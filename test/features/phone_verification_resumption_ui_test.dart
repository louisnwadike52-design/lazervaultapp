import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE RESUMPTION SCREEN'S LAYOUT, AND THE TWO THINGS THAT DEGRADED IT.
///
/// The screen renders: badge, title, masked number, six boxes, Verify, the
/// resend control, the Secure Verification note, and a way out. That order is
/// the design and is asserted here so a later edit cannot quietly reorder it.
///
/// What actually changed between a good screenshot and a bad one was never the
/// layout — it was STATE:
///
///   * the resend rendered as a bare "Resend code" link instead of
///     "Resend in 54s", because the cooldown was seeded only in initState and
///     never when a code was actually SENT;
///   * typing did nothing, because PinFieldAutoFill reconciles against
///     `currentCode` on every rebuild and none was passed.
void main() {
  final src = File(
    'lib/src/features/authentication/presentation/views/'
    'phone_verification_screen.dart',
  ).readAsStringSync();

  test('the screen still renders the designed pieces, in order', () {
    const order = [
      'VerificationBadgeIcon',
      'Verify Your Phone',
      'VerificationCodeInput',
      'ElevatedButton',
      'ResendCodeButton',
      'SecureVerificationNote',
    ];
    var at = -1;
    for (final piece in order) {
      final i = src.indexOf(piece, at + 1);
      expect(i, greaterThan(at), reason: '"$piece" is missing or out of order');
      at = i;
    }
  });

  // A cooldown belongs to the moment a code was SENT. Seeded only in initState
  // it covered the first paint and nothing after, so any code sent later left
  // the screen offering a resend the server would refuse anyway.
  test('the resend cooldown restarts whenever a code is sent', () {
    // Anchored on the LISTENER BRANCH, not the first mention of the state —
    // the type is named in a comment further up, and a window opened there
    // measured the wrong part of the file.
    final start = src.indexOf('if (state is PhoneVerificationCodeSent)');
    expect(start, greaterThan(-1),
        reason: 'the code-sent branch is gone — this guard needs updating');
    final end = src.indexOf('} else if', start);
    final block = src.substring(start, end > start ? end : start + 1600);
    expect(block.contains('_startResendCooldown'), isTrue,
        reason: 'the code-sent listener restarts the expiry but not the '
            'cooldown, so the control renders as a bare "Resend code" link '
            'instead of a countdown');
  });

  test('the cooldown is one named value, not a literal in three places', () {
    expect(src.contains('_kResendCooldownSeconds'), isTrue);
    expect(RegExp(r'_startResendCooldown\(60\)').hasMatch(src), isFalse,
        reason: 'a value deciding whether a control is usable must not be a '
            'literal somebody can change in two places out of three');
  });

  // The fix that made typing work at all — asserted here too because this
  // screen is the one it was reported on.
  //
  // THIS TEST USED TO ASSERT THE OPPOSITE, and the opposite was the bug.
  //
  // It required `currentCode: _controller.text`, on the reasoning that without
  // it `PinFieldAutoFill` resets the controller on every rebuild. That was a
  // true statement about a design that has since been removed: being a
  // CONTROLLED component is exactly what broke typing on Android.
  // `PinFieldAutoFill` reconciles against `currentCode` in `didUpdateWidget`
  // and assigns `TextEditingValue(text:)` with no selection — a caret offset
  // of −1 — and it also tagged the input `AutofillHints.oneTimeCode` and
  // started the SMS Retriever, neither of which happens on iOS. So the SMS
  // screens ran an input path the email screens never touched, on one
  // platform, and a customer could not type a code he had received.
  //
  // The field is now `PinInputTextField` on both platforms — uncontrolled —
  // with autofill sitting BESIDE the input instead of inside it. So the
  // property worth pinning is the reverse: the field must not be controlled,
  // and must never overwrite what the customer has already typed.
  test('the code field is NOT a controlled component', () {
    final field = File(
      'lib/src/features/widgets/verification_code_input.dart',
    ).readAsStringSync();

    // Strip the comment lines, which narrate the old design by name.
    final code = field
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//') &&
            !l.trimLeft().startsWith('///'))
        .join('\n');

    expect(code.contains('PinFieldAutoFill'), isFalse,
        reason: 'PinFieldAutoFill is a controlled component: it reconciles '
            'against currentCode on every rebuild and assigns a '
            'TextEditingValue with no selection, which is what made typing '
            'impossible on Android. The field is PinInputTextField on both '
            'platforms.');
    expect(code.contains('currentCode:'), isFalse,
        reason: 'currentCode is the controlled-component seam. Feeding the '
            'controller back into the field is what replaced live typing.');
    expect(code.contains('PinInputTextField'), isTrue,
        reason: 'one field, identical on both platforms');
    // The autofill path may only ever fill an EMPTY field.
    expect(code.contains('if (_controller.text.isNotEmpty) return'), isTrue,
        reason: 'an arriving SMS code must never overwrite digits the '
            'customer is in the middle of typing');
  });

  // Entering the sixth digit submits, like every other OTP screen.
  test('the last digit submits', () {
    expect(src.contains('verifyPhoneNumber('), isTrue);
    final oc = src.indexOf('onCompleted:');
    expect(oc, greaterThan(-1));
    expect(src.substring(oc, oc + 600).contains('verifyPhoneNumber'), isTrue,
        reason: 'a customer who has typed six digits has already said what '
            'they came to say; asking them to confirm it is a step with '
            'nothing in it');
  });
}
