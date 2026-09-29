import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/saved_recipients_rail.dart';

/// The rail card was restyled: elevation instead of a hairline border, the
/// chat action moved up beside the avatar instead of owning a full row at the
/// foot, and the card tightened (168x158 -> 150x124).
///
/// Shrinking a card that holds three lines of text is exactly how an overflow
/// gets shipped, so these render it for real — including the cases that break
/// layouts: a very long name, a missing bank, and a large accessibility text
/// scale.
RecipientModel _r({
  String name = 'Emmanuella Nwanne',
  String bank = 'Lazervault',
  String acct = '9799689751',
}) =>
    RecipientModel(
      id: 'r1',
      name: name,
      accountNumber: acct,
      bankName: bank,
      isFavorite: false,
      sortCode: '',
    );

Future<void> _pump(WidgetTester tester, List<RecipientModel> rs,
    {double textScale = 1.0}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
          child: Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: SavedRecipientsRail(
                recipients: rs,
                onTap: (_) {},
                onMore: (_) {},
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  setUp(() {
    // Any RenderFlex overflow paints an error and is recorded — fail on it.
    FlutterError.onError = (details) => FlutterError.presentError(details);
  });

  testWidgets('renders a normal recipient without overflowing', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await _pump(tester, [_r()]);
    expect(tester.takeException(), isNull);
    expect(find.text('Emmanuella Nwanne'), findsOneWidget);
  });

  testWidgets('a very long name ellipsises rather than overflowing',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await _pump(tester, [
      _r(name: 'Oluwaseunfunmi Adebayo-Oyelaran Chukwuemeka', bank: 'Guaranty Trust Bank Plc')
    ]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('survives a large accessibility text scale', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    // 1.3 is a realistic bump; the card must clip text, not blow the layout.
    await _pump(tester, [_r()], textScale: 1.3);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a recipient with no bank or account still renders',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await _pump(tester, [_r(name: 'X', bank: '', acct: '')]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('several cards scroll horizontally without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await _pump(tester, List.generate(8, (i) => _r(name: 'Recipient $i')));
    expect(tester.takeException(), isNull);
  });
}
