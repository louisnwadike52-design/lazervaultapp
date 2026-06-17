///
//  Generated code. Do not modify.
//  source: stocks/stock.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'stock.pb.dart' as $48;
export 'stock.pb.dart';

class StockServiceClient extends $grpc.Client {
  static final _$getStocks =
      $grpc.ClientMethod<$48.GetStocksRequest, $48.GetStocksResponse>(
          '/stockspb.StockService/GetStocks',
          ($48.GetStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetStocksResponse.fromBuffer(value));
  static final _$getStock =
      $grpc.ClientMethod<$48.GetStockRequest, $48.GetStockResponse>(
          '/stockspb.StockService/GetStock',
          ($48.GetStockRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetStockResponse.fromBuffer(value));
  static final _$searchStocks =
      $grpc.ClientMethod<$48.SearchStocksRequest, $48.SearchStocksResponse>(
          '/stockspb.StockService/SearchStocks',
          ($48.SearchStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.SearchStocksResponse.fromBuffer(value));
  static final _$getStockPriceHistory = $grpc.ClientMethod<
          $48.GetStockPriceHistoryRequest, $48.GetStockPriceHistoryResponse>(
      '/stockspb.StockService/GetStockPriceHistory',
      ($48.GetStockPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetStockPriceHistoryResponse.fromBuffer(value));
  static final _$getMarketIndices = $grpc.ClientMethod<
          $48.GetMarketIndicesRequest, $48.GetMarketIndicesResponse>(
      '/stockspb.StockService/GetMarketIndices',
      ($48.GetMarketIndicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetMarketIndicesResponse.fromBuffer(value));
  static final _$getTrendingStocks = $grpc.ClientMethod<
          $48.GetTrendingStocksRequest, $48.GetTrendingStocksResponse>(
      '/stockspb.StockService/GetTrendingStocks',
      ($48.GetTrendingStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetTrendingStocksResponse.fromBuffer(value));
  static final _$getTopGainers =
      $grpc.ClientMethod<$48.GetTopGainersRequest, $48.GetTopGainersResponse>(
          '/stockspb.StockService/GetTopGainers',
          ($48.GetTopGainersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetTopGainersResponse.fromBuffer(value));
  static final _$getTopLosers =
      $grpc.ClientMethod<$48.GetTopLosersRequest, $48.GetTopLosersResponse>(
          '/stockspb.StockService/GetTopLosers',
          ($48.GetTopLosersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetTopLosersResponse.fromBuffer(value));
  static final _$getMarketStatus = $grpc.ClientMethod<
          $48.GetMarketStatusRequest, $48.GetMarketStatusResponse>(
      '/stockspb.StockService/GetMarketStatus',
      ($48.GetMarketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetMarketStatusResponse.fromBuffer(value));
  static final _$getMarketNews =
      $grpc.ClientMethod<$48.GetMarketNewsRequest, $48.GetMarketNewsResponse>(
          '/stockspb.StockService/GetMarketNews',
          ($48.GetMarketNewsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetMarketNewsResponse.fromBuffer(value));
  static final _$createPriceAlert = $grpc.ClientMethod<
          $48.CreatePriceAlertRequest, $48.CreatePriceAlertResponse>(
      '/stockspb.StockService/CreatePriceAlert',
      ($48.CreatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.CreatePriceAlertResponse.fromBuffer(value));
  static final _$getPriceAlerts =
      $grpc.ClientMethod<$48.GetPriceAlertsRequest, $48.GetPriceAlertsResponse>(
          '/stockspb.StockService/GetPriceAlerts',
          ($48.GetPriceAlertsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetPriceAlertsResponse.fromBuffer(value));
  static final _$updatePriceAlert = $grpc.ClientMethod<
          $48.UpdatePriceAlertRequest, $48.UpdatePriceAlertResponse>(
      '/stockspb.StockService/UpdatePriceAlert',
      ($48.UpdatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.UpdatePriceAlertResponse.fromBuffer(value));
  static final _$deletePriceAlert = $grpc.ClientMethod<
          $48.DeletePriceAlertRequest, $48.DeletePriceAlertResponse>(
      '/stockspb.StockService/DeletePriceAlert',
      ($48.DeletePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.DeletePriceAlertResponse.fromBuffer(value));

  StockServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$48.GetStocksResponse> getStocks(
      $48.GetStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStocks, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetStockResponse> getStock(
      $48.GetStockRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStock, request, options: options);
  }

  $grpc.ResponseFuture<$48.SearchStocksResponse> searchStocks(
      $48.SearchStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStocks, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetStockPriceHistoryResponse> getStockPriceHistory(
      $48.GetStockPriceHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetMarketIndicesResponse> getMarketIndices(
      $48.GetMarketIndicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketIndices, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetTrendingStocksResponse> getTrendingStocks(
      $48.GetTrendingStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingStocks, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetTopGainersResponse> getTopGainers(
      $48.GetTopGainersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopGainers, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetTopLosersResponse> getTopLosers(
      $48.GetTopLosersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopLosers, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetMarketStatusResponse> getMarketStatus(
      $48.GetMarketStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetMarketNewsResponse> getMarketNews(
      $48.GetMarketNewsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketNews, request, options: options);
  }

  $grpc.ResponseFuture<$48.CreatePriceAlertResponse> createPriceAlert(
      $48.CreatePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetPriceAlertsResponse> getPriceAlerts(
      $48.GetPriceAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPriceAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$48.UpdatePriceAlertResponse> updatePriceAlert(
      $48.UpdatePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$48.DeletePriceAlertResponse> deletePriceAlert(
      $48.DeletePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePriceAlert, request, options: options);
  }
}

abstract class StockServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StockService';

  StockServiceBase() {
    $addMethod($grpc.ServiceMethod<$48.GetStocksRequest, $48.GetStocksResponse>(
        'GetStocks',
        getStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $48.GetStocksRequest.fromBuffer(value),
        ($48.GetStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetStockRequest, $48.GetStockResponse>(
        'GetStock',
        getStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $48.GetStockRequest.fromBuffer(value),
        ($48.GetStockResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$48.SearchStocksRequest, $48.SearchStocksResponse>(
            'SearchStocks',
            searchStocks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $48.SearchStocksRequest.fromBuffer(value),
            ($48.SearchStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetStockPriceHistoryRequest,
            $48.GetStockPriceHistoryResponse>(
        'GetStockPriceHistory',
        getStockPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetStockPriceHistoryRequest.fromBuffer(value),
        ($48.GetStockPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetMarketIndicesRequest,
            $48.GetMarketIndicesResponse>(
        'GetMarketIndices',
        getMarketIndices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetMarketIndicesRequest.fromBuffer(value),
        ($48.GetMarketIndicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetTrendingStocksRequest,
            $48.GetTrendingStocksResponse>(
        'GetTrendingStocks',
        getTrendingStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetTrendingStocksRequest.fromBuffer(value),
        ($48.GetTrendingStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetTopGainersRequest,
            $48.GetTopGainersResponse>(
        'GetTopGainers',
        getTopGainers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetTopGainersRequest.fromBuffer(value),
        ($48.GetTopGainersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$48.GetTopLosersRequest, $48.GetTopLosersResponse>(
            'GetTopLosers',
            getTopLosers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $48.GetTopLosersRequest.fromBuffer(value),
            ($48.GetTopLosersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetMarketStatusRequest,
            $48.GetMarketStatusResponse>(
        'GetMarketStatus',
        getMarketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetMarketStatusRequest.fromBuffer(value),
        ($48.GetMarketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetMarketNewsRequest,
            $48.GetMarketNewsResponse>(
        'GetMarketNews',
        getMarketNews_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetMarketNewsRequest.fromBuffer(value),
        ($48.GetMarketNewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.CreatePriceAlertRequest,
            $48.CreatePriceAlertResponse>(
        'CreatePriceAlert',
        createPriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.CreatePriceAlertRequest.fromBuffer(value),
        ($48.CreatePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetPriceAlertsRequest,
            $48.GetPriceAlertsResponse>(
        'GetPriceAlerts',
        getPriceAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetPriceAlertsRequest.fromBuffer(value),
        ($48.GetPriceAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.UpdatePriceAlertRequest,
            $48.UpdatePriceAlertResponse>(
        'UpdatePriceAlert',
        updatePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.UpdatePriceAlertRequest.fromBuffer(value),
        ($48.UpdatePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.DeletePriceAlertRequest,
            $48.DeletePriceAlertResponse>(
        'DeletePriceAlert',
        deletePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.DeletePriceAlertRequest.fromBuffer(value),
        ($48.DeletePriceAlertResponse value) => value.writeToBuffer()));
  }

  $async.Future<$48.GetStocksResponse> getStocks_Pre($grpc.ServiceCall call,
      $async.Future<$48.GetStocksRequest> request) async {
    return getStocks(call, await request);
  }

  $async.Future<$48.GetStockResponse> getStock_Pre($grpc.ServiceCall call,
      $async.Future<$48.GetStockRequest> request) async {
    return getStock(call, await request);
  }

  $async.Future<$48.SearchStocksResponse> searchStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.SearchStocksRequest> request) async {
    return searchStocks(call, await request);
  }

  $async.Future<$48.GetStockPriceHistoryResponse> getStockPriceHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetStockPriceHistoryRequest> request) async {
    return getStockPriceHistory(call, await request);
  }

  $async.Future<$48.GetMarketIndicesResponse> getMarketIndices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetMarketIndicesRequest> request) async {
    return getMarketIndices(call, await request);
  }

  $async.Future<$48.GetTrendingStocksResponse> getTrendingStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetTrendingStocksRequest> request) async {
    return getTrendingStocks(call, await request);
  }

  $async.Future<$48.GetTopGainersResponse> getTopGainers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetTopGainersRequest> request) async {
    return getTopGainers(call, await request);
  }

  $async.Future<$48.GetTopLosersResponse> getTopLosers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetTopLosersRequest> request) async {
    return getTopLosers(call, await request);
  }

  $async.Future<$48.GetMarketStatusResponse> getMarketStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetMarketStatusRequest> request) async {
    return getMarketStatus(call, await request);
  }

  $async.Future<$48.GetMarketNewsResponse> getMarketNews_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetMarketNewsRequest> request) async {
    return getMarketNews(call, await request);
  }

  $async.Future<$48.CreatePriceAlertResponse> createPriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.CreatePriceAlertRequest> request) async {
    return createPriceAlert(call, await request);
  }

  $async.Future<$48.GetPriceAlertsResponse> getPriceAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetPriceAlertsRequest> request) async {
    return getPriceAlerts(call, await request);
  }

  $async.Future<$48.UpdatePriceAlertResponse> updatePriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.UpdatePriceAlertRequest> request) async {
    return updatePriceAlert(call, await request);
  }

  $async.Future<$48.DeletePriceAlertResponse> deletePriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.DeletePriceAlertRequest> request) async {
    return deletePriceAlert(call, await request);
  }

  $async.Future<$48.GetStocksResponse> getStocks(
      $grpc.ServiceCall call, $48.GetStocksRequest request);
  $async.Future<$48.GetStockResponse> getStock(
      $grpc.ServiceCall call, $48.GetStockRequest request);
  $async.Future<$48.SearchStocksResponse> searchStocks(
      $grpc.ServiceCall call, $48.SearchStocksRequest request);
  $async.Future<$48.GetStockPriceHistoryResponse> getStockPriceHistory(
      $grpc.ServiceCall call, $48.GetStockPriceHistoryRequest request);
  $async.Future<$48.GetMarketIndicesResponse> getMarketIndices(
      $grpc.ServiceCall call, $48.GetMarketIndicesRequest request);
  $async.Future<$48.GetTrendingStocksResponse> getTrendingStocks(
      $grpc.ServiceCall call, $48.GetTrendingStocksRequest request);
  $async.Future<$48.GetTopGainersResponse> getTopGainers(
      $grpc.ServiceCall call, $48.GetTopGainersRequest request);
  $async.Future<$48.GetTopLosersResponse> getTopLosers(
      $grpc.ServiceCall call, $48.GetTopLosersRequest request);
  $async.Future<$48.GetMarketStatusResponse> getMarketStatus(
      $grpc.ServiceCall call, $48.GetMarketStatusRequest request);
  $async.Future<$48.GetMarketNewsResponse> getMarketNews(
      $grpc.ServiceCall call, $48.GetMarketNewsRequest request);
  $async.Future<$48.CreatePriceAlertResponse> createPriceAlert(
      $grpc.ServiceCall call, $48.CreatePriceAlertRequest request);
  $async.Future<$48.GetPriceAlertsResponse> getPriceAlerts(
      $grpc.ServiceCall call, $48.GetPriceAlertsRequest request);
  $async.Future<$48.UpdatePriceAlertResponse> updatePriceAlert(
      $grpc.ServiceCall call, $48.UpdatePriceAlertRequest request);
  $async.Future<$48.DeletePriceAlertResponse> deletePriceAlert(
      $grpc.ServiceCall call, $48.DeletePriceAlertRequest request);
}

class StocksPortfolioServiceClient extends $grpc.Client {
  static final _$getUserPortfolio = $grpc.ClientMethod<
          $48.GetUserPortfolioRequest, $48.GetUserPortfolioResponse>(
      '/stockspb.StocksPortfolioService/GetUserPortfolio',
      ($48.GetUserPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetUserPortfolioResponse.fromBuffer(value));
  static final _$getPortfolioHoldings = $grpc.ClientMethod<
          $48.GetPortfolioHoldingsRequest, $48.GetPortfolioHoldingsResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioHoldings',
      ($48.GetPortfolioHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetPortfolioHoldingsResponse.fromBuffer(value));
  static final _$getPortfolioPerformance = $grpc.ClientMethod<
          $48.GetPortfolioPerformanceRequest,
          $48.GetPortfolioPerformanceResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioPerformance',
      ($48.GetPortfolioPerformanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetPortfolioPerformanceResponse.fromBuffer(value));
  static final _$updatePortfolioCash = $grpc.ClientMethod<
          $48.UpdatePortfolioCashRequest, $48.UpdatePortfolioCashResponse>(
      '/stockspb.StocksPortfolioService/UpdatePortfolioCash',
      ($48.UpdatePortfolioCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.UpdatePortfolioCashResponse.fromBuffer(value));

  StocksPortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$48.GetUserPortfolioResponse> getUserPortfolio(
      $48.GetUserPortfolioRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $48.GetPortfolioHoldingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetPortfolioPerformanceResponse>
      getPortfolioPerformance($48.GetPortfolioPerformanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioPerformance, request,
        options: options);
  }

  $grpc.ResponseFuture<$48.UpdatePortfolioCashResponse> updatePortfolioCash(
      $48.UpdatePortfolioCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePortfolioCash, request, options: options);
  }
}

abstract class StocksPortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StocksPortfolioService';

  StocksPortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$48.GetUserPortfolioRequest,
            $48.GetUserPortfolioResponse>(
        'GetUserPortfolio',
        getUserPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetUserPortfolioRequest.fromBuffer(value),
        ($48.GetUserPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetPortfolioHoldingsRequest,
            $48.GetPortfolioHoldingsResponse>(
        'GetPortfolioHoldings',
        getPortfolioHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetPortfolioHoldingsRequest.fromBuffer(value),
        ($48.GetPortfolioHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetPortfolioPerformanceRequest,
            $48.GetPortfolioPerformanceResponse>(
        'GetPortfolioPerformance',
        getPortfolioPerformance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetPortfolioPerformanceRequest.fromBuffer(value),
        ($48.GetPortfolioPerformanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.UpdatePortfolioCashRequest,
            $48.UpdatePortfolioCashResponse>(
        'UpdatePortfolioCash',
        updatePortfolioCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.UpdatePortfolioCashRequest.fromBuffer(value),
        ($48.UpdatePortfolioCashResponse value) => value.writeToBuffer()));
  }

  $async.Future<$48.GetUserPortfolioResponse> getUserPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetUserPortfolioRequest> request) async {
    return getUserPortfolio(call, await request);
  }

  $async.Future<$48.GetPortfolioHoldingsResponse> getPortfolioHoldings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetPortfolioHoldingsRequest> request) async {
    return getPortfolioHoldings(call, await request);
  }

  $async.Future<$48.GetPortfolioPerformanceResponse>
      getPortfolioPerformance_Pre($grpc.ServiceCall call,
          $async.Future<$48.GetPortfolioPerformanceRequest> request) async {
    return getPortfolioPerformance(call, await request);
  }

  $async.Future<$48.UpdatePortfolioCashResponse> updatePortfolioCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.UpdatePortfolioCashRequest> request) async {
    return updatePortfolioCash(call, await request);
  }

  $async.Future<$48.GetUserPortfolioResponse> getUserPortfolio(
      $grpc.ServiceCall call, $48.GetUserPortfolioRequest request);
  $async.Future<$48.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $grpc.ServiceCall call, $48.GetPortfolioHoldingsRequest request);
  $async.Future<$48.GetPortfolioPerformanceResponse> getPortfolioPerformance(
      $grpc.ServiceCall call, $48.GetPortfolioPerformanceRequest request);
  $async.Future<$48.UpdatePortfolioCashResponse> updatePortfolioCash(
      $grpc.ServiceCall call, $48.UpdatePortfolioCashRequest request);
}

class OrderServiceClient extends $grpc.Client {
  static final _$placeOrder =
      $grpc.ClientMethod<$48.PlaceOrderRequest, $48.PlaceOrderResponse>(
          '/stockspb.OrderService/PlaceOrder',
          ($48.PlaceOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.PlaceOrderResponse.fromBuffer(value));
  static final _$getUserOrders =
      $grpc.ClientMethod<$48.GetUserOrdersRequest, $48.GetUserOrdersResponse>(
          '/stockspb.OrderService/GetUserOrders',
          ($48.GetUserOrdersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetUserOrdersResponse.fromBuffer(value));
  static final _$getOrder =
      $grpc.ClientMethod<$48.GetOrderRequest, $48.GetOrderResponse>(
          '/stockspb.OrderService/GetOrder',
          ($48.GetOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetOrderResponse.fromBuffer(value));
  static final _$cancelOrder =
      $grpc.ClientMethod<$48.CancelOrderRequest, $48.CancelOrderResponse>(
          '/stockspb.OrderService/CancelOrder',
          ($48.CancelOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.CancelOrderResponse.fromBuffer(value));
  static final _$getOrderHistory = $grpc.ClientMethod<
          $48.GetOrderHistoryRequest, $48.GetOrderHistoryResponse>(
      '/stockspb.OrderService/GetOrderHistory',
      ($48.GetOrderHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetOrderHistoryResponse.fromBuffer(value));

  OrderServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$48.PlaceOrderResponse> placeOrder(
      $48.PlaceOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$placeOrder, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetUserOrdersResponse> getUserOrders(
      $48.GetUserOrdersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserOrders, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetOrderResponse> getOrder(
      $48.GetOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrder, request, options: options);
  }

  $grpc.ResponseFuture<$48.CancelOrderResponse> cancelOrder(
      $48.CancelOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelOrder, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetOrderHistoryResponse> getOrderHistory(
      $48.GetOrderHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderHistory, request, options: options);
  }
}

abstract class OrderServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.OrderService';

  OrderServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$48.PlaceOrderRequest, $48.PlaceOrderResponse>(
            'PlaceOrder',
            placeOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $48.PlaceOrderRequest.fromBuffer(value),
            ($48.PlaceOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetUserOrdersRequest,
            $48.GetUserOrdersResponse>(
        'GetUserOrders',
        getUserOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetUserOrdersRequest.fromBuffer(value),
        ($48.GetUserOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetOrderRequest, $48.GetOrderResponse>(
        'GetOrder',
        getOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $48.GetOrderRequest.fromBuffer(value),
        ($48.GetOrderResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$48.CancelOrderRequest, $48.CancelOrderResponse>(
            'CancelOrder',
            cancelOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $48.CancelOrderRequest.fromBuffer(value),
            ($48.CancelOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetOrderHistoryRequest,
            $48.GetOrderHistoryResponse>(
        'GetOrderHistory',
        getOrderHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetOrderHistoryRequest.fromBuffer(value),
        ($48.GetOrderHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$48.PlaceOrderResponse> placeOrder_Pre($grpc.ServiceCall call,
      $async.Future<$48.PlaceOrderRequest> request) async {
    return placeOrder(call, await request);
  }

  $async.Future<$48.GetUserOrdersResponse> getUserOrders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetUserOrdersRequest> request) async {
    return getUserOrders(call, await request);
  }

  $async.Future<$48.GetOrderResponse> getOrder_Pre($grpc.ServiceCall call,
      $async.Future<$48.GetOrderRequest> request) async {
    return getOrder(call, await request);
  }

  $async.Future<$48.CancelOrderResponse> cancelOrder_Pre($grpc.ServiceCall call,
      $async.Future<$48.CancelOrderRequest> request) async {
    return cancelOrder(call, await request);
  }

  $async.Future<$48.GetOrderHistoryResponse> getOrderHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetOrderHistoryRequest> request) async {
    return getOrderHistory(call, await request);
  }

  $async.Future<$48.PlaceOrderResponse> placeOrder(
      $grpc.ServiceCall call, $48.PlaceOrderRequest request);
  $async.Future<$48.GetUserOrdersResponse> getUserOrders(
      $grpc.ServiceCall call, $48.GetUserOrdersRequest request);
  $async.Future<$48.GetOrderResponse> getOrder(
      $grpc.ServiceCall call, $48.GetOrderRequest request);
  $async.Future<$48.CancelOrderResponse> cancelOrder(
      $grpc.ServiceCall call, $48.CancelOrderRequest request);
  $async.Future<$48.GetOrderHistoryResponse> getOrderHistory(
      $grpc.ServiceCall call, $48.GetOrderHistoryRequest request);
}

class WatchlistServiceClient extends $grpc.Client {
  static final _$createWatchlist = $grpc.ClientMethod<
          $48.CreateWatchlistRequest, $48.CreateWatchlistResponse>(
      '/stockspb.WatchlistService/CreateWatchlist',
      ($48.CreateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.CreateWatchlistResponse.fromBuffer(value));
  static final _$getUserWatchlists = $grpc.ClientMethod<
          $48.GetUserWatchlistsRequest, $48.GetUserWatchlistsResponse>(
      '/stockspb.WatchlistService/GetUserWatchlists',
      ($48.GetUserWatchlistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.GetUserWatchlistsResponse.fromBuffer(value));
  static final _$getWatchlist =
      $grpc.ClientMethod<$48.GetWatchlistRequest, $48.GetWatchlistResponse>(
          '/stockspb.WatchlistService/GetWatchlist',
          ($48.GetWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $48.GetWatchlistResponse.fromBuffer(value));
  static final _$updateWatchlist = $grpc.ClientMethod<
          $48.UpdateWatchlistRequest, $48.UpdateWatchlistResponse>(
      '/stockspb.WatchlistService/UpdateWatchlist',
      ($48.UpdateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.UpdateWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist = $grpc.ClientMethod<
          $48.DeleteWatchlistRequest, $48.DeleteWatchlistResponse>(
      '/stockspb.WatchlistService/DeleteWatchlist',
      ($48.DeleteWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.DeleteWatchlistResponse.fromBuffer(value));
  static final _$addStockToWatchlist = $grpc.ClientMethod<
          $48.AddStockToWatchlistRequest, $48.AddStockToWatchlistResponse>(
      '/stockspb.WatchlistService/AddStockToWatchlist',
      ($48.AddStockToWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.AddStockToWatchlistResponse.fromBuffer(value));
  static final _$removeStockFromWatchlist = $grpc.ClientMethod<
          $48.RemoveStockFromWatchlistRequest,
          $48.RemoveStockFromWatchlistResponse>(
      '/stockspb.WatchlistService/RemoveStockFromWatchlist',
      ($48.RemoveStockFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $48.RemoveStockFromWatchlistResponse.fromBuffer(value));

  WatchlistServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$48.CreateWatchlistResponse> createWatchlist(
      $48.CreateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetUserWatchlistsResponse> getUserWatchlists(
      $48.GetUserWatchlistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$48.GetWatchlistResponse> getWatchlist(
      $48.GetWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$48.UpdateWatchlistResponse> updateWatchlist(
      $48.UpdateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$48.DeleteWatchlistResponse> deleteWatchlist(
      $48.DeleteWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$48.AddStockToWatchlistResponse> addStockToWatchlist(
      $48.AddStockToWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addStockToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$48.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist($48.RemoveStockFromWatchlistRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeStockFromWatchlist, request,
        options: options);
  }
}

abstract class WatchlistServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.WatchlistService';

  WatchlistServiceBase() {
    $addMethod($grpc.ServiceMethod<$48.CreateWatchlistRequest,
            $48.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.CreateWatchlistRequest.fromBuffer(value),
        ($48.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.GetUserWatchlistsRequest,
            $48.GetUserWatchlistsResponse>(
        'GetUserWatchlists',
        getUserWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.GetUserWatchlistsRequest.fromBuffer(value),
        ($48.GetUserWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$48.GetWatchlistRequest, $48.GetWatchlistResponse>(
            'GetWatchlist',
            getWatchlist_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $48.GetWatchlistRequest.fromBuffer(value),
            ($48.GetWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.UpdateWatchlistRequest,
            $48.UpdateWatchlistResponse>(
        'UpdateWatchlist',
        updateWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.UpdateWatchlistRequest.fromBuffer(value),
        ($48.UpdateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.DeleteWatchlistRequest,
            $48.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.DeleteWatchlistRequest.fromBuffer(value),
        ($48.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.AddStockToWatchlistRequest,
            $48.AddStockToWatchlistResponse>(
        'AddStockToWatchlist',
        addStockToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.AddStockToWatchlistRequest.fromBuffer(value),
        ($48.AddStockToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$48.RemoveStockFromWatchlistRequest,
            $48.RemoveStockFromWatchlistResponse>(
        'RemoveStockFromWatchlist',
        removeStockFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $48.RemoveStockFromWatchlistRequest.fromBuffer(value),
        ($48.RemoveStockFromWatchlistResponse value) => value.writeToBuffer()));
  }

  $async.Future<$48.CreateWatchlistResponse> createWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$48.GetUserWatchlistsResponse> getUserWatchlists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetUserWatchlistsRequest> request) async {
    return getUserWatchlists(call, await request);
  }

  $async.Future<$48.GetWatchlistResponse> getWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.GetWatchlistRequest> request) async {
    return getWatchlist(call, await request);
  }

  $async.Future<$48.UpdateWatchlistResponse> updateWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.UpdateWatchlistRequest> request) async {
    return updateWatchlist(call, await request);
  }

  $async.Future<$48.DeleteWatchlistResponse> deleteWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$48.AddStockToWatchlistResponse> addStockToWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$48.AddStockToWatchlistRequest> request) async {
    return addStockToWatchlist(call, await request);
  }

  $async.Future<$48.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist_Pre($grpc.ServiceCall call,
          $async.Future<$48.RemoveStockFromWatchlistRequest> request) async {
    return removeStockFromWatchlist(call, await request);
  }

  $async.Future<$48.CreateWatchlistResponse> createWatchlist(
      $grpc.ServiceCall call, $48.CreateWatchlistRequest request);
  $async.Future<$48.GetUserWatchlistsResponse> getUserWatchlists(
      $grpc.ServiceCall call, $48.GetUserWatchlistsRequest request);
  $async.Future<$48.GetWatchlistResponse> getWatchlist(
      $grpc.ServiceCall call, $48.GetWatchlistRequest request);
  $async.Future<$48.UpdateWatchlistResponse> updateWatchlist(
      $grpc.ServiceCall call, $48.UpdateWatchlistRequest request);
  $async.Future<$48.DeleteWatchlistResponse> deleteWatchlist(
      $grpc.ServiceCall call, $48.DeleteWatchlistRequest request);
  $async.Future<$48.AddStockToWatchlistResponse> addStockToWatchlist(
      $grpc.ServiceCall call, $48.AddStockToWatchlistRequest request);
  $async.Future<$48.RemoveStockFromWatchlistResponse> removeStockFromWatchlist(
      $grpc.ServiceCall call, $48.RemoveStockFromWatchlistRequest request);
}
