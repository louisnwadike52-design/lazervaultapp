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

import 'withdraw.pb.dart' as $14;

export 'withdraw.pb.dart';

@$pb.GrpcServiceName('pb.WithdrawService')
class WithdrawServiceClient extends $grpc.Client {
  static final _$initiateWithdrawal = $grpc.ClientMethod<$14.InitiateWithdrawalRequest, $14.InitiateWithdrawalResponse>(
      '/pb.WithdrawService/InitiateWithdrawal',
      ($14.InitiateWithdrawalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $14.InitiateWithdrawalResponse.fromBuffer(value));
  static final _$getWithdrawalDetails = $grpc.ClientMethod<$14.GetWithdrawalDetailsRequest, $14.GetWithdrawalDetailsResponse>(
      '/pb.WithdrawService/GetWithdrawalDetails',
      ($14.GetWithdrawalDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $14.GetWithdrawalDetailsResponse.fromBuffer(value));

  WithdrawServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$14.InitiateWithdrawalResponse> initiateWithdrawal($14.InitiateWithdrawalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateWithdrawal, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetWithdrawalDetailsResponse> getWithdrawalDetails($14.GetWithdrawalDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWithdrawalDetails, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.WithdrawService')
abstract class WithdrawServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.WithdrawService';

  WithdrawServiceBase() {
    $addMethod($grpc.ServiceMethod<$14.InitiateWithdrawalRequest, $14.InitiateWithdrawalResponse>(
        'InitiateWithdrawal',
        initiateWithdrawal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $14.InitiateWithdrawalRequest.fromBuffer(value),
        ($14.InitiateWithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetWithdrawalDetailsRequest, $14.GetWithdrawalDetailsResponse>(
        'GetWithdrawalDetails',
        getWithdrawalDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $14.GetWithdrawalDetailsRequest.fromBuffer(value),
        ($14.GetWithdrawalDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$14.InitiateWithdrawalResponse> initiateWithdrawal_Pre($grpc.ServiceCall $call, $async.Future<$14.InitiateWithdrawalRequest> $request) async {
    return initiateWithdrawal($call, await $request);
  }

  $async.Future<$14.GetWithdrawalDetailsResponse> getWithdrawalDetails_Pre($grpc.ServiceCall $call, $async.Future<$14.GetWithdrawalDetailsRequest> $request) async {
    return getWithdrawalDetails($call, await $request);
  }

  $async.Future<$14.InitiateWithdrawalResponse> initiateWithdrawal($grpc.ServiceCall call, $14.InitiateWithdrawalRequest request);
  $async.Future<$14.GetWithdrawalDetailsResponse> getWithdrawalDetails($grpc.ServiceCall call, $14.GetWithdrawalDetailsRequest request);
}
