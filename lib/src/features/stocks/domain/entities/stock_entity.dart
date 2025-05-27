import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String symbol;
  final String name;
  final double currentPrice;
  final double previousClose;
  final double change;
  final double changePercent;
  final double dayHigh;
  final double dayLow;
  final double volume;
  final double marketCap;
  final double peRatio;
  final double dividendYield;
  final String sector;
  final String industry;
  final String logoUrl;
  final List<StockPrice> priceHistory;
  final DateTime lastUpdated;
  final double weekHigh52;
  final double weekLow52;
  final double avgVolume;
  final double beta;
  final double eps;
  final String description;
  final String exchange;
  final String currency;

  const Stock({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.previousClose,
    required this.change,
    required this.changePercent,
    required this.dayHigh,
    required this.dayLow,
    required this.volume,
    required this.marketCap,
    required this.peRatio,
    required this.dividendYield,
    required this.sector,
    required this.industry,
    required this.logoUrl,
    required this.priceHistory,
    required this.lastUpdated,
    required this.weekHigh52,
    required this.weekLow52,
    required this.avgVolume,
    required this.beta,
    required this.eps,
    required this.description,
    required this.exchange,
    required this.currency,
  });

  bool get isPositive => change >= 0;

  @override
  List<Object?> get props => [
    symbol,
    name,
    currentPrice,
    previousClose,
    change,
    changePercent,
    dayHigh,
    dayLow,
    volume,
    marketCap,
    peRatio,
    dividendYield,
    sector,
    industry,
    logoUrl,
    priceHistory,
    lastUpdated,
    weekHigh52,
    weekLow52,
    avgVolume,
    beta,
    eps,
    description,
    exchange,
    currency,
  ];
}

class StockPrice extends Equatable {
  final DateTime timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  const StockPrice({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  @override
  List<Object?> get props => [timestamp, open, high, low, close, volume];
}

class Portfolio extends Equatable {
  final String id;
  final double totalValue;
  final double totalCost;
  final double totalReturn;
  final double totalReturnPercent;
  final double dayChange;
  final double dayChangePercent;
  final List<StockHolding> holdings;
  final DateTime lastUpdated;
  final double availableCash;
  final double totalInvested;

  const Portfolio({
    required this.id,
    required this.totalValue,
    required this.totalCost,
    required this.totalReturn,
    required this.totalReturnPercent,
    required this.dayChange,
    required this.dayChangePercent,
    required this.holdings,
    required this.lastUpdated,
    required this.availableCash,
    required this.totalInvested,
  });

  @override
  List<Object?> get props => [
        id,
        totalValue,
        totalCost,
        totalReturn,
        totalReturnPercent,
        dayChange,
        dayChangePercent,
        holdings,
        lastUpdated,
        availableCash,
        totalInvested,
      ];
}

class StockHolding extends Equatable {
  final String symbol;
  final String name;
  final int shares;
  final double averageCost;
  final double currentPrice;
  final double totalValue;
  final double totalReturn;
  final double totalReturnPercent;
  final double dayChange;
  final double dayChangePercent;
  final DateTime purchaseDate;
  final String logoUrl;

  const StockHolding({
    required this.symbol,
    required this.name,
    required this.shares,
    required this.averageCost,
    required this.currentPrice,
    required this.totalValue,
    required this.totalReturn,
    required this.totalReturnPercent,
    required this.dayChange,
    required this.dayChangePercent,
    required this.purchaseDate,
    required this.logoUrl,
  });

  @override
  List<Object?> get props => [
        symbol,
        name,
        shares,
        averageCost,
        currentPrice,
        totalValue,
        totalReturn,
        totalReturnPercent,
        dayChange,
        dayChangePercent,
        purchaseDate,
        logoUrl,
      ];
}

class StockOrder extends Equatable {
  final String id;
  final String symbol;
  final OrderType type;
  final OrderSide side;
  final int quantity;
  final double? price;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? executedAt;
  final double? executedPrice;
  final int? executedQuantity;
  final double? fees;
  final String? notes;

  const StockOrder({
    required this.id,
    required this.symbol,
    required this.type,
    required this.side,
    required this.quantity,
    this.price,
    required this.status,
    required this.createdAt,
    this.executedAt,
    this.executedPrice,
    this.executedQuantity,
    this.fees,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        symbol,
        type,
        side,
        quantity,
        price,
        status,
        createdAt,
        executedAt,
        executedPrice,
        executedQuantity,
        fees,
        notes,
      ];
}

enum OrderType { market, limit, stopLoss, stopLimit }

enum OrderSide { buy, sell }

enum OrderStatus { pending, executed, cancelled, rejected, partiallyFilled }

class MarketNews extends Equatable {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String source;
  final String imageUrl;
  final List<String> relatedSymbols;
  final DateTime publishedAt;
  final String url;
  final NewsCategory category;
  final int readTime;

  const MarketNews({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.source,
    required this.imageUrl,
    required this.relatedSymbols,
    required this.publishedAt,
    required this.url,
    required this.category,
    required this.readTime,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        content,
        source,
        imageUrl,
        relatedSymbols,
        publishedAt,
        url,
        category,
        readTime,
      ];
}

enum NewsCategory { market, earnings, analysis, breaking, sector }

class Watchlist extends Equatable {
  final String id;
  final String name;
  final List<String> symbols;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final bool isDefault;

  const Watchlist({
    required this.id,
    required this.name,
    required this.symbols,
    required this.createdAt,
    required this.lastUpdated,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [id, name, symbols, createdAt, lastUpdated, isDefault];
}

class MarketIndex extends Equatable {
  final String symbol;
  final String name;
  final double value;
  final double change;
  final double changePercent;
  final DateTime lastUpdated;

  const MarketIndex({
    required this.symbol,
    required this.name,
    required this.value,
    required this.change,
    required this.changePercent,
    required this.lastUpdated,
  });

  bool get isPositive => change >= 0;

  @override
  List<Object?> get props => [symbol, name, value, change, changePercent, lastUpdated];
}

class StockAlert extends Equatable {
  final String id;
  final String symbol;
  final AlertType type;
  final double targetValue;
  final AlertCondition condition;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? triggeredAt;
  final String? message;

  const StockAlert({
    required this.id,
    required this.symbol,
    required this.type,
    required this.targetValue,
    required this.condition,
    required this.isActive,
    required this.createdAt,
    this.triggeredAt,
    this.message,
  });

  @override
  List<Object?> get props => [
        id,
        symbol,
        type,
        targetValue,
        condition,
        isActive,
        createdAt,
        triggeredAt,
        message,
      ];
}

enum AlertType { price, volume, percentChange }

enum AlertCondition { above, below, equals }

class TradingSession extends Equatable {
  final String id;
  final String userId;
  final DateTime startTime;
  final DateTime? endTime;
  final double startingBalance;
  final double currentBalance;
  final double totalPnL;
  final int totalTrades;
  final int winningTrades;
  final int losingTrades;
  final List<StockOrder> orders;

  const TradingSession({
    required this.id,
    required this.userId,
    required this.startTime,
    this.endTime,
    required this.startingBalance,
    required this.currentBalance,
    required this.totalPnL,
    required this.totalTrades,
    required this.winningTrades,
    required this.losingTrades,
    required this.orders,
  });

  double get winRate => totalTrades > 0 ? (winningTrades / totalTrades) * 100 : 0;

  @override
  List<Object?> get props => [
        id,
        userId,
        startTime,
        endTime,
        startingBalance,
        currentBalance,
        totalPnL,
        totalTrades,
        winningTrades,
        losingTrades,
        orders,
      ];
}

class StockAnalysis extends Equatable {
  final String symbol;
  final AnalysisRating rating;
  final double targetPrice;
  final double stopLoss;
  final List<TechnicalIndicator> technicalIndicators;
  final List<FundamentalMetric> fundamentalMetrics;
  final String summary;
  final DateTime lastUpdated;

  const StockAnalysis({
    required this.symbol,
    required this.rating,
    required this.targetPrice,
    required this.stopLoss,
    required this.technicalIndicators,
    required this.fundamentalMetrics,
    required this.summary,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
        symbol,
        rating,
        targetPrice,
        stopLoss,
        technicalIndicators,
        fundamentalMetrics,
        summary,
        lastUpdated,
      ];
}

enum AnalysisRating { strongBuy, buy, hold, sell, strongSell }

class TechnicalIndicator extends Equatable {
  final String name;
  final double value;
  final String signal;
  final String description;

  const TechnicalIndicator({
    required this.name,
    required this.value,
    required this.signal,
    required this.description,
  });

  @override
  List<Object?> get props => [name, value, signal, description];
}

class FundamentalMetric extends Equatable {
  final String name;
  final double value;
  final String unit;
  final String description;

  const FundamentalMetric({
    required this.name,
    required this.value,
    required this.unit,
    required this.description,
  });

  @override
  List<Object?> get props => [name, value, unit, description];
}

class SectorPerformance extends Equatable {
  final String sector;
  final double change;
  final double changePercent;
  final double marketCap;
  final List<String> topStocks;

  const SectorPerformance({
    required this.sector,
    required this.change,
    required this.changePercent,
    required this.marketCap,
    required this.topStocks,
  });

  bool get isPositive => change >= 0;

  @override
  List<Object?> get props => [sector, change, changePercent, marketCap, topStocks];
}

class OptionContract extends Equatable {
  final String symbol;
  final String underlyingSymbol;
  final OptionType type;
  final double strikePrice;
  final DateTime expirationDate;
  final double premium;
  final double impliedVolatility;
  final double delta;
  final double gamma;
  final double theta;
  final double vega;
  final int openInterest;
  final int volume;

  const OptionContract({
    required this.symbol,
    required this.underlyingSymbol,
    required this.type,
    required this.strikePrice,
    required this.expirationDate,
    required this.premium,
    required this.impliedVolatility,
    required this.delta,
    required this.gamma,
    required this.theta,
    required this.vega,
    required this.openInterest,
    required this.volume,
  });

  @override
  List<Object?> get props => [
        symbol,
        underlyingSymbol,
        type,
        strikePrice,
        expirationDate,
        premium,
        impliedVolatility,
        delta,
        gamma,
        theta,
        vega,
        openInterest,
        volume,
      ];
}

enum OptionType { call, put } 