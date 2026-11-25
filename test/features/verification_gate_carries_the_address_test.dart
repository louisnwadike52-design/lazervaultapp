import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/verification_gate_routing.dart';

/// THE CODE SCREEN HAD NO ADDRESS, SO IT COULD NEITHER NAME AN INBOX NOR
/// RESEND.
///
/// Reported 2026-11-25 with a screenshot: "Enter the 6-digit code sent to"
/// followed by an empty line, and a customer saying no email arrived.
///
/// Two separate faults met on that screen:
///
///  1. `routeToVerificationGate` pushed the verification screen with no
///     `email` argument. On a phone+passcode login the client has never seen
///     the customer's address, and the stored-signup fallback is empty on a
///     device that did not sign up here — so the subtitle rendered blank,
///     `_sendVerificationEmailOnLoad` returned early, and Resend posted an
///     empty address.
///
///  2. auth-service's gate RE-USED a live code without re-publishing it. That
///     was right about the token (minting a new one invalidates the code
///     already in the inbox — the 2026-11-05 defect) and wrong about the
///     delivery: once any code existed, no further email was ever sent, so a
///     first code lost to a bounce or a spam folder could never be replaced.
void main() {
  test('the address is read out of the gate refusal', () {
    expect(
      emailFromVerificationGate(
          'email_not_verified: please verify your email to continue [verify_email=grace@example.com]'),
      'grace@example.com',
    );
  });

  test('an older backend without the tail is not a crash', () {
    expect(
        emailFromVerificationGate(
            'email_not_verified: please verify your email to continue'),
        isNull,
        reason: 'the screen then falls back to the stored signup address');
    expect(emailFromVerificationGate(null), isNull);
    expect(emailFromVerificationGate('[verify_email=]'), isNull,
        reason: 'an empty tail must not be passed off as an address');
  });

  test('the machine-readable tail never reaches a person', () {
    expect(
      stripGateTokens(
          'email_not_verified: please verify your email to continue [verify_email=grace@example.com]'),
      'email_not_verified: please verify your email to continue',
    );
  });

  test('the router actually passes it on', () {
    final src = File('lib/core/utils/verification_gate_routing.dart')
        .readAsStringSync();
    expect(src, contains("if (email != null) 'email': email"),
        reason: 'extracting the address and then not passing it is the bug');
  });

  test('an empty address is never passed as if it were one', () {
    final src = File('lib/core/utils/verification_gate_routing.dart')
        .readAsStringSync();
    // The route treats any non-null `email` as resolved and the screen then
    // stops consulting secure storage, so '' would be worse than absent.
    expect(src.contains("'email': email ?? ''"), isFalse);
  });

  test('every login surface routes through the one helper', () {
    final passcode = File(
            'lib/src/features/authentication/presentation/widgets/passcode_sign_in.dart')
        .readAsStringSync();
    expect(passcode, contains('routeToVerificationGate('),
        reason: 'the open-coded push here is what shipped without an address');
  });

  test('the subtitle is never a blank line', () {
    final screen = File(
            'lib/src/features/authentication/presentation/views/email_verification_screen.dart')
        .readAsStringSync();
    expect(screen, contains('maskedEmail.isEmpty'),
        reason: 'with no address resolved the screen must still say something');
    expect(screen, contains('the email address on your account'));
  });

  test('resend refuses locally rather than posting an empty address', () {
    final cubit = File(
            'lib/src/features/authentication/cubit/email_verification_cubit.dart')
        .readAsStringSync();
    expect(cubit, contains("if (_email.trim().isEmpty)"),
        reason: 'the server answers an empty address with a validation error '
            'about a field the customer never saw');
  });
}
