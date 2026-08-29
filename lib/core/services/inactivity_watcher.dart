import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/app_activity_bus.dart';
import 'package:lazervault/core/services/auto_logout_guard.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_state.dart';
import 'package:lazervault/src/features/voice_session/voice_session_activity.dart';

/// App-wide inactivity auto-logout + refresh-on-resume.
///
/// Wraps the root navigator (above [GetMaterialApp], inside the auth
/// [BlocProvider]). While the user is authenticated, any window of
/// [EndpointRegistry.inactivityTimeoutSeconds] with no pointer / scroll
/// interaction triggers a secure logout via the SAME path the app's drawer
/// uses ([AuthenticationCubit.logout] + `Get.offAllNamed(AppRoutes.signIn)`).
///
/// Production hardening / edge cases handled:
///   * **Timeout is the single source of truth from admin** — read live from
///     [EndpointRegistry] on every (re)arm, so an admin change takes effect on
///     the next interaction without an app restart.
///   * **Background time counts** — when the app is paused we stamp the time
///     and cancel the foreground timer (timers don't fire reliably while
///     backgrounded). On resume, if the elapsed background time already
///     exceeded the threshold the user is logged out immediately; otherwise the
///     timer re-arms and key data is refreshed.
///   * **Only runs when authenticated** — the timer is armed on auth-success
///     states and cancelled otherwise, so auth/onboarding screens are never
///     interrupted.
///   * **Re-entrancy guard** — `_loggingOut` prevents a double logout/navigate
///     if a pointer event and the timer race.
///   * **Passive interaction capture** — uses [Listener] (not GestureDetector),
///     so it observes pointer events without absorbing taps from the app.
class InactivityWatcher extends StatefulWidget {
  final Widget child;
  const InactivityWatcher({super.key, required this.child});

  @override
  State<InactivityWatcher> createState() => _InactivityWatcherState();
}

class _InactivityWatcherState extends State<InactivityWatcher>
    with WidgetsBindingObserver {
  Timer? _timer;
  DateTime? _backgroundedAt;
  bool _loggingOut = false;

  AuthenticationCubit get _auth => context.read<AuthenticationCubit>();

  bool _authed(AuthenticationState s) =>
      s is AuthenticationSuccess || s is AuthenticationAuthenticated;

  bool get _isAuthenticated => _authed(_auth.state);

  // Inactivity auto-logout only applies once the user has reached the
  // authenticated app (dashboard landing onwards). During the signup/onboarding
  // journey the profile is already hydrated (authenticated) BEFORE the user
  // finishes — transaction-PIN setup, KYC, the post-signup verification steps —
  // so arming here would wrongly log the user out mid-onboarding. Suppress on
  // the auth (`/auth/*`) and KYC (`/kyc/*`) route families; everything from the
  // dashboard onwards is fair game.
  bool get _inOnboardingFlow {
    final r = Get.currentRoute;
    return r.startsWith('/auth/') || r.startsWith('/kyc/');
  }

  // Inactivity auto-logout is ENABLED and read LIVE from the registry (single
  // source of truth, admin-tunable) on every (re)arm — defaults to 90s (1m30s);
  // an admin can override, or set 0 to disable. See
  // EndpointRegistry.inactivityTimeoutSeconds.
  Duration get _timeout =>
      Duration(seconds: endpointRegistry.inactivityTimeoutSeconds);

  // An active voice-agent session counts as activity: while the voice bottom
  // sheet / LiveKit session is engaged the user may be hands-free (speaking, or
  // the agent is processing/awaiting PIN), so we must NOT auto-logout. Treat any
  // VoiceSessionCubit state other than the clearly-idle/terminal ones as active.
  bool get _voiceActive {
    // Process-global flag set by VoiceSessionCubit — authoritative regardless of
    // BuildContext scope. Covers the minimized-into-floating-bubble case, where the
    // sheet is popped and the cubit may sit outside this watcher's context.
    if (VoiceSessionActivity.isActive) return true;
    try {
      final s = context.read<VoiceSessionCubit>().state;
      return s is! VoiceSessionInitial &&
          s is! VoiceSessionDisconnected &&
          s is! VoiceSessionEnded &&
          s is! VoiceSessionError &&
          s is! VoiceSessionCredentialsError &&
          s is! VoiceSessionMicPermissionDenied &&
          s is! VoiceSessionWebSocketFailed;
    } catch (_) {
      return false; // Cubit not in scope → rely on the global flag above.
    }
  }

  // True when the soft keyboard is up (the user is composing a message/typing).
  // Keyboard key-taps land on the OS keyboard overlay, NOT the Flutter pointer
  // `Listener`, so without this the timer would fire mid-typing. Read straight
  // from the platform view insets so it works even though this widget sits
  // above MediaQuery (no MediaQuery.of here).
  bool get _keyboardUp {
    try {
      final views = WidgetsBinding.instance.platformDispatcher.views;
      if (views.isEmpty) return false;
      return views.first.viewInsets.bottom > 0;
    } catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Non-pointer engagement (typing, chat send/receive, streaming AI reply,
    // voice activity) pings this bus → re-arm the timer.
    AppActivityBus.instance.tick.addListener(_onUserInteraction);
  }

  @override
  void dispose() {
    _timer?.cancel();
    AppActivityBus.instance.tick.removeListener(_onUserInteraction);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Fires on keyboard show/hide/resize among other metric changes. A visible
    // keyboard means the user is actively typing → count it as interaction.
    if (_keyboardUp) _onUserInteraction();
  }

  // TESTING TOGGLE: when true, the inactivity auto-logout is disabled so the
  // app never locks to the passcode screen mid-test.
  //
  // Paired with a kDebugMode check at the use site, so it CANNOT ship: a
  // release build ignores this flag entirely even if it is left true. That
  // matters because auto-logout is a security control and the pre-deploy guard
  // (scripts/ensure_auto_logout_enabled.sh) only repairs the SERVER setting —
  // it cannot see a client-side flag, so a forgotten `true` would otherwise
  // ship silently. Production behaviour remains admin-driven via
  // session_inactivity_logout_seconds.
  static const bool _kDisableInactivityForTesting = false;

  void _armTimer() {
    _timer?.cancel();
    // kDebugMode is load-bearing, not decoration — it is what makes the testing
    // toggle unshippable. Do not remove it to "simplify" this line.
    if (_kDisableInactivityForTesting && kDebugMode) return;
    if (!_isAuthenticated || _inOnboardingFlow) return;
    // A timeout of 0 (or less) means the admin disabled auto-logout
    // (`session_inactivity_logout_seconds = 0`) — don't arm the timer at all.
    if (_timeout.inSeconds <= 0) return;
    _timer = Timer(_timeout, _onInactive);
  }

  // Pointer/scroll callback. Fires very frequently, so keep it cheap: a single
  // bail-out when not authenticated, otherwise re-arm the (already short) timer.
  void _onUserInteraction([Object? _]) {
    if (!_isAuthenticated || _inOnboardingFlow) return;
    _armTimer();
  }

  Future<void> _onInactive() async {
    if (_loggingOut || !_isAuthenticated || _inOnboardingFlow) return;
    // Defer logout while the user is demonstrably engaged rather than idle:
    //   * a voice-agent session is live (general or per-service) — hands-free,
    //   * the soft keyboard is up (composing a chat/message/form),
    //   * an exempt page is on screen (chatbot / financial connections) — the
    //     user may sit reading with no interaction; auto-logout re-enables the
    //     instant they navigate away (the page's suppression clears on dispose /
    //     its predicate reports it's no longer the active surface).
    // Re-arm and re-check after the next window instead of logging out mid-use.
    // (Chat send/receive + streaming replies keep the timer fresh via
    // AppActivityBus, so an active conversation never reaches this point.)
    if (_voiceActive || _keyboardUp || AutoLogoutGuard.isSuppressed) {
      _armTimer();
      return;
    }
    _loggingOut = true;
    _timer?.cancel();
    try {
      await _auth.logout();
      // Logout KEEPS the cached identity (stored_email/stored_phone), so this is a
      // RETURNING user — route to the mode-aware login entry (email → email login;
      // phone → passcode lock), not a hardcoded passcode lock (wrong for email).
      Get.offAllNamed(AppRoutes.loginEntry);
    } catch (_) {
      // Never let a logout failure crash the app shell.
    } finally {
      _loggingOut = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.inactive:
        // Stamp once; don't overwrite an earlier pause with a later inactive.
        _backgroundedAt ??= DateTime.now();
        _timer?.cancel();
        break;
      case AppLifecycleState.resumed:
        final since = _backgroundedAt;
        _backgroundedAt = null;
        if (!_isAuthenticated) break;
        // Auto-logout disabled (timeout 0) → never log out on resume; just
        // refresh. (Guard needed: diff >= Duration.zero is always true.)
        if (_timeout.inSeconds > 0 &&
            since != null &&
            DateTime.now().difference(since) >= _timeout) {
          _onInactive();
        } else {
          _armTimer();
          _refreshOnResume();
        }
        break;
      case AppLifecycleState.detached:
        _timer?.cancel();
        break;
    }
  }

  // Folds in the "refresh state on resume" requirement: re-pull the active
  // user's account summaries (balances + dashboard cards) when returning to the
  // foreground within the inactivity window. Best-effort; never throws into UI.
  void _refreshOnResume() {
    try {
      final s = _auth.state;
      final userId = s is AuthenticationSuccess
          ? s.profile.userId
          : (s is AuthenticationAuthenticated ? s.profile.userId : null);
      if (userId == null || userId.isEmpty) return;
      if (serviceLocator.isRegistered<AccountCardsSummaryCubit>()) {
        serviceLocator<AccountCardsSummaryCubit>()
            .fetchAccountSummaries(userId: userId);
      }
    } catch (_) {
      // Refresh is best-effort.
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      // Arm on login, cancel on logout / auth screens.
      listener: (_, state) {
        if (_authed(state)) {
          _armTimer();
        } else {
          _timer?.cancel();
        }
      },
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _onUserInteraction,
        onPointerMove: _onUserInteraction,
        onPointerSignal: _onUserInteraction,
        child: widget.child,
      ),
    );
  }
}
