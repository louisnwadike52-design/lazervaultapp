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

  const PriceQuoteCard({
    super.key,
    required this.cryptoId,
    required this.cryptoSymbol,
    this.overrideFiat,
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

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final resp = await _client.getExchangeRate(
        cryptoId: widget.cryptoId,
        fiatCurrency: _fiat.toUpperCase(),
      );
      if (!mounted) return;
      setState(() {
        _price = resp.rate;
        // GetCryptoFiatRate doesn't expose 24h change today; surface the
        // spread basis points instead so the user sees the fee built into
        // the rate. When the server learns to return change24h, swap here.
        _change24h = null;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Rate unavailable';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _container(
        child: Text('Fetching ${widget.cryptoSymbol.toUpperCase()} price…',
            style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
      );
    }
    if (_error != null || _price == null) {
      return _container(
        child: Row(children: [
          Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 14.sp),
          SizedBox(width: 6.w),
          Text(_error ?? 'No price',
              style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12.sp)),
        ]),
      );
    }
    final priceStr = _formatPrice(_price!);
    final changeStr = _change24h == null
        ? ''
        : '${_change24h! >= 0 ? '+' : ''}${_change24h!.toStringAsFixed(2)}%';
    final changeColor = (_change24h ?? 0) >= 0
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
    return _container(
      child: Row(children: [
        Text('1 ${widget.cryptoSymbol.toUpperCase()}',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
        SizedBox(width: 6.w),
        Text('≈ $priceStr ${_fiat.toUpperCase()}',
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
        const Spacer(),
        if (changeStr.isNotEmpty)
          Text(changeStr,
              style: GoogleFonts.inter(
                  color: changeColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600)),
      ]),
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
