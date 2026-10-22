import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Pause tolerance is a value, not a constant.
///
/// Reported: the agent sends a turn before the user has finished speaking, and
/// hands-free needs more room to pause. The windows were compile-time constants
/// (3200/2500ms silence, 2200/1400ms grace), so the only way to correct them for
/// a market with a different speech rate was an app release.
///
/// They are now admin-tunable through the same /voice/session/start response that
/// already carries inputMode. The platform defaults have been retuned since
/// (a4a10713 cut the flat padding that fired after the user had finished), so
/// this pins the BAND they must stay in rather than the numbers themselves.
///
/// The cubit needs a live microphone, a platform recognizer and a LiveKit room to
/// exercise, so these read the source. What is worth pinning is the CLAMP and the
/// "no override" distinction — a 0 reaching the app as a real value would dispatch
/// a turn the instant the user paused, which is the exact behaviour the setting
/// exists to fix.
void main() {
  group('the app side', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/voice_session/cubit/voice_session_cubit.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'voice_session_cubit.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test('the windows are no longer compile-time constants', () {
      expect(
          source.contains('static final Duration _turnSilenceWindow'), isFalse,
          reason: 'a static final cannot be overridden per session');
      expect(source.contains('static final Duration _endOfTurnGraceWindow'),
          isFalse);
      expect(source, contains('Duration get _turnSilenceWindow'));
      expect(source, contains('Duration get _endOfTurnGraceWindow'));
    });

    test('the platform defaults stay inside a usable band', () {
      // THIS USED TO PIN EXACT LITERALS ('_isIOS ? 4000 : 3200') and it went
      // stale the moment the numbers were legitimately retuned: a4a10713 cut
      // the turn wait because the flat padding was firing after the user had
      // already finished, and the suite went red for a change that was
      // correct. A guard that fails on every intentional edit teaches people
      // to edit the guard, which is how it stops guarding anything.
      //
      // So pin the PROPERTY instead of the value. These are tuning knobs and
      // are meant to move; what must not happen is a number that breaks
      // turn-taking for everyone on the build.
      int platformDefault(String getter, bool ios) {
        final m = RegExp(
          'int get $getter => _isIOS \\? (\\d+) : (\\d+);',
        ).firstMatch(source);
        expect(m, isNotNull,
            reason: '$getter is no longer a platform-conditional int default '
                '— if the shape changed, update this test deliberately');
        return int.parse(m!.group(ios ? 1 : 2)!);
      }

      for (final ios in [true, false]) {
        final platform = ios ? 'iOS' : 'Android';

        // Below ~1.5s sits inside an ordinary mid-sentence pause, so the agent
        // would dispatch a turn while the user is still talking — the exact
        // complaint this setting was added to fix. Above ~6s the user has
        // concluded it is broken and starts repeating themselves.
        final silence = platformDefault('_turnSilenceDefaultMs', ios);
        expect(silence, inInclusiveRange(1500, 6000),
            reason: '$platform silence default is ${silence}ms');

        // The grace absorbs a continuation after a native "final". Too small
        // and a sentence gets split into two turns; too large and it is just
        // the silence window again.
        final grace = platformDefault('_graceDefaultMs', ios);
        expect(grace, inInclusiveRange(800, 4000),
            reason: '$platform grace default is ${grace}ms');
      }

      // The ternary exists because the two recognisers finalise differently —
      // iOS needs the longer wait. Equal is fine; shorter on iOS means the
      // branch is now backwards, which no band check would catch.
      expect(platformDefault('_turnSilenceDefaultMs', true),
          greaterThanOrEqualTo(platformDefault('_turnSilenceDefaultMs', false)));
      expect(platformDefault('_graceDefaultMs', true),
          greaterThanOrEqualTo(platformDefault('_graceDefaultMs', false)));
    });

    test('an override is read from the session-start response', () {
      expect(source, contains("_clampWindowMs(data['turnSilenceMs'])"));
      expect(source, contains("_clampWindowMs(data['endOfTurnGraceMs'])"));
    });

    test('the override is clamped, not trusted', () {
      // An admin typo must not break turn-taking for everyone on the build.
      expect(source, contains('if (ms < 600 || ms > 15000) return null;'),
          reason: 'below 600ms is inside a normal mid-sentence pause; past 15s '
              'the user has decided it is broken');
    });

    test('null means "keep the platform default", not zero', () {
      expect(source,
          contains('_silenceWindowMsOverride ?? _turnSilenceDefaultMs'));
      expect(source, contains('_graceWindowMsOverride ?? _graceDefaultMs'));
    });

    test('the long variants still derive from the tunable base', () {
      // Otherwise raising the base would silently stop widening the
      // incomplete-sentence window that goes with it.
      expect(source, contains('Duration get _endOfTurnGraceWindowLong =>'));
      expect(source, contains('_endOfTurnGraceWindow + _incompleteExtraWait'));
      expect(source, contains('_turnSilenceWindow + _incompleteExtraWait'));
    });
  });

  group('the mic indicator', () {
    late String cubit;
    late String sheet;

    setUpAll(() {
      cubit = File(
        'lib/src/features/voice_session/cubit/voice_session_cubit.dart',
      ).readAsStringSync();
      sheet = File(
        'lib/src/features/voice_session/widgets/voice_command_sheet.dart',
      ).readAsStringSync();
    });

    test('has a mode-independent signal', () {
      // isLocalListening is permanently false on a server configured for livekit
      // STT, so in hands-free the mic never turned green while the user spoke.
      expect(cubit, contains('bool get micIsHearingUser'));
      expect(cubit, contains('_localUserSpeaking'));
    });

    test('LiveKit voice activity is recorded before the dialog guard', () {
      // The visual-feedback guard exists to stop a dialog's state being
      // overwritten; the mic should still tell the truth while one is open.
      final idx =
          cubit.indexOf('_localUserSpeaking = event.participant.isSpeaking;');
      final guard = cubit.indexOf('if (_isVisualFeedbackActive) return;');
      expect(idx, greaterThan(-1));
      expect(guard, greaterThan(-1));
      expect(idx, lessThan(guard));
    });

    test('the flag is cleared on teardown and on disconnect', () {
      // LiveKit sends no trailing "stopped speaking" when the room goes away, so
      // without these the mic reads as live on a dead session.
      expect('_localUserSpeaking = false;'.allMatches(cubit).length,
          greaterThanOrEqualTo(2));
    });

    test('the sheet uses it rather than reading isLocalListening directly', () {
      expect(sheet, contains('cubit.micIsHearingUser'));
      expect(
          sheet.contains(
              '_isPtt ? cubit.isPttCapturing : cubit.isLocalListening'),
          isFalse);
    });
  });
}
