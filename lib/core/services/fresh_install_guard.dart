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

  static const String _kInstalledBuildKey =
      'fresh_install_guard.installed_build';

  /// Must match DeviceService._deviceIdKey. Duplicated rather than imported to
  /// keep this guard dependency-free — it runs before DI is wired. The pair is
  /// pinned by fresh_install_guard_test.dart.
  static const String _kDeviceIdKey = 'device_id';

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

      // THE DEVICE IDENTITY IS NOT STALE STATE — CARRY IT ACROSS THE WIPE.
      //
      // This guard exists to purge leftover SESSION state: tokens, cached
      // endpoints, feature flags. The device id is none of those. It is this
      // installation's name, and the backend now decides "is this a known
      // device" from it alone (auth-service risk_engine.go — location is no
      // longer a gate).
      //
      // So wiping it does not clear stale state, it changes who the device IS:
      // every user would be a brand-new device after an update and would be
      // sent an email OTP. That is the cost this guard was already disabled
      // for ("forced users to re-login ... on every app update"), and it would
      // now land harder than when that note was written.
      //
      // Read before, restore after. The guard is currently a no-op at the call
      // site, but it is deliberately kept for quick re-enabling, so it has to
      // be correct the day someone does.
      String? deviceId;
      try {
        deviceId = await secure.read(key: _kDeviceIdKey);
      } catch (_) {/* fall through to the prefs copy */}
      deviceId ??= prefs.getString(_kDeviceIdKey);

      try {
        await secure.deleteAll();
      } catch (_) {/* keychain quirks must not block */}
      await prefs.clear();
      // Re-stamp the current build AFTER clearing so the next launch is a no-op.
      await prefs.setString(_kInstalledBuildKey, current);
      if (deviceId != null && deviceId.isNotEmpty) {
        await prefs.setString(_kDeviceIdKey, deviceId);
        try {
          await secure.write(key: _kDeviceIdKey, value: deviceId);
        } catch (_) {/* the prefs copy alone keeps the identity stable */}
      }

      if (kDebugMode) {
        // ignore: avoid_print
        print('[FreshInstallGuard] build changed '
            '(${stored ?? "fresh install"} → $current), cleared local storage');
      }
      return true;
    } catch (_) {
      // Never let this brick startup.
      return false;
    }
  }
}
