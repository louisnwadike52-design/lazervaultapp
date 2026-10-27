// Auto-Save rules: the cubit is a factory, so its own 5-minute cache was
// empty on every open and the screen shimmered. The page now outlives the
// cubit in `autoSaveRulesStore`: a fresh cubit paints it (through the
// screen's existing "warm refresh" branch), still fetches, and a failed
// fetch keeps the painted page rather than replacing it with an error.
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_user_id.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/create_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/delete_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_rules_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_statistics_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_transactions_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/toggle_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/trigger_autosave_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/update_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_rules_session_store.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';
import 'package:mocktail/mocktail.dart';

class _Repo extends Mock implements IAutoSaveRepository {}

class _Create extends Mock implements CreateAutoSaveRuleUseCase {}

class _GetRules extends Mock implements GetAutoSaveRulesUseCase {}

class _Update extends Mock implements UpdateAutoSaveRuleUseCase {}

class _Toggle extends Mock implements ToggleAutoSaveRuleUseCase {}

class _Delete extends Mock implements DeleteAutoSaveRuleUseCase {}

class _Txns extends Mock implements GetAutoSaveTransactionsUseCase {}

class _Stats extends Mock implements GetAutoSaveStatisticsUseCase {}

class _Trigger extends Mock implements TriggerAutoSaveUseCase {}

AutoSaveRuleEntity _rule(String id) => AutoSaveRuleEntity(
      id: id,
      userId: 'user-1',
      name: 'Rule $id',
      description: '',
      triggerType: TriggerType.scheduled,
      amountType: AmountType.fixed,
      amountValue: 10,
      sourceAccountId: 'a',
      destinationAccountId: 'b',
      status: AutoSaveStatus.active,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
      triggerCount: 0,
      totalSaved: 0,
    );

void main() {
  late _Repo repo;
  late _Stats stats;

  AutoSaveCubit build() => AutoSaveCubit(
        createAutoSaveRuleUseCase: _Create(),
        getAutoSaveRulesUseCase: _GetRules(),
        updateAutoSaveRuleUseCase: _Update(),
        toggleAutoSaveRuleUseCase: _Toggle(),
        deleteAutoSaveRuleUseCase: _Delete(),
        getAutoSaveTransactionsUseCase: _Txns(),
        getAutoSaveStatisticsUseCase: stats,
        triggerAutoSaveUseCase: _Trigger(),
        autoSaveRepository: repo,
      );

  void stubPage(Either<Failure, AutoSavePagedResult> answer) {
    when(() => repo.getAutoSaveRulesPaged(
          accountId: any(named: 'accountId'),
          status: any(named: 'status'),
          triggerType: any(named: 'triggerType'),
          search: any(named: 'search'),
          sort: any(named: 'sort'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenAnswer((_) async => answer);
  }

  setUpAll(() {
    registerFallbackValue(RuleSortOption.dateCreatedDesc);
    registerFallbackValue(AutoSaveStatus.active);
  });

  setUp(() {
    autoSaveRulesStore.clear();
    SessionUserId.resolverForTest = () => 'user-1';
    repo = _Repo();
    stats = _Stats();
    when(() => stats()).thenAnswer(
        (_) async => Left(ServerFailure(message: 'no stats', statusCode: 500)));
  });

  tearDown(() => SessionUserId.resolverForTest = null);

  final scope = autoSaveRulesScope(sort: RuleSortOption.dateCreatedDesc);

  test('first open: loading with nothing cached, then the page is stored',
      () async {
    stubPage(Right(
        AutoSavePagedResult(rules: [_rule('1')], total: 1, hasMore: false)));
    final c = build();
    final seen = <AutoSaveState>[];
    c.stream.listen(seen.add);
    await c.getRulesWithCache();
    await Future<void>.delayed(Duration.zero);

    final loading = seen.first as AutoSaveRulesLoadingState;
    expect(loading.cachedRules, isEmpty);
    expect(seen.last, isA<AutoSaveRulesLoadedState>());
    final snap = autoSaveRulesStore.peek(userId: 'user-1', scope: scope);
    expect(snap!.single.rules.single.id, '1');
  });

  test('a fresh cubit paints the stored page and still fetches', () async {
    autoSaveRulesStore.put(
      [
        AutoSaveRulesSnapshot(
            rules: [_rule('old')],
            statistics: null,
            hasMore: true,
            totalCount: 30),
      ],
      userId: 'user-1',
      scope: scope,
    );
    stubPage(Right(AutoSavePagedResult(
        rules: [_rule('fresh')], total: 1, hasMore: false)));
    final c = build();
    final seen = <AutoSaveState>[];
    c.stream.listen(seen.add);
    await c.getRulesWithCache();
    await Future<void>.delayed(Duration.zero);

    final painted = seen.first as AutoSaveRulesLoadingState;
    expect(painted.cachedRules.single.id, 'old',
        reason:
            'the screen paints a non-empty cachedRules list, not a shimmer');
    final last = seen.last as AutoSaveRulesLoadedState;
    expect(last.rules.single.id, 'fresh');
    verify(() => repo.getAutoSaveRulesPaged(
          accountId: any(named: 'accountId'),
          status: any(named: 'status'),
          triggerType: any(named: 'triggerType'),
          search: any(named: 'search'),
          sort: any(named: 'sort'),
          limit: 25,
          offset: 0,
        )).called(1);
  });

  test('a failed fetch behind a painted page keeps the page', () async {
    autoSaveRulesStore.put(
      [
        AutoSaveRulesSnapshot(
            rules: [_rule('kept')],
            statistics: null,
            hasMore: false,
            totalCount: 1),
      ],
      userId: 'user-1',
      scope: scope,
    );
    stubPage(Left(ServerFailure(message: 'boom', statusCode: 500)));
    final c = build();
    await c.getRulesWithCache();
    await Future<void>.delayed(Duration.zero);

    expect(c.state, isA<AutoSaveRulesLoadedState>());
    expect((c.state as AutoSaveRulesLoadedState).rules.single.id, 'kept');
  });

  test('another user or another filter scope gets nothing', () async {
    autoSaveRulesStore.put(
      [
        AutoSaveRulesSnapshot(
            rules: [_rule('mine')],
            statistics: null,
            hasMore: false,
            totalCount: 1),
      ],
      userId: 'user-1',
      scope: scope,
    );
    stubPage(
        Right(AutoSavePagedResult(rules: const [], total: 0, hasMore: false)));
    final c = build();
    final seen = <AutoSaveState>[];
    c.stream.listen(seen.add);
    await c.getRulesWithCache(filter: AutoSaveStatus.paused);
    await Future<void>.delayed(Duration.zero);
    expect((seen.first as AutoSaveRulesLoadingState).cachedRules, isEmpty);
  });
}
