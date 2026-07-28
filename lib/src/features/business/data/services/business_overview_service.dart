import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../../domain/entities/business_overview_entity.dart';

/// Fetches the aggregated Lazavote Business overview from business-gateway
/// `GET /api/v1/business/overview` (the fan-out aggregator). Bearer-authed.
class BusinessOverviewService {
  static const String _accessTokenKey = 'access_token';
  static const Duration _timeout = Duration(seconds: 20);

  final EndpointRegistry _endpoints;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;

  BusinessOverviewService({
    required EndpointRegistry endpoints,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
  })  : _endpoints = endpoints,
        // Reuse the ONE app-wide FlutterSecureStorage singleton (same instance
        // every gRPC call reads). A hand-rolled `const FlutterSecureStorage()`
        // reads a different Android backend and finds no token → getOverview
        // throws → the analytics Revenue tab silently shows 0 sales revenue.
        _storage = storage ?? serviceLocator<FlutterSecureStorage>(),
        _httpClient = httpClient ?? http.Client();

  /// [periodStart]/[periodEnd] are optional YYYY-MM-DD bounds for payroll +
  /// expense windows; omit for all-time.
  Future<BusinessOverviewEntity> getOverview({
    String? periodStart,
    String? periodEnd,
  }) async {
    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw const BusinessOverviewException('Please sign in to view your business.');
    }

    // httpBusiness already ends in /api/v1 → /api/v1/business/overview.
    final params = <String, String>{};
    if (periodStart != null && periodStart.isNotEmpty) params['period_start'] = periodStart;
    if (periodEnd != null && periodEnd.isNotEmpty) params['period_end'] = periodEnd;
    final uri = Uri.parse('${_endpoints.httpBusiness}/business/overview')
        .replace(queryParameters: params.isEmpty ? null : params);

    final resp = await _httpClient.get(
      uri,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    ).timeout(_timeout);

    if (resp.statusCode == 401 || resp.statusCode == 403) {
      throw const BusinessOverviewException('Session expired. Please sign in again.');
    }
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw BusinessOverviewException(
        'Could not load your business overview (HTTP ${resp.statusCode}).',
      );
    }
    final decoded = jsonDecode(resp.body);
    if (decoded is! Map<String, dynamic>) {
      throw const BusinessOverviewException('Unexpected response from the server.');
    }
    return BusinessOverviewEntity.fromJson(decoded);
  }
}

class BusinessOverviewException implements Exception {
  final String message;
  const BusinessOverviewException(this.message);
  @override
  String toString() => message;
}
