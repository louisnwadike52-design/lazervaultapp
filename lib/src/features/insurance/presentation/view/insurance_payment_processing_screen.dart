import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/create_policy_cubit.dart';
import '../cubit/create_policy_state.dart';

/// Processing screen for MyCover.ai insurance purchase
///
/// Shows step-by-step progress with animated indicators.
/// Prompts for transaction PIN, then processes the purchase.
class InsurancePaymentProcessingScreen extends StatefulWidget {
  const InsurancePaymentProcessingScreen({super.key});

  @override
  State<InsurancePaymentProcessingScreen> createState() =>
      _InsurancePaymentProcessingScreenState();
}

class _InsurancePaymentProcessingScreenState
    extends State<InsurancePaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  bool _pinEntered = false;
  bool _processingPurchase = false;
  String? _pinErrorMessage;
  final _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Show PIN entry first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPinDialog();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _showPinDialog() {
    _pinController.clear();
    _pinErrorMessage = null;
    _processingPurchase = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Text('Enter Transaction PIN',
            style: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter your 4-digit transaction PIN to confirm this purchase',
                style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 20.h),
              TextField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 24.sp, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 8),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: _pinErrorMessage != null
                        ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D))),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Color(0xFF6366F1))),
                ),
                onChanged: (_) {
                  if (_pinErrorMessage != null) {
                    setDialogState(() => _pinErrorMessage = null);
                  }
                },
              ),
              if (_pinErrorMessage != null) ...[
                SizedBox(height: 8.h),
                Text(_pinErrorMessage!,
                  style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFFEF4444))),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop(); // Go back to carousel
              },
              child: Text('Cancel', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
            ),
            GestureDetector(
              onTap: _processingPurchase ? null : () {
                final pin = _pinController.text;
                if (pin.length == 4 && RegExp(r'^\d{4}$').hasMatch(pin)) {
                  FocusScope.of(dialogContext).unfocus();
                  setDialogState(() => _processingPurchase = true);
                  Navigator.of(dialogContext).pop();
                  _startPurchase(pin);
                } else if (pin.length < 4) {
                  setDialogState(() => _pinErrorMessage = 'Please enter a 4-digit PIN');
                } else {
                  setDialogState(() => _pinErrorMessage = 'PIN must contain only numbers');
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: _processingPurchase
                      ? [const Color(0xFF4B4B4B), const Color(0xFF4B4B4B)]
                      : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)]),
                  borderRadius: BorderRadius.circular(8.r)),
                child: Text(_processingPurchase ? 'Processing...' : 'Confirm',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startPurchase(String pin) {
    final cubit = context.read<CreatePolicyCubit>();

    // Validate account selection - no 'default' fallback
    if (cubit.selectedAccountId == null) {
      _processingPurchase = false;
      _showErrorDialog('Please select a payment account in the previous step');
      return;
    }

    setState(() => _pinEntered = true);
    _pulseController.repeat(reverse: true);
    _rotationController.repeat();

    cubit.purchaseInsurance(
      accountId: cubit.selectedAccountId!,
      transactionPin: pin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: BlocConsumer<CreatePolicyCubit, CreatePolicyState>(
          listener: (context, state) {
            if (state is InsurancePurchaseSuccess) {
              _pulseController.stop();
              _rotationController.stop();
              // Navigate to confirmation/receipt
              Future.delayed(const Duration(milliseconds: 500), () {
                Get.offAllNamed(AppRoutes.dashboard);
                Get.snackbar(
                  'Purchase Successful',
                  'Your insurance policy ${state.purchaseResult.policyNumber} is now active!',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              });
            } else if (state is InsurancePurchaseQueued) {
              Get.offAllNamed(AppRoutes.dashboard);
              Get.snackbar(
                'Purchase Queued',
                state.message,
                backgroundColor: const Color(0xFFFB923C),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            } else if (state is CreatePolicyError) {
              _processingPurchase = false;
              final msg = state.message.toLowerCase();
              if (msg.contains('pin') || msg.contains('verification token')) {
                // PIN-related error: re-show PIN dialog with inline error
                _pinErrorMessage = state.message;
                _showPinDialog();
              } else {
                _showErrorDialog(state.message);
              }
            }
          },
          builder: (context, state) {
            if (!_pinEntered) {
              return _buildWaitingForPin();
            }

            if (state is InsurancePurchaseProcessing) {
              return _buildProcessingView(state);
            }

            if (state is InsurancePurchaseSuccess) {
              return _buildSuccessView(state);
            }

            // Default processing view
            return _buildDefaultProcessingView();
          },
        ),
      ),
    );
  }

  Widget _buildWaitingForPin() {
    return SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.lock_outline, size: 64.sp, color: const Color(0xFF6366F1)),
          SizedBox(height: 16.h),
          Text('Enter PIN to Continue',
            style: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white)),
        ]),
      ),
    );
  }

  Widget _buildDefaultProcessingView() {
    final cubit = context.read<CreatePolicyCubit>();
    return _buildProcessingContent(
      step: InsuranceProcessingStep.initiated,
      progress: 0.1,
      productName: cubit.selectedProduct?.name ?? 'Insurance',
      premium: cubit.quote?.premium ?? 0,
      currency: cubit.quote?.currency ?? '',
    );
  }

  Widget _buildProcessingView(InsurancePurchaseProcessing state) {
    return _buildProcessingContent(
      step: state.step,
      progress: state.progress,
      productName: state.product.name,
      premium: state.quote.premium,
      currency: state.quote.currency,
    );
  }

  Widget _buildSuccessView(InsurancePurchaseSuccess state) {
    return SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 100.w, height: 100.w,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF10B981)),
            child: Icon(Icons.check, size: 60.sp, color: Colors.white),
          ),
          SizedBox(height: 24.h),
          Text('Purchase Successful!',
            style: GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.w800, color: Colors.white)),
          SizedBox(height: 8.h),
          Text('Policy #${state.purchaseResult.policyNumber}',
            style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
        ]),
      ),
    );
  }

  Widget _buildProcessingContent({
    required InsuranceProcessingStep step,
    required double progress,
    required String productName,
    required double premium,
    required String currency,
  }) {
    final formatter = NumberFormat('#,##0.00');

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),

              // Animated icon
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 100.w, height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                      ),
                      child: Icon(Icons.shield_outlined, size: 50.sp, color: const Color(0xFF6366F1)),
                    ),
                  );
                },
              ),

              SizedBox(height: 32.h),

              Text('Processing Purchase',
                style: GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              SizedBox(height: 8.h),
              Text(_stepMessage(step),
                style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),

              SizedBox(height: 32.h),

              // Progress bar
              Container(
                width: double.infinity, height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(3.r)),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                      borderRadius: BorderRadius.circular(3.r)),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text('${(progress * 100).toInt()}%',
                style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF9CA3AF))),

              SizedBox(height: 32.h),

              // Purchase details card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Column(children: [
                  _buildDetailRow('Product', productName),
                  SizedBox(height: 12.h),
                  _buildDetailRow('Amount', '$currency ${formatter.format(premium)}'),
                ]),
              ),

              SizedBox(height: 24.h),

              // Processing steps
              _buildProcessingSteps(step),

              SizedBox(height: 24.h),

              // Security note
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.lock_outline, size: 14.sp, color: const Color(0xFF6366F1)),
                  SizedBox(width: 6.w),
                  Text('Payment secured with end-to-end encryption',
                    style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF6366F1))),
                ]),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
      Text(value, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
    ]);
  }

  Widget _buildProcessingSteps(InsuranceProcessingStep currentStep) {
    final steps = [
      (InsuranceProcessingStep.initiated, 'Initiating purchase...'),
      (InsuranceProcessingStep.validatingPin, 'Validating transaction PIN...'),
      (InsuranceProcessingStep.holdingFunds, 'Securing payment...'),
      (InsuranceProcessingStep.purchasingPolicy, 'Purchasing insurance policy...'),
      (InsuranceProcessingStep.completed, 'Insurance purchased!'),
    ];

    return Column(
      children: steps.map((entry) {
        final stepEnum = entry.$1;
        final label = entry.$2;
        final isCompleted = stepEnum.index < currentStep.index;
        final isActive = stepEnum == currentStep;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(children: [
            Container(
              width: 24.w, height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? const Color(0xFF10B981)
                    : isActive
                        ? const Color(0xFF6366F1)
                        : Colors.white.withValues(alpha: 0.1),
              ),
              child: Icon(
                isCompleted ? Icons.check : isActive ? Icons.sync : Icons.circle,
                size: 14.sp,
                color: isCompleted || isActive ? Colors.white : const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(width: 12.w),
            Text(label, style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: isCompleted || isActive ? Colors.white : const Color(0xFF9CA3AF),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)),
          ]),
        );
      }).toList(),
    );
  }

  String _stepMessage(InsuranceProcessingStep step) {
    switch (step) {
      case InsuranceProcessingStep.initiated:
        return 'Initiating your insurance purchase...';
      case InsuranceProcessingStep.validatingPin:
        return 'Validating your transaction PIN...';
      case InsuranceProcessingStep.holdingFunds:
        return 'Securing payment from your account...';
      case InsuranceProcessingStep.purchasingPolicy:
        return 'Purchasing your insurance policy...';
      case InsuranceProcessingStep.completed:
        return 'Purchase completed successfully!';
      case InsuranceProcessingStep.failed:
        return 'Purchase failed. Please try again.';
    }
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Purchase Failed', style: GoogleFonts.inter(color: Colors.white)),
        content: Text(error, style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
            child: Text('Go Back', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(dialogContext).pop();
              _showPinDialog(); // Re-enter PIN to retry
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                borderRadius: BorderRadius.circular(8.r)),
              child: Text('Retry', style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
