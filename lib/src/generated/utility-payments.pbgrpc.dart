///
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'utility-payments.pb.dart' as $42;
export 'utility-payments.pb.dart';

class UtilityPaymentsServiceClient extends $grpc.Client {
  static final _$payElectricityBill = $grpc.ClientMethod<
          $42.PayElectricityBillRequest, $42.PayElectricityBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayElectricityBill',
      ($42.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.PayElectricityBillResponse.fromBuffer(value));
  static final _$payWaterBill =
      $grpc.ClientMethod<$42.PayWaterBillRequest, $42.PayWaterBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayWaterBill',
          ($42.PayWaterBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.PayWaterBillResponse.fromBuffer(value));
  static final _$payInternetBill = $grpc.ClientMethod<
          $42.PayInternetBillRequest, $42.PayInternetBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayInternetBill',
      ($42.PayInternetBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.PayInternetBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$42.BuyAirtimeRequest, $42.BuyAirtimeResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyAirtime',
          ($42.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.BuyAirtimeResponse.fromBuffer(value));
  static final _$buyData =
      $grpc.ClientMethod<$42.BuyDataRequest, $42.BuyDataResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyData',
          ($42.BuyDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.BuyDataResponse.fromBuffer(value));
  static final _$getDataPlans =
      $grpc.ClientMethod<$42.GetDataPlansRequest, $42.GetDataPlansResponse>(
          '/utilitypayments.UtilityPaymentsService/GetDataPlans',
          ($42.GetDataPlansRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.GetDataPlansResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$42.BarcodePayRequest, $42.BarcodePayResponse>(
          '/utilitypayments.UtilityPaymentsService/BarcodePay',
          ($42.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$42.ScanToPayRequest, $42.ScanToPayResponse>(
          '/utilitypayments.UtilityPaymentsService/ScanToPay',
          ($42.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.ScanToPayResponse.fromBuffer(value));
  static final _$getBillPaymentHistory = $grpc.ClientMethod<
          $42.GetBillPaymentHistoryRequest, $42.GetBillPaymentHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillPaymentHistory',
      ($42.GetBillPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetBillPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $42.GetBillProvidersRequest, $42.GetBillProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillProviders',
      ($42.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $42.GetAirtimeProvidersRequest, $42.GetAirtimeProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeProviders',
      ($42.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$verifyBill =
      $grpc.ClientMethod<$42.VerifyBillRequest, $42.VerifyBillResponse>(
          '/utilitypayments.UtilityPaymentsService/VerifyBill',
          ($42.VerifyBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.VerifyBillResponse.fromBuffer(value));
  static final _$validateSmartCard = $grpc.ClientMethod<
          $42.ValidateSmartCardRequest, $42.ValidateSmartCardResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateSmartCard',
      ($42.ValidateSmartCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.ValidateSmartCardResponse.fromBuffer(value));
  static final _$getTVPackages =
      $grpc.ClientMethod<$42.GetTVPackagesRequest, $42.GetTVPackagesResponse>(
          '/utilitypayments.UtilityPaymentsService/GetTVPackages',
          ($42.GetTVPackagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.GetTVPackagesResponse.fromBuffer(value));
  static final _$payCableTVBill =
      $grpc.ClientMethod<$42.PayCableTVBillRequest, $42.PayCableTVBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayCableTVBill',
          ($42.PayCableTVBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $42.PayCableTVBillResponse.fromBuffer(value));
  static final _$getCableTVProviders = $grpc.ClientMethod<
          $42.GetCableTVProvidersRequest, $42.GetCableTVProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVProviders',
      ($42.GetCableTVProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetCableTVProvidersResponse.fromBuffer(value));
  static final _$getInternetProviders = $grpc.ClientMethod<
          $42.GetInternetProvidersRequest, $42.GetInternetProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetProviders',
      ($42.GetInternetProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetInternetProvidersResponse.fromBuffer(value));
  static final _$validateInternetAccount = $grpc.ClientMethod<
          $42.ValidateInternetAccountRequest,
          $42.ValidateInternetAccountResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateInternetAccount',
      ($42.ValidateInternetAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.ValidateInternetAccountResponse.fromBuffer(value));
  static final _$getInternetPackages = $grpc.ClientMethod<
          $42.GetInternetPackagesRequest, $42.GetInternetPackagesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetPackages',
      ($42.GetInternetPackagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetInternetPackagesResponse.fromBuffer(value));
  static final _$purchaseEducationPin = $grpc.ClientMethod<
          $42.PurchaseEducationPinRequest, $42.PurchaseEducationPinResponse>(
      '/utilitypayments.UtilityPaymentsService/PurchaseEducationPin',
      ($42.PurchaseEducationPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.PurchaseEducationPinResponse.fromBuffer(value));
  static final _$getEducationProviders = $grpc.ClientMethod<
          $42.GetEducationProvidersRequest, $42.GetEducationProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationProviders',
      ($42.GetEducationProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetEducationProvidersResponse.fromBuffer(value));
  static final _$getActiveSubscriptions = $grpc.ClientMethod<
          $42.GetActiveSubscriptionsRequest,
          $42.GetActiveSubscriptionsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetActiveSubscriptions',
      ($42.GetActiveSubscriptionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetActiveSubscriptionsResponse.fromBuffer(value));
  static final _$getSubscriptionSummary = $grpc.ClientMethod<
          $42.GetSubscriptionSummaryRequest,
          $42.GetSubscriptionSummaryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetSubscriptionSummary',
      ($42.GetSubscriptionSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetSubscriptionSummaryResponse.fromBuffer(value));
  static final _$getSubscriptionSpending = $grpc.ClientMethod<
          $42.GetSubscriptionSpendingRequest,
          $42.GetSubscriptionSpendingResponse>(
      '/utilitypayments.UtilityPaymentsService/GetSubscriptionSpending',
      ($42.GetSubscriptionSpendingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetSubscriptionSpendingResponse.fromBuffer(value));
  static final _$enableAutoRenew = $grpc.ClientMethod<
          $42.EnableAutoRenewRequest, $42.EnableAutoRenewResponse>(
      '/utilitypayments.UtilityPaymentsService/EnableAutoRenew',
      ($42.EnableAutoRenewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.EnableAutoRenewResponse.fromBuffer(value));
  static final _$disableAutoRenew = $grpc.ClientMethod<
          $42.DisableAutoRenewRequest, $42.DisableAutoRenewResponse>(
      '/utilitypayments.UtilityPaymentsService/DisableAutoRenew',
      ($42.DisableAutoRenewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.DisableAutoRenewResponse.fromBuffer(value));
  static final _$getAutoRenewSubscriptions = $grpc.ClientMethod<
          $42.GetAutoRenewSubscriptionsRequest,
          $42.GetAutoRenewSubscriptionsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAutoRenewSubscriptions',
      ($42.GetAutoRenewSubscriptionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetAutoRenewSubscriptionsResponse.fromBuffer(value));
  static final _$updateAutoRenewPlan = $grpc.ClientMethod<
          $42.UpdateAutoRenewPlanRequest, $42.UpdateAutoRenewPlanResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAutoRenewPlan',
      ($42.UpdateAutoRenewPlanRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.UpdateAutoRenewPlanResponse.fromBuffer(value));
  static final _$transferAirtime = $grpc.ClientMethod<
          $42.TransferAirtimeRequest, $42.TransferAirtimeResponse>(
      '/utilitypayments.UtilityPaymentsService/TransferAirtime',
      ($42.TransferAirtimeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.TransferAirtimeResponse.fromBuffer(value));
  static final _$getAirtimeTransferRates = $grpc.ClientMethod<
          $42.GetAirtimeTransferRatesRequest,
          $42.GetAirtimeTransferRatesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeTransferRates',
      ($42.GetAirtimeTransferRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetAirtimeTransferRatesResponse.fromBuffer(value));
  static final _$getAirtimeTransferHistory = $grpc.ClientMethod<
          $42.GetAirtimeTransferHistoryRequest,
          $42.GetAirtimeTransferHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeTransferHistory',
      ($42.GetAirtimeTransferHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetAirtimeTransferHistoryResponse.fromBuffer(value));
  static final _$getAirtimeToCashRates = $grpc.ClientMethod<
          $42.GetAirtimeToCashRatesRequest, $42.GetAirtimeToCashRatesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashRates',
      ($42.GetAirtimeToCashRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetAirtimeToCashRatesResponse.fromBuffer(value));
  static final _$requestAirtimeToCashOTP = $grpc.ClientMethod<
          $42.RequestAirtimeToCashOTPRequest,
          $42.RequestAirtimeToCashOTPResponse>(
      '/utilitypayments.UtilityPaymentsService/RequestAirtimeToCashOTP',
      ($42.RequestAirtimeToCashOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.RequestAirtimeToCashOTPResponse.fromBuffer(value));
  static final _$verifyAirtimeToCashOTP = $grpc.ClientMethod<
          $42.VerifyAirtimeToCashOTPRequest,
          $42.VerifyAirtimeToCashOTPResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyAirtimeToCashOTP',
      ($42.VerifyAirtimeToCashOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.VerifyAirtimeToCashOTPResponse.fromBuffer(value));
  static final _$convertAirtimeToCash = $grpc.ClientMethod<
          $42.ConvertAirtimeToCashRequest, $42.ConvertAirtimeToCashResponse>(
      '/utilitypayments.UtilityPaymentsService/ConvertAirtimeToCash',
      ($42.ConvertAirtimeToCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.ConvertAirtimeToCashResponse.fromBuffer(value));
  static final _$getAirtimeToCashHistory = $grpc.ClientMethod<
          $42.GetAirtimeToCashHistoryRequest,
          $42.GetAirtimeToCashHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashHistory',
      ($42.GetAirtimeToCashHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetAirtimeToCashHistoryResponse.fromBuffer(value));
  static final _$verifyAirtimeToCashService = $grpc.ClientMethod<
          $42.VerifyAirtimeToCashServiceRequest,
          $42.VerifyAirtimeToCashServiceResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyAirtimeToCashService',
      ($42.VerifyAirtimeToCashServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.VerifyAirtimeToCashServiceResponse.fromBuffer(value));
  static final _$getAirtimeToCashProviderInfo = $grpc.ClientMethod<
          $42.GetAirtimeToCashProviderInfoRequest,
          $42.GetAirtimeToCashProviderInfoResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashProviderInfo',
      ($42.GetAirtimeToCashProviderInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.GetAirtimeToCashProviderInfoResponse.fromBuffer(value));
  static final _$checkAirtimeToCashQuota = $grpc.ClientMethod<
          $42.CheckAirtimeToCashQuotaRequest,
          $42.CheckAirtimeToCashQuotaResponse>(
      '/utilitypayments.UtilityPaymentsService/CheckAirtimeToCashQuota',
      ($42.CheckAirtimeToCashQuotaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.CheckAirtimeToCashQuotaResponse.fromBuffer(value));

  UtilityPaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$42.PayElectricityBillResponse> payElectricityBill(
      $42.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$42.PayWaterBillResponse> payWaterBill(
      $42.PayWaterBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWaterBill, request, options: options);
  }

  $grpc.ResponseFuture<$42.PayInternetBillResponse> payInternetBill(
      $42.PayInternetBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInternetBill, request, options: options);
  }

  $grpc.ResponseFuture<$42.BuyAirtimeResponse> buyAirtime(
      $42.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$42.BuyDataResponse> buyData($42.BuyDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyData, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetDataPlansResponse> getDataPlans(
      $42.GetDataPlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataPlans, request, options: options);
  }

  $grpc.ResponseFuture<$42.BarcodePayResponse> barcodePay(
      $42.BarcodePayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$42.ScanToPayResponse> scanToPay(
      $42.ScanToPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $42.GetBillPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetBillProvidersResponse> getBillProviders(
      $42.GetBillProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetAirtimeProvidersResponse> getAirtimeProviders(
      $42.GetAirtimeProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$42.VerifyBillResponse> verifyBill(
      $42.VerifyBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBill, request, options: options);
  }

  $grpc.ResponseFuture<$42.ValidateSmartCardResponse> validateSmartCard(
      $42.ValidateSmartCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateSmartCard, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetTVPackagesResponse> getTVPackages(
      $42.GetTVPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTVPackages, request, options: options);
  }

  $grpc.ResponseFuture<$42.PayCableTVBillResponse> payCableTVBill(
      $42.PayCableTVBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payCableTVBill, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetCableTVProvidersResponse> getCableTVProviders(
      $42.GetCableTVProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVProviders, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetInternetProvidersResponse> getInternetProviders(
      $42.GetInternetProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetProviders, request, options: options);
  }

  $grpc.ResponseFuture<$42.ValidateInternetAccountResponse>
      validateInternetAccount($42.ValidateInternetAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInternetAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.GetInternetPackagesResponse> getInternetPackages(
      $42.GetInternetPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetPackages, request, options: options);
  }

  $grpc.ResponseFuture<$42.PurchaseEducationPinResponse> purchaseEducationPin(
      $42.PurchaseEducationPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseEducationPin, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetEducationProvidersResponse> getEducationProviders(
      $42.GetEducationProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationProviders, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetActiveSubscriptionsResponse>
      getActiveSubscriptions($42.GetActiveSubscriptionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getActiveSubscriptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.GetSubscriptionSummaryResponse>
      getSubscriptionSummary($42.GetSubscriptionSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubscriptionSummary, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.GetSubscriptionSpendingResponse>
      getSubscriptionSpending($42.GetSubscriptionSpendingRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubscriptionSpending, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.EnableAutoRenewResponse> enableAutoRenew(
      $42.EnableAutoRenewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableAutoRenew, request, options: options);
  }

  $grpc.ResponseFuture<$42.DisableAutoRenewResponse> disableAutoRenew(
      $42.DisableAutoRenewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableAutoRenew, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions($42.GetAutoRenewSubscriptionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoRenewSubscriptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $42.UpdateAutoRenewPlanRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoRenewPlan, request, options: options);
  }

  $grpc.ResponseFuture<$42.TransferAirtimeResponse> transferAirtime(
      $42.TransferAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetAirtimeTransferRatesResponse>
      getAirtimeTransferRates($42.GetAirtimeTransferRatesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeTransferRates, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.GetAirtimeTransferHistoryResponse>
      getAirtimeTransferHistory($42.GetAirtimeTransferHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeTransferHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $42.GetAirtimeToCashRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashRates, request, options: options);
  }

  $grpc.ResponseFuture<$42.RequestAirtimeToCashOTPResponse>
      requestAirtimeToCashOTP($42.RequestAirtimeToCashOTPRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestAirtimeToCashOTP, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.VerifyAirtimeToCashOTPResponse>
      verifyAirtimeToCashOTP($42.VerifyAirtimeToCashOTPRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyAirtimeToCashOTP, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $42.ConvertAirtimeToCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertAirtimeToCash, request, options: options);
  }

  $grpc.ResponseFuture<$42.GetAirtimeToCashHistoryResponse>
      getAirtimeToCashHistory($42.GetAirtimeToCashHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService($42.VerifyAirtimeToCashServiceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyAirtimeToCashService, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo(
          $42.GetAirtimeToCashProviderInfoRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashProviderInfo, request,
        options: options);
  }

  $grpc.ResponseFuture<$42.CheckAirtimeToCashQuotaResponse>
      checkAirtimeToCashQuota($42.CheckAirtimeToCashQuotaRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkAirtimeToCashQuota, request,
        options: options);
  }
}

abstract class UtilityPaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'utilitypayments.UtilityPaymentsService';

  UtilityPaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$42.PayElectricityBillRequest,
            $42.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.PayElectricityBillRequest.fromBuffer(value),
        ($42.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$42.PayWaterBillRequest, $42.PayWaterBillResponse>(
            'PayWaterBill',
            payWaterBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $42.PayWaterBillRequest.fromBuffer(value),
            ($42.PayWaterBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.PayInternetBillRequest,
            $42.PayInternetBillResponse>(
        'PayInternetBill',
        payInternetBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.PayInternetBillRequest.fromBuffer(value),
        ($42.PayInternetBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$42.BuyAirtimeRequest, $42.BuyAirtimeResponse>(
            'BuyAirtime',
            buyAirtime_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $42.BuyAirtimeRequest.fromBuffer(value),
            ($42.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.BuyDataRequest, $42.BuyDataResponse>(
        'BuyData',
        buyData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.BuyDataRequest.fromBuffer(value),
        ($42.BuyDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$42.GetDataPlansRequest, $42.GetDataPlansResponse>(
            'GetDataPlans',
            getDataPlans_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $42.GetDataPlansRequest.fromBuffer(value),
            ($42.GetDataPlansResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$42.BarcodePayRequest, $42.BarcodePayResponse>(
            'BarcodePay',
            barcodePay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $42.BarcodePayRequest.fromBuffer(value),
            ($42.BarcodePayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.ScanToPayRequest, $42.ScanToPayResponse>(
        'ScanToPay',
        scanToPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $42.ScanToPayRequest.fromBuffer(value),
        ($42.ScanToPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetBillPaymentHistoryRequest,
            $42.GetBillPaymentHistoryResponse>(
        'GetBillPaymentHistory',
        getBillPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetBillPaymentHistoryRequest.fromBuffer(value),
        ($42.GetBillPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetBillProvidersRequest,
            $42.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetBillProvidersRequest.fromBuffer(value),
        ($42.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetAirtimeProvidersRequest,
            $42.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetAirtimeProvidersRequest.fromBuffer(value),
        ($42.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$42.VerifyBillRequest, $42.VerifyBillResponse>(
            'VerifyBill',
            verifyBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $42.VerifyBillRequest.fromBuffer(value),
            ($42.VerifyBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.ValidateSmartCardRequest,
            $42.ValidateSmartCardResponse>(
        'ValidateSmartCard',
        validateSmartCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.ValidateSmartCardRequest.fromBuffer(value),
        ($42.ValidateSmartCardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetTVPackagesRequest,
            $42.GetTVPackagesResponse>(
        'GetTVPackages',
        getTVPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetTVPackagesRequest.fromBuffer(value),
        ($42.GetTVPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.PayCableTVBillRequest,
            $42.PayCableTVBillResponse>(
        'PayCableTVBill',
        payCableTVBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.PayCableTVBillRequest.fromBuffer(value),
        ($42.PayCableTVBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetCableTVProvidersRequest,
            $42.GetCableTVProvidersResponse>(
        'GetCableTVProviders',
        getCableTVProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetCableTVProvidersRequest.fromBuffer(value),
        ($42.GetCableTVProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetInternetProvidersRequest,
            $42.GetInternetProvidersResponse>(
        'GetInternetProviders',
        getInternetProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetInternetProvidersRequest.fromBuffer(value),
        ($42.GetInternetProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.ValidateInternetAccountRequest,
            $42.ValidateInternetAccountResponse>(
        'ValidateInternetAccount',
        validateInternetAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.ValidateInternetAccountRequest.fromBuffer(value),
        ($42.ValidateInternetAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetInternetPackagesRequest,
            $42.GetInternetPackagesResponse>(
        'GetInternetPackages',
        getInternetPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetInternetPackagesRequest.fromBuffer(value),
        ($42.GetInternetPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.PurchaseEducationPinRequest,
            $42.PurchaseEducationPinResponse>(
        'PurchaseEducationPin',
        purchaseEducationPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.PurchaseEducationPinRequest.fromBuffer(value),
        ($42.PurchaseEducationPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetEducationProvidersRequest,
            $42.GetEducationProvidersResponse>(
        'GetEducationProviders',
        getEducationProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetEducationProvidersRequest.fromBuffer(value),
        ($42.GetEducationProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetActiveSubscriptionsRequest,
            $42.GetActiveSubscriptionsResponse>(
        'GetActiveSubscriptions',
        getActiveSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetActiveSubscriptionsRequest.fromBuffer(value),
        ($42.GetActiveSubscriptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetSubscriptionSummaryRequest,
            $42.GetSubscriptionSummaryResponse>(
        'GetSubscriptionSummary',
        getSubscriptionSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetSubscriptionSummaryRequest.fromBuffer(value),
        ($42.GetSubscriptionSummaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetSubscriptionSpendingRequest,
            $42.GetSubscriptionSpendingResponse>(
        'GetSubscriptionSpending',
        getSubscriptionSpending_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetSubscriptionSpendingRequest.fromBuffer(value),
        ($42.GetSubscriptionSpendingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.EnableAutoRenewRequest,
            $42.EnableAutoRenewResponse>(
        'EnableAutoRenew',
        enableAutoRenew_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.EnableAutoRenewRequest.fromBuffer(value),
        ($42.EnableAutoRenewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.DisableAutoRenewRequest,
            $42.DisableAutoRenewResponse>(
        'DisableAutoRenew',
        disableAutoRenew_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.DisableAutoRenewRequest.fromBuffer(value),
        ($42.DisableAutoRenewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetAutoRenewSubscriptionsRequest,
            $42.GetAutoRenewSubscriptionsResponse>(
        'GetAutoRenewSubscriptions',
        getAutoRenewSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetAutoRenewSubscriptionsRequest.fromBuffer(value),
        ($42.GetAutoRenewSubscriptionsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.UpdateAutoRenewPlanRequest,
            $42.UpdateAutoRenewPlanResponse>(
        'UpdateAutoRenewPlan',
        updateAutoRenewPlan_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.UpdateAutoRenewPlanRequest.fromBuffer(value),
        ($42.UpdateAutoRenewPlanResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.TransferAirtimeRequest,
            $42.TransferAirtimeResponse>(
        'TransferAirtime',
        transferAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.TransferAirtimeRequest.fromBuffer(value),
        ($42.TransferAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetAirtimeTransferRatesRequest,
            $42.GetAirtimeTransferRatesResponse>(
        'GetAirtimeTransferRates',
        getAirtimeTransferRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetAirtimeTransferRatesRequest.fromBuffer(value),
        ($42.GetAirtimeTransferRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetAirtimeTransferHistoryRequest,
            $42.GetAirtimeTransferHistoryResponse>(
        'GetAirtimeTransferHistory',
        getAirtimeTransferHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetAirtimeTransferHistoryRequest.fromBuffer(value),
        ($42.GetAirtimeTransferHistoryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetAirtimeToCashRatesRequest,
            $42.GetAirtimeToCashRatesResponse>(
        'GetAirtimeToCashRates',
        getAirtimeToCashRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetAirtimeToCashRatesRequest.fromBuffer(value),
        ($42.GetAirtimeToCashRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.RequestAirtimeToCashOTPRequest,
            $42.RequestAirtimeToCashOTPResponse>(
        'RequestAirtimeToCashOTP',
        requestAirtimeToCashOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.RequestAirtimeToCashOTPRequest.fromBuffer(value),
        ($42.RequestAirtimeToCashOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.VerifyAirtimeToCashOTPRequest,
            $42.VerifyAirtimeToCashOTPResponse>(
        'VerifyAirtimeToCashOTP',
        verifyAirtimeToCashOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.VerifyAirtimeToCashOTPRequest.fromBuffer(value),
        ($42.VerifyAirtimeToCashOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.ConvertAirtimeToCashRequest,
            $42.ConvertAirtimeToCashResponse>(
        'ConvertAirtimeToCash',
        convertAirtimeToCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.ConvertAirtimeToCashRequest.fromBuffer(value),
        ($42.ConvertAirtimeToCashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetAirtimeToCashHistoryRequest,
            $42.GetAirtimeToCashHistoryResponse>(
        'GetAirtimeToCashHistory',
        getAirtimeToCashHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetAirtimeToCashHistoryRequest.fromBuffer(value),
        ($42.GetAirtimeToCashHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.VerifyAirtimeToCashServiceRequest,
            $42.VerifyAirtimeToCashServiceResponse>(
        'VerifyAirtimeToCashService',
        verifyAirtimeToCashService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.VerifyAirtimeToCashServiceRequest.fromBuffer(value),
        ($42.VerifyAirtimeToCashServiceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetAirtimeToCashProviderInfoRequest,
            $42.GetAirtimeToCashProviderInfoResponse>(
        'GetAirtimeToCashProviderInfo',
        getAirtimeToCashProviderInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetAirtimeToCashProviderInfoRequest.fromBuffer(value),
        ($42.GetAirtimeToCashProviderInfoResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.CheckAirtimeToCashQuotaRequest,
            $42.CheckAirtimeToCashQuotaResponse>(
        'CheckAirtimeToCashQuota',
        checkAirtimeToCashQuota_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.CheckAirtimeToCashQuotaRequest.fromBuffer(value),
        ($42.CheckAirtimeToCashQuotaResponse value) => value.writeToBuffer()));
  }

  $async.Future<$42.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$42.PayWaterBillResponse> payWaterBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.PayWaterBillRequest> request) async {
    return payWaterBill(call, await request);
  }

  $async.Future<$42.PayInternetBillResponse> payInternetBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.PayInternetBillRequest> request) async {
    return payInternetBill(call, await request);
  }

  $async.Future<$42.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$42.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$42.BuyDataResponse> buyData_Pre(
      $grpc.ServiceCall call, $async.Future<$42.BuyDataRequest> request) async {
    return buyData(call, await request);
  }

  $async.Future<$42.GetDataPlansResponse> getDataPlans_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetDataPlansRequest> request) async {
    return getDataPlans(call, await request);
  }

  $async.Future<$42.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$42.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$42.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$42.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$42.GetBillPaymentHistoryResponse> getBillPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetBillPaymentHistoryRequest> request) async {
    return getBillPaymentHistory(call, await request);
  }

  $async.Future<$42.GetBillProvidersResponse> getBillProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$42.GetAirtimeProvidersResponse> getAirtimeProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$42.VerifyBillResponse> verifyBill_Pre($grpc.ServiceCall call,
      $async.Future<$42.VerifyBillRequest> request) async {
    return verifyBill(call, await request);
  }

  $async.Future<$42.ValidateSmartCardResponse> validateSmartCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.ValidateSmartCardRequest> request) async {
    return validateSmartCard(call, await request);
  }

  $async.Future<$42.GetTVPackagesResponse> getTVPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetTVPackagesRequest> request) async {
    return getTVPackages(call, await request);
  }

  $async.Future<$42.PayCableTVBillResponse> payCableTVBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.PayCableTVBillRequest> request) async {
    return payCableTVBill(call, await request);
  }

  $async.Future<$42.GetCableTVProvidersResponse> getCableTVProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetCableTVProvidersRequest> request) async {
    return getCableTVProviders(call, await request);
  }

  $async.Future<$42.GetInternetProvidersResponse> getInternetProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetInternetProvidersRequest> request) async {
    return getInternetProviders(call, await request);
  }

  $async.Future<$42.ValidateInternetAccountResponse>
      validateInternetAccount_Pre($grpc.ServiceCall call,
          $async.Future<$42.ValidateInternetAccountRequest> request) async {
    return validateInternetAccount(call, await request);
  }

  $async.Future<$42.GetInternetPackagesResponse> getInternetPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetInternetPackagesRequest> request) async {
    return getInternetPackages(call, await request);
  }

  $async.Future<$42.PurchaseEducationPinResponse> purchaseEducationPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.PurchaseEducationPinRequest> request) async {
    return purchaseEducationPin(call, await request);
  }

  $async.Future<$42.GetEducationProvidersResponse> getEducationProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetEducationProvidersRequest> request) async {
    return getEducationProviders(call, await request);
  }

  $async.Future<$42.GetActiveSubscriptionsResponse> getActiveSubscriptions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetActiveSubscriptionsRequest> request) async {
    return getActiveSubscriptions(call, await request);
  }

  $async.Future<$42.GetSubscriptionSummaryResponse> getSubscriptionSummary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetSubscriptionSummaryRequest> request) async {
    return getSubscriptionSummary(call, await request);
  }

  $async.Future<$42.GetSubscriptionSpendingResponse>
      getSubscriptionSpending_Pre($grpc.ServiceCall call,
          $async.Future<$42.GetSubscriptionSpendingRequest> request) async {
    return getSubscriptionSpending(call, await request);
  }

  $async.Future<$42.EnableAutoRenewResponse> enableAutoRenew_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.EnableAutoRenewRequest> request) async {
    return enableAutoRenew(call, await request);
  }

  $async.Future<$42.DisableAutoRenewResponse> disableAutoRenew_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.DisableAutoRenewRequest> request) async {
    return disableAutoRenew(call, await request);
  }

  $async.Future<$42.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions_Pre($grpc.ServiceCall call,
          $async.Future<$42.GetAutoRenewSubscriptionsRequest> request) async {
    return getAutoRenewSubscriptions(call, await request);
  }

  $async.Future<$42.UpdateAutoRenewPlanResponse> updateAutoRenewPlan_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.UpdateAutoRenewPlanRequest> request) async {
    return updateAutoRenewPlan(call, await request);
  }

  $async.Future<$42.TransferAirtimeResponse> transferAirtime_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.TransferAirtimeRequest> request) async {
    return transferAirtime(call, await request);
  }

  $async.Future<$42.GetAirtimeTransferRatesResponse>
      getAirtimeTransferRates_Pre($grpc.ServiceCall call,
          $async.Future<$42.GetAirtimeTransferRatesRequest> request) async {
    return getAirtimeTransferRates(call, await request);
  }

  $async.Future<$42.GetAirtimeTransferHistoryResponse>
      getAirtimeTransferHistory_Pre($grpc.ServiceCall call,
          $async.Future<$42.GetAirtimeTransferHistoryRequest> request) async {
    return getAirtimeTransferHistory(call, await request);
  }

  $async.Future<$42.GetAirtimeToCashRatesResponse> getAirtimeToCashRates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.GetAirtimeToCashRatesRequest> request) async {
    return getAirtimeToCashRates(call, await request);
  }

  $async.Future<$42.RequestAirtimeToCashOTPResponse>
      requestAirtimeToCashOTP_Pre($grpc.ServiceCall call,
          $async.Future<$42.RequestAirtimeToCashOTPRequest> request) async {
    return requestAirtimeToCashOTP(call, await request);
  }

  $async.Future<$42.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.VerifyAirtimeToCashOTPRequest> request) async {
    return verifyAirtimeToCashOTP(call, await request);
  }

  $async.Future<$42.ConvertAirtimeToCashResponse> convertAirtimeToCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.ConvertAirtimeToCashRequest> request) async {
    return convertAirtimeToCash(call, await request);
  }

  $async.Future<$42.GetAirtimeToCashHistoryResponse>
      getAirtimeToCashHistory_Pre($grpc.ServiceCall call,
          $async.Future<$42.GetAirtimeToCashHistoryRequest> request) async {
    return getAirtimeToCashHistory(call, await request);
  }

  $async.Future<$42.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService_Pre($grpc.ServiceCall call,
          $async.Future<$42.VerifyAirtimeToCashServiceRequest> request) async {
    return verifyAirtimeToCashService(call, await request);
  }

  $async.Future<$42.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo_Pre(
          $grpc.ServiceCall call,
          $async.Future<$42.GetAirtimeToCashProviderInfoRequest>
              request) async {
    return getAirtimeToCashProviderInfo(call, await request);
  }

  $async.Future<$42.CheckAirtimeToCashQuotaResponse>
      checkAirtimeToCashQuota_Pre($grpc.ServiceCall call,
          $async.Future<$42.CheckAirtimeToCashQuotaRequest> request) async {
    return checkAirtimeToCashQuota(call, await request);
  }

  $async.Future<$42.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $42.PayElectricityBillRequest request);
  $async.Future<$42.PayWaterBillResponse> payWaterBill(
      $grpc.ServiceCall call, $42.PayWaterBillRequest request);
  $async.Future<$42.PayInternetBillResponse> payInternetBill(
      $grpc.ServiceCall call, $42.PayInternetBillRequest request);
  $async.Future<$42.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $42.BuyAirtimeRequest request);
  $async.Future<$42.BuyDataResponse> buyData(
      $grpc.ServiceCall call, $42.BuyDataRequest request);
  $async.Future<$42.GetDataPlansResponse> getDataPlans(
      $grpc.ServiceCall call, $42.GetDataPlansRequest request);
  $async.Future<$42.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $42.BarcodePayRequest request);
  $async.Future<$42.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $42.ScanToPayRequest request);
  $async.Future<$42.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $grpc.ServiceCall call, $42.GetBillPaymentHistoryRequest request);
  $async.Future<$42.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $42.GetBillProvidersRequest request);
  $async.Future<$42.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $42.GetAirtimeProvidersRequest request);
  $async.Future<$42.VerifyBillResponse> verifyBill(
      $grpc.ServiceCall call, $42.VerifyBillRequest request);
  $async.Future<$42.ValidateSmartCardResponse> validateSmartCard(
      $grpc.ServiceCall call, $42.ValidateSmartCardRequest request);
  $async.Future<$42.GetTVPackagesResponse> getTVPackages(
      $grpc.ServiceCall call, $42.GetTVPackagesRequest request);
  $async.Future<$42.PayCableTVBillResponse> payCableTVBill(
      $grpc.ServiceCall call, $42.PayCableTVBillRequest request);
  $async.Future<$42.GetCableTVProvidersResponse> getCableTVProviders(
      $grpc.ServiceCall call, $42.GetCableTVProvidersRequest request);
  $async.Future<$42.GetInternetProvidersResponse> getInternetProviders(
      $grpc.ServiceCall call, $42.GetInternetProvidersRequest request);
  $async.Future<$42.ValidateInternetAccountResponse> validateInternetAccount(
      $grpc.ServiceCall call, $42.ValidateInternetAccountRequest request);
  $async.Future<$42.GetInternetPackagesResponse> getInternetPackages(
      $grpc.ServiceCall call, $42.GetInternetPackagesRequest request);
  $async.Future<$42.PurchaseEducationPinResponse> purchaseEducationPin(
      $grpc.ServiceCall call, $42.PurchaseEducationPinRequest request);
  $async.Future<$42.GetEducationProvidersResponse> getEducationProviders(
      $grpc.ServiceCall call, $42.GetEducationProvidersRequest request);
  $async.Future<$42.GetActiveSubscriptionsResponse> getActiveSubscriptions(
      $grpc.ServiceCall call, $42.GetActiveSubscriptionsRequest request);
  $async.Future<$42.GetSubscriptionSummaryResponse> getSubscriptionSummary(
      $grpc.ServiceCall call, $42.GetSubscriptionSummaryRequest request);
  $async.Future<$42.GetSubscriptionSpendingResponse> getSubscriptionSpending(
      $grpc.ServiceCall call, $42.GetSubscriptionSpendingRequest request);
  $async.Future<$42.EnableAutoRenewResponse> enableAutoRenew(
      $grpc.ServiceCall call, $42.EnableAutoRenewRequest request);
  $async.Future<$42.DisableAutoRenewResponse> disableAutoRenew(
      $grpc.ServiceCall call, $42.DisableAutoRenewRequest request);
  $async.Future<$42.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions(
          $grpc.ServiceCall call, $42.GetAutoRenewSubscriptionsRequest request);
  $async.Future<$42.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $grpc.ServiceCall call, $42.UpdateAutoRenewPlanRequest request);
  $async.Future<$42.TransferAirtimeResponse> transferAirtime(
      $grpc.ServiceCall call, $42.TransferAirtimeRequest request);
  $async.Future<$42.GetAirtimeTransferRatesResponse> getAirtimeTransferRates(
      $grpc.ServiceCall call, $42.GetAirtimeTransferRatesRequest request);
  $async.Future<$42.GetAirtimeTransferHistoryResponse>
      getAirtimeTransferHistory(
          $grpc.ServiceCall call, $42.GetAirtimeTransferHistoryRequest request);
  $async.Future<$42.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $grpc.ServiceCall call, $42.GetAirtimeToCashRatesRequest request);
  $async.Future<$42.RequestAirtimeToCashOTPResponse> requestAirtimeToCashOTP(
      $grpc.ServiceCall call, $42.RequestAirtimeToCashOTPRequest request);
  $async.Future<$42.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP(
      $grpc.ServiceCall call, $42.VerifyAirtimeToCashOTPRequest request);
  $async.Future<$42.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $grpc.ServiceCall call, $42.ConvertAirtimeToCashRequest request);
  $async.Future<$42.GetAirtimeToCashHistoryResponse> getAirtimeToCashHistory(
      $grpc.ServiceCall call, $42.GetAirtimeToCashHistoryRequest request);
  $async.Future<$42.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService($grpc.ServiceCall call,
          $42.VerifyAirtimeToCashServiceRequest request);
  $async.Future<$42.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo($grpc.ServiceCall call,
          $42.GetAirtimeToCashProviderInfoRequest request);
  $async.Future<$42.CheckAirtimeToCashQuotaResponse> checkAirtimeToCashQuota(
      $grpc.ServiceCall call, $42.CheckAirtimeToCashQuotaRequest request);
}
