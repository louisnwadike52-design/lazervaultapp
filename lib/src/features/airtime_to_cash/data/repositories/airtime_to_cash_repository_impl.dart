import '../../domain/entities/airtime_to_cash_conversion.dart';
import '../../domain/entities/network_rate.dart';
import '../../domain/repositories/airtime_to_cash_repository.dart';
import '../datasources/airtime_to_cash_remote_datasource.dart';

class AirtimeToCashRepositoryImpl implements AirtimeToCashRepository {
  final AirtimeToCashRemoteDataSource remoteDataSource;

  AirtimeToCashRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NetworkRate>> getRates() async {
    try {
      final rates = await remoteDataSource.getRates();
      return rates;
    } catch (e) {
      throw Exception('Failed to fetch conversion rates: $e');
    }
  }

  @override
  Future<OTPResult> requestOTP({
    required String phoneNumber,
    required String network,
  }) async {
    try {
      return await remoteDataSource.requestOTP(phoneNumber, network);
    } catch (e) {
      throw Exception('Failed to request OTP: $e');
    }
  }

  @override
  Future<OTPVerifyResult> verifyOTP({
    required String phoneNumber,
    required String network,
    required String otp,
    required String sessionId,
  }) async {
    try {
      return await remoteDataSource.verifyOTP(
        phoneNumber,
        network,
        otp,
        sessionId,
      );
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  @override
  Future<AirtimeToCashConversion> convert({
    required String phoneNumber,
    required String network,
    required double amount,
    required String sessionToken,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    try {
      return await remoteDataSource.convert(
        phoneNumber: phoneNumber,
        network: network,
        amount: amount,
        sessionToken: sessionToken,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
    } catch (e) {
      throw Exception('Failed to convert airtime to cash: $e');
    }
  }

  @override
  Future<List<AirtimeToCashConversion>> getHistory({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final conversions = await remoteDataSource.getHistory(
        limit: limit,
        offset: offset,
      );
      return conversions;
    } catch (e) {
      throw Exception('Failed to fetch conversion history: $e');
    }
  }
}
