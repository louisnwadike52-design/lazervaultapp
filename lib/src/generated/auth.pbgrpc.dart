//
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pb.dart' as $4;

export 'auth.pb.dart';

@$pb.GrpcServiceName('pb.AuthService')
class AuthServiceClient extends $grpc.Client {
  static final _$login = $grpc.ClientMethod<$4.LoginRequest, $4.LoginResponse>(
      '/pb.AuthService/Login',
      ($4.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$refreshToken = $grpc.ClientMethod<$4.RefreshTokenRequest, $4.RefreshTokenResponse>(
      '/pb.AuthService/RefreshToken',
      ($4.RefreshTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.RefreshTokenResponse.fromBuffer(value));
  static final _$logout = $grpc.ClientMethod<$4.LogoutRequest, $4.LogoutResponse>(
      '/pb.AuthService/Logout',
      ($4.LogoutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.LogoutResponse.fromBuffer(value));
  static final _$requestEmailVerification = $grpc.ClientMethod<$4.RequestEmailVerificationRequest, $4.RequestEmailVerificationResponse>(
      '/pb.AuthService/RequestEmailVerification',
      ($4.RequestEmailVerificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.RequestEmailVerificationResponse.fromBuffer(value));
  static final _$verifyEmail = $grpc.ClientMethod<$4.VerifyEmailRequest, $4.VerifyEmailResponse>(
      '/pb.AuthService/VerifyEmail',
      ($4.VerifyEmailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.VerifyEmailResponse.fromBuffer(value));
  static final _$requestPasswordReset = $grpc.ClientMethod<$4.RequestPasswordResetRequest, $4.RequestPasswordResetResponse>(
      '/pb.AuthService/RequestPasswordReset',
      ($4.RequestPasswordResetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.RequestPasswordResetResponse.fromBuffer(value));
  static final _$resetPassword = $grpc.ClientMethod<$4.ResetPasswordRequest, $4.ResetPasswordResponse>(
      '/pb.AuthService/ResetPassword',
      ($4.ResetPasswordRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.ResetPasswordResponse.fromBuffer(value));
  static final _$signInWithGoogle = $grpc.ClientMethod<$4.SignInWithGoogleRequest, $4.LoginResponse>(
      '/pb.AuthService/SignInWithGoogle',
      ($4.SignInWithGoogleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$signInWithApple = $grpc.ClientMethod<$4.SignInWithAppleRequest, $4.LoginResponse>(
      '/pb.AuthService/SignInWithApple',
      ($4.SignInWithAppleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.LoginResponse.fromBuffer(value));
  static final _$verifyPin = $grpc.ClientMethod<$4.VerifyPinRequest, $4.VerifyPinResponse>(
      '/pb.AuthService/VerifyPin',
      ($4.VerifyPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.VerifyPinResponse.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$4.LoginResponse> login($4.LoginRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$4.RefreshTokenResponse> refreshToken($4.RefreshTokenRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  $grpc.ResponseFuture<$4.LogoutResponse> logout($4.LogoutRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  $grpc.ResponseFuture<$4.RequestEmailVerificationResponse> requestEmailVerification($4.RequestEmailVerificationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestEmailVerification, request, options: options);
  }

  $grpc.ResponseFuture<$4.VerifyEmailResponse> verifyEmail($4.VerifyEmailRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyEmail, request, options: options);
  }

  $grpc.ResponseFuture<$4.RequestPasswordResetResponse> requestPasswordReset($4.RequestPasswordResetRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestPasswordReset, request, options: options);
  }

  $grpc.ResponseFuture<$4.ResetPasswordResponse> resetPassword($4.ResetPasswordRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetPassword, request, options: options);
  }

  $grpc.ResponseFuture<$4.LoginResponse> signInWithGoogle($4.SignInWithGoogleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signInWithGoogle, request, options: options);
  }

  $grpc.ResponseFuture<$4.LoginResponse> signInWithApple($4.SignInWithAppleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signInWithApple, request, options: options);
  }

  $grpc.ResponseFuture<$4.VerifyPinResponse> verifyPin($4.VerifyPinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPin, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.AuthService')
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
    $addMethod($grpc.ServiceMethod<$4.RefreshTokenRequest, $4.RefreshTokenResponse>(
        'RefreshToken',
        refreshToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.RefreshTokenRequest.fromBuffer(value),
        ($4.RefreshTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.LogoutRequest, $4.LogoutResponse>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.LogoutRequest.fromBuffer(value),
        ($4.LogoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.RequestEmailVerificationRequest, $4.RequestEmailVerificationResponse>(
        'RequestEmailVerification',
        requestEmailVerification_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.RequestEmailVerificationRequest.fromBuffer(value),
        ($4.RequestEmailVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.VerifyEmailRequest, $4.VerifyEmailResponse>(
        'VerifyEmail',
        verifyEmail_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.VerifyEmailRequest.fromBuffer(value),
        ($4.VerifyEmailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.RequestPasswordResetRequest, $4.RequestPasswordResetResponse>(
        'RequestPasswordReset',
        requestPasswordReset_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.RequestPasswordResetRequest.fromBuffer(value),
        ($4.RequestPasswordResetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ResetPasswordRequest, $4.ResetPasswordResponse>(
        'ResetPassword',
        resetPassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.ResetPasswordRequest.fromBuffer(value),
        ($4.ResetPasswordResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SignInWithGoogleRequest, $4.LoginResponse>(
        'SignInWithGoogle',
        signInWithGoogle_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.SignInWithGoogleRequest.fromBuffer(value),
        ($4.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SignInWithAppleRequest, $4.LoginResponse>(
        'SignInWithApple',
        signInWithApple_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.SignInWithAppleRequest.fromBuffer(value),
        ($4.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.VerifyPinRequest, $4.VerifyPinResponse>(
        'VerifyPin',
        verifyPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.VerifyPinRequest.fromBuffer(value),
        ($4.VerifyPinResponse value) => value.writeToBuffer()));
  }

  $async.Future<$4.LoginResponse> login_Pre($grpc.ServiceCall $call, $async.Future<$4.LoginRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$4.RefreshTokenResponse> refreshToken_Pre($grpc.ServiceCall $call, $async.Future<$4.RefreshTokenRequest> $request) async {
    return refreshToken($call, await $request);
  }

  $async.Future<$4.LogoutResponse> logout_Pre($grpc.ServiceCall $call, $async.Future<$4.LogoutRequest> $request) async {
    return logout($call, await $request);
  }

  $async.Future<$4.RequestEmailVerificationResponse> requestEmailVerification_Pre($grpc.ServiceCall $call, $async.Future<$4.RequestEmailVerificationRequest> $request) async {
    return requestEmailVerification($call, await $request);
  }

  $async.Future<$4.VerifyEmailResponse> verifyEmail_Pre($grpc.ServiceCall $call, $async.Future<$4.VerifyEmailRequest> $request) async {
    return verifyEmail($call, await $request);
  }

  $async.Future<$4.RequestPasswordResetResponse> requestPasswordReset_Pre($grpc.ServiceCall $call, $async.Future<$4.RequestPasswordResetRequest> $request) async {
    return requestPasswordReset($call, await $request);
  }

  $async.Future<$4.ResetPasswordResponse> resetPassword_Pre($grpc.ServiceCall $call, $async.Future<$4.ResetPasswordRequest> $request) async {
    return resetPassword($call, await $request);
  }

  $async.Future<$4.LoginResponse> signInWithGoogle_Pre($grpc.ServiceCall $call, $async.Future<$4.SignInWithGoogleRequest> $request) async {
    return signInWithGoogle($call, await $request);
  }

  $async.Future<$4.LoginResponse> signInWithApple_Pre($grpc.ServiceCall $call, $async.Future<$4.SignInWithAppleRequest> $request) async {
    return signInWithApple($call, await $request);
  }

  $async.Future<$4.VerifyPinResponse> verifyPin_Pre($grpc.ServiceCall $call, $async.Future<$4.VerifyPinRequest> $request) async {
    return verifyPin($call, await $request);
  }

  $async.Future<$4.LoginResponse> login($grpc.ServiceCall call, $4.LoginRequest request);
  $async.Future<$4.RefreshTokenResponse> refreshToken($grpc.ServiceCall call, $4.RefreshTokenRequest request);
  $async.Future<$4.LogoutResponse> logout($grpc.ServiceCall call, $4.LogoutRequest request);
  $async.Future<$4.RequestEmailVerificationResponse> requestEmailVerification($grpc.ServiceCall call, $4.RequestEmailVerificationRequest request);
  $async.Future<$4.VerifyEmailResponse> verifyEmail($grpc.ServiceCall call, $4.VerifyEmailRequest request);
  $async.Future<$4.RequestPasswordResetResponse> requestPasswordReset($grpc.ServiceCall call, $4.RequestPasswordResetRequest request);
  $async.Future<$4.ResetPasswordResponse> resetPassword($grpc.ServiceCall call, $4.ResetPasswordRequest request);
  $async.Future<$4.LoginResponse> signInWithGoogle($grpc.ServiceCall call, $4.SignInWithGoogleRequest request);
  $async.Future<$4.LoginResponse> signInWithApple($grpc.ServiceCall call, $4.SignInWithAppleRequest request);
  $async.Future<$4.VerifyPinResponse> verifyPin($grpc.ServiceCall call, $4.VerifyPinRequest request);
}
