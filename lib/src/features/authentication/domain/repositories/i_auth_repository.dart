import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/generated/auth.pbenum.dart' as auth_enum;
import '../entities/profile_entity.dart';
import '../entities/phone_verification_entity.dart';
import '../entities/two_factor_entity.dart';
import '../usecases/sign_up_usecase.dart';
part 'i_auth_repository_widgets.dart';


abstract class IAuthRepository {
  // Authentication methods - return ProfileEntity on success.
  // Exactly one of [email] / [phone] identifies the account (the email+password
  // login accepts either); [phone] must be E.164 when provided.
  Future<Either<Failure, ProfileEntity>> login({
    String email,
    String phone,
    required String password,
  });

  Future<Either<Failure, ProfileEntity>> loginWithPasscode({
    required String email,
    required String passcode,
  });

  // ── Phone + Passcode authentication mode ─────────────────────────────────
  /// Returns the active platform auth mode ('email_password' | 'phone_passcode').
  Future<Either<Failure, String>> getAuthenticationMode();

  /// Start phone+passcode signup: send a 6-digit SMS OTP to the phone.
  Future<Either<Failure, PhoneSignupOtpResult>> requestSignupPhoneOtp({
    required String phone,
    required String countryCode,
  });

  /// Verify the signup OTP; returns a single-use signup token on success.
  Future<Either<Failure, String>> verifySignupPhoneOtp({
    required String phone,
    required String code,
  });

  /// Create a phone-primary account (email optional). Returns a session.
  Future<Either<Failure, ProfileEntity>> signUpWithPhone({
    required String phone,
    required String signupToken,
    required String passcode,
    required String firstName,
    required String lastName,
    String? email,
    required String countryCode,
    String? locale,
    String? username,
    String? referralCode,
    String? dateOfBirth,
  });

  /// Login a phone-primary user with phone + passcode.
  Future<Either<Failure, ProfileEntity>> loginWithPhonePasscode({
    required String phone,
    required String passcode,
  });

  /// Forgot passcode (phone+passcode): send a 6-digit SMS OTP to a phone-primary
  /// account to begin a passcode reset.
  Future<Either<Failure, PhoneSignupOtpResult>> requestPasscodeReset({
    required String phone,
    required String countryCode,
  });

  /// Validate the reset OTP WITHOUT consuming it, so the code can be confirmed
  /// the instant it is entered (before choosing a new passcode).
  Future<Either<Failure, void>> verifyPasscodeReset({
    required String phone,
    required String code,
    required String countryCode,
  });

  /// Verify the reset OTP and set a new login passcode in one call.
  Future<Either<Failure, void>> resetPasscodeWithOtp({
    required String phone,
    required String code,
    required String newPasscode,
  });

  /// Set the calling user's preferred login method ("email_password" |
  /// "phone_passcode"). Returns the applied method on success.
  Future<Either<Failure, String>> setPreferredLoginMethod({
    required String method,
  });

  /// Set an INITIAL password for a passwordless account (enables the
  /// email+password login method).
  Future<Either<Failure, void>> setPassword({
    required String newPassword,
  });

  Future<Either<Failure, void>> registerPasscode({
    required String passcode,
  });

  Future<Either<Failure, void>> changePasscode({
    required String oldPasscode,
    required String newPasscode,
  });

  /// Complete an adaptive step-up login by verifying the OTP that was sent when
  /// a login returned [StepUpRequiredFailure]. Returns a full session.
  /// Requests a fresh step-up code; returns the new lifetime in seconds.
  Future<Either<Failure, int>> resendLoginOtp({required String stepUpToken});

  Future<Either<Failure, ProfileEntity>> verifyLoginOtp({
    required String stepUpToken,
    required String code,
  });

  /// Complete a 2FA login by verifying the code, using the temp [twoFactorToken]
  /// returned when a login responded with [TwoFactorRequiredFailure]. Works for
  /// authenticator (TOTP), SMS and email methods (+ backup codes).
  Future<Either<Failure, ProfileEntity>> verifyTwoFactor({
    required String twoFactorToken,
    required String code,
  });

  /// (Re)send a 2FA code for SMS/email methods. Pass the temp [twoFactorToken]
  /// during LOGIN (used as the Bearer). Pass null during SETUP (already authed —
  /// the normal access token is used). No-op-safe for TOTP.
  Future<Either<Failure, void>> sendTwoFactorLoginCode({
    String? twoFactorToken,
  });

  // ===== Trusted devices (security center) =====
  /// Enroll/refresh THIS device in the backend registry. Fire-and-forget after
  /// login; failures are non-fatal.
  Future<Either<Failure, void>> registerDevice();

  /// List the user's known devices for the security center.
  Future<Either<Failure, List<TrustedDevice>>> listDevices();

  /// Revoke a device (ends its sessions). [deviceUuid] from [listDevices].
  Future<Either<Failure, void>> revokeDevice({required String deviceUuid});

  /// Recent sign-in activity (successes + failures) for the security center.
  /// [offset] skips rows for bottom-reach pagination (load-more).
  Future<Either<Failure, List<LoginActivity>>> getLoginActivity(
      {int limit, int offset});

  /// Refresh the access/refresh tokens using the stored refresh token. Returns
  /// the new token metadata on success, or null when the session is no longer
  /// valid (revoked/expired). Used to re-validate after a biometric/voice unlock.
  Future<Map<String, String>?> refreshTokensSimple();

  /// Like [refreshTokensSimple], but DISTINGUISHES a definitive auth failure
  /// from a transient one so the caller never logs a user out over a network
  /// blip. Returns `authExpired: true` ONLY when the refresh token was actually
  /// rejected (Unauthenticated / PermissionDenied / InvalidArgument / NotFound /
  /// 401) — the session is genuinely gone → clear + passcode. On a transient
  /// failure (Unavailable / DeadlineExceeded / Internal / network / 5xx) it
  /// returns `authExpired: false` with null tokens — the refresh token is STILL
  /// VALID, so the caller MUST keep the session intact (a later retry / the next
  /// gRPC call / a biometric unlock will rotate it). On success it persists the
  /// rotated tokens and rolls the durable biometric copy forward, like
  /// [refreshTokensWithToken], and returns them.
  Future<({Map<String, String>? tokens, bool authExpired})>
      refreshTokensWithReason();

  /// Rotate the session from an EXPLICIT refresh token (e.g. the durable
  /// biometric token) rather than the volatile `refresh_token` key. Persists the
  /// rotated access/refresh tokens on success and returns the new token metadata,
  /// or null when that token is no longer valid. Used by biometric unlock to
  /// re-mint a live session after the volatile refresh token was wiped.
  Future<Map<String, String>?> refreshTokensWithToken(String refreshToken);

  /// Request in-app deletion of the current account (30-day cancellable grace).
  /// The user is identified by the bearer token. On the server this revokes
  /// sessions; the client should clear the local session on success.
  Future<Either<Failure, AccountDeletionOutcome>> requestAccountDeletion({String? reason});

  /// Arm a self-imposed account lock for [durationSeconds] (Settings → Security).
  /// Blocks login + transactions until it elapses; no early unlock. Returns the
  /// ISO-8601 unlock time on success. The current session is revoked server-side.
  Future<Either<Failure, DateTime>> requestAccountLock({required int durationSeconds, String? reason});

  /// Cancel a pending account deletion within the grace window.
  Future<Either<Failure, String>> cancelAccountDeletion();

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

  /// Revoke the current session on the backend (invalidates the server-side
  /// session / refresh token) so the JWT can't be replayed after logout. Best
  /// effort — the caller still clears the local session even if this fails.
  Future<Either<Failure, void>> logout({
    required String userId,
    required String refreshToken,
  });

  // Phone verification methods
  Future<Either<Failure, PhoneVerificationEntity>> requestPhoneVerification({
    required String phoneNumber,
  });

  Future<Either<Failure, VerifyPhoneEntity>> verifyPhoneNumber({
    required String phoneNumber,
    required String verificationCode,
  });

  /// Change the signed-in user's phone to a brand-new number. Sends an SMS OTP
  /// to the NEW number; the change only applies after [verifyPhoneChange].
  /// Returns a status message on success.
  Future<Either<Failure, String>> requestPhoneChange({
    required String newPhone,
    String countryCode,
  });

  /// Verify the OTP sent to the new number and apply the change. Returns the
  /// newly-applied phone number on success.
  Future<Either<Failure, String>> verifyPhoneChange({
    required String newPhone,
    required String code,
    String countryCode,
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
