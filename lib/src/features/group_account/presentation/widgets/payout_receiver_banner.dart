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

import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/support/data/support_api.dart';
import 'select_payout_receiver_bottom_sheet.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'payout_receiver_banner_widgets.dart';

class PayoutReceiverBannerState extends State<PayoutReceiverBanner> {
  pb.GetPayoutReceiverResponse? _state;
  bool _loading = true;
  bool _triggering = false;

  /// Admin-only reveal for the raw server error.
  bool _showRawError = false;
  bool _switchingManual = false;
  bool _raisingTicket = false;

  /// True when the pot can actually fund a payout.
  ///
  /// Mirrors the server's guard (processPayoutCore: current_amount <
  /// minimum_balance → ErrInsufficientFunds) so the UI doesn't offer an action
  /// the backend will refuse. minimumBalance null/0 still requires a non-empty
  /// pot — paying out zero is never meaningful.
  bool get _potCoversMinimum {
    final pot = widget.contribution.currentAmount;
    final min = widget.contribution.minimumBalance ?? 0;
    return pot > 0 && pot >= min;
  }

  /// Why the payout CTA is unavailable, in the user's terms.
  String get _payoutBlockedReason {
    final pot = widget.contribution.currentAmount;
    final min = widget.contribution.minimumBalance ?? 0;
    final ccy = widget.contribution.currency;
    if (pot <= 0) {
      return 'Nothing to pay out yet — no one has contributed to this goal.';
    }
    return 'Needs at least ${_formatAmount(min)} $ccy before a payout can run '
        '(currently ${_formatAmount(pot)} $ccy).';
  }

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
      if (status ==
          pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_IN_FLIGHT) {
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

  /// Take this payout off automation and re-arm it for a manual trigger.
  Future<void> _switchToManual() async {
    if (_switchingManual) return;
    setState(() => _switchingManual = true);
    try {
      await serviceLocator<PayoutAssignmentService>().switchPayoutToManual(
        contributionId: widget.contribution.id,
        cycleIndex: widget.cycleIndex,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "You're in control of this payout now — run it when you're ready."),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );
      await _load();
      widget.onStateChanged?.call();
    } on GrpcError catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // FailedPrecondition carries a real reason (already settled, etc.);
          // anything else is not worth quoting verbatim at a user.
          content: Text(e.code == StatusCode.failedPrecondition
              ? (e.message ?? "Couldn't switch this payout to manual.")
              : "Couldn't switch this payout to manual."),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Couldn't switch this payout to manual."),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _switchingManual = false);
    }
  }

  /// Open a support ticket that already contains what an admin needs.
  ///
  /// The old banner sent people to support with nothing — they would describe
  /// "my payout failed" and an agent would spend the first three replies
  /// establishing which payout, in which cycle, failing how. Every one of
  /// those facts is on screen here, so the ticket carries them: the payout id
  /// is what the admin console's Scheduled Payouts tab searches on.
  Future<void> _openPrefilledTicket() async {
    if (_raisingTicket) return;
    final p = _state?.scheduledPayout;
    if (p == null) return;
    setState(() => _raisingTicket = true);
    try {
      // Constructed the same way the support screens do — SupportApi is not
      // registered in the locator, and asking for it there throws at runtime.
      final api = SupportApi(serviceLocator<SecureStorageService>());
      final subject =
          'Group funds payout stuck — ${widget.contribution.title} (payout ${_shortId(p.id)})';
      final body = StringBuffer()
        ..writeln('A group-funds payout could not complete automatically.')
        ..writeln()
        ..writeln('Payout ID: ${p.id}')
        ..writeln(
            'Contribution: ${widget.contribution.title} (${widget.contribution.id})')
        ..writeln('Cycle: ${widget.cycleIndex}')
        ..writeln('Amount: ${widget.contribution.currency} '
            '${(p.amountMinor.toInt() / 100).toStringAsFixed(2)}')
        ..writeln(
            'Recipient: ${p.recipientName.isEmpty ? p.recipientUserId : p.recipientName}')
        ..writeln('Attempts: ${p.attempts}')
        ..writeln('Failure code: ${p.failureCode}')
        ..writeln('Reported error: ${p.lastError}');
      final ticket = await api.createTicket(
        subject: subject,
        message: body.toString(),
        category: 'payments',
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Ticket ${_shortId(ticket.id)} opened with the payout details.'),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on SupportTicketLimitException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Couldn't open a ticket. Please try again."),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _raisingTicket = false);
    }
  }

  static String _shortId(String id) => id.length <= 8 ? id : id.substring(0, 8);

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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
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
    // The members list is statically typed as List<ContributionMember>
    // but at runtime can be reified as List<ContributionMemberModel>
    // (the data-layer subclass). Dart's strict subtype check then
    // rejects an orElse: () => ContributionMember(...) lambda because
    // it returns the parent type. Using a manual walk + null fallback
    // sidesteps the issue without forcing a cast.
    for (final mb in widget.contribution.members) {
      if (mb.userId == userId) return mb.userName;
    }
    return '(unknown member)';
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
          LazerVaultLoader.tiny(),
          SizedBox(width: 12.w),
          Text('Loading payout status…',
              style:
                  GoogleFonts.inter(color: Colors.grey[400], fontSize: 12.sp)),
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
                style: GoogleFonts.inter(
                    color: Colors.grey[300], fontSize: 12.sp)),
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
        status !=
            pb_enum.ScheduledPayoutStatus
                .SCHEDULED_PAYOUT_STATUS_PENDING_RECEIVER &&
        status !=
            pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_CANCELED) {
      return widget.isAdmin
          ? _pendingReceiverBanner(hasRow: true)
          : _readOnlyPendingBanner();
    }

    switch (status) {
      case pb_enum
            .ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_PENDING_RECEIVER:
        return widget.isAdmin
            ? _pendingReceiverBanner(hasRow: true)
            : _readOnlyPendingBanner();
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_READY:
        return _readyBanner(state);
      case pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_SCHEDULED:
        if (widget.hideScheduled) return const SizedBox.shrink();
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
                ? 'The contribution closed on ${_formatDate(deadline)} but no receiver is set. Pick the member who should receive the payout. Once set, payout fires either automatically or via a manual trigger.'
                : 'Pick the member who will receive the payout when this closes on ${_formatDate(deadline)}. Whoever is set here gets paid by auto-payout or by a manual trigger from an admin.',
            style: GoogleFonts.inter(color: Colors.grey[300], fontSize: 12.sp),
          ),
          SizedBox(height: 10.h),
          _filledCta(
              label: 'Set Receiver',
              onPressed: _openReceiverPicker,
              color: color),
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
            // The pot must clear the contribution's minimum balance before a
            // payout can succeed. Offering the CTA regardless meant tapping it
            // on an empty pot returned a bare "insufficient funds", and the
            // scheduler then retried it every 30s until it exhausted — which
            // is how one unfunded goal produced 19 push notifications. Say why
            // it's unavailable instead of failing after the tap.
            if (!_potCoversMinimum) ...[
              SizedBox(height: 10.h),
              Text(
                _payoutBlockedReason,
                style: GoogleFonts.inter(
                    color: const Color(0xFFF59E0B), fontSize: 12.sp),
              ),
            ],
            SizedBox(height: 10.h),
            Row(children: [
              Expanded(
                child: _filledCta(
                  label: _triggering ? 'Triggering…' : 'Trigger Payout',
                  onPressed: (_triggering || !_potCoversMinimum)
                      ? null
                      : _triggerManualPayout,
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
            Icon(Icons.schedule, color: const Color(0xFF4E03D0), size: 18.sp),
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
            _outlineCta(
                label: 'Change Receiver', onPressed: _openReceiverPicker),
          ],
        ],
      ),
      accent: const Color(0xFF4E03D0),
    );
  }

  Widget _inFlightBanner(pb.GetPayoutReceiverResponse state) {
    final recipient = _resolveRecipientName(state.receiver.recipientUserId);
    return _shell(
      Row(children: [
        LazerVaultLoader(size: 18),
        SizedBox(width: 12.w),
        Expanded(
          child: Text('Sending payout to $recipient…',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
        ),
      ]),
      accent: const Color(0xFF4E03D0),
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
        Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 18.sp),
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

  /// True when the payout is blocked by WHERE it is going, not by a passing
  /// condition. group-accounts classifies this server-side
  /// (pkg/payoutfailure/classify.go) and both banners must read the same
  /// answer: firing again at a closed, frozen or missing account produces the
  /// identical rejection, so "we'll retry" would be a promise we cannot keep.
  static bool _receiverBlocked(String code) =>
      code == 'RECIPIENT_ACCOUNT_INACTIVE' ||
      code == 'RECIPIENT_ACCOUNT_FROZEN' ||
      code == 'RECIPIENT_KYC_INSUFFICIENT' ||
      code == 'NO_RECEIVER' ||
      code == 'RECEIVER_ACCOUNT_MISSING';

  /// A payout that failed but still has automatic attempts left.
  ///
  /// This used to show the RAW server error and always promise a retry:
  ///
  ///   Payout failed. Will retry
  ///   failed to credit recipient account: credit rejected: ACCOUNT_INACTIVE
  ///   - account is not active (status: closed)
  ///
  /// Two things were wrong with that. The text is an internal message with an
  /// error code in it, shown to an ordinary member. And for a closed account
  /// the promise is false: every remaining attempt rejects identically, so
  /// "Retry Now" was the loudest button on a screen where it could not work.
  ///
  /// group-accounts already classifies the cause and sends a written hint, the
  /// same fields the exhausted banner uses; this now reads them too.
  Widget _failedBanner(pb.GetPayoutReceiverResponse state) {
    final p = state.scheduledPayout;
    final blocked = _receiverBlocked(p.failureCode);
    final hint = p.failureHint.isNotEmpty
        ? p.failureHint
        : 'We could not complete this payout. We will try again shortly.';

    // Amber, not red, when the fix is in the user's hands: red plus "failed"
    // reads as money lost, and the money is still in the pot.
    final accent = blocked ? const Color(0xFFFB923C) : const Color(0xFFEF4444);

    return _shell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(blocked ? Icons.warning_amber_rounded : Icons.error_outline,
                color: accent, size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                  blocked
                      ? 'Payout needs a change'
                      : 'Payout failed. We will retry',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ]),
          SizedBox(height: 6.h),
          Text(hint,
              style: GoogleFonts.inter(
                  color: Colors.grey[300], fontSize: 12.sp, height: 1.4)),
          if (widget.isAdmin) ...[
            SizedBox(height: 10.h),
            // Lead with the action that can actually succeed. A blocked
            // destination is fixed by changing it; a passing condition is
            // fixed by trying again.
            Row(children: [
              if (blocked) ...[
                Expanded(
                  child: _filledCta(
                    label: 'Change receiver',
                    onPressed: _openReceiverPicker,
                    color: const Color(0xFF9B6DFF),
                  ),
                ),
                SizedBox(width: 8.w),
                _outlineCta(
                  label: _triggering ? 'Retrying…' : 'Try again',
                  onPressed: _triggering ? null : _triggerManualPayout,
                ),
              ] else ...[
                Expanded(
                  child: _filledCta(
                    label: _triggering ? 'Retrying…' : 'Retry Now',
                    onPressed: _triggering ? null : _triggerManualPayout,
                    color: const Color(0xFFEF4444),
                  ),
                ),
                SizedBox(width: 8.w),
                _outlineCta(label: 'Change', onPressed: _openReceiverPicker),
              ],
            ]),
            // The raw message still matters to whoever has to debug it, so it
            // stays reachable — behind a tap, for admins, instead of being the
            // first thing every member reads.
            if (p.lastError.isNotEmpty) ...[
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => setState(() => _showRawError = !_showRawError),
                child: Text(
                  _showRawError
                      ? 'Hide technical details'
                      : 'Technical details',
                  style: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              if (_showRawError) ...[
                SizedBox(height: 6.h),
                SelectableText(
                  p.lastError,
                  style: GoogleFonts.robotoMono(
                      color: Colors.grey[500], fontSize: 10.5.sp, height: 1.35),
                ),
              ],
            ],
          ],
        ],
      ),
      accent: accent,
    );
  }

  /// The payout ran out of automatic retries.
  ///
  /// This used to say "Contact support to investigate" and offer nothing —
  /// a dead end in front of money the group can see but cannot move. In
  /// production the blocking reason was usually something the creator could
  /// fix in seconds (the receiver's account was inactive), and support was
  /// the only door.
  ///
  /// Now the server classifies the failure (see payout_failure_classifier.go)
  /// and the banner offers the action that actually resolves THAT cause.
  /// Support is the last resort, reached only when the fault is genuinely
  /// ours — and it opens a ticket already carrying the identifiers an admin
  /// needs, instead of asking the user to describe a payout they can't see
  /// the internals of.
  Widget _exhaustedBanner(pb.GetPayoutReceiverResponse state) {
    final p = state.scheduledPayout;
    final code = p.failureCode;
    final hint = p.failureHint.isNotEmpty
        ? p.failureHint
        : 'Automatic retries stopped after ${p.attempts} attempts.';
    final isPlatform = !p.failureRecoverable;

    // Which action actually clears THIS cause. A blocked destination account
    // is not fixed by firing again, so "Change receiver" leads there; a pot
    // still filling is, so manual control leads there.
    final receiverBlocked = _receiverBlocked(code);

    return _shell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(isPlatform ? Icons.error_outline : Icons.warning_amber,
                color: const Color(0xFFFB923C), size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                  isPlatform
                      ? 'Payout needs our help'
                      : 'Payout needs a change',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ]),
          SizedBox(height: 6.h),
          Text(hint,
              style:
                  GoogleFonts.inter(color: Colors.grey[300], fontSize: 12.sp)),
          SizedBox(height: 10.h),
          if (isPlatform)
            Row(children: [
              Expanded(
                child: _filledCta(
                  label: _raisingTicket ? 'Opening…' : 'Contact support',
                  onPressed: _raisingTicket ? null : _openPrefilledTicket,
                  color: const Color(0xFFFB923C),
                ),
              ),
            ])
          else ...[
            Row(children: [
              if (receiverBlocked)
                Expanded(
                  child: _filledCta(
                    label: 'Change receiver',
                    onPressed: _openReceiverPicker,
                    color: const Color(0xFF9B6DFF),
                  ),
                )
              else
                Expanded(
                  child: _filledCta(
                    label:
                        _switchingManual ? 'Switching…' : 'Take manual control',
                    onPressed: _switchingManual ? null : _switchToManual,
                    color: const Color(0xFF9B6DFF),
                  ),
                ),
              SizedBox(width: 8.w),
              _outlineCta(
                label: _triggering ? 'Retrying…' : 'Try again',
                onPressed: _triggering ? null : _triggerManualPayout,
              ),
            ]),
            if (receiverBlocked) ...[
              SizedBox(height: 8.h),
              // Still offered, because the creator may have just fixed the
              // account and wants control rather than another automatic cycle.
              GestureDetector(
                onTap: _switchingManual ? null : _switchToManual,
                child: Text(
                  _switchingManual
                      ? 'Switching to manual…'
                      : 'Or take manual control of this payout',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9B6DFF),
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Text(label,
          style:
              GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600)),
    );
  }
}
