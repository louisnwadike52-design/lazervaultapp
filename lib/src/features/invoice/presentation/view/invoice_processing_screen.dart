import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/invoice_entity.dart';

enum InvoiceProcessingStatus {
  initiated,
  validating,
  processing,
  completed,
}

class InvoiceProcessingScreen extends StatefulWidget {
  final Invoice invoice;

  const InvoiceProcessingScreen({super.key, required this.invoice});

  @override
  State<InvoiceProcessingScreen> createState() =>
      _InvoiceProcessingScreenState();
}

class _InvoiceProcessingScreenState extends State<InvoiceProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _processingController;
  late AnimationController _fadeController;

  String get _currencySymbol {
    switch (widget.invoice.currency.toUpperCase()) {
      case 'NGN': return '₦';
      case 'GBP': return '£';
      case 'EUR': return '€';
      case 'ZAR': return 'R';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      case 'INR': return '₹';
      case 'JPY': return '¥';
      case 'USD': return '\$';
      default: return '₦';
    }
  }

  late AnimationController _pulseController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  InvoiceProcessingStatus _currentStatus = InvoiceProcessingStatus.initiated;
  String _statusMessage = 'Initiating payment...';
  bool _isCompleted = false;

  final List<_ProcessingStep> _steps = [
    _ProcessingStep(
      status: InvoiceProcessingStatus.initiated,
      title: 'Payment Initiated',
      description: 'Request received',
      icon: Icons.receipt_outlined,
    ),
    _ProcessingStep(
      status: InvoiceProcessingStatus.validating,
      title: 'Validating',
      description: 'Checking payment details',
      icon: Icons.verified_user_outlined,
    ),
    _ProcessingStep(
      status: InvoiceProcessingStatus.processing,
      title: 'Processing',
      description: 'Processing payment',
      icon: Icons.sync_outlined,
    ),
    _ProcessingStep(
      status: InvoiceProcessingStatus.completed,
      title: 'Completed',
      description: 'Payment successful',
      icon: Icons.check_circle_outline,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startProcessingSimulation();
  }

  void _setupAnimations() {
    _processingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _processingController, curve: Curves.linear),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.elasticOut),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _processingController.repeat();
    _fadeController.forward();
    _pulseController.repeat(reverse: true);
  }

  void _startProcessingSimulation() {
    Timer(const Duration(seconds: 1), () {
      if (mounted && !_isCompleted) {
        _updateStatus(
            InvoiceProcessingStatus.validating, 'Validating payment...');
      }
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted && !_isCompleted) {
        _updateStatus(
            InvoiceProcessingStatus.processing, 'Processing payment...');
      }
    });

    Future.delayed(const Duration(milliseconds: 4000), () {
      if (mounted && !_isCompleted) {
        _updateStatus(
            InvoiceProcessingStatus.completed, 'Payment successful!');
        _completePayment();
      }
    });
  }

  void _updateStatus(InvoiceProcessingStatus status, String message) {
    if (!mounted) return;
    setState(() {
      _currentStatus = status;
      _statusMessage = message;
    });
  }

  void _completePayment() {
    if (_isCompleted) return;
    _isCompleted = true;
    _processingController.stop();
    _pulseController.stop();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        Get.offNamed(
          AppRoutes.invoicePreview,
          arguments: widget.invoice,
        );
      }
    });
  }

  @override
  void dispose() {
    _processingController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              InvoiceThemeColors.primaryBackground,
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildProcessingContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isCompleted
                      ? 'Payment Complete!'
                      : 'Processing Payment...',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  _statusMessage,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            ScaleTransition(
              scale: _scaleAnimation,
              child: _buildProcessingIcon(),
            ),
            SizedBox(height: 32.h),
            _buildInvoiceDetailsCard(),
            SizedBox(height: 24.h),
            _buildProcessingSteps(),
            SizedBox(height: 24.h),
            _buildSecurityMessage(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingIcon() {
    return AnimatedBuilder(
      animation: _isCompleted ? _fadeAnimation : _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _isCompleted ? 0 : _rotationAnimation.value * 2 * 3.14159,
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _isCompleted ? 1.0 : _pulseAnimation.value,
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isCompleted
                          ? [Colors.green[600]!, Colors.green[400]!]
                          : [
                              InvoiceThemeColors.primaryPurple,
                              const Color(0xFF6366F1)
                            ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isCompleted
                                ? Colors.green
                                : InvoiceThemeColors.primaryPurple)
                            .withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isCompleted ? Icons.check : Icons.sync,
                    color: Colors.white,
                    size: 50.sp,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildInvoiceDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            'Service Fee Payment',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${_currencySymbol}99.99',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.invoice.title,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingSteps() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Progress',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          ..._steps.map((step) => _buildStepItem(step)),
        ],
      ),
    );
  }

  Widget _buildStepItem(_ProcessingStep step) {
    final isActive = _currentStatus.index >= step.status.index;
    final isCurrent = _currentStatus == step.status;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: isActive
                  ? (isCurrent
                          ? InvoiceThemeColors.primaryPurple
                          : Colors.green)
                      .withValues(alpha: 0.2)
                  : Colors.grey.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? (isCurrent
                        ? InvoiceThemeColors.primaryPurple
                        : Colors.green)
                    : Colors.grey.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              isActive && !isCurrent ? Icons.check : step.icon,
              color: isActive
                  ? (isCurrent
                      ? InvoiceThemeColors.primaryPurple
                      : Colors.green)
                  : Colors.grey[600],
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: GoogleFonts.inter(
                    color: isActive ? Colors.white : Colors.grey[600],
                    fontSize: 14.sp,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                Text(
                  step.description,
                  style: GoogleFonts.inter(
                    color: isActive ? Colors.grey[400] : Colors.grey[700],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isCurrent && !_isCompleted)
            SizedBox(
              width: 16.w,
              height: 16.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                    InvoiceThemeColors.primaryPurple),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSecurityMessage() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.security, color: Colors.green[400], size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Your payment is secured with bank-level encryption',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessingStep {
  final InvoiceProcessingStatus status;
  final String title;
  final String description;
  final IconData icon;

  const _ProcessingStep({
    required this.status,
    required this.title,
    required this.description,
    required this.icon,
  });
}
