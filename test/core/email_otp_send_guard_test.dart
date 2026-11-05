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
      expect(
        screen.contains("updateVerificationCode('')"),
        isFalse,
        reason: 'clearing on mount threw away digits the user had already '
            'entered whenever the screen re-mounted, which is what made it '
            'look like the app had reset itself',
      );
    });

    test('an explicit resend records the send too', () {
      expect(screen.contains('EmailOtpSendGuard.markSent(_email)'), isTrue,
          reason: 'without recording it, the guard would allow an automatic '
              'send moments after the user pressed Resend');
    });
  });
}
