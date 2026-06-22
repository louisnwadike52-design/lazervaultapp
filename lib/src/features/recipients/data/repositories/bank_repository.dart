import 'dart:convert';

import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/src/features/open_banking/data/datasources/open_banking_remote_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Single source for the selectable bank list.
///
/// Fetches the live list from the backend (`/api/v1/banks`, which the
/// banking-service now serves from Flutterwave — the SAME provider that
/// executes payouts, so each `code` is valid for a transfer's `account_bank`),
/// caches it in `SharedPreferences` for 24h, and falls back to the bundled
/// static [BanksData] list when offline or on any error. Banks are returned as
/// `{'name': ..., 'code': ...}` maps to match the existing dropdown shape.
///
/// Only Nigeria (`NG`) has a dynamic backend source today; other countries
/// always use the static list.
class BankRepository {
  BankRepository(this._remote, this._storage);

  final OpenBankingRemoteDataSource _remote;
  final SecureStorageService _storage;

  static const Duration _ttl = Duration(hours: 24);

  /// In-memory cache of the last dynamic list per country, so synchronous
  /// callers (bottom-sheet pickers built inline) can read the Flutterwave list
  /// without an async gap. Populated by every dynamic read; never holds the
  /// static list.
  final Map<String, List<Map<String, String>>> _mem = {};

  String _cacheKey(String country) => 'banks_cache_${country.toUpperCase()}';
  String _cacheAtKey(String country) => 'banks_cache_at_${country.toUpperCase()}';

  /// Synchronous best-effort list: the in-memory dynamic list if the repository
  /// has been warmed this session, otherwise the bundled static list. Pair with
  /// [warmUp] (e.g. in a screen's initState) so the dynamic list is ready before
  /// the user opens a bank picker.
  List<Map<String, String>> cachedSync(String country) {
    final mem = _mem[country.toUpperCase()];
    if (mem != null && mem.isNotEmpty) return mem;
    return BanksData.getBanksForCountry(country);
  }

  /// Fire-and-forget warm of the in-memory + persistent cache for [country].
  Future<void> warmUp(String country) => getBanks(country);

  /// Immediate, synchronous-ish list for first paint: last cached list (any
  /// age) or the bundled static list. Never hits the network.
  Future<List<Map<String, String>>> cachedOrStatic(String country) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_cacheKey(country));
    final decoded = _tryDecode(raw);
    if (decoded != null && decoded.isNotEmpty) {
      _mem[country.toUpperCase()] = decoded;
      return decoded;
    }
    return BanksData.getBanksForCountry(country);
  }

  /// Returns the freshest list available: a fresh (<24h) cache, else a live
  /// fetch (cached on success), else a stale cache, else the static list.
  Future<List<Map<String, String>>> getBanks(String country) async {
    // Only NG has a dynamic backend source; others use static.
    if (country.toUpperCase() != 'NG') {
      return BanksData.getBanksForCountry(country);
    }

    final prefs = await SharedPreferences.getInstance();
    final cachedRaw = prefs.getString(_cacheKey(country));
    final cachedAt = prefs.getInt(_cacheAtKey(country)) ?? 0;
    final isFresh =
        DateTime.now().millisecondsSinceEpoch - cachedAt < _ttl.inMilliseconds;

    if (isFresh) {
      final decoded = _tryDecode(cachedRaw);
      if (decoded != null && decoded.isNotEmpty) {
        _mem[country.toUpperCase()] = decoded;
        return decoded;
      }
    }

    try {
      final token = await _storage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        final banks = await _remote.getBanks(accessToken: token);
        // NB: do NOT filter on isActive — the backend currently returns it as
        // false for every bank; the Flutterwave list is already curated to
        // transfer-eligible banks.
        final list = banks
            .where((b) => b.code.isNotEmpty && b.name.isNotEmpty)
            .map((b) => {'name': b.name, 'code': b.code})
            .toList();
        if (list.isNotEmpty) {
          await prefs.setString(_cacheKey(country), jsonEncode(list));
          await prefs.setInt(
            _cacheAtKey(country),
            DateTime.now().millisecondsSinceEpoch,
          );
          _mem[country.toUpperCase()] = list;
          return list;
        }
      }
    } catch (_) {
      // fall through to stale cache / static
    }

    final stale = _tryDecode(cachedRaw);
    if (stale != null && stale.isNotEmpty) return stale;
    return BanksData.getBanksForCountry(country);
  }

  List<Map<String, String>>? _tryDecode(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final arr = jsonDecode(raw) as List;
      return arr
          .map((e) => {
                'name': (e['name'] ?? '').toString(),
                'code': (e['code'] ?? '').toString(),
              })
          .where((m) => m['code']!.isNotEmpty && m['name']!.isNotEmpty)
          .toList();
    } catch (_) {
      return null;
    }
  }
}
