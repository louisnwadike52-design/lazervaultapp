import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/dismiss_keyboard.dart';

/// A share sheet must not outlive the session.
///
/// Logout tears down the PAGE stack with Get.offAllNamed, which is enough for
/// ordinary pages. A bottom sheet or dialog is a PopupRoute sitting ABOVE that
/// stack, so an open share sheet would be left hovering over the login screen
/// still showing the previous user's account number, receipt or payment link.
///
/// The two things this has to get right are opposites, so both are asserted:
/// it must close the sheet, and it must NOT keep popping into the page
/// underneath — a logout that popped the navigator empty would be worse than
/// the bug.
void main() {
  Widget app() => GetMaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                builder: (_) => const Text('share sheet'),
              ),
              child: const Text('home page'),
            ),
          ),
        ),
      );

  testWidgets('closes an open share sheet', (tester) async {
    await tester.pumpWidget(app());
    await tester.tap(find.text('home page'));
    await tester.pumpAndSettle();
    expect(find.text('share sheet'), findsOneWidget,
        reason: 'precondition: the sheet is open');

    dismissTransientOverlays();
    await tester.pumpAndSettle();

    expect(find.text('share sheet'), findsNothing,
        reason: 'a sheet left open at logout hovers over the login screen');
    expect(find.text('home page'), findsOneWidget,
        reason: 'the page underneath must survive — popUntil stops at the '
            'first non-popup route');
  });

  testWidgets('is a no-op when nothing is floating', (tester) async {
    await tester.pumpWidget(app());
    expect(find.text('home page'), findsOneWidget);

    dismissTransientOverlays();
    await tester.pumpAndSettle();

    expect(find.text('home page'), findsOneWidget,
        reason: 'with no sheet open this must not pop the page stack');
  });
}
