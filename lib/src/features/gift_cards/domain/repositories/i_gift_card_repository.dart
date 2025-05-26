import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import '../entities/gift_card_entity.dart';
 
abstract class IGiftCardRepository {
  Future<Either<Failure, List<GiftCardBrand>>> getGiftCardBrands();
  Future<Either<Failure, List<GiftCardBrand>>> getGiftCardBrandsByCategory(GiftCardCategory category);
  Future<Either<Failure, List<GiftCardBrand>>> searchGiftCardBrands(String query);
  Future<Either<Failure, GiftCardBrand>> getGiftCardBrandById(String brandId);
  
  Future<Either<Failure, GiftCard>> purchaseGiftCard({
    required String brandId,
    required double amount,
    required String currency,
    String? recipientEmail,
    String? recipientName,
    String? message,
  });
  
  Future<Either<Failure, List<GiftCard>>> getUserGiftCards();
  Future<Either<Failure, GiftCard>> getGiftCardById(String giftCardId);
  Future<Either<Failure, GiftCard>> redeemGiftCard(String giftCardId, String code);
  
  Future<Either<Failure, List<GiftCardTransaction>>> getGiftCardTransactions();
  Future<Either<Failure, GiftCardTransaction>> getTransactionById(String transactionId);
  
  Future<Either<Failure, GiftCard>> sendGiftCard({
    required String giftCardId,
    required String recipientEmail,
    String? message,
  });
  
  Future<Either<Failure, bool>> validateGiftCardCode(String code);
  Future<Either<Failure, double>> getGiftCardBalance(String giftCardId);
  
  Future<Either<Failure, GiftCard>> sellGiftCard({
    required String giftCardId,
    required double sellingPrice,
  });
  
  Future<Either<Failure, List<GiftCard>>> getResellableGiftCards();
} 