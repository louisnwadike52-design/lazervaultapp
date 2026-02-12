import 'package:equatable/equatable.dart';
import '../../../generated/accounts.pb.dart' as accounts_pb;

/// Base class for all statistics states
abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object?> get props => [];
}

/// Initial state when statistics feature is first loaded
class StatisticsInitial extends StatisticsState {}

/// Loading state while fetching data
class StatisticsLoading extends StatisticsState {
  final String? loadingMessage;

  const StatisticsLoading({this.loadingMessage});

  @override
  List<Object?> get props => [loadingMessage];
}

/// Loaded state with all statistics data
class StatisticsLoaded extends StatisticsState {
  final DateTime startDate;
  final DateTime endDate;

  // Financial Analytics (from accounts-service)
  final accounts_pb.GetFinancialAnalyticsResponse? financialAnalytics;
  final accounts_pb.GetCategoryAnalyticsResponse? categoryAnalytics;
  final accounts_pb.GetMonthlyTrendsResponse? monthlyTrends;
  final accounts_pb.GetExpenseTimeSeriesResponse? expenseTimeSeries;
  final String currentPeriod;

  const StatisticsLoaded({
    required this.startDate,
    required this.endDate,
    this.financialAnalytics,
    this.categoryAnalytics,
    this.monthlyTrends,
    this.expenseTimeSeries,
    this.currentPeriod = 'month',
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        financialAnalytics,
        categoryAnalytics,
        monthlyTrends,
        expenseTimeSeries,
        currentPeriod,
      ];

  /// Create a copy with updated fields
  StatisticsLoaded copyWith({
    DateTime? startDate,
    DateTime? endDate,
    accounts_pb.GetFinancialAnalyticsResponse? financialAnalytics,
    accounts_pb.GetCategoryAnalyticsResponse? categoryAnalytics,
    accounts_pb.GetMonthlyTrendsResponse? monthlyTrends,
    accounts_pb.GetExpenseTimeSeriesResponse? expenseTimeSeries,
    String? currentPeriod,
  }) {
    return StatisticsLoaded(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      financialAnalytics: financialAnalytics ?? this.financialAnalytics,
      categoryAnalytics: categoryAnalytics ?? this.categoryAnalytics,
      monthlyTrends: monthlyTrends ?? this.monthlyTrends,
      expenseTimeSeries: expenseTimeSeries ?? this.expenseTimeSeries,
      currentPeriod: currentPeriod ?? this.currentPeriod,
    );
  }
}

/// Error state with detailed error message
class StatisticsError extends StatisticsState {
  final String message;
  final String? errorCode;
  final StackTrace? stackTrace;

  const StatisticsError({
    required this.message,
    this.errorCode,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, errorCode, stackTrace];
}
