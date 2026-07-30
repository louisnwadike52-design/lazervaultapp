import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared bank-picker sort model + Nigerian popularity ranking + per-user MRU
/// store. This is the SINGLE source of truth for the "Most used / Most popular /
/// A–Z / Recent" pills so every "choose a bank" surface (the shared
/// [BankPickerSheet], the send-funds recipient screen, split-bills, payroll,
/// batch transfers …) sorts identically and shares the same usage signals.
enum BankSort { mostUsed, popular, alphabetical, recent }

/// Curated popularity ranking for Nigerian banks (lower index = more popular).
/// Fintech/mobile banks lead — they dominate P2P volume — followed by the big
/// commercial banks. Matched case-insensitively against the bank name; anything
/// not listed sorts after the ranked ones, alphabetically.
const List<String> kPopularNgBanks = [
  'opay',
  'palmpay',
  'moniepoint',
  'kuda',
  'guaranty trust', // GTBank / GTCO
  'gtbank',
  'access bank',
  'zenith bank',
  'united bank for africa', // UBA
  'first bank',
  'fidelity bank',
  'union bank',
  'fcmb', // First City Monument Bank
  'sterling bank',
  'stanbic ibtc',
  'wema bank',
  'ecobank',
  'polaris bank',
  'keystone bank',
  'providus bank',
];

int popularRank(String name) {
  final n = name.toLowerCase();
  for (var i = 0; i < kPopularNgBanks.length; i++) {
    if (n.contains(kPopularNgBanks[i])) return i;
  }
  return kPopularNgBanks.length; // unlisted → after all ranked banks
}

/// Return a NEW sorted copy of [banks] per [sort]. [recentCodes] is the user's
/// most-recently-used bank codes (newest first) for the "recent" option.
List<Map<String, String>> sortBanks(
  List<Map<String, String>> banks,
  BankSort sort,
  List<String> recentCodes, {
  List<String> mostUsedCodes = const [],
}) {
  final list = List<Map<String, String>>.from(banks);
  switch (sort) {
    case BankSort.mostUsed:
      int usedIdx(Map<String, String> b) {
        final i = mostUsedCodes.indexOf(b['code'] ?? '');
        return i < 0 ? mostUsedCodes.length : i;
      }
      list.sort((a, b) {
        final byUsed = usedIdx(a).compareTo(usedIdx(b));
        if (byUsed != 0) return byUsed;
        // No usage yet (or a tie) → fall back to popularity so a new user still
        // sees a sensible list under the "Most used" pill.
        return popularRank(a['name'] ?? '')
            .compareTo(popularRank(b['name'] ?? ''));
      });
    case BankSort.alphabetical:
      list.sort((a, b) => (a['name'] ?? '')
          .toLowerCase()
          .compareTo((b['name'] ?? '').toLowerCase()));
    case BankSort.recent:
      int recentIdx(Map<String, String> b) {
        final i = recentCodes.indexOf(b['code'] ?? '');
        return i < 0 ? recentCodes.length : i;
      }
      list.sort((a, b) {
        final byRecent = recentIdx(a).compareTo(recentIdx(b));
        if (byRecent != 0) return byRecent;
        // Ties (both unused) fall back to popularity so the list still reads well.
        return popularRank(a['name'] ?? '')
            .compareTo(popularRank(b['name'] ?? ''));
      });
    case BankSort.popular:
      list.sort((a, b) {
        final byRank =
            popularRank(a['name'] ?? '').compareTo(popularRank(b['name'] ?? ''));
        if (byRank != 0) return byRank;
        return (a['name'] ?? '')
            .toLowerCase()
            .compareTo((b['name'] ?? '').toLowerCase());
      });
  }
  return list;
}

/// Per-user most-recently-used bank codes for the picker's "Recent" sort.
///
/// The MRU is a personal signal, so it is namespaced by the signed-in user id —
/// a device-global key would leak one user's recent banks to the next user who
/// signs in on the same device. The base key matches the send-funds recipient
/// screen so recents recorded in either surface are shared.
class RecentBanks {
  RecentBanks._();

  static const String _baseKey = 'recent_bank_codes';

  static Future<String> _key() async {
    try {
      final userId = await serviceLocator<SecureStorageService>().getUserId();
      if (userId != null && userId.isNotEmpty) {
        return '${_baseKey}_$userId';
      }
    } catch (_) {/* fall back to the plain key */}
    return _baseKey;
  }

  /// Load the MRU bank codes (newest first). Best-effort — returns [] on error.
  static Future<List<String>> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(await _key()) ?? [];
    } catch (_) {
      return [];
    }
  }

  /// Remember a just-selected bank as most-recent (newest first, deduped, cap 8).
  static Future<void> record(String? code) async {
    if (code == null || code.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = await _key();
      final current = prefs.getStringList(key) ?? [];
      final next = [code, ...current.where((c) => c != code)].take(8).toList();
      await prefs.setStringList(key, next);
    } catch (_) {/* best-effort */}
  }
}

/// Per-user destination-bank FREQUENCY tally powering the "Most used" pill.
///
/// Distinct from [RecentBanks] (which is recency/MRU): this counts how often the
/// user actually SENDS to each bank, so their real go-to banks lead the picker.
/// It's incremented once per successful external transfer (at the transfer
/// success point) — the same signal the backend already records on
/// `transfer_recipients.transfer_count`, kept locally here so the pill is
/// instant + offline and doesn't ride the money-path proto. Per-user namespaced.
class MostUsedBanks {
  MostUsedBanks._();

  static const String _baseKey = 'most_used_bank_codes';

  static Future<String> _key() async {
    try {
      final userId = await serviceLocator<SecureStorageService>().getUserId();
      if (userId != null && userId.isNotEmpty) return '${_baseKey}_$userId';
    } catch (_) {/* fall back to the plain key */}
    return _baseKey;
  }

  /// Bank codes ordered by usage count, DESC. Best-effort — [] on error.
  static Future<List<String>> load() async {
    try {
      final counts = await _counts();
      final entries = counts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      return entries.map((e) => e.key).toList();
    } catch (_) {
      return [];
    }
  }

  /// Increment the usage count for [code] after a successful transfer.
  static Future<void> record(String? code) async {
    if (code == null || code.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = await _key();
      final counts = await _counts();
      counts[code] = (counts[code] ?? 0) + 1;
      await prefs.setString(key, jsonEncode(counts));
    } catch (_) {/* best-effort */}
  }

  static Future<Map<String, int>> _counts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(await _key());
    if (raw == null || raw.isEmpty) return <String, int>{};
    final decoded = jsonDecode(raw);
    final out = <String, int>{};
    if (decoded is Map) {
      decoded.forEach((k, v) {
        if (k is String && v is int) out[k] = v;
      });
    }
    return out;
  }

  /// Pull the server's authoritative frequent-banks (aggregated from the user's
  /// transfer history, cross-device) and merge into the local tally, taking the
  /// max per bank. Best-effort — a missing/failed endpoint leaves the local
  /// (per-device) tally in charge. GET /api/v1/payments/frequent-banks.
  static Future<void> syncFromBackend() async {
    try {
      final token = await serviceLocator<SecureStorageService>().getAccessToken();
      if (token == null || token.isEmpty) return;
      final uri =
          Uri.parse('${endpointRegistry.httpTransfer}/payments/frequent-banks');
      final resp = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 8));
      if (resp.statusCode != 200) return;
      final decoded = jsonDecode(resp.body);
      final banks = decoded is Map ? decoded['banks'] : decoded;
      if (banks is! List) return;
      final counts = await _counts();
      var changed = false;
      for (final b in banks) {
        if (b is! Map) continue;
        final code = (b['bank_code'] ?? b['bankCode'])?.toString();
        final rawCount = b['count'];
        // int64 is JSON-encoded as a string by grpc-gateway.
        final c = rawCount is int
            ? rawCount
            : int.tryParse('${rawCount ?? ''}') ?? 0;
        if (code == null || code.isEmpty || c <= 0) continue;
        if (c > (counts[code] ?? 0)) {
          counts[code] = c;
          changed = true;
        }
      }
      if (changed) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(await _key(), jsonEncode(counts));
      }
    } catch (_) {/* best-effort */}
  }
}
