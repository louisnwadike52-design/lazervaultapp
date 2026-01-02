import '../entities/portfolio_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Get Complete Portfolio Use Case
class GetCompletePortfolioUseCase {
  final PortfolioRepository repository;

  const GetCompletePortfolioUseCase(this.repository);

  Future<Portfolio> call() async {
    return await repository.getCompletePortfolio();
  }
}

/// Get Portfolio By Asset Type Use Case
class GetPortfolioByAssetTypeUseCase {
  final PortfolioRepository repository;

  const GetPortfolioByAssetTypeUseCase(this.repository);

  Future<List<PortfolioAsset>> call(String assetType) async {
    return await repository.getPortfolioByAssetType(assetType);
  }
}

/// Get Portfolio Summary Use Case
class GetPortfolioSummaryUseCase {
  final PortfolioRepository repository;

  const GetPortfolioSummaryUseCase(this.repository);

  Future<PortfolioSummary> call() async {
    return await repository.getPortfolioSummary();
  }
}

/// Get Portfolio History Use Case
class GetPortfolioHistoryUseCase {
  final PortfolioRepository repository;

  const GetPortfolioHistoryUseCase(this.repository);

  Future<List<PortfolioHistoryPoint>> call(String period) async {
    return await repository.getPortfolioHistory(period);
  }
}
