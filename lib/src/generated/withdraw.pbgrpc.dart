// This is a generated file - do not edit.
//
// Generated from withdraw.proto.

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

import 'withdraw.pb.dart' as $0;

export 'withdraw.pb.dart';

/// Service for handling withdrawals
@$pb.GrpcServiceName('pb.WithdrawService')
class WithdrawServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  WithdrawServiceClient(super.channel, {super.options, super.interceptors});

  /// Initiates a withdrawal from a LazerVault account to an external bank account.
  $grpc.ResponseFuture<$0.InitiateWithdrawalResponse> initiateWithdrawal(
    $0.InitiateWithdrawalRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateWithdrawal, request, options: options);
  }

  /// Retrieves the details and status of a specific withdrawal transaction.
  $grpc.ResponseFuture<$0.GetWithdrawalDetailsResponse> getWithdrawalDetails(
    $0.GetWithdrawalDetailsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getWithdrawalDetails, request, options: options);
  }

  // method descriptors

  static final _$initiateWithdrawal = $grpc.ClientMethod<
          $0.InitiateWithdrawalRequest, $0.InitiateWithdrawalResponse>(
      '/pb.WithdrawService/InitiateWithdrawal',
      ($0.InitiateWithdrawalRequest value) => value.writeToBuffer(),
      $0.InitiateWithdrawalResponse.fromBuffer);
  static final _$getWithdrawalDetails = $grpc.ClientMethod<
          $0.GetWithdrawalDetailsRequest, $0.GetWithdrawalDetailsResponse>(
      '/pb.WithdrawService/GetWithdrawalDetails',
      ($0.GetWithdrawalDetailsRequest value) => value.writeToBuffer(),
      $0.GetWithdrawalDetailsResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.WithdrawService')
abstract class WithdrawServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.WithdrawService';

  WithdrawServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.InitiateWithdrawalRequest,
            $0.InitiateWithdrawalResponse>(
        'InitiateWithdrawal',
        initiateWithdrawal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateWithdrawalRequest.fromBuffer(value),
        ($0.InitiateWithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWithdrawalDetailsRequest,
            $0.GetWithdrawalDetailsResponse>(
        'GetWithdrawalDetails',
        getWithdrawalDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWithdrawalDetailsRequest.fromBuffer(value),
        ($0.GetWithdrawalDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.InitiateWithdrawalResponse> initiateWithdrawal_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InitiateWithdrawalRequest> $request) async {
    return initiateWithdrawal($call, await $request);
  }

  $async.Future<$0.InitiateWithdrawalResponse> initiateWithdrawal(
      $grpc.ServiceCall call, $0.InitiateWithdrawalRequest request);

  $async.Future<$0.GetWithdrawalDetailsResponse> getWithdrawalDetails_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetWithdrawalDetailsRequest> $request) async {
    return getWithdrawalDetails($call, await $request);
  }

  $async.Future<$0.GetWithdrawalDetailsResponse> getWithdrawalDetails(
      $grpc.ServiceCall call, $0.GetWithdrawalDetailsRequest request);
}
