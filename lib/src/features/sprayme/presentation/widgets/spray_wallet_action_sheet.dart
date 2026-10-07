import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/active_account_snapshot.dart';
import 'package:lazervault/core/services/account_summaries_store.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Which wallet action this sheet drives.
enum SprayWalletAction { fund, withdraw }

/// Canonical Lazerspray Fund / Withdraw flow: amount entry → the app-standard
/// transaction-PIN bottom sheet (`TransactionPinMixin`) → the sprayme money
/// endpoint with the minted `verificationToken` (NOT a raw PIN).
///
/// - Fund   : debits the active main account → credits the spendable spray
///            balance ("Gifts to spray"), so users top up BEFORE buying gifts.
/// - Withdraw: debits withdrawable EARNINGS → credits the active main account.
///
/// Returns the updated [SprayWallet] via `Navigator.pop(context, wallet)` on
/// success so the caller can refresh; returns null when cancelled.
Future<SprayWallet?> showSprayWalletActionSheet(
  BuildContext context, {
  required SprayWalletAction action,
  required SprayWallet wallet,
}) {
  return showModalBottomSheet<SprayWallet>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => SprayWalletActionSheet(action: action, wallet: wallet),
  );
}

class SprayWalletActionSheet extends StatefulWidget {
  final SprayWalletAction action;
  final SprayWallet wallet;

  const SprayWalletActionSheet({
    super.key,
    required this.action,
    required this.wallet,
  });

  @override
  State<SprayWalletActionSheet> createState() => _SprayWalletActionSheetState();
}

class _SprayWalletActionSheetState extends State<SprayWalletActionSheet>
    with TransactionPinMixin<SprayWalletActionSheet> {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  final _amountController = TextEditingController();

  /// The account the money moves to or from, read LIVE.
  ///
  /// ALWAYS the personal wallet, never whatever the dashboard has active.
  /// Spray funding tops a spray balance up from your own main money; silently
  /// following a savings or campaign selection would surprise the user and,
  /// on a savings wallet, be a debit the payment path may refuse outright.
  ///
  /// This used to come from `AccountManager.activeAccountDetails`, a field
  /// nothing in the app ever writes — so it was always null, the sheet always
  /// took its fallback branch, and "From account: Personal account" appeared
  /// with no balance beside it at all. Someone funding ₦5,000 found out
  /// whether they could afford it from the failure. See
  /// active_account_snapshot.dart.
  ActiveAccountSnapshot? _account;

  String? _accountId;
  String _accountDisplay = '';
  String _currency = 'NGN';
  bool _submitting = false;
  bool _loadingAccounts = false;
  SprayWallet? _result;

  bool get _isFund => widget.action == SprayWalletAction.fund;

  @override
  void initState() {
    super.initState();
    _adoptSnapshot(personalAccountSnapshot());
    // A null snapshot does NOT mean "this user has no account".
    //
    // activeAccountSnapshot() reads AccountCardsSummaryCubit synchronously and
    // answers null whenever that cubit has not loaded yet. Nothing anywhere in
    // Lazerspray ever loaded it — the dashboard does, so the sheet worked if
    // you had been there first and showed "No account selected" forever if you
    // had not, which is exactly how it was reported: the spray balance
    // rendered fine (its own repository) above a funding row that could never
    // resolve a source account.
    //
    // Reading once in initState made that permanent: even when the summaries
    // arrived a moment later, nothing re-read them.
    //
    // So: load them if they are missing, and listen so the row fills in when
    // they land.
    if (_account == null) _loadAccounts();
    // And re-resolve whenever ANY part of the app publishes fresh summaries —
    // a dashboard refresh, a balance websocket event, a background resume
    // refetch. Without this the row keeps whatever it resolved at open time,
    // including the nothing it resolves when the sheet is the first screen to
    // need an account.
    AccountSummariesStore.revision.addListener(_onSummariesChanged);
    _amountController.addListener(() => setState(() {}));
  }

  void _onSummariesChanged() {
    if (!mounted) return;
    final resolved = personalAccountSnapshot();
    if (resolved == null) return;
    setState(() => _adoptSnapshot(resolved));
  }

  /// Copy a resolved snapshot into the fields the sheet renders from.
  void _adoptSnapshot(ActiveAccountSnapshot? a) {
    _account = a;
    if (a == null) return;
    _accountId = a.id;
    _accountDisplay = a.display;
    _currency = a.currency;
  }

  /// Fetch the account summaries this sheet depends on, then re-resolve.
  ///
  /// Best-effort and non-blocking: a failure leaves the row reading "No
  /// account selected" exactly as before, and the server still validates the
  /// funding request, so this can only ever improve the outcome.
  Future<void> _loadAccounts() async {
    if (_loadingAccounts) return;
    setState(() => _loadingAccounts = true);
    final resolved = await ensurePersonalAccountSnapshot();
    if (!mounted) return;
    setState(() {
      _loadingAccounts = false;
      _adoptSnapshot(resolved);
    });
  }

  @override
  void dispose() {
    AccountSummariesStore.revision.removeListener(_onSummariesChanged);
    _amountController.dispose();
    super.dispose();
  }

  int? get _amountKobo {
    final major = int.tryParse(_amountController.text.trim());
    if (major == null || major <= 0) return null;
    return major * 100;
  }

  /// Everything a withdrawal can draw on: unspent deposit PLUS earnings.
  ///
  /// It used to be earnings alone, so someone who funded ₦10,000 for a party
  /// and sprayed ₦3,000 could not get their remaining ₦7,000 back — their own
  /// money, already debited from their main account, with no way out except
  /// spraying it at someone else.
  int get _withdrawableKobo =>
      widget.wallet.balance + widget.wallet.earningsBalance;

  /// What the source account can actually cover, in kobo. Null when we could
  /// not read it — in which case the server decides and we do not block.
  int? get _sourceBalanceKobo {
    final a = _account;
    if (a == null) return null;
    return (a.balanceMajor * 100).round();
  }

  bool get _overSourceBalance {
    if (!_isFund) return false;
    final kobo = _amountKobo, have = _sourceBalanceKobo;
    return kobo != null && have != null && kobo > have;
  }

  bool get _canContinue {
    final kobo = _amountKobo;
    if (kobo == null || _accountId == null || _accountId!.isEmpty) return false;
    if (!_isFund && kobo > _withdrawableKobo) return false;
    // Funding more than the account holds is refused BEFORE the PIN sheet.
    // Asking someone for their transaction PIN and then telling them there
    // was never enough money is the worst order to do those two things in.
    if (_overSourceBalance) return false;
    final a = _account;
    if (_isFund && a != null && (!a.isSpendable || a.isProvisioning)) {
      return false;
    }
    return true;
  }

  Future<void> _continue() async {
    if (_submitting) return;
    final kobo = _amountKobo;
    if (kobo == null) {
      _snack('Please enter a valid amount');
      return;
    }
    if (_accountId == null || _accountId!.isEmpty) {
      _snack('No account found. Pick an account on the home screen first.');
      return;
    }
    if (!_isFund && kobo > _withdrawableKobo) {
      final avail = (_withdrawableKobo / 100).toStringAsFixed(0);
      _snack('Not enough in your wallet. Available: $_currency $avail');
      return;
    }
    if (_overSourceBalance) {
      _snack(
          'Not enough in $_accountDisplay. Available: $_currency ${_money(_account!.balanceMajor)}');
      return;
    }

    setState(() => _submitting = true);
    HapticFeedback.lightImpact();

    final repo = serviceLocator<ISprayMeRepository>();
    // CRITICAL: the verification token is bound to (userID, transactionID) at mint
    // time and the sprayme-service handler re-validates it against the ACCOUNT id
    // (PreValidate(..., req.SourceAccountId/DestinationAccountId)). So we MUST mint
    // the token with transactionId == the account id, or the token never matches and
    // every fund/withdraw is rejected with a PIN error. Fund debits the source
    // account; withdraw credits the destination account — both are _accountId here.
    final ok = await validateTransactionPin(
      context: context,
      transactionId: _accountId!,
      transactionType: _isFund ? 'spray_wallet_fund' : 'spray_wallet_withdraw',
      amount: kobo / 100,
      currency: _currency,
      title: _isFund ? 'Fund wallet' : 'Withdraw to account',
      message: _isFund
          ? 'Confirm funding your Lazerspray wallet with $_currency ${kobo ~/ 100}'
          : 'Confirm withdrawing $_currency ${kobo ~/ 100} to your account',
      successMessage: _isFund ? 'Wallet funded' : 'Withdrawal successful',
      onPinValidated: (verificationToken) async {
        _result = _isFund
            ? await repo.fundWallet(
                amount: kobo,
                sourceAccountId: _accountId!,
                verificationToken: verificationToken,
              )
            : await repo.withdrawFromWallet(
                amount: kobo,
                destinationAccountId: _accountId!,
                verificationToken: verificationToken,
              );
      },
    );

    if (!mounted) return;
    setState(() => _submitting = false);
    if (ok && _result != null) {
      Navigator.of(context).pop(_result);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: const Color(0xFFEF4444)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spendable = (widget.wallet.balance / 100).toStringAsFixed(0);
    final earnings = (widget.wallet.earningsBalance / 100).toStringAsFixed(0);
    final accent = _isFund ? const Color(0xFF7C3AED) : const Color(0xFF10B981);

    // The app-root tap-to-dismiss (main.dart GetMaterialApp.builder)
    // cannot reach inside modal sheets - the opaque sheet surface
    // occludes it - so unfocus here to dismiss the keyboard on a tap
    // in the sheet's empty area.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Icon(
                    _isFund ? Icons.add_card_rounded : Icons.savings_outlined,
                    color: accent,
                    size: 22.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    _isFund ? 'Fund wallet' : 'Withdraw to account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                _isFund
                    ? 'Top up your spray balance from your account, so you can buy gifts and spray during a session.'
                    : 'Move money back to your account — both what you have left to spray and what you have earned.',
                style:
                    TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
              ),
              SizedBox(height: 16.h),
              if (_isFund)
                _balanceChip(
                  label: 'Gifts to spray',
                  value: '$_currency $spendable',
                  accent: accent,
                )
              else ...[
                // Both pots, named and totalled. Showing only the total would
                // hide which part is unspent deposit and which is earned — and
                // showing only earnings is what made the rest look unreachable.
                _balanceChip(
                  label: 'Available to withdraw',
                  value:
                      '$_currency ${(_withdrawableKobo / 100).toStringAsFixed(0)}',
                  accent: accent,
                ),
                SizedBox(height: 8.h),
                Text(
                  '$_currency $spendable left to spray  ·  $_currency $earnings earned',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
              SizedBox(height: 16.h),
              _accountRow(),
              SizedBox(height: 16.h),
              _amountField(accent),
              if (_overSourceBalance) ...[
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline,
                        size: 14.sp, color: const Color(0xFFEF4444)),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'That is more than $_accountDisplay holds. Add money to '
                        'the account first, or enter a smaller amount.',
                        style: TextStyle(
                            color: const Color(0xFFFCA5A5), fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _canContinue && !_submitting ? _continue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    disabledBackgroundColor: accent.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _isFund ? 'Fund wallet' : 'Withdraw',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _balanceChip({
    required String label,
    required String value,
    required Color accent,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _accountRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: const Color(0xFF9CA3AF), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_isFund ? 'From account' : 'To account',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                SizedBox(height: 2.h),
                Text(
                  _accountDisplay.isNotEmpty
                      ? _accountDisplay
                      // "No account selected" is a lie while we are still
                      // fetching, and it reads as "you have no account" rather
                      // than "we have not looked yet".
                      : _loadingAccounts
                          ? 'Loading your accounts…'
                          : 'No account selected',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          // THE BALANCE, which this row never showed.
          if (_account != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_currency ${_money(_account!.balanceMajor)}',
                  style: TextStyle(
                      color: _overSourceBalance
                          ? const Color(0xFFEF4444)
                          : Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(_isFund ? 'available' : 'current balance',
                    style: TextStyle(
                        color: const Color(0xFF6B7280), fontSize: 10.sp)),
              ],
            ),
        ],
      ),
    );
  }

  /// Thousands separators — a party top-up is routinely five figures.
  static String _money(double major) {
    final digits = major.floor().toString();
    final b = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) b.write(',');
      b.write(digits[i]);
    }
    return b.toString();
  }

  Widget _amountField(Color accent) {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(
          color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        prefixText: '$_currency ',
        prefixStyle: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600),
        hintText: '0',
        hintStyle: TextStyle(color: const Color(0xFF4B5563), fontSize: 22.sp),
        filled: true,
        fillColor: const Color(0xFF161616),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: accent),
        ),
      ),
    );
  }
}
