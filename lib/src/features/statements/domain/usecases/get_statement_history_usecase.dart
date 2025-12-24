import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/statements/domain/repositories/i_statement_repository.dart';

class GetStatementHistoryUseCase {
  final IStatementRepository repository;

  const GetStatementHistoryUseCase(this.repository);

  Future<Either<Failure, List<StatementEntity>>> call({
    required String accountId,
    int? limit,
  }) async {
    return await repository.getStatementHistory(
      accountId: accountId,
      limit: limit,
    );
  }
}
