import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../../../../core/types/app_routes.dart';

class GiftCardPurchaseProcessingScreen extends StatefulWidget {
  const GiftCardPurchaseProcessingScreen({super.key});

  @override
  State<GiftCardPurchaseProcessingScreen> createState() =>
      _GiftCardPurchaseProcessingScreenState();
}

class _GiftCardPurchaseProcessingScreenState
    extends State<GiftCardPurchaseProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: BlocListener<GiftCardCubit, GiftCardState>(
          listener: (context, state) {
            if (state is GiftCardPurchaseCompleted) {
              Get.offNamed(
                AppRoutes.giftCardDetails,
                arguments: state.giftCard,
              );
            } else if (state is GiftCardPurchaseError ||
                state is GiftCardInsufficientFunds ||
                state is GiftCardNetworkError ||
                state is GiftCardSoldOut) {
              _showErrorDialog(state);
            }
          },
          child: BlocBuilder<GiftCardCubit, GiftCardState>(
            builder: (context, state) {
              double progress = 0.0;
              String currentStep = 'Initializing...';

              if (state is GiftCardPurchaseProcessing) {
                progress = state.progress;
                currentStep = state.currentStep;
              }

              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 60.h),
                      _buildAnimatedIcon(),
                      SizedBox(height: 40.h),
                      Text(
                        'Processing Your Purchase',
                        style: GoogleFonts.inter(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        currentStep,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
                      _buildProgressBar(progress),
                      SizedBox(height: 40.h),
                      _buildStepIndicators(progress),
                      const Spacer(),
                      _buildSecurityMessage(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
          ),
          child: Center(
            child: Container(
              width: 72.w,
              height: 72.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF3B82F6),
              ),
              child: Icon(
                Icons.card_giftcard,
                size: 36.sp,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3B82F6),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6.h,
            backgroundColor: const Color(0xFF1F1F1F),
            valueColor:
                const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
        ),
      ],
    );
  }

  Widget _buildStepIndicators(double progress) {
    final steps = [
      {'label': 'Initializing', 'threshold': 0.1},
      {'label': 'Validating', 'threshold': 0.3},
      {'label': 'Processing', 'threshold': 0.6},
      {'label': 'Generating', 'threshold': 0.9},
      {'label': 'Completing', 'threshold': 1.0},
    ];

    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isCompleted = progress >= (step['threshold'] as double);
        final isActive = !isCompleted &&
            (index == 0 ||
                progress >= (steps[index - 1]['threshold'] as double));

        return Padding(
          padding: EdgeInsets.only(bottom: 14.h),
          child: Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? const Color(0xFF10B981)
                      : isActive
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF1F1F1F),
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : isActive
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF2D2D2D),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                      : isActive
                          ? SizedBox(
                              width: 12.w,
                              height: 12.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            )
                          : Text(
                              '${index + 1}',
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  step['label'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: isActive || isCompleted
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : isActive
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSecurityMessage() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock,
            size: 18.sp,
            color: const Color(0xFF10B981),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Your payment is encrypted and secure',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(GiftCardState state) {
    String title = 'Purchase Failed';
    String message = 'An error occurred while processing your purchase.';
    IconData icon = Icons.error_outline;
    Color iconColor = const Color(0xFFEF4444);

    if (state is GiftCardInsufficientFunds) {
      title = 'Insufficient Funds';
      message =
          'You need ${state.required.toStringAsFixed(2)} but only have ${state.available.toStringAsFixed(2)} in your wallet.';
      icon = Icons.account_balance_wallet_outlined;
    } else if (state is GiftCardSoldOut) {
      title = 'Sold Out';
      message =
          '${state.brandName} gift cards are currently sold out. Please try again later.';
      icon = Icons.inventory_2_outlined;
    } else if (state is GiftCardNetworkError) {
      title = 'Network Error';
      message = state.message;
      icon = Icons.wifi_off;
    } else if (state is GiftCardPurchaseError) {
      message = state.message;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(icon, color: iconColor, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.back();
            },
            child: Text(
              'Go Back',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
