import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_gift.dart';
import 'package:lazervault/src/features/sprayme/data/gift_catalog_defaults.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Buy-gifts-from-personal bottom sheet. Joiners do NOT fund a separate wallet —
/// they buy gift credit straight from their personal account, which becomes the
/// spendable "gifts to spray" balance. Shows the source account + its balance,
/// handles insufficient balance, gates on the canonical tx-PIN bottom sheet,
/// and calls [onBuy] with the minted verification token.
class BuyGiftCreditSheet extends StatefulWidget {
  final List<SprayGift> gifts;
  final String accountId;
  final String accountDisplay; // e.g. "Personal •••• 1234"
  final double accountBalanceMajor;
  final String currency;

  /// Returns an error message on failure, or null on success. Receives the
  /// PIN verification token (NOT a raw PIN) from the tx-PIN modal.
  final Future<String?> Function(
      List<Map<String, dynamic>> items, String verificationToken) onBuy;

  const BuyGiftCreditSheet({
    super.key,
    required this.gifts,
    required this.accountId,
    required this.accountDisplay,
    required this.accountBalanceMajor,
    required this.currency,
    required this.onBuy,
  });

  @override
  State<BuyGiftCreditSheet> createState() => _BuyGiftCreditSheetState();
}

class _BuyGiftCreditSheetState extends State<BuyGiftCreditSheet>
    with TransactionPinMixin<BuyGiftCreditSheet> {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  late final List<SprayGift> _gifts;
  String? _selectedGiftId;
  int _quantity = 1;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    // Only paid gifts can be bought (free gifts add no value).
    _gifts = GiftCatalogDefaults.mergeWithBackend(widget.gifts)
        .where((g) => !g.isFree && g.priceMajor > 0)
        .toList();
  }

  SprayGift? get _selected =>
      _gifts.where((g) => g.id == _selectedGiftId).firstOrNull;

  double get _totalMajor => (_selected?.priceMajor ?? 0) * _quantity;

  bool get _insufficient =>
      _selected != null && _totalMajor > widget.accountBalanceMajor;

  Future<void> _buy() async {
    final gift = _selected;
    if (gift == null || _busy) return;
    if (_insufficient) {
      _toast('Insufficient account balance', const Color(0xFFEF4444));
      return;
    }
    setState(() => _busy = true);
    HapticFeedback.mediumImpact();

    // CRITICAL: mint the token with transactionId == the source account id. The
    // sprayme-service BuyGiftCredit handler re-validates the token against
    // req.SourceAccountId (PreValidate); a UUID-bound token never matches and the
    // purchase is rejected with a PIN error. widget.accountId is the source account.
    final ok = await validateTransactionPin(
      context: context,
      transactionId: widget.accountId,
      transactionType: 'spray_buy_gift',
      amount: _totalMajor,
      currency: widget.currency,
      title: 'Buy gifts',
      message:
          'Confirm buying ${gift.emoji} ×$_quantity for ${widget.currency} ${_totalMajor.toStringAsFixed(0)}',
      successMessage: 'Gifts purchased',
      onPinValidated: (verificationToken) async {
        final err = await widget.onBuy(
          [
            {'gift_id': gift.id, 'quantity': _quantity},
          ],
          verificationToken,
        );
        // Surface a backend failure inside the PIN sheet (setFailed).
        if (err != null) throw Exception(err);
      },
    );

    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) {
      Navigator.of(context).pop();
      _toast('Gifts purchased — ready to spray', const Color(0xFF10B981));
    }
  }

  void _toast(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Buy gifts',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Bought from your personal account. The value becomes gifts you can spray.',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
              ),
            ),
            SizedBox(height: 14.h),

            // Source account
            _accountCard(),
            SizedBox(height: 14.h),

            // Gift picker
            SizedBox(
              height: 110.h,
              child: _gifts.isEmpty
                  ? Center(
                      child: Text('No purchasable gifts available',
                          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp)))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: _gifts.length,
                      separatorBuilder: (_, __) => SizedBox(width: 10.w),
                      itemBuilder: (context, i) {
                        final g = _gifts[i];
                        final selected = g.id == _selectedGiftId;
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _selectedGiftId = selected ? null : g.id;
                              _quantity = 1;
                            });
                          },
                          child: Container(
                            width: 84.w,
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFF7C3AED).withValues(alpha: 0.2)
                                  : const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: selected ? const Color(0xFF7C3AED) : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(g.emoji, style: TextStyle(fontSize: 28.sp)),
                                SizedBox(height: 4.h),
                                Text(g.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                                SizedBox(height: 2.h),
                                Text('${widget.currency} ${g.priceMajor.toStringAsFixed(0)}',
                                    style: TextStyle(
                                        color: const Color(0xFFFFD700),
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            if (_selected != null) ...[
              SizedBox(height: 12.h),
              // Quantity + total
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                            icon: Icon(Icons.remove, size: 18.sp, color: Colors.white),
                          ),
                          Text('$_quantity',
                              style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                          IconButton(
                            onPressed: _quantity < 50 ? () => setState(() => _quantity++) : null,
                            icon: Icon(Icons.add, size: 18.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text('Total: ${widget.currency} ${_totalMajor.toStringAsFixed(0)}',
                        style: TextStyle(
                            color: _insufficient ? const Color(0xFFEF4444) : Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              if (_insufficient)
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Insufficient balance in your personal account. Top up your account or pick a smaller gift.',
                      style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp),
                    ),
                  ),
                ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: (_busy || _insufficient) ? null : _buy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C3AED),
                      disabledBackgroundColor: const Color(0xFF7C3AED).withValues(alpha: 0.4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: _busy
                        ? LazerVaultLoader.small()
                        : Text(
                            'Buy ${_selected!.emoji} ×$_quantity (${widget.currency} ${_totalMajor.toStringAsFixed(0)})',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ),
            ] else
              SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _accountCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.6), width: 1.5),
        ),
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.account_balance_wallet, color: const Color(0xFF3B82F6), size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Paying from',
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                  SizedBox(height: 2.h),
                  Text(
                    widget.accountDisplay.isNotEmpty ? widget.accountDisplay : 'Personal Account',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Text('${widget.currency} ${widget.accountBalanceMajor.toStringAsFixed(0)}',
                style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
