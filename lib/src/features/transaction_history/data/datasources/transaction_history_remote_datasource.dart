import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Remote data source for transaction history
/// This handles all API calls for fetching transactions
class TransactionHistoryRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage storage;

  TransactionHistoryRemoteDataSource({
    required this.dio,
    required this.storage,
  });

  /// Fetch all transactions from the API
  Future<Map<String, dynamic>> fetchAllTransactions({
    int page = 1,
    int limit = 20,
    String? cursor,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final token = await storage.read(key: 'auth_token');

      final response = await dio.get(
        '/transactions',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (cursor != null) 'cursor': cursor,
          ...?filters,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch transactions');
      }
    } catch (e) {
      throw Exception('Error fetching transactions: $e');
    }
  }

  /// Fetch transactions for a specific service
  Future<Map<String, dynamic>> fetchServiceTransactions(
    String serviceType, {
    int page = 1,
    int limit = 20,
    String? cursor,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final token = await storage.read(key: 'auth_token');

      final response = await dio.get(
        '/transactions/$serviceType',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (cursor != null) 'cursor': cursor,
          ...?filters,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch service transactions');
      }
    } catch (e) {
      throw Exception('Error fetching service transactions: $e');
    }
  }

  /// Fetch transaction by ID
  Future<Map<String, dynamic>> fetchTransactionById(String id) async {
    try {
      final token = await storage.read(key: 'auth_token');

      final response = await dio.get(
        '/transactions/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch transaction');
      }
    } catch (e) {
      throw Exception('Error fetching transaction: $e');
    }
  }

  /// Search transactions
  Future<List<Map<String, dynamic>>> searchTransactions(String query) async {
    try {
      final token = await storage.read(key: 'auth_token');

      final response = await dio.get(
        '/transactions/search',
        queryParameters: {'q': query},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(
          response.data['transactions'] as List,
        );
      } else {
        throw Exception('Failed to search transactions');
      }
    } catch (e) {
      throw Exception('Error searching transactions: $e');
    }
  }

  /// Get transaction statistics
  Future<Map<String, dynamic>> getStatistics({
    String? serviceType,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final token = await storage.read(key: 'auth_token');

      final response = await dio.get(
        '/transactions/statistics',
        queryParameters: {
          if (serviceType != null) 'serviceType': serviceType,
          if (startDate != null) 'startDate': startDate,
          if (endDate != null) 'endDate': endDate,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch statistics');
      }
    } catch (e) {
      throw Exception('Error fetching statistics: $e');
    }
  }

  /// Refresh transactions (fetch latest from server)
  Future<void> refreshTransactions() async {
    // This would trigger a sync with the server
    // Implementation depends on your backend
    try {
      final token = await storage.read(key: 'auth_token');

      await dio.post(
        '/transactions/sync',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      throw Exception('Error refreshing transactions: $e');
    }
  }

  /// Parse API response to UnifiedTransaction list
  List<UnifiedTransaction> parseTransactions(List<dynamic> data) {
    return data.map((item) {
      return UnifiedTransaction.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  /// Parse API response to TransactionListResponse
  TransactionListResponse parseTransactionListResponse(Map<String, dynamic> data) {
    final transactions = parseTransactions(data['transactions'] as List);

    return TransactionListResponse(
      transactions: transactions,
      hasMore: data['hasMore'] as bool? ?? false,
      currentPage: data['currentPage'] as int? ?? 1,
      totalPages: data['totalPages'] as int? ?? 1,
      nextCursor: data['nextCursor'] as String?,
    );
  }

  /// Parse API response to TransactionStatistics
  TransactionStatistics parseTransactionStatistics(Map<String, dynamic> data) {
    final countsByService = <TransactionServiceType, int>{};
    final countsByStatus = <UnifiedTransactionStatus, int>{};

    if (data['countsByService'] != null) {
      (data['countsByService'] as Map<String, dynamic>).forEach((key, value) {
        final serviceType = TransactionServiceType.fromString(key);
        countsByService[serviceType] = value as int;
      });
    }

    if (data['countsByStatus'] != null) {
      (data['countsByStatus'] as Map<String, dynamic>).forEach((key, value) {
        final status = UnifiedTransactionStatus.fromString(key);
        countsByStatus[status] = value as int;
      });
    }

    return TransactionStatistics(
      totalIncoming: (data['totalIncoming'] as num).toDouble(),
      totalOutgoing: (data['totalOutgoing'] as num).toDouble(),
      netBalance: (data['netBalance'] as num).toDouble(),
      totalTransactions: data['totalTransactions'] as int? ?? 0,
      transactionCountsByService: countsByService,
      transactionCountsByStatus: countsByStatus,
    );
  }
}
