///
//  Generated code. Do not modify.
//  source: portfolio.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'portfolio.pb.dart' as $30;
export 'portfolio.pb.dart';

class PortfolioServiceClient extends $grpc.Client {
  static final _$getCompletePortfolio = $grpc.ClientMethod<
          $30.GetCompletePortfolioRequest, $30.GetCompletePortfolioResponse>(
      '/pb.PortfolioService/GetCompletePortfolio',
      ($30.GetCompletePortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.GetCompletePortfolioResponse.fromBuffer(value));
  static final _$getPortfolioByAssetType = $grpc.ClientMethod<
          $30.GetPortfolioByAssetTypeRequest,
          $30.GetPortfolioByAssetTypeResponse>(
      '/pb.PortfolioService/GetPortfolioByAssetType',
      ($30.GetPortfolioByAssetTypeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.GetPortfolioByAssetTypeResponse.fromBuffer(value));
  static final _$getPortfolioHistory = $grpc.ClientMethod<
          $30.GetPortfolioHistoryRequest, $30.GetPortfolioHistoryResponse>(
      '/pb.PortfolioService/GetPortfolioHistory',
      ($30.GetPortfolioHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.GetPortfolioHistoryResponse.fromBuffer(value));
  static final _$getPortfolioSummary = $grpc.ClientMethod<
          $30.GetPortfolioSummaryRequest, $30.GetPortfolioSummaryResponse>(
      '/pb.PortfolioService/GetPortfolioSummary',
      ($30.GetPortfolioSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $30.GetPortfolioSummaryResponse.fromBuffer(value));

  PortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$30.GetCompletePortfolioResponse> getCompletePortfolio(
      $30.GetCompletePortfolioRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCompletePortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetPortfolioByAssetTypeResponse>
      getPortfolioByAssetType($30.GetPortfolioByAssetTypeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioByAssetType, request,
        options: options);
  }

  $grpc.ResponseFuture<$30.GetPortfolioHistoryResponse> getPortfolioHistory(
      $30.GetPortfolioHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHistory, request, options: options);
  }

  $grpc.ResponseFuture<$30.GetPortfolioSummaryResponse> getPortfolioSummary(
      $30.GetPortfolioSummaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioSummary, request, options: options);
  }
}

abstract class PortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.PortfolioService';

  PortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$30.GetCompletePortfolioRequest,
            $30.GetCompletePortfolioResponse>(
        'GetCompletePortfolio',
        getCompletePortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetCompletePortfolioRequest.fromBuffer(value),
        ($30.GetCompletePortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetPortfolioByAssetTypeRequest,
            $30.GetPortfolioByAssetTypeResponse>(
        'GetPortfolioByAssetType',
        getPortfolioByAssetType_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetPortfolioByAssetTypeRequest.fromBuffer(value),
        ($30.GetPortfolioByAssetTypeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetPortfolioHistoryRequest,
            $30.GetPortfolioHistoryResponse>(
        'GetPortfolioHistory',
        getPortfolioHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetPortfolioHistoryRequest.fromBuffer(value),
        ($30.GetPortfolioHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$30.GetPortfolioSummaryRequest,
            $30.GetPortfolioSummaryResponse>(
        'GetPortfolioSummary',
        getPortfolioSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $30.GetPortfolioSummaryRequest.fromBuffer(value),
        ($30.GetPortfolioSummaryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$30.GetCompletePortfolioResponse> getCompletePortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetCompletePortfolioRequest> request) async {
    return getCompletePortfolio(call, await request);
  }

  $async.Future<$30.GetPortfolioByAssetTypeResponse>
      getPortfolioByAssetType_Pre($grpc.ServiceCall call,
          $async.Future<$30.GetPortfolioByAssetTypeRequest> request) async {
    return getPortfolioByAssetType(call, await request);
  }

  $async.Future<$30.GetPortfolioHistoryResponse> getPortfolioHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetPortfolioHistoryRequest> request) async {
    return getPortfolioHistory(call, await request);
  }

  $async.Future<$30.GetPortfolioSummaryResponse> getPortfolioSummary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$30.GetPortfolioSummaryRequest> request) async {
    return getPortfolioSummary(call, await request);
  }

  $async.Future<$30.GetCompletePortfolioResponse> getCompletePortfolio(
      $grpc.ServiceCall call, $30.GetCompletePortfolioRequest request);
  $async.Future<$30.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType(
      $grpc.ServiceCall call, $30.GetPortfolioByAssetTypeRequest request);
  $async.Future<$30.GetPortfolioHistoryResponse> getPortfolioHistory(
      $grpc.ServiceCall call, $30.GetPortfolioHistoryRequest request);
  $async.Future<$30.GetPortfolioSummaryResponse> getPortfolioSummary(
      $grpc.ServiceCall call, $30.GetPortfolioSummaryRequest request);
}
