import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Transition;
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _stepController;
  int _currentStep = 0;
  bool _isComplete = false;
  bool _hasFailed = false;
  bool _isAsyncPending = false;
  String _failMessage = '';

  ElectricityProviderEntity? _provider;
  MeterValidationResult? _validationResult;
  double _amount = 0;
  bool _argsValid = false;

  // Payment execution params
  String? _providerCode;
  String? _meterNumber;
  MeterType? _meterType;
  String? _currency;
  String? _accountId;
  String? _phoneNumber;
  String? _transactionId;
  String? _verificationToken;

  // Keep-alive flags forwarded from the confirm screen. Receipt screen
  // consumes these to fire the post-pay auto-recharge RPC once the
  // payment is confirmed complete. Stored as a plain map so we don't
  // need to import the rollover type here.
  final Map<String, dynamic> _keepAliveArgs = <String, dynamic>{};

  static const _steps = [
    _ProcessingStep(
      title: 'Payment Initiated',
      subtitle: 'Your payment request has been submitted',
      icon: Icons.receipt_long,
      activeColor: Color(0xFF4E03D0),
    ),
    _ProcessingStep(
      title: 'Confirming Details',
      subtitle: 'Validating payment and account details',
      icon: Icons.verified_user,
      activeColor: Color.fromARGB(255, 78, 3, 208),
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
        args['amount'] is double &&
        args['providerCode'] is String &&
        args['currency'] is String &&
        args['accountId'] is String &&
        args['transactionId'] is String &&
        args['verificationToken'] is String) {
      _provider = args['provider'] as ElectricityProviderEntity;
      _validationResult = args['validationResult'] as MeterValidationResult;
      _amount = args['amount'] as double;
      _providerCode = args['providerCode'] as String;
      _meterNumber = args['meterNumber'] as String;
      _meterType = args['meterType'] as MeterType;
      _currency = args['currency'] as String;
      _accountId = args['accountId'] as String;
      _phoneNumber = args['phoneNumber'] as String?;
      _transactionId = args['transactionId'] as String;
      _verificationToken = args['verificationToken'] as String;
      // Capture optional keep-alive flags — missing keys are fine, the
      // receipt screen treats absent values as "do nothing".
      if (args['autoRechargeEnabled'] != null) {
        _keepAliveArgs['autoRechargeEnabled'] = args['autoRechargeEnabled'];
      }
      if (args['autoRechargePref'] != null) {
        _keepAliveArgs['autoRechargePref'] = args['autoRechargePref'];
      }
      if (args['existingBeneficiaryId'] != null) {
        _keepAliveArgs['existingBeneficiaryId'] = args['existingBeneficiaryId'];
      }
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
      // Initiate payment on this screen's own cubit. Step indicators are
      // driven by cubit state transitions (see BlocListener below) — no
      // hardcoded timers gating business logic.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        print('[PaymentProcessing] Initiating payment: provider=$_providerCode, meter=$_meterNumber, amount=$_amount, txId=$_transactionId');
        context.read<ElectricityBillCubit>().initiatePaymentWithToken(
              providerCode: _providerCode!,
              meterNumber: _meterNumber!,
              meterType: _meterType!,
              amount: _amount,
              currency: _currency!,
              accountId: _accountId!,
              phoneNumber: _phoneNumber ?? '',
              transactionId: _transactionId!,
              verificationToken: _verificationToken!,
            );
      });
    } else {
      print('[PaymentProcessing] Args invalid! args=$args');
    }
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  /// Schedule advancing [_currentStep] to [target] after [after]. Subsequent
  /// terminal-state callbacks short-circuit if a later step has already been
  /// scheduled or reached.
  void _scheduleStep(int target, {required Duration after}) {
    Future.delayed(after, () {
      if (!mounted || _hasFailed) return;
      if (_currentStep < target) {
        setState(() => _currentStep = target);
      }
    });
  }

  /// Walk from the current step to [finalStep] with short delays so the
  /// user sees each indicator light up, then call [onArrive].
  ///   - sync success → finalStep = 3 (Token Generated) → navigate.
  ///   - async pending → finalStep = 2 (Processing) + pending hint → navigate.
  void _runToReceipt({
    required int finalStep,
    required bool pending,
    required VoidCallback onArrive,
  }) {
    if (!mounted || _hasFailed) return;
    if (pending && !_isAsyncPending) {
      setState(() => _isAsyncPending = true);
    }
    final stepDelay = const Duration(milliseconds: 600);
    final pendingHintDwell = const Duration(milliseconds: 1200);

    final stepsToAnimate = <int>[];
    for (var s = _currentStep + 1; s <= finalStep; s++) {
      stepsToAnimate.add(s);
    }

    Duration cumulative = Duration.zero;
    for (final step in stepsToAnimate) {
      cumulative += stepDelay;
      Future.delayed(cumulative, () {
        if (!mounted || _hasFailed) return;
        setState(() => _currentStep = step);
      });
    }
    final arriveDelay = pending
        ? cumulative + pendingHintDwell
        : cumulative + const Duration(milliseconds: 400);
    Future.delayed(arriveDelay, () {
      if (!mounted || _hasFailed) return;
      onArrive();
    });
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
          child: BlocListener<ElectricityBillCubit, ElectricityBillState>(
            listener: (context, state) {
              // Visual step progression. Backend may emit terminal states
              // (PaymentSuccess / AsyncPaymentPending) very quickly after
              // PaymentInitiated, so we DRIVE the intermediate steps from
              // a short staged timeline once we have the start signal. That
              // way the user actually sees the flow (Confirming Details →
              // Processing Payment → Token Generated / Pending) instead of
              // a flash from step 0 to the receipt.
              if (state is PaymentInitiating) {
                print('[PaymentProcessing] State: PaymentInitiating');
                if (!_hasFailed && _currentStep != 0) {
                  setState(() => _currentStep = 0);
                }
              }

              if (state is PaymentInitiated) {
                print('[PaymentProcessing] State: PaymentInitiated (id=${state.payment.id})');
                if (!_hasFailed && _currentStep < 1) {
                  setState(() => _currentStep = 1);
                  _scheduleStep(2, after: const Duration(milliseconds: 700));
                }
              }

              if (state is PaymentSuccess) {
                _runToReceipt(
                  finalStep: 3,
                  pending: false,
                  onArrive: () {
                    Get.offNamed(
                      AppRoutes.electricityBillReceipt,
                      arguments: {
                        'payment': state.payment,
                        ..._keepAliveArgs,
                      },
                    );
                  },
                );
              }

              if (state is AsyncPaymentPending) {
                // Async mode: payment accepted by the provider queue, token
                // arrives later via webhook/SMS. Walk to step 2 (Processing),
                // show the "we'll reflect when ready" hint, then navigate.
                // The receipt screen already handles the pending state.
                _runToReceipt(
                  finalStep: 2,
                  pending: true,
                  onArrive: () {
                    Get.offNamed(
                      AppRoutes.electricityBillReceipt,
                      arguments: {
                        'payment': state.payment,
                        ..._keepAliveArgs,
                      },
                    );
                  },
                );
              }

              if (state is PaymentFailed) {
                print('[PaymentProcessing] PaymentFailed: ${state.errorMessage}');
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.errorMessage;
                });
                // Let the user see the failure card + decide next step
                // (Try Again pops back; Back to Electricity offAllNamed).
              }

              if (state is ElectricityBillError) {
                print('[PaymentProcessing] ElectricityBillError: ${state.message}');
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
                  if (!_hasFailed && _isAsyncPending) _buildPendingHint(),
                  if (!_hasFailed && !_isAsyncPending && !_isComplete)
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
                    LazerVaultLoader.small(),
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
              Icon(Icons.error_outline,
                  color: const Color(0xFFEF4444), size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  _failMessage,
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
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Pop twice mirrors the old auto-navigation target
                  // (back past this screen + the confirmation to the
                  // meter-input step) so Try Again lands on the
                  // meaningful retry point.
                  Get.back();
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF4E03D0)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Try Again',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4E03D0),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () =>
                    Get.offAllNamed(AppRoutes.electricityBillHome),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Back to Electricity',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPendingHint() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.hourglass_top,
              size: 18.sp, color: const Color(0xFFFB923C)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Processing in the background — your electricity token will '
              'appear on the receipt once the provider confirms.',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFFFB923C),
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
        color: const Color(0xFF4E03D0).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 16.sp,
            color: const Color(0xFF4E03D0),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Your payment is secured with end-to-end encryption',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF4E03D0),
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
