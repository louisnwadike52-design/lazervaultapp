import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';

/// Progressive KYC prompt shown during signup flow
/// Allows users to either complete KYC now or skip for later
class ProgressiveKYCPromptScreen extends StatelessWidget {
  final String countryCode;
  final String? firstName;

  const ProgressiveKYCPromptScreen({
    super.key,
    required this.countryCode,
    this.firstName,
  });

  KYCTier _getNextTier() {
    // Determine next tier based on country requirements
    final config = CountryConfigs.getByCode(countryCode);
    if (config?.isAvailableForSignup ?? false) {
      return KYCTier.tier2;
    }
    return KYCTier.tier1;
  }

  IDType? _getPreferredIdType() {
    switch (countryCode) {
      case 'NG':
        return IDType.bvn; // Prefer BVN for Nigeria
      case 'GH':
        return IDType.ghanaCard;
      case 'KE':
        return IDType.kenyaNationalId;
      case 'ZA':
        return IDType.saIdCard;
      case 'GB':
        return IDType.ukPassport;
      case 'US':
        return IDType.usSsn;
      default:
        return null;
    }
  }

  Map<String, dynamic> _getTierLimits() {
    switch (countryCode) {
      case 'NG':
        return {
          'tier1': '₦50,000',
          'tier2': '₦500,000',
          'tier3': 'Unlimited',
        };
      case 'GH':
        return {
          'tier1': 'GH₵50',
          'tier2': 'GH₵500',
          'tier3': 'Unlimited',
        };
      case 'KE':
        return {
          'tier1': 'KSh 5,000',
          'tier2': 'KSh 50,000',
          'tier3': 'Unlimited',
        };
      case 'ZA':
        return {
          'tier1': 'R500',
          'tier2': 'R5,000',
          'tier3': 'Unlimited',
        };
      case 'GB':
        return {
          'tier1': '£50',
          'tier2': '£500',
          'tier3': 'Unlimited',
        };
      case 'US':
        return {
          'tier1': '\$50',
          'tier2': '\$500',
          'tier3': 'Unlimited',
        };
      default:
        return {
          'tier1': '50',
          'tier2': '500',
          'tier3': 'Unlimited',
        };
    }
  }

  String _getIdName() {
    switch (countryCode) {
      case 'NG':
        return 'BVN or NIN';
      case 'GH':
        return 'Ghana Card';
      case 'KE':
        return 'National ID';
      case 'ZA':
        return 'Smart ID Card';
      case 'GB':
        return 'Passport or Driving Licence';
      case 'US':
        return 'SSN';
      default:
        return 'Government ID';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tierLimits = _getTierLimits();
    final nextTier = _getNextTier();
    final idName = _getIdName();
    final displayName = firstName ?? 'there';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Illustration
              Center(
                child: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.verified_user,
                      size: 100.sp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Title
              Text(
                'Verify Your Identity, $displayName',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),

              // Description
              Text(
                'Complete identity verification to unlock higher transaction limits and access all features.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),

              // Tier comparison card
              _buildTierComparisonCard(tierLimits),
              SizedBox(height: 32.h),

              // Benefits list
              _buildBenefitsList(idName),
              SizedBox(height: 32.h),

              // Verify Now button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Navigate to ID verification screen
                    Get.toNamed(
                      AppRoutes.kycVerifyId,
                      arguments: {
                        'targetTier': nextTier,
                        'preferredIdType': _getPreferredIdType(),
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified, color: Colors.white, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'Verify Now',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Skip button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {
                    _showSkipConfirmation(context);
                  },
                  child: Text(
                    'Skip for Now',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Info text
              Center(
                child: Text(
                  'You can complete verification anytime from Settings',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTierComparisonCard(Map<String, dynamic> tierLimits) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTierItem(
                  'Tier 1',
                  tierLimits['tier1'],
                  'Basic',
                  Colors.grey,
                  false,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(Icons.arrow_forward, color: Colors.grey, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTierItem(
                  'Tier 2',
                  tierLimits['tier2'],
                  'Verified',
                  Colors.blue,
                  true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTierItem(
    String title,
    String limit,
    String subtitle,
    Color color,
    bool isHighlighted,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isHighlighted ? color.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isHighlighted ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            limit,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            '/day',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsList(String idName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verification Benefits',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        _buildBenefitItem(
          Icons.account_balance_wallet,
          'Send up to ${countryCode == 'NG' ? '₦500,000' : 'higher amounts'} per day',
        ),
        SizedBox(height: 12.h),
        _buildBenefitItem(
          Icons.swap_horiz,
          'Access international transfers',
        ),
        SizedBox(height: 12.h),
        _buildBenefitItem(
          Icons.card_membership,
          'Request virtual and physical cards',
        ),
        SizedBox(height: 12.h),
        _buildBenefitItem(
          Icons.verified,
          'Full access to all platform features',
        ),
      ],
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: Colors.green, size: 20.sp),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  void _showSkipConfirmation(BuildContext context) {
    Get.defaultDialog(
      title: 'Skip Verification?',
      titleStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      middleText: 'You\'ll have a daily limit of ₦50,000. You can complete verification later from Settings.',
      middleTextStyle: TextStyle(
        fontSize: 14.sp,
        color: Colors.black54,
      ),
      textConfirm: 'Skip',
      textCancel: 'Verify Now',
      confirmTextColor: Colors.white,
      buttonColor: Colors.grey.shade600,
      cancelTextColor: Colors.blue,
      onConfirm: () {
        Get.back(); // Close dialog
        // Continue with signup - will be marked as Tier 1
        Get.back(result: {'skipped': true});
      },
      onCancel: () {
        Get.back(); // Close dialog
        // Navigate to verification
        Get.toNamed(
          AppRoutes.kycVerifyId,
          arguments: {
            'targetTier': _getNextTier(),
            'preferredIdType': _getPreferredIdType(),
          },
        );
      },
      barrierDismissible: true,
      radius: 16.r,
    );
  }
}
