import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/stock_entity.dart';
import '../domain/usecases/get_stocks_usecase.dart';
import '../domain/usecases/get_portfolio_usecase.dart';
import '../domain/usecases/place_order_usecase.dart';
import '../domain/usecases/get_watchlists_usecase.dart';
import '../domain/repositories/i_stock_repository.dart';
import 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final GetStocksUseCase getStocksUseCase;
  final GetPortfolioUseCase getPortfolioUseCase;
  final PlaceOrderUseCase placeOrderUseCase;
  final GetWatchlistsUseCase getWatchlistsUseCase;
  final IStockRepository repository;

  StockCubit({
    required this.getStocksUseCase,
    required this.getPortfolioUseCase,
    required this.placeOrderUseCase,
    required this.getWatchlistsUseCase,
    required this.repository,
  }) : super(StockInitial());

  // Stock Data Methods
  Future<void> loadStocks({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      emit(StockLoading());
      
      final result = await getStocksUseCase(
        sector: sector,
        searchQuery: searchQuery,
        page: page,
        limit: limit,
      );
      
      result.fold(
        (failure) => emit(StockError(failure.message)),
        (stocks) => emit(StockLoaded(stocks, sector: sector)),
      );
    } catch (e) {
      emit(StockError('Failed to load stocks: ${e.toString()}'));
    }
  }

  Future<void> loadStockDetails(String symbol, {String timeframe = '1M'}) async {
    try {
      emit(StockDetailsLoading());
      
      final stockResult = await repository.getStockDetails(symbol);
      final priceHistoryResult = await repository.getStockPriceHistory(symbol, timeframe);
      final analysisResult = await repository.getStockAnalysis(symbol);
      
      stockResult.fold(
        (failure) => emit(StockDetailsError(failure.message)),
        (stock) {
          priceHistoryResult.fold(
            (failure) => emit(StockDetailsError(failure.message)),
            (priceHistory) {
              analysisResult.fold(
                (failure) => emit(StockDetailsLoaded(stock, priceHistory)),
                (analysis) => emit(StockDetailsLoaded(stock, priceHistory, analysis: analysis)),
              );
            },
          );
        },
      );
    } catch (e) {
      emit(StockDetailsError('Failed to load stock details: ${e.toString()}'));
    }
  }

  Future<void> searchStocks(String query) async {
    try {
      if (query.isEmpty) {
        emit(StockSearchLoaded([], query));
        return;
      }
      
      emit(StockSearchLoading());
      
      final result = await repository.searchStocks(query);
      
      result.fold(
        (failure) => emit(StockSearchError(failure.message)),
        (stocks) => emit(StockSearchLoaded(stocks, query)),
      );
    } catch (e) {
      emit(StockSearchError('Failed to search stocks: ${e.toString()}'));
    }
  }

  Future<void> loadTopMovers() async {
    try {
      emit(StockLoading());
      
      final result = await repository.getTopMovers();
      
      result.fold(
        (failure) => emit(StockError(failure.message)),
        (stocks) => emit(StockLoaded(stocks)),
      );
    } catch (e) {
      emit(StockError('Failed to load top movers: ${e.toString()}'));
    }
  }

  // Portfolio Methods
  Future<void> loadPortfolio() async {
    try {
      emit(PortfolioLoading());
      
      final result = await getPortfolioUseCase();
      
      result.fold(
        (failure) => emit(PortfolioError(failure.message)),
        (portfolio) => emit(PortfolioLoaded(portfolio)),
      );
    } catch (e) {
      emit(PortfolioError('Failed to load portfolio: ${e.toString()}'));
    }
  }

  Future<void> loadHoldings() async {
    try {
      emit(HoldingsLoading());
      
      final result = await repository.getHoldings();
      
      result.fold(
        (failure) => emit(HoldingsError(failure.message)),
        (holdings) => emit(HoldingsLoaded(holdings)),
      );
    } catch (e) {
      emit(HoldingsError('Failed to load holdings: ${e.toString()}'));
    }
  }

  // Trading Methods
  Future<void> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
    String? notes,
  }) async {
    try {
      emit(OrderPlacing());
      
      final result = await placeOrderUseCase(
        symbol: symbol,
        type: type,
        side: side,
        quantity: quantity,
        price: price,
      );
      
      result.fold(
        (failure) => emit(OrderError(failure.message)),
        (order) => emit(OrderPlaced(order)),
      );
    } catch (e) {
      emit(OrderError('Failed to place order: ${e.toString()}'));
    }
  }

  Future<void> loadOrders({OrderStatus? status, String? symbol}) async {
    try {
      emit(OrdersLoading());
      
      final result = await repository.getOrders(status: status, symbol: symbol);
      
      result.fold(
        (failure) => emit(StockError(failure.message)),
        (orders) => emit(OrdersLoaded(orders)),
      );
    } catch (e) {
      emit(StockError('Failed to load orders: ${e.toString()}'));
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      emit(OrderCancelling());
      
      final result = await repository.cancelOrder(orderId);
      
      result.fold(
        (failure) => emit(OrderError(failure.message)),
        (order) => emit(OrderCancelled(order)),
      );
    } catch (e) {
      emit(OrderError('Failed to cancel order: ${e.toString()}'));
    }
  }

  // Watchlist Methods
  Future<void> loadWatchlists() async {
    try {
      emit(WatchlistsLoading());
      
      final result = await getWatchlistsUseCase();
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (watchlists) => emit(WatchlistsLoaded(watchlists)),
      );
    } catch (e) {
      emit(WatchlistsError('Failed to load watchlists: ${e.toString()}'));
    }
  }

  Future<void> createWatchlist(String name, List<String> symbols) async {
    try {
      emit(WatchlistCreating());
      
      final result = await repository.createWatchlist(name, symbols);
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (watchlist) => emit(WatchlistCreated(watchlist)),
      );
    } catch (e) {
      emit(WatchlistsError('Failed to create watchlist: ${e.toString()}'));
    }
  }

  Future<void> updateWatchlist(String watchlistId, String name, List<String> symbols) async {
    try {
      emit(WatchlistUpdating());
      
      final result = await repository.updateWatchlist(watchlistId, name, symbols);
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (watchlist) => emit(WatchlistUpdated(watchlist)),
      );
    } catch (e) {
      emit(WatchlistsError('Failed to update watchlist: ${e.toString()}'));
    }
  }

  Future<void> deleteWatchlist(String watchlistId) async {
    try {
      emit(WatchlistDeleting());
      
      final result = await repository.deleteWatchlist(watchlistId);
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (_) => emit(WatchlistDeleted(watchlistId)),
      );
    } catch (e) {
      emit(WatchlistsError('Failed to delete watchlist: ${e.toString()}'));
    }
  }

  Future<void> addToWatchlist(String watchlistId, String symbol) async {
    try {
      final result = await repository.addToWatchlist(watchlistId, symbol);
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (watchlist) => emit(WatchlistUpdated(watchlist)),
      );
    } catch (e) {
      emit(WatchlistsError('Failed to add to watchlist: ${e.toString()}'));
    }
  }

  Future<void> removeFromWatchlist(String watchlistId, String symbol) async {
    try {
      final result = await repository.removeFromWatchlist(watchlistId, symbol);
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (watchlist) => emit(WatchlistUpdated(watchlist)),
      );
    } catch (e) {
      emit(WatchlistsError('Failed to remove from watchlist: ${e.toString()}'));
    }
  }

  // Market Data Methods
  Future<void> loadMarketNews({NewsCategory? category, List<String>? symbols}) async {
    try {
      emit(MarketNewsLoading());
      
      final result = await repository.getMarketNews(category: category, symbols: symbols);
      
      result.fold(
        (failure) => emit(MarketNewsError(failure.message)),
        (news) => emit(MarketNewsLoaded(news)),
      );
    } catch (e) {
      emit(MarketNewsError('Failed to load market news: ${e.toString()}'));
    }
  }

  Future<void> loadMarketIndices() async {
    try {
      emit(MarketIndicesLoading());
      
      final result = await repository.getMarketIndices();
      
      result.fold(
        (failure) => emit(MarketIndicesError(failure.message)),
        (indices) => emit(MarketIndicesLoaded(indices)),
      );
    } catch (e) {
      emit(MarketIndicesError('Failed to load market indices: ${e.toString()}'));
    }
  }

  Future<void> loadSectorPerformance() async {
    try {
      emit(SectorPerformanceLoading());
      
      final result = await repository.getSectorPerformance();
      
      result.fold(
        (failure) => emit(SectorPerformanceError(failure.message)),
        (sectors) => emit(SectorPerformanceLoaded(sectors)),
      );
    } catch (e) {
      emit(SectorPerformanceError('Failed to load sector performance: ${e.toString()}'));
    }
  }

  // Alert Methods
  Future<void> loadAlerts() async {
    try {
      emit(AlertsLoading());
      
      final result = await repository.getAlerts();
      
      result.fold(
        (failure) => emit(AlertsError(failure.message)),
        (alerts) => emit(AlertsLoaded(alerts)),
      );
    } catch (e) {
      emit(AlertsError('Failed to load alerts: ${e.toString()}'));
    }
  }

  Future<void> createAlert({
    required String symbol,
    required AlertType type,
    required double targetValue,
    required AlertCondition condition,
  }) async {
    try {
      emit(AlertCreating());
      
      final result = await repository.createAlert(
        symbol: symbol,
        type: type,
        targetValue: targetValue,
        condition: condition,
      );
      
      result.fold(
        (failure) => emit(AlertsError(failure.message)),
        (alert) => emit(AlertCreated(alert)),
      );
    } catch (e) {
      emit(AlertsError('Failed to create alert: ${e.toString()}'));
    }
  }

  Future<void> updateAlert(String alertId, {
    AlertType? type,
    double? targetValue,
    AlertCondition? condition,
    bool? isActive,
  }) async {
    try {
      emit(AlertUpdating());
      
      final result = await repository.updateAlert(
        alertId,
        type: type,
        targetValue: targetValue,
        condition: condition,
        isActive: isActive,
      );
      
      result.fold(
        (failure) => emit(AlertsError(failure.message)),
        (alert) => emit(AlertUpdated(alert)),
      );
    } catch (e) {
      emit(AlertsError('Failed to update alert: ${e.toString()}'));
    }
  }

  Future<void> deleteAlert(String alertId) async {
    try {
      emit(AlertDeleting());
      
      final result = await repository.deleteAlert(alertId);
      
      result.fold(
        (failure) => emit(AlertsError(failure.message)),
        (_) => emit(AlertDeleted(alertId)),
      );
    } catch (e) {
      emit(AlertsError('Failed to delete alert: ${e.toString()}'));
    }
  }

  // Trading Session Methods
  Future<void> loadTradingSession() async {
    try {
      emit(TradingSessionLoading());
      
      final result = await repository.getCurrentTradingSession();
      
      result.fold(
        (failure) => emit(TradingSessionError(failure.message)),
        (session) => emit(TradingSessionLoaded(session)),
      );
    } catch (e) {
      emit(TradingSessionError('Failed to load trading session: ${e.toString()}'));
    }
  }

  Future<void> startTradingSession(double startingBalance) async {
    try {
      emit(TradingSessionStarting());
      
      final result = await repository.startTradingSession(startingBalance);
      
      result.fold(
        (failure) => emit(TradingSessionError(failure.message)),
        (session) => emit(TradingSessionStarted(session)),
      );
    } catch (e) {
      emit(TradingSessionError('Failed to start trading session: ${e.toString()}'));
    }
  }

  Future<void> endTradingSession(String sessionId) async {
    try {
      emit(TradingSessionEnding());
      
      final result = await repository.endTradingSession(sessionId);
      
      result.fold(
        (failure) => emit(TradingSessionError(failure.message)),
        (session) => emit(TradingSessionEnded(session)),
      );
    } catch (e) {
      emit(TradingSessionError('Failed to end trading session: ${e.toString()}'));
    }
  }

  // Analysis Methods
  Future<void> loadStockAnalysis(String symbol) async {
    try {
      emit(AnalysisLoading());
      
      final result = await repository.getStockAnalysis(symbol);
      
      result.fold(
        (failure) => emit(AnalysisError(failure.message)),
        (analysis) => emit(AnalysisLoaded(analysis)),
      );
    } catch (e) {
      emit(AnalysisError('Failed to load stock analysis: ${e.toString()}'));
    }
  }

  // Options Methods
  Future<void> loadOptions(String underlyingSymbol, {DateTime? expirationDate}) async {
    try {
      emit(OptionsLoading());
      
      final result = await repository.getOptions(underlyingSymbol, expirationDate: expirationDate);
      
      result.fold(
        (failure) => emit(OptionsError(failure.message)),
        (options) => emit(OptionsLoaded(options)),
      );
    } catch (e) {
      emit(OptionsError('Failed to load options: ${e.toString()}'));
    }
  }

  // Dashboard Methods
  Future<void> loadDashboard() async {
    try {
      emit(StockLoading());
      
      // Load all dashboard data concurrently
      final futures = await Future.wait([
        getStocksUseCase(limit: 10).then((result) => result.fold((l) => <Stock>[], (r) => r)),
        getPortfolioUseCase().then((result) => result.fold((l) => null, (r) => r)),
        repository.getMarketIndices().then((result) => result.fold((l) => <String, double>{}, (r) => r)),
        repository.getMarketNews(category: NewsCategory.market).then((result) => result.fold((l) => <MarketNews>[], (r) => r)),
        repository.getSectorPerformance().then((result) => result.fold((l) => <SectorPerformance>[], (r) => r)),
      ]);

      final stocks = futures[0] as List<Stock>;
      final portfolio = futures[1] as Portfolio?;
      final indices = futures[2] as Map<String, double>;
      final news = futures[3] as List<MarketNews>;
      final sectors = futures[4] as List<SectorPerformance>;

      emit(StockDashboardLoaded(
        stocks: stocks,
        portfolio: portfolio,
        indices: indices,
        news: news,
        sectors: sectors,
      ));
    } catch (e) {
      emit(StockError('Failed to load dashboard: ${e.toString()}'));
    }
  }

  // Utility Methods
  Future<void> refreshData() async {
    final currentState = state;
    if (currentState is StockLoaded) {
      await loadStocks(sector: currentState.sector);
    } else if (currentState is PortfolioLoaded) {
      await loadPortfolio();
    } else if (currentState is WatchlistsLoaded) {
      await loadWatchlists();
    } else if (currentState is OrdersLoaded) {
      await loadOrders();
    } else if (currentState is MarketNewsLoaded) {
      await loadMarketNews();
    } else {
      await loadDashboard();
    }
  }

  void clearSearch() {
    emit(StockSearchLoaded([], ''));
  }

  void resetToInitial() {
    emit(StockInitial());
  }
} 