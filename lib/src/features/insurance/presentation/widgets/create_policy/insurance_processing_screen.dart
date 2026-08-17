import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get_it/get_it.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../../domain/repositories/insurance_repository.dart';
import '../insurance_terms_bottom_sheet.dart';
import '../../../../account_cards_summary/services/balance_websocket_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'insurance_processing_screen_widgets.dart';


/// Screen showing insurance purchase progress with animated steps
class InsuranceProcessingScreen extends StatefulWidget {
  const InsuranceProcessingScreen({super.key});

  @override
  State<InsuranceProcessingScreen> createState() => _InsuranceProcessingScreenState();
}

class _InsuranceProcessingScreenState extends State<InsuranceProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Watchdog timer — if no terminal state (success/error) is emitted
  // within this window, MyCover is probably hung or the gRPC call
  // dropped. Surface a retry-prompt so the user isn't staring at an
  // infinite spinner.
  static const Duration _hangTimeout = Duration(seconds: 60);
  Timer? _hangTimer;
  bool _hangTimedOut = false;

  // When the purchase fails we keep the user ON this screen and render a
  // persistent, unmissable error panel (not a transient snackbar that a
  // pop() dismisses before it's read). This holds the friendly, field-level
  // message from the cubit so the user can see EXACTLY what to correct.
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
    _armHangTimer();
  }

  void _armHangTimer() {
    _hangTimer?.cancel();
    _hangTimedOut = false;
    _hangTimer = Timer(_hangTimeout, () {
      if (!mounted) return;
      setState(() => _hangTimedOut = true);
    });
  }

  @override
  void dispose() {
    _hangTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String _currencySymbol(String currency) {
    final c = currency.toLowerCase().trim();
    if (c == 'ngn' || c.contains('naira')) return '\u20A6';
    if (c == 'usd' || c.contains('dollar')) return '\$';
    if (c == 'gbp' || c.contains('pound')) return '\u00A3';
    if (c == 'eur' || c.contains('euro')) return '\u20AC';
    if (c == 'ghs' || c.contains('cedi')) return '\u20B5';
    if (c == 'kes' || c.contains('shilling')) return 'KSh';
    if (c == 'zar' || c.contains('rand')) return 'R';
    return currency;
  }

  /// Spinner shown before the cubit emits any processing state. After
  /// the watchdog fires, swap to an "is this taking too long?" panel
  /// with a Go Back option so the user is never trapped staring at
  /// a static spinner.
  Widget _buildInitialSpinner() {
    if (!_hangTimedOut) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: Center(child: LazerVaultLoader.small()),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.hourglass_bottom_outlined,
                  color: const Color(0xFFFB923C), size: 48.sp),
              SizedBox(height: 16.h),
              Text('This is taking longer than usual',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              SizedBox(height: 8.h),
              Text(
                  'Our insurance provider is slow to respond. Your '
                  'payment is safe — we will refund automatically if '
                  'the policy does not issue. You can wait or go '
                  'back and check your purchases later.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFF9CA3AF),
                      height: 1.4)),
              SizedBox(height: 28.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F1F1F),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Go back',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 12.h),
              LazerVaultLoader.tiny(),
            ],
          ),
        ),
      ),
    );
  }

  /// Persistent, unmissable failure panel. Shows the exact friendly message
  /// (field-level where the provider tells us the field) so the user knows
  /// precisely what to correct, with a clear "Edit details" action that
  /// returns them to the form rather than silently dropping them out.
  Widget _buildErrorPanel(String message) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                ),
                child: Icon(Icons.error_outline,
                    color: const Color(0xFFEF4444), size: 38.sp),
              ),
              SizedBox(height: 20.h),
              Text("We couldn't complete your policy",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
                ),
                child: Text(message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white,
                        height: 1.45)),
              ),
              SizedBox(height: 10.h),
              Text(
                  'Your payment was not taken. Fix the details above and '
                  'try again.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                      height: 1.4)),
              SizedBox(height: 28.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Edit details',
                      style: GoogleFonts.inter(
                          fontSize: 15.sp, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePolicyCubit, CreatePolicyState>(
      listener: (context, state) {
        // Any terminal state cancels the hang watchdog.
        if (state is InsurancePurchaseSuccess
            || state is CreatePolicyError) {
          _hangTimer?.cancel();
        }
        if (state is InsurancePurchaseSuccess) {
          _pulseController.stop();
          // Navigate to success/receipt screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => InsurancePurchaseReceiptScreen(
                purchaseResult: (state as InsurancePurchaseSuccess).purchaseResult,
                product: (state as InsurancePurchaseSuccess).product,
                quote: (state as InsurancePurchaseSuccess).quote,
              ),
            ),
          );
        } else if (state is CreatePolicyError) {
          _pulseController.stop();
          _hangTimer?.cancel();
          // DON'T pop with a transient snackbar the user never sees. Keep them
          // here and render a persistent error panel with the exact message so
          // they know which field to fix.
          setState(() {
            _errorMessage = (state as CreatePolicyError).message;
          });
        }
      },
      builder: (context, state) {
        if (_errorMessage != null) {
          return _buildErrorPanel(_errorMessage!);
        }
        if (state is! InsurancePurchaseProcessing &&
            state is! InsurancePurchaseSuccess) {
          return _buildInitialSpinner();
        }

        final processingState = state is InsurancePurchaseProcessing
            ? (state as InsurancePurchaseProcessing)
            : null;

        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF6366F1),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Processing Payment',
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Please wait while we secure your policy',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  // Product preview card
                  if (processingState?.product != null) ...[
                    _buildProductCard(processingState!.product, processingState!.quote),
                    SizedBox(height: 32.h),
                  ],

                  // Progress steps
                  Expanded(
                    child: _buildProgressSteps(processingState?.step),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductCard(InsuranceProduct product, InsuranceQuote quote) {
    final formatter = NumberFormat('#,##0.00');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4E03D0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  product.category.icon,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      product.providerName,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.white30, height: 1),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.white70,
                ),
              ),
              Text(
                '${_currencySymbol(quote.currency)}${formatter.format(quote.premium)}',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSteps(InsuranceProcessingStep? currentStep) {
    final steps = [
      _ProgressStep(
        id: 0,
        title: 'Verifying PIN',
        subtitle: 'Validating your transaction PIN',
        icon: Icons.lock_outline,
      ),
      _ProgressStep(
        id: 1,
        title: 'Processing Payment',
        subtitle: 'Initiating premium payment',
        icon: Icons.payment_outlined,
      ),
      _ProgressStep(
        id: 2,
        title: 'Activating Policy',
        subtitle: 'Issuing your insurance policy',
        icon: Icons.verified_user_outlined,
      ),
      _ProgressStep(
        id: 3,
        title: 'Complete',
        subtitle: 'Policy activated successfully',
        icon: Icons.check_circle,
      ),
    ];

    // Map enum step to index
    final stepIndex = switch (currentStep) {
      InsuranceProcessingStep.initiated => 0,
      InsuranceProcessingStep.validatingPin => 0,
      // Documents upload runs between PIN and fund-hold. Treat it as
      // still under the "verifying" rail so the user sees motion on
      // the first step.
      InsuranceProcessingStep.uploadingDocuments => 0,
      InsuranceProcessingStep.holdingFunds => 1,
      InsuranceProcessingStep.purchasingPolicy => 2,
      InsuranceProcessingStep.completed => 3,
      InsuranceProcessingStep.failed => -1,
      null => 0,
    };

    return Column(
      children: [
        ...steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isCompleted = index < stepIndex;
          final isCurrent = index == stepIndex;
          final isPending = index > stepIndex;

          return _buildStepItem(
            step: step,
            isCompleted: isCompleted,
            isCurrent: isCurrent,
            isPending: isPending,
            progress: currentStep == InsuranceProcessingStep.completed ? 1.0 : null,
          );
        }),
      ],
    );
  }

  Widget _buildStepItem({
    required _ProgressStep step,
    required bool isCompleted,
    required bool isCurrent,
    required bool isPending,
    double? progress,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        children: [
          Row(
            children: [
              // Icon container
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: isCurrent ? _pulseAnimation.value : 1.0,
                    child: _buildStepIcon(step, isCompleted, isCurrent, isPending),
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
                        fontSize: 14.sp,
                        fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                        color: isCompleted || isCurrent
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      step.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: isCompleted || isCurrent
                            ? Colors.white70
                            : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildStepIcon(_ProgressStep step, bool isCompleted, bool isCurrent, bool isPending) {
    Color bgColor;
    Color iconColor;
    Widget? icon;

    if (isCompleted) {
      bgColor = const Color(0xFF10B981);
      iconColor = Colors.white;
      icon = Icon(Icons.check, size: 20.sp, color: iconColor);
    } else if (isCurrent) {
      bgColor = const Color(0xFF6366F1);
      iconColor = Colors.white;
      icon = LazerVaultLoader.small();
    } else {
      bgColor = const Color(0xFF1F1F1F);
      iconColor = const Color(0xFF9CA3AF);
      icon = Icon(step.icon, size: 20.sp, color: iconColor);
    }

    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: isCurrent
            ? Border.all(color: const Color(0xFF6366F1), width: 2)
            : null,
      ),
      child: Center(child: icon),
    );
  }
}
