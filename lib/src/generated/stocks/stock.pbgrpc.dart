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

import 'stock.pb.dart' as $42;

export 'stock.pb.dart';

@$pb.GrpcServiceName('stockspb.StockService')
class StockServiceClient extends $grpc.Client {
  static final _$getStocks = $grpc.ClientMethod<$42.GetStocksRequest, $42.GetStocksResponse>(
      '/stockspb.StockService/GetStocks',
      ($42.GetStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetStocksResponse.fromBuffer(value));
  static final _$getStock = $grpc.ClientMethod<$42.GetStockRequest, $42.GetStockResponse>(
      '/stockspb.StockService/GetStock',
      ($42.GetStockRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetStockResponse.fromBuffer(value));
  static final _$searchStocks = $grpc.ClientMethod<$42.SearchStocksRequest, $42.SearchStocksResponse>(
      '/stockspb.StockService/SearchStocks',
      ($42.SearchStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.SearchStocksResponse.fromBuffer(value));
  static final _$getStockPriceHistory = $grpc.ClientMethod<$42.GetStockPriceHistoryRequest, $42.GetStockPriceHistoryResponse>(
      '/stockspb.StockService/GetStockPriceHistory',
      ($42.GetStockPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetStockPriceHistoryResponse.fromBuffer(value));
  static final _$getMarketIndices = $grpc.ClientMethod<$42.GetMarketIndicesRequest, $42.GetMarketIndicesResponse>(
      '/stockspb.StockService/GetMarketIndices',
      ($42.GetMarketIndicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetMarketIndicesResponse.fromBuffer(value));
  static final _$getTrendingStocks = $grpc.ClientMethod<$42.GetTrendingStocksRequest, $42.GetTrendingStocksResponse>(
      '/stockspb.StockService/GetTrendingStocks',
      ($42.GetTrendingStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetTrendingStocksResponse.fromBuffer(value));
  static final _$getTopGainers = $grpc.ClientMethod<$42.GetTopGainersRequest, $42.GetTopGainersResponse>(
      '/stockspb.StockService/GetTopGainers',
      ($42.GetTopGainersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetTopGainersResponse.fromBuffer(value));
  static final _$getTopLosers = $grpc.ClientMethod<$42.GetTopLosersRequest, $42.GetTopLosersResponse>(
      '/stockspb.StockService/GetTopLosers',
      ($42.GetTopLosersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetTopLosersResponse.fromBuffer(value));

  StockServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$42.GetStocksResponse> getStocks($42.GetStocksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStocks, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetStockResponse> getStock($42.GetStockRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStock, request, options: options);
  }

  $grpc.ResponseFuture<$42.SearchStocksResponse> searchStocks($42.SearchStocksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStocks, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetStockPriceHistoryResponse> getStockPriceHistory($42.GetStockPriceHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetMarketIndicesResponse> getMarketIndices($42.GetMarketIndicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketIndices, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetTrendingStocksResponse> getTrendingStocks($42.GetTrendingStocksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrendingStocks, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetTopGainersResponse> getTopGainers($42.GetTopGainersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopGainers, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetTopLosersResponse> getTopLosers($42.GetTopLosersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopLosers, request, options: options);
  }
}

@$pb.GrpcServiceName('stockspb.StockService')
abstract class StockServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StockService';

  StockServiceBase() {
    $addMethod($grpc.ServiceMethod<$42.GetStocksRequest, $42.GetStocksResponse>(
        'GetStocks',
        getStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetStocksRequest.fromBuffer(value),
        ($42.GetStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetStockRequest, $42.GetStockResponse>(
        'GetStock',
        getStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetStockRequest.fromBuffer(value),
        ($42.GetStockResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.SearchStocksRequest, $42.SearchStocksResponse>(
        'SearchStocks',
        searchStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.SearchStocksRequest.fromBuffer(value),
        ($42.SearchStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetStockPriceHistoryRequest, $42.GetStockPriceHistoryResponse>(
        'GetStockPriceHistory',
        getStockPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetStockPriceHistoryRequest.fromBuffer(value),
        ($42.GetStockPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetMarketIndicesRequest, $42.GetMarketIndicesResponse>(
        'GetMarketIndices',
        getMarketIndices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetMarketIndicesRequest.fromBuffer(value),
        ($42.GetMarketIndicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetTrendingStocksRequest, $42.GetTrendingStocksResponse>(
        'GetTrendingStocks',
        getTrendingStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetTrendingStocksRequest.fromBuffer(value),
        ($42.GetTrendingStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetTopGainersRequest, $42.GetTopGainersResponse>(
        'GetTopGainers',
        getTopGainers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetTopGainersRequest.fromBuffer(value),
        ($42.GetTopGainersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetTopLosersRequest, $42.GetTopLosersResponse>(
        'GetTopLosers',
        getTopLosers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetTopLosersRequest.fromBuffer(value),
        ($42.GetTopLosersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$42.GetStocksResponse> getStocks_Pre($grpc.ServiceCall call, $async.Future<$42.GetStocksRequest> request) async {
    return getStocks(call, await request);
  }

  $async.Future<$42.GetStockResponse> getStock_Pre($grpc.ServiceCall call, $async.Future<$42.GetStockRequest> request) async {
    return getStock(call, await request);
  }

  $async.Future<$42.SearchStocksResponse> searchStocks_Pre($grpc.ServiceCall call, $async.Future<$42.SearchStocksRequest> request) async {
    return searchStocks(call, await request);
  }

  $async.Future<$42.GetStockPriceHistoryResponse> getStockPriceHistory_Pre($grpc.ServiceCall call, $async.Future<$42.GetStockPriceHistoryRequest> request) async {
    return getStockPriceHistory(call, await request);
  }

  $async.Future<$42.GetMarketIndicesResponse> getMarketIndices_Pre($grpc.ServiceCall call, $async.Future<$42.GetMarketIndicesRequest> request) async {
    return getMarketIndices(call, await request);
  }

  $async.Future<$42.GetTrendingStocksResponse> getTrendingStocks_Pre($grpc.ServiceCall call, $async.Future<$42.GetTrendingStocksRequest> request) async {
    return getTrendingStocks(call, await request);
  }

  $async.Future<$42.GetTopGainersResponse> getTopGainers_Pre($grpc.ServiceCall call, $async.Future<$42.GetTopGainersRequest> request) async {
    return getTopGainers(call, await request);
  }

  $async.Future<$42.GetTopLosersResponse> getTopLosers_Pre($grpc.ServiceCall call, $async.Future<$42.GetTopLosersRequest> request) async {
    return getTopLosers(call, await request);
  }

  $async.Future<$42.GetStocksResponse> getStocks($grpc.ServiceCall call, $42.GetStocksRequest request);
  $async.Future<$42.GetStockResponse> getStock($grpc.ServiceCall call, $42.GetStockRequest request);
  $async.Future<$42.SearchStocksResponse> searchStocks($grpc.ServiceCall call, $42.SearchStocksRequest request);
  $async.Future<$42.GetStockPriceHistoryResponse> getStockPriceHistory($grpc.ServiceCall call, $42.GetStockPriceHistoryRequest request);
  $async.Future<$42.GetMarketIndicesResponse> getMarketIndices($grpc.ServiceCall call, $42.GetMarketIndicesRequest request);
  $async.Future<$42.GetTrendingStocksResponse> getTrendingStocks($grpc.ServiceCall call, $42.GetTrendingStocksRequest request);
  $async.Future<$42.GetTopGainersResponse> getTopGainers($grpc.ServiceCall call, $42.GetTopGainersRequest request);
  $async.Future<$42.GetTopLosersResponse> getTopLosers($grpc.ServiceCall call, $42.GetTopLosersRequest request);
}
@$pb.GrpcServiceName('stockspb.StocksPortfolioService')
class StocksPortfolioServiceClient extends $grpc.Client {
  static final _$getUserPortfolio = $grpc.ClientMethod<$42.GetUserPortfolioRequest, $42.GetUserPortfolioResponse>(
      '/stockspb.StocksPortfolioService/GetUserPortfolio',
      ($42.GetUserPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetUserPortfolioResponse.fromBuffer(value));
  static final _$getPortfolioHoldings = $grpc.ClientMethod<$42.GetPortfolioHoldingsRequest, $42.GetPortfolioHoldingsResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioHoldings',
      ($42.GetPortfolioHoldingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetPortfolioHoldingsResponse.fromBuffer(value));
  static final _$getPortfolioPerformance = $grpc.ClientMethod<$42.GetPortfolioPerformanceRequest, $42.GetPortfolioPerformanceResponse>(
      '/stockspb.StocksPortfolioService/GetPortfolioPerformance',
      ($42.GetPortfolioPerformanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetPortfolioPerformanceResponse.fromBuffer(value));
  static final _$updatePortfolioCash = $grpc.ClientMethod<$42.UpdatePortfolioCashRequest, $42.UpdatePortfolioCashResponse>(
      '/stockspb.StocksPortfolioService/UpdatePortfolioCash',
      ($42.UpdatePortfolioCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.UpdatePortfolioCashResponse.fromBuffer(value));

  StocksPortfolioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$42.GetUserPortfolioResponse> getUserPortfolio($42.GetUserPortfolioRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetPortfolioHoldingsResponse> getPortfolioHoldings($42.GetPortfolioHoldingsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioHoldings, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetPortfolioPerformanceResponse> getPortfolioPerformance($42.GetPortfolioPerformanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolioPerformance, request, options: options);
  }

  $grpc.ResponseFuture<$42.UpdatePortfolioCashResponse> updatePortfolioCash($42.UpdatePortfolioCashRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePortfolioCash, request, options: options);
  }
}

@$pb.GrpcServiceName('stockspb.StocksPortfolioService')
abstract class StocksPortfolioServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.StocksPortfolioService';

  StocksPortfolioServiceBase() {
    $addMethod($grpc.ServiceMethod<$42.GetUserPortfolioRequest, $42.GetUserPortfolioResponse>(
        'GetUserPortfolio',
        getUserPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetUserPortfolioRequest.fromBuffer(value),
        ($42.GetUserPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetPortfolioHoldingsRequest, $42.GetPortfolioHoldingsResponse>(
        'GetPortfolioHoldings',
        getPortfolioHoldings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetPortfolioHoldingsRequest.fromBuffer(value),
        ($42.GetPortfolioHoldingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetPortfolioPerformanceRequest, $42.GetPortfolioPerformanceResponse>(
        'GetPortfolioPerformance',
        getPortfolioPerformance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetPortfolioPerformanceRequest.fromBuffer(value),
        ($42.GetPortfolioPerformanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UpdatePortfolioCashRequest, $42.UpdatePortfolioCashResponse>(
        'UpdatePortfolioCash',
        updatePortfolioCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.UpdatePortfolioCashRequest.fromBuffer(value),
        ($42.UpdatePortfolioCashResponse value) => value.writeToBuffer()));
  }

  $async.Future<$42.GetUserPortfolioResponse> getUserPortfolio_Pre($grpc.ServiceCall call, $async.Future<$42.GetUserPortfolioRequest> request) async {
    return getUserPortfolio(call, await request);
  }

  $async.Future<$42.GetPortfolioHoldingsResponse> getPortfolioHoldings_Pre($grpc.ServiceCall call, $async.Future<$42.GetPortfolioHoldingsRequest> request) async {
    return getPortfolioHoldings(call, await request);
  }

  $async.Future<$42.GetPortfolioPerformanceResponse> getPortfolioPerformance_Pre($grpc.ServiceCall call, $async.Future<$42.GetPortfolioPerformanceRequest> request) async {
    return getPortfolioPerformance(call, await request);
  }

  $async.Future<$42.UpdatePortfolioCashResponse> updatePortfolioCash_Pre($grpc.ServiceCall call, $async.Future<$42.UpdatePortfolioCashRequest> request) async {
    return updatePortfolioCash(call, await request);
  }

  $async.Future<$42.GetUserPortfolioResponse> getUserPortfolio($grpc.ServiceCall call, $42.GetUserPortfolioRequest request);
  $async.Future<$42.GetPortfolioHoldingsResponse> getPortfolioHoldings($grpc.ServiceCall call, $42.GetPortfolioHoldingsRequest request);
  $async.Future<$42.GetPortfolioPerformanceResponse> getPortfolioPerformance($grpc.ServiceCall call, $42.GetPortfolioPerformanceRequest request);
  $async.Future<$42.UpdatePortfolioCashResponse> updatePortfolioCash($grpc.ServiceCall call, $42.UpdatePortfolioCashRequest request);
}
@$pb.GrpcServiceName('stockspb.OrderService')
class OrderServiceClient extends $grpc.Client {
  static final _$placeOrder = $grpc.ClientMethod<$42.PlaceOrderRequest, $42.PlaceOrderResponse>(
      '/stockspb.OrderService/PlaceOrder',
      ($42.PlaceOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.PlaceOrderResponse.fromBuffer(value));
  static final _$getUserOrders = $grpc.ClientMethod<$42.GetUserOrdersRequest, $42.GetUserOrdersResponse>(
      '/stockspb.OrderService/GetUserOrders',
      ($42.GetUserOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetUserOrdersResponse.fromBuffer(value));
  static final _$getOrder = $grpc.ClientMethod<$42.GetOrderRequest, $42.GetOrderResponse>(
      '/stockspb.OrderService/GetOrder',
      ($42.GetOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetOrderResponse.fromBuffer(value));
  static final _$cancelOrder = $grpc.ClientMethod<$42.CancelOrderRequest, $42.CancelOrderResponse>(
      '/stockspb.OrderService/CancelOrder',
      ($42.CancelOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.CancelOrderResponse.fromBuffer(value));
  static final _$getOrderHistory = $grpc.ClientMethod<$42.GetOrderHistoryRequest, $42.GetOrderHistoryResponse>(
      '/stockspb.OrderService/GetOrderHistory',
      ($42.GetOrderHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetOrderHistoryResponse.fromBuffer(value));

  OrderServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$42.PlaceOrderResponse> placeOrder($42.PlaceOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$placeOrder, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetUserOrdersResponse> getUserOrders($42.GetUserOrdersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserOrders, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetOrderResponse> getOrder($42.GetOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrder, request, options: options);
  }

  $grpc.ResponseFuture<$42.CancelOrderResponse> cancelOrder($42.CancelOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelOrder, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetOrderHistoryResponse> getOrderHistory($42.GetOrderHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('stockspb.OrderService')
abstract class OrderServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.OrderService';

  OrderServiceBase() {
    $addMethod($grpc.ServiceMethod<$42.PlaceOrderRequest, $42.PlaceOrderResponse>(
        'PlaceOrder',
        placeOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.PlaceOrderRequest.fromBuffer(value),
        ($42.PlaceOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetUserOrdersRequest, $42.GetUserOrdersResponse>(
        'GetUserOrders',
        getUserOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetUserOrdersRequest.fromBuffer(value),
        ($42.GetUserOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetOrderRequest, $42.GetOrderResponse>(
        'GetOrder',
        getOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetOrderRequest.fromBuffer(value),
        ($42.GetOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.CancelOrderRequest, $42.CancelOrderResponse>(
        'CancelOrder',
        cancelOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.CancelOrderRequest.fromBuffer(value),
        ($42.CancelOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetOrderHistoryRequest, $42.GetOrderHistoryResponse>(
        'GetOrderHistory',
        getOrderHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetOrderHistoryRequest.fromBuffer(value),
        ($42.GetOrderHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$42.PlaceOrderResponse> placeOrder_Pre($grpc.ServiceCall call, $async.Future<$42.PlaceOrderRequest> request) async {
    return placeOrder(call, await request);
  }

  $async.Future<$42.GetUserOrdersResponse> getUserOrders_Pre($grpc.ServiceCall call, $async.Future<$42.GetUserOrdersRequest> request) async {
    return getUserOrders(call, await request);
  }

  $async.Future<$42.GetOrderResponse> getOrder_Pre($grpc.ServiceCall call, $async.Future<$42.GetOrderRequest> request) async {
    return getOrder(call, await request);
  }

  $async.Future<$42.CancelOrderResponse> cancelOrder_Pre($grpc.ServiceCall call, $async.Future<$42.CancelOrderRequest> request) async {
    return cancelOrder(call, await request);
  }

  $async.Future<$42.GetOrderHistoryResponse> getOrderHistory_Pre($grpc.ServiceCall call, $async.Future<$42.GetOrderHistoryRequest> request) async {
    return getOrderHistory(call, await request);
  }

  $async.Future<$42.PlaceOrderResponse> placeOrder($grpc.ServiceCall call, $42.PlaceOrderRequest request);
  $async.Future<$42.GetUserOrdersResponse> getUserOrders($grpc.ServiceCall call, $42.GetUserOrdersRequest request);
  $async.Future<$42.GetOrderResponse> getOrder($grpc.ServiceCall call, $42.GetOrderRequest request);
  $async.Future<$42.CancelOrderResponse> cancelOrder($grpc.ServiceCall call, $42.CancelOrderRequest request);
  $async.Future<$42.GetOrderHistoryResponse> getOrderHistory($grpc.ServiceCall call, $42.GetOrderHistoryRequest request);
}
@$pb.GrpcServiceName('stockspb.WatchlistService')
class WatchlistServiceClient extends $grpc.Client {
  static final _$createWatchlist = $grpc.ClientMethod<$42.CreateWatchlistRequest, $42.CreateWatchlistResponse>(
      '/stockspb.WatchlistService/CreateWatchlist',
      ($42.CreateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.CreateWatchlistResponse.fromBuffer(value));
  static final _$getUserWatchlists = $grpc.ClientMethod<$42.GetUserWatchlistsRequest, $42.GetUserWatchlistsResponse>(
      '/stockspb.WatchlistService/GetUserWatchlists',
      ($42.GetUserWatchlistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetUserWatchlistsResponse.fromBuffer(value));
  static final _$getWatchlist = $grpc.ClientMethod<$42.GetWatchlistRequest, $42.GetWatchlistResponse>(
      '/stockspb.WatchlistService/GetWatchlist',
      ($42.GetWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.GetWatchlistResponse.fromBuffer(value));
  static final _$updateWatchlist = $grpc.ClientMethod<$42.UpdateWatchlistRequest, $42.UpdateWatchlistResponse>(
      '/stockspb.WatchlistService/UpdateWatchlist',
      ($42.UpdateWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.UpdateWatchlistResponse.fromBuffer(value));
  static final _$deleteWatchlist = $grpc.ClientMethod<$42.DeleteWatchlistRequest, $42.DeleteWatchlistResponse>(
      '/stockspb.WatchlistService/DeleteWatchlist',
      ($42.DeleteWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.DeleteWatchlistResponse.fromBuffer(value));
  static final _$addStockToWatchlist = $grpc.ClientMethod<$42.AddStockToWatchlistRequest, $42.AddStockToWatchlistResponse>(
      '/stockspb.WatchlistService/AddStockToWatchlist',
      ($42.AddStockToWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.AddStockToWatchlistResponse.fromBuffer(value));
  static final _$removeStockFromWatchlist = $grpc.ClientMethod<$42.RemoveStockFromWatchlistRequest, $42.RemoveStockFromWatchlistResponse>(
      '/stockspb.WatchlistService/RemoveStockFromWatchlist',
      ($42.RemoveStockFromWatchlistRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $42.RemoveStockFromWatchlistResponse.fromBuffer(value));

  WatchlistServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$42.CreateWatchlistResponse> createWatchlist($42.CreateWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetUserWatchlistsResponse> getUserWatchlists($42.GetUserWatchlistsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserWatchlists, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetWatchlistResponse> getWatchlist($42.GetWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$42.UpdateWatchlistResponse> updateWatchlist($42.UpdateWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$42.DeleteWatchlistResponse> deleteWatchlist($42.DeleteWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$42.AddStockToWatchlistResponse> addStockToWatchlist($42.AddStockToWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addStockToWatchlist, request, options: options);
  }

  $grpc.ResponseFuture<$42.RemoveStockFromWatchlistResponse> removeStockFromWatchlist($42.RemoveStockFromWatchlistRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeStockFromWatchlist, request, options: options);
  }
}

@$pb.GrpcServiceName('stockspb.WatchlistService')
abstract class WatchlistServiceBase extends $grpc.Service {
  $core.String get $name => 'stockspb.WatchlistService';

  WatchlistServiceBase() {
    $addMethod($grpc.ServiceMethod<$42.CreateWatchlistRequest, $42.CreateWatchlistResponse>(
        'CreateWatchlist',
        createWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.CreateWatchlistRequest.fromBuffer(value),
        ($42.CreateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetUserWatchlistsRequest, $42.GetUserWatchlistsResponse>(
        'GetUserWatchlists',
        getUserWatchlists_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetUserWatchlistsRequest.fromBuffer(value),
        ($42.GetUserWatchlistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetWatchlistRequest, $42.GetWatchlistResponse>(
        'GetWatchlist',
        getWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.GetWatchlistRequest.fromBuffer(value),
        ($42.GetWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UpdateWatchlistRequest, $42.UpdateWatchlistResponse>(
        'UpdateWatchlist',
        updateWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.UpdateWatchlistRequest.fromBuffer(value),
        ($42.UpdateWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.DeleteWatchlistRequest, $42.DeleteWatchlistResponse>(
        'DeleteWatchlist',
        deleteWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.DeleteWatchlistRequest.fromBuffer(value),
        ($42.DeleteWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.AddStockToWatchlistRequest, $42.AddStockToWatchlistResponse>(
        'AddStockToWatchlist',
        addStockToWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.AddStockToWatchlistRequest.fromBuffer(value),
        ($42.AddStockToWatchlistResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.RemoveStockFromWatchlistRequest, $42.RemoveStockFromWatchlistResponse>(
        'RemoveStockFromWatchlist',
        removeStockFromWatchlist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.RemoveStockFromWatchlistRequest.fromBuffer(value),
        ($42.RemoveStockFromWatchlistResponse value) => value.writeToBuffer()));
  }

  $async.Future<$42.CreateWatchlistResponse> createWatchlist_Pre($grpc.ServiceCall call, $async.Future<$42.CreateWatchlistRequest> request) async {
    return createWatchlist(call, await request);
  }

  $async.Future<$42.GetUserWatchlistsResponse> getUserWatchlists_Pre($grpc.ServiceCall call, $async.Future<$42.GetUserWatchlistsRequest> request) async {
    return getUserWatchlists(call, await request);
  }

  $async.Future<$42.GetWatchlistResponse> getWatchlist_Pre($grpc.ServiceCall call, $async.Future<$42.GetWatchlistRequest> request) async {
    return getWatchlist(call, await request);
  }

  $async.Future<$42.UpdateWatchlistResponse> updateWatchlist_Pre($grpc.ServiceCall call, $async.Future<$42.UpdateWatchlistRequest> request) async {
    return updateWatchlist(call, await request);
  }

  $async.Future<$42.DeleteWatchlistResponse> deleteWatchlist_Pre($grpc.ServiceCall call, $async.Future<$42.DeleteWatchlistRequest> request) async {
    return deleteWatchlist(call, await request);
  }

  $async.Future<$42.AddStockToWatchlistResponse> addStockToWatchlist_Pre($grpc.ServiceCall call, $async.Future<$42.AddStockToWatchlistRequest> request) async {
    return addStockToWatchlist(call, await request);
  }

  $async.Future<$42.RemoveStockFromWatchlistResponse> removeStockFromWatchlist_Pre($grpc.ServiceCall call, $async.Future<$42.RemoveStockFromWatchlistRequest> request) async {
    return removeStockFromWatchlist(call, await request);
  }

  $async.Future<$42.CreateWatchlistResponse> createWatchlist($grpc.ServiceCall call, $42.CreateWatchlistRequest request);
  $async.Future<$42.GetUserWatchlistsResponse> getUserWatchlists($grpc.ServiceCall call, $42.GetUserWatchlistsRequest request);
  $async.Future<$42.GetWatchlistResponse> getWatchlist($grpc.ServiceCall call, $42.GetWatchlistRequest request);
  $async.Future<$42.UpdateWatchlistResponse> updateWatchlist($grpc.ServiceCall call, $42.UpdateWatchlistRequest request);
  $async.Future<$42.DeleteWatchlistResponse> deleteWatchlist($grpc.ServiceCall call, $42.DeleteWatchlistRequest request);
  $async.Future<$42.AddStockToWatchlistResponse> addStockToWatchlist($grpc.ServiceCall call, $42.AddStockToWatchlistRequest request);
  $async.Future<$42.RemoveStockFromWatchlistResponse> removeStockFromWatchlist($grpc.ServiceCall call, $42.RemoveStockFromWatchlistRequest request);
}
