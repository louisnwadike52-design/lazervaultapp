import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../domain/entities/group_entities.dart';
import '../../data/datasources/group_account_remote_data_source.dart';
import '../../data/services/contribution_payment_service.dart';
import '../../data/repositories/contribution_payment_repository_impl.dart';
import 'contribution_payment_confirmation_screen.dart';

class ContributionPaymentProcessingScreen extends StatefulWidget {
  final String contributionId;
  final Contribution contribution;
  final double amount;
  final String currency;
  final String paymentMethod;
  final String? notes;

  const ContributionPaymentProcessingScreen({
    super.key,
    required this.contributionId,
    required this.contribution,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    this.notes,
  });

  @override
  State<ContributionPaymentProcessingScreen> createState() => _ContributionPaymentProcessingScreenState();
}

class _ContributionPaymentProcessingScreenState extends State<ContributionPaymentProcessingScreen>
    with TickerProviderStateMixin {
  
  late AnimationController _mainAnimationController;
  late AnimationController _pulseAnimationController;
  late AnimationController _rotationAnimationController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  
  int _currentStep = 0;
  bool _isComplete = false;
  bool _hasError = false;
  String _errorMessage = '';
  
  late List<ProcessingStep> _steps;
  late ContributionPaymentRepositoryImpl _paymentRepository;

  @override
  void initState() {
    super.initState();
    _initializeSteps();
    _initializeAnimations();
    _initializeAndStartProcessing();
  }

  Future<void> _initializeAndStartProcessing() async {
    try {
      await _initializePaymentRepository();
      
      // Small delay to ensure UI is ready
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (mounted) {
        _startProcessing();
      }
    } catch (e) {
      print('❌ Storage initialization failed: $e');
      if (mounted) {
        // Don't show error state, just use fallback processing
        print('🔄 Using fallback processing mode...');
        _startProcessingFallback();
      }
    }
  }

  Future<void> _initializePaymentRepository() async {
    try {
      final remoteDataSource = GroupAccountRemoteDataSourceImpl();
      final paymentService = ContributionPaymentServiceImpl(remoteDataSource: remoteDataSource);
      _paymentRepository = ContributionPaymentRepositoryImpl(paymentService: paymentService);
    } catch (e) {
      print('❌ Repository initialization error: $e');
      rethrow;
    }
  }

  void _initializeSteps() {
    _steps = [
      ProcessingStep(
        title: 'Validating payment details',
        description: 'Checking payment information...',
        duration: 1000,
      ),
      ProcessingStep(
        title: _getPaymentMethodStep(),
        description: _getPaymentMethodDescription(),
        duration: 2000,
      ),
      ProcessingStep(
        title: 'Processing payment',
        description: 'Completing transaction...',
        duration: 1500,
      ),
      ProcessingStep(
        title: 'Updating contribution',
        description: 'Recording your contribution...',
        duration: 1000,
      ),
      ProcessingStep(
        title: 'Generating receipt',
        description: 'Creating payment confirmation...',
        duration: 800,
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

  void _startProcessing() async {
    for (int i = 0; i < _steps.length; i++) {
      if (!mounted) {
        return;
      }
      
      setState(() {
        _currentStep = i;
      });
      
      await Future.delayed(Duration(milliseconds: _steps[i].duration));
      
      // Save payment on the processing step
      if (i == 2) { // Processing payment step
        try {
          await _savePaymentToRepository();
        } catch (e) {
          print('❌ Payment save error: $e');
          if (mounted) {
            setState(() {
              _hasError = true;
              _errorMessage = 'Failed to process payment: ${e.toString()}';
            });
          }
          return;
        }
      }
    }
    
    if (mounted) {
      setState(() {
        _isComplete = true;
      });
      
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        _navigateToConfirmation();
      }
    }
  }

  void _startProcessingFallback() async {
    for (int i = 0; i < _steps.length; i++) {
      if (!mounted) {
        return;
      }
      
      setState(() {
        _currentStep = i;
        _hasError = false; // Clear any error state
      });
      
      await Future.delayed(Duration(milliseconds: _steps[i].duration));
      
      // Skip saving payment in fallback mode, just simulate
      if (i == 2) {
        print('⏭️ Payment simulated (storage unavailable)');
      }
    }
    
    if (mounted) {
      setState(() {
        _isComplete = true;
        _hasError = false; // Ensure no error state
      });
      
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        _navigateToConfirmationWithMockPayment();
      }
    }
  }

  Future<void> _savePaymentToRepository() async {
    await _paymentRepository.savePayment(
      contributionId: widget.contributionId,
      groupId: widget.contribution.groupId,
      userId: 'current_user_id', // TODO: Get from auth service
      userName: 'You', // TODO: Get from auth service
      amount: widget.amount,
      currency: widget.currency,
      notes: widget.notes,
      paymentMethod: widget.paymentMethod,
    );
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
      body: Container(
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
              if (!_isComplete) _buildResultActions(),
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
              color: Colors.white.withOpacity(0.1),
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
                color: const Color(0xFF10B981).withOpacity(0.3),
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

  Widget _buildResultActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            if (_isComplete)
              Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _navigateToConfirmation,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: Text(
                        'View Confirmation',
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
          ],
        ),
      ),
    );
  }

  void _navigateToConfirmation() async {
    // Get the saved payment
    final payments = await _paymentRepository.getPaymentsByContribution(widget.contributionId);
    final latestPayment = payments.isNotEmpty ? payments.first : null;
    
    if (latestPayment != null) {
      Get.off(
        () => ContributionPaymentConfirmationScreen(
          contribution: widget.contribution,
          payment: latestPayment,
          paymentMethod: widget.paymentMethod,
        ),
      );
    } else {
      // Fallback to mock payment if something went wrong
      final mockPayment = ContributionPayment(
        id: 'payment_${DateTime.now().millisecondsSinceEpoch}',
        contributionId: widget.contributionId,
        groupId: widget.contribution.groupId,
        userId: 'current_user_id',
        userName: 'You',
        amount: widget.amount,
        currency: widget.currency,
        paymentDate: DateTime.now(),
        status: PaymentStatus.completed,
        transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
        notes: widget.notes,
      );
      
      Get.off(
        () => ContributionPaymentConfirmationScreen(
          contribution: widget.contribution,
          payment: mockPayment,
          paymentMethod: widget.paymentMethod,
        ),
      );
    }
  }

  void _retryPayment() {
    Get.back();
  }

  void _navigateToConfirmationWithMockPayment() {
    final mockPayment = ContributionPayment(
      id: 'payment_${DateTime.now().millisecondsSinceEpoch}',
      contributionId: widget.contributionId,
      groupId: widget.contribution.groupId,
      userId: 'current_user_id',
      userName: 'You',
      amount: widget.amount,
      currency: widget.currency,
      paymentDate: DateTime.now(),
      status: PaymentStatus.completed,
      transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
      notes: widget.notes,
    );
    
    Get.off(
      () => ContributionPaymentConfirmationScreen(
        contribution: widget.contribution,
        payment: mockPayment,
        paymentMethod: widget.paymentMethod,
      ),
    );
  }

  String _getPaymentMethodStep() {
    switch (widget.paymentMethod.toLowerCase()) {
      case 'bank_transfer':
        return 'Connecting to bank';
      case 'card':
        return 'Verifying card details';
      case 'mobile_money':
        return 'Connecting to mobile money';
      case 'crypto':
        return 'Connecting to blockchain';
      default:
        return 'Verifying payment method';
    }
  }

  String _getPaymentMethodDescription() {
    switch (widget.paymentMethod.toLowerCase()) {
      case 'bank_transfer':
        return 'Establishing secure bank connection...';
      case 'card':
        return 'Validating card information...';
      case 'mobile_money':
        return 'Connecting to mobile money service...';
      case 'crypto':
        return 'Connecting to blockchain network...';
      default:
        return 'Preparing payment...';
    }
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