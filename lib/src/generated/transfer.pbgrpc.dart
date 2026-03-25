// This is a generated file - do not edit.
//
// Generated from transfer.proto.

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

import 'transfer.pb.dart' as $0;

export 'transfer.pb.dart';

/// Service definition for transfers
@$pb.GrpcServiceName('pb.TransferService')
class TransferServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TransferServiceClient(super.channel, {super.options, super.interceptors});

  /// Initiates a new transfer
  $grpc.ResponseFuture<$0.InitiateTransferResponse> initiateTransfer(
    $0.InitiateTransferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  /// Lists all transfers for the authenticated user with pagination
  $grpc.ResponseFuture<$0.ListTransfersResponse> listTransfers(
    $0.ListTransfersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  /// Fetches aggregated financial statistics based on transfer history.
  $grpc.ResponseFuture<$0.GetStatisticsResponse> getStatistics(
    $0.GetStatisticsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  /// Retrieves the details of a specific transfer transaction.
  $grpc.ResponseFuture<$0.GetTransferDetailsResponse> getTransferDetails(
    $0.GetTransferDetailsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }

  // method descriptors

  static final _$initiateTransfer = $grpc.ClientMethod<
          $0.InitiateTransferRequest, $0.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($0.InitiateTransferRequest value) => value.writeToBuffer(),
      $0.InitiateTransferResponse.fromBuffer);
  static final _$listTransfers =
      $grpc.ClientMethod<$0.ListTransfersRequest, $0.ListTransfersResponse>(
          '/pb.TransferService/ListTransfers',
          ($0.ListTransfersRequest value) => value.writeToBuffer(),
          $0.ListTransfersResponse.fromBuffer);
  static final _$getStatistics =
      $grpc.ClientMethod<$0.GetStatisticsRequest, $0.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($0.GetStatisticsRequest value) => value.writeToBuffer(),
          $0.GetStatisticsResponse.fromBuffer);
  static final _$getTransferDetails = $grpc.ClientMethod<
          $0.GetTransferDetailsRequest, $0.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($0.GetTransferDetailsRequest value) => value.writeToBuffer(),
      $0.GetTransferDetailsResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.TransferService')
abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.InitiateTransferRequest,
            $0.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateTransferRequest.fromBuffer(value),
        ($0.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListTransfersRequest, $0.ListTransfersResponse>(
            'ListTransfers',
            listTransfers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListTransfersRequest.fromBuffer(value),
            ($0.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetStatisticsRequest, $0.GetStatisticsResponse>(
            'GetStatistics',
            getStatistics_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetStatisticsRequest.fromBuffer(value),
            ($0.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferDetailsRequest,
            $0.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransferDetailsRequest.fromBuffer(value),
        ($0.GetTransferDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InitiateTransferRequest> $request) async {
    return initiateTransfer($call, await $request);
  }

  $async.Future<$0.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $0.InitiateTransferRequest request);

  $async.Future<$0.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListTransfersRequest> $request) async {
    return listTransfers($call, await $request);
  }

  $async.Future<$0.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $0.ListTransfersRequest request);

  $async.Future<$0.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetStatisticsRequest> $request) async {
    return getStatistics($call, await $request);
  }

  $async.Future<$0.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $0.GetStatisticsRequest request);

  $async.Future<$0.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTransferDetailsRequest> $request) async {
    return getTransferDetails($call, await $request);
  }

  $async.Future<$0.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $0.GetTransferDetailsRequest request);
}
