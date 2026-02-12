import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:lazervault/src/features/statistics/data/budget_repository.dart';
import 'package:lazervault/src/features/statistics/data/budget_ai_service.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';

/// Cubit for managing budget state
class BudgetCubit extends Cubit<BudgetState> {
  final BudgetRepository _budgetRepository;
  final BudgetAIService _budgetAIService;

  BudgetCubit({
    required BudgetRepository budgetRepository,
    required BudgetAIService budgetAIService,
  })  : _budgetRepository = budgetRepository,
        _budgetAIService = budgetAIService,
        super(BudgetInitial());

  /// Load budgets with optional filters
  Future<void> loadBudgets({
    pb.BudgetStatus? status,
    pb.ExpenseCategory? category,
    int page = 1,
    int perPage = 20,
  }) async {
    emit(const BudgetLoading(message: 'Loading budgets...'));
    try {
      final response = await _budgetRepository.getBudgets(
        page: page,
        perPage: perPage,
        status: status,
        category: category,
      );

      emit(BudgetsLoaded(
        budgets: response.budgets,
        totalBudgetAmount: response.totalBudgetAmount,
        totalSpentAmount: response.totalSpentAmount,
      ));
    } catch (e) {
      emit(BudgetError(message: 'Failed to load budgets: ${e.toString()}'));
    }
  }

  /// Load budget progress for analytics
  Future<void> loadBudgetProgress({pb.BudgetPeriod? period}) async {
    emit(const BudgetLoading(message: 'Loading budget progress...'));
    try {
      final response = await _budgetRepository.getBudgetProgress(
        period: period ?? pb.BudgetPeriod.BUDGET_PERIOD_MONTHLY,
      );

      emit(BudgetProgressLoaded(
        items: response.budgets,
        totalBudget: response.totalBudget,
        totalSpent: response.totalSpent,
        overallPercentage: response.overallPercentage,
      ));
    } catch (e) {
      emit(BudgetError(message: 'Failed to load budget progress: ${e.toString()}'));
    }
  }

  /// Create a new budget
  Future<void> createBudget({
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
    emit(const BudgetLoading(message: 'Creating budget...'));
    try {
      final response = await _budgetRepository.createBudget(
        name: name,
        amount: amount,
        currency: currency,
        category: category,
        period: period,
        startDate: startDate,
        endDate: endDate,
        enableAlerts: enableAlerts,
        alertThreshold: alertThreshold,
      );

      if (response.success) {
        emit(BudgetCreated(message: response.message));
        // Reload budgets after creation
        await loadBudgets();
      } else {
        emit(BudgetError(message: response.message));
      }
    } catch (e) {
      emit(BudgetError(message: 'Failed to create budget: ${e.toString()}'));
    }
  }

  /// Update an existing budget
  Future<void> updateBudget({
    required String budgetId,
    String? name,
    double? amount,
    pb.BudgetPeriod? period,
    DateTime? startDate,
    DateTime? endDate,
    bool? enableAlerts,
    double? alertThreshold,
  }) async {
    emit(const BudgetLoading(message: 'Updating budget...'));
    try {
      final response = await _budgetRepository.updateBudget(
        budgetId: budgetId,
        name: name,
        amount: amount,
        period: period,
        startDate: startDate,
        endDate: endDate,
        enableAlerts: enableAlerts,
        alertThreshold: alertThreshold,
      );

      if (response.success) {
        emit(BudgetUpdated(message: response.message));
        // Reload budgets after update
        await loadBudgets();
      } else {
        emit(BudgetError(message: response.message));
      }
    } catch (e) {
      emit(BudgetError(message: 'Failed to update budget: ${e.toString()}'));
    }
  }

  /// Delete a budget
  Future<void> deleteBudget(String budgetId) async {
    emit(const BudgetLoading(message: 'Deleting budget...'));
    try {
      final response = await _budgetRepository.deleteBudget(budgetId);

      if (response.success) {
        emit(BudgetDeleted(message: response.message));
        // Reload budgets after deletion
        await loadBudgets();
      } else {
        emit(BudgetError(message: response.message));
      }
    } catch (e) {
      emit(BudgetError(message: 'Failed to delete budget: ${e.toString()}'));
    }
  }

  /// Load budget alerts
  Future<void> loadBudgetAlerts({bool unreadOnly = false}) async {
    emit(const BudgetLoading(message: 'Loading alerts...'));
    try {
      final response = await _budgetRepository.getBudgetAlerts(
        unreadOnly: unreadOnly,
      );

      emit(BudgetAlertsLoaded(
        alerts: response.alerts,
        unreadCount: response.unreadCount.toInt(),
      ));
    } catch (e) {
      emit(BudgetError(message: 'Failed to load alerts: ${e.toString()}'));
    }
  }

  /// Mark an alert as read
  Future<void> markAlertAsRead(String alertId) async {
    try {
      await _budgetRepository.markAlertAsRead(alertId);
      emit(const AlertMarkedRead(message: 'Alert marked as read'));
      // Reload alerts after marking as read
      await loadBudgetAlerts();
    } catch (e) {
      emit(BudgetError(message: 'Failed to mark alert as read: ${e.toString()}'));
    }
  }

  /// Load AI-powered budget insights
  Future<void> loadAIInsights({
    required double monthlyIncome,
    required List<Map<String, dynamic>> spendingData,
    required List<Map<String, dynamic>> activeBudgets,
    required List<String> goals,
    required String riskTolerance,
    String currency = 'NGN',
    int monthsOfData = 3,
  }) async {
    emit(BudgetAIInsightsLoading());
    try {
      final aiResponse = await _budgetAIService.getAIInsights(
        monthlyIncome: monthlyIncome,
        spendingData: spendingData,
        activeBudgets: activeBudgets,
        goals: goals,
        riskTolerance: riskTolerance,
        currency: currency,
        monthsOfData: monthsOfData,
      );

      final insights = BudgetAIInsightsData(
        summary: aiResponse.summary,
        budgetRecommendations: aiResponse.budgetRecommendations
            .map((r) => BudgetRecommendationData(
                  category: r.category,
                  categoryName: r.categoryName,
                  recommendedAmount: r.recommendedAmount,
                  currentAmount: r.currentAmount,
                  difference: r.difference,
                  reasoning: r.reasoning,
                ))
            .toList(),
        savingsOpportunities: aiResponse.savingsOpportunities,
        spendingPatterns: aiResponse.spendingPatterns,
        recommendedSavingsRate: aiResponse.recommendedSavingsRate,
        monthlyProjection: aiResponse.monthlyProjection,
        rationale: aiResponse.rationale,
      );

      emit(BudgetAIInsightsLoaded(insights: insights));
    } catch (e) {
      emit(BudgetAIInsightsError(message: 'Failed to load AI insights: ${e.toString()}'));
    }
  }

  /// Refresh the current state (reload budgets or alerts based on current state)
  Future<void> refresh() async {
    final currentState = state;
    if (currentState is BudgetsLoaded) {
      await loadBudgets();
    } else if (currentState is BudgetAlertsLoaded) {
      await loadBudgetAlerts();
    } else if (currentState is BudgetProgressLoaded) {
      await loadBudgetProgress();
    } else {
      await loadBudgets();
    }
  }

  /// Reset to initial state
  void reset() {
    emit(BudgetInitial());
  }
}
