///
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transfer.pb.dart' as $12;
export 'transfer.pb.dart';

class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<
          $12.InitiateTransferRequest, $12.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($12.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.InitiateTransferResponse.fromBuffer(value));
  static final _$getStatistics =
      $grpc.ClientMethod<$12.GetStatisticsRequest, $12.GetStatisticsResponse>(
          '/pb.TransferService/GetStatistics',
          ($12.GetStatisticsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransactions = $grpc.ClientMethod<
          $12.GetTransactionsRequest, $12.GetTransactionsResponse>(
      '/pb.TransferService/GetTransactions',
      ($12.GetTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetTransactionsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<
          $12.GetTransferDetailsRequest, $12.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($12.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetTransferDetailsResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$12.InitiateTransferResponse> initiateTransfer(
      $12.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetStatisticsResponse> getStatistics(
      $12.GetStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetTransactionsResponse> getTransactions(
      $12.GetTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetTransferDetailsResponse> getTransferDetails(
      $12.GetTransferDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }
}

abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$12.InitiateTransferRequest,
            $12.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.InitiateTransferRequest.fromBuffer(value),
        ($12.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetStatisticsRequest,
            $12.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetStatisticsRequest.fromBuffer(value),
        ($12.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetTransactionsRequest,
            $12.GetTransactionsResponse>(
        'GetTransactions',
        getTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetTransactionsRequest.fromBuffer(value),
        ($12.GetTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetTransferDetailsRequest,
            $12.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetTransferDetailsRequest.fromBuffer(value),
        ($12.GetTransferDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$12.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$12.GetStatisticsResponse> getStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetStatisticsRequest> request) async {
    return getStatistics(call, await request);
  }

  $async.Future<$12.GetTransactionsResponse> getTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetTransactionsRequest> request) async {
    return getTransactions(call, await request);
  }

  $async.Future<$12.GetTransferDetailsResponse> getTransferDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetTransferDetailsRequest> request) async {
    return getTransferDetails(call, await request);
  }

  $async.Future<$12.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $12.InitiateTransferRequest request);
  $async.Future<$12.GetStatisticsResponse> getStatistics(
      $grpc.ServiceCall call, $12.GetStatisticsRequest request);
  $async.Future<$12.GetTransactionsResponse> getTransactions(
      $grpc.ServiceCall call, $12.GetTransactionsRequest request);
  $async.Future<$12.GetTransferDetailsResponse> getTransferDetails(
      $grpc.ServiceCall call, $12.GetTransferDetailsRequest request);
}
