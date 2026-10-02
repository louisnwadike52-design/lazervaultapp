import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The amount screen and the server must refuse the same transfers.
///
/// A bank transfer under the payout provider's floor is rejected by
/// core-payments with an exact, NON-RETRYABLE reason — and it was only
/// rejected after the PIN, behind "Something went wrong … Please try again".
/// Retrying a non-retryable refusal fails identically every time, which is
/// how three ₦10 attempts were reported as "all transfers are failing".
///
/// The floor is now one system_settings row (external_payout_floor_minor)
/// read by BOTH core-payments and the app. These tests pin the app half: the
/// value must come from the server, and the fallback must be the known floor
/// rather than something permissive.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences caches its instance, so setMockInitialValues only takes
  // effect before the FIRST getInstance. Write through the live instance
  // instead, which is also closer to how the value actually arrives — the
  // endpoint refresh persists it into prefs at runtime, not at boot.
  late SharedPreferences prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    prefs = await SharedPreferences.getInstance();
  });

  Future<void> withFloor(String? raw) async {
    if (raw == null) {
      await prefs.remove('external_payout_floor_minor');
    } else {
      await prefs.setString('external_payout_floor_minor', raw);
    }
  }

  test('the server value is used when present', () async {
    await withFloor('5000');
    expect(FeatureFlags.externalPayoutFloorMinor, 5000,
        reason: 'the app must refuse exactly what the server refuses');
  });

  test('a missing value falls back to the MEASURED floor, not to zero', () async {
    await withFloor(null);
    expect(
      FeatureFlags.externalPayoutFloorMinor,
      10000,
      reason: 'zero would let the amount screen wave through a transfer the '
          'server then refuses after the PIN — the exact failure this exists '
          'to prevent',
    );
  });

  test('a malformed or nonsense admin value degrades to the floor', () async {
    for (final bad in <String>['', '   ', 'abc', '0', '-500']) {
      await withFloor(bad);
      expect(FeatureFlags.externalPayoutFloorMinor, 10000,
          reason: '"$bad" must not disable the guard');
    }
  });

  test('a raised floor is honoured', () async {
    await withFloor('20000');
    expect(FeatureFlags.externalPayoutFloorMinor, 20000);
  });
}
