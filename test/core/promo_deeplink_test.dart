import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/route_service_map.dart';
import 'package:lazervault/core/types/services.dart';

// Promotional campaigns name a SERVICE, not a route, and the route is looked
// up in the same map the admin availability gate uses. These pin the three
// things that would break a send already sitting on handsets.

void main() {
  group('promotional deep links', () {
    NotificationTarget? promo(Map<String, String> data) =>
        NotificationRouteResolver.resolve('promo', data);

    test('every service with a route is linkable, by name', () {
      // The point of deriving from the map: a service added tomorrow is
      // promotable without anyone remembering to add a resolver case.
      var checked = 0;
      for (final entry in kServiceToRoute.entries) {
        final t = promo({'service': entry.key.name});
        expect(t, isNotNull, reason: '${entry.key.name} has no promo link');
        expect(t!.route, entry.value,
            reason: '${entry.key.name} pointed at the wrong screen');
        expect(t.precision, TargetPrecision.serviceLanding,
            reason: 'a promotion invites to a service, it is not a record');
        checked++;
      }
      expect(checked, greaterThan(30),
          reason: 'the map looks truncated — only $checked services resolved');
    });

    test('the services the campaign brief names all resolve', () {
      // AI, cheap bills/data/airtime, contactless "two phones collide".
      for (final s in [
        AppServiceName.airtime,
        AppServiceName.data,
        AppServiceName.payBills,
        AppServiceName.contactlessPay,
        AppServiceName.aiScanToPay,
        AppServiceName.crypto,
        AppServiceName.giftCards,
        AppServiceName.groupAccount,
      ]) {
        final t = promo({'service': s.name});
        expect(t, isNotNull, reason: '${s.name} is in the campaign brief');
        expect(t!.route, isNot(AppRoutes.notificationsFeed),
            reason: '${s.name} fell through to the feed instead of its screen');
      }
    });

    test('an operator typo in the service name still lands', () {
      // Typed into a campaign form. Refusing "gift_cards" because the enum
      // says "giftCards" turns a typo into a dead link on every handset that
      // already received the push.
      final want = kServiceToRoute[AppServiceName.giftCards];
      for (final spelling in [
        'giftCards',
        'gift_cards',
        'GIFTCARDS',
        ' giftcards '
      ]) {
        expect(promo({'service': spelling})?.route, want,
            reason: 'service spelled "$spelling" did not resolve');
      }
    });

    test('an unknown service opens the feed rather than nothing', () {
      // A promo that opens nothing reads as the app being broken.
      final t = promo({'service': 'teleportation'});
      expect(t, isNotNull);
      expect(t!.route, AppRoutes.notificationsFeed);
    });

    test('a raw route is only honoured from the closed list', () {
      // Accepting any route string from a push payload turns a notification
      // into an arbitrary-navigation primitive — a malformed or hostile
      // payload could drop a user onto a money-moving screen with
      // attacker-chosen arguments.
      expect(promo({'route': AppRoutes.referralDashboard})?.route,
          AppRoutes.referralDashboard);

      for (final forbidden in [
        AppRoutes.sendFunds,
        AppRoutes.transactionPinSetup,
        AppRoutes.batchTransfer,
      ]) {
        expect(promo({'route': forbidden})?.route, AppRoutes.notificationsFeed,
            reason: '$forbidden must not be reachable from a promo payload');
      }
    });

    test('promo does not shadow a real event type', () {
      // _resolvePromo runs LAST because its final branch returns the feed.
      // Were it first, that catch-all would swallow genuine events.
      final t = NotificationRouteResolver.resolve(
          'transfer', {'reference': 'TRF-123'});
      expect(t, isNotNull);
      expect(t!.route, isNot(AppRoutes.notificationsFeed),
          reason: 'a real transfer event resolved to the promo catch-all');
    });

    test('campaign and announcement are accepted as aliases', () {
      final want = kServiceToRoute[AppServiceName.airtime];
      for (final type in ['promo', 'campaign', 'announcement']) {
        expect(
            NotificationRouteResolver.resolve(type, {'service': 'airtime'})
                ?.route,
            want,
            reason: 'type "$type" should carry a promotion');
      }
    });
  });
}
