import 'package:equatable/equatable.dart';

/// Portfolio Asset Entity
class PortfolioAssetEntity extends Equatable {
  final String id;
  final String assetType; // "crypto", "stock", "investment", "account", "savings", "financial_goal"
  final String name;
  final String symbol;
  final double currentValue;
  final double quantity;
  final double currentPrice;
  final double initialValue;
  final double gainLoss;
  final double gainLossPercent;
  final String currency;
  final DateTime lastUpdated;
  final String? iconUrl;

  const PortfolioAssetEntity({
    required this.id,
    required this.assetType,
    required this.name,
    required this.symbol,
    required this.currentValue,
    required this.quantity,
    required this.currentPrice,
    required this.initialValue,
    required this.gainLoss,
    required this.gainLossPercent,
    required this.currency,
    required this.lastUpdated,
    this.iconUrl,
  });

  bool get isPositiveGain => gainLoss >= 0;
  bool get isNegativeGain => gainLoss < 0;

  String get formattedGainLoss {
    final sign = isPositiveGain ? '+' : '';
    return '$sign${gainLoss.toStringAsFixed(2)}';
  }

  String get formattedGainLossPercent {
    final sign = isPositiveGain ? '+' : '';
    return '$sign${gainLossPercent.toStringAsFixed(2)}%';
  }

  @override
  List<Object?> get props => [
        id,
        assetType,
        name,
        symbol,
        currentValue,
        quantity,
        currentPrice,
        initialValue,
        gainLoss,
        gainLossPercent,
        currency,
        lastUpdated,
        iconUrl,
      ];
}

/// Portfolio Summary Entity
class PortfolioSummaryEntity extends Equatable {
  final double totalValue;
  final double totalGainLoss;
  final double totalGainLossPercent;
  final double totalInvested;
  final String currency;
  final Map<String, double> assetsByType;
  final int assetCount;
  final DateTime lastUpdated;

  const PortfolioSummaryEntity({
    required this.totalValue,
    required this.totalGainLoss,
    required this.totalGainLossPercent,
    required this.totalInvested,
    required this.currency,
    required this.assetsByType,
    required this.assetCount,
    required this.lastUpdated,
  });

  bool get isPositiveGain => totalGainLoss >= 0;
  bool get isNegativeGain => totalGainLoss < 0;

  String get formattedTotalGainLoss {
    final sign = isPositiveGain ? '+' : '';
    return '$sign$currency ${totalGainLoss.toStringAsFixed(2)}';
  }

  String get formattedTotalGainLossPercent {
    final sign = isPositiveGain ? '+' : '';
    return '$sign${totalGainLossPercent.toStringAsFixed(2)}%';
  }

  @override
  List<Object?> get props => [
        totalValue,
        totalGainLoss,
        totalGainLossPercent,
        totalInvested,
        currency,
        assetsByType,
        assetCount,
        lastUpdated,
      ];
}

/// Complete Portfolio Entity
class PortfolioEntity extends Equatable {
  final PortfolioSummaryEntity summary;
  final List<PortfolioAssetEntity> assets;

  const PortfolioEntity({
    required this.summary,
    required this.assets,
  });

  /// Get assets filtered by type
  List<PortfolioAssetEntity> getAssetsByType(String assetType) {
    return assets.where((asset) => asset.assetType == assetType).toList();
  }

  /// Get top performing assets
  List<PortfolioAssetEntity> getTopPerformers({int limit = 5}) {
    final sortedAssets = List<PortfolioAssetEntity>.from(assets)
      ..sort((a, b) => b.gainLossPercent.compareTo(a.gainLossPercent));
    return sortedAssets.take(limit).toList();
  }

  /// Get worst performing assets
  List<PortfolioAssetEntity> getWorstPerformers({int limit = 5}) {
    final sortedAssets = List<PortfolioAssetEntity>.from(assets)
      ..sort((a, b) => a.gainLossPercent.compareTo(b.gainLossPercent));
    return sortedAssets.take(limit).toList();
  }

  @override
  List<Object?> get props => [summary, assets];
}
