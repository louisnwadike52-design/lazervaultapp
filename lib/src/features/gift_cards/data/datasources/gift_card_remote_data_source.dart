import '../models/gift_card_model.dart';
import '../../domain/entities/gift_card_entity.dart';

abstract class IGiftCardRemoteDataSource {
  Future<List<GiftCardBrandModel>> getGiftCardBrands();
  Future<List<GiftCardBrandModel>> getGiftCardBrandsByCategory(GiftCardCategory category);
  Future<List<GiftCardBrandModel>> searchGiftCardBrands(String query);
  Future<GiftCardBrandModel> getGiftCardBrandById(String brandId);
  Future<GiftCardModel> purchaseGiftCard({
    required String brandId,
    required double amount,
    required String currency,
    String? recipientEmail,
    String? recipientName,
    String? message,
  });
  Future<List<GiftCardModel>> getUserGiftCards();
  Future<GiftCardModel> getGiftCardById(String giftCardId);
  Future<GiftCardModel> redeemGiftCard(String giftCardId, String code);
  Future<List<GiftCardTransactionModel>> getGiftCardTransactions();
  Future<GiftCardTransactionModel> getTransactionById(String transactionId);
  Future<GiftCardModel> sendGiftCard({
    required String giftCardId,
    required String recipientEmail,
    String? message,
  });
  Future<bool> validateGiftCardCode(String code);
  Future<double> getGiftCardBalance(String giftCardId);
  Future<GiftCardModel> sellGiftCard({
    required String giftCardId,
    required double sellingPrice,
  });
  Future<List<GiftCardModel>> getResellableGiftCards();
}

class GiftCardRemoteDataSourceImpl implements IGiftCardRemoteDataSource {
  // Mock data for demonstration
  static const List<GiftCardBrandModel> _mockBrands = [
    GiftCardBrandModel(
      id: '1',
      name: 'Amazon',
      logoUrl: 'https://example.com/amazon-logo.png',
      description: 'Shop everything on Amazon',
      category: GiftCardCategory.shopping,
      discountPercentage: 5.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: '2',
      name: 'Netflix',
      logoUrl: 'https://example.com/netflix-logo.png',
      description: 'Stream movies and TV shows',
      category: GiftCardCategory.entertainment,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: '3',
      name: 'Starbucks',
      logoUrl: 'https://example.com/starbucks-logo.png',
      description: 'Coffee and more',
      category: GiftCardCategory.dining,
      discountPercentage: 2.0,
      isPopular: false,
    ),
    GiftCardBrandModel(
      id: '4',
      name: 'Steam',
      logoUrl: 'https://example.com/steam-logo.png',
      description: 'Gaming platform',
      category: GiftCardCategory.gaming,
      discountPercentage: 3.0,
      isPopular: true,
    ),
  ];

  @override
  Future<List<GiftCardBrandModel>> getGiftCardBrands() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return _mockBrands;
  }

  @override
  Future<List<GiftCardBrandModel>> getGiftCardBrandsByCategory(GiftCardCategory category) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockBrands.where((brand) => brand.category == category).toList();
  }

  @override
  Future<List<GiftCardBrandModel>> searchGiftCardBrands(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockBrands
        .where((brand) => brand.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<GiftCardBrandModel> getGiftCardBrandById(String brandId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockBrands.firstWhere((brand) => brand.id == brandId);
  }

  @override
  Future<GiftCardModel> purchaseGiftCard({
    required String brandId,
    required double amount,
    required String currency,
    String? recipientEmail,
    String? recipientName,
    String? message,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    
    final brand = _mockBrands.firstWhere((b) => b.id == brandId);
    final discountAmount = amount * ((brand.discountPercentage ?? 0) / 100);
    final finalPrice = amount - discountAmount;
    
    return GiftCardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      brandId: brand.id,
      brandName: brand.name,
      logoUrl: brand.logoUrl,
      amount: amount,
      discountPercentage: brand.discountPercentage ?? 0,
      finalPrice: finalPrice,
      currency: currency,
      status: GiftCardStatus.active,
      type: GiftCardType.digital,
      category: brand.category,
      description: brand.description,
      termsAndConditions: 'Standard terms and conditions apply',
      expiryDate: DateTime.now().add(const Duration(days: 365)),
      purchaseDate: DateTime.now(),
      recipientEmail: recipientEmail,
      recipientName: recipientName,
      message: message,
      code: 'GC${DateTime.now().millisecondsSinceEpoch}',
      pin: '1234',
      isRedeemed: false,
      transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
      availableDenominations: ['25', '50', '100'],
      qrCodeUrl: 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=GC${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  Future<List<GiftCardModel>> getUserGiftCards() async {
    await Future.delayed(const Duration(seconds: 1));
    // Return some mock gift cards
    return [
      GiftCardModel(
        id: '1',
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 50.0,
        discountPercentage: 5.0,
        finalPrice: 47.5,
        currency: 'USD',
        status: GiftCardStatus.active,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card',
        termsAndConditions: 'Terms apply',
        expiryDate: DateTime.now().add(const Duration(days: 300)),
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        isRedeemed: false,
        code: 'AMZN123456',
        availableDenominations: ['25', '50', '100'],
      ),
    ];
  }

  @override
  Future<GiftCardModel> getGiftCardById(String giftCardId) async {
    await Future.delayed(const Duration(seconds: 1));
    final giftCards = await getUserGiftCards();
    return giftCards.firstWhere((gc) => gc.id == giftCardId);
  }

  @override
  Future<GiftCardModel> redeemGiftCard(String giftCardId, String code) async {
    await Future.delayed(const Duration(seconds: 2));
    final giftCard = await getGiftCardById(giftCardId);
    return GiftCardModel(
      id: giftCard.id,
      brandId: giftCard.brandId,
      brandName: giftCard.brandName,
      logoUrl: giftCard.logoUrl,
      amount: giftCard.amount,
      discountPercentage: giftCard.discountPercentage,
      finalPrice: giftCard.finalPrice,
      currency: giftCard.currency,
      status: GiftCardStatus.used,
      type: giftCard.type,
      category: giftCard.category,
      description: giftCard.description,
      termsAndConditions: giftCard.termsAndConditions,
      expiryDate: giftCard.expiryDate,
      purchaseDate: giftCard.purchaseDate,
      recipientEmail: giftCard.recipientEmail,
      recipientName: giftCard.recipientName,
      message: giftCard.message,
      code: giftCard.code,
      pin: giftCard.pin,
      isRedeemed: true,
      transactionId: giftCard.transactionId,
      availableDenominations: giftCard.availableDenominations,
      qrCodeUrl: giftCard.qrCodeUrl,
      barcodeUrl: giftCard.barcodeUrl,
      additionalInfo: giftCard.additionalInfo,
    );
  }

  @override
  Future<List<GiftCardTransactionModel>> getGiftCardTransactions() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      GiftCardTransactionModel(
        id: '1',
        giftCardId: '1',
        userId: 'user1',
        amount: 50.0,
        currency: 'USD',
        transactionDate: DateTime.now().subtract(const Duration(days: 30)),
        transactionType: 'purchase',
        status: GiftCardStatus.active,
      ),
    ];
  }

  @override
  Future<GiftCardTransactionModel> getTransactionById(String transactionId) async {
    await Future.delayed(const Duration(seconds: 1));
    final transactions = await getGiftCardTransactions();
    return transactions.firstWhere((t) => t.id == transactionId);
  }

  @override
  Future<GiftCardModel> sendGiftCard({
    required String giftCardId,
    required String recipientEmail,
    String? message,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final giftCard = await getGiftCardById(giftCardId);
    return GiftCardModel(
      id: giftCard.id,
      brandId: giftCard.brandId,
      brandName: giftCard.brandName,
      logoUrl: giftCard.logoUrl,
      amount: giftCard.amount,
      discountPercentage: giftCard.discountPercentage,
      finalPrice: giftCard.finalPrice,
      currency: giftCard.currency,
      status: giftCard.status,
      type: giftCard.type,
      category: giftCard.category,
      description: giftCard.description,
      termsAndConditions: giftCard.termsAndConditions,
      expiryDate: giftCard.expiryDate,
      purchaseDate: giftCard.purchaseDate,
      recipientEmail: recipientEmail,
      recipientName: giftCard.recipientName,
      message: message ?? giftCard.message,
      code: giftCard.code,
      pin: giftCard.pin,
      isRedeemed: giftCard.isRedeemed,
      transactionId: giftCard.transactionId,
      availableDenominations: giftCard.availableDenominations,
      qrCodeUrl: giftCard.qrCodeUrl,
      barcodeUrl: giftCard.barcodeUrl,
      additionalInfo: giftCard.additionalInfo,
    );
  }

  @override
  Future<bool> validateGiftCardCode(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    return code.isNotEmpty && code.length >= 6;
  }

  @override
  Future<double> getGiftCardBalance(String giftCardId) async {
    await Future.delayed(const Duration(seconds: 1));
    final giftCard = await getGiftCardById(giftCardId);
    return giftCard.isRedeemed ? 0.0 : giftCard.amount;
  }

  @override
  Future<GiftCardModel> sellGiftCard({
    required String giftCardId,
    required double sellingPrice,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final giftCard = await getGiftCardById(giftCardId);
    return GiftCardModel(
      id: giftCard.id,
      brandId: giftCard.brandId,
      brandName: giftCard.brandName,
      logoUrl: giftCard.logoUrl,
      amount: giftCard.amount,
      discountPercentage: giftCard.discountPercentage,
      finalPrice: sellingPrice,
      currency: giftCard.currency,
      status: GiftCardStatus.pending,
      type: giftCard.type,
      category: giftCard.category,
      description: giftCard.description,
      termsAndConditions: giftCard.termsAndConditions,
      expiryDate: giftCard.expiryDate,
      purchaseDate: giftCard.purchaseDate,
      recipientEmail: giftCard.recipientEmail,
      recipientName: giftCard.recipientName,
      message: giftCard.message,
      code: giftCard.code,
      pin: giftCard.pin,
      isRedeemed: giftCard.isRedeemed,
      transactionId: 'SELL${DateTime.now().millisecondsSinceEpoch}',
      availableDenominations: giftCard.availableDenominations,
      qrCodeUrl: giftCard.qrCodeUrl,
      barcodeUrl: giftCard.barcodeUrl,
      additionalInfo: giftCard.additionalInfo,
    );
  }

  @override
  Future<List<GiftCardModel>> getResellableGiftCards() async {
    await Future.delayed(const Duration(seconds: 1));
    final userGiftCards = await getUserGiftCards();
    return userGiftCards.where((gc) => !gc.isRedeemed && gc.status == GiftCardStatus.active).toList();
  }
} 