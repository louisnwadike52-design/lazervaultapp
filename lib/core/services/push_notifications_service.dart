import 'dart:async';
import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/api_headers.dart';
import 'package:lazervault/firebase_options.dart';
import 'package:uuid/uuid.dart';

/// Top-level background message handler. Required by firebase_messaging:
/// must be a top-level (not inside a class) function annotated with
/// `@pragma('vm:entry-point')` so the Dart VM can wake it from a background
/// isolate. Keep this minimal — no DI/Firebase init beyond the call below.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

/// Wires Firebase Cloud Messaging end-to-end:
/// - initialises Firebase + the FCM SDK with the env-aware options
/// - requests OS-level notification permission (iOS / Android 13+)
/// - obtains the device FCM token and POSTs it to notifications-service
///   via `POST /api/v1/notifications/fcm-token`
/// - re-registers on `onTokenRefresh`
/// - displays foreground messages via flutter_local_notifications
/// - dispatches tap events through [onMessageTap]
class PushNotificationsService {
  PushNotificationsService({
    required SecureStorageService secureStorage,
    required AccountManager accountManager,
    required LocaleManager localeManager,
    Dio? dio,
    FlutterLocalNotificationsPlugin? localNotifications,
  })  : _secureStorage = secureStorage,
        _accountManager = accountManager,
        _localeManager = localeManager,
        _dio = dio ?? Dio(),
        _local = localNotifications ?? FlutterLocalNotificationsPlugin();

  static const _channelId = 'lazervault_default';
  static const _channelName = 'LazerVault notifications';
  static const _channelDescription =
      'Transactions, security alerts, and account activity';

  final SecureStorageService _secureStorage;
  final AccountManager _accountManager;
  final LocaleManager _localeManager;
  final Dio _dio;
  final FlutterLocalNotificationsPlugin _local;

  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<RemoteMessage>? _openedAppSub;

  /// Invoked when the user taps a notification (cold start, background, or
  /// foreground). The router lives in [PushNotificationsRouter]; this service
  /// is intentionally unaware of `Navigator` so it can be initialised before
  /// the app is mounted.
  void Function(RemoteMessage message)? onMessageTap;

  bool _initialised = false;

  /// Idempotent: safe to call multiple times. The first call performs
  /// `Firebase.initializeApp` + handler wiring; subsequent calls are no-ops.
  Future<void> initialize() async {
    if (_initialised) return;
    _initialised = true;

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _requestPermission();
    await _initLocalNotifications();
    await _wireHandlers();
    await _checkColdStartTap();
  }

  Future<void> _requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    await _local.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: (resp) {
        if (resp.payload == null) return;
        onMessageTap?.call(
          RemoteMessage(data: const {'tap_source': 'local_notification'}),
        );
      },
    );

    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
    );
    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _wireHandlers() async {
    _foregroundSub = FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    _openedAppSub = FirebaseMessaging.onMessageOpenedApp.listen((m) {
      onMessageTap?.call(m);
    });
    _tokenRefreshSub = FirebaseMessaging.instance.onTokenRefresh.listen((t) {
      unawaited(_registerToken(t));
    });
  }

  Future<void> _checkColdStartTap() async {
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) onMessageTap?.call(initial);
  }

  void _onForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;
    _local.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          icon: '@mipmap/ic_launcher',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: message.data['type']?.toString(),
    );
  }

  /// Called by the auth flow once a user is authenticated. Fetches the current
  /// FCM token and POSTs it to notifications-service. Safe to call multiple
  /// times — registration is idempotent server-side keyed by user_id+device_id.
  ///
  /// On web, getToken() requires a VAPID public key (per-Firebase-project,
  /// generated in Console → Cloud Messaging → Web configuration). Without
  /// it, FirebaseMessaging silently returns null and push never works on
  /// web. On native (iOS/Android), the vapidKey arg is ignored.
  Future<void> registerCurrentToken() async {
    final token = await FirebaseMessaging.instance.getToken(
      vapidKey: kIsWeb ? DefaultFirebaseOptions.vapidKey : null,
    );
    if (token == null || token.isEmpty) return;
    await _registerToken(token);
  }

  Future<String> _resolveDeviceId() async {
    const key = 'push_device_id';
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
        resetOnError: true,
      ),
    );
    final existing = await storage.read(key: key);
    if (existing != null && existing.isNotEmpty) return existing;
    final fresh = const Uuid().v4();
    await storage.write(key: key, value: fresh);
    return fresh;
  }

  Future<void> _registerToken(String token) async {
    final userId = await _secureStorage.getUserId() ?? '';
    if (userId.isEmpty) return;

    final deviceId = await _resolveDeviceId();
    final deviceType = kIsWeb
        ? 'web'
        : Platform.isIOS
            ? 'ios'
            : 'android';

    try {
      await _dio.post(
        '$_coreGatewayBase/api/v1/notifications/fcm-token',
        data: {
          'user_id': userId,
          'fcm_token': token,
          'device_id': deviceId,
          'device_type': deviceType,
        },
        options: Options(headers: await _headers()),
      );
    } catch (e) {
      // Token re-registration is retried on next onTokenRefresh / app start;
      // a transient network failure here must not crash the app.
      debugPrint('[push] register token failed: $e');
    }
  }

  String get _coreGatewayBase {
    final raw = dotenv.env['CORE_GATEWAY_URL'] ?? endpointRegistry.httpCore;
    return raw
        .replaceAll('localhost', '10.0.2.2')
        .replaceAll('127.0.0.1', '10.0.2.2');
  }

  Future<Map<String, String>> _headers() => ApiHeaders.build(
        secureStorage: _secureStorage,
        accountManager: _accountManager,
        localeManager: _localeManager,
      );

  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
    await _foregroundSub?.cancel();
    await _openedAppSub?.cancel();
  }
}
