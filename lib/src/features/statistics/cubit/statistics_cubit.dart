import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/accounts.pb.dart' as accounts_pb;
import '../../../generated/banking.pb.dart' as banking_pb;
import '../../../../core/utils/debouncer.dart';
import '../../open_banking/data/datasources/open_banking_grpc_datasource.dart';
import '../data/financial_analytics_repository.dart';
import 'statistics_state.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// Cubit for the AI budgeting / statistics screen.
///
/// SOURCE MODEL (the contract every section of the screen renders against):
///   * [StatisticsSource.lazervault] — wallet activity ONLY (accounts-service
///     analytics with external excluded).
///   * [StatisticsSource.bank] — synced external-bank activity ONLY, served
///     by banking-service's GetExternalBankAnalytics over its
///     external_bank_transactions table. Scope is ALL linked banks by
///     default, or ONE bank via [changeBank].
///   * [StatisticsSource.both] — wallet + external MERGED client-side
///     (additive aggregates: period totals, category amounts, daily points).
///
/// Before any external-including load the cubit fires an incremental
/// sync-all so the numbers reflect the banks' latest statements; sync
/// failures are non-fatal (the last synced rows still serve).
class StatisticsCubit extends Cubit<StatisticsState> {
  /// Hard ceiling on the wallet-analytics + monthly-trends gRPC awaits. Without
  /// it, an unreachable/slow accounts-service left `loadStatistics` hung forever
  /// — the cubit never emitted Loaded OR Error, so the spending/statistics
  /// screen sat on a blank loader indefinitely. On timeout the outer catch emits
  /// StatisticsError, which the screens render as a retryable error state.
  static const Duration _statsLoadTimeout = Duration(seconds: 20);

  final FinancialAnalyticsRepository analyticsRepository;

  /// Banking-service surface for external-bank analytics + sync. Optional so
  /// existing constructions/tests keep working; without it, bank sources
  /// gracefully render wallet-only.
  final OpenBankingGrpcDataSource? bankingDataSource;

  String _currentPeriod = 'week';
  StatisticsSource _source = StatisticsSource.both;
  // Selected linked-bank scope. Empty = ALL linked banks; one or more narrows
  // every external number on the page to that SUBSET of banks (multi-select).
  List<String> _selectedBankAccountIds = const [];
  String _userId = '';
  bool _isLoading = false;
  final _periodDebouncer = Debouncer.typing();

  StatisticsCubit({
    required this.analyticsRepository,
    this.bankingDataSource,
  }) : super(StatisticsInitial());

  /// Currently selected money source (LazerVault / Bank / both).
  StatisticsSource get source => _source;

  /// Selected linked-bank scope (empty = all banks).
  List<String> get selectedBankAccountIds => _selectedBankAccountIds;

  /// Back-compat single-bank getter: the one selected bank, or null when the
  /// scope is "all banks" or a multi-bank subset.
  String? get selectedBankAccountId =>
      _selectedBankAccountIds.length == 1 ? _selectedBankAccountIds.first : null;

  /// True when the given linked-account id is part of the active scope.
  bool isBankSelected(String id) => _selectedBankAccountIds.contains(id);

  /// User id used for banking-service calls; set once by the screen.
  // ignore: avoid_setters_without_getters
  set userId(String id) => _userId = id;

  /// Test-only: set source without triggering the debounced reload.
  @visibleForTesting
  void changeSourceForTest(StatisticsSource s) => _source = s;

  /// Test-only: set bank scope without triggering the debounced reload.
  @visibleForTesting
  void changeBankForTest(String? id) =>
      _selectedBankAccountIds = (id == null || id.isEmpty) ? const [] : [id];

  /// Test-only: set a multi-bank scope without triggering the reload.
  @visibleForTesting
  void changeBanksForTest(List<String> ids) =>
      _selectedBankAccountIds = _normalizeBankIds(ids);

  @override
  Future<void> close() {
    _periodDebouncer.dispose();
    return super.close();
  }

  /// Legacy 2-way toggle, retained for existing callers:
  /// false -> LazerVault only, true -> LazerVault + banks.
  void toggleExternalBanks(bool include) {
    changeSource(include ? StatisticsSource.both : StatisticsSource.lazervault);
  }

  /// Change the money source the content reflects and reload.
  /// Always wipes any per-bank filter so the new tab starts at "All" —
  /// otherwise switching Bank → LazerVault → Bank would still be silently
  /// pinned to whichever bank the user picked last time and the user
  /// can't tell why the numbers are off.
  void changeSource(StatisticsSource source) {
    if (_source == source) return;
    _source = source;
    _selectedBankAccountIds = const [];
    _switchScope();
  }

  /// Dedupe + drop empties so the scope is a clean set of ids.
  static List<String> _normalizeBankIds(List<String> ids) {
    final seen = <String>{};
    final out = <String>[];
    for (final id in ids) {
      if (id.isEmpty || !seen.add(id)) continue;
      out.add(id);
    }
    return out;
  }

  /// Change the external-bank scope to a SET of linked banks: empty = ALL banks,
  /// otherwise only those banks (multi-select). No-op for wallet-only source.
  void changeBanks(List<String> linkedAccountIds) {
    final normalized = _normalizeBankIds(linkedAccountIds);
    if (setEquals(_selectedBankAccountIds.toSet(), normalized.toSet())) return;
    _selectedBankAccountIds = normalized;
    if (_source == StatisticsSource.lazervault) return;
    _switchScope();
  }

  /// Back-compat single-bank entry point: null/empty = all banks.
  void changeBank(String? linkedAccountId) => changeBanks(
      (linkedAccountId == null || linkedAccountId.isEmpty) ? const [] : [linkedAccountId]);

  /// Switch scope (source/bank tab). Flip the content to the shimmer skeleton
  /// IMMEDIATELY and synchronously — a cheap rebuild — so the tab highlights and
  /// the skeleton appear on the same frame as the tap (emitting heavy cached
  /// content here would stall that frame and make the tab feel laggy). Then load
  /// the new scope's data right away (no typing debounce — a tab click isn't a
  /// keystroke); the skeleton shows until the real data lands.
  void _switchScope() {
    DateTime? start;
    DateTime? end;
    if (state is StatisticsLoaded) {
      final s = state as StatisticsLoaded;
      start = s.startDate;
      end = s.endDate;
      emit(s.copyWith(isRefreshing: true));
    } else {
      emit(const StatisticsLoading(loadingMessage: 'Loading statistics...'));
    }
    loadStatistics(startDate: start, endDate: end);
  }

  /// Change the analytics period (week/month/quarter/year) and reload.
  void changePeriod(String period) {
    _currentPeriod = period;
    // The period must drive the REAL analytics window. Previously this only
    // relabelled and reloaded the same (initial 7-day) range, so picking
    // "Month"/"Year" showed a week of data. Compute the window from the period.
    final range = _rangeForPeriod(period);
    _periodDebouncer.runAsync(() async {
      await loadStatistics(startDate: range.start, endDate: range.end);
    });
  }

  /// Map a named period to its actual data window (end = now).
  ({DateTime start, DateTime end}) _rangeForPeriod(String period) {
    final now = DateTime.now();
    final Duration span;
    switch (period.toLowerCase()) {
      case 'day':
        span = const Duration(days: 1);
        break;
      case 'month':
        span = const Duration(days: 30);
        break;
      case 'quarter':
        span = const Duration(days: 90);
        break;
      case 'year':
        span = const Duration(days: 365);
        break;
      case 'week':
      default:
        span = const Duration(days: 7);
        break;
    }
    return (start: now.subtract(span), end: now);
  }

  /// Load all statistics data for the selected source + bank scope.
  ///
  /// [silent] keeps any already-visible data on screen (no skeleton) while the
  /// fresh result is fetched and emitted in place — used when revisiting a
  /// cached tab so the switch is instant.
  Future<void> loadStatistics({
    DateTime? startDate,
    DateTime? endDate,
    bool silent = false,
  }) async {
    if (_isLoading) return;
    _isLoading = true;
    // Snapshot the scope we're loading. A source/bank switch can land while
    // this async load is in flight; we must emit + cache under the scope we
    // actually fetched (not whatever _source is by the time we finish), and
    // re-load for the new scope afterwards if it drifted.
    final loadSource = _source;
    final loadBanks = List<String>.from(_selectedBankAccountIds);
    try {
      if (isClosed) return;
      // Non-destructive reload: when we already have loaded data (a source /
      // bank / period switch), keep it on screen and flip isRefreshing so the
      // screen swaps ONLY the content region to the skeleton — header + tabs
      // stay mounted. A true first load (no data yet) still emits Loading.
      if (state is StatisticsLoaded) {
        // silent: leave the current (cached) data on screen — no skeleton —
        // and swap in the fresh result when it lands.
        if (!silent) {
          emit((state as StatisticsLoaded).copyWith(isRefreshing: true));
        }
      } else {
        emit(const StatisticsLoading(loadingMessage: 'Loading statistics...'));
      }

      final now = DateTime.now();
      final start = startDate ?? now.subtract(const Duration(days: 7));
      final end = endDate ?? now;

      final includesExternal = loadSource != StatisticsSource.lazervault;
      final includesWallet = loadSource != StatisticsSource.bank;

      // Monthly trends is a WALLET-side query (accounts-service), so it can
      // only answer for the wallet. It used to run unscoped, which blended
      // linked-bank rows into it and returned the SAME chart on all three
      // tabs — wrong on every one of them: the LazerVault tab included bank
      // spend, and the bank tabs were never answered by this query at all.
      //
      // Now it reflects the scope it can actually serve, and the Bank-only tab
      // does not call it: there is no bank-side trends source, and showing a
      // wallet chart there would be worse than showing none.
      final monthlyTrendsFuture = includesWallet
          ? analyticsRepository.getMonthlyTrends(
              months: 6,
              includeExternalBanks: includesExternal,
            )
          : Future<accounts_pb.GetMonthlyTrendsResponse?>.value(null);

      // Freshness note: analytics read the LAST-SYNCED external transactions
      // stored in banking-service — never a live Mono pull on load. The old
      // once-per-session bulk `syncAllAccountTransactions` (a cost-incurring
      // unattended Mono fan-out over every linked bank) was REMOVED; the store
      // is kept fresh by the mono.events.account_updated webhook, per-account
      // sync, and each bank card's explicit fee-gated refresh.

      // ---- Wallet leg (accounts-service, external rows excluded) ----
      accounts_pb.GetFinancialAnalyticsResponse? walletFinancial;
      accounts_pb.GetCategoryAnalyticsResponse? walletCategory;
      accounts_pb.GetExpenseTimeSeriesResponse? walletSeries;
      if (includesWallet) {
        final walletResults = await Future.wait([
          analyticsRepository.getFinancialAnalytics(
              period: _currentPeriod, includeExternalBanks: false),
          analyticsRepository.getCategoryAnalytics(
              startDate: start, endDate: end, includeExternalBanks: false),
          analyticsRepository.getExpenseTimeSeries(
              startDate: start, endDate: end, includeExternalBanks: false),
        ]).timeout(_statsLoadTimeout);
        walletFinancial =
            walletResults[0] as accounts_pb.GetFinancialAnalyticsResponse;
        walletCategory =
            walletResults[1] as accounts_pb.GetCategoryAnalyticsResponse;
        walletSeries =
            walletResults[2] as accounts_pb.GetExpenseTimeSeriesResponse;
      }

      // ---- External leg (banking-service, all banks or one) ----
      banking_pb.GetExternalBankAnalyticsResponse? external;
      var externalStatus = ExternalDataStatus.notApplicable;
      String? externalError;
      if (includesExternal) {
        if (bankingDataSource == null || _userId.isEmpty) {
          externalStatus = ExternalDataStatus.unavailable;
          externalError = 'Bank data is not available right now.';
        } else {
          try {
            final resp = await bankingDataSource!.getExternalBankAnalytics(
              userId: _userId,
              // The proto's linked_account_id field carries a comma-separated set
              // of banks; empty = all linked banks. banking-service parses it into
              // an IN (...) scope over external_bank_transactions.
              linkedAccountId: loadBanks.isEmpty ? null : loadBanks.join(','),
              startDate: start,
              endDate: end,
            );
            if (resp.success) {
              external = resp;
              final hasActivity = resp.currentPeriod.transactionCount > 0 ||
                  resp.currentPeriod.totalExpenses > 0 ||
                  resp.currentPeriod.totalIncome > 0;
              externalStatus = hasActivity
                  ? ExternalDataStatus.ready
                  : ExternalDataStatus.empty;
            } else {
              externalStatus = ExternalDataStatus.unavailable;
              // Sanitize: never render a raw server/gRPC string to the user.
              externalError = resp.errorMessage.isNotEmpty
                  ? sanitizeUserFacingError(resp.errorMessage)
                  : 'Could not load bank analytics.';
            }
          } catch (e) {
            externalStatus = ExternalDataStatus.unavailable;
            externalError = 'Could not load bank analytics.';
          }
        }
      }

      // ---- Compose per the source contract ----
      final financialAnalytics =
          _composeFinancial(walletFinancial, external);
      final categoryAnalytics =
          _composeCategories(walletCategory, external);
      final expenseTimeSeries =
          _composeSeries(walletSeries, external, start, end);

      // Failed transactions are a wallet concept — only for wallet sources.
      accounts_pb.GetTransactionHistoryResponse? failedTransactions;
      if (includesWallet) {
        try {
          failedTransactions = await analyticsRepository.getFailedTransactions(
            startDate: start,
            endDate: end,
            includeExternalBanks: false,
          );
        } catch (_) {}
      }

      final monthlyTrends = await monthlyTrendsFuture.timeout(_statsLoadTimeout);

      if (isClosed) return;
      final loaded = StatisticsLoaded(
        startDate: start,
        endDate: end,
        financialAnalytics: financialAnalytics,
        categoryAnalytics: categoryAnalytics,
        monthlyTrends: monthlyTrends,
        expenseTimeSeries: expenseTimeSeries,
        failedTransactions: failedTransactions,
        currentPeriod: _currentPeriod,
        includeExternalBanks: includesExternal,
        source: loadSource,
        selectedBankAccountIds: loadBanks,
        externalStatus: externalStatus,
        externalError: externalError,
      );
      // Only paint it if the user is still on this scope; if they switched
      // mid-load we drop this result and repaint for the new scope below.
      if (_source == loadSource && _sameBankScope(loadBanks)) {
        emit(loaded);
      }
    } catch (e, stackTrace) {
      if (isClosed) return;
      // Don't surface a stale-scope failure over the current view: if the user
      // already switched away from the scope this load was for, drop it.
      if (_source != loadSource || !_sameBankScope(loadBanks)) {
        return;
      }
      emit(StatisticsError(
        message: friendlyError(e, context: 'load your statistics'),
        stackTrace: stackTrace,
      ));
    } finally {
      _isLoading = false;
      // A source/bank switch landed while this load was in flight — bring the
      // screen up to the scope the user is actually on now.
      if (!isClosed &&
          (_source != loadSource || !_sameBankScope(loadBanks))) {
        _switchScope();
      }
    }
  }

  /// Order-independent comparison of the active bank scope against a snapshot.
  bool _sameBankScope(List<String> snapshot) =>
      setEquals(_selectedBankAccountIds.toSet(), snapshot.toSet());

  // ===== Composition (additive merges — exact for the aggregates shown) =====

  static double _changePct(double cur, double prev) {
    if (prev <= 0) return cur > 0 ? 100.0 : 0.0;
    return ((cur - prev) / prev) * 100.0;
  }

  accounts_pb.GetFinancialAnalyticsResponse _composeFinancial(
    accounts_pb.GetFinancialAnalyticsResponse? wallet,
    banking_pb.GetExternalBankAnalyticsResponse? external,
  ) {
    final d = wallet?.clone() ?? accounts_pb.GetFinancialAnalyticsResponse();
    if (!d.hasCurrentPeriod()) d.currentPeriod = accounts_pb.PeriodTotals();
    if (!d.hasPreviousPeriod()) d.previousPeriod = accounts_pb.PeriodTotals();
    if (external != null) {
      d.currentPeriod.totalIncome += external.currentPeriod.totalIncome;
      d.currentPeriod.totalExpenses += external.currentPeriod.totalExpenses;
      d.currentPeriod.transactionCount += external.currentPeriod.transactionCount;
      d.previousPeriod.totalIncome += external.previousPeriod.totalIncome;
      d.previousPeriod.totalExpenses += external.previousPeriod.totalExpenses;
    }
    d.currentPeriod.net =
        d.currentPeriod.totalIncome - d.currentPeriod.totalExpenses;
    d.previousPeriod.net =
        d.previousPeriod.totalIncome - d.previousPeriod.totalExpenses;
    d.incomeChangePercent =
        _changePct(d.currentPeriod.totalIncome, d.previousPeriod.totalIncome);
    d.expenseChangePercent = _changePct(
        d.currentPeriod.totalExpenses, d.previousPeriod.totalExpenses);
    return d;
  }

  accounts_pb.GetCategoryAnalyticsResponse _composeCategories(
    accounts_pb.GetCategoryAnalyticsResponse? wallet,
    banking_pb.GetExternalBankAnalyticsResponse? external,
  ) {
    final d = wallet?.clone() ?? accounts_pb.GetCategoryAnalyticsResponse();
    if (external != null) {
      _mergeCategoryList(d.expenseCategories, external.expenseCategories);
      _mergeCategoryList(d.incomeCategories, external.incomeCategories);
      d.totalExpenses += external.currentPeriod.totalExpenses;
      d.totalIncome += external.currentPeriod.totalIncome;
    }
    _repercent(d.expenseCategories, d.totalExpenses);
    _repercent(d.incomeCategories, d.totalIncome);
    d.expenseCategories.sort((a, b) => b.amount.compareTo(a.amount));
    d.incomeCategories.sort((a, b) => b.amount.compareTo(a.amount));
    return d;
  }

  void _mergeCategoryList(
    List<accounts_pb.CategoryBreakdownItem> target,
    List<banking_pb.ExternalCategoryTotal> external,
  ) {
    final byName = <String, accounts_pb.CategoryBreakdownItem>{
      for (final t in target) t.categoryName.toLowerCase(): t,
    };
    for (final e in external) {
      final key = e.category.toLowerCase();
      final existing = byName[key];
      if (existing != null) {
        existing.amount += e.amount;
        existing.transactionCount += e.transactionCount;
      } else {
        final item = accounts_pb.CategoryBreakdownItem(
          categoryName: e.category,
          amount: e.amount,
          transactionCount: e.transactionCount,
        );
        target.add(item);
        byName[key] = item;
      }
    }
  }

  void _repercent(List<accounts_pb.CategoryBreakdownItem> items, double total) {
    for (final it in items) {
      it.percentage = total > 0 ? (it.amount / total) * 100.0 : 0.0;
    }
  }

  accounts_pb.GetExpenseTimeSeriesResponse _composeSeries(
    accounts_pb.GetExpenseTimeSeriesResponse? wallet,
    banking_pb.GetExternalBankAnalyticsResponse? external,
    DateTime start,
    DateTime end,
  ) {
    final d = wallet?.clone() ?? accounts_pb.GetExpenseTimeSeriesResponse();
    if (external != null) {
      final byDate = <String, accounts_pb.DailyExpensePoint>{
        for (final p in d.dataPoints) p.date: p,
      };
      for (final e in external.dailyExpenses) {
        final existing = byDate[e.date];
        if (existing != null) {
          existing.amount += e.expenseAmount;
        } else {
          final p = accounts_pb.DailyExpensePoint(
              date: e.date, amount: e.expenseAmount);
          d.dataPoints.add(p);
          byDate[e.date] = p;
        }
      }
      d.dataPoints.sort((a, b) => a.date.compareTo(b.date));
    }
    var total = 0.0;
    for (final p in d.dataPoints) {
      total += p.amount;
    }
    d.totalExpenses = total;
    d.dailyAverage =
        d.dataPoints.isNotEmpty ? total / d.dataPoints.length : 0.0;
    return d;
  }

  /// Refresh all data (re-reads the last-synced external analytics; no live
  /// Mono pull — bulk refresh was removed).
  Future<void> refresh() async {
    if (_isLoading) return;
    if (state is StatisticsLoaded) {
      final currentState = state as StatisticsLoaded;
      await loadStatistics(
        startDate: currentState.startDate,
        endDate: currentState.endDate,
      );
    } else {
      await loadStatistics();
    }
  }

  /// Change date range filter
  Future<void> changeDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await loadStatistics(startDate: startDate, endDate: endDate);
  }
}
