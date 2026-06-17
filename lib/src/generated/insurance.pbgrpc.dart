///
//  Generated code. Do not modify.
//  source: insurance.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'insurance.pb.dart' as $24;
export 'insurance.pb.dart';

class InsuranceServiceClient extends $grpc.Client {
  static final _$getUserInsurances = $grpc.ClientMethod<
          $24.GetUserInsurancesRequest, $24.GetUserInsurancesResponse>(
      '/pb.InsuranceService/GetUserInsurances',
      ($24.GetUserInsurancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetUserInsurancesResponse.fromBuffer(value));
  static final _$getInsuranceById = $grpc.ClientMethod<
          $24.GetInsuranceByIdRequest, $24.GetInsuranceByIdResponse>(
      '/pb.InsuranceService/GetInsuranceById',
      ($24.GetInsuranceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceByIdResponse.fromBuffer(value));
  static final _$createInsurance = $grpc.ClientMethod<
          $24.CreateInsuranceRequest, $24.CreateInsuranceResponse>(
      '/pb.InsuranceService/CreateInsurance',
      ($24.CreateInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.CreateInsuranceResponse.fromBuffer(value));
  static final _$updateInsurance = $grpc.ClientMethod<
          $24.UpdateInsuranceRequest, $24.UpdateInsuranceResponse>(
      '/pb.InsuranceService/UpdateInsurance',
      ($24.UpdateInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.UpdateInsuranceResponse.fromBuffer(value));
  static final _$deleteInsurance = $grpc.ClientMethod<
          $24.DeleteInsuranceRequest, $24.DeleteInsuranceResponse>(
      '/pb.InsuranceService/DeleteInsurance',
      ($24.DeleteInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.DeleteInsuranceResponse.fromBuffer(value));
  static final _$searchInsurances = $grpc.ClientMethod<
          $24.SearchInsurancesRequest, $24.SearchInsurancesResponse>(
      '/pb.InsuranceService/SearchInsurances',
      ($24.SearchInsurancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.SearchInsurancesResponse.fromBuffer(value));
  static final _$getInsurancePayments = $grpc.ClientMethod<
          $24.GetInsurancePaymentsRequest, $24.GetInsurancePaymentsResponse>(
      '/pb.InsuranceService/GetInsurancePayments',
      ($24.GetInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsurancePaymentsResponse.fromBuffer(value));
  static final _$getUserPayments = $grpc.ClientMethod<
          $24.GetUserPaymentsRequest, $24.GetUserPaymentsResponse>(
      '/pb.InsuranceService/GetUserPayments',
      ($24.GetUserPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetUserPaymentsResponse.fromBuffer(value));
  static final _$createPayment =
      $grpc.ClientMethod<$24.CreatePaymentRequest, $24.CreatePaymentResponse>(
          '/pb.InsuranceService/CreatePayment',
          ($24.CreatePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.CreatePaymentResponse.fromBuffer(value));
  static final _$processPayment =
      $grpc.ClientMethod<$24.ProcessPaymentRequest, $24.ProcessPaymentResponse>(
          '/pb.InsuranceService/ProcessPayment',
          ($24.ProcessPaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.ProcessPaymentResponse.fromBuffer(value));
  static final _$getPaymentById =
      $grpc.ClientMethod<$24.GetPaymentByIdRequest, $24.GetPaymentByIdResponse>(
          '/pb.InsuranceService/GetPaymentById',
          ($24.GetPaymentByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.GetPaymentByIdResponse.fromBuffer(value));
  static final _$getOverduePayments = $grpc.ClientMethod<
          $24.GetOverduePaymentsRequest, $24.GetOverduePaymentsResponse>(
      '/pb.InsuranceService/GetOverduePayments',
      ($24.GetOverduePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetOverduePaymentsResponse.fromBuffer(value));
  static final _$getInsuranceClaims = $grpc.ClientMethod<
          $24.GetInsuranceClaimsRequest, $24.GetInsuranceClaimsResponse>(
      '/pb.InsuranceService/GetInsuranceClaims',
      ($24.GetInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceClaimsResponse.fromBuffer(value));
  static final _$getUserClaims =
      $grpc.ClientMethod<$24.GetUserClaimsRequest, $24.GetUserClaimsResponse>(
          '/pb.InsuranceService/GetUserClaims',
          ($24.GetUserClaimsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.GetUserClaimsResponse.fromBuffer(value));
  static final _$createClaim =
      $grpc.ClientMethod<$24.CreateClaimRequest, $24.CreateClaimResponse>(
          '/pb.InsuranceService/CreateClaim',
          ($24.CreateClaimRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.CreateClaimResponse.fromBuffer(value));
  static final _$updateClaim =
      $grpc.ClientMethod<$24.UpdateClaimRequest, $24.UpdateClaimResponse>(
          '/pb.InsuranceService/UpdateClaim',
          ($24.UpdateClaimRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.UpdateClaimResponse.fromBuffer(value));
  static final _$getClaimById =
      $grpc.ClientMethod<$24.GetClaimByIdRequest, $24.GetClaimByIdResponse>(
          '/pb.InsuranceService/GetClaimById',
          ($24.GetClaimByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $24.GetClaimByIdResponse.fromBuffer(value));
  static final _$generatePaymentReceipt = $grpc.ClientMethod<
          $24.GeneratePaymentReceiptRequest,
          $24.GeneratePaymentReceiptResponse>(
      '/pb.InsuranceService/GeneratePaymentReceipt',
      ($24.GeneratePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GeneratePaymentReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $24.GetUserReceiptsRequest, $24.GetUserReceiptsResponse>(
      '/pb.InsuranceService/GetUserReceipts',
      ($24.GetUserReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetUserReceiptsResponse.fromBuffer(value));
  static final _$getInsuranceStatistics = $grpc.ClientMethod<
          $24.GetInsuranceStatisticsRequest,
          $24.GetInsuranceStatisticsResponse>(
      '/pb.InsuranceService/GetInsuranceStatistics',
      ($24.GetInsuranceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceStatisticsResponse.fromBuffer(value));
  static final _$getPaymentStatistics = $grpc.ClientMethod<
          $24.GetPaymentStatisticsRequest, $24.GetPaymentStatisticsResponse>(
      '/pb.InsuranceService/GetPaymentStatistics',
      ($24.GetPaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetPaymentStatisticsResponse.fromBuffer(value));
  static final _$getInsuranceProducts = $grpc.ClientMethod<
          $24.GetInsuranceProductsRequest, $24.GetInsuranceProductsResponse>(
      '/pb.InsuranceService/GetInsuranceProducts',
      ($24.GetInsuranceProductsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceProductsResponse.fromBuffer(value));
  static final _$getInsuranceCategories = $grpc.ClientMethod<
          $24.GetInsuranceCategoriesRequest,
          $24.GetInsuranceCategoriesResponse>(
      '/pb.InsuranceService/GetInsuranceCategories',
      ($24.GetInsuranceCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceCategoriesResponse.fromBuffer(value));
  static final _$getInsuranceQuote = $grpc.ClientMethod<
          $24.GetInsuranceQuoteRequest, $24.GetInsuranceQuoteResponse>(
      '/pb.InsuranceService/GetInsuranceQuote',
      ($24.GetInsuranceQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceQuoteResponse.fromBuffer(value));
  static final _$purchaseInsurance = $grpc.ClientMethod<
          $24.PurchaseInsuranceRequest, $24.PurchaseInsuranceResponse>(
      '/pb.InsuranceService/PurchaseInsurance',
      ($24.PurchaseInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.PurchaseInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePurchaseStatus = $grpc.ClientMethod<
          $24.GetInsurancePurchaseStatusRequest,
          $24.GetInsurancePurchaseStatusResponse>(
      '/pb.InsuranceService/GetInsurancePurchaseStatus',
      ($24.GetInsurancePurchaseStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsurancePurchaseStatusResponse.fromBuffer(value));
  static final _$uploadInsuranceDocument = $grpc.ClientMethod<
          $24.UploadInsuranceDocumentRequest,
          $24.UploadInsuranceDocumentResponse>(
      '/pb.InsuranceService/UploadInsuranceDocument',
      ($24.UploadInsuranceDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.UploadInsuranceDocumentResponse.fromBuffer(value));
  static final _$getInsuranceAuxiliaryData = $grpc.ClientMethod<
          $24.GetInsuranceAuxiliaryDataRequest,
          $24.GetInsuranceAuxiliaryDataResponse>(
      '/pb.InsuranceService/GetInsuranceAuxiliaryData',
      ($24.GetInsuranceAuxiliaryDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceAuxiliaryDataResponse.fromBuffer(value));
  static final _$getMyCoverCustomers = $grpc.ClientMethod<
          $24.GetMyCoverCustomersRequest, $24.GetMyCoverCustomersResponse>(
      '/pb.InsuranceService/GetMyCoverCustomers',
      ($24.GetMyCoverCustomersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverCustomersResponse.fromBuffer(value));
  static final _$getMyCoverCustomerById = $grpc.ClientMethod<
          $24.GetMyCoverCustomerByIdRequest,
          $24.GetMyCoverCustomerByIdResponse>(
      '/pb.InsuranceService/GetMyCoverCustomerById',
      ($24.GetMyCoverCustomerByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverCustomerByIdResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPolicies = $grpc.ClientMethod<
          $24.GetMyCoverCustomerPoliciesRequest,
          $24.GetMyCoverCustomerPoliciesResponse>(
      '/pb.InsuranceService/GetMyCoverCustomerPolicies',
      ($24.GetMyCoverCustomerPoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverCustomerPoliciesResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPurchases = $grpc.ClientMethod<
          $24.GetMyCoverCustomerPurchasesRequest,
          $24.GetMyCoverCustomerPurchasesResponse>(
      '/pb.InsuranceService/GetMyCoverCustomerPurchases',
      ($24.GetMyCoverCustomerPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverCustomerPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchases = $grpc.ClientMethod<
          $24.GetMyCoverPurchasesRequest, $24.GetMyCoverPurchasesResponse>(
      '/pb.InsuranceService/GetMyCoverPurchases',
      ($24.GetMyCoverPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchaseById = $grpc.ClientMethod<
          $24.GetMyCoverPurchaseByIdRequest,
          $24.GetMyCoverPurchaseByIdResponse>(
      '/pb.InsuranceService/GetMyCoverPurchaseById',
      ($24.GetMyCoverPurchaseByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverPurchaseByIdResponse.fromBuffer(value));
  static final _$getMyCoverClaims = $grpc.ClientMethod<
          $24.GetMyCoverClaimsRequest, $24.GetMyCoverClaimsResponse>(
      '/pb.InsuranceService/GetMyCoverClaims',
      ($24.GetMyCoverClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverClaimsResponse.fromBuffer(value));
  static final _$getMyCoverClaimById = $grpc.ClientMethod<
          $24.GetMyCoverClaimByIdRequest, $24.GetMyCoverClaimByIdResponse>(
      '/pb.InsuranceService/GetMyCoverClaimById',
      ($24.GetMyCoverClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverClaimByIdResponse.fromBuffer(value));
  static final _$fileCreditLifeClaim = $grpc.ClientMethod<
          $24.FileCreditLifeClaimRequest, $24.FileCreditLifeClaimResponse>(
      '/pb.InsuranceService/FileCreditLifeClaim',
      ($24.FileCreditLifeClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.FileCreditLifeClaimResponse.fromBuffer(value));
  static final _$getInsuranceStates = $grpc.ClientMethod<
          $24.GetInsuranceStatesRequest, $24.GetInsuranceStatesResponse>(
      '/pb.InsuranceService/GetInsuranceStates',
      ($24.GetInsuranceStatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceStatesResponse.fromBuffer(value));
  static final _$getInsuranceVehicleMakes = $grpc.ClientMethod<
          $24.GetInsuranceVehicleMakesRequest,
          $24.GetInsuranceVehicleMakesResponse>(
      '/pb.InsuranceService/GetInsuranceVehicleMakes',
      ($24.GetInsuranceVehicleMakesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceVehicleMakesResponse.fromBuffer(value));
  static final _$getMyCoverNotificationPreferences = $grpc.ClientMethod<
          $24.GetMyCoverNotificationPreferencesRequest,
          $24.GetMyCoverNotificationPreferencesResponse>(
      '/pb.InsuranceService/GetMyCoverNotificationPreferences',
      ($24.GetMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$updateMyCoverNotificationPreferences = $grpc.ClientMethod<
          $24.UpdateMyCoverNotificationPreferencesRequest,
          $24.UpdateMyCoverNotificationPreferencesResponse>(
      '/pb.InsuranceService/UpdateMyCoverNotificationPreferences',
      ($24.UpdateMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.UpdateMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$getMyCoverWalletBalance = $grpc.ClientMethod<
          $24.GetMyCoverWalletBalanceRequest,
          $24.GetMyCoverWalletBalanceResponse>(
      '/pb.InsuranceService/GetMyCoverWalletBalance',
      ($24.GetMyCoverWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetMyCoverWalletBalanceResponse.fromBuffer(value));
  static final _$requestInsuranceRefund = $grpc.ClientMethod<
          $24.RequestInsuranceRefundRequest,
          $24.RequestInsuranceRefundResponse>(
      '/pb.InsuranceService/RequestInsuranceRefund',
      ($24.RequestInsuranceRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.RequestInsuranceRefundResponse.fromBuffer(value));
  static final _$getInsuranceRefundStatus = $grpc.ClientMethod<
          $24.GetInsuranceRefundStatusRequest,
          $24.GetInsuranceRefundStatusResponse>(
      '/pb.InsuranceService/GetInsuranceRefundStatus',
      ($24.GetInsuranceRefundStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $24.GetInsuranceRefundStatusResponse.fromBuffer(value));

  InsuranceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$24.GetUserInsurancesResponse> getUserInsurances(
      $24.GetUserInsurancesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsurances, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceByIdResponse> getInsuranceById(
      $24.GetInsuranceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceById, request, options: options);
  }

  $grpc.ResponseFuture<$24.CreateInsuranceResponse> createInsurance(
      $24.CreateInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$24.UpdateInsuranceResponse> updateInsurance(
      $24.UpdateInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$24.DeleteInsuranceResponse> deleteInsurance(
      $24.DeleteInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$24.SearchInsurancesResponse> searchInsurances(
      $24.SearchInsurancesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchInsurances, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsurancePaymentsResponse> getInsurancePayments(
      $24.GetInsurancePaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePayments, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetUserPaymentsResponse> getUserPayments(
      $24.GetUserPaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPayments, request, options: options);
  }

  $grpc.ResponseFuture<$24.CreatePaymentResponse> createPayment(
      $24.CreatePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPayment, request, options: options);
  }

  $grpc.ResponseFuture<$24.ProcessPaymentResponse> processPayment(
      $24.ProcessPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayment, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetPaymentByIdResponse> getPaymentById(
      $24.GetPaymentByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentById, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetOverduePaymentsResponse> getOverduePayments(
      $24.GetOverduePaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverduePayments, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceClaimsResponse> getInsuranceClaims(
      $24.GetInsuranceClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaims, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetUserClaimsResponse> getUserClaims(
      $24.GetUserClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserClaims, request, options: options);
  }

  $grpc.ResponseFuture<$24.CreateClaimResponse> createClaim(
      $24.CreateClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createClaim, request, options: options);
  }

  $grpc.ResponseFuture<$24.UpdateClaimResponse> updateClaim(
      $24.UpdateClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateClaim, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetClaimByIdResponse> getClaimById(
      $24.GetClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$24.GeneratePaymentReceiptResponse>
      generatePaymentReceipt($24.GeneratePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generatePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetUserReceiptsResponse> getUserReceipts(
      $24.GetUserReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceStatisticsResponse>
      getInsuranceStatistics($24.GetInsuranceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetPaymentStatisticsResponse> getPaymentStatistics(
      $24.GetPaymentStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceProductsResponse> getInsuranceProducts(
      $24.GetInsuranceProductsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceProducts, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceCategoriesResponse>
      getInsuranceCategories($24.GetInsuranceCategoriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceCategories, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceQuoteResponse> getInsuranceQuote(
      $24.GetInsuranceQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceQuote, request, options: options);
  }

  $grpc.ResponseFuture<$24.PurchaseInsuranceResponse> purchaseInsurance(
      $24.PurchaseInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus($24.GetInsurancePurchaseStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePurchaseStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.UploadInsuranceDocumentResponse>
      uploadInsuranceDocument($24.UploadInsuranceDocumentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadInsuranceDocument, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData($24.GetInsuranceAuxiliaryDataRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceAuxiliaryData, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $24.GetMyCoverCustomersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomers, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverCustomerByIdResponse>
      getMyCoverCustomerById($24.GetMyCoverCustomerByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerById, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies($24.GetMyCoverCustomerPoliciesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPolicies, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases(
          $24.GetMyCoverCustomerPurchasesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPurchases, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $24.GetMyCoverPurchasesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchases, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverPurchaseByIdResponse>
      getMyCoverPurchaseById($24.GetMyCoverPurchaseByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchaseById, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverClaimsResponse> getMyCoverClaims(
      $24.GetMyCoverClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaims, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $24.GetMyCoverClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$24.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $24.FileCreditLifeClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fileCreditLifeClaim, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceStatesResponse> getInsuranceStates(
      $24.GetInsuranceStatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStates, request, options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes($24.GetInsuranceVehicleMakesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceVehicleMakes, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences(
          $24.GetMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences(
          $24.UpdateMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetMyCoverWalletBalanceResponse>
      getMyCoverWalletBalance($24.GetMyCoverWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.RequestInsuranceRefundResponse>
      requestInsuranceRefund($24.RequestInsuranceRefundRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInsuranceRefund, request,
        options: options);
  }

  $grpc.ResponseFuture<$24.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus($24.GetInsuranceRefundStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceRefundStatus, request,
        options: options);
  }
}

abstract class InsuranceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InsuranceService';

  InsuranceServiceBase() {
    $addMethod($grpc.ServiceMethod<$24.GetUserInsurancesRequest,
            $24.GetUserInsurancesResponse>(
        'GetUserInsurances',
        getUserInsurances_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetUserInsurancesRequest.fromBuffer(value),
        ($24.GetUserInsurancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceByIdRequest,
            $24.GetInsuranceByIdResponse>(
        'GetInsuranceById',
        getInsuranceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceByIdRequest.fromBuffer(value),
        ($24.GetInsuranceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.CreateInsuranceRequest,
            $24.CreateInsuranceResponse>(
        'CreateInsurance',
        createInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.CreateInsuranceRequest.fromBuffer(value),
        ($24.CreateInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.UpdateInsuranceRequest,
            $24.UpdateInsuranceResponse>(
        'UpdateInsurance',
        updateInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.UpdateInsuranceRequest.fromBuffer(value),
        ($24.UpdateInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.DeleteInsuranceRequest,
            $24.DeleteInsuranceResponse>(
        'DeleteInsurance',
        deleteInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.DeleteInsuranceRequest.fromBuffer(value),
        ($24.DeleteInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.SearchInsurancesRequest,
            $24.SearchInsurancesResponse>(
        'SearchInsurances',
        searchInsurances_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.SearchInsurancesRequest.fromBuffer(value),
        ($24.SearchInsurancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsurancePaymentsRequest,
            $24.GetInsurancePaymentsResponse>(
        'GetInsurancePayments',
        getInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsurancePaymentsRequest.fromBuffer(value),
        ($24.GetInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetUserPaymentsRequest,
            $24.GetUserPaymentsResponse>(
        'GetUserPayments',
        getUserPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetUserPaymentsRequest.fromBuffer(value),
        ($24.GetUserPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.CreatePaymentRequest,
            $24.CreatePaymentResponse>(
        'CreatePayment',
        createPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.CreatePaymentRequest.fromBuffer(value),
        ($24.CreatePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.ProcessPaymentRequest,
            $24.ProcessPaymentResponse>(
        'ProcessPayment',
        processPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.ProcessPaymentRequest.fromBuffer(value),
        ($24.ProcessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetPaymentByIdRequest,
            $24.GetPaymentByIdResponse>(
        'GetPaymentById',
        getPaymentById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetPaymentByIdRequest.fromBuffer(value),
        ($24.GetPaymentByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetOverduePaymentsRequest,
            $24.GetOverduePaymentsResponse>(
        'GetOverduePayments',
        getOverduePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetOverduePaymentsRequest.fromBuffer(value),
        ($24.GetOverduePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceClaimsRequest,
            $24.GetInsuranceClaimsResponse>(
        'GetInsuranceClaims',
        getInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceClaimsRequest.fromBuffer(value),
        ($24.GetInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetUserClaimsRequest,
            $24.GetUserClaimsResponse>(
        'GetUserClaims',
        getUserClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetUserClaimsRequest.fromBuffer(value),
        ($24.GetUserClaimsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$24.CreateClaimRequest, $24.CreateClaimResponse>(
            'CreateClaim',
            createClaim_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $24.CreateClaimRequest.fromBuffer(value),
            ($24.CreateClaimResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$24.UpdateClaimRequest, $24.UpdateClaimResponse>(
            'UpdateClaim',
            updateClaim_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $24.UpdateClaimRequest.fromBuffer(value),
            ($24.UpdateClaimResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$24.GetClaimByIdRequest, $24.GetClaimByIdResponse>(
            'GetClaimById',
            getClaimById_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $24.GetClaimByIdRequest.fromBuffer(value),
            ($24.GetClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GeneratePaymentReceiptRequest,
            $24.GeneratePaymentReceiptResponse>(
        'GeneratePaymentReceipt',
        generatePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GeneratePaymentReceiptRequest.fromBuffer(value),
        ($24.GeneratePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetUserReceiptsRequest,
            $24.GetUserReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetUserReceiptsRequest.fromBuffer(value),
        ($24.GetUserReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceStatisticsRequest,
            $24.GetInsuranceStatisticsResponse>(
        'GetInsuranceStatistics',
        getInsuranceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceStatisticsRequest.fromBuffer(value),
        ($24.GetInsuranceStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetPaymentStatisticsRequest,
            $24.GetPaymentStatisticsResponse>(
        'GetPaymentStatistics',
        getPaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetPaymentStatisticsRequest.fromBuffer(value),
        ($24.GetPaymentStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceProductsRequest,
            $24.GetInsuranceProductsResponse>(
        'GetInsuranceProducts',
        getInsuranceProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceProductsRequest.fromBuffer(value),
        ($24.GetInsuranceProductsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceCategoriesRequest,
            $24.GetInsuranceCategoriesResponse>(
        'GetInsuranceCategories',
        getInsuranceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceCategoriesRequest.fromBuffer(value),
        ($24.GetInsuranceCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceQuoteRequest,
            $24.GetInsuranceQuoteResponse>(
        'GetInsuranceQuote',
        getInsuranceQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceQuoteRequest.fromBuffer(value),
        ($24.GetInsuranceQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.PurchaseInsuranceRequest,
            $24.PurchaseInsuranceResponse>(
        'PurchaseInsurance',
        purchaseInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.PurchaseInsuranceRequest.fromBuffer(value),
        ($24.PurchaseInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsurancePurchaseStatusRequest,
            $24.GetInsurancePurchaseStatusResponse>(
        'GetInsurancePurchaseStatus',
        getInsurancePurchaseStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsurancePurchaseStatusRequest.fromBuffer(value),
        ($24.GetInsurancePurchaseStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.UploadInsuranceDocumentRequest,
            $24.UploadInsuranceDocumentResponse>(
        'UploadInsuranceDocument',
        uploadInsuranceDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.UploadInsuranceDocumentRequest.fromBuffer(value),
        ($24.UploadInsuranceDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceAuxiliaryDataRequest,
            $24.GetInsuranceAuxiliaryDataResponse>(
        'GetInsuranceAuxiliaryData',
        getInsuranceAuxiliaryData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceAuxiliaryDataRequest.fromBuffer(value),
        ($24.GetInsuranceAuxiliaryDataResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverCustomersRequest,
            $24.GetMyCoverCustomersResponse>(
        'GetMyCoverCustomers',
        getMyCoverCustomers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverCustomersRequest.fromBuffer(value),
        ($24.GetMyCoverCustomersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverCustomerByIdRequest,
            $24.GetMyCoverCustomerByIdResponse>(
        'GetMyCoverCustomerById',
        getMyCoverCustomerById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverCustomerByIdRequest.fromBuffer(value),
        ($24.GetMyCoverCustomerByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverCustomerPoliciesRequest,
            $24.GetMyCoverCustomerPoliciesResponse>(
        'GetMyCoverCustomerPolicies',
        getMyCoverCustomerPolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverCustomerPoliciesRequest.fromBuffer(value),
        ($24.GetMyCoverCustomerPoliciesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverCustomerPurchasesRequest,
            $24.GetMyCoverCustomerPurchasesResponse>(
        'GetMyCoverCustomerPurchases',
        getMyCoverCustomerPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverCustomerPurchasesRequest.fromBuffer(value),
        ($24.GetMyCoverCustomerPurchasesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverPurchasesRequest,
            $24.GetMyCoverPurchasesResponse>(
        'GetMyCoverPurchases',
        getMyCoverPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverPurchasesRequest.fromBuffer(value),
        ($24.GetMyCoverPurchasesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverPurchaseByIdRequest,
            $24.GetMyCoverPurchaseByIdResponse>(
        'GetMyCoverPurchaseById',
        getMyCoverPurchaseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverPurchaseByIdRequest.fromBuffer(value),
        ($24.GetMyCoverPurchaseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverClaimsRequest,
            $24.GetMyCoverClaimsResponse>(
        'GetMyCoverClaims',
        getMyCoverClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverClaimsRequest.fromBuffer(value),
        ($24.GetMyCoverClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverClaimByIdRequest,
            $24.GetMyCoverClaimByIdResponse>(
        'GetMyCoverClaimById',
        getMyCoverClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverClaimByIdRequest.fromBuffer(value),
        ($24.GetMyCoverClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.FileCreditLifeClaimRequest,
            $24.FileCreditLifeClaimResponse>(
        'FileCreditLifeClaim',
        fileCreditLifeClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.FileCreditLifeClaimRequest.fromBuffer(value),
        ($24.FileCreditLifeClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceStatesRequest,
            $24.GetInsuranceStatesResponse>(
        'GetInsuranceStates',
        getInsuranceStates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceStatesRequest.fromBuffer(value),
        ($24.GetInsuranceStatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceVehicleMakesRequest,
            $24.GetInsuranceVehicleMakesResponse>(
        'GetInsuranceVehicleMakes',
        getInsuranceVehicleMakes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceVehicleMakesRequest.fromBuffer(value),
        ($24.GetInsuranceVehicleMakesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverNotificationPreferencesRequest,
            $24.GetMyCoverNotificationPreferencesResponse>(
        'GetMyCoverNotificationPreferences',
        getMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($24.GetMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $24.UpdateMyCoverNotificationPreferencesRequest,
            $24.UpdateMyCoverNotificationPreferencesResponse>(
        'UpdateMyCoverNotificationPreferences',
        updateMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.UpdateMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($24.UpdateMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetMyCoverWalletBalanceRequest,
            $24.GetMyCoverWalletBalanceResponse>(
        'GetMyCoverWalletBalance',
        getMyCoverWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetMyCoverWalletBalanceRequest.fromBuffer(value),
        ($24.GetMyCoverWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.RequestInsuranceRefundRequest,
            $24.RequestInsuranceRefundResponse>(
        'RequestInsuranceRefund',
        requestInsuranceRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.RequestInsuranceRefundRequest.fromBuffer(value),
        ($24.RequestInsuranceRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$24.GetInsuranceRefundStatusRequest,
            $24.GetInsuranceRefundStatusResponse>(
        'GetInsuranceRefundStatus',
        getInsuranceRefundStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $24.GetInsuranceRefundStatusRequest.fromBuffer(value),
        ($24.GetInsuranceRefundStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$24.GetUserInsurancesResponse> getUserInsurances_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetUserInsurancesRequest> request) async {
    return getUserInsurances(call, await request);
  }

  $async.Future<$24.GetInsuranceByIdResponse> getInsuranceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInsuranceByIdRequest> request) async {
    return getInsuranceById(call, await request);
  }

  $async.Future<$24.CreateInsuranceResponse> createInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.CreateInsuranceRequest> request) async {
    return createInsurance(call, await request);
  }

  $async.Future<$24.UpdateInsuranceResponse> updateInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.UpdateInsuranceRequest> request) async {
    return updateInsurance(call, await request);
  }

  $async.Future<$24.DeleteInsuranceResponse> deleteInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.DeleteInsuranceRequest> request) async {
    return deleteInsurance(call, await request);
  }

  $async.Future<$24.SearchInsurancesResponse> searchInsurances_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.SearchInsurancesRequest> request) async {
    return searchInsurances(call, await request);
  }

  $async.Future<$24.GetInsurancePaymentsResponse> getInsurancePayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInsurancePaymentsRequest> request) async {
    return getInsurancePayments(call, await request);
  }

  $async.Future<$24.GetUserPaymentsResponse> getUserPayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetUserPaymentsRequest> request) async {
    return getUserPayments(call, await request);
  }

  $async.Future<$24.CreatePaymentResponse> createPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.CreatePaymentRequest> request) async {
    return createPayment(call, await request);
  }

  $async.Future<$24.ProcessPaymentResponse> processPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.ProcessPaymentRequest> request) async {
    return processPayment(call, await request);
  }

  $async.Future<$24.GetPaymentByIdResponse> getPaymentById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetPaymentByIdRequest> request) async {
    return getPaymentById(call, await request);
  }

  $async.Future<$24.GetOverduePaymentsResponse> getOverduePayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetOverduePaymentsRequest> request) async {
    return getOverduePayments(call, await request);
  }

  $async.Future<$24.GetInsuranceClaimsResponse> getInsuranceClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInsuranceClaimsRequest> request) async {
    return getInsuranceClaims(call, await request);
  }

  $async.Future<$24.GetUserClaimsResponse> getUserClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetUserClaimsRequest> request) async {
    return getUserClaims(call, await request);
  }

  $async.Future<$24.CreateClaimResponse> createClaim_Pre($grpc.ServiceCall call,
      $async.Future<$24.CreateClaimRequest> request) async {
    return createClaim(call, await request);
  }

  $async.Future<$24.UpdateClaimResponse> updateClaim_Pre($grpc.ServiceCall call,
      $async.Future<$24.UpdateClaimRequest> request) async {
    return updateClaim(call, await request);
  }

  $async.Future<$24.GetClaimByIdResponse> getClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetClaimByIdRequest> request) async {
    return getClaimById(call, await request);
  }

  $async.Future<$24.GeneratePaymentReceiptResponse> generatePaymentReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GeneratePaymentReceiptRequest> request) async {
    return generatePaymentReceipt(call, await request);
  }

  $async.Future<$24.GetUserReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetUserReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$24.GetInsuranceStatisticsResponse> getInsuranceStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInsuranceStatisticsRequest> request) async {
    return getInsuranceStatistics(call, await request);
  }

  $async.Future<$24.GetPaymentStatisticsResponse> getPaymentStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetPaymentStatisticsRequest> request) async {
    return getPaymentStatistics(call, await request);
  }

  $async.Future<$24.GetInsuranceProductsResponse> getInsuranceProducts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInsuranceProductsRequest> request) async {
    return getInsuranceProducts(call, await request);
  }

  $async.Future<$24.GetInsuranceCategoriesResponse> getInsuranceCategories_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInsuranceCategoriesRequest> request) async {
    return getInsuranceCategories(call, await request);
  }

  $async.Future<$24.GetInsuranceQuoteResponse> getInsuranceQuote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInsuranceQuoteRequest> request) async {
    return getInsuranceQuote(call, await request);
  }

  $async.Future<$24.PurchaseInsuranceResponse> purchaseInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.PurchaseInsuranceRequest> request) async {
    return purchaseInsurance(call, await request);
  }

  $async.Future<$24.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus_Pre($grpc.ServiceCall call,
          $async.Future<$24.GetInsurancePurchaseStatusRequest> request) async {
    return getInsurancePurchaseStatus(call, await request);
  }

  $async.Future<$24.UploadInsuranceDocumentResponse>
      uploadInsuranceDocument_Pre($grpc.ServiceCall call,
          $async.Future<$24.UploadInsuranceDocumentRequest> request) async {
    return uploadInsuranceDocument(call, await request);
  }

  $async.Future<$24.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData_Pre($grpc.ServiceCall call,
          $async.Future<$24.GetInsuranceAuxiliaryDataRequest> request) async {
    return getInsuranceAuxiliaryData(call, await request);
  }

  $async.Future<$24.GetMyCoverCustomersResponse> getMyCoverCustomers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetMyCoverCustomersRequest> request) async {
    return getMyCoverCustomers(call, await request);
  }

  $async.Future<$24.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetMyCoverCustomerByIdRequest> request) async {
    return getMyCoverCustomerById(call, await request);
  }

  $async.Future<$24.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies_Pre($grpc.ServiceCall call,
          $async.Future<$24.GetMyCoverCustomerPoliciesRequest> request) async {
    return getMyCoverCustomerPolicies(call, await request);
  }

  $async.Future<$24.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases_Pre($grpc.ServiceCall call,
          $async.Future<$24.GetMyCoverCustomerPurchasesRequest> request) async {
    return getMyCoverCustomerPurchases(call, await request);
  }

  $async.Future<$24.GetMyCoverPurchasesResponse> getMyCoverPurchases_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetMyCoverPurchasesRequest> request) async {
    return getMyCoverPurchases(call, await request);
  }

  $async.Future<$24.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetMyCoverPurchaseByIdRequest> request) async {
    return getMyCoverPurchaseById(call, await request);
  }

  $async.Future<$24.GetMyCoverClaimsResponse> getMyCoverClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetMyCoverClaimsRequest> request) async {
    return getMyCoverClaims(call, await request);
  }

  $async.Future<$24.GetMyCoverClaimByIdResponse> getMyCoverClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetMyCoverClaimByIdRequest> request) async {
    return getMyCoverClaimById(call, await request);
  }

  $async.Future<$24.FileCreditLifeClaimResponse> fileCreditLifeClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.FileCreditLifeClaimRequest> request) async {
    return fileCreditLifeClaim(call, await request);
  }

  $async.Future<$24.GetInsuranceStatesResponse> getInsuranceStates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.GetInsuranceStatesRequest> request) async {
    return getInsuranceStates(call, await request);
  }

  $async.Future<$24.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes_Pre($grpc.ServiceCall call,
          $async.Future<$24.GetInsuranceVehicleMakesRequest> request) async {
    return getInsuranceVehicleMakes(call, await request);
  }

  $async.Future<$24.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$24.GetMyCoverNotificationPreferencesRequest>
              request) async {
    return getMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$24.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$24.UpdateMyCoverNotificationPreferencesRequest>
              request) async {
    return updateMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$24.GetMyCoverWalletBalanceResponse>
      getMyCoverWalletBalance_Pre($grpc.ServiceCall call,
          $async.Future<$24.GetMyCoverWalletBalanceRequest> request) async {
    return getMyCoverWalletBalance(call, await request);
  }

  $async.Future<$24.RequestInsuranceRefundResponse> requestInsuranceRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$24.RequestInsuranceRefundRequest> request) async {
    return requestInsuranceRefund(call, await request);
  }

  $async.Future<$24.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus_Pre($grpc.ServiceCall call,
          $async.Future<$24.GetInsuranceRefundStatusRequest> request) async {
    return getInsuranceRefundStatus(call, await request);
  }

  $async.Future<$24.GetUserInsurancesResponse> getUserInsurances(
      $grpc.ServiceCall call, $24.GetUserInsurancesRequest request);
  $async.Future<$24.GetInsuranceByIdResponse> getInsuranceById(
      $grpc.ServiceCall call, $24.GetInsuranceByIdRequest request);
  $async.Future<$24.CreateInsuranceResponse> createInsurance(
      $grpc.ServiceCall call, $24.CreateInsuranceRequest request);
  $async.Future<$24.UpdateInsuranceResponse> updateInsurance(
      $grpc.ServiceCall call, $24.UpdateInsuranceRequest request);
  $async.Future<$24.DeleteInsuranceResponse> deleteInsurance(
      $grpc.ServiceCall call, $24.DeleteInsuranceRequest request);
  $async.Future<$24.SearchInsurancesResponse> searchInsurances(
      $grpc.ServiceCall call, $24.SearchInsurancesRequest request);
  $async.Future<$24.GetInsurancePaymentsResponse> getInsurancePayments(
      $grpc.ServiceCall call, $24.GetInsurancePaymentsRequest request);
  $async.Future<$24.GetUserPaymentsResponse> getUserPayments(
      $grpc.ServiceCall call, $24.GetUserPaymentsRequest request);
  $async.Future<$24.CreatePaymentResponse> createPayment(
      $grpc.ServiceCall call, $24.CreatePaymentRequest request);
  $async.Future<$24.ProcessPaymentResponse> processPayment(
      $grpc.ServiceCall call, $24.ProcessPaymentRequest request);
  $async.Future<$24.GetPaymentByIdResponse> getPaymentById(
      $grpc.ServiceCall call, $24.GetPaymentByIdRequest request);
  $async.Future<$24.GetOverduePaymentsResponse> getOverduePayments(
      $grpc.ServiceCall call, $24.GetOverduePaymentsRequest request);
  $async.Future<$24.GetInsuranceClaimsResponse> getInsuranceClaims(
      $grpc.ServiceCall call, $24.GetInsuranceClaimsRequest request);
  $async.Future<$24.GetUserClaimsResponse> getUserClaims(
      $grpc.ServiceCall call, $24.GetUserClaimsRequest request);
  $async.Future<$24.CreateClaimResponse> createClaim(
      $grpc.ServiceCall call, $24.CreateClaimRequest request);
  $async.Future<$24.UpdateClaimResponse> updateClaim(
      $grpc.ServiceCall call, $24.UpdateClaimRequest request);
  $async.Future<$24.GetClaimByIdResponse> getClaimById(
      $grpc.ServiceCall call, $24.GetClaimByIdRequest request);
  $async.Future<$24.GeneratePaymentReceiptResponse> generatePaymentReceipt(
      $grpc.ServiceCall call, $24.GeneratePaymentReceiptRequest request);
  $async.Future<$24.GetUserReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $24.GetUserReceiptsRequest request);
  $async.Future<$24.GetInsuranceStatisticsResponse> getInsuranceStatistics(
      $grpc.ServiceCall call, $24.GetInsuranceStatisticsRequest request);
  $async.Future<$24.GetPaymentStatisticsResponse> getPaymentStatistics(
      $grpc.ServiceCall call, $24.GetPaymentStatisticsRequest request);
  $async.Future<$24.GetInsuranceProductsResponse> getInsuranceProducts(
      $grpc.ServiceCall call, $24.GetInsuranceProductsRequest request);
  $async.Future<$24.GetInsuranceCategoriesResponse> getInsuranceCategories(
      $grpc.ServiceCall call, $24.GetInsuranceCategoriesRequest request);
  $async.Future<$24.GetInsuranceQuoteResponse> getInsuranceQuote(
      $grpc.ServiceCall call, $24.GetInsuranceQuoteRequest request);
  $async.Future<$24.PurchaseInsuranceResponse> purchaseInsurance(
      $grpc.ServiceCall call, $24.PurchaseInsuranceRequest request);
  $async.Future<$24.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus($grpc.ServiceCall call,
          $24.GetInsurancePurchaseStatusRequest request);
  $async.Future<$24.UploadInsuranceDocumentResponse> uploadInsuranceDocument(
      $grpc.ServiceCall call, $24.UploadInsuranceDocumentRequest request);
  $async.Future<$24.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData(
          $grpc.ServiceCall call, $24.GetInsuranceAuxiliaryDataRequest request);
  $async.Future<$24.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $grpc.ServiceCall call, $24.GetMyCoverCustomersRequest request);
  $async.Future<$24.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById(
      $grpc.ServiceCall call, $24.GetMyCoverCustomerByIdRequest request);
  $async.Future<$24.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies($grpc.ServiceCall call,
          $24.GetMyCoverCustomerPoliciesRequest request);
  $async.Future<$24.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases($grpc.ServiceCall call,
          $24.GetMyCoverCustomerPurchasesRequest request);
  $async.Future<$24.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $grpc.ServiceCall call, $24.GetMyCoverPurchasesRequest request);
  $async.Future<$24.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById(
      $grpc.ServiceCall call, $24.GetMyCoverPurchaseByIdRequest request);
  $async.Future<$24.GetMyCoverClaimsResponse> getMyCoverClaims(
      $grpc.ServiceCall call, $24.GetMyCoverClaimsRequest request);
  $async.Future<$24.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $grpc.ServiceCall call, $24.GetMyCoverClaimByIdRequest request);
  $async.Future<$24.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $grpc.ServiceCall call, $24.FileCreditLifeClaimRequest request);
  $async.Future<$24.GetInsuranceStatesResponse> getInsuranceStates(
      $grpc.ServiceCall call, $24.GetInsuranceStatesRequest request);
  $async.Future<$24.GetInsuranceVehicleMakesResponse> getInsuranceVehicleMakes(
      $grpc.ServiceCall call, $24.GetInsuranceVehicleMakesRequest request);
  $async.Future<$24.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences($grpc.ServiceCall call,
          $24.GetMyCoverNotificationPreferencesRequest request);
  $async.Future<$24.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences($grpc.ServiceCall call,
          $24.UpdateMyCoverNotificationPreferencesRequest request);
  $async.Future<$24.GetMyCoverWalletBalanceResponse> getMyCoverWalletBalance(
      $grpc.ServiceCall call, $24.GetMyCoverWalletBalanceRequest request);
  $async.Future<$24.RequestInsuranceRefundResponse> requestInsuranceRefund(
      $grpc.ServiceCall call, $24.RequestInsuranceRefundRequest request);
  $async.Future<$24.GetInsuranceRefundStatusResponse> getInsuranceRefundStatus(
      $grpc.ServiceCall call, $24.GetInsuranceRefundStatusRequest request);
}
