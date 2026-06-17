import 'analytics_service.dart';

/// Analytics Service Mixin for easy tracking in widgets
mixin AnalyticsMixin {
  late final analyticsService = AnalyticsService();

  Future<void> trackScreenView(
    String screenName, {
    Map<String, dynamic>? properties,
  }) async {
    await analyticsService.trackScreenView(
      screenName: screenName,
      properties: properties,
    );
  }

  Future<void> trackButtonClick(
    String buttonName,
    String screenName, {
    Map<String, dynamic>? properties,
  }) async {
    await analyticsService.trackButtonClick(
      buttonName: buttonName,
      screenName: screenName,
      properties: properties,
    );
  }

  Future<void> trackError(
    String error,
    String stackTrace, {
    Map<String, dynamic>? properties,
  }) async {
    await analyticsService.trackError(
      error: error,
      stackTrace: stackTrace,
      properties: properties,
    );
  }
}
