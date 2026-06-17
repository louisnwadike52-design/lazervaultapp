import '../entities/airtime_to_cash_conversion.dart';
import '../entities/network_rate.dart';

/// Result of requesting an OTP for airtime-to-cash phone verification.
class OTPResult {
  final bool success;
  final String message;
  final String sessionId;
  final bool otpRequired;
  final String destinationPhone; // VTU Africa: phone to transfer airtime to
  final String providerName; // "airtimetocash" or "vtuafrica"

  const OTPResult({
    required this.success,
    required this.message,
    required this.sessionId,
    required this.otpRequired,
    this.destinationPhone = '',
    this.providerName = '',
  });
}

/// Result of verifying the OTP code.
class OTPVerifyResult {
  final bool verified;
  final String message;
  final String sessionToken;
  final String sessionId; // Added for Automation API

  const OTPVerifyResult({
    required this.verified,
    required this.message,
    required this.sessionToken,
    required this.sessionId,
  });
}

/// Result of verifying service availability.
class ServiceVerificationResult {
  final bool isAvailable;
  final String providerName;
  final String destinationPhone;
  final String message;
  final String network;
  final bool requiresTransfer;

  const ServiceVerificationResult({
    required this.isAvailable,
    required this.providerName,
    required this.destinationPhone,
    required this.message,
    required this.network,
    required this.requiresTransfer,
  });
}

/// Information about the active provider.
class ProviderInfoResult {
  final String providerName;
  final bool requiresOTP;
  final bool requiresTransfer;
  final String displayName;
  final List<ProviderStatusInfo> providers;

  const ProviderInfoResult({
    required this.providerName,
    required this.requiresOTP,
    required this.requiresTransfer,
    required this.displayName,
    required this.providers,
  });
}

/// Status of a provider.
class ProviderStatusInfo {
  final String name;
  final String displayName;
  final bool isActive;
  final bool isHealthy;
  final int networkCount;
  final String errorMessage;

  const ProviderStatusInfo({
    required this.name,
    required this.displayName,
    required this.isActive,
    required this.isHealthy,
    required this.networkCount,
    required this.errorMessage,
  });
}

/// Result of checking quota availability.
class QuotaCheckResult {
  final bool available;
  final double maxAmount;
  final String message;

  const QuotaCheckResult({
    required this.available,
    required this.maxAmount,
    required this.message,
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

  /// Verify service availability and get provider details.
  Future<ServiceVerificationResult> verifyService(String network);

  /// Check if provider can accept the conversion amount.
  Future<QuotaCheckResult> checkQuota({
    required String network,
    required double amount,
  });

  /// Get information about the active provider.
  Future<ProviderInfoResult> getProviderInfo();

  /// Execute an airtime-to-cash conversion.
  Future<AirtimeToCashConversion> convert({
    required String phoneNumber,
    required String network,
    required double amount,
    required String sessionToken,
    required String sessionId, // Added for Automation API
    required String pin, // SIM Transfer PIN (required for Automation API)
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
