import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/business_analytics/presentation/cubit/business_analytics_state.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

/// Tapping a period chip must not read as the page reloading.
///
/// Reported from a screenshot of the business analytics screen: tapping "Week"
/// (or any filter) replaced the entire page with a spinner. The cubit emitted a
/// bare BusinessAnalyticsLoading, and the screen's switch mapped that to
/// _buildLoadingState() — which swapped the whole body, so the header, the tab
/// bar and the chips all vanished and came back.
///
/// The cubit now stays on BusinessAnalyticsLoaded through a period change and
/// marks the pending period instead, so only the data sections are covered.

BusinessAnalyticsLoaded loaded({
  String period = 'month',
  String? refreshingPeriod,
  String? refreshError,
}) =>
    BusinessAnalyticsLoaded(
      financialAnalytics: accounts_pb.GetFinancialAnalyticsResponse(),
      categoryAnalytics: accounts_pb.GetCategoryAnalyticsResponse(),
      monthlyTrends: accounts_pb.GetMonthlyTrendsResponse(),
      expenseTimeSeries: accounts_pb.GetExpenseTimeSeriesResponse(),
      selectedPeriod: period,
      refreshingPeriod: refreshingPeriod,
      refreshError: refreshError,
    );

void main() {
  group('isChangingPeriod', () {
    test('is false when nothing is in flight', () {
      expect(loaded().isChangingPeriod, isFalse);
    });

    test('is true while a DIFFERENT period is being fetched', () {
      expect(
        loaded(period: 'month', refreshingPeriod: 'week').isChangingPeriod,
        isTrue,
      );
    });

    test('is false when the pending period is the one already shown', () {
      // A plain revalidation of the CURRENT period has nothing to cover — the
      // figures on screen are still the right ones. That is what isStale is for.
      expect(
        loaded(period: 'week', refreshingPeriod: 'week').isChangingPeriod,
        isFalse,
      );
    });
  });

  group('copyWith on the nullable fields', () {
    test('carries refreshingPeriod forward by default', () {
      final s = loaded(refreshingPeriod: 'week').copyWith();
      expect(s.refreshingPeriod, 'week');
    });

    test('clears it only when asked explicitly', () {
      // Passing null to copyWith cannot mean "clear", so an explicit flag is the
      // only way to end a period change — without it the section loader would
      // never come down.
      final s = loaded(refreshingPeriod: 'week')
          .copyWith(clearRefreshingPeriod: true);
      expect(s.refreshingPeriod, isNull);
      expect(s.isChangingPeriod, isFalse);
    });

    test('the same holds for refreshError', () {
      final withErr = loaded(refreshError: 'boom');
      expect(withErr.copyWith().refreshError, 'boom');
      expect(withErr.copyWith(clearRefreshError: true).refreshError, isNull);
    });
  });

  group('the cubit keeps the page during a period change', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/business_analytics/presentation/cubit/'
        'business_analytics_cubit.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'business_analytics_cubit.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test('emits Loaded with a pending period rather than a bare Loading', () {
      expect(source, contains('previous.copyWith(refreshingPeriod: period)'),
          reason: 'a bare Loading state is what blanked the whole page');
    });

    test('a full-page loader survives only for a cold open', () {
      // With nothing on screen there is no chrome to preserve, so a full-page
      // loader is honest there and must stay.
      expect(source, contains('emit(BusinessAnalyticsLoading())'));
      expect(source, contains('previous is BusinessAnalyticsLoaded'));
    });

    test('a failed period change does not replace the page', () {
      expect(source, contains('clearRefreshingPeriod: true'),
          reason: 'the chip must snap back to the period actually on screen');
      expect(source, contains('refreshError: e.toString()'),
          reason: 'the failure is reported in the section, not by destroying '
              'figures the user was reading over a transient blip');
    });
  });

  group('the screen scopes the loader', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/business_analytics/presentation/views/'
        'analytics_screen.dart',
      );
      expect(file.existsSync(), isTrue);
      source = file.readAsStringSync();
    });

    test('every tab wraps its data, not its chrome', () {
      // Three tabs: overview, revenue, expenses.
      expect(
        'AnalyticsSectionRefresh('.allMatches(source).length,
        3,
        reason: 'each tab must scope its own loader',
      );
    });

    test('the chip highlight follows the tap in every tab', () {
      // Counted on the SELECTOR argument specifically: the same expression also
      // appears in each wrapper's onRetry, so a bare count of it finds six.
      expect(
        'selectedPeriod: state.refreshingPeriod ?? state.selectedPeriod'
            .allMatches(source)
            .length,
        3,
        reason: 'without this the tapped chip stays unhighlighted until the '
            'fetch returns, so the tap reads as ignored',
      );
    });

    test('retry re-requests the period that failed', () {
      expect(source, contains('.changePeriod(state.refreshingPeriod ??'),
          reason: 'retrying the period already on screen would be a no-op');
    });
  });
}
