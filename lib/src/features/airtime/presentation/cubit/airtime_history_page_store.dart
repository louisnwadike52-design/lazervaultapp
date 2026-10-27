import 'package:lazervault/core/cache/session_page_store.dart';

import '../../data/models/airtime_transaction_model.dart';
import '../../domain/entities/airtime_transaction.dart';

/// The last airtime history + statistics the server gave us, per user, so
/// the landing strip ("Recent Transactions") and the history screen paint
/// instantly — including on the first open after a launch — while the live
/// answer is fetched behind them.
class AirtimeHistoryPageStore {
  AirtimeHistoryPageStore._();

  static final SessionPageStore<AirtimeTransaction> transactions =
      SessionPageStore<AirtimeTransaction>(
    'airtime_history',
    toJson: encode,
    fromJson: AirtimeTransactionModel.fromJson,
  );

  /// One row: the statistics map. Dates are ISO strings on disk.
  static final SessionPageStore<Map<String, dynamic>> statistics =
      SessionPageStore<Map<String, dynamic>>(
    'airtime_history_stats',
    toJson: _encodeStats,
    fromJson: _decodeStats,
  );

  static Future<
      ({
        List<AirtimeTransaction> transactions,
        Map<String, dynamic>? statistics
      })?> hydrate(String userId) async {
    if (userId.isEmpty) return null;
    final rows = await transactions.hydrate(userId: userId);
    if (rows == null) return null;
    final stats = await statistics.hydrate(userId: userId);
    return (
      transactions: rows,
      statistics: (stats == null || stats.isEmpty) ? null : stats.first,
    );
  }

  static void put(
    String userId, {
    required List<AirtimeTransaction> transactions,
    required Map<String, dynamic>? statistics,
  }) {
    if (userId.isEmpty) return;
    AirtimeHistoryPageStore.transactions.put(transactions, userId: userId);
    AirtimeHistoryPageStore.statistics
        .put(statistics == null ? const [] : [statistics], userId: userId);
  }

  /// Same keys as [AirtimeTransactionModel.toJson], written from the entity so
  /// any [AirtimeTransaction] instance round-trips.
  static Map<String, dynamic> encode(AirtimeTransaction t) => {
        'id': t.id,
        'transactionReference': t.transactionReference,
        'networkProvider': t.networkProvider.name,
        'recipientPhoneNumber': t.recipientPhoneNumber,
        'recipientName': t.recipientName,
        'amount': t.amount,
        'currency': t.currency,
        'status': t.status.name,
        'createdAt': t.createdAt.toIso8601String(),
        'completedAt': t.completedAt?.toIso8601String(),
        'failureReason': t.failureReason,
        'metadata': _jsonSafe(t.metadata),
        'userId': t.userId,
        'discount': t.discount,
        'fee': t.fee,
        'totalAmount': t.totalAmount,
      };

  static Map<String, dynamic> _encodeStats(Map<String, dynamic> m) =>
      _jsonSafe(m) ?? const {};

  static Map<String, dynamic> _decodeStats(Map<String, dynamic> j) {
    final out = Map<String, dynamic>.from(j);
    final last = out['lastTransactionDate'];
    if (last is String) out['lastTransactionDate'] = DateTime.tryParse(last);
    return out;
  }

  /// Statistics (and metadata) are loosely typed maps; make sure nothing in
  /// them trips jsonEncode.
  static Map<String, dynamic>? _jsonSafe(Map<String, dynamic>? m) {
    if (m == null) return null;
    final out = <String, dynamic>{};
    m.forEach((k, v) {
      if (v is DateTime) {
        out[k] = v.toIso8601String();
      } else if (v is Map<String, dynamic>) {
        out[k] = _jsonSafe(v);
      } else if (v is Map) {
        out[k] = _jsonSafe(Map<String, dynamic>.from(v));
      } else if (v == null || v is num || v is String || v is bool) {
        out[k] = v;
      } else if (v is List) {
        out[k] = v
            .where((e) => e == null || e is num || e is String || e is bool)
            .toList();
      } else {
        out[k] = v.toString();
      }
    });
    return out;
  }
}
