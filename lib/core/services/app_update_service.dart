import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'store_update_check.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/app_version_compare.dart';

/// Severity of an available app update.
enum AppUpdateType {
  /// Running build is current (or no config / unsupported platform) — no prompt.
  none,

  /// A newer build is available but the running build is still supported —
  /// show a dismissible banner + a one-time modal.
  optional,

  /// Running build is below the admin-configured minimum supported build —
  /// show a blocking, non-dismissible update gate.
  forced,
}

/// Immutable result of an update check, carrying everything the UI needs.
@immutable
class AppUpdateInfo {
  final AppUpdateType type;
  final int currentBuild;
  final int latestBuild;
  final int minBuild;
  final String latestVersion;
  final String notes;
  final String storeUrl;
  final bool isIOS;

  const AppUpdateInfo({
    required this.type,
    required this.currentBuild,
    required this.latestBuild,
    required this.minBuild,
    required this.latestVersion,
    required this.notes,
    required this.storeUrl,
    required this.isIOS,
  });

  /// Identifies the version this prompt is ABOUT, for the "show it once"
  /// check.
  ///
  /// It cannot just be the build number. On iOS the store answer is a VERSION
  /// STRING — the iTunes lookup returns "1.0.2", never a build — and
  /// app_latest_build_ios is legitimately 0 whenever nothing has been released
  /// there yet (it is 0 right now). Keying the de-dupe on the build alone meant
  /// `latestBuild <= 0` short-circuited to "already seen", so the store could
  /// report an update and the modal would never appear on iOS at all.
  ///
  /// Prefixed so a build and a version can never collide in the same pref.
  String get dedupeToken {
    if (latestBuild > 0) return 'b$latestBuild';
    if (latestVersion.trim().isNotEmpty) return 'v${latestVersion.trim()}';
    return '';
  }

  static const AppUpdateInfo none = AppUpdateInfo(
    type: AppUpdateType.none,
    currentBuild: 0,
    latestBuild: 0,
    minBuild: 0,
    latestVersion: '',
    notes: '',
    storeUrl: '',
    isIOS: false,
  );
}

/// Compares the running app build against the admin-configured latest/minimum
/// build numbers (resolved from [FeatureFlags], which the EndpointRegistry
/// background-refreshes on every launch) and decides whether to prompt the user
/// to update via the store.
///
/// This is a pure, local, non-blocking check — it reads already-cached config
/// plus the local [PackageInfo]; it never makes a network call on the hot path.
/// OTA code-push handles Dart-only OTA patches separately;
/// this service covers native/store updates OTA code-push can't deliver.
class AppUpdateService {
  AppUpdateService();

  /// Fallback store links used only when the admin hasn't configured one.
  ///
  /// ANDROID is a real, verified listing: com.lazervault.app resolves to a
  /// live Play Store page (HTTP 200, checked 31 Oct 2026), and the package
  /// name matches `applicationId` in android/app/build.gradle.kts.
  ///
  /// IOS IS DELIBERATELY EMPTY. An App Store link needs the app's NUMERIC
  /// Apple ID — `https://apps.apple.com/app/id123456789`. There is no
  /// name-based form: the previous default here,
  /// `https://apps.apple.com/app/lazervault`, was not a real URL and 404s.
  /// The ID cannot be looked up yet either — iTunes Lookup returns
  /// resultCount 0 for this bundle in every storefront, because the build is
  /// still TestFlight-only and the public listing does not exist.
  ///
  /// Sending a user to a 404 during a FORCED update is worse than sending
  /// them nowhere: the app looks broken and there is nothing they can do. So
  /// this stays empty and [openStore] refuses it, until someone pastes the
  /// real ID into Settings → App Versions. It is on the App Store Connect
  /// listing under App Information → General Information → "Apple ID".
  static const String _defaultIosStoreUrl = '';
  static const String _defaultAndroidStoreUrl =
      'https://play.google.com/store/apps/details?id=com.lazervault.app';

  /// SharedPreferences key holding the latest build the one-time optional modal
  /// has already been shown for, so we never nag for the same version twice.
  static const String _seenBuildKey = 'app_update_seen_build';

  /// Token form of the same idea, so a version-string answer (iOS) de-dupes
  /// just as well as a build-number one (Android). See [AppUpdateInfo.dedupeToken].
  static const String _seenTokenKey = 'app_update_seen_token';

  /// Resolve the running build number, the configured targets, and the update
  /// severity. Safe on every platform — returns [AppUpdateInfo.none] on web /
  /// desktop (no store) or when nothing is configured.
  Future<AppUpdateInfo> check() async {
    final bool isIOS = !kIsWeb && Platform.isIOS;
    final bool isAndroid = !kIsWeb && Platform.isAndroid;
    if (!isIOS && !isAndroid) return AppUpdateInfo.none;

    int currentBuild = 0;
    String currentVersion = '';
    try {
      final info = await PackageInfo.fromPlatform();
      currentBuild = int.tryParse(info.buildNumber.trim()) ?? 0;
      // THE VERSION STRING, NOT JUST THE BUILD. A release can raise either —
      // 1.0.1 -> 1.0.2, or the build alone — and on iOS the build is often
      // unusable (app_latest_build_ios is 0 until something ships there, and
      // the App Store's own lookup answers with a version string). Without
      // this the version dimension could not be compared at all.
      currentVersion = info.version.trim();
    } catch (_) {
      // PackageInfo can fail in odd embeddings; treat as unknown → no prompt.
      return AppUpdateInfo.none;
    }

    int latestBuild = FeatureFlags.appLatestBuild(isIOS: isIOS);
    final int minBuild = FeatureFlags.appMinBuild(isIOS: isIOS);
    final String storeUrl = _resolveStoreUrl(isIOS);
    final String notes = FeatureFlags.appUpdateNotes;
    String latestVersion = FeatureFlags.appLatestVersion(isIOS: isIOS);

    AppUpdateType type;
    // A MANDATORY UPDATE MUST POINT AT A BUILD THAT EXISTS.
    //
    // The floor stays the OPERATOR'S decision and is still not asked of the
    // store — neither store has a concept of "you must upgrade", and a
    // security fix has to be forceable whatever the rollout state says. What
    // is checked is cheaper and local: that the floor is not above the build
    // we have published as available.
    //
    // Without it, one wrong number locks every user out of an app they cannot
    // update: the ForcedUpdateScreen cannot be dismissed, and its Update
    // button opens a store page that says "Open", not "Update". There is no
    // way forward from that screen, on any device, until a server setting
    // changes.
    //
    // The server refuses such a floor too (guardAppMinBuild in admin-gateway,
    // which compares against the store-verified app_latest_build_*). This is
    // the second line: a floor written before that guard existed, or by any
    // path that bypasses it, still cannot brick an install.
    //
    // latestBuild <= 0 means we do not know what is available — and not
    // knowing is never grounds to force.
    final bool floorIsReachable = latestBuild > 0 && minBuild <= latestBuild;
    if (currentBuild > 0 && minBuild > 0 && currentBuild < minBuild &&
        floorIsReachable) {
      // Below minimum supported — block regardless of the optional toggle.
      type = AppUpdateType.forced;
    } else if (!FeatureFlags.appUpdateEnabled) {
      type = AppUpdateType.none;
    } else {
      // THE STORE IS ASKED FIRST for the optional prompt.
      //
      // app_latest_build_* is a number a human maintains, and it has been
      // wrong in both directions: stuck for weeks while builds shipped past
      // it, and once set to a build neither store served. The store knows
      // whether an update is actually installable by THIS device — including
      // whether a staged rollout has reached it — so it is the better answer
      // whenever it gives one.
      //
      // The configured number remains the fallback for the cases the store
      // cannot answer: a build not installed from Play (every debug and
      // sideloaded build), a device offline, or a lookup that fails. A
      // `upToDate` verdict is TRUSTED and ends it; only `indeterminate` falls
      // through, so a store that positively says "nothing newer" can no longer
      // be overruled by a stale admin value.
      final store = await StoreUpdateCheck.check();
      if (store.updateAvailable) {
        type = AppUpdateType.optional;
        // Carry the STORE's answer through, otherwise the prompt is about a
        // version nothing knows the name of: Android gives a version code,
        // iOS a version string, and the de-dupe + the "what's new" copy both
        // read from these.
        if (store.availableVersionCode != null) {
          latestBuild = store.availableVersionCode!;
        }
        if (store.availableVersion != null &&
            store.availableVersion!.isNotEmpty) {
          latestVersion = store.availableVersion!;
        }
      } else if (store.indeterminate) {
        // THE STORE COULD NOT ANSWER, SO FALL BACK TO THE ADMIN VALUES —
        // ON EITHER DIMENSION, AND STRICTLY GREATER IN BOTH.
        //
        // The build decides whenever both sides have one: it is a single
        // integer and unambiguous. It cannot always decide —
        // app_latest_build_ios sits at 0 until something ships there — so a
        // version-string comparison backs it up. That comparison is numeric
        // per segment (see compareAppVersions), because "1.0.10" sorts BELOW
        // "1.0.9" as a plain string and the tenth patch would never prompt.
        //
        // STRICTLY newer, never equal: telling someone to update to what they
        // already run is the fastest way to make the prompt feel broken, and
        // it is exactly what happens the moment an operator sets the latest
        // version to the build they are themselves testing.
        final buildSaysNewer =
            currentBuild > 0 && latestBuild > 0 && currentBuild < latestBuild;
        final buildCanDecide = currentBuild > 0 && latestBuild > 0;
        final versionSaysNewer = !buildCanDecide &&
            isNewerAppVersion(installed: currentVersion, latest: latestVersion);
        type = (buildSaysNewer || versionSaysNewer)
            ? AppUpdateType.optional
            : AppUpdateType.none;
      } else {
        type = AppUpdateType.none;
      }
    }

    return AppUpdateInfo(
      type: type,
      currentBuild: currentBuild,
      latestBuild: latestBuild,
      minBuild: minBuild,
      latestVersion: latestVersion,
      notes: notes,
      storeUrl: storeUrl,
      isIOS: isIOS,
    );
  }

  String _resolveStoreUrl(bool isIOS) {
    final configured = FeatureFlags.appStoreUrl(isIOS: isIOS);
    if (configured.isNotEmpty) return configured;
    return isIOS ? _defaultIosStoreUrl : _defaultAndroidStoreUrl;
  }

  /// Open the platform store so the user can update. Best-effort — returns
  /// `false` if the URL couldn't be launched.
  Future<bool> openStore(AppUpdateInfo info) async {
    // An empty or scheme-less URL is not something to hand to the OS. Before
    // this guard an unset iOS link reached launchUrl as a bare string and
    // opened a 404 page in Safari, which during a forced update leaves the
    // user staring at a broken App Store page with no way forward.
    final raw = info.storeUrl.trim();
    if (raw.isEmpty) return false;
    final uri = Uri.tryParse(raw);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) return false;
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Whether the one-time optional modal should be shown for [latestBuild]
  /// (i.e. it hasn't been shown for this build yet).
  Future<bool> shouldShowOptionalModal(AppUpdateInfo info) async {
    final token = info.dedupeToken;
    if (token.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();

    // MIGRATION: installs from before this was token-based hold an int under
    // the old key. Honouring it stops the modal reappearing once for everyone
    // who had already dismissed it — a small annoyance, but an avoidable one
    // and exactly the kind of thing that makes an update prompt feel broken.
    if (info.latestBuild > 0) {
      final legacy = prefs.getInt(_seenBuildKey) ?? 0;
      if (info.latestBuild <= legacy) return false;
    }

    return prefs.getString(_seenTokenKey) != token;
  }

  /// Record that the one-time optional modal has been shown for [info].
  Future<void> markOptionalModalSeen(AppUpdateInfo info) async {
    final token = info.dedupeToken;
    if (token.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_seenTokenKey, token);
    // Kept in step so a downgrade to an older build of the app still de-dupes.
    if (info.latestBuild > 0) {
      await prefs.setInt(_seenBuildKey, info.latestBuild);
    }
  }
}
