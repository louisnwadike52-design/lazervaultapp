import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';
import 'package:lazervault/src/features/widgets/smart_identifier_input.dart';

/// The passcode-reset field must open a NUMBER KEYPAD on the phone channel —
/// and the shared login field must NOT.
///
/// That second half is the point. SmartIdentifierInput is one box taking a
/// phone, an email or a handle, and on an EMPTY field its type falls back to
/// `emptyStateType`, which is phone. Binding the keyboard to that everywhere
/// would open login on a keypad with no letters, so someone signing in with an
/// email could not type the first character. Hence the opt-in.
void main() {
  Future<TextInputType> keyboardOf(
    WidgetTester tester, {
    required bool phoneKeypadOnly,
    required LoginIdentifierType emptyState,
    String typed = '',
  }) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            body: SmartIdentifierInput(
              countryCode: '+234',
              onChanged: (_, __) {},
              allowUsername: false,
              emptyStateType: emptyState,
              phoneKeypadOnly: phoneKeypadOnly,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    if (typed.isNotEmpty) {
      await tester.enterText(find.byType(TextField), typed);
      await tester.pumpAndSettle();
    }
    return tester.widget<TextField>(find.byType(TextField)).keyboardType;
  }

  group('passcode reset (opted in)', () {
    testWidgets('phone channel opens the dialpad', (tester) async {
      expect(
        await keyboardOf(tester,
            phoneKeypadOnly: true, emptyState: LoginIdentifierType.phone),
        TextInputType.phone,
      );
    });

    testWidgets('email channel keeps its letters', (tester) async {
      expect(
        await keyboardOf(tester,
            phoneKeypadOnly: true, emptyState: LoginIdentifierType.email),
        TextInputType.emailAddress,
        reason: 'switching to Use my email must give back a keyboard that can '
            'type an address',
      );
    });

    testWidgets('typing an address still flips it back', (tester) async {
      expect(
        await keyboardOf(tester,
            phoneKeypadOnly: true,
            emptyState: LoginIdentifierType.phone,
            typed: 'a@b.com'),
        TextInputType.emailAddress,
      );
    });
  });

  group('login (NOT opted in) — unchanged', () {
    testWidgets('an empty combined field still takes letters', (tester) async {
      expect(
        await keyboardOf(tester,
            phoneKeypadOnly: false, emptyState: LoginIdentifierType.phone),
        TextInputType.emailAddress,
        reason: 'the login field defaults to phone when empty. A keypad here '
            'would leave an email user unable to type anything at all.',
      );
    });

    testWidgets('and still takes letters with digits in it', (tester) async {
      expect(
        await keyboardOf(tester,
            phoneKeypadOnly: false,
            emptyState: LoginIdentifierType.phone,
            typed: '0801234'),
        TextInputType.emailAddress,
      );
    });
  });
}
