import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../../../core/network/grpc_client.dart';
import '../models/water_provider_model.dart';
import '../models/water_payment_model.dart';
import '../models/customer_validation_result_model.dart';

abstract class WaterBillRemoteDataSource {
  // Provider Management
  Future<List<WaterProviderModel>> getProviders({String? country});
  Future<void> syncProviders();

  // Customer Validation
  Future<CustomerValidationResultModel> validateCustomer({
    required String providerCode,
    required String customerNumber,
  });

  // Payment Operations
  Future<WaterPaymentModel> initiatePayment({
    required String providerCode,
    required String customerNumber,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? transactionId,
    String? verificationToken,
  });

  Future<WaterPaymentModel> verifyPayment({required String paymentId});
  Future<List<WaterPaymentModel>> getPaymentHistory({int? limit, int? offset});
  Future<WaterPaymentModel> getPaymentReceipt({required String paymentId});
}

class WaterBillRemoteDataSourceImpl implements WaterBillRemoteDataSource {
  final GrpcClient grpcClient;

  WaterBillRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<WaterProviderModel>> getProviders({String? country}) async {
    final request = pb.GetBillProvidersRequest()
      ..type = 'water'
      ..activeOnly = true;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.getBillProviders(
      request,
      options: options,
    );

    return response.providers
        .map((provider) => WaterProviderModel(
              providerCode: provider.id,
              providerName: provider.name,
              logoUrl: provider.logoUrl,
              isActive: provider.isActive,
            ))
        .toList();
  }

  @override
  Future<void> syncProviders() async {
    // Water providers are seeded server-side, no sync needed
    await getProviders();
  }

  @override
  Future<CustomerValidationResultModel> validateCustomer({
    required String providerCode,
    required String customerNumber,
  }) async {
    final request = pb.VerifyBillRequest()
      ..providerId = providerCode
      ..customerNumber = customerNumber
      ..billType = 'water';

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.verifyBill(
      request,
      options: options,
    );

    return CustomerValidationResultModel(
      customerNumber: customerNumber,
      customerName: response.customerName,
      outstandingBalance: response.outstandingAmount > 0
          ? response.outstandingAmount.toStringAsFixed(2)
          : null,
      isValid: response.isValid,
    );
  }

  @override
  Future<WaterPaymentModel> initiatePayment({
    required String providerCode,
    required String customerNumber,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? transactionId,
    String? verificationToken,
  }) async {
    final request = pb.PayWaterBillRequest()
      ..providerId = providerCode
      ..customerNumber = customerNumber
      ..amount = amount
      ..idempotencyKey = DateTime.now().millisecondsSinceEpoch.toString();

    if (transactionId != null) request.transactionId = transactionId;
    if (verificationToken != null) {
      request.verificationToken = verificationToken;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.payWaterBill(
      request,
      options: options,
    );

    return WaterPaymentModel.fromProtoResponse(
      payment: response.payment,
      newBalance: response.newBalance,
      receiptNumber: response.receiptNumber,
    );
  }

  @override
  Future<WaterPaymentModel> verifyPayment({required String paymentId}) async {
    final request = pb.GetBillPaymentHistoryRequest()
      ..billType = 'water'
      ..limit = 1;

    final options = await grpcClient.callOptions;
    final response =
        await grpcClient.utilityPaymentsClient.getBillPaymentHistory(
      request,
      options: options,
    );

    if (response.payments.isEmpty) {
      throw Exception('Payment not found');
    }

    final payment = response.payments.first;
    return WaterPaymentModel.fromProtoPayment(payment);
  }

  @override
  Future<List<WaterPaymentModel>> getPaymentHistory(
      {int? limit, int? offset}) async {
    final request = pb.GetBillPaymentHistoryRequest()
      ..billType = 'water'
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    final options = await grpcClient.callOptions;
    final response =
        await grpcClient.utilityPaymentsClient.getBillPaymentHistory(
      request,
      options: options,
    );

    return response.payments
        .map((p) => WaterPaymentModel.fromProtoPayment(p))
        .toList();
  }

  @override
  Future<WaterPaymentModel> getPaymentReceipt(
      {required String paymentId}) async {
    return verifyPayment(paymentId: paymentId);
  }
}
