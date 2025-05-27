import 'package:dartz/dartz.dart';
import '../../domain/entities/stock_entity.dart';
import '../../domain/repositories/i_stock_repository.dart';
import '../datasources/stock_remote_data_source.dart';
import '../../../../core/errors/failures.dart';

class StockRepositoryImpl implements IStockRepository {
  final IStockRemoteDataSource remoteDataSource;

  StockRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Stock>>> getStocks({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final stocks = await remoteDataSource.getStocks(
        sector: sector,
        searchQuery: searchQuery,
        page: page,
        limit: limit,
      );
      return Right(stocks);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Stock>> getStockDetails(String symbol) async {
    try {
      final stock = await remoteDataSource.getStockDetails(symbol);
      return Right(stock);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<StockPrice>>> getStockPriceHistory(
    String symbol,
    String timeframe,
  ) async {
    try {
      final priceHistory = await remoteDataSource.getStockPriceHistory(symbol, timeframe);
      return Right(priceHistory);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<Stock>>> getTopMovers() async {
    try {
      final stocks = await remoteDataSource.getTopMovers();
      return Right(stocks);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<Stock>>> searchStocks(String query) async {
    try {
      final stocks = await remoteDataSource.searchStocks(query);
      return Right(stocks);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Portfolio>> getPortfolio() async {
    try {
      final portfolio = await remoteDataSource.getPortfolio();
      return Right(portfolio);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<StockHolding>>> getHoldings() async {
    try {
      final holdings = await remoteDataSource.getHoldings();
      return Right(holdings);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, StockOrder>> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
  }) async {
    try {
      final order = await remoteDataSource.placeOrder(
        symbol: symbol,
        type: type,
        side: side,
        quantity: quantity,
        price: price,
      );
      return Right(order);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<StockOrder>>> getOrders({
    OrderStatus? status,
    String? symbol,
  }) async {
    try {
      final orders = await remoteDataSource.getOrders(status: status, symbol: symbol);
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, StockOrder>> cancelOrder(String orderId) async {
    try {
      final order = await remoteDataSource.cancelOrder(orderId);
      return Right(order);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<Watchlist>>> getWatchlists() async {
    try {
      final watchlists = await remoteDataSource.getWatchlists();
      return Right(watchlists);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Watchlist>> createWatchlist(String name) async {
    try {
      final watchlist = await remoteDataSource.createWatchlist(name);
      return Right(watchlist);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Watchlist>> addToWatchlist(String watchlistId, String symbol) async {
    try {
      final watchlist = await remoteDataSource.addToWatchlist(watchlistId, symbol);
      return Right(watchlist);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Watchlist>> removeFromWatchlist(String watchlistId, String symbol) async {
    try {
      final watchlist = await remoteDataSource.removeFromWatchlist(watchlistId, symbol);
      return Right(watchlist);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWatchlist(String watchlistId) async {
    try {
      await remoteDataSource.deleteWatchlist(watchlistId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<MarketNews>>> getMarketNews({
    String? symbol,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final news = await remoteDataSource.getMarketNews(
        symbol: symbol,
        page: page,
        limit: limit,
      );
      return Right(news);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getMarketIndices() async {
    try {
      final indices = await remoteDataSource.getMarketIndices();
      return Right(indices);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getSectorPerformance() async {
    try {
      final sectors = await remoteDataSource.getSectorPerformance();
      return Right(sectors);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
} 