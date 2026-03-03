import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_summary_entity.dart';

/// Gradient top card showing active count, monthly spend, and expiring count.
class SubscriptionSummaryCard extends StatelessWidget {
  final SubscriptionSummaryEntity summary;

  const SubscriptionSummaryCard({super.key, required this.summary});

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00');
    return '${CurrencySymbols.currentSymbol}${formatter.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F1F1F), Color(0xFF2D2D2D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryColumn(
              label: 'Active',
              value: '${summary.activeCount}',
              color: const Color(0xFF10B981),
              icon: Icons.check_circle_outline,
            ),
          ),
          Container(
            width: 1,
            height: 50.h,
            color: const Color(0xFF2D2D2D),
          ),
          Expanded(
            child: _SummaryColumn(
              label: 'Monthly Spend',
              value: _formatAmount(summary.totalMonthlySpend),
              color: Colors.white,
              icon: Icons.payments_outlined,
            ),
          ),
          Container(
            width: 1,
            height: 50.h,
            color: const Color(0xFF2D2D2D),
          ),
          Expanded(
            child: _SummaryColumn(
              label: 'Expiring',
              value: '${summary.expiringCount}',
              color: summary.expiringCount > 0
                  ? const Color(0xFFFB923C)
                  : const Color(0xFF9CA3AF),
              icon: Icons.timer_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryColumn({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 11.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
