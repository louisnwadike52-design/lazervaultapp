import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:math' as math;
import '../../domain/entities/user_tag_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';

class TagPayProcessingScreen extends StatefulWidget {
  const TagPayProcessingScreen({super.key});

  @override
  State<TagPayProcessingScreen> createState() => _TagPayProcessingScreenState();
}

class _TagPayProcessingScreenState extends State<TagPayProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _fadeController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _contentScaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // Trigger payment after a short delay to allow UI to settle
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        final args = Get.arguments as Map<String, dynamic>;
        final String tagId = args['tag'].id;
        final String accountId = args['accountId'];
        final String? transactionPin = args['transactionPin'];

        print('🚀 [ProcessingScreen] Triggering payment in initState - tagId: $tagId, accountId: $accountId');
        context.read<TagPayCubit>().payTag(
          tagId: tagId,
          sourceAccountId: accountId,
          transactionPin: transactionPin,
        );
      }
    });
  }

  void _setupAnimations() {
    // Tag pulsing animation (existing)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Fade and slide animation for content
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _contentScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.elasticOut),
    );

    // Rotation animation for outer ring
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _controller.repeat(reverse: true);
    _rotationController.repeat();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final UserTagEntity tag = args['tag'];

    return BlocListener<TagPayCubit, TagPayState>(
      listener: (context, state) {
        print('🎯 [ProcessingScreen] State changed: ${state.runtimeType}');
        if (state is TagPaidSuccess) {
          print('✅ [ProcessingScreen] Payment successful, navigating to receipt');
          // Navigate to receipt screen
          Get.offNamed(
            AppRoutes.tagPaymentReceipt,
            arguments: {
              'transaction': state.transaction,
              'tag': tag,
            },
          );
        } else if (state is TagPayError) {
          print('❌ [ProcessingScreen] Payment error: ${state.message}');
          // Show error and go back
          Get.back();
          Get.snackbar(
            'Payment Failed',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F23),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A3E),
                const Color(0xFF0F0F23),
                const Color(0xFF0A0A1A),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(tag),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: ScaleTransition(
                            scale: _contentScaleAnimation,
                            child: _buildProcessingContent(tag),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(UserTagEntity tag) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Processing Payment...',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Please wait while we process your tag payment',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingContent(UserTagEntity tag) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _buildProcessingAnimation(),
          SizedBox(height: 40.h),
          Text(
            'Processing your tag payment...',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            'Sending ${tag.currency} ${tag.amount.toStringAsFixed(2)} to ${tag.taggerTagPay.isNotEmpty ? '@${tag.taggerTagPay}' : tag.taggerName.isNotEmpty ? tag.taggerName : 'recipient'}',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          _buildPaymentDetails(tag),
          SizedBox(height: 40.h),
          _buildProgressIndicator(),
          const Spacer(),
          _buildSecurityMessage(),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildProcessingAnimation() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Rotating outer ring
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 2 * math.pi,
              child: Container(
                width: 140.w,
                height: 140.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                    width: 3,
                  ),
                ),
                child: CustomPaint(
                  painter: _ArcPainter(),
                ),
              ),
            );
          },
        ),
        // Pulsing tag icon (existing animation)
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF3B82F6).withValues(alpha: 0.2),
                        const Color(0xFF3B82F6).withValues(alpha: 0.1),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.tag,
                      color: const Color(0xFF3B82F6),
                      size: 50.sp,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 48.w),
      child: Column(
        children: [
          LinearProgressIndicator(
            backgroundColor: Colors.grey[800],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            minHeight: 4.h,
          ),
          SizedBox(height: 16.h),
          Text(
            'This may take a few moments',
            style: GoogleFonts.inter(
              color: Colors.grey[500],
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityMessage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security,
            color: Colors.green[400],
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Your payment is secured with bank-level encryption',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(UserTagEntity tag) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow('Amount', '${tag.currency} ${tag.amount.toStringAsFixed(2)}'),
          SizedBox(height: 12.h),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 12.h),
          _buildDetailRow('To', tag.taggerName.isNotEmpty ? tag.taggerName : 'Unknown'),
          SizedBox(height: 12.h),
          if (tag.taggerTagPay.isNotEmpty)
            _buildDetailRow('Tag', '@${tag.taggerTagPay}'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Custom painter for rotating arc
class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw arc (quarter circle)
    canvas.drawArc(
      rect,
      -math.pi / 2, // Start from top
      math.pi / 2,  // Draw quarter circle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
