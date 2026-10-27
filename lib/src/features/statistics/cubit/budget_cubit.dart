import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:lazervault/src/features/statistics/data/budget_repository.dart';
import 'package:lazervault/src/features/statistics/data/budget_ai_service.dart';
import 'package:lazervault/core/cache/session_page_user.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_page_store.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/widgets/category_selection.dart';
import 'package:lazervault/src/features/widgets/budget_warning_widget.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:grpc/grpc.dart';

/// Cubit for managing budget state
///
/// Note: BudgetRepository routes through investment-gateway (port 50072)
/// which proxies gRPC calls to statistics-service (port 50069)
class BudgetCubit extends Cubit<BudgetState> {
  final BudgetRepository _budgetRepository;
  final BudgetAIService _budgetAIService;

  /// Cache of service categories fetched from backend
  final Map<String, List<ServiceCategory>> _categoryCache = {};

  /// In-flight requests to deduplicate concurrent loads for the same service
  final Map<String, Future<List<ServiceCategory>>> _pendingLoads = {};

  /// Who the budgets in a retained `BudgetsLoaded` belong to.
  ///
  /// THIS CUBIT IS A LAZY SINGLETON, so its state outlives the session that
  /// filled it, and [loadBudgets] now PAINTS that retained state instead of a
  /// loader. Without this the next person to sign in on the device would be
  /// looking at the previous user's budget amounts until the fetch landed —
  /// the user-switch purge resets the cubit, and this is the half that holds
  /// when a switch slips past it.
  String? _loadedUserId;

  BudgetCubit({
    required BudgetRepository budgetRepository,
    required BudgetAIService budgetAIService,
  })  : _budgetRepository = budgetRepository,
        _budgetAIService = budgetAIService,
        super(BudgetInitial());

  /// Load budgets with optional filters.
  ///
  /// Paints what is already known first — the retained Loaded state, else
  /// the remembered unfiltered first page for this user — and fetches behind
  /// it; the loading view is for a cold miss only. A refresh that fails
  /// behind painted rows keeps them (the error view is for a cold miss too).
  Future<void> loadBudgets({
    pb.BudgetStatus? status,
    pb.ExpenseCategory? category,
    int page = 1,
    int perPage = 20,
  }) async {
    final unfilteredFirstPage = page == 1 && status == null && category == null;
    final uid = sessionPageUserId();
    // A retained list belonging to SOMEONE ELSE is never painted — it is
    // dropped, and this load shows the loader as it did before the cubit
    // learned to paint. An UNKNOWN id ('' — the locator not up yet) is not a
    // mismatch: it means "don't know", and acting on it would throw away a
    // good list for the user who is still signed in.
    if (uid.isNotEmpty && _loadedUserId != null && _loadedUserId != uid) {
      _loadedUserId = null;
      if (state is BudgetsLoaded) emit(BudgetInitial());
    }
    var painted = state is BudgetsLoaded;
    if (!painted && unfilteredFirstPage) {
      final cached = await BudgetPageStore.hydrate(uid);
      if (isClosed) return;
      if (cached != null && state is! BudgetsLoaded) {
        painted = true;
        emit(BudgetsLoaded(
          budgets: cached.budgets,
          totalBudgetAmount: cached.totalBudgetAmount,
          totalSpentAmount: cached.totalSpentAmount,
          isRefreshing: true,
        ));
      }
    }
    if (!painted) {
      emit(const BudgetLoading(message: 'Loading budgets...'));
    }
    try {
      final response = await _budgetRepository.getBudgets(
        page: page,
        perPage: perPage,
        status: status,
        category: category,
      );
      if (isClosed) return;

      if (unfilteredFirstPage) {
        BudgetPageStore.put(uid,
            budgets: response.budgets,
            totalBudgetAmount: response.totalBudgetAmount,
            totalSpentAmount: response.totalSpentAmount);
      }
      if (uid.isNotEmpty) _loadedUserId = uid;
      emit(BudgetsLoaded(
        budgets: response.budgets,
        totalBudgetAmount: response.totalBudgetAmount,
        totalSpentAmount: response.totalSpentAmount,
        page: page,
        hasMore: response.hasPagination() && response.pagination.hasNext,
      ));
    } catch (e) {
      if (isClosed) return;
      if (state is BudgetsLoaded) {
        developer.log('Budget refresh failed, keeping shown list',
            name: 'BudgetCubit', error: e);
        emit((state as BudgetsLoaded).copyWith(isRefreshing: false));
        return;
      }
      emit(
          BudgetError(message: friendlyError(e, context: 'load your budgets')));
    }
  }

  /// Append the next page of the unfiltered list on scroll. Guarded so two
  /// scroll events never fire two requests, and a failed append keeps what
  /// is on screen and simply stops paging.
  Future<void> loadMoreBudgets({int perPage = 20}) async {
    final current = state;
    if (current is! BudgetsLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    final nextPage = current.page + 1;
    emit(current.copyWith(isLoadingMore: true));
    try {
      final response = await _budgetRepository.getBudgets(
        page: nextPage,
        perPage: perPage,
      );
      if (isClosed) return;
      final latest = state;
      if (latest is! BudgetsLoaded) return;
      final seen = latest.budgets.map((b) => b.id).toSet();
      final appended = [
        ...latest.budgets,
        ...response.budgets.where((b) => seen.add(b.id)),
      ];
      emit(latest.copyWith(
        budgets: appended,
        totalBudgetAmount: response.totalBudgetAmount,
        totalSpentAmount: response.totalSpentAmount,
        page: nextPage,
        hasMore: response.hasPagination() && response.pagination.hasNext,
        isLoadingMore: false,
      ));
    } catch (e) {
      if (isClosed) return;
      final latest = state;
      if (latest is BudgetsLoaded) {
        developer.log('Budget page append failed',
            name: 'BudgetCubit', error: e);
        emit(latest.copyWith(isLoadingMore: false, hasMore: false));
      }
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
      emit(BudgetError(
          message: friendlyError(e, context: 'load your budget progress')));
    }
  }

  /// Validate a category budget before a transaction.
  /// Returns null on failure (allows transaction to proceed — budget validation
  /// should never block if the service is down).
  Future<BudgetValidationResult?> validateCategoryBudget({
    required int budgetCategory,
    required int amountMinor,
    required String currency,
  }) async {
    try {
      final response = await _budgetRepository.validateCategoryBudget(
        budgetCategory: budgetCategory,
        amountMinor: amountMinor,
        currency: currency,
      );

      return BudgetValidationResult(
        allowed: response.allowed,
        reason: response.reason,
        currentSpent: response.currentSpent,
        budgetLimit: response.budgetLimit,
        percentageUsed: response.percentageUsed,
        remaining: response.remaining,
        matchingBudgets: response.matchingBudgets
            .map((b) => BudgetInfo(
                  budgetId: b.budgetId,
                  budgetName: b.budgetName,
                  amount: b.amount,
                  spent: b.spent,
                  percentage: b.percentage,
                  daysRemaining: b.daysRemaining,
                  currency: b.currency,
                ))
            .toList(),
      );
    } catch (e) {
      developer.log('Budget validation failed', name: 'BudgetCubit', error: e);
      return null;
    }
  }

  /// Create a new budget
  Future<bool> createBudget({
    required String name,
    required double amount,
    required String currency,
    required pb.ExpenseCategory category,
    required pb.BudgetPeriod period,
    DateTime? startDate,
    DateTime? endDate,
    bool enableAlerts = true,
    double alertThreshold = 80.0,
    pb.BudgetEnforcementMode enforcementMode =
        pb.BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_FLEXIBLE,
  }) async {
    // Returns whether the budget was actually created.
    //
    // This used to return void and swallow every failure into a BudgetError
    // emit, so a caller applying SEVERAL budgets in a loop could not tell which
    // ones landed: its try/catch never fired (nothing throws) and it counted
    // every attempt as a success. The AI allocation review reported "N budgets
    // applied" for budgets that did not exist.
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
        enforcementMode: enforcementMode,
      );

      if (response.success) {
        emit(BudgetCreated(message: response.message));
        // Reload budgets after creation
        await loadBudgets();
        return true;
      }
      emit(BudgetError(message: response.message));
      return false;
    } catch (e) {
      emit(
          BudgetError(message: friendlyError(e, context: 'create the budget')));
      return false;
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
    pb.BudgetEnforcementMode? enforcementMode,
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
        enforcementMode: enforcementMode,
      );

      if (response.success) {
        emit(BudgetUpdated(message: response.message));
        // Reload budgets after update
        await loadBudgets();
      } else {
        emit(BudgetError(message: response.message));
      }
    } catch (e) {
      emit(
          BudgetError(message: friendlyError(e, context: 'update the budget')));
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
      emit(
          BudgetError(message: friendlyError(e, context: 'delete the budget')));
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
      emit(BudgetError(message: friendlyError(e, context: 'load your alerts')));
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
      emit(BudgetError(message: friendlyError(e, context: 'update the alert')));
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
    List<Map<String, dynamic>> financialGoals = const [],
    List<Map<String, dynamic>> upcomingBills = const [],
    List<Map<String, dynamic>> budgetAlerts = const [],
    List<Map<String, dynamic>> failedTransactions = const [],
    Map<String, dynamic> dataSources = const {},
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
        financialGoals: financialGoals,
        upcomingBills: upcomingBills,
        budgetAlerts: budgetAlerts,
        failedTransactions: failedTransactions,
        dataSources: dataSources,
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
        riskLevel: aiResponse.riskLevel,
        categoryInsights: aiResponse.categoryInsights
            .map((c) => CategoryInsightData(
                  categoryName: c.categoryName,
                  analysis: c.analysis,
                  subCategories: c.subCategories
                      .map((s) => SubCategoryInsightData(
                            name: s.name,
                            amount: s.amount,
                            insight: s.insight,
                          ))
                      .toList(),
                  actionItems: c.actionItems,
                ))
            .toList(),
      );

      emit(BudgetAIInsightsLoaded(insights: insights));
    } catch (e) {
      emit(BudgetAIInsightsError(
          message: friendlyError(e, context: 'load your AI insights')));
    }
  }

  /// Load financial goals
  Future<void> loadFinancialGoals({pb.GoalStatus? status}) async {
    emit(const BudgetLoading(message: 'Loading goals...'));
    try {
      final response =
          await _budgetRepository.getFinancialGoals(status: status);
      final goalsList = response.goalsList;

      emit(FinancialGoalsLoaded(
        goals: goalsList.goals.toList(),
        totalTarget: goalsList.totalTarget,
        totalSaved: goalsList.totalSaved,
      ));
    } catch (e) {
      emit(BudgetError(message: friendlyError(e, context: 'load your goals')));
    }
  }

  /// Create a financial goal
  Future<void> createFinancialGoal({
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
    emit(const BudgetLoading(message: 'Creating goal...'));
    try {
      final response = await _budgetRepository.createFinancialGoal(
        name: name,
        goalType: goalType,
        targetAmount: targetAmount,
        currentAmount: currentAmount,
        monthlyContribution: monthlyContribution,
        currency: currency,
        targetDate: targetDate,
        icon: icon,
        color: color,
      );

      if (response.success) {
        emit(BudgetCreated(message: response.message));
        await loadFinancialGoals();
      } else {
        emit(BudgetError(message: response.message));
      }
    } catch (e) {
      emit(BudgetError(message: friendlyError(e, context: 'create the goal')));
    }
  }

  /// Contribute REAL money to a financial goal: debits the wallet after the
  /// device PIN token ([pinToken] bound to [pinTxnId]) is validated server-side.
  Future<void> contributeToGoal({
    required String goalId,
    required double amount,
    required String pinToken,
    required String pinTxnId,
    String? accountId,
  }) async {
    emit(const BudgetLoading(message: 'Adding money...'));
    try {
      final response = await _budgetRepository.updateFinancialGoalProgress(
        goalId: goalId,
        amountToAdd: amount,
        pinToken: pinToken,
        pinTxnId: pinTxnId,
        accountId: accountId,
      );

      if (response.success) {
        emit(BudgetCreated(message: response.message));
        await loadFinancialGoals();
      } else {
        emit(BudgetError(message: response.message));
      }
    } catch (e) {
      emit(BudgetError(
          message: friendlyError(e, context: 'add money to your goal')));
    }
  }

  /// Withdraw money from a financial goal back to the wallet (no PIN — money is
  /// returning to its owner). [amount] is the positive amount to withdraw.
  Future<void> withdrawFromGoal({
    required String goalId,
    required double amount,
    String? accountId,
  }) async {
    emit(const BudgetLoading(message: 'Withdrawing...'));
    try {
      final response = await _budgetRepository.updateFinancialGoalProgress(
        goalId: goalId,
        amountToAdd: -amount,
        accountId: accountId,
      );

      if (response.success) {
        emit(BudgetCreated(message: response.message));
        await loadFinancialGoals();
      } else {
        emit(BudgetError(message: response.message));
      }
    } catch (e) {
      emit(BudgetError(
          message: friendlyError(e, context: 'withdraw from your goal')));
    }
  }

  /// Load recurring bills
  Future<void> loadRecurringBills({int daysAhead = 30}) async {
    emit(const BudgetLoading(message: 'Loading bills...'));
    try {
      final response =
          await _budgetRepository.getUpcomingBills(daysAhead: daysAhead);
      final billsList = response.billsList;

      emit(RecurringBillsLoaded(
        bills: billsList.bills.toList(),
        totalUpcoming: billsList.totalUpcoming,
      ));
    } catch (e) {
      emit(BudgetError(message: friendlyError(e, context: 'load your bills')));
    }
  }

  /// Create a recurring bill
  Future<void> createRecurringBill({
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
    emit(const BudgetLoading(message: 'Creating bill...'));
    try {
      final response = await _budgetRepository.createRecurringBill(
        name: name,
        amount: amount,
        currency: currency,
        category: category,
        recurrencePattern: recurrencePattern,
        nextDueDate: nextDueDate,
        merchant: merchant,
        icon: icon,
        autoPayEnabled: autoPayEnabled,
      );

      if (response.success) {
        emit(BudgetCreated(message: response.message));
        await loadRecurringBills();
      } else {
        emit(BudgetError(message: response.message));
      }
    } catch (e) {
      emit(BudgetError(message: friendlyError(e, context: 'create the bill')));
    }
  }

  /// Load service categories from backend, with in-memory cache and fallback.
  /// Deduplicates concurrent calls for the same serviceName.
  Future<List<ServiceCategory>> loadServiceCategories(
      String serviceName) async {
    if (_categoryCache.containsKey(serviceName)) {
      return _categoryCache[serviceName]!;
    }
    // Deduplicate concurrent requests for the same service
    if (_pendingLoads.containsKey(serviceName)) {
      return _pendingLoads[serviceName]!;
    }
    final future = _fetchServiceCategories(serviceName);
    _pendingLoads[serviceName] = future;
    try {
      return await future;
    } finally {
      _pendingLoads.remove(serviceName);
    }
  }

  Future<List<ServiceCategory>> _fetchServiceCategories(
      String serviceName) async {
    try {
      final response = await _budgetRepository.getServiceCategories(
        serviceName: serviceName,
      );
      final categories = response.categories
          .map((proto) => ServiceCategory.fromProto(proto))
          .toList();
      _categoryCache[serviceName] = categories;
      return categories;
    } catch (e) {
      developer.log('Failed to load service categories for $serviceName',
          name: 'BudgetCubit', error: e);
      return ServiceCategory.commonTransferCategories;
    }
  }

  /// Load categories from ALL services (for budget creation which spans all services).
  /// Deduplicates by budgetCategory to avoid showing duplicate budget categories.
  Future<List<ServiceCategory>> loadAllServiceCategories() async {
    const allKey = '_all_services';
    if (_categoryCache.containsKey(allKey)) {
      return _categoryCache[allKey]!;
    }
    if (_pendingLoads.containsKey(allKey)) {
      return _pendingLoads[allKey]!;
    }
    final future = _fetchAllServiceCategories();
    _pendingLoads[allKey] = future;
    try {
      return await future;
    } finally {
      _pendingLoads.remove(allKey);
    }
  }

  Future<List<ServiceCategory>> _fetchAllServiceCategories() async {
    const serviceNames = ['transfer', 'bill_payment', 'investment', 'commerce'];

    // Fetch all services in parallel
    final results = await Future.wait(
      serviceNames.map((service) async {
        try {
          return await loadServiceCategories(service);
        } catch (e) {
          developer.log('Failed to load categories for $service',
              name: 'BudgetCubit', error: e);
          return <ServiceCategory>[];
        }
      }),
    );

    final allCategories = <ServiceCategory>[];
    final seenBudgetCategories = <int>{};
    for (final categories in results) {
      for (final cat in categories) {
        if (!seenBudgetCategories.contains(cat.budgetCategory)) {
          seenBudgetCategories.add(cat.budgetCategory);
          allCategories.add(cat);
        }
      }
    }

    if (allCategories.isEmpty) {
      return ServiceCategory.commonTransferCategories;
    }

    _categoryCache['_all_services'] = allCategories;
    return allCategories;
  }

  /// Create a custom category and clear cache
  Future<ServiceCategory?> createCustomCategory({
    required String serviceName,
    required String displayName,
    int budgetCategory = 16,
    String icon = 'category',
    String color = '#95A5A6',
  }) async {
    try {
      final response = await _budgetRepository.createCustomCategory(
        serviceName: serviceName,
        displayName: displayName,
        budgetCategory: budgetCategory,
        icon: icon,
        color: color,
      );

      if (response.success && response.hasCategory()) {
        // Clear cache so next load includes the new category
        _categoryCache.remove(serviceName);
        return ServiceCategory.fromProto(response.category);
      }
      return null;
    } on GrpcError catch (e) {
      // Propagate. statistics-service classifies these precisely (the name is
      // taken, the per-user cap is reached, the session expired) and the caller
      // renders that reason. Collapsing them to null was why a refused create
      // looked like a category that appeared and then vanished.
      developer.log('Create custom category "$displayName" refused: ${e.code}',
          name: 'BudgetCubit', error: e);
      rethrow;
    } catch (e) {
      developer.log('Failed to create custom category "$displayName"',
          name: 'BudgetCubit', error: e);
      rethrow;
    }
  }

  /// Delete a custom category and clear cache
  Future<bool> deleteCustomCategory(
      String categoryId, String serviceName) async {
    try {
      final response = await _budgetRepository.deleteCustomCategory(categoryId);
      if (response.success) {
        _categoryCache.remove(serviceName);
      }
      return response.success;
    } catch (e) {
      developer.log('Failed to delete custom category $categoryId',
          name: 'BudgetCubit', error: e);
      return false;
    }
  }

  /// Clear the category cache (e.g., on logout)
  void clearCategoryCache() {
    _categoryCache.clear();
    _pendingLoads.clear();
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
    } else if (currentState is FinancialGoalsLoaded) {
      await loadFinancialGoals();
    } else if (currentState is RecurringBillsLoaded) {
      await loadRecurringBills();
    } else {
      await loadBudgets();
    }
  }

  /// Reset to initial state
  void reset() {
    _loadedUserId = null;
    emit(BudgetInitial());
  }
}
