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

  /// Extract clean error message, stripping "Exception:" prefix
  static String _extractErrorMessage(Object e) {
    final msg = e.toString();
    // Strip "Exception: " prefix if present
    if (msg.startsWith('Exception: ')) {
      return msg.substring(11);
    }
    return msg;
  }

  @override
  Future<Either<Failure, PaginatedBrands>> getGiftCardBrands({
    String? category,
    String? countryCode,
    String? searchQuery,
    int page = 0,
    int pageSize = 20,
  }) async {
    try {
      final result = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getGiftCardBrands(
          category: category,
          countryCode: countryCode,
          searchQuery: searchQuery,
          page: page,
          pageSize: pageSize,
        ),
      );

      return Right(PaginatedBrands(
        brands: result.brands,
        total: result.total,
        totalPages: result.totalPages,
        currentPage: result.currentPage,
        hasNext: result.hasNext,
      ));
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardCountry>>> getSupportedCountries() async {
    try {
      final countries = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getSupportedCountries(),
      );
      return Right(countries);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCard>> buyGiftCard({
    required String brandId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    int? productId,
    String? recipientEmail,
    String? recipientName,
    String? giftMessage,
    String? senderName,
    String? recipientPhone,
    String? countryCode,
    String? idempotencyKey,
    int quantity = 1,
    String? providerName,
    double? senderAmount,
    String? senderCurrency,
  }) async {
    try {
      final giftCard = await RetryPolicy.critical.execute(
        () => _remoteDataSource.buyGiftCard(
          brandId: brandId,
          amount: amount,
          transactionId: transactionId,
          verificationToken: verificationToken,
          productId: productId,
          recipientEmail: recipientEmail,
          recipientName: recipientName,
          giftMessage: giftMessage,
          senderName: senderName,
          recipientPhone: recipientPhone,
          countryCode: countryCode,
          idempotencyKey: idempotencyKey,
          quantity: quantity,
          providerName: providerName,
          senderAmount: senderAmount,
          senderCurrency: senderCurrency,
        ),
      );

      return Right(giftCard);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCard>>> getUserGiftCards({
    String? status,
    String? brandId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final giftCards = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getUserGiftCards(
          status: status,
          brandId: brandId,
          limit: limit,
          offset: offset,
        ),
      );

      return Right(giftCards);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCard>> getGiftCardById(String giftCardId) async {
    try {
      final giftCard = await _remoteDataSource.getGiftCardById(giftCardId);
      return Right(giftCard);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardTransaction>>> getGiftCardHistory({
    String? giftCardId,
    String? transactionType,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final transactions = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getGiftCardHistory(
          giftCardId: giftCardId,
          transactionType: transactionType,
          limit: limit,
          offset: offset,
        ),
      );

      return Right(transactions);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> getRedeemCode({
    required String transactionId,
    bool forceRefresh = false,
  }) async {
    try {
      final result = await _remoteDataSource.getRedeemCode(
        transactionId: transactionId,
        forceRefresh: forceRefresh,
      );
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCard>> transferGiftCard({
    required String giftCardId,
    required String recipientEmail,
    required String recipientName,
    required String message,
    required String transactionId,
    required String verificationToken,
    String? recipientUserId,
    String transferType = 'email',
  }) async {
    try {
      final giftCard = await RetryPolicy.critical.execute(
        () => _remoteDataSource.transferGiftCard(
          giftCardId: giftCardId,
          recipientEmail: recipientEmail,
          recipientName: recipientName,
          message: message,
          transactionId: transactionId,
          verificationToken: verificationToken,
          recipientUserId: recipientUserId,
          transferType: transferType,
        ),
      );
      return Right(giftCard);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  // Sell flow methods

  @override
  Future<Either<Failure, List<SellableCard>>> getSellableCards({String? countryCode}) async {
    try {
      final cards = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getSellableCards(countryCode: countryCode),
      );
      return Right(cards);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, SellRate>> getSellRate({
    required String cardType,
    required double denomination,
    String? currency,
  }) async {
    try {
      final rate = await _remoteDataSource.getSellRate(
        cardType: cardType,
        denomination: denomination,
        currency: currency,
      );
      return Right(rate);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCardSale>> sellGiftCard({
    required String cardType,
    required String cardNumber,
    required String cardPin,
    required double denomination,
    required String transactionId,
    required String verificationToken,
    String? currency,
    List<String>? images,
    String? idempotencyKey,
    String? providerName,
    String? cardCountry,
    String? cardFormat,
    List<String>? imageUrls,
    List<String>? imageKeys,
    String? ocrBrand,
    String? ocrCardNumber,
    String? ocrPin,
    double? ocrDenomination,
    String? ocrCurrency,
  }) async {
    try {
      final sale = await RetryPolicy.critical.execute(
        () => _remoteDataSource.sellGiftCard(
          cardType: cardType,
          cardNumber: cardNumber,
          cardPin: cardPin,
          denomination: denomination,
          transactionId: transactionId,
          verificationToken: verificationToken,
          currency: currency,
          images: images,
          idempotencyKey: idempotencyKey,
          providerName: providerName,
          cardCountry: cardCountry,
          cardFormat: cardFormat,
          imageUrls: imageUrls,
          imageKeys: imageKeys,
          ocrBrand: ocrBrand,
          ocrCardNumber: ocrCardNumber,
          ocrPin: ocrPin,
          ocrDenomination: ocrDenomination,
          ocrCurrency: ocrCurrency,
        ),
      );
      return Right(sale);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, GiftCardSale>> getSellStatus(String saleId) async {
    try {
      final sale = await _remoteDataSource.getSellStatus(saleId);
      return Right(sale);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardSale>>> getMySales({
    String? status,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final sales = await RetryPolicy.standard.execute(
        () => _remoteDataSource.getMySales(
          status: status,
          limit: limit,
          offset: offset,
        ),
      );
      return Right(sales);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> uploadSellImage({
    required String imageData,
    required String contentType,
    required String filename,
  }) async {
    try {
      final result = await _remoteDataSource.uploadSellImage(
        imageData: imageData,
        contentType: contentType,
        filename: filename,
      );
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> extractCardDetails({
    required List<String> imageUrls,
  }) async {
    try {
      final result = await _remoteDataSource.extractCardDetails(
        imageUrls: imageUrls,
      );
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: _extractErrorMessage(e), statusCode: 500));
    }
  }
}
