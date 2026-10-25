import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/voice_audio_route_policy.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_talk_affordance.dart';

void main() {
  group('the recogniser never runs under the agent', () {
    test('policy refuses the mic for the whole agent phase', () {
      // Prevention, not filtering. Android runs under the media profile, which
      // has no echo canceller, so an open recogniser submits the agent's own
      // sentence as the user's turn.
      expect(recogniserMayOpenWhileAgentSpeaks(), isFalse);
    });

    test('the open-mic acoustic barge-in timer is gone, not merely gated', () {
      final src = File(
              'lib/src/features/voice_session/cubit/voice_session_cubit.dart')
          .readAsStringSync();
      // The shape that used to reopen the mic 700 ms into the agent's audio.
      expect(
        src.contains('if (_agentSpeaking && _listeningPermitted())'),
        isFalse,
        reason: 'the acoustic open-mic barge-in is back; it cannot run without '
            'an echo canceller',
      );
      expect(src.contains('recogniserMayOpenWhileAgentSpeaks()'), isTrue,
          reason: 'the agent-phase gate was removed from _listeningPermitted');
    });
  });

  group('hands-free can interrupt', () {
    test('the cubit exposes a public interrupt', () {
      final src = File(
              'lib/src/features/voice_session/cubit/voice_session_cubit.dart')
          .readAsStringSync();
      expect(src.contains('void interruptAgent()'), isTrue);
      // Continuous mode must route the control's tap into it rather than
      // returning silently — otherwise hands-free has no interrupt at all.
      expect(
        RegExp(r'if \(!isPushToTalk\) \{\s*\n(\s*//[^\n]*\n)*\s*interruptAgent\(\);')
            .hasMatch(src),
        isTrue,
        reason: 'pttBegin no longer interrupts in continuous mode',
      );
    });

    test('both ways a turn ends share one mic handoff', () {
      final src = File(
              'lib/src/features/voice_session/cubit/voice_session_cubit.dart')
          .readAsStringSync();
      // iOS holds LiveKit's AEC mic through the agent phase; dropping it before
      // the recogniser opens is the step that must not drift between the
      // agent-finished path and the user-interrupted path.
      expect(
        RegExp(r'_handBackMicAfterAgentTurn\(\)').allMatches(src).length,
        greaterThanOrEqualTo(3),
        reason: 'expected the definition plus both call sites',
      );
    });

    test('the label names the interrupt while the agent speaks', () {
      expect(
        VoiceTalkMode.action(VoiceTalkMode.continuous,
            capturing: false, agentSpeaking: true),
        'Tap to stop',
      );
      // And stays an indicator the rest of the time.
      expect(
        VoiceTalkMode.action(VoiceTalkMode.continuous, capturing: false),
        'Hands-free',
      );
      expect(
        VoiceTalkMode.action(VoiceTalkMode.continuous, capturing: true),
        'Listening',
      );
    });
  });

  group('a lost end-of-speech event cannot strand the mic', () {
    late String src;
    setUpAll(() {
      src = File(
              'lib/src/features/voice_session/cubit/voice_session_cubit.dart')
          .readAsStringSync();
    });

    test('the speech phase is watched, not just the reply', () {
      // _armAgentReplyWatchdog covers "the reply never came" and the
      // speech-start handler cancels it — correctly. From then on nothing was
      // watching, while the recogniser was refused for the whole agent phase
      // and the listen watchdog honoured that same gate.
      expect(src.contains('void _armAgentSpeechWatchdog()'), isTrue);
      final startAt = src.indexOf('_bargedInThisTurn = false;');
      final armAt = src.indexOf('_armAgentSpeechWatchdog();');
      expect(startAt, greaterThan(-1));
      expect(armAt, greaterThan(startAt),
          reason: 'the watchdog is not armed where the agent phase begins');
    });

    test('it is disarmed on every way the phase can end', () {
      // The real end event, a barge-in, and session teardown. Missing any one
      // of these either leaves it armed into the next turn or fires it after
      // dispose.
      expect(RegExp(r'_cancelAgentSpeechWatchdog\(\)').allMatches(src).length,
          greaterThanOrEqualTo(3),
          reason: 'expected the definition plus the end-of-speech and '
              'barge-in call sites');
      expect(src.contains('_agentSpeechWatchdog?.cancel();'), isTrue,
          reason: 'not cancelled in close() — the timer outlives the session');
    });

    test('recovery clears the echo gate as well as the flag', () {
      // Clearing _agentSpeaking alone re-opens the mic into an echo gate that
      // is still swallowing the user, which looks identical to a dead mic.
      final body = src.substring(src.indexOf('void _armAgentSpeechWatchdog()'),
          src.indexOf('void _cancelAgentSpeechWatchdog()'));
      expect(body.contains('_setAgentAudioAudible(false)'), isTrue);
      expect(body.contains('_handBackMicAfterAgentTurn()'), isTrue,
          reason: 'recovery must drop the iOS AEC mic before reopening the '
              'recogniser, like the normal end-of-turn path');
    });
  });
}
