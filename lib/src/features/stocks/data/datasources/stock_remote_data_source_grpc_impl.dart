import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/grpc/grpc_channel_manager.dart';
import 'package:lazervault/src/generated/investments.pbgrpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/stock_entity.dart';
import '../models/stock_model.dart';
import 'stock_remote_data_source.dart';

const _kWatchlistPrefsKey = 'lv_invest_watchlists_v1';

/// Stock and invest flows via [InvestmentsService] on the investment-gateway channel.
/// Watchlists are stored locally (device) until a backend watchlist API exists.
class StockRemoteDataSourceGrpcImpl implements IStockRemoteDataSource {
  StockRemoteDataSourceGrpcImpl({
    required this.channelManager,
  }) : _client = InvestmentsServiceClient(channelManager.channel);

  final GrpcChannelManager channelManager;
  final InvestmentsServiceClient _client;

  Future<CallOptions> get _authOptions => channelManager.getAuthCallOptions();

  @override
  Future<List<StockModel>> getStocks({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    final q = (searchQuery != null && searchQuery.trim().isNotEmpty)
        ? searchQuery.trim()
        : (sector != null && sector.trim().isNotEmpty)
            ? sector.trim()
            : 'A';
    return searchStocks(q, market: null);
  }

  @override
  Future<StockModel> getStockDetails(String symbol) async {
    try {
      final resp = await _client.getStockDetails(
        GetStockDetailsRequest(symbol: symbol.toUpperCase()),
        options: await _authOptions,
      );
      final s = resp.stock;
      return StockModel(
        symbol: s.symbol,
        name: s.name.isNotEmpty ? s.name : s.symbol,
        currentPrice: s.currentPrice,
        previousClose: s.currentPrice - s.change,
        change: s.change,
        changePercent: s.changePercent,
        dayHigh: s.dayHigh,
        dayLow: s.dayLow,
        volume: s.volume,
        marketCap: s.marketCap,
        peRatio: s.peRatio,
        dividendYield: s.dividendYield,
        sector: s.sector,
        industry: s.industry,
        logoUrl: s.logoUrl,
        priceHistory: const [],
        lastUpdated: DateTime.now(),
        weekHigh52: s.weekHigh52,
        weekLow52: s.weekLow52,
        avgVolume: 0,
        beta: s.beta,
        eps: s.eps,
        description: s.description,
        exchange: s.exchange,
        currency: s.currency.isNotEmpty ? s.currency : 'USD',
      );
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Stock with symbol $symbol not found');
      }
      throw Exception('gRPC Error: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('getStockDetails: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockPriceModel>> getStockPriceHistory(
    String symbol,
    String timeframe,
  ) async {
    final tf = _mapTimeframeToProto(timeframe);
    final lim = _barsLimitForUiTimeframe(timeframe);
    try {
      final resp = await _client.getStockPriceHistory(
        GetStockPriceHistoryRequest(
          symbol: symbol.toUpperCase(),
          timeframe: tf,
          limit: lim,
        ),
        options: await _authOptions,
      );
      return resp.bars
          .map((b) => StockPriceModel(
                timestamp: DateTime.tryParse(b.timestamp) ?? DateTime.now(),
                open: b.open,
                high: b.high,
                low: b.low,
                close: b.close,
                volume: b.volume.toDouble(),
              ))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  String _mapTimeframeToProto(String timeframe) {
    switch (timeframe.toLowerCase()) {
      case '1d':
      case '5d':
      case '1w':
      case '1m':
      case '3m':
      case '6m':
      case '1y':
      case '5y':
      case 'all':
        return '1Day';
      default:
        return '1Day';
    }
  }

  int _barsLimitForUiTimeframe(String timeframe) {
    switch (timeframe.toLowerCase()) {
      case '1d':
        return 2;
      case '5d':
        return 7;
      case '1w':
        return 7;
      case '1m':
        return 32;
      case '3m':
        return 98;
      case '6m':
        return 190;
      case '1y':
        return 370;
      case '5y':
        return 260;
      case 'all':
        return 800;
      default:
        return 90;
    }
  }

  @override
  Future<List<StockModel>> getTopMovers({String? market}) async {
    try {
      final resp = await _client.getTopMovers(
        GetTopMoversRequest(
          market: market ?? '',
          limit: 10,
        ),
        options: await _authOptions,
      );
      final out = <StockModel>[];
      for (final m in resp.gainers) {
        out.add(_topMoverToStock(m));
      }
      for (final m in resp.losers) {
        out.add(_topMoverToStock(m));
      }
      out.sort((a, b) => b.changePercent.abs().compareTo(a.changePercent.abs()));
      return out;
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  StockModel _topMoverToStock(TopMover m) {
    return StockModel(
      symbol: m.symbol,
      name: m.name.isNotEmpty ? m.name : m.symbol,
      currentPrice: m.price,
      previousClose: m.price - m.change,
      change: m.change,
      changePercent: m.changePercent,
      dayHigh: m.price,
      dayLow: m.price,
      volume: m.volume,
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
      eps: 0,
      description: '',
      exchange: '',
      currency: 'USD',
    );
  }

  @override
  Future<List<StockModel>> searchStocks(String query, {String? market}) async {
    try {
      final resp = await _client.searchStocks(
        SearchStocksRequest(
          query: query,
          market: market ?? '',
          limit: 20,
        ),
        options: await _authOptions,
      );
      return resp.results.map((r) {
        return StockModel(
          symbol: r.symbol,
          name: r.name.isNotEmpty ? r.name : r.symbol,
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
          eps: 0,
          description: r.exchange,
          exchange: r.exchange,
          currency: 'USD',
        );
      }).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  @override
  Future<PortfolioModel> getPortfolio() async {
    try {
      final resp = await _client.getStockPortfolio(
        GetStockPortfolioRequest(),
        options: await _authOptions,
      );
      final holdings = resp.holdings
          .map((h) => StockHoldingModel(
                symbol: h.stockSymbol,
                name: h.stockName.isNotEmpty ? h.stockName : h.stockSymbol,
                shares: h.quantity.round(),
                averageCost: h.averagePrice,
                currentPrice: h.currentPrice,
                totalValue: h.totalValue,
                totalReturn: h.profitLoss,
                totalReturnPercent: h.profitLossPercentage,
                dayChange: 0,
                dayChangePercent: 0,
                purchaseDate: DateTime.now(),
                logoUrl: '',
              ))
          .toList();
      return PortfolioModel(
        id: 'stock-portfolio',
        totalValue: resp.totalValue,
        totalCost: resp.totalInvested,
        totalReturn: resp.totalProfitLoss,
        totalReturnPercent: resp.profitLossPercentage,
        dayChange: 0,
        dayChangePercent: 0,
        holdings: holdings,
        lastUpdated: DateTime.now(),
        availableCash: 0,
        totalInvested: resp.totalInvested,
      );
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  @override
  Future<List<StockHoldingModel>> getHoldings() async {
    final p = await getPortfolio();
    return p.holdings.cast<StockHoldingModel>();
  }

  @override
  Future<StockOrderModel> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
    double? quantityExact,
    String? transactionId,
    String? verificationToken,
  }) async {
    final qty = quantityExact ?? quantity.toDouble();
    if (qty <= 0) {
      throw Exception('Invalid quantity');
    }
    if (transactionId == null ||
        transactionId.isEmpty ||
        verificationToken == null ||
        verificationToken.isEmpty) {
      throw Exception(
        'Transaction verification required. Complete PIN confirmation before trading.',
      );
    }
    final orderType = type == OrderType.limit ? 'limit' : 'market';
    final sym = symbol.toUpperCase();
    try {
      if (side == OrderSide.buy) {
        final resp = await _client.buyStock(
          BuyStockRequest(
            symbol: sym,
            quantity: qty,
            pricePerShare: price ?? 0,
            orderType: orderType,
            transactionId: transactionId,
            verificationToken: verificationToken,
          ),
          options: await _authOptions,
        );
        return _orderFromBuyResponse(sym, type, side, qty, price, resp);
      }
      final resp = await _client.sellStock(
        SellStockRequest(
          symbol: sym,
          quantity: qty,
          pricePerShare: price ?? 0,
          orderType: orderType,
          transactionId: transactionId,
          verificationToken: verificationToken,
        ),
        options: await _authOptions,
      );
      return _orderFromSellResponse(sym, type, side, qty, price, resp);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception(e.message ?? 'Order failed');
    }
  }

  StockOrderModel _orderFromBuyResponse(
    String symbol,
    OrderType type,
    OrderSide side,
    double qty,
    double? price,
    BuyStockResponse resp,
  ) {
    final inv = resp.investment;
    final id = inv.id.isNotEmpty ? inv.id : 'buy-${DateTime.now().millisecondsSinceEpoch}';
    return StockOrderModel(
      id: id,
      symbol: symbol,
      orderType: type,
      side: side,
      quantity: qty.round().clamp(1, 1000000),
      price: price,
      orderStatus: OrderStatus.executed,
      createdAt: DateTime.now(),
      executedAt: DateTime.now(),
      executedPrice: inv.purchasePrice > 0 ? inv.purchasePrice : price,
      executedQuantity: qty.round(),
      fees: null,
      notes: resp.message,
    );
  }

  StockOrderModel _orderFromSellResponse(
    String symbol,
    OrderType type,
    OrderSide side,
    double qty,
    double? price,
    SellStockResponse resp,
  ) {
    final inv = resp.investment;
    final id = inv.id.isNotEmpty ? inv.id : 'sell-${DateTime.now().millisecondsSinceEpoch}';
    return StockOrderModel(
      id: id,
      symbol: symbol,
      orderType: type,
      side: side,
      quantity: qty.round().clamp(1, 1000000),
      price: price,
      orderStatus: OrderStatus.executed,
      createdAt: DateTime.now(),
      executedAt: DateTime.now(),
      executedPrice: price,
      executedQuantity: qty.round(),
      fees: null,
      notes: resp.message,
    );
  }

  @override
  Future<List<StockOrderModel>> getOrders({
    OrderStatus? status,
    String? symbol,
  }) async {
    try {
      String st = 'all';
      if (status == OrderStatus.pending || status == OrderStatus.partiallyFilled) {
        st = 'open';
      } else if (status == OrderStatus.executed ||
          status == OrderStatus.cancelled ||
          status == OrderStatus.rejected) {
        st = 'closed';
      }
      final resp = await _client.getStockOrders(
        GetStockOrdersRequest(
          status: st,
          side: '',
          limit: 50,
        ),
        options: await _authOptions,
      );
      return resp.orders.map((o) => _protoOrderToModel(o)).toList();
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  StockOrderModel _protoOrderToModel(StockOrderInfo o) {
    return StockOrderModel(
      id: o.orderId,
      symbol: o.symbol,
      orderType: o.orderType.toLowerCase() == 'limit' ? OrderType.limit : OrderType.market,
      side: o.side.toLowerCase() == 'sell' ? OrderSide.sell : OrderSide.buy,
      quantity: o.quantity.round().clamp(0, 1000000),
      price: o.limitPrice > 0 ? o.limitPrice : null,
      orderStatus: _parseOrderStatus(o.status),
      createdAt: DateTime.tryParse(o.createdAt) ?? DateTime.now(),
      executedAt: o.filledAt.isNotEmpty ? DateTime.tryParse(o.filledAt) : null,
      executedPrice: o.filledAvgPrice > 0 ? o.filledAvgPrice : null,
      executedQuantity: o.filledQty.round(),
      fees: o.fee > 0 ? o.fee : null,
      notes: '',
    );
  }

  OrderStatus _parseOrderStatus(String raw) {
    switch (raw.toLowerCase()) {
      case 'filled':
      case 'done_for_day':
        return OrderStatus.executed;
      case 'canceled':
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'rejected':
      case 'expired':
        return OrderStatus.rejected;
      case 'partially_filled':
        return OrderStatus.partiallyFilled;
      default:
        return OrderStatus.pending;
    }
  }

  @override
  Future<StockOrderModel> cancelOrder(String orderId) async {
    try {
      await _client.cancelStockOrder(
        CancelStockOrderRequest(orderId: orderId),
        options: await _authOptions,
      );
      return StockOrderModel(
        id: orderId,
        symbol: '',
        orderType: OrderType.market,
        side: OrderSide.buy,
        quantity: 0,
        orderStatus: OrderStatus.cancelled,
        createdAt: DateTime.now(),
        notes: 'Cancelled',
      );
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unauthenticated) {
        throw Exception('Unauthorized: Please log in');
      }
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> _loadWatchlistMaps() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kWatchlistPrefsKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveWatchlistMaps(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kWatchlistPrefsKey, jsonEncode(items));
  }

  WatchlistModel _mapToWatchlistModel(Map<String, dynamic> m) {
    return WatchlistModel(
      id: m['id'] as String? ?? '',
      name: m['name'] as String? ?? 'Watchlist',
      symbols: List<String>.from(m['symbols'] as List? ?? []),
      createdAt: DateTime.tryParse(m['createdAt'] as String? ?? '') ?? DateTime.now(),
      lastUpdated: DateTime.tryParse(m['lastUpdated'] as String? ?? '') ?? DateTime.now(),
      isDefault: m['isDefault'] as bool? ?? false,
    );
  }

  @override
  Future<List<WatchlistModel>> getWatchlists() async {
    final maps = await _loadWatchlistMaps();
    if (maps.isEmpty) {
      return [];
    }
    return maps.map(_mapToWatchlistModel).toList();
  }

  @override
  Future<WatchlistModel> createWatchlist(String name, List<String> symbols) async {
    final maps = await _loadWatchlistMaps();
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final now = DateTime.now().toIso8601String();
    final entry = {
      'id': id,
      'name': name,
      'symbols': symbols.map((s) => s.toUpperCase()).toList(),
      'createdAt': now,
      'lastUpdated': now,
      'isDefault': maps.isEmpty,
    };
    maps.add(entry);
    await _saveWatchlistMaps(maps);
    return _mapToWatchlistModel(entry);
  }

  @override
  Future<WatchlistModel> updateWatchlist(String watchlistId, String name, List<String> symbols) async {
    final maps = await _loadWatchlistMaps();
    final now = DateTime.now().toIso8601String();
    for (var i = 0; i < maps.length; i++) {
      if (maps[i]['id'] == watchlistId) {
        maps[i] = {
          ...maps[i],
          'name': name,
          'symbols': symbols.map((s) => s.toUpperCase()).toList(),
          'lastUpdated': now,
        };
        await _saveWatchlistMaps(maps);
        return _mapToWatchlistModel(maps[i]);
      }
    }
    throw Exception('Watchlist not found');
  }

  @override
  Future<WatchlistModel> addToWatchlist(String watchlistId, String symbol) async {
    final maps = await _loadWatchlistMaps();
    final sym = symbol.toUpperCase();
    for (var i = 0; i < maps.length; i++) {
      if (maps[i]['id'] == watchlistId) {
        final syms = List<String>.from(maps[i]['symbols'] as List? ?? []);
        if (!syms.contains(sym)) syms.add(sym);
        maps[i] = {
          ...maps[i],
          'symbols': syms,
          'lastUpdated': DateTime.now().toIso8601String(),
        };
        await _saveWatchlistMaps(maps);
        return _mapToWatchlistModel(maps[i]);
      }
    }
    throw Exception('Watchlist not found');
  }

  @override
  Future<WatchlistModel> removeFromWatchlist(String watchlistId, String symbol) async {
    final maps = await _loadWatchlistMaps();
    final sym = symbol.toUpperCase();
    for (var i = 0; i < maps.length; i++) {
      if (maps[i]['id'] == watchlistId) {
        final syms = List<String>.from(maps[i]['symbols'] as List? ?? [])
          ..remove(sym);
        maps[i] = {
          ...maps[i],
          'symbols': syms,
          'lastUpdated': DateTime.now().toIso8601String(),
        };
        await _saveWatchlistMaps(maps);
        return _mapToWatchlistModel(maps[i]);
      }
    }
    throw Exception('Watchlist not found');
  }

  @override
  Future<void> deleteWatchlist(String watchlistId) async {
    final maps = await _loadWatchlistMaps()..removeWhere((m) => m['id'] == watchlistId);
    await _saveWatchlistMaps(maps);
  }

  @override
  Future<Map<String, double>> getMarketIndices() async {
    try {
      final sectors = await getSectorPerformance();
      if (sectors.isEmpty) return {};
      return {for (final s in sectors) s.sector: s.changePercent};
    } catch (_) {
      return {};
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
      final request = GetMarketNewsRequest(
        limit: limit,
        page: page,
      );
      if (category != null) {
        request.category = category.toString().split('.').last;
      }
      if (symbols != null && symbols.isNotEmpty) {
        request.symbols.addAll(symbols);
      }
      final response = await _client.getMarketNews(
        request,
        options: await _authOptions,
      );
      return response.articles
          .map((article) => MarketNewsModel(
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
              ))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  @override
  Future<List<SectorPerformanceModel>> getSectorPerformance() async {
    try {
      final response = await _client.getSectorPerformance(
        GetSectorPerformanceRequest(),
        options: await _authOptions,
      );
      return response.sectors
          .map((sector) => SectorPerformanceModel(
                sector: sector.sector,
                change: sector.change,
                changePercent: sector.changePercent,
                marketCap: sector.marketCap,
                topStocks: List<String>.from(sector.topStocks),
              ))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  @override
  Future<List<StockAlertModel>> getAlerts() async {
    try {
      final response = await _client.getPriceAlerts(
        GetPriceAlertsRequest(),
        options: await _authOptions,
      );
      return response.alerts.map(_convertPriceAlertToModel).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
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
      final response = await _client.createPriceAlert(
        CreatePriceAlertRequest(
          symbol: symbol,
          alertType: type.toString().split('.').last,
          targetValue: targetValue,
          condition: condition.toString().split('.').last,
        ),
        options: await _authOptions,
      );
      return _convertPriceAlertToModel(response.alert);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
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
      final request = UpdatePriceAlertRequest(alertId: alertId);
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
      final response = await _client.updatePriceAlert(
        request,
        options: await _authOptions,
      );
      return _convertPriceAlertToModel(response.alert);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  @override
  Future<void> deleteAlert(String alertId) async {
    try {
      await _client.deletePriceAlert(
        DeletePriceAlertRequest(alertId: alertId),
        options: await _authOptions,
      );
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  StockAlertModel _convertPriceAlertToModel(PriceAlertInfo alert) {
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
      triggeredAt: alert.triggeredAt.isNotEmpty ? DateTime.tryParse(alert.triggeredAt) : null,
    );
  }

  @override
  Future<StockAnalysisModel> getStockAnalysis(String symbol) async {
    try {
      final stock = await getStockDetails(symbol);
      AnalysisRating rating = AnalysisRating.hold;
      if (stock.peRatio > 0 && stock.peRatio < 15 && stock.changePercent > 0) {
        rating = AnalysisRating.buy;
      } else if (stock.peRatio > 0 && stock.peRatio < 10) {
        rating = AnalysisRating.strongBuy;
      } else if (stock.peRatio > 40 && stock.changePercent < -2) {
        rating = AnalysisRating.sell;
      }
      final targetPrice = stock.weekHigh52 > 0
          ? stock.currentPrice + (stock.weekHigh52 - stock.currentPrice) * 0.5
          : stock.currentPrice * 1.1;
      final stopLoss =
          stock.weekLow52 > 0 ? stock.weekLow52 : stock.currentPrice * 0.9;
      final fundamentalMetrics = <FundamentalMetric>[];
      if (stock.peRatio > 0) {
        fundamentalMetrics.add(FundamentalMetric(
          name: 'P/E Ratio',
          value: stock.peRatio,
          unit: 'x',
          description: stock.peRatio < 20
              ? 'Below average — potentially undervalued'
              : 'Above average — higher growth expectations',
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
      final technicalIndicators = <TechnicalIndicator>[];
      if (stock.beta > 0) {
        technicalIndicators.add(TechnicalIndicator(
          name: 'Beta',
          value: stock.beta,
          signal: stock.beta > 1.2
              ? 'High volatility'
              : stock.beta < 0.8
                  ? 'Low volatility'
                  : 'Average volatility',
          description:
              'Measures price volatility relative to the market (1.0 = market average)',
        ));
      }
      if (stock.weekHigh52 > 0 && stock.weekLow52 > 0) {
        final range = stock.weekHigh52 - stock.weekLow52;
        final position =
            range > 0 ? (stock.currentPrice - stock.weekLow52) / range : 0.5;
        technicalIndicators.add(TechnicalIndicator(
          name: '52-Week Range Position',
          value: position * 100,
          signal: position > 0.8
              ? 'Near 52-week high'
              : position < 0.2
                  ? 'Near 52-week low'
                  : 'Mid-range',
          description: 'Current price position within the 52-week trading range',
        ));
      }
      final sectorInfo = stock.sector.isNotEmpty ? ' in the ${stock.sector} sector' : '';
      final industryInfo =
          stock.industry.isNotEmpty ? ' (${stock.industry})' : '';
      final summary =
          '${stock.name}$sectorInfo$industryInfo is currently trading at \$${stock.currentPrice.toStringAsFixed(2)} '
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
    return getTopMovers();
  }

  @override
  Future<List<StockModel>> getTrendingStocks() async {
    return getTopMovers();
  }

  @override
  Future<Map<String, dynamic>> getMarketStatus() async {
    try {
      final resp = await _client.getMarketStatus(
        GetMarketStatusRequest(),
        options: await _authOptions,
      );
      return {
        'marketOpen': resp.isOpen,
        'tradingSession': resp.isOpen ? 'regular' : 'closed',
        'sessionStartTime': resp.nextOpen.isNotEmpty
            ? DateTime.tryParse(resp.nextOpen)
            : null,
        'sessionEndTime': resp.nextClose.isNotEmpty
            ? DateTime.tryParse(resp.nextClose)
            : null,
        'timestamp': resp.timestamp,
      };
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  @override
  Future<List<StockModel>> getEarningsCalendar({DateTime? date}) async {
    try {
      final request = GetEarningsCalendarRequest();
      if (date != null) {
        request.startDate = date.toIso8601String().split('T').first;
        request.endDate =
            date.add(const Duration(days: 7)).toIso8601String().split('T').first;
      }
      final response = await _client.getEarningsCalendar(
        request,
        options: await _authOptions,
      );
      return response.events
          .map((event) => StockModel(
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
                description:
                    'Q${event.fiscalQuarter} earnings on ${event.reportDate}',
                exchange: '',
                currency: 'USD',
              ))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }

  @override
  Future<List<StockModel>> getDividendCalendar({DateTime? date}) async {
    try {
      final request = GetDividendCalendarRequest();
      if (date != null) {
        request.startDate = date.toIso8601String().split('T').first;
        request.endDate =
            date.add(const Duration(days: 7)).toIso8601String().split('T').first;
      }
      final response = await _client.getDividendCalendar(
        request,
        options: await _authOptions,
      );
      return response.events
          .map((event) => StockModel(
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
                description:
                    'Ex-date: ${event.exDate}, Payment: ${event.paymentDate}',
                exchange: '',
                currency: 'USD',
              ))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error: ${e.message}');
    }
  }
}
