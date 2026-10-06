import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';

/// One previously generated statement, remembered locally.
///
/// The backend has no statement-history RPC, and the download URL it returns
/// is short-lived, so "recent statements" cannot be a list of links — it is a
/// list of the PARAMETERS needed to ask for the same document again. Tapping
/// one re-generates it, which the service's 10-minute idempotency cache makes
/// cheap.
class StatementRecentEntry {
  final String accountId;
  final DateTime startDate;
  final DateTime endDate;
  final StatementFormat format;
  final DateTime generatedAt;

  const StatementRecentEntry({
    required this.accountId,
    required this.startDate,
    required this.endDate,
    required this.format,
    required this.generatedAt,
  });

  Map<String, dynamic> toJson() => {
        'accountId': accountId,
        'startMs': startDate.millisecondsSinceEpoch,
        'endMs': endDate.millisecondsSinceEpoch,
        'format': format == StatementFormat.csv ? 'csv' : 'pdf',
        'generatedMs': generatedAt.millisecondsSinceEpoch,
      };

  /// Returns null for a row that cannot be read back.
  ///
  /// The store is written by the app itself, but a half-written or
  /// older-shaped entry must drop out quietly rather than take the whole list
  /// with it — losing one row of history is invisible; losing the surface to a
  /// crash is not.
  static StatementRecentEntry? tryFromJson(Map<String, dynamic> json) {
    final accountId = json['accountId'];
    final startMs = json['startMs'];
    final endMs = json['endMs'];
    if (accountId is! String || accountId.isEmpty) return null;
    if (startMs is! int || endMs is! int) return null;
    final generatedMs = json['generatedMs'];
    return StatementRecentEntry(
      accountId: accountId,
      startDate: DateTime.fromMillisecondsSinceEpoch(startMs),
      endDate: DateTime.fromMillisecondsSinceEpoch(endMs),
      format:
          json['format'] == 'csv' ? StatementFormat.csv : StatementFormat.pdf,
      generatedAt: generatedMs is int
          ? DateTime.fromMillisecondsSinceEpoch(generatedMs)
          : DateTime.fromMillisecondsSinceEpoch(startMs),
    );
  }

  /// Same account, window and format — used to de-duplicate.
  bool sameRequestAs(StatementRecentEntry other) =>
      accountId == other.accountId &&
      startDate.millisecondsSinceEpoch ==
          other.startDate.millisecondsSinceEpoch &&
      endDate.millisecondsSinceEpoch == other.endDate.millisecondsSinceEpoch &&
      format == other.format;
}

/// The one place recent statements are persisted.
///
/// There used to be two: the settings screen kept a SharedPreferences list and
/// the export screen kept a global in-memory list that was lost the moment the
/// screen was disposed — so a statement generated from the dashboard never
/// appeared in the account sheet, and vice versa. Both now read and write here.
///
/// The storage key is unchanged (`recent_statements_v1`) so everything users
/// have already generated survives the consolidation.
class StatementRecentStore {
  static const String _key = 'recent_statements_v1';
  static const int _max = 20;

  /// Newest first. Never throws — an unreadable store yields an empty list,
  /// because a missing history surface is a far smaller problem than a screen
  /// that will not open.
  Future<List<StatementRecentEntry>> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) return const [];
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map>()
          .map((e) => StatementRecentEntry.tryFromJson(
              e.map((k, v) => MapEntry(k.toString(), v))))
          .whereType<StatementRecentEntry>()
          .toList();
    } catch (_) {
      return const [];
    }
  }

  /// Records [entry] at the top, replacing any identical request, and returns
  /// the new list so the caller can render it without a second read.
  Future<List<StatementRecentEntry>> record(StatementRecentEntry entry) async {
    final current = List<StatementRecentEntry>.from(await load())
      ..removeWhere((e) => e.sameRequestAs(entry));
    current.insert(0, entry);
    final trimmed = current.length > _max ? current.sublist(0, _max) : current;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _key, jsonEncode(trimmed.map((e) => e.toJson()).toList()));
    } catch (_) {
      // Non-fatal: the user still has the statement they just generated.
    }
    return trimmed;
  }
}
