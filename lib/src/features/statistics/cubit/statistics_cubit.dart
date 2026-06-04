import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/accounts.pb.dart' as accounts_pb;
import '../../../../core/utils/debouncer.dart';
import '../data/financial_analytics_repository.dart';
import 'statistics_state.dart';

/// Cubit for managing statistics state
class StatisticsCubit extends Cubit<StatisticsState> {
  final FinancialAnalyticsRepository analyticsRepository;
  String _currentPeriod = 'week'; // Changed from 'month' to 'week' - default to weekly date range
  StatisticsSource _source = StatisticsSource.both; // LazerVault + banks by default
  bool _isLoading = false;
  final _periodDebouncer = Debouncer.typing();

  StatisticsCubit({
    required this.analyticsRepository,
  }) : super(StatisticsInitial());

  /// Currently selected money source (LazerVault / Bank / both).
  StatisticsSource get source => _source;

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

  /// Change the money source the content reflects (LazerVault / Bank / both)
  /// and reload so the screen re-renders for the selected source.
  void changeSource(StatisticsSource source) {
    if (_source == source) return;
    _source = source;
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

  /// Change the analytics period (week/month/quarter/year) and reload
  void changePeriod(String period) {
    _currentPeriod = period;
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

  /// Load all statistics data from accounts-service for the selected source.
  Future<void> loadStatistics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      if (isClosed) return;
      emit(const StatisticsLoading(loadingMessage: 'Loading statistics...'));

      // Default to current week if no dates provided (last 7 days to now)
      final now = DateTime.now();
      final start = startDate ?? now.subtract(const Duration(days: 7));
      final end = endDate ?? now;

      // Monthly trends has no source filter — load once for every source.
      final monthlyTrendsFuture = analyticsRepository.getMonthlyTrends(months: 6);

      late final accounts_pb.GetFinancialAnalyticsResponse financialAnalytics;
      late final accounts_pb.GetCategoryAnalyticsResponse categoryAnalytics;
      late final accounts_pb.GetExpenseTimeSeriesResponse expenseTimeSeries;

      if (_source == StatisticsSource.bank) {
        // The backend exposes wallet-only and combined (wallet + banks), but not
        // bank-only. Bank = combined MINUS wallet, which is exact for the additive
        // aggregates this screen renders (period totals, per-category amounts,
        // per-day amounts). We fetch both and subtract.
        final both = await Future.wait([
          analyticsRepository.getFinancialAnalytics(period: _currentPeriod, includeExternalBanks: true),
          analyticsRepository.getCategoryAnalytics(startDate: start, endDate: end, includeExternalBanks: true),
          analyticsRepository.getExpenseTimeSeries(startDate: start, endDate: end, includeExternalBanks: true),
        ]);
        final wallet = await Future.wait([
          analyticsRepository.getFinancialAnalytics(period: _currentPeriod, includeExternalBanks: false),
          analyticsRepository.getCategoryAnalytics(startDate: start, endDate: end, includeExternalBanks: false),
          analyticsRepository.getExpenseTimeSeries(startDate: start, endDate: end, includeExternalBanks: false),
        ]);
        financialAnalytics = _deriveBankFinancial(
          both[0] as accounts_pb.GetFinancialAnalyticsResponse,
          wallet[0] as accounts_pb.GetFinancialAnalyticsResponse,
        );
        categoryAnalytics = _deriveBankCategory(
          both[1] as accounts_pb.GetCategoryAnalyticsResponse,
          wallet[1] as accounts_pb.GetCategoryAnalyticsResponse,
        );
        expenseTimeSeries = _deriveBankTimeSeries(
          both[2] as accounts_pb.GetExpenseTimeSeriesResponse,
          wallet[2] as accounts_pb.GetExpenseTimeSeriesResponse,
        );
      } else {
        final includeExternal = _source.includesExternal;
        final coreResults = await Future.wait([
          analyticsRepository.getFinancialAnalytics(period: _currentPeriod, includeExternalBanks: includeExternal),
          analyticsRepository.getCategoryAnalytics(startDate: start, endDate: end, includeExternalBanks: includeExternal),
          analyticsRepository.getExpenseTimeSeries(startDate: start, endDate: end, includeExternalBanks: includeExternal),
        ]);
        financialAnalytics = coreResults[0] as accounts_pb.GetFinancialAnalyticsResponse;
        categoryAnalytics = coreResults[1] as accounts_pb.GetCategoryAnalyticsResponse;
        expenseTimeSeries = coreResults[2] as accounts_pb.GetExpenseTimeSeriesResponse;
      }

      // Load failed transactions separately — non-fatal if this fails
      accounts_pb.GetTransactionHistoryResponse? failedTransactions;
      try {
        failedTransactions = await analyticsRepository.getFailedTransactions(
          startDate: start,
          endDate: end,
          includeExternalBanks: _source.includesExternal,
        );
      } catch (_) {
        // Silently ignore — failed transactions card simply won't show
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
        includeExternalBanks: _source.includesExternal,
        source: _source,
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

  // ===== Bank-only derivation (combined MINUS wallet) =====

  static double _pos(double v) => v < 0 ? 0 : v;

  static double _changePct(double cur, double prev) {
    if (prev <= 0) return cur > 0 ? 100.0 : 0.0;
    return ((cur - prev) / prev) * 100.0;
  }

  /// Bank-only financial analytics = combined period totals minus wallet totals.
  accounts_pb.GetFinancialAnalyticsResponse _deriveBankFinancial(
    accounts_pb.GetFinancialAnalyticsResponse both,
    accounts_pb.GetFinancialAnalyticsResponse wallet,
  ) {
    final d = both.clone();
    if (d.hasCurrentPeriod() && wallet.hasCurrentPeriod()) {
      d.currentPeriod.totalIncome = _pos(both.currentPeriod.totalIncome - wallet.currentPeriod.totalIncome);
      d.currentPeriod.totalExpenses = _pos(both.currentPeriod.totalExpenses - wallet.currentPeriod.totalExpenses);
      d.currentPeriod.net = d.currentPeriod.totalIncome - d.currentPeriod.totalExpenses;
      d.currentPeriod.transactionCount =
          math.max(0, both.currentPeriod.transactionCount - wallet.currentPeriod.transactionCount);
    }
    if (d.hasPreviousPeriod() && wallet.hasPreviousPeriod()) {
      d.previousPeriod.totalIncome = _pos(both.previousPeriod.totalIncome - wallet.previousPeriod.totalIncome);
      d.previousPeriod.totalExpenses = _pos(both.previousPeriod.totalExpenses - wallet.previousPeriod.totalExpenses);
      d.previousPeriod.net = d.previousPeriod.totalIncome - d.previousPeriod.totalExpenses;
    }
    if (d.hasCurrentPeriod()) {
      final prevInc = d.hasPreviousPeriod() ? d.previousPeriod.totalIncome : 0.0;
      final prevExp = d.hasPreviousPeriod() ? d.previousPeriod.totalExpenses : 0.0;
      d.incomeChangePercent = _changePct(d.currentPeriod.totalIncome, prevInc);
      d.expenseChangePercent = _changePct(d.currentPeriod.totalExpenses, prevExp);
    }
    return d;
  }

  /// Bank-only category breakdown = per-category combined amount minus wallet,
  /// dropping categories that net to zero and recomputing percentages.
  accounts_pb.GetCategoryAnalyticsResponse _deriveBankCategory(
    accounts_pb.GetCategoryAnalyticsResponse both,
    accounts_pb.GetCategoryAnalyticsResponse wallet,
  ) {
    final d = both.clone();
    d.expenseCategories
      ..clear()
      ..addAll(_subtractCategories(both.expenseCategories, wallet.expenseCategories));
    d.incomeCategories
      ..clear()
      ..addAll(_subtractCategories(both.incomeCategories, wallet.incomeCategories));
    d.totalExpenses = _pos(both.totalExpenses - wallet.totalExpenses);
    d.totalIncome = _pos(both.totalIncome - wallet.totalIncome);
    _repercent(d.expenseCategories, d.totalExpenses);
    _repercent(d.incomeCategories, d.totalIncome);
    return d;
  }

  List<accounts_pb.CategoryBreakdownItem> _subtractCategories(
    List<accounts_pb.CategoryBreakdownItem> both,
    List<accounts_pb.CategoryBreakdownItem> wallet,
  ) {
    final walletByName = <String, accounts_pb.CategoryBreakdownItem>{
      for (final w in wallet) w.categoryName: w,
    };
    final out = <accounts_pb.CategoryBreakdownItem>[];
    for (final b in both) {
      final w = walletByName[b.categoryName];
      final amount = _pos(b.amount - (w?.amount ?? 0));
      if (amount <= 0) continue;
      final item = b.clone();
      item.amount = amount;
      item.transactionCount = math.max(0, b.transactionCount - (w?.transactionCount ?? 0));
      out.add(item);
    }
    out.sort((a, b) => b.amount.compareTo(a.amount));
    return out;
  }

  void _repercent(List<accounts_pb.CategoryBreakdownItem> items, double total) {
    for (final it in items) {
      it.percentage = total > 0 ? (it.amount / total) * 100.0 : 0.0;
    }
  }

  /// Bank-only daily series = per-day combined amount minus wallet.
  accounts_pb.GetExpenseTimeSeriesResponse _deriveBankTimeSeries(
    accounts_pb.GetExpenseTimeSeriesResponse both,
    accounts_pb.GetExpenseTimeSeriesResponse wallet,
  ) {
    final d = both.clone();
    final walletByDate = <String, double>{
      for (final w in wallet.dataPoints) w.date: w.amount,
    };
    var total = 0.0;
    for (final p in d.dataPoints) {
      p.amount = _pos(p.amount - (walletByDate[p.date] ?? 0));
      total += p.amount;
    }
    d.totalExpenses = total;
    d.dailyAverage = d.dataPoints.isNotEmpty ? total / d.dataPoints.length : 0.0;
    return d;
  }

  /// Refresh all data
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
