///
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'referral.pb.dart' as $33;
export 'referral.pb.dart';

class ReferralServiceClient extends $grpc.Client {
  static final _$validateReferralCode = $grpc.ClientMethod<
          $33.ValidateReferralCodeRequest, $33.ValidateReferralCodeResponse>(
      '/pb.ReferralService/ValidateReferralCode',
      ($33.ValidateReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.ValidateReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralCode = $grpc.ClientMethod<
          $33.GetMyReferralCodeRequest, $33.GetMyReferralCodeResponse>(
      '/pb.ReferralService/GetMyReferralCode',
      ($33.GetMyReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetMyReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralStats = $grpc.ClientMethod<
          $33.GetMyReferralStatsRequest, $33.GetMyReferralStatsResponse>(
      '/pb.ReferralService/GetMyReferralStats',
      ($33.GetMyReferralStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetMyReferralStatsResponse.fromBuffer(value));
  static final _$getMyReferrals =
      $grpc.ClientMethod<$33.GetMyReferralsRequest, $33.GetMyReferralsResponse>(
          '/pb.ReferralService/GetMyReferrals',
          ($33.GetMyReferralsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.GetMyReferralsResponse.fromBuffer(value));
  static final _$getReferralLeaderboard = $grpc.ClientMethod<
          $33.GetReferralLeaderboardRequest,
          $33.GetReferralLeaderboardResponse>(
      '/pb.ReferralService/GetReferralLeaderboard',
      ($33.GetReferralLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetReferralLeaderboardResponse.fromBuffer(value));
  static final _$getCountryRewardConfig = $grpc.ClientMethod<
          $33.GetCountryRewardConfigRequest,
          $33.GetCountryRewardConfigResponse>(
      '/pb.ReferralService/GetCountryRewardConfig',
      ($33.GetCountryRewardConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetCountryRewardConfigResponse.fromBuffer(value));
  static final _$recordReferral =
      $grpc.ClientMethod<$33.RecordReferralRequest, $33.RecordReferralResponse>(
          '/pb.ReferralService/RecordReferral',
          ($33.RecordReferralRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $33.RecordReferralResponse.fromBuffer(value));
  static final _$creditReferralRewards = $grpc.ClientMethod<
          $33.CreditReferralRewardsRequest, $33.CreditReferralRewardsResponse>(
      '/pb.ReferralService/CreditReferralRewards',
      ($33.CreditReferralRewardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.CreditReferralRewardsResponse.fromBuffer(value));
  static final _$getMyPointsBalance = $grpc.ClientMethod<
          $33.GetMyPointsBalanceRequest, $33.GetMyPointsBalanceResponse>(
      '/pb.ReferralService/GetMyPointsBalance',
      ($33.GetMyPointsBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetMyPointsBalanceResponse.fromBuffer(value));
  static final _$getMyPointsHistory = $grpc.ClientMethod<
          $33.GetMyPointsHistoryRequest, $33.GetMyPointsHistoryResponse>(
      '/pb.ReferralService/GetMyPointsHistory',
      ($33.GetMyPointsHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetMyPointsHistoryResponse.fromBuffer(value));
  static final _$getPointsConfig = $grpc.ClientMethod<
          $33.GetPointsConfigRequest, $33.GetPointsConfigResponse>(
      '/pb.ReferralService/GetPointsConfig',
      ($33.GetPointsConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $33.GetPointsConfigResponse.fromBuffer(value));

  ReferralServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$33.ValidateReferralCodeResponse> validateReferralCode(
      $33.ValidateReferralCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetMyReferralCodeResponse> getMyReferralCode(
      $33.GetMyReferralCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetMyReferralStatsResponse> getMyReferralStats(
      $33.GetMyReferralStatsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralStats, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetMyReferralsResponse> getMyReferrals(
      $33.GetMyReferralsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferrals, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetReferralLeaderboardResponse>
      getReferralLeaderboard($33.GetReferralLeaderboardRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReferralLeaderboard, request,
        options: options);
  }

  $grpc.ResponseFuture<$33.GetCountryRewardConfigResponse>
      getCountryRewardConfig($33.GetCountryRewardConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRewardConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$33.RecordReferralResponse> recordReferral(
      $33.RecordReferralRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recordReferral, request, options: options);
  }

  $grpc.ResponseFuture<$33.CreditReferralRewardsResponse> creditReferralRewards(
      $33.CreditReferralRewardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$creditReferralRewards, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetMyPointsBalanceResponse> getMyPointsBalance(
      $33.GetMyPointsBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyPointsBalance, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetMyPointsHistoryResponse> getMyPointsHistory(
      $33.GetMyPointsHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyPointsHistory, request, options: options);
  }

  $grpc.ResponseFuture<$33.GetPointsConfigResponse> getPointsConfig(
      $33.GetPointsConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPointsConfig, request, options: options);
  }
}

abstract class ReferralServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ReferralService';

  ReferralServiceBase() {
    $addMethod($grpc.ServiceMethod<$33.ValidateReferralCodeRequest,
            $33.ValidateReferralCodeResponse>(
        'ValidateReferralCode',
        validateReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.ValidateReferralCodeRequest.fromBuffer(value),
        ($33.ValidateReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetMyReferralCodeRequest,
            $33.GetMyReferralCodeResponse>(
        'GetMyReferralCode',
        getMyReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetMyReferralCodeRequest.fromBuffer(value),
        ($33.GetMyReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetMyReferralStatsRequest,
            $33.GetMyReferralStatsResponse>(
        'GetMyReferralStats',
        getMyReferralStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetMyReferralStatsRequest.fromBuffer(value),
        ($33.GetMyReferralStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetMyReferralsRequest,
            $33.GetMyReferralsResponse>(
        'GetMyReferrals',
        getMyReferrals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetMyReferralsRequest.fromBuffer(value),
        ($33.GetMyReferralsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetReferralLeaderboardRequest,
            $33.GetReferralLeaderboardResponse>(
        'GetReferralLeaderboard',
        getReferralLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetReferralLeaderboardRequest.fromBuffer(value),
        ($33.GetReferralLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetCountryRewardConfigRequest,
            $33.GetCountryRewardConfigResponse>(
        'GetCountryRewardConfig',
        getCountryRewardConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetCountryRewardConfigRequest.fromBuffer(value),
        ($33.GetCountryRewardConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.RecordReferralRequest,
            $33.RecordReferralResponse>(
        'RecordReferral',
        recordReferral_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.RecordReferralRequest.fromBuffer(value),
        ($33.RecordReferralResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.CreditReferralRewardsRequest,
            $33.CreditReferralRewardsResponse>(
        'CreditReferralRewards',
        creditReferralRewards_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.CreditReferralRewardsRequest.fromBuffer(value),
        ($33.CreditReferralRewardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetMyPointsBalanceRequest,
            $33.GetMyPointsBalanceResponse>(
        'GetMyPointsBalance',
        getMyPointsBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetMyPointsBalanceRequest.fromBuffer(value),
        ($33.GetMyPointsBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetMyPointsHistoryRequest,
            $33.GetMyPointsHistoryResponse>(
        'GetMyPointsHistory',
        getMyPointsHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetMyPointsHistoryRequest.fromBuffer(value),
        ($33.GetMyPointsHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$33.GetPointsConfigRequest,
            $33.GetPointsConfigResponse>(
        'GetPointsConfig',
        getPointsConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $33.GetPointsConfigRequest.fromBuffer(value),
        ($33.GetPointsConfigResponse value) => value.writeToBuffer()));
  }

  $async.Future<$33.ValidateReferralCodeResponse> validateReferralCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.ValidateReferralCodeRequest> request) async {
    return validateReferralCode(call, await request);
  }

  $async.Future<$33.GetMyReferralCodeResponse> getMyReferralCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetMyReferralCodeRequest> request) async {
    return getMyReferralCode(call, await request);
  }

  $async.Future<$33.GetMyReferralStatsResponse> getMyReferralStats_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetMyReferralStatsRequest> request) async {
    return getMyReferralStats(call, await request);
  }

  $async.Future<$33.GetMyReferralsResponse> getMyReferrals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetMyReferralsRequest> request) async {
    return getMyReferrals(call, await request);
  }

  $async.Future<$33.GetReferralLeaderboardResponse> getReferralLeaderboard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetReferralLeaderboardRequest> request) async {
    return getReferralLeaderboard(call, await request);
  }

  $async.Future<$33.GetCountryRewardConfigResponse> getCountryRewardConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetCountryRewardConfigRequest> request) async {
    return getCountryRewardConfig(call, await request);
  }

  $async.Future<$33.RecordReferralResponse> recordReferral_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.RecordReferralRequest> request) async {
    return recordReferral(call, await request);
  }

  $async.Future<$33.CreditReferralRewardsResponse> creditReferralRewards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.CreditReferralRewardsRequest> request) async {
    return creditReferralRewards(call, await request);
  }

  $async.Future<$33.GetMyPointsBalanceResponse> getMyPointsBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetMyPointsBalanceRequest> request) async {
    return getMyPointsBalance(call, await request);
  }

  $async.Future<$33.GetMyPointsHistoryResponse> getMyPointsHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetMyPointsHistoryRequest> request) async {
    return getMyPointsHistory(call, await request);
  }

  $async.Future<$33.GetPointsConfigResponse> getPointsConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$33.GetPointsConfigRequest> request) async {
    return getPointsConfig(call, await request);
  }

  $async.Future<$33.ValidateReferralCodeResponse> validateReferralCode(
      $grpc.ServiceCall call, $33.ValidateReferralCodeRequest request);
  $async.Future<$33.GetMyReferralCodeResponse> getMyReferralCode(
      $grpc.ServiceCall call, $33.GetMyReferralCodeRequest request);
  $async.Future<$33.GetMyReferralStatsResponse> getMyReferralStats(
      $grpc.ServiceCall call, $33.GetMyReferralStatsRequest request);
  $async.Future<$33.GetMyReferralsResponse> getMyReferrals(
      $grpc.ServiceCall call, $33.GetMyReferralsRequest request);
  $async.Future<$33.GetReferralLeaderboardResponse> getReferralLeaderboard(
      $grpc.ServiceCall call, $33.GetReferralLeaderboardRequest request);
  $async.Future<$33.GetCountryRewardConfigResponse> getCountryRewardConfig(
      $grpc.ServiceCall call, $33.GetCountryRewardConfigRequest request);
  $async.Future<$33.RecordReferralResponse> recordReferral(
      $grpc.ServiceCall call, $33.RecordReferralRequest request);
  $async.Future<$33.CreditReferralRewardsResponse> creditReferralRewards(
      $grpc.ServiceCall call, $33.CreditReferralRewardsRequest request);
  $async.Future<$33.GetMyPointsBalanceResponse> getMyPointsBalance(
      $grpc.ServiceCall call, $33.GetMyPointsBalanceRequest request);
  $async.Future<$33.GetMyPointsHistoryResponse> getMyPointsHistory(
      $grpc.ServiceCall call, $33.GetMyPointsHistoryRequest request);
  $async.Future<$33.GetPointsConfigResponse> getPointsConfig(
      $grpc.ServiceCall call, $33.GetPointsConfigRequest request);
}
