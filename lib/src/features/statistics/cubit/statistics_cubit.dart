import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/accounts.pb.dart' as accounts_pb;
import '../../../../core/utils/debouncer.dart';
import '../data/financial_analytics_repository.dart';
import 'statistics_state.dart';

/// Cubit for managing statistics state
class StatisticsCubit extends Cubit<StatisticsState> {
  final FinancialAnalyticsRepository analyticsRepository;
  String _currentPeriod = 'month';
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

      // Default to current month if no dates provided
      final start = startDate ?? DateTime(DateTime.now().year, DateTime.now().month, 1);
      final end = endDate ?? DateTime.now();

      // Load real financial analytics from accounts-service
      final analyticsResults = await Future.wait([
        analyticsRepository.getFinancialAnalytics(period: _currentPeriod),
        analyticsRepository.getCategoryAnalytics(startDate: start, endDate: end),
        analyticsRepository.getMonthlyTrends(months: 6),
        analyticsRepository.getExpenseTimeSeries(startDate: start, endDate: end),
      ]);

      final financialAnalytics = analyticsResults[0] as accounts_pb.GetFinancialAnalyticsResponse;
      final categoryAnalytics = analyticsResults[1] as accounts_pb.GetCategoryAnalyticsResponse;
      final monthlyTrends = analyticsResults[2] as accounts_pb.GetMonthlyTrendsResponse;
      final expenseTimeSeries = analyticsResults[3] as accounts_pb.GetExpenseTimeSeriesResponse;

      if (isClosed) return;
      emit(StatisticsLoaded(
        startDate: start,
        endDate: end,
        financialAnalytics: financialAnalytics,
        categoryAnalytics: categoryAnalytics,
        monthlyTrends: monthlyTrends,
        expenseTimeSeries: expenseTimeSeries,
        currentPeriod: _currentPeriod,
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
