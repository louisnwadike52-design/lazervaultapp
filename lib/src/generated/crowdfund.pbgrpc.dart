///
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'crowdfund.pb.dart' as $9;
export 'crowdfund.pb.dart';

class CrowdfundServiceClient extends $grpc.Client {
  static final _$createCrowdfund =
      $grpc.ClientMethod<$9.CreateCrowdfundRequest, $9.CreateCrowdfundResponse>(
          '/pb.CrowdfundService/CreateCrowdfund',
          ($9.CreateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $9.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfund =
      $grpc.ClientMethod<$9.GetCrowdfundRequest, $9.GetCrowdfundResponse>(
          '/pb.CrowdfundService/GetCrowdfund',
          ($9.GetCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $9.GetCrowdfundResponse.fromBuffer(value));
  static final _$listCrowdfunds =
      $grpc.ClientMethod<$9.ListCrowdfundsRequest, $9.ListCrowdfundsResponse>(
          '/pb.CrowdfundService/ListCrowdfunds',
          ($9.ListCrowdfundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $9.ListCrowdfundsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<
          $9.SearchCrowdfundsRequest, $9.SearchCrowdfundsResponse>(
      '/pb.CrowdfundService/SearchCrowdfunds',
      ($9.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund =
      $grpc.ClientMethod<$9.UpdateCrowdfundRequest, $9.UpdateCrowdfundResponse>(
          '/pb.CrowdfundService/UpdateCrowdfund',
          ($9.UpdateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $9.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund =
      $grpc.ClientMethod<$9.DeleteCrowdfundRequest, $9.DeleteCrowdfundResponse>(
          '/pb.CrowdfundService/DeleteCrowdfund',
          ($9.DeleteCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $9.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$makeDonation =
      $grpc.ClientMethod<$9.MakeDonationRequest, $9.MakeDonationResponse>(
          '/pb.CrowdfundService/MakeDonation',
          ($9.MakeDonationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $9.MakeDonationResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<
          $9.GetCrowdfundDonationsRequest, $9.GetCrowdfundDonationsResponse>(
      '/pb.CrowdfundService/GetCrowdfundDonations',
      ($9.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<
          $9.GetUserDonationsRequest, $9.GetUserDonationsResponse>(
      '/pb.CrowdfundService/GetUserDonations',
      ($9.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<
          $9.GenerateDonationReceiptRequest,
          $9.GenerateDonationReceiptResponse>(
      '/pb.CrowdfundService/GenerateDonationReceipt',
      ($9.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<
          $9.GetUserCrowdfundReceiptsRequest,
          $9.GetUserCrowdfundReceiptsResponse>(
      '/pb.CrowdfundService/GetUserCrowdfundReceipts',
      ($9.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<
          $9.GetCrowdfundStatisticsRequest, $9.GetCrowdfundStatisticsResponse>(
      '/pb.CrowdfundService/GetCrowdfundStatistics',
      ($9.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $9.GetCrowdfundStatisticsResponse.fromBuffer(value));

  CrowdfundServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$9.CreateCrowdfundResponse> createCrowdfund(
      $9.CreateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$9.GetCrowdfundResponse> getCrowdfund(
      $9.GetCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$9.ListCrowdfundsResponse> listCrowdfunds(
      $9.ListCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$9.SearchCrowdfundsResponse> searchCrowdfunds(
      $9.SearchCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$9.UpdateCrowdfundResponse> updateCrowdfund(
      $9.UpdateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$9.DeleteCrowdfundResponse> deleteCrowdfund(
      $9.DeleteCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$9.MakeDonationResponse> makeDonation(
      $9.MakeDonationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeDonation, request, options: options);
  }

  $grpc.ResponseFuture<$9.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $9.GetCrowdfundDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$9.GetUserDonationsResponse> getUserDonations(
      $9.GetUserDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$9.GenerateDonationReceiptResponse>
      generateDonationReceipt($9.GenerateDonationReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$9.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts($9.GetUserCrowdfundReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$9.GetCrowdfundStatisticsResponse>
      getCrowdfundStatistics($9.GetCrowdfundStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request,
        options: options);
  }
}

abstract class CrowdfundServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CrowdfundService';

  CrowdfundServiceBase() {
    $addMethod($grpc.ServiceMethod<$9.CreateCrowdfundRequest,
            $9.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.CreateCrowdfundRequest.fromBuffer(value),
        ($9.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$9.GetCrowdfundRequest, $9.GetCrowdfundResponse>(
            'GetCrowdfund',
            getCrowdfund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $9.GetCrowdfundRequest.fromBuffer(value),
            ($9.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.ListCrowdfundsRequest,
            $9.ListCrowdfundsResponse>(
        'ListCrowdfunds',
        listCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.ListCrowdfundsRequest.fromBuffer(value),
        ($9.ListCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.SearchCrowdfundsRequest,
            $9.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.SearchCrowdfundsRequest.fromBuffer(value),
        ($9.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.UpdateCrowdfundRequest,
            $9.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.UpdateCrowdfundRequest.fromBuffer(value),
        ($9.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.DeleteCrowdfundRequest,
            $9.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.DeleteCrowdfundRequest.fromBuffer(value),
        ($9.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$9.MakeDonationRequest, $9.MakeDonationResponse>(
            'MakeDonation',
            makeDonation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $9.MakeDonationRequest.fromBuffer(value),
            ($9.MakeDonationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.GetCrowdfundDonationsRequest,
            $9.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($9.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.GetUserDonationsRequest,
            $9.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.GetUserDonationsRequest.fromBuffer(value),
        ($9.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.GenerateDonationReceiptRequest,
            $9.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.GenerateDonationReceiptRequest.fromBuffer(value),
        ($9.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.GetUserCrowdfundReceiptsRequest,
            $9.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($9.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.GetCrowdfundStatisticsRequest,
            $9.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($9.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$9.CreateCrowdfundResponse> createCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$9.GetCrowdfundResponse> getCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$9.ListCrowdfundsResponse> listCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.ListCrowdfundsRequest> request) async {
    return listCrowdfunds(call, await request);
  }

  $async.Future<$9.SearchCrowdfundsResponse> searchCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$9.UpdateCrowdfundResponse> updateCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$9.DeleteCrowdfundResponse> deleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$9.MakeDonationResponse> makeDonation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.MakeDonationRequest> request) async {
    return makeDonation(call, await request);
  }

  $async.Future<$9.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$9.GetUserDonationsResponse> getUserDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$9.GenerateDonationReceiptResponse> generateDonationReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$9.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$9.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$9.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$9.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$9.CreateCrowdfundResponse> createCrowdfund(
      $grpc.ServiceCall call, $9.CreateCrowdfundRequest request);
  $async.Future<$9.GetCrowdfundResponse> getCrowdfund(
      $grpc.ServiceCall call, $9.GetCrowdfundRequest request);
  $async.Future<$9.ListCrowdfundsResponse> listCrowdfunds(
      $grpc.ServiceCall call, $9.ListCrowdfundsRequest request);
  $async.Future<$9.SearchCrowdfundsResponse> searchCrowdfunds(
      $grpc.ServiceCall call, $9.SearchCrowdfundsRequest request);
  $async.Future<$9.UpdateCrowdfundResponse> updateCrowdfund(
      $grpc.ServiceCall call, $9.UpdateCrowdfundRequest request);
  $async.Future<$9.DeleteCrowdfundResponse> deleteCrowdfund(
      $grpc.ServiceCall call, $9.DeleteCrowdfundRequest request);
  $async.Future<$9.MakeDonationResponse> makeDonation(
      $grpc.ServiceCall call, $9.MakeDonationRequest request);
  $async.Future<$9.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $grpc.ServiceCall call, $9.GetCrowdfundDonationsRequest request);
  $async.Future<$9.GetUserDonationsResponse> getUserDonations(
      $grpc.ServiceCall call, $9.GetUserDonationsRequest request);
  $async.Future<$9.GenerateDonationReceiptResponse> generateDonationReceipt(
      $grpc.ServiceCall call, $9.GenerateDonationReceiptRequest request);
  $async.Future<$9.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts(
      $grpc.ServiceCall call, $9.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$9.GetCrowdfundStatisticsResponse> getCrowdfundStatistics(
      $grpc.ServiceCall call, $9.GetCrowdfundStatisticsRequest request);
}
