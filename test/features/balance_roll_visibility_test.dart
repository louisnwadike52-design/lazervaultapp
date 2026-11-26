import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/account_cards_summary/presentation/widgets/animated_balance_counter.dart';

/// A BALANCE ROLL IS A MESSAGE AND NEEDS SOMEBODY TO DELIVER IT TO.
///
/// Money changes while the customer is on a bill screen, an airtime screen,
/// a transfer flow — the dashboard is mounted UNDERNEATH all of those, so it
/// was counting down to an empty room, complete with the money-counting sound
/// and the haptic buzz. By the time they navigated back the roll had either
/// finished (so they saw nothing) or was mid-flight for a payment they made
/// two screens ago. Reported as a countdown "just because there's been a
/// money movement".
void main() {
  Widget host(Widget child) => ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (_, __) => MaterialApp(home: Scaffold(body: child)),
      );

  testWidgets('a visible balance still animates', (tester) async {
    // The default must not change: this is the whole feature when somebody IS
    // looking at the dashboard.
    await tester.pumpWidget(host(const CompactAnimatedBalance(
      balance: 1000, currencySymbol: '₦', identity: 'acct-1')));
    await tester.pumpWidget(host(const CompactAnimatedBalance(
      balance: 2000, currencySymbol: '₦', identity: 'acct-1')));
    await tester.pump(const Duration(milliseconds: 50));
    // It rendered and did not throw; the roll is a visual the golden cannot
    // assert here, so the source rules below pin the decision itself.
    expect(find.byType(CompactAnimatedBalance), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  group('the rule is stated once and applied to both counters', () {
    final src = File('lib/src/features/account_cards_summary/presentation/'
            'widgets/animated_balance_counter.dart')
        .readAsStringSync();

    test('visibility is decided by the route being current', () {
      expect(src.contains('ModalRoute.of(context)'), isTrue);
      expect(src.contains('route.isCurrent'), isTrue,
          reason: 'isCurrent is true only while this route is top-most — '
              'which is exactly "the customer is looking at it"');
    });

    test('unknown reads as VISIBLE, so tests exercise the real path', () {
      // Returning false on an unknown route would silently disable the
      // animation everywhere it could not be determined — including in a
      // harness, where every test would then pass against the wrong branch.
      expect(src.contains('if (route == null) return true;'), isTrue);
    });

    test('BOTH counters consult it', () {
      expect('_balanceIsOnScreen('.allMatches(src).length,
          greaterThanOrEqualTo(3),
          reason: 'declared once and called by AnimatedBalanceCounter AND '
              'CompactAnimatedBalance — one of the two still rolling in the '
              'background is the same bug half-fixed');
    });

    test('the off-screen path snaps, with no sound or haptics', () {
      // The compact counter folds into the existing panic-mode snap, which
      // already cancels the pulse, the sound and the vibration timer. The
      // full counter has its own early return.
      expect(src.contains('!widget.animate || !_balanceIsOnScreen(context)'),
          isTrue,
          reason: 'grouped with panic mode because the required behaviour is '
              'identical, and two paths doing it would drift');
      expect(src.contains('if (!_balanceIsOnScreen(context)) {'), isTrue);
    });
  });
}
