//
//  Generated code. Do not modify.
//  source: transfer.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'transfer.pb.dart' as $11;

export 'transfer.pb.dart';

@$pb.GrpcServiceName('pb.TransferService')
class TransferServiceClient extends $grpc.Client {
  static final _$initiateTransfer = $grpc.ClientMethod<$11.InitiateTransferRequest, $11.InitiateTransferResponse>(
      '/pb.TransferService/InitiateTransfer',
      ($11.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.InitiateTransferResponse.fromBuffer(value));
  static final _$getStatistics = $grpc.ClientMethod<$11.GetStatisticsRequest, $11.GetStatisticsResponse>(
      '/pb.TransferService/GetStatistics',
      ($11.GetStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.GetStatisticsResponse.fromBuffer(value));
  static final _$getTransactions = $grpc.ClientMethod<$11.GetTransactionsRequest, $11.GetTransactionsResponse>(
      '/pb.TransferService/GetTransactions',
      ($11.GetTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.GetTransactionsResponse.fromBuffer(value));
  static final _$getTransferDetails = $grpc.ClientMethod<$11.GetTransferDetailsRequest, $11.GetTransferDetailsResponse>(
      '/pb.TransferService/GetTransferDetails',
      ($11.GetTransferDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $11.GetTransferDetailsResponse.fromBuffer(value));

  TransferServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$11.InitiateTransferResponse> initiateTransfer($11.InitiateTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetStatisticsResponse> getStatistics($11.GetStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetTransactionsResponse> getTransactions($11.GetTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetTransferDetailsResponse> getTransferDetails($11.GetTransferDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferDetails, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.TransferService')
abstract class TransferServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransferService';

  TransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$11.InitiateTransferRequest, $11.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.InitiateTransferRequest.fromBuffer(value),
        ($11.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetStatisticsRequest, $11.GetStatisticsResponse>(
        'GetStatistics',
        getStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.GetStatisticsRequest.fromBuffer(value),
        ($11.GetStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetTransactionsRequest, $11.GetTransactionsResponse>(
        'GetTransactions',
        getTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.GetTransactionsRequest.fromBuffer(value),
        ($11.GetTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetTransferDetailsRequest, $11.GetTransferDetailsResponse>(
        'GetTransferDetails',
        getTransferDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $11.GetTransferDetailsRequest.fromBuffer(value),
        ($11.GetTransferDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$11.InitiateTransferResponse> initiateTransfer_Pre($grpc.ServiceCall $call, $async.Future<$11.InitiateTransferRequest> $request) async {
    return initiateTransfer($call, await $request);
  }

  $async.Future<$11.GetStatisticsResponse> getStatistics_Pre($grpc.ServiceCall $call, $async.Future<$11.GetStatisticsRequest> $request) async {
    return getStatistics($call, await $request);
  }

  $async.Future<$11.GetTransactionsResponse> getTransactions_Pre($grpc.ServiceCall $call, $async.Future<$11.GetTransactionsRequest> $request) async {
    return getTransactions($call, await $request);
  }

  $async.Future<$11.GetTransferDetailsResponse> getTransferDetails_Pre($grpc.ServiceCall $call, $async.Future<$11.GetTransferDetailsRequest> $request) async {
    return getTransferDetails($call, await $request);
  }

  $async.Future<$11.InitiateTransferResponse> initiateTransfer($grpc.ServiceCall call, $11.InitiateTransferRequest request);
  $async.Future<$11.GetStatisticsResponse> getStatistics($grpc.ServiceCall call, $11.GetStatisticsRequest request);
  $async.Future<$11.GetTransactionsResponse> getTransactions($grpc.ServiceCall call, $11.GetTransactionsRequest request);
  $async.Future<$11.GetTransferDetailsResponse> getTransferDetails($grpc.ServiceCall call, $11.GetTransferDetailsRequest request);
}
