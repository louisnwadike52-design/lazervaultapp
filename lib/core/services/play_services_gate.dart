import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Thin bridge to the native Google Play Services availability check
/// (`GoogleApiAvailability.isGooglePlayServicesAvailable` — see MainActivity's
/// `com.lazervault.app/play_services` channel).
///
/// Purpose: GATE Firebase App Check (Play Integrity) + FCM initialisation so they
/// never run — and never surface the native blocking "Something went wrong /
/// Check that Google Play is enabled … up-to-date … reinstall" dialog — on a
/// device whose Play Services/Store is missing, disabled, or outdated. When
/// unavailable the app runs WITHOUT push/attestation instead of hard-blocking at
/// open.
///
/// FAIL-OPEN by design: a wrong `false` would needlessly disable push on a
/// healthy device, so we return `false` ONLY on a definitive non-zero
/// availability code from GMS; any error (channel missing, exception, non-Android
/// platform) returns `true`.
class PlayServicesGate {
  static const MethodChannel _channel =
      MethodChannel('com.lazervault.app/play_services');

  /// True when Google Play Services is available AND up to date
  /// (`ConnectionResult.SUCCESS` == 0), on non-Android platforms, or if the check
  /// itself cannot run.
  static Future<bool> isAvailable() async {
    if (!Platform.isAndroid) return true;
    try {
      final code = await _channel.invokeMethod<int>('availability');
      return code == 0; // ConnectionResult.SUCCESS
    } catch (e) {
      debugPrint(
          'PlayServicesGate: availability check failed ($e) — assuming available');
      return true;
    }
  }
}
