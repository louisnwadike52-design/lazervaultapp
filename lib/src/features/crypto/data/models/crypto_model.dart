import '../../domain/entities/crypto_entity.dart';
import '../../domain/entities/price_point.dart';

class CryptoModel extends Crypto {
  const CryptoModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.marketCap,
    required super.marketCapRank,
    super.fullyDilutedValuation,
    required super.totalVolume,
    required super.high24h,
    required super.low24h,
    required super.priceChange24h,
    required super.priceChangePercentage24h,
    super.priceChangePercentage7d,
    super.priceChangePercentage30d,
    super.priceChangePercentage1y,
    super.marketCapChange24h,
    super.marketCapChangePercentage24h,
    required super.circulatingSupply,
    super.totalSupply,
    super.maxSupply,
    super.ath,
    super.athChangePercentage,
    super.athDate,
    super.atl,
    super.atlChangePercentage,
    super.atlDate,
    required super.lastUpdated,
    super.sparklineIn7d,
    super.priceHistory,
    super.isFavorite,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'] ?? '',
      symbol: json['symbol']?.toString().toUpperCase() ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      marketCap: (json['market_cap'] ?? 0).toDouble(),
      marketCapRank: json['market_cap_rank'] ?? 0,
      fullyDilutedValuation: json['fully_diluted_valuation']?.toDouble(),
      totalVolume: (json['total_volume'] ?? 0).toDouble(),
      high24h: (json['high_24h'] ?? 0).toDouble(),
      low24h: (json['low_24h'] ?? 0).toDouble(),
      priceChange24h: (json['price_change_24h'] ?? 0).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] ?? 0).toDouble(),
      priceChangePercentage7d: json['price_change_percentage_7d_in_currency']?.toDouble(),
      priceChangePercentage30d: json['price_change_percentage_30d_in_currency']?.toDouble(),
      priceChangePercentage1y: json['price_change_percentage_1y_in_currency']?.toDouble(),
      marketCapChange24h: json['market_cap_change_24h']?.toDouble(),
      marketCapChangePercentage24h: json['market_cap_change_percentage_24h']?.toDouble(),
      circulatingSupply: (json['circulating_supply'] ?? 0).toDouble(),
      totalSupply: json['total_supply']?.toDouble(),
      maxSupply: json['max_supply']?.toDouble(),
      ath: json['ath']?.toDouble(),
      athChangePercentage: json['ath_change_percentage']?.toDouble(),
      athDate: json['ath_date'] != null ? DateTime.parse(json['ath_date']) : null,
      atl: json['atl']?.toDouble(),
      atlChangePercentage: json['atl_change_percentage']?.toDouble(),
      atlDate: json['atl_date'] != null ? DateTime.parse(json['atl_date']) : null,
      lastUpdated: json['last_updated'] != null 
          ? DateTime.parse(json['last_updated']) 
          : DateTime.now(),
      sparklineIn7d: json['sparkline_in_7d']?['price']?.isNotEmpty == true 
          ? (json['sparkline_in_7d']['price'] as List).last.toDouble() 
          : null,
      priceHistory: json['price_history'] != null
          ? (json['price_history'] as List)
              .map((point) => PricePoint(
                    timestamp: DateTime.fromMillisecondsSinceEpoch(
                      (point[0] as num).toInt(),
                    ),
                    price: (point[1] as num).toDouble(),
                  ))
              .toList()
          : [],
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'fully_diluted_valuation': fullyDilutedValuation,
      'total_volume': totalVolume,
      'high_24h': high24h,
      'low_24h': low24h,
      'price_change_24h': priceChange24h,
      'price_change_percentage_24h': priceChangePercentage24h,
      'price_change_percentage_7d_in_currency': priceChangePercentage7d,
      'price_change_percentage_30d_in_currency': priceChangePercentage30d,
      'price_change_percentage_1y_in_currency': priceChangePercentage1y,
      'market_cap_change_24h': marketCapChange24h,
      'market_cap_change_percentage_24h': marketCapChangePercentage24h,
      'circulating_supply': circulatingSupply,
      'total_supply': totalSupply,
      'max_supply': maxSupply,
      'ath': ath,
      'ath_change_percentage': athChangePercentage,
      'ath_date': athDate?.toIso8601String(),
      'atl': atl,
      'atl_change_percentage': atlChangePercentage,
      'atl_date': atlDate?.toIso8601String(),
      'last_updated': lastUpdated.toIso8601String(),
      'sparkline_in_7d': sparklineIn7d,
      'price_history': priceHistory
          .map((point) => [
                point.timestamp.millisecondsSinceEpoch,
                point.price,
              ])
          .toList(),
      'is_favorite': isFavorite,
    };
  }

  // Create sample data for development
  static List<CryptoModel> sampleCryptos() {
    return [
      CryptoModel(
        id: 'bitcoin',
        symbol: 'BTC',
        name: 'Bitcoin',
        image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
        currentPrice: 43250.50,
        marketCap: 847500000000,
        marketCapRank: 1,
        totalVolume: 23500000000,
        high24h: 43890.25,
        low24h: 42100.75,
        priceChange24h: 1150.25,
        priceChangePercentage24h: 2.73,
        priceChangePercentage7d: -1.45,
        priceChangePercentage30d: 5.67,
        priceChangePercentage1y: 156.23,
        circulatingSupply: 19600000,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 69045.0,
        athChangePercentage: -37.35,
        athDate: DateTime.parse('2021-11-10'),
        atl: 67.81,
        atlChangePercentage: 63658.12,
        atlDate: DateTime.parse('2013-07-06'),
        lastUpdated: DateTime.now(),
        priceHistory: _generateSamplePriceHistory(43250.50),
      ),
      CryptoModel(
        id: 'ethereum',
        symbol: 'ETH',
        name: 'Ethereum',
        image: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png',
        currentPrice: 2650.75,
        marketCap: 318700000000,
        marketCapRank: 2,
        totalVolume: 15200000000,
        high24h: 2698.50,
        low24h: 2580.25,
        priceChange24h: 70.50,
        priceChangePercentage24h: 2.73,
        priceChangePercentage7d: -0.85,
        priceChangePercentage30d: 8.45,
        priceChangePercentage1y: 89.67,
        circulatingSupply: 120280000,
        totalSupply: 120280000,
        ath: 4878.26,
        athChangePercentage: -45.67,
        athDate: DateTime.parse('2021-11-10'),
        atl: 0.432979,
        atlChangePercentage: 612345.78,
        atlDate: DateTime.parse('2015-10-20'),
        lastUpdated: DateTime.now(),
        priceHistory: _generateSamplePriceHistory(2650.75),
      ),
      CryptoModel(
        id: 'binancecoin',
        symbol: 'BNB',
        name: 'BNB',
        image: 'https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png',
        currentPrice: 310.25,
        marketCap: 46500000000,
        marketCapRank: 4,
        totalVolume: 890000000,
        high24h: 315.80,
        low24h: 305.10,
        priceChange24h: 5.15,
        priceChangePercentage24h: 1.69,
        priceChangePercentage7d: 3.22,
        priceChangePercentage30d: -2.34,
        priceChangePercentage1y: 45.78,
        circulatingSupply: 149800000,
        totalSupply: 149800000,
        maxSupply: 200000000,
        ath: 686.31,
        athChangePercentage: -54.78,
        athDate: DateTime.parse('2021-05-10'),
        atl: 0.0398177,
        atlChangePercentage: 778900.56,
        atlDate: DateTime.parse('2017-10-19'),
        lastUpdated: DateTime.now(),
        priceHistory: _generateSamplePriceHistory(310.25),
      ),
    ];
  }

  static List<PricePoint> _generateSamplePriceHistory(double currentPrice) {
    final now = DateTime.now();
    final List<PricePoint> history = [];
    
    for (int i = 30; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final variation = (i * 0.02 - 0.3) * currentPrice;
      final price = currentPrice + variation;
      
      history.add(PricePoint(
        timestamp: date,
        price: price,
        open: price * 0.99,
        high: price * 1.02,
        low: price * 0.98,
        close: price,
        volume: 1000000 + (i * 50000),
      ));
    }
    
    return history;
  }
} 