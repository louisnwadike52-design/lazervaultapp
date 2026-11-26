import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/post_reset_handoff.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';

/// The identifier a reset flow carries to the login screen that follows it.
///
/// Both flows used to throw it away, so someone who had just proved control of
/// their number was asked who they were on the very next screen — and on a
/// device with no cached profile, PasscodeSignIn bounces to the full login
/// form, so they landed on a blank page seconds after verifying.
///
/// The deliberate NON-choice is auto-login: it would mint a session from
/// possession of the reset channel alone. These tests pin the three properties
/// that keep the carried value a convenience rather than a credential.
void main() {
  setUp(PostResetHandoff.clear);
  tearDown(PostResetHandoff.clear);

  group('carrying the identifier', () {
    test('a published identifier comes back once', () {
      PostResetHandoff.publish('+2348012345678', LoginIdentifierType.phone);
      final got = PostResetHandoff.consume();
      expect(got, isNotNull);
      expect(got!.identifier, '+2348012345678');
      expect(got.isPhone, isTrue);
    });

    test('SINGLE USE — a second read gets nothing', () {
      PostResetHandoff.publish('a@b.com', LoginIdentifierType.email);
      expect(PostResetHandoff.consume(), isNotNull);
      expect(PostResetHandoff.consume(), isNull,
          reason: 'a value that survives its first read can resurface on an '
              'unrelated screen later in the session');
    });

    test('nothing published means no prefill, not an error', () {
      expect(PostResetHandoff.consume(), isNull);
    });

    test('a blank identifier clears rather than carrying ""', () {
      PostResetHandoff.publish('+234801', LoginIdentifierType.phone);
      PostResetHandoff.publish('   ', LoginIdentifierType.phone);
      expect(PostResetHandoff.consume(), isNull,
          reason: 'a flow that could not resolve the identifier must degrade '
              'to the old behaviour, not prefill an empty string');
    });

    test('sign-out drops it — a shared device must not keep it', () {
      PostResetHandoff.publish('+2348012345678', LoginIdentifierType.phone);
      PostResetHandoff.clear();
      expect(PostResetHandoff.consume(), isNull);
    });
  });

  group('peek is for routing only', () {
    test('peek does NOT swallow the prefill the destination needs', () {
      PostResetHandoff.publish('a@b.com', LoginIdentifierType.email);
      expect(PostResetHandoff.peek()!.identifier, 'a@b.com');
      expect(PostResetHandoff.consume()!.identifier, 'a@b.com',
          reason: 'the lock screen peeks to decide where to send the user; '
              'the screen it sends them to is what consumes');
    });

    test('hasPending agrees with peek', () {
      expect(PostResetHandoff.hasPending, isFalse);
      PostResetHandoff.publish('a@b.com', LoginIdentifierType.email);
      expect(PostResetHandoff.hasPending, isTrue);
      PostResetHandoff.consume();
      expect(PostResetHandoff.hasPending, isFalse);
    });
  });

  group('splitE164Phone', () {
    test('splits a known country off an E.164 number', () {
      final s = splitE164Phone('+2348012345678');
      expect(s, isNotNull);
      expect(s!.countryCode, 'NG');
      expect(s.national, '8012345678');
    });

    test('an unknown prefix is no prefill, not a crash', () {
      expect(splitE164Phone('+9999999999999'), isNull);
    });

    test('empty and non-numeric are handled', () {
      expect(splitE164Phone(''), isNull);
      expect(splitE164Phone('not-a-phone'), isNull);
    });
  });

  group('it stays a prefill, never a credential', () {
    test('the carrier exposes no token, session or proof', () {
      PostResetHandoff.publish('+2348012345678', LoginIdentifierType.phone);
      final got = PostResetHandoff.consume()!;
      // If this ever grows a field, that is the moment to ask whether the
      // login screen has started trusting it.
      expect(got.identifier, isA<String>());
      expect(got.type, isA<LoginIdentifierType>());
    });

    test('NO reset flow signs the user in', () {
      // Auto-login would mint a session from possession of the reset channel
      // alone. Both flows must hand off to a login screen instead.
      for (final f in const [
        'lib/src/features/authentication/presentation/views/forgot_passcode_phone_screen.dart',
        'lib/src/features/widgets/create_new_password.dart',
      ]) {
        final src = File(f).readAsStringSync();
        for (final banned in const [
          'loginWithPhonePasscode(',
          'signInWithEmailAndPassword(',
          'AppRoutes.dashboard',
          'AppRoutes.home',
        ]) {
          expect(src.contains(banned), isFalse,
              reason: '$f appears to log the user in or jump past login '
                  '("$banned"). A completed reset proves control of a '
                  'channel, not that this person should get a funded '
                  'session.');
        }
      }
    });
  });
}
