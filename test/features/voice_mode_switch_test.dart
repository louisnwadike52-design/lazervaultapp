import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Switching talk mode mid-session must move EVERY system that depends on it.
///
/// THE BUGS THIS CATCHES, ALL LIVE
/// -------------------------------
/// Talk mode decides who captures audio. Push-to-talk always captures on device;
/// hands-free follows the admin `voice_stt_input_mode`. So a live switch can flip
/// the capture OWNER — and four separate things have to move with it. Three did not:
///
///   1. **The LiveKit mic track.** Set only in the connect path, so a switch left
///      it in the previous mode's state. Hands-free → PTT left it PUBLISHED while
///      the device recognizer also ran: every turn transcribed twice, by two
///      engines, arriving split. PTT → hands-free left it UNPUBLISHED with the
///      device recognizer stopped, so nothing was capturing at all.
///   2. **The capture announcement.** `_announceCaptureMode` returned early unless
///      on-device, so it could only ever say "on_device" — there was no packet
///      meaning "I stopped capturing, you take over".
///   3. **The server's latch.** `client_capture` set `_client_stt = True` and
///      nothing cleared it. One PTT turn disabled server STT for the whole
///      session; combined with (2), hands-free went permanently deaf afterwards.
///   4. **Barge-in** was `static const false`, so the mic stayed shut for the whole
///      agent turn and no gesture could interrupt it.
///
/// Source assertions: the behaviour needs LiveKit, a live room, an authenticated
/// session and a real microphone. What is cheap and durable is that the wiring has
/// not drifted back.

final _cubit = File(
  'lib/src/features/voice_session/cubit/voice_session_cubit.dart',
).readAsStringSync();

/// The code of a named method, comments stripped.
///
/// Every fix here is documented in a comment quoting the shape it replaced, so an
/// un-stripped search matches its own rationale and fails on correct code.
String _method(String source, String signature) {
  final start = source.indexOf(signature);
  // A plain throw, not `expect` — this is called while groups are being declared,
  // and matcher's expect outside a running test raises OutsideTestException.
  if (start == -1) throw StateError('method not found: $signature');
  final rest = source.substring(start);
  final end = rest.indexOf('\n  }\n');
  return rest
      .substring(0, end == -1 ? rest.length : end)
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');
}

void main() {
  group('a live mode switch moves the capture owner', () {
    final body = _method(_cubit, 'void setInteractionMode(String mode)');

    test('re-resolves who owns capture', () {
      expect(body, contains('_resolveOnDeviceMode()'));
    });

    test('moves the LiveKit mic track', () {
      // Without this the track keeps the old mode's state: dual capture one way,
      // silence the other.
      expect(
        body,
        contains('_applyCaptureOwnership()'),
        reason: 'the mic track must follow the capture owner on a live switch, '
            'not only at connect',
      );
    });

    test('tells the agent, in BOTH directions', () {
      expect(body, contains('_announceCaptureMode()'));
      final announce = _method(_cubit, 'void _announceCaptureMode()');
      expect(
        announce.contains("!_onDeviceMode) return"),
        isFalse,
        reason: 'announcing only on-device leaves no way to hand capture BACK to '
            'the server, so server STT stays latched off',
      );
      expect(announce, contains("'livekit'"),
          reason: 'the livekit ownership case must be announceable');
    });

    test('does not bin a turn captured under the old mode', () {
      // Switching mid-hold used to drop whatever had been said.
      expect(body, contains('_dispatchUserTurn(pending)'));
    });

    test('resets the per-turn barge-in guard', () {
      expect(body, contains('_bargedInThisTurn = false'));
    });

    test('only re-arms the LOCAL recognizer when capture is local', () {
      // Re-arming on the LiveKit path would open a recognizer that must stay shut.
      expect(body, contains('if (_onDeviceMode) _reArmListeningSoon()'));
    });
  });

  group('capture ownership rules', () {
    final own = _method(_cubit, 'Future<void> _applyCaptureOwnership()');

    test('publishes the mic only for server capture', () {
      expect(own, contains('!_onDeviceMode'));
    });

    test('mute wins over the capture owner', () {
      // A muted session must never publish, whoever owns capture.
      expect(own, contains('!_isMuted'),
          reason: 'a muted session must not publish a track');
    });

    test('a failed toggle does not kill the session', () {
      expect(own, contains('catch'));
    });
  });

  group('barge-in', () {
    test('is derived from the mode, not a compile-time constant', () {
      // `static const bool _bargeInEnabled = false` compiled the whole barge-in
      // path out, so the user could never interrupt the agent.
      expect(
        _cubit.contains('static const bool _bargeInEnabled'),
        isFalse,
        reason: 'a const false removes every interrupt path at compile time',
      );
      expect(_cubit, contains('bool get _bargeInEnabled => isPushToTalk'));
    });
  });

  group('the recognizer is initialised on demand', () {
    test('startLocalListening initialises before gating', () {
      // _initSpeech used to be reachable only from the connect path, behind a
      // flag resolved BEFORE the async talk-mode load delivered the real mode.
      final body = _method(_cubit, 'Future<void> startLocalListening()');
      final init = body.indexOf('_initSpeech()');
      final gate = body.indexOf('_listeningPermitted()');
      expect(init, isNot(-1), reason: 'must initialise on demand');
      expect(init < gate, isTrue,
          reason: 'initialising AFTER the !_sttAvailable gate never runs');
    });

    test('an unusable recognizer is reported, not swallowed', () {
      expect(_cubit, contains('_reportSttUnavailable()'));
      expect(_cubit, contains('bool get sttUnavailable'));
    });
  });
}
