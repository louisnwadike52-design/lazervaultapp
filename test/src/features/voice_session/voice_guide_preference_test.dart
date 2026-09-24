import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/data/voice_guide_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The voice session had no guidance at all.
///
/// The interaction mode decides whether you hold, tap, tap-back or just speak,
/// and nothing on the sheet said which — so the only way to learn was to guess,
/// and a wrong guess looked like a broken mic.
///
/// The preference behind the guidance keeps a standing DISMISSED choice separate
/// from per-surface SEEN marks. That separation is the whole design: with one flag,
/// turning guidance back on shows nothing (everything is still marked seen) and
/// the settings switch is a lie.
void main() {
  const alice = 'user-alice';
  const bob = 'user-bob';

  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('first run', () {
    test('a fresh user sees each surface', () async {
      for (final surface in VoiceGuidePreference.allSurfaces) {
        expect(await VoiceGuidePreference.shouldShow(alice, surface), isTrue);
      }
    });

    test('nothing is dismissed by default', () async {
      expect(await VoiceGuidePreference.isDismissed(alice), isFalse);
    });
  });

  group('seen marks', () {
    test('a surface shown once is not shown again', () async {
      await VoiceGuidePreference.markSeen(
          alice, VoiceGuidePreference.surfaceSessionTip);
      expect(
        await VoiceGuidePreference.shouldShow(
            alice, VoiceGuidePreference.surfaceSessionTip),
        isFalse,
      );
    });

    test('marking one surface does not mark the others', () async {
      await VoiceGuidePreference.markSeen(
          alice, VoiceGuidePreference.surfaceSessionTip);
      expect(
        await VoiceGuidePreference.shouldShow(
            alice, VoiceGuidePreference.surfaceModeCoachMark),
        isTrue,
      );
    });
  });

  group('the standing choice', () {
    test('dismissing hides every surface', () async {
      await VoiceGuidePreference.setDismissed(alice, true);
      for (final surface in VoiceGuidePreference.allSurfaces) {
        expect(await VoiceGuidePreference.shouldShow(alice, surface), isFalse);
      }
      expect(await VoiceGuidePreference.isDismissed(alice), isTrue);
    });

    test('re-enabling CLEARS the seen marks, so the switch is not a lie',
        () async {
      // The bug this prevents: turn tips off, turn them back on, and nothing
      // appears because every surface is still marked seen.
      await VoiceGuidePreference.markSeen(
          alice, VoiceGuidePreference.surfaceSessionTip);
      await VoiceGuidePreference.setDismissed(alice, true);
      await VoiceGuidePreference.setDismissed(alice, false);

      for (final surface in VoiceGuidePreference.allSurfaces) {
        expect(await VoiceGuidePreference.shouldShow(alice, surface), isTrue,
            reason: '$surface should be shown again after re-enabling');
      }
    });
  });

  group('replayAll', () {
    test('works for someone who never dismissed anything', () async {
      // The "Show again" button's case. setDismissed(false) alone would not help
      // them, because they were never dismissed — only the seen marks are in the
      // way, which is exactly the person most likely to press it.
      await VoiceGuidePreference.markSeen(
          alice, VoiceGuidePreference.surfaceSessionTip);
      await VoiceGuidePreference.markSeen(
          alice, VoiceGuidePreference.surfaceModeCoachMark);
      expect(await VoiceGuidePreference.isDismissed(alice), isFalse);

      await VoiceGuidePreference.replayAll(alice);

      for (final surface in VoiceGuidePreference.allSurfaces) {
        expect(await VoiceGuidePreference.shouldShow(alice, surface), isTrue);
      }
    });

    test('also lifts a standing dismissal', () async {
      await VoiceGuidePreference.setDismissed(alice, true);
      await VoiceGuidePreference.replayAll(alice);
      expect(await VoiceGuidePreference.isDismissed(alice), isFalse);
      expect(
        await VoiceGuidePreference.shouldShow(
            alice, VoiceGuidePreference.surfaceSessionTip),
        isTrue,
      );
    });
  });

  group('scoping', () {
    test('one user cannot consume another user first run', () async {
      // A second account on the same phone gets its own first run rather than
      // inheriting someone else's.
      await VoiceGuidePreference.markSeen(
          alice, VoiceGuidePreference.surfaceSessionTip);
      await VoiceGuidePreference.setDismissed(alice, true);

      expect(await VoiceGuidePreference.isDismissed(bob), isFalse);
      expect(
        await VoiceGuidePreference.shouldShow(
            bob, VoiceGuidePreference.surfaceSessionTip),
        isTrue,
      );
    });

    test('an empty uid never shows and never writes', () async {
      // The screens render before the profile lands. Writing to a shared key
      // there would leak one user's state onto the next.
      expect(
        await VoiceGuidePreference.shouldShow(
            '', VoiceGuidePreference.surfaceSessionTip),
        isFalse,
      );
      await VoiceGuidePreference.setDismissed('', true);
      await VoiceGuidePreference.markSeen(
          '', VoiceGuidePreference.surfaceSessionTip);
      // Alice is untouched.
      expect(
        await VoiceGuidePreference.shouldShow(
            alice, VoiceGuidePreference.surfaceSessionTip),
        isTrue,
      );
    });
  });
}
