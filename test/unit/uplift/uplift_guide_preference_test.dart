import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/features/uplift/data/services/uplift_guide_preference.dart';

/// Pins the LazerFunds guide preference.
///
/// Two ideas that must not collapse into one flag: SEEN (this tab has shown its
/// explainer) and DISMISSED (the user said never again). Collapsing them would
/// make the Settings toggle a switch that appears to do nothing, and would
/// leave the help icon with nothing to restore.
void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('first run', () {
    test('every tab shows its explainer initially', () async {
      for (final tab in UpliftGuidePreference.allTabs) {
        expect(await UpliftGuidePreference.shouldShow(tab), isTrue,
            reason: '$tab should explain itself on first open');
      }
    });

    test('seeing one tab does not consume another', () async {
      // Arriving at My Applications for the first time is a first run for THAT
      // idea, even if Discover was read weeks ago — the tabs explain different
      // things.
      await UpliftGuidePreference.markSeen(UpliftGuidePreference.tabDiscover);

      expect(
          await UpliftGuidePreference.shouldShow(
              UpliftGuidePreference.tabDiscover),
          isFalse);
      expect(
          await UpliftGuidePreference.shouldShow(
              UpliftGuidePreference.tabMyApplications),
          isTrue);
    });
  });

  group("don't show again", () {
    test('silences every tab, including unseen ones', () async {
      await UpliftGuidePreference.setDismissed(true);
      for (final tab in UpliftGuidePreference.allTabs) {
        expect(await UpliftGuidePreference.shouldShow(tab), isFalse,
            reason: 'a standing choice must outrank per-tab state');
      }
    });

    test('re-enabling actually shows them again', () async {
      // The trap this guards: if turning the setting back on left the per-tab
      // SEEN marks in place, the switch would read as ON while nothing ever
      // appeared — a control that visibly lies.
      await UpliftGuidePreference.markSeen(UpliftGuidePreference.tabDiscover);
      await UpliftGuidePreference.markSeen(UpliftGuidePreference.tabMyFunds);
      await UpliftGuidePreference.setDismissed(true);

      await UpliftGuidePreference.setDismissed(false);

      for (final tab in UpliftGuidePreference.allTabs) {
        expect(await UpliftGuidePreference.shouldShow(tab), isTrue,
            reason: 'turning guides back on must actually show them');
      }
    });
  });

  group('help icon', () {
    test('replays a tab that was already seen', () async {
      await UpliftGuidePreference.markSeen(UpliftGuidePreference.tabMyFunds);
      await UpliftGuidePreference.replay(UpliftGuidePreference.tabMyFunds);

      expect(
          await UpliftGuidePreference.shouldShow(
              UpliftGuidePreference.tabMyFunds),
          isTrue);
    });

    test('replay leaves the standing choice alone', () async {
      // "Don't show automatically" is not "refuse me help when I ask". Replay
      // must not quietly re-enable unprompted guides everywhere.
      await UpliftGuidePreference.setDismissed(true);
      await UpliftGuidePreference.replay(UpliftGuidePreference.tabDiscover);

      expect(await UpliftGuidePreference.isDismissed(), isTrue,
          reason: 'asking for help once must not undo the standing choice');
    });
  });

  test('marking seen is idempotent', () async {
    await UpliftGuidePreference.markSeen(UpliftGuidePreference.tabDiscover);
    await UpliftGuidePreference.markSeen(UpliftGuidePreference.tabDiscover);
    expect(
        await UpliftGuidePreference.shouldShow(
            UpliftGuidePreference.tabDiscover),
        isFalse);
  });
}
