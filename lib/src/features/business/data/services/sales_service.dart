import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../../domain/entities/sale_entity.dart';

/// HTTP client for the Sales/revenue engine (business-gateway /api/v1/sales/*).
class SalesService {
  static const String _accessTokenKey = 'access_token';
  static const Duration _timeout = Duration(seconds: 20);

  final EndpointRegistry _endpoints;
  final FlutterSecureStorage _storage;
  final http.Client _httpClient;

  SalesService({
    required EndpointRegistry endpoints,
    FlutterSecureStorage? storage,
    http.Client? httpClient,
  })  : _endpoints = endpoints,
        // Reuse the ONE app-wide FlutterSecureStorage singleton (the same
        // instance SendFunds/every gRPC call reads via GrpcCallOptionsHelper).
        // It's configured once (AndroidOptions encryptedSharedPreferences:true);
        // a hand-rolled `const FlutterSecureStorage()` reads a different Android
        // backend and finds no token → "Please sign in to record a sale".
        _storage = storage ?? serviceLocator<FlutterSecureStorage>(),
        _httpClient = httpClient ?? http.Client();

  Future<String> _token() async {
    final t = await _storage.read(key: _accessTokenKey);
    if (t == null || t.isEmpty) {
      throw const SalesException('Please sign in to record a sale.');
    }
    return t;
  }

  /// Record a sale. [amount]/[unitPrice] are in MINOR units (kobo).
  Future<SaleEntity> recordSale({
    required int amount,
    required String description,
    String paymentMethod = 'cash',
    bool paid = true,
    int quantity = 1,
    int unitPrice = 0,
    String customerId = '',
    String inventoryItemId = '',
    String currency = 'NGN',
    required String idempotencyKey,
  }) async {
    final token = await _token();
    final resp = await _httpClient
        .post(
          Uri.parse('${_endpoints.httpBusiness}/sales'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'amount': amount,
            'description': description,
            'payment_method': paymentMethod,
            'paid': paid,
            'quantity': quantity,
            'unit_price': unitPrice,
            'customer_id': customerId,
            'inventory_item_id': inventoryItemId,
            'currency': currency,
            'idempotency_key': idempotencyKey,
          }),
        )
        .timeout(_timeout);
    final body = _decode(resp);
    if (body['success'] != true) {
      throw SalesException(
          (body['message'] ?? 'Could not record the sale.').toString());
    }
    return SaleEntity.fromJson(
        (body['sale'] as Map?)?.cast<String, dynamic>() ?? {});
  }

  Future<List<SaleEntity>> listSales({int page = 1, int limit = 30, String status = ''}) async {
    final token = await _token();
    final uri = Uri.parse('${_endpoints.httpBusiness}/sales').replace(
      queryParameters: {
        'page': '$page',
        'limit': '$limit',
        if (status.isNotEmpty) 'status': status,
      },
    );
    final resp = await _httpClient.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }).timeout(_timeout);
    final body = _decode(resp);
    final list = (body['sales'] as List?) ?? const [];
    return list
        .whereType<Map>()
        .map((m) => SaleEntity.fromJson(m.cast<String, dynamic>()))
        .toList();
  }

  /// All-time (or date-ranged) revenue/receivables totals from the backend
  /// aggregate — the headline stat cards must use THIS, not a fold over the
  /// currently-loaded page (which understates totals past one page of sales).
  Future<SalesSummary> getSummary({String startDate = '', String endDate = ''}) async {
    final token = await _token();
    final uri = Uri.parse('${_endpoints.httpBusiness}/sales/summary').replace(
      queryParameters: {
        if (startDate.isNotEmpty) 'start_date': startDate,
        if (endDate.isNotEmpty) 'end_date': endDate,
      },
    );
    final resp = await _httpClient.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }).timeout(_timeout);
    final body = _decode(resp);
    // protobuf Go struct → snake_case json tags.
    return SalesSummary(
      revenue: (body['total_revenue'] as num?)?.toInt() ?? 0,
      receivables: (body['total_receivables'] as num?)?.toInt() ?? 0,
      count: (body['sale_count'] as num?)?.toInt() ?? 0,
      currency: (body['currency'] as String?)?.isNotEmpty == true
          ? body['currency'] as String
          : 'NGN',
    );
  }

  Map<String, dynamic> _decode(http.Response resp) {
    if (resp.statusCode == 401 || resp.statusCode == 403) {
      throw const SalesException('Session expired. Please sign in again.');
    }
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw SalesException('Request failed (HTTP ${resp.statusCode}).');
    }
    final decoded = jsonDecode(resp.body);
    if (decoded is! Map<String, dynamic>) {
      throw const SalesException('Unexpected response from the server.');
    }
    return decoded;
  }
}

/// Backend-computed sales aggregate (all sales, not just the loaded page).
class SalesSummary {
  final int revenue; // minor units, PAID sales
  final int receivables; // minor units, UNPAID sales
  final int count;
  final String currency;
  const SalesSummary({
    required this.revenue,
    required this.receivables,
    required this.count,
    required this.currency,
  });
}

class SalesException implements Exception {
  final String message;
  const SalesException(this.message);
  @override
  String toString() => message;
}
