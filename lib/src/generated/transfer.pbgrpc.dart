///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transfer.pb.dart' as $23;
export 'transfer.pb.dart';

class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<
          $23.InitiateTransferRequest, $23.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($23.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.InitiateTransferResponse.fromBuffer(value));
  static final _$listTransfers =
      $grpc.ClientMethod<$23.ListTransfersRequest, $23.ListTransfersResponse>(
          '/pb.TransferService/ListTransfers',
          ($23.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.ListTransfersResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$23.GetStatisticsRequest, $23.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($23.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<
          $23.GetTransferDetailsRequest, $23.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($23.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetTransferDetailsResponse.fromBuffer(value));
  static final _$initiateBatchTransfer = $grpc.ClientMethod<
          $23.InitiateBatchTransferRequest, $23.InitiateBatchTransferResponse>(
      '/pb.TransferService/InitiateBatchTransfer',
      ($23.InitiateBatchTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.InitiateBatchTransferResponse.fromBuffer(value));
  static final _$getBatchTransferStatus = $grpc.ClientMethod<
          $23.GetBatchTransferStatusRequest,
          $23.GetBatchTransferStatusResponse>(
      '/pb.TransferService/GetBatchTransferStatus',
      ($23.GetBatchTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetBatchTransferStatusResponse.fromBuffer(value));
  static final _$getBatchTransferHistory = $grpc.ClientMethod<
          $23.GetBatchTransferHistoryRequest,
          $23.GetBatchTransferHistoryResponse>(
      '/pb.TransferService/GetBatchTransferHistory',
      ($23.GetBatchTransferHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetBatchTransferHistoryResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$23.InitiateTransferResponse> initiateTransfer(
      $23.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$23.ListTransfersResponse> listTransfers(
      $23.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetStatisticsResponse> getStatistics(
      $23.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetTransferDetailsResponse> getTransferDetails(
      $23.GetTransferDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }

  $grpc.ResponseFuture<$23.InitiateBatchTransferResponse> initiateBatchTransfer(
      $23.InitiateBatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateBatchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetBatchTransferStatusResponse>
      getBatchTransferStatus($23.GetBatchTransferStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetBatchTransferHistoryResponse>
      getBatchTransferHistory($23.GetBatchTransferHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferHistory, request,
        options: options);
  }
}

abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$23.InitiateTransferRequest,
            $23.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.InitiateTransferRequest.fromBuffer(value),
        ($23.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ListTransfersRequest,
            $23.ListTransfersResponse>(
        'ListTransfers',
        listTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.ListTransfersRequest.fromBuffer(value),
        ($23.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetStatisticsRequest,
            $23.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetStatisticsRequest.fromBuffer(value),
        ($23.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetTransferDetailsRequest,
            $23.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetTransferDetailsRequest.fromBuffer(value),
        ($23.GetTransferDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.InitiateBatchTransferRequest,
            $23.InitiateBatchTransferResponse>(
        'InitiateBatchTransfer',
        initiateBatchTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.InitiateBatchTransferRequest.fromBuffer(value),
        ($23.InitiateBatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetBatchTransferStatusRequest,
            $23.GetBatchTransferStatusResponse>(
        'GetBatchTransferStatus',
        getBatchTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetBatchTransferStatusRequest.fromBuffer(value),
        ($23.GetBatchTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetBatchTransferHistoryRequest,
            $23.GetBatchTransferHistoryResponse>(
        'GetBatchTransferHistory',
        getBatchTransferHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetBatchTransferHistoryRequest.fromBuffer(value),
        ($23.GetBatchTransferHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$23.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$23.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$23.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$23.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$23.InitiateBatchTransferResponse> initiateBatchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.InitiateBatchTransferRequest> request) async {
    return initiateBatchTransfer(call, await request);
  }

  $async.Future<$23.GetBatchTransferStatusResponse> getBatchTransferStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetBatchTransferStatusRequest> request) async {
    return getBatchTransferStatus(call, await request);
  }

  $async.Future<$23.GetBatchTransferHistoryResponse>
      getBatchTransferHistory_Pre($grpc.ServiceCall call,
          $async.Future<$23.GetBatchTransferHistoryRequest> request) async {
    return getBatchTransferHistory(call, await request);
  }

  $async.Future<$23.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $23.InitiateTransferRequest request);
  $async.Future<$23.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $23.ListTransfersRequest request);
  $async.Future<$23.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $23.GetStatisticsRequest request);
  $async.Future<$23.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $23.GetTransferDetailsRequest request);
  $async.Future<$23.InitiateBatchTransferResponse> initiateBatchTransfer(
      $grpc.ServiceCall call, $23.InitiateBatchTransferRequest request);
  $async.Future<$23.GetBatchTransferStatusResponse> getBatchTransferStatus(
      $grpc.ServiceCall call, $23.GetBatchTransferStatusRequest request);
  $async.Future<$23.GetBatchTransferHistoryResponse> getBatchTransferHistory(
      $grpc.ServiceCall call, $23.GetBatchTransferHistoryRequest request);
}
