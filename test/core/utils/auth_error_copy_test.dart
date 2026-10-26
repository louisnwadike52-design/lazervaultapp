import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/auth_error_copy.dart';

/// Users must never see a backend code, and must not be told a step is a
/// failure.
///
/// Reported 2026-10-26: resuming login showed "Login Failed —
/// email_not_verified: please verify your email to continue" over the Verify
/// Your Email screen the app had just routed to.
void main() {
  test('the exact reported message produces no banner and no raw code', () {
    const raw = 'email_not_verified: please verify your email to continue';
    final c = authErrorCopy(raw);

    expect(c.suppressBanner, isTrue,
        reason: 'the verification screen already says this; a banner covers it');
    expect(c.message.contains('email_not_verified'), isFalse,
        reason: 'the backend code reached the user');
    expect(c.title, isNot('Login Failed'),
        reason: 'the passcode was correct — this is a next step, not a failure');
  });

  test('no mapped message ever leaks a raw code or underscore token', () {
    const raws = [
      'email_not_verified: please verify your email to continue',
      'phone_not_verified',
      'invalid_credentials',
      'account_locked: too many attempts',
      'account_frozen by fraud review',
      'SocketException: Failed host lookup',
      'HTTP 503 service unavailable',
      'something nobody has seen before',
      null,
      '',
    ];
    for (final raw in raws) {
      final c = authErrorCopy(raw);
      expect(c.message.trim(), isNotEmpty, reason: 'empty message for $raw');
      expect(c.title.trim(), isNotEmpty, reason: 'empty title for $raw');
      // A snake_case token in user copy is the signature of a leaked code.
      expect(RegExp(r'[a-z]+_[a-z]+').hasMatch(c.message), isFalse,
          reason: 'raw-looking token leaked for $raw: ${c.message}');
      expect(c.message.contains('Exception'), isFalse,
          reason: 'exception text leaked for $raw');
    }
  });

  test('an unknown failure is generic, never the raw text', () {
    final c = authErrorCopy('weird internal detail nobody should read');
    expect(c.message.contains('weird internal detail'), isFalse);
    expect(c.suppressBanner, isFalse,
        reason: 'an unknown failure has no better screen to defer to');
  });

  test('a wrong passcode does not reveal whether the account exists', () {
    final c = authErrorCopy('invalid_credentials');
    final m = c.message.toLowerCase();
    for (final leak in ['no account', 'not found', 'does not exist', 'no user']) {
      expect(m.contains(leak), isFalse, reason: 'enumeration hint: $leak');
    }
  });
}
