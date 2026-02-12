import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../models/airtime_transaction_model.dart';
import '../models/network_provider_model.dart';

abstract class AirtimeRemoteDataSource {
  Future<List<NetworkProviderModel>> getProvidersByCountry(String countryCode);
  Future<AirtimeTransactionModel> buyAirtime({
    required String providerId,
    required String phoneNumber,
    required double amount,
    required String airtimeType,
    String? dataPlanId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    required String countryCode,
    String? operatorId,
    required String currency,
  });
  Future<List<AirtimeTransactionModel>> getHistory({
    String? billType,
    int limit = 20,
    int offset = 0,
  });
}

class AirtimeRemoteDataSourceImpl implements AirtimeRemoteDataSource {
  final GrpcClient grpcClient;

  AirtimeRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<NetworkProviderModel>> getProvidersByCountry(
      String countryCode) async {
    try {
      final request = pb.GetAirtimeProvidersRequest()
        ..activeOnly = true
        ..countryCode = countryCode;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeProviders(request, options: options);

      return response.providers
          .map((provider) => NetworkProviderModel.fromProto(provider))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch airtime providers: ${e.message}');
    }
  }

  @override
  Future<AirtimeTransactionModel> buyAirtime({
    required String providerId,
    required String phoneNumber,
    required double amount,
    required String airtimeType,
    String? dataPlanId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    required String countryCode,
    String? operatorId,
    required String currency,
  }) async {
    try {
      final request = pb.BuyAirtimeRequest()
        ..providerId = providerId
        ..phoneNumber = phoneNumber
        ..amount = amount
        ..airtimeType = airtimeType
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey
        ..countryCode = countryCode;

      if (dataPlanId != null && dataPlanId.isNotEmpty) {
        request.dataPlanId = dataPlanId;
      }
      if (operatorId != null && operatorId.isNotEmpty) {
        request.operatorId = operatorId;
      }

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .buyAirtime(request, options: options);

      return AirtimeTransactionModel.fromBuyAirtimeResponse(response, currency: currency);
    } on GrpcError catch (e) {
      throw Exception('Failed to purchase airtime: ${e.message}');
    }
  }

  @override
  Future<List<AirtimeTransactionModel>> getHistory({
    String? billType,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final request = pb.GetBillPaymentHistoryRequest()
        ..limit = limit
        ..offset = offset;

      if (billType != null) {
        request.billType = billType;
      }

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getBillPaymentHistory(request, options: options);

      return response.payments
          .map((payment) => AirtimeTransactionModel.fromBillPaymentProto(payment, currency: 'NGN'))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch airtime history: ${e.message}');
    }
  }
}
