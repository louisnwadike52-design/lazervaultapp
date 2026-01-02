///
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use referralStatusDescriptor instead')
const ReferralStatus$json = const {
  '1': 'ReferralStatus',
  '2': const [
    const {'1': 'REFERRAL_STATUS_PENDING', '2': 0},
    const {'1': 'REFERRAL_STATUS_COMPLETED', '2': 1},
    const {'1': 'REFERRAL_STATUS_FAILED', '2': 2},
    const {'1': 'REFERRAL_STATUS_CANCELLED', '2': 3},
  ],
};

/// Descriptor for `ReferralStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List referralStatusDescriptor = $convert.base64Decode('Cg5SZWZlcnJhbFN0YXR1cxIbChdSRUZFUlJBTF9TVEFUVVNfUEVORElORxAAEh0KGVJFRkVSUkFMX1NUQVRVU19DT01QTEVURUQQARIaChZSRUZFUlJBTF9TVEFUVVNfRkFJTEVEEAISHQoZUkVGRVJSQUxfU1RBVFVTX0NBTkNFTExFRBAD');
@$core.Deprecated('Use referralCodeDescriptor instead')
const ReferralCode$json = const {
  '1': 'ReferralCode',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'is_active', '3': 4, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `ReferralCode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referralCodeDescriptor = $convert.base64Decode('CgxSZWZlcnJhbENvZGUSDgoCaWQYASABKARSAmlkEhcKB3VzZXJfaWQYAiABKARSBnVzZXJJZBISCgRjb2RlGAMgASgJUgRjb2RlEhsKCWlzX2FjdGl2ZRgEIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9hdBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use referralTransactionDescriptor instead')
const ReferralTransaction$json = const {
  '1': 'ReferralTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'referrer_user_id', '3': 2, '4': 1, '5': 4, '10': 'referrerUserId'},
    const {'1': 'referee_user_id', '3': 3, '4': 1, '5': 4, '10': 'refereeUserId'},
    const {'1': 'referral_code_used', '3': 4, '4': 1, '5': 9, '10': 'referralCodeUsed'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.ReferralStatus', '10': 'status'},
    const {'1': 'referrer_reward_amount', '3': 6, '4': 1, '5': 5, '10': 'referrerRewardAmount'},
    const {'1': 'referee_reward_amount', '3': 7, '4': 1, '5': 5, '10': 'refereeRewardAmount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'completed_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    const {'1': 'failure_reason', '3': 11, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `ReferralTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referralTransactionDescriptor = $convert.base64Decode('ChNSZWZlcnJhbFRyYW5zYWN0aW9uEg4KAmlkGAEgASgEUgJpZBIoChByZWZlcnJlcl91c2VyX2lkGAIgASgEUg5yZWZlcnJlclVzZXJJZBImCg9yZWZlcmVlX3VzZXJfaWQYAyABKARSDXJlZmVyZWVVc2VySWQSLAoScmVmZXJyYWxfY29kZV91c2VkGAQgASgJUhByZWZlcnJhbENvZGVVc2VkEioKBnN0YXR1cxgFIAEoDjISLnBiLlJlZmVycmFsU3RhdHVzUgZzdGF0dXMSNAoWcmVmZXJyZXJfcmV3YXJkX2Ftb3VudBgGIAEoBVIUcmVmZXJyZXJSZXdhcmRBbW91bnQSMgoVcmVmZXJlZV9yZXdhcmRfYW1vdW50GAcgASgFUhNyZWZlcmVlUmV3YXJkQW1vdW50EhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRI5CgpjcmVhdGVkX2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NvbXBsZXRlZEF0EiUKDmZhaWx1cmVfcmVhc29uGAsgASgJUg1mYWlsdXJlUmVhc29u');
@$core.Deprecated('Use countryRewardConfigDescriptor instead')
const CountryRewardConfig$json = const {
  '1': 'CountryRewardConfig',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'referrer_reward', '3': 4, '4': 1, '5': 5, '10': 'referrerReward'},
    const {'1': 'referee_reward', '3': 5, '4': 1, '5': 5, '10': 'refereeReward'},
    const {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `CountryRewardConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countryRewardConfigDescriptor = $convert.base64Decode('ChNDb3VudHJ5UmV3YXJkQ29uZmlnEg4KAmlkGAEgASgEUgJpZBIhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2RlEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRInCg9yZWZlcnJlcl9yZXdhcmQYBCABKAVSDnJlZmVycmVyUmV3YXJkEiUKDnJlZmVyZWVfcmV3YXJkGAUgASgFUg1yZWZlcmVlUmV3YXJkEhsKCWlzX2FjdGl2ZRgGIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use referralStatsDescriptor instead')
const ReferralStats$json = const {
  '1': 'ReferralStats',
  '2': const [
    const {'1': 'total_referrals', '3': 1, '4': 1, '5': 3, '10': 'totalReferrals'},
    const {'1': 'total_rewards_earned', '3': 2, '4': 1, '5': 5, '10': 'totalRewardsEarned'},
    const {'1': 'pending_rewards', '3': 3, '4': 1, '5': 5, '10': 'pendingRewards'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `ReferralStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referralStatsDescriptor = $convert.base64Decode('Cg1SZWZlcnJhbFN0YXRzEicKD3RvdGFsX3JlZmVycmFscxgBIAEoA1IOdG90YWxSZWZlcnJhbHMSMAoUdG90YWxfcmV3YXJkc19lYXJuZWQYAiABKAVSEnRvdGFsUmV3YXJkc0Vhcm5lZBInCg9wZW5kaW5nX3Jld2FyZHMYAyABKAVSDnBlbmRpbmdSZXdhcmRzEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeQ==');
@$core.Deprecated('Use leaderboardEntryDescriptor instead')
const LeaderboardEntry$json = const {
  '1': 'LeaderboardEntry',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'total_referrals', '3': 5, '4': 1, '5': 3, '10': 'totalReferrals'},
    const {'1': 'rank', '3': 6, '4': 1, '5': 5, '10': 'rank'},
  ],
};

/// Descriptor for `LeaderboardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardEntryDescriptor = $convert.base64Decode('ChBMZWFkZXJib2FyZEVudHJ5EhcKB3VzZXJfaWQYASABKARSBnVzZXJJZBIdCgpmaXJzdF9uYW1lGAIgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAMgASgJUghsYXN0TmFtZRIaCgh1c2VybmFtZRgEIAEoCVIIdXNlcm5hbWUSJwoPdG90YWxfcmVmZXJyYWxzGAUgASgDUg50b3RhbFJlZmVycmFscxISCgRyYW5rGAYgASgFUgRyYW5r');
@$core.Deprecated('Use validateReferralCodeRequestDescriptor instead')
const ValidateReferralCodeRequest$json = const {
  '1': 'ValidateReferralCodeRequest',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `ValidateReferralCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateReferralCodeRequestDescriptor = $convert.base64Decode('ChtWYWxpZGF0ZVJlZmVycmFsQ29kZVJlcXVlc3QSEgoEY29kZRgBIAEoCVIEY29kZQ==');
@$core.Deprecated('Use validateReferralCodeResponseDescriptor instead')
const ValidateReferralCodeResponse$json = const {
  '1': 'ValidateReferralCodeResponse',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ValidateReferralCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateReferralCodeResponseDescriptor = $convert.base64Decode('ChxWYWxpZGF0ZVJlZmVycmFsQ29kZVJlc3BvbnNlEhkKCGlzX3ZhbGlkGAEgASgIUgdpc1ZhbGlkEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getMyReferralCodeRequestDescriptor instead')
const GetMyReferralCodeRequest$json = const {
  '1': 'GetMyReferralCodeRequest',
};

/// Descriptor for `GetMyReferralCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralCodeRequestDescriptor = $convert.base64Decode('ChhHZXRNeVJlZmVycmFsQ29kZVJlcXVlc3Q=');
@$core.Deprecated('Use getMyReferralCodeResponseDescriptor instead')
const GetMyReferralCodeResponse$json = const {
  '1': 'GetMyReferralCodeResponse',
  '2': const [
    const {'1': 'referral_code', '3': 1, '4': 1, '5': 11, '6': '.pb.ReferralCode', '10': 'referralCode'},
  ],
};

/// Descriptor for `GetMyReferralCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralCodeResponseDescriptor = $convert.base64Decode('ChlHZXRNeVJlZmVycmFsQ29kZVJlc3BvbnNlEjUKDXJlZmVycmFsX2NvZGUYASABKAsyEC5wYi5SZWZlcnJhbENvZGVSDHJlZmVycmFsQ29kZQ==');
@$core.Deprecated('Use getMyReferralStatsRequestDescriptor instead')
const GetMyReferralStatsRequest$json = const {
  '1': 'GetMyReferralStatsRequest',
};

/// Descriptor for `GetMyReferralStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralStatsRequestDescriptor = $convert.base64Decode('ChlHZXRNeVJlZmVycmFsU3RhdHNSZXF1ZXN0');
@$core.Deprecated('Use getMyReferralStatsResponseDescriptor instead')
const GetMyReferralStatsResponse$json = const {
  '1': 'GetMyReferralStatsResponse',
  '2': const [
    const {'1': 'stats', '3': 1, '4': 1, '5': 11, '6': '.pb.ReferralStats', '10': 'stats'},
  ],
};

/// Descriptor for `GetMyReferralStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralStatsResponseDescriptor = $convert.base64Decode('ChpHZXRNeVJlZmVycmFsU3RhdHNSZXNwb25zZRInCgVzdGF0cxgBIAEoCzIRLnBiLlJlZmVycmFsU3RhdHNSBXN0YXRz');
@$core.Deprecated('Use getMyReferralsRequestDescriptor instead')
const GetMyReferralsRequest$json = const {
  '1': 'GetMyReferralsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetMyReferralsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralsRequestDescriptor = $convert.base64Decode('ChVHZXRNeVJlZmVycmFsc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXpl');
@$core.Deprecated('Use getMyReferralsResponseDescriptor instead')
const GetMyReferralsResponse$json = const {
  '1': 'GetMyReferralsResponse',
  '2': const [
    const {'1': 'referrals', '3': 1, '4': 3, '5': 11, '6': '.pb.ReferralTransaction', '10': 'referrals'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetMyReferralsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralsResponseDescriptor = $convert.base64Decode('ChZHZXRNeVJlZmVycmFsc1Jlc3BvbnNlEjUKCXJlZmVycmFscxgBIAMoCzIXLnBiLlJlZmVycmFsVHJhbnNhY3Rpb25SCXJlZmVycmFscxISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemU=');
@$core.Deprecated('Use getReferralLeaderboardRequestDescriptor instead')
const GetReferralLeaderboardRequest$json = const {
  '1': 'GetReferralLeaderboardRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetReferralLeaderboardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReferralLeaderboardRequestDescriptor = $convert.base64Decode('Ch1HZXRSZWZlcnJhbExlYWRlcmJvYXJkUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getReferralLeaderboardResponseDescriptor instead')
const GetReferralLeaderboardResponse$json = const {
  '1': 'GetReferralLeaderboardResponse',
  '2': const [
    const {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.pb.LeaderboardEntry', '10': 'entries'},
  ],
};

/// Descriptor for `GetReferralLeaderboardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReferralLeaderboardResponseDescriptor = $convert.base64Decode('Ch5HZXRSZWZlcnJhbExlYWRlcmJvYXJkUmVzcG9uc2USLgoHZW50cmllcxgBIAMoCzIULnBiLkxlYWRlcmJvYXJkRW50cnlSB2VudHJpZXM=');
@$core.Deprecated('Use getCountryRewardConfigRequestDescriptor instead')
const GetCountryRewardConfigRequest$json = const {
  '1': 'GetCountryRewardConfigRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetCountryRewardConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRewardConfigRequestDescriptor = $convert.base64Decode('Ch1HZXRDb3VudHJ5UmV3YXJkQ29uZmlnUmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2NvdW50cnlDb2Rl');
@$core.Deprecated('Use getCountryRewardConfigResponseDescriptor instead')
const GetCountryRewardConfigResponse$json = const {
  '1': 'GetCountryRewardConfigResponse',
  '2': const [
    const {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.pb.CountryRewardConfig', '10': 'config'},
  ],
};

/// Descriptor for `GetCountryRewardConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRewardConfigResponseDescriptor = $convert.base64Decode('Ch5HZXRDb3VudHJ5UmV3YXJkQ29uZmlnUmVzcG9uc2USLwoGY29uZmlnGAEgASgLMhcucGIuQ291bnRyeVJld2FyZENvbmZpZ1IGY29uZmln');
@$core.Deprecated('Use recordReferralRequestDescriptor instead')
const RecordReferralRequest$json = const {
  '1': 'RecordReferralRequest',
  '2': const [
    const {'1': 'referee_user_id', '3': 1, '4': 1, '5': 4, '10': 'refereeUserId'},
    const {'1': 'referral_code', '3': 2, '4': 1, '5': 9, '10': 'referralCode'},
  ],
};

/// Descriptor for `RecordReferralRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordReferralRequestDescriptor = $convert.base64Decode('ChVSZWNvcmRSZWZlcnJhbFJlcXVlc3QSJgoPcmVmZXJlZV91c2VyX2lkGAEgASgEUg1yZWZlcmVlVXNlcklkEiMKDXJlZmVycmFsX2NvZGUYAiABKAlSDHJlZmVycmFsQ29kZQ==');
@$core.Deprecated('Use recordReferralResponseDescriptor instead')
const RecordReferralResponse$json = const {
  '1': 'RecordReferralResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.ReferralTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `RecordReferralResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordReferralResponseDescriptor = $convert.base64Decode('ChZSZWNvcmRSZWZlcnJhbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI5Cgt0cmFuc2FjdGlvbhgDIAEoCzIXLnBiLlJlZmVycmFsVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9u');
@$core.Deprecated('Use creditReferralRewardsRequestDescriptor instead')
const CreditReferralRewardsRequest$json = const {
  '1': 'CreditReferralRewardsRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 4, '10': 'transactionId'},
  ],
};

/// Descriptor for `CreditReferralRewardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditReferralRewardsRequestDescriptor = $convert.base64Decode('ChxDcmVkaXRSZWZlcnJhbFJld2FyZHNSZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgASgEUg10cmFuc2FjdGlvbklk');
@$core.Deprecated('Use creditReferralRewardsResponseDescriptor instead')
const CreditReferralRewardsResponse$json = const {
  '1': 'CreditReferralRewardsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreditReferralRewardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditReferralRewardsResponseDescriptor = $convert.base64Decode('Ch1DcmVkaXRSZWZlcnJhbFJld2FyZHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
