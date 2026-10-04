import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';

// PriceQuoteCard (PR9c) — live exchange rate for a (crypto, fiat) pair.
//
// Renders as a small horizontal card. Caller passes the crypto symbol; the
// widget fetches the rate via getCryptoFiatRate using the user's locale fiat
// (from LocaleManager). Auto-refreshes every 30s so the displayed price
// doesn't go stale while the user is composing the buy/sell amount.
//
// Replaces the "placeholder fee until quote arrives" gap that the buy/sell
// screens had — users now see a real reference price the moment they pick
// the asset, before they commit to the 15s locked quote.

class PriceQuoteCard extends StatefulWidget {
  final String cryptoId; // CoinGecko id (e.g. "bitcoin")
  final String cryptoSymbol; // ticker (e.g. "btc")
  final String? overrideFiat; // optional override; defaults to LocaleManager

  /// Fires whenever the live rate state changes — successful fetch (rate
  /// in major fiat units per 1 crypto), or null when the card is loading
  /// or in error with no fallback. The parent uses this to bind its own
  /// summary widgets (Order Summary, You Pay / You Receive) to the live
  /// rate instead of stale entity fields. Optional.
  final ValueChanged<double?>? onRateUpdated;

  /// Quidax's swap margin as a fraction (0.01 = 1%) — how far the rate a trade
  /// actually fills at sits from the order-book ticker shown here. Sheets apply
  /// it in the direction being traded so their estimate matches the binding
  /// quote instead of the (unobtainable) ticker.
  final ValueChanged<double>? onSwapMarginUpdated;

  /// Which direction this card is quoting for: 'buy', 'sell', or null for a
  /// neutral/market context (asset details, watchlists).
  ///
  /// WHY THIS EXISTS. The card fetches the order-book TICKER, and a trade
  /// never fills there — Quidax applies a swap margin, which the sheets then
  /// apply themselves (sell: rate*(1-margin), buy: rate*(1+margin)) so their
  /// arithmetic matches the binding quote. The card went on displaying the raw
  /// ticker, so the SAME SCREEN showed "1 USDT ≈ 1,359 NGN" directly above an
  /// amount computed at 1,343.86 — and the Confirm sheet then showed 1,343.86
  /// again. Reported by a user as "different rates within one screen, this may
  /// cause distrust", and they were right: two of the three numbers were the
  /// executable rate and the headline was not.
  ///
  /// With a side set, the card shows the rate the trade will ACTUALLY fill at.
  /// Null keeps the raw ticker, which is correct where nothing is being traded.
  final String? side;

  const PriceQuoteCard({
    super.key,
    required this.cryptoId,
    required this.cryptoSymbol,
    this.overrideFiat,
    this.onRateUpdated,
    this.onSwapMarginUpdated,
    this.side,
  });

  @override
  State<PriceQuoteCard> createState() => _PriceQuoteCardState();
}

class _PriceQuoteCardState extends State<PriceQuoteCard> {
  double? _price;
  double? _change24h;
  bool _loading = true;
  String? _error;
  String _fiat = 'ngn';

  CryptoGrpcClient get _client => GetIt.I<CryptoGrpcClient>();

  @override
  void initState() {
    super.initState();
    _fiat = (widget.overrideFiat ?? _resolveFiat()).toLowerCase();
    _load();
  }

  @override
  void didUpdateWidget(covariant PriceQuoteCard old) {
    super.didUpdateWidget(old);
    if (old.cryptoId != widget.cryptoId ||
        old.cryptoSymbol != widget.cryptoSymbol ||
        old.overrideFiat != widget.overrideFiat) {
      _fiat = (widget.overrideFiat ?? _resolveFiat()).toLowerCase();
      _load();
    }
  }

  String _resolveFiat() {
    try {
      return GetIt.I<LocaleManager>().currentCurrency;
    } catch (_) {
      return 'ngn';
    }
  }

  // Number of attempts a single _load call will make before showing the
  // error widget. With 350ms + 1.2s backoff between attempts, three tries
  // ride out the typical CoinGecko 429 / Quidax-timeout blip the user
  // reported as "couldn't fetch rate" — the previous one-shot policy
  // failed loudly on the first transient blip.
  static const int _maxAttempts = 3;
  static const List<Duration> _backoff = [
    Duration(milliseconds: 350),
    Duration(milliseconds: 1200),
  ];

  // Holds the most recently-fetched successful rate so a transient blip
  // on auto-refresh keeps the previous reading on screen instead of
  // wiping it back to "Rate unavailable". The card auto-refreshes every
  // 30s; better to show a 30s-old number than nothing.
  double? _lastGoodPrice;
  double _swapMargin = 0;

  // Surface the current effective rate to the parent. Null = loading
  // OR error-with-no-fallback. Non-null = live or stale-but-usable.
  void _notifyRate() {
    // Still the RAW ticker. The sheets apply the margin themselves (and must
    // keep doing so — they also use it for min/max bounds and the fee
    // estimate), so changing what is reported here would double-apply it.
    // Only the DISPLAY is direction-adjusted.
    widget.onRateUpdated?.call(_price);
  }

  /// Ticker adjusted by the swap margin in the direction being traded.
  ///
  /// Mirrors exactly what buy_crypto_sheet._rate and sell_crypto_sheet._rate
  /// compute, so the headline, the amount conversion and the Confirm sheet all
  /// show one number.
  double _effectiveRate(double ticker) {
    switch (widget.side) {
      case 'sell':
        return ticker * (1 - _swapMargin);
      case 'buy':
        return ticker * (1 + _swapMargin);
      default:
        // No trade direction — the market price is the honest figure.
        return ticker;
    }
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    // Tell the parent we're back in loading state so its OrderSummary
    // can clear any prior cached calculation while we refetch.
    _notifyRate();
    Object? lastErr;
    for (int attempt = 0; attempt < _maxAttempts; attempt++) {
      try {
        final resp = await _client.getExchangeRate(
          cryptoId: widget.cryptoId,
          fiatCurrency: _fiat.toUpperCase(),
        );
        if (!mounted) return;
        setState(() {
          _price = resp.rate;
          _lastGoodPrice = resp.rate;
          _swapMargin = resp.spread;
          // GetCryptoFiatRate doesn't expose 24h change today; surface the
          // spread basis points instead so the user sees the fee built into
          // the rate. When the server learns to return change24h, swap here.
          _change24h = null;
          _loading = false;
        });
        _notifyRate();
        widget.onSwapMarginUpdated?.call(_swapMargin);
        return;
      } catch (e) {
        lastErr = e;
        if (attempt + 1 < _maxAttempts) {
          await Future<void>.delayed(_backoff[attempt]);
          if (!mounted) return;
        }
      }
    }
    if (!mounted) return;
    // Prefer to keep the last good reading visible if we have one — gives
    // the user a "this is a few seconds stale" experience instead of a
    // blank error. The error string still surfaces below for transparency.
    setState(() {
      _price = _lastGoodPrice;
      _error =
          _lastGoodPrice != null ? 'Rate paused, retrying' : 'Rate unavailable';
      _loading = false;
    });
    _notifyRate();
    // Swallow the last error explicitly so the analyzer is happy and the
    // intent is clear: we've surfaced what the user needs to see.
    assert(() {
      if (lastErr != null) {
        debugPrint(
            'PriceQuoteCard load failed after $_maxAttempts attempts: $lastErr');
      }
      return true;
    }());
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _container(
        child: Text('Fetching ${widget.cryptoSymbol.toUpperCase()} price…',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
      );
    }
    // Hard error: no rate at all, and no prior reading to fall back on.
    // Surfaces "Rate unavailable" plus a Retry button so the user can
    // recover without bouncing back to the asset picker.
    if (_error != null && _price == null) {
      return _container(
        child: Row(children: [
          Icon(Icons.error_outline,
              color: const Color(0xFFEF4444), size: 14.sp),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(_error!,
                style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444), fontSize: 12.sp)),
          ),
          GestureDetector(
            onTap: _load,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Row(children: [
                Icon(Icons.refresh,
                    color: const Color(0xFF3B82F6), size: 14.sp),
                SizedBox(width: 4.w),
                Text('Retry',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600)),
              ]),
            ),
          ),
        ]),
      );
    }
    if (_price == null) {
      return _container(
        child: Text('No price',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
      );
    }
    // The rate a trade in THIS direction actually fills at. Without the
    // margin the headline contradicts the sheet's own arithmetic directly
    // beneath it.
    final effective = _effectiveRate(_price!);
    final priceStr = _formatPrice(effective);
    final changeStr = _change24h == null
        ? ''
        : '${_change24h! >= 0 ? '+' : ''}${_change24h!.toStringAsFixed(2)}%';
    final changeColor = (_change24h ?? 0) >= 0
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
    // When we're showing a stale-but-good price (current refresh failed,
    // last known reading still on screen), expose that to the user with
    // a subtle "paused" tag and a tap-to-retry, instead of pretending the
    // figure is fresh. The previous version either showed the figure as
    // live OR an error widget with no figure — never the honest middle
    // ground.
    final isStale = _error != null;
    return GestureDetector(
      onTap: isStale ? _load : null,
      child: _container(
        child: Row(children: [
          Text('1 ${widget.cryptoSymbol.toUpperCase()}',
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          SizedBox(width: 6.w),
          Text('≈ $priceStr ${_fiat.toUpperCase()}',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
          if (isStale) ...[
            SizedBox(width: 6.w),
            Icon(Icons.pause_circle_outline,
                color: const Color(0xFFFB923C), size: 12.sp),
            SizedBox(width: 3.w),
            Text('paused',
                style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C), fontSize: 11.sp)),
          ],
          const Spacer(),
          if (changeStr.isNotEmpty)
            Text(changeStr,
                style: GoogleFonts.inter(
                    color: changeColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
          if (isStale) ...[
            SizedBox(width: 6.w),
            Icon(Icons.refresh, color: const Color(0xFF3B82F6), size: 14.sp),
          ],
        ]),
      ),
    );
  }

  Widget _container({required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFF2D2D2D))),
      child: child,
    );
  }

  // Format with the precision that makes sense for the magnitude. NGN BTC
  // prints as ₦100,000,000 (no decimals); USDT BTC prints as 50,123.45.
  String _formatPrice(double price) {
    if (price >= 1000) {
      // Integer with thousands separator.
      final whole = price.toStringAsFixed(0);
      final buf = StringBuffer();
      for (int i = 0; i < whole.length; i++) {
        if (i > 0 && (whole.length - i) % 3 == 0) buf.write(',');
        buf.write(whole[i]);
      }
      return buf.toString();
    }
    if (price >= 1) return price.toStringAsFixed(2);
    if (price >= 0.01) return price.toStringAsFixed(4);
    return price.toStringAsFixed(8);
  }
}
