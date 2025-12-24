import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';

class TriggerAutoSaveUseCase {
  final IAutoSaveRepository repository;

  const TriggerAutoSaveUseCase(this.repository);

  Future<Either<Failure, AutoSaveTransactionEntity>> call({
    required String ruleId,
    double? customAmount,
  }) {
    return repository.triggerAutoSave(
      ruleId: ruleId,
      customAmount: customAmount,
    );
  }
}
