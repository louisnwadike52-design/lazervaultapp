import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/stock_entity.dart';
import '../domain/entities/analyst_ratings.dart';
import '../domain/entities/stock_event.dart';
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
      if (isClosed) return;
      emit(StockLoading());
      
      final result = await getStocksUseCase(
        sector: sector,
        searchQuery: searchQuery,
        page: page,
        limit: limit,
      );

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(StockError(failure.message));
        },
        (stocks) {
          if (isClosed) return;
          emit(StockLoaded(stocks, sector: sector));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(StockError('Failed to load stocks: ${e.toString()}'));
    }
  }

  Future<void> loadStockDetails(String symbol, {String timeframe = '1M'}) async {
    try {
      if (isClosed) return;
      emit(StockDetailsLoading());
      
      final stockResult = await repository.getStockDetails(symbol);
      final priceHistoryResult = await repository.getStockPriceHistory(symbol, timeframe);
      final analysisResult = await repository.getStockAnalysis(symbol);

      stockResult.fold(
        (failure) {
          if (isClosed) return;
          emit(StockDetailsError(failure.message));
        },
        (stock) {
          priceHistoryResult.fold(
            (failure) {
              if (isClosed) return;
              emit(StockDetailsError(failure.message));
            },
            (priceHistory) {
              analysisResult.fold(
                (failure) {
                  if (isClosed) return;
                  emit(StockDetailsLoaded(
                    stock: stock,
                    priceHistory: priceHistory,
                  ));
                },
                (analysis) {
                  if (isClosed) return;
                  emit(StockDetailsLoaded(
                    stock: stock,
                    priceHistory: priceHistory,
                    analysis: analysis,
                  ));
                },
              );
            },
          );
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(StockDetailsError('Failed to load stock details: ${e.toString()}'));
    }
  }

  Future<void> searchStocks(String query) async {
    try {
      if (query.isEmpty) {
        if (isClosed) return;
        emit(StockSearchLoaded([], query));
        return;
      }

      if (isClosed) return;
      emit(StockSearchLoading());
      
      final result = await repository.searchStocks(query);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(StockSearchError(failure.message));
        },
        (stocks) {
          if (isClosed) return;
          emit(StockSearchLoaded(stocks, query));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(StockSearchError('Failed to search stocks: ${e.toString()}'));
    }
  }

  Future<void> loadTopMovers() async {
    try {
      if (isClosed) return;
      emit(StockLoading());
      
      final result = await repository.getTopMovers();

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(StockError(failure.message));
        },
        (stocks) {
          if (isClosed) return;
          emit(StockLoaded(stocks));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(StockError('Failed to load top movers: ${e.toString()}'));
    }
  }

  // Portfolio Methods
  Future<void> loadPortfolio() async {
    try {
      if (isClosed) return;
      emit(PortfolioLoading());
      
      final result = await getPortfolioUseCase();

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(PortfolioError(failure.message));
        },
        (portfolio) {
          if (isClosed) return;
          emit(PortfolioLoaded(portfolio));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(PortfolioError('Failed to load portfolio: ${e.toString()}'));
    }
  }

  Future<void> loadHoldings() async {
    try {
      if (isClosed) return;
      emit(HoldingsLoading());
      
      final result = await repository.getHoldings();

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(HoldingsError(failure.message));
        },
        (holdings) {
          if (isClosed) return;
          emit(HoldingsLoaded(holdings));
        },
      );
    } catch (e) {
      if (isClosed) return;
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
      if (isClosed) return;
      emit(OrderPlacing());
      
      final result = await placeOrderUseCase(
        symbol: symbol,
        type: type,
        side: side,
        quantity: quantity,
        price: price,
      );

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(OrderError(failure.message));
        },
        (order) {
          if (isClosed) return;
          emit(OrderPlaced(order));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(OrderError('Failed to place order: ${e.toString()}'));
    }
  }

  Future<void> loadOrders({OrderStatus? status, String? symbol}) async {
    try {
      if (isClosed) return;
      emit(OrdersLoading());
      
      final result = await repository.getOrders(status: status, symbol: symbol);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(StockError(failure.message));
        },
        (orders) {
          if (isClosed) return;
          emit(OrdersLoaded(orders));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(StockError('Failed to load orders: ${e.toString()}'));
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      if (isClosed) return;
      emit(OrderCancelling());
      
      final result = await repository.cancelOrder(orderId);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(OrderError(failure.message));
        },
        (order) {
          if (isClosed) return;
          emit(OrderCancelled(order));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(OrderError('Failed to cancel order: ${e.toString()}'));
    }
  }

  // Watchlist Methods
  Future<void> loadWatchlists() async {
    try {
      if (isClosed) return;
      emit(WatchlistsLoading());
      
      final result = await getWatchlistsUseCase();

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(WatchlistsError(failure.message));
        },
        (watchlists) {
          if (isClosed) return;
          emit(WatchlistsLoaded(watchlists));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(WatchlistsError('Failed to load watchlists: ${e.toString()}'));
    }
  }

  Future<void> createWatchlist(String name, List<String> symbols) async {
    try {
      if (isClosed) return;
      emit(WatchlistCreating());
      
      final result = await repository.createWatchlist(name, symbols);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(WatchlistsError(failure.message));
        },
        (watchlist) {
          if (isClosed) return;
          emit(WatchlistCreated(watchlist));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(WatchlistsError('Failed to create watchlist: ${e.toString()}'));
    }
  }

  Future<void> updateWatchlist(String watchlistId, String name, List<String> symbols) async {
    try {
      if (isClosed) return;
      emit(WatchlistUpdating());
      
      final result = await repository.updateWatchlist(watchlistId, name, symbols);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(WatchlistsError(failure.message));
        },
        (watchlist) {
          if (isClosed) return;
          emit(WatchlistUpdated(watchlist));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(WatchlistsError('Failed to update watchlist: ${e.toString()}'));
    }
  }

  Future<void> deleteWatchlist(String watchlistId) async {
    try {
      if (isClosed) return;
      emit(WatchlistDeleting());
      
      final result = await repository.deleteWatchlist(watchlistId);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(WatchlistsError(failure.message));
        },
        (_) {
          if (isClosed) return;
          emit(WatchlistDeleted(watchlistId));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(WatchlistsError('Failed to delete watchlist: ${e.toString()}'));
    }
  }

  Future<void> addToWatchlist(String watchlistId, String symbol) async {
    try {
      final result = await repository.addToWatchlist(watchlistId, symbol);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(WatchlistsError(failure.message));
        },
        (watchlist) {
          if (isClosed) return;
          emit(WatchlistUpdated(watchlist));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(WatchlistsError('Failed to add to watchlist: ${e.toString()}'));
    }
  }

  Future<void> removeFromWatchlist(String watchlistId, String symbol) async {
    try {
      final result = await repository.removeFromWatchlist(watchlistId, symbol);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(WatchlistsError(failure.message));
        },
        (watchlist) {
          if (isClosed) return;
          emit(WatchlistUpdated(watchlist));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(WatchlistsError('Failed to remove from watchlist: ${e.toString()}'));
    }
  }

  // Market Data Methods
  Future<void> loadMarketNews({NewsCategory? category, List<String>? symbols}) async {
    try {
      if (isClosed) return;
      emit(MarketNewsLoading());
      
      final result = await repository.getMarketNews(category: category, symbols: symbols);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(MarketNewsError(failure.message));
        },
        (news) {
          if (isClosed) return;
          emit(MarketNewsLoaded(news));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(MarketNewsError('Failed to load market news: ${e.toString()}'));
    }
  }

  Future<void> loadMarketIndices() async {
    try {
      if (isClosed) return;
      emit(MarketIndicesLoading());
      
      final result = await repository.getMarketIndices();

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(MarketIndicesError(failure.message));
        },
        (indices) {
          if (isClosed) return;
          emit(MarketIndicesLoaded(indices));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(MarketIndicesError('Failed to load market indices: ${e.toString()}'));
    }
  }

  Future<void> loadSectorPerformance() async {
    try {
      if (isClosed) return;
      emit(SectorPerformanceLoading());
      
      final result = await repository.getSectorPerformance();

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(SectorPerformanceError(failure.message));
        },
        (sectors) {
          if (isClosed) return;
          emit(SectorPerformanceLoaded(sectors));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(SectorPerformanceError('Failed to load sector performance: ${e.toString()}'));
    }
  }

  // Alert Methods
  Future<void> loadAlerts() async {
    try {
      if (isClosed) return;
      emit(AlertsLoading());
      
      final result = await repository.getAlerts();

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(AlertsError(failure.message));
        },
        (alerts) {
          if (isClosed) return;
          emit(AlertsLoaded(alerts));
        },
      );
    } catch (e) {
      if (isClosed) return;
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
      if (isClosed) return;
      emit(AlertCreating());
      
      final result = await repository.createAlert(
        symbol: symbol,
        type: type,
        targetValue: targetValue,
        condition: condition,
      );

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(AlertsError(failure.message));
        },
        (alert) {
          if (isClosed) return;
          emit(AlertCreated(alert));
        },
      );
    } catch (e) {
      if (isClosed) return;
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
      if (isClosed) return;
      emit(AlertUpdating());
      
      final result = await repository.updateAlert(
        alertId,
        type: type,
        targetValue: targetValue,
        condition: condition,
        isActive: isActive,
      );

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(AlertsError(failure.message));
        },
        (alert) {
          if (isClosed) return;
          emit(AlertUpdated(alert));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(AlertsError('Failed to update alert: ${e.toString()}'));
    }
  }

  Future<void> deleteAlert(String alertId) async {
    try {
      if (isClosed) return;
      emit(AlertDeleting());
      
      final result = await repository.deleteAlert(alertId);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(AlertsError(failure.message));
        },
        (_) {
          if (isClosed) return;
          emit(AlertDeleted(alertId));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(AlertsError('Failed to delete alert: ${e.toString()}'));
    }
  }

  // Trading Session Methods
  Future<void> loadTradingSession() async {
    try {
      if (isClosed) return;
      emit(TradingSessionLoading());
      
      final result = await repository.getCurrentTradingSession();

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(TradingSessionError(failure.message));
        },
        (session) {
          if (isClosed) return;
          emit(TradingSessionLoaded(session));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(TradingSessionError('Failed to load trading session: ${e.toString()}'));
    }
  }

  Future<void> startTradingSession(double startingBalance) async {
    try {
      if (isClosed) return;
      emit(TradingSessionStarting());
      
      final result = await repository.startTradingSession(startingBalance);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(TradingSessionError(failure.message));
        },
        (session) {
          if (isClosed) return;
          emit(TradingSessionStarted(session));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(TradingSessionError('Failed to start trading session: ${e.toString()}'));
    }
  }

  Future<void> endTradingSession(String sessionId) async {
    try {
      if (isClosed) return;
      emit(TradingSessionEnding());
      
      final result = await repository.endTradingSession(sessionId);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(TradingSessionError(failure.message));
        },
        (session) {
          if (isClosed) return;
          emit(TradingSessionEnded(session));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(TradingSessionError('Failed to end trading session: ${e.toString()}'));
    }
  }

  // Analysis Methods
  Future<void> loadStockAnalysis(String symbol) async {
    try {
      if (isClosed) return;
      emit(AnalysisLoading());
      
      final result = await repository.getStockAnalysis(symbol);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(AnalysisError(failure.message));
        },
        (analysis) {
          if (isClosed) return;
          emit(AnalysisLoaded(analysis));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(AnalysisError('Failed to load stock analysis: ${e.toString()}'));
    }
  }

  // Options Methods
  Future<void> loadOptions(String underlyingSymbol, {DateTime? expirationDate}) async {
    try {
      if (isClosed) return;
      emit(OptionsLoading());
      
      final result = await repository.getOptions(underlyingSymbol, expirationDate: expirationDate);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(OptionsError(failure.message));
        },
        (options) {
          if (isClosed) return;
          emit(OptionsLoaded(options));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(OptionsError('Failed to load options: ${e.toString()}'));
    }
  }

  // Dashboard Methods
  Future<void> loadDashboard() async {
    try {
      if (isClosed) return;
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

      if (isClosed) return;
      emit(StockDashboardLoaded(
        stocks: stocks,
        portfolio: portfolio,
        indices: indices,
        news: news,
        sectors: sectors,
      ));
    } catch (e) {
      if (isClosed) return;
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
    if (isClosed) return;
    emit(StockSearchLoaded([], ''));
  }

  void resetToInitial() {
    if (isClosed) return;
    emit(StockInitial());
  }

  void loadAnalystRatings(String symbol) async {
    try {
      // Simulate loading analyst ratings
      await Future.delayed(const Duration(milliseconds: 500));

      if (isClosed) return;

      // In a real implementation, you would fetch this data from your API
      final analystRatings = AnalystRatings(
        symbol: symbol,
        consensus: 'Hold',
        targetPrice: 299.38,
        buyRating: 48,
        holdRating: 31,
        sellRating: 21,
        analystCount: 48,
      );

      if (state is StockDetailsLoaded) {
        if (isClosed) return;
        final currentState = state as StockDetailsLoaded;
        emit(currentState.copyWith(analystRatings: analystRatings));
      }
    } catch (error) {
      if (isClosed) return;
      emit(StockError('Failed to load analyst ratings: $error'));
    }
  }

  void loadStockEvents(String symbol) async {
    try {
      // Simulate loading stock events
      await Future.delayed(const Duration(milliseconds: 300));

      if (isClosed) return;

      // In a real implementation, you would fetch this data from your API
      final events = [
        StockEvent(
          id: '1',
          title: 'Earnings Call',
          date: DateTime.now().add(const Duration(days: 15)),
          type: 'earnings',
          description: 'Quarterly earnings announcement',
        ),
        StockEvent(
          id: '2',
          title: 'Dividend Payment',
          date: DateTime.now().add(const Duration(days: 30)),
          type: 'dividend',
          description: 'Regular dividend payment',
        ),
      ];

      if (state is StockDetailsLoaded) {
        if (isClosed) return;
        final currentState = state as StockDetailsLoaded;
        emit(currentState.copyWith(events: events));
      }
    } catch (error) {
      if (isClosed) return;
      emit(StockError('Failed to load stock events: $error'));
    }
  }

  Future<void> loadStockChart(String symbol, String timeframe) async {
    try {
      // Don't emit loading state to avoid disrupting current UI
      // Just update the chart data
      
      // Mock implementation - replace with actual API call
      await Future.delayed(Duration(milliseconds: 500));
      
      // Generate mock chart data based on timeframe
      final chartData = _generateChartData(symbol, timeframe);
      
      // For now, we'll just complete the future since we're using mock data
      // In a real implementation, you would emit a new state with updated chart data

    } catch (e) {
      if (isClosed) return;
      emit(StockError('Failed to load chart data: $e'));
    }
  }

  List<StockPrice> _generateChartData(String symbol, String timeframe) {
    final now = DateTime.now();
    final prices = <StockPrice>[];
    
    // Determine number of data points and interval based on timeframe
    int dataPoints;
    Duration interval;
    
    switch (timeframe) {
      case '1m':
        dataPoints = 60;
        interval = Duration(minutes: 1);
        break;
      case '5m':
        dataPoints = 288; // 24 hours
        interval = Duration(minutes: 5);
        break;
      case '15m':
        dataPoints = 96; // 24 hours
        interval = Duration(minutes: 15);
        break;
      case '30m':
        dataPoints = 48; // 24 hours
        interval = Duration(minutes: 30);
        break;
      case '1H':
        dataPoints = 168; // 1 week
        interval = Duration(hours: 1);
        break;
      case '4H':
        dataPoints = 168; // 4 weeks
        interval = Duration(hours: 4);
        break;
      case '1D':
        dataPoints = 365; // 1 year
        interval = Duration(days: 1);
        break;
      case '1W':
        dataPoints = 104; // 2 years
        interval = Duration(days: 7);
        break;
      case '1M':
        dataPoints = 60; // 5 years
        interval = Duration(days: 30);
        break;
      default:
        dataPoints = 60;
        interval = Duration(days: 1);
    }
    
    double basePrice = 100.0; // Default base price
    
    for (int i = dataPoints; i >= 0; i--) {
      final date = now.subtract(interval * i);
      final variation = (i % 10 - 5) * 0.02; // Random variation
      final price = basePrice * (1 + variation);
      
      prices.add(StockPrice(
        timestamp: date,
        open: price * 0.99,
        high: price * 1.02,
        low: price * 0.98,
        close: price,
        volume: 1000000 + (i * 50000),
      ));
    }
    
    return prices;
  }
} 