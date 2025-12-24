import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';

class CreateAutoSaveRuleUseCase {
  final IAutoSaveRepository repository;

  const CreateAutoSaveRuleUseCase(this.repository);

  Future<Either<Failure, AutoSaveRuleEntity>> call({
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
  }) {
    return repository.createAutoSaveRule(
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
  }
}
