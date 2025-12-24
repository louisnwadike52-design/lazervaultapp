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
    emit(AutoSaveLoading());

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
      (rule) => emit(AutoSaveRuleCreated(rule)),
    );
  }

  Future<void> getRules({
    String? accountId,
    AutoSaveStatus? status,
  }) async {
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
    emit(AutoSaveLoading());

    final result = await getAutoSaveStatisticsUseCase();

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (statistics) => emit(AutoSaveStatisticsLoaded(statistics)),
    );
  }

  Future<void> triggerSave({
    required String ruleId,
    double? customAmount,
  }) async {
    emit(AutoSaveLoading());

    final result = await triggerAutoSaveUseCase(
      ruleId: ruleId,
      customAmount: customAmount,
    );

    result.fold(
      (failure) => emit(AutoSaveError(failure.message)),
      (transaction) => emit(AutoSaveTransactionTriggered(transaction)),
    );
  }
}
