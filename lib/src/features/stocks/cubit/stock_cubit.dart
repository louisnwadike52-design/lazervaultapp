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
        (stocks) => emit(StockLoaded(stocks)),
      );
    } catch (e) {
      emit(StockError('Failed to load stocks: ${e.toString()}'));
    }
  }

  Future<void> loadStockDetails(String symbol) async {
    try {
      emit(StockDetailsLoading());
      
      final stockResult = await repository.getStockDetails(symbol);
      final priceHistoryResult = await repository.getStockPriceHistory(symbol, '1M');
      
      stockResult.fold(
        (failure) => emit(StockDetailsError(failure.message)),
        (stock) {
          priceHistoryResult.fold(
            (failure) => emit(StockDetailsError(failure.message)),
            (priceHistory) => emit(StockDetailsLoaded(stock, priceHistory)),
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
        emit(StockSearchResults([], query));
        return;
      }
      
      emit(StockSearching());
      
      final result = await repository.searchStocks(query);
      
      result.fold(
        (failure) => emit(StockSearchError(failure.message)),
        (stocks) => emit(StockSearchResults(stocks, query)),
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
      emit(StockLoading());
      
      final result = await repository.getHoldings();
      
      result.fold(
        (failure) => emit(StockError(failure.message)),
        (holdings) {
          // Convert holdings to stocks for display
          final stocks = holdings.map((holding) => Stock(
            symbol: holding.symbol,
            name: holding.name,
            currentPrice: holding.currentPrice,
            previousClose: holding.currentPrice - holding.dayChange,
            change: holding.dayChange,
            changePercent: holding.dayChangePercent,
            dayHigh: holding.currentPrice + 5.0, // Mock data
            dayLow: holding.currentPrice - 5.0, // Mock data
            volume: 1000000, // Mock data
            marketCap: 1000000000, // Mock data
            peRatio: 25.0, // Mock data
            dividendYield: 2.0, // Mock data
            sector: 'Technology', // Mock data
            industry: 'Software', // Mock data
            logoUrl: 'https://logo.clearbit.com/${holding.symbol.toLowerCase()}.com',
            priceHistory: [], // Empty for now
            lastUpdated: DateTime.now(),
          )).toList();
          emit(StockLoaded(stocks));
        },
      );
    } catch (e) {
      emit(StockError('Failed to load holdings: ${e.toString()}'));
    }
  }

  // Trading Methods
  Future<void> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
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

  Future<void> createWatchlist(String name) async {
    try {
      emit(WatchlistCreating());
      
      final result = await repository.createWatchlist(name);
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (watchlist) => emit(WatchlistCreated(watchlist)),
      );
    } catch (e) {
      emit(WatchlistsError('Failed to create watchlist: ${e.toString()}'));
    }
  }

  Future<void> addToWatchlist(String watchlistId, String symbol) async {
    try {
      emit(WatchlistUpdating());
      
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
      emit(WatchlistUpdating());
      
      final result = await repository.removeFromWatchlist(watchlistId, symbol);
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (watchlist) => emit(WatchlistUpdated(watchlist)),
      );
    } catch (e) {
      emit(WatchlistsError('Failed to remove from watchlist: ${e.toString()}'));
    }
  }

  Future<void> deleteWatchlist(String watchlistId) async {
    try {
      emit(WatchlistUpdating());
      
      final result = await repository.deleteWatchlist(watchlistId);
      
      result.fold(
        (failure) => emit(WatchlistsError(failure.message)),
        (_) {
          // Reload watchlists after deletion
          loadWatchlists();
        },
      );
    } catch (e) {
      emit(WatchlistsError('Failed to delete watchlist: ${e.toString()}'));
    }
  }

  // Market Data Methods
  Future<void> loadMarketNews({String? symbol, int page = 1, int limit = 20}) async {
    try {
      emit(MarketNewsLoading());
      
      final result = await repository.getMarketNews(
        symbol: symbol,
        page: page,
        limit: limit,
      );
      
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
        (failure) => emit(StockError(failure.message)),
        (indices) => emit(MarketIndicesLoaded(indices)),
      );
    } catch (e) {
      emit(StockError('Failed to load market indices: ${e.toString()}'));
    }
  }

  Future<void> loadSectorPerformance() async {
    try {
      emit(SectorPerformanceLoading());
      
      final result = await repository.getSectorPerformance();
      
      result.fold(
        (failure) => emit(StockError(failure.message)),
        (sectors) => emit(SectorPerformanceLoaded(sectors)),
      );
    } catch (e) {
      emit(StockError('Failed to load sector performance: ${e.toString()}'));
    }
  }

  // Utility Methods
  void resetState() {
    emit(StockInitial());
  }

  void clearSearch() {
    emit(StockSearchResults([], ''));
  }
} 