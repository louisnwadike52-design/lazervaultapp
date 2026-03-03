import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/accounts.pb.dart' as accounts_pb;
import '../../../../core/utils/debouncer.dart';
import '../data/financial_analytics_repository.dart';
import 'statistics_state.dart';

/// Cubit for managing statistics state
class StatisticsCubit extends Cubit<StatisticsState> {
  final FinancialAnalyticsRepository analyticsRepository;
  String _currentPeriod = 'week'; // Changed from 'month' to 'week' - default to weekly date range
  bool _includeExternalBanks = true; // Default to including external banks
  bool _isLoading = false;
  final _periodDebouncer = Debouncer.typing();

  StatisticsCubit({
    required this.analyticsRepository,
  }) : super(StatisticsInitial());

  @override
  Future<void> close() {
    _periodDebouncer.dispose();
    return super.close();
  }

  /// Toggle external bank transactions inclusion
  void toggleExternalBanks(bool include) {
    _includeExternalBanks = include;
    _periodDebouncer.runAsync(() async {
      if (state is StatisticsLoaded) {
        final currentState = state as StatisticsLoaded;
        await loadStatistics(
          startDate: currentState.startDate,
          endDate: currentState.endDate,
        );
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

  /// Load all statistics data from accounts-service
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

      // Load core analytics (these are required for the page)
      final coreResults = await Future.wait([
        analyticsRepository.getFinancialAnalytics(
          period: _currentPeriod,
          includeExternalBanks: _includeExternalBanks,
        ),
        analyticsRepository.getCategoryAnalytics(
          startDate: start,
          endDate: end,
          includeExternalBanks: _includeExternalBanks,
        ),
        analyticsRepository.getMonthlyTrends(months: 6),
        analyticsRepository.getExpenseTimeSeries(
          startDate: start,
          endDate: end,
          includeExternalBanks: _includeExternalBanks,
        ),
      ]);

      // Load failed transactions separately — non-fatal if this fails
      accounts_pb.GetTransactionHistoryResponse? failedTransactions;
      try {
        failedTransactions = await analyticsRepository.getFailedTransactions(
          startDate: start,
          endDate: end,
          includeExternalBanks: _includeExternalBanks,
        );
      } catch (_) {
        // Silently ignore — failed transactions card simply won't show
      }

      final financialAnalytics = coreResults[0] as accounts_pb.GetFinancialAnalyticsResponse;
      final categoryAnalytics = coreResults[1] as accounts_pb.GetCategoryAnalyticsResponse;
      final monthlyTrends = coreResults[2] as accounts_pb.GetMonthlyTrendsResponse;
      final expenseTimeSeries = coreResults[3] as accounts_pb.GetExpenseTimeSeriesResponse;

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
        includeExternalBanks: _includeExternalBanks,
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
