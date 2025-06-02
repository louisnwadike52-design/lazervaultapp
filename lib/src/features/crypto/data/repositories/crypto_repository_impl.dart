import '../../domain/entities/crypto_entity.dart';
import '../../domain/entities/price_point.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_remote_data_source.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;

  CryptoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Crypto>> getCryptos({int page = 1, int perPage = 100}) async {
    return await remoteDataSource.getCryptos(page: page, perPage: perPage);
  }

  @override
  Future<Crypto> getCryptoById(String id) async {
    return await remoteDataSource.getCryptoById(id);
  }

  @override
  Future<List<Crypto>> searchCryptos(String query) async {
    return await remoteDataSource.searchCryptos(query);
  }

  @override
  Future<List<PricePoint>> getCryptoPriceHistory(String id, {String range = '7d'}) async {
    return await remoteDataSource.getCryptoPriceHistory(id, range: range);
  }

  @override
  Future<List<Crypto>> getTrendingCryptos() async {
    return await remoteDataSource.getTrendingCryptos();
  }

  @override
  Future<List<Crypto>> getTopCryptos() async {
    return await remoteDataSource.getTopCryptos();
  }

  @override
  Future<List<CryptoWatchlist>> getWatchlists() async {
    // Mock implementation - in production, this would fetch from local storage
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      CryptoWatchlist(
        id: '1',
        name: 'My Favorites',
        description: 'My favorite cryptocurrencies',
        cryptoIds: ['bitcoin', 'ethereum'],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
      CryptoWatchlist(
        id: '2',
        name: 'DeFi Tokens',
        description: 'Decentralized Finance tokens',
        cryptoIds: ['ethereum', 'cardano'],
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<CryptoWatchlist> createWatchlist(String name, String description) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return CryptoWatchlist(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      cryptoIds: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> addToWatchlist(String watchlistId, String cryptoId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Mock implementation - in production, this would update local storage
  }

  @override
  Future<void> removeFromWatchlist(String watchlistId, String cryptoId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Mock implementation - in production, this would update local storage
  }

  @override
  Future<void> deleteWatchlist(String watchlistId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Mock implementation - in production, this would delete from local storage
  }

  @override
  Future<List<CryptoHolding>> getHoldings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Mock holdings data
    return [
      CryptoHolding(
        id: '1',
        cryptoId: 'bitcoin',
        cryptoSymbol: 'BTC',
        cryptoName: 'Bitcoin',
        quantity: 0.25,
        averagePrice: 40000,
        currentPrice: 43250.50,
        totalValue: 10812.62,
        totalGainLoss: 812.62,
        totalGainLossPercentage: 8.13,
        purchaseDate: DateTime.now().subtract(const Duration(days: 45)),
        lastUpdated: DateTime.now(),
      ),
      CryptoHolding(
        id: '2',
        cryptoId: 'ethereum',
        cryptoSymbol: 'ETH',
        cryptoName: 'Ethereum',
        quantity: 2.5,
        averagePrice: 2400,
        currentPrice: 2650.75,
        totalValue: 6626.87,
        totalGainLoss: 626.87,
        totalGainLossPercentage: 10.45,
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  @override
  Future<CryptoTransaction> buyCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate processing time
    
    final crypto = await getCryptoById(cryptoId);
    final totalAmount = quantity * price;
    const fees = 2.99; // Fixed fee for demo
    
    return CryptoTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cryptoId: cryptoId,
      cryptoSymbol: crypto.symbol,
      cryptoName: crypto.name,
      type: TransactionType.buy,
      quantity: quantity,
      price: price,
      totalAmount: totalAmount + fees,
      fees: fees,
      timestamp: DateTime.now(),
      status: 'completed',
    );
  }

  @override
  Future<CryptoTransaction> sellCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate processing time
    
    final crypto = await getCryptoById(cryptoId);
    final totalAmount = quantity * price;
    const fees = 2.99; // Fixed fee for demo
    
    return CryptoTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cryptoId: cryptoId,
      cryptoSymbol: crypto.symbol,
      cryptoName: crypto.name,
      type: TransactionType.sell,
      quantity: quantity,
      price: price,
      totalAmount: totalAmount - fees,
      fees: fees,
      timestamp: DateTime.now(),
      status: 'completed',
    );
  }

  @override
  Future<List<CryptoTransaction>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Mock transaction data
    return [
      CryptoTransaction(
        id: '1',
        cryptoId: 'bitcoin',
        cryptoSymbol: 'BTC',
        cryptoName: 'Bitcoin',
        type: TransactionType.buy,
        quantity: 0.1,
        price: 42000,
        totalAmount: 4202.99,
        fees: 2.99,
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        status: 'completed',
      ),
      CryptoTransaction(
        id: '2',
        cryptoId: 'ethereum',
        cryptoSymbol: 'ETH',
        cryptoName: 'Ethereum',
        type: TransactionType.buy,
        quantity: 1.0,
        price: 2500,
        totalAmount: 2502.99,
        fees: 2.99,
        timestamp: DateTime.now().subtract(const Duration(days: 14)),
        status: 'completed',
      ),
    ];
  }

  @override
  Future<void> toggleFavorite(String cryptoId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Mock implementation - in production, this would update local storage
  }
} 