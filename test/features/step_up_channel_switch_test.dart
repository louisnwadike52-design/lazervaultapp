import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

/// NEW-DEVICE STEP-UP: email by default, phone on request.
///
/// The server already defaulted to email — it only falls to SMS for a
/// phone-only account. What was missing was any way for someone locked out of
/// their inbox to ask for the other channel.
///
/// The rule that shapes every piece of this: a switch is REFUSED, never
/// silently redirected. The user asks for the phone precisely because they
/// cannot reach the inbox; quietly sending another email leaves them watching
/// the wrong place with nothing to tell them so.
void main() {
  String read(String p) => File(p).readAsStringSync();

  group('StepUpResend carries the SERVER\'s answer', () {
    test('an alternative is advertised, not inferred', () {
      const r = StepUpResend(
        expiresInSeconds: 300,
        method: 'email',
        destination: 'j***@x.com',
        altMethod: 'sms',
        altDestination: '+23*****3952',
      );
      expect(r.hasAlternative, isTrue);
      expect(r.isSms, isFalse);
    });

    test('no alternative means offer no switch', () {
      const r = StepUpResend(
        expiresInSeconds: 300,
        method: 'email',
        destination: 'j***@x.com',
      );
      expect(r.hasAlternative, isFalse,
          reason: 'the account may have no phone, or SMS may be down — the '
              'client can know neither, so an empty alt means do not offer');
    });
  });

  group('the server refuses rather than redirecting', () {
    late final String src;
    setUpAll(() => src = read(
        '../microservices/auth-service/auth-microservice/internal/service/adaptive_otp.go'));

    test('a channel with no destination is refused', () {
      expect(src.contains('login-otp channel switch refused: no destination'),
          isTrue);
    });

    test('the refusal happens BEFORE the code is replaced', () {
      final switchAt = src.indexOf('sendMethod, sendDestination = want, dest');
      final replaceAt = src.indexOf('ReplaceCodeOnChannel');
      expect(switchAt, greaterThan(-1));
      expect(switchAt, lessThan(replaceAt),
          reason: 'a refusal after ReplaceCode would already have destroyed a '
              'working code, spent a resend slot and restarted the cooldown — '
              'making the resend strictly worse than not pressing it');
    });

    test('an unrecognised method degrades to "keep the current channel"', () {
      expect(src.contains('func normaliseStepUpMethod'), isTrue);
      expect(src.contains('return ""'), isTrue,
          reason: 'nonsense from a client must behave like an older build '
              'sending nothing, not error');
    });

    test('the channel and the code move together, in one statement', () {
      final repo = read(
          '../microservices/auth-service/auth-microservice/internal/repository/login_otp_repository.go');
      expect(repo.contains('ReplaceCodeOnChannel'), isTrue);
      expect(repo.contains('"method":      method'), isTrue,
          reason: 'a second UPDATE would leave a window where the row says '
              'email while the code went by SMS');
    });
  });

  group('the screen follows the server, not its own request', () {
    late final String src;
    setUpAll(() => src = read(
        'lib/src/features/authentication/presentation/views/login_otp_screen.dart'));

    test('channel state is MUTABLE — widget params only seed it', () {
      expect(src.contains('late String _method = widget.method'), isTrue,
          reason: 'after a switch, widget.method describes where the FIRST '
              'code went; copy naming the channel must not read it');
    });

    test('no stale param reads remain in the body', () {
      // Split AFTER the seed line, not at it — splitting at the marker
      // leaves the seed's own `= widget.destination;` at the head of the
      // remainder and the assertion fails on the one read that is correct.
      const seed = 'late String _altDestination = widget.altDestination;';
      expect(src.contains(seed), isTrue, reason: 'seed block moved');
      final body = src.split(seed)[1];
      expect(body.contains('widget.method'), isFalse,
          reason: 'copy naming the channel must read _method');
      expect(body.contains('widget.destination'), isFalse,
          reason: 'copy naming the destination must read _destination');
    });

    test('the switch is only offered when the server advertises one', () {
      expect(src.contains("if (_altMethod.isEmpty) return const SizedBox.shrink();"),
          isTrue);
    });

    test('both requests cannot race', () {
      expect(src.contains('_resending || _switching'), isTrue,
          reason: 'two codes in flight leaves the user holding whichever '
              'arrived second with no way to know');
    });
  });

  group('social login is deliberately excluded', () {
    test('its response has no alt fields, so no switch is offered', () {
      final src =
          read('lib/src/features/authentication/data/repositories/auth_repository.dart');
      expect(src.contains('SocialLoginResponse is a DIFFERENT message'), isTrue,
          reason: 'guessing an alternative there would produce an affordance '
              'that fails');
    });
  });
}
