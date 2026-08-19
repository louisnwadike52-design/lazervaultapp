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
import 'package:lazervault/core/services/app_check_service.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/play_services_gate.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/api_headers.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/notifications/presentation/cubit/notification_badge_cubit.dart';
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
  static const _channelName = 'Lazervault notifications';
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

    // Firebase CORE init is safe without Play Services, but guard it so a
    // misconfig / attestation hiccup can NEVER hard-block app open.
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      debugPrint('PushNotificationsService: Firebase core init failed (non-fatal): $e');
      return;
    }

    // App Check (Play Integrity) + FCM REQUIRE Google Play Services. On a device
    // whose Play Services/Store is missing, disabled, or outdated, running them
    // surfaces the native blocking "Check that Google Play is enabled … up-to-date
    // … reinstall" dialog at app open. Gate on availability and skip cleanly —
    // the app runs without push/attestation instead of hard-blocking. (App Check
    // getToken() short-circuits to null when not activated, so gRPC calls proceed
    // un-attested; the gateway runs App Check report-only until enforced.)
    final gmsOk = await PlayServicesGate.isAvailable();
    if (!gmsOk) {
      debugPrint('PushNotificationsService: Google Play Services unavailable/outdated '
          '— skipping App Check + FCM (no push/attestation on this device).');
      // Local notifications don't need Play Services — keep them working.
      try {
        await _initLocalNotifications();
      } catch (_) {}
      return;
    }

    try {
      // Activate App Check (App Attest / Play Integrity) before any token is
      // requested. Non-fatal if it fails.
      await AppCheckService.instance.activate();

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      await _requestPermission();
      await _initLocalNotifications();
      await _wireHandlers();
      await _checkColdStartTap();
    } catch (e) {
      // Any FCM/attestation failure is non-fatal — the app must open regardless.
      debugPrint('PushNotificationsService: FCM/App Check setup failed (non-fatal): $e');
    }
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
    // A push arriving while the app is open means a new unread notification —
    // re-read the authoritative count so the dashboard bell badge updates live.
    // Runs on both platforms (before the iOS early-return below). refresh()
    // mirrors the server's unread_count, which already excludes p2p.message.
    if (serviceLocator.isRegistered<NotificationBadgeCubit>()) {
      serviceLocator<NotificationBadgeCubit>().refresh();
    }
    // DOUBLE-NOTIFICATION FIX: on iOS we call
    // setForegroundNotificationPresentationOptions(alert:true), so iOS ALREADY
    // presents the banner for a foreground push — showing a local one here too
    // stacks a duplicate (the "notification came in twice" report). Android does
    // NOT auto-present foreground pushes, so the app must show it there.
    if (Platform.isIOS) return;
    // Use the server's STABLE notification id as the local-notification id so a
    // re-delivered push (FCM retry, or the same push arriving via two tokens on
    // one device) COLLAPSES onto the same banner instead of stacking a duplicate.
    // Falls back to a content hash when the id is absent.
    final serverId = message.data['notification_id']?.toString() ?? '';
    final localId = serverId.isNotEmpty
        ? (serverId.hashCode & 0x7fffffff)
        : Object.hash(notification.title, notification.body,
                message.data['type'], message.data['reference'])
            .toUnsigned(31);
    _local.show(
      localId,
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
    String? token;
    try {
      token = await FirebaseMessaging.instance.getToken(
        vapidKey: kIsWeb ? DefaultFirebaseOptions.vapidKey : null,
      );
    } catch (e) {
      debugPrint('[push] getToken threw: $e');
    }
    if (token == null || token.isEmpty) {
      // Play-services can lag on a cold start — retry once after a short delay
      // so the very first login still registers without needing an app restart.
      debugPrint('[push] getToken returned null/empty — retrying in 3s');
      await Future.delayed(const Duration(seconds: 3));
      try {
        token = await FirebaseMessaging.instance.getToken(
          vapidKey: kIsWeb ? DefaultFirebaseOptions.vapidKey : null,
        );
      } catch (e) {
        debugPrint('[push] getToken retry threw: $e');
      }
    }
    if (token == null || token.isEmpty) {
      debugPrint('[push] no FCM token available — push will not work until one is obtained');
      return;
    }
    debugPrint('[push] FCM token obtained (len=${token.length})');
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

  static const _kRegisteredMarkerKey = 'fcm_registered_marker';

  FlutterSecureStorage get _markerStore => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
          resetOnError: true,
        ),
      );

  /// The "<userId>:<token>" we last successfully registered, or null.
  Future<String?> _readRegisteredMarker() async {
    try {
      return await _markerStore.read(key: _kRegisteredMarkerKey);
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeRegisteredMarker(String marker) async {
    try {
      await _markerStore.write(key: _kRegisteredMarkerKey, value: marker);
    } catch (_) {
      // Non-fatal: worst case we re-POST on the next login.
    }
  }

  /// Clears the local registration flag so the next authenticated call
  /// re-registers with the server. Call on logout (the server may drop the
  /// device's tokens, and the next user must not be skipped by a stale marker).
  Future<void> clearRegistrationMarker() async {
    try {
      await _markerStore.delete(key: _kRegisteredMarkerKey);
    } catch (_) {}
  }

  Future<void> _registerToken(String token) async {
    final userId = await _secureStorage.getUserId() ?? '';
    if (userId.isEmpty) {
      debugPrint('[push] skip token registration — no userId yet');
      return;
    }

    // Local-flag gate: only hit the network if we haven't already registered
    // THIS device-token for THIS user. _registerPushTokenIfReady fires on every
    // auth transition (login, app-start, etc.), so without this we'd POST on
    // every login. The marker is "<userId>:<token>": if the FCM token rotates
    // (onTokenRefresh) it stops matching and we re-register automatically; a new
    // user logging in also won't match, so their token gets created on first login.
    final marker = '$userId:$token';
    if (await _readRegisteredMarker() == marker) {
      debugPrint('[push] token already registered for this user/device — skipping remote call');
      return;
    }

    final deviceId = await _resolveDeviceId();
    final deviceType = kIsWeb
        ? 'web'
        : Platform.isIOS
            ? 'ios'
            : 'android';

    final url = _coreUrl('/api/v1/notifications/fcm-token');
    try {
      final resp = await _dio.post(
        url,
        data: {
          'user_id': userId,
          'fcm_token': token,
          'device_id': deviceId,
          'device_type': deviceType,
        },
        options: Options(headers: await _headers()),
      );
      debugPrint('[push] token registered → $url (HTTP ${resp.statusCode})');
      final code = resp.statusCode ?? 0;
      if (code >= 200 && code < 300) {
        // Cache the success so subsequent logins skip the remote call until the
        // token or user changes.
        await _writeRegisteredMarker(marker);
      }
    } on DioException catch (e) {
      debugPrint('[push] register token failed → $url '
          '(HTTP ${e.response?.statusCode}) ${e.response?.data ?? e.message}');
    } catch (e) {
      // A transient failure must not crash the app; retried on next
      // onTokenRefresh / app start / dashboard load.
      debugPrint('[push] register token failed → $url: $e');
    }
  }

  String get _coreGatewayBase {
    final raw = dotenv.env['CORE_GATEWAY_URL'] ?? endpointRegistry.httpCore;
    return raw
        .replaceAll('localhost', '10.0.2.2')
        .replaceAll('127.0.0.1', '10.0.2.2');
  }

  /// Joins [apiPath] (a full gateway path like '/api/v1/notifications/fcm-token')
  /// onto the core-gateway base WITHOUT duplicating the '/api/v1' segment.
  /// `endpointRegistry.httpCore` already ends in '/api/v1', while a raw
  /// CORE_GATEWAY_URL override may not — this normalises both so the result
  /// always has exactly one '/api/v1' (the earlier bug produced
  /// `.../api/v1/api/v1/notifications/fcm-token` → 404).
  String _coreUrl(String apiPath) {
    var base = _coreGatewayBase.replaceAll(RegExp(r'/+$'), '');
    if (base.endsWith('/api/v1') && apiPath.startsWith('/api/v1')) {
      base = base.substring(0, base.length - '/api/v1'.length);
    }
    return '$base$apiPath';
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
