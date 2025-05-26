import 'dart:io'; // Added for Platform.isAndroid / Platform.isIOS

import 'package:flutter/material.dart';
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
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart'; // Added device_info_plus

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

  // Initialize dependency injection
  await init();

  try {
    // Load environment variables
    await dotenv.load(fileName: envFileName); // Use the determined filename
    print("$envFileName file loaded successfully.");
  } catch (e) {
    print("Error loading $envFileName file: $e");
    // Consider how to handle errors - maybe default values are okay,
    // or maybe the app shouldn't start without certain variables.
  }

  // Initialize the database
  final dbHelper = DatabaseHelper();
  await dbHelper.database;

  await _checkPermissions();
  await _initializeAndroidAudioSettings();

  runApp(const MyApp());

  // Remove the splash screen after the app has been fully initialized
  FlutterNativeSplash.remove();
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
        BlocProvider<VoiceSessionCubit>(
          create: (_) => serviceLocator<VoiceSessionCubit>(),
        ),
        BlocProvider<AccountCardsSummaryCubit>(
          create: (_) => serviceLocator<AccountCardsSummaryCubit>(),
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
            textTheme: GoogleFonts.robotoTextTheme().copyWith(
              titleLarge: GoogleFonts.robotoTextTheme().titleLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
          initialRoute: AppRoutes.root,
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
