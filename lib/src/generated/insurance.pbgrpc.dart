///
//  Generated code. Do not modify.
//  source: insurance.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'insurance.pb.dart' as $23;
export 'insurance.pb.dart';

class InsuranceServiceClient extends $grpc.Client {
  static final _$getUserInsurances = $grpc.ClientMethod<
          $23.GetUserInsurancesRequest, $23.GetUserInsurancesResponse>(
      '/pb.InsuranceService/GetUserInsurances',
      ($23.GetUserInsurancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetUserInsurancesResponse.fromBuffer(value));
  static final _$getInsuranceById = $grpc.ClientMethod<
          $23.GetInsuranceByIdRequest, $23.GetInsuranceByIdResponse>(
      '/pb.InsuranceService/GetInsuranceById',
      ($23.GetInsuranceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceByIdResponse.fromBuffer(value));
  static final _$createInsurance = $grpc.ClientMethod<
          $23.CreateInsuranceRequest, $23.CreateInsuranceResponse>(
      '/pb.InsuranceService/CreateInsurance',
      ($23.CreateInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.CreateInsuranceResponse.fromBuffer(value));
  static final _$updateInsurance = $grpc.ClientMethod<
          $23.UpdateInsuranceRequest, $23.UpdateInsuranceResponse>(
      '/pb.InsuranceService/UpdateInsurance',
      ($23.UpdateInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UpdateInsuranceResponse.fromBuffer(value));
  static final _$deleteInsurance = $grpc.ClientMethod<
          $23.DeleteInsuranceRequest, $23.DeleteInsuranceResponse>(
      '/pb.InsuranceService/DeleteInsurance',
      ($23.DeleteInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.DeleteInsuranceResponse.fromBuffer(value));
  static final _$searchInsurances = $grpc.ClientMethod<
          $23.SearchInsurancesRequest, $23.SearchInsurancesResponse>(
      '/pb.InsuranceService/SearchInsurances',
      ($23.SearchInsurancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.SearchInsurancesResponse.fromBuffer(value));
  static final _$getInsurancePayments = $grpc.ClientMethod<
          $23.GetInsurancePaymentsRequest, $23.GetInsurancePaymentsResponse>(
      '/pb.InsuranceService/GetInsurancePayments',
      ($23.GetInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsurancePaymentsResponse.fromBuffer(value));
  static final _$getUserPayments = $grpc.ClientMethod<
          $23.GetUserPaymentsRequest, $23.GetUserPaymentsResponse>(
      '/pb.InsuranceService/GetUserPayments',
      ($23.GetUserPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetUserPaymentsResponse.fromBuffer(value));
  static final _$createPayment =
      $grpc.ClientMethod<$23.CreatePaymentRequest, $23.CreatePaymentResponse>(
          '/pb.InsuranceService/CreatePayment',
          ($23.CreatePaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.CreatePaymentResponse.fromBuffer(value));
  static final _$processPayment =
      $grpc.ClientMethod<$23.ProcessPaymentRequest, $23.ProcessPaymentResponse>(
          '/pb.InsuranceService/ProcessPayment',
          ($23.ProcessPaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.ProcessPaymentResponse.fromBuffer(value));
  static final _$getPaymentById =
      $grpc.ClientMethod<$23.GetPaymentByIdRequest, $23.GetPaymentByIdResponse>(
          '/pb.InsuranceService/GetPaymentById',
          ($23.GetPaymentByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetPaymentByIdResponse.fromBuffer(value));
  static final _$getOverduePayments = $grpc.ClientMethod<
          $23.GetOverduePaymentsRequest, $23.GetOverduePaymentsResponse>(
      '/pb.InsuranceService/GetOverduePayments',
      ($23.GetOverduePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetOverduePaymentsResponse.fromBuffer(value));
  static final _$getInsuranceClaims = $grpc.ClientMethod<
          $23.GetInsuranceClaimsRequest, $23.GetInsuranceClaimsResponse>(
      '/pb.InsuranceService/GetInsuranceClaims',
      ($23.GetInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceClaimsResponse.fromBuffer(value));
  static final _$getUserClaims =
      $grpc.ClientMethod<$23.GetUserClaimsRequest, $23.GetUserClaimsResponse>(
          '/pb.InsuranceService/GetUserClaims',
          ($23.GetUserClaimsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetUserClaimsResponse.fromBuffer(value));
  static final _$createClaim =
      $grpc.ClientMethod<$23.CreateClaimRequest, $23.CreateClaimResponse>(
          '/pb.InsuranceService/CreateClaim',
          ($23.CreateClaimRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.CreateClaimResponse.fromBuffer(value));
  static final _$updateClaim =
      $grpc.ClientMethod<$23.UpdateClaimRequest, $23.UpdateClaimResponse>(
          '/pb.InsuranceService/UpdateClaim',
          ($23.UpdateClaimRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.UpdateClaimResponse.fromBuffer(value));
  static final _$getClaimById =
      $grpc.ClientMethod<$23.GetClaimByIdRequest, $23.GetClaimByIdResponse>(
          '/pb.InsuranceService/GetClaimById',
          ($23.GetClaimByIdRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetClaimByIdResponse.fromBuffer(value));
  static final _$generatePaymentReceipt = $grpc.ClientMethod<
          $23.GeneratePaymentReceiptRequest,
          $23.GeneratePaymentReceiptResponse>(
      '/pb.InsuranceService/GeneratePaymentReceipt',
      ($23.GeneratePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GeneratePaymentReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<
          $23.GetUserReceiptsRequest, $23.GetUserReceiptsResponse>(
      '/pb.InsuranceService/GetUserReceipts',
      ($23.GetUserReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetUserReceiptsResponse.fromBuffer(value));
  static final _$getInsuranceStatistics = $grpc.ClientMethod<
          $23.GetInsuranceStatisticsRequest,
          $23.GetInsuranceStatisticsResponse>(
      '/pb.InsuranceService/GetInsuranceStatistics',
      ($23.GetInsuranceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceStatisticsResponse.fromBuffer(value));
  static final _$getPaymentStatistics = $grpc.ClientMethod<
          $23.GetPaymentStatisticsRequest, $23.GetPaymentStatisticsResponse>(
      '/pb.InsuranceService/GetPaymentStatistics',
      ($23.GetPaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetPaymentStatisticsResponse.fromBuffer(value));
  static final _$getInsuranceProducts = $grpc.ClientMethod<
          $23.GetInsuranceProductsRequest, $23.GetInsuranceProductsResponse>(
      '/pb.InsuranceService/GetInsuranceProducts',
      ($23.GetInsuranceProductsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceProductsResponse.fromBuffer(value));
  static final _$getInsuranceCategories = $grpc.ClientMethod<
          $23.GetInsuranceCategoriesRequest,
          $23.GetInsuranceCategoriesResponse>(
      '/pb.InsuranceService/GetInsuranceCategories',
      ($23.GetInsuranceCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceCategoriesResponse.fromBuffer(value));
  static final _$getInsuranceQuote = $grpc.ClientMethod<
          $23.GetInsuranceQuoteRequest, $23.GetInsuranceQuoteResponse>(
      '/pb.InsuranceService/GetInsuranceQuote',
      ($23.GetInsuranceQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceQuoteResponse.fromBuffer(value));
  static final _$purchaseInsurance = $grpc.ClientMethod<
          $23.PurchaseInsuranceRequest, $23.PurchaseInsuranceResponse>(
      '/pb.InsuranceService/PurchaseInsurance',
      ($23.PurchaseInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.PurchaseInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePurchaseStatus = $grpc.ClientMethod<
          $23.GetInsurancePurchaseStatusRequest,
          $23.GetInsurancePurchaseStatusResponse>(
      '/pb.InsuranceService/GetInsurancePurchaseStatus',
      ($23.GetInsurancePurchaseStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsurancePurchaseStatusResponse.fromBuffer(value));
  static final _$uploadInsuranceDocument = $grpc.ClientMethod<
          $23.UploadInsuranceDocumentRequest,
          $23.UploadInsuranceDocumentResponse>(
      '/pb.InsuranceService/UploadInsuranceDocument',
      ($23.UploadInsuranceDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UploadInsuranceDocumentResponse.fromBuffer(value));
  static final _$getInsuranceAuxiliaryData = $grpc.ClientMethod<
          $23.GetInsuranceAuxiliaryDataRequest,
          $23.GetInsuranceAuxiliaryDataResponse>(
      '/pb.InsuranceService/GetInsuranceAuxiliaryData',
      ($23.GetInsuranceAuxiliaryDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceAuxiliaryDataResponse.fromBuffer(value));
  static final _$getMyCoverCustomers = $grpc.ClientMethod<
          $23.GetMyCoverCustomersRequest, $23.GetMyCoverCustomersResponse>(
      '/pb.InsuranceService/GetMyCoverCustomers',
      ($23.GetMyCoverCustomersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverCustomersResponse.fromBuffer(value));
  static final _$getMyCoverCustomerById = $grpc.ClientMethod<
          $23.GetMyCoverCustomerByIdRequest,
          $23.GetMyCoverCustomerByIdResponse>(
      '/pb.InsuranceService/GetMyCoverCustomerById',
      ($23.GetMyCoverCustomerByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverCustomerByIdResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPolicies = $grpc.ClientMethod<
          $23.GetMyCoverCustomerPoliciesRequest,
          $23.GetMyCoverCustomerPoliciesResponse>(
      '/pb.InsuranceService/GetMyCoverCustomerPolicies',
      ($23.GetMyCoverCustomerPoliciesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverCustomerPoliciesResponse.fromBuffer(value));
  static final _$getMyCoverCustomerPurchases = $grpc.ClientMethod<
          $23.GetMyCoverCustomerPurchasesRequest,
          $23.GetMyCoverCustomerPurchasesResponse>(
      '/pb.InsuranceService/GetMyCoverCustomerPurchases',
      ($23.GetMyCoverCustomerPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverCustomerPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchases = $grpc.ClientMethod<
          $23.GetMyCoverPurchasesRequest, $23.GetMyCoverPurchasesResponse>(
      '/pb.InsuranceService/GetMyCoverPurchases',
      ($23.GetMyCoverPurchasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverPurchasesResponse.fromBuffer(value));
  static final _$getMyCoverPurchaseById = $grpc.ClientMethod<
          $23.GetMyCoverPurchaseByIdRequest,
          $23.GetMyCoverPurchaseByIdResponse>(
      '/pb.InsuranceService/GetMyCoverPurchaseById',
      ($23.GetMyCoverPurchaseByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverPurchaseByIdResponse.fromBuffer(value));
  static final _$getMyCoverClaims = $grpc.ClientMethod<
          $23.GetMyCoverClaimsRequest, $23.GetMyCoverClaimsResponse>(
      '/pb.InsuranceService/GetMyCoverClaims',
      ($23.GetMyCoverClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverClaimsResponse.fromBuffer(value));
  static final _$getMyCoverClaimById = $grpc.ClientMethod<
          $23.GetMyCoverClaimByIdRequest, $23.GetMyCoverClaimByIdResponse>(
      '/pb.InsuranceService/GetMyCoverClaimById',
      ($23.GetMyCoverClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverClaimByIdResponse.fromBuffer(value));
  static final _$fileCreditLifeClaim = $grpc.ClientMethod<
          $23.FileCreditLifeClaimRequest, $23.FileCreditLifeClaimResponse>(
      '/pb.InsuranceService/FileCreditLifeClaim',
      ($23.FileCreditLifeClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.FileCreditLifeClaimResponse.fromBuffer(value));
  static final _$getInsuranceStates = $grpc.ClientMethod<
          $23.GetInsuranceStatesRequest, $23.GetInsuranceStatesResponse>(
      '/pb.InsuranceService/GetInsuranceStates',
      ($23.GetInsuranceStatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceStatesResponse.fromBuffer(value));
  static final _$getInsuranceVehicleMakes = $grpc.ClientMethod<
          $23.GetInsuranceVehicleMakesRequest,
          $23.GetInsuranceVehicleMakesResponse>(
      '/pb.InsuranceService/GetInsuranceVehicleMakes',
      ($23.GetInsuranceVehicleMakesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceVehicleMakesResponse.fromBuffer(value));
  static final _$getMyCoverNotificationPreferences = $grpc.ClientMethod<
          $23.GetMyCoverNotificationPreferencesRequest,
          $23.GetMyCoverNotificationPreferencesResponse>(
      '/pb.InsuranceService/GetMyCoverNotificationPreferences',
      ($23.GetMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$updateMyCoverNotificationPreferences = $grpc.ClientMethod<
          $23.UpdateMyCoverNotificationPreferencesRequest,
          $23.UpdateMyCoverNotificationPreferencesResponse>(
      '/pb.InsuranceService/UpdateMyCoverNotificationPreferences',
      ($23.UpdateMyCoverNotificationPreferencesRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UpdateMyCoverNotificationPreferencesResponse.fromBuffer(value));
  static final _$getMyCoverWalletBalance = $grpc.ClientMethod<
          $23.GetMyCoverWalletBalanceRequest,
          $23.GetMyCoverWalletBalanceResponse>(
      '/pb.InsuranceService/GetMyCoverWalletBalance',
      ($23.GetMyCoverWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyCoverWalletBalanceResponse.fromBuffer(value));
  static final _$requestInsuranceRefund = $grpc.ClientMethod<
          $23.RequestInsuranceRefundRequest,
          $23.RequestInsuranceRefundResponse>(
      '/pb.InsuranceService/RequestInsuranceRefund',
      ($23.RequestInsuranceRefundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.RequestInsuranceRefundResponse.fromBuffer(value));
  static final _$getInsuranceRefundStatus = $grpc.ClientMethod<
          $23.GetInsuranceRefundStatusRequest,
          $23.GetInsuranceRefundStatusResponse>(
      '/pb.InsuranceService/GetInsuranceRefundStatus',
      ($23.GetInsuranceRefundStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetInsuranceRefundStatusResponse.fromBuffer(value));

  InsuranceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$23.GetUserInsurancesResponse> getUserInsurances(
      $23.GetUserInsurancesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsurances, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceByIdResponse> getInsuranceById(
      $23.GetInsuranceByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceById, request, options: options);
  }

  $grpc.ResponseFuture<$23.CreateInsuranceResponse> createInsurance(
      $23.CreateInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$23.UpdateInsuranceResponse> updateInsurance(
      $23.UpdateInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$23.DeleteInsuranceResponse> deleteInsurance(
      $23.DeleteInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$23.SearchInsurancesResponse> searchInsurances(
      $23.SearchInsurancesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchInsurances, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsurancePaymentsResponse> getInsurancePayments(
      $23.GetInsurancePaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePayments, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetUserPaymentsResponse> getUserPayments(
      $23.GetUserPaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPayments, request, options: options);
  }

  $grpc.ResponseFuture<$23.CreatePaymentResponse> createPayment(
      $23.CreatePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.ProcessPaymentResponse> processPayment(
      $23.ProcessPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayment, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetPaymentByIdResponse> getPaymentById(
      $23.GetPaymentByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentById, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetOverduePaymentsResponse> getOverduePayments(
      $23.GetOverduePaymentsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverduePayments, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceClaimsResponse> getInsuranceClaims(
      $23.GetInsuranceClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaims, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetUserClaimsResponse> getUserClaims(
      $23.GetUserClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserClaims, request, options: options);
  }

  $grpc.ResponseFuture<$23.CreateClaimResponse> createClaim(
      $23.CreateClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createClaim, request, options: options);
  }

  $grpc.ResponseFuture<$23.UpdateClaimResponse> updateClaim(
      $23.UpdateClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateClaim, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetClaimByIdResponse> getClaimById(
      $23.GetClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$23.GeneratePaymentReceiptResponse>
      generatePaymentReceipt($23.GeneratePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generatePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetUserReceiptsResponse> getUserReceipts(
      $23.GetUserReceiptsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceStatisticsResponse>
      getInsuranceStatistics($23.GetInsuranceStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetPaymentStatisticsResponse> getPaymentStatistics(
      $23.GetPaymentStatisticsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceProductsResponse> getInsuranceProducts(
      $23.GetInsuranceProductsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceProducts, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceCategoriesResponse>
      getInsuranceCategories($23.GetInsuranceCategoriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceCategories, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceQuoteResponse> getInsuranceQuote(
      $23.GetInsuranceQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceQuote, request, options: options);
  }

  $grpc.ResponseFuture<$23.PurchaseInsuranceResponse> purchaseInsurance(
      $23.PurchaseInsuranceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus($23.GetInsurancePurchaseStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePurchaseStatus, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.UploadInsuranceDocumentResponse>
      uploadInsuranceDocument($23.UploadInsuranceDocumentRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadInsuranceDocument, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData($23.GetInsuranceAuxiliaryDataRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceAuxiliaryData, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $23.GetMyCoverCustomersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomers, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverCustomerByIdResponse>
      getMyCoverCustomerById($23.GetMyCoverCustomerByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerById, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies($23.GetMyCoverCustomerPoliciesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPolicies, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases(
          $23.GetMyCoverCustomerPurchasesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverCustomerPurchases, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $23.GetMyCoverPurchasesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchases, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverPurchaseByIdResponse>
      getMyCoverPurchaseById($23.GetMyCoverPurchaseByIdRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverPurchaseById, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverClaimsResponse> getMyCoverClaims(
      $23.GetMyCoverClaimsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaims, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $23.GetMyCoverClaimByIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$23.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $23.FileCreditLifeClaimRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fileCreditLifeClaim, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceStatesResponse> getInsuranceStates(
      $23.GetInsuranceStatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStates, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes($23.GetInsuranceVehicleMakesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceVehicleMakes, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences(
          $23.GetMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences(
          $23.UpdateMyCoverNotificationPreferencesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMyCoverNotificationPreferences, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetMyCoverWalletBalanceResponse>
      getMyCoverWalletBalance($23.GetMyCoverWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCoverWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.RequestInsuranceRefundResponse>
      requestInsuranceRefund($23.RequestInsuranceRefundRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestInsuranceRefund, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus($23.GetInsuranceRefundStatusRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceRefundStatus, request,
        options: options);
  }
}

abstract class InsuranceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InsuranceService';

  InsuranceServiceBase() {
    $addMethod($grpc.ServiceMethod<$23.GetUserInsurancesRequest,
            $23.GetUserInsurancesResponse>(
        'GetUserInsurances',
        getUserInsurances_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetUserInsurancesRequest.fromBuffer(value),
        ($23.GetUserInsurancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceByIdRequest,
            $23.GetInsuranceByIdResponse>(
        'GetInsuranceById',
        getInsuranceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceByIdRequest.fromBuffer(value),
        ($23.GetInsuranceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.CreateInsuranceRequest,
            $23.CreateInsuranceResponse>(
        'CreateInsurance',
        createInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.CreateInsuranceRequest.fromBuffer(value),
        ($23.CreateInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UpdateInsuranceRequest,
            $23.UpdateInsuranceResponse>(
        'UpdateInsurance',
        updateInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UpdateInsuranceRequest.fromBuffer(value),
        ($23.UpdateInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.DeleteInsuranceRequest,
            $23.DeleteInsuranceResponse>(
        'DeleteInsurance',
        deleteInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.DeleteInsuranceRequest.fromBuffer(value),
        ($23.DeleteInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.SearchInsurancesRequest,
            $23.SearchInsurancesResponse>(
        'SearchInsurances',
        searchInsurances_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.SearchInsurancesRequest.fromBuffer(value),
        ($23.SearchInsurancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsurancePaymentsRequest,
            $23.GetInsurancePaymentsResponse>(
        'GetInsurancePayments',
        getInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsurancePaymentsRequest.fromBuffer(value),
        ($23.GetInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetUserPaymentsRequest,
            $23.GetUserPaymentsResponse>(
        'GetUserPayments',
        getUserPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetUserPaymentsRequest.fromBuffer(value),
        ($23.GetUserPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.CreatePaymentRequest,
            $23.CreatePaymentResponse>(
        'CreatePayment',
        createPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.CreatePaymentRequest.fromBuffer(value),
        ($23.CreatePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.ProcessPaymentRequest,
            $23.ProcessPaymentResponse>(
        'ProcessPayment',
        processPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.ProcessPaymentRequest.fromBuffer(value),
        ($23.ProcessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetPaymentByIdRequest,
            $23.GetPaymentByIdResponse>(
        'GetPaymentById',
        getPaymentById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetPaymentByIdRequest.fromBuffer(value),
        ($23.GetPaymentByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetOverduePaymentsRequest,
            $23.GetOverduePaymentsResponse>(
        'GetOverduePayments',
        getOverduePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetOverduePaymentsRequest.fromBuffer(value),
        ($23.GetOverduePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceClaimsRequest,
            $23.GetInsuranceClaimsResponse>(
        'GetInsuranceClaims',
        getInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceClaimsRequest.fromBuffer(value),
        ($23.GetInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetUserClaimsRequest,
            $23.GetUserClaimsResponse>(
        'GetUserClaims',
        getUserClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetUserClaimsRequest.fromBuffer(value),
        ($23.GetUserClaimsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$23.CreateClaimRequest, $23.CreateClaimResponse>(
            'CreateClaim',
            createClaim_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.CreateClaimRequest.fromBuffer(value),
            ($23.CreateClaimResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$23.UpdateClaimRequest, $23.UpdateClaimResponse>(
            'UpdateClaim',
            updateClaim_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.UpdateClaimRequest.fromBuffer(value),
            ($23.UpdateClaimResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$23.GetClaimByIdRequest, $23.GetClaimByIdResponse>(
            'GetClaimById',
            getClaimById_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.GetClaimByIdRequest.fromBuffer(value),
            ($23.GetClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GeneratePaymentReceiptRequest,
            $23.GeneratePaymentReceiptResponse>(
        'GeneratePaymentReceipt',
        generatePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GeneratePaymentReceiptRequest.fromBuffer(value),
        ($23.GeneratePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetUserReceiptsRequest,
            $23.GetUserReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetUserReceiptsRequest.fromBuffer(value),
        ($23.GetUserReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceStatisticsRequest,
            $23.GetInsuranceStatisticsResponse>(
        'GetInsuranceStatistics',
        getInsuranceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceStatisticsRequest.fromBuffer(value),
        ($23.GetInsuranceStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetPaymentStatisticsRequest,
            $23.GetPaymentStatisticsResponse>(
        'GetPaymentStatistics',
        getPaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetPaymentStatisticsRequest.fromBuffer(value),
        ($23.GetPaymentStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceProductsRequest,
            $23.GetInsuranceProductsResponse>(
        'GetInsuranceProducts',
        getInsuranceProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceProductsRequest.fromBuffer(value),
        ($23.GetInsuranceProductsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceCategoriesRequest,
            $23.GetInsuranceCategoriesResponse>(
        'GetInsuranceCategories',
        getInsuranceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceCategoriesRequest.fromBuffer(value),
        ($23.GetInsuranceCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceQuoteRequest,
            $23.GetInsuranceQuoteResponse>(
        'GetInsuranceQuote',
        getInsuranceQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceQuoteRequest.fromBuffer(value),
        ($23.GetInsuranceQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.PurchaseInsuranceRequest,
            $23.PurchaseInsuranceResponse>(
        'PurchaseInsurance',
        purchaseInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.PurchaseInsuranceRequest.fromBuffer(value),
        ($23.PurchaseInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsurancePurchaseStatusRequest,
            $23.GetInsurancePurchaseStatusResponse>(
        'GetInsurancePurchaseStatus',
        getInsurancePurchaseStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsurancePurchaseStatusRequest.fromBuffer(value),
        ($23.GetInsurancePurchaseStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UploadInsuranceDocumentRequest,
            $23.UploadInsuranceDocumentResponse>(
        'UploadInsuranceDocument',
        uploadInsuranceDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UploadInsuranceDocumentRequest.fromBuffer(value),
        ($23.UploadInsuranceDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceAuxiliaryDataRequest,
            $23.GetInsuranceAuxiliaryDataResponse>(
        'GetInsuranceAuxiliaryData',
        getInsuranceAuxiliaryData_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceAuxiliaryDataRequest.fromBuffer(value),
        ($23.GetInsuranceAuxiliaryDataResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverCustomersRequest,
            $23.GetMyCoverCustomersResponse>(
        'GetMyCoverCustomers',
        getMyCoverCustomers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverCustomersRequest.fromBuffer(value),
        ($23.GetMyCoverCustomersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverCustomerByIdRequest,
            $23.GetMyCoverCustomerByIdResponse>(
        'GetMyCoverCustomerById',
        getMyCoverCustomerById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverCustomerByIdRequest.fromBuffer(value),
        ($23.GetMyCoverCustomerByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverCustomerPoliciesRequest,
            $23.GetMyCoverCustomerPoliciesResponse>(
        'GetMyCoverCustomerPolicies',
        getMyCoverCustomerPolicies_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverCustomerPoliciesRequest.fromBuffer(value),
        ($23.GetMyCoverCustomerPoliciesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverCustomerPurchasesRequest,
            $23.GetMyCoverCustomerPurchasesResponse>(
        'GetMyCoverCustomerPurchases',
        getMyCoverCustomerPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverCustomerPurchasesRequest.fromBuffer(value),
        ($23.GetMyCoverCustomerPurchasesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverPurchasesRequest,
            $23.GetMyCoverPurchasesResponse>(
        'GetMyCoverPurchases',
        getMyCoverPurchases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverPurchasesRequest.fromBuffer(value),
        ($23.GetMyCoverPurchasesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverPurchaseByIdRequest,
            $23.GetMyCoverPurchaseByIdResponse>(
        'GetMyCoverPurchaseById',
        getMyCoverPurchaseById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverPurchaseByIdRequest.fromBuffer(value),
        ($23.GetMyCoverPurchaseByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverClaimsRequest,
            $23.GetMyCoverClaimsResponse>(
        'GetMyCoverClaims',
        getMyCoverClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverClaimsRequest.fromBuffer(value),
        ($23.GetMyCoverClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverClaimByIdRequest,
            $23.GetMyCoverClaimByIdResponse>(
        'GetMyCoverClaimById',
        getMyCoverClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverClaimByIdRequest.fromBuffer(value),
        ($23.GetMyCoverClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.FileCreditLifeClaimRequest,
            $23.FileCreditLifeClaimResponse>(
        'FileCreditLifeClaim',
        fileCreditLifeClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.FileCreditLifeClaimRequest.fromBuffer(value),
        ($23.FileCreditLifeClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceStatesRequest,
            $23.GetInsuranceStatesResponse>(
        'GetInsuranceStates',
        getInsuranceStates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceStatesRequest.fromBuffer(value),
        ($23.GetInsuranceStatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceVehicleMakesRequest,
            $23.GetInsuranceVehicleMakesResponse>(
        'GetInsuranceVehicleMakes',
        getInsuranceVehicleMakes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceVehicleMakesRequest.fromBuffer(value),
        ($23.GetInsuranceVehicleMakesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverNotificationPreferencesRequest,
            $23.GetMyCoverNotificationPreferencesResponse>(
        'GetMyCoverNotificationPreferences',
        getMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($23.GetMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $23.UpdateMyCoverNotificationPreferencesRequest,
            $23.UpdateMyCoverNotificationPreferencesResponse>(
        'UpdateMyCoverNotificationPreferences',
        updateMyCoverNotificationPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UpdateMyCoverNotificationPreferencesRequest.fromBuffer(value),
        ($23.UpdateMyCoverNotificationPreferencesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyCoverWalletBalanceRequest,
            $23.GetMyCoverWalletBalanceResponse>(
        'GetMyCoverWalletBalance',
        getMyCoverWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyCoverWalletBalanceRequest.fromBuffer(value),
        ($23.GetMyCoverWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.RequestInsuranceRefundRequest,
            $23.RequestInsuranceRefundResponse>(
        'RequestInsuranceRefund',
        requestInsuranceRefund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.RequestInsuranceRefundRequest.fromBuffer(value),
        ($23.RequestInsuranceRefundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetInsuranceRefundStatusRequest,
            $23.GetInsuranceRefundStatusResponse>(
        'GetInsuranceRefundStatus',
        getInsuranceRefundStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetInsuranceRefundStatusRequest.fromBuffer(value),
        ($23.GetInsuranceRefundStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$23.GetUserInsurancesResponse> getUserInsurances_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetUserInsurancesRequest> request) async {
    return getUserInsurances(call, await request);
  }

  $async.Future<$23.GetInsuranceByIdResponse> getInsuranceById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetInsuranceByIdRequest> request) async {
    return getInsuranceById(call, await request);
  }

  $async.Future<$23.CreateInsuranceResponse> createInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.CreateInsuranceRequest> request) async {
    return createInsurance(call, await request);
  }

  $async.Future<$23.UpdateInsuranceResponse> updateInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.UpdateInsuranceRequest> request) async {
    return updateInsurance(call, await request);
  }

  $async.Future<$23.DeleteInsuranceResponse> deleteInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.DeleteInsuranceRequest> request) async {
    return deleteInsurance(call, await request);
  }

  $async.Future<$23.SearchInsurancesResponse> searchInsurances_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.SearchInsurancesRequest> request) async {
    return searchInsurances(call, await request);
  }

  $async.Future<$23.GetInsurancePaymentsResponse> getInsurancePayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetInsurancePaymentsRequest> request) async {
    return getInsurancePayments(call, await request);
  }

  $async.Future<$23.GetUserPaymentsResponse> getUserPayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetUserPaymentsRequest> request) async {
    return getUserPayments(call, await request);
  }

  $async.Future<$23.CreatePaymentResponse> createPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.CreatePaymentRequest> request) async {
    return createPayment(call, await request);
  }

  $async.Future<$23.ProcessPaymentResponse> processPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.ProcessPaymentRequest> request) async {
    return processPayment(call, await request);
  }

  $async.Future<$23.GetPaymentByIdResponse> getPaymentById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetPaymentByIdRequest> request) async {
    return getPaymentById(call, await request);
  }

  $async.Future<$23.GetOverduePaymentsResponse> getOverduePayments_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetOverduePaymentsRequest> request) async {
    return getOverduePayments(call, await request);
  }

  $async.Future<$23.GetInsuranceClaimsResponse> getInsuranceClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetInsuranceClaimsRequest> request) async {
    return getInsuranceClaims(call, await request);
  }

  $async.Future<$23.GetUserClaimsResponse> getUserClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetUserClaimsRequest> request) async {
    return getUserClaims(call, await request);
  }

  $async.Future<$23.CreateClaimResponse> createClaim_Pre($grpc.ServiceCall call,
      $async.Future<$23.CreateClaimRequest> request) async {
    return createClaim(call, await request);
  }

  $async.Future<$23.UpdateClaimResponse> updateClaim_Pre($grpc.ServiceCall call,
      $async.Future<$23.UpdateClaimRequest> request) async {
    return updateClaim(call, await request);
  }

  $async.Future<$23.GetClaimByIdResponse> getClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetClaimByIdRequest> request) async {
    return getClaimById(call, await request);
  }

  $async.Future<$23.GeneratePaymentReceiptResponse> generatePaymentReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GeneratePaymentReceiptRequest> request) async {
    return generatePaymentReceipt(call, await request);
  }

  $async.Future<$23.GetUserReceiptsResponse> getUserReceipts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetUserReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$23.GetInsuranceStatisticsResponse> getInsuranceStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetInsuranceStatisticsRequest> request) async {
    return getInsuranceStatistics(call, await request);
  }

  $async.Future<$23.GetPaymentStatisticsResponse> getPaymentStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetPaymentStatisticsRequest> request) async {
    return getPaymentStatistics(call, await request);
  }

  $async.Future<$23.GetInsuranceProductsResponse> getInsuranceProducts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetInsuranceProductsRequest> request) async {
    return getInsuranceProducts(call, await request);
  }

  $async.Future<$23.GetInsuranceCategoriesResponse> getInsuranceCategories_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetInsuranceCategoriesRequest> request) async {
    return getInsuranceCategories(call, await request);
  }

  $async.Future<$23.GetInsuranceQuoteResponse> getInsuranceQuote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetInsuranceQuoteRequest> request) async {
    return getInsuranceQuote(call, await request);
  }

  $async.Future<$23.PurchaseInsuranceResponse> purchaseInsurance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.PurchaseInsuranceRequest> request) async {
    return purchaseInsurance(call, await request);
  }

  $async.Future<$23.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus_Pre($grpc.ServiceCall call,
          $async.Future<$23.GetInsurancePurchaseStatusRequest> request) async {
    return getInsurancePurchaseStatus(call, await request);
  }

  $async.Future<$23.UploadInsuranceDocumentResponse>
      uploadInsuranceDocument_Pre($grpc.ServiceCall call,
          $async.Future<$23.UploadInsuranceDocumentRequest> request) async {
    return uploadInsuranceDocument(call, await request);
  }

  $async.Future<$23.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData_Pre($grpc.ServiceCall call,
          $async.Future<$23.GetInsuranceAuxiliaryDataRequest> request) async {
    return getInsuranceAuxiliaryData(call, await request);
  }

  $async.Future<$23.GetMyCoverCustomersResponse> getMyCoverCustomers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyCoverCustomersRequest> request) async {
    return getMyCoverCustomers(call, await request);
  }

  $async.Future<$23.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyCoverCustomerByIdRequest> request) async {
    return getMyCoverCustomerById(call, await request);
  }

  $async.Future<$23.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies_Pre($grpc.ServiceCall call,
          $async.Future<$23.GetMyCoverCustomerPoliciesRequest> request) async {
    return getMyCoverCustomerPolicies(call, await request);
  }

  $async.Future<$23.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases_Pre($grpc.ServiceCall call,
          $async.Future<$23.GetMyCoverCustomerPurchasesRequest> request) async {
    return getMyCoverCustomerPurchases(call, await request);
  }

  $async.Future<$23.GetMyCoverPurchasesResponse> getMyCoverPurchases_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyCoverPurchasesRequest> request) async {
    return getMyCoverPurchases(call, await request);
  }

  $async.Future<$23.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyCoverPurchaseByIdRequest> request) async {
    return getMyCoverPurchaseById(call, await request);
  }

  $async.Future<$23.GetMyCoverClaimsResponse> getMyCoverClaims_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyCoverClaimsRequest> request) async {
    return getMyCoverClaims(call, await request);
  }

  $async.Future<$23.GetMyCoverClaimByIdResponse> getMyCoverClaimById_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyCoverClaimByIdRequest> request) async {
    return getMyCoverClaimById(call, await request);
  }

  $async.Future<$23.FileCreditLifeClaimResponse> fileCreditLifeClaim_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.FileCreditLifeClaimRequest> request) async {
    return fileCreditLifeClaim(call, await request);
  }

  $async.Future<$23.GetInsuranceStatesResponse> getInsuranceStates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetInsuranceStatesRequest> request) async {
    return getInsuranceStates(call, await request);
  }

  $async.Future<$23.GetInsuranceVehicleMakesResponse>
      getInsuranceVehicleMakes_Pre($grpc.ServiceCall call,
          $async.Future<$23.GetInsuranceVehicleMakesRequest> request) async {
    return getInsuranceVehicleMakes(call, await request);
  }

  $async.Future<$23.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$23.GetMyCoverNotificationPreferencesRequest>
              request) async {
    return getMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$23.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences_Pre(
          $grpc.ServiceCall call,
          $async.Future<$23.UpdateMyCoverNotificationPreferencesRequest>
              request) async {
    return updateMyCoverNotificationPreferences(call, await request);
  }

  $async.Future<$23.GetMyCoverWalletBalanceResponse>
      getMyCoverWalletBalance_Pre($grpc.ServiceCall call,
          $async.Future<$23.GetMyCoverWalletBalanceRequest> request) async {
    return getMyCoverWalletBalance(call, await request);
  }

  $async.Future<$23.RequestInsuranceRefundResponse> requestInsuranceRefund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.RequestInsuranceRefundRequest> request) async {
    return requestInsuranceRefund(call, await request);
  }

  $async.Future<$23.GetInsuranceRefundStatusResponse>
      getInsuranceRefundStatus_Pre($grpc.ServiceCall call,
          $async.Future<$23.GetInsuranceRefundStatusRequest> request) async {
    return getInsuranceRefundStatus(call, await request);
  }

  $async.Future<$23.GetUserInsurancesResponse> getUserInsurances(
      $grpc.ServiceCall call, $23.GetUserInsurancesRequest request);
  $async.Future<$23.GetInsuranceByIdResponse> getInsuranceById(
      $grpc.ServiceCall call, $23.GetInsuranceByIdRequest request);
  $async.Future<$23.CreateInsuranceResponse> createInsurance(
      $grpc.ServiceCall call, $23.CreateInsuranceRequest request);
  $async.Future<$23.UpdateInsuranceResponse> updateInsurance(
      $grpc.ServiceCall call, $23.UpdateInsuranceRequest request);
  $async.Future<$23.DeleteInsuranceResponse> deleteInsurance(
      $grpc.ServiceCall call, $23.DeleteInsuranceRequest request);
  $async.Future<$23.SearchInsurancesResponse> searchInsurances(
      $grpc.ServiceCall call, $23.SearchInsurancesRequest request);
  $async.Future<$23.GetInsurancePaymentsResponse> getInsurancePayments(
      $grpc.ServiceCall call, $23.GetInsurancePaymentsRequest request);
  $async.Future<$23.GetUserPaymentsResponse> getUserPayments(
      $grpc.ServiceCall call, $23.GetUserPaymentsRequest request);
  $async.Future<$23.CreatePaymentResponse> createPayment(
      $grpc.ServiceCall call, $23.CreatePaymentRequest request);
  $async.Future<$23.ProcessPaymentResponse> processPayment(
      $grpc.ServiceCall call, $23.ProcessPaymentRequest request);
  $async.Future<$23.GetPaymentByIdResponse> getPaymentById(
      $grpc.ServiceCall call, $23.GetPaymentByIdRequest request);
  $async.Future<$23.GetOverduePaymentsResponse> getOverduePayments(
      $grpc.ServiceCall call, $23.GetOverduePaymentsRequest request);
  $async.Future<$23.GetInsuranceClaimsResponse> getInsuranceClaims(
      $grpc.ServiceCall call, $23.GetInsuranceClaimsRequest request);
  $async.Future<$23.GetUserClaimsResponse> getUserClaims(
      $grpc.ServiceCall call, $23.GetUserClaimsRequest request);
  $async.Future<$23.CreateClaimResponse> createClaim(
      $grpc.ServiceCall call, $23.CreateClaimRequest request);
  $async.Future<$23.UpdateClaimResponse> updateClaim(
      $grpc.ServiceCall call, $23.UpdateClaimRequest request);
  $async.Future<$23.GetClaimByIdResponse> getClaimById(
      $grpc.ServiceCall call, $23.GetClaimByIdRequest request);
  $async.Future<$23.GeneratePaymentReceiptResponse> generatePaymentReceipt(
      $grpc.ServiceCall call, $23.GeneratePaymentReceiptRequest request);
  $async.Future<$23.GetUserReceiptsResponse> getUserReceipts(
      $grpc.ServiceCall call, $23.GetUserReceiptsRequest request);
  $async.Future<$23.GetInsuranceStatisticsResponse> getInsuranceStatistics(
      $grpc.ServiceCall call, $23.GetInsuranceStatisticsRequest request);
  $async.Future<$23.GetPaymentStatisticsResponse> getPaymentStatistics(
      $grpc.ServiceCall call, $23.GetPaymentStatisticsRequest request);
  $async.Future<$23.GetInsuranceProductsResponse> getInsuranceProducts(
      $grpc.ServiceCall call, $23.GetInsuranceProductsRequest request);
  $async.Future<$23.GetInsuranceCategoriesResponse> getInsuranceCategories(
      $grpc.ServiceCall call, $23.GetInsuranceCategoriesRequest request);
  $async.Future<$23.GetInsuranceQuoteResponse> getInsuranceQuote(
      $grpc.ServiceCall call, $23.GetInsuranceQuoteRequest request);
  $async.Future<$23.PurchaseInsuranceResponse> purchaseInsurance(
      $grpc.ServiceCall call, $23.PurchaseInsuranceRequest request);
  $async.Future<$23.GetInsurancePurchaseStatusResponse>
      getInsurancePurchaseStatus($grpc.ServiceCall call,
          $23.GetInsurancePurchaseStatusRequest request);
  $async.Future<$23.UploadInsuranceDocumentResponse> uploadInsuranceDocument(
      $grpc.ServiceCall call, $23.UploadInsuranceDocumentRequest request);
  $async.Future<$23.GetInsuranceAuxiliaryDataResponse>
      getInsuranceAuxiliaryData(
          $grpc.ServiceCall call, $23.GetInsuranceAuxiliaryDataRequest request);
  $async.Future<$23.GetMyCoverCustomersResponse> getMyCoverCustomers(
      $grpc.ServiceCall call, $23.GetMyCoverCustomersRequest request);
  $async.Future<$23.GetMyCoverCustomerByIdResponse> getMyCoverCustomerById(
      $grpc.ServiceCall call, $23.GetMyCoverCustomerByIdRequest request);
  $async.Future<$23.GetMyCoverCustomerPoliciesResponse>
      getMyCoverCustomerPolicies($grpc.ServiceCall call,
          $23.GetMyCoverCustomerPoliciesRequest request);
  $async.Future<$23.GetMyCoverCustomerPurchasesResponse>
      getMyCoverCustomerPurchases($grpc.ServiceCall call,
          $23.GetMyCoverCustomerPurchasesRequest request);
  $async.Future<$23.GetMyCoverPurchasesResponse> getMyCoverPurchases(
      $grpc.ServiceCall call, $23.GetMyCoverPurchasesRequest request);
  $async.Future<$23.GetMyCoverPurchaseByIdResponse> getMyCoverPurchaseById(
      $grpc.ServiceCall call, $23.GetMyCoverPurchaseByIdRequest request);
  $async.Future<$23.GetMyCoverClaimsResponse> getMyCoverClaims(
      $grpc.ServiceCall call, $23.GetMyCoverClaimsRequest request);
  $async.Future<$23.GetMyCoverClaimByIdResponse> getMyCoverClaimById(
      $grpc.ServiceCall call, $23.GetMyCoverClaimByIdRequest request);
  $async.Future<$23.FileCreditLifeClaimResponse> fileCreditLifeClaim(
      $grpc.ServiceCall call, $23.FileCreditLifeClaimRequest request);
  $async.Future<$23.GetInsuranceStatesResponse> getInsuranceStates(
      $grpc.ServiceCall call, $23.GetInsuranceStatesRequest request);
  $async.Future<$23.GetInsuranceVehicleMakesResponse> getInsuranceVehicleMakes(
      $grpc.ServiceCall call, $23.GetInsuranceVehicleMakesRequest request);
  $async.Future<$23.GetMyCoverNotificationPreferencesResponse>
      getMyCoverNotificationPreferences($grpc.ServiceCall call,
          $23.GetMyCoverNotificationPreferencesRequest request);
  $async.Future<$23.UpdateMyCoverNotificationPreferencesResponse>
      updateMyCoverNotificationPreferences($grpc.ServiceCall call,
          $23.UpdateMyCoverNotificationPreferencesRequest request);
  $async.Future<$23.GetMyCoverWalletBalanceResponse> getMyCoverWalletBalance(
      $grpc.ServiceCall call, $23.GetMyCoverWalletBalanceRequest request);
  $async.Future<$23.RequestInsuranceRefundResponse> requestInsuranceRefund(
      $grpc.ServiceCall call, $23.RequestInsuranceRefundRequest request);
  $async.Future<$23.GetInsuranceRefundStatusResponse> getInsuranceRefundStatus(
      $grpc.ServiceCall call, $23.GetInsuranceRefundStatusRequest request);
}
