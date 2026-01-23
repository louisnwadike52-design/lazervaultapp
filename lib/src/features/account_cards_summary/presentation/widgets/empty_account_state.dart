import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Empty state widget displayed when a user has no virtual accounts
/// This is shown to non-Nigeria users or users whose accounts are not yet created
class EmptyAccountState extends StatelessWidget {
  /// The user's country code (if available)
  final String? countryCode;

  /// Whether virtual accounts are supported in the user's country
  final bool isVirtualAccountSupported;

  /// Callback when the user wants to get notified about account availability
  final VoidCallback? onNotifyMe;

  const EmptyAccountState({
    super.key,
    this.countryCode,
    this.isVirtualAccountSupported = false,
    this.onNotifyMe,
  });

  /// Check if the country supports virtual accounts (Nigeria only for now)
  static bool isCountrySupported(String? countryCode) {
    if (countryCode == null) return false;
    return countryCode.toUpperCase() == 'NG';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C5CE7).withOpacity(0.8),
            const Color(0xFF4834D4).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background decorative pattern
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              left: -20,
              bottom: -40,
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.04),
                ),
              ),
            ),
            // Main content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isVirtualAccountSupported
                          ? Icons.account_balance_wallet_outlined
                          : Icons.hourglass_empty_rounded,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),

                  // Title
                  Text(
                    isVirtualAccountSupported
                        ? 'Setting Up Your Accounts'
                        : 'Coming Soon',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Description
                  Text(
                    isVirtualAccountSupported
                        ? 'Your virtual accounts are being created.'
                        : 'Virtual accounts will be available in your region soon.',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12.sp,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 18.h),

                  // Action button
                  if (isVirtualAccountSupported)
                    _buildRefreshButton(context)
                  else
                    _buildNotifyMeButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Trigger account refresh
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Checking account status...'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.refresh_rounded,
              color: const Color(0xFF6C5CE7),
              size: 16.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              'Check Status',
              style: TextStyle(
                color: const Color(0xFF6C5CE7),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifyMeButton(BuildContext context) {
    return GestureDetector(
      onTap: onNotifyMe ??
          () {
            // Default notify me action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'We\'ll notify you when virtual accounts become available in your region!',
                ),
                duration: const Duration(seconds: 3),
                backgroundColor: const Color(0xFF6C5CE7),
              ),
            );
          },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_active_outlined,
              color: const Color(0xFF6C5CE7),
              size: 16.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              'Notify Me',
              style: TextStyle(
                color: const Color(0xFF6C5CE7),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget shown when user is in a supported country but still loading accounts
class AccountLoadingState extends StatelessWidget {
  const AccountLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C5CE7),
            Color(0xFF4834D4),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
            SizedBox(height: 16.h),
            Text(
              'Loading your accounts...',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
