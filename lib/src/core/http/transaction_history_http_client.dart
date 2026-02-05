import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// HTTP client for Transaction History Service
/// Connects to the Core Gateway (port 7878) which routes to the Transaction History microservice
class TransactionHistoryHttpClient {
  final Dio dio;
  final FlutterSecureStorage storage;
  final String baseUrl;

  TransactionHistoryHttpClient({
    required this.baseUrl,
    String? authToken,
  })  : storage = const FlutterSecureStorage(),
      dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      )) {
    if (authToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
    }
  }

  /// Get auth token and update headers
  Future<void> _updateAuthHeaders() async {
    final token = await storage.read(key: 'auth_token');
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  /// Get transaction history
  Future<Map<String, dynamic>> getTransactionHistory({
    required String userId,
    int page = 1,
    int limit = 20,
    String? serviceType,
    List<int>? statuses,
    String? startDate,
    String? endDate,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
  }) async {
    await _updateAuthHeaders();

    final queryParams = <String, dynamic>{
      'user_id': userId,
      'page': page,
      'limit': limit,
    };

    if (serviceType != null) {
      queryParams['service_type'] = serviceType;
    }
    if (statuses != null && statuses.isNotEmpty) {
      queryParams['statuses'] = statuses;
    }
    if (startDate != null) {
      queryParams['start_date'] = startDate;
    }
    if (endDate != null) {
      queryParams['end_date'] = endDate;
    }
    if (minAmount != null) {
      queryParams['min_amount'] = minAmount;
    }
    if (maxAmount != null) {
      queryParams['max_amount'] = maxAmount;
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams['search_query'] = searchQuery;
    }

    try {
      final response = await dio.get(
        '/api/v1/transactions/history',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Error ${e.response?.statusCode}: ${e.response?.data}');
      }
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get transaction statistics
  Future<Map<String, dynamic>> getTransactionStatistics({
    required String userId,
    String? serviceType,
    String? startDate,
    String? endDate,
  }) async {
    await _updateAuthHeaders();

    final queryParams = <String, dynamic>{
      'user_id': userId,
    };

    if (serviceType != null) {
      queryParams['service_type'] = serviceType;
    }
    if (startDate != null) {
      queryParams['start_date'] = startDate;
    }
    if (endDate != null) {
      queryParams['end_date'] = endDate;
    }

    try {
      final response = await dio.get(
        '/api/v1/transactions/statistics',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Error ${e.response?.statusCode}: ${e.response?.data}');
      }
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get transaction details
  Future<Map<String, dynamic>> getTransactionDetails({
    required String userId,
    required String transactionId,
  }) async {
    await _updateAuthHeaders();

    try {
      final response = await dio.get(
        '/api/v1/transactions/$transactionId',
        queryParameters: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else if (response.statusCode == 404) {
        throw Exception('Transaction not found');
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          throw Exception('Transaction not found');
        }
        throw Exception('Error $statusCode: ${e.response?.data}');
      }
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Search transactions
  Future<Map<String, dynamic>> searchTransactions({
    required String userId,
    required String query,
    int limit = 20,
  }) async {
    await _updateAuthHeaders();

    try {
      final response = await dio.get(
        '/api/v1/transactions/search',
        queryParameters: {
          'user_id': userId,
          'q': query,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Error ${e.response?.statusCode}: ${e.response?.data}');
      }
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Refresh transactions (trigger sync from upstream services)
  Future<Map<String, dynamic>> refreshTransactions({
    required String userId,
  }) async {
    await _updateAuthHeaders();

    try {
      final response = await dio.post(
        '/api/v1/transactions/refresh',
        data: {'user_id': userId},
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Error ${e.response?.statusCode}: ${e.response?.data}');
      }
      throw Exception('Network error: ${e.message}');
    }
  }
}
