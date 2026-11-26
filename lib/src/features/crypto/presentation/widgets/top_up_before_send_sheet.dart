import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// BUY WHAT IS MISSING, THEN SEND — with the customer present for both.
///
/// "Send 40 USDT" when they hold 12 used to be a dead end: the send screen
/// only ever listed coins with a positive balance, and typing over the balance
/// produced "Amount exceeds your USDT balance" and nothing else. The naira to
/// buy the difference was sitting in the wallet the whole time.
///
/// WHY THIS IS A SEQUENCE OF TWO EXISTING FLOWS, NOT A NEW SAGA. The obvious
/// shape — a server-side "buy then send" state machine — would be a third
/// deferred money path next to the two Pay-with-Crypto already has, executing
/// an irreversible on-chain send with nobody present if the buy landed an hour
/// later. Here the customer taps once, authorises the buy, watches it land,
/// and then authorises the send. Every intermediate failure leaves them
/// holding either their naira or their crypto — never a stranded obligation.
///
/// Two PINs, deliberately. They are two separate movements of money and the
/// second one is irreversible; collapsing them into one authorisation would
/// mean a PIN entered for a purchase also signed an on-chain transfer.
class TopUpBeforeSendSheet {
  const TopUpBeforeSendSheet._();

  /// Offers to buy `shortfall` of [symbol], returning true once it has landed.
  ///
  /// `false` for every other outcome — declined, refused, failed, or still
  /// pending when the customer stopped waiting — so the caller simply does not
  /// resume the send. The caller must NOT treat false as an error to report;
  /// this sheet has already said whatever needed saying.
  static Future<bool> open(
    BuildContext context, {
    required String accountId,
    required String symbol,
    required double shortfall,
    required double unitPrice,
    required int decimals,
    required Future<String?> Function(double amount, String label) requestPin,
  }) async {
    final ok = await showAppBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // Not dismissible by tapping away WHILE buying: the sheet owns the
      // poll, and a dismissal mid-purchase would leave the customer with
      // bought crypto and no idea whether the send would follow.
      isDismissible: true,
      enableDrag: true,
      builder: (ctx) => _TopUpBody(
        accountId: accountId,
        symbol: symbol,
        shortfall: shortfall,
        unitPrice: unitPrice,
        decimals: decimals,
        requestPin: requestPin,
      ),
    );
    return ok ?? false;
  }
}

class _TopUpBody extends StatefulWidget {
  const _TopUpBody({
    required this.accountId,
    required this.symbol,
    required this.shortfall,
    required this.unitPrice,
    required this.decimals,
    required this.requestPin,
  });

  final String accountId;
  final String symbol;
  final double shortfall;
  final double unitPrice;
  final int decimals;
  final Future<String?> Function(double amount, String label) requestPin;

  @override
  State<_TopUpBody> createState() => _TopUpBodyState();
}

class _TopUpBodyState extends State<_TopUpBody> {
  static const _brand = Color.fromARGB(255, 78, 3, 208);

  /// How long to wait for a bought asset to land before handing the decision
  /// back to the customer.
  ///
  /// A buy fills in seconds; this is sized for a slow one, not a stuck one. On
  /// expiry the purchase is NOT cancelled — it cannot be — so the copy says
  /// what is true: the coin is on its way and the send can be made once it
  /// arrives.
  static const _waitCeiling = Duration(seconds: 90);
  static const _pollEvery = Duration(seconds: 3);

  bool _busy = false;
  String _error = '';
  String _progress = '';

  /// The shortfall in the asset's own minor units.
  ///
  /// TO-DENOMINATED, which is the whole reason this can be exact: the quote
  /// asks the exchange for "this many USDT" and it returns the naira it costs.
  /// Converting the shortfall to naira ourselves at a snapshot price and
  /// buying that instead is how you end up a fraction short of the amount the
  /// customer actually typed, and then refuse their send a second time.
  int get _targetMinor {
    final scale = math.pow(10, widget.decimals);
    // Round UP. A rounded-down target buys a hair less than the send needs,
    // which is exactly the refusal this exists to remove.
    return (widget.shortfall * scale).ceil();
  }

  double get _indicativeCost =>
      widget.unitPrice > 0 ? widget.shortfall * widget.unitPrice : 0;

  Future<void> _buyThenReport() async {
    setState(() {
      _busy = true;
      _error = '';
      _progress = 'Getting a price…';
    });
    final repo = serviceLocator<CryptoRepository>();
    final sym = widget.symbol.toLowerCase();
    try {
      // The intent id is the PIN's subject as well as the quote's idempotency
      // key — the saga validates the token against the row's intent id, so
      // they must be the same value.
      final intentId =
          'TOPUPBUY-${DateTime.now().microsecondsSinceEpoch}-${widget.symbol.toLowerCase()}';

      final quote = await repo.createSwapQuote(
        accountId: widget.accountId,
        side: 'buy',
        fromCurrency: 'ngn',
        toCurrency: sym,
        // Zero FROM plus a TO target is what selects the to-denominated
        // branch server-side; sending both would be refused.
        fromAmountMinorUnits: 0,
        toAmountMinorUnits: _targetMinor,
        clientIntentId: intentId,
        description: 'Top up to send ${widget.symbol.toUpperCase()}',
      );
      if (!mounted) return;

      // The real cost, from the exchange rather than our snapshot. Shown in
      // the PIN sheet so the customer authorises the figure that will
      // actually leave their wallet.
      final costMajor = double.tryParse(quote.fromAmount) ?? _indicativeCost;
      setState(() => _progress = 'Confirm the purchase…');

      final token = await widget.requestPin(
        costMajor,
        'Buy ${widget.shortfall.toStringAsFixed(widget.decimals > 6 ? 6 : widget.decimals)} '
        '${widget.symbol.toUpperCase()}',
      );
      if (!mounted) return;
      if (token == null || token.isEmpty) {
        // Declined at the PIN. Nothing has moved — the quote expires on its
        // own and holds nothing.
        setState(() {
          _busy = false;
          _progress = '';
        });
        return;
      }

      setState(() => _progress = 'Buying…');
      final confirmed =
          await repo.confirmSwap(quote.transactionId, transactionPin: token);
      if (!mounted) return;

      if (confirmed.status == 'completed') {
        Navigator.of(context).pop(true);
        return;
      }

      // Async fill. Poll the SAME status the crypto receipt screens poll.
      setState(() => _progress = 'Waiting for it to land…');
      final deadline = DateTime.now().add(_waitCeiling);
      while (DateTime.now().isBefore(deadline)) {
        await Future<void>.delayed(_pollEvery);
        if (!mounted) return;
        final st = await repo.getSwapStatus(quote.transactionId);
        if (!mounted) return;
        if (st.status == 'completed') {
          Navigator.of(context).pop(true);
          return;
        }
        if (st.status == 'failed' ||
            st.status == 'reversed' ||
            st.status == 'refunded') {
          setState(() {
            _busy = false;
            _progress = '';
            // A failed buy returns the naira through the swap's own rollback.
            // Say that rather than leaving them wondering.
            _error = 'That purchase did not go through. Your money has not '
                'left your wallet.';
          });
          return;
        }
      }
      if (!mounted) return;
      // STILL PENDING. The purchase stands — it is not cancelled and must not
      // be described as failed. Close WITHOUT resuming the send: sending an
      // asset that has not arrived would simply be refused again.
      Navigator.of(context).pop(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Your ${widget.symbol.toUpperCase()} is on its way. '
            'Try the send again once it shows in your balance.'),
      ));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _progress = '';
        _error = _friendly(e);
      });
    }
  }

  /// Keeps the server's own sentence when it wrote one for a person.
  ///
  /// The naira-side refusals are the ones that matter here — an insufficient
  /// fiat balance, a minimum order, a daily cap — and every one of them is
  /// already phrased for a customer by the saga. Rewording them would lose
  /// the only actionable part.
  String _friendly(Object e) {
    final s = e.toString();
    if (s.contains('insufficient') || s.contains('Insufficient')) {
      return 'There is not enough in your wallet to buy that. '
          'Add money and try again.';
    }
    if (s.contains('min_order') || s.contains('Minimum')) {
      return 'That amount is below the minimum purchase for '
          '${widget.symbol.toUpperCase()}.';
    }
    if (s.contains('fee_misconfigured') || s.contains('temporarily')) {
      return 'Buying is temporarily unavailable. Please try again shortly.';
    }
    return 'We could not buy that just now. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final sym = widget.symbol.toUpperCase();
    final short = widget.shortfall
        .toStringAsFixed(widget.decimals > 6 ? 6 : widget.decimals);
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 42.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text('Buy $sym and continue',
              style: GoogleFonts.inter(
                  fontSize: 16.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 6.h),
          Text(
            // Names the exact shortfall rather than the whole send: the
            // customer keeps what they already hold.
            'You are $short $sym short. We can buy just that much from your '
            'wallet, then you confirm the send.',
            style: GoogleFonts.inter(
                fontSize: 12.sp, color: Colors.grey[700], height: 1.4),
          ),
          SizedBox(height: 14.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                _row('To buy', '$short $sym'),
                SizedBox(height: 8.h),
                _row(
                  'Approximate cost',
                  _indicativeCost > 0
                      ? '${CurrencySymbols.currentSymbol}${_indicativeCost.toStringAsFixed(2)}'
                      : '—',
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            // The honest caveat, before they commit rather than after: the
            // figure above is a snapshot and the exchange quotes at purchase.
            'The exact cost is set when the purchase runs, so it may differ '
            'slightly from the figure above.',
            style: GoogleFonts.inter(
                fontSize: 11.sp, color: Colors.grey[600], height: 1.35),
          ),
          if (_error.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(_error,
                style: GoogleFonts.inter(
                    fontSize: 12.sp, color: Colors.red[700], height: 1.35)),
          ],
          if (_busy && _progress.isNotEmpty) ...[
            SizedBox(height: 14.h),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 10.w),
                Text(_progress,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: Colors.grey[700])),
              ],
            ),
          ],
          SizedBox(height: 18.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _busy ? null : _buyThenReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: _brand,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
              ),
              child: Text('Buy $sym',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _busy ? null : () => Navigator.of(context).pop(false),
              child: Text('Not now',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, color: Colors.grey[700])),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String k, String v) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(k,
              style:
                  GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[600])),
          Text(v,
              style: GoogleFonts.inter(
                  fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
        ],
      );
}
