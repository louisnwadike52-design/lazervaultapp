import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/portfolio.pb.dart' as pb;
import 'package:lazervault/src/features/portfolio/domain/entities/portfolio_entity.dart';
import 'package:lazervault/src/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryGrpcImpl implements PortfolioRepository {
  final GrpcClient grpcClient;
  final GrpcCallOptionsHelper callOptionsHelper;

  PortfolioRepositoryGrpcImpl({
    required this.grpcClient,
    required this.callOptionsHelper,
  });

  @override
  Future<Portfolio> getCompletePortfolio() async {
    try {
      final request = pb.GetCompletePortfolioRequest();
      final options = await callOptionsHelper.withAuth();

      final response = await grpcClient.portfolioClient.getCompletePortfolio(
        request,
        options: options,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      // Convert proto summary to entity
      final summary = _convertSummary(response.summary);

      // Convert proto assets to entities
      final assets = response.assets
          .map((pbAsset) => _convertAsset(pbAsset))
          .toList();

      return Portfolio(
        summary: summary,
        assets: assets,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch portfolio: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch portfolio: $e');
    }
  }

  @override
  Future<List<PortfolioAsset>> getPortfolioByAssetType(String assetType) async {
    try {
      final request = pb.GetPortfolioByAssetTypeRequest()
        ..assetType = assetType;
      final options = await callOptionsHelper.withAuth();

      final response = await grpcClient.portfolioClient.getPortfolioByAssetType(
        request,
        options: options,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      return response.assets
          .map((pbAsset) => _convertAsset(pbAsset))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch assets by type: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch assets by type: $e');
    }
  }

  @override
  Future<PortfolioSummary> getPortfolioSummary() async {
    try {
      final request = pb.GetPortfolioSummaryRequest();
      final options = await callOptionsHelper.withAuth();

      final response = await grpcClient.portfolioClient.getPortfolioSummary(
        request,
        options: options,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      return _convertSummary(response.summary);
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch portfolio summary: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch portfolio summary: $e');
    }
  }

  @override
  Future<List<PortfolioHistoryPoint>> getPortfolioHistory(String period) async {
    try {
      final request = pb.GetPortfolioHistoryRequest()
        ..period = period;
      final options = await callOptionsHelper.withAuth();

      final response = await grpcClient.portfolioClient.getPortfolioHistory(
        request,
        options: options,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      return response.history
          .map((pbPoint) => PortfolioHistoryPoint(
                date: pbPoint.date.toDateTime(),
                value: pbPoint.value,
              ))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch portfolio history: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch portfolio history: $e');
    }
  }

  // Helper methods to convert proto to entity

  PortfolioSummary _convertSummary(pb.PortfolioSummary pbSummary) {
    return PortfolioSummary(
      totalValue: pbSummary.totalValue,
      totalGainLoss: pbSummary.totalGainLoss,
      totalGainLossPercent: pbSummary.totalGainLossPercent,
      totalInvested: pbSummary.totalInvested,
      currency: pbSummary.currency,
      assetsByType: Map<String, double>.from(pbSummary.assetsByType),
      assetCount: pbSummary.assetCount,
      lastUpdated: pbSummary.lastUpdated.toDateTime(),
    );
  }

  PortfolioAsset _convertAsset(pb.PortfolioAsset pbAsset) {
    return PortfolioAsset(
      id: pbAsset.id,
      assetType: pbAsset.assetType,
      name: pbAsset.name,
      symbol: pbAsset.symbol,
      currentValue: pbAsset.currentValue,
      quantity: pbAsset.quantity,
      currentPrice: pbAsset.currentPrice,
      initialValue: pbAsset.initialValue,
      gainLoss: pbAsset.gainLoss,
      gainLossPercent: pbAsset.gainLossPercent,
      currency: pbAsset.currency,
      lastUpdated: pbAsset.lastUpdated.toDateTime(),
      iconUrl: pbAsset.iconUrl.isNotEmpty ? pbAsset.iconUrl : null,
    );
  }
}
