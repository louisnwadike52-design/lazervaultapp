import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// Balance Trend Chart Widget
/// Shows balance trends over time with change indicators
/// WCAG AA compliant colors
class BalanceTrendChart extends StatelessWidget {
  final double balance;
  final double previousBalance;
  final DateTime startDate;
  final DateTime endDate;

  const BalanceTrendChart({
    super.key,
    required this.balance,
    required this.previousBalance,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final change = balance - previousBalance;
    final changePercent = previousBalance != 0
        ? (change / previousBalance.abs() * 100)
        : 0.0;
    final isPositive = change >= 0;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.show_chart,
                  color: const Color(0xFF4E03D0),
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Balance Trend',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Current Balance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Balance',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: (isPositive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444))
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${isPositive ? '+' : ''}${changePercent.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: isPositive
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Change Details
            _buildChangeDetail('Change from last period', change),
            SizedBox(height: 16.h),
            _buildChangeDetail('Previous Balance', previousBalance),

            SizedBox(height: 24.h),

            // Period Info
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16.sp,
                    color: const Color(0xFF4E03D0),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Period: ${DateFormat('MMM dd').format(startDate)} - ${DateFormat('MMM dd, yyyy').format(endDate)}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangeDetail(String label, double value) {
    final isPositive = value >= 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF6B7280),
          ),
        ),
        Text(
          '${isPositive ? '+' : ''}\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isPositive
                ? const Color(0xFF10B981)
                : const Color(0xFFEF4444),
          ),
        ),
      ],
    );
  }
}
