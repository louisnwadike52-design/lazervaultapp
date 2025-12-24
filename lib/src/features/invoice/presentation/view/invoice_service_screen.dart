import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';

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
      backgroundColor: InvoiceThemeColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: InvoiceThemeColors.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.secondaryBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: InvoiceThemeColors.textWhite,
              size: 16.sp,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Invoice Services',
          style: InvoiceTextStyles.header20,
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
                style: InvoiceTextStyles.header24,
              ),
              SizedBox(height: 8.h),
              Text(
                'Choose from the options below to get started',
                style: InvoiceTextStyles.body14,
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
                        InvoiceThemeColors.primaryPurple,
                        InvoiceThemeColors.primaryPurple.withOpacity(0.7),
                      ],
                      onTap: () => Get.toNamed(AppRoutes.invoiceList),
                    ),
                    SizedBox(height: 16.h),
                    _buildServiceOption(
                      index: 1,
                      icon: Icons.payment_outlined,
                      title: 'Pay Invoice',
                      description: 'View and pay invoices that have been sent to you',
                      gradientColors: [
                        InvoiceThemeColors.alternativePurple,
                        InvoiceThemeColors.gradientPurple,
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
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isHovered
                ? InvoiceThemeColors.textWhite.withOpacity(0.3)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(isHovered ? 0.4 : 0.2),
              blurRadius: isHovered ? 20 : 10,
              offset: Offset(0, isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.textWhite.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                icon,
                color: InvoiceThemeColors.textWhite,
                size: 32.sp,
              ),
            ),
            SizedBox(width: 20.w),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: InvoiceThemeColors.textWhite,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: InvoiceThemeColors.textWhite.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isHovered ? 1.1 : 1.0,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.textWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18.sp,
                  color: InvoiceThemeColors.textWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
