import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_state.dart';

/// Cable TV payment processing screen. Mirrors the internet/data
/// processing pattern:
///
///   * Circular + step-text progress while the cubit emits
///     `CableTVPaymentProcessing` frames.
///   * On success: navigate to receipt with the full save/auto-renew
///     payload so the receipt screen's `_runPostPurchaseActions` can
///     do its thing.
///   * On failure: latch into the failed state — do NOT auto-pop. The
///     user sees a red error pill + "Back to Cable TV" button that
///     routes to the landing. Hardware back on failure also routes to
///     the landing (consistent with the visible button).
class CableTVPaymentProcessingScreen extends StatefulWidget {
  const CableTVPaymentProcessingScreen({super.key});

  @override
  State<CableTVPaymentProcessingScreen> createState() =>
      _CableTVPaymentProcessingScreenState();
}

class _CableTVPaymentProcessingScreenState
    extends State<CableTVPaymentProcessingScreen> {
  bool _paymentTriggered = false;
  bool _popAllowed = false;
  bool _hasFailed = false;
  String _failMessage = '';
  // Latches the first terminal transition so a late-arriving duplicate
  // state from the cubit (or a reconciler-driven success that fires
  // after a local failure) can't double-navigate or flip the UI.
  bool _terminalReached = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerPayment();
    });
  }

  void _triggerPayment() {
    if (_paymentTriggered) return;
    _paymentTriggered = true;

    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) {
      Get.back();
      return;
    }

    try {
      final provider = args['provider'] as CableTVProviderEntity;
      final package = args['package'] as TVPackageEntity;
      final smartCardNumber = args['smartCardNumber'] as String;
      final transactionId = args['transactionId'] as String;
      final verificationToken = args['verificationToken'] as String;
      final idempotencyKey = args['idempotencyKey'] as String;

      context.read<CableTVCubit>().paySubscription(
            providerId: provider.serviceId,
            smartCardNumber: smartCardNumber,
            variationCode: package.variationCode,
            amount: package.amount,
            phone: smartCardNumber,
            transactionId: transactionId,
            verificationToken: verificationToken,
            idempotencyKey: idempotencyKey,
          );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _popAllowed = true;
        _hasFailed = true;
        _failMessage = 'Could not start payment: $e';
      });
    }
  }

  /// Forward everything the confirmation screen handed us plus the
  /// resolved `payment` so the receipt screen can run post-purchase
  /// actions (save beneficiary, create auto-renew) with the full
  /// context.
  void _navigateToReceipt(dynamic payment) {
    if (!mounted) return;
    setState(() => _popAllowed = true);
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    Get.offNamed(
      AppRoutes.cableTVPaymentReceipt,
      arguments: {
        'payment': payment,
        'provider': args['provider'],
        'package': args['package'],
        'smartCardNumber': args['smartCardNumber'],
        'saveBeneficiary': args['saveBeneficiary'] ?? false,
        'beneficiaryNickname': args['beneficiaryNickname'],
        'autoRenewEnabled': args['autoRenewEnabled'] ?? false,
        'rolloverPref': args['rolloverPref'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _popAllowed && !_hasFailed,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_hasFailed) {
          Get.offAllNamed(AppRoutes.cableTVHome);
          return;
        }
        Get.snackbar(
          'Payment in Progress',
          'Please wait while your payment is being processed.',
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: BlocListener<CableTVCubit, CableTVState>(
            listener: (context, state) {
              if (_terminalReached) return;
              if (state is CableTVPaymentSuccess) {
                _terminalReached = true;
                _navigateToReceipt(state.payment);
              } else if (state is CableTVPaymentFailed) {
                _terminalReached = true;
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                  _popAllowed = true;
                });
                Get.snackbar(
                  'Payment Failed',
                  state.message,
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.9),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 4),
                  snackPosition: SnackPosition.TOP,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12,
                );
              } else if (state is CableTVError) {
                _terminalReached = true;
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                  _popAllowed = true;
                });
                Get.snackbar(
                  'Error',
                  state.message,
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.9),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 4),
                  snackPosition: SnackPosition.TOP,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12,
                );
              }
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: BlocBuilder<CableTVCubit, CableTVState>(
                  builder: (context, state) {
                    double progress = 0.1;
                    String stepText = 'Initializing payment...';

                    if (state is CableTVPaymentProcessing) {
                      progress = state.progress;
                      stepText = state.currentStep;
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120.w,
                          height: 120.w,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 120.w,
                                height: 120.w,
                                child: CircularProgressIndicator(
                                  value: _hasFailed ? 1.0 : progress,
                                  strokeWidth: 6,
                                  backgroundColor: const Color(0xFF2D2D2D),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _hasFailed
                                        ? const Color(0xFFEF4444)
                                        : const Color(0xFF3B82F6),
                                  ),
                                ),
                              ),
                              if (_hasFailed)
                                Icon(Icons.close,
                                    color: const Color(0xFFEF4444),
                                    size: 40.sp)
                              else
                                Text(
                                  '${(progress * 100).toInt()}%',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 36.h),
                        Text(
                          _hasFailed ? 'Payment Failed' : stepText,
                          style: GoogleFonts.inter(
                            color: _hasFailed
                                ? const Color(0xFFEF4444)
                                : Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        if (_hasFailed) ...[
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: const Color(0xFFEF4444)
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              _failMessage.isEmpty
                                  ? 'Something went wrong. Please try again.'
                                  : _failMessage,
                              style: GoogleFonts.inter(
                                color: const Color(0xFFEF4444),
                                fontSize: 13.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          SizedBox(
                            width: double.infinity,
                            height: 52.h,
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  Get.offAllNamed(AppRoutes.cableTVHome),
                              icon: Icon(Icons.arrow_back,
                                  size: 18.sp, color: Colors.white),
                              label: Text(
                                'Back to Cable TV',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B82F6),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          Text(
                            'Please do not close this screen',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 13.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40.h),
                          SizedBox(
                            width: 40.w,
                            child: const LinearProgressIndicator(
                              backgroundColor: Color(0xFF2D2D2D),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF3B82F6),
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
