///
//  Generated code. Do not modify.
//  source: portfolio.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'portfolio.pb.dart' as $21;
export 'portfolio.pb.dart';

class PortfolioServiceClient extends $grpc.Client {
  static final _$getCompletePortfolio = $grpc.ClientMethod<
          $21.GetCompletePortfolioRequest, $21.GetCompletePortfolioResponse>(
      '/pb.PortfolioService/GetCompletePortfolio',
      ($21.GetCompletePortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetCompletePortfolioResponse.fromBuffer(value));
  static final _$getPortfolioByAssetType = $grpc.ClientMethod<
          $21.GetPortfolioByAssetTypeRequest,
          $21.GetPortfolioByAssetTypeResponse>(
      '/pb.PortfolioService/GetPortfolioByAssetType',
      ($21.GetPortfolioByAssetTypeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetPortfolioByAssetTypeResponse.fromBuffer(value));
  static final _$getPortfolioHistory = $grpc.ClientMethod<
          $21.GetPortfolioHistoryRequest, $21.GetPortfolioHistoryResponse>(
      '/pb.PortfolioService/GetPortfolioHistory',
      ($21.GetPortfolioHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetPortfolioHistoryResponse.fromBuffer(value));
  static final _$getPortfolioSummary = $grpc.ClientMethod<
          $21.GetPortfolioSummaryRequest, $21.GetPortfolioSummaryResponse>(
      '/pb.PortfolioService/GetPortfolioSummary',
      ($21.GetPortfolioSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetPortfolioSummaryResponse.fromBuffer(value));

  PortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$21.GetCompletePortfolioResponse> getCompletePortfolio(
      $21.GetCompletePortfolioRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCompletePortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetPortfolioByAssetTypeResponse>
      getPortfolioByAssetType($21.GetPortfolioByAssetTypeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioByAssetType, request,
        options: options);
  }

  $grpc.ResponseFuture<$21.GetPortfolioHistoryResponse> getPortfolioHistory(
      $21.GetPortfolioHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHistory, request, options: options);
  }

  $grpc.ResponseFuture<$21.GetPortfolioSummaryResponse> getPortfolioSummary(
      $21.GetPortfolioSummaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioSummary, request, options: options);
  }
}

abstract class PortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.PortfolioService';

  PortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$21.GetCompletePortfolioRequest,
            $21.GetCompletePortfolioResponse>(
        'GetCompletePortfolio',
        getCompletePortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetCompletePortfolioRequest.fromBuffer(value),
        ($21.GetCompletePortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetPortfolioByAssetTypeRequest,
            $21.GetPortfolioByAssetTypeResponse>(
        'GetPortfolioByAssetType',
        getPortfolioByAssetType_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetPortfolioByAssetTypeRequest.fromBuffer(value),
        ($21.GetPortfolioByAssetTypeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetPortfolioHistoryRequest,
            $21.GetPortfolioHistoryResponse>(
        'GetPortfolioHistory',
        getPortfolioHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetPortfolioHistoryRequest.fromBuffer(value),
        ($21.GetPortfolioHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$21.GetPortfolioSummaryRequest,
            $21.GetPortfolioSummaryResponse>(
        'GetPortfolioSummary',
        getPortfolioSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetPortfolioSummaryRequest.fromBuffer(value),
        ($21.GetPortfolioSummaryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$21.GetCompletePortfolioResponse> getCompletePortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetCompletePortfolioRequest> request) async {
    return getCompletePortfolio(call, await request);
  }

  $async.Future<$21.GetPortfolioByAssetTypeResponse>
      getPortfolioByAssetType_Pre($grpc.ServiceCall call,
          $async.Future<$21.GetPortfolioByAssetTypeRequest> request) async {
    return getPortfolioByAssetType(call, await request);
  }

  $async.Future<$21.GetPortfolioHistoryResponse> getPortfolioHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetPortfolioHistoryRequest> request) async {
    return getPortfolioHistory(call, await request);
  }

  $async.Future<$21.GetPortfolioSummaryResponse> getPortfolioSummary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetPortfolioSummaryRequest> request) async {
    return getPortfolioSummary(call, await request);
  }

  $async.Future<$21.GetCompletePortfolioResponse> getCompletePortfolio(
      $grpc.ServiceCall call, $21.GetCompletePortfolioRequest request);
  $async.Future<$21.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType(
      $grpc.ServiceCall call, $21.GetPortfolioByAssetTypeRequest request);
  $async.Future<$21.GetPortfolioHistoryResponse> getPortfolioHistory(
      $grpc.ServiceCall call, $21.GetPortfolioHistoryRequest request);
  $async.Future<$21.GetPortfolioSummaryResponse> getPortfolioSummary(
      $grpc.ServiceCall call, $21.GetPortfolioSummaryRequest request);
}
