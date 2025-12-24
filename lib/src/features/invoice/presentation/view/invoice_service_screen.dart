import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';

/// Consolidated invoice service screen that allows users to choose between
/// generating invoices or paying invoices
class InvoiceServiceScreen extends StatefulWidget {
  const InvoiceServiceScreen({super.key});

  @override
  State<InvoiceServiceScreen> createState() => _InvoiceServiceScreenState();
}

class _InvoiceServiceScreenState extends State<InvoiceServiceScreen> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.05),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: const Color(0xFF1A1D1F),
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Invoice Services',
          style: GoogleFonts.inter(
            color: const Color(0xFF1A1D1F),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                'What would you like to do?',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1D1F),
                  height: 1.3,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Choose from the options below to get started',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6F767E),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 32.h),

              // Service Options
              Expanded(
                child: ListView(
                  children: [
                    _buildServiceOption(
                      index: 0,
                      icon: Icons.receipt_long_outlined,
                      title: 'Generate Invoice',
                      description: 'Create and send invoices to your clients or customers',
                      gradientColors: [
                        const Color(0xFF3B82F6),
                        const Color(0xFF1E3A8A),
                      ],
                      onTap: () => Get.toNamed(AppRoutes.createInvoice),
                    ),
                    SizedBox(height: 16.h),
                    _buildServiceOption(
                      index: 1,
                      icon: Icons.payment_outlined,
                      title: 'Pay Invoice',
                      description: 'View and pay invoices that have been sent to you',
                      gradientColors: [
                        const Color(0xFF10B981),
                        const Color(0xFF059669),
                      ],
                      onTap: () => Get.toNamed(AppRoutes.payInvoice),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceOption({
    required int index,
    required IconData icon,
    required String title,
    required String description,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    final isHovered = _hoveredIndex == index;

    return GestureDetector(
      onTap: onTap,
      onTapDown: (_) => setState(() => _hoveredIndex = index),
      onTapUp: (_) => setState(() => _hoveredIndex = null),
      onTapCancel: () => setState(() => _hoveredIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isHovered
                ? gradientColors[0].withOpacity(0.3)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? gradientColors[0].withOpacity(0.2)
                  : Colors.black.withOpacity(0.04),
              blurRadius: isHovered ? 16 : 8,
              offset: Offset(0, isHovered ? 6 : 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isHovered
                      ? gradientColors
                      : [
                          gradientColors[0].withOpacity(0.1),
                          gradientColors[1].withOpacity(0.1),
                        ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: isHovered ? Colors.white : gradientColors[0],
                size: 28.sp,
              ),
            ),
            SizedBox(width: 16.w),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1D1F),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6F767E),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: isHovered ? 0 : 0,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18.sp,
                color: isHovered ? gradientColors[0] : const Color(0xFF9A9FA5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
