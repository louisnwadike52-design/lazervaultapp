import 'package:equatable/equatable.dart';

class GlobalMarketData extends Equatable {
  final double totalMarketCap;
  final double totalVolume24h;
  final double marketCapPercentageBtc;
  final double marketCapPercentageEth;
  final int activeCryptocurrencies;
  final int markets;
  final DateTime updatedAt;
  // Admin-configured crypto disclosure URL (system_settings key
  // `crypto.disclosure_url`). Empty string = footer hides the CTA.
  final String disclosureUrl;
  // Admin-configured "learn more" URL for the landing-page risk warning
  // (system_settings key `crypto.risk_disclaimer_url`). Empty = the warning
  // shows as plain text with no tappable "learn more".
  final String learnMoreUrl;

  const GlobalMarketData({
    required this.totalMarketCap,
    required this.totalVolume24h,
    required this.marketCapPercentageBtc,
    required this.marketCapPercentageEth,
    required this.activeCryptocurrencies,
    required this.markets,
    required this.updatedAt,
    this.disclosureUrl = '',
    this.learnMoreUrl = '',
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
        disclosureUrl,
        learnMoreUrl,
      ];
}
