import '../../domain/entities/sell_card_entry.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../models/gift_card_model.dart';

abstract class IGiftCardRemoteDataSource {
  /// Re-reads ONE brand live from the ACTIVE buy provider.
  ///
  /// The catalogue is a cached, shared page; this is not. It returns only the
  /// denominations that provider will sell right now, which is what the
  /// amounts screen must offer.
  Future<GiftCardBrandLiveResult> getGiftCardBrandLive({
    required String productRef,
    String? countryCode,
    String? providerName,
  });

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
    bool pinProvider = false,
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
    bool balanceAttested = false,
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
    List<SellCardEntry>? cards,
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

  // Active sell-provider resolution (drives the sell-flow provider display).
  Future<Map<String, dynamic>> getActiveSellProvider();
}
