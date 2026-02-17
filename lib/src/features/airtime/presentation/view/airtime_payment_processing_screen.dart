import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../../../../core/types/app_routes.dart';

class AirtimePaymentProcessingScreen extends StatefulWidget {
  const AirtimePaymentProcessingScreen({super.key});

  @override
  State<AirtimePaymentProcessingScreen> createState() => _AirtimePaymentProcessingScreenState();
}

class _AirtimePaymentProcessingScreenState extends State<AirtimePaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  Timer? _timeoutTimer;
  bool _hasTimedOut = false;

  Map<String, dynamic>? _paymentParams;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _setupAnimations();
    _startPaymentProcessing();
  }

  void _loadArguments() {
    _paymentParams = Get.arguments as Map<String, dynamic>?;
  }

  void _startPaymentProcessing() {
    if (_paymentParams == null) return;

    // Start timeout timer (120 seconds)
    _timeoutTimer = Timer(const Duration(seconds: 120), _onPaymentTimeout);

    // Call the real cubit method with all payment params
    context.read<AirtimeCubit>().processPaymentWithToken(
      countryCode: _paymentParams!['countryCode'] as String,
      networkProviderId: _paymentParams!['networkProviderId'] as String,
      phoneNumber: _paymentParams!['phoneNumber'] as String,
      amount: _paymentParams!['amount'] as double,
      currency: _paymentParams!['currency'] as String,
      transactionId: _paymentParams!['transactionId'] as String,
      verificationToken: _paymentParams!['verificationToken'] as String,
      sourceAccountId: _paymentParams!['sourceAccountId'] as String?,
      operatorId: _paymentParams!['operatorId'] as String?,
      reloadlyOperatorId: _paymentParams!['reloadlyOperatorId'] as String?,
    );
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: Duration(seconds: 3),
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

    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
  }

  void _onPaymentTimeout() {
    if (!mounted || _hasTimedOut) return;
    setState(() => _hasTimedOut = true);
  }

  void _retryPayment() {
    setState(() => _hasTimedOut = false);
    _startPaymentProcessing();
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
          child: BlocConsumer<AirtimeCubit, AirtimeState>(
            listener: (context, state) {
              if (state is AirtimePaymentSuccess) {
                _timeoutTimer?.cancel();
                Get.offNamed(AppRoutes.airtimePaymentConfirmation, arguments: {
                  'transaction': state.transaction,
                  'isSuccess': true,
                });
              } else if (state is AirtimePaymentFailed) {
                _timeoutTimer?.cancel();
                Get.offNamed(AppRoutes.airtimePaymentConfirmation, arguments: {
                  'transaction': state.transaction,
                  'isSuccess': false,
                  'errorMessage': state.message,
                });
              }
            },
            builder: (context, state) {
              if (_hasTimedOut) {
                return _buildTimeoutUI();
              }

              double progress = 0.1;
              String currentStep = 'Initializing payment...';

              if (state is AirtimePaymentProcessing) {
                progress = state.progress;
                currentStep = state.currentStep;
              }

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 60.h),

                        // Processing animation
                        _buildProcessingAnimation(),

                        SizedBox(height: 40.h),

                        // Processing text with state awareness
                        _buildProcessingText(state, currentStep),

                        SizedBox(height: 32.h),

                        // Processing steps indicator
                        if (state is AirtimePaymentProcessing || state is AirtimeInitial)
                          _buildProcessingSteps(progress),

                        SizedBox(height: 32.h),

                        // Security note
                        if (state is AirtimePaymentProcessing || state is AirtimeInitial)
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Color(0xFF3B82F6).withValues(alpha: 0.1),
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
                                  color: Color(0xFF3B82F6),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    'Your payment is secured with end-to-end encryption',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xFF3B82F6),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(height: 32.h),

                        // Transaction details from params
                        if (_paymentParams != null) _buildTransactionDetails(),

                        SizedBox(height: 60.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }

  Widget _buildTimeoutUI() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer_off_outlined,
              size: 64.sp,
              color: const Color(0xFFFB923C),
            ),
            SizedBox(height: 24.h),
            Text(
              'Payment Timeout',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'The payment is taking longer than expected.\nYou can retry or go back to check your transaction history.',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _retryPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Retry Payment',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.offAllNamed(AppRoutes.airtimeHistory),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Check Transaction History',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingAnimation() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulsing circle
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3B82F6).withValues(alpha: 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Middle circle
          Container(
            width: 140.w,
            height: 140.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF3B82F6).withValues(alpha: 0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),

          // Inner rotating circle with icon
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF3B82F6).withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.phone_android,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingText(AirtimeState state, String currentStep) {
    String title = 'Processing Payment';
    String subtitle = 'Please wait while we process your airtime purchase.\nThis may take a few moments.';

    if (state is AirtimePaymentSuccess) {
      title = 'Payment Successful!';
      subtitle = 'Your airtime has been successfully purchased.\nRedirecting to confirmation...';
    } else if (state is AirtimePaymentFailed) {
      title = 'Payment Failed';
      subtitle = 'There was an issue processing your payment.\nRedirecting to confirmation...';
    }

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 12.h),

        // Current step
        if (state is! AirtimePaymentSuccess && state is! AirtimePaymentFailed)
          Text(
            currentStep,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),

        if (state is AirtimePaymentSuccess || state is AirtimePaymentFailed) ...[
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],

        SizedBox(height: 32.h),

        // Progress indicator
        if (state is AirtimePaymentProcessing || state is AirtimeInitial)
          _buildProgressIndicator(state),

        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildProgressIndicator(AirtimeState state) {
    double progress = 0.1;

    if (state is AirtimePaymentProcessing) {
      progress = state.progress;
    }

    return Column(
      children: [
        Container(
          width: 200.w,
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
                gradient: LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w600,
          ),
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
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? const Color(0xFF10B981)
                      : isActive
                          ? const Color(0xFF3B82F6)
                          : Colors.white.withValues(alpha: 0.2),
                ),
                child: Icon(
                  isCompleted ? Icons.check : Icons.circle,
                  size: 12.sp,
                  color: isCompleted || isActive ? Colors.white : Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  step,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isCompleted || isActive ? Colors.white : Color(0xFF9CA3AF),
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
      'Validating phone number',
      'Checking account balance',
      'Processing with network provider',
      'Sending airtime',
      'Confirming payment',
    ];
  }

  Widget _buildTransactionDetails() {
    final amount = _paymentParams!['amount'] as double;
    final phoneNumber = _paymentParams!['phoneNumber'] as String;
    final providerName = _paymentParams!['providerName'] as String? ?? 'Unknown';
    final currency = _paymentParams!['currency'] as String? ?? 'NGN';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            'Transaction Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          _buildDetailRow('Amount', '$currency ${amount.toStringAsFixed(0)}'),
          SizedBox(height: 8.h),
          _buildDetailRow('Phone Number', phoneNumber),
          SizedBox(height: 8.h),
          _buildDetailRow('Network', providerName),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
