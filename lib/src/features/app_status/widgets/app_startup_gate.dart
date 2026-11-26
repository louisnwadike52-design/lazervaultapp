import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/config/feature_flags.dart';
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
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

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

  /// True while this gate is painting something the user cannot navigate past.
  ///
  /// WHY A FLAG AND NOT A ROUTE CHECK. The two blocking surfaces here are
  /// neither routes nor dialogs: the forced-update screen is returned INSTEAD
  /// of `child` (so the app's Navigator is not even in the tree), and the
  /// maintenance overlay is a `Positioned.fill` inside a Stack. Nothing a
  /// caller can inspect — `Get.currentRoute` still reads whatever it was, and
  /// `Get.isDialogOpen` is false — so a deep-link replay checking either of
  /// those concludes the coast is clear.
  ///
  /// What that cost: a push or a shared link arriving on a build below the
  /// minimum version was resolved, "navigated" into a Navigator that is not
  /// displayed, and CONSUMED from the stash. The user updates, reopens, and
  /// the link is gone — and a user on an outdated build is exactly who gets
  /// sent a link telling them to do something.
  ///
  /// [PendingDeepLink] consults this and defers instead. The stash is on disk,
  /// so the target survives the update and replays afterwards.
  static bool blockingTheScreen = false;

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

  /// Screens where the user is mid-way through typing a one-time code.
  ///
  /// NOTHING OPTIONAL MAY INTERRUPT THESE. Entering an OTP is the one flow in
  /// the app that requires LEAVING it: the code is in a mail app or the SMS
  /// shade, so the user must switch away and come back. That return is exactly
  /// when `didChangeAppLifecycleState(resumed)` fires `_run()`.
  ///
  /// Before 2026-10-31 that was harmless here, because the optional-update
  /// sheet was shown with this widget's own context — which sits ABOVE the
  /// Navigator, so showModalBottomSheet could not find one and threw, and the
  /// throw was swallowed by _run's catch-all. The sheet therefore never
  /// appeared on an auth screen. Switching it to Get.context (deliberately, so
  /// people on unsupported builds are told) made it land for the first time —
  /// and the first screen it lands on is the one the user had to leave the app
  /// to complete.
  ///
  /// From the user's side that reads as the app reloading and scattering the
  /// screen on every return from their inbox, right as they try to paste a
  /// code. A forced update still blocks, because an unsupported build genuinely
  /// cannot be used; an OPTIONAL prompt can wait for literally any other
  /// moment, and `shouldShowOptionalModal` is token-based so deferring it does
  /// not consume it.
  static const Set<String> _oneTimeCodeRoutes = <String>{
    AppRoutes.emailVerification,
    AppRoutes.phoneEmailVerification,
    AppRoutes.phoneOtp,
    AppRoutes.otpVerification,
    AppRoutes.verifyPasswordResetOTP,
  };

  bool _isEnteringOneTimeCode() {
    final r = Get.currentRoute;
    if (_oneTimeCodeRoutes.contains(r)) return true;
    // The login step-up screen is pushed with `Get.to(() => LoginOtpScreen(...))`
    // (phone_passcode_login_screen.dart), so it has no AppRoutes constant —
    // GetX names an anonymous route after the widget, giving `/LoginOtpScreen`.
    // Matching the substring covers it and any future anonymously-pushed code
    // screen, which is the direction this drifts: a named set alone would
    // silently stop protecting a screen the moment someone pushes it that way.
    return r.toLowerCase().contains('otp');
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

  /// Whether the identity cached on this device is on the maintenance
  /// allow-list.
  ///
  /// Reads the CACHED identity rather than a live session, because this gate
  /// runs before login: a tester opening the app during a declared window has
  /// no session yet, and requiring one would make the allow-list useless
  /// exactly when it is needed. The same keys the passcode lock and
  /// LoginFlowResolver use.
  ///
  /// Any failure answers "not whitelisted" — the notice shows. Failing the
  /// other way would let a storage error silently suppress a maintenance
  /// notice for everybody.
  Future<bool> _whitelistedForMaintenance() async {
    if (FeatureFlags.maintenanceWhitelist.isEmpty) return false;
    try {
      const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
          resetOnError: true,
        ),
      );
      final results = await Future.wait([
        storage.read(key: 'stored_email'),
        storage.read(key: 'user_id'),
        storage.read(key: 'stored_phone'),
      ]);
      return FeatureFlags.maintenanceAllows(results);
    } catch (_) {
      return false;
    }
  }

  /// Decides WHOSE problem this is, or null when there is no problem.
  ///
  /// The old logic was `!healthy && deviceOnline()`, which asked the wrong
  /// question. `deviceOnline()` reads the radio, and a phone with four bars and
  /// no working data — an exhausted bundle, a captive portal, a broken APN —
  /// answers yes. So every one of those told the user our servers were down.
  Future<OutageKind?> _classifyOutage() async {
    // A DECLARED window wins, and is checked BEFORE any probe.
    //
    // Probing first would defeat the point: during a planned deploy the backend
    // is usually still answering, so the probe returns healthy and the notice
    // the operator switched on would never appear. It also costs nothing — the
    // flag is already in SharedPreferences from the settings poll, so this is a
    // synchronous read, not a round trip.
    //
    // It does NOT stop money. The gate only runs on launch and resume and only
    // outside an authenticated session (see _isPreLoginScreen), so it cannot
    // interrupt a transfer somebody has already submitted, and every backend
    // worker and reconciler keeps running behind it regardless.
    if (FeatureFlags.maintenanceModeEnabled) {
      // WHITELISTED PEOPLE WALK THROUGH A DECLARED WINDOW.
      //
      // An operator who puts the app behind the notice almost always needs
      // somebody — themselves, a tester, a support responder — still using it
      // to confirm the fix before the notice comes down. The alternative is
      // turning maintenance off for everyone to check one thing.
      //
      // DELIBERATELY ONLY HERE. Every branch below is a MEASURED outage: a
      // 5xx, a timeout, an unreachable host. Being on a list cannot conjure a
      // working backend, so letting someone past those would hand them a
      // broken app with no explanation — strictly worse than the notice. The
      // whitelist is about a decision we made, never about a failure we found.
      if (await _whitelistedForMaintenance()) {
        if (!mounted) return null;
        debugPrint('[startup-gate] maintenance declared, but this identity is '
            'whitelisted — letting them through');
        return null;
      }
      if (!mounted) return null;
      return OutageKind.plannedMaintenance;
    }

    final reach = await _serverStatus.checkReachability();
    if (!mounted) return null;

    switch (reach) {
      case BackendReachability.healthy:
        return null;

      case BackendReachability.serverError:
        // Something answered for us, with a 5xx. Ours, regardless of the
        // device's network — and worth not second-guessing with further probes.
        return OutageKind.server;

      case BackendReachability.timedOut:
        // The link reached far enough to stall rather than refuse. That is the
        // signature of a slow connection, NOT of a dead server, and it is the
        // case that used to be folded into the branch below and reported as
        // "our servers are being updated".
        //
        // The radio check still runs first: a timeout with no interface at all
        // is just being offline by a slower route.
        if (!await _deviceOnline()) return OutageKind.connection;
        if (!mounted) return null;
        // If the small 204 probes also fail, the connection is not merely slow
        // but effectively unusable, which the user reads as being offline.
        final reachableWhileSlow = await _serverStatus.hasWorkingInternet();
        if (!mounted) return null;
        return reachableWhileSlow
            ? OutageKind.slowConnection
            : OutageKind.connection;

      case BackendReachability.unreachable:
        // A HARD failure on every attempt — refused, or no DNS. Ambiguous
        // between our edge being gone and the device having no route at all.
        // The radio check is free and instant, so it goes first: if there is no
        // interface, we are certainly not the problem.
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
        // A TRANSIENT verdict must not cover a one-time-code entry.
        //
        // The user reached this screen and then left the app to fetch the code,
        // so on return the radio is often still re-establishing — which is
        // exactly when a reachability probe reports `connection` or
        // `slowConnection`. Painting a full-screen Positioned.fill modal over
        // the code field at that moment blocks the one action they came back to
        // perform, for a problem that has usually already resolved.
        //
        // `server` and `plannedMaintenance` still show: those are OURS, they are
        // not a false positive from a waking radio, and they genuinely explain
        // why the code cannot be verified.
        if (outage != null &&
            _isEnteringOneTimeCode() &&
            (outage == OutageKind.connection ||
                outage == OutageKind.slowConnection)) {
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
          // Never over a one-time-code entry. Token-based de-duplication means
          // the prompt is NOT consumed by skipping it here: the next resume, or
          // the pre-login poll, shows it once the user is off the code screen.
          if (_isEnteringOneTimeCode()) {
            debugPrint('[startup-gate] update sheet deferred: user is '
                'entering a one-time code');
            return;
          }
          final should = await service.shouldShowOptionalModal(info);
          if (should && mounted) {
            // Get.context, NOT this widget's context.
            //
            // THIS IS WHY THE SHEET ONLY EVER APPEARED AFTER LOGIN. The gate
            // is built inside GetMaterialApp.builder, which wraps the
            // Navigator — so its own context sits ABOVE the Navigator, and
            // showAppBottomSheet(context: thatContext) cannot find one and
            // throws. The throw landed in _run's catch-all, so nothing was
            // logged and nothing appeared; the dashboard's own AppUpdateCubit
            // then showed the sheet post-login with a real route context, and
            // the prompt looked login-gated when it was simply broken here.
            //
            // Get.context is the Navigator's context (the same handle
            // ImpersonationBannerHost uses a few lines up in main.dart), so
            // the sheet renders over whatever route is on screen — including
            // sign-in and sign-up, which is where someone on an unsupported
            // build most needs to be told.
            final navCtx = Get.context;
            // `mounted` on the CONTEXT, not on this State: the context being
            // used belongs to the Navigator, and it is the one that can go
            // away across the awaits above (a route teardown, a logout).
            if (navCtx == null || !navCtx.mounted) {
              // No Navigator yet (very first frames). Leave the prompt
              // UNSEEN so the 10s pre-login poll retries, rather than
              // consuming it.
              debugPrint('[startup-gate] update sheet deferred: no live '
                  'Navigator context yet');
              return;
            }
            try {
              // MARKED WHEN THE SHEET IS PUSHED, NOT WHEN IT CLOSES.
              //
              // THE BUG THIS FIXES, reported 2026-11-10: "the app keeps
              // telling me to update anytime I want to open the app."
              //
              // Marking after the await meant the prompt was only ever spent
              // when the sheet was DISMISSED. A customer who met it on the
              // passcode screen — which is exactly "anytime I open the app" —
              // and killed the app from the task switcher instead of
              // dismissing it never reached the mark, so the same prompt
              // returned on the next launch, and the next, for ever. The app
              // was behaving correctly by its own rules and felt broken.
              //
              // The original reasoning was right and is preserved: a prompt
              // that FAILS TO APPEAR must stay owed rather than be spent (it
              // was once marked before the call, so the context throw above
              // silently consumed it). The mistake was the boundary, not the
              // idea — "closed" and "rendered" are different events, and only
              // the second one is what "the user has seen it" means.
              //
              // showModalBottomSheet pushes its route synchronously and throws
              // synchronously on a bad context. So holding the Future without
              // awaiting it proves the sheet is on screen: if we have a
              // Future, it rendered; if it threw, we are in the catch and
              // nothing is marked. Same protection, correct boundary.
              final shown = showUpdateModal(
                navCtx,
                info: info,
                onUpdate: () => service.openStore(info),
              );
              await service.markOptionalModalSeen(info);
              await shown;
            } catch (e) {
              debugPrint('[startup-gate] update sheet failed to show: $e');
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
      // Assigned here rather than in _run() because this is the question the
      // flag actually answers — "what am I painting right now" — and the
      // maintenance branch below depends on _isPreLoginScreen(), which is only
      // meaningful at build time. A plain assignment of derived state, so it
      // cannot loop.
      AppStartupGate.blockingTheScreen = true;
      return ForcedUpdateScreen(
        info: forced,
        onUpdate: () => serviceLocator<AppUpdateService>().openStore(forced),
      );
    }
    final maintenanceVisible = outage != null && _isPreLoginScreen();
    AppStartupGate.blockingTheScreen = maintenanceVisible;
    return Stack(
      children: [
        widget.child,
        // Belt-and-suspenders: only ever paint the maintenance overlay on a
        // pre-login screen, even if a stale `_backendUnhealthy` lingers after a
        // route change (the next `_run` on resume reconciles the flag).
        if (maintenanceVisible)
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
