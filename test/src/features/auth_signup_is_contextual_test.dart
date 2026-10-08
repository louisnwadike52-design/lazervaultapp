import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Signup must follow the SCREEN the user is on, not the platform default.
///
/// AppRoutes.signupEntry resolves from the platform `auth_mode`. That is right
/// for a context-free entry point — onboarding, where no flow is in play and
/// the platform default is the only signal there is.
///
/// It is WRONG on a login screen. Somebody reading an email+password form and
/// tapping "Sign Up" means the email signup; with the platform set to
/// phone_passcode they were sent to the phone flow instead, discarding the
/// screen they had chosen. The same fault exists in mirror image: a passcode
/// screen must offer the phone signup even when the platform says email.
///
/// Asserted on source text because the alternative is booting four screens and
/// a GetX navigator to observe one route constant.
void main() {
  String read(String path) {
    final f = File(path);
    expect(f.existsSync(), isTrue, reason: '$path moved');
    return f.readAsStringSync();
  }

  /// Source with `//` comment lines removed.
  ///
  /// The absence assertions below are about what the code DOES. Without this
  /// they also match the comments explaining why the old route was wrong —
  /// which fails the moment the fix is documented, punishing the explanation
  /// rather than the behaviour.
  String code(String path) => read(path)
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  test('the EMAIL login screen offers the EMAIL signup', () {
    final s = code(
        'lib/src/features/authentication/presentation/views/email_sign_in_screen.dart');
    expect(s, contains('Get.toNamed(AppRoutes.signUp)'));
    expect(s.contains('AppRoutes.signupEntry'), isFalse,
        reason: 'the platform default sends an email user to the phone signup');
  });

  test('the PHONE passcode login offers the PHONE signup', () {
    final s = code(
        'lib/src/features/authentication/presentation/views/phone_passcode_login_screen.dart');
    expect(s, contains('Get.toNamed(AppRoutes.phoneEntry)'));
    expect(s.contains('AppRoutes.signupEntry'), isFalse);
  });

  test('the passcode LOCK screen offers the PHONE signup', () {
    final s = read(
        'lib/src/features/authentication/presentation/widgets/passcode_sign_in.dart');
    expect(s, contains('AppRoutes.phoneEntry'));
  });

  test('onboarding KEEPS the platform default', () {
    // The one place signupEntry belongs: no flow has been chosen yet, so the
    // platform's auth_mode is the only thing that can decide.
    for (final p in const [
      'lib/src/features/presentation/views/onboarding_screen.dart',
      'lib/src/features/authentication/presentation/views/modern_onboarding_screen.dart',
    ]) {
      expect(read(p), contains('AppRoutes.signupEntry'), reason: p);
    }
  });

  test('"use passcode instead" does not bounce back to the email form', () {
    // passcodeLogin is the LOCK screen and is a dead end without a cached
    // passcode user — it redirects to the full login screen, which IS the
    // email form, so the button looked dead. It must resolve.
    final s = read(
        'lib/src/features/authentication/presentation/views/email_sign_in_screen.dart');
    expect(s, contains('hasCachedReturningUser'));
    expect(s, contains('AppRoutes.phonePasscodeLogin'),
        reason: 'no cached passcode user must land on the FULL passcode login');
  });
}
