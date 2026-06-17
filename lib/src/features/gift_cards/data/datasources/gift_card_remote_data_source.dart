import '../../domain/entities/gift_card_entity.dart';
import '../models/gift_card_model.dart';

abstract class IGiftCardRemoteDataSource {
  Future<GiftCardBrandsResult> getGiftCardBrands({
    String? category,
    String? countryCode,
    String? searchQuery,
    int page = 0,
    int pageSize = 20,
  });

  Future<List<GiftCardCountry>> getSupportedCountries();

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
    String? providerName,
    double? senderAmount,
    String? senderCurrency,
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

  /// Fetches the merchant redeem code for a purchased gift card from the provider.
  /// Returns a map with: redemptionCode, redemptionPin, transactionId, status, message
  Future<Map<String, String>> getRedeemCode({
    required String transactionId,
    bool forceRefresh = false,
  });

  // Sell flow methods

  Future<List<SellableCardModel>> getSellableCards({String? countryCode});

  Future<SellRateModel> getSellRate({
    required String cardType,
    required double denomination,
    String? currency,
  });

  /// Returns the active sell-provider's payout methods, available-only,
  /// for the Flutter sell-flow payout picker.
  Future<List<PayoutMethodEntity>> getPayoutMethods();

  Future<GiftCardSaleModel> sellGiftCard({
    required String cardType,
    required String cardNumber,
    required String cardPin,
    required double denomination,
    required String transactionId,
    required String verificationToken,
    String? payoutMethod,
    String? form,
    String? subcategoryId,
    String? cardCode,
    bool disclaimerAccepted = false,
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

  Future<GiftCardSaleModel> getSellStatus(String saleId);

  Future<List<GiftCardSaleModel>> getMySales({
    String? status,
    int limit,
    int offset,
  });

  Future<Map<String, String>> uploadSellImage({
    required String imageData,
    required String contentType,
    required String filename,
  });

  Future<Map<String, dynamic>> extractCardDetails({
    required List<String> imageUrls,
  });

  // Settlement and provider management methods (admin only)
  Future<Map<String, dynamic>> getActiveSellProvider();
  Future<Map<String, dynamic>?> retrySettlement(String saleId);
  Future<Map<String, dynamic>?> exportSettlementHistory(String format);
  Future<List<Settlement>> getSettlementHistory();
}
