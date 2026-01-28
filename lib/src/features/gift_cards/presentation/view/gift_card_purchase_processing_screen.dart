import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';

/// Processing screen with multi-step progress animation for gift card purchase
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
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start purchase processing
    final args = Get.arguments as Map<String, dynamic>;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GiftCardCubit>().purchaseGiftCard(
            brandId: args['brandId'],
            amount: args['amount'],
            currency: args['currency'],
            brand: args['brand'],
            userBalance: args['userBalance'] ?? 0.0,
            recipientEmail: args['recipientEmail'],
            recipientName: args['recipientName'],
            message: args['message'],
          );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation during processing
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: BlocListener<GiftCardCubit, GiftCardState>(
          listener: (context, state) {
            if (state is GiftCardPurchaseCompleted) {
              // Navigate to confirmation screen
              Get.offNamed(
                '/gift-cards/purchase-confirmation',
                arguments: {
                  'giftCard': state.giftCard,
                  'receiptUrl': state.receiptUrl,
                  'transactionId': state.transactionId,
                },
              );
            } else if (state is GiftCardPurchaseError ||
                state is GiftCardInsufficientFunds ||
                state is GiftCardNetworkError ||
                state is GiftCardSoldOut) {
              // Show error and go back
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

                      // Animated Processing Icon
                      _buildAnimatedIcon(),

                      SizedBox(height: 40.h),

                      // Processing Title
                      Text(
                        'Processing Your Purchase',
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 12.h),

                      // Current Step
                      Text(
                        currentStep,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          color: Colors.grey[400],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 40.h),

                      // Progress Bar
                      _buildProgressBar(progress),

                      SizedBox(height: 40.h),

                      // Step Indicators
                      _buildStepIndicators(progress),

                      const Spacer(),

                      // Security Message
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
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * 2 * 3.14159,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                Icons.card_giftcard,
                size: 60.sp,
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
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6366F1),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            backgroundColor: Colors.grey[800],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
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
            (index == 0 || progress >= (steps[index - 1]['threshold'] as double));

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              // Step Number/Check Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? const Color(0xFF10B981)
                      : isActive
                          ? const Color(0xFF6366F1)
                          : Colors.grey[800],
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : isActive
                            ? const Color(0xFF6366F1)
                            : Colors.grey[700]!,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(
                          Icons.check,
                          size: 18.sp,
                          color: Colors.white,
                        )
                      : isActive
                          ? SizedBox(
                              width: 12.w,
                              height: 12.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              '${index + 1}',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                            ),
                ),
              ),

              SizedBox(width: 12.w),

              // Step Label
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
                            : Colors.grey[600],
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock,
            size: 20.sp,
            color: const Color(0xFF10B981),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Your payment is encrypted and secure',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Colors.grey[400],
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
      message = 'You need \$${state.required.toStringAsFixed(2)} but only have \$${state.available.toStringAsFixed(2)} in your wallet.';
      icon = Icons.account_balance_wallet_outlined;
    } else if (state is GiftCardSoldOut) {
      title = 'Sold Out';
      message = '${state.brandName} gift cards are currently sold out. Please try again later.';
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
            Icon(icon, color: iconColor, size: 28.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
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
            color: Colors.grey[400],
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.back(); // Go back to payment method selection
            },
            child: Text(
              'Go Back',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6366F1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
