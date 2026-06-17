import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/core/network/grpc_client.dart';
import '../models/education_provider_model.dart';
import '../models/education_purchase_model.dart';
import '../models/education_history_model.dart';

abstract class EducationRemoteDataSource {
  Future<List<EducationProviderModel>> getProviders({bool activeOnly = true});
  Future<EducationPurchaseModel> purchasePin({
    required String serviceId,
    required String variationCode,
    required int quantity,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String billersCode = '',
  });

  /// Get education PIN purchase history
  Future<List<EducationHistoryModel>> getHistory({
    int limit = 20,
    int offset = 0,
  });

  /// Get education PIN purchase by ID with full PIN details
  Future<EducationHistoryModel> getPurchaseById(String id);
}

class EducationRemoteDataSourceImpl implements EducationRemoteDataSource {
  final GrpcClient grpcClient;

  EducationRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<EducationProviderModel>> getProviders({bool activeOnly = true}) async {
    final request = pb.GetEducationProvidersRequest()
      ..activeOnly = activeOnly;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient
        .getEducationProviders(request, options: options);

    return response.providers
        .map((provider) => EducationProviderModel.fromProto(provider))
        .toList();
  }

  @override
  Future<EducationPurchaseModel> purchasePin({
    required String serviceId,
    required String variationCode,
    required int quantity,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String billersCode = '',
  }) async {
    final request = pb.PurchaseEducationPinRequest()
      ..serviceId = serviceId
      ..variationCode = variationCode
      ..quantity = quantity
      ..phone = phone
      ..transactionId = transactionId
      ..verificationToken = verificationToken
      ..idempotencyKey = idempotencyKey
      ..billersCode = billersCode;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient
        .purchaseEducationPin(request, options: options);

    return EducationPurchaseModel.fromProto(
      payment: response.payment,
      newBalance: response.newBalance,
      pins: response.pins,
      message: response.message,
    );
  }

  @override
  Future<List<EducationHistoryModel>> getHistory({
    int limit = 20,
    int offset = 0,
  }) async {
    final request = pb.GetBillPaymentHistoryRequest()
      ..billType = 'education'
      ..limit = limit
      ..offset = offset;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient
        .getBillPaymentHistory(request, options: options);

    return response.payments
        .map((payment) => EducationHistoryModel.fromProto(payment))
        .toList();
  }

  @override
  Future<EducationHistoryModel> getPurchaseById(String id) async {
    // This is a workaround - in production, you'd want a dedicated endpoint
    // For now, we'll get the full history and filter
    final request = pb.GetBillPaymentHistoryRequest()
      ..billType = 'education'
      ..limit = 100; // Get a larger batch to find the purchase

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient
        .getBillPaymentHistory(request, options: options);

    // Filter the payments to find the one with matching ID
    final matchingPayment = response.payments.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Purchase not found'),
    );

    return EducationHistoryModel.fromProto(matchingPayment);
  }
}
