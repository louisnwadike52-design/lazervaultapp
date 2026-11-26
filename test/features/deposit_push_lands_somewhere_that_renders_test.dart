import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// THE DEPOSIT PUSH THAT LANDED ON A DEAD PAGE.
///
/// Reported on build 543: tapping a deposit notification opened a "Deposit"
/// screen that showed "Something went wrong — We couldn't load transactions
/// just now", with a Retry that could not help.
///
/// The shape that does it is `type=payment`, `entity_type=deposit`, and NO
/// transaction id — notifications-service's generic payment event. It narrows
/// correctly to the deposit service, finds no id, and falls through to
/// `_history`, which routed to ServiceTransactionHistoryScreen. That screen
/// must FETCH before it renders, and on a cold start from a push there is no
/// active account yet — the dashboard carousel selects one and a deep link
/// never passes it — so the fetch refuses and the page is dead on arrival.
///
/// The deposit-specific branch in resolver_money.dart had been fixed for
/// exactly this and `_history` — the path every other money service falls
/// through — had not. The dashboard ledger paints from cache before it asks
/// the network, so it renders either way.
void main() {
  NotificationTarget? resolve(Map<String, String> data) {
    final type = data.remove('type')!;
    return NotificationRouteResolver.resolve(type, data);
  }

  test('a deposit push with no id lands on a page that renders', () {
    final t = resolve({
      'type': 'payment',
      'entity_type': 'deposit',
      'title': 'Money in',
    });
    expect(t, isNotNull);
    expect(t!.route, AppRoutes.dashboardTransactionHistory,
        reason: 'the per-service history must FETCH before it renders, and a '
            'cold-start deep link has no active account — that is the dead '
            'page this reproduces');
  });

  test('the same is true for every other money service', () {
    // _history is the shared fallback. Whatever narrowed, an id-less push
    // must not land somewhere that has to succeed first.
    for (final entity in ['withdrawal', 'refund', 'reversal', 'exchange']) {
      final t = resolve({'type': 'payment', 'entity_type': entity});
      expect(t?.route, AppRoutes.dashboardTransactionHistory,
          reason: '$entity with no id still lands on a fetch-first page');
    }
  });

  test('an id still goes to the precise record, not the list', () {
    // The downgrade is ONLY for the id-less case. A push that names a
    // transaction must still open it — that is the whole point of the deep
    // link, and this must not regress into always showing a list.
    final t = resolve({
      'type': 'payment',
      'entity_type': 'deposit',
      'entity_id': 'txn-abc-123',
    });
    expect(t?.route, AppRoutes.transactionDeepLink,
        reason: 'a named record must open that record');
  });

  test('a deposit deep link still requires authentication', () {
    // A push tap must never walk past the passcode gate. requiresAuth
    // defaults true and the navigator refuses to push until the session and
    // the token are both ready.
    final t = resolve({'type': 'payment', 'entity_type': 'deposit'});
    expect(t?.requiresAuth, isTrue,
        reason:
            'a money screen reached from a notification must wait for auth');
  });
}
