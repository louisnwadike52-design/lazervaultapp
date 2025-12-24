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

class AutoSaveError extends AutoSaveState {
  final String message;

  const AutoSaveError(this.message);

  @override
  List<Object?> get props => [message];
}
