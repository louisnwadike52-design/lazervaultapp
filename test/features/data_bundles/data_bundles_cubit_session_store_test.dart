// Data bundles: the landing "Recent Purchases" strip and the plan grid must
// paint what a previous open fetched (per user; plans per network) and
// refresh behind it; the loader is only for a first open.
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_user_id.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/data_bundles/domain/entities/data_plan_entity.dart';
import 'package:lazervault/src/features/data_bundles/domain/entities/data_purchase_entity.dart';
import 'package:lazervault/src/features/data_bundles/domain/repositories/data_bundles_repository.dart';
import 'package:lazervault/src/features/data_bundles/presentation/cubit/data_bundles_cubit.dart';
import 'package:lazervault/src/features/data_bundles/presentation/cubit/data_bundles_session_store.dart';
import 'package:lazervault/src/features/data_bundles/presentation/cubit/data_bundles_state.dart';
import 'package:mocktail/mocktail.dart';

class _Repo extends Mock implements DataBundlesRepository {}

DataPurchaseEntity _p(String id) => DataPurchaseEntity(
      id: id,
      userId: 'user-1',
      accountId: 'a',
      reference: 'ref-$id',
      amount: 500,
      status: 'success',
      phoneNumber: '0800',
      dataPlan: '1GB',
      newBalance: 0,
      commissionEarned: 0,
      providerReference: '',
      createdAt: '2026-01-01T00:00:00Z',
    );

DataPlanEntity _plan(String id) => DataPlanEntity(
      variationId: id,
      name: 'Plan $id',
      price: 100,
      network: 'mtn',
      availability: 'available',
    );

void main() {
  late _Repo repo;

  setUp(() {
    dataPurchasesStore.clear();
    dataPlansStore.clear();
    SessionUserId.resolverForTest = () => 'user-1';
    repo = _Repo();
  });

  tearDown(() => SessionUserId.resolverForTest = null);

  group('purchase history', () {
    test('first open: Loading, then stored', () async {
      when(() => repo.getPurchaseHistory(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer((_) async => Right([_p('1')]));
      final c = DataBundlesCubit(repository: repo);
      final seen = <DataBundlesState>[];
      c.stream.listen(seen.add);
      await c.loadDataPurchaseHistory();
      await Future<void>.delayed(Duration.zero);
      expect(seen.first, isA<DataPurchaseHistoryLoading>());
      expect(dataPurchasesStore.peek(userId: 'user-1'), hasLength(1));
    });

    test('re-open paints the stored page (isStale) then the fresh one',
        () async {
      dataPurchasesStore.put([_p('old')], userId: 'user-1');
      when(() => repo.getPurchaseHistory(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer((_) async => Right([_p('fresh')]));
      final c = DataBundlesCubit(repository: repo);
      final seen = <DataBundlesState>[];
      c.stream.listen(seen.add);
      await c.loadDataPurchaseHistory();
      await Future<void>.delayed(Duration.zero);
      expect(seen.whereType<DataPurchaseHistoryLoading>(), isEmpty);
      final first = seen.first as DataPurchaseHistoryLoaded;
      expect(first.purchases.single.id, 'old');
      expect(first.isStale, isTrue);
      final last = seen.last as DataPurchaseHistoryLoaded;
      expect(last.purchases.single.id, 'fresh');
      expect(last.isStale, isFalse);
    });

    test('a failed refresh keeps the painted page', () async {
      dataPurchasesStore.put([_p('kept')], userId: 'user-1');
      when(() => repo.getPurchaseHistory(
                limit: any(named: 'limit'),
                offset: any(named: 'offset'),
              ))
          .thenAnswer((_) async =>
              Left(ServerFailure(message: 'boom', statusCode: 500)));
      final c = DataBundlesCubit(repository: repo);
      await c.loadDataPurchaseHistory();
      await Future<void>.delayed(Duration.zero);
      expect(c.state, isA<DataPurchaseHistoryLoaded>());
    });
  });

  group('data plans', () {
    test('plans for a network paint at once on re-open; other network loads',
        () async {
      dataPlansStore.put([_plan('old')], userId: 'user-1', scope: 'mtn');
      when(() => repo.getDataPlans(network: any(named: 'network')))
          .thenAnswer((_) async => Right([_plan('fresh')]));

      final c = DataBundlesCubit(repository: repo);
      final seen = <DataBundlesState>[];
      c.stream.listen(seen.add);
      await c.getDataPlans(network: 'mtn');
      await Future<void>.delayed(Duration.zero);
      expect(seen.whereType<DataBundlesLoading>(), isEmpty);
      expect((seen.first as DataPlansLoaded).plans.single.variationId, 'old');
      expect((seen.last as DataPlansLoaded).plans.single.variationId, 'fresh');

      final c2 = DataBundlesCubit(repository: repo);
      final seen2 = <DataBundlesState>[];
      c2.stream.listen(seen2.add);
      await c2.getDataPlans(network: 'glo');
      await Future<void>.delayed(Duration.zero);
      expect(seen2.first, isA<DataBundlesLoading>());
    });
  });
}
