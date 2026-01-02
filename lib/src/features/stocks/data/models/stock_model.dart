import '../../domain/entities/stock_entity.dart';
import '../../domain/entities/price_point.dart';

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
    required super.weekHigh52,
    required super.weekLow52,
    required super.avgVolume,
    required super.beta,
    required super.eps,
    required super.description,
    required super.exchange,
    required super.currency,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    // Support both snake_case (from API) and camelCase (local)
    return StockModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      currentPrice: (json['current_price'] ?? json['currentPrice'] ?? 0.0).toDouble(),
      previousClose: (json['previous_close'] ?? json['previousClose'] ?? 0.0).toDouble(),
      change: (json['change'] ?? 0.0).toDouble(),
      changePercent: (json['change_percent'] ?? json['changePercent'] ?? 0.0).toDouble(),
      dayHigh: (json['day_high'] ?? json['dayHigh'] ?? 0.0).toDouble(),
      dayLow: (json['day_low'] ?? json['dayLow'] ?? 0.0).toDouble(),
      volume: (json['volume'] ?? 0.0).toDouble(),
      marketCap: (json['market_cap'] ?? json['marketCap'] ?? 0.0).toDouble(),
      peRatio: (json['pe_ratio'] ?? json['peRatio'] ?? 0.0).toDouble(),
      dividendYield: (json['dividend_yield'] ?? json['dividendYield'] ?? 0.0).toDouble(),
      sector: json['sector'] ?? '',
      industry: json['industry'] ?? '',
      logoUrl: json['logo_url'] ?? json['logoUrl'] ?? '',
      priceHistory: (json['price_history'] ?? json['priceHistory'] as List<dynamic>?)
              ?.map((e) => PricePoint(
                timestamp: DateTime.parse(e['timestamp']),
                price: (e['price'] ?? e['close'] as num).toDouble(),
                volume: (e['volume'] as num?)?.toDouble(),
              ))
              .toList() ??
          [],
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'])
          : (json['lastUpdated'] != null
              ? DateTime.parse(json['lastUpdated'])
              : DateTime.now()),
      weekHigh52: (json['week_52_high'] ?? json['weekHigh52'] ?? 0.0).toDouble(),
      weekLow52: (json['week_52_low'] ?? json['weekLow52'] ?? 0.0).toDouble(),
      avgVolume: (json['avg_volume'] ?? json['avgVolume'] ?? 0.0).toDouble(),
      beta: (json['beta'] ?? 0.0).toDouble(),
      eps: (json['eps'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      exchange: json['exchange'] ?? '',
      currency: json['currency'] ?? 'USD',
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
      'priceHistory': priceHistory.map((e) => {
        'timestamp': e.timestamp.toIso8601String(),
        'price': e.price,
        'volume': e.volume,
      }).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'weekHigh52': weekHigh52,
      'weekLow52': weekLow52,
      'avgVolume': avgVolume,
      'beta': beta,
      'eps': eps,
      'description': description,
      'exchange': exchange,
      'currency': currency,
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
    required super.availableCash,
    required super.totalInvested,
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
      availableCash: (json['availableCash'] ?? 0.0).toDouble(),
      totalInvested: (json['totalInvested'] ?? 0.0).toDouble(),
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
      'availableCash': availableCash,
      'totalInvested': totalInvested,
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
    required super.logoUrl,
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
      logoUrl: json['logoUrl'] ?? '',
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
      'logoUrl': logoUrl,
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
    super.executedQuantity,
    super.fees,
    super.notes,
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
      executedQuantity: json['executedQuantity']?.toInt(),
      fees: json['fees']?.toDouble(),
      notes: json['notes'],
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
      'executedQuantity': executedQuantity,
      'fees': fees,
      'notes': notes,
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
    required super.category,
    required super.readTime,
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
      category: NewsCategory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
        orElse: () => NewsCategory.market,
      ),
      readTime: json['readTime'] ?? 5,
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
      'category': category.toString().split('.').last,
      'readTime': readTime,
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
    super.isDefault = false,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) {
    return WatchlistModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      symbols: List<String>.from(json['symbols'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbols': symbols,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'isDefault': isDefault,
    };
  }
}

class MarketIndexModel extends MarketIndex {
  const MarketIndexModel({
    required super.symbol,
    required super.name,
    required super.value,
    required super.change,
    required super.changePercent,
    required super.lastUpdated,
  });

  factory MarketIndexModel.fromJson(Map<String, dynamic> json) {
    return MarketIndexModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      value: (json['value'] ?? 0.0).toDouble(),
      change: (json['change'] ?? 0.0).toDouble(),
      changePercent: (json['changePercent'] ?? 0.0).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'value': value,
      'change': change,
      'changePercent': changePercent,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class StockAlertModel extends StockAlert {
  const StockAlertModel({
    required super.id,
    required super.symbol,
    required super.type,
    required super.condition,
    required super.targetValue,
    super.message,
    required super.isActive,
    required super.createdAt,
    super.triggeredAt,
  });

  factory StockAlertModel.fromJson(Map<String, dynamic> json) {
    return StockAlertModel(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      type: AlertType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => AlertType.price,
      ),
      condition: AlertCondition.values.firstWhere(
        (e) => e.toString().split('.').last == json['condition'],
        orElse: () => AlertCondition.above,
      ),
      targetValue: (json['targetValue'] ?? 0.0).toDouble(),
      message: json['message'],
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      triggeredAt: json['triggeredAt'] != null ? DateTime.parse(json['triggeredAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'type': type.toString().split('.').last,
      'condition': condition.toString().split('.').last,
      'targetValue': targetValue,
      'message': message,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'triggeredAt': triggeredAt?.toIso8601String(),
    };
  }
}

class TradingSessionModel extends TradingSession {
  const TradingSessionModel({
    required super.id,
    required super.userId,
    required super.startTime,
    super.endTime,
    required super.startingBalance,
    required super.currentBalance,
    required super.totalPnL,
    required super.totalTrades,
    required super.winningTrades,
    required super.losingTrades,
    required super.orders,
  });

  factory TradingSessionModel.fromJson(Map<String, dynamic> json) {
    return TradingSessionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      startTime: DateTime.parse(json['startTime'] ?? DateTime.now().toIso8601String()),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      startingBalance: (json['startingBalance'] ?? 0.0).toDouble(),
      currentBalance: (json['currentBalance'] ?? 0.0).toDouble(),
      totalPnL: (json['totalPnL'] ?? 0.0).toDouble(),
      totalTrades: json['totalTrades'] ?? 0,
      winningTrades: json['winningTrades'] ?? 0,
      losingTrades: json['losingTrades'] ?? 0,
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) => StockOrderModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'startingBalance': startingBalance,
      'currentBalance': currentBalance,
      'totalPnL': totalPnL,
      'totalTrades': totalTrades,
      'winningTrades': winningTrades,
      'losingTrades': losingTrades,
      'orders': orders.map((e) => (e as StockOrderModel).toJson()).toList(),
    };
  }
}

class StockAnalysisModel extends StockAnalysis {
  const StockAnalysisModel({
    required super.symbol,
    required super.rating,
    required super.targetPrice,
    required super.stopLoss,
    required super.technicalIndicators,
    required super.fundamentalMetrics,
    required super.summary,
    required super.lastUpdated,
  });

  factory StockAnalysisModel.fromJson(Map<String, dynamic> json) {
    return StockAnalysisModel(
      symbol: json['symbol'] ?? '',
      rating: AnalysisRating.values.firstWhere(
        (e) => e.toString().split('.').last == json['rating'],
        orElse: () => AnalysisRating.hold,
      ),
      targetPrice: (json['targetPrice'] ?? 0.0).toDouble(),
      stopLoss: (json['stopLoss'] ?? 0.0).toDouble(),
      summary: json['summary'] ?? '',
      technicalIndicators: (json['technicalIndicators'] as List<dynamic>?)
              ?.map((e) => TechnicalIndicatorModel.fromJson(e))
              .toList() ??
          [],
      fundamentalMetrics: (json['fundamentalMetrics'] as List<dynamic>?)
              ?.map((e) => FundamentalMetricModel.fromJson(e))
              .toList() ??
          [],
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'rating': rating.toString().split('.').last,
      'targetPrice': targetPrice,
      'stopLoss': stopLoss,
      'summary': summary,
      'technicalIndicators': technicalIndicators.map((e) => (e as TechnicalIndicatorModel).toJson()).toList(),
      'fundamentalMetrics': fundamentalMetrics.map((e) => (e as FundamentalMetricModel).toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class TechnicalIndicatorModel extends TechnicalIndicator {
  const TechnicalIndicatorModel({
    required super.name,
    required super.value,
    required super.signal,
    required super.description,
  });

  factory TechnicalIndicatorModel.fromJson(Map<String, dynamic> json) {
    return TechnicalIndicatorModel(
      name: json['name'] ?? '',
      value: (json['value'] ?? 0.0).toDouble(),
      signal: json['signal'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'signal': signal,
      'description': description,
    };
  }
}

class FundamentalMetricModel extends FundamentalMetric {
  const FundamentalMetricModel({
    required super.name,
    required super.value,
    required super.unit,
    required super.description,
  });

  factory FundamentalMetricModel.fromJson(Map<String, dynamic> json) {
    return FundamentalMetricModel(
      name: json['name'] ?? '',
      value: (json['value'] ?? 0.0).toDouble(),
      unit: json['unit'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'unit': unit,
      'description': description,
    };
  }
}

class SectorPerformanceModel extends SectorPerformance {
  const SectorPerformanceModel({
    required super.sector,
    required super.change,
    required super.changePercent,
    required super.marketCap,
    required super.topStocks,
  });

  factory SectorPerformanceModel.fromJson(Map<String, dynamic> json) {
    return SectorPerformanceModel(
      sector: json['sector'] ?? '',
      change: (json['change'] ?? 0.0).toDouble(),
      changePercent: (json['changePercent'] ?? 0.0).toDouble(),
      marketCap: (json['marketCap'] ?? 0.0).toDouble(),
      topStocks: List<String>.from(json['topStocks'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sector': sector,
      'change': change,
      'changePercent': changePercent,
      'marketCap': marketCap,
      'topStocks': topStocks,
    };
  }
}

class OptionContractModel extends OptionContract {
  const OptionContractModel({
    required super.symbol,
    required super.underlyingSymbol,
    required super.type,
    required super.strikePrice,
    required super.expirationDate,
    required super.premium,
    required super.impliedVolatility,
    required super.delta,
    required super.gamma,
    required super.theta,
    required super.vega,
    required super.openInterest,
    required super.volume,
  });

  factory OptionContractModel.fromJson(Map<String, dynamic> json) {
    return OptionContractModel(
      symbol: json['symbol'] ?? '',
      underlyingSymbol: json['underlyingSymbol'] ?? '',
      type: OptionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => OptionType.call,
      ),
      strikePrice: (json['strikePrice'] ?? 0.0).toDouble(),
      expirationDate: DateTime.parse(json['expirationDate'] ?? DateTime.now().toIso8601String()),
      premium: (json['premium'] ?? 0.0).toDouble(),
      impliedVolatility: (json['impliedVolatility'] ?? 0.0).toDouble(),
      delta: (json['delta'] ?? 0.0).toDouble(),
      gamma: (json['gamma'] ?? 0.0).toDouble(),
      theta: (json['theta'] ?? 0.0).toDouble(),
      vega: (json['vega'] ?? 0.0).toDouble(),
      openInterest: json['openInterest'] ?? 0,
      volume: json['volume'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'underlyingSymbol': underlyingSymbol,
      'type': type.toString().split('.').last,
      'strikePrice': strikePrice,
      'expirationDate': expirationDate.toIso8601String(),
      'premium': premium,
      'impliedVolatility': impliedVolatility,
      'delta': delta,
      'gamma': gamma,
      'theta': theta,
      'vega': vega,
      'openInterest': openInterest,
      'volume': volume,
    };
  }
} 