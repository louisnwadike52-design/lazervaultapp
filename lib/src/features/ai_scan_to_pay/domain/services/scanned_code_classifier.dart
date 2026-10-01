import 'dart:convert';

import '../entities/scan_entities.dart';
import '../entities/scanned_receipt.dart';

/// Classifies a raw scanned QR/barcode value into a unified [ScanPaymentIntent].
///
/// Centralizes the LazerVault QR parsing that previously lived (duplicated) in
/// `recipients/.../qr_scanner_screen.dart` (`lazervault_pay` v2 token,
/// `lazervault_recipient`), `qr_payment/.../scan_qr_screen.dart` (`qr_payment`
/// + raw `QR-…`) and `invoice/services/invoice_qr_service.dart`
/// (`invoice` / `payment`). Returns `null` when the value isn't a recognizable
/// Lazervault payment code (caller falls back to OCR or shows "unsupported QR").
class ScannedCodeClassifier {
  const ScannedCodeClassifier();

  /// Receipt `type` values the app ENCODES on its own receipts.
  ///
  /// Taken from the code that writes them — transfer_receipt_screen
  /// ('transfer', 'batch_transfer'), bill_receipt_qr_block (the bill services),
  /// contribution_payment_confirmation_screen ('group_contribution') — rather
  /// than invented. Anything here is PROOF OF A COMPLETED PAYMENT and must never
  /// become a payment request; see [ScannedReceipt].
  static const Set<String> receiptTypes = {
    'transfer',
    'batch_transfer',
    'airtime',
    'data',
    'electricity',
    'cable_tv',
    'internet',
    'water',
    'education',
    'intl_airtime',
    'intl_data',
    'betting',
    'epin',
    'group_contribution',
    'contribution',
    'donation',
    'conversion',
    'exchange',
    'withdrawal',
    'deposit',
  };

  /// Recognise a RECEIPT QR. Returns null when the value is not one.
  ///
  /// Checked by the caller BEFORE any payment classification and before the OCR
  /// fallback, because a receipt contains everything a payment request contains
  /// — a name, an amount, sometimes an account — and OCR cannot tell the
  /// difference. Getting this order wrong is how someone pays the same bill
  /// twice by scanning their own receipt.
  ScannedReceipt? classifyReceipt(String rawValue) {
    final raw = rawValue.trim();
    if (raw.isEmpty) return null;
    Map<String, dynamic> data;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;
      data = decoded;
    } catch (_) {
      return null;
    }
    final type = (data['type'] as String?)?.trim().toLowerCase();
    if (type == null || !receiptTypes.contains(type)) return null;
    // A receipt always carries a reference. Without one there is nothing to look
    // up and nothing to show, so it is not treated as a receipt — which also
    // keeps a malformed or spoofed payload from suppressing the payment paths
    // silently.
    final ref = (data['ref'] ?? data['reference'])?.toString().trim();
    if (ref == null || ref.isEmpty) return null;
    return ScannedReceipt(
      kind: type,
      reference: ref,
      amount: _asDouble(data['amount']),
      currency: (data['currency'] ?? 'NGN').toString(),
      status: data['status']?.toString(),
      date: DateTime.tryParse((data['date'] ?? '').toString()),
      counterparty: (data['to'] ?? data['recipient'])?.toString(),
      raw: raw,
    );
  }

  /// A LazerVault LINK read off a QR, or null.
  ///
  /// The app prints links into QR codes in several places — a shared escrow
  /// offer, a crowdfund campaign, a family invite, a LazerSpray session, a group
  /// report, a donation receipt — and every one of those shapes is already
  /// understood by DeepLinkService. So this only identifies the link as ours and
  /// hands the Uri on; the scanner must not learn a second reading of our own
  /// URLs, because the two would drift and the scanner would be the one that
  /// fell behind.
  ///
  /// Accepts both forms the app mints: the custom scheme and the universal link.
  Uri? lazervaultLink(String rawValue) {
    final raw = rawValue.trim();
    if (raw.isEmpty) return null;
    final uri = Uri.tryParse(raw);
    if (uri == null) return null;
    final scheme = uri.scheme.toLowerCase();
    if (scheme == 'lazervault') return uri;
    if (scheme != 'http' && scheme != 'https') return null;
    final host = uri.host.toLowerCase();
    // Exact hosts only. A suffix match would accept
    // `lazervault.app.attacker.example` and hand an attacker's URL to our own
    // router.
    if (host == 'lazervault.app' || host == 'www.lazervault.app') return uri;
    return null;
  }

  ScanPaymentIntent? classify(String rawValue) {
    final raw = rawValue.trim();
    if (raw.isEmpty) return null;

    // Raw qr-pay-service code (not JSON) — e.g. "QR-abc123".
    if (raw.startsWith('QR-')) {
      return ScanPaymentIntent(
        type: ScanIntentType.qrPay,
        title: 'QR Payment',
        subtitle: raw,
        qrCode: raw,
        amountEditable: true,
        raw: raw,
      );
    }

    // Structured LazerVault QR (JSON).
    Map<String, dynamic> data;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;
      data = decoded;
    } catch (_) {
      return null; // not JSON, not a known raw code
    }

    final type = (data['type'] as String?)?.toLowerCase();
    // A receipt is never a payment request, whatever else the payload says.
    //
    // Belt-and-braces today: no receipt type matches a case below, so `default`
    // already returns null — removing this line breaks nothing, and the test
    // suite says so honestly rather than pretending otherwise. It is here for
    // the day someone adds a payable branch whose discriminator collides with a
    // receipt's ('data' and 'airtime' are bill receipt types; 'payment' is
    // already a payable invoice), because the cost of that collision is charging
    // a customer twice.
    if (type != null && receiptTypes.contains(type)) return null;
    switch (type) {
      // ── Dedicated QR-pay product (qr-pay-service) ──
      case 'qr_payment':
        final code = (data['qr_code'] ?? data['qrCode'])?.toString();
        if (code == null || code.isEmpty) return null;
        final amount = _asDouble(data['amount']);
        return ScanPaymentIntent(
          type: ScanIntentType.qrPay,
          title: (data['name'] ?? data['business_name'] ?? 'QR Payment')
              .toString(),
          subtitle: code,
          qrCode: code,
          amount: amount,
          currency: (data['currency'] ?? 'NGN').toString(),
          amountEditable: amount == null || amount == 0,
          description: data['description']?.toString(),
          raw: raw,
        );

      // ── Invoice QR (invoice-service) ──
      case 'invoice':
      case 'payment':
        final id = (data['invoiceId'] ?? data['id'])?.toString();
        if (id == null || id.isEmpty) return null;
        final amount = _asDouble(data['amount'] ?? data['totalAmount']);
        return ScanPaymentIntent(
          type: ScanIntentType.invoice,
          title: (data['title'] ?? data['recipient'] ?? 'Invoice').toString(),
          subtitle: 'Invoice ${_shortId(id)}',
          invoiceId: id,
          amount: amount,
          currency: (data['currency'] ?? 'NGN').toString(),
          amountEditable: false, // invoices are fixed-amount
          description: data['description']?.toString(),
          raw: raw,
        );

      // ── Pay a Lazervault user (dynamic, signed) → C2C transfer ──
      case 'lazervault_pay':
        // v2.1 (My Account → My QR with an amount): carries a server-minted
        // qr_code reference, NOT a token. Route it as a server QR — the
        // token-only reading rejected it as "unsupported" even though every
        // other scanner accepts it.
        final qrRef = data['qr_code']?.toString();
        if (qrRef != null && qrRef.isNotEmpty) {
          return ScanPaymentIntent(
            type: ScanIntentType.qrPay,
            title: 'Lazervault payment',
            subtitle: qrRef,
            qrCode: qrRef,
            amountEditable: false,
            raw: raw,
          );
        }
        final payload = _decodeTokenPayload(data['token']?.toString());
        if (payload == null) return null;
        if (_isExpired(payload['exp']))
          return null; // surfaced as "unrecognized/expired"
        final userId = (payload['user_id'] ?? payload['userId'])?.toString();
        final username = payload['username']?.toString();
        if ((userId == null || userId.isEmpty) &&
            (username == null || username.isEmpty)) {
          return null;
        }
        final amount = _asDouble(payload['amount']);
        return ScanPaymentIntent(
          type: ScanIntentType.recipient,
          title: (payload['name'] ?? username ?? 'Recipient').toString(),
          subtitle: username != null ? '@$username' : 'Lazervault user',
          userId: userId,
          username: username,
          amount: amount == 0 ? null : amount,
          currency: (payload['currency'] ?? 'NGN').toString(),
          amountEditable: amount == null || amount == 0,
          raw: raw,
        );

      // ── Static recipient QR → C2C transfer ──
      case 'lazervault_recipient':
        final userId =
            (data['recipientId'] ?? data['recipient_id'])?.toString();
        final username = data['username']?.toString();
        if ((userId == null || userId.isEmpty) &&
            (username == null || username.isEmpty)) {
          return null;
        }
        return ScanPaymentIntent(
          type: ScanIntentType.recipient,
          title: (data['name'] ?? username ?? 'Recipient').toString(),
          subtitle: username != null ? '@$username' : 'Lazervault user',
          userId: userId,
          username: username,
          amountEditable: true,
          raw: raw,
        );

      default:
        return null;
    }
  }

  // Decode the payload segment of a JWT-like token (header.payload[.sig]).
  Map<String, dynamic>? _decodeTokenPayload(String? token) {
    if (token == null || token.isEmpty) return null;
    final parts = token.split('.');
    if (parts.length < 2) return null;
    try {
      var seg = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      while (seg.length % 4 != 0) {
        seg += '=';
      }
      final decoded = jsonDecode(utf8.decode(base64.decode(seg)));
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  bool _isExpired(dynamic exp) {
    if (exp == null) return false;
    final secs = (exp is num) ? exp.toInt() : int.tryParse(exp.toString());
    if (secs == null) return false;
    final expiry = DateTime.fromMillisecondsSinceEpoch(secs * 1000);
    return DateTime.now().isAfter(expiry);
  }

  double? _asDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  String _shortId(String id) => id.length <= 8 ? id : '${id.substring(0, 8)}…';
}
