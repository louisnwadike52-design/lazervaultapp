import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
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
  final _accountManager = serviceLocator<AccountManager>();

  String? _accountId;
  String _accountDisplay = '';
  String _currency = 'NGN';
  bool _submitting = false;
  SprayWallet? _result;

  bool get _isFund => widget.action == SprayWalletAction.fund;

  @override
  void initState() {
    super.initState();
    final d = _accountManager.activeAccountDetails;
    if (d != null) {
      _accountId = d.id;
      final n = d.accountNumber;
      _accountDisplay =
          '${d.accountType} •••• ${n.length >= 4 ? n.substring(n.length - 4) : n}';
      _currency = d.currency.isNotEmpty ? d.currency : 'NGN';
    } else {
      _accountId = _accountManager.activeAccountId;
      _accountDisplay = _accountId != null ? 'Personal account' : '';
    }
    _amountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  int? get _amountKobo {
    final major = int.tryParse(_amountController.text.trim());
    if (major == null || major <= 0) return null;
    return major * 100;
  }

  bool get _canContinue {
    final kobo = _amountKobo;
    if (kobo == null || _accountId == null || _accountId!.isEmpty) return false;
    // Withdrawals are capped at the withdrawable earnings balance.
    if (!_isFund && kobo > widget.wallet.earningsBalance) return false;
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
    if (!_isFund && kobo > widget.wallet.earningsBalance) {
      final avail = (widget.wallet.earningsBalance / 100).toStringAsFixed(0);
      _snack('Insufficient earnings. Available: $_currency $avail');
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
      title: _isFund ? 'Fund wallet' : 'Withdraw earnings',
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
    final accent =
        _isFund ? const Color(0xFF7C3AED) : const Color(0xFF10B981);

    return Padding(
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
                  _isFund ? 'Fund wallet' : 'Withdraw earnings',
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
                  : 'Move your withdrawable earnings back to your account.',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            _balanceChip(
              label: _isFund ? 'Gifts to spray' : 'Earnings (withdrawable)',
              value: '$_currency ${_isFund ? spendable : earnings}',
              accent: accent,
            ),
            SizedBox(height: 16.h),
            _accountRow(),
            SizedBox(height: 16.h),
            _amountField(accent),
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
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
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
                  _accountDisplay.isEmpty ? 'No account selected' : _accountDisplay,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
