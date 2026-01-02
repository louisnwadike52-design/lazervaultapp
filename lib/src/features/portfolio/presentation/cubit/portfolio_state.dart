import 'package:equatable/equatable.dart';
import '../../domain/entities/portfolio_entity.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PortfolioInitial extends PortfolioState {
  const PortfolioInitial();
}

/// Loading state
class PortfolioLoading extends PortfolioState {
  const PortfolioLoading();
}

/// Portfolio loaded successfully
class PortfolioLoaded extends PortfolioState {
  final Portfolio portfolio;

  const PortfolioLoaded({required this.portfolio});

  @override
  List<Object?> get props => [portfolio];
}

/// Portfolio summary loaded
class PortfolioSummaryLoaded extends PortfolioState {
  final PortfolioSummary summary;

  const PortfolioSummaryLoaded({required this.summary});

  @override
  List<Object?> get props => [summary];
}

/// Assets by type loaded
class PortfolioAssetsByTypeLoaded extends PortfolioState {
  final List<PortfolioAsset> assets;
  final String assetType;

  const PortfolioAssetsByTypeLoaded({
    required this.assets,
    required this.assetType,
  });

  @override
  List<Object?> get props => [assets, assetType];
}

/// Portfolio history loaded
class PortfolioHistoryLoaded extends PortfolioState {
  final List<PortfolioHistoryPoint> history;
  final String period;

  const PortfolioHistoryLoaded({
    required this.history,
    required this.period,
  });

  @override
  List<Object?> get props => [history, period];
}

/// Error state
class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Refreshing portfolio
class PortfolioRefreshing extends PortfolioState {
  final Portfolio currentPortfolio;

  const PortfolioRefreshing({required this.currentPortfolio});

  @override
  List<Object?> get props => [currentPortfolio];
}
