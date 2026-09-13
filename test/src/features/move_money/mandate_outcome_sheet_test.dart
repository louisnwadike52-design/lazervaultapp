import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_outcome_sheet.dart';

// Every one of these states used to be a SNACKBAR — a container that vanishes
// while the user is still deciding, and that cannot carry the one question
// that actually matters here: "did you already send the NGN 50?" Only the user
// knows, and the answer changes what we do next.

Future<void> pump(WidgetTester tester, MandateOutcome outcome) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      // A fresh key per call. Without it pumpWidget UPDATES the existing tree
      // rather than replacing it, so a sheet opened by a previous call — and
      // the unconfirmed one cannot be dismissed — survives and covers the
      // button, leaving later cases silently asserting against the old sheet.
      builder: (_, __) => MaterialApp(
        key: ValueKey(outcome),
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showMandateOutcomeSheet(
                context: context,
                outcome: outcome,
                bankName: 'ALAT by WEMA',
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the unconfirmed state ASKS rather than declaring failure',
      (tester) async {
    await pump(tester, MandateOutcome.unconfirmed);
    expect(find.textContaining('Did you finish with'), findsOneWidget);
    // The user who already completed the step is at risk of doing it twice, so
    // their path must be present and unmistakable.
    expect(find.text('Yes, I finished it'), findsOneWidget);
    expect(find.text("Not yet, I'll finish later"), findsOneWidget);
  });

  testWidgets('it is method-agnostic and warns against doing it twice',
      (tester) async {
    // Mono decides login-vs-one-off-transfer on its hosted page and never tells
    // us which, so the copy must cover BOTH and never falsely instruct a
    // login-based bank to "send ₦50".
    await pump(tester, MandateOutcome.unconfirmed);
    final body = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? '')
        .join(' ');
    expect(body.toLowerCase(), contains('login approval'));
    expect(body.toLowerCase(), contains('one-off transfer'));
    expect(body.toLowerCase(), contains('do not do it twice'));
    // Must NOT hardcode the ₦50 amount as the required action.
    expect(body, isNot(contains('₦50')));
  });

  testWidgets('"finished" returns true so the caller keeps polling',
      (tester) async {
    await pump(tester, MandateOutcome.unconfirmed);
    // The sheet scrolls (85% max height); bring the button into view first.
    await tester.ensureVisible(find.text('Yes, I finished it'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yes, I finished it'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Did you finish with'), findsNothing);
  });

  testWidgets('the unconfirmed sheet exposes a dismissible scrim (escape)',
      (tester) async {
    // The scrim is now a valid escape: a dismissible ModalBarrier means the
    // sheet can be tapped away, returning null — which the caller treats like
    // "Not yet" (return to the deposit form, no re-open). Locking it, combined
    // with the caller re-opening the flow, was the infinite-loop trap. (Actual
    // dismissal is exercised by the back-button test below.)
    await pump(tester, MandateOutcome.unconfirmed);
    final dismissibleBarrier = find.byWidgetPredicate(
      (w) => w is ModalBarrier && w.dismissible == true,
    );
    expect(dismissibleBarrier, findsWidgets);
  });

  navigationEdgeCases();

  testWidgets('the confirming state tells the user there is nothing to do',
      (tester) async {
    await pump(tester, MandateOutcome.confirming);
    expect(find.textContaining('Confirming with ALAT by WEMA'), findsOneWidget);
    // No resume action — reopening a spent link is exactly what dead-ends.
    expect(find.text("Not yet, I'll finish later"), findsNothing);
  });

  testWidgets('the expired state reassures that nothing was charged',
      (tester) async {
    await pump(tester, MandateOutcome.linkExpired);
    final body = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? '')
        .join(' ');
    expect(body.toLowerCase(), contains('nothing was charged'));
  });

  testWidgets('every state names the bank the user chose', (tester) async {
    for (final o in [
      MandateOutcome.unconfirmed,
      MandateOutcome.confirming,
      MandateOutcome.active,
    ]) {
      await pump(tester, o);
      final body = tester
          .widgetList<Text>(find.byType(Text))
          .map((t) => t.data ?? '')
          .join(' ');
      expect(body, contains('ALAT by WEMA'), reason: '$o');
    }
  });
}

// Navigation edge cases. The unconfirmed sheet is now escapable (scrim + back
// both dismiss → null, treated as "Not yet"), because locking it trapped users
// in a loop. The remaining guard is the double-tap one: a sheet stays
// hit-testable while it animates out, so a fast double-tap must resolve ONCE
// and never pop the screen underneath.

Future<int> pumpOverAScreen(WidgetTester tester, MandateOutcome outcome) async {
  var poppedPastTheSheet = 0;
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                await showMandateOutcomeSheet(
                  context: context,
                  outcome: outcome,
                  bankName: 'ALAT by WEMA',
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
        // A second route under the sheet stands in for the deposit screen: if
        // a double-tap pops twice, this is what disappears.
        navigatorObservers: [_PopSpy(() => poppedPastTheSheet++)],
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return poppedPastTheSheet;
}

class _PopSpy extends NavigatorObserver {
  _PopSpy(this.onPop);
  final VoidCallback onPop;
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) => onPop();
}

void navigationEdgeCases() {
  testWidgets('the back button dismisses the sheet (escape, no loop)',
      (tester) async {
    await pump(tester, MandateOutcome.unconfirmed);
    // Android back / iOS back-swipe now pops the sheet → caller gets null and
    // returns to the deposit form (the poll it fired beforehand keeps running).
    // This is the escape hatch; blocking it is what trapped users in a loop.
    final handled =
        await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
      'flutter/navigation',
      const JSONMethodCodec().encodeMethodCall(
        const MethodCall('popRoute'),
      ),
      (_) {},
    );
    await tester.pumpAndSettle();
    expect(handled, isNotNull);
    expect(find.textContaining('Did you finish with'), findsNothing);
  });

  testWidgets('a resolved state CAN still be dismissed normally',
      (tester) async {
    // Every state is now dismissible; the terminal "Got it" states especially.
    await pump(tester, MandateOutcome.active);
    await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
      'flutter/navigation',
      const JSONMethodCodec().encodeMethodCall(const MethodCall('popRoute')),
      (_) {},
    );
    await tester.pumpAndSettle();
    expect(find.text('Direct Debit is on'), findsNothing);
  });

  testWidgets('a double-tap resolves once, never popping the screen under it',
      (tester) async {
    await pumpOverAScreen(tester, MandateOutcome.unconfirmed);
    final btn = find.text('Yes, I finished it');
    await tester.ensureVisible(btn);
    await tester.pumpAndSettle();
    // Two taps inside the exit animation — the sheet is still hit-testable.
    await tester.tap(btn, warnIfMissed: false);
    await tester.pump(const Duration(milliseconds: 16));
    await tester.tap(btn, warnIfMissed: false);
    await tester.pumpAndSettle();
    // The launcher screen must survive.
    expect(find.text('open'), findsOneWidget);
  });
}
