import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE SERVICE LAYER EXISTED AND NOTHING COULD REACH IT.
///
/// ListEventAttendees, RequestTicketRefund and TransferTicket were written,
/// tested and dead: no proto, no handler, no gateway route, no Dart, no screen.
/// The door counts had the same shape — GetEventEarnings computed
/// tickets_issued / tickets_admitted and the organiser saw an order count.
///
/// Source assertions, because reproducing any of this needs the DI graph plus
/// a live gRPC channel. Each one is the link whose absence makes the chain
/// silently incomplete rather than failing to build:
///
///   * a missing PROXY FIELD is dropped silently, not a compile error;
///   * a missing ROUTE is a 404 at runtime;
///   * a missing CAPABILITY FLAG hides a button for every user whatever the
///     operator switched on.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  const repoRoot = '..';
  const svcProto = '$repoRoot/microservices/financial-products-service/'
      'financial-products-microservice/proto/ticketing.proto';
  const gwProto = '$repoRoot/services/products-gateway/proto/ticketing.proto';
  const gwProxy = '$repoRoot/services/products-gateway/'
      'internal/proxy/ticketing_proxy.go';
  const handler = '$repoRoot/microservices/financial-products-service/'
      'financial-products-microservice/internal/handler/ticketing_handler.go';
  const dartRepo = 'lib/src/features/ticketing/data/ticketing_repository.dart';

  group('the three RPCs reach the app', () {
    for (final rpc in [
      'ListEventAttendees',
      'RequestTicketRefund',
      'TransferTicket',
    ]) {
      test('$rpc is declared on BOTH protos', () {
        for (final p in [svcProto, gwProto]) {
          expect(read(p).contains('rpc $rpc('), isTrue,
              reason: '$rpc is missing from $p. The two copies are maintained '
                  'BY HAND and a method in only one of them is a runtime '
                  'Unimplemented, not a build failure.');
        }
      });

      test('$rpc has a handler and a proxy', () {
        expect(code(read(handler)).contains(') $rpc('), isTrue,
            reason: 'the service method is unreachable without a handler');
        expect(code(read(gwProxy)).contains(') $rpc('), isTrue,
            reason: 'the gateway has no proxy for $rpc, so the app\'s call '
                'reaches an unimplemented method');
      });
    }

    test('the attendee list is routed and gated', () {
      final routes = code(read('lib/core/types/app_routes.dart'));
      expect(routes.contains('ticketingAttendees'), isTrue);
      // A static segment under a param route gets eaten — this file's own
      // note records it, and '/events/:eventId' would swallow it.
      expect(routes.contains("'/events-attendees/:eventId'"), isTrue,
          reason: 'the attendees path sits under /events/:eventId again, '
              'where the param route eats it');
      expect(
          code(read('lib/core/types/route_service_map.dart'))
              .contains('ticketingAttendees'),
          isTrue,
          reason: 'without the service map a deep link bypasses the gate');
      expect(
          code(read('lib/src/features/presentation/app_router.dart'))
              .contains('AppRoutes.ticketingAttendees'),
          isTrue,
          reason: 'the route is declared but no page is registered for it');
    });

    test('the Dart repository exposes all three', () {
      final src = code(read(dartRepo));
      for (final m in ['attendees(', 'requestRefund(', 'transferTicket(']) {
        expect(src.contains(m), isTrue,
            reason: '$m is missing, so no screen can call it');
      }
    });
  });

  group('the door counts are not the order count', () {
    test('both protos carry tickets_issued and tickets_admitted', () {
      for (final p in [svcProto, gwProto]) {
        final src = read(p);
        expect(src.contains('int32 tickets_issued'), isTrue, reason: p);
        expect(src.contains('int32 tickets_admitted'), isTrue, reason: p);
      }
    });

    test('the proxy copies them', () {
      final src = code(read(gwProxy));
      // A drifted or omitted field number is SILENTLY DROPPED here, which
      // would make the organiser's "87 of 240 in" read zero — as if nobody
      // came.
      expect(src.contains('TicketsIssued:   resp.GetTicketsIssued()'), isTrue);
      expect(
          src.contains('TicketsAdmitted: resp.GetTicketsAdmitted()'), isTrue);
    });

    test('the organiser screen shows admissions, not orders', () {
      final src = code(read(
          'lib/src/features/ticketing/presentation/screens/organiser_event_screen.dart'));
      expect(src.contains('e.ticketsIssued'), isTrue,
          reason: 'the door card is back to ticketsSold, which is an ORDER '
              'count — an organiser reading "60 sold" against 240 humans has '
              'been told the wrong thing');
      expect(src.contains("'\$admitted of \$issued in'"), isTrue);
    });
  });

  group('the two switches reach the buyer', () {
    test('the capability flags are on both protos', () {
      for (final p in [svcProto, gwProto]) {
        final src = read(p);
        expect(src.contains('bool refunds_enabled'), isTrue, reason: p);
        expect(src.contains('bool transfers_enabled'), isTrue, reason: p);
      }
    });

    test('the proxy copies them', () {
      final src = code(read(gwProxy));
      expect(src.contains('RefundsEnabled:    resp.GetRefundsEnabled()'),
          isTrue,
          reason: 'dropped here, both buttons are hidden for every buyer '
              'whatever the operator switched on — a silent zero that looks '
              'like the feature was never built');
      expect(src.contains('TransfersEnabled:  resp.GetTransfersEnabled()'),
          isTrue);
    });

    test('the app defaults them OFF, like the service', () {
      final src = code(read(
          'lib/src/features/ticketing/presentation/cubit/ticketing_state.dart'));
      expect(src.contains('this.refundsEnabled = false'), isTrue,
          reason: 'a response that could not be read must not show buttons');
      expect(src.contains('this.transfersEnabled = false'), isTrue);
    });

    test('the actions refuse a used, cancelled or past ticket', () {
      final src = code(read(
          'lib/src/features/ticketing/presentation/widgets/ticket_actions.dart'));
      expect(src.contains('if (_used || _cancelled || _past)'), isTrue,
          reason: 'offering a refund on a cancelled event races the automatic '
              'sweep, and offering one on a used ticket asks for money back '
              'for an event the holder attended');
    });

    test('a refund names the whole ORDER, not one ticket', () {
      final src = code(read(
          'lib/src/features/ticketing/presentation/widgets/ticket_actions.dart'));
      expect(src.contains('sameOrderCount > 1'), isTrue,
          reason: '"Refund this ticket" on a four-ticket order is a sentence '
              'that misleads about what is about to happen');
    });

    test('a partial refund says what was kept', () {
      final src = code(read(
          'lib/src/features/ticketing/presentation/screens/my_tickets_screen.dart'));
      expect(src.contains('state.isPartial'), isTrue,
          reason: 'a buyer who paid 5,200 and got 5,000 back must be told why '
              'here, not left to find it on a statement');
      expect(src.contains('r.feeKeptMinor'), isTrue);
    });
  });
}
