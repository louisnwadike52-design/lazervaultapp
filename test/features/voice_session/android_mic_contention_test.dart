import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "THE VOICE AGENT STILL CAN'T HEAR ME" (Android), and the agent inaudible
/// on both platforms. Reported 2026-10-19.
///
/// Both come out of the hybrid-AEC design, which published the LiveKit mic
/// through the agent's turn. That earns its keep on iOS — it holds the
/// AVAudioSession category stable and keeps Apple's voice-processing I/O
/// unit (hardware AEC) engaged. On Android it pays for neither:
///
///   * ANDROID HAS ONE MIC CONSUMER. speech_to_text's SpeechRecognizer and a
///     published WebRTC capture track contend; whichever asks second loses.
///     listen() throws, and the only handling was a `print` — so the session
///     goes deaf with no error, no state and nothing on screen.
///   * THE RECOGNIZER TAKES AUDIO FOCUS. Starting it moves AudioManager to
///     MODE_IN_COMMUNICATION, ducking whatever is playing. Re-arming 350ms
///     after the agent's turn put that duck on the tail still leaving the
///     loudspeaker, every single turn.
///
/// Source-level because the defect is which platform does what with a shared
/// audio device: no return value distinguishes a ducked speaker from a loud
/// one, and the contention only reproduces on a real handset.

void main() {
  final src = File(
    '${Directory.current.path}/lib/src/features/voice_session/cubit/'
    'voice_session_cubit.dart',
  ).readAsStringSync();

  // Comments legitimately discuss the old behaviour; judge the code.
  final code = src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  test('the hybrid-AEC mic is iOS only', () {
    expect(code, contains('static bool get _hybridAecBargeIn => _isIOS;'),
        reason: 'publishing the LiveKit mic on Android contends with the '
            'SpeechRecognizer, and listen() then throws into a print');
    expect(code, isNot(contains('_hybridAecBargeIn = true')),
        reason: 'the flag is unconditional again');
  });

  test('a failed listen retries once instead of going silently deaf', () {
    expect(code, contains('_listenRetryPending'),
        reason: 'startLocalListening swallows a contention failure again');
    // Exactly one retry: a permanently contended mic must not spin behind a
    // silent UI.
    expect('_listenRetryPending = true'.allMatches(code).length, 1);
    expect('_listenRetryPending = false'.allMatches(code).length, 2,
        reason: 'the guard must be cleared on the retry path and declared '
            'false — any other count means the latch leaked');
  });

  test('android re-arms only after the loudspeaker tail', () {
    expect(code, contains('_androidReArmDelayMs'));
    expect(code, contains('static const int _androidReArmDelayMs = 1500;'),
        reason: 'must match VoiceEchoGuard.tailWindow — the same physical '
            'tail, named once, or the two drift');
    expect(code, isNot(contains('_isIOS ? 200 : 350')),
        reason: 'the 350ms Android re-arm is back, so the recognizer audio-'
            'focus duck lands on the agent\'s last words again');
  });

  test('the echo guard still owns the tail number', () {
    final guard = File(
      '${Directory.current.path}/lib/src/features/voice_session/'
      'voice_echo_guard.dart',
    ).readAsStringSync();
    expect(guard, contains('milliseconds: 1500'),
        reason: 'VoiceEchoGuard.tailWindow changed but the Android re-arm '
            'delay did not — they describe the same loudspeaker tail');
  });

  test('iOS keeps the fast re-arm', () {
    expect(code, contains('_isIOS ? 200 :'),
        reason: 'iOS has no focus-duck to avoid; waiting there only makes '
            'the mic slower to open');
  });
}
