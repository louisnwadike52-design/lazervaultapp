///
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'referral.pb.dart' as $23;
export 'referral.pb.dart';

class ReferralServiceClient extends $grpc.Client {
  static final _$validateReferralCode = $grpc.ClientMethod<
          $23.ValidateReferralCodeRequest, $23.ValidateReferralCodeResponse>(
      '/pb.ReferralService/ValidateReferralCode',
      ($23.ValidateReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.ValidateReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralCode = $grpc.ClientMethod<
          $23.GetMyReferralCodeRequest, $23.GetMyReferralCodeResponse>(
      '/pb.ReferralService/GetMyReferralCode',
      ($23.GetMyReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralStats = $grpc.ClientMethod<
          $23.GetMyReferralStatsRequest, $23.GetMyReferralStatsResponse>(
      '/pb.ReferralService/GetMyReferralStats',
      ($23.GetMyReferralStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyReferralStatsResponse.fromBuffer(value));
  static final _$getMyReferrals =
      $grpc.ClientMethod<$23.GetMyReferralsRequest, $23.GetMyReferralsResponse>(
          '/pb.ReferralService/GetMyReferrals',
          ($23.GetMyReferralsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetMyReferralsResponse.fromBuffer(value));
  static final _$getReferralLeaderboard = $grpc.ClientMethod<
          $23.GetReferralLeaderboardRequest,
          $23.GetReferralLeaderboardResponse>(
      '/pb.ReferralService/GetReferralLeaderboard',
      ($23.GetReferralLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetReferralLeaderboardResponse.fromBuffer(value));
  static final _$getCountryRewardConfig = $grpc.ClientMethod<
          $23.GetCountryRewardConfigRequest,
          $23.GetCountryRewardConfigResponse>(
      '/pb.ReferralService/GetCountryRewardConfig',
      ($23.GetCountryRewardConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetCountryRewardConfigResponse.fromBuffer(value));
  static final _$recordReferral =
      $grpc.ClientMethod<$23.RecordReferralRequest, $23.RecordReferralResponse>(
          '/pb.ReferralService/RecordReferral',
          ($23.RecordReferralRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.RecordReferralResponse.fromBuffer(value));
  static final _$creditReferralRewards = $grpc.ClientMethod<
          $23.CreditReferralRewardsRequest, $23.CreditReferralRewardsResponse>(
      '/pb.ReferralService/CreditReferralRewards',
      ($23.CreditReferralRewardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.CreditReferralRewardsResponse.fromBuffer(value));

  ReferralServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$23.ValidateReferralCodeResponse> validateReferralCode(
      $23.ValidateReferralCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetMyReferralCodeResponse> getMyReferralCode(
      $23.GetMyReferralCodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetMyReferralStatsResponse> getMyReferralStats(
      $23.GetMyReferralStatsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralStats, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetMyReferralsResponse> getMyReferrals(
      $23.GetMyReferralsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferrals, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetReferralLeaderboardResponse>
      getReferralLeaderboard($23.GetReferralLeaderboardRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReferralLeaderboard, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.GetCountryRewardConfigResponse>
      getCountryRewardConfig($23.GetCountryRewardConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRewardConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$23.RecordReferralResponse> recordReferral(
      $23.RecordReferralRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recordReferral, request, options: options);
  }

  $grpc.ResponseFuture<$23.CreditReferralRewardsResponse> creditReferralRewards(
      $23.CreditReferralRewardsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$creditReferralRewards, request, options: options);
  }
}

abstract class ReferralServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ReferralService';

  ReferralServiceBase() {
    $addMethod($grpc.ServiceMethod<$23.ValidateReferralCodeRequest,
            $23.ValidateReferralCodeResponse>(
        'ValidateReferralCode',
        validateReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.ValidateReferralCodeRequest.fromBuffer(value),
        ($23.ValidateReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyReferralCodeRequest,
            $23.GetMyReferralCodeResponse>(
        'GetMyReferralCode',
        getMyReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyReferralCodeRequest.fromBuffer(value),
        ($23.GetMyReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyReferralStatsRequest,
            $23.GetMyReferralStatsResponse>(
        'GetMyReferralStats',
        getMyReferralStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyReferralStatsRequest.fromBuffer(value),
        ($23.GetMyReferralStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyReferralsRequest,
            $23.GetMyReferralsResponse>(
        'GetMyReferrals',
        getMyReferrals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyReferralsRequest.fromBuffer(value),
        ($23.GetMyReferralsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetReferralLeaderboardRequest,
            $23.GetReferralLeaderboardResponse>(
        'GetReferralLeaderboard',
        getReferralLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetReferralLeaderboardRequest.fromBuffer(value),
        ($23.GetReferralLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetCountryRewardConfigRequest,
            $23.GetCountryRewardConfigResponse>(
        'GetCountryRewardConfig',
        getCountryRewardConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetCountryRewardConfigRequest.fromBuffer(value),
        ($23.GetCountryRewardConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.RecordReferralRequest,
            $23.RecordReferralResponse>(
        'RecordReferral',
        recordReferral_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.RecordReferralRequest.fromBuffer(value),
        ($23.RecordReferralResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.CreditReferralRewardsRequest,
            $23.CreditReferralRewardsResponse>(
        'CreditReferralRewards',
        creditReferralRewards_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.CreditReferralRewardsRequest.fromBuffer(value),
        ($23.CreditReferralRewardsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$23.ValidateReferralCodeResponse> validateReferralCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.ValidateReferralCodeRequest> request) async {
    return validateReferralCode(call, await request);
  }

  $async.Future<$23.GetMyReferralCodeResponse> getMyReferralCode_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyReferralCodeRequest> request) async {
    return getMyReferralCode(call, await request);
  }

  $async.Future<$23.GetMyReferralStatsResponse> getMyReferralStats_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyReferralStatsRequest> request) async {
    return getMyReferralStats(call, await request);
  }

  $async.Future<$23.GetMyReferralsResponse> getMyReferrals_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyReferralsRequest> request) async {
    return getMyReferrals(call, await request);
  }

  $async.Future<$23.GetReferralLeaderboardResponse> getReferralLeaderboard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetReferralLeaderboardRequest> request) async {
    return getReferralLeaderboard(call, await request);
  }

  $async.Future<$23.GetCountryRewardConfigResponse> getCountryRewardConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetCountryRewardConfigRequest> request) async {
    return getCountryRewardConfig(call, await request);
  }

  $async.Future<$23.RecordReferralResponse> recordReferral_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.RecordReferralRequest> request) async {
    return recordReferral(call, await request);
  }

  $async.Future<$23.CreditReferralRewardsResponse> creditReferralRewards_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.CreditReferralRewardsRequest> request) async {
    return creditReferralRewards(call, await request);
  }

  $async.Future<$23.ValidateReferralCodeResponse> validateReferralCode(
      $grpc.ServiceCall call, $23.ValidateReferralCodeRequest request);
  $async.Future<$23.GetMyReferralCodeResponse> getMyReferralCode(
      $grpc.ServiceCall call, $23.GetMyReferralCodeRequest request);
  $async.Future<$23.GetMyReferralStatsResponse> getMyReferralStats(
      $grpc.ServiceCall call, $23.GetMyReferralStatsRequest request);
  $async.Future<$23.GetMyReferralsResponse> getMyReferrals(
      $grpc.ServiceCall call, $23.GetMyReferralsRequest request);
  $async.Future<$23.GetReferralLeaderboardResponse> getReferralLeaderboard(
      $grpc.ServiceCall call, $23.GetReferralLeaderboardRequest request);
  $async.Future<$23.GetCountryRewardConfigResponse> getCountryRewardConfig(
      $grpc.ServiceCall call, $23.GetCountryRewardConfigRequest request);
  $async.Future<$23.RecordReferralResponse> recordReferral(
      $grpc.ServiceCall call, $23.RecordReferralRequest request);
  $async.Future<$23.CreditReferralRewardsResponse> creditReferralRewards(
      $grpc.ServiceCall call, $23.CreditReferralRewardsRequest request);
}
