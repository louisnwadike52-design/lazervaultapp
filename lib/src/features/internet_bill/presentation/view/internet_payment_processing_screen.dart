import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../cubit/internet_bill_cubit.dart';
import '../cubit/internet_bill_state.dart';

/// Stepped processing screen for internet subscription purchases.
/// Mirrors the electricity bill processing screen's visual pattern:
/// vertical step indicators with connectors, animated active step,
/// payment summary card, terminal-state handlers on the cubit.
///
/// Production notes:
///   * NO hardcoded delays on the success path. Step transitions
///     are driven entirely by cubit state emissions — no `await
///     Future.delayed(...)`, no polling loops.
///   * PopScope is gated on `_popAllowed` so programmatic
///     `Get.back()` from terminal-state handlers isn't intercepted
///     by the in-flight "please wait" guard.
///   * `initState` fires payBill via a post-frame callback so
///     context.read is safe — the cubit is provided by the router's
///     BlocProvider ancestor.
class InternetPaymentProcessingScreen extends StatefulWidget {
  const InternetPaymentProcessingScreen({super.key});

  @override
  State<InternetPaymentProcessingScreen> createState() =>
      _InternetPaymentProcessingScreenState();
}

class _InternetPaymentProcessingScreenState
    extends State<InternetPaymentProcessingScreen>
    with TickerProviderStateMixin {
  bool _paymentTriggered = false;
  bool _popAllowed = false;
  bool _hasFailed = false;
  String _failMessage = '';
  int _currentStep = 0;

  late final AnimationController _pulseController;

  // Cached from Get.arguments on mount. Keeping copies avoids re-
  // parsing on every rebuild and lets us pass them through to the
  // receipt screen even if the original map mutates.
  InternetProviderEntity? _provider;
  InternetPackageEntity? _package;
  String? _accountNumber;

  static const _steps = [
    _ProcessingStep(
      title: 'Payment Initiated',
      subtitle: 'Your subscription request has been submitted',
      icon: Icons.receipt_long,
      activeColor: Color(0xFF4E03D0),
    ),
    _ProcessingStep(
      title: 'Confirming Details',
      subtitle: 'Validating account and package selection',
      icon: Icons.verified_user,
      activeColor: Color(0xFF4E03D0),
    ),
    _ProcessingStep(
      title: 'Processing with Provider',
      subtitle: 'Debiting your account and reaching the ISP',
      icon: Icons.sync,
      activeColor: Color(0xFFFB923C),
    ),
    _ProcessingStep(
      title: 'Subscription Activated',
      subtitle: 'Internet package delivered to your account',
      icon: Icons.wifi,
      activeColor: Color(0xFF10B981),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) => _triggerPayment());
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _triggerPayment() {
    if (_paymentTriggered) return;
    _paymentTriggered = true;

    final args = Get.arguments as Map<String, dynamic>?;
    debugPrint('[InternetProcessing] _triggerPayment args=${args != null}');
    if (args == null) {
      Get.back();
      return;
    }

    try {
      _provider = args['provider'] as InternetProviderEntity;
      _package = args['package'] as InternetPackageEntity;
      _accountNumber = args['accountNumber'] as String;
      final transactionId = args['transactionId'] as String;
      final verificationToken = args['verificationToken'] as String;
      final idempotencyKey = args['idempotencyKey'] as String;

      debugPrint('[InternetProcessing] calling payBill provider='
          '${_provider!.serviceId} account=$_accountNumber '
          'pkg=${_package!.id} amount=${_package!.amount}');

      context.read<InternetBillCubit>().payBill(
            providerId: _provider!.serviceId,
            customerNumber: _accountNumber!,
            serviceType: _provider!.serviceId,
            packageId: _package!.id,
            amount: _package!.amount,
            transactionId: transactionId,
            verificationToken: verificationToken,
            idempotencyKey: idempotencyKey,
          );
      debugPrint('[InternetProcessing] payBill dispatched');
    } catch (e, st) {
      debugPrint('[InternetProcessing] FATAL: $e\n$st');
      if (!mounted) return;
      setState(() => _popAllowed = true);
      Get.back();
      Get.snackbar(
        'Something went wrong',
        'Could not start payment: ${e.toString()}',
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
    }
  }

  /// Route to the receipt and forward save/rollover flags. Called on
  /// either a completed purchase or an async-pending one (the receipt
  /// screen renders both and handles post-purchase actions when the
  /// status is terminal-completed).
  void _navigateToReceipt(dynamic payment) {
    if (!mounted) return;
    setState(() => _popAllowed = true);
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    Get.offNamed(
      AppRoutes.internetPaymentReceipt,
      arguments: {
        'payment': payment,
        'provider': args['provider'],
        'package': args['package'],
        'accountNumber': args['accountNumber'],
        'saveBeneficiary': args['saveBeneficiary'] ?? false,
        'beneficiaryNickname': args['beneficiaryNickname'],
        'autoRenewEnabled': args['autoRenewEnabled'] ?? false,
        'rolloverPref': args['rolloverPref'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _popAllowed && !_hasFailed,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_hasFailed) {
          Get.offAllNamed(AppRoutes.internetBillHome);
          return;
        }
        Get.snackbar(
          'Payment in Progress',
          'Please wait while your payment is being processed.',
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: BlocListener<InternetBillCubit, InternetBillState>(
            listener: (context, state) {
              if (state is InternetBillPaymentProcessing) {
                // Cubit emitted a mid-flight state (the RPC has been
                // dispatched to the backend). Advance to the "Processing
                // with Provider" step — steps 0 & 1 complete visually.
                if (_currentStep < 2) setState(() => _currentStep = 2);
              } else if (state is InternetBillPaymentSuccess) {
                // Terminal-completed or pending async — both navigate to
                // the receipt, which renders each status correctly and
                // triggers the save/rollover side-effects only when
                // isCompleted is true.
                setState(() => _currentStep = 3);
                _navigateToReceipt(state.payment);
              } else if (state is InternetBillPaymentFailed) {
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                  _popAllowed = true;
                });
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
              } else if (state is InternetBillError) {
                setState(() {
                  _hasFailed = true;
                  _failMessage = state.message;
                  _popAllowed = true;
                });
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
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  _buildStepIndicators(),
                  SizedBox(height: 40.h),
                  if (_provider != null && _package != null)
                    _buildPaymentSummary(_provider!, _package!, _accountNumber),
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
        final isActive = index == _currentStep && !_hasFailed;
        final isFailed = _hasFailed && index == _currentStep;

        return Column(
          children: [
            Row(
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale =
                        isActive ? 1.0 + (_pulseController.value * 0.1) : 1.0;
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

  Widget _buildPaymentSummary(
    InternetProviderEntity provider,
    InternetPackageEntity package,
    String? accountNumber,
  ) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Provider', provider.name),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          if (accountNumber != null) ...[
            _buildSummaryRow('Account', accountNumber),
            SizedBox(height: 12.h),
          ],
          _buildSummaryRow('Package', package.name),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            'Amount',
            '\u20A6${package.displayAmount.toStringAsFixed(0)}',
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
    final friendly = _friendlyError(_failMessage, _provider);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline,
                      color: const Color(0xFFEF4444), size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      friendly.title,
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEF4444),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              if (friendly.detail != null) ...[
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(left: 32.w),
                  child: Text(
                    friendly.detail!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.85),
                      fontSize: 12.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Primary action: send the user back to the recipient screen
        // so they can fix what's wrong (most often the account number)
        // without restarting the whole flow. Less destructive than
        // dropping them on the home page.
        SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton.icon(
            onPressed: () => Get.offAllNamed(
              AppRoutes.internetBillHome,
              arguments: {
                'editAccount': true,
                'accountNumber': _accountNumber,
                if (_provider != null) 'providerId': _provider!.id,
                if (_package != null) 'packageId': _package!.id,
              },
            ),
            icon: Icon(Icons.edit, size: 18.sp, color: Colors.white),
            label: Text(
              'Edit account & try again',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        TextButton(
          onPressed: () => Get.offAllNamed(AppRoutes.internetBillHome),
          child: Text(
            'Back to Internet Home',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  /// Translate the raw backend / provider error into a user-actionable
  /// title + hint. Most internet failures are a bad account-number
  /// format for the chosen provider — the raw "invalid internet account
  /// number: 08011111111" message doesn't tell the user that Smile
  /// expects an email, that Spectranet expects an account ID, etc.
  ({String title, String? detail}) _friendlyError(
      String raw, dynamic provider) {
    final m = raw.toLowerCase();
    // InternetProviderEntity uses `serviceId` ("smile-direct",
    // "spectranet", etc.) and `name` ("Smile", "Spectranet"). Match
    // against either to derive provider-specific hints.
    final providerCode = (provider?.serviceId as String?)?.toLowerCase();
    final providerName = provider?.name as String?;
    String providerDisplay() => providerName ?? providerCode ?? 'this provider';

    String? hintForProvider() {
      if (providerCode == null) return null;
      if (providerCode.contains('smile')) {
        return 'Smile uses your registered email address (or Smile-issued '
            'account ID) — not a phone number. Check your Smile dashboard '
            'or contact Smile support if you\'re unsure.';
      }
      if (providerCode.contains('spectranet')) {
        return 'Spectranet uses the account ID printed on your modem or '
            'sent to you when you registered.';
      }
      if (providerCode.contains('swift')) {
        return 'Swift uses the account number on your service contract.';
      }
      return null;
    }

    if (m.contains('invalid') &&
        (m.contains('account number') || m.contains('account'))) {
      return (
        title:
            'Account number not recognised by ${providerDisplay()}',
        detail: hintForProvider() ??
            'Please double-check the account number and try again.',
      );
    }
    if (m.contains('insufficient') && m.contains('balance')) {
      return (
        title: 'Insufficient balance',
        detail: 'Top up your wallet or pick a different account, '
            'then try again.',
      );
    }
    if (m.contains('biller') &&
        (m.contains('unavail') || m.contains('down'))) {
      return (
        title: '${providerDisplay()} is temporarily unavailable',
        detail: 'The provider is offline. Try again in a few minutes.',
      );
    }
    // VTpass TRANSACTION FAILED (code 016) is the gateway's catch-all
    // when the upstream biller rejected the request post-charge for a
    // reason it didn't disclose. Money is auto-refunded by our
    // reconciler — surface that explicitly so the user doesn't think
    // they're out of pocket.
    if (m.contains('transaction failed') ||
        m.contains('016') ||
        m.contains('ambiguous')) {
      return (
        title: 'Provider rejected the transaction',
        detail: '${providerDisplay()} couldn\'t complete this top-up '
            '(VTpass returned a generic failure). Your wallet has been '
            'refunded — you can try again or pick a different package.',
      );
    }
    // Code 011 = INVALID ARGUMENTS — VTpass rejected the request
    // payload before charging. Same friendliness as account-number
    // errors but generic since we don't know which field broke.
    if (m.contains('invalid arguments') || m.contains('code: 011')) {
      return (
        title: 'Provider rejected the request',
        detail: 'Some of the details didn\'t pass ${providerDisplay()}\'s '
            'validation. Double-check the account number and package, '
            'then try again.',
      );
    }
    if (m.contains('timeout') || m.contains('deadline')) {
      return (
        title: 'Provider timed out',
        detail: 'We couldn\'t reach ${providerDisplay()} in time. Your '
            'wallet wasn\'t charged — please try again.',
      );
    }
    if (m.contains('network') || m.contains('connection')) {
      return (
        title: 'Connection error',
        detail: 'Check your internet connection and try again.',
      );
    }
    return (
      title: raw.isEmpty ? 'Payment failed. Please try again.' : raw,
      detail: null,
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
          Icon(Icons.lock_outline,
              size: 16.sp, color: const Color(0xFF4E03D0)),
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
