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

  Future<AirtimeToCashConversionModel> convert({
    required String phoneNumber,
    required String network,
    required double amount,
    required String sessionToken,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });

  Future<List<AirtimeToCashConversionModel>> getHistory({
    int limit = 20,
    int offset = 0,
  });
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
  Future<AirtimeToCashConversionModel> convert({
    required String phoneNumber,
    required String network,
    required double amount,
    required String sessionToken,
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
}
