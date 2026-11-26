import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/widgets/resend_code_button.dart';

/// A COOLDOWN IS A STATEMENT THAT A CODE WENT OUT.
///
/// Running one after a refusal tells the customer to wait for something that
/// never happened — and it contradicts the error they are looking at. A real
/// customer saw "too many codes requested. Please try again in 24 minutes"
/// sitting directly above "Resend in 57s", because the button substituted 60
/// for a null return and started counting regardless.
void main() {
  Future<void> pump(WidgetTester tester, Future<int?> Function() onResend,
      {int initial = 0}) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            body: ResendCodeButton(
              initialSeconds: initial,
              onResend: onResend,
              prompt: "Didn't receive the code?",
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a refusal starts NO countdown and leaves the button tappable',
      (tester) async {
    var calls = 0;
    await pump(tester, () async {
      calls++;
      return null; // the server refused — nothing was sent
    });

    expect(find.textContaining('Resend in'), findsNothing);
    await tester.tap(find.text('Resend code'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(calls, 1);
    expect(find.textContaining('Resend in'), findsNothing,
        reason: 'a countdown here contradicts the refusal on screen');
    expect(find.text('Resend code'), findsOneWidget,
        reason: 'the server decides when another code may be sent, and it '
            'already said so in its message');
  });

  testWidgets('a successful resend counts down the cooldown the server gave',
      (tester) async {
    await pump(tester, () async => 90);

    await tester.tap(find.text('Resend code'));
    await tester.pump();
    await tester.pumpAndSettle();

    // 90, not a compiled-in 60: the server's dial is the only source.
    expect(find.textContaining('Resend in 90s'), findsOneWidget);
  });

  testWidgets('a zero or negative cooldown is treated as no cooldown',
      (tester) async {
    await pump(tester, () async => 0);
    await tester.tap(find.text('Resend code'));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('Resend code'), findsOneWidget);
    expect(find.textContaining('Resend in'), findsNothing);
  });

  testWidgets('an initial cooldown still renders and runs down',
      (tester) async {
    await pump(tester, () async => 60, initial: 3);
    expect(find.textContaining('Resend in 3s'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('Resend in 2s'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Resend code'), findsOneWidget);
  });
}
