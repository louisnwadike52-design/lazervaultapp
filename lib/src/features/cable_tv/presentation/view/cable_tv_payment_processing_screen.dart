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

class CableTVPaymentProcessingScreen extends StatefulWidget {
  const CableTVPaymentProcessingScreen({super.key});

  @override
  State<CableTVPaymentProcessingScreen> createState() =>
      _CableTVPaymentProcessingScreenState();
}

class _CableTVPaymentProcessingScreenState
    extends State<CableTVPaymentProcessingScreen> {
  bool _paymentTriggered = false;

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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Get.snackbar(
            'Payment in Progress',
            'Please wait while your payment is being processed.',
            backgroundColor: const Color(0xFFFB923C),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: BlocListener<CableTVCubit, CableTVState>(
            listener: (context, state) {
              if (state is CableTVPaymentSuccess) {
                Get.offNamed(
                  AppRoutes.cableTVPaymentReceipt,
                  arguments: {'payment': state.payment},
                );
              } else if (state is CableTVPaymentFailed) {
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
                Get.back();
              } else if (state is CableTVError) {
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
                Get.back();
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
                        // Animated progress circle
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
                                  value: progress,
                                  strokeWidth: 6,
                                  backgroundColor: const Color(0xFF2D2D2D),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF3B82F6),
                                  ),
                                ),
                              ),
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

                        // Step text
                        Text(
                          stepText,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),

                        Text(
                          'Please do not close this screen',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40.h),

                        // Subtle loading dots
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
