///
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'crowdfund.pb.dart' as $11;
export 'crowdfund.pb.dart';

class CrowdfundServiceClient extends $grpc.Client {
  static final _$createCrowdfund = $grpc.ClientMethod<
          $11.CreateCrowdfundRequest, $11.CreateCrowdfundResponse>(
      '/pb.CrowdfundService/CreateCrowdfund',
      ($11.CreateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfund =
      $grpc.ClientMethod<$11.GetCrowdfundRequest, $11.GetCrowdfundResponse>(
          '/pb.CrowdfundService/GetCrowdfund',
          ($11.GetCrowdfundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $11.GetCrowdfundResponse.fromBuffer(value));
  static final _$listCrowdfunds =
      $grpc.ClientMethod<$11.ListCrowdfundsRequest, $11.ListCrowdfundsResponse>(
          '/pb.CrowdfundService/ListCrowdfunds',
          ($11.ListCrowdfundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $11.ListCrowdfundsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<
          $11.SearchCrowdfundsRequest, $11.SearchCrowdfundsResponse>(
      '/pb.CrowdfundService/SearchCrowdfunds',
      ($11.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund = $grpc.ClientMethod<
          $11.UpdateCrowdfundRequest, $11.UpdateCrowdfundResponse>(
      '/pb.CrowdfundService/UpdateCrowdfund',
      ($11.UpdateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund = $grpc.ClientMethod<
          $11.DeleteCrowdfundRequest, $11.DeleteCrowdfundResponse>(
      '/pb.CrowdfundService/DeleteCrowdfund',
      ($11.DeleteCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$makeDonation =
      $grpc.ClientMethod<$11.MakeDonationRequest, $11.MakeDonationResponse>(
          '/pb.CrowdfundService/MakeDonation',
          ($11.MakeDonationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $11.MakeDonationResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<
          $11.GetCrowdfundDonationsRequest, $11.GetCrowdfundDonationsResponse>(
      '/pb.CrowdfundService/GetCrowdfundDonations',
      ($11.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<
          $11.GetUserDonationsRequest, $11.GetUserDonationsResponse>(
      '/pb.CrowdfundService/GetUserDonations',
      ($11.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<
          $11.GenerateDonationReceiptRequest,
          $11.GenerateDonationReceiptResponse>(
      '/pb.CrowdfundService/GenerateDonationReceipt',
      ($11.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<
          $11.GetUserCrowdfundReceiptsRequest,
          $11.GetUserCrowdfundReceiptsResponse>(
      '/pb.CrowdfundService/GetUserCrowdfundReceipts',
      ($11.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<
          $11.GetCrowdfundStatisticsRequest,
          $11.GetCrowdfundStatisticsResponse>(
      '/pb.CrowdfundService/GetCrowdfundStatistics',
      ($11.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetCrowdfundStatisticsResponse.fromBuffer(value));
  static final _$withdrawFromCrowdfund = $grpc.ClientMethod<
          $11.WithdrawFromCrowdfundRequest, $11.WithdrawFromCrowdfundResponse>(
      '/pb.CrowdfundService/WithdrawFromCrowdfund',
      ($11.WithdrawFromCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.WithdrawFromCrowdfundResponse.fromBuffer(value));
  static final _$getMyCrowdfunds = $grpc.ClientMethod<
          $11.GetMyCrowdfundsRequest, $11.GetMyCrowdfundsResponse>(
      '/pb.CrowdfundService/GetMyCrowdfunds',
      ($11.GetMyCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetMyCrowdfundsResponse.fromBuffer(value));
  static final _$getCampaignWalletBalance = $grpc.ClientMethod<
          $11.GetCampaignWalletBalanceRequest,
          $11.GetCampaignWalletBalanceResponse>(
      '/pb.CrowdfundService/GetCampaignWalletBalance',
      ($11.GetCampaignWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetCampaignWalletBalanceResponse.fromBuffer(value));
  static final _$getCrowdfundLeaderboard = $grpc.ClientMethod<
          $11.GetCrowdfundLeaderboardRequest,
          $11.GetCrowdfundLeaderboardResponse>(
      '/pb.CrowdfundService/GetCrowdfundLeaderboard',
      ($11.GetCrowdfundLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetCrowdfundLeaderboardResponse.fromBuffer(value));
  static final _$connectNotificationChannel = $grpc.ClientMethod<
          $11.ConnectNotificationChannelRequest,
          $11.ConnectNotificationChannelResponse>(
      '/pb.CrowdfundService/ConnectNotificationChannel',
      ($11.ConnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.ConnectNotificationChannelResponse.fromBuffer(value));
  static final _$disconnectNotificationChannel = $grpc.ClientMethod<
          $11.DisconnectNotificationChannelRequest,
          $11.DisconnectNotificationChannelResponse>(
      '/pb.CrowdfundService/DisconnectNotificationChannel',
      ($11.DisconnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.DisconnectNotificationChannelResponse.fromBuffer(value));
  static final _$getNotificationChannels = $grpc.ClientMethod<
          $11.GetNotificationChannelsRequest,
          $11.GetNotificationChannelsResponse>(
      '/pb.CrowdfundService/GetNotificationChannels',
      ($11.GetNotificationChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetNotificationChannelsResponse.fromBuffer(value));
  static final _$updateNotificationChannel = $grpc.ClientMethod<
          $11.UpdateNotificationChannelRequest,
          $11.UpdateNotificationChannelResponse>(
      '/pb.CrowdfundService/UpdateNotificationChannel',
      ($11.UpdateNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.UpdateNotificationChannelResponse.fromBuffer(value));
  static final _$testNotificationChannel = $grpc.ClientMethod<
          $11.TestNotificationChannelRequest,
          $11.TestNotificationChannelResponse>(
      '/pb.CrowdfundService/TestNotificationChannel',
      ($11.TestNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.TestNotificationChannelResponse.fromBuffer(value));
  static final _$getTelegramBotInfo = $grpc.ClientMethod<
          $11.GetTelegramBotInfoRequest, $11.GetTelegramBotInfoResponse>(
      '/pb.CrowdfundService/GetTelegramBotInfo',
      ($11.GetTelegramBotInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetTelegramBotInfoResponse.fromBuffer(value));
  static final _$verifyTelegramChannel = $grpc.ClientMethod<
          $11.VerifyTelegramChannelRequest, $11.VerifyTelegramChannelResponse>(
      '/pb.CrowdfundService/VerifyTelegramChannel',
      ($11.VerifyTelegramChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.VerifyTelegramChannelResponse.fromBuffer(value));
  static final _$getNotificationHistory = $grpc.ClientMethod<
          $11.GetNotificationHistoryRequest,
          $11.GetNotificationHistoryResponse>(
      '/pb.CrowdfundService/GetNotificationHistory',
      ($11.GetNotificationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $11.GetNotificationHistoryResponse.fromBuffer(value));

  CrowdfundServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$11.CreateCrowdfundResponse> createCrowdfund(
      $11.CreateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetCrowdfundResponse> getCrowdfund(
      $11.GetCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$11.ListCrowdfundsResponse> listCrowdfunds(
      $11.ListCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$11.SearchCrowdfundsResponse> searchCrowdfunds(
      $11.SearchCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$11.UpdateCrowdfundResponse> updateCrowdfund(
      $11.UpdateCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$11.DeleteCrowdfundResponse> deleteCrowdfund(
      $11.DeleteCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$11.MakeDonationResponse> makeDonation(
      $11.MakeDonationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeDonation, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $11.GetCrowdfundDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetUserDonationsResponse> getUserDonations(
      $11.GetUserDonationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$11.GenerateDonationReceiptResponse>
      generateDonationReceipt($11.GenerateDonationReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts($11.GetUserCrowdfundReceiptsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.GetCrowdfundStatisticsResponse>
      getCrowdfundStatistics($11.GetCrowdfundStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $11.WithdrawFromCrowdfundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetMyCrowdfundsResponse> getMyCrowdfunds(
      $11.GetMyCrowdfundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetCampaignWalletBalanceResponse>
      getCampaignWalletBalance($11.GetCampaignWalletBalanceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCampaignWalletBalance, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.GetCrowdfundLeaderboardResponse>
      getCrowdfundLeaderboard($11.GetCrowdfundLeaderboardRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundLeaderboard, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.ConnectNotificationChannelResponse>
      connectNotificationChannel($11.ConnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel(
          $11.DisconnectNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.GetNotificationChannelsResponse>
      getNotificationChannels($11.GetNotificationChannelsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationChannels, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.UpdateNotificationChannelResponse>
      updateNotificationChannel($11.UpdateNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.TestNotificationChannelResponse>
      testNotificationChannel($11.TestNotificationChannelRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testNotificationChannel, request,
        options: options);
  }

  $grpc.ResponseFuture<$11.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $11.GetTelegramBotInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTelegramBotInfo, request, options: options);
  }

  $grpc.ResponseFuture<$11.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $11.VerifyTelegramChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTelegramChannel, request, options: options);
  }

  $grpc.ResponseFuture<$11.GetNotificationHistoryResponse>
      getNotificationHistory($11.GetNotificationHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationHistory, request,
        options: options);
  }
}

abstract class CrowdfundServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CrowdfundService';

  CrowdfundServiceBase() {
    $addMethod($grpc.ServiceMethod<$11.CreateCrowdfundRequest,
            $11.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.CreateCrowdfundRequest.fromBuffer(value),
        ($11.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$11.GetCrowdfundRequest, $11.GetCrowdfundResponse>(
            'GetCrowdfund',
            getCrowdfund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $11.GetCrowdfundRequest.fromBuffer(value),
            ($11.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.ListCrowdfundsRequest,
            $11.ListCrowdfundsResponse>(
        'ListCrowdfunds',
        listCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.ListCrowdfundsRequest.fromBuffer(value),
        ($11.ListCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.SearchCrowdfundsRequest,
            $11.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.SearchCrowdfundsRequest.fromBuffer(value),
        ($11.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.UpdateCrowdfundRequest,
            $11.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.UpdateCrowdfundRequest.fromBuffer(value),
        ($11.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.DeleteCrowdfundRequest,
            $11.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.DeleteCrowdfundRequest.fromBuffer(value),
        ($11.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$11.MakeDonationRequest, $11.MakeDonationResponse>(
            'MakeDonation',
            makeDonation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $11.MakeDonationRequest.fromBuffer(value),
            ($11.MakeDonationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetCrowdfundDonationsRequest,
            $11.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($11.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetUserDonationsRequest,
            $11.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetUserDonationsRequest.fromBuffer(value),
        ($11.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GenerateDonationReceiptRequest,
            $11.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GenerateDonationReceiptRequest.fromBuffer(value),
        ($11.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetUserCrowdfundReceiptsRequest,
            $11.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($11.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetCrowdfundStatisticsRequest,
            $11.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($11.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.WithdrawFromCrowdfundRequest,
            $11.WithdrawFromCrowdfundResponse>(
        'WithdrawFromCrowdfund',
        withdrawFromCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.WithdrawFromCrowdfundRequest.fromBuffer(value),
        ($11.WithdrawFromCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetMyCrowdfundsRequest,
            $11.GetMyCrowdfundsResponse>(
        'GetMyCrowdfunds',
        getMyCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetMyCrowdfundsRequest.fromBuffer(value),
        ($11.GetMyCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetCampaignWalletBalanceRequest,
            $11.GetCampaignWalletBalanceResponse>(
        'GetCampaignWalletBalance',
        getCampaignWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetCampaignWalletBalanceRequest.fromBuffer(value),
        ($11.GetCampaignWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetCrowdfundLeaderboardRequest,
            $11.GetCrowdfundLeaderboardResponse>(
        'GetCrowdfundLeaderboard',
        getCrowdfundLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetCrowdfundLeaderboardRequest.fromBuffer(value),
        ($11.GetCrowdfundLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.ConnectNotificationChannelRequest,
            $11.ConnectNotificationChannelResponse>(
        'ConnectNotificationChannel',
        connectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.ConnectNotificationChannelRequest.fromBuffer(value),
        ($11.ConnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.DisconnectNotificationChannelRequest,
            $11.DisconnectNotificationChannelResponse>(
        'DisconnectNotificationChannel',
        disconnectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.DisconnectNotificationChannelRequest.fromBuffer(value),
        ($11.DisconnectNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetNotificationChannelsRequest,
            $11.GetNotificationChannelsResponse>(
        'GetNotificationChannels',
        getNotificationChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetNotificationChannelsRequest.fromBuffer(value),
        ($11.GetNotificationChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.UpdateNotificationChannelRequest,
            $11.UpdateNotificationChannelResponse>(
        'UpdateNotificationChannel',
        updateNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.UpdateNotificationChannelRequest.fromBuffer(value),
        ($11.UpdateNotificationChannelResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.TestNotificationChannelRequest,
            $11.TestNotificationChannelResponse>(
        'TestNotificationChannel',
        testNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.TestNotificationChannelRequest.fromBuffer(value),
        ($11.TestNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetTelegramBotInfoRequest,
            $11.GetTelegramBotInfoResponse>(
        'GetTelegramBotInfo',
        getTelegramBotInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetTelegramBotInfoRequest.fromBuffer(value),
        ($11.GetTelegramBotInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.VerifyTelegramChannelRequest,
            $11.VerifyTelegramChannelResponse>(
        'VerifyTelegramChannel',
        verifyTelegramChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.VerifyTelegramChannelRequest.fromBuffer(value),
        ($11.VerifyTelegramChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.GetNotificationHistoryRequest,
            $11.GetNotificationHistoryResponse>(
        'GetNotificationHistory',
        getNotificationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.GetNotificationHistoryRequest.fromBuffer(value),
        ($11.GetNotificationHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$11.CreateCrowdfundResponse> createCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$11.GetCrowdfundResponse> getCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$11.ListCrowdfundsResponse> listCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.ListCrowdfundsRequest> request) async {
    return listCrowdfunds(call, await request);
  }

  $async.Future<$11.SearchCrowdfundsResponse> searchCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$11.UpdateCrowdfundResponse> updateCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$11.DeleteCrowdfundResponse> deleteCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$11.MakeDonationResponse> makeDonation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.MakeDonationRequest> request) async {
    return makeDonation(call, await request);
  }

  $async.Future<$11.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$11.GetUserDonationsResponse> getUserDonations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$11.GenerateDonationReceiptResponse>
      generateDonationReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$11.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$11.GetUserCrowdfundReceiptsResponse>
      getUserCrowdfundReceipts_Pre($grpc.ServiceCall call,
          $async.Future<$11.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$11.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$11.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.WithdrawFromCrowdfundRequest> request) async {
    return withdrawFromCrowdfund(call, await request);
  }

  $async.Future<$11.GetMyCrowdfundsResponse> getMyCrowdfunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetMyCrowdfundsRequest> request) async {
    return getMyCrowdfunds(call, await request);
  }

  $async.Future<$11.GetCampaignWalletBalanceResponse>
      getCampaignWalletBalance_Pre($grpc.ServiceCall call,
          $async.Future<$11.GetCampaignWalletBalanceRequest> request) async {
    return getCampaignWalletBalance(call, await request);
  }

  $async.Future<$11.GetCrowdfundLeaderboardResponse>
      getCrowdfundLeaderboard_Pre($grpc.ServiceCall call,
          $async.Future<$11.GetCrowdfundLeaderboardRequest> request) async {
    return getCrowdfundLeaderboard(call, await request);
  }

  $async.Future<$11.ConnectNotificationChannelResponse>
      connectNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$11.ConnectNotificationChannelRequest> request) async {
    return connectNotificationChannel(call, await request);
  }

  $async.Future<$11.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel_Pre(
          $grpc.ServiceCall call,
          $async.Future<$11.DisconnectNotificationChannelRequest>
              request) async {
    return disconnectNotificationChannel(call, await request);
  }

  $async.Future<$11.GetNotificationChannelsResponse>
      getNotificationChannels_Pre($grpc.ServiceCall call,
          $async.Future<$11.GetNotificationChannelsRequest> request) async {
    return getNotificationChannels(call, await request);
  }

  $async.Future<$11.UpdateNotificationChannelResponse>
      updateNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$11.UpdateNotificationChannelRequest> request) async {
    return updateNotificationChannel(call, await request);
  }

  $async.Future<$11.TestNotificationChannelResponse>
      testNotificationChannel_Pre($grpc.ServiceCall call,
          $async.Future<$11.TestNotificationChannelRequest> request) async {
    return testNotificationChannel(call, await request);
  }

  $async.Future<$11.GetTelegramBotInfoResponse> getTelegramBotInfo_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetTelegramBotInfoRequest> request) async {
    return getTelegramBotInfo(call, await request);
  }

  $async.Future<$11.VerifyTelegramChannelResponse> verifyTelegramChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.VerifyTelegramChannelRequest> request) async {
    return verifyTelegramChannel(call, await request);
  }

  $async.Future<$11.GetNotificationHistoryResponse> getNotificationHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$11.GetNotificationHistoryRequest> request) async {
    return getNotificationHistory(call, await request);
  }

  $async.Future<$11.CreateCrowdfundResponse> createCrowdfund(
      $grpc.ServiceCall call, $11.CreateCrowdfundRequest request);
  $async.Future<$11.GetCrowdfundResponse> getCrowdfund(
      $grpc.ServiceCall call, $11.GetCrowdfundRequest request);
  $async.Future<$11.ListCrowdfundsResponse> listCrowdfunds(
      $grpc.ServiceCall call, $11.ListCrowdfundsRequest request);
  $async.Future<$11.SearchCrowdfundsResponse> searchCrowdfunds(
      $grpc.ServiceCall call, $11.SearchCrowdfundsRequest request);
  $async.Future<$11.UpdateCrowdfundResponse> updateCrowdfund(
      $grpc.ServiceCall call, $11.UpdateCrowdfundRequest request);
  $async.Future<$11.DeleteCrowdfundResponse> deleteCrowdfund(
      $grpc.ServiceCall call, $11.DeleteCrowdfundRequest request);
  $async.Future<$11.MakeDonationResponse> makeDonation(
      $grpc.ServiceCall call, $11.MakeDonationRequest request);
  $async.Future<$11.GetCrowdfundDonationsResponse> getCrowdfundDonations(
      $grpc.ServiceCall call, $11.GetCrowdfundDonationsRequest request);
  $async.Future<$11.GetUserDonationsResponse> getUserDonations(
      $grpc.ServiceCall call, $11.GetUserDonationsRequest request);
  $async.Future<$11.GenerateDonationReceiptResponse> generateDonationReceipt(
      $grpc.ServiceCall call, $11.GenerateDonationReceiptRequest request);
  $async.Future<$11.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts(
      $grpc.ServiceCall call, $11.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$11.GetCrowdfundStatisticsResponse> getCrowdfundStatistics(
      $grpc.ServiceCall call, $11.GetCrowdfundStatisticsRequest request);
  $async.Future<$11.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund(
      $grpc.ServiceCall call, $11.WithdrawFromCrowdfundRequest request);
  $async.Future<$11.GetMyCrowdfundsResponse> getMyCrowdfunds(
      $grpc.ServiceCall call, $11.GetMyCrowdfundsRequest request);
  $async.Future<$11.GetCampaignWalletBalanceResponse> getCampaignWalletBalance(
      $grpc.ServiceCall call, $11.GetCampaignWalletBalanceRequest request);
  $async.Future<$11.GetCrowdfundLeaderboardResponse> getCrowdfundLeaderboard(
      $grpc.ServiceCall call, $11.GetCrowdfundLeaderboardRequest request);
  $async.Future<$11.ConnectNotificationChannelResponse>
      connectNotificationChannel($grpc.ServiceCall call,
          $11.ConnectNotificationChannelRequest request);
  $async.Future<$11.DisconnectNotificationChannelResponse>
      disconnectNotificationChannel($grpc.ServiceCall call,
          $11.DisconnectNotificationChannelRequest request);
  $async.Future<$11.GetNotificationChannelsResponse> getNotificationChannels(
      $grpc.ServiceCall call, $11.GetNotificationChannelsRequest request);
  $async.Future<$11.UpdateNotificationChannelResponse>
      updateNotificationChannel(
          $grpc.ServiceCall call, $11.UpdateNotificationChannelRequest request);
  $async.Future<$11.TestNotificationChannelResponse> testNotificationChannel(
      $grpc.ServiceCall call, $11.TestNotificationChannelRequest request);
  $async.Future<$11.GetTelegramBotInfoResponse> getTelegramBotInfo(
      $grpc.ServiceCall call, $11.GetTelegramBotInfoRequest request);
  $async.Future<$11.VerifyTelegramChannelResponse> verifyTelegramChannel(
      $grpc.ServiceCall call, $11.VerifyTelegramChannelRequest request);
  $async.Future<$11.GetNotificationHistoryResponse> getNotificationHistory(
      $grpc.ServiceCall call, $11.GetNotificationHistoryRequest request);
}
