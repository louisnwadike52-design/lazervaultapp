import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/airtime_to_cash_conversion.dart';
import '../cubit/airtime_to_cash_cubit.dart';
import '../cubit/airtime_to_cash_state.dart';

class A2CProcessingScreen extends StatefulWidget {
  const A2CProcessingScreen({super.key});

  @override
  State<A2CProcessingScreen> createState() => _A2CProcessingScreenState();
}

class _A2CProcessingScreenState extends State<A2CProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  Timer? _timeoutTimer;
  bool _hasTimedOut = false;

  Map<String, dynamic>? _params;
  bool _isAlreadyProcessed = false;
  bool _isProcessingPending = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _setupAnimations();
    _startProcessing();
  }

  void _loadArguments() {
    _params = Get.arguments as Map<String, dynamic>?;
    _isAlreadyProcessed = _params?['isAlreadyProcessed'] == true;
    _isProcessingPending = _params?['isProcessingPending'] == true;
  }

  void _startProcessing() {
    if (_params == null) {
      // Missing params — show error and navigate back
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Get.offNamed(AppRoutes.airtimeToCashResult, arguments: {
            'isSuccess': false,
            'errorMessage': 'Missing conversion data. Please try again.',
          });
        }
      });
      return;
    }

    if (_isAlreadyProcessed) {
      final conversion = _params!['conversion'] as AirtimeToCashConversion?;

      if (_isProcessingPending && conversion != null) {
        // Conversion submitted but wallet credit pending via webhook
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Get.offNamed(AppRoutes.airtimeToCashResult, arguments: {
              'isSuccess': true,
              'isProcessingPending': true,
              'conversion': conversion,
              'message': _params!['message'] ??
                  'Your conversion is being processed. You\'ll be notified when cash is credited to your wallet.',
              'phoneNumber': _params!['phoneNumber'],
              'network': _params!['network'],
              'amount': _params!['amount'],
              'rate': _params!['rate'],
              'estimatedCash': _params!['estimatedCash'],
            });
          }
        });
        return;
      }

      // Conversion was already completed in the review screen PIN flow
      final newBalance = _params!['newBalance'] as double?;
      if (conversion != null) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Get.offNamed(AppRoutes.airtimeToCashResult, arguments: {
              'isSuccess': true,
              'conversion': conversion,
              'newBalance': newBalance ?? 0.0,
              'phoneNumber': _params!['phoneNumber'],
              'network': _params!['network'],
              'amount': _params!['amount'],
              'rate': _params!['rate'],
              'estimatedCash': _params!['estimatedCash'],
            });
          }
        });
        return;
      }
    }

    // Validate required params before starting
    final phoneNumber = _params!['phoneNumber'] as String?;
    final network = _params!['network'] as String?;
    final amount = _params!['amount'] as double?;
    final sessionToken = _params!['sessionToken'] as String?;
    final transactionId = _params!['transactionId'] as String?;
    final verificationToken = _params!['verificationToken'] as String?;

    if (phoneNumber == null || network == null || amount == null ||
        sessionToken == null || transactionId == null || verificationToken == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Get.offNamed(AppRoutes.airtimeToCashResult, arguments: {
            'isSuccess': false,
            'errorMessage': 'Invalid conversion data. Please try again.',
          });
        }
      });
      return;
    }

    // Start timeout timer (120 seconds)
    _timeoutTimer = Timer(const Duration(seconds: 120), _onTimeout);

    // Start the conversion process
    context.read<AirtimeToCashCubit>().processConversion(
          phoneNumber: phoneNumber,
          network: network,
          amount: amount,
          sessionToken: sessionToken,
          transactionId: transactionId,
          verificationToken: verificationToken,
          sourceAccountId: _params!['sourceAccountId'] as String?,
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

  void _onTimeout() {
    if (!mounted || _hasTimedOut) return;
    setState(() => _hasTimedOut = true);
  }

  void _retryConversion() {
    _timeoutTimer?.cancel();
    setState(() => _hasTimedOut = false);
    _startProcessing();
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
        child: BlocConsumer<AirtimeToCashCubit, AirtimeToCashState>(
          listener: (context, state) {
            if (state is AirtimeToCashSuccess) {
              _timeoutTimer?.cancel();
              Get.offNamed(AppRoutes.airtimeToCashResult, arguments: {
                'isSuccess': true,
                'conversion': state.conversion,
                'newBalance': state.newBalance,
                'phoneNumber': _params?['phoneNumber'],
                'network': _params?['network'],
                'amount': _params?['amount'],
                'rate': _params?['rate'],
                'estimatedCash': _params?['estimatedCash'],
              });
            } else if (state is AirtimeToCashProcessingPending) {
              _timeoutTimer?.cancel();
              Get.offNamed(AppRoutes.airtimeToCashResult, arguments: {
                'isSuccess': true,
                'isProcessingPending': true,
                'conversion': state.conversion,
                'message': state.message,
                'phoneNumber': _params?['phoneNumber'],
                'network': _params?['network'],
                'amount': _params?['amount'],
                'rate': _params?['rate'],
                'estimatedCash': _params?['estimatedCash'],
              });
            } else if (state is AirtimeToCashFailed) {
              _timeoutTimer?.cancel();
              Get.offNamed(AppRoutes.airtimeToCashResult, arguments: {
                'isSuccess': false,
                'errorMessage': state.message,
                'phoneNumber': _params?['phoneNumber'],
                'network': _params?['network'],
                'amount': _params?['amount'],
                'rate': _params?['rate'],
                'estimatedCash': _params?['estimatedCash'],
              });
            }
          },
          builder: (context, state) {
            if (_hasTimedOut) {
              return _buildTimeoutUI();
            }

            double progress = 0.1;
            String currentStep = 'Initializing conversion...';

            if (state is AirtimeToCashProcessing) {
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
                      _buildProcessingAnimation(),
                      SizedBox(height: 40.h),
                      _buildProcessingText(currentStep),
                      SizedBox(height: 32.h),
                      _buildProgressBar(progress),
                      SizedBox(height: 32.h),
                      _buildProcessingSteps(progress),
                      SizedBox(height: 32.h),
                      _buildSecurityNote(),
                      SizedBox(height: 32.h),
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
              'Conversion Timeout',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'The conversion is taking longer than expected.\nYou can retry or go back to check your history.',
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
                onPressed: _retryConversion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Retry Conversion',
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
                onPressed: () =>
                    Get.offAllNamed(AppRoutes.airtimeToCashHistory),
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
                  'Check Conversion History',
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
                      colors: [
                        Color(0xFF3B82F6),
                        Color.fromARGB(255, 78, 3, 208),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(0xFF3B82F6).withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.swap_horiz,
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

  Widget _buildProcessingText(String currentStep) {
    return Column(
      children: [
        Text(
          'Processing Conversion',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          currentStep,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressBar(double progress) {
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
                  colors: [
                    Color(0xFF3B82F6),
                    Color.fromARGB(255, 78, 3, 208),
                  ],
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
      'Validating...',
      'Initiating transfer...',
      'Transferring airtime...',
      'Crediting wallet...',
    ];
    final stepThresholds = [0.2, 0.4, 0.6, 0.8];

    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final threshold = stepThresholds[index];
        final isCompleted = progress >= threshold;
        final isActive = index > 0
            ? progress > stepThresholds[index - 1] && progress < threshold
            : progress > 0 && progress < threshold;

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
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
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
              'Your conversion is secured with end-to-end encryption',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF3B82F6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails() {
    final phoneNum = _params!['phoneNumber'] as String? ?? '';
    final networkName = _params!['network'] as String? ?? '';
    final amt = _params!['amount'] as double? ?? 0;

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
            'Conversion Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(
              'Airtime Amount', '\u20A6${amt.toStringAsFixed(0)}'),
          SizedBox(height: 8.h),
          _buildDetailRow('Phone Number', phoneNum),
          SizedBox(height: 8.h),
          _buildDetailRow('Network', networkName),
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
