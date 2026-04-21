import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_state.dart';

class CableTVPaymentProcessingScreen extends StatefulWidget {
  const CableTVPaymentProcessingScreen({super.key});

  @override
  State<CableTVPaymentProcessingScreen> createState() =>
      _CableTVPaymentProcessingScreenState();
}

class _CableTVPaymentProcessingScreenState
    extends State<CableTVPaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _paymentTriggered = false;
  bool _hasNavigated = false;
  bool _hasFailed = false;
  String _failMessage = '';
  int _currentStep = 0;

  static const _steps = [
    _ProcessingStep(
      title: 'Payment Initiated',
      subtitle: 'Your subscription request has been submitted',
      icon: Icons.receipt_long,
      activeColor: Color(0xFF4E03D0),
    ),
    _ProcessingStep(
      title: 'Validating Smart Card',
      subtitle: 'Verifying smart card and account details',
      icon: Icons.credit_card,
      activeColor: Color(0xFF4E03D0),
    ),
    _ProcessingStep(
      title: 'Processing Subscription',
      subtitle: 'Debiting your account and contacting provider',
      icon: Icons.sync,
      activeColor: Color(0xFFFB923C),
    ),
    _ProcessingStep(
      title: 'Subscription Active',
      subtitle: 'Your cable TV subscription has been activated',
      icon: Icons.live_tv,
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
    if (args == null) {
      Get.back();
      return;
    }
    try {
      final provider = args['provider'] as CableTVProviderEntity;
      final package = args['package'] as TVPackageEntity;
      final smartCardNumber = args['smartCardNumber'] as String;
      final transactionId = args['transactionId'] as String;
      final verificationToken = args['verificationToken'] as String;
      final idempotencyKey = args['idempotencyKey'] as String;

      context.read<CableTVCubit>().paySubscription(
            providerId: provider.serviceId,
            smartCardNumber: smartCardNumber,
            variationCode: package.variationCode,
            amount: package.amount,
            phone: smartCardNumber,
            transactionId: transactionId,
            verificationToken: verificationToken,
            idempotencyKey: idempotencyKey,
          );
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasFailed = true;
          _failMessage = 'Could not start payment: $e';
        });
      }
    }
  }

  int _stepIndexFromLabel(String label) {
    switch (label) {
      case 'Payment Initiated':
        return 0;
      case 'Validating Smart Card':
        return 1;
      case 'Processing Subscription':
        return 2;
      case 'Subscription Active':
        return 3;
      default:
        return _currentStep;
    }
  }

  void _navigateToReceipt(dynamic payment) {
    if (!mounted) return;
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    Get.offNamed(
      AppRoutes.cableTVPaymentReceipt,
      arguments: {
        'payment': payment,
        'provider': args['provider'],
        'package': args['package'],
        'smartCardNumber': args['smartCardNumber'],
        'saveBeneficiary': args['saveBeneficiary'] ?? false,
        'beneficiaryNickname': args['beneficiaryNickname'],
        'autoRenewEnabled': args['autoRenewEnabled'] ?? false,
        'rolloverPref': args['rolloverPref'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final provider = args?['provider'] as CableTVProviderEntity?;
    final package = args?['package'] as TVPackageEntity?;
    final smartCardNumber = args?['smartCardNumber'] as String? ?? '';
    final fmt = NumberFormat('#,##0', 'en_NG');

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _hasFailed) {
          Get.offAllNamed(AppRoutes.cableTVHome);
          return;
        }
        if (!didPop) {
          Get.snackbar(
            'Payment in Progress',
            'Please wait while your payment is being processed.',
            backgroundColor: const Color(0xFFFB923C),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: BlocListener<CableTVCubit, CableTVState>(
            listener: (context, state) {
              if (_hasNavigated) return;
              if (state is CableTVPaymentProcessing) {
                final idx = _stepIndexFromLabel(state.currentStep);
                if (idx != _currentStep && mounted) {
                  setState(() => _currentStep = idx);
                }
              } else if (state is CableTVPaymentSuccess) {
                _hasNavigated = true;
                _navigateToReceipt(state.payment);
              } else if (state is CableTVPaymentFailed) {
                _hasNavigated = true;
                if (mounted) {
                  setState(() {
                    _hasFailed = true;
                    _failMessage = state.message;
                  });
                }
              } else if (state is CableTVError) {
                _hasNavigated = true;
                if (mounted) {
                  setState(() {
                    _hasFailed = true;
                    _failMessage = state.message;
                  });
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  _buildStepIndicators(),
                  SizedBox(height: 40.h),
                  // Payment summary card
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                          color: const Color(0xFF2D2D2D), width: 1),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                            'Provider', provider?.name ?? '—'),
                        const Divider(
                            color: Color(0xFF2D2D2D), height: 24),
                        _buildSummaryRow(
                            'Smart Card', smartCardNumber),
                        const Divider(
                            color: Color(0xFF2D2D2D), height: 24),
                        _buildSummaryRow(
                          'Package',
                          package?.name ?? '—',
                        ),
                        const Divider(
                            color: Color(0xFF2D2D2D), height: 24),
                        _buildSummaryRow(
                          'Amount',
                          package != null
                              ? '₦${fmt.format(package.amount)}'
                              : '—',
                          valueColor: const Color(0xFF10B981),
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  if (_hasFailed) _buildFailureInfo() else _buildSecurityNote(),
                  if (_hasFailed) ...[
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Get.offAllNamed(AppRoutes.cableTVHome),
                        icon: Icon(Icons.arrow_back,
                            size: 18.sp, color: Colors.white),
                        label: Text(
                          'Back to Cable TV',
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
                  ],
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
                  builder: (context, _) {
                    final scale = isActive
                        ? 1.0 + (_pulseController.value * 0.08)
                        : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFailed
                              ? const Color(0xFFEF4444)
                                  .withValues(alpha: 0.15)
                              : isCompleted || isActive
                                  ? step.activeColor
                                      .withValues(alpha: 0.15)
                                  : const Color(0xFF1F1F1F),
                          border: Border.all(
                            color: isFailed
                                ? const Color(0xFFEF4444)
                                : isCompleted || isActive
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
                              : isCompleted || isActive
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
                              ? const Color(0xFFEF4444)
                                  .withValues(alpha: 0.8)
                              : isCompleted || isActive
                                  ? const Color(0xFF9CA3AF)
                                  : const Color(0xFF4B5563),
                          fontSize: 12.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (isActive)
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFailureInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline,
              color: const Color(0xFFEF4444), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              _failMessage.isEmpty
                  ? 'Something went wrong. Please try again.'
                  : _failMessage,
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
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
