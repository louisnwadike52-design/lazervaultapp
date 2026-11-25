import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE COUNTDOWN AND THE CODE MUST BE THE SAME NUMBER.
///
/// Reported 2026-11-25 by a customer: a code reported expired "before it was
/// actually expired", and Resend that did nothing until the app was updated.
/// Both halves were number drift between the app and the server.
///
///  * The email screen armed a SIXTY-second resend cooldown while the live
///    dial said ninety. The button unlocked thirty seconds early, every tap in
///    that gap was refused by the server AND spent a resend from the budget,
///    and once the budget was gone Resend stopped working entirely — which is
///    exactly what she described.
///
///  * The registry's fallback windows were 60s (email) and 300s (SMS) against
///    live rows of 120. With an unreadable settings snapshot the app counted
///    down from five minutes on a two-minute code.
void main() {
  final registry =
      File('lib/core/services/endpoint_registry.dart').readAsStringSync();
  final emailScreen = File(
          'lib/src/features/authentication/presentation/views/email_verification_screen.dart')
      .readAsStringSync();

  // Comments discuss the old numbers by name, so a check about code must not
  // read them.
  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  test('the resend cooldown is the server dial, never a literal', () {
    final body = code(emailScreen);
    final armCalls = RegExp(r'_armResendCooldown\(([^)]*)\)')
        .allMatches(body)
        .map((m) => m.group(1)!.trim())
        .where((arg) => arg != 'int seconds') // the declaration itself
        .toList();
    expect(armCalls, isNotEmpty,
        reason: 'the cooldown is never armed, so Resend is tappable instantly');
    for (final arg in armCalls) {
      expect(int.tryParse(arg), isNull,
          reason: 'a literal cooldown ($arg) drifts from the admin dial — at 60 '
              'against a server 90 it unlocked the button early, and every tap '
              'in the gap spent a resend without sending one');
    }
  });

  test('both code windows default to the same 120 the server defaults to', () {
    expect(registry, contains("_get('auth_otp_ttl_email_seconds', '120')"),
        reason: 'must match auth-service otpTTLDefault');
    expect(registry, contains("_get('auth_otp_ttl_sms_seconds', '120')"),
        reason: 'must match auth-service otpTTLDefault');
  });

  test('the windows are read from the server keys, not invented', () {
    for (final key in const [
      'auth_otp_ttl_email_seconds',
      'auth_otp_ttl_sms_seconds',
      'auth_otp_resend_cooldown_seconds',
    ]) {
      expect(registry, contains(key),
          reason: '$key is the key auth-service reads; a different name here '
              'silently falls back for ever');
    }
  });

  test('the stated expiry comes from the dial, not from prose', () {
    expect(code(emailScreen), contains('endpointRegistry.otpTtlEmailSeconds'),
        reason: 'the "It expires in ..." line must be the window the server '
            'minted, or it promises what the database will not honour');
  });
}
