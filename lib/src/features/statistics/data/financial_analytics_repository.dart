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
}
