import '../models/stock_model.dart';
import '../../domain/entities/stock_entity.dart';
import '../../domain/entities/price_point.dart';

abstract class IStockRemoteDataSource {
  Future<List<StockModel>> getStocks({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  });

  Future<StockModel> getStockDetails(String symbol);

  Future<List<StockPriceModel>> getStockPriceHistory(
    String symbol,
    String timeframe,
  );

  Future<List<StockModel>> getTopMovers();

  Future<List<StockModel>> searchStocks(String query);

  Future<PortfolioModel> getPortfolio();

  Future<List<StockHoldingModel>> getHoldings();

  Future<StockOrderModel> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
  });

  Future<List<StockOrderModel>> getOrders({
    OrderStatus? status,
    String? symbol,
  });

  Future<StockOrderModel> cancelOrder(String orderId);

  Future<List<WatchlistModel>> getWatchlists();

  Future<WatchlistModel> createWatchlist(String name, List<String> symbols);

  Future<WatchlistModel> updateWatchlist(String watchlistId, String name, List<String> symbols);

  Future<WatchlistModel> addToWatchlist(String watchlistId, String symbol);

  Future<WatchlistModel> removeFromWatchlist(String watchlistId, String symbol);

  Future<void> deleteWatchlist(String watchlistId);

  Future<List<MarketNewsModel>> getMarketNews({
    NewsCategory? category,
    List<String>? symbols,
    int page = 1,
    int limit = 20,
  });

  Future<Map<String, double>> getMarketIndices();

  Future<List<SectorPerformanceModel>> getSectorPerformance();

  // Alerts
  Future<List<StockAlertModel>> getAlerts();

  Future<StockAlertModel> createAlert({
    required String symbol,
    required AlertType type,
    required double targetValue,
    required AlertCondition condition,
  });

  Future<StockAlertModel> updateAlert(
    String alertId, {
    AlertType? type,
    double? targetValue,
    AlertCondition? condition,
    bool? isActive,
  });

  Future<void> deleteAlert(String alertId);

  // Analysis
  Future<StockAnalysisModel> getStockAnalysis(String symbol);

  // Trading Sessions
  Future<TradingSessionModel> getCurrentTradingSession();

  Future<TradingSessionModel> startTradingSession(double startingBalance);

  Future<TradingSessionModel> endTradingSession(String sessionId);

  Future<List<TradingSessionModel>> getTradingSessionHistory();

  // Options
  Future<List<OptionContractModel>> getOptions(
    String underlyingSymbol, {
    DateTime? expirationDate,
    OptionType? type,
  });

  Future<OptionContractModel> getOptionDetails(String optionSymbol);

  // Advanced Features
  Future<List<StockModel>> getRecommendations();

  Future<List<StockModel>> getTrendingStocks();

  Future<Map<String, dynamic>> getMarketStatus();

  Future<List<StockModel>> getEarningsCalendar({DateTime? date});

  Future<List<StockModel>> getDividendCalendar({DateTime? date});
}
