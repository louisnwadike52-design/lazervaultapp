import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// WHERE THE USER CHOOSES AN OTP CHANNEL, AND WHERE THE SERVER DOES.
///
/// SmsPolicy exists so that four screens in three features cannot answer
/// "can SMS be delivered?" differently. A flow that reads the flags itself —
/// or asks nothing at all — is how that drift starts, and the symptom is a
/// user waiting for a code nothing attempted to send.
void main() {
  String read(String p) => File(p).readAsStringSync();

  group('flows that OFFER a choice must gate it', () {
    test('password recovery consults SmsPolicy for its SMS tab', () {
      final src = read('lib/src/features/widgets/password_recovery.dart');
      expect(src.contains('SmsPolicy.available'), isTrue,
          reason: 'this tab offered SMS unconditionally — with no provider '
              'the user submitted a number and waited for nothing');
      expect(src.contains('SmsPolicy.unavailableReason'), isTrue,
          reason: 'refuse with the SHARED reason, so every surface says the '
              'same thing');
    });

    test('it refuses rather than hiding, like canUseSmsTwoFactor', () {
      final src = read('lib/src/features/widgets/password_recovery.dart');
      // Both tabs stay in the bar; only the body changes.
      expect(src.contains("Tab(text: 'SMS')"), isTrue,
          reason: 'a vanished SMS tab beside an Email one reads as the '
              'feature being broken');
    });
  });

  group('the passcode-reset resolver is the server-side counterpart', () {
    late final String src;
    setUpAll(() => src = read(
        '../microservices/auth-service/auth-microservice/internal/service/auth_passcode_reset.go'));

    test('it honours what the user asked for', () {
      expect(src.contains('email as requested'), isTrue);
    });

    test('it falls back rather than failing, and says why', () {
      for (final reason in const [
        'no active SMS provider; delivered by email instead',
        'no email on the account; delivered by SMS instead',
      ]) {
        expect(src.contains(reason), isTrue,
            reason: 'a silent fallback leaves the user watching the wrong '
                'inbox');
      }
    });

    test('undeliverable is an explicit state, not a timeout', () {
      expect(src.contains('no reachable channel'), isTrue,
          reason: 'an account with neither channel must be told, not left on '
              'a spinner');
    });
  });

  group('flows where the SERVER picks — no selector by design', () {
    test('new-device step-up takes the method, and checks it can deliver', () {
      final src = read(
          'lib/src/features/authentication/presentation/views/login_otp_screen.dart');
      // Reads the LIVE channel, not the widget param that seeded it: a resend
      // can move the code to the other channel, after which widget.method
      // describes where the FIRST one went. Asserting the seed here is what
      // made this test fail when the switch landed — the code was right.
      //
      // ASSERTED AS TWO PROPERTIES, NOT ONE LITERAL EXPRESSION. This used to
      // pin the exact string "_method != 'sms' || SmsPolicy.available", and it
      // broke the day a third term was added — correctly — for the SMS
      // whitelist. A guard that fails on a refactor it should welcome teaches
      // people to edit the guard without reading it, which is how a real
      // regression gets waved through next time.
      expect(src.contains("_method != 'sms'"), isTrue,
          reason: 'the risk engine picks the starting channel; the screen only '
              'verifies the one in force can actually be delivered');
      expect(src.contains('SmsPolicy.available'), isTrue,
          reason: 'the platform-wide switch must still be consulted');
      expect(src.contains("widget.method != 'sms'"), isFalse,
          reason: 'checking the seed would pass a dead channel after a switch');

      // The one permitted way to override the global flag is PER-USER EVIDENCE
      // the server produced: a send it accepted on this challenge. Anything
      // else overriding it would be the client second-guessing a platform
      // switch, which is how SMS gets offered to people it cannot reach.
      if (src.contains('_smsConfirmedForThisUser')) {
        expect(
            src.contains("if (_method == 'sms') _smsConfirmedForThisUser = true"),
            isTrue,
            reason: 'the per-user override must be set ONLY from a resend the '
                'server accepted — never from a local guess');
      }
    });

    test('forgot PIN gets per-channel availability FROM the server', () {
      final src = read(
          'lib/src/features/transaction_pin/presentation/views/forgot_pin_screen.dart');
      expect(src.contains('isAvailable'), isTrue,
          reason: 'the richest pattern of the three: the server advertises '
              'each channel and whether it can be used');
      expect(src.contains('No verification method available'), isTrue,
          reason: 'and the no-channel case is handled explicitly');
    });
  });
}
