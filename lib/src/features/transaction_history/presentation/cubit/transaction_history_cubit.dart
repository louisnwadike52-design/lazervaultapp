import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';

/// Cubit for managing transaction history state
class TransactionHistoryCubit extends Cubit<TransactionHistoryState> {
  final TransactionHistoryRepository repository;

  // Pagination
  int _currentPage = 1;
  final int _pageSize = 20;
  String? _nextCursor;

  // Current filters and service type
  TransactionFilters? _activeFilters;
  TransactionServiceType? _serviceType;

  // Cached transactions
  List<UnifiedTransaction> _cachedTransactions = [];

  // OUT-OF-ORDER RESPONSE GUARD.
  //
  // ONE instance of this cubit (a service-locator singleton) backs the
  // dashboard's recent-history section, and TWO independent listeners reload
  // it: the active-account stream and the country stream. A region switch
  // fires BOTH — LocaleManager emits country before currency, so the country
  // listener's fetch leaves with the OLD active account id and the
  // account-stream fetch follows a moment later with the new one. Whichever
  // answered LAST won, so the dashboard could settle on the previous wallet's
  // rows, or on an error raised by a request whose account id had already been
  // replaced: "Could not load transactions" sitting on top of data that had
  // actually loaded fine, needing a manual Retry to clear.
  //
  // Every list load takes a ticket; only the newest ticket may emit.
  int _listGeneration = 0;

  int _beginListLoad() => ++_listGeneration;

  /// Emit only while [generation] is still the newest list load.
  void _emitList(int generation, TransactionHistoryState next) {
    if (isClosed || generation != _listGeneration) return;
    emit(next);
  }

  TransactionHistoryCubit({required this.repository})
      : super(const TransactionHistoryInitial());

  /// Load all transactions (for dashboard)
  Future<void> loadAllTransactions({
    TransactionFilters? filters,
    bool background = false,
  }) async {
    // Background refresh (e.g. scroll-into-view on the dashboard): keep the
    // current list on screen and update it in place when the fetch returns, so
    // the section re-renders WITHOUT flashing a loading skeleton.
    final generation = _beginListLoad();
    if (!(background && state is TransactionHistoryLoaded)) {
      // The repository keeps page one in SQLite (5 min, per user+account).
      // Paint that page NOW instead of a loader and converge to the network
      // in the background — the same revalidation a cache hit always ran,
      // just without the spinner in front of it. The spinner is only for an
      // empty cache.
      if (await _paintCachedPageOne(generation, filters)) {
        unawaited(refreshTransactions(background: true));
        return;
      }
      _emitList(generation, const TransactionHistoryLoading());
    }

    try {
      final response = await repository.fetchAllTransactions(
        page: 1,
        limit: _pageSize,
        filters: filters,
      );

      _currentPage = 1;
      _nextCursor = response.nextCursor;
      _activeFilters = filters;
      _cachedTransactions = response.transactions;
      _serviceType = null;

      if (response.transactions.isEmpty) {
        // A background refresh that comes back empty must NOT wipe a populated
        // list (transient/edge result) — keep the last good data on screen.
        if (background &&
            state is TransactionHistoryLoaded &&
            (state as TransactionHistoryLoaded).transactions.isNotEmpty) {
          return;
        }
        _emitList(generation, TransactionHistoryEmpty(activeFilters: filters));
      } else {
        TransactionStatistics? stats;
        try {
          stats = await repository.getStatistics(
            startDate: filters?.startDate,
            endDate: filters?.endDate,
          );
        } catch (_) {
          // Stats failure is non-blocking
        }

        _emitList(
            generation,
            TransactionHistoryLoaded(
              transactions: response.transactions,
              hasMore: response.hasMore,
              currentPage: response.currentPage,
              totalPages: response.totalPages,
              activeFilters: filters,
              statistics: stats,
            ));

        // Stale-while-revalidate: a cache-served page is instant but can be a
        // stale SUBSET (no external-transfer merge, hasMore capped false —
        // the "list only completes after pull-to-refresh" bug). Converge to
        // the full network result in place, no loading flash.
        if (response.fromCache && !background) {
          unawaited(refreshTransactions(background: true));
        }
      }
    } catch (e) {
      // A failed background refresh must NOT wipe the visible list — keep the
      // last good data on screen instead of showing a full error state.
      if (background && state is TransactionHistoryLoaded) return;
      _emitList(
          generation,
          TransactionHistoryError(
            message: e.toString().replaceAll('Exception: ', ''),
            errorCode: 'LOAD_ALL_FAILED',
          ));
    }
  }

  /// Emit the locally cached page one as a Loaded state, if there is one.
  /// Returns false (emitting nothing) on an empty cache or any cache error.
  /// Statistics are left as they were: they arrive with the refresh that
  /// follows, as they did before, rather than holding up the paint.
  Future<bool> _paintCachedPageOne(
      int generation, TransactionFilters? filters) async {
    TransactionListResponse? cached;
    try {
      cached = await repository.peekCachedAllTransactions(
        limit: _pageSize,
        filters: filters,
      );
    } catch (_) {
      return false;
    }
    if (isClosed ||
        cached == null ||
        cached.transactions.isEmpty ||
        generation != _listGeneration) {
      return false;
    }
    final previous = state;
    _currentPage = 1;
    _nextCursor = cached.nextCursor;
    _activeFilters = filters;
    _cachedTransactions = cached.transactions;
    _serviceType = null;
    _emitList(
        generation,
        TransactionHistoryLoaded(
          transactions: cached.transactions,
          hasMore: cached.hasMore,
          currentPage: cached.currentPage,
          totalPages: cached.totalPages,
          activeFilters: filters,
          statistics:
              previous is TransactionHistoryLoaded ? previous.statistics : null,
        ));
    return true;
  }

  /// Load transactions for a specific service type
  Future<void> loadServiceTransactions(
    TransactionServiceType serviceType, {
    TransactionFilters? filters,
    bool background = false,
  }) async {
    final generation = _beginListLoad();
    // Background refresh: keep the current list on screen (no loading flash).
    if (!(background && state is TransactionHistoryLoaded)) {
      _emitList(
          generation,
          TransactionHistoryLoading(
            message: 'Loading ${serviceType.displayName} transactions...',
          ));
    }

    try {
      final response = await repository.fetchServiceTransactions(
        serviceType,
        page: 1,
        limit: _pageSize,
        filters: filters,
      );

      _currentPage = 1;
      _nextCursor = response.nextCursor;
      _activeFilters = filters;
      _cachedTransactions = response.transactions;
      _serviceType = serviceType;

      if (response.transactions.isEmpty) {
        if (background &&
            state is TransactionHistoryLoaded &&
            (state as TransactionHistoryLoaded).transactions.isNotEmpty) {
          return; // keep the populated list on a transient-empty background refresh
        }
        _emitList(
            generation,
            TransactionHistoryEmpty(
              message: 'No ${serviceType.displayName} transactions found',
              activeFilters: filters,
            ));
      } else {
        TransactionStatistics? stats;
        try {
          stats = await repository.getStatistics(
            serviceType: serviceType,
            startDate: filters?.startDate,
            endDate: filters?.endDate,
          );
        } catch (_) {
          // Stats failure is non-blocking
        }

        _emitList(
            generation,
            TransactionHistoryLoaded(
              transactions: response.transactions,
              hasMore: response.hasMore,
              currentPage: response.currentPage,
              totalPages: response.totalPages,
              activeFilters: filters,
              statistics: stats,
            ));

        // Stale-while-revalidate — same as loadAllTransactions.
        if (response.fromCache && !background) {
          unawaited(refreshTransactions(background: true));
        }
      }
    } catch (e) {
      if (background && state is TransactionHistoryLoaded) return;
      _emitList(
          generation,
          TransactionHistoryError(
            message: e.toString().replaceAll('Exception: ', ''),
            errorCode: 'LOAD_SERVICE_FAILED',
          ));
    }
  }

  /// Load more transactions (pagination).
  ///
  /// THREE THINGS HERE WERE EACH ENOUGH ON THEIR OWN to make "scroll for more"
  /// do nothing, and all three were live:
  ///
  ///  1. it emitted [TransactionHistoryLoading], which the screens render as a
  ///     full-page skeleton — the ListView was destroyed mid-scroll, the
  ///     offset reset to the top, and the screens' scroll listeners only fire
  ///     while the state is Loaded, so no further page could ever be asked
  ///     for. Now it flags [TransactionHistoryLoaded.isLoadingMore] and the
  ///     rows stay put.
  ///  2. it handed the SAME list instance back after mutating it with
  ///     `addAll`. Equatable deep-compares `props`, so when `hasMore`,
  ///     `currentPage` and `totalPages` were unchanged — which is precisely
  ///     what cursor pagination does — the state compared EQUAL to the one on
  ///     screen and bloc dropped the emit. The rows were fetched, appended,
  ///     and never shown.
  ///  3. a failed page replaced the whole list with an error screen, throwing
  ///     away pages the reader already had because page four timed out.
  ///
  /// It also no longer mutates the repository's own list (see `_appended`).
  Future<void> loadMoreTransactions() async {
    if (state is! TransactionHistoryLoaded) return;

    final currentState = state as TransactionHistoryLoaded;
    if (!currentState.hasMore) return;

    // ONE PAGE IN FLIGHT AT A TIME. The listeners fire on every scroll frame
    // near the bottom, and without this each frame would start another
    // identical fetch — the same page appended several times over.
    if (currentState.isLoadingMore) return;

    // Pagination takes a ticket too: a region switch (or any reload) mid-page
    // replaces _cachedTransactions, and appending page N+1 of the OLD account
    // onto the new list is how two wallets' rows end up in one list.
    final generation = _beginListLoad();
    try {
      _emitList(generation, currentState.copyWith(isLoadingMore: true));

      final response = _serviceType == null
          ? await repository.fetchAllTransactions(
              page: _currentPage + 1,
              limit: _pageSize,
              cursor: _nextCursor,
              filters: _activeFilters,
            )
          : await repository.fetchServiceTransactions(
              _serviceType!,
              page: _currentPage + 1,
              limit: _pageSize,
              cursor: _nextCursor,
              filters: _activeFilters,
            );

      if (generation != _listGeneration) return;
      _currentPage = response.currentPage;
      _nextCursor = response.nextCursor;
      _cachedTransactions = _appended(_cachedTransactions, response.transactions);

      // A page arrived, so a previous failure is no longer true. Cleared
      // BEFORE the emit for the same reason the failure is set before its
      // own: the footer reads this during the rebuild this emit causes.
      _lastLoadMoreError = null;
      _emitList(
          generation,
          currentState.copyWith(
            transactions: _cachedTransactions,
            hasMore: response.hasMore,
            currentPage: response.currentPage,
            totalPages: response.totalPages,
          ));
    } catch (e) {
      // KEEP THE PAGES ALREADY READ. Replacing them with a full-screen error
      // because page four timed out loses the reader's place and everything
      // they were looking at; the rows on screen are still true. Clearing the
      // flag is what lets them scroll down and try again.
      if (generation != _listGeneration) return;
      // SET BEFORE THE EMIT. This is a plain field, not part of the state, so
      // the footer reads it during the rebuild the emit below causes —
      // assigning afterwards meant the first failure rendered with no message
      // at all, and the text only appeared if something else happened to
      // rebuild later.
      _lastLoadMoreError = e.toString().replaceAll('Exception: ', '');
      _emitList(generation, currentState.copyWith(isLoadingMore: false));
    }
  }

  /// The most recent append failure, for a screen that wants to say so.
  ///
  /// Deliberately NOT a state: an append failing must not take the list down
  /// with it, and a transient page-four timeout is not worth a dialog.
  String? _lastLoadMoreError;
  String? get lastLoadMoreError => _lastLoadMoreError;

  /// A NEW list, with rows already present left out.
  ///
  /// New: a fresh instance every time, because Equatable deep-compares and a
  /// mutated-in-place list reads as "nothing changed" — and because
  /// `_cachedTransactions` is the repository's own list, so `addAll` was
  /// writing into its cache.
  ///
  /// The de-duplication is not belt-and-braces. Offset pagination over a table
  /// that takes new rows at the top shifts everything down by one, so page two
  /// legitimately re-sends the last row of page one; appending it blind gives
  /// duplicate ids, and a `ListView` keyed on id throws on the duplicate.
  static List<UnifiedTransaction> _appended(
    List<UnifiedTransaction> existing,
    List<UnifiedTransaction> incoming,
  ) {
    final seen = existing.map((t) => t.id).toSet();
    return [
      ...existing,
      for (final t in incoming)
        if (t.id.isEmpty || seen.add(t.id)) t,
    ];
  }

  /// Refresh transactions. When [background] is true (e.g. the dashboard's
  /// scroll-into-view auto-refresh) the current list stays on screen and is
  /// updated in place — no loading skeleton flash, no error-over-data.
  Future<void> refreshTransactions({bool background = false}) async {
    try {
      await repository.refreshTransactions();

      if (_serviceType == null) {
        await loadAllTransactions(
            filters: _activeFilters, background: background);
      } else {
        await loadServiceTransactions(_serviceType!,
            filters: _activeFilters, background: background);
      }
    } catch (e) {
      if (background && state is TransactionHistoryLoaded) return;
      _emitList(
          _listGeneration,
          TransactionHistoryError(
            message: e.toString().replaceAll('Exception: ', ''),
            errorCode: 'REFRESH_FAILED',
          ));
    }
  }

  /// Apply filters
  Future<void> applyFilters(TransactionFilters filters) async {
    if (_serviceType == null) {
      await loadAllTransactions(filters: filters.hasFilters ? filters : null);
    } else {
      await loadServiceTransactions(_serviceType!, filters: filters);
    }
  }

  /// Clear all filters
  Future<void> clearFilters() async {
    _activeFilters = null;
    if (_serviceType == null) {
      await loadAllTransactions();
    } else {
      await loadServiceTransactions(_serviceType!);
    }
  }

  /// Search transactions
  Future<void> searchTransactions(String query) async {
    if (state is! TransactionHistoryLoaded) return;

    // A search REPLACES the list, so it takes a ticket like any other list
    // load — a scope change that lands while it is in flight must win.
    final generation = _beginListLoad();
    try {
      _emitList(
          generation, const TransactionHistoryLoading(message: 'Searching...'));

      final results = await repository.searchTransactions(query);
      if (generation != _listGeneration) return;

      if (results.isEmpty) {
        _emitList(
            generation,
            const TransactionHistoryEmpty(
              message: 'No transactions found for your search',
            ));
      } else if (state is TransactionHistoryLoaded) {
        _emitList(
            generation,
            (state as TransactionHistoryLoaded).copyWith(
              transactions: results,
              hasMore: false,
            ));
      }
    } catch (e) {
      _emitList(
          generation,
          TransactionHistoryError(
            message: e.toString().replaceAll('Exception: ', ''),
            errorCode: 'SEARCH_FAILED',
          ));
    }
  }

  /// Load transaction details
  Future<void> loadTransactionDetails(String transactionId) async {
    emit(const TransactionDetailsLoading());

    try {
      final transaction = await repository.fetchTransactionById(transactionId);

      if (transaction != null) {
        emit(TransactionDetailsLoaded(transaction: transaction));
      } else {
        emit(const TransactionDetailsError(
          message: 'Transaction not found',
        ));
      }
    } catch (e) {
      emit(TransactionDetailsError(
        message: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  /// Load statistics
  Future<void> loadStatistics({TransactionServiceType? serviceType}) async {
    emit(const TransactionStatisticsLoading());

    try {
      final stats = await repository.getStatistics(
        serviceType: serviceType ?? _serviceType,
        startDate: _activeFilters?.startDate,
        endDate: _activeFilters?.endDate,
      );

      if (state is TransactionHistoryLoaded) {
        emit((state as TransactionHistoryLoaded).copyWith(statistics: stats));
      } else {
        emit(TransactionStatisticsLoaded(statistics: stats));
      }
    } catch (e) {
      // A STATISTICS failure must not blank the transaction list. Everywhere
      // else in this cubit stats are fetched inside a try/catch described as
      // "non-blocking"; here the catch replaced a populated list with a
      // full-area error, so a flaky totals call read as "we lost your
      // history".
      if (state is TransactionHistoryLoaded) return;
      emit(TransactionHistoryError(
        message: e.toString().replaceAll('Exception: ', ''),
        errorCode: 'STATS_FAILED',
      ));
    }
  }

  /// Fetch transactions for export (date range, no pagination)
  Future<List<UnifiedTransaction>> fetchTransactionsForExport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return repository.fetchTransactionsForExport(
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Reset to initial state
  void reset() {
    _currentPage = 1;
    _nextCursor = null;
    // A reload starts a new list; carrying the previous one's append failure
    // would put "Couldn't load more" under rows it was never about.
    _lastLoadMoreError = null;
    _activeFilters = null;
    _serviceType = null;
    _cachedTransactions = [];
    emit(const TransactionHistoryInitial());
  }

  /// Get current service type
  TransactionServiceType? get currentServiceType => _serviceType;

  /// Get current filters
  TransactionFilters? get currentFilters => _activeFilters;
}
