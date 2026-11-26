import 'dart:math' as math;

import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';

/// THE SMALLEST ORDER THE EXCHANGE WILL ACCEPT, IN FIAT.
///
/// ## Where the number comes from, and why it is not one number
///
/// A swap has TWO floors and the binding one is whichever is higher:
///
///   * the CRYPTO LEG — Quidax's `minimum_order_size` for the asset being
///     sold. This is the real constraint, and it is per-coin: 1 USDT and
///     0.001 ETH are different amounts of money.
///   * a flat FIAT NOTIONAL backstop (~$1 in the user's currency), for pairs
///     where the crypto leg has no published rule.
///
/// Both arrive in `GetCryptoConfig.min_order_minor_units`, which the server
/// builds as `max(our admin config, Quidax's live floor)` precisely so every
/// sheet can pre-check against the exchange's ACTUAL floor rather than a
/// configured guess. crypto-service's own comment on that map: the per-currency
/// map "is necessarily approximate where a currency trades against several
/// quotes", and the authoritative check is the saga's — which asks Quidax for
/// the exact pair.
///
/// ## Why Pay with Crypto uses this and not a floor of its own
///
/// A crypto-funded payment IS a sell. It was briefly gated on a single
/// admin-tuned naira figure (`feature_cryptopay_min_fiat_minor`), which was
/// wrong in the dangerous direction: that figure sat at ₦1,000 while Quidax
/// wanted ₦1,253, so a payment passed our gate and failed at theirs. A floor
/// the app invents is worse than no floor — it turns a clear server message
/// into a contradiction the customer cannot act on.
///
/// ## Null means NO APP-LAYER FLOOR
///
/// Matching every other caller of [CryptoRuntimeConfig.minOrderFor]: an
/// unhydrated config must not be read as "zero minimum" or as "refuse
/// everything". The server is the security boundary and will say so properly.
int? cryptoOrderFloorFiatMinor({
  required CryptoRuntimeConfig config,
  required String symbol,
  required String fiatCurrency,
  required double? unitPriceFiatMinor,
}) {
  var fromCryptoLeg = 0.0;
  final cryptoMinMinor = config.minOrderFor(symbol);
  if (cryptoMinMinor != null &&
      cryptoMinMinor > 0 &&
      unitPriceFiatMinor != null &&
      unitPriceFiatMinor > 0) {
    // minOrderFor(symbol) is in the CRYPTO's ledger minor units, so it scales
    // by that coin's decimals — never a flat /100. Getting this wrong
    // under-scales the floor by orders of magnitude for an 8-dp coin.
    final units = cryptoMinMinor / math.pow(10, config.decimalsFor(symbol));
    fromCryptoLeg = units * unitPriceFiatMinor;
  }

  // The fiat notional entry is already in FIAT minor units, so it is compared
  // directly — no rescaling.
  final fiatNotional = (config.minOrderFor(fiatCurrency) ?? 0).toDouble();

  final floor = math.max(fromCryptoLeg, fiatNotional);
  if (floor <= 0) return null;
  // CEIL, not round. Rounding down by a single kobo lets an order through
  // that the exchange then refuses, which is the whole failure being
  // prevented.
  return floor.ceil();
}
