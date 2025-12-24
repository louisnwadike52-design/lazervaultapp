///
//  Generated code. Do not modify.
//  source: withdraw.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'withdraw.pb.dart' as $25;
export 'withdraw.pb.dart';

class WithdrawServiceClient extends $grpc.Client {
  static final _$initiateWithdrawal = $grpc.ClientMethod<
          $25.InitiateWithdrawalRequest, $25.InitiateWithdrawalResponse>(
      '/pb.WithdrawService/InitiateWithdrawal',
      ($25.InitiateWithdrawalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.InitiateWithdrawalResponse.fromBuffer(value));
  static final _$getWithdrawalDetails = $grpc.ClientMethod<
          $25.GetWithdrawalDetailsRequest, $25.GetWithdrawalDetailsResponse>(
      '/pb.WithdrawService/GetWithdrawalDetails',
      ($25.GetWithdrawalDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $25.GetWithdrawalDetailsResponse.fromBuffer(value));

  WithdrawServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$25.InitiateWithdrawalResponse> initiateWithdrawal(
      $25.InitiateWithdrawalRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateWithdrawal, request, options: options);
  }

  $grpc.ResponseFuture<$25.GetWithdrawalDetailsResponse> getWithdrawalDetails(
      $25.GetWithdrawalDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWithdrawalDetails, request, options: options);
  }
}

abstract class WithdrawServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.WithdrawService';

  WithdrawServiceBase() {
    $addMethod($grpc.ServiceMethod<$25.InitiateWithdrawalRequest,
            $25.InitiateWithdrawalResponse>(
        'InitiateWithdrawal',
        initiateWithdrawal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.InitiateWithdrawalRequest.fromBuffer(value),
        ($25.InitiateWithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$25.GetWithdrawalDetailsRequest,
            $25.GetWithdrawalDetailsResponse>(
        'GetWithdrawalDetails',
        getWithdrawalDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $25.GetWithdrawalDetailsRequest.fromBuffer(value),
        ($25.GetWithdrawalDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$25.InitiateWithdrawalResponse> initiateWithdrawal_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.InitiateWithdrawalRequest> request) async {
    return initiateWithdrawal(call, await request);
  }

  $async.Future<$25.GetWithdrawalDetailsResponse> getWithdrawalDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$25.GetWithdrawalDetailsRequest> request) async {
    return getWithdrawalDetails(call, await request);
  }

  $async.Future<$25.InitiateWithdrawalResponse> initiateWithdrawal(
      $grpc.ServiceCall call, $25.InitiateWithdrawalRequest request);
  $async.Future<$25.GetWithdrawalDetailsResponse> getWithdrawalDetails(
      $grpc.ServiceCall call, $25.GetWithdrawalDetailsRequest request);
}
