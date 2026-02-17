import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Data needed to render the cash flow insights card.
class CashFlowData {
  final double totalIncome;
  final double totalExpenses;
  final double dailyAverage;
  final double expenseChangePercent;

  /// The period being viewed: "week", "month", "quarter", "year".
  final String period;

  /// Start and end dates of the current period.
  final DateTime periodStart;
  final DateTime periodEnd;

  /// Top expense categories, sorted by amount descending.
  /// Each entry: (categoryName, amount, percentage).
  final List<({String name, double amount, double percentage})> topCategories;

  /// Total transaction count for the period.
  final int transactionCount;

  const CashFlowData({
    required this.totalIncome,
    required this.totalExpenses,
    required this.dailyAverage,
    required this.expenseChangePercent,
    required this.period,
    required this.periodStart,
    required this.periodEnd,
    this.topCategories = const [],
    this.transactionCount = 0,
  });

  /// Days elapsed so far in this period (at least 1 to avoid division by zero).
  int get daysElapsed {
    final now = DateTime.now();
    final effective = now.isBefore(periodEnd) ? now : periodEnd;
    return effective.difference(periodStart).inDays.clamp(1, 366);
  }

  /// Total days in the period.
  int get totalDays =>
      periodEnd.difference(periodStart).inDays.clamp(1, 366);

  /// Days remaining in the period.
  int get daysRemaining => (totalDays - daysElapsed).clamp(0, 366);

  /// Projected total expenses by end of period (linear extrapolation).
  double get projectedExpenses {
    if (daysElapsed <= 0) return totalExpenses;
    return (totalExpenses / daysElapsed) * totalDays;
  }

  /// Projected net income (income minus projected expenses).
  double get projectedNet => totalIncome - projectedExpenses;

  /// Net cash flow so far.
  double get netCashFlow => totalIncome - totalExpenses;

  /// Whether spending pace is increasing vs last period.
  bool get isOverspending => expenseChangePercent > 5;
}

/// Cash Flow Insights Card
///
/// Shows cash flow projection, daily average, spending pace, remaining capacity,
/// and top expense categories for the current period.
class CashFlowInsightsCard extends StatelessWidget {
  final CashFlowData data;
  final VoidCallback? onTap;

  const CashFlowInsightsCard({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Don't render if no financial activity
    if (data.totalIncome <= 0 && data.totalExpenses <= 0) {
      return const SizedBox.shrink();
    }

    final netColor = data.netCashFlow >= 0
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.trending_up,
                    color: const Color(0xFF3B82F6),
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Cash Flow Insights',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Period progress pill
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${data.daysRemaining}d left',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Net cash flow + projection row
            Row(
              children: [
                // Net cash flow
                Expanded(
                  child: _MetricTile(
                    label: 'Net Cash Flow',
                    value: '${data.netCashFlow >= 0 ? '+' : '-'}${CurrencySymbols.formatAmount(data.netCashFlow.abs())}',
                    valueColor: netColor,
                  ),
                ),
                SizedBox(width: 12.w),
                // Projected end-of-period
                Expanded(
                  child: _MetricTile(
                    label: 'Projected Spend',
                    value: CurrencySymbols.formatAmount(data.projectedExpenses),
                    valueColor: data.projectedExpenses > data.totalIncome
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Daily average + transaction count row
            Row(
              children: [
                Expanded(
                  child: _MetricTile(
                    label: 'Daily Avg. Spend',
                    value: CurrencySymbols.formatAmount(data.dailyAverage),
                    valueColor: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _MetricTile(
                    label: 'Transactions',
                    value: data.transactionCount.toString(),
                    valueColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Spending pace indicator
            _buildPaceIndicator(),

            // Top categories (up to 3)
            if (data.topCategories.isNotEmpty) ...[
              SizedBox(height: 16.h),
              Text(
                'Top Spending',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              ...data.topCategories.take(3).map(_buildCategoryBar),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaceIndicator() {
    final change = data.expenseChangePercent;
    final isDown = change < 0;
    final isStable = change.abs() <= 5;

    String paceText;
    Color paceColor;
    IconData paceIcon;

    if (isStable) {
      paceText = 'Spending is stable vs last period';
      paceColor = const Color(0xFF3B82F6);
      paceIcon = Icons.horizontal_rule;
    } else if (isDown) {
      paceText = 'Spending down ${change.abs().toStringAsFixed(0)}% vs last period';
      paceColor = const Color(0xFF10B981);
      paceIcon = Icons.trending_down;
    } else {
      paceText = 'Spending up ${change.toStringAsFixed(0)}% vs last period';
      paceColor = change > 15
          ? const Color(0xFFEF4444)
          : const Color(0xFFFB923C);
      paceIcon = Icons.trending_up;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: paceColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(paceIcon, color: paceColor, size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              paceText,
              style: TextStyle(
                color: paceColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar(({String name, double amount, double percentage}) category) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${CurrencySymbols.formatAmount(category.amount)} (${category.percentage.toStringAsFixed(0)}%)',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(2.r),
            child: LinearProgressIndicator(
              value: (category.percentage / 100).clamp(0.0, 1.0),
              minHeight: 4.h,
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
          ),
        ],
      ),
    );
  }
}

/// A compact metric tile showing label + value.
class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _MetricTile({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
