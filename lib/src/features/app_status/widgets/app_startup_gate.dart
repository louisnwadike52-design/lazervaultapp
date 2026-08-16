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

  bool _backendUnhealthy = false;
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

  Future<void> _run() async {
    if (_running) return;
    _running = true;
    try {
      // 1) Backend health (background). The maintenance overlay is shown ONLY
      //    when we're on a pre-login screen AND the device has connectivity AND
      //    the edge is unreachable — i.e. a real server outage blocking sign-in,
      //    not the user's flaky network and never over a logged-in session.
      if (!_isPreLoginScreen()) {
        if (_backendUnhealthy) setState(() => _backendUnhealthy = false);
      } else {
        final healthy = await _serverStatus.isBackendHealthy();
        if (!mounted) return;
        final unhealthy = !healthy && await _deviceOnline() && _isPreLoginScreen();
        if (!mounted) return;
        if (unhealthy != _backendUnhealthy) {
          setState(() => _backendUnhealthy = unhealthy);
        }
        if (unhealthy) return; // edge down on an auth screen — skip update check
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
        if (_backendUnhealthy && _isPreLoginScreen())
          Positioned.fill(child: MaintenanceModal(onRetry: _run)),
      ],
    );
  }
}
