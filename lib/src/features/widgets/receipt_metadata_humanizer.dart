/// Humanizes backend transaction metadata for CUSTOMER receipts.
///
/// Backend rows carry ledger plumbing like `amount_minor_units: 1070000`,
/// `fiat_fee_minor_units: 2500` (kobo / µcrypto). Those raw values must never
/// reach a receipt: fiat kobo amounts are converted to naira with a clean
/// label ("Fee · ₦25.00"), and crypto minor units — whose per-asset scale the
/// client can't know reliably — are hidden entirely (the receipt's hero
/// amount and explicit Amount/Fee rows already show the major values).
library;

/// A humanized label/value pair, or null when the row must be hidden.
class HumanizedReceiptEntry {
  final String label;
  final String value;
  const HumanizedReceiptEntry(this.label, this.value);
}

/// Humanize one metadata entry. Returns null to HIDE the row.
/// [formatKey] renders the fallback label for ordinary keys (screens pass
/// their existing key formatter so styling stays consistent).
HumanizedReceiptEntry? humanizeReceiptMetadataEntry(
  String key,
  String rawValue, {
  String Function(String key)? formatKey,
}) {
  final value = rawValue.trim();
  if (value.isEmpty) return null;
  final lk = key.toLowerCase();

  if (lk.contains('minor')) {
    // Fiat kobo (NGN) → naira with a human label. Anything else (crypto
    // minor units at unknown per-asset scale) is ledger plumbing — hide it.
    final isFiatKobo =
        lk.contains('fiat') || lk.contains('ngn') || lk.contains('kobo');
    final numeric = double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (isFiatKobo && numeric != null) {
      final naira = numeric / 100.0;
      // e.g. fiat_fee_minor_units → "Fee"; ngn_amount_minor → "Amount".
      final label = lk.contains('fee')
          ? 'Fee'
          : lk.contains('total')
              ? 'Total'
              : 'Amount';
      return HumanizedReceiptEntry(
          label,
          '₦${naira.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},')}');
    }
    return null;
  }

  final label = formatKey != null ? formatKey(key) : key;
  return HumanizedReceiptEntry(label, value);
}
