import 'package:flutter_test/flutter_test.dart';

import 'dart:io';

/// The device id is the backend's answer to "is this a known device"
/// (auth-service risk_engine.go — location is no longer an authentication
/// gate). Anything that silently changes it turns a phone the customer has
/// used for months into a new device and sends them an email OTP.
///
/// Three places can change it, and all three are pinned here. These are source
/// checks on purpose: the failure is a value going missing at runtime on a
/// device we cannot reproduce, so the only durable guard is on the code that
/// could drop it.
void main() {
  String read(String p) => File(p).readAsStringSync();

  group('the device id survives every local wipe', () {
    test('FreshInstallGuard carries it across the wipe', () {
      final src = read('lib/core/services/fresh_install_guard.dart');

      // It must read the id BEFORE clearing...
      final readAt = src.indexOf('secure.read(key: _kDeviceIdKey)');
      final clearAt = src.indexOf('await prefs.clear()');
      final restoreAt = src.indexOf('prefs.setString(_kDeviceIdKey');

      expect(readAt, greaterThan(-1),
          reason: 'the guard must read the device id before wiping — it wipes '
              'BOTH secure storage and prefs, so nothing else can recover it');
      expect(clearAt, greaterThan(readAt),
          reason: 'the read must happen before the clear, or there is nothing '
              'left to read');
      expect(restoreAt, greaterThan(clearAt),
          reason: 'the id must be written back AFTER the clear, or the clear '
              'removes it again');
    });

    test('the key matches DeviceService, which is what makes it the same id',
        () {
      final guard = read('lib/core/services/fresh_install_guard.dart');
      final service = read('lib/core/services/device_service.dart');
      expect(guard.contains("_kDeviceIdKey = 'device_id'"), isTrue,
          reason: 'the guard duplicates the key (it runs before DI); if the '
              'two ever disagree the guard preserves nothing and the id still '
              'rotates on every update');
      expect(service.contains("_deviceIdKey = 'device_id'"), isTrue,
          reason: 'DeviceService key changed — update the guard to match');
    });

    test('DeviceService keeps a plain mirror and heals from it', () {
      final src = read('lib/core/services/device_service.dart');
      expect(src.contains('_readMirroredDeviceId'), isTrue,
          reason: 'without a plain mirror, an Android Keystore loss silently '
              'rotates the id (resetOnError wipes the encrypted copy)');
      expect(src.contains('_mirrorDeviceId'), isTrue);
      // The mirror must be consulted BEFORE minting a new id.
      final mirrorAt = src.indexOf('await _readMirroredDeviceId()');
      final mintAt = src.indexOf('const Uuid().v4()');
      expect(mirrorAt, greaterThan(-1));
      expect(mirrorAt, lessThan(mintAt),
          reason: 'the mirror must be read before a new UUID is minted, or it '
              'can never prevent a rotation');
    });
  });

  group('the mirror must not travel to another handset', () {
    test('both stores are excluded from backup AND device transfer', () {
      for (final f in [
        'android/app/src/main/res/xml/backup_rules.xml',
        'android/app/src/main/res/xml/data_extraction_rules.xml',
      ]) {
        final src = read(f);
        expect(src.contains('FlutterSharedPreferences.xml'), isTrue,
            reason: '$f must exclude the plain mirror, or restoring onto a '
                'different phone carries the identity across and a genuinely '
                'new device arrives already trusted');
        expect(src.contains('FlutterSecureStorage.xml'), isTrue, reason: f);
      }
      // device-transfer is a separate transport from cloud-backup and is easy
      // to forget; phone-to-phone migration is exactly the case that matters.
      final rules = read('android/app/src/main/res/xml/data_extraction_rules.xml');
      expect(rules.contains('<device-transfer>'), isTrue,
          reason: 'excluding cloud-backup alone still lets a direct '
              'phone-to-phone transfer carry the device identity across');
    });

    test('the manifest actually points at both rule files', () {
      final m = read('android/app/src/main/AndroidManifest.xml');
      expect(m.contains('android:fullBackupContent="@xml/backup_rules"'), isTrue,
          reason: 'Android 11 and below use fullBackupContent');
      expect(
          m.contains('android:dataExtractionRules="@xml/data_extraction_rules"'),
          isTrue,
          reason: 'Android 12+ use dataExtractionRules');
    });
  });
}
