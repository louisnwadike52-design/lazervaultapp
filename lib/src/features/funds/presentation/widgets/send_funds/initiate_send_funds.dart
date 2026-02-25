import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
// For serviceLocator
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_config.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_modal.dart';
import 'package:lazervault/src/features/widgets/category_selection.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:uuid/uuid.dart';

class InitiateSendFunds extends StatefulWidget {
  final RecipientModel? recipient;

  const InitiateSendFunds({super.key, this.recipient});

  @override
  State<InitiateSendFunds> createState() => _InitiateSendFundsState();
}

class _InitiateSendFundsState extends State<InitiateSendFunds>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  // Recipient handling variables
  RecipientModel? _recipient;


  String amount =
      ''; // Stores amount as string of MINOR units (e.g., "2000" for £20.00)
  // final double maxAmount = 15358.00; // TODO: Get max from selected card/account later
  int selectedCardIndex = 0;
  ServiceCategory? selectedCategory;
  List<ServiceCategory> _availableCategories = ServiceCategory.commonTransferCategories;
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isConfirmingTransfer = false; // State for dialog loading
  bool _autoShowConfirm = false;
  bool _autoConfirmTriggered = false;

  final List<int> quickAmounts = [50, 100, 200, 500]; // Major units for display

  // Categories loaded from backend via BudgetCubit.loadServiceCategories

  DateTime? scheduledDate;
  // TimeOfDay? scheduledTime; // Removed as DateTime handles both

  bool _isRecurringEnabled = false;
  RecurringTransferConfig? _recurringConfig;

  // Tracks whether we're waiting for both transfer + recurring setup to complete
  // before navigating to receipt. Prevents recurring error being lost during navigation.
  bool _recurringSetupPending = false;
  bool _transferSucceeded = false;
  TransferSuccess? _pendingTransferSuccess;

  // Stored for deferred recurring setup after transfer succeeds
  String? _pendingRecurringTransactionId;
  String? _pendingRecurringVerificationToken;

  // Guards against duplicate recurring setup and tracks created transfer for rollback
  bool _recurringSetupInitiated = false;
  String? _createdRecurringTransferId;
  int _recurringRetryCount = 0;
  static const _maxRecurringRetries = 2;

  // --- Fetch Accounts on Init ---
  @override
  void initState() {
    super.initState();

    // First check if recipient was passed directly via widget parameter
    if (widget.recipient != null) {
      _recipient = widget.recipient;
    } else {
      // Get arguments and determine recipient details
      final args = Get.arguments;

      if (args is Map<String, dynamic>) {
        _recipient = args['recipient'] as RecipientModel;

        // Prefill from recipient transaction history
        final prefillAmount = args['prefillAmount'] as int?;
        if (prefillAmount != null && prefillAmount > 0) {
          amount = prefillAmount.toString();
          _amountController.text = _formatAmount();
        }
        _autoShowConfirm = args['autoShowConfirm'] == true;
      } else if (args is RecipientModel) {
        _recipient = args;
      }
    }

    // Check the current state of the accounts cubit
    final accountCubit = context.read<AccountCardsSummaryCubit>();
    final currentState = accountCubit.state;

    // Only fetch if the data hasn't been loaded or isn't currently loading
    if (currentState is AccountCardsSummaryInitial ||
        currentState is AccountCardsSummaryError) {
      print(
          "InitiateSendFunds: Account state is $currentState, fetching accounts...");
      // Fetch account summaries only if not already loaded/loading
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        final userId = authState.profile.user.id;
        final accessToken = authState.profile.session.accessToken;
        accountCubit.fetchAccountSummaries(
          userId: userId,
          accessToken: accessToken,
        );
      } else {
        // Handle case where user is not authenticated
        print(
            "InitiateSendFunds: User not authenticated, cannot fetch accounts.");
        // Optionally show a snackbar or navigate away
        // You might want to emit an error state in AccountCardsSummaryCubit or handle this differently
      }
    } else {
      print(
          "InitiateSendFunds: Accounts already loaded or loading ($currentState), skipping fetch.");

      // Auto-show confirm if accounts already loaded and prefill is set
      if (_autoShowConfirm &&
          !_autoConfirmTriggered &&
          amount.isNotEmpty &&
          _recipient != null &&
          (currentState is AccountCardsSummaryLoaded ||
              currentState is AccountBalanceUpdated)) {
        _autoConfirmTriggered = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showTransferConfirmation(currentState);
        });
      }
    }

    // Load categories from backend
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final budgetCubit = context.read<BudgetCubit>();
      final categories = await budgetCubit.loadServiceCategories('transfer');
      if (mounted && categories.isNotEmpty) {
        setState(() {
          _availableCategories = categories;
        });
      }
    } on ProviderNotFoundException catch (_) {
      // BudgetCubit not in tree — keep fallback categories
    } catch (e) {
      debugPrint('Failed to load categories: $e');
      // Keep fallback categories
    }
  }

  // --- Input and Formatting Logic (Updated for Minor Units) ---

  void _onNumberPress(String value) {
    setState(() {
      if (value == '<') {
        if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
        }
      } else {
        // Prevent excessive length (e.g., 8 digits for £99999.99)
        if (amount.length < 8) {
          amount += value;
        }
      }
      // Update controller to show formatted value
      _amountController.text = _formatAmount();
    });
  }

  void _setQuickAmount(int value) {
    setState(() {
      // Convert major unit value to minor unit string (e.g., 20 -> "2000")
      amount = '${value}00';
      // Update controller to show formatted value
      _amountController.text = _formatAmount();
    });
  }

  /// Get currency symbol from currency code
  String _getCurrencySymbol(String? currencyCode) {
    switch (currencyCode?.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      default:
        return '₦'; // Default to Naira since signup is Nigeria-only
    }
  }

  /// Format amount WITHOUT currency symbol (symbol is shown separately)
  String _formatAmount() {
    if (amount.isEmpty) return '0.00';
    try {
      // Parse the minor unit string and convert to major units for formatting
      double value = double.parse(amount) / 100.0;
      // Format without symbol - just the number with 2 decimal places
      return NumberFormat('#,##0.00', 'en_US').format(value);
    } catch (e) {
      print("Error formatting amount: $e");
      return '0.00'; // Handle parsing error gracefully
    }
  }

  // --- UI Building Methods --- (Largely unchanged, minor fixes)

  // Updated to use AccountSummaryEntity from AccountCardsSummaryCubit state
  Widget _buildCardSelector(AccountCardsSummaryState accountState) {
    if (accountState is AccountCardsSummaryLoading ||
        accountState is AccountCardsSummaryInitial) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }
    if (accountState is AccountCardsSummaryError) {
      return Center(
          child: Text('Error loading accounts: ${accountState.message}',
              style: const TextStyle(color: Colors.red)));
    }
    // Handle both AccountCardsSummaryLoaded and AccountBalanceUpdated states
    // AccountBalanceUpdated is emitted when WebSocket receives a balance update
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (summaries.isEmpty) {
      return const Center(
          child: Text('No payment methods available.',
              style: TextStyle(color: Colors.white70)));
    }
    // Ensure selectedCardIndex is valid
    if (selectedCardIndex >= summaries.length) {
      // Use post-frame callback to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Check if the widget is still mounted
          setState(() => selectedCardIndex = 0);
        }
      });
      // Show a loading state temporarily while index resets
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }

    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: summaries.length,
        itemBuilder: (context, index) {
          final account = summaries[index];
            final isSelected = selectedCardIndex == index;

            // Determine account type display
            String accountTypeDisplay = 'Personal';
            Color accountTypeColor = Colors.blue;
            IconData accountIcon = Icons.account_balance_wallet;

            final accountTypeLower = account.accountType.toLowerCase();
            if (accountTypeLower.contains('saving')) {
              accountTypeDisplay = 'Savings';
              accountTypeColor = Colors.green;
              accountIcon = Icons.savings;
            } else if (accountTypeLower.contains('investment')) {
              accountTypeDisplay = 'Investment';
              accountTypeColor = Colors.orange;
              accountIcon = Icons.trending_up;
            } else if (accountTypeLower.contains('personal')) {
              accountTypeDisplay = 'Personal';
              accountTypeColor = Colors.blue;
              accountIcon = Icons.account_balance_wallet;
            }

            String last4 = account.accountNumberLast4;

            return GestureDetector(
              onTap: () => setState(() => selectedCardIndex = index),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                width: 160.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: accountTypeColor.withValues(alpha: 0.5), width: 1.5)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          accountIcon,
                          color: accountTypeColor,
                          size: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: accountTypeColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            accountTypeDisplay,
                            style: TextStyle(
                              color: accountTypeColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '•••• $last4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              symbol: _getCurrencySymbol(account.currency), decimalDigits: 2)
                          .format(account.balance),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }

  Widget _buildQuickAmounts(AccountCardsSummaryState accountState) {
    // Get currency symbol from selected account
    String currencySymbol = '₦'; // Default to Naira
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (summaries.isNotEmpty && selectedCardIndex < summaries.length) {
      currencySymbol = _getCurrencySymbol(summaries[selectedCardIndex].currency);
    }

    return SizedBox(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: quickAmounts
            .map((amountValue) => GestureDetector(
                  onTap: () => _setQuickAmount(amountValue),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      '$currencySymbol$amountValue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  void _showCategoryPicker() async {
    final result = await CategorySelectionBottomSheet.show(
      context,
      serviceName: 'transfer',
      categories: _availableCategories,
      selectedCategory: selectedCategory,
    );
    if (result != null && mounted) {
      setState(() => selectedCategory = result);
    }
  }

  void _showSchedulePicker() async {
    final now = DateTime.now();
    final initialSelectableDate =
        now.hour >= 23 && now.minute >= 55 // Edge case: near midnight
            ? now.add(const Duration(days: 1))
            : now;
    final initialDateTime = initialSelectableDate
        .add(const Duration(days: 1)); // Default to tomorrow

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: initialDateTime, // Can't schedule earlier than tomorrow
      lastDate: now.add(const Duration(days: 90)), // Limit scheduling range
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF2962FF).withValues(alpha: 0.8),
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(
                backgroundColor: Colors.black.withValues(alpha: 0.95)),
          ),
          child: child!,
        );
      },
    );

    if (date != null && context.mounted) {
      // Check context before async gap
      final initialTime =
          TimeOfDay.fromDateTime(now.add(const Duration(minutes: 5)));
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                primary: const Color(0xFF2962FF).withValues(alpha: 0.8),
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.white,
              ),
              dialogTheme: DialogThemeData(
                  backgroundColor: Colors.black.withValues(alpha: 0.95)),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        final potentialDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        // Ensure scheduled time is strictly in the future relative to now
        if (potentialDateTime.isAfter(DateTime.now())) {
          setState(() {
            scheduledDate = potentialDateTime;
            // Mutual exclusivity: clear recurring config when scheduling
            _isRecurringEnabled = false;
            _recurringConfig = null;
          });
        } else {
          Get.snackbar('Invalid Time', 'Scheduled time must be in the future.',
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    }
  }

  // Updated to use AccountSummaryEntity from AccountCardsSummaryCubit state
  void _showTransferConfirmation(AccountCardsSummaryState accountState) {
    // COMPREHENSIVE EDGE CASE VALIDATION

    // 1. Validate amount is not empty and parseable
    if (amount.isEmpty || int.tryParse(amount) == null) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // 2. Validate account data is loaded
    // AccountBalanceUpdated also contains the updated account summaries from WebSocket
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (summaries.isEmpty) {
      Get.snackbar(
        'Account Error',
        'Account data not loaded. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // 3. Validate selected card index
    if (selectedCardIndex >= summaries.length) {
      Get.snackbar(
        'Invalid Card',
        'Please select a valid payment method.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    final selectedAccount = summaries[selectedCardIndex];
    double transferAmountMajor = double.parse(amount) / 100.0;

    // 4. Validate minimum transfer amount (e.g., 0.01)
    if (transferAmountMajor < 0.01) {
      Get.snackbar(
        'Amount Too Small',
        'Minimum transfer amount is ${_getCurrencySymbol(selectedAccount.currency)}0.01',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // Get currency symbol from selected account (needed for error messages)
    final accountCurrency = selectedAccount.currency;
    final currencySymbol = _getCurrencySymbol(accountCurrency);

    // 5. Validate maximum transfer amount (e.g., ₦10,000 per transaction)
    const double maxTransferAmount = 10000.00;
    if (transferAmountMajor > maxTransferAmount) {
      Get.snackbar(
        'Amount Too Large',
        'Maximum transfer amount is $currencySymbol${NumberFormat('#,###.00').format(maxTransferAmount)}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // 6. CRITICAL: Validate sufficient balance
    // Note: Backend uses AvailableBalance for the CanDebit check, which is what
    // the frontend receives as 'balance' field from AccountSummary.
    double availableBalance = selectedAccount.balance;

    // For external transfers, estimate fee for pre-validation
    // The exact fee will be fetched later, but we use a cached/estimated fee here
    final bool isExternalTransfer = _recipient != null && _recipient!.bankName != 'LazerVault';
    final transferCubitState = context.read<TransferCubit>().state;
    double estimatedFee = 0.0;
    if (isExternalTransfer && transferCubitState is TransferFeeLoaded) {
      estimatedFee = transferCubitState.fee / 100.0;
    }

    final double totalRequired = transferAmountMajor + (isExternalTransfer ? estimatedFee : 0.0);

    if (totalRequired > availableBalance) {
      final String message;
      if (isExternalTransfer && estimatedFee > 0) {
        message = 'Insufficient balance. Amount ($currencySymbol${NumberFormat('#,###.00').format(transferAmountMajor)}) + Fee ($currencySymbol${NumberFormat('#,###.00').format(estimatedFee)}) = $currencySymbol${NumberFormat('#,###.00').format(totalRequired)} exceeds your balance of $currencySymbol${NumberFormat('#,###.00').format(availableBalance)}';
      } else {
        message = 'Your balance ($currencySymbol${NumberFormat('#,###.00').format(availableBalance)}) is insufficient for this transfer of $currencySymbol${NumberFormat('#,###.00').format(transferAmountMajor)}. Please top up your account or use a different account.';
      }
      Get.snackbar(
        'Insufficient Funds',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    // 7. Validate recipient exists and has required information
    if (_recipient == null ||
        _recipient!.name.trim().isEmpty ||
        _recipient!.accountNumber.trim().isEmpty) {
      Get.snackbar(
        'Invalid Recipient',
        'Recipient information is missing or invalid. Please go back and select a recipient.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // Additional validation for external transfers
    if (_recipient!.bankName != 'LazerVault' &&
        (_recipient!.sortCode.trim().isEmpty || _recipient!.bankName.trim().isEmpty)) {
      Get.snackbar(
        'Invalid Recipient',
        'Bank details are incomplete. Please verify the recipient\'s bank information.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // 8. Validate scheduled date is in future (if set)
    if (scheduledDate != null && !scheduledDate!.isAfter(DateTime.now())) {
      Get.snackbar(
        'Invalid Schedule',
        'Scheduled time must be in the future.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // Determine transfer type based on recipient
    final bool isInternalTransfer = _recipient!.bankName == 'LazerVault';
    final String transferType = isInternalTransfer ? 'internal' : 'domestic';

    // Get source card details
    String sourceCardType = selectedAccount.accountType;
    String sourceLast4 = selectedAccount.accountNumberLast4;
    String sourceAccountInfo = '$sourceCardType •••• $sourceLast4';

    // Fetch real transfer fee before showing dialog
    final transferCubit = context.read<TransferCubit>();
    transferCubit.getTransferFee(
      amountMinorUnits: int.parse(amount),
      currency: accountCurrency,
      transferType: transferType,
      destinationBankCode: _recipient!.sortCode,
    );

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (dialogContext) => BlocProvider.value(
        value: transferCubit,
        child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(dialogContext).size.height * 0.92,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 24,
                  spreadRadius: 3,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Column(
                    children: [
                      Container(
                        width: 64.w,
                        height: 64.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.white.withValues(alpha: 0.05),
                            ],
                          ),
                          border:
                              Border.all(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: const Icon(Icons.send_rounded,
                            color: Colors.white, size: 32),
                      ),
                      SizedBox(height: 16.h),
                      const Text(
                        'Transfer Confirmation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            children: [
                              _buildConfirmationRow(
                                'From',
                                sourceAccountInfo, // Use fetched data
                                '',
                              ),
                              _buildConfirmationRow(
                                'To',
                                _recipient!.name,
                                _recipient!.accountNumber.length >
                                        4 // Mask account number
                                    ? '•••• ${_recipient!.accountNumber.substring(_recipient!.accountNumber.length - 4)}'
                                    : _recipient!.accountNumber,
                              ),
                              if (selectedCategory != null)
                                _buildConfirmationRow(
                                  'Category',
                                  selectedCategory!.displayName,
                                  '',
                                ),
                              _buildConfirmationRow(
                                'Amount',
                                '',
                                NumberFormat.currency(
                                        symbol: currencySymbol, decimalDigits: 2)
                                    .format(transferAmountMajor),
                              ),
                              // Fee row - uses BlocConsumer to show real fee
                              BlocConsumer<TransferCubit, TransferState>(
                                listener: (context, feeState) {
                                  // Check if amount + fee exceeds balance for external transfers
                                  if (feeState is TransferFeeLoaded && isExternalTransfer) {
                                    final feeMajor = feeState.fee / 100.0;
                                    final totalRequired = transferAmountMajor + feeMajor;
                                    if (totalRequired > availableBalance) {
                                      Get.snackbar(
                                        'Insufficient Funds',
                                        'Amount ($currencySymbol${NumberFormat('#,###.00').format(transferAmountMajor)}) + Fee ($currencySymbol${NumberFormat('#,###.00').format(feeMajor)}) = $currencySymbol${NumberFormat('#,###.00').format(totalRequired)} exceeds your balance of $currencySymbol${NumberFormat('#,###.00').format(availableBalance)}',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red.withValues(alpha: 0.7),
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 5),
                                      );
                                    }
                                  }
                                },
                                builder: (context, feeState) {
                                  if (feeState is TransferFeeLoading) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Transfer Fee',
                                              style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
                                          SizedBox(
                                            width: 16, height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2, color: Colors.white54),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  final int feeMinor;
                                  final int totalMinor;
                                  if (feeState is TransferFeeLoaded) {
                                    feeMinor = feeState.fee;
                                    totalMinor = feeState.totalAmount;
                                  } else {
                                    // Fallback: 0 fee
                                    feeMinor = 0;
                                    totalMinor = int.tryParse(amount) ?? 0;
                                  }
                                  final feeMajor = feeMinor / 100.0;
                                  final totalMajor = totalMinor / 100.0;
                                  final bool isFree = feeMinor == 0;
                                  return Column(
                                    children: [
                                      _buildConfirmationRow(
                                        'Transfer Fee',
                                        '',
                                        isFree
                                            ? 'Free'
                                            : NumberFormat.currency(
                                                    symbol: currencySymbol, decimalDigits: 2)
                                                .format(feeMajor),
                                      ),
                                      _buildConfirmationRow(
                                        'Total',
                                        '',
                                        NumberFormat.currency(
                                                symbol: currencySymbol, decimalDigits: 2)
                                            .format(totalMajor),
                                        isTotal: true,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        if (scheduledDate != null)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2962FF).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.schedule,
                                    color: Color(0xFF2962FF),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Scheduled for ${DateFormat('MMM d, HH:mm').format(scheduledDate!)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        // Recurring payment toggle
                        if (scheduledDate == null)
                          StatefulBuilder(
                            builder: (context, setRecurringState) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.repeat,
                                        color: _isRecurringEnabled
                                            ? const Color(0xFF3B82F6)
                                            : const Color(0xFF9CA3AF),
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Make Recurring',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            if (_isRecurringEnabled && _recurringConfig != null)
                                              Text(
                                                _recurringConfig!.summary,
                                                style: TextStyle(
                                                  color: const Color(0xFF3B82F6),
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Switch(
                                        value: _isRecurringEnabled,
                                        activeColor: const Color(0xFF3B82F6),
                                        onChanged: (value) {
                                          if (value) {
                                            showModalBottomSheet(
                                              context: dialogContext,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (_) => RecurringTransferModal(
                                                initialConfig: _recurringConfig,
                                                onConfigured: (config) {
                                                  setRecurringState(() {
                                                    _isRecurringEnabled = true;
                                                    _recurringConfig = config;
                                                  });
                                                },
                                              ),
                                            );
                                          } else {
                                            setRecurringState(() {
                                              _isRecurringEnabled = false;
                                              _recurringConfig = null;
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      // Use StatefulBuilder to manage the button loading state locally
                      StatefulBuilder(
                        builder:
                            (BuildContext dialogCtx, StateSetter setDialogState) {
                          bool isDialogLoading =
                              _isConfirmingTransfer; // Use the main state or a local one if preferred

                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isDialogLoading
                                  ? null
                                  : () async {
                                      print("Dialog Button: Pressed!");
                                      // Generate unique transaction ID
                                      final transactionId = 'transfer_${const Uuid().v4()}';

                                      // Calculate amounts for PIN validation
                                      double transferAmountMajor = double.parse(amount) / 100.0;

                                      // Close the confirmation dialog before showing PIN modal
                                      // to avoid using the dialog's deactivated context
                                      Navigator.of(dialogCtx).pop();

                                      if (!mounted) return;

                                      // Validate PIN using the widget's context (not the dialog's)
                                      final summaries = switch (accountState) {
                                        AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                        AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                        _ => <AccountSummaryEntity>[],
                                      };
                                      final accountCurrency = summaries.isNotEmpty && selectedCardIndex < summaries.length
                                          ? summaries[selectedCardIndex].currency
                                          : 'NGN';
                                      final currSym = _getCurrencySymbol(accountCurrency);

                                      // Get fee info for PIN modal processing view
                                      final lastFee = context.read<TransferCubit>().lastFeeLoaded;
                                      final pinFee = (lastFee != null && lastFee.fee > 0) ? lastFee.fee / 100.0 : null;
                                      final pinTotal = pinFee != null ? transferAmountMajor + pinFee : null;

                                      final success = await validateTransactionPin(
                                        context: context,
                                        transactionId: transactionId,
                                        transactionType: 'transfer',
                                        amount: transferAmountMajor,
                                        fee: pinFee,
                                        totalAmount: pinTotal,
                                        currency: accountCurrency,
                                        currencySymbol: currSym,
                                        title: 'Confirm Transfer',
                                        message: 'Confirm transfer of $currSym${transferAmountMajor.toStringAsFixed(2)} to ${_recipient!.name}?',
                                        onPinValidated: (verificationToken) async {
                                          // PIN is valid, proceed with transfer
                                          await _executeTransferWithPin(
                                            accountState: accountState,
                                            transactionId: transactionId,
                                            verificationToken: verificationToken,
                                          );
                                        },
                                      );

                                      if (!success) {
                                        // PIN validation failed or was cancelled
                                        // Reset loading state
                                        if (mounted) {
                                          setState(() {
                                            _isConfirmingTransfer = false;
                                          });
                                        }
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF2962FF).withValues(alpha: 0.9),
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                disabledBackgroundColor:
                                    Colors.grey.withValues(alpha: 0.5),
                                elevation: 8,
                              ),
                              child: isDialogLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      _isRecurringEnabled
                                          ? 'Set Up Recurring'
                                          : scheduledDate != null
                                              ? 'Schedule Transfer'
                                              : 'Send Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        // Disable cancel button while confirming? Yes, currently disabled.
                        onPressed: _isConfirmingTransfer
                            ? null // Button is disabled if _isConfirmingTransfer is true
                            : () {
                                setState(() {
                                  _isConfirmingTransfer = false;
                                });
                                print("TextButton: Pressed!");
                                Navigator.pop(dialogContext);
                              }, // Closes the dialog if not confirming
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: _isConfirmingTransfer
                                ? Colors.grey // Greyed out when disabled
                                : Colors.white70,
                            fontSize: 14.sp,
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
      ),
      ),
    );
  }

  // --- Cubit Interaction ---

  /// Execute transfer with verification token (for PIN-validated transactions)
  Future<void> _executeTransferWithPin({
    required AccountCardsSummaryState accountState,
    required String transactionId,
    required String verificationToken,
  }) async {
    print("_executeTransferWithPin: Entered function.");
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      print("_executeTransferWithPin: Error - Not authenticated.");
      throw Exception('Authentication required.');
    }

    // Validate selected card and get source account ID from cubit state
    // AccountBalanceUpdated also contains the updated account summaries from WebSocket
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (summaries.isEmpty) {
      print("_executeTransferWithPin: Error - Account data not loaded.");
      throw Exception('Account data not available.');
    }
    if (selectedCardIndex >= summaries.length) {
      print("_executeTransferWithPin: Error - Invalid card index.");
      throw Exception('Invalid card selected.');
    }
    final selectedAccount = summaries[selectedCardIndex];
    final fromAccountId = selectedAccount.id;

    // Parse amount string (minor units) and convert to major units for API
    int amountMinorUnits;
    try {
      if (amount.isEmpty) throw const FormatException('Amount is empty');
      amountMinorUnits = int.parse(amount);
      if (amountMinorUnits <= 0) {
        throw Exception('Amount must be greater than zero.');
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('Amount must be greater than zero')) {
        rethrow;
      }
      throw Exception('Invalid amount entered.');
    }

    // Convert minor units to major units for SendFundsRequest (e.g., 10050 -> 100.50)
    double amountMajor = amountMinorUnits / 100.0;

    final reference = _referenceController.text.trim();
    final narration = selectedCategory != null
        ? '${selectedCategory!.displayName}: ${reference.isNotEmpty ? reference : "Transfer"}'
        : (reference.isNotEmpty ? reference : 'Transfer');

    // Get recipient account number
    // For internal transfers: use accountNumber which contains LazerVault account number
    // For external transfers: use accountNumber which is the external bank account number
    final toAccountNumber = _recipient!.accountNumber;

    // Execute the immediate transfer first
    print("_executeTransferWithPin: Calling TransferCubit.sendFunds...");
    print("_executeTransferWithPin: fromAccountId=$fromAccountId, toAccountNumber=$toAccountNumber, amount=$amountMajor");
    context.read<TransferCubit>().sendFunds(
      fromAccountId: fromAccountId,
      toAccountNumber: toAccountNumber,
      amount: amountMajor,
      description: narration,
      transactionId: transactionId,
      verificationToken: verificationToken,
      scheduledAt: scheduledDate,
    );
    print("_executeTransferWithPin: Transfer initiated.");

    // If recurring is enabled, store params for deferred setup after transfer succeeds
    // This prevents creating a recurring rule when the initial transfer fails
    if (_isRecurringEnabled && _recurringConfig != null) {
      _pendingRecurringTransactionId = transactionId;
      _pendingRecurringVerificationToken = verificationToken;
      _recurringSetupPending = true;
      _transferSucceeded = false;
      _pendingTransferSuccess = null;
      _recurringSetupInitiated = false;
      _createdRecurringTransferId = null;
      _recurringRetryCount = 0;
      print("_executeTransferWithPin: Recurring setup deferred until transfer succeeds.");
    }
  }

  /// Navigate to receipt screen after transfer success.
  /// Called immediately if no recurring setup, or deferred until recurring resolves.
  void _navigateToReceipt(BuildContext context, TransferSuccess transferState) {
    if (!mounted) return;

    final accountState = context.read<AccountCardsSummaryCubit>().state;
    final summaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    double transferAmount = 0.0;
    try {
      transferAmount = transferState.response.amount.toDouble() / 100.0;
    } catch (_) {}
    double transferFee = transferState.response.fee.toDouble() / 100.0;
    double totalAmount = transferState.response.totalAmount.toDouble() / 100.0;
    if (transferFee == 0.0) {
      final lastFeeState = context.read<TransferCubit>().lastFeeLoaded;
      if (lastFeeState != null) {
        transferFee = lastFeeState.fee / 100.0;
      }
    }
    if (totalAmount == 0 && transferAmount > 0) {
      totalAmount = transferAmount + transferFee;
    }

    String sourceAccountInfo = 'Unknown Card';
    String senderCurrency = 'NGN';
    String sourceAccountName = '';
    if (summaries.isNotEmpty && selectedCardIndex < summaries.length) {
      final selectedAccount = summaries[selectedCardIndex];
      sourceAccountInfo = '${selectedAccount.accountType} •••• ${selectedAccount.accountNumberLast4}';
      senderCurrency = selectedAccount.currency;
      sourceAccountName = selectedAccount.accountName ?? '';
    }

    String recipientAccountMasked = _recipient!.accountNumber.length > 4
        ? '•••• ${_recipient!.accountNumber.substring(_recipient!.accountNumber.length - 4)}'
        : _recipient!.accountNumber;

    final transferDetails = {
      'amount': transferAmount,
      'fee': transferFee,
      'totalAmount': totalAmount,
      'recipientName': _recipient!.name,
      'recipientAccountMasked': recipientAccountMasked,
      'recipientBankName': _recipient!.bankName,
      'sourceAccountInfo': sourceAccountInfo,
      'sourceAccountName': sourceAccountName,
      'currency': senderCurrency,
      'transferId': transferState.response.transferId.toString(),
      'timestamp': transferState.response.createdAt,
      'category': selectedCategory?.displayName,
      'reference': _referenceController.text.trim().isNotEmpty
          ? _referenceController.text.trim()
          : null,
      'status': transferState.response.status,
      'network': _recipient!.bankName == 'LazerVault'
          ? 'LazerVault Internal Transfer'
          : 'External Bank Transfer',
      'transferType': _recipient!.bankName == 'LazerVault'
          ? 'Internal Transfer'
          : 'Domestic Transfer',
      if (scheduledDate != null) 'scheduledAt': scheduledDate,
      // Recurring payment context for receipt display
      if (_isRecurringEnabled && _recurringConfig != null) ...{
        'isRecurring': true,
        'recurringFrequency': _recurringConfig!.frequency.name,
        'recurringSchedule': _recurringConfig!.summary,
        if (_createdRecurringTransferId != null)
          'recurringTransferId': _createdRecurringTransferId,
      },
    };

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        Get.offAllNamed(AppRoutes.transferProof, arguments: transferDetails);
      }
    });
  }

  /// Fire deferred recurring setup. Extracted to allow retry on failure.
  void _fireRecurringSetup(BuildContext context) {
    if (_recurringConfig == null || _pendingRecurringTransactionId == null) {
      print("_fireRecurringSetup: Missing config or transaction ID, skipping.");
      return;
    }

    final accountState = context.read<AccountCardsSummaryCubit>().state;
    final recurringSummaries = switch (accountState) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };

    if (recurringSummaries.isEmpty || selectedCardIndex >= recurringSummaries.length) {
      print("_fireRecurringSetup: No valid account data, skipping.");
      _recurringSetupPending = false;
      return;
    }

    final recurringAccount = recurringSummaries[selectedCardIndex];
    final recurringAmountMajor = int.tryParse(amount) != null ? int.parse(amount) / 100.0 : 0.0;
    final recurringReference = _referenceController.text.trim();
    final recurringNarration = selectedCategory != null
        ? '${selectedCategory!.displayName}: ${recurringReference.isNotEmpty ? recurringReference : "Transfer"}'
        : (recurringReference.isNotEmpty ? recurringReference : 'Transfer');

    _recurringSetupPending = true;
    _recurringSetupInitiated = true;

    context.read<RecurringTransferCubit>().createRecurringTransfer(
      fromAccountId: recurringAccount.id,
      toAccountNumber: _recipient!.accountNumber,
      recipientName: _recipient!.name,
      recipientBankCode: _recipient!.sortCode,
      recipientBankName: _recipient!.bankName,
      amount: recurringAmountMajor,
      description: recurringNarration,
      frequency: _recurringConfig!.frequency,
      scheduleDay: _recurringConfig!.scheduleDay,
      scheduleTime: _recurringConfig!.scheduleTimeString,
      endDate: _recurringConfig!.endDate?.toIso8601String(),
      transactionId: _pendingRecurringTransactionId!,
      verificationToken: _pendingRecurringVerificationToken!,
    );
    print("_fireRecurringSetup: Recurring transfer setup initiated (attempt ${_recurringRetryCount + 1}).");
  }

  /// Show retry dialog when recurring setup fails but transfer succeeded.
  void _showRecurringRetryDialog(BuildContext context, String errorMessage) {
    if (!mounted) {
      // Widget disposed — navigate via Get which works globally
      if (_pendingTransferSuccess != null) {
        _navigateToReceipt(context, _pendingTransferSuccess!);
      }
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(Icons.warning_amber_rounded, color: const Color(0xFFFB923C), size: 48.sp),
        title: Text(
          'Recurring Setup Failed',
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your transfer was successful, but the recurring payment could not be set up.',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                errorMessage,
                style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp),
              ),
            ),
            if (_recurringRetryCount >= _maxRecurringRetries)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  'You can set up recurring payments later from the transfer history.',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp, fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              if (_pendingTransferSuccess != null) {
                _navigateToReceipt(context, _pendingTransferSuccess!);
              }
            },
            child: Text(
              'Continue Without Recurring',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
            ),
          ),
          if (_recurringRetryCount < _maxRecurringRetries)
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _recurringRetryCount++;
                _recurringSetupInitiated = false;
                _fireRecurringSetup(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Retry Setup',
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
        ],
      ),
    );
  }

  /// Reset all recurring-related state. Called on failure, cancellation, and cleanup.
  void _resetRecurringState() {
    _recurringSetupPending = false;
    _transferSucceeded = false;
    _pendingTransferSuccess = null;
    _pendingRecurringTransactionId = null;
    _pendingRecurringVerificationToken = null;
    _recurringSetupInitiated = false;
    _createdRecurringTransferId = null;
    _recurringRetryCount = 0;
  }

  // Confirmation Row Helper (Minor Adjustments)
  Widget _buildConfirmationRow(String label, String name, String detail,
      {bool isTotal = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items at the start
          children: [
            if (name.isNotEmpty)
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTotal ? 18.sp : 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2, // Allow wrapping slightly
                ),
              ),
            if (name.isNotEmpty && detail.isNotEmpty)
              SizedBox(width: 8.w), // Add spacing
            // Allow detail text to take space but align right
            if (detail.isNotEmpty)
              Expanded(
                flex:
                    name.isNotEmpty ? 1 : 2, // Give more space if name is empty
                child: Text(
                  detail,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTotal ? 18.sp : 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
          ],
        ),
        if (!isTotal)
          Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 24.h,
            thickness: 1,
          ),
      ],
    );
  }

  @override
  void dispose() {
    _referenceController.dispose();
    _amountController.dispose();
    // Clean up recurring state — backend operations may still complete
    // but BlocListener is gone. Get.snackbar works without mounted context.
    if (_recurringSetupPending) {
      print("dispose: Recurring setup still pending — backend will complete independently.");
    }
    _resetRecurringState();
    super.dispose();
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecurringTransferCubit, RecurringTransferState>(
      listener: (context, recurringState) {
        if (recurringState is RecurringTransferCreated) {
          _recurringSetupPending = false;
          _recurringSetupInitiated = false;
          _createdRecurringTransferId = recurringState.transfer.id;
          Get.snackbar('Recurring Payment Set', recurringState.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              duration: const Duration(seconds: 4));
          // If transfer already succeeded and was waiting for recurring, navigate now
          if (_transferSucceeded && _pendingTransferSuccess != null) {
            _navigateToReceipt(context, _pendingTransferSuccess!);
          }
        } else if (recurringState is RecurringTransferError) {
          _recurringSetupPending = false;
          _recurringSetupInitiated = false;
          // Transfer succeeded but recurring failed — show retry dialog instead of navigating
          if (_transferSucceeded && _pendingTransferSuccess != null) {
            _showRecurringRetryDialog(context, recurringState.message);
          } else {
            // Transfer hasn't resolved yet — just show a snackbar
            Get.snackbar('Recurring Payment Failed', recurringState.message,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                duration: const Duration(seconds: 5));
          }
        }
      },
      child: BlocConsumer<TransferCubit, TransferState>(
      // Now directly consumes the cubit from context
      listener: (context, transferState) {
        // Access AccountCardsSummaryCubit state inside the listener
        // AccountCardsSummaryCubit is still provided higher up (likely main.dart or AppRouter itself)
        // or needs to be accessed differently if not.
        // Let's assume it's available via context.read for now.
        final accountState = context.read<AccountCardsSummaryCubit>().state;
        print("Listener: TransferState: $transferState");
        if (transferState is TransferSuccess) {
          print(
              'Listener: Transfer Success received. State: $transferState');
          if (_isConfirmingTransfer) {
            setState(() {
              _isConfirmingTransfer = false;
            });
          }

          // --- Show success in PIN modal ---
          pinModalKey.currentState?.setSuccess();

          // --- Fire deferred recurring setup after transfer succeeds ---
          // Guard: only fire once, and only if recurring was enabled
          if (_isRecurringEnabled && _recurringConfig != null
              && _pendingRecurringTransactionId != null
              && !_recurringSetupInitiated) {
            print("TransferSuccess: Firing deferred recurring transfer setup...");
            _fireRecurringSetup(context);
          }

          // --- Save Recipient After Successful Transfer ---
          // Only save if the recipient is marked for saving (isSaved=true)
          // and is not already persisted in the backend.
          // Backend handles dedup via unique constraint on (user_id, account_number, bank_name),
          // so even if this fires for an existing recipient, it will update rather than duplicate.
          if (_recipient != null && _recipient!.isSaved) {
            final recipientId = _recipient!.id;
            final parsedId = int.tryParse(recipientId);
            // Backend IDs are small auto-increment integers.
            // Temporary IDs use DateTime.now().millisecondsSinceEpoch (very large).
            // UUIDs won't parse as int (parsedId == null).
            final isAlreadySaved = parsedId != null && parsedId < 1000000000;
            if (!isAlreadySaved) {
              print("Listener: Saving new recipient to database (id: $recipientId)...");
              final authStateForSave = context.read<AuthenticationCubit>().state;
              if (authStateForSave is AuthenticationSuccess) {
                final accessToken = authStateForSave.profile.session.accessToken;
                // Use selected account's currency, falling back to locale
                final activeAccountSummaries = switch (accountState) {
                  AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                  AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                  _ => <AccountSummaryEntity>[],
                };
                final activeAccountCurrency = activeAccountSummaries.isNotEmpty && selectedCardIndex < activeAccountSummaries.length
                    ? activeAccountSummaries[selectedCardIndex].currency
                    : serviceLocator<LocaleManager>().currentCurrency;
                final recipientToSave = _recipient!.copyWith(
                  id: '0',
                  isSaved: true,
                  countryCode: _recipient!.countryCode ?? serviceLocator<LocaleManager>().currentCountry,
                  currency: _recipient!.currency ?? activeAccountCurrency,
                );
                final addRecipientUseCase = serviceLocator<AddRecipientUseCase>();
                addRecipientUseCase(
                  recipient: recipientToSave,
                  accessToken: accessToken,
                ).then((result) {
                  result.fold(
                    (failure) => print("Warning: Failed to save recipient: ${failure.message}"),
                    (saved) {
                      print("Listener: Recipient saved with id: ${saved.id}");
                      // Update local reference so subsequent transfers
                      // recognize this recipient as already saved.
                      _recipient = saved;
                    },
                  );
                });
              }
            }
          }
          // --- End Save Recipient ---

          // --- Refresh Account Summaries ---
          // Refresh immediately (no delay) since this widget will be disposed
          // when navigating to the receipt. The cubit persists across navigation.
          final refreshAuthState = context.read<AuthenticationCubit>().state;
          if (refreshAuthState is AuthenticationSuccess) {
            context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
              userId: refreshAuthState.profile.user.id,
              accessToken: refreshAuthState.profile.session.accessToken,
            );
            print("Balance refresh triggered after successful transfer");
          }
          // --- End Refresh ---

          try {
            // Prepare data for the proof screen
            double transferAmount = 0.0;
            try {
              transferAmount =
                  (transferState.response.amount)
                          .toDouble() /
                      100.0;
            } catch (_) {
              print("Warning: Could not parse amount for proof screen.");
            }
            double transferFee =
                (transferState.response.fee).toDouble() / 100.0;
            double totalAmount =
                (transferState.response.totalAmount).toDouble() /
                    100.0;
            if (transferFee == 0.0) {
              final lastFeeState = context.read<TransferCubit>().lastFeeLoaded;
              if (lastFeeState != null) {
                transferFee = lastFeeState.fee / 100.0;
              }
            }
            if (totalAmount == 0 && transferAmount > 0) {
              totalAmount = transferAmount + transferFee;
            }

            String sourceAccountInfo = 'Unknown Card';
            String senderCurrency = 'NGN';
            String sourceAccountName = '';
            final summaries = switch (accountState) {
              AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
              AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
              _ => <AccountSummaryEntity>[],
            };
            if (summaries.isNotEmpty &&
                selectedCardIndex < summaries.length) {
              final selectedAccount =
                  summaries[selectedCardIndex];
              String sourceCardType = selectedAccount.accountType;
              String sourceLast4 = selectedAccount.accountNumberLast4;
              sourceAccountInfo = '$sourceCardType •••• $sourceLast4';
              senderCurrency = selectedAccount.currency;
              sourceAccountName = selectedAccount.accountName ?? '';
            }

            String recipientAccountMasked = _recipient!.accountNumber.length >
                    4
                ? '•••• ${_recipient!.accountNumber.substring(_recipient!.accountNumber.length - 4)}'
                : _recipient!.accountNumber;

            final transferDetails = {
              'amount': transferAmount,
              'fee': transferFee,
              'totalAmount': totalAmount,
              'recipientName': _recipient!.name,
              'recipientAccountMasked': recipientAccountMasked,
              'recipientBankName': _recipient!.bankName,
              'sourceAccountInfo': sourceAccountInfo,
              'sourceAccountName': sourceAccountName,
              'currency': senderCurrency,
              'transferId':
                  transferState.response.transferId.toString(),
              'timestamp': transferState.response.createdAt,
              'category': selectedCategory?.displayName,
              'reference': _referenceController.text.trim().isNotEmpty
                  ? _referenceController.text.trim()
                  : null,
              'status': transferState.response.status,
              'network': _recipient!.bankName == 'LazerVault'
                  ? 'LazerVault Internal Transfer'
                  : 'External Bank Transfer',
              'transferType': _recipient!.bankName == 'LazerVault'
                  ? 'Internal Transfer'
                  : 'Domestic Transfer',
              if (scheduledDate != null) 'scheduledAt': scheduledDate,
              // Recurring payment context for receipt display
              if (_isRecurringEnabled && _recurringConfig != null) ...{
                'isRecurring': true,
                'recurringFrequency': _recurringConfig!.frequency.name,
                'recurringSchedule': _recurringConfig!.summary,
                if (_createdRecurringTransferId != null)
                  'recurringTransferId': _createdRecurringTransferId,
              },
            };
            print(
                'Listener: Transfer details prepared: $transferDetails');

            // Wait for success animation, then dismiss sheet and navigate to receipt
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) {
                // Pop the PIN bottom sheet
                Navigator.of(context).pop();

                // If recurring setup is still pending, defer navigation
                // until recurring resolves (success or error) so the user sees the result
                if (_recurringSetupPending) {
                  _transferSucceeded = true;
                  _pendingTransferSuccess = transferState;
                  // Safety timeout: if recurring takes >10s, warn and navigate
                  Future.delayed(const Duration(seconds: 10), () {
                    if (_recurringSetupPending && mounted) {
                      _recurringSetupPending = false;
                      _recurringSetupInitiated = false;
                      Get.snackbar(
                        'Recurring Setup Timed Out',
                        'Transfer succeeded. Recurring payment setup is still processing — check recurring transfers later.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange.withValues(alpha: 0.8),
                        colorText: Colors.white,
                        duration: const Duration(seconds: 6),
                      );
                      _navigateToReceipt(context, transferState);
                    }
                  });
                } else {
                  // No recurring or already resolved — navigate immediately
                  Future.delayed(const Duration(milliseconds: 200), () {
                    if (mounted) {
                      Get.offAllNamed(AppRoutes.transferProof,
                          arguments: transferDetails);
                    }
                  });
                }
              }
            });
          } catch (e, stackTrace) {
            print("Error inside TransferSuccess listener: $e\n$stackTrace");
            if (_isConfirmingTransfer) {
              setState(() {
                _isConfirmingTransfer = false;
              });
            }
            // Close pin sheet if open
            if (mounted) {
              try { Navigator.of(context).pop(); } catch (_) {}
            }
            Get.snackbar(
              'Error',
              'An internal error occurred while processing the transfer success.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange.withValues(alpha: 0.8),
              colorText: Colors.white,
            );
          }
        } else if (transferState is TransferFailure) {
          print(
              'Listener: Transfer Failure received: ${transferState.message}');
          if (_isConfirmingTransfer) {
            setState(() {
              _isConfirmingTransfer = false;
            });
          }

          // Reset all recurring state to prevent stale flags
          _resetRecurringState();

          // Show failure in PIN modal if open, otherwise show snackbar
          final modalState = pinModalKey.currentState;
          if (modalState != null) {
            modalState.setFailed(transferState.message);
            // Auto-close after showing failure
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                try { Navigator.of(context).pop(); } catch (_) {}
              }
            });
          } else {
            // Fallback: close any open dialog
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
          }

          // ENHANCED ERROR HANDLING
          String errorTitle = 'Transfer Failed';
          String errorMessage = transferState.message;
          Color errorColor = Colors.red.withValues(alpha: 0.7);
          Duration errorDuration = const Duration(seconds: 4);

          final lowerMessage = transferState.message.toLowerCase();

          if (lowerMessage.contains('insufficient') || lowerMessage.contains('balance')) {
            errorTitle = 'Insufficient Funds';
            errorMessage = 'Your account does not have sufficient funds for this transfer. Please check your balance and try again.';
            errorDuration = const Duration(seconds: 5);
          } else if (lowerMessage.contains('network') || lowerMessage.contains('connection') || lowerMessage.contains('timeout')) {
            errorTitle = 'Network Error';
            errorMessage = 'Unable to connect to server. Please check your internet connection and try again.';
            errorColor = Colors.orange.withValues(alpha: 0.7);
            errorDuration = const Duration(seconds: 5);
          } else if ((lowerMessage.contains('auth') || lowerMessage.contains('token') || lowerMessage.contains('unauthorized')) && !lowerMessage.contains('authorization key') && !lowerMessage.contains('provider') && !lowerMessage.contains('flutterwave')) {
            errorTitle = 'Session Expired';
            errorMessage = 'Your session has expired. Please log in again.';
            errorDuration = const Duration(seconds: 6);
          } else if (lowerMessage.contains('authorization key') || lowerMessage.contains('provider') || lowerMessage.contains('flutterwave error')) {
            errorTitle = 'Transfer Failed';
            errorMessage = 'The payment provider encountered an error. Please try again later or contact support.';
            errorDuration = const Duration(seconds: 5);
          } else if (lowerMessage.contains('recipient') || lowerMessage.contains('not found')) {
            errorTitle = 'Recipient Not Found';
            errorMessage = 'The recipient could not be found. Please verify the recipient details.';
          } else if (lowerMessage.contains('account') && lowerMessage.contains('not found')) {
            errorTitle = 'Account Error';
            errorMessage = 'Source account not found or invalid. Please select another account.';
          } else if (lowerMessage.contains('limit') || lowerMessage.contains('exceeded')) {
            errorTitle = 'Transaction Limit Exceeded';
            errorMessage = 'This transfer exceeds your transaction limits. Please contact support for assistance.';
            errorDuration = const Duration(seconds: 6);
          } else if (lowerMessage.contains('frozen') || lowerMessage.contains('locked') || lowerMessage.contains('suspended')) {
            errorTitle = 'Account Restricted';
            errorMessage = 'Your account has been temporarily restricted. Please contact support for assistance.';
            errorDuration = const Duration(seconds: 6);
          } else if (lowerMessage.contains('invalid') && lowerMessage.contains('amount')) {
            errorTitle = 'Invalid Amount';
            errorMessage = 'The transfer amount is invalid. Please enter a valid amount.';
          } else if (lowerMessage.contains('grpc') || lowerMessage.contains('unavailable')) {
            errorTitle = 'Service Unavailable';
            errorMessage = 'The service is temporarily unavailable. Please try again in a few moments.';
            errorColor = Colors.orange.withValues(alpha: 0.7);
            errorDuration = const Duration(seconds: 5);
          }

          Get.snackbar(
            errorTitle,
            errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: errorColor,
            colorText: Colors.white,
            duration: errorDuration,
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
          );
        }
      },
      builder: (context, transferState) {
        final isTransferLoading = transferState is TransferLoading;
        if (transferState is TransferSuccess) {
          print("TransferSuccess: $transferState");
        }

        // Use BlocConsumer for AccountCardsSummaryCubit to rebuild UI parts when accounts load
        return BlocConsumer<AccountCardsSummaryCubit, AccountCardsSummaryState>(
          listener: (context, accountState) {
            // Add listener to observe state changes for AccountCardsSummaryCubit
            print(
                "InitiateSendFunds AccountSummary Listener: Received state -> $accountState");

            // Auto-show confirm when prefilled from transaction history
            if (_autoShowConfirm &&
                !_autoConfirmTriggered &&
                amount.isNotEmpty &&
                _recipient != null &&
                (accountState is AccountCardsSummaryLoaded ||
                    accountState is AccountBalanceUpdated)) {
              _autoConfirmTriggered = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showTransferConfirmation(accountState);
              });
            }
          },
          builder: (context, accountState) {
            final isAccountLoading =
                accountState is AccountCardsSummaryLoading ||
                    accountState is AccountCardsSummaryInitial;
            // AccountBalanceUpdated means we have data (from WebSocket), so don't treat as loading
            final isLoading =
                isTransferLoading || isAccountLoading; // Combined loading state

            // Determine max amount (example logic, adjust as needed)
            double maxAmount = 0.0;
            final summaries = switch (accountState) {
              AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
              AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
              _ => <AccountSummaryEntity>[],
            };
            if (summaries.isNotEmpty &&
                selectedCardIndex < summaries.length) {
              maxAmount =
                  summaries[selectedCardIndex].balance; // Example: use balance as max
            }

            return Scaffold(
              backgroundColor: const Color(0xFF121212),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  // AbsorbPointer disables interaction during loading
                  child: AbsorbPointer(
                    absorbing: isLoading,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            // Top Row (Recipient Info)
                            Row(
                              children: [
                                const BackNavigator(),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          _recipient!.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4.h),
                                        // Show selected account type and number
                                        Builder(
                                          builder: (context) {
                                            final summaries = switch (accountState) {
                                              AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                              AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                              _ => <AccountSummaryEntity>[],
                                            };
                                            if (summaries.isNotEmpty &&
                                                selectedCardIndex < summaries.length)
                                              return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Account type badge
                                              Builder(
                                                builder: (context) {
                                                  final account = summaries[selectedCardIndex];
                                                  String accountTypeDisplay = 'Personal';
                                                  Color accountTypeColor = Colors.blue;

                                                  final accountTypeLower = account.accountType.toLowerCase();
                                                  if (accountTypeLower.contains('saving')) {
                                                    accountTypeDisplay = 'Savings';
                                                    accountTypeColor = Colors.green;
                                                  } else if (accountTypeLower.contains('investment')) {
                                                    accountTypeDisplay = 'Investment';
                                                    accountTypeColor = Colors.orange;
                                                  } else if (accountTypeLower.contains('personal')) {
                                                    accountTypeDisplay = 'Personal';
                                                    accountTypeColor = Colors.blue;
                                                  }

                                                  return Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                                                    decoration: BoxDecoration(
                                                      color: accountTypeColor.withValues(alpha: 0.2),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Text(
                                                      accountTypeDisplay,
                                                      style: TextStyle(
                                                        color: accountTypeColor,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 6.w),
                                              Text(
                                                '•••• ${summaries[selectedCardIndex].accountNumberLast4}',
                                                style: TextStyle(
                                                  color: Colors.white.withValues(alpha: 0.7),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          );
                                        else
                                          return Text(
                                            _recipient!.accountNumber.length > 4
                                                ? '•••• ${_recipient!.accountNumber.substring(_recipient!.accountNumber.length - 4)}'
                                                : _recipient!.accountNumber,
                                            style: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.7),
                                              fontSize: 12,
                                            ),
                                          );
                                          },
                                        ),
                                      ],
                                  ),
                                )),
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  padding: const EdgeInsets.all(2.0),
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
                                  child: CircleAvatar(
                                    backgroundColor: Colors
                                        .blueGrey[700], // Slightly darker grey
                                    child: Text(
                                        _recipient!.name.isNotEmpty
                                            ? _recipient!.name[0]
                                                .toUpperCase()
                                            : '?',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // Pay with Card Selector
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pay with',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                _buildCardSelector(accountState),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // Amount Entry Box
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Enter amount:',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  SizedBox(height: 4.0.h),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.05),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        // Get currency from selected account or default
                                        child: Builder(
                                          builder: (context) {
                                            final summaries = switch (accountState) {
                                              AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                              AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                              _ => <AccountSummaryEntity>[],
                                            };
                                            final currency = summaries.isNotEmpty &&
                                                    selectedCardIndex < summaries.length
                                                ? summaries[selectedCardIndex].currency
                                                : 'NGN';
                                            return Text(
                                              currency,
                                              style: TextStyle(color: Colors.white),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Editable amount field (read-only - use custom buttons)
                                      Expanded(
                                        child: TextField(
                                          controller: _amountController,
                                          readOnly: true,
                                          showCursor: false,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '0.00',
                                            hintStyle: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.5),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          // Remove onChanged since input is via custom buttons only
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Builder(
                                      builder: (context) {
                                        // Get currency symbol from selected account
                                        final summaries = switch (accountState) {
                                          AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                          AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                          _ => <AccountSummaryEntity>[],
                                        };
                                        String currencySymbol = '₦';
                                        if (summaries.isNotEmpty &&
                                            selectedCardIndex < summaries.length) {
                                          currencySymbol = _getCurrencySymbol(
                                              summaries[selectedCardIndex].currency);
                                        }
                                        return Text(
                                          'Max $currencySymbol${NumberFormat('#,##0.00', 'en_US').format(maxAmount)}',
                                          style: const TextStyle(color: Colors.white70),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  // Category Dropdown
                                  GestureDetector(
                                    onTap: _showCategoryPicker,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.05),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            selectedCategory?.iconData ?? Icons.category_outlined,
                                            color: selectedCategory != null
                                                ? selectedCategory!.color
                                                : Colors.white70,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              selectedCategory?.displayName ??
                                                  'Select Category',
                                              style: TextStyle(
                                                color: selectedCategory != null
                                                    ? Colors.white
                                                    : Colors.white70,
                                                fontSize: 14,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white70,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  // Reference Field
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.note_outlined,
                                          color: Colors.white70,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: TextField(
                                            controller: _referenceController,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Add a reference (optional)',
                                              hintStyle: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),

                            // Quick amounts section
                            _buildQuickAmounts(accountState),
                            SizedBox(height: 16.h),

                            // Send/Schedule Button Row
                            Row(
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      final summaries = switch (accountState) {
                                        AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
                                        AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
                                        _ => <AccountSummaryEntity>[],
                                      };
                                      final canProceed = !isLoading &&
                                          amount.isNotEmpty &&
                                          (int.tryParse(amount) ?? 0) != 0 &&
                                          summaries.isNotEmpty;
                                      return ElevatedButton(
                                        onPressed: canProceed
                                            ? () => _showTransferConfirmation(
                                                accountState)
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF2962FF)
                                              .withValues(alpha: 0.8),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          disabledBackgroundColor:
                                              Colors.grey.withValues(alpha: 0.3),
                                          disabledForegroundColor:
                                              Colors.white.withValues(alpha: 0.5),
                                        ),
                                        child: const Text(
                                          'Confirm Transfer',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                // Schedule Button
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                                  ),
                                  child: IconButton(
                                    tooltip: scheduledDate == null
                                        ? 'Schedule Transfer'
                                        : 'Scheduled: ${DateFormat('MMM d, HH:mm').format(scheduledDate!)}',
                                    onPressed:
                                        isLoading ? null : _showSchedulePicker,
                                    icon: Icon(
                                      Icons.schedule,
                                      color: scheduledDate != null
                                          ? const Color(0xFF2962FF)
                                              .withValues(alpha: 0.8)
                                          : Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0.h),

                            // Number pad
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 16.w,
                                childAspectRatio:
                                    2.5, // Adjust aspect ratio for better spacing
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  for (var i = 1; i <= 9; i++)
                                    _buildNumberButton(i.toString()),
                                  // Use Icon for clear/placeholder if needed
                                  Container(), // Placeholder
                                  _buildNumberButton('0'),
                                  _buildNumberButton('<'), // Backspace
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Loading Overlay
                        if (isLoading)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.5),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
    );
  }

  Widget _buildNumberButton(String number) {
    return TextButton(
      onPressed: () => _onNumberPress(number),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white.withValues(alpha: 0.1), // Ripple color
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.zero, // Remove default padding
      ),
      child: Center(
        child: Text(
          number == '<' ? '⌫' : number, // Use backspace icon
          style: TextStyle(
            color: Colors.white,
            fontSize: number == '<' ? 20 : 24, // Smaller size for icon
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
