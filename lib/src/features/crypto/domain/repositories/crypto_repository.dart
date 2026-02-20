import '../entities/crypto_entity.dart';
import '../entities/price_point.dart';

abstract class CryptoRepository {
  Future<List<Crypto>> getCryptos({int page = 1, int perPage = 100});
  Future<Crypto> getCryptoById(String id);
  Future<List<Crypto>> searchCryptos(String query);
  Future<List<PricePoint>> getCryptoPriceHistory(
    String id, {
    String range = '7d',
  });
  Future<List<Crypto>> getTrendingCryptos();
  Future<List<Crypto>> getTopCryptos();
  Future<List<CryptoWatchlist>> getWatchlists();
  Future<CryptoWatchlist> createWatchlist(String name, String description);
  Future<void> addToWatchlist(String watchlistId, String cryptoId);
  Future<void> removeFromWatchlist(String watchlistId, String cryptoId);
  Future<void> deleteWatchlist(String watchlistId);
  Future<List<CryptoHolding>> getHoldings();
  Future<CryptoTransaction> buyCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  });
  Future<CryptoTransaction> sellCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  });
  Future<CryptoTransaction> convertCrypto({
    required String fromCryptoId,
    required String toCryptoId,
    required double amount,
    required String transactionPin,
    String? fiatCurrency,
  });
  Future<List<CryptoTransaction>> getTransactions();
  Future<void> toggleFavorite(String cryptoId);
} 