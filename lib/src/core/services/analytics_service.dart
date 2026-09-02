import 'dart:async';
import 'dart:io' show Platform;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/services/endpoint_registry.dart';

/// Analytics / telemetry service.
///
/// Events are queued in memory and flushed (batched) to the telemetry-collector
/// backend, which translates them into Prometheus metrics for Grafana. The flush
/// is BEST-EFFORT: a failed POST re-queues (bounded) and is dropped after a cap.
/// Telemetry must never affect a user flow.
///
/// Use the shared [instance] everywhere so there is a single queue + flush timer
/// (the Dio interceptor, global error handler, cubits and screens all feed it).
class AnalyticsService {
  final FlutterSecureStorage _secureStorage;
  final List<AnalyticsEvent> _eventQueue = [];
  Timer? _flushTimer;
  bool _isEnabled = true;
  String? _userId;

  // Bare Dio for ingest — deliberately has NO interceptors so posting telemetry
  // does not itself emit an http_request event (which would recurse).
  Dio? _ingestDio;
  String? _appVersionCache;

  static const String _userIdKey = 'analytics_user_id';
  static const String _enabledKey = 'analytics_enabled';
  static const int _maxQueueSize = 100;
  static const Duration _flushInterval = Duration(seconds: 30);

  /// Process-wide shared instance.
  static final AnalyticsService instance = AnalyticsService();

  AnalyticsService({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage() {
    _initialize();
  }

  Future<void> _initialize() async {
    _isEnabled = await _secureStorage.read(key: _enabledKey) != 'false';
    _userId = await _secureStorage.read(key: _userIdKey);
    _flushTimer = Timer.periodic(_flushInterval, (_) => flush());
  }

  Future<void> setUserId(String userId) async {
    _userId = userId;
    await _secureStorage.write(key: _userIdKey, value: userId);
    await trackEvent(
      eventName: 'user_identified',
      properties: {'user_id': userId},
    );
  }

  Future<void> trackScreenView({
    required String screenName,
    Map<String, dynamic>? properties,
  }) async {
    await trackEvent(
      eventName: 'screen_view',
      properties: {
        'screen_name': screenName,
        ...?properties,
      },
    );
  }

  Future<void> trackEvent({
    required String eventName,
    Map<String, dynamic>? properties,
  }) async {
    if (!_isEnabled || kIsWeb) return;

    final event = AnalyticsEvent(
      id: _generateEventId(),
      name: eventName,
      properties: properties ?? {},
      timestamp: DateTime.now(),
      userId: _userId,
    );

    _eventQueue.add(event);

    if (_eventQueue.length >= _maxQueueSize) {
      await flush();
    }
  }

  Future<void> trackButtonClick({
    required String buttonName,
    required String screenName,
    Map<String, dynamic>? properties,
  }) async {
    await trackEvent(
      eventName: 'button_click',
      properties: {
        'button_name': buttonName,
        'screen_name': screenName,
        ...?properties,
      },
    );
  }

  Future<void> trackError({
    required String error,
    required String stackTrace,
    Map<String, dynamic>? properties,
  }) async {
    await trackEvent(
      eventName: 'error',
      properties: {
        'error': error,
        'stack_trace': stackTrace,
        ...?properties,
      },
    );
  }

  // ---- Typed send-funds telemetry (names match the collector allowlist) ------

  // The flow (long|short) of the in-progress send. Set when a send-funds screen
  // is viewed so the cubit-side outcome can be attributed to it without
  // threading the flow through every call site.
  String _currentSendFlow = 'unknown';

  // The most recently viewed screen (send-funds or generic). Used to attribute a
  // runtime error/crash to the screen the user was on, since the global error
  // handlers in main.dart have no widget context. Bounded server-side to the
  // screen allowlist (unmapped values collapse to "other").
  String _currentScreen = 'unknown';

  /// The flow (long|short|unknown) recorded at the last send-funds screen view.
  /// Used to stamp `flow` into navigation argument maps (e.g. the
  /// processing/receipt `transferDetails`) so terminal telemetry is attributed
  /// to the right funnel without threading flow through every call site.
  String get currentSendFlow => _currentSendFlow;

  /// Screen view in the send-funds flow. [screen] ∈
  /// select_recipients|initiate|amount|pin|recipient_verify|receipt; [flow] ∈ long|short.
  void trackSendFundsScreen(String screen, String flow) {
    _currentSendFlow = flow;
    _currentScreen = screen;
    unawaited(trackEvent(
      eventName: 'send_funds.screen_view',
      properties: {'screen': screen, 'flow': flow},
    ));
  }

  /// Terminal client outcome of a send-funds attempt. [flow] defaults to the
  /// flow recorded at the last send-funds screen view.
  void trackSendFundsOutcome({
    required String type,
    required String outcome,
    String? flow,
    int? latencyMs,
  }) {
    unawaited(trackEvent(
      eventName: 'send_funds.outcome',
      properties: {
        'flow': flow ?? _currentSendFlow,
        'type': type,
        'outcome': outcome,
        if (latencyMs != null) 'latency_ms': latencyMs,
      },
    ));
  }

  /// Terminal send-funds settlement observed by the client
  /// (status polling/WebSocket driven). [status] ∈ success|failure|cancelled|pending.
  /// [flow] defaults to the flow recorded at the last send-funds screen view so
  /// settlement is attributable to long vs short.
  void trackSendFundsSettled({required String status, String? flow}) {
    unawaited(trackEvent(
      eventName: 'send_funds.settled',
      properties: {'status': status, 'flow': flow ?? _currentSendFlow},
    ));
  }

  /// PIN entry outcome. [result] ∈ success|wrong_pin|locked|exhausted|cancelled.
  void trackPinOutcome(String result) {
    unawaited(trackEvent(
      eventName: 'pin.outcome',
      properties: {'result': result},
    ));
  }

  /// Launch-time pending-payments prompt. [outcome] ∈ shown|pay|later.
  ///
  /// The whole point of this prompt is that outstanding tags/invoices/split
  /// bills were being missed in the general notification feed. Without these
  /// events there is no way to tell whether it actually recovers payments or
  /// just gets dismissed — which is the difference between keeping it and
  /// pulling it.
  void trackPendingPaymentsPrompt({
    required String outcome,
    int? pendingCount,
    String? source,
  }) {
    unawaited(trackEvent(
      eventName: 'pending_payments.prompt',
      properties: {
        'outcome': outcome,
        if (pendingCount != null) 'pending_count': pendingCount,
        if (source != null) 'source': source,
      },
    ));
  }

  /// HTTP request observed by the Dio interceptor.
  void trackHttpRequest({
    required String endpointGroup,
    required String statusClass,
    int? latencyMs,
  }) {
    unawaited(trackEvent(
      eventName: 'http_request',
      properties: {
        'endpoint_group': endpointGroup,
        'status_class': statusClass,
        if (latencyMs != null) 'latency_ms': latencyMs,
      },
    ));
  }

  /// Uncaught runtime error/exception. [kind] ∈
  /// flutter_error|zone_error|http_error. [screen] defaults to the last viewed
  /// screen so crashes are attributable without a widget context.
  void trackRuntimeError({required String kind, String? screen}) {
    unawaited(trackEvent(
      eventName: 'runtime_error',
      properties: {'kind': kind, 'screen': screen ?? _currentScreen},
    ));
  }

  // ---- Typed deposit telemetry (names match the collector allowlist) ---------

  // The method (card|apple_pay|link_account|...) of the in-progress deposit, set
  // at initiation so the later settlement event can be attributed to it.
  String _currentDepositMethod = 'other';

  /// Deposit screen view. [currency] is bounded server-side.
  void trackDepositScreen(String currency) {
    unawaited(trackEvent(
      eventName: 'deposit.screen_view',
      properties: {'currency': currency},
    ));
  }

  /// Client outcome of a deposit INITIATION (not terminal settlement).
  /// [outcome] ∈ success|failure|requires_auth|network_error|cancelled|pending|kyc_required.
  void trackDepositOutcome({
    required String method,
    required String outcome,
    int? latencyMs,
  }) {
    _currentDepositMethod = method;
    unawaited(trackEvent(
      eventName: 'deposit.outcome',
      properties: {
        'method': method,
        'outcome': outcome,
        if (latencyMs != null) 'latency_ms': latencyMs,
      },
    ));
  }

  /// Terminal deposit settlement observed by the client (webhook/poll driven).
  /// [status] ∈ successful|failed|cancelled. [method] defaults to the method of
  /// the last initiation.
  void trackDepositSettled({required String status, String? method}) {
    unawaited(trackEvent(
      eventName: 'deposit.settled',
      properties: {'method': method ?? _currentDepositMethod, 'status': status},
    ));
  }

  // ---- Typed withdrawal telemetry (names match the collector allowlist) ------

  // The destination (linked_bank|external_bank) of the in-progress withdrawal.
  String _currentWithdrawalDest = 'external_bank';

  /// Withdrawal screen view.
  void trackWithdrawalScreen(String currency) {
    unawaited(trackEvent(
      eventName: 'withdrawal.screen_view',
      properties: {'currency': currency},
    ));
  }

  /// Client outcome of a withdrawal INITIATION. [destination] ∈
  /// linked_bank|external_bank; [outcome] ∈
  /// success|failure|network_error|cancelled|pin_failure|pending.
  void trackWithdrawalOutcome({
    required String destination,
    required String outcome,
    int? latencyMs,
  }) {
    _currentWithdrawalDest = destination;
    unawaited(trackEvent(
      eventName: 'withdrawal.outcome',
      properties: {
        'destination': destination,
        'outcome': outcome,
        if (latencyMs != null) 'latency_ms': latencyMs,
      },
    ));
  }

  /// Terminal withdrawal settlement observed by the client.
  /// [status] ∈ successful|failed|cancelled.
  void trackWithdrawalSettled({required String status, String? destination}) {
    unawaited(trackEvent(
      eventName: 'withdrawal.settled',
      properties: {
        'destination': destination ?? _currentWithdrawalDest,
        'status': status,
      },
    ));
  }

  // ---- Typed batch-transfer telemetry (names match the collector allowlist) --

  // The flow (long|short) of the in-progress batch.
  String _currentBatchFlow = 'unknown';

  /// Batch-transfer screen view. [flow] ∈ long|short.
  void trackBatchTransferScreen(String flow) {
    _currentBatchFlow = flow;
    unawaited(trackEvent(
      eventName: 'batch_transfer.screen_view',
      properties: {'flow': flow},
    ));
  }

  /// Client outcome of a batch-transfer submission. [outcome] ∈
  /// completed|partial|failed|network_error|cancelled|pin_failure|processing.
  void trackBatchTransferOutcome({
    required String outcome,
    String? flow,
    int? latencyMs,
  }) {
    unawaited(trackEvent(
      eventName: 'batch_transfer.outcome',
      properties: {
        'flow': flow ?? _currentBatchFlow,
        'outcome': outcome,
        if (latencyMs != null) 'latency_ms': latencyMs,
      },
    ));
  }

  /// Terminal batch settlement observed by the client.
  /// [status] ∈ completed|partial|failed|processing|cancelled.
  void trackBatchTransferSettled({required String status}) {
    unawaited(trackEvent(
      eventName: 'batch_transfer.settled',
      properties: {'status': status},
    ));
  }

  /// Batch-flush the queue to the telemetry-collector. Best-effort.
  Future<bool> flush() async {
    if (_eventQueue.isEmpty || kIsWeb) return true;

    final events = List<AnalyticsEvent>.from(_eventQueue);
    _eventQueue.clear();

    if (kDebugMode) {
      for (final event in events) {
        debugPrint('Analytics Event: ${event.name} - ${event.properties}');
      }
    }

    try {
      final dio = _ingestDio ??= Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ));
      final resp = await dio.post(
        endpointRegistry.telemetryIngest,
        data: {
          'app_version': await _appVersion(),
          'platform': _platform(),
          'events': events.map((e) => e.toIngestJson()).toList(),
        },
      );
      // 2xx (collector returns 202) = delivered. 4xx = bad batch, drop it.
      final code = resp.statusCode ?? 0;
      if (code >= 500) {
        _requeue(events);
        return false;
      }
      return true;
    } catch (_) {
      // Network/collector down — re-queue (bounded) for the next tick.
      _requeue(events);
      return false;
    }
  }

  // Re-add dropped events to the front, capped so the queue can't grow without
  // bound when the collector is unreachable for a long time.
  void _requeue(List<AnalyticsEvent> events) {
    final room = _maxQueueSize - _eventQueue.length;
    if (room <= 0) return;
    final take = events.length > room ? events.sublist(events.length - room) : events;
    _eventQueue.insertAll(0, take);
  }

  Future<String> _appVersion() async {
    if (_appVersionCache != null) return _appVersionCache!;
    try {
      final info = await PackageInfo.fromPlatform();
      _appVersionCache = '${info.version}+${info.buildNumber}';
    } catch (_) {
      _appVersionCache = 'unknown';
    }
    return _appVersionCache!;
  }

  String _platform() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return 'other';
  }

  Future<void> setEnabled(bool enabled) async {
    _isEnabled = enabled;
    await _secureStorage.write(key: _enabledKey, value: enabled ? 'true' : 'false');
  }

  void clearQueue() {
    _eventQueue.clear();
  }

  int get queueSize => _eventQueue.length;

  bool get isEnabled => _isEnabled;

  String _generateEventId() {
    return '${DateTime.now().millisecondsSinceEpoch}-${_eventQueue.length}';
  }

  void dispose() {
    _flushTimer?.cancel();
    flush();
  }
}

class AnalyticsEvent {
  final String id;
  final String name;
  final Map<String, dynamic> properties;
  final DateTime timestamp;
  final String? userId;

  AnalyticsEvent({
    required this.id,
    required this.name,
    required this.properties,
    required this.timestamp,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'properties': properties,
      'timestamp': timestamp.toIso8601String(),
      'user_id': userId,
    };
  }

  // Shape the telemetry-collector ingest endpoint expects.
  Map<String, dynamic> toIngestJson() {
    return {
      'name': name,
      'properties': properties,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
    };
  }
}
