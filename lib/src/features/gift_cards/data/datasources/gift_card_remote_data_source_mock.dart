import 'dart:math';
import '../models/gift_card_model.dart';
import '../../domain/entities/gift_card_entity.dart';
import 'gift_card_remote_data_source.dart';

/// Mock implementation of the gift card remote data source for development/testing
class GiftCardRemoteDataSourceMock implements IGiftCardRemoteDataSource {
  final Random _random = Random();
  final List<GiftCardModel> _userGiftCards = [];
  final List<GiftCardTransactionModel> _transactions = [];

  final double failureRate;
  double _walletBalance = 500000.0; // 500k kobo / NGN

  GiftCardRemoteDataSourceMock({this.failureRate = 0.1});

  Future<void> _simulateNetworkDelay() async {
    final delay = 500 + _random.nextInt(1500);
    await Future.delayed(Duration(milliseconds: delay));
  }

  void _simulateRandomFailure() {
    if (_random.nextDouble() < failureRate) {
      throw Exception('Network error: Connection timeout');
    }
  }

  @override
  Future<List<GiftCardBrandModel>> getGiftCardBrands({
    String? category,
    String? countryCode,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    var brands = List<GiftCardBrandModel>.from(_mockBrands);
    if (category != null && category.isNotEmpty) {
      brands = brands.where((b) => b.category == category).toList();
    }
    if (countryCode != null && countryCode.isNotEmpty) {
      brands = brands.where((b) => b.countryCode == countryCode || b.countryCode.isEmpty).toList();
    }
    return brands;
  }

  @override
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
    int quantity = 1,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final brand = _mockBrands.firstWhere(
      (b) => b.id == brandId,
      orElse: () => throw Exception('Gift card brand not found'),
    );

    final discount = brand.discountPercentage;
    final finalPrice = amount - (amount * discount / 100);

    if (_walletBalance < finalPrice) {
      throw Exception('Insufficient funds for purchase');
    }

    _walletBalance -= finalPrice;

    final giftCard = GiftCardModel(
      id: 'gc_${DateTime.now().millisecondsSinceEpoch}',
      brandId: brandId,
      brandName: brand.name,
      logoUrl: brand.logoUrl,
      originalAmount: amount,
      currentBalance: amount,
      currency: brand.currencyCode.isNotEmpty ? brand.currencyCode : 'NGN',
      status: 'active',
      purchaseDate: DateTime.now().toIso8601String(),
      expiryDate: DateTime.now().add(const Duration(days: 365)).toIso8601String(),
      recipientEmail: recipientEmail,
      recipientName: recipientName,
      message: giftMessage,
      redemptionCode: _generateCode(),
      redemptionPin: _generatePin(),
      providerTransactionId: 'mock_txn_${DateTime.now().millisecondsSinceEpoch}',
      countryCode: countryCode ?? brand.countryCode,
      providerProductId: productId ?? brand.productId,
      discountPercentage: discount,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    _userGiftCards.add(giftCard);

    final transaction = GiftCardTransactionModel(
      id: transactionId,
      giftCardId: giftCard.id,
      userId: 'mock_user',
      transactionType: 'purchase',
      amount: finalPrice,
      balanceBefore: _walletBalance + finalPrice,
      balanceAfter: _walletBalance,
      description: 'Purchased ${brand.name} gift card',
      createdAt: DateTime.now().toIso8601String(),
      providerTransactionId: giftCard.providerTransactionId ?? '',
      reference: 'GC-$transactionId',
    );
    _transactions.add(transaction);

    return giftCard;
  }

  @override
  Future<List<GiftCardModel>> getUserGiftCards({
    String? status,
    String? brandId,
    int limit = 50,
    int offset = 0,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    var cards = List<GiftCardModel>.from(_userGiftCards);
    if (status != null && status.isNotEmpty) {
      cards = cards.where((c) => c.status == status).toList();
    }
    if (brandId != null && brandId.isNotEmpty) {
      cards = cards.where((c) => c.brandId == brandId).toList();
    }
    return cards.skip(offset).take(limit).toList();
  }

  @override
  Future<GiftCardModel> getGiftCardById(String giftCardId) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    try {
      return _userGiftCards.firstWhere((card) => card.id == giftCardId);
    } catch (e) {
      throw Exception('Gift card not found');
    }
  }

  @override
  Future<List<GiftCardTransactionModel>> getGiftCardHistory({
    String? giftCardId,
    String? transactionType,
    int limit = 50,
    int offset = 0,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    var txns = List<GiftCardTransactionModel>.from(_transactions.reversed);
    if (giftCardId != null && giftCardId.isNotEmpty) {
      txns = txns.where((t) => t.giftCardId == giftCardId).toList();
    }
    if (transactionType != null && transactionType.isNotEmpty) {
      txns = txns.where((t) => t.transactionType == transactionType).toList();
    }
    return txns.skip(offset).take(limit).toList();
  }

  // Helper methods
  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(16, (index) => chars[_random.nextInt(chars.length)]).join();
  }

  String _generatePin() {
    return List.generate(4, (index) => _random.nextInt(10).toString()).join();
  }

  // Sell flow mock methods

  final List<GiftCardSaleModel> _userSales = [];

  @override
  Future<List<SellableCardModel>> getSellableCards() async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();
    return _mockSellableCards;
  }

  @override
  Future<SellRateModel> getSellRate({
    required String cardType,
    required double denomination,
    String? currency,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final rates = <String, double>{
      'amazon': 88.0,
      'itunes': 85.0,
      'google_play': 82.0,
      'steam': 80.0,
      'walmart': 87.0,
    };

    final rate = rates[cardType] ?? 75.0;
    final payoutAmount = denomination * rate / 100 * 1600; // approx NGN conversion

    return SellRateModel(
      cardType: cardType,
      denomination: denomination,
      ratePercentage: rate,
      payoutAmount: payoutAmount,
      currency: 'NGN',
      expiresAt: DateTime.now().add(const Duration(minutes: 5)).toIso8601String(),
    );
  }

  @override
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
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final rates = <String, double>{
      'amazon': 88.0,
      'itunes': 85.0,
      'google_play': 82.0,
      'steam': 80.0,
      'walmart': 87.0,
    };

    final rate = rates[cardType] ?? 75.0;
    final expectedPayout = denomination * rate / 100 * 1600;

    final sale = GiftCardSaleModel(
      id: 'sale_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'mock_user',
      cardType: cardType,
      cardNumber: cardNumber,
      denomination: denomination,
      currency: currency ?? 'USD',
      ratePercentage: rate,
      expectedPayout: expectedPayout,
      status: 'pending',
      reference: 'SELL-$transactionId',
      submittedAt: DateTime.now().toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    _userSales.add(sale);
    return sale;
  }

  @override
  Future<GiftCardSaleModel> getSellStatus(String saleId) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    try {
      return _userSales.firstWhere((s) => s.id == saleId);
    } catch (e) {
      throw Exception('Sale not found');
    }
  }

  @override
  Future<GiftCardModel> redeemGiftCard({
    required String accountId,
    required String cardNumber,
    required String cardPin,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    // Find a card matching the code, or create a mock redeemed card
    final card = GiftCardModel(
      id: 'gc_redeem_${DateTime.now().millisecondsSinceEpoch}',
      brandId: 'amazon',
      brandName: 'Amazon',
      logoUrl: 'https://logo.clearbit.com/amazon.com',
      originalAmount: 10000,
      currentBalance: 10000,
      currency: 'NGN',
      status: 'active',
      purchaseDate: DateTime.now().toIso8601String(),
      expiryDate: DateTime.now().add(const Duration(days: 365)).toIso8601String(),
      redemptionCode: cardNumber,
      redemptionPin: cardPin,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    _userGiftCards.add(card);
    return card;
  }

  @override
  Future<GiftCardModel> transferGiftCard({
    required String giftCardId,
    required String recipientEmail,
    required String recipientName,
    required String message,
    required String transactionId,
    required String verificationToken,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    try {
      final card = _userGiftCards.firstWhere((c) => c.id == giftCardId);
      final transferred = GiftCardModel(
        id: card.id,
        brandId: card.brandId,
        brandName: card.brandName,
        logoUrl: card.logoUrl,
        originalAmount: card.originalAmount,
        currentBalance: card.currentBalance,
        currency: card.currency,
        status: 'transferred',
        purchaseDate: card.purchaseDate,
        expiryDate: card.expiryDate,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
        redemptionCode: card.redemptionCode,
        redemptionPin: card.redemptionPin,
        createdAt: card.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
      );
      return transferred;
    } catch (e) {
      throw Exception('Gift card not found');
    }
  }

  @override
  Future<GiftCardBalanceModel> getGiftCardBalance({
    required String cardNumber,
    required String cardPin,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    return GiftCardBalanceModel(
      balance: 10000 + _random.nextInt(40000).toDouble(),
      brandName: 'Amazon',
      expiryDate: DateTime.now().add(const Duration(days: 180)).toIso8601String(),
      status: 'active',
    );
  }

  @override
  Future<List<GiftCardSaleModel>> getMySales({
    String? status,
    int limit = 50,
    int offset = 0,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    var sales = List<GiftCardSaleModel>.from(_userSales.reversed);
    if (status != null && status.isNotEmpty) {
      sales = sales.where((s) => s.status == status).toList();
    }
    return sales.skip(offset).take(limit).toList();
  }

  static final List<SellableCardModel> _mockSellableCards = const [
    SellableCardModel(
      cardType: 'amazon',
      displayName: 'Amazon',
      logoUrl: 'https://logo.clearbit.com/amazon.com',
      category: 'shopping',
      denominations: [25, 50, 100, 200],
      currencies: ['USD', 'GBP', 'EUR'],
      minDenomination: 25,
      maxDenomination: 200,
    ),
    SellableCardModel(
      cardType: 'itunes',
      displayName: 'iTunes / Apple',
      logoUrl: 'https://logo.clearbit.com/apple.com',
      category: 'entertainment',
      denominations: [25, 50, 100],
      currencies: ['USD', 'GBP'],
      minDenomination: 25,
      maxDenomination: 100,
    ),
    SellableCardModel(
      cardType: 'google_play',
      displayName: 'Google Play',
      logoUrl: 'https://logo.clearbit.com/play.google.com',
      category: 'entertainment',
      denominations: [25, 50, 100],
      currencies: ['USD'],
      minDenomination: 25,
      maxDenomination: 100,
    ),
    SellableCardModel(
      cardType: 'steam',
      displayName: 'Steam',
      logoUrl: 'https://logo.clearbit.com/steampowered.com',
      category: 'gaming',
      denominations: [20, 50, 100],
      currencies: ['USD'],
      minDenomination: 20,
      maxDenomination: 100,
    ),
    SellableCardModel(
      cardType: 'walmart',
      displayName: 'Walmart',
      logoUrl: 'https://logo.clearbit.com/walmart.com',
      category: 'shopping',
      denominations: [25, 50, 100, 200],
      currencies: ['USD'],
      minDenomination: 25,
      maxDenomination: 200,
    ),
  ];

  // Mock brand data
  static final List<GiftCardBrandModel> _mockBrands = [
    const GiftCardBrandModel(
      id: 'amazon',
      name: 'Amazon',
      logoUrl: 'https://logo.clearbit.com/amazon.com',
      description: 'Shop millions of products online',
      category: 'shopping',
      discountPercentage: 5.0,
      currencyCode: 'NGN',
      productId: 1001,
      fixedDenominations: [
        GiftCardDenomination(price: 5000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 10000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 25000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 50000, currencyCode: 'NGN'),
      ],
    ),
    const GiftCardBrandModel(
      id: 'netflix',
      name: 'Netflix',
      logoUrl: 'https://logo.clearbit.com/netflix.com',
      description: 'Unlimited movies and TV shows',
      category: 'entertainment',
      discountPercentage: 0.0,
      currencyCode: 'NGN',
      productId: 1002,
      fixedDenominations: [
        GiftCardDenomination(price: 5000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 10000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 15000, currencyCode: 'NGN'),
      ],
    ),
    const GiftCardBrandModel(
      id: 'steam',
      name: 'Steam',
      logoUrl: 'https://logo.clearbit.com/steampowered.com',
      description: 'The ultimate gaming platform',
      category: 'gaming',
      discountPercentage: 0.0,
      currencyCode: 'NGN',
      productId: 1003,
      fixedDenominations: [
        GiftCardDenomination(price: 5000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 10000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 20000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 50000, currencyCode: 'NGN'),
      ],
    ),
    const GiftCardBrandModel(
      id: 'spotify',
      name: 'Spotify',
      logoUrl: 'https://logo.clearbit.com/spotify.com',
      description: 'Millions of songs and podcasts',
      category: 'entertainment',
      discountPercentage: 0.0,
      currencyCode: 'NGN',
      productId: 1004,
      fixedDenominations: [
        GiftCardDenomination(price: 3000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 5000, currencyCode: 'NGN'),
      ],
    ),
    const GiftCardBrandModel(
      id: 'uber',
      name: 'Uber',
      logoUrl: 'https://logo.clearbit.com/uber.com',
      description: 'Request a ride, 24/7',
      category: 'travel',
      discountPercentage: 2.0,
      currencyCode: 'NGN',
      productId: 1005,
      minAmount: 1000,
      maxAmount: 100000,
    ),
    const GiftCardBrandModel(
      id: 'googleplay',
      name: 'Google Play',
      logoUrl: 'https://logo.clearbit.com/play.google.com',
      description: 'Apps, games, movies, music & books',
      category: 'other',
      discountPercentage: 0.0,
      currencyCode: 'NGN',
      productId: 1006,
      fixedDenominations: [
        GiftCardDenomination(price: 2000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 5000, currencyCode: 'NGN'),
        GiftCardDenomination(price: 10000, currencyCode: 'NGN'),
      ],
    ),
  ];
}
