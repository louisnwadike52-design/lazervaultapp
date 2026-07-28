// This is a generated file - do not edit.
//
// Generated from auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pb.dart' as $0;

export 'auth.pb.dart';

/// Auth Service - Complete authentication and authorization
@$pb.GrpcServiceName('pb.AuthService')
class AuthServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AuthServiceClient(super.channel, {super.options, super.interceptors});

  /// User registration
  $grpc.ResponseFuture<$0.SignupResponse> signup(
    $0.SignupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$signup, request, options: options);
  }

  /// User login
  $grpc.ResponseFuture<$0.LoginResponse> login(
    $0.LoginRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$login, request, options: options);
  }

  /// Refresh access token
  $grpc.ResponseFuture<$0.RefreshTokenResponse> refreshToken(
    $0.RefreshTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  /// Logout user
  $grpc.ResponseFuture<$0.LogoutResponse> logout(
    $0.LogoutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  /// Email verification
  $grpc.ResponseFuture<$0.VerifyEmailResponse> verifyEmail(
    $0.VerifyEmailRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyEmail, request, options: options);
  }

  /// Phone verification
  $grpc.ResponseFuture<$0.VerifyPhoneResponse> verifyPhone(
    $0.VerifyPhoneRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyPhone, request, options: options);
  }

  /// Request password reset (supports email or SMS)
  $grpc.ResponseFuture<$0.ForgotPasswordResponse> forgotPassword(
    $0.ForgotPasswordRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$forgotPassword, request, options: options);
  }

  /// Verify password reset code (for SMS OTP or email token)
  $grpc.ResponseFuture<$0.VerifyPasswordResetCodeResponse>
      verifyPasswordResetCode(
    $0.VerifyPasswordResetCodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyPasswordResetCode, request,
        options: options);
  }

  /// Reset password with token
  $grpc.ResponseFuture<$0.ResetPasswordResponse> resetPassword(
    $0.ResetPasswordRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resetPassword, request, options: options);
  }

  /// Get current user info
  $grpc.ResponseFuture<$0.GetMeResponse> getMe(
    $0.GetMeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMe, request, options: options);
  }

  /// Update user profile
  $grpc.ResponseFuture<$0.UpdateProfileResponse> updateProfile(
    $0.UpdateProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateProfile, request, options: options);
  }

  /// Facial recognition login
  $grpc.ResponseFuture<$0.FacialLoginResponse> facialLogin(
    $0.FacialLoginRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$facialLogin, request, options: options);
  }

  /// Social login (Google, Facebook, Apple)
  $grpc.ResponseFuture<$0.SocialLoginResponse> socialLogin(
    $0.SocialLoginRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$socialLogin, request, options: options);
  }

  /// Enable two-factor authentication
  $grpc.ResponseFuture<$0.EnableTwoFactorResponse> enableTwoFactor(
    $0.EnableTwoFactorRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$enableTwoFactor, request, options: options);
  }

  /// Verify two-factor authentication
  $grpc.ResponseFuture<$0.VerifyTwoFactorResponse> verifyTwoFactor(
    $0.VerifyTwoFactorRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyTwoFactor, request, options: options);
  }

  /// Complete two-factor authentication setup
  $grpc.ResponseFuture<$0.CompleteTwoFactorSetupResponse>
      completeTwoFactorSetup(
    $0.CompleteTwoFactorSetupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$completeTwoFactorSetup, request,
        options: options);
  }

  /// Disable two-factor authentication
  $grpc.ResponseFuture<$0.DisableTwoFactorResponse> disableTwoFactor(
    $0.DisableTwoFactorRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$disableTwoFactor, request, options: options);
  }

  /// Get two-factor authentication status
  $grpc.ResponseFuture<$0.GetTwoFactorStatusResponse> getTwoFactorStatus(
    $0.GetTwoFactorStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTwoFactorStatus, request, options: options);
  }

  /// Regenerate two-factor backup codes
  $grpc.ResponseFuture<$0.RegenerateBackupCodesResponse> regenerateBackupCodes(
    $0.RegenerateBackupCodesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$regenerateBackupCodes, request, options: options);
  }

  /// Send two-factor authentication code (for SMS/Email methods)
  $grpc.ResponseFuture<$0.SendTwoFactorCodeResponse> sendTwoFactorCode(
    $0.SendTwoFactorCodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendTwoFactorCode, request, options: options);
  }

  /// Get available two-factor authentication methods
  $grpc.ResponseFuture<$0.GetAvailable2FAMethodsResponse>
      getAvailable2FAMethods(
    $0.GetAvailable2FAMethodsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAvailable2FAMethods, request,
        options: options);
  }

  /// Validate token (used by gateway)
  $grpc.ResponseFuture<$0.ValidateTokenResponse> validateToken(
    $0.ValidateTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateToken, request, options: options);
  }

  /// Resend verification email
  $grpc.ResponseFuture<$0.ResendVerificationEmailResponse>
      resendVerificationEmail(
    $0.ResendVerificationEmailRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resendVerificationEmail, request,
        options: options);
  }

  /// Resend phone verification SMS
  $grpc.ResponseFuture<$0.ResendPhoneVerificationResponse>
      resendPhoneVerification(
    $0.ResendPhoneVerificationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resendPhoneVerification, request,
        options: options);
  }

  /// Change password (authenticated)
  $grpc.ResponseFuture<$0.ChangePasswordResponse> changePassword(
    $0.ChangePasswordRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$changePassword, request, options: options);
  }

  /// Channel login - authenticate via phone number for SMS/WhatsApp/Phone banking
  $grpc.ResponseFuture<$0.ChannelLoginResponse> channelLogin(
    $0.ChannelLoginRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$channelLogin, request, options: options);
  }

  /// Channel register - register new user via phone channel
  $grpc.ResponseFuture<$0.ChannelRegisterResponse> channelRegister(
    $0.ChannelRegisterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$channelRegister, request, options: options);
  }

  /// Channel verify registration - verify OTP for new user registration
  $grpc.ResponseFuture<$0.ChannelVerifyRegistrationResponse>
      channelVerifyRegistration(
    $0.ChannelVerifyRegistrationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$channelVerifyRegistration, request,
        options: options);
  }

  /// Admin: Generate JWT token for user by phone number (for telephony/WhatsApp voice agents)
  $grpc.ResponseFuture<$0.AdminGenerateTokenByPhoneResponse>
      adminGenerateTokenByPhone(
    $0.AdminGenerateTokenByPhoneRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminGenerateTokenByPhone, request,
        options: options);
  }

  /// Login with passcode
  $grpc.ResponseFuture<$0.LoginResponse> loginWithPasscode(
    $0.LoginWithPasscodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$loginWithPasscode, request, options: options);
  }

  /// Public: complete an adaptive step-up login by verifying the OTP that was
  /// sent when LoginResponse.step_up_required was true. Returns a full session.
  $grpc.ResponseFuture<$0.LoginResponse> verifyLoginOtp(
    $0.VerifyLoginOtpRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyLoginOtp, request, options: options);
  }

  /// Register passcode
  $grpc.ResponseFuture<$0.RegisterPasscodeResponse> registerPasscode(
    $0.RegisterPasscodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$registerPasscode, request, options: options);
  }

  /// Change passcode
  $grpc.ResponseFuture<$0.ChangePasscodeResponse> changePasscode(
    $0.ChangePasscodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$changePasscode, request, options: options);
  }

  /// Device permissions audit (camera/mic/contacts/etc). Persists the user's
  /// last-known OS permission grants for cross-device audit. The OS remains the
  /// source of truth on each device; this is a best-effort mirror.
  $grpc.ResponseFuture<$0.AuthUpdateDevicePermissionsResponse>
      updateDevicePermissions(
    $0.AuthUpdateDevicePermissionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateDevicePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.AuthGetDevicePermissionsResponse>
      getDevicePermissions(
    $0.AuthGetDevicePermissionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDevicePermissions, request, options: options);
  }

  /// Verify passcode (read-only check of the current login passcode; no session
  /// change). Used by the Settings "Change Passcode" flow to confirm the current
  /// passcode before allowing entry of a new one. Applies brute-force lockout.
  $grpc.ResponseFuture<$0.VerifyPasscodeResponse> verifyPasscode(
    $0.VerifyPasscodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyPasscode, request, options: options);
  }

  /// Request password reset
  $grpc.ResponseFuture<$0.RequestPasswordResetResponse> requestPasswordReset(
    $0.RequestPasswordResetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestPasswordReset, request, options: options);
  }

  /// Request email verification
  $grpc.ResponseFuture<$0.RequestEmailVerificationResponse>
      requestEmailVerification(
    $0.RequestEmailVerificationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestEmailVerification, request,
        options: options);
  }

  /// Check email availability
  $grpc.ResponseFuture<$0.CheckEmailAvailabilityResponse>
      checkEmailAvailability(
    $0.CheckEmailAvailabilityRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkEmailAvailability, request,
        options: options);
  }

  /// Request phone verification
  $grpc.ResponseFuture<$0.RequestPhoneVerificationResponse>
      requestPhoneVerification(
    $0.RequestPhoneVerificationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestPhoneVerification, request,
        options: options);
  }

  /// Verify phone number
  $grpc.ResponseFuture<$0.VerifyPhoneNumberResponse> verifyPhoneNumber(
    $0.VerifyPhoneNumberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyPhoneNumber, request, options: options);
  }

  /// Get signup progress for authenticated user
  $grpc.ResponseFuture<$0.GetSignupProgressResponse> getSignupProgress(
    $0.GetSignupProgressRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSignupProgress, request, options: options);
  }

  /// Update signup step progress
  $grpc.ResponseFuture<$0.UpdateSignupStepResponse> updateSignupStep(
    $0.UpdateSignupStepRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateSignupStep, request, options: options);
  }

  /// Complete signup flow
  $grpc.ResponseFuture<$0.CompleteSignupResponse> completeSignup(
    $0.CompleteSignupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$completeSignup, request, options: options);
  }

  /// Verify identity (BVN or NIN) - Synchronous flow during signup
  $grpc.ResponseFuture<$0.VerifyIdentityResponse> verifyIdentity(
    $0.VerifyIdentityRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyIdentity, request, options: options);
  }

  /// Get identity verification status
  $grpc.ResponseFuture<$0.GetIdentityVerificationStatusResponse>
      getIdentityVerificationStatus(
    $0.GetIdentityVerificationStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getIdentityVerificationStatus, request,
        options: options);
  }

  /// Initiate KYC verification flow
  $grpc.ResponseFuture<$0.InitiateKYCResponse> initiateKYC(
    $0.InitiateKYCRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateKYC, request, options: options);
  }

  /// Upload KYC document
  $grpc.ResponseFuture<$0.UploadDocumentResponse> uploadDocument(
    $0.UploadDocumentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadDocument, request, options: options);
  }

  /// Skip KYC upgrade (progressive onboarding)
  $grpc.ResponseFuture<$0.SkipKYCUpgradeResponse> skipKYCUpgrade(
    $0.SkipKYCUpgradeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$skipKYCUpgrade, request, options: options);
  }

  /// SyncVerifiedKYCTier — INTERNAL, gRPC-only (no HTTP route). A trusted service
  /// (banking-service, which runs the Mono Prove flow and owns the verified
  /// identity record) pushes a user's verified KYC tier into auth so the
  /// platform's users.kyc_tier reflects it. Gated by x-service-name metadata in
  /// the handler; never reachable by end users.
  $grpc.ResponseFuture<$0.SyncVerifiedKYCTierResponse> syncVerifiedKYCTier(
    $0.SyncVerifiedKYCTierRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$syncVerifiedKYCTier, request, options: options);
  }

  /// AdminOverrideKYCTier sets a user's KYC tier from the admin console. Unlike
  /// SyncVerifiedKYCTier (monotonic, system source), this allows a DOWNGRADE
  /// (fraud) and records the admin actor + reason in the audit trail. It emits
  /// the same tier-change event so accounts re-syncs limits both ways. Gated by
  /// x-service-name (admin-gateway).
  $grpc.ResponseFuture<$0.AdminOverrideKYCTierResponse> adminOverrideKYCTier(
    $0.AdminOverrideKYCTierRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminOverrideKYCTier, request, options: options);
  }

  /// AdminResetTransactionPin clears a user's transaction PIN from the admin
  /// console (super-admin support action). The admin does NOT choose a PIN value —
  /// the PIN is cleared and the user must re-enrol a fresh PIN in the app. Emits a
  /// security notification (push + SMS + email) and audits the admin actor. Gated
  /// by x-service-name (admin-gateway).
  $grpc.ResponseFuture<$0.AdminResetTransactionPinResponse>
      adminResetTransactionPin(
    $0.AdminResetTransactionPinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminResetTransactionPin, request,
        options: options);
  }

  /// GetKYCTier returns the canonical kyc_tier for a user (service-only; gated by
  /// x-service-name). Lets banking reflect the authoritative tier (e.g. after an
  /// admin override) in GetProveKYCStatus.
  $grpc.ResponseFuture<$0.GetKYCTierResponse> getKYCTier(
    $0.GetKYCTierRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getKYCTier, request, options: options);
  }

  /// GetUserIdentityForService returns the user's RAW verified KYC identity
  /// (NIN/BVN + name/email/phone/DOB) for SERVICE-TO-SERVICE callers that must
  /// prefill a downstream provider form (e.g. MyCover insurance purchase needs
  /// first_name/last_name/email/phone_number + nin). gRPC-only (NO HTTP route)
  /// and gated by x-service-name; end users reach auth only via the gateway and
  /// can never invoke it, so the raw NIN/BVN stays internal.
  $grpc.ResponseFuture<$0.GetUserIdentityForServiceResponse>
      getUserIdentityForService(
    $0.GetUserIdentityForServiceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserIdentityForService, request,
        options: options);
  }

  /// MarkEmailBouncedByEmail flags an email address as undeliverable (hard bounce
  /// or complaint) reported by Amazon SES. Called by notifications-service's
  /// ses-events consumer when SES delivers a bounce/complaint event. Sets
  /// email_bounced (+ clears email_verified) on the user owning that address so
  /// downstream flows treat the email as unusable. gRPC-only (NO HTTP route) and
  /// gated by x-service-name, so end users can never invoke it.
  $grpc.ResponseFuture<$0.MarkEmailBouncedByEmailResponse>
      markEmailBouncedByEmail(
    $0.MarkEmailBouncedByEmailRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$markEmailBouncedByEmail, request,
        options: options);
  }

  /// GetMyInsurancePrefill returns the AUTHENTICATED caller's OWN verified KYC
  /// identity (name/email/phone/DOB + nin/bvn) so the insurance create-policy
  /// form can prefill the customer-info section (editable). The user_id comes
  /// from the JWT context, never the request, so a user can only read their own
  /// identity. Dedicated route (not GetMe) so the raw NIN/BVN is only exposed on
  /// an endpoint a client opts into for prefill, not on every profile fetch.
  $grpc.ResponseFuture<$0.GetMyInsurancePrefillResponse> getMyInsurancePrefill(
    $0.GetMyInsurancePrefillRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMyInsurancePrefill, request, options: options);
  }

  /// Get user's KYC documents
  $grpc.ResponseFuture<$0.GetUserDocumentsResponse> getUserDocuments(
    $0.GetUserDocumentsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserDocuments, request, options: options);
  }

  /// Get KYC status for the authenticated user
  $grpc.ResponseFuture<$0.GetKYCStatusResponse> getKYCStatus(
    $0.GetKYCStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getKYCStatus, request, options: options);
  }

  /// Get country-specific KYC requirements
  $grpc.ResponseFuture<$0.GetCountryRequirementsResponse>
      getCountryRequirements(
    $0.GetCountryRequirementsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCountryRequirements, request,
        options: options);
  }

  /// Create async verification session (provider-hosted SDK/WebView)
  $grpc.ResponseFuture<$0.CreateVerificationSessionResponse>
      createVerificationSession(
    $0.CreateVerificationSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createVerificationSession, request,
        options: options);
  }

  /// Confirm verification after SDK/WebView completion
  $grpc.ResponseFuture<$0.ConfirmVerificationResponse> confirmVerification(
    $0.ConfirmVerificationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$confirmVerification, request, options: options);
  }

  /// Get presigned upload URL for KYC documents (Tier 3)
  $grpc.ResponseFuture<$0.GetDocumentUploadURLResponse> getDocumentUploadURL(
    $0.GetDocumentUploadURLRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDocumentUploadURL, request, options: options);
  }

  /// Submit uploaded documents for Tier 3 admin review
  $grpc.ResponseFuture<$0.SubmitDocumentsForReviewResponse>
      submitDocumentsForReview(
    $0.SubmitDocumentsForReviewRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$submitDocumentsForReview, request,
        options: options);
  }

  /// Confirm BVN name after reconciliation (user chooses to update or keep)
  $grpc.ResponseFuture<$0.ConfirmBVNNameResponse> confirmBVNName(
    $0.ConfirmBVNNameRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$confirmBVNName, request, options: options);
  }

  /// Lookup user by username (LazerTag)
  $grpc.ResponseFuture<$0.UserLookupResponse> lookupUserByUsername(
    $0.LookupUserByUsernameRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$lookupUserByUsername, request, options: options);
  }

  /// Lookup user by phone number
  $grpc.ResponseFuture<$0.UserLookupResponse> lookupUserByPhone(
    $0.LookupUserByPhoneRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$lookupUserByPhone, request, options: options);
  }

  /// Search users for transfers / invites (unified: username, name, email, phone)
  $grpc.ResponseFuture<$0.UserSearchResponse> searchUsers(
    $0.UserSearchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  /// Get all linked social accounts for current user
  $grpc.ResponseFuture<$0.GetLinkedSocialAccountsResponse>
      getLinkedSocialAccounts(
    $0.GetLinkedSocialAccountsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getLinkedSocialAccounts, request,
        options: options);
  }

  /// Link a new social account
  $grpc.ResponseFuture<$0.LinkSocialAccountResponse> linkSocialAccount(
    $0.LinkSocialAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$linkSocialAccount, request, options: options);
  }

  /// Unlink a social account
  $grpc.ResponseFuture<$0.UnlinkSocialAccountResponse> unlinkSocialAccount(
    $0.UnlinkSocialAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unlinkSocialAccount, request, options: options);
  }

  /// Set a social account as primary for login
  $grpc.ResponseFuture<$0.SetPrimarySocialAccountResponse>
      setPrimarySocialAccount(
    $0.SetPrimarySocialAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setPrimarySocialAccount, request,
        options: options);
  }

  /// Reauthorize a social account (refresh tokens)
  $grpc.ResponseFuture<$0.ReauthorizeSocialAccountResponse>
      reauthorizeSocialAccount(
    $0.ReauthorizeSocialAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$reauthorizeSocialAccount, request,
        options: options);
  }

  /// Public: returns the platform-wide active authentication mode so the client
  /// renders the correct onboarding/login flow. Mirrors the value read from
  /// system_settings(auth_mode); defaults to email_password.
  $grpc.ResponseFuture<$0.GetAuthenticationConfigResponse>
      getAuthenticationConfig(
    $0.GetAuthenticationConfigRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAuthenticationConfig, request,
        options: options);
  }

  /// Public: send a 6-digit SMS OTP to prove ownership of a phone before signup
  /// (no account exists yet). Reuses the sms.verification Kafka delivery path.
  $grpc.ResponseFuture<$0.RequestSignupPhoneOTPResponse> requestSignupPhoneOTP(
    $0.RequestSignupPhoneOTPRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestSignupPhoneOTP, request, options: options);
  }

  /// Public: verify the signup phone OTP; on success returns a single-use
  /// signup_token proving phone ownership, consumed by SignupWithPhone.
  $grpc.ResponseFuture<$0.VerifySignupPhoneOTPResponse> verifySignupPhoneOTP(
    $0.VerifySignupPhoneOTPRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifySignupPhoneOTP, request, options: options);
  }

  /// Public: create a phone-primary account (auth_type=PHONE_PASSCODE) using a
  /// verified signup_token + 6-digit passcode. Email is optional. Returns tokens.
  $grpc.ResponseFuture<$0.LoginResponse> signupWithPhone(
    $0.SignupWithPhoneRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$signupWithPhone, request, options: options);
  }

  /// Public: login with phone + passcode (phone-primary accounts).
  $grpc.ResponseFuture<$0.LoginResponse> loginWithPhonePasscode(
    $0.LoginWithPhonePasscodeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$loginWithPhonePasscode, request,
        options: options);
  }

  /// Public: start a passcode reset for a phone-primary (passwordless) account by
  /// sending a 6-digit SMS OTP to the account's phone. Mirrors the signup OTP
  /// path but targets an EXISTING account; never reveals whether the phone is
  /// registered. Used by "Forgot your passcode?" in phone+passcode mode.
  $grpc.ResponseFuture<$0.RequestPasscodeResetResponse> requestPasscodeReset(
    $0.RequestPasscodeResetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestPasscodeReset, request, options: options);
  }

  /// Public: verify the passcode-reset OTP WITHOUT consuming it, so the client
  /// can validate the 6-digit code immediately on entry and only advance to the
  /// new-passcode step when the code is valid. Increments the attempt counter on
  /// a wrong code (same budget as the confirm call); marks the OTP verified on
  /// success but leaves it unconsumed for ResetPasscodeWithOTP to finalize.
  $grpc.ResponseFuture<$0.VerifyPasscodeResetOTPResponse>
      verifyPasscodeResetOTP(
    $0.VerifyPasscodeResetOTPRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyPasscodeResetOTP, request,
        options: options);
  }

  /// Public: verify the passcode-reset OTP and set a new login passcode for the
  /// phone-primary account in a single call. Consumes the OTP.
  $grpc.ResponseFuture<$0.ResetPasscodeWithOTPResponse> resetPasscodeWithOTP(
    $0.ResetPasscodeWithOTPRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resetPasscodeWithOTP, request, options: options);
  }

  /// Authenticated: set the calling user's preferred login method
  /// ("email_password" | "phone_passcode"). Overrides the platform default on
  /// subsequent logins. Switching to email_password requires a password to
  /// already be set (see SetPassword).
  $grpc.ResponseFuture<$0.SetPreferredLoginMethodResponse>
      setPreferredLoginMethod(
    $0.SetPreferredLoginMethodRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setPreferredLoginMethod, request,
        options: options);
  }

  /// Authenticated: set an INITIAL password for a passwordless (phone-primary)
  /// account, so the user can switch to the email+password login method. Only
  /// succeeds when no password is set yet; use ChangePassword to rotate an
  /// existing password.
  $grpc.ResponseFuture<$0.SetPasswordResponse> setPassword(
    $0.SetPasswordRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setPassword, request, options: options);
  }

  /// Admin: set a specific user's preferred login method (dashboard override).
  /// Requires an admin JWT; enforced by the admin-gateway.
  $grpc.ResponseFuture<$0.SetPreferredLoginMethodResponse>
      adminSetPreferredLoginMethod(
    $0.AdminSetPreferredLoginMethodRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminSetPreferredLoginMethod, request,
        options: options);
  }

  /// Authenticated: begin changing the calling user's phone number to a brand-new
  /// one. Sends a 6-digit SMS OTP to the NEW number (stored pending, not applied
  /// yet). Rejects a number already owned by another account.
  $grpc.ResponseFuture<$0.RequestPhoneChangeResponse> requestPhoneChange(
    $0.RequestPhoneChangeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestPhoneChange, request, options: options);
  }

  /// Authenticated: verify the OTP sent to the new number and apply the change
  /// (sets phone + phone_verified=true). Consumes the OTP.
  $grpc.ResponseFuture<$0.VerifyPhoneChangeResponse> verifyPhoneChange(
    $0.VerifyPhoneChangeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyPhoneChange, request, options: options);
  }

  /// ===== Device registry (trusted devices / security center) =====
  /// Enroll or update the calling user's device: stores the hardware-backed
  /// public key (DPoP) + descriptor and returns the server device_uuid + trust
  /// status. Authenticated (user from JWT).
  $grpc.ResponseFuture<$0.RegisterDeviceResponse> registerDevice(
    $0.RegisterDeviceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$registerDevice, request, options: options);
  }

  /// List the calling user's known devices (trusted-device list / login activity).
  $grpc.ResponseFuture<$0.ListDevicesResponse> listDevices(
    $0.ListDevicesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listDevices, request, options: options);
  }

  /// Revoke one of the calling user's devices (forces re-verification on it).
  $grpc.ResponseFuture<$0.RevokeDeviceResponse> revokeDevice(
    $0.RevokeDeviceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$revokeDevice, request, options: options);
  }

  /// Recent sign-in activity (successes + failures) for the calling user.
  $grpc.ResponseFuture<$0.GetLoginHistoryResponse> getLoginHistory(
    $0.GetLoginHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getLoginHistory, request, options: options);
  }

  /// ===== Account deletion (in-app self-service — required by both app stores) =====
  /// Initiate deletion of the CALLING user's account (JWT-identified). Blocked
  /// when the user still holds funds/active holds (error_code = FUNDS_PRESENT).
  /// Otherwise starts a cancellable grace period and revokes the user's sessions.
  $grpc.ResponseFuture<$0.RequestAccountDeletionResponse>
      requestAccountDeletion(
    $0.RequestAccountDeletionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestAccountDeletion, request,
        options: options);
  }

  /// Cancel a pending account deletion within the grace window (JWT-identified).
  $grpc.ResponseFuture<$0.CancelAccountDeletionResponse> cancelAccountDeletion(
    $0.CancelAccountDeletionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelAccountDeletion, request, options: options);
  }

  /// Admin: list accounts in the deletion lifecycle (pending within grace, or
  /// awaiting admin finalization past grace). Enforced by the admin-gateway.
  $grpc.ResponseFuture<$0.ListDeletionAccountsResponse> listDeletionAccounts(
    $0.ListDeletionAccountsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listDeletionAccounts, request, options: options);
  }

  /// Admin: irreversibly finalize (anonymise + soft-delete) a specific account
  /// that is past its grace period. Confirm-gated in the dashboard.
  $grpc.ResponseFuture<$0.AdminAccountDeletionActionResponse>
      adminFinalizeAccountDeletion(
    $0.AdminAccountDeletionActionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminFinalizeAccountDeletion, request,
        options: options);
  }

  /// Admin: reactivate an account still in the deletion lifecycle (restore).
  $grpc.ResponseFuture<$0.AdminAccountDeletionActionResponse>
      adminReactivateAccount(
    $0.AdminAccountDeletionActionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminReactivateAccount, request,
        options: options);
  }

  /// ===== Account self-lock (Settings → Security) =====
  /// Arm a user-initiated login + transaction lock for a timeframe (JWT-identified).
  /// No early unlock — it elapses. Blocks login (after creds, before 2FA) AND
  /// money movement (accounts-service gates debits/holds on the same window).
  $grpc.ResponseFuture<$0.RequestAccountLockResponse> requestAccountLock(
    $0.RequestAccountLockRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestAccountLock, request, options: options);
  }

  // method descriptors

  static final _$signup =
      $grpc.ClientMethod<$0.SignupRequest, $0.SignupResponse>(
          '/pb.AuthService/Signup',
          ($0.SignupRequest value) => value.writeToBuffer(),
          $0.SignupResponse.fromBuffer);
  static final _$login = $grpc.ClientMethod<$0.LoginRequest, $0.LoginResponse>(
      '/pb.AuthService/Login',
      ($0.LoginRequest value) => value.writeToBuffer(),
      $0.LoginResponse.fromBuffer);
  static final _$refreshToken =
      $grpc.ClientMethod<$0.RefreshTokenRequest, $0.RefreshTokenResponse>(
          '/pb.AuthService/RefreshToken',
          ($0.RefreshTokenRequest value) => value.writeToBuffer(),
          $0.RefreshTokenResponse.fromBuffer);
  static final _$logout =
      $grpc.ClientMethod<$0.LogoutRequest, $0.LogoutResponse>(
          '/pb.AuthService/Logout',
          ($0.LogoutRequest value) => value.writeToBuffer(),
          $0.LogoutResponse.fromBuffer);
  static final _$verifyEmail =
      $grpc.ClientMethod<$0.VerifyEmailRequest, $0.VerifyEmailResponse>(
          '/pb.AuthService/VerifyEmail',
          ($0.VerifyEmailRequest value) => value.writeToBuffer(),
          $0.VerifyEmailResponse.fromBuffer);
  static final _$verifyPhone =
      $grpc.ClientMethod<$0.VerifyPhoneRequest, $0.VerifyPhoneResponse>(
          '/pb.AuthService/VerifyPhone',
          ($0.VerifyPhoneRequest value) => value.writeToBuffer(),
          $0.VerifyPhoneResponse.fromBuffer);
  static final _$forgotPassword =
      $grpc.ClientMethod<$0.ForgotPasswordRequest, $0.ForgotPasswordResponse>(
          '/pb.AuthService/ForgotPassword',
          ($0.ForgotPasswordRequest value) => value.writeToBuffer(),
          $0.ForgotPasswordResponse.fromBuffer);
  static final _$verifyPasswordResetCode = $grpc.ClientMethod<
          $0.VerifyPasswordResetCodeRequest,
          $0.VerifyPasswordResetCodeResponse>(
      '/pb.AuthService/VerifyPasswordResetCode',
      ($0.VerifyPasswordResetCodeRequest value) => value.writeToBuffer(),
      $0.VerifyPasswordResetCodeResponse.fromBuffer);
  static final _$resetPassword =
      $grpc.ClientMethod<$0.ResetPasswordRequest, $0.ResetPasswordResponse>(
          '/pb.AuthService/ResetPassword',
          ($0.ResetPasswordRequest value) => value.writeToBuffer(),
          $0.ResetPasswordResponse.fromBuffer);
  static final _$getMe = $grpc.ClientMethod<$0.GetMeRequest, $0.GetMeResponse>(
      '/pb.AuthService/GetMe',
      ($0.GetMeRequest value) => value.writeToBuffer(),
      $0.GetMeResponse.fromBuffer);
  static final _$updateProfile =
      $grpc.ClientMethod<$0.UpdateProfileRequest, $0.UpdateProfileResponse>(
          '/pb.AuthService/UpdateProfile',
          ($0.UpdateProfileRequest value) => value.writeToBuffer(),
          $0.UpdateProfileResponse.fromBuffer);
  static final _$facialLogin =
      $grpc.ClientMethod<$0.FacialLoginRequest, $0.FacialLoginResponse>(
          '/pb.AuthService/FacialLogin',
          ($0.FacialLoginRequest value) => value.writeToBuffer(),
          $0.FacialLoginResponse.fromBuffer);
  static final _$socialLogin =
      $grpc.ClientMethod<$0.SocialLoginRequest, $0.SocialLoginResponse>(
          '/pb.AuthService/SocialLogin',
          ($0.SocialLoginRequest value) => value.writeToBuffer(),
          $0.SocialLoginResponse.fromBuffer);
  static final _$enableTwoFactor =
      $grpc.ClientMethod<$0.EnableTwoFactorRequest, $0.EnableTwoFactorResponse>(
          '/pb.AuthService/EnableTwoFactor',
          ($0.EnableTwoFactorRequest value) => value.writeToBuffer(),
          $0.EnableTwoFactorResponse.fromBuffer);
  static final _$verifyTwoFactor =
      $grpc.ClientMethod<$0.VerifyTwoFactorRequest, $0.VerifyTwoFactorResponse>(
          '/pb.AuthService/VerifyTwoFactor',
          ($0.VerifyTwoFactorRequest value) => value.writeToBuffer(),
          $0.VerifyTwoFactorResponse.fromBuffer);
  static final _$completeTwoFactorSetup = $grpc.ClientMethod<
          $0.CompleteTwoFactorSetupRequest, $0.CompleteTwoFactorSetupResponse>(
      '/pb.AuthService/CompleteTwoFactorSetup',
      ($0.CompleteTwoFactorSetupRequest value) => value.writeToBuffer(),
      $0.CompleteTwoFactorSetupResponse.fromBuffer);
  static final _$disableTwoFactor = $grpc.ClientMethod<
          $0.DisableTwoFactorRequest, $0.DisableTwoFactorResponse>(
      '/pb.AuthService/DisableTwoFactor',
      ($0.DisableTwoFactorRequest value) => value.writeToBuffer(),
      $0.DisableTwoFactorResponse.fromBuffer);
  static final _$getTwoFactorStatus = $grpc.ClientMethod<
          $0.GetTwoFactorStatusRequest, $0.GetTwoFactorStatusResponse>(
      '/pb.AuthService/GetTwoFactorStatus',
      ($0.GetTwoFactorStatusRequest value) => value.writeToBuffer(),
      $0.GetTwoFactorStatusResponse.fromBuffer);
  static final _$regenerateBackupCodes = $grpc.ClientMethod<
          $0.RegenerateBackupCodesRequest, $0.RegenerateBackupCodesResponse>(
      '/pb.AuthService/RegenerateBackupCodes',
      ($0.RegenerateBackupCodesRequest value) => value.writeToBuffer(),
      $0.RegenerateBackupCodesResponse.fromBuffer);
  static final _$sendTwoFactorCode = $grpc.ClientMethod<
          $0.SendTwoFactorCodeRequest, $0.SendTwoFactorCodeResponse>(
      '/pb.AuthService/SendTwoFactorCode',
      ($0.SendTwoFactorCodeRequest value) => value.writeToBuffer(),
      $0.SendTwoFactorCodeResponse.fromBuffer);
  static final _$getAvailable2FAMethods = $grpc.ClientMethod<
          $0.GetAvailable2FAMethodsRequest, $0.GetAvailable2FAMethodsResponse>(
      '/pb.AuthService/GetAvailable2FAMethods',
      ($0.GetAvailable2FAMethodsRequest value) => value.writeToBuffer(),
      $0.GetAvailable2FAMethodsResponse.fromBuffer);
  static final _$validateToken =
      $grpc.ClientMethod<$0.ValidateTokenRequest, $0.ValidateTokenResponse>(
          '/pb.AuthService/ValidateToken',
          ($0.ValidateTokenRequest value) => value.writeToBuffer(),
          $0.ValidateTokenResponse.fromBuffer);
  static final _$resendVerificationEmail = $grpc.ClientMethod<
          $0.ResendVerificationEmailRequest,
          $0.ResendVerificationEmailResponse>(
      '/pb.AuthService/ResendVerificationEmail',
      ($0.ResendVerificationEmailRequest value) => value.writeToBuffer(),
      $0.ResendVerificationEmailResponse.fromBuffer);
  static final _$resendPhoneVerification = $grpc.ClientMethod<
          $0.ResendPhoneVerificationRequest,
          $0.ResendPhoneVerificationResponse>(
      '/pb.AuthService/ResendPhoneVerification',
      ($0.ResendPhoneVerificationRequest value) => value.writeToBuffer(),
      $0.ResendPhoneVerificationResponse.fromBuffer);
  static final _$changePassword =
      $grpc.ClientMethod<$0.ChangePasswordRequest, $0.ChangePasswordResponse>(
          '/pb.AuthService/ChangePassword',
          ($0.ChangePasswordRequest value) => value.writeToBuffer(),
          $0.ChangePasswordResponse.fromBuffer);
  static final _$channelLogin =
      $grpc.ClientMethod<$0.ChannelLoginRequest, $0.ChannelLoginResponse>(
          '/pb.AuthService/ChannelLogin',
          ($0.ChannelLoginRequest value) => value.writeToBuffer(),
          $0.ChannelLoginResponse.fromBuffer);
  static final _$channelRegister =
      $grpc.ClientMethod<$0.ChannelRegisterRequest, $0.ChannelRegisterResponse>(
          '/pb.AuthService/ChannelRegister',
          ($0.ChannelRegisterRequest value) => value.writeToBuffer(),
          $0.ChannelRegisterResponse.fromBuffer);
  static final _$channelVerifyRegistration = $grpc.ClientMethod<
          $0.ChannelVerifyRegistrationRequest,
          $0.ChannelVerifyRegistrationResponse>(
      '/pb.AuthService/ChannelVerifyRegistration',
      ($0.ChannelVerifyRegistrationRequest value) => value.writeToBuffer(),
      $0.ChannelVerifyRegistrationResponse.fromBuffer);
  static final _$adminGenerateTokenByPhone = $grpc.ClientMethod<
          $0.AdminGenerateTokenByPhoneRequest,
          $0.AdminGenerateTokenByPhoneResponse>(
      '/pb.AuthService/AdminGenerateTokenByPhone',
      ($0.AdminGenerateTokenByPhoneRequest value) => value.writeToBuffer(),
      $0.AdminGenerateTokenByPhoneResponse.fromBuffer);
  static final _$loginWithPasscode =
      $grpc.ClientMethod<$0.LoginWithPasscodeRequest, $0.LoginResponse>(
          '/pb.AuthService/LoginWithPasscode',
          ($0.LoginWithPasscodeRequest value) => value.writeToBuffer(),
          $0.LoginResponse.fromBuffer);
  static final _$verifyLoginOtp =
      $grpc.ClientMethod<$0.VerifyLoginOtpRequest, $0.LoginResponse>(
          '/pb.AuthService/VerifyLoginOtp',
          ($0.VerifyLoginOtpRequest value) => value.writeToBuffer(),
          $0.LoginResponse.fromBuffer);
  static final _$registerPasscode = $grpc.ClientMethod<
          $0.RegisterPasscodeRequest, $0.RegisterPasscodeResponse>(
      '/pb.AuthService/RegisterPasscode',
      ($0.RegisterPasscodeRequest value) => value.writeToBuffer(),
      $0.RegisterPasscodeResponse.fromBuffer);
  static final _$changePasscode =
      $grpc.ClientMethod<$0.ChangePasscodeRequest, $0.ChangePasscodeResponse>(
          '/pb.AuthService/ChangePasscode',
          ($0.ChangePasscodeRequest value) => value.writeToBuffer(),
          $0.ChangePasscodeResponse.fromBuffer);
  static final _$updateDevicePermissions = $grpc.ClientMethod<
          $0.AuthUpdateDevicePermissionsRequest,
          $0.AuthUpdateDevicePermissionsResponse>(
      '/pb.AuthService/UpdateDevicePermissions',
      ($0.AuthUpdateDevicePermissionsRequest value) => value.writeToBuffer(),
      $0.AuthUpdateDevicePermissionsResponse.fromBuffer);
  static final _$getDevicePermissions = $grpc.ClientMethod<
          $0.AuthGetDevicePermissionsRequest,
          $0.AuthGetDevicePermissionsResponse>(
      '/pb.AuthService/GetDevicePermissions',
      ($0.AuthGetDevicePermissionsRequest value) => value.writeToBuffer(),
      $0.AuthGetDevicePermissionsResponse.fromBuffer);
  static final _$verifyPasscode =
      $grpc.ClientMethod<$0.VerifyPasscodeRequest, $0.VerifyPasscodeResponse>(
          '/pb.AuthService/VerifyPasscode',
          ($0.VerifyPasscodeRequest value) => value.writeToBuffer(),
          $0.VerifyPasscodeResponse.fromBuffer);
  static final _$requestPasswordReset = $grpc.ClientMethod<
          $0.RequestPasswordResetRequest, $0.RequestPasswordResetResponse>(
      '/pb.AuthService/RequestPasswordReset',
      ($0.RequestPasswordResetRequest value) => value.writeToBuffer(),
      $0.RequestPasswordResetResponse.fromBuffer);
  static final _$requestEmailVerification = $grpc.ClientMethod<
          $0.RequestEmailVerificationRequest,
          $0.RequestEmailVerificationResponse>(
      '/pb.AuthService/RequestEmailVerification',
      ($0.RequestEmailVerificationRequest value) => value.writeToBuffer(),
      $0.RequestEmailVerificationResponse.fromBuffer);
  static final _$checkEmailAvailability = $grpc.ClientMethod<
          $0.CheckEmailAvailabilityRequest, $0.CheckEmailAvailabilityResponse>(
      '/pb.AuthService/CheckEmailAvailability',
      ($0.CheckEmailAvailabilityRequest value) => value.writeToBuffer(),
      $0.CheckEmailAvailabilityResponse.fromBuffer);
  static final _$requestPhoneVerification = $grpc.ClientMethod<
          $0.RequestPhoneVerificationRequest,
          $0.RequestPhoneVerificationResponse>(
      '/pb.AuthService/RequestPhoneVerification',
      ($0.RequestPhoneVerificationRequest value) => value.writeToBuffer(),
      $0.RequestPhoneVerificationResponse.fromBuffer);
  static final _$verifyPhoneNumber = $grpc.ClientMethod<
          $0.VerifyPhoneNumberRequest, $0.VerifyPhoneNumberResponse>(
      '/pb.AuthService/VerifyPhoneNumber',
      ($0.VerifyPhoneNumberRequest value) => value.writeToBuffer(),
      $0.VerifyPhoneNumberResponse.fromBuffer);
  static final _$getSignupProgress = $grpc.ClientMethod<
          $0.GetSignupProgressRequest, $0.GetSignupProgressResponse>(
      '/pb.AuthService/GetSignupProgress',
      ($0.GetSignupProgressRequest value) => value.writeToBuffer(),
      $0.GetSignupProgressResponse.fromBuffer);
  static final _$updateSignupStep = $grpc.ClientMethod<
          $0.UpdateSignupStepRequest, $0.UpdateSignupStepResponse>(
      '/pb.AuthService/UpdateSignupStep',
      ($0.UpdateSignupStepRequest value) => value.writeToBuffer(),
      $0.UpdateSignupStepResponse.fromBuffer);
  static final _$completeSignup =
      $grpc.ClientMethod<$0.CompleteSignupRequest, $0.CompleteSignupResponse>(
          '/pb.AuthService/CompleteSignup',
          ($0.CompleteSignupRequest value) => value.writeToBuffer(),
          $0.CompleteSignupResponse.fromBuffer);
  static final _$verifyIdentity =
      $grpc.ClientMethod<$0.VerifyIdentityRequest, $0.VerifyIdentityResponse>(
          '/pb.AuthService/VerifyIdentity',
          ($0.VerifyIdentityRequest value) => value.writeToBuffer(),
          $0.VerifyIdentityResponse.fromBuffer);
  static final _$getIdentityVerificationStatus = $grpc.ClientMethod<
          $0.GetIdentityVerificationStatusRequest,
          $0.GetIdentityVerificationStatusResponse>(
      '/pb.AuthService/GetIdentityVerificationStatus',
      ($0.GetIdentityVerificationStatusRequest value) => value.writeToBuffer(),
      $0.GetIdentityVerificationStatusResponse.fromBuffer);
  static final _$initiateKYC =
      $grpc.ClientMethod<$0.InitiateKYCRequest, $0.InitiateKYCResponse>(
          '/pb.AuthService/InitiateKYC',
          ($0.InitiateKYCRequest value) => value.writeToBuffer(),
          $0.InitiateKYCResponse.fromBuffer);
  static final _$uploadDocument =
      $grpc.ClientMethod<$0.UploadDocumentRequest, $0.UploadDocumentResponse>(
          '/pb.AuthService/UploadDocument',
          ($0.UploadDocumentRequest value) => value.writeToBuffer(),
          $0.UploadDocumentResponse.fromBuffer);
  static final _$skipKYCUpgrade =
      $grpc.ClientMethod<$0.SkipKYCUpgradeRequest, $0.SkipKYCUpgradeResponse>(
          '/pb.AuthService/SkipKYCUpgrade',
          ($0.SkipKYCUpgradeRequest value) => value.writeToBuffer(),
          $0.SkipKYCUpgradeResponse.fromBuffer);
  static final _$syncVerifiedKYCTier = $grpc.ClientMethod<
          $0.SyncVerifiedKYCTierRequest, $0.SyncVerifiedKYCTierResponse>(
      '/pb.AuthService/SyncVerifiedKYCTier',
      ($0.SyncVerifiedKYCTierRequest value) => value.writeToBuffer(),
      $0.SyncVerifiedKYCTierResponse.fromBuffer);
  static final _$adminOverrideKYCTier = $grpc.ClientMethod<
          $0.AdminOverrideKYCTierRequest, $0.AdminOverrideKYCTierResponse>(
      '/pb.AuthService/AdminOverrideKYCTier',
      ($0.AdminOverrideKYCTierRequest value) => value.writeToBuffer(),
      $0.AdminOverrideKYCTierResponse.fromBuffer);
  static final _$adminResetTransactionPin = $grpc.ClientMethod<
          $0.AdminResetTransactionPinRequest,
          $0.AdminResetTransactionPinResponse>(
      '/pb.AuthService/AdminResetTransactionPin',
      ($0.AdminResetTransactionPinRequest value) => value.writeToBuffer(),
      $0.AdminResetTransactionPinResponse.fromBuffer);
  static final _$getKYCTier =
      $grpc.ClientMethod<$0.GetKYCTierRequest, $0.GetKYCTierResponse>(
          '/pb.AuthService/GetKYCTier',
          ($0.GetKYCTierRequest value) => value.writeToBuffer(),
          $0.GetKYCTierResponse.fromBuffer);
  static final _$getUserIdentityForService = $grpc.ClientMethod<
          $0.GetUserIdentityForServiceRequest,
          $0.GetUserIdentityForServiceResponse>(
      '/pb.AuthService/GetUserIdentityForService',
      ($0.GetUserIdentityForServiceRequest value) => value.writeToBuffer(),
      $0.GetUserIdentityForServiceResponse.fromBuffer);
  static final _$markEmailBouncedByEmail = $grpc.ClientMethod<
          $0.MarkEmailBouncedByEmailRequest,
          $0.MarkEmailBouncedByEmailResponse>(
      '/pb.AuthService/MarkEmailBouncedByEmail',
      ($0.MarkEmailBouncedByEmailRequest value) => value.writeToBuffer(),
      $0.MarkEmailBouncedByEmailResponse.fromBuffer);
  static final _$getMyInsurancePrefill = $grpc.ClientMethod<
          $0.GetMyInsurancePrefillRequest, $0.GetMyInsurancePrefillResponse>(
      '/pb.AuthService/GetMyInsurancePrefill',
      ($0.GetMyInsurancePrefillRequest value) => value.writeToBuffer(),
      $0.GetMyInsurancePrefillResponse.fromBuffer);
  static final _$getUserDocuments = $grpc.ClientMethod<
          $0.GetUserDocumentsRequest, $0.GetUserDocumentsResponse>(
      '/pb.AuthService/GetUserDocuments',
      ($0.GetUserDocumentsRequest value) => value.writeToBuffer(),
      $0.GetUserDocumentsResponse.fromBuffer);
  static final _$getKYCStatus =
      $grpc.ClientMethod<$0.GetKYCStatusRequest, $0.GetKYCStatusResponse>(
          '/pb.AuthService/GetKYCStatus',
          ($0.GetKYCStatusRequest value) => value.writeToBuffer(),
          $0.GetKYCStatusResponse.fromBuffer);
  static final _$getCountryRequirements = $grpc.ClientMethod<
          $0.GetCountryRequirementsRequest, $0.GetCountryRequirementsResponse>(
      '/pb.AuthService/GetCountryRequirements',
      ($0.GetCountryRequirementsRequest value) => value.writeToBuffer(),
      $0.GetCountryRequirementsResponse.fromBuffer);
  static final _$createVerificationSession = $grpc.ClientMethod<
          $0.CreateVerificationSessionRequest,
          $0.CreateVerificationSessionResponse>(
      '/pb.AuthService/CreateVerificationSession',
      ($0.CreateVerificationSessionRequest value) => value.writeToBuffer(),
      $0.CreateVerificationSessionResponse.fromBuffer);
  static final _$confirmVerification = $grpc.ClientMethod<
          $0.ConfirmVerificationRequest, $0.ConfirmVerificationResponse>(
      '/pb.AuthService/ConfirmVerification',
      ($0.ConfirmVerificationRequest value) => value.writeToBuffer(),
      $0.ConfirmVerificationResponse.fromBuffer);
  static final _$getDocumentUploadURL = $grpc.ClientMethod<
          $0.GetDocumentUploadURLRequest, $0.GetDocumentUploadURLResponse>(
      '/pb.AuthService/GetDocumentUploadURL',
      ($0.GetDocumentUploadURLRequest value) => value.writeToBuffer(),
      $0.GetDocumentUploadURLResponse.fromBuffer);
  static final _$submitDocumentsForReview = $grpc.ClientMethod<
          $0.SubmitDocumentsForReviewRequest,
          $0.SubmitDocumentsForReviewResponse>(
      '/pb.AuthService/SubmitDocumentsForReview',
      ($0.SubmitDocumentsForReviewRequest value) => value.writeToBuffer(),
      $0.SubmitDocumentsForReviewResponse.fromBuffer);
  static final _$confirmBVNName =
      $grpc.ClientMethod<$0.ConfirmBVNNameRequest, $0.ConfirmBVNNameResponse>(
          '/pb.AuthService/ConfirmBVNName',
          ($0.ConfirmBVNNameRequest value) => value.writeToBuffer(),
          $0.ConfirmBVNNameResponse.fromBuffer);
  static final _$lookupUserByUsername =
      $grpc.ClientMethod<$0.LookupUserByUsernameRequest, $0.UserLookupResponse>(
          '/pb.AuthService/LookupUserByUsername',
          ($0.LookupUserByUsernameRequest value) => value.writeToBuffer(),
          $0.UserLookupResponse.fromBuffer);
  static final _$lookupUserByPhone =
      $grpc.ClientMethod<$0.LookupUserByPhoneRequest, $0.UserLookupResponse>(
          '/pb.AuthService/LookupUserByPhone',
          ($0.LookupUserByPhoneRequest value) => value.writeToBuffer(),
          $0.UserLookupResponse.fromBuffer);
  static final _$searchUsers =
      $grpc.ClientMethod<$0.UserSearchRequest, $0.UserSearchResponse>(
          '/pb.AuthService/SearchUsers',
          ($0.UserSearchRequest value) => value.writeToBuffer(),
          $0.UserSearchResponse.fromBuffer);
  static final _$getLinkedSocialAccounts = $grpc.ClientMethod<
          $0.GetLinkedSocialAccountsRequest,
          $0.GetLinkedSocialAccountsResponse>(
      '/pb.AuthService/GetLinkedSocialAccounts',
      ($0.GetLinkedSocialAccountsRequest value) => value.writeToBuffer(),
      $0.GetLinkedSocialAccountsResponse.fromBuffer);
  static final _$linkSocialAccount = $grpc.ClientMethod<
          $0.LinkSocialAccountRequest, $0.LinkSocialAccountResponse>(
      '/pb.AuthService/LinkSocialAccount',
      ($0.LinkSocialAccountRequest value) => value.writeToBuffer(),
      $0.LinkSocialAccountResponse.fromBuffer);
  static final _$unlinkSocialAccount = $grpc.ClientMethod<
          $0.UnlinkSocialAccountRequest, $0.UnlinkSocialAccountResponse>(
      '/pb.AuthService/UnlinkSocialAccount',
      ($0.UnlinkSocialAccountRequest value) => value.writeToBuffer(),
      $0.UnlinkSocialAccountResponse.fromBuffer);
  static final _$setPrimarySocialAccount = $grpc.ClientMethod<
          $0.SetPrimarySocialAccountRequest,
          $0.SetPrimarySocialAccountResponse>(
      '/pb.AuthService/SetPrimarySocialAccount',
      ($0.SetPrimarySocialAccountRequest value) => value.writeToBuffer(),
      $0.SetPrimarySocialAccountResponse.fromBuffer);
  static final _$reauthorizeSocialAccount = $grpc.ClientMethod<
          $0.ReauthorizeSocialAccountRequest,
          $0.ReauthorizeSocialAccountResponse>(
      '/pb.AuthService/ReauthorizeSocialAccount',
      ($0.ReauthorizeSocialAccountRequest value) => value.writeToBuffer(),
      $0.ReauthorizeSocialAccountResponse.fromBuffer);
  static final _$getAuthenticationConfig = $grpc.ClientMethod<
          $0.GetAuthenticationConfigRequest,
          $0.GetAuthenticationConfigResponse>(
      '/pb.AuthService/GetAuthenticationConfig',
      ($0.GetAuthenticationConfigRequest value) => value.writeToBuffer(),
      $0.GetAuthenticationConfigResponse.fromBuffer);
  static final _$requestSignupPhoneOTP = $grpc.ClientMethod<
          $0.RequestSignupPhoneOTPRequest, $0.RequestSignupPhoneOTPResponse>(
      '/pb.AuthService/RequestSignupPhoneOTP',
      ($0.RequestSignupPhoneOTPRequest value) => value.writeToBuffer(),
      $0.RequestSignupPhoneOTPResponse.fromBuffer);
  static final _$verifySignupPhoneOTP = $grpc.ClientMethod<
          $0.VerifySignupPhoneOTPRequest, $0.VerifySignupPhoneOTPResponse>(
      '/pb.AuthService/VerifySignupPhoneOTP',
      ($0.VerifySignupPhoneOTPRequest value) => value.writeToBuffer(),
      $0.VerifySignupPhoneOTPResponse.fromBuffer);
  static final _$signupWithPhone =
      $grpc.ClientMethod<$0.SignupWithPhoneRequest, $0.LoginResponse>(
          '/pb.AuthService/SignupWithPhone',
          ($0.SignupWithPhoneRequest value) => value.writeToBuffer(),
          $0.LoginResponse.fromBuffer);
  static final _$loginWithPhonePasscode =
      $grpc.ClientMethod<$0.LoginWithPhonePasscodeRequest, $0.LoginResponse>(
          '/pb.AuthService/LoginWithPhonePasscode',
          ($0.LoginWithPhonePasscodeRequest value) => value.writeToBuffer(),
          $0.LoginResponse.fromBuffer);
  static final _$requestPasscodeReset = $grpc.ClientMethod<
          $0.RequestPasscodeResetRequest, $0.RequestPasscodeResetResponse>(
      '/pb.AuthService/RequestPasscodeReset',
      ($0.RequestPasscodeResetRequest value) => value.writeToBuffer(),
      $0.RequestPasscodeResetResponse.fromBuffer);
  static final _$verifyPasscodeResetOTP = $grpc.ClientMethod<
          $0.VerifyPasscodeResetOTPRequest, $0.VerifyPasscodeResetOTPResponse>(
      '/pb.AuthService/VerifyPasscodeResetOTP',
      ($0.VerifyPasscodeResetOTPRequest value) => value.writeToBuffer(),
      $0.VerifyPasscodeResetOTPResponse.fromBuffer);
  static final _$resetPasscodeWithOTP = $grpc.ClientMethod<
          $0.ResetPasscodeWithOTPRequest, $0.ResetPasscodeWithOTPResponse>(
      '/pb.AuthService/ResetPasscodeWithOTP',
      ($0.ResetPasscodeWithOTPRequest value) => value.writeToBuffer(),
      $0.ResetPasscodeWithOTPResponse.fromBuffer);
  static final _$setPreferredLoginMethod = $grpc.ClientMethod<
          $0.SetPreferredLoginMethodRequest,
          $0.SetPreferredLoginMethodResponse>(
      '/pb.AuthService/SetPreferredLoginMethod',
      ($0.SetPreferredLoginMethodRequest value) => value.writeToBuffer(),
      $0.SetPreferredLoginMethodResponse.fromBuffer);
  static final _$setPassword =
      $grpc.ClientMethod<$0.SetPasswordRequest, $0.SetPasswordResponse>(
          '/pb.AuthService/SetPassword',
          ($0.SetPasswordRequest value) => value.writeToBuffer(),
          $0.SetPasswordResponse.fromBuffer);
  static final _$adminSetPreferredLoginMethod = $grpc.ClientMethod<
          $0.AdminSetPreferredLoginMethodRequest,
          $0.SetPreferredLoginMethodResponse>(
      '/pb.AuthService/AdminSetPreferredLoginMethod',
      ($0.AdminSetPreferredLoginMethodRequest value) => value.writeToBuffer(),
      $0.SetPreferredLoginMethodResponse.fromBuffer);
  static final _$requestPhoneChange = $grpc.ClientMethod<
          $0.RequestPhoneChangeRequest, $0.RequestPhoneChangeResponse>(
      '/pb.AuthService/RequestPhoneChange',
      ($0.RequestPhoneChangeRequest value) => value.writeToBuffer(),
      $0.RequestPhoneChangeResponse.fromBuffer);
  static final _$verifyPhoneChange = $grpc.ClientMethod<
          $0.VerifyPhoneChangeRequest, $0.VerifyPhoneChangeResponse>(
      '/pb.AuthService/VerifyPhoneChange',
      ($0.VerifyPhoneChangeRequest value) => value.writeToBuffer(),
      $0.VerifyPhoneChangeResponse.fromBuffer);
  static final _$registerDevice =
      $grpc.ClientMethod<$0.RegisterDeviceRequest, $0.RegisterDeviceResponse>(
          '/pb.AuthService/RegisterDevice',
          ($0.RegisterDeviceRequest value) => value.writeToBuffer(),
          $0.RegisterDeviceResponse.fromBuffer);
  static final _$listDevices =
      $grpc.ClientMethod<$0.ListDevicesRequest, $0.ListDevicesResponse>(
          '/pb.AuthService/ListDevices',
          ($0.ListDevicesRequest value) => value.writeToBuffer(),
          $0.ListDevicesResponse.fromBuffer);
  static final _$revokeDevice =
      $grpc.ClientMethod<$0.RevokeDeviceRequest, $0.RevokeDeviceResponse>(
          '/pb.AuthService/RevokeDevice',
          ($0.RevokeDeviceRequest value) => value.writeToBuffer(),
          $0.RevokeDeviceResponse.fromBuffer);
  static final _$getLoginHistory =
      $grpc.ClientMethod<$0.GetLoginHistoryRequest, $0.GetLoginHistoryResponse>(
          '/pb.AuthService/GetLoginHistory',
          ($0.GetLoginHistoryRequest value) => value.writeToBuffer(),
          $0.GetLoginHistoryResponse.fromBuffer);
  static final _$requestAccountDeletion = $grpc.ClientMethod<
          $0.RequestAccountDeletionRequest, $0.RequestAccountDeletionResponse>(
      '/pb.AuthService/RequestAccountDeletion',
      ($0.RequestAccountDeletionRequest value) => value.writeToBuffer(),
      $0.RequestAccountDeletionResponse.fromBuffer);
  static final _$cancelAccountDeletion = $grpc.ClientMethod<
          $0.CancelAccountDeletionRequest, $0.CancelAccountDeletionResponse>(
      '/pb.AuthService/CancelAccountDeletion',
      ($0.CancelAccountDeletionRequest value) => value.writeToBuffer(),
      $0.CancelAccountDeletionResponse.fromBuffer);
  static final _$listDeletionAccounts = $grpc.ClientMethod<
          $0.ListDeletionAccountsRequest, $0.ListDeletionAccountsResponse>(
      '/pb.AuthService/ListDeletionAccounts',
      ($0.ListDeletionAccountsRequest value) => value.writeToBuffer(),
      $0.ListDeletionAccountsResponse.fromBuffer);
  static final _$adminFinalizeAccountDeletion = $grpc.ClientMethod<
          $0.AdminAccountDeletionActionRequest,
          $0.AdminAccountDeletionActionResponse>(
      '/pb.AuthService/AdminFinalizeAccountDeletion',
      ($0.AdminAccountDeletionActionRequest value) => value.writeToBuffer(),
      $0.AdminAccountDeletionActionResponse.fromBuffer);
  static final _$adminReactivateAccount = $grpc.ClientMethod<
          $0.AdminAccountDeletionActionRequest,
          $0.AdminAccountDeletionActionResponse>(
      '/pb.AuthService/AdminReactivateAccount',
      ($0.AdminAccountDeletionActionRequest value) => value.writeToBuffer(),
      $0.AdminAccountDeletionActionResponse.fromBuffer);
  static final _$requestAccountLock = $grpc.ClientMethod<
          $0.RequestAccountLockRequest, $0.RequestAccountLockResponse>(
      '/pb.AuthService/RequestAccountLock',
      ($0.RequestAccountLockRequest value) => value.writeToBuffer(),
      $0.RequestAccountLockResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SignupRequest, $0.SignupResponse>(
        'Signup',
        signup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignupRequest.fromBuffer(value),
        ($0.SignupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LoginRequest, $0.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RefreshTokenRequest, $0.RefreshTokenResponse>(
            'RefreshToken',
            refreshToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RefreshTokenRequest.fromBuffer(value),
            ($0.RefreshTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LogoutRequest, $0.LogoutResponse>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LogoutRequest.fromBuffer(value),
        ($0.LogoutResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.VerifyEmailRequest, $0.VerifyEmailResponse>(
            'VerifyEmail',
            verifyEmail_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.VerifyEmailRequest.fromBuffer(value),
            ($0.VerifyEmailResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.VerifyPhoneRequest, $0.VerifyPhoneResponse>(
            'VerifyPhone',
            verifyPhone_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.VerifyPhoneRequest.fromBuffer(value),
            ($0.VerifyPhoneResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ForgotPasswordRequest,
            $0.ForgotPasswordResponse>(
        'ForgotPassword',
        forgotPassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ForgotPasswordRequest.fromBuffer(value),
        ($0.ForgotPasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyPasswordResetCodeRequest,
            $0.VerifyPasswordResetCodeResponse>(
        'VerifyPasswordResetCode',
        verifyPasswordResetCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyPasswordResetCodeRequest.fromBuffer(value),
        ($0.VerifyPasswordResetCodeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ResetPasswordRequest, $0.ResetPasswordResponse>(
            'ResetPassword',
            resetPassword_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ResetPasswordRequest.fromBuffer(value),
            ($0.ResetPasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMeRequest, $0.GetMeResponse>(
        'GetMe',
        getMe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMeRequest.fromBuffer(value),
        ($0.GetMeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UpdateProfileRequest, $0.UpdateProfileResponse>(
            'UpdateProfile',
            updateProfile_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UpdateProfileRequest.fromBuffer(value),
            ($0.UpdateProfileResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.FacialLoginRequest, $0.FacialLoginResponse>(
            'FacialLogin',
            facialLogin_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.FacialLoginRequest.fromBuffer(value),
            ($0.FacialLoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SocialLoginRequest, $0.SocialLoginResponse>(
            'SocialLogin',
            socialLogin_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SocialLoginRequest.fromBuffer(value),
            ($0.SocialLoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EnableTwoFactorRequest,
            $0.EnableTwoFactorResponse>(
        'EnableTwoFactor',
        enableTwoFactor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.EnableTwoFactorRequest.fromBuffer(value),
        ($0.EnableTwoFactorResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyTwoFactorRequest,
            $0.VerifyTwoFactorResponse>(
        'VerifyTwoFactor',
        verifyTwoFactor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyTwoFactorRequest.fromBuffer(value),
        ($0.VerifyTwoFactorResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompleteTwoFactorSetupRequest,
            $0.CompleteTwoFactorSetupResponse>(
        'CompleteTwoFactorSetup',
        completeTwoFactorSetup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CompleteTwoFactorSetupRequest.fromBuffer(value),
        ($0.CompleteTwoFactorSetupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DisableTwoFactorRequest,
            $0.DisableTwoFactorResponse>(
        'DisableTwoFactor',
        disableTwoFactor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DisableTwoFactorRequest.fromBuffer(value),
        ($0.DisableTwoFactorResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTwoFactorStatusRequest,
            $0.GetTwoFactorStatusResponse>(
        'GetTwoFactorStatus',
        getTwoFactorStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTwoFactorStatusRequest.fromBuffer(value),
        ($0.GetTwoFactorStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegenerateBackupCodesRequest,
            $0.RegenerateBackupCodesResponse>(
        'RegenerateBackupCodes',
        regenerateBackupCodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RegenerateBackupCodesRequest.fromBuffer(value),
        ($0.RegenerateBackupCodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendTwoFactorCodeRequest,
            $0.SendTwoFactorCodeResponse>(
        'SendTwoFactorCode',
        sendTwoFactorCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendTwoFactorCodeRequest.fromBuffer(value),
        ($0.SendTwoFactorCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAvailable2FAMethodsRequest,
            $0.GetAvailable2FAMethodsResponse>(
        'GetAvailable2FAMethods',
        getAvailable2FAMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAvailable2FAMethodsRequest.fromBuffer(value),
        ($0.GetAvailable2FAMethodsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ValidateTokenRequest, $0.ValidateTokenResponse>(
            'ValidateToken',
            validateToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ValidateTokenRequest.fromBuffer(value),
            ($0.ValidateTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResendVerificationEmailRequest,
            $0.ResendVerificationEmailResponse>(
        'ResendVerificationEmail',
        resendVerificationEmail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResendVerificationEmailRequest.fromBuffer(value),
        ($0.ResendVerificationEmailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResendPhoneVerificationRequest,
            $0.ResendPhoneVerificationResponse>(
        'ResendPhoneVerification',
        resendPhoneVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResendPhoneVerificationRequest.fromBuffer(value),
        ($0.ResendPhoneVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChangePasswordRequest,
            $0.ChangePasswordResponse>(
        'ChangePassword',
        changePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ChangePasswordRequest.fromBuffer(value),
        ($0.ChangePasswordResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ChannelLoginRequest, $0.ChannelLoginResponse>(
            'ChannelLogin',
            channelLogin_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ChannelLoginRequest.fromBuffer(value),
            ($0.ChannelLoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChannelRegisterRequest,
            $0.ChannelRegisterResponse>(
        'ChannelRegister',
        channelRegister_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ChannelRegisterRequest.fromBuffer(value),
        ($0.ChannelRegisterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChannelVerifyRegistrationRequest,
            $0.ChannelVerifyRegistrationResponse>(
        'ChannelVerifyRegistration',
        channelVerifyRegistration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ChannelVerifyRegistrationRequest.fromBuffer(value),
        ($0.ChannelVerifyRegistrationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGenerateTokenByPhoneRequest,
            $0.AdminGenerateTokenByPhoneResponse>(
        'AdminGenerateTokenByPhone',
        adminGenerateTokenByPhone_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminGenerateTokenByPhoneRequest.fromBuffer(value),
        ($0.AdminGenerateTokenByPhoneResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.LoginWithPasscodeRequest, $0.LoginResponse>(
            'LoginWithPasscode',
            loginWithPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.LoginWithPasscodeRequest.fromBuffer(value),
            ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyLoginOtpRequest, $0.LoginResponse>(
        'VerifyLoginOtp',
        verifyLoginOtp_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyLoginOtpRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegisterPasscodeRequest,
            $0.RegisterPasscodeResponse>(
        'RegisterPasscode',
        registerPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RegisterPasscodeRequest.fromBuffer(value),
        ($0.RegisterPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChangePasscodeRequest,
            $0.ChangePasscodeResponse>(
        'ChangePasscode',
        changePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ChangePasscodeRequest.fromBuffer(value),
        ($0.ChangePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AuthUpdateDevicePermissionsRequest,
            $0.AuthUpdateDevicePermissionsResponse>(
        'UpdateDevicePermissions',
        updateDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AuthUpdateDevicePermissionsRequest.fromBuffer(value),
        ($0.AuthUpdateDevicePermissionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AuthGetDevicePermissionsRequest,
            $0.AuthGetDevicePermissionsResponse>(
        'GetDevicePermissions',
        getDevicePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AuthGetDevicePermissionsRequest.fromBuffer(value),
        ($0.AuthGetDevicePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyPasscodeRequest,
            $0.VerifyPasscodeResponse>(
        'VerifyPasscode',
        verifyPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyPasscodeRequest.fromBuffer(value),
        ($0.VerifyPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestPasswordResetRequest,
            $0.RequestPasswordResetResponse>(
        'RequestPasswordReset',
        requestPasswordReset_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestPasswordResetRequest.fromBuffer(value),
        ($0.RequestPasswordResetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestEmailVerificationRequest,
            $0.RequestEmailVerificationResponse>(
        'RequestEmailVerification',
        requestEmailVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestEmailVerificationRequest.fromBuffer(value),
        ($0.RequestEmailVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckEmailAvailabilityRequest,
            $0.CheckEmailAvailabilityResponse>(
        'CheckEmailAvailability',
        checkEmailAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CheckEmailAvailabilityRequest.fromBuffer(value),
        ($0.CheckEmailAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestPhoneVerificationRequest,
            $0.RequestPhoneVerificationResponse>(
        'RequestPhoneVerification',
        requestPhoneVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestPhoneVerificationRequest.fromBuffer(value),
        ($0.RequestPhoneVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyPhoneNumberRequest,
            $0.VerifyPhoneNumberResponse>(
        'VerifyPhoneNumber',
        verifyPhoneNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyPhoneNumberRequest.fromBuffer(value),
        ($0.VerifyPhoneNumberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSignupProgressRequest,
            $0.GetSignupProgressResponse>(
        'GetSignupProgress',
        getSignupProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSignupProgressRequest.fromBuffer(value),
        ($0.GetSignupProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSignupStepRequest,
            $0.UpdateSignupStepResponse>(
        'UpdateSignupStep',
        updateSignupStep_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateSignupStepRequest.fromBuffer(value),
        ($0.UpdateSignupStepResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompleteSignupRequest,
            $0.CompleteSignupResponse>(
        'CompleteSignup',
        completeSignup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CompleteSignupRequest.fromBuffer(value),
        ($0.CompleteSignupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyIdentityRequest,
            $0.VerifyIdentityResponse>(
        'VerifyIdentity',
        verifyIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyIdentityRequest.fromBuffer(value),
        ($0.VerifyIdentityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIdentityVerificationStatusRequest,
            $0.GetIdentityVerificationStatusResponse>(
        'GetIdentityVerificationStatus',
        getIdentityVerificationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetIdentityVerificationStatusRequest.fromBuffer(value),
        ($0.GetIdentityVerificationStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.InitiateKYCRequest, $0.InitiateKYCResponse>(
            'InitiateKYC',
            initiateKYC_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.InitiateKYCRequest.fromBuffer(value),
            ($0.InitiateKYCResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadDocumentRequest,
            $0.UploadDocumentResponse>(
        'UploadDocument',
        uploadDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UploadDocumentRequest.fromBuffer(value),
        ($0.UploadDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SkipKYCUpgradeRequest,
            $0.SkipKYCUpgradeResponse>(
        'SkipKYCUpgrade',
        skipKYCUpgrade_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SkipKYCUpgradeRequest.fromBuffer(value),
        ($0.SkipKYCUpgradeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SyncVerifiedKYCTierRequest,
            $0.SyncVerifiedKYCTierResponse>(
        'SyncVerifiedKYCTier',
        syncVerifiedKYCTier_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SyncVerifiedKYCTierRequest.fromBuffer(value),
        ($0.SyncVerifiedKYCTierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminOverrideKYCTierRequest,
            $0.AdminOverrideKYCTierResponse>(
        'AdminOverrideKYCTier',
        adminOverrideKYCTier_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminOverrideKYCTierRequest.fromBuffer(value),
        ($0.AdminOverrideKYCTierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminResetTransactionPinRequest,
            $0.AdminResetTransactionPinResponse>(
        'AdminResetTransactionPin',
        adminResetTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminResetTransactionPinRequest.fromBuffer(value),
        ($0.AdminResetTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetKYCTierRequest, $0.GetKYCTierResponse>(
        'GetKYCTier',
        getKYCTier_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetKYCTierRequest.fromBuffer(value),
        ($0.GetKYCTierResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserIdentityForServiceRequest,
            $0.GetUserIdentityForServiceResponse>(
        'GetUserIdentityForService',
        getUserIdentityForService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserIdentityForServiceRequest.fromBuffer(value),
        ($0.GetUserIdentityForServiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkEmailBouncedByEmailRequest,
            $0.MarkEmailBouncedByEmailResponse>(
        'MarkEmailBouncedByEmail',
        markEmailBouncedByEmail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkEmailBouncedByEmailRequest.fromBuffer(value),
        ($0.MarkEmailBouncedByEmailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyInsurancePrefillRequest,
            $0.GetMyInsurancePrefillResponse>(
        'GetMyInsurancePrefill',
        getMyInsurancePrefill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyInsurancePrefillRequest.fromBuffer(value),
        ($0.GetMyInsurancePrefillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserDocumentsRequest,
            $0.GetUserDocumentsResponse>(
        'GetUserDocuments',
        getUserDocuments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserDocumentsRequest.fromBuffer(value),
        ($0.GetUserDocumentsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetKYCStatusRequest, $0.GetKYCStatusResponse>(
            'GetKYCStatus',
            getKYCStatus_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetKYCStatusRequest.fromBuffer(value),
            ($0.GetKYCStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCountryRequirementsRequest,
            $0.GetCountryRequirementsResponse>(
        'GetCountryRequirements',
        getCountryRequirements_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCountryRequirementsRequest.fromBuffer(value),
        ($0.GetCountryRequirementsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateVerificationSessionRequest,
            $0.CreateVerificationSessionResponse>(
        'CreateVerificationSession',
        createVerificationSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateVerificationSessionRequest.fromBuffer(value),
        ($0.CreateVerificationSessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConfirmVerificationRequest,
            $0.ConfirmVerificationResponse>(
        'ConfirmVerification',
        confirmVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ConfirmVerificationRequest.fromBuffer(value),
        ($0.ConfirmVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDocumentUploadURLRequest,
            $0.GetDocumentUploadURLResponse>(
        'GetDocumentUploadURL',
        getDocumentUploadURL_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDocumentUploadURLRequest.fromBuffer(value),
        ($0.GetDocumentUploadURLResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubmitDocumentsForReviewRequest,
            $0.SubmitDocumentsForReviewResponse>(
        'SubmitDocumentsForReview',
        submitDocumentsForReview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SubmitDocumentsForReviewRequest.fromBuffer(value),
        ($0.SubmitDocumentsForReviewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConfirmBVNNameRequest,
            $0.ConfirmBVNNameResponse>(
        'ConfirmBVNName',
        confirmBVNName_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ConfirmBVNNameRequest.fromBuffer(value),
        ($0.ConfirmBVNNameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LookupUserByUsernameRequest,
            $0.UserLookupResponse>(
        'LookupUserByUsername',
        lookupUserByUsername_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.LookupUserByUsernameRequest.fromBuffer(value),
        ($0.UserLookupResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.LookupUserByPhoneRequest, $0.UserLookupResponse>(
            'LookupUserByPhone',
            lookupUserByPhone_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.LookupUserByPhoneRequest.fromBuffer(value),
            ($0.UserLookupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserSearchRequest, $0.UserSearchResponse>(
        'SearchUsers',
        searchUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserSearchRequest.fromBuffer(value),
        ($0.UserSearchResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLinkedSocialAccountsRequest,
            $0.GetLinkedSocialAccountsResponse>(
        'GetLinkedSocialAccounts',
        getLinkedSocialAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetLinkedSocialAccountsRequest.fromBuffer(value),
        ($0.GetLinkedSocialAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LinkSocialAccountRequest,
            $0.LinkSocialAccountResponse>(
        'LinkSocialAccount',
        linkSocialAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.LinkSocialAccountRequest.fromBuffer(value),
        ($0.LinkSocialAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnlinkSocialAccountRequest,
            $0.UnlinkSocialAccountResponse>(
        'UnlinkSocialAccount',
        unlinkSocialAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UnlinkSocialAccountRequest.fromBuffer(value),
        ($0.UnlinkSocialAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetPrimarySocialAccountRequest,
            $0.SetPrimarySocialAccountResponse>(
        'SetPrimarySocialAccount',
        setPrimarySocialAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetPrimarySocialAccountRequest.fromBuffer(value),
        ($0.SetPrimarySocialAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReauthorizeSocialAccountRequest,
            $0.ReauthorizeSocialAccountResponse>(
        'ReauthorizeSocialAccount',
        reauthorizeSocialAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReauthorizeSocialAccountRequest.fromBuffer(value),
        ($0.ReauthorizeSocialAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAuthenticationConfigRequest,
            $0.GetAuthenticationConfigResponse>(
        'GetAuthenticationConfig',
        getAuthenticationConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAuthenticationConfigRequest.fromBuffer(value),
        ($0.GetAuthenticationConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestSignupPhoneOTPRequest,
            $0.RequestSignupPhoneOTPResponse>(
        'RequestSignupPhoneOTP',
        requestSignupPhoneOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestSignupPhoneOTPRequest.fromBuffer(value),
        ($0.RequestSignupPhoneOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifySignupPhoneOTPRequest,
            $0.VerifySignupPhoneOTPResponse>(
        'VerifySignupPhoneOTP',
        verifySignupPhoneOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifySignupPhoneOTPRequest.fromBuffer(value),
        ($0.VerifySignupPhoneOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SignupWithPhoneRequest, $0.LoginResponse>(
        'SignupWithPhone',
        signupWithPhone_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SignupWithPhoneRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.LoginWithPhonePasscodeRequest, $0.LoginResponse>(
            'LoginWithPhonePasscode',
            loginWithPhonePasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.LoginWithPhonePasscodeRequest.fromBuffer(value),
            ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestPasscodeResetRequest,
            $0.RequestPasscodeResetResponse>(
        'RequestPasscodeReset',
        requestPasscodeReset_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestPasscodeResetRequest.fromBuffer(value),
        ($0.RequestPasscodeResetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyPasscodeResetOTPRequest,
            $0.VerifyPasscodeResetOTPResponse>(
        'VerifyPasscodeResetOTP',
        verifyPasscodeResetOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyPasscodeResetOTPRequest.fromBuffer(value),
        ($0.VerifyPasscodeResetOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResetPasscodeWithOTPRequest,
            $0.ResetPasscodeWithOTPResponse>(
        'ResetPasscodeWithOTP',
        resetPasscodeWithOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResetPasscodeWithOTPRequest.fromBuffer(value),
        ($0.ResetPasscodeWithOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetPreferredLoginMethodRequest,
            $0.SetPreferredLoginMethodResponse>(
        'SetPreferredLoginMethod',
        setPreferredLoginMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetPreferredLoginMethodRequest.fromBuffer(value),
        ($0.SetPreferredLoginMethodResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SetPasswordRequest, $0.SetPasswordResponse>(
            'SetPassword',
            setPassword_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SetPasswordRequest.fromBuffer(value),
            ($0.SetPasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminSetPreferredLoginMethodRequest,
            $0.SetPreferredLoginMethodResponse>(
        'AdminSetPreferredLoginMethod',
        adminSetPreferredLoginMethod_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminSetPreferredLoginMethodRequest.fromBuffer(value),
        ($0.SetPreferredLoginMethodResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestPhoneChangeRequest,
            $0.RequestPhoneChangeResponse>(
        'RequestPhoneChange',
        requestPhoneChange_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestPhoneChangeRequest.fromBuffer(value),
        ($0.RequestPhoneChangeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyPhoneChangeRequest,
            $0.VerifyPhoneChangeResponse>(
        'VerifyPhoneChange',
        verifyPhoneChange_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyPhoneChangeRequest.fromBuffer(value),
        ($0.VerifyPhoneChangeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegisterDeviceRequest,
            $0.RegisterDeviceResponse>(
        'RegisterDevice',
        registerDevice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RegisterDeviceRequest.fromBuffer(value),
        ($0.RegisterDeviceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListDevicesRequest, $0.ListDevicesResponse>(
            'ListDevices',
            listDevices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListDevicesRequest.fromBuffer(value),
            ($0.ListDevicesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RevokeDeviceRequest, $0.RevokeDeviceResponse>(
            'RevokeDevice',
            revokeDevice_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RevokeDeviceRequest.fromBuffer(value),
            ($0.RevokeDeviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLoginHistoryRequest,
            $0.GetLoginHistoryResponse>(
        'GetLoginHistory',
        getLoginHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetLoginHistoryRequest.fromBuffer(value),
        ($0.GetLoginHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestAccountDeletionRequest,
            $0.RequestAccountDeletionResponse>(
        'RequestAccountDeletion',
        requestAccountDeletion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestAccountDeletionRequest.fromBuffer(value),
        ($0.RequestAccountDeletionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelAccountDeletionRequest,
            $0.CancelAccountDeletionResponse>(
        'CancelAccountDeletion',
        cancelAccountDeletion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelAccountDeletionRequest.fromBuffer(value),
        ($0.CancelAccountDeletionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListDeletionAccountsRequest,
            $0.ListDeletionAccountsResponse>(
        'ListDeletionAccounts',
        listDeletionAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListDeletionAccountsRequest.fromBuffer(value),
        ($0.ListDeletionAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminAccountDeletionActionRequest,
            $0.AdminAccountDeletionActionResponse>(
        'AdminFinalizeAccountDeletion',
        adminFinalizeAccountDeletion_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminAccountDeletionActionRequest.fromBuffer(value),
        ($0.AdminAccountDeletionActionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminAccountDeletionActionRequest,
            $0.AdminAccountDeletionActionResponse>(
        'AdminReactivateAccount',
        adminReactivateAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminAccountDeletionActionRequest.fromBuffer(value),
        ($0.AdminAccountDeletionActionResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestAccountLockRequest,
            $0.RequestAccountLockResponse>(
        'RequestAccountLock',
        requestAccountLock_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestAccountLockRequest.fromBuffer(value),
        ($0.RequestAccountLockResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SignupResponse> signup_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SignupRequest> $request) async {
    return signup($call, await $request);
  }

  $async.Future<$0.SignupResponse> signup(
      $grpc.ServiceCall call, $0.SignupRequest request);

  $async.Future<$0.LoginResponse> login_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.LoginRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$0.LoginResponse> login(
      $grpc.ServiceCall call, $0.LoginRequest request);

  $async.Future<$0.RefreshTokenResponse> refreshToken_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RefreshTokenRequest> $request) async {
    return refreshToken($call, await $request);
  }

  $async.Future<$0.RefreshTokenResponse> refreshToken(
      $grpc.ServiceCall call, $0.RefreshTokenRequest request);

  $async.Future<$0.LogoutResponse> logout_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.LogoutRequest> $request) async {
    return logout($call, await $request);
  }

  $async.Future<$0.LogoutResponse> logout(
      $grpc.ServiceCall call, $0.LogoutRequest request);

  $async.Future<$0.VerifyEmailResponse> verifyEmail_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VerifyEmailRequest> $request) async {
    return verifyEmail($call, await $request);
  }

  $async.Future<$0.VerifyEmailResponse> verifyEmail(
      $grpc.ServiceCall call, $0.VerifyEmailRequest request);

  $async.Future<$0.VerifyPhoneResponse> verifyPhone_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VerifyPhoneRequest> $request) async {
    return verifyPhone($call, await $request);
  }

  $async.Future<$0.VerifyPhoneResponse> verifyPhone(
      $grpc.ServiceCall call, $0.VerifyPhoneRequest request);

  $async.Future<$0.ForgotPasswordResponse> forgotPassword_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ForgotPasswordRequest> $request) async {
    return forgotPassword($call, await $request);
  }

  $async.Future<$0.ForgotPasswordResponse> forgotPassword(
      $grpc.ServiceCall call, $0.ForgotPasswordRequest request);

  $async.Future<$0.VerifyPasswordResetCodeResponse> verifyPasswordResetCode_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyPasswordResetCodeRequest> $request) async {
    return verifyPasswordResetCode($call, await $request);
  }

  $async.Future<$0.VerifyPasswordResetCodeResponse> verifyPasswordResetCode(
      $grpc.ServiceCall call, $0.VerifyPasswordResetCodeRequest request);

  $async.Future<$0.ResetPasswordResponse> resetPassword_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ResetPasswordRequest> $request) async {
    return resetPassword($call, await $request);
  }

  $async.Future<$0.ResetPasswordResponse> resetPassword(
      $grpc.ServiceCall call, $0.ResetPasswordRequest request);

  $async.Future<$0.GetMeResponse> getMe_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.GetMeRequest> $request) async {
    return getMe($call, await $request);
  }

  $async.Future<$0.GetMeResponse> getMe(
      $grpc.ServiceCall call, $0.GetMeRequest request);

  $async.Future<$0.UpdateProfileResponse> updateProfile_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateProfileRequest> $request) async {
    return updateProfile($call, await $request);
  }

  $async.Future<$0.UpdateProfileResponse> updateProfile(
      $grpc.ServiceCall call, $0.UpdateProfileRequest request);

  $async.Future<$0.FacialLoginResponse> facialLogin_Pre($grpc.ServiceCall $call,
      $async.Future<$0.FacialLoginRequest> $request) async {
    return facialLogin($call, await $request);
  }

  $async.Future<$0.FacialLoginResponse> facialLogin(
      $grpc.ServiceCall call, $0.FacialLoginRequest request);

  $async.Future<$0.SocialLoginResponse> socialLogin_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SocialLoginRequest> $request) async {
    return socialLogin($call, await $request);
  }

  $async.Future<$0.SocialLoginResponse> socialLogin(
      $grpc.ServiceCall call, $0.SocialLoginRequest request);

  $async.Future<$0.EnableTwoFactorResponse> enableTwoFactor_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.EnableTwoFactorRequest> $request) async {
    return enableTwoFactor($call, await $request);
  }

  $async.Future<$0.EnableTwoFactorResponse> enableTwoFactor(
      $grpc.ServiceCall call, $0.EnableTwoFactorRequest request);

  $async.Future<$0.VerifyTwoFactorResponse> verifyTwoFactor_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyTwoFactorRequest> $request) async {
    return verifyTwoFactor($call, await $request);
  }

  $async.Future<$0.VerifyTwoFactorResponse> verifyTwoFactor(
      $grpc.ServiceCall call, $0.VerifyTwoFactorRequest request);

  $async.Future<$0.CompleteTwoFactorSetupResponse> completeTwoFactorSetup_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CompleteTwoFactorSetupRequest> $request) async {
    return completeTwoFactorSetup($call, await $request);
  }

  $async.Future<$0.CompleteTwoFactorSetupResponse> completeTwoFactorSetup(
      $grpc.ServiceCall call, $0.CompleteTwoFactorSetupRequest request);

  $async.Future<$0.DisableTwoFactorResponse> disableTwoFactor_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DisableTwoFactorRequest> $request) async {
    return disableTwoFactor($call, await $request);
  }

  $async.Future<$0.DisableTwoFactorResponse> disableTwoFactor(
      $grpc.ServiceCall call, $0.DisableTwoFactorRequest request);

  $async.Future<$0.GetTwoFactorStatusResponse> getTwoFactorStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTwoFactorStatusRequest> $request) async {
    return getTwoFactorStatus($call, await $request);
  }

  $async.Future<$0.GetTwoFactorStatusResponse> getTwoFactorStatus(
      $grpc.ServiceCall call, $0.GetTwoFactorStatusRequest request);

  $async.Future<$0.RegenerateBackupCodesResponse> regenerateBackupCodes_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RegenerateBackupCodesRequest> $request) async {
    return regenerateBackupCodes($call, await $request);
  }

  $async.Future<$0.RegenerateBackupCodesResponse> regenerateBackupCodes(
      $grpc.ServiceCall call, $0.RegenerateBackupCodesRequest request);

  $async.Future<$0.SendTwoFactorCodeResponse> sendTwoFactorCode_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SendTwoFactorCodeRequest> $request) async {
    return sendTwoFactorCode($call, await $request);
  }

  $async.Future<$0.SendTwoFactorCodeResponse> sendTwoFactorCode(
      $grpc.ServiceCall call, $0.SendTwoFactorCodeRequest request);

  $async.Future<$0.GetAvailable2FAMethodsResponse> getAvailable2FAMethods_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAvailable2FAMethodsRequest> $request) async {
    return getAvailable2FAMethods($call, await $request);
  }

  $async.Future<$0.GetAvailable2FAMethodsResponse> getAvailable2FAMethods(
      $grpc.ServiceCall call, $0.GetAvailable2FAMethodsRequest request);

  $async.Future<$0.ValidateTokenResponse> validateToken_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ValidateTokenRequest> $request) async {
    return validateToken($call, await $request);
  }

  $async.Future<$0.ValidateTokenResponse> validateToken(
      $grpc.ServiceCall call, $0.ValidateTokenRequest request);

  $async.Future<$0.ResendVerificationEmailResponse> resendVerificationEmail_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ResendVerificationEmailRequest> $request) async {
    return resendVerificationEmail($call, await $request);
  }

  $async.Future<$0.ResendVerificationEmailResponse> resendVerificationEmail(
      $grpc.ServiceCall call, $0.ResendVerificationEmailRequest request);

  $async.Future<$0.ResendPhoneVerificationResponse> resendPhoneVerification_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ResendPhoneVerificationRequest> $request) async {
    return resendPhoneVerification($call, await $request);
  }

  $async.Future<$0.ResendPhoneVerificationResponse> resendPhoneVerification(
      $grpc.ServiceCall call, $0.ResendPhoneVerificationRequest request);

  $async.Future<$0.ChangePasswordResponse> changePassword_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ChangePasswordRequest> $request) async {
    return changePassword($call, await $request);
  }

  $async.Future<$0.ChangePasswordResponse> changePassword(
      $grpc.ServiceCall call, $0.ChangePasswordRequest request);

  $async.Future<$0.ChannelLoginResponse> channelLogin_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ChannelLoginRequest> $request) async {
    return channelLogin($call, await $request);
  }

  $async.Future<$0.ChannelLoginResponse> channelLogin(
      $grpc.ServiceCall call, $0.ChannelLoginRequest request);

  $async.Future<$0.ChannelRegisterResponse> channelRegister_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ChannelRegisterRequest> $request) async {
    return channelRegister($call, await $request);
  }

  $async.Future<$0.ChannelRegisterResponse> channelRegister(
      $grpc.ServiceCall call, $0.ChannelRegisterRequest request);

  $async.Future<$0.ChannelVerifyRegistrationResponse>
      channelVerifyRegistration_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ChannelVerifyRegistrationRequest> $request) async {
    return channelVerifyRegistration($call, await $request);
  }

  $async.Future<$0.ChannelVerifyRegistrationResponse> channelVerifyRegistration(
      $grpc.ServiceCall call, $0.ChannelVerifyRegistrationRequest request);

  $async.Future<$0.AdminGenerateTokenByPhoneResponse>
      adminGenerateTokenByPhone_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminGenerateTokenByPhoneRequest> $request) async {
    return adminGenerateTokenByPhone($call, await $request);
  }

  $async.Future<$0.AdminGenerateTokenByPhoneResponse> adminGenerateTokenByPhone(
      $grpc.ServiceCall call, $0.AdminGenerateTokenByPhoneRequest request);

  $async.Future<$0.LoginResponse> loginWithPasscode_Pre($grpc.ServiceCall $call,
      $async.Future<$0.LoginWithPasscodeRequest> $request) async {
    return loginWithPasscode($call, await $request);
  }

  $async.Future<$0.LoginResponse> loginWithPasscode(
      $grpc.ServiceCall call, $0.LoginWithPasscodeRequest request);

  $async.Future<$0.LoginResponse> verifyLoginOtp_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VerifyLoginOtpRequest> $request) async {
    return verifyLoginOtp($call, await $request);
  }

  $async.Future<$0.LoginResponse> verifyLoginOtp(
      $grpc.ServiceCall call, $0.VerifyLoginOtpRequest request);

  $async.Future<$0.RegisterPasscodeResponse> registerPasscode_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RegisterPasscodeRequest> $request) async {
    return registerPasscode($call, await $request);
  }

  $async.Future<$0.RegisterPasscodeResponse> registerPasscode(
      $grpc.ServiceCall call, $0.RegisterPasscodeRequest request);

  $async.Future<$0.ChangePasscodeResponse> changePasscode_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ChangePasscodeRequest> $request) async {
    return changePasscode($call, await $request);
  }

  $async.Future<$0.ChangePasscodeResponse> changePasscode(
      $grpc.ServiceCall call, $0.ChangePasscodeRequest request);

  $async.Future<$0.AuthUpdateDevicePermissionsResponse>
      updateDevicePermissions_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AuthUpdateDevicePermissionsRequest> $request) async {
    return updateDevicePermissions($call, await $request);
  }

  $async.Future<$0.AuthUpdateDevicePermissionsResponse> updateDevicePermissions(
      $grpc.ServiceCall call, $0.AuthUpdateDevicePermissionsRequest request);

  $async.Future<$0.AuthGetDevicePermissionsResponse> getDevicePermissions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AuthGetDevicePermissionsRequest> $request) async {
    return getDevicePermissions($call, await $request);
  }

  $async.Future<$0.AuthGetDevicePermissionsResponse> getDevicePermissions(
      $grpc.ServiceCall call, $0.AuthGetDevicePermissionsRequest request);

  $async.Future<$0.VerifyPasscodeResponse> verifyPasscode_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyPasscodeRequest> $request) async {
    return verifyPasscode($call, await $request);
  }

  $async.Future<$0.VerifyPasscodeResponse> verifyPasscode(
      $grpc.ServiceCall call, $0.VerifyPasscodeRequest request);

  $async.Future<$0.RequestPasswordResetResponse> requestPasswordReset_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestPasswordResetRequest> $request) async {
    return requestPasswordReset($call, await $request);
  }

  $async.Future<$0.RequestPasswordResetResponse> requestPasswordReset(
      $grpc.ServiceCall call, $0.RequestPasswordResetRequest request);

  $async.Future<$0.RequestEmailVerificationResponse>
      requestEmailVerification_Pre($grpc.ServiceCall $call,
          $async.Future<$0.RequestEmailVerificationRequest> $request) async {
    return requestEmailVerification($call, await $request);
  }

  $async.Future<$0.RequestEmailVerificationResponse> requestEmailVerification(
      $grpc.ServiceCall call, $0.RequestEmailVerificationRequest request);

  $async.Future<$0.CheckEmailAvailabilityResponse> checkEmailAvailability_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckEmailAvailabilityRequest> $request) async {
    return checkEmailAvailability($call, await $request);
  }

  $async.Future<$0.CheckEmailAvailabilityResponse> checkEmailAvailability(
      $grpc.ServiceCall call, $0.CheckEmailAvailabilityRequest request);

  $async.Future<$0.RequestPhoneVerificationResponse>
      requestPhoneVerification_Pre($grpc.ServiceCall $call,
          $async.Future<$0.RequestPhoneVerificationRequest> $request) async {
    return requestPhoneVerification($call, await $request);
  }

  $async.Future<$0.RequestPhoneVerificationResponse> requestPhoneVerification(
      $grpc.ServiceCall call, $0.RequestPhoneVerificationRequest request);

  $async.Future<$0.VerifyPhoneNumberResponse> verifyPhoneNumber_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyPhoneNumberRequest> $request) async {
    return verifyPhoneNumber($call, await $request);
  }

  $async.Future<$0.VerifyPhoneNumberResponse> verifyPhoneNumber(
      $grpc.ServiceCall call, $0.VerifyPhoneNumberRequest request);

  $async.Future<$0.GetSignupProgressResponse> getSignupProgress_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSignupProgressRequest> $request) async {
    return getSignupProgress($call, await $request);
  }

  $async.Future<$0.GetSignupProgressResponse> getSignupProgress(
      $grpc.ServiceCall call, $0.GetSignupProgressRequest request);

  $async.Future<$0.UpdateSignupStepResponse> updateSignupStep_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateSignupStepRequest> $request) async {
    return updateSignupStep($call, await $request);
  }

  $async.Future<$0.UpdateSignupStepResponse> updateSignupStep(
      $grpc.ServiceCall call, $0.UpdateSignupStepRequest request);

  $async.Future<$0.CompleteSignupResponse> completeSignup_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CompleteSignupRequest> $request) async {
    return completeSignup($call, await $request);
  }

  $async.Future<$0.CompleteSignupResponse> completeSignup(
      $grpc.ServiceCall call, $0.CompleteSignupRequest request);

  $async.Future<$0.VerifyIdentityResponse> verifyIdentity_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyIdentityRequest> $request) async {
    return verifyIdentity($call, await $request);
  }

  $async.Future<$0.VerifyIdentityResponse> verifyIdentity(
      $grpc.ServiceCall call, $0.VerifyIdentityRequest request);

  $async.Future<$0.GetIdentityVerificationStatusResponse>
      getIdentityVerificationStatus_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetIdentityVerificationStatusRequest>
              $request) async {
    return getIdentityVerificationStatus($call, await $request);
  }

  $async.Future<$0.GetIdentityVerificationStatusResponse>
      getIdentityVerificationStatus($grpc.ServiceCall call,
          $0.GetIdentityVerificationStatusRequest request);

  $async.Future<$0.InitiateKYCResponse> initiateKYC_Pre($grpc.ServiceCall $call,
      $async.Future<$0.InitiateKYCRequest> $request) async {
    return initiateKYC($call, await $request);
  }

  $async.Future<$0.InitiateKYCResponse> initiateKYC(
      $grpc.ServiceCall call, $0.InitiateKYCRequest request);

  $async.Future<$0.UploadDocumentResponse> uploadDocument_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UploadDocumentRequest> $request) async {
    return uploadDocument($call, await $request);
  }

  $async.Future<$0.UploadDocumentResponse> uploadDocument(
      $grpc.ServiceCall call, $0.UploadDocumentRequest request);

  $async.Future<$0.SkipKYCUpgradeResponse> skipKYCUpgrade_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SkipKYCUpgradeRequest> $request) async {
    return skipKYCUpgrade($call, await $request);
  }

  $async.Future<$0.SkipKYCUpgradeResponse> skipKYCUpgrade(
      $grpc.ServiceCall call, $0.SkipKYCUpgradeRequest request);

  $async.Future<$0.SyncVerifiedKYCTierResponse> syncVerifiedKYCTier_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SyncVerifiedKYCTierRequest> $request) async {
    return syncVerifiedKYCTier($call, await $request);
  }

  $async.Future<$0.SyncVerifiedKYCTierResponse> syncVerifiedKYCTier(
      $grpc.ServiceCall call, $0.SyncVerifiedKYCTierRequest request);

  $async.Future<$0.AdminOverrideKYCTierResponse> adminOverrideKYCTier_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminOverrideKYCTierRequest> $request) async {
    return adminOverrideKYCTier($call, await $request);
  }

  $async.Future<$0.AdminOverrideKYCTierResponse> adminOverrideKYCTier(
      $grpc.ServiceCall call, $0.AdminOverrideKYCTierRequest request);

  $async.Future<$0.AdminResetTransactionPinResponse>
      adminResetTransactionPin_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminResetTransactionPinRequest> $request) async {
    return adminResetTransactionPin($call, await $request);
  }

  $async.Future<$0.AdminResetTransactionPinResponse> adminResetTransactionPin(
      $grpc.ServiceCall call, $0.AdminResetTransactionPinRequest request);

  $async.Future<$0.GetKYCTierResponse> getKYCTier_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetKYCTierRequest> $request) async {
    return getKYCTier($call, await $request);
  }

  $async.Future<$0.GetKYCTierResponse> getKYCTier(
      $grpc.ServiceCall call, $0.GetKYCTierRequest request);

  $async.Future<$0.GetUserIdentityForServiceResponse>
      getUserIdentityForService_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetUserIdentityForServiceRequest> $request) async {
    return getUserIdentityForService($call, await $request);
  }

  $async.Future<$0.GetUserIdentityForServiceResponse> getUserIdentityForService(
      $grpc.ServiceCall call, $0.GetUserIdentityForServiceRequest request);

  $async.Future<$0.MarkEmailBouncedByEmailResponse> markEmailBouncedByEmail_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MarkEmailBouncedByEmailRequest> $request) async {
    return markEmailBouncedByEmail($call, await $request);
  }

  $async.Future<$0.MarkEmailBouncedByEmailResponse> markEmailBouncedByEmail(
      $grpc.ServiceCall call, $0.MarkEmailBouncedByEmailRequest request);

  $async.Future<$0.GetMyInsurancePrefillResponse> getMyInsurancePrefill_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMyInsurancePrefillRequest> $request) async {
    return getMyInsurancePrefill($call, await $request);
  }

  $async.Future<$0.GetMyInsurancePrefillResponse> getMyInsurancePrefill(
      $grpc.ServiceCall call, $0.GetMyInsurancePrefillRequest request);

  $async.Future<$0.GetUserDocumentsResponse> getUserDocuments_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserDocumentsRequest> $request) async {
    return getUserDocuments($call, await $request);
  }

  $async.Future<$0.GetUserDocumentsResponse> getUserDocuments(
      $grpc.ServiceCall call, $0.GetUserDocumentsRequest request);

  $async.Future<$0.GetKYCStatusResponse> getKYCStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetKYCStatusRequest> $request) async {
    return getKYCStatus($call, await $request);
  }

  $async.Future<$0.GetKYCStatusResponse> getKYCStatus(
      $grpc.ServiceCall call, $0.GetKYCStatusRequest request);

  $async.Future<$0.GetCountryRequirementsResponse> getCountryRequirements_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetCountryRequirementsRequest> $request) async {
    return getCountryRequirements($call, await $request);
  }

  $async.Future<$0.GetCountryRequirementsResponse> getCountryRequirements(
      $grpc.ServiceCall call, $0.GetCountryRequirementsRequest request);

  $async.Future<$0.CreateVerificationSessionResponse>
      createVerificationSession_Pre($grpc.ServiceCall $call,
          $async.Future<$0.CreateVerificationSessionRequest> $request) async {
    return createVerificationSession($call, await $request);
  }

  $async.Future<$0.CreateVerificationSessionResponse> createVerificationSession(
      $grpc.ServiceCall call, $0.CreateVerificationSessionRequest request);

  $async.Future<$0.ConfirmVerificationResponse> confirmVerification_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ConfirmVerificationRequest> $request) async {
    return confirmVerification($call, await $request);
  }

  $async.Future<$0.ConfirmVerificationResponse> confirmVerification(
      $grpc.ServiceCall call, $0.ConfirmVerificationRequest request);

  $async.Future<$0.GetDocumentUploadURLResponse> getDocumentUploadURL_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDocumentUploadURLRequest> $request) async {
    return getDocumentUploadURL($call, await $request);
  }

  $async.Future<$0.GetDocumentUploadURLResponse> getDocumentUploadURL(
      $grpc.ServiceCall call, $0.GetDocumentUploadURLRequest request);

  $async.Future<$0.SubmitDocumentsForReviewResponse>
      submitDocumentsForReview_Pre($grpc.ServiceCall $call,
          $async.Future<$0.SubmitDocumentsForReviewRequest> $request) async {
    return submitDocumentsForReview($call, await $request);
  }

  $async.Future<$0.SubmitDocumentsForReviewResponse> submitDocumentsForReview(
      $grpc.ServiceCall call, $0.SubmitDocumentsForReviewRequest request);

  $async.Future<$0.ConfirmBVNNameResponse> confirmBVNName_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ConfirmBVNNameRequest> $request) async {
    return confirmBVNName($call, await $request);
  }

  $async.Future<$0.ConfirmBVNNameResponse> confirmBVNName(
      $grpc.ServiceCall call, $0.ConfirmBVNNameRequest request);

  $async.Future<$0.UserLookupResponse> lookupUserByUsername_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.LookupUserByUsernameRequest> $request) async {
    return lookupUserByUsername($call, await $request);
  }

  $async.Future<$0.UserLookupResponse> lookupUserByUsername(
      $grpc.ServiceCall call, $0.LookupUserByUsernameRequest request);

  $async.Future<$0.UserLookupResponse> lookupUserByPhone_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.LookupUserByPhoneRequest> $request) async {
    return lookupUserByPhone($call, await $request);
  }

  $async.Future<$0.UserLookupResponse> lookupUserByPhone(
      $grpc.ServiceCall call, $0.LookupUserByPhoneRequest request);

  $async.Future<$0.UserSearchResponse> searchUsers_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UserSearchRequest> $request) async {
    return searchUsers($call, await $request);
  }

  $async.Future<$0.UserSearchResponse> searchUsers(
      $grpc.ServiceCall call, $0.UserSearchRequest request);

  $async.Future<$0.GetLinkedSocialAccountsResponse> getLinkedSocialAccounts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetLinkedSocialAccountsRequest> $request) async {
    return getLinkedSocialAccounts($call, await $request);
  }

  $async.Future<$0.GetLinkedSocialAccountsResponse> getLinkedSocialAccounts(
      $grpc.ServiceCall call, $0.GetLinkedSocialAccountsRequest request);

  $async.Future<$0.LinkSocialAccountResponse> linkSocialAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.LinkSocialAccountRequest> $request) async {
    return linkSocialAccount($call, await $request);
  }

  $async.Future<$0.LinkSocialAccountResponse> linkSocialAccount(
      $grpc.ServiceCall call, $0.LinkSocialAccountRequest request);

  $async.Future<$0.UnlinkSocialAccountResponse> unlinkSocialAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UnlinkSocialAccountRequest> $request) async {
    return unlinkSocialAccount($call, await $request);
  }

  $async.Future<$0.UnlinkSocialAccountResponse> unlinkSocialAccount(
      $grpc.ServiceCall call, $0.UnlinkSocialAccountRequest request);

  $async.Future<$0.SetPrimarySocialAccountResponse> setPrimarySocialAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SetPrimarySocialAccountRequest> $request) async {
    return setPrimarySocialAccount($call, await $request);
  }

  $async.Future<$0.SetPrimarySocialAccountResponse> setPrimarySocialAccount(
      $grpc.ServiceCall call, $0.SetPrimarySocialAccountRequest request);

  $async.Future<$0.ReauthorizeSocialAccountResponse>
      reauthorizeSocialAccount_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ReauthorizeSocialAccountRequest> $request) async {
    return reauthorizeSocialAccount($call, await $request);
  }

  $async.Future<$0.ReauthorizeSocialAccountResponse> reauthorizeSocialAccount(
      $grpc.ServiceCall call, $0.ReauthorizeSocialAccountRequest request);

  $async.Future<$0.GetAuthenticationConfigResponse> getAuthenticationConfig_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAuthenticationConfigRequest> $request) async {
    return getAuthenticationConfig($call, await $request);
  }

  $async.Future<$0.GetAuthenticationConfigResponse> getAuthenticationConfig(
      $grpc.ServiceCall call, $0.GetAuthenticationConfigRequest request);

  $async.Future<$0.RequestSignupPhoneOTPResponse> requestSignupPhoneOTP_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestSignupPhoneOTPRequest> $request) async {
    return requestSignupPhoneOTP($call, await $request);
  }

  $async.Future<$0.RequestSignupPhoneOTPResponse> requestSignupPhoneOTP(
      $grpc.ServiceCall call, $0.RequestSignupPhoneOTPRequest request);

  $async.Future<$0.VerifySignupPhoneOTPResponse> verifySignupPhoneOTP_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifySignupPhoneOTPRequest> $request) async {
    return verifySignupPhoneOTP($call, await $request);
  }

  $async.Future<$0.VerifySignupPhoneOTPResponse> verifySignupPhoneOTP(
      $grpc.ServiceCall call, $0.VerifySignupPhoneOTPRequest request);

  $async.Future<$0.LoginResponse> signupWithPhone_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SignupWithPhoneRequest> $request) async {
    return signupWithPhone($call, await $request);
  }

  $async.Future<$0.LoginResponse> signupWithPhone(
      $grpc.ServiceCall call, $0.SignupWithPhoneRequest request);

  $async.Future<$0.LoginResponse> loginWithPhonePasscode_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.LoginWithPhonePasscodeRequest> $request) async {
    return loginWithPhonePasscode($call, await $request);
  }

  $async.Future<$0.LoginResponse> loginWithPhonePasscode(
      $grpc.ServiceCall call, $0.LoginWithPhonePasscodeRequest request);

  $async.Future<$0.RequestPasscodeResetResponse> requestPasscodeReset_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestPasscodeResetRequest> $request) async {
    return requestPasscodeReset($call, await $request);
  }

  $async.Future<$0.RequestPasscodeResetResponse> requestPasscodeReset(
      $grpc.ServiceCall call, $0.RequestPasscodeResetRequest request);

  $async.Future<$0.VerifyPasscodeResetOTPResponse> verifyPasscodeResetOTP_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyPasscodeResetOTPRequest> $request) async {
    return verifyPasscodeResetOTP($call, await $request);
  }

  $async.Future<$0.VerifyPasscodeResetOTPResponse> verifyPasscodeResetOTP(
      $grpc.ServiceCall call, $0.VerifyPasscodeResetOTPRequest request);

  $async.Future<$0.ResetPasscodeWithOTPResponse> resetPasscodeWithOTP_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ResetPasscodeWithOTPRequest> $request) async {
    return resetPasscodeWithOTP($call, await $request);
  }

  $async.Future<$0.ResetPasscodeWithOTPResponse> resetPasscodeWithOTP(
      $grpc.ServiceCall call, $0.ResetPasscodeWithOTPRequest request);

  $async.Future<$0.SetPreferredLoginMethodResponse> setPreferredLoginMethod_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SetPreferredLoginMethodRequest> $request) async {
    return setPreferredLoginMethod($call, await $request);
  }

  $async.Future<$0.SetPreferredLoginMethodResponse> setPreferredLoginMethod(
      $grpc.ServiceCall call, $0.SetPreferredLoginMethodRequest request);

  $async.Future<$0.SetPasswordResponse> setPassword_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SetPasswordRequest> $request) async {
    return setPassword($call, await $request);
  }

  $async.Future<$0.SetPasswordResponse> setPassword(
      $grpc.ServiceCall call, $0.SetPasswordRequest request);

  $async.Future<$0.SetPreferredLoginMethodResponse>
      adminSetPreferredLoginMethod_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.AdminSetPreferredLoginMethodRequest>
              $request) async {
    return adminSetPreferredLoginMethod($call, await $request);
  }

  $async.Future<$0.SetPreferredLoginMethodResponse>
      adminSetPreferredLoginMethod($grpc.ServiceCall call,
          $0.AdminSetPreferredLoginMethodRequest request);

  $async.Future<$0.RequestPhoneChangeResponse> requestPhoneChange_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestPhoneChangeRequest> $request) async {
    return requestPhoneChange($call, await $request);
  }

  $async.Future<$0.RequestPhoneChangeResponse> requestPhoneChange(
      $grpc.ServiceCall call, $0.RequestPhoneChangeRequest request);

  $async.Future<$0.VerifyPhoneChangeResponse> verifyPhoneChange_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyPhoneChangeRequest> $request) async {
    return verifyPhoneChange($call, await $request);
  }

  $async.Future<$0.VerifyPhoneChangeResponse> verifyPhoneChange(
      $grpc.ServiceCall call, $0.VerifyPhoneChangeRequest request);

  $async.Future<$0.RegisterDeviceResponse> registerDevice_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RegisterDeviceRequest> $request) async {
    return registerDevice($call, await $request);
  }

  $async.Future<$0.RegisterDeviceResponse> registerDevice(
      $grpc.ServiceCall call, $0.RegisterDeviceRequest request);

  $async.Future<$0.ListDevicesResponse> listDevices_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListDevicesRequest> $request) async {
    return listDevices($call, await $request);
  }

  $async.Future<$0.ListDevicesResponse> listDevices(
      $grpc.ServiceCall call, $0.ListDevicesRequest request);

  $async.Future<$0.RevokeDeviceResponse> revokeDevice_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RevokeDeviceRequest> $request) async {
    return revokeDevice($call, await $request);
  }

  $async.Future<$0.RevokeDeviceResponse> revokeDevice(
      $grpc.ServiceCall call, $0.RevokeDeviceRequest request);

  $async.Future<$0.GetLoginHistoryResponse> getLoginHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetLoginHistoryRequest> $request) async {
    return getLoginHistory($call, await $request);
  }

  $async.Future<$0.GetLoginHistoryResponse> getLoginHistory(
      $grpc.ServiceCall call, $0.GetLoginHistoryRequest request);

  $async.Future<$0.RequestAccountDeletionResponse> requestAccountDeletion_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestAccountDeletionRequest> $request) async {
    return requestAccountDeletion($call, await $request);
  }

  $async.Future<$0.RequestAccountDeletionResponse> requestAccountDeletion(
      $grpc.ServiceCall call, $0.RequestAccountDeletionRequest request);

  $async.Future<$0.CancelAccountDeletionResponse> cancelAccountDeletion_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelAccountDeletionRequest> $request) async {
    return cancelAccountDeletion($call, await $request);
  }

  $async.Future<$0.CancelAccountDeletionResponse> cancelAccountDeletion(
      $grpc.ServiceCall call, $0.CancelAccountDeletionRequest request);

  $async.Future<$0.ListDeletionAccountsResponse> listDeletionAccounts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListDeletionAccountsRequest> $request) async {
    return listDeletionAccounts($call, await $request);
  }

  $async.Future<$0.ListDeletionAccountsResponse> listDeletionAccounts(
      $grpc.ServiceCall call, $0.ListDeletionAccountsRequest request);

  $async.Future<$0.AdminAccountDeletionActionResponse>
      adminFinalizeAccountDeletion_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminAccountDeletionActionRequest> $request) async {
    return adminFinalizeAccountDeletion($call, await $request);
  }

  $async.Future<$0.AdminAccountDeletionActionResponse>
      adminFinalizeAccountDeletion(
          $grpc.ServiceCall call, $0.AdminAccountDeletionActionRequest request);

  $async.Future<$0.AdminAccountDeletionActionResponse>
      adminReactivateAccount_Pre($grpc.ServiceCall $call,
          $async.Future<$0.AdminAccountDeletionActionRequest> $request) async {
    return adminReactivateAccount($call, await $request);
  }

  $async.Future<$0.AdminAccountDeletionActionResponse> adminReactivateAccount(
      $grpc.ServiceCall call, $0.AdminAccountDeletionActionRequest request);

  $async.Future<$0.RequestAccountLockResponse> requestAccountLock_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestAccountLockRequest> $request) async {
    return requestAccountLock($call, await $request);
  }

  $async.Future<$0.RequestAccountLockResponse> requestAccountLock(
      $grpc.ServiceCall call, $0.RequestAccountLockRequest request);
}
