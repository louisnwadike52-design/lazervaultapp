import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/widgets/nfc_positioning_guide.dart';

// NFC couples over roughly two centimetres, between antennas neither person can
// see. Held wrong, the tap does nothing at all — no error, no feedback — and
// both people conclude the feature is broken rather than that their phones are
// a few centimetres apart. The instruction is therefore load-bearing, not
// decoration.

Future<void> pump(WidgetTester tester, {required bool isPayer}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(body: NfcPositioningGuide(isPayer: isPayer)),
      ),
    ),
  );
  await tester.pump();
}

String textOf(WidgetTester tester) => tester
    .widgetList<Text>(find.byType(Text))
    .map((t) => t.data ?? '')
    .join(' ');

void main() {
  testWidgets('the payer is told to move their phone to the other one',
      (tester) async {
    await pump(tester, isPayer: true);
    expect(find.text('Hold your phone to theirs'), findsOneWidget);
  });

  testWidgets('the payee is told to hold still', (tester) async {
    // Both moving at once is how a tap gets missed; only one side should move.
    await pump(tester, isPayer: false);
    final body = textOf(tester).toLowerCase();
    expect(body, contains('steady'));
  });

  testWidgets('both roles name WHICH part of the phone must meet',
      (tester) async {
    // "Hold them near each other" is the advice that fails: the antenna is in
    // the upper back on Android and the top edge on iPhone, so a vague
    // instruction leaves people touching the wrong halves together.
    for (final payer in [true, false]) {
      await pump(tester, isPayer: payer);
      final body = textOf(tester).toLowerCase();
      expect(
        body.contains('back') || body.contains('top edge'),
        isTrue,
        reason: 'isPayer=$payer copy must say which part of the phone to use',
      );
    }
  });

  testWidgets('it renders without a platform channel', (tester) async {
    // Platform.isIOS throws on unsupported hosts; the guide must degrade to
    // sensible copy rather than taking the payment screen down with it.
    await pump(tester, isPayer: true);
    expect(tester.takeException(), isNull);
  });
}
