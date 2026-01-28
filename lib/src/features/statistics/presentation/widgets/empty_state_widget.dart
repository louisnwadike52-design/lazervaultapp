import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Empty State Widget for Statistics Screen
/// Shows when no data is available
/// WCAG AA compliant colors
class EmptyStateWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    this.message,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 48.sp,
                color: const Color(0xFF4E03D0),
              ),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              'No Financial Data Yet',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            // Message
            Text(
              message ??
                  'Start tracking your income and expenses to see your financial statistics here. '
                  'You can add transactions manually or connect your bank account for automatic tracking.',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),

            // Action Buttons
            if (onAction != null) ...[
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: const Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              OutlinedButton.icon(
                onPressed: () {
                  // Connect bank action
                },
                icon: const Icon(Icons.account_balance),
                label: const Text('Connect Bank Account'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4E03D0),
                  side: const BorderSide(
                    color: Color(0xFF4E03D0),
                    width: 2,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],

            SizedBox(height: 24.h),

            // Tips
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: const Color(0xFF3B82F6),
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Tip: Connect your bank account to automatically import all your transactions',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF3B82F6),
                      ),
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
}
