import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/crypto_pay/domain/pay_source.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// One holding the customer could pay with.
///
/// `fiatValueMinor` is INDICATIVE. It comes from a price snapshot and is shown
/// so the customer can tell which coin covers the payment — it is never what
/// gets sold. The server quotes against the exchange at confirm time, and the
/// amount actually delivered is the fill.
class PayableAsset {
  const PayableAsset({
    required this.symbol,
    required this.name,
    required this.balance,
    required this.fiatValueMinor,
  });

  final String symbol; // lowercase
  final String name;
  final String balance; // decimal string, as held
  final int fiatValueMinor;
}

/// The coin picker.
///
/// Opens from the Crypto segment and returns the chosen [PaySource], or null
/// when the customer backs out — which the caller must treat as "no change",
/// never as "crypto with no asset".
class PayWithCryptoSheet {
  const PayWithCryptoSheet._();

  /// Opens the picker, loading the customer's payable assets from the server.
  ///
  /// [assets] is for tests and for a caller that has already loaded them;
  /// left null, the sheet fetches. The list is NEVER filtered client-side —
  /// which coins may move money is an operator decision and the server is the
  /// only place that knows it.
  static Future<PaySource?> open(
    BuildContext context, {
    required int amountMinor,
    int? walletBalanceMinor,
    String? current,
    List<PayableAsset>? assets,
  }) {
    return showAppBottomSheet<PaySource>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _PayWithCryptoSheetBody(
        amountMinor: amountMinor,
        walletBalanceMinor: walletBalanceMinor,
        current: current,
        preloaded: assets,
      ),
    );
  }
}

class _PayWithCryptoSheetBody extends StatefulWidget {
  const _PayWithCryptoSheetBody({
    required this.amountMinor,
    required this.current,
    this.walletBalanceMinor,
    this.preloaded,
  });

  final int amountMinor;

  /// What the wallet already holds, so the sheet asks of each coin only what
  /// is actually MISSING.
  ///
  /// CRYPTO AND FIAT COMBINE — that is the default funding mode
  /// (crypto.pay.fund_mode = shortfall): the wallet pays what it can and the
  /// conversion covers the rest. Gating each coin on the FULL payment, which
  /// is what this did, refused exactly that combination: ₦2,000 in the wallet,
  /// a ₦2,500 payment and ₦1,000 of USDT was told "not enough to cover this
  /// payment" when ₦500 of USDT was all that was needed.
  ///
  /// Null means unknown, and then the full amount is used — the conservative
  /// direction, since over-asking only hides a coin that would have worked
  /// rather than offering one that cannot.
  final int? walletBalanceMinor;

  final String? current;
  final List<PayableAsset>? preloaded;

  @override
  State<_PayWithCryptoSheetBody> createState() =>
      _PayWithCryptoSheetBodyState();
}

class _PayWithCryptoSheetBodyState extends State<_PayWithCryptoSheetBody> {
  static const _brand = Color.fromARGB(255, 78, 3, 208);

  List<PayableAsset>? _assets;
  bool _loading = false;
  String _error = '';

  int get amountMinor => widget.amountMinor;

  /// What the conversion actually has to deliver: the payment less whatever
  /// the wallet already covers, never below zero.
  ///
  /// INDICATIVE, like every figure on this sheet. The server recomputes the
  /// shortfall against the live balance and adds its own drift buffer and
  /// margin, so a coin that looks just sufficient here can still be refused —
  /// before anything is sold. That direction is safe; the reverse, hiding a
  /// coin that would have worked, is the defect this replaced.
  int get neededMinor {
    final held = widget.walletBalanceMinor;
    if (held == null || held <= 0) return amountMinor;
    final short = amountMinor - held;
    return short > 0 ? short : 0;
  }

  String? get current => widget.current;
  List<PayableAsset> get assets => _assets ?? const [];

  @override
  void initState() {
    super.initState();
    if (widget.preloaded != null) {
      _assets = widget.preloaded;
    } else {
      _load();
    }
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = '';
    });
    try {
      final resp = await serviceLocator<CryptoGrpcClient>().listPayableAssets();
      if (!mounted) return;
      setState(() {
        _assets = resp.assets
            .map((a) => PayableAsset(
                  symbol: a.symbol,
                  name: a.name,
                  balance: a.balance,
                  fiatValueMinor: a.fiatValueMinor.toInt(),
                ))
            .toList(growable: false);
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      // NEVER fall back to "show everything". A list we could not load is
      // not an empty wallet and is not a free pass — offering coins we
      // cannot confirm the customer holds, or that policy may not allow,
      // would start a conversion the server will refuse anyway.
      setState(() {
        _loading = false;
        _error = 'We could not load your crypto just now.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      constraints: BoxConstraints(maxHeight: 0.75.sh),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      // The keyboard inset is the CONTAINER's, so the white surface still
      // reaches the bottom edge; the home-indicator / navigation-bar inset is
      // applied INSIDE it by the SafeArea below. Same shape as
      // TransactionPinModal — see the note on showAppBottomSheet for why the
      // surface has to be the outer widget.
      padding: EdgeInsets.only(bottom: keyboard),
      child: SafeArea(
        top: false,
        // At least the original 12.h when there is no system inset to honour.
        minimum: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Pay with crypto',
                style: GoogleFonts.inter(
                    fontSize: 16.sp, fontWeight: FontWeight.w700)),
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              // Says plainly what choosing this does. Selling is irreversible
              // and the rate is not fixed until it executes, so the customer
              // is told both things BEFORE they pick, not after.
              neededMinor < amountMinor
                  // Says the thing the customer most needs to know when the
                  // two sources combine: their naira is used first, so only
                  // the difference is sold.
                  ? 'Your wallet covers part of this. We convert only the '
                      '${_naira(neededMinor)} still needed, at the rate when '
                      'the conversion runs.'
                  : 'We convert just enough to cover this payment. The rate '
                      'is set when the conversion runs.',
              style: GoogleFonts.inter(
                  fontSize: 11.5.sp, color: Colors.grey[600], height: 1.35),
            ),
          ),
          SizedBox(height: 14.h),
          if (_loading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 28.h),
              child: const Center(child: CircularProgressIndicator()),
            )
          else if (_error.isNotEmpty)
            _failed(context)
          else if (assets.isEmpty)
            _empty(context)
          else
            Flexible(child: _list()),
          ],
        ),
      ),
    );
  }

  /// COULD NOT LOAD. Distinct from "no holdings": one is a fact about the
  /// customer, the other is a failure of ours, and telling them they have no
  /// crypto when we simply could not ask would be a lie they might act on.
  Widget _failed(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22.h),
      child: Column(
        children: [
          Icon(Icons.cloud_off_rounded, size: 36.sp, color: Colors.grey[400]),
          SizedBox(height: 10.h),
          Text(_error,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 13.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 14.h),
          OutlinedButton(onPressed: _load, child: const Text('Try again')),
        ],
      ),
    );
  }

  /// NO HOLDINGS. A dead end here is the whole reason people abandon a flow,
  /// so it offers the one action that makes the choice possible and returns
  /// the customer to where they were.
  Widget _empty(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Column(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              size: 40.sp, color: Colors.grey[400]),
          SizedBox(height: 10.h),
          Text('You have no crypto to pay with yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 6.h),
          Text('Buy some, then come back here to use it for this payment.',
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[600])),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _brand,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              onPressed: () {
                // Close the sheet FIRST, then navigate. Pushing the crypto
                // screen underneath an open modal leaves the sheet on the
                // stack, so coming back lands on a picker the customer
                // already dismissed.
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.crypto);
              },
              child: Text('Buy crypto',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: assets.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (ctx, i) {
        final a = assets[i];
        final selected = a.symbol == current;
        // A holding worth less than what is still MISSING cannot fund the
        // payment. Shown but not selectable, with the reason — hiding it
        // makes the customer hunt for a coin they can see in their wallet.
        final covers = a.fiatValueMinor >= neededMinor;
        return Opacity(
          opacity: covers ? 1 : 0.55,
          child: InkWell(
            borderRadius: BorderRadius.circular(14.r),
            onTap: covers
                ? () => Navigator.of(ctx).pop(
                      PaySource.crypto(
                        a.symbol,
                        assetBalance: a.balance,
                        // Carried so the amount screen can warn BEFORE the
                        // customer commits. 0 from the server means "could
                        // not be priced", which must travel as null — the
                        // callers treat null as unknown and proceed, and
                        // would treat 0 as "worth nothing" and refuse.
                        assetFiatValueMinor:
                            a.fiatValueMinor > 0 ? a.fiatValueMinor : null,
                      ),
                    )
                : null,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: selected ? _brand.withValues(alpha: 0.06) : Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border:
                    Border.all(color: selected ? _brand : Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: Colors.grey[100],
                    child: Text(
                      a.symbol.toUpperCase().characters.take(2).toString(),
                      style: GoogleFonts.inter(
                          fontSize: 10.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.symbol.toUpperCase(),
                            style: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: 2.h),
                        Text(
                          covers
                              ? '${a.balance} ${a.symbol.toUpperCase()}'
                              : 'Not enough — ${_naira(neededMinor)} needed',
                          style: GoogleFonts.inter(
                              fontSize: 11.5.sp,
                              color: covers
                                  ? Colors.grey[600]
                                  : Colors.orange[800]),
                        ),
                      ],
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle, color: _brand, size: 20.sp),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Renders kobo as naira with thousands separators.
///
/// Minor units everywhere internally, major units only at the edge — this
/// function IS that edge. Getting it wrong here is how ₦500 is announced as
/// ₦50,000.
String _naira(int minor) {
  final whole = (minor / 100).floor();
  final s = whole.toString();
  final out = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) out.write(',');
    out.write(s[i]);
  }
  return '\u20a6$out';
}
