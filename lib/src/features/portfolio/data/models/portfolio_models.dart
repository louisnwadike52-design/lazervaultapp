import '../../domain/entities/portfolio_entity.dart';
import '../../../../generated/portfolio.pb.dart' as pb;

/// Portfolio Asset Model
class PortfolioAssetModel extends PortfolioAsset {
  const PortfolioAssetModel({
    required super.id,
    required super.assetType,
    required super.name,
    required super.symbol,
    required super.currentValue,
    required super.quantity,
    required super.currentPrice,
    required super.initialValue,
    required super.gainLoss,
    required super.gainLossPercent,
    required super.currency,
    required super.lastUpdated,
    super.iconUrl,
  });

  /// Create from proto message
  factory PortfolioAssetModel.fromProto(pb.PortfolioAsset proto) {
    return PortfolioAssetModel(
      id: proto.id,
      assetType: proto.assetType,
      name: proto.name,
      symbol: proto.symbol,
      currentValue: proto.currentValue,
      quantity: proto.quantity,
      currentPrice: proto.currentPrice,
      initialValue: proto.initialValue,
      gainLoss: proto.gainLoss,
      gainLossPercent: proto.gainLossPercent,
      currency: proto.currency,
      lastUpdated: proto.lastUpdated.toDateTime(),
      iconUrl: proto.iconUrl.isEmpty ? null : proto.iconUrl,
    );
  }
}

/// Portfolio Summary Model
class PortfolioSummaryModel extends PortfolioSummary {
  const PortfolioSummaryModel({
    required super.totalValue,
    required super.totalGainLoss,
    required super.totalGainLossPercent,
    required super.totalInvested,
    required super.currency,
    required super.assetsByType,
    required super.assetCount,
    required super.lastUpdated,
  });

  /// Create from proto message
  factory PortfolioSummaryModel.fromProto(pb.PortfolioSummary proto) {
    return PortfolioSummaryModel(
      totalValue: proto.totalValue,
      totalGainLoss: proto.totalGainLoss,
      totalGainLossPercent: proto.totalGainLossPercent,
      totalInvested: proto.totalInvested,
      currency: proto.currency,
      assetsByType: Map<String, double>.from(proto.assetsByType),
      assetCount: proto.assetCount,
      lastUpdated: proto.lastUpdated.toDateTime(),
    );
  }
}

/// Portfolio Model
class PortfolioModel extends Portfolio {
  const PortfolioModel({
    required super.summary,
    required super.assets,
  });

  /// Create from proto response
  factory PortfolioModel.fromProtoResponse(pb.GetCompletePortfolioResponse proto) {
    final summary = PortfolioSummaryModel.fromProto(proto.summary);
    final assets = proto.assets
        .map((asset) => PortfolioAssetModel.fromProto(asset))
        .toList();

    return PortfolioModel(
      summary: summary,
      assets: assets,
    );
  }
}
