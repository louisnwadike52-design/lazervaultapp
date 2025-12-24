///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transfer.pb.dart' as $20;
export 'transfer.pb.dart';

class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<
          $20.InitiateTransferRequest, $20.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($20.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.InitiateTransferResponse.fromBuffer(value));
  static final _$listTransfers =
      $grpc.ClientMethod<$20.ListTransfersRequest, $20.ListTransfersResponse>(
          '/pb.TransferService/ListTransfers',
          ($20.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.ListTransfersResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$20.GetStatisticsRequest, $20.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($20.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<
          $20.GetTransferDetailsRequest, $20.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($20.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetTransferDetailsResponse.fromBuffer(value));
  static final _$initiateBatchTransfer = $grpc.ClientMethod<
          $20.InitiateBatchTransferRequest, $20.InitiateBatchTransferResponse>(
      '/pb.TransferService/InitiateBatchTransfer',
      ($20.InitiateBatchTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.InitiateBatchTransferResponse.fromBuffer(value));
  static final _$getBatchTransferStatus = $grpc.ClientMethod<
          $20.GetBatchTransferStatusRequest,
          $20.GetBatchTransferStatusResponse>(
      '/pb.TransferService/GetBatchTransferStatus',
      ($20.GetBatchTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetBatchTransferStatusResponse.fromBuffer(value));
  static final _$getBatchTransferHistory = $grpc.ClientMethod<
          $20.GetBatchTransferHistoryRequest,
          $20.GetBatchTransferHistoryResponse>(
      '/pb.TransferService/GetBatchTransferHistory',
      ($20.GetBatchTransferHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $20.GetBatchTransferHistoryResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$20.InitiateTransferResponse> initiateTransfer(
      $20.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$20.ListTransfersResponse> listTransfers(
      $20.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetStatisticsResponse> getStatistics(
      $20.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetTransferDetailsResponse> getTransferDetails(
      $20.GetTransferDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }

  $grpc.ResponseFuture<$20.InitiateBatchTransferResponse> initiateBatchTransfer(
      $20.InitiateBatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateBatchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$20.GetBatchTransferStatusResponse>
      getBatchTransferStatus($20.GetBatchTransferStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$20.GetBatchTransferHistoryResponse>
      getBatchTransferHistory($20.GetBatchTransferHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferHistory, request,
        options: options);
  }
}

abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$20.InitiateTransferRequest,
            $20.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.InitiateTransferRequest.fromBuffer(value),
        ($20.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.ListTransfersRequest,
            $20.ListTransfersResponse>(
        'ListTransfers',
        listTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.ListTransfersRequest.fromBuffer(value),
        ($20.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetStatisticsRequest,
            $20.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetStatisticsRequest.fromBuffer(value),
        ($20.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetTransferDetailsRequest,
            $20.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetTransferDetailsRequest.fromBuffer(value),
        ($20.GetTransferDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.InitiateBatchTransferRequest,
            $20.InitiateBatchTransferResponse>(
        'InitiateBatchTransfer',
        initiateBatchTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.InitiateBatchTransferRequest.fromBuffer(value),
        ($20.InitiateBatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetBatchTransferStatusRequest,
            $20.GetBatchTransferStatusResponse>(
        'GetBatchTransferStatus',
        getBatchTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetBatchTransferStatusRequest.fromBuffer(value),
        ($20.GetBatchTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetBatchTransferHistoryRequest,
            $20.GetBatchTransferHistoryResponse>(
        'GetBatchTransferHistory',
        getBatchTransferHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetBatchTransferHistoryRequest.fromBuffer(value),
        ($20.GetBatchTransferHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$20.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$20.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$20.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$20.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$20.InitiateBatchTransferResponse> initiateBatchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.InitiateBatchTransferRequest> request) async {
    return initiateBatchTransfer(call, await request);
  }

  $async.Future<$20.GetBatchTransferStatusResponse> getBatchTransferStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.GetBatchTransferStatusRequest> request) async {
    return getBatchTransferStatus(call, await request);
  }

  $async.Future<$20.GetBatchTransferHistoryResponse>
      getBatchTransferHistory_Pre($grpc.ServiceCall call,
          $async.Future<$20.GetBatchTransferHistoryRequest> request) async {
    return getBatchTransferHistory(call, await request);
  }

  $async.Future<$20.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $20.InitiateTransferRequest request);
  $async.Future<$20.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $20.ListTransfersRequest request);
  $async.Future<$20.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $20.GetStatisticsRequest request);
  $async.Future<$20.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $20.GetTransferDetailsRequest request);
  $async.Future<$20.InitiateBatchTransferResponse> initiateBatchTransfer(
      $grpc.ServiceCall call, $20.InitiateBatchTransferRequest request);
  $async.Future<$20.GetBatchTransferStatusResponse> getBatchTransferStatus(
      $grpc.ServiceCall call, $20.GetBatchTransferStatusRequest request);
  $async.Future<$20.GetBatchTransferHistoryResponse> getBatchTransferHistory(
      $grpc.ServiceCall call, $20.GetBatchTransferHistoryRequest request);
}
