import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';

/// "THE NUMBER WAS PRESSING BUT NOT INPUTTING. THE CURSOR LINE JUST
/// DISAPPEARS."
///
/// Reported from the field on the email OTP screen. Nothing was wrong with the
/// pin widget — it was the screen leaving SIX REJECTED DIGITS in the field.
/// A full pin field is inert by construction, and these tests pin both halves
/// of that so the behaviour is written down rather than rediscovered:
///
///   * `maxLength: 6` discards a seventh keypress silently — the keypad
///     responds, no digit appears;
///   * the box decoration paints a caret only while `index < pinLength`, so at
///     six digits there is no cursor to see or to move.
///
/// The screen's fix is a reset key bumped on failure. What these tests
/// guarantee is that a CLEARED field is immediately usable again — which is
/// the property the fix depends on.
void main() {
  Widget host({Key? codeKey, bool sms = false, ValueChanged<String>? onChanged}) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: VerificationCodeInput(
            key: codeKey,
            enableSmsAutofill: sms,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  void ime(WidgetTester tester, String text) {
    tester.testTextInput.updateEditingValue(TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    ));
  }

  TextEditingController ctrl(WidgetTester tester) =>
      tester.widget<EditableText>(find.byType(EditableText)).controller;

  testWidgets('a full field swallows further presses — the reported symptom',
      (tester) async {
    await tester.pumpWidget(host());
    await tester.pumpAndSettle();
    await tester.tap(find.byType(EditableText));
    await tester.pumpAndSettle();

    ime(tester, '123456');
    await tester.pump();
    expect(ctrl(tester).text, '123456');

    // The seventh press. This is what the user was doing.
    ime(tester, '1234567');
    await tester.pump();
    expect(ctrl(tester).text, '123456',
        reason: 'a seventh digit is discarded, which is why the keypad felt dead');
  });

  testWidgets('remounting with a new key clears it and it types again',
      (tester) async {
    final changes = <String>[];
    await tester.pumpWidget(
        host(codeKey: const ValueKey('code-0'), onChanged: changes.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(EditableText));
    await tester.pumpAndSettle();

    ime(tester, '123456');
    await tester.pump();
    expect(ctrl(tester).text, '123456');

    // What the screen now does when the server rejects the code.
    await tester.pumpWidget(
        host(codeKey: const ValueKey('code-1'), onChanged: changes.add));
    await tester.pumpAndSettle();
    expect(ctrl(tester).text, '',
        reason: 'the rejected digits must be gone, or the field stays inert');

    // autoFocus must have brought the caret back, or the user has to hunt for
    // a box to tap — and tapping a pin box is not an obvious affordance.
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
      isTrue,
      reason: 'cleared is only useful if it is also ready to type into',
    );

    ime(tester, '9');
    await tester.pump();
    expect(ctrl(tester).text, '9');
    expect(changes.last, '9');
  });

  testWidgets('backspacing through a full field works digit by digit',
      (tester) async {
    await tester.pumpWidget(host());
    await tester.pumpAndSettle();
    await tester.tap(find.byType(EditableText));
    await tester.pumpAndSettle();

    ime(tester, '123456');
    await tester.pump();
    for (final step in ['12345', '1234', '123', '12', '1', '']) {
      ime(tester, step);
      await tester.pump();
      expect(ctrl(tester).text, step);
      expect(ctrl(tester).selection.isValid, isTrue,
          reason: 'an invalid selection is a field with no caret');
    }
  });

  testWidgets('with SMS autofill off there is no SMS subscription at all',
      (tester) async {
    // PinFieldAutoFill calls listenForCode() unconditionally, and its default
    // match is \d{4,6} against ANY incoming SMS — so an unrelated bank alert
    // could replace a half-typed EMAIL code. The email screen must therefore
    // not be using that widget at all.
    final calls = <String>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('sms_autofill'),
            (call) async {
      calls.add(call.method);
      return null;
    });

    await tester.pumpWidget(host(sms: false));
    await tester.pumpAndSettle();
    expect(calls, isEmpty,
        reason: 'an email-code screen must not start the SMS retriever');

    // And the opt-in path still does subscribe, exactly once.
    calls.clear();
    await tester.pumpWidget(host(sms: true, codeKey: const ValueKey('sms')));
    await tester.pumpAndSettle();
    expect(calls.where((c) => c == 'listenForCode').length, 1,
        reason: 'phone OTP screens need autofill — once, not twice');
  });
}
