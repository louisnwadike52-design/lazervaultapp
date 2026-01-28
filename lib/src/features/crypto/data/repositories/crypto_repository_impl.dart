import '../../domain/entities/crypto_entity.dart';
import '../../domain/entities/price_point.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_remote_data_source.dart';
import '../../../../core/grpc/crypto_grpc_client.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;
  final CryptoGrpcClient grpcClient;

  CryptoRepositoryImpl({
    required this.remoteDataSource,
    required this.grpcClient,
  });

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
    // TODO: Implement watchlist feature when backend gRPC methods are available
    // For now, return empty list to prevent compilation errors
    return [];
  }

  @override
  Future<CryptoWatchlist> createWatchlist(String name, String description) async {
    // TODO: Implement watchlist feature when backend gRPC methods are available
    throw UnimplementedError('Watchlist feature not yet implemented');
  }

  @override
  Future<void> addToWatchlist(String watchlistId, String cryptoId) async {
    // TODO: Implement watchlist feature when backend gRPC methods are available
  }

  @override
  Future<void> removeFromWatchlist(String watchlistId, String cryptoId) async {
    // TODO: Implement watchlist feature when backend gRPC methods are available
  }

  @override
  Future<void> deleteWatchlist(String watchlistId) async {
    // TODO: Implement watchlist feature when backend gRPC methods are available
  }

  @override
  Future<List<CryptoHolding>> getHoldings() async {
    // Fetch real holdings from backend via gRPC
    try {
      final response = await grpcClient.getHoldings();
      return response.holdings.map((h) => CryptoHolding(
        id: h.cryptoId, // Use cryptoId as id
        cryptoId: h.cryptoId,
        cryptoSymbol: h.symbol, // Changed from cryptoSymbol
        cryptoName: h.name, // Changed from cryptoName
        quantity: h.balance, // Changed from quantity to balance
        averagePrice: h.fiatValue / (h.balance > 0 ? h.balance : 1), // Calculate avg
        currentPrice: h.fiatValue / (h.balance > 0 ? h.balance : 1),
        totalValue: h.fiatValue,
        totalGainLoss: 0, // Not in proto
        totalGainLossPercentage: 0.0, // Not in proto
        purchaseDate: DateTime.fromMillisecondsSinceEpoch(h.acquiredAt.toDateTime().millisecondsSinceEpoch),
        lastUpdated: DateTime.now(),
      )).toList();
    } catch (e) {
      // If backend not available, return empty list
      return [];
    }
  }

  @override
  Future<CryptoTransaction> buyCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
  }) async {
    // Execute buy via backend gRPC service
    final response = await grpcClient.buyCrypto(
      cryptoId: cryptoId,
      fiatAmount: quantity * price,
      fiatCurrency: 'GBP', // TODO: Use user's preferred currency
    );

    // Get crypto details for the response
    final crypto = await getCryptoById(cryptoId);

    return CryptoTransaction(
      id: response.transactionId,
      cryptoId: cryptoId,
      cryptoSymbol: crypto.symbol,
      cryptoName: crypto.name,
      type: TransactionType.buy,
      quantity: response.cryptoAmount,
      price: response.fiatAmount / response.cryptoAmount,
      totalAmount: response.fiatAmount,
      fees: 0.0, // Fee not returned by proto response
      timestamp: DateTime.now(),
      status: response.status,
    );
  }

  @override
  Future<CryptoTransaction> sellCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
  }) async {
    // Execute sell via backend gRPC service
    final response = await grpcClient.sellCrypto(
      cryptoId: cryptoId,
      quantity: quantity, // grpc client expects 'quantity' parameter name
      fiatCurrency: 'GBP', // TODO: Use user's preferred currency
    );

    // Get crypto details for the response
    final crypto = await getCryptoById(cryptoId);

    return CryptoTransaction(
      id: response.transactionId,
      cryptoId: cryptoId,
      cryptoSymbol: crypto.symbol,
      cryptoName: crypto.name,
      type: TransactionType.sell,
      quantity: response.cryptoAmount,
      price: response.fiatAmount / response.cryptoAmount,
      totalAmount: response.fiatAmount,
      fees: 0.0, // Fee not returned by proto response
      timestamp: DateTime.now(),
      status: response.status,
    );
  }

  @override
  Future<List<CryptoTransaction>> getTransactions() async {
    // Fetch real transactions from backend via gRPC
    try {
      final response = await grpcClient.getTransactions(limit: 100);
      return response.transactions.map((t) => CryptoTransaction(
        id: t.id,
        cryptoId: t.cryptoId,
        cryptoSymbol: t.cryptoSymbol,
        cryptoName: '', // cryptoName not in proto, would need separate fetch
        type: t.type == 'buy' ? TransactionType.buy : TransactionType.sell,
        quantity: t.amount, // proto uses 'amount' not 'quantity'
        price: t.fiatValue > 0 && t.amount > 0 ? t.fiatValue / t.amount : 0, // calculate price
        totalAmount: t.fiatValue, // proto uses 'fiatValue' not 'totalAmount'
        fees: 0.0, // fees not in proto
        timestamp: t.timestamp.toDateTime(), // proto uses Timestamp type
        status: t.status,
      )).toList();
    } catch (e) {
      // If backend not available, return empty list
      return [];
    }
  }

  @override
  Future<void> toggleFavorite(String cryptoId) async {
    // TODO: Implement toggleFavorite when backend gRPC method is available
    // For now, this is a no-op to prevent compilation errors
    throw UnimplementedError('Toggle favorite feature not yet implemented');
  }
} 