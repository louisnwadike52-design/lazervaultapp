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
      ];
}

enum OrderType { market, limit, stopLoss, stopLimit }

enum OrderSide { buy, sell }

enum OrderStatus { pending, executed, cancelled, rejected }

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
      ];
}

class Watchlist extends Equatable {
  final String id;
  final String name;
  final List<String> symbols;
  final DateTime createdAt;
  final DateTime lastUpdated;

  const Watchlist({
    required this.id,
    required this.name,
    required this.symbols,
    required this.createdAt,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id, name, symbols, createdAt, lastUpdated];
} 