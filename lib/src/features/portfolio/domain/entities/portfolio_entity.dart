import 'package:equatable/equatable.dart';

/// Represents a single asset in the portfolio
class PortfolioAsset extends Equatable {
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

  const PortfolioAsset({
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

  bool get isProfit => gainLoss >= 0;

  String get formattedValue => '${currency} ${currentValue.toStringAsFixed(2)}';

  String get formattedGainLoss {
    final sign = gainLoss >= 0 ? '+' : '';
    return '$sign${currency} ${gainLoss.toStringAsFixed(2)}';
  }

  String get formattedGainLossPercent {
    final sign = gainLossPercent >= 0 ? '+' : '';
    return '$sign${gainLossPercent.toStringAsFixed(2)}%';
  }

  String get assetTypeDisplay {
    switch (assetType) {
      case 'account':
        return 'Account';
      case 'crypto':
        return 'Crypto';
      case 'stock':
        return 'Stock';
      case 'investment':
        return 'Investment';
      case 'savings':
        return 'Savings';
      case 'financial_goal':
        return 'Goal';
      default:
        return assetType;
    }
  }

  String get assetIcon {
    switch (assetType) {
      case 'account':
        return 'assets/images/icons/wallet.png';
      case 'crypto':
        return 'assets/images/currencies/${symbol.toLowerCase()}.png';
      case 'stock':
        return 'assets/images/icons/stocks.png';
      case 'investment':
        return 'assets/images/icons/investment.png';
      case 'savings':
        return 'assets/images/icons/savings.png';
      case 'financial_goal':
        return 'assets/images/icons/goal.png';
      default:
        return 'assets/images/icons/default.png';
    }
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

/// Represents overall portfolio statistics
class PortfolioSummary extends Equatable {
  final double totalValue;
  final double totalGainLoss;
  final double totalGainLossPercent;
  final double totalInvested;
  final String currency;
  final Map<String, double> assetsByType;
  final int assetCount;
  final DateTime lastUpdated;

  const PortfolioSummary({
    required this.totalValue,
    required this.totalGainLoss,
    required this.totalGainLossPercent,
    required this.totalInvested,
    required this.currency,
    required this.assetsByType,
    required this.assetCount,
    required this.lastUpdated,
  });

  bool get isProfit => totalGainLoss >= 0;

  String get formattedTotalValue => '${currency} ${totalValue.toStringAsFixed(2)}';

  String get formattedGainLoss {
    final sign = totalGainLoss >= 0 ? '+' : '';
    return '$sign${currency} ${totalGainLoss.toStringAsFixed(2)}';
  }

  String get formattedGainLossPercent {
    final sign = totalGainLossPercent >= 0 ? '+' : '';
    return '$sign${totalGainLossPercent.toStringAsFixed(2)}%';
  }

  double get accountsValue => assetsByType['accounts'] ?? 0.0;
  double get investmentsValue => assetsByType['investments'] ?? 0.0;
  double get savingsValue => assetsByType['savings'] ?? 0.0;
  double get goalsValue => assetsByType['goals'] ?? 0.0;

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

/// Complete portfolio data
class Portfolio extends Equatable {
  final PortfolioSummary summary;
  final List<PortfolioAsset> assets;

  const Portfolio({
    required this.summary,
    required this.assets,
  });

  List<PortfolioAsset> getAssetsByType(String type) {
    return assets.where((asset) => asset.assetType == type).toList();
  }

  List<PortfolioAsset> get accounts => getAssetsByType('account');
  List<PortfolioAsset> get cryptoAssets => getAssetsByType('crypto');
  List<PortfolioAsset> get stocks => getAssetsByType('stock');
  List<PortfolioAsset> get investments => getAssetsByType('investment');
  List<PortfolioAsset> get savings => getAssetsByType('savings');
  List<PortfolioAsset> get goals => getAssetsByType('financial_goal');

  @override
  List<Object?> get props => [summary, assets];
}

/// Portfolio history data point
class PortfolioHistoryPoint extends Equatable {
  final DateTime date;
  final double value;

  const PortfolioHistoryPoint({
    required this.date,
    required this.value,
  });

  @override
  List<Object?> get props => [date, value];
}
