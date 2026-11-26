import 'package:flutter/foundation.dart';

import 'crypto_quote_preview.dart';

/// How a payment is being funded.
///
/// Deliberately a TYPE rather than a bool. Every money screen already carries
/// several booleans, and `payWithCrypto: false` reads identically to a flag
/// nobody set — which is exactly the shape of bug that spends the wrong
/// balance. A `PaySource` has to be constructed on purpose and carries the
/// chosen asset with it, so the PIN sheet, the request and the receipt all
/// receive one object that cannot disagree with itself.
@immutable
class PaySource {
  const PaySource.fiat()
      : asset = null,
        assetBalance = null,
        assetFiatValueMinor = null,
        quote = null;

  const PaySource.crypto(
    String this.asset, {
    this.assetBalance,
    this.assetFiatValueMinor,
    this.quote,
  });

  /// The lowercase symbol being sold, or null when paying from the wallet.
  final String? asset;

  /// What the customer holds of [asset], for display only. Never used for a
  /// decision — the server re-reads the real balance at quote time, because
  /// anything the client holds is already stale.
  final String? assetBalance;

  /// What that holding is worth in KOBO, as the picker showed it.
  ///
  /// INDICATIVE, AND ONLY EVER USED TO WARN. It is a ticker snapshot taken
  /// when the list was loaded; the binding number comes from the exchange at
  /// quote time and the server re-reads the balance regardless. Its whole job
  /// is to let the amount screen say "this coin covers about half of that"
  /// BEFORE the customer commits, instead of letting them find out from a
  /// refusal after the fact.
  ///
  /// Null means the coin could not be priced — an asset with no market, or a
  /// provider that was down. Callers must treat null as "unknown" and let the
  /// payment proceed, never as "worth nothing": the server makes the real
  /// decision and refusing here would decline a payment that would have
  /// worked.
  final int? assetFiatValueMinor;

  /// THE SPLIT, AS THE CUSTOMER WAS SHOWN IT, carried with the choice.
  ///
  /// This used to be built inside `confirmCryptoPayment`, shown on the
  /// conversion sheet, and then THROWN AWAY — only the asset survived. So
  /// everything after the conversion sheet knew which coin had been picked
  /// and nothing else: the PIN sheet could not say how much coin was being
  /// sold, the failure copy could not name it, and the receipt had no split
  /// to print.
  ///
  /// It belongs HERE for the reason this class exists at all, stated at the
  /// top: the PIN sheet, the request and the receipt should receive ONE
  /// object that cannot disagree with itself. A preview passed alongside is
  /// a second thing to thread through seven call sites and forget at one.
  ///
  /// NULL IS NORMAL AND MUST BE HANDLED. A coin that could not be priced
  /// yields no preview, and the payment still proceeds — the server prices it
  /// properly at quote time. Every reader treats null as "we cannot show the
  /// split", never as "there is no crypto".
  final CryptoQuotePreview? quote;

  bool get isCrypto => asset != null;

  /// What the wallet must top up, in kobo, or null when unknown.
  ///
  /// Drives the "and the rest from your wallet" line. Null and zero are
  /// different: zero means the coin covers it all, null means we could not
  /// price the coin and cannot say.
  int? get walletTopUpMinor => quote?.fromWalletMinor;

  /// Whether this payment needs BOTH the coin and the wallet.
  bool get isSplitFunded => (quote?.fromWalletMinor ?? 0) > 0;

  /// Roughly how much coin would be sold, already formatted, or null.
  String? get sellQuantity => quote?.sellQuantity;

  /// FIAT IS THE DEFAULT EVERYWHERE. Exposed as a const so a screen that
  /// simply never sets a source still behaves correctly, rather than relying
  /// on a nullable field that reads the same as "nobody chose".
  static const PaySource wallet = PaySource.fiat();

  /// The word shown to the customer. Uppercased symbol, because a coin is a
  /// ticker and "usdt" reads like a typo.
  String get label => asset == null ? 'Wallet' : asset!.toUpperCase();

  @override
  bool operator ==(Object other) =>
      other is PaySource &&
      other.asset == asset &&
      other.assetBalance == assetBalance &&
      other.assetFiatValueMinor == assetFiatValueMinor &&
      other.quote == quote;

  @override
  int get hashCode =>
      Object.hash(asset, assetBalance, assetFiatValueMinor, quote);

  @override
  String toString() => isCrypto ? 'PaySource.crypto($asset)' : 'PaySource.fiat';
}
