import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/business/data/services/business_overview_service.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import 'business_analytics_state.dart';

class BusinessAnalyticsCubit extends Cubit<BusinessAnalyticsState> {
  final accounts_grpc.AccountsServiceClient accountsClient;
  final GrpcCallOptionsHelper callOptionsHelper;
  String? _accountId;

  // Per-period memo so switching periods/tabs (or re-opening) serves instantly
  // from cache instead of re-issuing the 5 analytics round-trips. Cleared on
  // refresh() and when the account changes.
  final Map<String, BusinessAnalyticsLoaded> _cache = {};

  // The period the user is currently viewing — a background revalidation only
  // emits its fresh result if the user is still on that period.
  String _currentPeriod = 'month';

  BusinessAnalyticsCubit({
    required this.accountsClient,
    required this.callOptionsHelper,
  }) : super(BusinessAnalyticsInitial());

  void setAccountId(String accountId) {
    if (_accountId != accountId) _cache.clear(); // account switched → drop memo
    _accountId = accountId;
  }

  Future<void> loadAnalytics({String period = 'month', bool force = false}) async {
    if (_accountId == null) {
      emit(BusinessAnalyticsError(message: 'No business account selected'));
      return;
    }
    _currentPeriod = period;

    // Stale-while-revalidate: if we have a memoised value, show it INSTANTLY
    // (marked stale) and refresh in the BACKGROUND — no spinner, and the fresh
    // data auto-re-emits so the screen updates itself without a reload.
    final cached = _cache[_cacheKey(period)];
    if (!force && cached != null) {
      emit(cached.copyWith(isStale: true));
      unawaited(_fetchAndCache(period, background: true));
      return;
    }

    emit(BusinessAnalyticsLoading());
    await _fetchAndCache(period, background: false);
  }

  /// Fetches the full analytics batch, caches it, and emits it — but a
  /// [background] revalidation stays silent on failure (keeps the stale cache)
  /// and only emits if the user is still viewing [period].
  Future<void> _fetchAndCache(String period, {required bool background}) async {
    try {
      final options = await callOptionsHelper.withAuth();
      final dateRange = _getDateRange(period);
      // Scope every analytics aggregate to the ACTIVE locale. The handlers read
      // the proto `locale` field (not the x-locale header) and skip the locale
      // filter when it's empty — so without this the four aggregates sum
      // transactions across ALL locales, mixing currencies for a multi-locale
      // account. Mirrors the per-account+locale scoping used by invoices.
      final locale = serviceLocator<LocaleManager>().currentLocale;

      final results = await Future.wait([
        accountsClient.getFinancialAnalytics(
          accounts_pb.GetFinancialAnalyticsRequest(
            accountId: _accountId!,
            period: period,
            locale: locale,
          ),
          options: options,
        ),
        accountsClient.getCategoryAnalytics(
          accounts_pb.GetCategoryAnalyticsRequest(
            accountId: _accountId!,
            startDate: dateRange.$1,
            endDate: dateRange.$2,
            locale: locale,
          ),
          options: options,
        ),
        accountsClient.getMonthlyTrends(
          accounts_pb.GetMonthlyTrendsRequest(
            accountId: _accountId!,
            months: _getMonthsForPeriod(period),
            locale: locale,
          ),
          options: options,
        ),
        accountsClient.getExpenseTimeSeries(
          accounts_pb.GetExpenseTimeSeriesRequest(
            accountId: _accountId!,
            startDate: dateRange.$1,
            endDate: dateRange.$2,
            locale: locale,
          ),
          options: options,
        ),
      ]);

      // Sales revenue for the Revenue tab comes from the business overview
      // aggregator (→ GetSalesSummary on the sales table), NOT the wallet ledger.
      // Best-effort: a failure here must never blank out the ledger analytics.
      int salesRevenue = 0;
      int salesReceivables = 0;
      String salesCurrency = 'NGN';
      try {
        final overview = await BusinessOverviewService(endpoints: endpointRegistry)
            .getOverview(periodStart: dateRange.$1, periodEnd: dateRange.$2);
        salesRevenue = overview.revenue;
        salesReceivables = overview.receivables;
        if (overview.currency.isNotEmpty) salesCurrency = overview.currency;
      } catch (_) {
        // Leave zeros — the Revenue tab still renders the ledger-based charts.
      }

      final loaded = BusinessAnalyticsLoaded(
        financialAnalytics:
            results[0] as accounts_pb.GetFinancialAnalyticsResponse,
        categoryAnalytics:
            results[1] as accounts_pb.GetCategoryAnalyticsResponse,
        monthlyTrends: results[2] as accounts_pb.GetMonthlyTrendsResponse,
        expenseTimeSeries:
            results[3] as accounts_pb.GetExpenseTimeSeriesResponse,
        selectedPeriod: period,
        salesRevenue: salesRevenue,
        salesReceivables: salesReceivables,
        salesCurrency: salesCurrency,
      );
      _cache[_cacheKey(period)] = loaded; // memo for instant period/tab switches
      // Only surface if the user is still viewing this period (a background
      // revalidation must not clobber a period the user has since switched to).
      if (_currentPeriod == period) emit(loaded);
    } catch (e) {
      // Foreground: surface the error. Background: keep the stale cache silently.
      if (!background && _currentPeriod == period) {
        emit(BusinessAnalyticsError(message: e.toString()));
      }
    }
  }

  Future<void> changePeriod(String period) async {
    final currentState = state;
    // No-op if the same period is already shown (SWR still revalidates on load).
    if (currentState is BusinessAnalyticsLoaded &&
        currentState.selectedPeriod == period &&
        !currentState.isStale) {
      return;
    }
    // loadAnalytics handles the instant-cache + background revalidate.
    await loadAnalytics(period: period);
  }

  Future<void> refresh() async {
    // Explicit pull-to-refresh: revalidate in the background so the current
    // content stays on screen (the RefreshIndicator shows its own spinner).
    _currentPeriod =
        state is BusinessAnalyticsLoaded ? (state as BusinessAnalyticsLoaded).selectedPeriod : _currentPeriod;
    await _fetchAndCache(_currentPeriod, background: true);
  }

  // Cache key includes the active locale so a locale/currency switch never
  // serves another locale's cached analytics (period alone would collide).
  String _cacheKey(String period) =>
      '$period|${serviceLocator<LocaleManager>().currentLocale}';

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
