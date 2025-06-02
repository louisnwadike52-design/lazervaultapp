import 'package:equatable/equatable.dart';
import '../domain/entities/crypto_entity.dart';
import '../domain/entities/price_point.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object?> get props => [];
}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptosLoaded extends CryptoState {
  final List<Crypto> cryptos;
  final List<Crypto> trendingCryptos;
  final List<Crypto> topCryptos;
  final List<CryptoWatchlist> watchlists;
  final List<CryptoHolding> holdings;
  final List<CryptoTransaction> transactions;
  final String? searchQuery;
  final bool isSearching;

  const CryptosLoaded({
    required this.cryptos,
    this.trendingCryptos = const [],
    this.topCryptos = const [],
    this.watchlists = const [],
    this.holdings = const [],
    this.transactions = const [],
    this.searchQuery,
    this.isSearching = false,
  });

  @override
  List<Object?> get props => [
        cryptos,
        trendingCryptos,
        topCryptos,
        watchlists,
        holdings,
        transactions,
        searchQuery,
        isSearching,
      ];

  CryptosLoaded copyWith({
    List<Crypto>? cryptos,
    List<Crypto>? trendingCryptos,
    List<Crypto>? topCryptos,
    List<CryptoWatchlist>? watchlists,
    List<CryptoHolding>? holdings,
    List<CryptoTransaction>? transactions,
    String? searchQuery,
    bool? isSearching,
  }) {
    return CryptosLoaded(
      cryptos: cryptos ?? this.cryptos,
      trendingCryptos: trendingCryptos ?? this.trendingCryptos,
      topCryptos: topCryptos ?? this.topCryptos,
      watchlists: watchlists ?? this.watchlists,
      holdings: holdings ?? this.holdings,
      transactions: transactions ?? this.transactions,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

class CryptoDetailsLoaded extends CryptoState {
  final Crypto crypto;
  final List<PricePoint> priceHistory;
  final String selectedTimeframe;

  const CryptoDetailsLoaded({
    required this.crypto,
    required this.priceHistory,
    this.selectedTimeframe = '7d',
  });

  @override
  List<Object> get props => [crypto, priceHistory, selectedTimeframe];

  CryptoDetailsLoaded copyWith({
    Crypto? crypto,
    List<PricePoint>? priceHistory,
    String? selectedTimeframe,
  }) {
    return CryptoDetailsLoaded(
      crypto: crypto ?? this.crypto,
      priceHistory: priceHistory ?? this.priceHistory,
      selectedTimeframe: selectedTimeframe ?? this.selectedTimeframe,
    );
  }
}

class CryptoTransactionProcessing extends CryptoState {
  final String cryptoId;
  final TransactionType type;
  final double quantity;
  final double price;

  const CryptoTransactionProcessing({
    required this.cryptoId,
    required this.type,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object> get props => [cryptoId, type, quantity, price];
}

class CryptoTransactionSuccess extends CryptoState {
  final CryptoTransaction transaction;

  const CryptoTransactionSuccess({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class CryptoWatchlistCreated extends CryptoState {
  final CryptoWatchlist watchlist;

  const CryptoWatchlistCreated({required this.watchlist});

  @override
  List<Object> get props => [watchlist];
}

class CryptoError extends CryptoState {
  final String message;

  const CryptoError({required this.message});

  @override
  List<Object> get props => [message];
} 