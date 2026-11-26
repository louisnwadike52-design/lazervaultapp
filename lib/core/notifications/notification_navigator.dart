import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/shared_widgets/service_unavailable_modal.dart';
import 'package:lazervault/core/types/route_service_map.dart';
import 'package:lazervault/core/config/feature_flags.dart';

import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/notifications/pending_deep_link_store.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/app_status/widgets/app_startup_gate.dart';
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
  // Whether a user was authenticated at the MOMENT this target was stashed.
  // A target captured with no session (a share link opened on a cold, logged-
  // out start) belongs to the person opening it now, NOT to any outgoing user,
  // so the sign-out/auto-login teardown must not wipe it. Only targets captured
  // under a live session are account-specific and cleared on teardown.
  bool _stashedUnderSession = false;

  /// Whether this target came from a link opened OUTSIDE the app — a shared
  /// campaign, an escrow offer, a group invite, a ticketed event.
  ///
  /// THE BUG THIS EXISTS FOR. `clear()` drops a target captured under a
  /// session, because a tapped receipt belongs to the user who tapped it and
  /// must never replay into the next person on a shared device. On a cold
  /// start that rule fired against the wrong target: the auth cubit restores a
  /// cached profile OPTIMISTICALLY, so `_isAuthenticated()` can be true at the
  /// moment a link is ingested, and when the stored refresh token is then
  /// rejected the teardown ran and took the link with it. The supporter tapped
  /// a campaign, was asked to log in, logged in, and landed on the dashboard
  /// with no sign the link had ever existed — reported against
  /// `https://lazervault.app/crowdfund/<id>`.
  ///
  /// A shared link is not account-specific by construction. It names something
  /// its sender wants ANYONE to open, it carries no private record, and
  /// whoever is holding the phone is its intended audience. So it is exempt
  /// from the sign-out rule — and its owner is left null, so the
  /// shared-device ownership check lets it through too.
  bool _stashedFromSharedLink = false;

  /// The user a session-captured target belongs to. A restored target with an
  /// owner may only replay for that same user — otherwise, on a shared device,
  /// one person's transfer notification would open for whoever logs in next.
  String? _stashedOwnerUserId;

  /// Guards against restoring twice (startup + a later trigger).
  bool _restoreAttempted = false;

  /// How long a stashed target stays valid.
  ///
  /// A tap that has been waiting at the login gate for a day is no longer what
  /// the user is trying to do — they have come back for their own reasons, and
  /// yanking them to a stale receipt would be baffling. An hour comfortably
  /// covers "tap push → log in", including a password reset detour.
  static const _staleAfter = Duration(hours: 1);

  bool get hasPending => _take(peek: true) != null;

  /// Reloads a stash the previous process left behind, then tries to route.
  ///
  /// Called once at startup. Does nothing when a target is already held in
  /// memory — this process's own tap is fresher than the last one's leftovers.
  Future<void> restore() async {
    if (_restoreAttempted) return;
    _restoreAttempted = true;
    if (_pending != null) return;

    final stored = await PendingDeepLinkStore.load();
    if (stored == null) return;

    // Same staleness rule as the in-memory stash: an intent that has been
    // waiting longer than this is no longer what the user came back for.
    if (DateTime.now().difference(stored.stashedAt) > _staleAfter) {
      await PendingDeepLinkStore.clear();
      return;
    }

    NotificationTarget? target;
    if (stored.isLink) {
      final parsed = NotificationLink.parse(stored.uri!);
      if (parsed != null) {
        target = NotificationRouteResolver.resolve(parsed.type, parsed.data);
        // Unknown type in THIS build — same fallback handleOrFeed uses, so an
        // older app meeting a newer server still shows what buzzed rather than
        // dropping the restored tap silently.
        target ??= const NotificationTarget(
          route: AppRoutes.notificationsFeed,
          precision: TargetPrecision.serviceLanding,
        );
      }
    } else {
      target = stored.toTarget();
    }
    if (target == null) {
      await PendingDeepLinkStore.clear();
      return;
    }

    _pending = target;
    _stashedAt = stored.stashedAt;
    _stashedOwnerUserId = stored.ownerUserId;
    // A record with an owner was captured under a session, so sign-out
    // teardown must drop it exactly as it would have in the original process.
    _stashedUnderSession = stored.ownerUserId != null;
    consumeAndNavigate();
  }

  /// The signed-in user's id, or null when there is no session.
  String? _currentUserId() {
    try {
      final s = serviceLocator<AuthenticationCubit>().state;
      if (s is AuthenticationSuccess) return s.profile.user.id;
      if (s is AuthenticationAuthenticated) return s.profile.user.id;
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Resolves [type]/[data] and routes, or stashes for after login.
  ///
  /// Returns true when the notification had a destination at all — false means
  /// nothing in this build recognised the type, and the caller decides what to
  /// do (the push handler opens the notifications feed).
  bool handle(String type, Map<String, dynamic> data) {
    final target = NotificationRouteResolver.resolve(type, data);
    if (target == null) return false;
    // Carry the ORIGINAL pair alongside the resolved target so the stash can be
    // persisted in link form and re-resolved after a restart. Preferred over
    // persisting the target, whose arguments may hold a live object (the
    // transaction deep link passes a TransactionServiceType enum).
    push(target, sourceType: type, sourceData: _asStringMap(data));
    return true;
  }

  /// Flattens a push payload to the string map the canonical link form takes.
  /// FCM data is already all-strings; a feed row may hold other scalars.
  static Map<String, String> _asStringMap(Map<String, dynamic> data) {
    final out = <String, String>{};
    data.forEach((k, v) {
      if (v == null) return;
      final s = v.toString();
      if (s.isNotEmpty) out[k] = s;
    });
    return out;
  }

  /// Same, from a `lazervault://n/...` or `https://lazervault.app/n/...` link.
  ///
  /// Returns false only when [uri] is not a notification link at all — the
  /// older `lazervault://deposit/callback` and family-invite links still belong
  /// to their own handlers. A link that IS a notification link but names a type
  /// this build does not know still returns true, having opened the feed: it
  /// was addressed to us, so swallowing it silently would be a dead tap.
  bool handleUri(Uri uri) {
    final parsed = NotificationLink.parse(uri);
    if (parsed == null) return false;
    handleOrFeed(parsed.type, parsed.data);
    return true;
  }

  /// Routes [type]/[data], falling back to the notifications feed when this
  /// build does not recognise the type.
  ///
  /// The fallback is the point: an older app meeting a newer server must still
  /// show the user what buzzed rather than dropping them on the dashboard. Both
  /// doors — a tapped push and a tapped link — go through here so they cannot
  /// diverge on that behaviour.
  void handleOrFeed(String type, Map<String, dynamic> data) {
    if (handle(type, data)) return;
    push(
      const NotificationTarget(
        route: AppRoutes.notificationsFeed,
        precision: TargetPrecision.serviceLanding,
      ),
    );
  }

  /// Stashes [target] and tries to route right away.
  ///
  /// [sourceType]/[sourceData] are the original notification pair when there was
  /// one; passing them lets the stash persist in the re-resolvable link form.
  void push(
    NotificationTarget target, {
    String? sourceType,
    Map<String, String>? sourceData,
    bool fromSharedLink = false,
  }) {
    _pending = target;
    _stashedAt = DateTime.now();
    _stashedFromSharedLink = fromSharedLink;
    _stashedUnderSession = !fromSharedLink && _isAuthenticated();
    _stashedOwnerUserId = _stashedUnderSession ? _currentUserId() : null;
    unawaited(_persist(target, sourceType, sourceData));
    consumeAndNavigate();
  }

  /// Mirrors the stash to disk so it survives the app being killed during the
  /// login detour. Fire-and-forget: a failed write costs the cross-restart
  /// guarantee, never the tap.
  Future<void> _persist(
    NotificationTarget target,
    String? sourceType,
    Map<String, String>? sourceData,
  ) async {
    final at = _stashedAt;
    if (at == null) return;
    if (sourceType != null && sourceType.isNotEmpty) {
      await PendingDeepLinkStore.saveLink(
        type: sourceType,
        data: sourceData ?? const {},
        stashedAt: at,
        ownerUserId: _stashedOwnerUserId,
      );
      return;
    }
    await PendingDeepLinkStore.saveRoute(
      target: target,
      stashedAt: at,
      ownerUserId: _stashedOwnerUserId,
    );
  }

  /// Routes the stashed target if it is now possible to. Safe to call from
  /// anywhere, at any time — it self-checks every precondition.
  void consumeAndNavigate() {
    final target = _take(peek: true);
    if (target == null) {
      _stopRetrying();
      return;
    }
    if (Get.context == null) return _retryShortly(); // no navigator yet
    if (target.requiresAuth && !_isAuthenticated()) return _retryShortly();
    // Hold the replay until a call from the destination would carry a token.
    // The observer retries on the next frame and on every pop, so this costs
    // a few frames at worst and saves the destination from rendering an
    // authentication failure as its first impression.
    if (target.requiresAuth && !_tokenLooksReady()) return _retryShortly();
    if (_onAuthOrLockRoute()) return _retryShortly(); // wait past the gate

    // OWNERSHIP. A target captured under a session belongs to that user. On a
    // shared device the next person to log in must never be shown the previous
    // one's transfer, so a restored session-captured target is discarded rather
    // than replayed when the signed-in user differs.
    final owner = _stashedOwnerUserId;
    if (owner != null && owner.isNotEmpty) {
      final now = _currentUserId();
      if (now != null && now != owner) {
        clearAll();
        return;
      }
    }

    final confirmed = _take();
    if (confirmed == null) return; // another caller won the race
    _stopRetrying();

    _prepare(confirmed);

    // Defer a frame so we never push during a build or an in-flight route
    // change — both throw, and a thrown navigation reads to the user as the
    // app ignoring their tap.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        // ADMIN UNAVAILABILITY GATE — the deep-link half.
        //
        // The tile dispatcher already refuses to open a service an admin has
        // taken offline, which covers the grid and the all-services search.
        // A notification bypasses both: it names a route and pushes it. So an
        // admin could mark a service unavailable and still have users land
        // inside it from a push, which is exactly the confusion the modal
        // exists to prevent.
        //
        // Explained, not silently swallowed: a tap that does nothing reads as
        // the app ignoring the user. They get the same modal they would have
        // got from the tile, with the admin's own message.
        final gated = serviceForRoute(confirmed.route);
        if (gated != null &&
            FeatureFlags.quickServiceEntryBlocked(gated.name)) {
          final ctx = Get.context;
          if (ctx != null) {
            showServiceUnavailableModal(
              ctx,
              serviceName: gated.displayName,
              message: FeatureFlags.quickServiceMessage(gated.name),
            );
          }
          return;
        }
        // `toNamed`, not `offNamed`: the destination stacks over the dashboard
        // so Back returns there rather than out of the app or onto the login
        // gate.
        Get.toNamed(confirmed.route, arguments: confirmed.arguments);
      } catch (_) {
        // A route the resolver names but this build does not register, or one
        // whose arguments the destination rejects. Throwing inside a
        // post-frame callback is invisible to the user — the tap simply does
        // nothing — so fall back to the feed, where they can at least read
        // what the notification said.
        //
        // `notification_route_coverage_test.dart` asserts every route the
        // resolver can return is registered, so this should be unreachable;
        // it exists because a dead tap is a bad way to discover otherwise.
        try {
          Get.toNamed(AppRoutes.notificationsFeed);
        } catch (_) {}
      }
    });
  }

  /// Called on sign-out / rejected auto-login. Drops a target captured UNDER a
  /// session (account-specific — must never replay into the next user), but
  /// KEEPS one captured with no session: that is a fresh share/deep link opened
  /// on a cold logged-out start, and the cold-start auto-login teardown races
  /// its ingestion. Clearing it there silently dropped the link the user just
  /// tapped — they logged in and landed on the dashboard instead of the offer.
  void clear() {
    // A shared link belongs to whoever opened it, not to the session that
    // happened to be restored when it arrived. See _stashedFromSharedLink.
    if (_stashedFromSharedLink) return;
    if (!_stashedUnderSession) return; // fresh pre-auth intent — preserve it
    _pending = null;
    _stashedAt = null;
    _stashedUnderSession = false;
    _stashedFromSharedLink = false;
    _stashedOwnerUserId = null;
    unawaited(PendingDeepLinkStore.clear());
  }

  /// Unconditional wipe (used by tests / a hard reset). Prefer [clear] for
  /// sign-out so pre-auth deep links survive the login gate.
  void clearAll() {
    _pending = null;
    _stashedAt = null;
    _stashedUnderSession = false;
    _stashedFromSharedLink = false;
    _stashedOwnerUserId = null;
    unawaited(PendingDeepLinkStore.clear());
  }

  /// A BOUNDED TICK, BECAUSE A ROUTE CHANGE IS NOT GUARANTEED TO COME.
  ///
  /// Replay used to be driven entirely by events: the tap, the dashboard's
  /// first frame, and [DeepLinkReplayObserver] on every push/pop/replace.
  /// That covers every case where something MOVES — and the one that strands
  /// a link is the case where nothing does. The last route change of a login
  /// is `offAllNamed(dashboard)`, and the access token is written to secure
  /// storage after it; a target held back by `_tokenLooksReady()` at that
  /// instant has no further event to wake it. The user then sits on a
  /// dashboard with their campaign link still in the stash, which reads
  /// exactly like the link having done nothing.
  ///
  /// Bounded on purpose. It stops the moment the target is routed, dropped or
  /// has run out of attempts, so there is no timer alive in the common case
  /// and no unbounded poll in any case. Thirty attempts at 400ms is twelve
  /// seconds — comfortably past a token write, and far short of a user having
  /// moved on.
  static const _retryEvery = Duration(milliseconds: 400);
  static const _maxRetries = 30;
  Timer? _retryTimer;
  int _retriesLeft = 0;

  void _retryShortly() {
    if (_retryTimer != null) return; // already ticking
    _retriesLeft = _maxRetries;
    _retryTimer = Timer.periodic(_retryEvery, (t) {
      if (_retriesLeft-- <= 0) {
        _stopRetrying();
        return;
      }
      consumeAndNavigate();
    });
  }

  void _stopRetrying() {
    _retryTimer?.cancel();
    _retryTimer = null;
    _retriesLeft = 0;
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
      _stashedUnderSession = false;
      _stashedFromSharedLink = false;
      _stashedOwnerUserId = null;
      unawaited(PendingDeepLinkStore.clear());
      return null;
    }
    if (!peek) {
      _pending = null;
      _stashedAt = null;
      _stashedUnderSession = false;
      _stashedFromSharedLink = false;
      _stashedOwnerUserId = null;
      // The disk copy must go with it. Leaving it behind would replay an
      // already-consumed notification on the next cold start — yanking the
      // user to a receipt they just closed.
      unawaited(PendingDeepLinkStore.clear());
    }
    return target;
  }

  /// Overridable in tests, the same seam [PendingDeepLinkStore.prefs] uses.
  ///
  /// Without it the session-ownership rules are untestable: the service
  /// locator is empty under `flutter test`, so `_isAuthenticated()` always
  /// answers false and every stash looks like a pre-auth one — which is
  /// exactly the branch the crowdfund bug was NOT in.
  @visibleForTesting
  static bool Function()? debugIsAuthenticated;

  bool _isAuthenticated() {
    final override = debugIsAuthenticated;
    if (override != null) return override();
    try {
      final s = serviceLocator<AuthenticationCubit>().state;
      return s is AuthenticationSuccess || s is AuthenticationAuthenticated;
    } catch (_) {
      return false;
    }
  }

  /// Whether a CALL made by the destination would actually carry a token.
  ///
  /// "AUTHENTICATED" AND "HAS A USABLE TOKEN" ARE NOT THE SAME THING, and the
  /// gap between them is what a cold start from a tapped notification lands
  /// in. The cubit reports a session the moment it is restored; the access
  /// token is written to secure storage separately and asynchronously. A
  /// target replayed in that window pushes a screen that fetches immediately,
  /// with no authorization header, and the gateway answers UNAUTHENTICATED —
  /// which reached the customer as a page of gRPC trailers on the Deposit
  /// screen after tapping a deposit push.
  ///
  /// SYNCHRONOUS AND CHEAP, deliberately: this is called from a post-frame
  /// callback and from the replay observer on every pop, so it reads a value
  /// the token helper already keeps in memory rather than touching storage.
  /// Unknown reads as READY — the destination's own call then waits for the
  /// token (GrpcCallOptionsHelper does, for up to 3.6s, whenever a refresh
  /// token exists), so being wrong here only costs what it cost before.
  bool _tokenLooksReady() {
    try {
      return GrpcCallOptionsHelper.lastKnownTokenUsable ?? true;
    } catch (_) {
      return true;
    }
  }

  /// True while the app is sitting on a screen the user must clear first.
  ///
  /// Matches `PendingChatNavigation`'s check so both behave identically — the
  /// authenticated state can flip to true while the passcode screen is still
  /// on top, and routing then would push the destination underneath the gate.
  bool _onAuthOrLockRoute() {
    // A BLOCKING MODAL OWNS THE SCREEN.
    //
    // The fraud freeze and the forced-update prompt are dialogs, not routes, so
    // no path check sees them — and the freeze is security-critical: the
    // dashboard deliberately resolves it first and lets it own the screen.
    // Pushing a receipt over it would both hide it and let the user navigate
    // away from it. Deferring costs nothing, because the replay observer
    // retries on didPop as soon as the dialog closes.
    if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) return true;

    // AND THE TWO BLOCKERS THAT ARE NEITHER ROUTE NOR DIALOG.
    //
    // AppStartupGate returns the forced-update screen INSTEAD of the app (so
    // the Navigator is not in the tree at all) and paints the maintenance
    // overlay as a Positioned.fill. Neither moves Get.currentRoute and neither
    // registers as a dialog, so every check above reads "clear" while the user
    // cannot reach anything. A replay then navigated into a Navigator nobody
    // could see and CONSUMED the stash — the link silently lost, on exactly
    // the outdated or offline build most likely to have been sent one.
    if (AppStartupGate.blockingTheScreen) return true;

    final r = Get.currentRoute;
    // Breadth is the right direction here. A false positive costs a short
    // wait — the replay observer retries on the next didPop — while a false
    // negative pushes a destination OVER a gate the user has not passed.
    return r.startsWith('/auth/') ||
        r.startsWith('/kyc/') ||
        // THE INTRO CAROUSEL IS A GATE TOO, and it is under none of the
        // prefixes above. A fresh install shows it before the auth entry, and
        // `has_seen_onboarding` is only written when it finishes or is
        // skipped — so a target that does not require auth, replayed here,
        // navigated away from the carousel, left the flag unwritten, and the
        // carousel came back on the next launch.
        r.startsWith(AppRoutes.onboarding) ||
        r.contains('login') ||
        r.contains('passcode') ||
        r.contains('sign-in') ||
        r.contains('signup');
  }
}
