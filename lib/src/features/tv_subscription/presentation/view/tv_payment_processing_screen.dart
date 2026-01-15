import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../../domain/entities/tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../domain/entities/smartcard_validation_result.dart';
import '../../domain/entities/tv_payment_entity.dart';
import '../cubit/tv_subscription_cubit.dart';
import '../cubit/tv_subscription_state.dart';

class TVPaymentProcessingScreen extends StatefulWidget {
  const TVPaymentProcessingScreen({super.key});

  @override
  State<TVPaymentProcessingScreen> createState() => _TVPaymentProcessingScreenState();
}

class _TVPaymentProcessingScreenState extends State<TVPaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  Timer? _pollingTimer;
  String? _currentPaymentId;

  @override
  void initState() {
    super.initState();

    // Initialize dual animations
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
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _pollingTimer?.cancel();
    super.dispose();
  }

  void _startPolling(String paymentId) {
    if (_currentPaymentId == paymentId) return;
    _currentPaymentId = paymentId;

    // Poll every 3 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      context.read<TVSubscriptionCubit>().verifyPayment(paymentId: paymentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as TVProviderEntity;
    final package = args['package'] as TVPackageEntity;
    final validationResult = args['validationResult'] as SmartcardValidationResult;
    final initialPayment = args['payment'] as TVPaymentEntity;

    return PopScope(
      canPop: false,
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
          child: BlocConsumer<TVSubscriptionCubit, TVSubscriptionState>(
            listener: (context, state) {
              if (state is PaymentInitiated || state is PaymentProcessing) {
                final payment = state is PaymentInitiated
                    ? state.payment
                    : (state as PaymentProcessing).payment;

                _startPolling(payment.id);
              }

              if (state is PaymentSuccess) {
                _pollingTimer?.cancel();

                Get.off(
                  () => const TVPaymentReceiptScreen(),
                  arguments: {'payment': state.payment},
                );
              }

              if (state is PaymentFailed) {
                _pollingTimer?.cancel();

                Get.snackbar(
                  'Payment Failed',
                  state.errorMessage,
                  backgroundColor: Colors.red.withValues(alpha: 0.9),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 5),
                );

                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) {
                    Get.back();
                    Get.back();
                  }
                });
              }

              if (state is TVSubscriptionError) {
                _pollingTimer?.cancel();

                Get.snackbar(
                  'Error',
                  state.message,
                  backgroundColor: Colors.red.withValues(alpha: 0.9),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 5),
                );
              }
            },
            builder: (context, state) {
              String currentStep = 'Initializing...';
              double progress = 0.1;
              TVPaymentEntity payment = initialPayment;

              if (state is PaymentProcessing) {
                currentStep = state.currentStep;
                progress = state.progress;
                payment = state.payment;
              } else if (state is PaymentVerifying) {
                currentStep = 'Verifying payment...';
                progress = 0.7;
              }

              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),

                      // Dual animated processing icon (pulse + rotation)
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
                                      Icons.tv,
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
                        currentStep,
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
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
                              ),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Progress percentage
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Payment details card
                      _buildPaymentDetailsCard(provider, package, validationResult, payment.amount),

                      SizedBox(height: 24.h),

                      // Processing steps indicator
                      _buildProcessingSteps(progress),

                      SizedBox(height: 32.h),

                      // Security note
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
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
                              color: const Color(0xFF8B5CF6),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Your payment is secured with end-to-end encryption',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF8B5CF6),
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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard(
    TVProviderEntity provider,
    TVPackageEntity package,
    SmartcardValidationResult validationResult,
    double amount,
  ) {
    return Container(
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
          _buildDetailRow('Provider', provider.providerName, Icons.tv),
          SizedBox(height: 16.h),
          _buildDetailRow('Package', package.packageName, Icons.subscriptions),
          SizedBox(height: 16.h),
          _buildDetailRow('Customer', validationResult.customerName, Icons.person),
          SizedBox(height: 16.h),
          _buildDetailRow('Smartcard', validationResult.smartcardNumber, Icons.credit_card),
          SizedBox(height: 16.h),
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
                '₦${amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Icon(
          icon,
          color: const Color(0xFF8B5CF6),
          size: 20.sp,
        ),
      ],
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
                          ? const Color(0xFF8B5CF6)
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
                    color: isCompleted || isActive ? Colors.white : const Color(0xFF9CA3AF),
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
    return [
      'Validating smartcard number',
      'Checking account balance',
      'Processing with provider',
      'Activating subscription',
      'Confirming payment',
    ];
  }
}

class TVPaymentReceiptScreen extends StatelessWidget {
  const TVPaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final payment = args['payment'] as TVPaymentEntity;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
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
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success Icon
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF34D399)],
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 60.sp,
                  ),
                ),
                SizedBox(height: 32.h),

                // Success Message
                Text(
                  'Subscription Activated!',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Your TV subscription has been activated successfully',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),

                // Receipt Card
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
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Receipt Details',
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildReceiptRow('Transaction ID', payment.transactionReference ?? payment.id),
                      SizedBox(height: 12.h),
                      _buildReceiptRow('Provider', payment.providerName),
                      SizedBox(height: 12.h),
                      _buildReceiptRow('Package', payment.packageName),
                      SizedBox(height: 12.h),
                      _buildReceiptRow('Smartcard Number', payment.smartcardNumber),
                      SizedBox(height: 12.h),
                      _buildReceiptRow('Customer Name', payment.customerName),
                      SizedBox(height: 12.h),
                      _buildReceiptRow('Amount Paid', '₦${payment.amount.toStringAsFixed(2)}'),
                      SizedBox(height: 12.h),
                      _buildReceiptRow('Duration', '${payment.duration} Days'),
                      SizedBox(height: 12.h),
                      if (payment.renewalDate != null) ...[
                        _buildReceiptRow('New Renewal Date', payment.renewalDate!),
                        SizedBox(height: 12.h),
                      ],
                      _buildReceiptRow(
                        'Payment Date',
                        '${payment.completedAt?.toLocal().toString().split('.')[0] ?? payment.createdAt.toLocal().toString().split('.')[0]}',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                // Buttons
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.backUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12.sp,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
