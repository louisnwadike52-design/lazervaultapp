import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/core/network/grpc_client.dart';
import '../models/education_provider_model.dart';
import '../models/education_purchase_model.dart';

abstract class EducationRemoteDataSource {
  Future<List<EducationProviderModel>> getProviders({bool activeOnly = true});
  Future<EducationPurchaseModel> purchasePin({
    required String serviceId,
    required int quantity,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });
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
    required int quantity,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    final request = pb.PurchaseEducationPinRequest()
      ..serviceId = serviceId
      ..quantity = quantity
      ..phone = phone
      ..transactionId = transactionId
      ..verificationToken = verificationToken
      ..idempotencyKey = idempotencyKey;

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
}
