import '../entities/portfolio_entity.dart';

/// Repository interface for portfolio operations
abstract class PortfolioRepository {
  /// Get complete user portfolio with all assets and summary
  Future<Portfolio> getCompletePortfolio();

  /// Get portfolio filtered by asset type
  Future<List<PortfolioAsset>> getPortfolioByAssetType(String assetType);

  /// Get portfolio summary only (without asset details)
  Future<PortfolioSummary> getPortfolioSummary();

  /// Get portfolio value history for a specific period
  Future<List<PortfolioHistoryPoint>> getPortfolioHistory(String period);
}
