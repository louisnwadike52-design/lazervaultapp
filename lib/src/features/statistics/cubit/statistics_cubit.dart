import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/accounts.pb.dart' as accounts_pb;
import '../../../generated/banking.pb.dart' as banking_pb;
import '../../../../core/utils/debouncer.dart';
import '../../open_banking/data/datasources/open_banking_grpc_datasource.dart';
import '../data/financial_analytics_repository.dart';
import 'statistics_state.dart';

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
  final FinancialAnalyticsRepository analyticsRepository;

  /// Banking-service surface for external-bank analytics + sync. Optional so
  /// existing constructions/tests keep working; without it, bank sources
  /// gracefully render wallet-only.
  final OpenBankingGrpcDataSource? bankingDataSource;

  String _currentPeriod = 'week';
  StatisticsSource _source = StatisticsSource.both;
  String? _selectedBankAccountId; // null = ALL linked banks
  String _userId = '';
  bool _isLoading = false;
  bool _syncedThisSession = false;
  final _periodDebouncer = Debouncer.typing();

  StatisticsCubit({
    required this.analyticsRepository,
    this.bankingDataSource,
  }) : super(StatisticsInitial());

  /// Currently selected money source (LazerVault / Bank / both).
  StatisticsSource get source => _source;

  /// Selected linked-bank scope (null = all banks).
  String? get selectedBankAccountId => _selectedBankAccountId;

  /// User id used for banking-service calls; set once by the screen.
  // ignore: avoid_setters_without_getters
  set userId(String id) => _userId = id;

  /// Test-only: set source without triggering the debounced reload.
  @visibleForTesting
  void changeSourceForTest(StatisticsSource s) => _source = s;

  /// Test-only: set bank scope without triggering the debounced reload.
  @visibleForTesting
  void changeBankForTest(String? id) => _selectedBankAccountId = id;

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
    _selectedBankAccountId = null;
    _switchScope();
  }

  /// Change the external-bank scope: null = ALL linked banks, otherwise the
  /// one linked-account id. No-op for wallet-only source.
  void changeBank(String? linkedAccountId) {
    final normalized =
        (linkedAccountId == null || linkedAccountId.isEmpty) ? null : linkedAccountId;
    if (_selectedBankAccountId == normalized) return;
    _selectedBankAccountId = normalized;
    if (_source == StatisticsSource.lazervault) return;
    _switchScope();
  }

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
    _reloadKeepingRange();
  }

  void _reloadKeepingRange({bool silent = false}) {
    _periodDebouncer.runAsync(() async {
      if (state is StatisticsLoaded) {
        final currentState = state as StatisticsLoaded;
        await loadStatistics(
          startDate: currentState.startDate,
          endDate: currentState.endDate,
          silent: silent,
        );
      } else {
        await loadStatistics(silent: silent);
      }
    });
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
    final loadBank = _selectedBankAccountId;
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

      // Monthly trends has no source filter — load once for every source.
      final monthlyTrendsFuture = analyticsRepository.getMonthlyTrends(months: 6);

      // Freshness: incremental sync of all linked banks once per session
      // before the first external-including load. The sync OUTCOME drives the
      // honesty signal below — a failed sync surfaces as 'unavailable', never
      // as fabricated zeros.
      bool syncFailedHard = false;
      String? syncError;
      if (includesExternal && !_syncedThisSession && bankingDataSource != null && _userId.isNotEmpty) {
        try {
          final res = await bankingDataSource!
              .syncAllAccountTransactions(userId: _userId, syncType: 'incremental')
              .timeout(const Duration(seconds: 25));
          _syncedThisSession = true;
          final relevant = loadBank == null
              ? res.accounts
              : res.accounts.where((a) => a.accountId == loadBank).toList();
          if (relevant.isNotEmpty && relevant.every((a) => !a.success)) {
            syncFailedHard = true;
            syncError = relevant.first.error ?? 'Could not sync bank transactions.';
          }
        } on TimeoutException {
          syncFailedHard = true;
          syncError = 'Bank sync timed out. Pull to refresh to try again.';
        } catch (e) {
          syncFailedHard = true;
          syncError = 'Could not reach your bank right now.';
        }
      }

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
        ]);
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
        } else if (syncFailedHard) {
          externalStatus = ExternalDataStatus.unavailable;
          externalError = syncError;
        } else {
          try {
            final resp = await bankingDataSource!.getExternalBankAnalytics(
              userId: _userId,
              linkedAccountId: loadBank,
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
              externalError = resp.errorMessage.isNotEmpty
                  ? resp.errorMessage
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

      final monthlyTrends = await monthlyTrendsFuture;

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
        selectedBankAccountId: loadBank,
        externalStatus: externalStatus,
        externalError: externalError,
      );
      // Only paint it if the user is still on this scope; if they switched
      // mid-load we drop this result and repaint for the new scope below.
      if (_source == loadSource && _selectedBankAccountId == loadBank) {
        emit(loaded);
      }
    } catch (e, stackTrace) {
      if (isClosed) return;
      // Don't surface a stale-scope failure over the current view: if the user
      // already switched away from the scope this load was for, drop it.
      if (_source != loadSource || _selectedBankAccountId != loadBank) {
        return;
      }
      emit(StatisticsError(
        message: 'Failed to load statistics: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    } finally {
      _isLoading = false;
      // A source/bank switch landed while this load was in flight — bring the
      // screen up to the scope the user is actually on now.
      if (!isClosed &&
          (_source != loadSource || _selectedBankAccountId != loadBank)) {
        _switchScope();
      }
    }
  }

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

  /// Refresh all data (also re-syncs external banks once per pull).
  Future<void> refresh() async {
    _syncedThisSession = false; // pull-to-refresh implies "get me fresh data"
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
