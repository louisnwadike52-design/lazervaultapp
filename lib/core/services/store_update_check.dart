import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart' as play;
import 'package:package_info_plus/package_info_plus.dart';

/// ASKS THE STORE whether a newer version is actually available.
///
/// WHY THIS EXISTS. The update prompt used to be driven solely by
/// `app_latest_build_*`, a number an operator set. That number is only ever as
/// correct as the last person to remember it, and it has been wrong in both
/// directions:
///
///   * Too LOW — it sat at 343 for two releases, then at 353 while builds
///     354-358 shipped past it. Nobody was prompted to update for weeks.
///   * Too HIGH — a deploy published 478 while Play production served 477 and
///     the App Store served nothing at all, so every production user was shown
///     an update for a build they could not download.
///
/// The store knows the answer. Asking it removes the human step entirely, and
/// cannot announce something the store will not serve.
///
/// WHAT THIS DOES NOT DO: decide that an update is MANDATORY. Neither store
/// has an opinion on that, and a security fix has to be forceable regardless of
/// rollout state — so the blocking gate stays with the admin-configured
/// `app_min_build_*`. This only answers "is there something newer".
///
/// PER PLATFORM, because the two stores are genuinely different:
///
///   Android  Play In-App Updates. The store answers for THIS device and
///            install, so a staged rollout the device is not in correctly
///            reports no update.
///   iOS      the public iTunes Lookup endpoint, which returns the version
///            currently ON SALE. Apple offers no in-app update API, so this is
///            the standard equivalent.
///
/// EVERY FAILURE MEANS "NO UPDATE", never an error shown to the user. A store
/// that cannot be reached, a device offline, a build not installed from Play,
/// a bundle id with no listing — none of those are the user's problem, and an
/// update prompt is not urgent enough to interrupt anyone over.
class StoreUpdateResult {
  /// Whether the store says a newer version exists.
  final bool updateAvailable;

  /// Android only: the version code the store would install. Null elsewhere,
  /// and null when the store declined to say.
  final int? availableVersionCode;

  /// iOS only: the version string currently on sale (e.g. "1.0.2").
  final String? availableVersion;

  /// True when the check could not reach a verdict, so a caller knows to fall
  /// back to the admin-configured numbers rather than treat it as "up to date".
  final bool indeterminate;

  const StoreUpdateResult({
    this.updateAvailable = false,
    this.availableVersionCode,
    this.availableVersion,
    this.indeterminate = false,
  });

  static const StoreUpdateResult upToDate = StoreUpdateResult();
  static const StoreUpdateResult unknown =
      StoreUpdateResult(indeterminate: true);
}

class StoreUpdateCheck {
  const StoreUpdateCheck._();

  /// iTunes Lookup. Unauthenticated and cached by Apple for a few hours, which
  /// is well inside the time an App Store release takes to propagate anyway.
  static const String _itunesLookup = 'https://itunes.apple.com/lookup';

  /// How long to wait before giving up. Short on purpose: this runs at launch
  /// and must never be something the user waits behind.
  static const Duration _timeout = Duration(seconds: 6);

  static Future<StoreUpdateResult> check() async {
    if (kIsWeb) return StoreUpdateResult.upToDate;
    try {
      if (Platform.isAndroid) return await _android();
      if (Platform.isIOS) return await _ios();
    } catch (e) {
      // Deliberately swallowed. See the class doc: a failed probe is never
      // surfaced, and callers fall back to the admin-configured numbers.
      debugPrint('[StoreUpdateCheck] failed: $e');
      return StoreUpdateResult.unknown;
    }
    return StoreUpdateResult.upToDate;
  }

  static Future<StoreUpdateResult> _android() async {
    final info = await play.InAppUpdate.checkForUpdate().timeout(_timeout);
    final available =
        info.updateAvailability == play.UpdateAvailability.updateAvailable;
    if (!available) return StoreUpdateResult.upToDate;
    return StoreUpdateResult(
      updateAvailable: true,
      availableVersionCode: info.availableVersionCode,
    );
  }

  static Future<StoreUpdateResult> _ios() async {
    final pkg = await PackageInfo.fromPlatform();
    final uri = Uri.parse(
        '$_itunesLookup?bundleId=${pkg.packageName}&t=${DateTime.now().millisecondsSinceEpoch}');
    final resp = await http.get(uri).timeout(_timeout);
    if (resp.statusCode != 200) return StoreUpdateResult.unknown;

    final body = jsonDecode(resp.body);
    final results = (body is Map) ? body['results'] : null;
    if (results is! List || results.isEmpty) {
      // NO LISTING IS NOT AN ERROR, and it is not an update either. Our own
      // bundle id returns resultCount 0 today because the app has never been
      // released on the App Store (its only submission is still in review).
      // Reporting "unknown" here would make the caller fall back to the
      // admin-configured number, which is exactly the value that was wrong.
      return StoreUpdateResult.upToDate;
    }

    final storeVersion = (results.first as Map)['version']?.toString();
    if (storeVersion == null || storeVersion.isEmpty) {
      return StoreUpdateResult.unknown;
    }
    final newer = _isNewer(storeVersion, pkg.version);
    return StoreUpdateResult(
      updateAvailable: newer,
      availableVersion: newer ? storeVersion : null,
    );
  }

  /// Dotted numeric comparison, segment by segment.
  ///
  /// String comparison is wrong here and quietly so: "1.0.10" sorts BEFORE
  /// "1.0.9" lexically, so the tenth patch of a release would read as older
  /// than the ninth and the prompt would never appear. Missing segments count
  /// as zero, so "1.1" and "1.1.0" are the same version. A non-numeric segment
  /// (a build tag such as "1.2.0-rc1") makes the whole comparison give up
  /// rather than guess — returning false means "no update", which is the safe
  /// direction for a prompt nobody asked for.
  static bool _isNewer(String store, String running) {
    final a = store.split('.');
    final b = running.split('.');
    final len = a.length > b.length ? a.length : b.length;
    for (var i = 0; i < len; i++) {
      final x = i < a.length ? int.tryParse(a[i]) : 0;
      final y = i < b.length ? int.tryParse(b[i]) : 0;
      if (x == null || y == null) return false;
      if (x != y) return x > y;
    }
    return false;
  }
}
