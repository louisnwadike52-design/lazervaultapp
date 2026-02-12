import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Transition;
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../../../../../core/types/app_routes.dart';
import 'dart:async';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _stepController;
  Timer? _pollingTimer;
  String? _currentPaymentId;
  int _currentStep = 0;
  bool _isComplete = false;
  bool _hasFailed = false;
  bool _hasTimedOut = false;
  String _failMessage = '';
  int _pollCount = 0;
  static const int _maxPollCount = 20; // 20 polls * 3s = 60s timeout

  ElectricityProviderEntity? _provider;
  MeterValidationResult? _validationResult;
  double _amount = 0;
  bool _argsValid = false;

  static const _steps = [
    _ProcessingStep(
      title: 'Payment Initiated',
      subtitle: 'Your payment request has been submitted',
      icon: Icons.receipt_long,
      activeColor: Color(0xFF3B82F6),
    ),
    _ProcessingStep(
      title: 'Verifying Meter',
      subtitle: 'Confirming meter number and customer details',
      icon: Icons.verified_user,
      activeColor: Color(0xFF8B5CF6),
    ),
    _ProcessingStep(
      title: 'Processing Payment',
      subtitle: 'Debiting your account and sending to provider',
      icon: Icons.sync,
      activeColor: Color(0xFFFB923C),
    ),
    _ProcessingStep(
      title: 'Token Generated',
      subtitle: 'Your electricity token is ready',
      icon: Icons.check_circle,
      activeColor: Color(0xFF10B981),
    ),
  ];

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    if (args is Map<String, dynamic> &&
        args['provider'] is ElectricityProviderEntity &&
        args['validationResult'] is MeterValidationResult &&
        args['amount'] is double) {
      _provider = args['provider'] as ElectricityProviderEntity;
      _validationResult = args['validationResult'] as MeterValidationResult;
      _amount = args['amount'] as double;
      _argsValid = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        Get.snackbar(
          'Error',
          'Invalid payment data',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
        );
      });
    }

    _stepController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    // Simulate step progression
    if (_argsValid) {
      _advanceSteps();
    }
  }

  void _advanceSteps() {
    // Step 0 -> 1 after 1.5s
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted || _hasFailed) return;
      setState(() => _currentStep = 1);
    });

    // Step 1 -> 2 after 3s
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted || _hasFailed) return;
      setState(() => _currentStep = 2);
    });
  }

  void _startPolling(String paymentId) {
    if (_currentPaymentId == paymentId) return;
    _currentPaymentId = paymentId;

    // C7: Cancel existing timer before creating a new one
    _pollingTimer?.cancel();
    _pollCount = 0;

    // Poll every 3 seconds for payment verification
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      // C6: Timeout after max polls
      _pollCount++;
      if (_pollCount >= _maxPollCount) {
        timer.cancel();
        if (!mounted) return;
        setState(() {
          _hasTimedOut = true;
          _hasFailed = true;
          _failMessage = 'Payment verification timed out. Check your payment history for the latest status.';
        });
        return;
      }

      context.read<ElectricityBillCubit>().verifyPayment(paymentId: paymentId);
    });
  }

  @override
  void dispose() {
    _stepController.dispose();
    _pollingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_argsValid) {
      return const Scaffold(backgroundColor: Color(0xFF0A0A0A));
    }
    final provider = _provider!;
    final validationResult = _validationResult!;
    final amount = _amount;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && !_hasTimedOut) {
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
          child: BlocListener<ElectricityBillCubit, ElectricityBillState>(
            listener: (context, state) {
              if (state is PaymentInitiated || state is PaymentProcessing) {
                final payment = state is PaymentInitiated
                    ? state.payment
                    : (state as PaymentProcessing).payment;
                _startPolling(payment.id);
              }

              if (state is PaymentSuccess) {
                _pollingTimer?.cancel();
                setState(() {
                  _currentStep = 3;
                  _isComplete = true;
                });

                // Navigate to receipt after brief delay to show completion
                Future.delayed(const Duration(milliseconds: 1200), () {
                  if (!mounted) return;
                  Get.offNamed(
                    AppRoutes.electricityBillReceipt,
                    arguments: {'payment': state.payment},
                  );
                });
              }

              if (state is PaymentFailed) {
                _pollingTimer?.cancel();
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.errorMessage;
                });

                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) {
                    Get.back();
                    Get.back();
                  }
                });
              }

              if (state is ElectricityBillError) {
                _pollingTimer?.cancel();
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  _buildStepIndicators(),
                  SizedBox(height: 40.h),
                  _buildPaymentSummary(provider, validationResult, amount),
                  const Spacer(flex: 2),
                  if (_hasFailed) _buildFailureInfo(),
                  if (!_hasFailed && !_isComplete) _buildSecurityNote(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicators() {
    return Column(
      children: List.generate(_steps.length, (index) {
        final step = _steps[index];
        final isCompleted = index < _currentStep;
        final isActive = index == _currentStep && !_isComplete;
        final isFinalComplete = _isComplete && index == 3;
        final isFailed = _hasFailed && index == _currentStep;

        return Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Row(
                children: [
                  // Step circle
                  AnimatedBuilder(
                    animation: _stepController,
                    builder: (context, child) {
                      final scale =
                          isActive ? 1.0 + (_stepController.value * 0.1) : 1.0;
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFailed
                                ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                                : isCompleted || isFinalComplete
                                    ? step.activeColor.withValues(alpha: 0.15)
                                    : isActive
                                        ? step.activeColor
                                            .withValues(alpha: 0.15)
                                        : const Color(0xFF1F1F1F),
                            border: Border.all(
                              color: isFailed
                                  ? const Color(0xFFEF4444)
                                  : isCompleted || isFinalComplete
                                      ? step.activeColor
                                      : isActive
                                          ? step.activeColor
                                          : const Color(0xFF2D2D2D),
                              width: isActive ? 2 : 1.5,
                            ),
                          ),
                          child: Icon(
                            isFailed
                                ? Icons.close
                                : isCompleted || isFinalComplete
                                    ? Icons.check
                                    : step.icon,
                            color: isFailed
                                ? const Color(0xFFEF4444)
                                : isCompleted || isFinalComplete
                                    ? step.activeColor
                                    : isActive
                                        ? step.activeColor
                                        : const Color(0xFF6B7280),
                            size: 22.sp,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 16.w),
                  // Step text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: GoogleFonts.inter(
                            color: isFailed
                                ? const Color(0xFFEF4444)
                                : isCompleted || isActive || isFinalComplete
                                    ? Colors.white
                                    : const Color(0xFF6B7280),
                            fontSize: 15.sp,
                            fontWeight: isActive || isFinalComplete
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          isFailed ? _failMessage : step.subtitle,
                          style: GoogleFonts.inter(
                            color: isFailed
                                ? const Color(0xFFEF4444).withValues(alpha: 0.8)
                                : isCompleted || isActive || isFinalComplete
                                    ? const Color(0xFF9CA3AF)
                                    : const Color(0xFF4B5563),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status indicator
                  if (isActive && !_hasFailed)
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(step.activeColor),
                      ),
                    ),
                  if (isCompleted || isFinalComplete)
                    Icon(
                      Icons.check_circle,
                      color: step.activeColor,
                      size: 20.sp,
                    ),
                ],
              ),
              // Connector line
              if (index < _steps.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 23.w),
                  child: Container(
                    width: 2,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? step.activeColor.withValues(alpha: 0.4)
                          : const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPaymentSummary(
    ElectricityProviderEntity provider,
    MeterValidationResult validationResult,
    double amount,
  ) {
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
          _buildSummaryRow('Provider', provider.providerName),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          _buildSummaryRow('Customer', validationResult.customerName),
          SizedBox(height: 12.h),
          _buildSummaryRow('Meter', validationResult.meterNumber),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            'Amount',
            '\u20A6${amount.toStringAsFixed(2)}',
            valueColor: const Color(0xFF10B981),
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: isBold ? 16.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFailureInfo() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFFEF4444).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: const Color(0xFFEF4444),
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  _hasTimedOut ? _failMessage : 'Payment failed. Redirecting back...',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_hasTimedOut) ...[
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.electricityBillHome),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Go to History',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 16.sp,
            color: const Color(0xFF3B82F6),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Your payment is secured with end-to-end encryption',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessingStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color activeColor;

  const _ProcessingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.activeColor,
  });
}
