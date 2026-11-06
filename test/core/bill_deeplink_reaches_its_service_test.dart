import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// A tapped bill notification must reach the service it was about.
///
/// notifications-service sends every bill as `type: "bill"`. It already knew
/// which service it was — event.BillType picks the copy — but did not put it
/// in the push, so the app had only biller_name to go on. It string-matched
/// "electric", "dstv" and "water" and dropped EVERYTHING ELSE on the generic
/// Bills hub: airtime, data, betting, education, internet, e-PIN and
/// airtime-to-cash all landed somewhere the user then had to navigate out of.
void main() {
  _paymentNarrowing();
  Map<String, String> push(String billType, {String biller = 'Some Biller'}) =>
      {'bill_type': billType, 'biller_name': biller, 'reference': 'BILL-1'};

  group('every bill type reaches its own service', () {
    const expected = <String, String>{
      'airtime': AppRoutes.airtimeHistory,
      'intl_airtime': AppRoutes.airtimeHistory,
      'data': AppRoutes.dataBundlesHistory,
      'intl_data': AppRoutes.dataBundlesHistory,
      'cable_tv': AppRoutes.cableTVHistory,
      'electric': AppRoutes.electricityBillHistory,
      'electricity': AppRoutes.electricityBillHistory,
      'water': AppRoutes.waterBillHistory,
      'internet': AppRoutes.internetBillHistory,
      'education': AppRoutes.educationHistory,
      'betting': AppRoutes.bettingHistory,
      'epin': AppRoutes.epinOrders,
      'airtime_to_cash': AppRoutes.airtimeToCash,
    };

    expected.forEach((billType, route) {
      test(billType, () {
        final t = NotificationRouteResolver.resolve('bill', push(billType));
        expect(t, isNotNull, reason: '$billType has no destination at all');
        expect(t!.route, route,
            reason: '$billType still lands on ${t.route} instead of its own '
                'service — the user has to navigate out of where the tap put '
                'them');
      });
    });

    test('none of them fall through to the generic hub', () {
      for (final billType in expected.keys) {
        final t = NotificationRouteResolver.resolve('bill', push(billType));
        expect(t?.route, isNot(AppRoutes.billsHub), reason: billType);
      }
    });
  });

  group('older payloads still work', () {
    // A push minted before bill_type shipped carries only the biller name.
    test('biller name still reaches electricity', () {
      final t = NotificationRouteResolver.resolve(
          'bill', {'biller_name': 'Ikeja Electric'});
      expect(t?.route, AppRoutes.electricityBillHistory);
    });
    test('biller name still reaches cable', () {
      final t =
          NotificationRouteResolver.resolve('bill', {'biller_name': 'DSTV'});
      expect(t?.route, AppRoutes.cableTVHistory);
    });
    test('an unknown bill with no type still reaches the hub', () {
      // The hub remains the honest landing when nothing identifies the
      // service — better than a wrong service page.
      final t = NotificationRouteResolver.resolve(
          'bill', {'biller_name': 'Something New'});
      expect(t?.route, AppRoutes.billsHub);
    });
  });

  group('the type match is robust to spelling', () {
    test('separators and case do not matter', () {
      for (final v in ['CABLE_TV', 'cable-tv', 'Cable Tv', 'cabletv']) {
        expect(NotificationRouteResolver.resolve('bill', push(v))?.route,
            AppRoutes.cableTVHistory,
            reason: v);
      }
    });
    test('an unrecognised bill_type falls back rather than dead-ending', () {
      final t = NotificationRouteResolver.resolve(
          'bill', {'bill_type': 'something_new', 'biller_name': 'DSTV'});
      expect(t?.route, AppRoutes.cableTVHistory,
          reason: 'an unknown type must fall through to the name heuristic, '
              'not short-circuit to the hub');
    });
  });
}

/// The `payment` catch-all passed NO service type, and a null service type is
/// exactly what makes TransactionDeepLinkScreen fall back to the ALL-SERVICES
/// history. So any tap whose record could not be loaded — offline, a lookup
/// past its six-second budget, a reference the ledger search misses — landed
/// on the generic list, leaving the user to find the thing the notification
/// was already about. entity_type was in the payload all along.
void _paymentNarrowing() {
  group('a generic payment narrows to its service', () {
    const cases = <String, TransactionServiceType>{
      'transfer': TransactionServiceType.transfer,
      'deposit': TransactionServiceType.deposit,
      'withdrawal': TransactionServiceType.withdrawal,
      'exchange': TransactionServiceType.exchange,
      'refund': TransactionServiceType.refund,
      'reversal': TransactionServiceType.reversal,
    };
    cases.forEach((entity, want) {
      test(entity, () {
        final t = NotificationRouteResolver.resolve('payment', {
          'entity_type': entity,
          'entity_id': '11111111-1111-1111-1111-111111111111',
          'reference': 'REF-1',
        });
        expect(t, isNotNull);
        final args = t!.arguments as Map;
        expect(args['serviceType'], want,
            reason: 'no service type means the loader falls back to the '
                'all-services history, which is the reported problem');
      });
    });

    test('an unknown entity_type still reaches the record', () {
      // Honest fallback: a guessed service page is worse than a list that
      // definitely contains the record.
      final t = NotificationRouteResolver.resolve('payment', {
        'entity_type': 'something_new',
        'reference': 'REF-1',
      });
      expect(t, isNotNull);
      expect(t!.route, AppRoutes.transactionDeepLink);
    });

    test('a card payment still goes to the account', () {
      final t = NotificationRouteResolver.resolve(
          'payment', {'payment_method': 'card', 'reference': 'R'});
      expect(t?.route, AppRoutes.myAccount);
    });
  });
}
