import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/intl_data_bundle.dart';
import '../../domain/entities/intl_data_operator.dart';
import '../cubit/intl_data_cubit.dart';
import 'intl_data_checkout_screen.dart';

/// Processing screen for international data purchases. Fires the
/// buy RPC via [IntlDataCubit] and shows a step-progress animation
/// while waiting for the backend response. On success navigates to
/// the receipt screen; on failure shows an error with retry / back.
class IntlDataProcessingScreen extends StatefulWidget {
  const IntlDataProcessingScreen({super.key});

  @override
  State<IntlDataProcessingScreen> createState() =>
      _IntlDataProcessingScreenState();
}

class _IntlDataProcessingScreenState extends State<IntlDataProcessingScreen>
    with TickerProviderStateMixin {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _primary = Color(0xFF4E03D0);
  static const Color _text2 = Color(0xFF9CA3AF);

  late AnimationController _pulseController;
  bool _hasNavigated = false;
  bool _argsValid = false;

  late IntlDataCountry _country;
  late IntlDataOperator _operator;
  late IntlDataBundle _bundle;
  late String _providerPhone;
  late String _transactionId;
  late String _verificationToken;
  late String _senderCurrency;
  late double _senderAmount;

  Timer? _watchdog;
  static const Duration _watchdogTimeout = Duration(seconds: 60);

  static const _steps = [
    _Step('Payment Initiated', 'Your data request has been submitted',
        Icons.receipt_long, Color(0xFF4E03D0)),
    _Step('Confirming Details', 'Validating payment and account details',
        Icons.verified_user, Color(0xFF4E03D0)),
    _Step('Processing Payment', 'Debiting your account and contacting provider',
        Icons.sync, Color(0xFFFB923C)),
    _Step('Data Bundle Delivered', 'Your international data bundle is active',
        Icons.check_circle, Color(0xFF10B981)),
  ];

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null &&
        args['country'] is IntlDataCountry &&
        args['operator'] is IntlDataOperator &&
        args['bundle'] is IntlDataBundle &&
        args['providerPhone'] is String &&
        args['transactionId'] is String &&
        args['verificationToken'] is String) {
      _country = args['country'] as IntlDataCountry;
      _operator = args['operator'] as IntlDataOperator;
      _bundle = args['bundle'] as IntlDataBundle;
      _providerPhone = args['providerPhone'] as String;
      _transactionId = args['transactionId'] as String;
      _verificationToken = args['verificationToken'] as String;
      _senderCurrency = args['senderCurrency'] as String? ?? _bundle.senderCurrencyCode;
      _senderAmount = (args['senderAmount'] as num?)?.toDouble() ?? _bundle.amount;
      _argsValid = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        Get.snackbar('Error', 'Invalid payment data',
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white);
      });
    }

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    if (_argsValid) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final cubit = context.read<IntlDataCubit>();
        cubit.loadOperators(_country.code, _country.name)
            .then((_) => cubit.loadBundles(_operator))
            .then((_) {
            cubit.selectBundle(_bundle);
            cubit.setRecipient(_providerPhone);
            if (mounted) setState(() => _currentStep = 1);
            cubit.buy(
              accountId: '',
              idempotencyKey: _transactionId,
              pin: _verificationToken,
              senderCurrency: _senderCurrency,
              senderAmount: _senderAmount,
            );
            if (mounted) setState(() => _currentStep = 2);
          });
        _watchdog = Timer(_watchdogTimeout, _handleTimeout);
      });
    }
  }

  void _handleTimeout() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;
    Get.offNamed(AppRoutes.intlDataReceipt, arguments: {
      'isSuccess': false,
      'operatorName': _operator.operatorName,
      'countryName': _country.name,
      'bundleDescription': _bundle.description,
      'phoneNumber': _providerPhone,
      'amountPaid': _senderAmount,
      'senderCurrency': _senderCurrency,
    });
  }

  @override
  void dispose() {
    _watchdog?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_argsValid) {
      return const Scaffold(backgroundColor: _bg);
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
        backgroundColor: _bg,
        body: SafeArea(
          child: BlocListener<IntlDataCubit, IntlDataState>(
            listener: (context, state) {
              if (_hasNavigated) return;

              if (state.purchase != null) {
                _watchdog?.cancel();
                _hasNavigated = true;
                final p = state.purchase!;
                if (p.status == 'completed') {
                  Get.offNamed(AppRoutes.intlDataReceipt, arguments: {
                    'purchase': p,
                    'operatorName': _operator.operatorName,
                    'countryName': _country.name,
                    'bundleDescription': _bundle.description,
                  });
                } else {
                  // Non-completed (processing / failed)
                  Get.offNamed(AppRoutes.intlDataReceipt, arguments: {
                    'purchase': p,
                    'operatorName': _operator.operatorName,
                    'countryName': _country.name,
                    'bundleDescription': _bundle.description,
                    'isSuccess': false,
                  });
                }
              }

              if (state.purchaseError != null && !_hasNavigated) {
                _watchdog?.cancel();
                _hasNavigated = true;
                Get.offNamed(AppRoutes.intlDataReceipt, arguments: {
                  'isSuccess': false,
                  'operatorName': _operator.operatorName,
                  'countryName': _country.name,
                  'bundleDescription': _bundle.description,
                  'phoneNumber': _providerPhone,
                  'amountPaid': _senderAmount,
                  'senderCurrency': _senderCurrency,
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
                  _buildSecurityNote(),
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

        return Column(
          children: [
            Row(
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale = isActive
                        ? 1.0 + (_pulseController.value * 0.1)
                        : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted || isActive
                              ? step.color.withValues(alpha: 0.15)
                              : const Color(0xFF1F1F1F),
                          border: Border.all(
                            color: isCompleted || isActive
                                ? step.color
                                : const Color(0xFF2D2D2D),
                            width: isActive ? 2 : 1.5,
                          ),
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : step.icon,
                          color: isCompleted || isActive
                              ? step.color
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
                        style: TextStyle(
                          color: isCompleted || isActive
                              ? Colors.white
                              : const Color(0xFF6B7280),
                          fontSize: 15.sp,
                          fontWeight:
                              isActive ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        step.subtitle,
                        style: TextStyle(
                          color: isCompleted || isActive
                              ? _text2
                              : const Color(0xFF4B5563),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isActive)
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(step.color),
                    ),
                  ),
                if (isCompleted)
                  Icon(Icons.check_circle, color: step.color, size: 20.sp),
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
                        ? step.color.withValues(alpha: 0.4)
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
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          _summaryRow('Operator', _operator.operatorName),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          _summaryRow('Phone', _providerPhone),
          SizedBox(height: 12.h),
          _summaryRow('Bundle', _bundle.description),
          SizedBox(height: 12.h),
          _summaryRow(
            'Amount',
            '$_senderCurrency ${_senderAmount.toStringAsFixed(2)}',
            valueColor: const Color(0xFF10B981),
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: _text2, fontSize: 14.sp)),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: isBold ? 16.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 16.sp, color: _primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Your payment is secured with end-to-end encryption',
              style: TextStyle(
                fontSize: 12.sp,
                color: _primary,
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

class _Step {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _Step(this.title, this.subtitle, this.icon, this.color);
}
