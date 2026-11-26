// THE OTP FIELD MUST BE THE SAME ON BOTH PLATFORMS.
//
// VerificationCodeInput used to swap its input widget depending on whether the
// screen wanted SMS autofill. The autofill variant, PinFieldAutoFill, is not
// the same field with a listener bolted on — it is a CONTROLLED component that
// reconciles its own `code` against `currentCode` on every rebuild, tags the
// input `AutofillHints.oneTimeCode` for the Android autofill framework, and
// starts the SMS Retriever. `listenForCode()` returns early on iOS, so all of
// that was Android-only.
//
// The result was that SMS screens ran an input path the EMAIL screens never
// touched, on one platform. On 2026-11-18 a customer on Android received his
// code and could not enter it: four login attempts over forty minutes, and no
// verify call ever reached the server, so the digits never left the device.
//
// The listener is now separate from the field. These assertions keep it that
// way — they are source-level because the failure is structural, and the
// broken version rendered, compiled and passed any test that drove the widget
// through its callbacks rather than through a real Android text input.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final src = File(
    'lib/src/features/widgets/verification_code_input.dart',
  ).readAsStringSync();

  group('OTP input', () {
    test('renders exactly one field widget, for every screen', () {
      // PinFieldAutoFill anywhere in the build means the Android-only input
      // path is reachable again.
      final rendered = RegExp(
        r'child:\s*PinFieldAutoFill\(|^\s*PinFieldAutoFill\(',
        multiLine: true,
      ).allMatches(src).length;
      expect(
        rendered,
        0,
        reason:
            'PinFieldAutoFill is a controlled component that tags the '
            'field AutofillHints.oneTimeCode and starts the Android SMS '
            'Retriever — it must not be in the input path',
      );

      expect(
        src.contains('PinInputTextField('),
        isTrue,
        reason:
            'the plain field — the one the email screens have always '
            'used — is what every screen should render',
      );
    });

    test('there is no branch that picks a different widget per screen', () {
      // A conditional around the field is how the two paths diverged before.
      final branchy = RegExp(
        r'child:\s*widget\.enableSmsAutofill',
      ).hasMatch(src);
      expect(
        branchy,
        isFalse,
        reason:
            'the screen flag must choose whether to LISTEN, never which '
            'field to render',
      );
    });

    test('autofill fills only an empty field', () {
      final i = src.indexOf('void codeUpdated()');
      expect(i, greaterThan(0), reason: 'the listener lives on this State now');
      final fn = src.substring(i, i + 900);
      expect(
        fn.contains('_controller.text.isNotEmpty'),
        isTrue,
        reason:
            'an SMS landing mid-typing must not overwrite what the '
            'customer is entering — the exact complaint in this file\'s history',
      );
    });

    test('an autofilled code gets a valid caret position', () {
      final i = src.indexOf('void codeUpdated()');
      final fn = src.substring(i, i + 900);
      expect(
        fn.contains('TextSelection.collapsed'),
        isTrue,
        reason:
            'TextEditingValue(text:) alone leaves selection at offset -1, '
            'which Android cannot place a caret at — the next keypress then '
            'has nowhere to go',
      );
    });

    test('the listener is torn down with the screen', () {
      final i = src.indexOf('void dispose()');
      final fn = src.substring(i, i + 600);
      expect(
        fn.contains('cancel()'),
        isTrue,
        reason: 'the stream subscription outlives the widget otherwise',
      );
      expect(
        fn.contains('unregisterListener()'),
        isTrue,
        reason:
            'the platform retriever keeps running otherwise — one leak '
            'per OTP screen visit',
      );
    });
  });
}
