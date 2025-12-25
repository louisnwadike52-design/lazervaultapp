import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

abstract class AutoSaveState extends Equatable {
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

  const AutoSaveRulesLoadedState({
    required this.rules,
    this.accountNames = const {},
    this.appliedFilter,
    this.appliedSearch,
    this.appliedSort,
    required this.lastRefreshed,
  });

  @override
  List<Object?> get props => [
        rules,
        accountNames,
        appliedFilter,
        appliedSearch,
        appliedSort,
        lastRefreshed,
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

class AutoSaveError extends AutoSaveState {
  final String message;

  const AutoSaveError(this.message);

  @override
  List<Object?> get props => [message];
}
