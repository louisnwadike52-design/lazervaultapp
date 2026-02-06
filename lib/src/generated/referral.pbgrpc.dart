//
//  Generated code. Do not modify.
//  source: referral.proto
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

import 'referral.pb.dart' as $29;

export 'referral.pb.dart';

@$pb.GrpcServiceName('pb.ReferralService')
class ReferralServiceClient extends $grpc.Client {
  static final _$validateReferralCode = $grpc.ClientMethod<$29.ValidateReferralCodeRequest, $29.ValidateReferralCodeResponse>(
      '/pb.ReferralService/ValidateReferralCode',
      ($29.ValidateReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $29.ValidateReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralCode = $grpc.ClientMethod<$29.GetMyReferralCodeRequest, $29.GetMyReferralCodeResponse>(
      '/pb.ReferralService/GetMyReferralCode',
      ($29.GetMyReferralCodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $29.GetMyReferralCodeResponse.fromBuffer(value));
  static final _$getMyReferralStats = $grpc.ClientMethod<$29.GetMyReferralStatsRequest, $29.GetMyReferralStatsResponse>(
      '/pb.ReferralService/GetMyReferralStats',
      ($29.GetMyReferralStatsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $29.GetMyReferralStatsResponse.fromBuffer(value));
  static final _$getMyReferrals = $grpc.ClientMethod<$29.GetMyReferralsRequest, $29.GetMyReferralsResponse>(
      '/pb.ReferralService/GetMyReferrals',
      ($29.GetMyReferralsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $29.GetMyReferralsResponse.fromBuffer(value));
  static final _$getReferralLeaderboard = $grpc.ClientMethod<$29.GetReferralLeaderboardRequest, $29.GetReferralLeaderboardResponse>(
      '/pb.ReferralService/GetReferralLeaderboard',
      ($29.GetReferralLeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $29.GetReferralLeaderboardResponse.fromBuffer(value));
  static final _$getCountryRewardConfig = $grpc.ClientMethod<$29.GetCountryRewardConfigRequest, $29.GetCountryRewardConfigResponse>(
      '/pb.ReferralService/GetCountryRewardConfig',
      ($29.GetCountryRewardConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $29.GetCountryRewardConfigResponse.fromBuffer(value));
  static final _$recordReferral = $grpc.ClientMethod<$29.RecordReferralRequest, $29.RecordReferralResponse>(
      '/pb.ReferralService/RecordReferral',
      ($29.RecordReferralRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $29.RecordReferralResponse.fromBuffer(value));
  static final _$creditReferralRewards = $grpc.ClientMethod<$29.CreditReferralRewardsRequest, $29.CreditReferralRewardsResponse>(
      '/pb.ReferralService/CreditReferralRewards',
      ($29.CreditReferralRewardsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $29.CreditReferralRewardsResponse.fromBuffer(value));

  ReferralServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$29.ValidateReferralCodeResponse> validateReferralCode($29.ValidateReferralCodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetMyReferralCodeResponse> getMyReferralCode($29.GetMyReferralCodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralCode, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetMyReferralStatsResponse> getMyReferralStats($29.GetMyReferralStatsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferralStats, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetMyReferralsResponse> getMyReferrals($29.GetMyReferralsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyReferrals, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetReferralLeaderboardResponse> getReferralLeaderboard($29.GetReferralLeaderboardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReferralLeaderboard, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetCountryRewardConfigResponse> getCountryRewardConfig($29.GetCountryRewardConfigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCountryRewardConfig, request, options: options);
  }

  $grpc.ResponseFuture<$29.RecordReferralResponse> recordReferral($29.RecordReferralRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recordReferral, request, options: options);
  }

  $grpc.ResponseFuture<$29.CreditReferralRewardsResponse> creditReferralRewards($29.CreditReferralRewardsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$creditReferralRewards, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.ReferralService')
abstract class ReferralServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ReferralService';

  ReferralServiceBase() {
    $addMethod($grpc.ServiceMethod<$29.ValidateReferralCodeRequest, $29.ValidateReferralCodeResponse>(
        'ValidateReferralCode',
        validateReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.ValidateReferralCodeRequest.fromBuffer(value),
        ($29.ValidateReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetMyReferralCodeRequest, $29.GetMyReferralCodeResponse>(
        'GetMyReferralCode',
        getMyReferralCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.GetMyReferralCodeRequest.fromBuffer(value),
        ($29.GetMyReferralCodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetMyReferralStatsRequest, $29.GetMyReferralStatsResponse>(
        'GetMyReferralStats',
        getMyReferralStats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.GetMyReferralStatsRequest.fromBuffer(value),
        ($29.GetMyReferralStatsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetMyReferralsRequest, $29.GetMyReferralsResponse>(
        'GetMyReferrals',
        getMyReferrals_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.GetMyReferralsRequest.fromBuffer(value),
        ($29.GetMyReferralsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetReferralLeaderboardRequest, $29.GetReferralLeaderboardResponse>(
        'GetReferralLeaderboard',
        getReferralLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.GetReferralLeaderboardRequest.fromBuffer(value),
        ($29.GetReferralLeaderboardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetCountryRewardConfigRequest, $29.GetCountryRewardConfigResponse>(
        'GetCountryRewardConfig',
        getCountryRewardConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.GetCountryRewardConfigRequest.fromBuffer(value),
        ($29.GetCountryRewardConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.RecordReferralRequest, $29.RecordReferralResponse>(
        'RecordReferral',
        recordReferral_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.RecordReferralRequest.fromBuffer(value),
        ($29.RecordReferralResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.CreditReferralRewardsRequest, $29.CreditReferralRewardsResponse>(
        'CreditReferralRewards',
        creditReferralRewards_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.CreditReferralRewardsRequest.fromBuffer(value),
        ($29.CreditReferralRewardsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$29.ValidateReferralCodeResponse> validateReferralCode_Pre($grpc.ServiceCall call, $async.Future<$29.ValidateReferralCodeRequest> request) async {
    return validateReferralCode(call, await request);
  }

  $async.Future<$29.GetMyReferralCodeResponse> getMyReferralCode_Pre($grpc.ServiceCall call, $async.Future<$29.GetMyReferralCodeRequest> request) async {
    return getMyReferralCode(call, await request);
  }

  $async.Future<$29.GetMyReferralStatsResponse> getMyReferralStats_Pre($grpc.ServiceCall call, $async.Future<$29.GetMyReferralStatsRequest> request) async {
    return getMyReferralStats(call, await request);
  }

  $async.Future<$29.GetMyReferralsResponse> getMyReferrals_Pre($grpc.ServiceCall call, $async.Future<$29.GetMyReferralsRequest> request) async {
    return getMyReferrals(call, await request);
  }

  $async.Future<$29.GetReferralLeaderboardResponse> getReferralLeaderboard_Pre($grpc.ServiceCall call, $async.Future<$29.GetReferralLeaderboardRequest> request) async {
    return getReferralLeaderboard(call, await request);
  }

  $async.Future<$29.GetCountryRewardConfigResponse> getCountryRewardConfig_Pre($grpc.ServiceCall call, $async.Future<$29.GetCountryRewardConfigRequest> request) async {
    return getCountryRewardConfig(call, await request);
  }

  $async.Future<$29.RecordReferralResponse> recordReferral_Pre($grpc.ServiceCall call, $async.Future<$29.RecordReferralRequest> request) async {
    return recordReferral(call, await request);
  }

  $async.Future<$29.CreditReferralRewardsResponse> creditReferralRewards_Pre($grpc.ServiceCall call, $async.Future<$29.CreditReferralRewardsRequest> request) async {
    return creditReferralRewards(call, await request);
  }

  $async.Future<$29.ValidateReferralCodeResponse> validateReferralCode($grpc.ServiceCall call, $29.ValidateReferralCodeRequest request);
  $async.Future<$29.GetMyReferralCodeResponse> getMyReferralCode($grpc.ServiceCall call, $29.GetMyReferralCodeRequest request);
  $async.Future<$29.GetMyReferralStatsResponse> getMyReferralStats($grpc.ServiceCall call, $29.GetMyReferralStatsRequest request);
  $async.Future<$29.GetMyReferralsResponse> getMyReferrals($grpc.ServiceCall call, $29.GetMyReferralsRequest request);
  $async.Future<$29.GetReferralLeaderboardResponse> getReferralLeaderboard($grpc.ServiceCall call, $29.GetReferralLeaderboardRequest request);
  $async.Future<$29.GetCountryRewardConfigResponse> getCountryRewardConfig($grpc.ServiceCall call, $29.GetCountryRewardConfigRequest request);
  $async.Future<$29.RecordReferralResponse> recordReferral($grpc.ServiceCall call, $29.RecordReferralRequest request);
  $async.Future<$29.CreditReferralRewardsResponse> creditReferralRewards($grpc.ServiceCall call, $29.CreditReferralRewardsRequest request);
}
