import 'dart:convert';

/// Single source of truth for classifying a scanned Lazervault QR string.
///
/// Both scanners parse the same wire formats but act on the result differently
/// (the send-funds scanner returns a result map; the QR-pay scanner navigates).
/// Keeping the *classification* here guarantees they never drift — a format the
/// My-QR screen emits is understood everywhere.
///
/// Recognised payloads:
///  - v2.1 server-backed amount QR: `{"type":"lazervault_pay","qr_code":"QR-…"}`
///  - legacy v2.0 self-contained token: `{"type":"lazervault_pay","token":"…"}`
///  - static recipient QR: `{"type":"lazervault_recipient","recipientId":…}`
///  - legacy payment JSON: `{"type":"qr_payment","qr_code":"QR-…"}`
///  - a bare `QR-…` reference string (no JSON wrapper)
sealed class QrPayload {
  const QrPayload();

  /// Classify a raw scanned string. Never throws.
  factory QrPayload.parse(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return const InvalidQr();

    // JSON-wrapped payloads.
    try {
      final decoded = json.decode(value);
      if (decoded is Map<String, dynamic>) {
        final type = decoded['type'] as String?;
        switch (type) {
          case 'lazervault_pay':
          case 'qr_payment':
            final qrCode = decoded['qr_code'] as String?;
            if (qrCode != null && qrCode.isNotEmpty) {
              return ServerPayQr(qrCode: qrCode);
            }
            final token = decoded['token'] as String?;
            if (token != null && token.isNotEmpty) {
              return LegacyTokenQr.decodeToken(token);
            }
            return const InvalidQr();
          case 'lazervault_recipient':
            final recipientId = decoded['recipientId']?.toString();
            final username = decoded['username']?.toString();
            if (recipientId == null ||
                recipientId.isEmpty ||
                username == null ||
                username.isEmpty) {
              return const InvalidQr();
            }
            return RecipientQr(
              recipientId: recipientId,
              username: username,
              name: (decoded['name'] ?? username).toString(),
            );
          case 'invoice':
          case 'payment':
            // Invoice QRs are payable only through the Invoices flow (or the
            // AI scanner, which understands them) — name the situation
            // instead of calling a valid Lazervault code "invalid".
            return const InvalidQr(
                reason:
                    'This is an invoice QR. Open it with AI Scan to Pay, or pay it from the Invoices screen.');
          case 'transfer':
          case 'batch_transfer':
            // Receipt QRs encode a completed transaction reference — they
            // identify a payment, they can't start one.
            return const InvalidQr(
                reason:
                    'This QR is a transaction receipt — it can\'t be used to make a payment.');
          default:
            return const InvalidQr();
        }
      }
    } catch (_) {
      // Not JSON — fall through to the raw-reference check.
    }

    // A bare server reference (e.g. shared/printed as plain text).
    if (value.startsWith('QR-')) {
      return ServerPayQr(qrCode: value);
    }
    return const InvalidQr();
  }
}

/// v2.1 server-backed QR: carries only a `QR-…` reference. The recipient +
/// amount are resolved authoritatively via `getQRDetails` (zero client trust).
class ServerPayQr extends QrPayload {
  final String qrCode;
  const ServerPayQr({required this.qrCode});
}

/// Static recipient QR — identifies a person to pay but carries no amount.
class RecipientQr extends QrPayload {
  final String recipientId;
  final String username;
  final String name;
  const RecipientQr({
    required this.recipientId,
    required this.username,
    required this.name,
  });
}

/// Legacy v2.0 self-contained token (base64 JWT-style middle segment). Kept for
/// QR codes minted before server-backed references existed.
class LegacyTokenQr extends QrPayload {
  final String recipientId;
  final String username;
  final String name;
  final int? amountMinor;
  final String currency;
  final DateTime? expiresAt;

  const LegacyTokenQr({
    required this.recipientId,
    required this.username,
    required this.name,
    this.amountMinor,
    this.currency = 'NGN',
    this.expiresAt,
  });

  /// Decode the base64 middle segment. Returns [InvalidQr] on any failure.
  static QrPayload decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 2) return const InvalidQr();
      var payload = parts[1];
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      final decoded =
          json.decode(String.fromCharCodes(base64Url.decode(payload)));
      if (decoded is! Map<String, dynamic>) return const InvalidQr();
      final recipientId = decoded['user_id']?.toString() ?? '';
      if (recipientId.isEmpty) return const InvalidQr();
      final amountRaw = decoded['amount'];
      final amount =
          (amountRaw is num && amountRaw != 0) ? amountRaw.toInt() : null;
      DateTime? exp;
      if (decoded['exp'] != null) {
        exp = DateTime.fromMillisecondsSinceEpoch(
          (decoded['exp'] as num).toInt() * 1000,
        );
      }
      return LegacyTokenQr(
        recipientId: recipientId,
        username: (decoded['username'] ?? '').toString(),
        name: (decoded['name'] ?? decoded['username'] ?? '').toString(),
        amountMinor: amount,
        currency: (decoded['currency'] ?? 'NGN').toString(),
        expiresAt: exp,
      );
    } catch (_) {
      return const InvalidQr();
    }
  }

  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);
}

/// Unrecognised / malformed QR.
class InvalidQr extends QrPayload {
  const InvalidQr({this.reason});

  /// Optional user-facing explanation for a RECOGNIZED-but-unpayable code
  /// (e.g. an invoice QR, a receipt QR). Null = genuinely unknown format.
  /// Scanners show this instead of the generic "not a Lazervault code" so
  /// scanning your own receipt/invoice isn't reported as corruption.
  final String? reason;
}
