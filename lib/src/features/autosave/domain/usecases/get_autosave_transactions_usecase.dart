import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';

class GetAutoSaveTransactionsUseCase {
  final IAutoSaveRepository repository;

  const GetAutoSaveTransactionsUseCase(this.repository);

  Future<Either<Failure, List<AutoSaveTransactionEntity>>> call({
    String? ruleId,
    String? accountId,
    int? limit,
    int? offset,
  }) {
    return repository.getAutoSaveTransactions(
      ruleId: ruleId,
      accountId: accountId,
      limit: limit,
      offset: offset,
    );
  }
}
