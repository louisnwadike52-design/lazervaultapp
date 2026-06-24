// dart:io / device_info_plus were used to pick `.env` vs `.env.prod` by
// physical-vs-emulator detection. The tier is now a build-time decision
// via `--flavor`, so those checks are gone — see `currentAppEnvironment`.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/data/datasources/cms_data.dart';
import 'package:lazervault/src/features/presentation/app_router.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'core/services/endpoint_registry.dart';
import 'core/services/inactivity_watcher.dart';
import 'src/core/config/app_environment.dart' show currentAppEnvironment;
import 'core/services/injection_container.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  // Initialise the backend URL registry BEFORE dependency injection so
  // every grpc/http/ws factory reads the already-cached URLs on first
  // construction. The call is fast (single SharedPreferences read) and
  // never blocks on the network — the background refresh fires off
  // asynchronously and updates the cache for the NEXT cold start.
  await endpointRegistry.ensureReady();

  // Hydrate the feature-flag cache from SharedPreferences before any widget
  // reads a synchronous flag (e.g. dashboard's `FeatureFlags.dashboardCardsVisible`).
  // The admin-side refresh that bulk-updates flags via
  // `FeatureFlags.applyRemoteSnapshot` rides on top of this baseline.
  await FeatureFlags.init();

  // Initialize dependency injection (after env vars are loaded)
  await init();

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
  unawaited(serviceLocator<PushNotificationsService>().initialize());

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

  // Initialize app icon quick actions (long-press shortcuts)
  QuickActionsService.instance.initialize();

  // Process any pending quick action shortcut that launched the app.
  // (Previously this fired inside SplashScreen.initState; with the
  // splash removed it lands here so the shortcut still gets honoured.)
  QuickActionsService.instance.processPendingShortcut();
}

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
      print('🔄 Onboarding reset for development - showing onboarding screens');
      return AppRoutes.root; // Show onboarding
    }

    // Check if user has seen onboarding
    final hasSeenOnboarding = await storage.read(key: 'has_seen_onboarding');
    if (hasSeenOnboarding != 'true') {
      print('👋 First-time user - showing onboarding screens');
      return AppRoutes.root; // Show onboarding for first-time users
    }

    // Read stored auth/session state up front.
    final loginMethod = await storage.read(key: 'login_method');
    final storedEmail = await storage.read(key: 'stored_email');
    final userId = await storage.read(key: 'user_id');

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
    // have NOT yet established a passcode credential.
    final hasIncompleteSignup = await storage.read(key: 'has_incomplete_signup');
    final currentSignupStep = await storage.read(key: 'current_signup_step');

    if (hasIncompleteSignup == 'true' && currentSignupStep != null) {
      // User has an incomplete signup - route based on step
      print('📝 Found incomplete signup at step: $currentSignupStep');
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

      print('🔐 User was previously logged in, requiring re-authentication via email');
      return AppRoutes.emailSignIn;
    }

    // New user or logged out, show email sign in
    return AppRoutes.emailSignIn;
  } catch (e) {
    print('Error determining initial route: $e');
    return AppRoutes.emailSignIn;
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
    );
  }
}

void localLogWriter(String text, {bool isError = false}) {
  // pass the message to your favourite logging package here
  // please note that even if enableLog: false log messages will be pushed in this callback
  // you get check the flag if you want through GetConfig.isLogEnable
}
