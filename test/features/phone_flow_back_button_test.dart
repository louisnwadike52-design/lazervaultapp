import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';

/// A BACK ARROW THAT DOES NOTHING IS WORSE THAN NO BACK ARROW.
///
/// Reported from "Create a passcode": the arrow was there and tapping it did
/// nothing. The cause was a hardcoded `showBack = true` default taken by six
/// screens in this flow, several of which are entered where there is nothing
/// to pop:
///
///   phone_entry → Get.offNamed(passcodeCreate)   stack REPLACED  (SMS off)
///   main.dart boot → initialRoute = passcodeCreate   stack EMPTY
///   phone_otp   → Get.toNamed(passcodeCreate)    stack PUSHED    (SMS on)
///
/// The same screen can and cannot go back depending on how it was entered, so
/// no screen can answer this with a constant — the scaffold has to ask the
/// navigator. These pin that it does.
Future<void> _pump(WidgetTester tester, Widget home, {List<Widget>? pushTo}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(home: home),
    ),
  );
  await tester.pumpAndSettle();
}

PhoneFlowScaffold _scaffold({bool? showBack, VoidCallback? onBack}) =>
    PhoneFlowScaffold(
      title: 'Create a passcode',
      subtitle: 'Set a 6-digit passcode',
      showBack: showBack,
      onBack: onBack,
      children: const [SizedBox.shrink()],
    );

void main() {
  testWidgets('ROOT route: no arrow, because there is nothing to pop',
      (tester) async {
    // The boot-resume and Get.offNamed cases — the reported bug.
    await _pump(tester, _scaffold());
    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });

  testWidgets('PUSHED route: the arrow is shown and pops', (tester) async {
    await _pump(
      tester,
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => _scaffold()),
              ),
              child: const Text('go'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.text('Create a passcode'), findsOneWidget);
  });

  testWidgets('a custom onBack counts as working, even at the root',
      (tester) async {
    // The phone step clears the whole route rather than popping, so it has a
    // real back even on an empty stack.
    var tapped = false;
    await _pump(tester, _scaffold(onBack: () => tapped = true));

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });

  testWidgets('an explicit false still wins — security gates hide it',
      (tester) async {
    // login_otp_screen is a step-up gate: it COULD pop and must not.
    await _pump(
      tester,
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => _scaffold(showBack: false, onBack: () {}),
                ),
              ),
              child: const Text('go'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });

  testWidgets('the header keeps its height so the layout does not jump',
      (tester) async {
    // Hidden means an empty spacer, not a collapsed top bar — otherwise the
    // title shifts up between consecutive steps of the same flow.
    await _pump(tester, _scaffold());
    final withoutBack = tester.getTopLeft(find.text('Create a passcode')).dy;

    await _pump(tester, _scaffold(onBack: () {}));
    final withBack = tester.getTopLeft(find.text('Create a passcode')).dy;

    expect(withoutBack, withBack,
        reason: 'the title must sit at the same height either way');
  });
}
