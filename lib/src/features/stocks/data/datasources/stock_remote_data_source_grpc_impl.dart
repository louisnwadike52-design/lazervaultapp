import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/grpc/grpc_channel_manager.dart';
import 'package:lazervault/src/generated/stocks/stock.pbgrpc.dart' hide OrderType, OrderSide, OrderStatus, PricePoint, AlertType;
import 'package:lazervault/src/generated/stocks/stock.pbenum.dart' as stockspb_enums;
import 'package:lazervault/src/generated/investments.pbgrpc.dart' as investmentspb;
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
  late final investmentspb.InvestmentsServiceClient _investmentsClient;

  StockRemoteDataSourceGrpcImpl({
    required this.channelManager,
  }) {
    _stockClient = StockServiceClient(channelManager.channel);
    _portfolioClient = StocksPortfolioServiceClient(channelManager.channel);
    _orderClient = OrderServiceClient(channelManager.channel);
    _watchlistClient = WatchlistServiceClient(channelManager.channel);
    _investmentsClient = investmentspb.InvestmentsServiceClient(channelManager.channel);
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
  Future<List<StockModel>> getTopMovers({String? market}) async {
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
  Future<List<StockModel>> searchStocks(String query, {String? market}) async {
    try {
      final request = SearchStocksRequest()
        ..query = query
        ..limit = 10;
      if (market != null && market.isNotEmpty) {
        request.market = market;
      }

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

  @override
  Future<List<MarketNewsModel>> getMarketNews({
    NewsCategory? category,
    List<String>? symbols,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = investmentspb.GetMarketNewsRequest(
        limit: limit,
        page: page,
      );
      if (category != null) {
        request.category = category.toString().split('.').last;
      }
      if (symbols != null && symbols.isNotEmpty) {
        request.symbols.addAll(symbols);
      }

      final response = await _investmentsClient.getMarketNews(
        request,
        options: channelManager.getCallOptions(),
      );

      return response.articles.map((article) => MarketNewsModel(
        id: article.id,
        title: article.title,
        summary: article.summary,
        content: article.content,
        source: article.source,
        imageUrl: article.imageUrl,
        relatedSymbols: List<String>.from(article.relatedSymbols),
        publishedAt: article.publishedAt.isNotEmpty
            ? DateTime.tryParse(article.publishedAt) ?? DateTime.now()
            : DateTime.now(),
        url: article.url,
        category: NewsCategory.values.firstWhere(
          (e) => e.toString().split('.').last == article.category,
          orElse: () => NewsCategory.market,
        ),
        readTime: article.readTime > 0 ? article.readTime : 5,
      )).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching market news via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<List<SectorPerformanceModel>> getSectorPerformance() async {
    try {
      final request = investmentspb.GetSectorPerformanceRequest();

      final response = await _investmentsClient.getSectorPerformance(
        request,
        options: channelManager.getCallOptions(),
      );

      return response.sectors.map((sector) => SectorPerformanceModel(
        sector: sector.sector,
        change: sector.change,
        changePercent: sector.changePercent,
        marketCap: sector.marketCap,
        topStocks: List<String>.from(sector.topStocks),
      )).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching sector performance via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockAlertModel>> getAlerts() async {
    try {
      final request = investmentspb.GetPriceAlertsRequest();

      final response = await _investmentsClient.getPriceAlerts(
        request,
        options: channelManager.getCallOptions(),
      );

      return response.alerts.map((alert) => _convertPriceAlertToModel(alert)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching price alerts via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<StockAlertModel> createAlert({
    required String symbol,
    required AlertType type,
    required double targetValue,
    required AlertCondition condition,
  }) async {
    try {
      final request = investmentspb.CreatePriceAlertRequest(
        symbol: symbol,
        alertType: type.toString().split('.').last,
        targetValue: targetValue,
        condition: condition.toString().split('.').last,
      );

      final response = await _investmentsClient.createPriceAlert(
        request,
        options: channelManager.getCallOptions(),
      );

      return _convertPriceAlertToModel(response.alert);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error creating price alert via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<StockAlertModel> updateAlert(
    String alertId, {
    AlertType? type,
    double? targetValue,
    AlertCondition? condition,
    bool? isActive,
  }) async {
    try {
      final request = investmentspb.UpdatePriceAlertRequest(
        alertId: alertId,
      );
      if (type != null) {
        request.alertType = type.toString().split('.').last;
      }
      if (targetValue != null) {
        request.targetValue = targetValue;
      }
      if (condition != null) {
        request.condition = condition.toString().split('.').last;
      }
      if (isActive != null) {
        request.isActive = isActive;
      }

      final response = await _investmentsClient.updatePriceAlert(
        request,
        options: channelManager.getCallOptions(),
      );

      return _convertPriceAlertToModel(response.alert);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error updating price alert via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteAlert(String alertId) async {
    try {
      final request = investmentspb.DeletePriceAlertRequest(
        alertId: alertId,
      );

      await _investmentsClient.deletePriceAlert(
        request,
        options: channelManager.getCallOptions(),
      );
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error deleting price alert via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<StockAnalysisModel> getStockAnalysis(String symbol) async {
    try {
      final stock = await getStockDetails(symbol);

      // Derive rating from fundamental metrics
      AnalysisRating rating = AnalysisRating.hold;
      if (stock.peRatio > 0 && stock.peRatio < 15 && stock.changePercent > 0) {
        rating = AnalysisRating.buy;
      } else if (stock.peRatio > 0 && stock.peRatio < 10) {
        rating = AnalysisRating.strongBuy;
      } else if (stock.peRatio > 40 && stock.changePercent < -2) {
        rating = AnalysisRating.sell;
      }

      // Calculate target price from 52-week data
      final targetPrice = stock.weekHigh52 > 0
          ? stock.currentPrice + (stock.weekHigh52 - stock.currentPrice) * 0.5
          : stock.currentPrice * 1.1;

      // Calculate stop loss from 52-week low
      final stopLoss = stock.weekLow52 > 0
          ? stock.weekLow52
          : stock.currentPrice * 0.9;

      // Build fundamental metrics from available data
      final fundamentalMetrics = <FundamentalMetric>[];
      if (stock.peRatio > 0) {
        fundamentalMetrics.add(FundamentalMetric(
          name: 'P/E Ratio',
          value: stock.peRatio,
          unit: 'x',
          description: stock.peRatio < 20 ? 'Below average — potentially undervalued' : 'Above average — higher growth expectations',
        ));
      }
      if (stock.dividendYield > 0) {
        fundamentalMetrics.add(FundamentalMetric(
          name: 'Dividend Yield',
          value: stock.dividendYield,
          unit: '%',
          description: '${stock.dividendYield.toStringAsFixed(2)}% annual yield',
        ));
      }
      if (stock.eps > 0) {
        fundamentalMetrics.add(FundamentalMetric(
          name: 'EPS',
          value: stock.eps,
          unit: 'USD',
          description: 'Earnings per share: \$${stock.eps.toStringAsFixed(2)}',
        ));
      }
      if (stock.marketCap > 0) {
        final capLabel = stock.marketCap >= 200e9
            ? 'Mega Cap'
            : stock.marketCap >= 10e9
                ? 'Large Cap'
                : stock.marketCap >= 2e9
                    ? 'Mid Cap'
                    : 'Small Cap';
        fundamentalMetrics.add(FundamentalMetric(
          name: 'Market Cap',
          value: stock.marketCap,
          unit: 'USD',
          description: capLabel,
        ));
      }

      // Build technical indicators
      final technicalIndicators = <TechnicalIndicator>[];
      if (stock.beta > 0) {
        technicalIndicators.add(TechnicalIndicator(
          name: 'Beta',
          value: stock.beta,
          signal: stock.beta > 1.2 ? 'High volatility' : stock.beta < 0.8 ? 'Low volatility' : 'Average volatility',
          description: 'Measures price volatility relative to the market (1.0 = market average)',
        ));
      }
      if (stock.weekHigh52 > 0 && stock.weekLow52 > 0) {
        final range = stock.weekHigh52 - stock.weekLow52;
        final position = range > 0 ? (stock.currentPrice - stock.weekLow52) / range : 0.5;
        technicalIndicators.add(TechnicalIndicator(
          name: '52-Week Range Position',
          value: position * 100,
          signal: position > 0.8 ? 'Near 52-week high' : position < 0.2 ? 'Near 52-week low' : 'Mid-range',
          description: 'Current price position within the 52-week trading range',
        ));
      }
      if (stock.volume > 0 && stock.avgVolume > 0) {
        final volumeRatio = stock.volume / stock.avgVolume;
        technicalIndicators.add(TechnicalIndicator(
          name: 'Volume Ratio',
          value: volumeRatio,
          signal: volumeRatio > 1.5 ? 'High activity' : volumeRatio < 0.5 ? 'Low activity' : 'Normal activity',
          description: 'Today\'s volume compared to the average daily volume',
        ));
      }

      // Build summary
      final sectorInfo = stock.sector.isNotEmpty ? ' in the ${stock.sector} sector' : '';
      final industryInfo = stock.industry.isNotEmpty ? ' (${stock.industry})' : '';
      final summary = '${stock.name}$sectorInfo$industryInfo is currently trading at \$${stock.currentPrice.toStringAsFixed(2)} '
          'with a ${stock.changePercent >= 0 ? "+" : ""}${stock.changePercent.toStringAsFixed(2)}% daily change. '
          '52-week range: \$${stock.weekLow52.toStringAsFixed(2)} - \$${stock.weekHigh52.toStringAsFixed(2)}.';

      return StockAnalysisModel(
        symbol: symbol,
        rating: rating,
        targetPrice: targetPrice,
        stopLoss: stopLoss,
        technicalIndicators: technicalIndicators,
        fundamentalMetrics: fundamentalMetrics,
        summary: summary,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      // Fallback to basic analysis if stock details fail
      return StockAnalysisModel(
        symbol: symbol,
        rating: AnalysisRating.hold,
        targetPrice: 0,
        stopLoss: 0,
        technicalIndicators: [],
        fundamentalMetrics: [],
        summary: 'Unable to load analysis data. Please try again later.',
        lastUpdated: DateTime.now(),
      );
    }
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
    // US market hours: 9:30 AM - 4:00 PM ET, Monday-Friday
    // Pre-market: 4:00 AM - 9:30 AM ET
    // After-hours: 4:00 PM - 8:00 PM ET
    final now = DateTime.now().toUtc();
    // ET is UTC-5 (EST) or UTC-4 (EDT). Use approximate offset.
    final month = now.month;
    final etOffset = (month >= 3 && month <= 10) ? -4 : -5; // Rough EDT/EST
    final etNow = now.add(Duration(hours: etOffset));

    final hour = etNow.hour;
    final minute = etNow.minute;
    final weekday = etNow.weekday; // 1=Mon, 7=Sun
    final timeMinutes = hour * 60 + minute;

    final isWeekday = weekday >= 1 && weekday <= 5;
    final regularOpen = 9 * 60 + 30; // 9:30 AM
    final regularClose = 16 * 60; // 4:00 PM
    final preMarketOpen = 4 * 60; // 4:00 AM
    final afterHoursClose = 20 * 60; // 8:00 PM

    String tradingSession;
    bool marketOpen;
    DateTime sessionStartTime;
    DateTime sessionEndTime;

    if (!isWeekday) {
      tradingSession = 'closed';
      marketOpen = false;
      // Next Monday
      final daysUntilMonday = weekday == 6 ? 2 : 1;
      final nextMonday = DateTime(etNow.year, etNow.month, etNow.day + daysUntilMonday, 9, 30);
      sessionStartTime = nextMonday;
      sessionEndTime = nextMonday.add(const Duration(hours: 6, minutes: 30));
    } else if (timeMinutes >= regularOpen && timeMinutes < regularClose) {
      tradingSession = 'regular';
      marketOpen = true;
      sessionStartTime = DateTime(etNow.year, etNow.month, etNow.day, 9, 30);
      sessionEndTime = DateTime(etNow.year, etNow.month, etNow.day, 16, 0);
    } else if (timeMinutes >= preMarketOpen && timeMinutes < regularOpen) {
      tradingSession = 'pre_market';
      marketOpen = false;
      sessionStartTime = DateTime(etNow.year, etNow.month, etNow.day, 4, 0);
      sessionEndTime = DateTime(etNow.year, etNow.month, etNow.day, 9, 30);
    } else if (timeMinutes >= regularClose && timeMinutes < afterHoursClose) {
      tradingSession = 'after_hours';
      marketOpen = false;
      sessionStartTime = DateTime(etNow.year, etNow.month, etNow.day, 16, 0);
      sessionEndTime = DateTime(etNow.year, etNow.month, etNow.day, 20, 0);
    } else {
      tradingSession = 'closed';
      marketOpen = false;
      sessionStartTime = DateTime(etNow.year, etNow.month, etNow.day, 9, 30);
      sessionEndTime = DateTime(etNow.year, etNow.month, etNow.day, 16, 0);
    }

    return {
      'marketOpen': marketOpen,
      'tradingSession': tradingSession,
      'sessionStartTime': sessionStartTime,
      'sessionEndTime': sessionEndTime,
    };
  }

  @override
  Future<List<StockModel>> getEarningsCalendar({DateTime? date}) async {
    try {
      final request = investmentspb.GetEarningsCalendarRequest();
      if (date != null) {
        request.startDate = date.toIso8601String().split('T').first;
        request.endDate = date.add(const Duration(days: 7)).toIso8601String().split('T').first;
      }

      final response = await _investmentsClient.getEarningsCalendar(
        request,
        options: channelManager.getCallOptions(),
      );

      return response.events.map((event) => StockModel(
        symbol: event.symbol,
        name: event.name,
        currentPrice: 0,
        previousClose: 0,
        change: 0,
        changePercent: 0,
        dayHigh: 0,
        dayLow: 0,
        volume: 0,
        marketCap: 0,
        peRatio: 0,
        dividendYield: 0,
        sector: '',
        industry: '',
        logoUrl: '',
        priceHistory: const [],
        lastUpdated: DateTime.now(),
        weekHigh52: 0,
        weekLow52: 0,
        avgVolume: 0,
        beta: 0,
        eps: event.epsEstimate,
        description: 'Q${event.fiscalQuarter} earnings on ${event.reportDate}',
        exchange: '',
        currency: 'USD',
      )).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching earnings calendar via gRPC: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockModel>> getDividendCalendar({DateTime? date}) async {
    try {
      final request = investmentspb.GetDividendCalendarRequest();
      if (date != null) {
        request.startDate = date.toIso8601String().split('T').first;
        request.endDate = date.add(const Duration(days: 7)).toIso8601String().split('T').first;
      }

      final response = await _investmentsClient.getDividendCalendar(
        request,
        options: channelManager.getCallOptions(),
      );

      return response.events.map((event) => StockModel(
        symbol: event.symbol,
        name: event.name,
        currentPrice: 0,
        previousClose: 0,
        change: 0,
        changePercent: 0,
        dayHigh: 0,
        dayLow: 0,
        volume: 0,
        marketCap: 0,
        peRatio: 0,
        dividendYield: event.yield,
        sector: '',
        industry: '',
        logoUrl: '',
        priceHistory: const [],
        lastUpdated: DateTime.now(),
        weekHigh52: 0,
        weekLow52: 0,
        avgVolume: 0,
        beta: 0,
        eps: event.amount,
        description: 'Ex-date: ${event.exDate}, Payment: ${event.paymentDate}',
        exchange: '',
        currency: 'USD',
      )).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching dividend calendar via gRPC: $e');
      rethrow;
    }
  }

  // Helper conversion methods
  StockAlertModel _convertPriceAlertToModel(investmentspb.PriceAlertInfo alert) {
    return StockAlertModel(
      id: alert.id,
      symbol: alert.symbol,
      type: AlertType.values.firstWhere(
        (e) => e.toString().split('.').last == alert.alertType,
        orElse: () => AlertType.price,
      ),
      condition: AlertCondition.values.firstWhere(
        (e) => e.toString().split('.').last == alert.condition,
        orElse: () => AlertCondition.above,
      ),
      targetValue: alert.targetValue,
      message: alert.message.isNotEmpty ? alert.message : null,
      isActive: alert.isActive,
      createdAt: alert.createdAt.isNotEmpty
          ? DateTime.tryParse(alert.createdAt) ?? DateTime.now()
          : DateTime.now(),
      triggeredAt: alert.triggeredAt.isNotEmpty
          ? DateTime.tryParse(alert.triggeredAt)
          : null,
    );
  }

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
