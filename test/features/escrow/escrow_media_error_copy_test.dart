import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/presentation/view/escrow_deal_chat_screen.dart';

/// The last thing between an internal error string and the user.
///
/// The server's OWN refusals are deliberately passed through, because "you can
/// attach up to 5 photos" is advice and rewording it to "that file could not be
/// shared" throws the advice away. The risk that creates is a technical message
/// that happens to contain one of those phrases, which is exactly what
/// happened: the storage gateway's allow-list refusal ended with "or voice note
/// (m4a, aac, mp3)", matched the "voice note" marker, and the user was shown
/// "filename or content_type must identify a supported image (jpg, png, webp,
/// heic, gif), video (mp4, mov, webm) or voice note (m4a, aac, mp3)".
void main() {
  group('escrowMediaErrorMessage', () {
    test('never shows a wire field name, even alongside a passthrough phrase',
        () {
      // The exact string the gateway used to return.
      const leaked =
          'filename or content_type must identify a supported image '
          '(jpg, png, webp, heic, gif), video (mp4, mov, webm) or voice note '
          '(m4a, aac, mp3)';
      final msg = escrowMediaErrorMessage(Exception(leaked));
      for (final internal in const [
        'content_type',
        'filename',
        'must identify',
        'm4a',
      ]) {
        expect(msg.toLowerCase(), isNot(contains(internal)),
            reason: 'leaked "$internal" to the user: $msg');
      }
      expect(msg, contains('not supported'));
    });

    test('other technical shapes are ours to phrase too', () {
      for (final raw in const [
        'rpc error: code = InvalidArgument desc = mime type image/tiff rejected',
        'keyspace "escrow" does not allow this',
        'unsupported_media_type',
      ]) {
        final msg = escrowMediaErrorMessage(Exception(raw));
        expect(msg, contains('not supported'), reason: 'raw: $raw');
        expect(msg.toLowerCase(), isNot(contains('rpc error')));
      }
    });

    // The reason the marker list exists at all: these are actionable.
    test('the server\'s own advice still reaches the person', () {
      final msg = escrowMediaErrorMessage(Exception(
          'rpc error: code = FailedPrecondition desc = you can attach up to 5 photos'));
      expect(msg, 'you can attach up to 5 photos');
    });

    test('a length refusal keeps its number', () {
      final msg = escrowMediaErrorMessage(Exception(
          'rpc error: code = FailedPrecondition desc = voice notes can be at most 120 seconds long'));
      expect(msg, contains('120'));
      expect(msg, contains('seconds long'));
    });

    test('a closed deal says so', () {
      final msg = escrowMediaErrorMessage(
          Exception('rpc error: code = FailedPrecondition desc = this deal is closed'));
      expect(msg, contains('this deal is closed'));
    });

    test('a transport failure reads as unreachable, not as a bad file', () {
      for (final raw in const [
        'SocketException: Connection refused',
        'rpc error: code = Unavailable desc = no healthy upstream',
      ]) {
        expect(escrowMediaErrorMessage(Exception(raw)),
            'Server not reachable. Please try again.');
      }
    });

    test('an unrecognised failure gets the generic retry line', () {
      final msg = escrowMediaErrorMessage(Exception('something went sideways'));
      expect(msg, 'That file could not be shared. Please try again.');
    });

    test('never returns an empty string', () {
      for (final raw in const ['', 'desc = ', 'you can attach']) {
        expect(escrowMediaErrorMessage(Exception(raw)).trim(), isNotEmpty,
            reason: 'raw: "$raw"');
      }
    });
  });
}
