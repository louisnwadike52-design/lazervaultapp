import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../controllers/exchange_controller.dart';
import 'exchange_receipt_screen.dart';

class ExchangeProcessingScreen extends StatefulWidget {
  const ExchangeProcessingScreen({super.key});

  @override
  State<ExchangeProcessingScreen> createState() =>
      _ExchangeProcessingScreenState();
}

class _ExchangeProcessingScreenState extends State<ExchangeProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _processingController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _simulateProcessing();
  }

  void _setupAnimations() {
    _processingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _processingController, curve: Curves.linear),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _processingController, curve: Curves.elasticOut),
    );

    _processingController.repeat();
  }

  void _simulateProcessing() async {
    // Simulate processing time - in real implementation,
    // this would poll the transaction status
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      _processingController.stop();

      // Navigate to receipt screen
      Get.off(() => const ExchangeReceiptScreen());
    }
  }

  @override
  void dispose() {
    _processingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: GetX<ExchangeController>(
          builder: (controller) {
            return Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: _buildProcessingContent(controller),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Processing Transfer...',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Please wait while we process your transfer',
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingContent(ExchangeController controller) {
    return Center(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Processing Animation
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 2 * 3.14159,
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.sync,
                      color: Colors.white,
                      size: 50.sp,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40.h),

            // Processing Text
            Text(
              'Processing your transfer...',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            // Transfer Details
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Text(
                    'Sending ${controller.fromCurrency.value?.symbol}${controller.amount.value.toStringAsFixed(2)} to',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    controller.selectedRecipient.value?.name ?? 'Recipient',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // Progress Indicator
            Container(
              margin: EdgeInsets.symmetric(horizontal: 48.w),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    backgroundColor: const Color(0xFF2D2D2D),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    minHeight: 4.h,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'This may take a few moments',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 60.h),

            // Security Message
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: const Color(0xFF10B981),
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Your transfer is secured with bank-level encryption',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
