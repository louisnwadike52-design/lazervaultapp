import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Where a SUPPORT DESK push lands, and why the ordering is load-bearing.
///
/// `_is(type, prefix)` matches an underscore suffix, so `_is('support_desk',
/// 'support')` is true. If the desk branch were placed after the customer
/// support branch, every desk notification would open the AGENT's own ticket
/// list — a screen that is usually empty — while the customer who messaged sat
/// in a queue nobody opened. Nothing in the build catches that: both routes
/// exist, both resolve, and the push arrives either way.
void main() {
  test('a desk push opens the DESK, not the agent\'s own tickets', () {
    final t = NotificationRouteResolver.resolve('support_desk', {
      'event_type': 'support_desk',
      'entity_id': 'd290f1ee-6c54-4b01-90e6-d701748f0851',
      'ticket_number': 'LV-10421',
    });

    expect(t, isNotNull);
    expect(t!.route, AppRoutes.supportDesk,
        reason: 'a desk push resolved to ${t.route}; an agent would be shown '
            'their own tickets while a customer waited');
    expect(t.route, isNot(AppRoutes.supportTickets));
  });

  test('the ticket ID is what the desk opens, not the ticket number', () {
    final t = NotificationRouteResolver.resolve('support_desk', {
      'entity_id': 'd290f1ee-6c54-4b01-90e6-d701748f0851',
      'ticket_number': 'LV-10421',
    });
    expect(t!.arguments, 'd290f1ee-6c54-4b01-90e6-d701748f0851',
        reason: 'the desk fetches by id; handed a display number it would ask '
            'the server for a record that cannot exist');
  });

  test('a desk push with no id still lands on the queue', () {
    final t = NotificationRouteResolver.resolve(
        'support_desk', {'ticket_number': 'LV-10421'});
    expect(t, isNotNull);
    expect(t!.route, AppRoutes.supportDesk);
    // No argument: the queue, where the ticket is the top row.
    expect(t.arguments, isNull);
  });

  test('a composite id is not treated as a ticket id', () {
    // Payloads have carried dedup suffixes appended to ids. Opening the desk
    // with one asks for a record that does not exist and sits on a spinner.
    final t = NotificationRouteResolver.resolve('support_desk', {
      'entity_id': 'd290f1ee-6c54-4b01-90e6-d701748f0851:desk:2026-11-10',
    });
    expect(t!.route, AppRoutes.supportDesk);
    expect(t.arguments, isNull,
        reason: 'a composite key was passed through as a ticket id');
  });

  test('the CUSTOMER support reply still opens the customer ticket list', () {
    // The regression the desk branch could introduce: claiming "support" too
    // broadly and stealing the customer's own notification.
    final t = NotificationRouteResolver.resolve('support', {
      'event_type': 'support_reply',
      'ticket_number': 'LV-10422',
    });
    expect(t!.route, AppRoutes.supportTickets,
        reason: 'the desk branch swallowed a customer support reply');
    expect(t.arguments, 'LV-10422');
  });

  test('a plain support_reply event type is unaffected', () {
    final t = NotificationRouteResolver.resolve('account', {
      'event_type': 'support_reply',
      'ticket_number': 'LV-10423',
    });
    expect(t!.route, AppRoutes.supportTickets);
  });
}
