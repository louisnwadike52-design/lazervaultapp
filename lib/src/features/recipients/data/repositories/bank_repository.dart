import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/src/features/open_banking/data/datasources/open_banking_grpc_datasource.dart';
import 'package:lazervault/src/features/open_banking/data/datasources/open_banking_remote_datasource.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/withdrawal.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Single source for the selectable bank list.
///
/// Fetches the live list from the backend (`/api/v1/banks`), which serves it
/// from whichever rail is CURRENTLY carrying payouts — not from any particular
/// provider. That matters because bank codes are per-rail rather than a shared
/// standard: Kuda is 50211 on Flutterwave and 090267 on Nomba, and only ~39 of
/// the 155 codes in the bundled list resolve against Nomba at all. So each
/// `code` is valid for a transfer's `account_bank` only against the rail that
/// issued it, and the response names that rail.
///
/// The list is cached in `SharedPreferences` for 24h AND under the rail that
/// produced it, revalidated once per app session so a provider switch is picked
/// up on the next launch rather than up to a day later, and falls back to the
/// bundled static [BanksData] list when offline or on any error. Banks are
/// returned as `{'name': ..., 'code': ...}` maps to match the existing dropdown
/// shape.
///
/// NOTE on the static fallback: it is Flutterwave-shaped and contains no Nomba
/// entries, so on a Nomba rail it is a LAST resort that will mis-code fintech
/// destinations. It is still preferable to an empty picker, and the backend
/// refuses to resolve a code it does not recognise, so the failure is a
/// declined transfer rather than misrouted money.
///
/// Only Nigeria (`NG`) has a dynamic backend source today; other countries
/// always use the static list.
class BankRepository {
  BankRepository(this._remote, this._storage, {this.grpc});

  final OpenBankingRemoteDataSource _remote;
  final SecureStorageService _storage;

  /// PRIMARY transport for the directory.
  ///
  /// `GET /api/v1/banks` is implemented and correct on banking-service, but the
  /// public edge carried no ingress rule for that path, so through
  /// api.lazervault.app it fell to the catch-all gateway and answered
  /// `{"code":5,"message":"Not Found"}`. Measured 2026-10-03: REST 404 at the
  /// edge, 200 with 633 banks on the service itself, and gRPC
  /// `banking.BankingService/GetBanks` 200 with `provider=nomba` and
  /// `Kuda Microfinance Bank = 090267` through the SAME public hostname.
  ///
  /// So the transport that actually reaches the rail is gRPC, and REST is now
  /// the second attempt rather than the only one. Nullable so tests and any
  /// caller without a gRPC channel keep working.
  final OpenBankingGrpcDataSource? grpc;

  static const Duration _ttl = Duration(hours: 24);

  /// In-memory cache of the last dynamic list per country, so synchronous
  /// callers (bottom-sheet pickers built inline) can read the Flutterwave list
  /// without an async gap. Populated by every dynamic read; never holds the
  /// static list.
  final Map<String, List<Map<String, String>>> _mem = {};

  String _cacheKey(String country) => 'banks_cache_${country.toUpperCase()}';
  String _cacheAtKey(String country) =>
      'banks_cache_at_${country.toUpperCase()}';

  /// Which payout rail the cached list belongs to.
  ///
  /// Bank codes are NOT a shared standard — each rail publishes its own, and
  /// only ~39 of the 155 codes this app can send resolve against Nomba. So a
  /// list is meaningless without the name of the rail that issued it, and a
  /// cache that stores one without the other cannot tell when it has gone
  /// wrong.
  String _cacheProviderKey(String country) =>
      'banks_cache_provider_${country.toUpperCase()}';

  /// Countries already revalidated against the server in this app session.
  ///
  /// The 24h TTL alone let a provider switch go unnoticed for a full day: a
  /// fresh cache was served without ever asking the server, so the app kept
  /// offering the OLD rail's codes and every transfer to a fintech was refused
  /// while the screens looked perfectly normal. Revalidating once per session
  /// bounds that to a single app launch, and the TTL still does its real job of
  /// keeping the list off the network on every picker open.
  final Set<String> _revalidated = {};

  /// Bumped whenever the cached list is REPLACED because the rail changed, so
  /// a picker that is already open can repaint instead of showing codes that
  /// have just been invalidated underneath it.
  final ValueNotifier<int> listRevision = ValueNotifier<int>(0);

  /// The rail the in-memory list came from, for diagnostics and tests.
  String? providerOf(String country) => _memProvider[country.toUpperCase()];

  final Map<String, String> _memProvider = {};

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

    final key = country.toUpperCase();
    final cachedProvider = prefs.getString(_cacheProviderKey(country)) ?? '';

    // A fresh cache still serves immediately — but only ONCE per session is it
    // trusted without asking the server, so an admin's provider switch is
    // picked up on the next app launch instead of up to 24 hours later.
    if (isFresh && _revalidated.contains(key)) {
      final decoded = _tryDecode(cachedRaw);
      if (decoded != null && decoded.isNotEmpty) {
        _mem[key] = decoded;
        if (cachedProvider.isNotEmpty) _memProvider[key] = cachedProvider;
        return decoded;
      }
    }

    try {
      final token = await _storage.getAccessToken();
      if (token == null || token.isEmpty) {
        // Said out loud. A bank list fetched with no session silently falls
        // back to the bundled list, and on a non-Flutterwave rail every
        // fintech code in that list is wrong — so this is the difference
        // between a working transfer and a declined one.
        debugPrint('[banks] no access token — cannot refresh, using fallback');
      }
      if (token != null && token.isNotEmpty) {
        final sw = Stopwatch()..start();
        final res = await _fetchFromAnyTransport(token);
        debugPrint('[banks] fetched ${res.banks.length} banks '
            'from provider=${res.provider} in ${sw.elapsedMilliseconds}ms');
        // NB: do NOT filter on isActive — the backend currently returns it as
        // false for every bank; the rail's own list is already curated to
        // transfer-eligible banks.
        final list = res.banks
            .where((b) => b.code.isNotEmpty && b.name.isNotEmpty)
            .map((b) => {'name': b.name, 'code': b.code})
            .toList();
        if (list.isNotEmpty) {
          final railChanged = cachedProvider.isNotEmpty &&
              res.provider.isNotEmpty &&
              cachedProvider != res.provider;
          await prefs.setString(_cacheKey(country), jsonEncode(list));
          await prefs.setInt(
            _cacheAtKey(country),
            DateTime.now().millisecondsSinceEpoch,
          );
          await prefs.setString(_cacheProviderKey(country), res.provider);
          _mem[key] = list;
          if (res.provider.isNotEmpty) _memProvider[key] = res.provider;
          _revalidated.add(key);
          if (railChanged) {
            // The codes just changed meaning. Anything already painted from the
            // old rail is now wrong, so tell it to repaint.
            listRevision.value++;
          }
          return list;
        }
      }
    } catch (e) {
      // Name it. This used to fall through silently to a list whose codes the
      // active rail rejects, so a user saw a normal-looking bank picker and a
      // transfer that failed for no visible reason.
      debugPrint('[banks] refresh FAILED: $e — falling back');
    }

    final stale = _tryDecode(cachedRaw);
    if (stale != null && stale.isNotEmpty) {
      // A stale list from the SAME rail is fine — bank codes change a few
      // times a year, not hourly.
      debugPrint('[banks] serving stale cache from provider=$cachedProvider');
      return stale;
    }
    // LAST RESORT, and a knowingly wrong one on a non-Flutterwave rail.
    //
    // The bundled list is Flutterwave-shaped: Kuda is 50211 there and 090267
    // on Nomba, OPay 999992 vs 305, Moniepoint 50515 vs 090405. Only ~39 of
    // its 155 codes resolve against Nomba at all, and the ones that fail are
    // the most-used destinations in the country.
    //
    // It is still returned rather than nothing — an empty picker helps no one
    // and the backend refuses a code it cannot resolve, so the failure is a
    // declined transfer rather than misrouted money — but it is now ANNOUNCED,
    // because "the list looks normal and transfers fail" is the worst
    // possible shape for this bug and it is exactly what was reported.
    if (cachedProvider.isNotEmpty &&
        cachedProvider.toLowerCase() != 'flutterwave') {
      debugPrint('[banks] WARNING: falling back to the bundled Flutterwave '
          'list while the active rail is "$cachedProvider" — fintech codes '
          'in this list will be refused');
    }
    return BanksData.getBanksForCountry(country);
  }

  /// gRPC first, REST second.
  ///
  /// Both are tried on every refresh rather than one being picked up front,
  /// because the failure that caused this bug was invisible: REST 404'd at the
  /// edge while the service behind it was perfectly healthy, and the app
  /// quietly used its bundled Flutterwave list instead — which is how a user on
  /// the Nomba rail got a normal-looking picker full of codes Nomba refuses,
  /// and no Nombank row at all. If EITHER transport can reach the live
  /// directory, the user gets the live directory.
  Future<({List<Bank> banks, String provider})> _fetchFromAnyTransport(
    String token,
  ) async {
    var grpcFailed = false;
    if (grpc != null) {
      try {
        return await grpc!.getBanksWithProvider();
      } catch (e) {
        grpcFailed = true;
        debugPrint('[banks] gRPC GetBanks failed: $e — trying REST');
      }
    }
    try {
      return await _remote.getBanksWithProvider(accessToken: token);
    } catch (e) {
      if (grpcFailed) debugPrint('[banks] REST /banks also failed: $e');
      rethrow;
    }
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
