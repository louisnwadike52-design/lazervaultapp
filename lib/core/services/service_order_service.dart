import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The user's HAND-PLACED quick-service order.
///
/// This is the counterpart to [ServiceUsageService]: usage ordering is a guess
/// the app makes, this is an instruction the user gave. So it wins — and the
/// moment a user drags a tile, adaptive ordering is switched off, because
/// leaving it on would let the next usage tally quietly undo the arrangement
/// they just made by hand. Nothing is more annoying than a layout that moves
/// after you have arranged it.
///
/// Design mirrors [ServiceUsageService] deliberately:
///  * LOCAL SharedPreferences (`service_order_<uid>`) is the source of truth for
///    the on-screen sort — synchronous and offline-safe, so the grid never waits
///    on a network round-trip to render the order the user just set.
///  * Every save ALSO fires a best-effort PUT to statistics-gateway, and
///    [syncFromBackend] seeds a fresh device (cross-device continuity).
///  * Everything is fire-and-forget. A missing or failing endpoint must never
///    throw into the UI or lose the local arrangement — the user's drag has
///    already been honoured on screen before the network is touched.
class ServiceOrderService {
  ServiceOrderService(this._storage);

  final SecureStorageService _storage;

  /// Ordered service keys (AppServiceName.name). Empty = no custom order, so
  /// the default (revenue/adaptive) ordering applies.
  List<String> _order = <String>[];
  String? _loadedForUser;
  bool _loading = false;

  static const _prefsPrefix = 'service_order_';

  // ── Read (synchronous, for the grid sort) ──────────────────────────────────

  /// The user's order as a rank map (service → position). Empty when the user
  /// has never arranged their services.
  ///
  /// Synchronous like [ServiceUsageService.counts]: returns what is in memory
  /// and lazily kicks off the load, so the next rebuild has it.
  Map<AppServiceName, int> ranks() {
    if (_loadedForUser == null && !_loading) {
      unawaited(ensureLoaded());
    }
    if (_order.isEmpty) return const <AppServiceName, int>{};
    final byName = {for (final s in AppServiceName.values) s.name: s};
    final out = <AppServiceName, int>{};
    for (var i = 0; i < _order.length; i++) {
      final s = byName[_order[i]];
      if (s != null) out[s] = i;
    }
    return out;
  }

  bool get hasCustomOrder => _order.isNotEmpty;

  // ── Load / persist ─────────────────────────────────────────────────────────

  Future<void> ensureLoaded() async {
    if (_loading) return;
    _loading = true;
    try {
      final uid = await _storage.getUserId();
      if (uid == null || uid.isEmpty) return;
      if (_loadedForUser == uid) return;
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('$_prefsPrefix$uid');
      _order = <String>[];
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _order = decoded.whereType<String>().toList();
        }
      }
      _loadedForUser = uid;
    } catch (_) {
      // A corrupt cache must not brick the dashboard — fall back to no custom
      // order, which is the pre-feature behaviour.
      _order = <String>[];
    } finally {
      _loading = false;
    }
  }

  /// Persist a new arrangement.
  ///
  /// Writes locally FIRST and bumps the dashboard revision so the grid reflects
  /// the drop immediately; the backend is told afterwards and its failure is
  /// invisible to the user. Also turns adaptive ordering OFF — see the class
  /// doc: an explicit arrangement must not be re-sorted by a later tally.
  Future<void> saveOrder(List<AppServiceName> services) async {
    _order = services.map((s) => s.name).toList();
    // Local + flag first: the drag is already on screen, so nothing here may
    // fail in a way that reverts it.
    try {
      final uid = await _storage.getUserId();
      if (uid != null && uid.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('$_prefsPrefix$uid', jsonEncode(_order));
        _loadedForUser = uid;
      }
    } catch (_) {/* keep the in-memory order regardless */}

    if (FeatureFlags.adaptiveQuickServices) {
      await FeatureFlags.setAdaptiveQuickServices(false);
    } else {
      FeatureFlags.dashboardLayoutRevision.value++;
    }

    unawaited(_pushToBackend());
  }

  /// Drop the custom order (back to adaptive/revenue ordering).
  Future<void> clearOrder() async {
    _order = <String>[];
    try {
      final uid = await _storage.getUserId();
      if (uid != null && uid.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('$_prefsPrefix$uid');
      }
    } catch (_) {/* ignore */}
    FeatureFlags.dashboardLayoutRevision.value++;
    unawaited(_pushToBackend());
  }

  // ── Backend sync (best-effort) ─────────────────────────────────────────────

  Future<void> _pushToBackend() async {
    try {
      final token = await _storage.getAccessToken();
      if (token == null || token.isEmpty) return;
      final uri = Uri.parse(
          '${endpointRegistry.httpStatistics}/statistics/service-order');
      await http
          .put(uri,
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'order': _order}))
          .timeout(const Duration(seconds: 8));
    } catch (_) {
      // Offline, or the endpoint isn't deployed yet. The local order still
      // stands; the next save re-pushes the whole list, so nothing is lost.
    }
  }

  /// Seed this device from the server. Called on login/dashboard load.
  ///
  /// The LOCAL order wins when present: it is either the same arrangement or a
  /// newer one made on this device, and silently replacing a user's layout with
  /// another device's is worse than being briefly out of date.
  Future<void> syncFromBackend() async {
    try {
      await ensureLoaded();
      if (_order.isNotEmpty) return;
      final token = await _storage.getAccessToken();
      if (token == null || token.isEmpty) return;
      final uri = Uri.parse(
          '${endpointRegistry.httpStatistics}/statistics/service-order');
      final resp = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 8));
      if (resp.statusCode != 200) return;
      final decoded = jsonDecode(resp.body);
      if (decoded is! Map) return;
      final list = decoded['order'];
      if (list is! List) return;
      final incoming = list.whereType<String>().toList();
      if (incoming.isEmpty) return;
      _order = incoming;
      final uid = await _storage.getUserId();
      if (uid != null && uid.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('$_prefsPrefix$uid', jsonEncode(_order));
        _loadedForUser = uid;
      }
      FeatureFlags.dashboardLayoutRevision.value++;
    } catch (_) {
      // Never blocks login or the dashboard.
    }
  }
}
