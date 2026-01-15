import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:fixnum/fixnum.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart'; // For serviceLocator
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

class InitiateSendFunds extends StatefulWidget {
  const InitiateSendFunds({super.key, required this.recipient});
  final RecipientModel recipient;

  @override
  State<InitiateSendFunds> createState() => _InitiateSendFundsState();
}

class _InitiateSendFundsState extends State<InitiateSendFunds>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();
  String amount =
      ''; // Stores amount as string of MINOR units (e.g., "2000" for £20.00)
  // final double maxAmount = 15358.00; // TODO: Get max from selected card/account later
  int selectedCardIndex = 0;
  String? selectedCategory;
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isConfirmingTransfer = false; // State for dialog loading

  // Mock card data - Replace with actual data source
  // Added 'id' for sourceAccountId
  // REMOVED - Will be fetched from AccountCardsSummaryCubit
  // final List<Map<String, dynamic>> cards = [
  //   {
  //     'id': 1, // Example Account ID
  //     'type': 'Visa',
  //     'last4': '4242',
  //     'expiry': '12/24',
  //     'balance': 2580.50,
  //     'currency': 'GBP' // Assuming currency
  //   },
  //   {
  //     'id': 2, // Example Account ID
  //     'type': 'Mastercard',
  //     'last4': '8888',
  //     'expiry': '09/25',
  //     'balance': 1250.75,
  //     'currency': 'GBP' // Assuming currency
  //   },
  // ];

  final List<int> quickAmounts = [50, 100, 200, 500]; // Major units for display

  final List<String> categories = [
    'Food & Drinks',
    'Shopping',
    'Transportation',
    'Entertainment',
    'Bills & Utilities',
    'Others'
  ];

  DateTime? scheduledDate;
  // TimeOfDay? scheduledTime; // Removed as DateTime handles both

  // --- Fetch Accounts on Init ---
  @override
  void initState() {
    super.initState();
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

  String _formatAmount() {
    if (amount.isEmpty) return '£0.00';
    try {
      // Parse the minor unit string and convert to major units for formatting
      double value = double.parse(amount) / 100.0;
      return NumberFormat.currency(symbol: '£', decimalDigits: 2).format(value);
    } catch (e) {
      print("Error formatting amount: $e");
      return '£0.00'; // Handle parsing error gracefully
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
    if (accountState is AccountCardsSummaryLoaded) {
      final accounts = accountState.accountSummaries;
      if (accounts.isEmpty) {
        return const Center(
            child: Text('No payment methods available.',
                style: TextStyle(color: Colors.white70)));
      }
      // Ensure selectedCardIndex is valid
      if (selectedCardIndex >= accounts.length) {
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
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final account = accounts[index];
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
                              symbol: account.currency ?? '£', decimalDigits: 2)
                          .format(account.balance ?? 0.0),
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
    // Default fallback
    return const Center(
        child: Text('Could not load accounts.',
            style: TextStyle(color: Colors.white70)));
  }

  Widget _buildQuickAmounts() {
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
                      '£$amountValue',
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

  void _showCategoryPicker() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
              ),
              child: const Center(
                child: Text(
                  'Select Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 300.h),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() => selectedCategory = categories[index]);
                      Get.back();
                    },
                    leading: const Icon(
                      Icons.category_outlined,
                      color: Colors.white70,
                    ),
                    title: Text(
                      categories[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    hoverColor: Colors.white.withValues(alpha: 0.1),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black.withValues(alpha: 0.7),
      isDismissible: true,
      enableDrag: true,
    );
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
    if (accountState is! AccountCardsSummaryLoaded ||
        accountState.accountSummaries.isEmpty) {
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
    if (selectedCardIndex >= accountState.accountSummaries.length) {
      Get.snackbar(
        'Invalid Card',
        'Please select a valid payment method.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    final selectedAccount = accountState.accountSummaries[selectedCardIndex];
    double transferAmountMajor = double.parse(amount) / 100.0;

    // 4. Validate minimum transfer amount (e.g., £0.01)
    if (transferAmountMajor < 0.01) {
      Get.snackbar(
        'Amount Too Small',
        'Minimum transfer amount is £0.01',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // 5. Validate maximum transfer amount (e.g., £10,000 per transaction)
    const double maxTransferAmount = 10000.00;
    if (transferAmountMajor > maxTransferAmount) {
      Get.snackbar(
        'Amount Too Large',
        'Maximum transfer amount is £${NumberFormat('#,###.00').format(maxTransferAmount)}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // 6. CRITICAL: Validate sufficient balance (including estimated fee)
    double estimatedFee = transferAmountMajor * 0.005; // 0.5% fee
    double estimatedTotal = transferAmountMajor + estimatedFee;
    double availableBalance = selectedAccount.balance ?? 0.0;

    if (estimatedTotal > availableBalance) {
      Get.snackbar(
        'Insufficient Funds',
        'Your balance (£${NumberFormat('#,###.00').format(availableBalance)}) is insufficient. You need £${NumberFormat('#,###.00').format(estimatedTotal)} including fees.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    // 7. Validate recipient exists
    if (widget.recipient.id == null || widget.recipient.name.isEmpty) {
      Get.snackbar(
        'Invalid Recipient',
        'Recipient information is missing or invalid.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
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

    // All validations passed - calculate final amounts for confirmation
    double transferFee = transferAmountMajor * 0.005; // Example 0.5% fee
    double totalAmount = transferAmountMajor + transferFee;
    // Get source card details
    String sourceCardType = selectedAccount.accountType ?? 'Card';
    String sourceLast4 = selectedAccount.accountNumberLast4;
    String sourceAccountInfo = '$sourceCardType •••• $sourceLast4';

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(dialogContext).size.height * 0.85,
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
                                widget.recipient.name,
                                widget.recipient.accountNumber.length >
                                        4 // Mask account number
                                    ? '•••• ${widget.recipient.accountNumber.substring(widget.recipient.accountNumber.length - 4)}'
                                    : widget.recipient.accountNumber,
                              ),
                              if (selectedCategory != null)
                                _buildConfirmationRow(
                                  'Category',
                                  selectedCategory!,
                                  '',
                                ),
                              _buildConfirmationRow(
                                'Amount',
                                '',
                                NumberFormat.currency(
                                        symbol: '£', decimalDigits: 2)
                                    .format(transferAmountMajor),
                              ),
                              _buildConfirmationRow(
                                'Transfer Fee',
                                '',
                                NumberFormat.currency(
                                        symbol: '£', decimalDigits: 2)
                                    .format(transferFee),
                              ),
                              _buildConfirmationRow(
                                'Total',
                                '',
                                NumberFormat.currency(
                                        symbol: '£', decimalDigits: 2)
                                    .format(totalAmount),
                                isTotal: true,
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
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2962FF).withValues(alpha: 0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
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
                            (BuildContext context, StateSetter setDialogState) {
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
                                      final transactionId = 'transfer_${DateTime.now().millisecondsSinceEpoch}_${widget.recipient.id}';

                                      // Calculate amounts for PIN validation
                                      double transferAmountMajor = double.parse(amount) / 100.0;

                                      // Validate PIN before processing transfer
                                      final success = await validateTransactionPin(
                                        context: context,
                                        transactionId: transactionId,
                                        transactionType: 'transfer',
                                        amount: transferAmountMajor,
                                        currency: 'GBP',
                                        title: 'Confirm Transfer',
                                        message: 'Confirm transfer of £${transferAmountMajor.toStringAsFixed(2)} to ${widget.recipient.name}?',
                                        onPinValidated: (verificationToken) async {
                                          // PIN is valid, proceed with transfer
                                          _executeTransferWithPin(
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
                                      scheduledDate != null
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
    );
  }

  // --- Cubit Interaction ---

  // Updated to use AccountSummaryEntity from AccountCardsSummaryCubit state
  void _handleTransferInitiation(AccountCardsSummaryState accountState) {
    print("_handleTransferInitiation: Entered function.");
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      print("_handleTransferInitiation: Error - Not authenticated.");
      Get.snackbar('Error', 'Authentication required.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final accessToken = authState.profile.session.accessToken;

    // Validate selected card and get source account ID from cubit state
    if (accountState is! AccountCardsSummaryLoaded ||
        accountState.accountSummaries.isEmpty) {
      print("_handleTransferInitiation: Error - Account data not loaded.");
      Get.snackbar('Error', 'Account data not available.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (selectedCardIndex >= accountState.accountSummaries.length) {
      print("_handleTransferInitiation: Error - Invalid card index.");
      Get.snackbar('Error', 'Invalid card selected.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final selectedAccount = accountState.accountSummaries[selectedCardIndex];
    final fromAccountIdString = selectedAccount.id;

    // Ensure fromAccountId can be parsed to int before creating Int64
    int fromAccountIdInt;
    try {
      fromAccountIdInt = int.parse(fromAccountIdString);
    } catch (e) {
      print(
          "_handleTransferInitiation: Error - Parsing fromAccountIdString: $e");
      Get.snackbar('Error', 'Invalid source account ID format.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Get recipient ID - Ensure widget.recipient.id is not null and can be parsed to int
    int recipientIdInt; // Use non-nullable int
    try {
      final dynamic id = widget.recipient.id; // Use dynamic type
      if (id is String) {
        recipientIdInt =
            int.parse(id); // Use int.parse, will throw if invalid format
      } else if (id is int) {
        recipientIdInt = id; // Assign directly if it's already an int
      } else {
        // Handle unexpected type if necessary, or throw
        print(
            "_handleTransferInitiation: Error - Unexpected recipient ID type: $id");
        throw const FormatException('Unexpected recipient ID type');
      }
    } catch (e) {
      print("_handleTransferInitiation: Error - Parsing recipientId: $e");
      Get.snackbar(
          'Error', 'Recipient information missing or invalid: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Parse amount string (minor units)
    Int64 amountMinorUnits;
    try {
      if (amount.isEmpty) throw const FormatException('Amount is empty');
      // Use Int64.parseInt for string parsing
      amountMinorUnits = Int64.parseInt(amount);
      if (amountMinorUnits <= Int64.ZERO) {
        // Compare with Int64.ZERO
        print("_handleTransferInitiation: Error - Amount is zero or less.");
        Get.snackbar('Error', 'Amount must be greater than zero.',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    } catch (e) {
      print("_handleTransferInitiation: Error - Parsing amount: $e");
      Get.snackbar('Error', 'Invalid amount entered.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final category = selectedCategory;
    final reference = _referenceController.text.trim();

    // Call the Cubit - Pass DateTime? directly
    print(
        "_handleTransferInitiation: Calling TransferCubit.initiateTransfer...");
    context.read<TransferCubit>().initiateTransfer(
          fromAccountId: Int64(fromAccountIdInt), // Use parsed Int64
          amount: amountMinorUnits,
          accessToken: accessToken,
          recipientId: Int64(recipientIdInt), // Use parsed recipient ID
          category: category,
          reference: reference.isNotEmpty ? reference : null,
          scheduledAt: scheduledDate, // Pass DateTime? directly
        );
    print("_handleTransferInitiation: Transfer initiation called.");
  }

  /// Execute transfer with verification token (for PIN-validated transactions)
  void _executeTransferWithPin({
    required AccountCardsSummaryState accountState,
    required String transactionId,
    required String verificationToken,
  }) {
    print("_executeTransferWithPin: Entered function.");
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      print("_executeTransferWithPin: Error - Not authenticated.");
      Get.snackbar('Error', 'Authentication required.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final accessToken = authState.profile.session.accessToken;

    // Validate selected card and get source account ID from cubit state
    if (accountState is! AccountCardsSummaryLoaded ||
        accountState.accountSummaries.isEmpty) {
      print("_executeTransferWithPin: Error - Account data not loaded.");
      Get.snackbar('Error', 'Account data not available.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (selectedCardIndex >= accountState.accountSummaries.length) {
      print("_executeTransferWithPin: Error - Invalid card index.");
      Get.snackbar('Error', 'Invalid card selected.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final selectedAccount = accountState.accountSummaries[selectedCardIndex];
    final fromAccountIdString = selectedAccount.id;

    // Ensure fromAccountId can be parsed to int before creating Int64
    int fromAccountIdInt;
    try {
      fromAccountIdInt = int.parse(fromAccountIdString);
    } catch (e) {
      print(
          "_executeTransferWithPin: Error - Parsing fromAccountIdString: $e");
      Get.snackbar('Error', 'Invalid source account ID format.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Get recipient ID - Ensure widget.recipient.id is not null and can be parsed to int
    int recipientIdInt;
    try {
      final dynamic id = widget.recipient.id;
      if (id is String) {
        recipientIdInt = int.parse(id);
      } else if (id is int) {
        recipientIdInt = id;
      } else {
        print(
            "_executeTransferWithPin: Error - Unexpected recipient ID type: $id");
        throw const FormatException('Unexpected recipient ID type');
      }
    } catch (e) {
      print("_executeTransferWithPin: Error - Parsing recipientId: $e");
      Get.snackbar(
          'Error', 'Recipient information missing or invalid: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Parse amount string (minor units)
    Int64 amountMinorUnits;
    try {
      if (amount.isEmpty) throw const FormatException('Amount is empty');
      amountMinorUnits = Int64.parseInt(amount);
      if (amountMinorUnits <= Int64.ZERO) {
        print("_executeTransferWithPin: Error - Amount is zero or less.");
        Get.snackbar('Error', 'Amount must be greater than zero.',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    } catch (e) {
      print("_executeTransferWithPin: Error - Parsing amount: $e");
      Get.snackbar('Error', 'Invalid amount entered.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final category = selectedCategory;
    final reference = _referenceController.text.trim();

    // Call the Cubit with verification token
    print(
        "_executeTransferWithPin: Calling TransferCubit.initiateTransferWithToken...");
    context.read<TransferCubit>().initiateTransferWithToken(
          fromAccountId: Int64(fromAccountIdInt),
          amount: amountMinorUnits,
          accessToken: accessToken,
          recipientId: Int64(recipientIdInt),
          category: category,
          reference: reference.isNotEmpty ? reference : null,
          scheduledAt: scheduledDate,
          transactionId: transactionId,
          verificationToken: verificationToken,
        );
    print("_executeTransferWithPin: Transfer initiation with token called.");
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
    super.dispose();
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    // Wrap the main content with BlocProvider and BlocConsumer
    // REMOVE MultiBlocProvider - It will be provided by the AppRouter
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (_) => serviceLocator<TransferCubit>()),
    //     // Provide AccountCardsSummaryCubit here as well
    //     BlocProvider.value(value: context.read<AccountCardsSummaryCubit>()),
    //   ],
    // child: BlocConsumer<TransferCubit, TransferState>(
    return BlocConsumer<TransferCubit, TransferState>(
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
              'Listener: Transfer Success received. State: $transferState'); // Debug print
          // Ensure loading state is reset
          if (_isConfirmingTransfer) {
            print('Listener: Resetting confirm transfer flag.'); // Debug print
            setState(() {
              _isConfirmingTransfer = false;
            });
          }

          // --- Refresh Account Summaries ---
          print(
              "Listener: Refreshing account summaries after successful transfer...");
          final authStateForRefresh = context.read<AuthenticationCubit>().state;
          if (authStateForRefresh is AuthenticationSuccess) {
            final userId = authStateForRefresh.profile.user.id;
            final accessToken = authStateForRefresh.profile.session.accessToken;
            context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
                  userId: userId,
                  accessToken: accessToken,
                );
          } else {
            print(
                "Warning: Could not refresh accounts as user is not authenticated.");
          }
          // --- End Refresh ---

          try {
            print('Listener: Preparing transfer details...'); // Debug print
            // Prepare data for the proof screen
            double transferAmount = 0.0;
            try {
              // Convert amount from response (minor units) if available, else use original input
              transferAmount =
                  (transferState.response.amount ?? Int64.parseInt(amount))
                          .toDouble() /
                      100.0;
            } catch (_) {
              print("Warning: Could not parse amount for proof screen.");
            }
            // Use fee/total from response if available
            double transferFee =
                (transferState.response.fee ?? Int64(0)).toDouble() / 100.0;
            double totalAmount =
                (transferState.response.totalAmount ?? Int64(0)).toDouble() /
                    100.0;
            // Fallback calculation if total is missing from response
            if (totalAmount == 0 && transferAmount > 0) {
              print(
                  "Warning: Total amount missing from response, calculating locally.");
              transferFee = transferAmount * 0.005; // Recalculate fee example
              totalAmount = transferAmount + transferFee;
            }

            String sourceAccountInfo = 'Unknown Card';
            // Get source info from AccountCardsSummaryCubit state
            if (accountState is AccountCardsSummaryLoaded &&
                accountState.accountSummaries.isNotEmpty &&
                selectedCardIndex < accountState.accountSummaries.length) {
              final selectedAccount =
                  accountState.accountSummaries[selectedCardIndex];
              String sourceCardType = selectedAccount.accountType ?? 'Card';
              String sourceLast4 = selectedAccount.accountNumberLast4;
              sourceAccountInfo = '$sourceCardType •••• $sourceLast4';
            } else {
              print(
                  "Warning: Could not get source account info for proof screen.");
            }

            String recipientAccountMasked = widget
                        .recipient.accountNumber.length >
                    4
                ? '•••• ${widget.recipient.accountNumber.substring(widget.recipient.accountNumber.length - 4)}'
                : widget.recipient.accountNumber;

            final transferDetails = {
              'amount': transferAmount,
              'fee': transferFee,
              'totalAmount': totalAmount,
              'recipientName': widget.recipient.name,
              'recipientAccountMasked': recipientAccountMasked,
              'sourceAccountInfo': sourceAccountInfo,
              // Use transferId from response (assuming it's Int64)
              'transferId':
                  transferState.response.transferId.toString() ?? 'N/A',
              'timestamp': transferState.response.createdAt ??
                  DateTime.now(), // Use time from response if available
              'category': selectedCategory,
              'reference': _referenceController.text.trim().isNotEmpty
                  ? _referenceController.text.trim()
                  : null,
              'status': transferState.response.status ??
                  'Completed', // Or derive from response
            };
            print(
                'Listener: Transfer details prepared: $transferDetails'); // Debug print

            Get.snackbar(
              'Transfer Initiated',
              'Status: ${transferState.response.status}',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withValues(alpha: 0.7),
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );

            // Navigate to processing screen WITH details
            Future.delayed(const Duration(seconds: 1), () {
              print('Listener: Navigating to TransferProcessing...'); // Debug print
              if (mounted) {
                // Ensure widget is still mounted before navigating
                Get.offAllNamed(AppRoutes.transferProcessing,
                    arguments:
                        transferDetails); // This should dismiss the dialog
              }
            });
          } catch (e, stackTrace) {
            print("Error inside TransferSuccess listener: $e\n$stackTrace");
            // Optionally show an error message to the user here as well
            if (_isConfirmingTransfer) {
              // Ensure loading state is reset even if listener errors occur
              setState(() {
                _isConfirmingTransfer = false;
              });
            }
            if (Get.isDialogOpen ?? false) {
              // Close dialog if listener failed
              Get.back();
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
              'Listener: Transfer Failure received: ${transferState.message}'); // Debug print
          // Ensure loading state is reset
          if (_isConfirmingTransfer) {
            setState(() {
              _isConfirmingTransfer = false;
            });
          }

          // Close the confirmation dialog if it's open
          if (Get.isDialogOpen ?? false) {
            print('Listener: Closing dialog due to failure.'); // Debug print
            Get.back();
          }

          // ENHANCED ERROR HANDLING - Provide specific feedback based on error type
          String errorTitle = 'Transfer Failed';
          String errorMessage = transferState.message;
          Color errorColor = Colors.red.withValues(alpha: 0.7);
          Duration errorDuration = const Duration(seconds: 4);

          // Parse error message to provide better UX
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
          } else if (lowerMessage.contains('auth') || lowerMessage.contains('token') || lowerMessage.contains('unauthorized')) {
            errorTitle = 'Session Expired';
            errorMessage = 'Your session has expired. Please log in again.';
            errorDuration = const Duration(seconds: 6);
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

          // Show enhanced error snackbar
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
          },
          builder: (context, accountState) {
            final isAccountLoading =
                accountState is AccountCardsSummaryLoading ||
                    accountState is AccountCardsSummaryInitial;
            final isLoading =
                isTransferLoading || isAccountLoading; // Combined loading state

            // Determine max amount (example logic, adjust as needed)
            double maxAmount = 0.0;
            if (accountState is AccountCardsSummaryLoaded &&
                accountState.accountSummaries.isNotEmpty &&
                selectedCardIndex < accountState.accountSummaries.length) {
              maxAmount =
                  accountState.accountSummaries[selectedCardIndex].balance ??
                      0.0; // Example: use balance as max
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
                                          widget.recipient.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4.h),
                                        // Show selected account type and number
                                        if (accountState is AccountCardsSummaryLoaded &&
                                            accountState.accountSummaries.isNotEmpty &&
                                            selectedCardIndex < accountState.accountSummaries.length)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Account type badge
                                              Builder(
                                                builder: (context) {
                                                  final account = accountState.accountSummaries[selectedCardIndex];
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
                                                '•••• ${accountState.accountSummaries[selectedCardIndex].accountNumberLast4}',
                                                style: TextStyle(
                                                  color: Colors.white.withValues(alpha: 0.7),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                        else
                                          Text(
                                            widget.recipient.accountNumber.length > 4
                                                ? '•••• ${widget.recipient.accountNumber.substring(widget.recipient.accountNumber.length - 4)}'
                                                : widget.recipient.accountNumber,
                                            style: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.7),
                                              fontSize: 12,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                        widget.recipient.name.isNotEmpty
                                            ? widget.recipient.name[0]
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
                                        // TODO: Make currency dynamic based on selected card
                                        child: Text(
                                          // Get currency from selected account or default
                                          (accountState
                                                      is AccountCardsSummaryLoaded &&
                                                  accountState.accountSummaries
                                                      .isNotEmpty &&
                                                  selectedCardIndex <
                                                      accountState
                                                          .accountSummaries
                                                          .length)
                                              ? accountState
                                                      .accountSummaries[
                                                          selectedCardIndex]
                                                      .currency ??
                                                  'GBP'
                                              : 'GBP',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Editable amount field
                                      Expanded(
                                        child: TextField(
                                          controller: _amountController,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '£0.00',
                                            hintStyle: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.5),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          onChanged: (value) {
                                            // Parse user input and convert to minor units
                                            // Remove currency symbols and parse
                                            String cleanValue = value.replaceAll(RegExp(r'[^0-9.]'), '');
                                            if (cleanValue.isNotEmpty) {
                                              try {
                                                double majorUnits = double.parse(cleanValue);
                                                // Convert to minor units
                                                int minorUnits = (majorUnits * 100).round();
                                                setState(() {
                                                  amount = minorUnits.toString();
                                                });
                                              } catch (e) {
                                                // Invalid input, ignore
                                              }
                                            } else {
                                              setState(() {
                                                amount = '';
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Max ${NumberFormat.currency(symbol: '£', decimalDigits: 2).format(maxAmount)}', // Use dynamic max amount
                                      style: const TextStyle(
                                          color: Colors.white70),
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
                                          const Icon(
                                            Icons.category_outlined,
                                            color: Colors.white70,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              selectedCategory ??
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
                            _buildQuickAmounts(),
                            SizedBox(height: 16.h),

                            // Send/Schedule Button Row
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    // Disable button if loading or amount is invalid/zero
                                    onPressed: isLoading ||
                                            amount.isEmpty ||
                                            (int.tryParse(amount) ?? 0) == 0 ||
                                            accountState
                                                is! AccountCardsSummaryLoaded ||
                                            accountState
                                                .accountSummaries.isEmpty
                                        ? null
                                        : () => _showTransferConfirmation(
                                            accountState), // Pass state
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
