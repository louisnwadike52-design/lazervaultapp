import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/betting_cubit.dart';
import '../cubit/betting_state.dart';
import 'betting_theme.dart';

/// Runs the betting funding gRPC call and animates through steps.
class BettingProcessingScreen extends StatefulWidget {
  const BettingProcessingScreen({super.key});

  @override
  State<BettingProcessingScreen> createState() =>
      _BettingProcessingScreenState();
}

class _BettingProcessingScreenState extends State<BettingProcessingScreen>
    with TickerProviderStateMixin {
  static const _bg = BettingTheme.bg;
  static const _card = BettingTheme.card;
  static const _divider = BettingTheme.divider;
  static const _primary = BettingTheme.primary;
  static const _success = BettingTheme.success;
  static const _warning = BettingTheme.warning;
  static const _error = BettingTheme.error;

  /// Failure "Back" returns to the Bills Hub landing the service was launched
  /// from, preserving the carousel / active account / locale that sit below it.
  void _exitToBillsHub() {
    Get.until((route) =>
        route.settings.name == AppRoutes.billsHub || route.isFirst);
  }

  late AnimationController _pulse;
  bool _argsValid = false;
  bool _hasNavigated = false;
  bool _hasFailed = false;
  String _failMessage = '';
  int _currentStep = 0;

  String _platformName = '';
  String _accountName = '';
  double _amount = 0;

  static const _steps = [
    _Step('Payment Initiated', 'Your funding request has been submitted',
        Icons.receipt_long),
    _Step('Confirming Details', 'Validating payment and account',
        Icons.verified_user),
    _Step('Funding Account', 'Sending funds to your betting wallet', Icons.sync),
    _Step('Wallet Funded', 'Your betting wallet is funded',
        Icons.check_circle),
  ];

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    final args = Get.arguments;
    if (args is Map<String, dynamic> &&
        args['platform'] is String &&
        args['accountUserid'] is String &&
        args['accountName'] is String &&
        args['amount'] is double &&
        args['transactionId'] is String &&
        args['verificationToken'] is String &&
        args['sourceAccountId'] is String &&
        args['idempotencyKey'] is String) {
      _platformName = args['platformName'] as String? ?? 'Platform';
      _accountName = args['accountName'] as String;
      _amount = args['amount'] as double;
      _argsValid = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<BettingCubit>().fund(
              platform: args['platform'] as String,
              accountUserid: args['accountUserid'] as String,
              accountName: args['accountName'] as String,
              amount: args['amount'] as double,
              sourceAccountId: args['sourceAccountId'] as String,
              phoneNumber: (args['phoneNumber'] as String?) ?? '',
              transactionId: args['transactionId'] as String,
              verificationToken: args['verificationToken'] as String,
              idempotencyKey: args['idempotencyKey'] as String,
              saveBeneficiary: (args['saveAccount'] as bool?) ?? false,
              nickname: args['nickname'] as String?,
            );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        Get.snackbar('Error', 'Invalid payment data',
            backgroundColor: _error, colorText: Colors.white);
      });
    }
  }

  int _stepFromLabel(String label) {
    switch (label) {
      case 'Payment Initiated':
        return 0;
      case 'Confirming Details':
        return 1;
      case 'Funding Account':
        return 2;
      case 'Wallet Funded':
        return 3;
      default:
        return _currentStep;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_argsValid) return const Scaffold(backgroundColor: _bg);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Get.snackbar(
            'Payment in progress',
            'Please wait while your funding is being processed.',
            backgroundColor: _warning,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      },
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: BlocListener<BettingCubit, BettingState>(
            listener: (context, state) {
              if (_hasNavigated) return;
              if (state is BettingFundingProcessing) {
                final step = _stepFromLabel(state.currentStep);
                if (step != _currentStep && mounted) {
                  setState(() => _currentStep = step);
                }
              } else if (state is BettingFundingSuccess) {
                _hasNavigated = true;
                Get.offNamed(AppRoutes.bettingReceipt, arguments: {
                  'result': state.result,
                  'platformName': _platformName,
                  'accountName': _accountName,
                });
              } else if (state is BettingFundingFailed) {
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
                  _buildSteps(),
                  SizedBox(height: 32.h),
                  _buildSummary(),
                  const Spacer(flex: 2),
                  if (_hasFailed) _buildFailure() else _buildNote(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSteps() {
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
                  animation: _pulse,
                  builder: (context, _) {
                    final scale = isActive && !_hasFailed
                        ? 1.0 + (_pulse.value * 0.1)
                        : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 46.w,
                        height: 46.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFailed
                              ? _error.withValues(alpha: 0.15)
                              : (isCompleted || isActive)
                                  ? _primary.withValues(alpha: 0.15)
                                  : _card,
                          border: Border.all(
                            color: isFailed
                                ? _error
                                : (isCompleted || isActive)
                                    ? _primary
                                    : _divider,
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
                              ? _error
                              : (isCompleted || isActive)
                                  ? _primary
                                  : BettingTheme.inactive,
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
                              ? _error
                              : (isCompleted || isActive)
                                  ? Colors.white
                                  : BettingTheme.inactive,
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
                              ? _error.withValues(alpha: 0.8)
                              : BettingTheme.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isActive && !_hasFailed)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        color: _primary, strokeWidth: 2),
                  ),
                if (isCompleted)
                  Icon(Icons.check_circle, color: _success, size: 20.sp),
              ],
            ),
            if (index < _steps.length - 1)
              Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: Container(
                  width: 2,
                  height: 22.h,
                  color: isCompleted
                      ? _primary.withValues(alpha: 0.4)
                      : _divider,
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _divider),
      ),
      child: Column(
        children: [
          _summaryRow('Platform', _platformName),
          SizedBox(height: 12.h),
          const Divider(color: _divider),
          SizedBox(height: 12.h),
          _summaryRow('Account', _accountName),
          SizedBox(height: 12.h),
          _summaryRow('Amount', 'NGN ${_amount.toStringAsFixed(2)}',
              valueColor: _success, bold: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {Color? valueColor, bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                color: BettingTheme.textSecondary, fontSize: 14.sp)),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: bold ? 16.sp : 14.sp,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNote() {
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
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 12.sp, color: _primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailure() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: _error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: _error.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: _error, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  _failMessage,
                  style: GoogleFonts.inter(color: _error, fontSize: 13.sp),
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
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _primary),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('Try again',
                    style: GoogleFonts.inter(
                        color: _primary, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: _exitToBillsHub,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('Back',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Step {
  final String title;
  final String subtitle;
  final IconData icon;
  const _Step(this.title, this.subtitle, this.icon);
}
