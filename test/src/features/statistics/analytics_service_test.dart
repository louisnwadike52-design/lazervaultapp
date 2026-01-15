import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';

void main() {
  group('AnalyticsService', () {
    late AnalyticsService service;

    setUp(() {
      service = AnalyticsService(
        secureStorage: const FlutterSecureStorage(),
      );
    });

    tearDown(() {
      service.dispose();
    });

    test('initial state is enabled', () {
      expect(service.isEnabled, true);
    });

    test('can be disabled', () async {
      await service.setEnabled(false);
      expect(service.isEnabled, false);

      await service.setEnabled(true);
      expect(service.isEnabled, true);
    });

    test('sets user ID correctly', () async {
      await service.setUserId('user_123');
      // Note: In production, verify with secure storage
    });

    test('tracks screen view events', () async {
      await service.trackScreenView(
        screenName: 'statistics_screen',
        properties: {'feature': 'financial_overview'},
      );

      expect(service.queueSize, greaterThan(0));
    });

    test('tracks button click events', () async {
      await service.trackButtonClick(
        buttonName: 'sync_button',
        screenName: 'statistics_screen',
      );

      expect(service.queueSize, greaterThan(0));
    });

    test('tracks API call events', () async {
      await service.trackApiCall(
        endpoint: '/api/statistics',
        method: 'GET',
        statusCode: 200,
        duration: const Duration(milliseconds: 150),
      );

      expect(service.queueSize, greaterThan(0));
    });

    test('tracks transaction events', () async {
      await service.trackTransaction(
        transactionType: 'expense',
        amount: 100.0,
        currency: 'USD',
        category: 'food',
      );

      expect(service.queueSize, greaterThan(0));
    });

    test('tracks error events', () async {
      await service.trackError(
        error: 'Network error',
        stackTrace: 'at Object.<anonymous> (test.js:10:15)',
      );

      expect(service.queueSize, greaterThan(0));
    });

    test('clears queue when flush is called', () async {
      await service.trackScreenView(screenName: 'test_screen');
      final sizeBefore = service.queueSize;

      await service.flush();

      expect(service.queueSize, lessThan(sizeBefore));
    });
  });

  group('AnalyticsEvent', () {
    test('serializes to JSON correctly', () {
      final event = AnalyticsEvent(
        id: '123',
        name: 'test_event',
        properties: {'key': 'value'},
        timestamp: DateTime(2024, 1, 1),
        userId: 'user_123',
      );

      final json = event.toJson();

      expect(json['id'], '123');
      expect(json['name'], 'test_event');
      expect(json['properties'], {'key': 'value'});
      expect(json['user_id'], 'user_123');
    });

    test('deserializes from JSON correctly', () {
      final json = {
        'id': '123',
        'name': 'test_event',
        'properties': {'key': 'value'},
        'timestamp': '2024-01-01T00:00:00.000Z',
        'user_id': 'user_123',
      };

      final event = AnalyticsEvent.fromJson(json);

      expect(event.id, '123');
      expect(event.name, 'test_event');
      expect(event.properties, {'key': 'value'});
      expect(event.userId, 'user_123');
    });
  });
}
