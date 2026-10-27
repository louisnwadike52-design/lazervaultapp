// The statistics tab must paint what the singleton cubit already holds and
// refresh it behind — never a skeleton over figures for the SAME scope, and
// never an error screen over them when that background refresh fails. A
// scope switch (source / bank / wallet / period) is different: its figures
// are not in yet, so the skeleton and, on failure, the error are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_scope_policy.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/data/financial_analytics_repository.dart';

class _FakeGrpc extends Mock implements AccountsGrpcClient {}

/// Every analytics call throws (unstubbed mock), so a load over it fails.
class _FailingRepo extends Mock implements FinancialAnalyticsRepository {}

/// Lets a test start from a loaded state without a working backend.
class _SeedableCubit extends StatisticsCubit {
  _SeedableCubit({required super.analyticsRepository});
  void seed(StatisticsState s) => emit(s);
}

void main() {
  late _SeedableCubit cubit;
  late _SeedableCubit failing;

  StatisticsLoaded loaded({
    StatisticsSource source = StatisticsSource.both,
    String period = 'week',
    List<String> banks = const [],
  }) =>
      StatisticsLoaded(
        startDate: DateTime(2026, 10, 20),
        endDate: DateTime(2026, 10, 27),
        currentPeriod: period,
        source: source,
        selectedBankAccountIds: banks,
      );

  setUp(() {
    cubit = _SeedableCubit(
      analyticsRepository: FinancialAnalyticsRepository(
        grpcClient: _FakeGrpc(),
        accountManager: AccountManager(),
        localeManager: LocaleManager(),
      ),
    );
    cubit.userId = 'chris';
    failing = _SeedableCubit(analyticsRepository: _FailingRepo());
    failing.userId = 'chris';
  });

  tearDown(() async {
    await cubit.close();
    await failing.close();
  });

  group('scope policy', () {
    test('a loaded state for the current scope needs no skeleton', () {
      final s = loaded(period: 'week').copyWith(isRefreshing: true);
      expect(
        statisticsShowSkeleton(s,
            source: StatisticsSource.both,
            bankAccountIds: const [],
            walletIds: const [],
            period: 'week'),
        isFalse,
      );
    });

    test('a loaded state for ANOTHER scope still shows the skeleton', () {
      final s = loaded(period: 'week').copyWith(isRefreshing: true);
      expect(
        statisticsShowSkeleton(s,
            source: StatisticsSource.both,
            bankAccountIds: const [],
            walletIds: const [],
            period: 'month'),
        isTrue,
        reason: 'the held figures answer for a week, the chip says month',
      );
      expect(
        statisticsShowSkeleton(s,
            source: StatisticsSource.bank,
            bankAccountIds: const [],
            walletIds: const [],
            period: 'week'),
        isTrue,
      );
    });

    test('nothing loaded always shows the skeleton', () {
      for (final s in [StatisticsInitial(), const StatisticsLoading()]) {
        expect(
          statisticsShowSkeleton(s,
              source: StatisticsSource.both,
              bankAccountIds: const [],
              walletIds: const [],
              period: 'week'),
          isTrue,
        );
      }
    });
  });

  group('silent re-entry', () {
    test('keeps the figures on screen and never flips isRefreshing', () async {
      cubit.seed(loaded());
      final emitted = <StatisticsState>[];
      final sub = cubit.stream.listen(emitted.add);

      await cubit.loadStatistics(silent: true);
      await sub.cancel();

      expect(emitted.whereType<StatisticsLoading>(), isEmpty);
      expect(
        emitted.whereType<StatisticsLoaded>().where((s) => s.isRefreshing),
        isEmpty,
        reason: 'silent means no skeleton and no indicator',
      );
    });

    test('a failed same-scope refresh keeps the figures, not an error',
        () async {
      failing.seed(loaded());
      final emitted = <StatisticsState>[];
      final sub = failing.stream.listen(emitted.add);

      await failing.loadStatistics(silent: true);
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(emitted.whereType<StatisticsError>(), isEmpty,
          reason: 'a background failure must not replace shown figures');
      expect(failing.state, isA<StatisticsLoaded>());
      expect((failing.state as StatisticsLoaded).isRefreshing, isFalse);
    });

    test('a failed explicit refresh of the same scope also keeps them',
        () async {
      failing.seed(loaded());

      await failing.refresh();

      expect(failing.state, isA<StatisticsLoaded>());
      expect((failing.state as StatisticsLoaded).isRefreshing, isFalse,
          reason: 'the indicator stops; the figures stay');
    });

    test('an explicit same-scope refresh shows the indicator, then settles',
        () async {
      cubit.seed(loaded());
      final emitted = <StatisticsState>[];
      final sub = cubit.stream.listen(emitted.add);

      await cubit.refresh();
      await sub.cancel();

      expect(emitted.first, isA<StatisticsLoaded>());
      expect((emitted.first as StatisticsLoaded).isRefreshing, isTrue);
      expect(cubit.state, isA<StatisticsLoaded>());
      expect((cubit.state as StatisticsLoaded).isRefreshing, isFalse);
    });
  });

  group('scope switch', () {
    test('a failed load for a NEW scope surfaces the error', () async {
      failing.seed(loaded(source: StatisticsSource.both));
      final emitted = <StatisticsState>[];
      final sub = failing.stream.listen(emitted.add);

      failing.changeSource(StatisticsSource.lazervault);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await sub.cancel();

      expect(failing.isLoadedForCurrentScope(emitted.first), isFalse,
          reason: 'the first emit is the old scope flagged isRefreshing');
      expect(failing.state, isA<StatisticsError>(),
          reason: 'there are no figures for the new scope to fall back on');
    });
  });
}
