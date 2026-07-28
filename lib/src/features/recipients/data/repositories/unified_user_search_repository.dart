import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';

/// Calls the core-gateway unified search endpoint
/// `GET /api/v1/users/search-unified?q=&limit=&offset=` which composes the
/// caller's saved recipients (alias-first) with the global user directory.
///
/// The endpoint base comes from [EndpointRegistry.httpCore] (already ends in
/// `/api/v1`, and the cloudflare tunnel routes `/api/v1/users/*` to
/// core-gateway). Auth is the bearer access token from secure storage — the
/// gateway resolves the caller from the JWT and scopes the local recipients.
class UnifiedUserSearchRepository {
  final SecureStorageService _secureStorage;
  final http.Client _client;

  UnifiedUserSearchRepository(this._secureStorage, {http.Client? client})
      : _client = client ?? http.Client();

  Future<UnifiedSearchPage> search(
    String query, {
    int limit = 20,
    int offset = 0,
  }) async {
    final q = query.trim();
    if (q.length < 2) return UnifiedSearchPage.empty;

    final token = await _secureStorage.getAccessToken();
    if (token == null || token.isEmpty) return UnifiedSearchPage.empty;

    final uri = Uri.parse('${endpointRegistry.httpCore}/users/search-unified')
        .replace(queryParameters: {
      'q': q,
      'limit': '$limit',
      'offset': '$offset',
    });

    final resp = await _client.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }).timeout(const Duration(seconds: 12));

    if (resp.statusCode != 200) {
      throw UnifiedSearchException(
        'Search failed (${resp.statusCode})',
        statusCode: resp.statusCode,
      );
    }
    final body = jsonDecode(resp.body);
    if (body is! Map<String, dynamic>) return UnifiedSearchPage.empty;
    return UnifiedSearchPage.fromJson(body);
  }
}

class UnifiedSearchException implements Exception {
  final String message;
  final int? statusCode;
  const UnifiedSearchException(this.message, {this.statusCode});
  @override
  String toString() => 'UnifiedSearchException($statusCode): $message';
}
