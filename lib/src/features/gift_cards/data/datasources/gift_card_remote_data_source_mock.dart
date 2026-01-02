import 'dart:math';
import '../models/gift_card_model.dart';
import '../../domain/entities/gift_card_entity.dart';
import 'gift_card_remote_data_source.dart';

/// Enhanced mock implementation with realistic network delays and edge cases
class GiftCardRemoteDataSourceMock implements IGiftCardRemoteDataSource {
  final Random _random = Random();
  final List<GiftCardModel> _userGiftCards = [];
  final List<GiftCardTransactionModel> _transactions = [];

  // Configurable failure rate (default 10%)
  final double failureRate;

  // Simulated wallet balance
  double _walletBalance = 5000.0;

  GiftCardRemoteDataSourceMock({this.failureRate = 0.1});

  /// Simulate network delay
  Future<void> _simulateNetworkDelay() async {
    final delay = 500 + _random.nextInt(1500); // 500-2000ms
    await Future.delayed(Duration(milliseconds: delay));
  }

  /// Simulate random network failure
  void _simulateRandomFailure() {
    if (_random.nextDouble() < failureRate) {
      throw Exception('Network error: Connection timeout');
    }
  }

  @override
  Future<List<GiftCardBrandModel>> getGiftCardBrands() async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    return _mockBrands;
  }

  @override
  Future<List<GiftCardBrandModel>> getGiftCardBrandsByCategory(
    GiftCardCategory category,
  ) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    return _mockBrands.where((brand) => brand.category == category).toList();
  }

  @override
  Future<List<GiftCardBrandModel>> searchGiftCardBrands(String query) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final lowerQuery = query.toLowerCase();
    return _mockBrands
        .where((brand) =>
            brand.name.toLowerCase().contains(lowerQuery) ||
            brand.description.toLowerCase().contains(lowerQuery))
        .toList();
  }

  @override
  Future<GiftCardBrandModel> getGiftCardBrandById(String brandId) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    try {
      return _mockBrands.firstWhere((brand) => brand.id == brandId);
    } catch (e) {
      throw Exception('Gift card brand not found');
    }
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
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    // Find brand
    final brand = _mockBrands.firstWhere(
      (b) => b.id == brandId,
      orElse: () => throw Exception('Gift card brand not found'),
    );

    // Calculate final price with discount
    final discount = brand.discountPercentage ?? 0.0;
    final finalPrice = amount - (amount * discount / 100);

    // Check wallet balance
    if (_walletBalance < finalPrice) {
      throw Exception('Insufficient funds for purchase');
    }

    // Deduct from wallet
    _walletBalance -= finalPrice;

    // Create gift card
    final giftCard = GiftCardModel(
      id: 'gc_${DateTime.now().millisecondsSinceEpoch}',
      brandId: brandId,
      brandName: brand.name,
      logoUrl: brand.logoUrl,
      amount: amount,
      discountPercentage: discount,
      finalPrice: finalPrice,
      currency: currency,
      status: GiftCardStatus.active,
      type: GiftCardType.digital,
      category: brand.category,
      description: brand.description,
      termsAndConditions: 'Valid for 12 months from purchase date',
      expiryDate: DateTime.now().add(const Duration(days: 365)),
      purchaseDate: DateTime.now(),
      recipientEmail: recipientEmail,
      recipientName: recipientName,
      message: message,
      code: _generateCode(),
      pin: _generatePin(),
      isRedeemed: false,
      transactionId: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      availableDenominations: ['50', '100', '200', '500'],
      qrCodeUrl: 'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=${_generateCode()}',
      barcodeUrl: null,
      additionalInfo: null,
    );

    _userGiftCards.add(giftCard);

    // Create transaction
    final transaction = GiftCardTransactionModel(
      id: giftCard.transactionId!,
      giftCardId: giftCard.id,
      userId: 'user123',
      amount: finalPrice,
      currency: currency,
      transactionDate: DateTime.now(),
      transactionType: 'purchase',
      status: GiftCardStatus.active,
      failureReason: null,
      additionalDetails: null,
    );

    _transactions.add(transaction);

    return giftCard;
  }

  @override
  Future<List<GiftCardModel>> getUserGiftCards() async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    return List.from(_userGiftCards);
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
  Future<GiftCardModel> redeemGiftCard(String giftCardId, String code) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final card = _userGiftCards.firstWhere(
      (c) => c.id == giftCardId,
      orElse: () => throw Exception('Gift card not found'),
    );

    // Validate code
    if (card.code != code) {
      throw Exception('Invalid gift card code');
    }

    // Check if already redeemed
    if (card.isRedeemed) {
      throw Exception('Gift card already redeemed or expired');
    }

    // Check if expired
    if (card.expiryDate.isBefore(DateTime.now())) {
      throw Exception('Gift card already redeemed or expired');
    }

    // Update card status
    final index = _userGiftCards.indexOf(card);
    final updatedCard = GiftCardModel(
      id: card.id,
      brandId: card.brandId,
      brandName: card.brandName,
      logoUrl: card.logoUrl,
      amount: card.amount,
      discountPercentage: card.discountPercentage,
      finalPrice: card.finalPrice,
      currency: card.currency,
      status: GiftCardStatus.used,
      type: card.type,
      category: card.category,
      description: card.description,
      termsAndConditions: card.termsAndConditions,
      expiryDate: card.expiryDate,
      purchaseDate: card.purchaseDate,
      recipientEmail: card.recipientEmail,
      recipientName: card.recipientName,
      message: card.message,
      code: card.code,
      pin: card.pin,
      isRedeemed: true,
      transactionId: card.transactionId,
      availableDenominations: card.availableDenominations,
      qrCodeUrl: card.qrCodeUrl,
      barcodeUrl: card.barcodeUrl,
      additionalInfo: card.additionalInfo,
    );

    _userGiftCards[index] = updatedCard;

    // Create redemption transaction
    final transaction = GiftCardTransactionModel(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      giftCardId: giftCardId,
      userId: 'user123',
      amount: card.amount,
      currency: card.currency,
      transactionDate: DateTime.now(),
      transactionType: 'redeem',
      status: GiftCardStatus.used,
      failureReason: null,
      additionalDetails: null,
    );

    _transactions.add(transaction);

    return updatedCard;
  }

  @override
  Future<List<GiftCardTransactionModel>> getGiftCardTransactions() async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    return List.from(_transactions.reversed);
  }

  @override
  Future<GiftCardTransactionModel> getTransactionById(
    String transactionId,
  ) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    try {
      return _transactions.firstWhere((t) => t.id == transactionId);
    } catch (e) {
      throw Exception('Transaction not found');
    }
  }

  @override
  Future<GiftCardModel> sendGiftCard({
    required String giftCardId,
    required String recipientEmail,
    String? message,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final card = _userGiftCards.firstWhere(
      (c) => c.id == giftCardId,
      orElse: () => throw Exception('Gift card or recipient not found'),
    );

    final index = _userGiftCards.indexOf(card);
    final updatedCard = GiftCardModel(
      id: card.id,
      brandId: card.brandId,
      brandName: card.brandName,
      logoUrl: card.logoUrl,
      amount: card.amount,
      discountPercentage: card.discountPercentage,
      finalPrice: card.finalPrice,
      currency: card.currency,
      status: card.status,
      type: card.type,
      category: card.category,
      description: card.description,
      termsAndConditions: card.termsAndConditions,
      expiryDate: card.expiryDate,
      purchaseDate: card.purchaseDate,
      recipientEmail: recipientEmail,
      recipientName: card.recipientName,
      message: message,
      code: card.code,
      pin: card.pin,
      isRedeemed: card.isRedeemed,
      transactionId: card.transactionId,
      availableDenominations: card.availableDenominations,
      qrCodeUrl: card.qrCodeUrl,
      barcodeUrl: card.barcodeUrl,
      additionalInfo: card.additionalInfo,
    );

    _userGiftCards[index] = updatedCard;

    // Create transfer transaction
    final transaction = GiftCardTransactionModel(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      giftCardId: giftCardId,
      userId: 'user123',
      amount: card.amount,
      currency: card.currency,
      transactionDate: DateTime.now(),
      transactionType: 'transfer',
      status: card.status,
      failureReason: null,
      additionalDetails: null,
    );

    _transactions.add(transaction);

    return updatedCard;
  }

  @override
  Future<bool> validateGiftCardCode(String code) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final card = _userGiftCards.where((c) => c.code == code).firstOrNull;
    if (card == null) return false;

    return !card.isRedeemed && card.expiryDate.isAfter(DateTime.now());
  }

  @override
  Future<double> getGiftCardBalance(String giftCardId) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final card = _userGiftCards.firstWhere(
      (c) => c.id == giftCardId,
      orElse: () => throw Exception('Gift card not found'),
    );

    return card.isRedeemed ? 0.0 : card.amount;
  }

  @override
  Future<GiftCardModel> sellGiftCard({
    required String giftCardId,
    required double sellingPrice,
  }) async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    final card = _userGiftCards.firstWhere(
      (c) => c.id == giftCardId,
      orElse: () => throw Exception('Gift card not found'),
    );

    if (card.isRedeemed || card.expiryDate.isBefore(DateTime.now())) {
      throw Exception('Gift card cannot be sold (already used or expired)');
    }

    // Create sell transaction
    final transaction = GiftCardTransactionModel(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      giftCardId: giftCardId,
      userId: 'user123',
      amount: sellingPrice,
      currency: card.currency,
      transactionDate: DateTime.now(),
      transactionType: 'sell',
      status: GiftCardStatus.pending,
      failureReason: null,
      additionalDetails: null,
    );

    _transactions.add(transaction);

    return card;
  }

  @override
  Future<List<GiftCardModel>> getResellableGiftCards() async {
    await _simulateNetworkDelay();
    _simulateRandomFailure();

    // Return mock resellable cards (other users' cards)
    return _mockResellableCards;
  }

  // Helper methods
  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(16, (index) => chars[_random.nextInt(chars.length)])
        .join();
  }

  String _generatePin() {
    return List.generate(4, (index) => _random.nextInt(10).toString()).join();
  }

  // Mock data
  static final List<GiftCardBrandModel> _mockBrands = [
    // Shopping
    GiftCardBrandModel(
      id: 'amazon',
      name: 'Amazon',
      logoUrl: 'https://logo.clearbit.com/amazon.com',
      description: 'Shop millions of products online',
      category: GiftCardCategory.shopping,
      discountPercentage: 5.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'walmart',
      name: 'Walmart',
      logoUrl: 'https://logo.clearbit.com/walmart.com',
      description: 'Save money. Live better.',
      category: GiftCardCategory.shopping,
      discountPercentage: 3.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'target',
      name: 'Target',
      logoUrl: 'https://logo.clearbit.com/target.com',
      description: 'Expect more. Pay less.',
      category: GiftCardCategory.shopping,
      discountPercentage: 4.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'bestbuy',
      name: 'Best Buy',
      logoUrl: 'https://logo.clearbit.com/bestbuy.com',
      description: 'Electronics, computers, appliances & more',
      category: GiftCardCategory.shopping,
      discountPercentage: 2.5,
      isPopular: false,
    ),
    GiftCardBrandModel(
      id: 'ebay',
      name: 'eBay',
      logoUrl: 'https://logo.clearbit.com/ebay.com',
      description: 'Buy & sell electronics, fashion & more',
      category: GiftCardCategory.shopping,
      discountPercentage: 3.5,
      isPopular: false,
    ),

    // Entertainment
    GiftCardBrandModel(
      id: 'netflix',
      name: 'Netflix',
      logoUrl: 'https://logo.clearbit.com/netflix.com',
      description: 'Unlimited movies and TV shows',
      category: GiftCardCategory.entertainment,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'spotify',
      name: 'Spotify',
      logoUrl: 'https://logo.clearbit.com/spotify.com',
      description: 'Millions of songs and podcasts',
      category: GiftCardCategory.entertainment,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'hulu',
      name: 'Hulu',
      logoUrl: 'https://logo.clearbit.com/hulu.com',
      description: 'Stream TV shows and movies',
      category: GiftCardCategory.entertainment,
      discountPercentage: 0.0,
      isPopular: false,
    ),
    GiftCardBrandModel(
      id: 'disney',
      name: 'Disney+',
      logoUrl: 'https://logo.clearbit.com/disneyplus.com',
      description: 'Stream Disney, Pixar, Marvel & more',
      category: GiftCardCategory.entertainment,
      discountPercentage: 0.0,
      isPopular: true,
    ),

    // Dining
    GiftCardBrandModel(
      id: 'starbucks',
      name: 'Starbucks',
      logoUrl: 'https://logo.clearbit.com/starbucks.com',
      description: 'Coffee, tea, and delicious treats',
      category: GiftCardCategory.dining,
      discountPercentage: 2.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'mcdonalds',
      name: "McDonald's",
      logoUrl: 'https://logo.clearbit.com/mcdonalds.com',
      description: "I'm lovin' it",
      category: GiftCardCategory.dining,
      discountPercentage: 1.5,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'dominos',
      name: "Domino's Pizza",
      logoUrl: 'https://logo.clearbit.com/dominos.com',
      description: 'Pizza delivery & carryout',
      category: GiftCardCategory.dining,
      discountPercentage: 3.0,
      isPopular: false,
    ),
    GiftCardBrandModel(
      id: 'subway',
      name: 'Subway',
      logoUrl: 'https://logo.clearbit.com/subway.com',
      description: 'Eat fresh',
      category: GiftCardCategory.dining,
      discountPercentage: 2.5,
      isPopular: false,
    ),

    // Travel
    GiftCardBrandModel(
      id: 'airbnb',
      name: 'Airbnb',
      logoUrl: 'https://logo.clearbit.com/airbnb.com',
      description: 'Book unique places to stay and things to do',
      category: GiftCardCategory.travel,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'uber',
      name: 'Uber',
      logoUrl: 'https://logo.clearbit.com/uber.com',
      description: 'Request a ride, 24/7',
      category: GiftCardCategory.travel,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'southwest',
      name: 'Southwest Airlines',
      logoUrl: 'https://logo.clearbit.com/southwest.com',
      description: 'Low fares, no hidden fees',
      category: GiftCardCategory.travel,
      discountPercentage: 0.0,
      isPopular: false,
    ),

    // Gaming
    GiftCardBrandModel(
      id: 'steam',
      name: 'Steam',
      logoUrl: 'https://logo.clearbit.com/steampowered.com',
      description: 'The ultimate gaming platform',
      category: GiftCardCategory.gaming,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'playstation',
      name: 'PlayStation Store',
      logoUrl: 'https://logo.clearbit.com/playstation.com',
      description: 'Download the latest games',
      category: GiftCardCategory.gaming,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'xbox',
      name: 'Xbox',
      logoUrl: 'https://logo.clearbit.com/xbox.com',
      description: 'Power your dreams',
      category: GiftCardCategory.gaming,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'nintendo',
      name: 'Nintendo eShop',
      logoUrl: 'https://logo.clearbit.com/nintendo.com',
      description: 'Download games for Nintendo Switch',
      category: GiftCardCategory.gaming,
      discountPercentage: 0.0,
      isPopular: false,
    ),

    // Other
    GiftCardBrandModel(
      id: 'appstore',
      name: 'Apple App Store & iTunes',
      logoUrl: 'https://logo.clearbit.com/apple.com',
      description: 'Apps, games, music, movies & more',
      category: GiftCardCategory.other,
      discountPercentage: 0.0,
      isPopular: true,
    ),
    GiftCardBrandModel(
      id: 'googleplay',
      name: 'Google Play',
      logoUrl: 'https://logo.clearbit.com/play.google.com',
      description: 'Apps, games, movies, music & books',
      category: GiftCardCategory.other,
      discountPercentage: 0.0,
      isPopular: true,
    ),
  ];

  static final List<GiftCardModel> _mockResellableCards = [
    GiftCardModel(
      id: 'resell_1',
      brandId: 'amazon',
      brandName: 'Amazon',
      logoUrl: 'https://logo.clearbit.com/amazon.com',
      amount: 50.0,
      discountPercentage: 10.0,
      finalPrice: 45.0,
      currency: 'USD',
      status: GiftCardStatus.active,
      type: GiftCardType.digital,
      category: GiftCardCategory.shopping,
      description: 'Shop millions of products online',
      termsAndConditions: 'Valid for 12 months',
      expiryDate: DateTime.now().add(const Duration(days: 180)),
      purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
      recipientEmail: null,
      recipientName: null,
      message: null,
      code: null,
      pin: null,
      isRedeemed: false,
      transactionId: null,
      availableDenominations: ['50', '100', '200'],
      qrCodeUrl: null,
      barcodeUrl: null,
      additionalInfo: null,
    ),
  ];
}
