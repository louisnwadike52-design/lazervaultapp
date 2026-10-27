import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// EXACTLY ONE THING NAVIGATES AFTER 2FA.
///
/// The 2FA screen is pushed with the SHARED app-wide AuthenticationCubit, so
/// the screen that pushed it stays mounted underneath and its listener fires
/// again on the AuthenticationSuccess that verifying emits. Both then called
/// goAfterLogin.
///
/// Same user, same router, so never a wrong destination — but two offAllNamed
/// calls whose order depends on whether the bloc stream's microtask beats the
/// 2FA screen's `await` continuation. Login is not a place to leave a race.
///
/// The 2FA screen has to be the owner, not the pushing screen: the PHONE login
/// screen has no AuthenticationCubit listener at all, so 2FA reached from that
/// path would go nowhere if the screen stopped navigating.
///
/// Asserted against source because the condition is a widget-lifecycle
/// interaction between two screens and a shared cubit — the thing that must
/// not regress is the handoff itself.
void main() {
  String read(String p) => File(p).readAsStringSync();

  final passcode = read(
    'lib/src/features/authentication/presentation/widgets/passcode_sign_in.dart',
  );
  final email = read(
    'lib/src/features/authentication/presentation/views/email_sign_in_screen.dart',
  );
  final twoFactor = read(
    'lib/src/features/authentication/presentation/views/two_factor_verification_screen.dart',
  );

  group('pushing the 2FA screen hands over navigation', () {
    test('the passcode lock screen claims _navigated at push', () {
      final i = passcode.indexOf('_navigated = true;');
      final j = passcode.indexOf('TwoFactorVerificationScreen');
      expect(i, greaterThan(-1));
      expect(j, greaterThan(-1));
      expect(i, lessThan(j),
          reason: 'ownership must be claimed BEFORE the push, or the listener '
              'can still fire and double-navigate');
    });

    test('email sign-in does the same', () {
      final i = email.indexOf('_navigated = true;');
      final j = email.indexOf('TwoFactorVerificationScreen');
      expect(i, greaterThan(-1));
      expect(j, greaterThan(-1));
      expect(i, lessThan(j));
    });
  });

  group('backing out gives ownership back', () {
    test('the passcode screen re-arms AND releases _navigated', () {
      // Releasing without re-arming leaves a dead keypad; re-arming without
      // releasing leaves a live keypad that can never navigate. Both or
      // neither.
      expect(passcode.contains('_navigated = false;'), isTrue,
          reason: 'a user who backs out of 2FA must be able to log in again');
      expect(passcode.contains('authCubit.startPasscodeLogin()'), isTrue);
    });

    test('email sign-in releases it too', () {
      expect(email.contains('_navigated = false;'), isTrue);
    });
  });

  test('the 2FA screen remains the one that navigates', () {
    // The phone login path has NO AuthenticationCubit listener, so if this
    // screen stopped navigating, 2FA from phone+passcode would dead-end.
    expect(twoFactor.contains('goAfterLogin('), isTrue,
        reason: 'the 2FA screen is the single owner of post-2FA navigation');
  });

  group('the step-up OTP path hands over the same way', () {
    // Found only after fixing 2FA: the step-up branch has the IDENTICAL shape.
    // LoginOtpScreen scopes the same app-wide cubit and calls goAfterLogin
    // itself, so the pushing screen had to stop owning navigation there too.
    test('the passcode lock screen claims _navigated before the OTP push', () {
      final i = passcode.indexOf('LoginOtpScreen');
      expect(i, greaterThan(-1));
      final before = passcode.substring(0, i);
      expect(before.lastIndexOf('_navigated = true;'), greaterThan(-1),
          reason: 'ownership must be claimed before pushing the OTP screen');
    });

    test('email sign-in claims it too', () {
      final i = email.indexOf('LoginOtpScreen');
      expect(i, greaterThan(-1));
      final before = email.substring(0, i);
      expect(before.lastIndexOf('_navigated = true;'), greaterThan(-1));
    });

    test('the OTP screen remains the one that navigates', () {
      final otp = File(
        'lib/src/features/authentication/presentation/views/login_otp_screen.dart',
      ).readAsStringSync();
      // The phone login screen has no AuthenticationCubit listener, so step-up
      // from phone+passcode would dead-end if this screen stopped navigating.
      expect(otp.contains('goAfterLogin('), isTrue);
    });
  });
}
