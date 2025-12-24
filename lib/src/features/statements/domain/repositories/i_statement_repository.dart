import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';

abstract class IStatementRepository {
  Future<Either<Failure, StatementEntity>> downloadStatement({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    required StatementFormat format,
  });

  Future<Either<Failure, List<StatementEntity>>> getStatementHistory({
    required String accountId,
    int? limit,
  });
}
