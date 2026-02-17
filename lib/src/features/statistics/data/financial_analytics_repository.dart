import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/generated/accounts.pb.dart';

/// Repository for financial analytics data from accounts-service.
///
/// Uses AccountsGrpcClient (core-gateway -> accounts-service) instead of
/// the non-existent statistics microservice. All analytics are computed
/// server-side from real transaction data.
class FinancialAnalyticsRepository {
  final AccountsGrpcClient grpcClient;
  final AccountManager accountManager;

  FinancialAnalyticsRepository({
    required this.grpcClient,
    required this.accountManager,
  });

  String? get _accountId => accountManager.activeAccountId;

  /// Get financial analytics with period comparison (current vs previous)
  Future<GetFinancialAnalyticsResponse> getFinancialAnalytics({
    String period = 'month',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final accountId = _accountId;
    if (accountId == null || accountId.isEmpty) {
      return GetFinancialAnalyticsResponse();
    }

    return retryWithBackoff(
      operation: () => grpcClient.getFinancialAnalytics(
        accountId: accountId,
        period: period,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  /// Get category breakdown for income and expenses
  Future<GetCategoryAnalyticsResponse> getCategoryAnalytics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final accountId = _accountId;
    if (accountId == null || accountId.isEmpty) {
      return GetCategoryAnalyticsResponse();
    }

    return retryWithBackoff(
      operation: () => grpcClient.getCategoryAnalytics(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  /// Get monthly income/expense trends
  Future<GetMonthlyTrendsResponse> getMonthlyTrends({
    int months = 6,
  }) async {
    final accountId = _accountId;
    if (accountId == null || accountId.isEmpty) {
      return GetMonthlyTrendsResponse();
    }

    return retryWithBackoff(
      operation: () => grpcClient.getMonthlyTrends(
        accountId: accountId,
        months: months,
      ),
    );
  }

  /// Get daily expense time series
  Future<GetExpenseTimeSeriesResponse> getExpenseTimeSeries({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final accountId = _accountId;
    if (accountId == null || accountId.isEmpty) {
      return GetExpenseTimeSeriesResponse();
    }

    return retryWithBackoff(
      operation: () => grpcClient.getExpenseTimeSeries(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  /// Get failed and reversed transactions for the current period
  Future<GetTransactionHistoryResponse> getFailedTransactions({
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
  }) async {
    final accountId = _accountId;
    if (accountId == null || accountId.isEmpty) {
      return GetTransactionHistoryResponse();
    }

    // Fetch failed and reversed in parallel — handle each independently
    // so a failure in one doesn't discard the other
    Future<GetTransactionHistoryResponse?> safeFetch(String status) async {
      try {
        return await retryWithBackoff(
          operation: () => grpcClient.getTransactionHistory(
            accountId: accountId,
            status: status,
            startDate: startDate,
            endDate: endDate,
            limit: limit,
          ),
        );
      } catch (_) {
        return null;
      }
    }

    final results = await Future.wait([
      safeFetch('failed'),
      safeFetch('reversed'),
    ]);

    final failed = results[0];
    final reversed = results[1];

    // Merge whatever succeeded into a single response
    final merged = GetTransactionHistoryResponse();
    if (failed != null) {
      merged.transactions.addAll(failed.transactions);
      merged.total += failed.total;
    }
    if (reversed != null) {
      merged.transactions.addAll(reversed.transactions);
      merged.total += reversed.total;
    }

    // Sort by date descending
    if (merged.transactions.length > 1) {
      merged.transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return merged;
  }

  // ===== CATEGORY MANAGEMENT =====

  /// Get user's custom category mappings
  Future<GetUserCategoryMappingsResponse> getUserCategoryMappings() async {
    return retryWithBackoff(
      operation: () => grpcClient.getUserCategoryMappings(),
    );
  }

  /// Update a category mapping (rename, re-parent)
  Future<UpdateUserCategoryMappingResponse> updateUserCategoryMapping({
    required String originalCategory,
    required String customCategory,
    String parentCategory = '',
  }) async {
    return retryWithBackoff(
      operation: () => grpcClient.updateUserCategoryMapping(
        originalCategory: originalCategory,
        customCategory: customCategory,
        parentCategory: parentCategory,
      ),
    );
  }

  /// Reorder categories (batch update display order)
  Future<ReorderCategoriesResponse> reorderCategories({
    required List<CategoryOrderItem> orderings,
  }) async {
    return retryWithBackoff(
      operation: () => grpcClient.reorderCategories(orderings: orderings),
    );
  }
}
