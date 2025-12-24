///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'auth.pb.dart' as $5;
export 'auth.pb.dart';

class AuthServiceClient extends $grpc.Client {
  static final _$login = $grpc.ClientMethod<$5.LoginRequest, $5.LoginResponse>(
      '/pb.AuthService/Login',
      ($5.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.LoginResponse.fromBuffer(value));
  static final _$loginWithPasscode =
      $grpc.ClientMethod<$5.LoginWithPasscodeRequest, $5.LoginResponse>(
          '/pb.AuthService/LoginWithPasscode',
          ($5.LoginWithPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.LoginResponse.fromBuffer(value));
  static final _$registerPasscode = $grpc.ClientMethod<
          $5.RegisterPasscodeRequest, $5.RegisterPasscodeResponse>(
      '/pb.AuthService/RegisterPasscode',
      ($5.RegisterPasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.RegisterPasscodeResponse.fromBuffer(value));
  static final _$refreshToken =
      $grpc.ClientMethod<$5.RefreshTokenRequest, $5.RefreshTokenResponse>(
          '/pb.AuthService/RefreshToken',
          ($5.RefreshTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.RefreshTokenResponse.fromBuffer(value));
  static final _$logout =
      $grpc.ClientMethod<$5.LogoutRequest, $5.LogoutResponse>(
          '/pb.AuthService/Logout',
          ($5.LogoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.LogoutResponse.fromBuffer(value));
  static final _$requestEmailVerification = $grpc.ClientMethod<
          $5.RequestEmailVerificationRequest,
          $5.RequestEmailVerificationResponse>(
      '/pb.AuthService/RequestEmailVerification',
      ($5.RequestEmailVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.RequestEmailVerificationResponse.fromBuffer(value));
  static final _$verifyEmail =
      $grpc.ClientMethod<$5.VerifyEmailRequest, $5.VerifyEmailResponse>(
          '/pb.AuthService/VerifyEmail',
          ($5.VerifyEmailRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.VerifyEmailResponse.fromBuffer(value));
  static final _$requestPasswordReset = $grpc.ClientMethod<
          $5.RequestPasswordResetRequest, $5.RequestPasswordResetResponse>(
      '/pb.AuthService/RequestPasswordReset',
      ($5.RequestPasswordResetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.RequestPasswordResetResponse.fromBuffer(value));
  static final _$resetPassword =
      $grpc.ClientMethod<$5.ResetPasswordRequest, $5.ResetPasswordResponse>(
          '/pb.AuthService/ResetPassword',
          ($5.ResetPasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.ResetPasswordResponse.fromBuffer(value));
  static final _$signInWithGoogle =
      $grpc.ClientMethod<$5.SignInWithGoogleRequest, $5.LoginResponse>(
          '/pb.AuthService/SignInWithGoogle',
          ($5.SignInWithGoogleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.LoginResponse.fromBuffer(value));
  static final _$signInWithApple =
      $grpc.ClientMethod<$5.SignInWithAppleRequest, $5.LoginResponse>(
          '/pb.AuthService/SignInWithApple',
          ($5.SignInWithAppleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.LoginResponse.fromBuffer(value));
  static final _$checkEmailAvailability = $grpc.ClientMethod<
          $5.CheckEmailAvailabilityRequest, $5.CheckEmailAvailabilityResponse>(
      '/pb.AuthService/CheckEmailAvailability',
      ($5.CheckEmailAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.CheckEmailAvailabilityResponse.fromBuffer(value));
  static final _$verifyPin =
      $grpc.ClientMethod<$5.VerifyPinRequest, $5.VerifyPinResponse>(
          '/pb.AuthService/VerifyPin',
          ($5.VerifyPinRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.VerifyPinResponse.fromBuffer(value));
  static final _$requestPhoneVerification = $grpc.ClientMethod<
          $5.RequestPhoneVerificationRequest,
          $5.RequestPhoneVerificationResponse>(
      '/pb.AuthService/RequestPhoneVerification',
      ($5.RequestPhoneVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.RequestPhoneVerificationResponse.fromBuffer(value));
  static final _$verifyPhoneNumber = $grpc.ClientMethod<
          $5.VerifyPhoneNumberRequest, $5.VerifyPhoneNumberResponse>(
      '/pb.AuthService/VerifyPhoneNumber',
      ($5.VerifyPhoneNumberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.VerifyPhoneNumberResponse.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$5.LoginResponse> login($5.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$5.LoginResponse> loginWithPasscode(
      $5.LoginWithPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$loginWithPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$5.RegisterPasscodeResponse> registerPasscode(
      $5.RegisterPasscodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerPasscode, request, options: options);
  }

  $grpc.ResponseFuture<$5.RefreshTokenResponse> refreshToken(
      $5.RefreshTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  $grpc.ResponseFuture<$5.LogoutResponse> logout($5.LogoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  $grpc.ResponseFuture<$5.RequestEmailVerificationResponse>
      requestEmailVerification($5.RequestEmailVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestEmailVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$5.VerifyEmailResponse> verifyEmail(
      $5.VerifyEmailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyEmail, request, options: options);
  }

  $grpc.ResponseFuture<$5.RequestPasswordResetResponse> requestPasswordReset(
      $5.RequestPasswordResetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPasswordReset, request, options: options);
  }

  $grpc.ResponseFuture<$5.ResetPasswordResponse> resetPassword(
      $5.ResetPasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetPassword, request, options: options);
  }

  $grpc.ResponseFuture<$5.LoginResponse> signInWithGoogle(
      $5.SignInWithGoogleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signInWithGoogle, request, options: options);
  }

  $grpc.ResponseFuture<$5.LoginResponse> signInWithApple(
      $5.SignInWithAppleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signInWithApple, request, options: options);
  }

  $grpc.ResponseFuture<$5.CheckEmailAvailabilityResponse>
      checkEmailAvailability($5.CheckEmailAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkEmailAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$5.VerifyPinResponse> verifyPin(
      $5.VerifyPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPin, request, options: options);
  }

  $grpc.ResponseFuture<$5.RequestPhoneVerificationResponse>
      requestPhoneVerification($5.RequestPhoneVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPhoneVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$5.VerifyPhoneNumberResponse> verifyPhoneNumber(
      $5.VerifyPhoneNumberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPhoneNumber, request, options: options);
  }
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.LoginRequest, $5.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.LoginRequest.fromBuffer(value),
        ($5.LoginResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$5.LoginWithPasscodeRequest, $5.LoginResponse>(
            'LoginWithPasscode',
            loginWithPasscode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.LoginWithPasscodeRequest.fromBuffer(value),
            ($5.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.RegisterPasscodeRequest,
            $5.RegisterPasscodeResponse>(
        'RegisterPasscode',
        registerPasscode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.RegisterPasscodeRequest.fromBuffer(value),
        ($5.RegisterPasscodeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$5.RefreshTokenRequest, $5.RefreshTokenResponse>(
            'RefreshToken',
            refreshToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.RefreshTokenRequest.fromBuffer(value),
            ($5.RefreshTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.LogoutRequest, $5.LogoutResponse>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.LogoutRequest.fromBuffer(value),
        ($5.LogoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.RequestEmailVerificationRequest,
            $5.RequestEmailVerificationResponse>(
        'RequestEmailVerification',
        requestEmailVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.RequestEmailVerificationRequest.fromBuffer(value),
        ($5.RequestEmailVerificationResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$5.VerifyEmailRequest, $5.VerifyEmailResponse>(
            'VerifyEmail',
            verifyEmail_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.VerifyEmailRequest.fromBuffer(value),
            ($5.VerifyEmailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.RequestPasswordResetRequest,
            $5.RequestPasswordResetResponse>(
        'RequestPasswordReset',
        requestPasswordReset_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.RequestPasswordResetRequest.fromBuffer(value),
        ($5.RequestPasswordResetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$5.ResetPasswordRequest, $5.ResetPasswordResponse>(
            'ResetPassword',
            resetPassword_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.ResetPasswordRequest.fromBuffer(value),
            ($5.ResetPasswordResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$5.SignInWithGoogleRequest, $5.LoginResponse>(
            'SignInWithGoogle',
            signInWithGoogle_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.SignInWithGoogleRequest.fromBuffer(value),
            ($5.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SignInWithAppleRequest, $5.LoginResponse>(
        'SignInWithApple',
        signInWithApple_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.SignInWithAppleRequest.fromBuffer(value),
        ($5.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.CheckEmailAvailabilityRequest,
            $5.CheckEmailAvailabilityResponse>(
        'CheckEmailAvailability',
        checkEmailAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.CheckEmailAvailabilityRequest.fromBuffer(value),
        ($5.CheckEmailAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.VerifyPinRequest, $5.VerifyPinResponse>(
        'VerifyPin',
        verifyPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.VerifyPinRequest.fromBuffer(value),
        ($5.VerifyPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.RequestPhoneVerificationRequest,
            $5.RequestPhoneVerificationResponse>(
        'RequestPhoneVerification',
        requestPhoneVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.RequestPhoneVerificationRequest.fromBuffer(value),
        ($5.RequestPhoneVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.VerifyPhoneNumberRequest,
            $5.VerifyPhoneNumberResponse>(
        'VerifyPhoneNumber',
        verifyPhoneNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.VerifyPhoneNumberRequest.fromBuffer(value),
        ($5.VerifyPhoneNumberResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.LoginResponse> login_Pre(
      $grpc.ServiceCall call, $async.Future<$5.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$5.LoginResponse> loginWithPasscode_Pre($grpc.ServiceCall call,
      $async.Future<$5.LoginWithPasscodeRequest> request) async {
    return loginWithPasscode(call, await request);
  }

  $async.Future<$5.RegisterPasscodeResponse> registerPasscode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.RegisterPasscodeRequest> request) async {
    return registerPasscode(call, await request);
  }

  $async.Future<$5.RefreshTokenResponse> refreshToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.RefreshTokenRequest> request) async {
    return refreshToken(call, await request);
  }

  $async.Future<$5.LogoutResponse> logout_Pre(
      $grpc.ServiceCall call, $async.Future<$5.LogoutRequest> request) async {
    return logout(call, await request);
  }

  $async.Future<$5.RequestEmailVerificationResponse>
      requestEmailVerification_Pre($grpc.ServiceCall call,
          $async.Future<$5.RequestEmailVerificationRequest> request) async {
    return requestEmailVerification(call, await request);
  }

  $async.Future<$5.VerifyEmailResponse> verifyEmail_Pre($grpc.ServiceCall call,
      $async.Future<$5.VerifyEmailRequest> request) async {
    return verifyEmail(call, await request);
  }

  $async.Future<$5.RequestPasswordResetResponse> requestPasswordReset_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.RequestPasswordResetRequest> request) async {
    return requestPasswordReset(call, await request);
  }

  $async.Future<$5.ResetPasswordResponse> resetPassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.ResetPasswordRequest> request) async {
    return resetPassword(call, await request);
  }

  $async.Future<$5.LoginResponse> signInWithGoogle_Pre($grpc.ServiceCall call,
      $async.Future<$5.SignInWithGoogleRequest> request) async {
    return signInWithGoogle(call, await request);
  }

  $async.Future<$5.LoginResponse> signInWithApple_Pre($grpc.ServiceCall call,
      $async.Future<$5.SignInWithAppleRequest> request) async {
    return signInWithApple(call, await request);
  }

  $async.Future<$5.CheckEmailAvailabilityResponse> checkEmailAvailability_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.CheckEmailAvailabilityRequest> request) async {
    return checkEmailAvailability(call, await request);
  }

  $async.Future<$5.VerifyPinResponse> verifyPin_Pre($grpc.ServiceCall call,
      $async.Future<$5.VerifyPinRequest> request) async {
    return verifyPin(call, await request);
  }

  $async.Future<$5.RequestPhoneVerificationResponse>
      requestPhoneVerification_Pre($grpc.ServiceCall call,
          $async.Future<$5.RequestPhoneVerificationRequest> request) async {
    return requestPhoneVerification(call, await request);
  }

  $async.Future<$5.VerifyPhoneNumberResponse> verifyPhoneNumber_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.VerifyPhoneNumberRequest> request) async {
    return verifyPhoneNumber(call, await request);
  }

  $async.Future<$5.LoginResponse> login(
      $grpc.ServiceCall call, $5.LoginRequest request);
  $async.Future<$5.LoginResponse> loginWithPasscode(
      $grpc.ServiceCall call, $5.LoginWithPasscodeRequest request);
  $async.Future<$5.RegisterPasscodeResponse> registerPasscode(
      $grpc.ServiceCall call, $5.RegisterPasscodeRequest request);
  $async.Future<$5.RefreshTokenResponse> refreshToken(
      $grpc.ServiceCall call, $5.RefreshTokenRequest request);
  $async.Future<$5.LogoutResponse> logout(
      $grpc.ServiceCall call, $5.LogoutRequest request);
  $async.Future<$5.RequestEmailVerificationResponse> requestEmailVerification(
      $grpc.ServiceCall call, $5.RequestEmailVerificationRequest request);
  $async.Future<$5.VerifyEmailResponse> verifyEmail(
      $grpc.ServiceCall call, $5.VerifyEmailRequest request);
  $async.Future<$5.RequestPasswordResetResponse> requestPasswordReset(
      $grpc.ServiceCall call, $5.RequestPasswordResetRequest request);
  $async.Future<$5.ResetPasswordResponse> resetPassword(
      $grpc.ServiceCall call, $5.ResetPasswordRequest request);
  $async.Future<$5.LoginResponse> signInWithGoogle(
      $grpc.ServiceCall call, $5.SignInWithGoogleRequest request);
  $async.Future<$5.LoginResponse> signInWithApple(
      $grpc.ServiceCall call, $5.SignInWithAppleRequest request);
  $async.Future<$5.CheckEmailAvailabilityResponse> checkEmailAvailability(
      $grpc.ServiceCall call, $5.CheckEmailAvailabilityRequest request);
  $async.Future<$5.VerifyPinResponse> verifyPin(
      $grpc.ServiceCall call, $5.VerifyPinRequest request);
  $async.Future<$5.RequestPhoneVerificationResponse> requestPhoneVerification(
      $grpc.ServiceCall call, $5.RequestPhoneVerificationRequest request);
  $async.Future<$5.VerifyPhoneNumberResponse> verifyPhoneNumber(
      $grpc.ServiceCall call, $5.VerifyPhoneNumberRequest request);
}
