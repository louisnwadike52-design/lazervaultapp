import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/generated/auth.pbenum.dart' as auth_enum;
import '../entities/profile_entity.dart';
import '../entities/phone_verification_entity.dart';
import '../entities/two_factor_entity.dart';
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
    String? locale, // Locale format: "en-NG", "en-US", etc. Backend will derive country/currency
    String? bvn,
    String? nin,
  });

  Future<Either<Failure, ProfileEntity>> signInWithGoogle();

  Future<Either<Failure, ProfileEntity>> signInWithApple();

  // Password reset methods (supports both email and SMS)
  /// Request password reset via email or SMS
  /// Returns PasswordResetResult with delivery method and masked contact
  Future<Either<Failure, PasswordResetResult>> requestPasswordResetV2({
    String? email,
    String? phone,
    auth_enum.PasswordResetDeliveryMethod? deliveryMethod,
  });

  /// Verify password reset code (OTP for SMS or token for email)
  /// Returns PasswordResetVerificationResult with reset token
  Future<Either<Failure, PasswordResetVerificationResult>> verifyPasswordResetCode({
    required String contact,
    required String code,
    required auth_enum.PasswordResetDeliveryMethod deliveryMethod,
  });

  /// Reset password using verified reset token
  Future<Either<Failure, void>> resetPasswordWithToken({
    required String resetToken,
    required String newPassword,
  });

  // Legacy password reset methods (kept for backward compatibility)
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

  // ===== Two-Factor Authentication =====
  /// Read the current 2FA status (enabled/method/backup-code count) for the
  /// authenticated user. JWT-derived user id; no body args needed.
  Future<Either<Failure, TwoFactorStatus>> getTwoFactorStatus();

  /// Begin 2FA enrolment for [method]. Returns the QR/secret/backup codes
  /// payload — caller must then verify the first generated code via
  /// [completeTwoFactorSetup] within the backend's setup-window TTL.
  Future<Either<Failure, TwoFactorSetup>> enableTwoFactor({
    required TwoFactorMethod method,
  });

  /// Verify the first 6-digit code and flip the account's
  /// `two_factor_enabled` column to true.
  Future<Either<Failure, void>> completeTwoFactorSetup({
    required String code,
  });

  /// Disable 2FA on the account; backend requires a current valid code as
  /// proof of possession.
  Future<Either<Failure, void>> disableTwoFactor({
    required String code,
  });

  /// Mint a new batch of backup codes (invalidates the previous batch).
  /// Requires a current valid code as proof of possession.
  Future<Either<Failure, List<String>>> regenerateBackupCodes({
    required String code,
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

/// Result of password reset request
class PasswordResetResult {
  final bool success;
  final String message;
  final String deliveryMethod; // 'email' or 'sms'
  final String maskedContact; // Masked email or phone
  final int expiresInSeconds;
  final String? resetToken; // For email flow (direct token)
  final bool userFound; // Whether the email/phone was actually registered

  PasswordResetResult({
    required this.success,
    required this.message,
    required this.deliveryMethod,
    required this.maskedContact,
    required this.expiresInSeconds,
    this.resetToken,
    this.userFound = true, // Default to true for backward compatibility
  });
}

/// Result of password reset code verification
class PasswordResetVerificationResult {
  final bool success;
  final String message;
  final String resetToken; // Use this to call resetPasswordWithToken
  final int expiresInSeconds;

  PasswordResetVerificationResult({
    required this.success,
    required this.message,
    required this.resetToken,
    required this.expiresInSeconds,
  });
} 