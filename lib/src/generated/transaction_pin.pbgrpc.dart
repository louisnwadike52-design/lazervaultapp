//
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'transaction_pin.pb.dart' as $0;

export 'transaction_pin.pb.dart';

@$pb.GrpcServiceName('auth.TransactionPinService')
class TransactionPinServiceClient extends $grpc.Client {
  static final _$createTransactionPin = $grpc.ClientMethod<$0.CreateTransactionPinRequest, $0.CreateTransactionPinResponse>(
      '/auth.TransactionPinService/CreateTransactionPin',
      ($0.CreateTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateTransactionPinResponse.fromBuffer(value));
  static final _$verifyTransactionPin = $grpc.ClientMethod<$0.VerifyTransactionPinRequest, $0.VerifyTransactionPinResponse>(
      '/auth.TransactionPinService/VerifyTransactionPin',
      ($0.VerifyTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyTransactionPinResponse.fromBuffer(value));
  static final _$changeTransactionPin = $grpc.ClientMethod<$0.ChangeTransactionPinRequest, $0.ChangeTransactionPinResponse>(
      '/auth.TransactionPinService/ChangeTransactionPin',
      ($0.ChangeTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ChangeTransactionPinResponse.fromBuffer(value));
  static final _$resetTransactionPin = $grpc.ClientMethod<$0.ResetTransactionPinRequest, $0.ResetTransactionPinResponse>(
      '/auth.TransactionPinService/ResetTransactionPin',
      ($0.ResetTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResetTransactionPinResponse.fromBuffer(value));
  static final _$checkUserHasPin = $grpc.ClientMethod<$0.CheckUserHasPinRequest, $0.CheckUserHasPinResponse>(
      '/auth.TransactionPinService/CheckUserHasPin',
      ($0.CheckUserHasPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CheckUserHasPinResponse.fromBuffer(value));
  static final _$validateTransactionPinToken = $grpc.ClientMethod<$0.ValidateTransactionPinTokenRequest, $0.ValidateTransactionPinTokenResponse>(
      '/auth.TransactionPinService/ValidateTransactionPinToken',
      ($0.ValidateTransactionPinTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ValidateTransactionPinTokenResponse.fromBuffer(value));
  static final _$initiatePinOTP = $grpc.ClientMethod<$0.InitiatePinOTPRequest, $0.InitiatePinOTPResponse>(
      '/auth.TransactionPinService/InitiatePinOTP',
      ($0.InitiatePinOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.InitiatePinOTPResponse.fromBuffer(value));
  static final _$verifyPinOTP = $grpc.ClientMethod<$0.VerifyPinOTPRequest, $0.VerifyPinOTPResponse>(
      '/auth.TransactionPinService/VerifyPinOTP',
      ($0.VerifyPinOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyPinOTPResponse.fromBuffer(value));
  static final _$getPinOTPChannels = $grpc.ClientMethod<$0.GetPinOTPChannelsRequest, $0.GetPinOTPChannelsResponse>(
      '/auth.TransactionPinService/GetPinOTPChannels',
      ($0.GetPinOTPChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPinOTPChannelsResponse.fromBuffer(value));
  static final _$completeForgotPin = $grpc.ClientMethod<$0.CompleteForgotPinRequest, $0.CompleteForgotPinResponse>(
      '/auth.TransactionPinService/CompleteForgotPin',
      ($0.CompleteForgotPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CompleteForgotPinResponse.fromBuffer(value));

  TransactionPinServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateTransactionPinResponse> createTransactionPin($0.CreateTransactionPinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyTransactionPinResponse> verifyTransactionPin($0.VerifyTransactionPinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$0.ChangeTransactionPinResponse> changeTransactionPin($0.ChangeTransactionPinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changeTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResetTransactionPinResponse> resetTransactionPin($0.ResetTransactionPinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$0.CheckUserHasPinResponse> checkUserHasPin($0.CheckUserHasPinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkUserHasPin, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidateTransactionPinTokenResponse> validateTransactionPinToken($0.ValidateTransactionPinTokenRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateTransactionPinToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.InitiatePinOTPResponse> initiatePinOTP($0.InitiatePinOTPRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePinOTP, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyPinOTPResponse> verifyPinOTP($0.VerifyPinOTPRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPinOTP, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPinOTPChannelsResponse> getPinOTPChannels($0.GetPinOTPChannelsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPinOTPChannels, request, options: options);
  }

  $grpc.ResponseFuture<$0.CompleteForgotPinResponse> completeForgotPin($0.CompleteForgotPinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$completeForgotPin, request, options: options);
  }
}

@$pb.GrpcServiceName('auth.TransactionPinService')
abstract class TransactionPinServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.TransactionPinService';

  TransactionPinServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateTransactionPinRequest, $0.CreateTransactionPinResponse>(
        'CreateTransactionPin',
        createTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateTransactionPinRequest.fromBuffer(value),
        ($0.CreateTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyTransactionPinRequest, $0.VerifyTransactionPinResponse>(
        'VerifyTransactionPin',
        verifyTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyTransactionPinRequest.fromBuffer(value),
        ($0.VerifyTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChangeTransactionPinRequest, $0.ChangeTransactionPinResponse>(
        'ChangeTransactionPin',
        changeTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChangeTransactionPinRequest.fromBuffer(value),
        ($0.ChangeTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResetTransactionPinRequest, $0.ResetTransactionPinResponse>(
        'ResetTransactionPin',
        resetTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ResetTransactionPinRequest.fromBuffer(value),
        ($0.ResetTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckUserHasPinRequest, $0.CheckUserHasPinResponse>(
        'CheckUserHasPin',
        checkUserHasPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CheckUserHasPinRequest.fromBuffer(value),
        ($0.CheckUserHasPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateTransactionPinTokenRequest, $0.ValidateTransactionPinTokenResponse>(
        'ValidateTransactionPinToken',
        validateTransactionPinToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ValidateTransactionPinTokenRequest.fromBuffer(value),
        ($0.ValidateTransactionPinTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiatePinOTPRequest, $0.InitiatePinOTPResponse>(
        'InitiatePinOTP',
        initiatePinOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InitiatePinOTPRequest.fromBuffer(value),
        ($0.InitiatePinOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyPinOTPRequest, $0.VerifyPinOTPResponse>(
        'VerifyPinOTP',
        verifyPinOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyPinOTPRequest.fromBuffer(value),
        ($0.VerifyPinOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPinOTPChannelsRequest, $0.GetPinOTPChannelsResponse>(
        'GetPinOTPChannels',
        getPinOTPChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPinOTPChannelsRequest.fromBuffer(value),
        ($0.GetPinOTPChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompleteForgotPinRequest, $0.CompleteForgotPinResponse>(
        'CompleteForgotPin',
        completeForgotPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CompleteForgotPinRequest.fromBuffer(value),
        ($0.CompleteForgotPinResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateTransactionPinResponse> createTransactionPin_Pre($grpc.ServiceCall call, $async.Future<$0.CreateTransactionPinRequest> request) async {
    return createTransactionPin(call, await request);
  }

  $async.Future<$0.VerifyTransactionPinResponse> verifyTransactionPin_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyTransactionPinRequest> request) async {
    return verifyTransactionPin(call, await request);
  }

  $async.Future<$0.ChangeTransactionPinResponse> changeTransactionPin_Pre($grpc.ServiceCall call, $async.Future<$0.ChangeTransactionPinRequest> request) async {
    return changeTransactionPin(call, await request);
  }

  $async.Future<$0.ResetTransactionPinResponse> resetTransactionPin_Pre($grpc.ServiceCall call, $async.Future<$0.ResetTransactionPinRequest> request) async {
    return resetTransactionPin(call, await request);
  }

  $async.Future<$0.CheckUserHasPinResponse> checkUserHasPin_Pre($grpc.ServiceCall call, $async.Future<$0.CheckUserHasPinRequest> request) async {
    return checkUserHasPin(call, await request);
  }

  $async.Future<$0.ValidateTransactionPinTokenResponse> validateTransactionPinToken_Pre($grpc.ServiceCall call, $async.Future<$0.ValidateTransactionPinTokenRequest> request) async {
    return validateTransactionPinToken(call, await request);
  }

  $async.Future<$0.InitiatePinOTPResponse> initiatePinOTP_Pre($grpc.ServiceCall call, $async.Future<$0.InitiatePinOTPRequest> request) async {
    return initiatePinOTP(call, await request);
  }

  $async.Future<$0.VerifyPinOTPResponse> verifyPinOTP_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyPinOTPRequest> request) async {
    return verifyPinOTP(call, await request);
  }

  $async.Future<$0.GetPinOTPChannelsResponse> getPinOTPChannels_Pre($grpc.ServiceCall call, $async.Future<$0.GetPinOTPChannelsRequest> request) async {
    return getPinOTPChannels(call, await request);
  }

  $async.Future<$0.CompleteForgotPinResponse> completeForgotPin_Pre($grpc.ServiceCall call, $async.Future<$0.CompleteForgotPinRequest> request) async {
    return completeForgotPin(call, await request);
  }

  $async.Future<$0.CreateTransactionPinResponse> createTransactionPin($grpc.ServiceCall call, $0.CreateTransactionPinRequest request);
  $async.Future<$0.VerifyTransactionPinResponse> verifyTransactionPin($grpc.ServiceCall call, $0.VerifyTransactionPinRequest request);
  $async.Future<$0.ChangeTransactionPinResponse> changeTransactionPin($grpc.ServiceCall call, $0.ChangeTransactionPinRequest request);
  $async.Future<$0.ResetTransactionPinResponse> resetTransactionPin($grpc.ServiceCall call, $0.ResetTransactionPinRequest request);
  $async.Future<$0.CheckUserHasPinResponse> checkUserHasPin($grpc.ServiceCall call, $0.CheckUserHasPinRequest request);
  $async.Future<$0.ValidateTransactionPinTokenResponse> validateTransactionPinToken($grpc.ServiceCall call, $0.ValidateTransactionPinTokenRequest request);
  $async.Future<$0.InitiatePinOTPResponse> initiatePinOTP($grpc.ServiceCall call, $0.InitiatePinOTPRequest request);
  $async.Future<$0.VerifyPinOTPResponse> verifyPinOTP($grpc.ServiceCall call, $0.VerifyPinOTPRequest request);
  $async.Future<$0.GetPinOTPChannelsResponse> getPinOTPChannels($grpc.ServiceCall call, $0.GetPinOTPChannelsRequest request);
  $async.Future<$0.CompleteForgotPinResponse> completeForgotPin($grpc.ServiceCall call, $0.CompleteForgotPinRequest request);
}
