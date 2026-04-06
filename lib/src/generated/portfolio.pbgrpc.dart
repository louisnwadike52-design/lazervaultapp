///
//  Generated code. Do not modify.
//  source: portfolio.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'portfolio.pb.dart' as $29;
export 'portfolio.pb.dart';

class PortfolioServiceClient extends $grpc.Client {
  static final _$getCompletePortfolio = $grpc.ClientMethod<
          $29.GetCompletePortfolioRequest, $29.GetCompletePortfolioResponse>(
      '/pb.PortfolioService/GetCompletePortfolio',
      ($29.GetCompletePortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetCompletePortfolioResponse.fromBuffer(value));
  static final _$getPortfolioByAssetType = $grpc.ClientMethod<
          $29.GetPortfolioByAssetTypeRequest,
          $29.GetPortfolioByAssetTypeResponse>(
      '/pb.PortfolioService/GetPortfolioByAssetType',
      ($29.GetPortfolioByAssetTypeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetPortfolioByAssetTypeResponse.fromBuffer(value));
  static final _$getPortfolioHistory = $grpc.ClientMethod<
          $29.GetPortfolioHistoryRequest, $29.GetPortfolioHistoryResponse>(
      '/pb.PortfolioService/GetPortfolioHistory',
      ($29.GetPortfolioHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetPortfolioHistoryResponse.fromBuffer(value));
  static final _$getPortfolioSummary = $grpc.ClientMethod<
          $29.GetPortfolioSummaryRequest, $29.GetPortfolioSummaryResponse>(
      '/pb.PortfolioService/GetPortfolioSummary',
      ($29.GetPortfolioSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $29.GetPortfolioSummaryResponse.fromBuffer(value));

  PortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$29.GetCompletePortfolioResponse> getCompletePortfolio(
      $29.GetCompletePortfolioRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCompletePortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetPortfolioByAssetTypeResponse>
      getPortfolioByAssetType($29.GetPortfolioByAssetTypeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioByAssetType, request,
        options: options);
  }

  $grpc.ResponseFuture<$29.GetPortfolioHistoryResponse> getPortfolioHistory(
      $29.GetPortfolioHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHistory, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetPortfolioSummaryResponse> getPortfolioSummary(
      $29.GetPortfolioSummaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioSummary, request, options: options);
  }
}

abstract class PortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.PortfolioService';

  PortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$29.GetCompletePortfolioRequest,
            $29.GetCompletePortfolioResponse>(
        'GetCompletePortfolio',
        getCompletePortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetCompletePortfolioRequest.fromBuffer(value),
        ($29.GetCompletePortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetPortfolioByAssetTypeRequest,
            $29.GetPortfolioByAssetTypeResponse>(
        'GetPortfolioByAssetType',
        getPortfolioByAssetType_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetPortfolioByAssetTypeRequest.fromBuffer(value),
        ($29.GetPortfolioByAssetTypeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetPortfolioHistoryRequest,
            $29.GetPortfolioHistoryResponse>(
        'GetPortfolioHistory',
        getPortfolioHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetPortfolioHistoryRequest.fromBuffer(value),
        ($29.GetPortfolioHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetPortfolioSummaryRequest,
            $29.GetPortfolioSummaryResponse>(
        'GetPortfolioSummary',
        getPortfolioSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.GetPortfolioSummaryRequest.fromBuffer(value),
        ($29.GetPortfolioSummaryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$29.GetCompletePortfolioResponse> getCompletePortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetCompletePortfolioRequest> request) async {
    return getCompletePortfolio(call, await request);
  }

  $async.Future<$29.GetPortfolioByAssetTypeResponse>
      getPortfolioByAssetType_Pre($grpc.ServiceCall call,
          $async.Future<$29.GetPortfolioByAssetTypeRequest> request) async {
    return getPortfolioByAssetType(call, await request);
  }

  $async.Future<$29.GetPortfolioHistoryResponse> getPortfolioHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetPortfolioHistoryRequest> request) async {
    return getPortfolioHistory(call, await request);
  }

  $async.Future<$29.GetPortfolioSummaryResponse> getPortfolioSummary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetPortfolioSummaryRequest> request) async {
    return getPortfolioSummary(call, await request);
  }

  $async.Future<$29.GetCompletePortfolioResponse> getCompletePortfolio(
      $grpc.ServiceCall call, $29.GetCompletePortfolioRequest request);
  $async.Future<$29.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType(
      $grpc.ServiceCall call, $29.GetPortfolioByAssetTypeRequest request);
  $async.Future<$29.GetPortfolioHistoryResponse> getPortfolioHistory(
      $grpc.ServiceCall call, $29.GetPortfolioHistoryRequest request);
  $async.Future<$29.GetPortfolioSummaryResponse> getPortfolioSummary(
      $grpc.ServiceCall call, $29.GetPortfolioSummaryRequest request);
}
