import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

sealed class BusinessAnalyticsState {}

class BusinessAnalyticsInitial extends BusinessAnalyticsState {}

class BusinessAnalyticsLoading extends BusinessAnalyticsState {}

class BusinessAnalyticsLoaded extends BusinessAnalyticsState {
  final accounts_pb.GetFinancialAnalyticsResponse financialAnalytics;
  final accounts_pb.GetCategoryAnalyticsResponse categoryAnalytics;
  final accounts_pb.GetMonthlyTrendsResponse monthlyTrends;
  final accounts_pb.GetExpenseTimeSeriesResponse expenseTimeSeries;
  final String selectedPeriod;
  final bool isStale;

  BusinessAnalyticsLoaded({
    required this.financialAnalytics,
    required this.categoryAnalytics,
    required this.monthlyTrends,
    required this.expenseTimeSeries,
    required this.selectedPeriod,
    this.isStale = false,
  });

  BusinessAnalyticsLoaded copyWith({
    accounts_pb.GetFinancialAnalyticsResponse? financialAnalytics,
    accounts_pb.GetCategoryAnalyticsResponse? categoryAnalytics,
    accounts_pb.GetMonthlyTrendsResponse? monthlyTrends,
    accounts_pb.GetExpenseTimeSeriesResponse? expenseTimeSeries,
    String? selectedPeriod,
    bool? isStale,
  }) {
    return BusinessAnalyticsLoaded(
      financialAnalytics: financialAnalytics ?? this.financialAnalytics,
      categoryAnalytics: categoryAnalytics ?? this.categoryAnalytics,
      monthlyTrends: monthlyTrends ?? this.monthlyTrends,
      expenseTimeSeries: expenseTimeSeries ?? this.expenseTimeSeries,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      isStale: isStale ?? this.isStale,
    );
  }
}

class BusinessAnalyticsError extends BusinessAnalyticsState {
  final String message;
  BusinessAnalyticsError({required this.message});
}
