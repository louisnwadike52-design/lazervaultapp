import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Closing the voice sheet must END the call, not just drop the media connection.
///
/// THE BUG THIS CATCHES, WHICH WAS LIVE
/// ------------------------------------
/// The sheet's X called `disconnectFromLiveKitRoom(fullCleanup: true)`. That tears down
/// LiveKit and the socket, but it never emits `VoiceSessionEnded` and never closes the
/// conversation record — so the call ended silently, with no end reason, and the
/// conversation sat in history with no end time. The swipe-down / back dismissal in
/// dispose() had exactly the same flaw.
///
/// Every page and quick-service voice entry point renders the SAME VoiceCommandSheet
/// (16 launch sites), so this one handler is the whole surface.
///
/// Asserted against the source because the behaviour lives in a 4,500-line stateful
/// widget whose live path needs LiveKit, a socket and an authenticated session. What can
/// be checked cheaply and durably is that the teardown calls have not drifted back.

final _sheet = File(
  'lib/src/features/voice_session/widgets/voice_command_sheet.dart',
).readAsStringSync();

final _cubit = File(
  'lib/src/features/voice_session/cubit/voice_session_cubit.dart',
).readAsStringSync();

/// The CODE of a named method, with comments stripped.
///
/// Comments are removed because these assertions check which teardown call a method
/// makes, and the explanatory comments beside those calls name the very method being
/// asserted absent — "must not still call disconnectFromLiveKitRoom" would match its own
/// rationale and fail on correct code.
String _method(String source, String signature) {
  final start = source.indexOf(signature);
  expect(start, isNot(-1), reason: 'method not found: $signature');
  final rest = source.substring(start);
  final end = rest.indexOf('\n  }\n');
  final body = rest.substring(0, end == -1 ? rest.length : end);
  return body
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');
}

void main() {
  group('closing the voice sheet', () {
    test('the X ends the session rather than only disconnecting', () {
      final body = _method(_sheet, 'void _closeSheet()');
      expect(
        body.contains('endSession('),
        isTrue,
        reason: 'the close button must END the call — disconnecting alone leaves the '
            'session unterminated and emits no VoiceSessionEnded',
      );
      expect(
        body.contains('disconnectFromLiveKitRoom'),
        isFalse,
        reason: 'disconnect alone was the bug; endSession already performs the teardown',
      );
    });

    test('the close records WHY the call ended', () {
      // Without a reason an operator cannot tell a deliberate hang-up from a dropped
      // connection, and those need very different follow-up.
      expect(_method(_sheet, 'void _closeSheet()'), contains('endReason:'));
    });

    test('an already-ended session is not ended twice', () {
      // The same handler backs the close button on the call-ended / rating view, which
      // exists only because the session ended. Re-ending it would emit a second terminal
      // state and move the conversation's recorded end time to the dismissal.
      expect(
        _method(_sheet, 'void _closeSheet()'),
        contains('is! VoiceSessionEnded'),
      );
    });

    test('dismissing by gesture ends the call the same way', () {
      // Swipe-down and system-back reach dispose() without passing through the X. That
      // is still the user ending the call and had the identical disconnect-only flaw.
      final body = _method(_sheet, 'void dispose()');
      expect(body, contains('endSession('));
      expect(
        body.contains('disconnectFromLiveKitRoom'),
        isFalse,
        reason: 'the gesture-dismissal path must not fall back to a bare disconnect',
      );
    });

    test('minimising still does NOT end the call', () {
      // The whole point of the bubble is that the call survives. If this ever starts
      // ending the session, minimising silently hangs up on the user.
      final body = _method(_sheet, 'void _minimizeSheet()');
      expect(
        body.contains('endSession(') || body.contains('disconnectFromLiveKitRoom'),
        isFalse,
        reason: 'minimising must keep the session alive',
      );
    });

    test('a full cleanup closes the conversation record', () {
      // Logout tears the session down silently (no rating screen) and so must keep using
      // disconnect — but it still has to close the history record, and clearing
      // _currentSessionId throws away the only id that can close it.
      final body = _method(_cubit, 'Future<void> disconnectFromLiveKitRoom(');
      final endIdx = body.indexOf('_chatHistoryCubit.endSession');
      final clearIdx = body.indexOf('_currentSessionId = null');
      expect(endIdx, isNot(-1),
          reason: 'a full cleanup must close the conversation record');
      expect(
        endIdx < clearIdx,
        isTrue,
        reason: 'the record must be closed BEFORE the session id is discarded',
      );
    });
  });
}
