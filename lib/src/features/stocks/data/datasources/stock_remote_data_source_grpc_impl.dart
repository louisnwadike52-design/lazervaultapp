import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/grpc/grpc_channel_manager.dart';
import 'package:lazervault/src/generated/stocks/stock.pbgrpc.dart' hide OrderType, OrderSide, OrderStatus, PricePoint;
import 'package:lazervault/src/generated/stocks/stock.pbenum.dart' as stockspb_enums;
import '../models/stock_model.dart';
import '../../domain/entities/stock_entity.dart';
import '../../domain/entities/price_point.dart';
import 'stock_remote_data_source.dart';

/// gRPC implementation of stock data source using native gRPC protocol
class StockRemoteDataSourceGrpcImpl implements IStockRemoteDataSource {
  final GrpcChannelManager channelManager;

  late final StockServiceClient _stockClient;
  late final StocksPortfolioServiceClient _portfolioClient;
  late final OrderServiceClient _orderClient;
  late final WatchlistServiceClient _watchlistClient;

  StockRemoteDataSourceGrpcImpl({
    required this.channelManager,
  }) {
    _stockClient = StockServiceClient(channelManager.channel);
    _portfolioClient = StocksPortfolioServiceClient(channelManager.channel);
    _orderClient = OrderServiceClient(channelManager.channel);
    _watchlistClient = WatchlistServiceClient(channelManager.channel);
  }

  @override
  Future<List<StockModel>> getStocks({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = GetStocksRequest()
        ..page = page
        ..perPage = limit;

      final response = await _stockClient.getStocks(
        request,
        options: channelManager.getCallOptions(),
      );

      return response.stocks
          .map((stock) => _convertStockMessageToModel(stock))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching stocks via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<StockModel> getStockDetails(String symbol) async {
    try {
      final request = GetStockRequest()..symbol = symbol.toUpperCase();

      final response = await _stockClient.getStock(
        request,
        options: channelManager.getCallOptions(),
      );

      return _convertStockMessageToModel(response.stock);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Stock with symbol $symbol not found');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching stock details via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockPriceModel>> getStockPriceHistory(
    String symbol,
    String timeframe,
  ) async {
    try {
      final request = GetStockPriceHistoryRequest()
        ..symbol = symbol.toUpperCase()
        ..timeframe = _convertTimeframeToEnum(timeframe)
        ..interval = '1d';

      final response = await _stockClient.getStockPriceHistory(
        request,
        options: channelManager.getCallOptions(),
      );

      return response.priceHistory
          .map((pricePoint) => StockPriceModel(
                timestamp: pricePoint.timestamp.toDateTime(),
                open: pricePoint.open,
                high: pricePoint.high,
                low: pricePoint.low,
                close: pricePoint.close,
                volume: pricePoint.volume,
              ))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching price history via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockModel>> getTopMovers() async {
    try {
      // Get both gainers and losers
      final gainers = await _getTopGainers();
      final losers = await _getTopLosers();

      // Combine and sort by absolute change
      final allMovers = [...gainers, ...losers];
      allMovers.sort((a, b) => b.changePercent.abs().compareTo(a.changePercent.abs()));

      return allMovers;
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching top movers via gRPC: $e');
      rethrow;
    }
  }

  Future<List<StockModel>> _getTopGainers() async {
    final request = GetTopGainersRequest()..limit = 10;
    final response = await _stockClient.getTopGainers(
      request,
      options: channelManager.getCallOptions(),
    );
    return response.stocks
        .map((stock) => _convertStockMessageToModel(stock))
        .toList();
  }

  Future<List<StockModel>> _getTopLosers() async {
    final request = GetTopLosersRequest()..limit = 10;
    final response = await _stockClient.getTopLosers(
      request,
      options: channelManager.getCallOptions(),
    );
    return response.stocks
        .map((stock) => _convertStockMessageToModel(stock))
        .toList();
  }

  @override
  Future<List<StockModel>> searchStocks(String query) async {
    try {
      final request = SearchStocksRequest()
        ..query = query
        ..limit = 10;

      final response = await _stockClient.searchStocks(
        request,
        options: channelManager.getCallOptions(),
      );

      return response.stocks
          .map((stock) => _convertStockMessageToModel(stock))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error searching stocks via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<PortfolioModel> getPortfolio() async {
    try {
      final request = GetUserPortfolioRequest();

      final response = await _portfolioClient.getUserPortfolio(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return _convertPortfolioMessageToModel(response.portfolio);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching portfolio via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockHoldingModel>> getHoldings() async {
    try {
      final portfolio = await getPortfolio();
      return portfolio.holdings.cast<StockHoldingModel>();
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching holdings via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<StockOrderModel> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
  }) async {
    try {
      final request = PlaceOrderRequest()
        ..symbol = symbol.toUpperCase()
        ..type = _convertOrderTypeToProto(type)
        ..side = _convertOrderSideToProto(side)
        ..quantity = quantity;

      if (price != null) {
        request.price = price;
      }

      final response = await _orderClient.placeOrder(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return _convertOrderMessageToModel(response.order);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error placing order via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockOrderModel>> getOrders({
    OrderStatus? status,
    String? symbol,
  }) async {
    try {
      final request = GetUserOrdersRequest()
        ..page = 1
        ..perPage = 50;

      if (status != null) {
        request.status = _convertOrderStatusToProto(status);
      }

      final response = await _orderClient.getUserOrders(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return response.orders
          .map((order) => _convertOrderMessageToModel(order))
          .toList();
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching orders via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<StockOrderModel> cancelOrder(String orderId) async {
    try {
      final request = CancelOrderRequest()..orderId = orderId;

      final response = await _orderClient.cancelOrder(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return _convertOrderMessageToModel(response.order);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error canceling order via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<List<WatchlistModel>> getWatchlists() async {
    try {
      final request = GetUserWatchlistsRequest();

      final response = await _watchlistClient.getUserWatchlists(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return response.watchlists
          .map((watchlist) => _convertWatchlistMessageToModel(watchlist))
          .toList();
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching watchlists via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<WatchlistModel> createWatchlist(String name, List<String> symbols) async {
    try {
      final request = CreateWatchlistRequest()
        ..name = name
        ..symbols.addAll(symbols.map((s) => s.toUpperCase()))
        ..isDefault = false;

      final response = await _watchlistClient.createWatchlist(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return _convertWatchlistMessageToModel(response.watchlist);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error creating watchlist via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<WatchlistModel> updateWatchlist(String watchlistId, String name, List<String> symbols) async {
    try {
      final request = UpdateWatchlistRequest()
        ..watchlistId = watchlistId
        ..name = name
        ..isDefault = false;

      final response = await _watchlistClient.updateWatchlist(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return _convertWatchlistMessageToModel(response.watchlist);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error updating watchlist via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<WatchlistModel> addToWatchlist(String watchlistId, String symbol) async {
    try {
      final request = AddStockToWatchlistRequest()
        ..watchlistId = watchlistId
        ..symbol = symbol.toUpperCase();

      final response = await _watchlistClient.addStockToWatchlist(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return _convertWatchlistMessageToModel(response.watchlist);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error adding to watchlist via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<WatchlistModel> removeFromWatchlist(String watchlistId, String symbol) async {
    try {
      final request = RemoveStockFromWatchlistRequest()
        ..watchlistId = watchlistId
        ..symbol = symbol.toUpperCase();

      final response = await _watchlistClient.removeStockFromWatchlist(
        request,
        options: await channelManager.getAuthCallOptions(),
      );

      return _convertWatchlistMessageToModel(response.watchlist);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error removing from watchlist via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteWatchlist(String watchlistId) async {
    try {
      final request = DeleteWatchlistRequest()..watchlistId = watchlistId;

      await _watchlistClient.deleteWatchlist(
        request,
        options: await channelManager.getAuthCallOptions(),
      );
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error deleting watchlist via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, double>> getMarketIndices() async {
    try {
      final request = GetMarketIndicesRequest();

      final response = await _stockClient.getMarketIndices(
        request,
        options: channelManager.getCallOptions(),
      );

      final Map<String, double> result = {};
      for (var index in response.indices) {
        result[index.name] = index.value;
      }
      return result;
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching market indices via gRPC: $e');
      rethrow;
    }
  }

  // Not yet implemented in microservice - return empty lists
  @override
  Future<List<MarketNewsModel>> getMarketNews({
    NewsCategory? category,
    List<String>? symbols,
    int page = 1,
    int limit = 20,
  }) async {
    return [];
  }

  @override
  Future<List<SectorPerformanceModel>> getSectorPerformance() async {
    return [];
  }

  @override
  Future<List<StockAlertModel>> getAlerts() async {
    return [];
  }

  @override
  Future<StockAlertModel> createAlert({
    required String symbol,
    required AlertType type,
    required double targetValue,
    required AlertCondition condition,
  }) async {
    throw Exception('Price alerts are coming soon');
  }

  @override
  Future<StockAlertModel> updateAlert(
    String alertId, {
    AlertType? type,
    double? targetValue,
    AlertCondition? condition,
    bool? isActive,
  }) async {
    throw Exception('Price alerts are coming soon');
  }

  @override
  Future<void> deleteAlert(String alertId) async {
    throw Exception('Price alerts are coming soon');
  }

  @override
  Future<StockAnalysisModel> getStockAnalysis(String symbol) async {
    // Return a basic analysis based on available stock data
    return StockAnalysisModel(
      symbol: symbol,
      rating: AnalysisRating.hold,
      targetPrice: 0,
      stopLoss: 0,
      technicalIndicators: [],
      fundamentalMetrics: [],
      summary: 'Detailed analysis is coming soon.',
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<TradingSessionModel> getCurrentTradingSession() async {
    throw Exception('Trading sessions are coming soon');
  }

  @override
  Future<TradingSessionModel> startTradingSession(double startingBalance) async {
    throw Exception('Trading sessions are coming soon');
  }

  @override
  Future<TradingSessionModel> endTradingSession(String sessionId) async {
    throw Exception('Trading sessions are coming soon');
  }

  @override
  Future<List<TradingSessionModel>> getTradingSessionHistory() async {
    return [];
  }

  @override
  Future<List<OptionContractModel>> getOptions(
    String underlyingSymbol, {
    DateTime? expirationDate,
    OptionType? type,
  }) async {
    return [];
  }

  @override
  Future<OptionContractModel> getOptionDetails(String optionSymbol) async {
    throw Exception('Options trading is coming soon');
  }

  @override
  Future<List<StockModel>> getRecommendations() async {
    return _getTopGainers();
  }

  @override
  Future<List<StockModel>> getTrendingStocks() async {
    return getTopMovers();
  }

  @override
  Future<Map<String, dynamic>> getMarketStatus() async {
    return {
      'marketOpen': true,
      'tradingSession': 'regular',
      'sessionStartTime': DateTime.now().subtract(const Duration(hours: 1)),
      'sessionEndTime': DateTime.now().add(const Duration(hours: 3)),
    };
  }

  @override
  Future<List<StockModel>> getEarningsCalendar({DateTime? date}) async {
    return [];
  }

  @override
  Future<List<StockModel>> getDividendCalendar({DateTime? date}) async {
    return [];
  }

  // Helper conversion methods
  StockModel _convertStockMessageToModel(StockMessage msg) {
    return StockModel(
      symbol: msg.symbol,
      name: msg.name,
      currentPrice: msg.currentPrice,
      previousClose: msg.previousClose,
      change: msg.change,
      changePercent: msg.changePercent,
      dayHigh: msg.dayHigh,
      dayLow: msg.dayLow,
      volume: msg.volume,
      marketCap: msg.marketCap,
      peRatio: msg.peRatio,
      dividendYield: msg.dividendYield,
      sector: msg.sector.isNotEmpty ? msg.sector : '',
      industry: msg.industry.isNotEmpty ? msg.industry : '',
      logoUrl: msg.logoUrl.isNotEmpty ? msg.logoUrl : '',
      priceHistory: msg.priceHistory
          .map((p) => PricePoint(
                timestamp: p.timestamp.toDateTime(),
                price: p.close,
                volume: p.volume,
              ))
          .toList(),
      lastUpdated: msg.hasLastUpdated() ? msg.lastUpdated.toDateTime() : DateTime.now(),
      weekHigh52: msg.weekHigh52,
      weekLow52: msg.weekLow52,
      avgVolume: msg.avgVolume,
      beta: msg.beta,
      eps: msg.eps,
      description: msg.description.isNotEmpty ? msg.description : '',
      exchange: msg.exchange.isNotEmpty ? msg.exchange : '',
      currency: msg.currency.isNotEmpty ? msg.currency : 'USD',
    );
  }

  PortfolioModel _convertPortfolioMessageToModel(PortfolioMessage msg) {
    return PortfolioModel(
      id: msg.id,
      totalValue: msg.totalValue,
      totalCost: msg.totalCost,
      totalReturn: msg.totalReturn,
      totalReturnPercent: msg.totalReturnPercent,
      dayChange: msg.dayChange,
      dayChangePercent: msg.dayChangePercent,
      holdings: msg.holdings
          .map((h) => StockHoldingModel(
                symbol: h.symbol,
                name: h.name,
                shares: h.shares,
                averageCost: h.averageCost,
                currentPrice: h.currentPrice,
                totalValue: h.totalValue,
                totalReturn: h.totalReturn,
                totalReturnPercent: h.totalReturnPercent,
                dayChange: h.dayChange,
                dayChangePercent: h.dayChangePercent,
                purchaseDate: h.hasPurchaseDate() ? h.purchaseDate.toDateTime() : DateTime.now(),
                logoUrl: h.logoUrl.isNotEmpty ? h.logoUrl : '',
              ))
          .toList(),
      lastUpdated: msg.hasLastUpdated() ? msg.lastUpdated.toDateTime() : DateTime.now(),
      availableCash: msg.availableCash,
      totalInvested: msg.totalInvested,
    );
  }

  StockOrderModel _convertOrderMessageToModel(OrderMessage msg) {
    return StockOrderModel(
      id: msg.id,
      symbol: msg.symbol,
      type: _convertProtoToOrderType(msg.type),
      side: _convertProtoToOrderSide(msg.side),
      quantity: msg.quantity,
      price: msg.price,
      status: _convertProtoToOrderStatus(msg.status),
      createdAt: msg.hasCreatedAt() ? msg.createdAt.toDateTime() : DateTime.now(),
      executedAt: msg.hasExecutedAt() ? msg.executedAt.toDateTime() : null,
      executedPrice: msg.executedPrice,
      executedQuantity: msg.executedQuantity,
      fees: msg.fees,
      notes: msg.notes.isNotEmpty ? msg.notes : '',
    );
  }

  WatchlistModel _convertWatchlistMessageToModel(WatchlistMessage msg) {
    return WatchlistModel(
      id: msg.id,
      name: msg.name,
      symbols: msg.stocks.map((s) => s.symbol).toList(),
      createdAt: msg.hasCreatedAt() ? msg.createdAt.toDateTime() : DateTime.now(),
      lastUpdated: msg.hasUpdatedAt() ? msg.updatedAt.toDateTime() : DateTime.now(),
      isDefault: msg.isDefault,
    );
  }

  TimeFrame _convertTimeframeToEnum(String timeframe) {
    switch (timeframe.toLowerCase()) {
      case '1d':
        return TimeFrame.TIME_FRAME_1D;
      case '5d':
        return TimeFrame.TIME_FRAME_5D;
      case '1m':
        return TimeFrame.TIME_FRAME_1M;
      case '3m':
        return TimeFrame.TIME_FRAME_3M;
      case '6m':
        return TimeFrame.TIME_FRAME_6M;
      case '1y':
        return TimeFrame.TIME_FRAME_1Y;
      case '5y':
        return TimeFrame.TIME_FRAME_5Y;
      case 'all':
        return TimeFrame.TIME_FRAME_ALL;
      default:
        return TimeFrame.TIME_FRAME_1M;
    }
  }

  stockspb_enums.OrderType _convertOrderTypeToProto(OrderType type) {
    switch (type) {
      case OrderType.market:
        return stockspb_enums.OrderType.ORDER_TYPE_MARKET;
      case OrderType.limit:
        return stockspb_enums.OrderType.ORDER_TYPE_LIMIT;
      case OrderType.stopLoss:
        return stockspb_enums.OrderType.ORDER_TYPE_STOP_LOSS;
      case OrderType.stopLimit:
        return stockspb_enums.OrderType.ORDER_TYPE_STOP_LIMIT;
    }
  }

  stockspb_enums.OrderSide _convertOrderSideToProto(OrderSide side) {
    switch (side) {
      case OrderSide.buy:
        return stockspb_enums.OrderSide.ORDER_SIDE_BUY;
      case OrderSide.sell:
        return stockspb_enums.OrderSide.ORDER_SIDE_SELL;
    }
  }

  stockspb_enums.OrderStatus _convertOrderStatusToProto(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return stockspb_enums.OrderStatus.ORDER_STATUS_PENDING;
      case OrderStatus.executed:
        return stockspb_enums.OrderStatus.ORDER_STATUS_EXECUTED;
      case OrderStatus.cancelled:
        return stockspb_enums.OrderStatus.ORDER_STATUS_CANCELLED;
      case OrderStatus.rejected:
        return stockspb_enums.OrderStatus.ORDER_STATUS_REJECTED;
      case OrderStatus.partiallyFilled:
        return stockspb_enums.OrderStatus.ORDER_STATUS_PARTIALLY_FILLED;
    }
  }

  OrderType _convertProtoToOrderType(stockspb_enums.OrderType type) {
    switch (type) {
      case stockspb_enums.OrderType.ORDER_TYPE_MARKET:
        return OrderType.market;
      case stockspb_enums.OrderType.ORDER_TYPE_LIMIT:
        return OrderType.limit;
      case stockspb_enums.OrderType.ORDER_TYPE_STOP_LOSS:
        return OrderType.stopLoss;
      case stockspb_enums.OrderType.ORDER_TYPE_STOP_LIMIT:
        return OrderType.stopLimit;
      default:
        return OrderType.market;
    }
  }

  OrderSide _convertProtoToOrderSide(stockspb_enums.OrderSide side) {
    switch (side) {
      case stockspb_enums.OrderSide.ORDER_SIDE_BUY:
        return OrderSide.buy;
      case stockspb_enums.OrderSide.ORDER_SIDE_SELL:
        return OrderSide.sell;
      default:
        return OrderSide.buy;
    }
  }

  OrderStatus _convertProtoToOrderStatus(stockspb_enums.OrderStatus status) {
    switch (status) {
      case stockspb_enums.OrderStatus.ORDER_STATUS_PENDING:
        return OrderStatus.pending;
      case stockspb_enums.OrderStatus.ORDER_STATUS_EXECUTED:
        return OrderStatus.executed;
      case stockspb_enums.OrderStatus.ORDER_STATUS_CANCELLED:
        return OrderStatus.cancelled;
      case stockspb_enums.OrderStatus.ORDER_STATUS_REJECTED:
        return OrderStatus.rejected;
      case stockspb_enums.OrderStatus.ORDER_STATUS_PARTIALLY_FILLED:
        return OrderStatus.partiallyFilled;
      default:
        return OrderStatus.pending;
    }
  }
}
