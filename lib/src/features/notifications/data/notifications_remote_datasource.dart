import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/api_headers.dart';

/// A single notification as served by notifications-service via core-gateway
/// (`GET /api/v1/notifications`). Mirrors the proto `Notification` message.
class AppNotification {
  final String id;
  final String type; // transfer | payment | deposit | withdrawal | account | security | investment | giftcard | bill | ...
  final String title;
  final String body;
  final bool read;
  final DateTime createdAt;

  /// The server's `data` payload — the same map the push carries, holding the
  /// ids a tapped row needs to open the actual record (`invoice_id`,
  /// `split_bill_id`, `sender_user_id`, …).
  ///
  /// The list API has always returned this (the handler unmarshals
  /// `n.Data` into the proto), but the client parsed only the display fields
  /// and dropped it — which is why a feed row could not be made tappable even
  /// after the push side could route: there was nothing to route WITH.
  final Map<String, dynamic> data;

  /// The server's `reference_id`, when set. A second place an entity id can
  /// arrive; folded into [data] below so the resolver only has one thing to
  /// look at.
  final String referenceId;

  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.read,
    required this.createdAt,
    this.data = const {},
    this.referenceId = '',
  });

  factory AppNotification.fromJson(Map<String, dynamic> j) {
    DateTime parsed;
    final raw = (j['created_at'] ?? j['createdAt'])?.toString();
    parsed = DateTime.tryParse(raw ?? '')?.toLocal() ?? DateTime.now();

    // `data` arrives as a JSON object, but tolerate a JSON *string* too: the
    // column is jsonb and has been written both ways over the years.
    final rawData = j['data'];
    Map<String, dynamic> data = const {};
    if (rawData is Map) {
      data = Map<String, dynamic>.from(rawData);
    } else if (rawData is String && rawData.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawData);
        if (decoded is Map) data = Map<String, dynamic>.from(decoded);
      } catch (_) {
        // Malformed data must not cost the user the whole notification — the
        // row still renders, it just cannot deep-link.
      }
    }

    final refId = (j['reference_id'] ?? j['referenceId'] ?? '').toString();
    if (refId.isNotEmpty && !data.containsKey('reference_id')) {
      data = {...data, 'reference_id': refId};
    }

    return AppNotification(
      id: (j['id'] ?? '').toString(),
      type: (j['type'] ?? '').toString(),
      title: (j['title'] ?? '').toString(),
      body: (j['body'] ?? '').toString(),
      read: j['read'] == true || j['read'] == 'true',
      createdAt: parsed,
      data: data,
      referenceId: refId,
    );
  }
}

class NotificationsResult {
  final List<AppNotification> notifications;
  final int unreadCount;

  /// Total notifications the server has for this user (after its own filtering),
  /// used to drive "load more" pagination — there are more pages while
  /// `offset + notifications.length < total`. Falls back to the page length when
  /// the server omits it (so a single-page result never claims more).
  final int total;

  const NotificationsResult(
    this.notifications,
    this.unreadCount, {
    int? total,
  }) : total = total ?? notifications.length;
}

/// Real notifications data source — replaces the screen's old hardcoded lists.
/// Calls the notifications-service through core-gateway's REST surface with the
/// standard authed headers (Bearer + X-User-Id + X-Account-Id + locale).
class NotificationsRemoteDataSource {
  final Dio _dio;
  final SecureStorageService _secureStorage;
  final AccountManager _accountManager;
  final LocaleManager _localeManager;

  NotificationsRemoteDataSource({
    Dio? dio,
    required SecureStorageService secureStorage,
    required AccountManager accountManager,
    required LocaleManager localeManager,
  })  : _dio = dio ?? Dio(),
        _secureStorage = secureStorage,
        _accountManager = accountManager,
        _localeManager = localeManager;

  Future<Map<String, String>> _headers() => ApiHeaders.build(
        secureStorage: _secureStorage,
        accountManager: _accountManager,
        localeManager: _localeManager,
      );

  // Read the core-gateway base from dotenv with the emulator default. Avoids
  // ApiConfig's late-init which isn't guaranteed to have run. On the Android
  // emulator, host localhost must be reached via 10.0.2.2.
  //
  // Self-correcting: the request paths below already include `/api/v1/...`,
  // but historically the default fallback and some `.env` configurations
  // bake `/api/v1` into the URL too — producing `…/api/v1/api/v1/notifications`
  // (404 → "Could not load notifications"). Strip the trailing `/api/v1`
  // (and any trailing slash) so the concat is always correct regardless of
  // which shape the env / default has.
  String get _base {
    // CORE_GATEWAY_URL isn't set in the per-tier .env files — fall back to
    // HTTP_API_HOST (the cloudflared host, e.g. https://dev.lazervault.app)
    // BEFORE the hardcoded api.lazervault.app default, else notifications hit
    // the wrong host and never load.
    final raw = dotenv.env['CORE_GATEWAY_URL'] ??
        dotenv.env['HTTP_API_HOST'] ??
        endpointRegistry.httpCore;
    var normalised = raw
        .replaceAll('localhost', '10.0.2.2')
        .replaceAll('127.0.0.1', '10.0.2.2');
    while (normalised.endsWith('/')) {
      normalised = normalised.substring(0, normalised.length - 1);
    }
    if (normalised.endsWith('/api/v1')) {
      normalised = normalised.substring(0, normalised.length - '/api/v1'.length);
    }
    return normalised;
  }

  /// Fetch the user's notifications (newest first per the service). Returns the
  /// list + unread count. Throws on transport/HTTP error so the screen can show
  /// a retry state instead of fabricated rows.
  Future<NotificationsResult> getNotifications({
    int limit = 50,
    int offset = 0,
    bool unreadOnly = false,
  }) async {
    // The notifications-service GetNotifications RPC reads user_id from the
    // request (the grpc-gateway does not auto-inject it from the JWT), so we
    // pass it explicitly from secure storage.
    final userId = await _secureStorage.getUserId() ?? '';
    final resp = await _dio.get(
      '$_base/api/v1/notifications',
      queryParameters: {
        'limit': limit,
        'offset': offset,
        'unread_only': unreadOnly,
        if (userId.isNotEmpty) 'user_id': userId,
      },
      options: Options(headers: await _headers()),
    );
    final data = resp.data is Map ? resp.data as Map : <String, dynamic>{};
    final rawList = (data['notifications'] as List?) ?? const [];
    final notifications = rawList
        .whereType<Map>()
        .map((m) => AppNotification.fromJson(Map<String, dynamic>.from(m)))
        .toList();
    final unread = (data['unread_count'] as num?)?.toInt() ??
        notifications.where((n) => !n.read).length;
    final total = (data['total'] as num?)?.toInt();
    return NotificationsResult(notifications, unread, total: total);
  }

  Future<void> markAsRead(String id) async {
    final userId = await _secureStorage.getUserId() ?? '';
    await _dio.post(
      '$_base/api/v1/notifications/$id/read',
      data: {'user_id': userId},
      options: Options(headers: await _headers()),
    );
  }

  Future<void> markAllAsRead() async {
    final userId = await _secureStorage.getUserId() ?? '';
    await _dio.post(
      '$_base/api/v1/notifications/read-all',
      data: {'user_id': userId},
      options: Options(headers: await _headers()),
    );
  }
}
