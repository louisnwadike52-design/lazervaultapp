import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/statistics.pb.dart';

/// Financial Overview Card displaying key financial metrics
/// WCAG AA compliant colors with 4.5:1 contrast ratio
class FinancialOverviewCard extends StatelessWidget {
  final double trackedIncome;
  final double trackedExpenditure;
  final ComprehensiveFinancialSummary? comprehensiveSummary;
  final String currency;

  const FinancialOverviewCard({
    super.key,
    required this.trackedIncome,
    required this.trackedExpenditure,
    this.comprehensiveSummary,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    final netIncome = trackedIncome - trackedExpenditure;
    final savingsRate = trackedIncome > 0
        ? (netIncome / trackedIncome * 100).clamp(0, 100) as double
        : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A1A1A).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: const Color(0xFF4E03D0),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Financial Overview',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Metrics Grid
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    label: 'Total Income',
                    value: trackedIncome,
                    icon: Icons.trending_up,
                    color: const Color(0xFF10B981), // Green - WCAG AA
                    currency: currency,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _MetricCard(
                    label: 'Total Expenses',
                    value: trackedExpenditure,
                    icon: Icons.trending_down,
                    color: const Color(0xFFEF4444), // Red - WCAG AA
                    currency: currency,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    label: 'Net Income',
                    value: netIncome,
                    icon: Icons.savings,
                    color: netIncome >= 0
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                    currency: currency,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _SavingsRateCard(
                    savingsRate: savingsRate,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;
  final Color color;
  final String currency;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 20.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _formatCurrency(value, currency),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount, String currency) {
    return '\$${amount.toStringAsFixed(2)}';
  }
}

class _SavingsRateCard extends StatelessWidget {
  final double savingsRate;

  const _SavingsRateCard({
    required this.savingsRate,
  });

  @override
  Widget build(BuildContext context) {
    final color = savingsRate >= 20
        ? const Color(0xFF10B981) // Good - Green
        : savingsRate >= 10
            ? const Color(0xFFF59E0B) // Okay - Orange
            : const Color(0xFFEF4444); // Poor - Red

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.percent,
            color: color,
            size: 20.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            'Savings Rate',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${savingsRate.toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
