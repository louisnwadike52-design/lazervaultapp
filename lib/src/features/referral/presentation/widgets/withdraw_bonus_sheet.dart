import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_bonus_entities.dart';
import 'package:lazervault/src/features/referral/domain/repositories/i_referral_repository.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

/// Withdraw accrued referral bonus into the PERSONAL wallet.
///
/// The destination is not a choice. referral-service pays a bonus into the
/// personal wallet and nowhere else — selectPayoutAccount fails closed on any
/// other account type — so offering a picker would be offering options the
/// server will refuse.
class WithdrawBonusSheet extends StatefulWidget {
  const WithdrawBonusSheet({
    super.key,
    required this.balance,
    required this.repository,
    this.onWithdrawn,
  });

  final ReferralBonusBalanceEntity balance;
  final IReferralRepository repository;
  final VoidCallback? onWithdrawn;

  @override
  State<WithdrawBonusSheet> createState() => _WithdrawBonusSheetState();
}

class _WithdrawBonusSheetState extends State<WithdrawBonusSheet> {
  static const _bg = Color(0xFF121212);
  static const _card = Color(0xFF1C1C1E);
  static const _border = Color(0xFF2A2A2C);
  static const _accent = Color(0xFF4E03D0);

  final _controller = TextEditingController();
  bool _submitting = false;
  String? _error;

  /// The key for this withdrawal attempt.
  ///
  /// Generated once and PERSISTED, for the reason the conversion sheet learned
  /// the hard way: a timeout is exactly when somebody closes the sheet and
  /// reopens it, and a fresh key would make that retry a SECOND withdrawal.
  /// Cleared only when an attempt has definitively resolved.
  String? _idempotencyKey;
  static const _pendingKeyPref = 'referral.pending_bonus_withdrawal_key';

  @override
  void initState() {
    super.initState();
    _restoreOrCreateKey();
    // Prefilled with the whole balance, because that is what people withdraw.
    _controller.text =
        ReferralBonusBalanceEntity.majorOf(widget.balance.availableMinor)
            .toStringAsFixed(2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _restoreOrCreateKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existing = prefs.getString(_pendingKeyPref);
      if (existing != null && existing.isNotEmpty) {
        _idempotencyKey = existing;
        return;
      }
      final fresh = const Uuid().v4();
      await prefs.setString(_pendingKeyPref, fresh);
      _idempotencyKey = fresh;
    } catch (_) {
      // Storage unavailable: an in-memory key is still correct within this
      // sheet, which is the common case.
      _idempotencyKey = const Uuid().v4();
    }
  }

  Future<void> _clearPendingKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pendingKeyPref);
    } catch (_) {
      // A stale key only ever makes a later attempt the SAME withdrawal, which
      // is the safe direction.
    }
  }

  String get _symbol => CurrencyUtils.getSymbol(widget.balance.currency);

  /// Parses the field into minor units.
  ///
  /// Rounds rather than truncating: `(x * 100).toInt()` on a value like 2.30
  /// yields 229 in binary floating point, which silently withdraws a kobo less
  /// than the user typed and can leave an un-withdrawable remainder behind.
  int? _amountMinor() {
    final raw = _controller.text.trim().replaceAll(',', '');
    if (raw.isEmpty) return null;
    final major = double.tryParse(raw);
    if (major == null || major <= 0) return null;
    return (major * 100).round();
  }

  String? _validate(int? minor) {
    if (minor == null) return 'Enter an amount';
    if (minor > widget.balance.availableMinor) {
      return 'You have '
          '$_symbol${ReferralBonusBalanceEntity.majorOf(widget.balance.availableMinor).toStringAsFixed(2)}'
          ' available';
    }
    final min = widget.balance.minimumWithdrawalMinor;
    if (min > 0 && minor < min) {
      return 'Minimum withdrawal is '
          '$_symbol${ReferralBonusBalanceEntity.majorOf(min).toStringAsFixed(2)}';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_submitting) return;
    final minor = _amountMinor();
    final problem = _validate(minor);
    if (problem != null) {
      setState(() => _error = problem);
      return;
    }
    setState(() => _error = null);

    // PIN before the spinner. Showing "withdrawing" and then asking for a PIN
    // reads as though the money has already moved.
    final pin = await showTransactionPinModal(
      context,
      title: 'Withdraw referral bonus',
      message: 'Withdraw to your personal wallet',
      amount: ReferralBonusBalanceEntity.majorOf(minor!),
      currency: widget.balance.currency,
      currencySymbol: _symbol,
    );
    // A null is a deliberate cancel: no error, no snackbar, and the key is kept
    // so a later attempt is still the same attempt.
    if (pin == null || pin.length != 4) return;
    if (!mounted) return;

    setState(() => _submitting = true);
    final res = await widget.repository.withdrawReferralBonus(
      amountMinor: minor,
      idempotencyKey: _idempotencyKey ?? const Uuid().v4(),
      pin: pin,
    );
    if (!mounted) return;

    await res.fold(
      (f) async {
        // The key is deliberately KEPT. This may be a timeout on a withdrawal
        // that actually settled, and reusing the key is what makes the next
        // attempt a retry rather than a second withdrawal.
        setState(() {
          _submitting = false;
          _error = f.message;
        });
      },
      (r) async {
        await _clearPendingKey();
        if (!mounted) return;
        widget.onWithdrawn?.call();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$_symbol${ReferralBonusBalanceEntity.majorOf(r.amountMinor).toStringAsFixed(2)}'
              ' sent to ${r.destination}',
            ),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final available = widget.balance.availableMinor;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Withdraw referral bonus',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Goes to your personal '
              '${widget.balance.currency.toUpperCase()} wallet',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: _border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available',
                      style: TextStyle(
                          fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
                  Text(
                    '$_symbol${ReferralBonusBalanceEntity.majorOf(available).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            TextField(
              controller: _controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                prefixText: '$_symbol ',
                prefixStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF9CA3AF),
                ),
                filled: true,
                fillColor: _card,
                errorText: _error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: _border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: _border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: _accent),
                ),
              ),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _submitting
                    ? null
                    : () => setState(() {
                          _controller.text =
                              ReferralBonusBalanceEntity.majorOf(available)
                                  .toStringAsFixed(2);
                          _error = null;
                        }),
                child: Text('Withdraw all',
                    style: TextStyle(fontSize: 12.sp, color: _accent)),
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  disabledBackgroundColor: _accent.withValues(alpha: 0.4),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _submitting
                    ? SizedBox(
                        height: 18.h,
                        width: 18.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Withdraw',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
