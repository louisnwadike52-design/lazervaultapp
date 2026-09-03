import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/pending_actions/domain/pending_action.dart';

const _kAccent = Color(0xFF9B6DFF);
const _kDeep = Color(0xFF4E03D0);

/// The launch-time "payments waiting" sheet.
///
/// Shows at most [_maxVisible] items so it stays a nudge rather than a second
/// inbox — the rest are reachable from their own service, which the tile badges
/// now point at. Every row is a one-tap route into the real payment flow: this
/// sheet never moves money itself, it only shortens the path to the screen that
/// does.
class PendingPaymentsPromptSheet extends StatelessWidget {
  const PendingPaymentsPromptSheet({
    required this.actions,
    required this.onPay,
    required this.onLater,
    super.key,
  });

  final List<PendingAction> actions;
  final void Function(PendingAction action) onPay;
  final VoidCallback onLater;

  static const int _maxVisible = 4;

  @override
  Widget build(BuildContext context) {
    final visible = actions.take(_maxVisible).toList();
    final hidden = actions.length - visible.length;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _header(),
            SizedBox(height: 16.h),
            // Constrained + scrollable so four rows with long names can never
            // push the actions off a small screen.
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 0.42.sh),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final action in visible) ...[
                      _PendingRow(action: action, onPay: () => onPay(action)),
                      SizedBox(height: 10.h),
                    ],
                  ],
                ),
              ),
            ),
            if (hidden > 0) ...[
              SizedBox(height: 2.h),
              Text(
                '+ $hidden more waiting — open the service to see ${hidden == 1 ? 'it' : 'them'}.',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onLater,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  'Not now',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: _kDeep.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.schedule_rounded, color: _kAccent, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _headline,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                _subhead,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  height: 1.35,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Names both halves so the prompt never announces the wrong kind of thing.
  /// Before categories existed this always said "payments waiting", which would
  /// have described a lone friend request as a payment.
  String get _headline {
    final payments = actions
        .where((a) => a.category == PendingActionCategory.payment)
        .length;
    final requests = actions.length - payments;
    String plural(int n, String word) => '$n $word${n == 1 ? '' : 's'}';
    if (payments > 0 && requests > 0) {
      return 'You have ${plural(payments, 'payment')} and '
          '${plural(requests, 'request')} waiting';
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

  String get _subhead {
    final hasPayments =
        actions.any((a) => a.category == PendingActionCategory.payment);
    return hasPayments
        ? 'Settle now, or come back to them any time from their service.'
        : 'Review these now, or come back to them any time.';
  }
}

class _PendingRow extends StatelessWidget {
  const _PendingRow({required this.action, required this.onPay});

  final PendingAction action;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final deadline = action.deadlineLabel;
    // Under a day left is the only case worth colouring — anything longer is
    // information, not urgency.
    final urgent = (action.timeLeft?.inHours ?? 999) < 24;

    return InkWell(
      onTap: onPay,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFEEF0F4)),
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: _kDeep.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(_icon, color: _kAccent, size: 17.sp),
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
                      color: const Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    // The source is always named: a bare "₦500 from Praiz"
                    // doesn't tell you which screen to go fix it on.
                    [action.source.label, action.subtitle]
                        .whereType<String>()
                        .where((s) => s.isNotEmpty)
                        .join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  if (deadline != null) ...[
                    SizedBox(height: 3.h),
                    Text(
                      deadline,
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: urgent
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Requests carry no amount. Rendering a placeholder here
                // would put a money figure on a friend request.
                if (action.formattedAmount != null) ...[
                  Text(
                    action.formattedAmount!,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      action.actionLabel,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: _kAccent,
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        size: 16.sp, color: _kAccent),
                  ],
                ),
              ],
            ),
          ],
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
