import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/src/features/account_actions/utils/hold_route_resolver.dart';

/// Every service that can place a reserve, taken from the actual reserve call
/// sites rather than imagined. If a service starts holding money and is not
/// listed here, its row is silently non-tappable — which is the bug this file
/// exists to make visible.
const _reservingServices = <String>[
  'financial-products-service',
  'banking-service',
  'crypto-service',
  'utility-payments-service',
  'bill_payment',
  'giftcards-service',
  'exchange-service',
  'invoice-service',
  'split-bill-service',
  'group-accounts-service',
  'payroll-service',
  'core-payments-service',
  'core-payments-batch-transfer',
  'core-payments-admin',
  'transfer',
  'accounts-service',
];

void main() {
  group('HoldRouteResolver', () {
    test('a lock resolves to the savings plan, record-close', () {
      final t = HoldRouteResolver.resolve(
        kind: 'lock',
        serviceName: 'financial-products-service',
        lockType: 'year_lock',
      );
      expect(t, isNotNull);
      expect(t!.precision, TargetPrecision.record);
      expect(t.route, isNotEmpty);
    });

    test('a lock is a lock regardless of which service recorded it', () {
      // The user put this money away deliberately; the owning service is an
      // implementation detail they never chose.
      for (final svc in ['', 'accounts-service', 'unknown-service']) {
        final t = HoldRouteResolver.resolve(kind: 'lock', serviceName: svc);
        expect(t, isNotNull, reason: 'lock from $svc must still resolve');
      }
    });

    test('every service that can reserve funds resolves somewhere', () {
      final unresolved = <String>[];
      for (final svc in _reservingServices) {
        final t = HoldRouteResolver.resolve(kind: 'hold', serviceName: svc);
        if (t == null) unresolved.add(svc);
      }
      expect(unresolved, isEmpty,
          reason: 'these holds would render as dead rows: $unresolved');
    });

    test('service holds are honest about landing, not record, precision', () {
      // MyAccountHold carries no reference, and its id is the RESERVE's id —
      // not the id of the bill or deal that caused it. Claiming `record` here
      // would be a lie encoded in a type.
      final t = HoldRouteResolver.resolve(
        kind: 'hold',
        serviceName: 'utility-payments-service',
      );
      expect(t!.precision, TargetPrecision.serviceLanding);
    });

    test('an unknown service returns null so the row stays non-tappable', () {
      // Deliberate: guessing is how a hold row ends up on the dashboard
      // telling the user nothing.
      expect(
        HoldRouteResolver.resolve(kind: 'hold', serviceName: 'brand-new-svc'),
        isNull,
      );
      expect(HoldRouteResolver.resolve(kind: 'hold', serviceName: ''), isNull);
    });

    test('service name matching is case- and whitespace-insensitive', () {
      for (final svc in [' Crypto-Service ', 'CRYPTO-SERVICE']) {
        expect(
          HoldRouteResolver.resolve(kind: 'hold', serviceName: svc),
          isNotNull,
          reason: '$svc should resolve like its canonical form',
        );
      }
    });

    test('routes are real route constants, not raw paths', () {
      // AppRoutes values all start with '/'. A typo'd literal would fail here
      // rather than dead-ending a tap at runtime.
      for (final svc in _reservingServices) {
        final t = HoldRouteResolver.resolve(kind: 'hold', serviceName: svc);
        expect(t!.route.startsWith('/'), isTrue, reason: '$svc -> ${t.route}');
      }
    });
  });
}
