import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_navigator.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// THE SHARED CAMPAIGN LINK THAT NEVER ARRIVED.
///
/// Reported against `https://lazervault.app/crowdfund/<id>`: tapped while
/// signed out, the app asked for a login and then landed on the dashboard
/// with the campaign gone — "not going through the login flow… leads to no
/// auth and account loading on dashboard without fetching".
///
/// The stash machinery was right and one rule inside it was aimed at the
/// wrong target. `clear()` drops a destination captured under a session,
/// because a tapped receipt belongs to the person who tapped it and must
/// never replay into the next user of a shared phone. On a cold start the
/// auth cubit restores a cached profile OPTIMISTICALLY, so the link is
/// ingested while `_isAuthenticated()` reads true — and when the stored
/// refresh token is then rejected, the teardown runs `clear()` and takes the
/// link with it.
///
/// A link someone SHARED is not account-specific. It names something its
/// sender wants anyone to open, and whoever is holding the phone is its
/// audience. So it is exempt from that rule, and from the owner check for the
/// same reason.
void main() {
  // consumeAndNavigate reads Get.context, which needs a binding.
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    PendingDeepLink.debugIsAuthenticated = null;
    PendingDeepLink.instance.clearAll();
  });

  const campaign = NotificationTarget(
    route: AppRoutes.crowdfundDetails,
    arguments: {'crowdfundId': '6ea5c612-54e7-419d-b7d0-97439bc44575'},
  );

  test('a shared link survives the auto-login teardown', () {
    // The exact cold-start shape: a restored profile makes this read true at
    // the moment the link is ingested.
    PendingDeepLink.debugIsAuthenticated = () => true;
    PendingDeepLink.instance.push(campaign, fromSharedLink: true);

    // The stored refresh token is rejected; _clearSession runs.
    PendingDeepLink.instance.clear();

    expect(PendingDeepLink.instance.hasPending, isTrue,
        reason: 'the supporter tapped a campaign and must still reach it '
            'after logging in');
  });

  test('a notification tapped under a session is still dropped', () {
    // The rule clear() exists for, unchanged: this one IS account-specific.
    PendingDeepLink.debugIsAuthenticated = () => true;
    PendingDeepLink.instance.push(const NotificationTarget(
      route: AppRoutes.dashboardTransactionHistory,
    ));

    PendingDeepLink.instance.clear();

    expect(PendingDeepLink.instance.hasPending, isFalse,
        reason: 'one person\'s transaction must never open for the next '
            'person to log in on a shared device');
  });

  test('a link opened with no session at all is kept', () {
    PendingDeepLink.debugIsAuthenticated = () => false;
    PendingDeepLink.instance.push(campaign, fromSharedLink: true);
    PendingDeepLink.instance.clear();
    expect(PendingDeepLink.instance.hasPending, isTrue);
  });

  test('every external share link is marked as one', () {
    // ANCHORED on the ROUTE, so the check cannot drift onto a different case
    // in the switch. Each of these is a link a user sends to someone else.
    final src = File('lib/main.dart').readAsStringSync();
    const shareRoutes = [
      'AppRoutes.groupJoinLink', // family / group invite
      'AppRoutes.escrowOfferView',
      'AppRoutes.crowdfundDetails',
      'AppRoutes.ticketingDetail',
      'AppRoutes.lazerSprayJoin',
      'AppRoutes.groupDetails',
    ];
    for (final route in shareRoutes) {
      final at = src.indexOf('route: $route');
      expect(at, greaterThan(0), reason: '$route is no longer deep-linked');
      // The push call ends within a few lines of the route.
      final window = src.substring(at, at + 400);
      final end = window.indexOf(');');
      expect(window.substring(0, end == -1 ? window.length : end),
          contains('fromSharedLink: true'),
          reason: '$route is a link people SEND to other people. Without '
              'fromSharedLink the auto-login teardown deletes it and the '
              'recipient lands on the dashboard.');
    }
  });

  test('the teardown exemption is actually in clear()', () {
    final src = File('lib/core/notifications/notification_navigator.dart')
        .readAsStringSync();
    final clearBody = src.substring(src.indexOf('void clear() {'));
    expect(clearBody.substring(0, clearBody.indexOf('\n  }')),
        contains('if (_stashedFromSharedLink) return;'),
        reason: 'the exemption must come BEFORE the under-session check, or '
            'the share link is dropped exactly as before');
  });
}
