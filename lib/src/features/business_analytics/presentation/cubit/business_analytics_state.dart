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

  /// The period being fetched right now, when it DIFFERS from [selectedPeriod].
  ///
  /// Tapping a period chip used to emit a bare Loading state, and the screen
  /// swapped its whole body for a full-page spinner — throwing away the header,
  /// the tabs and the chips, so a filter tap read as the page reloading.
  ///
  /// Staying on Loaded keeps all of that on screen. The chip the user tapped is
  /// highlighted from this field, and only the sections whose numbers are about to
  /// change show a loader. Null when nothing is in flight.
  ///
  /// Distinct from [isStale], which means "these figures ARE the selected
  /// period's and are being revalidated" — there the numbers are still correct to
  /// show, and there is nothing to cover.
  final String? refreshingPeriod;

  /// Why the last period change failed, when it did.
  ///
  /// A failed period change used to emit BusinessAnalyticsError, which replaced
  /// the whole page — so a transient network blip threw away figures the user was
  /// reading. Keeping the page and reporting the failure in the section that
  /// asked is both less destructive and more accurate: the numbers on screen are
  /// still valid for [selectedPeriod], which is what the chip snaps back to.
  final String? refreshError;

  /// True while a period change is in flight, so the data sections can show a
  /// loader without having to compare strings themselves.
  bool get isChangingPeriod =>
      refreshingPeriod != null && refreshingPeriod != selectedPeriod;

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
    this.refreshingPeriod,
    this.refreshError,
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
    // Nullable field on a copyWith: passing null cannot mean "clear it", so an
    // explicit flag is the only way to end a period change.
    String? refreshingPeriod,
    bool clearRefreshingPeriod = false,
    String? refreshError,
    bool clearRefreshError = false,
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
      refreshingPeriod: clearRefreshingPeriod
          ? null
          : (refreshingPeriod ?? this.refreshingPeriod),
      refreshError:
          clearRefreshError ? null : (refreshError ?? this.refreshError),
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
