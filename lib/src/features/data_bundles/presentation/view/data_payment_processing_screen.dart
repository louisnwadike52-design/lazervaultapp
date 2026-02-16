import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../cubit/data_bundles_cubit.dart';
import '../cubit/data_bundles_state.dart';

class DataPaymentProcessingScreen extends StatefulWidget {
  const DataPaymentProcessingScreen({super.key});

  @override
  State<DataPaymentProcessingScreen> createState() =>
      _DataPaymentProcessingScreenState();
}

class _DataPaymentProcessingScreenState
    extends State<DataPaymentProcessingScreen> {
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

    final plan = args['plan'] as DataPlanEntity;
    final network = args['network'] as String;
    final phoneNumber = args['phoneNumber'] as String;
    final transactionId = args['transactionId'] as String;
    final verificationToken = args['verificationToken'] as String;
    final idempotencyKey = args['idempotencyKey'] as String;

    context.read<DataBundlesCubit>().buyData(
          phoneNumber: phoneNumber,
          network: network,
          variationId: plan.variationId,
          amount: plan.price,
          transactionId: transactionId,
          verificationToken: verificationToken,
          idempotencyKey: idempotencyKey,
        );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final networkName = args?['networkName'] as String? ?? '';
    final planName = (args?['plan'] as DataPlanEntity?)?.name ?? '';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Get.snackbar(
            'Payment in Progress',
            'Please wait while your data purchase is being processed.',
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
          child: BlocListener<DataBundlesCubit, DataBundlesState>(
            listener: (context, state) {
              if (state is DataBundlesPaymentSuccess) {
                Get.offNamed(
                  AppRoutes.dataBundlesPaymentReceipt,
                  arguments: {
                    'purchase': state.purchase,
                    'networkName': networkName,
                    'planName': planName,
                  },
                );
              } else if (state is DataBundlesPaymentFailed) {
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
              } else if (state is DataBundlesError) {
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
                child: BlocBuilder<DataBundlesCubit, DataBundlesState>(
                  builder: (context, state) {
                    double progress = 0.1;
                    String stepText = 'Initializing payment...';

                    if (state is DataBundlesPaymentProcessing) {
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

                        // Subtle loading bar
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
