import 'package:flutter/widgets.dart';

import 'package:lazervault/core/notifications/notification_navigator.dart';
import 'package:lazervault/core/services/pending_chat_navigation.dart';

/// Retries a stashed deep link whenever the app settles on a new route.
///
/// WHY A ROUTE OBSERVER AND NOT JUST THE DASHBOARD
///
/// [PendingDeepLink.consumeAndNavigate] self-checks every precondition, so the
/// only question is WHEN to call it. It was called from two places: the tap
/// itself, and the dashboard's first frame. That assumed the dashboard is
/// always the first authenticated screen — and it is not:
///
///   * login can land on KYC, a forced-update gate, or a fraud-freeze screen
///     that owns the screen before the dashboard mounts;
///   * `_onAuthOrLockRoute()` correctly declines while the passcode screen is
///     still on top, and the authenticated state can flip to true BEFORE that
///     route is gone — so the dashboard's own callback can fire too early and
///     then never be retried;
///   * a user already signed in who is deep inside another service when the
///     push arrives never re-mounts the dashboard at all.
///
/// In each of those the target sat in the stash until the user happened to
/// return to the dashboard. Observing route changes removes the guesswork: the
/// retry happens every time the navigation stack changes, which is exactly when
/// the preconditions can newly have become true.
///
/// Cheap by construction: a peek at a null stash is the common case and returns
/// immediately, and consumption is atomic so repeated calls cannot double-fire.
class DeepLinkReplayObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _retry();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _retry();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _retry();
  }

  /// Deferred a frame: the observer fires DURING the route transition, and
  /// pushing then is the exact "navigation during build" crash the navigator's
  /// own post-frame deferral exists to avoid.
  void _retry() {
    if (!PendingDeepLink.instance.hasPending &&
        !PendingChatNavigation.instance.hasPending) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PendingChatNavigation.instance.consumeAndNavigate();
      PendingDeepLink.instance.consumeAndNavigate();
    });
  }
}

/// The single instance registered on `GetMaterialApp.navigatorObservers`.
final DeepLinkReplayObserver deepLinkReplayObserver = DeepLinkReplayObserver();
