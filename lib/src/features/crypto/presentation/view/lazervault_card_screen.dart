import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LazerVaultCardScreen extends StatelessWidget {
  const LazerVaultCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
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
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'LazerVault Card',
                    style: GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.credit_card, color: const Color.fromARGB(255, 78, 3, 208), size: 40.sp),
                      ),
                      SizedBox(height: 24.h),
                      Text('Coming Soon', style: GoogleFonts.inter(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 8.h),
                      Text(
                        'Spend your crypto anywhere',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.white.withValues(alpha: 0.6)),
                      ),
                      SizedBox(height: 32.h),
                      for (final f in [
                        'Virtual and physical crypto debit card',
                        'Spend crypto at any merchant worldwide',
                        'Auto-convert crypto to fiat at point of sale',
                        'Cashback rewards in crypto',
                        'Real-time spending notifications',
                      ])
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_outline, color: const Color.fromARGB(255, 78, 3, 208), size: 18.sp),
                              SizedBox(width: 10.w),
                              Expanded(child: Text(f, style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white.withValues(alpha: 0.7)))),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
