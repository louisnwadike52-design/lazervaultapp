///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transfer.pb.dart' as $40;
export 'transfer.pb.dart';

class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<
          $40.InitiateTransferRequest, $40.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($40.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $40.InitiateTransferResponse.fromBuffer(value));
  static final _$listTransfers =
      $grpc.ClientMethod<$40.ListTransfersRequest, $40.ListTransfersResponse>(
          '/pb.TransferService/ListTransfers',
          ($40.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $40.ListTransfersResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$40.GetStatisticsRequest, $40.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($40.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $40.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<
          $40.GetTransferDetailsRequest, $40.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($40.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $40.GetTransferDetailsResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$40.InitiateTransferResponse> initiateTransfer(
      $40.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$40.ListTransfersResponse> listTransfers(
      $40.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$40.GetStatisticsResponse> getStatistics(
      $40.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$40.GetTransferDetailsResponse> getTransferDetails(
      $40.GetTransferDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }
}

abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$40.InitiateTransferRequest,
            $40.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $40.InitiateTransferRequest.fromBuffer(value),
        ($40.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$40.ListTransfersRequest,
            $40.ListTransfersResponse>(
        'ListTransfers',
        listTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $40.ListTransfersRequest.fromBuffer(value),
        ($40.ListTransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$40.GetStatisticsRequest,
            $40.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $40.GetStatisticsRequest.fromBuffer(value),
        ($40.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$40.GetTransferDetailsRequest,
            $40.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $40.GetTransferDetailsRequest.fromBuffer(value),
        ($40.GetTransferDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$40.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$40.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$40.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$40.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$40.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$40.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$40.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$40.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$40.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $40.InitiateTransferRequest request);
  $async.Future<$40.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $40.ListTransfersRequest request);
  $async.Future<$40.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $40.GetStatisticsRequest request);
  $async.Future<$40.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $40.GetTransferDetailsRequest request);
}
