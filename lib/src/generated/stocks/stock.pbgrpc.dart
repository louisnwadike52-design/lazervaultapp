///
//  Generated code. Do not modify.
//  source: stocks/stock.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'stock.pb.dart' as $47;
export 'stock.pb.dart';

class StockServiceClient extends $grpc.Client {
  static final _$getStocks =
      $grpc.ClientMethod<$47.GetStocksRequest, $47.GetStocksResponse>(
          '/stockspb.StockService/GetStocks',
          ($47.GetStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetStocksResponse.fromBuffer(value));
  static final _$getStock =
      $grpc.ClientMethod<$47.GetStockRequest, $47.GetStockResponse>(
          '/stockspb.StockService/GetStock',
          ($47.GetStockRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetStockResponse.fromBuffer(value));
  static final _$searchStocks =
      $grpc.ClientMethod<$47.SearchStocksRequest, $47.SearchStocksResponse>(
          '/stockspb.StockService/SearchStocks',
          ($47.SearchStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.SearchStocksResponse.fromBuffer(value));
  static final _$getStockPriceHistory = $grpc.ClientMethod<
          $47.GetStockPriceHistoryRequest, $47.GetStockPriceHistoryResponse>(
      '/stockspb.StockService/GetStockPriceHistory',
      ($47.GetStockPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetStockPriceHistoryResponse.fromBuffer(value));
  static final _$getMarketIndices = $grpc.ClientMethod<
          $47.GetMarketIndicesRequest, $47.GetMarketIndicesResponse>(
      '/stockspb.StockService/GetMarketIndices',
      ($47.GetMarketIndicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetMarketIndicesResponse.fromBuffer(value));
  static final _$getTrendingStocks = $grpc.ClientMethod<
          $47.GetTrendingStocksRequest, $47.GetTrendingStocksResponse>(
      '/stockspb.StockService/GetTrendingStocks',
      ($47.GetTrendingStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetTrendingStocksResponse.fromBuffer(value));
  static final _$getTopGainers =
      $grpc.ClientMethod<$47.GetTopGainersRequest, $47.GetTopGainersResponse>(
          '/stockspb.StockService/GetTopGainers',
          ($47.GetTopGainersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetTopGainersResponse.fromBuffer(value));
  static final _$getTopLosers =
      $grpc.ClientMethod<$47.GetTopLosersRequest, $47.GetTopLosersResponse>(
          '/stockspb.StockService/GetTopLosers',
          ($47.GetTopLosersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetTopLosersResponse.fromBuffer(value));
  static final _$getMarketStatus = $grpc.ClientMethod<
          $47.GetMarketStatusRequest, $47.GetMarketStatusResponse>(
      '/stockspb.StockService/GetMarketStatus',
      ($47.GetMarketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetMarketStatusResponse.fromBuffer(value));
  static final _$getMarketNews =
      $grpc.ClientMethod<$47.GetMarketNewsRequest, $47.GetMarketNewsResponse>(
          '/stockspb.StockService/GetMarketNews',
          ($47.GetMarketNewsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetMarketNewsResponse.fromBuffer(value));
  static final _$createPriceAlert = $grpc.ClientMethod<
          $47.CreatePriceAlertRequest, $47.CreatePriceAlertResponse>(
      '/stockspb.StockService/CreatePriceAlert',
      ($47.CreatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.CreatePriceAlertResponse.fromBuffer(value));
  static final _$getPriceAlerts =
      $grpc.ClientMethod<$47.GetPriceAlertsRequest, $47.GetPriceAlertsResponse>(
          '/stockspb.StockService/GetPriceAlerts',
          ($47.GetPriceAlertsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetPriceAlertsResponse.fromBuffer(value));
  static final _$updatePriceAlert = $grpc.ClientMethod<
          $47.UpdatePriceAlertRequest, $47.UpdatePriceAlertResponse>(
      '/stockspb.StockService/UpdatePriceAlert',
      ($47.UpdatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.UpdatePriceAlertResponse.fromBuffer(value));
  static final _$deletePriceAlert = $grpc.ClientMethod<
          $47.DeletePriceAlertRequest, $47.DeletePriceAlertResponse>(
      '/stockspb.StockService/DeletePriceAlert',
      ($47.DeletePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.DeletePriceAlertResponse.fromBuffer(value));

  StockServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$47.GetStocksResponse> getStocks(
      $47.GetStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStocks, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetStockResponse> getStock(
      $47.GetStockRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStock, request, options: options);
  }

  $grpc.ResponseFuture<$47.SearchStocksResponse> searchStocks(
      $47.SearchStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStocks, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetStockPriceHistoryResponse> getStockPriceHistory(
      $47.GetStockPriceHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetMarketIndicesResponse> getMarketIndices(
      $47.GetMarketIndicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketIndices, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetTrendingStocksResponse> getTrendingStocks(
      $47.GetTrendingStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingStocks, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetTopGainersResponse> getTopGainers(
      $47.GetTopGainersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopGainers, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetTopLosersResponse> getTopLosers(
      $47.GetTopLosersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopLosers, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetMarketStatusResponse> getMarketStatus(
      $47.GetMarketStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetMarketNewsResponse> getMarketNews(
      $47.GetMarketNewsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketNews, request, options: options);
  }

  $grpc.ResponseFuture<$47.CreatePriceAlertResponse> createPriceAlert(
      $47.CreatePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetPriceAlertsResponse> getPriceAlerts(
      $47.GetPriceAlertsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPriceAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$47.UpdatePriceAlertResponse> updatePriceAlert(
      $47.UpdatePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$47.DeletePriceAlertResponse> deletePriceAlert(
      $47.DeletePriceAlertRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePriceAlert, request, options: options);
  }
}

abstract class StockServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StockService';

  StockServiceBase() {
    $addMethod($grpc.ServiceMethod<$47.GetStocksRequest, $47.GetStocksResponse>(
        'GetStocks',
        getStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $47.GetStocksRequest.fromBuffer(value),
        ($47.GetStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetStockRequest, $47.GetStockResponse>(
        'GetStock',
        getStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $47.GetStockRequest.fromBuffer(value),
        ($47.GetStockResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$47.SearchStocksRequest, $47.SearchStocksResponse>(
            'SearchStocks',
            searchStocks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $47.SearchStocksRequest.fromBuffer(value),
            ($47.SearchStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetStockPriceHistoryRequest,
            $47.GetStockPriceHistoryResponse>(
        'GetStockPriceHistory',
        getStockPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetStockPriceHistoryRequest.fromBuffer(value),
        ($47.GetStockPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetMarketIndicesRequest,
            $47.GetMarketIndicesResponse>(
        'GetMarketIndices',
        getMarketIndices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetMarketIndicesRequest.fromBuffer(value),
        ($47.GetMarketIndicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetTrendingStocksRequest,
            $47.GetTrendingStocksResponse>(
        'GetTrendingStocks',
        getTrendingStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetTrendingStocksRequest.fromBuffer(value),
        ($47.GetTrendingStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetTopGainersRequest,
            $47.GetTopGainersResponse>(
        'GetTopGainers',
        getTopGainers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetTopGainersRequest.fromBuffer(value),
        ($47.GetTopGainersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$47.GetTopLosersRequest, $47.GetTopLosersResponse>(
            'GetTopLosers',
            getTopLosers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $47.GetTopLosersRequest.fromBuffer(value),
            ($47.GetTopLosersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetMarketStatusRequest,
            $47.GetMarketStatusResponse>(
        'GetMarketStatus',
        getMarketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetMarketStatusRequest.fromBuffer(value),
        ($47.GetMarketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetMarketNewsRequest,
            $47.GetMarketNewsResponse>(
        'GetMarketNews',
        getMarketNews_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetMarketNewsRequest.fromBuffer(value),
        ($47.GetMarketNewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.CreatePriceAlertRequest,
            $47.CreatePriceAlertResponse>(
        'CreatePriceAlert',
        createPriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.CreatePriceAlertRequest.fromBuffer(value),
        ($47.CreatePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetPriceAlertsRequest,
            $47.GetPriceAlertsResponse>(
        'GetPriceAlerts',
        getPriceAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetPriceAlertsRequest.fromBuffer(value),
        ($47.GetPriceAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.UpdatePriceAlertRequest,
            $47.UpdatePriceAlertResponse>(
        'UpdatePriceAlert',
        updatePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.UpdatePriceAlertRequest.fromBuffer(value),
        ($47.UpdatePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.DeletePriceAlertRequest,
            $47.DeletePriceAlertResponse>(
        'DeletePriceAlert',
        deletePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.DeletePriceAlertRequest.fromBuffer(value),
        ($47.DeletePriceAlertResponse value) => value.writeToBuffer()));
  }

  $async.Future<$47.GetStocksResponse> getStocks_Pre($grpc.ServiceCall call,
      $async.Future<$47.GetStocksRequest> request) async {
    return getStocks(call, await request);
  }

  $async.Future<$47.GetStockResponse> getStock_Pre($grpc.ServiceCall call,
      $async.Future<$47.GetStockRequest> request) async {
    return getStock(call, await request);
  }

  $async.Future<$47.SearchStocksResponse> searchStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.SearchStocksRequest> request) async {
    return searchStocks(call, await request);
  }

  $async.Future<$47.GetStockPriceHistoryResponse> getStockPriceHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetStockPriceHistoryRequest> request) async {
    return getStockPriceHistory(call, await request);
  }

  $async.Future<$47.GetMarketIndicesResponse> getMarketIndices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetMarketIndicesRequest> request) async {
    return getMarketIndices(call, await request);
  }

  $async.Future<$47.GetTrendingStocksResponse> getTrendingStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetTrendingStocksRequest> request) async {
    return getTrendingStocks(call, await request);
  }

  $async.Future<$47.GetTopGainersResponse> getTopGainers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetTopGainersRequest> request) async {
    return getTopGainers(call, await request);
  }

  $async.Future<$47.GetTopLosersResponse> getTopLosers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetTopLosersRequest> request) async {
    return getTopLosers(call, await request);
  }

  $async.Future<$47.GetMarketStatusResponse> getMarketStatus_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetMarketStatusRequest> request) async {
    return getMarketStatus(call, await request);
  }

  $async.Future<$47.GetMarketNewsResponse> getMarketNews_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetMarketNewsRequest> request) async {
    return getMarketNews(call, await request);
  }

  $async.Future<$47.CreatePriceAlertResponse> createPriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.CreatePriceAlertRequest> request) async {
    return createPriceAlert(call, await request);
  }

  $async.Future<$47.GetPriceAlertsResponse> getPriceAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetPriceAlertsRequest> request) async {
    return getPriceAlerts(call, await request);
  }

  $async.Future<$47.UpdatePriceAlertResponse> updatePriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.UpdatePriceAlertRequest> request) async {
    return updatePriceAlert(call, await request);
  }

  $async.Future<$47.DeletePriceAlertResponse> deletePriceAlert_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.DeletePriceAlertRequest> request) async {
    return deletePriceAlert(call, await request);
  }

  $async.Future<$47.GetStocksResponse> getStocks(
      $grpc.ServiceCall call, $47.GetStocksRequest request);
  $async.Future<$47.GetStockResponse> getStock(
      $grpc.ServiceCall call, $47.GetStockRequest request);
  $async.Future<$47.SearchStocksResponse> searchStocks(
      $grpc.ServiceCall call, $47.SearchStocksRequest request);
  $async.Future<$47.GetStockPriceHistoryResponse> getStockPriceHistory(
      $grpc.ServiceCall call, $47.GetStockPriceHistoryRequest request);
  $async.Future<$47.GetMarketIndicesResponse> getMarketIndices(
      $grpc.ServiceCall call, $47.GetMarketIndicesRequest request);
  $async.Future<$47.GetTrendingStocksResponse> getTrendingStocks(
      $grpc.ServiceCall call, $47.GetTrendingStocksRequest request);
  $async.Future<$47.GetTopGainersResponse> getTopGainers(
      $grpc.ServiceCall call, $47.GetTopGainersRequest request);
  $async.Future<$47.GetTopLosersResponse> getTopLosers(
      $grpc.ServiceCall call, $47.GetTopLosersRequest request);
  $async.Future<$47.GetMarketStatusResponse> getMarketStatus(
      $grpc.ServiceCall call, $47.GetMarketStatusRequest request);
  $async.Future<$47.GetMarketNewsResponse> getMarketNews(
      $grpc.ServiceCall call, $47.GetMarketNewsRequest request);
  $async.Future<$47.CreatePriceAlertResponse> createPriceAlert(
      $grpc.ServiceCall call, $47.CreatePriceAlertRequest request);
  $async.Future<$47.GetPriceAlertsResponse> getPriceAlerts(
      $grpc.ServiceCall call, $47.GetPriceAlertsRequest request);
  $async.Future<$47.UpdatePriceAlertResponse> updatePriceAlert(
      $grpc.ServiceCall call, $47.UpdatePriceAlertRequest request);
  $async.Future<$47.DeletePriceAlertResponse> deletePriceAlert(
      $grpc.ServiceCall call, $47.DeletePriceAlertRequest request);
}

class StocksPortfolioServiceClient extends $grpc.Client {
  static final _$getUserPortfolio = $grpc.ClientMethod<
          $47.GetUserPortfolioRequest, $47.GetUserPortfolioResponse>(
      '/stockspb.StocksPortfolioService/GetUserPortfolio',
      ($47.GetUserPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetUserPortfolioResponse.fromBuffer(value));
  static final _$getPortfolioHoldings = $grpc.ClientMethod<
          $47.GetPortfolioHoldingsRequest, $47.GetPortfolioHoldingsResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioHoldings',
      ($47.GetPortfolioHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetPortfolioHoldingsResponse.fromBuffer(value));
  static final _$getPortfolioPerformance = $grpc.ClientMethod<
          $47.GetPortfolioPerformanceRequest,
          $47.GetPortfolioPerformanceResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioPerformance',
      ($47.GetPortfolioPerformanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetPortfolioPerformanceResponse.fromBuffer(value));
  static final _$updatePortfolioCash = $grpc.ClientMethod<
          $47.UpdatePortfolioCashRequest, $47.UpdatePortfolioCashResponse>(
      '/stockspb.StocksPortfolioService/UpdatePortfolioCash',
      ($47.UpdatePortfolioCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.UpdatePortfolioCashResponse.fromBuffer(value));

  StocksPortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$47.GetUserPortfolioResponse> getUserPortfolio(
      $47.GetUserPortfolioRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $47.GetPortfolioHoldingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetPortfolioPerformanceResponse>
      getPortfolioPerformance($47.GetPortfolioPerformanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioPerformance, request,
        options: options);
  }

  $grpc.ResponseFuture<$47.UpdatePortfolioCashResponse> updatePortfolioCash(
      $47.UpdatePortfolioCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePortfolioCash, request, options: options);
  }
}

abstract class StocksPortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StocksPortfolioService';

  StocksPortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$47.GetUserPortfolioRequest,
            $47.GetUserPortfolioResponse>(
        'GetUserPortfolio',
        getUserPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetUserPortfolioRequest.fromBuffer(value),
        ($47.GetUserPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetPortfolioHoldingsRequest,
            $47.GetPortfolioHoldingsResponse>(
        'GetPortfolioHoldings',
        getPortfolioHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetPortfolioHoldingsRequest.fromBuffer(value),
        ($47.GetPortfolioHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetPortfolioPerformanceRequest,
            $47.GetPortfolioPerformanceResponse>(
        'GetPortfolioPerformance',
        getPortfolioPerformance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetPortfolioPerformanceRequest.fromBuffer(value),
        ($47.GetPortfolioPerformanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.UpdatePortfolioCashRequest,
            $47.UpdatePortfolioCashResponse>(
        'UpdatePortfolioCash',
        updatePortfolioCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.UpdatePortfolioCashRequest.fromBuffer(value),
        ($47.UpdatePortfolioCashResponse value) => value.writeToBuffer()));
  }

  $async.Future<$47.GetUserPortfolioResponse> getUserPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetUserPortfolioRequest> request) async {
    return getUserPortfolio(call, await request);
  }

  $async.Future<$47.GetPortfolioHoldingsResponse> getPortfolioHoldings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetPortfolioHoldingsRequest> request) async {
    return getPortfolioHoldings(call, await request);
  }

  $async.Future<$47.GetPortfolioPerformanceResponse>
      getPortfolioPerformance_Pre($grpc.ServiceCall call,
          $async.Future<$47.GetPortfolioPerformanceRequest> request) async {
    return getPortfolioPerformance(call, await request);
  }

  $async.Future<$47.UpdatePortfolioCashResponse> updatePortfolioCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.UpdatePortfolioCashRequest> request) async {
    return updatePortfolioCash(call, await request);
  }

  $async.Future<$47.GetUserPortfolioResponse> getUserPortfolio(
      $grpc.ServiceCall call, $47.GetUserPortfolioRequest request);
  $async.Future<$47.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $grpc.ServiceCall call, $47.GetPortfolioHoldingsRequest request);
  $async.Future<$47.GetPortfolioPerformanceResponse> getPortfolioPerformance(
      $grpc.ServiceCall call, $47.GetPortfolioPerformanceRequest request);
  $async.Future<$47.UpdatePortfolioCashResponse> updatePortfolioCash(
      $grpc.ServiceCall call, $47.UpdatePortfolioCashRequest request);
}

class OrderServiceClient extends $grpc.Client {
  static final _$placeOrder =
      $grpc.ClientMethod<$47.PlaceOrderRequest, $47.PlaceOrderResponse>(
          '/stockspb.OrderService/PlaceOrder',
          ($47.PlaceOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.PlaceOrderResponse.fromBuffer(value));
  static final _$getUserOrders =
      $grpc.ClientMethod<$47.GetUserOrdersRequest, $47.GetUserOrdersResponse>(
          '/stockspb.OrderService/GetUserOrders',
          ($47.GetUserOrdersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetUserOrdersResponse.fromBuffer(value));
  static final _$getOrder =
      $grpc.ClientMethod<$47.GetOrderRequest, $47.GetOrderResponse>(
          '/stockspb.OrderService/GetOrder',
          ($47.GetOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetOrderResponse.fromBuffer(value));
  static final _$cancelOrder =
      $grpc.ClientMethod<$47.CancelOrderRequest, $47.CancelOrderResponse>(
          '/stockspb.OrderService/CancelOrder',
          ($47.CancelOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.CancelOrderResponse.fromBuffer(value));
  static final _$getOrderHistory = $grpc.ClientMethod<
          $47.GetOrderHistoryRequest, $47.GetOrderHistoryResponse>(
      '/stockspb.OrderService/GetOrderHistory',
      ($47.GetOrderHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetOrderHistoryResponse.fromBuffer(value));

  OrderServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$47.PlaceOrderResponse> placeOrder(
      $47.PlaceOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$placeOrder, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetUserOrdersResponse> getUserOrders(
      $47.GetUserOrdersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserOrders, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetOrderResponse> getOrder(
      $47.GetOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrder, request, options: options);
  }

  $grpc.ResponseFuture<$47.CancelOrderResponse> cancelOrder(
      $47.CancelOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelOrder, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetOrderHistoryResponse> getOrderHistory(
      $47.GetOrderHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderHistory, request, options: options);
  }
}

abstract class OrderServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.OrderService';

  OrderServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$47.PlaceOrderRequest, $47.PlaceOrderResponse>(
            'PlaceOrder',
            placeOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $47.PlaceOrderRequest.fromBuffer(value),
            ($47.PlaceOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetUserOrdersRequest,
            $47.GetUserOrdersResponse>(
        'GetUserOrders',
        getUserOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetUserOrdersRequest.fromBuffer(value),
        ($47.GetUserOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetOrderRequest, $47.GetOrderResponse>(
        'GetOrder',
        getOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $47.GetOrderRequest.fromBuffer(value),
        ($47.GetOrderResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$47.CancelOrderRequest, $47.CancelOrderResponse>(
            'CancelOrder',
            cancelOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $47.CancelOrderRequest.fromBuffer(value),
            ($47.CancelOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetOrderHistoryRequest,
            $47.GetOrderHistoryResponse>(
        'GetOrderHistory',
        getOrderHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetOrderHistoryRequest.fromBuffer(value),
        ($47.GetOrderHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$47.PlaceOrderResponse> placeOrder_Pre($grpc.ServiceCall call,
      $async.Future<$47.PlaceOrderRequest> request) async {
    return placeOrder(call, await request);
  }

  $async.Future<$47.GetUserOrdersResponse> getUserOrders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetUserOrdersRequest> request) async {
    return getUserOrders(call, await request);
  }

  $async.Future<$47.GetOrderResponse> getOrder_Pre($grpc.ServiceCall call,
      $async.Future<$47.GetOrderRequest> request) async {
    return getOrder(call, await request);
  }

  $async.Future<$47.CancelOrderResponse> cancelOrder_Pre($grpc.ServiceCall call,
      $async.Future<$47.CancelOrderRequest> request) async {
    return cancelOrder(call, await request);
  }

  $async.Future<$47.GetOrderHistoryResponse> getOrderHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetOrderHistoryRequest> request) async {
    return getOrderHistory(call, await request);
  }

  $async.Future<$47.PlaceOrderResponse> placeOrder(
      $grpc.ServiceCall call, $47.PlaceOrderRequest request);
  $async.Future<$47.GetUserOrdersResponse> getUserOrders(
      $grpc.ServiceCall call, $47.GetUserOrdersRequest request);
  $async.Future<$47.GetOrderResponse> getOrder(
      $grpc.ServiceCall call, $47.GetOrderRequest request);
  $async.Future<$47.CancelOrderResponse> cancelOrder(
      $grpc.ServiceCall call, $47.CancelOrderRequest request);
  $async.Future<$47.GetOrderHistoryResponse> getOrderHistory(
      $grpc.ServiceCall call, $47.GetOrderHistoryRequest request);
}

class WatchlistServiceClient extends $grpc.Client {
  static final _$createWatchlist = $grpc.ClientMethod<
          $47.CreateWatchlistRequest, $47.CreateWatchlistResponse>(
      '/stockspb.WatchlistService/CreateWatchlist',
      ($47.CreateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.CreateWatchlistResponse.fromBuffer(value));
  static final _$getUserWatchlists = $grpc.ClientMethod<
          $47.GetUserWatchlistsRequest, $47.GetUserWatchlistsResponse>(
      '/stockspb.WatchlistService/GetUserWatchlists',
      ($47.GetUserWatchlistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.GetUserWatchlistsResponse.fromBuffer(value));
  static final _$getWatchlist =
      $grpc.ClientMethod<$47.GetWatchlistRequest, $47.GetWatchlistResponse>(
          '/stockspb.WatchlistService/GetWatchlist',
          ($47.GetWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $47.GetWatchlistResponse.fromBuffer(value));
  static final _$updateWatchlist = $grpc.ClientMethod<
          $47.UpdateWatchlistRequest, $47.UpdateWatchlistResponse>(
      '/stockspb.WatchlistService/UpdateWatchlist',
      ($47.UpdateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.UpdateWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist = $grpc.ClientMethod<
          $47.DeleteWatchlistRequest, $47.DeleteWatchlistResponse>(
      '/stockspb.WatchlistService/DeleteWatchlist',
      ($47.DeleteWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.DeleteWatchlistResponse.fromBuffer(value));
  static final _$addStockToWatchlist = $grpc.ClientMethod<
          $47.AddStockToWatchlistRequest, $47.AddStockToWatchlistResponse>(
      '/stockspb.WatchlistService/AddStockToWatchlist',
      ($47.AddStockToWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.AddStockToWatchlistResponse.fromBuffer(value));
  static final _$removeStockFromWatchlist = $grpc.ClientMethod<
          $47.RemoveStockFromWatchlistRequest,
          $47.RemoveStockFromWatchlistResponse>(
      '/stockspb.WatchlistService/RemoveStockFromWatchlist',
      ($47.RemoveStockFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $47.RemoveStockFromWatchlistResponse.fromBuffer(value));

  WatchlistServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$47.CreateWatchlistResponse> createWatchlist(
      $47.CreateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetUserWatchlistsResponse> getUserWatchlists(
      $47.GetUserWatchlistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$47.GetWatchlistResponse> getWatchlist(
      $47.GetWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$47.UpdateWatchlistResponse> updateWatchlist(
      $47.UpdateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$47.DeleteWatchlistResponse> deleteWatchlist(
      $47.DeleteWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$47.AddStockToWatchlistResponse> addStockToWatchlist(
      $47.AddStockToWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addStockToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$47.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist($47.RemoveStockFromWatchlistRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeStockFromWatchlist, request,
        options: options);
  }
}

abstract class WatchlistServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.WatchlistService';

  WatchlistServiceBase() {
    $addMethod($grpc.ServiceMethod<$47.CreateWatchlistRequest,
            $47.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.CreateWatchlistRequest.fromBuffer(value),
        ($47.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.GetUserWatchlistsRequest,
            $47.GetUserWatchlistsResponse>(
        'GetUserWatchlists',
        getUserWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.GetUserWatchlistsRequest.fromBuffer(value),
        ($47.GetUserWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$47.GetWatchlistRequest, $47.GetWatchlistResponse>(
            'GetWatchlist',
            getWatchlist_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $47.GetWatchlistRequest.fromBuffer(value),
            ($47.GetWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.UpdateWatchlistRequest,
            $47.UpdateWatchlistResponse>(
        'UpdateWatchlist',
        updateWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.UpdateWatchlistRequest.fromBuffer(value),
        ($47.UpdateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.DeleteWatchlistRequest,
            $47.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.DeleteWatchlistRequest.fromBuffer(value),
        ($47.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.AddStockToWatchlistRequest,
            $47.AddStockToWatchlistResponse>(
        'AddStockToWatchlist',
        addStockToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.AddStockToWatchlistRequest.fromBuffer(value),
        ($47.AddStockToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$47.RemoveStockFromWatchlistRequest,
            $47.RemoveStockFromWatchlistResponse>(
        'RemoveStockFromWatchlist',
        removeStockFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $47.RemoveStockFromWatchlistRequest.fromBuffer(value),
        ($47.RemoveStockFromWatchlistResponse value) => value.writeToBuffer()));
  }

  $async.Future<$47.CreateWatchlistResponse> createWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$47.GetUserWatchlistsResponse> getUserWatchlists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetUserWatchlistsRequest> request) async {
    return getUserWatchlists(call, await request);
  }

  $async.Future<$47.GetWatchlistResponse> getWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.GetWatchlistRequest> request) async {
    return getWatchlist(call, await request);
  }

  $async.Future<$47.UpdateWatchlistResponse> updateWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.UpdateWatchlistRequest> request) async {
    return updateWatchlist(call, await request);
  }

  $async.Future<$47.DeleteWatchlistResponse> deleteWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$47.AddStockToWatchlistResponse> addStockToWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$47.AddStockToWatchlistRequest> request) async {
    return addStockToWatchlist(call, await request);
  }

  $async.Future<$47.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist_Pre($grpc.ServiceCall call,
          $async.Future<$47.RemoveStockFromWatchlistRequest> request) async {
    return removeStockFromWatchlist(call, await request);
  }

  $async.Future<$47.CreateWatchlistResponse> createWatchlist(
      $grpc.ServiceCall call, $47.CreateWatchlistRequest request);
  $async.Future<$47.GetUserWatchlistsResponse> getUserWatchlists(
      $grpc.ServiceCall call, $47.GetUserWatchlistsRequest request);
  $async.Future<$47.GetWatchlistResponse> getWatchlist(
      $grpc.ServiceCall call, $47.GetWatchlistRequest request);
  $async.Future<$47.UpdateWatchlistResponse> updateWatchlist(
      $grpc.ServiceCall call, $47.UpdateWatchlistRequest request);
  $async.Future<$47.DeleteWatchlistResponse> deleteWatchlist(
      $grpc.ServiceCall call, $47.DeleteWatchlistRequest request);
  $async.Future<$47.AddStockToWatchlistResponse> addStockToWatchlist(
      $grpc.ServiceCall call, $47.AddStockToWatchlistRequest request);
  $async.Future<$47.RemoveStockFromWatchlistResponse> removeStockFromWatchlist(
      $grpc.ServiceCall call, $47.RemoveStockFromWatchlistRequest request);
}
