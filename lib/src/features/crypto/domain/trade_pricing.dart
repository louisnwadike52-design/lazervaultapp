import 'package:get_it/get_it.dart';

import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';
import 'package:lazervault/src/features/crypto/domain/trade_amounts.dart';

/// ONE definition of what a crypto trade costs.
///
/// WHY THIS EXISTS. The buy sheet, the buy screen, the sell sheet and the sell
/// screen each carried their own copy of the same six lines: hold a `_liveRate`
/// and a `_swapMargin` from [PriceQuoteCard], turn them into an executable rate,
/// resolve the platform fee, and feed both into [CryptoTradeAmounts.estimate].
/// Four copies of one rule.
///
/// That is not hypothetical duplication. `buy_crypto_screen.dart` still carries
/// the note: *"This used to return the mid unadjusted, so the screen priced a
/// buy at a rate no buy can get — understating the cost by the whole margin
/// (1.4% on USDC, measured). The sheet applied the margin; this screen,
/// reachable from the same Buy action, did not."* Same trade, two entry points,
/// two prices — and the only thing that had gone wrong was one copy drifting
/// from the other three.
///
/// So the derivation lives here once. A new entry point into buy or sell gets
/// the right price by construction instead of by someone remembering to copy
/// six lines correctly.
///
/// WHAT IT DELIBERATELY DOES NOT DO: fetch anything. The live rate and the swap
/// margin still arrive from [PriceQuoteCard]'s callbacks, which is the single
/// place that talks to the rate API. Adding a fetch here would create the
/// second API call this type exists to prevent.
class CryptoTradePricing {
  const CryptoTradePricing({
    required this.isBuy,
    required this.fiatCurrency,
    this.liveRate,
    this.swapMargin = 0,
  });

  /// Buy lifts the offer, sell hits the bid. The only asymmetry in here.
  final bool isBuy;
  final String fiatCurrency;

  /// The mid/ticker rate from [PriceQuoteCard]. Null until one arrives.
  final double? liveRate;

  /// Half-spread from the same card. Zero degrades to the unadjusted rate,
  /// which is the behaviour that predates the margin being measured at all.
  final double swapMargin;

  /// The rate a trade actually FILLS at.
  ///
  /// A buy pays above the ticker and a sell receives below it, because the swap
  /// quote is two-sided. Returning the mid for either would price a trade at a
  /// rate no trade can get.
  double? get executableRate {
    final r = liveRate;
    if (r == null || r <= 0) return null;
    return isBuy ? r * (1 + swapMargin) : r * (1 - swapMargin);
  }

  /// True once a live rate exists. Gates a CTA so a trade can never be composed
  /// against a price we do not currently have.
  bool get hasLiveRate => (liveRate ?? 0) > 0;

  /// The platform fee for an arbitrary fiat amount, honouring the admin's
  /// percentage / floor / cap / fixed configuration.
  ///
  /// Passed to [CryptoTradeAmounts.estimate] as a FUNCTION rather than a single
  /// computed number, because a floor or a cap applies at the amount being
  /// priced — not at whatever happens to be typed. Pricing a Max button or a
  /// hypothetical subtotal has to run the same rules at that amount.
  ///
  /// Falls back to the flat display rate before the config RPC lands, so an
  /// estimate shown on a cold start is approximately right rather than zero.
  double feeForFiat(double fiatAmount) {
    final op = isBuy ? 'buy' : 'sell';
    try {
      return GetIt.I<CryptoConfigCubit>()
          .config
          .feeForOp(op, fiatAmount, fiatCurrency);
    } catch (_) {
      final bps = CryptoRuntimeConfig.defaults().feeDisplayFallbackBps;
      return fiatAmount * (bps / 10000.0);
    }
  }

  /// THE trade, priced once: subtotal, our fee, the total, and the all-in unit
  /// rate the headline must show.
  ///
  /// Every figure on a buy or sell screen must come from here. Deriving them
  /// separately is what previously put "1 USDT ≈ ₦1,376" directly above "You
  /// pay ₦4,138.71" for 3 USDT (₦1,379.57 each) — the headline had the margin
  /// but not the fee.
  CryptoTradeAmounts amounts({required double assetQuantity}) =>
      CryptoTradeAmounts.estimate(
        isBuy: isBuy,
        fiatCurrency: fiatCurrency,
        executableRate: executableRate ?? 0,
        assetQuantity: assetQuantity,
        feeForFiatAmount: feeForFiat,
      );

  /// Fiat for a crypto quantity at the executable rate, or 0 with no rate.
  double fiatFor(double assetQuantity) {
    final r = executableRate ?? 0;
    return r > 0 ? assetQuantity * r : 0.0;
  }

  /// Crypto for a fiat amount at the executable rate, or 0 with no rate.
  double cryptoFor(double fiatAmount) {
    final r = executableRate ?? 0;
    return r > 0 ? fiatAmount / r : 0.0;
  }

  CryptoTradePricing copyWith({double? liveRate, double? swapMargin}) =>
      CryptoTradePricing(
        isBuy: isBuy,
        fiatCurrency: fiatCurrency,
        liveRate: liveRate ?? this.liveRate,
        swapMargin: swapMargin ?? this.swapMargin,
      );
}
