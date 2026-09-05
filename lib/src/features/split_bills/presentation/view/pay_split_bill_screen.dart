import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../cubit/split_bill_cubit.dart';
import '../cubit/split_bill_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'pay_split_bill_screen_widgets.dart';

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

  /// Masked destination account, external-bank receivers only. Carried through
  /// purely so the receipt and its PDF can show WHICH account was paid.
  late final String receiverAccountMasked;

  /// Destination bank name, external-bank receivers only. Same purpose as
  /// [receiverAccountMasked]: it exists so the receipt can name the bank.
  late final String receiverBankName;
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
    receiverAccountMasked = args['receiverAccountMasked'] as String? ?? '';
    receiverBankName = args['receiverBankName'] as String? ?? '';
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

  /// Shared resolver — see SplitBillEntity._currencySymbol. This copy matched
  /// on the RAW code, so a lowercase or display-name currency silently fell
  /// through to a bare code prefix.
  String _currencySymbol(String code) => CurrencyUtils.getSymbol(code);

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
            final payerUserId =
                context.read<AuthenticationCubit>().userId ?? '';
            Get.offAllNamed(
              AppRoutes.splitBillReceipt,
              arguments: {
                // Authoritative source: the refreshed bill + this payer's id.
                // The receipt reads real paidAt / reference / status / amount
                // from the participant record; the scalars below are a legacy
                // fallback only.
                'bill': state.updatedBill,
                'payerUserId': payerUserId,
                'transactionReference': state.transactionReference,
                'amount': amount,
                'currency': currency,
                'creatorName': creatorName,
                'receiverName': receiverName,
                'receiverAccountMasked': receiverAccountMasked,
                'receiverBankName': receiverBankName,
                'description': description,
                'paidCount': state.updatedBill.paidCount,
                'totalParticipants': state.updatedBill.totalParticipants,
              },
            );
          } else if (state is SplitBillError) {
            setState(() => _isProcessing = false);
            Get.snackbar(
              'Payment Failed',
              _friendlyPaymentError(state.message),
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

    return Container(
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
                        color:
                            hasAccount ? Colors.white : const Color(0xFFEF4444),
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
                Icons.lock_outline,
                color: Color(0xFF6B7280),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Your active account is used for this payment',
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      'Insufficient balance. You need ${_currencySymbol(currency)}${(amount - (_accountBalance ?? 0)).toStringAsFixed(2)} more in your active account.',
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
    );
  }

  /// Turns a raw payment error (rpc/status noise) into a clear, user-friendly
  /// message. Special-cases the common split-bill payment failures; everything
  /// else falls back to the shared sanitiser (never leaks status codes).
  String _friendlyPaymentError(String raw) {
    final low = raw.toLowerCase();
    if (low.contains('same account')) {
      return "You can't pay this bill into your own account — you don't need to "
          "pay your own share of a bill you're collecting.";
    }
    if (low.contains('insufficient') || low.contains('not enough')) {
      return 'Insufficient balance in your active account for this payment.';
    }
    if (low.contains('frozen') ||
        low.contains('suspended') ||
        low.contains('closed')) {
      return 'Your account is not active for payments right now. Contact support.';
    }
    if (low.contains('already') && low.contains('paid')) {
      return 'This share has already been paid.';
    }
    return sanitizeUserFacingError(raw);
  }

  String _accountLabel(bool hasAccount) {
    if (!hasAccount) return 'No account selected';
    final summary = _selectedSummary;
    if (summary != null) {
      return '${summary.accountType} •••• ${summary.accountNumberLast4}';
    }
    return _accountManager.getAccountDisplayText();
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
        onPressed:
            _isProcessing || _hasInsufficientFunds ? null : _submitPayment,
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
