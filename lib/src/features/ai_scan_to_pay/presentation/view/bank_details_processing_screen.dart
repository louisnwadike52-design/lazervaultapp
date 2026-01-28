import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

/// Processing screen shown during bank details payment processing
///
/// Displays:
/// - Animated Lottie loader
/// - Status text updates
/// - Progress bar (0-100%)
/// - Cannot be dismissed during processing
class BankDetailsProcessingScreen extends StatefulWidget {
  final String initialStatus;
  final double initialProgress;

  const BankDetailsProcessingScreen({
    Key? key,
    this.initialStatus = 'Initiating payment...',
    this.initialProgress = 0.0,
  }) : super(key: key);

  @override
  State<BankDetailsProcessingScreen> createState() =>
      _BankDetailsProcessingScreenState();
}

class _BankDetailsProcessingScreenState
    extends State<BankDetailsProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Setup pulse animation for progress indicator
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back button during processing
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Animated Lottie
                _buildAnimatedLottie(),

                SizedBox(height: 48.h),

                // Status Text
                _buildStatusText(widget.initialStatus),

                SizedBox(height: 32.h),

                // Progress Bar
                _buildProgressBar(widget.initialProgress),

                SizedBox(height: 16.h),

                // Progress Percentage
                _buildProgressPercentage(widget.initialProgress),

                const Spacer(),

                // Security Info
                _buildSecurityInfo(),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLottie() {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        width: 200.w,
        height: 200.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
              blurRadius: 30.r,
              offset: Offset(0, 10.h),
            ),
          ],
        ),
        child: Center(
          child: Lottie.asset(
            'assets/animations/payment_processing.json',
            width: 160.w,
            height: 160.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusText(String status) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        status,
        key: ValueKey<String>(status),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF111827),
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      width: double.infinity,
      height: 8.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),

          // Progress fill
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: MediaQuery.of(context).size.width * progress,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4E03D0),
                  Color(0xFF7C3AED),
                ],
              ),
              borderRadius: BorderRadius.circular(4.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
          ),

          // Shimmer effect
          if (progress > 0 && progress < 1.0)
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: MediaQuery.of(context).size.width * progress,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressPercentage(double progress) {
    final percentage = (progress * 100).toInt();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        '$percentage%',
        key: ValueKey<int>(percentage),
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 18.r,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              'Your transaction is encrypted and secure',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget that listens to payment processing state and updates UI accordingly
class BankDetailsProcessingListener extends StatelessWidget {
  final String status;
  final double progress;

  const BankDetailsProcessingListener({
    Key? key,
    required this.status,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BankDetailsProcessingScreen(
      initialStatus: status,
      initialProgress: progress,
    );
  }
}

/// Status messages for different processing stages
class BankDetailsProcessingStatus {
  static const String verifyingPin = 'Verifying your PIN...';
  static const String validatingAccount = 'Validating account details...';
  static const String processingPayment = 'Processing payment...';
  static const String updatingBalance = 'Updating your balance...';
  static const String generatingReceipt = 'Generating receipt...';
  static const String initiatingTransfer = 'Initiating bank transfer...';
  static const String awaitingConfirmation = 'Awaiting bank confirmation...';

  /// Get status message based on progress
  static String getStatusForProgress(double progress, bool isExternal) {
    if (progress < 0.2) {
      return verifyingPin;
    } else if (progress < 0.4) {
      return validatingAccount;
    } else if (progress < 0.6) {
      return isExternal ? initiatingTransfer : processingPayment;
    } else if (progress < 0.8) {
      return isExternal ? awaitingConfirmation : updatingBalance;
    } else {
      return generatingReceipt;
    }
  }
}

/// Progress values for different stages
class BankDetailsProcessingProgress {
  static const double verifyingPin = 0.2;
  static const double validatingAccount = 0.4;
  static const double processingPayment = 0.6;
  static const double updatingBalance = 0.8;
  static const double generatingReceipt = 1.0;
}
