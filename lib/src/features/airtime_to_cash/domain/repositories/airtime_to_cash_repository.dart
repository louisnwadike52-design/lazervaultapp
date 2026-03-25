import '../entities/airtime_to_cash_conversion.dart';
import '../entities/network_rate.dart';

/// Result of requesting an OTP for airtime-to-cash phone verification.
class OTPResult {
  final bool success;
  final String message;
  final String sessionId;
  final bool otpRequired;

  const OTPResult({
    required this.success,
    required this.message,
    required this.sessionId,
    required this.otpRequired,
  });
}

/// Result of verifying the OTP code.
class OTPVerifyResult {
  final bool verified;
  final String message;
  final String sessionToken;

  const OTPVerifyResult({
    required this.verified,
    required this.message,
    required this.sessionToken,
  });
}

abstract class AirtimeToCashRepository {
  /// Get conversion rates for all supported networks.
  Future<List<NetworkRate>> getRates();

  /// Request OTP to verify phone ownership before conversion.
  Future<OTPResult> requestOTP({
    required String phoneNumber,
    required String network,
  });

  /// Verify the OTP code and obtain a session token for conversion.
  Future<OTPVerifyResult> verifyOTP({
    required String phoneNumber,
    required String network,
    required String otp,
    required String sessionId,
  });

  /// Execute an airtime-to-cash conversion.
  Future<AirtimeToCashConversion> convert({
    required String phoneNumber,
    required String network,
    required double amount,
    required String sessionToken,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });

  /// Get conversion history with pagination.
  Future<List<AirtimeToCashConversion>> getHistory({
    int limit = 20,
    int offset = 0,
  });
}
