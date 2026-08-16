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
import '../../data/lock_funds_error.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Main carousel controller for lock fund creation
///
/// Manages a consolidated 3-step flow with PageView, progress
/// indicators, and validation:
///   1. Plan & Amount   — lock type + amount/duration/auto-renew
///   2. Details & Payment — name/description + funding account
///   3. Review & Confirm — final summary, then Create Lock
///
/// The five underlying step widgets are grouped two-per-page (Review
/// alone) inside a single scroll view; no captured field is dropped.
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
  final int _totalPages = 3;

  final List<String> _pageNames = [
    'Plan & Amount',
    'Details & Payment',
    'Review & Confirm',
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

    // Validate current page. Each page now bundles two of the
    // original five sub-steps (Review stands alone), so the page
    // validators are composed of the underlying step validators.
    // `&&` short-circuits, so the cubit's emitted validation error
    // always reflects the first failing sub-step on the page.
    bool isValid = false;
    switch (_currentPage) {
      case 0: // Plan & Amount = lock type + amount/duration
        isValid = cubit.validateStep1() && cubit.validateStep2();
        break;
      case 1: // Details & Payment = name/description + funding account
        isValid = cubit.validateStep3() && cubit.validateStep5();
        break;
      case 2: // Review — re-check the captured fields before create
        isValid = cubit.validateStep4();
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

    // Pre-flight balance guard. Read the funding account's available
    // balance from the already-loaded AccountCardsSummaryCubit and, if
    // the lock amount exceeds it, block with a clear modal here rather
    // than letting the backend reject the debit with a generic error.
    // Only guards when the account row is loaded and matches the
    // selection — otherwise we defer to the backend's own check (no
    // change to money math or the create call).
    final lockAmount = createCubit.amount ?? 0;
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      AccountSummaryEntity? source;
      for (final a in accountState.accountSummaries) {
        if (a.id == selectedAccountId) {
          source = a;
          break;
        }
      }
      if (source != null && source.availableBalance < lockAmount) {
        await _showInsufficientBalanceDialog(
          currency: source.currency,
          available: source.availableBalance,
          requiredAmount: lockAmount,
        );
        return;
      }
    }

    HapticFeedback.mediumImpact();

    // Snapshot wizard state. The bottom sheet stays open across the
    // verify → process → success arc and we don't want a UI rebuild
    // mid-flight to mutate any of these values.
    final lockType = createCubit.lockType!;
    // Stable plan identity — the backend resolves the plan by this
    // PiggyVaultConfig UUID, not by lock_type name. Empty only if
    // the config list hasn't loaded (the wizard blocks submit before
    // then), in which case the backend falls back to lock_type.
    final configId =
        createCubit.selectedConfigId ?? createCubit.getConfigForType(lockType)?.id ?? '';
    final amount = createCubit.amount!;
    final currency = createCubit.currency;
    final lockDurationDays = createCubit.lockDurationDays ?? 0;
    // Final guard: never submit auto-renew for a plan that doesn't support it
    // (e.g. the Year lock) — the backend rejects it with INVALID_ARGUMENT.
    final autoRenew =
        createCubit.autoRenew && createCubit.getSupportsAutoRenew(lockType);
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
      title: 'Confirm Piggyvault',
      message: 'Locking ${amount.toStringAsFixed(2)} $currency',
      // Surface the lock-funds-specific friendly copy on the PIN
      // sheet's FAILED beat (e.g. "minimum amount is 5000",
      // "Year Lock does not support auto-renewal") instead of the
      // generic transfer failure line, so a create rejection is
      // diagnosable.
      failureMessageBuilder: friendlyLockError,
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
          configId: configId,
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

  /// Dark-theme modal shown when the funding account can't cover the
  /// lock amount. Names the shortfall explicitly so the user knows
  /// how much to add (or by how much to lower the amount).
  Future<void> _showInsufficientBalanceDialog({
    required String currency,
    required double available,
    required double requiredAmount,
  }) async {
    final shortfall = requiredAmount - available;
    await showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: const Color(0xFFEF4444).withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        title: Text(
          'Insufficient balance',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Your funding account has '
          '${CurrencySymbols.formatAmountWithCurrency(available, currency)} '
          'available, but this lock needs '
          '${CurrencySymbols.formatAmountWithCurrency(requiredAmount, currency)}. '
          'Add ${CurrencySymbols.formatAmountWithCurrency(shortfall, currency)} '
          'to that account, or lower the lock amount.',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(
              'OK',
              style: GoogleFonts.inter(
                color: const Color(0xFF8B5CF6),
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
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
                // Step 1 — Plan & Amount
                _WizardPage(children: [
                  LockTypeSelector(),
                  AmountDurationSelector(),
                ]),
                // Step 2 — Details & Payment
                _WizardPage(children: [
                  GoalDetailsScreen(),
                  PaymentMethodSelector(),
                ]),
                // Step 3 — Review & Confirm
                _WizardPage(children: [
                  ReviewScreen(),
                ]),
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
            'Create Piggyvault',
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

/// A single wizard page: hosts one or more of the step widgets inside
/// a shared scroll view. The step widgets themselves are non-scrolling
/// (they return a padded Column), so grouping two per page here is what
/// collapses the original five slides into three without dropping any
/// captured field or nesting scroll views.
class _WizardPage extends StatelessWidget {
  final List<Widget> children;

  const _WizardPage({required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
