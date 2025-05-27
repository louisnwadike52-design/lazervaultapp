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
  
  Future<Either<Failure, Watchlist>> createWatchlist(String name, List<String> symbols);
  
  Future<Either<Failure, Watchlist>> updateWatchlist(String watchlistId, String name, List<String> symbols);
  
  Future<Either<Failure, Watchlist>> addToWatchlist(String watchlistId, String symbol);
  
  Future<Either<Failure, Watchlist>> removeFromWatchlist(String watchlistId, String symbol);
  
  Future<Either<Failure, void>> deleteWatchlist(String watchlistId);
  
  // Market Data
  Future<Either<Failure, List<MarketNews>>> getMarketNews({
    NewsCategory? category,
    List<String>? symbols,
    int page = 1,
    int limit = 20,
  });
  
  Future<Either<Failure, Map<String, double>>> getMarketIndices();
  
  Future<Either<Failure, List<SectorPerformance>>> getSectorPerformance();
  
  // Alerts
  Future<Either<Failure, List<StockAlert>>> getAlerts();
  
  Future<Either<Failure, StockAlert>> createAlert({
    required String symbol,
    required AlertType type,
    required double targetValue,
    required AlertCondition condition,
  });
  
  Future<Either<Failure, StockAlert>> updateAlert(
    String alertId, {
    AlertType? type,
    double? targetValue,
    AlertCondition? condition,
    bool? isActive,
  });
  
  Future<Either<Failure, void>> deleteAlert(String alertId);
  
  // Analysis
  Future<Either<Failure, StockAnalysis>> getStockAnalysis(String symbol);
  
  // Trading Sessions
  Future<Either<Failure, TradingSession>> getCurrentTradingSession();
  
  Future<Either<Failure, TradingSession>> startTradingSession(double startingBalance);
  
  Future<Either<Failure, TradingSession>> endTradingSession(String sessionId);
  
  Future<Either<Failure, List<TradingSession>>> getTradingSessionHistory();
  
  // Options
  Future<Either<Failure, List<OptionContract>>> getOptions(
    String underlyingSymbol, {
    DateTime? expirationDate,
    OptionType? type,
  });
  
  Future<Either<Failure, OptionContract>> getOptionDetails(String optionSymbol);
  
  // Advanced Features
  Future<Either<Failure, List<Stock>>> getRecommendations();
  
  Future<Either<Failure, List<Stock>>> getTrendingStocks();
  
  Future<Either<Failure, Map<String, dynamic>>> getMarketStatus();
  
  Future<Either<Failure, List<Stock>>> getEarningsCalendar({DateTime? date});
  
  Future<Either<Failure, List<Stock>>> getDividendCalendar({DateTime? date});
} 