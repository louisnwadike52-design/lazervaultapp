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
    extends State<DataPaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _stepController;
  bool _hasFailed = false;
  bool _hasNavigated = false;
  String _failMessage = '';
  bool _argsValid = false;
  bool _paymentTriggered = false;

  // Payment display params
  String _networkName = '';
  String _planName = '';
  String _phoneNumber = '';
  double _amount = 0;
  final String _currency = 'NGN';

  // Step tracking synced to cubit states
  int _currentStep = 0;

  static const _steps = [
    _ProcessingStep(
      title: 'Payment Initiated',
      subtitle: 'Your data purchase request has been submitted',
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
      title: 'Data Delivered',
      subtitle: 'Your data bundle is now active',
      icon: Icons.check_circle,
      activeColor: Color(0xFF10B981),
    ),
  ];

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    if (args is Map<String, dynamic> &&
        args['plan'] is DataPlanEntity &&
        args['network'] is String &&
        args['phoneNumber'] is String &&
        args['transactionId'] is String &&
        args['verificationToken'] is String &&
        args['idempotencyKey'] is String) {
      _networkName = args['networkName'] as String? ?? '';
      _planName = (args['plan'] as DataPlanEntity).name;
      _phoneNumber = args['phoneNumber'] as String;
      _amount = (args['plan'] as DataPlanEntity).price;
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
        _triggerPayment();
      });
    }
  }

  void _triggerPayment() {
    if (_paymentTriggered) return;
    _paymentTriggered = true;

    final args = Get.arguments as Map<String, dynamic>;
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

  int _stepIndexFromLabel(String label) {
    switch (label) {
      case 'Payment Initiated':
        return 0;
      case 'Confirming Details':
        return 1;
      case 'Processing Payment':
        return 2;
      case 'Data Delivered':
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

    final args = Get.arguments as Map<String, dynamic>;

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
              if (_hasNavigated) return;

              if (state is DataBundlesPaymentProcessing) {
                final step = _stepIndexFromLabel(state.currentStep);
                if (step != _currentStep && mounted) {
                  setState(() => _currentStep = step);
                }
              }

              if (state is DataBundlesPaymentSuccess) {
                _hasNavigated = true;
                final autoRenew =
                    args['autoRenewEnabled'] as bool? ?? false;
                Get.offNamed(
                  AppRoutes.dataBundlesPaymentReceipt,
                  arguments: {
                    'purchase': state.purchase,
                    'networkName': _networkName,
                    'planName': _planName,
                    'autoRenewEnabled': autoRenew,
                    'network': args['network'] ?? '',
                    'plan': args['plan'],
                    // New: forward the rollover preference + beneficiary
                    // save flag so the receipt can wire them post-payment.
                    'rolloverPreference': args['rolloverPreference'],
                    'saveBeneficiary': args['saveBeneficiary'] ?? false,
                    'phoneNumber': args['phoneNumber'] ?? '',
                  },
                );
              }

              if (state is DataBundlesPaymentFailed) {
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                });

                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted && !_hasNavigated) {
                    _hasNavigated = true;
                    Get.until((route) =>
                        route.settings.name == AppRoutes.dataBundlesPaymentConfirmation ||
                        route.settings.name == AppRoutes.dataBundlesHome ||
                        route.isFirst);
                    Get.snackbar(
                      'Payment Failed',
                      state.message,
                      backgroundColor: const Color(0xFFEF4444),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                      duration: const Duration(seconds: 4),
                    );
                  }
                });
              }

              if (state is DataBundlesError) {
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                });

                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted && !_hasNavigated) {
                    _hasNavigated = true;
                    Get.until((route) =>
                        route.settings.name == AppRoutes.dataBundlesPaymentConfirmation ||
                        route.settings.name == AppRoutes.dataBundlesHome ||
                        route.isFirst);
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
                AnimatedBuilder(
                  animation: _stepController,
                  builder: (context, child) {
                    final scale = isActive && !_hasFailed
                        ? 1.0 + (_stepController.value * 0.1)
                        : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFailed
                              ? const Color(0xFFEF4444)
                                  .withValues(alpha: 0.15)
                              : isCompleted
                                  ? step.activeColor
                                      .withValues(alpha: 0.15)
                                  : isActive
                                      ? step.activeColor
                                          .withValues(alpha: 0.15)
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
                          fontWeight:
                              isActive ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        isFailed ? _failMessage : step.subtitle,
                        style: GoogleFonts.inter(
                          color: isFailed
                              ? const Color(0xFFEF4444)
                                  .withValues(alpha: 0.8)
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
          _buildSummaryRow('Network', _networkName),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          _buildSummaryRow('Plan', _planName),
          SizedBox(height: 12.h),
          _buildSummaryRow('Phone', _phoneNumber),
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
              'Payment failed. Redirecting back...',
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
