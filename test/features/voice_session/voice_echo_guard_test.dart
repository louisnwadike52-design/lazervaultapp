import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/voice_echo_guard.dart';

void main() {
  // The exact production failure, verbatim from the device.
  const agentSaid =
      "I'm still waiting for your pin. To finish that, no problem — "
      "would you like to try entering your pin again?";
  // What the microphone heard of it, including the "pin" -> "pain" mis-hear
  // that defeated the old exact-token check.
  const micHeard =
      "I'm still waiting for your pin to finish that no problem would you "
      "like to try entering your pain again";

  final t0 = DateTime.utc(2026, 10, 9, 19, 0, 0);

  group('the production failure', () {
    test('the agent\'s own sentence is not attributed to the user', () {
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      g.noteAgentStoppedSpeaking(t0);
      // Arrives 300ms AFTER the agent stopped — the window where the old code
      // had no suppression at all, because _agentSpeaking was already false.
      final later = t0.add(const Duration(milliseconds: 300));
      expect(g.isEcho(micHeard, later, agentIsSpeaking: false), isTrue);
    });

    test('still caught while the agent is actively speaking', () {
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      expect(g.isEcho(micHeard, t0, agentIsSpeaking: true), isTrue);
    });
  });

  group('the three holes, each pinned', () {
    test('hole 1: suppression extends past the end of agent speech', () {
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      g.noteAgentStoppedSpeaking(t0);
      expect(g.inTailWindow(t0.add(const Duration(milliseconds: 900))), isTrue);
      // ...but not forever: the user must be able to speak again promptly.
      expect(g.inTailWindow(t0.add(const Duration(seconds: 3))), isFalse);
    });

    test('hole 2: no remembered caption defaults to echo, not to user', () {
      // This is the state right after a barge-in nulls the caption.
      final g = VoiceEchoGuard();
      g.noteAgentStoppedSpeaking(t0);
      expect(
        g.isEcho('would you like to try again', t0, agentIsSpeaking: true),
        isTrue,
      );
    });

    test('hole 3: a one-letter mis-hear still matches', () {
      final g = VoiceEchoGuard()..noteAgentUtterance('please enter your pin');
      g.noteAgentStoppedSpeaking(t0);
      expect(g.isEcho('please enter your pain', t0, agentIsSpeaking: false),
          isTrue);
    });
  });

  group('it must not swallow the real user', () {
    test('genuine speech outside the tail window passes through', () {
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      g.noteAgentStoppedSpeaking(t0);
      final later = t0.add(const Duration(seconds: 5));
      expect(g.isEcho('send two thousand naira to John', later,
              agentIsSpeaking: false),
          isFalse);
    });

    test('a real interruption during agent speech is NOT echo', () {
      // The user barging in with something the agent never said must still get
      // through, or barge-in is dead.
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      expect(
        g.isEcho('no stop cancel that transfer', t0, agentIsSpeaking: true),
        isFalse,
      );
    });

    test('short confirmations during the tail are treated as echo only when '
        'they match the agent', () {
      final g = VoiceEchoGuard()..noteAgentUtterance('would you like to try again');
      g.noteAgentStoppedSpeaking(t0);
      final inTail = t0.add(const Duration(milliseconds: 200));
      // "yes" is the user answering — the agent did not say it.
      expect(g.isEcho('yes', inTail, agentIsSpeaking: false), isFalse);
    });

    test('reset clears the window so a new turn is never suppressed', () {
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      g.noteAgentStoppedSpeaking(t0);
      g.reset();
      expect(g.isEcho(micHeard, t0, agentIsSpeaking: false), isFalse);
    });
  });

  group('short tokens must not collapse into each other', () {
    test('"no" and "go" are different words', () {
      final g = VoiceEchoGuard()..noteAgentUtterance('go ahead');
      // "no thanks" shares no real token with "go ahead"; a naive one-edit
      // rule on short words would match no/go and suppress the user.
      expect(g.isEcho('no thanks', t0, agentIsSpeaking: true), isFalse);
    });
  });

  // ── WHAT THE GUARD IS ANCHORED TO ──
  //
  // The guard was correct and still failed in production, because of what it
  // was WIRED to. It was armed by the caption flag (_agentSpeaking) plus a
  // 1.5s tail, and captions are TEXT: a sentence streams as text in a few
  // hundred milliseconds and then takes seconds to actually speak. So the
  // guard disarmed mid-sentence and the rest of Nova's own words were
  // transcribed as the user's, inside a transfer waiting on a PIN.
  group('the guard must be anchored to AUDIO, not caption text', () {
    test('a caption-anchored tail disarms while the speaker is still talking',
        () {
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      // Caption stream ended at t0. The audio has four more seconds to run.
      g.noteAgentStoppedSpeaking(t0);
      final midSentence = t0.add(const Duration(seconds: 4));
      // THIS is the production bug, reproduced: the real tail outlasts the
      // window, so the echo is handed through as the user.
      expect(g.isEcho(micHeard, midSentence, agentIsSpeaking: false), isFalse,
          reason: 'documents WHY the anchor had to move; if this ever starts '
              'returning true the tail window grew and this test is no longer '
              'describing the hazard');
    });

    test('anchored to audio, the same moment is still suppressed', () {
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      // Audio-anchored: the agent counts as speaking until the SOUND stops, so
      // the flag is still true four seconds in.
      final midSentence = t0.add(const Duration(seconds: 4));
      expect(g.isEcho(micHeard, midSentence, agentIsSpeaking: true), isTrue);
    });

    test('the tail window runs from the end of the AUDIO', () {
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      // Sound stopped four seconds after the captions did.
      final audioEnded = t0.add(const Duration(seconds: 4));
      g.noteAgentStoppedSpeaking(audioEnded);
      expect(
        g.isEcho(micHeard, audioEnded.add(const Duration(milliseconds: 300)),
            agentIsSpeaking: false),
        isTrue,
        reason: 'reverb right after the speaker goes quiet is still the agent',
      );
    });

    test('and a real user turn after that window still gets through', () {
      // The guard must not become a mute button. This is the cost side of the
      // trade and it has to keep working.
      final g = VoiceEchoGuard()..noteAgentUtterance(agentSaid);
      final audioEnded = t0.add(const Duration(seconds: 4));
      g.noteAgentStoppedSpeaking(audioEnded);
      expect(
        g.isEcho('yes send five thousand naira to my brother',
            audioEnded.add(const Duration(seconds: 2)),
            agentIsSpeaking: false),
        isFalse,
      );
    });
  });

  // The guard above was already correct when production failed. What was wrong
  // was what it was CONNECTED to, and that is not reachable from a unit test —
  // so it is pinned at the source instead.
  group('the cubit wiring the guard depends on', () {
    String cubit() => File(
          'lib/src/features/voice_session/cubit/voice_session_cubit.dart',
        ).readAsStringSync();

    test('the echo gate asks whether the agent is AUDIBLE', () {
      expect(cubit().contains('agentIsSpeaking: _agentAudible'), isTrue,
          reason: 'the echo gate is back on the caption flag, so it disarms '
              'seconds before the speaker goes quiet');
    });

    test('audibility includes the live audio track, not just captions', () {
      expect(
          cubit().contains('_agentSpeaking || _agentAudioAudible'), isTrue,
          reason: 'the only signal that tracks real playback has been dropped');
    });

    test('the remote participant feeds it', () {
      // Before this, SpeakingChangedEvent handled ONLY the local participant;
      // the agent's own speaking events were discarded.
      expect(cubit().contains('event.participant != local'), isTrue,
          reason: 'remote speaking events are ignored again, so nothing '
              'observes when the agent actually stops making sound');
    });

    test('"remote" is established positively, never by null', () {
      // `participant != localParticipant` is ALSO true when localParticipant
      // is null -- during setup, or after a disconnect. Classifying the local
      // participant as the agent there arms the echo guard the instant the
      // USER speaks and suppresses them: the bug inverted.
      final src = cubit();
      expect(src.contains('final local = _room?.localParticipant'), isTrue);
      expect(src.contains('if (local != null && event.participant != local)'),
          isTrue,
          reason: 'an unidentifiable participant must be treated as neither '
              'side, not as the agent');
    });

    test('teardown clears it', () {
      // A stuck-true flag means the guard suppresses EVERY utterance of the
      // next session: a deaf agent, which is worse than the echo.
      expect(cubit().contains('_agentAudioAudible = false'), isTrue);
    });

    test('the loudspeaker is re-asserted, not set once at connect', () {
      // Asserting only at connect is what made the agent inaudible after a mic
      // publish or the transaction-PIN sheet: another component reconfigures the
      // audio session and hands it back with the route changed.
      //
      // On iOS the re-assertion is cheap and idempotent — Hardware's iOS branch
      // re-invokes onConfigureNativeAudio, which is PINNED to
      // playAndRecordSpeaker, so it restores our own configuration rather than
      // imposing a different one. It was briefly removed on the theory that it
      // caused the agent's level to swing; it does not. That was LiveKit's
      // DEFAULT configuration function returning `playback` (spokenAudio) while
      // remote-only and `playAndRecordSpeaker` (videoChat) once the AEC mic
      // published — two different output curves, swapped every turn. The pin at
      // the Room construction site is what fixed it.
      final src = cubit();
      expect(
        RegExp(r'_assertLoudspeaker\(\)').allMatches(src).length,
        greaterThanOrEqualTo(4),
        reason: 'asserting the speaker only at connect is what made the agent '
            'inaudible after a mic publish or the transaction-PIN sheet',
      );
    });
  });
}
