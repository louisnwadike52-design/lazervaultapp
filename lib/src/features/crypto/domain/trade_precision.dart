/// How many decimal places the EXCHANGE will accept in an order amount.
///
/// This is NOT the ledger scale. Two different precisions exist and conflating
/// them moves money wrongly:
///
///   * LEDGER minor units — `CryptoRuntimeConfig.decimalsFor` (USDT=6, NGN=2,
///     coins=8). Used to build `from_amount_minor_units`. Comes from the
///     server's GetCryptoConfig.
///   * ORDER precision — THIS table (USDT=2, NGN=0, BTC=5). The most decimals
///     Quidax accepts in an order. Anything finer is TRUNCATED toward zero by
///     the backend's FormatAmountForCurrency before the order is placed.
///
/// WHY THE APP NEEDS IT. Without it the sell sheet previewed an amount that
/// could not execute: a user holding 29.019800 USDT tapped Max, saw "You sell
/// 29.019794 USDT · You receive ₦38,901.04", and the Confirm sheet then said
/// 29.01 USDT / ₦38,887.92 — ₦13.16 less, because the backend truncated the
/// quantity to 2dp on the way to the exchange. The money was never lost; the
/// preview simply promised a trade the exchange would not take.
///
/// MIRRORS `quidax.CurrencyDecimals` in
/// microservices/crypto-service/internal/quidax/precision.go. It is not served
/// by GetCryptoConfig — that RPC's `currency_decimals` carries the LEDGER
/// scale (its proto comment claiming otherwise is wrong and has been
/// corrected). A Go test pins these values so the two cannot drift silently.
library;

const Map<String, int> _orderDecimals = {
  // Fiat — whole units only
  'ngn': 0, 'ghs': 0,
  // USD stables
  'usdt': 2, 'usdc': 2, 'busd': 2, 'usd': 2, 'cnhc': 2, 'cngn': 2, 'axcnh': 2,
  // Majors
  'btc': 5, 'eth': 4,
  'bnb': 3, 'ltc': 3, 'aave': 3, 'bch': 3, 'dash': 3,
  'sol': 2, 'link': 2, 'axs': 2, 'cake': 2, 'dot': 2, 'fil': 2, 'ape': 2,
  'ada': 1, 'matic': 1, 'pol': 1, 'xtz': 1,
  'trx': 4, 'xrp': 4, 'xlm': 4, 'doge': 4, 'mana': 4, 'ftm': 4, 'sand': 4,
  'cfx': 4, 'one': 4,
  // Meme coins priced in whole units
  'shib': 0, 'wkd': 0, 'babydoge': 0, 'floki': 0,
  'qdx': 6,
};

/// Decimals the exchange accepts for `currency`. Unknown → 8, matching the
/// backend's conservative default.
int orderDecimalsFor(String currency) =>
    _orderDecimals[currency.trim().toLowerCase()] ?? 8;

/// Floor `amount` to what the exchange will actually accept.
///
/// FLOOR, never round. Rounding up sends more than the user holds or
/// authorised — the backend learned this the hard way (a max-sell of 12.34567
/// TRX rounded to 12.3457 and the exchange rejected it as insufficient; a
/// 10.76 ADA send rounded to 10.8 and over-sent, irreversibly). Flooring can
/// only ever leave a little dust behind, which is recoverable.
double floorToOrderPrecision(double amount, String currency) {
  if (!amount.isFinite || amount <= 0) return 0;
  final d = orderDecimalsFor(currency);
  // Integer maths on the scaled value: pow() on a double reintroduces the
  // binary-float error this exists to avoid.
  var pow = 1.0;
  for (var i = 0; i < d; i++) {
    pow *= 10;
  }
  // A hair of tolerance before flooring, so a value that is exactly on a
  // boundary but stored as 29.009999999 does not drop a whole unit.
  return (amount * pow + 1e-9).floorToDouble() / pow;
}
