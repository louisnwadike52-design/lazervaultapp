import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';

class GetAutoSaveRulesUseCase {
  final IAutoSaveRepository repository;

  const GetAutoSaveRulesUseCase(this.repository);

  Future<Either<Failure, List<AutoSaveRuleEntity>>> call({
    String? accountId,
    AutoSaveStatus? status,
  }) {
    return repository.getAutoSaveRules(
      accountId: accountId,
      status: status,
    );
  }
}
