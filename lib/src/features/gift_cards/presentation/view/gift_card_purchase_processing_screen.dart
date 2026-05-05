import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/services/balance_websocket_service.dart';
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
    extends State<GiftCardPurchaseProcessingScreen> {
  bool _purchaseStarted = false;
  bool _hasError = false;
  String _errorTitle = '';
  String _errorMessage = '';
  IconData _errorIcon = Icons.error_outline;
  Color _errorIconColor = const Color(0xFFEF4444);

  // Async-buy WebSocket plumbing. When the backend returns the row in
  // a non-terminal state, we sit on this screen and wait for a
  // `giftcard_purchase` event with a matching reference, then refetch.
  // No polling timers, no hardcoded delays — backend response time is
  // the only source of truth for processing-screen transitions.
  StreamSubscription<BalanceUpdateEvent>? _balanceSub;
  String? _awaitingReference;
  String? _awaitingGiftCardId;

  @override
  void dispose() {
    _balanceSub?.cancel();
    super.dispose();
  }

  void _ensureBalanceSubscription() {
    if (_balanceSub != null) return;
    try {
      final wsService = GetIt.I<BalanceWebSocketService>();
      _balanceSub = wsService.balanceUpdates.listen(_handleBalanceEvent);
    } catch (_) {
      // Service not registered — pull-to-refresh on the receipt screen
      // is the fallback. The cubit's awaiting state stays mounted.
    }
  }

  void _handleBalanceEvent(BalanceUpdateEvent event) {
    if (!mounted) return;
    final ref = _awaitingReference;
    final gid = _awaitingGiftCardId;
    if (ref == null || gid == null) return;
    if (event.eventType != 'giftcard_purchase') return;
    if (event.reference != ref) return;
    // Terminal event matched — refetch by id; cubit will emit
    // GiftCardPurchaseCompleted (success), GiftCardPurchaseError
    // (refunded/failed), or stay GiftCardPurchaseAwaitingProvider if
    // the backend reports the row hasn't flipped yet (race).
    context.read<GiftCardCubit>().refreshGiftCardDetails(gid);
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
              Get.offNamed(
                AppRoutes.giftCardDetails,
                arguments: state.giftCard,
              );
            } else if (state is GiftCardPurchaseAwaitingProvider) {
              // Async path: backend returned the row but provider hasn't
              // confirmed yet. Subscribe to the balance WebSocket and
              // wait for a giftcard_purchase event matching this ref.
              _awaitingReference = state.reference;
              _awaitingGiftCardId = state.giftCard.id;
              _ensureBalanceSubscription();
            } else if (state is GiftCardPurchaseError ||
                state is GiftCardInsufficientFunds ||
                state is GiftCardNetworkError ||
                state is GiftCardSoldOut ||
                state is GiftCardTimeoutError ||
                state is GiftCardServerUnavailable ||
                state is GiftCardValidationError ||
                state is GiftCardNotFound) {
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
              } else if (state is GiftCardPurchaseAwaitingProvider) {
                // Async path: row exists, provider call still pending.
                // Show steady waiting state until the WebSocket flips us
                // to Completed via _handleBalanceEvent + refresh.
                progress = 0.75;
                currentStep =
                    'Waiting for confirmation from the provider.';
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
    // Plain stock indeterminate spinner — no app-controlled animation
    // duration and no Future.delayed/Timer anywhere on this screen.
    // The framework owns the spinner cadence; the screen's actual
    // visible state changes are driven exclusively by cubit events
    // (which themselves are driven by backend response time).
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
      ),
      child: Center(
        child: SizedBox(
          width: 72.w,
          height: 72.w,
          child: const CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(
              InvoiceThemeColors.primaryPurple,
            ),
          ),
        ),
      ),
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
