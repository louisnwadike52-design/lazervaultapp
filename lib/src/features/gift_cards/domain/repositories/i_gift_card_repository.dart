import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import '../entities/gift_card_entity.dart';

abstract class IGiftCardRepository {
  Future<Either<Failure, PaginatedBrands>> getGiftCardBrands({
    String? category,
    String? countryCode,
    String? searchQuery,
    int page = 0,
    int pageSize = 20,
  });

  Future<Either<Failure, List<GiftCardCountry>>> getSupportedCountries();

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
    int quantity,
    String? providerName,
    double? senderAmount,
    String? senderCurrency,
  });

  Future<Either<Failure, List<GiftCard>>> getUserGiftCards({
    String? status,
    String? brandId,
    int limit,
    int offset,
  });

  Future<Either<Failure, GiftCard>> getGiftCardById(String giftCardId);

  Future<Either<Failure, List<GiftCardTransaction>>> getGiftCardHistory({
    String? giftCardId,
    String? transactionType,
    int limit,
    int offset,
  });

  Future<Either<Failure, Map<String, String>>> getRedeemCode({
    required String transactionId,
    bool forceRefresh = false,
  });

  Future<Either<Failure, GiftCard>> transferGiftCard({
    required String giftCardId,
    required String recipientEmail,
    required String recipientName,
    required String message,
    required String transactionId,
    required String verificationToken,
    String? recipientUserId,
    String transferType = 'email',
  });

  // Sell flow methods

  Future<Either<Failure, List<SellableCard>>> getSellableCards({String? countryCode});

  Future<Either<Failure, SellRate>> getSellRate({
    required String cardType,
    required double denomination,
    String? currency,
  });

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
  });

  Future<Either<Failure, GiftCardSale>> getSellStatus(String saleId);

  Future<Either<Failure, List<GiftCardSale>>> getMySales({
    String? status,
    int limit,
    int offset,
  });

  Future<Either<Failure, Map<String, String>>> uploadSellImage({
    required String imageData,
    required String contentType,
    required String filename,
  });

  Future<Either<Failure, Map<String, dynamic>>> extractCardDetails({
    required List<String> imageUrls,
  });

  Future<Either<Failure, List<Settlement>>> getSettlementHistory();
}
