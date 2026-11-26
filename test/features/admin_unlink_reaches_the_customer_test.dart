import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// AN ADMIN UNLINK HAS TO LAND SOMEWHERE THE CUSTOMER CAN ACT.
///
/// banking-service queues a push and an in-app notice when an operator
/// disconnects a connected bank. A notice whose tap goes nowhere is the
/// support ticket it was meant to prevent — and the only action either of
/// these messages implies is "reconnect", which lives on exactly one screen.
///
/// Two shapes are matched because the two notices were written years apart:
/// the newer one publishes a notification TYPE, and the re-authorisation
/// notice that predates it carries only an `action` in its data.
void main() {
  test('the unlink notice opens the linked banks screen', () {
    final t = NotificationRouteResolver.resolve('linked_account_unlinked', {
      'linked_account_id': 'la-1',
      'bank_name': 'GTBank',
      'action': 'linked_accounts',
    });
    expect(t?.route, AppRoutes.linkedBanks);
    expect(t?.requiresAuth, isTrue,
        reason: 'it names the customer\'s own banks');
  });

  test('the older re-authorisation notice lands there too', () {
    final t = NotificationRouteResolver.resolve(
      'account_reauthorization_required',
      {'linked_account_id': 'la-2', 'action': 'reauthorize'},
    );
    expect(t?.route, AppRoutes.linkedBanks);
  });

  test('the action alone is enough', () {
    // The payload shape the outbox has always sent, under a type this build
    // may not know. Landing on the right screen beats falling through to the
    // feed for a message whose whole point is one tap.
    final t = NotificationRouteResolver.resolve('banking', {
      'action': 'linked_accounts',
    });
    expect(t?.route, AppRoutes.linkedBanks);
  });

  test('an unrelated banking notice is not hijacked', () {
    final t = NotificationRouteResolver.resolve('security', {
      'event_type': '2fa.enabled',
    });
    expect(t?.route, isNot(AppRoutes.linkedBanks),
        reason: 'the match must be on the linked-account shapes, not on '
            'anything that mentions an account');
  });
}
