import 'package:equatable/equatable.dart';
import 'price_point.dart';
part 'stock_entity_widgets.dart';


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
  final List<PricePoint> priceHistory;
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

  Map<String, dynamic> toJson() => {
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

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    symbol: json['symbol'] as String,
    name: json['name'] as String,
    currentPrice: (json['currentPrice'] as num).toDouble(),
    previousClose: (json['previousClose'] as num).toDouble(),
    change: (json['change'] as num).toDouble(),
    changePercent: (json['changePercent'] as num).toDouble(),
    dayHigh: (json['dayHigh'] as num).toDouble(),
    dayLow: (json['dayLow'] as num).toDouble(),
    volume: (json['volume'] as num).toDouble(),
    marketCap: (json['marketCap'] as num).toDouble(),
    peRatio: (json['peRatio'] as num).toDouble(),
    dividendYield: (json['dividendYield'] as num).toDouble(),
    sector: json['sector'] as String,
    industry: json['industry'] as String,
    logoUrl: json['logoUrl'] as String,
    priceHistory: const [],
    lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    weekHigh52: (json['weekHigh52'] as num).toDouble(),
    weekLow52: (json['weekLow52'] as num).toDouble(),
    avgVolume: (json['avgVolume'] as num).toDouble(),
    beta: (json['beta'] as num).toDouble(),
    eps: (json['eps'] as num).toDouble(),
    description: json['description'] as String,
    exchange: json['exchange'] as String,
    currency: json['currency'] as String,
  );

  /// Placeholder for navigation; [StockDetailsScreen] loads full quote via cubit.
  factory Stock.navigationStub(String symbol, {String currency = 'USD'}) {
    final now = DateTime.now();
    return Stock(
      symbol: symbol.toUpperCase(),
      name: symbol.toUpperCase(),
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
      lastUpdated: now,
      weekHigh52: 0,
      weekLow52: 0,
      avgVolume: 0,
      beta: 0,
      eps: 0,
      description: '',
      exchange: '',
      currency: currency,
    );
  }

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