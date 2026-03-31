import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SecureWalletScreen extends StatelessWidget {
  const SecureWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Asset Security',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Security Shield Icon
                    Center(
                      child: Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                              const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_user,
                          color: const Color.fromARGB(255, 78, 3, 208),
                          size: 48.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Title
                    Center(
                      child: Text(
                        'Your Assets Are Secure',
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Description
                    Center(
                      child: Text(
                        'LazerVault partners with licensed and regulated crypto providers to ensure the highest level of security for your digital assets.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.white.withValues(alpha: 0.7),
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Security Features
                    _buildSecurityFeature(
                      Icons.shield,
                      'Licensed Custody',
                      'Your crypto assets are held by our licensed partner Quidax, a regulated digital asset exchange.',
                    ),
                    SizedBox(height: 16.h),
                    _buildSecurityFeature(
                      Icons.lock,
                      'No Key Management Needed',
                      'As a distributor, LazerVault handles all the complexity. No seed phrases, no private keys to worry about.',
                    ),
                    SizedBox(height: 16.h),
                    _buildSecurityFeature(
                      Icons.account_balance,
                      'Segregated Accounts',
                      'Each user has a dedicated sub-account with our provider, ensuring complete fund segregation.',
                    ),
                    SizedBox(height: 16.h),
                    _buildSecurityFeature(
                      Icons.security,
                      'Transaction PIN',
                      'Every buy and sell transaction requires your personal transaction PIN for authorization.',
                    ),
                    SizedBox(height: 16.h),
                    _buildSecurityFeature(
                      Icons.sync_lock,
                      'Fund Protection',
                      'All transactions use fund holds and multi-step verification to prevent unauthorized access.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityFeature(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: const Color.fromARGB(255, 78, 3, 208), size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
