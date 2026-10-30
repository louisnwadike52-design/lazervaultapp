import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/authentication/domain/signup_phone_rules.dart';

/// Pins the two decisions behind the 30 October 2026 signup banner that read
/// "Couldn't use that email" over "invalid phone number format".
void main() {
  group('isValidSignupE164 matches the server', () {
    test('accepts the canonical Nigerian form the flow actually submits', () {
      expect(isValidSignupE164('+2348031234567'), isTrue);
    });

    test('rejects an EMPTY phone — the exact value a resumed flow submitted',
        () {
      // This is the regression. The draft load is async; a submit that
      // overtook it sent '' to SignupWithPhone, which rejected it before any
      // database call (0.00004s in the prod logs) with "invalid phone number
      // format". Refusing it locally is what stops that reaching the user as
      // an email error.
      expect(isValidSignupE164(''), isFalse);
    });

    test('rejects a national number with no country code', () {
      // What a user types. It is canonicalised earlier in the flow; if it ever
      // reaches submit in this shape, the server would refuse it too.
      expect(isValidSignupE164('08031234567'), isFalse);
    });

    test('rejects non-digits after the plus', () {
      expect(isValidSignupE164('+234 803 123 4567'), isFalse);
      expect(isValidSignupE164('+234-8031234567'), isFalse);
    });

    test('honours the server bounds exactly', () {
      // The server measures CHARACTERS INCLUDING the '+', not digits:
      // `len(phone) < 9 || len(phone) > 16`. So the lower edge is 9 characters
      // — a plus and eight digits — not nine digits. Asserting the digit count
      // here is how this test was wrong before the implementation was.
      expect(isValidSignupE164('+1234567'), isFalse); // 8 chars = too short
      expect(isValidSignupE164('+12345678'), isTrue); // 9 chars = lower edge
      expect(isValidSignupE164('+123456789012345'), isTrue); // 16 = upper edge
      expect(isValidSignupE164('+1234567890123456'), isFalse); // 17 = too long
    });
  });

  group('signupFailureTitle describes what failed, not where you are', () {
    test('a phone rejection on the EMAIL step is not called an email problem',
        () {
      // The whole bug in one assertion: this message arrived on the email step
      // and was titled "Couldn't use that email".
      expect(
        signupFailureTitle('invalid phone number format', onCodeStep: false),
        'Phone number problem',
      );
    });

    test('the real "already registered" phone error is also attributed right',
        () {
      expect(
        signupFailureTitle('phone number already registered, please log in',
            onCodeStep: false),
        'Phone number problem',
      );
    });

    test('a genuine email rejection still reads as one', () {
      expect(
        signupFailureTitle('email already in use', onCodeStep: false),
        "Couldn't use that email",
      );
    });

    test('a passcode rejection is named', () {
      expect(
        signupFailureTitle('passcode must be 6 digits', onCodeStep: false),
        'Passcode problem',
      );
    });

    test('an unattributable failure on the code step is still "Invalid code"',
        () {
      expect(
        signupFailureTitle('that code has expired', onCodeStep: true),
        'Invalid code',
      );
    });

    test('phase never overrides a message that names the culprit', () {
      // Even on the code step, a phone message must not be called a bad code.
      expect(
        signupFailureTitle('invalid phone number format', onCodeStep: true),
        'Phone number problem',
      );
    });
  });
}
