import 'dart:convert';

import '../entities/scan_entities.dart';

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
    switch (type) {
      // ── Dedicated QR-pay product (qr-pay-service) ──
      case 'qr_payment':
        final code = (data['qr_code'] ?? data['qrCode'])?.toString();
        if (code == null || code.isEmpty) return null;
        final amount = _asDouble(data['amount']);
        return ScanPaymentIntent(
          type: ScanIntentType.qrPay,
          title: (data['name'] ?? data['business_name'] ?? 'QR Payment').toString(),
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
        if (_isExpired(payload['exp'])) return null; // surfaced as "unrecognized/expired"
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
        final userId = (data['recipientId'] ?? data['recipient_id'])?.toString();
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

  String _shortId(String id) =>
      id.length <= 8 ? id : '${id.substring(0, 8)}…';
}
