//
//  Generated code. Do not modify.
//  source: stocks/stock.proto
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

import 'stock.pb.dart' as $0;

export 'stock.pb.dart';

@$pb.GrpcServiceName('stockspb.StockService')
class StockServiceClient extends $grpc.Client {
  static final _$getStocks = $grpc.ClientMethod<$0.GetStocksRequest, $0.GetStocksResponse>(
      '/stockspb.StockService/GetStocks',
      ($0.GetStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetStocksResponse.fromBuffer(value));
  static final _$getStock = $grpc.ClientMethod<$0.GetStockRequest, $0.GetStockResponse>(
      '/stockspb.StockService/GetStock',
      ($0.GetStockRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetStockResponse.fromBuffer(value));
  static final _$searchStocks = $grpc.ClientMethod<$0.SearchStocksRequest, $0.SearchStocksResponse>(
      '/stockspb.StockService/SearchStocks',
      ($0.SearchStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SearchStocksResponse.fromBuffer(value));
  static final _$getStockPriceHistory = $grpc.ClientMethod<$0.GetStockPriceHistoryRequest, $0.GetStockPriceHistoryResponse>(
      '/stockspb.StockService/GetStockPriceHistory',
      ($0.GetStockPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetStockPriceHistoryResponse.fromBuffer(value));
  static final _$getMarketIndices = $grpc.ClientMethod<$0.GetMarketIndicesRequest, $0.GetMarketIndicesResponse>(
      '/stockspb.StockService/GetMarketIndices',
      ($0.GetMarketIndicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMarketIndicesResponse.fromBuffer(value));
  static final _$getTrendingStocks = $grpc.ClientMethod<$0.GetTrendingStocksRequest, $0.GetTrendingStocksResponse>(
      '/stockspb.StockService/GetTrendingStocks',
      ($0.GetTrendingStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTrendingStocksResponse.fromBuffer(value));
  static final _$getTopGainers = $grpc.ClientMethod<$0.GetTopGainersRequest, $0.GetTopGainersResponse>(
      '/stockspb.StockService/GetTopGainers',
      ($0.GetTopGainersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTopGainersResponse.fromBuffer(value));
  static final _$getTopLosers = $grpc.ClientMethod<$0.GetTopLosersRequest, $0.GetTopLosersResponse>(
      '/stockspb.StockService/GetTopLosers',
      ($0.GetTopLosersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTopLosersResponse.fromBuffer(value));
  static final _$getMarketStatus = $grpc.ClientMethod<$0.GetMarketStatusRequest, $0.GetMarketStatusResponse>(
      '/stockspb.StockService/GetMarketStatus',
      ($0.GetMarketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMarketStatusResponse.fromBuffer(value));
  static final _$getMarketNews = $grpc.ClientMethod<$0.GetMarketNewsRequest, $0.GetMarketNewsResponse>(
      '/stockspb.StockService/GetMarketNews',
      ($0.GetMarketNewsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMarketNewsResponse.fromBuffer(value));
  static final _$createPriceAlert = $grpc.ClientMethod<$0.CreatePriceAlertRequest, $0.CreatePriceAlertResponse>(
      '/stockspb.StockService/CreatePriceAlert',
      ($0.CreatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreatePriceAlertResponse.fromBuffer(value));
  static final _$getPriceAlerts = $grpc.ClientMethod<$0.GetPriceAlertsRequest, $0.GetPriceAlertsResponse>(
      '/stockspb.StockService/GetPriceAlerts',
      ($0.GetPriceAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPriceAlertsResponse.fromBuffer(value));
  static final _$updatePriceAlert = $grpc.ClientMethod<$0.UpdatePriceAlertRequest, $0.UpdatePriceAlertResponse>(
      '/stockspb.StockService/UpdatePriceAlert',
      ($0.UpdatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdatePriceAlertResponse.fromBuffer(value));
  static final _$deletePriceAlert = $grpc.ClientMethod<$0.DeletePriceAlertRequest, $0.DeletePriceAlertResponse>(
      '/stockspb.StockService/DeletePriceAlert',
      ($0.DeletePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeletePriceAlertResponse.fromBuffer(value));

  StockServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetStocksResponse> getStocks($0.GetStocksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStocks, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetStockResponse> getStock($0.GetStockRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStock, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchStocksResponse> searchStocks($0.SearchStocksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStocks, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetStockPriceHistoryResponse> getStockPriceHistory($0.GetStockPriceHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketIndicesResponse> getMarketIndices($0.GetMarketIndicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketIndices, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrendingStocksResponse> getTrendingStocks($0.GetTrendingStocksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingStocks, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTopGainersResponse> getTopGainers($0.GetTopGainersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopGainers, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTopLosersResponse> getTopLosers($0.GetTopLosersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopLosers, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketStatusResponse> getMarketStatus($0.GetMarketStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketNewsResponse> getMarketNews($0.GetMarketNewsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketNews, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreatePriceAlertResponse> createPriceAlert($0.CreatePriceAlertRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPriceAlertsResponse> getPriceAlerts($0.GetPriceAlertsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPriceAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePriceAlertResponse> updatePriceAlert($0.UpdatePriceAlertRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePriceAlert, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeletePriceAlertResponse> deletePriceAlert($0.DeletePriceAlertRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePriceAlert, request, options: options);
  }
}

@$pb.GrpcServiceName('stockspb.StockService')
abstract class StockServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StockService';

  StockServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetStocksRequest, $0.GetStocksResponse>(
        'GetStocks',
        getStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStocksRequest.fromBuffer(value),
        ($0.GetStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStockRequest, $0.GetStockResponse>(
        'GetStock',
        getStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStockRequest.fromBuffer(value),
        ($0.GetStockResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchStocksRequest, $0.SearchStocksResponse>(
        'SearchStocks',
        searchStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchStocksRequest.fromBuffer(value),
        ($0.SearchStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStockPriceHistoryRequest, $0.GetStockPriceHistoryResponse>(
        'GetStockPriceHistory',
        getStockPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStockPriceHistoryRequest.fromBuffer(value),
        ($0.GetStockPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketIndicesRequest, $0.GetMarketIndicesResponse>(
        'GetMarketIndices',
        getMarketIndices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMarketIndicesRequest.fromBuffer(value),
        ($0.GetMarketIndicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrendingStocksRequest, $0.GetTrendingStocksResponse>(
        'GetTrendingStocks',
        getTrendingStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTrendingStocksRequest.fromBuffer(value),
        ($0.GetTrendingStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTopGainersRequest, $0.GetTopGainersResponse>(
        'GetTopGainers',
        getTopGainers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTopGainersRequest.fromBuffer(value),
        ($0.GetTopGainersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTopLosersRequest, $0.GetTopLosersResponse>(
        'GetTopLosers',
        getTopLosers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTopLosersRequest.fromBuffer(value),
        ($0.GetTopLosersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketStatusRequest, $0.GetMarketStatusResponse>(
        'GetMarketStatus',
        getMarketStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMarketStatusRequest.fromBuffer(value),
        ($0.GetMarketStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketNewsRequest, $0.GetMarketNewsResponse>(
        'GetMarketNews',
        getMarketNews_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMarketNewsRequest.fromBuffer(value),
        ($0.GetMarketNewsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreatePriceAlertRequest, $0.CreatePriceAlertResponse>(
        'CreatePriceAlert',
        createPriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreatePriceAlertRequest.fromBuffer(value),
        ($0.CreatePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPriceAlertsRequest, $0.GetPriceAlertsResponse>(
        'GetPriceAlerts',
        getPriceAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPriceAlertsRequest.fromBuffer(value),
        ($0.GetPriceAlertsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePriceAlertRequest, $0.UpdatePriceAlertResponse>(
        'UpdatePriceAlert',
        updatePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdatePriceAlertRequest.fromBuffer(value),
        ($0.UpdatePriceAlertResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeletePriceAlertRequest, $0.DeletePriceAlertResponse>(
        'DeletePriceAlert',
        deletePriceAlert_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeletePriceAlertRequest.fromBuffer(value),
        ($0.DeletePriceAlertResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetStocksResponse> getStocks_Pre($grpc.ServiceCall call, $async.Future<$0.GetStocksRequest> request) async {
    return getStocks(call, await request);
  }

  $async.Future<$0.GetStockResponse> getStock_Pre($grpc.ServiceCall call, $async.Future<$0.GetStockRequest> request) async {
    return getStock(call, await request);
  }

  $async.Future<$0.SearchStocksResponse> searchStocks_Pre($grpc.ServiceCall call, $async.Future<$0.SearchStocksRequest> request) async {
    return searchStocks(call, await request);
  }

  $async.Future<$0.GetStockPriceHistoryResponse> getStockPriceHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetStockPriceHistoryRequest> request) async {
    return getStockPriceHistory(call, await request);
  }

  $async.Future<$0.GetMarketIndicesResponse> getMarketIndices_Pre($grpc.ServiceCall call, $async.Future<$0.GetMarketIndicesRequest> request) async {
    return getMarketIndices(call, await request);
  }

  $async.Future<$0.GetTrendingStocksResponse> getTrendingStocks_Pre($grpc.ServiceCall call, $async.Future<$0.GetTrendingStocksRequest> request) async {
    return getTrendingStocks(call, await request);
  }

  $async.Future<$0.GetTopGainersResponse> getTopGainers_Pre($grpc.ServiceCall call, $async.Future<$0.GetTopGainersRequest> request) async {
    return getTopGainers(call, await request);
  }

  $async.Future<$0.GetTopLosersResponse> getTopLosers_Pre($grpc.ServiceCall call, $async.Future<$0.GetTopLosersRequest> request) async {
    return getTopLosers(call, await request);
  }

  $async.Future<$0.GetMarketStatusResponse> getMarketStatus_Pre($grpc.ServiceCall call, $async.Future<$0.GetMarketStatusRequest> request) async {
    return getMarketStatus(call, await request);
  }

  $async.Future<$0.GetMarketNewsResponse> getMarketNews_Pre($grpc.ServiceCall call, $async.Future<$0.GetMarketNewsRequest> request) async {
    return getMarketNews(call, await request);
  }

  $async.Future<$0.CreatePriceAlertResponse> createPriceAlert_Pre($grpc.ServiceCall call, $async.Future<$0.CreatePriceAlertRequest> request) async {
    return createPriceAlert(call, await request);
  }

  $async.Future<$0.GetPriceAlertsResponse> getPriceAlerts_Pre($grpc.ServiceCall call, $async.Future<$0.GetPriceAlertsRequest> request) async {
    return getPriceAlerts(call, await request);
  }

  $async.Future<$0.UpdatePriceAlertResponse> updatePriceAlert_Pre($grpc.ServiceCall call, $async.Future<$0.UpdatePriceAlertRequest> request) async {
    return updatePriceAlert(call, await request);
  }

  $async.Future<$0.DeletePriceAlertResponse> deletePriceAlert_Pre($grpc.ServiceCall call, $async.Future<$0.DeletePriceAlertRequest> request) async {
    return deletePriceAlert(call, await request);
  }

  $async.Future<$0.GetStocksResponse> getStocks($grpc.ServiceCall call, $0.GetStocksRequest request);
  $async.Future<$0.GetStockResponse> getStock($grpc.ServiceCall call, $0.GetStockRequest request);
  $async.Future<$0.SearchStocksResponse> searchStocks($grpc.ServiceCall call, $0.SearchStocksRequest request);
  $async.Future<$0.GetStockPriceHistoryResponse> getStockPriceHistory($grpc.ServiceCall call, $0.GetStockPriceHistoryRequest request);
  $async.Future<$0.GetMarketIndicesResponse> getMarketIndices($grpc.ServiceCall call, $0.GetMarketIndicesRequest request);
  $async.Future<$0.GetTrendingStocksResponse> getTrendingStocks($grpc.ServiceCall call, $0.GetTrendingStocksRequest request);
  $async.Future<$0.GetTopGainersResponse> getTopGainers($grpc.ServiceCall call, $0.GetTopGainersRequest request);
  $async.Future<$0.GetTopLosersResponse> getTopLosers($grpc.ServiceCall call, $0.GetTopLosersRequest request);
  $async.Future<$0.GetMarketStatusResponse> getMarketStatus($grpc.ServiceCall call, $0.GetMarketStatusRequest request);
  $async.Future<$0.GetMarketNewsResponse> getMarketNews($grpc.ServiceCall call, $0.GetMarketNewsRequest request);
  $async.Future<$0.CreatePriceAlertResponse> createPriceAlert($grpc.ServiceCall call, $0.CreatePriceAlertRequest request);
  $async.Future<$0.GetPriceAlertsResponse> getPriceAlerts($grpc.ServiceCall call, $0.GetPriceAlertsRequest request);
  $async.Future<$0.UpdatePriceAlertResponse> updatePriceAlert($grpc.ServiceCall call, $0.UpdatePriceAlertRequest request);
  $async.Future<$0.DeletePriceAlertResponse> deletePriceAlert($grpc.ServiceCall call, $0.DeletePriceAlertRequest request);
}
@$pb.GrpcServiceName('stockspb.StocksPortfolioService')
class StocksPortfolioServiceClient extends $grpc.Client {
  static final _$getUserPortfolio = $grpc.ClientMethod<$0.GetUserPortfolioRequest, $0.GetUserPortfolioResponse>(
      '/stockspb.StocksPortfolioService/GetUserPortfolio',
      ($0.GetUserPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserPortfolioResponse.fromBuffer(value));
  static final _$getPortfolioHoldings = $grpc.ClientMethod<$0.GetPortfolioHoldingsRequest, $0.GetPortfolioHoldingsResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioHoldings',
      ($0.GetPortfolioHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPortfolioHoldingsResponse.fromBuffer(value));
  static final _$getPortfolioPerformance = $grpc.ClientMethod<$0.GetPortfolioPerformanceRequest, $0.GetPortfolioPerformanceResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioPerformance',
      ($0.GetPortfolioPerformanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPortfolioPerformanceResponse.fromBuffer(value));
  static final _$updatePortfolioCash = $grpc.ClientMethod<$0.UpdatePortfolioCashRequest, $0.UpdatePortfolioCashResponse>(
      '/stockspb.StocksPortfolioService/UpdatePortfolioCash',
      ($0.UpdatePortfolioCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdatePortfolioCashResponse.fromBuffer(value));

  StocksPortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetUserPortfolioResponse> getUserPortfolio($0.GetUserPortfolioRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPortfolioHoldingsResponse> getPortfolioHoldings($0.GetPortfolioHoldingsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPortfolioPerformanceResponse> getPortfolioPerformance($0.GetPortfolioPerformanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioPerformance, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePortfolioCashResponse> updatePortfolioCash($0.UpdatePortfolioCashRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePortfolioCash, request, options: options);
  }
}

@$pb.GrpcServiceName('stockspb.StocksPortfolioService')
abstract class StocksPortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StocksPortfolioService';

  StocksPortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetUserPortfolioRequest, $0.GetUserPortfolioResponse>(
        'GetUserPortfolio',
        getUserPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserPortfolioRequest.fromBuffer(value),
        ($0.GetUserPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPortfolioHoldingsRequest, $0.GetPortfolioHoldingsResponse>(
        'GetPortfolioHoldings',
        getPortfolioHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPortfolioHoldingsRequest.fromBuffer(value),
        ($0.GetPortfolioHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPortfolioPerformanceRequest, $0.GetPortfolioPerformanceResponse>(
        'GetPortfolioPerformance',
        getPortfolioPerformance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPortfolioPerformanceRequest.fromBuffer(value),
        ($0.GetPortfolioPerformanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePortfolioCashRequest, $0.UpdatePortfolioCashResponse>(
        'UpdatePortfolioCash',
        updatePortfolioCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdatePortfolioCashRequest.fromBuffer(value),
        ($0.UpdatePortfolioCashResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetUserPortfolioResponse> getUserPortfolio_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserPortfolioRequest> request) async {
    return getUserPortfolio(call, await request);
  }

  $async.Future<$0.GetPortfolioHoldingsResponse> getPortfolioHoldings_Pre($grpc.ServiceCall call, $async.Future<$0.GetPortfolioHoldingsRequest> request) async {
    return getPortfolioHoldings(call, await request);
  }

  $async.Future<$0.GetPortfolioPerformanceResponse> getPortfolioPerformance_Pre($grpc.ServiceCall call, $async.Future<$0.GetPortfolioPerformanceRequest> request) async {
    return getPortfolioPerformance(call, await request);
  }

  $async.Future<$0.UpdatePortfolioCashResponse> updatePortfolioCash_Pre($grpc.ServiceCall call, $async.Future<$0.UpdatePortfolioCashRequest> request) async {
    return updatePortfolioCash(call, await request);
  }

  $async.Future<$0.GetUserPortfolioResponse> getUserPortfolio($grpc.ServiceCall call, $0.GetUserPortfolioRequest request);
  $async.Future<$0.GetPortfolioHoldingsResponse> getPortfolioHoldings($grpc.ServiceCall call, $0.GetPortfolioHoldingsRequest request);
  $async.Future<$0.GetPortfolioPerformanceResponse> getPortfolioPerformance($grpc.ServiceCall call, $0.GetPortfolioPerformanceRequest request);
  $async.Future<$0.UpdatePortfolioCashResponse> updatePortfolioCash($grpc.ServiceCall call, $0.UpdatePortfolioCashRequest request);
}
@$pb.GrpcServiceName('stockspb.OrderService')
class OrderServiceClient extends $grpc.Client {
  static final _$placeOrder = $grpc.ClientMethod<$0.PlaceOrderRequest, $0.PlaceOrderResponse>(
      '/stockspb.OrderService/PlaceOrder',
      ($0.PlaceOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PlaceOrderResponse.fromBuffer(value));
  static final _$getUserOrders = $grpc.ClientMethod<$0.GetUserOrdersRequest, $0.GetUserOrdersResponse>(
      '/stockspb.OrderService/GetUserOrders',
      ($0.GetUserOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserOrdersResponse.fromBuffer(value));
  static final _$getOrder = $grpc.ClientMethod<$0.GetOrderRequest, $0.GetOrderResponse>(
      '/stockspb.OrderService/GetOrder',
      ($0.GetOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetOrderResponse.fromBuffer(value));
  static final _$cancelOrder = $grpc.ClientMethod<$0.CancelOrderRequest, $0.CancelOrderResponse>(
      '/stockspb.OrderService/CancelOrder',
      ($0.CancelOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CancelOrderResponse.fromBuffer(value));
  static final _$getOrderHistory = $grpc.ClientMethod<$0.GetOrderHistoryRequest, $0.GetOrderHistoryResponse>(
      '/stockspb.OrderService/GetOrderHistory',
      ($0.GetOrderHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetOrderHistoryResponse.fromBuffer(value));

  OrderServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.PlaceOrderResponse> placeOrder($0.PlaceOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$placeOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserOrdersResponse> getUserOrders($0.GetUserOrdersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserOrders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOrderResponse> getOrder($0.GetOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelOrderResponse> cancelOrder($0.CancelOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOrderHistoryResponse> getOrderHistory($0.GetOrderHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('stockspb.OrderService')
abstract class OrderServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.OrderService';

  OrderServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PlaceOrderRequest, $0.PlaceOrderResponse>(
        'PlaceOrder',
        placeOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlaceOrderRequest.fromBuffer(value),
        ($0.PlaceOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserOrdersRequest, $0.GetUserOrdersResponse>(
        'GetUserOrders',
        getUserOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserOrdersRequest.fromBuffer(value),
        ($0.GetUserOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOrderRequest, $0.GetOrderResponse>(
        'GetOrder',
        getOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOrderRequest.fromBuffer(value),
        ($0.GetOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelOrderRequest, $0.CancelOrderResponse>(
        'CancelOrder',
        cancelOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelOrderRequest.fromBuffer(value),
        ($0.CancelOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOrderHistoryRequest, $0.GetOrderHistoryResponse>(
        'GetOrderHistory',
        getOrderHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOrderHistoryRequest.fromBuffer(value),
        ($0.GetOrderHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PlaceOrderResponse> placeOrder_Pre($grpc.ServiceCall call, $async.Future<$0.PlaceOrderRequest> request) async {
    return placeOrder(call, await request);
  }

  $async.Future<$0.GetUserOrdersResponse> getUserOrders_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserOrdersRequest> request) async {
    return getUserOrders(call, await request);
  }

  $async.Future<$0.GetOrderResponse> getOrder_Pre($grpc.ServiceCall call, $async.Future<$0.GetOrderRequest> request) async {
    return getOrder(call, await request);
  }

  $async.Future<$0.CancelOrderResponse> cancelOrder_Pre($grpc.ServiceCall call, $async.Future<$0.CancelOrderRequest> request) async {
    return cancelOrder(call, await request);
  }

  $async.Future<$0.GetOrderHistoryResponse> getOrderHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetOrderHistoryRequest> request) async {
    return getOrderHistory(call, await request);
  }

  $async.Future<$0.PlaceOrderResponse> placeOrder($grpc.ServiceCall call, $0.PlaceOrderRequest request);
  $async.Future<$0.GetUserOrdersResponse> getUserOrders($grpc.ServiceCall call, $0.GetUserOrdersRequest request);
  $async.Future<$0.GetOrderResponse> getOrder($grpc.ServiceCall call, $0.GetOrderRequest request);
  $async.Future<$0.CancelOrderResponse> cancelOrder($grpc.ServiceCall call, $0.CancelOrderRequest request);
  $async.Future<$0.GetOrderHistoryResponse> getOrderHistory($grpc.ServiceCall call, $0.GetOrderHistoryRequest request);
}
@$pb.GrpcServiceName('stockspb.WatchlistService')
class WatchlistServiceClient extends $grpc.Client {
  static final _$createWatchlist = $grpc.ClientMethod<$0.CreateWatchlistRequest, $0.CreateWatchlistResponse>(
      '/stockspb.WatchlistService/CreateWatchlist',
      ($0.CreateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateWatchlistResponse.fromBuffer(value));
  static final _$getUserWatchlists = $grpc.ClientMethod<$0.GetUserWatchlistsRequest, $0.GetUserWatchlistsResponse>(
      '/stockspb.WatchlistService/GetUserWatchlists',
      ($0.GetUserWatchlistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserWatchlistsResponse.fromBuffer(value));
  static final _$getWatchlist = $grpc.ClientMethod<$0.GetWatchlistRequest, $0.GetWatchlistResponse>(
      '/stockspb.WatchlistService/GetWatchlist',
      ($0.GetWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetWatchlistResponse.fromBuffer(value));
  static final _$updateWatchlist = $grpc.ClientMethod<$0.UpdateWatchlistRequest, $0.UpdateWatchlistResponse>(
      '/stockspb.WatchlistService/UpdateWatchlist',
      ($0.UpdateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist = $grpc.ClientMethod<$0.DeleteWatchlistRequest, $0.DeleteWatchlistResponse>(
      '/stockspb.WatchlistService/DeleteWatchlist',
      ($0.DeleteWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteWatchlistResponse.fromBuffer(value));
  static final _$addStockToWatchlist = $grpc.ClientMethod<$0.AddStockToWatchlistRequest, $0.AddStockToWatchlistResponse>(
      '/stockspb.WatchlistService/AddStockToWatchlist',
      ($0.AddStockToWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddStockToWatchlistResponse.fromBuffer(value));
  static final _$removeStockFromWatchlist = $grpc.ClientMethod<$0.RemoveStockFromWatchlistRequest, $0.RemoveStockFromWatchlistResponse>(
      '/stockspb.WatchlistService/RemoveStockFromWatchlist',
      ($0.RemoveStockFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RemoveStockFromWatchlistResponse.fromBuffer(value));

  WatchlistServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateWatchlistResponse> createWatchlist($0.CreateWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserWatchlistsResponse> getUserWatchlists($0.GetUserWatchlistsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWatchlistResponse> getWatchlist($0.GetWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateWatchlistResponse> updateWatchlist($0.UpdateWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteWatchlistResponse> deleteWatchlist($0.DeleteWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddStockToWatchlistResponse> addStockToWatchlist($0.AddStockToWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addStockToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$0.RemoveStockFromWatchlistResponse> removeStockFromWatchlist($0.RemoveStockFromWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeStockFromWatchlist, request, options: options);
  }
}

@$pb.GrpcServiceName('stockspb.WatchlistService')
abstract class WatchlistServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.WatchlistService';

  WatchlistServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateWatchlistRequest, $0.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateWatchlistRequest.fromBuffer(value),
        ($0.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserWatchlistsRequest, $0.GetUserWatchlistsResponse>(
        'GetUserWatchlists',
        getUserWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserWatchlistsRequest.fromBuffer(value),
        ($0.GetUserWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWatchlistRequest, $0.GetWatchlistResponse>(
        'GetWatchlist',
        getWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetWatchlistRequest.fromBuffer(value),
        ($0.GetWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateWatchlistRequest, $0.UpdateWatchlistResponse>(
        'UpdateWatchlist',
        updateWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateWatchlistRequest.fromBuffer(value),
        ($0.UpdateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteWatchlistRequest, $0.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteWatchlistRequest.fromBuffer(value),
        ($0.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddStockToWatchlistRequest, $0.AddStockToWatchlistResponse>(
        'AddStockToWatchlist',
        addStockToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddStockToWatchlistRequest.fromBuffer(value),
        ($0.AddStockToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveStockFromWatchlistRequest, $0.RemoveStockFromWatchlistResponse>(
        'RemoveStockFromWatchlist',
        removeStockFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RemoveStockFromWatchlistRequest.fromBuffer(value),
        ($0.RemoveStockFromWatchlistResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateWatchlistResponse> createWatchlist_Pre($grpc.ServiceCall call, $async.Future<$0.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$0.GetUserWatchlistsResponse> getUserWatchlists_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserWatchlistsRequest> request) async {
    return getUserWatchlists(call, await request);
  }

  $async.Future<$0.GetWatchlistResponse> getWatchlist_Pre($grpc.ServiceCall call, $async.Future<$0.GetWatchlistRequest> request) async {
    return getWatchlist(call, await request);
  }

  $async.Future<$0.UpdateWatchlistResponse> updateWatchlist_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateWatchlistRequest> request) async {
    return updateWatchlist(call, await request);
  }

  $async.Future<$0.DeleteWatchlistResponse> deleteWatchlist_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$0.AddStockToWatchlistResponse> addStockToWatchlist_Pre($grpc.ServiceCall call, $async.Future<$0.AddStockToWatchlistRequest> request) async {
    return addStockToWatchlist(call, await request);
  }

  $async.Future<$0.RemoveStockFromWatchlistResponse> removeStockFromWatchlist_Pre($grpc.ServiceCall call, $async.Future<$0.RemoveStockFromWatchlistRequest> request) async {
    return removeStockFromWatchlist(call, await request);
  }

  $async.Future<$0.CreateWatchlistResponse> createWatchlist($grpc.ServiceCall call, $0.CreateWatchlistRequest request);
  $async.Future<$0.GetUserWatchlistsResponse> getUserWatchlists($grpc.ServiceCall call, $0.GetUserWatchlistsRequest request);
  $async.Future<$0.GetWatchlistResponse> getWatchlist($grpc.ServiceCall call, $0.GetWatchlistRequest request);
  $async.Future<$0.UpdateWatchlistResponse> updateWatchlist($grpc.ServiceCall call, $0.UpdateWatchlistRequest request);
  $async.Future<$0.DeleteWatchlistResponse> deleteWatchlist($grpc.ServiceCall call, $0.DeleteWatchlistRequest request);
  $async.Future<$0.AddStockToWatchlistResponse> addStockToWatchlist($grpc.ServiceCall call, $0.AddStockToWatchlistRequest request);
  $async.Future<$0.RemoveStockFromWatchlistResponse> removeStockFromWatchlist($grpc.ServiceCall call, $0.RemoveStockFromWatchlistRequest request);
}
