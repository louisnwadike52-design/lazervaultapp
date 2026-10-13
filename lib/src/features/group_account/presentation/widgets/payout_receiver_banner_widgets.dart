part of 'payout_receiver_banner.dart';

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
  // When true, the SCHEDULED state collapses to SizedBox.shrink()
  // because the parent screen is rendering the same information as a
  // compact chip in the status row. All other states (pending,
  // ready, in_flight, settled, failed, exhausted) still surface as
  // full-width banners — those are exceptional / actionable and need
  // the headroom.
  final bool hideScheduled;

  /// Suppress the "set the payout receiver" state.
  ///
  /// Used while an esusu has not started, where the details screen offers
  /// Start and Set receiver as one compact pair instead. Two tall banners
  /// stacked above the tab bar pushed the tabs off the bottom of the screen,
  /// so the content behind them could not be reached at all.
  final bool hidePendingReceiver;

  const PayoutReceiverBanner({
    super.key,
    required this.contribution,
    this.cycleIndex = 0,
    required this.isAdmin,
    this.onStateChanged,
    this.hideScheduled = false,
    this.hidePendingReceiver = false,
  });

  @override
  State<PayoutReceiverBanner> createState() => PayoutReceiverBannerState();
}

/// Compact chip that surfaces ONLY the auto-payout SCHEDULED state.
///
/// Designed to share a horizontal row with the auto-debit and role
/// chips on contribution_details_screen. When the contribution is in
/// any other payout state (pending receiver, ready, in_flight, failed,
/// exhausted, settled), this widget collapses to SizedBox.shrink() —
/// those states need the full-width PayoutReceiverBanner because they
/// carry actionable CTAs (Set Receiver, Trigger Payout, Retry Now).
///
/// Tap opens [AutoPayoutScheduledDialog], which exposes a Change
/// Receiver action for admins.
///
/// Self-loads + polls the same gRPC endpoint as PayoutReceiverBanner.
/// The double-fetch is intentional: keeps the chip self-contained so
/// callers don't have to thread state, and the request is cheap (one
/// gRPC round-trip every ~30s while visible).
class AutoPayoutScheduledChip extends StatefulWidget {
  final Contribution contribution;
  final int cycleIndex;
  final bool isAdmin;
  // Called when an admin changes the receiver via the chip's dialog;
  // parent screens use this to refresh contribution details + the
  // sibling PayoutReceiverBanner so all three views (chip, banner,
  // tabs) reflect the new state without the user pulling-to-refresh.
  final VoidCallback? onReceiverChanged;

  /// Fired whenever the chip starts or stops rendering anything.
  ///
  /// The chip decides for itself — it collapses to nothing unless the payout
  /// is SCHEDULED — and a parent laying chips out in a row has no other way
  /// to know. Without this the parent reserved a slot for a zero-height chip
  /// and the chips after it were pushed onto a row of their own, which is
  /// what put the Role tile on a line of its own underneath the tab bar.
  final ValueChanged<bool>? onVisibilityChanged;

  const AutoPayoutScheduledChip({
    super.key,
    required this.contribution,
    this.cycleIndex = 0,
    required this.isAdmin,
    this.onReceiverChanged,
    this.onVisibilityChanged,
  });

  @override
  State<AutoPayoutScheduledChip> createState() =>
      _AutoPayoutScheduledChipState();
}

class _AutoPayoutScheduledChipState extends State<AutoPayoutScheduledChip> {
  pb.GetPayoutReceiverResponse? _state;
  Timer? _pollTimer;
  bool? _lastReportedVisible;

  /// Reported from build, so the answer is whatever was actually painted.
  /// Deferred to after the frame because a parent that rebuilds its layout in
  /// response cannot setState during this one.
  void _reportVisibility(bool visible) {
    if (_lastReportedVisible == visible) return;
    _lastReportedVisible = visible;
    final cb = widget.onVisibilityChanged;
    if (cb == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) cb(visible);
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
    // Light polling. The chip is informational, so a 30s tick is
    // plenty — it doesn't need the 3s cadence the banner uses for
    // in_flight states.
    _pollTimer = Timer.periodic(const Duration(seconds: 30), (_) => _load());
  }

  @override
  void didUpdateWidget(covariant AutoPayoutScheduledChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contribution.id != widget.contribution.id ||
        oldWidget.cycleIndex != widget.cycleIndex ||
        oldWidget.contribution.autoPayoutEnabled !=
            widget.contribution.autoPayoutEnabled) {
      _load();
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final svc = serviceLocator<PayoutAssignmentService>();
    try {
      final res = await svc.getReceiver(
        contributionId: widget.contribution.id,
        cycleIndex: widget.cycleIndex,
      );
      if (!mounted) return;
      setState(() => _state = res);
    } on GrpcError catch (e) {
      if (!mounted) return;
      if (e.code == StatusCode.notFound) {
        setState(() => _state = null);
      }
      // Other errors are silent — the chip just stays hidden until the
      // next poll succeeds. Failure-state UX lives on the banner.
    } catch (_) {
      // Silent.
    }
  }

  Future<void> _openChangeReceiver() async {
    final res = await SelectPayoutReceiverBottomSheet.show(
      context: context,
      contribution: widget.contribution,
      cycleIndex: widget.cycleIndex,
      currentReceiverUserId: _state?.receiver.recipientUserId.isNotEmpty == true
          ? _state!.receiver.recipientUserId
          : null,
    );
    if (res != null) {
      await _load();
      widget.onReceiverChanged?.call();
    }
  }

  void _openDialog() {
    final state = _state;
    if (state == null) return;
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => AutoPayoutScheduledDialog(
        state: state,
        contribution: widget.contribution,
        isAdmin: widget.isAdmin,
        onChangeReceiver: () {
          Navigator.of(context, rootNavigator: false).pop();
          _openChangeReceiver();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = _state;
    if (s == null) {
      _reportVisibility(false);
      return const SizedBox.shrink();
    }
    final status = s.scheduledPayout.status;
    final isScheduled = status ==
        pb_enum.ScheduledPayoutStatus.SCHEDULED_PAYOUT_STATUS_SCHEDULED;
    if (!isScheduled) {
      _reportVisibility(false);
      return const SizedBox.shrink();
    }
    _reportVisibility(true);

    // Violet-400: this chip only ever paints on #1F1F1F, where the brand
    // purple reads as a slightly-off grey. See GroupFundsPalette.
    const accent = GroupFundsPalette.onDark;
    return Material(
      color: const Color(0xFF1F1F1F),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: _openDialog,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(Icons.schedule, color: accent, size: 14.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Auto-payout',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Scheduled',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: accent,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[600], size: 16.sp),
            ],
          ),
        ),
      ),
    );
  }
}

/// Modal opened from [AutoPayoutScheduledChip]. Shows the recipient,
/// amount, and scheduled fire time, plus a "Change Receiver" CTA for
/// admins. Mirrors the visual style of the contribution-details
/// status dialogs so the surface feels consistent.
class AutoPayoutScheduledDialog extends StatelessWidget {
  final pb.GetPayoutReceiverResponse state;
  final Contribution contribution;
  final bool isAdmin;
  final VoidCallback onChangeReceiver;

  const AutoPayoutScheduledDialog({
    super.key,
    required this.state,
    required this.contribution,
    required this.isAdmin,
    required this.onChangeReceiver,
  });

  String _resolveRecipientName(String userId) {
    for (final mb in contribution.members) {
      if (mb.userId == userId) return mb.userName;
    }
    return '(unknown member)';
  }

  String _formatAmount(double v) => NumberFormat.decimalPattern().format(v);
  String _formatDate(DateTime dt) =>
      DateFormat('MMM d, y · h:mm a').format(dt.toLocal());

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF4E03D0);
    final recipient = _resolveRecipientName(state.receiver.recipientUserId);
    final amount = _formatAmount(contribution.currentAmount);
    final fireAt = state.scheduledPayout.hasScheduledFor()
        ? state.scheduledPayout.scheduledFor.toDateTime()
        : contribution.deadline;

    return Dialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420.w),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.schedule, color: accent, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Auto-payout scheduled',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon:
                        Icon(Icons.close, color: Colors.grey[400], size: 20.sp),
                    padding: EdgeInsets.zero,
                    constraints:
                        BoxConstraints(minWidth: 32.w, minHeight: 32.w),
                    tooltip: 'Close',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _kvRow(label: 'Recipient', value: recipient),
              SizedBox(height: 8.h),
              _kvRow(
                label: 'Amount',
                value: '$amount ${contribution.currency}',
              ),
              SizedBox(height: 8.h),
              _kvRow(label: 'Fires on', value: _formatDate(fireAt)),
              SizedBox(height: 14.h),
              Text(
                'When the contribution closes, the funds collected this cycle will be sent automatically to the recipient. You can change who receives the payout up until it fires.',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                  height: 1.5,
                ),
              ),
              if (isAdmin) ...[
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onChangeReceiver,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Change Receiver',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _kvRow({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88.w,
          child: Text(
            label,
            style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 12.sp),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
