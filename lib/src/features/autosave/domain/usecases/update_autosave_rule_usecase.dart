import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';

class UpdateAutoSaveRuleUseCase {
  final IAutoSaveRepository repository;

  const UpdateAutoSaveRuleUseCase(this.repository);

  Future<Either<Failure, AutoSaveRuleEntity>> call({
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
  }) {
    return repository.updateAutoSaveRule(
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
  }
}
