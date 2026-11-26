import 'dart:convert';

/// What a parked purchase tells the app about the conversion it is waiting on.
///
/// WHY THE TOTAL COMES FROM THE SERVER. A purchase reserves face + platform
/// fee − discount, and only the server resolves the fee (it comes from admin
/// settings and can change between two taps). A client that re-derives it
/// converts the wrong amount the moment an operator edits a setting — short by
/// the fee, so the purchase then fails on insufficient funds and the customer
/// is told the rate moved, which is not what happened.
///
/// The server therefore states the figure, in the free-form metadata every
/// bill payment already carries, and this reads it back.
class CryptoFundingInfo {
  const CryptoFundingInfo({
    required this.requiredMinor,
    required this.asset,
    required this.service,
  });

  /// Fiat minor units (kobo for NGN) — the TOTAL the purchase will reserve.
  final int requiredMinor;
  final String asset;
  final String service;

  /// Reads the funding fields out of a payment's metadata, or null when this
  /// is not a crypto-funded purchase.
  ///
  /// Tolerant by design: the field is a plain string carrying whatever a
  /// service wrote, so anything unparseable yields null rather than throwing
  /// on a receipt. The `funding_source` marker is what distinguishes our
  /// fields from another service's — without it a stray `required_minor` from
  /// somewhere else would be read as a conversion target.
  static CryptoFundingInfo? fromMetadata(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      if (decoded['funding_source'] != 'crypto') return null;
      final v = decoded['required_minor'];
      final minor = v is int
          ? v
          : v is num
              ? v.toInt()
              : int.tryParse('$v') ?? 0;
      if (minor <= 0) return null;
      return CryptoFundingInfo(
        requiredMinor: minor,
        asset: (decoded['funding_asset'] ?? '').toString(),
        service: (decoded['service'] ?? '').toString(),
      );
    } catch (_) {
      return null;
    }
  }
}
