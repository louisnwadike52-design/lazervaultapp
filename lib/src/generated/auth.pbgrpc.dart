///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'auth.pb.dart' as $4;
export 'auth.pb.dart';

class AuthServiceClient extends $grpc.Client {
  static final _$signup =
      $grpc.ClientMethod<$4.SignupRequest, $4.SignupResponse>(
          '/auth.AuthService/Signup',
          ($4.SignupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.SignupResponse.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$4.LoginRequest, $4.LoginResponse>(
      '/auth.AuthService/Login',
      ($4.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$refreshToken =
      $grpc.ClientMethod<$4.RefreshTokenRequest, $4.RefreshTokenResponse>(
          '/auth.AuthService/RefreshToken',
          ($4.RefreshTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.RefreshTokenResponse.fromBuffer(value));
  static final _$logout =
      $grpc.ClientMethod<$4.LogoutRequest, $4.LogoutResponse>(
          '/auth.AuthService/Logout',
          ($4.LogoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.LogoutResponse.fromBuffer(value));
  static final _$verifyEmail =
      $grpc.ClientMethod<$4.VerifyEmailRequest, $4.VerifyEmailResponse>(
          '/auth.AuthService/VerifyEmail',
          ($4.VerifyEmailRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.VerifyEmailResponse.fromBuffer(value));
  static final _$verifyPhone =
      $grpc.ClientMethod<$4.VerifyPhoneRequest, $4.VerifyPhoneResponse>(
          '/auth.AuthService/VerifyPhone',
          ($4.VerifyPhoneRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.VerifyPhoneResponse.fromBuffer(value));
  static final _$forgotPassword =
      $grpc.ClientMethod<$4.ForgotPasswordRequest, $4.ForgotPasswordResponse>(
          '/auth.AuthService/ForgotPassword',
          ($4.ForgotPasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ForgotPasswordResponse.fromBuffer(value));
  static final _$resetPassword =
      $grpc.ClientMethod<$4.ResetPasswordRequest, $4.ResetPasswordResponse>(
          '/auth.AuthService/ResetPassword',
          ($4.ResetPasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ResetPasswordResponse.fromBuffer(value));
  static final _$getMe = $grpc.ClientMethod<$4.GetMeRequest, $4.GetMeResponse>(
      '/auth.AuthService/GetMe',
      ($4.GetMeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetMeResponse.fromBuffer(value));
  static final _$facialLogin =
      $grpc.ClientMethod<$4.FacialLoginRequest, $4.FacialLoginResponse>(
          '/auth.AuthService/FacialLogin',
          ($4.FacialLoginRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.FacialLoginResponse.fromBuffer(value));
  static final _$socialLogin =
      $grpc.ClientMethod<$4.SocialLoginRequest, $4.SocialLoginResponse>(
          '/auth.AuthService/SocialLogin',
          ($4.SocialLoginRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.SocialLoginResponse.fromBuffer(value));
  static final _$enableTwoFactor =
      $grpc.ClientMethod<$4.EnableTwoFactorRequest, $4.EnableTwoFactorResponse>(
          '/auth.AuthService/EnableTwoFactor',
          ($4.EnableTwoFactorRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.EnableTwoFactorResponse.fromBuffer(value));
  static final _$verifyTwoFactor =
      $grpc.ClientMethod<$4.VerifyTwoFactorRequest, $4.VerifyTwoFactorResponse>(
          '/auth.AuthService/VerifyTwoFactor',
          ($4.VerifyTwoFactorRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.VerifyTwoFactorResponse.fromBuffer(value));
  static final _$validateToken =
      $grpc.ClientMethod<$4.ValidateTokenRequest, $4.ValidateTokenResponse>(
          '/auth.AuthService/ValidateToken',
          ($4.ValidateTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ValidateTokenResponse.fromBuffer(value));
  static final _$resendVerificationEmail = $grpc.ClientMethod<
          $4.ResendVerificationEmailRequest,
          $4.ResendVerificationEmailResponse>(
      '/auth.AuthService/ResendVerificationEmail',
      ($4.ResendVerificationEmailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.ResendVerificationEmailResponse.fromBuffer(value));
  static final _$resendPhoneVerification = $grpc.ClientMethod<
          $4.ResendPhoneVerificationRequest,
          $4.ResendPhoneVerificationResponse>(
      '/auth.AuthService/ResendPhoneVerification',
      ($4.ResendPhoneVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.ResendPhoneVerificationResponse.fromBuffer(value));
  static final _$changePassword =
      $grpc.ClientMethod<$4.ChangePasswordRequest, $4.ChangePasswordResponse>(
          '/auth.AuthService/ChangePassword',
          ($4.ChangePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ChangePasswordResponse.fromBuffer(value));
  static final _$loginWithPasscode =
      $grpc.ClientMethod<$4.LoginWithPasscodeRequest, $4.LoginResponse>(
          '/auth.AuthService/LoginWithPasscode',
          ($4.LoginWithPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$registerPasscode = $grpc.ClientMethod<
          $4.RegisterPasscodeRequest, $4.RegisterPasscodeResponse>(
      '/auth.AuthService/RegisterPasscode',
      ($4.RegisterPasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.RegisterPasscodeResponse.fromBuffer(value));
  static final _$changePasscode =
      $grpc.ClientMethod<$4.ChangePasscodeRequest, $4.ChangePasscodeResponse>(
          '/auth.AuthService/ChangePasscode',
          ($4.ChangePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ChangePasscodeResponse.fromBuffer(value));
  static final _$requestPasswordReset = $grpc.ClientMethod<
          $4.RequestPasswordResetRequest, $4.RequestPasswordResetResponse>(
      '/auth.AuthService/RequestPasswordReset',
      ($4.RequestPasswordResetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.RequestPasswordResetResponse.fromBuffer(value));
  static final _$requestEmailVerification = $grpc.ClientMethod<
          $4.RequestEmailVerificationRequest,
          $4.RequestEmailVerificationResponse>(
      '/auth.AuthService/RequestEmailVerification',
      ($4.RequestEmailVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.RequestEmailVerificationResponse.fromBuffer(value));
  static final _$checkEmailAvailability = $grpc.ClientMethod<
          $4.CheckEmailAvailabilityRequest, $4.CheckEmailAvailabilityResponse>(
      '/auth.AuthService/CheckEmailAvailability',
      ($4.CheckEmailAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.CheckEmailAvailabilityResponse.fromBuffer(value));
  static final _$requestPhoneVerification = $grpc.ClientMethod<
          $4.RequestPhoneVerificationRequest,
          $4.RequestPhoneVerificationResponse>(
      '/auth.AuthService/RequestPhoneVerification',
      ($4.RequestPhoneVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.RequestPhoneVerificationResponse.fromBuffer(value));
  static final _$verifyPhoneNumber = $grpc.ClientMethod<
          $4.VerifyPhoneNumberRequest, $4.VerifyPhoneNumberResponse>(
      '/auth.AuthService/VerifyPhoneNumber',
      ($4.VerifyPhoneNumberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.VerifyPhoneNumberResponse.fromBuffer(value));
  static final _$getSignupProgress = $grpc.ClientMethod<
          $4.GetSignupProgressRequest, $4.GetSignupProgressResponse>(
      '/auth.AuthService/GetSignupProgress',
      ($4.GetSignupProgressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.GetSignupProgressResponse.fromBuffer(value));
  static final _$updateSignupStep = $grpc.ClientMethod<
          $4.UpdateSignupStepRequest, $4.UpdateSignupStepResponse>(
      '/auth.AuthService/UpdateSignupStep',
      ($4.UpdateSignupStepRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.UpdateSignupStepResponse.fromBuffer(value));
  static final _$completeSignup =
      $grpc.ClientMethod<$4.CompleteSignupRequest, $4.CompleteSignupResponse>(
          '/auth.AuthService/CompleteSignup',
          ($4.CompleteSignupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.CompleteSignupResponse.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$4.SignupResponse> signup($4.SignupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signup, request, options: options);
  }

  $grpc.ResponseFuture<$4.LoginResponse> login($4.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$4.RefreshTokenResponse> refreshToken(
      $4.RefreshTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  $grpc.ResponseFuture<$4.LogoutResponse> logout($4.LogoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  $grpc.ResponseFuture<$4.VerifyEmailResponse> verifyEmail(
      $4.VerifyEmailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyEmail, request, options: options);
  }

  $grpc.ResponseFuture<$4.VerifyPhoneResponse> verifyPhone(
      $4.VerifyPhoneRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPhone, request, options: options);
  }

  $grpc.ResponseFuture<$4.ForgotPasswordResponse> forgotPassword(
      $4.ForgotPasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forgotPassword, request, options: options);
  }

  $grpc.ResponseFuture<$4.ResetPasswordResponse> resetPassword(
      $4.ResetPasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetPassword, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetMeResponse> getMe($4.GetMeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMe, request, options: options);
  }

  $grpc.ResponseFuture<$4.FacialLoginResponse> facialLogin(
      $4.FacialLoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$facialLogin, request, options: options);
  }

  $grpc.ResponseFuture<$4.SocialLoginResponse> socialLogin(
      $4.SocialLoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$socialLogin, request, options: options);
  }

  $grpc.ResponseFuture<$4.EnableTwoFactorResponse> enableTwoFactor(
      $4.EnableTwoFactorRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableTwoFactor, request, options: options);
  }

  $grpc.ResponseFuture<$4.VerifyTwoFactorResponse> verifyTwoFactor(
      $4.VerifyTwoFactorRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTwoFactor, request, options: options);
  }

  $grpc.ResponseFuture<$4.ValidateTokenResponse> validateToken(
      $4.ValidateTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateToken, request, options: options);
  }

  $grpc.ResponseFuture<$4.ResendVerificationEmailResponse>
      resendVerificationEmail($4.ResendVerificationEmailRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resendVerificationEmail, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.ResendPhoneVerificationResponse>
      resendPhoneVerification($4.ResendPhoneVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resendPhoneVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.ChangePasswordResponse> changePassword(
      $4.ChangePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changePassword, request, options: options);
  }

  $grpc.ResponseFuture<$4.LoginResponse> loginWithPasscode(
      $4.LoginWithPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$loginWithPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$4.RegisterPasscodeResponse> registerPasscode(
      $4.RegisterPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$4.ChangePasscodeResponse> changePasscode(
      $4.ChangePasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changePasscode, request, options: options);
  }

  $grpc.ResponseFuture<$4.RequestPasswordResetResponse> requestPasswordReset(
      $4.RequestPasswordResetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPasswordReset, request, options: options);
  }

  $grpc.ResponseFuture<$4.RequestEmailVerificationResponse>
      requestEmailVerification($4.RequestEmailVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestEmailVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.CheckEmailAvailabilityResponse>
      checkEmailAvailability($4.CheckEmailAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkEmailAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.RequestPhoneVerificationResponse>
      requestPhoneVerification($4.RequestPhoneVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPhoneVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.VerifyPhoneNumberResponse> verifyPhoneNumber(
      $4.VerifyPhoneNumberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPhoneNumber, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetSignupProgressResponse> getSignupProgress(
      $4.GetSignupProgressRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSignupProgress, request, options: options);
  }

  $grpc.ResponseFuture<$4.UpdateSignupStepResponse> updateSignupStep(
      $4.UpdateSignupStepRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSignupStep, request, options: options);
  }

  $grpc.ResponseFuture<$4.CompleteSignupResponse> completeSignup(
      $4.CompleteSignupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$completeSignup, request, options: options);
  }
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.SignupRequest, $4.SignupResponse>(
        'Signup',
        signup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.SignupRequest.fromBuffer(value),
        ($4.SignupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.LoginRequest, $4.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.LoginRequest.fromBuffer(value),
        ($4.LoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.RefreshTokenRequest, $4.RefreshTokenResponse>(
            'RefreshToken',
            refreshToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.RefreshTokenRequest.fromBuffer(value),
            ($4.RefreshTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.LogoutRequest, $4.LogoutResponse>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.LogoutRequest.fromBuffer(value),
        ($4.LogoutResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.VerifyEmailRequest, $4.VerifyEmailResponse>(
            'VerifyEmail',
            verifyEmail_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.VerifyEmailRequest.fromBuffer(value),
            ($4.VerifyEmailResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.VerifyPhoneRequest, $4.VerifyPhoneResponse>(
            'VerifyPhone',
            verifyPhone_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.VerifyPhoneRequest.fromBuffer(value),
            ($4.VerifyPhoneResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ForgotPasswordRequest,
            $4.ForgotPasswordResponse>(
        'ForgotPassword',
        forgotPassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.ForgotPasswordRequest.fromBuffer(value),
        ($4.ForgotPasswordResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.ResetPasswordRequest, $4.ResetPasswordResponse>(
            'ResetPassword',
            resetPassword_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.ResetPasswordRequest.fromBuffer(value),
            ($4.ResetPasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetMeRequest, $4.GetMeResponse>(
        'GetMe',
        getMe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetMeRequest.fromBuffer(value),
        ($4.GetMeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.FacialLoginRequest, $4.FacialLoginResponse>(
            'FacialLogin',
            facialLogin_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.FacialLoginRequest.fromBuffer(value),
            ($4.FacialLoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.SocialLoginRequest, $4.SocialLoginResponse>(
            'SocialLogin',
            socialLogin_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.SocialLoginRequest.fromBuffer(value),
            ($4.SocialLoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.EnableTwoFactorRequest,
            $4.EnableTwoFactorResponse>(
        'EnableTwoFactor',
        enableTwoFactor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.EnableTwoFactorRequest.fromBuffer(value),
        ($4.EnableTwoFactorResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.VerifyTwoFactorRequest,
            $4.VerifyTwoFactorResponse>(
        'VerifyTwoFactor',
        verifyTwoFactor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.VerifyTwoFactorRequest.fromBuffer(value),
        ($4.VerifyTwoFactorResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.ValidateTokenRequest, $4.ValidateTokenResponse>(
            'ValidateToken',
            validateToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.ValidateTokenRequest.fromBuffer(value),
            ($4.ValidateTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ResendVerificationEmailRequest,
            $4.ResendVerificationEmailResponse>(
        'ResendVerificationEmail',
        resendVerificationEmail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.ResendVerificationEmailRequest.fromBuffer(value),
        ($4.ResendVerificationEmailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ResendPhoneVerificationRequest,
            $4.ResendPhoneVerificationResponse>(
        'ResendPhoneVerification',
        resendPhoneVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.ResendPhoneVerificationRequest.fromBuffer(value),
        ($4.ResendPhoneVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ChangePasswordRequest,
            $4.ChangePasswordResponse>(
        'ChangePassword',
        changePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.ChangePasswordRequest.fromBuffer(value),
        ($4.ChangePasswordResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.LoginWithPasscodeRequest, $4.LoginResponse>(
            'LoginWithPasscode',
            loginWithPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.LoginWithPasscodeRequest.fromBuffer(value),
            ($4.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.RegisterPasscodeRequest,
            $4.RegisterPasscodeResponse>(
        'RegisterPasscode',
        registerPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.RegisterPasscodeRequest.fromBuffer(value),
        ($4.RegisterPasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ChangePasscodeRequest,
            $4.ChangePasscodeResponse>(
        'ChangePasscode',
        changePasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.ChangePasscodeRequest.fromBuffer(value),
        ($4.ChangePasscodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.RequestPasswordResetRequest,
            $4.RequestPasswordResetResponse>(
        'RequestPasswordReset',
        requestPasswordReset_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.RequestPasswordResetRequest.fromBuffer(value),
        ($4.RequestPasswordResetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.RequestEmailVerificationRequest,
            $4.RequestEmailVerificationResponse>(
        'RequestEmailVerification',
        requestEmailVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.RequestEmailVerificationRequest.fromBuffer(value),
        ($4.RequestEmailVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.CheckEmailAvailabilityRequest,
            $4.CheckEmailAvailabilityResponse>(
        'CheckEmailAvailability',
        checkEmailAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.CheckEmailAvailabilityRequest.fromBuffer(value),
        ($4.CheckEmailAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.RequestPhoneVerificationRequest,
            $4.RequestPhoneVerificationResponse>(
        'RequestPhoneVerification',
        requestPhoneVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.RequestPhoneVerificationRequest.fromBuffer(value),
        ($4.RequestPhoneVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.VerifyPhoneNumberRequest,
            $4.VerifyPhoneNumberResponse>(
        'VerifyPhoneNumber',
        verifyPhoneNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.VerifyPhoneNumberRequest.fromBuffer(value),
        ($4.VerifyPhoneNumberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetSignupProgressRequest,
            $4.GetSignupProgressResponse>(
        'GetSignupProgress',
        getSignupProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.GetSignupProgressRequest.fromBuffer(value),
        ($4.GetSignupProgressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UpdateSignupStepRequest,
            $4.UpdateSignupStepResponse>(
        'UpdateSignupStep',
        updateSignupStep_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UpdateSignupStepRequest.fromBuffer(value),
        ($4.UpdateSignupStepResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.CompleteSignupRequest,
            $4.CompleteSignupResponse>(
        'CompleteSignup',
        completeSignup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.CompleteSignupRequest.fromBuffer(value),
        ($4.CompleteSignupResponse value) => value.writeToBuffer()));
  }

  $async.Future<$4.SignupResponse> signup_Pre(
      $grpc.ServiceCall call, $async.Future<$4.SignupRequest> request) async {
    return signup(call, await request);
  }

  $async.Future<$4.LoginResponse> login_Pre(
      $grpc.ServiceCall call, $async.Future<$4.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$4.RefreshTokenResponse> refreshToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.RefreshTokenRequest> request) async {
    return refreshToken(call, await request);
  }

  $async.Future<$4.LogoutResponse> logout_Pre(
      $grpc.ServiceCall call, $async.Future<$4.LogoutRequest> request) async {
    return logout(call, await request);
  }

  $async.Future<$4.VerifyEmailResponse> verifyEmail_Pre($grpc.ServiceCall call,
      $async.Future<$4.VerifyEmailRequest> request) async {
    return verifyEmail(call, await request);
  }

  $async.Future<$4.VerifyPhoneResponse> verifyPhone_Pre($grpc.ServiceCall call,
      $async.Future<$4.VerifyPhoneRequest> request) async {
    return verifyPhone(call, await request);
  }

  $async.Future<$4.ForgotPasswordResponse> forgotPassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ForgotPasswordRequest> request) async {
    return forgotPassword(call, await request);
  }

  $async.Future<$4.ResetPasswordResponse> resetPassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ResetPasswordRequest> request) async {
    return resetPassword(call, await request);
  }

  $async.Future<$4.GetMeResponse> getMe_Pre(
      $grpc.ServiceCall call, $async.Future<$4.GetMeRequest> request) async {
    return getMe(call, await request);
  }

  $async.Future<$4.FacialLoginResponse> facialLogin_Pre($grpc.ServiceCall call,
      $async.Future<$4.FacialLoginRequest> request) async {
    return facialLogin(call, await request);
  }

  $async.Future<$4.SocialLoginResponse> socialLogin_Pre($grpc.ServiceCall call,
      $async.Future<$4.SocialLoginRequest> request) async {
    return socialLogin(call, await request);
  }

  $async.Future<$4.EnableTwoFactorResponse> enableTwoFactor_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.EnableTwoFactorRequest> request) async {
    return enableTwoFactor(call, await request);
  }

  $async.Future<$4.VerifyTwoFactorResponse> verifyTwoFactor_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.VerifyTwoFactorRequest> request) async {
    return verifyTwoFactor(call, await request);
  }

  $async.Future<$4.ValidateTokenResponse> validateToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ValidateTokenRequest> request) async {
    return validateToken(call, await request);
  }

  $async.Future<$4.ResendVerificationEmailResponse> resendVerificationEmail_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ResendVerificationEmailRequest> request) async {
    return resendVerificationEmail(call, await request);
  }

  $async.Future<$4.ResendPhoneVerificationResponse> resendPhoneVerification_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ResendPhoneVerificationRequest> request) async {
    return resendPhoneVerification(call, await request);
  }

  $async.Future<$4.ChangePasswordResponse> changePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ChangePasswordRequest> request) async {
    return changePassword(call, await request);
  }

  $async.Future<$4.LoginResponse> loginWithPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$4.LoginWithPasscodeRequest> request) async {
    return loginWithPasscode(call, await request);
  }

  $async.Future<$4.RegisterPasscodeResponse> registerPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.RegisterPasscodeRequest> request) async {
    return registerPasscode(call, await request);
  }

  $async.Future<$4.ChangePasscodeResponse> changePasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ChangePasscodeRequest> request) async {
    return changePasscode(call, await request);
  }

  $async.Future<$4.RequestPasswordResetResponse> requestPasswordReset_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.RequestPasswordResetRequest> request) async {
    return requestPasswordReset(call, await request);
  }

  $async.Future<$4.RequestEmailVerificationResponse>
      requestEmailVerification_Pre($grpc.ServiceCall call,
          $async.Future<$4.RequestEmailVerificationRequest> request) async {
    return requestEmailVerification(call, await request);
  }

  $async.Future<$4.CheckEmailAvailabilityResponse> checkEmailAvailability_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.CheckEmailAvailabilityRequest> request) async {
    return checkEmailAvailability(call, await request);
  }

  $async.Future<$4.RequestPhoneVerificationResponse>
      requestPhoneVerification_Pre($grpc.ServiceCall call,
          $async.Future<$4.RequestPhoneVerificationRequest> request) async {
    return requestPhoneVerification(call, await request);
  }

  $async.Future<$4.VerifyPhoneNumberResponse> verifyPhoneNumber_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.VerifyPhoneNumberRequest> request) async {
    return verifyPhoneNumber(call, await request);
  }

  $async.Future<$4.GetSignupProgressResponse> getSignupProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.GetSignupProgressRequest> request) async {
    return getSignupProgress(call, await request);
  }

  $async.Future<$4.UpdateSignupStepResponse> updateSignupStep_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.UpdateSignupStepRequest> request) async {
    return updateSignupStep(call, await request);
  }

  $async.Future<$4.CompleteSignupResponse> completeSignup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.CompleteSignupRequest> request) async {
    return completeSignup(call, await request);
  }

  $async.Future<$4.SignupResponse> signup(
      $grpc.ServiceCall call, $4.SignupRequest request);
  $async.Future<$4.LoginResponse> login(
      $grpc.ServiceCall call, $4.LoginRequest request);
  $async.Future<$4.RefreshTokenResponse> refreshToken(
      $grpc.ServiceCall call, $4.RefreshTokenRequest request);
  $async.Future<$4.LogoutResponse> logout(
      $grpc.ServiceCall call, $4.LogoutRequest request);
  $async.Future<$4.VerifyEmailResponse> verifyEmail(
      $grpc.ServiceCall call, $4.VerifyEmailRequest request);
  $async.Future<$4.VerifyPhoneResponse> verifyPhone(
      $grpc.ServiceCall call, $4.VerifyPhoneRequest request);
  $async.Future<$4.ForgotPasswordResponse> forgotPassword(
      $grpc.ServiceCall call, $4.ForgotPasswordRequest request);
  $async.Future<$4.ResetPasswordResponse> resetPassword(
      $grpc.ServiceCall call, $4.ResetPasswordRequest request);
  $async.Future<$4.GetMeResponse> getMe(
      $grpc.ServiceCall call, $4.GetMeRequest request);
  $async.Future<$4.FacialLoginResponse> facialLogin(
      $grpc.ServiceCall call, $4.FacialLoginRequest request);
  $async.Future<$4.SocialLoginResponse> socialLogin(
      $grpc.ServiceCall call, $4.SocialLoginRequest request);
  $async.Future<$4.EnableTwoFactorResponse> enableTwoFactor(
      $grpc.ServiceCall call, $4.EnableTwoFactorRequest request);
  $async.Future<$4.VerifyTwoFactorResponse> verifyTwoFactor(
      $grpc.ServiceCall call, $4.VerifyTwoFactorRequest request);
  $async.Future<$4.ValidateTokenResponse> validateToken(
      $grpc.ServiceCall call, $4.ValidateTokenRequest request);
  $async.Future<$4.ResendVerificationEmailResponse> resendVerificationEmail(
      $grpc.ServiceCall call, $4.ResendVerificationEmailRequest request);
  $async.Future<$4.ResendPhoneVerificationResponse> resendPhoneVerification(
      $grpc.ServiceCall call, $4.ResendPhoneVerificationRequest request);
  $async.Future<$4.ChangePasswordResponse> changePassword(
      $grpc.ServiceCall call, $4.ChangePasswordRequest request);
  $async.Future<$4.LoginResponse> loginWithPasscode(
      $grpc.ServiceCall call, $4.LoginWithPasscodeRequest request);
  $async.Future<$4.RegisterPasscodeResponse> registerPasscode(
      $grpc.ServiceCall call, $4.RegisterPasscodeRequest request);
  $async.Future<$4.ChangePasscodeResponse> changePasscode(
      $grpc.ServiceCall call, $4.ChangePasscodeRequest request);
  $async.Future<$4.RequestPasswordResetResponse> requestPasswordReset(
      $grpc.ServiceCall call, $4.RequestPasswordResetRequest request);
  $async.Future<$4.RequestEmailVerificationResponse> requestEmailVerification(
      $grpc.ServiceCall call, $4.RequestEmailVerificationRequest request);
  $async.Future<$4.CheckEmailAvailabilityResponse> checkEmailAvailability(
      $grpc.ServiceCall call, $4.CheckEmailAvailabilityRequest request);
  $async.Future<$4.RequestPhoneVerificationResponse> requestPhoneVerification(
      $grpc.ServiceCall call, $4.RequestPhoneVerificationRequest request);
  $async.Future<$4.VerifyPhoneNumberResponse> verifyPhoneNumber(
      $grpc.ServiceCall call, $4.VerifyPhoneNumberRequest request);
  $async.Future<$4.GetSignupProgressResponse> getSignupProgress(
      $grpc.ServiceCall call, $4.GetSignupProgressRequest request);
  $async.Future<$4.UpdateSignupStepResponse> updateSignupStep(
      $grpc.ServiceCall call, $4.UpdateSignupStepRequest request);
  $async.Future<$4.CompleteSignupResponse> completeSignup(
      $grpc.ServiceCall call, $4.CompleteSignupRequest request);
}
