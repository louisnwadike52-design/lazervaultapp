import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lazervault/core/config/feature_flags.dart';

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
/// Shorebird handles Dart-only OTA patches separately (see docs/SHOREBIRD.md);
/// this service covers native/store updates Shorebird can't deliver.
class AppUpdateService {
  AppUpdateService();

  /// Fallback store links used only when the admin hasn't configured one.
  static const String _defaultIosStoreUrl =
      'https://apps.apple.com/app/lazervault';
  static const String _defaultAndroidStoreUrl =
      'https://play.google.com/store/apps/details?id=com.lazervault.app';

  /// SharedPreferences key holding the latest build the one-time optional modal
  /// has already been shown for, so we never nag for the same version twice.
  static const String _seenBuildKey = 'app_update_seen_build';

  /// Resolve the running build number, the configured targets, and the update
  /// severity. Safe on every platform — returns [AppUpdateInfo.none] on web /
  /// desktop (no store) or when nothing is configured.
  Future<AppUpdateInfo> check() async {
    final bool isIOS = !kIsWeb && Platform.isIOS;
    final bool isAndroid = !kIsWeb && Platform.isAndroid;
    if (!isIOS && !isAndroid) return AppUpdateInfo.none;

    int currentBuild = 0;
    try {
      final info = await PackageInfo.fromPlatform();
      currentBuild = int.tryParse(info.buildNumber.trim()) ?? 0;
    } catch (_) {
      // PackageInfo can fail in odd embeddings; treat as unknown → no prompt.
      return AppUpdateInfo.none;
    }

    final int latestBuild = FeatureFlags.appLatestBuild(isIOS: isIOS);
    final int minBuild = FeatureFlags.appMinBuild(isIOS: isIOS);
    final String storeUrl = _resolveStoreUrl(isIOS);
    final String notes = FeatureFlags.appUpdateNotes;
    final String latestVersion = FeatureFlags.appLatestVersion(isIOS: isIOS);

    AppUpdateType type;
    if (currentBuild > 0 && minBuild > 0 && currentBuild < minBuild) {
      // Below minimum supported — block regardless of the optional toggle.
      type = AppUpdateType.forced;
    } else if (FeatureFlags.appUpdateEnabled &&
        currentBuild > 0 &&
        latestBuild > 0 &&
        currentBuild < latestBuild) {
      type = AppUpdateType.optional;
    } else {
      type = AppUpdateType.none;
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
    final uri = Uri.tryParse(info.storeUrl);
    if (uri == null) return false;
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Whether the one-time optional modal should be shown for [latestBuild]
  /// (i.e. it hasn't been shown for this build yet).
  Future<bool> shouldShowOptionalModal(int latestBuild) async {
    if (latestBuild <= 0) return false;
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getInt(_seenBuildKey) ?? 0;
    return latestBuild > seen;
  }

  /// Record that the one-time optional modal has been shown for [latestBuild].
  Future<void> markOptionalModalSeen(int latestBuild) async {
    if (latestBuild <= 0) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_seenBuildKey, latestBuild);
  }
}
