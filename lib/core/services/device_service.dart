import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

      if (deviceId == null || deviceId.isEmpty) {
        // Generate a new device ID
        deviceId = const Uuid().v4();
        await _storage.write(key: _deviceIdKey, value: deviceId);
      }

      _cachedDeviceId = deviceId;
      return deviceId;
    } catch (e) {
      // Fallback to a new UUID if storage fails
      final deviceId = const Uuid().v4();
      _cachedDeviceId = deviceId;
      return deviceId;
    }
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
