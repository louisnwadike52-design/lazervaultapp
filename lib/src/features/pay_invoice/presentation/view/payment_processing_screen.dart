import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/entities/tagged_invoice_entity.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/repositories/pay_invoice_repository.dart';
import 'transaction_receipt_screen.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final TaggedInvoice invoice;
  final PaymentMethod paymentMethod;
  final String? selectedAccount;
  final String? selectedCrypto;

  const PaymentProcessingScreen({
    super.key,
    required this.invoice,
    required this.paymentMethod,
    this.selectedAccount,
    this.selectedCrypto,
  });

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen>
    with TickerProviderStateMixin {
  
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  
  List<String> _processingSteps = [];
  int _currentStep = 0;
  bool _isProcessing = true;
  bool _isSuccess = false;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeProcessingSteps();
    _startPaymentProcessing();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
  }

  void _initializeProcessingSteps() {
    _processingSteps = [
      'Verifying payment method...',
      'Checking account balance...',
      'Processing transaction...',
      'Updating invoice status...',
      'Sending confirmation...',
    ];

    // Customize steps based on payment method
    switch (widget.paymentMethod) {
      case PaymentMethod.bitcoin:
      case PaymentMethod.ethereum:
      case PaymentMethod.usdc:
        _processingSteps = [
          'Connecting to blockchain...',
          'Verifying wallet balance...',
          'Creating transaction...',
          'Broadcasting to network...',
          'Waiting for confirmation...',
        ];
        break;
      case PaymentMethod.applePay:
        _processingSteps = [
          'Authenticating with Touch ID...',
          'Verifying Apple Pay...',
          'Processing payment...',
          'Updating records...',
          'Sending confirmation...',
        ];
        break;
      case PaymentMethod.googlePay:
        _processingSteps = [
          'Authenticating with Google...',
          'Verifying Google Pay...',
          'Processing payment...',
          'Updating records...',
          'Sending confirmation...',
        ];
        break;
      case PaymentMethod.paypal:
        _processingSteps = [
          'Connecting to PayPal...',
          'Verifying account...',
          'Processing payment...',
          'Updating records...',
          'Sending confirmation...',
        ];
        break;
      default:
        break;
    }
  }

  Future<void> _startPaymentProcessing() async {
    for (int i = 0; i < _processingSteps.length; i++) {
      if (!mounted) return;
      
      setState(() {
        _currentStep = i;
      });
      
      // Simulate processing time
      await Future.delayed(Duration(milliseconds: 800 + (i * 200)));
    }

    // Simulate payment result
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (!mounted) return;

    // Simulate different success rates based on payment method
    final isSuccess = _simulatePaymentResult();
    
    setState(() {
      _isProcessing = false;
      _isSuccess = isSuccess;
      if (!isSuccess) {
        _errorMessage = _getErrorMessage();
      }
    });

    _pulseController.stop();
    _rotationController.stop();
    _scaleController.forward();

    // Navigate after showing result
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;

    if (isSuccess) {
      _navigateToReceipt();
    } else {
      _showRetryOptions();
    }
  }

  bool _simulatePaymentResult() {
    // Simulate different success rates
    switch (widget.paymentMethod) {
      case PaymentMethod.accountBalance:
        return true; // 95% success rate
      case PaymentMethod.bitcoin:
      case PaymentMethod.ethereum:
      case PaymentMethod.usdc:
        return DateTime.now().millisecond % 10 < 8; // 80% success rate
      case PaymentMethod.applePay:
      case PaymentMethod.googlePay:
        return DateTime.now().millisecond % 10 < 9; // 90% success rate
      default:
        return DateTime.now().millisecond % 10 < 8; // 80% success rate
    }
  }

  String _getErrorMessage() {
    switch (widget.paymentMethod) {
      case PaymentMethod.bitcoin:
      case PaymentMethod.ethereum:
      case PaymentMethod.usdc:
        return 'Network congestion detected. Please try again.';
      case PaymentMethod.applePay:
        return 'Touch ID verification failed. Please try again.';
      case PaymentMethod.googlePay:
        return 'Google Pay authentication failed.';
      case PaymentMethod.paypal:
        return 'PayPal service temporarily unavailable.';
      default:
        return 'Payment failed. Please check your account and try again.';
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (!_isProcessing) _buildResultActions(),
            ],
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
              Icons.payment,
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
                  _isProcessing 
                      ? 'Processing Payment...'
                      : _isSuccess 
                          ? 'Payment Successful!'
                          : 'Payment Failed',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '£${widget.invoice.totalAmount.toStringAsFixed(2)} to ${widget.invoice.fromUserName}',
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
    if (!_isProcessing) {
      return ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: _isSuccess 
                  ? [InvoiceThemeColors.successGreen, const Color(0xFF059669)]
                  : [InvoiceThemeColors.errorRed, const Color(0xFFDC2626)],
            ),
            boxShadow: [
              BoxShadow(
                color: (_isSuccess ? InvoiceThemeColors.successGreen : InvoiceThemeColors.errorRed)
                    .withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            _isSuccess ? Icons.check : Icons.close,
            color: Colors.white,
            size: 60.sp,
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer pulsing circle
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Container(
              width: 120.w * _pulseAnimation.value,
              height: 120.w * _pulseAnimation.value,
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
            );
          },
        ),
        // Inner rotating circle
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
                  ),
                ),
                child: Icon(
                  Icons.payment,
                  color: Colors.white,
                  size: 40.sp,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProcessingStatus() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
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
          if (_isProcessing)
            Text(
              _currentStep < _processingSteps.length 
                  ? _processingSteps[_currentStep]
                  : 'Finalizing...',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
          else if (_isSuccess)
            Column(
              children: [
                Text(
                  'Payment Completed Successfully!',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: InvoiceThemeColors.successGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your invoice has been paid and receipt is ready.',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          else
            Column(
              children: [
                Text(
                  'Payment Failed',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: InvoiceThemeColors.errorRed,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  _errorMessage ?? 'Unknown error occurred',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildProgressSteps() {
    if (!_isProcessing) return const SizedBox.shrink();

    return Column(
      children: _processingSteps.asMap().entries.map((entry) {
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
                      ? InvoiceThemeColors.successGreen
                      : isCurrent
                          ? InvoiceThemeColors.infoBlue
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
                  step,
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

  Widget _buildResultActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            if (_isSuccess)
              Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _navigateToReceipt,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: Text(
                        'View Receipt',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56.h,
                      decoration: BoxDecoration(                        borderRadius: BorderRadius.circular(16.r),
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
                          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
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
          ],
        ),
      ),
    );
  }

  void _navigateToReceipt() {
    HapticFeedback.lightImpact();
    Get.off(
      () => TransactionReceiptScreen(
        invoice: widget.invoice,
        paymentMethod: widget.paymentMethod,
        selectedAccount: widget.selectedAccount,
        selectedCrypto: widget.selectedCrypto,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _retryPayment() {
    HapticFeedback.lightImpact();
    Get.back();
  }

  void _showRetryOptions() {
    // Additional retry logic could be implemented here
  }
} 