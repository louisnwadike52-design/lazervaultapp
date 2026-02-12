import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

class BillsHubScreen extends StatelessWidget {
  const BillsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Pay Bills',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a bill type',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 16.h),
              _BillTile(
                icon: Icons.electric_bolt,
                title: 'Electricity',
                description: 'Buy prepaid tokens or pay postpaid bills',
                onTap: () => Get.toNamed(AppRoutes.electricityBillHome),
              ),
              SizedBox(height: 12.h),
              _BillTile(
                icon: Icons.tv,
                title: 'Cable TV',
                description: 'Subscribe to DStv, GOtv, Startimes & more',
                onTap: () => Get.toNamed(AppRoutes.cableTVHome),
              ),
              SizedBox(height: 12.h),
              _BillTile(
                icon: Icons.school,
                title: 'Education PINs',
                description: 'Buy WAEC, NECO & JAMB exam PINs',
                onTap: () => Get.toNamed(AppRoutes.educationHome),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BillTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _BillTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF3B82F6),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF9CA3AF),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
