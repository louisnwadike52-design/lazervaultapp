import 'package:equatable/equatable.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;

/// Base class for all budget states
sealed class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class BudgetInitial extends BudgetState {}

/// Loading state
class BudgetLoading extends BudgetState {
  final String? message;

  const BudgetLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// Budget list loaded
class BudgetsLoaded extends BudgetState {
  final List<pb.BudgetMessage> budgets;
  final double totalBudgetAmount;
  final double totalSpentAmount;

  const BudgetsLoaded({
    required this.budgets,
    required this.totalBudgetAmount,
    required this.totalSpentAmount,
  });

  @override
  List<Object?> get props => [budgets, totalBudgetAmount, totalSpentAmount];
}

/// Budget progress loaded
class BudgetProgressLoaded extends BudgetState {
  final List<pb.BudgetProgressItem> items;
  final double totalBudget;
  final double totalSpent;
  final double overallPercentage;

  const BudgetProgressLoaded({
    required this.items,
    required this.totalBudget,
    required this.totalSpent,
    required this.overallPercentage,
  });

  @override
  List<Object?> get props => [items, totalBudget, totalSpent, overallPercentage];
}

/// Budget alerts loaded
class BudgetAlertsLoaded extends BudgetState {
  final List<pb.BudgetAlertMessage> alerts;
  final int unreadCount;

  const BudgetAlertsLoaded({
    required this.alerts,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [alerts, unreadCount];
}

/// Budget created successfully
class BudgetCreated extends BudgetState {
  final String message;

  const BudgetCreated({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Budget updated successfully
class BudgetUpdated extends BudgetState {
  final String message;

  const BudgetUpdated({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Budget deleted successfully
class BudgetDeleted extends BudgetState {
  final String message;

  const BudgetDeleted({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Alert marked as read
class AlertMarkedRead extends BudgetState {
  final String message;

  const AlertMarkedRead({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Financial goals loaded
class FinancialGoalsLoaded extends BudgetState {
  final List<pb.FinancialGoal> goals;
  final double totalTarget;
  final double totalSaved;

  const FinancialGoalsLoaded({
    required this.goals,
    required this.totalTarget,
    required this.totalSaved,
  });

  @override
  List<Object?> get props => [goals, totalTarget, totalSaved];
}

/// Recurring bills loaded
class RecurringBillsLoaded extends BudgetState {
  final List<pb.RecurringBill> bills;
  final double totalUpcoming;

  const RecurringBillsLoaded({
    required this.bills,
    required this.totalUpcoming,
  });

  @override
  List<Object?> get props => [bills, totalUpcoming];
}

/// Error state
class BudgetError extends BudgetState {
  final String message;

  const BudgetError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// AI Insights loading
class BudgetAIInsightsLoading extends BudgetState {}

/// AI Insights loaded
class BudgetAIInsightsLoaded extends BudgetState {
  final BudgetAIInsightsData insights;

  const BudgetAIInsightsLoaded({required this.insights});

  @override
  List<Object?> get props => [insights];
}

/// AI Insights error
class BudgetAIInsightsError extends BudgetState {
  final String message;

  const BudgetAIInsightsError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// AI Insights data model (separate from the service response for clean architecture)
class BudgetAIInsightsData {
  final String summary;
  final List<BudgetRecommendationData> budgetRecommendations;
  final List<String> savingsOpportunities;
  final Map<String, dynamic> spendingPatterns;
  final double recommendedSavingsRate;
  final String riskLevel;

  BudgetAIInsightsData({
    required this.summary,
    required this.budgetRecommendations,
    required this.savingsOpportunities,
    required this.spendingPatterns,
    required this.recommendedSavingsRate,
    required this.riskLevel,
  });
}

class BudgetRecommendationData {
  final String category;
  final String categoryName;
  final double recommendedAmount;
  final double currentAmount;
  final double difference;
  final String reasoning;

  BudgetRecommendationData({
    required this.category,
    required this.categoryName,
    required this.recommendedAmount,
    required this.currentAmount,
    required this.difference,
    required this.reasoning,
  });
}
