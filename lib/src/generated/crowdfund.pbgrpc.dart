///
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'crowdfund.pb.dart' as $10;
export 'crowdfund.pb.dart';

class CrowdfundServiceClient extends $grpc.Client {
  static final _$createCrowdfund = $grpc.ClientMethod<
          $10.CreateCrowdfundRequest, $10.CreateCrowdfundResponse>(
      '/pb.CrowdfundService/CreateCrowdfund',
      ($10.CreateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfund =
      $grpc.ClientMethod<$10.GetCrowdfundRequest, $10.GetCrowdfundResponse>(
          '/pb.CrowdfundService/GetCrowdfund',
          ($10.GetCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.GetCrowdfundResponse.fromBuffer(value));
  static final _$listCrowdfunds =
      $grpc.ClientMethod<$10.ListCrowdfundsRequest, $10.ListCrowdfundsResponse>(
          '/pb.CrowdfundService/ListCrowdfunds',
          ($10.ListCrowdfundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.ListCrowdfundsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<
          $10.SearchCrowdfundsRequest, $10.SearchCrowdfundsResponse>(
      '/pb.CrowdfundService/SearchCrowdfunds',
      ($10.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund = $grpc.ClientMethod<
          $10.UpdateCrowdfundRequest, $10.UpdateCrowdfundResponse>(
      '/pb.CrowdfundService/UpdateCrowdfund',
      ($10.UpdateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund = $grpc.ClientMethod<
          $10.DeleteCrowdfundRequest, $10.DeleteCrowdfundResponse>(
      '/pb.CrowdfundService/DeleteCrowdfund',
      ($10.DeleteCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$makeDonation =
      $grpc.ClientMethod<$10.MakeDonationRequest, $10.MakeDonationResponse>(
          '/pb.CrowdfundService/MakeDonation',
          ($10.MakeDonationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $10.MakeDonationResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<
          $10.GetCrowdfundDonationsRequest, $10.GetCrowdfundDonationsResponse>(
      '/pb.CrowdfundService/GetCrowdfundDonations',
      ($10.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<
          $10.GetUserDonationsRequest, $10.GetUserDonationsResponse>(
      '/pb.CrowdfundService/GetUserDonations',
      ($10.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<
          $10.GenerateDonationReceiptRequest,
          $10.GenerateDonationReceiptResponse>(
      '/pb.CrowdfundService/GenerateDonationReceipt',
      ($10.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<
          $10.GetUserCrowdfundReceiptsRequest,
          $10.GetUserCrowdfundReceiptsResponse>(
      '/pb.CrowdfundService/GetUserCrowdfundReceipts',
      ($10.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<
          $10.GetCrowdfundStatisticsRequest,
          $10.GetCrowdfundStatisticsResponse>(
      '/pb.CrowdfundService/GetCrowdfundStatistics',
      ($10.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $10.GetCrowdfundStatisticsResponse.fromBuffer(value));

  CrowdfundServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$10.CreateCrowdfundResponse> createCrowdfund(
      $10.CreateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetCrowdfundResponse> getCrowdfund(
      $10.GetCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$10.ListCrowdfundsResponse> listCrowdfunds(
      $10.ListCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$10.SearchCrowdfundsResponse> searchCrowdfunds(
      $10.SearchCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$10.UpdateCrowdfundResponse> updateCrowdfund(
      $10.UpdateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$10.DeleteCrowdfundResponse> deleteCrowdfund(
      $10.DeleteCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$10.MakeDonationResponse> makeDonation(
      $10.MakeDonationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeDonation, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $10.GetCrowdfundDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$10.GetUserDonationsResponse> getUserDonations(
      $10.GetUserDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$10.GenerateDonationReceiptResponse>
      generateDonationReceipt($10.GenerateDonationReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$10.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts($10.GetUserCrowdfundReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$10.GetCrowdfundStatisticsResponse>
      getCrowdfundStatistics($10.GetCrowdfundStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request,
        options: options);
  }
}

abstract class CrowdfundServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CrowdfundService';

  CrowdfundServiceBase() {
    $addMethod($grpc.ServiceMethod<$10.CreateCrowdfundRequest,
            $10.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.CreateCrowdfundRequest.fromBuffer(value),
        ($10.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.GetCrowdfundRequest, $10.GetCrowdfundResponse>(
            'GetCrowdfund',
            getCrowdfund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.GetCrowdfundRequest.fromBuffer(value),
            ($10.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.ListCrowdfundsRequest,
            $10.ListCrowdfundsResponse>(
        'ListCrowdfunds',
        listCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.ListCrowdfundsRequest.fromBuffer(value),
        ($10.ListCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.SearchCrowdfundsRequest,
            $10.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.SearchCrowdfundsRequest.fromBuffer(value),
        ($10.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.UpdateCrowdfundRequest,
            $10.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.UpdateCrowdfundRequest.fromBuffer(value),
        ($10.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.DeleteCrowdfundRequest,
            $10.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.DeleteCrowdfundRequest.fromBuffer(value),
        ($10.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$10.MakeDonationRequest, $10.MakeDonationResponse>(
            'MakeDonation',
            makeDonation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.MakeDonationRequest.fromBuffer(value),
            ($10.MakeDonationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetCrowdfundDonationsRequest,
            $10.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($10.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetUserDonationsRequest,
            $10.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetUserDonationsRequest.fromBuffer(value),
        ($10.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GenerateDonationReceiptRequest,
            $10.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GenerateDonationReceiptRequest.fromBuffer(value),
        ($10.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetUserCrowdfundReceiptsRequest,
            $10.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($10.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$10.GetCrowdfundStatisticsRequest,
            $10.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $10.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($10.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$10.CreateCrowdfundResponse> createCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$10.GetCrowdfundResponse> getCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$10.ListCrowdfundsResponse> listCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.ListCrowdfundsRequest> request) async {
    return listCrowdfunds(call, await request);
  }

  $async.Future<$10.SearchCrowdfundsResponse> searchCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$10.UpdateCrowdfundResponse> updateCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$10.DeleteCrowdfundResponse> deleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$10.MakeDonationResponse> makeDonation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.MakeDonationRequest> request) async {
    return makeDonation(call, await request);
  }

  $async.Future<$10.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$10.GetUserDonationsResponse> getUserDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$10.GenerateDonationReceiptResponse>
      generateDonationReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$10.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$10.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$10.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$10.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$10.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$10.CreateCrowdfundResponse> createCrowdfund(
      $grpc.ServiceCall call, $10.CreateCrowdfundRequest request);
  $async.Future<$10.GetCrowdfundResponse> getCrowdfund(
      $grpc.ServiceCall call, $10.GetCrowdfundRequest request);
  $async.Future<$10.ListCrowdfundsResponse> listCrowdfunds(
      $grpc.ServiceCall call, $10.ListCrowdfundsRequest request);
  $async.Future<$10.SearchCrowdfundsResponse> searchCrowdfunds(
      $grpc.ServiceCall call, $10.SearchCrowdfundsRequest request);
  $async.Future<$10.UpdateCrowdfundResponse> updateCrowdfund(
      $grpc.ServiceCall call, $10.UpdateCrowdfundRequest request);
  $async.Future<$10.DeleteCrowdfundResponse> deleteCrowdfund(
      $grpc.ServiceCall call, $10.DeleteCrowdfundRequest request);
  $async.Future<$10.MakeDonationResponse> makeDonation(
      $grpc.ServiceCall call, $10.MakeDonationRequest request);
  $async.Future<$10.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $grpc.ServiceCall call, $10.GetCrowdfundDonationsRequest request);
  $async.Future<$10.GetUserDonationsResponse> getUserDonations(
      $grpc.ServiceCall call, $10.GetUserDonationsRequest request);
  $async.Future<$10.GenerateDonationReceiptResponse> generateDonationReceipt(
      $grpc.ServiceCall call, $10.GenerateDonationReceiptRequest request);
  $async.Future<$10.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts(
      $grpc.ServiceCall call, $10.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$10.GetCrowdfundStatisticsResponse> getCrowdfundStatistics(
      $grpc.ServiceCall call, $10.GetCrowdfundStatisticsRequest request);
}
