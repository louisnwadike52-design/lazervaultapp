import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../core/grpc/crypto_grpc_client.dart';
import '../../../../core/services/injection_container.dart';
import '../../../generated/crypto.pb.dart' show PriceAlert;
import '../domain/entities/crypto_entity.dart';
import '../domain/entities/global_market_data.dart';
import '../domain/repositories/crypto_repository.dart';
import '../presentation/utils/crypto_error_messages.dart';
import 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository repository;

  /// Guard against concurrent financial operations (buy/sell/convert).
  /// Prevents double-tap / rapid re-invocation from executing two transactions.
  bool _isTransacting = false;
  // Transaction PIN (verification token) captured at swap initiation, held
  // until ConfirmSwap so the backend can verify it server-side. Cleared after
  // confirm. Held in memory only, transiently.
  String? _swapPin;

  /// Single-shot guard so the landing-page wallet-provisioning fallback fires
  /// at most once per cubit lifetime. Idempotent server-side, but no need to
  /// hammer the gRPC endpoint on every pull-to-refresh.
  bool _walletProvisioningAttempted = false;

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

      // Load Quidax-supported assets for buy/sell filtering
      List<Crypto> supportedAssets = [];
      try {
        supportedAssets = await repository.getSupportedAssets();
      } catch (e) {
        // Non-critical — continue without
      }

      // Authenticated data — graceful failure if not logged in
      List<CryptoWatchlist> watchlists = [];
      List<CryptoHolding> holdings = [];
      List<CryptoTransaction> transactions = [];
      bool authedOk = false;
      try {
        watchlists = await repository.getWatchlists();
        // Lazy holdings: the server returns balances only, leaving fiat
        // values as 0 + priceLoading=true. The fan-out below populates
        // each holding's fiat value via parallel rate fetches, emitting
        // a copyWith'd state per arrival. Lets the landing page render
        // units in ~50ms instead of waiting for N serial price lookups.
        holdings = await repository.getHoldings(unitsOnly: true);
        transactions = await repository.getTransactions();
        authedOk = true;
      } catch (e) {
        // Auth calls failed (user not logged in) — continue with public data
      }

      // Price alerts — non-critical, fetched via gRPC client directly
      // (proxied through investment-gateway). Empty on failure so the
      // landing-page card still renders.
      List<PriceAlert> priceAlerts = [];
      if (authedOk) {
        try {
          final client = serviceLocator<CryptoGrpcClient>();
          final res = await client.getPriceAlerts(activeOnly: false);
          priceAlerts = res.alerts.toList();
        } catch (_) {
          // Non-critical — landing renders an empty state.
        }
      }

      // Landing-page wallet provisioning fallback. The signup Kafka consumer
      // normally creates wallets in the background within ~2 min of signup,
      // but if it raced/failed the user lands here with no holdings. Trigger
      // BatchCreateWallets in the background and re-fetch — the gRPC call is
      // idempotent server-side so calling it on a healthy user is a no-op.
      if (authedOk && holdings.isEmpty && supportedAssets.isNotEmpty && !_walletProvisioningAttempted) {
        _walletProvisioningAttempted = true;
        unawaited(_provisionWalletsAndRefresh());
      }

      if (isClosed) return;
      emit(CryptosLoaded(
        cryptos: cryptos,
        trendingCryptos: trendingCryptos,
        topCryptos: topCryptos,
        supportedAssets: supportedAssets,
        watchlists: watchlists,
        holdings: holdings,
        transactions: transactions,
        priceAlerts: priceAlerts,
        globalMarketData: globalMarketData,
      ));
      // Lazy fiat hydration: emits a fresh state per asset as its rate
      // arrives so the portfolio total + per-row fiat values fill in
      // progressively without blocking the landing page render.
      if (authedOk && holdings.isNotEmpty) {
        unawaited(_hydrateHoldingFiatValues(holdings));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  Future<void> searchCryptos(String query) async {
    try {
      final currentState = state;
      if (currentState is! CryptosLoaded) return;
      if (isClosed) return;
      emit(currentState.copyWith(isSearching: true));

      if (query.isEmpty) {
        final cryptos = await repository.getCryptos();
        if (isClosed) return;
        // Re-check state after async gap -- another emit may have changed it
        final postState = state;
        if (postState is CryptosLoaded) {
          emit(postState.copyWith(
            cryptos: cryptos,
            clearSearchQuery: true,
            isSearching: false,
          ));
        }
      } else {
        final searchResults = await repository.searchCryptos(query);
        if (isClosed) return;
        final postState = state;
        if (postState is CryptosLoaded) {
          emit(postState.copyWith(
            cryptos: searchResults,
            searchQuery: query,
            isSearching: false,
          ));
        }
      }
    } catch (e) {
      if (isClosed) return;
      // On search failure, revert to non-searching state instead of full error
      final currentState = state;
      if (currentState is CryptosLoaded) {
        emit(currentState.copyWith(isSearching: false));
      } else {
        emit(CryptoError(message: friendlyCryptoError(e)));
      }
    }
  }

  /// Silently re-fetches holdings + transactions and folds them into the
  /// existing CryptosLoaded state without an intervening CryptoLoading
  /// emission. Called from the swap-processing screen on terminal swap
  /// states so:
  ///
  ///   • A completed BUY shows the new crypto in the dashboard holdings
  ///     card the moment the user returns to it (Quidax sub-account
  ///     credit lands at swap completion; webhook mirrors to user_wallets
  ///     and we re-pull here).
  ///   • A completed SELL shows the crypto debit (and the fiat credit
  ///     handled by AccountCardsSummaryCubit refresh elsewhere) on
  ///     dashboard return without a manual pull-to-refresh.
  ///   • A failed/refunded swap appears in the transactions list so the
  ///     user sees a "Trade failed — refund processed" row in history
  ///     instead of a silent disappearance.
  ///
  /// No-op when the cubit isn't in CryptosLoaded (the receipt screen owns
  /// its own state for swaps started from a non-dashboard entry like
  /// voice agent).
  Future<void> refreshHoldingsAfterSwap() async {
    final current = state;
    if (current is! CryptosLoaded) return;
    try {
      final results = await Future.wait([
        repository.getHoldings(unitsOnly: true),
        repository.getTransactions(),
      ]);
      if (isClosed) return;
      final s = state;
      if (s is! CryptosLoaded) return;
      final freshHoldings = results[0] as List<CryptoHolding>;
      emit(s.copyWith(
        holdings: freshHoldings,
        transactions: results[1] as List<CryptoTransaction>,
      ));
      // Kick lazy fiat hydration so the receipt's holdings card updates
      // without blocking navigation on N serial provider lookups.
      unawaited(_hydrateHoldingFiatValues(freshHoldings));
    } catch (_) {
      // Silent — the dashboard's own pull-to-refresh / next loadCryptos
      // will pick up the truth. We never want a refresh failure to leak
      // into the receipt UX.
    }
  }

  /// Fans out per-asset fiat-rate fetches in parallel for every holding
  /// the server returned with priceLoading=true. As each rate resolves the
  /// matching holding is patched via copyWith and the state is re-emitted,
  /// so the landing-page fiat totals fill in progressively instead of all-
  /// or-nothing at the end. Failures per asset leave the holding at
  /// priceLoading=true; the next pull-to-refresh tries again.
  Future<void> _hydrateHoldingFiatValues(List<CryptoHolding> initial) async {
    if (initial.isEmpty) return;
    // We use the existing GetCryptoFiatRate RPC (provider router picks
    // Quidax first, falls back to CoinGecko) one call per asset.
    final client = serviceLocator<CryptoGrpcClient>();
    const fiat = 'NGN';
    final pending = initial.where((h) => h.priceLoading && h.quantity > 0).toList();
    if (pending.isEmpty) return;

    Future<void> fetchOne(CryptoHolding h) async {
      try {
        final res = await client.getExchangeRate(
          cryptoId: h.cryptoId,
          fiatCurrency: fiat,
        );
        final rate = res.rate;
        if (isClosed) return;
        final s = state;
        if (s is! CryptosLoaded) return;
        final updated = s.holdings.map((row) {
          if (row.cryptoId != h.cryptoId) return row;
          final total = row.quantity * rate;
          return row.copyWith(
            currentPrice: rate,
            totalValue: total,
            priceLoading: false,
            lastUpdated: DateTime.now(),
          );
        }).toList();
        emit(s.copyWith(holdings: updated));
      } catch (_) {
        // Leave priceLoading=true so a later refresh can retry; do not
        // emit a partial state with totalValue=0 (would visually flash).
      }
    }

    // Fire all rate requests in parallel.
    await Future.wait(pending.map(fetchOne));
  }

  /// Removes a price alert (PriceAlertWorker won't fire it again) and
  /// optimistically updates state. On error, re-fetches to resync.
  Future<void> removePriceAlert(String alertId) async {
    final current = state;
    if (current is! CryptosLoaded) return;
    final next = current.priceAlerts.where((a) => a.id != alertId).toList();
    emit(current.copyWith(priceAlerts: next));
    try {
      final client = serviceLocator<CryptoGrpcClient>();
      await client.deletePriceAlert(alertId);
    } catch (_) {
      // Roll back by re-fetching.
      try {
        final client = serviceLocator<CryptoGrpcClient>();
        final res = await client.getPriceAlerts(activeOnly: false);
        if (isClosed) return;
        final s = state;
        if (s is CryptosLoaded) {
          emit(s.copyWith(priceAlerts: res.alerts.toList()));
        }
      } catch (_) {
        // Give up silently — landing card will show stale state until next pull.
      }
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

      // Load news asynchronously (non-blocking)
      loadCryptoNews(crypto.symbol);
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  Future<void> loadCryptoNews(String cryptoSymbol) async {
    try {
      final currentState = state;
      if (currentState is! CryptoDetailsLoaded) return;
      if (isClosed) return;
      emit(currentState.copyWith(isLoadingNews: true));

      final news = await repository.getCryptoNews(cryptoSymbol);
      if (isClosed) return;
      final postState = state;
      if (postState is CryptoDetailsLoaded) {
        emit(postState.copyWith(news: news, isLoadingNews: false));
      }
    } catch (e) {
      if (isClosed) return;
      final postState = state;
      if (postState is CryptoDetailsLoaded) {
        emit(postState.copyWith(isLoadingNews: false));
      }
    }
  }

  Future<void> changeTimeframe(String timeframe) async {
    try {
      final currentState = state;
      if (currentState is! CryptoDetailsLoaded) return;
      final crypto = currentState.crypto;

      // Keep existing data visible while loading new timeframe instead of
      // emitting CryptoLoading which would blank the screen.
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
    } catch (e) {
      if (isClosed) return;
      // On timeframe change failure, keep existing detail state instead of
      // navigating to a full-screen error.
      final currentState = state;
      if (currentState is CryptoDetailsLoaded) {
        // Silently keep old data -- user can retry the timeframe tap
        return;
      }
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  Future<void> buyCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    if (_isTransacting) return; // Prevent concurrent buy operations
    _isTransacting = true;
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
      emit(CryptoError(message: friendlyCryptoError(e)));
    } finally {
      _isTransacting = false;
    }
  }

  Future<void> sellCrypto({
    required String cryptoId,
    required double quantity,
    required double price,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    if (_isTransacting) return; // Prevent concurrent sell operations
    _isTransacting = true;
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
      emit(CryptoError(message: friendlyCryptoError(e)));
    } finally {
      _isTransacting = false;
    }
  }

  Future<void> convertCrypto({
    required String fromCryptoId,
    required String toCryptoId,
    required double amount,
    required String transactionPin,
    String? fiatCurrency,
  }) async {
    if (_isTransacting) return; // Prevent concurrent convert operations
    _isTransacting = true;
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
      emit(CryptoError(message: friendlyCryptoError(e)));
    } finally {
      _isTransacting = false;
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
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  Future<void> addToWatchlist(String watchlistId, String cryptoId) async {
    try {
      await repository.addToWatchlist(watchlistId, cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  Future<void> removeFromWatchlist(String watchlistId, String cryptoId) async {
    try {
      await repository.removeFromWatchlist(watchlistId, cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  Future<void> deleteWatchlist(String watchlistId) async {
    try {
      await repository.deleteWatchlist(watchlistId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  Future<void> toggleFavorite(String cryptoId) async {
    try {
      await repository.toggleFavorite(cryptoId);
      await loadCryptos(); // Reload to reflect changes
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  Future<void> loadSupportedAssets({int page = 1, int perPage = 50}) async {
    try {
      final assets = await repository.getSupportedAssets(page: page, perPage: perPage);
      final currentState = state;
      if (isClosed) return;
      if (currentState is CryptosLoaded) {
        emit(currentState.copyWith(supportedAssets: assets));
      }
    } catch (e) {
      // Non-critical — don't emit error
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

  /// Fires the BatchCreateWallets gRPC fallback when the landing page detects
  /// no holdings for an authenticated user. On success (any wallet created),
  /// re-fetches holdings and emits a patched CryptosLoaded so the UI updates
  /// without a full reload. Errors are swallowed — the user still sees the
  /// empty state and can refresh manually.
  Future<void> _provisionWalletsAndRefresh() async {
    final created = await repository.ensureUserWallets();
    if (!created || isClosed) return;
    try {
      final refreshed = await repository.getHoldings();
      if (isClosed) return;
      final current = state;
      if (current is CryptosLoaded) {
        emit(current.copyWith(holdings: refreshed));
      }
    } catch (_) {
      // non-fatal; pull-to-refresh will pick this up
    }
  }

  // ==========================================================================
  // Swap-quotation flow (PR3)
  // ==========================================================================

  /// Generates a fresh 15s quote. Emits SwapQuotePending on success so the
  /// QuoteTimerCard can render the countdown. Concurrency-guarded by
  /// _isTransacting to prevent double-tap.
  Future<void> createSwapQuote({
    required String accountId,
    required String side, // "buy" | "sell"
    required String fromCurrency,
    required String toCurrency,
    required int fromAmountMinorUnits,
    String description = '',
    String transactionPin = '',
  }) async {
    if (_isTransacting || isClosed) return;
    _isTransacting = true;
    // Hold the PIN/verification-token for the later ConfirmSwap (server-side
    // PIN gate). Cleared on confirm success/failure.
    _swapPin = transactionPin.isEmpty ? null : transactionPin;
    try {
      final receipt = await repository.createSwapQuote(
        accountId: accountId,
        side: side,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        fromAmountMinorUnits: fromAmountMinorUnits,
        clientIntentId: _newIntentId(),
        description: description,
      );
      if (isClosed) return;
      emit(SwapQuotePending(
        transactionId: receipt.transactionId,
        reference: receipt.reference,
        quoteId: receipt.quoteId,
        expiresAt: receipt.expiresAt,
        fromCurrency: receipt.fromCurrency,
        toCurrency: receipt.toCurrency,
        fromAmount: receipt.fromAmount,
        toAmount: receipt.toAmount,
        quotedPrice: receipt.quotedPrice,
        spreadBps: receipt.spreadBps,
        spreadMinorUnits: receipt.spreadMinorUnits,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(SwapFailed(
        transactionId: '',
        reason: 'create_quote_failed',
        message: friendlyCryptoError(e),
      ));
    } finally {
      _isTransacting = false;
    }
  }

  /// Renews the active quote (called by QuoteTimerCard at expiresAt-2s).
  /// Re-emits SwapQuotePending so the timer resets.
  Future<void> refreshSwapQuote() async {
    final current = state;
    if (current is! SwapQuotePending) return;
    try {
      final refreshed = await repository.refreshSwapQuote(current.transactionId);
      if (isClosed) return;
      emit(SwapQuotePending(
        transactionId: current.transactionId,
        reference: current.reference,
        quoteId: refreshed.quoteId,
        expiresAt: refreshed.expiresAt,
        fromCurrency: current.fromCurrency,
        toCurrency: current.toCurrency,
        fromAmount: refreshed.fromAmount.isNotEmpty ? refreshed.fromAmount : current.fromAmount,
        toAmount: refreshed.toAmount.isNotEmpty ? refreshed.toAmount : current.toAmount,
        quotedPrice: refreshed.quotedPrice.isNotEmpty ? refreshed.quotedPrice : current.quotedPrice,
        spreadBps: current.spreadBps,
        spreadMinorUnits: current.spreadMinorUnits,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(SwapFailed(
        transactionId: current.transactionId,
        reason: 'quote_refresh_failed',
        message: friendlyCryptoError(e),
      ));
    }
  }

  /// Confirms the active quote. On success emits SwapPending; webhook + the
  /// receipt screen's GetSwapStatus poll drives the terminal state.
  Future<void> confirmSwapQuote() async {
    final current = state;
    if (current is! SwapQuotePending || _isTransacting) return;
    _isTransacting = true;
    try {
      final receipt = await repository.confirmSwap(current.transactionId,
          transactionPin: _swapPin);
      _swapPin = null; // single-use: clear once consumed
      if (isClosed) return;
      if (receipt.status == 'completed') {
        emit(SwapCompleted(
          transactionId: receipt.transactionId,
          quidaxSwapId: receipt.quidaxSwapId,
          fromCurrency: current.fromCurrency,
          toCurrency: current.toCurrency,
          fromAmount: current.fromAmount,
          receivedAmount: receipt.receivedAmount.isNotEmpty ? receipt.receivedAmount : current.toAmount,
          executionPrice: receipt.executionPrice.isNotEmpty ? receipt.executionPrice : current.quotedPrice,
        ));
      } else {
        emit(SwapPending(
          transactionId: receipt.transactionId,
          quidaxSwapId: receipt.quidaxSwapId,
          fromCurrency: current.fromCurrency,
          toCurrency: current.toCurrency,
          fromAmount: current.fromAmount,
          toAmount: current.toAmount,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(SwapFailed(
        transactionId: current.transactionId,
        reason: 'confirm_failed',
        message: friendlyCryptoError(e),
      ));
    } finally {
      _isTransacting = false;
    }
  }

  /// Receipt-screen polling tick. Called every ~5s from the receipt UI while
  /// the swap is in SwapPending. Transitions to SwapCompleted or SwapFailed
  /// once the webhook lands.
  Future<void> pollSwapStatus() async {
    final current = state;
    if (current is! SwapPending) return;
    try {
      final receipt = await repository.getSwapStatus(current.transactionId);
      if (isClosed) return;
      switch (receipt.status) {
        case 'completed':
          emit(SwapCompleted(
            transactionId: receipt.transactionId,
            quidaxSwapId: receipt.quidaxSwapId,
            fromCurrency: receipt.fromCurrency,
            toCurrency: receipt.toCurrency,
            fromAmount: receipt.fromAmount,
            receivedAmount: receipt.receivedAmount,
            executionPrice: receipt.executionPrice,
          ));
          break;
        case 'failed':
        case 'reversed':
        case 'refunded':
        case 'manual_review':
          emit(SwapFailed(
            transactionId: receipt.transactionId,
            reason: receipt.status,
            message: receipt.lastError.isNotEmpty
                ? receipt.lastError
                : 'Swap did not complete (${receipt.status})',
          ));
          break;
        default:
          // still pending; keep polling
          break;
      }
    } catch (_) {
      // transient; let the next tick retry
    }
  }

  // client_intent_id is opaque to the server but doubles as the
  // correlation key in logs across crypto-service / accounts-service /
  // Quidax webhook handlers. Using uuid v4 here so the format matches
  // the E2E test (uuid.New().String()) and operators can grep one ID
  // across every backend log.
  String _newIntentId() => const Uuid().v4();
}