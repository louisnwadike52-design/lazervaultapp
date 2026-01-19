///
//  Generated code. Do not modify.
//  source: stocks/stock.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'stock.pb.dart' as $35;
export 'stock.pb.dart';

class StockServiceClient extends $grpc.Client {
  static final _$getStocks =
      $grpc.ClientMethod<$35.GetStocksRequest, $35.GetStocksResponse>(
          '/stockspb.StockService/GetStocks',
          ($35.GetStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetStocksResponse.fromBuffer(value));
  static final _$getStock =
      $grpc.ClientMethod<$35.GetStockRequest, $35.GetStockResponse>(
          '/stockspb.StockService/GetStock',
          ($35.GetStockRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetStockResponse.fromBuffer(value));
  static final _$searchStocks =
      $grpc.ClientMethod<$35.SearchStocksRequest, $35.SearchStocksResponse>(
          '/stockspb.StockService/SearchStocks',
          ($35.SearchStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.SearchStocksResponse.fromBuffer(value));
  static final _$getStockPriceHistory = $grpc.ClientMethod<
          $35.GetStockPriceHistoryRequest, $35.GetStockPriceHistoryResponse>(
      '/stockspb.StockService/GetStockPriceHistory',
      ($35.GetStockPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetStockPriceHistoryResponse.fromBuffer(value));
  static final _$getMarketIndices = $grpc.ClientMethod<
          $35.GetMarketIndicesRequest, $35.GetMarketIndicesResponse>(
      '/stockspb.StockService/GetMarketIndices',
      ($35.GetMarketIndicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetMarketIndicesResponse.fromBuffer(value));
  static final _$getTrendingStocks = $grpc.ClientMethod<
          $35.GetTrendingStocksRequest, $35.GetTrendingStocksResponse>(
      '/stockspb.StockService/GetTrendingStocks',
      ($35.GetTrendingStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetTrendingStocksResponse.fromBuffer(value));
  static final _$getTopGainers =
      $grpc.ClientMethod<$35.GetTopGainersRequest, $35.GetTopGainersResponse>(
          '/stockspb.StockService/GetTopGainers',
          ($35.GetTopGainersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetTopGainersResponse.fromBuffer(value));
  static final _$getTopLosers =
      $grpc.ClientMethod<$35.GetTopLosersRequest, $35.GetTopLosersResponse>(
          '/stockspb.StockService/GetTopLosers',
          ($35.GetTopLosersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetTopLosersResponse.fromBuffer(value));

  StockServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$35.GetStocksResponse> getStocks(
      $35.GetStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStocks, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetStockResponse> getStock(
      $35.GetStockRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStock, request, options: options);
  }

  $grpc.ResponseFuture<$35.SearchStocksResponse> searchStocks(
      $35.SearchStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStocks, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetStockPriceHistoryResponse> getStockPriceHistory(
      $35.GetStockPriceHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetMarketIndicesResponse> getMarketIndices(
      $35.GetMarketIndicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketIndices, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetTrendingStocksResponse> getTrendingStocks(
      $35.GetTrendingStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingStocks, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetTopGainersResponse> getTopGainers(
      $35.GetTopGainersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopGainers, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetTopLosersResponse> getTopLosers(
      $35.GetTopLosersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopLosers, request, options: options);
  }
}

abstract class StockServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StockService';

  StockServiceBase() {
    $addMethod($grpc.ServiceMethod<$35.GetStocksRequest, $35.GetStocksResponse>(
        'GetStocks',
        getStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.GetStocksRequest.fromBuffer(value),
        ($35.GetStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetStockRequest, $35.GetStockResponse>(
        'GetStock',
        getStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.GetStockRequest.fromBuffer(value),
        ($35.GetStockResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.SearchStocksRequest, $35.SearchStocksResponse>(
            'SearchStocks',
            searchStocks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.SearchStocksRequest.fromBuffer(value),
            ($35.SearchStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetStockPriceHistoryRequest,
            $35.GetStockPriceHistoryResponse>(
        'GetStockPriceHistory',
        getStockPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetStockPriceHistoryRequest.fromBuffer(value),
        ($35.GetStockPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetMarketIndicesRequest,
            $35.GetMarketIndicesResponse>(
        'GetMarketIndices',
        getMarketIndices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetMarketIndicesRequest.fromBuffer(value),
        ($35.GetMarketIndicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTrendingStocksRequest,
            $35.GetTrendingStocksResponse>(
        'GetTrendingStocks',
        getTrendingStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetTrendingStocksRequest.fromBuffer(value),
        ($35.GetTrendingStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetTopGainersRequest,
            $35.GetTopGainersResponse>(
        'GetTopGainers',
        getTopGainers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetTopGainersRequest.fromBuffer(value),
        ($35.GetTopGainersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.GetTopLosersRequest, $35.GetTopLosersResponse>(
            'GetTopLosers',
            getTopLosers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.GetTopLosersRequest.fromBuffer(value),
            ($35.GetTopLosersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$35.GetStocksResponse> getStocks_Pre($grpc.ServiceCall call,
      $async.Future<$35.GetStocksRequest> request) async {
    return getStocks(call, await request);
  }

  $async.Future<$35.GetStockResponse> getStock_Pre($grpc.ServiceCall call,
      $async.Future<$35.GetStockRequest> request) async {
    return getStock(call, await request);
  }

  $async.Future<$35.SearchStocksResponse> searchStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.SearchStocksRequest> request) async {
    return searchStocks(call, await request);
  }

  $async.Future<$35.GetStockPriceHistoryResponse> getStockPriceHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetStockPriceHistoryRequest> request) async {
    return getStockPriceHistory(call, await request);
  }

  $async.Future<$35.GetMarketIndicesResponse> getMarketIndices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetMarketIndicesRequest> request) async {
    return getMarketIndices(call, await request);
  }

  $async.Future<$35.GetTrendingStocksResponse> getTrendingStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetTrendingStocksRequest> request) async {
    return getTrendingStocks(call, await request);
  }

  $async.Future<$35.GetTopGainersResponse> getTopGainers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetTopGainersRequest> request) async {
    return getTopGainers(call, await request);
  }

  $async.Future<$35.GetTopLosersResponse> getTopLosers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetTopLosersRequest> request) async {
    return getTopLosers(call, await request);
  }

  $async.Future<$35.GetStocksResponse> getStocks(
      $grpc.ServiceCall call, $35.GetStocksRequest request);
  $async.Future<$35.GetStockResponse> getStock(
      $grpc.ServiceCall call, $35.GetStockRequest request);
  $async.Future<$35.SearchStocksResponse> searchStocks(
      $grpc.ServiceCall call, $35.SearchStocksRequest request);
  $async.Future<$35.GetStockPriceHistoryResponse> getStockPriceHistory(
      $grpc.ServiceCall call, $35.GetStockPriceHistoryRequest request);
  $async.Future<$35.GetMarketIndicesResponse> getMarketIndices(
      $grpc.ServiceCall call, $35.GetMarketIndicesRequest request);
  $async.Future<$35.GetTrendingStocksResponse> getTrendingStocks(
      $grpc.ServiceCall call, $35.GetTrendingStocksRequest request);
  $async.Future<$35.GetTopGainersResponse> getTopGainers(
      $grpc.ServiceCall call, $35.GetTopGainersRequest request);
  $async.Future<$35.GetTopLosersResponse> getTopLosers(
      $grpc.ServiceCall call, $35.GetTopLosersRequest request);
}

class StocksPortfolioServiceClient extends $grpc.Client {
  static final _$getUserPortfolio = $grpc.ClientMethod<
          $35.GetUserPortfolioRequest, $35.GetUserPortfolioResponse>(
      '/stockspb.StocksPortfolioService/GetUserPortfolio',
      ($35.GetUserPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetUserPortfolioResponse.fromBuffer(value));
  static final _$getPortfolioHoldings = $grpc.ClientMethod<
          $35.GetPortfolioHoldingsRequest, $35.GetPortfolioHoldingsResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioHoldings',
      ($35.GetPortfolioHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetPortfolioHoldingsResponse.fromBuffer(value));
  static final _$getPortfolioPerformance = $grpc.ClientMethod<
          $35.GetPortfolioPerformanceRequest,
          $35.GetPortfolioPerformanceResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioPerformance',
      ($35.GetPortfolioPerformanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetPortfolioPerformanceResponse.fromBuffer(value));
  static final _$updatePortfolioCash = $grpc.ClientMethod<
          $35.UpdatePortfolioCashRequest, $35.UpdatePortfolioCashResponse>(
      '/stockspb.StocksPortfolioService/UpdatePortfolioCash',
      ($35.UpdatePortfolioCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.UpdatePortfolioCashResponse.fromBuffer(value));

  StocksPortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$35.GetUserPortfolioResponse> getUserPortfolio(
      $35.GetUserPortfolioRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $35.GetPortfolioHoldingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetPortfolioPerformanceResponse>
      getPortfolioPerformance($35.GetPortfolioPerformanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioPerformance, request,
        options: options);
  }

  $grpc.ResponseFuture<$35.UpdatePortfolioCashResponse> updatePortfolioCash(
      $35.UpdatePortfolioCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePortfolioCash, request, options: options);
  }
}

abstract class StocksPortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StocksPortfolioService';

  StocksPortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$35.GetUserPortfolioRequest,
            $35.GetUserPortfolioResponse>(
        'GetUserPortfolio',
        getUserPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetUserPortfolioRequest.fromBuffer(value),
        ($35.GetUserPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetPortfolioHoldingsRequest,
            $35.GetPortfolioHoldingsResponse>(
        'GetPortfolioHoldings',
        getPortfolioHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetPortfolioHoldingsRequest.fromBuffer(value),
        ($35.GetPortfolioHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetPortfolioPerformanceRequest,
            $35.GetPortfolioPerformanceResponse>(
        'GetPortfolioPerformance',
        getPortfolioPerformance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetPortfolioPerformanceRequest.fromBuffer(value),
        ($35.GetPortfolioPerformanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.UpdatePortfolioCashRequest,
            $35.UpdatePortfolioCashResponse>(
        'UpdatePortfolioCash',
        updatePortfolioCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.UpdatePortfolioCashRequest.fromBuffer(value),
        ($35.UpdatePortfolioCashResponse value) => value.writeToBuffer()));
  }

  $async.Future<$35.GetUserPortfolioResponse> getUserPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetUserPortfolioRequest> request) async {
    return getUserPortfolio(call, await request);
  }

  $async.Future<$35.GetPortfolioHoldingsResponse> getPortfolioHoldings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetPortfolioHoldingsRequest> request) async {
    return getPortfolioHoldings(call, await request);
  }

  $async.Future<$35.GetPortfolioPerformanceResponse>
      getPortfolioPerformance_Pre($grpc.ServiceCall call,
          $async.Future<$35.GetPortfolioPerformanceRequest> request) async {
    return getPortfolioPerformance(call, await request);
  }

  $async.Future<$35.UpdatePortfolioCashResponse> updatePortfolioCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.UpdatePortfolioCashRequest> request) async {
    return updatePortfolioCash(call, await request);
  }

  $async.Future<$35.GetUserPortfolioResponse> getUserPortfolio(
      $grpc.ServiceCall call, $35.GetUserPortfolioRequest request);
  $async.Future<$35.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $grpc.ServiceCall call, $35.GetPortfolioHoldingsRequest request);
  $async.Future<$35.GetPortfolioPerformanceResponse> getPortfolioPerformance(
      $grpc.ServiceCall call, $35.GetPortfolioPerformanceRequest request);
  $async.Future<$35.UpdatePortfolioCashResponse> updatePortfolioCash(
      $grpc.ServiceCall call, $35.UpdatePortfolioCashRequest request);
}

class OrderServiceClient extends $grpc.Client {
  static final _$placeOrder =
      $grpc.ClientMethod<$35.PlaceOrderRequest, $35.PlaceOrderResponse>(
          '/stockspb.OrderService/PlaceOrder',
          ($35.PlaceOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.PlaceOrderResponse.fromBuffer(value));
  static final _$getUserOrders =
      $grpc.ClientMethod<$35.GetUserOrdersRequest, $35.GetUserOrdersResponse>(
          '/stockspb.OrderService/GetUserOrders',
          ($35.GetUserOrdersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetUserOrdersResponse.fromBuffer(value));
  static final _$getOrder =
      $grpc.ClientMethod<$35.GetOrderRequest, $35.GetOrderResponse>(
          '/stockspb.OrderService/GetOrder',
          ($35.GetOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetOrderResponse.fromBuffer(value));
  static final _$cancelOrder =
      $grpc.ClientMethod<$35.CancelOrderRequest, $35.CancelOrderResponse>(
          '/stockspb.OrderService/CancelOrder',
          ($35.CancelOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.CancelOrderResponse.fromBuffer(value));
  static final _$getOrderHistory = $grpc.ClientMethod<
          $35.GetOrderHistoryRequest, $35.GetOrderHistoryResponse>(
      '/stockspb.OrderService/GetOrderHistory',
      ($35.GetOrderHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetOrderHistoryResponse.fromBuffer(value));

  OrderServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$35.PlaceOrderResponse> placeOrder(
      $35.PlaceOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$placeOrder, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetUserOrdersResponse> getUserOrders(
      $35.GetUserOrdersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserOrders, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetOrderResponse> getOrder(
      $35.GetOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrder, request, options: options);
  }

  $grpc.ResponseFuture<$35.CancelOrderResponse> cancelOrder(
      $35.CancelOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelOrder, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetOrderHistoryResponse> getOrderHistory(
      $35.GetOrderHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderHistory, request, options: options);
  }
}

abstract class OrderServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.OrderService';

  OrderServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$35.PlaceOrderRequest, $35.PlaceOrderResponse>(
            'PlaceOrder',
            placeOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.PlaceOrderRequest.fromBuffer(value),
            ($35.PlaceOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetUserOrdersRequest,
            $35.GetUserOrdersResponse>(
        'GetUserOrders',
        getUserOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetUserOrdersRequest.fromBuffer(value),
        ($35.GetUserOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetOrderRequest, $35.GetOrderResponse>(
        'GetOrder',
        getOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $35.GetOrderRequest.fromBuffer(value),
        ($35.GetOrderResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.CancelOrderRequest, $35.CancelOrderResponse>(
            'CancelOrder',
            cancelOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.CancelOrderRequest.fromBuffer(value),
            ($35.CancelOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetOrderHistoryRequest,
            $35.GetOrderHistoryResponse>(
        'GetOrderHistory',
        getOrderHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetOrderHistoryRequest.fromBuffer(value),
        ($35.GetOrderHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$35.PlaceOrderResponse> placeOrder_Pre($grpc.ServiceCall call,
      $async.Future<$35.PlaceOrderRequest> request) async {
    return placeOrder(call, await request);
  }

  $async.Future<$35.GetUserOrdersResponse> getUserOrders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetUserOrdersRequest> request) async {
    return getUserOrders(call, await request);
  }

  $async.Future<$35.GetOrderResponse> getOrder_Pre($grpc.ServiceCall call,
      $async.Future<$35.GetOrderRequest> request) async {
    return getOrder(call, await request);
  }

  $async.Future<$35.CancelOrderResponse> cancelOrder_Pre($grpc.ServiceCall call,
      $async.Future<$35.CancelOrderRequest> request) async {
    return cancelOrder(call, await request);
  }

  $async.Future<$35.GetOrderHistoryResponse> getOrderHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetOrderHistoryRequest> request) async {
    return getOrderHistory(call, await request);
  }

  $async.Future<$35.PlaceOrderResponse> placeOrder(
      $grpc.ServiceCall call, $35.PlaceOrderRequest request);
  $async.Future<$35.GetUserOrdersResponse> getUserOrders(
      $grpc.ServiceCall call, $35.GetUserOrdersRequest request);
  $async.Future<$35.GetOrderResponse> getOrder(
      $grpc.ServiceCall call, $35.GetOrderRequest request);
  $async.Future<$35.CancelOrderResponse> cancelOrder(
      $grpc.ServiceCall call, $35.CancelOrderRequest request);
  $async.Future<$35.GetOrderHistoryResponse> getOrderHistory(
      $grpc.ServiceCall call, $35.GetOrderHistoryRequest request);
}

class WatchlistServiceClient extends $grpc.Client {
  static final _$createWatchlist = $grpc.ClientMethod<
          $35.CreateWatchlistRequest, $35.CreateWatchlistResponse>(
      '/stockspb.WatchlistService/CreateWatchlist',
      ($35.CreateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.CreateWatchlistResponse.fromBuffer(value));
  static final _$getUserWatchlists = $grpc.ClientMethod<
          $35.GetUserWatchlistsRequest, $35.GetUserWatchlistsResponse>(
      '/stockspb.WatchlistService/GetUserWatchlists',
      ($35.GetUserWatchlistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.GetUserWatchlistsResponse.fromBuffer(value));
  static final _$getWatchlist =
      $grpc.ClientMethod<$35.GetWatchlistRequest, $35.GetWatchlistResponse>(
          '/stockspb.WatchlistService/GetWatchlist',
          ($35.GetWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $35.GetWatchlistResponse.fromBuffer(value));
  static final _$updateWatchlist = $grpc.ClientMethod<
          $35.UpdateWatchlistRequest, $35.UpdateWatchlistResponse>(
      '/stockspb.WatchlistService/UpdateWatchlist',
      ($35.UpdateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.UpdateWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist = $grpc.ClientMethod<
          $35.DeleteWatchlistRequest, $35.DeleteWatchlistResponse>(
      '/stockspb.WatchlistService/DeleteWatchlist',
      ($35.DeleteWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.DeleteWatchlistResponse.fromBuffer(value));
  static final _$addStockToWatchlist = $grpc.ClientMethod<
          $35.AddStockToWatchlistRequest, $35.AddStockToWatchlistResponse>(
      '/stockspb.WatchlistService/AddStockToWatchlist',
      ($35.AddStockToWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.AddStockToWatchlistResponse.fromBuffer(value));
  static final _$removeStockFromWatchlist = $grpc.ClientMethod<
          $35.RemoveStockFromWatchlistRequest,
          $35.RemoveStockFromWatchlistResponse>(
      '/stockspb.WatchlistService/RemoveStockFromWatchlist',
      ($35.RemoveStockFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $35.RemoveStockFromWatchlistResponse.fromBuffer(value));

  WatchlistServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$35.CreateWatchlistResponse> createWatchlist(
      $35.CreateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetUserWatchlistsResponse> getUserWatchlists(
      $35.GetUserWatchlistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$35.GetWatchlistResponse> getWatchlist(
      $35.GetWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$35.UpdateWatchlistResponse> updateWatchlist(
      $35.UpdateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$35.DeleteWatchlistResponse> deleteWatchlist(
      $35.DeleteWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$35.AddStockToWatchlistResponse> addStockToWatchlist(
      $35.AddStockToWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addStockToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$35.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist($35.RemoveStockFromWatchlistRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeStockFromWatchlist, request,
        options: options);
  }
}

abstract class WatchlistServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.WatchlistService';

  WatchlistServiceBase() {
    $addMethod($grpc.ServiceMethod<$35.CreateWatchlistRequest,
            $35.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.CreateWatchlistRequest.fromBuffer(value),
        ($35.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.GetUserWatchlistsRequest,
            $35.GetUserWatchlistsResponse>(
        'GetUserWatchlists',
        getUserWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.GetUserWatchlistsRequest.fromBuffer(value),
        ($35.GetUserWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$35.GetWatchlistRequest, $35.GetWatchlistResponse>(
            'GetWatchlist',
            getWatchlist_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $35.GetWatchlistRequest.fromBuffer(value),
            ($35.GetWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.UpdateWatchlistRequest,
            $35.UpdateWatchlistResponse>(
        'UpdateWatchlist',
        updateWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.UpdateWatchlistRequest.fromBuffer(value),
        ($35.UpdateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.DeleteWatchlistRequest,
            $35.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.DeleteWatchlistRequest.fromBuffer(value),
        ($35.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.AddStockToWatchlistRequest,
            $35.AddStockToWatchlistResponse>(
        'AddStockToWatchlist',
        addStockToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.AddStockToWatchlistRequest.fromBuffer(value),
        ($35.AddStockToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$35.RemoveStockFromWatchlistRequest,
            $35.RemoveStockFromWatchlistResponse>(
        'RemoveStockFromWatchlist',
        removeStockFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $35.RemoveStockFromWatchlistRequest.fromBuffer(value),
        ($35.RemoveStockFromWatchlistResponse value) => value.writeToBuffer()));
  }

  $async.Future<$35.CreateWatchlistResponse> createWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$35.GetUserWatchlistsResponse> getUserWatchlists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetUserWatchlistsRequest> request) async {
    return getUserWatchlists(call, await request);
  }

  $async.Future<$35.GetWatchlistResponse> getWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.GetWatchlistRequest> request) async {
    return getWatchlist(call, await request);
  }

  $async.Future<$35.UpdateWatchlistResponse> updateWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.UpdateWatchlistRequest> request) async {
    return updateWatchlist(call, await request);
  }

  $async.Future<$35.DeleteWatchlistResponse> deleteWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$35.AddStockToWatchlistResponse> addStockToWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$35.AddStockToWatchlistRequest> request) async {
    return addStockToWatchlist(call, await request);
  }

  $async.Future<$35.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist_Pre($grpc.ServiceCall call,
          $async.Future<$35.RemoveStockFromWatchlistRequest> request) async {
    return removeStockFromWatchlist(call, await request);
  }

  $async.Future<$35.CreateWatchlistResponse> createWatchlist(
      $grpc.ServiceCall call, $35.CreateWatchlistRequest request);
  $async.Future<$35.GetUserWatchlistsResponse> getUserWatchlists(
      $grpc.ServiceCall call, $35.GetUserWatchlistsRequest request);
  $async.Future<$35.GetWatchlistResponse> getWatchlist(
      $grpc.ServiceCall call, $35.GetWatchlistRequest request);
  $async.Future<$35.UpdateWatchlistResponse> updateWatchlist(
      $grpc.ServiceCall call, $35.UpdateWatchlistRequest request);
  $async.Future<$35.DeleteWatchlistResponse> deleteWatchlist(
      $grpc.ServiceCall call, $35.DeleteWatchlistRequest request);
  $async.Future<$35.AddStockToWatchlistResponse> addStockToWatchlist(
      $grpc.ServiceCall call, $35.AddStockToWatchlistRequest request);
  $async.Future<$35.RemoveStockFromWatchlistResponse> removeStockFromWatchlist(
      $grpc.ServiceCall call, $35.RemoveStockFromWatchlistRequest request);
}
