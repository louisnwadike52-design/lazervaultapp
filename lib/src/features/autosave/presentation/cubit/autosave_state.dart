import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

sealed class AutoSaveState extends Equatable {
  const AutoSaveState();

  @override
  List<Object?> get props => [];
}

class AutoSaveInitial extends AutoSaveState {}

class AutoSaveLoading extends AutoSaveState {}

class AutoSaveRulesLoaded extends AutoSaveState {
  final List<AutoSaveRuleEntity> rules;

  const AutoSaveRulesLoaded(this.rules);

  @override
  List<Object?> get props => [rules];
}

class AutoSaveRuleCreated extends AutoSaveState {
  final AutoSaveRuleEntity rule;

  const AutoSaveRuleCreated(this.rule);

  @override
  List<Object?> get props => [rule];
}

class AutoSaveRuleUpdated extends AutoSaveState {
  final AutoSaveRuleEntity rule;

  const AutoSaveRuleUpdated(this.rule);

  @override
  List<Object?> get props => [rule];
}

class AutoSaveRuleDeleted extends AutoSaveState {
  final String ruleId;

  const AutoSaveRuleDeleted(this.ruleId);

  @override
  List<Object?> get props => [ruleId];
}

class AutoSaveTransactionsLoaded extends AutoSaveState {
  final List<AutoSaveTransactionEntity> transactions;

  const AutoSaveTransactionsLoaded(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class AutoSaveStatisticsLoaded extends AutoSaveState {
  final AutoSaveStatisticsEntity statistics;

  const AutoSaveStatisticsLoaded(this.statistics);

  @override
  List<Object?> get props => [statistics];
}

class AutoSaveTransactionTriggered extends AutoSaveState {
  final AutoSaveTransactionEntity transaction;

  const AutoSaveTransactionTriggered(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

// Granular loading states for better UX
class AutoSaveRulesLoadingState extends AutoSaveState {
  final List<AutoSaveRuleEntity> cachedRules; // Show cached while loading

  const AutoSaveRulesLoadingState({this.cachedRules = const []});

  @override
  List<Object?> get props => [cachedRules];
}

class AutoSaveRuleTogglingState extends AutoSaveState {
  final String ruleId;
  final bool newStatus; // For optimistic update

  const AutoSaveRuleTogglingState(this.ruleId, this.newStatus);

  @override
  List<Object?> get props => [ruleId, newStatus];
}

class AutoSaveRuleDeletingState extends AutoSaveState {
  final String ruleId;

  const AutoSaveRuleDeletingState(this.ruleId);

  @override
  List<Object?> get props => [ruleId];
}

class AutoSaveRuleTriggeringState extends AutoSaveState {
  final String ruleId;

  const AutoSaveRuleTriggeringState(this.ruleId);

  @override
  List<Object?> get props => [ruleId];
}

// Enhanced loaded state with metadata
class AutoSaveRulesLoadedState extends AutoSaveState {
  final List<AutoSaveRuleEntity> rules;
  final Map<String, String> accountNames; // accountId -> accountName mapping
  final AutoSaveStatus? appliedFilter;
  final String? appliedSearch;
  final RuleSortOption? appliedSort;
  final DateTime lastRefreshed;
  // Backend-aggregated statistics fetched alongside the rules list.
  // Carries lifetime totals + best-performing rule so the analytics
  // card stops re-aggregating client-side from the (paginated) rules
  // array. Optional for back-compat with paths that only fetch rules.
  final AutoSaveStatisticsEntity? statistics;
  // Pagination state for infinite-scroll. hasMore is false when the
  // backend has returned fewer rows than the requested page size.
  final bool hasMore;
  final bool isLoadingMore;
  // Total rules in the user's account regardless of the active
  // search/filter — used by the rule count subheader so it doesn't
  // tick down when filters are applied.
  final int totalCount;

  const AutoSaveRulesLoadedState({
    required this.rules,
    this.accountNames = const {},
    this.appliedFilter,
    this.appliedSearch,
    this.appliedSort,
    required this.lastRefreshed,
    this.statistics,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.totalCount = 0,
  });

  AutoSaveRulesLoadedState copyWith({
    List<AutoSaveRuleEntity>? rules,
    Map<String, String>? accountNames,
    AutoSaveStatus? appliedFilter,
    String? appliedSearch,
    RuleSortOption? appliedSort,
    DateTime? lastRefreshed,
    AutoSaveStatisticsEntity? statistics,
    bool? hasMore,
    bool? isLoadingMore,
    int? totalCount,
  }) {
    return AutoSaveRulesLoadedState(
      rules: rules ?? this.rules,
      accountNames: accountNames ?? this.accountNames,
      appliedFilter: appliedFilter ?? this.appliedFilter,
      appliedSearch: appliedSearch ?? this.appliedSearch,
      appliedSort: appliedSort ?? this.appliedSort,
      lastRefreshed: lastRefreshed ?? this.lastRefreshed,
      statistics: statistics ?? this.statistics,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object?> get props => [
        rules,
        accountNames,
        appliedFilter,
        appliedSearch,
        appliedSort,
        lastRefreshed,
        statistics,
        hasMore,
        isLoadingMore,
        totalCount,
      ];
}

// Operation-specific success states
class AutoSaveRuleToggleSuccess extends AutoSaveState {
  final AutoSaveRuleEntity rule;

  const AutoSaveRuleToggleSuccess(this.rule);

  @override
  List<Object?> get props => [rule];
}

class AutoSaveRuleDeleteSuccess extends AutoSaveState {
  final String ruleId;

  const AutoSaveRuleDeleteSuccess(this.ruleId);

  @override
  List<Object?> get props => [ruleId];
}

class AutoSaveBulkOperationSuccess extends AutoSaveState {
  final BulkOperationType operation;
  final int affectedCount;

  const AutoSaveBulkOperationSuccess(this.operation, this.affectedCount);

  @override
  List<Object?> get props => [operation, affectedCount];
}

// Enums
enum RuleSortOption {
  nameAsc,
  nameDesc,
  dateCreatedDesc,
  dateCreatedAsc,
  totalSavedDesc,
  totalSavedAsc,
  statusActive,
}

enum BulkOperationType {
  pause,
  resume,
  delete,
  archive,
}

// Processing states for step-by-step feedback
class AutoSaveRuleCreating extends AutoSaveState {
  final String step;
  final int currentStepIndex;
  final int totalSteps;

  const AutoSaveRuleCreating({
    required this.step,
    required this.currentStepIndex,
    this.totalSteps = 4,
  });

  @override
  List<Object?> get props => [step, currentStepIndex, totalSteps];
}

class AutoSaveTriggerProcessing extends AutoSaveState {
  final String step;
  final int currentStepIndex;
  final int totalSteps;

  const AutoSaveTriggerProcessing({
    required this.step,
    required this.currentStepIndex,
    this.totalSteps = 4,
  });

  @override
  List<Object?> get props => [step, currentStepIndex, totalSteps];
}

class AutoSaveTriggerQueued extends AutoSaveState {
  final String message;

  const AutoSaveTriggerQueued({required this.message});

  @override
  List<Object?> get props => [message];
}

class AutoSaveDashboardLoaded extends AutoSaveState {
  final AutoSaveStatisticsEntity statistics;
  final List<AutoSaveRuleEntity> rules;

  const AutoSaveDashboardLoaded({
    required this.statistics,
    required this.rules,
  });

  @override
  List<Object?> get props => [statistics, rules];
}

class AutoSaveError extends AutoSaveState {
  final String message;

  const AutoSaveError(this.message);

  @override
  List<Object?> get props => [message];
}
