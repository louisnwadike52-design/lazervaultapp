import '../../domain/entities/portfolio_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_grpc_data_source.dart';
import '../models/portfolio_models.dart';

/// Portfolio Repository Implementation
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioGrpcDataSource _dataSource;

  const PortfolioRepositoryImpl(this._dataSource);

  @override
  Future<Portfolio> getCompletePortfolio() async {
    try {
      final response = await _dataSource.getCompletePortfolio();

      if (!response.success) {
        throw Exception(response.message);
      }

      final summary = PortfolioSummaryModel.fromProto(response.summary);
      final assets = response.assets
          .map((asset) => PortfolioAssetModel.fromProto(asset))
          .toList();

      return Portfolio(
        summary: summary,
        assets: assets,
      );
    } catch (e) {
      throw Exception('Failed to get complete portfolio: $e');
    }
  }

  @override
  Future<List<PortfolioAsset>> getPortfolioByAssetType(
    String assetType,
  ) async {
    try {
      final response = await _dataSource.getPortfolioByAssetType(assetType);

      if (!response.success) {
        throw Exception(response.message);
      }

      return response.assets
          .map((asset) => PortfolioAssetModel.fromProto(asset))
          .toList();
    } catch (e) {
      throw Exception('Failed to get portfolio by asset type: $e');
    }
  }

  @override
  Future<PortfolioSummary> getPortfolioSummary() async {
    try {
      final response = await _dataSource.getPortfolioSummary();

      if (!response.success) {
        throw Exception(response.message);
      }

      return PortfolioSummaryModel.fromProto(response.summary);
    } catch (e) {
      throw Exception('Failed to get portfolio summary: $e');
    }
  }

  @override
  Future<List<PortfolioHistoryPoint>> getPortfolioHistory(String period) async {
    try {
      final response = await _dataSource.getPortfolioHistory(period);

      if (!response.success) {
        throw Exception(response.message);
      }

      return response.history
          .map((point) => PortfolioHistoryPoint(
                date: point.date.toDateTime(),
                value: point.value,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to get portfolio history: $e');
    }
  }
}
