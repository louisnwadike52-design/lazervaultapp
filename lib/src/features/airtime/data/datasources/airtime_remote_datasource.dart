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
    String? reloadlyOperatorId,
    required String currency,
  });
  Future<AirtimeTransactionModel> transferAirtime({
    required String senderPhone,
    required String recipientPhone,
    required String recipientName,
    required String network,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    required String countryCode,
    String? operatorId,
    String? transferNote,
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
    String? reloadlyOperatorId,
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
  Future<AirtimeTransactionModel> transferAirtime({
    required String senderPhone,
    required String recipientPhone,
    required String recipientName,
    required String network,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    required String countryCode,
    String? operatorId,
    String? transferNote,
    required String currency,
  }) async {
    // The utility-payments proto does NOT define a dedicated
    // TransferAirtime RPC. Airtime transfers are modelled as a top-up to the
    // recipient from the sender's wallet — i.e. the same shape as
    // `BuyAirtime`, just annotated with transfer metadata so the receipt and
    // history can distinguish it. The backend handler detects
    // `airtimeType == 'transfer'` and stamps the payment accordingly.
    try {
      final request = pb.BuyAirtimeRequest()
        ..providerId = network
        ..phoneNumber = recipientPhone
        ..amount = amount
        ..airtimeType = 'transfer'
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey
        ..countryCode = countryCode;

      if (operatorId != null && operatorId.isNotEmpty) {
        request.operatorId = operatorId;
      }

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .buyAirtime(request, options: options);

      return AirtimeTransactionModel.fromTransferAirtimeResponse(
        senderPhone: senderPhone,
        recipientPhone: recipientPhone,
        recipientName: recipientName,
        response: response,
        currency: currency,
        transferNote: transferNote,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to transfer airtime: ${e.message}');
    }
  }

  /// The airtime "family" — expanded server-side by `bill_type_in` so
  /// history queries don't drag electricity/water/cable rows into the
  /// airtime tab.
  static const _airtimeFamily = [
    'airtime',
    'intl_airtime',
    'airtime_to_cash',
  ];

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
        // Single-value scope: respect the caller (used by admin tools).
        request.billType = billType;
      } else {
        // Default: let the backend IN-filter to the airtime family so we
        // don't post-process rows client-side.
        request.billTypeIn.addAll(_airtimeFamily);
      }

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getBillPaymentHistory(request, options: options);

      return response.payments
          .map((payment) => AirtimeTransactionModel.fromBillPaymentProto(
              payment, currency: 'NGN'))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch airtime history: ${e.message}');
    }
  }
}
