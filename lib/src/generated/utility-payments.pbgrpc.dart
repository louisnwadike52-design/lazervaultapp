///
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'utility-payments.pb.dart' as $0;
export 'utility-payments.pb.dart';

class UtilityPaymentsServiceClient extends $grpc.Client {
  static final _$payElectricityBill = $grpc.ClientMethod<
          $0.PayElectricityBillRequest, $0.PayElectricityBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayElectricityBill',
      ($0.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.PayElectricityBillResponse.fromBuffer(value));
  static final _$payWaterBill =
      $grpc.ClientMethod<$0.PayWaterBillRequest, $0.PayWaterBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayWaterBill',
          ($0.PayWaterBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayWaterBillResponse.fromBuffer(value));
  static final _$payInternetBill =
      $grpc.ClientMethod<$0.PayInternetBillRequest, $0.PayInternetBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayInternetBill',
          ($0.PayInternetBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PayInternetBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyAirtime',
          ($0.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BuyAirtimeResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$0.BarcodePayRequest, $0.BarcodePayResponse>(
          '/utilitypayments.UtilityPaymentsService/BarcodePay',
          ($0.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$0.ScanToPayRequest, $0.ScanToPayResponse>(
          '/utilitypayments.UtilityPaymentsService/ScanToPay',
          ($0.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ScanToPayResponse.fromBuffer(value));
  static final _$getBillPaymentHistory = $grpc.ClientMethod<
          $0.GetBillPaymentHistoryRequest, $0.GetBillPaymentHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillPaymentHistory',
      ($0.GetBillPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBillPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $0.GetBillProvidersRequest, $0.GetBillProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillProviders',
      ($0.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $0.GetAirtimeProvidersRequest, $0.GetAirtimeProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeProviders',
      ($0.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$verifyBill =
      $grpc.ClientMethod<$0.VerifyBillRequest, $0.VerifyBillResponse>(
          '/utilitypayments.UtilityPaymentsService/VerifyBill',
          ($0.VerifyBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyBillResponse.fromBuffer(value));

  UtilityPaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.PayElectricityBillResponse> payElectricityBill(
      $0.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayWaterBillResponse> payWaterBill(
      $0.PayWaterBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWaterBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayInternetBillResponse> payInternetBill(
      $0.PayInternetBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInternetBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyAirtimeResponse> buyAirtime(
      $0.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$0.BarcodePayResponse> barcodePay(
      $0.BarcodePayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$0.ScanToPayResponse> scanToPay(
      $0.ScanToPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $0.GetBillPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBillProvidersResponse> getBillProviders(
      $0.GetBillProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeProvidersResponse> getAirtimeProviders(
      $0.GetAirtimeProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyBillResponse> verifyBill(
      $0.VerifyBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBill, request, options: options);
  }
}

abstract class UtilityPaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'utilitypayments.UtilityPaymentsService';

  UtilityPaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PayElectricityBillRequest,
            $0.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayElectricityBillRequest.fromBuffer(value),
        ($0.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.PayWaterBillRequest, $0.PayWaterBillResponse>(
            'PayWaterBill',
            payWaterBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.PayWaterBillRequest.fromBuffer(value),
            ($0.PayWaterBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayInternetBillRequest,
            $0.PayInternetBillResponse>(
        'PayInternetBill',
        payInternetBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PayInternetBillRequest.fromBuffer(value),
        ($0.PayInternetBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
        'BuyAirtime',
        buyAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyAirtimeRequest.fromBuffer(value),
        ($0.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BarcodePayRequest, $0.BarcodePayResponse>(
        'BarcodePay',
        barcodePay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BarcodePayRequest.fromBuffer(value),
        ($0.BarcodePayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ScanToPayRequest, $0.ScanToPayResponse>(
        'ScanToPay',
        scanToPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ScanToPayRequest.fromBuffer(value),
        ($0.ScanToPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBillPaymentHistoryRequest,
            $0.GetBillPaymentHistoryResponse>(
        'GetBillPaymentHistory',
        getBillPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBillPaymentHistoryRequest.fromBuffer(value),
        ($0.GetBillPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBillProvidersRequest,
            $0.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBillProvidersRequest.fromBuffer(value),
        ($0.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeProvidersRequest,
            $0.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAirtimeProvidersRequest.fromBuffer(value),
        ($0.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyBillRequest, $0.VerifyBillResponse>(
        'VerifyBill',
        verifyBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyBillRequest.fromBuffer(value),
        ($0.VerifyBillResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$0.PayWaterBillResponse> payWaterBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayWaterBillRequest> request) async {
    return payWaterBill(call, await request);
  }

  $async.Future<$0.PayInternetBillResponse> payInternetBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PayInternetBillRequest> request) async {
    return payInternetBill(call, await request);
  }

  $async.Future<$0.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$0.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$0.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$0.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$0.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$0.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBillPaymentHistoryRequest> request) async {
    return getBillPaymentHistory(call, await request);
  }

  $async.Future<$0.GetBillProvidersResponse> getBillProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$0.VerifyBillResponse> verifyBill_Pre($grpc.ServiceCall call,
      $async.Future<$0.VerifyBillRequest> request) async {
    return verifyBill(call, await request);
  }

  $async.Future<$0.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $0.PayElectricityBillRequest request);
  $async.Future<$0.PayWaterBillResponse> payWaterBill(
      $grpc.ServiceCall call, $0.PayWaterBillRequest request);
  $async.Future<$0.PayInternetBillResponse> payInternetBill(
      $grpc.ServiceCall call, $0.PayInternetBillRequest request);
  $async.Future<$0.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $0.BuyAirtimeRequest request);
  $async.Future<$0.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $0.BarcodePayRequest request);
  $async.Future<$0.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $0.ScanToPayRequest request);
  $async.Future<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $grpc.ServiceCall call, $0.GetBillPaymentHistoryRequest request);
  $async.Future<$0.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $0.GetBillProvidersRequest request);
  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $0.GetAirtimeProvidersRequest request);
  $async.Future<$0.VerifyBillResponse> verifyBill(
      $grpc.ServiceCall call, $0.VerifyBillRequest request);
}
