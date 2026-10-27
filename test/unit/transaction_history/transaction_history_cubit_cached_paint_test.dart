// Transaction history: a cache hit must paint the cached page at once with
// NO loading state in front of it, then converge to the network in the
// background; the spinner is only for an empty cache.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:mocktail/mocktail.dart';

class _Repo extends Mock implements TransactionHistoryRepository {}

UnifiedTransaction _tx(String id) => UnifiedTransaction(
      id: id,
      serviceType: TransactionServiceType.airtime,
      title: 'T $id',
      amount: 100,
      currency: 'NGN',
      createdAt: DateTime(2026, 1, 1),
      status: UnifiedTransactionStatus.completed,
      flow: TransactionFlow.outgoing,
    );

TransactionListResponse _resp(List<UnifiedTransaction> rows,
        {bool fromCache = false}) =>
    TransactionListResponse(
      transactions: rows,
      hasMore: false,
      currentPage: 1,
      totalPages: 1,
      fromCache: fromCache,
    );

void main() {
  late _Repo repo;

  setUpAll(() {
    registerFallbackValue(const TransactionFilters());
  });

  setUp(() {
    repo = _Repo();
    when(() => repo.refreshTransactions()).thenAnswer((_) async {});
    when(() => repo.getStatistics(
          serviceType: any(named: 'serviceType'),
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
        )).thenThrow(Exception('no stats'));
  });

  test('cache hit: Loaded first, never Loading; network lands behind',
      () async {
    when(() => repo.peekCachedAllTransactions(
          limit: any(named: 'limit'),
          filters: any(named: 'filters'),
        )).thenAnswer((_) async => _resp([_tx('cached')], fromCache: true));
    when(() => repo.fetchAllTransactions(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          cursor: any(named: 'cursor'),
          filters: any(named: 'filters'),
        )).thenAnswer((_) async => _resp([_tx('fresh')]));

    final c = TransactionHistoryCubit(repository: repo);
    final seen = <TransactionHistoryState>[];
    c.stream.listen(seen.add);
    await c.loadAllTransactions();
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(seen.whereType<TransactionHistoryLoading>(), isEmpty);
    expect((seen.first as TransactionHistoryLoaded).transactions.single.id,
        'cached');
    expect((seen.last as TransactionHistoryLoaded).transactions.single.id,
        'fresh');
    verify(() => repo.refreshTransactions()).called(1);
  });

  test('empty cache: Loading first, as before', () async {
    when(() => repo.peekCachedAllTransactions(
          limit: any(named: 'limit'),
          filters: any(named: 'filters'),
        )).thenAnswer((_) async => null);
    when(() => repo.fetchAllTransactions(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          cursor: any(named: 'cursor'),
          filters: any(named: 'filters'),
        )).thenAnswer((_) async => _resp([_tx('fresh')]));

    final c = TransactionHistoryCubit(repository: repo);
    final seen = <TransactionHistoryState>[];
    c.stream.listen(seen.add);
    await c.loadAllTransactions();
    await Future<void>.delayed(Duration.zero);

    expect(seen.first, isA<TransactionHistoryLoading>());
    expect(seen.last, isA<TransactionHistoryLoaded>());
  });

  test('a failed background refresh keeps the cached page on screen', () async {
    when(() => repo.peekCachedAllTransactions(
          limit: any(named: 'limit'),
          filters: any(named: 'filters'),
        )).thenAnswer((_) async => _resp([_tx('cached')], fromCache: true));
    when(() => repo.fetchAllTransactions(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          cursor: any(named: 'cursor'),
          filters: any(named: 'filters'),
        )).thenThrow(Exception('offline'));

    final c = TransactionHistoryCubit(repository: repo);
    await c.loadAllTransactions();
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(c.state, isA<TransactionHistoryLoaded>());
    expect(
        (c.state as TransactionHistoryLoaded).transactions.single.id, 'cached');
  });
}
