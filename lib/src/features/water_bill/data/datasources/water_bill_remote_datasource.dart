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
    // TODO: Implement gRPC call to utility payments service
    // This will call GetBillProviders with category="water"
    throw UnimplementedError('getProviders not implemented');
  }

  @override
  Future<void> syncProviders() async {
    // TODO: Implement gRPC call to sync providers
    throw UnimplementedError('syncProviders not implemented');
  }

  @override
  Future<CustomerValidationResultModel> validateCustomer({
    required String providerCode,
    required String customerNumber,
  }) async {
    // TODO: Implement gRPC call to validate water customer
    throw UnimplementedError('validateCustomer not implemented');
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
    // TODO: Implement gRPC call to PayWaterBill
    throw UnimplementedError('initiatePayment not implemented');
  }

  @override
  Future<WaterPaymentModel> verifyPayment({required String paymentId}) async {
    // TODO: Implement gRPC call to VerifyBillPayment
    throw UnimplementedError('verifyPayment not implemented');
  }

  @override
  Future<List<WaterPaymentModel>> getPaymentHistory({int? limit, int? offset}) async {
    // TODO: Implement gRPC call to GetPaymentHistory
    throw UnimplementedError('getPaymentHistory not implemented');
  }

  @override
  Future<WaterPaymentModel> getPaymentReceipt({required String paymentId}) async {
    // TODO: Implement gRPC call to GetPaymentReceipt
    throw UnimplementedError('getPaymentReceipt not implemented');
  }
}
