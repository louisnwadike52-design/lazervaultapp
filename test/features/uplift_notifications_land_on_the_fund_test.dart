import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Every Lazerfunds notification used to land on the transaction history.
///
/// The feature had no named route — both screens were only ever pushed with
/// `Get.to(() => ...)` from inside the feature — so the resolver had no name
/// to send anyone to and fell back to the account history. Tapping
/// "Applications closing soon" took you to a list of transactions.
///
/// Worse, the deadline reminders smuggled their dedup key into the REFERENCE:
/// they sent `"<fund-uuid>:appdl:2026-10-16"` so the reminder would not repeat
/// daily, and that string travelled on as the notification's reference_id —
/// the very field the client folds into the deep-link payload. The id was not
/// a uuid and matched nothing.
void main() {
  const fund = 'b1436916-12dc-426b-bfa8-f9bd7092e2de';

  group('fund notices open the fund', () {
    const types = [
      'uplift_applications_closed',
      'uplift_application_deadline_soon',
      'uplift_funding_deadline_soon',
      'uplift_fund_expired',
      'uplift_fund_completed',
      'uplift_fund_cancelled',
      'uplift_pool_committed',
      'uplift_application_received',
      'uplift_offer_received',
    ];

    for (final t in types) {
      test('$t opens the fund', () {
        final target =
            NotificationRouteResolver.resolve(t, {'fund_id': fund});
        expect(target, isNotNull);
        expect(target!.route, AppRoutes.lazerfundDetails,
            reason: '$t landed on ${target.route} instead of the fund');
        expect((target.arguments as Map)['fundId'], fund);
      });
    }

    test('reference_id alone is enough', () {
      // Older payloads carry only reference_id, which the client folds into
      // data. For every fund-scoped uplift notice it IS the fund id.
      final target = NotificationRouteResolver.resolve(
          'uplift_applications_closed', {'reference_id': fund});
      expect((target!.arguments as Map)['fundId'], fund);
    });

    test('a composite reference is NOT treated as a fund id', () {
      // The shape the deadline reminders used to send. It must not be handed
      // to a screen that will ask the server for it.
      final target = NotificationRouteResolver.resolve(
        'uplift_application_deadline_soon',
        {'reference_id': '$fund:appdl:2026-10-16'},
      );
      expect(target, isNotNull);
      final args = target!.arguments;
      final id = args is Map ? args['fundId'] as String? : null;
      expect(id, isNot(contains(':appdl:')),
          reason: 'a dedup key is not an entity id — asking the server for '
              'this fetches nothing and the screen hangs');
    });
  });

  group('money notices still go to the history', () {
    // A disbursement or refund is a question about an amount landing in an
    // account, and the history is where that is answered.
    for (final t in const [
      'uplift_disbursement',
      'uplift_disbursement_rollback',
      'uplift_escrow_refunded',
    ]) {
      test('$t opens the transaction history', () {
        final target =
            NotificationRouteResolver.resolve(t, {'fund_id': fund});
        expect(target!.route, AppRoutes.dashboardTransactionHistory);
      });
    }
  });

  test('no id at all still lands somewhere about Lazerfunds', () {
    final target =
        NotificationRouteResolver.resolve('uplift_fund_expired', const {});
    expect(target!.route, AppRoutes.lazerfunds,
        reason: 'the message was about a fund; a transaction list is not an '
            'answer to it');
  });
}
