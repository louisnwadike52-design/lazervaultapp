import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/create_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/delete_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_rules_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_statistics_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_transactions_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/toggle_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/trigger_autosave_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/update_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

class AutoSaveCubit extends Cubit<AutoSaveState> {
  final CreateAutoSaveRuleUseCase createAutoSaveRuleUseCase;
  final GetAutoSaveRulesUseCase getAutoSaveRulesUseCase;
  final UpdateAutoSaveRuleUseCase updateAutoSaveRuleUseCase;
  final ToggleAutoSaveRuleUseCase toggleAutoSaveRuleUseCase;
  final DeleteAutoSaveRuleUseCase deleteAutoSaveRuleUseCase;
  final GetAutoSaveTransactionsUseCase getAutoSaveTransactionsUseCase;
  final GetAutoSaveStatisticsUseCase getAutoSaveStatisticsUseCase;
  final TriggerAutoSaveUseCase triggerAutoSaveUseCase;

  // Cache management
  List<AutoSaveRuleEntity> _cachedRules = [];
  Map<String, String> _accountNamesCache = {};
  DateTime? _lastFetch;
  static const _cacheDuration = Duration(minutes: 5);

  // Current filters/search/sort
  AutoSaveStatus? _currentFilter;
  String? _currentSearch;
  RuleSortOption _currentSort = RuleSortOption.dateCreatedDesc;

  AutoSaveCubit({
    required this.createAutoSaveRuleUseCase,
    required this.getAutoSaveRulesUseCase,
    required this.updateAutoSaveRuleUseCase,
    required this.toggleAutoSaveRuleUseCase,
    required this.deleteAutoSaveRuleUseCase,
    required this.getAutoSaveTransactionsUseCase,
    required this.getAutoSaveStatisticsUseCase,
    required this.triggerAutoSaveUseCase,
  }) : super(AutoSaveInitial());

  Future<void> createRule({
    required String name,
    required String description,
    required TriggerType triggerType,
    required AmountType amountType,
    required double amountValue,
    required String sourceAccountId,
    required String destinationAccountId,
    ScheduleFrequency? frequency,
    String? scheduleTime,
    int? scheduleDay,
    int? roundUpTo,
    double? targetAmount,
    double? minimumBalance,
    double? maximumPerSave,
  }) async {
    if (isClosed) return;

    // Step 1: Configure
    emit(const AutoSaveRuleCreating(
      step: 'Configuring rule...',
      currentStepIndex: 0,
    ));
    await Future.delayed(const Duration(milliseconds: 400));

    // Step 2: Validate
    if (isClosed) return;
    emit(const AutoSaveRuleCreating(
      step: 'Validating settings...',
      currentStepIndex: 1,
    ));
    await Future.delayed(const Duration(milliseconds: 300));

    // Step 3: Create
    if (isClosed) return;
    emit(const AutoSaveRuleCreating(
      step: 'Creating rule...',
      currentStepIndex: 2,
    ));

    final result = await createAutoSaveRuleUseCase(
      name: name,
      description: description,
      triggerType: triggerType,
      amountType: amountType,
      amountValue: amountValue,
      sourceAccountId: sourceAccountId,
      destinationAccountId: destinationAccountId,
      frequency: frequency,
      scheduleTime: scheduleTime,
      scheduleDay: scheduleDay,
      roundUpTo: roundUpTo,
      targetAmount: targetAmount,
      minimumBalance: minimumBalance,
      maximumPerSave: maximumPerSave,
    );

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (rule) {
        // Step 4: Confirm
        if (isClosed) return;
        emit(const AutoSaveRuleCreating(
          step: 'Rule created!',
          currentStepIndex: 3,
        ));
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!isClosed) emit(AutoSaveRuleCreated(rule));
        });
      },
    );
  }

  Future<void> getRules({
    String? accountId,
    AutoSaveStatus? status,
  }) async {
    if (isClosed) return;
    emit(AutoSaveLoading());

    final result = await getAutoSaveRulesUseCase(
      accountId: accountId,
      status: status,
    );

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (rules) => emit(AutoSaveRulesLoaded(rules)),
    );
  }

  Future<void> updateRule({
    required String ruleId,
    String? name,
    String? description,
    AmountType? amountType,
    double? amountValue,
    ScheduleFrequency? frequency,
    String? scheduleTime,
    int? scheduleDay,
    int? roundUpTo,
    double? targetAmount,
    double? minimumBalance,
    double? maximumPerSave,
  }) async {
    if (isClosed) return;
    emit(AutoSaveLoading());

    final result = await updateAutoSaveRuleUseCase(
      ruleId: ruleId,
      name: name,
      description: description,
      amountType: amountType,
      amountValue: amountValue,
      frequency: frequency,
      scheduleTime: scheduleTime,
      scheduleDay: scheduleDay,
      roundUpTo: roundUpTo,
      targetAmount: targetAmount,
      minimumBalance: minimumBalance,
      maximumPerSave: maximumPerSave,
    );

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (rule) => emit(AutoSaveRuleUpdated(rule)),
    );
  }

  Future<void> toggleRule({
    required String ruleId,
    required String action,
  }) async {
    if (isClosed) return;
    emit(AutoSaveLoading());

    final result = await toggleAutoSaveRuleUseCase(
      ruleId: ruleId,
      action: action,
    );

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (rule) => emit(AutoSaveRuleUpdated(rule)),
    );
  }

  Future<void> deleteRule({
    required String ruleId,
  }) async {
    if (isClosed) return;
    emit(AutoSaveLoading());

    final result = await deleteAutoSaveRuleUseCase(ruleId: ruleId);

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (_) => emit(AutoSaveRuleDeleted(ruleId)),
    );
  }

  Future<void> getTransactions({
    String? ruleId,
    String? accountId,
    int? limit,
    int? offset,
  }) async {
    if (isClosed) return;
    emit(AutoSaveLoading());

    final result = await getAutoSaveTransactionsUseCase(
      ruleId: ruleId,
      accountId: accountId,
      limit: limit,
      offset: offset,
    );

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (transactions) => emit(AutoSaveTransactionsLoaded(transactions)),
    );
  }

  Future<void> getStatistics() async {
    if (isClosed) return;
    emit(AutoSaveLoading());

    final result = await getAutoSaveStatisticsUseCase();

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (statistics) => emit(AutoSaveStatisticsLoaded(statistics)),
    );
  }

  /// Load dashboard data (statistics + rules) in a single call to avoid race conditions.
  Future<void> loadDashboard() async {
    if (isClosed) return;
    emit(AutoSaveLoading());

    final statsResult = await getAutoSaveStatisticsUseCase();
    final rulesResult = await getAutoSaveRulesUseCase();

    if (isClosed) return;

    statsResult.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (statistics) {
        rulesResult.fold(
          (failure) => emit(AutoSaveError(failure.message)),
          (rules) {
            _cachedRules = rules;
            _lastFetch = DateTime.now();
            emit(AutoSaveDashboardLoaded(
              statistics: statistics,
              rules: rules,
            ));
          },
        );
      },
    );
  }

  Future<void> triggerSave({
    required String ruleId,
    required String transactionPinToken,
    double? customAmount,
  }) async {
    if (isClosed) return;

    // Step 1: Validate
    emit(const AutoSaveTriggerProcessing(
      step: 'Validating rule...',
      currentStepIndex: 0,
    ));
    await Future.delayed(const Duration(milliseconds: 400));

    // Step 2: Execute
    if (isClosed) return;
    emit(const AutoSaveTriggerProcessing(
      step: 'Executing transfer...',
      currentStepIndex: 1,
    ));

    final result = await triggerAutoSaveUseCase(
      ruleId: ruleId,
      customAmount: customAmount,
      transactionPinToken: transactionPinToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AutoSaveError(failure.message));
      },
      (transaction) {
        // Step 3: Update
        if (isClosed) return;
        emit(const AutoSaveTriggerProcessing(
          step: 'Updating records...',
          currentStepIndex: 2,
        ));
        Future.delayed(const Duration(milliseconds: 400), () {
          if (isClosed) return;
          // Step 4: Receipt
          emit(const AutoSaveTriggerProcessing(
            step: 'Save complete!',
            currentStepIndex: 3,
          ));
          Future.delayed(const Duration(milliseconds: 300), () {
            if (!isClosed) emit(AutoSaveTransactionTriggered(transaction));
          });
        });
      },
    );
  }

  // Enhanced getRules with caching
  Future<void> getRulesWithCache({
    bool forceRefresh = false,
    AutoSaveStatus? filter,
    String? searchQuery,
    RuleSortOption? sort,
  }) async {
    // Check cache validity
    if (!forceRefresh &&
        _lastFetch != null &&
        DateTime.now().difference(_lastFetch!) < _cacheDuration &&
        _cachedRules.isNotEmpty) {
      _emitFilteredAndSorted(filter, searchQuery, sort);
      return;
    }

    if (isClosed) return;
    emit(AutoSaveRulesLoadingState(cachedRules: _cachedRules));

    final result = await getAutoSaveRulesUseCase(
      accountId: null,
      status: filter,
    );

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (rules) {
        _cachedRules = rules;
        _lastFetch = DateTime.now();
        _currentFilter = filter;
        _currentSearch = searchQuery;
        _currentSort = sort ?? _currentSort;

        _emitFilteredAndSorted(filter, searchQuery, sort);
      },
    );
  }

  void searchRules(String query) {
    _currentSearch = query;
    _emitFilteredAndSorted(_currentFilter, query, _currentSort);
  }

  void filterRules(AutoSaveStatus? status) {
    _currentFilter = status;
    _emitFilteredAndSorted(status, _currentSearch, _currentSort);
  }

  void sortRules(RuleSortOption option) {
    _currentSort = option;
    _emitFilteredAndSorted(_currentFilter, _currentSearch, option);
  }

  void _emitFilteredAndSorted(
    AutoSaveStatus? filter,
    String? search,
    RuleSortOption? sort,
  ) {
    var filtered = List<AutoSaveRuleEntity>.from(_cachedRules);

    // Apply filter
    if (filter != null) {
      filtered = filtered.where((r) => r.status == filter).toList();
    }

    // Apply search
    if (search != null && search.isNotEmpty) {
      final lower = search.toLowerCase();
      filtered = filtered.where((r) {
        return r.name.toLowerCase().contains(lower) ||
            r.description.toLowerCase().contains(lower);
      }).toList();
    }

    // Apply sort
    filtered = _sortRules(filtered, sort ?? _currentSort);

    if (isClosed) return;
    emit(AutoSaveRulesLoadedState(
      rules: filtered,
      accountNames: _accountNamesCache,
      appliedFilter: filter,
      appliedSearch: search,
      appliedSort: sort,
      lastRefreshed: _lastFetch ?? DateTime.now(),
    ));
  }

  List<AutoSaveRuleEntity> _sortRules(
    List<AutoSaveRuleEntity> rules,
    RuleSortOption option,
  ) {
    final sorted = List<AutoSaveRuleEntity>.from(rules);
    switch (option) {
      case RuleSortOption.nameAsc:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case RuleSortOption.nameDesc:
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
      case RuleSortOption.dateCreatedDesc:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case RuleSortOption.dateCreatedAsc:
        sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case RuleSortOption.totalSavedDesc:
        sorted.sort((a, b) => b.totalSaved.compareTo(a.totalSaved));
        break;
      case RuleSortOption.totalSavedAsc:
        sorted.sort((a, b) => a.totalSaved.compareTo(b.totalSaved));
        break;
      case RuleSortOption.statusActive:
        sorted.sort((a, b) {
          if (a.isActive && !b.isActive) return -1;
          if (!a.isActive && b.isActive) return 1;
          return 0;
        });
        break;
    }
    return sorted;
  }

  // Optimistic toggle
  Future<void> toggleRuleOptimistic({
    required String ruleId,
    required String action,
  }) async {
    // Find rule in cache
    final index = _cachedRules.indexWhere((r) => r.id == ruleId);
    if (index == -1) {
      // Rule not in cache, fallback to regular toggle
      await toggleRule(ruleId: ruleId, action: action);
      return;
    }

    final oldRule = _cachedRules[index];

    // Emit toggling state
    if (isClosed) return;
    emit(AutoSaveRuleTogglingState(ruleId, action == 'resume'));

    // Optimistically update cache
    final optimisticRule = AutoSaveRuleEntity(
      id: oldRule.id,
      userId: oldRule.userId,
      name: oldRule.name,
      description: oldRule.description,
      triggerType: oldRule.triggerType,
      amountType: oldRule.amountType,
      amountValue: oldRule.amountValue,
      sourceAccountId: oldRule.sourceAccountId,
      destinationAccountId: oldRule.destinationAccountId,
      status: action == 'resume'
          ? AutoSaveStatus.active
          : AutoSaveStatus.paused,
      frequency: oldRule.frequency,
      scheduleTime: oldRule.scheduleTime,
      scheduleDay: oldRule.scheduleDay,
      roundUpTo: oldRule.roundUpTo,
      targetAmount: oldRule.targetAmount,
      minimumBalance: oldRule.minimumBalance,
      maximumPerSave: oldRule.maximumPerSave,
      createdAt: oldRule.createdAt,
      updatedAt: DateTime.now(),
      lastTriggeredAt: oldRule.lastTriggeredAt,
      triggerCount: oldRule.triggerCount,
      totalSaved: oldRule.totalSaved,
    );

    _cachedRules[index] = optimisticRule;
    _emitFilteredAndSorted(_currentFilter, _currentSearch, _currentSort);

    // Make actual API call
    final result = await toggleAutoSaveRuleUseCase(
      ruleId: ruleId,
      action: action,
    );

    result.fold(
      (failure) {
        // Revert optimistic update
        _cachedRules[index] = oldRule;
        if (isClosed) return;
        emit(AutoSaveError(failure.message));
        _emitFilteredAndSorted(_currentFilter, _currentSearch, _currentSort);
      },
      (rule) {
        // Update cache with actual result
        _cachedRules[index] = rule;
        if (isClosed) return;
        emit(AutoSaveRuleToggleSuccess(rule));
        _emitFilteredAndSorted(_currentFilter, _currentSearch, _currentSort);
      },
    );
  }

  // Bulk operations
  Future<void> bulkPause(List<String> ruleIds) async {
    await _performBulkOperation(
      ruleIds,
      BulkOperationType.pause,
      (id) => toggleAutoSaveRuleUseCase(ruleId: id, action: 'pause'),
    );
  }

  Future<void> bulkResume(List<String> ruleIds) async {
    await _performBulkOperation(
      ruleIds,
      BulkOperationType.resume,
      (id) => toggleAutoSaveRuleUseCase(ruleId: id, action: 'resume'),
    );
  }

  Future<void> bulkDelete(List<String> ruleIds) async {
    await _performBulkOperation(
      ruleIds,
      BulkOperationType.delete,
      (id) => deleteAutoSaveRuleUseCase(ruleId: id),
    );
  }

  Future<void> _performBulkOperation(
    List<String> ruleIds,
    BulkOperationType operation,
    Future<dynamic> Function(String) operationFn,
  ) async {
    if (isClosed) return;
    emit(AutoSaveLoading());

    int successCount = 0;
    for (final id in ruleIds) {
      final result = await operationFn(id);
      if (result != null) {
        // Check if operation succeeded
        result.fold(
          (failure) {
            // Operation failed for this rule
          },
          (_) {
            successCount++;
          },
        );
      }
    }

    // Refresh list
    await getRulesWithCache(forceRefresh: true);

    if (successCount > 0) {
      if (isClosed) return;
      emit(AutoSaveBulkOperationSuccess(operation, successCount));
      _emitFilteredAndSorted(_currentFilter, _currentSearch, _currentSort);
    } else {
      if (isClosed) return;
      emit(AutoSaveError('Bulk operation failed for all selected rules'));
    }
  }

  // Set account names cache (called from UI)
  void setAccountNames(Map<String, String> accountNames) {
    _accountNamesCache = accountNames;
    if (state is AutoSaveRulesLoadedState) {
      _emitFilteredAndSorted(_currentFilter, _currentSearch, _currentSort);
    }
  }

  // Clear cache
  void clearCache() {
    _cachedRules = [];
    _accountNamesCache = {};
    _lastFetch = null;
    _currentFilter = null;
    _currentSearch = null;
    _currentSort = RuleSortOption.dateCreatedDesc;
  }
}
