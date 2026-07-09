import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_state.dart';

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

  // Auto-logout DISABLED for now (per request). Forcing 0 makes _armTimer
  // never arm the inactivity timer and the resume path never log out,
  // regardless of the backend-provided `session_inactivity_logout_seconds`.
  // To re-enable, restore:
  //   Duration(seconds: endpointRegistry.inactivityTimeoutSeconds);
  Duration get _timeout => Duration.zero;

  // An active voice-agent session counts as activity: while the voice bottom
  // sheet / LiveKit session is engaged the user may be hands-free (speaking, or
  // the agent is processing/awaiting PIN), so we must NOT auto-logout. Treat any
  // VoiceSessionCubit state other than the clearly-idle/terminal ones as active.
  bool get _voiceActive {
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
      return false; // Cubit not in scope → treat as not-active.
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _armTimer() {
    _timer?.cancel();
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
    // Defer logout while a voice session is active — re-arm and check again
    // after the next window instead of logging the user out mid-call.
    if (_voiceActive) {
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
