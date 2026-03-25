// This is a generated file - do not edit.
//
// Generated from deposit.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'deposit.pb.dart' as $0;

export 'deposit.pb.dart';

/// Service for handling deposits (asynchronous)
@$pb.GrpcServiceName('pb.DepositService')
class DepositServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DepositServiceClient(super.channel, {super.options, super.interceptors});

  /// Initiates a deposit into a specified account.
  /// The deposit will be processed asynchronously.
  /// Amount should be provided in the smallest currency unit (e.g., cents).
  $grpc.ResponseFuture<$0.InitiateDepositResponse> initiateDeposit(
    $0.InitiateDepositRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  /// Retrieves the details and status of a specific deposit transaction.
  $grpc.ResponseFuture<$0.GetDepositDetailsResponse> getDepositDetails(
    $0.GetDepositDetailsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDepositDetails, request, options: options);
  }

  /// Simulate a test deposit (sandbox only)
  $grpc.ResponseFuture<$0.InitiateDepositResponse> simulateTestDeposit(
    $0.SimulateTestDepositRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$simulateTestDeposit, request, options: options);
  }

  /// Get available deposit methods for a country
  $grpc.ResponseFuture<$0.GetDepositMethodsResponse> getDepositMethods(
    $0.GetDepositMethodsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDepositMethods, request, options: options);
  }

  // method descriptors

  static final _$initiateDeposit =
      $grpc.ClientMethod<$0.InitiateDepositRequest, $0.InitiateDepositResponse>(
          '/pb.DepositService/InitiateDeposit',
          ($0.InitiateDepositRequest value) => value.writeToBuffer(),
          $0.InitiateDepositResponse.fromBuffer);
  static final _$getDepositDetails = $grpc.ClientMethod<
          $0.GetDepositDetailsRequest, $0.GetDepositDetailsResponse>(
      '/pb.DepositService/GetDepositDetails',
      ($0.GetDepositDetailsRequest value) => value.writeToBuffer(),
      $0.GetDepositDetailsResponse.fromBuffer);
  static final _$simulateTestDeposit = $grpc.ClientMethod<
          $0.SimulateTestDepositRequest, $0.InitiateDepositResponse>(
      '/pb.DepositService/SimulateTestDeposit',
      ($0.SimulateTestDepositRequest value) => value.writeToBuffer(),
      $0.InitiateDepositResponse.fromBuffer);
  static final _$getDepositMethods = $grpc.ClientMethod<
          $0.GetDepositMethodsRequest, $0.GetDepositMethodsResponse>(
      '/pb.DepositService/GetDepositMethods',
      ($0.GetDepositMethodsRequest value) => value.writeToBuffer(),
      $0.GetDepositMethodsResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.DepositService')
abstract class DepositServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.DepositService';

  DepositServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.InitiateDepositRequest,
            $0.InitiateDepositResponse>(
        'InitiateDeposit',
        initiateDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateDepositRequest.fromBuffer(value),
        ($0.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDepositDetailsRequest,
            $0.GetDepositDetailsResponse>(
        'GetDepositDetails',
        getDepositDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDepositDetailsRequest.fromBuffer(value),
        ($0.GetDepositDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SimulateTestDepositRequest,
            $0.InitiateDepositResponse>(
        'SimulateTestDeposit',
        simulateTestDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SimulateTestDepositRequest.fromBuffer(value),
        ($0.InitiateDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDepositMethodsRequest,
            $0.GetDepositMethodsResponse>(
        'GetDepositMethods',
        getDepositMethods_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDepositMethodsRequest.fromBuffer(value),
        ($0.GetDepositMethodsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.InitiateDepositResponse> initiateDeposit_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InitiateDepositRequest> $request) async {
    return initiateDeposit($call, await $request);
  }

  $async.Future<$0.InitiateDepositResponse> initiateDeposit(
      $grpc.ServiceCall call, $0.InitiateDepositRequest request);

  $async.Future<$0.GetDepositDetailsResponse> getDepositDetails_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDepositDetailsRequest> $request) async {
    return getDepositDetails($call, await $request);
  }

  $async.Future<$0.GetDepositDetailsResponse> getDepositDetails(
      $grpc.ServiceCall call, $0.GetDepositDetailsRequest request);

  $async.Future<$0.InitiateDepositResponse> simulateTestDeposit_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SimulateTestDepositRequest> $request) async {
    return simulateTestDeposit($call, await $request);
  }

  $async.Future<$0.InitiateDepositResponse> simulateTestDeposit(
      $grpc.ServiceCall call, $0.SimulateTestDepositRequest request);

  $async.Future<$0.GetDepositMethodsResponse> getDepositMethods_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDepositMethodsRequest> $request) async {
    return getDepositMethods($call, await $request);
  }

  $async.Future<$0.GetDepositMethodsResponse> getDepositMethods(
      $grpc.ServiceCall call, $0.GetDepositMethodsRequest request);
}
