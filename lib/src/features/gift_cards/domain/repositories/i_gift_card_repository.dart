import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import '../entities/gift_card_entity.dart';

abstract class IGiftCardRepository {
  Future<Either<Failure, List<GiftCardBrand>>> getGiftCardBrands({
    String? category,
    String? countryCode,
  });

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

  Future<Either<Failure, GiftCard>> redeemGiftCard({
    required String accountId,
    required String cardNumber,
    required String cardPin,
  });

  Future<Either<Failure, GiftCard>> transferGiftCard({
    required String giftCardId,
    required String recipientEmail,
    required String recipientName,
    required String message,
    required String transactionId,
    required String verificationToken,
  });

  Future<Either<Failure, GiftCardBalance>> getGiftCardBalance({
    required String cardNumber,
    required String cardPin,
  });

  // Sell flow methods

  Future<Either<Failure, List<SellableCard>>> getSellableCards();

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
  });

  Future<Either<Failure, GiftCardSale>> getSellStatus(String saleId);

  Future<Either<Failure, List<GiftCardSale>>> getMySales({
    String? status,
    int limit,
    int offset,
  });
}
