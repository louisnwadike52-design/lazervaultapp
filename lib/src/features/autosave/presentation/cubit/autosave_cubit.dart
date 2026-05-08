import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';
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
  // Repository is injected directly so the cubit can call the
  // paginated rules endpoint (currently the only consumer of the
  // limit/offset/sort/search params). Use-cases stay for legacy
  // single-shot operations.
  final IAutoSaveRepository _autoSaveRepository;

  // Cache management
  List<AutoSaveRuleEntity> _cachedRules = [];
  Map<String, String> _accountNamesCache = {};
  DateTime? _lastFetch;
  static const _cacheDuration = Duration(minutes: 5);

  // Backend-aggregated stats. Fetched alongside the rules list so
  // the All-Rules screen's analytics card can render lifetime
  // totals + the best-performing rule without re-summing the
  // currently-paginated `rules` array.
  AutoSaveStatisticsEntity? _cachedStatistics;

  // Server-side pagination state. _currentOffset is incremented by
  // _pageSize on each loadMoreRules() call; reset to zero whenever a
  // sort/filter/search change forces a fresh fetch. _hasMore comes
  // straight from the gateway's has_more flag.
  static const int _pageSize = 25;
  int _currentOffset = 0;
  bool _hasMore = false;
  int _totalCount = 0;

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
    required IAutoSaveRepository autoSaveRepository,
  })  : _autoSaveRepository = autoSaveRepository,
        super(AutoSaveInitial());

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
            // Normalise to a true List<AutoSaveRuleEntity>. The
            // repository hands back List<AutoSaveRuleModel> (the data
            // class extends the entity), and Dart's reified generics
            // remember THAT runtime type — so any downstream `.reduce`
            // / `.fold` lambda typed against AutoSaveRuleEntity blows
            // up with "(Entity, Entity) => Entity is not a subtype of
            // (Model, Model) => Model of 'combine'". Wrapping with
            // `List<E>.from` materialises a fresh list whose runtime
            // element type is exactly E.
            final normalised =
                List<AutoSaveRuleEntity>.from(rules);
            _cachedRules = normalised;
            _lastFetch = DateTime.now();
            emit(AutoSaveDashboardLoaded(
              statistics: statistics,
              rules: normalised,
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

  // Enhanced getRules with caching. Fetches the first page of rules
  // and the backend-aggregated stats in parallel; subsequent pages
  // are appended via [loadMoreRules].
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
        _cachedRules.isNotEmpty &&
        _currentFilter == filter &&
        _currentSearch == searchQuery &&
        (sort == null || _currentSort == sort)) {
      _emitFilteredAndSorted(filter, searchQuery, sort);
      return;
    }

    if (isClosed) return;
    emit(AutoSaveRulesLoadingState(cachedRules: _cachedRules));

    _currentFilter = filter;
    _currentSearch = searchQuery;
    _currentSort = sort ?? _currentSort;
    _currentOffset = 0;

    // Fetch first page + stats in parallel. Stats failure is
    // non-fatal — the analytics card hides itself when stats are
    // absent rather than blocking the rules list.
    final results = await Future.wait([
      _autoSaveRepository.getAutoSaveRulesPaged(
        status: _currentFilter,
        search: _currentSearch,
        sort: _currentSort,
        limit: _pageSize,
        offset: 0,
      ),
      getAutoSaveStatisticsUseCase(),
    ]);

    final rulesResult = results[0];
    final statsResult = results[1];

    rulesResult.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (data) {
        final page = data as AutoSavePagedResult;
        // List<E>.from forces the runtime element type to E so the
        // `.reduce(...)` / `.fold(...)` callbacks downstream don't
        // hit Dart's reified-generic variance check (the repository
        // returns List<AutoSaveRuleModel>, which is *not* covariant
        // for callback inputs).
        _cachedRules = List<AutoSaveRuleEntity>.from(page.rules);
        _hasMore = page.hasMore;
        _totalCount = page.total;
        _lastFetch = DateTime.now();

        statsResult.fold(
          (_) => _cachedStatistics = null,
          (stats) =>
              _cachedStatistics = stats as AutoSaveStatisticsEntity,
        );

        _emitFilteredAndSorted(filter, searchQuery, sort);
      },
    );
  }

  /// Append the next page of rules to the cache. The list screen
  /// calls this from a ScrollController bottom-edge listener.
  /// Drops to a no-op when the backend has signalled has_more=false.
  Future<void> loadMoreRules() async {
    if (isClosed || !_hasMore) return;
    final current = state;
    // Already loading the next page — don't double-fire.
    if (current is AutoSaveRulesLoadedState && current.isLoadingMore) {
      return;
    }
    if (current is AutoSaveRulesLoadedState) {
      emit(current.copyWith(isLoadingMore: true));
    }

    final nextOffset = _currentOffset + _pageSize;
    final result = await _autoSaveRepository.getAutoSaveRulesPaged(
      status: _currentFilter,
      search: _currentSearch,
      sort: _currentSort,
      limit: _pageSize,
      offset: nextOffset,
    );

    result.fold(
      (failure) {
        // Don't emit AutoSaveError — that would replace the visible
        // list with an error screen. Just stop the spinner; the
        // user can pull-to-refresh to retry.
        if (current is AutoSaveRulesLoadedState) {
          emit(current.copyWith(isLoadingMore: false));
        }
      },
      (page) {
        // Append, dedup by id (server pagination + concurrent
        // create can race; the server total is authoritative). The
        // append target was already normalised to
        // List<AutoSaveRuleEntity> when the first page landed, so the
        // runtime element type is preserved as we add rows.
        final seen = _cachedRules.map((r) => r.id).toSet();
        for (final r in page.rules) {
          if (seen.add(r.id)) _cachedRules.add(r);
        }
        _currentOffset = nextOffset;
        _hasMore = page.hasMore;
        _totalCount = page.total;
        _emitFilteredAndSorted(_currentFilter, _currentSearch, _currentSort);
      },
    );
  }

  // Filter / sort / search are pushed to the backend so the result
  // is accurate across the entire collection (not just whatever
  // the current page happens to contain). Each call resets the
  // pagination cursor and re-fetches page 1.
  void searchRules(String query) {
    getRulesWithCache(
      forceRefresh: true,
      filter: _currentFilter,
      searchQuery: query,
      sort: _currentSort,
    );
  }

  void filterRules(AutoSaveStatus? status) {
    getRulesWithCache(
      forceRefresh: true,
      filter: status,
      searchQuery: _currentSearch,
      sort: _currentSort,
    );
  }

  void sortRules(RuleSortOption option) {
    getRulesWithCache(
      forceRefresh: true,
      filter: _currentFilter,
      searchQuery: _currentSearch,
      sort: option,
    );
  }

  void _emitFilteredAndSorted(
    AutoSaveStatus? filter,
    String? search,
    RuleSortOption? sort,
  ) {
    // Filter / search / sort are server-side now. The client just
    // renders whatever the last fetch returned; we keep the
    // local sort comparator below as a safety net so a sort
    // change never produces a momentarily-mis-ordered list while
    // the next page fetch is in flight.
    final ordered = _sortRules(
      List<AutoSaveRuleEntity>.from(_cachedRules),
      sort ?? _currentSort,
    );

    if (isClosed) return;
    emit(AutoSaveRulesLoadedState(
      rules: ordered,
      accountNames: _accountNamesCache,
      appliedFilter: filter,
      appliedSearch: search,
      appliedSort: sort ?? _currentSort,
      lastRefreshed: _lastFetch ?? DateTime.now(),
      statistics: _cachedStatistics,
      hasMore: _hasMore,
      isLoadingMore: false,
      totalCount: _totalCount,
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

  /// Re-emit the current cache as a Loaded state without any network
  /// I/O. Used when the rules list screen regains focus (e.g. on
  /// return from the detail page): we want to render the cache
  /// immediately so the empty-state placeholder doesn't flash. Any
  /// mutation that happened in the detail view has already updated
  /// the cache in-place via toggleRuleOptimistic / deleteRule.
  ///
  /// Falls back to a force-refresh when the cache is empty or older
  /// than [_cacheDuration].
  Future<void> refreshFromCache() async {
    final stale = _lastFetch == null ||
        DateTime.now().difference(_lastFetch!) >= _cacheDuration;
    if (_cachedRules.isEmpty || stale) {
      await getRulesWithCache(forceRefresh: stale);
      return;
    }
    _emitFilteredAndSorted(_currentFilter, _currentSearch, _currentSort);
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
