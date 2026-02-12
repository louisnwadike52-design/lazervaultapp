import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../cubit/education_cubit.dart';
import '../cubit/education_state.dart';

class EducationPaymentProcessingScreen extends StatefulWidget {
  const EducationPaymentProcessingScreen({super.key});

  @override
  State<EducationPaymentProcessingScreen> createState() =>
      _EducationPaymentProcessingScreenState();
}

class _EducationPaymentProcessingScreenState
    extends State<EducationPaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  Map<String, dynamic>? _params;
  bool _purchaseTriggered = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _setupAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerPurchase();
    });
  }

  void _loadArguments() {
    _params = Get.arguments as Map<String, dynamic>?;
  }

  void _triggerPurchase() {
    if (_purchaseTriggered || _params == null) return;
    _purchaseTriggered = true;

    final provider = _params!['provider'] as EducationProviderEntity;
    final quantity = _params!['quantity'] as int;
    final phone = _params!['phone'] as String;
    final transactionId = _params!['transactionId'] as String;
    final verificationToken = _params!['verificationToken'] as String;
    final idempotencyKey = _params!['idempotencyKey'] as String;

    context.read<EducationCubit>().purchasePin(
          serviceId: provider.serviceId,
          quantity: quantity,
          phone: phone,
          transactionId: transactionId,
          verificationToken: verificationToken,
          idempotencyKey: idempotencyKey,
        );
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
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

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<EducationCubit, EducationState>(
          listener: (context, state) {
            if (state is EducationPurchaseSuccess) {
              Get.offNamed(AppRoutes.educationPinResult, arguments: {
                'purchase': state.purchase,
                'provider': _params?['provider'],
              });
            } else if (state is EducationPurchaseFailed) {
              Get.snackbar(
                'Purchase Failed',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 4),
              );
              // Navigate back to confirmation screen
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  Get.back();
                }
              });
            }
          },
          builder: (context, state) {
            double progress = 0.1;
            String currentStep = 'Initializing purchase...';

            if (state is EducationPurchaseProcessing) {
              progress = state.progress;
              currentStep = state.currentStep;
            }

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
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

                      // Processing text
                      _buildProcessingText(state, currentStep),

                      SizedBox(height: 32.h),

                      // Processing steps
                      if (state is EducationPurchaseProcessing ||
                          state is EducationInitial)
                        _buildProcessingSteps(progress),

                      SizedBox(height: 32.h),

                      // Security note
                      if (state is EducationPurchaseProcessing ||
                          state is EducationInitial)
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock_outline,
                                size: 16.sp,
                                color: const Color(0xFF3B82F6),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  'Your payment is secured with end-to-end encryption',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF3B82F6),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: 32.h),

                      // Transaction details
                      if (_params != null) _buildTransactionDetails(),

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
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
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
              color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
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
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.school,
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

  Widget _buildProcessingText(EducationState state, String currentStep) {
    String title = 'Processing Purchase';
    String subtitle =
        'Please wait while we process your education PIN purchase.\nThis may take a few moments.';

    if (state is EducationPurchaseSuccess) {
      title = 'Purchase Successful!';
      subtitle =
          'Your education PINs have been generated.\nRedirecting to results...';
    } else if (state is EducationPurchaseFailed) {
      title = 'Purchase Failed';
      subtitle =
          'There was an issue processing your purchase.\nPlease try again.';
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

        if (state is! EducationPurchaseSuccess &&
            state is! EducationPurchaseFailed)
          Text(
            currentStep,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),

        if (state is EducationPurchaseSuccess ||
            state is EducationPurchaseFailed) ...[
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

        // Progress bar
        if (state is EducationPurchaseProcessing || state is EducationInitial)
          _buildProgressBar(state),

        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildProgressBar(EducationState state) {
    double progress = 0.1;
    if (state is EducationPurchaseProcessing) {
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
                gradient: const LinearGradient(
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
    final steps = [
      'Validating purchase details',
      'Verifying account balance',
      'Processing payment',
      'Generating education PINs',
      'Confirming purchase',
    ];

    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final stepProgress = (index + 1) / steps.length;
        final isCompleted = progress >= stepProgress;
        final isActive =
            progress > (index / steps.length) && progress <= stepProgress;

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
                  color: isCompleted || isActive
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  step,
                  style: TextStyle(
                    fontSize: 13.sp,
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

  Widget _buildTransactionDetails() {
    final provider = _params!['provider'] as EducationProviderEntity?;
    final quantity = _params!['quantity'] as int? ?? 1;
    final totalAmount = _params!['totalAmount'] as double? ?? 0;
    final phone = _params!['phone'] as String? ?? '';

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
            'Purchase Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Provider', provider?.name ?? 'Unknown'),
          SizedBox(height: 8.h),
          _buildDetailRow('Quantity', '$quantity'),
          SizedBox(height: 8.h),
          _buildDetailRow('Phone', phone),
          SizedBox(height: 8.h),
          _buildDetailRow('Amount', '\u20A6${_formatAmount(totalAmount)}'),
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

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          result.write(',');
        }
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }
}
