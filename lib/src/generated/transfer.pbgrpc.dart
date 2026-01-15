///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transfer.pb.dart' as $29;
export 'transfer.pb.dart';

class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<
          $29.InitiateTransferRequest, $29.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($29.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.InitiateTransferResponse.fromBuffer(value));
  static final _$listTransfers =
      $grpc.ClientMethod<$29.ListTransfersRequest, $29.ListTransfersResponse>(
          '/pb.TransferService/ListTransfers',
          ($29.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.ListTransfersResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$29.GetStatisticsRequest, $29.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($29.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<
          $29.GetTransferDetailsRequest, $29.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($29.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetTransferDetailsResponse.fromBuffer(value));
  static final _$initiateBatchTransfer = $grpc.ClientMethod<
          $29.InitiateBatchTransferRequest, $29.InitiateBatchTransferResponse>(
      '/pb.TransferService/InitiateBatchTransfer',
      ($29.InitiateBatchTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.InitiateBatchTransferResponse.fromBuffer(value));
  static final _$getBatchTransferStatus = $grpc.ClientMethod<
          $29.GetBatchTransferStatusRequest,
          $29.GetBatchTransferStatusResponse>(
      '/pb.TransferService/GetBatchTransferStatus',
      ($29.GetBatchTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetBatchTransferStatusResponse.fromBuffer(value));
  static final _$getBatchTransferHistory = $grpc.ClientMethod<
          $29.GetBatchTransferHistoryRequest,
          $29.GetBatchTransferHistoryResponse>(
      '/pb.TransferService/GetBatchTransferHistory',
      ($29.GetBatchTransferHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetBatchTransferHistoryResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$29.InitiateTransferResponse> initiateTransfer(
      $29.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$29.ListTransfersResponse> listTransfers(
      $29.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetStatisticsResponse> getStatistics(
      $29.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetTransferDetailsResponse> getTransferDetails(
      $29.GetTransferDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }

  $grpc.ResponseFuture<$29.InitiateBatchTransferResponse> initiateBatchTransfer(
      $29.InitiateBatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateBatchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetBatchTransferStatusResponse>
      getBatchTransferStatus($29.GetBatchTransferStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.GetBatchTransferHistoryResponse>
      getBatchTransferHistory($29.GetBatchTransferHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferHistory, request,
        options: options);
  }
}

abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$29.InitiateTransferRequest,
            $29.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.InitiateTransferRequest.fromBuffer(value),
        ($29.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.ListTransfersRequest,
            $29.ListTransfersResponse>(
        'ListTransfers',
        listTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.ListTransfersRequest.fromBuffer(value),
        ($29.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetStatisticsRequest,
            $29.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetStatisticsRequest.fromBuffer(value),
        ($29.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetTransferDetailsRequest,
            $29.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetTransferDetailsRequest.fromBuffer(value),
        ($29.GetTransferDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.InitiateBatchTransferRequest,
            $29.InitiateBatchTransferResponse>(
        'InitiateBatchTransfer',
        initiateBatchTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.InitiateBatchTransferRequest.fromBuffer(value),
        ($29.InitiateBatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetBatchTransferStatusRequest,
            $29.GetBatchTransferStatusResponse>(
        'GetBatchTransferStatus',
        getBatchTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetBatchTransferStatusRequest.fromBuffer(value),
        ($29.GetBatchTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetBatchTransferHistoryRequest,
            $29.GetBatchTransferHistoryResponse>(
        'GetBatchTransferHistory',
        getBatchTransferHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetBatchTransferHistoryRequest.fromBuffer(value),
        ($29.GetBatchTransferHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$29.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$29.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$29.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$29.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$29.InitiateBatchTransferResponse> initiateBatchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.InitiateBatchTransferRequest> request) async {
    return initiateBatchTransfer(call, await request);
  }

  $async.Future<$29.GetBatchTransferStatusResponse> getBatchTransferStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetBatchTransferStatusRequest> request) async {
    return getBatchTransferStatus(call, await request);
  }

  $async.Future<$29.GetBatchTransferHistoryResponse>
      getBatchTransferHistory_Pre($grpc.ServiceCall call,
          $async.Future<$29.GetBatchTransferHistoryRequest> request) async {
    return getBatchTransferHistory(call, await request);
  }

  $async.Future<$29.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $29.InitiateTransferRequest request);
  $async.Future<$29.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $29.ListTransfersRequest request);
  $async.Future<$29.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $29.GetStatisticsRequest request);
  $async.Future<$29.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $29.GetTransferDetailsRequest request);
  $async.Future<$29.InitiateBatchTransferResponse> initiateBatchTransfer(
      $grpc.ServiceCall call, $29.InitiateBatchTransferRequest request);
  $async.Future<$29.GetBatchTransferStatusResponse> getBatchTransferStatus(
      $grpc.ServiceCall call, $29.GetBatchTransferStatusRequest request);
  $async.Future<$29.GetBatchTransferHistoryResponse> getBatchTransferHistory(
      $grpc.ServiceCall call, $29.GetBatchTransferHistoryRequest request);
}
