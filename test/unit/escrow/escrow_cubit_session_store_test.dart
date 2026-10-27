// Escrow Pay home: page one of each (role, status) list must paint at once
// on re-open (no shimmer) and refresh behind; a page turn is unchanged.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_user_id.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/features/escrow/domain/entities/escrow_deal_entity.dart';
import 'package:lazervault/src/features/escrow/domain/repositories/escrow_repository.dart';
import 'package:lazervault/src/features/escrow/presentation/cubit/escrow_cubit.dart';
import 'package:lazervault/src/features/escrow/presentation/cubit/escrow_session_store.dart';
import 'package:mocktail/mocktail.dart';

class _Repo extends Mock implements EscrowRepository {}

class _Grpc extends Mock implements GrpcClient {}

EscrowDealEntity _deal(String id) => EscrowDealEntity(
      id: id,
      reference: 'ESC-$id',
      buyerUserId: 'user-1',
      buyerAccountId: 'a',
      buyerName: 'Me',
      sellerUserId: 'u2',
      sellerAccountId: 'b',
      sellerName: 'Them',
      title: 'Deal $id',
      description: '',
      currency: 'NGN',
      amount: 1000,
      fee: 10,
      feePayer: 'buyer',
      buyerTotal: 1010,
      sellerNet: 1000,
      status: 'FUNDED',
      fraudScore: 0,
      requiresAdminReview: false,
      deliveryNote: '',
    );

EscrowDealsPage _page(List<EscrowDealEntity> items, {int page = 1}) =>
    EscrowDealsPage(items: items, total: items.length, page: page, limit: 5);

void main() {
  late _Repo repo;
  late _Grpc grpc;

  setUp(() {
    escrowDealsPageStore.clear();
    SessionUserId.resolverForTest = () => 'user-1';
    repo = _Repo();
    grpc = _Grpc();
    when(() => grpc.getCurrentUserId()).thenAnswer((_) async => 'user-1');
  });

  tearDown(() => SessionUserId.resolverForTest = null);

  void stubDeals(Future<EscrowDealsPage> Function() answer) {
    when(() => repo.listMyDealsPaged(
          role: any(named: 'role'),
          status: any(named: 'status'),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        )).thenAnswer((_) => answer());
  }

  test('first open shimmers, then page one is stored for the scope', () async {
    stubDeals(() async => _page([_deal('1')]));
    final c = EscrowCubit(repository: repo, grpcClient: grpc);
    final seen = <EscrowState>[];
    c.stream.listen(seen.add);
    await c.loadDeals(role: 'buyer');
    await Future<void>.delayed(Duration.zero);

    expect(seen.first, isA<EscrowLoading>());
    expect(seen.last, isA<EscrowDealsLoaded>());
    final stored = escrowDealsPageStore.peek(
        userId: 'user-1', scope: escrowDealsScope('buyer', ''));
    expect(stored!.single.items.single.id, '1');
  });

  test('re-open paints the stored page one, no shimmer, then refreshes',
      () async {
    escrowDealsPageStore.put([
      _page([_deal('old')])
    ], userId: 'user-1', scope: escrowDealsScope('', ''));
    stubDeals(() async => _page([_deal('fresh')]));
    final c = EscrowCubit(repository: repo, grpcClient: grpc);
    final seen = <EscrowState>[];
    c.stream.listen(seen.add);
    await c.loadDeals();
    await Future<void>.delayed(Duration.zero);

    expect(seen.whereType<EscrowLoading>(), isEmpty);
    expect((seen.first as EscrowDealsLoaded).deals.single.id, 'old');
    expect((seen.first as EscrowDealsLoaded).currentUserId, 'user-1');
    expect((seen.last as EscrowDealsLoaded).deals.single.id, 'fresh');
  });

  test('a failed refresh behind a painted page keeps the page', () async {
    escrowDealsPageStore.put([
      _page([_deal('kept')])
    ], userId: 'user-1', scope: escrowDealsScope('', ''));
    stubDeals(() async => throw Exception('offline'));
    final c = EscrowCubit(repository: repo, grpcClient: grpc);
    await c.loadDeals();
    await Future<void>.delayed(Duration.zero);
    expect(c.state, isA<EscrowDealsLoaded>());
    expect((c.state as EscrowDealsLoaded).deals.single.id, 'kept');
  });

  test('a different (role, status) scope or page 2 is not painted', () async {
    escrowDealsPageStore.put([
      _page([_deal('all')])
    ], userId: 'user-1', scope: escrowDealsScope('', ''));
    stubDeals(() async => _page([_deal('x')], page: 2));
    final c = EscrowCubit(repository: repo, grpcClient: grpc);
    final seen = <EscrowState>[];
    c.stream.listen(seen.add);
    await c.loadDeals(role: 'seller');
    await Future<void>.delayed(Duration.zero);
    expect(seen.first, isA<EscrowLoading>());

    // Page 2 of the "all" list: page one is stored but must not be painted.
    final c2 = EscrowCubit(repository: repo, grpcClient: grpc);
    final seen2 = <EscrowState>[];
    c2.stream.listen(seen2.add);
    await c2.loadDeals(page: 2);
    await Future<void>.delayed(Duration.zero);
    expect(seen2.first, isA<EscrowLoading>());
  });
}
