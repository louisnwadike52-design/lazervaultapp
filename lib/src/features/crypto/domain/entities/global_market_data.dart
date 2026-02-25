import 'package:equatable/equatable.dart';

class GlobalMarketData extends Equatable {
  final double totalMarketCap;
  final double totalVolume24h;
  final double marketCapPercentageBtc;
  final double marketCapPercentageEth;
  final int activeCryptocurrencies;
  final int markets;
  final DateTime updatedAt;

  const GlobalMarketData({
    required this.totalMarketCap,
    required this.totalVolume24h,
    required this.marketCapPercentageBtc,
    required this.marketCapPercentageEth,
    required this.activeCryptocurrencies,
    required this.markets,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        totalMarketCap,
        totalVolume24h,
        marketCapPercentageBtc,
        marketCapPercentageEth,
        activeCryptocurrencies,
        markets,
        updatedAt,
      ];
}
