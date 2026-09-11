import 'package:flutter/material.dart';
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
      builder: (_, __) => MaterialApp(
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
    expect(find.text('Did you send the transfer?'), findsOneWidget);
    // The user who already paid is the one at risk of paying twice, so their
    // path must be present and unmistakable.
    expect(find.text('Yes, I already sent it'), findsOneWidget);
    expect(find.text('Not yet — take me back'), findsOneWidget);
  });

  testWidgets('it names the amount and warns against paying twice',
      (tester) async {
    await pump(tester, MandateOutcome.unconfirmed);
    final body = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? '')
        .join(' ');
    expect(body, contains('₦50'));
    expect(body.toLowerCase(), contains('do not send it again'));
  });

  testWidgets('"already sent" returns true so the caller keeps polling',
      (tester) async {
    await pump(tester, MandateOutcome.unconfirmed);
    await tester.tap(find.text('Yes, I already sent it'));
    await tester.pumpAndSettle();
    expect(find.text('Did you send the transfer?'), findsNothing);
  });

  testWidgets('the unconfirmed sheet cannot be dismissed by the scrim',
      (tester) async {
    // Tapping it away would lose the only screen telling a user who may have
    // just paid that the setup is still in progress.
    await pump(tester, MandateOutcome.unconfirmed);
    await tester.tapAt(const Offset(200, 60));
    await tester.pumpAndSettle();
    expect(find.text('Did you send the transfer?'), findsOneWidget);
  });

  testWidgets('the confirming state tells the user there is nothing to do',
      (tester) async {
    await pump(tester, MandateOutcome.confirming);
    expect(find.textContaining('Confirming with ALAT by WEMA'), findsOneWidget);
    // No resume action — reopening a spent link is exactly what dead-ends.
    expect(find.text('Not yet — take me back'), findsNothing);
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
