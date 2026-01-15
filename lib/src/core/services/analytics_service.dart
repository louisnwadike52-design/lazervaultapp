import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Analytics Service for tracking user interactions and events
class AnalyticsService {
  final FlutterSecureStorage _secureStorage;
  final List<AnalyticsEvent> _eventQueue = [];
  Timer? _flushTimer;
  bool _isEnabled = true;
  String? _userId;

  static const String _userIdKey = 'analytics_user_id';
  static const String _enabledKey = 'analytics_enabled';
  static const int _maxQueueSize = 100;
  static const Duration _flushInterval = Duration(seconds: 30);

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

  Future<bool> flush() async {
    if (_eventQueue.isEmpty || kIsWeb) return true;

    final events = List<AnalyticsEvent>.from(_eventQueue);
    _eventQueue.clear();

    if (kDebugMode) {
      for (final event in events) {
        print('Analytics Event: ${event.name} - ${event.properties}');
      }
    }

    return true;
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
}
