import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared bank-picker sort model + Nigerian popularity ranking + per-user MRU
/// store. This is the SINGLE source of truth for the "Most popular / A–Z /
/// Recent" pills so every "choose a bank" surface (the shared [BankPickerSheet],
/// the send-funds recipient screen, split-bills, payroll, batch transfers …)
/// sorts identically and shares the same recently-used list.
enum BankSort { popular, alphabetical, recent }

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
  List<String> recentCodes,
) {
  final list = List<Map<String, String>>.from(banks);
  switch (sort) {
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
