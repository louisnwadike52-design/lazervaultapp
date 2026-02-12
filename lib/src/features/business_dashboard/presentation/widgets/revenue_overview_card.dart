import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RevenueOverviewCard extends StatelessWidget {
  final int totalRevenue;
  final int totalExpenses;
  final int netProfit;
  final String currency;

  const RevenueOverviewCard({
    super.key,
    required this.totalRevenue,
    required this.totalExpenses,
    required this.netProfit,
    required this.currency,
  });

  String _formatAmount(int amountInMinor) {
    final amount = amountInMinor / 100;
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'Revenue',
            amount: _formatAmount(totalRevenue),
            currency: currency,
            color: const Color(0xFF10B981),
            icon: Icons.trending_up_rounded,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _SummaryCard(
            label: 'Expenses',
            amount: _formatAmount(totalExpenses),
            currency: currency,
            color: const Color(0xFFEF4444),
            icon: Icons.trending_down_rounded,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _SummaryCard(
            label: 'Net',
            amount: _formatAmount(netProfit),
            currency: currency,
            color: netProfit >= 0
                ? const Color(0xFF3B82F6)
                : const Color(0xFFFB923C),
            icon: Icons.account_balance_rounded,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String amount;
  final String currency;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.currency,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 16.sp, color: color),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 2.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              '$currency $amount',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
