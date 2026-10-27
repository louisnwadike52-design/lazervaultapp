// The dashboard balance rolls, and what it rolls THROUGH is the whole point.
//
// Three properties are load-bearing and each was reachable as a bug:
//   * a change that lands mid-roll RETARGETS, it does not queue — otherwise
//     three WebSocket credits in a second are replayed in order and the
//     counter counts through figures the account has already left;
//   * a card whose account changes SNAPS — rolling from one account's figure
//     to another's reads as the balance being wrong;
//   * the panic/decoy balance SNAPS, with no roll, no pulse and no sound —
//     a roll from the real balance to the decoy would count through (and so
//     leak) the real one to whoever is watching.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

import 'package:lazervault/src/features/account_cards_summary/presentation/widgets/animated_balance_counter.dart';

const _base = Color(0xFFFFFFFF);
const _green = Colors.greenAccent;
const _red = Color(0xFFFF6B6B);

/// The colour the row is painted in — the only outward sign of the private
/// `_isAnimating` flag (green rolling up, red rolling down, base at rest).
Color _rowColour(WidgetTester tester) =>
    (tester.widget<Text>(find.text('NGN')).style!.color)!;

num _counterValue(WidgetTester tester) =>
    tester.widget<AnimatedFlipCounter>(find.byType(AnimatedFlipCounter)).value;

Future<void> _show(
  WidgetTester tester, {
  required double balance,
  required bool animate,
  String identity = 'acct-1',
  Duration startDelay = Duration.zero,
}) async {
  // Phone-sized surface at 1:1 so ScreenUtil's 414x896 design scale is 1.0;
  // the default 800x600 surface scales `.sp` ~1.9x and a seven-figure balance
  // then overflows the Row.
  tester.view.physicalSize = const Size(414, 896);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: CompactAnimatedBalance(
            identity: identity,
            balance: balance,
            currencySymbol: 'NGN',
            fontSize: 14,
            color: _base,
            animate: animate,
            startDelay: startDelay,
            duration: const Duration(seconds: 2),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('a change mid-roll retargets instead of queueing behind it',
      (tester) async {
    await _show(tester, balance: 100, animate: true);
    expect(_counterValue(tester), 100);

    await _show(tester, balance: 200, animate: true);
    // The zero-delay start timer needs the fake clock to move at all.
    await tester.pump(const Duration(milliseconds: 1));
    expect(_counterValue(tester), 200);
    expect(_rowColour(tester), _green);

    // Half a second into that roll, a credit lands.
    await tester.pump(const Duration(milliseconds: 500));
    await _show(tester, balance: 300, animate: true);
    await tester.pump(const Duration(milliseconds: 1));
    expect(_counterValue(tester), 300,
        reason: 'the roll retargets from where it is to the newest value');

    await tester.pump(const Duration(seconds: 3));
    expect(_rowColour(tester), _base, reason: 'one roll, one end');
  });

  testWidgets('a card handed a DIFFERENT account snaps to its figure',
      (tester) async {
    await _show(tester, balance: 100, animate: true, identity: 'acct-1');
    await _show(tester, balance: 9000, animate: true, identity: 'acct-2');
    await tester.pump(const Duration(milliseconds: 1));
    expect(_counterValue(tester), 9000);
    expect(_rowColour(tester), _base,
        reason: 'a different account is not a balance CHANGE — no roll');
  });

  testWidgets(
      'the decoy snaps, and a roll pending when panic engaged is '
      'abandoned', (tester) async {
    // A real credit, with the start delay still running…
    await _show(tester,
        balance: 100,
        animate: true,
        startDelay: const Duration(milliseconds: 500));
    await _show(tester,
        balance: 200,
        animate: true,
        startDelay: const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 100));
    expect(_counterValue(tester), 100, reason: 'still inside the start delay');

    // …and panic engages before it fires: the decoy must appear AT ONCE.
    await _show(tester,
        balance: 50,
        animate: false,
        startDelay: const Duration(milliseconds: 500));
    expect(_counterValue(tester), 50);
    expect(_rowColour(tester), _base);

    // Past when that pending roll would have fired. It must not fire at all:
    // it would flip the direction colour (and pulse, and on what it reads as
    // a credit play the money sound) over a figure that is camouflage.
    await tester.pump(const Duration(seconds: 1));
    expect(_counterValue(tester), 50);
    expect(_rowColour(tester), _base,
        reason: 'the abandoned roll must not animate over the decoy');
    expect(_rowColour(tester), isNot(_green));
    expect(_rowColour(tester), isNot(_red));
  });

  testWidgets('a decoy change never rolls through the real balance',
      (tester) async {
    await _show(tester, balance: 1250000, animate: false);
    await _show(tester, balance: 50, animate: false);
    // No pump needed: the snap is synchronous, and the flip counter is handed
    // a zero duration so it cannot tween between the two.
    expect(_counterValue(tester), 50);
    final counter =
        tester.widget<AnimatedFlipCounter>(find.byType(AnimatedFlipCounter));
    expect(counter.duration, Duration.zero);
  });

  testWidgets('disposing mid-roll cancels cleanly', (tester) async {
    await _show(tester, balance: 100, animate: true);
    await _show(tester, balance: 200, animate: true);
    await tester.pump(const Duration(milliseconds: 200)); // mid-tween
    await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
    // Past both the roll duration and the end timer: a timer that outlived
    // dispose would fail the test here.
    await tester.pump(const Duration(seconds: 3));
    expect(tester.takeException(), isNull);
  });
}
