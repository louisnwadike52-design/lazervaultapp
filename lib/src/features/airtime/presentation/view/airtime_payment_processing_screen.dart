import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../../../../core/types/app_routes.dart';

class AirtimePaymentProcessingScreen extends StatefulWidget {
  const AirtimePaymentProcessingScreen({super.key});

  @override
  State<AirtimePaymentProcessingScreen> createState() =>
      _AirtimePaymentProcessingScreenState();
}

class _AirtimePaymentProcessingScreenState
    extends State<AirtimePaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _stepController;
  bool _hasFailed = false;
  bool _hasNavigated = false;
  String _failMessage = '';
  bool _argsValid = false;

  // Payment display params
  String? _providerName;
  String? _phoneNumber;
  double _amount = 0;
  String _currency = 'NGN';

  // Payment execution params
  String? _countryCode;
  String? _networkProviderId;
  String? _transactionId;
  String? _verificationToken;
  String? _sourceAccountId;
  String? _operatorId;
  String? _reloadlyOperatorId;

  // Step tracking synced to cubit states
  int _currentStep = 0;

  static const _steps = [
    _ProcessingStep(
      title: 'Payment Initiated',
      subtitle: 'Your airtime request has been submitted',
      icon: Icons.receipt_long,
      activeColor: Color(0xFF3B82F6),
    ),
    _ProcessingStep(
      title: 'Confirming Details',
      subtitle: 'Validating payment and account details',
      icon: Icons.verified_user,
      activeColor: Color.fromARGB(255, 78, 3, 208),
    ),
    _ProcessingStep(
      title: 'Processing Payment',
      subtitle: 'Debiting your account and contacting provider',
      icon: Icons.sync,
      activeColor: Color(0xFFFB923C),
    ),
    _ProcessingStep(
      title: 'Airtime Delivered',
      subtitle: 'Your airtime top-up is complete',
      icon: Icons.check_circle,
      activeColor: Color(0xFF10B981),
    ),
  ];

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    if (args is Map<String, dynamic> &&
        args['countryCode'] is String &&
        args['networkProviderId'] is String &&
        args['phoneNumber'] is String &&
        args['amount'] is double &&
        args['currency'] is String &&
        args['transactionId'] is String &&
        args['verificationToken'] is String) {
      _countryCode = args['countryCode'] as String;
      _networkProviderId = args['networkProviderId'] as String;
      _phoneNumber = args['phoneNumber'] as String;
      _amount = args['amount'] as double;
      _currency = args['currency'] as String;
      _transactionId = args['transactionId'] as String;
      _verificationToken = args['verificationToken'] as String;
      _sourceAccountId = args['sourceAccountId'] as String?;
      _operatorId = args['operatorId'] as String?;
      _reloadlyOperatorId = args['reloadlyOperatorId'] as String?;
      _providerName = args['providerName'] as String? ?? 'Network Provider';
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

    if (_argsValid) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<AirtimeCubit>().processPaymentWithToken(
              countryCode: _countryCode!,
              networkProviderId: _networkProviderId!,
              phoneNumber: _phoneNumber!,
              amount: _amount,
              currency: _currency,
              transactionId: _transactionId!,
              verificationToken: _verificationToken!,
              sourceAccountId: _sourceAccountId,
              operatorId: _operatorId,
              reloadlyOperatorId: _reloadlyOperatorId,
            );
      });
    }
  }

  int _stepIndexFromLabel(String label) {
    switch (label) {
      case 'Payment Initiated':
        return 0;
      case 'Confirming Details':
        return 1;
      case 'Processing Payment':
        return 2;
      case 'Airtime Delivered':
        return 3;
      default:
        return _currentStep;
    }
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_argsValid) {
      return const Scaffold(backgroundColor: Color(0xFF0A0A0A));
    }

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
          child: BlocListener<AirtimeCubit, AirtimeState>(
            listener: (context, state) {
              if (_hasNavigated) return;

              if (state is AirtimePaymentProcessing) {
                final step = _stepIndexFromLabel(state.currentStep);
                if (step != _currentStep && mounted) {
                  setState(() => _currentStep = step);
                }
              }

              if (state is AirtimePaymentSuccess) {
                _hasNavigated = true;
                Get.offNamed(
                  AppRoutes.airtimePaymentConfirmation,
                  arguments: {
                    'transaction': state.transaction,
                  },
                );
              }

              if (state is AirtimePaymentFailed) {
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                });

                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted && !_hasNavigated) {
                    _hasNavigated = true;
                    Get.offNamed(
                      AppRoutes.airtimePaymentConfirmation,
                      arguments: {
                        'transaction': state.transaction,
                        'errorMessage': state.message,
                      },
                    );
                  }
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
                  _buildPaymentSummary(),
                  const Spacer(flex: 2),
                  if (_hasFailed) _buildFailureInfo(),
                  if (!_hasFailed) _buildSecurityNote(),
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
        final isActive = index == _currentStep;
        final isFailed = _hasFailed && index == _currentStep;

        return Column(
          children: [
            Row(
              children: [
                // Step circle
                AnimatedBuilder(
                  animation: _stepController,
                  builder: (context, child) {
                    final scale =
                        isActive && !_hasFailed ? 1.0 + (_stepController.value * 0.1) : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFailed
                              ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                              : isCompleted
                                  ? step.activeColor.withValues(alpha: 0.15)
                                  : isActive
                                      ? step.activeColor.withValues(alpha: 0.15)
                                      : const Color(0xFF1F1F1F),
                          border: Border.all(
                            color: isFailed
                                ? const Color(0xFFEF4444)
                                : isCompleted
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
                              : isCompleted
                                  ? Icons.check
                                  : step.icon,
                          color: isFailed
                              ? const Color(0xFFEF4444)
                              : isCompleted
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
                              : isCompleted || isActive
                                  ? Colors.white
                                  : const Color(0xFF6B7280),
                          fontSize: 15.sp,
                          fontWeight: isActive
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
                              : isCompleted || isActive
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
                if (isCompleted)
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
        );
      }),
    );
  }

  Widget _buildPaymentSummary() {
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
          _buildSummaryRow('Network', _providerName ?? 'Unknown'),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          _buildSummaryRow('Phone', _phoneNumber ?? ''),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            'Amount',
            '$_currency ${_amount.toStringAsFixed(2)}',
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
    return Container(
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
              'Payment failed. Redirecting...',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
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
