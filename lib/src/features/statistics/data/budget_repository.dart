import 'package:lazervault/src/generated/statistics.pbgrpc.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart';

/// Repository for budget management via StatisticsService
/// Routes through investment-gateway to statistics-service
class BudgetRepository {
  final StatisticsServiceClient _grpcClient;
  final AccountManager _accountManager;
  final GrpcCallOptionsHelper _callOptionsHelper;

  BudgetRepository({
    required StatisticsServiceClient grpcClient,
    required AccountManager accountManager,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _grpcClient = grpcClient,
        _accountManager = accountManager,
        _callOptionsHelper = callOptionsHelper;

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
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
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
        operation: () => _grpcClient.createBudget(request, options: callOptions),
      );
    });
  }

  /// Get budgets for the current user with optional filters
  Future<pb.GetBudgetsResponse> getBudgets({
    int page = 1,
    int perPage = 20,
    pb.BudgetStatus? status,
    pb.ExpenseCategory? category,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
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
        operation: () => _grpcClient.getBudgets(request, options: callOptions),
      );
    });
  }

  /// Get a single budget by ID
  Future<pb.GetBudgetByIdResponse> getBudgetById(String budgetId) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.GetBudgetByIdRequest()..budgetId = budgetId;

      return retryWithBackoff(
        operation: () => _grpcClient.getBudgetById(request, options: callOptions),
      );
    });
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
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
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
        operation: () => _grpcClient.updateBudget(request, options: callOptions),
      );
    });
  }

  /// Delete a budget (soft delete)
  Future<pb.DeleteBudgetResponse> deleteBudget(String budgetId) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.DeleteBudgetRequest()..budgetId = budgetId;

      return retryWithBackoff(
        operation: () => _grpcClient.deleteBudget(request, options: callOptions),
      );
    });
  }

  /// Get budget progress for analytics
  Future<pb.GetBudgetProgressResponse> getBudgetProgress({
    pb.BudgetPeriod? period,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.GetBudgetProgressRequest();

      if (period != null && period != pb.BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED) {
        request.period = period;
      }

      return retryWithBackoff(
        operation: () => _grpcClient.getBudgetProgress(request, options: callOptions),
      );
    });
  }

  /// Get budget alerts
  Future<pb.GetBudgetAlertsResponse> getBudgetAlerts({
    bool unreadOnly = false,
    int limit = 50,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.GetBudgetAlertsRequest()
        ..unreadOnly = unreadOnly
        ..limit = limit;

      return retryWithBackoff(
        operation: () => _grpcClient.getBudgetAlerts(request, options: callOptions),
      );
    });
  }

  /// Mark an alert as read
  Future<pb.MarkAlertAsReadResponse> markAlertAsRead(String alertId) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.MarkAlertAsReadRequest()..alertId = alertId;

      return retryWithBackoff(
        operation: () => _grpcClient.markAlertAsRead(request, options: callOptions),
      );
    });
  }

  /// Get financial goals
  Future<pb.GetFinancialGoalsResponse> getFinancialGoals({
    pb.GoalStatus? status,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.GetFinancialGoalsRequest();
      if (status != null) {
        request.status = status;
      }

      return retryWithBackoff(
        operation: () => _grpcClient.getFinancialGoals(request, options: callOptions),
      );
    });
  }

  /// Create a new financial goal
  Future<pb.CreateFinancialGoalResponse> createFinancialGoal({
    required String name,
    required pb.GoalType goalType,
    required double targetAmount,
    double currentAmount = 0,
    double monthlyContribution = 0,
    String currency = 'NGN',
    DateTime? targetDate,
    String? icon,
    String? color,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.CreateFinancialGoalRequest()
        ..name = name
        ..goalType = goalType
        ..targetAmount = targetAmount
        ..currentAmount = currentAmount
        ..monthlyContribution = monthlyContribution
        ..currency = currency;

      if (targetDate != null) {
        request.targetDate = Timestamp.fromDateTime(targetDate);
      }
      if (icon != null) request.icon = icon;
      if (color != null) request.color = color;

      return retryWithBackoff(
        operation: () => _grpcClient.createFinancialGoal(request, options: callOptions),
      );
    });
  }

  /// Update financial goal progress (add contribution)
  Future<pb.UpdateFinancialGoalProgressResponse> updateFinancialGoalProgress({
    required String goalId,
    required double amountToAdd,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.UpdateFinancialGoalProgressRequest()
        ..goalId = goalId
        ..amountToAdd = amountToAdd;

      return retryWithBackoff(
        operation: () => _grpcClient.updateFinancialGoalProgress(request, options: callOptions),
      );
    });
  }

  /// Get upcoming/recurring bills
  Future<pb.GetUpcomingBillsResponse> getUpcomingBills({
    int daysAhead = 30,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.GetUpcomingBillsRequest()..daysAhead = daysAhead;

      return retryWithBackoff(
        operation: () => _grpcClient.getUpcomingBills(request, options: callOptions),
      );
    });
  }

  /// Create a recurring bill
  Future<pb.CreateRecurringBillResponse> createRecurringBill({
    required String name,
    required double amount,
    required String currency,
    required pb.ExpenseCategory category,
    required String recurrencePattern,
    DateTime? nextDueDate,
    String? merchant,
    String? icon,
    bool autoPayEnabled = false,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.CreateRecurringBillRequest()
        ..name = name
        ..amount = amount
        ..currency = currency
        ..category = category
        ..recurrencePattern = recurrencePattern
        ..autoPayEnabled = autoPayEnabled;

      if (nextDueDate != null) {
        request.nextDueDate = Timestamp.fromDateTime(nextDueDate);
      }
      if (merchant != null) request.merchant = merchant;
      if (icon != null) request.icon = icon;

      return retryWithBackoff(
        operation: () => _grpcClient.createRecurringBill(request, options: callOptions),
      );
    });
  }

  /// Get service categories from backend
  Future<pb.GetServiceCategoriesResponse> getServiceCategories({
    required String serviceName,
    bool activeOnly = true,
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.GetServiceCategoriesRequest()
        ..serviceName = serviceName
        ..activeOnly = activeOnly;

      return retryWithBackoff(
        operation: () => _grpcClient.getServiceCategories(request, options: callOptions),
      );
    });
  }

  /// Create a custom category
  Future<pb.CreateCustomCategoryResponse> createCustomCategory({
    required String serviceName,
    required String displayName,
    int budgetCategory = 16,
    String icon = 'category',
    String color = '#95A5A6',
  }) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.CreateCustomCategoryRequest()
        ..serviceName = serviceName
        ..displayName = displayName
        ..budgetCategory = budgetCategory
        ..icon = icon
        ..color = color;

      return retryWithBackoff(
        operation: () => _grpcClient.createCustomCategory(request, options: callOptions),
      );
    });
  }

  /// Delete a custom category
  Future<pb.DeleteCustomCategoryResponse> deleteCustomCategory(String categoryId) async {
    return _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = pb.DeleteCustomCategoryRequest()..categoryId = categoryId;

      return retryWithBackoff(
        operation: () => _grpcClient.deleteCustomCategory(request, options: callOptions),
      );
    });
  }
}
