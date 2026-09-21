import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/referral_code_entity.dart';
import '../entities/referral_transaction_entity.dart';
import '../entities/country_reward_config_entity.dart';
import '../entities/referral_stats_entity.dart';
import '../entities/leaderboard_entry_entity.dart';
import '../entities/points_balance_entity.dart';
import '../entities/point_transaction_entity.dart';
import '../entities/points_breakdown_entity.dart';
import '../entities/points_config_entity.dart';
import '../entities/redemption_entities.dart';

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
    String filter = '',
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

  /// Get user's LazerPoints balance
  Future<Either<Failure, PointsBalanceEntity>> getMyPointsBalance();

  /// Get user's LazerPoints transaction history
  Future<Either<Failure, List<PointTransactionEntity>>> getMyPointsHistory({
    int page = 1,
    int pageSize = 20,
  });

  /// Get LazerPoints earn rules/configuration
  Future<Either<Failure, List<PointsConfigEntity>>> getPointsConfig();

  /// Where the balance came from, per product.
  ///
  /// An empty breakdown is the normal state of a new account, not a failure.
  Future<Either<Failure, PointsBreakdownEntity>> getPointsBreakdown();

  /// What converting [points] would be worth. 0 quotes the whole balance,
  /// which is what the screen opens on.
  Future<Either<Failure, RedemptionQuoteEntity>> getRedemptionQuote({int points});

  /// Convert points to cash.
  ///
  /// [idempotencyKey] must be stable across retries of the SAME attempt: a
  /// timeout that is retried has to convert once, not twice.
  Future<Either<Failure, RedemptionResultEntity>> redeemPoints({
    required int points,
    required String idempotencyKey,
  });
}
