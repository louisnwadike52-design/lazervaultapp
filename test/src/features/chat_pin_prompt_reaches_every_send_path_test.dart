import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

// A chat-driven money move collects its PIN in the native sheet, and the sheet
// is driven ENTIRELY by one payload: `pin_prompt`. The server mints it, the
// cubit must put it on the assistant message, the card reads it off that
// message, and `ChatPinPromptCard.autoOpenFor` drives the card it registered.
//
// WHAT WENT WRONG, AND WHY NOTHING CAUGHT IT
// ------------------------------------------
// Every chat cubit had a text path that carried `pin_prompt` and a MEDIA path
// that did not. `AIChatCubit.sendMediaMessage` set only receiptData/receiptCard;
// `GeneralChatCubit.sendMediaMessage` built its bot message with no metadata at
// all; `MicroserviceChatCubit.sendMediaMessage` drained none of the `*_pending`
// sentinels. `GeneralChatCubit.submitPinVerification` carried every payload
// except `pin_prompt`.
//
// So: ask to send money by TYPING and the pad opens. Ask with a VOICE NOTE or a
// PHOTO and the agent says "enter your PIN to confirm" and nothing appears. The
// server was correct throughout — it logged `_pin_prompt_pending` on the way
// out — and no layer reported an error, because a missing payload is not an
// error anywhere. The only visible symptom was a transfer that would not
// complete.
//
// The fix gave each cubit ONE decoder that every send path routes through. This
// test enforces that shape, because the defect is re-introduced by adding a new
// send path and hand-rolling its payload list — which is exactly how all four
// of the above came to exist.

/// A cubit, and the name of the single helper its send paths must route through.
const _cubits = <String, String>{
  'lib/src/features/ai_chats/cubit/ai_chat_cubit.dart':
      '_decodeStructuredPayloads',
  'lib/src/features/microservice_chat/cubit/general_chat_cubit.dart':
      '_structuredPayloadMetadata',
  'lib/src/features/microservice_chat/cubit/microservice_chat_cubit.dart':
      '_drainSentinelMetadata',
};

/// The methods that turn a server reply into an assistant message. Each one is
/// a path a money move can arrive on, so each one must carry the prompt.
final _sendPaths = RegExp(
  r'Future<void>\s+(sendMessage|sendMediaMessage|submitPinVerification)\s*\(',
);

void main() {
  group('pin_prompt reaches the assistant message on every send path', () {
    _cubits.forEach((path, helper) {
      test('$path routes all send paths through $helper', () {
        final file = File(path);
        expect(file.existsSync(), isTrue,
            reason: 'the cubit moved — this test is now blind. Point it at the '
                'new location rather than deleting it.');
        final src = file.readAsStringSync();

        expect(src.contains('$helper('), isTrue,
            reason: '$helper is gone from $path. If it was renamed, update '
                'this test; if it was inlined, the text and media paths can '
                'drift apart again and a voice-note transfer will silently '
                'lose its PIN sheet.');

        final starts = _sendPaths.allMatches(src).toList();
        expect(starts, isNotEmpty,
            reason: 'found no send paths in $path — the matcher is broken, '
                'not the cubit');

        // Each method body runs to the start of the next matched method, or to
        // end of file for the last one. Coarse, but it cannot silently pass:
        // a body that does not mention the helper fails.
        for (var i = 0; i < starts.length; i++) {
          final name = starts[i].group(1)!;
          final from = starts[i].start;
          final to = i + 1 < starts.length ? starts[i + 1].start : src.length;
          final body = src.substring(from, to);

          expect(body.contains('$helper('), isTrue,
              reason: '$name in $path does not call $helper. Every send path '
                  'must decode its structured payloads through the one '
                  'helper, or this path will not carry pin_prompt and the '
                  'PIN sheet cannot open for a transfer started this way. '
                  'This is the exact bug that shipped: typing worked, a '
                  'voice note did not.');
        }
      });
    });

    test('the shared helpers all mention pin_prompt', () {
      // Guards against the helper being kept but quietly losing the one key
      // that matters — the other payloads degrade a turn, this one breaks a
      // transfer.
      _cubits.forEach((path, helper) {
        final src = File(path).readAsStringSync();
        final start = src.indexOf('$helper(');
        expect(start, greaterThan(-1), reason: '$helper missing from $path');
        // Search from the declaration onward; the key appears in the body.
        final seg = src.substring(start);
        expect(
          seg.contains('pin_prompt') || seg.contains('pinPrompt'),
          isTrue,
          reason: '$helper in $path no longer handles the pin prompt. Without '
              'it every chat surface loses the PIN sheet at once.',
        );
      });
    });
  });
}
