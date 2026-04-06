import 'dart:async';

import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/repositories/airtime_to_cash_repository.dart';
import '../models/airtime_to_cash_conversion_model.dart';
import '../models/network_rate_model.dart';

abstract class AirtimeToCashRemoteDataSource {
  Future<List<NetworkRateModel>> getRates();

  Future<OTPResult> requestOTP(String phoneNumber, String network);

  Future<OTPVerifyResult> verifyOTP(
    String phoneNumber,
    String network,
    String otp,
    String sessionId,
  );

  Future<ServiceVerificationResult> verifyService(String network);

  Future<ProviderInfoResult> getProviderInfo();

  Future<AirtimeToCashConversionModel> convert({
    required String phoneNumber,
    required String network,
    required double amount,
    required String sessionToken,
    required String sessionId,
    required String pin,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });

  Future<List<AirtimeToCashConversionModel>> getHistory({
    int limit = 20,
    int offset = 0,
  });

  Future<QuotaCheckResult> checkQuota(String network, double amount);
}

class AirtimeToCashRemoteDataSourceImpl
    implements AirtimeToCashRemoteDataSource {
  final GrpcClient grpcClient;

  AirtimeToCashRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<NetworkRateModel>> getRates() async {
    try {
      final request = pb.GetAirtimeToCashRatesRequest();
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeToCashRates(request, options: options);

      final rates = response.rates;
      if (rates.isEmpty) {
        throw Exception(
            'No conversion rates available. Please try again later.');
      }

      return rates
          .map((rate) => NetworkRateModel.fromProto(rate))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch airtime-to-cash rates: ${e.message}');
    } on TimeoutException {
      throw Exception(
          'Request timed out. Please check your connection and try again.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to fetch airtime-to-cash rates: $e');
    }
  }

  @override
  Future<OTPResult> requestOTP(String phoneNumber, String network) async {
    try {
      final request = pb.RequestAirtimeToCashOTPRequest()
        ..phoneNumber = phoneNumber
        ..network = network;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .requestAirtimeToCashOTP(request, options: options);

      // Validate sessionId when OTP is required and request succeeded
      if (response.success && response.otpRequired && response.sessionId.isEmpty) {
        throw Exception(
            'Server returned an invalid session. Please try again.');
      }

      return OTPResult(
        success: response.success,
        message: response.message.isNotEmpty
            ? response.message
            : (response.success ? 'OTP sent successfully' : 'Failed to send OTP'),
        sessionId: response.sessionId,
        otpRequired: response.otpRequired,
        destinationPhone: response.hasDestinationPhone() ? response.destinationPhone : '',
        providerName: response.hasProviderName() ? response.providerName : '',
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to request OTP: ${e.message}');
    } on TimeoutException {
      throw Exception(
          'Request timed out. Please check your connection and try again.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to request OTP: $e');
    }
  }

  @override
  Future<OTPVerifyResult> verifyOTP(
    String phoneNumber,
    String network,
    String otp,
    String sessionId,
  ) async {
    try {
      final request = pb.VerifyAirtimeToCashOTPRequest()
        ..phoneNumber = phoneNumber
        ..network = network
        ..otp = otp
        ..sessionId = sessionId;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .verifyAirtimeToCashOTP(request, options: options);

      // Validate sessionToken when verification succeeded
      if (response.verified && response.sessionToken.isEmpty) {
        throw Exception(
            'Server returned an invalid session token. Please try again.');
      }

      return OTPVerifyResult(
        verified: response.verified,
        message: response.message.isNotEmpty
            ? response.message
            : (response.verified ? 'OTP verified' : 'Invalid OTP code'),
        sessionToken: response.sessionToken,
        sessionId: response.sessionId, // sessionId now returned in response
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to verify OTP: ${e.message}');
    } on TimeoutException {
      throw Exception(
          'Verification timed out. Please check your connection and try again.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to verify OTP: $e');
    }
  }

  @override
  Future<QuotaCheckResult> checkQuota(String network, double amount) async {
    try {
      final request = pb.GetAirtimeToCashRatesRequest();

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeToCashRates(request, options: options);

      // Find the specific network rate
      final networkRate = response.rates.firstWhere(
        (rate) => rate.network == network,
        orElse: () => pb.AirtimeToCashNetworkRate()
          ..network = network
          ..isAvailable = false
          ..conversionRate = 0.0
          ..minAmount = 0.0
          ..maxAmount = 0.0
          ..automationFee = 0.0,
      );

      final available = networkRate.isAvailable &&
          amount >= networkRate.minAmount &&
          amount <= networkRate.maxAmount;

      return QuotaCheckResult(
        available: available,
        maxAmount: networkRate.maxAmount,
        message: available
            ? 'Conversion available at ${networkRate.conversionRate}x rate'
            : 'Conversion not available for this network or amount',
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to check quota: ${e.message}');
    } on TimeoutException {
      throw Exception('Quota check timed out. Please try again.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to check quota: $e');
    }
  }

  @override
  Future<AirtimeToCashConversionModel> convert({
    required String phoneNumber,
    required String network,
    required double amount,
    required String sessionToken,
    required String sessionId,
    required String pin,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    try {
      final request = pb.ConvertAirtimeToCashRequest()
        ..phoneNumber = phoneNumber
        ..network = network
        ..amount = amount
        ..sessionToken = sessionToken
        ..sessionId = sessionId
        ..pin = pin
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .convertAirtimeToCash(request, options: options);

      // Null-safe response parsing: validate payment exists
      if (!response.hasPayment()) {
        throw Exception(
            'Server returned an incomplete response. Please check your conversion history.');
      }

      return AirtimeToCashConversionModel.fromConvertResponse(response);
    } on GrpcError catch (e) {
      throw Exception('Failed to convert airtime to cash: ${e.message}');
    } on TimeoutException {
      throw Exception(
          'Conversion request timed out. Please check your conversion history for the status.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to convert airtime to cash: $e');
    }
  }

  @override
  Future<List<AirtimeToCashConversionModel>> getHistory({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final request = pb.GetAirtimeToCashHistoryRequest()
        ..limit = limit
        ..offset = offset;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeToCashHistory(request, options: options);

      return response.conversions
          .map((conversion) =>
              AirtimeToCashConversionModel.fromProto(conversion))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to fetch airtime-to-cash history: ${e.message}');
    } on TimeoutException {
      throw Exception(
          'Request timed out. Please check your connection and try again.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to fetch airtime-to-cash history: $e');
    }
  }

  @override
  Future<ServiceVerificationResult> verifyService(String network) async {
    try {
      final request = pb.GetAirtimeToCashRatesRequest();

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeToCashRates(request, options: options);

      // Check if the specific network is available
      final networkRate = response.rates.firstWhere(
        (rate) => rate.network == network,
        orElse: () => pb.AirtimeToCashNetworkRate()
          ..network = network
          ..isAvailable = false,
      );

      return ServiceVerificationResult(
        isAvailable: networkRate.isAvailable,
        providerName: 'VTUAfrica',
        destinationPhone: '',
        message: networkRate.isAvailable
            ? 'Service available for $network'
            : 'Service not available for $network',
        network: network,
        requiresTransfer: true,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to verify service: ${e.message}');
    } on TimeoutException {
      throw Exception('Service verification timed out. Please try again.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to verify service: $e');
    }
  }

  @override
  Future<ProviderInfoResult> getProviderInfo() async {
    try {
      // Use GetAirtimeToCashRates to get provider info
      final request = pb.GetAirtimeToCashRatesRequest();

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeToCashRates(request, options: options);

      // Map network rates to provider status info
      final providers = response.rates.map((rate) => ProviderStatusInfo(
        name: rate.network,
        displayName: '${rate.network} Airtime',
        isActive: rate.isAvailable,
        isHealthy: rate.isAvailable,
        networkCount: 1,
        errorMessage: rate.isAvailable ? '' : 'Network unavailable',
      )).toList();

      return ProviderInfoResult(
        providerName: 'VTUAfrica',
        requiresOTP: true,
        requiresTransfer: true,
        displayName: 'Airtime to Cash',
        providers: providers,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to get provider info: ${e.message}');
    } on TimeoutException {
      throw Exception('Request timed out. Please check your connection and try again.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Failed to get provider info: $e');
    }
  }
}
