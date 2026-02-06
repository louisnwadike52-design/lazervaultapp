//
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'transfer.pb.dart' as $35;

export 'transfer.pb.dart';

@$pb.GrpcServiceName('pb.TransferService')
class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<$35.InitiateTransferRequest, $35.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($35.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $35.InitiateTransferResponse.fromBuffer(value));
  static final _$listTransfers = $grpc.ClientMethod<$35.ListTransfersRequest, $35.ListTransfersResponse>(
      '/pb.TransferService/ListTransfers',
      ($35.ListTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $35.ListTransfersResponse.fromBuffer(value));
  static final _$getStatistics = $grpc.ClientMethod<$35.GetStatisticsRequest, $35.GetStatisticsResponse>(
      '/pb.TransferService/GetStatistics',
      ($35.GetStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $35.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<$35.GetTransferDetailsRequest, $35.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($35.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $35.GetTransferDetailsResponse.fromBuffer(value));
  static final _$initiateBatchTransfer = $grpc.ClientMethod<$35.InitiateBatchTransferRequest, $35.InitiateBatchTransferResponse>(
      '/pb.TransferService/InitiateBatchTransfer',
      ($35.InitiateBatchTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $35.InitiateBatchTransferResponse.fromBuffer(value));
  static final _$getBatchTransferStatus = $grpc.ClientMethod<$35.GetBatchTransferStatusRequest, $35.GetBatchTransferStatusResponse>(
      '/pb.TransferService/GetBatchTransferStatus',
      ($35.GetBatchTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $35.GetBatchTransferStatusResponse.fromBuffer(value));
  static final _$getBatchTransferHistory = $grpc.ClientMethod<$35.GetBatchTransferHistoryRequest, $35.GetBatchTransferHistoryResponse>(
      '/pb.TransferService/GetBatchTransferHistory',
      ($35.GetBatchTransferHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $35.GetBatchTransferHistoryResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$35.InitiateTransferResponse> initiateTransfer($35.InitiateTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$35.ListTransfersResponse> listTransfers($35.ListTransfersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetStatisticsResponse> getStatistics($35.GetStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetTransferDetailsResponse> getTransferDetails($35.GetTransferDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }

  $grpc.ResponseFuture<$35.InitiateBatchTransferResponse> initiateBatchTransfer($35.InitiateBatchTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateBatchTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetBatchTransferStatusResponse> getBatchTransferStatus($35.GetBatchTransferStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferStatus, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetBatchTransferHistoryResponse> getBatchTransferHistory($35.GetBatchTransferHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBatchTransferHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.TransferService')
abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$35.InitiateTransferRequest, $35.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.InitiateTransferRequest.fromBuffer(value),
        ($35.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.ListTransfersRequest, $35.ListTransfersResponse>(
        'ListTransfers',
        listTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.ListTransfersRequest.fromBuffer(value),
        ($35.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetStatisticsRequest, $35.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.GetStatisticsRequest.fromBuffer(value),
        ($35.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTransferDetailsRequest, $35.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.GetTransferDetailsRequest.fromBuffer(value),
        ($35.GetTransferDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.InitiateBatchTransferRequest, $35.InitiateBatchTransferResponse>(
        'InitiateBatchTransfer',
        initiateBatchTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.InitiateBatchTransferRequest.fromBuffer(value),
        ($35.InitiateBatchTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetBatchTransferStatusRequest, $35.GetBatchTransferStatusResponse>(
        'GetBatchTransferStatus',
        getBatchTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.GetBatchTransferStatusRequest.fromBuffer(value),
        ($35.GetBatchTransferStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetBatchTransferHistoryRequest, $35.GetBatchTransferHistoryResponse>(
        'GetBatchTransferHistory',
        getBatchTransferHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.GetBatchTransferHistoryRequest.fromBuffer(value),
        ($35.GetBatchTransferHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$35.InitiateTransferResponse> initiateTransfer_Pre($grpc.ServiceCall call, $async.Future<$35.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$35.ListTransfersResponse> listTransfers_Pre($grpc.ServiceCall call, $async.Future<$35.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$35.GetStatisticsResponse> getStatistics_Pre($grpc.ServiceCall call, $async.Future<$35.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$35.GetTransferDetailsResponse> getTransferDetails_Pre($grpc.ServiceCall call, $async.Future<$35.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$35.InitiateBatchTransferResponse> initiateBatchTransfer_Pre($grpc.ServiceCall call, $async.Future<$35.InitiateBatchTransferRequest> request) async {
    return initiateBatchTransfer(call, await request);
  }

  $async.Future<$35.GetBatchTransferStatusResponse> getBatchTransferStatus_Pre($grpc.ServiceCall call, $async.Future<$35.GetBatchTransferStatusRequest> request) async {
    return getBatchTransferStatus(call, await request);
  }

  $async.Future<$35.GetBatchTransferHistoryResponse> getBatchTransferHistory_Pre($grpc.ServiceCall call, $async.Future<$35.GetBatchTransferHistoryRequest> request) async {
    return getBatchTransferHistory(call, await request);
  }

  $async.Future<$35.InitiateTransferResponse> initiateTransfer($grpc.ServiceCall call, $35.InitiateTransferRequest request);
  $async.Future<$35.ListTransfersResponse> listTransfers($grpc.ServiceCall call, $35.ListTransfersRequest request);
  $async.Future<$35.GetStatisticsResponse> getStatistics($grpc.ServiceCall call, $35.GetStatisticsRequest request);
  $async.Future<$35.GetTransferDetailsResponse> getTransferDetails($grpc.ServiceCall call, $35.GetTransferDetailsRequest request);
  $async.Future<$35.InitiateBatchTransferResponse> initiateBatchTransfer($grpc.ServiceCall call, $35.InitiateBatchTransferRequest request);
  $async.Future<$35.GetBatchTransferStatusResponse> getBatchTransferStatus($grpc.ServiceCall call, $35.GetBatchTransferStatusRequest request);
  $async.Future<$35.GetBatchTransferHistoryResponse> getBatchTransferHistory($grpc.ServiceCall call, $35.GetBatchTransferHistoryRequest request);
}
