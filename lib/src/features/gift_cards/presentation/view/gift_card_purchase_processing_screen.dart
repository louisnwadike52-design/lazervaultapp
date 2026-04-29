import 'package:flutter/material.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../../../core/types/app_routes.dart';
import 'widgets/gift_card_error_widget.dart';

class GiftCardPurchaseProcessingScreen extends StatefulWidget {
  final GiftCardPurchaseArgs purchaseArgs;

  const GiftCardPurchaseProcessingScreen({
    super.key,
    required this.purchaseArgs,
  });

  @override
  State<GiftCardPurchaseProcessingScreen> createState() =>
      _GiftCardPurchaseProcessingScreenState();
}

class _GiftCardPurchaseProcessingScreenState
    extends State<GiftCardPurchaseProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _purchaseStarted = false;
  bool _hasError = false;
  String _errorTitle = '';
  String _errorMessage = '';
  IconData _errorIcon = Icons.error_outline;
  Color _errorIconColor = const Color(0xFFEF4444);

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

  void _startPurchase(BuildContext context) {
    if (_purchaseStarted) return;
    _purchaseStarted = true;

    final args = widget.purchaseArgs;
    context.read<GiftCardCubit>().purchaseGiftCardWithToken(
      brandId: args.brand.id,
      amount: args.amount,
      brand: args.brand,
      userBalance: args.userBalance,
      transactionId: args.transactionId,
      verificationToken: args.verificationToken,
      productId: args.productId,
      countryCode: args.countryCode,
      providerName: args.providerName,
      senderAmount: args.senderAmount,
      senderCurrency: args.senderCurrency,
    );
  }

  void _retryPurchase() {
    setState(() {
      _hasError = false;
      _purchaseStarted = false;
    });
    _animationController.repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startPurchase(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Start the purchase after the first frame so the cubit is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startPurchase(context);
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: BlocListener<GiftCardCubit, GiftCardState>(
          listener: (context, state) {
            if (state is GiftCardPurchaseCompleted) {
              _animationController.stop();
              Get.offNamed(
                AppRoutes.giftCardDetails,
                arguments: state.giftCard,
              );
            } else if (state is GiftCardPurchaseError ||
                state is GiftCardInsufficientFunds ||
                state is GiftCardNetworkError ||
                state is GiftCardSoldOut ||
                state is GiftCardTimeoutError ||
                state is GiftCardServerUnavailable ||
                state is GiftCardValidationError ||
                state is GiftCardNotFound) {
              _animationController.stop();
              _setErrorState(state);
            }
          },
          child: BlocBuilder<GiftCardCubit, GiftCardState>(
            builder: (context, state) {
              if (_hasError) return _buildErrorView();

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
            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
          ),
          child: Center(
            child: Container(
              width: 72.w,
              height: 72.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: InvoiceThemeColors.primaryPurple,
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
                color: InvoiceThemeColors.primaryPurple,
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
                const AlwaysStoppedAnimation<Color>(InvoiceThemeColors.primaryPurple),
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
                          ? InvoiceThemeColors.primaryPurple
                          : const Color(0xFF1F1F1F),
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : isActive
                            ? InvoiceThemeColors.primaryPurple
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

  void _setErrorState(GiftCardState state) {
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
      message = friendlyGiftCardError(state.message);
      icon = Icons.wifi_off;
    } else if (state is GiftCardTimeoutError) {
      title = 'Request Timed Out';
      message =
          'The purchase request timed out. Your funds have not been charged. Please try again.';
      icon = Icons.timer_off_outlined;
      iconColor = const Color(0xFFFB923C);
    } else if (state is GiftCardServerUnavailable) {
      title = 'Service Unavailable';
      message =
          'The gift card service is temporarily unavailable. Please try again in a few moments.';
      icon = Icons.cloud_off_outlined;
      iconColor = const Color(0xFFFB923C);
    } else if (state is GiftCardValidationError) {
      title = 'Validation Error';
      message = friendlyGiftCardError(state.message);
      icon = Icons.warning_amber_rounded;
      iconColor = const Color(0xFFFB923C);
    } else if (state is GiftCardNotFound) {
      title = 'Not Found';
      message = 'The gift card brand could not be found. It may have been removed from the catalog.';
      icon = Icons.search_off_rounded;
    } else if (state is GiftCardPurchaseError) {
      message = friendlyGiftCardError(state.message);
    }

    setState(() {
      _hasError = true;
      _errorTitle = title;
      _errorMessage = message;
      _errorIcon = icon;
      _errorIconColor = iconColor;
    });
  }

  Widget _buildErrorView() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _errorIconColor.withValues(alpha: 0.1),
              ),
              child: Center(
                child: Icon(
                  _errorIcon,
                  size: 48.sp,
                  color: _errorIconColor,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              _errorTitle,
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              _errorMessage,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: _retryPurchase,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [InvoiceThemeColors.primaryPurple, Color(0xFF6366F1)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Center(
                    child: Text(
                      'Try Again',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Get.offAllNamed(AppRoutes.giftCards),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'Back to Gift Cards',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
