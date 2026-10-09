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
}
