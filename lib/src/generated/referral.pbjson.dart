//
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use referralStatusDescriptor instead')
const ReferralStatus$json = {
  '1': 'ReferralStatus',
  '2': [
    {'1': 'REFERRAL_STATUS_PENDING', '2': 0},
    {'1': 'REFERRAL_STATUS_COMPLETED', '2': 1},
    {'1': 'REFERRAL_STATUS_FAILED', '2': 2},
    {'1': 'REFERRAL_STATUS_CANCELLED', '2': 3},
  ],
};

/// Descriptor for `ReferralStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List referralStatusDescriptor = $convert.base64Decode(
    'Cg5SZWZlcnJhbFN0YXR1cxIbChdSRUZFUlJBTF9TVEFUVVNfUEVORElORxAAEh0KGVJFRkVSUk'
    'FMX1NUQVRVU19DT01QTEVURUQQARIaChZSRUZFUlJBTF9TVEFUVVNfRkFJTEVEEAISHQoZUkVG'
    'RVJSQUxfU1RBVFVTX0NBTkNFTExFRBAD');

@$core.Deprecated('Use referralCodeDescriptor instead')
const ReferralCode$json = {
  '1': 'ReferralCode',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    {'1': 'is_active', '3': 4, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `ReferralCode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referralCodeDescriptor = $convert.base64Decode(
    'CgxSZWZlcnJhbENvZGUSDgoCaWQYASABKARSAmlkEhcKB3VzZXJfaWQYAiABKARSBnVzZXJJZB'
    'ISCgRjb2RlGAMgASgJUgRjb2RlEhsKCWlzX2FjdGl2ZRgEIAEoCFIIaXNBY3RpdmUSOQoKY3Jl'
    'YXRlZF9hdBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cg'
    'p1cGRhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use referralTransactionDescriptor instead')
const ReferralTransaction$json = {
  '1': 'ReferralTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'referrer_user_id', '3': 2, '4': 1, '5': 4, '10': 'referrerUserId'},
    {'1': 'referee_user_id', '3': 3, '4': 1, '5': 4, '10': 'refereeUserId'},
    {'1': 'referral_code_used', '3': 4, '4': 1, '5': 9, '10': 'referralCodeUsed'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.ReferralStatus', '10': 'status'},
    {'1': 'referrer_reward_amount', '3': 6, '4': 1, '5': 5, '10': 'referrerRewardAmount'},
    {'1': 'referee_reward_amount', '3': 7, '4': 1, '5': 5, '10': 'refereeRewardAmount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    {'1': 'failure_reason', '3': 11, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `ReferralTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referralTransactionDescriptor = $convert.base64Decode(
    'ChNSZWZlcnJhbFRyYW5zYWN0aW9uEg4KAmlkGAEgASgEUgJpZBIoChByZWZlcnJlcl91c2VyX2'
    'lkGAIgASgEUg5yZWZlcnJlclVzZXJJZBImCg9yZWZlcmVlX3VzZXJfaWQYAyABKARSDXJlZmVy'
    'ZWVVc2VySWQSLAoScmVmZXJyYWxfY29kZV91c2VkGAQgASgJUhByZWZlcnJhbENvZGVVc2VkEi'
    'oKBnN0YXR1cxgFIAEoDjISLnBiLlJlZmVycmFsU3RhdHVzUgZzdGF0dXMSNAoWcmVmZXJyZXJf'
    'cmV3YXJkX2Ftb3VudBgGIAEoBVIUcmVmZXJyZXJSZXdhcmRBbW91bnQSMgoVcmVmZXJlZV9yZX'
    'dhcmRfYW1vdW50GAcgASgFUhNyZWZlcmVlUmV3YXJkQW1vdW50EhoKCGN1cnJlbmN5GAggASgJ'
    'UghjdXJyZW5jeRI5CgpjcmVhdGVkX2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIJY3JlYXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5U'
    'aW1lc3RhbXBSC2NvbXBsZXRlZEF0EiUKDmZhaWx1cmVfcmVhc29uGAsgASgJUg1mYWlsdXJlUm'
    'Vhc29u');

@$core.Deprecated('Use countryRewardConfigDescriptor instead')
const CountryRewardConfig$json = {
  '1': 'CountryRewardConfig',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'referrer_reward', '3': 4, '4': 1, '5': 5, '10': 'referrerReward'},
    {'1': 'referee_reward', '3': 5, '4': 1, '5': 5, '10': 'refereeReward'},
    {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `CountryRewardConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countryRewardConfigDescriptor = $convert.base64Decode(
    'ChNDb3VudHJ5UmV3YXJkQ29uZmlnEg4KAmlkGAEgASgEUgJpZBIhCgxjb3VudHJ5X2NvZGUYAi'
    'ABKAlSC2NvdW50cnlDb2RlEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRInCg9yZWZlcnJl'
    'cl9yZXdhcmQYBCABKAVSDnJlZmVycmVyUmV3YXJkEiUKDnJlZmVyZWVfcmV3YXJkGAUgASgFUg'
    '1yZWZlcmVlUmV3YXJkEhsKCWlzX2FjdGl2ZRgGIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9h'
    'dBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdG'
    'VkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use referralStatsDescriptor instead')
const ReferralStats$json = {
  '1': 'ReferralStats',
  '2': [
    {'1': 'total_referrals', '3': 1, '4': 1, '5': 3, '10': 'totalReferrals'},
    {'1': 'total_rewards_earned', '3': 2, '4': 1, '5': 5, '10': 'totalRewardsEarned'},
    {'1': 'pending_rewards', '3': 3, '4': 1, '5': 5, '10': 'pendingRewards'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `ReferralStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referralStatsDescriptor = $convert.base64Decode(
    'Cg1SZWZlcnJhbFN0YXRzEicKD3RvdGFsX3JlZmVycmFscxgBIAEoA1IOdG90YWxSZWZlcnJhbH'
    'MSMAoUdG90YWxfcmV3YXJkc19lYXJuZWQYAiABKAVSEnRvdGFsUmV3YXJkc0Vhcm5lZBInCg9w'
    'ZW5kaW5nX3Jld2FyZHMYAyABKAVSDnBlbmRpbmdSZXdhcmRzEhoKCGN1cnJlbmN5GAQgASgJUg'
    'hjdXJyZW5jeQ==');

@$core.Deprecated('Use leaderboardEntryDescriptor instead')
const LeaderboardEntry$json = {
  '1': 'LeaderboardEntry',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'total_referrals', '3': 5, '4': 1, '5': 3, '10': 'totalReferrals'},
    {'1': 'rank', '3': 6, '4': 1, '5': 5, '10': 'rank'},
  ],
};

/// Descriptor for `LeaderboardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardEntryDescriptor = $convert.base64Decode(
    'ChBMZWFkZXJib2FyZEVudHJ5EhcKB3VzZXJfaWQYASABKARSBnVzZXJJZBIdCgpmaXJzdF9uYW'
    '1lGAIgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAMgASgJUghsYXN0TmFtZRIaCgh1c2Vy'
    'bmFtZRgEIAEoCVIIdXNlcm5hbWUSJwoPdG90YWxfcmVmZXJyYWxzGAUgASgDUg50b3RhbFJlZm'
    'VycmFscxISCgRyYW5rGAYgASgFUgRyYW5r');

@$core.Deprecated('Use validateReferralCodeRequestDescriptor instead')
const ValidateReferralCodeRequest$json = {
  '1': 'ValidateReferralCodeRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `ValidateReferralCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateReferralCodeRequestDescriptor = $convert.base64Decode(
    'ChtWYWxpZGF0ZVJlZmVycmFsQ29kZVJlcXVlc3QSEgoEY29kZRgBIAEoCVIEY29kZQ==');

@$core.Deprecated('Use validateReferralCodeResponseDescriptor instead')
const ValidateReferralCodeResponse$json = {
  '1': 'ValidateReferralCodeResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ValidateReferralCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateReferralCodeResponseDescriptor = $convert.base64Decode(
    'ChxWYWxpZGF0ZVJlZmVycmFsQ29kZVJlc3BvbnNlEhkKCGlzX3ZhbGlkGAEgASgIUgdpc1ZhbG'
    'lkEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getMyReferralCodeRequestDescriptor instead')
const GetMyReferralCodeRequest$json = {
  '1': 'GetMyReferralCodeRequest',
};

/// Descriptor for `GetMyReferralCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralCodeRequestDescriptor = $convert.base64Decode(
    'ChhHZXRNeVJlZmVycmFsQ29kZVJlcXVlc3Q=');

@$core.Deprecated('Use getMyReferralCodeResponseDescriptor instead')
const GetMyReferralCodeResponse$json = {
  '1': 'GetMyReferralCodeResponse',
  '2': [
    {'1': 'referral_code', '3': 1, '4': 1, '5': 11, '6': '.pb.ReferralCode', '10': 'referralCode'},
  ],
};

/// Descriptor for `GetMyReferralCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralCodeResponseDescriptor = $convert.base64Decode(
    'ChlHZXRNeVJlZmVycmFsQ29kZVJlc3BvbnNlEjUKDXJlZmVycmFsX2NvZGUYASABKAsyEC5wYi'
    '5SZWZlcnJhbENvZGVSDHJlZmVycmFsQ29kZQ==');

@$core.Deprecated('Use getMyReferralStatsRequestDescriptor instead')
const GetMyReferralStatsRequest$json = {
  '1': 'GetMyReferralStatsRequest',
};

/// Descriptor for `GetMyReferralStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralStatsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRNeVJlZmVycmFsU3RhdHNSZXF1ZXN0');

@$core.Deprecated('Use getMyReferralStatsResponseDescriptor instead')
const GetMyReferralStatsResponse$json = {
  '1': 'GetMyReferralStatsResponse',
  '2': [
    {'1': 'stats', '3': 1, '4': 1, '5': 11, '6': '.pb.ReferralStats', '10': 'stats'},
  ],
};

/// Descriptor for `GetMyReferralStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralStatsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRNeVJlZmVycmFsU3RhdHNSZXNwb25zZRInCgVzdGF0cxgBIAEoCzIRLnBiLlJlZmVycm'
    'FsU3RhdHNSBXN0YXRz');

@$core.Deprecated('Use getMyReferralsRequestDescriptor instead')
const GetMyReferralsRequest$json = {
  '1': 'GetMyReferralsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetMyReferralsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRNeVJlZmVycmFsc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3Npem'
    'UYAiABKAVSCHBhZ2VTaXpl');

@$core.Deprecated('Use getMyReferralsResponseDescriptor instead')
const GetMyReferralsResponse$json = {
  '1': 'GetMyReferralsResponse',
  '2': [
    {'1': 'referrals', '3': 1, '4': 3, '5': 11, '6': '.pb.ReferralTransaction', '10': 'referrals'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetMyReferralsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralsResponseDescriptor = $convert.base64Decode(
    'ChZHZXRNeVJlZmVycmFsc1Jlc3BvbnNlEjUKCXJlZmVycmFscxgBIAMoCzIXLnBiLlJlZmVycm'
    'FsVHJhbnNhY3Rpb25SCXJlZmVycmFscxISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6'
    'ZRgDIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use getReferralLeaderboardRequestDescriptor instead')
const GetReferralLeaderboardRequest$json = {
  '1': 'GetReferralLeaderboardRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetReferralLeaderboardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReferralLeaderboardRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRSZWZlcnJhbExlYWRlcmJvYXJkUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getReferralLeaderboardResponseDescriptor instead')
const GetReferralLeaderboardResponse$json = {
  '1': 'GetReferralLeaderboardResponse',
  '2': [
    {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.pb.LeaderboardEntry', '10': 'entries'},
  ],
};

/// Descriptor for `GetReferralLeaderboardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReferralLeaderboardResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRSZWZlcnJhbExlYWRlcmJvYXJkUmVzcG9uc2USLgoHZW50cmllcxgBIAMoCzIULnBiLk'
    'xlYWRlcmJvYXJkRW50cnlSB2VudHJpZXM=');

@$core.Deprecated('Use getCountryRewardConfigRequestDescriptor instead')
const GetCountryRewardConfigRequest$json = {
  '1': 'GetCountryRewardConfigRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetCountryRewardConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRewardConfigRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRDb3VudHJ5UmV3YXJkQ29uZmlnUmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2'
    'NvdW50cnlDb2Rl');

@$core.Deprecated('Use getCountryRewardConfigResponseDescriptor instead')
const GetCountryRewardConfigResponse$json = {
  '1': 'GetCountryRewardConfigResponse',
  '2': [
    {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.pb.CountryRewardConfig', '10': 'config'},
  ],
};

/// Descriptor for `GetCountryRewardConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRewardConfigResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRDb3VudHJ5UmV3YXJkQ29uZmlnUmVzcG9uc2USLwoGY29uZmlnGAEgASgLMhcucGIuQ2'
    '91bnRyeVJld2FyZENvbmZpZ1IGY29uZmln');

@$core.Deprecated('Use recordReferralRequestDescriptor instead')
const RecordReferralRequest$json = {
  '1': 'RecordReferralRequest',
  '2': [
    {'1': 'referee_user_id', '3': 1, '4': 1, '5': 4, '10': 'refereeUserId'},
    {'1': 'referral_code', '3': 2, '4': 1, '5': 9, '10': 'referralCode'},
  ],
};

/// Descriptor for `RecordReferralRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordReferralRequestDescriptor = $convert.base64Decode(
    'ChVSZWNvcmRSZWZlcnJhbFJlcXVlc3QSJgoPcmVmZXJlZV91c2VyX2lkGAEgASgEUg1yZWZlcm'
    'VlVXNlcklkEiMKDXJlZmVycmFsX2NvZGUYAiABKAlSDHJlZmVycmFsQ29kZQ==');

@$core.Deprecated('Use recordReferralResponseDescriptor instead')
const RecordReferralResponse$json = {
  '1': 'RecordReferralResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.ReferralTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `RecordReferralResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordReferralResponseDescriptor = $convert.base64Decode(
    'ChZSZWNvcmRSZWZlcnJhbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRI5Cgt0cmFuc2FjdGlvbhgDIAEoCzIXLnBiLlJlZmVycmFs'
    'VHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9u');

@$core.Deprecated('Use creditReferralRewardsRequestDescriptor instead')
const CreditReferralRewardsRequest$json = {
  '1': 'CreditReferralRewardsRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 4, '10': 'transactionId'},
  ],
};

/// Descriptor for `CreditReferralRewardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditReferralRewardsRequestDescriptor = $convert.base64Decode(
    'ChxDcmVkaXRSZWZlcnJhbFJld2FyZHNSZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgASgEUg'
    '10cmFuc2FjdGlvbklk');

@$core.Deprecated('Use creditReferralRewardsResponseDescriptor instead')
const CreditReferralRewardsResponse$json = {
  '1': 'CreditReferralRewardsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreditReferralRewardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditReferralRewardsResponseDescriptor = $convert.base64Decode(
    'Ch1DcmVkaXRSZWZlcnJhbFJld2FyZHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

