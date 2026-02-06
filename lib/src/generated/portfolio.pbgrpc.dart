//
//  Generated code. Do not modify.
//  source: portfolio.proto
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

import 'portfolio.pb.dart' as $27;

export 'portfolio.pb.dart';

@$pb.GrpcServiceName('pb.PortfolioService')
class PortfolioServiceClient extends $grpc.Client {
  static final _$getCompletePortfolio = $grpc.ClientMethod<$27.GetCompletePortfolioRequest, $27.GetCompletePortfolioResponse>(
      '/pb.PortfolioService/GetCompletePortfolio',
      ($27.GetCompletePortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $27.GetCompletePortfolioResponse.fromBuffer(value));
  static final _$getPortfolioByAssetType = $grpc.ClientMethod<$27.GetPortfolioByAssetTypeRequest, $27.GetPortfolioByAssetTypeResponse>(
      '/pb.PortfolioService/GetPortfolioByAssetType',
      ($27.GetPortfolioByAssetTypeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $27.GetPortfolioByAssetTypeResponse.fromBuffer(value));
  static final _$getPortfolioHistory = $grpc.ClientMethod<$27.GetPortfolioHistoryRequest, $27.GetPortfolioHistoryResponse>(
      '/pb.PortfolioService/GetPortfolioHistory',
      ($27.GetPortfolioHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $27.GetPortfolioHistoryResponse.fromBuffer(value));
  static final _$getPortfolioSummary = $grpc.ClientMethod<$27.GetPortfolioSummaryRequest, $27.GetPortfolioSummaryResponse>(
      '/pb.PortfolioService/GetPortfolioSummary',
      ($27.GetPortfolioSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $27.GetPortfolioSummaryResponse.fromBuffer(value));

  PortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$27.GetCompletePortfolioResponse> getCompletePortfolio($27.GetCompletePortfolioRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCompletePortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType($27.GetPortfolioByAssetTypeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioByAssetType, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetPortfolioHistoryResponse> getPortfolioHistory($27.GetPortfolioHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHistory, request, options: options);
  }

  $grpc.ResponseFuture<$27.GetPortfolioSummaryResponse> getPortfolioSummary($27.GetPortfolioSummaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioSummary, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.PortfolioService')
abstract class PortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.PortfolioService';

  PortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$27.GetCompletePortfolioRequest, $27.GetCompletePortfolioResponse>(
        'GetCompletePortfolio',
        getCompletePortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $27.GetCompletePortfolioRequest.fromBuffer(value),
        ($27.GetCompletePortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetPortfolioByAssetTypeRequest, $27.GetPortfolioByAssetTypeResponse>(
        'GetPortfolioByAssetType',
        getPortfolioByAssetType_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $27.GetPortfolioByAssetTypeRequest.fromBuffer(value),
        ($27.GetPortfolioByAssetTypeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetPortfolioHistoryRequest, $27.GetPortfolioHistoryResponse>(
        'GetPortfolioHistory',
        getPortfolioHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $27.GetPortfolioHistoryRequest.fromBuffer(value),
        ($27.GetPortfolioHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$27.GetPortfolioSummaryRequest, $27.GetPortfolioSummaryResponse>(
        'GetPortfolioSummary',
        getPortfolioSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $27.GetPortfolioSummaryRequest.fromBuffer(value),
        ($27.GetPortfolioSummaryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$27.GetCompletePortfolioResponse> getCompletePortfolio_Pre($grpc.ServiceCall call, $async.Future<$27.GetCompletePortfolioRequest> request) async {
    return getCompletePortfolio(call, await request);
  }

  $async.Future<$27.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType_Pre($grpc.ServiceCall call, $async.Future<$27.GetPortfolioByAssetTypeRequest> request) async {
    return getPortfolioByAssetType(call, await request);
  }

  $async.Future<$27.GetPortfolioHistoryResponse> getPortfolioHistory_Pre($grpc.ServiceCall call, $async.Future<$27.GetPortfolioHistoryRequest> request) async {
    return getPortfolioHistory(call, await request);
  }

  $async.Future<$27.GetPortfolioSummaryResponse> getPortfolioSummary_Pre($grpc.ServiceCall call, $async.Future<$27.GetPortfolioSummaryRequest> request) async {
    return getPortfolioSummary(call, await request);
  }

  $async.Future<$27.GetCompletePortfolioResponse> getCompletePortfolio($grpc.ServiceCall call, $27.GetCompletePortfolioRequest request);
  $async.Future<$27.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType($grpc.ServiceCall call, $27.GetPortfolioByAssetTypeRequest request);
  $async.Future<$27.GetPortfolioHistoryResponse> getPortfolioHistory($grpc.ServiceCall call, $27.GetPortfolioHistoryRequest request);
  $async.Future<$27.GetPortfolioSummaryResponse> getPortfolioSummary($grpc.ServiceCall call, $27.GetPortfolioSummaryRequest request);
}
