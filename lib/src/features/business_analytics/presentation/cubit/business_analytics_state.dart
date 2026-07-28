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

  // Sales-ledger figures for the Revenue tab (from the business overview
  // aggregator → GetSalesSummary). These are REPORTING figures from the sales
  // table — NOT the wallet ledger — so recorded sales show up as revenue without
  // ever crediting the wallet. In MINOR units (kobo). Currency in [salesCurrency].
  final int salesRevenue;
  final int salesReceivables;
  final String salesCurrency;

  BusinessAnalyticsLoaded({
    required this.financialAnalytics,
    required this.categoryAnalytics,
    required this.monthlyTrends,
    required this.expenseTimeSeries,
    required this.selectedPeriod,
    this.isStale = false,
    this.salesRevenue = 0,
    this.salesReceivables = 0,
    this.salesCurrency = 'NGN',
  });

  BusinessAnalyticsLoaded copyWith({
    accounts_pb.GetFinancialAnalyticsResponse? financialAnalytics,
    accounts_pb.GetCategoryAnalyticsResponse? categoryAnalytics,
    accounts_pb.GetMonthlyTrendsResponse? monthlyTrends,
    accounts_pb.GetExpenseTimeSeriesResponse? expenseTimeSeries,
    String? selectedPeriod,
    bool? isStale,
    int? salesRevenue,
    int? salesReceivables,
    String? salesCurrency,
  }) {
    return BusinessAnalyticsLoaded(
      financialAnalytics: financialAnalytics ?? this.financialAnalytics,
      categoryAnalytics: categoryAnalytics ?? this.categoryAnalytics,
      monthlyTrends: monthlyTrends ?? this.monthlyTrends,
      expenseTimeSeries: expenseTimeSeries ?? this.expenseTimeSeries,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      isStale: isStale ?? this.isStale,
      salesRevenue: salesRevenue ?? this.salesRevenue,
      salesReceivables: salesReceivables ?? this.salesReceivables,
      salesCurrency: salesCurrency ?? this.salesCurrency,
    );
  }
}

class BusinessAnalyticsError extends BusinessAnalyticsState {
  final String message;
  BusinessAnalyticsError({required this.message});
}
