import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

import '../../domain/vendor_entities.dart';
import 'vendor_money.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// The answer to one scan, shown as a bottom sheet.
///
/// ALREADY-SERVED IS NOT A FAILURE AND MUST NOT LOOK LIKE ONE. Two tills
/// scanning the same customer within seconds is ordinary at a busy door, and
/// the right response is "already served at 19:42 — next customer", not a red
/// error that makes a vendor stop and re-scan.
Future<void> showVendorResultSheet(
  BuildContext context, {
  required RedeemOutcome outcome,
  required VendorCampaign campaign,
}) {
  return showAppBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _VendorResultSheet(outcome: outcome, campaign: campaign),
  );
}

class _VendorResultSheet extends StatelessWidget {
  const _VendorResultSheet({required this.outcome, required this.campaign});

  final RedeemOutcome outcome;
  final VendorCampaign campaign;

  @override
  Widget build(BuildContext context) {
    final served = outcome.alreadyServed;
    final accent = served ? PayFlowTheme.warning : PayFlowTheme.success;

    return Container(
      padding: EdgeInsets.fromLTRB(
          20.w, 18.h, 20.w, MediaQuery.of(context).padding.bottom + 20.h),
      decoration: const BoxDecoration(
        color: PayFlowTheme.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: PayFlowTheme.border,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 18.h),

          CircleAvatar(
            radius: 28.r,
            backgroundColor: accent.withValues(alpha: 0.15),
            child: Icon(
              served ? Icons.history_rounded : Icons.check_rounded,
              color: accent,
              size: 30.sp,
            ),
          ),
          SizedBox(height: 14.h),

          Text(
            served ? 'Already served' : 'Customer served',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6.h),

          if (outcome.customerName.isNotEmpty)
            Text(
              outcome.customerName,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
          if (outcome.customerUsername.isNotEmpty)
            Text(
              '@${outcome.customerUsername}',
              style:
                  TextStyle(color: PayFlowTheme.textSecondary, fontSize: 12.sp),
            ),

          SizedBox(height: 14.h),

          // WHEN they were served, and UNDER WHICH RULE.
          //
          // "Already served" means two different things now, and the sheet
          // used to say only the first:
          //
          //   campaign scope — served on THIS campaign. The question is
          //       whether that was just now on the other till or an hour ago,
          //       so a bare time is exactly right.
          //   vendor scope   — served by this VENDOR, possibly on a different
          //       campaign, possibly days ago at another venue. A bare "served
          //       at 19:42" reads as tonight, and the attendant tells a
          //       customer they were here when they were not. That is an
          //       argument neither of them can settle: the customer knows they
          //       did not come, and the screen says they did.
          //
          // So the wide rule gets the DATE as well as the time, and says which
          // rule refused — because the customer's next question is "why", and
          // "you have already claimed this once" is an answer they can accept.
          if (served && outcome.servedAt != null)
            Text(
              campaign.isVendorScoped
                  ? 'Already claimed ${_when(outcome.servedAt!)}. This '
                      'promotion counts each customer once for your business, '
                      'across all your campaigns — so they cannot be served '
                      'again. Nobody has been charged or paid twice.'
                  : 'Served at ${_hhmm(outcome.servedAt!)}. They have not been '
                      'charged twice and you have not been paid twice.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: PayFlowTheme.textSecondary, fontSize: 12.sp),
            )
          else
            Text(
              '${formatKobo(outcome.amountKobo, outcome.currency)} added to '
              'your earnings',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: PayFlowTheme.accentOnDark,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),

          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: PayFlowTheme.bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Fact(
                  label: 'Served',
                  value: '${outcome.redeemedCount} / ${outcome.maxRedemptions}',
                ),
                _Fact(
                  label: 'Left to serve',
                  value: '${outcome.remainingRedemptions}',
                ),
              ],
            ),
          ),

          // The cap closing is said plainly and immediately: the next person
          // in the queue needs to be told now, not after another refused scan.
          if (outcome.campaignStatus == 'exhausted') ...[
            SizedBox(height: 14.h),
            Text(
              'That was the last customer on this campaign. Scanning is now '
              'closed and your earnings are ready to withdraw.',
              textAlign: TextAlign.center,
              style: TextStyle(color: PayFlowTheme.warning, fontSize: 12.sp),
            ),
          ],

          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: PayFlowTheme.accentCta,
                padding: EdgeInsets.symmetric(vertical: 13.h),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Next customer'),
            ),
          ),
        ],
      ),
    );
  }

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  /// A time for today, a date and time for anything older.
  ///
  /// Only the vendor-wide rule can refuse on a scan from another day, and that
  /// is precisely when a bare clock time misleads — it reads as tonight.
  static String _when(DateTime t) {
    final now = DateTime.now();
    final sameDay =
        t.year == now.year && t.month == now.month && t.day == now.day;
    if (sameDay) return 'at ${_hhmm(t)}';
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'on ${t.day} ${months[t.month - 1]} at ${_hhmm(t)}';
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700)),
        Text(label,
            style:
                TextStyle(color: PayFlowTheme.textSecondary, fontSize: 11.sp)),
      ],
    );
  }
}

/// A refusal at the door: what went wrong and what to do about it.
Future<void> showVendorRefusalSheet(
  BuildContext context, {
  required String title,
  required String message,
}) {
  return showAppBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      padding: EdgeInsets.fromLTRB(
          20.w, 18.h, 20.w, MediaQuery.of(context).padding.bottom + 20.h),
      decoration: const BoxDecoration(
        color: PayFlowTheme.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline_rounded,
              color: PayFlowTheme.warning, size: 34.sp),
          SizedBox(height: 12.h),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 8.h),
          Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: PayFlowTheme.textSecondary, fontSize: 13.sp)),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: PayFlowTheme.accentCta,
                padding: EdgeInsets.symmetric(vertical: 13.h),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it'),
            ),
          ),
        ],
      ),
    ),
  );
}
