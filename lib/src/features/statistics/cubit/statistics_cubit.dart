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
  void changeSource(StatisticsSource source) {
    if (_source == source) return;
    _source = source;
    _reloadKeepingRange();
  }

  /// Change the external-bank scope: null = ALL linked banks, otherwise the
  /// one linked-account id. No-op for wallet-only source.
  void changeBank(String? linkedAccountId) {
    final normalized =
        (linkedAccountId == null || linkedAccountId.isEmpty) ? null : linkedAccountId;
    if (_selectedBankAccountId == normalized) return;
    _selectedBankAccountId = normalized;
    if (_source == StatisticsSource.lazervault) return;
    _reloadKeepingRange();
  }

  /// Change the analytics period (week/month/quarter/year) and reload.
  void changePeriod(String period) {
    _currentPeriod = period;
    _reloadKeepingRange();
  }

  void _reloadKeepingRange() {
    _periodDebouncer.runAsync(() async {
      if (state is StatisticsLoaded) {
        final currentState = state as StatisticsLoaded;
        await loadStatistics(
          startDate: currentState.startDate,
          endDate: currentState.endDate,
        );
      } else {
        await loadStatistics();
      }
    });
  }

  /// Load all statistics data for the selected source + bank scope.
  Future<void> loadStatistics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      if (isClosed) return;
      emit(const StatisticsLoading(loadingMessage: 'Loading statistics...'));

      final now = DateTime.now();
      final start = startDate ?? now.subtract(const Duration(days: 7));
      final end = endDate ?? now;

      final includesExternal = _source != StatisticsSource.lazervault;
      final includesWallet = _source != StatisticsSource.bank;

      // Monthly trends has no source filter — load once for every source.
      final monthlyTrendsFuture = analyticsRepository.getMonthlyTrends(months: 6);

      // Freshness: incremental sync of all linked banks once per session
      // before the first external-including load. Non-fatal.
      if (includesExternal && !_syncedThisSession && bankingDataSource != null && _userId.isNotEmpty) {
        try {
          await bankingDataSource!
              .syncAllAccountTransactions(userId: _userId, syncType: 'incremental')
              .timeout(const Duration(seconds: 25));
          _syncedThisSession = true;
        } catch (_) {
          // Last synced rows still serve; banks screen offers manual sync.
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
      if (includesExternal && bankingDataSource != null && _userId.isNotEmpty) {
        try {
          final resp = await bankingDataSource!.getExternalBankAnalytics(
            userId: _userId,
            linkedAccountId: _selectedBankAccountId,
            startDate: start,
            endDate: end,
          );
          if (resp.success) external = resp;
        } catch (_) {
          // External unavailable — wallet leg (or zeros for bank-only)
          // still renders; the banks section surfaces sync state.
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
      emit(StatisticsLoaded(
        startDate: start,
        endDate: end,
        financialAnalytics: financialAnalytics,
        categoryAnalytics: categoryAnalytics,
        monthlyTrends: monthlyTrends,
        expenseTimeSeries: expenseTimeSeries,
        failedTransactions: failedTransactions,
        currentPeriod: _currentPeriod,
        includeExternalBanks: includesExternal,
        source: _source,
        selectedBankAccountId: _selectedBankAccountId,
      ));
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(StatisticsError(
        message: 'Failed to load statistics: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    } finally {
      _isLoading = false;
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
