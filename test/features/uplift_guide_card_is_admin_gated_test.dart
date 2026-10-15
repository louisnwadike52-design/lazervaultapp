import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The Lazerfunds tabs show a ONE-LINE info link. The full first-run card is
/// the other state, and it exists only while an admin turns it on.
///
/// Two halves, and each can rot on its own:
///
///   * the RULE — a gate that ADDS UI must default OFF. Every other gate in the
///     `feature_` family withholds an existing surface and so defaults ON; if
///     this one inherited that, merely shipping the key family would put the
///     card back on every phone at the next settings poll. Nobody would have
///     asked for it and nobody would know which change did it.
///   * the WIRING — the screen must consult the gate, the Settings switch must
///     only exist while the card does, and the dashboard must actually list the
///     gate. A flag nothing reads is the bug this repo has shipped most often.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  const gate = 'feature_explainer_lazerfundsguide';

  group('a gate that ADDS UI defaults OFF', () {
    test('unset means off', () async {
      await FeatureFlags.applyRemoteSnapshot({});
      expect(FeatureFlags.gateAvailable(gate, defaultOn: false), isFalse);
      expect(FeatureFlags.lazerfundsGuideCardEnabled, isFalse,
          reason: 'shipping the gate must not ship the card');
    });

    test('a blank row means off too', () async {
      // `upsertSystemSetting(key, "")` is how a cleared field saves, so blank
      // is a real state in this store — four such rows are live on prod.
      await FeatureFlags.applyRemoteSnapshot({'${gate}_available': ''});
      expect(FeatureFlags.lazerfundsGuideCardEnabled, isFalse);
    });

    test('only the exact string "true" enables', () async {
      for (final v in ['on', 'yes', '1', 'enabled', 'True ', 'true']) {
        await FeatureFlags.applyRemoteSnapshot({'${gate}_available': v});
        expect(FeatureFlags.lazerfundsGuideCardEnabled,
            v.trim().toLowerCase() == 'true',
            reason: 'a typo must not put unasked-for UI on every phone — '
                'value was "$v"');
      }
    });

    test('the default-ON family is unchanged', () async {
      // The same function serves both, so this is the regression that would
      // matter most: a bill type must still be available when unconfigured.
      await FeatureFlags.applyRemoteSnapshot({});
      expect(FeatureFlags.gateAvailable('feature_bill_education'), isTrue);
      await FeatureFlags
          .applyRemoteSnapshot({'feature_bill_education_available': ''});
      expect(FeatureFlags.gateAvailable('feature_bill_education'), isTrue,
          reason: 'a blanked field must not take a live service off the app');
    });

    test('the whitelist still overrides, so it can ship to a demo cohort',
        () async {
      await FeatureFlags.applyRemoteSnapshot({
        '${gate}_whitelist': 'Demo@Example.com',
      });
      expect(
          FeatureFlags.gateAllowed(gate,
              email: 'demo@example.com', defaultOn: false),
          isTrue);
      expect(
          FeatureFlags.gateAllowed(gate,
              email: 'someone@example.com', defaultOn: false),
          isFalse);
    });

    test('a parked whitelist denies rather than granting', () async {
      await FeatureFlags.applyRemoteSnapshot({
        '${gate}_whitelist': 'demo@example.com',
        '${gate}_whitelist_enabled': 'false',
      });
      expect(
          FeatureFlags.gateAllowed(gate,
              email: 'demo@example.com', defaultOn: false),
          isFalse);
    });
  });

  group('the wiring', () {
    /// Comment lines are stripped before matching: these files explain the gate
    /// at length and name it while doing so, and a scan over raw text would
    /// find the key inside the paragraph describing it and pass.
    String codeOf(String p) {
      final f = File(p);
      expect(f.existsSync(), isTrue, reason: '$p moved');
      return f
          .readAsStringSync()
          .split('\n')
          .where((l) =>
              !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('*'))
          .join('\n');
    }

    const home =
        'lib/src/features/uplift/presentation/views/uplift_home_screen.dart';
    const settings =
        'lib/src/features/settings/presentation/view/settings_screen.dart';

    test('the screen consults the gate before rendering the card', () {
      final code = codeOf(home);
      expect(code, contains('FeatureFlags.lazerfundsGuideCardEnabled'),
          reason: 'without this the card renders on first run regardless');
      expect(
          code,
          contains(RegExp(
              r'if\s*\(!FeatureFlags\.lazerfundsGuideCardEnabled\)\s*\{\s*\n\s*return UpliftTabInfoLink')),
          reason: 'the gate must choose the INFO LINK when closed, not merely '
              'be mentioned');
    });

    test('a gate flip repaints without a relaunch', () {
      final code = codeOf(home);
      expect(code, contains('valueListenable: FeatureFlags.revision'),
          reason: 'the background refresh applies the snapshot but tells no '
              'widget, so a flip would land only at next launch');
    });

    test('the Settings switch exists only while the card does', () {
      final code = codeOf(settings);
      expect(
          code,
          contains(
              'final lazerfundsGuidesEnabled = FeatureFlags.lazerfundsGuideCardEnabled;'),
          reason: 'a switch promising "explain each tab the first time you '
              'open it" must not be offered while no tab can show it');
      expect(code, contains('if (lazerfundsGuidesEnabled) lazerfundsGuidesTile'),
          reason: 'the search results list must be gated too — item search '
              'reaches tiles the grouped layout has dropped');
      expect(code, contains('if (lazerfundsGuidesEnabled) ...['),
          reason: 'the grouped layout must drop the tile AND its spacer');
      expect(code, contains('FeatureFlags.revision.addListener('));
      expect(code, contains('FeatureFlags.revision.removeListener('),
          reason: 'a listener left on a disposed State calls setState on it');
    });

    test('the admin dashboard actually lists the gate', () {
      final f = File(
          '../apps/admin-dashboard/src/app/settings/page/FeatureGatesTab.tsx');
      if (!f.existsSync()) {
        markTestSkipped('admin dashboard not reachable from here');
        return;
      }
      final tsx = f
          .readAsStringSync()
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(tsx, contains('domain: "explainer"'),
          reason: 'the key is feature_explainer_lazerfundsguide_available; the '
              'tab builds its keys from domain + id, so both halves must be '
              'present or the gate is unreachable from the dashboard');
      expect(tsx, contains('id: "lazerfundsguide"'));
      expect(tsx, contains('defaultOff: true'),
          reason: 'without this the dashboard draws the switch as ON while the '
              'app treats the same unset key as OFF — the operator would be '
              'looking at a lie');
    });
  });
}
