import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';

class GetAutoSaveStatisticsUseCase {
  final IAutoSaveRepository repository;

  const GetAutoSaveStatisticsUseCase(this.repository);

  Future<Either<Failure, AutoSaveStatisticsEntity>> call() {
    return repository.getAutoSaveStatistics();
  }
}
