import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Per-user quick-service usage tally that powers adaptive dashboard ordering.
///
/// Design:
///  * A LOCAL, per-user SharedPreferences-backed counter (`service_usage_<uid>`)
///    is the source of truth for the on-screen re-sort — it's synchronous and
///    offline-safe, so the grid never waits on the network to reorder.
///  * Every record ALSO fires a best-effort POST to statistics-gateway, and a
///    login/dashboard-load [syncFromBackend] pulls the server's top-N to seed a
///    fresh device (cross-device continuity).
///  * Everything is fire-and-forget: a failed/absent backend never blocks
///    navigation or throws into the UI. Tracking only happens while the user
///    has adaptive quick services turned on ([FeatureFlags.adaptiveQuickServices]).
class ServiceUsageService {
  ServiceUsageService(this._storage);

  final SecureStorageService _storage;

  final Map<String, int> _counts = <String, int>{}; // key = AppServiceName.name
  String? _loadedForUser;
  bool _loading = false;

  static const _prefsPrefix = 'service_usage_';

  // ── Read (synchronous, for the grid sort) ──────────────────────────────────

  /// Current per-service counts as an [AppServiceName]→count map. Synchronous:
  /// returns whatever is loaded in memory (empty until [ensureLoaded] resolves,
  /// which is kicked off lazily here so the next rebuild has data).
  Map<AppServiceName, int> counts() {
    if (_loadedForUser == null && !_loading) {
      // Fire the load; a later rebuild (dashboardLayoutRevision bump) picks it up.
      unawaited(ensureLoaded());
    }
    final out = <AppServiceName, int>{};
    for (final s in AppServiceName.values) {
      final c = _counts[s.name];
      if (c != null && c > 0) out[s] = c;
    }
    return out;
  }

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
      _counts.clear();
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is Map) {
          decoded.forEach((k, v) {
            if (k is String && v is int) _counts[k] = v;
          });
        }
      }
      _loadedForUser = uid;
    } catch (_) {
      // best-effort — leave counts empty on any read error
    } finally {
      _loading = false;
    }
  }

  Future<void> _persist() async {
    try {
      final uid = _loadedForUser ?? await _storage.getUserId();
      if (uid == null || uid.isEmpty) return;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('$_prefsPrefix$uid', jsonEncode(_counts));
    } catch (_) {/* best-effort */}
  }

  // ── Record (on service open, adaptive ON) ──────────────────────────────────

  /// Increment usage for [service] (local, instant) and fire a best-effort
  /// backend POST. No-op when adaptive quick services is off.
  Future<void> record(AppServiceName service) async {
    if (!FeatureFlags.adaptiveQuickServices) return;
    await ensureLoaded();
    _counts[service.name] = (_counts[service.name] ?? 0) + 1;
    await _persist();
    // Live re-sort of the visible grid.
    FeatureFlags.dashboardLayoutRevision.value++;
    unawaited(_postUsage(service));
  }

  Future<void> _postUsage(AppServiceName service) async {
    try {
      final token = await _storage.getAccessToken();
      if (token == null || token.isEmpty) return;
      final uri = Uri.parse(
          '${endpointRegistry.httpStatistics}/statistics/service-usage');
      await http
          .post(uri,
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'service_key': service.name}))
          .timeout(const Duration(seconds: 6));
    } catch (_) {/* fire-and-forget */}
  }

  // ── Sync from backend (login / dashboard load, adaptive ON) ─────────────────

  /// Pull the server's top-N usage and merge into the local tally (taking the
  /// max per service) so a fresh device inherits the user's history. Best-effort.
  Future<void> syncFromBackend() async {
    if (!FeatureFlags.adaptiveQuickServices) return;
    try {
      await ensureLoaded();
      final token = await _storage.getAccessToken();
      if (token == null || token.isEmpty) return;
      final uri = Uri.parse(
          '${endpointRegistry.httpStatistics}/statistics/service-usage');
      final resp = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 8));
      if (resp.statusCode != 200) return;
      final decoded = jsonDecode(resp.body);
      final items = decoded is Map ? decoded['items'] ?? decoded['usage'] : decoded;
      if (items is! List) return;
      var changed = false;
      for (final it in items) {
        if (it is! Map) continue;
        final key = (it['service_key'] ?? it['serviceKey'])?.toString();
        final cnt = it['count'];
        if (key == null || key.isEmpty || cnt is! int) continue;
        final local = _counts[key] ?? 0;
        if (cnt > local) {
          _counts[key] = cnt;
          changed = true;
        }
      }
      if (changed) {
        await _persist();
        FeatureFlags.dashboardLayoutRevision.value++;
      }
    } catch (_) {/* best-effort */}
  }
}

/// Convenience accessor used by the grid.
ServiceUsageService get serviceUsage => serviceLocator<ServiceUsageService>();
