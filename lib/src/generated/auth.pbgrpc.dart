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
  static final _$login = $grpc.ClientMethod<$4.LoginRequest, $4.LoginResponse>(
      '/pb.AuthService/Login',
      ($4.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$loginWithPasscode =
      $grpc.ClientMethod<$4.LoginWithPasscodeRequest, $4.LoginResponse>(
          '/pb.AuthService/LoginWithPasscode',
          ($4.LoginWithPasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$registerPasscode = $grpc.ClientMethod<
          $4.RegisterPasscodeRequest, $4.RegisterPasscodeResponse>(
      '/pb.AuthService/RegisterPasscode',
      ($4.RegisterPasscodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.RegisterPasscodeResponse.fromBuffer(value));
  static final _$changePasscode =
      $grpc.ClientMethod<$4.ChangePasscodeRequest, $4.ChangePasscodeResponse>(
          '/pb.AuthService/ChangePasscode',
          ($4.ChangePasscodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ChangePasscodeResponse.fromBuffer(value));
  static final _$refreshToken =
      $grpc.ClientMethod<$4.RefreshTokenRequest, $4.RefreshTokenResponse>(
          '/pb.AuthService/RefreshToken',
          ($4.RefreshTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.RefreshTokenResponse.fromBuffer(value));
  static final _$logout =
      $grpc.ClientMethod<$4.LogoutRequest, $4.LogoutResponse>(
          '/pb.AuthService/Logout',
          ($4.LogoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.LogoutResponse.fromBuffer(value));
  static final _$requestEmailVerification = $grpc.ClientMethod<
          $4.RequestEmailVerificationRequest,
          $4.RequestEmailVerificationResponse>(
      '/pb.AuthService/RequestEmailVerification',
      ($4.RequestEmailVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.RequestEmailVerificationResponse.fromBuffer(value));
  static final _$verifyEmail =
      $grpc.ClientMethod<$4.VerifyEmailRequest, $4.VerifyEmailResponse>(
          '/pb.AuthService/VerifyEmail',
          ($4.VerifyEmailRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.VerifyEmailResponse.fromBuffer(value));
  static final _$requestPasswordReset = $grpc.ClientMethod<
          $4.RequestPasswordResetRequest, $4.RequestPasswordResetResponse>(
      '/pb.AuthService/RequestPasswordReset',
      ($4.RequestPasswordResetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.RequestPasswordResetResponse.fromBuffer(value));
  static final _$resetPassword =
      $grpc.ClientMethod<$4.ResetPasswordRequest, $4.ResetPasswordResponse>(
          '/pb.AuthService/ResetPassword',
          ($4.ResetPasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.ResetPasswordResponse.fromBuffer(value));
  static final _$verifyPasswordResetCode = $grpc.ClientMethod<
          $4.VerifyPasswordResetCodeRequest,
          $4.VerifyPasswordResetCodeResponse>(
      '/pb.AuthService/VerifyPasswordResetCode',
      ($4.VerifyPasswordResetCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.VerifyPasswordResetCodeResponse.fromBuffer(value));
  static final _$loginWithFace =
      $grpc.ClientMethod<$4.LoginWithFaceRequest, $4.LoginWithFaceResponse>(
          '/pb.AuthService/LoginWithFace',
          ($4.LoginWithFaceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.LoginWithFaceResponse.fromBuffer(value));
  static final _$checkFaceRegistration = $grpc.ClientMethod<
          $4.CheckFaceRegistrationRequest, $4.CheckFaceRegistrationResponse>(
      '/pb.AuthService/CheckFaceRegistration',
      ($4.CheckFaceRegistrationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.CheckFaceRegistrationResponse.fromBuffer(value));
  static final _$signInWithGoogle =
      $grpc.ClientMethod<$4.SignInWithGoogleRequest, $4.LoginResponse>(
          '/pb.AuthService/SignInWithGoogle',
          ($4.SignInWithGoogleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$signInWithApple =
      $grpc.ClientMethod<$4.SignInWithAppleRequest, $4.LoginResponse>(
          '/pb.AuthService/SignInWithApple',
          ($4.SignInWithAppleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$checkEmailAvailability = $grpc.ClientMethod<
          $4.CheckEmailAvailabilityRequest, $4.CheckEmailAvailabilityResponse>(
      '/pb.AuthService/CheckEmailAvailability',
      ($4.CheckEmailAvailabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.CheckEmailAvailabilityResponse.fromBuffer(value));
  static final _$verifyPin =
      $grpc.ClientMethod<$4.VerifyPinRequest, $4.VerifyPinResponse>(
          '/pb.AuthService/VerifyPin',
          ($4.VerifyPinRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.VerifyPinResponse.fromBuffer(value));
  static final _$requestPhoneVerification = $grpc.ClientMethod<
          $4.RequestPhoneVerificationRequest,
          $4.RequestPhoneVerificationResponse>(
      '/pb.AuthService/RequestPhoneVerification',
      ($4.RequestPhoneVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.RequestPhoneVerificationResponse.fromBuffer(value));
  static final _$verifyPhoneNumber = $grpc.ClientMethod<
          $4.VerifyPhoneNumberRequest, $4.VerifyPhoneNumberResponse>(
      '/pb.AuthService/VerifyPhoneNumber',
      ($4.VerifyPhoneNumberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $4.VerifyPhoneNumberResponse.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$4.LoginResponse> login($4.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
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

  $grpc.ResponseFuture<$4.RefreshTokenResponse> refreshToken(
      $4.RefreshTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  $grpc.ResponseFuture<$4.LogoutResponse> logout($4.LogoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  $grpc.ResponseFuture<$4.RequestEmailVerificationResponse>
      requestEmailVerification($4.RequestEmailVerificationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestEmailVerification, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.VerifyEmailResponse> verifyEmail(
      $4.VerifyEmailRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyEmail, request, options: options);
  }

  $grpc.ResponseFuture<$4.RequestPasswordResetResponse> requestPasswordReset(
      $4.RequestPasswordResetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPasswordReset, request, options: options);
  }

  $grpc.ResponseFuture<$4.ResetPasswordResponse> resetPassword(
      $4.ResetPasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetPassword, request, options: options);
  }

  $grpc.ResponseFuture<$4.VerifyPasswordResetCodeResponse>
      verifyPasswordResetCode($4.VerifyPasswordResetCodeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPasswordResetCode, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.LoginWithFaceResponse> loginWithFace(
      $4.LoginWithFaceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$loginWithFace, request, options: options);
  }

  $grpc.ResponseFuture<$4.CheckFaceRegistrationResponse> checkFaceRegistration(
      $4.CheckFaceRegistrationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkFaceRegistration, request, options: options);
  }

  $grpc.ResponseFuture<$4.LoginResponse> signInWithGoogle(
      $4.SignInWithGoogleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signInWithGoogle, request, options: options);
  }

  $grpc.ResponseFuture<$4.LoginResponse> signInWithApple(
      $4.SignInWithAppleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signInWithApple, request, options: options);
  }

  $grpc.ResponseFuture<$4.CheckEmailAvailabilityResponse>
      checkEmailAvailability($4.CheckEmailAvailabilityRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkEmailAvailability, request,
        options: options);
  }

  $grpc.ResponseFuture<$4.VerifyPinResponse> verifyPin(
      $4.VerifyPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPin, request, options: options);
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
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.LoginRequest, $4.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.LoginRequest.fromBuffer(value),
        ($4.LoginResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$4.RequestEmailVerificationRequest,
            $4.RequestEmailVerificationResponse>(
        'RequestEmailVerification',
        requestEmailVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.RequestEmailVerificationRequest.fromBuffer(value),
        ($4.RequestEmailVerificationResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.VerifyEmailRequest, $4.VerifyEmailResponse>(
            'VerifyEmail',
            verifyEmail_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.VerifyEmailRequest.fromBuffer(value),
            ($4.VerifyEmailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.RequestPasswordResetRequest,
            $4.RequestPasswordResetResponse>(
        'RequestPasswordReset',
        requestPasswordReset_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.RequestPasswordResetRequest.fromBuffer(value),
        ($4.RequestPasswordResetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.ResetPasswordRequest, $4.ResetPasswordResponse>(
            'ResetPassword',
            resetPassword_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.ResetPasswordRequest.fromBuffer(value),
            ($4.ResetPasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.VerifyPasswordResetCodeRequest,
            $4.VerifyPasswordResetCodeResponse>(
        'VerifyPasswordResetCode',
        verifyPasswordResetCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.VerifyPasswordResetCodeRequest.fromBuffer(value),
        ($4.VerifyPasswordResetCodeResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.LoginWithFaceRequest, $4.LoginWithFaceResponse>(
            'LoginWithFace',
            loginWithFace_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.LoginWithFaceRequest.fromBuffer(value),
            ($4.LoginWithFaceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.CheckFaceRegistrationRequest,
            $4.CheckFaceRegistrationResponse>(
        'CheckFaceRegistration',
        checkFaceRegistration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.CheckFaceRegistrationRequest.fromBuffer(value),
        ($4.CheckFaceRegistrationResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$4.SignInWithGoogleRequest, $4.LoginResponse>(
            'SignInWithGoogle',
            signInWithGoogle_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.SignInWithGoogleRequest.fromBuffer(value),
            ($4.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SignInWithAppleRequest, $4.LoginResponse>(
        'SignInWithApple',
        signInWithApple_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.SignInWithAppleRequest.fromBuffer(value),
        ($4.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.CheckEmailAvailabilityRequest,
            $4.CheckEmailAvailabilityResponse>(
        'CheckEmailAvailability',
        checkEmailAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.CheckEmailAvailabilityRequest.fromBuffer(value),
        ($4.CheckEmailAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.VerifyPinRequest, $4.VerifyPinResponse>(
        'VerifyPin',
        verifyPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.VerifyPinRequest.fromBuffer(value),
        ($4.VerifyPinResponse value) => value.writeToBuffer()));
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
  }

  $async.Future<$4.LoginResponse> login_Pre(
      $grpc.ServiceCall call, $async.Future<$4.LoginRequest> request) async {
    return login(call, await request);
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

  $async.Future<$4.RefreshTokenResponse> refreshToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.RefreshTokenRequest> request) async {
    return refreshToken(call, await request);
  }

  $async.Future<$4.LogoutResponse> logout_Pre(
      $grpc.ServiceCall call, $async.Future<$4.LogoutRequest> request) async {
    return logout(call, await request);
  }

  $async.Future<$4.RequestEmailVerificationResponse>
      requestEmailVerification_Pre($grpc.ServiceCall call,
          $async.Future<$4.RequestEmailVerificationRequest> request) async {
    return requestEmailVerification(call, await request);
  }

  $async.Future<$4.VerifyEmailResponse> verifyEmail_Pre($grpc.ServiceCall call,
      $async.Future<$4.VerifyEmailRequest> request) async {
    return verifyEmail(call, await request);
  }

  $async.Future<$4.RequestPasswordResetResponse> requestPasswordReset_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.RequestPasswordResetRequest> request) async {
    return requestPasswordReset(call, await request);
  }

  $async.Future<$4.ResetPasswordResponse> resetPassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.ResetPasswordRequest> request) async {
    return resetPassword(call, await request);
  }

  $async.Future<$4.VerifyPasswordResetCodeResponse> verifyPasswordResetCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.VerifyPasswordResetCodeRequest> request) async {
    return verifyPasswordResetCode(call, await request);
  }

  $async.Future<$4.LoginWithFaceResponse> loginWithFace_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.LoginWithFaceRequest> request) async {
    return loginWithFace(call, await request);
  }

  $async.Future<$4.CheckFaceRegistrationResponse> checkFaceRegistration_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.CheckFaceRegistrationRequest> request) async {
    return checkFaceRegistration(call, await request);
  }

  $async.Future<$4.LoginResponse> signInWithGoogle_Pre($grpc.ServiceCall call,
      $async.Future<$4.SignInWithGoogleRequest> request) async {
    return signInWithGoogle(call, await request);
  }

  $async.Future<$4.LoginResponse> signInWithApple_Pre($grpc.ServiceCall call,
      $async.Future<$4.SignInWithAppleRequest> request) async {
    return signInWithApple(call, await request);
  }

  $async.Future<$4.CheckEmailAvailabilityResponse> checkEmailAvailability_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.CheckEmailAvailabilityRequest> request) async {
    return checkEmailAvailability(call, await request);
  }

  $async.Future<$4.VerifyPinResponse> verifyPin_Pre($grpc.ServiceCall call,
      $async.Future<$4.VerifyPinRequest> request) async {
    return verifyPin(call, await request);
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

  $async.Future<$4.LoginResponse> login(
      $grpc.ServiceCall call, $4.LoginRequest request);
  $async.Future<$4.LoginResponse> loginWithPasscode(
      $grpc.ServiceCall call, $4.LoginWithPasscodeRequest request);
  $async.Future<$4.RegisterPasscodeResponse> registerPasscode(
      $grpc.ServiceCall call, $4.RegisterPasscodeRequest request);
  $async.Future<$4.ChangePasscodeResponse> changePasscode(
      $grpc.ServiceCall call, $4.ChangePasscodeRequest request);
  $async.Future<$4.RefreshTokenResponse> refreshToken(
      $grpc.ServiceCall call, $4.RefreshTokenRequest request);
  $async.Future<$4.LogoutResponse> logout(
      $grpc.ServiceCall call, $4.LogoutRequest request);
  $async.Future<$4.RequestEmailVerificationResponse> requestEmailVerification(
      $grpc.ServiceCall call, $4.RequestEmailVerificationRequest request);
  $async.Future<$4.VerifyEmailResponse> verifyEmail(
      $grpc.ServiceCall call, $4.VerifyEmailRequest request);
  $async.Future<$4.RequestPasswordResetResponse> requestPasswordReset(
      $grpc.ServiceCall call, $4.RequestPasswordResetRequest request);
  $async.Future<$4.ResetPasswordResponse> resetPassword(
      $grpc.ServiceCall call, $4.ResetPasswordRequest request);
  $async.Future<$4.VerifyPasswordResetCodeResponse> verifyPasswordResetCode(
      $grpc.ServiceCall call, $4.VerifyPasswordResetCodeRequest request);
  $async.Future<$4.LoginWithFaceResponse> loginWithFace(
      $grpc.ServiceCall call, $4.LoginWithFaceRequest request);
  $async.Future<$4.CheckFaceRegistrationResponse> checkFaceRegistration(
      $grpc.ServiceCall call, $4.CheckFaceRegistrationRequest request);
  $async.Future<$4.LoginResponse> signInWithGoogle(
      $grpc.ServiceCall call, $4.SignInWithGoogleRequest request);
  $async.Future<$4.LoginResponse> signInWithApple(
      $grpc.ServiceCall call, $4.SignInWithAppleRequest request);
  $async.Future<$4.CheckEmailAvailabilityResponse> checkEmailAvailability(
      $grpc.ServiceCall call, $4.CheckEmailAvailabilityRequest request);
  $async.Future<$4.VerifyPinResponse> verifyPin(
      $grpc.ServiceCall call, $4.VerifyPinRequest request);
  $async.Future<$4.RequestPhoneVerificationResponse> requestPhoneVerification(
      $grpc.ServiceCall call, $4.RequestPhoneVerificationRequest request);
  $async.Future<$4.VerifyPhoneNumberResponse> verifyPhoneNumber(
      $grpc.ServiceCall call, $4.VerifyPhoneNumberRequest request);
}
