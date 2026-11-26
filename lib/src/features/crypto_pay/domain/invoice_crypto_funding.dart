/// PAYING AN INVOICE OUT OF CRYPTO — what the server hands back.
///
/// The invoice is NOT paid when this returns. The payment has been authorised
/// and recorded, and the conversion has not been asked for yet; that is the
/// next call, and it names [reference].
///
/// ORDER IS THE SAFETY PROPERTY. A conversion started with no intent waiting
/// for it would sell a customer's coin for an errand nothing tracks, and the
/// sub→master transfer at confirm is irreversible. If the conversion is never
/// asked for, invoice-service's sweep closes the intent and nothing moved.
library;

import 'dart:convert';

class InvoiceCryptoFunding {
  const InvoiceCryptoFunding({
    required this.reference,
    required this.requiredMinor,
    required this.currency,
    required this.asset,
  });

  /// The reference the conversion must name. Derived server-side from the
  /// invoice and the payer, so a tapped-twice button returns the SAME intent
  /// rather than opening a second conversion.
  final String reference;

  /// What the conversion must deliver, in [currency]'s minor units.
  ///
  /// COMES FROM THE SERVER, always. A client that works out its own total is
  /// a client that can under-fund a payment — and the customer is then told
  /// their rate moved, which is not what happened.
  final int requiredMinor;

  /// What the payment settles in. For a cross-currency invoice this is the
  /// payer's account currency, not the invoice's own.
  final String currency;

  /// The coin the customer chose, lowercase.
  final String asset;

  /// Reads the funding block off the `metadata` the server put on the
  /// response invoice.
  ///
  /// Returns null for an ordinary wallet payment — which is almost all of
  /// them — so a caller branches on null rather than on a sentinel.
  static InvoiceCryptoFunding? fromMetadata(String? raw) {
    final text = (raw ?? '').trim();
    if (text.isEmpty) return null;
    Map<String, dynamic> m;
    try {
      final decoded = jsonDecode(text);
      if (decoded is! Map) return null;
      m = Map<String, dynamic>.from(decoded);
    } catch (_) {
      // Malformed metadata is not a reason to crash a payment screen.
      return null;
    }
    if ((m['funding_source'] ?? '').toString() != 'crypto') return null;

    final reference = (m['reference'] ?? '').toString().trim();
    final required = _minor(m['required_minor']);
    // REFUSES TO GUESS. Without both of these there is nothing to fund and
    // nothing to fund it against; proceeding would ask the exchange to
    // convert an unknown amount for an unknown payment.
    if (reference.isEmpty || required == null || required <= 0) return null;

    return InvoiceCryptoFunding(
      reference: reference,
      requiredMinor: required,
      currency: (m['currency'] ?? 'NGN').toString().trim().isEmpty
          ? 'NGN'
          : (m['currency'] ?? 'NGN').toString().trim(),
      asset: (m['asset'] ?? '').toString().trim().toLowerCase(),
    );
  }

  /// Minor units from whatever JSON gave us.
  ///
  /// The wire can hand these back as int, double or string depending on which
  /// decoder touched them, and a payment that silently does nothing because a
  /// number arrived as a string is the kind of fault nobody reports.
  static int? _minor(Object? v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is double) return v.round();
    return int.tryParse(v.toString().trim());
  }
}
