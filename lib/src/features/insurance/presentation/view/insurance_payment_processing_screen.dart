import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';

class InsurancePaymentProcessingScreen extends StatefulWidget {
  final InsurancePayment payment;

  const InsurancePaymentProcessingScreen({
    super.key,
    required this.payment,
  });

  @override
  State<InsurancePaymentProcessingScreen> createState() => _InsurancePaymentProcessingScreenState();
}

class _InsurancePaymentProcessingScreenState extends State<InsurancePaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // Start animations
    _pulseController.repeat(reverse: true);
    _rotationController.repeat();

    // Start payment processing
    context.read<InsuranceCubit>().processPayment(widget.payment);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation during processing
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0E27),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A3E),
                const Color(0xFF0A0E27),
                const Color(0xFF0F0F23),
              ],
            ),
          ),
          child: BlocConsumer<InsuranceCubit, InsuranceState>(
          listener: (context, state) {
            if (state is PaymentCompleted) {
              // Navigate to confirmation screen using route
              Get.offNamed(
                AppRoutes.insurancePaymentConfirmation,
                arguments: {
                  'payment': state.payment,
                  'receiptUrl': state.receiptUrl,
                },
              );
            } else if (state is PaymentFailed) {
              // Show error and navigate back
              _showErrorDialog(state.error);
            }
          },
          builder: (context, state) {
            if (state is PaymentProcessing) {
              return _buildProcessingView(state);
            }
            
            return _buildProcessingView(PaymentProcessing(
              payment: widget.payment,
              step: 'Initializing payment...',
              progress: 0.1,
            ));
          },
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingView(PaymentProcessing state) {
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
            
            // Animated processing icon
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value * 2 * 3.14159,
                        child: Container(
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.2),
                            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                          ),
                          child: Icon(
                            Icons.shield_outlined,
                            size: 60.sp,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

              SizedBox(height: 32.h),

            // Processing title
            Text(
              'Processing Payment',
                style: GoogleFonts.inter(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

              SizedBox(height: 12.h),

            // Processing step
            Text(
              state.step,
                style: GoogleFonts.inter(
                fontSize: 16.sp,
                  color: Colors.white.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),

              SizedBox(height: 32.h),

            // Progress bar
            Container(
              width: double.infinity,
              height: 8.h,
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: state.progress,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),

              SizedBox(height: 12.h),

            // Progress percentage
            Text(
              '${(state.progress * 100).toInt()}%',
                style: GoogleFonts.inter(
                fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),

              SizedBox(height: 32.h),

            // Payment details card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF2A2A3E).withValues(alpha: 0.8),
                      const Color(0xFF1F1F35).withValues(alpha: 0.9),
                    ],
                  ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                          style: GoogleFonts.inter(
                          fontSize: 14.sp,
                            color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        '\$${widget.payment.amount.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                            color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Policy Number',
                          style: GoogleFonts.inter(
                          fontSize: 14.sp,
                            color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        widget.payment.policyNumber,
                          style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method',
                          style: GoogleFonts.inter(
                          fontSize: 14.sp,
                            color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      Row(
                        children: [
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                            widget.payment.paymentMethod.icon,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            widget.payment.paymentMethod.displayName,
                              style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

              SizedBox(height: 24.h),

            // Processing steps indicator
            _buildProcessingSteps(state.progress),

              SizedBox(height: 32.h),

            // Security note
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                ),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 16.sp,
                      color: const Color(0xFF6366F1),
                ),
                SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                  'Your payment is secured with end-to-end encryption',
                        style: GoogleFonts.inter(
                    fontSize: 12.sp,
                          color: const Color(0xFF6366F1),
                        ),
                        textAlign: TextAlign.center,
                  ),
                ),
              ],
                ),
            ),

            SizedBox(height: 40.h),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingSteps(double progress) {
    final steps = _getProcessingSteps();
    
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final stepProgress = (index + 1) / steps.length;
        final isCompleted = progress >= stepProgress;
        final isActive = progress > (index / steps.length) && progress <= stepProgress;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted 
                      ? const Color(0xFF10B981)
                      : isActive 
                          ? const Color(0xFF6366F1)
                          : Colors.white.withValues(alpha: 0.2),
                ),
                child: Icon(
                  isCompleted ? Icons.check : Icons.circle,
                  size: 14.sp,
                  color: isCompleted || isActive ? Colors.white : const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  step,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: isCompleted || isActive 
                        ? Colors.white 
                        : const Color(0xFF9CA3AF),
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<String> _getProcessingSteps() {
    switch (widget.payment.paymentMethod) {
      case PaymentMethod.card:
        return [
          'Validating card details',
          'Processing with bank',
          'Confirming transaction',
          'Updating policy status'
        ];
      case PaymentMethod.bankTransfer:
        return [
          'Initiating bank transfer',
          'Verifying account details',
          'Processing transfer',
          'Confirming payment'
        ];
      case PaymentMethod.mobileMoney:
        return [
          'Connecting to mobile money',
          'Authenticating payment',
          'Processing transaction',
          'Confirming payment'
        ];
      case PaymentMethod.crypto:
        return [
          'Validating wallet',
          'Broadcasting transaction',
          'Waiting for confirmations',
          'Payment confirmed'
        ];
      case PaymentMethod.wallet:
        return [
          'Checking wallet balance',
          'Authorizing payment',
          'Processing transaction',
          'Payment completed'
        ];
    }
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Payment Failed',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Text(
          error,
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.back(); // Return to previous screen
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
            ),
              child: Text(
              'Try Again',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 