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
@$pb.GrpcServiceName('auth.AuthService')
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

  /// Search users by username prefix (for autocomplete/search functionality)
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

  // method descriptors

  static final _$signup =
      $grpc.ClientMethod<$0.SignupRequest, $0.SignupResponse>(
          '/auth.AuthService/Signup',
          ($0.SignupRequest value) => value.writeToBuffer(),
          $0.SignupResponse.fromBuffer);
  static final _$login = $grpc.ClientMethod<$0.LoginRequest, $0.LoginResponse>(
      '/auth.AuthService/Login',
      ($0.LoginRequest value) => value.writeToBuffer(),
      $0.LoginResponse.fromBuffer);
  static final _$refreshToken =
      $grpc.ClientMethod<$0.RefreshTokenRequest, $0.RefreshTokenResponse>(
          '/auth.AuthService/RefreshToken',
          ($0.RefreshTokenRequest value) => value.writeToBuffer(),
          $0.RefreshTokenResponse.fromBuffer);
  static final _$logout =
      $grpc.ClientMethod<$0.LogoutRequest, $0.LogoutResponse>(
          '/auth.AuthService/Logout',
          ($0.LogoutRequest value) => value.writeToBuffer(),
          $0.LogoutResponse.fromBuffer);
  static final _$verifyEmail =
      $grpc.ClientMethod<$0.VerifyEmailRequest, $0.VerifyEmailResponse>(
          '/auth.AuthService/VerifyEmail',
          ($0.VerifyEmailRequest value) => value.writeToBuffer(),
          $0.VerifyEmailResponse.fromBuffer);
  static final _$verifyPhone =
      $grpc.ClientMethod<$0.VerifyPhoneRequest, $0.VerifyPhoneResponse>(
          '/auth.AuthService/VerifyPhone',
          ($0.VerifyPhoneRequest value) => value.writeToBuffer(),
          $0.VerifyPhoneResponse.fromBuffer);
  static final _$forgotPassword =
      $grpc.ClientMethod<$0.ForgotPasswordRequest, $0.ForgotPasswordResponse>(
          '/auth.AuthService/ForgotPassword',
          ($0.ForgotPasswordRequest value) => value.writeToBuffer(),
          $0.ForgotPasswordResponse.fromBuffer);
  static final _$verifyPasswordResetCode = $grpc.ClientMethod<
          $0.VerifyPasswordResetCodeRequest,
          $0.VerifyPasswordResetCodeResponse>(
      '/auth.AuthService/VerifyPasswordResetCode',
      ($0.VerifyPasswordResetCodeRequest value) => value.writeToBuffer(),
      $0.VerifyPasswordResetCodeResponse.fromBuffer);
  static final _$resetPassword =
      $grpc.ClientMethod<$0.ResetPasswordRequest, $0.ResetPasswordResponse>(
          '/auth.AuthService/ResetPassword',
          ($0.ResetPasswordRequest value) => value.writeToBuffer(),
          $0.ResetPasswordResponse.fromBuffer);
  static final _$getMe = $grpc.ClientMethod<$0.GetMeRequest, $0.GetMeResponse>(
      '/auth.AuthService/GetMe',
      ($0.GetMeRequest value) => value.writeToBuffer(),
      $0.GetMeResponse.fromBuffer);
  static final _$updateProfile =
      $grpc.ClientMethod<$0.UpdateProfileRequest, $0.UpdateProfileResponse>(
          '/auth.AuthService/UpdateProfile',
          ($0.UpdateProfileRequest value) => value.writeToBuffer(),
          $0.UpdateProfileResponse.fromBuffer);
  static final _$facialLogin =
      $grpc.ClientMethod<$0.FacialLoginRequest, $0.FacialLoginResponse>(
          '/auth.AuthService/FacialLogin',
          ($0.FacialLoginRequest value) => value.writeToBuffer(),
          $0.FacialLoginResponse.fromBuffer);
  static final _$socialLogin =
      $grpc.ClientMethod<$0.SocialLoginRequest, $0.SocialLoginResponse>(
          '/auth.AuthService/SocialLogin',
          ($0.SocialLoginRequest value) => value.writeToBuffer(),
          $0.SocialLoginResponse.fromBuffer);
  static final _$enableTwoFactor =
      $grpc.ClientMethod<$0.EnableTwoFactorRequest, $0.EnableTwoFactorResponse>(
          '/auth.AuthService/EnableTwoFactor',
          ($0.EnableTwoFactorRequest value) => value.writeToBuffer(),
          $0.EnableTwoFactorResponse.fromBuffer);
  static final _$verifyTwoFactor =
      $grpc.ClientMethod<$0.VerifyTwoFactorRequest, $0.VerifyTwoFactorResponse>(
          '/auth.AuthService/VerifyTwoFactor',
          ($0.VerifyTwoFactorRequest value) => value.writeToBuffer(),
          $0.VerifyTwoFactorResponse.fromBuffer);
  static final _$completeTwoFactorSetup = $grpc.ClientMethod<
          $0.CompleteTwoFactorSetupRequest, $0.CompleteTwoFactorSetupResponse>(
      '/auth.AuthService/CompleteTwoFactorSetup',
      ($0.CompleteTwoFactorSetupRequest value) => value.writeToBuffer(),
      $0.CompleteTwoFactorSetupResponse.fromBuffer);
  static final _$disableTwoFactor = $grpc.ClientMethod<
          $0.DisableTwoFactorRequest, $0.DisableTwoFactorResponse>(
      '/auth.AuthService/DisableTwoFactor',
      ($0.DisableTwoFactorRequest value) => value.writeToBuffer(),
      $0.DisableTwoFactorResponse.fromBuffer);
  static final _$getTwoFactorStatus = $grpc.ClientMethod<
          $0.GetTwoFactorStatusRequest, $0.GetTwoFactorStatusResponse>(
      '/auth.AuthService/GetTwoFactorStatus',
      ($0.GetTwoFactorStatusRequest value) => value.writeToBuffer(),
      $0.GetTwoFactorStatusResponse.fromBuffer);
  static final _$regenerateBackupCodes = $grpc.ClientMethod<
          $0.RegenerateBackupCodesRequest, $0.RegenerateBackupCodesResponse>(
      '/auth.AuthService/RegenerateBackupCodes',
      ($0.RegenerateBackupCodesRequest value) => value.writeToBuffer(),
      $0.RegenerateBackupCodesResponse.fromBuffer);
  static final _$sendTwoFactorCode = $grpc.ClientMethod<
          $0.SendTwoFactorCodeRequest, $0.SendTwoFactorCodeResponse>(
      '/auth.AuthService/SendTwoFactorCode',
      ($0.SendTwoFactorCodeRequest value) => value.writeToBuffer(),
      $0.SendTwoFactorCodeResponse.fromBuffer);
  static final _$getAvailable2FAMethods = $grpc.ClientMethod<
          $0.GetAvailable2FAMethodsRequest, $0.GetAvailable2FAMethodsResponse>(
      '/auth.AuthService/GetAvailable2FAMethods',
      ($0.GetAvailable2FAMethodsRequest value) => value.writeToBuffer(),
      $0.GetAvailable2FAMethodsResponse.fromBuffer);
  static final _$validateToken =
      $grpc.ClientMethod<$0.ValidateTokenRequest, $0.ValidateTokenResponse>(
          '/auth.AuthService/ValidateToken',
          ($0.ValidateTokenRequest value) => value.writeToBuffer(),
          $0.ValidateTokenResponse.fromBuffer);
  static final _$resendVerificationEmail = $grpc.ClientMethod<
          $0.ResendVerificationEmailRequest,
          $0.ResendVerificationEmailResponse>(
      '/auth.AuthService/ResendVerificationEmail',
      ($0.ResendVerificationEmailRequest value) => value.writeToBuffer(),
      $0.ResendVerificationEmailResponse.fromBuffer);
  static final _$resendPhoneVerification = $grpc.ClientMethod<
          $0.ResendPhoneVerificationRequest,
          $0.ResendPhoneVerificationResponse>(
      '/auth.AuthService/ResendPhoneVerification',
      ($0.ResendPhoneVerificationRequest value) => value.writeToBuffer(),
      $0.ResendPhoneVerificationResponse.fromBuffer);
  static final _$changePassword =
      $grpc.ClientMethod<$0.ChangePasswordRequest, $0.ChangePasswordResponse>(
          '/auth.AuthService/ChangePassword',
          ($0.ChangePasswordRequest value) => value.writeToBuffer(),
          $0.ChangePasswordResponse.fromBuffer);
  static final _$channelLogin =
      $grpc.ClientMethod<$0.ChannelLoginRequest, $0.ChannelLoginResponse>(
          '/auth.AuthService/ChannelLogin',
          ($0.ChannelLoginRequest value) => value.writeToBuffer(),
          $0.ChannelLoginResponse.fromBuffer);
  static final _$channelRegister =
      $grpc.ClientMethod<$0.ChannelRegisterRequest, $0.ChannelRegisterResponse>(
          '/auth.AuthService/ChannelRegister',
          ($0.ChannelRegisterRequest value) => value.writeToBuffer(),
          $0.ChannelRegisterResponse.fromBuffer);
  static final _$channelVerifyRegistration = $grpc.ClientMethod<
          $0.ChannelVerifyRegistrationRequest,
          $0.ChannelVerifyRegistrationResponse>(
      '/auth.AuthService/ChannelVerifyRegistration',
      ($0.ChannelVerifyRegistrationRequest value) => value.writeToBuffer(),
      $0.ChannelVerifyRegistrationResponse.fromBuffer);
  static final _$adminGenerateTokenByPhone = $grpc.ClientMethod<
          $0.AdminGenerateTokenByPhoneRequest,
          $0.AdminGenerateTokenByPhoneResponse>(
      '/auth.AuthService/AdminGenerateTokenByPhone',
      ($0.AdminGenerateTokenByPhoneRequest value) => value.writeToBuffer(),
      $0.AdminGenerateTokenByPhoneResponse.fromBuffer);
  static final _$loginWithPasscode =
      $grpc.ClientMethod<$0.LoginWithPasscodeRequest, $0.LoginResponse>(
          '/auth.AuthService/LoginWithPasscode',
          ($0.LoginWithPasscodeRequest value) => value.writeToBuffer(),
          $0.LoginResponse.fromBuffer);
  static final _$registerPasscode = $grpc.ClientMethod<
          $0.RegisterPasscodeRequest, $0.RegisterPasscodeResponse>(
      '/auth.AuthService/RegisterPasscode',
      ($0.RegisterPasscodeRequest value) => value.writeToBuffer(),
      $0.RegisterPasscodeResponse.fromBuffer);
  static final _$changePasscode =
      $grpc.ClientMethod<$0.ChangePasscodeRequest, $0.ChangePasscodeResponse>(
          '/auth.AuthService/ChangePasscode',
          ($0.ChangePasscodeRequest value) => value.writeToBuffer(),
          $0.ChangePasscodeResponse.fromBuffer);
  static final _$requestPasswordReset = $grpc.ClientMethod<
          $0.RequestPasswordResetRequest, $0.RequestPasswordResetResponse>(
      '/auth.AuthService/RequestPasswordReset',
      ($0.RequestPasswordResetRequest value) => value.writeToBuffer(),
      $0.RequestPasswordResetResponse.fromBuffer);
  static final _$requestEmailVerification = $grpc.ClientMethod<
          $0.RequestEmailVerificationRequest,
          $0.RequestEmailVerificationResponse>(
      '/auth.AuthService/RequestEmailVerification',
      ($0.RequestEmailVerificationRequest value) => value.writeToBuffer(),
      $0.RequestEmailVerificationResponse.fromBuffer);
  static final _$checkEmailAvailability = $grpc.ClientMethod<
          $0.CheckEmailAvailabilityRequest, $0.CheckEmailAvailabilityResponse>(
      '/auth.AuthService/CheckEmailAvailability',
      ($0.CheckEmailAvailabilityRequest value) => value.writeToBuffer(),
      $0.CheckEmailAvailabilityResponse.fromBuffer);
  static final _$requestPhoneVerification = $grpc.ClientMethod<
          $0.RequestPhoneVerificationRequest,
          $0.RequestPhoneVerificationResponse>(
      '/auth.AuthService/RequestPhoneVerification',
      ($0.RequestPhoneVerificationRequest value) => value.writeToBuffer(),
      $0.RequestPhoneVerificationResponse.fromBuffer);
  static final _$verifyPhoneNumber = $grpc.ClientMethod<
          $0.VerifyPhoneNumberRequest, $0.VerifyPhoneNumberResponse>(
      '/auth.AuthService/VerifyPhoneNumber',
      ($0.VerifyPhoneNumberRequest value) => value.writeToBuffer(),
      $0.VerifyPhoneNumberResponse.fromBuffer);
  static final _$getSignupProgress = $grpc.ClientMethod<
          $0.GetSignupProgressRequest, $0.GetSignupProgressResponse>(
      '/auth.AuthService/GetSignupProgress',
      ($0.GetSignupProgressRequest value) => value.writeToBuffer(),
      $0.GetSignupProgressResponse.fromBuffer);
  static final _$updateSignupStep = $grpc.ClientMethod<
          $0.UpdateSignupStepRequest, $0.UpdateSignupStepResponse>(
      '/auth.AuthService/UpdateSignupStep',
      ($0.UpdateSignupStepRequest value) => value.writeToBuffer(),
      $0.UpdateSignupStepResponse.fromBuffer);
  static final _$completeSignup =
      $grpc.ClientMethod<$0.CompleteSignupRequest, $0.CompleteSignupResponse>(
          '/auth.AuthService/CompleteSignup',
          ($0.CompleteSignupRequest value) => value.writeToBuffer(),
          $0.CompleteSignupResponse.fromBuffer);
  static final _$verifyIdentity =
      $grpc.ClientMethod<$0.VerifyIdentityRequest, $0.VerifyIdentityResponse>(
          '/auth.AuthService/VerifyIdentity',
          ($0.VerifyIdentityRequest value) => value.writeToBuffer(),
          $0.VerifyIdentityResponse.fromBuffer);
  static final _$getIdentityVerificationStatus = $grpc.ClientMethod<
          $0.GetIdentityVerificationStatusRequest,
          $0.GetIdentityVerificationStatusResponse>(
      '/auth.AuthService/GetIdentityVerificationStatus',
      ($0.GetIdentityVerificationStatusRequest value) => value.writeToBuffer(),
      $0.GetIdentityVerificationStatusResponse.fromBuffer);
  static final _$initiateKYC =
      $grpc.ClientMethod<$0.InitiateKYCRequest, $0.InitiateKYCResponse>(
          '/auth.AuthService/InitiateKYC',
          ($0.InitiateKYCRequest value) => value.writeToBuffer(),
          $0.InitiateKYCResponse.fromBuffer);
  static final _$uploadDocument =
      $grpc.ClientMethod<$0.UploadDocumentRequest, $0.UploadDocumentResponse>(
          '/auth.AuthService/UploadDocument',
          ($0.UploadDocumentRequest value) => value.writeToBuffer(),
          $0.UploadDocumentResponse.fromBuffer);
  static final _$skipKYCUpgrade =
      $grpc.ClientMethod<$0.SkipKYCUpgradeRequest, $0.SkipKYCUpgradeResponse>(
          '/auth.AuthService/SkipKYCUpgrade',
          ($0.SkipKYCUpgradeRequest value) => value.writeToBuffer(),
          $0.SkipKYCUpgradeResponse.fromBuffer);
  static final _$getUserDocuments = $grpc.ClientMethod<
          $0.GetUserDocumentsRequest, $0.GetUserDocumentsResponse>(
      '/auth.AuthService/GetUserDocuments',
      ($0.GetUserDocumentsRequest value) => value.writeToBuffer(),
      $0.GetUserDocumentsResponse.fromBuffer);
  static final _$getKYCStatus =
      $grpc.ClientMethod<$0.GetKYCStatusRequest, $0.GetKYCStatusResponse>(
          '/auth.AuthService/GetKYCStatus',
          ($0.GetKYCStatusRequest value) => value.writeToBuffer(),
          $0.GetKYCStatusResponse.fromBuffer);
  static final _$getCountryRequirements = $grpc.ClientMethod<
          $0.GetCountryRequirementsRequest, $0.GetCountryRequirementsResponse>(
      '/auth.AuthService/GetCountryRequirements',
      ($0.GetCountryRequirementsRequest value) => value.writeToBuffer(),
      $0.GetCountryRequirementsResponse.fromBuffer);
  static final _$createVerificationSession = $grpc.ClientMethod<
          $0.CreateVerificationSessionRequest,
          $0.CreateVerificationSessionResponse>(
      '/auth.AuthService/CreateVerificationSession',
      ($0.CreateVerificationSessionRequest value) => value.writeToBuffer(),
      $0.CreateVerificationSessionResponse.fromBuffer);
  static final _$confirmVerification = $grpc.ClientMethod<
          $0.ConfirmVerificationRequest, $0.ConfirmVerificationResponse>(
      '/auth.AuthService/ConfirmVerification',
      ($0.ConfirmVerificationRequest value) => value.writeToBuffer(),
      $0.ConfirmVerificationResponse.fromBuffer);
  static final _$getDocumentUploadURL = $grpc.ClientMethod<
          $0.GetDocumentUploadURLRequest, $0.GetDocumentUploadURLResponse>(
      '/auth.AuthService/GetDocumentUploadURL',
      ($0.GetDocumentUploadURLRequest value) => value.writeToBuffer(),
      $0.GetDocumentUploadURLResponse.fromBuffer);
  static final _$submitDocumentsForReview = $grpc.ClientMethod<
          $0.SubmitDocumentsForReviewRequest,
          $0.SubmitDocumentsForReviewResponse>(
      '/auth.AuthService/SubmitDocumentsForReview',
      ($0.SubmitDocumentsForReviewRequest value) => value.writeToBuffer(),
      $0.SubmitDocumentsForReviewResponse.fromBuffer);
  static final _$confirmBVNName =
      $grpc.ClientMethod<$0.ConfirmBVNNameRequest, $0.ConfirmBVNNameResponse>(
          '/auth.AuthService/ConfirmBVNName',
          ($0.ConfirmBVNNameRequest value) => value.writeToBuffer(),
          $0.ConfirmBVNNameResponse.fromBuffer);
  static final _$lookupUserByUsername =
      $grpc.ClientMethod<$0.LookupUserByUsernameRequest, $0.UserLookupResponse>(
          '/auth.AuthService/LookupUserByUsername',
          ($0.LookupUserByUsernameRequest value) => value.writeToBuffer(),
          $0.UserLookupResponse.fromBuffer);
  static final _$lookupUserByPhone =
      $grpc.ClientMethod<$0.LookupUserByPhoneRequest, $0.UserLookupResponse>(
          '/auth.AuthService/LookupUserByPhone',
          ($0.LookupUserByPhoneRequest value) => value.writeToBuffer(),
          $0.UserLookupResponse.fromBuffer);
  static final _$searchUsers =
      $grpc.ClientMethod<$0.UserSearchRequest, $0.UserSearchResponse>(
          '/auth.AuthService/SearchUsers',
          ($0.UserSearchRequest value) => value.writeToBuffer(),
          $0.UserSearchResponse.fromBuffer);
  static final _$getLinkedSocialAccounts = $grpc.ClientMethod<
          $0.GetLinkedSocialAccountsRequest,
          $0.GetLinkedSocialAccountsResponse>(
      '/auth.AuthService/GetLinkedSocialAccounts',
      ($0.GetLinkedSocialAccountsRequest value) => value.writeToBuffer(),
      $0.GetLinkedSocialAccountsResponse.fromBuffer);
  static final _$linkSocialAccount = $grpc.ClientMethod<
          $0.LinkSocialAccountRequest, $0.LinkSocialAccountResponse>(
      '/auth.AuthService/LinkSocialAccount',
      ($0.LinkSocialAccountRequest value) => value.writeToBuffer(),
      $0.LinkSocialAccountResponse.fromBuffer);
  static final _$unlinkSocialAccount = $grpc.ClientMethod<
          $0.UnlinkSocialAccountRequest, $0.UnlinkSocialAccountResponse>(
      '/auth.AuthService/UnlinkSocialAccount',
      ($0.UnlinkSocialAccountRequest value) => value.writeToBuffer(),
      $0.UnlinkSocialAccountResponse.fromBuffer);
  static final _$setPrimarySocialAccount = $grpc.ClientMethod<
          $0.SetPrimarySocialAccountRequest,
          $0.SetPrimarySocialAccountResponse>(
      '/auth.AuthService/SetPrimarySocialAccount',
      ($0.SetPrimarySocialAccountRequest value) => value.writeToBuffer(),
      $0.SetPrimarySocialAccountResponse.fromBuffer);
  static final _$reauthorizeSocialAccount = $grpc.ClientMethod<
          $0.ReauthorizeSocialAccountRequest,
          $0.ReauthorizeSocialAccountResponse>(
      '/auth.AuthService/ReauthorizeSocialAccount',
      ($0.ReauthorizeSocialAccountRequest value) => value.writeToBuffer(),
      $0.ReauthorizeSocialAccountResponse.fromBuffer);
}

@$pb.GrpcServiceName('auth.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.AuthService';

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
}
