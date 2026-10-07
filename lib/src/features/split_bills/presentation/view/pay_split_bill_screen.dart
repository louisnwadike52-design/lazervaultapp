import 'package:flutter/material.dart';
import 'package:lazervault/core/services/active_account_snapshot.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
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

  /// True while the settlement is running INSIDE the transaction-PIN sheet.
  ///
  /// The sheet renders the outcome itself in that window, so the BlocListener
  /// must not also raise an error snackbar — the user would get the same
  /// failure twice, once inside the sheet and once behind it.
  bool _settlingInPinSheet = false;

  /// A completed payment that must not navigate yet.
  ///
  /// Get.offAllNamed clears EVERY route — including the transaction-PIN sheet
  /// that is still running. The mixin pops that sheet when onPinValidated
  /// returns, so if we navigate first its pop lands on the receipt instead and
  /// the user is left on an empty stack: the receipt appears for an instant and
  /// then the screen is blank.
  ///
  /// It only bites when settlement is fast enough to finish while the sheet is
  /// still up, which is why it showed on INTERNAL receivers (synchronous) and
  /// not on external payouts (async, resolved later by webhook).
  ///
  /// So the listener parks the result here and the navigation happens once
  /// validateTransactionPin has returned and the sheet has closed itself.
  SplitBillSharePaid? _paidAwaitingNav;

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

  /// The transfer fee this co-payer will ALSO be charged, in minor units.
  ///
  /// Only external-bank receivers have one: that leg goes out through
  /// SendFundsExternal, and the co-payer bears the fee on their own hold
  /// exactly as in Send Funds. An internal receiver never touches a payout
  /// provider, so there is no fee and this stays null.
  ///
  /// Quoted from the SAME backend call Send Funds uses, with the paying
  /// account id attached — the quote resolves the provider fee from that
  /// wallet's rail, and omitting it silently falls back to the admin default
  /// rail, which is how a quoted fee and a charged fee come to disagree.
  int? _externalFeeMinor;
  bool _feeLoading = false;
  bool _feeFailed = false;

  /// True when this bill pays out to a bank — the only case that carries a fee.
  bool get _isExternalReceiver => receiverBankName.trim().isNotEmpty;

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

    if (!_invalidArgs && _isExternalReceiver) _loadExternalFee();

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

  /// Formats a major-unit figure in this bill's currency, with separators.
  String _money(double major) =>
      '${_currencySymbol(currency)}${NumberFormat('#,##0.00').format(major)}';

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

  // FALLBACK IS THE LIVE SNAPSHOT, NOT AccountManager.activeAccountDetails.
  //
  // That field is written by nothing in the app, so the old fallback always
  // returned null: whenever the cubit's summaries had not loaded, the balance
  // was unknown and the currency silently reverted to a default. Both now
  // resolve against the same live source the dashboard draws from.
  double? get _accountBalance {
    final summary = _selectedSummary;
    if (summary != null) return summary.availableBalance;
    return activeAccountSnapshot()?.balanceMajor;
  }

  String? get _accountDisplayCurrency {
    final summary = _selectedSummary;
    if (summary != null) return summary.currency;
    return activeAccountSnapshot()?.currency;
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

    // SETTLE INSIDE THE CALLBACK, NOT AFTER IT.
    //
    // The mixin's contract is that [onPinValidated] PERFORMS the work: it shows
    // the success phase when the callback returns and the failure phase when it
    // throws. This callback used to do nothing but capture the token, so it
    // could never throw — the sheet therefore announced "Transaction
    // Successful!" on the strength of a valid PIN alone, popped itself, and
    // only then started the payment. A settlement that failed a moment later
    // arrived as a red snackbar contradicting the tick the user had just seen.
    //
    // Running the payment here makes every phase mean what it says: Processing
    // covers the real settlement, and success is only ever shown for money that
    // actually moved.
    final cubit = context.read<SplitBillCubit>();
    setState(() => _isProcessing = true);
    try {
      await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'split_bill_payment',
        amount: amount,
        currency: currency,
        title: 'Confirm Payment',
        message:
            'Confirm split bill payment of $currency ${amount.toStringAsFixed(2)}',
        // Our own failure already carries the server's user-facing message; the
        // default builder would relabel it "complete your transfer", which is
        // both the wrong noun and less specific than what the server said.
        failureMessageBuilder: (e) => e is SplitBillPaymentFailure
            ? _friendlyPaymentError(e.message)
            : _friendlyPaymentError(e.toString()),
        onPinValidated: (token) async {
          // The sheet renders the outcome, so suppress the duplicate snackbar
          // the BlocListener would otherwise raise for the same failure.
          //
          // The flag is CLEARED IN THE OUTER finally, not here. BlocListener
          // delivers on a microtask, so clearing it the moment payShare
          // returned put the listener on the far side of the reset: the user
          // got the red "Payment Failed" banner AND the sheet's failure state
          // for one failure. Held until the sheet is done, one failure reads
          // as one failure.
          _settlingInPinSheet = true;
          await cubit.payShare(
            splitBillId: splitBillId,
            sourceAccountId: sourceAccountId,
            transactionPin: token,
          );
          final result = cubit.state;
          if (result is SplitBillError) {
            // Surface the real reason through the mixin so the sheet shows the
            // failure phase instead of a success tick.
            throw SplitBillPaymentFailure(result.message);
          }
        },
      );
    } finally {
      _settlingInPinSheet = false;
      if (mounted) setState(() => _isProcessing = false);
    }
    // The sheet has closed itself by now, so the route it popped was its own.
    // Only then is it safe to clear the stack and show the receipt.
    final paid = _paidAwaitingNav;
    if (paid != null) _goToReceipt(paid);
  }

  /// Quotes the transfer fee for an external payout.
  ///
  /// Failure is NOT fatal: the share is still payable, and core-payments
  /// charges the real fee whatever we managed to display. What it must never
  /// do is show a confident 0.00 — the co-payer would be debited more than the
  /// screen said. A failed quote says so instead.
  Future<void> _loadExternalFee() async {
    if (!mounted) return;
    setState(() {
      _feeLoading = true;
      _feeFailed = false;
    });
    try {
      final fee = await GetIt.I<IPaymentsTransferDataSource>().getTransferFee(
        amountMinorUnits: (amount * 100).round(),
        currency: currency,
        // The split-bill external leg is a domestic bank payout, the same
        // transfer type Send Funds quotes for a Nigerian bank.
        transferType: 'domestic',
        sourceAccountId: _accountManager.activeAccountId,
      );
      if (!mounted) return;
      setState(() {
        _externalFeeMinor = fee;
        _feeLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _feeLoading = false;
        _feeFailed = true;
        _externalFeeMinor = null;
      });
    }
  }

  /// Leaves for the receipt. Sole navigation path after a successful payment,
  /// so the PIN-sheet and non-PIN routes cannot drift apart.
  void _goToReceipt(SplitBillSharePaid state) {
    if (!mounted) return;
    _paidAwaitingNav = null;
    final payerUserId = context.read<AuthenticationCubit>().userId ?? '';
    Get.offAllNamed(
      AppRoutes.splitBillReceipt,
      arguments: {
        // Authoritative source: the refreshed bill + this payer's id. The
        // receipt reads real paidAt / reference / status / amount from the
        // participant record; the scalars below are a legacy fallback only.
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
        // External bills only, and only when we actually quoted it. The
        // receipt omits the row rather than printing a fee it is unsure of.
        if (_isExternalReceiver && _externalFeeMinor != null)
          'transferFeeMinor': _externalFeeMinor,
      },
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
            if (_settlingInPinSheet) {
              // The sheet is still on screen and will pop itself. Navigating
              // now would delete the route it is about to pop.
              _paidAwaitingNav = state;
              return;
            }
            _goToReceipt(state);
          } else if (state is SplitBillError) {
            setState(() => _isProcessing = false);
            // The PIN sheet is showing this same failure inline; a snackbar on
            // top of it would report the error twice.
            if (_settlingInPinSheet) return;
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
        // Elevation + background contrast instead of a hairline border,
        // matching invoices and joint funds. A 1px #2D2D2D line on a
        // #1F1F1F card is almost invisible and does nothing to separate
        // the card from the page; a shadow does.
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
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
          // THE TRANSFER FEE, ON EXTERNAL BILLS ONLY.
          //
          // This leg settles through SendFundsExternal and the co-payer bears
          // the fee on their own hold, exactly as in Send Funds — so the figure
          // above is NOT what leaves their account. It was never shown, which
          // made the debit larger than the screen said with no explanation.
          // An internal receiver never touches a payout provider and has no
          // fee, so none of this renders for one.
          if (_isExternalReceiver) ...[
            const SizedBox(height: 12),
            if (_feeLoading)
              _buildDetailRow('Transfer fee', 'Checking…')
            else if (_externalFeeMinor != null)
              _buildDetailRow(
                  'Transfer fee', _money(_externalFeeMinor! / 100.0))
            else
              // Never print a 0.00 we are not sure of — the co-payer would be
              // debited more than the screen promised. Say which it is: a
              // failed quote is a different thing from one not asked for.
              _buildDetailRow(
                'Transfer fee',
                _feeFailed
                    ? 'Couldn\'t check — charged at payment'
                    : 'Charged at payment',
              ),
            if (_externalFeeMinor != null) ...[
              const SizedBox(height: 12),
              const Divider(color: Color(0xFF2D2D2D), thickness: 1),
              const SizedBox(height: 12),
              _buildDetailRow(
                'Total to pay',
                _money(amount + _externalFeeMinor! / 100.0),
                emphasise: true,
              ),
            ],
          ],
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

  Widget _buildDetailRow(String label, String value, {bool emphasise = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: emphasise ? Colors.white : const Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: emphasise ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: emphasise ? 16 : 14,
              fontWeight: emphasise ? FontWeight.w700 : FontWeight.w600,
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

/// Carries a settlement failure out of the transaction-PIN callback.
///
/// The mixin decides success vs failure by whether [onPinValidated] throws, so
/// a failed settlement has to leave the callback as an exception rather than a
/// return value. Holding the server's own message means the sheet can show the
/// real reason instead of a generic one.
class SplitBillPaymentFailure implements Exception {
  final String message;
  const SplitBillPaymentFailure(this.message);

  @override
  String toString() => message;
}
