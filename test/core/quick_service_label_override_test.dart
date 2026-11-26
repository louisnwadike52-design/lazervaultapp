import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE TILE LABEL IS OPERATOR-RENAMEABLE, AND THE SHIPPED WORD IS THE FLOOR.
///
/// The label is the only part of a service a customer reads before tapping,
/// and the right words change without the service changing — "Send Funds"
/// became "Transfer" because that is what people here call it. Shipping that
/// as a constant makes a wording decision wait on a store review.
///
/// What these pin is the FALLBACK behaviour, because every failure here is a
/// tile a customer cannot read: a blank override must not render an
/// unlabelled icon, and an over-long one must not clip to nonsense. Both fall
/// back to the shipped word rather than to nothing.
void main() {
  // FeatureFlags.init() binds the store with `??=`, so it never re-reads once
  // set — and debugResetForTest() CLEARS. So a test cannot seed through
  // setMockInitialValues: it must rebind, then write through the shared
  // instance, which is the same singleton FeatureFlags is holding.
  Future<void> seed(Map<String, String> values) async {
    await FeatureFlags.debugResetForTest();
    final prefs = await SharedPreferences.getInstance();
    for (final e in values.entries) {
      await prefs.setString(e.key, e.value);
    }
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await seed({});
  });

  test('with nothing configured the shipped label is used', () async {
    expect(AppServiceName.sendFunds.label, 'Transfer');
    expect(AppServiceName.payBills.label, 'Bills Hub');
  });

  test('"Transfer" is the shipped default for send funds', () {
    // Pinned because the rename was a deliberate operator decision, and a
    // revert to "Send Funds" in the enum would silently undo it for every
    // install that has not polled settings yet — which is every cold start.
    expect(AppServiceName.sendFunds.displayName, 'Transfer');
  });

  test('an operator override replaces the shipped label', () async {
    await seed({FeatureFlags.quickServiceLabelKey('sendFunds'): 'Send Money'});
    expect(AppServiceName.sendFunds.label, 'Send Money');
    // And only that service — a rename must not leak across tiles.
    expect(AppServiceName.payBills.label, 'Bills Hub');
  });

  test('a blank or whitespace override falls back, never to an empty tile',
      () async {
    for (final blank in ['', '   ', '\n']) {
      await seed({FeatureFlags.quickServiceLabelKey('sendFunds'): blank});
      expect(AppServiceName.sendFunds.label, 'Transfer',
          reason: 'a blank override would render an icon with no caption, '
              'which reads as broken rather than renamed');
    }
  });

  test('an over-long override falls back rather than clipping', () async {
    final tooLong = 'x' * (FeatureFlags.quickServiceLabelMaxRunes + 1);
    await seed({FeatureFlags.quickServiceLabelKey('sendFunds'): tooLong});
    expect(AppServiceName.sendFunds.label, 'Transfer');

    // Exactly at the bound is accepted — the cap is a limit, not a margin.
    final atBound = 'y' * FeatureFlags.quickServiceLabelMaxRunes;
    await seed({FeatureFlags.quickServiceLabelKey('sendFunds'): atBound});
    expect(AppServiceName.sendFunds.label, atBound);
  });

  test('the key is built from the enum name, which is the settings identifier',
      () {
    expect(FeatureFlags.quickServiceLabelKey('sendFunds'),
        'quick_service_sendFunds_label');
    // Rides the quick_service_ family the settings poll already ingests
    // verbatim, so a label needs no new plumbing in the gateway or the app.
    expect(FeatureFlags.quickServiceLabelKey('sendFunds'),
        startsWith('quick_service_'));
  });
}
