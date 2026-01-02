import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/leaderboard_entry_entity.dart';
import '../repositories/i_referral_repository.dart';

class GetReferralLeaderboardUseCase {
  final IReferralRepository repository;

  GetReferralLeaderboardUseCase(this.repository);

  Future<Either<Failure, List<LeaderboardEntryEntity>>> call({
    int limit = 10,
    String period = 'all_time',
  }) async {
    return await repository.getReferralLeaderboard(
      limit: limit,
      period: period,
    );
  }
}
