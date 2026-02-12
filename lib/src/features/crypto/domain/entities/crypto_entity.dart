import 'package:equatable/equatable.dart';
import 'price_point.dart';

class Crypto extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double? fullyDilutedValuation;
  final double totalVolume;
  final double high24h;
  final double low24h;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final double? priceChangePercentage7d;
  final double? priceChangePercentage30d;
  final double? priceChangePercentage1y;
  final double? marketCapChange24h;
  final double? marketCapChangePercentage24h;
  final double circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double? ath;
  final double? athChangePercentage;
  final DateTime? athDate;
  final double? atl;
  final double? atlChangePercentage;
  final DateTime? atlDate;
  final DateTime lastUpdated;
  final double? sparklineIn7d;
  final List<PricePoint> priceHistory;
  final bool isFavorite;

  const Crypto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    this.priceChangePercentage7d,
    this.priceChangePercentage30d,
    this.priceChangePercentage1y,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    required this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    required this.lastUpdated,
    this.sparklineIn7d,
    this.priceHistory = const [],
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        currentPrice,
        marketCap,
        marketCapRank,
        fullyDilutedValuation,
        totalVolume,
        high24h,
        low24h,
        priceChange24h,
        priceChangePercentage24h,
        priceChangePercentage7d,
        priceChangePercentage30d,
        priceChangePercentage1y,
        marketCapChange24h,
        marketCapChangePercentage24h,
        circulatingSupply,
        totalSupply,
        maxSupply,
        ath,
        athChangePercentage,
        athDate,
        atl,
        atlChangePercentage,
        atlDate,
        lastUpdated,
        sparklineIn7d,
        priceHistory,
        isFavorite,
      ];

  Crypto copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    double? currentPrice,
    double? marketCap,
    int? marketCapRank,
    double? fullyDilutedValuation,
    double? totalVolume,
    double? high24h,
    double? low24h,
    double? priceChange24h,
    double? priceChangePercentage24h,
    double? priceChangePercentage7d,
    double? priceChangePercentage30d,
    double? priceChangePercentage1y,
    double? marketCapChange24h,
    double? marketCapChangePercentage24h,
    double? circulatingSupply,
    double? totalSupply,
    double? maxSupply,
    double? ath,
    double? athChangePercentage,
    DateTime? athDate,
    double? atl,
    double? atlChangePercentage,
    DateTime? atlDate,
    DateTime? lastUpdated,
    double? sparklineIn7d,
    List<PricePoint>? priceHistory,
    bool? isFavorite,
  }) {
    return Crypto(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      fullyDilutedValuation: fullyDilutedValuation ?? this.fullyDilutedValuation,
      totalVolume: totalVolume ?? this.totalVolume,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      priceChange24h: priceChange24h ?? this.priceChange24h,
      priceChangePercentage24h: priceChangePercentage24h ?? this.priceChangePercentage24h,
      priceChangePercentage7d: priceChangePercentage7d ?? this.priceChangePercentage7d,
      priceChangePercentage30d: priceChangePercentage30d ?? this.priceChangePercentage30d,
      priceChangePercentage1y: priceChangePercentage1y ?? this.priceChangePercentage1y,
      marketCapChange24h: marketCapChange24h ?? this.marketCapChange24h,
      marketCapChangePercentage24h: marketCapChangePercentage24h ?? this.marketCapChangePercentage24h,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      maxSupply: maxSupply ?? this.maxSupply,
      ath: ath ?? this.ath,
      athChangePercentage: athChangePercentage ?? this.athChangePercentage,
      athDate: athDate ?? this.athDate,
      atl: atl ?? this.atl,
      atlChangePercentage: atlChangePercentage ?? this.atlChangePercentage,
      atlDate: atlDate ?? this.atlDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      sparklineIn7d: sparklineIn7d ?? this.sparklineIn7d,
      priceHistory: priceHistory ?? this.priceHistory,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class CryptoWatchlist extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> cryptoIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CryptoWatchlist({
    required this.id,
    required this.name,
    required this.description,
    required this.cryptoIds,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [id, name, description, cryptoIds, createdAt, updatedAt];

  CryptoWatchlist copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? cryptoIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CryptoWatchlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      cryptoIds: cryptoIds ?? this.cryptoIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CryptoHolding extends Equatable {
  final String id;
  final String cryptoId;
  final String cryptoSymbol;
  final String cryptoName;
  final double quantity;
  final double averagePrice;
  final double currentPrice;
  final double totalValue;
  final double totalGainLoss;
  final double totalGainLossPercentage;
  final DateTime purchaseDate;
  final DateTime lastUpdated;

  const CryptoHolding({
    required this.id,
    required this.cryptoId,
    required this.cryptoSymbol,
    required this.cryptoName,
    required this.quantity,
    required this.averagePrice,
    required this.currentPrice,
    required this.totalValue,
    required this.totalGainLoss,
    required this.totalGainLossPercentage,
    required this.purchaseDate,
    required this.lastUpdated,
  });

  @override
  List<Object> get props => [
        id,
        cryptoId,
        cryptoSymbol,
        cryptoName,
        quantity,
        averagePrice,
        currentPrice,
        totalValue,
        totalGainLoss,
        totalGainLossPercentage,
        purchaseDate,
        lastUpdated,
      ];
}

enum TransactionType { buy, sell, swap }

class CryptoTransaction extends Equatable {
  final String id;
  final String cryptoId;
  final String cryptoSymbol;
  final String cryptoName;
  final TransactionType type;
  final double quantity;
  final double price;
  final double totalAmount;
  final double fees;
  final DateTime timestamp;
  final String status;

  const CryptoTransaction({
    required this.id,
    required this.cryptoId,
    required this.cryptoSymbol,
    required this.cryptoName,
    required this.type,
    required this.quantity,
    required this.price,
    required this.totalAmount,
    required this.fees,
    required this.timestamp,
    required this.status,
  });

  @override
  List<Object> get props => [
        id,
        cryptoId,
        cryptoSymbol,
        cryptoName,
        type,
        quantity,
        price,
        totalAmount,
        fees,
        timestamp,
        status,
      ];
} 