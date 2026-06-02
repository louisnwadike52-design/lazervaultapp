///
//  Generated code. Do not modify.
//  source: deposit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'deposit.pb.dart' as $2;
export 'deposit.pb.dart';

class DepositServiceClient extends $grpc.Client {
  static final _$initiateDeposit =
      $grpc.ClientMethod<$2.InitiateDepositRequest, $2.InitiateDepositResponse>(
          '/pb.DepositService/InitiateDeposit',
          ($2.InitiateDepositRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.InitiateDepositResponse.fromBuffer(value));
  static final _$getDepositDetails = $grpc.ClientMethod<
          $2.GetDepositDetailsRequest, $2.GetDepositDetailsResponse>(
      '/pb.DepositService/GetDepositDetails',
      ($2.GetDepositDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.GetDepositDetailsResponse.fromBuffer(value));
  static final _$getDepositMethods = $grpc.ClientMethod<
          $2.GetDepositMethodsRequest, $2.GetDepositMethodsResponse>(
      '/pb.DepositService/GetDepositMethods',
      ($2.GetDepositMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.GetDepositMethodsResponse.fromBuffer(value));

  DepositServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.InitiateDepositResponse> initiateDeposit(
      $2.InitiateDepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetDepositDetailsResponse> getDepositDetails(
      $2.GetDepositDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositDetails, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetDepositMethodsResponse> getDepositMethods(
      $2.GetDepositMethodsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositMethods, request, options: options);
  }
}

abstract class DepositServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.DepositService';

  DepositServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.InitiateDepositRequest,
            $2.InitiateDepositResponse>(
        'InitiateDeposit',
        initiateDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.InitiateDepositRequest.fromBuffer(value),
        ($2.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetDepositDetailsRequest,
            $2.GetDepositDetailsResponse>(
        'GetDepositDetails',
        getDepositDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetDepositDetailsRequest.fromBuffer(value),
        ($2.GetDepositDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetDepositMethodsRequest,
            $2.GetDepositMethodsResponse>(
        'GetDepositMethods',
        getDepositMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetDepositMethodsRequest.fromBuffer(value),
        ($2.GetDepositMethodsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.InitiateDepositResponse> initiateDeposit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.InitiateDepositRequest> request) async {
    return initiateDeposit(call, await request);
  }

  $async.Future<$2.GetDepositDetailsResponse> getDepositDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.GetDepositDetailsRequest> request) async {
    return getDepositDetails(call, await request);
  }

  $async.Future<$2.GetDepositMethodsResponse> getDepositMethods_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.GetDepositMethodsRequest> request) async {
    return getDepositMethods(call, await request);
  }

  $async.Future<$2.InitiateDepositResponse> initiateDeposit(
      $grpc.ServiceCall call, $2.InitiateDepositRequest request);
  $async.Future<$2.GetDepositDetailsResponse> getDepositDetails(
      $grpc.ServiceCall call, $2.GetDepositDetailsRequest request);
  $async.Future<$2.GetDepositMethodsResponse> getDepositMethods(
      $grpc.ServiceCall call, $2.GetDepositMethodsRequest request);
}
