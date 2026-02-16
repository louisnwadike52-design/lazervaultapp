import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/qr_payment_entity.dart';
import '../../domain/entities/qr_transaction_entity.dart';
import '../../domain/repositories/qr_payment_repository.dart';
import 'qr_payment_state.dart';

class QRPaymentCubit extends Cubit<QRPaymentState> {
  final QRPaymentRepository repository;

  QRPaymentCubit({required this.repository}) : super(QRPaymentInitial());

  Future<void> generateQR({
    required double amount,
    required String currency,
    String? description,
    QRPaymentType qrType = QRPaymentType.dynamic,
    int? validityMinutes,
  }) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.generateQR(
      amount: amount,
      currency: currency,
      description: description,
      qrType: qrType,
      validityMinutes: validityMinutes,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (data) {
        final (qrCode, qrData) = data;
        emit(QRGenerated(qrCode: qrCode, qrData: qrData));
      },
    );
  }

  Future<void> getQRDetails({required String qrCode}) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.getQRDetails(qrCode: qrCode);

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (qr) => emit(QRDetailsLoaded(qrCode: qr)),
    );
  }

  Future<void> processQRPayment({
    required String qrCode,
    required String sourceAccountId,
    required double amount,
    required String transactionPin,
    String? idempotencyKey,
  }) async {
    if (isClosed) return;
    emit(QRPaymentProcessing());

    final result = await repository.processQRPayment(
      qrCode: qrCode,
      sourceAccountId: sourceAccountId,
      amount: amount,
      transactionPin: transactionPin,
      idempotencyKey: idempotencyKey,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (data) {
        final (transaction, newBalance) = data;
        emit(QRPaymentSuccess(
          transaction: transaction,
          newBalance: newBalance,
        ));
      },
    );
  }

  Future<void> getMyGeneratedQRCodes({
    int? limit,
    int? offset,
    QRPaymentStatus? statusFilter,
  }) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.getMyGeneratedQRCodes(
      limit: limit,
      offset: offset,
      statusFilter: statusFilter,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (qrCodes) => emit(GeneratedQRCodesLoaded(qrCodes: qrCodes)),
    );
  }

  Future<void> getMyQRPayments({int? limit, int? offset}) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.getMyQRPayments(
      limit: limit,
      offset: offset,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (transactions) => emit(QRPaymentsLoaded(transactions: transactions)),
    );
  }

  Future<void> cancelQR({required String qrId}) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.cancelQR(qrId: qrId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (_) {
        emit(QRCancelled(message: 'QR code cancelled successfully'));
        getMyGeneratedQRCodes();
      },
    );
  }

  Future<void> getTransactionReceipt({required String transactionId}) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.getQRTransactionReceipt(
      transactionId: transactionId,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (transaction) =>
          emit(QRTransactionReceiptLoaded(transaction: transaction)),
    );
  }

  Future<void> getRecentActivity() async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final results = await Future.wait([
      repository.getMyGeneratedQRCodes(limit: 3),
      repository.getMyQRPayments(limit: 3),
    ]);

    if (isClosed) return;

    final qrCodesResult = results[0] as Either<Failure, List<QRPaymentEntity>>;
    final paymentsResult =
        results[1] as Either<Failure, List<QRTransactionEntity>>;

    emit(QRRecentActivityLoaded(
      recentQRCodes: qrCodesResult.getOrElse(() => []),
      recentPayments: paymentsResult.getOrElse(() => []),
    ));
  }

  void reset() {
    if (isClosed) return;
    emit(QRPaymentInitial());
  }
}
