import 'dart:io';

/// Decides whether a device should use the on-device live auto-detect scan
/// (Google ML Kit) or fall back to the manual "tap to capture" flow.
///
/// On-device ML Kit text recognition hard-requires iOS 15.5+ (the app's minimum
/// deployment target is pinned to it for that reason). This gate keeps the scan
/// flow working on any device the app can run on:
///   • Auto-detect (ML Kit) — when the OS supports it AND ML Kit initialises.
///   • Tap-to-capture — otherwise; the captured image is sent to the per-service
///     chat OCR backend, which does the authoritative extraction.
///
/// The version check is the declared intent (and future-proofs a lower app
/// minimum), while [markAutoUnsupported] is the active safety net: if ML Kit
/// fails to init or throws at runtime on a nominally-capable device, we degrade
/// to tap-to-capture for the rest of the session instead of breaking the scan.
class ScanCapability {
  ScanCapability._();

  /// The iOS major version at/above which on-device ML Kit is expected to work.
  /// Matches ML Kit's current framework floor (iOS 15.5).
  static const int _minIosMajorForAuto = 15;

  static bool? _override;

  /// Whether live on-device auto-detect should be attempted on this device.
  /// Synchronous so the scan view can decide its mode in `initState`.
  static bool autoScanSupported() {
    if (_override != null) return _override!;
    if (Platform.isAndroid) return true; // ML Kit runs on all supported Android
    if (Platform.isIOS) return iosMajorVersion() >= _minIosMajorForAuto;
    return false; // other platforms: manual capture only
  }

  /// Parses the iOS major version from `Platform.operatingSystemVersion`
  /// (e.g. "Version 16.4 (Build 20E247)"). Defaults to the auto floor on an
  /// unparseable string so a capable install isn't wrongly downgraded.
  static int iosMajorVersion() {
    final match = RegExp(r'(\d+)').firstMatch(Platform.operatingSystemVersion);
    if (match == null) return _minIosMajorForAuto;
    return int.tryParse(match.group(1)!) ?? _minIosMajorForAuto;
  }

  /// Force tap-to-capture for the rest of the session — called when ML Kit
  /// init/runtime fails on a device the version check thought was capable.
  static void markAutoUnsupported() => _override = false;

  /// Test/debug hook to reset the session override.
  static void reset() => _override = null;
}
