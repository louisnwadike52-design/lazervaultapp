import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Takes a notification to its destination, whenever that becomes possible.
///
/// The hard part of deep linking is not the mapping — it is timing. A tap can
/// arrive at four different moments, and three of them have no navigator or no
/// session to route with:
///
///  * **Warm, signed in** — route immediately.
///  * **Warm, at the login gate** — the user tapped a push while the app sits
///    on the passcode screen. Pushing now would stack the destination *over*
///    the login screen: the user would see the invoice for an instant, then the
///    gate, and Back would take them out of the app.
///  * **Cold start from terminated** — `getInitialMessage()` fires during push
///    init, long before `GetMaterialApp` has mounted a navigator.
///  * **Cold start, signed out** — the destination exists but the session does
///    not. This is the case the old code dropped on the floor: only p2p chat
///    had a stash, so tapping a split-bill reminder while logged out logged you
///    in and left you on the dashboard, with nothing explaining why.
///
/// So a target is *stashed* and replayed. [consumeAndNavigate] is called on
/// every plausible trigger — the tap itself, the dashboard's `initState` after
/// login — and it is a no-op unless all the preconditions hold. Consumption is
/// atomic, so two callers racing produce one navigation.
///
/// Generalises `PendingChatNavigation`, which solved exactly this for p2p chat
/// alone; that class now delegates here.
class PendingDeepLink {
  PendingDeepLink._();
  static final PendingDeepLink instance = PendingDeepLink._();

  NotificationTarget? _pending;
  DateTime? _stashedAt;

  /// How long a stashed target stays valid.
  ///
  /// A tap that has been waiting at the login gate for a day is no longer what
  /// the user is trying to do — they have come back for their own reasons, and
  /// yanking them to a stale receipt would be baffling. An hour comfortably
  /// covers "tap push → log in", including a password reset detour.
  static const _staleAfter = Duration(hours: 1);

  bool get hasPending => _take(peek: true) != null;

  /// Resolves [type]/[data] and routes, or stashes for after login.
  ///
  /// Returns true when the notification had a destination at all — false means
  /// nothing in this build recognised the type, and the caller decides what to
  /// do (the push handler opens the notifications feed).
  bool handle(String type, Map<String, dynamic> data) {
    final target = NotificationRouteResolver.resolve(type, data);
    if (target == null) return false;
    push(target);
    return true;
  }

  /// Same, from a `lazervault://n/...` or `https://lazervault.app/n/...` link.
  bool handleUri(Uri uri) {
    final target = NotificationRouteResolver.resolveUri(uri);
    if (target == null) return false;
    push(target);
    return true;
  }

  /// Stashes [target] and tries to route right away.
  void push(NotificationTarget target) {
    _pending = target;
    _stashedAt = DateTime.now();
    consumeAndNavigate();
  }

  /// Routes the stashed target if it is now possible to. Safe to call from
  /// anywhere, at any time — it self-checks every precondition.
  void consumeAndNavigate() {
    final target = _take(peek: true);
    if (target == null) return;
    if (Get.context == null) return; // navigator not mounted yet
    if (target.requiresAuth && !_isAuthenticated()) return;
    if (_onAuthOrLockRoute()) return; // wait until past the gate

    final confirmed = _take();
    if (confirmed == null) return; // another caller won the race

    _prepare(confirmed);

    // Defer a frame so we never push during a build or an in-flight route
    // change — both throw, and a thrown navigation reads to the user as the
    // app ignoring their tap.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // `toNamed`, not `offNamed`: the destination stacks over the dashboard so
      // Back returns there rather than out of the app or onto the login gate.
      Get.toNamed(confirmed.route, arguments: confirmed.arguments);
    });
  }

  /// Discards anything stashed. Called on sign-out so a target captured by one
  /// user is never replayed into the next user's session — the stash outlives
  /// a logout otherwise, and these targets are account-specific.
  void clear() {
    _pending = null;
    _stashedAt = null;
  }

  /// Side effects that must happen before landing on certain destinations.
  ///
  /// Kept here rather than in the resolver so the resolver stays a pure
  /// mapping: it answers "where", this answers "what has to be true first".
  void _prepare(NotificationTarget target) {
    // A super-admin cleared this user's transaction PIN. The session caches
    // "has PIN = true"; without invalidating it the setup screen bounces
    // straight back out and the user can never re-enrol.
    if (target.route == AppRoutes.transactionPinSetup) {
      if (serviceLocator.isRegistered<ITransactionPinService>()) {
        try {
          serviceLocator<ITransactionPinService>().resetPinCache();
        } catch (_) {}
      }
    }
  }

  /// Reads the stash, dropping it if it has gone stale. [peek] leaves it in
  /// place; the default takes it (take-and-clear, so it fires exactly once).
  NotificationTarget? _take({bool peek = false}) {
    final target = _pending;
    if (target == null) return null;
    final at = _stashedAt;
    if (at != null && DateTime.now().difference(at) > _staleAfter) {
      _pending = null;
      _stashedAt = null;
      return null;
    }
    if (!peek) {
      _pending = null;
      _stashedAt = null;
    }
    return target;
  }

  bool _isAuthenticated() {
    try {
      final s = serviceLocator<AuthenticationCubit>().state;
      return s is AuthenticationSuccess || s is AuthenticationAuthenticated;
    } catch (_) {
      return false;
    }
  }

  /// True while the app is sitting on a screen the user must clear first.
  ///
  /// Matches `PendingChatNavigation`'s check so both behave identically — the
  /// authenticated state can flip to true while the passcode screen is still
  /// on top, and routing then would push the destination underneath the gate.
  bool _onAuthOrLockRoute() {
    final r = Get.currentRoute;
    return r.startsWith('/auth/') ||
        r.startsWith('/kyc/') ||
        r.contains('login') ||
        r.contains('passcode') ||
        r.contains('sign-in') ||
        r.contains('signup');
  }
}
