///
//  Generated code. Do not modify.
//  source: deposit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'deposit.pb.dart' as $10;
export 'deposit.pb.dart';

class DepositServiceClient extends $grpc.Client {
  static final _$initiateDeposit = $grpc.ClientMethod<
          $10.InitiateDepositRequest, $10.InitiateDepositResponse>(
      '/pb.DepositService/InitiateDeposit',
      ($10.InitiateDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.InitiateDepositResponse.fromBuffer(value));
  static final _$getDepositDetails = $grpc.ClientMethod<
          $10.GetDepositDetailsRequest, $10.GetDepositDetailsResponse>(
      '/pb.DepositService/GetDepositDetails',
      ($10.GetDepositDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetDepositDetailsResponse.fromBuffer(value));

  DepositServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.InitiateDepositResponse> initiateDeposit(
      $10.InitiateDepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetDepositDetailsResponse> getDepositDetails(
      $10.GetDepositDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositDetails, request, options: options);
  }
}

abstract class DepositServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.DepositService';

  DepositServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.InitiateDepositRequest,
            $10.InitiateDepositResponse>(
        'InitiateDeposit',
        initiateDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.InitiateDepositRequest.fromBuffer(value),
        ($10.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetDepositDetailsRequest,
            $10.GetDepositDetailsResponse>(
        'GetDepositDetails',
        getDepositDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetDepositDetailsRequest.fromBuffer(value),
        ($10.GetDepositDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$10.InitiateDepositResponse> initiateDeposit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.InitiateDepositRequest> request) async {
    return initiateDeposit(call, await request);
  }

  $async.Future<$10.GetDepositDetailsResponse> getDepositDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetDepositDetailsRequest> request) async {
    return getDepositDetails(call, await request);
  }

  $async.Future<$10.InitiateDepositResponse> initiateDeposit(
      $grpc.ServiceCall call, $10.InitiateDepositRequest request);
  $async.Future<$10.GetDepositDetailsResponse> getDepositDetails(
      $grpc.ServiceCall call, $10.GetDepositDetailsRequest request);
}
