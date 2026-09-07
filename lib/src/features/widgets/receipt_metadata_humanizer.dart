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
/// Matches a bare UUID (with or without dashes). A raw UUID is never
/// customer-meaningful: the user-facing identifiers on a receipt are the
/// Transaction ID and reference rows, which are rendered as first-class rows
/// (never through this metadata path) and carry prefixes (ESCROW-, TPTAG-,
/// IDEM-XFER-…), so a BARE uuid in metadata is always internal plumbing —
/// most damagingly a counterparty USER id, which belongs only in the admin
/// dashboard's raw metadata view.
final RegExp _bareUuid = RegExp(
    r'^[0-9a-fA-F]{8}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{12}$');

/// Metadata keys that identify a PARTY (user/account ids). Never shown to
/// customers — receipts identify people by name/tag, admins by id.
bool _isPartyIdKey(String lk) {
  if (lk == 'id') return true;
  return lk.endsWith('user_id') ||
      lk.endsWith('userid') ||
      lk == 'user' ||
      lk.endsWith('sender_id') ||
      lk.endsWith('recipient_id') ||
      lk.endsWith('receiver_id') ||
      lk.endsWith('payer_id') ||
      lk.endsWith('payee_id') ||
      lk.endsWith('beneficiary_id') ||
      lk.endsWith('counterparty_id') ||
      lk.endsWith('initiator_id') ||
      lk.endsWith('creator_id') ||
      lk.endsWith('member_id') ||
      lk.endsWith('account_id') ||
      lk.endsWith('wallet_id');
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

  // Party identifiers (user/account ids) and bare-UUID values are internal
  // plumbing — admin-dashboard material, never customer receipt rows.
  if (_isPartyIdKey(lk)) return null;
  if (_bareUuid.hasMatch(value)) return null;

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
