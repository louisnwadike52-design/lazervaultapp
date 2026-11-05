import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Two routing gaps found by sweeping the resolver over the types the backend
/// actually emits, in the shape it actually emits them.
void main() {
  group('all three budget alerts open the budgets', () {
    // HandleBudgetAlertNotification emits THREE alert types for one feature and
    // puts the alert type straight into `type`. The resolver matched on the
    // prefix "budget", so only budget_exceeded was caught — the two EARLY
    // warnings, the ones a user can still act on, dead-ended on the
    // notifications feed while the already-too-late one opened the budgets.
    for (final t in const [
      'budget_exceeded',
      'threshold_reached',
      'approaching_limit',
    ]) {
      test(t, () {
        final target = NotificationRouteResolver.resolve(
          t,
          const {'budget_id': 'b-1', 'budget_name': 'Food'},
        );
        expect(target, isNotNull,
            reason: '$t has no destination, so a tapped budget warning lands '
                'on the feed instead of the budget it is warning about');
        expect(target!.route, AppRoutes.budgetList);
      });
    }

    test('an unrelated type is not swept up by the new matches', () {
      // The two new matches are exact, not prefixes: "threshold_reached" must
      // not start catching, say, a savings threshold event that belongs
      // elsewhere.
      expect(
        NotificationRouteResolver.resolve('threshold_reached_savings', const {}),
        isNot(predicate<NotificationTarget?>(
            (t) => t?.route == AppRoutes.budgetList)),
      );
    });
  });

  group('a 2FA change opens the 2FA screen', () {
    for (final e in const ['2fa.enabled', '2fa.disabled']) {
      test(e, () {
        final target =
            NotificationRouteResolver.resolve('security', {'event_type': e});
        expect(target, isNotNull);
        expect(
          target!.route,
          AppRoutes.twoFactorSettings,
          reason: 'a security change about a specific control must open the '
              'page showing that control — the question the notification '
              'raises is "was that me?", and myAccount cannot answer it',
        );
      });
    }

    test('other security events still reach the account page', () {
      // The catch-all must survive: these have no dedicated screen, and
      // myAccount is where sessions and account state live.
      for (final e in const [
        'login.new_device',
        'password.changed',
        'account.admin_unlocked',
      ]) {
        final target =
            NotificationRouteResolver.resolve('security', {'event_type': e});
        expect(target?.route, AppRoutes.myAccount, reason: 'regressed for $e');
      }
    });

    test('a PIN reset still goes straight to PIN setup', () {
      // The most actionable security route in the app, and the one the
      // navigator invalidates the has-PIN cache for. Must not be shadowed.
      final target = NotificationRouteResolver.resolve(
          'security', {'event_type': 'transaction_pin.admin_reset'});
      expect(target?.route, AppRoutes.transactionPinSetup);
      expect(target?.precision, TargetPrecision.record);
    });
  });
}
