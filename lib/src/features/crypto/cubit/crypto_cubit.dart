import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../core/grpc/crypto_grpc_client.dart';
import '../../../../core/services/injection_container.dart';
import '../domain/entities/crypto_entity.dart';
import '../domain/entities/global_market_data.dart';
import '../domain/repositories/crypto_repository.dart';
import '../presentation/utils/crypto_error_messages.dart';
import 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository repository;

  /// Page size for the paginated transactions list (View All screen).
  static const int txPageSize = 20;

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

  /// Stale-while-revalidate cache of the last fully/partly loaded landing
  /// snapshot. STATIC so it survives across CryptoCubit instances (the cubit
  /// is a DI factory — a fresh one is built on every navigation). On re-entry
  /// we paint this instantly, then revalidate in the background, instead of
  /// flashing the full-screen shimmer every single time. Bounded by a short
  /// TTL so we never show materially stale holdings/prices (and a logout→login
  /// within the window still self-corrects on the immediate revalidate pass).
  static CryptosLoaded? _cachedSnapshot;
  static DateTime? _cachedAt;
  static const Duration _snapshotTtl = Duration(seconds: 90);

  CryptoCubit({required this.repository}) : super(CryptoInitial());

  /// Capture the freshest loaded snapshot for the SWR cache. Cheap: BLoC calls
  /// this on every state transition; we only stash the loaded variant.
  @override
  void onChange(Change<CryptoState> change) {
    super.onChange(change);
    final next = change.nextState;
    if (next is CryptosLoaded) {
      _cachedSnapshot = next;
      _cachedAt = DateTime.now();
    }
  }

  /// Clears the cross-instance snapshot cache. Call on logout / account switch
  /// so a different user never briefly sees the previous user's holdings.
  static void invalidateSnapshot() {
    _cachedSnapshot = null;
    _cachedAt = null;
  }

  Future<void> loadCryptos() async {
    // SWR fast path: if we have a recent snapshot, paint it immediately and
    // refresh quietly underneath (no shimmer). Bounded by _snapshotTtl.
    final cached = _cachedSnapshot;
    final cachedAt = _cachedAt;
    if (cached != null &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < _snapshotTtl) {
      if (isClosed) return;
      emit(cached);
      unawaited(_revalidate());
      return;
    }
    await _initialLoad();
  }

  /// Full first-load path: shimmer → asset list → lazy sections.
  Future<void> _initialLoad() async {
    try {
      if (isClosed) return;
      emit(CryptoLoading());

      // ── PHASE A (fast, primary render) ──────────────────────────────────
      // Fetch ONLY the tradable asset list (Quidax-first backend: catalogue +
      // one bulk /markets/tickers, no CoinGecko universe fetch). This is the
      // thing the user came for; everything else lazy-loads below with its own
      // spinner. We no longer fetch getCryptos()/getTopCryptos() (the full,
      // non-tradable CoinGecko top-N) at all — the landing shows only assets
      // users can actually trade.
      List<Crypto> assets;
      try {
        assets = await repository.getSupportedAssets();
      } catch (e) {
        if (isClosed) return;
        emit(CryptoError(message: friendlyCryptoError(e)));
        return;
      }
      if (isClosed) return;

      // Movers = the tradable assets sorted by 24h change (client-side; no
      // extra call, and never shows a coin we can't trade).
      final movers = List<Crypto>.from(assets)
        ..sort((a, b) =>
            b.priceChangePercentage24h.compareTo(a.priceChangePercentage24h));

      emit(CryptosLoaded(
        cryptos: assets,
        supportedAssets: assets,
        topCryptos: movers,
        trendingCryptos: movers.take(10).toList(),
        // Every auxiliary section starts in its own loading state.
        portfolioLoading: true,
        statsLoading: true,
        watchlistLoading: true,
        transactionsLoading: true,
        priceAlertsLoading: true,
        autoOrdersLoading: true,
        topMoversLoading: true,
      ));

      // ── PHASE B (lazy, independent, non-blocking) ───────────────────────
      unawaited(_loadStatistics());
      unawaited(_loadAuthedSections());
      // Top movers data is already in state (derived from assets), but we hold
      // its shimmer for a beat so the critical landing content paints first —
      // then reveal it non-blocking, after the initial frame.
      unawaited(_revealTopMovers());
    } catch (e) {
      if (isClosed) return;
      emit(CryptoError(message: friendlyCryptoError(e)));
    }
  }

  /// SWR revalidate pass: refresh the asset list + every lazy section WITHOUT
  /// flipping any loading flag (the cached snapshot is already on screen), so
  /// data updates in place with no shimmer. Runs after an instant cache paint.
  Future<void> _revalidate() async {
    try {
      final assets = await repository.getSupportedAssets();
      if (isClosed) return;
      final s = state;
      if (s is CryptosLoaded) {
        final movers = List<Crypto>.from(assets)
          ..sort((a, b) =>
              b.priceChangePercentage24h.compareTo(a.priceChangePercentage24h));
        emit(s.copyWith(
          cryptos: assets,
          supportedAssets: assets,
          topCryptos: movers,
          trendingCryptos: movers.take(10).toList(),
        ));
      }
    } catch (_) {
      // Keep the cached asset list on a transient failure.
    }
    // Refresh the auxiliary sections quietly (their loading flags stay false).
    unawaited(_loadStatistics());
    unawaited(_loadAuthedSections());
  }

  /// Reveal the Top Movers section shortly after the initial frame so the
  /// critical landing content (portfolio, quick actions, supported assets)
  /// paints first. The data is already in state — this only drops the shimmer.
  Future<void> _revealTopMovers() async {
    await Future.delayed(const Duration(milliseconds: 350));
    if (isClosed) return;
    final s = state;
    if (s is CryptosLoaded) emit(s.copyWith(topMoversLoading: false));
  }

  /// Lazy: global market data (statistics header). Flips [statsLoading] off.
  Future<void> _loadStatistics() async {
    GlobalMarketData? g;
    try {
      g = await repository.getGlobalMarketData();
    } catch (_) {
      // CoinGecko rate limit / unavailable — render without stats.
    }
    if (isClosed) return;
    final s = state;
    if (s is CryptosLoaded) {
      emit(s.copyWith(globalMarketData: g, statsLoading: false));
    }
  }

  /// Lazy: the authenticated sections — watchlists, holdings, transactions,
  /// price alerts, auto-orders. These are INDEPENDENT gateway round-trips, so
  /// they run CONCURRENTLY (previously they awaited one another sequentially,
  /// which serialised ~5 RTTs). Each flips ONLY its own loading flag, so one
  /// slow/failed call never blocks the others (or the asset list). Concurrent
  /// emits are safe: each section does a synchronous `state`-read + `emit`
  /// with no `await` in between, so copyWith never reads a stale slice.
  Future<void> _loadAuthedSections() async {
    await Future.wait([
      _loadWatchlistsSection(),
      _loadHoldingsSection(),
      _loadTransactionsSection(),
      _loadPriceAlertsSection(),
      _loadAutoOrdersSection(),
    ]);
  }

  /// Watchlists. The watchlist is the SINGLE source of truth for "saved
  /// assets" — the old favorites path (isFavorite / ToggleFavorite) is gone.
  /// We derive each asset's isFavorite flag from real watchlist membership so
  /// the detail-screen star and the watchlist section stay consistent.
  Future<void> _loadWatchlistsSection() async {
    try {
      final w = await repository.getWatchlists();
      if (isClosed) return;
      final s = state;
      if (s is CryptosLoaded) {
        emit(_applyWatchlistMembership(
            s.copyWith(watchlists: w, watchlistLoading: false)));
      }
    } catch (_) {
      final s = state;
      if (s is CryptosLoaded) emit(s.copyWith(watchlistLoading: false));
    }
  }

  /// Holdings WITH fiat values in a SINGLE round-trip. The backend now values
  /// every holding off the one bulk /markets/tickers snapshot it already warms
  /// for the asset list, so we no longer fetch units-only then fan out N
  /// per-asset GetCryptoFiatRate calls — one call returns units + fiat.
  Future<void> _loadHoldingsSection() async {
    try {
      final h = await repository.getHoldings(unitsOnly: false);
      if (isClosed) return;
      final s = state;
      if (s is CryptosLoaded) {
        emit(s.copyWith(holdings: h, portfolioLoading: false));
      }
      if (h.isEmpty) {
        // Provisioning fallback: idempotent server-side; no-op for healthy users.
        final s2 = state;
        if (s2 is CryptosLoaded &&
            s2.supportedAssets.isNotEmpty &&
            !_walletProvisioningAttempted) {
          _walletProvisioningAttempted = true;
          unawaited(_provisionWalletsAndRefresh());
        }
      }
    } catch (_) {
      final s = state;
      if (s is CryptosLoaded) emit(s.copyWith(portfolioLoading: false));
    }
  }

  /// Transactions (first page; View All paginates via loadMoreTransactions).
  Future<void> _loadTransactionsSection() async {
    try {
      final t = await repository.getTransactions(limit: txPageSize, offset: 0);
      if (isClosed) return;
      final s = state;
      if (s is CryptosLoaded) {
        emit(s.copyWith(
          transactions: t,
          transactionsLoading: false,
          transactionsHasMore: t.length >= txPageSize,
        ));
      }
    } catch (_) {
      final s = state;
      if (s is CryptosLoaded) emit(s.copyWith(transactionsLoading: false));
    }
  }

  /// Price alerts (via gRPC client, gateway-proxied).
  Future<void> _loadPriceAlertsSection() async {
    try {
      final client = serviceLocator<CryptoGrpcClient>();
      final res = await client.getPriceAlerts(activeOnly: false);
      if (isClosed) return;
      final s = state;
      if (s is CryptosLoaded) {
        emit(s.copyWith(
            priceAlerts: res.alerts.toList(), priceAlertsLoading: false));
      }
    } catch (_) {
      final s = state;
      if (s is CryptosLoaded) emit(s.copyWith(priceAlertsLoading: false));
    }
  }

  /// Auto-orders (price-triggered trades).
  Future<void> _loadAutoOrdersSection() async {
    try {
      final client = serviceLocator<CryptoGrpcClient>();
      final res = await client.listAutoOrders();
      if (isClosed) return;
      final s = state;
      if (s is CryptosLoaded) {
        emit(s.copyWith(
            autoOrders: res.orders.toList(), autoOrdersLoading: false));
      }
    } catch (_) {
      final s = state;
      if (s is CryptosLoaded) emit(s.copyWith(autoOrdersLoading: false));
    }
  }

  /// Refreshes just the auto-orders list (after create/cancel).
  Future<void> refreshAutoOrders() async {
    try {
      final client = serviceLocator<CryptoGrpcClient>();
      final res = await client.listAutoOrders();
      if (isClosed) return;
      final s = state;
      if (s is CryptosLoaded) {
        emit(s.copyWith(autoOrders: res.orders.toList(), autoOrdersLoading: false));
      }
    } catch (_) {
      // keep existing list on failure
    }
  }

  /// Creates a price-triggered auto-order. Returns true on success. The BUY
  /// path reserves fiat up front (a fund hold) after PIN verification; the
  /// worker executes automatically when the target price is crossed.
  Future<bool> createAutoOrder({
    required String accountId,
    required String side,
    required String cryptoId,
    required String fiatCurrency,
    required String triggerDirection,
    required double targetPrice,
    required int amountMinor,
    required String transactionPin,
    int expiresInSeconds = 0,
  }) async {
    try {
      final client = serviceLocator<CryptoGrpcClient>();
      await client.createAutoOrder(
        accountId: accountId,
        side: side,
        cryptoId: cryptoId,
        fiatCurrency: fiatCurrency,
        triggerDirection: triggerDirection,
        targetPrice: targetPrice,
        amountMinor: amountMinor,
        transactionPin: transactionPin,
        idempotencyKey: '',
        expiresInSeconds: expiresInSeconds,
      );
      await refreshAutoOrders();
      return true;
    } catch (e) {
      if (isClosed) return false;
      emit(CryptoError(message: friendlyCryptoError(e)));
      return false;
    }
  }

  /// Cancels an auto-order (releases the reserved funds for a buy).
  Future<void> cancelAutoOrder(String orderId) async {
    final current = state;
    if (current is! CryptosLoaded) return;
    // Optimistic removal.
    final next = current.autoOrders.where((o) => o.id != orderId).toList();
    emit(current.copyWith(autoOrders: next));
    try {
      final client = serviceLocator<CryptoGrpcClient>();
      await client.cancelAutoOrder(orderId);
      await refreshAutoOrders();
    } catch (e) {
      // Reload to restore truth on failure.
      await refreshAutoOrders();
    }
  }

  Future<void> searchCryptos(String query) async {
    try {
      final currentState = state;
      if (currentState is! CryptosLoaded) return;
      if (isClosed) return;
      emit(currentState.copyWith(isSearching: true));

      // Search ONLY the tradable (Quidax-supported) assets — client-side over
      // the already-loaded list. Instant (no backend round-trip) AND it can
      // never surface a coin the user can't actually buy/sell on the platform
      // (the old repository.searchCryptos hit CoinGecko's full universe).
      final pool = currentState.supportedAssets.isNotEmpty
          ? currentState.supportedAssets
          : currentState.cryptos;
      if (query.isEmpty) {
        emit(currentState.copyWith(
          cryptos: pool,
          clearSearchQuery: true,
          isSearching: false,
        ));
      } else {
        final q = query.toLowerCase().trim();
        final results = pool
            .where((c) =>
                c.name.toLowerCase().contains(q) ||
                c.symbol.toLowerCase().contains(q))
            .toList();
        emit(currentState.copyWith(
          cryptos: results,
          searchQuery: query,
          isSearching: false,
        ));
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
  /// Refresh ONLY the holdings list from the backend (which itself
  /// overlays Quidax-live balances on top of the mirror via
  /// `WalletService.GetUserWallets` — see crypto-service for the
  /// regulatory framing). Intended for screens that gate user action
  /// on what they currently hold (Send, Sell, Swap, holdings picker)
  /// so a deposit that landed on Quidax via an external transfer
  /// surfaces immediately on next screen mount, instead of waiting
  /// for the periodic landing-page refresh.
  ///
  /// Light enough to be called on every screen `initState` — bypasses
  /// the full `loadCryptos` ten-call fan-out and avoids touching
  /// `transactions` (the Send/Sell screens don't display them).
  ///
  /// Silent on failure so a transient gateway blip never blanks out a
  /// working holdings card.
  Future<void> refreshHoldingsLive() async {
    final current = state;
    if (current is! CryptosLoaded) return;
    try {
      // One round-trip returns units + fiat (backend values off the bulk
      // ticker snapshot), so no separate hydration fan-out is needed.
      final freshHoldings = await repository.getHoldings(unitsOnly: false);
      if (isClosed) return;
      final s = state;
      if (s is! CryptosLoaded) return;
      emit(s.copyWith(holdings: freshHoldings));
    } catch (_) {
      // Silent — the next landing-page pull-to-refresh will pick
      // up the truth; we never want a refresh blip to blank out a
      // working holdings UI.
    }
  }

  /// Pull-to-refresh for the transaction history screen: re-fetch the
  /// transactions list and fold it into state. Silent on failure so a refresh
  /// blip never blanks a working list.
  Future<void> refreshTransactions() async {
    final s0 = state;
    if (s0 is! CryptosLoaded) return;
    try {
      final txns = await repository.getTransactions(limit: txPageSize, offset: 0);
      if (isClosed) return;
      final s = state;
      if (s is CryptosLoaded) {
        emit(s.copyWith(
          transactions: txns,
          transactionsHasMore: txns.length >= txPageSize,
          transactionsLoadingMore: false,
        ));
      }
    } catch (_) {
      // Silent — keep the existing list on a transient failure.
    }
  }

  /// Load the next page of transactions (View All screen, load-more on scroll).
  /// Appends to the existing list, deduping by id; flips `transactionsHasMore`
  /// off when a short page comes back. No-op while already loading or drained.
  Future<void> loadMoreTransactions() async {
    final s = state;
    if (s is! CryptosLoaded) return;
    if (s.transactionsLoadingMore || !s.transactionsHasMore) return;
    emit(s.copyWith(transactionsLoadingMore: true));
    try {
      final next = await repository.getTransactions(
        limit: txPageSize,
        offset: s.transactions.length,
      );
      if (isClosed) return;
      final cur = state;
      if (cur is! CryptosLoaded) return;
      final seen = cur.transactions.map((t) => t.id).toSet();
      final fresh = next.where((t) => !seen.contains(t.id)).toList();
      emit(cur.copyWith(
        transactions: [...cur.transactions, ...fresh],
        transactionsLoadingMore: false,
        transactionsHasMore: next.length >= txPageSize,
      ));
    } catch (_) {
      final cur = state;
      if (cur is CryptosLoaded) {
        emit(cur.copyWith(transactionsLoadingMore: false));
      }
    }
  }

  Future<void> refreshHoldingsAfterSwap() async {
    final current = state;
    if (current is! CryptosLoaded) return;
    try {
      final results = await Future.wait([
        repository.getHoldings(unitsOnly: false),
        repository.getTransactions(limit: txPageSize, offset: 0),
      ]);
      if (isClosed) return;
      final s = state;
      if (s is! CryptosLoaded) return;
      final freshHoldings = results[0] as List<CryptoHolding>;
      final freshTxns = results[1] as List<CryptoTransaction>;
      emit(s.copyWith(
        holdings: freshHoldings,
        transactions: freshTxns,
        // A new trade resets the paginated list to its first page.
        transactionsHasMore: freshTxns.length >= txPageSize,
        transactionsLoadingMore: false,
      ));
    } catch (_) {
      // Silent — the dashboard's own pull-to-refresh / next loadCryptos
      // will pick up the truth. We never want a refresh failure to leak
      // into the receipt UX.
    }
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

  /// Toggles an asset's membership in the user's watchlist. This is the SINGLE
  /// consolidated "save/unsave asset" path — it operates on the real Watchlist
  /// CRUD (the same store the watchlist manager sheet uses), replacing the old
  /// dead ToggleFavorite RPC. If the user has no watchlist yet, a default
  /// "My Watchlist" is created on first save.
  ///
  /// STATE-INDEPENDENT: works whether the current state is the landing page's
  /// [CryptosLoaded] or the detail screen's [CryptoDetailsLoaded] (which does
  /// NOT extend CryptosLoaded and carries no watchlists). It sources the
  /// watchlists from state when they're already loaded, otherwise fetches them,
  /// so the detail-screen bookmark actually persists instead of silently
  /// no-opping. Returns the new membership (`true` = now saved) so the caller
  /// can set its local UI authoritatively. On failure it rethrows WITHOUT
  /// emitting [CryptoError] — that would blank whichever screen is showing;
  /// the caller reverts its optimistic UI and surfaces the error instead.
  Future<bool> toggleFavorite(String cryptoId) async {
    // Prefer already-loaded watchlists (landing page); otherwise fetch them
    // (detail screen, whose fresh cubit never loaded them). Errors propagate to
    // the caller, which reverts its optimistic UI — we deliberately do NOT emit
    // CryptoError here, as that would blank whichever screen is showing.
    final s = state;
    List<CryptoWatchlist> watchlists;
    if (s is CryptosLoaded && s.watchlists.isNotEmpty) {
      watchlists = s.watchlists;
    } else {
      watchlists = await repository.getWatchlists();
    }

    // Is the asset already in ANY of the user's watchlists?
    String? containingWatchlistId;
    for (final wl in watchlists) {
      if (wl.cryptoIds.contains(cryptoId)) {
        containingWatchlistId = wl.id;
        break;
      }
    }

    final bool nowSaved;
    if (containingWatchlistId != null) {
      await repository.removeFromWatchlist(containingWatchlistId, cryptoId);
      nowSaved = false;
    } else {
      // Resolve (or create) the default watchlist, then add.
      String targetId;
      if (watchlists.isNotEmpty) {
        targetId = watchlists.first.id;
      } else {
        final wl = await repository.createWatchlist('My Watchlist', '');
        targetId = wl.id;
      }
      await repository.addToWatchlist(targetId, cryptoId);
      nowSaved = true;
    }

    // Reload watchlists and re-derive membership flags into the active list
    // state. No-op when the detail screen (CryptoDetailsLoaded) is showing —
    // the landing page re-syncs via refreshWatchlists() when it regains focus.
    final w = await repository.getWatchlists();
    if (!isClosed) {
      final cur = state;
      if (cur is CryptosLoaded) {
        emit(_applyWatchlistMembership(cur.copyWith(watchlists: w)));
      }
    }
    return nowSaved;
  }

  /// Public re-fetch of the user's watchlists + re-derived membership flags.
  /// The detail screen's bookmark toggle runs on a SEPARATE CryptoCubit
  /// instance (it's opened via a named route that builds its own cubit), so
  /// the landing page's cubit never learns about a save/unsave made there.
  /// The landing page calls this when it regains focus after visiting a
  /// detail screen, keeping the "Your Watchlist" section and every saved
  /// indicator in sync with the backend.
  Future<void> refreshWatchlists() async {
    final s = state;
    if (s is! CryptosLoaded) return;
    try {
      final w = await repository.getWatchlists();
      if (isClosed) return;
      final cur = state;
      if (cur is CryptosLoaded) {
        emit(_applyWatchlistMembership(cur.copyWith(watchlists: w)));
      }
    } catch (_) {
      // Non-critical: keep showing the last known watchlist.
    }
  }

  /// Re-derives each asset's `isFavorite` flag from real watchlist membership
  /// across every crypto list in the state, so the UI's saved/unsaved
  /// indicators reflect the single watchlist source of truth.
  CryptosLoaded _applyWatchlistMembership(CryptosLoaded s) {
    final ids = <String>{};
    for (final wl in s.watchlists) {
      ids.addAll(wl.cryptoIds);
    }
    List<Crypto> mark(List<Crypto> list) => list
        .map((c) => c.isFavorite == ids.contains(c.id)
            ? c
            : c.copyWith(isFavorite: ids.contains(c.id)))
        .toList();
    return s.copyWith(
      cryptos: mark(s.cryptos),
      supportedAssets: mark(s.supportedAssets),
      topCryptos: mark(s.topCryptos),
      trendingCryptos: mark(s.trendingCryptos),
    );
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
    // The id the PIN verification token was minted against (the screen's
    // transaction id). We reuse it as the swap's clientIntentId so ConfirmSwap
    // can validate the token against the row's intent id. Empty → generate one.
    String clientIntentId = '',
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
        clientIntentId:
            clientIntentId.isEmpty ? _newIntentId() : clientIntentId,
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
  Future<void> confirmSwapQuote({String transactionPin = ''}) async {
    final current = state;
    if (current is! SwapQuotePending || _isTransacting) return;
    _isTransacting = true;
    // The PIN now finalizes the trade — it's entered AFTER the user reviews the
    // quote (quote sheet → Confirm → PIN sheet). Prefer the freshly-supplied
    // token; fall back to any _swapPin captured at quote time (legacy path).
    final pin = transactionPin.isNotEmpty ? transactionPin : _swapPin;
    try {
      final receipt = await repository.confirmSwap(current.transactionId,
          transactionPin: pin);
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
          // status=processing => backend queued the saga (async mode); the flow
          // shows a live pending receipt instead of blocking on processing.
          isAsync: receipt.status == 'processing',
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