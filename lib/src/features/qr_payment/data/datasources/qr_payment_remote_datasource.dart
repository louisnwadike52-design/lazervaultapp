import '../../../../generated/qr_pay.pbgrpc.dart' as pb;
import '../../../../core/network/grpc_client.dart';
import '../../domain/entities/qr_payment_entity.dart';
import '../models/qr_payment_model.dart';
import '../models/qr_transaction_model.dart';

abstract class QRPaymentRemoteDataSource {
  Future<(QRPaymentModel, String)> generateQR({
    required double amount,
    required String currency,
    String? description,
    QRPaymentType qrType,
    int? validityMinutes,
  });

  Future<QRPaymentModel> getQRDetails({
    required String qrCode,
  });

  Future<(QRTransactionModel, double)> processQRPayment({
    required String qrCode,
    required String sourceAccountId,
    required double amount,
    required String transactionPin,
    String? idempotencyKey,
  });

  Future<List<QRPaymentModel>> getMyGeneratedQRCodes({
    int? limit,
    int? offset,
    QRPaymentStatus? statusFilter,
  });

  Future<List<QRTransactionModel>> getMyQRPayments({
    int? limit,
    int? offset,
  });

  Future<void> cancelQR({
    required String qrId,
  });

  Future<QRTransactionModel> getQRTransactionReceipt({
    required String transactionId,
  });
}

class QRPaymentRemoteDataSourceImpl implements QRPaymentRemoteDataSource {
  final GrpcClient grpcClient;

  QRPaymentRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<(QRPaymentModel, String)> generateQR({
    required double amount,
    required String currency,
    String? description,
    QRPaymentType qrType = QRPaymentType.dynamic,
    int? validityMinutes,
  }) async {
    final request = pb.GenerateQRRequest()
      ..amount = amount
      ..currency = currency
      ..description = description ?? ''
      ..qrType = qrType == QRPaymentType.static
          ? pb.QRType.QR_TYPE_STATIC
          : pb.QRType.QR_TYPE_DYNAMIC
      ..validityMinutes = validityMinutes ?? 30;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.qrPayClient.generateQR(
      request,
      options: options,
    );

    return (
      QRPaymentModel.fromProto(response.qrCode),
      response.qrData,
    );
  }

  @override
  Future<QRPaymentModel> getQRDetails({
    required String qrCode,
  }) async {
    final request = pb.GetQRDetailsRequest()..qrCode = qrCode;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.qrPayClient.getQRDetails(
      request,
      options: options,
    );
    return QRPaymentModel.fromProto(response.qrCode);
  }

  @override
  Future<(QRTransactionModel, double)> processQRPayment({
    required String qrCode,
    required String sourceAccountId,
    required double amount,
    required String transactionPin,
    String? idempotencyKey,
  }) async {
    final request = pb.ProcessQRPaymentRequest()
      ..qrCode = qrCode
      ..sourceAccountId = sourceAccountId
      ..amount = amount
      ..transactionPin = transactionPin;

    if (idempotencyKey != null) {
      request.idempotencyKey = idempotencyKey;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.qrPayClient.processQRPayment(
      request,
      options: options,
    );

    return (
      QRTransactionModel.fromProto(response.transaction),
      response.newBalance,
    );
  }

  @override
  Future<List<QRPaymentModel>> getMyGeneratedQRCodes({
    int? limit,
    int? offset,
    QRPaymentStatus? statusFilter,
  }) async {
    final request = pb.GetMyGeneratedQRCodesRequest()
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    if (statusFilter != null) {
      request.statusFilter = _statusToProto(statusFilter);
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.qrPayClient.getMyGeneratedQRCodes(
      request,
      options: options,
    );
    return response.qrCodes
        .map((qr) => QRPaymentModel.fromProto(qr))
        .toList();
  }

  @override
  Future<List<QRTransactionModel>> getMyQRPayments({
    int? limit,
    int? offset,
  }) async {
    final request = pb.GetMyQRPaymentsRequest()
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.qrPayClient.getMyQRPayments(
      request,
      options: options,
    );
    return response.transactions
        .map((txn) => QRTransactionModel.fromProto(txn))
        .toList();
  }

  @override
  Future<void> cancelQR({
    required String qrId,
  }) async {
    final request = pb.CancelQRRequest()..qrId = qrId;

    final options = await grpcClient.callOptions;
    await grpcClient.qrPayClient.cancelQR(
      request,
      options: options,
    );
  }

  @override
  Future<QRTransactionModel> getQRTransactionReceipt({
    required String transactionId,
  }) async {
    final request = pb.GetQRTransactionReceiptRequest()
      ..transactionId = transactionId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.qrPayClient.getQRTransactionReceipt(
      request,
      options: options,
    );
    return QRTransactionModel.fromProto(response.transaction);
  }

  pb.QRStatus _statusToProto(QRPaymentStatus status) {
    switch (status) {
      case QRPaymentStatus.pending:
        return pb.QRStatus.QR_STATUS_PENDING;
      case QRPaymentStatus.paid:
        return pb.QRStatus.QR_STATUS_PAID;
      case QRPaymentStatus.cancelled:
        return pb.QRStatus.QR_STATUS_CANCELLED;
      case QRPaymentStatus.expired:
        return pb.QRStatus.QR_STATUS_EXPIRED;
    }
  }
}
