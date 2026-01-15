import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/http/transaction_history_http_client.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/datasources/transaction_history_cache_datasource.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';
import 'package:intl/intl.dart';

/// Production-ready Transaction History Repository
/// - No mock data
/// - Connects to actual microservices via HTTP
/// - Implements local caching with SQLite
/// - Handles all edge cases production-grade
class TransactionHistoryRepositoryFinal implements TransactionHistoryRepository {
  final TransactionHistoryHttpClient httpClient;
  final TransactionHistoryCacheDataSource cacheDataSource;
  final FlutterSecureStorage storage;

  // Cache TTL - 5 minutes
  static const _cacheTTL = Duration(minutes: 5);

  TransactionHistoryRepositoryFinal({
    required String baseUrl,
    String? authToken,
  })  : httpClient = TransactionHistoryHttpClient(
          baseUrl: baseUrl,
          authToken: authToken,
        ),
        cacheDataSource = TransactionHistoryCacheDataSource(),
        storage = const FlutterSecureStorage();

  @override
  Future<TransactionListResponse> fetchAllTransactions({
    int page = 1,
    int limit = 20,
    String? cursor,
    TransactionFilters? filters,
  }) async {
    try {
      final userId = await storage.read(key: 'user_id');
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Try cache first
      if (page == 1 && !_shouldBypassCache(filters)) {
        try {
          final cached = await cacheDataSource.getCachedTransactions(
            userId: userId,
            limit: limit,
          );

          if (cached.isNotEmpty) {
            return TransactionListResponse(
              transactions: cached,
              hasMore: false, // Cache might not have all data
              currentPage: page,
              totalPages: 1,
              nextCursor: null,
            );
          }
        } catch (e) {
          // Cache miss or error, continue to network
        }
      }

      // Prepare request parameters
      final serviceType = filters?.serviceTypes?.isEmpty == false
          ? _getFirstServiceType(filters!.serviceTypes!)
          : null;

      final statuses = filters?.statuses?.map((s) => s.index).toList();

      final startDate = filters?.startDate?.toIso8601String();
      final endDate = filters?.endDate?.toIso8601String();

      // Fetch from network
      final response = await httpClient.getTransactionHistory(
        userId: userId,
        page: page,
        limit: limit,
        serviceType: serviceType?.toString().split('.').last,
        statuses: statuses,
        startDate: startDate,
        endDate: endDate,
        minAmount: filters?.minAmount,
        maxAmount: filters?.maxAmount,
        searchQuery: filters?.searchQuery,
      );

      // Parse response
      final transactions = (response['transactions'] as List)
          .map((item) => UnifiedTransaction.fromJson(item as Map<String, dynamic>))
          .toList();

      // Cache the results
      if (page == 1 && transactions.isNotEmpty) {
        try {
          await cacheDataSource.cacheTransactions(
            userId,
            transactions,
            _cacheTTL,
          );
        } catch (e) {
          // Cache failure is not critical
        }
      }

      return TransactionListResponse(
        transactions: transactions,
        hasMore: response['has_more'] as bool? ?? false,
        currentPage: response['current_page'] as int? ?? page,
        totalPages: response['total_pages'] as int? ?? 1,
        nextCursor: response['next_cursor'] as String?,
      );
    } catch (e) {
      throw Exception('Failed to fetch transaction history: $e');
    }
  }

  @override
  Future<TransactionListResponse> fetchServiceTransactions(
    TransactionServiceType serviceType, {
    int page = 1,
    int limit = 20,
    String? cursor,
    TransactionFilters? filters,
  }) async {
    try {
      final userId = await storage.read(key: 'user_id');
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Try cache first for page 1
      if (page == 1) {
        try {
          final cached = await cacheDataSource.getCachedTransactions(
            userId: userId,
            serviceType: serviceType,
            limit: limit,
          );

          if (cached.isNotEmpty) {
            // Apply additional filters
            var filtered = cached;
            if (filters?.statuses != null && filters!.statuses!.isNotEmpty) {
              filtered = filtered.where((t) => filters.statuses!.contains(t.status)).toList();
            }
            if (filters?.searchQuery != null && filters!.searchQuery!.isNotEmpty) {
              final query = filters.searchQuery!.toLowerCase();
              filtered = filtered.where((t) =>
                  t.title.toLowerCase().contains(query) ||
                  (t.description?.toLowerCase().contains(query) ?? false)).toList();
            }

            return TransactionListResponse(
              transactions: filtered,
              hasMore: false,
              currentPage: page,
              totalPages: 1,
              nextCursor: null,
            );
          }
        } catch (e) {
          // Cache miss, continue to network
        }
      }

      final statuses = filters?.statuses?.map((s) => s.index).toList();

      final response = await httpClient.getTransactionHistory(
        userId: userId,
        page: page,
        limit: limit,
        serviceType: serviceType.toString().split('.').last,
        statuses: statuses,
        searchQuery: filters?.searchQuery,
      );

      final transactions = (response['transactions'] as List)
          .map((item) => UnifiedTransaction.fromJson(item as Map<String, dynamic>))
          .toList();

      // Cache if first page
      if (page == 1 && transactions.isNotEmpty) {
        try {
          await cacheDataSource.cacheTransactions(
            userId,
            transactions,
            _cacheTTL,
          );
        } catch (e) {
          // Cache failure is not critical
        }
      }

      return TransactionListResponse(
        transactions: transactions,
        hasMore: response['has_more'] as bool? ?? false,
        currentPage: response['current_page'] as int? ?? page,
        totalPages: response['total_pages'] as int? ?? 1,
        nextCursor: response['next_cursor'] as String?,
      );
    } catch (e) {
      throw Exception('Failed to fetch service transactions: $e');
    }
  }

  @override
  Future<UnifiedTransaction?> fetchTransactionById(String id) async {
    try {
      // Try cache first
      try {
        final cached = await cacheDataSource.getCachedTransaction(id);
        if (cached != null) {
          return cached;
        }
      } catch (e) {
        // Cache miss, continue to network
      }

      final userId = await storage.read(key: 'user_id');
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final response = await httpClient.getTransactionDetails(
        userId: userId,
        transactionId: id,
      );

      final transaction = UnifiedTransaction.fromJson(
        response['transaction'] as Map<String, dynamic>,
      );

      // Cache the result
      try {
        await cacheDataSource.cacheTransactions(
          userId,
          [transaction],
          _cacheTTL,
        );
      } catch (e) {
        // Cache failure is not critical
      }

      return transaction;
    } catch (e) {
      if (e.toString().contains('not found')) {
        return null;
      }
      throw Exception('Failed to fetch transaction: $e');
    }
  }

  @override
  Future<List<UnifiedTransaction>> searchTransactions(String query) async {
    try {
      final userId = await storage.read(key: 'user_id');
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final response = await httpClient.searchTransactions(
        userId: userId,
        query: query,
      );

      return (response['transactions'] as List)
          .map((item) => UnifiedTransaction.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search transactions: $e');
    }
  }

  @override
  Future<TransactionStatistics> getStatistics({
    TransactionServiceType? serviceType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final userId = await storage.read(key: 'user_id');
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final response = await httpClient.getTransactionStatistics(
        userId: userId,
        serviceType: serviceType?.toString().split('.').last,
        startDate: startDate?.toIso8601String(),
        endDate: endDate?.toIso8601String(),
      );

      final countsByService = <TransactionServiceType, int>{};
      final countsByServiceRaw =
          response['transaction_counts_by_service'] as Map<String, dynamic>?;
      if (countsByServiceRaw != null) {
        countsByServiceRaw.forEach((key, value) {
          final serviceIndex = int.tryParse(key) ?? 0;
          if (serviceIndex < TransactionServiceType.values.length) {
            countsByService[TransactionServiceType.values[serviceIndex]] =
                (value as num).toInt();
          }
        });
      }

      final countsByStatus = <UnifiedTransactionStatus, int>{};
      final countsByStatusRaw =
          response['transaction_counts_by_status'] as Map<String, dynamic>?;
      if (countsByStatusRaw != null) {
        countsByStatusRaw.forEach((key, value) {
          final statusIndex = int.tryParse(key) ?? 0;
          if (statusIndex < UnifiedTransactionStatus.values.length) {
            countsByStatus[UnifiedTransactionStatus.values[statusIndex]] =
                (value as num).toInt();
          }
        });
      }

      return TransactionStatistics(
        totalIncoming: (response['total_incoming'] as num).toDouble(),
        totalOutgoing: (response['total_outgoing'] as num).toDouble(),
        netBalance: (response['net_balance'] as num).toDouble(),
        totalTransactions: (response['total_transactions'] as num).toInt(),
        transactionCountsByService: countsByService,
        transactionCountsByStatus: countsByStatus,
      );
    } catch (e) {
      throw Exception('Failed to fetch statistics: $e');
    }
  }

  @override
  Future<void> refreshTransactions() async {
    try {
      final userId = await storage.read(key: 'user_id');
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      await httpClient.refreshTransactions(userId: userId);

      // Clear cache after refresh
      await cacheDataSource.clearUserTransactions(userId);
    } catch (e) {
      throw Exception('Failed to refresh transactions: $e');
    }
  }

  @override
  Future<void> cacheTransactions(List<UnifiedTransaction> transactions) async {
    final userId = await storage.read(key: 'user_id');
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await cacheDataSource.cacheTransactions(
      userId,
      transactions,
      _cacheTTL,
    );
  }

  @override
  Future<List<UnifiedTransaction>> getCachedTransactions() async {
    final userId = await storage.read(key: 'user_id');
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return await cacheDataSource.getCachedTransactions(userId: userId);
  }

  // Helper methods
  bool _shouldBypassCache(TransactionFilters? filters) {
    // Bypass cache if there are filters that can't be handled locally
    if (filters == null || !filters.hasFilters) return false;

    // Date range filters bypass cache
    if (filters.startDate != null || filters.endDate != null) return true;

    // Amount range filters bypass cache
    if (filters.minAmount != null || filters.maxAmount != null) return true;

    return false;
  }

  String _getFirstServiceType(List<TransactionServiceType> types) {
    return types.first.toString().split('.').last;
  }
}
