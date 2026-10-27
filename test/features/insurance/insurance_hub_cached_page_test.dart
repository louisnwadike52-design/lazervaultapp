// The insurance hub must paint page one from the last open at once and fetch
// behind it; the loader is for a first load only, and a failed background
// refresh keeps the page on screen.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_entity.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_payment_entity.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_product_entity.dart';
import 'package:lazervault/src/features/insurance/domain/repositories/insurance_repository.dart';
import 'package:lazervault/src/features/insurance/presentation/cubit/insurance_cubit.dart';
import 'package:lazervault/src/features/insurance/presentation/cubit/insurance_hub_page_store.dart';
import 'package:lazervault/src/features/insurance/presentation/cubit/insurance_state.dart';

void main() {
  setUp(() => InsuranceHubPageStore.page1.clear());

  Future<void> tick() => Future<void>.delayed(Duration.zero);

  test('first load on a device shows the loader, then remembers the page',
      () async {
    final repo = _Repo(total: 1);
    final cubit = InsuranceCubit(repository: repo);
    final emitted = <InsuranceState>[];
    final sub = cubit.stream.listen(emitted.add);

    cubit.setUserId('u1');
    await tick();
    expect(emitted.single, isA<InsuranceLoading>());

    repo.gate.complete();
    await _settle();
    await sub.cancel();

    expect(emitted.last, isA<InsurancesLoaded>());
    expect(InsuranceHubPageStore.peek('u1')!.statistics['total'], 1);
    await cubit.close();
  });

  test('a new cubit for the same user paints the remembered page first',
      () async {
    final warm = _Repo(total: 1)..gate.complete();
    final first = InsuranceCubit(repository: warm)..setUserId('u1');
    await _settle();
    await first.close();

    final repo = _Repo(total: 2);
    final cubit = InsuranceCubit(repository: repo);
    final emitted = <InsuranceState>[];
    final sub = cubit.stream.listen(emitted.add);

    cubit.setUserId('u1');
    await tick();
    expect(emitted.single, isA<InsurancesLoaded>(),
        reason: 'the remembered page paints before the network answers');
    expect((emitted.single as InsurancesLoaded).statistics['total'], 1);
    expect(emitted.whereType<InsuranceLoading>(), isEmpty);

    repo.gate.complete();
    await _settle();
    await sub.cancel();
    expect((cubit.state as InsurancesLoaded).statistics['total'], 2,
        reason: 'the fresh page replaces the remembered one in place');
    await cubit.close();
  });

  test('a failed background refresh keeps the remembered page', () async {
    final warm = _Repo(total: 1)..gate.complete();
    final first = InsuranceCubit(repository: warm)..setUserId('u1');
    await _settle();
    await first.close();

    final repo = _Repo(total: 2, fail: true)..gate.complete();
    final cubit = InsuranceCubit(repository: repo)..setUserId('u1');
    await _settle();

    expect(cubit.state, isA<InsurancesLoaded>(),
        reason: 'an error screen must not replace shown policies');
    expect((cubit.state as InsurancesLoaded).statistics['total'], 1);
    await cubit.close();
  });

  test('another user never sees the remembered page', () async {
    final warm = _Repo(total: 1)..gate.complete();
    final first = InsuranceCubit(repository: warm)..setUserId('u1');
    await _settle();
    await first.close();

    final repo = _Repo(total: 3);
    final cubit = InsuranceCubit(repository: repo);
    final emitted = <InsuranceState>[];
    final sub = cubit.stream.listen(emitted.add);
    cubit.setUserId('u2');
    await tick();
    expect(emitted.single, isA<InsuranceLoading>());

    repo.gate.complete();
    await _settle();
    await sub.cancel();
    await cubit.close();
  });
}

Future<void> _settle() async {
  for (var i = 0; i < 10; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
}

/// Page one answers once [gate] opens; the companions answer at once.
class _Repo implements InsuranceRepository {
  _Repo({required this.total, this.fail = false});
  final int total;
  final bool fail;
  final Completer<void> gate = Completer<void>();

  @override
  Future<UserInsurancesPage> getUserInsurancesPage({
    required String userId,
    int page = 1,
    int limit = 15,
  }) async {
    await gate.future;
    if (fail) throw Exception('backend down');
    return UserInsurancesPage(
      insurances: const <Insurance>[],
      totalItems: total,
      currentPage: page,
      totalPages: 1,
      hasMore: false,
    );
  }

  @override
  Future<List<InsurancePayment>> getUserPayments(String userId) async => [];

  @override
  Future<List<InsurancePayment>> getOverduePayments(String userId) async => [];

  @override
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId) async =>
      {'total': total};

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not stubbed');
}
