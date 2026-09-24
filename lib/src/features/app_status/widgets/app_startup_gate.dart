import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/server_status_service.dart';
import 'package:lazervault/core/services/app_update_service.dart';
import 'package:lazervault/src/features/app_update/widgets/forced_update_screen.dart';
import 'package:lazervault/src/features/app_update/widgets/update_modal.dart';
import 'package:lazervault/src/features/app_status/widgets/maintenance_screen.dart';
import 'package:lazervault/src/features/app_status/widgets/outage_copy.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

/// App-wide startup gate wrapping every route (mounted inside GetMaterialApp so
/// it has Navigator/Overlay/theme). Both of its checks run entirely in the
/// BACKGROUND after the first frame (and again on resume) — they NEVER block
/// app startup or the current screen, whatever loads:
///   1. Backend health: a 2xx from the public root `/health` = up → the app
///      flow continues untouched. Anything else (server down / machine off /
///      Cloudflare 5xx / timeout) overlays a [MaintenanceModal] ON TOP of the
///      current screen (a scrim + card, not a replacement) that auto-dismisses
///      the instant health recovers.
///   2. Store update: reads cached version config (offline-safe, no hot network
///      call), so the check is cheap/background. A build below minimum shows
///      the blocking [ForcedUpdateScreen]; an optional update surfaces the
///      one-time [showUpdateModal] (de-duped per build) over the app.
class AppStartupGate extends StatefulWidget {
  final Widget child;
  const AppStartupGate({super.key, required this.child});

  @override
  State<AppStartupGate> createState() => _AppStartupGateState();
}

class _AppStartupGateState extends State<AppStartupGate>
    with WidgetsBindingObserver {
  final ServerStatusService _serverStatus = ServerStatusService();

  OutageKind? _outage;

  /// When the user last dismissed a connection problem, and which one.
  ///
  /// Without this the dismiss button is decorative: the pre-login poll re-runs
  /// every 10 seconds, still finds no internet, and puts the card straight back.
  /// The user would tap "Later", watch it reappear, and reasonably conclude the
  /// button does nothing.
  ///
  /// Only a CONNECTION problem is dismissible, so only that needs remembering.
  /// A server outage holds the screen until it clears, which it does on its own.
  DateTime? _outageDismissedAt;
  OutageKind? _outageDismissedKind;

  /// How long a dismissal holds.
  ///
  /// Long enough to go and fix the connection — turn data on, move, top up a
  /// bundle — without the card interrupting, and short enough that someone who
  /// forgets is reminded rather than left staring at a sign-in screen that
  /// silently cannot work.
  static const Duration _dismissHold = Duration(minutes: 2);
  AppUpdateInfo? _forcedInfo;
  bool _running = false;

  // Lightweight poll so that if the edge goes down WHILE the user sits on an
  // auth screen (never resuming the app), the maintenance modal still appears
  // within a few seconds. Only ticks on a pre-login screen — post-login the
  // gate relies on resume-checks, so a logged-in session never re-probes on a
  // timer (that was the over-popping bug).
  Timer? _poll;
  static const Duration _pollInterval = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _run());
    // An auth flow that just hit a server-unreachable failure can poke this to
    // make us re-probe immediately (we still confirm with a real health check).
    ServerHealthNotifier.instance.addListener(_onPoke);
    _poll = Timer.periodic(_pollInterval, (_) {
      if (_isPreLoginScreen()) _run();
    });
  }

  void _onPoke() {
    if (_isPreLoginScreen()) _run();
  }

  @override
  void dispose() {
    _poll?.cancel();
    ServerHealthNotifier.instance.removeListener(_onPoke);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-check when the user returns to the app (a deploy/outage may have
    // happened, or an update may have shipped, while they were away).
    if (state == AppLifecycleState.resumed) _run();
  }

  // True once the user has an authenticated session. The maintenance overlay is
  // meaningless post-login, so this is the primary guard — read from the SAME
  // AuthenticationCubit the rest of the app uses (mirrors InactivityWatcher /
  // PendingChatNavigation). It is authoritative regardless of the route name.
  bool _isAuthenticated() {
    try {
      final s = serviceLocator<AuthenticationCubit>().state;
      return s is AuthenticationSuccess || s is AuthenticationAuthenticated;
    } catch (_) {
      return false; // DI/cubit not ready yet → treat as not-yet-authenticated
    }
  }

  // The maintenance overlay is ONLY meaningful pre-login: it explains you can't
  // sign in because the backend edge is down. Once the user is authenticated the
  // app runs on cached data and per-request failures surface inline/as snackbars
  // — a global "server under maintenance" overlay there is wrong AND fires on the
  // user's own flaky network.
  //
  // Auth state is checked FIRST (and wins) because the route heuristic alone is
  // unreliable: screens pushed via a bare `Navigator.push`/`MaterialPageRoute`
  // (e.g. Plan My Day off the Lifestyle tab) have no GetX route name, so
  // `Get.currentRoute` is empty — which the `r.isEmpty` clause below would else
  // misread as the transient boot route and pop maintenance over a logged-in
  // screen. The route clauses only matter while NOT authenticated (real
  // auth/onboarding/boot).
  bool _isPreLoginScreen() {
    if (_isAuthenticated()) return false;
    final r = Get.currentRoute;
    return r.isEmpty ||
        r == '/' ||
        r.startsWith('/auth/') ||
        r == AppRoutes.onboarding;
  }

  /// The create-an-account flow, where the user has nothing with us yet and the
  /// "your money and data are safe" reassurance is meaningless.
  ///
  /// A fixed set rather than a prefix: `/auth/` also covers signing IN, changing
  /// a passcode and 2FA, where that reassurance is exactly right. If a new
  /// signup step is added and not listed here it falls back to the sign-in copy,
  /// which is the behaviour this replaced — so drift degrades, it does not break.
  static const Set<String> _signUpRoutes = <String>{
    AppRoutes.signUp,
    AppRoutes.selectCountry,
    AppRoutes.phoneEntry,
    AppRoutes.phoneOtp,
    AppRoutes.phonePersonalDetails,
    AppRoutes.phoneEmailVerification,
    AppRoutes.phonePasscodeCreate,
    AppRoutes.emailVerification,
    AppRoutes.passcodeSetup,
    AppRoutes.bvnSignup,
    AppRoutes.onboarding,
  };

  bool _isSignUpFlow() => _signUpRoutes.contains(Get.currentRoute);

  // Distinguishes the USER's connectivity from a SERVER outage: if the device
  // itself has no network, a failed health probe is the user's problem (their
  // API calls will snackbar "no connection"), NOT maintenance. Unknown → assume
  // online so a genuine outage on an auth screen still surfaces.
  Future<bool> _deviceOnline() async {
    try {
      final results = await Connectivity().checkConnectivity();
      return results.any((r) => r != ConnectivityResult.none);
    } catch (_) {
      return true;
    }
  }

  /// Decides WHOSE problem this is, or null when there is no problem.
  ///
  /// The old logic was `!healthy && deviceOnline()`, which asked the wrong
  /// question. `deviceOnline()` reads the radio, and a phone with four bars and
  /// no working data — an exhausted bundle, a captive portal, a broken APN —
  /// answers yes. So every one of those told the user our servers were down.
  Future<OutageKind?> _classifyOutage() async {
    final reach = await _serverStatus.checkReachability();
    if (!mounted) return null;

    switch (reach) {
      case BackendReachability.healthy:
        return null;

      case BackendReachability.serverError:
        // Something answered for us, with a 5xx. Ours, regardless of the
        // device's network — and worth not second-guessing with further probes.
        return OutageKind.server;

      case BackendReachability.unreachable:
        // Ambiguous. The radio check is free and instant, so it goes first: if
        // there is no interface at all, we are certainly not the problem.
        if (!await _deviceOnline()) return OutageKind.connection;
        if (!mounted) return null;
        // Radio says connected, which means nothing on its own. Ask whether the
        // internet is actually reachable, and only claim an outage if it is.
        final internet = await _serverStatus.hasWorkingInternet();
        if (!mounted) return null;
        return internet ? OutageKind.server : OutageKind.connection;
    }
  }

  Future<void> _run() async {
    if (_running) return;
    _running = true;
    try {
      // 1) Backend health (background). The maintenance overlay is shown ONLY
      //    when we're on a pre-login screen AND the device has connectivity AND
      //    the edge is unreachable — i.e. a real server outage blocking sign-in,
      //    not the user's flaky network and never over a logged-in session.
      if (!_isPreLoginScreen()) {
        if (_outage != null) setState(() => _outage = null);
        // Signed in, or off the auth flow entirely — a stale dismissal must not
        // suppress a genuine problem the next time through.
        _outageDismissedAt = null;
        _outageDismissedKind = null;
      } else {
        var outage = await _classifyOutage();
        if (!mounted) return;
        // A dismissed connection problem stays dismissed for a short while. The
        // check is on KIND as well as time, so a connection problem that turns
        // out to be a real outage still surfaces immediately — that one is ours
        // to own and is not dismissible.
        if (outage == OutageKind.connection &&
            _outageDismissedKind == OutageKind.connection &&
            _outageDismissedAt != null &&
            DateTime.now().difference(_outageDismissedAt!) < _dismissHold) {
          outage = null;
        }
        if (outage != _outage) setState(() => _outage = outage);
        if (outage != null) {
          return; // can't reach the backend on an auth screen — skip the
          // update check, which needs the network too.
        }
      }

      // 2) Store-update check (background; reads cached config, offline-safe).
      AppUpdateService service;
      try {
        service = serviceLocator<AppUpdateService>();
      } catch (_) {
        return; // DI not ready — skip; next resume will retry.
      }
      final info = await service.check();
      if (!mounted) return;
      if (info.type == AppUpdateType.forced) {
        setState(() => _forcedInfo = info);
      } else {
        if (_forcedInfo != null) setState(() => _forcedInfo = null);
        if (info.type == AppUpdateType.optional) {
          final should =
              await service.shouldShowOptionalModal(info.latestBuild);
          if (should && mounted) {
            await service.markOptionalModalSeen(info.latestBuild);
            if (mounted) {
              await showUpdateModal(
                context,
                info: info,
                onUpdate: () => service.openStore(info),
              );
            }
          }
        }
      }
    } catch (_) {
      // Never let a startup check crash the shell.
    } finally {
      _running = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // A forced (below-minimum) update legitimately BLOCKS — you can't use an
    // unsupported build — and it's independent of backend health (you update
    // via the store). Everything else renders the normal app, with the
    // maintenance modal overlaid on top when the backend is unhealthy.
    final outage = _outage;
    final copy = outage == null
        ? null
        : OutageCopy.of(outage, isSignUp: _isSignUpFlow());
    final forced = _forcedInfo;
    if (forced != null) {
      return ForcedUpdateScreen(
        info: forced,
        onUpdate: () => serviceLocator<AppUpdateService>().openStore(forced),
      );
    }
    return Stack(
      children: [
        widget.child,
        // Belt-and-suspenders: only ever paint the maintenance overlay on a
        // pre-login screen, even if a stale `_backendUnhealthy` lingers after a
        // route change (the next `_run` on resume reconciles the flag).
        if (outage != null && _isPreLoginScreen())
          Positioned.fill(
            child: MaintenanceModal(
              onRetry: _run,
              icon: copy!.icon,
              title: copy.title,
              message: copy.message,
              // A connection problem may need the user to leave the app to fix
              // it, so it must be closable. A server outage clears itself.
              onClose: copy.dismissible
                  ? () => setState(() {
                        _outageDismissedAt = DateTime.now();
                        _outageDismissedKind = outage;
                        _outage = null;
                      })
                  : null,
            ),
          ),
      ],
    );
  }
}
