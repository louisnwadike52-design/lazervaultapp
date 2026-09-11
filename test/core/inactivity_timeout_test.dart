import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

// The idle-logout preference decides when a user is thrown out of a banking
// session, so its bounds matter more than its convenience. A stored 1 would
// log someone out a second after every tap; a stored 86400 would leave a
// funded session open all day on a shared phone.
//
// EndpointRegistry already clamps the ADMIN to [15, 600]. The user preference
// is clamped to the same window on BOTH write and read: write so a bad value
// is never persisted, read so a value written by an older build — or tampered
// with on a rooted device — cannot take effect either.
void main() {
  late SecureStorageService store;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    store = SecureStorageService(const FlutterSecureStorage());
  });

  test('absent means follow the platform, not "no timeout"', () async {
    // The fail-safe direction: an unset preference must defer to the admin
    // policy rather than disabling the protection.
    expect(await store.getInactivityTimeoutSeconds(), isNull);
  });

  test('a value below the floor is raised, never stored as-is', () async {
    await store.setInactivityTimeoutSeconds(1);
    expect(await store.getInactivityTimeoutSeconds(),
        SecureStorageService.minInactivityTimeout);
  });

  test('a value above the ceiling is capped', () async {
    await store.setInactivityTimeoutSeconds(86400);
    expect(await store.getInactivityTimeoutSeconds(),
        SecureStorageService.maxInactivityTimeout);
  });

  test('values inside the window round-trip untouched', () async {
    for (final s in [15, 30, 60, 120, 300, 600]) {
      await store.setInactivityTimeoutSeconds(s);
      expect(await store.getInactivityTimeoutSeconds(), s);
    }
  });

  test('null clears back to following the platform', () async {
    await store.setInactivityTimeoutSeconds(300);
    await store.setInactivityTimeoutSeconds(null);
    expect(await store.getInactivityTimeoutSeconds(), isNull);
  });

  test('a hostile stored value cannot disable the timeout', () async {
    // Written straight past the setter, as an older build or a tampered
    // keystore would. Read-side clamping is what makes this safe.
    for (final raw in ['0', '-1', 'never', '', '999999']) {
      FlutterSecureStorage.setMockInitialValues(
          {'inactivity_timeout_seconds': raw});
      final v = await SecureStorageService(const FlutterSecureStorage()).getInactivityTimeoutSeconds();
      if (v != null) {
        expect(v, inInclusiveRange(SecureStorageService.minInactivityTimeout,
            SecureStorageService.maxInactivityTimeout),
            reason: 'stored "$raw" produced an out-of-range $v');
      }
      // null is acceptable — it means "follow the platform", which is a
      // policy, not an absence of one.
    }
  });
}
