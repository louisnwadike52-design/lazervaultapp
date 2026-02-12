import 'package:lazervault/src/generated/statistics.pbgrpc.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart';

/// Repository for budget management via StatisticsService
/// Routes through investment-gateway to statistics-service
class BudgetRepository {
  final StatisticsServiceClient _grpcClient;
  final AccountManager _accountManager;

  BudgetRepository({
    required StatisticsServiceClient grpcClient,
    required AccountManager accountManager,
  })  : _grpcClient = grpcClient,
        _accountManager = accountManager;

  /// Create a new budget
  Future<pb.CreateBudgetResponse> createBudget({
    required String name,
    required double amount,
    required String currency,
    required pb.ExpenseCategory category,
    required pb.BudgetPeriod period,
    DateTime? startDate,
    DateTime? endDate,
    bool enableAlerts = true,
    double alertThreshold = 80.0,
  }) async {
    final request = pb.CreateBudgetRequest()
      ..name = name
      ..amount = amount
      ..currency = currency
      ..category = category
      ..period = period
      ..enableAlerts = enableAlerts
      ..alertThreshold = alertThreshold;

    if (startDate != null) {
      request.startDate = Timestamp.fromDateTime(startDate);
    }
    if (endDate != null) {
      request.endDate = Timestamp.fromDateTime(endDate);
    }

    return retryWithBackoff(
      operation: () => _grpcClient.createBudget(request),
    );
  }

  /// Get budgets for the current user with optional filters
  Future<pb.GetBudgetsResponse> getBudgets({
    int page = 1,
    int perPage = 20,
    pb.BudgetStatus? status,
    pb.ExpenseCategory? category,
  }) async {
    final request = pb.GetBudgetsRequest()
      ..page = page
      ..perPage = perPage;

    if (status != null) {
      request.status = status;
    }
    if (category != null) {
      request.category = category;
    }

    return retryWithBackoff(
      operation: () => _grpcClient.getBudgets(request),
    );
  }

  /// Get a single budget by ID
  Future<pb.GetBudgetByIdResponse> getBudgetById(String budgetId) async {
    final request = pb.GetBudgetByIdRequest()..budgetId = budgetId;

    return retryWithBackoff(
      operation: () => _grpcClient.getBudgetById(request),
    );
  }

  /// Update an existing budget
  Future<pb.UpdateBudgetResponse> updateBudget({
    required String budgetId,
    String? name,
    double? amount,
    pb.BudgetPeriod? period,
    DateTime? startDate,
    DateTime? endDate,
    bool? enableAlerts,
    double? alertThreshold,
  }) async {
    final request = pb.UpdateBudgetRequest()..budgetId = budgetId;

    if (name != null) {
      request.name = name;
    }
    if (amount != null) {
      request.amount = amount;
    }
    if (period != null) {
      request.period = period;
    }
    if (startDate != null) {
      request.startDate = Timestamp.fromDateTime(startDate);
    }
    if (endDate != null) {
      request.endDate = Timestamp.fromDateTime(endDate);
    }
    if (enableAlerts != null) {
      request.enableAlerts = enableAlerts;
    }
    if (alertThreshold != null) {
      request.alertThreshold = alertThreshold;
    }

    return retryWithBackoff(
      operation: () => _grpcClient.updateBudget(request),
    );
  }

  /// Delete a budget (soft delete)
  Future<pb.DeleteBudgetResponse> deleteBudget(String budgetId) async {
    final request = pb.DeleteBudgetRequest()..budgetId = budgetId;

    return retryWithBackoff(
      operation: () => _grpcClient.deleteBudget(request),
    );
  }

  /// Get budget progress for analytics
  Future<pb.GetBudgetProgressResponse> getBudgetProgress({
    pb.BudgetPeriod? period,
  }) async {
    final request = pb.GetBudgetProgressRequest();

    if (period != null && period != pb.BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED) {
      request.period = period;
    }

    return retryWithBackoff(
      operation: () => _grpcClient.getBudgetProgress(request),
    );
  }

  /// Get budget alerts
  Future<pb.GetBudgetAlertsResponse> getBudgetAlerts({
    bool unreadOnly = false,
    int limit = 50,
  }) async {
    final request = pb.GetBudgetAlertsRequest()
      ..unreadOnly = unreadOnly
      ..limit = limit;

    return retryWithBackoff(
      operation: () => _grpcClient.getBudgetAlerts(request),
    );
  }

  /// Mark an alert as read
  Future<pb.MarkAlertAsReadResponse> markAlertAsRead(String alertId) async {
    final request = pb.MarkAlertAsReadRequest()..alertId = alertId;

    return retryWithBackoff(
      operation: () => _grpcClient.markAlertAsRead(request),
    );
  }
}
