/// The ONE definition of what a crypto trade costs and returns.
///
/// Every surface used to derive this for itself, and they disagreed. A live
/// sell of 51.55 USDT showed ₦70,344.79 on the amount sheet, ₦69,978.61 on the
/// confirm sheet, and credited ₦69,628.71 — three numbers for one trade, which
/// reads as hidden charges even though the fee was a single consistent 0.5%.
///
/// The rule is the same one the backend settles on, and it depends on which leg
/// is fiat:
///
///   * SELL (crypto → fiat): our fee is DEDUCTED from the proceeds, so the
///     amount that lands is `to_amount − fee`. This is the number the
///     settlement processor credits (`netUserMinor = grossMinor - spreadMinor`)
///     and the one the push notification already quotes.
///   * BUY (fiat → crypto): our fee is charged ON TOP, so the amount debited is
///     `from_amount + fee` and the crypto delivered is `to_amount` in full.
///
/// `spreadMinorUnits` is always denominated in the FIAT leg's minor units
/// (kobo for NGN) — that is what `fiatLegSpreadBasisMinor` guarantees
/// server-side, so it is safe to apply it to whichever side is fiat.
class CryptoTradeAmounts {
  const CryptoTradeAmounts({
    required this.pay,
    required this.receive,
    required this.feeInFiat,
    required this.feeCurrency,
    bool payLegIsFiat = true,
  }) : _payLegIsFiat = payLegIsFiat;

  /// What leaves the user, inclusive of our fee when the pay leg is fiat.
  final double pay;

  /// What reaches the user, net of our fee when the receive leg is fiat.
  final double receive;

  /// Our fee, always in the fiat leg's major units (e.g. naira).
  final double feeInFiat;

  /// The currency [feeInFiat] is denominated in.
  final String feeCurrency;

  /// Fiat currencies LazerVault settles in. This list MIRRORS the server's
  /// isLazerVaultFiat (crypto_swap_saga.go) and must stay in step with it: the
  /// server decides which leg the fee is charged on, and if the two disagree
  /// this class applies it to the wrong leg — or to neither, printing the gross
  /// again. An earlier draft of this list carried eur/gbp (which the server does
  /// not settle) and omitted ugx/tzs/xof (which it does).
  static const _fiat = {
    'ngn',
    'ghs',
    'kes',
    'ugx',
    'tzs',
    'zar',
    'xof',
    'usd',
  };

  static bool isFiat(String currency) => _fiat.contains(currency.toLowerCase());

  /// Fiat minor units are hundredths (kobo, cents) across every currency we
  /// settle in, which is the same assumption the server's minor-unit scale
  /// makes for the fiat leg.
  static const _fiatMinorPerMajor = 100.0;

  factory CryptoTradeAmounts.fromQuote({
    required String fromCurrency,
    required String toCurrency,
    required String fromAmount,
    required String toAmount,
    required int spreadMinorUnits,
  }) {
    final from = double.tryParse(fromAmount) ?? 0.0;
    final to = double.tryParse(toAmount) ?? 0.0;
    final fee = spreadMinorUnits / _fiatMinorPerMajor;

    if (isFiat(toCurrency)) {
      // Sell: the fee comes out of the proceeds. Never let it read negative —
      // a malformed quote should show zero, not a number that implies we took
      // more than the trade was worth.
      final net = to - fee;
      return CryptoTradeAmounts(
        pay: from,
        receive: net > 0 ? net : 0,
        feeInFiat: fee,
        feeCurrency: toCurrency,
        payLegIsFiat: false,
      );
    }
    if (isFiat(fromCurrency)) {
      // Buy: the fee is added to what we debit; the crypto is delivered whole.
      return CryptoTradeAmounts(
        pay: from + fee,
        receive: to,
        feeInFiat: fee,
        feeCurrency: fromCurrency,
        payLegIsFiat: true,
      );
    }
    // Crypto → crypto has no fiat leg, so there is no fiat-denominated fee to
    // apply to either side.
    return CryptoTradeAmounts(
      pay: from,
      receive: to,
      feeInFiat: 0,
      feeCurrency: '',
    );
  }

  /// The ALL-IN unit rate: what one unit of the asset costs or yields once our
  /// fee is included.
  ///
  /// This is the figure a headline rate must show. The buy sheet used to print
  /// the pre-fee rate at the top and a fee-inclusive total at the bottom —
  /// "1 USDT ≈ ₦1,376" above "You pay ₦4,138.71" for 3 USDT, which works out
  /// at ₦1,379.57 each. Two rates on one screen, neither wrong on its own, and
  /// no way for the user to reconcile them.
  ///
  /// Derived from the TOTAL rather than by scaling the rate, so it stays exact
  /// under every fee shape the admin console can configure — percentage,
  /// percentage-with-cap, floor, or a flat fee. Scaling would only be right
  /// for an uncapped percentage.
  double allInRateFor(double quantity) {
    if (quantity <= 0) return 0;
    // For a buy the fiat leg is what the user PAYS; for a sell it is what they
    // RECEIVE. Either way the all-in rate is the fiat side over the asset
    // side, which is exactly what the receipt will later print.
    final fiatSide = _payLegIsFiat ? pay : receive;
    if (fiatSide <= 0) return 0;
    return fiatSide / quantity;
  }

  /// Set by the factories: which leg carried the fiat.
  final bool _payLegIsFiat;

  /// A PRE-QUOTE estimate, built from the executable rate and the admin fee
  /// rules — the same shape [CryptoTradeAmounts.fromQuote] returns once the
  /// server has locked a price.
  ///
  /// Exists so the amount sheet, the headline rate and the affordability check
  /// stop each deriving their own. They disagreed in both directions: the rate
  /// chip applied the swap margin while the totals did not, and the totals
  /// added our fee while the rate chip did not.
  ///
  /// [executableRate] is fiat per 1 unit of the asset, AS A TRADE IN THIS
  /// DIRECTION WILL FILL — not the market mid. GetCryptoFiatRate returns the
  /// mid and the measured spread such that `mid * (1 ± spread)` reproduces
  /// each side's fill rate exactly; apply that before calling this.
  ///
  /// [feeForFiatAmount] resolves the platform fee for a fiat subtotal, honouring
  /// the admin's percentage / cap / floor / fixed configuration. Passed in
  /// rather than read here so this stays a pure function.
  factory CryptoTradeAmounts.estimate({
    required bool isBuy,
    required String fiatCurrency,
    required double executableRate,
    required double assetQuantity,
    required double Function(double fiatSubtotal) feeForFiatAmount,
  }) {
    if (executableRate <= 0 || assetQuantity <= 0) {
      return CryptoTradeAmounts(
        pay: 0,
        receive: 0,
        feeInFiat: 0,
        feeCurrency: fiatCurrency,
        payLegIsFiat: isBuy,
      );
    }
    final subtotal = assetQuantity * executableRate;
    final fee = feeForFiatAmount(subtotal);
    if (isBuy) {
      // Charged ON TOP, matching swap_saga_confirm's hold of
      // from_amount_minor + FeeMinorForOp(...).
      return CryptoTradeAmounts(
        pay: subtotal + fee,
        receive: assetQuantity,
        feeInFiat: fee,
        feeCurrency: fiatCurrency,
        payLegIsFiat: true,
      );
    }
    // Sell: deducted from the proceeds, matching the settlement processor's
    // netUserMinor = grossMinor - spreadMinor.
    final net = subtotal - fee;
    return CryptoTradeAmounts(
      pay: assetQuantity,
      receive: net > 0 ? net : 0,
      feeInFiat: fee,
      feeCurrency: fiatCurrency,
      payLegIsFiat: false,
    );
  }
}
