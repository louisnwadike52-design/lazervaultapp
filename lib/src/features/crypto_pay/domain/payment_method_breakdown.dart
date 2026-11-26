/// HOW A PAYMENT WAS ACTUALLY FUNDED, read back off the record.
///
/// A crypto-funded payment is paid from TWO places: the coin that was sold
/// and the wallet that covered the rest. The receipt is where a customer
/// checks that later, and one that says only "₦5,000 sent" cannot answer the
/// question they will actually have — *which* of my balances did that come
/// out of, and how much coin did it cost me?
///
/// core-payments writes the split onto the payment when the conversion's
/// outcome meets it (`mergeFundingBreakdown`), which is the one moment both
/// halves are in the same place. This reads it back.
///
/// ## Every field is optional, and that is deliberate
///
/// An ordinary wallet payment carries none of this, an older payment predates
/// it, and a conversion whose swap could not be read has the naira but not the
/// quantity. [PaymentMethodBreakdown.from] returns null for the first two and
/// a breakdown with a null [assetAmount] for the third — so a caller renders
/// what is known and never invents the rest.
library;

import 'dart:convert';

class PaymentMethodBreakdown {
  const PaymentMethodBreakdown({
    required this.cryptoMinor,
    required this.fiatMinor,
    required this.totalMinor,
    this.asset,
    this.assetAmount,
  });

  /// What the sold coin contributed, in kobo.
  final int cryptoMinor;

  /// What the wallet contributed, in kobo. Zero when the coin covered it all.
  final int fiatMinor;

  /// The two legs together — recorded rather than derived so a receipt can be
  /// checked against the charge without trusting the arithmetic here.
  final int totalMinor;

  /// The coin symbol, lowercase as stored.
  final String? asset;

  /// How much coin was sold, as a decimal string exactly as the exchange
  /// reported it.
  ///
  /// A STRING, not a number: crypto quantities carry up to eighteen places and
  /// parsing one into a double loses the tail. Null when the swap could not be
  /// read — omitted rather than shown as zero, which would be a claim that no
  /// coin was sold.
  final String? assetAmount;

  /// Whether both sources actually contributed.
  ///
  /// The renderer hides a zero second row — "Crypto ₦5,000" alone is the
  /// truth when the wallet paid nothing, and a "₦0.00" line invites the
  /// question of what it means.
  bool get isSplit => cryptoMinor > 0 && fiatMinor > 0;

  /// The coin's ticker as a customer reads it. "usdt" looks like a typo.
  String get assetLabel => (asset ?? '').toUpperCase();

  /// Reads a breakdown out of a transaction's metadata, or null when this was
  /// not a crypto-funded payment.
  ///
  /// REFUSES TO GUESS. Without the crypto leg there is no split to describe,
  /// so an ordinary payment — and any payment written before this was
  /// recorded — simply has no breakdown rather than a fabricated one.
  static PaymentMethodBreakdown? from(Map<String, dynamic>? metadata) {
    if (metadata == null || metadata.isEmpty) return null;
    if ((metadata['funding_source'] ?? '').toString() != 'crypto') return null;

    final crypto = _minor(metadata['funding_crypto_minor']);
    final fiat = _minor(metadata['funding_fiat_minor']);
    if (crypto == null && fiat == null) {
      // Marked as crypto-funded but with no figures — an older payment, or
      // one whose conversion never settled. There is nothing to show.
      return null;
    }

    final c = crypto ?? 0;
    final f = fiat ?? 0;
    // Prefer the recorded total; fall back to the sum so a partially written
    // record still renders something consistent with itself.
    final total = _minor(metadata['funding_total_minor']) ?? (c + f);

    final amount = metadata['funding_asset_amount']?.toString().trim();
    return PaymentMethodBreakdown(
      cryptoMinor: c,
      fiatMinor: f,
      totalMinor: total,
      asset: (metadata['funding_asset']?.toString().trim().isNotEmpty ?? false)
          ? metadata['funding_asset'].toString().trim()
          : null,
      assetAmount: (amount != null && amount.isNotEmpty) ? amount : null,
    );
  }

  /// Minor units from whatever JSON gave us.
  ///
  /// The wire can hand these back as int, double or string depending on which
  /// decoder touched them, and a receipt that silently shows nothing because
  /// a number arrived as a string is the kind of fault nobody reports.
  static int? _minor(Object? v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is double) return v.round();
    return int.tryParse(v.toString().trim());
  }
}

/// The rows a receipt should print, in order, with zero legs omitted.
///
/// Shared by the receipt screen and the share PDF so the document a customer
/// sends on says exactly what the screen said. Two renderers would eventually
/// disagree, and the PDF is the copy that gets forwarded to other people.
List<({String label, String value, String? note})> breakdownRows(
  PaymentMethodBreakdown b,
  String Function(int minor) money,
) {
  final rows = <({String label, String value, String? note})>[];
  final coin = b.assetLabel.isEmpty ? 'Crypto' : b.assetLabel;

  if (b.cryptoMinor > 0) {
    rows.add((
      // PRIMARY is whichever actually led. With crypto selected the coin is
      // spent first, so it is the primary method and the wallet is what
      // finished the job.
      label: b.isSplit ? 'Primary payment method' : 'Payment method',
      value: '$coin — ${money(b.cryptoMinor)}',
      // The quantity belongs with the leg it describes, not in a footnote.
      note: b.assetAmount == null ? null : '${b.assetAmount} $coin sold',
    ));
  }
  if (b.fiatMinor > 0) {
    rows.add((
      label: b.cryptoMinor > 0 ? 'Secondary payment method' : 'Payment method',
      value: 'Wallet — ${money(b.fiatMinor)}',
      note: null,
    ));
  }
  return rows;
}

/// The breakdown as label/value pairs, with the quantity folded into the value.
///
/// ONE FLATTENING RULE, IN ONE PLACE. The receipt screen renders label/value
/// rows and the share PDF takes `List<MapEntry<String, String>>`; if each
/// decided for itself how to present the coin quantity, the document a
/// customer forwards would eventually stop matching the screen they read it
/// on. The PDF is the copy other people see, so that divergence is the one
/// that matters.
List<MapEntry<String, String>> breakdownEntries(
  PaymentMethodBreakdown b,
  String Function(int minor) money,
) =>
    breakdownRows(b, money)
        .map((r) => MapEntry(
              r.label,
              // A middle dot rather than a second line: both surfaces render a
              // single value string, and a newline inside a PDF table cell is
              // what turns one row into a clipped one.
              r.note == null ? r.value : '${r.value}  ·  ${r.note}',
            ))
        .toList();

/// The compact one-liner a transaction LIST row can carry.
///
/// A history row has space for a few words, not two rows of a table — but
/// "paid with crypto" is exactly the thing that makes a row recognisable when
/// a customer is scrolling to find it. Returns null when there is nothing to
/// say, so a caller renders no badge at all rather than an empty one.
String? breakdownBadge(PaymentMethodBreakdown? b) {
  if (b == null) return null;
  final coin = b.assetLabel.isEmpty ? 'Crypto' : b.assetLabel;
  if (b.isSplit) return 'Paid with $coin + wallet';
  if (b.cryptoMinor > 0) return 'Paid with $coin';
  // Marked crypto-funded but the coin contributed nothing — the conversion
  // delivered nothing and the wallet paid for all of it. Saying "paid with
  // crypto" there would be false, and a badge is not the place to explain it.
  return null;
}

/// Decode whatever shape a bill entity keeps its metadata in.
///
/// THE SHAPES GENUINELY DIFFER AND ALL OF THEM ARE CORRECT. Data bundles
/// expose a decoded `metadataMap`; water keeps `metadata` as the raw JSON
/// string the backend sent; cable TV and internet hand back a map already.
/// Teaching each receipt to decode its own is twelve chances to forget a
/// try/catch, and a receipt that throws on malformed metadata loses the whole
/// document over a row that is merely decorative.
///
/// Returns null for anything unusable — never throws.
Map<String, dynamic>? decodeFundingMetadata(Object? raw) {
  if (raw == null) return null;
  if (raw is Map<String, dynamic>) return raw;
  if (raw is Map) return Map<String, dynamic>.from(raw);
  if (raw is String) {
    final t = raw.trim();
    if (t.isEmpty) return null;
    try {
      final decoded = jsonDecode(t);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {
      // Malformed metadata is not worth a crashed receipt.
    }
  }
  return null;
}

/// The funding rows for a NAIRA receipt, read straight off a payment's
/// metadata in whatever shape that entity keeps it.
///
/// WHY THIS EXISTS RATHER THAN A LAMBDA AT EACH CALL SITE. Every bill receipt
/// in the app — airtime, data, electricity, cable TV, internet, water — needs
/// exactly these rows, on both the SCREEN and the PDF it shares. Twelve copies
/// of `(minor) => '₦${(minor / 100).toStringAsFixed(2)}'` is twelve
/// chances for one of them to format differently from the rest, and the one
/// that drifts is whichever nobody opened recently.
///
/// Returns an empty list for an ordinary wallet payment, so a caller can
/// splat it unconditionally rather than guarding each site.
List<MapEntry<String, String>> nairaFundingRows(Object? metadata) {
  final b = PaymentMethodBreakdown.from(decodeFundingMetadata(metadata));
  if (b == null) return const [];
  return breakdownEntries(b, (minor) => '₦${(minor / 100).toStringAsFixed(2)}');
}

/// [nairaFundingRows] for a PDF, in ASCII only.
///
/// THE NAIRA SIGN CRASHES THE DOCUMENT. The embedded font is fetched over HTTP
/// and silently falls back to base-14 Helvetica when that fails; the fallback
/// latin1-encodes every string and THROWS on any code unit above 255. So a
/// receipt generated offline would crash on the one character this row is most
/// likely to contain. The bill PDFs already strip to printable ASCII for
/// exactly this reason — these rows must arrive already safe rather than rely
/// on each of them remembering.
List<MapEntry<String, String>> nairaFundingRowsAscii(Object? metadata) {
  final b = PaymentMethodBreakdown.from(decodeFundingMetadata(metadata));
  if (b == null) return const [];
  return breakdownEntries(
          b, (minor) => 'NGN ${(minor / 100).toStringAsFixed(2)}')
      .map((e) => MapEntry(_toAscii(e.key), _toAscii(e.value)))
      .toList();
}

/// Fold a composed row down to printable ASCII.
///
/// THE SEPARATORS ARE THE HAZARD, NOT THE MONEY. `breakdownEntries` joins with
/// an em-dash (U+2014) and a middle dot (U+00B7) because they read well on
/// screen — and U+2014 is above the latin1 ceiling that the PDF's Helvetica
/// fallback encodes to, so it THROWS and takes the whole document with it.
/// Caught by a test asserting every code unit of every PDF row is < 128; it
/// failed on the em-dash the first time it ran.
///
/// Substituted rather than deleted: dropping the separator would run the coin
/// and the amount together ("USDTNGN 800.00").
String _toAscii(String input) => input
    .replaceAll('\u2014', '-')
    .replaceAll('\u2013', '-')
    .replaceAll('\u00b7', '-')
    .replaceAll('\u20a6', 'NGN ')
    .replaceAll(RegExp(r'[^\x20-\x7E]'), '')
    .replaceAll(RegExp(r'\s{2,}'), ' ')
    .trim();
