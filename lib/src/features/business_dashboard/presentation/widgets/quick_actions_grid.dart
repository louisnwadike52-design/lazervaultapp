import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: Icons.payments_rounded,
                label: 'Pay Staff',
                color: const Color(0xFF3B82F6),
                onTap: () => Get.toNamed(AppRoutes.payroll),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _ActionButton(
                icon: Icons.receipt_long_rounded,
                label: 'Invoice',
                color: const Color(0xFF10B981),
                onTap: () => Get.toNamed(AppRoutes.createInvoice),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _ActionButton(
                icon: Icons.send_rounded,
                label: 'Send',
                color: const Color(0xFFFB923C),
                onTap: () => Get.toNamed(AppRoutes.selectRecipient),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _ActionButton(
                icon: Icons.analytics_rounded,
                label: 'Analytics',
                color: const Color(0xFF8B5CF6),
                onTap: () => Get.toNamed(AppRoutes.businessAnalytics),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20.sp, color: color),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
