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
    // The /business/overview aggregate leaves revenue/receivables at 0 — the
    // revenue engine is the SALES ledger, served by the wired /sales/summary.
    // Overlay the REAL figures so the dashboard Revenue KPI + Money-in bar and
    // the analytics Revenue header reflect recorded sales instead of ₦0.
    // Best-effort: any failure keeps whatever the overview returned.
    try {
      final sales = await _fetchSalesRevenue(token, periodStart, periodEnd);
      if (sales != null) {
        decoded['revenue'] = sales.$1;
        decoded['receivables'] = sales.$2;
      }
    } catch (_) {
      // Non-fatal — the rest of the overview still renders.
    }
    return BusinessOverviewEntity.fromJson(decoded);
  }

  /// Real (revenue, receivables) in minor units from the wired /sales/summary
  /// endpoint, scoped to the same period. Returns null on any non-2xx / shape
  /// mismatch so the caller falls back to the overview's own values.
  Future<(int, int)?> _fetchSalesRevenue(
      String token, String? periodStart, String? periodEnd) async {
    final params = <String, String>{};
    if (periodStart != null && periodStart.isNotEmpty) {
      params['start_date'] = periodStart;
    }
    if (periodEnd != null && periodEnd.isNotEmpty) {
      params['end_date'] = periodEnd;
    }
    final uri = Uri.parse('${_endpoints.httpBusiness}/sales/summary')
        .replace(queryParameters: params.isEmpty ? null : params);
    final resp = await _httpClient.get(
      uri,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    ).timeout(_timeout);
    if (resp.statusCode < 200 || resp.statusCode >= 300) return null;
    final body = jsonDecode(resp.body);
    if (body is! Map<String, dynamic>) return null;
    int i(dynamic v) => v is num ? v.toInt() : int.tryParse('${v ?? 0}') ?? 0;
    return (i(body['total_revenue']), i(body['total_receivables']));
  }
}

class BusinessOverviewException implements Exception {
  final String message;
  const BusinessOverviewException(this.message);
  @override
  String toString() => message;
}
