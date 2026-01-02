import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/statistics.pb.dart';
import '../data/statistics_repository.dart';
import 'statistics_state.dart';

/// Cubit for managing statistics, expenses, and budgets state
class StatisticsCubit extends Cubit<StatisticsState> {
  final StatisticsRepository repository;

  StatisticsCubit({required this.repository}) : super(StatisticsInitial());

  /// Load all statistics data (expenses, budgets, analytics)
  /// Loads data for the specified date range
  Future<void> loadStatistics({
    DateTime? startDate,
    DateTime? endDate,
    ExpenseCategory? category,
  }) async {
    try {
      if (isClosed) return;
      emit(const StatisticsLoading(loadingMessage: 'Loading statistics...'));

      // Default to current month if no dates provided
      final start = startDate ?? DateTime(DateTime.now().year, DateTime.now().month, 1);
      final end = endDate ?? DateTime.now();

      // Load all data in parallel
      final results = await Future.wait([
        repository.getExpenses(
          startDate: start,
          endDate: end,
          category: category,
        ),
        repository.getBudgets(category: category),
        repository.getSpendingAnalytics(startDate: start, endDate: end),
        repository.getCategoryBreakdown(startDate: start, endDate: end),
        repository.getBudgetProgress(),
        repository.getIncomeSources(activeOnly: true),
        repository.getIncomeBreakdown(),
        repository.getInvestmentPortfolio(),
        repository.getFinancialGoals(status: GoalStatus.GOAL_STATUS_IN_PROGRESS),
        repository.getSavingsGoal(),
        repository.getUpcomingBills(daysAhead: 30),
        // Tracked transactions (automatic)
        repository.getComprehensiveFinancialSummary(startDate: start, endDate: end),
        repository.getTrackedIncome(startDate: start, endDate: end),
        repository.getTrackedExpenditure(startDate: start, endDate: end),
        repository.getTrackedIncomeBreakdown(startDate: start, endDate: end),
        repository.getTrackedExpenditureBreakdown(startDate: start, endDate: end),
        repository.getTrackedIncomeTransactions(startDate: start, endDate: end),
        repository.getTrackedExpenditureTransactions(startDate: start, endDate: end),
      ]);

      final incomeSourcesResponse = results[5] as GetIncomeSourcesResponse;
      final incomeBreakdownResponse = results[6] as GetIncomeBreakdownResponse;
      final investmentPortfolioResponse = results[7] as GetInvestmentPortfolioResponse;
      final financialGoalsResponse = results[8] as GetFinancialGoalsResponse;
      final savingsGoalResponse = results[9] as GetSavingsGoalResponse;
      final upcomingBillsResponse = results[10] as GetUpcomingBillsResponse;
      final comprehensiveSummary = results[11] as ComprehensiveFinancialSummary;
      final trackedIncome = results[12] as double;
      final trackedExpenditure = results[13] as double;
      final trackedIncomeBreakdown = results[14] as Map<String, double>;
      final trackedExpenditureBreakdown = results[15] as Map<String, double>;
      final trackedIncomeTransactions = results[16] as List<TrackedIncomeTransaction>;
      final trackedExpenditureTransactions = results[17] as List<TrackedExpenditureTransaction>;

      if (isClosed) return;
      emit(StatisticsLoaded(
        expenses: results[0] as List<ExpenseMessage>,
        budgets: results[1] as List<BudgetMessage>,
        analytics: results[2] as SpendingAnalytics,
        categoryBreakdown: results[3] as List<CategorySpending>,
        budgetProgress: results[4] as List<BudgetProgressItem>,
        startDate: start,
        endDate: end,
        selectedCategory: category,
        incomeSources: incomeSourcesResponse.incomeSources,
        totalMonthlyIncome: incomeSourcesResponse.totalMonthlyIncome,
        incomeBreakdown: incomeBreakdownResponse.breakdown,
        investments: investmentPortfolioResponse.portfolio.investments,
        investmentPortfolio: investmentPortfolioResponse.portfolio,
        financialGoals: financialGoalsResponse.goalsList.goals,
        savingsGoal: savingsGoalResponse.hasGoal ? savingsGoalResponse.savingsGoal : null,
        upcomingBills: upcomingBillsResponse.billsList,
        comprehensiveSummary: comprehensiveSummary,
        trackedIncome: trackedIncome,
        trackedExpenditure: trackedExpenditure,
        trackedIncomeBreakdown: trackedIncomeBreakdown,
        trackedExpenditureBreakdown: trackedExpenditureBreakdown,
        trackedIncomeTransactions: trackedIncomeTransactions,
        trackedExpenditureTransactions: trackedExpenditureTransactions,
      ));
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to load statistics: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Load only expenses
  Future<void> loadExpenses({
    DateTime? startDate,
    DateTime? endDate,
    ExpenseCategory? category,
  }) async {
    try {
      if (state is StatisticsLoaded) {
        final currentState = state as StatisticsLoaded;
        if (isClosed) return;
        emit(currentState.copyWith(isRefreshing: true));

        final start = startDate ?? currentState.startDate;
        final end = endDate ?? currentState.endDate;
        final cat = category ?? currentState.selectedCategory;

        final expenses = await repository.getExpenses(
          startDate: start,
          endDate: end,
          category: cat,
        );

        if (isClosed) return;
        emit(currentState.copyWith(
          expenses: expenses,
          startDate: start,
          endDate: end,
          selectedCategory: cat,
          isRefreshing: false,
        ));
      } else {
        await loadStatistics(
          startDate: startDate,
          endDate: endDate,
          category: category,
        );
      }
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to load expenses: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Create a new expense
  Future<void> createExpense({
    required double amount,
    required String currency,
    required ExpenseCategory category,
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
    try {
      if (isClosed) return;
      emit(ExpenseCreating(amount: amount, category: category));

      final expense = await repository.createExpense(
        amount: amount,
        currency: currency,
        category: category,
        transactionDate: transactionDate,
        description: description,
        merchant: merchant,
        accountId: accountId,
        subcategory: subcategory,
        paymentMethod: paymentMethod,
        receiptUrl: receiptUrl,
        tags: tags,
        notes: notes,
        isRecurring: isRecurring,
        recurrencePattern: recurrencePattern,
      );

      if (isClosed) return;
      emit(ExpenseCreated(expense: expense));

      // Reload all statistics to reflect the new expense
      await loadStatistics();
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to create expense: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Update an existing expense
  Future<void> updateExpense({
    required String expenseId,
    double? amount,
    String? currency,
    ExpenseCategory? category,
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
    try {
      if (isClosed) return;
      emit(ExpenseUpdating(expenseId: expenseId));

      final expense = await repository.updateExpense(
        expenseId: expenseId,
        amount: amount,
        currency: currency,
        category: category,
        transactionDate: transactionDate,
        description: description,
        merchant: merchant,
        accountId: accountId,
        subcategory: subcategory,
        paymentMethod: paymentMethod,
        receiptUrl: receiptUrl,
        tags: tags,
        notes: notes,
        isRecurring: isRecurring,
        recurrencePattern: recurrencePattern,
      );

      if (isClosed) return;
      emit(ExpenseUpdated(expense: expense));

      // Reload statistics
      await loadStatistics();
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to update expense: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Delete an expense
  Future<void> deleteExpense(String expenseId) async {
    try {
      if (isClosed) return;
      emit(ExpenseDeleting(expenseId: expenseId));

      await repository.deleteExpense(expenseId);

      if (isClosed) return;
      emit(ExpenseDeleted(expenseId: expenseId));

      // Reload statistics
      await loadStatistics();
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to delete expense: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Load only budgets
  Future<void> loadBudgets({
    BudgetStatus? status,
    ExpenseCategory? category,
  }) async {
    try {
      if (state is StatisticsLoaded) {
        final currentState = state as StatisticsLoaded;
        if (isClosed) return;
        emit(currentState.copyWith(isRefreshing: true));

        final budgets = await repository.getBudgets(
          status: status,
          category: category,
        );

        final budgetProgress = await repository.getBudgetProgress();

        if (isClosed) return;
        emit(currentState.copyWith(
          budgets: budgets,
          budgetProgress: budgetProgress,
          isRefreshing: false,
        ));
      } else {
        await loadStatistics(category: category);
      }
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to load budgets: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Create a new budget
  Future<void> createBudget({
    required String name,
    required double amount,
    required String currency,
    required BudgetPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    ExpenseCategory? category,
    double? alertThreshold,
    String? description,
  }) async {
    try {
      if (isClosed) return;
      emit(BudgetCreating(name: name, amount: amount, period: period));

      final budget = await repository.createBudget(
        name: name,
        amount: amount,
        currency: currency,
        period: period,
        startDate: startDate,
        endDate: endDate,
        category: category,
        alertThreshold: alertThreshold,
        description: description,
      );

      if (isClosed) return;
      emit(BudgetCreated(budget: budget));

      // Reload statistics
      await loadStatistics();
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to create budget: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Update an existing budget
  Future<void> updateBudget({
    required String budgetId,
    String? name,
    double? amount,
    String? currency,
    BudgetPeriod? period,
    DateTime? startDate,
    DateTime? endDate,
    ExpenseCategory? category,
    double? alertThreshold,
    String? description,
  }) async {
    try {
      if (isClosed) return;
      emit(BudgetUpdating(budgetId: budgetId));

      final budget = await repository.updateBudget(
        budgetId: budgetId,
        name: name,
        amount: amount,
        currency: currency,
        period: period,
        startDate: startDate,
        endDate: endDate,
        category: category,
        alertThreshold: alertThreshold,
        description: description,
      );

      if (isClosed) return;
      emit(BudgetUpdated(budget: budget));

      // Reload statistics
      await loadStatistics();
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to update budget: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Delete a budget
  Future<void> deleteBudget(String budgetId) async {
    try {
      if (isClosed) return;
      emit(BudgetDeleting(budgetId: budgetId));

      await repository.deleteBudget(budgetId);

      if (isClosed) return;
      emit(BudgetDeleted(budgetId: budgetId));

      // Reload statistics
      await loadStatistics();
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to delete budget: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Load analytics data
  Future<void> loadAnalytics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      if (state is StatisticsLoaded) {
        final currentState = state as StatisticsLoaded;
        if (isClosed) return;
        emit(currentState.copyWith(isRefreshing: true));

        final start = startDate ?? currentState.startDate;
        final end = endDate ?? currentState.endDate;

        final results = await Future.wait([
          repository.getSpendingAnalytics(startDate: start, endDate: end),
          repository.getCategoryBreakdown(startDate: start, endDate: end),
          repository.getBudgetProgress(),
        ]);

        if (isClosed) return;
        emit(currentState.copyWith(
          analytics: results[0] as SpendingAnalytics,
          categoryBreakdown: results[1] as List<CategorySpending>,
          budgetProgress: results[2] as List<BudgetProgressItem>,
          startDate: start,
          endDate: end,
          isRefreshing: false,
        ));
      } else {
        await loadStatistics(startDate: startDate, endDate: endDate);
      }
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to load analytics: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Refresh all data
  Future<void> refresh() async {
    if (state is StatisticsLoaded) {
      final currentState = state as StatisticsLoaded;
      await loadStatistics(
        startDate: currentState.startDate,
        endDate: currentState.endDate,
        category: currentState.selectedCategory,
      );
    } else {
      await loadStatistics();
    }
  }

  /// Change date range filter
  Future<void> changeDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (state is StatisticsLoaded) {
      final currentState = state as StatisticsLoaded;
      await loadStatistics(
        startDate: startDate,
        endDate: endDate,
        category: currentState.selectedCategory,
      );
    } else {
      await loadStatistics(startDate: startDate, endDate: endDate);
    }
  }

  /// Change category filter
  Future<void> changeCategoryFilter(ExpenseCategory? category) async {
    if (state is StatisticsLoaded) {
      final currentState = state as StatisticsLoaded;
      await loadStatistics(
        startDate: currentState.startDate,
        endDate: currentState.endDate,
        category: category,
      );
    } else {
      await loadStatistics(category: category);
    }
  }

  // ====================
  // AI-POWERED FEATURES
  // ====================

  /// Get AI-powered spending insights
  Future<void> getAISpendingInsights({
    DateTime? startDate,
    DateTime? endDate,
    String focusArea = 'savings',
  }) async {
    if (state is! StatisticsLoaded) {
      await loadStatistics(startDate: startDate, endDate: endDate);
    }

    if (state is StatisticsLoaded) {
      try {
        final currentState = state as StatisticsLoaded;
        if (isClosed) return;
        emit(currentState.copyWith(isLoadingAIInsights: true, clearAIError: true));

        final start = startDate ?? currentState.startDate;
        final end = endDate ?? currentState.endDate;

        final response = await repository.getAISpendingInsights(
          startDate: start,
          endDate: end,
          focusArea: focusArea,
        );

        if (isClosed) return;
        emit(currentState.copyWith(
          aiSpendingInsights: response,
          isLoadingAIInsights: false,
        ));
      } catch (e) {
        if (state is StatisticsLoaded) {
          if (isClosed) return;
          emit((state as StatisticsLoaded).copyWith(
            isLoadingAIInsights: false,
            aiError: 'Failed to get AI insights: ${e.toString()}',
          ));
        }
      }
    }
  }

  /// Get AI-powered budgeting recommendations
  Future<void> getAIBudgetingRecommendations({
    required double monthlyIncome,
    required List<String> financialGoals,
    String riskTolerance = 'moderate',
  }) async {
    if (state is! StatisticsLoaded) {
      await loadStatistics();
    }

    if (state is StatisticsLoaded) {
      try {
        final currentState = state as StatisticsLoaded;
        if (isClosed) return;
        emit(currentState.copyWith(isLoadingAIRecommendations: true, clearAIError: true));

        final response = await repository.getAIBudgetingRecommendations(
          monthlyIncome: monthlyIncome,
          financialGoals: financialGoals,
          riskTolerance: riskTolerance,
        );

        if (isClosed) return;
        emit(currentState.copyWith(
          aiBudgetingRecommendations: response,
          isLoadingAIRecommendations: false,
        ));
      } catch (e) {
        if (state is StatisticsLoaded) {
          if (isClosed) return;
          emit((state as StatisticsLoaded).copyWith(
            isLoadingAIRecommendations: false,
            aiError: 'Failed to get AI recommendations: ${e.toString()}',
          ));
        }
      }
    }
  }

  /// Auto-categorize an expense using AI
  Future<void> autoCategorizeExpense({
    required String description,
    String? merchant,
    double? amount,
    String? notes,
  }) async {
    if (state is! StatisticsLoaded) {
      await loadStatistics();
    }

    if (state is StatisticsLoaded) {
      try {
        final currentState = state as StatisticsLoaded;
        if (isClosed) return;
        emit(currentState.copyWith(isLoadingAICategorization: true, clearAIError: true));

        final response = await repository.autoCategorizeExpense(
          description: description,
          merchant: merchant,
          amount: amount,
          notes: notes,
        );

        if (isClosed) return;
        emit(currentState.copyWith(
          aiCategorySuggestions: response,
          isLoadingAICategorization: false,
        ));
      } catch (e) {
        if (state is StatisticsLoaded) {
          if (isClosed) return;
          emit((state as StatisticsLoaded).copyWith(
            isLoadingAICategorization: false,
            aiError: 'Failed to categorize expense: ${e.toString()}',
          ));
        }
      }
    }
  }

  /// Get AI-powered financial advice
  Future<void> getAIFinancialAdvice({
    required String query,
    List<String> contextAreas = const ['spending', 'budgeting', 'savings'],
  }) async {
    if (state is! StatisticsLoaded) {
      await loadStatistics();
    }

    if (state is StatisticsLoaded) {
      try {
        final currentState = state as StatisticsLoaded;
        if (isClosed) return;
        emit(currentState.copyWith(isLoadingAIAdvice: true, clearAIError: true));

        final response = await repository.getAIFinancialAdvice(
          query: query,
          contextAreas: contextAreas,
        );

        if (isClosed) return;
        emit(currentState.copyWith(
          aiFinancialAdvice: response,
          isLoadingAIAdvice: false,
        ));
      } catch (e) {
        if (state is StatisticsLoaded) {
          if (isClosed) return;
          emit((state as StatisticsLoaded).copyWith(
            isLoadingAIAdvice: false,
            aiError: 'Failed to get AI advice: ${e.toString()}',
          ));
        }
      }
    }
  }
}
