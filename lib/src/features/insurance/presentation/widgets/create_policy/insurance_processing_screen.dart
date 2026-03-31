import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';
import '../../../domain/entities/insurance_product_entity.dart';

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
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePolicyCubit, CreatePolicyState>(
      listener: (context, state) {
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
          // Show error and go back
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text((state as CreatePolicyError).message),
              backgroundColor: const Color(0xFFEF4444),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is! InsurancePurchaseProcessing &&
            state is! InsurancePurchaseSuccess) {
          return const Scaffold(
            backgroundColor: Color(0xFF0A0A0A),
            body: Center(child: CircularProgressIndicator(color: Color(0xFF6366F1))),
          );
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
      icon = SizedBox(
        width: 20.sp,
        height: 20.sp,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
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

class _ProgressStep {
  final int id;
  final String title;
  final String subtitle;
  final IconData icon;

  const _ProgressStep({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

/// Receipt/Success screen shown after successful insurance purchase
class InsurancePurchaseReceiptScreen extends StatelessWidget {
  final dynamic purchaseResult;
  final InsuranceProduct product;
  final InsuranceQuote quote;

  const InsurancePurchaseReceiptScreen({
    super.key,
    required this.purchaseResult,
    required this.product,
    required this.quote,
  });

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

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00');
    final now = DateTime.now();

    // Extract data from purchaseResult - handle both map and object
    final policyNumber = purchaseResult is Map
        ? (purchaseResult as Map)['policy_number'] ?? 'Processing...'
        : purchaseResult.policyNumber.toString();
    final status = purchaseResult is Map
        ? (purchaseResult as Map)['status'] ?? 'active'
        : purchaseResult.status.toString();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),

              // Success animation
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: const Color(0xFF10B981),
                  size: 48.sp,
                ),
              ),
              SizedBox(height: 24.h),

              Text(
                'Purchase Successful!',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your insurance policy is now active',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 32.h),

              // Policy details card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Policy Details',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    _buildReceiptRow('Policy Number', policyNumber),
                    _buildReceiptRow('Status', status.replaceAll('_', ' ').toUpperCase()),
                    Divider(color: const Color(0xFF2D2D2D), height: 24.h),
                    _buildReceiptRow('Product', product.name),
                    _buildReceiptRow('Provider', product.providerName),
                    _buildReceiptRow('Category', product.category.displayName),
                    Divider(color: const Color(0xFF2D2D2D), height: 24.h),
                    _buildReceiptRow('Premium Amount',
                        '${_currencySymbol(quote.currency)}${formatter.format(quote.premium)}',
                        isAmount: true),
                    if (quote.coverageItems.isNotEmpty)
                      _buildReceiptRow('Coverage', quote.coverageItems.first),
                    SizedBox(height: 16.h),
                    _buildReceiptRow('Purchase Date',
                        DateFormat('MMM dd, yyyy • HH:mm').format(now)),
                    _buildReceiptRow('Reference',
                        purchaseResult is Map
                            ? (purchaseResult as Map)['reference'] ?? 'N/A'
                            : (purchaseResult.reference?.toString() ?? 'N/A')),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Coverage highlights
              if (quote.coverageItems.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coverage Highlights',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ...quote.coverageItems.take(4).map((item) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xFF10B981),
                              size: 16.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                item,
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],

              // Action buttons
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Back to Dashboard',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'You can view your policy details in the Insurance section',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: isAmount ? FontWeight.w700 : FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
