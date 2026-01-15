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
  $async.Future<$0.FacialLoginResponse> facialLogin(
      $grpc.ServiceCall call, $0.FacialLoginRequest request);
  $async.Future<$0.SocialLoginResponse> socialLogin(
      $grpc.ServiceCall call, $0.SocialLoginRequest request);
  $async.Future<$0.EnableTwoFactorResponse> enableTwoFactor(
      $grpc.ServiceCall call, $0.EnableTwoFactorRequest request);
  $async.Future<$0.VerifyTwoFactorResponse> verifyTwoFactor(
      $grpc.ServiceCall call, $0.VerifyTwoFactorRequest request);
  $async.Future<$0.ValidateTokenResponse> validateToken(
      $grpc.ServiceCall call, $0.ValidateTokenRequest request);
  $async.Future<$0.ResendVerificationEmailResponse> resendVerificationEmail(
      $grpc.ServiceCall call, $0.ResendVerificationEmailRequest request);
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
}
