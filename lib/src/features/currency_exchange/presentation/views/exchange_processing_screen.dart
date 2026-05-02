import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';

/// Exchange processing screen — modelled on airtime_payment_processing_screen.
/// PIN bottomsheet only validates the PIN; the moment it returns, the host
/// screen navigates here. We then:
///
///   1. Read all execution params from Get.arguments (verification token,
///      currencies, amount, recipient — NO data is read off cubit state
///      because the cubit is freshly created via BlocProvider).
///   2. On the next frame, fire the cubit method (convertCurrency or
///      initiateTransfer) — that's the only RPC the user waits on.
///   3. BlocListener flips step indicators as cubit emits Processing /
///      Success / Error. WS subscription inside the cubit handles async
///      mode automatically; sync mode lands on Success directly.
///   4. On Success → push receipt. On Error → render the failure card.
///
/// No polling, no hardcoded delays, no client-side sync/async branching.
/// Backend speed alone determines how long we sit on this screen.
class ExchangeProcessingScreen extends StatefulWidget {
  const ExchangeProcessingScreen({super.key});

  @override
  State<ExchangeProcessingScreen> createState() =>
      _ExchangeProcessingScreenState();
}

class _ExchangeProcessingScreenState extends State<ExchangeProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _stepController;
  bool _hasFailed = false;
  bool _hasNavigated = false;
  String _failMessage = '';
  bool _argsValid = false;

  // Display params (always shown).
  String _mode = 'convert'; // 'convert' | 'sendAbroad'
  String _fromCurrency = 'NGN';
  String _toCurrency = 'USD';
  double _amount = 0;
  String? _recipientName;

  // The host bottomsheet has already fired the RPC; we just need the
  // backend's transaction id so we can subscribe to the WS for its
  // terminal event. No RPC re-firing on this screen.
  String? _transactionId;

  // Step state. Step 0 is "Submitted" (instant — RPC already returned
  // a processing state by the time we get here). Step 1 is "Confirming
  // with provider" (active while we wait on the WS). Step 2 is
  // "Complete" (set on terminal). Backend-event-driven only.
  int _currentStep = 1;

  static const _steps = [
    _ProcessingStep(
      title: 'Submitted',
      subtitle: 'PIN verified and request accepted',
      icon: Icons.receipt_long,
      activeColor: Color(0xFF4E03D0),
    ),
    _ProcessingStep(
      title: 'Confirming with Provider',
      subtitle: 'Waiting for the bank to settle the transfer',
      icon: Icons.sync,
      activeColor: Color(0xFFFB923C),
    ),
    _ProcessingStep(
      title: 'Complete',
      subtitle: 'Funds successfully exchanged',
      icon: Icons.check_circle,
      activeColor: Color(0xFF10B981),
    ),
  ];

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    if (args is Map<String, dynamic> &&
        args['mode'] is String &&
        args['fromCurrency'] is String &&
        args['toCurrency'] is String &&
        args['amount'] is double &&
        args['transactionId'] is String) {
      _mode = args['mode'] as String;
      _fromCurrency = args['fromCurrency'] as String;
      _toCurrency = args['toCurrency'] as String;
      _amount = args['amount'] as double;
      _transactionId = args['transactionId'] as String;
      _recipientName = args['recipientName'] as String?;
      _argsValid = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        Get.snackbar(
          'Error',
          'Invalid exchange data',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
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
        // The host PIN bottomsheet already fired the RPC and got back
        // a processing-state tx id. We only need to subscribe to the
        // WS for the terminal event. Cubit on this screen is fresh
        // (BlocProvider in the route), so we drive subscription by
        // explicit txId rather than reading from cubit state.
        context.read<ExchangeCubit>().subscribeToTransactionStatus(
              _transactionId!,
            );
      });
    }
  }

  /// Pull-to-refresh fallback — for the rare case where the WS dropped
  /// the terminal event. Fires a single RPC reconcile via the cubit.
  /// Still no polling, just one explicit user-initiated check.
  Future<void> _onRefresh() async {
    await context.read<ExchangeCubit>().refreshTransactionStatus();
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
        if (didPop) return;
        Get.snackbar(
          'Exchange in Progress',
          'Please wait — we\'re confirming with the provider.',
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: BlocListener<ExchangeCubit, ExchangeState>(
            listener: (context, state) {
              if (_hasNavigated) return;

              // We mount with step 1 ("Confirming with Provider") active
              // since the RPC has already been fired by the host PIN
              // bottomsheet. The only transitions left are terminal.
              if (state is ExchangeSuccess) {
                _hasNavigated = true;
                if (mounted) setState(() => _currentStep = 2);
                Get.offNamed(
                  AppRoutes.exchangeReceipt,
                  arguments: state.transaction,
                );
              }

              if (state is ExchangeError) {
                if (!mounted) return;
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                });
              }
            },
            child: RefreshIndicator(
              color: const Color(0xFF4E03D0),
              backgroundColor: const Color(0xFF1F1F1F),
              onRefresh: _onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  SizedBox(height: 40.h),
                  _buildStepIndicators(),
                  SizedBox(height: 32.h),
                  _buildSummary(),
                  SizedBox(height: 24.h),
                  if (_hasFailed) _buildFailureActions(),
                  if (!_hasFailed) _buildSecurityNote(),
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
                  builder: (context, _) {
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
                              ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                              : (isCompleted || isActive)
                                  ? step.activeColor.withValues(alpha: 0.15)
                                  : const Color(0xFF1F1F1F),
                          border: Border.all(
                            color: isFailed
                                ? const Color(0xFFEF4444)
                                : (isCompleted || isActive)
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
                              : (isCompleted || isActive)
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
                              : (isCompleted || isActive)
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
                              : (isCompleted || isActive)
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
                  Icon(Icons.check_circle,
                      color: step.activeColor, size: 20.sp),
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

  Widget _buildSummary() {
    final isAbroad = _mode == 'sendAbroad';
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Column(
        children: [
          _row('Type', isAbroad ? 'International Transfer' : 'Conversion'),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          _row('From', '$_fromCurrency ${_amount.toStringAsFixed(2)}'),
          SizedBox(height: 12.h),
          _row('To', _toCurrency),
          if (isAbroad &&
              _recipientName != null &&
              _recipientName!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            const Divider(color: Color(0xFF2D2D2D)),
            SizedBox(height: 12.h),
            _row('Recipient', _recipientName!),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false}) {
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
              color: Colors.white,
              fontSize: isBold ? 16.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityNote() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          Icon(Icons.lock_outline,
              color: const Color(0xFF9CA3AF), size: 14.sp),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Pull down to refresh if it seems stuck.',
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Reset cubit + go back to host screen so the user can
              // re-enter PIN and retry. Cubit state restore handles
              // form repopulation.
              context.read<ExchangeCubit>().restoreHomeState();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Get.offAllNamed(AppRoutes.exchangeHome),
            child: Text(
              'Back to Exchange',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
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
