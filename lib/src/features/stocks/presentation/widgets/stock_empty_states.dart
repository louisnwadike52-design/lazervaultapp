import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable empty state widgets for stock screens
class StockEmptyStates {
  /// Empty portfolio state
  static Widget emptyPortfolio({VoidCallback? onGetStarted}) {
    return _EmptyStateTemplate(
      icon: Icons.pie_chart_outline,
      iconColor: const Color(0xFF10B981),
      title: 'No Holdings Yet',
      subtitle: 'Start investing to build your portfolio',
      actionText: 'Browse Stocks',
      onAction: onGetStarted,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF10B981).withValues(alpha: 0.15),
          const Color(0xFF059669).withValues(alpha: 0.05),
        ],
      ),
    );
  }

  /// Empty watchlist state
  static Widget emptyWatchlist({VoidCallback? onAddStocks}) {
    return _EmptyStateTemplate(
      icon: Icons.bookmark_border,
      iconColor: const Color(0xFFF59E0B),
      title: 'Your Watchlist is Empty',
      subtitle: 'Add stocks you want to track and monitor',
      actionText: 'Add Stocks',
      onAction: onAddStocks,
      gradient: LinearGradient(
        colors: [
          const Color(0xFFF59E0B).withValues(alpha: 0.15),
          const Color(0xFFD97706).withValues(alpha: 0.05),
        ],
      ),
    );
  }

  /// Empty orders state
  static Widget emptyOrders({VoidCallback? onTrade}) {
    return _EmptyStateTemplate(
      icon: Icons.receipt_long_outlined,
      iconColor: const Color(0xFF8B5CF6),
      title: 'No Orders Yet',
      subtitle: 'Your trade orders will appear here',
      actionText: 'Start Trading',
      onAction: onTrade,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF8B5CF6).withValues(alpha: 0.15),
          const Color(0xFF7C3AED).withValues(alpha: 0.05),
        ],
      ),
    );
  }

  /// Empty news state
  static Widget emptyNews({VoidCallback? onRetry}) {
    return _EmptyStateTemplate(
      icon: Icons.article_outlined,
      iconColor: const Color(0xFF3B82F6),
      title: 'No News Available',
      subtitle: 'Market news will appear here when available',
      actionText: 'Retry',
      onAction: onRetry,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF3B82F6).withValues(alpha: 0.15),
          const Color(0xFF2563EB).withValues(alpha: 0.05),
        ],
      ),
    );
  }

  /// Empty stocks search state
  static Widget emptySearchResults({String? searchQuery}) {
    return _EmptyStateTemplate(
      icon: Icons.search_off,
      iconColor: const Color(0xFF94A3B8),
      title: 'No Results Found',
      subtitle: searchQuery != null
          ? 'No stocks match "$searchQuery"'
          : 'Try adjusting your search',
      showAction: false,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF94A3B8).withValues(alpha: 0.15),
          const Color(0xFF64748B).withValues(alpha: 0.05),
        ],
      ),
    );
  }

  /// Error state for failed data loading
  static Widget errorState({
    required String message,
    VoidCallback? onRetry,
  }) {
    return _EmptyStateTemplate(
      icon: Icons.error_outline,
      iconColor: const Color(0xFFEF4444),
      title: 'Something Went Wrong',
      subtitle: message,
      actionText: 'Try Again',
      onAction: onRetry,
      gradient: LinearGradient(
        colors: [
          const Color(0xFFEF4444).withValues(alpha: 0.15),
          const Color(0xFFDC2626).withValues(alpha: 0.05),
        ],
      ),
    );
  }

  /// Network error state
  static Widget networkError({VoidCallback? onRetry}) {
    return _EmptyStateTemplate(
      icon: Icons.wifi_off,
      iconColor: const Color(0xFFF59E0B),
      title: 'No Internet Connection',
      subtitle: 'Please check your connection and try again',
      actionText: 'Retry',
      onAction: onRetry,
      gradient: LinearGradient(
        colors: [
          const Color(0xFFF59E0B).withValues(alpha: 0.15),
          const Color(0xFFD97706).withValues(alpha: 0.05),
        ],
      ),
    );
  }

  /// Loading skeleton for lists
  static Widget loadingSkeleton({int itemCount = 5}) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => _SkeletonItem(),
    );
  }

  /// Shimmer loading effect
  static Widget shimmerLoading({String? message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60.w,
            height: 60.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color(0xFF3B82F6),
              ),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 20.h),
            Text(
              message,
              style: GoogleFonts.inter(
                color: const Color(0xFF94A3B8),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Private template widget for consistent empty state design
class _EmptyStateTemplate extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  final bool showAction;
  final Gradient gradient;

  const _EmptyStateTemplate({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onAction,
    this.showAction = true,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container with gradient background
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                gradient: gradient,
                shape: BoxShape.circle,
                border: Border.all(
                  color: iconColor.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 56.sp,
                  color: iconColor,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),

            // Subtitle
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: const Color(0xFF94A3B8),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            // Action button
            if (showAction && actionText != null && onAction != null) ...[
              SizedBox(height: 32.h),
              GestureDetector(
                onTap: onAction,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        iconColor,
                        iconColor.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    actionText!,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
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

/// Skeleton loading item
class _SkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar skeleton
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: const Color(0xFF334155).withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),

          // Text skeletons
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF334155).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 14.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF334155).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),

          // Price skeleton
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 16.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF334155).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 14.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF334155).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
