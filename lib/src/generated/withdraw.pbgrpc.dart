///
//  Generated code. Do not modify.
//  source: withdraw.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'withdraw.pb.dart' as $33;
export 'withdraw.pb.dart';

class WithdrawServiceClient extends $grpc.Client {
  static final _$initiateWithdrawal = $grpc.ClientMethod<
          $33.InitiateWithdrawalRequest, $33.InitiateWithdrawalResponse>(
      '/pb.WithdrawService/InitiateWithdrawal',
      ($33.InitiateWithdrawalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.InitiateWithdrawalResponse.fromBuffer(value));
  static final _$getWithdrawalDetails = $grpc.ClientMethod<
          $33.GetWithdrawalDetailsRequest, $33.GetWithdrawalDetailsResponse>(
      '/pb.WithdrawService/GetWithdrawalDetails',
      ($33.GetWithdrawalDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetWithdrawalDetailsResponse.fromBuffer(value));

  WithdrawServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$33.InitiateWithdrawalResponse> initiateWithdrawal(
      $33.InitiateWithdrawalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateWithdrawal, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetWithdrawalDetailsResponse> getWithdrawalDetails(
      $33.GetWithdrawalDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWithdrawalDetails, request, options: options);
  }
}

abstract class WithdrawServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.WithdrawService';

  WithdrawServiceBase() {
    $addMethod($grpc.ServiceMethod<$33.InitiateWithdrawalRequest,
            $33.InitiateWithdrawalResponse>(
        'InitiateWithdrawal',
        initiateWithdrawal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.InitiateWithdrawalRequest.fromBuffer(value),
        ($33.InitiateWithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetWithdrawalDetailsRequest,
            $33.GetWithdrawalDetailsResponse>(
        'GetWithdrawalDetails',
        getWithdrawalDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetWithdrawalDetailsRequest.fromBuffer(value),
        ($33.GetWithdrawalDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.InitiateWithdrawalResponse> initiateWithdrawal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.InitiateWithdrawalRequest> request) async {
    return initiateWithdrawal(call, await request);
  }

  $async.Future<$33.GetWithdrawalDetailsResponse> getWithdrawalDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetWithdrawalDetailsRequest> request) async {
    return getWithdrawalDetails(call, await request);
  }

  $async.Future<$33.InitiateWithdrawalResponse> initiateWithdrawal(
      $grpc.ServiceCall call, $33.InitiateWithdrawalRequest request);
  $async.Future<$33.GetWithdrawalDetailsResponse> getWithdrawalDetails(
      $grpc.ServiceCall call, $33.GetWithdrawalDetailsRequest request);
}
