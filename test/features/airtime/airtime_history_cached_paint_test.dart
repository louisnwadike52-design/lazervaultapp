// The airtime landing's "Recent Transactions" strip showed its loading row on
// every open because loadTransactionHistory had no cache. Now the remembered
// page paints first, the fetch runs behind it, and a failed refresh keeps the
// painted rows instead of swapping in an error.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/airtime/domain/entities/airtime_transaction.dart';
import 'package:lazervault/src/features/airtime/domain/entities/network_provider.dart';
import 'package:lazervault/src/features/airtime/domain/repositories/airtime_repository.dart';
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_cubit.dart';
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_history_page_store.dart';
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Repo extends Mock implements AirtimeRepository {}

class _Storage extends Mock implements SecureStorageService {}

AirtimeTransaction _tx(String id) => AirtimeTransaction(
      id: id,
      transactionReference: 'ref-$id',
      networkProvider: NetworkProviderType.mtn,
      recipientPhoneNumber: '08012345678',
      amount: 500,
      currency: 'NGN',
      status: AirtimeTransactionStatus.completed,
      createdAt: DateTime.utc(2026, 1, 1),
      userId: 'u1',
      totalAmount: 500,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Repo repo;
  late AirtimeCubit cubit;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
    AirtimeHistoryPageStore.transactions.clear();
    AirtimeHistoryPageStore.statistics.clear();
    repo = _Repo();
    cubit = AirtimeCubit(repository: repo, secureStorage: _Storage());
  });

  tearDown(() => cubit.close());

  test('remembered history paints first; the fetch replaces it in place',
      () async {
    AirtimeHistoryPageStore.put('u1',
        transactions: [_tx('old')], statistics: {'totalTransactions': 1});
    final history = Completer<List<AirtimeTransaction>>();
    when(() => repo.getTransactionHistory('u1'))
        .thenAnswer((_) => history.future);
    when(() => repo.getAirtimeStatistics('u1'))
        .thenAnswer((_) async => {'totalTransactions': 2});

    final seen = <AirtimeState>[];
    final sub = cubit.stream.listen(seen.add);
    final load = cubit.loadTransactionHistory('u1');
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(seen.whereType<AirtimeTransactionHistoryLoading>(), isEmpty);
    expect(cubit.state, isA<AirtimeTransactionHistoryLoaded>());
    expect(
        (cubit.state as AirtimeTransactionHistoryLoaded).transactions.single.id,
        'old');

    history.complete([_tx('fresh'), _tx('fresh2')]);
    await load;
    final s = cubit.state as AirtimeTransactionHistoryLoaded;
    expect(s.transactions.map((t) => t.id), ['fresh', 'fresh2']);
    expect(s.statistics!['totalTransactions'], 2);
    expect(AirtimeHistoryPageStore.transactions.peek(userId: 'u1')!.length, 2);
    await sub.cancel();
  });

  test('a refresh that fails behind painted rows keeps them', () async {
    AirtimeHistoryPageStore.put('u1',
        transactions: [_tx('old')], statistics: null);
    when(() => repo.getTransactionHistory('u1')).thenThrow(Exception('down'));
    when(() => repo.getAirtimeStatistics('u1')).thenThrow(Exception('down'));

    await cubit.loadTransactionHistory('u1');

    expect(cubit.state, isA<AirtimeTransactionHistoryLoaded>());
    expect(
        (cubit.state as AirtimeTransactionHistoryLoaded).transactions.single.id,
        'old');
  });

  test('nothing remembered: the loading row shows, then the error', () async {
    when(() => repo.getTransactionHistory('u1')).thenThrow(Exception('down'));
    when(() => repo.getAirtimeStatistics('u1')).thenThrow(Exception('down'));
    final seen = <AirtimeState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.loadTransactionHistory('u1');
    await Future<void>.delayed(Duration.zero); // stream delivery
    expect(seen.first, isA<AirtimeTransactionHistoryLoading>());
    expect(cubit.state, isA<AirtimeError>());
    await sub.cancel();
  });
}
