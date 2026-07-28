import 'dart:async';
import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'endpoint_registry.dart';
import 'package:lazervault/src/core/config/app_environment.dart';

/// Ships structured application LOGS from real devices to our Loki server
/// (via the authenticated `POST /api/v1/client-logs` gateway proxy → internal
/// Loki push). This is the "read what happened on this phone" surface — it is
/// complementary to [AnalyticsService], which ships aggregatable Prometheus
/// METRICS. A store build otherwise logs only to the local `dart:developer`
/// console, invisible once shipped; this is how we finally see why e.g. a
/// fingerprint unlock dead-ends on a user's device.
///
/// Design (mirrors the proven [AnalyticsService] pipeline):
///   * in-memory queue, batched flush every [_flushInterval] or at [_maxQueueSize]
///   * bare Dio with NO interceptors so posting logs never emits its own logs
///   * BEST-EFFORT: a failed POST re-queues (bounded) then drops — logging must
///     NEVER block, slow, or crash a user flow. Every public method is fail-silent.
///   * PII-redacted before enqueue (fintech: never ship tokens/PINs/OTPs/balances)
///   * gated + sampled: errors/warnings always ship; info/debug are sampled; a
///     remote flag (or a server "disabled" response) can silence it without a
///     store release.
class RemoteLogSink {
  /// Process-wide shared instance — one queue + flush timer for the whole app.
  static final RemoteLogSink instance = RemoteLogSink();

  static const int _maxQueueSize = 200;
  static const Duration _flushInterval = Duration(seconds: 15);
  static const String _deviceIdKey = 'lv_client_log_device_id';

  final List<Map<String, dynamic>> _queue = [];
  Timer? _flushTimer;
  Dio? _dio;
  bool _initialized = false;

  // Effective gating — starts from the env default, then the server response
  // (and the admin flag via EndpointRegistry) can tighten/loosen it at runtime.
  bool _enabled = true;
  double _sampleRate = 1.0;

  // Stable identity for correlation. device_id is an opaque generated UUID
  // persisted in SharedPreferences — NOT a hardware identifier (privacy).
  String _deviceId = '';
  String _sessionId = '';
  String _appVersion = 'unknown';
  String _platform = 'other';
  String _osVersion = 'unknown';
  String? _userId;

  /// Load identity + gating and start the periodic flush. Idempotent and
  /// fail-silent — a failure here just means logs stay local this launch.
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    try {
      _platform = _resolvePlatform();

      // Env default: dev ships everything; staging/prod ship errors always +
      // a sampled slice of info/debug (keeps Loki + battery/network sane).
      final env = currentAppEnvironment;
      _sampleRate = env.isProduction ? 0.2 : (env.isStaging ? 0.5 : 1.0);
      // Admin can flip these remotely (EndpointRegistry hydrates the keys from
      // the same settings poll that feeds the URL cache); defaults win offline.
      _enabled = endpointRegistry
              .raw('client_logs_enabled')
              ?.trim()
              .toLowerCase() !=
          'false';
      final rawRate = double.tryParse(
          endpointRegistry.raw('client_logs_sample_rate')?.trim() ?? '');
      if (rawRate != null && rawRate >= 0 && rawRate <= 1) _sampleRate = rawRate;

      final prefs = await SharedPreferences.getInstance();
      _deviceId = prefs.getString(_deviceIdKey) ?? '';
      if (_deviceId.isEmpty) {
        _deviceId = const Uuid().v4();
        await prefs.setString(_deviceIdKey, _deviceId);
      }
      _sessionId = const Uuid().v4();

      try {
        final info = await PackageInfo.fromPlatform();
        _appVersion = '${info.version}+${info.buildNumber}';
      } catch (_) {/* keep 'unknown' */}

      _osVersion = await _resolveOsVersion();
    } catch (_) {/* never block startup on logging setup */}

    _flushTimer ??= Timer.periodic(_flushInterval, (_) => flush());
  }

  /// Attach the authenticated user to subsequent logs (call after login /
  /// biometric hydrate). Cleared on logout by passing null.
  void setUserId(String? userId) {
    _userId = (userId != null && userId.isNotEmpty) ? userId : null;
  }

  /// Enqueue one structured log line. Fail-silent. [level] ∈
  /// debug|info|warn|error. [flow] groups related events (e.g.
  /// `biometric_login`, `voice_txpin_settings`) and becomes a low-cardinality
  /// Loki label. [fields] is arbitrary structured context (redacted here).
  void log({
    required String level,
    required String flow,
    required String message,
    String? screen,
    Map<String, dynamic>? fields,
  }) {
    try {
      if (kIsWeb) return;
      final lvl = _normalizeLevel(level);
      if (!_enabled && lvl != 'error') return;
      // Errors + warnings always ship; info/debug are sampled.
      if (lvl == 'info' || lvl == 'debug') {
        if (!_passesSample()) return;
      }

      _queue.add({
        'ts': DateTime.now().toUtc().toIso8601String(),
        'level': lvl,
        'flow': flow.isEmpty ? 'app' : flow,
        'msg': _redactString(message),
        if (screen != null && screen.isNotEmpty) 'screen': screen,
        if (fields != null && fields.isNotEmpty) 'fields': _redactMap(fields),
      });

      if (_queue.length >= _maxQueueSize) {
        // Trim oldest if we somehow overflow before a flush lands.
        while (_queue.length > _maxQueueSize) {
          _queue.removeAt(0);
        }
        unawaited(flush());
      }
    } catch (_) {/* logging must never throw into a caller */}
  }

  /// Batch-flush the queue to the client-logs gateway proxy. Best-effort.
  Future<void> flush() async {
    if (_queue.isEmpty || kIsWeb) return;
    final batch = List<Map<String, dynamic>>.from(_queue);
    _queue.clear();
    try {
      final dio = _dio ??= Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 6),
        receiveTimeout: const Duration(seconds: 6),
        headers: {'Content-Type': 'application/json'},
      ));
      final resp = await dio.post(
        _ingestUrl(),
        data: {
          'device_id': _deviceId,
          'session_id': _sessionId,
          'app_version': _appVersion,
          'app_env': currentAppEnvironment.tierName,
          'platform': _platform,
          'os_version': _osVersion,
          if (_userId != null) 'user_id': _userId,
          'events': batch,
        },
      );
      // Honour a server kill-switch / sampling directive so ops can silence a
      // noisy build without waiting for a store release.
      final data = resp.data;
      if (data is Map) {
        if (data['enabled'] is bool) _enabled = data['enabled'] as bool;
        final sr = data['sample_rate'];
        if (sr is num && sr >= 0 && sr <= 1) _sampleRate = sr.toDouble();
      }
      final code = resp.statusCode ?? 0;
      if (code >= 500) _requeue(batch); // transient — try again next tick
      // 2xx = delivered; 4xx = bad batch, drop it.
    } catch (_) {
      _requeue(batch);
    }
  }

  /// Flush now and stop (call on app pause so breadcrumbs land before the OS
  /// may freeze the process).
  Future<void> flushNow() => flush();

  String _ingestUrl() {
    // EndpointRegistry owns the tier-correct base; the client-logs route lives
    // on core-gateway alongside the storage/support proxies.
    final override = endpointRegistry.raw('url_client_logs_ingest');
    if (override != null && override.isNotEmpty) return override;
    return '${endpointRegistry.httpCore}/client-logs';
  }

  void _requeue(List<Map<String, dynamic>> batch) {
    final room = _maxQueueSize - _queue.length;
    if (room <= 0) return;
    final take =
        batch.length > room ? batch.sublist(batch.length - room) : batch;
    _queue.insertAll(0, take);
  }

  // Deterministic-enough sampling without Math.random dependencies at call
  // sites: hash the session id + queue length. Cheap and good enough for a
  // "ship ~X% of info logs" gate.
  int _sampleCounter = 0;
  bool _passesSample() {
    if (_sampleRate >= 1.0) return true;
    if (_sampleRate <= 0.0) return false;
    _sampleCounter++;
    final bucket = (_sampleCounter * 2654435761) % 1000; // Knuth multiplicative
    return bucket < (_sampleRate * 1000);
  }

  String _normalizeLevel(String level) {
    final l = level.trim().toLowerCase();
    switch (l) {
      case 'error':
      case 'severe':
      case 'fatal':
        return 'error';
      case 'warn':
      case 'warning':
        return 'warn';
      case 'debug':
      case 'fine':
        return 'debug';
      default:
        return 'info';
    }
  }

  String _resolvePlatform() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return 'other';
  }

  Future<String> _resolveOsVersion() async {
    try {
      final plugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final a = await plugin.androidInfo;
        return 'Android ${a.version.release} (SDK ${a.version.sdkInt})';
      }
      if (Platform.isIOS) {
        final i = await plugin.iosInfo;
        return 'iOS ${i.systemVersion}';
      }
    } catch (_) {/* best-effort */}
    return 'unknown';
  }

  // ---- PII redaction (fintech-critical) -------------------------------------

  // Keys whose VALUES must never leave the device, regardless of level.
  static final RegExp _secretKey = RegExp(
    r'(token|passcode|password|pin|otp|secret|authorization|auth|balance|'
    r'cvv|card_number|pan|account_number|bvn|nin|email|phone|msisdn)',
    caseSensitive: false,
  );
  // Bearer tokens / long opaque blobs embedded in free text.
  static final RegExp _bearer =
      RegExp(r'bearer\s+[A-Za-z0-9\-_\.]+', caseSensitive: false);
  static final RegExp _jwtLike =
      RegExp(r'[A-Za-z0-9\-_]{12,}\.[A-Za-z0-9\-_]{12,}\.[A-Za-z0-9\-_]{6,}');

  String _redactString(String? input) {
    if (input == null || input.isEmpty) return '';
    var s = input;
    s = s.replaceAll(_bearer, 'bearer ***');
    s = s.replaceAll(_jwtLike, '***');
    return s.length > 2000 ? '${s.substring(0, 2000)}…' : s;
  }

  Map<String, dynamic> _redactMap(Map<String, dynamic> input) {
    final out = <String, dynamic>{};
    input.forEach((k, v) {
      // Allow user_id through (needed to trace a user's failed flow); mask any
      // other sensitive-looking key.
      if (k.toLowerCase() != 'user_id' && _secretKey.hasMatch(k)) {
        out[k] = '***';
        return;
      }
      if (v is String) {
        out[k] = _redactString(v);
      } else if (v is Map) {
        out[k] = _redactMap(Map<String, dynamic>.from(v));
      } else if (v is num || v is bool || v == null) {
        out[k] = v;
      } else {
        out[k] = _redactString(v.toString());
      }
    });
    return out;
  }
}
