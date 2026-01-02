import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_code_entity.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_transaction_entity.dart';
import 'package:lazervault/src/features/referral/domain/entities/country_reward_config_entity.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_stats_entity.dart';
import 'package:lazervault/src/features/referral/domain/entities/leaderboard_entry_entity.dart';
import 'package:lazervault/src/features/referral/domain/repositories/i_referral_repository.dart';
import 'package:lazervault/src/features/referral/data/models/referral_code_model.dart';
import 'package:lazervault/src/features/referral/data/models/referral_transaction_model.dart';
import 'package:lazervault/src/features/referral/data/models/country_reward_config_model.dart';
import 'package:lazervault/src/features/referral/data/models/referral_stats_model.dart';
import 'package:lazervault/src/features/referral/data/models/leaderboard_entry_model.dart';
import 'package:lazervault/src/generated/referral.pbgrpc.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as referral_pb;

class ReferralRepositoryImpl implements IReferralRepository {
  final ReferralServiceClient _referralServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  ReferralRepositoryImpl({
    required ReferralServiceClient referralServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _referralServiceClient = referralServiceClient,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<Either<Failure, bool>> validateReferralCode({
    required String code,
  }) async {
    try {
      final request = referral_pb.ValidateReferralCodeRequest(code: code);
      final response = await _referralServiceClient.validateReferralCode(request);

      if (response.isValid) {
        return const Right(true);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Invalid referral code',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error validating referral code: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to validate referral code',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error validating referral code: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ReferralCodeEntity>> getMyReferralCode() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = referral_pb.GetMyReferralCodeRequest();
      final response = await _referralServiceClient.getMyReferralCode(
        request,
        options: callOptions,
      );

      if (response.hasReferralCode()) {
        final codeModel = ReferralCodeModel.fromProto(response.referralCode);
        return Right(codeModel);
      } else {
        return Left(ServerFailure(
          message: 'Failed to retrieve referral code',
          statusCode: 404,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting referral code: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get referral code',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting referral code: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ReferralStatsEntity>> getMyReferralStats() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = referral_pb.GetMyReferralStatsRequest();
      final response = await _referralServiceClient.getMyReferralStats(
        request,
        options: callOptions,
      );

      if (response.hasStats()) {
        final statsModel = ReferralStatsModel.fromProto(response.stats);
        return Right(statsModel);
      } else {
        return Left(ServerFailure(
          message: 'Failed to retrieve referral statistics',
          statusCode: 404,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting referral stats: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get referral statistics',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting referral stats: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<ReferralTransactionEntity>>> getMyReferrals({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = referral_pb.GetMyReferralsRequest(
        page: page,
        pageSize: pageSize,
      );
      final response = await _referralServiceClient.getMyReferrals(
        request,
        options: callOptions,
      );

      final transactions = response.referrals
          .map((proto) => ReferralTransactionModel.fromProto(proto))
          .toList();
      return Right(transactions);
    } on GrpcError catch (e) {
      print('gRPC Error getting referrals: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get referrals',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting referrals: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<LeaderboardEntryEntity>>> getReferralLeaderboard({
    int limit = 10,
    String period = 'all_time',
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = referral_pb.GetReferralLeaderboardRequest(
        limit: limit,
      );
      final response = await _referralServiceClient.getReferralLeaderboard(
        request,
        options: callOptions,
      );

      final leaderboard = response.entries
          .map((proto) => LeaderboardEntryModel.fromProto(proto))
          .toList();
      return Right(leaderboard);
    } on GrpcError catch (e) {
      print('gRPC Error getting leaderboard: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get leaderboard',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting leaderboard: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, CountryRewardConfigEntity>> getCountryRewardConfig({
    String? countryCode,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = referral_pb.GetCountryRewardConfigRequest(
        countryCode: countryCode ?? '',
      );
      final response = await _referralServiceClient.getCountryRewardConfig(
        request,
        options: callOptions,
      );

      if (response.hasConfig()) {
        final configModel = CountryRewardConfigModel.fromProto(response.config);
        return Right(configModel);
      } else {
        return Left(ServerFailure(
          message: 'Failed to retrieve country reward configuration',
          statusCode: 404,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting country config: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get country reward configuration',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting country config: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }
}
