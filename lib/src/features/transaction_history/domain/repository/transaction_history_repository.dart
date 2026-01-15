import 'package:lazervault/core/types/unified_transaction.dart';

/// Abstract repository for transaction history operations
abstract class TransactionHistoryRepository {
  /// Fetch all transactions (for dashboard)
  Future<TransactionListResponse> fetchAllTransactions({
    int page = 1,
    int limit = 20,
    String? cursor,
    TransactionFilters? filters,
  });

  /// Fetch transactions for a specific service type
  Future<TransactionListResponse> fetchServiceTransactions(
    TransactionServiceType serviceType, {
    int page = 1,
    int limit = 20,
    String? cursor,
    TransactionFilters? filters,
  });

  /// Fetch transaction by ID
  Future<UnifiedTransaction?> fetchTransactionById(String id);

  /// Search transactions
  Future<List<UnifiedTransaction>> searchTransactions(String query);

  /// Get transaction statistics
  Future<TransactionStatistics> getStatistics({
    TransactionServiceType? serviceType,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Refresh transactions from server
  Future<void> refreshTransactions();

  /// Cache transactions locally
  Future<void> cacheTransactions(List<UnifiedTransaction> transactions);

  /// Get cached transactions
  Future<List<UnifiedTransaction>> getCachedTransactions();
}
