import 'dart:convert';

import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;

/// The first page of the user's budgets (plus the two totals the summary
/// card shows), remembered per user and mirrored to disk, so the Budgets
/// list paints what it showed last time the moment it opens and refreshes
/// behind it.
///
/// Only the UNFILTERED first page is remembered — a status- or category-
/// filtered page must never be painted as the answer to the plain list.
///
/// Rows are JSON maps: row 0 is `{_meta, total_budget, total_spent}`, the
/// rest hold one protobuf [pb.BudgetMessage] each, as base64 of its wire
/// bytes (the message's own codec, so every field round-trips).
class BudgetPageStore {
  BudgetPageStore._();

  static final SessionPageStore<Map<String, dynamic>> store =
      SessionPageStore<Map<String, dynamic>>(
    'budgets_page_one',
    toJson: (m) => m,
    fromJson: (j) => j,
  );

  /// Synchronous read for the first frame, or null when nothing is held in
  /// memory for this user (disk needs [hydrate]).
  static ({
    List<pb.BudgetMessage> budgets,
    double totalBudgetAmount,
    double totalSpentAmount
  })? peek(String userId) {
    if (userId.isEmpty) return null;
    return _unpack(store.peek(userId: userId));
  }

  static Future<
      ({
        List<pb.BudgetMessage> budgets,
        double totalBudgetAmount,
        double totalSpentAmount
      })?> hydrate(String userId) async {
    if (userId.isEmpty) return null;
    return _unpack(await store.hydrate(userId: userId));
  }

  static void put(
    String userId, {
    required List<pb.BudgetMessage> budgets,
    required double totalBudgetAmount,
    required double totalSpentAmount,
  }) {
    if (userId.isEmpty) return;
    store.put([
      {
        '_meta': true,
        'total_budget': totalBudgetAmount,
        'total_spent': totalSpentAmount,
      },
      for (final b in budgets) {'b': base64Encode(b.writeToBuffer())},
    ], userId: userId);
  }

  static ({
    List<pb.BudgetMessage> budgets,
    double totalBudgetAmount,
    double totalSpentAmount
  })? _unpack(List<Map<String, dynamic>>? rows) {
    if (rows == null || rows.isEmpty || rows.first['_meta'] != true) {
      return null;
    }
    final meta = rows.first;
    final budgets = <pb.BudgetMessage>[];
    for (final r in rows.skip(1)) {
      final raw = r['b'];
      if (raw is! String) continue;
      try {
        budgets.add(pb.BudgetMessage.fromBuffer(base64Decode(raw)));
      } catch (_) {
        // One unreadable row never costs the list.
      }
    }
    return (
      budgets: budgets,
      totalBudgetAmount: (meta['total_budget'] as num?)?.toDouble() ?? 0,
      totalSpentAmount: (meta['total_spent'] as num?)?.toDouble() ?? 0,
    );
  }
}
