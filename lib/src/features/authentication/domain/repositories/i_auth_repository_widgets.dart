part of 'i_auth_repository.dart';

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

 
/// Result of requesting a phone signup OTP.
class PhoneSignupOtpResult {
  final int expiresInSeconds;   // OTP validity window
  final int resendAfterSeconds; // cooldown before another request is allowed
  const PhoneSignupOtpResult({
    required this.expiresInSeconds,
    required this.resendAfterSeconds,
  });
}

/// Returned (as a Left) when a login needs an adaptive step-up OTP before a
/// session is issued. Carries everything the OTP screen needs. The cubit
/// inspects for this type and routes to the OTP flow instead of showing an error.
/// A step-up verify that failed, with the server's stable reason attached.
class StepUpVerifyFailure extends Failure {
  final String code;
  StepUpVerifyFailure({required String message, required this.code})
      : super(message: message, statusCode: 401);
}

class StepUpRequiredFailure extends Failure {
  final String stepUpToken;
  final String stepUpMethod;  // "email" | "sms"
  final String destination;   // masked, for display

  /// Seconds the code is valid for, straight from the server. The OTP screen
  /// counts down from this instead of a constant of its own, so the admin can
  /// retune the lifetime and installed apps follow on the next sign-in.
  /// Zero means the server did not say; the screen falls back to its default.
  final int expiresInSeconds;

  StepUpRequiredFailure({
    required this.stepUpToken,
    required this.stepUpMethod,
    required this.destination,
    this.expiresInSeconds = 0,
  }) : super(message: 'Verification required', statusCode: 0);
}

/// One sign-in event (success or failure) for the Login Activity feed.
class LoginActivity {
  final bool success;
  final String ipAddress;
  final String deviceName;
  final String userAgent;
  final String failReason; // populated when success == false
  final DateTime? at;

  const LoginActivity({
    required this.success,
    required this.ipAddress,
    required this.deviceName,
    required this.userAgent,
    required this.failReason,
    this.at,
  });
}

/// Returned (as a Left) when a login needs 2FA verification before a session is
/// issued. Carries the temp token + method so the UI can prompt correctly (TOTP
/// = enter authenticator code; sms/email = a code is sent).
class TwoFactorRequiredFailure extends Failure {
  final String twoFactorToken;
  final String method; // "totp" | "sms" | "email"
  TwoFactorRequiredFailure({
    required this.twoFactorToken,
    required this.method,
  }) : super(message: '2FA required', statusCode: 0);
}

/// A device the user has logged in from (security center / trusted devices).
class TrustedDevice {
  final String deviceUuid;
  final String platform;     // ios | android
  final String model;
  final String osVersion;
  final String appVersion;
  final String trustStatus;  // pending | trusted | revoked | compromised
  final String lastIp;
  final String lastLocation;
  final DateTime? firstSeenAt;
  final DateTime? lastLoginAt;
  final bool isCurrent;      // true when this is the requesting device

  const TrustedDevice({
    required this.deviceUuid,
    required this.platform,
    required this.model,
    required this.osVersion,
    required this.appVersion,
    required this.trustStatus,
    required this.lastIp,
    required this.lastLocation,
    this.firstSeenAt,
    this.lastLoginAt,
    this.isCurrent = false,
  });

  bool get isTrusted => trustStatus == 'trusted';
}

/// Outcome of an in-app account-deletion request.
class AccountDeletionOutcome {
  final bool success;
  final String status;          // "pending_deletion" on success
  final String scheduledAt;     // ISO 8601 — when the account is finalized
  final int gracePeriodDays;
  final String message;
  final String errorCode;       // "FUNDS_PRESENT" when blocked by a balance/hold

  const AccountDeletionOutcome({
    required this.success,
    this.status = '',
    this.scheduledAt = '',
    this.gracePeriodDays = 0,
    this.message = '',
    this.errorCode = '',
  });

  bool get isFundsBlocked => errorCode == 'FUNDS_PRESENT';
}
