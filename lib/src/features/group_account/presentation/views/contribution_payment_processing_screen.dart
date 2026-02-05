import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import 'contribution_payment_confirmation_screen.dart';

/// Payment processing screen that shows progress while the backend processes the payment.
/// This screen listens to the GroupAccountCubit for payment state changes.
class ContributionPaymentProcessingScreen extends StatefulWidget {
  final String contributionId;
  final Contribution contribution;
  final double amount;
  final String currency;
  final String paymentMethod;
  final String? notes;
  final ContributionPayment? payment; // Pre-existing payment from cubit

  const ContributionPaymentProcessingScreen({
    super.key,
    required this.contributionId,
    required this.contribution,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    this.notes,
    this.payment,
  });

  @override
  State<ContributionPaymentProcessingScreen> createState() => _ContributionPaymentProcessingScreenState();
}

class _ContributionPaymentProcessingScreenState extends State<ContributionPaymentProcessingScreen>
    with TickerProviderStateMixin {

  late AnimationController _pulseAnimationController;
  late AnimationController _rotationAnimationController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  int _currentStep = 0;
  bool _isComplete = false;
  bool _hasError = false;
  String _errorMessage = '';

  late List<ProcessingStep> _steps;

  @override
  void initState() {
    super.initState();
    _initializeSteps();
    _initializeAnimations();

    // If payment was already completed (passed via widget), show success immediately
    if (widget.payment != null) {
      _isComplete = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _navigateToConfirmation(widget.payment!);
        }
      });
    }
  }

  void _initializeSteps() {
    _steps = [
      ProcessingStep(
        title: 'Validating payment details',
        description: 'Checking payment information...',
        duration: 800,
      ),
      ProcessingStep(
        title: 'Verifying account balance',
        description: 'Checking available funds...',
        duration: 600,
      ),
      ProcessingStep(
        title: 'Processing payment',
        description: 'Completing transaction...',
        duration: 1000,
      ),
      ProcessingStep(
        title: 'Updating contribution',
        description: 'Recording your contribution...',
        duration: 600,
      ),
      ProcessingStep(
        title: 'Generating receipt',
        description: 'Creating payment confirmation...',
        duration: 500,
      ),
    ];
  }

  void _initializeAnimations() {
    _pulseAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseAnimationController, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationAnimationController, curve: Curves.linear),
    );

    _pulseAnimationController.repeat(reverse: true);
    _rotationAnimationController.repeat();
  }

  void _advanceStep() {
    if (!mounted || _isComplete || _hasError) return;

    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _setComplete(ContributionPayment payment) {
    if (!mounted) return;
    setState(() {
      _isComplete = true;
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _navigateToConfirmation(payment);
      }
    });
  }

  void _setError(String message) {
    if (!mounted) return;
    setState(() {
      _hasError = true;
      _errorMessage = message;
    });
  }

  @override
  void dispose() {
    _pulseAnimationController.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is ContributionPaymentProcessing) {
            // Advance step animation
            _advanceStep();
          } else if (state is ContributionPaymentSuccess) {
            _setComplete(state.payment);
          } else if (state is ContributionPaymentFailed) {
            _setError(state.error);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1F1F1F),
                const Color(0xFF0A0A0A),
                const Color(0xFF0F0F23),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildProcessingAnimation(),
                        SizedBox(height: 48.h),
                        _buildProcessingStatus(),
                        SizedBox(height: 32.h),
                        _buildProgressSteps(),
                      ],
                    ),
                  ),
                ),
                if (!_isComplete && _hasError) _buildResultActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isComplete 
                      ? 'Payment Successful!'
                      : 'Processing Payment...',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${widget.currency} ${widget.amount.toStringAsFixed(2)} to ${widget.contribution.title}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingAnimation() {
    if (_isComplete) {
      return ScaleTransition(
        scale: _pulseAnimation,
        child: Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [const Color(0xFF10B981), const Color(0xFF059669)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 60.sp,
          ),
        ),
      );
    }

    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulsing ring
          AnimatedBuilder(
            animation: _pulseAnimation,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
            ),
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: child,
              );
            },
          ),
          // Inner rotating circle
          AnimatedBuilder(
            animation: _rotationAnimation,
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFF8B5CF6)],
                ),
              ),
              child: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 40.sp,
              ),
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingStatus() {
    if (_isComplete) {
      return Column(
        children: [
          Text(
            'Payment Completed Successfully!',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF10B981),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Your contribution has been processed and receipt is ready.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else if (_hasError) {
      return Column(
        children: [
          Text(
            'Payment Failed',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFEF4444),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            _errorMessage,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return Text(
        _steps[_currentStep].title,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _buildProgressSteps() {
    if (_isComplete) return const SizedBox.shrink();

    return Column(
      children: _steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isCompleted = index < _currentStep;
        final isCurrent = index == _currentStep;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted 
                      ? const Color(0xFF10B981)
                      : isCurrent
                          ? const Color(0xFF6C5CE7)
                          : Colors.grey[600],
                ),
                child: Icon(
                  isCompleted ? Icons.check : Icons.circle,
                  color: Colors.white,
                  size: 12.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  step.title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: isCurrent ? Colors.white : Colors.grey[500],
                    fontWeight: isCurrent ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Build error action buttons (only shown when there's an error)
  Widget _buildResultActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _retryPayment,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: Text(
                        'Retry',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToConfirmation(ContributionPayment payment) {
    Get.off(
      () => ContributionPaymentConfirmationScreen(
        contribution: widget.contribution,
        payment: payment,
        paymentMethod: widget.paymentMethod,
      ),
    );
  }

  void _retryPayment() {
    Get.back();
  }
}

class ProcessingStep {
  final String title;
  final String description;
  final int duration;

  ProcessingStep({
    required this.title,
    required this.description,
    required this.duration,
  });
} 