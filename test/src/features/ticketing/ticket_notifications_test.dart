import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_service_icon.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/services.dart';

/// TICKETING PUBLISHED NOTHING AT ALL.
///
/// Not under-notified — silent. Somebody gives you a ticket and it appears in
/// My tickets with no receipt to have seen and no reason to look; a refund
/// completes and money arrives unexplained; an event is cancelled, every buyer
/// is refunded automatically, and the customer is left wondering whether they
/// lost both the show and the money.
///
/// The pipeline already existed — `s.notificationProducer` is on the service
/// struct and insurance and group accounts publish through it — so this is
/// about the feature USING it, and about the app recognising what arrives.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  const svc = '../microservices/financial-products-service/'
      'financial-products-microservice/internal/service';

  group('every ticketing event that matters now notifies', () {
    test('the six types are declared', () {
      final src = read('$svc/ticket_notifications.go');
      for (final t in [
        'ticket.sold',
        'ticket.received',
        'ticket.given_away',
        'ticket.refunded',
        'ticket.event_cancelled',
        'ticket.payout',
      ]) {
        expect(src.contains('"$t"'), isTrue, reason: '$t is gone');
      }
    });

    test('each is actually called from its own flow', () {
      // A helper nothing calls is the same silence with more code in it.
      for (final pair in const [
        ['$svc/ticket_purchase.go', 'notifyTicketSold('],
        ['$svc/ticket_transfer.go', 'notifyTicketReceived('],
        ['$svc/ticket_transfer.go', 'notifyTicketGivenAway('],
        ['$svc/ticket_refund_request.go', 'notifyTicketRefunded('],
        ['$svc/ticket_cancel.go', 'notifyTicketEventCancelled('],
        ['$svc/ticket_payout.go', 'notifyTicketPayout('],
      ]) {
        expect(read(pair[0]).contains(pair[1]), isTrue,
            reason: '${pair[1]} is not called from ${pair[0]}');
      }
    });

    test('a notification can never fail a money leg', () {
      final src = read('$svc/ticket_notifications.go');
      expect(src.contains('if s.notificationProducer == nil'), isTrue,
          reason: 'an unwired producer would panic inside a completed '
              'transfer');
      expect(src.contains('go func()'), isTrue,
          reason: 'the publish is back on the caller\'s path, so a slow '
              'broker now delays a money response');
      expect(src.contains('context.Background()'), isTrue,
          reason: 'using the request context drops the only message the '
              'customer gets about money that has already moved');
    });

    test('the idempotency key is derived, not minted per send', () {
      final src = read('$svc/ticket_notifications.go');
      expect(src.contains('GenerateIdempotencyKey('), isTrue);
      expect(src.contains('GenerateUUIDIdempotencyKey('), isFalse,
          reason: 'a fresh key per send means the cancelled-event sweep — '
              'which retries the same rows by design — tells the same person '
              'over and over');
    });

    test('SMS is never used, and email only for money', () {
      final src = read('$svc/ticket_notifications.go');
      expect(src.contains('"push,email"'), isTrue);
      expect(src.contains('"push"'), isTrue);
      expect(src.contains('sms'), isFalse,
          reason: 'none of these is security-critical, each text costs money, '
              'and ticket.sold fires once per order — an organiser selling '
              '200 tickets would be sent 200 texts at our expense');
    });
  });

  group('a partial refund says what actually came back', () {
    const meta = 'lib/src/features/ticketing/utils/ticket_receipt_fields.dart';

    test('the service stamps the refunded amount and the kept fee', () {
      final src = read('$svc/ticket_receipt_metadata.go');
      expect(src.contains('"ticket_refund_amount"'), isTrue);
      expect(src.contains('"ticket_refund_fee_kept"'), isTrue);
      // Both ALWAYS, including a zero: a reader that only sometimes sees the
      // key cannot tell "nothing was kept" from "not recorded".
      expect(src.contains('func ticketRefundReceiptMetadata('), isTrue);
    });

    test('BOTH refund legs use the refund document', () {
      for (final f in [
        '$svc/ticket_refund_request.go', // buyer-initiated, may be partial
        '$svc/ticket_money.go', // cancelled-event sweep, always full
      ]) {
        expect(read(f).contains('ticketRefundReceiptMetadata('), isTrue,
            reason: '$f still stamps the PURCHASE document, whose only total '
                'is the original one');
      }
    });

    test('the receipt renders the refunded figure, not the original', () {
      final src = read(meta);
      expect(src.contains("money('Refunded', 'ticket_refund_amount')"), isTrue,
          reason: 'a buyer who paid 5,200 and received 5,000 is handed a '
              'document saying 5,200 came back');
      expect(src.contains("money('Booking fee kept', 'ticket_refund_fee_kept')"),
          isTrue,
          reason: 'the gap between the two figures must be named, or the '
              'receipt reads as a short payment');
    });

    test('a legacy receipt still renders', () {
      // Rows written before these keys existed carry neither. Falling back to
      // the original total is the rule this whole file is built on.
      final src = read(meta);
      expect(src.contains("money('Refunded', 'ticket_buyer_total')"), isTrue,
          reason: 'an old refund receipt now renders a blank amount');
    });
  });

  group('the app recognises what arrives', () {
    test('a ticket notification gets the ticket glyph, not the catch-all', () {
      for (final t in [
        'ticket.sold',
        'ticket.received',
        'ticket.given_away',
        'ticket.refunded',
        'ticket.event_cancelled',
        'ticket.payout',
      ]) {
        expect(notificationServiceFor(t).serviceName,
            AppServiceName.ticketing,
            reason: '$t falls through to the generic glyph, so the feed '
                'cannot be read at a glance');
      }
    });

    test('ticket.refunded is a TICKET, not a generic refund', () {
      // It would otherwise be filed under Send Funds by the money-movement
      // branch, losing the one thing that makes it recognisable.
      expect(notificationServiceFor('ticket.refunded').serviceName,
          AppServiceName.ticketing);
    });

    test('a buyer tap lands on My tickets', () {
      for (final t in ['ticket.received', 'ticket.given_away']) {
        final target = NotificationRouteResolver.resolve(t, const {});
        expect(target, isNotNull, reason: '$t taps nowhere');
        expect(target!.route, AppRoutes.ticketingMyTickets);
      }
    });

    test('an organiser tap lands on THAT event, not a list', () {
      final target = NotificationRouteResolver.resolve(
          'ticket.sold', const {'event_id': 'd7a1e8f2-0000-4000-8000-000000000001'});
      expect(target, isNotNull);
      expect(target!.route,
          contains('d7a1e8f2-0000-4000-8000-000000000001'),
          reason: 'the organiser is told they sold a ticket and sent to a '
              'list to go and find which event');
    });

    test('an organiser tap with no event id still lands somewhere useful', () {
      final target =
          NotificationRouteResolver.resolve('ticket.payout', const {});
      expect(target, isNotNull);
      expect(target!.route, AppRoutes.ticketingMyEvents,
          reason: 'never the public Events list — the organiser is not '
              'looking to discover an event');
    });

    test('a cancelled event opens the event, where the answer is', () {
      final target = NotificationRouteResolver.resolve(
          'ticket.event_cancelled',
          const {'event_id': 'd7a1e8f2-0000-4000-8000-000000000002'});
      expect(target, isNotNull);
      expect(target!.route, contains('d7a1e8f2-0000-4000-8000-000000000002'));
      // The money is already back — the open question is the show.
      expect(target.route, isNot(AppRoutes.ticketingMyTickets));
    });
  });
}
