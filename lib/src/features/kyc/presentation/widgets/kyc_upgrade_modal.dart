import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Modal bottom sheet shown when a financial operation is blocked by KYC tier limits.
///
/// Explains why the operation was blocked and offers the user a path to upgrade.
class KYCUpgradeModal extends StatelessWidget {
  final int currentTier;
  final int requiredTier;
  final String operationName;

  const KYCUpgradeModal({
    super.key,
    required this.currentTier,
    required this.requiredTier,
    required this.operationName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A4A),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Shield icon
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFB923C).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              color: const Color(0xFFFB923C),
              size: 32.w,
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Text(
            'Upgrade Required',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),

          // Description
          Text(
            'Your Tier $currentTier account has reached its transaction limit. '
            'Upgrade to Tier $requiredTier to $operationName with higher limits.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9CA3AF),
              height: 1.5,
            ),
          ),
          SizedBox(height: 8.h),

          // Tier comparison
          _buildTierComparison(),
          SizedBox(height: 24.h),

          // Upgrade button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () async {
                Get.back();
                await Future.delayed(const Duration(milliseconds: 150));
                Get.toNamed(AppRoutes.kycProgressive);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Upgrade Now',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Maybe later button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Maybe Later',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierComparison() {
    final currentLimits = _getTierLimits(currentTier);
    final upgradeLimits = _getTierLimits(requiredTier);

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Current tier
          Expanded(
            child: Column(
              children: [
                Text(
                  'Tier $currentTier',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  currentLimits,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Arrow
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Icon(
              Icons.arrow_forward,
              color: const Color(0xFF3B82F6),
              size: 20.w,
            ),
          ),
          // Upgrade tier
          Expanded(
            child: Column(
              children: [
                Text(
                  'Tier $requiredTier',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF10B981),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  upgradeLimits,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTierLimits(int tier) {
    switch (tier) {
      case 1:
        return '\u20A650,000/day';
      case 2:
        return '\u20A6500,000/day';
      case 3:
        return '\u20A65,000,000/day';
      default:
        return 'N/A';
    }
  }
}
