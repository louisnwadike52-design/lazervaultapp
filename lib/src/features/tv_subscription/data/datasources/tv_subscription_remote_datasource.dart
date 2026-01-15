import '../../../../core/network/grpc_client.dart';
import '../models/tv_provider_model.dart';
import '../models/tv_package_model.dart';
import '../models/smartcard_validation_result_model.dart';
import '../models/tv_payment_model.dart';

abstract class TVSubscriptionRemoteDataSource {
  // Provider Management
  Future<List<TVProviderModel>> getProviders({String? category});
  Future<void> syncProviders();

  // Package Management
  Future<List<TVPackageModel>> getPackages({required String providerCode});

  // Smartcard Validation
  Future<SmartcardValidationResultModel> validateSmartcard({
    required String providerCode,
    required String smartcardNumber,
  });

  // Payment Operations
  Future<TVPaymentModel> initiatePayment({
    required String providerCode,
    required String packageCode,
    required String smartcardNumber,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? transactionId,
    String? verificationToken,
  });

  Future<TVPaymentModel> verifyPayment({required String paymentId});
  Future<List<TVPaymentModel>> getPaymentHistory({int? limit, int? offset});
  Future<TVPaymentModel> getPaymentReceipt({required String paymentId});
}

class TVSubscriptionRemoteDataSourceImpl implements TVSubscriptionRemoteDataSource {
  final GrpcClient grpcClient;

  TVSubscriptionRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<TVProviderModel>> getProviders({String? category}) async {
    // TODO: Implement gRPC call to utility payments service
    throw UnimplementedError('getProviders not implemented');
  }

  @override
  Future<void> syncProviders() async {
    // TODO: Implement gRPC call to sync providers
    throw UnimplementedError('syncProviders not implemented');
  }

  @override
  Future<List<TVPackageModel>> getPackages({required String providerCode}) async {
    // TODO: Implement gRPC call to get packages for provider
    throw UnimplementedError('getPackages not implemented');
  }

  @override
  Future<SmartcardValidationResultModel> validateSmartcard({
    required String providerCode,
    required String smartcardNumber,
  }) async {
    // TODO: Implement gRPC call to validate smartcard
    throw UnimplementedError('validateSmartcard not implemented');
  }

  @override
  Future<TVPaymentModel> initiatePayment({
    required String providerCode,
    required String packageCode,
    required String smartcardNumber,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? transactionId,
    String? verificationToken,
  }) async {
    // TODO: Implement gRPC call to PayTVSubscription
    throw UnimplementedError('initiatePayment not implemented');
  }

  @override
  Future<TVPaymentModel> verifyPayment({required String paymentId}) async {
    // TODO: Implement gRPC call to VerifyBillPayment
    throw UnimplementedError('verifyPayment not implemented');
  }

  @override
  Future<List<TVPaymentModel>> getPaymentHistory({int? limit, int? offset}) async {
    // TODO: Implement gRPC call to GetPaymentHistory
    throw UnimplementedError('getPaymentHistory not implemented');
  }

  @override
  Future<TVPaymentModel> getPaymentReceipt({required String paymentId}) async {
    // TODO: Implement gRPC call to GetPaymentReceipt
    throw UnimplementedError('getPaymentReceipt not implemented');
  }
}
