/// WHAT SELLING THIS COIN WOULD DO, WORKED OUT BEFORE THE PIN.
///
/// The customer picked a coin and typed an amount. What they have NOT been
/// told is the thing they most need to see: roughly what rate it converts at,
/// how much of the coin that costs, and whether any naira will be taken to
/// finish the job. Selling crypto is irreversible, so learning any of that
/// afterwards is learning it too late.
///
/// ## Indicative, and the copy must say so
///
/// Every figure here is derived from a price snapshot. The binding rate comes
/// from the exchange when the conversion actually runs, and it will differ —
/// in both directions. That is normal for this product and every venue states
/// it the same way; what matters is that we state it too, beside the numbers
/// rather than in a footnote nobody reads.
library;

/// The split and the rate, as far as a client can know them.
class CryptoQuotePreview {
  const CryptoQuotePreview({
    required this.asset,
    required this.amountMinor,
    required this.fromCryptoMinor,
    required this.fromWalletMinor,
    required this.coinValueMinor,
    this.unitPriceMinor,
    this.sellQuantity,
    this.stale = false,
  });

  /// Lowercase symbol being sold.
  final String asset;

  /// What the payment costs in total, in kobo.
  final int amountMinor;

  /// What the coin would contribute. Capped at the payment: a coin worth more
  /// than the payment sells only what is needed, and the rest stays a holding.
  final int fromCryptoMinor;

  /// What the wallet tops up. Zero when the coin covers it all.
  final int fromWalletMinor;

  /// What the WHOLE holding is worth, which is what the picker showed.
  final int coinValueMinor;

  /// Kobo per one unit of the coin, or null when it could not be derived.
  ///
  /// Null rather than zero: a rate of zero is a claim, and "we could not
  /// price this" is not the same claim.
  final double? unitPriceMinor;

  /// Roughly how much coin would be sold, already formatted.
  ///
  /// A STRING, formatted once here, because the sensible number of decimals
  /// depends on the rate — eight for a coin worth millions a unit, two for a
  /// stablecoin — and every surface showing this must make the same choice.
  final String? sellQuantity;

  /// True when the live price could not be refreshed and this rests on the
  /// snapshot the picker loaded with. The copy says so; it does not silently
  /// present an old number as a current one.
  final bool stale;

  /// Whether the wallet has to finish the job.
  bool get isSplit => fromWalletMinor > 0;

  /// VALUE EQUALITY, because [PaySource] holds one of these and compares
  /// itself. Without it two identical previews are different objects, so a
  /// `setState` that rebuilt the source would always look like a change and
  /// every screen holding one would repaint on each pricing pass.
  @override
  bool operator ==(Object other) =>
      other is CryptoQuotePreview &&
      other.asset == asset &&
      other.amountMinor == amountMinor &&
      other.fromCryptoMinor == fromCryptoMinor &&
      other.fromWalletMinor == fromWalletMinor &&
      other.coinValueMinor == coinValueMinor &&
      other.unitPriceMinor == unitPriceMinor &&
      other.sellQuantity == sellQuantity &&
      other.stale == stale;

  @override
  int get hashCode => Object.hash(asset, amountMinor, fromCryptoMinor,
      fromWalletMinor, coinValueMinor, unitPriceMinor, sellQuantity, stale);

  /// The ticker as a customer reads it.
  String get label => asset.toUpperCase();

  /// Build a preview from a holding and a payment amount.
  ///
  /// [coinValueMinor] is what the holding is worth; [balance] is how much of
  /// the coin that is, as the exchange spells it. Either may be missing, and
  /// the result degrades rather than guesses: no balance means no rate and no
  /// sell quantity, but the split is still knowable and still worth showing.
  static CryptoQuotePreview build({
    required String asset,
    required int amountMinor,
    required int coinValueMinor,
    String? balance,
    bool stale = false,
  }) {
    // A coin worth more than the payment sells only what the payment needs.
    final fromCrypto =
        coinValueMinor >= amountMinor ? amountMinor : coinValueMinor;
    final fromWallet = amountMinor - fromCrypto;

    double? unit;
    String? qty;
    final held = double.tryParse((balance ?? '').trim());
    if (held != null && held > 0 && coinValueMinor > 0) {
      unit = coinValueMinor / held;
      if (unit > 0) {
        qty = _formatQuantity(fromCrypto / unit, unit);
      }
    }

    return CryptoQuotePreview(
      asset: asset,
      amountMinor: amountMinor,
      fromCryptoMinor: fromCrypto,
      fromWalletMinor: fromWallet < 0 ? 0 : fromWallet,
      coinValueMinor: coinValueMinor,
      unitPriceMinor: unit,
      sellQuantity: qty,
      stale: stale,
    );
  }

  /// Decimals chosen by what the coin is WORTH, not by a fixed constant.
  ///
  /// 0.00004 BTC and 12.50 USDT are both the right answer for their coin, and
  /// one rule cannot be both — two decimals makes a BTC quantity read as
  /// zero, and eight makes a stablecoin read as a serial number.
  static String _formatQuantity(double qty, double unitPriceMinor) {
    if (!qty.isFinite || qty <= 0) return '0';
    // unitPriceMinor is KOBO per unit; a million kobo is ₦10,000 a coin.
    final decimals = unitPriceMinor >= 100000000 // ≥ ₦1,000,000/unit
        ? 8
        : unitPriceMinor >= 1000000 // ≥ ₦10,000/unit
            ? 6
            : unitPriceMinor >= 10000 // ≥ ₦100/unit
                ? 4
                : 2;
    var s = qty.toStringAsFixed(decimals);
    // Trailing zeros carry no information and make a short number look long.
    if (s.contains('.')) {
      s = s.replaceFirst(RegExp(r'0+$'), '');
      s = s.replaceFirst(RegExp(r'\.$'), '');
    }
    return s;
  }
}
