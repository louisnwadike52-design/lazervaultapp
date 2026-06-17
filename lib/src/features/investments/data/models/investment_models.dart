class AssetCatalogItem {
  final String id;
  final String symbol;
  final String name;
  final String assetType;
  final String provider;
  final String region;
  final String currency;
  final String riskLevel;
  final String yieldType;
  final double expectedYield;
  final String description;
  final String exchange;
  final String sector;
  final bool isFeatured;

  AssetCatalogItem({
    required this.id,
    required this.symbol,
    required this.name,
    required this.assetType,
    required this.provider,
    required this.region,
    required this.currency,
    required this.riskLevel,
    required this.yieldType,
    required this.expectedYield,
    required this.description,
    required this.exchange,
    required this.sector,
    required this.isFeatured,
  });

  factory AssetCatalogItem.fromJson(Map<String, dynamic> json) {
    return AssetCatalogItem(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      assetType: json['asset_type'] ?? json['assetType'] ?? '',
      provider: json['provider'] ?? '',
      region: json['region'] ?? '',
      currency: json['currency'] ?? 'USD',
      riskLevel: json['risk_level'] ?? json['riskLevel'] ?? 'medium',
      yieldType: json['yield_type'] ?? json['yieldType'] ?? '',
      expectedYield: (json['expected_yield'] ?? json['expectedYield'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      exchange: json['exchange'] ?? '',
      sector: json['sector'] ?? '',
      isFeatured: json['is_featured'] ?? json['isFeatured'] ?? false,
    );
  }

  String get riskLabel {
    switch (riskLevel) {
      case 'very_low':
        return 'Very Low Risk';
      case 'low':
        return 'Low Risk';
      case 'medium':
        return 'Medium Risk';
      case 'high':
        return 'High Risk';
      default:
        return riskLevel;
    }
  }

  String get yieldLabel {
    if (expectedYield <= 0) return 'N/A';
    return '${expectedYield.toStringAsFixed(1)}% yield';
  }

  String get assetTypeLabel {
    switch (assetType) {
      case 'stock':
        return 'Stock';
      case 'etf':
        return 'ETF';
      case 'reit_etf':
        return 'REIT ETF';
      case 'bond_etf':
        return 'Bond ETF';
      case 'treasury_etf':
        return 'Treasury ETF';
      case 'tbill':
        return 'T-Bill';
      case 'mutual_fund':
        return 'Mutual Fund';
      case 'money_market':
        return 'Money Market';
      default:
        return assetType;
    }
  }
}

class AssetCategory {
  final String name;
  final String displayName;
  final List<AssetCatalogItem> assets;

  AssetCategory({
    required this.name,
    required this.displayName,
    required this.assets,
  });

  factory AssetCategory.fromJson(Map<String, dynamic> json) {
    return AssetCategory(
      name: json['name'] ?? '',
      displayName: json['display_name'] ?? json['displayName'] ?? '',
      assets: (json['assets'] as List?)
              ?.map((a) => AssetCatalogItem.fromJson(a))
              .toList() ??
          [],
    );
  }
}

class FXRate {
  final String fromCurrency;
  final String toCurrency;
  final double marketRate;
  final double buyRate;
  final double sellRate;
  final int spreadBps;
  final String rateId;
  final String updatedAt;

  FXRate({
    required this.fromCurrency,
    required this.toCurrency,
    required this.marketRate,
    required this.buyRate,
    required this.sellRate,
    required this.spreadBps,
    required this.rateId,
    required this.updatedAt,
  });

  factory FXRate.fromJson(Map<String, dynamic> json) {
    return FXRate(
      fromCurrency: json['from_currency'] ?? json['fromCurrency'] ?? '',
      toCurrency: json['to_currency'] ?? json['toCurrency'] ?? '',
      marketRate: (json['market_rate'] ?? json['marketRate'] ?? 0).toDouble(),
      buyRate: (json['buy_rate'] ?? json['buyRate'] ?? 0).toDouble(),
      sellRate: (json['sell_rate'] ?? json['sellRate'] ?? 0).toDouble(),
      spreadBps: json['spread_bps'] ?? json['spreadBps'] ?? 0,
      rateId: json['rate_id'] ?? json['rateId'] ?? '',
      updatedAt: json['updated_at'] ?? json['updatedAt'] ?? '',
    );
  }

  double get spreadPercent => spreadBps / 100.0;
}

class FXConversionResult {
  final String fromCurrency;
  final String toCurrency;
  final double fromAmount;
  final double toAmount;
  final double marketRate;
  final double appliedRate;
  final double spreadProfit;
  final String direction;
  final bool success;
  final String message;

  FXConversionResult({
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromAmount,
    required this.toAmount,
    required this.marketRate,
    required this.appliedRate,
    required this.spreadProfit,
    required this.direction,
    required this.success,
    required this.message,
  });

  factory FXConversionResult.fromJson(Map<String, dynamic> json) {
    return FXConversionResult(
      fromCurrency: json['from_currency'] ?? json['fromCurrency'] ?? '',
      toCurrency: json['to_currency'] ?? json['toCurrency'] ?? '',
      fromAmount: (json['from_amount'] ?? json['fromAmount'] ?? 0).toDouble(),
      toAmount: (json['to_amount'] ?? json['toAmount'] ?? 0).toDouble(),
      marketRate: (json['market_rate'] ?? json['marketRate'] ?? 0).toDouble(),
      appliedRate: (json['applied_rate'] ?? json['appliedRate'] ?? 0).toDouble(),
      spreadProfit: (json['spread_profit'] ?? json['spreadProfit'] ?? 0).toDouble(),
      direction: json['direction'] ?? '',
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class CommissionTier {
  final String assetType;
  final int rateBps;
  final double minAmount;
  final double maxAmount;
  final bool isActive;

  CommissionTier({
    required this.assetType,
    required this.rateBps,
    required this.minAmount,
    required this.maxAmount,
    required this.isActive,
  });

  factory CommissionTier.fromJson(Map<String, dynamic> json) {
    return CommissionTier(
      assetType: json['asset_type'] ?? json['assetType'] ?? '',
      rateBps: json['rate_bps'] ?? json['rateBps'] ?? 0,
      minAmount: (json['min_amount'] ?? json['minAmount'] ?? 0).toDouble(),
      maxAmount: (json['max_amount'] ?? json['maxAmount'] ?? 0).toDouble(),
      isActive: json['is_active'] ?? json['isActive'] ?? true,
    );
  }

  double get ratePercent => rateBps / 100.0;
  String get rateLabel => rateBps == 0 ? 'Free' : '${ratePercent.toStringAsFixed(2)}%';
}

class IncomeEvent {
  final String id;
  final String assetSymbol;
  final String assetType;
  final String incomeType;
  final double grossAmount;
  final double taxWithheld;
  final double netAmount;
  final String currency;
  final String provider;
  final bool isReinvested;
  final String payDate;
  final String createdAt;

  IncomeEvent({
    required this.id,
    required this.assetSymbol,
    required this.assetType,
    required this.incomeType,
    required this.grossAmount,
    required this.taxWithheld,
    required this.netAmount,
    required this.currency,
    required this.provider,
    required this.isReinvested,
    required this.payDate,
    required this.createdAt,
  });

  factory IncomeEvent.fromJson(Map<String, dynamic> json) {
    return IncomeEvent(
      id: json['id'] ?? '',
      assetSymbol: json['asset_symbol'] ?? json['assetSymbol'] ?? '',
      assetType: json['asset_type'] ?? json['assetType'] ?? '',
      incomeType: json['income_type'] ?? json['incomeType'] ?? '',
      grossAmount: (json['gross_amount'] ?? json['grossAmount'] ?? 0).toDouble(),
      taxWithheld: (json['tax_withheld'] ?? json['taxWithheld'] ?? 0).toDouble(),
      netAmount: (json['net_amount'] ?? json['netAmount'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
      provider: json['provider'] ?? '',
      isReinvested: json['is_reinvested'] ?? json['isReinvested'] ?? false,
      payDate: json['pay_date'] ?? json['payDate'] ?? '',
      createdAt: json['created_at'] ?? json['createdAt'] ?? '',
    );
  }

  String get incomeTypeLabel {
    switch (incomeType) {
      case 'dividend':
        return 'Dividend';
      case 'interest':
        return 'Interest';
      case 'distribution':
        return 'Distribution';
      case 'coupon':
        return 'Coupon';
      default:
        return incomeType;
    }
  }
}

class TreasuryBill {
  final String id;
  final String name;
  final int maturityDays;
  final double rate;
  final double unitPrice;
  final String currency;
  final String maturityDate;
  final String status;

  TreasuryBill({
    required this.id,
    required this.name,
    required this.maturityDays,
    required this.rate,
    required this.unitPrice,
    required this.currency,
    required this.maturityDate,
    required this.status,
  });

  factory TreasuryBill.fromJson(Map<String, dynamic> json) {
    return TreasuryBill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      maturityDays: json['maturity_days'] ?? json['maturityDays'] ?? 0,
      rate: (json['rate'] ?? 0).toDouble(),
      unitPrice: (json['unit_price'] ?? json['unitPrice'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'NGN',
      maturityDate: json['maturity_date'] ?? json['maturityDate'] ?? '',
      status: json['status'] ?? '',
    );
  }

  String get maturityLabel {
    if (maturityDays <= 91) return '91 Days';
    if (maturityDays <= 182) return '182 Days';
    return '364 Days';
  }

  String get rateLabel => '${rate.toStringAsFixed(1)}% p.a.';
}

class MutualFund {
  final String id;
  final String name;
  final String fundType;
  final String riskLevel;
  final double returnRate;
  final double minInvestment;
  final String currency;
  final double nav;
  final String status;

  MutualFund({
    required this.id,
    required this.name,
    required this.fundType,
    required this.riskLevel,
    required this.returnRate,
    required this.minInvestment,
    required this.currency,
    required this.nav,
    required this.status,
  });

  factory MutualFund.fromJson(Map<String, dynamic> json) {
    return MutualFund(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      fundType: json['fund_type'] ?? json['fundType'] ?? '',
      riskLevel: json['risk_level'] ?? json['riskLevel'] ?? '',
      returnRate: (json['return_rate'] ?? json['returnRate'] ?? 0).toDouble(),
      minInvestment: (json['min_investment'] ?? json['minInvestment'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'NGN',
      nav: (json['nav'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }

  String get fundTypeLabel {
    switch (fundType) {
      case 'equity':
        return 'Equity Fund';
      case 'money_market':
        return 'Money Market';
      case 'bond':
        return 'Bond Fund';
      case 'balanced':
        return 'Balanced Fund';
      default:
        return fundType;
    }
  }
}
