import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/points_config_entity.dart';
import '../repositories/i_referral_repository.dart';

class GetPointsConfigUseCase {
  final IReferralRepository repository;

  GetPointsConfigUseCase(this.repository);

  Future<Either<Failure, List<PointsConfigEntity>>> call() async {
    return await repository.getPointsConfig();
  }
}
