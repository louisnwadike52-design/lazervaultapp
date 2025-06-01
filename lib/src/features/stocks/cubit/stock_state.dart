import 'package:equatable/equatable.dart';
import '../domain/entities/stock_entity.dart';
import '../domain/entities/analyst_ratings.dart';
import '../domain/entities/stock_event.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object?> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<Stock> stocks;
  final String? sector;

  const StockLoaded(this.stocks, {this.sector});

  @override
  List<Object?> get props => [stocks, sector];
}

class StockError extends StockState {
  final String message;

  const StockError(this.message);

  @override
  List<Object?> get props => [message];
}

// Portfolio States
class PortfolioLoading extends StockState {}

class PortfolioLoaded extends StockState {
  final Portfolio portfolio;

  const PortfolioLoaded(this.portfolio);

  @override
  List<Object?> get props => [portfolio];
}

class PortfolioError extends StockState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}

// Holdings States
class HoldingsLoading extends StockState {}

class HoldingsLoaded extends StockState {
  final List<StockHolding> holdings;

  const HoldingsLoaded(this.holdings);

  @override
  List<Object?> get props => [holdings];
}

class HoldingsError extends StockState {
  final String message;

  const HoldingsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Stock Details States
class StockDetailsLoading extends StockState {}

class StockDetailsLoaded extends StockState {
  final Stock stock;
  final List<StockPrice> priceHistory;
  final StockAnalysis? analysis;
  final AnalystRatings? analystRatings;
  final List<StockEvent>? events;

  const StockDetailsLoaded({
    required this.stock,
    required this.priceHistory,
    this.analysis,
    this.analystRatings,
    this.events,
  });

  StockDetailsLoaded copyWith({
    Stock? stock,
    List<StockPrice>? priceHistory,
    StockAnalysis? analysis,
    AnalystRatings? analystRatings,
    List<StockEvent>? events,
  }) {
    return StockDetailsLoaded(
      stock: stock ?? this.stock,
      priceHistory: priceHistory ?? this.priceHistory,
      analysis: analysis ?? this.analysis,
      analystRatings: analystRatings ?? this.analystRatings,
      events: events ?? this.events,
    );
  }

  @override
  List<Object?> get props => [stock, priceHistory, analysis, analystRatings, events];
}

class StockDetailsError extends StockState {
  final String message;

  const StockDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Trading States
class OrderPlacing extends StockState {}

class OrderPlaced extends StockState {
  final StockOrder order;

  const OrderPlaced(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderError extends StockState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrdersLoading extends StockState {}

class OrdersLoaded extends StockState {
  final List<StockOrder> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderCancelling extends StockState {}

class OrderCancelled extends StockState {
  final StockOrder order;

  const OrderCancelled(this.order);

  @override
  List<Object?> get props => [order];
}

// Watchlist States
class WatchlistsLoading extends StockState {}

class WatchlistsLoaded extends StockState {
  final List<Watchlist> watchlists;

  const WatchlistsLoaded(this.watchlists);

  @override
  List<Object?> get props => [watchlists];
}

class WatchlistsError extends StockState {
  final String message;

  const WatchlistsError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistCreating extends StockState {}

class WatchlistCreated extends StockState {
  final Watchlist watchlist;

  const WatchlistCreated(this.watchlist);

  @override
  List<Object?> get props => [watchlist];
}

class WatchlistUpdating extends StockState {}

class WatchlistUpdated extends StockState {
  final Watchlist watchlist;

  const WatchlistUpdated(this.watchlist);

  @override
  List<Object?> get props => [watchlist];
}

class WatchlistDeleting extends StockState {}

class WatchlistDeleted extends StockState {
  final String watchlistId;

  const WatchlistDeleted(this.watchlistId);

  @override
  List<Object?> get props => [watchlistId];
}

// Market Data States
class MarketNewsLoading extends StockState {}

class MarketNewsLoaded extends StockState {
  final List<MarketNews> news;

  const MarketNewsLoaded(this.news);

  @override
  List<Object?> get props => [news];
}

class MarketNewsError extends StockState {
  final String message;

  const MarketNewsError(this.message);

  @override
  List<Object?> get props => [message];
}

class MarketIndicesLoading extends StockState {}

class MarketIndicesLoaded extends StockState {
  final Map<String, double> indices;

  const MarketIndicesLoaded(this.indices);

  @override
  List<Object?> get props => [indices];
}

class MarketIndicesError extends StockState {
  final String message;

  const MarketIndicesError(this.message);

  @override
  List<Object?> get props => [message];
}

class SectorPerformanceLoading extends StockState {}

class SectorPerformanceLoaded extends StockState {
  final List<SectorPerformance> sectors;

  const SectorPerformanceLoaded(this.sectors);

  @override
  List<Object?> get props => [sectors];
}

class SectorPerformanceError extends StockState {
  final String message;

  const SectorPerformanceError(this.message);

  @override
  List<Object?> get props => [message];
}

// Alert States
class AlertsLoading extends StockState {}

class AlertsLoaded extends StockState {
  final List<StockAlert> alerts;

  const AlertsLoaded(this.alerts);

  @override
  List<Object?> get props => [alerts];
}

class AlertsError extends StockState {
  final String message;

  const AlertsError(this.message);

  @override
  List<Object?> get props => [message];
}

class AlertCreating extends StockState {}

class AlertCreated extends StockState {
  final StockAlert alert;

  const AlertCreated(this.alert);

  @override
  List<Object?> get props => [alert];
}

class AlertUpdating extends StockState {}

class AlertUpdated extends StockState {
  final StockAlert alert;

  const AlertUpdated(this.alert);

  @override
  List<Object?> get props => [alert];
}

class AlertDeleting extends StockState {}

class AlertDeleted extends StockState {
  final String alertId;

  const AlertDeleted(this.alertId);

  @override
  List<Object?> get props => [alertId];
}

// Trading Session States
class TradingSessionLoading extends StockState {}

class TradingSessionLoaded extends StockState {
  final TradingSession session;

  const TradingSessionLoaded(this.session);

  @override
  List<Object?> get props => [session];
}

class TradingSessionError extends StockState {
  final String message;

  const TradingSessionError(this.message);

  @override
  List<Object?> get props => [message];
}

class TradingSessionStarting extends StockState {}

class TradingSessionStarted extends StockState {
  final TradingSession session;

  const TradingSessionStarted(this.session);

  @override
  List<Object?> get props => [session];
}

class TradingSessionEnding extends StockState {}

class TradingSessionEnded extends StockState {
  final TradingSession session;

  const TradingSessionEnded(this.session);

  @override
  List<Object?> get props => [session];
}

// Analysis States
class AnalysisLoading extends StockState {}

class AnalysisLoaded extends StockState {
  final StockAnalysis analysis;

  const AnalysisLoaded(this.analysis);

  @override
  List<Object?> get props => [analysis];
}

class AnalysisError extends StockState {
  final String message;

  const AnalysisError(this.message);

  @override
  List<Object?> get props => [message];
}

// Options States
class OptionsLoading extends StockState {}

class OptionsLoaded extends StockState {
  final List<OptionContract> options;

  const OptionsLoaded(this.options);

  @override
  List<Object?> get props => [options];
}

class OptionsError extends StockState {
  final String message;

  const OptionsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Search States
class StockSearchLoading extends StockState {}

class StockSearchLoaded extends StockState {
  final List<Stock> searchResults;
  final String query;

  const StockSearchLoaded(this.searchResults, this.query);

  @override
  List<Object?> get props => [searchResults, query];
}

class StockSearchError extends StockState {
  final String message;

  const StockSearchError(this.message);

  @override
  List<Object?> get props => [message];
}

// Combined State for Complex UI
class StockDashboardLoaded extends StockState {
  final List<Stock> stocks;
  final Portfolio? portfolio;
  final Map<String, double> indices;
  final List<MarketNews> news;
  final List<SectorPerformance> sectors;

  const StockDashboardLoaded({
    required this.stocks,
    this.portfolio,
    required this.indices,
    required this.news,
    required this.sectors,
  });

  @override
  List<Object?> get props => [stocks, portfolio, indices, news, sectors];
} 