import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import 'business_analytics_state.dart';

class BusinessAnalyticsCubit extends Cubit<BusinessAnalyticsState> {
  final accounts_grpc.AccountsServiceClient accountsClient;
  final GrpcCallOptionsHelper callOptionsHelper;
  String? _accountId;

  BusinessAnalyticsCubit({
    required this.accountsClient,
    required this.callOptionsHelper,
  }) : super(BusinessAnalyticsInitial());

  void setAccountId(String accountId) {
    _accountId = accountId;
  }

  Future<void> loadAnalytics({String period = 'month'}) async {
    if (_accountId == null) {
      emit(BusinessAnalyticsError(message: 'No business account selected'));
      return;
    }

    emit(BusinessAnalyticsLoading());

    try {
      final options = await callOptionsHelper.withAuth();
      final dateRange = _getDateRange(period);

      final results = await Future.wait([
        accountsClient.getFinancialAnalytics(
          accounts_pb.GetFinancialAnalyticsRequest(
            accountId: _accountId!,
            period: period,
          ),
          options: options,
        ),
        accountsClient.getCategoryAnalytics(
          accounts_pb.GetCategoryAnalyticsRequest(
            accountId: _accountId!,
            startDate: dateRange.$1,
            endDate: dateRange.$2,
          ),
          options: options,
        ),
        accountsClient.getMonthlyTrends(
          accounts_pb.GetMonthlyTrendsRequest(
            accountId: _accountId!,
            months: _getMonthsForPeriod(period),
          ),
          options: options,
        ),
        accountsClient.getExpenseTimeSeries(
          accounts_pb.GetExpenseTimeSeriesRequest(
            accountId: _accountId!,
            startDate: dateRange.$1,
            endDate: dateRange.$2,
          ),
          options: options,
        ),
      ]);

      emit(BusinessAnalyticsLoaded(
        financialAnalytics:
            results[0] as accounts_pb.GetFinancialAnalyticsResponse,
        categoryAnalytics:
            results[1] as accounts_pb.GetCategoryAnalyticsResponse,
        monthlyTrends: results[2] as accounts_pb.GetMonthlyTrendsResponse,
        expenseTimeSeries:
            results[3] as accounts_pb.GetExpenseTimeSeriesResponse,
        selectedPeriod: period,
      ));
    } catch (e) {
      emit(BusinessAnalyticsError(message: e.toString()));
    }
  }

  Future<void> changePeriod(String period) async {
    final currentState = state;
    if (currentState is BusinessAnalyticsLoaded) {
      emit(currentState.copyWith(selectedPeriod: period, isStale: true));
    }
    await loadAnalytics(period: period);
  }

  Future<void> refresh() async {
    final currentState = state;
    final period = currentState is BusinessAnalyticsLoaded
        ? currentState.selectedPeriod
        : 'month';
    await loadAnalytics(period: period);
  }

  int _getMonthsForPeriod(String period) {
    switch (period) {
      case 'week':
        return 3;
      case 'month':
        return 6;
      case 'quarter':
        return 12;
      default:
        return 6;
    }
  }

  (String, String) _getDateRange(String period) {
    final now = DateTime.now();
    DateTime start;
    switch (period) {
      case 'today':
        start = DateTime(now.year, now.month, now.day);
      case 'week':
        start = now.subtract(const Duration(days: 7));
      case 'month':
        start = DateTime(now.year, now.month, 1);
      case 'quarter':
        final quarterStart = ((now.month - 1) ~/ 3) * 3 + 1;
        start = DateTime(now.year, quarterStart, 1);
      default:
        start = DateTime(now.year, now.month, 1);
    }
    String formatDate(DateTime d) =>
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return (formatDate(start), formatDate(now));
  }
}
