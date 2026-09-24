import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regression guards for the push-to-talk turn boundary.
///
/// Reported from a device: in tap / hold / double-tap the turn was submitted
/// before the user released or tapped back, and pausing mid-sentence sent it.
///
/// The gesture wiring was never the problem — `pttEnd()` has always
/// force-dispatched on release. The problem was that THREE independent clocks
/// stayed armed during a gesture turn and whichever fired first won:
///
///   1. `_endOfTurnTimer`  — ~2.2s iOS / 1.4s Android after a final result
///   2. `_turnSilenceTimer` — ~3.2s iOS / 2.5s Android of no partials
///   3. `pauseFor` on the platform recognizer — same windows, and this one
///      stops the microphone outright, so the rest of the sentence is not even
///      captured
///
/// These read the source rather than driving the cubit because all three paths
/// need a live microphone, a platform speech recognizer and a LiveKit room to
/// reach. What is worth pinning is that each clock still refuses to arm in a
/// gesture mode — a future edit that drops one of the guards would restore a
/// bug whose only symptom is "it sent before I finished", which is easy to
/// misread as a transcription problem.
void main() {
  late String source;

  setUpAll(() {
    final file = File(
      'lib/src/features/voice_session/cubit/voice_session_cubit.dart',
    );
    expect(file.existsSync(), isTrue,
        reason: 'voice_session_cubit.dart moved — update this test');
    source = file.readAsStringSync();
  });

  /// Returns the body of a named method, bounded by the next same-indent close.
  String bodyOf(String signature) {
    final start = source.indexOf(signature);
    expect(start, greaterThan(-1), reason: 'not found: $signature');
    final end = source.indexOf('\n  }', start);
    expect(end, greaterThan(start), reason: 'could not bound: $signature');
    return source.substring(start, end);
  }

  group('only the gesture ends a push-to-talk turn', () {
    test('the end-of-turn grace timer does not arm', () {
      // The guard sits immediately before graceWindow is computed.
      final idx = source.indexOf('final graceWindow =');
      expect(idx, greaterThan(-1));
      final preceding = source.substring(idx - 900, idx);
      expect(preceding, contains('if (isPushToTalk) return;'),
          reason: 'the grace timer must not arm in hold/tap/double_tap — it '
              'dispatched the turn ~2.2s into any pause, while the finger was '
              'still down');
    });

    test('the client silence timer does not arm', () {
      final idx = source.indexOf('final silenceWindow =');
      expect(idx, greaterThan(-1));
      final preceding = source.substring(idx - 900, idx);
      expect(preceding, contains('if (isPushToTalk) return;'),
          reason: 'the silence timer must not arm in a gesture mode — it cut '
              'off slower speakers mid-thought while they held the button');
    });

    test('the recognizer is not told to stop on a pause', () {
      // pauseFor must be mode-dependent. A bare Duration(milliseconds: …) here
      // means the platform recognizer still halts capture during a long pause,
      // which is the one failure the other two guards cannot compensate for —
      // the audio is simply never heard.
      expect(source, contains('pauseFor: isPushToTalk'),
          reason: 'pauseFor must branch on the mode; in PTT the recognizer '
              'must keep listening until the gesture ends');
    });

    test('pttEnd is still the thing that dispatches', () {
      // The guards above only make sense while the gesture path still commits.
      expect(bodyOf('Future<void> pttEnd() async {'),
          contains('_dispatchUserTurn('),
          reason: 'if pttEnd stops dispatching, disarming the timers leaves no '
              'way to submit a turn at all');
    });
  });

  group('pressing to talk interrupts the agent', () {
    test('pttBegin triggers barge-in when the agent is speaking', () {
      final body = bodyOf('Future<void> pttBegin() async {');
      expect(body, contains('_agentSpeaking'),
          reason: 'pttBegin must notice the agent is mid-sentence');
      expect(body, contains('_triggerBargeIn()'),
          reason: 'reaching for the button IS the interruption. Waiting for '
              'the acoustic detector needs two non-echo words first, so the '
              'agent talks over the start of the reply');
    });

    test('the barge-in it calls still publishes an interrupt', () {
      // _triggerBargeIn is what reaches the gateway; if it stops publishing,
      // the local flags clear but the agent keeps talking.
      expect(bodyOf('void _triggerBargeIn() {'), contains('_publishInterrupt()'),
          reason: 'clearing local state without telling the gateway leaves the '
              'agent speaking into a muted client');
    });
  });
}
