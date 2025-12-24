import 'package:grpc/grpc.dart';
import '../../../../generated/barcode_payment.pbgrpc.dart' as pb;
import '../../../../core/network/grpc_client.dart';
import '../models/barcode_payment_model.dart';
import '../models/barcode_transaction_model.dart';

abstract class BarcodePaymentRemoteDataSource {
  Future<BarcodePaymentModel> generateBarcode({
    required double amount,
    required String currency,
    String? description,
    int? validityMinutes,
  });

  Future<BarcodePaymentModel> getBarcodeDetails({
    required String barcodeCode,
  });

  Future<BarcodeTransactionModel> processBarcodePayment({
    required String barcodeCode,
    required String sourceAccountId,
  });

  Future<List<BarcodePaymentModel>> getMyGeneratedBarcodes({
    int? limit,
    int? offset,
  });

  Future<List<BarcodeTransactionModel>> getMyScannedBarcodes({
    int? limit,
    int? offset,
  });

  Future<void> cancelBarcode({
    required String barcodeId,
  });
}

class BarcodePaymentRemoteDataSourceImpl implements BarcodePaymentRemoteDataSource {
  final GrpcClient grpcClient;

  BarcodePaymentRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<BarcodePaymentModel> generateBarcode({
    required double amount,
    required String currency,
    String? description,
    int? validityMinutes,
  }) async {
    final request = pb.GenerateBarcodeRequest()
      ..amount = amount
      ..currency = currency
      ..description = description ?? ''
      ..validityMinutes = validityMinutes ?? 30;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.barcodePaymentClient.generateBarcode(
      request,
      options: options,
    );

    // Fetch the full barcode details
    return await getBarcodeDetails(barcodeCode: response.barcodeCode);
  }

  @override
  Future<BarcodePaymentModel> getBarcodeDetails({
    required String barcodeCode,
  }) async {
    final request = pb.GetBarcodeDetailsRequest()
      ..barcodeCode = barcodeCode;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.barcodePaymentClient.getBarcodeDetails(
      request,
      options: options,
    );
    return BarcodePaymentModel.fromProto(response.barcode);
  }

  @override
  Future<BarcodeTransactionModel> processBarcodePayment({
    required String barcodeCode,
    required String sourceAccountId,
  }) async {
    final request = pb.ProcessBarcodePaymentRequest()
      ..barcodeCode = barcodeCode
      ..sourceAccountId = sourceAccountId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.barcodePaymentClient.processBarcodePayment(
      request,
      options: options,
    );
    return BarcodeTransactionModel.fromProto(response.transaction);
  }

  @override
  Future<List<BarcodePaymentModel>> getMyGeneratedBarcodes({
    int? limit,
    int? offset,
  }) async {
    final request = pb.GetMyGeneratedBarcodesRequest()
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.barcodePaymentClient.getMyGeneratedBarcodes(
      request,
      options: options,
    );
    return response.barcodes
        .map((barcode) => BarcodePaymentModel.fromProto(barcode))
        .toList();
  }

  @override
  Future<List<BarcodeTransactionModel>> getMyScannedBarcodes({
    int? limit,
    int? offset,
  }) async {
    final request = pb.GetMyScannedBarcodesRequest()
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.barcodePaymentClient.getMyScannedBarcodes(
      request,
      options: options,
    );
    return response.transactions
        .map((transaction) => BarcodeTransactionModel.fromProto(transaction))
        .toList();
  }

  @override
  Future<void> cancelBarcode({
    required String barcodeId,
  }) async {
    final request = pb.CancelBarcodeRequest()
      ..barcodeId = barcodeId;

    final options = await grpcClient.callOptions;
    await grpcClient.barcodePaymentClient.cancelBarcode(
      request,
      options: options,
    );
  }
}
