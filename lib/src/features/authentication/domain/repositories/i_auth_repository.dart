import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/profile_entity.dart';
import '../entities/phone_verification_entity.dart';
import '../usecases/sign_up_usecase.dart';

abstract class IAuthRepository {
  // Authentication methods - return ProfileEntity on success
  Future<Either<Failure, ProfileEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, ProfileEntity>> loginWithPasscode({
    required String email,
    required String passcode,
  });

  Future<Either<Failure, void>> registerPasscode({
    required String passcode,
  });

  Future<Either<Failure, void>> changePasscode({
    required String oldPasscode,
    required String newPasscode,
  });

  Future<Either<Failure, ProfileEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required SignupPrimaryContact primaryContact,
    String? phoneNumber,
    String? username,
    String? referralCode,
    String? countryCode,
    String? currencyCode,
    String? bvn,
    String? nin,
  });

  Future<Either<Failure, ProfileEntity>> signInWithGoogle();

  Future<Either<Failure, ProfileEntity>> signInWithApple();

  // Password reset methods
  Future<Either<Failure, void>> requestPasswordReset({
    required String email,
  });

  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });

  // Email verification methods
  Future<Either<Failure, ProfileEntity>> verifyEmail({
    required String verificationCode,
  });

  /// Returns the cooldown seconds (time to wait before next resend attempt)
  Future<Either<Failure, int>> resendVerificationEmail({required String email});

  // Email availability check
  Future<Either<Failure, bool>> checkEmailAvailability({
    required String email,
  });

  // Token refresh
  Future<Either<Failure, ProfileEntity>> refreshToken({
    required String refreshToken,
  });

  /// Validate access token and return user profile if valid
  Future<Either<Failure, ProfileEntity>> validateToken({
    required String accessToken,
  });

  // Phone verification methods
  Future<Either<Failure, PhoneVerificationEntity>> requestPhoneVerification({
    required String phoneNumber,
  });

  Future<Either<Failure, VerifyPhoneEntity>> verifyPhoneNumber({
    required String phoneNumber,
    required String verificationCode,
  });

  /// Verify identity (BVN, NIN, SSN, etc.) with the banking service
  /// Returns verified identity details and virtual account info on success
  Future<Either<Failure, IdentityVerificationResult>> verifyIdentity({
    required String identityType, // 'bvn', 'nin', 'ssn', etc.
    required String identityNumber,
    required String dateOfBirth, // YYYY-MM-DD format
    String? countryCode, // ISO country code (e.g., 'NG', 'US', 'GB')
  });
}

/// Result of identity verification
class IdentityVerificationResult {
  final bool verified;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? photoUrl;
  final VirtualAccountInfo? virtualAccount;

  IdentityVerificationResult({
    required this.verified,
    this.firstName,
    this.lastName,
    this.middleName,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.photoUrl,
    this.virtualAccount,
  });
}

/// Virtual account info created after verification
class VirtualAccountInfo {
  final String accountNumber;
  final String bankName;
  final String bankCode;
  final String accountName;
  final String currency;
  final String provider;

  VirtualAccountInfo({
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
    required this.accountName,
    required this.currency,
    required this.provider,
  });
} 