// The QR Pay landing's history section showed a loader on every open and on
// every return from a sub-screen (factory cubit, no cache). Now the remembered
// activity paints first, the fetch runs behind it, and a failed call keeps
// whichever list was on screen.
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/core/cache/session_page_user.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_payment_entity.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_transaction_entity.dart';
import 'package:lazervault/src/features/qr_payment/domain/repositories/qr_payment_repository.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_state.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_recent_activity_store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Repo extends Mock implements QRPaymentRepository {}

class _Failure extends Failure {
  _Failure() : super(message: 'down', statusCode: 500);
}

QRPaymentEntity _code(String id) => QRPaymentEntity(
      id: id,
      userId: 'u1',
      username: 'ada',
      fullName: 'Ada',
      qrCode: 'qr-$id',
      amount: 10,
      currency: 'NGN',
      description: '',
      qrType: QRPaymentType.static,
      status: QRPaymentStatus.pending,
      createdAt: DateTime.utc(2026, 1, 1),
    );

QRTransactionEntity _payment(String id) => QRTransactionEntity(
      id: id,
      qrId: 'q',
      payerId: 'p',
      payerUsername: 'p',
      payerName: 'P',
      recipientId: 'u1',
      recipientUsername: 'ada',
      recipientName: 'Ada',
      amount: 5,
      currency: 'NGN',
      description: '',
      referenceNumber: 'r-$id',
      status: QRTransactionStatus.completed,
      createdAt: DateTime.utc(2026, 1, 2),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Repo repo;
  late QRPaymentCubit cubit;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
    QRRecentActivityStore.codes.clear();
    QRRecentActivityStore.payments.clear();
    sessionPageUserIdOverride = 'u1';
    repo = _Repo();
    cubit = QRPaymentCubit(repository: repo);
  });

  tearDown(() {
    sessionPageUserIdOverride = null;
    return cubit.close();
  });

  test('remembered activity paints before the fetch answers', () async {
    QRRecentActivityStore.codes.put([_code('old')], userId: 'u1');
    QRRecentActivityStore.payments.put([_payment('old')], userId: 'u1');
    final codes = Completer<Either<Failure, List<QRPaymentEntity>>>();
    when(() => repo.getMyGeneratedQRCodes(limit: 3))
        .thenAnswer((_) => codes.future);
    when(() => repo.getMyQRPayments(limit: 3))
        .thenAnswer((_) async => Right([_payment('fresh')]));

    final seen = <QRPaymentState>[];
    final sub = cubit.stream.listen(seen.add);
    final load = cubit.getRecentActivity();
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(seen.whereType<QRPaymentLoading>(), isEmpty);
    expect(
        (cubit.state as QRRecentActivityLoaded).recentQRCodes.single.id, 'old');

    codes.complete(Right([_code('fresh')]));
    await load;
    final s = cubit.state as QRRecentActivityLoaded;
    expect(s.recentQRCodes.single.id, 'fresh');
    expect(s.recentPayments.single.id, 'fresh');
    expect(QRRecentActivityStore.codes.peek(userId: 'u1')!.single.id, 'fresh');
    await sub.cancel();
  });

  test('a failed call keeps the list that was on screen', () async {
    QRRecentActivityStore.codes.put([_code('old')], userId: 'u1');
    QRRecentActivityStore.payments.put([_payment('old')], userId: 'u1');
    when(() => repo.getMyGeneratedQRCodes(limit: 3))
        .thenAnswer((_) async => Left(_Failure()));
    when(() => repo.getMyQRPayments(limit: 3))
        .thenAnswer((_) async => Right([_payment('fresh')]));

    await cubit.getRecentActivity();

    final s = cubit.state as QRRecentActivityLoaded;
    expect(s.recentQRCodes.single.id, 'old');
    expect(s.recentPayments.single.id, 'fresh');
  });

  test('nothing remembered: the section loader shows first', () async {
    when(() => repo.getMyGeneratedQRCodes(limit: 3))
        .thenAnswer((_) async => const Right([]));
    when(() => repo.getMyQRPayments(limit: 3))
        .thenAnswer((_) async => const Right([]));
    final seen = <QRPaymentState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.getRecentActivity();
    await Future<void>.delayed(Duration.zero); // stream delivery
    expect(seen.first, isA<QRPaymentLoading>());
    expect(cubit.state, isA<QRRecentActivityLoaded>());
    await sub.cancel();
  });
}
