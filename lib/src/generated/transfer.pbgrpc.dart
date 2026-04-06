///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transfer.pb.dart' as $39;
export 'transfer.pb.dart';

class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<
          $39.InitiateTransferRequest, $39.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($39.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.InitiateTransferResponse.fromBuffer(value));
  static final _$listTransfers =
      $grpc.ClientMethod<$39.ListTransfersRequest, $39.ListTransfersResponse>(
          '/pb.TransferService/ListTransfers',
          ($39.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $39.ListTransfersResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$39.GetStatisticsRequest, $39.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($39.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $39.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<
          $39.GetTransferDetailsRequest, $39.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($39.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.GetTransferDetailsResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$39.InitiateTransferResponse> initiateTransfer(
      $39.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$39.ListTransfersResponse> listTransfers(
      $39.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$39.GetStatisticsResponse> getStatistics(
      $39.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$39.GetTransferDetailsResponse> getTransferDetails(
      $39.GetTransferDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }
}

abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$39.InitiateTransferRequest,
            $39.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.InitiateTransferRequest.fromBuffer(value),
        ($39.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.ListTransfersRequest,
            $39.ListTransfersResponse>(
        'ListTransfers',
        listTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.ListTransfersRequest.fromBuffer(value),
        ($39.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.GetStatisticsRequest,
            $39.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.GetStatisticsRequest.fromBuffer(value),
        ($39.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.GetTransferDetailsRequest,
            $39.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.GetTransferDetailsRequest.fromBuffer(value),
        ($39.GetTransferDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$39.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$39.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$39.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$39.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$39.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $39.InitiateTransferRequest request);
  $async.Future<$39.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $39.ListTransfersRequest request);
  $async.Future<$39.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $39.GetStatisticsRequest request);
  $async.Future<$39.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $39.GetTransferDetailsRequest request);
}
