///
//  Generated code. Do not modify.
//  source: deposit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'deposit.pb.dart' as $6;
export 'deposit.pb.dart';

class DepositServiceClient extends $grpc.Client {
  static final _$initiateDeposit =
      $grpc.ClientMethod<$6.InitiateDepositRequest, $6.InitiateDepositResponse>(
          '/pb.DepositService/InitiateDeposit',
          ($6.InitiateDepositRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $6.InitiateDepositResponse.fromBuffer(value));
  static final _$getDepositDetails = $grpc.ClientMethod<
          $6.GetDepositDetailsRequest, $6.GetDepositDetailsResponse>(
      '/pb.DepositService/GetDepositDetails',
      ($6.GetDepositDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $6.GetDepositDetailsResponse.fromBuffer(value));

  DepositServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$6.InitiateDepositResponse> initiateDeposit(
      $6.InitiateDepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetDepositDetailsResponse> getDepositDetails(
      $6.GetDepositDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositDetails, request, options: options);
  }
}

abstract class DepositServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.DepositService';

  DepositServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.InitiateDepositRequest,
            $6.InitiateDepositResponse>(
        'InitiateDeposit',
        initiateDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.InitiateDepositRequest.fromBuffer(value),
        ($6.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetDepositDetailsRequest,
            $6.GetDepositDetailsResponse>(
        'GetDepositDetails',
        getDepositDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.GetDepositDetailsRequest.fromBuffer(value),
        ($6.GetDepositDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.InitiateDepositResponse> initiateDeposit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$6.InitiateDepositRequest> request) async {
    return initiateDeposit(call, await request);
  }

  $async.Future<$6.GetDepositDetailsResponse> getDepositDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$6.GetDepositDetailsRequest> request) async {
    return getDepositDetails(call, await request);
  }

  $async.Future<$6.InitiateDepositResponse> initiateDeposit(
      $grpc.ServiceCall call, $6.InitiateDepositRequest request);
  $async.Future<$6.GetDepositDetailsResponse> getDepositDetails(
      $grpc.ServiceCall call, $6.GetDepositDetailsRequest request);
}
