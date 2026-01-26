///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'auth.pb.dart' as $0;
export 'auth.pb.dart';

class AuthServiceClient extends $grpc.Client {
  static final _$signup =
      $grpc.ClientMethod<$0.SignupRequest, $0.SignupResponse>(
          '/auth.AuthService/Signup',
          ($0.SignupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SignupResponse.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$0.LoginRequest, $0.LoginResponse>(
      '/auth.AuthService/Login',
      ($0.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LoginResponse.fromBuffer(value));
  static final _$refreshToken =
      $grpc.ClientMethod<$0.RefreshTokenRequest, $0.RefreshTokenResponse>(
          '/auth.AuthService/RefreshToken',
          ($0.RefreshTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RefreshTokenResponse.fromBuffer(value));
  static final _$logout =
      $grpc.ClientMethod<$0.LogoutRequest, $0.LogoutResponse>(
          '/auth.AuthService/Logout',
          ($0.LogoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.LogoutResponse.fromBuffer(value));
  static final _$verifyEmail =
      $grpc.ClientMethod<$0.VerifyEmailRequest, $0.VerifyEmailResponse>(
          '/auth.AuthService/VerifyEmail',
          ($0.VerifyEmailRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyEmailResponse.fromBuffer(value));
  static final _$verifyPhone =
      $grpc.ClientMethod<$0.VerifyPhoneRequest, $0.VerifyPhoneResponse>(
          '/auth.AuthService/VerifyPhone',
          ($0.VerifyPhoneRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyPhoneResponse.fromBuffer(value));
  static final _$forgotPassword =
      $grpc.ClientMethod<$0.ForgotPasswordRequest, $0.ForgotPasswordResponse>(
          '/auth.AuthService/ForgotPassword',
          ($0.ForgotPasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ForgotPasswordResponse.fromBuffer(value));
  static final _$resetPassword =
      $grpc.ClientMethod<$0.ResetPasswordRequest, $0.ResetPasswordResponse>(
          '/auth.AuthService/ResetPassword',
          ($0.ResetPasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ResetPasswordResponse.fromBuffer(value));
  static final _$getMe = $grpc.ClientMethod<$0.GetMeRequest, $0.GetMeResponse>(
      '/auth.AuthService/GetMe',
      ($0.GetMeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMeResponse.fromBuffer(value));
  static final _$updateProfile =
      $grpc.ClientMethod<$0.UpdateProfileRequest, $0.UpdateProfileResponse>(
          '/auth.AuthService/UpdateProfile',
          ($0.UpdateProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateProfileResponse.fromBuffer(value));
  static final _$facialLogin =
      $grpc.ClientMethod<$0.FacialLoginRequest, $0.FacialLoginResponse>(
          '/auth.AuthService/FacialLogin',
          ($0.FacialLoginRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.FacialLoginResponse.fromBuffer(value));
  static final _$socialLogin =
      $grpc.ClientMethod<$0.SocialLoginRequest, $0.SocialLoginResponse>(
          '/auth.AuthService/SocialLogin',
          ($0.SocialLoginRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SocialLoginResponse.fromBuffer(value));
  static final _$enableTwoFactor =
      $grpc.ClientMethod<$0.EnableTwoFactorRequest, $0.EnableTwoFactorResponse>(
          '/auth.AuthService/EnableTwoFactor',
          ($0.EnableTwoFactorRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.EnableTwoFactorResponse.fromBuffer(value));
  static final _$verifyTwoFactor =
      $grpc.ClientMethod<$0.VerifyTwoFactorRequest, $0.VerifyTwoFactorResponse>(
          '/auth.AuthService/VerifyTwoFactor',
          ($0.VerifyTwoFactorRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyTwoFactorResponse.fromBuffer(value));
  static final _$completeTwoFactorSetup = $grpc.ClientMethod<
          $0.CompleteTwoFactorSetupRequest, $0.CompleteTwoFactorSetupResponse>(
      '/auth.AuthService/CompleteTwoFactorSetup',
      ($0.CompleteTwoFactorSetupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CompleteTwoFactorSetupResponse.fromBuffer(value));
  static final _$disableTwoFactor = $grpc.ClientMethod<
          $0.DisableTwoFactorRequest, $0.DisableTwoFactorResponse>(
      '/auth.AuthService/DisableTwoFactor',
      ($0.DisableTwoFactorRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DisableTwoFactorResponse.fromBuffer(value));
  static final _$getTwoFactorStatus = $grpc.ClientMethod<
          $0.GetTwoFactorStatusRequest, $0.GetTwoFactorStatusResponse>(
      '/auth.AuthService/GetTwoFactorStatus',
      ($0.GetTwoFactorStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTwoFactorStatusResponse.fromBuffer(value));
  static final _$regenerateBackupCodes = $grpc.ClientMethod<
          $0.RegenerateBackupCodesRequest, $0.RegenerateBackupCodesResponse>(
      '/auth.AuthService/RegenerateBackupCodes',
      ($0.RegenerateBackupCodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RegenerateBackupCodesResponse.fromBuffer(value));
  static final _$sendTwoFactorCode = $grpc.ClientMethod<
          $0.SendTwoFactorCodeRequest, $0.SendTwoFactorCodeResponse>(
      '/auth.AuthService/SendTwoFactorCode',
      ($0.SendTwoFactorCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SendTwoFactorCodeResponse.fromBuffer(value));
  static final _$getAvailable2FAMethods = $grpc.ClientMethod<
          $0.GetAvailable2FAMethodsRequest, $0.GetAvailable2FAMethodsResponse>(
      '/auth.AuthService/GetAvailable2FAMethods',
      ($0.GetAvailable2FAMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAvailable2FAMethodsResponse.fromBuffer(value));
  static final _$validateToken =
      $grpc.ClientMethod<$0.ValidateTokenRequest, $0.ValidateTokenResponse>(
          '/auth.AuthService/ValidateToken',
          ($0.ValidateTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ValidateTokenResponse.fromBuffer(value));
  static final _$resendVerificationEmail = $grpc.ClientMethod<
          $0.ResendVerificationEmailRequest,
          $0.ResendVerificationEmailResponse>(
      '/auth.AuthService/ResendVerificationEmail',
      ($0.ResendVerificationEmailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResendVerificationEmailResponse.fromBuffer(value));
  static final _$resendPhoneVerification = $grpc.ClientMethod<
          $0.ResendPhoneVerificationRequest,
          $0.ResendPhoneVerificationResponse>(
      '/auth.AuthService/ResendPhoneVerification',
      ($0.ResendPhoneVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ResendPhoneVerificationResponse.fromBuffer(value));
  static final _$changePassword =
      $grpc.ClientMethod<$0.ChangePasswordRequest, $0.ChangePasswordResponse>(
          '/auth.AuthService/ChangePassword',
          ($0.ChangePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ChangePasswordResponse.fromBuffer(value));
  static final _$loginWithPasscode =
      $grpc.ClientMethod<$0.LoginWithPasscodeRequest, $0.LoginResponse>(
          '/auth.AuthService/LoginWithPasscode',
          ($0.LoginWithPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.LoginResponse.fromBuffer(value));
  static final _$registerPasscode = $grpc.ClientMethod<
          $0.RegisterPasscodeRequest, $0.RegisterPasscodeResponse>(
      '/auth.AuthService/RegisterPasscode',
      ($0.RegisterPasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RegisterPasscodeResponse.fromBuffer(value));
  static final _$changePasscode =
      $grpc.ClientMethod<$0.ChangePasscodeRequest, $0.ChangePasscodeResponse>(
          '/auth.AuthService/ChangePasscode',
          ($0.ChangePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ChangePasscodeResponse.fromBuffer(value));
  static final _$requestPasswordReset = $grpc.ClientMethod<
          $0.RequestPasswordResetRequest, $0.RequestPasswordResetResponse>(
      '/auth.AuthService/RequestPasswordReset',
      ($0.RequestPasswordResetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RequestPasswordResetResponse.fromBuffer(value));
  static final _$requestEmailVerification = $grpc.ClientMethod<
          $0.RequestEmailVerificationRequest,
          $0.RequestEmailVerificationResponse>(
      '/auth.AuthService/RequestEmailVerification',
      ($0.RequestEmailVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RequestEmailVerificationResponse.fromBuffer(value));
  static final _$checkEmailAvailability = $grpc.ClientMethod<
          $0.CheckEmailAvailabilityRequest, $0.CheckEmailAvailabilityResponse>(
      '/auth.AuthService/CheckEmailAvailability',
      ($0.CheckEmailAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CheckEmailAvailabilityResponse.fromBuffer(value));
  static final _$requestPhoneVerification = $grpc.ClientMethod<
          $0.RequestPhoneVerificationRequest,
          $0.RequestPhoneVerificationResponse>(
      '/auth.AuthService/RequestPhoneVerification',
      ($0.RequestPhoneVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RequestPhoneVerificationResponse.fromBuffer(value));
  static final _$verifyPhoneNumber = $grpc.ClientMethod<
          $0.VerifyPhoneNumberRequest, $0.VerifyPhoneNumberResponse>(
      '/auth.AuthService/VerifyPhoneNumber',
      ($0.VerifyPhoneNumberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.VerifyPhoneNumberResponse.fromBuffer(value));
  static final _$getSignupProgress = $grpc.ClientMethod<
          $0.GetSignupProgressRequest, $0.GetSignupProgressResponse>(
      '/auth.AuthService/GetSignupProgress',
      ($0.GetSignupProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetSignupProgressResponse.fromBuffer(value));
  static final _$updateSignupStep = $grpc.ClientMethod<
          $0.UpdateSignupStepRequest, $0.UpdateSignupStepResponse>(
      '/auth.AuthService/UpdateSignupStep',
      ($0.UpdateSignupStepRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateSignupStepResponse.fromBuffer(value));
  static final _$completeSignup =
      $grpc.ClientMethod<$0.CompleteSignupRequest, $0.CompleteSignupResponse>(
          '/auth.AuthService/CompleteSignup',
          ($0.CompleteSignupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CompleteSignupResponse.fromBuffer(value));
  static final _$verifyIdentity =
      $grpc.ClientMethod<$0.VerifyIdentityRequest, $0.VerifyIdentityResponse>(
          '/auth.AuthService/VerifyIdentity',
          ($0.VerifyIdentityRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyIdentityResponse.fromBuffer(value));
  static final _$getIdentityVerificationStatus = $grpc.ClientMethod<
          $0.GetIdentityVerificationStatusRequest,
          $0.GetIdentityVerificationStatusResponse>(
      '/auth.AuthService/GetIdentityVerificationStatus',
      ($0.GetIdentityVerificationStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetIdentityVerificationStatusResponse.fromBuffer(value));
  static final _$initiateKYC =
      $grpc.ClientMethod<$0.InitiateKYCRequest, $0.InitiateKYCResponse>(
          '/auth.AuthService/InitiateKYC',
          ($0.InitiateKYCRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.InitiateKYCResponse.fromBuffer(value));
  static final _$uploadDocument =
      $grpc.ClientMethod<$0.UploadDocumentRequest, $0.UploadDocumentResponse>(
          '/auth.AuthService/UploadDocument',
          ($0.UploadDocumentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UploadDocumentResponse.fromBuffer(value));
  static final _$skipKYCUpgrade =
      $grpc.ClientMethod<$0.SkipKYCUpgradeRequest, $0.SkipKYCUpgradeResponse>(
          '/auth.AuthService/SkipKYCUpgrade',
          ($0.SkipKYCUpgradeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SkipKYCUpgradeResponse.fromBuffer(value));
  static final _$getUserDocuments = $grpc.ClientMethod<
          $0.GetUserDocumentsRequest, $0.GetUserDocumentsResponse>(
      '/auth.AuthService/GetUserDocuments',
      ($0.GetUserDocumentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserDocumentsResponse.fromBuffer(value));
  static final _$lookupUserByUsername =
      $grpc.ClientMethod<$0.LookupUserByUsernameRequest, $0.UserLookupResponse>(
          '/auth.AuthService/LookupUserByUsername',
          ($0.LookupUserByUsernameRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UserLookupResponse.fromBuffer(value));
  static final _$lookupUserByPhone =
      $grpc.ClientMethod<$0.LookupUserByPhoneRequest, $0.UserLookupResponse>(
          '/auth.AuthService/LookupUserByPhone',
          ($0.LookupUserByPhoneRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UserLookupResponse.fromBuffer(value));
  static final _$searchUsersByUsername = $grpc.ClientMethod<
          $0.SearchUsersByUsernameRequest, $0.SearchUsersByUsernameResponse>(
      '/auth.AuthService/SearchUsersByUsername',
      ($0.SearchUsersByUsernameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SearchUsersByUsernameResponse.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SignupResponse> signup($0.SignupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signup, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResponse> login($0.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.RefreshTokenResponse> refreshToken(
      $0.RefreshTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.LogoutResponse> logout($0.LogoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyEmailResponse> verifyEmail(
      $0.VerifyEmailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyEmail, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyPhoneResponse> verifyPhone(
      $0.VerifyPhoneRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPhone, request, options: options);
  }

  $grpc.ResponseFuture<$0.ForgotPasswordResponse> forgotPassword(
      $0.ForgotPasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forgotPassword, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResetPasswordResponse> resetPassword(
      $0.ResetPasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetPassword, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMeResponse> getMe($0.GetMeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMe, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateProfileResponse> updateProfile(
      $0.UpdateProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateProfile, request, options: options);
  }

  $grpc.ResponseFuture<$0.FacialLoginResponse> facialLogin(
      $0.FacialLoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$facialLogin, request, options: options);
  }

  $grpc.ResponseFuture<$0.SocialLoginResponse> socialLogin(
      $0.SocialLoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$socialLogin, request, options: options);
  }

  $grpc.ResponseFuture<$0.EnableTwoFactorResponse> enableTwoFactor(
      $0.EnableTwoFactorRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableTwoFactor, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyTwoFactorResponse> verifyTwoFactor(
      $0.VerifyTwoFactorRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTwoFactor, request, options: options);
  }

  $grpc.ResponseFuture<$0.CompleteTwoFactorSetupResponse>
      completeTwoFactorSetup($0.CompleteTwoFactorSetupRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$completeTwoFactorSetup, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DisableTwoFactorResponse> disableTwoFactor(
      $0.DisableTwoFactorRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableTwoFactor, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTwoFactorStatusResponse> getTwoFactorStatus(
      $0.GetTwoFactorStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTwoFactorStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.RegenerateBackupCodesResponse> regenerateBackupCodes(
      $0.RegenerateBackupCodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$regenerateBackupCodes, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendTwoFactorCodeResponse> sendTwoFactorCode(
      $0.SendTwoFactorCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendTwoFactorCode, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAvailable2FAMethodsResponse>
      getAvailable2FAMethods($0.GetAvailable2FAMethodsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAvailable2FAMethods, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ValidateTokenResponse> validateToken(
      $0.ValidateTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResendVerificationEmailResponse>
      resendVerificationEmail($0.ResendVerificationEmailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resendVerificationEmail, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ResendPhoneVerificationResponse>
      resendPhoneVerification($0.ResendPhoneVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resendPhoneVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ChangePasswordResponse> changePassword(
      $0.ChangePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changePassword, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResponse> loginWithPasscode(
      $0.LoginWithPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$loginWithPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$0.RegisterPasscodeResponse> registerPasscode(
      $0.RegisterPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$0.ChangePasscodeResponse> changePasscode(
      $0.ChangePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestPasswordResetResponse> requestPasswordReset(
      $0.RequestPasswordResetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPasswordReset, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestEmailVerificationResponse>
      requestEmailVerification($0.RequestEmailVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestEmailVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CheckEmailAvailabilityResponse>
      checkEmailAvailability($0.CheckEmailAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkEmailAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RequestPhoneVerificationResponse>
      requestPhoneVerification($0.RequestPhoneVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPhoneVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.VerifyPhoneNumberResponse> verifyPhoneNumber(
      $0.VerifyPhoneNumberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPhoneNumber, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSignupProgressResponse> getSignupProgress(
      $0.GetSignupProgressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSignupProgress, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSignupStepResponse> updateSignupStep(
      $0.UpdateSignupStepRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSignupStep, request, options: options);
  }

  $grpc.ResponseFuture<$0.CompleteSignupResponse> completeSignup(
      $0.CompleteSignupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$completeSignup, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyIdentityResponse> verifyIdentity(
      $0.VerifyIdentityRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyIdentity, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIdentityVerificationStatusResponse>
      getIdentityVerificationStatus(
          $0.GetIdentityVerificationStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIdentityVerificationStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.InitiateKYCResponse> initiateKYC(
      $0.InitiateKYCRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateKYC, request, options: options);
  }

  $grpc.ResponseFuture<$0.UploadDocumentResponse> uploadDocument(
      $0.UploadDocumentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadDocument, request, options: options);
  }

  $grpc.ResponseFuture<$0.SkipKYCUpgradeResponse> skipKYCUpgrade(
      $0.SkipKYCUpgradeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$skipKYCUpgrade, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserDocumentsResponse> getUserDocuments(
      $0.GetUserDocumentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDocuments, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserLookupResponse> lookupUserByUsername(
      $0.LookupUserByUsernameRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupUserByUsername, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserLookupResponse> lookupUserByPhone(
      $0.LookupUserByPhoneRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupUserByPhone, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchUsersByUsernameResponse> searchUsersByUsername(
      $0.SearchUsersByUsernameRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchUsersByUsername, request, options: options);
  }
}

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
    $addMethod($grpc.ServiceMethod<$0.SearchUsersByUsernameRequest,
            $0.SearchUsersByUsernameResponse>(
        'SearchUsersByUsername',
        searchUsersByUsername_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SearchUsersByUsernameRequest.fromBuffer(value),
        ($0.SearchUsersByUsernameResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SignupResponse> signup_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SignupRequest> request) async {
    return signup(call, await request);
  }

  $async.Future<$0.LoginResponse> login_Pre(
      $grpc.ServiceCall call, $async.Future<$0.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$0.RefreshTokenResponse> refreshToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RefreshTokenRequest> request) async {
    return refreshToken(call, await request);
  }

  $async.Future<$0.LogoutResponse> logout_Pre(
      $grpc.ServiceCall call, $async.Future<$0.LogoutRequest> request) async {
    return logout(call, await request);
  }

  $async.Future<$0.VerifyEmailResponse> verifyEmail_Pre($grpc.ServiceCall call,
      $async.Future<$0.VerifyEmailRequest> request) async {
    return verifyEmail(call, await request);
  }

  $async.Future<$0.VerifyPhoneResponse> verifyPhone_Pre($grpc.ServiceCall call,
      $async.Future<$0.VerifyPhoneRequest> request) async {
    return verifyPhone(call, await request);
  }

  $async.Future<$0.ForgotPasswordResponse> forgotPassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ForgotPasswordRequest> request) async {
    return forgotPassword(call, await request);
  }

  $async.Future<$0.ResetPasswordResponse> resetPassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ResetPasswordRequest> request) async {
    return resetPassword(call, await request);
  }

  $async.Future<$0.GetMeResponse> getMe_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetMeRequest> request) async {
    return getMe(call, await request);
  }

  $async.Future<$0.UpdateProfileResponse> updateProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateProfileRequest> request) async {
    return updateProfile(call, await request);
  }

  $async.Future<$0.FacialLoginResponse> facialLogin_Pre($grpc.ServiceCall call,
      $async.Future<$0.FacialLoginRequest> request) async {
    return facialLogin(call, await request);
  }

  $async.Future<$0.SocialLoginResponse> socialLogin_Pre($grpc.ServiceCall call,
      $async.Future<$0.SocialLoginRequest> request) async {
    return socialLogin(call, await request);
  }

  $async.Future<$0.EnableTwoFactorResponse> enableTwoFactor_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.EnableTwoFactorRequest> request) async {
    return enableTwoFactor(call, await request);
  }

  $async.Future<$0.VerifyTwoFactorResponse> verifyTwoFactor_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.VerifyTwoFactorRequest> request) async {
    return verifyTwoFactor(call, await request);
  }

  $async.Future<$0.CompleteTwoFactorSetupResponse> completeTwoFactorSetup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CompleteTwoFactorSetupRequest> request) async {
    return completeTwoFactorSetup(call, await request);
  }

  $async.Future<$0.DisableTwoFactorResponse> disableTwoFactor_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DisableTwoFactorRequest> request) async {
    return disableTwoFactor(call, await request);
  }

  $async.Future<$0.GetTwoFactorStatusResponse> getTwoFactorStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTwoFactorStatusRequest> request) async {
    return getTwoFactorStatus(call, await request);
  }

  $async.Future<$0.RegenerateBackupCodesResponse> regenerateBackupCodes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RegenerateBackupCodesRequest> request) async {
    return regenerateBackupCodes(call, await request);
  }

  $async.Future<$0.SendTwoFactorCodeResponse> sendTwoFactorCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SendTwoFactorCodeRequest> request) async {
    return sendTwoFactorCode(call, await request);
  }

  $async.Future<$0.GetAvailable2FAMethodsResponse> getAvailable2FAMethods_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAvailable2FAMethodsRequest> request) async {
    return getAvailable2FAMethods(call, await request);
  }

  $async.Future<$0.ValidateTokenResponse> validateToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ValidateTokenRequest> request) async {
    return validateToken(call, await request);
  }

  $async.Future<$0.ResendVerificationEmailResponse> resendVerificationEmail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ResendVerificationEmailRequest> request) async {
    return resendVerificationEmail(call, await request);
  }

  $async.Future<$0.ResendPhoneVerificationResponse> resendPhoneVerification_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ResendPhoneVerificationRequest> request) async {
    return resendPhoneVerification(call, await request);
  }

  $async.Future<$0.ChangePasswordResponse> changePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ChangePasswordRequest> request) async {
    return changePassword(call, await request);
  }

  $async.Future<$0.LoginResponse> loginWithPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$0.LoginWithPasscodeRequest> request) async {
    return loginWithPasscode(call, await request);
  }

  $async.Future<$0.RegisterPasscodeResponse> registerPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RegisterPasscodeRequest> request) async {
    return registerPasscode(call, await request);
  }

  $async.Future<$0.ChangePasscodeResponse> changePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ChangePasscodeRequest> request) async {
    return changePasscode(call, await request);
  }

  $async.Future<$0.RequestPasswordResetResponse> requestPasswordReset_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RequestPasswordResetRequest> request) async {
    return requestPasswordReset(call, await request);
  }

  $async.Future<$0.RequestEmailVerificationResponse>
      requestEmailVerification_Pre($grpc.ServiceCall call,
          $async.Future<$0.RequestEmailVerificationRequest> request) async {
    return requestEmailVerification(call, await request);
  }

  $async.Future<$0.CheckEmailAvailabilityResponse> checkEmailAvailability_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CheckEmailAvailabilityRequest> request) async {
    return checkEmailAvailability(call, await request);
  }

  $async.Future<$0.RequestPhoneVerificationResponse>
      requestPhoneVerification_Pre($grpc.ServiceCall call,
          $async.Future<$0.RequestPhoneVerificationRequest> request) async {
    return requestPhoneVerification(call, await request);
  }

  $async.Future<$0.VerifyPhoneNumberResponse> verifyPhoneNumber_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.VerifyPhoneNumberRequest> request) async {
    return verifyPhoneNumber(call, await request);
  }

  $async.Future<$0.GetSignupProgressResponse> getSignupProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSignupProgressRequest> request) async {
    return getSignupProgress(call, await request);
  }

  $async.Future<$0.UpdateSignupStepResponse> updateSignupStep_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateSignupStepRequest> request) async {
    return updateSignupStep(call, await request);
  }

  $async.Future<$0.CompleteSignupResponse> completeSignup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CompleteSignupRequest> request) async {
    return completeSignup(call, await request);
  }

  $async.Future<$0.VerifyIdentityResponse> verifyIdentity_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.VerifyIdentityRequest> request) async {
    return verifyIdentity(call, await request);
  }

  $async.Future<$0.GetIdentityVerificationStatusResponse>
      getIdentityVerificationStatus_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetIdentityVerificationStatusRequest>
              request) async {
    return getIdentityVerificationStatus(call, await request);
  }

  $async.Future<$0.InitiateKYCResponse> initiateKYC_Pre($grpc.ServiceCall call,
      $async.Future<$0.InitiateKYCRequest> request) async {
    return initiateKYC(call, await request);
  }

  $async.Future<$0.UploadDocumentResponse> uploadDocument_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UploadDocumentRequest> request) async {
    return uploadDocument(call, await request);
  }

  $async.Future<$0.SkipKYCUpgradeResponse> skipKYCUpgrade_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SkipKYCUpgradeRequest> request) async {
    return skipKYCUpgrade(call, await request);
  }

  $async.Future<$0.GetUserDocumentsResponse> getUserDocuments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserDocumentsRequest> request) async {
    return getUserDocuments(call, await request);
  }

  $async.Future<$0.UserLookupResponse> lookupUserByUsername_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.LookupUserByUsernameRequest> request) async {
    return lookupUserByUsername(call, await request);
  }

  $async.Future<$0.UserLookupResponse> lookupUserByPhone_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.LookupUserByPhoneRequest> request) async {
    return lookupUserByPhone(call, await request);
  }

  $async.Future<$0.SearchUsersByUsernameResponse> searchUsersByUsername_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SearchUsersByUsernameRequest> request) async {
    return searchUsersByUsername(call, await request);
  }

  $async.Future<$0.SignupResponse> signup(
      $grpc.ServiceCall call, $0.SignupRequest request);
  $async.Future<$0.LoginResponse> login(
      $grpc.ServiceCall call, $0.LoginRequest request);
  $async.Future<$0.RefreshTokenResponse> refreshToken(
      $grpc.ServiceCall call, $0.RefreshTokenRequest request);
  $async.Future<$0.LogoutResponse> logout(
      $grpc.ServiceCall call, $0.LogoutRequest request);
  $async.Future<$0.VerifyEmailResponse> verifyEmail(
      $grpc.ServiceCall call, $0.VerifyEmailRequest request);
  $async.Future<$0.VerifyPhoneResponse> verifyPhone(
      $grpc.ServiceCall call, $0.VerifyPhoneRequest request);
  $async.Future<$0.ForgotPasswordResponse> forgotPassword(
      $grpc.ServiceCall call, $0.ForgotPasswordRequest request);
  $async.Future<$0.ResetPasswordResponse> resetPassword(
      $grpc.ServiceCall call, $0.ResetPasswordRequest request);
  $async.Future<$0.GetMeResponse> getMe(
      $grpc.ServiceCall call, $0.GetMeRequest request);
  $async.Future<$0.UpdateProfileResponse> updateProfile(
      $grpc.ServiceCall call, $0.UpdateProfileRequest request);
  $async.Future<$0.FacialLoginResponse> facialLogin(
      $grpc.ServiceCall call, $0.FacialLoginRequest request);
  $async.Future<$0.SocialLoginResponse> socialLogin(
      $grpc.ServiceCall call, $0.SocialLoginRequest request);
  $async.Future<$0.EnableTwoFactorResponse> enableTwoFactor(
      $grpc.ServiceCall call, $0.EnableTwoFactorRequest request);
  $async.Future<$0.VerifyTwoFactorResponse> verifyTwoFactor(
      $grpc.ServiceCall call, $0.VerifyTwoFactorRequest request);
  $async.Future<$0.CompleteTwoFactorSetupResponse> completeTwoFactorSetup(
      $grpc.ServiceCall call, $0.CompleteTwoFactorSetupRequest request);
  $async.Future<$0.DisableTwoFactorResponse> disableTwoFactor(
      $grpc.ServiceCall call, $0.DisableTwoFactorRequest request);
  $async.Future<$0.GetTwoFactorStatusResponse> getTwoFactorStatus(
      $grpc.ServiceCall call, $0.GetTwoFactorStatusRequest request);
  $async.Future<$0.RegenerateBackupCodesResponse> regenerateBackupCodes(
      $grpc.ServiceCall call, $0.RegenerateBackupCodesRequest request);
  $async.Future<$0.SendTwoFactorCodeResponse> sendTwoFactorCode(
      $grpc.ServiceCall call, $0.SendTwoFactorCodeRequest request);
  $async.Future<$0.GetAvailable2FAMethodsResponse> getAvailable2FAMethods(
      $grpc.ServiceCall call, $0.GetAvailable2FAMethodsRequest request);
  $async.Future<$0.ValidateTokenResponse> validateToken(
      $grpc.ServiceCall call, $0.ValidateTokenRequest request);
  $async.Future<$0.ResendVerificationEmailResponse> resendVerificationEmail(
      $grpc.ServiceCall call, $0.ResendVerificationEmailRequest request);
  $async.Future<$0.ResendPhoneVerificationResponse> resendPhoneVerification(
      $grpc.ServiceCall call, $0.ResendPhoneVerificationRequest request);
  $async.Future<$0.ChangePasswordResponse> changePassword(
      $grpc.ServiceCall call, $0.ChangePasswordRequest request);
  $async.Future<$0.LoginResponse> loginWithPasscode(
      $grpc.ServiceCall call, $0.LoginWithPasscodeRequest request);
  $async.Future<$0.RegisterPasscodeResponse> registerPasscode(
      $grpc.ServiceCall call, $0.RegisterPasscodeRequest request);
  $async.Future<$0.ChangePasscodeResponse> changePasscode(
      $grpc.ServiceCall call, $0.ChangePasscodeRequest request);
  $async.Future<$0.RequestPasswordResetResponse> requestPasswordReset(
      $grpc.ServiceCall call, $0.RequestPasswordResetRequest request);
  $async.Future<$0.RequestEmailVerificationResponse> requestEmailVerification(
      $grpc.ServiceCall call, $0.RequestEmailVerificationRequest request);
  $async.Future<$0.CheckEmailAvailabilityResponse> checkEmailAvailability(
      $grpc.ServiceCall call, $0.CheckEmailAvailabilityRequest request);
  $async.Future<$0.RequestPhoneVerificationResponse> requestPhoneVerification(
      $grpc.ServiceCall call, $0.RequestPhoneVerificationRequest request);
  $async.Future<$0.VerifyPhoneNumberResponse> verifyPhoneNumber(
      $grpc.ServiceCall call, $0.VerifyPhoneNumberRequest request);
  $async.Future<$0.GetSignupProgressResponse> getSignupProgress(
      $grpc.ServiceCall call, $0.GetSignupProgressRequest request);
  $async.Future<$0.UpdateSignupStepResponse> updateSignupStep(
      $grpc.ServiceCall call, $0.UpdateSignupStepRequest request);
  $async.Future<$0.CompleteSignupResponse> completeSignup(
      $grpc.ServiceCall call, $0.CompleteSignupRequest request);
  $async.Future<$0.VerifyIdentityResponse> verifyIdentity(
      $grpc.ServiceCall call, $0.VerifyIdentityRequest request);
  $async.Future<$0.GetIdentityVerificationStatusResponse>
      getIdentityVerificationStatus($grpc.ServiceCall call,
          $0.GetIdentityVerificationStatusRequest request);
  $async.Future<$0.InitiateKYCResponse> initiateKYC(
      $grpc.ServiceCall call, $0.InitiateKYCRequest request);
  $async.Future<$0.UploadDocumentResponse> uploadDocument(
      $grpc.ServiceCall call, $0.UploadDocumentRequest request);
  $async.Future<$0.SkipKYCUpgradeResponse> skipKYCUpgrade(
      $grpc.ServiceCall call, $0.SkipKYCUpgradeRequest request);
  $async.Future<$0.GetUserDocumentsResponse> getUserDocuments(
      $grpc.ServiceCall call, $0.GetUserDocumentsRequest request);
  $async.Future<$0.UserLookupResponse> lookupUserByUsername(
      $grpc.ServiceCall call, $0.LookupUserByUsernameRequest request);
  $async.Future<$0.UserLookupResponse> lookupUserByPhone(
      $grpc.ServiceCall call, $0.LookupUserByPhoneRequest request);
  $async.Future<$0.SearchUsersByUsernameResponse> searchUsersByUsername(
      $grpc.ServiceCall call, $0.SearchUsersByUsernameRequest request);
}
