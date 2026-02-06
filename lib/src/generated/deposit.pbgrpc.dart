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

import 'deposit.pb.dart' as $14;

export 'deposit.pb.dart';

@$pb.GrpcServiceName('pb.DepositService')
class DepositServiceClient extends $grpc.Client {
  static final _$initiateDeposit = $grpc.ClientMethod<$14.InitiateDepositRequest, $14.InitiateDepositResponse>(
      '/pb.DepositService/InitiateDeposit',
      ($14.InitiateDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $14.InitiateDepositResponse.fromBuffer(value));
  static final _$getDepositDetails = $grpc.ClientMethod<$14.GetDepositDetailsRequest, $14.GetDepositDetailsResponse>(
      '/pb.DepositService/GetDepositDetails',
      ($14.GetDepositDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $14.GetDepositDetailsResponse.fromBuffer(value));

  DepositServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$14.InitiateDepositResponse> initiateDeposit($14.InitiateDepositRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$14.GetDepositDetailsResponse> getDepositDetails($14.GetDepositDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositDetails, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.DepositService')
abstract class DepositServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.DepositService';

  DepositServiceBase() {
    $addMethod($grpc.ServiceMethod<$14.InitiateDepositRequest, $14.InitiateDepositResponse>(
        'InitiateDeposit',
        initiateDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $14.InitiateDepositRequest.fromBuffer(value),
        ($14.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$14.GetDepositDetailsRequest, $14.GetDepositDetailsResponse>(
        'GetDepositDetails',
        getDepositDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $14.GetDepositDetailsRequest.fromBuffer(value),
        ($14.GetDepositDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$14.InitiateDepositResponse> initiateDeposit_Pre($grpc.ServiceCall call, $async.Future<$14.InitiateDepositRequest> request) async {
    return initiateDeposit(call, await request);
  }

  $async.Future<$14.GetDepositDetailsResponse> getDepositDetails_Pre($grpc.ServiceCall call, $async.Future<$14.GetDepositDetailsRequest> request) async {
    return getDepositDetails(call, await request);
  }

  $async.Future<$14.InitiateDepositResponse> initiateDeposit($grpc.ServiceCall call, $14.InitiateDepositRequest request);
  $async.Future<$14.GetDepositDetailsResponse> getDepositDetails($grpc.ServiceCall call, $14.GetDepositDetailsRequest request);
}
