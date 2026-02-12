//
//  Generated code. Do not modify.
//  source: deposit.proto
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

import 'deposit.pb.dart' as $1;

export 'deposit.pb.dart';

@$pb.GrpcServiceName('pb.DepositService')
class DepositServiceClient extends $grpc.Client {
  static final _$initiateDeposit = $grpc.ClientMethod<$1.InitiateDepositRequest, $1.InitiateDepositResponse>(
      '/pb.DepositService/InitiateDeposit',
      ($1.InitiateDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.InitiateDepositResponse.fromBuffer(value));
  static final _$getDepositDetails = $grpc.ClientMethod<$1.GetDepositDetailsRequest, $1.GetDepositDetailsResponse>(
      '/pb.DepositService/GetDepositDetails',
      ($1.GetDepositDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetDepositDetailsResponse.fromBuffer(value));

  DepositServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.InitiateDepositResponse> initiateDeposit($1.InitiateDepositRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetDepositDetailsResponse> getDepositDetails($1.GetDepositDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositDetails, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.DepositService')
abstract class DepositServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.DepositService';

  DepositServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.InitiateDepositRequest, $1.InitiateDepositResponse>(
        'InitiateDeposit',
        initiateDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.InitiateDepositRequest.fromBuffer(value),
        ($1.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetDepositDetailsRequest, $1.GetDepositDetailsResponse>(
        'GetDepositDetails',
        getDepositDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetDepositDetailsRequest.fromBuffer(value),
        ($1.GetDepositDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.InitiateDepositResponse> initiateDeposit_Pre($grpc.ServiceCall call, $async.Future<$1.InitiateDepositRequest> request) async {
    return initiateDeposit(call, await request);
  }

  $async.Future<$1.GetDepositDetailsResponse> getDepositDetails_Pre($grpc.ServiceCall call, $async.Future<$1.GetDepositDetailsRequest> request) async {
    return getDepositDetails(call, await request);
  }

  $async.Future<$1.InitiateDepositResponse> initiateDeposit($grpc.ServiceCall call, $1.InitiateDepositRequest request);
  $async.Future<$1.GetDepositDetailsResponse> getDepositDetails($grpc.ServiceCall call, $1.GetDepositDetailsRequest request);
}
