import 'package:shorebird_code_push/shorebird_code_push.dart';

/// Thin wrapper around Shorebird's read-only code-push API.
///
/// Shorebird downloads Dart-only patches in the background and applies them on
/// the next app restart automatically — this service only *observes* that
/// state so the UI can show a gentle "Update ready — restart to apply" nudge.
/// It never forces a restart and is a complete no-op when the app wasn't built
/// with the Shorebird CLI (e.g. a plain `flutter run`), so it's always safe to
/// call. See docs/SHOREBIRD.md for the release/patch workflow.
class AppPatchService {
  final ShorebirdUpdater _updater = ShorebirdUpdater();

  /// Whether the Shorebird updater is present in this build. False for plain
  /// `flutter build`/`flutter run` (non-Shorebird) artefacts.
  bool get isAvailable => _updater.isAvailable;

  /// True when a patch has been downloaded in the background and is staged to
  /// take effect on the next restart. Safe to call anywhere — returns false on
  /// non-Shorebird builds or any error.
  Future<bool> isPatchReadyForRestart() async {
    if (!_updater.isAvailable) return false;
    try {
      final status = await _updater.checkForUpdate();
      return status == UpdateStatus.restartRequired;
    } catch (_) {
      return false;
    }
  }

  /// The currently-installed patch number, or null when none / unavailable.
  Future<int?> currentPatchNumber() async {
    if (!_updater.isAvailable) return null;
    try {
      final patch = await _updater.readCurrentPatch();
      return patch?.number;
    } catch (_) {
      return null;
    }
  }
}
