import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
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

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final UserTagEntity tag = args['tag'];

    return BlocListener<TagPayCubit, TagPayState>(
      listener: (context, state) {
        if (state is TagPaidSuccess) {
          // Navigate to receipt screen
          Get.offNamed(
            AppRoutes.tagPaymentReceipt,
            arguments: {
              'transaction': state.transaction,
              'tag': tag,
            },
          );
        } else if (state is TagPayError) {
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
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                _buildProcessingAnimation(),
                SizedBox(height: 32.h),
                Text(
                  'Processing Payment',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Please wait while we process your payment',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 32.h),
                _buildPaymentDetails(tag),
                const Spacer(),
                _buildLoadingIndicator(),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.payment,
                  color: const Color(0xFF3B82F6),
                  size: 60.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentDetails(UserTagEntity tag) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Amount', '${tag.currency} ${tag.amount.toStringAsFixed(2)}'),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          _buildDetailRow('To', tag.taggerName),
          SizedBox(height: 12.h),
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
            color: const Color(0xFF9CA3AF),
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

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 40.w,
      height: 40.w,
      child: CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
        strokeWidth: 3,
      ),
    );
  }
}
