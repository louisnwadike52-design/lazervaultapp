import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/core/network/grpc_client.dart';
import '../models/internet_provider_model.dart';
import '../models/internet_package_model.dart';
import '../models/internet_account_validation_model.dart';
import '../models/internet_payment_model.dart';

abstract class InternetBillRemoteDataSource {
  Future<List<InternetProviderModel>> getProviders({bool activeOnly = true});
  Future<InternetAccountValidationModel> validateAccount({
    required String providerId,
    required String accountNumber,
  });
  Future<List<InternetPackageModel>> getPackages({required String providerId});
  Future<InternetPaymentModel> payBill({
    required String providerId,
    required String customerNumber,
    required String serviceType,
    required String packageId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });
}

class InternetBillRemoteDataSourceImpl implements InternetBillRemoteDataSource {
  final GrpcClient grpcClient;

  InternetBillRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<InternetProviderModel>> getProviders({bool activeOnly = true}) async {
    final request = pb.GetInternetProvidersRequest()
      ..activeOnly = activeOnly;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.getInternetProviders(
      request,
      options: options,
    );

    return response.providers
        .map((provider) => InternetProviderModel.fromProto(provider))
        .toList();
  }

  @override
  Future<InternetAccountValidationModel> validateAccount({
    required String providerId,
    required String accountNumber,
  }) async {
    final request = pb.ValidateInternetAccountRequest()
      ..providerId = providerId
      ..accountNumber = accountNumber;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.validateInternetAccount(
      request,
      options: options,
    );

    return InternetAccountValidationModel.fromProto(response.validation);
  }

  @override
  Future<List<InternetPackageModel>> getPackages({required String providerId}) async {
    final request = pb.GetInternetPackagesRequest()
      ..providerId = providerId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.getInternetPackages(
      request,
      options: options,
    );

    return response.packages
        .map((package) => InternetPackageModel.fromProto(package))
        .toList();
  }

  @override
  Future<InternetPaymentModel> payBill({
    required String providerId,
    required String customerNumber,
    required String serviceType,
    required String packageId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    final request = pb.PayInternetBillRequest()
      ..providerId = providerId
      ..customerNumber = customerNumber
      ..serviceType = serviceType
      ..packageId = packageId
      ..amount = amount
      ..transactionId = transactionId
      ..verificationToken = verificationToken
      ..idempotencyKey = idempotencyKey;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.payInternetBill(
      request,
      options: options,
    );

    return InternetPaymentModel.fromResponse(
      payment: response.payment,
      newBalance: response.newBalance,
      renewalDate: response.renewalDate,
    );
  }
}
