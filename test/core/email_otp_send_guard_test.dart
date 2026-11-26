import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/src/features/authentication/presentation/views/email_otp_send_guard.dart';

/// The signup drop-off, from the client side.
///
/// EmailVerificationScreen auto-sends on mount when entered with
/// `codeSent: false` (four of its nine entry points do). That send goes through
/// the resend endpoint, and the server DELETES the user's existing verification
/// row before issuing a new code — so a re-mount does not merely send a second
/// email, it INVALIDATES the code the user is at that moment switching apps to
/// go and read.
void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    EmailOtpSendGuard.prefs = SharedPreferences.getInstance;
  });

  test('the first automatic send is always allowed', () async {
    expect(await EmailOtpSendGuard.mayAutoSend('a@b.com'), isTrue,
        reason: 'a user with no code at all must always get one');
  });

  test('a second automatic send inside the window is refused', () async {
    await EmailOtpSendGuard.markSent('a@b.com');
    expect(await EmailOtpSendGuard.mayAutoSend('a@b.com'), isFalse,
        reason: 'this is the re-mount case: sending again would delete the '
            'code the user has already gone to fetch');
  });

  test('the window expires, so a user who never got the mail is not stranded',
      () async {
    final past = DateTime.now()
            .subtract(EmailOtpSendGuard.window + const Duration(seconds: 5))
            .millisecondsSinceEpoch;
    SharedPreferences.setMockInitialValues(
        {'email_otp_last_sent_a@b.com': past});
    expect(await EmailOtpSendGuard.mayAutoSend('a@b.com'), isTrue);
  });

  test('addresses are tracked independently and case-insensitively', () async {
    await EmailOtpSendGuard.markSent('A@B.com');
    expect(await EmailOtpSendGuard.mayAutoSend('a@b.COM'), isFalse,
        reason: 'the same address in different case is the same inbox');
    expect(await EmailOtpSendGuard.mayAutoSend('other@b.com'), isTrue,
        reason: "one user's send must not gate another's");
  });

  test('an empty address is never auto-sent to', () async {
    expect(await EmailOtpSendGuard.mayAutoSend(''), isFalse);
    expect(await EmailOtpSendGuard.mayAutoSend('   '), isFalse);
  });

  test('clear forgets the marker', () async {
    await EmailOtpSendGuard.markSent('a@b.com');
    await EmailOtpSendGuard.clear('a@b.com');
    expect(await EmailOtpSendGuard.mayAutoSend('a@b.com'), isTrue);
  });

  test('a clock that moved backwards does not strand the user', () async {
    final future =
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;
    SharedPreferences.setMockInitialValues(
        {'email_otp_last_sent_a@b.com': future});
    expect(await EmailOtpSendGuard.mayAutoSend('a@b.com'), isTrue,
        reason: 'a future timestamp is not trustworthy, and refusing on it '
            'would block sends until that time passed');
  });

  test('the window is at least the server-side resend throttle', () {
    expect(EmailOtpSendGuard.window.inSeconds, greaterThanOrEqualTo(60),
        reason: 'the server refuses a resend inside 60s anyway '
            '(auth_verify.go); a shorter client window just asks for a send '
            'that gets rejected');
    expect(EmailOtpSendGuard.window.inMinutes, lessThan(10),
        reason: 'longer than this and a user who genuinely never received the '
            'first email waits too long for the automatic retry');
  });

  group('the screen actually consults the guard', () {
    late String screen;
    setUpAll(() {
      screen = File(
              'lib/src/features/authentication/presentation/views/email_verification_screen.dart')
          .readAsStringSync();
    });

    test('the auto-send is gated', () {
      expect(screen.contains('EmailOtpSendGuard.mayAutoSend(_email)'), isTrue,
          reason: 'the on-mount send is unconditional again, so a re-mount '
              'kills the live code');
      final gate = screen.indexOf('EmailOtpSendGuard.mayAutoSend');
      final send = screen.indexOf('_sendVerificationEmailOnLoad();');
      expect(gate, lessThan(send),
          reason: 'the guard must be consulted BEFORE sending');
    });

    test('the typed code is no longer wiped on mount', () {
      // THE RULE IS ABOUT *WHEN*, NOT ABOUT WHETHER.
      //
      // This asserted the string `updateVerificationCode('')` was absent from
      // the whole file. That was a proxy for the real rule and it outlawed the
      // legitimate use: clearing the boxes when the server REJECTS a code.
      // Leaving a rejected code in place is its own bug — a full pin field
      // discards further keypresses and paints no caret, so the screen reads
      // as dead. So the scan now looks at the mount path specifically.
      final initStart = screen.indexOf('void initState()');
      expect(initStart, greaterThan(-1));
      // initState ends where the next member begins.
      final initEnd = screen.indexOf('void _sendVerificationEmailOnLoad()');
      expect(initEnd, greaterThan(initStart),
          reason: 'could not bound initState; update this scan');
      final mountPath = screen.substring(initStart, initEnd);

      expect(
        mountPath.contains("updateVerificationCode('')"),
        isFalse,
        reason: 'clearing on mount threw away digits the user had already '
            'entered whenever the screen re-mounted, which is what made it '
            'look like the app had reset itself',
      );
      expect(
        mountPath.contains('_resetCodeInput'),
        isFalse,
        reason: 'the reset helper must not be reachable from the mount path '
            'either — that is the same bug wearing a function name',
      );
    });

    test('a rejected code IS cleared, or the field goes dead', () {
      // The field auto-submits on the sixth digit. If the server refuses it
      // and the digits stay, `maxLength` swallows every further press and the
      // decoration stops drawing a caret past the last box: the keypad
      // responds, nothing appears, the cursor is gone. Reported from the
      // field in exactly those words.
      expect(screen.contains('void _resetCodeInput()'), isTrue,
          reason: 'no way to clear a refused code');
      expect(screen.contains("key: ValueKey('code-\$_codeResetKey')"), isTrue,
          reason: 'the input needs the reset key or remounting cannot clear it');

      // And it has to run on the error branch.
      final errBranch = screen.indexOf('if (state.errorMessage.isNotEmpty) {');
      expect(errBranch, greaterThan(-1),
          reason: 'the error branch must stand on its own, not behind an '
              'else-if that a stale success message can win');
      expect(
        screen.indexOf('_resetCodeInput();', errBranch),
        greaterThan(errBranch),
        reason: 'a refused code must clear the input',
      );
    });

    test('an explicit resend records the send too', () {
      expect(screen.contains('EmailOtpSendGuard.markSent(_email)'), isTrue,
          reason: 'without recording it, the guard would allow an automatic '
              'send moments after the user pressed Resend');
    });
  });
}
