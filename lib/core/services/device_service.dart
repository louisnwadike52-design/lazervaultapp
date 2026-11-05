import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Service for managing device identification
/// Used for tracking signup state across devices and detecting new device logins
class DeviceService {
  static const String _deviceIdKey = 'device_id';
  static const String _deviceNameKey = 'device_name';
  static const String _lastKnownDeviceIdKey = 'last_known_device_id';

  final FlutterSecureStorage _storage;
  final DeviceInfoPlugin _deviceInfo;

  String? _cachedDeviceId;
  String? _cachedDeviceName;

  DeviceService(this._storage, this._deviceInfo);

  /// Get or generate a unique device ID
  /// This ID persists across app restarts on the same device
  Future<String> getDeviceId() async {
    // Return cached value if available
    if (_cachedDeviceId != null) {
      return _cachedDeviceId!;
    }

    try {
      // Try to read from storage first
      String? deviceId = await _storage.read(key: _deviceIdKey);

      // SECURE STORAGE LOST IT? ASK THE PLAIN MIRROR BEFORE MINTING A NEW ONE.
      //
      // The device id is now what the backend uses to decide whether you are a
      // known device (risk_engine.go — location is no longer a gate), so a
      // rotated id is not a cosmetic bug: it makes a phone the user has used
      // for months look brand new and puts an email OTP in front of them.
      //
      // On ANDROID that was reachable without anything going wrong on the
      // server. flutter_secure_storage is configured
      // `encryptedSharedPreferences: true, resetOnError: true`; the Keystore
      // key is device-bound and is NOT included in Android auto-backup, while
      // the encrypted file IS. After a restore the file cannot be decrypted,
      // resetOnError silently wipes it, and _stablePlatformId() returns null on
      // Android (ANDROID_ID was removed for privacy) — so the next read minted
      // a fresh UUID. The same happens on any Keystore invalidation.
      //
      // The id is an IDENTIFIER, not a credential: nothing is protected by its
      // secrecy, and the server treats it as a claim it verifies with an OTP.
      // So mirroring it in ordinary app-private preferences costs no security
      // and removes the whole failure mode. The mirror must be excluded from
      // auto-backup too, so restoring onto a DIFFERENT handset still yields a
      // fresh id — a new phone genuinely is a new device.
      if (deviceId == null || deviceId.isEmpty) {
        deviceId = await _readMirroredDeviceId();
        if (deviceId != null && deviceId.isNotEmpty) {
          // Heal secure storage from the mirror so both agree again.
          try {
            await _storage.write(key: _deviceIdKey, value: deviceId);
          } catch (_) {/* mirror alone is enough to stay stable */}
        }
      }

      if (deviceId == null || deviceId.isEmpty) {
        // Seed from a STABLE platform identifier where available (iOS
        // identifierForVendor) so a Keystore/secure-storage loss re-derives the
        // SAME id instead of rotating. A rotating device_id registers a NEW FCM
        // token row per launch while the old stays active → the SAME device gets
        // the push once per token (duplicate push). Existing installs keep their
        // already-persisted id (no churn); only fresh/lost state uses the seed.
        deviceId = await _stablePlatformId() ?? const Uuid().v4();
        await _storage.write(key: _deviceIdKey, value: deviceId);
      }

      await _mirrorDeviceId(deviceId);
      _cachedDeviceId = deviceId;
      return deviceId;
    } catch (e) {
      // Secure storage threw outright. The mirror is the whole reason this
      // branch no longer rotates the id on Android.
      final mirrored = await _readMirroredDeviceId();
      final fallback =
          mirrored ?? (await _stablePlatformId()) ?? const Uuid().v4();
      try {
        await _storage.write(key: _deviceIdKey, value: fallback);
      } catch (_) {
        // best-effort; cached below keeps it stable for this process at least
      }
      await _mirrorDeviceId(fallback);
      _cachedDeviceId = fallback;
      return fallback;
    }
  }

  /// The plain, app-private mirror of [_deviceIdKey].
  ///
  /// Deliberately NOT encrypted: encryption is what made the primary copy
  /// fragile, and this value is an identifier rather than a secret. Both
  /// reads and writes are best-effort — a missing mirror simply means the
  /// caller falls through to the behaviour that existed before it.
  Future<String?> _readMirroredDeviceId() async {
    try {
      return (await SharedPreferences.getInstance()).getString(_deviceIdKey);
    } catch (_) {
      return null;
    }
  }

  Future<void> _mirrorDeviceId(String deviceId) async {
    if (deviceId.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString(_deviceIdKey) != deviceId) {
        await prefs.setString(_deviceIdKey, deviceId);
      }
    } catch (_) {/* best-effort */}
  }

  /// A stable per-device identifier from the OS, used only to SEED [_deviceIdKey]
  /// when no id is persisted yet. iOS `identifierForVendor` survives app data
  /// loss (resets only when all vendor apps are uninstalled). Android exposes no
  /// stable per-install hardware id via device_info_plus (ANDROID_ID was removed
  /// for privacy), so Android falls back to a persisted UUID. Returns null when
  /// no stable id is available → caller uses a UUID.
  Future<String?> _stablePlatformId() async {
    try {
      if (Platform.isIOS) {
        final ios = await _deviceInfo.iosInfo;
        final idfv = ios.identifierForVendor;
        if (idfv != null && idfv.isNotEmpty) return 'ios-$idfv';
      }
    } catch (_) {
      // device_info unavailable → fall through to UUID
    }
    return null;
  }

  /// Get a human-readable device name
  Future<String> getDeviceName() async {
    // Return cached value if available
    if (_cachedDeviceName != null) {
      return _cachedDeviceName!;
    }

    try {
      // Try to read from storage first
      String? deviceName = await _storage.read(key: _deviceNameKey);

      if (deviceName == null || deviceName.isEmpty) {
        // Generate device name based on platform
        deviceName = await _generateDeviceName();
        await _storage.write(key: _deviceNameKey, value: deviceName);
      }

      _cachedDeviceName = deviceName;
      return deviceName;
    } catch (e) {
      return 'Unknown Device';
    }
  }

  /// Generate a device name based on platform info
  Future<String> _generateDeviceName() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return '${androidInfo.brand} ${androidInfo.model}';
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return '${iosInfo.name} (${iosInfo.model})';
      } else {
        return 'Unknown Device';
      }
    } catch (e) {
      return 'Unknown Device';
    }
  }

  /// Check if this is a new device compared to a saved device ID
  /// Used for detecting cross-device signup resumption
  Future<bool> isNewDevice(String? savedDeviceId) async {
    if (savedDeviceId == null || savedDeviceId.isEmpty) {
      return false; // No saved device ID means we can't determine
    }

    final currentDeviceId = await getDeviceId();
    return currentDeviceId != savedDeviceId;
  }

  /// Save the last known device ID (for cross-device detection)
  Future<void> saveLastKnownDeviceId(String deviceId) async {
    try {
      await _storage.write(key: _lastKnownDeviceIdKey, value: deviceId);
    } catch (e) {
      // Silently fail
    }
  }

  /// Get the last known device ID
  Future<String?> getLastKnownDeviceId() async {
    try {
      return await _storage.read(key: _lastKnownDeviceIdKey);
    } catch (e) {
      return null;
    }
  }

  /// Check if the current device is different from the last known device
  Future<bool> isDeviceChanged() async {
    final lastKnownId = await getLastKnownDeviceId();
    if (lastKnownId == null) {
      return false; // First time, no change
    }
    return await isNewDevice(lastKnownId);
  }

  /// Update last known device to current device
  Future<void> updateLastKnownDevice() async {
    final deviceId = await getDeviceId();
    await saveLastKnownDeviceId(deviceId);
  }

  /// Get device info for debugging/logging
  Future<Map<String, String>> getDeviceInfo() async {
    final deviceId = await getDeviceId();
    final deviceName = await getDeviceName();

    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
      'platform': Platform.operatingSystem,
      'version': Platform.operatingSystemVersion,
    };
  }

  /// Clear all device-related storage (for testing/logout)
  Future<void> clearDeviceData() async {
    try {
      await _storage.delete(key: _deviceIdKey);
      await _storage.delete(key: _deviceNameKey);
      await _storage.delete(key: _lastKnownDeviceIdKey);
      _cachedDeviceId = null;
      _cachedDeviceName = null;
    } catch (e) {
      // Silently fail
    }
  }
}
