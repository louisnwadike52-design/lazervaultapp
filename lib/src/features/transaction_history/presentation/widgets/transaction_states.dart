import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Empty state widget for transaction history
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
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.receipt_long_rounded,
                size: 48.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              message ?? 'No Transactions Yet',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Your transaction history will appear here',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              SizedBox(height: 24.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Error state widget for transaction history
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
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48.sp,
                color: Colors.red.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh_rounded, size: 18.sp),
                label: Text(
                  'Retry',
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
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

/// Loading state widget for transaction history
class TransactionLoadingState extends StatelessWidget {
  final String? message;

  const TransactionLoadingState({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withValues(alpha: 0.7),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Initial/placeholder loading widget
class TransactionInitialLoading extends StatelessWidget {
  const TransactionInitialLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              _buildShimmerBox(48.w, 48.w),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerBox(120.w, 16.sp),
                    SizedBox(height: 8.h),
                    _buildShimmerBox(80.w, 12.sp),
                    SizedBox(height: 6.h),
                    _buildShimmerBox(100.w, 11.sp),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildShimmerBox(80.w, 16.sp),
                  SizedBox(height: 6.h),
                  _buildShimmerBox(60.w, 10.sp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerBox(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
