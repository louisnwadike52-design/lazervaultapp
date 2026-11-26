import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/auth_error_copy.dart';
import 'package:lazervault/core/utils/verification_gate_routing.dart';

/// A VERIFICATION GATE IS NOT A LOGIN FAILURE.
///
/// Reported 2026-11-24 with a screenshot: a customer entered her correct
/// passcode and was shown
///
///   Login failed
///   email_not_verified: please verify your email to continue
///
/// Three faults in one toast — the backend CODE reached a person, nothing had
/// actually failed, and it named a next step while offering no way to take
/// it. She re-entered the passcode and got the same banner every time.
///
/// auth_error_copy.dart already had the wording; what was missing was that
/// two of the four login surfaces never consulted it, and none of them routed
/// anywhere. These pin both halves.
void main() {
  String code(String path) => File(path)
      .readAsStringSync()
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  final phone = code(
      'lib/src/features/authentication/presentation/views/phone_passcode_login_screen.dart');
  final email = code(
      'lib/src/features/authentication/presentation/views/email_passcode_login_screen.dart');

  group('the gate is recognised', () {
    test('by the shared predicate, on the real server string', () {
      const raw = 'email_not_verified: please verify your email to continue';
      expect(isEmailVerificationGate(raw), isTrue);
      expect(isVerificationGate(raw), isTrue);
      expect(isVerificationGate('Incorrect passcode. 2 attempts remaining'),
          isFalse);
      expect(isVerificationGate(null), isFalse);
    });

    test('and worded as one more step, never as a failure', () {
      final copy = authErrorCopy(
          'email_not_verified: please verify your email to continue');
      expect(copy.title.toLowerCase(), isNot(contains('fail')));
      expect(copy.message.toLowerCase(), isNot(contains('email_not_verified')),
          reason: 'a backend code must never reach a person');
    });
  });

  group('every passcode surface routes instead of dead-ending', () {
    test('phone + passcode', () {
      expect(phone, contains('isVerificationGate(state.message)'));
      expect(phone, contains('routeToVerificationGate('));
    });

    test('email + passcode', () {
      expect(email, contains('isVerificationGate(state.message)'));
      expect(email, contains('routeToVerificationGate('));
    });

    test('and nothing prints the raw server message any more', () {
      // The specific regression: showing state.message under a hardcoded
      // "Login failed" title. Both screens now map through authErrorCopy.
      expect(phone.contains("showAppSnackbar('Login failed', state.message"),
          isFalse,
          reason: 'the raw message is where backend codes leak to users');
      expect(email.contains("Get.snackbar('Login failed', state.message"),
          isFalse);
      expect(phone, contains('authErrorCopy(state.message)'));
      expect(email, contains('authErrorCopy(state.message)'));
    });
  });

  test('the customer is brought back so the flow resumes', () {
    // The whole point of routing is that the NEXT passcode entry succeeds.
    // Dropping them at the verification screen with no return is the same
    // dead end in a different place.
    expect(phone, contains('returnTo:'));
    expect(email, contains('returnTo:'));
    expect(phone, contains('onReturn:'),
        reason: 'the de-dupe must be re-armed or the second attempt is '
            'byte-identical and gets swallowed');
  });
}
