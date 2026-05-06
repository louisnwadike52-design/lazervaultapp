// payout_receiver_banner.dart
//
// Status-aware banner shown on contribution_details_screen. Reads
// the receiver + scheduled-payout state from GetPayoutReceiver and
// renders one of seven UX flavors:
//
//   pending_receiver  → "Set who receives funds before {deadline}"
//                       + Set Receiver CTA. Only visible to admins.
//   ready             → "{recipient} will receive {amount} when triggered"
//                       + Trigger Payout CTA (manual mode only).
//   scheduled         → "{recipient} will be paid {amount} on {date}"
//                       (no CTA — auto fires).
//   in_flight         → "Payout in progress to {recipient}…"
//                       (spinner, no CTA).
//   settled           → "Paid {amount} to {recipient} on {date}"
//                       Green check.
//   failed            → "Payout failed: {error}. Will retry."
//                       + Retry Now CTA (admin only).
//   exhausted         → "Payout exhausted after N attempts. Needs review."
//                       + Contact Support CTA.
//
// Reload strategy: caller passes a `key` based on the contribution id;
// banner self-loads on initState and refreshes when SetReceiver /
// TriggerManual / ClearReceiver complete (parent calls .reload()).

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grpc/grpc.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/group_account/data/services/payout_assignment_service.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';
import 'package:lazervault/src/generated/group_account.pb.dart' as pb;
import 'package:lazervault/src/generated/group_account.pbenum.dart' as pb_enum;

import 'select_payout_receiver_bottom_sheet.dart';

class PayoutReceiverBanner extends StatefulWidget {
  final Contribution contribution;
  final int cycleIndex;
  // Whether the current user can act on the banner (admin-only CTAs).
  // The widget still renders read-only state for everyone.
  final bool isAdmin;
  // Optional. Called whenever the banner observes a state change that
  // would also affect the parent (e.g. a settled payout creates a new
  // payout_transaction + zeros current_amount on the contribution).
  // The parent reloads contribution details to keep its Payments /
  // Overview tabs aligned with the receiver flow's outcome.
  final VoidCallback? onStateChanged;

  const PayoutReceiverBanner({
    super.key,
    required this.contribution,
    this.cycleIndex = 0,
    required this.isAdmin,
    this.onStateChanged,
  });

  @override
  State<PayoutReceiverBanner> createState() => PayoutReceiverBannerState();
}

class PayoutReceiverBannerState extends State<PayoutReceiverBanner> {
  pb.GetPayoutReceiverResponse? _state;
  bool _loading = true;
  bool _triggering = false;
  String? _error;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant PayoutReceiverBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload when the parent passes a fresh contribution (different
    // id, cycle index, or auto/manual mode). Without this, an admin
    // who flips auto_payout_enabled in the Edit screen would see the
    // banner stuck on the old SCHEDULED copy until they navigate
    // away — the receiver row server-side already transitioned to
    // READY (because EnsurePayout fires from the lifecycle hook),
    // but the banner's cached _state still says SCHEDULED. Re-fetch
    // when any of the relevant props move.
    final old = oldWidget.contribution;
    final now = widget.contribution;
    final cycleChanged = oldWidget.cycleIndex != widget.cycleIndex;
    final modeChanged = old.autoPayoutEnabled != now.autoPayoutEnabled;
    final idChanged = old.id != now.id;
    final amountChanged = old.currentAmount != now.currentAmount;
    if (cycleChanged || modeChanged || idChanged || amountChanged) {
      _load();
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = _state == null;
      _error = null;
    });
    final svc = serviceLocator<PayoutAssignmentService>();
    try {
      final res = await svc.getReceiver(
        contributionId: widget.contribution.id,
        cycleIndex: widget.cycleIndex,
      );
      if (!mounted) return;
      setState(() {
        _state = res;
        _loading = false;
      });
      // Auto-poll while a payout is mid-flight so the UI converges
      // without the user pulling-to-refresh. Stops itself once the
      // status leaves in_flight.
      final status = res.scheduledPayout.status;
      if (status == pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_IN_FLIGHT) {
        _pollTimer?.cancel();
        _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) => _load());
      } else {
        _pollTimer?.cancel();
        _pollTimer = null;
      }
    } on GrpcError catch (e) {
      if (!mounted) return;
      // NOT_FOUND while the scheduler is still bootstrapping — treat
      // as "no row yet" and render nothing.
      if (e.code == StatusCode.notFound) {
        setState(() {
          _state = null;
          _loading = false;
        });
        return;
      }
      setState(() {
        _error = 'Could not load payout state.';
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load payout state.';
        _loading = false;
      });
    }
  }

  /// Public reload hook — parent screens call this after admin actions
  /// (e.g. closing the receiver picker) so the banner reflects the
  /// new state without polling.
  Future<void> reload() => _load();

  Future<void> _openReceiverPicker() async {
    final res = await SelectPayoutReceiverBottomSheet.show(
      context: context,
      contribution: widget.contribution,
      cycleIndex: widget.cycleIndex,
      currentReceiverUserId: _state?.receiver.recipientUserId.isNotEmpty == true
          ? _state!.receiver.recipientUserId
          : null,
    );
    if (res != null && mounted) {
      // Server returned the freshly-transitioned scheduled-payout row;
      // we still re-fetch via getReceiver to pick up the receiver row
      // in the same shape this banner expects.
      await _load();
      widget.onStateChanged?.call();
    }
  }

  Future<void> _triggerManualPayout() async {
    if (_triggering) return;
    final confirmed = await _confirmManualTrigger();
    if (confirmed != true) return;
    setState(() => _triggering = true);
    final svc = serviceLocator<PayoutAssignmentService>();
    try {
      await svc.triggerManualPayout(
        contributionId: widget.contribution.id,
        cycleIndex: widget.cycleIndex,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Payout triggered'),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );
      await _load();
      // Settled (or in_flight) → the contribution row's
      // current_amount + payout_history just changed. Tell the parent
      // so its Overview / Payments tabs refresh.
      widget.onStateChanged?.call();
    } on GrpcError catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_humanizeTriggerError(e)),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Could not trigger payout.'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _triggering = false);
    }
  }

  Future<bool?> _confirmManualTrigger() {
    final amount = _formatAmount(widget.contribution.currentAmount);
    final recipient = _state?.receiver.recipientUserId.isNotEmpty == true
        ? _resolveRecipientName(_state!.receiver.recipientUserId)
        : 'the assigned receiver';
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text('Trigger payout?',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600)),
        content: Text(
          'This will send $amount ${widget.contribution.currency} to $recipient. The credit is final once the saga completes.',
          style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 13.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: Colors.grey[400])),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: const Text('Trigger Payout'),
          ),
        ],
      ),
    );
  }

  String _humanizeTriggerError(GrpcError e) {
    switch (e.code) {
      case StatusCode.permissionDenied:
        return 'Only group admins can trigger payouts.';
      case StatusCode.failedPrecondition:
        return e.message ?? 'Payout is not ready to fire.';
      case StatusCode.notFound:
        return 'No scheduled payout for this contribution.';
      case StatusCode.aborted:
        return 'Payout state changed; refresh and retry.';
      default:
        return 'Could not trigger payout.';
    }
  }

  String _resolveRecipientName(String userId) {
    final m = widget.contribution.members.firstWhere(
      (mb) => mb.userId == userId,
      orElse: () => ContributionMember(
        id: '',
        contributionId: widget.contribution.id,
        userId: userId,
        userName: '(unknown member)',
        email: '',
        joinedAt: DateTime.now(),
      ),
    );
    return m.userName;
  }

  String _formatAmount(num value) {
    // Accepts double (from the entity) or int (from the proto). The
    // entity stores major-unit doubles for now, so we just thousands-
    // format. When the entity migrates to int minor units this will
    // need divisor + decimals — gated to one place.
    return NumberFormat.decimalPattern().format(value);
  }

  String _formatDate(DateTime dt) {
    return DateFormat('MMM d, y · h:mm a').format(dt.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _shell(
        Row(children: [
          SizedBox(
            width: 16.w,
            height: 16.w,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12.w),
          Text('Loading payout status…',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 12.sp)),
        ]),
        accent: const Color(0xFF2D2D2D),
      );
    }
    if (_error != null) {
      return _shell(
        Row(children: [
          Icon(Icons.error_outline,
              color: const Color(0xFFEF4444), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(_error!,
                style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 12.sp)),
          ),
          TextButton(onPressed: _load, child: const Text('Retry')),
        ]),
        accent: const Color(0xFFEF4444),
      );
    }
    final state = _state;
    if (state == null) {
      // No row yet. The widget always surfaces the receiver state — the
      // user explicitly asked for the banner to show whether autopayout
      // is on or off, since the receiver matters in BOTH paths (auto
      // fires when scheduled, manual fires when an admin triggers it).
      // Admins see the actionable Set Receiver CTA; non-admins see a
      // read-only "Waiting for receiver" so they know payout is gated
      // on someone setting one.
      return widget.isAdmin
          ? _pendingReceiverBanner(hasRow: false)
          : _readOnlyPendingBanner();
    }

    final status = state.scheduledPayout.status;
    final hasReceiver = state.receiver.recipientUserId.isNotEmpty;

    // Defensive routing: if the row's status implies a receiver is set
    // but the receiver is actually empty (race between SetReceiver and
    // ClearReceiver, or backend backfill that hasn't completed), fall
    // back to the pending-receiver banner. Better to ask the admin to
    // set a receiver than to render "Ready to pay (unknown member)".
    if (!hasReceiver &&
        status != pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_PENDING_RECEIVER &&
        status != pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_CANCELED) {
      return widget.isAdmin
          ? _pendingReceiverBanner(hasRow: true)
          : _readOnlyPendingBanner();
    }

    switch (status) {
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_PENDING_RECEIVER:
        return widget.isAdmin
            ? _pendingReceiverBanner(hasRow: true)
            : _readOnlyPendingBanner();
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_READY:
        return _readyBanner(state);
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_SCHEDULED:
        return _scheduledBanner(state);
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_IN_FLIGHT:
        return _inFlightBanner(state);
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_SETTLED:
        return _settledBanner(state);
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_FAILED:
        return _failedBanner(state);
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_EXHAUSTED:
        return _exhaustedBanner(state);
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_CANCELED:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }

  // ---------- Banner variants ----------

  Widget _pendingReceiverBanner({required bool hasRow}) {
    final deadline = widget.contribution.deadline;
    final pastDeadline = deadline.isBefore(DateTime.now());
    final color =
        pastDeadline ? const Color(0xFFEF4444) : const Color(0xFFFB923C);
    return _shell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(pastDeadline ? Icons.warning_amber : Icons.person_add_alt_1,
                color: color, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              pastDeadline ? 'Receiver overdue' : 'Set the payout receiver',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600),
            ),
          ]),
          SizedBox(height: 6.h),
          Text(
            pastDeadline
                ? 'The contribution closed on ${_formatDate(deadline)} but no receiver is set. Pick the member who should receive the payout — once set, payout fires either automatically or via a manual trigger.'
                : 'Pick the member who will receive the payout when this closes on ${_formatDate(deadline)}. Whoever is set here gets paid by auto-payout or by a manual trigger from an admin.',
            style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 12.sp),
          ),
          SizedBox(height: 10.h),
          _filledCta(
              label: 'Set Receiver', onPressed: _openReceiverPicker, color: color),
        ],
      ),
      accent: color,
    );
  }

  Widget _readOnlyPendingBanner() {
    return _shell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.hourglass_empty, color: Colors.grey[400], size: 18.sp),
            SizedBox(width: 8.w),
            Text('Payout receiver not set',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ]),
          SizedBox(height: 6.h),
          Text(
            'Waiting for an admin to assign the member who will receive the payout. Once set, payout fires either automatically or via a manual trigger.',
            style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 12.sp),
          ),
        ],
      ),
      accent: const Color(0xFF2D2D2D),
    );
  }

  Widget _readyBanner(pb.GetPayoutReceiverResponse state) {
    final recipient = _resolveRecipientName(state.receiver.recipientUserId);
    final amount = _formatAmount(widget.contribution.currentAmount);
    return _shell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.payments, color: const Color(0xFF3B82F6), size: 18.sp),
            SizedBox(width: 8.w),
            Text('Ready to pay $recipient',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ]),
          SizedBox(height: 6.h),
          Text(
            '$amount ${widget.contribution.currency} will be sent to their wallet when you trigger the payout.',
            style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 12.sp),
          ),
          if (widget.isAdmin) ...[
            SizedBox(height: 10.h),
            Row(children: [
              Expanded(
                child: _filledCta(
                  label: _triggering ? 'Triggering…' : 'Trigger Payout',
                  onPressed: _triggering ? null : _triggerManualPayout,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
              SizedBox(width: 8.w),
              _outlineCta(label: 'Change', onPressed: _openReceiverPicker),
            ]),
          ],
        ],
      ),
      accent: const Color(0xFF3B82F6),
    );
  }

  Widget _scheduledBanner(pb.GetPayoutReceiverResponse state) {
    final recipient = _resolveRecipientName(state.receiver.recipientUserId);
    final amount = _formatAmount(widget.contribution.currentAmount);
    final fireAt = state.scheduledPayout.hasScheduledFor()
        ? state.scheduledPayout.scheduledFor.toDateTime()
        : widget.contribution.deadline;
    return _shell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.schedule,
                color: const Color(0xFF6366F1), size: 18.sp),
            SizedBox(width: 8.w),
            Text('Auto-payout scheduled',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ]),
          SizedBox(height: 6.h),
          Text(
            '$amount ${widget.contribution.currency} → $recipient on ${_formatDate(fireAt)}.',
            style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 12.sp),
          ),
          if (widget.isAdmin) ...[
            SizedBox(height: 10.h),
            _outlineCta(label: 'Change Receiver', onPressed: _openReceiverPicker),
          ],
        ],
      ),
      accent: const Color(0xFF6366F1),
    );
  }

  Widget _inFlightBanner(pb.GetPayoutReceiverResponse state) {
    final recipient = _resolveRecipientName(state.receiver.recipientUserId);
    return _shell(
      Row(children: [
        SizedBox(
          width: 18.w,
          height: 18.w,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text('Sending payout to $recipient…',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
        ),
      ]),
      accent: const Color(0xFF6366F1),
    );
  }

  Widget _settledBanner(pb.GetPayoutReceiverResponse state) {
    final recipient = _resolveRecipientName(state.receiver.recipientUserId);
    final amount = _formatAmount(widget.contribution.currentAmount);
    final settledAt = state.scheduledPayout.hasSettledAt()
        ? state.scheduledPayout.settledAt.toDateTime()
        : null;
    return _shell(
      Row(children: [
        Icon(Icons.check_circle,
            color: const Color(0xFF10B981), size: 18.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Paid $amount ${widget.contribution.currency} to $recipient',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)),
              if (settledAt != null) ...[
                SizedBox(height: 2.h),
                Text(_formatDate(settledAt),
                    style: GoogleFonts.inter(
                        color: Colors.grey[400], fontSize: 11.sp)),
              ],
            ],
          ),
        ),
      ]),
      accent: const Color(0xFF10B981),
    );
  }

  Widget _failedBanner(pb.GetPayoutReceiverResponse state) {
    final last = state.scheduledPayout.lastError.isNotEmpty
        ? state.scheduledPayout.lastError
        : 'Provider returned an error.';
    return _shell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.error_outline,
                color: const Color(0xFFEF4444), size: 18.sp),
            SizedBox(width: 8.w),
            Text('Payout failed — will retry',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ]),
          SizedBox(height: 6.h),
          Text(last,
              style: GoogleFonts.inter(
                  color: Colors.grey[300], fontSize: 12.sp)),
          if (widget.isAdmin) ...[
            SizedBox(height: 10.h),
            _filledCta(
              label: _triggering ? 'Retrying…' : 'Retry Now',
              onPressed: _triggering ? null : _triggerManualPayout,
              color: const Color(0xFFEF4444),
            ),
          ],
        ],
      ),
      accent: const Color(0xFFEF4444),
    );
  }

  Widget _exhaustedBanner(pb.GetPayoutReceiverResponse state) {
    return _shell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.warning_amber,
                color: const Color(0xFFFB923C), size: 18.sp),
            SizedBox(width: 8.w),
            Text('Payout needs review',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ]),
          SizedBox(height: 6.h),
          Text(
            'Automatic retries gave up after ${state.scheduledPayout.attempts} attempts. Contact support to investigate.',
            style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 12.sp),
          ),
        ],
      ),
      accent: const Color(0xFFFB923C),
    );
  }

  // ---------- Shell + CTAs ----------

  Widget _shell(Widget child, {required Color accent}) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: child,
    );
  }

  Widget _filledCta(
      {required String label, VoidCallback? onPressed, required Color color}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[700],
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child: Text(label,
            style: GoogleFonts.inter(
                fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _outlineCta({required String label, VoidCallback? onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey[600]!),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Text(label,
          style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600)),
    );
  }
}
