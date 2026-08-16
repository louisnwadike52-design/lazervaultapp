import 'package:shorebird_code_push/shorebird_code_push.dart';

/// Thin, crash-proof wrapper around Shorebird's OTA code-push updater.
///
/// Re-added flag-gated + additive: plain store builds ship full, self-contained
/// binaries and NEVER touch Shorebird. This service is only meaningful when the
/// build was produced via `shorebird release` (see scripts/deploy_mobile.sh
/// --shorebird / --patch). On any other build `ShorebirdUpdater.isAvailable`
/// is false and every method here degrades to a safe no-op (returns
/// false/null/does nothing) — it MUST never throw.
///
/// Policy (shorebird.yaml has `auto_update: false`): we control patch lifecycle
/// explicitly — CHECK + DOWNLOAD in the background (on resume), then APPLY on the
/// NEXT restart. Code is never swapped mid-session, so a running money flow can't
/// have its logic changed underneath it.
///
/// The per-flavor `app_ids` in shorebird.yaml keep a patch pinned to its own tier
/// (dev/staging/prod), which — together with app_environment.dart resolving the
/// tier fail-closed to prod in release — prevents the original failure mode (a
/// dev-flavored patch overriding a prod store build).
class AppPatchService {
  AppPatchService();

  final ShorebirdUpdater _updater = ShorebirdUpdater();

  /// True only on a Shorebird-built (release + `shorebird release`) binary.
  /// False for every plain store/debug build → all other methods short-circuit.
  bool get isAvailable {
    try {
      return _updater.isAvailable;
    } catch (_) {
      return false;
    }
  }

  /// The patch number currently running, or null when none is installed / the
  /// updater isn't available. Never throws.
  Future<int?> currentPatchNumber() async {
    if (!isAvailable) return null;
    try {
      final patch = await _updater.readCurrentPatch();
      return patch?.number;
    } catch (_) {
      return null;
    }
  }

  /// True when a downloaded patch is staged and will take effect on the next
  /// cold start (i.e. the updater reports [UpdateStatus.restartRequired], or the
  /// next-boot patch differs from the current one). Used to gently nudge a
  /// restart. Never throws; false on non-Shorebird builds.
  Future<bool> isPatchReadyForRestart() async {
    if (!isAvailable) return false;
    try {
      final status = await _updater.checkForUpdate();
      if (status == UpdateStatus.restartRequired) return true;
      // Fallback: compare the next-boot patch against the running one. If a
      // patch was downloaded earlier this run, next != current even if a fresh
      // network check couldn't be made.
      final current = await _updater.readCurrentPatch();
      final next = await _updater.readNextPatch();
      return next?.number != current?.number;
    } catch (_) {
      return false;
    }
  }

  /// Background check-and-download: if a newer patch is available, download it so
  /// it's staged for the NEXT restart. Respects `auto_update: false` — this only
  /// stages the patch; it is applied on the next cold start, never mid-session.
  ///
  /// Fire-and-forget safe: returns true if a patch was downloaded/staged this
  /// call, false otherwise (including on non-Shorebird builds). Never throws.
  Future<bool> checkAndDownloadUpdate() async {
    if (!isAvailable) return false;
    try {
      final status = await _updater.checkForUpdate();
      if (status != UpdateStatus.outdated) return false;
      // Downloads the latest patch and stages it for the next restart.
      await _updater.update();
      return true;
    } catch (_) {
      // UpdateException / network / any failure — silently ignore; we'll retry
      // on the next resume. A failed OTA check must never disrupt the app.
      return false;
    }
  }
}
