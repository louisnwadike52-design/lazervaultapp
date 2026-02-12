//
//  Generated code. Do not modify.
//  source: utility-payments.proto
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

import 'utility-payments.pb.dart' as $0;

export 'utility-payments.pb.dart';

@$pb.GrpcServiceName('utilitypayments.UtilityPaymentsService')
class UtilityPaymentsServiceClient extends $grpc.Client {
  static final _$payElectricityBill = $grpc.ClientMethod<$0.PayElectricityBillRequest, $0.PayElectricityBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayElectricityBill',
      ($0.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayElectricityBillResponse.fromBuffer(value));
  static final _$payWaterBill = $grpc.ClientMethod<$0.PayWaterBillRequest, $0.PayWaterBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayWaterBill',
      ($0.PayWaterBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayWaterBillResponse.fromBuffer(value));
  static final _$payInternetBill = $grpc.ClientMethod<$0.PayInternetBillRequest, $0.PayInternetBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayInternetBill',
      ($0.PayInternetBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayInternetBillResponse.fromBuffer(value));
  static final _$buyAirtime = $grpc.ClientMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
      '/utilitypayments.UtilityPaymentsService/BuyAirtime',
      ($0.BuyAirtimeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BuyAirtimeResponse.fromBuffer(value));
  static final _$buyData = $grpc.ClientMethod<$0.BuyDataRequest, $0.BuyDataResponse>(
      '/utilitypayments.UtilityPaymentsService/BuyData',
      ($0.BuyDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BuyDataResponse.fromBuffer(value));
  static final _$getDataPlans = $grpc.ClientMethod<$0.GetDataPlansRequest, $0.GetDataPlansResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataPlans',
      ($0.GetDataPlansRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetDataPlansResponse.fromBuffer(value));
  static final _$barcodePay = $grpc.ClientMethod<$0.BarcodePayRequest, $0.BarcodePayResponse>(
      '/utilitypayments.UtilityPaymentsService/BarcodePay',
      ($0.BarcodePayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay = $grpc.ClientMethod<$0.ScanToPayRequest, $0.ScanToPayResponse>(
      '/utilitypayments.UtilityPaymentsService/ScanToPay',
      ($0.ScanToPayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ScanToPayResponse.fromBuffer(value));
  static final _$getBillPaymentHistory = $grpc.ClientMethod<$0.GetBillPaymentHistoryRequest, $0.GetBillPaymentHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillPaymentHistory',
      ($0.GetBillPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBillPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<$0.GetBillProvidersRequest, $0.GetBillProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillProviders',
      ($0.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<$0.GetAirtimeProvidersRequest, $0.GetAirtimeProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeProviders',
      ($0.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$verifyBill = $grpc.ClientMethod<$0.VerifyBillRequest, $0.VerifyBillResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyBill',
      ($0.VerifyBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyBillResponse.fromBuffer(value));
  static final _$validateSmartCard = $grpc.ClientMethod<$0.ValidateSmartCardRequest, $0.ValidateSmartCardResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateSmartCard',
      ($0.ValidateSmartCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ValidateSmartCardResponse.fromBuffer(value));
  static final _$getTVPackages = $grpc.ClientMethod<$0.GetTVPackagesRequest, $0.GetTVPackagesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetTVPackages',
      ($0.GetTVPackagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTVPackagesResponse.fromBuffer(value));
  static final _$payCableTVBill = $grpc.ClientMethod<$0.PayCableTVBillRequest, $0.PayCableTVBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayCableTVBill',
      ($0.PayCableTVBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayCableTVBillResponse.fromBuffer(value));
  static final _$getCableTVProviders = $grpc.ClientMethod<$0.GetCableTVProvidersRequest, $0.GetCableTVProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVProviders',
      ($0.GetCableTVProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCableTVProvidersResponse.fromBuffer(value));
  static final _$purchaseEducationPin = $grpc.ClientMethod<$0.PurchaseEducationPinRequest, $0.PurchaseEducationPinResponse>(
      '/utilitypayments.UtilityPaymentsService/PurchaseEducationPin',
      ($0.PurchaseEducationPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PurchaseEducationPinResponse.fromBuffer(value));
  static final _$getEducationProviders = $grpc.ClientMethod<$0.GetEducationProvidersRequest, $0.GetEducationProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationProviders',
      ($0.GetEducationProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetEducationProvidersResponse.fromBuffer(value));

  UtilityPaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.PayElectricityBillResponse> payElectricityBill($0.PayElectricityBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayWaterBillResponse> payWaterBill($0.PayWaterBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWaterBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayInternetBillResponse> payInternetBill($0.PayInternetBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInternetBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyAirtimeResponse> buyAirtime($0.BuyAirtimeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$0.BuyDataResponse> buyData($0.BuyDataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyData, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDataPlansResponse> getDataPlans($0.GetDataPlansRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataPlans, request, options: options);
  }

  $grpc.ResponseFuture<$0.BarcodePayResponse> barcodePay($0.BarcodePayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$0.ScanToPayResponse> scanToPay($0.ScanToPayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory($0.GetBillPaymentHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBillProvidersResponse> getBillProviders($0.GetBillProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAirtimeProvidersResponse> getAirtimeProviders($0.GetAirtimeProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyBillResponse> verifyBill($0.VerifyBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidateSmartCardResponse> validateSmartCard($0.ValidateSmartCardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateSmartCard, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTVPackagesResponse> getTVPackages($0.GetTVPackagesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTVPackages, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayCableTVBillResponse> payCableTVBill($0.PayCableTVBillRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payCableTVBill, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCableTVProvidersResponse> getCableTVProviders($0.GetCableTVProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.PurchaseEducationPinResponse> purchaseEducationPin($0.PurchaseEducationPinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseEducationPin, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetEducationProvidersResponse> getEducationProviders($0.GetEducationProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationProviders, request, options: options);
  }
}

@$pb.GrpcServiceName('utilitypayments.UtilityPaymentsService')
abstract class UtilityPaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'utilitypayments.UtilityPaymentsService';

  UtilityPaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PayElectricityBillRequest, $0.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayElectricityBillRequest.fromBuffer(value),
        ($0.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayWaterBillRequest, $0.PayWaterBillResponse>(
        'PayWaterBill',
        payWaterBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayWaterBillRequest.fromBuffer(value),
        ($0.PayWaterBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayInternetBillRequest, $0.PayInternetBillResponse>(
        'PayInternetBill',
        payInternetBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayInternetBillRequest.fromBuffer(value),
        ($0.PayInternetBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyAirtimeRequest, $0.BuyAirtimeResponse>(
        'BuyAirtime',
        buyAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyAirtimeRequest.fromBuffer(value),
        ($0.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuyDataRequest, $0.BuyDataResponse>(
        'BuyData',
        buyData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BuyDataRequest.fromBuffer(value),
        ($0.BuyDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDataPlansRequest, $0.GetDataPlansResponse>(
        'GetDataPlans',
        getDataPlans_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetDataPlansRequest.fromBuffer(value),
        ($0.GetDataPlansResponse value) => value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.GetBillPaymentHistoryRequest, $0.GetBillPaymentHistoryResponse>(
        'GetBillPaymentHistory',
        getBillPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBillPaymentHistoryRequest.fromBuffer(value),
        ($0.GetBillPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBillProvidersRequest, $0.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBillProvidersRequest.fromBuffer(value),
        ($0.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAirtimeProvidersRequest, $0.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAirtimeProvidersRequest.fromBuffer(value),
        ($0.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyBillRequest, $0.VerifyBillResponse>(
        'VerifyBill',
        verifyBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyBillRequest.fromBuffer(value),
        ($0.VerifyBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateSmartCardRequest, $0.ValidateSmartCardResponse>(
        'ValidateSmartCard',
        validateSmartCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ValidateSmartCardRequest.fromBuffer(value),
        ($0.ValidateSmartCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTVPackagesRequest, $0.GetTVPackagesResponse>(
        'GetTVPackages',
        getTVPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTVPackagesRequest.fromBuffer(value),
        ($0.GetTVPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayCableTVBillRequest, $0.PayCableTVBillResponse>(
        'PayCableTVBill',
        payCableTVBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayCableTVBillRequest.fromBuffer(value),
        ($0.PayCableTVBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCableTVProvidersRequest, $0.GetCableTVProvidersResponse>(
        'GetCableTVProviders',
        getCableTVProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCableTVProvidersRequest.fromBuffer(value),
        ($0.GetCableTVProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PurchaseEducationPinRequest, $0.PurchaseEducationPinResponse>(
        'PurchaseEducationPin',
        purchaseEducationPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PurchaseEducationPinRequest.fromBuffer(value),
        ($0.PurchaseEducationPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEducationProvidersRequest, $0.GetEducationProvidersResponse>(
        'GetEducationProviders',
        getEducationProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetEducationProvidersRequest.fromBuffer(value),
        ($0.GetEducationProvidersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PayElectricityBillResponse> payElectricityBill_Pre($grpc.ServiceCall call, $async.Future<$0.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$0.PayWaterBillResponse> payWaterBill_Pre($grpc.ServiceCall call, $async.Future<$0.PayWaterBillRequest> request) async {
    return payWaterBill(call, await request);
  }

  $async.Future<$0.PayInternetBillResponse> payInternetBill_Pre($grpc.ServiceCall call, $async.Future<$0.PayInternetBillRequest> request) async {
    return payInternetBill(call, await request);
  }

  $async.Future<$0.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call, $async.Future<$0.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$0.BuyDataResponse> buyData_Pre($grpc.ServiceCall call, $async.Future<$0.BuyDataRequest> request) async {
    return buyData(call, await request);
  }

  $async.Future<$0.GetDataPlansResponse> getDataPlans_Pre($grpc.ServiceCall call, $async.Future<$0.GetDataPlansRequest> request) async {
    return getDataPlans(call, await request);
  }

  $async.Future<$0.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call, $async.Future<$0.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$0.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call, $async.Future<$0.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetBillPaymentHistoryRequest> request) async {
    return getBillPaymentHistory(call, await request);
  }

  $async.Future<$0.GetBillProvidersResponse> getBillProviders_Pre($grpc.ServiceCall call, $async.Future<$0.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders_Pre($grpc.ServiceCall call, $async.Future<$0.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$0.VerifyBillResponse> verifyBill_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyBillRequest> request) async {
    return verifyBill(call, await request);
  }

  $async.Future<$0.ValidateSmartCardResponse> validateSmartCard_Pre($grpc.ServiceCall call, $async.Future<$0.ValidateSmartCardRequest> request) async {
    return validateSmartCard(call, await request);
  }

  $async.Future<$0.GetTVPackagesResponse> getTVPackages_Pre($grpc.ServiceCall call, $async.Future<$0.GetTVPackagesRequest> request) async {
    return getTVPackages(call, await request);
  }

  $async.Future<$0.PayCableTVBillResponse> payCableTVBill_Pre($grpc.ServiceCall call, $async.Future<$0.PayCableTVBillRequest> request) async {
    return payCableTVBill(call, await request);
  }

  $async.Future<$0.GetCableTVProvidersResponse> getCableTVProviders_Pre($grpc.ServiceCall call, $async.Future<$0.GetCableTVProvidersRequest> request) async {
    return getCableTVProviders(call, await request);
  }

  $async.Future<$0.PurchaseEducationPinResponse> purchaseEducationPin_Pre($grpc.ServiceCall call, $async.Future<$0.PurchaseEducationPinRequest> request) async {
    return purchaseEducationPin(call, await request);
  }

  $async.Future<$0.GetEducationProvidersResponse> getEducationProviders_Pre($grpc.ServiceCall call, $async.Future<$0.GetEducationProvidersRequest> request) async {
    return getEducationProviders(call, await request);
  }

  $async.Future<$0.PayElectricityBillResponse> payElectricityBill($grpc.ServiceCall call, $0.PayElectricityBillRequest request);
  $async.Future<$0.PayWaterBillResponse> payWaterBill($grpc.ServiceCall call, $0.PayWaterBillRequest request);
  $async.Future<$0.PayInternetBillResponse> payInternetBill($grpc.ServiceCall call, $0.PayInternetBillRequest request);
  $async.Future<$0.BuyAirtimeResponse> buyAirtime($grpc.ServiceCall call, $0.BuyAirtimeRequest request);
  $async.Future<$0.BuyDataResponse> buyData($grpc.ServiceCall call, $0.BuyDataRequest request);
  $async.Future<$0.GetDataPlansResponse> getDataPlans($grpc.ServiceCall call, $0.GetDataPlansRequest request);
  $async.Future<$0.BarcodePayResponse> barcodePay($grpc.ServiceCall call, $0.BarcodePayRequest request);
  $async.Future<$0.ScanToPayResponse> scanToPay($grpc.ServiceCall call, $0.ScanToPayRequest request);
  $async.Future<$0.GetBillPaymentHistoryResponse> getBillPaymentHistory($grpc.ServiceCall call, $0.GetBillPaymentHistoryRequest request);
  $async.Future<$0.GetBillProvidersResponse> getBillProviders($grpc.ServiceCall call, $0.GetBillProvidersRequest request);
  $async.Future<$0.GetAirtimeProvidersResponse> getAirtimeProviders($grpc.ServiceCall call, $0.GetAirtimeProvidersRequest request);
  $async.Future<$0.VerifyBillResponse> verifyBill($grpc.ServiceCall call, $0.VerifyBillRequest request);
  $async.Future<$0.ValidateSmartCardResponse> validateSmartCard($grpc.ServiceCall call, $0.ValidateSmartCardRequest request);
  $async.Future<$0.GetTVPackagesResponse> getTVPackages($grpc.ServiceCall call, $0.GetTVPackagesRequest request);
  $async.Future<$0.PayCableTVBillResponse> payCableTVBill($grpc.ServiceCall call, $0.PayCableTVBillRequest request);
  $async.Future<$0.GetCableTVProvidersResponse> getCableTVProviders($grpc.ServiceCall call, $0.GetCableTVProvidersRequest request);
  $async.Future<$0.PurchaseEducationPinResponse> purchaseEducationPin($grpc.ServiceCall call, $0.PurchaseEducationPinRequest request);
  $async.Future<$0.GetEducationProvidersResponse> getEducationProviders($grpc.ServiceCall call, $0.GetEducationProvidersRequest request);
}
