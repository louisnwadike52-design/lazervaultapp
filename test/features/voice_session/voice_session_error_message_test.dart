import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// The bug this guards: the app rendered the transport layer verbatim —
///   Failed to get voice session credentials: 500 {"error":"Failed to create
///   voice session. Please try again."}
/// — in a red banner on the dashboard. The user cannot act on a status code,
/// and a raw JSON body is our internals on their screen.
void main() {
  // The real payloads the gateway returns, so a change to either side breaks
  // this rather than drifting silently.
  const serverBody =
      '{"error":"Failed to create voice session. Please try again."}';
  const restartingBody =
      '{"error":"voice_service_restarting","message":"Voice is restarting. Please try again in a moment."}';
  const disabledBody =
      '{"error":"voice_recognition_disabled","message":"Voice recognition is currently disabled by your administrator. Please use chat instead."}';

  group('voiceSessionStartMessage never leaks internals', () {
    // One table-driven assertion over every case, because the property is
    // about ALL outputs, not about any single message's wording.
    final cases = <String, String>{
      '500 generic': serverBody,
      '503 restarting': restartingBody,
      '503 disabled': disabledBody,
      '401': '{"error":"Missing or invalid Authorization header"}',
      '429': '{"error":"rate limited"}',
      '400': '{"error":"bad request"}',
    };
    final codes = <String, int>{
      '500 generic': 500,
      '503 restarting': 503,
      '503 disabled': 503,
      '401': 401,
      '429': 429,
      '400': 400,
    };

    cases.forEach((name, body) {
      test('$name produces nothing technical', () {
        final msg = voiceSessionStartMessage(codes[name]!, body);

        expect(msg, isNotEmpty);
        // No status code of any kind.
        expect(RegExp(r'\b[45]\d{2}\b').hasMatch(msg), isFalse,
            reason: 'a status code reached the user in: $msg');
        // No JSON, no braces, no quoted keys.
        expect(msg.contains('{'), isFalse, reason: 'raw body in: $msg');
        expect(msg.contains('"'), isFalse, reason: 'raw JSON in: $msg');
        // No machine-readable error codes.
        expect(msg.contains('_'), isFalse, reason: 'snake_case code in: $msg');
        expect(msg.toLowerCase().contains('credential'), isFalse,
            reason: 'internal vocabulary in: $msg');
        // Reads as a sentence to a person.
        expect(msg.endsWith('.'), isTrue, reason: 'not a sentence: $msg');
      });
    });
  });

  group('the distinctions that change what the user should DO', () {
    test('a restarting gateway invites a retry', () {
      final msg = voiceSessionStartMessage(503, restartingBody);
      expect(msg.toLowerCase(), contains('try again'));
    });

    test('voice disabled by an admin does NOT invite a retry', () {
      // Retrying never helps here, so promising it would be a lie. It must
      // point at the thing that does work instead.
      final msg = voiceSessionStartMessage(503, disabledBody);
      expect(msg.toLowerCase(), contains('chat'));
      expect(msg.toLowerCase(), isNot(contains('try again')));
    });

    test('a 5xx blames us, never the user\'s connection', () {
      // Telling someone to check their wifi when our gateway is down sends
      // them to restart a router that was never the problem.
      final msg = voiceSessionStartMessage(500, serverBody);
      expect(msg.toLowerCase(), contains('not your connection'));
    });

    test('an expired session routes to sign-in, not to a retry', () {
      final msg = voiceSessionStartMessage(401, '{"error":"bad token"}');
      expect(msg.toLowerCase(), contains('sign in'));
    });
  });
}
