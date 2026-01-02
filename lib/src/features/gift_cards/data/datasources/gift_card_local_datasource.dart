import 'package:hive_flutter/hive_flutter.dart';
import '../models/gift_card_hive_model.dart';
import '../models/gift_card_brand_hive_model.dart';
import '../models/gift_card_transaction_hive_model.dart';
import '../models/gift_card_model.dart';

/// Local data source interface for gift card caching
abstract class IGiftCardLocalDataSource {
  /// Initialize Hive boxes and register adapters
  Future<void> initialize();

  /// Get cached gift card brands
  Future<List<GiftCardBrandModel>> getCachedBrands();

  /// Cache gift card brands
  Future<void> cacheBrands(List<GiftCardBrandModel> brands);

  /// Get user's gift cards from cache
  Future<List<GiftCardModel>> getUserGiftCards(String userId);

  /// Save or update a gift card in cache
  Future<void> saveGiftCard(GiftCardModel giftCard);

  /// Get a single gift card by ID from cache
  Future<GiftCardModel?> getGiftCardById(String giftCardId);

  /// Delete a gift card from cache
  Future<void> deleteGiftCard(String giftCardId);

  /// Get cached transactions
  Future<List<GiftCardTransactionModel>> getTransactions(String userId);

  /// Save a transaction to cache
  Future<void> saveTransaction(GiftCardTransactionModel transaction);

  /// Clear all cached data
  Future<void> clearAllCache();

  /// Clear expired cache entries
  Future<void> clearExpiredCache();
}

/// Implementation of local data source using Hive
class GiftCardLocalDataSourceImpl implements IGiftCardLocalDataSource {
  static const String _brandsBoxName = 'gift_card_brands';
  static const String _cardsBoxName = 'gift_cards';
  static const String _transactionsBoxName = 'gift_card_transactions';

  Box<GiftCardBrandHiveModel>? _brandsBox;
  Box<GiftCardHiveModel>? _cardsBox;
  Box<GiftCardTransactionHiveModel>? _transactionsBox;

  @override
  Future<void> initialize() async {
    try {
      // Initialize Hive
      await Hive.initFlutter();

      // Register adapters if not already registered
      if (!Hive.isAdapterRegistered(30)) {
        Hive.registerAdapter(GiftCardHiveModelAdapter());
      }
      if (!Hive.isAdapterRegistered(31)) {
        Hive.registerAdapter(GiftCardBrandHiveModelAdapter());
      }
      if (!Hive.isAdapterRegistered(32)) {
        Hive.registerAdapter(GiftCardTransactionHiveModelAdapter());
      }

      // Open boxes
      _brandsBox = await Hive.openBox<GiftCardBrandHiveModel>(_brandsBoxName);
      _cardsBox = await Hive.openBox<GiftCardHiveModel>(_cardsBoxName);
      _transactionsBox = await Hive.openBox<GiftCardTransactionHiveModel>(_transactionsBoxName);

      // Clear expired cache on initialization
      await clearExpiredCache();
    } catch (e) {
      print('Error initializing gift card local data source: $e');
      rethrow;
    }
  }

  @override
  Future<List<GiftCardBrandModel>> getCachedBrands() async {
    try {
      if (_brandsBox == null) await initialize();

      final brands = _brandsBox!.values
          .where((brand) => !brand.isCacheExpired())
          .map((hiveModel) => hiveModel.toEntity())
          .toList();

      return brands;
    } catch (e) {
      print('Error getting cached brands: $e');
      return [];
    }
  }

  @override
  Future<void> cacheBrands(List<GiftCardBrandModel> brands) async {
    try {
      if (_brandsBox == null) await initialize();

      // Clear existing brands
      await _brandsBox!.clear();

      // Cache new brands
      final hiveBrands = brands.map((brand) => GiftCardBrandHiveModel.fromEntity(brand)).toList();

      for (var hiveBrand in hiveBrands) {
        await _brandsBox!.put(hiveBrand.id, hiveBrand);
      }
    } catch (e) {
      print('Error caching brands: $e');
    }
  }

  @override
  Future<List<GiftCardModel>> getUserGiftCards(String userId) async {
    try {
      if (_cardsBox == null) await initialize();

      final cards = _cardsBox!.values
          .where((card) => !card.isCacheExpired())
          .map((hiveModel) => hiveModel.toEntity())
          .toList();

      // Sort by purchase date (most recent first)
      cards.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

      return cards;
    } catch (e) {
      print('Error getting user gift cards: $e');
      return [];
    }
  }

  @override
  Future<void> saveGiftCard(GiftCardModel giftCard) async {
    try {
      if (_cardsBox == null) await initialize();

      final hiveCard = GiftCardHiveModel.fromEntity(giftCard);
      await _cardsBox!.put(giftCard.id, hiveCard);
    } catch (e) {
      print('Error saving gift card: $e');
    }
  }

  @override
  Future<GiftCardModel?> getGiftCardById(String giftCardId) async {
    try {
      if (_cardsBox == null) await initialize();

      final hiveCard = _cardsBox!.get(giftCardId);
      if (hiveCard == null || hiveCard.isCacheExpired()) {
        return null;
      }

      return hiveCard.toEntity();
    } catch (e) {
      print('Error getting gift card by ID: $e');
      return null;
    }
  }

  @override
  Future<void> deleteGiftCard(String giftCardId) async {
    try {
      if (_cardsBox == null) await initialize();

      await _cardsBox!.delete(giftCardId);
    } catch (e) {
      print('Error deleting gift card: $e');
    }
  }

  @override
  Future<List<GiftCardTransactionModel>> getTransactions(String userId) async {
    try {
      if (_transactionsBox == null) await initialize();

      final transactions = _transactionsBox!.values
          .where((transaction) => transaction.userId == userId && !transaction.isCacheExpired())
          .map((hiveModel) => hiveModel.toEntity())
          .toList();

      // Sort by transaction date (most recent first)
      transactions.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));

      return transactions;
    } catch (e) {
      print('Error getting transactions: $e');
      return [];
    }
  }

  @override
  Future<void> saveTransaction(GiftCardTransactionModel transaction) async {
    try {
      if (_transactionsBox == null) await initialize();

      final hiveTransaction = GiftCardTransactionHiveModel.fromEntity(transaction);
      await _transactionsBox!.put(transaction.id, hiveTransaction);
    } catch (e) {
      print('Error saving transaction: $e');
    }
  }

  @override
  Future<void> clearAllCache() async {
    try {
      if (_brandsBox == null || _cardsBox == null || _transactionsBox == null) {
        await initialize();
      }

      await _brandsBox!.clear();
      await _cardsBox!.clear();
      await _transactionsBox!.clear();
    } catch (e) {
      print('Error clearing all cache: $e');
    }
  }

  @override
  Future<void> clearExpiredCache() async {
    try {
      if (_brandsBox == null || _cardsBox == null || _transactionsBox == null) {
        await initialize();
      }

      // Clear expired brands
      final expiredBrandKeys = _brandsBox!.values
          .where((brand) => brand.isCacheExpired())
          .map((brand) => brand.id)
          .toList();

      for (var key in expiredBrandKeys) {
        await _brandsBox!.delete(key);
      }

      // Clear expired gift cards
      final expiredCardKeys = _cardsBox!.values
          .where((card) => card.isCacheExpired())
          .map((card) => card.id)
          .toList();

      for (var key in expiredCardKeys) {
        await _cardsBox!.delete(key);
      }

      // Clear expired transactions
      final expiredTransactionKeys = _transactionsBox!.values
          .where((transaction) => transaction.isCacheExpired())
          .map((transaction) => transaction.id)
          .toList();

      for (var key in expiredTransactionKeys) {
        await _transactionsBox!.delete(key);
      }
    } catch (e) {
      print('Error clearing expired cache: $e');
    }
  }

  /// Dispose and close all boxes
  Future<void> dispose() async {
    await _brandsBox?.close();
    await _cardsBox?.close();
    await _transactionsBox?.close();
  }
}
