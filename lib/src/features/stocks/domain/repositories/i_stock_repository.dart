import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class IStockRepository {
  // Stock Data
  Future<Either<Failure, List<Stock>>> getStocks({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  });
  
  Future<Either<Failure, Stock>> getStockDetails(String symbol);
  
  Future<Either<Failure, List<StockPrice>>> getStockPriceHistory(
    String symbol,
    String timeframe, // 1D, 1W, 1M, 3M, 1Y, ALL
  );
  
  Future<Either<Failure, List<Stock>>> getTopMovers();
  
  Future<Either<Failure, List<Stock>>> searchStocks(String query);
  
  // Portfolio Management
  Future<Either<Failure, Portfolio>> getPortfolio();
  
  Future<Either<Failure, List<StockHolding>>> getHoldings();
  
  // Trading
  Future<Either<Failure, StockOrder>> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
  });
  
  Future<Either<Failure, List<StockOrder>>> getOrders({
    OrderStatus? status,
    String? symbol,
  });
  
  Future<Either<Failure, StockOrder>> cancelOrder(String orderId);
  
  // Watchlist
  Future<Either<Failure, List<Watchlist>>> getWatchlists();
  
  Future<Either<Failure, Watchlist>> createWatchlist(String name);
  
  Future<Either<Failure, Watchlist>> addToWatchlist(String watchlistId, String symbol);
  
  Future<Either<Failure, Watchlist>> removeFromWatchlist(String watchlistId, String symbol);
  
  Future<Either<Failure, void>> deleteWatchlist(String watchlistId);
  
  // Market Data
  Future<Either<Failure, List<MarketNews>>> getMarketNews({
    String? symbol,
    int page = 1,
    int limit = 20,
  });
  
  Future<Either<Failure, Map<String, double>>> getMarketIndices();
  
  Future<Either<Failure, List<Map<String, dynamic>>>> getSectorPerformance();
} 