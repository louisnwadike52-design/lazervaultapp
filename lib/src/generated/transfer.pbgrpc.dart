///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transfer.pb.dart' as $21;
export 'transfer.pb.dart';

class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<
          $21.InitiateTransferRequest, $21.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($21.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.InitiateTransferResponse.fromBuffer(value));
  static final _$listTransfers =
      $grpc.ClientMethod<$21.ListTransfersRequest, $21.ListTransfersResponse>(
          '/pb.TransferService/ListTransfers',
          ($21.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.ListTransfersResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$21.GetStatisticsRequest, $21.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($21.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $21.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<
          $21.GetTransferDetailsRequest, $21.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($21.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetTransferDetailsResponse.fromBuffer(value));
  static final _$initiateBatchTransfer = $grpc.ClientMethod<
          $21.InitiateBatchTransferRequest, $21.InitiateBatchTransferResponse>(
      '/pb.TransferService/InitiateBatchTransfer',
      ($21.InitiateBatchTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.InitiateBatchTransferResponse.fromBuffer(value));
  static final _$getBatchTransferStatus = $grpc.ClientMethod<
          $21.GetBatchTransferStatusRequest,
          $21.GetBatchTransferStatusResponse>(
      '/pb.TransferService/GetBatchTransferStatus',
      ($21.GetBatchTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetBatchTransferStatusResponse.fromBuffer(value));
  static final _$getBatchTransferHistory = $grpc.ClientMethod<
          $21.GetBatchTransferHistoryRequest,
          $21.GetBatchTransferHistoryResponse>(
      '/pb.TransferService/GetBatchTransferHistory',
      ($21.GetBatchTransferHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetBatchTransferHistoryResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$21.InitiateTransferResponse> initiateTransfer(
      $21.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$21.ListTransfersResponse> listTransfers(
      $21.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetStatisticsResponse> getStatistics(
      $21.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetTransferDetailsResponse> getTransferDetails(
      $21.GetTransferDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }

  $grpc.ResponseFuture<$21.InitiateBatchTransferResponse> initiateBatchTransfer(
      $21.InitiateBatchTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateBatchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetBatchTransferStatusResponse>
      getBatchTransferStatus($21.GetBatchTransferStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.GetBatchTransferHistoryResponse>
      getBatchTransferHistory($21.GetBatchTransferHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferHistory, request,
        options: options);
  }
}

abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$21.InitiateTransferRequest,
            $21.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.InitiateTransferRequest.fromBuffer(value),
        ($21.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.ListTransfersRequest,
            $21.ListTransfersResponse>(
        'ListTransfers',
        listTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.ListTransfersRequest.fromBuffer(value),
        ($21.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetStatisticsRequest,
            $21.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetStatisticsRequest.fromBuffer(value),
        ($21.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetTransferDetailsRequest,
            $21.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetTransferDetailsRequest.fromBuffer(value),
        ($21.GetTransferDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.InitiateBatchTransferRequest,
            $21.InitiateBatchTransferResponse>(
        'InitiateBatchTransfer',
        initiateBatchTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.InitiateBatchTransferRequest.fromBuffer(value),
        ($21.InitiateBatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetBatchTransferStatusRequest,
            $21.GetBatchTransferStatusResponse>(
        'GetBatchTransferStatus',
        getBatchTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetBatchTransferStatusRequest.fromBuffer(value),
        ($21.GetBatchTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetBatchTransferHistoryRequest,
            $21.GetBatchTransferHistoryResponse>(
        'GetBatchTransferHistory',
        getBatchTransferHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetBatchTransferHistoryRequest.fromBuffer(value),
        ($21.GetBatchTransferHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$21.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$21.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$21.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$21.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$21.InitiateBatchTransferResponse> initiateBatchTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.InitiateBatchTransferRequest> request) async {
    return initiateBatchTransfer(call, await request);
  }

  $async.Future<$21.GetBatchTransferStatusResponse> getBatchTransferStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetBatchTransferStatusRequest> request) async {
    return getBatchTransferStatus(call, await request);
  }

  $async.Future<$21.GetBatchTransferHistoryResponse>
      getBatchTransferHistory_Pre($grpc.ServiceCall call,
          $async.Future<$21.GetBatchTransferHistoryRequest> request) async {
    return getBatchTransferHistory(call, await request);
  }

  $async.Future<$21.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $21.InitiateTransferRequest request);
  $async.Future<$21.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $21.ListTransfersRequest request);
  $async.Future<$21.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $21.GetStatisticsRequest request);
  $async.Future<$21.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $21.GetTransferDetailsRequest request);
  $async.Future<$21.InitiateBatchTransferResponse> initiateBatchTransfer(
      $grpc.ServiceCall call, $21.InitiateBatchTransferRequest request);
  $async.Future<$21.GetBatchTransferStatusResponse> getBatchTransferStatus(
      $grpc.ServiceCall call, $21.GetBatchTransferStatusRequest request);
  $async.Future<$21.GetBatchTransferHistoryResponse> getBatchTransferHistory(
      $grpc.ServiceCall call, $21.GetBatchTransferHistoryRequest request);
}
