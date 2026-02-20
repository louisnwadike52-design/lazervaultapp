//
//  Generated code. Do not modify.
//  source: investments.proto
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

import 'investments.pb.dart' as $0;

export 'investments.pb.dart';

@$pb.GrpcServiceName('investments.InvestmentsService')
class InvestmentsServiceClient extends $grpc.Client {
  static final _$createInvestment = $grpc.ClientMethod<$0.CreateInvestmentRequest, $0.CreateInvestmentResponse>(
      '/investments.InvestmentsService/CreateInvestment',
      ($0.CreateInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateInvestmentResponse.fromBuffer(value));
  static final _$getInvestments = $grpc.ClientMethod<$0.GetInvestmentsRequest, $0.GetInvestmentsResponse>(
      '/investments.InvestmentsService/GetInvestments',
      ($0.GetInvestmentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvestmentsResponse.fromBuffer(value));
  static final _$getInvestment = $grpc.ClientMethod<$0.GetInvestmentRequest, $0.GetInvestmentResponse>(
      '/investments.InvestmentsService/GetInvestment',
      ($0.GetInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvestmentResponse.fromBuffer(value));
  static final _$closeInvestment = $grpc.ClientMethod<$0.CloseInvestmentRequest, $0.CloseInvestmentResponse>(
      '/investments.InvestmentsService/CloseInvestment',
      ($0.CloseInvestmentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CloseInvestmentResponse.fromBuffer(value));
  static final _$buyStock = $grpc.ClientMethod<$0.BuyStockRequest, $0.BuyStockResponse>(
      '/investments.InvestmentsService/BuyStock',
      ($0.BuyStockRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BuyStockResponse.fromBuffer(value));
  static final _$sellStock = $grpc.ClientMethod<$0.SellStockRequest, $0.SellStockResponse>(
      '/investments.InvestmentsService/SellStock',
      ($0.SellStockRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SellStockResponse.fromBuffer(value));
  static final _$getStockQuote = $grpc.ClientMethod<$0.GetStockQuoteRequest, $0.GetStockQuoteResponse>(
      '/investments.InvestmentsService/GetStockQuote',
      ($0.GetStockQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetStockQuoteResponse.fromBuffer(value));
  static final _$getStockPortfolio = $grpc.ClientMethod<$0.GetStockPortfolioRequest, $0.GetStockPortfolioResponse>(
      '/investments.InvestmentsService/GetStockPortfolio',
      ($0.GetStockPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetStockPortfolioResponse.fromBuffer(value));
  static final _$buyCrypto = $grpc.ClientMethod<$0.BuyCryptoRequest, $0.BuyCryptoResponse>(
      '/investments.InvestmentsService/BuyCrypto',
      ($0.BuyCryptoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BuyCryptoResponse.fromBuffer(value));
  static final _$sellCrypto = $grpc.ClientMethod<$0.SellCryptoRequest, $0.SellCryptoResponse>(
      '/investments.InvestmentsService/SellCrypto',
      ($0.SellCryptoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SellCryptoResponse.fromBuffer(value));
  static final _$getCryptoPortfolio = $grpc.ClientMethod<$0.GetCryptoPortfolioRequest, $0.GetCryptoPortfolioResponse>(
      '/investments.InvestmentsService/GetCryptoPortfolio',
      ($0.GetCryptoPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCryptoPortfolioResponse.fromBuffer(value));
  static final _$exchangeCurrency = $grpc.ClientMethod<$0.ExchangeCurrencyRequest, $0.ExchangeCurrencyResponse>(
      '/investments.InvestmentsService/ExchangeCurrency',
      ($0.ExchangeCurrencyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ExchangeCurrencyResponse.fromBuffer(value));
  static final _$getExchangeRates = $grpc.ClientMethod<$0.GetExchangeRatesRequest, $0.GetExchangeRatesResponse>(
      '/investments.InvestmentsService/GetExchangeRates',
      ($0.GetExchangeRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetExchangeRatesResponse.fromBuffer(value));
  static final _$getPortfolio = $grpc.ClientMethod<$0.GetPortfolioRequest, $0.GetPortfolioResponse>(
      '/investments.InvestmentsService/GetPortfolio',
      ($0.GetPortfolioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPortfolioResponse.fromBuffer(value));
  static final _$getMarketPrices = $grpc.ClientMethod<$0.GetMarketPricesRequest, $0.GetMarketPricesResponse>(
      '/investments.InvestmentsService/GetMarketPrices',
      ($0.GetMarketPricesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMarketPricesResponse.fromBuffer(value));
  static final _$getInvestmentHistory = $grpc.ClientMethod<$0.GetInvestmentHistoryRequest, $0.GetInvestmentHistoryResponse>(
      '/investments.InvestmentsService/GetInvestmentHistory',
      ($0.GetInvestmentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvestmentHistoryResponse.fromBuffer(value));
  static final _$searchStocks = $grpc.ClientMethod<$0.SearchStocksRequest, $0.SearchStocksResponse>(
      '/investments.InvestmentsService/SearchStocks',
      ($0.SearchStocksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SearchStocksResponse.fromBuffer(value));
  static final _$getStockDetails = $grpc.ClientMethod<$0.GetStockDetailsRequest, $0.GetStockDetailsResponse>(
      '/investments.InvestmentsService/GetStockDetails',
      ($0.GetStockDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetStockDetailsResponse.fromBuffer(value));
  static final _$getStockPriceHistory = $grpc.ClientMethod<$0.GetStockPriceHistoryRequest, $0.GetStockPriceHistoryResponse>(
      '/investments.InvestmentsService/GetStockPriceHistory',
      ($0.GetStockPriceHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetStockPriceHistoryResponse.fromBuffer(value));
  static final _$getTopMovers = $grpc.ClientMethod<$0.GetTopMoversRequest, $0.GetTopMoversResponse>(
      '/investments.InvestmentsService/GetTopMovers',
      ($0.GetTopMoversRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTopMoversResponse.fromBuffer(value));
  static final _$getStockOrders = $grpc.ClientMethod<$0.GetStockOrdersRequest, $0.GetStockOrdersResponse>(
      '/investments.InvestmentsService/GetStockOrders',
      ($0.GetStockOrdersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetStockOrdersResponse.fromBuffer(value));
  static final _$cancelStockOrder = $grpc.ClientMethod<$0.CancelStockOrderRequest, $0.CancelStockOrderResponse>(
      '/investments.InvestmentsService/CancelStockOrder',
      ($0.CancelStockOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CancelStockOrderResponse.fromBuffer(value));
  static final _$getMarketStatus = $grpc.ClientMethod<$0.GetMarketStatusRequest, $0.GetMarketStatusResponse>(
      '/investments.InvestmentsService/GetMarketStatus',
      ($0.GetMarketStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMarketStatusResponse.fromBuffer(value));
  static final _$getMarketNews = $grpc.ClientMethod<$0.GetMarketNewsRequest, $0.GetMarketNewsResponse>(
      '/investments.InvestmentsService/GetMarketNews',
      ($0.GetMarketNewsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMarketNewsResponse.fromBuffer(value));
  static final _$getSectorPerformance = $grpc.ClientMethod<$0.GetSectorPerformanceRequest, $0.GetSectorPerformanceResponse>(
      '/investments.InvestmentsService/GetSectorPerformance',
      ($0.GetSectorPerformanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSectorPerformanceResponse.fromBuffer(value));
  static final _$getEarningsCalendar = $grpc.ClientMethod<$0.GetEarningsCalendarRequest, $0.GetEarningsCalendarResponse>(
      '/investments.InvestmentsService/GetEarningsCalendar',
      ($0.GetEarningsCalendarRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetEarningsCalendarResponse.fromBuffer(value));
  static final _$getDividendCalendar = $grpc.ClientMethod<$0.GetDividendCalendarRequest, $0.GetDividendCalendarResponse>(
      '/investments.InvestmentsService/GetDividendCalendar',
      ($0.GetDividendCalendarRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetDividendCalendarResponse.fromBuffer(value));
  static final _$createPriceAlert = $grpc.ClientMethod<$0.CreatePriceAlertRequest, $0.CreatePriceAlertResponse>(
      '/investments.InvestmentsService/CreatePriceAlert',
      ($0.CreatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreatePriceAlertResponse.fromBuffer(value));
  static final _$getPriceAlerts = $grpc.ClientMethod<$0.GetPriceAlertsRequest, $0.GetPriceAlertsResponse>(
      '/investments.InvestmentsService/GetPriceAlerts',
      ($0.GetPriceAlertsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPriceAlertsResponse.fromBuffer(value));
  static final _$updatePriceAlert = $grpc.ClientMethod<$0.UpdatePriceAlertRequest, $0.UpdatePriceAlertResponse>(
      '/investments.InvestmentsService/UpdatePriceAlert',
      ($0.UpdatePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdatePriceAlertResponse.fromBuffer(value));
  static final _$deletePriceAlert = $grpc.ClientMethod<$0.DeletePriceAlertRequest, $0.DeletePriceAlertResponse>(
      '/investments.InvestmentsService/DeletePriceAlert',
      ($0.DeletePriceAlertRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeletePriceAlertResponse.fromBuffer(value));

  InvestmentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateInvestmentResponse> createInvestment($0.CreateInvestmentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvestmentsResponse> getInvestments($0.GetInvestmentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestments, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvestmentResponse> getInvestment($0.GetInvestmentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$0.CloseInvestmentResponse> closeInvestment($0.CloseInvestmentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeInvestment, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyStockResponse> buyStock($0.BuyStockRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyStock, request, options: options);
  }

  $grpc.ResponseFuture<$0.SellStockResponse> sellStock($0.SellStockRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellStock, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetStockQuoteResponse> getStockQuote($0.GetStockQuoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockQuote, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetStockPortfolioResponse> getStockPortfolio($0.GetStockPortfolioRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyCryptoResponse> buyCrypto($0.BuyCryptoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$0.SellCryptoResponse> sellCrypto($0.SellCryptoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sellCrypto, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCryptoPortfolioResponse> getCryptoPortfolio($0.GetCryptoPortfolioRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptoPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$0.ExchangeCurrencyResponse> exchangeCurrency($0.ExchangeCurrencyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$exchangeCurrency, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetExchangeRatesResponse> getExchangeRates($0.GetExchangeRatesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRates, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPortfolioResponse> getPortfolio($0.GetPortfolioRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPortfolio, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketPricesResponse> getMarketPrices($0.GetMarketPricesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketPrices, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvestmentHistoryResponse> getInvestmentHistory($0.GetInvestmentHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvestmentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchStocksResponse> searchStocks($0.SearchStocksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStocks, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetStockDetailsResponse> getStockDetails($0.GetStockDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetStockPriceHistoryResponse> getStockPriceHistory($0.GetStockPriceHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockPriceHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTopMoversResponse> getTopMovers($0.GetTopMoversRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopMovers, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetStockOrdersResponse> getStockOrders($0.GetStockOrdersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStockOrders, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelStockOrderResponse> cancelStockOrder($0.CancelStockOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelStockOrder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketStatusResponse> getMarketStatus($0.GetMarketStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMarketNewsResponse> getMarketNews($0.GetMarketNewsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMarketNews, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSectorPerformanceResponse> getSectorPerformance($0.GetSectorPerformanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSectorPerformance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetEarningsCalendarResponse> getEarningsCalendar($0.GetEarningsCalendarRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEarningsCalendar, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDividendCalendarResponse> getDividendCalendar($0.GetDividendCalendarRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDividendCalendar, request, options: options);
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

@$pb.GrpcServiceName('investments.InvestmentsService')
abstract class InvestmentsServiceBase extends $grpc.Service {
  $core.String get $name => 'investments.InvestmentsService';

  InvestmentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateInvestmentRequest, $0.CreateInvestmentResponse>(
        'CreateInvestment',
        createInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateInvestmentRequest.fromBuffer(value),
        ($0.CreateInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvestmentsRequest, $0.GetInvestmentsResponse>(
        'GetInvestments',
        getInvestments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvestmentsRequest.fromBuffer(value),
        ($0.GetInvestmentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvestmentRequest, $0.GetInvestmentResponse>(
        'GetInvestment',
        getInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvestmentRequest.fromBuffer(value),
        ($0.GetInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseInvestmentRequest, $0.CloseInvestmentResponse>(
        'CloseInvestment',
        closeInvestment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CloseInvestmentRequest.fromBuffer(value),
        ($0.CloseInvestmentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyStockRequest, $0.BuyStockResponse>(
        'BuyStock',
        buyStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyStockRequest.fromBuffer(value),
        ($0.BuyStockResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SellStockRequest, $0.SellStockResponse>(
        'SellStock',
        sellStock_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SellStockRequest.fromBuffer(value),
        ($0.SellStockResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStockQuoteRequest, $0.GetStockQuoteResponse>(
        'GetStockQuote',
        getStockQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStockQuoteRequest.fromBuffer(value),
        ($0.GetStockQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStockPortfolioRequest, $0.GetStockPortfolioResponse>(
        'GetStockPortfolio',
        getStockPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStockPortfolioRequest.fromBuffer(value),
        ($0.GetStockPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyCryptoRequest, $0.BuyCryptoResponse>(
        'BuyCrypto',
        buyCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyCryptoRequest.fromBuffer(value),
        ($0.BuyCryptoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SellCryptoRequest, $0.SellCryptoResponse>(
        'SellCrypto',
        sellCrypto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SellCryptoRequest.fromBuffer(value),
        ($0.SellCryptoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCryptoPortfolioRequest, $0.GetCryptoPortfolioResponse>(
        'GetCryptoPortfolio',
        getCryptoPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCryptoPortfolioRequest.fromBuffer(value),
        ($0.GetCryptoPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExchangeCurrencyRequest, $0.ExchangeCurrencyResponse>(
        'ExchangeCurrency',
        exchangeCurrency_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExchangeCurrencyRequest.fromBuffer(value),
        ($0.ExchangeCurrencyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetExchangeRatesRequest, $0.GetExchangeRatesResponse>(
        'GetExchangeRates',
        getExchangeRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetExchangeRatesRequest.fromBuffer(value),
        ($0.GetExchangeRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPortfolioRequest, $0.GetPortfolioResponse>(
        'GetPortfolio',
        getPortfolio_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPortfolioRequest.fromBuffer(value),
        ($0.GetPortfolioResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMarketPricesRequest, $0.GetMarketPricesResponse>(
        'GetMarketPrices',
        getMarketPrices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMarketPricesRequest.fromBuffer(value),
        ($0.GetMarketPricesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvestmentHistoryRequest, $0.GetInvestmentHistoryResponse>(
        'GetInvestmentHistory',
        getInvestmentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvestmentHistoryRequest.fromBuffer(value),
        ($0.GetInvestmentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchStocksRequest, $0.SearchStocksResponse>(
        'SearchStocks',
        searchStocks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchStocksRequest.fromBuffer(value),
        ($0.SearchStocksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStockDetailsRequest, $0.GetStockDetailsResponse>(
        'GetStockDetails',
        getStockDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStockDetailsRequest.fromBuffer(value),
        ($0.GetStockDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStockPriceHistoryRequest, $0.GetStockPriceHistoryResponse>(
        'GetStockPriceHistory',
        getStockPriceHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStockPriceHistoryRequest.fromBuffer(value),
        ($0.GetStockPriceHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTopMoversRequest, $0.GetTopMoversResponse>(
        'GetTopMovers',
        getTopMovers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTopMoversRequest.fromBuffer(value),
        ($0.GetTopMoversResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetStockOrdersRequest, $0.GetStockOrdersResponse>(
        'GetStockOrders',
        getStockOrders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStockOrdersRequest.fromBuffer(value),
        ($0.GetStockOrdersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelStockOrderRequest, $0.CancelStockOrderResponse>(
        'CancelStockOrder',
        cancelStockOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelStockOrderRequest.fromBuffer(value),
        ($0.CancelStockOrderResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.GetSectorPerformanceRequest, $0.GetSectorPerformanceResponse>(
        'GetSectorPerformance',
        getSectorPerformance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSectorPerformanceRequest.fromBuffer(value),
        ($0.GetSectorPerformanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEarningsCalendarRequest, $0.GetEarningsCalendarResponse>(
        'GetEarningsCalendar',
        getEarningsCalendar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetEarningsCalendarRequest.fromBuffer(value),
        ($0.GetEarningsCalendarResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDividendCalendarRequest, $0.GetDividendCalendarResponse>(
        'GetDividendCalendar',
        getDividendCalendar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetDividendCalendarRequest.fromBuffer(value),
        ($0.GetDividendCalendarResponse value) => value.writeToBuffer()));
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

  $async.Future<$0.CreateInvestmentResponse> createInvestment_Pre($grpc.ServiceCall call, $async.Future<$0.CreateInvestmentRequest> request) async {
    return createInvestment(call, await request);
  }

  $async.Future<$0.GetInvestmentsResponse> getInvestments_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvestmentsRequest> request) async {
    return getInvestments(call, await request);
  }

  $async.Future<$0.GetInvestmentResponse> getInvestment_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvestmentRequest> request) async {
    return getInvestment(call, await request);
  }

  $async.Future<$0.CloseInvestmentResponse> closeInvestment_Pre($grpc.ServiceCall call, $async.Future<$0.CloseInvestmentRequest> request) async {
    return closeInvestment(call, await request);
  }

  $async.Future<$0.BuyStockResponse> buyStock_Pre($grpc.ServiceCall call, $async.Future<$0.BuyStockRequest> request) async {
    return buyStock(call, await request);
  }

  $async.Future<$0.SellStockResponse> sellStock_Pre($grpc.ServiceCall call, $async.Future<$0.SellStockRequest> request) async {
    return sellStock(call, await request);
  }

  $async.Future<$0.GetStockQuoteResponse> getStockQuote_Pre($grpc.ServiceCall call, $async.Future<$0.GetStockQuoteRequest> request) async {
    return getStockQuote(call, await request);
  }

  $async.Future<$0.GetStockPortfolioResponse> getStockPortfolio_Pre($grpc.ServiceCall call, $async.Future<$0.GetStockPortfolioRequest> request) async {
    return getStockPortfolio(call, await request);
  }

  $async.Future<$0.BuyCryptoResponse> buyCrypto_Pre($grpc.ServiceCall call, $async.Future<$0.BuyCryptoRequest> request) async {
    return buyCrypto(call, await request);
  }

  $async.Future<$0.SellCryptoResponse> sellCrypto_Pre($grpc.ServiceCall call, $async.Future<$0.SellCryptoRequest> request) async {
    return sellCrypto(call, await request);
  }

  $async.Future<$0.GetCryptoPortfolioResponse> getCryptoPortfolio_Pre($grpc.ServiceCall call, $async.Future<$0.GetCryptoPortfolioRequest> request) async {
    return getCryptoPortfolio(call, await request);
  }

  $async.Future<$0.ExchangeCurrencyResponse> exchangeCurrency_Pre($grpc.ServiceCall call, $async.Future<$0.ExchangeCurrencyRequest> request) async {
    return exchangeCurrency(call, await request);
  }

  $async.Future<$0.GetExchangeRatesResponse> getExchangeRates_Pre($grpc.ServiceCall call, $async.Future<$0.GetExchangeRatesRequest> request) async {
    return getExchangeRates(call, await request);
  }

  $async.Future<$0.GetPortfolioResponse> getPortfolio_Pre($grpc.ServiceCall call, $async.Future<$0.GetPortfolioRequest> request) async {
    return getPortfolio(call, await request);
  }

  $async.Future<$0.GetMarketPricesResponse> getMarketPrices_Pre($grpc.ServiceCall call, $async.Future<$0.GetMarketPricesRequest> request) async {
    return getMarketPrices(call, await request);
  }

  $async.Future<$0.GetInvestmentHistoryResponse> getInvestmentHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvestmentHistoryRequest> request) async {
    return getInvestmentHistory(call, await request);
  }

  $async.Future<$0.SearchStocksResponse> searchStocks_Pre($grpc.ServiceCall call, $async.Future<$0.SearchStocksRequest> request) async {
    return searchStocks(call, await request);
  }

  $async.Future<$0.GetStockDetailsResponse> getStockDetails_Pre($grpc.ServiceCall call, $async.Future<$0.GetStockDetailsRequest> request) async {
    return getStockDetails(call, await request);
  }

  $async.Future<$0.GetStockPriceHistoryResponse> getStockPriceHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetStockPriceHistoryRequest> request) async {
    return getStockPriceHistory(call, await request);
  }

  $async.Future<$0.GetTopMoversResponse> getTopMovers_Pre($grpc.ServiceCall call, $async.Future<$0.GetTopMoversRequest> request) async {
    return getTopMovers(call, await request);
  }

  $async.Future<$0.GetStockOrdersResponse> getStockOrders_Pre($grpc.ServiceCall call, $async.Future<$0.GetStockOrdersRequest> request) async {
    return getStockOrders(call, await request);
  }

  $async.Future<$0.CancelStockOrderResponse> cancelStockOrder_Pre($grpc.ServiceCall call, $async.Future<$0.CancelStockOrderRequest> request) async {
    return cancelStockOrder(call, await request);
  }

  $async.Future<$0.GetMarketStatusResponse> getMarketStatus_Pre($grpc.ServiceCall call, $async.Future<$0.GetMarketStatusRequest> request) async {
    return getMarketStatus(call, await request);
  }

  $async.Future<$0.GetMarketNewsResponse> getMarketNews_Pre($grpc.ServiceCall call, $async.Future<$0.GetMarketNewsRequest> request) async {
    return getMarketNews(call, await request);
  }

  $async.Future<$0.GetSectorPerformanceResponse> getSectorPerformance_Pre($grpc.ServiceCall call, $async.Future<$0.GetSectorPerformanceRequest> request) async {
    return getSectorPerformance(call, await request);
  }

  $async.Future<$0.GetEarningsCalendarResponse> getEarningsCalendar_Pre($grpc.ServiceCall call, $async.Future<$0.GetEarningsCalendarRequest> request) async {
    return getEarningsCalendar(call, await request);
  }

  $async.Future<$0.GetDividendCalendarResponse> getDividendCalendar_Pre($grpc.ServiceCall call, $async.Future<$0.GetDividendCalendarRequest> request) async {
    return getDividendCalendar(call, await request);
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

  $async.Future<$0.CreateInvestmentResponse> createInvestment($grpc.ServiceCall call, $0.CreateInvestmentRequest request);
  $async.Future<$0.GetInvestmentsResponse> getInvestments($grpc.ServiceCall call, $0.GetInvestmentsRequest request);
  $async.Future<$0.GetInvestmentResponse> getInvestment($grpc.ServiceCall call, $0.GetInvestmentRequest request);
  $async.Future<$0.CloseInvestmentResponse> closeInvestment($grpc.ServiceCall call, $0.CloseInvestmentRequest request);
  $async.Future<$0.BuyStockResponse> buyStock($grpc.ServiceCall call, $0.BuyStockRequest request);
  $async.Future<$0.SellStockResponse> sellStock($grpc.ServiceCall call, $0.SellStockRequest request);
  $async.Future<$0.GetStockQuoteResponse> getStockQuote($grpc.ServiceCall call, $0.GetStockQuoteRequest request);
  $async.Future<$0.GetStockPortfolioResponse> getStockPortfolio($grpc.ServiceCall call, $0.GetStockPortfolioRequest request);
  $async.Future<$0.BuyCryptoResponse> buyCrypto($grpc.ServiceCall call, $0.BuyCryptoRequest request);
  $async.Future<$0.SellCryptoResponse> sellCrypto($grpc.ServiceCall call, $0.SellCryptoRequest request);
  $async.Future<$0.GetCryptoPortfolioResponse> getCryptoPortfolio($grpc.ServiceCall call, $0.GetCryptoPortfolioRequest request);
  $async.Future<$0.ExchangeCurrencyResponse> exchangeCurrency($grpc.ServiceCall call, $0.ExchangeCurrencyRequest request);
  $async.Future<$0.GetExchangeRatesResponse> getExchangeRates($grpc.ServiceCall call, $0.GetExchangeRatesRequest request);
  $async.Future<$0.GetPortfolioResponse> getPortfolio($grpc.ServiceCall call, $0.GetPortfolioRequest request);
  $async.Future<$0.GetMarketPricesResponse> getMarketPrices($grpc.ServiceCall call, $0.GetMarketPricesRequest request);
  $async.Future<$0.GetInvestmentHistoryResponse> getInvestmentHistory($grpc.ServiceCall call, $0.GetInvestmentHistoryRequest request);
  $async.Future<$0.SearchStocksResponse> searchStocks($grpc.ServiceCall call, $0.SearchStocksRequest request);
  $async.Future<$0.GetStockDetailsResponse> getStockDetails($grpc.ServiceCall call, $0.GetStockDetailsRequest request);
  $async.Future<$0.GetStockPriceHistoryResponse> getStockPriceHistory($grpc.ServiceCall call, $0.GetStockPriceHistoryRequest request);
  $async.Future<$0.GetTopMoversResponse> getTopMovers($grpc.ServiceCall call, $0.GetTopMoversRequest request);
  $async.Future<$0.GetStockOrdersResponse> getStockOrders($grpc.ServiceCall call, $0.GetStockOrdersRequest request);
  $async.Future<$0.CancelStockOrderResponse> cancelStockOrder($grpc.ServiceCall call, $0.CancelStockOrderRequest request);
  $async.Future<$0.GetMarketStatusResponse> getMarketStatus($grpc.ServiceCall call, $0.GetMarketStatusRequest request);
  $async.Future<$0.GetMarketNewsResponse> getMarketNews($grpc.ServiceCall call, $0.GetMarketNewsRequest request);
  $async.Future<$0.GetSectorPerformanceResponse> getSectorPerformance($grpc.ServiceCall call, $0.GetSectorPerformanceRequest request);
  $async.Future<$0.GetEarningsCalendarResponse> getEarningsCalendar($grpc.ServiceCall call, $0.GetEarningsCalendarRequest request);
  $async.Future<$0.GetDividendCalendarResponse> getDividendCalendar($grpc.ServiceCall call, $0.GetDividendCalendarRequest request);
  $async.Future<$0.CreatePriceAlertResponse> createPriceAlert($grpc.ServiceCall call, $0.CreatePriceAlertRequest request);
  $async.Future<$0.GetPriceAlertsResponse> getPriceAlerts($grpc.ServiceCall call, $0.GetPriceAlertsRequest request);
  $async.Future<$0.UpdatePriceAlertResponse> updatePriceAlert($grpc.ServiceCall call, $0.UpdatePriceAlertRequest request);
  $async.Future<$0.DeletePriceAlertResponse> deletePriceAlert($grpc.ServiceCall call, $0.DeletePriceAlertRequest request);
}
