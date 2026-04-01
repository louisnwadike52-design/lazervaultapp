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
@$core.Deprecated('Use pointSourceDescriptor instead')
const PointSource$json = const {
  '1': 'PointSource',
  '2': const [
    const {'1': 'POINT_SOURCE_REFERRAL', '2': 0},
    const {'1': 'POINT_SOURCE_SIGNUP_BONUS', '2': 1},
    const {'1': 'POINT_SOURCE_FIRST_TRANSACTION', '2': 2},
    const {'1': 'POINT_SOURCE_MONTHLY_ACTIVE', '2': 3},
    const {'1': 'POINT_SOURCE_ACHIEVEMENT', '2': 4},
    const {'1': 'POINT_SOURCE_REDEMPTION', '2': 5},
  ],
};

/// Descriptor for `PointSource`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List pointSourceDescriptor = $convert.base64Decode('CgtQb2ludFNvdXJjZRIZChVQT0lOVF9TT1VSQ0VfUkVGRVJSQUwQABIdChlQT0lOVF9TT1VSQ0VfU0lHTlVQX0JPTlVTEAESIgoeUE9JTlRfU09VUkNFX0ZJUlNUX1RSQU5TQUNUSU9OEAISHwobUE9JTlRfU09VUkNFX01PTlRITFlfQUNUSVZFEAMSHAoYUE9JTlRfU09VUkNFX0FDSElFVkVNRU5UEAQSGwoXUE9JTlRfU09VUkNFX1JFREVNUFRJT04QBQ==');
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
    const {'1': 'referee_first_name', '3': 12, '4': 1, '5': 9, '10': 'refereeFirstName'},
    const {'1': 'referee_last_name', '3': 13, '4': 1, '5': 9, '10': 'refereeLastName'},
    const {'1': 'referee_username', '3': 14, '4': 1, '5': 9, '10': 'refereeUsername'},
    const {'1': 'referrer_username', '3': 15, '4': 1, '5': 9, '10': 'referrerUsername'},
    const {'1': 'referee_has_joined', '3': 16, '4': 1, '5': 8, '10': 'refereeHasJoined'},
  ],
};

/// Descriptor for `ReferralTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referralTransactionDescriptor = $convert.base64Decode('ChNSZWZlcnJhbFRyYW5zYWN0aW9uEg4KAmlkGAEgASgEUgJpZBIoChByZWZlcnJlcl91c2VyX2lkGAIgASgEUg5yZWZlcnJlclVzZXJJZBImCg9yZWZlcmVlX3VzZXJfaWQYAyABKARSDXJlZmVyZWVVc2VySWQSLAoScmVmZXJyYWxfY29kZV91c2VkGAQgASgJUhByZWZlcnJhbENvZGVVc2VkEioKBnN0YXR1cxgFIAEoDjISLnBiLlJlZmVycmFsU3RhdHVzUgZzdGF0dXMSNAoWcmVmZXJyZXJfcmV3YXJkX2Ftb3VudBgGIAEoBVIUcmVmZXJyZXJSZXdhcmRBbW91bnQSMgoVcmVmZXJlZV9yZXdhcmRfYW1vdW50GAcgASgFUhNyZWZlcmVlUmV3YXJkQW1vdW50EhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRI5CgpjcmVhdGVkX2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NvbXBsZXRlZEF0EiUKDmZhaWx1cmVfcmVhc29uGAsgASgJUg1mYWlsdXJlUmVhc29uEiwKEnJlZmVyZWVfZmlyc3RfbmFtZRgMIAEoCVIQcmVmZXJlZUZpcnN0TmFtZRIqChFyZWZlcmVlX2xhc3RfbmFtZRgNIAEoCVIPcmVmZXJlZUxhc3ROYW1lEikKEHJlZmVyZWVfdXNlcm5hbWUYDiABKAlSD3JlZmVyZWVVc2VybmFtZRIrChFyZWZlcnJlcl91c2VybmFtZRgPIAEoCVIQcmVmZXJyZXJVc2VybmFtZRIsChJyZWZlcmVlX2hhc19qb2luZWQYECABKAhSEHJlZmVyZWVIYXNKb2luZWQ=');
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
    const {'1': 'pending_referrals', '3': 5, '4': 1, '5': 5, '10': 'pendingReferrals'},
    const {'1': 'completed_referrals', '3': 6, '4': 1, '5': 5, '10': 'completedReferrals'},
  ],
};

/// Descriptor for `ReferralStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referralStatsDescriptor = $convert.base64Decode('Cg1SZWZlcnJhbFN0YXRzEicKD3RvdGFsX3JlZmVycmFscxgBIAEoA1IOdG90YWxSZWZlcnJhbHMSMAoUdG90YWxfcmV3YXJkc19lYXJuZWQYAiABKAVSEnRvdGFsUmV3YXJkc0Vhcm5lZBInCg9wZW5kaW5nX3Jld2FyZHMYAyABKAVSDnBlbmRpbmdSZXdhcmRzEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIrChFwZW5kaW5nX3JlZmVycmFscxgFIAEoBVIQcGVuZGluZ1JlZmVycmFscxIvChNjb21wbGV0ZWRfcmVmZXJyYWxzGAYgASgFUhJjb21wbGV0ZWRSZWZlcnJhbHM=');
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
    const {'1': 'total_rewards_earned', '3': 7, '4': 1, '5': 5, '10': 'totalRewardsEarned'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'profile_picture', '3': 9, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `LeaderboardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardEntryDescriptor = $convert.base64Decode('ChBMZWFkZXJib2FyZEVudHJ5EhcKB3VzZXJfaWQYASABKARSBnVzZXJJZBIdCgpmaXJzdF9uYW1lGAIgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAMgASgJUghsYXN0TmFtZRIaCgh1c2VybmFtZRgEIAEoCVIIdXNlcm5hbWUSJwoPdG90YWxfcmVmZXJyYWxzGAUgASgDUg50b3RhbFJlZmVycmFscxISCgRyYW5rGAYgASgFUgRyYW5rEjAKFHRvdGFsX3Jld2FyZHNfZWFybmVkGAcgASgFUhJ0b3RhbFJld2FyZHNFYXJuZWQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5EicKD3Byb2ZpbGVfcGljdHVyZRgJIAEoCVIOcHJvZmlsZVBpY3R1cmU=');
@$core.Deprecated('Use pointTransactionDescriptor instead')
const PointTransaction$json = const {
  '1': 'PointTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'points', '3': 3, '4': 1, '5': 5, '10': 'points'},
    const {'1': 'source', '3': 4, '4': 1, '5': 14, '6': '.pb.PointSource', '10': 'source'},
    const {'1': 'reference_id', '3': 5, '4': 1, '5': 9, '10': 'referenceId'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `PointTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointTransactionDescriptor = $convert.base64Decode('ChBQb2ludFRyYW5zYWN0aW9uEg4KAmlkGAEgASgEUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSFgoGcG9pbnRzGAMgASgFUgZwb2ludHMSJwoGc291cmNlGAQgASgOMg8ucGIuUG9pbnRTb3VyY2VSBnNvdXJjZRIhCgxyZWZlcmVuY2VfaWQYBSABKAlSC3JlZmVyZW5jZUlkEiAKC2Rlc2NyaXB0aW9uGAYgASgJUgtkZXNjcmlwdGlvbhI5CgpjcmVhdGVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');
@$core.Deprecated('Use pointsBalanceDescriptor instead')
const PointsBalance$json = const {
  '1': 'PointsBalance',
  '2': const [
    const {'1': 'total_earned', '3': 1, '4': 1, '5': 5, '10': 'totalEarned'},
    const {'1': 'total_redeemed', '3': 2, '4': 1, '5': 5, '10': 'totalRedeemed'},
    const {'1': 'current_balance', '3': 3, '4': 1, '5': 5, '10': 'currentBalance'},
    const {'1': 'tier', '3': 4, '4': 1, '5': 9, '10': 'tier'},
  ],
};

/// Descriptor for `PointsBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsBalanceDescriptor = $convert.base64Decode('Cg1Qb2ludHNCYWxhbmNlEiEKDHRvdGFsX2Vhcm5lZBgBIAEoBVILdG90YWxFYXJuZWQSJQoOdG90YWxfcmVkZWVtZWQYAiABKAVSDXRvdGFsUmVkZWVtZWQSJwoPY3VycmVudF9iYWxhbmNlGAMgASgFUg5jdXJyZW50QmFsYW5jZRISCgR0aWVyGAQgASgJUgR0aWVy');
@$core.Deprecated('Use pointsConfigEntryDescriptor instead')
const PointsConfigEntry$json = const {
  '1': 'PointsConfigEntry',
  '2': const [
    const {'1': 'source', '3': 1, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'points_amount', '3': 2, '4': 1, '5': 5, '10': 'pointsAmount'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'is_active', '3': 4, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `PointsConfigEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointsConfigEntryDescriptor = $convert.base64Decode('ChFQb2ludHNDb25maWdFbnRyeRIWCgZzb3VyY2UYASABKAlSBnNvdXJjZRIjCg1wb2ludHNfYW1vdW50GAIgASgFUgxwb2ludHNBbW91bnQSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhsKCWlzX2FjdGl2ZRgEIAEoCFIIaXNBY3RpdmU=');
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
    const {'1': 'filter', '3': 3, '4': 1, '5': 9, '10': 'filter'},
  ],
};

/// Descriptor for `GetMyReferralsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralsRequestDescriptor = $convert.base64Decode('ChVHZXRNeVJlZmVycmFsc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEhYKBmZpbHRlchgDIAEoCVIGZmlsdGVy');
@$core.Deprecated('Use getMyReferralsResponseDescriptor instead')
const GetMyReferralsResponse$json = const {
  '1': 'GetMyReferralsResponse',
  '2': const [
    const {'1': 'referrals', '3': 1, '4': 3, '5': 11, '6': '.pb.ReferralTransaction', '10': 'referrals'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'total_count', '3': 4, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetMyReferralsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyReferralsResponseDescriptor = $convert.base64Decode('ChZHZXRNeVJlZmVycmFsc1Jlc3BvbnNlEjUKCXJlZmVycmFscxgBIAMoCzIXLnBiLlJlZmVycmFsVHJhbnNhY3Rpb25SCXJlZmVycmFscxISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemUSHwoLdG90YWxfY291bnQYBCABKAVSCnRvdGFsQ291bnQ=');
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
@$core.Deprecated('Use getMyPointsBalanceRequestDescriptor instead')
const GetMyPointsBalanceRequest$json = const {
  '1': 'GetMyPointsBalanceRequest',
};

/// Descriptor for `GetMyPointsBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyPointsBalanceRequestDescriptor = $convert.base64Decode('ChlHZXRNeVBvaW50c0JhbGFuY2VSZXF1ZXN0');
@$core.Deprecated('Use getMyPointsBalanceResponseDescriptor instead')
const GetMyPointsBalanceResponse$json = const {
  '1': 'GetMyPointsBalanceResponse',
  '2': const [
    const {'1': 'balance', '3': 1, '4': 1, '5': 11, '6': '.pb.PointsBalance', '10': 'balance'},
  ],
};

/// Descriptor for `GetMyPointsBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyPointsBalanceResponseDescriptor = $convert.base64Decode('ChpHZXRNeVBvaW50c0JhbGFuY2VSZXNwb25zZRIrCgdiYWxhbmNlGAEgASgLMhEucGIuUG9pbnRzQmFsYW5jZVIHYmFsYW5jZQ==');
@$core.Deprecated('Use getMyPointsHistoryRequestDescriptor instead')
const GetMyPointsHistoryRequest$json = const {
  '1': 'GetMyPointsHistoryRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetMyPointsHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyPointsHistoryRequestDescriptor = $convert.base64Decode('ChlHZXRNeVBvaW50c0hpc3RvcnlSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAIgASgFUghwYWdlU2l6ZQ==');
@$core.Deprecated('Use getMyPointsHistoryResponseDescriptor instead')
const GetMyPointsHistoryResponse$json = const {
  '1': 'GetMyPointsHistoryResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.PointTransaction', '10': 'transactions'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'total_count', '3': 4, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetMyPointsHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyPointsHistoryResponseDescriptor = $convert.base64Decode('ChpHZXRNeVBvaW50c0hpc3RvcnlSZXNwb25zZRI4Cgx0cmFuc2FjdGlvbnMYASADKAsyFC5wYi5Qb2ludFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXplEh8KC3RvdGFsX2NvdW50GAQgASgFUgp0b3RhbENvdW50');
@$core.Deprecated('Use getPointsConfigRequestDescriptor instead')
const GetPointsConfigRequest$json = const {
  '1': 'GetPointsConfigRequest',
};

/// Descriptor for `GetPointsConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPointsConfigRequestDescriptor = $convert.base64Decode('ChZHZXRQb2ludHNDb25maWdSZXF1ZXN0');
@$core.Deprecated('Use getPointsConfigResponseDescriptor instead')
const GetPointsConfigResponse$json = const {
  '1': 'GetPointsConfigResponse',
  '2': const [
    const {'1': 'configs', '3': 1, '4': 3, '5': 11, '6': '.pb.PointsConfigEntry', '10': 'configs'},
  ],
};

/// Descriptor for `GetPointsConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPointsConfigResponseDescriptor = $convert.base64Decode('ChdHZXRQb2ludHNDb25maWdSZXNwb25zZRIvCgdjb25maWdzGAEgAygLMhUucGIuUG9pbnRzQ29uZmlnRW50cnlSB2NvbmZpZ3M=');
