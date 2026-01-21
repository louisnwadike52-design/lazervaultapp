import 'package:fixnum/fixnum.dart';
import '../../../core/network/grpc_client.dart';
import '../../../core/network/retry_helper.dart';
import '../../../generated/statistics.pb.dart' as pb;
import '../../../generated/google/protobuf/timestamp.pb.dart' as timestamp_pb;

/// Repository for statistics, expenses, and budgets operations
/// Wraps the gRPC StatisticsServiceClient with retry logic and error handling
class StatisticsRepository {
  final GrpcClient grpcClient;

  StatisticsRepository({required this.grpcClient});

  /// Create a new expense
  Future<pb.ExpenseMessage> createExpense({
    required double amount,
    required String currency,
    required pb.ExpenseCategory category,
    required DateTime transactionDate,
    String? description,
    String? merchant,
    String? accountId,
    String? subcategory,
    String? paymentMethod,
    String? receiptUrl,
    List<String>? tags,
    String? notes,
    bool isRecurring = false,
    String? recurrencePattern,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CreateExpenseRequest()
          ..amount = amount
          ..currency = currency
          ..category = category
          ..transactionDate = _toProtoTimestamp(transactionDate);

        if (description != null) request.description = description;
        if (merchant != null) request.merchant = merchant;
        if (accountId != null) request.accountId = accountId;
        if (subcategory != null) request.subcategory = subcategory;
        if (paymentMethod != null) request.paymentMethod = paymentMethod;
        if (receiptUrl != null) request.receiptUrl = receiptUrl;
        if (tags != null) request.tags.addAll(tags);
        if (notes != null) request.notes = notes;
        request.isRecurring = isRecurring;
        if (recurrencePattern != null) request.recurrencePattern = recurrencePattern;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.createExpense(
          request,
          options: options,
        );

        return response.expense;
      },
    );
  }

  /// Get all expenses with optional filtering
  Future<List<pb.ExpenseMessage>> getExpenses({
    DateTime? startDate,
    DateTime? endDate,
    pb.ExpenseCategory? category,
    int page = 1,
    int limit = 100,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetExpensesRequest()
          ..page = page
          ..perPage = limit;

        if (startDate != null) {
          request.startDate = _toProtoTimestamp(startDate);
        }
        if (endDate != null) {
          request.endDate = _toProtoTimestamp(endDate);
        }
        if (category != null) {
          request.category = category;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getExpenses(
          request,
          options: options,
        );

        return response.expenses;
      },
    );
  }

  /// Create a new budget
  Future<pb.BudgetMessage> createBudget({
    required String name,
    required double amount,
    required String currency,
    required pb.BudgetPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    pb.ExpenseCategory? category,
    double? alertThreshold,
    String? description,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CreateBudgetRequest()
          ..name = name
          ..amount = amount
          ..currency = currency
          ..period = period
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate);

        if (category != null) request.category = category;
        if (alertThreshold != null) request.alertThreshold = alertThreshold;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.createBudget(
          request,
          options: options,
        );

        return response.budget;
      },
    );
  }

  /// Get all budgets
  Future<List<pb.BudgetMessage>> getBudgets({
    pb.BudgetStatus? status,
    pb.ExpenseCategory? category,
    int page = 1,
    int limit = 100,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetBudgetsRequest()
          ..page = page
          ..perPage = limit;

        if (status != null) {
          request.status = status;
        }
        if (category != null) {
          request.category = category;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getBudgets(
          request,
          options: options,
        );

        return response.budgets;
      },
    );
  }

  /// Get spending analytics for a period
  Future<pb.SpendingAnalytics> getSpendingAnalytics({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetSpendingAnalyticsRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getSpendingAnalytics(
          request,
          options: options,
        );

        return response.analytics;
      },
    );
  }

  /// Get category breakdown for spending
  Future<List<pb.CategorySpending>> getCategoryBreakdown({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetCategoryBreakdownRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getCategoryBreakdown(
          request,
          options: options,
        );

        return response.categories;
      },
    );
  }

  /// Get budget progress and status
  Future<List<pb.BudgetProgressItem>> getBudgetProgress() async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetBudgetProgressRequest();

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getBudgetProgress(
          request,
          options: options,
        );

        return response.budgets;
      },
    );
  }

  /// Update an existing expense
  Future<pb.ExpenseMessage> updateExpense({
    required String expenseId,
    double? amount,
    String? currency,
    pb.ExpenseCategory? category,
    DateTime? transactionDate,
    String? description,
    String? merchant,
    String? accountId,
    String? subcategory,
    String? paymentMethod,
    String? receiptUrl,
    List<String>? tags,
    String? notes,
    bool? isRecurring,
    String? recurrencePattern,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.UpdateExpenseRequest()
          ..expenseId = expenseId;

        if (amount != null) request.amount = amount;
        if (category != null) request.category = category;
        if (transactionDate != null) request.transactionDate = _toProtoTimestamp(transactionDate);
        if (description != null) request.description = description;
        if (merchant != null) request.merchant = merchant;
        if (subcategory != null) request.subcategory = subcategory;
        if (paymentMethod != null) request.paymentMethod = paymentMethod;
        if (tags != null) request.tags.addAll(tags);
        if (notes != null) request.notes = notes;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.updateExpense(
          request,
          options: options,
        );

        return response.expense;
      },
    );
  }

  /// Delete an expense
  Future<void> deleteExpense(String expenseId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.DeleteExpenseRequest()..expenseId = expenseId;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.deleteExpense(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception('Failed to delete expense');
        }
      },
    );
  }

  /// Update a budget
  Future<pb.BudgetMessage> updateBudget({
    required String budgetId,
    String? name,
    double? amount,
    String? currency,
    pb.BudgetPeriod? period,
    DateTime? startDate,
    DateTime? endDate,
    pb.ExpenseCategory? category,
    double? alertThreshold,
    String? description,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.UpdateBudgetRequest()
          ..budgetId = budgetId;

        if (name != null) request.name = name;
        if (amount != null) request.amount = amount;
        if (period != null) request.period = period;
        if (startDate != null) request.startDate = _toProtoTimestamp(startDate);
        if (endDate != null) request.endDate = _toProtoTimestamp(endDate);
        if (alertThreshold != null) request.alertThreshold = alertThreshold;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.updateBudget(
          request,
          options: options,
        );

        return response.budget;
      },
    );
  }

  /// Delete a budget
  Future<void> deleteBudget(String budgetId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.DeleteBudgetRequest()..budgetId = budgetId;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.deleteBudget(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception('Failed to delete budget');
        }
      },
    );
  }

  // Helper: Convert DateTime to protobuf Timestamp
  timestamp_pb.Timestamp _toProtoTimestamp(DateTime dateTime) {
    final milliseconds = dateTime.millisecondsSinceEpoch;
    final seconds = milliseconds ~/ 1000;
    final nanos = (milliseconds % 1000) * 1000000;

    return timestamp_pb.Timestamp()
      ..seconds = Int64(seconds)
      ..nanos = nanos;
  }

  // Helper: Convert protobuf Timestamp to DateTime
  static DateTime fromProtoTimestamp(timestamp_pb.Timestamp timestamp) {
    final milliseconds = timestamp.seconds.toInt() * 1000 +
        (timestamp.nanos ~/ 1000000);
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  // ====================
  // AI-POWERED FEATURES
  // ====================

  /// Get AI-powered spending insights
  Future<pb.GetAISpendingInsightsResponse> getAISpendingInsights({
    required DateTime startDate,
    required DateTime endDate,
    String focusArea = 'savings',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetAISpendingInsightsRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate)
          ..focusArea = focusArea;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getAISpendingInsights(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  /// Get AI-powered budgeting recommendations
  Future<pb.GetAIBudgetingRecommendationsResponse> getAIBudgetingRecommendations({
    required double monthlyIncome,
    required List<String> financialGoals,
    String riskTolerance = 'moderate',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetAIBudgetingRecommendationsRequest()
          ..monthlyIncome = monthlyIncome
          ..financialGoals.addAll(financialGoals)
          ..riskTolerance = riskTolerance;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getAIBudgetingRecommendations(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  /// Auto-categorize an expense using AI
  Future<pb.AutoCategorizeExpenseResponse> autoCategorizeExpense({
    required String description,
    String? merchant,
    double? amount,
    String? notes,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.AutoCategorizeExpenseRequest()
          ..description = description;

        if (merchant != null) request.merchant = merchant;
        if (amount != null) request.amount = amount;
        if (notes != null) request.notes = notes;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.autoCategorizeExpense(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  /// Get AI-powered financial advice
  Future<pb.GetAIFinancialAdviceResponse> getAIFinancialAdvice({
    required String query,
    List<String> contextAreas = const ['spending', 'budgeting', 'savings'],
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetAIFinancialAdviceRequest()
          ..query = query
          ..contextAreas.addAll(contextAreas);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getAIFinancialAdvice(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  // ========================================
  // INCOME MANAGEMENT
  // ========================================

  /// Get all income sources
  Future<pb.GetIncomeSourcesResponse> getIncomeSources({
    bool activeOnly = true,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetIncomeSourcesRequest()
          ..activeOnly = activeOnly;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getIncomeSources(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  /// Get income breakdown
  Future<pb.GetIncomeBreakdownResponse> getIncomeBreakdown({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetIncomeBreakdownRequest();

        if (startDate != null) {
          request.startDate = _toProtoTimestamp(startDate);
        }
        if (endDate != null) {
          request.endDate = _toProtoTimestamp(endDate);
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getIncomeBreakdown(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  // ========================================
  // INVESTMENT MANAGEMENT
  // ========================================

  /// Get investment portfolio
  Future<pb.GetInvestmentPortfolioResponse> getInvestmentPortfolio() async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetInvestmentPortfolioRequest();

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getInvestmentPortfolio(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  // ========================================
  // FINANCIAL GOALS MANAGEMENT
  // ========================================

  /// Get financial goals
  Future<pb.GetFinancialGoalsResponse> getFinancialGoals({
    pb.GoalStatus? status,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetFinancialGoalsRequest();

        if (status != null) {
          request.status = status;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getFinancialGoals(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  // ========================================
  // SAVINGS GOAL MANAGEMENT
  // ========================================

  /// Get savings goal
  Future<pb.GetSavingsGoalResponse> getSavingsGoal() async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetSavingsGoalRequest();

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getSavingsGoal(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  // ========================================
  // RECURRING BILLS MANAGEMENT
  // ========================================

  /// Get upcoming bills
  Future<pb.GetUpcomingBillsResponse> getUpcomingBills({
    int daysAhead = 30,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetUpcomingBillsRequest()
          ..daysAhead = daysAhead;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getUpcomingBills(
          request,
          options: options,
        );

        return response;
      },
    );
  }

  // ========================================
  // TRACKED TRANSACTIONS (AUTOMATIC)
  // ========================================

  /// Get tracked income total for a period
  Future<double> getTrackedIncome({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetTrackedIncomeRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getTrackedIncome(
          request,
          options: options,
        );

        return response.totalIncome;
      },
    );
  }

  /// Get tracked expenditure total for a period
  Future<double> getTrackedExpenditure({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetTrackedExpenditureRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getTrackedExpenditure(
          request,
          options: options,
        );

        return response.totalExpenditure;
      },
    );
  }

  /// Get tracked income breakdown by source type
  Future<Map<String, double>> getTrackedIncomeBreakdown({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetTrackedIncomeBreakdownRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getTrackedIncomeBreakdown(
          request,
          options: options,
        );

        return response.breakdownBySource;
      },
    );
  }

  /// Get tracked expenditure breakdown by expense type
  Future<Map<String, double>> getTrackedExpenditureBreakdown({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetTrackedExpenditureBreakdownRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getTrackedExpenditureBreakdown(
          request,
          options: options,
        );

        return response.breakdownByType;
      },
    );
  }

  /// Get tracked income transactions
  Future<List<pb.TrackedIncomeTransaction>> getTrackedIncomeTransactions({
    required DateTime startDate,
    required DateTime endDate,
    int limit = 100,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetTrackedIncomeTransactionsRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate)
          ..limit = limit;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getTrackedIncomeTransactions(
          request,
          options: options,
        );

        return response.transactions;
      },
    );
  }

  /// Get tracked expenditure transactions
  Future<List<pb.TrackedExpenditureTransaction>> getTrackedExpenditureTransactions({
    required DateTime startDate,
    required DateTime endDate,
    int limit = 100,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetTrackedExpenditureTransactionsRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate)
          ..limit = limit;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getTrackedExpenditureTransactions(
          request,
          options: options,
        );

        return response.transactions;
      },
    );
  }

  /// Get comprehensive financial summary (combines manual + tracked data)
  Future<pb.ComprehensiveFinancialSummary> getComprehensiveFinancialSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetComprehensiveFinancialSummaryRequest()
          ..startDate = _toProtoTimestamp(startDate)
          ..endDate = _toProtoTimestamp(endDate);

        final options = await grpcClient.callOptions;
        final response = await grpcClient.statisticsClient.getComprehensiveFinancialSummary(
          request,
          options: options,
        );

        return response.summary;
      },
    );
  }

  // ========================================
  // FINANCIAL WRAPPED
  // ========================================
  // TODO: Implement when proto types are available
  // /// Get Financial Wrapped experience data
  // Future<pb.FinancialWrapped> getFinancialWrapped({
  //   required pb.WrappedPeriod period,
  //   int? year,
  //   int? month,
  // }) async {
  //   return retryWithBackoff(
  //     operation: () async {
  //       final request = pb.GetFinancialWrappedRequest()
  //         ..period = period;
  //
  //       if (year != null) {
  //         request.year = year;
  //       }
  //       if (month != null) {
  //         request.month = month;
  //       }
  //
  //       final options = await grpcClient.callOptions;
  //       final response = await grpcClient.statisticsClient.getFinancialWrapped(
  //         request,
  //         options: options,
  //       );
  //
  //       if (!response.success) {
  //         throw Exception(response.error.isNotEmpty
  //             ? response.error
  //             : 'Failed to get financial wrapped');
  //       }
  //
  //       return response.wrapped;
  //     },
  //   );
  // }
}
