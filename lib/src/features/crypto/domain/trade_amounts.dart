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
  });

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
      );
    }
    if (isFiat(fromCurrency)) {
      // Buy: the fee is added to what we debit; the crypto is delivered whole.
      return CryptoTradeAmounts(
        pay: from + fee,
        receive: to,
        feeInFiat: fee,
        feeCurrency: fromCurrency,
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
}
