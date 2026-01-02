///
//  Generated code. Do not modify.
//  source: stocks/stock.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'stock.pb.dart' as $33;
export 'stock.pb.dart';

class StockServiceClient extends $grpc.Client {
  static final _$getStocks =
      $grpc.ClientMethod<$33.GetStocksRequest, $33.GetStocksResponse>(
          '/stockspb.StockService/GetStocks',
          ($33.GetStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetStocksResponse.fromBuffer(value));
  static final _$getStock =
      $grpc.ClientMethod<$33.GetStockRequest, $33.GetStockResponse>(
          '/stockspb.StockService/GetStock',
          ($33.GetStockRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetStockResponse.fromBuffer(value));
  static final _$searchStocks =
      $grpc.ClientMethod<$33.SearchStocksRequest, $33.SearchStocksResponse>(
          '/stockspb.StockService/SearchStocks',
          ($33.SearchStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.SearchStocksResponse.fromBuffer(value));
  static final _$getStockPriceHistory = $grpc.ClientMethod<
          $33.GetStockPriceHistoryRequest, $33.GetStockPriceHistoryResponse>(
      '/stockspb.StockService/GetStockPriceHistory',
      ($33.GetStockPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetStockPriceHistoryResponse.fromBuffer(value));
  static final _$getMarketIndices = $grpc.ClientMethod<
          $33.GetMarketIndicesRequest, $33.GetMarketIndicesResponse>(
      '/stockspb.StockService/GetMarketIndices',
      ($33.GetMarketIndicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetMarketIndicesResponse.fromBuffer(value));
  static final _$getTrendingStocks = $grpc.ClientMethod<
          $33.GetTrendingStocksRequest, $33.GetTrendingStocksResponse>(
      '/stockspb.StockService/GetTrendingStocks',
      ($33.GetTrendingStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetTrendingStocksResponse.fromBuffer(value));
  static final _$getTopGainers =
      $grpc.ClientMethod<$33.GetTopGainersRequest, $33.GetTopGainersResponse>(
          '/stockspb.StockService/GetTopGainers',
          ($33.GetTopGainersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetTopGainersResponse.fromBuffer(value));
  static final _$getTopLosers =
      $grpc.ClientMethod<$33.GetTopLosersRequest, $33.GetTopLosersResponse>(
          '/stockspb.StockService/GetTopLosers',
          ($33.GetTopLosersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetTopLosersResponse.fromBuffer(value));

  StockServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$33.GetStocksResponse> getStocks(
      $33.GetStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStocks, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetStockResponse> getStock(
      $33.GetStockRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStock, request, options: options);
  }

  $grpc.ResponseFuture<$33.SearchStocksResponse> searchStocks(
      $33.SearchStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStocks, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetStockPriceHistoryResponse> getStockPriceHistory(
      $33.GetStockPriceHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetMarketIndicesResponse> getMarketIndices(
      $33.GetMarketIndicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketIndices, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetTrendingStocksResponse> getTrendingStocks(
      $33.GetTrendingStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingStocks, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetTopGainersResponse> getTopGainers(
      $33.GetTopGainersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopGainers, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetTopLosersResponse> getTopLosers(
      $33.GetTopLosersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopLosers, request, options: options);
  }
}

abstract class StockServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StockService';

  StockServiceBase() {
    $addMethod($grpc.ServiceMethod<$33.GetStocksRequest, $33.GetStocksResponse>(
        'GetStocks',
        getStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetStocksRequest.fromBuffer(value),
        ($33.GetStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetStockRequest, $33.GetStockResponse>(
        'GetStock',
        getStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetStockRequest.fromBuffer(value),
        ($33.GetStockResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$33.SearchStocksRequest, $33.SearchStocksResponse>(
            'SearchStocks',
            searchStocks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $33.SearchStocksRequest.fromBuffer(value),
            ($33.SearchStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetStockPriceHistoryRequest,
            $33.GetStockPriceHistoryResponse>(
        'GetStockPriceHistory',
        getStockPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetStockPriceHistoryRequest.fromBuffer(value),
        ($33.GetStockPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetMarketIndicesRequest,
            $33.GetMarketIndicesResponse>(
        'GetMarketIndices',
        getMarketIndices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetMarketIndicesRequest.fromBuffer(value),
        ($33.GetMarketIndicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetTrendingStocksRequest,
            $33.GetTrendingStocksResponse>(
        'GetTrendingStocks',
        getTrendingStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetTrendingStocksRequest.fromBuffer(value),
        ($33.GetTrendingStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetTopGainersRequest,
            $33.GetTopGainersResponse>(
        'GetTopGainers',
        getTopGainers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetTopGainersRequest.fromBuffer(value),
        ($33.GetTopGainersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$33.GetTopLosersRequest, $33.GetTopLosersResponse>(
            'GetTopLosers',
            getTopLosers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $33.GetTopLosersRequest.fromBuffer(value),
            ($33.GetTopLosersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.GetStocksResponse> getStocks_Pre($grpc.ServiceCall call,
      $async.Future<$33.GetStocksRequest> request) async {
    return getStocks(call, await request);
  }

  $async.Future<$33.GetStockResponse> getStock_Pre($grpc.ServiceCall call,
      $async.Future<$33.GetStockRequest> request) async {
    return getStock(call, await request);
  }

  $async.Future<$33.SearchStocksResponse> searchStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.SearchStocksRequest> request) async {
    return searchStocks(call, await request);
  }

  $async.Future<$33.GetStockPriceHistoryResponse> getStockPriceHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetStockPriceHistoryRequest> request) async {
    return getStockPriceHistory(call, await request);
  }

  $async.Future<$33.GetMarketIndicesResponse> getMarketIndices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetMarketIndicesRequest> request) async {
    return getMarketIndices(call, await request);
  }

  $async.Future<$33.GetTrendingStocksResponse> getTrendingStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetTrendingStocksRequest> request) async {
    return getTrendingStocks(call, await request);
  }

  $async.Future<$33.GetTopGainersResponse> getTopGainers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetTopGainersRequest> request) async {
    return getTopGainers(call, await request);
  }

  $async.Future<$33.GetTopLosersResponse> getTopLosers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetTopLosersRequest> request) async {
    return getTopLosers(call, await request);
  }

  $async.Future<$33.GetStocksResponse> getStocks(
      $grpc.ServiceCall call, $33.GetStocksRequest request);
  $async.Future<$33.GetStockResponse> getStock(
      $grpc.ServiceCall call, $33.GetStockRequest request);
  $async.Future<$33.SearchStocksResponse> searchStocks(
      $grpc.ServiceCall call, $33.SearchStocksRequest request);
  $async.Future<$33.GetStockPriceHistoryResponse> getStockPriceHistory(
      $grpc.ServiceCall call, $33.GetStockPriceHistoryRequest request);
  $async.Future<$33.GetMarketIndicesResponse> getMarketIndices(
      $grpc.ServiceCall call, $33.GetMarketIndicesRequest request);
  $async.Future<$33.GetTrendingStocksResponse> getTrendingStocks(
      $grpc.ServiceCall call, $33.GetTrendingStocksRequest request);
  $async.Future<$33.GetTopGainersResponse> getTopGainers(
      $grpc.ServiceCall call, $33.GetTopGainersRequest request);
  $async.Future<$33.GetTopLosersResponse> getTopLosers(
      $grpc.ServiceCall call, $33.GetTopLosersRequest request);
}

class StocksPortfolioServiceClient extends $grpc.Client {
  static final _$getUserPortfolio = $grpc.ClientMethod<
          $33.GetUserPortfolioRequest, $33.GetUserPortfolioResponse>(
      '/stockspb.StocksPortfolioService/GetUserPortfolio',
      ($33.GetUserPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetUserPortfolioResponse.fromBuffer(value));
  static final _$getPortfolioHoldings = $grpc.ClientMethod<
          $33.GetPortfolioHoldingsRequest, $33.GetPortfolioHoldingsResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioHoldings',
      ($33.GetPortfolioHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetPortfolioHoldingsResponse.fromBuffer(value));
  static final _$getPortfolioPerformance = $grpc.ClientMethod<
          $33.GetPortfolioPerformanceRequest,
          $33.GetPortfolioPerformanceResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioPerformance',
      ($33.GetPortfolioPerformanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetPortfolioPerformanceResponse.fromBuffer(value));
  static final _$updatePortfolioCash = $grpc.ClientMethod<
          $33.UpdatePortfolioCashRequest, $33.UpdatePortfolioCashResponse>(
      '/stockspb.StocksPortfolioService/UpdatePortfolioCash',
      ($33.UpdatePortfolioCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.UpdatePortfolioCashResponse.fromBuffer(value));

  StocksPortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$33.GetUserPortfolioResponse> getUserPortfolio(
      $33.GetUserPortfolioRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $33.GetPortfolioHoldingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetPortfolioPerformanceResponse>
      getPortfolioPerformance($33.GetPortfolioPerformanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioPerformance, request,
        options: options);
  }

  $grpc.ResponseFuture<$33.UpdatePortfolioCashResponse> updatePortfolioCash(
      $33.UpdatePortfolioCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePortfolioCash, request, options: options);
  }
}

abstract class StocksPortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StocksPortfolioService';

  StocksPortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$33.GetUserPortfolioRequest,
            $33.GetUserPortfolioResponse>(
        'GetUserPortfolio',
        getUserPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetUserPortfolioRequest.fromBuffer(value),
        ($33.GetUserPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetPortfolioHoldingsRequest,
            $33.GetPortfolioHoldingsResponse>(
        'GetPortfolioHoldings',
        getPortfolioHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetPortfolioHoldingsRequest.fromBuffer(value),
        ($33.GetPortfolioHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetPortfolioPerformanceRequest,
            $33.GetPortfolioPerformanceResponse>(
        'GetPortfolioPerformance',
        getPortfolioPerformance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetPortfolioPerformanceRequest.fromBuffer(value),
        ($33.GetPortfolioPerformanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.UpdatePortfolioCashRequest,
            $33.UpdatePortfolioCashResponse>(
        'UpdatePortfolioCash',
        updatePortfolioCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.UpdatePortfolioCashRequest.fromBuffer(value),
        ($33.UpdatePortfolioCashResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.GetUserPortfolioResponse> getUserPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetUserPortfolioRequest> request) async {
    return getUserPortfolio(call, await request);
  }

  $async.Future<$33.GetPortfolioHoldingsResponse> getPortfolioHoldings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetPortfolioHoldingsRequest> request) async {
    return getPortfolioHoldings(call, await request);
  }

  $async.Future<$33.GetPortfolioPerformanceResponse>
      getPortfolioPerformance_Pre($grpc.ServiceCall call,
          $async.Future<$33.GetPortfolioPerformanceRequest> request) async {
    return getPortfolioPerformance(call, await request);
  }

  $async.Future<$33.UpdatePortfolioCashResponse> updatePortfolioCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.UpdatePortfolioCashRequest> request) async {
    return updatePortfolioCash(call, await request);
  }

  $async.Future<$33.GetUserPortfolioResponse> getUserPortfolio(
      $grpc.ServiceCall call, $33.GetUserPortfolioRequest request);
  $async.Future<$33.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $grpc.ServiceCall call, $33.GetPortfolioHoldingsRequest request);
  $async.Future<$33.GetPortfolioPerformanceResponse> getPortfolioPerformance(
      $grpc.ServiceCall call, $33.GetPortfolioPerformanceRequest request);
  $async.Future<$33.UpdatePortfolioCashResponse> updatePortfolioCash(
      $grpc.ServiceCall call, $33.UpdatePortfolioCashRequest request);
}

class OrderServiceClient extends $grpc.Client {
  static final _$placeOrder =
      $grpc.ClientMethod<$33.PlaceOrderRequest, $33.PlaceOrderResponse>(
          '/stockspb.OrderService/PlaceOrder',
          ($33.PlaceOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.PlaceOrderResponse.fromBuffer(value));
  static final _$getUserOrders =
      $grpc.ClientMethod<$33.GetUserOrdersRequest, $33.GetUserOrdersResponse>(
          '/stockspb.OrderService/GetUserOrders',
          ($33.GetUserOrdersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetUserOrdersResponse.fromBuffer(value));
  static final _$getOrder =
      $grpc.ClientMethod<$33.GetOrderRequest, $33.GetOrderResponse>(
          '/stockspb.OrderService/GetOrder',
          ($33.GetOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetOrderResponse.fromBuffer(value));
  static final _$cancelOrder =
      $grpc.ClientMethod<$33.CancelOrderRequest, $33.CancelOrderResponse>(
          '/stockspb.OrderService/CancelOrder',
          ($33.CancelOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.CancelOrderResponse.fromBuffer(value));
  static final _$getOrderHistory = $grpc.ClientMethod<
          $33.GetOrderHistoryRequest, $33.GetOrderHistoryResponse>(
      '/stockspb.OrderService/GetOrderHistory',
      ($33.GetOrderHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetOrderHistoryResponse.fromBuffer(value));

  OrderServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$33.PlaceOrderResponse> placeOrder(
      $33.PlaceOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$placeOrder, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetUserOrdersResponse> getUserOrders(
      $33.GetUserOrdersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserOrders, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetOrderResponse> getOrder(
      $33.GetOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrder, request, options: options);
  }

  $grpc.ResponseFuture<$33.CancelOrderResponse> cancelOrder(
      $33.CancelOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelOrder, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetOrderHistoryResponse> getOrderHistory(
      $33.GetOrderHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderHistory, request, options: options);
  }
}

abstract class OrderServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.OrderService';

  OrderServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$33.PlaceOrderRequest, $33.PlaceOrderResponse>(
            'PlaceOrder',
            placeOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $33.PlaceOrderRequest.fromBuffer(value),
            ($33.PlaceOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetUserOrdersRequest,
            $33.GetUserOrdersResponse>(
        'GetUserOrders',
        getUserOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetUserOrdersRequest.fromBuffer(value),
        ($33.GetUserOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetOrderRequest, $33.GetOrderResponse>(
        'GetOrder',
        getOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $33.GetOrderRequest.fromBuffer(value),
        ($33.GetOrderResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$33.CancelOrderRequest, $33.CancelOrderResponse>(
            'CancelOrder',
            cancelOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $33.CancelOrderRequest.fromBuffer(value),
            ($33.CancelOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetOrderHistoryRequest,
            $33.GetOrderHistoryResponse>(
        'GetOrderHistory',
        getOrderHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetOrderHistoryRequest.fromBuffer(value),
        ($33.GetOrderHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.PlaceOrderResponse> placeOrder_Pre($grpc.ServiceCall call,
      $async.Future<$33.PlaceOrderRequest> request) async {
    return placeOrder(call, await request);
  }

  $async.Future<$33.GetUserOrdersResponse> getUserOrders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetUserOrdersRequest> request) async {
    return getUserOrders(call, await request);
  }

  $async.Future<$33.GetOrderResponse> getOrder_Pre($grpc.ServiceCall call,
      $async.Future<$33.GetOrderRequest> request) async {
    return getOrder(call, await request);
  }

  $async.Future<$33.CancelOrderResponse> cancelOrder_Pre($grpc.ServiceCall call,
      $async.Future<$33.CancelOrderRequest> request) async {
    return cancelOrder(call, await request);
  }

  $async.Future<$33.GetOrderHistoryResponse> getOrderHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetOrderHistoryRequest> request) async {
    return getOrderHistory(call, await request);
  }

  $async.Future<$33.PlaceOrderResponse> placeOrder(
      $grpc.ServiceCall call, $33.PlaceOrderRequest request);
  $async.Future<$33.GetUserOrdersResponse> getUserOrders(
      $grpc.ServiceCall call, $33.GetUserOrdersRequest request);
  $async.Future<$33.GetOrderResponse> getOrder(
      $grpc.ServiceCall call, $33.GetOrderRequest request);
  $async.Future<$33.CancelOrderResponse> cancelOrder(
      $grpc.ServiceCall call, $33.CancelOrderRequest request);
  $async.Future<$33.GetOrderHistoryResponse> getOrderHistory(
      $grpc.ServiceCall call, $33.GetOrderHistoryRequest request);
}

class WatchlistServiceClient extends $grpc.Client {
  static final _$createWatchlist = $grpc.ClientMethod<
          $33.CreateWatchlistRequest, $33.CreateWatchlistResponse>(
      '/stockspb.WatchlistService/CreateWatchlist',
      ($33.CreateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.CreateWatchlistResponse.fromBuffer(value));
  static final _$getUserWatchlists = $grpc.ClientMethod<
          $33.GetUserWatchlistsRequest, $33.GetUserWatchlistsResponse>(
      '/stockspb.WatchlistService/GetUserWatchlists',
      ($33.GetUserWatchlistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetUserWatchlistsResponse.fromBuffer(value));
  static final _$getWatchlist =
      $grpc.ClientMethod<$33.GetWatchlistRequest, $33.GetWatchlistResponse>(
          '/stockspb.WatchlistService/GetWatchlist',
          ($33.GetWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetWatchlistResponse.fromBuffer(value));
  static final _$updateWatchlist = $grpc.ClientMethod<
          $33.UpdateWatchlistRequest, $33.UpdateWatchlistResponse>(
      '/stockspb.WatchlistService/UpdateWatchlist',
      ($33.UpdateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.UpdateWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist = $grpc.ClientMethod<
          $33.DeleteWatchlistRequest, $33.DeleteWatchlistResponse>(
      '/stockspb.WatchlistService/DeleteWatchlist',
      ($33.DeleteWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.DeleteWatchlistResponse.fromBuffer(value));
  static final _$addStockToWatchlist = $grpc.ClientMethod<
          $33.AddStockToWatchlistRequest, $33.AddStockToWatchlistResponse>(
      '/stockspb.WatchlistService/AddStockToWatchlist',
      ($33.AddStockToWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.AddStockToWatchlistResponse.fromBuffer(value));
  static final _$removeStockFromWatchlist = $grpc.ClientMethod<
          $33.RemoveStockFromWatchlistRequest,
          $33.RemoveStockFromWatchlistResponse>(
      '/stockspb.WatchlistService/RemoveStockFromWatchlist',
      ($33.RemoveStockFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.RemoveStockFromWatchlistResponse.fromBuffer(value));

  WatchlistServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$33.CreateWatchlistResponse> createWatchlist(
      $33.CreateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetUserWatchlistsResponse> getUserWatchlists(
      $33.GetUserWatchlistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetWatchlistResponse> getWatchlist(
      $33.GetWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$33.UpdateWatchlistResponse> updateWatchlist(
      $33.UpdateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$33.DeleteWatchlistResponse> deleteWatchlist(
      $33.DeleteWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$33.AddStockToWatchlistResponse> addStockToWatchlist(
      $33.AddStockToWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addStockToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$33.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist($33.RemoveStockFromWatchlistRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeStockFromWatchlist, request,
        options: options);
  }
}

abstract class WatchlistServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.WatchlistService';

  WatchlistServiceBase() {
    $addMethod($grpc.ServiceMethod<$33.CreateWatchlistRequest,
            $33.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.CreateWatchlistRequest.fromBuffer(value),
        ($33.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetUserWatchlistsRequest,
            $33.GetUserWatchlistsResponse>(
        'GetUserWatchlists',
        getUserWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetUserWatchlistsRequest.fromBuffer(value),
        ($33.GetUserWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$33.GetWatchlistRequest, $33.GetWatchlistResponse>(
            'GetWatchlist',
            getWatchlist_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $33.GetWatchlistRequest.fromBuffer(value),
            ($33.GetWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.UpdateWatchlistRequest,
            $33.UpdateWatchlistResponse>(
        'UpdateWatchlist',
        updateWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.UpdateWatchlistRequest.fromBuffer(value),
        ($33.UpdateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.DeleteWatchlistRequest,
            $33.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.DeleteWatchlistRequest.fromBuffer(value),
        ($33.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.AddStockToWatchlistRequest,
            $33.AddStockToWatchlistResponse>(
        'AddStockToWatchlist',
        addStockToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.AddStockToWatchlistRequest.fromBuffer(value),
        ($33.AddStockToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.RemoveStockFromWatchlistRequest,
            $33.RemoveStockFromWatchlistResponse>(
        'RemoveStockFromWatchlist',
        removeStockFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.RemoveStockFromWatchlistRequest.fromBuffer(value),
        ($33.RemoveStockFromWatchlistResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.CreateWatchlistResponse> createWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$33.GetUserWatchlistsResponse> getUserWatchlists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetUserWatchlistsRequest> request) async {
    return getUserWatchlists(call, await request);
  }

  $async.Future<$33.GetWatchlistResponse> getWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetWatchlistRequest> request) async {
    return getWatchlist(call, await request);
  }

  $async.Future<$33.UpdateWatchlistResponse> updateWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.UpdateWatchlistRequest> request) async {
    return updateWatchlist(call, await request);
  }

  $async.Future<$33.DeleteWatchlistResponse> deleteWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$33.AddStockToWatchlistResponse> addStockToWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.AddStockToWatchlistRequest> request) async {
    return addStockToWatchlist(call, await request);
  }

  $async.Future<$33.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist_Pre($grpc.ServiceCall call,
          $async.Future<$33.RemoveStockFromWatchlistRequest> request) async {
    return removeStockFromWatchlist(call, await request);
  }

  $async.Future<$33.CreateWatchlistResponse> createWatchlist(
      $grpc.ServiceCall call, $33.CreateWatchlistRequest request);
  $async.Future<$33.GetUserWatchlistsResponse> getUserWatchlists(
      $grpc.ServiceCall call, $33.GetUserWatchlistsRequest request);
  $async.Future<$33.GetWatchlistResponse> getWatchlist(
      $grpc.ServiceCall call, $33.GetWatchlistRequest request);
  $async.Future<$33.UpdateWatchlistResponse> updateWatchlist(
      $grpc.ServiceCall call, $33.UpdateWatchlistRequest request);
  $async.Future<$33.DeleteWatchlistResponse> deleteWatchlist(
      $grpc.ServiceCall call, $33.DeleteWatchlistRequest request);
  $async.Future<$33.AddStockToWatchlistResponse> addStockToWatchlist(
      $grpc.ServiceCall call, $33.AddStockToWatchlistRequest request);
  $async.Future<$33.RemoveStockFromWatchlistResponse> removeStockFromWatchlist(
      $grpc.ServiceCall call, $33.RemoveStockFromWatchlistRequest request);
}
