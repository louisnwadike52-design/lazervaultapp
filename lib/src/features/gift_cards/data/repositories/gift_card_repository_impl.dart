import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import 'package:lazervault/core/network/retry_policy.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../domain/repositories/i_gift_card_repository.dart';
import '../datasources/gift_card_remote_data_source.dart';

class GiftCardRepositoryImpl implements IGiftCardRepository {
  final IGiftCardRemoteDataSource _remoteDataSource;

  GiftCardRepositoryImpl({
    required IGiftCardRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<GiftCardBrand>>> getGiftCardBrands() async {
    try {
      final brands = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getGiftCardBrands(),
        onRetry: (attempt, error) {
          print('Retrying fetch brands (attempt $attempt) due to: $error');
        },
      );

      return Right(brands);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardBrand>>> getGiftCardBrandsByCategory(
      GiftCardCategory category) async {
    try {
      final brands = await _remoteDataSource.getGiftCardBrandsByCategory(category);
      return Right(brands);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardBrand>>> searchGiftCardBrands(String query) async {
    try {
      final brands = await _remoteDataSource.searchGiftCardBrands(query);
      return Right(brands);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCardBrand>> getGiftCardBrandById(String brandId) async {
    try {
      final brand = await _remoteDataSource.getGiftCardBrandById(brandId);
      return Right(brand);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCard>> purchaseGiftCard({
    required String brandId,
    required double amount,
    required String currency,
    String? recipientEmail,
    String? recipientName,
    String? message,
  }) async {
    try {
      final giftCard = await RetryPolicy.critical.execute(
        () => _remoteDataSource.purchaseGiftCard(
          brandId: brandId,
          amount: amount,
          currency: currency,
          recipientEmail: recipientEmail,
          recipientName: recipientName,
          message: message,
        ),
        onRetry: (attempt, error) {
          print('Retrying purchase (attempt $attempt) due to: $error');
        },
      );

      return Right(giftCard);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCard>>> getUserGiftCards() async {
    try {
      final giftCards = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getUserGiftCards(),
        onRetry: (attempt, error) {
          print('Retrying fetch user cards (attempt $attempt) due to: $error');
        },
      );

      return Right(giftCards);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCard>> getGiftCardById(String giftCardId) async {
    try {
      final giftCard = await _remoteDataSource.getGiftCardById(giftCardId);
      return Right(giftCard);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCard>> redeemGiftCard(String giftCardId, String code) async {
    try {
      final giftCard = await RetryPolicy.critical.execute(
        () => _remoteDataSource.redeemGiftCard(giftCardId, code),
        onRetry: (attempt, error) {
          print('Retrying redemption (attempt $attempt) due to: $error');
        },
      );

      return Right(giftCard);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardTransaction>>> getGiftCardTransactions() async {
    try {
      final transactions = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getGiftCardTransactions(),
        onRetry: (attempt, error) {
          print('Retrying fetch transactions (attempt $attempt) due to: $error');
        },
      );

      return Right(transactions);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCardTransaction>> getTransactionById(String transactionId) async {
    try {
      final transaction = await _remoteDataSource.getTransactionById(transactionId);
      return Right(transaction);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCard>> sendGiftCard({
    required String giftCardId,
    required String recipientEmail,
    String? message,
  }) async {
    try {
      final giftCard = await _remoteDataSource.sendGiftCard(
        giftCardId: giftCardId,
        recipientEmail: recipientEmail,
        message: message,
      );
      return Right(giftCard);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> validateGiftCardCode(String code) async {
    try {
      final isValid = await _remoteDataSource.validateGiftCardCode(code);
      return Right(isValid);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, double>> getGiftCardBalance(String giftCardId) async {
    try {
      final balance = await _remoteDataSource.getGiftCardBalance(giftCardId);
      return Right(balance);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCard>> sellGiftCard({
    required String giftCardId,
    required double sellingPrice,
  }) async {
    try {
      // Critical operation - use retry with extended attempts
      final giftCard = await RetryPolicy.critical.execute(
        () => _remoteDataSource.sellGiftCard(
          giftCardId: giftCardId,
          sellingPrice: sellingPrice,
        ),
        onRetry: (attempt, error) {
          print('Retrying sell gift card (attempt $attempt) due to: $error');
        },
      );
      return Right(giftCard);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCard>>> getResellableGiftCards() async {
    try {
      final giftCards = await _remoteDataSource.getResellableGiftCards();
      return Right(giftCards);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 500));
    }
  }
} 