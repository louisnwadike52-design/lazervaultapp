///
//  Generated code. Do not modify.
//  source: deposit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'deposit.pb.dart' as $13;
export 'deposit.pb.dart';

class DepositServiceClient extends $grpc.Client {
  static final _$initiateDeposit = $grpc.ClientMethod<
          $13.InitiateDepositRequest, $13.InitiateDepositResponse>(
      '/pb.DepositService/InitiateDeposit',
      ($13.InitiateDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.InitiateDepositResponse.fromBuffer(value));
  static final _$getDepositDetails = $grpc.ClientMethod<
          $13.GetDepositDetailsRequest, $13.GetDepositDetailsResponse>(
      '/pb.DepositService/GetDepositDetails',
      ($13.GetDepositDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetDepositDetailsResponse.fromBuffer(value));
  static final _$simulateTestDeposit = $grpc.ClientMethod<
          $13.SimulateTestDepositRequest, $13.InitiateDepositResponse>(
      '/pb.DepositService/SimulateTestDeposit',
      ($13.SimulateTestDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.InitiateDepositResponse.fromBuffer(value));
  static final _$getDepositMethods = $grpc.ClientMethod<
          $13.GetDepositMethodsRequest, $13.GetDepositMethodsResponse>(
      '/pb.DepositService/GetDepositMethods',
      ($13.GetDepositMethodsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetDepositMethodsResponse.fromBuffer(value));

  DepositServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$13.InitiateDepositResponse> initiateDeposit(
      $13.InitiateDepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetDepositDetailsResponse> getDepositDetails(
      $13.GetDepositDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositDetails, request, options: options);
  }

  $grpc.ResponseFuture<$13.InitiateDepositResponse> simulateTestDeposit(
      $13.SimulateTestDepositRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$simulateTestDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$13.GetDepositMethodsResponse> getDepositMethods(
      $13.GetDepositMethodsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositMethods, request, options: options);
  }
}

abstract class DepositServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.DepositService';

  DepositServiceBase() {
    $addMethod($grpc.ServiceMethod<$13.InitiateDepositRequest,
            $13.InitiateDepositResponse>(
        'InitiateDeposit',
        initiateDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.InitiateDepositRequest.fromBuffer(value),
        ($13.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetDepositDetailsRequest,
            $13.GetDepositDetailsResponse>(
        'GetDepositDetails',
        getDepositDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetDepositDetailsRequest.fromBuffer(value),
        ($13.GetDepositDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.SimulateTestDepositRequest,
            $13.InitiateDepositResponse>(
        'SimulateTestDeposit',
        simulateTestDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.SimulateTestDepositRequest.fromBuffer(value),
        ($13.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$13.GetDepositMethodsRequest,
            $13.GetDepositMethodsResponse>(
        'GetDepositMethods',
        getDepositMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetDepositMethodsRequest.fromBuffer(value),
        ($13.GetDepositMethodsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$13.InitiateDepositResponse> initiateDeposit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.InitiateDepositRequest> request) async {
    return initiateDeposit(call, await request);
  }

  $async.Future<$13.GetDepositDetailsResponse> getDepositDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GetDepositDetailsRequest> request) async {
    return getDepositDetails(call, await request);
  }

  $async.Future<$13.InitiateDepositResponse> simulateTestDeposit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.SimulateTestDepositRequest> request) async {
    return simulateTestDeposit(call, await request);
  }

  $async.Future<$13.GetDepositMethodsResponse> getDepositMethods_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GetDepositMethodsRequest> request) async {
    return getDepositMethods(call, await request);
  }

  $async.Future<$13.InitiateDepositResponse> initiateDeposit(
      $grpc.ServiceCall call, $13.InitiateDepositRequest request);
  $async.Future<$13.GetDepositDetailsResponse> getDepositDetails(
      $grpc.ServiceCall call, $13.GetDepositDetailsRequest request);
  $async.Future<$13.InitiateDepositResponse> simulateTestDeposit(
      $grpc.ServiceCall call, $13.SimulateTestDepositRequest request);
  $async.Future<$13.GetDepositMethodsResponse> getDepositMethods(
      $grpc.ServiceCall call, $13.GetDepositMethodsRequest request);
}
