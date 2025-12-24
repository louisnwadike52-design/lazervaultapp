import 'package:grpc/grpc.dart';
import '../../../../grpc_generated/barcode_payment.pbgrpc.dart' as pb;
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
  final pb.BarcodePaymentServiceClient client;

  BarcodePaymentRemoteDataSourceImpl({required this.client});

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

    final response = await client.generateBarcode(request);

    // Fetch the full barcode details
    return await getBarcodeDetails(barcodeCode: response.barcodeCode);
  }

  @override
  Future<BarcodePaymentModel> getBarcodeDetails({
    required String barcodeCode,
  }) async {
    final request = pb.GetBarcodeDetailsRequest()
      ..barcodeCode = barcodeCode;

    final response = await client.getBarcodeDetails(request);
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

    final response = await client.processBarcodePayment(request);
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

    final response = await client.getMyGeneratedBarcodes(request);
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

    final response = await client.getMyScannedBarcodes(request);
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

    await client.cancelBarcode(request);
  }
}
