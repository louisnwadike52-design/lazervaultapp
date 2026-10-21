import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/admin_alerts/admin_alerts_screen.dart';

/// WHO CAN OPEN THE OPERATOR ALERT FEED.
///
/// The settings tile was gated from the start, and that was mistaken for the
/// screen being gated. It was not: `isAdminRoles` had exactly one caller — the
/// tile — while the class doc claimed the screen "additionally hides itself
/// from non-admins via [isAdminRoles]".
///
/// Two other ways in existed the whole time:
///   * `app_router.dart` registers `/admin/alerts` as a named route;
///   * an `ops_alert` / `prometheus_alert` push deep-links straight to it
///     (`core/notifications/resolver_account.dart`).
///
/// Nothing leaked — admin-gateway answers a non-admin with 403 — but the user
/// got the full operator surface and a failed request, which reads as a broken
/// app rather than a screen they were never meant to open.
void main() {
  group('the role predicate', () {
    test('the roles that actually exist in prod', () {
      // Measured 2026-10-20: every account holds some subset of
      // user / admin / super_admin. The other names below are accepted by
      // admin-gateway and simply unused so far.
      expect(isAdminRoles(['user']), isFalse);
      expect(isAdminRoles(['admin']), isTrue);
      expect(isAdminRoles(['super_admin', 'user']), isTrue);
      expect(isAdminRoles(['user', 'admin', 'super_admin']), isTrue);
    });

    test('absent or empty roles are not admin', () {
      // null is the state before a profile loads. Defaulting that to "admin"
      // would open the screen during every cold start.
      expect(isAdminRoles(null), isFalse);
      expect(isAdminRoles([]), isFalse);
    });

    test('case does not let a role through or keep one out', () {
      expect(isAdminRoles(['Admin']), isTrue);
      expect(isAdminRoles(['SUPER_ADMIN']), isTrue);
    });

    test('a lookalike role is not admin', () {
      // Substring matching here would make "administrator_readonly" or a
      // customer-chosen username-ish role an operator.
      expect(isAdminRoles(['adminx']), isFalse);
      expect(isAdminRoles(['not_admin']), isFalse);
      expect(isAdminRoles(['superadmin']), isFalse);
    });
  });

  group('the screen guards itself, not just the tile', () {
    String src(String p) => File(p).readAsStringSync();
    const screen = 'lib/src/features/admin_alerts/admin_alerts_screen.dart';
    const settings =
        'lib/src/features/settings/presentation/view/settings_screen.dart';

    test('the tile is still gated', () {
      expect(src(settings), contains('isAdminRoles('),
          reason: 'the settings tile lost its gate');
    });

    test('and so is the screen, on the path that actually loads data', () {
      final s = src(screen);
      expect(s.contains('if (!isAdminRoles(roles))'), isTrue,
          reason: 'the screen is back to trusting whoever opened it, so a '
              'deep link or an ops_alert push shows the operator feed');
    });

    test('the guard reads the locator, not the widget tree', () {
      // A GetX-pushed route does not necessarily carry the BlocProvider the
      // settings tile relies on; a guard that throws on the deep-link path is
      // no guard at all.
      expect(src(screen),
          contains('serviceLocator<AuthenticationCubit>().currentProfile'));
      expect(src(screen).contains('context.read<AuthenticationCubit>'), isFalse,
          reason: 'reading the provider here fails on exactly the route this '
              'guard exists to cover');
    });

    test('a refused view is not dressed up as an error', () {
      // There is nothing wrong; it is simply not their screen. An error state
      // invites a retry that can never succeed.
      final s = src(screen);
      expect(s.contains('_notPermitted'), isTrue);
      expect(s.contains('only available to system administrators'), isTrue);
      expect(s.contains('if (!_notPermitted)'), isTrue,
          reason: 'the refresh action is still offered on a screen that will '
              'never load');
    });
  });
}
