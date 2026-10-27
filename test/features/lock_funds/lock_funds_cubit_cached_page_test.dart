// The lock-funds list must paint the last answer (list + statistics) at once
// on re-open and refresh behind it; a reload over data already on screen
// (WS event, returning from a detail) never flashes the loader.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';
import 'package:lazervault/src/features/lock_funds/domain/repositories/lock_funds_repository.dart';
import 'package:lazervault/src/features/lock_funds/presentation/cubit/lock_funds_cubit.dart';
import 'package:lazervault/src/features/lock_funds/presentation/cubit/lock_funds_page_store.dart';
import 'package:lazervault/src/features/lock_funds/presentation/cubit/lock_funds_state.dart';

class _Repo extends Mock implements LockFundsRepository {}

void main() {
  late _Repo repo;

  LockFundsStatistics stats(int total) => LockFundsStatistics(
        totalLockedAmount: 100,
        totalAccruedInterest: 1,
        activeLocksCount: total,
        totalCount: total,
      );

  void stubOk(int total) {
    when(() => repo.getLockFunds(status: any(named: 'status')))
        .thenAnswer((_) async => <LockFund>[]);
    when(() => repo.getStatistics()).thenAnswer((_) async => stats(total));
  }

  setUp(() {
    repo = _Repo();
    LockFundsPageStore.list.clear();
    LockFundsPageStore.statistics.clear();
  });

  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 20));

  test('first load shows the loader, then remembers list + statistics',
      () async {
    stubOk(1);
    final cubit = LockFundsCubit(repo);
    final emitted = <LockFundsState>[];
    final sub = cubit.stream.listen(emitted.add);

    cubit.setUserId('u1');
    await settle();
    await sub.cancel();

    expect(emitted.first, isA<LockFundsLoading>());
    expect(emitted.last, isA<LockFundsLoaded>());
    expect(LockFundsPageStore.peek(userId: 'u1')!.statistics['totalCount'], 1);
    await cubit.close();
  });

  test('a new cubit for the same user paints the remembered answer first',
      () async {
    stubOk(1);
    final first = LockFundsCubit(repo)..setUserId('u1');
    await settle();
    await first.close();

    stubOk(2);
    final cubit = LockFundsCubit(repo);
    final emitted = <LockFundsState>[];
    final sub = cubit.stream.listen(emitted.add);
    cubit.setUserId('u1');
    // Synchronous: the remembered state is emitted before the first await.
    expect(cubit.state, isA<LockFundsLoaded>());
    expect((cubit.state as LockFundsLoaded).statistics['totalCount'], 1);

    await settle();
    await sub.cancel();
    expect(emitted.whereType<LockFundsLoading>(), isEmpty);
    expect((cubit.state as LockFundsLoaded).statistics['totalCount'], 2,
        reason: 'the fresh answer replaces the remembered one in place');
    await cubit.close();
  });

  test('a reload over data on screen is silent', () async {
    stubOk(1);
    final cubit = LockFundsCubit(repo)..setUserId('u1');
    await settle();
    final emitted = <LockFundsState>[];
    final sub = cubit.stream.listen(emitted.add);

    stubOk(2);
    await cubit.loadLockFunds(); // what the WS lifecycle listener does
    await settle();
    await sub.cancel();

    expect(emitted.whereType<LockFundsLoading>(), isEmpty);
    expect(emitted.single, isA<LockFundsLoaded>());
    expect((emitted.single as LockFundsLoaded).statistics['totalCount'], 2);
    await cubit.close();
  });

  test('a failed refresh keeps the remembered answer for the next paint',
      () async {
    stubOk(1);
    final first = LockFundsCubit(repo)..setUserId('u1');
    await settle();
    await first.close();

    when(() => repo.getLockFunds(status: any(named: 'status')))
        .thenThrow(Exception('backend down'));
    final cubit = LockFundsCubit(repo);
    final emitted = <LockFundsState>[];
    final sub = cubit.stream.listen(emitted.add);
    cubit.setUserId('u1');
    await settle();
    await sub.cancel();

    expect(emitted.first, isA<LockFundsLoaded>(),
        reason: 'painted from the store before the failing fetch');
    expect(emitted.whereType<LockFundsLoading>(), isEmpty);
    // The error is still reported (the screen shows a snackbar over the
    // list it keeps), and the remembered answer survives for the next open.
    expect(emitted.last, isA<LockFundsError>());
    expect(LockFundsPageStore.peek(userId: 'u1'), isNotNull);
    await cubit.close();
  });

  test('another user never sees the remembered answer', () async {
    stubOk(1);
    final first = LockFundsCubit(repo)..setUserId('u1');
    await settle();
    await first.close();

    final cubit = LockFundsCubit(repo);
    final emitted = <LockFundsState>[];
    final sub = cubit.stream.listen(emitted.add);
    cubit.setUserId('u2');
    expect(cubit.state, isA<LockFundsLoading>());
    await settle();
    await sub.cancel();
    await cubit.close();
  });
}
