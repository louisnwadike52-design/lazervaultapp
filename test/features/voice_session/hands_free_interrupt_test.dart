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
}
