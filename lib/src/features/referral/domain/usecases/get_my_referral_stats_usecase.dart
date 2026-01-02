import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/referral_stats_entity.dart';
import '../repositories/i_referral_repository.dart';

class GetMyReferralStatsUseCase {
  final IReferralRepository repository;

  GetMyReferralStatsUseCase(this.repository);

  Future<Either<Failure, ReferralStatsEntity>> call() async {
    return await repository.getMyReferralStats();
  }
}
