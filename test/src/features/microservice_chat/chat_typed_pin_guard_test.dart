import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_typed_pin_guard.dart';

/// A transaction PIN must never travel as chat text.
///
/// Production: the Send Funds chat told the user to enter their PIN on the
/// secure pad, the pad never appeared (that surface rendered no pin-prompt
/// card), so the user typed the PIN into the message box. It was sent, spent
/// as a PIN, and answered "Incorrect PIN. You have 1 attempts remaining." The
/// bubble was masked to "Secured data ***", which hid the leak rather than
/// preventing it.
///
/// The guard is deliberately CONDITIONAL: "4 to 6 digits" is also a perfectly
/// good answer to "how much?", and swallowing that would break the flow far
/// more often than it protects anything.
void main() {
  Map<String, dynamic> prompt({
    String id = 'TX-1',
    String? expiresAt,
  }) =>
      {
        'transaction_id': id,
        if (expiresAt != null) 'expires_at': expiresAt,
      };

  group('with a PIN prompt outstanding', () {
    test('a 4-digit message is intercepted and names the pad to open', () {
      expect(
        ChatTypedPinGuard.interceptedTransactionId(
          text: '1234',
          prompts: [prompt()],
        ),
        'TX-1',
      );
    });

    test('6 digits too, and surrounding whitespace does not evade it', () {
      expect(
        ChatTypedPinGuard.interceptedTransactionId(
          text: '  123456 ',
          prompts: [prompt()],
        ),
        'TX-1',
      );
    });

    test('the NEWEST prompt is the one reopened', () {
      // "make it 200" leaves the earlier prompt above it in the transcript;
      // reopening that one would confirm the amount the user just corrected.
      expect(
        ChatTypedPinGuard.interceptedTransactionId(
          text: '1234',
          prompts: [prompt(id: 'TX-OLD'), prompt(id: 'TX-NEW')],
        ),
        'TX-NEW',
      );
    });

    test('ordinary text still sends', () {
      for (final t in ['send 5000 to Grace', 'yes', 'what is my balance?']) {
        expect(
          ChatTypedPinGuard.interceptedTransactionId(
            text: t,
            prompts: [prompt()],
          ),
          isNull,
          reason: '"$t" is not a PIN',
        );
      }
    });

    test('an EXPIRED prompt does not intercept', () {
      // The pad would only fail. Let the text through so the agent can say so.
      expect(
        ChatTypedPinGuard.interceptedTransactionId(
          text: '1234',
          prompts: [prompt(expiresAt: '2020-01-01T00:00:00Z')],
        ),
        isNull,
      );
    });
  });

  group('with NO prompt outstanding', () {
    test('digits are an ordinary message — this is the amount case', () {
      // "how much?" → "5000". Swallowing this would be a far worse bug than
      // the one the guard exists for.
      expect(
        ChatTypedPinGuard.interceptedTransactionId(
          text: '5000',
          prompts: const [],
        ),
        isNull,
      );
    });
  });

  test('a prompt with no transaction id cannot be opened, so it sends', () {
    expect(
      ChatTypedPinGuard.interceptedTransactionId(
        text: '1234',
        prompts: [const <String, dynamic>{}],
      ),
      isNull,
    );
  });
}
