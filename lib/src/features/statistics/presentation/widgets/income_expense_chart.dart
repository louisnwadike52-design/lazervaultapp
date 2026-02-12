import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Income vs Expense Chart Widget
/// Displays a visual comparison of income and expenses
/// Uses WCAG AA compliant colors
class IncomeExpenseChart extends StatelessWidget {
  final double income;
  final double expenses;
  final Map<String, double> incomeBreakdown;
  final Map<String, double> expenseBreakdown;
  final DateTime startDate;
  final DateTime endDate;

  const IncomeExpenseChart({
    super.key,
    required this.income,
    required this.expenses,
    required this.incomeBreakdown,
    required this.expenseBreakdown,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A1A1A).withValues(alpha: 0.08),
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
                  Icons.bar_chart,
                  color: const Color(0xFF4E03D0),
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Income vs Expenses',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Bar Chart
            _buildBarChart(),
            SizedBox(height: 24.h),

            // Breakdown
            _buildBreakdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final maxValue = income > expenses ? income : expenses;
    final incomePercentage = (maxValue > 0 ? (income / maxValue) : 0).toDouble();
    final expensePercentage = (maxValue > 0 ? (expenses / maxValue) : 0).toDouble();

    return Column(
      children: [
        // Income Bar
        _BarRow(
          label: 'Income',
          value: income,
          percentage: incomePercentage,
          color: const Color(0xFF10B981), // Green - WCAG AA
        ),
        SizedBox(height: 16.h),

        // Expense Bar
        _BarRow(
          label: 'Expenses',
          value: expenses,
          percentage: expensePercentage,
          color: const Color(0xFFEF4444), // Red - WCAG AA
        ),
      ],
    );
  }

  Widget _buildBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Breakdown by Source',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        SizedBox(height: 16.h),

        // Income Breakdown
        if (incomeBreakdown.isNotEmpty) ...[
          Text(
            'Income Sources',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 8.h),
          ...incomeBreakdown.entries.take(3).map((entry) {
            return _BreakdownItem(
              label: _formatLabel(entry.key),
              value: entry.value,
              color: const Color(0xFF10B981),
            );
          }),
          SizedBox(height: 16.h),
        ],

        // Expense Breakdown
        if (expenseBreakdown.isNotEmpty) ...[
          Text(
            'Expense Categories',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 8.h),
          ...expenseBreakdown.entries.take(3).map((entry) {
            return _BreakdownItem(
              label: _formatLabel(entry.key),
              value: entry.value,
              color: const Color(0xFFEF4444),
            );
          }),
        ],
      ],
    );
  }

  String _formatLabel(String key) {
    return key.split('_').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}

class _BarRow extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  final Color color;

  const _BarRow({
    required this.label,
    required this.value,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            Text(
              CurrencySymbols.formatAmount(value),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: LinearProgressIndicator(
            value: percentage.clamp(0.0, 1.0),
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 12.h,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${(percentage * 100).toStringAsFixed(1)}% of total',
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

class _BreakdownItem extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _BreakdownItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF374151),
              ),
            ),
          ),
          Text(
            CurrencySymbols.formatAmount(value),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
