import 'package:equatable/equatable.dart';
import '../../../generated/statistics.pb.dart';

/// Base class for all statistics states
abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object?> get props => [];
}

/// Initial state when statistics feature is first loaded
class StatisticsInitial extends StatisticsState {}

/// Loading state while fetching data
class StatisticsLoading extends StatisticsState {
  final String? loadingMessage;

  const StatisticsLoading({this.loadingMessage});

  @override
  List<Object?> get props => [loadingMessage];
}

/// Loaded state with all statistics data
class StatisticsLoaded extends StatisticsState {
  final List<ExpenseMessage> expenses;
  final List<BudgetMessage> budgets;
  final SpendingAnalytics? analytics;
  final List<CategorySpending> categoryBreakdown;
  final List<BudgetProgressItem> budgetProgress;
  final DateTime startDate;
  final DateTime endDate;
  final ExpenseCategory? selectedCategory;
  final bool isRefreshing;

  // Financial Statistics Data
  final List<IncomeSource> incomeSources;
  final double totalMonthlyIncome;
  final IncomeBreakdown? incomeBreakdown;
  final List<InvestmentTypeData> investments;
  final InvestmentPortfolio? investmentPortfolio;
  final List<FinancialGoal> financialGoals;
  final SavingsGoal? savingsGoal;
  final UpcomingBillsList? upcomingBills;

  // AI-powered features
  final GetAISpendingInsightsResponse? aiSpendingInsights;
  final GetAIBudgetingRecommendationsResponse? aiBudgetingRecommendations;
  final AutoCategorizeExpenseResponse? aiCategorySuggestions;
  final GetAIFinancialAdviceResponse? aiFinancialAdvice;
  final bool isLoadingAIInsights;
  final bool isLoadingAIRecommendations;
  final bool isLoadingAICategorization;
  final bool isLoadingAIAdvice;
  final String? aiError;

  const StatisticsLoaded({
    this.expenses = const [],
    this.budgets = const [],
    this.analytics,
    this.categoryBreakdown = const [],
    this.budgetProgress = const [],
    required this.startDate,
    required this.endDate,
    this.selectedCategory,
    this.isRefreshing = false,
    this.incomeSources = const [],
    this.totalMonthlyIncome = 0.0,
    this.incomeBreakdown,
    this.investments = const [],
    this.investmentPortfolio,
    this.financialGoals = const [],
    this.savingsGoal,
    this.upcomingBills,
    this.aiSpendingInsights,
    this.aiBudgetingRecommendations,
    this.aiCategorySuggestions,
    this.aiFinancialAdvice,
    this.isLoadingAIInsights = false,
    this.isLoadingAIRecommendations = false,
    this.isLoadingAICategorization = false,
    this.isLoadingAIAdvice = false,
    this.aiError,
  });

  @override
  List<Object?> get props => [
        expenses,
        budgets,
        analytics,
        categoryBreakdown,
        budgetProgress,
        startDate,
        endDate,
        selectedCategory,
        isRefreshing,
        incomeSources,
        totalMonthlyIncome,
        incomeBreakdown,
        investments,
        investmentPortfolio,
        financialGoals,
        savingsGoal,
        upcomingBills,
        aiSpendingInsights,
        aiBudgetingRecommendations,
        aiCategorySuggestions,
        aiFinancialAdvice,
        isLoadingAIInsights,
        isLoadingAIRecommendations,
        isLoadingAICategorization,
        isLoadingAIAdvice,
        aiError,
      ];

  /// Create a copy with updated fields
  StatisticsLoaded copyWith({
    List<ExpenseMessage>? expenses,
    List<BudgetMessage>? budgets,
    SpendingAnalytics? analytics,
    List<CategorySpending>? categoryBreakdown,
    List<BudgetProgressItem>? budgetProgress,
    DateTime? startDate,
    DateTime? endDate,
    ExpenseCategory? selectedCategory,
    bool? isRefreshing,
    bool clearCategory = false,
    List<IncomeSource>? incomeSources,
    double? totalMonthlyIncome,
    IncomeBreakdown? incomeBreakdown,
    List<InvestmentTypeData>? investments,
    InvestmentPortfolio? investmentPortfolio,
    List<FinancialGoal>? financialGoals,
    SavingsGoal? savingsGoal,
    UpcomingBillsList? upcomingBills,
    GetAISpendingInsightsResponse? aiSpendingInsights,
    GetAIBudgetingRecommendationsResponse? aiBudgetingRecommendations,
    AutoCategorizeExpenseResponse? aiCategorySuggestions,
    GetAIFinancialAdviceResponse? aiFinancialAdvice,
    bool? isLoadingAIInsights,
    bool? isLoadingAIRecommendations,
    bool? isLoadingAICategorization,
    bool? isLoadingAIAdvice,
    String? aiError,
    bool clearAIError = false,
  }) {
    return StatisticsLoaded(
      expenses: expenses ?? this.expenses,
      budgets: budgets ?? this.budgets,
      analytics: analytics ?? this.analytics,
      categoryBreakdown: categoryBreakdown ?? this.categoryBreakdown,
      budgetProgress: budgetProgress ?? this.budgetProgress,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      isRefreshing: isRefreshing ?? this.isRefreshing,
      incomeSources: incomeSources ?? this.incomeSources,
      totalMonthlyIncome: totalMonthlyIncome ?? this.totalMonthlyIncome,
      incomeBreakdown: incomeBreakdown ?? this.incomeBreakdown,
      investments: investments ?? this.investments,
      investmentPortfolio: investmentPortfolio ?? this.investmentPortfolio,
      financialGoals: financialGoals ?? this.financialGoals,
      savingsGoal: savingsGoal ?? this.savingsGoal,
      upcomingBills: upcomingBills ?? this.upcomingBills,
      aiSpendingInsights: aiSpendingInsights ?? this.aiSpendingInsights,
      aiBudgetingRecommendations: aiBudgetingRecommendations ?? this.aiBudgetingRecommendations,
      aiCategorySuggestions: aiCategorySuggestions ?? this.aiCategorySuggestions,
      aiFinancialAdvice: aiFinancialAdvice ?? this.aiFinancialAdvice,
      isLoadingAIInsights: isLoadingAIInsights ?? this.isLoadingAIInsights,
      isLoadingAIRecommendations: isLoadingAIRecommendations ?? this.isLoadingAIRecommendations,
      isLoadingAICategorization: isLoadingAICategorization ?? this.isLoadingAICategorization,
      isLoadingAIAdvice: isLoadingAIAdvice ?? this.isLoadingAIAdvice,
      aiError: clearAIError ? null : (aiError ?? this.aiError),
    );
  }
}

/// State when an expense is being created
class ExpenseCreating extends StatisticsState {
  final double amount;
  final ExpenseCategory category;

  const ExpenseCreating({
    required this.amount,
    required this.category,
  });

  @override
  List<Object> get props => [amount, category];
}

/// State when an expense has been successfully created
class ExpenseCreated extends StatisticsState {
  final ExpenseMessage expense;

  const ExpenseCreated({required this.expense});

  @override
  List<Object> get props => [expense];
}

/// State when a budget is being created
class BudgetCreating extends StatisticsState {
  final String name;
  final double amount;
  final BudgetPeriod period;

  const BudgetCreating({
    required this.name,
    required this.amount,
    required this.period,
  });

  @override
  List<Object> get props => [name, amount, period];
}

/// State when a budget has been successfully created
class BudgetCreated extends StatisticsState {
  final BudgetMessage budget;

  const BudgetCreated({required this.budget});

  @override
  List<Object> get props => [budget];
}

/// State when an expense is being updated
class ExpenseUpdating extends StatisticsState {
  final String expenseId;

  const ExpenseUpdating({required this.expenseId});

  @override
  List<Object> get props => [expenseId];
}

/// State when an expense has been successfully updated
class ExpenseUpdated extends StatisticsState {
  final ExpenseMessage expense;

  const ExpenseUpdated({required this.expense});

  @override
  List<Object> get props => [expense];
}

/// State when a budget is being updated
class BudgetUpdating extends StatisticsState {
  final String budgetId;

  const BudgetUpdating({required this.budgetId});

  @override
  List<Object> get props => [budgetId];
}

/// State when a budget has been successfully updated
class BudgetUpdated extends StatisticsState {
  final BudgetMessage budget;

  const BudgetUpdated({required this.budget});

  @override
  List<Object> get props => [budget];
}

/// State when an expense is being deleted
class ExpenseDeleting extends StatisticsState {
  final String expenseId;

  const ExpenseDeleting({required this.expenseId});

  @override
  List<Object> get props => [expenseId];
}

/// State when an expense has been successfully deleted
class ExpenseDeleted extends StatisticsState {
  final String expenseId;

  const ExpenseDeleted({required this.expenseId});

  @override
  List<Object> get props => [expenseId];
}

/// State when a budget is being deleted
class BudgetDeleting extends StatisticsState {
  final String budgetId;

  const BudgetDeleting({required this.budgetId});

  @override
  List<Object> get props => [budgetId];
}

/// State when a budget has been successfully deleted
class BudgetDeleted extends StatisticsState {
  final String budgetId;

  const BudgetDeleted({required this.budgetId});

  @override
  List<Object> get props => [budgetId];
}

/// Error state with detailed error message
class StatisticsError extends StatisticsState {
  final String message;
  final String? errorCode;
  final StackTrace? stackTrace;

  const StatisticsError({
    required this.message,
    this.errorCode,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, errorCode, stackTrace];
}
