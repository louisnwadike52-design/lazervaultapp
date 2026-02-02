import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_card.dart';

/// Empty state — minimal dark theme
class TransactionEmptyState extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final Widget? action;

  const TransactionEmptyState({
    super.key,
    this.message,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.receipt_long_rounded,
              size: 48.sp,
              color: const Color(0xFF8E8E93),
            ),
            SizedBox(height: 16.h),
            Text(
              message ?? 'No transactions yet',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              'Your transactions will appear here',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              SizedBox(height: 20.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Error state — minimal with retry
class TransactionErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const TransactionErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: onRetry,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading state — shimmer placeholders
class TransactionInitialLoading extends StatelessWidget {
  const TransactionInitialLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: 8,
      itemBuilder: (context, index) => const TransactionCardShimmer(),
    );
  }
}
