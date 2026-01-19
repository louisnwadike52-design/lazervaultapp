///
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transaction_pin.pb.dart' as $28;
export 'transaction_pin.pb.dart';

class TransactionPinServiceClient extends $grpc.Client {
  static final _$createTransactionPin = $grpc.ClientMethod<
          $28.CreateTransactionPinRequest, $28.CreateTransactionPinResponse>(
      '/auth.TransactionPinService/CreateTransactionPin',
      ($28.CreateTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.CreateTransactionPinResponse.fromBuffer(value));
  static final _$verifyTransactionPin = $grpc.ClientMethod<
          $28.VerifyTransactionPinRequest, $28.VerifyTransactionPinResponse>(
      '/auth.TransactionPinService/VerifyTransactionPin',
      ($28.VerifyTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.VerifyTransactionPinResponse.fromBuffer(value));
  static final _$changeTransactionPin = $grpc.ClientMethod<
          $28.ChangeTransactionPinRequest, $28.ChangeTransactionPinResponse>(
      '/auth.TransactionPinService/ChangeTransactionPin',
      ($28.ChangeTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.ChangeTransactionPinResponse.fromBuffer(value));
  static final _$resetTransactionPin = $grpc.ClientMethod<
          $28.ResetTransactionPinRequest, $28.ResetTransactionPinResponse>(
      '/auth.TransactionPinService/ResetTransactionPin',
      ($28.ResetTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.ResetTransactionPinResponse.fromBuffer(value));
  static final _$checkUserHasPin = $grpc.ClientMethod<
          $28.CheckUserHasPinRequest, $28.CheckUserHasPinResponse>(
      '/auth.TransactionPinService/CheckUserHasPin',
      ($28.CheckUserHasPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.CheckUserHasPinResponse.fromBuffer(value));
  static final _$validateTransactionPinToken = $grpc.ClientMethod<
          $28.ValidateTransactionPinTokenRequest,
          $28.ValidateTransactionPinTokenResponse>(
      '/auth.TransactionPinService/ValidateTransactionPinToken',
      ($28.ValidateTransactionPinTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.ValidateTransactionPinTokenResponse.fromBuffer(value));

  TransactionPinServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$28.CreateTransactionPinResponse> createTransactionPin(
      $28.CreateTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$28.VerifyTransactionPinResponse> verifyTransactionPin(
      $28.VerifyTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$28.ChangeTransactionPinResponse> changeTransactionPin(
      $28.ChangeTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changeTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$28.ResetTransactionPinResponse> resetTransactionPin(
      $28.ResetTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$28.CheckUserHasPinResponse> checkUserHasPin(
      $28.CheckUserHasPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkUserHasPin, request, options: options);
  }

  $grpc.ResponseFuture<$28.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken(
          $28.ValidateTransactionPinTokenRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateTransactionPinToken, request,
        options: options);
  }
}

abstract class TransactionPinServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.TransactionPinService';

  TransactionPinServiceBase() {
    $addMethod($grpc.ServiceMethod<$28.CreateTransactionPinRequest,
            $28.CreateTransactionPinResponse>(
        'CreateTransactionPin',
        createTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.CreateTransactionPinRequest.fromBuffer(value),
        ($28.CreateTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.VerifyTransactionPinRequest,
            $28.VerifyTransactionPinResponse>(
        'VerifyTransactionPin',
        verifyTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.VerifyTransactionPinRequest.fromBuffer(value),
        ($28.VerifyTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.ChangeTransactionPinRequest,
            $28.ChangeTransactionPinResponse>(
        'ChangeTransactionPin',
        changeTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.ChangeTransactionPinRequest.fromBuffer(value),
        ($28.ChangeTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.ResetTransactionPinRequest,
            $28.ResetTransactionPinResponse>(
        'ResetTransactionPin',
        resetTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.ResetTransactionPinRequest.fromBuffer(value),
        ($28.ResetTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.CheckUserHasPinRequest,
            $28.CheckUserHasPinResponse>(
        'CheckUserHasPin',
        checkUserHasPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.CheckUserHasPinRequest.fromBuffer(value),
        ($28.CheckUserHasPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.ValidateTransactionPinTokenRequest,
            $28.ValidateTransactionPinTokenResponse>(
        'ValidateTransactionPinToken',
        validateTransactionPinToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.ValidateTransactionPinTokenRequest.fromBuffer(value),
        ($28.ValidateTransactionPinTokenResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$28.CreateTransactionPinResponse> createTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.CreateTransactionPinRequest> request) async {
    return createTransactionPin(call, await request);
  }

  $async.Future<$28.VerifyTransactionPinResponse> verifyTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.VerifyTransactionPinRequest> request) async {
    return verifyTransactionPin(call, await request);
  }

  $async.Future<$28.ChangeTransactionPinResponse> changeTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.ChangeTransactionPinRequest> request) async {
    return changeTransactionPin(call, await request);
  }

  $async.Future<$28.ResetTransactionPinResponse> resetTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.ResetTransactionPinRequest> request) async {
    return resetTransactionPin(call, await request);
  }

  $async.Future<$28.CheckUserHasPinResponse> checkUserHasPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.CheckUserHasPinRequest> request) async {
    return checkUserHasPin(call, await request);
  }

  $async.Future<$28.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken_Pre($grpc.ServiceCall call,
          $async.Future<$28.ValidateTransactionPinTokenRequest> request) async {
    return validateTransactionPinToken(call, await request);
  }

  $async.Future<$28.CreateTransactionPinResponse> createTransactionPin(
      $grpc.ServiceCall call, $28.CreateTransactionPinRequest request);
  $async.Future<$28.VerifyTransactionPinResponse> verifyTransactionPin(
      $grpc.ServiceCall call, $28.VerifyTransactionPinRequest request);
  $async.Future<$28.ChangeTransactionPinResponse> changeTransactionPin(
      $grpc.ServiceCall call, $28.ChangeTransactionPinRequest request);
  $async.Future<$28.ResetTransactionPinResponse> resetTransactionPin(
      $grpc.ServiceCall call, $28.ResetTransactionPinRequest request);
  $async.Future<$28.CheckUserHasPinResponse> checkUserHasPin(
      $grpc.ServiceCall call, $28.CheckUserHasPinRequest request);
  $async.Future<$28.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken($grpc.ServiceCall call,
          $28.ValidateTransactionPinTokenRequest request);
}
