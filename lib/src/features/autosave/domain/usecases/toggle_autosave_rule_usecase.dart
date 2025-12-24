import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';

class ToggleAutoSaveRuleUseCase {
  final IAutoSaveRepository repository;

  const ToggleAutoSaveRuleUseCase(this.repository);

  Future<Either<Failure, AutoSaveRuleEntity>> call({
    required String ruleId,
    required String action,
  }) {
    return repository.toggleAutoSaveRule(
      ruleId: ruleId,
      action: action,
    );
  }
}
