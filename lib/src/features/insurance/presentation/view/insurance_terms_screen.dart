import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/insurance_product_entity.dart';

class InsuranceTermsScreen extends StatelessWidget {
  final InsuranceProduct product;

  const InsuranceTermsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    _buildHeroCard(),
                    SizedBox(height: 24.h),
                    _buildCoverageBenefitsSection(),
                    SizedBox(height: 16.h),
                    _buildSectionCard(
                      title: 'Eligibility Requirements',
                      items: [
                        'Must be a registered LazerVault user',
                        'Must meet minimum age requirements',
                        'Must provide accurate personal information',
                        'Must be a resident of a supported region',
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildSectionCard(
                      title: 'Premium Payments',
                      items: [
                        'Premiums must be paid on time to maintain coverage',
                        'Late payments may result in policy suspension',
                        'Premium amounts are determined at the time of purchase',
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildSectionCard(
                      title: 'Claims Process',
                      items: [
                        'Claims must be filed within 30 days of the incident',
                        'Supporting documentation is required for all claims',
                        'Claims are reviewed within 5-10 business days',
                        'Approved claims are settled to your LazerVault account',
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildSectionCard(
                      title: 'Exclusions',
                      items: [
                        'Pre-existing conditions (varies by policy)',
                        'Intentional self-harm or illegal activities',
                        'War, terrorism, or nuclear events',
                        'Claims filed after the policy expiration date',
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildSectionCard(
                      title: 'Cancellation Policy',
                      items: [
                        'You may cancel within 14 days for a full refund',
                        'After 14 days, cancellation terms vary by provider',
                        'Contact the provider to initiate cancellation',
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildSectionCard(
                      title: 'Data Privacy',
                      items: [
                        'Your data is encrypted and securely stored',
                        'Information is shared only with your insurance provider',
                        'You can request data deletion at any time',
                      ],
                    ),
                    SizedBox(height: 24.h),
                    _buildViewFullTermsButton(),
                    SizedBox(height: 16.h),
                    _buildAcknowledgmentCard(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms & Conditions',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  product.providerName,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.description_outlined,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Terms & Conditions',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'for ${product.name}',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            product.providerName,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverageBenefitsSection() {
    if (product.benefits.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Coverage Benefits',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          ...product.benefits.map(
            (benefit) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: const Color(0xFF10B981),
                      size: 14.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      benefit,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<String> items,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h),
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewFullTermsButton() {
    return GestureDetector(
      onTap: () async {
        if (product.termsUrl.isEmpty) {
          Get.snackbar(
            'Unavailable',
            'Terms URL not available',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF1F1F1F),
            colorText: Colors.white,
            margin: EdgeInsets.all(16.w),
            borderRadius: 12.r,
          );
          return;
        }
        await launchUrl(Uri.parse(product.termsUrl));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.open_in_new,
              color: Colors.white,
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'View Full Provider Terms',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcknowledgmentCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: const Color(0xFFFB923C),
            size: 22.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'By purchasing this policy, you acknowledge that you have read and agree to these terms and conditions.',
              style: GoogleFonts.inter(
                color: const Color(0xFFFB923C),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
