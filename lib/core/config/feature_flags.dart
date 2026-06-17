import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight client-side feature-flag cache.
///
/// Backed by SharedPreferences so admin-side flips survive cold-start, and
/// re-hydrated from the admin/system_settings endpoint on each app launch
/// (call [FeatureFlags.refresh] from a startup hook that has the cached
/// settings map — same place the EndpointRegistry refresh is wired).
///
/// New flags should be:
///   1) Declared as a `static const String` key.
///   2) Exposed via a getter that returns the SharedPreferences value, with
///      a safe default if the key hasn't been seeded yet.
///   3) Hidden-by-default if exposing the surface costs us anything.
class FeatureFlags {
  // ── Existing flags ────────────────────────────────────────────────────────
  static const String useNewTransferApi = 'use_new_transfer_api';

  // ── Dashboard section visibility (admin-toggled) ──────────────────────────
  // Key the admin-side system_settings table uses. The toggle is intentionally
  // OFF by default — the Cards card on the dashboard is hidden from the user
  // until the admin flips the flag from Flutter Service Configs in the
  // admin dashboard. Code path is otherwise unchanged, so flipping the flag
  // back to true restores the section without redeploy.
  static const String dashboardCardsSectionVisible =
      'dashboard_cards_section_visible';

  static SharedPreferences? _prefs;

  /// Called once from app boot (after SharedPreferences is available) so the
  /// synchronous getters below don't have to await. Idempotent.
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Apply a fresh batch of flags pulled from the admin endpoint. The map is
  /// the same shape as the `url_*` cache the EndpointRegistry already
  /// refreshes — just `key → "true"/"false"`. Silently ignores unknown keys.
  static Future<void> applyRemoteSnapshot(Map<String, String> remote) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    for (final key in <String>[dashboardCardsSectionVisible]) {
      final v = remote[key];
      if (v == null) continue;
      await prefs.setBool(key, v.toLowerCase() == 'true');
    }
  }

  // ── Existing transfer-API helpers ────────────────────────────────────────
  static bool isUsingNewTransferApi() {
    return _prefs?.getBool(useNewTransferApi) ?? false;
  }

  static void enableNewTransferApi() {
    _prefs?.setBool(useNewTransferApi, true);
  }

  // ── Dashboard cards visibility ───────────────────────────────────────────
  /// `false` by default so the Cards section stays hidden until an admin
  /// enables it from Flutter Service Configs. Synchronous read — must be
  /// called after [init].
  static bool get dashboardCardsVisible {
    return _prefs?.getBool(dashboardCardsSectionVisible) ?? false;
  }
}
