// dart:io / device_info_plus were used to pick `.env` vs `.env.prod` by
// physical-vs-emulator detection. The tier is now a build-time decision
// via `--flavor`, so those checks are gone — see `currentAppEnvironment`.

import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/foundation.dart'
    show kDebugMode, kReleaseMode, debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/login_flow_resolver.dart';
// FreshInstallGuard intentionally disabled (see call site below); re-enable the
// import + the clearIfBuildChanged() call together if a stale-state regression returns.
// import 'package:lazervault/core/services/fresh_install_guard.dart';
import 'package:lazervault/core/notifications/notification_navigator.dart';
import 'package:lazervault/core/services/pending_chat_navigation.dart';
import 'package:lazervault/core/services/chat_sound_settings.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/data/datasources/cms_data.dart';
import 'package:lazervault/src/features/app_status/widgets/app_startup_gate.dart';
import 'package:lazervault/src/features/presentation/app_router.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'core/services/endpoint_registry.dart';
import 'core/services/inactivity_watcher.dart';
import 'core/services/remote_log_sink.dart';
import 'src/core/services/analytics_service.dart';
import 'src/core/config/app_environment.dart'
    show currentAppEnvironment, resolvedFlavor;
import 'core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'core/services/secure_storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/services/push_notifications_service.dart';
import 'src/features/authentication/cubit/authentication_cubit.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/database/database_helper.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/data/datasources/recipient_verification_grpc_datasource.dart';
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments_grpc;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/contacts/presentation/cubit/contact_sync_cubit.dart';
import 'package:lazervault/src/features/multi_country/cubit/multi_country_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
// device_info_plus dropped — tier identity is build-time now (see above).
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/quick_actions_service.dart';
import 'package:lazervault/core/services/panic_balance_service.dart';
import 'package:lazervault/src/core/services/deep_link_service.dart';
import 'dart:async';
part 'main_widgets.dart';


Future<void> _checkPermissions() async {
  var status = await Permission.bluetooth.request();
  if (status.isPermanentlyDenied) {
    print('Bluetooth Permission disabled');
  }
  status = await Permission.bluetoothConnect.request();
  if (status.isPermanentlyDenied) {
    print('Bluetooth Connect Permission disabled');
  }
}

Future<void> _initializeAndroidAudioSettings() async {
  await webrtc.WebRTC.initialize(options: {
    'androidAudioConfiguration': webrtc.AndroidAudioConfiguration.communication.toMap()
  });
  webrtc.Helper.setAndroidAudioConfiguration(
      webrtc.AndroidAudioConfiguration.communication);
}

void main() {
  // Run the whole app inside a guarded zone so uncaught async ("zone") errors
  // and Flutter framework errors are routed to telemetry (→ Prometheus
  // app_runtime_errors_total → Grafana). Best-effort: telemetry never blocks.
  runZonedGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();

  // FRESH-INSTALL GUARD — DISABLED. This wiped ALL local storage on every build
  // change to purge a leftover DEV session/endpoint. The real cause (a mis-baked
  // FLUTTER_FLAVOR silently defaulting to dev) is now fixed at the source
  // (app_environment.dart resolves fail-closed to prod in release), so the
  // blanket wipe is no longer needed — and it forced users to re-login and lose
  // cached state on every app update. Left in place (no-op) so it can be
  // re-enabled quickly if a stale-state regression ever reappears.
  // await FreshInstallGuard.clearIfBuildChanged();

  // PROD hygiene: silence ALL raw debugPrint output in release builds so debug
  // logs never leak to logcat / the Xcode console on store devices. This
  // no-ops every debugPrint() call app-wide in one place — safer than deleting
  // ~286 scattered (often multi-line) debug statements. Structured logging is
  // unaffected: AppLogger.info/warn/error still ship to Loki for observability,
  // and errors ALWAYS do (RemoteLogSink bypasses the enable gate for errors).
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  // Framework (build/layout/paint) errors → telemetry, after the default handler
  // (which still prints to the console / red screen in debug).
  final priorFlutterOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    priorFlutterOnError?.call(details);
    AnalyticsService.instance.trackRuntimeError(kind: 'flutter_error');
    // Ship the actual error text + stack to Loki so a crash on a store device
    // is readable, not just an aggregate counter. Fail-silent.
    RemoteLogSink.instance.log(
      level: 'error',
      flow: 'crash',
      message: details.exceptionAsString(),
      fields: {
        'kind': 'flutter_error',
        'library': details.library ?? '',
        'stack': details.stack?.toString() ?? '',
      },
    );
  };

  // Uncaught PLATFORM-dispatched errors (outside the guarded zone / framework).
  // Log then keep running — consistent with the zone handler's "last-resort net"
  // philosophy below (the app already survives uncaught zone errors).
  final priorPlatformOnError = PlatformDispatcher.instance.onError;
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    AnalyticsService.instance.trackRuntimeError(kind: 'platform_error');
    RemoteLogSink.instance.log(
      level: 'error',
      flow: 'crash',
      message: error.toString(),
      fields: {'kind': 'platform_error', 'stack': stack.toString()},
    );
    return priorPlatformOnError?.call(error, stack) ?? true;
  };

  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // Single source of truth: always load `.env`. Per-tier source files
  // (`.env.dev`, `.env.staging`, `.env.prod`) live alongside as the
  // editable origin; `scripts/use-env.sh <tier>` copies the right one
  // OVER `.env` before each build. This mirrors how the Go backend's
  // `scripts/sync-env.sh` flips per-service `.env` files.
  final tierName = currentAppEnvironment.tierName; // 'dev' / 'staging' / 'prod'
  print("Build tier: $tierName, env source: .env "
      "(populate via scripts/use-env.sh $tierName)");

  try {
    await dotenv.load(fileName: '.env');
    print(".env file loaded successfully.");
  } catch (e) {
    print("WARNING: could not load .env: $e — using compiled-in defaults.");
  }

  // PROD LEAK GUARD (defense-in-depth; the enforced gate is scripts/use-env.sh).
  // A prod build must talk ONLY to api.lazervault.app. dotenv host values OVERRIDE
  // the compiled prod tier, so if a dev/localhost host leaked into the bundled
  // .env, surface it. assert() catches it in debug/CI; release NEVER crashes on
  // startup — it only logs, so a leak is visible in telemetry without an outage.
  if (currentAppEnvironment.isProduction) {
    const forbidden = <String>[
      '10.0.2.2', '127.0.0.1', 'localhost',
      'dev.lazervault.app', 'staging.lazervault.app', '.run.app',
    ];
    final leaks = dotenv.env.entries
        .where((e) => forbidden.any((f) => e.value.contains(f)))
        .map((e) => e.key)
        .toList();
    if (leaks.isNotEmpty) {
      print('🚨 PROD ENV LEAK — non-prod host in .env keys: $leaks '
          '(production must use api.lazervault.app only)');
      assert(leaks.isEmpty,
          'PROD build shipped dev/localhost hosts in .env keys: $leaks');
    }
  }

  // Initialise the backend URL registry BEFORE dependency injection so
  // every grpc/http/ws factory reads the already-cached URLs on first
  // construction. The call is fast (single SharedPreferences read) and
  // never blocks on the network — the background refresh fires off
  // asynchronously and updates the cache for the NEXT cold start.
  await endpointRegistry.ensureReady();

  // Start the remote log sink now that the URL registry + admin flags are
  // cached — it reads the client-logs endpoint + gating from there. This makes
  // AppLogger + the crash handlers above start shipping to Loki. Fast (a
  // SharedPreferences read + package info); never blocks on the network.
  // Telemetry is FULLY non-blocking: init runs fire-and-forget (its identity
  // reads happen off the startup critical path), log() is a synchronous in-memory
  // enqueue, and network shipping is a background Timer with timeouts. Nothing
  // here can stall or break the Flutter main thread / UI.
  unawaited(RemoteLogSink.instance.init());

  // STARTUP TRACE → Loki: record the COMPILED tier and the exact backend host this
  // build will dial, so we can confirm SERVER-SIDE whether an installed build is
  // genuinely prod or dev (diagnosing "new build still points to dev"). Uses
  // level:error because RemoteLogSink always ships errors (bypasses the enable
  // gate + release-mode debugPrint silencing). Also printed for `adb logcat`.
  try {
    // Raw compile-time define — empty when the --dart-define failed to bake
    // (the historical "prod build still hit dev" mode). `resolvedFlavor` shows
    // what the fail-closed logic settled on; comparing the two + kReleaseMode
    // pinpoints a mis-bake directly from `adb logcat` / Console.app.
    const flavorDefine = String.fromEnvironment('FLUTTER_FLAVOR');
    final startupTrace = 'tier=${currentAppEnvironment.tierName} '
        'flavorDefine=${flavorDefine.isEmpty ? '(empty)' : flavorDefine} '
        'resolvedFlavor=$resolvedFlavor '
        'releaseMode=$kReleaseMode '
        'grpc_base=${endpointRegistry.grpcBase} '
        'grpc_host=${endpointRegistry.grpcHost} '
        'environment=${dotenv.env['ENVIRONMENT'] ?? '?'}';
    print('🔎 STARTUP TRACE: $startupTrace');
    RemoteLogSink.instance.log(
      level: 'error',
      flow: 'startup_trace',
      message: startupTrace,
      fields: {
        'tier': currentAppEnvironment.tierName,
        'flavor_define': flavorDefine,
        'resolved_flavor': resolvedFlavor,
        'release_mode': kReleaseMode,
        'grpc_base': endpointRegistry.grpcBase,
        'grpc_host': endpointRegistry.grpcHost,
        'environment': dotenv.env['ENVIRONMENT'] ?? '',
      },
    );
  } catch (_) {/* diagnostics must never block startup */}

  // Hydrate the feature-flag cache from SharedPreferences before any widget
  // reads a synchronous flag (e.g. dashboard's `FeatureFlags.dashboardCardsVisible`).
  // The admin-side refresh that bulk-updates flags via
  // `FeatureFlags.applyRemoteSnapshot` rides on top of this baseline.
  await FeatureFlags.init();
  // Hydrate admin-toggled flags from the endpoint registry's cached snapshot
  // (same /internal/voice-agents/settings poll that feeds the URL cache). On a
  // brand-new install the keys aren't cached yet, so flags hold their safe
  // OFF default until the first background refresh + next launch.
  await FeatureFlags.applyRemoteSnapshot(endpointRegistry.nonUrlSnapshot());
  // NOTE: the Send Funds flow pin is loaded from storage inside FeatureFlags.init
  // above (instant, offline routing with the last-known value). It is re-resolved
  // + re-persisted on the next login/session-revalidation (authentication_cubit),
  // so we deliberately do NOT recompute it here at boot.

  // Hydrate P2P chat sound/vibration preferences so the first outgoing message
  // fires the correct (per-chat or global) feedback without a cold read.
  await ChatSoundSettings.instance.init();

  // Initialize dependency injection (after env vars are loaded)
  await init();

  // Refresh the platform auth mode from the authoritative GET /auth/config
  // BEFORE boot routing, so an admin flip (email_password ⇄ phone_passcode)
  // takes effect on the very NEXT launch rather than the one after. Capped with
  // a short timeout and falls back to the cached value (hydrated above from the
  // settings poll) so a slow/absent network never blocks startup.
  // Give the authoritative fetch enough time to survive a cold/just-recreated
  // gRPC channel (a 2.5s cap frequently timed out on the first call after a
  // channel reset and left boot routing on a STALE cached auth_mode — e.g. the
  // email screen showing while the backend is in phone_passcode mode). 5s still
  // falls back to the cached value if the network is genuinely down.
  try {
    final res = await serviceLocator<IAuthRepository>()
        .getAuthenticationMode()
        .timeout(const Duration(milliseconds: 5000));
    await res.fold(
      (_) async {/* keep cached value */},
      (mode) => FeatureFlags.setAuthenticationMode(mode),
    );
  } catch (_) {/* best-effort — boot routing uses the cached value */}

  // Resolve the SINGLE canonical login flow once, offline, before routing. If it
  // was never cached (fresh install or first launch after this change), seed it
  // from the legacy secure-storage signals so an existing account still lands on
  // the correct screen without a network call. Every login/signup site then
  // reads FeatureFlags.loginFlow — no more per-site re-derivation / flip-flop.
  try {
    await LoginFlowResolver.seedFromLegacyIfUnset();
  } catch (_) {/* default (phone_passcode) applies */}

  // Hydrate the panic-balance decoy state from local storage BEFORE the first
  // balance render, so a previously-triggered decoy is restored on cold start.
  await serviceLocator<PanicBalanceService>().init();

  // Build the theme controller from the cached dark-mode flag BEFORE the first
  // frame so the app opens in the correct theme (instant, offline).
  final themeController =
      await ThemeController.create(serviceLocator<SecureStorageService>());
  if (serviceLocator.isRegistered<ThemeController>()) {
    serviceLocator.unregister<ThemeController>();
  }
  serviceLocator.registerSingleton<ThemeController>(themeController);

  // Initialize the database
  final dbHelper = DatabaseHelper();
  await dbHelper.database;

  // Initialize push notifications (Firebase + FCM). Fire-and-forget so we don't
  // block first frame on permission prompts or token retrieval — the token is
  // re-registered post-login via authentication_cubit.
  //
  // Every tapped push routes through NotificationRouteResolver, which is the
  // single mapping shared with the in-app feed, universal links and the
  // server's email/SMS links. This used to be a hand-written if-chain covering
  // four types out of roughly sixty; everything else landed on the dashboard,
  // so most notifications told the user something had happened and then made
  // them go find it.
  //
  // PendingDeepLink owns the timing: it routes immediately when there is a
  // session and a navigator, and otherwise stashes the destination until the
  // dashboard consumes it after login.
  final pushSvc = serviceLocator<PushNotificationsService>();
  pushSvc.onMessageTap = (m) {
    final type = m.data['type']?.toString() ?? '';

    // P2P chat keeps its dedicated holder: it carries extra chat-specific state
    // (isSavedRecipient, conversationId) that the chat screen and the message
    // highlight both read, and it is consumed from more places than the
    // dashboard alone.
    if (type == 'p2p_message') {
      PendingChatNavigation.instance.set(
        otherUserId: m.data['sender_user_id']?.toString() ?? '',
        otherUserName: m.data['sender_name']?.toString(),
        conversationId: m.data['conversation_id']?.toString(),
      );
      PendingChatNavigation.instance.consumeAndNavigate();
      return;
    }

    // Unknown types open the feed rather than the dashboard — an older app
    // meeting a newer server must still show the user what buzzed.
    PendingDeepLink.instance.handleOrFeed(type, m.data);
  };
  unawaited(pushSvc.initialize());

  // Permissions + audio settings are fire-and-forget: they don't gate
  // anything on first frame (the permission check just logs on denial;
  // audio init wires WebRTC for voice/video which the user only reaches
  // after navigating into a voice session). Awaiting them here blocked
  // runApp behind a platform permission prompt — in production that's a
  // visible "blank screen for 1-2s" UX papercut; in integration tests
  // there's no UI for the prompt at all, so the await never resolves
  // and the GetMaterialApp/Navigator never mounts. unawaited() lets the
  // splash → home transition land on first frame and the perm prompt
  // appears alongside the home UI as it should.
  unawaited(_checkPermissions());
  unawaited(_initializeAndroidAudioSettings());

  // Set global status bar style for dark screens
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Resolve the destination BEFORE mounting any Flutter UI. The native
  // splash stays visible behind us during this read — there is no
  // separate Flutter splash widget. As soon as we know where the user
  // belongs (dashboard / sign-in / onboarding / passcode), MyApp mounts
  // that route directly, and the native splash is dismissed on the
  // first frame the destination paints. Net effect: ONE splash, no
  // visible handoff.
  final initialRoute = await _determineInitialRoute();

  runApp(MyApp(initialRoute: initialRoute));

  // Flush buffered Loki logs when the app is backgrounded/detached so
  // breadcrumbs land before the OS may freeze the process. Kept alive by the
  // top-level [_logLifecycleListener] reference.
  _logLifecycleListener = AppLifecycleListener(
    onPause: () => RemoteLogSink.instance.flushNow(),
    onDetach: () => RemoteLogSink.instance.flushNow(),
  );

  // Initialize app icon quick actions (long-press shortcuts)
  QuickActionsService.instance.initialize();

  // Process any pending quick action shortcut that launched the app.
  // (Previously this fired inside SplashScreen.initState; with the
  // splash removed it lands here so the shortcut still gets honoured.)
  QuickActionsService.instance.processPendingShortcut();
  }, (Object error, StackTrace stack) {
    // Uncaught async error escaped to the zone — record and swallow (the app
    // keeps running; this is the last-resort net, not a crash handler).
    AnalyticsService.instance.trackRuntimeError(kind: 'zone_error');
    RemoteLogSink.instance.log(
      level: 'error',
      flow: 'crash',
      message: error.toString(),
      fields: {'kind': 'zone_error', 'stack': stack.toString()},
    );
    if (kDebugMode) {
      // ignore: avoid_print
      print('Uncaught zone error: $error\n$stack');
    }
  });
}

/// Keeps the app-lifecycle listener that flushes Loki logs on pause alive for
/// the process lifetime (an unreferenced [AppLifecycleListener] would be GC'd).
// ignore: unused_element
AppLifecycleListener? _logLifecycleListener;

/// Helper function to determine the initial route based on authentication status
/// IMPORTANT: Users must authenticate on every app restart for security
Future<String> _determineInitialRoute() async {
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  try {
    // DEVELOPMENT: Check if we should force onboarding (for testing fresh install)
    // Set 'force_onboarding' to 'true' in secure storage to reset onboarding
    final forceOnboarding = await storage.read(key: 'force_onboarding');
    if (forceOnboarding == 'true') {
      // Clear the flag so it only happens once
      await storage.delete(key: 'force_onboarding');
      await storage.delete(key: 'has_seen_onboarding');
      await storage.delete(key: 'user_id');
      await storage.delete(key: 'stored_email');
      await storage.delete(key: 'login_method');
      await storage.delete(key: 'has_incomplete_signup');
      await storage.delete(key: 'signup_draft');
      await storage.delete(key: 'current_signup_step');
      print('🔄 Onboarding reset for development — routing to the fresh-user entry');
      // Intro onboarding carousel removed — fall through to the normal fresh-user
      // routing below (phone signup / email sign-in) rather than a slides screen.
    }

    // NOTE: the intro onboarding carousel has been removed. First-time users are
    // no longer shown slides; they fall through to the brand-new-user routing at
    // the end of this function (phone signup in phone+passcode mode, email
    // sign-in otherwise).

    // SELF-LOCK / EMERGENCY LOCK: arming the lock wipes the cached identity
    // (clearAll) and writes this local deadline mirror. While it's still in the
    // future, route STRAIGHT to the mode's login screen — which shows the live
    // countdown modal on arrival — bypassing the onboarding/fresh routing below
    // (which would otherwise land a locked user on the carousel because clearAll
    // also wiped has_seen_onboarding). Self-clears once elapsed. The backend login
    // gate remains the real enforcement; this is the proactive reflection.
    final selfLockRaw = await storage.read(key: 'self_lock_until');
    if (selfLockRaw != null && selfLockRaw.isNotEmpty) {
      final until = DateTime.tryParse(selfLockRaw);
      if (until != null && until.toUtc().isAfter(DateTime.now().toUtc())) {
        print('🔒 Account self-locked until $until — routing to login for the lock countdown');
        return AppRoutes.freshLoginEntry;
      }
      // Elapsed or unparseable — drop the stale mirror and continue normally.
      await storage.delete(key: 'self_lock_until');
    }

    // Read stored auth/session state up front.
    final loginMethod = await storage.read(key: 'login_method');
    final storedEmail = await storage.read(key: 'stored_email');
    final storedPhone = await storage.read(key: 'stored_phone');
    final userId = await storage.read(key: 'user_id');
    final hasIncompleteSignup = await storage.read(key: 'has_incomplete_signup');
    final currentSignupStep = await storage.read(key: 'current_signup_step');
    final onboardingAuthType = await storage.read(key: 'onboarding_auth_type');
    // User-selectable login-method preference (set in Settings, mirrored from
    // GetMe/login). Overrides the platform default; see the explicit check below.
    final preferredLoginMethod = await storage.read(key: 'preferred_login_method');

    // Resume a GENUINE in-progress phone+passcode signup BEFORE the per-account
    // login checks, so quitting mid-signup returns the user to where they left
    // off even on a device that also holds a previously-completed account. Gated
    // on a REAL draft (a verified token, a recorded skip, or an active OTP step)
    // so a stale `has_incomplete_signup` flag still falls through to login.
    if (hasIncompleteSignup == 'true' &&
        onboardingAuthType == 'PHONE_PASSCODE' &&
        currentSignupStep != null) {
      final phoneDraft = await storage.read(key: 'phone_signup_phone');
      final phoneToken = await storage.read(key: 'phone_signup_token');
      final phoneSkipped = await storage.read(key: 'phone_signup_skipped');
      final hasRealDraft = (phoneDraft?.isNotEmpty ?? false) &&
          ((phoneToken?.isNotEmpty ?? false) ||
              phoneSkipped == 'true' ||
              currentSignupStep == 'phone_otp');
      if (hasRealDraft) {
        print('📲 Resuming in-progress phone signup at $currentSignupStep');
        final phoneRoute =
            await _getRouteForPhoneSignupStep(storage, currentSignupStep);
        if (phoneRoute != null) return phoneRoute;
      }
    }

    // Resume a GENUINE in-progress EMAIL signup BEFORE the per-account login
    // checks below — a user who quit during email verification / passcode setup
    // must return there, not be sent to a login screen by the stored_email /
    // preferred_login_method that _saveSession writes at account creation. Gated
    // on login_method being ABSENT: a fully-registered account has it set (written
    // only after passcode setup / login), so a returning user with a stale
    // incomplete flag still falls through to the login routing below.
    if (hasIncompleteSignup == 'true' &&
        currentSignupStep != null &&
        onboardingAuthType != 'PHONE_PASSCODE' &&
        (loginMethod == null || loginMethod.isEmpty)) {
      final route = _getRouteForSignupStep(currentSignupStep);
      if (route != null && route != AppRoutes.dashboard) {
        print('📝 Resuming in-progress email signup at $currentSignupStep');
        return route;
      }
    }

    // EXPLICIT PER-USER PREFERENCE (highest priority for a returning account).
    // When the user has deliberately chosen email+password in Settings, honor it
    // over the passcode-first routing below — "force email_password and not
    // passcode". The email sign-in screen still offers "Use passcode instead" as
    // a fallback. A stored 'phone_passcode' preference simply falls through to
    // the passcode routing. This only fires for an established account (has a
    // stored identifier), so fresh users still get onboarding.
    if (preferredLoginMethod == 'email_password' &&
        ((storedEmail != null && storedEmail.isNotEmpty) ||
            (storedPhone != null && storedPhone.isNotEmpty) ||
            (userId != null && userId.isNotEmpty))) {
      print('🔐 User forced email+password login → email sign-in');
      return AppRoutes.emailSignIn;
    }
    // Symmetric branch: an explicit phone+passcode preference routes to the
    // passcode login screen (the backend guarantees a passcode exists before it
    // lets a user pick this method, so we don't strand them). Requires a stored
    // identifier so a fresh user still gets onboarding.
    if (preferredLoginMethod == 'phone_passcode' &&
        ((storedEmail != null && storedEmail.isNotEmpty) ||
            (storedPhone != null && storedPhone.isNotEmpty))) {
      print('🔐 User forced phone+passcode login → passcode login');
      return AppRoutes.passcodeLogin;
    }

    // PHONE+PASSCODE accounts log in via the SAME passcode login screen as
    // email/passcode accounts (the canonical dark "Enter your Passcode"
    // screen). Because email is required at phone signup, the account has a
    // stored email + passcode, so the shared passcode login authenticates them
    // unchanged — no separate phone field on the login screen. Checked here
    // (login_method survives logout) so phone accounts aren't bounced into the
    // email flow.
    if (loginMethod == 'phone_passcode' &&
        storedPhone != null &&
        storedPhone.isNotEmpty) {
      print('🔐 Phone+passcode account → passcode login screen');
      return AppRoutes.passcodeLogin;
    }

    // HIGHEST PRIORITY (after onboarding): a user who has a passcode credential
    // has, by definition, already completed signup. Always send them to passcode
    // login — even if a stale `has_incomplete_signup` draft flag was left behind
    // — so a returning, logged-in user is never bounced back into the signup
    // flow (the bug this guards against).
    // Note: userId may be null after logout (cleared by _clearSession), but
    // passcode login only needs stored_email + passcode to authenticate.
    if (loginMethod == 'passcode' &&
        storedEmail != null &&
        storedEmail.isNotEmpty) {
      print('🔐 User has passcode login configured, redirecting to passcode login');
      return AppRoutes.passcodeLogin;
    }

    // Check for incomplete signup (local draft) — only reached for users who
    // have NOT yet established a passcode credential. (A genuine in-progress
    // PHONE signup is already handled by the early-resume block above; this
    // covers the EMAIL flow and any phone draft that fell through.)
    if (hasIncompleteSignup == 'true' && currentSignupStep != null) {
      // Resume using the auth type PINNED when the journey started, so an admin
      // flipping the platform auth_mode mid-onboarding can't switch an
      // in-progress user between the email and phone flows.
      print('📝 Found incomplete signup at step: $currentSignupStep');
      if (onboardingAuthType == 'PHONE_PASSCODE') {
        final phoneRoute =
            await _getRouteForPhoneSignupStep(storage, currentSignupStep);
        if (phoneRoute != null) {
          return phoneRoute;
        }
      }
      final route = _getRouteForSignupStep(currentSignupStep);
      if (route != null) {
        return route;
      }
    }

    // If user was previously logged in but no passcode, go to email sign in
    // This ensures they re-authenticate with email/password
    if (userId != null && userId.isNotEmpty) {
      // Check if user needs KYC onboarding (just completed signup, hasn't skipped)
      final hasSkippedKyc = await storage.read(key: 'has_skipped_kyc');
      final kycOnboardingPending = await storage.read(key: 'kyc_onboarding_pending');
      if (kycOnboardingPending == 'true' && hasSkippedKyc != 'true') {
        print('📋 KYC onboarding pending - showing progressive KYC');
        return AppRoutes.kycBVNVerification;
      }

      // Re-authenticate via the account's OWN canonical flow (default
      // phone_passcode), not a hardcoded email screen.
      print('🔐 User was previously logged in, requiring re-authentication');
      return AppRoutes.loginEntry;
    }

    // Brand-new / logged-out user with NO stored account: show the intro
    // carousel ONCE per install before the auth entry (the email path then
    // begins with country selection). Reaching here means every returning-user
    // / resume check above already fell through, so this is genuinely a fresh
    // user. Gated by has_seen_onboarding (reset by the force_onboarding dev
    // trigger above); set to 'true' when the carousel finishes or is skipped.
    final hasSeenOnboarding = await storage.read(key: 'has_seen_onboarding');
    if (hasSeenOnboarding != 'true') {
      print('🎠 First launch — showing onboarding carousel');
      return AppRoutes.onboarding;
    }

    // Fresh user: follow the canonical flow (default phone_passcode → phone
    // signup; email_password → email sign-in landing with its sign-up link).
    if (!FeatureFlags.isEmailPasswordLogin) {
      print('📱 Phone+passcode flow — starting phone signup');
      return AppRoutes.phoneEntry;
    }
    return AppRoutes.emailSignIn;
  } catch (e) {
    print('Error determining initial route: $e');
    // On any failure, fall back to the canonical flow (default phone_passcode)
    // instead of a hardcoded email screen, so behavior is consistent.
    return AppRoutes.loginEntry;
  }
}

/// Map a persisted phone-onboarding step to its resume route. The PASSCODE is
/// never persisted (security), so any resume past OTP verification must return
/// the user to passcode creation rather than the details screen (which would
/// otherwise have no passcode to submit). Gated on proof of the phone — a
/// verified signup token OR a recorded "skip" — else we restart phone entry.
/// Returns null for unknown steps so the caller falls through to the email map.
Future<String?> _getRouteForPhoneSignupStep(
    FlutterSecureStorage storage, String? step) async {
  final hasPhone =
      (await storage.read(key: 'phone_signup_phone'))?.isNotEmpty ?? false;
  final hasToken =
      (await storage.read(key: 'phone_signup_token'))?.isNotEmpty ?? false;
  final skipped = (await storage.read(key: 'phone_signup_skipped')) == 'true';
  switch (step) {
    case 'phone_otp':
      // Still verifying — resume at the OTP screen (the user can resend if the
      // code has lapsed). No phone draft → restart entry.
      return hasPhone ? AppRoutes.phoneOtp : AppRoutes.phoneEntry;
    case 'phone_passcode_create':
    case 'phone_personal_details':
    // The former separate optional-email step is merged into details.
    case 'phone_optional_email':
      return (hasToken || skipped)
          ? AppRoutes.phonePasscodeCreate
          : AppRoutes.phoneEntry;
    default:
      return null;
  }
}

/// Get the appropriate route for a signup step
String? _getRouteForSignupStep(String? step) {
  if (step == null) return null;

  switch (step) {
    case 'form_page_0':
    case 'form_page_1':
      return AppRoutes.signUp; // Resume signup form
    case 'account_created':
    case 'email_verify':
      return AppRoutes.emailVerification; // Resume email verification
    case 'phone_verify':
      return AppRoutes.phoneVerification; // Resume phone verification
    case 'passcode_setup':
      return AppRoutes.passcodeSetup; // Resume passcode setup
    case 'complete':
      return AppRoutes.dashboard; // Signup complete, go to dashboard
    default:
      return null;
  }
}

class MyApp extends StatefulWidget {
  /// The resolved boot route. Determined synchronously by main() BEFORE
  /// runApp so the native splash stays visible through the read and the
  /// app boots straight onto the user's destination — no Flutter splash
  /// surface in between.
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<DeepLinkData>? _deepLinkSub;

  @override
  void initState() {
    super.initState();
    _bootstrapDeepLinks();
    // Dismiss the native splash on the first frame the destination
    // screen paints — this is the seam where the OS surface hands off
    // to Flutter rendering. By keeping the native splash up until then,
    // there's no visible "two splash" handoff.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    _deepLinkSub?.cancel();
    super.dispose();
  }

  /// Initializes the global deep-link service and wires the listeners.
  ///
  /// We handle two arrival paths:
  ///   1. **Cold start** — the app was launched by tapping a deep link.
  ///      `getInitialLink()` resolves once after the first frame settles.
  ///   2. **Warm receive** — the app is already running when the OS
  ///      hands us a new URL (foreground/background). `linkStream`
  ///      delivers these in real time.
  ///
  /// On a `familyInvite` URL we navigate to the invitations screen.
  /// If the user is unauthenticated, the auth-check screen still owns
  /// the initial route — they'll see login first and can manually open
  /// the Invitations tab from the dashboard banner once signed in.
  Future<void> _bootstrapDeepLinks() async {
    final svc = DeepLinkService.instance;
    if (!svc.isInitialized) {
      await svc.initialize();
    }
    _deepLinkSub = svc.linkStream.listen(_handleDeepLink);

    // Cold-start link: defer navigation to the next frame so GetMaterialApp
    // has finished mounting and Get.toNamed has a navigator to push onto.
    final initial = await svc.getInitialLink();
    if (initial != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleDeepLink(initial);
      });
    }
  }

  void _handleDeepLink(DeepLinkData data) {
    // Notification links (`lazervault://n/<type>?…` and the
    // `https://lazervault.app/n/<type>` universal-link form the server puts in
    // emails and SMS) resolve through the same mapping as a tapped push, so an
    // emailed link and its push open the same page. PendingDeepLink handles the
    // signed-out case: the destination survives the login gate instead of the
    // user landing on the dashboard after signing in.
    final uri = Uri.tryParse(data.rawUri);
    if (uri != null && PendingDeepLink.instance.handleUri(uri)) return;

    switch (data.type) {
      case DeepLinkType.familyInvite:
        // Defer to a post-frame so we don't race the in-flight build.
        // Get.toNamed (rather than offNamed) so the user can navigate
        // back to whatever they were doing if they bail.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          // Token is informational for now — the screen lists all the
          // user's pending invites; the deep-linked one will be there.
          // Future: pass it as args and have the screen highlight/scroll.
          Get.toNamed(
            AppRoutes.familyInvitations,
            arguments: {
              if (data.familyInviteToken != null)
                'invitationToken': data.familyInviteToken,
            },
          );
        });
        break;
      case DeepLinkType.depositCallback:
      case DeepLinkType.paymentCallback:
      case DeepLinkType.quickAction:
      case DeepLinkType.unknown:
        // Handled (or intentionally ignored) elsewhere — depositCallback /
        // paymentCallback are listened to by the respective payment
        // flows; quickAction is handled by QuickActionsService.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (_) => serviceLocator<AuthenticationCubit>(),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => serviceLocator<ProfileCubit>(),
        ),
        BlocProvider<VoiceSessionCubit>(
          create: (_) => serviceLocator<VoiceSessionCubit>(),
        ),
        BlocProvider<AccountCardsSummaryCubit>.value(
          value: serviceLocator<AccountCardsSummaryCubit>(),
        ),
        BlocProvider<BalanceWebSocketCubit>.value(
          value: serviceLocator<BalanceWebSocketCubit>(),
        ),
        BlocProvider<AccountVerificationCubit>(
          create: (_) => AccountVerificationCubit(
            dataSource: RecipientVerificationGrpcDataSource(
              client: serviceLocator<payments_grpc.PaymentsServiceClient>(),
              callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
            ),
          ),
        ),
        BlocProvider<ContactSyncCubit>(
          create: (_) => serviceLocator<ContactSyncCubit>(),
        ),
        BlocProvider<MultiCountryCubit>(
          create: (_) => serviceLocator<MultiCountryCubit>(),
        ),
      ],
      // Responsive width cap: on tablets / large windows, feed ScreenUtilInit a
      // MediaQuery whose WIDTH is capped to [kMaxContentWidth] so the .w/.h
      // scaling stays phone-proportioned instead of blowing up to fill a huge
      // screen. The physical letterboxing happens in the GetMaterialApp.builder
      // below. Phones (width <= cap) pass through untouched.
      child: _MaxWidthMediaQuery(
        maxWidth: kMaxContentWidth,
        child: ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => InactivityWatcher(
          child: GetMaterialApp(
          enableLog: true,
          logWriterCallback: localLogWriter,
          translations: CMSData(),
          fallbackLocale: const Locale('en', 'UK'),
          locale: Get.deviceLocale,
          debugShowCheckedModeBanner: false,
          // Global "tap outside to dismiss the keyboard": tapping any empty area
          // unfocuses the active field and hides the soft keyboard. translucent
          // behaviour means buttons/fields/lists still receive their own taps —
          // only taps that reach empty space trigger the unfocus. Covers every
          // bills-hub input screen (and the rest of the app) in one place.
          builder: (context, child) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            // Startup gate: on launch/resume, show a maintenance screen if the
            // backend is down and prompt for store updates (forced/optional).
            // The app content is letterboxed to a phone-like max width on large
            // screens (tablets, desktop windows) so it never stretches and
            // loses proportion; the gate's own overlays stay full-screen.
            child: AppStartupGate(
              child: _MaxWidthShell(
                maxWidth: kMaxContentWidth,
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          ),
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: serviceLocator<ThemeController>().mode,
          initialRoute: widget.initialRoute,
          unknownRoute: GetPage(
            name: '/not-found',
            // Unknown route → empty purple frame matches the native
            // splash, so a misrouted boot doesn't flash a white screen.
            page: () => const Scaffold(
              backgroundColor: Color(0xFF3D2F8B),
              body: SizedBox.shrink(),
            ),
          ),
          getPages: AppRouter.routes,
          ),
        ),
      ),
      ),
    );
  }
}

void localLogWriter(String text, {bool isError = false}) {
  // pass the message to your favourite logging package here
  // please note that even if enableLog: false log messages will be pushed in this callback
  // you get check the flag if you want through GetConfig.isLogEnable
}

/// The maximum content width the app is laid out at. The UI is phone-first
/// (designSize 414); on tablets / large desktop windows we cap the width here so
/// content stays phone-proportioned and centered instead of stretching edge to
/// edge and losing its dimensions. Slightly wider than the design width for a
/// touch of breathing room on big screens.
const double kMaxContentWidth = 560.0;
