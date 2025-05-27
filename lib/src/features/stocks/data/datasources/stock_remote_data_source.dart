import '../models/stock_model.dart';
import '../../domain/entities/stock_entity.dart';

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

class StockRemoteDataSourceImpl implements IStockRemoteDataSource {
  // Mock implementation for now - replace with actual API calls
  
  @override
  Future<List<StockModel>> getStocks({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      StockModel(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        currentPrice: 175.43,
        previousClose: 173.50,
        change: 1.93,
        changePercent: 1.11,
        dayHigh: 176.80,
        dayLow: 174.20,
        volume: 45678900,
        marketCap: 2750000000000,
        peRatio: 28.5,
        dividendYield: 0.52,
        sector: 'Technology',
        industry: 'Consumer Electronics',
        logoUrl: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/apple/apple-original.svg',
        priceHistory: _generateMockPriceHistory('AAPL'),
        lastUpdated: DateTime.now(),
        weekHigh52: 180.00,
        weekLow52: 150.00,
        avgVolume: 50000000,
        beta: 1.2,
        eps: 6.15,
        description: 'Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide.',
        exchange: 'NASDAQ',
        currency: 'USD',
      ),
      StockModel(
        symbol: 'GOOGL',
        name: 'Alphabet Inc.',
        currentPrice: 138.21,
        previousClose: 140.05,
        change: -1.84,
        changePercent: -1.31,
        dayHigh: 140.50,
        dayLow: 137.80,
        volume: 23456789,
        marketCap: 1750000000000,
        peRatio: 25.2,
        dividendYield: 0.0,
        sector: 'Technology',
        industry: 'Internet Content & Information',
        logoUrl: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/google/google-original.svg',
        priceHistory: _generateMockPriceHistory('GOOGL'),
        lastUpdated: DateTime.now(),
        weekHigh52: 145.00,
        weekLow52: 120.00,
        avgVolume: 25000000,
        beta: 1.1,
        eps: 5.80,
        description: 'Alphabet Inc. provides online advertising services in the United States, Europe, the Middle East, Africa, the Asia-Pacific, Canada, and Latin America.',
        exchange: 'NASDAQ',
        currency: 'USD',
      ),
      StockModel(
        symbol: 'MSFT',
        name: 'Microsoft Corporation',
        currentPrice: 378.85,
        previousClose: 375.20,
        change: 3.65,
        changePercent: 0.97,
        dayHigh: 380.00,
        dayLow: 376.50,
        volume: 18765432,
        marketCap: 2800000000000,
        peRatio: 32.1,
        dividendYield: 0.72,
        sector: 'Technology',
        industry: 'Software—Infrastructure',
        logoUrl: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/microsoftsqlserver/microsoftsqlserver-plain.svg',
        priceHistory: _generateMockPriceHistory('MSFT'),
        lastUpdated: DateTime.now(),
        weekHigh52: 385.00,
        weekLow52: 320.00,
        avgVolume: 20000000,
        beta: 0.9,
        eps: 11.05,
        description: 'Microsoft Corporation develops, licenses, and supports software, services, devices, and solutions worldwide.',
        exchange: 'NASDAQ',
        currency: 'USD',
      ),
      StockModel(
        symbol: 'TSLA',
        name: 'Tesla, Inc.',
        currentPrice: 248.50,
        previousClose: 245.80,
        change: 2.70,
        changePercent: 1.10,
        dayHigh: 252.00,
        dayLow: 246.30,
        volume: 67890123,
        marketCap: 790000000000,
        peRatio: 65.8,
        dividendYield: 0.0,
        sector: 'Consumer Cyclical',
        industry: 'Auto Manufacturers',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/b/bb/Tesla_T_symbol.svg',
        priceHistory: _generateMockPriceHistory('TSLA'),
        lastUpdated: DateTime.now(),
        weekHigh52: 280.00,
        weekLow52: 200.00,
        avgVolume: 70000000,
        beta: 2.0,
        eps: 3.62,
        description: 'Tesla, Inc. designs, develops, manufactures, leases, and sells electric vehicles, and energy generation and storage systems.',
        exchange: 'NASDAQ',
        currency: 'USD',
      ),
      StockModel(
        symbol: 'NVDA',
        name: 'NVIDIA Corporation',
        currentPrice: 478.23,
        previousClose: 472.56,
        change: 5.67,
        changePercent: 1.20,
        dayHigh: 485.00,
        dayLow: 475.20,
        volume: 34567890,
        marketCap: 1180000000000,
        peRatio: 68.5,
        dividendYield: 0.09,
        sector: 'Technology',
        industry: 'Semiconductors',
        logoUrl: 'https://upload.wikimedia.org/wikipedia/sco/2/21/Nvidia_logo.svg',
        priceHistory: _generateMockPriceHistory('NVDA'),
        lastUpdated: DateTime.now(),
        weekHigh52: 500.00,
        weekLow52: 400.00,
        avgVolume: 35000000,
        beta: 1.7,
        eps: 7.00,
        description: 'NVIDIA Corporation operates as a computing company in the United States, Taiwan, China, Hong Kong, and internationally.',
        exchange: 'NASDAQ',
        currency: 'USD',
      ),
    ];
  }

  @override
  Future<StockModel> getStockDetails(String symbol) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final stocks = await getStocks();
    return stocks.firstWhere((stock) => stock.symbol == symbol);
  }

  @override
  Future<List<StockPriceModel>> getStockPriceHistory(
    String symbol,
    String timeframe,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _generateMockPriceHistory(symbol);
  }

  @override
  Future<List<StockModel>> getTopMovers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final stocks = await getStocks();
    return stocks..sort((a, b) => b.changePercent.abs().compareTo(a.changePercent.abs()));
  }

  @override
  Future<List<StockModel>> searchStocks(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final stocks = await getStocks();
    return stocks.where((stock) => 
      stock.symbol.toLowerCase().contains(query.toLowerCase()) ||
      stock.name.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  @override
  Future<PortfolioModel> getPortfolio() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final holdings = await getHoldings();
    final totalValue = holdings.fold(0.0, (sum, holding) => sum + holding.totalValue);
    final totalCost = holdings.fold(0.0, (sum, holding) => sum + (holding.averageCost * holding.shares));
    final totalReturn = totalValue - totalCost;
    final totalReturnPercent = totalCost > 0 ? (totalReturn / totalCost) * 100 : 0.0;
    final dayChange = holdings.fold(0.0, (sum, holding) => sum + holding.dayChange);
    final dayChangePercent = totalValue > 0 ? (dayChange / (totalValue - dayChange)) * 100 : 0.0;
    
    return PortfolioModel(
      id: 'portfolio_1',
      totalValue: totalValue,
      totalCost: totalCost,
      totalReturn: totalReturn,
      totalReturnPercent: totalReturnPercent,
      dayChange: dayChange,
      dayChangePercent: dayChangePercent,
      holdings: holdings,
      lastUpdated: DateTime.now(),
      availableCash: 50000.0,
      totalInvested: totalCost,
    );
  }

  @override
  Future<List<StockHoldingModel>> getHoldings() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return [
      StockHoldingModel(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        shares: 50,
        averageCost: 150.00,
        currentPrice: 175.43,
        totalValue: 8771.50,
        totalReturn: 1271.50,
        totalReturnPercent: 16.95,
        dayChange: 96.50,
        dayChangePercent: 1.11,
        purchaseDate: DateTime.now().subtract(const Duration(days: 90)),
        logoUrl: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/apple/apple-original.svg',
      ),
      StockHoldingModel(
        symbol: 'GOOGL',
        name: 'Alphabet Inc.',
        shares: 25,
        averageCost: 120.00,
        currentPrice: 138.21,
        totalValue: 3455.25,
        totalReturn: 455.25,
        totalReturnPercent: 15.18,
        dayChange: -46.00,
        dayChangePercent: -1.31,
        purchaseDate: DateTime.now().subtract(const Duration(days: 60)),
        logoUrl: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/google/google-original.svg',
      ),
      StockHoldingModel(
        symbol: 'MSFT',
        name: 'Microsoft Corporation',
        shares: 30,
        averageCost: 320.00,
        currentPrice: 378.85,
        totalValue: 11365.50,
        totalReturn: 1765.50,
        totalReturnPercent: 18.39,
        dayChange: 109.50,
        dayChangePercent: 0.97,
        purchaseDate: DateTime.now().subtract(const Duration(days: 120)),
        logoUrl: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/microsoftsqlserver/microsoftsqlserver-plain.svg',
      ),
    ];
  }

  @override
  Future<StockOrderModel> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return StockOrderModel(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      symbol: symbol,
      type: type,
      side: side,
      quantity: quantity,
      price: price,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
      executedAt: null,
      executedPrice: null,
    );
  }

  @override
  Future<List<StockOrderModel>> getOrders({
    OrderStatus? status,
    String? symbol,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      StockOrderModel(
        id: 'order_1',
        symbol: 'AAPL',
        type: OrderType.market,
        side: OrderSide.buy,
        quantity: 10,
        price: null,
        status: OrderStatus.executed,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        executedAt: DateTime.now().subtract(const Duration(hours: 2)),
        executedPrice: 175.20,
      ),
      StockOrderModel(
        id: 'order_2',
        symbol: 'GOOGL',
        type: OrderType.limit,
        side: OrderSide.sell,
        quantity: 5,
        price: 140.00,
        status: OrderStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        executedAt: null,
        executedPrice: null,
      ),
    ];
  }

  @override
  Future<StockOrderModel> cancelOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return StockOrderModel(
      id: orderId,
      symbol: 'GOOGL',
      type: OrderType.limit,
      side: OrderSide.sell,
      quantity: 5,
      price: 140.00,
      status: OrderStatus.cancelled,
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      executedAt: null,
      executedPrice: null,
    );
  }

  @override
  Future<List<WatchlistModel>> getWatchlists() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      WatchlistModel(
        id: 'watchlist_1',
        name: 'Tech Stocks',
        symbols: ['AAPL', 'GOOGL', 'MSFT', 'NVDA'],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        lastUpdated: DateTime.now(),
      ),
      WatchlistModel(
        id: 'watchlist_2',
        name: 'Growth Stocks',
        symbols: ['TSLA', 'NVDA', 'AMD'],
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  @override
  Future<WatchlistModel> createWatchlist(String name, List<String> symbols) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return WatchlistModel(
      id: 'watchlist_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      symbols: symbols,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<WatchlistModel> updateWatchlist(String watchlistId, String name, List<String> symbols) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return WatchlistModel(
      id: watchlistId,
      name: name,
      symbols: symbols,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<WatchlistModel> addToWatchlist(String watchlistId, String symbol) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return WatchlistModel(
      id: watchlistId,
      name: 'Updated Watchlist',
      symbols: ['AAPL', 'GOOGL', symbol],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<WatchlistModel> removeFromWatchlist(String watchlistId, String symbol) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return WatchlistModel(
      id: watchlistId,
      name: 'Updated Watchlist',
      symbols: ['AAPL', 'GOOGL'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<void> deleteWatchlist(String watchlistId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<List<MarketNewsModel>> getMarketNews({
    NewsCategory? category,
    List<String>? symbols,
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return [
      MarketNewsModel(
        id: 'news_1',
        title: 'Apple Reports Record Q4 Earnings',
        summary: 'Apple Inc. reported record quarterly earnings driven by strong iPhone sales.',
        content: 'Apple Inc. today announced financial results for its fiscal 2024 fourth quarter...',
        source: 'Apple Newsroom',
        imageUrl: 'https://picsum.photos/400/200?random=1',
        relatedSymbols: ['AAPL'],
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
        url: 'https://apple.com/newsroom',
        category: NewsCategory.earnings,
        readTime: 5,
      ),
      MarketNewsModel(
        id: 'news_2',
        title: 'Tesla Announces New Gigafactory',
        summary: 'Tesla reveals plans for a new Gigafactory in Southeast Asia.',
        content: 'Tesla Inc. today announced plans to build a new Gigafactory...',
        source: 'Tesla Blog',
        imageUrl: 'https://picsum.photos/400/200?random=2',
        relatedSymbols: ['TSLA'],
        publishedAt: DateTime.now().subtract(const Duration(hours: 4)),
        url: 'https://tesla.com/blog',
        category: NewsCategory.market,
        readTime: 3,
      ),
    ];
  }

  @override
  Future<Map<String, double>> getMarketIndices() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return {
      'S&P 500': 4567.89,
      'NASDAQ': 14234.56,
      'DOW': 34567.12,
      'Russell 2000': 1987.65,
    };
  }

  @override
  Future<List<SectorPerformanceModel>> getSectorPerformance() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      SectorPerformanceModel(
        sector: 'Technology',
        change: 2.34,
        changePercent: 1.5,
        marketCap: 15000000000000,
        topStocks: ['AAPL', 'MSFT', 'GOOGL'],
      ),
      SectorPerformanceModel(
        sector: 'Healthcare',
        change: -1.23,
        changePercent: -0.8,
        marketCap: 8000000000000,
        topStocks: ['JNJ', 'PFE', 'UNH'],
      ),
      SectorPerformanceModel(
        sector: 'Finance',
        change: 0.87,
        changePercent: 0.6,
        marketCap: 12000000000000,
        topStocks: ['JPM', 'BAC', 'WFC'],
      ),
      SectorPerformanceModel(
        sector: 'Energy',
        change: -2.45,
        changePercent: -1.8,
        marketCap: 5000000000000,
        topStocks: ['XOM', 'CVX', 'COP'],
      ),
      SectorPerformanceModel(
        sector: 'Consumer Discretionary',
        change: 1.56,
        changePercent: 1.2,
        marketCap: 9000000000000,
        topStocks: ['AMZN', 'TSLA', 'HD'],
      ),
    ];
  }

  @override
  Future<List<StockAlertModel>> getAlerts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      StockAlertModel(
        id: 'alert_1',
        symbol: 'AAPL',
        type: AlertType.price,
        targetValue: 180.00,
        condition: AlertCondition.above,
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      StockAlertModel(
        id: 'alert_2',
        symbol: 'GOOGL',
        type: AlertType.volume,
        targetValue: 20000000,
        condition: AlertCondition.above,
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  @override
  Future<StockAlertModel> createAlert({
    required String symbol,
    required AlertType type,
    required double targetValue,
    required AlertCondition condition,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return StockAlertModel(
      id: 'alert_${DateTime.now().millisecondsSinceEpoch}',
      symbol: symbol,
      type: type,
      targetValue: targetValue,
      condition: condition,
      isActive: true,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<StockAlertModel> updateAlert(
    String alertId, {
    AlertType? type,
    double? targetValue,
    AlertCondition? condition,
    bool? isActive,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return StockAlertModel(
      id: alertId,
      symbol: 'AAPL',
      type: type ?? AlertType.price,
      targetValue: targetValue ?? 180.00,
      condition: condition ?? AlertCondition.above,
      isActive: isActive ?? true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    );
  }

  @override
  Future<void> deleteAlert(String alertId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<StockAnalysisModel> getStockAnalysis(String symbol) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return StockAnalysisModel(
      symbol: symbol,
      rating: AnalysisRating.buy,
      targetPrice: 200.0,
      stopLoss: 150.0,
      summary: 'This stock has a strong upward trend and is recommended for purchase.',
      technicalIndicators: [
        TechnicalIndicatorModel(
          name: 'RSI',
          value: 65.5,
          signal: 'Buy',
          description: 'Relative Strength Index indicates bullish momentum',
        ),
        TechnicalIndicatorModel(
          name: 'MACD',
          value: 2.3,
          signal: 'Buy',
          description: 'Moving Average Convergence Divergence shows positive trend',
        ),
      ],
      fundamentalMetrics: [
        FundamentalMetricModel(
          name: 'P/E Ratio',
          value: 28.5,
          unit: 'x',
          description: 'Price to Earnings ratio',
        ),
        FundamentalMetricModel(
          name: 'ROE',
          value: 15.2,
          unit: '%',
          description: 'Return on Equity',
        ),
      ],
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<TradingSessionModel> getCurrentTradingSession() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return TradingSessionModel(
      id: 'session_1',
      userId: 'user_123',
      startTime: DateTime.now().subtract(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(hours: 3)),
      startingBalance: 100000.00,
      currentBalance: 105000.00,
      totalPnL: 5000.00,
      totalTrades: 15,
      winningTrades: 10,
      losingTrades: 5,
      orders: [],
    );
  }

  @override
  Future<TradingSessionModel> startTradingSession(double startingBalance) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return TradingSessionModel(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_123',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      startingBalance: startingBalance,
      currentBalance: startingBalance,
      totalPnL: 0.00,
      totalTrades: 0,
      winningTrades: 0,
      losingTrades: 0,
      orders: [],
    );
  }

  @override
  Future<TradingSessionModel> endTradingSession(String sessionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return TradingSessionModel(
      id: sessionId,
      userId: 'user_123',
      startTime: DateTime.now().subtract(const Duration(hours: 4)),
      endTime: DateTime.now(),
      startingBalance: 100000.00,
      currentBalance: 105000.00,
      totalPnL: 5000.00,
      totalTrades: 15,
      winningTrades: 10,
      losingTrades: 5,
      orders: [],
    );
  }

  @override
  Future<List<TradingSessionModel>> getTradingSessionHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      TradingSessionModel(
        id: 'session_1',
        userId: 'user_123',
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        endTime: DateTime.now().subtract(const Duration(days: 1, hours: -4)),
        startingBalance: 100000.00,
        currentBalance: 105000.00,
        totalPnL: 5000.00,
        totalTrades: 15,
        winningTrades: 10,
        losingTrades: 5,
        orders: [],
      ),
      TradingSessionModel(
        id: 'session_2',
        userId: 'user_123',
        startTime: DateTime.now().subtract(const Duration(days: 2)),
        endTime: DateTime.now().subtract(const Duration(days: 2, hours: -3)),
        startingBalance: 100000.00,
        currentBalance: 102000.00,
        totalPnL: 2000.00,
        totalTrades: 8,
        winningTrades: 6,
        losingTrades: 2,
        orders: [],
      ),
    ];
  }

  @override
  Future<List<OptionContractModel>> getOptions(
    String underlyingSymbol, {
    DateTime? expirationDate,
    OptionType? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      OptionContractModel(
        symbol: 'AAPL_CALL_20240615_180',
        underlyingSymbol: 'AAPL',
        type: OptionType.call,
        strikePrice: 180.00,
        expirationDate: DateTime(2024, 6, 15),
        premium: 5.00,
        impliedVolatility: 0.25,
        delta: 0.65,
        gamma: 0.03,
        theta: -0.05,
        vega: 0.15,
        openInterest: 1500,
        volume: 250,
      ),
      OptionContractModel(
        symbol: 'AAPL_PUT_20240615_180',
        underlyingSymbol: 'AAPL',
        type: OptionType.put,
        strikePrice: 180.00,
        expirationDate: DateTime(2024, 6, 15),
        premium: 3.00,
        impliedVolatility: 0.22,
        delta: -0.35,
        gamma: 0.03,
        theta: -0.04,
        vega: 0.12,
        openInterest: 1200,
        volume: 180,
      ),
    ];
  }

  @override
  Future<OptionContractModel> getOptionDetails(String optionSymbol) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return OptionContractModel(
      symbol: optionSymbol,
      underlyingSymbol: 'AAPL',
      type: OptionType.call,
      strikePrice: 180.00,
      expirationDate: DateTime(2024, 6, 15),
      premium: 5.00,
      impliedVolatility: 0.25,
      delta: 0.65,
      gamma: 0.03,
      theta: -0.05,
      vega: 0.15,
      openInterest: 1500,
      volume: 250,
    );
  }

  @override
  Future<List<StockModel>> getRecommendations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final stocks = await getStocks();
    return stocks.take(2).toList();
  }

  @override
  Future<List<StockModel>> getTrendingStocks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final stocks = await getStocks();
    return stocks.take(2).toList();
  }

  @override
  Future<Map<String, dynamic>> getMarketStatus() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return {
      'marketOpen': true,
      'tradingSession': 'session_1',
      'sessionStartTime': DateTime.now().subtract(const Duration(hours: 1)),
      'sessionEndTime': DateTime.now().add(const Duration(hours: 3)),
    };
  }

  @override
  Future<List<StockModel>> getEarningsCalendar({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final stocks = await getStocks();
    return [stocks.first];
  }

  @override
  Future<List<StockModel>> getDividendCalendar({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final stocks = await getStocks();
    return [stocks.first];
  }

  List<StockPriceModel> _generateMockPriceHistory(String symbol) {
    final now = DateTime.now();
    final prices = <StockPriceModel>[];
    
    double basePrice = 100.0;
    switch (symbol) {
      case 'AAPL':
        basePrice = 175.0;
        break;
      case 'GOOGL':
        basePrice = 138.0;
        break;
      case 'MSFT':
        basePrice = 378.0;
        break;
      case 'TSLA':
        basePrice = 248.0;
        break;
      case 'NVDA':
        basePrice = 478.0;
        break;
    }
    
    for (int i = 30; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final variation = (i * 0.5) + (i % 3 == 0 ? 2.0 : -1.0);
      final price = basePrice + variation;
      
      prices.add(StockPriceModel(
        timestamp: date,
        open: price - 1.0,
        high: price + 2.0,
        low: price - 2.0,
        close: price,
        volume: 1000000 + (i * 50000),
      ));
    }
    
    return prices;
  }
} 