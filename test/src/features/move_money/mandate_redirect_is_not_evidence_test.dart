import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/directpay_authorization_sheet.dart';

// Chris could not finish Direct Debit on ALAT by WEMA for months. Mono's
// mandate redirect is a bare `lazervault://mandate/callback` with NO status
// parameter, so the webview sheet fell through to "default to success" and
// reported an authorization that never happened. That stamped an auth attempt,
// which armed the 40-minute spent-link guard, which then answered every retry
// with "no need to authorize again" — locking him out of the only screen that
// could complete the setup. Mono said `approved: false, ready_to_debit: false`
// the whole time (verified live against the mandate on 2026-10-02).

void main() {
  group('a result carries whether it is evidence', () {
    test('unverified is neither success nor failure', () {
      final r = DirectPayAuthResult.unverified(paymentId: 'p1');
      expect(r.unverified, isTrue);
      expect(r.success, isFalse,
          reason: 'must never be treated as an authorization');
      expect(r.errorMessage, isNull,
          reason: 'not an error either — the user did nothing wrong');
      expect(r.paymentId, 'p1');
    });

    test('ordinary results are not unverified', () {
      expect(DirectPayAuthResult.success().unverified, isFalse);
      expect(DirectPayAuthResult.failed('x').unverified, isFalse);
      expect(DirectPayAuthResult.cancelled().unverified, isFalse);
    });

    test('success still means success', () {
      final r = DirectPayAuthResult.success(paymentId: 'p', reference: 'r');
      expect(r.success, isTrue);
      expect(r.unverified, isFalse);
    });
  });

  group('popping only ever closes the sheet that is popping', () {
    // The black screen: the app is killed while the user is in their bank app,
    // relaunches onto the login screen, and the sheet's deferred close (a
    // 2-second debounce) then pops THAT route instead of its own. `mounted` is
    // no protection — a State stays mounted while its route is buried.
    testWidgets('a buried route is removed, never popped', (tester) async {
      final navKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navKey,
        home: const Scaffold(body: Text('home')),
      ));

      // A route standing in for the sheet.
      navKey.currentState!.push(MaterialPageRoute<String>(
          builder: (_) => const Scaffold(body: Text('sheet'))));
      await tester.pumpAndSettle();

      // Something else lands on top (the relaunched login screen).
      navKey.currentState!.push(MaterialPageRoute<void>(
          builder: (_) => const Scaffold(body: Text('login'))));
      await tester.pumpAndSettle();
      expect(find.text('login'), findsOneWidget);

      // This is what a bare Navigator.pop() would have done.
      navKey.currentState!.pop();
      await tester.pumpAndSettle();
      expect(find.text('login'), findsNothing,
          reason: 'a bare pop closes the WRONG route — the bug being fixed');
      expect(find.text('sheet'), findsOneWidget);
    });

    testWidgets('removeRoute retires a buried route and leaves the top alone',
        (tester) async {
      final navKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navKey,
        home: const Scaffold(body: Text('home')),
      ));

      final sheetRoute = MaterialPageRoute<String>(
          builder: (_) => const Scaffold(body: Text('sheet')));
      navKey.currentState!.push(sheetRoute);
      await tester.pumpAndSettle();
      navKey.currentState!.push(MaterialPageRoute<void>(
          builder: (_) => const Scaffold(body: Text('login'))));
      await tester.pumpAndSettle();

      expect(sheetRoute.isCurrent, isFalse, reason: 'it is buried');

      // What _popSelf does instead.
      navKey.currentState!.removeRoute(sheetRoute);
      await tester.pumpAndSettle();

      expect(find.text('login'), findsOneWidget,
          reason: 'the top route is untouched');
      // And the stack can still unwind normally — no black screen.
      navKey.currentState!.pop();
      await tester.pumpAndSettle();
      expect(find.text('home'), findsOneWidget);
    });
  });
}
