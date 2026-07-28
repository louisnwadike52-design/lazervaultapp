import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/epin_cubit.dart';
import '../cubit/epin_state.dart';
import 'epin_theme.dart';

/// Runs the recharge-card purchase gRPC call and animates through steps.
/// On success routes to the receipt; on failure shows retry / back CTAs.
class EPinProcessingScreen extends StatefulWidget {
  const EPinProcessingScreen({super.key});

  @override
  State<EPinProcessingScreen> createState() => _EPinProcessingScreenState();
}

class _EPinProcessingScreenState extends State<EPinProcessingScreen>
    with TickerProviderStateMixin {
  static const _bg = EpinTheme.bg;
  static const _card = EpinTheme.card;
  static const _divider = EpinTheme.divider;
  static const _primary = EpinTheme.primary;
  static const _success = EpinTheme.success;
  static const _warning = EpinTheme.warning;
  static const _error = EpinTheme.error;

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

  String _networkName = '';
  int _quantity = 1;
  double _total = 0;
  String _accountLabel = '';
  String _businessName = '';

  static const _steps = [
    _Step('Payment Initiated', 'Your order has been submitted', Icons.receipt_long),
    _Step('Confirming Details', 'Validating payment and account', Icons.verified_user),
    _Step('Printing Cards', 'Generating your recharge PINs', Icons.sync),
    _Step('Cards Ready', 'Your recharge cards are ready', Icons.check_circle),
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
        args['network'] is String &&
        args['denomination'] is double &&
        args['quantity'] is int &&
        args['total'] is double &&
        args['transactionId'] is String &&
        args['verificationToken'] is String &&
        args['sourceAccountId'] is String &&
        args['idempotencyKey'] is String) {
      _networkName = args['networkName'] as String? ?? 'Network';
      _quantity = args['quantity'] as int;
      _total = args['total'] as double;
      _accountLabel = args['accountLabel'] as String? ?? '';
      _businessName = args['businessName'] as String? ?? '';
      _argsValid = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<EPinCubit>().purchase(
              network: args['network'] as String,
              denomination: args['denomination'] as double,
              quantity: args['quantity'] as int,
              sourceAccountId: args['sourceAccountId'] as String,
              phoneNumber: (args['phoneNumber'] as String?) ?? '',
              transactionId: args['transactionId'] as String,
              verificationToken: args['verificationToken'] as String,
              idempotencyKey: args['idempotencyKey'] as String,
              businessName: _businessName,
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
      case 'Printing Cards':
        return 2;
      case 'Cards Ready':
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
            'Please wait while your order is being processed.',
            backgroundColor: _warning,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      },
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: BlocListener<EPinCubit, EPinState>(
            listener: (context, state) {
              if (_hasNavigated) return;
              if (state is EPinPurchaseProcessing) {
                final step = _stepFromLabel(state.currentStep);
                if (step != _currentStep && mounted) {
                  setState(() => _currentStep = step);
                }
              } else if (state is EPinPurchaseSuccess) {
                _hasNavigated = true;
                Get.offNamed(AppRoutes.epinReceipt, arguments: {
                  'order': state.order,
                  'message': state.message,
                  'accountLabel': _accountLabel,
                  'businessName': _businessName,
                });
              } else if (state is EPinPurchaseFailed) {
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
                    final scale =
                        isActive && !_hasFailed ? 1.0 + (_pulse.value * 0.1) : 1.0;
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
                                  : EpinTheme.inactive,
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
                                  : EpinTheme.inactive,
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
                              : EpinTheme.textSecondary,
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
          _summaryRow('Network', _networkName),
          SizedBox(height: 12.h),
          const Divider(color: _divider),
          SizedBox(height: 12.h),
          _summaryRow('Cards', '$_quantity'),
          SizedBox(height: 12.h),
          _summaryRow('Total', 'NGN ${_total.toStringAsFixed(2)}',
              valueColor: _success, bold: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {Color? valueColor, bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                color: EpinTheme.textSecondary, fontSize: 14.sp)),
        Text(
          value,
          style: GoogleFonts.inter(
            color: valueColor ?? Colors.white,
            fontSize: bold ? 16.sp : 14.sp,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
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
                    style:
                        GoogleFonts.inter(fontWeight: FontWeight.w600)),
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
