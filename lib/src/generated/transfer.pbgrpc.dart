///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transfer.pb.dart' as $28;
export 'transfer.pb.dart';

class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<
          $28.InitiateTransferRequest, $28.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($28.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.InitiateTransferResponse.fromBuffer(value));
  static final _$listTransfers =
      $grpc.ClientMethod<$28.ListTransfersRequest, $28.ListTransfersResponse>(
          '/pb.TransferService/ListTransfers',
          ($28.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.ListTransfersResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$28.GetStatisticsRequest, $28.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($28.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $28.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<
          $28.GetTransferDetailsRequest, $28.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($28.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetTransferDetailsResponse.fromBuffer(value));
  static final _$initiateBatchTransfer = $grpc.ClientMethod<
          $28.InitiateBatchTransferRequest, $28.InitiateBatchTransferResponse>(
      '/pb.TransferService/InitiateBatchTransfer',
      ($28.InitiateBatchTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.InitiateBatchTransferResponse.fromBuffer(value));
  static final _$getBatchTransferStatus = $grpc.ClientMethod<
          $28.GetBatchTransferStatusRequest,
          $28.GetBatchTransferStatusResponse>(
      '/pb.TransferService/GetBatchTransferStatus',
      ($28.GetBatchTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetBatchTransferStatusResponse.fromBuffer(value));
  static final _$getBatchTransferHistory = $grpc.ClientMethod<
          $28.GetBatchTransferHistoryRequest,
          $28.GetBatchTransferHistoryResponse>(
      '/pb.TransferService/GetBatchTransferHistory',
      ($28.GetBatchTransferHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $28.GetBatchTransferHistoryResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$28.InitiateTransferResponse> initiateTransfer(
      $28.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$28.ListTransfersResponse> listTransfers(
      $28.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetStatisticsResponse> getStatistics(
      $28.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetTransferDetailsResponse> getTransferDetails(
      $28.GetTransferDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }

  $grpc.ResponseFuture<$28.InitiateBatchTransferResponse> initiateBatchTransfer(
      $28.InitiateBatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateBatchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$28.GetBatchTransferStatusResponse>
      getBatchTransferStatus($28.GetBatchTransferStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$28.GetBatchTransferHistoryResponse>
      getBatchTransferHistory($28.GetBatchTransferHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferHistory, request,
        options: options);
  }
}

abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$28.InitiateTransferRequest,
            $28.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.InitiateTransferRequest.fromBuffer(value),
        ($28.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.ListTransfersRequest,
            $28.ListTransfersResponse>(
        'ListTransfers',
        listTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.ListTransfersRequest.fromBuffer(value),
        ($28.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetStatisticsRequest,
            $28.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetStatisticsRequest.fromBuffer(value),
        ($28.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetTransferDetailsRequest,
            $28.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetTransferDetailsRequest.fromBuffer(value),
        ($28.GetTransferDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.InitiateBatchTransferRequest,
            $28.InitiateBatchTransferResponse>(
        'InitiateBatchTransfer',
        initiateBatchTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.InitiateBatchTransferRequest.fromBuffer(value),
        ($28.InitiateBatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetBatchTransferStatusRequest,
            $28.GetBatchTransferStatusResponse>(
        'GetBatchTransferStatus',
        getBatchTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetBatchTransferStatusRequest.fromBuffer(value),
        ($28.GetBatchTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$28.GetBatchTransferHistoryRequest,
            $28.GetBatchTransferHistoryResponse>(
        'GetBatchTransferHistory',
        getBatchTransferHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $28.GetBatchTransferHistoryRequest.fromBuffer(value),
        ($28.GetBatchTransferHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$28.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$28.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$28.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$28.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$28.InitiateBatchTransferResponse> initiateBatchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.InitiateBatchTransferRequest> request) async {
    return initiateBatchTransfer(call, await request);
  }

  $async.Future<$28.GetBatchTransferStatusResponse> getBatchTransferStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$28.GetBatchTransferStatusRequest> request) async {
    return getBatchTransferStatus(call, await request);
  }

  $async.Future<$28.GetBatchTransferHistoryResponse>
      getBatchTransferHistory_Pre($grpc.ServiceCall call,
          $async.Future<$28.GetBatchTransferHistoryRequest> request) async {
    return getBatchTransferHistory(call, await request);
  }

  $async.Future<$28.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $28.InitiateTransferRequest request);
  $async.Future<$28.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $28.ListTransfersRequest request);
  $async.Future<$28.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $28.GetStatisticsRequest request);
  $async.Future<$28.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $28.GetTransferDetailsRequest request);
  $async.Future<$28.InitiateBatchTransferResponse> initiateBatchTransfer(
      $grpc.ServiceCall call, $28.InitiateBatchTransferRequest request);
  $async.Future<$28.GetBatchTransferStatusResponse> getBatchTransferStatus(
      $grpc.ServiceCall call, $28.GetBatchTransferStatusRequest request);
  $async.Future<$28.GetBatchTransferHistoryResponse> getBatchTransferHistory(
      $grpc.ServiceCall call, $28.GetBatchTransferHistoryRequest request);
}
