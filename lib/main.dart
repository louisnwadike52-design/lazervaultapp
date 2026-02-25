import 'dart:io'; // Added for Platform.isAndroid / Platform.isIOS

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/data/datasources/cms_data.dart';
import 'package:lazervault/src/features/presentation/app_router.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'core/services/injection_container.dart';
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
import 'package:device_info_plus/device_info_plus.dart'; // Added device_info_plus
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/quick_actions_service.dart';

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

  // Determine .env file based on device type
  String envFileName = ".env"; // Default to .env (for emulators or other platforms)
  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.isPhysicalDevice) {
        envFileName = ".env.prod";
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if (iosInfo.isPhysicalDevice) {
        envFileName = ".env.prod";
      }
    }
  } catch (e) {
    print("Error getting device info: $e. Defaulting to $envFileName");
  }
  
  print("Attempting to load environment file: $envFileName");

  try {
    // Load environment variables FIRST (before dependency injection)
    await dotenv.load(fileName: envFileName);
    print("$envFileName file loaded successfully.");
  } catch (e) {
    print("Error loading $envFileName file: $e");
    // Consider how to handle errors - maybe default values are okay,
    // or maybe the app shouldn't start without certain variables.
  }

  // Initialize dependency injection (after env vars are loaded)
  await init();

  // Initialize the database
  final dbHelper = DatabaseHelper();
  await dbHelper.database;

  await _checkPermissions();
  await _initializeAndroidAudioSettings();

  // Set global status bar style for dark screens
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());

  // Initialize app icon quick actions (long-press shortcuts)
  QuickActionsService.instance.initialize();

  // Remove the splash screen after the app has been fully initialized
  FlutterNativeSplash.remove();
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

    // Check for incomplete signup (local draft)
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

    // Check if user has a stored login method
    final loginMethod = await storage.read(key: 'login_method');
    final storedEmail = await storage.read(key: 'stored_email');
    final userId = await storage.read(key: 'user_id');

    // If user has passcode login set up, require passcode authentication
    // Note: userId may be null after logout (cleared by _clearSession),
    // but passcode login only needs stored_email + passcode to authenticate
    if (loginMethod == 'passcode' &&
        storedEmail != null &&
        storedEmail.isNotEmpty) {
      print('🔐 User has passcode login configured, redirecting to passcode login');
      return AppRoutes.passcodeLogin;
    }

    // If user was previously logged in but no passcode, go to email sign in
    // This ensures they re-authenticate with email/password
    if (userId != null && userId.isNotEmpty) {
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

/// Auth check screen that determines where to navigate on app start
class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    final initialRoute = await _determineInitialRoute();

    // Small delay to ensure app is ready
    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) {
      Get.offAllNamed(initialRoute);
      // Process any quick action shortcut that launched the app
      QuickActionsService.instance.processPendingShortcut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
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
        builder: (context, child) => GetMaterialApp(
          enableLog: true,
          logWriterCallback: localLogWriter,
          translations: CMSData(),
          fallbackLocale: const Locale('en', 'UK'),
          locale: Get.deviceLocale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarIconBrightness: Brightness.light,
              ),
            ),
            textTheme: GoogleFonts.robotoTextTheme().copyWith(
              titleLarge: GoogleFonts.robotoTextTheme().titleLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
          initialRoute: AppRoutes.authCheck,
          unknownRoute: GetPage(
            name: '/not-found',
            page: () => const AuthCheckScreen(),
          ),
          getPages: AppRouter.routes,
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
