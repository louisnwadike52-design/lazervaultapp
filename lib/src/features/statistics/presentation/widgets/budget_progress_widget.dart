import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/statistics.pb.dart';
import '../../../../../core/utils/currency_formatter.dart';

/// Budget Progress Widget
/// Displays budget progress with visual indicators
/// WCAG AA compliant colors
class BudgetProgressWidget extends StatelessWidget {
  final List<BudgetProgressItem> budgetProgress;
  final List<BudgetMessage> budgets;

  const BudgetProgressWidget({
    super.key,
    required this.budgetProgress,
    required this.budgets,
  });

  @override
  Widget build(BuildContext context) {
    if (budgetProgress.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: const Color(0xFF10B981),
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Budget Progress',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Budget Items
            ...budgetProgress.take(5).map((item) {
              return _BudgetProgressItem(progress: item);
            }),
          ],
        ),
      ),
    );
  }
}

class _BudgetProgressItem extends StatelessWidget {
  final BudgetProgressItem progress;

  const _BudgetProgressItem({required this.progress});

  @override
  Widget build(BuildContext context) {
    final percentage = progress.budgetAmount > 0
        ? (progress.spentAmount / progress.budgetAmount * 100).clamp(0, 100) as double
        : 0.0;

    final status = _getBudgetStatus(percentage);
    final remaining = progress.budgetAmount - progress.spentAmount;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  progress.budgetName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: status.color,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  status.label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: AlwaysStoppedAnimation<Color>(status.color),
              minHeight: 8.h,
            ),
          ),
          SizedBox(height: 12.h),

          // Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _DetailItem(
                label: 'Spent',
                value: CurrencySymbols.formatAmount(progress.spentAmount),
                color: const Color(0xFFEF4444),
              ),
              _DetailItem(
                label: 'Budget',
                value: CurrencySymbols.formatAmount(progress.budgetAmount),
                color: const Color(0xFF10B981),
              ),
              _DetailItem(
                label: 'Remaining',
                value: CurrencySymbols.formatAmount(remaining),
                color: remaining >= 0
                    ? const Color(0xFF10B981)
                    : const Color(0xFFEF4444),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _BudgetStatus _getBudgetStatus(double percentage) {
    if (percentage >= 100) {
      return _BudgetStatus(
        label: 'Over Budget',
        color: const Color(0xFFEF4444), // Red - WCAG AA
      );
    } else if (percentage >= 80) {
      return _BudgetStatus(
        label: 'Near Limit',
        color: const Color(0xFFF59E0B), // Orange - WCAG AA
      );
    } else if (percentage >= 50) {
      return _BudgetStatus(
        label: 'On Track',
        color: const Color(0xFF10B981), // Green - WCAG AA
      );
    } else {
      return _BudgetStatus(
        label: 'Good',
        color: const Color(0xFF10B981), // Green - WCAG AA
      );
    }
  }
}

class _BudgetStatus {
  final String label;
  final Color color;

  _BudgetStatus({required this.label, required this.color});
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _DetailItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
