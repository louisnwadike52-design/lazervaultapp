import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/referral_code_entity.dart';
import '../entities/referral_transaction_entity.dart';
import '../entities/country_reward_config_entity.dart';
import '../entities/referral_stats_entity.dart';
import '../entities/leaderboard_entry_entity.dart';

abstract class IReferralRepository {
  /// Validate a referral code (used during signup)
  Future<Either<Failure, bool>> validateReferralCode({
    required String code,
  });

  /// Get authenticated user's referral code
  Future<Either<Failure, ReferralCodeEntity>> getMyReferralCode();

  /// Get user's referral statistics
  Future<Either<Failure, ReferralStatsEntity>> getMyReferralStats();

  /// Get list of users who signed up with my referral code
  Future<Either<Failure, List<ReferralTransactionEntity>>> getMyReferrals({
    int page = 1,
    int pageSize = 20,
  });

  /// Get referral leaderboard
  Future<Either<Failure, List<LeaderboardEntryEntity>>> getReferralLeaderboard({
    int limit = 10,
    String period = 'all_time',
  });

  /// Get country-specific reward configuration
  Future<Either<Failure, CountryRewardConfigEntity>> getCountryRewardConfig({
    String? countryCode,
  });
}
