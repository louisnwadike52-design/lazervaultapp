// The Contactless landing's quick stats read 0 and its recent strip stayed
// empty until getMyContactlessPayments answered, on every open (a fresh cubit
// per screen). Now the remembered answer for this user and query shape paints
// first and the fetch replaces it in place.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/core/cache/session_page_user.dart';
import 'package:lazervault/src/features/contactless_payment/domain/entities/contactless_payment_entity.dart';
import 'package:lazervault/src/features/contactless_payment/domain/repositories/contactless_payment_repository.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/cubit/contactless_payment_cubit.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/cubit/contactless_payment_state.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/cubit/contactless_payments_page_store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Repo extends Mock implements ContactlessPaymentRepository {}

ContactlessTransactionEntity _tx(String id) => ContactlessTransactionEntity(
      id: id,
      sessionId: 's',
      payerId: 'p',
      payerUsername: 'p',
      payerName: 'P',
      payerAccountId: 'pa',
      receiverId: 'u1',
      receiverUsername: 'ada',
      receiverName: 'Ada',
      receiverAccountId: 'ra',
      amount: 12,
      currency: 'NGN',
      referenceNumber: 'r-$id',
      status: TransactionStatus.completed,
      createdAt: DateTime.utc(2026, 1, 1),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Repo repo;
  late ContactlessPaymentCubit cubit;
  final scope =
      ContactlessPaymentsPageStore.scope(limit: 5, offset: 0, roleFilter: null);

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
    ContactlessPaymentsPageStore.storeFor(scope).clear();
    sessionPageUserIdOverride = 'u1';
    repo = _Repo();
    cubit = ContactlessPaymentCubit(repository: repo);
  });

  tearDown(() {
    sessionPageUserIdOverride = null;
    return cubit.close();
  });

  test('the remembered page (rows + total) paints before the fetch answers',
      () async {
    ContactlessPaymentsPageStore.put('u1', scope,
        transactions: [_tx('old')], total: 9);
    final answer = Completer<
        ({List<ContactlessTransactionEntity> transactions, int total})>();
    when(() => repo.getMyContactlessPayments(
        limit: 5,
        offset: 0,
        roleFilter: null)).thenAnswer((_) => answer.future);

    final seen = <ContactlessPaymentState>[];
    final sub = cubit.stream.listen(seen.add);
    final load = cubit.getMyContactlessPayments(limit: 5);
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(seen.whereType<ContactlessPaymentLoading>(), isEmpty);
    final painted = cubit.state as ContactlessPaymentsLoaded;
    expect(painted.transactions.single.id, 'old');
    expect(painted.total, 9);

    answer.complete((transactions: [_tx('fresh')], total: 10));
    await load;
    final s = cubit.state as ContactlessPaymentsLoaded;
    expect(s.transactions.single.id, 'fresh');
    expect(s.total, 10);
    await sub.cancel();
  });

  test('a different query shape is never painted from this one', () async {
    ContactlessPaymentsPageStore.put('u1', scope,
        transactions: [_tx('old')], total: 9);
    when(() => repo.getMyContactlessPayments(
            limit: 20, offset: 0, roleFilter: null))
        .thenAnswer((_) async =>
            (transactions: <ContactlessTransactionEntity>[], total: 0));

    final seen = <ContactlessPaymentState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.getMyContactlessPayments();
    await Future<void>.delayed(Duration.zero); // stream delivery
    expect(seen.first, isA<ContactlessPaymentLoading>());
    await sub.cancel();
  });
}
