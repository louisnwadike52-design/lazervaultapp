import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';

class DeleteAutoSaveRuleUseCase {
  final IAutoSaveRepository repository;

  const DeleteAutoSaveRuleUseCase(this.repository);

  Future<Either<Failure, bool>> call({required String ruleId}) {
    return repository.deleteAutoSaveRule(ruleId: ruleId);
  }
}
