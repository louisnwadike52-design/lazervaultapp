import 'package:equatable/equatable.dart';
import '../data/models/crypto_wallet_model.dart';
import '../domain/entities/crypto_entity.dart';
import '../domain/entities/global_market_data.dart';
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
  final List<Crypto> supportedAssets;
  final List<CryptoWatchlist> watchlists;
  final List<CryptoHolding> holdings;
  final List<CryptoTransaction> transactions;
  final List<CryptoWalletModel> wallets;
  final GlobalMarketData? globalMarketData;
  final String? searchQuery;
  final bool isSearching;

  const CryptosLoaded({
    required this.cryptos,
    this.trendingCryptos = const [],
    this.topCryptos = const [],
    this.supportedAssets = const [],
    this.watchlists = const [],
    this.holdings = const [],
    this.transactions = const [],
    this.wallets = const [],
    this.globalMarketData,
    this.searchQuery,
    this.isSearching = false,
  });

  @override
  List<Object?> get props => [
        cryptos,
        trendingCryptos,
        topCryptos,
        supportedAssets,
        watchlists,
        holdings,
        transactions,
        wallets,
        globalMarketData,
        searchQuery,
        isSearching,
      ];

  /// [clearSearchQuery] - set to true to explicitly clear the search query to null.
  /// Without this, passing searchQuery: null preserves the existing value.
  CryptosLoaded copyWith({
    List<Crypto>? cryptos,
    List<Crypto>? trendingCryptos,
    List<Crypto>? topCryptos,
    List<Crypto>? supportedAssets,
    List<CryptoWatchlist>? watchlists,
    List<CryptoHolding>? holdings,
    List<CryptoTransaction>? transactions,
    List<CryptoWalletModel>? wallets,
    GlobalMarketData? globalMarketData,
    String? searchQuery,
    bool clearSearchQuery = false,
    bool? isSearching,
  }) {
    return CryptosLoaded(
      cryptos: cryptos ?? this.cryptos,
      trendingCryptos: trendingCryptos ?? this.trendingCryptos,
      topCryptos: topCryptos ?? this.topCryptos,
      supportedAssets: supportedAssets ?? this.supportedAssets,
      watchlists: watchlists ?? this.watchlists,
      holdings: holdings ?? this.holdings,
      transactions: transactions ?? this.transactions,
      wallets: wallets ?? this.wallets,
      globalMarketData: globalMarketData ?? this.globalMarketData,
      searchQuery: clearSearchQuery ? null : (searchQuery ?? this.searchQuery),
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

class CryptoDetailsLoaded extends CryptoState {
  final Crypto crypto;
  final List<PricePoint> priceHistory;
  final String selectedTimeframe;
  final List<CryptoNews> news;
  final bool isLoadingNews;

  const CryptoDetailsLoaded({
    required this.crypto,
    required this.priceHistory,
    this.selectedTimeframe = '7d',
    this.news = const [],
    this.isLoadingNews = false,
  });

  @override
  List<Object> get props => [crypto, priceHistory, selectedTimeframe, news, isLoadingNews];

  CryptoDetailsLoaded copyWith({
    Crypto? crypto,
    List<PricePoint>? priceHistory,
    String? selectedTimeframe,
    List<CryptoNews>? news,
    bool? isLoadingNews,
  }) {
    return CryptoDetailsLoaded(
      crypto: crypto ?? this.crypto,
      priceHistory: priceHistory ?? this.priceHistory,
      selectedTimeframe: selectedTimeframe ?? this.selectedTimeframe,
      news: news ?? this.news,
      isLoadingNews: isLoadingNews ?? this.isLoadingNews,
    );
  }
}

enum CryptoProcessingStep {
  validatingPin,
  checkingBalance,
  fetchingRate,
  executingOrder,
  confirmingTransaction,
  complete,
}

class CryptoTransactionProcessing extends CryptoState {
  final String cryptoId;
  final TransactionType type;
  final double quantity;
  final double price;
  final CryptoProcessingStep step;
  final double progress; // 0.0 to 1.0

  const CryptoTransactionProcessing({
    required this.cryptoId,
    required this.type,
    required this.quantity,
    required this.price,
    this.step = CryptoProcessingStep.validatingPin,
    this.progress = 0.0,
  });

  @override
  List<Object> get props => [cryptoId, type, quantity, price, step, progress];

  String get stepMessage {
    switch (step) {
      case CryptoProcessingStep.validatingPin:
        return 'Validating transaction PIN...';
      case CryptoProcessingStep.checkingBalance:
        return 'Checking available balance...';
      case CryptoProcessingStep.fetchingRate:
        return 'Getting latest exchange rate...';
      case CryptoProcessingStep.executingOrder:
        return 'Executing order...';
      case CryptoProcessingStep.confirmingTransaction:
        return 'Confirming transaction...';
      case CryptoProcessingStep.complete:
        return 'Transaction complete!';
    }
  }
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