import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/widgets/budget_warning_widget.dart';

/// Non-blocking budget warning shown BEFORE a transfer when the matching
/// budget is FLEXIBLE (or near its limit). Strict budgets use
/// BudgetOverrideDialog instead — this is the "allows transactions with a
/// warning" half of the enforcement model.
///
/// Returns true when the user chooses to proceed, false/null on cancel.
Future<bool?> showBudgetWarningSheet(
  BuildContext context, {
  required BudgetValidationResult result,
  required double transactionAmount,
  required String currency,
}) {
  final budget = result.primaryBudget;
  final isExceeded = result.status == BudgetStatus.exceeded;
  final accent =
      isExceeded ? const Color(0xFFFB923C) : const Color(0xFFFBBF24);

  final projectedSpent = result.currentSpent + transactionAmount;
  final overBy = projectedSpent - result.budgetLimit;

  String money(double v) => CurrencySymbols.formatAmountWithCurrency(v, currency);

  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: const Color(0xFF1F1F1F),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.warning_amber_rounded,
                      color: accent, size: 24.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isExceeded
                            ? 'This goes over your budget'
                            : 'You\'re close to your budget',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        budget?.budgetName ?? 'Budget',
                        style: GoogleFonts.inter(
                          color: accent,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Progress bar (projected)
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: LinearProgressIndicator(
                value: result.budgetLimit > 0
                    ? (projectedSpent / result.budgetLimit).clamp(0.0, 1.0)
                    : 0,
                minHeight: 8.h,
                backgroundColor: const Color(0xFF2D2D2D),
                valueColor: AlwaysStoppedAnimation(accent),
              ),
            ),
            SizedBox(height: 14.h),

            _row('Already spent', money(result.currentSpent)),
            _row('This transfer', money(transactionAmount)),
            _row('Budget limit', money(result.budgetLimit)),
            if (isExceeded && overBy > 0)
              _row('Over by', money(overBy), valueColor: accent, bold: true)
            else
              _row('Remaining after',
                  money((result.budgetLimit - projectedSpent).clamp(0, double.infinity)),
                  valueColor: const Color(0xFF10B981)),

            SizedBox(height: 16.h),
            Text(
              isExceeded
                  ? 'This is a flexible budget, so we won\'t stop you — but this transfer will put you over your limit.'
                  : 'This is a flexible budget. You can still proceed.',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.5.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 20.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF2D2D2D)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text('Cancel',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text('Proceed anyway',
                        style: GoogleFonts.inter(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _row(String label, String value,
    {Color? valueColor, bool bold = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
        Text(value,
            style: GoogleFonts.inter(
                color: valueColor ?? Colors.white,
                fontSize: 13.sp,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w600)),
      ],
    ),
  );
}
