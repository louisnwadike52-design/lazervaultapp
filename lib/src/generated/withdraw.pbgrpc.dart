//
//  Generated code. Do not modify.
//  source: withdraw.proto
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

import 'withdraw.pb.dart' as $41;

export 'withdraw.pb.dart';

@$pb.GrpcServiceName('pb.WithdrawService')
class WithdrawServiceClient extends $grpc.Client {
  static final _$initiateWithdrawal = $grpc.ClientMethod<$41.InitiateWithdrawalRequest, $41.InitiateWithdrawalResponse>(
      '/pb.WithdrawService/InitiateWithdrawal',
      ($41.InitiateWithdrawalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $41.InitiateWithdrawalResponse.fromBuffer(value));
  static final _$getWithdrawalDetails = $grpc.ClientMethod<$41.GetWithdrawalDetailsRequest, $41.GetWithdrawalDetailsResponse>(
      '/pb.WithdrawService/GetWithdrawalDetails',
      ($41.GetWithdrawalDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $41.GetWithdrawalDetailsResponse.fromBuffer(value));

  WithdrawServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$41.InitiateWithdrawalResponse> initiateWithdrawal($41.InitiateWithdrawalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateWithdrawal, request, options: options);
  }

  $grpc.ResponseFuture<$41.GetWithdrawalDetailsResponse> getWithdrawalDetails($41.GetWithdrawalDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWithdrawalDetails, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.WithdrawService')
abstract class WithdrawServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.WithdrawService';

  WithdrawServiceBase() {
    $addMethod($grpc.ServiceMethod<$41.InitiateWithdrawalRequest, $41.InitiateWithdrawalResponse>(
        'InitiateWithdrawal',
        initiateWithdrawal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $41.InitiateWithdrawalRequest.fromBuffer(value),
        ($41.InitiateWithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.GetWithdrawalDetailsRequest, $41.GetWithdrawalDetailsResponse>(
        'GetWithdrawalDetails',
        getWithdrawalDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $41.GetWithdrawalDetailsRequest.fromBuffer(value),
        ($41.GetWithdrawalDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$41.InitiateWithdrawalResponse> initiateWithdrawal_Pre($grpc.ServiceCall call, $async.Future<$41.InitiateWithdrawalRequest> request) async {
    return initiateWithdrawal(call, await request);
  }

  $async.Future<$41.GetWithdrawalDetailsResponse> getWithdrawalDetails_Pre($grpc.ServiceCall call, $async.Future<$41.GetWithdrawalDetailsRequest> request) async {
    return getWithdrawalDetails(call, await request);
  }

  $async.Future<$41.InitiateWithdrawalResponse> initiateWithdrawal($grpc.ServiceCall call, $41.InitiateWithdrawalRequest request);
  $async.Future<$41.GetWithdrawalDetailsResponse> getWithdrawalDetails($grpc.ServiceCall call, $41.GetWithdrawalDetailsRequest request);
}
