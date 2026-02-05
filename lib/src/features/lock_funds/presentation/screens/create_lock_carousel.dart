import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/create_lock_cubit.dart';
import '../cubit/lock_funds_cubit.dart';
import '../cubit/lock_funds_state.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../widgets/create_lock_steps/lock_type_selector.dart';
import '../widgets/create_lock_steps/amount_duration_selector.dart';
import '../widgets/create_lock_steps/goal_details_screen.dart';
import '../widgets/create_lock_steps/review_screen.dart';
import '../widgets/create_lock_steps/payment_method_selector.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Main carousel controller for lock fund creation
///
/// Manages 5-screen flow with PageView, progress indicators, and validation
class CreateLockCarousel extends StatefulWidget {
  const CreateLockCarousel({super.key});

  @override
  State<CreateLockCarousel> createState() => _CreateLockCarouselState();
}

class _CreateLockCarouselState extends State<CreateLockCarousel>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 5;
  bool _isProcessing = false;

  final List<String> _pageNames = [
    'Lock Type',
    'Amount & Duration',
    'Goal Details',
    'Review & Calculate',
    'Payment Method',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToNextPage() async {
    final cubit = context.read<CreateLockCubit>();

    // Validate current page
    bool isValid = false;
    switch (_currentPage) {
      case 0:
        isValid = cubit.validateStep1();
        break;
      case 1:
        isValid = cubit.validateStep2();
        break;
      case 2:
        isValid = cubit.validateStep3();
        break;
      case 3:
        isValid = cubit.validateStep4();
        break;
      case 4:
        isValid = cubit.validateStep5();
        break;
    }

    if (!isValid) {
      // Show error message if validation failed
      final state = cubit.state;
      if (state is CreateLockValidationError) {
        _showErrorSnackBar(state.message);
      }
      return;
    }

    if (_currentPage < _totalPages - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page - proceed to create lock
      _proceedToCreateLock();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // First page - go back to list screen
      Navigator.of(context).pop();
    }
  }

  Future<void> _proceedToCreateLock() async {
    final createCubit = context.read<CreateLockCubit>();
    final lockFundsCubit = context.read<LockFundsCubit>();
    final authCubit = context.read<AuthenticationCubit>();

    // Debug logging
    developer.log(
      'CreateLock: selectedAccountId = "${createCubit.selectedAccountId}"',
      name: 'LockFunds',
    );

    // Verify authentication before creating lock
    final authState = authCubit.state;
    if (authState is! AuthenticationSuccess) {
      _showErrorSnackBar('Please log in to create a lock fund');
      Navigator.of(context).pop(); // Close carousel
      return;
    }

    // Verify account is selected with better validation
    final selectedAccountId = createCubit.selectedAccountId;
    if (selectedAccountId == null || selectedAccountId.isEmpty) {
      developer.log(
        'CreateLock: ERROR - selectedAccountId is null or empty',
        name: 'LockFunds',
      );
      _showErrorSnackBar('Please select an account to fund your lock');
      return;
    }

    // Additional validation - ensure it's a valid UUID format or numeric ID
    if (selectedAccountId == '0') {
      developer.log(
        'CreateLock: ERROR - selectedAccountId is "0" (invalid)',
        name: 'LockFunds',
      );
      _showErrorSnackBar('Invalid account selected. Please select a different account.');
      return;
    }

    HapticFeedback.mediumImpact();

    // Store values BEFORE showing PIN dialog (in case of state changes during async operation)
    final lockType = createCubit.lockType!;
    final amount = createCubit.amount!;
    final currency = createCubit.currency;
    final lockDurationDays = createCubit.lockDurationDays!;
    final autoRenew = createCubit.autoRenew;
    final goalName = createCubit.goalName;
    final goalDescription = createCubit.goalDescription;
    final paymentMethod = createCubit.paymentMethod!;
    // Use the already validated selectedAccountId
    final sourceAccountId = selectedAccountId;

    developer.log(
      'CreateLock: Stored sourceAccountId = "$sourceAccountId" before PIN validation',
      name: 'LockFunds',
    );

    // Generate a unique transaction ID for PIN validation
    final transactionId =
        'LOCK-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    // Validate transaction PIN
    final pinResult = await validatePinOnly(
      context: context,
      transactionId: transactionId,
      transactionType: 'lock_fund',
      amount: amount,
      currency: currency,
    );

    if (pinResult == null || !pinResult.success) {
      return; // User cancelled or PIN validation failed
    }

    if (!mounted) return;

    // Verify the account ID is still valid after PIN validation
    developer.log(
      'CreateLock: After PIN validation, using sourceAccountId = "$sourceAccountId"',
      name: 'LockFunds',
    );

    setState(() {
      _isProcessing = true;
    });

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(24.w),
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F35),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: const Color(0xFF6366F1),
              ),
              SizedBox(height: 16.h),
              Text(
                'Creating Lock Fund...',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Create lock fund with source account and transaction PIN
    // Use the stored values to ensure consistency
    lockFundsCubit.createLockFund(
      lockType: lockType,
      amount: amount,
      currency: currency,
      lockDurationDays: lockDurationDays,
      autoRenew: autoRenew,
      goalName: goalName,
      goalDescription: goalDescription,
      paymentMethod: paymentMethod,
      sourceAccountId: sourceAccountId,
      transactionPin: pinResult.verificationToken ?? '',
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LockFundsCubit, LockFundsState>(
      listener: (context, state) {
        if (state is LockFundCreated) {
          setState(() {
            _isProcessing = false;
          });

          // Close loading dialog if open
          if (ModalRoute.of(context)?.isCurrent == false) {
            Navigator.of(context).pop();
          }

          // Get the create cubit to pass interest calculation to receipt
          final createCubit = context.read<CreateLockCubit>();

          // Navigate to receipt screen
          Get.offAllNamed(
            AppRoutes.lockFundReceipt,
            arguments: {
              'lockFund': state.lockFund,
              'interestCalculation': createCubit.interestCalculation,
            },
          );
        } else if (state is LockFundsError) {
          setState(() {
            _isProcessing = false;
          });

          // Check if loading dialog is open before popping
          if (ModalRoute.of(context)?.isCurrent == false) {
            Navigator.of(context).pop();
          }

          // Show error snackbar
          Get.snackbar(
            'Lock Fund Failed',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 4),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildProgressIndicators(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() => _currentPage = page);
                },
                children: const [
                  LockTypeSelector(),
                  AmountDurationSelector(),
                  GoalDetailsScreen(),
                  ReviewScreen(),
                  PaymentMethodSelector(),
                ],
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0A0A0A),
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 24.sp,
        ),
        onPressed: _goToPreviousPage,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Lock Fund',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            'Step ${_currentPage + 1} of $_totalPages - ${_pageNames[_currentPage]}',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicators() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          // Linear progress bar
          Stack(
            children: [
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4.h,
                width: (MediaQuery.of(context).size.width - 40.w) *
                    ((_currentPage + 1) / _totalPages),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _currentPage == _totalPages - 1
                        ? [Colors.green, Colors.green.shade700]
                        : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _currentPage == index ? 24.w : 8.w,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFF6366F1)
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final isLastPage = _currentPage == _totalPages - 1;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentPage > 0)
              Expanded(
                child: GestureDetector(
                  onTap: _goToPreviousPage,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'Back',
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
            if (_currentPage > 0) SizedBox(width: 12.w),
            Expanded(
              flex: _currentPage == 0 ? 1 : 1,
              child: GestureDetector(
                onTap: _goToNextPage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLastPage ? 'Create Lock' : 'Continue',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        if (!isLastPage) ...[
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ],
                      ],
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
}
