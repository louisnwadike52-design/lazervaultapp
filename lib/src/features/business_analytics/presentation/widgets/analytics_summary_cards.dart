import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

class AnalyticsSummaryCards extends StatelessWidget {
  final accounts_pb.GetFinancialAnalyticsResponse analytics;

  const AnalyticsSummaryCards({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    final current = analytics.currentPeriod;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            analytics.periodLabel.isNotEmpty
                ? analytics.periodLabel
                : 'This Period',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _buildKPICard(
                label: 'Income',
                amount: current.totalIncome,
                changePercent: analytics.incomeChangePercent,
                color: const Color(0xFF10B981),
              ),
              SizedBox(width: 12.w),
              _buildKPICard(
                label: 'Expenses',
                amount: current.totalExpenses,
                changePercent: analytics.expenseChangePercent,
                color: const Color(0xFFEF4444),
              ),
              SizedBox(width: 12.w),
              _buildKPICard(
                label: 'Net',
                amount: current.net,
                changePercent: null,
                color: current.net >= 0
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFFB923C),
              ),
              SizedBox(width: 12.w),
              _buildKPICard(
                label: 'Transactions',
                count: current.transactionCount,
                changePercent: null,
                color: const Color(0xFF8B5CF6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKPICard({
    required String label,
    double? amount,
    int? count,
    double? changePercent,
    required Color color,
  }) {
    final displayValue = count != null
        ? count.toString()
        : 'NGN ${_formatAmount((amount ?? 0) * 100)}';

    return Container(
      width: 160.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              displayValue,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          if (changePercent != null) ...[
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  changePercent >= 0
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  size: 14.sp,
                  color: changePercent >= 0
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                ),
                SizedBox(width: 4.w),
                Text(
                  '${changePercent.abs().toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: changePercent >= 0
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatAmount(double amountInKobo) {
    final amount = amountInKobo / 100;
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }
}
