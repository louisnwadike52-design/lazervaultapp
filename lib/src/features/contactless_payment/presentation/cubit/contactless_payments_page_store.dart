import 'package:lazervault/core/cache/session_page_store.dart';

import '../../domain/entities/contactless_payment_entity.dart';

/// The last "my contactless payments" answer, per user and per query shape
/// (limit / offset / role filter), so the Contactless landing's quick stats
/// and recent-activity strip — and the history screen — paint instantly on
/// open and refresh behind.
///
/// Rows are JSON maps: row 0 is `{_meta, total}` (the server's total count,
/// which the quick stats show), the rest are transactions.
class ContactlessPaymentsPageStore {
  ContactlessPaymentsPageStore._();

  /// One store per query shape, so the landing's `limit: 5` page and the
  /// history screen's `limit: 20` page do not evict each other.
  static final Map<String, SessionPageStore<Map<String, dynamic>>> _stores = {};

  static SessionPageStore<Map<String, dynamic>> storeFor(String scope) =>
      _stores.putIfAbsent(
        scope,
        () => SessionPageStore<Map<String, dynamic>>(
          'contactless_payments.$scope',
          toJson: (m) => m,
          fromJson: (j) => j,
        ),
      );

  static String scope({
    required int limit,
    required int offset,
    String? roleFilter,
  }) =>
      '$limit:$offset:${roleFilter ?? ''}';

  static Future<({List<ContactlessTransactionEntity> transactions, int total})?>
      hydrate(String userId, String scope) async {
    if (userId.isEmpty) return null;
    final rows = await storeFor(scope).hydrate(userId: userId);
    if (rows == null || rows.isEmpty || rows.first['_meta'] != true) {
      return null;
    }
    final total = (rows.first['total'] as num?)?.toInt() ?? 0;
    final txs = <ContactlessTransactionEntity>[];
    for (final r in rows.skip(1)) {
      try {
        txs.add(decode(r));
      } catch (_) {
        // One unreadable row never costs the list.
      }
    }
    return (transactions: txs, total: total);
  }

  static void put(
    String userId,
    String scope, {
    required List<ContactlessTransactionEntity> transactions,
    required int total,
  }) {
    if (userId.isEmpty) return;
    storeFor(scope).put([
      {'_meta': true, 'total': total},
      for (final t in transactions) encode(t),
    ], userId: userId);
  }

  static Map<String, dynamic> encode(ContactlessTransactionEntity t) => {
        'id': t.id,
        'session_id': t.sessionId,
        'payer_id': t.payerId,
        'payer_username': t.payerUsername,
        'payer_name': t.payerName,
        'payer_account_id': t.payerAccountId,
        'receiver_id': t.receiverId,
        'receiver_username': t.receiverUsername,
        'receiver_name': t.receiverName,
        'receiver_account_id': t.receiverAccountId,
        'amount': t.amount,
        'currency': t.currency,
        'category': t.category,
        'description': t.description,
        'reference_number': t.referenceNumber,
        'status': t.status.name,
        'created_at': t.createdAt.toIso8601String(),
      };

  static ContactlessTransactionEntity decode(Map<String, dynamic> j) =>
      ContactlessTransactionEntity(
        id: j['id'] as String? ?? '',
        sessionId: j['session_id'] as String? ?? '',
        payerId: j['payer_id'] as String? ?? '',
        payerUsername: j['payer_username'] as String? ?? '',
        payerName: j['payer_name'] as String? ?? '',
        payerAccountId: j['payer_account_id'] as String? ?? '',
        receiverId: j['receiver_id'] as String? ?? '',
        receiverUsername: j['receiver_username'] as String? ?? '',
        receiverName: j['receiver_name'] as String? ?? '',
        receiverAccountId: j['receiver_account_id'] as String? ?? '',
        amount: (j['amount'] as num?)?.toDouble() ?? 0,
        currency: j['currency'] as String? ?? '',
        category: j['category'] as String?,
        description: j['description'] as String?,
        referenceNumber: j['reference_number'] as String? ?? '',
        status: TransactionStatus.values.firstWhere(
          (s) => s.name == j['status'],
          orElse: () => TransactionStatus.completed,
        ),
        createdAt: DateTime.tryParse(j['created_at'] as String? ?? '') ??
            DateTime.now(),
      );
}
