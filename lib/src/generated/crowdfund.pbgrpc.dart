///
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'crowdfund.pb.dart' as $0;
export 'crowdfund.pb.dart';

class CrowdfundServiceClient extends $grpc.Client {
  static final _$createCrowdfund =
      $grpc.ClientMethod<$0.CreateCrowdfundRequest, $0.CreateCrowdfundResponse>(
          '/pb.CrowdfundService/CreateCrowdfund',
          ($0.CreateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfund =
      $grpc.ClientMethod<$0.GetCrowdfundRequest, $0.GetCrowdfundResponse>(
          '/pb.CrowdfundService/GetCrowdfund',
          ($0.GetCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetCrowdfundResponse.fromBuffer(value));
  static final _$listCrowdfunds =
      $grpc.ClientMethod<$0.ListCrowdfundsRequest, $0.ListCrowdfundsResponse>(
          '/pb.CrowdfundService/ListCrowdfunds',
          ($0.ListCrowdfundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListCrowdfundsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<
          $0.SearchCrowdfundsRequest, $0.SearchCrowdfundsResponse>(
      '/pb.CrowdfundService/SearchCrowdfunds',
      ($0.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund =
      $grpc.ClientMethod<$0.UpdateCrowdfundRequest, $0.UpdateCrowdfundResponse>(
          '/pb.CrowdfundService/UpdateCrowdfund',
          ($0.UpdateCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund =
      $grpc.ClientMethod<$0.DeleteCrowdfundRequest, $0.DeleteCrowdfundResponse>(
          '/pb.CrowdfundService/DeleteCrowdfund',
          ($0.DeleteCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$makeDonation =
      $grpc.ClientMethod<$0.MakeDonationRequest, $0.MakeDonationResponse>(
          '/pb.CrowdfundService/MakeDonation',
          ($0.MakeDonationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MakeDonationResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<
          $0.GetCrowdfundDonationsRequest, $0.GetCrowdfundDonationsResponse>(
      '/pb.CrowdfundService/GetCrowdfundDonations',
      ($0.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<
          $0.GetUserDonationsRequest, $0.GetUserDonationsResponse>(
      '/pb.CrowdfundService/GetUserDonations',
      ($0.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<
          $0.GenerateDonationReceiptRequest,
          $0.GenerateDonationReceiptResponse>(
      '/pb.CrowdfundService/GenerateDonationReceipt',
      ($0.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<
          $0.GetUserCrowdfundReceiptsRequest,
          $0.GetUserCrowdfundReceiptsResponse>(
      '/pb.CrowdfundService/GetUserCrowdfundReceipts',
      ($0.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<
          $0.GetCrowdfundStatisticsRequest, $0.GetCrowdfundStatisticsResponse>(
      '/pb.CrowdfundService/GetCrowdfundStatistics',
      ($0.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetCrowdfundStatisticsResponse.fromBuffer(value));
  static final _$connectNotificationChannel = $grpc.ClientMethod<
          $0.ConnectNotificationChannelRequest,
          $0.ConnectNotificationChannelResponse>(
      '/pb.CrowdfundService/ConnectNotificationChannel',
      ($0.ConnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ConnectNotificationChannelResponse.fromBuffer(value));
  static final _$disconnectNotificationChannel = $grpc.ClientMethod<
          $0.DisconnectNotificationChannelRequest,
          $0.DisconnectNotificationChannelResponse>(
      '/pb.CrowdfundService/DisconnectNotificationChannel',
      ($0.DisconnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DisconnectNotificationChannelResponse.fromBuffer(value));
  static final _$getNotificationChannels = $grpc.ClientMethod<
          $0.GetNotificationChannelsRequest,
          $0.GetNotificationChannelsResponse>(
      '/pb.CrowdfundService/GetNotificationChannels',
      ($0.GetNotificationChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetNotificationChannelsResponse.fromBuffer(value));
  static final _$updateNotificationChannel = $grpc.ClientMethod<
          $0.UpdateNotificationChannelRequest,
          $0.UpdateNotificationChannelResponse>(
      '/pb.CrowdfundService/UpdateNotificationChannel',
      ($0.UpdateNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateNotificationChannelResponse.fromBuffer(value));
  static final _$testNotificationChannel = $grpc.ClientMethod<
          $0.TestNotificationChannelRequest,
          $0.TestNotificationChannelResponse>(
      '/pb.CrowdfundService/TestNotificationChannel',
      ($0.TestNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.TestNotificationChannelResponse.fromBuffer(value));
  static final _$getTelegramBotInfo = $grpc.ClientMethod<
          $0.GetTelegramBotInfoRequest, $0.GetTelegramBotInfoResponse>(
      '/pb.CrowdfundService/GetTelegramBotInfo',
      ($0.GetTelegramBotInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTelegramBotInfoResponse.fromBuffer(value));
  static final _$verifyTelegramChannel = $grpc.ClientMethod<
          $0.VerifyTelegramChannelRequest, $0.VerifyTelegramChannelResponse>(
      '/pb.CrowdfundService/VerifyTelegramChannel',
      ($0.VerifyTelegramChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.VerifyTelegramChannelResponse.fromBuffer(value));
  static final _$getNotificationHistory = $grpc.ClientMethod<
          $0.GetNotificationHistoryRequest, $0.GetNotificationHistoryResponse>(
      '/pb.CrowdfundService/GetNotificationHistory',
      ($0.GetNotificationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetNotificationHistoryResponse.fromBuffer(value));

  CrowdfundServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateCrowdfundResponse> createCrowdfund(
      $0.CreateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundResponse> getCrowdfund(
      $0.GetCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListCrowdfundsResponse> listCrowdfunds(
      $0.ListCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchCrowdfundsResponse> searchCrowdfunds(
      $0.SearchCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateCrowdfundResponse> updateCrowdfund(
      $0.UpdateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteCrowdfundResponse> deleteCrowdfund(
      $0.DeleteCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$0.MakeDonationResponse> makeDonation(
      $0.MakeDonationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeDonation, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $0.GetCrowdfundDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserDonationsResponse> getUserDonations(
      $0.GetUserDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateDonationReceiptResponse>
      generateDonationReceipt($0.GenerateDonationReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts($0.GetUserCrowdfundReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetCrowdfundStatisticsResponse>
      getCrowdfundStatistics($0.GetCrowdfundStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ConnectNotificationChannelResponse>
      connectNotificationChannel($0.ConnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel(
          $0.DisconnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetNotificationChannelsResponse>
      getNotificationChannels($0.GetNotificationChannelsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationChannels, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateNotificationChannelResponse>
      updateNotificationChannel($0.UpdateNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TestNotificationChannelResponse>
      testNotificationChannel($0.TestNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $0.GetTelegramBotInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTelegramBotInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $0.VerifyTelegramChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTelegramChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetNotificationHistoryResponse>
      getNotificationHistory($0.GetNotificationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationHistory, request,
        options: options);
  }
}

abstract class CrowdfundServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CrowdfundService';

  CrowdfundServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateCrowdfundRequest,
            $0.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateCrowdfundRequest.fromBuffer(value),
        ($0.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetCrowdfundRequest, $0.GetCrowdfundResponse>(
            'GetCrowdfund',
            getCrowdfund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetCrowdfundRequest.fromBuffer(value),
            ($0.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListCrowdfundsRequest,
            $0.ListCrowdfundsResponse>(
        'ListCrowdfunds',
        listCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListCrowdfundsRequest.fromBuffer(value),
        ($0.ListCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchCrowdfundsRequest,
            $0.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SearchCrowdfundsRequest.fromBuffer(value),
        ($0.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCrowdfundRequest,
            $0.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCrowdfundRequest.fromBuffer(value),
        ($0.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteCrowdfundRequest,
            $0.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteCrowdfundRequest.fromBuffer(value),
        ($0.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.MakeDonationRequest, $0.MakeDonationResponse>(
            'MakeDonation',
            makeDonation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.MakeDonationRequest.fromBuffer(value),
            ($0.MakeDonationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundDonationsRequest,
            $0.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($0.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserDonationsRequest,
            $0.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserDonationsRequest.fromBuffer(value),
        ($0.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateDonationReceiptRequest,
            $0.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateDonationReceiptRequest.fromBuffer(value),
        ($0.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserCrowdfundReceiptsRequest,
            $0.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($0.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCrowdfundStatisticsRequest,
            $0.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($0.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConnectNotificationChannelRequest,
            $0.ConnectNotificationChannelResponse>(
        'ConnectNotificationChannel',
        connectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ConnectNotificationChannelRequest.fromBuffer(value),
        ($0.ConnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DisconnectNotificationChannelRequest,
            $0.DisconnectNotificationChannelResponse>(
        'DisconnectNotificationChannel',
        disconnectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DisconnectNotificationChannelRequest.fromBuffer(value),
        ($0.DisconnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetNotificationChannelsRequest,
            $0.GetNotificationChannelsResponse>(
        'GetNotificationChannels',
        getNotificationChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetNotificationChannelsRequest.fromBuffer(value),
        ($0.GetNotificationChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateNotificationChannelRequest,
            $0.UpdateNotificationChannelResponse>(
        'UpdateNotificationChannel',
        updateNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateNotificationChannelRequest.fromBuffer(value),
        ($0.UpdateNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TestNotificationChannelRequest,
            $0.TestNotificationChannelResponse>(
        'TestNotificationChannel',
        testNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TestNotificationChannelRequest.fromBuffer(value),
        ($0.TestNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTelegramBotInfoRequest,
            $0.GetTelegramBotInfoResponse>(
        'GetTelegramBotInfo',
        getTelegramBotInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTelegramBotInfoRequest.fromBuffer(value),
        ($0.GetTelegramBotInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyTelegramChannelRequest,
            $0.VerifyTelegramChannelResponse>(
        'VerifyTelegramChannel',
        verifyTelegramChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyTelegramChannelRequest.fromBuffer(value),
        ($0.VerifyTelegramChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetNotificationHistoryRequest,
            $0.GetNotificationHistoryResponse>(
        'GetNotificationHistory',
        getNotificationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetNotificationHistoryRequest.fromBuffer(value),
        ($0.GetNotificationHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateCrowdfundResponse> createCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$0.GetCrowdfundResponse> getCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$0.ListCrowdfundsResponse> listCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListCrowdfundsRequest> request) async {
    return listCrowdfunds(call, await request);
  }

  $async.Future<$0.SearchCrowdfundsResponse> searchCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$0.UpdateCrowdfundResponse> updateCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$0.DeleteCrowdfundResponse> deleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$0.MakeDonationResponse> makeDonation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.MakeDonationRequest> request) async {
    return makeDonation(call, await request);
  }

  $async.Future<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$0.GetUserDonationsResponse> getUserDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$0.GenerateDonationReceiptResponse> generateDonationReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$0.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$0.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$0.ConnectNotificationChannelResponse>
      connectNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$0.ConnectNotificationChannelRequest> request) async {
    return connectNotificationChannel(call, await request);
  }

  $async.Future<$0.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.DisconnectNotificationChannelRequest>
              request) async {
    return disconnectNotificationChannel(call, await request);
  }

  $async.Future<$0.GetNotificationChannelsResponse> getNotificationChannels_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetNotificationChannelsRequest> request) async {
    return getNotificationChannels(call, await request);
  }

  $async.Future<$0.UpdateNotificationChannelResponse>
      updateNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$0.UpdateNotificationChannelRequest> request) async {
    return updateNotificationChannel(call, await request);
  }

  $async.Future<$0.TestNotificationChannelResponse> testNotificationChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.TestNotificationChannelRequest> request) async {
    return testNotificationChannel(call, await request);
  }

  $async.Future<$0.GetTelegramBotInfoResponse> getTelegramBotInfo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTelegramBotInfoRequest> request) async {
    return getTelegramBotInfo(call, await request);
  }

  $async.Future<$0.VerifyTelegramChannelResponse> verifyTelegramChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.VerifyTelegramChannelRequest> request) async {
    return verifyTelegramChannel(call, await request);
  }

  $async.Future<$0.GetNotificationHistoryResponse> getNotificationHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetNotificationHistoryRequest> request) async {
    return getNotificationHistory(call, await request);
  }

  $async.Future<$0.CreateCrowdfundResponse> createCrowdfund(
      $grpc.ServiceCall call, $0.CreateCrowdfundRequest request);
  $async.Future<$0.GetCrowdfundResponse> getCrowdfund(
      $grpc.ServiceCall call, $0.GetCrowdfundRequest request);
  $async.Future<$0.ListCrowdfundsResponse> listCrowdfunds(
      $grpc.ServiceCall call, $0.ListCrowdfundsRequest request);
  $async.Future<$0.SearchCrowdfundsResponse> searchCrowdfunds(
      $grpc.ServiceCall call, $0.SearchCrowdfundsRequest request);
  $async.Future<$0.UpdateCrowdfundResponse> updateCrowdfund(
      $grpc.ServiceCall call, $0.UpdateCrowdfundRequest request);
  $async.Future<$0.DeleteCrowdfundResponse> deleteCrowdfund(
      $grpc.ServiceCall call, $0.DeleteCrowdfundRequest request);
  $async.Future<$0.MakeDonationResponse> makeDonation(
      $grpc.ServiceCall call, $0.MakeDonationRequest request);
  $async.Future<$0.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $grpc.ServiceCall call, $0.GetCrowdfundDonationsRequest request);
  $async.Future<$0.GetUserDonationsResponse> getUserDonations(
      $grpc.ServiceCall call, $0.GetUserDonationsRequest request);
  $async.Future<$0.GenerateDonationReceiptResponse> generateDonationReceipt(
      $grpc.ServiceCall call, $0.GenerateDonationReceiptRequest request);
  $async.Future<$0.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts(
      $grpc.ServiceCall call, $0.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$0.GetCrowdfundStatisticsResponse> getCrowdfundStatistics(
      $grpc.ServiceCall call, $0.GetCrowdfundStatisticsRequest request);
  $async.Future<$0.ConnectNotificationChannelResponse>
      connectNotificationChannel(
          $grpc.ServiceCall call, $0.ConnectNotificationChannelRequest request);
  $async.Future<$0.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel($grpc.ServiceCall call,
          $0.DisconnectNotificationChannelRequest request);
  $async.Future<$0.GetNotificationChannelsResponse> getNotificationChannels(
      $grpc.ServiceCall call, $0.GetNotificationChannelsRequest request);
  $async.Future<$0.UpdateNotificationChannelResponse> updateNotificationChannel(
      $grpc.ServiceCall call, $0.UpdateNotificationChannelRequest request);
  $async.Future<$0.TestNotificationChannelResponse> testNotificationChannel(
      $grpc.ServiceCall call, $0.TestNotificationChannelRequest request);
  $async.Future<$0.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $grpc.ServiceCall call, $0.GetTelegramBotInfoRequest request);
  $async.Future<$0.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $grpc.ServiceCall call, $0.VerifyTelegramChannelRequest request);
  $async.Future<$0.GetNotificationHistoryResponse> getNotificationHistory(
      $grpc.ServiceCall call, $0.GetNotificationHistoryRequest request);
}
