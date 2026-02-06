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

import 'insurance.pb.dart' as $22;

export 'insurance.pb.dart';

@$pb.GrpcServiceName('insurance.InsuranceService')
class InsuranceServiceClient extends $grpc.Client {
  static final _$getUserInsurances = $grpc.ClientMethod<$22.GetUserInsurancesRequest, $22.GetUserInsurancesResponse>(
      '/insurance.InsuranceService/GetUserInsurances',
      ($22.GetUserInsurancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetUserInsurancesResponse.fromBuffer(value));
  static final _$getInsuranceById = $grpc.ClientMethod<$22.GetInsuranceByIdRequest, $22.GetInsuranceByIdResponse>(
      '/insurance.InsuranceService/GetInsuranceById',
      ($22.GetInsuranceByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetInsuranceByIdResponse.fromBuffer(value));
  static final _$createInsurance = $grpc.ClientMethod<$22.CreateInsuranceRequest, $22.CreateInsuranceResponse>(
      '/insurance.InsuranceService/CreateInsurance',
      ($22.CreateInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.CreateInsuranceResponse.fromBuffer(value));
  static final _$updateInsurance = $grpc.ClientMethod<$22.UpdateInsuranceRequest, $22.UpdateInsuranceResponse>(
      '/insurance.InsuranceService/UpdateInsurance',
      ($22.UpdateInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.UpdateInsuranceResponse.fromBuffer(value));
  static final _$deleteInsurance = $grpc.ClientMethod<$22.DeleteInsuranceRequest, $22.DeleteInsuranceResponse>(
      '/insurance.InsuranceService/DeleteInsurance',
      ($22.DeleteInsuranceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.DeleteInsuranceResponse.fromBuffer(value));
  static final _$searchInsurances = $grpc.ClientMethod<$22.SearchInsurancesRequest, $22.SearchInsurancesResponse>(
      '/insurance.InsuranceService/SearchInsurances',
      ($22.SearchInsurancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.SearchInsurancesResponse.fromBuffer(value));
  static final _$getInsurancePayments = $grpc.ClientMethod<$22.GetInsurancePaymentsRequest, $22.GetInsurancePaymentsResponse>(
      '/insurance.InsuranceService/GetInsurancePayments',
      ($22.GetInsurancePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetInsurancePaymentsResponse.fromBuffer(value));
  static final _$getUserPayments = $grpc.ClientMethod<$22.GetUserPaymentsRequest, $22.GetUserPaymentsResponse>(
      '/insurance.InsuranceService/GetUserPayments',
      ($22.GetUserPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetUserPaymentsResponse.fromBuffer(value));
  static final _$createPayment = $grpc.ClientMethod<$22.CreatePaymentRequest, $22.CreatePaymentResponse>(
      '/insurance.InsuranceService/CreatePayment',
      ($22.CreatePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.CreatePaymentResponse.fromBuffer(value));
  static final _$processPayment = $grpc.ClientMethod<$22.ProcessPaymentRequest, $22.ProcessPaymentResponse>(
      '/insurance.InsuranceService/ProcessPayment',
      ($22.ProcessPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.ProcessPaymentResponse.fromBuffer(value));
  static final _$getPaymentById = $grpc.ClientMethod<$22.GetPaymentByIdRequest, $22.GetPaymentByIdResponse>(
      '/insurance.InsuranceService/GetPaymentById',
      ($22.GetPaymentByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetPaymentByIdResponse.fromBuffer(value));
  static final _$getOverduePayments = $grpc.ClientMethod<$22.GetOverduePaymentsRequest, $22.GetOverduePaymentsResponse>(
      '/insurance.InsuranceService/GetOverduePayments',
      ($22.GetOverduePaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetOverduePaymentsResponse.fromBuffer(value));
  static final _$getInsuranceClaims = $grpc.ClientMethod<$22.GetInsuranceClaimsRequest, $22.GetInsuranceClaimsResponse>(
      '/insurance.InsuranceService/GetInsuranceClaims',
      ($22.GetInsuranceClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetInsuranceClaimsResponse.fromBuffer(value));
  static final _$getUserClaims = $grpc.ClientMethod<$22.GetUserClaimsRequest, $22.GetUserClaimsResponse>(
      '/insurance.InsuranceService/GetUserClaims',
      ($22.GetUserClaimsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetUserClaimsResponse.fromBuffer(value));
  static final _$createClaim = $grpc.ClientMethod<$22.CreateClaimRequest, $22.CreateClaimResponse>(
      '/insurance.InsuranceService/CreateClaim',
      ($22.CreateClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.CreateClaimResponse.fromBuffer(value));
  static final _$updateClaim = $grpc.ClientMethod<$22.UpdateClaimRequest, $22.UpdateClaimResponse>(
      '/insurance.InsuranceService/UpdateClaim',
      ($22.UpdateClaimRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.UpdateClaimResponse.fromBuffer(value));
  static final _$getClaimById = $grpc.ClientMethod<$22.GetClaimByIdRequest, $22.GetClaimByIdResponse>(
      '/insurance.InsuranceService/GetClaimById',
      ($22.GetClaimByIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetClaimByIdResponse.fromBuffer(value));
  static final _$generatePaymentReceipt = $grpc.ClientMethod<$22.GeneratePaymentReceiptRequest, $22.GeneratePaymentReceiptResponse>(
      '/insurance.InsuranceService/GeneratePaymentReceipt',
      ($22.GeneratePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GeneratePaymentReceiptResponse.fromBuffer(value));
  static final _$getUserReceipts = $grpc.ClientMethod<$22.GetUserReceiptsRequest, $22.GetUserReceiptsResponse>(
      '/insurance.InsuranceService/GetUserReceipts',
      ($22.GetUserReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetUserReceiptsResponse.fromBuffer(value));
  static final _$getInsuranceStatistics = $grpc.ClientMethod<$22.GetInsuranceStatisticsRequest, $22.GetInsuranceStatisticsResponse>(
      '/insurance.InsuranceService/GetInsuranceStatistics',
      ($22.GetInsuranceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetInsuranceStatisticsResponse.fromBuffer(value));
  static final _$getPaymentStatistics = $grpc.ClientMethod<$22.GetPaymentStatisticsRequest, $22.GetPaymentStatisticsResponse>(
      '/insurance.InsuranceService/GetPaymentStatistics',
      ($22.GetPaymentStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $22.GetPaymentStatisticsResponse.fromBuffer(value));

  InsuranceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$22.GetUserInsurancesResponse> getUserInsurances($22.GetUserInsurancesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInsurances, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetInsuranceByIdResponse> getInsuranceById($22.GetInsuranceByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceById, request, options: options);
  }

  $grpc.ResponseFuture<$22.CreateInsuranceResponse> createInsurance($22.CreateInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdateInsuranceResponse> updateInsurance($22.UpdateInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$22.DeleteInsuranceResponse> deleteInsurance($22.DeleteInsuranceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInsurance, request, options: options);
  }

  $grpc.ResponseFuture<$22.SearchInsurancesResponse> searchInsurances($22.SearchInsurancesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchInsurances, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetInsurancePaymentsResponse> getInsurancePayments($22.GetInsurancePaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsurancePayments, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetUserPaymentsResponse> getUserPayments($22.GetUserPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPayments, request, options: options);
  }

  $grpc.ResponseFuture<$22.CreatePaymentResponse> createPayment($22.CreatePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPayment, request, options: options);
  }

  $grpc.ResponseFuture<$22.ProcessPaymentResponse> processPayment($22.ProcessPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$processPayment, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetPaymentByIdResponse> getPaymentById($22.GetPaymentByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentById, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetOverduePaymentsResponse> getOverduePayments($22.GetOverduePaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOverduePayments, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetInsuranceClaimsResponse> getInsuranceClaims($22.GetInsuranceClaimsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceClaims, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetUserClaimsResponse> getUserClaims($22.GetUserClaimsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserClaims, request, options: options);
  }

  $grpc.ResponseFuture<$22.CreateClaimResponse> createClaim($22.CreateClaimRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createClaim, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdateClaimResponse> updateClaim($22.UpdateClaimRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateClaim, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetClaimByIdResponse> getClaimById($22.GetClaimByIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getClaimById, request, options: options);
  }

  $grpc.ResponseFuture<$22.GeneratePaymentReceiptResponse> generatePaymentReceipt($22.GeneratePaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generatePaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetUserReceiptsResponse> getUserReceipts($22.GetUserReceiptsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetInsuranceStatisticsResponse> getInsuranceStatistics($22.GetInsuranceStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInsuranceStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetPaymentStatisticsResponse> getPaymentStatistics($22.GetPaymentStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentStatistics, request, options: options);
  }
}

@$pb.GrpcServiceName('insurance.InsuranceService')
abstract class InsuranceServiceBase extends $grpc.Service {
  $core.String get $name => 'insurance.InsuranceService';

  InsuranceServiceBase() {
    $addMethod($grpc.ServiceMethod<$22.GetUserInsurancesRequest, $22.GetUserInsurancesResponse>(
        'GetUserInsurances',
        getUserInsurances_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetUserInsurancesRequest.fromBuffer(value),
        ($22.GetUserInsurancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetInsuranceByIdRequest, $22.GetInsuranceByIdResponse>(
        'GetInsuranceById',
        getInsuranceById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetInsuranceByIdRequest.fromBuffer(value),
        ($22.GetInsuranceByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.CreateInsuranceRequest, $22.CreateInsuranceResponse>(
        'CreateInsurance',
        createInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.CreateInsuranceRequest.fromBuffer(value),
        ($22.CreateInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateInsuranceRequest, $22.UpdateInsuranceResponse>(
        'UpdateInsurance',
        updateInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.UpdateInsuranceRequest.fromBuffer(value),
        ($22.UpdateInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.DeleteInsuranceRequest, $22.DeleteInsuranceResponse>(
        'DeleteInsurance',
        deleteInsurance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.DeleteInsuranceRequest.fromBuffer(value),
        ($22.DeleteInsuranceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.SearchInsurancesRequest, $22.SearchInsurancesResponse>(
        'SearchInsurances',
        searchInsurances_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.SearchInsurancesRequest.fromBuffer(value),
        ($22.SearchInsurancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetInsurancePaymentsRequest, $22.GetInsurancePaymentsResponse>(
        'GetInsurancePayments',
        getInsurancePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetInsurancePaymentsRequest.fromBuffer(value),
        ($22.GetInsurancePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetUserPaymentsRequest, $22.GetUserPaymentsResponse>(
        'GetUserPayments',
        getUserPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetUserPaymentsRequest.fromBuffer(value),
        ($22.GetUserPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.CreatePaymentRequest, $22.CreatePaymentResponse>(
        'CreatePayment',
        createPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.CreatePaymentRequest.fromBuffer(value),
        ($22.CreatePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.ProcessPaymentRequest, $22.ProcessPaymentResponse>(
        'ProcessPayment',
        processPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.ProcessPaymentRequest.fromBuffer(value),
        ($22.ProcessPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetPaymentByIdRequest, $22.GetPaymentByIdResponse>(
        'GetPaymentById',
        getPaymentById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetPaymentByIdRequest.fromBuffer(value),
        ($22.GetPaymentByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetOverduePaymentsRequest, $22.GetOverduePaymentsResponse>(
        'GetOverduePayments',
        getOverduePayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetOverduePaymentsRequest.fromBuffer(value),
        ($22.GetOverduePaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetInsuranceClaimsRequest, $22.GetInsuranceClaimsResponse>(
        'GetInsuranceClaims',
        getInsuranceClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetInsuranceClaimsRequest.fromBuffer(value),
        ($22.GetInsuranceClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetUserClaimsRequest, $22.GetUserClaimsResponse>(
        'GetUserClaims',
        getUserClaims_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetUserClaimsRequest.fromBuffer(value),
        ($22.GetUserClaimsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.CreateClaimRequest, $22.CreateClaimResponse>(
        'CreateClaim',
        createClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.CreateClaimRequest.fromBuffer(value),
        ($22.CreateClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateClaimRequest, $22.UpdateClaimResponse>(
        'UpdateClaim',
        updateClaim_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.UpdateClaimRequest.fromBuffer(value),
        ($22.UpdateClaimResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetClaimByIdRequest, $22.GetClaimByIdResponse>(
        'GetClaimById',
        getClaimById_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetClaimByIdRequest.fromBuffer(value),
        ($22.GetClaimByIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GeneratePaymentReceiptRequest, $22.GeneratePaymentReceiptResponse>(
        'GeneratePaymentReceipt',
        generatePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GeneratePaymentReceiptRequest.fromBuffer(value),
        ($22.GeneratePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetUserReceiptsRequest, $22.GetUserReceiptsResponse>(
        'GetUserReceipts',
        getUserReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetUserReceiptsRequest.fromBuffer(value),
        ($22.GetUserReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetInsuranceStatisticsRequest, $22.GetInsuranceStatisticsResponse>(
        'GetInsuranceStatistics',
        getInsuranceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetInsuranceStatisticsRequest.fromBuffer(value),
        ($22.GetInsuranceStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetPaymentStatisticsRequest, $22.GetPaymentStatisticsResponse>(
        'GetPaymentStatistics',
        getPaymentStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.GetPaymentStatisticsRequest.fromBuffer(value),
        ($22.GetPaymentStatisticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$22.GetUserInsurancesResponse> getUserInsurances_Pre($grpc.ServiceCall call, $async.Future<$22.GetUserInsurancesRequest> request) async {
    return getUserInsurances(call, await request);
  }

  $async.Future<$22.GetInsuranceByIdResponse> getInsuranceById_Pre($grpc.ServiceCall call, $async.Future<$22.GetInsuranceByIdRequest> request) async {
    return getInsuranceById(call, await request);
  }

  $async.Future<$22.CreateInsuranceResponse> createInsurance_Pre($grpc.ServiceCall call, $async.Future<$22.CreateInsuranceRequest> request) async {
    return createInsurance(call, await request);
  }

  $async.Future<$22.UpdateInsuranceResponse> updateInsurance_Pre($grpc.ServiceCall call, $async.Future<$22.UpdateInsuranceRequest> request) async {
    return updateInsurance(call, await request);
  }

  $async.Future<$22.DeleteInsuranceResponse> deleteInsurance_Pre($grpc.ServiceCall call, $async.Future<$22.DeleteInsuranceRequest> request) async {
    return deleteInsurance(call, await request);
  }

  $async.Future<$22.SearchInsurancesResponse> searchInsurances_Pre($grpc.ServiceCall call, $async.Future<$22.SearchInsurancesRequest> request) async {
    return searchInsurances(call, await request);
  }

  $async.Future<$22.GetInsurancePaymentsResponse> getInsurancePayments_Pre($grpc.ServiceCall call, $async.Future<$22.GetInsurancePaymentsRequest> request) async {
    return getInsurancePayments(call, await request);
  }

  $async.Future<$22.GetUserPaymentsResponse> getUserPayments_Pre($grpc.ServiceCall call, $async.Future<$22.GetUserPaymentsRequest> request) async {
    return getUserPayments(call, await request);
  }

  $async.Future<$22.CreatePaymentResponse> createPayment_Pre($grpc.ServiceCall call, $async.Future<$22.CreatePaymentRequest> request) async {
    return createPayment(call, await request);
  }

  $async.Future<$22.ProcessPaymentResponse> processPayment_Pre($grpc.ServiceCall call, $async.Future<$22.ProcessPaymentRequest> request) async {
    return processPayment(call, await request);
  }

  $async.Future<$22.GetPaymentByIdResponse> getPaymentById_Pre($grpc.ServiceCall call, $async.Future<$22.GetPaymentByIdRequest> request) async {
    return getPaymentById(call, await request);
  }

  $async.Future<$22.GetOverduePaymentsResponse> getOverduePayments_Pre($grpc.ServiceCall call, $async.Future<$22.GetOverduePaymentsRequest> request) async {
    return getOverduePayments(call, await request);
  }

  $async.Future<$22.GetInsuranceClaimsResponse> getInsuranceClaims_Pre($grpc.ServiceCall call, $async.Future<$22.GetInsuranceClaimsRequest> request) async {
    return getInsuranceClaims(call, await request);
  }

  $async.Future<$22.GetUserClaimsResponse> getUserClaims_Pre($grpc.ServiceCall call, $async.Future<$22.GetUserClaimsRequest> request) async {
    return getUserClaims(call, await request);
  }

  $async.Future<$22.CreateClaimResponse> createClaim_Pre($grpc.ServiceCall call, $async.Future<$22.CreateClaimRequest> request) async {
    return createClaim(call, await request);
  }

  $async.Future<$22.UpdateClaimResponse> updateClaim_Pre($grpc.ServiceCall call, $async.Future<$22.UpdateClaimRequest> request) async {
    return updateClaim(call, await request);
  }

  $async.Future<$22.GetClaimByIdResponse> getClaimById_Pre($grpc.ServiceCall call, $async.Future<$22.GetClaimByIdRequest> request) async {
    return getClaimById(call, await request);
  }

  $async.Future<$22.GeneratePaymentReceiptResponse> generatePaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$22.GeneratePaymentReceiptRequest> request) async {
    return generatePaymentReceipt(call, await request);
  }

  $async.Future<$22.GetUserReceiptsResponse> getUserReceipts_Pre($grpc.ServiceCall call, $async.Future<$22.GetUserReceiptsRequest> request) async {
    return getUserReceipts(call, await request);
  }

  $async.Future<$22.GetInsuranceStatisticsResponse> getInsuranceStatistics_Pre($grpc.ServiceCall call, $async.Future<$22.GetInsuranceStatisticsRequest> request) async {
    return getInsuranceStatistics(call, await request);
  }

  $async.Future<$22.GetPaymentStatisticsResponse> getPaymentStatistics_Pre($grpc.ServiceCall call, $async.Future<$22.GetPaymentStatisticsRequest> request) async {
    return getPaymentStatistics(call, await request);
  }

  $async.Future<$22.GetUserInsurancesResponse> getUserInsurances($grpc.ServiceCall call, $22.GetUserInsurancesRequest request);
  $async.Future<$22.GetInsuranceByIdResponse> getInsuranceById($grpc.ServiceCall call, $22.GetInsuranceByIdRequest request);
  $async.Future<$22.CreateInsuranceResponse> createInsurance($grpc.ServiceCall call, $22.CreateInsuranceRequest request);
  $async.Future<$22.UpdateInsuranceResponse> updateInsurance($grpc.ServiceCall call, $22.UpdateInsuranceRequest request);
  $async.Future<$22.DeleteInsuranceResponse> deleteInsurance($grpc.ServiceCall call, $22.DeleteInsuranceRequest request);
  $async.Future<$22.SearchInsurancesResponse> searchInsurances($grpc.ServiceCall call, $22.SearchInsurancesRequest request);
  $async.Future<$22.GetInsurancePaymentsResponse> getInsurancePayments($grpc.ServiceCall call, $22.GetInsurancePaymentsRequest request);
  $async.Future<$22.GetUserPaymentsResponse> getUserPayments($grpc.ServiceCall call, $22.GetUserPaymentsRequest request);
  $async.Future<$22.CreatePaymentResponse> createPayment($grpc.ServiceCall call, $22.CreatePaymentRequest request);
  $async.Future<$22.ProcessPaymentResponse> processPayment($grpc.ServiceCall call, $22.ProcessPaymentRequest request);
  $async.Future<$22.GetPaymentByIdResponse> getPaymentById($grpc.ServiceCall call, $22.GetPaymentByIdRequest request);
  $async.Future<$22.GetOverduePaymentsResponse> getOverduePayments($grpc.ServiceCall call, $22.GetOverduePaymentsRequest request);
  $async.Future<$22.GetInsuranceClaimsResponse> getInsuranceClaims($grpc.ServiceCall call, $22.GetInsuranceClaimsRequest request);
  $async.Future<$22.GetUserClaimsResponse> getUserClaims($grpc.ServiceCall call, $22.GetUserClaimsRequest request);
  $async.Future<$22.CreateClaimResponse> createClaim($grpc.ServiceCall call, $22.CreateClaimRequest request);
  $async.Future<$22.UpdateClaimResponse> updateClaim($grpc.ServiceCall call, $22.UpdateClaimRequest request);
  $async.Future<$22.GetClaimByIdResponse> getClaimById($grpc.ServiceCall call, $22.GetClaimByIdRequest request);
  $async.Future<$22.GeneratePaymentReceiptResponse> generatePaymentReceipt($grpc.ServiceCall call, $22.GeneratePaymentReceiptRequest request);
  $async.Future<$22.GetUserReceiptsResponse> getUserReceipts($grpc.ServiceCall call, $22.GetUserReceiptsRequest request);
  $async.Future<$22.GetInsuranceStatisticsResponse> getInsuranceStatistics($grpc.ServiceCall call, $22.GetInsuranceStatisticsRequest request);
  $async.Future<$22.GetPaymentStatisticsResponse> getPaymentStatistics($grpc.ServiceCall call, $22.GetPaymentStatisticsRequest request);
}
