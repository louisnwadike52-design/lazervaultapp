import '../../domain/entities/stock_entity.dart';

class StockModel extends Stock {
  const StockModel({
    required super.symbol,
    required super.name,
    required super.currentPrice,
    required super.previousClose,
    required super.change,
    required super.changePercent,
    required super.dayHigh,
    required super.dayLow,
    required super.volume,
    required super.marketCap,
    required super.peRatio,
    required super.dividendYield,
    required super.sector,
    required super.industry,
    required super.logoUrl,
    required super.priceHistory,
    required super.lastUpdated,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      currentPrice: (json['currentPrice'] ?? 0.0).toDouble(),
      previousClose: (json['previousClose'] ?? 0.0).toDouble(),
      change: (json['change'] ?? 0.0).toDouble(),
      changePercent: (json['changePercent'] ?? 0.0).toDouble(),
      dayHigh: (json['dayHigh'] ?? 0.0).toDouble(),
      dayLow: (json['dayLow'] ?? 0.0).toDouble(),
      volume: (json['volume'] ?? 0.0).toDouble(),
      marketCap: (json['marketCap'] ?? 0.0).toDouble(),
      peRatio: (json['peRatio'] ?? 0.0).toDouble(),
      dividendYield: (json['dividendYield'] ?? 0.0).toDouble(),
      sector: json['sector'] ?? '',
      industry: json['industry'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      priceHistory: (json['priceHistory'] as List<dynamic>?)
              ?.map((e) => StockPriceModel.fromJson(e))
              .toList() ??
          [],
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'currentPrice': currentPrice,
      'previousClose': previousClose,
      'change': change,
      'changePercent': changePercent,
      'dayHigh': dayHigh,
      'dayLow': dayLow,
      'volume': volume,
      'marketCap': marketCap,
      'peRatio': peRatio,
      'dividendYield': dividendYield,
      'sector': sector,
      'industry': industry,
      'logoUrl': logoUrl,
      'priceHistory': priceHistory.map((e) => (e as StockPriceModel).toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class StockPriceModel extends StockPrice {
  const StockPriceModel({
    required super.timestamp,
    required super.open,
    required super.high,
    required super.low,
    required super.close,
    required super.volume,
  });

  factory StockPriceModel.fromJson(Map<String, dynamic> json) {
    return StockPriceModel(
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      open: (json['open'] ?? 0.0).toDouble(),
      high: (json['high'] ?? 0.0).toDouble(),
      low: (json['low'] ?? 0.0).toDouble(),
      close: (json['close'] ?? 0.0).toDouble(),
      volume: (json['volume'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'volume': volume,
    };
  }
}

class PortfolioModel extends Portfolio {
  const PortfolioModel({
    required super.id,
    required super.totalValue,
    required super.totalCost,
    required super.totalReturn,
    required super.totalReturnPercent,
    required super.dayChange,
    required super.dayChangePercent,
    required super.holdings,
    required super.lastUpdated,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      id: json['id'] ?? '',
      totalValue: (json['totalValue'] ?? 0.0).toDouble(),
      totalCost: (json['totalCost'] ?? 0.0).toDouble(),
      totalReturn: (json['totalReturn'] ?? 0.0).toDouble(),
      totalReturnPercent: (json['totalReturnPercent'] ?? 0.0).toDouble(),
      dayChange: (json['dayChange'] ?? 0.0).toDouble(),
      dayChangePercent: (json['dayChangePercent'] ?? 0.0).toDouble(),
      holdings: (json['holdings'] as List<dynamic>?)
              ?.map((e) => StockHoldingModel.fromJson(e))
              .toList() ??
          [],
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalValue': totalValue,
      'totalCost': totalCost,
      'totalReturn': totalReturn,
      'totalReturnPercent': totalReturnPercent,
      'dayChange': dayChange,
      'dayChangePercent': dayChangePercent,
      'holdings': holdings.map((e) => (e as StockHoldingModel).toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class StockHoldingModel extends StockHolding {
  const StockHoldingModel({
    required super.symbol,
    required super.name,
    required super.shares,
    required super.averageCost,
    required super.currentPrice,
    required super.totalValue,
    required super.totalReturn,
    required super.totalReturnPercent,
    required super.dayChange,
    required super.dayChangePercent,
    required super.purchaseDate,
  });

  factory StockHoldingModel.fromJson(Map<String, dynamic> json) {
    return StockHoldingModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      shares: json['shares'] ?? 0,
      averageCost: (json['averageCost'] ?? 0.0).toDouble(),
      currentPrice: (json['currentPrice'] ?? 0.0).toDouble(),
      totalValue: (json['totalValue'] ?? 0.0).toDouble(),
      totalReturn: (json['totalReturn'] ?? 0.0).toDouble(),
      totalReturnPercent: (json['totalReturnPercent'] ?? 0.0).toDouble(),
      dayChange: (json['dayChange'] ?? 0.0).toDouble(),
      dayChangePercent: (json['dayChangePercent'] ?? 0.0).toDouble(),
      purchaseDate: DateTime.parse(json['purchaseDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'shares': shares,
      'averageCost': averageCost,
      'currentPrice': currentPrice,
      'totalValue': totalValue,
      'totalReturn': totalReturn,
      'totalReturnPercent': totalReturnPercent,
      'dayChange': dayChange,
      'dayChangePercent': dayChangePercent,
      'purchaseDate': purchaseDate.toIso8601String(),
    };
  }
}

class StockOrderModel extends StockOrder {
  const StockOrderModel({
    required super.id,
    required super.symbol,
    required super.type,
    required super.side,
    required super.quantity,
    super.price,
    required super.status,
    required super.createdAt,
    super.executedAt,
    super.executedPrice,
  });

  factory StockOrderModel.fromJson(Map<String, dynamic> json) {
    return StockOrderModel(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      type: OrderType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => OrderType.market,
      ),
      side: OrderSide.values.firstWhere(
        (e) => e.toString().split('.').last == json['side'],
        orElse: () => OrderSide.buy,
      ),
      quantity: json['quantity'] ?? 0,
      price: json['price']?.toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      executedAt: json['executedAt'] != null ? DateTime.parse(json['executedAt']) : null,
      executedPrice: json['executedPrice']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'type': type.toString().split('.').last,
      'side': side.toString().split('.').last,
      'quantity': quantity,
      'price': price,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'executedAt': executedAt?.toIso8601String(),
      'executedPrice': executedPrice,
    };
  }
}

class MarketNewsModel extends MarketNews {
  const MarketNewsModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.content,
    required super.source,
    required super.imageUrl,
    required super.relatedSymbols,
    required super.publishedAt,
    required super.url,
  });

  factory MarketNewsModel.fromJson(Map<String, dynamic> json) {
    return MarketNewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      content: json['content'] ?? '',
      source: json['source'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      relatedSymbols: List<String>.from(json['relatedSymbols'] ?? []),
      publishedAt: DateTime.parse(json['publishedAt'] ?? DateTime.now().toIso8601String()),
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'source': source,
      'imageUrl': imageUrl,
      'relatedSymbols': relatedSymbols,
      'publishedAt': publishedAt.toIso8601String(),
      'url': url,
    };
  }
}

class WatchlistModel extends Watchlist {
  const WatchlistModel({
    required super.id,
    required super.name,
    required super.symbols,
    required super.createdAt,
    required super.lastUpdated,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) {
    return WatchlistModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      symbols: List<String>.from(json['symbols'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbols': symbols,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
} 