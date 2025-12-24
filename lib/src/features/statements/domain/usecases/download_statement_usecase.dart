import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/statements/domain/repositories/i_statement_repository.dart';

class DownloadStatementUseCase {
  final IStatementRepository repository;

  const DownloadStatementUseCase(this.repository);

  Future<Either<Failure, StatementEntity>> call({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    required StatementFormat format,
  }) async {
    return await repository.downloadStatement(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
      format: format,
    );
  }
}
