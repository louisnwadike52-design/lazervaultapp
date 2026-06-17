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

  /// Convert from proto message to CryptoModel
  factory CryptoModel.fromProto(dynamic proto) {
    return CryptoModel(
      id: proto.id,
      symbol: proto.symbol.toUpperCase(),
      name: proto.name,
      image: proto.image,
      currentPrice: proto.currentPrice,
      marketCap: proto.marketCap.toDouble(),
      marketCapRank: proto.marketCapRank,
      fullyDilutedValuation: proto.hasFullyDilutedValuation() ? proto.fullyDilutedValuation : null,
      totalVolume: proto.totalVolume.toDouble(),
      high24h: proto.hasHigh24h() ? proto.high24h : 0.0,
      low24h: proto.hasLow24h() ? proto.low24h : 0.0,
      priceChange24h: proto.hasPriceChange24h() ? proto.priceChange24h : 0.0,
      priceChangePercentage24h: proto.hasPriceChangePercentage24h() ? proto.priceChangePercentage24h : 0.0,
      priceChangePercentage7d: proto.hasPriceChangePercentage7d() ? proto.priceChangePercentage7d : null,
      priceChangePercentage30d: proto.hasPriceChangePercentage30d() ? proto.priceChangePercentage30d : null,
      priceChangePercentage1y: proto.hasPriceChangePercentage1y() ? proto.priceChangePercentage1y : null,
      marketCapChange24h: proto.hasMarketCapChange24h() ? proto.marketCapChange24h : null,
      marketCapChangePercentage24h: proto.hasMarketCapChangePercentage24h() ? proto.marketCapChangePercentage24h : null,
      circulatingSupply: proto.circulatingSupply,
      totalSupply: proto.hasTotalSupply() ? proto.totalSupply : null,
      maxSupply: proto.hasMaxSupply() ? proto.maxSupply : null,
      ath: proto.hasAth() ? proto.ath : null,
      athChangePercentage: proto.hasAthChangePercentage() ? proto.athChangePercentage : null,
      athDate: proto.hasAthDate() ? proto.athDate.toDateTime() : null,
      atl: proto.hasAtl() ? proto.atl : null,
      atlChangePercentage: proto.hasAtlChangePercentage() ? proto.atlChangePercentage : null,
      atlDate: proto.hasAtlDate() ? proto.atlDate.toDateTime() : null,
      lastUpdated: proto.hasLastUpdated() ? proto.lastUpdated.toDateTime() : DateTime.now(),
      sparklineIn7d: null,
      priceHistory: proto.priceHistory
          .map((point) => PricePoint(
                timestamp: point.timestamp.toDateTime(),
                price: point.price,
                volume: point.volume,
                open: point.hasOpen() ? point.open : null,
                high: point.hasHigh() ? point.high : null,
                low: point.hasLow() ? point.low : null,
                close: point.hasClose() ? point.close : null,
              ))
          .toList(),
      isFavorite: false,
    );
  }

  Crypto toEntity() => Crypto(
    id: id,
    symbol: symbol,
    name: name,
    image: image,
    currentPrice: currentPrice,
    marketCap: marketCap,
    marketCapRank: marketCapRank,
    fullyDilutedValuation: fullyDilutedValuation,
    totalVolume: totalVolume,
    high24h: high24h,
    low24h: low24h,
    priceChange24h: priceChange24h,
    priceChangePercentage24h: priceChangePercentage24h,
    priceChangePercentage7d: priceChangePercentage7d,
    priceChangePercentage30d: priceChangePercentage30d,
    priceChangePercentage1y: priceChangePercentage1y,
    marketCapChange24h: marketCapChange24h,
    marketCapChangePercentage24h: marketCapChangePercentage24h,
    circulatingSupply: circulatingSupply,
    totalSupply: totalSupply,
    maxSupply: maxSupply,
    ath: ath,
    athChangePercentage: athChangePercentage,
    athDate: athDate,
    atl: atl,
    atlChangePercentage: atlChangePercentage,
    atlDate: atlDate,
    lastUpdated: lastUpdated,
    sparklineIn7d: sparklineIn7d,
    priceHistory: priceHistory,
    isFavorite: isFavorite,
  );
} 