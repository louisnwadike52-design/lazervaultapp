//
//  Generated code. Do not modify.
//  source: insurance.proto
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

import 'insurance.pb.dart' as $0;

export 'insurance.pb.dart';

@$pb.GrpcServiceName('pb.InsuranceService')
class InsuranceServiceClient extends $grpc.Client {
  static final _$getUserInsurances = $grpc.ClientMethod<$0.GetUserInsurancesRequest, $0.GetUserInsurancesResponse>(
      '/pb.InsuranceService/GetUserInsurances',
      ($0.GetUserInsurancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserInsurancesResponse.fromBuffer(value));
  static final _$getInsuranceById = $grpc.ClientMethod<$0.GetInsuranceByIdRequest, $0.GetInsuranceByIdResponse>(
      '/pb.InsuranceService/GetInsuranceById',
      ($0.GetInsuranceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsuranceByIdResponse.fromBuffer(value));
  static final _$createInsurance = $grpc.ClientMethod<$0.CreateInsuranceRequest, $0.CreateInsuranceResponse>(
      '/pb.InsuranceService/CreateInsurance',
      ($0.CreateInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateInsuranceResponse.fromBuffer(value));
  static final _$updateInsurance = $grpc.ClientMethod<$0.UpdateInsuranceRequest, $0.UpdateInsuranceResponse>(
      '/pb.InsuranceService/UpdateInsurance',
      ($0.UpdateInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateInsuranceResponse.fromBuffer(value));
  static final _$deleteInsurance = $grpc.ClientMethod<$0.DeleteInsuranceRequest, $0.DeleteInsuranceResponse>(
      '/pb.InsuranceService/DeleteInsurance',
      ($0.DeleteInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteInsuranceResponse.fromBuffer(value));
  static final _$searchInsurances = $grpc.ClientMethod<$0.SearchInsurancesRequest, $0.SearchInsurancesResponse>(
      '/pb.InsuranceService/SearchInsurances',
      ($0.SearchInsurancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SearchInsurancesResponse.fromBuffer(value));
  static final _$getInsurancePayments = $grpc.ClientMethod<$0.GetInsurancePaymentsRequest, $0.GetInsurancePaymentsResponse>(
      '/pb.InsuranceService/GetInsurancePayments',
      ($0.GetInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsurancePaymentsResponse.fromBuffer(value));
  static final _$getUserPayments = $grpc.ClientMethod<$0.GetUserPaymentsRequest, $0.GetUserPaymentsResponse>(
      '/pb.InsuranceService/GetUserPayments',
      ($0.GetUserPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserPaymentsResponse.fromBuffer(value));
  static final _$createPayment = $grpc.ClientMethod<$0.CreatePaymentRequest, $0.CreatePaymentResponse>(
      '/pb.InsuranceService/CreatePayment',
      ($0.CreatePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreatePaymentResponse.fromBuffer(value));
  static final _$processPayment = $grpc.ClientMethod<$0.ProcessPaymentRequest, $0.ProcessPaymentResponse>(
      '/pb.InsuranceService/ProcessPayment',
      ($0.ProcessPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ProcessPaymentResponse.fromBuffer(value));
  static final _$getPaymentById = $grpc.ClientMethod<$0.GetPaymentByIdRequest, $0.GetPaymentByIdResponse>(
      '/pb.InsuranceService/GetPaymentById',
      ($0.GetPaymentByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPaymentByIdResponse.fromBuffer(value));
  static final _$getOverduePayments = $grpc.ClientMethod<$0.GetOverduePaymentsRequest, $0.GetOverduePaymentsResponse>(
      '/pb.InsuranceService/GetOverduePayments',
      ($0.GetOverduePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetOverduePaymentsResponse.fromBuffer(value));
  static final _$getInsuranceClaims = $grpc.ClientMethod<$0.GetInsuranceClaimsRequest, $0.GetInsuranceClaimsResponse>(
      '/pb.InsuranceService/GetInsuranceClaims',
      ($0.GetInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsuranceClaimsResponse.fromBuffer(value));
  static final _$getUserClaims = $grpc.ClientMethod<$0.GetUserClaimsRequest, $0.GetUserClaimsResponse>(
      '/pb.InsuranceService/GetUserClaims',
      ($0.GetUserClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserClaimsResponse.fromBuffer(value));
  static final _$createClaim = $grpc.ClientMethod<$0.CreateClaimRequest, $0.CreateClaimResponse>(
      '/pb.InsuranceService/CreateClaim',
      ($0.CreateClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateClaimResponse.fromBuffer(value));
  static final _$updateClaim = $grpc.ClientMethod<$0.UpdateClaimRequest, $0.UpdateClaimResponse>(
      '/pb.InsuranceService/UpdateClaim',
      ($0.UpdateClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateClaimResponse.fromBuffer(value));
  static final _$getClaimById = $grpc.ClientMethod<$0.GetClaimByIdRequest, $0.GetClaimByIdResponse>(
      '/pb.InsuranceService/GetClaimById',
      ($0.GetClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetClaimByIdResponse.fromBuffer(value));
  static final _$generatePaymentReceipt = $grpc.ClientMethod<$0.GeneratePaymentReceiptRequest, $0.GeneratePaymentReceiptResponse>(
      '/pb.InsuranceService/GeneratePaymentReceipt',
      ($0.GeneratePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GeneratePaymentReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<$0.GetUserReceiptsRequest, $0.GetUserReceiptsResponse>(
      '/pb.InsuranceService/GetUserReceipts',
      ($0.GetUserReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserReceiptsResponse.fromBuffer(value));
  static final _$getInsuranceStatistics = $grpc.ClientMethod<$0.GetInsuranceStatisticsRequest, $0.GetInsuranceStatisticsResponse>(
      '/pb.InsuranceService/GetInsuranceStatistics',
      ($0.GetInsuranceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsuranceStatisticsResponse.fromBuffer(value));
  static final _$getPaymentStatistics = $grpc.ClientMethod<$0.GetPaymentStatisticsRequest, $0.GetPaymentStatisticsResponse>(
      '/pb.InsuranceService/GetPaymentStatistics',
      ($0.GetPaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPaymentStatisticsResponse.fromBuffer(value));
  static final _$getInsuranceProducts = $grpc.ClientMethod<$0.GetInsuranceProductsRequest, $0.GetInsuranceProductsResponse>(
      '/pb.InsuranceService/GetInsuranceProducts',
      ($0.GetInsuranceProductsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsuranceProductsResponse.fromBuffer(value));
  static final _$getInsuranceCategories = $grpc.ClientMethod<$0.GetInsuranceCategoriesRequest, $0.GetInsuranceCategoriesResponse>(
      '/pb.InsuranceService/GetInsuranceCategories',
      ($0.GetInsuranceCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsuranceCategoriesResponse.fromBuffer(value));
  static final _$getInsuranceQuote = $grpc.ClientMethod<$0.GetInsuranceQuoteRequest, $0.GetInsuranceQuoteResponse>(
      '/pb.InsuranceService/GetInsuranceQuote',
      ($0.GetInsuranceQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsuranceQuoteResponse.fromBuffer(value));
  static final _$purchaseInsurance = $grpc.ClientMethod<$0.PurchaseInsuranceRequest, $0.PurchaseInsuranceResponse>(
      '/pb.InsuranceService/PurchaseInsurance',
      ($0.PurchaseInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PurchaseInsuranceResponse.fromBuffer(value));
  static final _$getInsurancePurchaseStatus = $grpc.ClientMethod<$0.GetInsurancePurchaseStatusRequest, $0.GetInsurancePurchaseStatusResponse>(
      '/pb.InsuranceService/GetInsurancePurchaseStatus',
      ($0.GetInsurancePurchaseStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsurancePurchaseStatusResponse.fromBuffer(value));
  static final _$uploadInsuranceDocument = $grpc.ClientMethod<$0.UploadInsuranceDocumentRequest, $0.UploadInsuranceDocumentResponse>(
      '/pb.InsuranceService/UploadInsuranceDocument',
      ($0.UploadInsuranceDocumentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UploadInsuranceDocumentResponse.fromBuffer(value));
  static final _$getInsuranceAuxiliaryData = $grpc.ClientMethod<$0.GetInsuranceAuxiliaryDataRequest, $0.GetInsuranceAuxiliaryDataResponse>(
      '/pb.InsuranceService/GetInsuranceAuxiliaryData',
      ($0.GetInsuranceAuxiliaryDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInsuranceAuxiliaryDataResponse.fromBuffer(value));

  InsuranceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetUserInsurancesResponse> getUserInsurances($0.GetUserInsurancesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsurances, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceByIdResponse> getInsuranceById($0.GetInsuranceByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceById, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateInsuranceResponse> createInsurance($0.CreateInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInsuranceResponse> updateInsurance($0.UpdateInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteInsuranceResponse> deleteInsurance($0.DeleteInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchInsurancesResponse> searchInsurances($0.SearchInsurancesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchInsurances, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePaymentsResponse> getInsurancePayments($0.GetInsurancePaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePayments, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserPaymentsResponse> getUserPayments($0.GetUserPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPayments, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreatePaymentResponse> createPayment($0.CreatePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProcessPaymentResponse> processPayment($0.ProcessPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPaymentByIdResponse> getPaymentById($0.GetPaymentByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentById, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOverduePaymentsResponse> getOverduePayments($0.GetOverduePaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverduePayments, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceClaimsResponse> getInsuranceClaims($0.GetInsuranceClaimsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaims, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserClaimsResponse> getUserClaims($0.GetUserClaimsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserClaims, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateClaimResponse> createClaim($0.CreateClaimRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createClaim, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateClaimResponse> updateClaim($0.UpdateClaimRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateClaim, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetClaimByIdResponse> getClaimById($0.GetClaimByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$0.GeneratePaymentReceiptResponse> generatePaymentReceipt($0.GeneratePaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generatePaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserReceiptsResponse> getUserReceipts($0.GetUserReceiptsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceStatisticsResponse> getInsuranceStatistics($0.GetInsuranceStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPaymentStatisticsResponse> getPaymentStatistics($0.GetPaymentStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceProductsResponse> getInsuranceProducts($0.GetInsuranceProductsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceProducts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceCategoriesResponse> getInsuranceCategories($0.GetInsuranceCategoriesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceCategories, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceQuoteResponse> getInsuranceQuote($0.GetInsuranceQuoteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceQuote, request, options: options);
  }

  $grpc.ResponseFuture<$0.PurchaseInsuranceResponse> purchaseInsurance($0.PurchaseInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsurancePurchaseStatusResponse> getInsurancePurchaseStatus($0.GetInsurancePurchaseStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePurchaseStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.UploadInsuranceDocumentResponse> uploadInsuranceDocument($0.UploadInsuranceDocumentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadInsuranceDocument, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInsuranceAuxiliaryDataResponse> getInsuranceAuxiliaryData($0.GetInsuranceAuxiliaryDataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceAuxiliaryData, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.InsuranceService')
abstract class InsuranceServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.InsuranceService';

  InsuranceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetUserInsurancesRequest, $0.GetUserInsurancesResponse>(
        'GetUserInsurances',
        getUserInsurances_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserInsurancesRequest.fromBuffer(value),
        ($0.GetUserInsurancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceByIdRequest, $0.GetInsuranceByIdResponse>(
        'GetInsuranceById',
        getInsuranceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsuranceByIdRequest.fromBuffer(value),
        ($0.GetInsuranceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateInsuranceRequest, $0.CreateInsuranceResponse>(
        'CreateInsurance',
        createInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateInsuranceRequest.fromBuffer(value),
        ($0.CreateInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInsuranceRequest, $0.UpdateInsuranceResponse>(
        'UpdateInsurance',
        updateInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateInsuranceRequest.fromBuffer(value),
        ($0.UpdateInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteInsuranceRequest, $0.DeleteInsuranceResponse>(
        'DeleteInsurance',
        deleteInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteInsuranceRequest.fromBuffer(value),
        ($0.DeleteInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchInsurancesRequest, $0.SearchInsurancesResponse>(
        'SearchInsurances',
        searchInsurances_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchInsurancesRequest.fromBuffer(value),
        ($0.SearchInsurancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePaymentsRequest, $0.GetInsurancePaymentsResponse>(
        'GetInsurancePayments',
        getInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsurancePaymentsRequest.fromBuffer(value),
        ($0.GetInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserPaymentsRequest, $0.GetUserPaymentsResponse>(
        'GetUserPayments',
        getUserPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserPaymentsRequest.fromBuffer(value),
        ($0.GetUserPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreatePaymentRequest, $0.CreatePaymentResponse>(
        'CreatePayment',
        createPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreatePaymentRequest.fromBuffer(value),
        ($0.CreatePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProcessPaymentRequest, $0.ProcessPaymentResponse>(
        'ProcessPayment',
        processPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ProcessPaymentRequest.fromBuffer(value),
        ($0.ProcessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaymentByIdRequest, $0.GetPaymentByIdResponse>(
        'GetPaymentById',
        getPaymentById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPaymentByIdRequest.fromBuffer(value),
        ($0.GetPaymentByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOverduePaymentsRequest, $0.GetOverduePaymentsResponse>(
        'GetOverduePayments',
        getOverduePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOverduePaymentsRequest.fromBuffer(value),
        ($0.GetOverduePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceClaimsRequest, $0.GetInsuranceClaimsResponse>(
        'GetInsuranceClaims',
        getInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsuranceClaimsRequest.fromBuffer(value),
        ($0.GetInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserClaimsRequest, $0.GetUserClaimsResponse>(
        'GetUserClaims',
        getUserClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserClaimsRequest.fromBuffer(value),
        ($0.GetUserClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateClaimRequest, $0.CreateClaimResponse>(
        'CreateClaim',
        createClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateClaimRequest.fromBuffer(value),
        ($0.CreateClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateClaimRequest, $0.UpdateClaimResponse>(
        'UpdateClaim',
        updateClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateClaimRequest.fromBuffer(value),
        ($0.UpdateClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetClaimByIdRequest, $0.GetClaimByIdResponse>(
        'GetClaimById',
        getClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetClaimByIdRequest.fromBuffer(value),
        ($0.GetClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GeneratePaymentReceiptRequest, $0.GeneratePaymentReceiptResponse>(
        'GeneratePaymentReceipt',
        generatePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GeneratePaymentReceiptRequest.fromBuffer(value),
        ($0.GeneratePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserReceiptsRequest, $0.GetUserReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserReceiptsRequest.fromBuffer(value),
        ($0.GetUserReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceStatisticsRequest, $0.GetInsuranceStatisticsResponse>(
        'GetInsuranceStatistics',
        getInsuranceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsuranceStatisticsRequest.fromBuffer(value),
        ($0.GetInsuranceStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaymentStatisticsRequest, $0.GetPaymentStatisticsResponse>(
        'GetPaymentStatistics',
        getPaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPaymentStatisticsRequest.fromBuffer(value),
        ($0.GetPaymentStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceProductsRequest, $0.GetInsuranceProductsResponse>(
        'GetInsuranceProducts',
        getInsuranceProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsuranceProductsRequest.fromBuffer(value),
        ($0.GetInsuranceProductsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceCategoriesRequest, $0.GetInsuranceCategoriesResponse>(
        'GetInsuranceCategories',
        getInsuranceCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsuranceCategoriesRequest.fromBuffer(value),
        ($0.GetInsuranceCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceQuoteRequest, $0.GetInsuranceQuoteResponse>(
        'GetInsuranceQuote',
        getInsuranceQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsuranceQuoteRequest.fromBuffer(value),
        ($0.GetInsuranceQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PurchaseInsuranceRequest, $0.PurchaseInsuranceResponse>(
        'PurchaseInsurance',
        purchaseInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PurchaseInsuranceRequest.fromBuffer(value),
        ($0.PurchaseInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsurancePurchaseStatusRequest, $0.GetInsurancePurchaseStatusResponse>(
        'GetInsurancePurchaseStatus',
        getInsurancePurchaseStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsurancePurchaseStatusRequest.fromBuffer(value),
        ($0.GetInsurancePurchaseStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadInsuranceDocumentRequest, $0.UploadInsuranceDocumentResponse>(
        'UploadInsuranceDocument',
        uploadInsuranceDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UploadInsuranceDocumentRequest.fromBuffer(value),
        ($0.UploadInsuranceDocumentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInsuranceAuxiliaryDataRequest, $0.GetInsuranceAuxiliaryDataResponse>(
        'GetInsuranceAuxiliaryData',
        getInsuranceAuxiliaryData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInsuranceAuxiliaryDataRequest.fromBuffer(value),
        ($0.GetInsuranceAuxiliaryDataResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetUserInsurancesResponse> getUserInsurances_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserInsurancesRequest> request) async {
    return getUserInsurances(call, await request);
  }

  $async.Future<$0.GetInsuranceByIdResponse> getInsuranceById_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsuranceByIdRequest> request) async {
    return getInsuranceById(call, await request);
  }

  $async.Future<$0.CreateInsuranceResponse> createInsurance_Pre($grpc.ServiceCall call, $async.Future<$0.CreateInsuranceRequest> request) async {
    return createInsurance(call, await request);
  }

  $async.Future<$0.UpdateInsuranceResponse> updateInsurance_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateInsuranceRequest> request) async {
    return updateInsurance(call, await request);
  }

  $async.Future<$0.DeleteInsuranceResponse> deleteInsurance_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteInsuranceRequest> request) async {
    return deleteInsurance(call, await request);
  }

  $async.Future<$0.SearchInsurancesResponse> searchInsurances_Pre($grpc.ServiceCall call, $async.Future<$0.SearchInsurancesRequest> request) async {
    return searchInsurances(call, await request);
  }

  $async.Future<$0.GetInsurancePaymentsResponse> getInsurancePayments_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsurancePaymentsRequest> request) async {
    return getInsurancePayments(call, await request);
  }

  $async.Future<$0.GetUserPaymentsResponse> getUserPayments_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserPaymentsRequest> request) async {
    return getUserPayments(call, await request);
  }

  $async.Future<$0.CreatePaymentResponse> createPayment_Pre($grpc.ServiceCall call, $async.Future<$0.CreatePaymentRequest> request) async {
    return createPayment(call, await request);
  }

  $async.Future<$0.ProcessPaymentResponse> processPayment_Pre($grpc.ServiceCall call, $async.Future<$0.ProcessPaymentRequest> request) async {
    return processPayment(call, await request);
  }

  $async.Future<$0.GetPaymentByIdResponse> getPaymentById_Pre($grpc.ServiceCall call, $async.Future<$0.GetPaymentByIdRequest> request) async {
    return getPaymentById(call, await request);
  }

  $async.Future<$0.GetOverduePaymentsResponse> getOverduePayments_Pre($grpc.ServiceCall call, $async.Future<$0.GetOverduePaymentsRequest> request) async {
    return getOverduePayments(call, await request);
  }

  $async.Future<$0.GetInsuranceClaimsResponse> getInsuranceClaims_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsuranceClaimsRequest> request) async {
    return getInsuranceClaims(call, await request);
  }

  $async.Future<$0.GetUserClaimsResponse> getUserClaims_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserClaimsRequest> request) async {
    return getUserClaims(call, await request);
  }

  $async.Future<$0.CreateClaimResponse> createClaim_Pre($grpc.ServiceCall call, $async.Future<$0.CreateClaimRequest> request) async {
    return createClaim(call, await request);
  }

  $async.Future<$0.UpdateClaimResponse> updateClaim_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateClaimRequest> request) async {
    return updateClaim(call, await request);
  }

  $async.Future<$0.GetClaimByIdResponse> getClaimById_Pre($grpc.ServiceCall call, $async.Future<$0.GetClaimByIdRequest> request) async {
    return getClaimById(call, await request);
  }

  $async.Future<$0.GeneratePaymentReceiptResponse> generatePaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$0.GeneratePaymentReceiptRequest> request) async {
    return generatePaymentReceipt(call, await request);
  }

  $async.Future<$0.GetUserReceiptsResponse> getUserReceipts_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$0.GetInsuranceStatisticsResponse> getInsuranceStatistics_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsuranceStatisticsRequest> request) async {
    return getInsuranceStatistics(call, await request);
  }

  $async.Future<$0.GetPaymentStatisticsResponse> getPaymentStatistics_Pre($grpc.ServiceCall call, $async.Future<$0.GetPaymentStatisticsRequest> request) async {
    return getPaymentStatistics(call, await request);
  }

  $async.Future<$0.GetInsuranceProductsResponse> getInsuranceProducts_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsuranceProductsRequest> request) async {
    return getInsuranceProducts(call, await request);
  }

  $async.Future<$0.GetInsuranceCategoriesResponse> getInsuranceCategories_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsuranceCategoriesRequest> request) async {
    return getInsuranceCategories(call, await request);
  }

  $async.Future<$0.GetInsuranceQuoteResponse> getInsuranceQuote_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsuranceQuoteRequest> request) async {
    return getInsuranceQuote(call, await request);
  }

  $async.Future<$0.PurchaseInsuranceResponse> purchaseInsurance_Pre($grpc.ServiceCall call, $async.Future<$0.PurchaseInsuranceRequest> request) async {
    return purchaseInsurance(call, await request);
  }

  $async.Future<$0.GetInsurancePurchaseStatusResponse> getInsurancePurchaseStatus_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsurancePurchaseStatusRequest> request) async {
    return getInsurancePurchaseStatus(call, await request);
  }

  $async.Future<$0.UploadInsuranceDocumentResponse> uploadInsuranceDocument_Pre($grpc.ServiceCall call, $async.Future<$0.UploadInsuranceDocumentRequest> request) async {
    return uploadInsuranceDocument(call, await request);
  }

  $async.Future<$0.GetInsuranceAuxiliaryDataResponse> getInsuranceAuxiliaryData_Pre($grpc.ServiceCall call, $async.Future<$0.GetInsuranceAuxiliaryDataRequest> request) async {
    return getInsuranceAuxiliaryData(call, await request);
  }

  $async.Future<$0.GetUserInsurancesResponse> getUserInsurances($grpc.ServiceCall call, $0.GetUserInsurancesRequest request);
  $async.Future<$0.GetInsuranceByIdResponse> getInsuranceById($grpc.ServiceCall call, $0.GetInsuranceByIdRequest request);
  $async.Future<$0.CreateInsuranceResponse> createInsurance($grpc.ServiceCall call, $0.CreateInsuranceRequest request);
  $async.Future<$0.UpdateInsuranceResponse> updateInsurance($grpc.ServiceCall call, $0.UpdateInsuranceRequest request);
  $async.Future<$0.DeleteInsuranceResponse> deleteInsurance($grpc.ServiceCall call, $0.DeleteInsuranceRequest request);
  $async.Future<$0.SearchInsurancesResponse> searchInsurances($grpc.ServiceCall call, $0.SearchInsurancesRequest request);
  $async.Future<$0.GetInsurancePaymentsResponse> getInsurancePayments($grpc.ServiceCall call, $0.GetInsurancePaymentsRequest request);
  $async.Future<$0.GetUserPaymentsResponse> getUserPayments($grpc.ServiceCall call, $0.GetUserPaymentsRequest request);
  $async.Future<$0.CreatePaymentResponse> createPayment($grpc.ServiceCall call, $0.CreatePaymentRequest request);
  $async.Future<$0.ProcessPaymentResponse> processPayment($grpc.ServiceCall call, $0.ProcessPaymentRequest request);
  $async.Future<$0.GetPaymentByIdResponse> getPaymentById($grpc.ServiceCall call, $0.GetPaymentByIdRequest request);
  $async.Future<$0.GetOverduePaymentsResponse> getOverduePayments($grpc.ServiceCall call, $0.GetOverduePaymentsRequest request);
  $async.Future<$0.GetInsuranceClaimsResponse> getInsuranceClaims($grpc.ServiceCall call, $0.GetInsuranceClaimsRequest request);
  $async.Future<$0.GetUserClaimsResponse> getUserClaims($grpc.ServiceCall call, $0.GetUserClaimsRequest request);
  $async.Future<$0.CreateClaimResponse> createClaim($grpc.ServiceCall call, $0.CreateClaimRequest request);
  $async.Future<$0.UpdateClaimResponse> updateClaim($grpc.ServiceCall call, $0.UpdateClaimRequest request);
  $async.Future<$0.GetClaimByIdResponse> getClaimById($grpc.ServiceCall call, $0.GetClaimByIdRequest request);
  $async.Future<$0.GeneratePaymentReceiptResponse> generatePaymentReceipt($grpc.ServiceCall call, $0.GeneratePaymentReceiptRequest request);
  $async.Future<$0.GetUserReceiptsResponse> getUserReceipts($grpc.ServiceCall call, $0.GetUserReceiptsRequest request);
  $async.Future<$0.GetInsuranceStatisticsResponse> getInsuranceStatistics($grpc.ServiceCall call, $0.GetInsuranceStatisticsRequest request);
  $async.Future<$0.GetPaymentStatisticsResponse> getPaymentStatistics($grpc.ServiceCall call, $0.GetPaymentStatisticsRequest request);
  $async.Future<$0.GetInsuranceProductsResponse> getInsuranceProducts($grpc.ServiceCall call, $0.GetInsuranceProductsRequest request);
  $async.Future<$0.GetInsuranceCategoriesResponse> getInsuranceCategories($grpc.ServiceCall call, $0.GetInsuranceCategoriesRequest request);
  $async.Future<$0.GetInsuranceQuoteResponse> getInsuranceQuote($grpc.ServiceCall call, $0.GetInsuranceQuoteRequest request);
  $async.Future<$0.PurchaseInsuranceResponse> purchaseInsurance($grpc.ServiceCall call, $0.PurchaseInsuranceRequest request);
  $async.Future<$0.GetInsurancePurchaseStatusResponse> getInsurancePurchaseStatus($grpc.ServiceCall call, $0.GetInsurancePurchaseStatusRequest request);
  $async.Future<$0.UploadInsuranceDocumentResponse> uploadInsuranceDocument($grpc.ServiceCall call, $0.UploadInsuranceDocumentRequest request);
  $async.Future<$0.GetInsuranceAuxiliaryDataResponse> getInsuranceAuxiliaryData($grpc.ServiceCall call, $0.GetInsuranceAuxiliaryDataRequest request);
}
