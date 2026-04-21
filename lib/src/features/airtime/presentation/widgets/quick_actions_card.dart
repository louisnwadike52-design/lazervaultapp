import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/country.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Invoice purple for both CTAs — matches the invoice theme the
          // International & Sell tabs use so the whole airtime landing
          // reads as one palette. Slightly lighter secondary shade on the
          // Send tile keeps them visually distinct without reintroducing a
          // second hue.
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.phone_android,
                  title: 'Buy Airtime',
                  subtitle: 'Top up your phone',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4E03D0), Color(0xFF3B0A99)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {'country': DefaultCountries.nigeria, 'isBuyForSelf': true}),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: _buildActionButton(
                  icon: Icons.send,
                  title: 'Send Airtime',
                  subtitle: 'Gift to others',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6D28D9), Color(0xFF4E03D0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () => Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {'country': DefaultCountries.nigeria, 'isBuyForSelf': false}),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            
            SizedBox(height: 12.h),
            
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: 4.h),
            
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 