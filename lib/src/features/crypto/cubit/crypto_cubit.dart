import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/crypto_entity.dart';
import '../domain/entities/crypto_wallet_entity.dart';
import '../domain/entities/global_market_data.dart';
import '../domain/repositories/crypto_repository.dart';
import 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository repository;

  CryptoCubit({required this.repository}) : super(CryptoInitial());

  Future<void> loadCryptos() async {
    try {
      if (isClosed) return;
      emit(CryptoLoading());

      // Public data (no auth required) — parallel to reduce wall-clock time
      final results = await Future.wait([
        repository.getCryptos(),
        repository.getTrendingCryptos(),
        repository.getTopCryptos(),
      ]);
      final cryptos = results[0] as List<Crypto>;
      final trendingCryptos = results[1] as List<Crypto>;
      final topCryptos = results[2] as List<Crypto>;

      // Global market data (non-critical, graceful failure)
      GlobalMarketData? globalMarketData;
      try {
        globalMarketData = await repository.getGlobalMarketData();
      } catch (e) {
        // CoinGecko rate limit or unavailable — continue without
      }

      // Authenticated data — graceful failure if not logged in
      List<CryptoWalletEntity> wallets = [];
      List<CryptoWatchlist> watchlists = [];
      List<CryptoHolding> holdings = [];
      List<CryptoTransaction> transactions = [];
      try {
        watchlists = await repository.getWatchlists();
        holdings = await repository.getHoldings();
        transactions = await repository.getTransactions();
        wallets = await repository.getWallets();
      } catch (e) {
        // Auth calls failed (user not logged in) — continue with public data
      }

      if (isClosed) return;
      emit(CryptosLoaded(
        cryptos: cryptos,
        trendingCryptos: trendingCryptos,
        topCryptos: topCryptos,
        watchlists: watchlists,
        holdings: holdings,
        transactions: transactions,
        wallets: wallets,
        globalMarketData: globalMarketData,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> searchCryptos(String query) async {
    try {
      if (state is CryptosLoaded) {
        if (isClosed) return;
        emit((state as CryptosLoaded).copyWith(isSearching: true));

        if (query.isEmpty) {
          final cryptos = await repository.getCryptos();
          if (isClosed) return;
          emit((state as CryptosLoaded).copyWith(
            cryptos: cryptos,
            searchQuery: null,
            isSearching: false,
          ));
        } else {
          final searchResults = await repository.searchCryptos(query);
          if (isClosed) return;
          emit((state as CryptosLoaded).copyWith(
            cryptos: searchResults,
            searchQuery: query,
            isSearching: false,
          ));
        }
      }
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> loadCryptoDetails(String cryptoId, {String timeframe = '7d'}) async {
    try {
      if (isClosed) return;
      emit(CryptoLoading());

      final crypto = await repository.getCryptoById(cryptoId);
      final priceHistory = await repository.getCryptoPriceHistory(cryptoId, range: timeframe);

      if (isClosed) return;
      emit(CryptoDetailsLoaded(
        crypto: crypto,
        priceHistory: priceHistory,
        selectedTimeframe: timeframe,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> changeTimeframe(String timeframe) async {
    try {
      if (state is CryptoDetailsLoaded) {
        final crypto = (state as CryptoDetailsLoaded).crypto;
        if (isClosed) return;
        emit(CryptoLoading());

        final priceHistory = await repository.getCryptoPriceHistory(
          crypto.id,
          range: timeframe,
        );

        if (isClosed) return;
        emit(CryptoDetailsLoaded(
          crypto: crypto,
          priceHistory: priceHistory,
          selectedTimeframe: timeframe,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> buyCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    try {
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.buy,
        quantity: quantity,
        price: price,
        step: CryptoProcessingStep.validatingPin,
        progress: 0.2,
      ));

      // Step 2: Fetching rate
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.buy,
        quantity: quantity,
        price: price,
        step: CryptoProcessingStep.fetchingRate,
        progress: 0.4,
      ));

      // Step 3: Executing order
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.buy,
        quantity: quantity,
        price: price,
        step: CryptoProcessingStep.executingOrder,
        progress: 0.6,
      ));

      final transaction = await repository.buyCrypto(
        cryptoId: cryptoId,
        quantity: quantity,
        price: price,
        transactionPin: transactionPin,
        fiatCurrency: fiatCurrency,
      );

      // Step 4: Confirming
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.buy,
        quantity: quantity,
        price: price,
        step: CryptoProcessingStep.confirmingTransaction,
        progress: 0.8,
      ));

      if (isClosed) return;
      emit(CryptoTransactionSuccess(transaction: transaction));

      // Reload data to reflect the new transaction
      await loadCryptos();
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> sellCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    try {
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.sell,
        quantity: quantity,
        price: price,
        step: CryptoProcessingStep.validatingPin,
        progress: 0.2,
      ));

      // Step 2: Checking balance
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.sell,
        quantity: quantity,
        price: price,
        step: CryptoProcessingStep.checkingBalance,
        progress: 0.4,
      ));

      // Step 3: Executing order
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.sell,
        quantity: quantity,
        price: price,
        step: CryptoProcessingStep.executingOrder,
        progress: 0.6,
      ));

      final transaction = await repository.sellCrypto(
        cryptoId: cryptoId,
        quantity: quantity,
        price: price,
        transactionPin: transactionPin,
        fiatCurrency: fiatCurrency,
      );

      // Step 4: Confirming
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.sell,
        quantity: quantity,
        price: price,
        step: CryptoProcessingStep.confirmingTransaction,
        progress: 0.8,
      ));

      if (isClosed) return;
      emit(CryptoTransactionSuccess(transaction: transaction));

      // Reload data to reflect the new transaction
      await loadCryptos();
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> convertCrypto({
    required String fromCryptoId,
    required String toCryptoId,
    required double amount,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    try {
      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: fromCryptoId,
        type: TransactionType.swap,
        quantity: amount,
        price: 0,
        step: CryptoProcessingStep.validatingPin,
        progress: 0.2,
      ));

      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: fromCryptoId,
        type: TransactionType.swap,
        quantity: amount,
        price: 0,
        step: CryptoProcessingStep.fetchingRate,
        progress: 0.4,
      ));

      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: fromCryptoId,
        type: TransactionType.swap,
        quantity: amount,
        price: 0,
        step: CryptoProcessingStep.executingOrder,
        progress: 0.6,
      ));

      final transaction = await repository.convertCrypto(
        fromCryptoId: fromCryptoId,
        toCryptoId: toCryptoId,
        amount: amount,
        transactionPin: transactionPin,
        fiatCurrency: fiatCurrency,
      );

      if (isClosed) return;
      emit(CryptoTransactionProcessing(
        cryptoId: fromCryptoId,
        type: TransactionType.swap,
        quantity: amount,
        price: 0,
        step: CryptoProcessingStep.confirmingTransaction,
        progress: 0.8,
      ));

      if (isClosed) return;
      emit(CryptoTransactionSuccess(transaction: transaction));

      await loadCryptos();
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> createWatchlist(String name, String description) async {
    try {
      final watchlist = await repository.createWatchlist(name, description);
      if (isClosed) return;
      emit(CryptoWatchlistCreated(watchlist: watchlist));

      // Reload data to include the new watchlist
      await loadCryptos();
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> addToWatchlist(String watchlistId, String cryptoId) async {
    try {
      await repository.addToWatchlist(watchlistId, cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> removeFromWatchlist(String watchlistId, String cryptoId) async {
    try {
      await repository.removeFromWatchlist(watchlistId, cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> deleteWatchlist(String watchlistId) async {
    try {
      await repository.deleteWatchlist(watchlistId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> toggleFavorite(String cryptoId) async {
    try {
      await repository.toggleFavorite(cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> refreshData() async {
    await loadCryptos();
  }

  void clearSearch() {
    if (state is CryptosLoaded) {
      searchCryptos(''); // This will reload all cryptos
    }
  }
} 