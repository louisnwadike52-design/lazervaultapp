import 'dart:async';
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
import '../../domain/entities/lock_fund_entity.dart';
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
    }
    // On first page, back button is hidden - use X button to close
  }

  Future<void> _proceedToCreateLock() async {
    final createCubit = context.read<CreateLockCubit>();
    final lockFundsCubit = context.read<LockFundsCubit>();
    final authCubit = context.read<AuthenticationCubit>();

    final authState = authCubit.state;
    if (authState is! AuthenticationSuccess) {
      _showErrorSnackBar('Please log in to create a lock fund');
      Navigator.of(context).pop();
      return;
    }

    final selectedAccountId = createCubit.selectedAccountId;
    if (selectedAccountId == null || selectedAccountId.isEmpty) {
      _showErrorSnackBar('Please select an account to fund your lock');
      return;
    }
    if (selectedAccountId == '0') {
      _showErrorSnackBar('Invalid account selected. Please select a different account.');
      return;
    }

    HapticFeedback.mediumImpact();

    // Snapshot wizard state. The bottom sheet stays open across the
    // verify → process → success arc and we don't want a UI rebuild
    // mid-flight to mutate any of these values.
    final lockType = createCubit.lockType!;
    final amount = createCubit.amount!;
    final currency = createCubit.currency;
    final lockDurationDays = createCubit.lockDurationDays ?? 0;
    final autoRenew = createCubit.autoRenew;
    final goalName = createCubit.goalName;
    final goalDescription = createCubit.goalDescription;
    final paymentMethod = createCubit.paymentMethod!;
    final sourceAccountId = selectedAccountId;
    // Empty when admin's plan disables upfront interest — backend
    // ignores the field unless supports_upfront_interest=true.
    final interestDestinationAccountId =
        createCubit.interestDestinationAccountId;

    final transactionId =
        'LOCK-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    // Single PIN bottomsheet that walks Entry → Verifying →
    // Processing → Success, all inline. The createLockFund call is
    // wired into onPinValidated so the network round-trip happens
    // while the sheet shows the spinner. After success the sheet
    // closes itself (validateTransactionPin handles the dismiss),
    // and the BlocListener routes us to the receipt.
    await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'lock_fund',
      amount: amount,
      currency: currency,
      title: 'Confirm PiggyVault',
      message: 'Locking ${amount.toStringAsFixed(2)} $currency',
      onPinValidated: (verificationToken) async {
        if (!mounted) return;

        // Wire the pending-create call to a Completer so we can
        // await the cubit's result (success or error) inside the
        // PIN sheet — letting setSuccess()/setFailed() fire AFTER
        // the backend confirms, not after the call enqueues.
        final completer = Completer<LockFund>();
        late final StreamSubscription<LockFundsState> sub;
        sub = lockFundsCubit.stream.listen((state) {
          if (state is LockFundCreated && !completer.isCompleted) {
            completer.complete(state.lockFund);
            sub.cancel();
          } else if (state is LockFundsError && !completer.isCompleted) {
            completer.completeError(Exception(state.message));
            sub.cancel();
          }
        });

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
          transactionPin: verificationToken,
          interestDestinationAccountId: interestDestinationAccountId,
        );

        try {
          final lockFund = await completer.future
              .timeout(const Duration(seconds: 60));
          // Success: validateTransactionPin will fire setSuccess()
          // and dismiss the sheet. We schedule the receipt jump on
          // a microtask so navigation runs after the bottomsheet
          // pops cleanly.
          if (!mounted) return;
          Future.microtask(() {
            if (!mounted) return;
            Get.offAllNamed(
              AppRoutes.lockFundReceipt,
              arguments: {
                'lockFund': lockFund,
                'interestCalculation': createCubit.interestCalculation,
              },
            );
          });
        } catch (e) {
          await sub.cancel();
          rethrow;
        }
      },
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
    // Navigation + error surfacing are owned by the
    // validateTransactionPin flow inside _proceedToCreateLock — the
    // PIN bottom sheet drives Verify → Process → Success/Failed
    // states inline and triggers the receipt navigation directly.
    // No BlocListener needed here, removing it eliminates the
    // duplicate "Creating PiggyVault…" overlay that used to fire
    // alongside the bottom sheet.
    return Scaffold(
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
    );
  }

  /// Close the carousel and go back to lock funds landing page
  void _closeCarousel() {
    Navigator.of(context).pop();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0A0A0A),
      elevation: 0,
      leading: _currentPage > 0
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24.sp,
              ),
              onPressed: _goToPreviousPage,
            )
          : const SizedBox.shrink(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create PiggyVault',
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
            size: 24.sp,
          ),
          onPressed: _closeCarousel,
          tooltip: 'Close',
        ),
        SizedBox(width: 4.w),
      ],
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
                        : [const Color(0xFF6366F1), const Color.fromARGB(255, 78, 3, 208)],
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
                      colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
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
