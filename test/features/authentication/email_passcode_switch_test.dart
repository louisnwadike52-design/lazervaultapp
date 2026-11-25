import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "USE PASSCODE INSTEAD" MUST NOT STRAND ANYBODY.
///
/// A customer on the email+password screen tapped it and landed on the full
/// phone+passcode login with no back button and no way to finish — reported
/// 2026-11-25. Two separate mistakes produced it:
///
///  1. `Get.offAllNamed` destroyed the stack. This is an OPTIONAL ALTERNATIVE
///     to the form they were already looking at, so the screen they came from
///     has to still be there.
///  2. It asked `hasCachedReturningUser`, which answers a DEFAULT-ROUTING
///     question and returns false for a genuine email+password account BY
///     DESIGN (so the boot router never drops an email user on a lock screen).
///     Read as "nothing cached", it sent email accounts WITH a passcode to a
///     phone login instead of to their own lock.
///
/// And the button's own gate asked a third, looser question, so it could be
/// offered for an account the destination then refused — which is how the two
/// disagreed in the first place.
void main() {
  final screen = File(
    'lib/src/features/authentication/presentation/views/email_sign_in_screen.dart',
  ).readAsStringSync();
  final resolver =
      File('lib/core/services/login_flow_resolver.dart').readAsStringSync();

  test('the passcode switch never clears the stack', () {
    final i = screen.indexOf('Future<void> _switchToPasscodeLogin');
    expect(i, greaterThan(-1), reason: 'the handler has moved');
    final body = screen.substring(i, i + 1800);
    expect(body.contains('Get.offAllNamed('), isFalse,
        reason: 'offAllNamed removes the back button, and this is an optional '
            'alternative to the screen the user is already on');
    expect(body.contains('Get.toNamed(AppRoutes.passcodeLogin)'), isTrue,
        reason: 'the lock should be pushed, so back returns to the email form');
  });

  test('it never routes to the phone+passcode login', () {
    final i = screen.indexOf('Future<void> _switchToPasscodeLogin');
    final body = screen.substring(i, i + 1800);
    expect(body.contains('AppRoutes.phonePasscodeLogin'), isFalse,
        reason: 'an email+password account has no phone passcode to enter '
            'there — that screen is the dead end this fixes');
  });

  test('the button and its destination ask the SAME question', () {
    // The DEFINITION, not the call site a few hundred lines above it.
    final gate = screen.indexOf('Future<void> _checkPasscodeAvailability');
    final body = screen.substring(gate, gate + 1500);
    expect(body.contains('hasPasscodeCredentialCached'), isTrue,
        reason: 'the gate re-derived its own answer from secure storage, so '
            'the button could appear for an account the destination refused');
    final i = screen.indexOf('Future<void> _switchToPasscodeLogin');
    expect(screen.substring(i, i + 1800).contains('hasPasscodeCredentialCached'),
        isTrue);
    // And neither asks the routing question any more.
    expect(screen.contains('hasCachedReturningUser('), isFalse,
        reason: 'that answers where to SEND someone by default, not whether '
            'they may go where they just asked to go');
  });

  test('the resolver distinguishes the two questions', () {
    expect(resolver.contains('static Future<bool> hasPasscodeCredentialCached'),
        isTrue);
    final i = resolver.indexOf('static Future<bool> hasPasscodeCredentialCached');
    final body = resolver.substring(i, i + 1400);
    // The explicit-request answer must NOT carry the email-preference
    // exclusion that the routing answer deliberately has.
    expect(body.contains('_preferredKey'), isFalse,
        reason: 'an explicit request outranks the preference that step 2 of '
            'hasCachedReturningUser protects');
    expect(body.contains('_hasPasscodeKey'), isTrue);
  });

  test('a credential that vanished is reported, not navigated into', () {
    final i = screen.indexOf('Future<void> _switchToPasscodeLogin');
    final body = screen.substring(i, i + 1800);
    expect(body.contains('Get.snackbar'), isTrue,
        reason: 'if the passcode went away between build and tap, say so '
            'rather than opening a screen they cannot finish');
  });

  test('the sign-up footer is hidden while the keyboard is up', () {
    // Pinned to bottom:0 it sits inside the purple band — until the keyboard
    // resizes the Scaffold and lifts it onto the pale middle of the one cover
    // image, where white text disappears and lands on the voice/passcode
    // buttons.
    expect(
      screen.contains('MediaQuery.of(context).viewInsets.bottom == 0'),
      isTrue,
      reason: 'the bottom strip renders over the form when the keyboard is '
          'open, invisible and overlapping the buttons beneath it',
    );
  });
}
