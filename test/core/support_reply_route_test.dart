import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// A "support replied" push must open the TICKET.
///
/// Until 2026-11-10 it carried type "account" and resolved to the profile
/// screen: the customer was told support had answered and was then shown their
/// account details, which reads as a broken app at the moment they are already
/// waiting on help.
void main() {
  group('support reply deep link', () {
    test('opens the ticket when the push names one', () {
      final t = NotificationRouteResolver.resolve('support', {
        'event_type': 'support_reply',
        'ticket_number': 'LVS-ABC12345',
      });
      expect(t, isNotNull);
      expect(t!.route, AppRoutes.supportTickets);
      expect(t.arguments, 'LVS-ABC12345');
    });

    test('falls back to account_number, which older servers set instead', () {
      final t = NotificationRouteResolver.resolve('support', {
        'event_type': 'support_reply',
        'account_number': 'LVS-OLD00001',
      });
      expect(t!.arguments, 'LVS-OLD00001');
    });

    test('lands on the list when no ticket is named', () {
      final t = NotificationRouteResolver.resolve('support', {
        'event_type': 'support_reply',
      });
      expect(t, isNotNull);
      expect(t!.route, AppRoutes.supportTickets);
      expect(t.arguments, isNull);
    });

    test('an older push typed "account" still reaches support', () {
      // Server builds already in the field send type "account" with this
      // event_type. They must not open the profile screen.
      final t = NotificationRouteResolver.resolve('account', {
        'event_type': 'support_reply',
        'account_number': 'LVS-LEGACY01',
      });
      expect(t!.route, AppRoutes.supportTickets,
          reason: 'a support reply must never resolve to the account screen');
    });

    test('an ordinary account push is unaffected', () {
      final t = NotificationRouteResolver.resolve('account', {
        'event_type': 'created',
      });
      expect(t!.route, AppRoutes.myAccount);
    });

    test('the target requires auth, so a logged-out tap is replayed', () {
      final t = NotificationRouteResolver.resolve('support', {
        'event_type': 'support_reply',
        'ticket_number': 'LVS-ABC12345',
      });
      expect(t!.requiresAuth, isTrue);
    });
  });
}
