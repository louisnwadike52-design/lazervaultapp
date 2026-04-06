///
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'referral.pb.dart' as $32;
export 'referral.pb.dart';

class ReferralServiceClient extends $grpc.Client {
  static final _$validateReferralCode = $grpc.ClientMethod<
          $32.ValidateReferralCodeRequest, $32.ValidateReferralCodeResponse>(
      '/pb.ReferralService/ValidateReferralCode',
      ($32.ValidateReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.ValidateReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralCode = $grpc.ClientMethod<
          $32.GetMyReferralCodeRequest, $32.GetMyReferralCodeResponse>(
      '/pb.ReferralService/GetMyReferralCode',
      ($32.GetMyReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.GetMyReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralStats = $grpc.ClientMethod<
          $32.GetMyReferralStatsRequest, $32.GetMyReferralStatsResponse>(
      '/pb.ReferralService/GetMyReferralStats',
      ($32.GetMyReferralStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.GetMyReferralStatsResponse.fromBuffer(value));
  static final _$getMyReferrals =
      $grpc.ClientMethod<$32.GetMyReferralsRequest, $32.GetMyReferralsResponse>(
          '/pb.ReferralService/GetMyReferrals',
          ($32.GetMyReferralsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $32.GetMyReferralsResponse.fromBuffer(value));
  static final _$getReferralLeaderboard = $grpc.ClientMethod<
          $32.GetReferralLeaderboardRequest,
          $32.GetReferralLeaderboardResponse>(
      '/pb.ReferralService/GetReferralLeaderboard',
      ($32.GetReferralLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.GetReferralLeaderboardResponse.fromBuffer(value));
  static final _$getCountryRewardConfig = $grpc.ClientMethod<
          $32.GetCountryRewardConfigRequest,
          $32.GetCountryRewardConfigResponse>(
      '/pb.ReferralService/GetCountryRewardConfig',
      ($32.GetCountryRewardConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.GetCountryRewardConfigResponse.fromBuffer(value));
  static final _$recordReferral =
      $grpc.ClientMethod<$32.RecordReferralRequest, $32.RecordReferralResponse>(
          '/pb.ReferralService/RecordReferral',
          ($32.RecordReferralRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $32.RecordReferralResponse.fromBuffer(value));
  static final _$creditReferralRewards = $grpc.ClientMethod<
          $32.CreditReferralRewardsRequest, $32.CreditReferralRewardsResponse>(
      '/pb.ReferralService/CreditReferralRewards',
      ($32.CreditReferralRewardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.CreditReferralRewardsResponse.fromBuffer(value));
  static final _$getMyPointsBalance = $grpc.ClientMethod<
          $32.GetMyPointsBalanceRequest, $32.GetMyPointsBalanceResponse>(
      '/pb.ReferralService/GetMyPointsBalance',
      ($32.GetMyPointsBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.GetMyPointsBalanceResponse.fromBuffer(value));
  static final _$getMyPointsHistory = $grpc.ClientMethod<
          $32.GetMyPointsHistoryRequest, $32.GetMyPointsHistoryResponse>(
      '/pb.ReferralService/GetMyPointsHistory',
      ($32.GetMyPointsHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.GetMyPointsHistoryResponse.fromBuffer(value));
  static final _$getPointsConfig = $grpc.ClientMethod<
          $32.GetPointsConfigRequest, $32.GetPointsConfigResponse>(
      '/pb.ReferralService/GetPointsConfig',
      ($32.GetPointsConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $32.GetPointsConfigResponse.fromBuffer(value));

  ReferralServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$32.ValidateReferralCodeResponse> validateReferralCode(
      $32.ValidateReferralCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetMyReferralCodeResponse> getMyReferralCode(
      $32.GetMyReferralCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetMyReferralStatsResponse> getMyReferralStats(
      $32.GetMyReferralStatsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralStats, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetMyReferralsResponse> getMyReferrals(
      $32.GetMyReferralsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferrals, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetReferralLeaderboardResponse>
      getReferralLeaderboard($32.GetReferralLeaderboardRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReferralLeaderboard, request,
        options: options);
  }

  $grpc.ResponseFuture<$32.GetCountryRewardConfigResponse>
      getCountryRewardConfig($32.GetCountryRewardConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRewardConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$32.RecordReferralResponse> recordReferral(
      $32.RecordReferralRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recordReferral, request, options: options);
  }

  $grpc.ResponseFuture<$32.CreditReferralRewardsResponse> creditReferralRewards(
      $32.CreditReferralRewardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$creditReferralRewards, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetMyPointsBalanceResponse> getMyPointsBalance(
      $32.GetMyPointsBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyPointsBalance, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetMyPointsHistoryResponse> getMyPointsHistory(
      $32.GetMyPointsHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyPointsHistory, request, options: options);
  }

  $grpc.ResponseFuture<$32.GetPointsConfigResponse> getPointsConfig(
      $32.GetPointsConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPointsConfig, request, options: options);
  }
}

abstract class ReferralServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ReferralService';

  ReferralServiceBase() {
    $addMethod($grpc.ServiceMethod<$32.ValidateReferralCodeRequest,
            $32.ValidateReferralCodeResponse>(
        'ValidateReferralCode',
        validateReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.ValidateReferralCodeRequest.fromBuffer(value),
        ($32.ValidateReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetMyReferralCodeRequest,
            $32.GetMyReferralCodeResponse>(
        'GetMyReferralCode',
        getMyReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetMyReferralCodeRequest.fromBuffer(value),
        ($32.GetMyReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetMyReferralStatsRequest,
            $32.GetMyReferralStatsResponse>(
        'GetMyReferralStats',
        getMyReferralStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetMyReferralStatsRequest.fromBuffer(value),
        ($32.GetMyReferralStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetMyReferralsRequest,
            $32.GetMyReferralsResponse>(
        'GetMyReferrals',
        getMyReferrals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetMyReferralsRequest.fromBuffer(value),
        ($32.GetMyReferralsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetReferralLeaderboardRequest,
            $32.GetReferralLeaderboardResponse>(
        'GetReferralLeaderboard',
        getReferralLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetReferralLeaderboardRequest.fromBuffer(value),
        ($32.GetReferralLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetCountryRewardConfigRequest,
            $32.GetCountryRewardConfigResponse>(
        'GetCountryRewardConfig',
        getCountryRewardConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetCountryRewardConfigRequest.fromBuffer(value),
        ($32.GetCountryRewardConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.RecordReferralRequest,
            $32.RecordReferralResponse>(
        'RecordReferral',
        recordReferral_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.RecordReferralRequest.fromBuffer(value),
        ($32.RecordReferralResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.CreditReferralRewardsRequest,
            $32.CreditReferralRewardsResponse>(
        'CreditReferralRewards',
        creditReferralRewards_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.CreditReferralRewardsRequest.fromBuffer(value),
        ($32.CreditReferralRewardsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetMyPointsBalanceRequest,
            $32.GetMyPointsBalanceResponse>(
        'GetMyPointsBalance',
        getMyPointsBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetMyPointsBalanceRequest.fromBuffer(value),
        ($32.GetMyPointsBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetMyPointsHistoryRequest,
            $32.GetMyPointsHistoryResponse>(
        'GetMyPointsHistory',
        getMyPointsHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetMyPointsHistoryRequest.fromBuffer(value),
        ($32.GetMyPointsHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$32.GetPointsConfigRequest,
            $32.GetPointsConfigResponse>(
        'GetPointsConfig',
        getPointsConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $32.GetPointsConfigRequest.fromBuffer(value),
        ($32.GetPointsConfigResponse value) => value.writeToBuffer()));
  }

  $async.Future<$32.ValidateReferralCodeResponse> validateReferralCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.ValidateReferralCodeRequest> request) async {
    return validateReferralCode(call, await request);
  }

  $async.Future<$32.GetMyReferralCodeResponse> getMyReferralCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetMyReferralCodeRequest> request) async {
    return getMyReferralCode(call, await request);
  }

  $async.Future<$32.GetMyReferralStatsResponse> getMyReferralStats_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetMyReferralStatsRequest> request) async {
    return getMyReferralStats(call, await request);
  }

  $async.Future<$32.GetMyReferralsResponse> getMyReferrals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetMyReferralsRequest> request) async {
    return getMyReferrals(call, await request);
  }

  $async.Future<$32.GetReferralLeaderboardResponse> getReferralLeaderboard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetReferralLeaderboardRequest> request) async {
    return getReferralLeaderboard(call, await request);
  }

  $async.Future<$32.GetCountryRewardConfigResponse> getCountryRewardConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetCountryRewardConfigRequest> request) async {
    return getCountryRewardConfig(call, await request);
  }

  $async.Future<$32.RecordReferralResponse> recordReferral_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.RecordReferralRequest> request) async {
    return recordReferral(call, await request);
  }

  $async.Future<$32.CreditReferralRewardsResponse> creditReferralRewards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.CreditReferralRewardsRequest> request) async {
    return creditReferralRewards(call, await request);
  }

  $async.Future<$32.GetMyPointsBalanceResponse> getMyPointsBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetMyPointsBalanceRequest> request) async {
    return getMyPointsBalance(call, await request);
  }

  $async.Future<$32.GetMyPointsHistoryResponse> getMyPointsHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetMyPointsHistoryRequest> request) async {
    return getMyPointsHistory(call, await request);
  }

  $async.Future<$32.GetPointsConfigResponse> getPointsConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$32.GetPointsConfigRequest> request) async {
    return getPointsConfig(call, await request);
  }

  $async.Future<$32.ValidateReferralCodeResponse> validateReferralCode(
      $grpc.ServiceCall call, $32.ValidateReferralCodeRequest request);
  $async.Future<$32.GetMyReferralCodeResponse> getMyReferralCode(
      $grpc.ServiceCall call, $32.GetMyReferralCodeRequest request);
  $async.Future<$32.GetMyReferralStatsResponse> getMyReferralStats(
      $grpc.ServiceCall call, $32.GetMyReferralStatsRequest request);
  $async.Future<$32.GetMyReferralsResponse> getMyReferrals(
      $grpc.ServiceCall call, $32.GetMyReferralsRequest request);
  $async.Future<$32.GetReferralLeaderboardResponse> getReferralLeaderboard(
      $grpc.ServiceCall call, $32.GetReferralLeaderboardRequest request);
  $async.Future<$32.GetCountryRewardConfigResponse> getCountryRewardConfig(
      $grpc.ServiceCall call, $32.GetCountryRewardConfigRequest request);
  $async.Future<$32.RecordReferralResponse> recordReferral(
      $grpc.ServiceCall call, $32.RecordReferralRequest request);
  $async.Future<$32.CreditReferralRewardsResponse> creditReferralRewards(
      $grpc.ServiceCall call, $32.CreditReferralRewardsRequest request);
  $async.Future<$32.GetMyPointsBalanceResponse> getMyPointsBalance(
      $grpc.ServiceCall call, $32.GetMyPointsBalanceRequest request);
  $async.Future<$32.GetMyPointsHistoryResponse> getMyPointsHistory(
      $grpc.ServiceCall call, $32.GetMyPointsHistoryRequest request);
  $async.Future<$32.GetPointsConfigResponse> getPointsConfig(
      $grpc.ServiceCall call, $32.GetPointsConfigRequest request);
}
