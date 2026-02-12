import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/core/network/grpc_client.dart';
import '../models/cable_tv_provider_model.dart';
import '../models/tv_package_model.dart';
import '../models/smart_card_validation_model.dart';
import '../models/cable_tv_payment_model.dart';

abstract class CableTVRemoteDataSource {
  Future<List<CableTVProviderModel>> getProviders({bool activeOnly = true});
  Future<SmartCardValidationModel> validateSmartCard({
    required String providerId,
    required String smartCardNumber,
  });
  Future<List<TVPackageModel>> getPackages({required String providerId});
  Future<CableTVPaymentModel> paySubscription({
    required String providerId,
    required String smartCardNumber,
    required String variationCode,
    required double amount,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });
}

class CableTVRemoteDataSourceImpl implements CableTVRemoteDataSource {
  final GrpcClient grpcClient;

  CableTVRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<CableTVProviderModel>> getProviders({bool activeOnly = true}) async {
    final request = pb.GetCableTVProvidersRequest()
      ..activeOnly = activeOnly;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.getCableTVProviders(
      request,
      options: options,
    );

    return response.providers
        .map((provider) => CableTVProviderModel.fromProto(provider))
        .toList();
  }

  @override
  Future<SmartCardValidationModel> validateSmartCard({
    required String providerId,
    required String smartCardNumber,
  }) async {
    final request = pb.ValidateSmartCardRequest()
      ..providerId = providerId
      ..smartCardNumber = smartCardNumber;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.validateSmartCard(
      request,
      options: options,
    );

    return SmartCardValidationModel.fromProto(response.validation);
  }

  @override
  Future<List<TVPackageModel>> getPackages({required String providerId}) async {
    final request = pb.GetTVPackagesRequest()
      ..providerId = providerId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.getTVPackages(
      request,
      options: options,
    );

    return response.packages
        .map((package) => TVPackageModel.fromProto(package))
        .toList();
  }

  @override
  Future<CableTVPaymentModel> paySubscription({
    required String providerId,
    required String smartCardNumber,
    required String variationCode,
    required double amount,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    final request = pb.PayCableTVBillRequest()
      ..providerId = providerId
      ..smartCardNumber = smartCardNumber
      ..variationCode = variationCode
      ..amount = amount
      ..phone = phone
      ..transactionId = transactionId
      ..verificationToken = verificationToken
      ..idempotencyKey = idempotencyKey;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.payCableTVBill(
      request,
      options: options,
    );

    return CableTVPaymentModel.fromResponse(
      payment: response.payment,
      newBalance: response.newBalance,
      renewalDate: response.renewalDate,
      customerName: response.customerName,
    );
  }
}
