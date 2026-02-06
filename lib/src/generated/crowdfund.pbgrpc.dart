//
//  Generated code. Do not modify.
//  source: crowdfund.proto
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

import 'crowdfund.pb.dart' as $12;

export 'crowdfund.pb.dart';

@$pb.GrpcServiceName('pb.CrowdfundService')
class CrowdfundServiceClient extends $grpc.Client {
  static final _$createCrowdfund = $grpc.ClientMethod<$12.CreateCrowdfundRequest, $12.CreateCrowdfundResponse>(
      '/pb.CrowdfundService/CreateCrowdfund',
      ($12.CreateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.CreateCrowdfundResponse.fromBuffer(value));
  static final _$getCrowdfund = $grpc.ClientMethod<$12.GetCrowdfundRequest, $12.GetCrowdfundResponse>(
      '/pb.CrowdfundService/GetCrowdfund',
      ($12.GetCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetCrowdfundResponse.fromBuffer(value));
  static final _$listCrowdfunds = $grpc.ClientMethod<$12.ListCrowdfundsRequest, $12.ListCrowdfundsResponse>(
      '/pb.CrowdfundService/ListCrowdfunds',
      ($12.ListCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.ListCrowdfundsResponse.fromBuffer(value));
  static final _$searchCrowdfunds = $grpc.ClientMethod<$12.SearchCrowdfundsRequest, $12.SearchCrowdfundsResponse>(
      '/pb.CrowdfundService/SearchCrowdfunds',
      ($12.SearchCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.SearchCrowdfundsResponse.fromBuffer(value));
  static final _$updateCrowdfund = $grpc.ClientMethod<$12.UpdateCrowdfundRequest, $12.UpdateCrowdfundResponse>(
      '/pb.CrowdfundService/UpdateCrowdfund',
      ($12.UpdateCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.UpdateCrowdfundResponse.fromBuffer(value));
  static final _$deleteCrowdfund = $grpc.ClientMethod<$12.DeleteCrowdfundRequest, $12.DeleteCrowdfundResponse>(
      '/pb.CrowdfundService/DeleteCrowdfund',
      ($12.DeleteCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.DeleteCrowdfundResponse.fromBuffer(value));
  static final _$makeDonation = $grpc.ClientMethod<$12.MakeDonationRequest, $12.MakeDonationResponse>(
      '/pb.CrowdfundService/MakeDonation',
      ($12.MakeDonationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.MakeDonationResponse.fromBuffer(value));
  static final _$getCrowdfundDonations = $grpc.ClientMethod<$12.GetCrowdfundDonationsRequest, $12.GetCrowdfundDonationsResponse>(
      '/pb.CrowdfundService/GetCrowdfundDonations',
      ($12.GetCrowdfundDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetCrowdfundDonationsResponse.fromBuffer(value));
  static final _$getUserDonations = $grpc.ClientMethod<$12.GetUserDonationsRequest, $12.GetUserDonationsResponse>(
      '/pb.CrowdfundService/GetUserDonations',
      ($12.GetUserDonationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetUserDonationsResponse.fromBuffer(value));
  static final _$generateDonationReceipt = $grpc.ClientMethod<$12.GenerateDonationReceiptRequest, $12.GenerateDonationReceiptResponse>(
      '/pb.CrowdfundService/GenerateDonationReceipt',
      ($12.GenerateDonationReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GenerateDonationReceiptResponse.fromBuffer(value));
  static final _$getUserCrowdfundReceipts = $grpc.ClientMethod<$12.GetUserCrowdfundReceiptsRequest, $12.GetUserCrowdfundReceiptsResponse>(
      '/pb.CrowdfundService/GetUserCrowdfundReceipts',
      ($12.GetUserCrowdfundReceiptsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetUserCrowdfundReceiptsResponse.fromBuffer(value));
  static final _$getCrowdfundStatistics = $grpc.ClientMethod<$12.GetCrowdfundStatisticsRequest, $12.GetCrowdfundStatisticsResponse>(
      '/pb.CrowdfundService/GetCrowdfundStatistics',
      ($12.GetCrowdfundStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetCrowdfundStatisticsResponse.fromBuffer(value));
  static final _$withdrawFromCrowdfund = $grpc.ClientMethod<$12.WithdrawFromCrowdfundRequest, $12.WithdrawFromCrowdfundResponse>(
      '/pb.CrowdfundService/WithdrawFromCrowdfund',
      ($12.WithdrawFromCrowdfundRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.WithdrawFromCrowdfundResponse.fromBuffer(value));
  static final _$getMyCrowdfunds = $grpc.ClientMethod<$12.GetMyCrowdfundsRequest, $12.GetMyCrowdfundsResponse>(
      '/pb.CrowdfundService/GetMyCrowdfunds',
      ($12.GetMyCrowdfundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetMyCrowdfundsResponse.fromBuffer(value));
  static final _$getCampaignWalletBalance = $grpc.ClientMethod<$12.GetCampaignWalletBalanceRequest, $12.GetCampaignWalletBalanceResponse>(
      '/pb.CrowdfundService/GetCampaignWalletBalance',
      ($12.GetCampaignWalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetCampaignWalletBalanceResponse.fromBuffer(value));
  static final _$connectNotificationChannel = $grpc.ClientMethod<$12.ConnectNotificationChannelRequest, $12.ConnectNotificationChannelResponse>(
      '/pb.CrowdfundService/ConnectNotificationChannel',
      ($12.ConnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.ConnectNotificationChannelResponse.fromBuffer(value));
  static final _$disconnectNotificationChannel = $grpc.ClientMethod<$12.DisconnectNotificationChannelRequest, $12.DisconnectNotificationChannelResponse>(
      '/pb.CrowdfundService/DisconnectNotificationChannel',
      ($12.DisconnectNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.DisconnectNotificationChannelResponse.fromBuffer(value));
  static final _$getNotificationChannels = $grpc.ClientMethod<$12.GetNotificationChannelsRequest, $12.GetNotificationChannelsResponse>(
      '/pb.CrowdfundService/GetNotificationChannels',
      ($12.GetNotificationChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetNotificationChannelsResponse.fromBuffer(value));
  static final _$updateNotificationChannel = $grpc.ClientMethod<$12.UpdateNotificationChannelRequest, $12.UpdateNotificationChannelResponse>(
      '/pb.CrowdfundService/UpdateNotificationChannel',
      ($12.UpdateNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.UpdateNotificationChannelResponse.fromBuffer(value));
  static final _$testNotificationChannel = $grpc.ClientMethod<$12.TestNotificationChannelRequest, $12.TestNotificationChannelResponse>(
      '/pb.CrowdfundService/TestNotificationChannel',
      ($12.TestNotificationChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.TestNotificationChannelResponse.fromBuffer(value));
  static final _$getTelegramBotInfo = $grpc.ClientMethod<$12.GetTelegramBotInfoRequest, $12.GetTelegramBotInfoResponse>(
      '/pb.CrowdfundService/GetTelegramBotInfo',
      ($12.GetTelegramBotInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetTelegramBotInfoResponse.fromBuffer(value));
  static final _$verifyTelegramChannel = $grpc.ClientMethod<$12.VerifyTelegramChannelRequest, $12.VerifyTelegramChannelResponse>(
      '/pb.CrowdfundService/VerifyTelegramChannel',
      ($12.VerifyTelegramChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.VerifyTelegramChannelResponse.fromBuffer(value));
  static final _$getNotificationHistory = $grpc.ClientMethod<$12.GetNotificationHistoryRequest, $12.GetNotificationHistoryResponse>(
      '/pb.CrowdfundService/GetNotificationHistory',
      ($12.GetNotificationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $12.GetNotificationHistoryResponse.fromBuffer(value));

  CrowdfundServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$12.CreateCrowdfundResponse> createCrowdfund($12.CreateCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCrowdfundResponse> getCrowdfund($12.GetCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$12.ListCrowdfundsResponse> listCrowdfunds($12.ListCrowdfundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$12.SearchCrowdfundsResponse> searchCrowdfunds($12.SearchCrowdfundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateCrowdfundResponse> updateCrowdfund($12.UpdateCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeleteCrowdfundResponse> deleteCrowdfund($12.DeleteCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$12.MakeDonationResponse> makeDonation($12.MakeDonationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$makeDonation, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCrowdfundDonationsResponse> getCrowdfundDonations($12.GetCrowdfundDonationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundDonations, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetUserDonationsResponse> getUserDonations($12.GetUserDonationsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDonations, request, options: options);
  }

  $grpc.ResponseFuture<$12.GenerateDonationReceiptResponse> generateDonationReceipt($12.GenerateDonationReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateDonationReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts($12.GetUserCrowdfundReceiptsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCrowdfundReceipts, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCrowdfundStatisticsResponse> getCrowdfundStatistics($12.GetCrowdfundStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCrowdfundStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$12.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund($12.WithdrawFromCrowdfundRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$withdrawFromCrowdfund, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetMyCrowdfundsResponse> getMyCrowdfunds($12.GetMyCrowdfundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyCrowdfunds, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetCampaignWalletBalanceResponse> getCampaignWalletBalance($12.GetCampaignWalletBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCampaignWalletBalance, request, options: options);
  }

  $grpc.ResponseFuture<$12.ConnectNotificationChannelResponse> connectNotificationChannel($12.ConnectNotificationChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectNotificationChannel, request, options: options);
  }

  $grpc.ResponseFuture<$12.DisconnectNotificationChannelResponse> disconnectNotificationChannel($12.DisconnectNotificationChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectNotificationChannel, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetNotificationChannelsResponse> getNotificationChannels($12.GetNotificationChannelsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationChannels, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateNotificationChannelResponse> updateNotificationChannel($12.UpdateNotificationChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNotificationChannel, request, options: options);
  }

  $grpc.ResponseFuture<$12.TestNotificationChannelResponse> testNotificationChannel($12.TestNotificationChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testNotificationChannel, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetTelegramBotInfoResponse> getTelegramBotInfo($12.GetTelegramBotInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTelegramBotInfo, request, options: options);
  }

  $grpc.ResponseFuture<$12.VerifyTelegramChannelResponse> verifyTelegramChannel($12.VerifyTelegramChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTelegramChannel, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetNotificationHistoryResponse> getNotificationHistory($12.GetNotificationHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNotificationHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.CrowdfundService')
abstract class CrowdfundServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.CrowdfundService';

  CrowdfundServiceBase() {
    $addMethod($grpc.ServiceMethod<$12.CreateCrowdfundRequest, $12.CreateCrowdfundResponse>(
        'CreateCrowdfund',
        createCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.CreateCrowdfundRequest.fromBuffer(value),
        ($12.CreateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCrowdfundRequest, $12.GetCrowdfundResponse>(
        'GetCrowdfund',
        getCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetCrowdfundRequest.fromBuffer(value),
        ($12.GetCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ListCrowdfundsRequest, $12.ListCrowdfundsResponse>(
        'ListCrowdfunds',
        listCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.ListCrowdfundsRequest.fromBuffer(value),
        ($12.ListCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.SearchCrowdfundsRequest, $12.SearchCrowdfundsResponse>(
        'SearchCrowdfunds',
        searchCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.SearchCrowdfundsRequest.fromBuffer(value),
        ($12.SearchCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateCrowdfundRequest, $12.UpdateCrowdfundResponse>(
        'UpdateCrowdfund',
        updateCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.UpdateCrowdfundRequest.fromBuffer(value),
        ($12.UpdateCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DeleteCrowdfundRequest, $12.DeleteCrowdfundResponse>(
        'DeleteCrowdfund',
        deleteCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.DeleteCrowdfundRequest.fromBuffer(value),
        ($12.DeleteCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.MakeDonationRequest, $12.MakeDonationResponse>(
        'MakeDonation',
        makeDonation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.MakeDonationRequest.fromBuffer(value),
        ($12.MakeDonationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCrowdfundDonationsRequest, $12.GetCrowdfundDonationsResponse>(
        'GetCrowdfundDonations',
        getCrowdfundDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetCrowdfundDonationsRequest.fromBuffer(value),
        ($12.GetCrowdfundDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetUserDonationsRequest, $12.GetUserDonationsResponse>(
        'GetUserDonations',
        getUserDonations_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetUserDonationsRequest.fromBuffer(value),
        ($12.GetUserDonationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GenerateDonationReceiptRequest, $12.GenerateDonationReceiptResponse>(
        'GenerateDonationReceipt',
        generateDonationReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GenerateDonationReceiptRequest.fromBuffer(value),
        ($12.GenerateDonationReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetUserCrowdfundReceiptsRequest, $12.GetUserCrowdfundReceiptsResponse>(
        'GetUserCrowdfundReceipts',
        getUserCrowdfundReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetUserCrowdfundReceiptsRequest.fromBuffer(value),
        ($12.GetUserCrowdfundReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCrowdfundStatisticsRequest, $12.GetCrowdfundStatisticsResponse>(
        'GetCrowdfundStatistics',
        getCrowdfundStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetCrowdfundStatisticsRequest.fromBuffer(value),
        ($12.GetCrowdfundStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.WithdrawFromCrowdfundRequest, $12.WithdrawFromCrowdfundResponse>(
        'WithdrawFromCrowdfund',
        withdrawFromCrowdfund_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.WithdrawFromCrowdfundRequest.fromBuffer(value),
        ($12.WithdrawFromCrowdfundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetMyCrowdfundsRequest, $12.GetMyCrowdfundsResponse>(
        'GetMyCrowdfunds',
        getMyCrowdfunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetMyCrowdfundsRequest.fromBuffer(value),
        ($12.GetMyCrowdfundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetCampaignWalletBalanceRequest, $12.GetCampaignWalletBalanceResponse>(
        'GetCampaignWalletBalance',
        getCampaignWalletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetCampaignWalletBalanceRequest.fromBuffer(value),
        ($12.GetCampaignWalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ConnectNotificationChannelRequest, $12.ConnectNotificationChannelResponse>(
        'ConnectNotificationChannel',
        connectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.ConnectNotificationChannelRequest.fromBuffer(value),
        ($12.ConnectNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DisconnectNotificationChannelRequest, $12.DisconnectNotificationChannelResponse>(
        'DisconnectNotificationChannel',
        disconnectNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.DisconnectNotificationChannelRequest.fromBuffer(value),
        ($12.DisconnectNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetNotificationChannelsRequest, $12.GetNotificationChannelsResponse>(
        'GetNotificationChannels',
        getNotificationChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetNotificationChannelsRequest.fromBuffer(value),
        ($12.GetNotificationChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateNotificationChannelRequest, $12.UpdateNotificationChannelResponse>(
        'UpdateNotificationChannel',
        updateNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.UpdateNotificationChannelRequest.fromBuffer(value),
        ($12.UpdateNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.TestNotificationChannelRequest, $12.TestNotificationChannelResponse>(
        'TestNotificationChannel',
        testNotificationChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.TestNotificationChannelRequest.fromBuffer(value),
        ($12.TestNotificationChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetTelegramBotInfoRequest, $12.GetTelegramBotInfoResponse>(
        'GetTelegramBotInfo',
        getTelegramBotInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetTelegramBotInfoRequest.fromBuffer(value),
        ($12.GetTelegramBotInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.VerifyTelegramChannelRequest, $12.VerifyTelegramChannelResponse>(
        'VerifyTelegramChannel',
        verifyTelegramChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.VerifyTelegramChannelRequest.fromBuffer(value),
        ($12.VerifyTelegramChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetNotificationHistoryRequest, $12.GetNotificationHistoryResponse>(
        'GetNotificationHistory',
        getNotificationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $12.GetNotificationHistoryRequest.fromBuffer(value),
        ($12.GetNotificationHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$12.CreateCrowdfundResponse> createCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$12.CreateCrowdfundRequest> request) async {
    return createCrowdfund(call, await request);
  }

  $async.Future<$12.GetCrowdfundResponse> getCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$12.GetCrowdfundRequest> request) async {
    return getCrowdfund(call, await request);
  }

  $async.Future<$12.ListCrowdfundsResponse> listCrowdfunds_Pre($grpc.ServiceCall call, $async.Future<$12.ListCrowdfundsRequest> request) async {
    return listCrowdfunds(call, await request);
  }

  $async.Future<$12.SearchCrowdfundsResponse> searchCrowdfunds_Pre($grpc.ServiceCall call, $async.Future<$12.SearchCrowdfundsRequest> request) async {
    return searchCrowdfunds(call, await request);
  }

  $async.Future<$12.UpdateCrowdfundResponse> updateCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$12.UpdateCrowdfundRequest> request) async {
    return updateCrowdfund(call, await request);
  }

  $async.Future<$12.DeleteCrowdfundResponse> deleteCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$12.DeleteCrowdfundRequest> request) async {
    return deleteCrowdfund(call, await request);
  }

  $async.Future<$12.MakeDonationResponse> makeDonation_Pre($grpc.ServiceCall call, $async.Future<$12.MakeDonationRequest> request) async {
    return makeDonation(call, await request);
  }

  $async.Future<$12.GetCrowdfundDonationsResponse> getCrowdfundDonations_Pre($grpc.ServiceCall call, $async.Future<$12.GetCrowdfundDonationsRequest> request) async {
    return getCrowdfundDonations(call, await request);
  }

  $async.Future<$12.GetUserDonationsResponse> getUserDonations_Pre($grpc.ServiceCall call, $async.Future<$12.GetUserDonationsRequest> request) async {
    return getUserDonations(call, await request);
  }

  $async.Future<$12.GenerateDonationReceiptResponse> generateDonationReceipt_Pre($grpc.ServiceCall call, $async.Future<$12.GenerateDonationReceiptRequest> request) async {
    return generateDonationReceipt(call, await request);
  }

  $async.Future<$12.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts_Pre($grpc.ServiceCall call, $async.Future<$12.GetUserCrowdfundReceiptsRequest> request) async {
    return getUserCrowdfundReceipts(call, await request);
  }

  $async.Future<$12.GetCrowdfundStatisticsResponse> getCrowdfundStatistics_Pre($grpc.ServiceCall call, $async.Future<$12.GetCrowdfundStatisticsRequest> request) async {
    return getCrowdfundStatistics(call, await request);
  }

  $async.Future<$12.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund_Pre($grpc.ServiceCall call, $async.Future<$12.WithdrawFromCrowdfundRequest> request) async {
    return withdrawFromCrowdfund(call, await request);
  }

  $async.Future<$12.GetMyCrowdfundsResponse> getMyCrowdfunds_Pre($grpc.ServiceCall call, $async.Future<$12.GetMyCrowdfundsRequest> request) async {
    return getMyCrowdfunds(call, await request);
  }

  $async.Future<$12.GetCampaignWalletBalanceResponse> getCampaignWalletBalance_Pre($grpc.ServiceCall call, $async.Future<$12.GetCampaignWalletBalanceRequest> request) async {
    return getCampaignWalletBalance(call, await request);
  }

  $async.Future<$12.ConnectNotificationChannelResponse> connectNotificationChannel_Pre($grpc.ServiceCall call, $async.Future<$12.ConnectNotificationChannelRequest> request) async {
    return connectNotificationChannel(call, await request);
  }

  $async.Future<$12.DisconnectNotificationChannelResponse> disconnectNotificationChannel_Pre($grpc.ServiceCall call, $async.Future<$12.DisconnectNotificationChannelRequest> request) async {
    return disconnectNotificationChannel(call, await request);
  }

  $async.Future<$12.GetNotificationChannelsResponse> getNotificationChannels_Pre($grpc.ServiceCall call, $async.Future<$12.GetNotificationChannelsRequest> request) async {
    return getNotificationChannels(call, await request);
  }

  $async.Future<$12.UpdateNotificationChannelResponse> updateNotificationChannel_Pre($grpc.ServiceCall call, $async.Future<$12.UpdateNotificationChannelRequest> request) async {
    return updateNotificationChannel(call, await request);
  }

  $async.Future<$12.TestNotificationChannelResponse> testNotificationChannel_Pre($grpc.ServiceCall call, $async.Future<$12.TestNotificationChannelRequest> request) async {
    return testNotificationChannel(call, await request);
  }

  $async.Future<$12.GetTelegramBotInfoResponse> getTelegramBotInfo_Pre($grpc.ServiceCall call, $async.Future<$12.GetTelegramBotInfoRequest> request) async {
    return getTelegramBotInfo(call, await request);
  }

  $async.Future<$12.VerifyTelegramChannelResponse> verifyTelegramChannel_Pre($grpc.ServiceCall call, $async.Future<$12.VerifyTelegramChannelRequest> request) async {
    return verifyTelegramChannel(call, await request);
  }

  $async.Future<$12.GetNotificationHistoryResponse> getNotificationHistory_Pre($grpc.ServiceCall call, $async.Future<$12.GetNotificationHistoryRequest> request) async {
    return getNotificationHistory(call, await request);
  }

  $async.Future<$12.CreateCrowdfundResponse> createCrowdfund($grpc.ServiceCall call, $12.CreateCrowdfundRequest request);
  $async.Future<$12.GetCrowdfundResponse> getCrowdfund($grpc.ServiceCall call, $12.GetCrowdfundRequest request);
  $async.Future<$12.ListCrowdfundsResponse> listCrowdfunds($grpc.ServiceCall call, $12.ListCrowdfundsRequest request);
  $async.Future<$12.SearchCrowdfundsResponse> searchCrowdfunds($grpc.ServiceCall call, $12.SearchCrowdfundsRequest request);
  $async.Future<$12.UpdateCrowdfundResponse> updateCrowdfund($grpc.ServiceCall call, $12.UpdateCrowdfundRequest request);
  $async.Future<$12.DeleteCrowdfundResponse> deleteCrowdfund($grpc.ServiceCall call, $12.DeleteCrowdfundRequest request);
  $async.Future<$12.MakeDonationResponse> makeDonation($grpc.ServiceCall call, $12.MakeDonationRequest request);
  $async.Future<$12.GetCrowdfundDonationsResponse> getCrowdfundDonations($grpc.ServiceCall call, $12.GetCrowdfundDonationsRequest request);
  $async.Future<$12.GetUserDonationsResponse> getUserDonations($grpc.ServiceCall call, $12.GetUserDonationsRequest request);
  $async.Future<$12.GenerateDonationReceiptResponse> generateDonationReceipt($grpc.ServiceCall call, $12.GenerateDonationReceiptRequest request);
  $async.Future<$12.GetUserCrowdfundReceiptsResponse> getUserCrowdfundReceipts($grpc.ServiceCall call, $12.GetUserCrowdfundReceiptsRequest request);
  $async.Future<$12.GetCrowdfundStatisticsResponse> getCrowdfundStatistics($grpc.ServiceCall call, $12.GetCrowdfundStatisticsRequest request);
  $async.Future<$12.WithdrawFromCrowdfundResponse> withdrawFromCrowdfund($grpc.ServiceCall call, $12.WithdrawFromCrowdfundRequest request);
  $async.Future<$12.GetMyCrowdfundsResponse> getMyCrowdfunds($grpc.ServiceCall call, $12.GetMyCrowdfundsRequest request);
  $async.Future<$12.GetCampaignWalletBalanceResponse> getCampaignWalletBalance($grpc.ServiceCall call, $12.GetCampaignWalletBalanceRequest request);
  $async.Future<$12.ConnectNotificationChannelResponse> connectNotificationChannel($grpc.ServiceCall call, $12.ConnectNotificationChannelRequest request);
  $async.Future<$12.DisconnectNotificationChannelResponse> disconnectNotificationChannel($grpc.ServiceCall call, $12.DisconnectNotificationChannelRequest request);
  $async.Future<$12.GetNotificationChannelsResponse> getNotificationChannels($grpc.ServiceCall call, $12.GetNotificationChannelsRequest request);
  $async.Future<$12.UpdateNotificationChannelResponse> updateNotificationChannel($grpc.ServiceCall call, $12.UpdateNotificationChannelRequest request);
  $async.Future<$12.TestNotificationChannelResponse> testNotificationChannel($grpc.ServiceCall call, $12.TestNotificationChannelRequest request);
  $async.Future<$12.GetTelegramBotInfoResponse> getTelegramBotInfo($grpc.ServiceCall call, $12.GetTelegramBotInfoRequest request);
  $async.Future<$12.VerifyTelegramChannelResponse> verifyTelegramChannel($grpc.ServiceCall call, $12.VerifyTelegramChannelRequest request);
  $async.Future<$12.GetNotificationHistoryResponse> getNotificationHistory($grpc.ServiceCall call, $12.GetNotificationHistoryRequest request);
}
