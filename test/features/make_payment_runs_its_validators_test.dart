import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A Form whose validate() is never called is protection that does not exist.
///
/// make_payment_screen.dart attaches _formKey to its Form and the amount field
/// carries real rules — the overpay caps for both partial modes, the
/// already-settled refusal, and the fixed-share equality rule. None of them ran:
/// validate() was never called anywhere on the screen, so the only client-side
/// check was `amount <= 0`.
///
/// The reported case was NGN 20,000 entered against a NGN 200 share. It passed
/// every client check, took the user through the PIN, and was refused by
/// group-accounts at the very end — after they had committed to it.
void main() {
  final src = File('lib/src/features/group_account/presentation/views/'
          'make_payment_screen.dart')
      .readAsStringSync()
      // Strip comments: this file now EXPLAINS the bug and quotes the call,
      // so a raw scan could pass by matching its own documentation.
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  test('the pay action runs the form validators before anything else', () {
    expect(src, contains('_formKey.currentState?.validate()'),
        reason: 'Without this the amount validators are dead code and the '
            'server refusal arrives after the PIN.');

    final validateAt = src.indexOf('_formKey.currentState?.validate()');
    final pinAt = src.indexOf('validateTransactionPin');
    expect(validateAt, greaterThan(-1));
    if (pinAt > -1) {
      expect(validateAt, lessThan(pinAt),
          reason: 'validation must happen BEFORE the PIN sheet — refusing a '
              'member after they have entered their PIN is the failure this '
              'fixes');
    }
  });

  test('the amount field still carries the rules worth running', () {
    for (final rule in const [
      'already paid your share for this cycle',
      'remaining for this cycle',
      'takes exactly',
    ]) {
      expect(src, contains(rule),
          reason: 'an amount rule was removed; the server still enforces it, '
              'so the user would meet it as a late refusal instead');
    }
  });

  test('the scan can tell a present call from an absent one', () {
    // Guards that pass on broken code are worse than none.
    expect(src.contains('_formKey.currentState?.validateNothingHere()'), isFalse);
  });
}
