import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/pending_actions/domain/pending_action.dart';

const _kAccent = Color(0xFF9B6DFF);
const _kDeep = Color(0xFF4E03D0);
const _kInk = Color(0xFF111827);
const _kMuted = Color(0xFF6B7280);
const _kFaint = Color(0xFF9CA3AF);
const _kHairline = Color(0xFFEEF0F4);

/// The launch-time "waiting on you" sheet.
///
/// Every row is a one-tap route into the real flow: this sheet never moves
/// money itself, it only shortens the path to the screen that does.
///
/// Grouped by category because the two halves are not the same kind of thing —
/// a bill you owe and a friend request should not sit in one undifferentiated
/// list under a single verb. Payments offer "Pay", requests offer "Review".
class PendingPaymentsPromptSheet extends StatelessWidget {
  const PendingPaymentsPromptSheet({
    required this.actions,
    required this.onPay,
    required this.onLater,
    this.onNeverShowAgain,
    super.key,
  });

  final List<PendingAction> actions;
  final void Function(PendingAction action) onPay;
  final VoidCallback onLater;

  /// Supplied only once the user has seen the sheet enough times to know what
  /// they would be switching off. Null hides the control entirely — see
  /// `PendingPaymentsPromptGate.optOutAfterShows`.
  final VoidCallback? onNeverShowAgain;

  /// How many rows are listed before the sheet points at the service instead.
  /// This is a nudge, not a second inbox.
  static const int _maxVisible = 6;

  @override
  Widget build(BuildContext context) {
    final visible = actions.take(_maxVisible).toList();
    final hidden = actions.length - visible.length;

    final payments = visible
        .where((a) => a.category == PendingActionCategory.payment)
        .toList();
    final requests = visible
        .where((a) => a.category == PendingActionCategory.request)
        .toList();

    // The white surface must extend to the physical bottom edge, with the safe
    // area applied INSIDE it. Wrapping the container in a SafeArea instead
    // leaves the home-indicator inset transparent, which renders as a grey band
    // under the sheet — it reads as the sheet failing to reach the bottom.
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      // Never taller than 80% of the screen: the sheet is a prompt, and one
      // that covers everything is a screen the user did not ask to open.
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            _grabber(),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _header(),
            ),
            SizedBox(height: 14.h),
            // Flexible + shrinkWrap: short lists size to content (no dead
            // space), long ones scroll inside the sheet rather than pushing
            // the actions off-screen.
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  if (payments.isNotEmpty) ...[
                    _sectionLabel('To pay', payments.length),
                    ...payments.map(_row),
                  ],
                  if (requests.isNotEmpty) ...[
                    if (payments.isNotEmpty) SizedBox(height: 14.h),
                    _sectionLabel('Waiting on you', requests.length),
                    ...requests.map(_row),
                  ],
                  if (hidden > 0) _moreLine(hidden),
                ],
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _grabber() => Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(2.r),
        ),
      );

  Widget _header() {
    final payments = actions
        .where((a) => a.category == PendingActionCategory.payment)
        .length;
    final requests = actions.length - payments;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: _kDeep.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.schedule_rounded, color: _kAccent, size: 18.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _headline(payments, requests),
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                payments > 0
                    ? 'Settle now, or come back any time from the service.'
                    : 'Review now, or come back any time.',
                style: GoogleFonts.inter(
                  fontSize: 11.5.sp,
                  height: 1.35,
                  color: _kMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Names both halves so the sheet never announces the wrong kind of thing —
  /// a lone friend request described as a "payment" is simply wrong.
  String _headline(int payments, int requests) {
    String plural(int n, String w) => '$n $w${n == 1 ? '' : 's'}';
    if (payments > 0 && requests > 0) {
      return '${plural(payments, 'payment')} and ${plural(requests, 'request')} waiting';
    }
    if (payments > 0) {
      return payments == 1
          ? 'You have a payment waiting'
          : 'You have $payments payments waiting';
    }
    return requests == 1
        ? 'Someone is waiting on you'
        : '$requests people are waiting on you';
  }

  Widget _sectionLabel(String text, int count) => Padding(
        padding: EdgeInsets.only(bottom: 8.h, left: 2.w),
        child: Row(
          children: [
            Text(
              text.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: _kFaint,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              '$count',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: _kFaint,
              ),
            ),
          ],
        ),
      );

  Widget _row(PendingAction action) =>
      _PendingRow(action: action, onTap: () => onPay(action));

  Widget _moreLine(int hidden) => Padding(
        padding: EdgeInsets.only(top: 10.h, left: 2.w),
        child: Text(
          '+$hidden more — open the service to see the rest',
          style: GoogleFonts.inter(fontSize: 11.5.sp, color: _kMuted),
        ),
      );

  Widget _footer() => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 6.h),
        child: Column(
          children: [
            Divider(height: 1, color: _kHairline),
            SizedBox(height: 6.h),
            TextButton(
              onPressed: onLater,
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 44.h),
              ),
              child: Text(
                'Not now',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: _kMuted,
                ),
              ),
            ),
            // Only offered once the user has seen this enough times to know
            // what it is. Understated on purpose: it is a real choice, not one
            // to trip over while reaching for "Not now".
            if (onNeverShowAgain != null)
              TextButton(
                onPressed: onNeverShowAgain,
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 34.h),
                ),
                child: Text(
                  "Don't show this again",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: _kFaint,
                  ),
                ),
              ),
          ],
        ),
      );
}

/// One compact row. Two lines instead of three, so six fit where four did.
class _PendingRow extends StatelessWidget {
  const _PendingRow({required this.action, required this.onTap});

  final PendingAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final amount = action.formattedAmount;
    final deadline = action.deadlineLabel;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: _kDeep.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child: Icon(_icon, size: 15.sp, color: _kAccent),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        action.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: _kInk,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      // Source, detail and deadline on ONE line. Three stacked
                      // lines per row is what made four items fill the screen.
                      Text(
                        [
                          action.source.label,
                          if (action.subtitle != null &&
                              action.subtitle!.isNotEmpty)
                            action.subtitle,
                          if (deadline != null) deadline,
                        ].whereType<String>().join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: _kMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Requests carry no amount; rendering a placeholder would
                    // put a money figure on a friend request.
                    if (amount != null)
                      Text(
                        amount,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: _kInk,
                        ),
                      ),
                    SizedBox(height: amount != null ? 2.h : 0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          action.actionLabel,
                          style: GoogleFonts.inter(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w700,
                            color: _kAccent,
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 14.sp, color: _kAccent),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData get _icon => switch (action.source) {
        PendingActionSource.tagPay => Icons.tag,
        PendingActionSource.invoice => Icons.receipt_long,
        PendingActionSource.splitBill => Icons.call_split_rounded,
        PendingActionSource.familyInvite => Icons.family_restroom_rounded,
        PendingActionSource.groupInvite => Icons.groups_2_outlined,
        PendingActionSource.connectionRequest => Icons.person_add_alt_1_rounded,
      };
}
