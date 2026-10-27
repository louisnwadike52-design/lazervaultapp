// The Budgets list loaded only from the builder's Initial fall-through, behind
// a full loading view, and never paged. Now the remembered first page paints
// first, a retained list refreshes silently, a failed refresh keeps the rows,
// and the next page appends on demand.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/core/cache/session_page_user.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_page_store.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/statistics/data/budget_ai_service.dart';
import 'package:lazervault/src/features/statistics/data/budget_repository.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Repo extends Mock implements BudgetRepository {}

class _Ai extends Mock implements BudgetAIService {}

pb.BudgetMessage _budget(String id) => pb.BudgetMessage()
  ..id = id
  ..name = 'Budget $id'
  ..amount = 100;

pb.GetBudgetsResponse _page(List<String> ids, {required bool hasNext}) =>
    pb.GetBudgetsResponse()
      ..budgets.addAll(ids.map(_budget))
      ..totalBudgetAmount = 100.0 * ids.length
      ..totalSpentAmount = 10
      ..pagination = (pb.PaginationMetadata()..hasNext = hasNext);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Repo repo;
  late BudgetCubit cubit;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
    BudgetPageStore.store.clear();
    sessionPageUserIdOverride = 'u1';
    repo = _Repo();
    cubit = BudgetCubit(budgetRepository: repo, budgetAIService: _Ai());
  });

  tearDown(() {
    sessionPageUserIdOverride = null;
    return cubit.close();
  });

  test('the remembered first page paints before the fetch answers', () async {
    BudgetPageStore.put('u1',
        budgets: [_budget('old')], totalBudgetAmount: 100, totalSpentAmount: 1);
    final answer = Completer<pb.GetBudgetsResponse>();
    when(() => repo.getBudgets(
          page: 1,
          perPage: 20,
          status: null,
          category: null,
        )).thenAnswer((_) => answer.future);

    final seen = <BudgetState>[];
    final sub = cubit.stream.listen(seen.add);
    final load = cubit.loadBudgets();
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(seen.whereType<BudgetLoading>(), isEmpty);
    final painted = cubit.state as BudgetsLoaded;
    expect(painted.budgets.single.id, 'old');
    expect(painted.isRefreshing, isTrue);

    answer.complete(_page(['a', 'b'], hasNext: true));
    await load;
    final s = cubit.state as BudgetsLoaded;
    expect(s.budgets.map((b) => b.id), ['a', 'b']);
    expect(s.isRefreshing, isFalse);
    expect(s.hasMore, isTrue);
    expect(BudgetPageStore.peek('u1')!.budgets.length, 2);
    await sub.cancel();
  });

  test('a retained list refreshes silently and survives a failed refresh',
      () async {
    when(() => repo.getBudgets(
          page: 1,
          perPage: 20,
          status: null,
          category: null,
        )).thenAnswer((_) async => _page(['a'], hasNext: false));
    await cubit.loadBudgets();
    expect(cubit.state, isA<BudgetsLoaded>());

    when(() => repo.getBudgets(
          page: 1,
          perPage: 20,
          status: null,
          category: null,
        )).thenThrow(Exception('down'));
    final seen = <BudgetState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.loadBudgets();
    await Future<void>.delayed(Duration.zero); // stream delivery

    expect(seen.whereType<BudgetLoading>(), isEmpty);
    expect(seen.whereType<BudgetError>(), isEmpty);
    expect((cubit.state as BudgetsLoaded).budgets.single.id, 'a');
    await sub.cancel();
  });

  test('a retained list belonging to ANOTHER user is never painted', () async {
    // BudgetCubit is a lazy SINGLETON, so its state outlives the session that
    // filled it, and loadBudgets now paints that state instead of a loader.
    // Without a user check, the next person to sign in on the device would be
    // looking at the previous user's budget AMOUNTS until their fetch landed.
    when(() => repo.getBudgets(
          page: 1,
          perPage: 20,
          status: null,
          category: null,
        )).thenAnswer((_) async => _page(['u1-budget'], hasNext: false));
    await cubit.loadBudgets();
    expect((cubit.state as BudgetsLoaded).budgets.single.id, 'u1-budget');

    // Someone else signs in — no logout, so nothing reset the cubit.
    sessionPageUserIdOverride = 'u2';
    final answer = Completer<pb.GetBudgetsResponse>();
    when(() => repo.getBudgets(
          page: 1,
          perPage: 20,
          status: null,
          category: null,
        )).thenAnswer((_) => answer.future);

    final seen = <BudgetState>[];
    final sub = cubit.stream.listen(seen.add);
    final load = cubit.loadBudgets();
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(seen.whereType<BudgetsLoaded>(), isEmpty,
        reason: "u1's budgets must never be painted for u2");
    expect(cubit.state, isA<BudgetLoading>());

    answer.complete(_page(['u2-budget'], hasNext: false));
    await load;
    expect((cubit.state as BudgetsLoaded).budgets.single.id, 'u2-budget');
    await sub.cancel();
  });

  test('an UNKNOWN user id keeps the retained list (it is not a mismatch)',
      () async {
    when(() => repo.getBudgets(
          page: 1,
          perPage: 20,
          status: null,
          category: null,
        )).thenAnswer((_) async => _page(['a'], hasNext: false));
    await cubit.loadBudgets();

    // '' means "the locator is not up yet", not "a different person" —
    // acting on it would throw away a good list for the user still signed in.
    sessionPageUserIdOverride = '';
    final seen = <BudgetState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.loadBudgets();
    await Future<void>.delayed(Duration.zero);
    expect(seen.whereType<BudgetLoading>(), isEmpty);
    expect((cubit.state as BudgetsLoaded).budgets.single.id, 'a');
    await sub.cancel();
  });

  test('loadMoreBudgets appends the next page and stops at the end', () async {
    when(() => repo.getBudgets(
          page: 1,
          perPage: 20,
          status: null,
          category: null,
        )).thenAnswer((_) async => _page(['a'], hasNext: true));
    when(() => repo.getBudgets(page: 2, perPage: 20))
        .thenAnswer((_) async => _page(['b', 'a'], hasNext: false));
    await cubit.loadBudgets();

    await cubit.loadMoreBudgets();
    final s = cubit.state as BudgetsLoaded;
    expect(s.budgets.map((b) => b.id), ['a', 'b']); // de-duplicated append
    expect(s.page, 2);
    expect(s.hasMore, isFalse);
    expect(s.isLoadingMore, isFalse);

    // Nothing more to fetch: a further call is a no-op.
    await cubit.loadMoreBudgets();
    verifyNever(() => repo.getBudgets(page: 3, perPage: 20));
  });
}
