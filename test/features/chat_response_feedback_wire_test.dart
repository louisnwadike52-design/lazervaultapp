// Copy / 👍 / 👎 under an assistant answer, on BOTH chat surfaces, with a wire
// contract the Go handler actually accepts.
//
// This feature shipped once and recorded nothing for a day: the central
// endpoint declared `message_id: int`, so FastAPI answered 422 before the
// handler ran, and the app swallows feedback errors by design — the thumb
// filled in, looked recorded, and was discarded. The lesson is that the
// interesting half of a feedback feature is the CONTRACT, not the widget, and
// a contract spanning Dart and Go has nobody checking it at build time.
//
// So this test reads the Go handler's own accepted set and compares it with
// what Dart sends.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/data/datasources/chat_feedback_datasource.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_response_actions.dart';

String _read(String relativeToRepoRoot) {
  // The test runs from lazervaultapp/, the Go service is a sibling repo.
  final f = File('../$relativeToRepoRoot');
  expect(f.existsSync(), isTrue,
      reason: 'cannot find $relativeToRepoRoot — path moved?');
  return f.readAsStringSync();
}

void main() {
  group('the wire verdicts Dart sends are exactly what Go accepts', () {
    test('up / down / none, and nothing else', () {
      final sent = {
        for (final v in ChatFeedbackVerdict.values)
          ChatFeedbackDataSource.verdictWire(v)
      };
      expect(sent, {'up', 'down', 'none'});
    });

    test('the Go handler accepts that same set', () {
      final go = _read('services/chat-proxy-gateway/chat_feedback.go');
      // The clear branch and the refusal branch between them define the set.
      expect(go.contains('in.Verdict == "none"'), isTrue,
          reason: 'the retraction branch is gone — an un-toggled thumb would '
              'be stored or refused instead of deleted');
      expect(
        RegExp(r'in\.Verdict != "up" && in\.Verdict != "down"').hasMatch(go),
        isTrue,
        reason: 'the handler no longer restricts verdicts to up/down, so a '
            'typo would be stored as an opinion',
      );
      // And the column constraint must not contradict the handler.
      expect(go.contains("verdict IN ('up','down')"), isTrue,
          reason: 'the CHECK constraint changed; "none" must never be INSERTed '
              'and up/down must both remain legal');
    });

    test('a retraction maps to none, not to a third stored state', () {
      expect(ChatFeedbackDataSource.verdictWire(ChatFeedbackVerdict.none),
          'none');
      // And an unknown wire value reads back as "no opinion" rather than
      // defaulting to a vote.
      expect(ChatFeedbackDataSource.verdictFromWire('garbage'),
          ChatFeedbackVerdict.none);
      expect(ChatFeedbackDataSource.verdictFromWire(null),
          ChatFeedbackVerdict.none);
      expect(ChatFeedbackDataSource.verdictFromWire('up'),
          ChatFeedbackVerdict.up);
      expect(ChatFeedbackDataSource.verdictFromWire('down'),
          ChatFeedbackVerdict.down);
    });
  });

  // WHICH FILE IS THE CENTRAL CHAT
  // ------------------------------
  // The bottom nav's AI Chat tab renders `AiChats` (dashboard_screen.dart),
  // i.e. lib/src/features/ai_chats/. That is the LIVE central chat and it has
  // its own feedback row (`_buildAnswerActions` / `_rateAnswer`), on a
  // different wire vocabulary: `rating: up|down|''` against the chat-agent
  // gateway, where '' nulls the column.
  //
  // microservice_chat/.../general_chat_content.dart is a SECOND central-chat
  // implementation whose route (AppRoutes.generalChat, '/general-chat') is
  // declared but registered nowhere and navigated to from nowhere. It is
  // asserted below anyway — it is live code that compiles and someone will
  // route it one day — but it is NOT the surface a user reaches, and a test
  // that only checked it would have proved nothing about the shipped app.
  group('the live central chat carries copy and both thumbs', () {
    final src = File(
      'lib/src/features/ai_chats/presentation/widgets/ai_chat_content.dart',
    ).readAsStringSync();

    test('copy, helpful and not-helpful are all wired', () {
      expect(src.contains('Clipboard.setData'), isTrue,
          reason: 'the copy action is gone from the live central chat');
      for (final t in ['Copy', 'Helpful', 'Not helpful']) {
        expect(src.contains("tooltip: '$t'"), isTrue,
            reason: 'the live central chat lost its "$t" action');
      }
      expect(
        RegExp(r"_rateAnswer\(message,\s*'up'\)").hasMatch(src) &&
            RegExp(r"_rateAnswer\(message,\s*'down'\)").hasMatch(src),
        isTrue,
        reason: 'the thumbs no longer call _rateAnswer with up/down',
      );
    });

    test('a retraction reaches the server rather than only the UI', () {
      // The empty string is what nulls the column. Returning early on a clear
      // was the original bug: the thumb went out locally and came back the
      // next time history loaded.
      expect(
        RegExp(r"_answerRatings\[key\]\s*\?\?\s*''").hasMatch(src),
        isTrue,
        reason: 'a cleared rating is no longer sent as the empty string, so an '
            'un-tap is lost and history will restore the retracted thumb',
      );
      expect(src.contains('rating: applied'), isTrue,
          reason: 'the computed value (including the clear) is not what is sent');
    });

    test('an answer with no server id is not rateable', () {
      // A local timestamp is not resolvable server-side; rating by it would
      // rate the wrong row.
      // The NAME surviving is not enough: `serverMessageId: null` still
      // contains the word. The value has to come from the message.
      expect(
        RegExp(r'serverMessageId:\s*message\.serverMessageId').hasMatch(src),
        isTrue,
        reason: 'the rating no longer carries the MESSAGE\'s server id, so it '
            'cannot name which answer it means',
      );
    });
  });

  group('the other chat surfaces render the actions row', () {
    const surfaces = {
      'general_chat_content.dart':
          'the SECOND central chat (unrouted, see note above)',
      'microservice_chat_content.dart': 'the PER-SERVICE chat',
    };

    for (final entry in surfaces.entries) {
      test('${entry.value} wires onVerdict and canRate', () {
        final src = File(
          'lib/src/features/microservice_chat/presentation/widgets/${entry.key}',
        ).readAsStringSync();

        // Match the CONSTRUCTOR CALL together with its required arguments, as
        // one expression. A bare `ChatResponseActions(` substring is satisfied
        // by an import, a comment, or a call under `if (false)`.
        final call = RegExp(
          r'ChatResponseActions\(\s*'
          r'responseText:[^;]*?'
          r'verdict:[^;]*?'
          r'canRate:[^;]*?'
          r'onVerdict:[^;]*?\)',
          dotAll: true,
        );
        expect(call.hasMatch(src), isTrue,
            reason: '${entry.value} does not construct ChatResponseActions '
                'with all four arguments — copy/thumbs are absent or inert');

        // canRate must be derived from the session, never hardcoded true:
        // a vote with no session cannot be attributed and would be dropped.
        expect(
          RegExp(r'canRate:\s*true').hasMatch(src),
          isFalse,
          reason: '${entry.value} hardcodes canRate: true, so it collects '
              'ratings it cannot store',
        );
        expect(src.contains('sessionId') || src.contains('currentSessionId'),
            isTrue,
            reason: '${entry.value} does not consult the session id at all');
      });
    }
  });

  test('the actions row refuses to draw for an empty answer', () {
    // Pure behaviour on the widget's own guard: an empty assistant turn (a
    // card-only reply, e.g. a PIN prompt) must not sprout a copy button for
    // nothing.
    final src = File(
      'lib/src/features/microservice_chat/presentation/widgets/'
      'chat_response_actions.dart',
    ).readAsStringSync();
    expect(
      RegExp(r'if\s*\(responseText\.trim\(\)\.isEmpty\)\s*return\s+const\s+SizedBox\.shrink\(\);')
          .hasMatch(src),
      isTrue,
      reason: 'the empty-answer guard is gone, so a card-only reply would '
          'show a copy button that copies nothing',
    );
  });
}
