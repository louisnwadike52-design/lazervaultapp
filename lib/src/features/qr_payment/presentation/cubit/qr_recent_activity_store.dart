import 'package:lazervault/core/cache/session_page_store.dart';

import '../../domain/entities/qr_payment_entity.dart';
import '../../domain/entities/qr_transaction_entity.dart';

/// The QR Pay landing's "recent activity" (last 3 codes + last 3 payments),
/// per user, remembered across the factory cubit's lifetimes and across
/// launches so the landing paints its sections instantly and refreshes
/// behind them.
class QRRecentActivityStore {
  QRRecentActivityStore._();

  static final SessionPageStore<QRPaymentEntity> codes =
      SessionPageStore<QRPaymentEntity>(
    'qr_recent_codes',
    toJson: encodeCode,
    fromJson: decodeCode,
  );

  static final SessionPageStore<QRTransactionEntity> payments =
      SessionPageStore<QRTransactionEntity>(
    'qr_recent_payments',
    toJson: encodePayment,
    fromJson: decodePayment,
  );

  static Future<
          ({List<QRPaymentEntity> codes, List<QRTransactionEntity> payments})?>
      hydrate(String userId) async {
    if (userId.isEmpty) return null;
    final c = await codes.hydrate(userId: userId);
    final p = await payments.hydrate(userId: userId);
    if (c == null && p == null) return null;
    return (codes: c ?? const [], payments: p ?? const []);
  }

  static Map<String, dynamic> encodeCode(QRPaymentEntity e) => {
        'id': e.id,
        'user_id': e.userId,
        'username': e.username,
        'full_name': e.fullName,
        'qr_code': e.qrCode,
        'amount': e.amount,
        'currency': e.currency,
        'description': e.description,
        'qr_type': e.qrType.name,
        'usage_mode': e.usageMode,
        'status': e.status.name,
        'created_at': e.createdAt.toIso8601String(),
        'expires_at': e.expiresAt?.toIso8601String(),
        'paid_at': e.paidAt?.toIso8601String(),
      };

  static QRPaymentEntity decodeCode(Map<String, dynamic> j) => QRPaymentEntity(
        id: j['id'] as String? ?? '',
        userId: j['user_id'] as String? ?? '',
        username: j['username'] as String? ?? '',
        fullName: j['full_name'] as String? ?? '',
        qrCode: j['qr_code'] as String? ?? '',
        amount: (j['amount'] as num?)?.toDouble() ?? 0,
        currency: j['currency'] as String? ?? '',
        description: j['description'] as String? ?? '',
        qrType:
            QRPaymentTypeExtension.fromString(j['qr_type'] as String? ?? ''),
        usageMode: j['usage_mode'] as String? ?? 'one_time',
        status:
            QRPaymentStatusExtension.fromString(j['status'] as String? ?? ''),
        createdAt: _date(j['created_at']) ?? DateTime.now(),
        expiresAt: _date(j['expires_at']),
        paidAt: _date(j['paid_at']),
      );

  static Map<String, dynamic> encodePayment(QRTransactionEntity t) => {
        'id': t.id,
        'qr_id': t.qrId,
        'payer_id': t.payerId,
        'payer_username': t.payerUsername,
        'payer_name': t.payerName,
        'recipient_id': t.recipientId,
        'recipient_username': t.recipientUsername,
        'recipient_name': t.recipientName,
        'amount': t.amount,
        'currency': t.currency,
        'description': t.description,
        'reference_number': t.referenceNumber,
        'status': t.status.name,
        'created_at': t.createdAt.toIso8601String(),
      };

  static QRTransactionEntity decodePayment(Map<String, dynamic> j) =>
      QRTransactionEntity(
        id: j['id'] as String? ?? '',
        qrId: j['qr_id'] as String? ?? '',
        payerId: j['payer_id'] as String? ?? '',
        payerUsername: j['payer_username'] as String? ?? '',
        payerName: j['payer_name'] as String? ?? '',
        recipientId: j['recipient_id'] as String? ?? '',
        recipientUsername: j['recipient_username'] as String? ?? '',
        recipientName: j['recipient_name'] as String? ?? '',
        amount: (j['amount'] as num?)?.toDouble() ?? 0,
        currency: j['currency'] as String? ?? '',
        description: j['description'] as String? ?? '',
        referenceNumber: j['reference_number'] as String? ?? '',
        status: QRTransactionStatusExtension.fromString(
            j['status'] as String? ?? ''),
        createdAt: _date(j['created_at']) ?? DateTime.now(),
      );

  static DateTime? _date(Object? v) =>
      v is String ? DateTime.tryParse(v) : null;
}
