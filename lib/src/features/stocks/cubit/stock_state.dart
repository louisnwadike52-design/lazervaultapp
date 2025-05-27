import 'package:equatable/equatable.dart';
import '../domain/entities/stock_entity.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object?> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<Stock> stocks;

  const StockLoaded(this.stocks);

  @override
  List<Object?> get props => [stocks];
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

// Stock Details States
class StockDetailsLoading extends StockState {}

class StockDetailsLoaded extends StockState {
  final Stock stock;
  final List<StockPrice> priceHistory;

  const StockDetailsLoaded(this.stock, this.priceHistory);

  @override
  List<Object?> get props => [stock, priceHistory];
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

class SectorPerformanceLoading extends StockState {}

class SectorPerformanceLoaded extends StockState {
  final List<Map<String, dynamic>> sectors;

  const SectorPerformanceLoaded(this.sectors);

  @override
  List<Object?> get props => [sectors];
}

// Search States
class StockSearching extends StockState {}

class StockSearchResults extends StockState {
  final List<Stock> results;
  final String query;

  const StockSearchResults(this.results, this.query);

  @override
  List<Object?> get props => [results, query];
}

class StockSearchError extends StockState {
  final String message;

  const StockSearchError(this.message);

  @override
  List<Object?> get props => [message];
} 