import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'portfolio_rebalance_carousel.dart';
import 'portfolio_rebalance_confirmation_screen.dart';

/// Processing screen for portfolio rebalancing with animations
class PortfolioRebalanceProcessingScreen extends StatefulWidget {
  final List<RebalanceTrade> trades;
  final String strategy;

  const PortfolioRebalanceProcessingScreen({
    super.key,
    required this.trades,
    required this.strategy,
  });

  @override
  State<PortfolioRebalanceProcessingScreen> createState() =>
      _PortfolioRebalanceProcessingScreenState();
}

class _PortfolioRebalanceProcessingScreenState
    extends State<PortfolioRebalanceProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  double _progress = 0.0;
  int _currentStepIndex = 0;

  final List<String> _processingSteps = [
    'Analyzing portfolio...',
    'Calculating optimal trades...',
    'Placing sell orders...',
    'Executing buy orders...',
    'Updating portfolio...',
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _processRebalance();
  }

  void _setupAnimations() {
    // Pulse animation
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Future<void> _processRebalance() async {
    try {
      // Simulate step-by-step progress
      for (int i = 0; i < _processingSteps.length; i++) {
        if (!mounted) return;

        setState(() {
          _currentStepIndex = i;
          _progress = (i + 1) / _processingSteps.length;
        });

        // Wait before next step
        if (i < _processingSteps.length - 1) {
          await Future.delayed(const Duration(milliseconds: 800));
        }
      }

      // Wait a bit before navigating to confirmation
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      // Navigate to confirmation
      Get.off(() => PortfolioRebalanceConfirmationScreen(
        trades: widget.trades,
        strategy: widget.strategy,
      ));
    } catch (e) {
      // Error handling
      if (!mounted) return;
      _showErrorDialog('Failed to rebalance portfolio. Please try again.');
    }
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28.sp),
            SizedBox(width: 12.w),
            Text(
              'Rebalance Failed',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          error,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.back(); // Go back to carousel
            },
            child: Text(
              'Try Again',
              style: GoogleFonts.inter(
                color: const Color(0xFF6366F1),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated icon
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
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF6366F1).withValues(alpha: 0.3),
                                  const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                                ],
                              ),
                            ),
                            child: Icon(
                              Icons.auto_fix_high,
                              size: 60.sp,
                              color: const Color(0xFF6366F1),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 48.h),

              // Processing title
              Text(
                'Rebalancing Portfolio',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12.h),

              Text(
                'Executing ${widget.trades.length} trades using ${widget.strategy} strategy',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48.h),

              // Progress bar
              Container(
                width: double.infinity,
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progress,
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

              SizedBox(height: 32.h),

              // Processing steps
              _buildProcessingSteps(),

              const Spacer(),

              // Security note
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: const Color(0xFF6366F1),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Your transactions are secure and encrypted',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingSteps() {
    return Column(
      children: _processingSteps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final stepProgress = (index + 1) / _processingSteps.length;
        final isCompleted = _progress >= stepProgress;
        final isActive = index == _currentStepIndex;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              // Step indicator
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
                  color: isCompleted || isActive
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(width: 16.w),
              // Step text
              Expanded(
                child: Text(
                  step,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isCompleted || isActive
                        ? Colors.white
                        : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              // Loading indicator for active step
              if (isActive && !isCompleted)
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF6366F1),
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
