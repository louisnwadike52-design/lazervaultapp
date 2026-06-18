import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../cubit/split_bill_cubit.dart';
import '../cubit/split_bill_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class PaySplitBillScreen extends StatelessWidget {
  const PaySplitBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SplitBillCubit>(),
      child: const _PaySplitBillView(),
    );
  }
}

class _PaySplitBillView extends StatefulWidget {
  const _PaySplitBillView();

  @override
  State<_PaySplitBillView> createState() => _PaySplitBillViewState();
}

class _PaySplitBillViewState extends State<_PaySplitBillView>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  bool _isProcessing = false;

  late final String splitBillId;
  late final double amount;
  late final String currency;
  late final String creatorName;
  late final String receiverName;
  late final String description;
  bool _invalidArgs = false;

  final _accountManager = GetIt.I<AccountManager>();

  /// Who the co-payer is paying TO. Prefer an explicit receiver name; fall back
  /// to the creator (legacy bills where the creator collects).
  String get _payingToName =>
      receiverName.isNotEmpty ? receiverName : creatorName;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    splitBillId = args['splitBillId'] as String? ?? '';
    amount = (args['amount'] as num?)?.toDouble() ?? 0.0;
    currency = args['currency'] as String? ?? 'NGN';
    creatorName = args['creatorName'] as String? ?? 'Unknown';
    receiverName = args['receiverName'] as String? ?? '';
    description = args['description'] as String? ?? '';
    if (splitBillId.isEmpty || amount <= 0) {
      _invalidArgs = true;
    }

    // Ensure the accounts list is loaded so the switcher can show alternatives.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final accountState = context.read<AccountCardsSummaryCubit>().state;
      if (accountState is! AccountCardsSummaryLoaded) {
        final userId = context.read<AuthenticationCubit>().userId ?? '';
        if (userId.isNotEmpty) {
          context
              .read<AccountCardsSummaryCubit>()
              .fetchAccountSummaries(userId: userId);
        }
      }
    });
  }


  String get _formattedAmount {
    return '${_currencySymbol(currency)}${amount.toStringAsFixed(2)}';
  }

  String _currencySymbol(String code) {
    switch (code) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'GHS':
        return 'GH\u20B5';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '$code ';
    }
  }

  /// The currently selected source account, resolved from the cubit's loaded
  /// summaries by the active id. The cubit's `setActiveAccount` only updates the
  /// active id (not AccountManager.activeAccountDetails), so the summary entity
  /// is the source of truth for the displayed balance after a switch.
  AccountSummaryEntity? get _selectedSummary {
    final activeId = _accountManager.activeAccountId;
    if (activeId == null) return null;
    final state = context.read<AccountCardsSummaryCubit>().state;
    final summaries = state is AccountCardsSummaryLoaded
        ? state.accountSummaries
        : context.read<AccountCardsSummaryCubit>().currentSummaries;
    for (final s in summaries) {
      if (s.id == activeId) return s;
    }
    return null;
  }

  double? get _accountBalance {
    final summary = _selectedSummary;
    if (summary != null) return summary.availableBalance;
    return _accountManager.activeAccountDetails?.balance;
  }

  String? get _accountDisplayCurrency {
    final summary = _selectedSummary;
    if (summary != null) return summary.currency;
    return _accountManager.activeAccountDetails?.currency;
  }

  bool get _hasInsufficientFunds {
    final balance = _accountBalance;
    return balance != null && balance < amount;
  }

  Future<void> _submitPayment() async {
    final sourceAccountId = _accountManager.activeAccountId ?? '';
    if (sourceAccountId.isEmpty) {
      Get.snackbar(
        'No Account',
        'Please select an active account first',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (_hasInsufficientFunds) {
      Get.snackbar(
        'Insufficient Funds',
        'Your account balance is not enough for this payment',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    HapticFeedback.mediumImpact();

    // Open the canonical 4-digit TransactionPinModal bottom sheet. It mints a
    // single-use verification token bound to "SPLIT-PAY-{splitBillId[:8]}" —
    // the exact id split-bill-service validates the token against. The raw PIN
    // never leaves the sheet. (Chat/voice mint the same token against the same
    // binding.)
    final idPrefix =
        splitBillId.length >= 8 ? splitBillId.substring(0, 8) : splitBillId;
    final transactionId = 'SPLIT-PAY-$idPrefix';

    String? verificationToken;
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'split_bill_payment',
      amount: amount,
      currency: currency,
      title: 'Confirm Payment',
      message:
          'Confirm split bill payment of $currency ${amount.toStringAsFixed(2)}',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;
    if (!mounted) return;

    setState(() => _isProcessing = true);

    context.read<SplitBillCubit>().payShare(
          splitBillId: splitBillId,
          sourceAccountId: sourceAccountId,
          transactionPin: verificationToken!,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_invalidArgs) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: const Center(
          child: Text(
            'Invalid payment details',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Pay Split Bill',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<SplitBillCubit, SplitBillState>(
        listener: (context, state) {
          if (!mounted) return;
          if (state is SplitBillSharePaid) {
            setState(() => _isProcessing = false);
            Get.offAllNamed(
              AppRoutes.splitBillReceipt,
              arguments: {
                'transactionReference': state.transactionReference,
                'amount': amount,
                'currency': currency,
                'creatorName': creatorName,
                'receiverName': receiverName,
                'description': description,
                'paidCount': state.updatedBill.paidCount,
                'totalParticipants': state.updatedBill.totalParticipants,
              },
            );
          } else if (state is SplitBillError) {
            setState(() => _isProcessing = false);
            Get.snackbar(
              'Payment Failed',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 4),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _buildSummaryCard(),
                const SizedBox(height: 16),
                _buildAccountInfo(),
                const SizedBox(height: 40),
                _buildPayButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          const Text(
            'You\'re Paying',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formattedAmount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFF2D2D2D), thickness: 1),
          const SizedBox(height: 20),
          _buildDetailRow('Paying to', _payingToName),
          const SizedBox(height: 12),
          if (description.isNotEmpty) ...[
            _buildDetailRow('Description', description),
            const SizedBox(height: 12),
          ],
          _buildDetailRow('Currency', currency),
        ],
      ),
    );
  }

  Widget _buildAccountInfo() {
    final hasAccount = _accountManager.hasActiveAccount;
    final displayBalance = _accountBalance;
    final displayCurrency = _accountDisplayCurrency;

    return GestureDetector(
      onTap: _openAccountSwitcher,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hasInsufficientFunds
                ? const Color(0xFFEF4444).withValues(alpha: 0.5)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4834D4).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Color(0xFF4834D4),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Paying from',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _accountLabel(hasAccount),
                        style: TextStyle(
                          color: hasAccount
                              ? Colors.white
                              : const Color(0xFFEF4444),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (displayBalance != null)
                  Text(
                    '${_currencySymbol(displayCurrency ?? currency)}${displayBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: _hasInsufficientFunds
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF10B981),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.swap_horiz,
                  color: Color(0xFF4834D4),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap to change account',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_hasInsufficientFunds) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xFFEF4444),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Insufficient balance. You need ${_currencySymbol(currency)}${(amount - (_accountBalance ?? 0)).toStringAsFixed(2)} more. Tap to switch account.',
                        style: const TextStyle(
                          color: Color(0xFFEF4444),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Opens a dark-theme wallet picker sourced from [AccountCardsSummaryCubit]
  /// (the same accounts list the dashboard uses). Selecting an account writes
  /// it into [AccountManager] (active account id + details) so the displayed
  /// balance and the insufficient-funds check refresh, and so the submit path
  /// (which reads `_accountManager.activeAccountId`) picks it up unchanged.
  void _openAccountSwitcher() {
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded ||
        accountState.accountSummaries.isEmpty) {
      // Trigger a load and let the user retry once accounts arrive.
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      if (userId.isNotEmpty) {
        context
            .read<AccountCardsSummaryCubit>()
            .fetchAccountSummaries(userId: userId);
      }
      Get.snackbar(
        'Loading Accounts',
        'Fetching your accounts, please try again in a moment',
        backgroundColor: const Color(0xFF1F1F1F),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final accounts = accountState.accountSummaries
        .where((a) => a.currency.toUpperCase() == currency.toUpperCase())
        .toList();
    final selectable = accounts.isNotEmpty
        ? accounts
        : accountState.accountSummaries; // fallback: show all

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.6,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: selectable.map((account) {
                    final isSelected =
                        _accountManager.activeAccountId == account.id;
                    final hasEnough = account.availableBalance >= amount;
                    return _buildAccountOption(
                      account: account,
                      isSelected: isSelected,
                      insufficientFunds: !hasEnough,
                      onTap: () {
                        _selectAccount(account);
                        Navigator.pop(sheetContext);
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: MediaQuery.of(sheetContext).padding.bottom + 16),
            ],
          ),
        );
      },
    );
  }

  String _accountLabel(bool hasAccount) {
    if (!hasAccount) return 'No account selected';
    final summary = _selectedSummary;
    if (summary != null) {
      return '${summary.accountType} •••• ${summary.accountNumberLast4}';
    }
    return _accountManager.getAccountDisplayText();
  }

  void _selectAccount(AccountSummaryEntity account) {
    // Mirror the dashboard switcher: persist into the cubit + AccountManager so
    // every reader (including the submit path) sees the new active account.
    context.read<AccountCardsSummaryCubit>().setActiveAccount(account.id);
    setState(() {});
  }

  Widget _buildAccountOption({
    required AccountSummaryEntity account,
    required bool isSelected,
    required bool insufficientFunds,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF4834D4) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF4834D4).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                color: Color(0xFF4834D4),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.accountType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_currencySymbol(account.currency)}${account.availableBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: insufficientFunds
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF9CA3AF),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4834D4),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing || _hasInsufficientFunds
            ? null
            : _submitPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          disabledBackgroundColor:
              const Color(0xFF10B981).withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? LazerVaultLoader.small()
            : Text(
                'Pay $_formattedAmount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
