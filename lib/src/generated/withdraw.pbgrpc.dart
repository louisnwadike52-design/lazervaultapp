//
//  Generated code. Do not modify.
//  source: withdraw.proto
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

import 'withdraw.pb.dart' as $15;

export 'withdraw.pb.dart';

@$pb.GrpcServiceName('pb.WithdrawService')
class WithdrawServiceClient extends $grpc.Client {
  static final _$initiateWithdrawal = $grpc.ClientMethod<$15.InitiateWithdrawalRequest, $15.InitiateWithdrawalResponse>(
      '/pb.WithdrawService/InitiateWithdrawal',
      ($15.InitiateWithdrawalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.InitiateWithdrawalResponse.fromBuffer(value));
  static final _$getWithdrawalDetails = $grpc.ClientMethod<$15.GetWithdrawalDetailsRequest, $15.GetWithdrawalDetailsResponse>(
      '/pb.WithdrawService/GetWithdrawalDetails',
      ($15.GetWithdrawalDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.GetWithdrawalDetailsResponse.fromBuffer(value));

  WithdrawServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$15.InitiateWithdrawalResponse> initiateWithdrawal($15.InitiateWithdrawalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateWithdrawal, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetWithdrawalDetailsResponse> getWithdrawalDetails($15.GetWithdrawalDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWithdrawalDetails, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.WithdrawService')
abstract class WithdrawServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.WithdrawService';

  WithdrawServiceBase() {
    $addMethod($grpc.ServiceMethod<$15.InitiateWithdrawalRequest, $15.InitiateWithdrawalResponse>(
        'InitiateWithdrawal',
        initiateWithdrawal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.InitiateWithdrawalRequest.fromBuffer(value),
        ($15.InitiateWithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetWithdrawalDetailsRequest, $15.GetWithdrawalDetailsResponse>(
        'GetWithdrawalDetails',
        getWithdrawalDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetWithdrawalDetailsRequest.fromBuffer(value),
        ($15.GetWithdrawalDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$15.InitiateWithdrawalResponse> initiateWithdrawal_Pre($grpc.ServiceCall $call, $async.Future<$15.InitiateWithdrawalRequest> $request) async {
    return initiateWithdrawal($call, await $request);
  }

  $async.Future<$15.GetWithdrawalDetailsResponse> getWithdrawalDetails_Pre($grpc.ServiceCall $call, $async.Future<$15.GetWithdrawalDetailsRequest> $request) async {
    return getWithdrawalDetails($call, await $request);
  }

  $async.Future<$15.InitiateWithdrawalResponse> initiateWithdrawal($grpc.ServiceCall call, $15.InitiateWithdrawalRequest request);
  $async.Future<$15.GetWithdrawalDetailsResponse> getWithdrawalDetails($grpc.ServiceCall call, $15.GetWithdrawalDetailsRequest request);
}
