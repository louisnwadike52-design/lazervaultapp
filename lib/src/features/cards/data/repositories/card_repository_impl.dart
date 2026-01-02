import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/data/datasources/card_remote_data_source.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

/// Card repository implementation
class CardRepositoryImpl implements ICardRepository {
  final ICardRemoteDataSource remoteDataSource;

  CardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Card>> createVirtualCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    String? currency,
    String? billingAddress,
  }) async {
    try {
      final card = await remoteDataSource.createVirtualCard(
        accountId: accountId,
        cardHolderName: cardHolderName,
        nickname: nickname,
        currency: currency,
        billingAddress: billingAddress,
      );
      return Right(card);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Card>> createDisposableCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    double? spendingLimit,
    int? maxUsageCount,
    int? expiresInHours,
    String? currency,
    String? billingAddress,
  }) async {
    try {
      final card = await remoteDataSource.createDisposableCard(
        accountId: accountId,
        cardHolderName: cardHolderName,
        nickname: nickname,
        spendingLimit: spendingLimit,
        maxUsageCount: maxUsageCount,
        expiresInHours: expiresInHours,
        currency: currency,
        billingAddress: billingAddress,
      );
      return Right(card);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<Card>>> getUserCards({
    CardType? typeFilter,
    CardStatus? statusFilter,
  }) async {
    try {
      final cards = await remoteDataSource.getUserCards(
        typeFilter: typeFilter,
        statusFilter: statusFilter,
      );
      return Right(cards);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Card>> getCardDetails({
    required String cardUuid,
    bool includeFullDetails = false,
  }) async {
    try {
      final card = await remoteDataSource.getCardDetails(
        cardUuid: cardUuid,
        includeFullDetails: includeFullDetails,
      );
      return Right(card);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Card>> freezeCard({
    required String cardUuid,
    String? reason,
  }) async {
    try {
      final card = await remoteDataSource.freezeCard(
        cardUuid: cardUuid,
        reason: reason,
      );
      return Right(card);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Card>> unfreezeCard({
    required String cardUuid,
  }) async {
    try {
      final card = await remoteDataSource.unfreezeCard(
        cardUuid: cardUuid,
      );
      return Right(card);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> cancelCard({
    required String cardUuid,
    String? reason,
  }) async {
    try {
      await remoteDataSource.cancelCard(
        cardUuid: cardUuid,
        reason: reason,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Card>> updateCardNickname({
    required String cardUuid,
    required String nickname,
  }) async {
    try {
      final card = await remoteDataSource.updateCardNickname(
        cardUuid: cardUuid,
        nickname: nickname,
      );
      return Right(card);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Card>> updateCardSpendingLimit({
    required String cardUuid,
    required double newLimit,
  }) async {
    try {
      final card = await remoteDataSource.updateCardSpendingLimit(
        cardUuid: cardUuid,
        newLimit: newLimit,
      );
      return Right(card);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Card>> setDefaultCard({
    required String cardUuid,
  }) async {
    try {
      final card = await remoteDataSource.setDefaultCard(
        cardUuid: cardUuid,
      );
      return Right(card);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
}
