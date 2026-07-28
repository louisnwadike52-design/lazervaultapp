// This is a generated file - do not edit.
//
// Generated from portfolio.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'portfolio.pb.dart' as $0;

export 'portfolio.pb.dart';

/// Portfolio Service
@$pb.GrpcServiceName('pb.PortfolioService')
class PortfolioServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  PortfolioServiceClient(super.channel, {super.options, super.interceptors});

  /// Get complete user portfolio with all assets
  $grpc.ResponseFuture<$0.GetCompletePortfolioResponse> getCompletePortfolio(
    $0.GetCompletePortfolioRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCompletePortfolio, request, options: options);
  }

  /// Get portfolio filtered by asset type
  $grpc.ResponseFuture<$0.GetPortfolioByAssetTypeResponse>
      getPortfolioByAssetType(
    $0.GetPortfolioByAssetTypeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPortfolioByAssetType, request,
        options: options);
  }

  /// Get portfolio value history
  $grpc.ResponseFuture<$0.GetPortfolioHistoryResponse> getPortfolioHistory(
    $0.GetPortfolioHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPortfolioHistory, request, options: options);
  }

  /// Get portfolio summary only (without asset details)
  $grpc.ResponseFuture<$0.GetPortfolioSummaryResponse> getPortfolioSummary(
    $0.GetPortfolioSummaryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPortfolioSummary, request, options: options);
  }

  // method descriptors

  static final _$getCompletePortfolio = $grpc.ClientMethod<
          $0.GetCompletePortfolioRequest, $0.GetCompletePortfolioResponse>(
      '/pb.PortfolioService/GetCompletePortfolio',
      ($0.GetCompletePortfolioRequest value) => value.writeToBuffer(),
      $0.GetCompletePortfolioResponse.fromBuffer);
  static final _$getPortfolioByAssetType = $grpc.ClientMethod<
          $0.GetPortfolioByAssetTypeRequest,
          $0.GetPortfolioByAssetTypeResponse>(
      '/pb.PortfolioService/GetPortfolioByAssetType',
      ($0.GetPortfolioByAssetTypeRequest value) => value.writeToBuffer(),
      $0.GetPortfolioByAssetTypeResponse.fromBuffer);
  static final _$getPortfolioHistory = $grpc.ClientMethod<
          $0.GetPortfolioHistoryRequest, $0.GetPortfolioHistoryResponse>(
      '/pb.PortfolioService/GetPortfolioHistory',
      ($0.GetPortfolioHistoryRequest value) => value.writeToBuffer(),
      $0.GetPortfolioHistoryResponse.fromBuffer);
  static final _$getPortfolioSummary = $grpc.ClientMethod<
          $0.GetPortfolioSummaryRequest, $0.GetPortfolioSummaryResponse>(
      '/pb.PortfolioService/GetPortfolioSummary',
      ($0.GetPortfolioSummaryRequest value) => value.writeToBuffer(),
      $0.GetPortfolioSummaryResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.PortfolioService')
abstract class PortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.PortfolioService';

  PortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetCompletePortfolioRequest,
            $0.GetCompletePortfolioResponse>(
        'GetCompletePortfolio',
        getCompletePortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCompletePortfolioRequest.fromBuffer(value),
        ($0.GetCompletePortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPortfolioByAssetTypeRequest,
            $0.GetPortfolioByAssetTypeResponse>(
        'GetPortfolioByAssetType',
        getPortfolioByAssetType_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPortfolioByAssetTypeRequest.fromBuffer(value),
        ($0.GetPortfolioByAssetTypeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPortfolioHistoryRequest,
            $0.GetPortfolioHistoryResponse>(
        'GetPortfolioHistory',
        getPortfolioHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPortfolioHistoryRequest.fromBuffer(value),
        ($0.GetPortfolioHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPortfolioSummaryRequest,
            $0.GetPortfolioSummaryResponse>(
        'GetPortfolioSummary',
        getPortfolioSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPortfolioSummaryRequest.fromBuffer(value),
        ($0.GetPortfolioSummaryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetCompletePortfolioResponse> getCompletePortfolio_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetCompletePortfolioRequest> $request) async {
    return getCompletePortfolio($call, await $request);
  }

  $async.Future<$0.GetCompletePortfolioResponse> getCompletePortfolio(
      $grpc.ServiceCall call, $0.GetCompletePortfolioRequest request);

  $async.Future<$0.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPortfolioByAssetTypeRequest> $request) async {
    return getPortfolioByAssetType($call, await $request);
  }

  $async.Future<$0.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType(
      $grpc.ServiceCall call, $0.GetPortfolioByAssetTypeRequest request);

  $async.Future<$0.GetPortfolioHistoryResponse> getPortfolioHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPortfolioHistoryRequest> $request) async {
    return getPortfolioHistory($call, await $request);
  }

  $async.Future<$0.GetPortfolioHistoryResponse> getPortfolioHistory(
      $grpc.ServiceCall call, $0.GetPortfolioHistoryRequest request);

  $async.Future<$0.GetPortfolioSummaryResponse> getPortfolioSummary_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPortfolioSummaryRequest> $request) async {
    return getPortfolioSummary($call, await $request);
  }

  $async.Future<$0.GetPortfolioSummaryResponse> getPortfolioSummary(
      $grpc.ServiceCall call, $0.GetPortfolioSummaryRequest request);
}
