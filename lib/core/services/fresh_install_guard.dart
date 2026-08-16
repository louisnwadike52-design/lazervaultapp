import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wipes ALL on-device app state (SharedPreferences + secure storage) whenever
/// the installed build changes — i.e. on a fresh install OR an app update.
///
/// WHY: a previous build (especially an old DEV-flavored build) can leave behind
/// a session/refresh-token, a cached backend URL, or feature-flag state that then
/// "sticks" into the newly-installed build — the classic "I updated but it still
/// logs into dev / shows old data" symptom. By keying off the exact
/// `version+build` string, the very first launch after ANY install/update starts
/// from a guaranteed-clean slate: no stale tokens, no cached dev endpoints.
///
/// Runs FIRST in `main()`, before dotenv / EndpointRegistry / DI / auth, so
/// nothing has read the stale state yet. Best-effort: never blocks startup.
class FreshInstallGuard {
  FreshInstallGuard._();

  static const String _kInstalledBuildKey = 'fresh_install_guard.installed_build';

  /// Clears all local storage when `version+build` differs from the last launch.
  /// Returns true if it wiped (new install/update), false if unchanged.
  static Future<bool> clearIfBuildChanged() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final info = await PackageInfo.fromPlatform();
      final current = '${info.version}+${info.buildNumber}';
      final stored = prefs.getString(_kInstalledBuildKey);

      if (stored == current) return false; // same build — nothing to clear

      // New install (stored == null) or update (stored != current) → wipe.
      // Secure storage holds the auth session (access/refresh tokens); prefs hold
      // cached URLs, feature flags, onboarding state, etc. Clear BOTH.
      const secure = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );
      try {
        await secure.deleteAll();
      } catch (_) {/* keychain quirks must not block */}
      await prefs.clear();
      // Re-stamp the current build AFTER clearing so the next launch is a no-op.
      await prefs.setString(_kInstalledBuildKey, current);

      if (kDebugMode) {
        // ignore: avoid_print
        print('[FreshInstallGuard] build changed '
            '(${stored ?? "fresh install"} → $current) — cleared local storage');
      }
      return true;
    } catch (_) {
      // Never let this brick startup.
      return false;
    }
  }
}
