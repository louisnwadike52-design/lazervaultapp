import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The gate rules, pinned at the level they are actually asked.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  const gate = 'feature_bill_education';

  group('availability', () {
    test('an unconfigured surface is AVAILABLE', () async {
      await FeatureFlags.applyRemoteSnapshot({});
      expect(FeatureFlags.gateAvailable(gate), isTrue,
          reason: 'nothing should need seeding, and a surface added later '
              'must be live rather than invisible until someone configures it');
    });

    test('only the exact string "false" disables', () async {
      for (final v in ['off', 'no', '0', 'disabled', 'FALSE ']) {
        await FeatureFlags.applyRemoteSnapshot({'${gate}_available': v});
        final disabled = !FeatureFlags.gateAvailable(gate);
        // "FALSE " is trimmed + lower-cased and DOES disable; the rest must not.
        expect(disabled, v.trim().toLowerCase() == 'false',
            reason: 'a typo in an admin field must not take a working service '
                'off the app — value was "$v"');
      }
    });

    test('"false" disables', () async {
      await FeatureFlags.applyRemoteSnapshot({'${gate}_available': 'false'});
      expect(FeatureFlags.gateAvailable(gate), isFalse);
    });
  });

  group('whitelist is an OVERRIDE, not a filter', () {
    test('a listed address gets in while the switch is off', () async {
      await FeatureFlags.applyRemoteSnapshot({
        '${gate}_available': 'false',
        '${gate}_whitelist': 'Tester@Example.com , other@example.com',
      });
      expect(FeatureFlags.gateAllowed(gate, email: 'tester@example.com'), isTrue,
          reason: 'case and padding must not matter');
      expect(FeatureFlags.gateAllowed(gate, email: 'nobody@example.com'), isFalse);
    });

    test('a parked list lets nobody through', () async {
      await FeatureFlags.applyRemoteSnapshot({
        '${gate}_available': 'false',
        '${gate}_whitelist': 'tester@example.com',
        '${gate}_whitelist_enabled': 'false',
      });
      expect(FeatureFlags.gateAllowed(gate, email: 'tester@example.com'), isFalse,
          reason: 'parking the list must park it, without losing who is on it');
      expect(FeatureFlags.whitelistEmails(gate), contains('tester@example.com'),
          reason: 'and the list itself must survive being parked');
    });

    test('fails closed on an unknown or empty email', () async {
      await FeatureFlags.applyRemoteSnapshot({
        '${gate}_available': 'false',
        '${gate}_whitelist': 'tester@example.com',
      });
      expect(FeatureFlags.gateAllowed(gate, email: ''), isFalse);
      expect(FeatureFlags.gateAllowed(gate, email: null), isFalse);
    });

    test('an empty list does not grant everyone', () async {
      await FeatureFlags.applyRemoteSnapshot({
        '${gate}_available': 'false',
        '${gate}_whitelist': '',
      });
      expect(FeatureFlags.gateAllowed(gate, email: 'tester@example.com'), isFalse,
          reason: 'a whitelist that accidentally matched everyone would publish '
              'a surface that was deliberately hidden');
    });
  });

  group('hydration types', () {
    // _whitelist_enabled is written TWICE by applyRemoteSnapshot: once as a
    // String by the feature_ loop, then as a bool by the whitelist loop. The
    // bool write must land LAST, because whitelistActive reads it with
    // getBool — and getBool over a String throws, which during a build method
    // is a red screen rather than a wrong answer.
    test('_whitelist_enabled survives as a bool, not a string', () async {
      await FeatureFlags.applyRemoteSnapshot({
        '${gate}_whitelist_enabled': 'true',
        '${gate}_whitelist': 'a@b.com',
        '${gate}_available': 'false',
        '${gate}_message': 'Back soon',
      });
      // Would throw if the String write had won.
      expect(() => FeatureFlags.whitelistActive(gate), returnsNormally);
      expect(FeatureFlags.whitelistActive(gate), isTrue);
      // And the string-valued siblings are still strings.
      expect(FeatureFlags.gateMessage(gate), 'Back soon');
      expect(FeatureFlags.gateAvailable(gate), isFalse);
    });
  });

  group('message', () {
    test('never blank', () async {
      await FeatureFlags.applyRemoteSnapshot({'${gate}_available': 'false'});
      expect(FeatureFlags.gateMessage(gate), isNotEmpty);
      await FeatureFlags.applyRemoteSnapshot({'${gate}_message': '   '});
      expect(FeatureFlags.gateMessage(gate), isNotEmpty,
          reason: 'a blanked field must not render an empty modal');
    });
  });

  group('a landed snapshot announces itself', () {
    test('revision advances so gated surfaces repaint', () async {
      final before = FeatureFlags.revision.value;
      await FeatureFlags.applyRemoteSnapshot({'${gate}_available': 'false'});
      expect(FeatureFlags.revision.value, greaterThan(before),
          reason: 'without this a kill switch takes effect only at next launch');
    });
  });
}
