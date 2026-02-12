import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/cache/cache_config.dart';
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
  final SWRCacheManager? cacheManager;

  StockCubit({
    required this.getStocksUseCase,
    required this.getPortfolioUseCase,
    required this.placeOrderUseCase,
    required this.getWatchlistsUseCase,
    required this.repository,
    this.cacheManager,
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

      if (cacheManager != null && searchQuery == null) {
        final cacheKey = 'stocks:${sector ?? 'all'}:$page:$limit';
        await for (final result in cacheManager!.get<List<Stock>>(
          key: cacheKey,
          fetcher: () async {
            final either = await getStocksUseCase(
              sector: sector,
              searchQuery: searchQuery,
              page: page,
              limit: limit,
            );
            return either.fold(
              (failure) => throw Exception(failure.message),
              (stocks) => stocks,
            );
          },
          config: CacheConfig.stocks,
          serializer: (stocks) =>
              jsonEncode(stocks.map((s) => s.toJson()).toList()),
          deserializer: (json) => (jsonDecode(json) as List)
              .map((j) => Stock.fromJson(j as Map<String, dynamic>))
              .toList(),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            emit(StockLoaded(result.data!, sector: sector, isStale: result.isStale));
          } else if (result.hasError) {
            emit(StockError(result.error.toString()));
          }
        }
        return;
      }

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

      if (cacheManager != null) {
        await for (final result in cacheManager!.get<Portfolio>(
          key: 'portfolio',
          fetcher: () async {
            final either = await getPortfolioUseCase();
            return either.fold(
              (failure) => throw Exception(failure.message),
              (portfolio) => portfolio,
            );
          },
          config: CacheConfig.portfolio,
          serializer: (portfolio) => jsonEncode(portfolio.toJson()),
          deserializer: (json) =>
              Portfolio.fromJson(jsonDecode(json) as Map<String, dynamic>),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            emit(PortfolioLoaded(result.data!, isStale: result.isStale));
          } else if (result.hasError) {
            emit(PortfolioError(result.error.toString()));
          }
        }
        return;
      }

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

      if (cacheManager != null) {
        await for (final result in cacheManager!.get<List<StockHolding>>(
          key: 'holdings',
          fetcher: () async {
            final either = await repository.getHoldings();
            return either.fold(
              (failure) => throw Exception(failure.message),
              (holdings) => holdings,
            );
          },
          config: CacheConfig.holdings,
          serializer: (holdings) =>
              jsonEncode(holdings.map((h) => h.toJson()).toList()),
          deserializer: (json) => (jsonDecode(json) as List)
              .map((j) => StockHolding.fromJson(j as Map<String, dynamic>))
              .toList(),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            emit(HoldingsLoaded(result.data!, isStale: result.isStale));
          } else if (result.hasError) {
            emit(HoldingsError(result.error.toString()));
          }
        }
        return;
      }

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
      // Input validation
      if (symbol.isEmpty || !RegExp(r'^[A-Z0-9.]{1,10}$').hasMatch(symbol)) {
        emit(const OrderFailed(message: 'Invalid stock symbol'));
        return;
      }
      if (quantity <= 0 || quantity > 100000) {
        emit(const OrderFailed(message: 'Quantity must be between 1 and 100,000'));
        return;
      }
      if (price != null && (price <= 0 || price > 1000000)) {
        emit(const OrderFailed(message: 'Invalid price'));
        return;
      }

      if (isClosed) return;
      emit(const OrderProcessing(step: 'Placing order...', progress: 0.5));

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
          emit(OrderFailed(message: failure.message));
        },
        (order) {
          if (isClosed) return;
          final action = side == OrderSide.buy ? 'purchased' : 'sold';
          emit(OrderSuccess(
            order: order,
            message: 'Successfully $action $quantity shares of $symbol',
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(OrderFailed(message: 'Failed to place order: ${e.toString()}'));
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
    // Analyst ratings not yet available from backend
    // Will be populated when the analysis API endpoint is extended
  }

  void loadStockEvents(String symbol) async {
    // Stock events not yet available from backend
    // Will be populated when the events API endpoint is added
  }

  Future<void> loadStockChart(String symbol, String timeframe) async {
    try {
      final result = await repository.getStockPriceHistory(symbol, timeframe);

      result.fold(
        (failure) {
          if (isClosed) return;
          emit(StockError('Failed to load chart data: ${failure.message}'));
        },
        (priceHistory) {
          if (state is StockDetailsLoaded) {
            if (isClosed) return;
            final currentState = state as StockDetailsLoaded;
            emit(currentState.copyWith(priceHistory: priceHistory));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(StockError('Failed to load chart data: $e'));
    }
  }
} 