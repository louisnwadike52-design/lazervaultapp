///
//  Generated code. Do not modify.
//  source: stocks/stock.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'stock.pb.dart' as $34;
export 'stock.pb.dart';

class StockServiceClient extends $grpc.Client {
  static final _$getStocks =
      $grpc.ClientMethod<$34.GetStocksRequest, $34.GetStocksResponse>(
          '/stockspb.StockService/GetStocks',
          ($34.GetStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetStocksResponse.fromBuffer(value));
  static final _$getStock =
      $grpc.ClientMethod<$34.GetStockRequest, $34.GetStockResponse>(
          '/stockspb.StockService/GetStock',
          ($34.GetStockRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetStockResponse.fromBuffer(value));
  static final _$searchStocks =
      $grpc.ClientMethod<$34.SearchStocksRequest, $34.SearchStocksResponse>(
          '/stockspb.StockService/SearchStocks',
          ($34.SearchStocksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.SearchStocksResponse.fromBuffer(value));
  static final _$getStockPriceHistory = $grpc.ClientMethod<
          $34.GetStockPriceHistoryRequest, $34.GetStockPriceHistoryResponse>(
      '/stockspb.StockService/GetStockPriceHistory',
      ($34.GetStockPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetStockPriceHistoryResponse.fromBuffer(value));
  static final _$getMarketIndices = $grpc.ClientMethod<
          $34.GetMarketIndicesRequest, $34.GetMarketIndicesResponse>(
      '/stockspb.StockService/GetMarketIndices',
      ($34.GetMarketIndicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetMarketIndicesResponse.fromBuffer(value));
  static final _$getTrendingStocks = $grpc.ClientMethod<
          $34.GetTrendingStocksRequest, $34.GetTrendingStocksResponse>(
      '/stockspb.StockService/GetTrendingStocks',
      ($34.GetTrendingStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetTrendingStocksResponse.fromBuffer(value));
  static final _$getTopGainers =
      $grpc.ClientMethod<$34.GetTopGainersRequest, $34.GetTopGainersResponse>(
          '/stockspb.StockService/GetTopGainers',
          ($34.GetTopGainersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetTopGainersResponse.fromBuffer(value));
  static final _$getTopLosers =
      $grpc.ClientMethod<$34.GetTopLosersRequest, $34.GetTopLosersResponse>(
          '/stockspb.StockService/GetTopLosers',
          ($34.GetTopLosersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetTopLosersResponse.fromBuffer(value));

  StockServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$34.GetStocksResponse> getStocks(
      $34.GetStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStocks, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetStockResponse> getStock(
      $34.GetStockRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStock, request, options: options);
  }

  $grpc.ResponseFuture<$34.SearchStocksResponse> searchStocks(
      $34.SearchStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStocks, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetStockPriceHistoryResponse> getStockPriceHistory(
      $34.GetStockPriceHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetMarketIndicesResponse> getMarketIndices(
      $34.GetMarketIndicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketIndices, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetTrendingStocksResponse> getTrendingStocks(
      $34.GetTrendingStocksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingStocks, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetTopGainersResponse> getTopGainers(
      $34.GetTopGainersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopGainers, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetTopLosersResponse> getTopLosers(
      $34.GetTopLosersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopLosers, request, options: options);
  }
}

abstract class StockServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StockService';

  StockServiceBase() {
    $addMethod($grpc.ServiceMethod<$34.GetStocksRequest, $34.GetStocksResponse>(
        'GetStocks',
        getStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $34.GetStocksRequest.fromBuffer(value),
        ($34.GetStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetStockRequest, $34.GetStockResponse>(
        'GetStock',
        getStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $34.GetStockRequest.fromBuffer(value),
        ($34.GetStockResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.SearchStocksRequest, $34.SearchStocksResponse>(
            'SearchStocks',
            searchStocks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.SearchStocksRequest.fromBuffer(value),
            ($34.SearchStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetStockPriceHistoryRequest,
            $34.GetStockPriceHistoryResponse>(
        'GetStockPriceHistory',
        getStockPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetStockPriceHistoryRequest.fromBuffer(value),
        ($34.GetStockPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetMarketIndicesRequest,
            $34.GetMarketIndicesResponse>(
        'GetMarketIndices',
        getMarketIndices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetMarketIndicesRequest.fromBuffer(value),
        ($34.GetMarketIndicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetTrendingStocksRequest,
            $34.GetTrendingStocksResponse>(
        'GetTrendingStocks',
        getTrendingStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetTrendingStocksRequest.fromBuffer(value),
        ($34.GetTrendingStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetTopGainersRequest,
            $34.GetTopGainersResponse>(
        'GetTopGainers',
        getTopGainers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetTopGainersRequest.fromBuffer(value),
        ($34.GetTopGainersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.GetTopLosersRequest, $34.GetTopLosersResponse>(
            'GetTopLosers',
            getTopLosers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.GetTopLosersRequest.fromBuffer(value),
            ($34.GetTopLosersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$34.GetStocksResponse> getStocks_Pre($grpc.ServiceCall call,
      $async.Future<$34.GetStocksRequest> request) async {
    return getStocks(call, await request);
  }

  $async.Future<$34.GetStockResponse> getStock_Pre($grpc.ServiceCall call,
      $async.Future<$34.GetStockRequest> request) async {
    return getStock(call, await request);
  }

  $async.Future<$34.SearchStocksResponse> searchStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.SearchStocksRequest> request) async {
    return searchStocks(call, await request);
  }

  $async.Future<$34.GetStockPriceHistoryResponse> getStockPriceHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetStockPriceHistoryRequest> request) async {
    return getStockPriceHistory(call, await request);
  }

  $async.Future<$34.GetMarketIndicesResponse> getMarketIndices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetMarketIndicesRequest> request) async {
    return getMarketIndices(call, await request);
  }

  $async.Future<$34.GetTrendingStocksResponse> getTrendingStocks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetTrendingStocksRequest> request) async {
    return getTrendingStocks(call, await request);
  }

  $async.Future<$34.GetTopGainersResponse> getTopGainers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetTopGainersRequest> request) async {
    return getTopGainers(call, await request);
  }

  $async.Future<$34.GetTopLosersResponse> getTopLosers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetTopLosersRequest> request) async {
    return getTopLosers(call, await request);
  }

  $async.Future<$34.GetStocksResponse> getStocks(
      $grpc.ServiceCall call, $34.GetStocksRequest request);
  $async.Future<$34.GetStockResponse> getStock(
      $grpc.ServiceCall call, $34.GetStockRequest request);
  $async.Future<$34.SearchStocksResponse> searchStocks(
      $grpc.ServiceCall call, $34.SearchStocksRequest request);
  $async.Future<$34.GetStockPriceHistoryResponse> getStockPriceHistory(
      $grpc.ServiceCall call, $34.GetStockPriceHistoryRequest request);
  $async.Future<$34.GetMarketIndicesResponse> getMarketIndices(
      $grpc.ServiceCall call, $34.GetMarketIndicesRequest request);
  $async.Future<$34.GetTrendingStocksResponse> getTrendingStocks(
      $grpc.ServiceCall call, $34.GetTrendingStocksRequest request);
  $async.Future<$34.GetTopGainersResponse> getTopGainers(
      $grpc.ServiceCall call, $34.GetTopGainersRequest request);
  $async.Future<$34.GetTopLosersResponse> getTopLosers(
      $grpc.ServiceCall call, $34.GetTopLosersRequest request);
}

class StocksPortfolioServiceClient extends $grpc.Client {
  static final _$getUserPortfolio = $grpc.ClientMethod<
          $34.GetUserPortfolioRequest, $34.GetUserPortfolioResponse>(
      '/stockspb.StocksPortfolioService/GetUserPortfolio',
      ($34.GetUserPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetUserPortfolioResponse.fromBuffer(value));
  static final _$getPortfolioHoldings = $grpc.ClientMethod<
          $34.GetPortfolioHoldingsRequest, $34.GetPortfolioHoldingsResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioHoldings',
      ($34.GetPortfolioHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetPortfolioHoldingsResponse.fromBuffer(value));
  static final _$getPortfolioPerformance = $grpc.ClientMethod<
          $34.GetPortfolioPerformanceRequest,
          $34.GetPortfolioPerformanceResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioPerformance',
      ($34.GetPortfolioPerformanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetPortfolioPerformanceResponse.fromBuffer(value));
  static final _$updatePortfolioCash = $grpc.ClientMethod<
          $34.UpdatePortfolioCashRequest, $34.UpdatePortfolioCashResponse>(
      '/stockspb.StocksPortfolioService/UpdatePortfolioCash',
      ($34.UpdatePortfolioCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.UpdatePortfolioCashResponse.fromBuffer(value));

  StocksPortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$34.GetUserPortfolioResponse> getUserPortfolio(
      $34.GetUserPortfolioRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $34.GetPortfolioHoldingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetPortfolioPerformanceResponse>
      getPortfolioPerformance($34.GetPortfolioPerformanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioPerformance, request,
        options: options);
  }

  $grpc.ResponseFuture<$34.UpdatePortfolioCashResponse> updatePortfolioCash(
      $34.UpdatePortfolioCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePortfolioCash, request, options: options);
  }
}

abstract class StocksPortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StocksPortfolioService';

  StocksPortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$34.GetUserPortfolioRequest,
            $34.GetUserPortfolioResponse>(
        'GetUserPortfolio',
        getUserPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetUserPortfolioRequest.fromBuffer(value),
        ($34.GetUserPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetPortfolioHoldingsRequest,
            $34.GetPortfolioHoldingsResponse>(
        'GetPortfolioHoldings',
        getPortfolioHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetPortfolioHoldingsRequest.fromBuffer(value),
        ($34.GetPortfolioHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetPortfolioPerformanceRequest,
            $34.GetPortfolioPerformanceResponse>(
        'GetPortfolioPerformance',
        getPortfolioPerformance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetPortfolioPerformanceRequest.fromBuffer(value),
        ($34.GetPortfolioPerformanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.UpdatePortfolioCashRequest,
            $34.UpdatePortfolioCashResponse>(
        'UpdatePortfolioCash',
        updatePortfolioCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.UpdatePortfolioCashRequest.fromBuffer(value),
        ($34.UpdatePortfolioCashResponse value) => value.writeToBuffer()));
  }

  $async.Future<$34.GetUserPortfolioResponse> getUserPortfolio_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetUserPortfolioRequest> request) async {
    return getUserPortfolio(call, await request);
  }

  $async.Future<$34.GetPortfolioHoldingsResponse> getPortfolioHoldings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetPortfolioHoldingsRequest> request) async {
    return getPortfolioHoldings(call, await request);
  }

  $async.Future<$34.GetPortfolioPerformanceResponse>
      getPortfolioPerformance_Pre($grpc.ServiceCall call,
          $async.Future<$34.GetPortfolioPerformanceRequest> request) async {
    return getPortfolioPerformance(call, await request);
  }

  $async.Future<$34.UpdatePortfolioCashResponse> updatePortfolioCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.UpdatePortfolioCashRequest> request) async {
    return updatePortfolioCash(call, await request);
  }

  $async.Future<$34.GetUserPortfolioResponse> getUserPortfolio(
      $grpc.ServiceCall call, $34.GetUserPortfolioRequest request);
  $async.Future<$34.GetPortfolioHoldingsResponse> getPortfolioHoldings(
      $grpc.ServiceCall call, $34.GetPortfolioHoldingsRequest request);
  $async.Future<$34.GetPortfolioPerformanceResponse> getPortfolioPerformance(
      $grpc.ServiceCall call, $34.GetPortfolioPerformanceRequest request);
  $async.Future<$34.UpdatePortfolioCashResponse> updatePortfolioCash(
      $grpc.ServiceCall call, $34.UpdatePortfolioCashRequest request);
}

class OrderServiceClient extends $grpc.Client {
  static final _$placeOrder =
      $grpc.ClientMethod<$34.PlaceOrderRequest, $34.PlaceOrderResponse>(
          '/stockspb.OrderService/PlaceOrder',
          ($34.PlaceOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.PlaceOrderResponse.fromBuffer(value));
  static final _$getUserOrders =
      $grpc.ClientMethod<$34.GetUserOrdersRequest, $34.GetUserOrdersResponse>(
          '/stockspb.OrderService/GetUserOrders',
          ($34.GetUserOrdersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetUserOrdersResponse.fromBuffer(value));
  static final _$getOrder =
      $grpc.ClientMethod<$34.GetOrderRequest, $34.GetOrderResponse>(
          '/stockspb.OrderService/GetOrder',
          ($34.GetOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetOrderResponse.fromBuffer(value));
  static final _$cancelOrder =
      $grpc.ClientMethod<$34.CancelOrderRequest, $34.CancelOrderResponse>(
          '/stockspb.OrderService/CancelOrder',
          ($34.CancelOrderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.CancelOrderResponse.fromBuffer(value));
  static final _$getOrderHistory = $grpc.ClientMethod<
          $34.GetOrderHistoryRequest, $34.GetOrderHistoryResponse>(
      '/stockspb.OrderService/GetOrderHistory',
      ($34.GetOrderHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetOrderHistoryResponse.fromBuffer(value));

  OrderServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$34.PlaceOrderResponse> placeOrder(
      $34.PlaceOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$placeOrder, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetUserOrdersResponse> getUserOrders(
      $34.GetUserOrdersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserOrders, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetOrderResponse> getOrder(
      $34.GetOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrder, request, options: options);
  }

  $grpc.ResponseFuture<$34.CancelOrderResponse> cancelOrder(
      $34.CancelOrderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelOrder, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetOrderHistoryResponse> getOrderHistory(
      $34.GetOrderHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderHistory, request, options: options);
  }
}

abstract class OrderServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.OrderService';

  OrderServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$34.PlaceOrderRequest, $34.PlaceOrderResponse>(
            'PlaceOrder',
            placeOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.PlaceOrderRequest.fromBuffer(value),
            ($34.PlaceOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetUserOrdersRequest,
            $34.GetUserOrdersResponse>(
        'GetUserOrders',
        getUserOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetUserOrdersRequest.fromBuffer(value),
        ($34.GetUserOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetOrderRequest, $34.GetOrderResponse>(
        'GetOrder',
        getOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $34.GetOrderRequest.fromBuffer(value),
        ($34.GetOrderResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.CancelOrderRequest, $34.CancelOrderResponse>(
            'CancelOrder',
            cancelOrder_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.CancelOrderRequest.fromBuffer(value),
            ($34.CancelOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetOrderHistoryRequest,
            $34.GetOrderHistoryResponse>(
        'GetOrderHistory',
        getOrderHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetOrderHistoryRequest.fromBuffer(value),
        ($34.GetOrderHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$34.PlaceOrderResponse> placeOrder_Pre($grpc.ServiceCall call,
      $async.Future<$34.PlaceOrderRequest> request) async {
    return placeOrder(call, await request);
  }

  $async.Future<$34.GetUserOrdersResponse> getUserOrders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetUserOrdersRequest> request) async {
    return getUserOrders(call, await request);
  }

  $async.Future<$34.GetOrderResponse> getOrder_Pre($grpc.ServiceCall call,
      $async.Future<$34.GetOrderRequest> request) async {
    return getOrder(call, await request);
  }

  $async.Future<$34.CancelOrderResponse> cancelOrder_Pre($grpc.ServiceCall call,
      $async.Future<$34.CancelOrderRequest> request) async {
    return cancelOrder(call, await request);
  }

  $async.Future<$34.GetOrderHistoryResponse> getOrderHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetOrderHistoryRequest> request) async {
    return getOrderHistory(call, await request);
  }

  $async.Future<$34.PlaceOrderResponse> placeOrder(
      $grpc.ServiceCall call, $34.PlaceOrderRequest request);
  $async.Future<$34.GetUserOrdersResponse> getUserOrders(
      $grpc.ServiceCall call, $34.GetUserOrdersRequest request);
  $async.Future<$34.GetOrderResponse> getOrder(
      $grpc.ServiceCall call, $34.GetOrderRequest request);
  $async.Future<$34.CancelOrderResponse> cancelOrder(
      $grpc.ServiceCall call, $34.CancelOrderRequest request);
  $async.Future<$34.GetOrderHistoryResponse> getOrderHistory(
      $grpc.ServiceCall call, $34.GetOrderHistoryRequest request);
}

class WatchlistServiceClient extends $grpc.Client {
  static final _$createWatchlist = $grpc.ClientMethod<
          $34.CreateWatchlistRequest, $34.CreateWatchlistResponse>(
      '/stockspb.WatchlistService/CreateWatchlist',
      ($34.CreateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.CreateWatchlistResponse.fromBuffer(value));
  static final _$getUserWatchlists = $grpc.ClientMethod<
          $34.GetUserWatchlistsRequest, $34.GetUserWatchlistsResponse>(
      '/stockspb.WatchlistService/GetUserWatchlists',
      ($34.GetUserWatchlistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.GetUserWatchlistsResponse.fromBuffer(value));
  static final _$getWatchlist =
      $grpc.ClientMethod<$34.GetWatchlistRequest, $34.GetWatchlistResponse>(
          '/stockspb.WatchlistService/GetWatchlist',
          ($34.GetWatchlistRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $34.GetWatchlistResponse.fromBuffer(value));
  static final _$updateWatchlist = $grpc.ClientMethod<
          $34.UpdateWatchlistRequest, $34.UpdateWatchlistResponse>(
      '/stockspb.WatchlistService/UpdateWatchlist',
      ($34.UpdateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.UpdateWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist = $grpc.ClientMethod<
          $34.DeleteWatchlistRequest, $34.DeleteWatchlistResponse>(
      '/stockspb.WatchlistService/DeleteWatchlist',
      ($34.DeleteWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.DeleteWatchlistResponse.fromBuffer(value));
  static final _$addStockToWatchlist = $grpc.ClientMethod<
          $34.AddStockToWatchlistRequest, $34.AddStockToWatchlistResponse>(
      '/stockspb.WatchlistService/AddStockToWatchlist',
      ($34.AddStockToWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.AddStockToWatchlistResponse.fromBuffer(value));
  static final _$removeStockFromWatchlist = $grpc.ClientMethod<
          $34.RemoveStockFromWatchlistRequest,
          $34.RemoveStockFromWatchlistResponse>(
      '/stockspb.WatchlistService/RemoveStockFromWatchlist',
      ($34.RemoveStockFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $34.RemoveStockFromWatchlistResponse.fromBuffer(value));

  WatchlistServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$34.CreateWatchlistResponse> createWatchlist(
      $34.CreateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetUserWatchlistsResponse> getUserWatchlists(
      $34.GetUserWatchlistsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$34.GetWatchlistResponse> getWatchlist(
      $34.GetWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$34.UpdateWatchlistResponse> updateWatchlist(
      $34.UpdateWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$34.DeleteWatchlistResponse> deleteWatchlist(
      $34.DeleteWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$34.AddStockToWatchlistResponse> addStockToWatchlist(
      $34.AddStockToWatchlistRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addStockToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$34.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist($34.RemoveStockFromWatchlistRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeStockFromWatchlist, request,
        options: options);
  }
}

abstract class WatchlistServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.WatchlistService';

  WatchlistServiceBase() {
    $addMethod($grpc.ServiceMethod<$34.CreateWatchlistRequest,
            $34.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.CreateWatchlistRequest.fromBuffer(value),
        ($34.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.GetUserWatchlistsRequest,
            $34.GetUserWatchlistsResponse>(
        'GetUserWatchlists',
        getUserWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.GetUserWatchlistsRequest.fromBuffer(value),
        ($34.GetUserWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$34.GetWatchlistRequest, $34.GetWatchlistResponse>(
            'GetWatchlist',
            getWatchlist_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $34.GetWatchlistRequest.fromBuffer(value),
            ($34.GetWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.UpdateWatchlistRequest,
            $34.UpdateWatchlistResponse>(
        'UpdateWatchlist',
        updateWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.UpdateWatchlistRequest.fromBuffer(value),
        ($34.UpdateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.DeleteWatchlistRequest,
            $34.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.DeleteWatchlistRequest.fromBuffer(value),
        ($34.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.AddStockToWatchlistRequest,
            $34.AddStockToWatchlistResponse>(
        'AddStockToWatchlist',
        addStockToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.AddStockToWatchlistRequest.fromBuffer(value),
        ($34.AddStockToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$34.RemoveStockFromWatchlistRequest,
            $34.RemoveStockFromWatchlistResponse>(
        'RemoveStockFromWatchlist',
        removeStockFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $34.RemoveStockFromWatchlistRequest.fromBuffer(value),
        ($34.RemoveStockFromWatchlistResponse value) => value.writeToBuffer()));
  }

  $async.Future<$34.CreateWatchlistResponse> createWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$34.GetUserWatchlistsResponse> getUserWatchlists_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetUserWatchlistsRequest> request) async {
    return getUserWatchlists(call, await request);
  }

  $async.Future<$34.GetWatchlistResponse> getWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.GetWatchlistRequest> request) async {
    return getWatchlist(call, await request);
  }

  $async.Future<$34.UpdateWatchlistResponse> updateWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.UpdateWatchlistRequest> request) async {
    return updateWatchlist(call, await request);
  }

  $async.Future<$34.DeleteWatchlistResponse> deleteWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$34.AddStockToWatchlistResponse> addStockToWatchlist_Pre(
      $grpc.ServiceCall call,
      $async.Future<$34.AddStockToWatchlistRequest> request) async {
    return addStockToWatchlist(call, await request);
  }

  $async.Future<$34.RemoveStockFromWatchlistResponse>
      removeStockFromWatchlist_Pre($grpc.ServiceCall call,
          $async.Future<$34.RemoveStockFromWatchlistRequest> request) async {
    return removeStockFromWatchlist(call, await request);
  }

  $async.Future<$34.CreateWatchlistResponse> createWatchlist(
      $grpc.ServiceCall call, $34.CreateWatchlistRequest request);
  $async.Future<$34.GetUserWatchlistsResponse> getUserWatchlists(
      $grpc.ServiceCall call, $34.GetUserWatchlistsRequest request);
  $async.Future<$34.GetWatchlistResponse> getWatchlist(
      $grpc.ServiceCall call, $34.GetWatchlistRequest request);
  $async.Future<$34.UpdateWatchlistResponse> updateWatchlist(
      $grpc.ServiceCall call, $34.UpdateWatchlistRequest request);
  $async.Future<$34.DeleteWatchlistResponse> deleteWatchlist(
      $grpc.ServiceCall call, $34.DeleteWatchlistRequest request);
  $async.Future<$34.AddStockToWatchlistResponse> addStockToWatchlist(
      $grpc.ServiceCall call, $34.AddStockToWatchlistRequest request);
  $async.Future<$34.RemoveStockFromWatchlistResponse> removeStockFromWatchlist(
      $grpc.ServiceCall call, $34.RemoveStockFromWatchlistRequest request);
}
