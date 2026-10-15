import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/features/escrow/domain/repositories/escrow_repository.dart';
import 'package:lazervault/src/features/escrow/presentation/cubit/escrow_cubit.dart';

/// EscrowPay's offers list loaded EVERYTHING in one call.
///
/// `listMyOffers` discarded the `total` the RPC has always returned, so the
/// screen could not know how many pages there were and never paged at all —
/// while the deals list beside it had numbered pages and a prefetch. Two
/// lists in one feature behaving differently is a difference the user has to
/// notice.
///
/// These run the real cubit against a repository that only records what was
/// asked of it, so the assertions are about the paging BEHAVIOUR rather than
/// about the source that implements it.

/// Records every paged call and answers with a synthetic page.
class _RecordingRepo implements EscrowRepository {
  _RecordingRepo({required this.total});
  final int total;
  final List<String> offerCalls = [];
  final List<String> dealCalls = [];

  @override
  Future<EscrowOffersPage> listMyOffersPaged({
    String role = '',
    String status = '',
    int page = 1,
    int limit = 5,
  }) async {
    offerCalls.add('$role|$status|$page|$limit');
    return EscrowOffersPage(
        items: const [], total: total, page: page, limit: limit);
  }

  @override
  Future<EscrowDealsPage> listMyDealsPaged({
    String role = '',
    String status = '',
    int page = 1,
    int limit = 5,
  }) async {
    dealCalls.add('$role|$status|$page|$limit');
    return EscrowDealsPage(
        items: const [], total: total, page: page, limit: limit);
  }

  // Everything else is unused by these tests.
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not stubbed');
}

class _FakeGrpc implements GrpcClient {
  @override
  Future<String?> getCurrentUserId() async => 'user-1';

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not stubbed');
}

void main() {
  EscrowCubit build(_RecordingRepo repo) =>
      EscrowCubit(repository: repo, grpcClient: _FakeGrpc());

  test('five rows per page, for deals AND offers', () {
    // A deal card is tall. Twenty of them is a long scroll with a pager at
    // the bottom nobody reaches — the cost of pagination without the benefit.
    expect(EscrowCubit.dealsPageSize, 5);
    expect(EscrowCubit.offersPageSize, 5);
    expect(EscrowCubit.offersPageSize, EscrowCubit.dealsPageSize,
        reason: 'two lists in one feature must not page differently');
  });

  test('the offers list asks for one page, not everything', () async {
    final repo = _RecordingRepo(total: 12);
    await build(repo).loadOffers();
    expect(repo.offerCalls.first, '||1|5');
  });

  test('a total of 12 at 5 a page is 3 pages', () async {
    final repo = _RecordingRepo(total: 12);
    final cubit = build(repo);
    await cubit.loadOffers();
    final state = cubit.state as EscrowOffersLoaded;
    expect(state.page, 1);
    expect(state.totalPages, 3);
  });

  test('an empty list is page 1 of 1, never "of 0"', () async {
    final repo = _RecordingRepo(total: 0);
    final cubit = build(repo);
    await cubit.loadOffers();
    final state = cubit.state as EscrowOffersLoaded;
    expect(state.totalPages, 1, reason: '"page 1 of 0" reads as a broken counter');
  });

  test('the next page is prefetched after the current one lands', () async {
    final repo = _RecordingRepo(total: 12);
    await build(repo).loadOffers();
    // Let the unawaited prefetch run.
    await Future<void>.delayed(Duration.zero);
    expect(repo.offerCalls, contains('||2|5'),
        reason: 'the page after the one on screen should already be warm');
  });

  test('the last page prefetches nothing', () async {
    final repo = _RecordingRepo(total: 12);
    await build(repo).loadOffers(page: 3);
    await Future<void>.delayed(Duration.zero);
    expect(repo.offerCalls.where((c) => c.endsWith('|4|5')), isEmpty,
        reason: 'there is no page 4 to warm');
  });

  test('a prefetched page is SERVED, not refetched', () async {
    final repo = _RecordingRepo(total: 12);
    final cubit = build(repo);
    await cubit.loadOffers();
    await Future<void>.delayed(Duration.zero);
    final before = repo.offerCalls.where((c) => c.contains('|2|')).length;
    await cubit.loadOffers(page: 2);
    final after = repo.offerCalls.where((c) => c.contains('|2|')).length;
    expect(after, before,
        reason: 'page 2 was already in hand; fetching it again wastes the '
            'prefetch entirely');
  });

  test('a filter change does NOT serve a page prefetched for another list',
      () async {
    // The bug that makes prefetching worse than not prefetching: showing one
    // filter's rows under another filter's heading.
    final repo = _RecordingRepo(total: 12);
    final cubit = build(repo);
    await cubit.loadOffers(); // warms ('', '', 2)
    await Future<void>.delayed(Duration.zero);
    await cubit.loadOffers(role: 'created', page: 2);
    expect(repo.offerCalls, contains('created||2|5'),
        reason: 'a different role is a different list and must be fetched');
  });

  test('changing page keeps the current list visible while it loads',
      () async {
    final repo = _RecordingRepo(total: 12);
    final cubit = build(repo);
    await cubit.loadOffers();
    final seen = <EscrowState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.loadOffers(page: 2);
    await sub.cancel();
    // The intermediate state must be the SAME list flagged loading, not a
    // shimmer — blanking a list the user is reading loses their place.
    expect(seen.first, isA<EscrowOffersLoaded>(),
        reason: 'a page change must not fall back to the full-screen shimmer');
    expect((seen.first as EscrowOffersLoaded).pageLoading, isTrue);
  });

  test('a first load does show the shimmer', () async {
    final repo = _RecordingRepo(total: 12);
    final cubit = build(repo);
    final seen = <EscrowState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.loadOffers();
    await sub.cancel();
    expect(seen.first, isA<EscrowLoading>(),
        reason: 'there is nothing on screen to keep');
  });

  test('page arithmetic has no off-by-one', () {
    // A wrong total renders a page that does not exist, and tapping it shows
    // an empty list that looks like lost data.
    for (final (total, pages) in [(0, 1), (1, 1), (5, 1), (6, 2), (10, 2), (11, 3)]) {
      expect(
          EscrowOffersPage(items: const [], total: total, page: 1, limit: 5)
              .totalPages,
          pages,
          reason: 'total=$total');
    }
  });
}
