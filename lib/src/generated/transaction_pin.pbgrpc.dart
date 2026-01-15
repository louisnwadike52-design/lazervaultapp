///
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transaction_pin.pb.dart' as $1;
export 'transaction_pin.pb.dart';

class TransactionPinServiceClient extends $grpc.Client {
  static final _$createTransactionPin = $grpc.ClientMethod<
          $1.CreateTransactionPinRequest, $1.CreateTransactionPinResponse>(
      '/auth.TransactionPinService/CreateTransactionPin',
      ($1.CreateTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateTransactionPinResponse.fromBuffer(value));
  static final _$verifyTransactionPin = $grpc.ClientMethod<
          $1.VerifyTransactionPinRequest, $1.VerifyTransactionPinResponse>(
      '/auth.TransactionPinService/VerifyTransactionPin',
      ($1.VerifyTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.VerifyTransactionPinResponse.fromBuffer(value));
  static final _$changeTransactionPin = $grpc.ClientMethod<
          $1.ChangeTransactionPinRequest, $1.ChangeTransactionPinResponse>(
      '/auth.TransactionPinService/ChangeTransactionPin',
      ($1.ChangeTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ChangeTransactionPinResponse.fromBuffer(value));
  static final _$resetTransactionPin = $grpc.ClientMethod<
          $1.ResetTransactionPinRequest, $1.ResetTransactionPinResponse>(
      '/auth.TransactionPinService/ResetTransactionPin',
      ($1.ResetTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ResetTransactionPinResponse.fromBuffer(value));
  static final _$checkUserHasPin =
      $grpc.ClientMethod<$1.CheckUserHasPinRequest, $1.CheckUserHasPinResponse>(
          '/auth.TransactionPinService/CheckUserHasPin',
          ($1.CheckUserHasPinRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.CheckUserHasPinResponse.fromBuffer(value));
  static final _$validateTransactionPinToken = $grpc.ClientMethod<
          $1.ValidateTransactionPinTokenRequest,
          $1.ValidateTransactionPinTokenResponse>(
      '/auth.TransactionPinService/ValidateTransactionPinToken',
      ($1.ValidateTransactionPinTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ValidateTransactionPinTokenResponse.fromBuffer(value));

  TransactionPinServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.CreateTransactionPinResponse> createTransactionPin(
      $1.CreateTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$1.VerifyTransactionPinResponse> verifyTransactionPin(
      $1.VerifyTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChangeTransactionPinResponse> changeTransactionPin(
      $1.ChangeTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changeTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$1.ResetTransactionPinResponse> resetTransactionPin(
      $1.ResetTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$1.CheckUserHasPinResponse> checkUserHasPin(
      $1.CheckUserHasPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkUserHasPin, request, options: options);
  }

  $grpc.ResponseFuture<$1.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken($1.ValidateTransactionPinTokenRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateTransactionPinToken, request,
        options: options);
  }
}

abstract class TransactionPinServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.TransactionPinService';

  TransactionPinServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.CreateTransactionPinRequest,
            $1.CreateTransactionPinResponse>(
        'CreateTransactionPin',
        createTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateTransactionPinRequest.fromBuffer(value),
        ($1.CreateTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.VerifyTransactionPinRequest,
            $1.VerifyTransactionPinResponse>(
        'VerifyTransactionPin',
        verifyTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.VerifyTransactionPinRequest.fromBuffer(value),
        ($1.VerifyTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChangeTransactionPinRequest,
            $1.ChangeTransactionPinResponse>(
        'ChangeTransactionPin',
        changeTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ChangeTransactionPinRequest.fromBuffer(value),
        ($1.ChangeTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ResetTransactionPinRequest,
            $1.ResetTransactionPinResponse>(
        'ResetTransactionPin',
        resetTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ResetTransactionPinRequest.fromBuffer(value),
        ($1.ResetTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CheckUserHasPinRequest,
            $1.CheckUserHasPinResponse>(
        'CheckUserHasPin',
        checkUserHasPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CheckUserHasPinRequest.fromBuffer(value),
        ($1.CheckUserHasPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ValidateTransactionPinTokenRequest,
            $1.ValidateTransactionPinTokenResponse>(
        'ValidateTransactionPinToken',
        validateTransactionPinToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ValidateTransactionPinTokenRequest.fromBuffer(value),
        ($1.ValidateTransactionPinTokenResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$1.CreateTransactionPinResponse> createTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateTransactionPinRequest> request) async {
    return createTransactionPin(call, await request);
  }

  $async.Future<$1.VerifyTransactionPinResponse> verifyTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.VerifyTransactionPinRequest> request) async {
    return verifyTransactionPin(call, await request);
  }

  $async.Future<$1.ChangeTransactionPinResponse> changeTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ChangeTransactionPinRequest> request) async {
    return changeTransactionPin(call, await request);
  }

  $async.Future<$1.ResetTransactionPinResponse> resetTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ResetTransactionPinRequest> request) async {
    return resetTransactionPin(call, await request);
  }

  $async.Future<$1.CheckUserHasPinResponse> checkUserHasPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CheckUserHasPinRequest> request) async {
    return checkUserHasPin(call, await request);
  }

  $async.Future<$1.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken_Pre($grpc.ServiceCall call,
          $async.Future<$1.ValidateTransactionPinTokenRequest> request) async {
    return validateTransactionPinToken(call, await request);
  }

  $async.Future<$1.CreateTransactionPinResponse> createTransactionPin(
      $grpc.ServiceCall call, $1.CreateTransactionPinRequest request);
  $async.Future<$1.VerifyTransactionPinResponse> verifyTransactionPin(
      $grpc.ServiceCall call, $1.VerifyTransactionPinRequest request);
  $async.Future<$1.ChangeTransactionPinResponse> changeTransactionPin(
      $grpc.ServiceCall call, $1.ChangeTransactionPinRequest request);
  $async.Future<$1.ResetTransactionPinResponse> resetTransactionPin(
      $grpc.ServiceCall call, $1.ResetTransactionPinRequest request);
  $async.Future<$1.CheckUserHasPinResponse> checkUserHasPin(
      $grpc.ServiceCall call, $1.CheckUserHasPinRequest request);
  $async.Future<$1.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken($grpc.ServiceCall call,
          $1.ValidateTransactionPinTokenRequest request);
}
