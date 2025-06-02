import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/crypto_entity.dart';
import '../domain/repositories/crypto_repository.dart';
import 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository repository;

  CryptoCubit({required this.repository}) : super(CryptoInitial());

  Future<void> loadCryptos() async {
    try {
      emit(CryptoLoading());
      
      final cryptos = await repository.getCryptos();
      final trendingCryptos = await repository.getTrendingCryptos();
      final topCryptos = await repository.getTopCryptos();
      final watchlists = await repository.getWatchlists();
      final holdings = await repository.getHoldings();
      final transactions = await repository.getTransactions();

      emit(CryptosLoaded(
        cryptos: cryptos,
        trendingCryptos: trendingCryptos,
        topCryptos: topCryptos,
        watchlists: watchlists,
        holdings: holdings,
        transactions: transactions,
      ));
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> searchCryptos(String query) async {
    try {
      if (state is CryptosLoaded) {
        emit((state as CryptosLoaded).copyWith(isSearching: true));
        
        if (query.isEmpty) {
          final cryptos = await repository.getCryptos();
          emit((state as CryptosLoaded).copyWith(
            cryptos: cryptos,
            searchQuery: null,
            isSearching: false,
          ));
        } else {
          final searchResults = await repository.searchCryptos(query);
          emit((state as CryptosLoaded).copyWith(
            cryptos: searchResults,
            searchQuery: query,
            isSearching: false,
          ));
        }
      }
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> loadCryptoDetails(String cryptoId, {String timeframe = '7d'}) async {
    try {
      emit(CryptoLoading());
      
      final crypto = await repository.getCryptoById(cryptoId);
      final priceHistory = await repository.getCryptoPriceHistory(cryptoId, range: timeframe);
      
      emit(CryptoDetailsLoaded(
        crypto: crypto,
        priceHistory: priceHistory,
        selectedTimeframe: timeframe,
      ));
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> changeTimeframe(String timeframe) async {
    try {
      if (state is CryptoDetailsLoaded) {
        final crypto = (state as CryptoDetailsLoaded).crypto;
        emit(CryptoLoading());
        
        final priceHistory = await repository.getCryptoPriceHistory(
          crypto.id,
          range: timeframe,
        );
        
        emit(CryptoDetailsLoaded(
          crypto: crypto,
          priceHistory: priceHistory,
          selectedTimeframe: timeframe,
        ));
      }
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> buyCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
  }) async {
    try {
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.buy,
        quantity: quantity,
        price: price,
      ));

      final transaction = await repository.buyCrypto(
        cryptoId: cryptoId,
        quantity: quantity,
        price: price,
      );

      emit(CryptoTransactionSuccess(transaction: transaction));
      
      // Reload data to reflect the new transaction
      await loadCryptos();
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> sellCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
  }) async {
    try {
      emit(CryptoTransactionProcessing(
        cryptoId: cryptoId,
        type: TransactionType.sell,
        quantity: quantity,
        price: price,
      ));

      final transaction = await repository.sellCrypto(
        cryptoId: cryptoId,
        quantity: quantity,
        price: price,
      );

      emit(CryptoTransactionSuccess(transaction: transaction));
      
      // Reload data to reflect the new transaction
      await loadCryptos();
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> createWatchlist(String name, String description) async {
    try {
      final watchlist = await repository.createWatchlist(name, description);
      emit(CryptoWatchlistCreated(watchlist: watchlist));
      
      // Reload data to include the new watchlist
      await loadCryptos();
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> addToWatchlist(String watchlistId, String cryptoId) async {
    try {
      await repository.addToWatchlist(watchlistId, cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> removeFromWatchlist(String watchlistId, String cryptoId) async {
    try {
      await repository.removeFromWatchlist(watchlistId, cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> deleteWatchlist(String watchlistId) async {
    try {
      await repository.deleteWatchlist(watchlistId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }

  Future<void> toggleFavorite(String cryptoId) async {
    try {
      await repository.toggleFavorite(cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
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