import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';

/// TYPING INTO THE OTP BOXES DID NOTHING, ON EVERY SCREEN THAT USED THEM.
///
/// PinFieldAutoFill is a CONTROLLED component: it holds its own `code` and
/// reconciles against `currentCode` on every didUpdateWidget. Its initState
/// also listens to the controller and sets `code = controller.text` as the user
/// types. With no `currentCode` supplied, the reconciliation reads
/// `currentCode (null) != code ("1")`, sets code back to null and assigns the
/// controller an empty value — erasing the digit just typed.
///
/// Harmless on a screen that never rebuilds mid-typing. Fatal on these: every
/// OTP screen reports each keystroke to a cubit, the cubit emits, the
/// BlocBuilder rebuilds, and the clear fires on EVERY digit. The boxes stayed
/// empty while the keypad responded normally — reported as "entering the code
/// isn't inserting into the boxes".
///
/// The test drives a parent rebuild between keystrokes, which is the condition
/// the bug needs and which no previous test created.
void main() {
  // enableSmsAutofill is left at its DEFAULT (true) on purpose: that selects
  // PinFieldAutoFill, which is the widget with the reconciliation bug and the
  // one every phone-OTP screen actually uses. An earlier version of this file
  // passed false, quietly exercising PinInputTextField instead — it passed
  // with the fix removed, which is worse than having no test.
  TestWidgetsFlutterBinding.ensureInitialized();
  _digitHandlerGuards();

  testWidgets('a digit survives a parent rebuild', (tester) async {
    late StateSetter rebuildParent;
    final changes = <String>[];

    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) {
            rebuildParent = setState;
            return VerificationCodeInput(
              onChanged: changes.add,
            );
          },
        ),
      ),
    )));

    await tester.enterText(find.byType(EditableText), '1');
    await tester.pump();

    // Exactly what a cubit emit does to this subtree.
    rebuildParent(() {});
    await tester.pump();

    expect(find.byType(EditableText), findsOneWidget);
    final field = tester.widget<EditableText>(find.byType(EditableText));
    expect(field.controller.text, '1',
        reason: 'the rebuild erased the digit — this is the bug: the user '
            'types and the boxes stay empty');
  });

  testWidgets('a full code survives repeated rebuilds, one per keystroke',
      (tester) async {
    late StateSetter rebuildParent;
    String last = '';

    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) {
            rebuildParent = setState;
            return VerificationCodeInput(
              onChanged: (c) => last = c,
            );
          },
        ),
      ),
    )));

    // Type the code one digit at a time, rebuilding after each — the real
    // sequence, where every onChanged drives a cubit emit.
    for (var i = 1; i <= 6; i++) {
      await tester.enterText(find.byType(EditableText), '1' * i);
      await tester.pump();
      rebuildParent(() {});
      await tester.pump();
    }

    final field = tester.widget<EditableText>(find.byType(EditableText));
    expect(field.controller.text, '111111');
    expect(last, '111111',
        reason: 'the parent must also have been told the complete code, or '
            'Verify stays disabled on a full-looking field');
  });

  testWidgets('onCompleted fires once the sixth digit is in', (tester) async {
    final completed = <String>[];
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
      home: Scaffold(
        body: VerificationCodeInput(
          onCompleted: completed.add,
        ),
      ),
    )));

    await tester.enterText(find.byType(EditableText), '123456');
    await tester.pump();
    expect(completed, contains('123456'));
  });
}

/// THE SECOND WAY A DIGIT GETS EATEN: unfocusing during the edit that typed it.
///
/// login_otp_screen rolls its own boxes rather than using the widget above, and
/// its last-digit branch called FocusScope.unfocus() synchronously from inside
/// onChanged. Closing the IME connection while the text client is mid-update
/// makes Android revert the in-flight editing value, so the sixth box ended up
/// empty, `_code` was five characters and the auto-submit guard never passed.
///
/// Asserted on the SOURCE because the failure is a platform IME race that a
/// widget test cannot reproduce — `enterText` writes the controller directly
/// and never opens an input connection to tear down. A test that "passes"
/// against the bug would be worse than none, so this checks the property that
/// actually prevents it: the unfocus is deferred past the frame.
void _digitHandlerGuards() {
  test('login_otp does not unfocus during the keystroke it is handling', () {
    final src = _readSource(
        'lib/src/features/authentication/presentation/views/login_otp_screen.dart');

    final start = src.indexOf('void _onDigitChanged(');
    expect(start, greaterThan(-1),
        reason: '_onDigitChanged not found — this guard needs updating');
    var body = src.substring(start);
    final end = body.indexOf('\n  void _onBackspace(');
    if (end > 0) body = body.substring(0, end);

    // Strip comments so the prose above (which names unfocus) cannot satisfy
    // or trip the check — the same trap the Go gate guards hit.
    final code = body
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');

    // SCOPED TO THE LAST-DIGIT BRANCH, not the whole handler. The first
    // version of this guard asked whether `addPostFrameCallback` appeared
    // anywhere in _onDigitChanged — and the paste branch above also defers,
    // so it passed with the bug reinstated. A guard that cannot fail on the
    // defect it names is worse than no guard.
    final branch = code.substring(code.indexOf('index == _boxes - 1'));
    if (branch.contains('unfocus()')) {
      final beforeUnfocus = branch.substring(0, branch.indexOf('unfocus()'));
      expect(beforeUnfocus.contains('addPostFrameCallback'), isTrue,
          reason: 'unfocus() runs inside onChanged. Android reverts the '
              'in-flight editing value when the IME connection closes '
              'mid-update, so the digit that triggered this handler is '
              'discarded — the sixth box stays empty and the code is never '
              'submitted. Defer it with addPostFrameCallback.');
    }

    // And the auto-submit must read the code AFTER the edit commits.
    expect(code.contains('_code.length == _boxes'), isTrue,
        reason: 'the submit must re-read the controllers rather than trust '
            'the value handed to onChanged');
  });
}


String _readSource(String path) => File(path).readAsStringSync();
