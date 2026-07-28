import 'dart:io';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:url_launcher/url_launcher.dart';

/// Whether the device can do fingerprint/Face-ID auth right now.
enum BiometricAvailability {
  /// Hardware present AND at least one biometric enrolled → ready to use.
  available,

  /// Hardware present but NOTHING enrolled → we can send the user to the OS
  /// enrollment screen to add a fingerprint / face, then come back.
  noneEnrolled,

  /// No biometric sensor on this device at all.
  noHardware,

  /// Temporarily unavailable (sensor busy / locked out) or undetermined.
  unavailable,
}

/// The outcome of a single OS biometric prompt, classified so callers can give
/// the user an actionable message instead of a silent no-op.
enum BiometricAuthOutcome {
  success,
  /// User dismissed / failed the prompt (not an error — just didn't pass).
  failed,
  /// No biometric enrolled — steer to OS enrollment.
  notEnrolled,
  /// Sensor not available on this device.
  notAvailable,
  /// Too many attempts — temporarily locked; retry later.
  lockedOut,
  /// Locked until the device is unlocked with PIN/pattern/password.
  permanentlyLockedOut,
  /// No device PIN/pattern/password set (required to use biometrics).
  passcodeNotSet,
  /// Any other platform error.
  error,
}

class BiometricAuthResult {
  final BiometricAuthOutcome outcome;
  final String? message;
  const BiometricAuthResult(this.outcome, [this.message]);
  bool get ok => outcome == BiometricAuthOutcome.success;
}

/// Snapshot of the device's biometric capability.
class BiometricStatus {
  final BiometricAvailability availability;
  final bool hasFace;
  final bool hasFingerprint;

  const BiometricStatus(
    this.availability, {
    this.hasFace = false,
    this.hasFingerprint = false,
  });

  bool get isAvailable => availability == BiometricAvailability.available;

  /// Hardware is present but the user hasn't enrolled a biometric yet — the
  /// case where we offer to open the OS enrollment settings.
  bool get canEnroll => availability == BiometricAvailability.noneEnrolled;
}

/// Single source of truth for OS fingerprint / Face-ID:
///  • [status] — precise readiness (distinguishes "not enrolled" from "no
///    hardware" — on Android via the native framework BiometricManager, on iOS
///    via local_auth + isDeviceSupported).
///  • [openOsEnrollment] — deep-links from our app DOWN to the OS screen where
///    the user actually enrolls a fingerprint / face.
///  • [authenticate] — runs the OS prompt and maps failures to a typed outcome.
///
/// Fingerprint/Face-ID are device-local: the secure enclave does the match; the
/// app only ever gets a yes/no. This is the fintech standard — there is no
/// backend call for the match itself.
class BiometricService {
  BiometricService({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  /// Reuses the existing native settings channel (also hosts openNfcSettings).
  static const MethodChannel _settings =
      MethodChannel('com.lazervault.app/settings');

  Future<List<BiometricType>> _enrolledTypes() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      if (!canCheck) return const [];
      return await _auth.getAvailableBiometrics();
    } catch (_) {
      return const [];
    }
  }

  Future<BiometricStatus> status() async {
    final types = await _enrolledTypes();
    final hasFace = types.contains(BiometricType.face);
    // Android reports fingerprint/face-unlock as generic strong/weak (NOT
    // BiometricType.face), so those count as "fingerprint" for our purposes.
    final hasFingerprint = types.contains(BiometricType.fingerprint) ||
        types.contains(BiometricType.strong) ||
        types.contains(BiometricType.weak);

    if (Platform.isAndroid) {
      // The framework BiometricManager precisely separates "none enrolled"
      // (hardware present, add one in OS settings) from "no hardware".
      String native = 'unknown';
      try {
        native = await _settings.invokeMethod<String>('biometricStatus') ??
            'unknown';
      } catch (_) {}
      switch (native) {
        case 'available':
          return BiometricStatus(
            BiometricAvailability.available,
            hasFace: hasFace,
            // Ensure at least the fingerprint tile is usable even if the type
            // list came back generic.
            hasFingerprint: hasFingerprint || !hasFace,
          );
        case 'none_enrolled':
          return const BiometricStatus(BiometricAvailability.noneEnrolled);
        case 'no_hardware':
          return const BiometricStatus(BiometricAvailability.noHardware);
        case 'hw_unavailable':
          return const BiometricStatus(BiometricAvailability.unavailable);
      }
      // Native status undetermined (older API) → fall back to local_auth.
      if (types.isNotEmpty) {
        return BiometricStatus(BiometricAvailability.available,
            hasFace: hasFace, hasFingerprint: hasFingerprint);
      }
      return const BiometricStatus(BiometricAvailability.unavailable);
    }

    // iOS: a non-empty type list means Face/Touch ID is set up. Otherwise, if
    // the device supports device auth at all we treat it as "hardware present
    // but not enrolled" (there's no public API to enumerate un-enrolled iOS
    // biometric hardware) so we can still guide the user into Settings.
    if (types.isNotEmpty) {
      return BiometricStatus(BiometricAvailability.available,
          hasFace: hasFace, hasFingerprint: hasFingerprint);
    }
    bool supported = false;
    try {
      supported = await _auth.isDeviceSupported();
    } catch (_) {}
    return BiometricStatus(supported
        ? BiometricAvailability.noneEnrolled
        : BiometricAvailability.noHardware);
  }

  /// Opens the OS screen where the user enrolls a fingerprint / face.
  /// Android: the biometric-enroll intent (falls back to security settings).
  /// iOS: no public deep-link to "Face ID & Passcode", so we open the app's
  /// Settings page — the caller should tell the user to finish there.
  Future<bool> openOsEnrollment() async {
    if (Platform.isAndroid) {
      try {
        final ok = await _settings.invokeMethod<bool>('openBiometricEnroll');
        return ok ?? true;
      } catch (_) {
        // fall through to the generic app-settings deep-link
      }
    }
    try {
      return await launchUrl(Uri.parse('app-settings:'));
    } catch (_) {
      return false;
    }
  }

  /// Runs the OS biometric prompt. [reason] is shown by the OS.
  Future<BiometricAuthResult> authenticate({required String reason}) async {
    try {
      final ok = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return BiometricAuthResult(
          ok ? BiometricAuthOutcome.success : BiometricAuthOutcome.failed);
    } on PlatformException catch (e) {
      return _mapError(e);
    }
  }

  BiometricAuthResult _mapError(PlatformException e) {
    switch (e.code) {
      case auth_error.notEnrolled:
        return const BiometricAuthResult(BiometricAuthOutcome.notEnrolled);
      case auth_error.notAvailable:
        return const BiometricAuthResult(BiometricAuthOutcome.notAvailable);
      case auth_error.lockedOut:
        return const BiometricAuthResult(BiometricAuthOutcome.lockedOut);
      case auth_error.permanentlyLockedOut:
        return const BiometricAuthResult(
            BiometricAuthOutcome.permanentlyLockedOut);
      case auth_error.passcodeNotSet:
        return const BiometricAuthResult(BiometricAuthOutcome.passcodeNotSet);
      default:
        return BiometricAuthResult(BiometricAuthOutcome.error, e.message);
    }
  }

  /// User-facing copy for a non-success outcome (nullable → no message needed).
  static String? messageFor(BiometricAuthResult r, {String label = 'biometrics'}) {
    switch (r.outcome) {
      case BiometricAuthOutcome.success:
      case BiometricAuthOutcome.failed:
        return null;
      case BiometricAuthOutcome.notEnrolled:
        return 'No $label is set up on this device yet. Add one in your device settings, then try again.';
      case BiometricAuthOutcome.notAvailable:
        return '$label is not available on this device right now.';
      case BiometricAuthOutcome.lockedOut:
        return 'Too many attempts. Try again in a little while, or use your passcode.';
      case BiometricAuthOutcome.permanentlyLockedOut:
        return 'Biometrics are locked. Unlock your device with its PIN/pattern first.';
      case BiometricAuthOutcome.passcodeNotSet:
        return 'Set a screen lock (PIN, pattern or password) on your device to use $label.';
      case BiometricAuthOutcome.error:
        return r.message ?? 'Something went wrong. Please try again.';
    }
  }
}
