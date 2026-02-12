import '../models/gift_card_model.dart';

abstract class IGiftCardRemoteDataSource {
  Future<List<GiftCardBrandModel>> getGiftCardBrands({
    String? category,
    String? countryCode,
  });

  Future<GiftCardModel> buyGiftCard({
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

  Future<List<GiftCardModel>> getUserGiftCards({
    String? status,
    String? brandId,
    int limit,
    int offset,
  });

  Future<GiftCardModel> getGiftCardById(String giftCardId);

  Future<List<GiftCardTransactionModel>> getGiftCardHistory({
    String? giftCardId,
    String? transactionType,
    int limit,
    int offset,
  });

  Future<GiftCardModel> redeemGiftCard({
    required String accountId,
    required String cardNumber,
    required String cardPin,
  });

  Future<GiftCardModel> transferGiftCard({
    required String giftCardId,
    required String recipientEmail,
    required String recipientName,
    required String message,
    required String transactionId,
    required String verificationToken,
  });

  Future<GiftCardBalanceModel> getGiftCardBalance({
    required String cardNumber,
    required String cardPin,
  });

  // Sell flow methods

  Future<List<SellableCardModel>> getSellableCards();

  Future<SellRateModel> getSellRate({
    required String cardType,
    required double denomination,
    String? currency,
  });

  Future<GiftCardSaleModel> sellGiftCard({
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

  Future<GiftCardSaleModel> getSellStatus(String saleId);

  Future<List<GiftCardSaleModel>> getMySales({
    String? status,
    int limit,
    int offset,
  });
}
