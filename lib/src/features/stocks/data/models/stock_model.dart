import '../../domain/entities/stock_entity.dart';
import '../../domain/entities/price_point.dart';
part 'stock_model_widgets.dart';


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