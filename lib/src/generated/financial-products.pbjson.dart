///
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use autoSaveTriggerTypeDescriptor instead')
const AutoSaveTriggerType$json = const {
  '1': 'AutoSaveTriggerType',
  '2': const [
    const {'1': 'AUTO_SAVE_TRIGGER_UNKNOWN', '2': 0},
    const {'1': 'AUTO_SAVE_TRIGGER_ON_DEPOSIT', '2': 1},
    const {'1': 'AUTO_SAVE_TRIGGER_SCHEDULED', '2': 2},
    const {'1': 'AUTO_SAVE_TRIGGER_ROUND_UP', '2': 3},
  ],
};

/// Descriptor for `AutoSaveTriggerType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autoSaveTriggerTypeDescriptor = $convert.base64Decode('ChNBdXRvU2F2ZVRyaWdnZXJUeXBlEh0KGUFVVE9fU0FWRV9UUklHR0VSX1VOS05PV04QABIgChxBVVRPX1NBVkVfVFJJR0dFUl9PTl9ERVBPU0lUEAESHwobQVVUT19TQVZFX1RSSUdHRVJfU0NIRURVTEVEEAISHgoaQVVUT19TQVZFX1RSSUdHRVJfUk9VTkRfVVAQAw==');
@$core.Deprecated('Use autoSaveScheduleFrequencyDescriptor instead')
const AutoSaveScheduleFrequency$json = const {
  '1': 'AutoSaveScheduleFrequency',
  '2': const [
    const {'1': 'AUTO_SAVE_FREQUENCY_UNKNOWN', '2': 0},
    const {'1': 'AUTO_SAVE_FREQUENCY_DAILY', '2': 1},
    const {'1': 'AUTO_SAVE_FREQUENCY_WEEKLY', '2': 2},
    const {'1': 'AUTO_SAVE_FREQUENCY_BIWEEKLY', '2': 3},
    const {'1': 'AUTO_SAVE_FREQUENCY_MONTHLY', '2': 4},
  ],
};

/// Descriptor for `AutoSaveScheduleFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autoSaveScheduleFrequencyDescriptor = $convert.base64Decode('ChlBdXRvU2F2ZVNjaGVkdWxlRnJlcXVlbmN5Eh8KG0FVVE9fU0FWRV9GUkVRVUVOQ1lfVU5LTk9XThAAEh0KGUFVVE9fU0FWRV9GUkVRVUVOQ1lfREFJTFkQARIeChpBVVRPX1NBVkVfRlJFUVVFTkNZX1dFRUtMWRACEiAKHEFVVE9fU0FWRV9GUkVRVUVOQ1lfQklXRUVLTFkQAxIfChtBVVRPX1NBVkVfRlJFUVVFTkNZX01PTlRITFkQBA==');
@$core.Deprecated('Use autoSaveRuleStatusDescriptor instead')
const AutoSaveRuleStatus$json = const {
  '1': 'AutoSaveRuleStatus',
  '2': const [
    const {'1': 'AUTO_SAVE_STATUS_UNKNOWN', '2': 0},
    const {'1': 'AUTO_SAVE_STATUS_ACTIVE', '2': 1},
    const {'1': 'AUTO_SAVE_STATUS_PAUSED', '2': 2},
    const {'1': 'AUTO_SAVE_STATUS_COMPLETED', '2': 3},
    const {'1': 'AUTO_SAVE_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `AutoSaveRuleStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autoSaveRuleStatusDescriptor = $convert.base64Decode('ChJBdXRvU2F2ZVJ1bGVTdGF0dXMSHAoYQVVUT19TQVZFX1NUQVRVU19VTktOT1dOEAASGwoXQVVUT19TQVZFX1NUQVRVU19BQ1RJVkUQARIbChdBVVRPX1NBVkVfU1RBVFVTX1BBVVNFRBACEh4KGkFVVE9fU0FWRV9TVEFUVVNfQ09NUExFVEVEEAMSHgoaQVVUT19TQVZFX1NUQVRVU19DQU5DRUxMRUQQBA==');
@$core.Deprecated('Use autoSaveAmountTypeDescriptor instead')
const AutoSaveAmountType$json = const {
  '1': 'AutoSaveAmountType',
  '2': const [
    const {'1': 'AUTO_SAVE_AMOUNT_UNKNOWN', '2': 0},
    const {'1': 'AUTO_SAVE_AMOUNT_FIXED', '2': 1},
    const {'1': 'AUTO_SAVE_AMOUNT_PERCENTAGE', '2': 2},
  ],
};

/// Descriptor for `AutoSaveAmountType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autoSaveAmountTypeDescriptor = $convert.base64Decode('ChJBdXRvU2F2ZUFtb3VudFR5cGUSHAoYQVVUT19TQVZFX0FNT1VOVF9VTktOT1dOEAASGgoWQVVUT19TQVZFX0FNT1VOVF9GSVhFRBABEh8KG0FVVE9fU0FWRV9BTU9VTlRfUEVSQ0VOVEFHRRAC');
@$core.Deprecated('Use notificationChannelTypeDescriptor instead')
const NotificationChannelType$json = const {
  '1': 'NotificationChannelType',
  '2': const [
    const {'1': 'NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'NOTIFICATION_CHANNEL_TYPE_TELEGRAM', '2': 1},
    const {'1': 'NOTIFICATION_CHANNEL_TYPE_DISCORD', '2': 2},
    const {'1': 'NOTIFICATION_CHANNEL_TYPE_WHATSAPP_BUSINESS', '2': 3},
    const {'1': 'NOTIFICATION_CHANNEL_TYPE_SLACK', '2': 4},
  ],
};

/// Descriptor for `NotificationChannelType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List notificationChannelTypeDescriptor = $convert.base64Decode('ChdOb3RpZmljYXRpb25DaGFubmVsVHlwZRIpCiVOT1RJRklDQVRJT05fQ0hBTk5FTF9UWVBFX1VOU1BFQ0lGSUVEEAASJgoiTk9USUZJQ0FUSU9OX0NIQU5ORUxfVFlQRV9URUxFR1JBTRABEiUKIU5PVElGSUNBVElPTl9DSEFOTkVMX1RZUEVfRElTQ09SRBACEi8KK05PVElGSUNBVElPTl9DSEFOTkVMX1RZUEVfV0hBVFNBUFBfQlVTSU5FU1MQAxIjCh9OT1RJRklDQVRJT05fQ0hBTk5FTF9UWVBFX1NMQUNLEAQ=');
@$core.Deprecated('Use notificationChannelStatusDescriptor instead')
const NotificationChannelStatus$json = const {
  '1': 'NotificationChannelStatus',
  '2': const [
    const {'1': 'NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'NOTIFICATION_CHANNEL_STATUS_PENDING', '2': 1},
    const {'1': 'NOTIFICATION_CHANNEL_STATUS_ACTIVE', '2': 2},
    const {'1': 'NOTIFICATION_CHANNEL_STATUS_PAUSED', '2': 3},
    const {'1': 'NOTIFICATION_CHANNEL_STATUS_ERROR', '2': 4},
    const {'1': 'NOTIFICATION_CHANNEL_STATUS_DISCONNECTED', '2': 5},
  ],
};

/// Descriptor for `NotificationChannelStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List notificationChannelStatusDescriptor = $convert.base64Decode('ChlOb3RpZmljYXRpb25DaGFubmVsU3RhdHVzEisKJ05PVElGSUNBVElPTl9DSEFOTkVMX1NUQVRVU19VTlNQRUNJRklFRBAAEicKI05PVElGSUNBVElPTl9DSEFOTkVMX1NUQVRVU19QRU5ESU5HEAESJgoiTk9USUZJQ0FUSU9OX0NIQU5ORUxfU1RBVFVTX0FDVElWRRACEiYKIk5PVElGSUNBVElPTl9DSEFOTkVMX1NUQVRVU19QQVVTRUQQAxIlCiFOT1RJRklDQVRJT05fQ0hBTk5FTF9TVEFUVVNfRVJST1IQBBIsCihOT1RJRklDQVRJT05fQ0hBTk5FTF9TVEFUVVNfRElTQ09OTkVDVEVEEAU=');
@$core.Deprecated('Use notificationEventTypeDescriptor instead')
const NotificationEventType$json = const {
  '1': 'NotificationEventType',
  '2': const [
    const {'1': 'NOTIFICATION_EVENT_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'NOTIFICATION_EVENT_TYPE_NEW_DONATION', '2': 1},
    const {'1': 'NOTIFICATION_EVENT_TYPE_MILESTONE_REACHED', '2': 2},
    const {'1': 'NOTIFICATION_EVENT_TYPE_GOAL_REACHED', '2': 3},
    const {'1': 'NOTIFICATION_EVENT_TYPE_NEW_CONTRIBUTOR', '2': 4},
    const {'1': 'NOTIFICATION_EVENT_TYPE_LARGE_DONATION', '2': 5},
    const {'1': 'NOTIFICATION_EVENT_TYPE_DAILY_SUMMARY', '2': 6},
    const {'1': 'NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDING', '2': 7},
    const {'1': 'NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDED', '2': 8},
    const {'1': 'NOTIFICATION_EVENT_TYPE_WITHDRAWAL', '2': 9},
  ],
};

/// Descriptor for `NotificationEventType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List notificationEventTypeDescriptor = $convert.base64Decode('ChVOb3RpZmljYXRpb25FdmVudFR5cGUSJwojTk9USUZJQ0FUSU9OX0VWRU5UX1RZUEVfVU5TUEVDSUZJRUQQABIoCiROT1RJRklDQVRJT05fRVZFTlRfVFlQRV9ORVdfRE9OQVRJT04QARItCilOT1RJRklDQVRJT05fRVZFTlRfVFlQRV9NSUxFU1RPTkVfUkVBQ0hFRBACEigKJE5PVElGSUNBVElPTl9FVkVOVF9UWVBFX0dPQUxfUkVBQ0hFRBADEisKJ05PVElGSUNBVElPTl9FVkVOVF9UWVBFX05FV19DT05UUklCVVRPUhAEEioKJk5PVElGSUNBVElPTl9FVkVOVF9UWVBFX0xBUkdFX0RPTkFUSU9OEAUSKQolTk9USUZJQ0FUSU9OX0VWRU5UX1RZUEVfREFJTFlfU1VNTUFSWRAGEisKJ05PVElGSUNBVElPTl9FVkVOVF9UWVBFX0NBTVBBSUdOX0VORElORxAHEioKJk5PVElGSUNBVElPTl9FVkVOVF9UWVBFX0NBTVBBSUdOX0VOREVEEAgSJgoiTk9USUZJQ0FUSU9OX0VWRU5UX1RZUEVfV0lUSERSQVdBTBAJ');
@$core.Deprecated('Use leaderboardSortByDescriptor instead')
const LeaderboardSortBy$json = const {
  '1': 'LeaderboardSortBy',
  '2': const [
    const {'1': 'LEADERBOARD_SORT_UNSPECIFIED', '2': 0},
    const {'1': 'LEADERBOARD_SORT_MOST_FUNDED', '2': 1},
    const {'1': 'LEADERBOARD_SORT_MOST_DONORS', '2': 2},
    const {'1': 'LEADERBOARD_SORT_TRENDING', '2': 3},
    const {'1': 'LEADERBOARD_SORT_NEARLY_COMPLETE', '2': 4},
    const {'1': 'LEADERBOARD_SORT_NEWEST', '2': 5},
  ],
};

/// Descriptor for `LeaderboardSortBy`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List leaderboardSortByDescriptor = $convert.base64Decode('ChFMZWFkZXJib2FyZFNvcnRCeRIgChxMRUFERVJCT0FSRF9TT1JUX1VOU1BFQ0lGSUVEEAASIAocTEVBREVSQk9BUkRfU09SVF9NT1NUX0ZVTkRFRBABEiAKHExFQURFUkJPQVJEX1NPUlRfTU9TVF9ET05PUlMQAhIdChlMRUFERVJCT0FSRF9TT1JUX1RSRU5ESU5HEAMSJAogTEVBREVSQk9BUkRfU09SVF9ORUFSTFlfQ09NUExFVEUQBBIbChdMRUFERVJCT0FSRF9TT1JUX05FV0VTVBAF');
@$core.Deprecated('Use groupAccountDescriptor instead')
const GroupAccount$json = const {
  '1': 'GroupAccount',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'creator_id', '3': 4, '4': 1, '5': 9, '10': 'creatorId'},
    const {'1': 'balance', '3': 5, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'target_amount', '3': 6, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'members', '3': 8, '4': 3, '5': 11, '6': '.financialproducts.GroupMember', '10': 'members'},
    const {'1': 'withdrawal_rules', '3': 9, '4': 1, '5': 9, '10': 'withdrawalRules'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `GroupAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupAccountDescriptor = $convert.base64Decode('CgxHcm91cEFjY291bnQSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEh0KCmNyZWF0b3JfaWQYBCABKAlSCWNyZWF0b3JJZBIYCgdiYWxhbmNlGAUgASgBUgdiYWxhbmNlEiMKDXRhcmdldF9hbW91bnQYBiABKAFSDHRhcmdldEFtb3VudBIWCgZzdGF0dXMYByABKAlSBnN0YXR1cxI4CgdtZW1iZXJzGAggAygLMh4uZmluYW5jaWFscHJvZHVjdHMuR3JvdXBNZW1iZXJSB21lbWJlcnMSKQoQd2l0aGRyYXdhbF9ydWxlcxgJIAEoCVIPd2l0aGRyYXdhbFJ1bGVzEh0KCmNyZWF0ZWRfYXQYCiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAsgASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use groupMemberDescriptor instead')
const GroupMember$json = const {
  '1': 'GroupMember',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'contribution', '3': 4, '4': 1, '5': 1, '10': 'contribution'},
    const {'1': 'joined_at', '3': 5, '4': 1, '5': 9, '10': 'joinedAt'},
  ],
};

/// Descriptor for `GroupMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupMemberDescriptor = $convert.base64Decode('CgtHcm91cE1lbWJlchIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSEgoEbmFtZRgCIAEoCVIEbmFtZRISCgRyb2xlGAMgASgJUgRyb2xlEiIKDGNvbnRyaWJ1dGlvbhgEIAEoAVIMY29udHJpYnV0aW9uEhsKCWpvaW5lZF9hdBgFIAEoCVIIam9pbmVkQXQ=');
@$core.Deprecated('Use insuranceDescriptor instead')
const Insurance$json = const {
  '1': 'Insurance',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'policy_number', '3': 4, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'plan_id', '3': 5, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'plan_name', '3': 6, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'coverage_type', '3': 7, '4': 1, '5': 9, '10': 'coverageType'},
    const {'1': 'premium', '3': 8, '4': 1, '5': 1, '10': 'premium'},
    const {'1': 'coverage_amount', '3': 9, '4': 1, '5': 1, '10': 'coverageAmount'},
    const {'1': 'payment_frequency', '3': 10, '4': 1, '5': 9, '10': 'paymentFrequency'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'start_date', '3': 12, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 13, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'next_payment_date', '3': 14, '4': 1, '5': 9, '10': 'nextPaymentDate'},
    const {'1': 'beneficiary', '3': 15, '4': 1, '5': 9, '10': 'beneficiary'},
    const {'1': 'metadata', '3': 16, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Insurance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceDescriptor = $convert.base64Decode('CglJbnN1cmFuY2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSIwoNcG9saWN5X251bWJlchgEIAEoCVIMcG9saWN5TnVtYmVyEhcKB3BsYW5faWQYBSABKAlSBnBsYW5JZBIbCglwbGFuX25hbWUYBiABKAlSCHBsYW5OYW1lEiMKDWNvdmVyYWdlX3R5cGUYByABKAlSDGNvdmVyYWdlVHlwZRIYCgdwcmVtaXVtGAggASgBUgdwcmVtaXVtEicKD2NvdmVyYWdlX2Ftb3VudBgJIAEoAVIOY292ZXJhZ2VBbW91bnQSKwoRcGF5bWVudF9mcmVxdWVuY3kYCiABKAlSEHBheW1lbnRGcmVxdWVuY3kSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSHQoKc3RhcnRfZGF0ZRgMIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGA0gASgJUgdlbmREYXRlEioKEW5leHRfcGF5bWVudF9kYXRlGA4gASgJUg9uZXh0UGF5bWVudERhdGUSIAoLYmVuZWZpY2lhcnkYDyABKAlSC2JlbmVmaWNpYXJ5EhoKCG1ldGFkYXRhGBAgASgJUghtZXRhZGF0YRIdCgpjcmVhdGVkX2F0GBEgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgSIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use insurancePlanDescriptor instead')
const InsurancePlan$json = const {
  '1': 'InsurancePlan',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'coverage_type', '3': 3, '4': 1, '5': 9, '10': 'coverageType'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'min_premium', '3': 5, '4': 1, '5': 1, '10': 'minPremium'},
    const {'1': 'max_premium', '3': 6, '4': 1, '5': 1, '10': 'maxPremium'},
    const {'1': 'coverage_amount', '3': 7, '4': 1, '5': 1, '10': 'coverageAmount'},
    const {'1': 'benefits', '3': 8, '4': 3, '5': 9, '10': 'benefits'},
    const {'1': 'terms', '3': 9, '4': 1, '5': 9, '10': 'terms'},
    const {'1': 'is_active', '3': 10, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `InsurancePlan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePlanDescriptor = $convert.base64Decode('Cg1JbnN1cmFuY2VQbGFuEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiMKDWNvdmVyYWdlX3R5cGUYAyABKAlSDGNvdmVyYWdlVHlwZRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SHwoLbWluX3ByZW1pdW0YBSABKAFSCm1pblByZW1pdW0SHwoLbWF4X3ByZW1pdW0YBiABKAFSCm1heFByZW1pdW0SJwoPY292ZXJhZ2VfYW1vdW50GAcgASgBUg5jb3ZlcmFnZUFtb3VudBIaCghiZW5lZml0cxgIIAMoCVIIYmVuZWZpdHMSFAoFdGVybXMYCSABKAlSBXRlcm1zEhsKCWlzX2FjdGl2ZRgKIAEoCFIIaXNBY3RpdmU=');
@$core.Deprecated('Use insuranceClaimDescriptor instead')
const InsuranceClaim$json = const {
  '1': 'InsuranceClaim',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'policy_id', '3': 2, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'claim_amount', '3': 4, '4': 1, '5': 1, '10': 'claimAmount'},
    const {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'documents', '3': 7, '4': 1, '5': 9, '10': 'documents'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `InsuranceClaim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceClaimDescriptor = $convert.base64Decode('Cg5JbnN1cmFuY2VDbGFpbRIOCgJpZBgBIAEoCVICaWQSGwoJcG9saWN5X2lkGAIgASgJUghwb2xpY3lJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSIQoMY2xhaW1fYW1vdW50GAQgASgBUgtjbGFpbUFtb3VudBIWCgZyZWFzb24YBSABKAlSBnJlYXNvbhIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIcCglkb2N1bWVudHMYByABKAlSCWRvY3VtZW50cxIdCgpjcmVhdGVkX2F0GAggASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgJIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use crowdfundDescriptor instead')
const Crowdfund$json = const {
  '1': 'Crowdfund',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'target_amount', '3': 7, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'current_amount', '3': 8, '4': 1, '5': 1, '10': 'currentAmount'},
    const {'1': 'percentage_funded', '3': 9, '4': 1, '5': 1, '10': 'percentageFunded'},
    const {'1': 'total_contributors', '3': 10, '4': 1, '5': 5, '10': 'totalContributors'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'image_url', '3': 12, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'deadline', '3': 13, '4': 1, '5': 9, '10': 'deadline'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'crowdfund_code', '3': 16, '4': 1, '5': 9, '10': 'crowdfundCode'},
    const {'1': 'creator_first_name', '3': 17, '4': 1, '5': 9, '10': 'creatorFirstName'},
    const {'1': 'creator_last_name', '3': 18, '4': 1, '5': 9, '10': 'creatorLastName'},
    const {'1': 'creator_username', '3': 19, '4': 1, '5': 9, '10': 'creatorUsername'},
    const {'1': 'creator_email', '3': 20, '4': 1, '5': 9, '10': 'creatorEmail'},
  ],
};

/// Descriptor for `Crowdfund`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundDescriptor = $convert.base64Decode('CglDcm93ZGZ1bmQSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSFAoFdGl0bGUYBCABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIaCghjYXRlZ29yeRgGIAEoCVIIY2F0ZWdvcnkSIwoNdGFyZ2V0X2Ftb3VudBgHIAEoAVIMdGFyZ2V0QW1vdW50EiUKDmN1cnJlbnRfYW1vdW50GAggASgBUg1jdXJyZW50QW1vdW50EisKEXBlcmNlbnRhZ2VfZnVuZGVkGAkgASgBUhBwZXJjZW50YWdlRnVuZGVkEi0KEnRvdGFsX2NvbnRyaWJ1dG9ycxgKIAEoBVIRdG90YWxDb250cmlidXRvcnMSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSGwoJaW1hZ2VfdXJsGAwgASgJUghpbWFnZVVybBIaCghkZWFkbGluZRgNIAEoCVIIZGVhZGxpbmUSHQoKY3JlYXRlZF9hdBgOIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYDyABKAlSCXVwZGF0ZWRBdBIlCg5jcm93ZGZ1bmRfY29kZRgQIAEoCVINY3Jvd2RmdW5kQ29kZRIsChJjcmVhdG9yX2ZpcnN0X25hbWUYESABKAlSEGNyZWF0b3JGaXJzdE5hbWUSKgoRY3JlYXRvcl9sYXN0X25hbWUYEiABKAlSD2NyZWF0b3JMYXN0TmFtZRIpChBjcmVhdG9yX3VzZXJuYW1lGBMgASgJUg9jcmVhdG9yVXNlcm5hbWUSIwoNY3JlYXRvcl9lbWFpbBgUIAEoCVIMY3JlYXRvckVtYWls');
@$core.Deprecated('Use crowdfundContributionDescriptor instead')
const CrowdfundContribution$json = const {
  '1': 'CrowdfundContribution',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'crowdfund_id', '3': 2, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_anonymous', '3': 6, '4': 1, '5': 8, '10': 'isAnonymous'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `CrowdfundContribution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundContributionDescriptor = $convert.base64Decode('ChVDcm93ZGZ1bmRDb250cmlidXRpb24SDgoCaWQYASABKAlSAmlkEiEKDGNyb3dkZnVuZF9pZBgCIAEoCVILY3Jvd2RmdW5kSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2USIQoMaXNfYW5vbnltb3VzGAYgASgIUgtpc0Fub255bW91cxIdCgpjcmVhdGVkX2F0GAcgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use createGroupAccountRequestDescriptor instead')
const CreateGroupAccountRequest$json = const {
  '1': 'CreateGroupAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'target_amount', '3': 4, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'withdrawal_rules', '3': 5, '4': 1, '5': 9, '10': 'withdrawalRules'},
    const {'1': 'member_ids', '3': 6, '4': 3, '5': 9, '10': 'memberIds'},
  ],
};

/// Descriptor for `CreateGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupAccountRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVHcm91cEFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIjCg10YXJnZXRfYW1vdW50GAQgASgBUgx0YXJnZXRBbW91bnQSKQoQd2l0aGRyYXdhbF9ydWxlcxgFIAEoCVIPd2l0aGRyYXdhbFJ1bGVzEh0KCm1lbWJlcl9pZHMYBiADKAlSCW1lbWJlcklkcw==');
@$core.Deprecated('Use createGroupAccountResponseDescriptor instead')
const CreateGroupAccountResponse$json = const {
  '1': 'CreateGroupAccountResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupAccountResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVHcm91cEFjY291bnRSZXNwb25zZRJECg1ncm91cF9hY2NvdW50GAEgASgLMh8uZmluYW5jaWFscHJvZHVjdHMuR3JvdXBBY2NvdW50Ugxncm91cEFjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getGroupAccountsRequestDescriptor instead')
const GetGroupAccountsRequest$json = const {
  '1': 'GetGroupAccountsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetGroupAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountsRequestDescriptor = $convert.base64Decode('ChdHZXRHcm91cEFjY291bnRzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getGroupAccountsResponseDescriptor instead')
const GetGroupAccountsResponse$json = const {
  '1': 'GetGroupAccountsResponse',
  '2': const [
    const {'1': 'group_accounts', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccounts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetGroupAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountsResponseDescriptor = $convert.base64Decode('ChhHZXRHcm91cEFjY291bnRzUmVzcG9uc2USRgoOZ3JvdXBfYWNjb3VudHMYASADKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDWdyb3VwQWNjb3VudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getGroupAccountRequestDescriptor instead')
const GetGroupAccountRequest$json = const {
  '1': 'GetGroupAccountRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountRequestDescriptor = $convert.base64Decode('ChZHZXRHcm91cEFjY291bnRSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');
@$core.Deprecated('Use getGroupAccountResponseDescriptor instead')
const GetGroupAccountResponse$json = const {
  '1': 'GetGroupAccountResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
  ],
};

/// Descriptor for `GetGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountResponseDescriptor = $convert.base64Decode('ChdHZXRHcm91cEFjY291bnRSZXNwb25zZRJECg1ncm91cF9hY2NvdW50GAEgASgLMh8uZmluYW5jaWFscHJvZHVjdHMuR3JvdXBBY2NvdW50Ugxncm91cEFjY291bnQ=');
@$core.Deprecated('Use addGroupMemberRequestDescriptor instead')
const AddGroupMemberRequest$json = const {
  '1': 'AddGroupMemberRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `AddGroupMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupMemberRequestDescriptor = $convert.base64Decode('ChVBZGRHcm91cE1lbWJlclJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBISCgRyb2xlGAMgASgJUgRyb2xl');
@$core.Deprecated('Use addGroupMemberResponseDescriptor instead')
const AddGroupMemberResponse$json = const {
  '1': 'AddGroupMemberResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AddGroupMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupMemberResponseDescriptor = $convert.base64Decode('ChZBZGRHcm91cE1lbWJlclJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use removeGroupMemberRequestDescriptor instead')
const RemoveGroupMemberRequest$json = const {
  '1': 'RemoveGroupMemberRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
  ],
};

/// Descriptor for `RemoveGroupMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeGroupMemberRequestDescriptor = $convert.base64Decode('ChhSZW1vdmVHcm91cE1lbWJlclJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZA==');
@$core.Deprecated('Use removeGroupMemberResponseDescriptor instead')
const RemoveGroupMemberResponse$json = const {
  '1': 'RemoveGroupMemberResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemoveGroupMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeGroupMemberResponseDescriptor = $convert.base64Decode('ChlSZW1vdmVHcm91cE1lbWJlclJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use contributeToGroupRequestDescriptor instead')
const ContributeToGroupRequest$json = const {
  '1': 'ContributeToGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'pin', '3': 4, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `ContributeToGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToGroupRequestDescriptor = $convert.base64Decode('ChhDb250cmlidXRlVG9Hcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhAKA3BpbhgEIAEoCVIDcGlu');
@$core.Deprecated('Use contributeToGroupResponseDescriptor instead')
const ContributeToGroupResponse$json = const {
  '1': 'ContributeToGroupResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ContributeToGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToGroupResponseDescriptor = $convert.base64Decode('ChlDb250cmlidXRlVG9Hcm91cFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use withdrawFromGroupRequestDescriptor instead')
const WithdrawFromGroupRequest$json = const {
  '1': 'WithdrawFromGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'pin', '3': 4, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `WithdrawFromGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromGroupRequestDescriptor = $convert.base64Decode('ChhXaXRoZHJhd0Zyb21Hcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSFgoGcmVhc29uGAMgASgJUgZyZWFzb24SEAoDcGluGAQgASgJUgNwaW4=');
@$core.Deprecated('Use withdrawFromGroupResponseDescriptor instead')
const WithdrawFromGroupResponse$json = const {
  '1': 'WithdrawFromGroupResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawFromGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromGroupResponseDescriptor = $convert.base64Decode('ChlXaXRoZHJhd0Zyb21Hcm91cFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use closeGroupAccountRequestDescriptor instead')
const CloseGroupAccountRequest$json = const {
  '1': 'CloseGroupAccountRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `CloseGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeGroupAccountRequestDescriptor = $convert.base64Decode('ChhDbG9zZUdyb3VwQWNjb3VudFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSEAoDcGluGAIgASgJUgNwaW4=');
@$core.Deprecated('Use closeGroupAccountResponseDescriptor instead')
const CloseGroupAccountResponse$json = const {
  '1': 'CloseGroupAccountResponse',
  '2': const [
    const {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CloseGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeGroupAccountResponseDescriptor = $convert.base64Decode('ChlDbG9zZUdyb3VwQWNjb3VudFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use buyInsuranceRequestDescriptor instead')
const BuyInsuranceRequest$json = const {
  '1': 'BuyInsuranceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'plan_id', '3': 2, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'coverage_amount', '3': 3, '4': 1, '5': 1, '10': 'coverageAmount'},
    const {'1': 'payment_frequency', '3': 4, '4': 1, '5': 9, '10': 'paymentFrequency'},
    const {'1': 'beneficiary', '3': 5, '4': 1, '5': 9, '10': 'beneficiary'},
    const {'1': 'pin', '3': 6, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `BuyInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyInsuranceRequestDescriptor = $convert.base64Decode('ChNCdXlJbnN1cmFuY2VSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIXCgdwbGFuX2lkGAIgASgJUgZwbGFuSWQSJwoPY292ZXJhZ2VfYW1vdW50GAMgASgBUg5jb3ZlcmFnZUFtb3VudBIrChFwYXltZW50X2ZyZXF1ZW5jeRgEIAEoCVIQcGF5bWVudEZyZXF1ZW5jeRIgCgtiZW5lZmljaWFyeRgFIAEoCVILYmVuZWZpY2lhcnkSEAoDcGluGAYgASgJUgNwaW4=');
@$core.Deprecated('Use buyInsuranceResponseDescriptor instead')
const BuyInsuranceResponse$json = const {
  '1': 'BuyInsuranceResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
    const {'1': 'first_premium', '3': 2, '4': 1, '5': 1, '10': 'firstPremium'},
    const {'1': 'new_balance', '3': 3, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyInsuranceResponseDescriptor = $convert.base64Decode('ChRCdXlJbnN1cmFuY2VSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZRIjCg1maXJzdF9wcmVtaXVtGAIgASgBUgxmaXJzdFByZW1pdW0SHwoLbmV3X2JhbGFuY2UYAyABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getInsurancePoliciesRequestDescriptor instead')
const GetInsurancePoliciesRequest$json = const {
  '1': 'GetInsurancePoliciesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInsurancePoliciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePoliciesRequestDescriptor = $convert.base64Decode('ChtHZXRJbnN1cmFuY2VQb2xpY2llc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getInsurancePoliciesResponseDescriptor instead')
const GetInsurancePoliciesResponse$json = const {
  '1': 'GetInsurancePoliciesResponse',
  '2': const [
    const {'1': 'policies', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.Insurance', '10': 'policies'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_coverage', '3': 3, '4': 1, '5': 1, '10': 'totalCoverage'},
    const {'1': 'total_premiums_paid', '3': 4, '4': 1, '5': 1, '10': 'totalPremiumsPaid'},
  ],
};

/// Descriptor for `GetInsurancePoliciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePoliciesResponseDescriptor = $convert.base64Decode('ChxHZXRJbnN1cmFuY2VQb2xpY2llc1Jlc3BvbnNlEjgKCHBvbGljaWVzGAEgAygLMhwuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUghwb2xpY2llcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSJQoOdG90YWxfY292ZXJhZ2UYAyABKAFSDXRvdGFsQ292ZXJhZ2USLgoTdG90YWxfcHJlbWl1bXNfcGFpZBgEIAEoAVIRdG90YWxQcmVtaXVtc1BhaWQ=');
@$core.Deprecated('Use getInsurancePolicyRequestDescriptor instead')
const GetInsurancePolicyRequest$json = const {
  '1': 'GetInsurancePolicyRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
  ],
};

/// Descriptor for `GetInsurancePolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePolicyRequestDescriptor = $convert.base64Decode('ChlHZXRJbnN1cmFuY2VQb2xpY3lSZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQ=');
@$core.Deprecated('Use getInsurancePolicyResponseDescriptor instead')
const GetInsurancePolicyResponse$json = const {
  '1': 'GetInsurancePolicyResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `GetInsurancePolicyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePolicyResponseDescriptor = $convert.base64Decode('ChpHZXRJbnN1cmFuY2VQb2xpY3lSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZQ==');
@$core.Deprecated('Use makeInsuranceClaimRequestDescriptor instead')
const MakeInsuranceClaimRequest$json = const {
  '1': 'MakeInsuranceClaimRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'claim_amount', '3': 2, '4': 1, '5': 1, '10': 'claimAmount'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'documents', '3': 4, '4': 3, '5': 9, '10': 'documents'},
    const {'1': 'claim_type', '3': 5, '4': 1, '5': 9, '10': 'claimType'},
    const {'1': 'title', '3': 6, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'incident_date', '3': 7, '4': 1, '5': 9, '10': 'incidentDate'},
    const {'1': 'incident_location', '3': 8, '4': 1, '5': 9, '10': 'incidentLocation'},
    const {'1': 'additional_info', '3': 9, '4': 3, '5': 11, '6': '.financialproducts.MakeInsuranceClaimRequest.AdditionalInfoEntry', '10': 'additionalInfo'},
    const {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'attachments', '3': 12, '4': 3, '5': 9, '10': 'attachments'},
  ],
  '3': const [MakeInsuranceClaimRequest_AdditionalInfoEntry$json],
};

@$core.Deprecated('Use makeInsuranceClaimRequestDescriptor instead')
const MakeInsuranceClaimRequest_AdditionalInfoEntry$json = const {
  '1': 'AdditionalInfoEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `MakeInsuranceClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeInsuranceClaimRequestDescriptor = $convert.base64Decode('ChlNYWtlSW5zdXJhbmNlQ2xhaW1SZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQSIQoMY2xhaW1fYW1vdW50GAIgASgBUgtjbGFpbUFtb3VudBIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhIcCglkb2N1bWVudHMYBCADKAlSCWRvY3VtZW50cxIdCgpjbGFpbV90eXBlGAUgASgJUgljbGFpbVR5cGUSFAoFdGl0bGUYBiABKAlSBXRpdGxlEiMKDWluY2lkZW50X2RhdGUYByABKAlSDGluY2lkZW50RGF0ZRIrChFpbmNpZGVudF9sb2NhdGlvbhgIIAEoCVIQaW5jaWRlbnRMb2NhdGlvbhJpCg9hZGRpdGlvbmFsX2luZm8YCSADKAsyQC5maW5hbmNpYWxwcm9kdWN0cy5NYWtlSW5zdXJhbmNlQ2xhaW1SZXF1ZXN0LkFkZGl0aW9uYWxJbmZvRW50cnlSDmFkZGl0aW9uYWxJbmZvEicKD2lkZW1wb3RlbmN5X2tleRgKIAEoCVIOaWRlbXBvdGVuY3lLZXkSGgoIY3VycmVuY3kYCyABKAlSCGN1cnJlbmN5EiAKC2F0dGFjaG1lbnRzGAwgAygJUgthdHRhY2htZW50cxpBChNBZGRpdGlvbmFsSW5mb0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use makeInsuranceClaimResponseDescriptor instead')
const MakeInsuranceClaimResponse$json = const {
  '1': 'MakeInsuranceClaimResponse',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsuranceClaimRecord', '10': 'claim'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MakeInsuranceClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeInsuranceClaimResponseDescriptor = $convert.base64Decode('ChpNYWtlSW5zdXJhbmNlQ2xhaW1SZXNwb25zZRI9CgVjbGFpbRgBIAEoCzInLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZUNsYWltUmVjb3JkUgVjbGFpbRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use cancelInsuranceRequestDescriptor instead')
const CancelInsuranceRequest$json = const {
  '1': 'CancelInsuranceRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInsuranceRequestDescriptor = $convert.base64Decode('ChZDYW5jZWxJbnN1cmFuY2VSZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');
@$core.Deprecated('Use cancelInsuranceResponseDescriptor instead')
const CancelInsuranceResponse$json = const {
  '1': 'CancelInsuranceResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInsuranceResponseDescriptor = $convert.base64Decode('ChdDYW5jZWxJbnN1cmFuY2VSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getInsurancePlansRequestDescriptor instead')
const GetInsurancePlansRequest$json = const {
  '1': 'GetInsurancePlansRequest',
  '2': const [
    const {'1': 'coverage_type', '3': 1, '4': 1, '5': 9, '10': 'coverageType'},
  ],
};

/// Descriptor for `GetInsurancePlansRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePlansRequestDescriptor = $convert.base64Decode('ChhHZXRJbnN1cmFuY2VQbGFuc1JlcXVlc3QSIwoNY292ZXJhZ2VfdHlwZRgBIAEoCVIMY292ZXJhZ2VUeXBl');
@$core.Deprecated('Use getInsurancePlansResponseDescriptor instead')
const GetInsurancePlansResponse$json = const {
  '1': 'GetInsurancePlansResponse',
  '2': const [
    const {'1': 'plans', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsurancePlan', '10': 'plans'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInsurancePlansResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePlansResponseDescriptor = $convert.base64Decode('ChlHZXRJbnN1cmFuY2VQbGFuc1Jlc3BvbnNlEjYKBXBsYW5zGAEgAygLMiAuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUGxhblIFcGxhbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use marketplaceProductFormFieldDescriptor instead')
const MarketplaceProductFormField$json = const {
  '1': 'MarketplaceProductFormField',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'required', '3': 4, '4': 1, '5': 8, '10': 'required'},
    const {'1': 'options', '3': 5, '4': 3, '5': 9, '10': 'options'},
    const {'1': 'default_value', '3': 6, '4': 1, '5': 9, '10': 'defaultValue'},
    const {'1': 'validation_regex', '3': 7, '4': 1, '5': 9, '10': 'validationRegex'},
    const {'1': 'placeholder', '3': 8, '4': 1, '5': 9, '10': 'placeholder'},
    const {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `MarketplaceProductFormField`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketplaceProductFormFieldDescriptor = $convert.base64Decode('ChtNYXJrZXRwbGFjZVByb2R1Y3RGb3JtRmllbGQSEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgVsYWJlbBgCIAEoCVIFbGFiZWwSEgoEdHlwZRgDIAEoCVIEdHlwZRIaCghyZXF1aXJlZBgEIAEoCFIIcmVxdWlyZWQSGAoHb3B0aW9ucxgFIAMoCVIHb3B0aW9ucxIjCg1kZWZhdWx0X3ZhbHVlGAYgASgJUgxkZWZhdWx0VmFsdWUSKQoQdmFsaWRhdGlvbl9yZWdleBgHIAEoCVIPdmFsaWRhdGlvblJlZ2V4EiAKC3BsYWNlaG9sZGVyGAggASgJUgtwbGFjZWhvbGRlchIgCgtkZXNjcmlwdGlvbhgJIAEoCVILZGVzY3JpcHRpb24=');
@$core.Deprecated('Use marketplaceInsuranceProductDescriptor instead')
const MarketplaceInsuranceProduct$json = const {
  '1': 'MarketplaceInsuranceProduct',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'provider_name', '3': 5, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'provider_logo', '3': 6, '4': 1, '5': 9, '10': 'providerLogo'},
    const {'1': 'min_premium', '3': 7, '4': 1, '5': 1, '10': 'minPremium'},
    const {'1': 'max_premium', '3': 8, '4': 1, '5': 1, '10': 'maxPremium'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'benefits', '3': 10, '4': 3, '5': 9, '10': 'benefits'},
    const {'1': 'terms_url', '3': 11, '4': 1, '5': 9, '10': 'termsUrl'},
    const {'1': 'metadata', '3': 12, '4': 3, '5': 11, '6': '.financialproducts.MarketplaceInsuranceProduct.MetadataEntry', '10': 'metadata'},
    const {'1': 'form_fields', '3': 13, '4': 3, '5': 11, '6': '.financialproducts.MarketplaceProductFormField', '10': 'formFields'},
    const {'1': 'is_active', '3': 14, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'purchase_route', '3': 15, '4': 1, '5': 9, '10': 'purchaseRoute'},
    const {'1': 'provider_id', '3': 16, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'base_price', '3': 17, '4': 1, '5': 1, '10': 'basePrice'},
    const {'1': 'how_it_works', '3': 18, '4': 1, '5': 9, '10': 'howItWorks'},
    const {'1': 'full_benefits', '3': 19, '4': 1, '5': 9, '10': 'fullBenefits'},
    const {'1': 'is_renewable', '3': 20, '4': 1, '5': 8, '10': 'isRenewable'},
    const {'1': 'is_claimable', '3': 21, '4': 1, '5': 8, '10': 'isClaimable'},
  ],
  '3': const [MarketplaceInsuranceProduct_MetadataEntry$json],
};

@$core.Deprecated('Use marketplaceInsuranceProductDescriptor instead')
const MarketplaceInsuranceProduct_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `MarketplaceInsuranceProduct`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketplaceInsuranceProductDescriptor = $convert.base64Decode('ChtNYXJrZXRwbGFjZUluc3VyYW5jZVByb2R1Y3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIjCg1wcm92aWRlcl9uYW1lGAUgASgJUgxwcm92aWRlck5hbWUSIwoNcHJvdmlkZXJfbG9nbxgGIAEoCVIMcHJvdmlkZXJMb2dvEh8KC21pbl9wcmVtaXVtGAcgASgBUgptaW5QcmVtaXVtEh8KC21heF9wcmVtaXVtGAggASgBUgptYXhQcmVtaXVtEhoKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeRIaCghiZW5lZml0cxgKIAMoCVIIYmVuZWZpdHMSGwoJdGVybXNfdXJsGAsgASgJUgh0ZXJtc1VybBJYCghtZXRhZGF0YRgMIAMoCzI8LmZpbmFuY2lhbHByb2R1Y3RzLk1hcmtldHBsYWNlSW5zdXJhbmNlUHJvZHVjdC5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRJPCgtmb3JtX2ZpZWxkcxgNIAMoCzIuLmZpbmFuY2lhbHByb2R1Y3RzLk1hcmtldHBsYWNlUHJvZHVjdEZvcm1GaWVsZFIKZm9ybUZpZWxkcxIbCglpc19hY3RpdmUYDiABKAhSCGlzQWN0aXZlEiUKDnB1cmNoYXNlX3JvdXRlGA8gASgJUg1wdXJjaGFzZVJvdXRlEh8KC3Byb3ZpZGVyX2lkGBAgASgJUgpwcm92aWRlcklkEh0KCmJhc2VfcHJpY2UYESABKAFSCWJhc2VQcmljZRIgCgxob3dfaXRfd29ya3MYEiABKAlSCmhvd0l0V29ya3MSIwoNZnVsbF9iZW5lZml0cxgTIAEoCVIMZnVsbEJlbmVmaXRzEiEKDGlzX3JlbmV3YWJsZRgUIAEoCFILaXNSZW5ld2FibGUSIQoMaXNfY2xhaW1hYmxlGBUgASgIUgtpc0NsYWltYWJsZRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use marketplaceInsuranceCategoryDescriptor instead')
const MarketplaceInsuranceCategory$json = const {
  '1': 'MarketplaceInsuranceCategory',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'icon', '3': 3, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'product_count', '3': 5, '4': 1, '5': 5, '10': 'productCount'},
  ],
};

/// Descriptor for `MarketplaceInsuranceCategory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketplaceInsuranceCategoryDescriptor = $convert.base64Decode('ChxNYXJrZXRwbGFjZUluc3VyYW5jZUNhdGVnb3J5Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhIKBGljb24YAyABKAlSBGljb24SIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEiMKDXByb2R1Y3RfY291bnQYBSABKAVSDHByb2R1Y3RDb3VudA==');
@$core.Deprecated('Use marketplaceInsuranceQuoteDescriptor instead')
const MarketplaceInsuranceQuote$json = const {
  '1': 'MarketplaceInsuranceQuote',
  '2': const [
    const {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    const {'1': 'product_id', '3': 2, '4': 1, '5': 9, '10': 'productId'},
    const {'1': 'premium', '3': 3, '4': 1, '5': 1, '10': 'premium'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'coverage_summary', '3': 5, '4': 1, '5': 9, '10': 'coverageSummary'},
    const {'1': 'coverage_items', '3': 6, '4': 3, '5': 9, '10': 'coverageItems'},
    const {'1': 'valid_until', '3': 7, '4': 1, '5': 9, '10': 'validUntil'},
    const {'1': 'quote_details', '3': 8, '4': 3, '5': 11, '6': '.financialproducts.MarketplaceInsuranceQuote.QuoteDetailsEntry', '10': 'quoteDetails'},
  ],
  '3': const [MarketplaceInsuranceQuote_QuoteDetailsEntry$json],
};

@$core.Deprecated('Use marketplaceInsuranceQuoteDescriptor instead')
const MarketplaceInsuranceQuote_QuoteDetailsEntry$json = const {
  '1': 'QuoteDetailsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `MarketplaceInsuranceQuote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketplaceInsuranceQuoteDescriptor = $convert.base64Decode('ChlNYXJrZXRwbGFjZUluc3VyYW5jZVF1b3RlEhkKCHF1b3RlX2lkGAEgASgJUgdxdW90ZUlkEh0KCnByb2R1Y3RfaWQYAiABKAlSCXByb2R1Y3RJZBIYCgdwcmVtaXVtGAMgASgBUgdwcmVtaXVtEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIpChBjb3ZlcmFnZV9zdW1tYXJ5GAUgASgJUg9jb3ZlcmFnZVN1bW1hcnkSJQoOY292ZXJhZ2VfaXRlbXMYBiADKAlSDWNvdmVyYWdlSXRlbXMSHwoLdmFsaWRfdW50aWwYByABKAlSCnZhbGlkVW50aWwSYwoNcXVvdGVfZGV0YWlscxgIIAMoCzI+LmZpbmFuY2lhbHByb2R1Y3RzLk1hcmtldHBsYWNlSW5zdXJhbmNlUXVvdGUuUXVvdGVEZXRhaWxzRW50cnlSDHF1b3RlRGV0YWlscxo/ChFRdW90ZURldGFpbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use marketplaceInsurancePurchaseResultDescriptor instead')
const MarketplaceInsurancePurchaseResult$json = const {
  '1': 'MarketplaceInsurancePurchaseResult',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'policy_number', '3': 2, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'provider_reference', '3': 5, '4': 1, '5': 9, '10': 'providerReference'},
    const {'1': 'insurance', '3': 6, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `MarketplaceInsurancePurchaseResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List marketplaceInsurancePurchaseResultDescriptor = $convert.base64Decode('CiJNYXJrZXRwbGFjZUluc3VyYW5jZVB1cmNoYXNlUmVzdWx0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQSIwoNcG9saWN5X251bWJlchgCIAEoCVIMcG9saWN5TnVtYmVyEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVzEi0KEnByb3ZpZGVyX3JlZmVyZW5jZRgFIAEoCVIRcHJvdmlkZXJSZWZlcmVuY2USOgoJaW5zdXJhbmNlGAYgASgLMhwuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUglpbnN1cmFuY2U=');
@$core.Deprecated('Use getInsuranceMarketplaceProductsRequestDescriptor instead')
const GetInsuranceMarketplaceProductsRequest$json = const {
  '1': 'GetInsuranceMarketplaceProductsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'locale', '3': 2, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInsuranceMarketplaceProductsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceMarketplaceProductsRequestDescriptor = $convert.base64Decode('CiZHZXRJbnN1cmFuY2VNYXJrZXRwbGFjZVByb2R1Y3RzUmVxdWVzdBIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnkSFgoGbG9jYWxlGAIgASgJUgZsb2NhbGUSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getInsuranceMarketplaceProductsResponseDescriptor instead')
const GetInsuranceMarketplaceProductsResponse$json = const {
  '1': 'GetInsuranceMarketplaceProductsResponse',
  '2': const [
    const {'1': 'products', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.MarketplaceInsuranceProduct', '10': 'products'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInsuranceMarketplaceProductsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceMarketplaceProductsResponseDescriptor = $convert.base64Decode('CidHZXRJbnN1cmFuY2VNYXJrZXRwbGFjZVByb2R1Y3RzUmVzcG9uc2USSgoIcHJvZHVjdHMYASADKAsyLi5maW5hbmNpYWxwcm9kdWN0cy5NYXJrZXRwbGFjZUluc3VyYW5jZVByb2R1Y3RSCHByb2R1Y3RzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use getInsuranceMarketplaceCategoriesRequestDescriptor instead')
const GetInsuranceMarketplaceCategoriesRequest$json = const {
  '1': 'GetInsuranceMarketplaceCategoriesRequest',
  '2': const [
    const {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `GetInsuranceMarketplaceCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceMarketplaceCategoriesRequestDescriptor = $convert.base64Decode('CihHZXRJbnN1cmFuY2VNYXJrZXRwbGFjZUNhdGVnb3JpZXNSZXF1ZXN0EhYKBmxvY2FsZRgBIAEoCVIGbG9jYWxl');
@$core.Deprecated('Use getInsuranceMarketplaceCategoriesResponseDescriptor instead')
const GetInsuranceMarketplaceCategoriesResponse$json = const {
  '1': 'GetInsuranceMarketplaceCategoriesResponse',
  '2': const [
    const {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.MarketplaceInsuranceCategory', '10': 'categories'},
  ],
};

/// Descriptor for `GetInsuranceMarketplaceCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceMarketplaceCategoriesResponseDescriptor = $convert.base64Decode('CilHZXRJbnN1cmFuY2VNYXJrZXRwbGFjZUNhdGVnb3JpZXNSZXNwb25zZRJPCgpjYXRlZ29yaWVzGAEgAygLMi8uZmluYW5jaWFscHJvZHVjdHMuTWFya2V0cGxhY2VJbnN1cmFuY2VDYXRlZ29yeVIKY2F0ZWdvcmllcw==');
@$core.Deprecated('Use getInsuranceQuoteRequestDescriptor instead')
const GetInsuranceQuoteRequest$json = const {
  '1': 'GetInsuranceQuoteRequest',
  '2': const [
    const {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    const {'1': 'form_data', '3': 2, '4': 3, '5': 11, '6': '.financialproducts.GetInsuranceQuoteRequest.FormDataEntry', '10': 'formData'},
    const {'1': 'locale', '3': 3, '4': 1, '5': 9, '10': 'locale'},
  ],
  '3': const [GetInsuranceQuoteRequest_FormDataEntry$json],
};

@$core.Deprecated('Use getInsuranceQuoteRequestDescriptor instead')
const GetInsuranceQuoteRequest_FormDataEntry$json = const {
  '1': 'FormDataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetInsuranceQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceQuoteRequestDescriptor = $convert.base64Decode('ChhHZXRJbnN1cmFuY2VRdW90ZVJlcXVlc3QSHQoKcHJvZHVjdF9pZBgBIAEoCVIJcHJvZHVjdElkElYKCWZvcm1fZGF0YRgCIAMoCzI5LmZpbmFuY2lhbHByb2R1Y3RzLkdldEluc3VyYW5jZVF1b3RlUmVxdWVzdC5Gb3JtRGF0YUVudHJ5Ughmb3JtRGF0YRIWCgZsb2NhbGUYAyABKAlSBmxvY2FsZRo7Cg1Gb3JtRGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use getInsuranceQuoteResponseDescriptor instead')
const GetInsuranceQuoteResponse$json = const {
  '1': 'GetInsuranceQuoteResponse',
  '2': const [
    const {'1': 'quote', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.MarketplaceInsuranceQuote', '10': 'quote'},
  ],
};

/// Descriptor for `GetInsuranceQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceQuoteResponseDescriptor = $convert.base64Decode('ChlHZXRJbnN1cmFuY2VRdW90ZVJlc3BvbnNlEkIKBXF1b3RlGAEgASgLMiwuZmluYW5jaWFscHJvZHVjdHMuTWFya2V0cGxhY2VJbnN1cmFuY2VRdW90ZVIFcXVvdGU=');
@$core.Deprecated('Use purchaseMarketplaceInsuranceRequestDescriptor instead')
const PurchaseMarketplaceInsuranceRequest$json = const {
  '1': 'PurchaseMarketplaceInsuranceRequest',
  '2': const [
    const {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    const {'1': 'product_id', '3': 2, '4': 1, '5': 9, '10': 'productId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'transaction_pin_token', '3': 4, '4': 1, '5': 9, '10': 'transactionPinToken'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'form_data', '3': 6, '4': 3, '5': 11, '6': '.financialproducts.PurchaseMarketplaceInsuranceRequest.FormDataEntry', '10': 'formData'},
    const {'1': 'locale', '3': 7, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'pin_transaction_id', '3': 8, '4': 1, '5': 9, '10': 'pinTransactionId'},
  ],
  '3': const [PurchaseMarketplaceInsuranceRequest_FormDataEntry$json],
};

@$core.Deprecated('Use purchaseMarketplaceInsuranceRequestDescriptor instead')
const PurchaseMarketplaceInsuranceRequest_FormDataEntry$json = const {
  '1': 'FormDataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `PurchaseMarketplaceInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseMarketplaceInsuranceRequestDescriptor = $convert.base64Decode('CiNQdXJjaGFzZU1hcmtldHBsYWNlSW5zdXJhbmNlUmVxdWVzdBIZCghxdW90ZV9pZBgBIAEoCVIHcXVvdGVJZBIdCgpwcm9kdWN0X2lkGAIgASgJUglwcm9kdWN0SWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEjIKFXRyYW5zYWN0aW9uX3Bpbl90b2tlbhgEIAEoCVITdHJhbnNhY3Rpb25QaW5Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYBSABKAlSDmlkZW1wb3RlbmN5S2V5EmEKCWZvcm1fZGF0YRgGIAMoCzJELmZpbmFuY2lhbHByb2R1Y3RzLlB1cmNoYXNlTWFya2V0cGxhY2VJbnN1cmFuY2VSZXF1ZXN0LkZvcm1EYXRhRW50cnlSCGZvcm1EYXRhEhYKBmxvY2FsZRgHIAEoCVIGbG9jYWxlEiwKEnBpbl90cmFuc2FjdGlvbl9pZBgIIAEoCVIQcGluVHJhbnNhY3Rpb25JZBo7Cg1Gb3JtRGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use purchaseMarketplaceInsuranceResponseDescriptor instead')
const PurchaseMarketplaceInsuranceResponse$json = const {
  '1': 'PurchaseMarketplaceInsuranceResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.MarketplaceInsurancePurchaseResult', '10': 'result'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PurchaseMarketplaceInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseMarketplaceInsuranceResponseDescriptor = $convert.base64Decode('CiRQdXJjaGFzZU1hcmtldHBsYWNlSW5zdXJhbmNlUmVzcG9uc2USTQoGcmVzdWx0GAEgASgLMjUuZmluYW5jaWFscHJvZHVjdHMuTWFya2V0cGxhY2VJbnN1cmFuY2VQdXJjaGFzZVJlc3VsdFIGcmVzdWx0EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getInsurancePurchaseStatusRequestDescriptor instead')
const GetInsurancePurchaseStatusRequest$json = const {
  '1': 'GetInsurancePurchaseStatusRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GetInsurancePurchaseStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePurchaseStatusRequestDescriptor = $convert.base64Decode('CiFHZXRJbnN1cmFuY2VQdXJjaGFzZVN0YXR1c1JlcXVlc3QSHAoJcmVmZXJlbmNlGAEgASgJUglyZWZlcmVuY2U=');
@$core.Deprecated('Use getInsurancePurchaseStatusResponseDescriptor instead')
const GetInsurancePurchaseStatusResponse$json = const {
  '1': 'GetInsurancePurchaseStatusResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.MarketplaceInsurancePurchaseResult', '10': 'result'},
  ],
};

/// Descriptor for `GetInsurancePurchaseStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePurchaseStatusResponseDescriptor = $convert.base64Decode('CiJHZXRJbnN1cmFuY2VQdXJjaGFzZVN0YXR1c1Jlc3BvbnNlEk0KBnJlc3VsdBgBIAEoCzI1LmZpbmFuY2lhbHByb2R1Y3RzLk1hcmtldHBsYWNlSW5zdXJhbmNlUHVyY2hhc2VSZXN1bHRSBnJlc3VsdA==');
@$core.Deprecated('Use uploadInsuranceDocumentRequestDescriptor instead')
const UploadInsuranceDocumentRequest$json = const {
  '1': 'UploadInsuranceDocumentRequest',
  '2': const [
    const {'1': 'file_data', '3': 1, '4': 1, '5': 12, '10': 'fileData'},
    const {'1': 'filename', '3': 2, '4': 1, '5': 9, '10': 'filename'},
    const {'1': 'document_type', '3': 3, '4': 1, '5': 9, '10': 'documentType'},
  ],
};

/// Descriptor for `UploadInsuranceDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadInsuranceDocumentRequestDescriptor = $convert.base64Decode('Ch5VcGxvYWRJbnN1cmFuY2VEb2N1bWVudFJlcXVlc3QSGwoJZmlsZV9kYXRhGAEgASgMUghmaWxlRGF0YRIaCghmaWxlbmFtZRgCIAEoCVIIZmlsZW5hbWUSIwoNZG9jdW1lbnRfdHlwZRgDIAEoCVIMZG9jdW1lbnRUeXBl');
@$core.Deprecated('Use uploadInsuranceDocumentResponseDescriptor instead')
const UploadInsuranceDocumentResponse$json = const {
  '1': 'UploadInsuranceDocumentResponse',
  '2': const [
    const {'1': 'upload_id', '3': 1, '4': 1, '5': 9, '10': 'uploadId'},
    const {'1': 'file_url', '3': 2, '4': 1, '5': 9, '10': 'fileUrl'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `UploadInsuranceDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadInsuranceDocumentResponseDescriptor = $convert.base64Decode('Ch9VcGxvYWRJbnN1cmFuY2VEb2N1bWVudFJlc3BvbnNlEhsKCXVwbG9hZF9pZBgBIAEoCVIIdXBsb2FkSWQSGQoIZmlsZV91cmwYAiABKAlSB2ZpbGVVcmwSGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2VzcxIQCgNtc2cYBCABKAlSA21zZw==');
@$core.Deprecated('Use getInsuranceAuxiliaryDataRequestDescriptor instead')
const GetInsuranceAuxiliaryDataRequest$json = const {
  '1': 'GetInsuranceAuxiliaryDataRequest',
  '2': const [
    const {'1': 'utility_id', '3': 1, '4': 1, '5': 9, '10': 'utilityId'},
    const {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `GetInsuranceAuxiliaryDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceAuxiliaryDataRequestDescriptor = $convert.base64Decode('CiBHZXRJbnN1cmFuY2VBdXhpbGlhcnlEYXRhUmVxdWVzdBIdCgp1dGlsaXR5X2lkGAEgASgJUgl1dGlsaXR5SWQSFAoFcXVlcnkYAiABKAlSBXF1ZXJ5');
@$core.Deprecated('Use getInsuranceAuxiliaryDataResponseDescriptor instead')
const GetInsuranceAuxiliaryDataResponse$json = const {
  '1': 'GetInsuranceAuxiliaryDataResponse',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsuranceAuxiliaryItem', '10': 'items'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceAuxiliaryDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceAuxiliaryDataResponseDescriptor = $convert.base64Decode('CiFHZXRJbnN1cmFuY2VBdXhpbGlhcnlEYXRhUmVzcG9uc2USPwoFaXRlbXMYASADKAsyKS5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VBdXhpbGlhcnlJdGVtUgVpdGVtcxIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVIDbXNn');
@$core.Deprecated('Use insuranceAuxiliaryItemDescriptor instead')
const InsuranceAuxiliaryItem$json = const {
  '1': 'InsuranceAuxiliaryItem',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `InsuranceAuxiliaryItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceAuxiliaryItemDescriptor = $convert.base64Decode('ChZJbnN1cmFuY2VBdXhpbGlhcnlJdGVtEhQKBWxhYmVsGAEgASgJUgVsYWJlbBIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU=');
@$core.Deprecated('Use createCrowdfundRequestDescriptor instead')
const CreateCrowdfundRequest$json = const {
  '1': 'CreateCrowdfundRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'deadline', '3': 6, '4': 1, '5': 9, '10': 'deadline'},
    const {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `CreateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVDcm93ZGZ1bmRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIjCg10YXJnZXRfYW1vdW50GAUgASgBUgx0YXJnZXRBbW91bnQSGgoIZGVhZGxpbmUYBiABKAlSCGRlYWRsaW5lEhsKCWltYWdlX3VybBgHIAEoCVIIaW1hZ2VVcmw=');
@$core.Deprecated('Use createCrowdfundResponseDescriptor instead')
const CreateCrowdfundResponse$json = const {
  '1': 'CreateCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVDcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getCrowdfundsRequestDescriptor instead')
const GetCrowdfundsRequest$json = const {
  '1': 'GetCrowdfundsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetCrowdfundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundsRequestDescriptor = $convert.base64Decode('ChRHZXRDcm93ZGZ1bmRzUmVxdWVzdBIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnkSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSFAoFbGltaXQYAyABKAVSBWxpbWl0EhYKBm9mZnNldBgEIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getCrowdfundsResponseDescriptor instead')
const GetCrowdfundsResponse$json = const {
  '1': 'GetCrowdfundsResponse',
  '2': const [
    const {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfunds'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundsResponseDescriptor = $convert.base64Decode('ChVHZXRDcm93ZGZ1bmRzUmVzcG9uc2USPAoKY3Jvd2RmdW5kcxgBIAMoCzIcLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFIKY3Jvd2RmdW5kcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use getCrowdfundRequestDescriptor instead')
const GetCrowdfundRequest$json = const {
  '1': 'GetCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `GetCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundRequestDescriptor = $convert.base64Decode('ChNHZXRDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQ=');
@$core.Deprecated('Use getCrowdfundResponseDescriptor instead')
const GetCrowdfundResponse$json = const {
  '1': 'GetCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'recent_contributions', '3': 2, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'recentContributions'},
  ],
};

/// Descriptor for `GetCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundResponseDescriptor = $convert.base64Decode('ChRHZXRDcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBJbChRyZWNlbnRfY29udHJpYnV0aW9ucxgCIAMoCzIoLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZENvbnRyaWJ1dGlvblITcmVjZW50Q29udHJpYnV0aW9ucw==');
@$core.Deprecated('Use contributeToCrowdfundRequestDescriptor instead')
const ContributeToCrowdfundRequest$json = const {
  '1': 'ContributeToCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_anonymous', '3': 5, '4': 1, '5': 8, '10': 'isAnonymous'},
    const {'1': 'pin', '3': 6, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `ContributeToCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToCrowdfundRequestDescriptor = $convert.base64Decode('ChxDb250cmlidXRlVG9Dcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2USIQoMaXNfYW5vbnltb3VzGAUgASgIUgtpc0Fub255bW91cxIQCgNwaW4YBiABKAlSA3Bpbg==');
@$core.Deprecated('Use contributeToCrowdfundResponseDescriptor instead')
const ContributeToCrowdfundResponse$json = const {
  '1': 'ContributeToCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'contribution', '3': 2, '4': 1, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'contribution'},
    const {'1': 'new_balance', '3': 3, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ContributeToCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToCrowdfundResponseDescriptor = $convert.base64Decode('Ch1Db250cmlidXRlVG9Dcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBJMCgxjb250cmlidXRpb24YAiABKAsyKC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRDb250cmlidXRpb25SDGNvbnRyaWJ1dGlvbhIfCgtuZXdfYmFsYW5jZRgDIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use withdrawFromCrowdfundRequestDescriptor instead')
const WithdrawFromCrowdfundRequest$json = const {
  '1': 'WithdrawFromCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'destination_account_type', '3': 5, '4': 1, '5': 9, '10': 'destinationAccountType'},
  ],
};

/// Descriptor for `WithdrawFromCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCrowdfundRequestDescriptor = $convert.base64Decode('ChxXaXRoZHJhd0Zyb21Dcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSEAoDcGluGAMgASgJUgNwaW4SNAoWZGVzdGluYXRpb25fYWNjb3VudF9pZBgEIAEoCVIUZGVzdGluYXRpb25BY2NvdW50SWQSOAoYZGVzdGluYXRpb25fYWNjb3VudF90eXBlGAUgASgJUhZkZXN0aW5hdGlvbkFjY291bnRUeXBl');
@$core.Deprecated('Use withdrawFromCrowdfundResponseDescriptor instead')
const WithdrawFromCrowdfundResponse$json = const {
  '1': 'WithdrawFromCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'amount_withdrawn', '3': 2, '4': 1, '5': 1, '10': 'amountWithdrawn'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'destination_new_balance', '3': 5, '4': 1, '5': 1, '10': 'destinationNewBalance'},
  ],
};

/// Descriptor for `WithdrawFromCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCrowdfundResponseDescriptor = $convert.base64Decode('Ch1XaXRoZHJhd0Zyb21Dcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBIpChBhbW91bnRfd2l0aGRyYXduGAIgASgBUg9hbW91bnRXaXRoZHJhd24SGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGAQgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBI2ChdkZXN0aW5hdGlvbl9uZXdfYmFsYW5jZRgFIAEoAVIVZGVzdGluYXRpb25OZXdCYWxhbmNl');
@$core.Deprecated('Use closeCrowdfundRequestDescriptor instead')
const CloseCrowdfundRequest$json = const {
  '1': 'CloseCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `CloseCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeCrowdfundRequestDescriptor = $convert.base64Decode('ChVDbG9zZUNyb3dkZnVuZFJlcXVlc3QSIQoMY3Jvd2RmdW5kX2lkGAEgASgJUgtjcm93ZGZ1bmRJZA==');
@$core.Deprecated('Use closeCrowdfundResponseDescriptor instead')
const CloseCrowdfundResponse$json = const {
  '1': 'CloseCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CloseCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeCrowdfundResponseDescriptor = $convert.base64Decode('ChZDbG9zZUNyb3dkZnVuZFJlc3BvbnNlEjoKCWNyb3dkZnVuZBgBIAEoCzIcLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFIJY3Jvd2RmdW5kEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getCrowdfundStatisticsRequestDescriptor instead')
const GetCrowdfundStatisticsRequest$json = const {
  '1': 'GetCrowdfundStatisticsRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'include_leaderboard', '3': 2, '4': 1, '5': 8, '10': 'includeLeaderboard'},
    const {'1': 'include_daily_progress', '3': 3, '4': 1, '5': 8, '10': 'includeDailyProgress'},
    const {'1': 'leaderboard_limit', '3': 4, '4': 1, '5': 5, '10': 'leaderboardLimit'},
    const {'1': 'progress_days', '3': 5, '4': 1, '5': 5, '10': 'progressDays'},
  ],
};

/// Descriptor for `GetCrowdfundStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundStatisticsRequestDescriptor = $convert.base64Decode('Ch1HZXRDcm93ZGZ1bmRTdGF0aXN0aWNzUmVxdWVzdBIhCgxjcm93ZGZ1bmRfaWQYASABKAlSC2Nyb3dkZnVuZElkEi8KE2luY2x1ZGVfbGVhZGVyYm9hcmQYAiABKAhSEmluY2x1ZGVMZWFkZXJib2FyZBI0ChZpbmNsdWRlX2RhaWx5X3Byb2dyZXNzGAMgASgIUhRpbmNsdWRlRGFpbHlQcm9ncmVzcxIrChFsZWFkZXJib2FyZF9saW1pdBgEIAEoBVIQbGVhZGVyYm9hcmRMaW1pdBIjCg1wcm9ncmVzc19kYXlzGAUgASgFUgxwcm9ncmVzc0RheXM=');
@$core.Deprecated('Use getCrowdfundStatisticsResponseDescriptor instead')
const GetCrowdfundStatisticsResponse$json = const {
  '1': 'GetCrowdfundStatisticsResponse',
  '2': const [
    const {'1': 'statistics', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.CrowdfundStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetCrowdfundStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundStatisticsResponseDescriptor = $convert.base64Decode('Ch5HZXRDcm93ZGZ1bmRTdGF0aXN0aWNzUmVzcG9uc2USRgoKc3RhdGlzdGljcxgBIAEoCzImLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFN0YXRpc3RpY3NSCnN0YXRpc3RpY3M=');
@$core.Deprecated('Use crowdfundStatisticsDescriptor instead')
const CrowdfundStatistics$json = const {
  '1': 'CrowdfundStatistics',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'total_raised', '3': 2, '4': 1, '5': 1, '10': 'totalRaised'},
    const {'1': 'target_amount', '3': 3, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'progress_percentage', '3': 4, '4': 1, '5': 1, '10': 'progressPercentage'},
    const {'1': 'donor_count', '3': 5, '4': 1, '5': 5, '10': 'donorCount'},
    const {'1': 'average_donation', '3': 6, '4': 1, '5': 1, '10': 'averageDonation'},
    const {'1': 'largest_donation', '3': 7, '4': 1, '5': 1, '10': 'largestDonation'},
    const {'1': 'smallest_donation', '3': 8, '4': 1, '5': 1, '10': 'smallestDonation'},
    const {'1': 'days_remaining', '3': 9, '4': 1, '5': 5, '10': 'daysRemaining'},
    const {'1': 'days_active', '3': 10, '4': 1, '5': 5, '10': 'daysActive'},
    const {'1': 'is_completed', '3': 11, '4': 1, '5': 8, '10': 'isCompleted'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'top_contributors', '3': 13, '4': 3, '5': 11, '6': '.financialproducts.ContributorLeaderboardEntry', '10': 'topContributors'},
    const {'1': 'daily_progress', '3': 14, '4': 3, '5': 11, '6': '.financialproducts.DailyProgress', '10': 'dailyProgress'},
    const {'1': 'funding_velocity', '3': 15, '4': 1, '5': 1, '10': 'fundingVelocity'},
    const {'1': 'projected_completion_date', '3': 16, '4': 1, '5': 9, '10': 'projectedCompletionDate'},
    const {'1': 'new_donors_today', '3': 17, '4': 1, '5': 5, '10': 'newDonorsToday'},
    const {'1': 'new_donors_this_week', '3': 18, '4': 1, '5': 5, '10': 'newDonorsThisWeek'},
    const {'1': 'amount_raised_today', '3': 19, '4': 1, '5': 1, '10': 'amountRaisedToday'},
    const {'1': 'amount_raised_this_week', '3': 20, '4': 1, '5': 1, '10': 'amountRaisedThisWeek'},
  ],
};

/// Descriptor for `CrowdfundStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundStatisticsDescriptor = $convert.base64Decode('ChNDcm93ZGZ1bmRTdGF0aXN0aWNzEiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSIQoMdG90YWxfcmFpc2VkGAIgASgBUgt0b3RhbFJhaXNlZBIjCg10YXJnZXRfYW1vdW50GAMgASgBUgx0YXJnZXRBbW91bnQSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgEIAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdlEh8KC2Rvbm9yX2NvdW50GAUgASgFUgpkb25vckNvdW50EikKEGF2ZXJhZ2VfZG9uYXRpb24YBiABKAFSD2F2ZXJhZ2VEb25hdGlvbhIpChBsYXJnZXN0X2RvbmF0aW9uGAcgASgBUg9sYXJnZXN0RG9uYXRpb24SKwoRc21hbGxlc3RfZG9uYXRpb24YCCABKAFSEHNtYWxsZXN0RG9uYXRpb24SJQoOZGF5c19yZW1haW5pbmcYCSABKAVSDWRheXNSZW1haW5pbmcSHwoLZGF5c19hY3RpdmUYCiABKAVSCmRheXNBY3RpdmUSIQoMaXNfY29tcGxldGVkGAsgASgIUgtpc0NvbXBsZXRlZBIdCgpjcmVhdGVkX2F0GAwgASgJUgljcmVhdGVkQXQSWQoQdG9wX2NvbnRyaWJ1dG9ycxgNIAMoCzIuLmZpbmFuY2lhbHByb2R1Y3RzLkNvbnRyaWJ1dG9yTGVhZGVyYm9hcmRFbnRyeVIPdG9wQ29udHJpYnV0b3JzEkcKDmRhaWx5X3Byb2dyZXNzGA4gAygLMiAuZmluYW5jaWFscHJvZHVjdHMuRGFpbHlQcm9ncmVzc1INZGFpbHlQcm9ncmVzcxIpChBmdW5kaW5nX3ZlbG9jaXR5GA8gASgBUg9mdW5kaW5nVmVsb2NpdHkSOgoZcHJvamVjdGVkX2NvbXBsZXRpb25fZGF0ZRgQIAEoCVIXcHJvamVjdGVkQ29tcGxldGlvbkRhdGUSKAoQbmV3X2Rvbm9yc190b2RheRgRIAEoBVIObmV3RG9ub3JzVG9kYXkSLwoUbmV3X2Rvbm9yc190aGlzX3dlZWsYEiABKAVSEW5ld0Rvbm9yc1RoaXNXZWVrEi4KE2Ftb3VudF9yYWlzZWRfdG9kYXkYEyABKAFSEWFtb3VudFJhaXNlZFRvZGF5EjUKF2Ftb3VudF9yYWlzZWRfdGhpc193ZWVrGBQgASgBUhRhbW91bnRSYWlzZWRUaGlzV2Vlaw==');
@$core.Deprecated('Use contributorLeaderboardEntryDescriptor instead')
const ContributorLeaderboardEntry$json = const {
  '1': 'ContributorLeaderboardEntry',
  '2': const [
    const {'1': 'rank', '3': 1, '4': 1, '5': 5, '10': 'rank'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'profile_picture', '3': 4, '4': 1, '5': 9, '10': 'profilePicture'},
    const {'1': 'total_amount', '3': 5, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'contribution_count', '3': 6, '4': 1, '5': 5, '10': 'contributionCount'},
    const {'1': 'is_anonymous', '3': 7, '4': 1, '5': 8, '10': 'isAnonymous'},
    const {'1': 'first_contribution_date', '3': 8, '4': 1, '5': 9, '10': 'firstContributionDate'},
    const {'1': 'last_contribution_date', '3': 9, '4': 1, '5': 9, '10': 'lastContributionDate'},
  ],
};

/// Descriptor for `ContributorLeaderboardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributorLeaderboardEntryDescriptor = $convert.base64Decode('ChtDb250cmlidXRvckxlYWRlcmJvYXJkRW50cnkSEgoEcmFuaxgBIAEoBVIEcmFuaxIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSIQoMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRInCg9wcm9maWxlX3BpY3R1cmUYBCABKAlSDnByb2ZpbGVQaWN0dXJlEiEKDHRvdGFsX2Ftb3VudBgFIAEoAVILdG90YWxBbW91bnQSLQoSY29udHJpYnV0aW9uX2NvdW50GAYgASgFUhFjb250cmlidXRpb25Db3VudBIhCgxpc19hbm9ueW1vdXMYByABKAhSC2lzQW5vbnltb3VzEjYKF2ZpcnN0X2NvbnRyaWJ1dGlvbl9kYXRlGAggASgJUhVmaXJzdENvbnRyaWJ1dGlvbkRhdGUSNAoWbGFzdF9jb250cmlidXRpb25fZGF0ZRgJIAEoCVIUbGFzdENvbnRyaWJ1dGlvbkRhdGU=');
@$core.Deprecated('Use dailyProgressDescriptor instead')
const DailyProgress$json = const {
  '1': 'DailyProgress',
  '2': const [
    const {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
    const {'1': 'amount_raised', '3': 2, '4': 1, '5': 1, '10': 'amountRaised'},
    const {'1': 'new_donors', '3': 3, '4': 1, '5': 5, '10': 'newDonors'},
    const {'1': 'total_contributions', '3': 4, '4': 1, '5': 5, '10': 'totalContributions'},
    const {'1': 'cumulative_amount', '3': 5, '4': 1, '5': 1, '10': 'cumulativeAmount'},
    const {'1': 'progress_percentage', '3': 6, '4': 1, '5': 1, '10': 'progressPercentage'},
  ],
};

/// Descriptor for `DailyProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyProgressDescriptor = $convert.base64Decode('Cg1EYWlseVByb2dyZXNzEhIKBGRhdGUYASABKAlSBGRhdGUSIwoNYW1vdW50X3JhaXNlZBgCIAEoAVIMYW1vdW50UmFpc2VkEh0KCm5ld19kb25vcnMYAyABKAVSCW5ld0Rvbm9ycxIvChN0b3RhbF9jb250cmlidXRpb25zGAQgASgFUhJ0b3RhbENvbnRyaWJ1dGlvbnMSKwoRY3VtdWxhdGl2ZV9hbW91bnQYBSABKAFSEGN1bXVsYXRpdmVBbW91bnQSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgGIAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdl');
@$core.Deprecated('Use searchCrowdfundsRequestDescriptor instead')
const SearchCrowdfundsRequest$json = const {
  '1': 'SearchCrowdfundsRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchCrowdfundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCrowdfundsRequestDescriptor = $convert.base64Decode('ChdTZWFyY2hDcm93ZGZ1bmRzUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSFAoFbGltaXQYAiABKAVSBWxpbWl0');
@$core.Deprecated('Use searchCrowdfundsResponseDescriptor instead')
const SearchCrowdfundsResponse$json = const {
  '1': 'SearchCrowdfundsResponse',
  '2': const [
    const {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfunds'},
  ],
};

/// Descriptor for `SearchCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCrowdfundsResponseDescriptor = $convert.base64Decode('ChhTZWFyY2hDcm93ZGZ1bmRzUmVzcG9uc2USPAoKY3Jvd2RmdW5kcxgBIAMoCzIcLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFIKY3Jvd2RmdW5kcw==');
@$core.Deprecated('Use updateCrowdfundRequestDescriptor instead')
const UpdateCrowdfundRequest$json = const {
  '1': 'UpdateCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'deadline', '3': 6, '4': 1, '5': 9, '10': 'deadline'},
    const {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `UpdateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCrowdfundRequestDescriptor = $convert.base64Decode('ChZVcGRhdGVDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIaCghjYXRlZ29yeRgEIAEoCVIIY2F0ZWdvcnkSIwoNdGFyZ2V0X2Ftb3VudBgFIAEoAVIMdGFyZ2V0QW1vdW50EhoKCGRlYWRsaW5lGAYgASgJUghkZWFkbGluZRIbCglpbWFnZV91cmwYByABKAlSCGltYWdlVXJsEhYKBnN0YXR1cxgIIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use updateCrowdfundResponseDescriptor instead')
const UpdateCrowdfundResponse$json = const {
  '1': 'UpdateCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCrowdfundResponseDescriptor = $convert.base64Decode('ChdVcGRhdGVDcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteCrowdfundRequestDescriptor instead')
const DeleteCrowdfundRequest$json = const {
  '1': 'DeleteCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `DeleteCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCrowdfundRequestDescriptor = $convert.base64Decode('ChZEZWxldGVDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQ=');
@$core.Deprecated('Use deleteCrowdfundResponseDescriptor instead')
const DeleteCrowdfundResponse$json = const {
  '1': 'DeleteCrowdfundResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCrowdfundResponseDescriptor = $convert.base64Decode('ChdEZWxldGVDcm93ZGZ1bmRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getCrowdfundDonationsRequestDescriptor instead')
const GetCrowdfundDonationsRequest$json = const {
  '1': 'GetCrowdfundDonationsRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetCrowdfundDonationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundDonationsRequestDescriptor = $convert.base64Decode('ChxHZXRDcm93ZGZ1bmREb25hdGlvbnNSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXpl');
@$core.Deprecated('Use getCrowdfundDonationsResponseDescriptor instead')
const GetCrowdfundDonationsResponse$json = const {
  '1': 'GetCrowdfundDonationsResponse',
  '2': const [
    const {'1': 'donations', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'donations'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetCrowdfundDonationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundDonationsResponseDescriptor = $convert.base64Decode('Ch1HZXRDcm93ZGZ1bmREb25hdGlvbnNSZXNwb25zZRJGCglkb25hdGlvbnMYASADKAsyKC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRDb250cmlidXRpb25SCWRvbmF0aW9ucxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYBCABKAVSCHBhZ2VTaXplEhkKCGhhc19tb3JlGAUgASgIUgdoYXNNb3Jl');
@$core.Deprecated('Use getUserDonationsRequestDescriptor instead')
const GetUserDonationsRequest$json = const {
  '1': 'GetUserDonationsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetUserDonationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDonationsRequestDescriptor = $convert.base64Decode('ChdHZXRVc2VyRG9uYXRpb25zUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemU=');
@$core.Deprecated('Use getUserDonationsResponseDescriptor instead')
const GetUserDonationsResponse$json = const {
  '1': 'GetUserDonationsResponse',
  '2': const [
    const {'1': 'donations', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'donations'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetUserDonationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDonationsResponseDescriptor = $convert.base64Decode('ChhHZXRVc2VyRG9uYXRpb25zUmVzcG9uc2USRgoJZG9uYXRpb25zGAEgAygLMiguZmluYW5jaWFscHJvZHVjdHMuQ3Jvd2RmdW5kQ29udHJpYnV0aW9uUglkb25hdGlvbnMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZRIZCghoYXNfbW9yZRgFIAEoCFIHaGFzTW9yZQ==');
@$core.Deprecated('Use generateDonationReceiptRequestDescriptor instead')
const GenerateDonationReceiptRequest$json = const {
  '1': 'GenerateDonationReceiptRequest',
  '2': const [
    const {'1': 'donation_id', '3': 1, '4': 1, '5': 9, '10': 'donationId'},
  ],
};

/// Descriptor for `GenerateDonationReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateDonationReceiptRequestDescriptor = $convert.base64Decode('Ch5HZW5lcmF0ZURvbmF0aW9uUmVjZWlwdFJlcXVlc3QSHwoLZG9uYXRpb25faWQYASABKAlSCmRvbmF0aW9uSWQ=');
@$core.Deprecated('Use generateDonationReceiptResponseDescriptor instead')
const GenerateDonationReceiptResponse$json = const {
  '1': 'GenerateDonationReceiptResponse',
  '2': const [
    const {'1': 'receipt', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.CrowdfundReceipt', '10': 'receipt'},
  ],
};

/// Descriptor for `GenerateDonationReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateDonationReceiptResponseDescriptor = $convert.base64Decode('Ch9HZW5lcmF0ZURvbmF0aW9uUmVjZWlwdFJlc3BvbnNlEj0KB3JlY2VpcHQYASABKAsyIy5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSZWNlaXB0UgdyZWNlaXB0');
@$core.Deprecated('Use getUserCrowdfundReceiptsRequestDescriptor instead')
const GetUserCrowdfundReceiptsRequest$json = const {
  '1': 'GetUserCrowdfundReceiptsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetUserCrowdfundReceiptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCrowdfundReceiptsRequestDescriptor = $convert.base64Decode('Ch9HZXRVc2VyQ3Jvd2RmdW5kUmVjZWlwdHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAIgASgFUghwYWdlU2l6ZQ==');
@$core.Deprecated('Use getUserCrowdfundReceiptsResponseDescriptor instead')
const GetUserCrowdfundReceiptsResponse$json = const {
  '1': 'GetUserCrowdfundReceiptsResponse',
  '2': const [
    const {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundReceipt', '10': 'receipts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetUserCrowdfundReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCrowdfundReceiptsResponseDescriptor = $convert.base64Decode('CiBHZXRVc2VyQ3Jvd2RmdW5kUmVjZWlwdHNSZXNwb25zZRI/CghyZWNlaXB0cxgBIAMoCzIjLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFJlY2VpcHRSCHJlY2VpcHRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZVNpemUSGQoIaGFzX21vcmUYBSABKAhSB2hhc01vcmU=');
@$core.Deprecated('Use crowdfundReceiptDescriptor instead')
const CrowdfundReceipt$json = const {
  '1': 'CrowdfundReceipt',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'donation_id', '3': 2, '4': 1, '5': 9, '10': 'donationId'},
    const {'1': 'crowdfund_id', '3': 3, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'crowdfund_title', '3': 4, '4': 1, '5': 9, '10': 'crowdfundTitle'},
    const {'1': 'donor_user_id', '3': 5, '4': 1, '5': 9, '10': 'donorUserId'},
    const {'1': 'donor_name', '3': 6, '4': 1, '5': 9, '10': 'donorName'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'donation_date', '3': 9, '4': 1, '5': 9, '10': 'donationDate'},
    const {'1': 'generated_at', '3': 10, '4': 1, '5': 9, '10': 'generatedAt'},
    const {'1': 'receipt_number', '3': 11, '4': 1, '5': 9, '10': 'receiptNumber'},
    const {'1': 'receipt_data', '3': 12, '4': 1, '5': 9, '10': 'receiptData'},
  ],
};

/// Descriptor for `CrowdfundReceipt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundReceiptDescriptor = $convert.base64Decode('ChBDcm93ZGZ1bmRSZWNlaXB0Eg4KAmlkGAEgASgJUgJpZBIfCgtkb25hdGlvbl9pZBgCIAEoCVIKZG9uYXRpb25JZBIhCgxjcm93ZGZ1bmRfaWQYAyABKAlSC2Nyb3dkZnVuZElkEicKD2Nyb3dkZnVuZF90aXRsZRgEIAEoCVIOY3Jvd2RmdW5kVGl0bGUSIgoNZG9ub3JfdXNlcl9pZBgFIAEoCVILZG9ub3JVc2VySWQSHQoKZG9ub3JfbmFtZRgGIAEoCVIJZG9ub3JOYW1lEhYKBmFtb3VudBgHIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIjCg1kb25hdGlvbl9kYXRlGAkgASgJUgxkb25hdGlvbkRhdGUSIQoMZ2VuZXJhdGVkX2F0GAogASgJUgtnZW5lcmF0ZWRBdBIlCg5yZWNlaXB0X251bWJlchgLIAEoCVINcmVjZWlwdE51bWJlchIhCgxyZWNlaXB0X2RhdGEYDCABKAlSC3JlY2VpcHREYXRh');
@$core.Deprecated('Use insurancePaymentRecordDescriptor instead')
const InsurancePaymentRecord$json = const {
  '1': 'InsurancePaymentRecord',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'policy_id', '3': 3, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'account_id', '3': 4, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'purchase_id', '3': 5, '4': 1, '5': 9, '10': 'purchaseId'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_method', '3': 8, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'transaction_reference', '3': 10, '4': 1, '5': 9, '10': 'transactionReference'},
    const {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'narration', '3': 12, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'failure_reason', '3': 13, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'receipt_number', '3': 14, '4': 1, '5': 9, '10': 'receiptNumber'},
    const {'1': 'processed_at', '3': 15, '4': 1, '5': 9, '10': 'processedAt'},
    const {'1': 'created_at', '3': 16, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 17, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `InsurancePaymentRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePaymentRecordDescriptor = $convert.base64Decode('ChZJbnN1cmFuY2VQYXltZW50UmVjb3JkEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSGwoJcG9saWN5X2lkGAMgASgJUghwb2xpY3lJZBIdCgphY2NvdW50X2lkGAQgASgJUglhY2NvdW50SWQSHwoLcHVyY2hhc2VfaWQYBSABKAlSCnB1cmNoYXNlSWQSFgoGYW1vdW50GAYgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EiUKDnBheW1lbnRfbWV0aG9kGAggASgJUg1wYXltZW50TWV0aG9kEhYKBnN0YXR1cxgJIAEoCVIGc3RhdHVzEjMKFXRyYW5zYWN0aW9uX3JlZmVyZW5jZRgKIAEoCVIUdHJhbnNhY3Rpb25SZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAsgASgJUg5pZGVtcG90ZW5jeUtleRIcCgluYXJyYXRpb24YDCABKAlSCW5hcnJhdGlvbhIlCg5mYWlsdXJlX3JlYXNvbhgNIAEoCVINZmFpbHVyZVJlYXNvbhIlCg5yZWNlaXB0X251bWJlchgOIAEoCVINcmVjZWlwdE51bWJlchIhCgxwcm9jZXNzZWRfYXQYDyABKAlSC3Byb2Nlc3NlZEF0Eh0KCmNyZWF0ZWRfYXQYECABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GBEgASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use insuranceClaimRecordDescriptor instead')
const InsuranceClaimRecord$json = const {
  '1': 'InsuranceClaimRecord',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'policy_id', '3': 3, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'claim_number', '3': 4, '4': 1, '5': 9, '10': 'claimNumber'},
    const {'1': 'claim_type', '3': 5, '4': 1, '5': 9, '10': 'claimType'},
    const {'1': 'claim_amount', '3': 6, '4': 1, '5': 3, '10': 'claimAmount'},
    const {'1': 'approved_amount', '3': 7, '4': 1, '5': 3, '10': 'approvedAmount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'title', '3': 10, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'incident_date', '3': 12, '4': 1, '5': 9, '10': 'incidentDate'},
    const {'1': 'incident_location', '3': 13, '4': 1, '5': 9, '10': 'incidentLocation'},
    const {'1': 'documents', '3': 14, '4': 3, '5': 9, '10': 'documents'},
    const {'1': 'additional_info', '3': 15, '4': 3, '5': 11, '6': '.financialproducts.InsuranceClaimRecord.AdditionalInfoEntry', '10': 'additionalInfo'},
    const {'1': 'rejection_reason', '3': 16, '4': 1, '5': 9, '10': 'rejectionReason'},
    const {'1': 'settlement_date', '3': 17, '4': 1, '5': 9, '10': 'settlementDate'},
    const {'1': 'settlement_details', '3': 18, '4': 1, '5': 9, '10': 'settlementDetails'},
    const {'1': 'provider_claim_id', '3': 19, '4': 1, '5': 9, '10': 'providerClaimId'},
    const {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'attachments', '3': 22, '4': 3, '5': 9, '10': 'attachments'},
  ],
  '3': const [InsuranceClaimRecord_AdditionalInfoEntry$json],
};

@$core.Deprecated('Use insuranceClaimRecordDescriptor instead')
const InsuranceClaimRecord_AdditionalInfoEntry$json = const {
  '1': 'AdditionalInfoEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `InsuranceClaimRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceClaimRecordDescriptor = $convert.base64Decode('ChRJbnN1cmFuY2VDbGFpbVJlY29yZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhsKCXBvbGljeV9pZBgDIAEoCVIIcG9saWN5SWQSIQoMY2xhaW1fbnVtYmVyGAQgASgJUgtjbGFpbU51bWJlchIdCgpjbGFpbV90eXBlGAUgASgJUgljbGFpbVR5cGUSIQoMY2xhaW1fYW1vdW50GAYgASgDUgtjbGFpbUFtb3VudBInCg9hcHByb3ZlZF9hbW91bnQYByABKANSDmFwcHJvdmVkQW1vdW50EhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cxIUCgV0aXRsZRgKIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YCyABKAlSC2Rlc2NyaXB0aW9uEiMKDWluY2lkZW50X2RhdGUYDCABKAlSDGluY2lkZW50RGF0ZRIrChFpbmNpZGVudF9sb2NhdGlvbhgNIAEoCVIQaW5jaWRlbnRMb2NhdGlvbhIcCglkb2N1bWVudHMYDiADKAlSCWRvY3VtZW50cxJkCg9hZGRpdGlvbmFsX2luZm8YDyADKAsyOy5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VDbGFpbVJlY29yZC5BZGRpdGlvbmFsSW5mb0VudHJ5Ug5hZGRpdGlvbmFsSW5mbxIpChByZWplY3Rpb25fcmVhc29uGBAgASgJUg9yZWplY3Rpb25SZWFzb24SJwoPc2V0dGxlbWVudF9kYXRlGBEgASgJUg5zZXR0bGVtZW50RGF0ZRItChJzZXR0bGVtZW50X2RldGFpbHMYEiABKAlSEXNldHRsZW1lbnREZXRhaWxzEioKEXByb3ZpZGVyX2NsYWltX2lkGBMgASgJUg9wcm92aWRlckNsYWltSWQSHQoKY3JlYXRlZF9hdBgUIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFSABKAlSCXVwZGF0ZWRBdBIgCgthdHRhY2htZW50cxgWIAMoCVILYXR0YWNobWVudHMaQQoTQWRkaXRpb25hbEluZm9FbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use getInsurancePaymentsRequestDescriptor instead')
const GetInsurancePaymentsRequest$json = const {
  '1': 'GetInsurancePaymentsRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInsurancePaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentsRequestDescriptor = $convert.base64Decode('ChtHZXRJbnN1cmFuY2VQYXltZW50c1JlcXVlc3QSGwoJcG9saWN5X2lkGAEgASgJUghwb2xpY3lJZBIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getInsurancePaymentsResponseDescriptor instead')
const GetInsurancePaymentsResponse$json = const {
  '1': 'GetInsurancePaymentsResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsurancePaymentRecord', '10': 'payments'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInsurancePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentsResponseDescriptor = $convert.base64Decode('ChxHZXRJbnN1cmFuY2VQYXltZW50c1Jlc3BvbnNlEkUKCHBheW1lbnRzGAEgAygLMikuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUGF5bWVudFJlY29yZFIIcGF5bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getUserInsurancePaymentsRequestDescriptor instead')
const GetUserInsurancePaymentsRequest$json = const {
  '1': 'GetUserInsurancePaymentsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserInsurancePaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsurancePaymentsRequestDescriptor = $convert.base64Decode('Ch9HZXRVc2VySW5zdXJhbmNlUGF5bWVudHNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getUserInsurancePaymentsResponseDescriptor instead')
const GetUserInsurancePaymentsResponse$json = const {
  '1': 'GetUserInsurancePaymentsResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsurancePaymentRecord', '10': 'payments'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetUserInsurancePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsurancePaymentsResponseDescriptor = $convert.base64Decode('CiBHZXRVc2VySW5zdXJhbmNlUGF5bWVudHNSZXNwb25zZRJFCghwYXltZW50cxgBIAMoCzIpLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZVBheW1lbnRSZWNvcmRSCHBheW1lbnRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use createInsurancePaymentRequestDescriptor instead')
const CreateInsurancePaymentRequest$json = const {
  '1': 'CreateInsurancePaymentRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_method', '3': 5, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'narration', '3': 6, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `CreateInsurancePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInsurancePaymentRequestDescriptor = $convert.base64Decode('Ch1DcmVhdGVJbnN1cmFuY2VQYXltZW50UmVxdWVzdBIbCglwb2xpY3lfaWQYASABKAlSCHBvbGljeUlkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIWCgZhbW91bnQYAyABKANSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSJQoOcGF5bWVudF9tZXRob2QYBSABKAlSDXBheW1lbnRNZXRob2QSHAoJbmFycmF0aW9uGAYgASgJUgluYXJyYXRpb24SJwoPaWRlbXBvdGVuY3lfa2V5GAcgASgJUg5pZGVtcG90ZW5jeUtleQ==');
@$core.Deprecated('Use createInsurancePaymentResponseDescriptor instead')
const CreateInsurancePaymentResponse$json = const {
  '1': 'CreateInsurancePaymentResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsurancePaymentRecord', '10': 'payment'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInsurancePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInsurancePaymentResponseDescriptor = $convert.base64Decode('Ch5DcmVhdGVJbnN1cmFuY2VQYXltZW50UmVzcG9uc2USQwoHcGF5bWVudBgBIAEoCzIpLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZVBheW1lbnRSZWNvcmRSB3BheW1lbnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use processInsurancePaymentRequestDescriptor instead')
const ProcessInsurancePaymentRequest$json = const {
  '1': 'ProcessInsurancePaymentRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'transaction_pin_token', '3': 2, '4': 1, '5': 9, '10': 'transactionPinToken'},
  ],
};

/// Descriptor for `ProcessInsurancePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processInsurancePaymentRequestDescriptor = $convert.base64Decode('Ch5Qcm9jZXNzSW5zdXJhbmNlUGF5bWVudFJlcXVlc3QSHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudElkEjIKFXRyYW5zYWN0aW9uX3Bpbl90b2tlbhgCIAEoCVITdHJhbnNhY3Rpb25QaW5Ub2tlbg==');
@$core.Deprecated('Use processInsurancePaymentResponseDescriptor instead')
const ProcessInsurancePaymentResponse$json = const {
  '1': 'ProcessInsurancePaymentResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsurancePaymentRecord', '10': 'payment'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessInsurancePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processInsurancePaymentResponseDescriptor = $convert.base64Decode('Ch9Qcm9jZXNzSW5zdXJhbmNlUGF5bWVudFJlc3BvbnNlEkMKB3BheW1lbnQYASABKAsyKS5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VQYXltZW50UmVjb3JkUgdwYXltZW50EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getInsurancePaymentByIdRequestDescriptor instead')
const GetInsurancePaymentByIdRequest$json = const {
  '1': 'GetInsurancePaymentByIdRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GetInsurancePaymentByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentByIdRequestDescriptor = $convert.base64Decode('Ch5HZXRJbnN1cmFuY2VQYXltZW50QnlJZFJlcXVlc3QSHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudElk');
@$core.Deprecated('Use getInsurancePaymentByIdResponseDescriptor instead')
const GetInsurancePaymentByIdResponse$json = const {
  '1': 'GetInsurancePaymentByIdResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsurancePaymentRecord', '10': 'payment'},
  ],
};

/// Descriptor for `GetInsurancePaymentByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentByIdResponseDescriptor = $convert.base64Decode('Ch9HZXRJbnN1cmFuY2VQYXltZW50QnlJZFJlc3BvbnNlEkMKB3BheW1lbnQYASABKAsyKS5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VQYXltZW50UmVjb3JkUgdwYXltZW50');
@$core.Deprecated('Use getOverdueInsurancePaymentsRequestDescriptor instead')
const GetOverdueInsurancePaymentsRequest$json = const {
  '1': 'GetOverdueInsurancePaymentsRequest',
};

/// Descriptor for `GetOverdueInsurancePaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueInsurancePaymentsRequestDescriptor = $convert.base64Decode('CiJHZXRPdmVyZHVlSW5zdXJhbmNlUGF5bWVudHNSZXF1ZXN0');
@$core.Deprecated('Use getOverdueInsurancePaymentsResponseDescriptor instead')
const GetOverdueInsurancePaymentsResponse$json = const {
  '1': 'GetOverdueInsurancePaymentsResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsurancePaymentRecord', '10': 'payments'},
  ],
};

/// Descriptor for `GetOverdueInsurancePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueInsurancePaymentsResponseDescriptor = $convert.base64Decode('CiNHZXRPdmVyZHVlSW5zdXJhbmNlUGF5bWVudHNSZXNwb25zZRJFCghwYXltZW50cxgBIAMoCzIpLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZVBheW1lbnRSZWNvcmRSCHBheW1lbnRz');
@$core.Deprecated('Use getInsuranceClaimsRequestDescriptor instead')
const GetInsuranceClaimsRequest$json = const {
  '1': 'GetInsuranceClaimsRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInsuranceClaimsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimsRequestDescriptor = $convert.base64Decode('ChlHZXRJbnN1cmFuY2VDbGFpbXNSZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getInsuranceClaimsResponseDescriptor instead')
const GetInsuranceClaimsResponse$json = const {
  '1': 'GetInsuranceClaimsResponse',
  '2': const [
    const {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsuranceClaimRecord', '10': 'claims'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInsuranceClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimsResponseDescriptor = $convert.base64Decode('ChpHZXRJbnN1cmFuY2VDbGFpbXNSZXNwb25zZRI/CgZjbGFpbXMYASADKAsyJy5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VDbGFpbVJlY29yZFIGY2xhaW1zEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use getUserInsuranceClaimsRequestDescriptor instead')
const GetUserInsuranceClaimsRequest$json = const {
  '1': 'GetUserInsuranceClaimsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserInsuranceClaimsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsuranceClaimsRequestDescriptor = $convert.base64Decode('Ch1HZXRVc2VySW5zdXJhbmNlQ2xhaW1zUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getUserInsuranceClaimsResponseDescriptor instead')
const GetUserInsuranceClaimsResponse$json = const {
  '1': 'GetUserInsuranceClaimsResponse',
  '2': const [
    const {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsuranceClaimRecord', '10': 'claims'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetUserInsuranceClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsuranceClaimsResponseDescriptor = $convert.base64Decode('Ch5HZXRVc2VySW5zdXJhbmNlQ2xhaW1zUmVzcG9uc2USPwoGY2xhaW1zGAEgAygLMicuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlQ2xhaW1SZWNvcmRSBmNsYWltcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use updateInsuranceClaimRequestDescriptor instead')
const UpdateInsuranceClaimRequest$json = const {
  '1': 'UpdateInsuranceClaimRequest',
  '2': const [
    const {'1': 'claim_id', '3': 1, '4': 1, '5': 9, '10': 'claimId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'documents', '3': 4, '4': 3, '5': 9, '10': 'documents'},
    const {'1': 'additional_info', '3': 5, '4': 3, '5': 11, '6': '.financialproducts.UpdateInsuranceClaimRequest.AdditionalInfoEntry', '10': 'additionalInfo'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'attachments', '3': 7, '4': 3, '5': 9, '10': 'attachments'},
  ],
  '3': const [UpdateInsuranceClaimRequest_AdditionalInfoEntry$json],
};

@$core.Deprecated('Use updateInsuranceClaimRequestDescriptor instead')
const UpdateInsuranceClaimRequest_AdditionalInfoEntry$json = const {
  '1': 'AdditionalInfoEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `UpdateInsuranceClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsuranceClaimRequestDescriptor = $convert.base64Decode('ChtVcGRhdGVJbnN1cmFuY2VDbGFpbVJlcXVlc3QSGQoIY2xhaW1faWQYASABKAlSB2NsYWltSWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIcCglkb2N1bWVudHMYBCADKAlSCWRvY3VtZW50cxJrCg9hZGRpdGlvbmFsX2luZm8YBSADKAsyQi5maW5hbmNpYWxwcm9kdWN0cy5VcGRhdGVJbnN1cmFuY2VDbGFpbVJlcXVlc3QuQWRkaXRpb25hbEluZm9FbnRyeVIOYWRkaXRpb25hbEluZm8SFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSIAoLYXR0YWNobWVudHMYByADKAlSC2F0dGFjaG1lbnRzGkEKE0FkZGl0aW9uYWxJbmZvRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use updateInsuranceClaimResponseDescriptor instead')
const UpdateInsuranceClaimResponse$json = const {
  '1': 'UpdateInsuranceClaimResponse',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsuranceClaimRecord', '10': 'claim'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInsuranceClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsuranceClaimResponseDescriptor = $convert.base64Decode('ChxVcGRhdGVJbnN1cmFuY2VDbGFpbVJlc3BvbnNlEj0KBWNsYWltGAEgASgLMicuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlQ2xhaW1SZWNvcmRSBWNsYWltEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getInsuranceClaimByIdRequestDescriptor instead')
const GetInsuranceClaimByIdRequest$json = const {
  '1': 'GetInsuranceClaimByIdRequest',
  '2': const [
    const {'1': 'claim_id', '3': 1, '4': 1, '5': 9, '10': 'claimId'},
  ],
};

/// Descriptor for `GetInsuranceClaimByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimByIdRequestDescriptor = $convert.base64Decode('ChxHZXRJbnN1cmFuY2VDbGFpbUJ5SWRSZXF1ZXN0EhkKCGNsYWltX2lkGAEgASgJUgdjbGFpbUlk');
@$core.Deprecated('Use getInsuranceClaimByIdResponseDescriptor instead')
const GetInsuranceClaimByIdResponse$json = const {
  '1': 'GetInsuranceClaimByIdResponse',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsuranceClaimRecord', '10': 'claim'},
  ],
};

/// Descriptor for `GetInsuranceClaimByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimByIdResponseDescriptor = $convert.base64Decode('Ch1HZXRJbnN1cmFuY2VDbGFpbUJ5SWRSZXNwb25zZRI9CgVjbGFpbRgBIAEoCzInLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZUNsYWltUmVjb3JkUgVjbGFpbQ==');
@$core.Deprecated('Use updateInsurancePolicyRequestDescriptor instead')
const UpdateInsurancePolicyRequest$json = const {
  '1': 'UpdateInsurancePolicyRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'beneficiary', '3': 2, '4': 1, '5': 9, '10': 'beneficiary'},
    const {'1': 'payment_frequency', '3': 3, '4': 1, '5': 9, '10': 'paymentFrequency'},
    const {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `UpdateInsurancePolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsurancePolicyRequestDescriptor = $convert.base64Decode('ChxVcGRhdGVJbnN1cmFuY2VQb2xpY3lSZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQSIAoLYmVuZWZpY2lhcnkYAiABKAlSC2JlbmVmaWNpYXJ5EisKEXBheW1lbnRfZnJlcXVlbmN5GAMgASgJUhBwYXltZW50RnJlcXVlbmN5EhoKCG1ldGFkYXRhGAQgASgJUghtZXRhZGF0YQ==');
@$core.Deprecated('Use updateInsurancePolicyResponseDescriptor instead')
const UpdateInsurancePolicyResponse$json = const {
  '1': 'UpdateInsurancePolicyResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInsurancePolicyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsurancePolicyResponseDescriptor = $convert.base64Decode('Ch1VcGRhdGVJbnN1cmFuY2VQb2xpY3lSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use generateInsuranceReceiptRequestDescriptor instead')
const GenerateInsuranceReceiptRequest$json = const {
  '1': 'GenerateInsuranceReceiptRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GenerateInsuranceReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateInsuranceReceiptRequestDescriptor = $convert.base64Decode('Ch9HZW5lcmF0ZUluc3VyYW5jZVJlY2VpcHRSZXF1ZXN0Eh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZA==');
@$core.Deprecated('Use generateInsuranceReceiptResponseDescriptor instead')
const GenerateInsuranceReceiptResponse$json = const {
  '1': 'GenerateInsuranceReceiptResponse',
  '2': const [
    const {'1': 'receipt_id', '3': 1, '4': 1, '5': 9, '10': 'receiptId'},
    const {'1': 'receipt_number', '3': 2, '4': 1, '5': 9, '10': 'receiptNumber'},
    const {'1': 'payment', '3': 3, '4': 1, '5': 11, '6': '.financialproducts.InsurancePaymentRecord', '10': 'payment'},
    const {'1': 'policy_number', '3': 4, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'policy_type', '3': 5, '4': 1, '5': 9, '10': 'policyType'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateInsuranceReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateInsuranceReceiptResponseDescriptor = $convert.base64Decode('CiBHZW5lcmF0ZUluc3VyYW5jZVJlY2VpcHRSZXNwb25zZRIdCgpyZWNlaXB0X2lkGAEgASgJUglyZWNlaXB0SWQSJQoOcmVjZWlwdF9udW1iZXIYAiABKAlSDXJlY2VpcHROdW1iZXISQwoHcGF5bWVudBgDIAEoCzIpLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZVBheW1lbnRSZWNvcmRSB3BheW1lbnQSIwoNcG9saWN5X251bWJlchgEIAEoCVIMcG9saWN5TnVtYmVyEh8KC3BvbGljeV90eXBlGAUgASgJUgpwb2xpY3lUeXBlEhgKB21lc3NhZ2UYBiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getUserInsuranceReceiptsRequestDescriptor instead')
const GetUserInsuranceReceiptsRequest$json = const {
  '1': 'GetUserInsuranceReceiptsRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetUserInsuranceReceiptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsuranceReceiptsRequestDescriptor = $convert.base64Decode('Ch9HZXRVc2VySW5zdXJhbmNlUmVjZWlwdHNSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIWCgZvZmZzZXQYAiABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getUserInsuranceReceiptsResponseDescriptor instead')
const GetUserInsuranceReceiptsResponse$json = const {
  '1': 'GetUserInsuranceReceiptsResponse',
  '2': const [
    const {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsurancePaymentRecord', '10': 'receipts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetUserInsuranceReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsuranceReceiptsResponseDescriptor = $convert.base64Decode('CiBHZXRVc2VySW5zdXJhbmNlUmVjZWlwdHNSZXNwb25zZRJFCghyZWNlaXB0cxgBIAMoCzIpLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZVBheW1lbnRSZWNvcmRSCHJlY2VpcHRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use getInsuranceStatisticsRequestDescriptor instead')
const GetInsuranceStatisticsRequest$json = const {
  '1': 'GetInsuranceStatisticsRequest',
};

/// Descriptor for `GetInsuranceStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceStatisticsRequestDescriptor = $convert.base64Decode('Ch1HZXRJbnN1cmFuY2VTdGF0aXN0aWNzUmVxdWVzdA==');
@$core.Deprecated('Use getInsuranceStatisticsResponseDescriptor instead')
const GetInsuranceStatisticsResponse$json = const {
  '1': 'GetInsuranceStatisticsResponse',
  '2': const [
    const {'1': 'active_policies', '3': 1, '4': 1, '5': 5, '10': 'activePolicies'},
    const {'1': 'total_policies', '3': 2, '4': 1, '5': 5, '10': 'totalPolicies'},
    const {'1': 'total_coverage', '3': 3, '4': 1, '5': 3, '10': 'totalCoverage'},
    const {'1': 'total_premiums_paid', '3': 4, '4': 1, '5': 3, '10': 'totalPremiumsPaid'},
    const {'1': 'total_claims', '3': 5, '4': 1, '5': 5, '10': 'totalClaims'},
    const {'1': 'pending_claims', '3': 6, '4': 1, '5': 5, '10': 'pendingClaims'},
    const {'1': 'total_claimed_amount', '3': 7, '4': 1, '5': 3, '10': 'totalClaimedAmount'},
    const {'1': 'total_approved_amount', '3': 8, '4': 1, '5': 3, '10': 'totalApprovedAmount'},
    const {'1': 'next_payment_due', '3': 9, '4': 1, '5': 9, '10': 'nextPaymentDue'},
    const {'1': 'policies_by_type', '3': 10, '4': 3, '5': 11, '6': '.financialproducts.GetInsuranceStatisticsResponse.PoliciesByTypeEntry', '10': 'policiesByType'},
  ],
  '3': const [GetInsuranceStatisticsResponse_PoliciesByTypeEntry$json],
};

@$core.Deprecated('Use getInsuranceStatisticsResponseDescriptor instead')
const GetInsuranceStatisticsResponse_PoliciesByTypeEntry$json = const {
  '1': 'PoliciesByTypeEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetInsuranceStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceStatisticsResponseDescriptor = $convert.base64Decode('Ch5HZXRJbnN1cmFuY2VTdGF0aXN0aWNzUmVzcG9uc2USJwoPYWN0aXZlX3BvbGljaWVzGAEgASgFUg5hY3RpdmVQb2xpY2llcxIlCg50b3RhbF9wb2xpY2llcxgCIAEoBVINdG90YWxQb2xpY2llcxIlCg50b3RhbF9jb3ZlcmFnZRgDIAEoA1INdG90YWxDb3ZlcmFnZRIuChN0b3RhbF9wcmVtaXVtc19wYWlkGAQgASgDUhF0b3RhbFByZW1pdW1zUGFpZBIhCgx0b3RhbF9jbGFpbXMYBSABKAVSC3RvdGFsQ2xhaW1zEiUKDnBlbmRpbmdfY2xhaW1zGAYgASgFUg1wZW5kaW5nQ2xhaW1zEjAKFHRvdGFsX2NsYWltZWRfYW1vdW50GAcgASgDUhJ0b3RhbENsYWltZWRBbW91bnQSMgoVdG90YWxfYXBwcm92ZWRfYW1vdW50GAggASgDUhN0b3RhbEFwcHJvdmVkQW1vdW50EigKEG5leHRfcGF5bWVudF9kdWUYCSABKAlSDm5leHRQYXltZW50RHVlEm8KEHBvbGljaWVzX2J5X3R5cGUYCiADKAsyRS5maW5hbmNpYWxwcm9kdWN0cy5HZXRJbnN1cmFuY2VTdGF0aXN0aWNzUmVzcG9uc2UuUG9saWNpZXNCeVR5cGVFbnRyeVIOcG9saWNpZXNCeVR5cGUaQQoTUG9saWNpZXNCeVR5cGVFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoBVIFdmFsdWU6AjgB');
@$core.Deprecated('Use getInsurancePaymentStatisticsRequestDescriptor instead')
const GetInsurancePaymentStatisticsRequest$json = const {
  '1': 'GetInsurancePaymentStatisticsRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetInsurancePaymentStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentStatisticsRequestDescriptor = $convert.base64Decode('CiRHZXRJbnN1cmFuY2VQYXltZW50U3RhdGlzdGljc1JlcXVlc3QSHQoKc3RhcnRfZGF0ZRgBIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAIgASgJUgdlbmREYXRl');
@$core.Deprecated('Use getInsurancePaymentStatisticsResponseDescriptor instead')
const GetInsurancePaymentStatisticsResponse$json = const {
  '1': 'GetInsurancePaymentStatisticsResponse',
  '2': const [
    const {'1': 'total_payments', '3': 1, '4': 1, '5': 5, '10': 'totalPayments'},
    const {'1': 'completed_payments', '3': 2, '4': 1, '5': 5, '10': 'completedPayments'},
    const {'1': 'pending_payments', '3': 3, '4': 1, '5': 5, '10': 'pendingPayments'},
    const {'1': 'failed_payments', '3': 4, '4': 1, '5': 5, '10': 'failedPayments'},
    const {'1': 'total_amount', '3': 5, '4': 1, '5': 3, '10': 'totalAmount'},
    const {'1': 'completed_amount', '3': 6, '4': 1, '5': 3, '10': 'completedAmount'},
  ],
};

/// Descriptor for `GetInsurancePaymentStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentStatisticsResponseDescriptor = $convert.base64Decode('CiVHZXRJbnN1cmFuY2VQYXltZW50U3RhdGlzdGljc1Jlc3BvbnNlEiUKDnRvdGFsX3BheW1lbnRzGAEgASgFUg10b3RhbFBheW1lbnRzEi0KEmNvbXBsZXRlZF9wYXltZW50cxgCIAEoBVIRY29tcGxldGVkUGF5bWVudHMSKQoQcGVuZGluZ19wYXltZW50cxgDIAEoBVIPcGVuZGluZ1BheW1lbnRzEicKD2ZhaWxlZF9wYXltZW50cxgEIAEoBVIOZmFpbGVkUGF5bWVudHMSIQoMdG90YWxfYW1vdW50GAUgASgDUgt0b3RhbEFtb3VudBIpChBjb21wbGV0ZWRfYW1vdW50GAYgASgDUg9jb21wbGV0ZWRBbW91bnQ=');
@$core.Deprecated('Use autoSaveRuleDescriptor instead')
const AutoSaveRule$json = const {
  '1': 'AutoSaveRule',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'trigger_type', '3': 5, '4': 1, '5': 9, '10': 'triggerType'},
    const {'1': 'amount_type', '3': 6, '4': 1, '5': 9, '10': 'amountType'},
    const {'1': 'amount_value', '3': 7, '4': 1, '5': 1, '10': 'amountValue'},
    const {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account_id', '3': 9, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'frequency', '3': 11, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'schedule_time', '3': 12, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'schedule_day', '3': 13, '4': 1, '5': 5, '10': 'scheduleDay'},
    const {'1': 'round_up_to', '3': 14, '4': 1, '5': 5, '10': 'roundUpTo'},
    const {'1': 'target_amount', '3': 15, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'minimum_balance', '3': 16, '4': 1, '5': 1, '10': 'minimumBalance'},
    const {'1': 'maximum_per_save', '3': 17, '4': 1, '5': 1, '10': 'maximumPerSave'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'last_triggered_at', '3': 20, '4': 1, '5': 9, '10': 'lastTriggeredAt'},
    const {'1': 'trigger_count', '3': 21, '4': 1, '5': 5, '10': 'triggerCount'},
    const {'1': 'total_saved', '3': 22, '4': 1, '5': 1, '10': 'totalSaved'},
  ],
};

/// Descriptor for `AutoSaveRule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveRuleDescriptor = $convert.base64Decode('CgxBdXRvU2F2ZVJ1bGUSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBISCgRuYW1lGAMgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIhCgx0cmlnZ2VyX3R5cGUYBSABKAlSC3RyaWdnZXJUeXBlEh8KC2Ftb3VudF90eXBlGAYgASgJUgphbW91bnRUeXBlEiEKDGFtb3VudF92YWx1ZRgHIAEoAVILYW1vdW50VmFsdWUSKgoRc291cmNlX2FjY291bnRfaWQYCCABKAlSD3NvdXJjZUFjY291bnRJZBI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGAkgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBIWCgZzdGF0dXMYCiABKAlSBnN0YXR1cxIcCglmcmVxdWVuY3kYCyABKAlSCWZyZXF1ZW5jeRIjCg1zY2hlZHVsZV90aW1lGAwgASgJUgxzY2hlZHVsZVRpbWUSIQoMc2NoZWR1bGVfZGF5GA0gASgFUgtzY2hlZHVsZURheRIeCgtyb3VuZF91cF90bxgOIAEoBVIJcm91bmRVcFRvEiMKDXRhcmdldF9hbW91bnQYDyABKAFSDHRhcmdldEFtb3VudBInCg9taW5pbXVtX2JhbGFuY2UYECABKAFSDm1pbmltdW1CYWxhbmNlEigKEG1heGltdW1fcGVyX3NhdmUYESABKAFSDm1heGltdW1QZXJTYXZlEh0KCmNyZWF0ZWRfYXQYEiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GBMgASgJUgl1cGRhdGVkQXQSKgoRbGFzdF90cmlnZ2VyZWRfYXQYFCABKAlSD2xhc3RUcmlnZ2VyZWRBdBIjCg10cmlnZ2VyX2NvdW50GBUgASgFUgx0cmlnZ2VyQ291bnQSHwoLdG90YWxfc2F2ZWQYFiABKAFSCnRvdGFsU2F2ZWQ=');
@$core.Deprecated('Use autoSaveTransactionDescriptor instead')
const AutoSaveTransaction$json = const {
  '1': 'AutoSaveTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'rule_id', '3': 2, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account_id', '3': 5, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'trigger_type', '3': 7, '4': 1, '5': 9, '10': 'triggerType'},
    const {'1': 'trigger_reason', '3': 8, '4': 1, '5': 9, '10': 'triggerReason'},
    const {'1': 'success', '3': 9, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_message', '3': 10, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `AutoSaveTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveTransactionDescriptor = $convert.base64Decode('ChNBdXRvU2F2ZVRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIXCgdydWxlX2lkGAIgASgJUgZydWxlSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEioKEXNvdXJjZV9hY2NvdW50X2lkGAQgASgJUg9zb3VyY2VBY2NvdW50SWQSNAoWZGVzdGluYXRpb25fYWNjb3VudF9pZBgFIAEoCVIUZGVzdGluYXRpb25BY2NvdW50SWQSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSIQoMdHJpZ2dlcl90eXBlGAcgASgJUgt0cmlnZ2VyVHlwZRIlCg50cmlnZ2VyX3JlYXNvbhgIIAEoCVINdHJpZ2dlclJlYXNvbhIYCgdzdWNjZXNzGAkgASgIUgdzdWNjZXNzEiMKDWVycm9yX21lc3NhZ2UYCiABKAlSDGVycm9yTWVzc2FnZRIdCgpjcmVhdGVkX2F0GAsgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use autoSaveStatisticsDescriptor instead')
const AutoSaveStatistics$json = const {
  '1': 'AutoSaveStatistics',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'active_rules_count', '3': 2, '4': 1, '5': 5, '10': 'activeRulesCount'},
    const {'1': 'total_saved_all_time', '3': 3, '4': 1, '5': 1, '10': 'totalSavedAllTime'},
    const {'1': 'total_saved_this_month', '3': 4, '4': 1, '5': 1, '10': 'totalSavedThisMonth'},
    const {'1': 'total_saved_this_week', '3': 5, '4': 1, '5': 1, '10': 'totalSavedThisWeek'},
    const {'1': 'total_transactions', '3': 6, '4': 1, '5': 5, '10': 'totalTransactions'},
    const {'1': 'average_save_amount', '3': 7, '4': 1, '5': 1, '10': 'averageSaveAmount'},
    const {'1': 'most_active_rule', '3': 8, '4': 1, '5': 11, '6': '.financialproducts.AutoSaveRule', '10': 'mostActiveRule'},
  ],
};

/// Descriptor for `AutoSaveStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveStatisticsDescriptor = $convert.base64Decode('ChJBdXRvU2F2ZVN0YXRpc3RpY3MSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiwKEmFjdGl2ZV9ydWxlc19jb3VudBgCIAEoBVIQYWN0aXZlUnVsZXNDb3VudBIvChR0b3RhbF9zYXZlZF9hbGxfdGltZRgDIAEoAVIRdG90YWxTYXZlZEFsbFRpbWUSMwoWdG90YWxfc2F2ZWRfdGhpc19tb250aBgEIAEoAVITdG90YWxTYXZlZFRoaXNNb250aBIxChV0b3RhbF9zYXZlZF90aGlzX3dlZWsYBSABKAFSEnRvdGFsU2F2ZWRUaGlzV2VlaxItChJ0b3RhbF90cmFuc2FjdGlvbnMYBiABKAVSEXRvdGFsVHJhbnNhY3Rpb25zEi4KE2F2ZXJhZ2Vfc2F2ZV9hbW91bnQYByABKAFSEWF2ZXJhZ2VTYXZlQW1vdW50EkkKEG1vc3RfYWN0aXZlX3J1bGUYCCABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5BdXRvU2F2ZVJ1bGVSDm1vc3RBY3RpdmVSdWxl');
@$core.Deprecated('Use createAutoSaveRuleRequest2Descriptor instead')
const CreateAutoSaveRuleRequest2$json = const {
  '1': 'CreateAutoSaveRuleRequest2',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'trigger_type', '3': 3, '4': 1, '5': 9, '10': 'triggerType'},
    const {'1': 'amount_type', '3': 4, '4': 1, '5': 9, '10': 'amountType'},
    const {'1': 'amount_value', '3': 5, '4': 1, '5': 1, '10': 'amountValue'},
    const {'1': 'source_account_id', '3': 6, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account_id', '3': 7, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'frequency', '3': 8, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'schedule_time', '3': 9, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'schedule_day', '3': 10, '4': 1, '5': 5, '10': 'scheduleDay'},
    const {'1': 'round_up_to', '3': 11, '4': 1, '5': 5, '10': 'roundUpTo'},
    const {'1': 'target_amount', '3': 12, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'minimum_balance', '3': 13, '4': 1, '5': 1, '10': 'minimumBalance'},
    const {'1': 'maximum_per_save', '3': 14, '4': 1, '5': 1, '10': 'maximumPerSave'},
  ],
};

/// Descriptor for `CreateAutoSaveRuleRequest2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveRuleRequest2Descriptor = $convert.base64Decode('ChpDcmVhdGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0MhISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgASgJUgtkZXNjcmlwdGlvbhIhCgx0cmlnZ2VyX3R5cGUYAyABKAlSC3RyaWdnZXJUeXBlEh8KC2Ftb3VudF90eXBlGAQgASgJUgphbW91bnRUeXBlEiEKDGFtb3VudF92YWx1ZRgFIAEoAVILYW1vdW50VmFsdWUSKgoRc291cmNlX2FjY291bnRfaWQYBiABKAlSD3NvdXJjZUFjY291bnRJZBI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGAcgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBIcCglmcmVxdWVuY3kYCCABKAlSCWZyZXF1ZW5jeRIjCg1zY2hlZHVsZV90aW1lGAkgASgJUgxzY2hlZHVsZVRpbWUSIQoMc2NoZWR1bGVfZGF5GAogASgFUgtzY2hlZHVsZURheRIeCgtyb3VuZF91cF90bxgLIAEoBVIJcm91bmRVcFRvEiMKDXRhcmdldF9hbW91bnQYDCABKAFSDHRhcmdldEFtb3VudBInCg9taW5pbXVtX2JhbGFuY2UYDSABKAFSDm1pbmltdW1CYWxhbmNlEigKEG1heGltdW1fcGVyX3NhdmUYDiABKAFSDm1heGltdW1QZXJTYXZl');
@$core.Deprecated('Use createAutoSaveRuleResponse2Descriptor instead')
const CreateAutoSaveRuleResponse2$json = const {
  '1': 'CreateAutoSaveRuleResponse2',
  '2': const [
    const {'1': 'rule', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.AutoSaveRule', '10': 'rule'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAutoSaveRuleResponse2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveRuleResponse2Descriptor = $convert.base64Decode('ChtDcmVhdGVBdXRvU2F2ZVJ1bGVSZXNwb25zZTISMwoEcnVsZRgBIAEoCzIfLmZpbmFuY2lhbHByb2R1Y3RzLkF1dG9TYXZlUnVsZVIEcnVsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getAutoSaveRulesRequest2Descriptor instead')
const GetAutoSaveRulesRequest2$json = const {
  '1': 'GetAutoSaveRulesRequest2',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetAutoSaveRulesRequest2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveRulesRequest2Descriptor = $convert.base64Decode('ChhHZXRBdXRvU2F2ZVJ1bGVzUmVxdWVzdDISHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use getAutoSaveRulesResponse2Descriptor instead')
const GetAutoSaveRulesResponse2$json = const {
  '1': 'GetAutoSaveRulesResponse2',
  '2': const [
    const {'1': 'rules', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.AutoSaveRule', '10': 'rules'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAutoSaveRulesResponse2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveRulesResponse2Descriptor = $convert.base64Decode('ChlHZXRBdXRvU2F2ZVJ1bGVzUmVzcG9uc2UyEjUKBXJ1bGVzGAEgAygLMh8uZmluYW5jaWFscHJvZHVjdHMuQXV0b1NhdmVSdWxlUgVydWxlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use updateAutoSaveRuleRequest2Descriptor instead')
const UpdateAutoSaveRuleRequest2$json = const {
  '1': 'UpdateAutoSaveRuleRequest2',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'amount_type', '3': 4, '4': 1, '5': 9, '10': 'amountType'},
    const {'1': 'amount_value', '3': 5, '4': 1, '5': 1, '10': 'amountValue'},
    const {'1': 'frequency', '3': 6, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'schedule_time', '3': 7, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'schedule_day', '3': 8, '4': 1, '5': 5, '10': 'scheduleDay'},
    const {'1': 'round_up_to', '3': 9, '4': 1, '5': 5, '10': 'roundUpTo'},
    const {'1': 'target_amount', '3': 10, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'minimum_balance', '3': 11, '4': 1, '5': 1, '10': 'minimumBalance'},
    const {'1': 'maximum_per_save', '3': 12, '4': 1, '5': 1, '10': 'maximumPerSave'},
  ],
};

/// Descriptor for `UpdateAutoSaveRuleRequest2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveRuleRequest2Descriptor = $convert.base64Decode('ChpVcGRhdGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0MhIXCgdydWxlX2lkGAEgASgJUgZydWxlSWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SHwoLYW1vdW50X3R5cGUYBCABKAlSCmFtb3VudFR5cGUSIQoMYW1vdW50X3ZhbHVlGAUgASgBUgthbW91bnRWYWx1ZRIcCglmcmVxdWVuY3kYBiABKAlSCWZyZXF1ZW5jeRIjCg1zY2hlZHVsZV90aW1lGAcgASgJUgxzY2hlZHVsZVRpbWUSIQoMc2NoZWR1bGVfZGF5GAggASgFUgtzY2hlZHVsZURheRIeCgtyb3VuZF91cF90bxgJIAEoBVIJcm91bmRVcFRvEiMKDXRhcmdldF9hbW91bnQYCiABKAFSDHRhcmdldEFtb3VudBInCg9taW5pbXVtX2JhbGFuY2UYCyABKAFSDm1pbmltdW1CYWxhbmNlEigKEG1heGltdW1fcGVyX3NhdmUYDCABKAFSDm1heGltdW1QZXJTYXZl');
@$core.Deprecated('Use updateAutoSaveRuleResponse2Descriptor instead')
const UpdateAutoSaveRuleResponse2$json = const {
  '1': 'UpdateAutoSaveRuleResponse2',
  '2': const [
    const {'1': 'rule', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.AutoSaveRule', '10': 'rule'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAutoSaveRuleResponse2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveRuleResponse2Descriptor = $convert.base64Decode('ChtVcGRhdGVBdXRvU2F2ZVJ1bGVSZXNwb25zZTISMwoEcnVsZRgBIAEoCzIfLmZpbmFuY2lhbHByb2R1Y3RzLkF1dG9TYXZlUnVsZVIEcnVsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use toggleAutoSaveRuleRequest2Descriptor instead')
const ToggleAutoSaveRuleRequest2$json = const {
  '1': 'ToggleAutoSaveRuleRequest2',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
  ],
};

/// Descriptor for `ToggleAutoSaveRuleRequest2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleAutoSaveRuleRequest2Descriptor = $convert.base64Decode('ChpUb2dnbGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0MhIXCgdydWxlX2lkGAEgASgJUgZydWxlSWQSFgoGYWN0aW9uGAIgASgJUgZhY3Rpb24=');
@$core.Deprecated('Use toggleAutoSaveRuleResponse2Descriptor instead')
const ToggleAutoSaveRuleResponse2$json = const {
  '1': 'ToggleAutoSaveRuleResponse2',
  '2': const [
    const {'1': 'rule', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.AutoSaveRule', '10': 'rule'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ToggleAutoSaveRuleResponse2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleAutoSaveRuleResponse2Descriptor = $convert.base64Decode('ChtUb2dnbGVBdXRvU2F2ZVJ1bGVSZXNwb25zZTISMwoEcnVsZRgBIAEoCzIfLmZpbmFuY2lhbHByb2R1Y3RzLkF1dG9TYXZlUnVsZVIEcnVsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteAutoSaveRuleRequest2Descriptor instead')
const DeleteAutoSaveRuleRequest2$json = const {
  '1': 'DeleteAutoSaveRuleRequest2',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
  ],
};

/// Descriptor for `DeleteAutoSaveRuleRequest2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveRuleRequest2Descriptor = $convert.base64Decode('ChpEZWxldGVBdXRvU2F2ZVJ1bGVSZXF1ZXN0MhIXCgdydWxlX2lkGAEgASgJUgZydWxlSWQ=');
@$core.Deprecated('Use deleteAutoSaveRuleResponse2Descriptor instead')
const DeleteAutoSaveRuleResponse2$json = const {
  '1': 'DeleteAutoSaveRuleResponse2',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAutoSaveRuleResponse2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveRuleResponse2Descriptor = $convert.base64Decode('ChtEZWxldGVBdXRvU2F2ZVJ1bGVSZXNwb25zZTISGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getAutoSaveTransactionsRequest2Descriptor instead')
const GetAutoSaveTransactionsRequest2$json = const {
  '1': 'GetAutoSaveTransactionsRequest2',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAutoSaveTransactionsRequest2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveTransactionsRequest2Descriptor = $convert.base64Decode('Ch9HZXRBdXRvU2F2ZVRyYW5zYWN0aW9uc1JlcXVlc3QyEhcKB3J1bGVfaWQYASABKAlSBnJ1bGVJZBIdCgphY2NvdW50X2lkGAIgASgJUglhY2NvdW50SWQSFAoFbGltaXQYAyABKAVSBWxpbWl0EhYKBm9mZnNldBgEIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getAutoSaveTransactionsResponse2Descriptor instead')
const GetAutoSaveTransactionsResponse2$json = const {
  '1': 'GetAutoSaveTransactionsResponse2',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.AutoSaveTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAutoSaveTransactionsResponse2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveTransactionsResponse2Descriptor = $convert.base64Decode('CiBHZXRBdXRvU2F2ZVRyYW5zYWN0aW9uc1Jlc3BvbnNlMhJKCgx0cmFuc2FjdGlvbnMYASADKAsyJi5maW5hbmNpYWxwcm9kdWN0cy5BdXRvU2F2ZVRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getAutoSaveStatisticsRequest2Descriptor instead')
const GetAutoSaveStatisticsRequest2$json = const {
  '1': 'GetAutoSaveStatisticsRequest2',
};

/// Descriptor for `GetAutoSaveStatisticsRequest2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveStatisticsRequest2Descriptor = $convert.base64Decode('Ch1HZXRBdXRvU2F2ZVN0YXRpc3RpY3NSZXF1ZXN0Mg==');
@$core.Deprecated('Use getAutoSaveStatisticsResponse2Descriptor instead')
const GetAutoSaveStatisticsResponse2$json = const {
  '1': 'GetAutoSaveStatisticsResponse2',
  '2': const [
    const {'1': 'statistics', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.AutoSaveStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetAutoSaveStatisticsResponse2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSaveStatisticsResponse2Descriptor = $convert.base64Decode('Ch5HZXRBdXRvU2F2ZVN0YXRpc3RpY3NSZXNwb25zZTISRQoKc3RhdGlzdGljcxgBIAEoCzIlLmZpbmFuY2lhbHByb2R1Y3RzLkF1dG9TYXZlU3RhdGlzdGljc1IKc3RhdGlzdGljcw==');
@$core.Deprecated('Use triggerAutoSaveRequest2Descriptor instead')
const TriggerAutoSaveRequest2$json = const {
  '1': 'TriggerAutoSaveRequest2',
  '2': const [
    const {'1': 'rule_id', '3': 1, '4': 1, '5': 9, '10': 'ruleId'},
    const {'1': 'custom_amount', '3': 2, '4': 1, '5': 1, '10': 'customAmount'},
    const {'1': 'transaction_pin_token', '3': 4, '4': 1, '5': 9, '10': 'transactionPinToken'},
  ],
};

/// Descriptor for `TriggerAutoSaveRequest2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerAutoSaveRequest2Descriptor = $convert.base64Decode('ChdUcmlnZ2VyQXV0b1NhdmVSZXF1ZXN0MhIXCgdydWxlX2lkGAEgASgJUgZydWxlSWQSIwoNY3VzdG9tX2Ftb3VudBgCIAEoAVIMY3VzdG9tQW1vdW50EjIKFXRyYW5zYWN0aW9uX3Bpbl90b2tlbhgEIAEoCVITdHJhbnNhY3Rpb25QaW5Ub2tlbg==');
@$core.Deprecated('Use triggerAutoSaveResponse2Descriptor instead')
const TriggerAutoSaveResponse2$json = const {
  '1': 'TriggerAutoSaveResponse2',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.AutoSaveTransaction', '10': 'transaction'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TriggerAutoSaveResponse2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerAutoSaveResponse2Descriptor = $convert.base64Decode('ChhUcmlnZ2VyQXV0b1NhdmVSZXNwb25zZTISSAoLdHJhbnNhY3Rpb24YASABKAsyJi5maW5hbmNpYWxwcm9kdWN0cy5BdXRvU2F2ZVRyYW5zYWN0aW9uUgt0cmFuc2FjdGlvbhIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use notificationChannelDescriptor instead')
const NotificationChannel$json = const {
  '1': 'NotificationChannel',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'crowdfund_id', '3': 2, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'creator_user_id', '3': 3, '4': 1, '5': 9, '10': 'creatorUserId'},
    const {'1': 'channel_type', '3': 4, '4': 1, '5': 14, '6': '.financialproducts.NotificationChannelType', '10': 'channelType'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.financialproducts.NotificationChannelStatus', '10': 'status'},
    const {'1': 'channel_name', '3': 6, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'channel_identifier', '3': 7, '4': 1, '5': 9, '10': 'channelIdentifier'},
    const {'1': 'channel_username', '3': 8, '4': 1, '5': 9, '10': 'channelUsername'},
    const {'1': 'enabled_events', '3': 9, '4': 3, '5': 14, '6': '.financialproducts.NotificationEventType', '10': 'enabledEvents'},
    const {'1': 'preferences', '3': 10, '4': 1, '5': 11, '6': '.financialproducts.NotificationPreferences', '10': 'preferences'},
    const {'1': 'last_notification_at', '3': 11, '4': 1, '5': 9, '10': 'lastNotificationAt'},
    const {'1': 'notification_count', '3': 12, '4': 1, '5': 5, '10': 'notificationCount'},
    const {'1': 'failure_count', '3': 13, '4': 1, '5': 5, '10': 'failureCount'},
    const {'1': 'last_error', '3': 14, '4': 1, '5': 9, '10': 'lastError'},
    const {'1': 'created_at', '3': 15, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 16, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `NotificationChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationChannelDescriptor = $convert.base64Decode('ChNOb3RpZmljYXRpb25DaGFubmVsEg4KAmlkGAEgASgJUgJpZBIhCgxjcm93ZGZ1bmRfaWQYAiABKAlSC2Nyb3dkZnVuZElkEiYKD2NyZWF0b3JfdXNlcl9pZBgDIAEoCVINY3JlYXRvclVzZXJJZBJNCgxjaGFubmVsX3R5cGUYBCABKA4yKi5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25DaGFubmVsVHlwZVILY2hhbm5lbFR5cGUSRAoGc3RhdHVzGAUgASgOMiwuZmluYW5jaWFscHJvZHVjdHMuTm90aWZpY2F0aW9uQ2hhbm5lbFN0YXR1c1IGc3RhdHVzEiEKDGNoYW5uZWxfbmFtZRgGIAEoCVILY2hhbm5lbE5hbWUSLQoSY2hhbm5lbF9pZGVudGlmaWVyGAcgASgJUhFjaGFubmVsSWRlbnRpZmllchIpChBjaGFubmVsX3VzZXJuYW1lGAggASgJUg9jaGFubmVsVXNlcm5hbWUSTwoOZW5hYmxlZF9ldmVudHMYCSADKA4yKC5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25FdmVudFR5cGVSDWVuYWJsZWRFdmVudHMSTAoLcHJlZmVyZW5jZXMYCiABKAsyKi5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25QcmVmZXJlbmNlc1ILcHJlZmVyZW5jZXMSMAoUbGFzdF9ub3RpZmljYXRpb25fYXQYCyABKAlSEmxhc3ROb3RpZmljYXRpb25BdBItChJub3RpZmljYXRpb25fY291bnQYDCABKAVSEW5vdGlmaWNhdGlvbkNvdW50EiMKDWZhaWx1cmVfY291bnQYDSABKAVSDGZhaWx1cmVDb3VudBIdCgpsYXN0X2Vycm9yGA4gASgJUglsYXN0RXJyb3ISHQoKY3JlYXRlZF9hdBgPIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYECABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use notificationPreferencesDescriptor instead')
const NotificationPreferences$json = const {
  '1': 'NotificationPreferences',
  '2': const [
    const {'1': 'include_donor_name', '3': 1, '4': 1, '5': 8, '10': 'includeDonorName'},
    const {'1': 'include_amount', '3': 2, '4': 1, '5': 8, '10': 'includeAmount'},
    const {'1': 'include_message', '3': 3, '4': 1, '5': 8, '10': 'includeMessage'},
    const {'1': 'include_progress', '3': 4, '4': 1, '5': 8, '10': 'includeProgress'},
    const {'1': 'include_leaderboard', '3': 5, '4': 1, '5': 8, '10': 'includeLeaderboard'},
    const {'1': 'large_donation_threshold', '3': 6, '4': 1, '5': 1, '10': 'largeDonationThreshold'},
    const {'1': 'message_template', '3': 7, '4': 1, '5': 9, '10': 'messageTemplate'},
    const {'1': 'language', '3': 8, '4': 1, '5': 9, '10': 'language'},
    const {'1': 'quiet_hours_enabled', '3': 9, '4': 1, '5': 8, '10': 'quietHoursEnabled'},
    const {'1': 'quiet_hours_start', '3': 10, '4': 1, '5': 9, '10': 'quietHoursStart'},
    const {'1': 'quiet_hours_end', '3': 11, '4': 1, '5': 9, '10': 'quietHoursEnd'},
    const {'1': 'timezone', '3': 12, '4': 1, '5': 9, '10': 'timezone'},
  ],
};

/// Descriptor for `NotificationPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationPreferencesDescriptor = $convert.base64Decode('ChdOb3RpZmljYXRpb25QcmVmZXJlbmNlcxIsChJpbmNsdWRlX2Rvbm9yX25hbWUYASABKAhSEGluY2x1ZGVEb25vck5hbWUSJQoOaW5jbHVkZV9hbW91bnQYAiABKAhSDWluY2x1ZGVBbW91bnQSJwoPaW5jbHVkZV9tZXNzYWdlGAMgASgIUg5pbmNsdWRlTWVzc2FnZRIpChBpbmNsdWRlX3Byb2dyZXNzGAQgASgIUg9pbmNsdWRlUHJvZ3Jlc3MSLwoTaW5jbHVkZV9sZWFkZXJib2FyZBgFIAEoCFISaW5jbHVkZUxlYWRlcmJvYXJkEjgKGGxhcmdlX2RvbmF0aW9uX3RocmVzaG9sZBgGIAEoAVIWbGFyZ2VEb25hdGlvblRocmVzaG9sZBIpChBtZXNzYWdlX3RlbXBsYXRlGAcgASgJUg9tZXNzYWdlVGVtcGxhdGUSGgoIbGFuZ3VhZ2UYCCABKAlSCGxhbmd1YWdlEi4KE3F1aWV0X2hvdXJzX2VuYWJsZWQYCSABKAhSEXF1aWV0SG91cnNFbmFibGVkEioKEXF1aWV0X2hvdXJzX3N0YXJ0GAogASgJUg9xdWlldEhvdXJzU3RhcnQSJgoPcXVpZXRfaG91cnNfZW5kGAsgASgJUg1xdWlldEhvdXJzRW5kEhoKCHRpbWV6b25lGAwgASgJUgh0aW1lem9uZQ==');
@$core.Deprecated('Use notificationDeliveryDescriptor instead')
const NotificationDelivery$json = const {
  '1': 'NotificationDelivery',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
    const {'1': 'crowdfund_id', '3': 3, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'event_type', '3': 4, '4': 1, '5': 14, '6': '.financialproducts.NotificationEventType', '10': 'eventType'},
    const {'1': 'event_data', '3': 5, '4': 1, '5': 9, '10': 'eventData'},
    const {'1': 'message_content', '3': 6, '4': 1, '5': 9, '10': 'messageContent'},
    const {'1': 'success', '3': 7, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_message', '3': 8, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'retry_count', '3': 9, '4': 1, '5': 5, '10': 'retryCount'},
    const {'1': 'platform_message_id', '3': 10, '4': 1, '5': 9, '10': 'platformMessageId'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'delivered_at', '3': 12, '4': 1, '5': 9, '10': 'deliveredAt'},
  ],
};

/// Descriptor for `NotificationDelivery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationDeliveryDescriptor = $convert.base64Decode('ChROb3RpZmljYXRpb25EZWxpdmVyeRIOCgJpZBgBIAEoCVICaWQSHQoKY2hhbm5lbF9pZBgCIAEoCVIJY2hhbm5lbElkEiEKDGNyb3dkZnVuZF9pZBgDIAEoCVILY3Jvd2RmdW5kSWQSRwoKZXZlbnRfdHlwZRgEIAEoDjIoLmZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvbkV2ZW50VHlwZVIJZXZlbnRUeXBlEh0KCmV2ZW50X2RhdGEYBSABKAlSCWV2ZW50RGF0YRInCg9tZXNzYWdlX2NvbnRlbnQYBiABKAlSDm1lc3NhZ2VDb250ZW50EhgKB3N1Y2Nlc3MYByABKAhSB3N1Y2Nlc3MSIwoNZXJyb3JfbWVzc2FnZRgIIAEoCVIMZXJyb3JNZXNzYWdlEh8KC3JldHJ5X2NvdW50GAkgASgFUgpyZXRyeUNvdW50Ei4KE3BsYXRmb3JtX21lc3NhZ2VfaWQYCiABKAlSEXBsYXRmb3JtTWVzc2FnZUlkEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIhCgxkZWxpdmVyZWRfYXQYDCABKAlSC2RlbGl2ZXJlZEF0');
@$core.Deprecated('Use connectNotificationChannelRequestDescriptor instead')
const ConnectNotificationChannelRequest$json = const {
  '1': 'ConnectNotificationChannelRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'channel_type', '3': 2, '4': 1, '5': 14, '6': '.financialproducts.NotificationChannelType', '10': 'channelType'},
    const {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'telegram', '3': 4, '4': 1, '5': 11, '6': '.financialproducts.TelegramConnectionData', '9': 0, '10': 'telegram'},
    const {'1': 'discord', '3': 5, '4': 1, '5': 11, '6': '.financialproducts.DiscordConnectionData', '9': 0, '10': 'discord'},
    const {'1': 'whatsapp_business', '3': 6, '4': 1, '5': 11, '6': '.financialproducts.WhatsAppBusinessConnectionData', '9': 0, '10': 'whatsappBusiness'},
    const {'1': 'slack', '3': 7, '4': 1, '5': 11, '6': '.financialproducts.SlackConnectionData', '9': 0, '10': 'slack'},
    const {'1': 'enabled_events', '3': 8, '4': 3, '5': 14, '6': '.financialproducts.NotificationEventType', '10': 'enabledEvents'},
    const {'1': 'preferences', '3': 9, '4': 1, '5': 11, '6': '.financialproducts.NotificationPreferences', '10': 'preferences'},
  ],
  '8': const [
    const {'1': 'connection_data'},
  ],
};

/// Descriptor for `ConnectNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectNotificationChannelRequestDescriptor = $convert.base64Decode('CiFDb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlcXVlc3QSIQoMY3Jvd2RmdW5kX2lkGAEgASgJUgtjcm93ZGZ1bmRJZBJNCgxjaGFubmVsX3R5cGUYAiABKA4yKi5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25DaGFubmVsVHlwZVILY2hhbm5lbFR5cGUSIQoMY2hhbm5lbF9uYW1lGAMgASgJUgtjaGFubmVsTmFtZRJHCgh0ZWxlZ3JhbRgEIAEoCzIpLmZpbmFuY2lhbHByb2R1Y3RzLlRlbGVncmFtQ29ubmVjdGlvbkRhdGFIAFIIdGVsZWdyYW0SRAoHZGlzY29yZBgFIAEoCzIoLmZpbmFuY2lhbHByb2R1Y3RzLkRpc2NvcmRDb25uZWN0aW9uRGF0YUgAUgdkaXNjb3JkEmAKEXdoYXRzYXBwX2J1c2luZXNzGAYgASgLMjEuZmluYW5jaWFscHJvZHVjdHMuV2hhdHNBcHBCdXNpbmVzc0Nvbm5lY3Rpb25EYXRhSABSEHdoYXRzYXBwQnVzaW5lc3MSPgoFc2xhY2sYByABKAsyJi5maW5hbmNpYWxwcm9kdWN0cy5TbGFja0Nvbm5lY3Rpb25EYXRhSABSBXNsYWNrEk8KDmVuYWJsZWRfZXZlbnRzGAggAygOMiguZmluYW5jaWFscHJvZHVjdHMuTm90aWZpY2F0aW9uRXZlbnRUeXBlUg1lbmFibGVkRXZlbnRzEkwKC3ByZWZlcmVuY2VzGAkgASgLMiouZmluYW5jaWFscHJvZHVjdHMuTm90aWZpY2F0aW9uUHJlZmVyZW5jZXNSC3ByZWZlcmVuY2VzQhEKD2Nvbm5lY3Rpb25fZGF0YQ==');
@$core.Deprecated('Use telegramConnectionDataDescriptor instead')
const TelegramConnectionData$json = const {
  '1': 'TelegramConnectionData',
  '2': const [
    const {'1': 'chat_id', '3': 1, '4': 1, '5': 9, '10': 'chatId'},
    const {'1': 'verification_code', '3': 2, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
};

/// Descriptor for `TelegramConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List telegramConnectionDataDescriptor = $convert.base64Decode('ChZUZWxlZ3JhbUNvbm5lY3Rpb25EYXRhEhcKB2NoYXRfaWQYASABKAlSBmNoYXRJZBIrChF2ZXJpZmljYXRpb25fY29kZRgCIAEoCVIQdmVyaWZpY2F0aW9uQ29kZQ==');
@$core.Deprecated('Use discordConnectionDataDescriptor instead')
const DiscordConnectionData$json = const {
  '1': 'DiscordConnectionData',
  '2': const [
    const {'1': 'webhook_url', '3': 1, '4': 1, '5': 9, '10': 'webhookUrl'},
    const {'1': 'server_name', '3': 2, '4': 1, '5': 9, '10': 'serverName'},
    const {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `DiscordConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List discordConnectionDataDescriptor = $convert.base64Decode('ChVEaXNjb3JkQ29ubmVjdGlvbkRhdGESHwoLd2ViaG9va191cmwYASABKAlSCndlYmhvb2tVcmwSHwoLc2VydmVyX25hbWUYAiABKAlSCnNlcnZlck5hbWUSIQoMY2hhbm5lbF9uYW1lGAMgASgJUgtjaGFubmVsTmFtZQ==');
@$core.Deprecated('Use whatsAppBusinessConnectionDataDescriptor instead')
const WhatsAppBusinessConnectionData$json = const {
  '1': 'WhatsAppBusinessConnectionData',
  '2': const [
    const {'1': 'phone_number_id', '3': 1, '4': 1, '5': 9, '10': 'phoneNumberId'},
    const {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'recipient_id', '3': 3, '4': 1, '5': 9, '10': 'recipientId'},
  ],
};

/// Descriptor for `WhatsAppBusinessConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List whatsAppBusinessConnectionDataDescriptor = $convert.base64Decode('Ch5XaGF0c0FwcEJ1c2luZXNzQ29ubmVjdGlvbkRhdGESJgoPcGhvbmVfbnVtYmVyX2lkGAEgASgJUg1waG9uZU51bWJlcklkEiEKDGFjY2Vzc190b2tlbhgCIAEoCVILYWNjZXNzVG9rZW4SIQoMcmVjaXBpZW50X2lkGAMgASgJUgtyZWNpcGllbnRJZA==');
@$core.Deprecated('Use slackConnectionDataDescriptor instead')
const SlackConnectionData$json = const {
  '1': 'SlackConnectionData',
  '2': const [
    const {'1': 'webhook_url', '3': 1, '4': 1, '5': 9, '10': 'webhookUrl'},
    const {'1': 'workspace_name', '3': 2, '4': 1, '5': 9, '10': 'workspaceName'},
    const {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `SlackConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List slackConnectionDataDescriptor = $convert.base64Decode('ChNTbGFja0Nvbm5lY3Rpb25EYXRhEh8KC3dlYmhvb2tfdXJsGAEgASgJUgp3ZWJob29rVXJsEiUKDndvcmtzcGFjZV9uYW1lGAIgASgJUg13b3Jrc3BhY2VOYW1lEiEKDGNoYW5uZWxfbmFtZRgDIAEoCVILY2hhbm5lbE5hbWU=');
@$core.Deprecated('Use connectNotificationChannelResponseDescriptor instead')
const ConnectNotificationChannelResponse$json = const {
  '1': 'ConnectNotificationChannelResponse',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.NotificationChannel', '10': 'channel'},
    const {'1': 'requires_verification', '3': 2, '4': 1, '5': 8, '10': 'requiresVerification'},
    const {'1': 'verification_instructions', '3': 3, '4': 1, '5': 9, '10': 'verificationInstructions'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ConnectNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectNotificationChannelResponseDescriptor = $convert.base64Decode('CiJDb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlc3BvbnNlEkAKB2NoYW5uZWwYASABKAsyJi5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25DaGFubmVsUgdjaGFubmVsEjMKFXJlcXVpcmVzX3ZlcmlmaWNhdGlvbhgCIAEoCFIUcmVxdWlyZXNWZXJpZmljYXRpb24SOwoZdmVyaWZpY2F0aW9uX2luc3RydWN0aW9ucxgDIAEoCVIYdmVyaWZpY2F0aW9uSW5zdHJ1Y3Rpb25zEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use disconnectNotificationChannelRequestDescriptor instead')
const DisconnectNotificationChannelRequest$json = const {
  '1': 'DisconnectNotificationChannelRequest',
  '2': const [
    const {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `DisconnectNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectNotificationChannelRequestDescriptor = $convert.base64Decode('CiREaXNjb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlcXVlc3QSHQoKY2hhbm5lbF9pZBgBIAEoCVIJY2hhbm5lbElk');
@$core.Deprecated('Use disconnectNotificationChannelResponseDescriptor instead')
const DisconnectNotificationChannelResponse$json = const {
  '1': 'DisconnectNotificationChannelResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DisconnectNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectNotificationChannelResponseDescriptor = $convert.base64Decode('CiVEaXNjb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getNotificationChannelsRequestDescriptor instead')
const GetNotificationChannelsRequest$json = const {
  '1': 'GetNotificationChannelsRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `GetNotificationChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationChannelsRequestDescriptor = $convert.base64Decode('Ch5HZXROb3RpZmljYXRpb25DaGFubmVsc1JlcXVlc3QSIQoMY3Jvd2RmdW5kX2lkGAEgASgJUgtjcm93ZGZ1bmRJZA==');
@$core.Deprecated('Use getNotificationChannelsResponseDescriptor instead')
const GetNotificationChannelsResponse$json = const {
  '1': 'GetNotificationChannelsResponse',
  '2': const [
    const {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.NotificationChannel', '10': 'channels'},
  ],
};

/// Descriptor for `GetNotificationChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationChannelsResponseDescriptor = $convert.base64Decode('Ch9HZXROb3RpZmljYXRpb25DaGFubmVsc1Jlc3BvbnNlEkIKCGNoYW5uZWxzGAEgAygLMiYuZmluYW5jaWFscHJvZHVjdHMuTm90aWZpY2F0aW9uQ2hhbm5lbFIIY2hhbm5lbHM=');
@$core.Deprecated('Use updateNotificationChannelRequestDescriptor instead')
const UpdateNotificationChannelRequest$json = const {
  '1': 'UpdateNotificationChannelRequest',
  '2': const [
    const {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    const {'1': 'channel_name', '3': 2, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'enabled_events', '3': 3, '4': 3, '5': 14, '6': '.financialproducts.NotificationEventType', '10': 'enabledEvents'},
    const {'1': 'preferences', '3': 4, '4': 1, '5': 11, '6': '.financialproducts.NotificationPreferences', '10': 'preferences'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.financialproducts.NotificationChannelStatus', '10': 'status'},
  ],
};

/// Descriptor for `UpdateNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotificationChannelRequestDescriptor = $convert.base64Decode('CiBVcGRhdGVOb3RpZmljYXRpb25DaGFubmVsUmVxdWVzdBIdCgpjaGFubmVsX2lkGAEgASgJUgljaGFubmVsSWQSIQoMY2hhbm5lbF9uYW1lGAIgASgJUgtjaGFubmVsTmFtZRJPCg5lbmFibGVkX2V2ZW50cxgDIAMoDjIoLmZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvbkV2ZW50VHlwZVINZW5hYmxlZEV2ZW50cxJMCgtwcmVmZXJlbmNlcxgEIAEoCzIqLmZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvblByZWZlcmVuY2VzUgtwcmVmZXJlbmNlcxJECgZzdGF0dXMYBSABKA4yLC5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25DaGFubmVsU3RhdHVzUgZzdGF0dXM=');
@$core.Deprecated('Use updateNotificationChannelResponseDescriptor instead')
const UpdateNotificationChannelResponse$json = const {
  '1': 'UpdateNotificationChannelResponse',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.NotificationChannel', '10': 'channel'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotificationChannelResponseDescriptor = $convert.base64Decode('CiFVcGRhdGVOb3RpZmljYXRpb25DaGFubmVsUmVzcG9uc2USQAoHY2hhbm5lbBgBIAEoCzImLmZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvbkNoYW5uZWxSB2NoYW5uZWwSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use testNotificationChannelRequestDescriptor instead')
const TestNotificationChannelRequest$json = const {
  '1': 'TestNotificationChannelRequest',
  '2': const [
    const {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `TestNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testNotificationChannelRequestDescriptor = $convert.base64Decode('Ch5UZXN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlcXVlc3QSHQoKY2hhbm5lbF9pZBgBIAEoCVIJY2hhbm5lbElk');
@$core.Deprecated('Use testNotificationChannelResponseDescriptor instead')
const TestNotificationChannelResponse$json = const {
  '1': 'TestNotificationChannelResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'platform_message_id', '3': 3, '4': 1, '5': 9, '10': 'platformMessageId'},
  ],
};

/// Descriptor for `TestNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testNotificationChannelResponseDescriptor = $convert.base64Decode('Ch9UZXN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIuChNwbGF0Zm9ybV9tZXNzYWdlX2lkGAMgASgJUhFwbGF0Zm9ybU1lc3NhZ2VJZA==');
@$core.Deprecated('Use getTelegramBotInfoRequestDescriptor instead')
const GetTelegramBotInfoRequest$json = const {
  '1': 'GetTelegramBotInfoRequest',
};

/// Descriptor for `GetTelegramBotInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTelegramBotInfoRequestDescriptor = $convert.base64Decode('ChlHZXRUZWxlZ3JhbUJvdEluZm9SZXF1ZXN0');
@$core.Deprecated('Use getTelegramBotInfoResponseDescriptor instead')
const GetTelegramBotInfoResponse$json = const {
  '1': 'GetTelegramBotInfoResponse',
  '2': const [
    const {'1': 'bot_username', '3': 1, '4': 1, '5': 9, '10': 'botUsername'},
    const {'1': 'bot_name', '3': 2, '4': 1, '5': 9, '10': 'botName'},
    const {'1': 'bot_link', '3': 3, '4': 1, '5': 9, '10': 'botLink'},
    const {'1': 'instructions', '3': 4, '4': 1, '5': 9, '10': 'instructions'},
  ],
};

/// Descriptor for `GetTelegramBotInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTelegramBotInfoResponseDescriptor = $convert.base64Decode('ChpHZXRUZWxlZ3JhbUJvdEluZm9SZXNwb25zZRIhCgxib3RfdXNlcm5hbWUYASABKAlSC2JvdFVzZXJuYW1lEhkKCGJvdF9uYW1lGAIgASgJUgdib3ROYW1lEhkKCGJvdF9saW5rGAMgASgJUgdib3RMaW5rEiIKDGluc3RydWN0aW9ucxgEIAEoCVIMaW5zdHJ1Y3Rpb25z');
@$core.Deprecated('Use verifyTelegramChannelRequestDescriptor instead')
const VerifyTelegramChannelRequest$json = const {
  '1': 'VerifyTelegramChannelRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'chat_id', '3': 2, '4': 1, '5': 9, '10': 'chatId'},
    const {'1': 'verification_code', '3': 3, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
};

/// Descriptor for `VerifyTelegramChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTelegramChannelRequestDescriptor = $convert.base64Decode('ChxWZXJpZnlUZWxlZ3JhbUNoYW5uZWxSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSFwoHY2hhdF9pZBgCIAEoCVIGY2hhdElkEisKEXZlcmlmaWNhdGlvbl9jb2RlGAMgASgJUhB2ZXJpZmljYXRpb25Db2Rl');
@$core.Deprecated('Use verifyTelegramChannelResponseDescriptor instead')
const VerifyTelegramChannelResponse$json = const {
  '1': 'VerifyTelegramChannelResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'channel', '3': 2, '4': 1, '5': 11, '6': '.financialproducts.NotificationChannel', '10': 'channel'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `VerifyTelegramChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTelegramChannelResponseDescriptor = $convert.base64Decode('Ch1WZXJpZnlUZWxlZ3JhbUNoYW5uZWxSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEkAKB2NoYW5uZWwYAiABKAsyJi5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25DaGFubmVsUgdjaGFubmVsEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getNotificationHistoryRequestDescriptor instead')
const GetNotificationHistoryRequest$json = const {
  '1': 'GetNotificationHistoryRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetNotificationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationHistoryRequestDescriptor = $convert.base64Decode('Ch1HZXROb3RpZmljYXRpb25IaXN0b3J5UmVxdWVzdBIhCgxjcm93ZGZ1bmRfaWQYASABKAlSC2Nyb3dkZnVuZElkEh0KCmNoYW5uZWxfaWQYAiABKAlSCWNoYW5uZWxJZBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZVNpemU=');
@$core.Deprecated('Use getNotificationHistoryResponseDescriptor instead')
const GetNotificationHistoryResponse$json = const {
  '1': 'GetNotificationHistoryResponse',
  '2': const [
    const {'1': 'deliveries', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.NotificationDelivery', '10': 'deliveries'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetNotificationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationHistoryResponseDescriptor = $convert.base64Decode('Ch5HZXROb3RpZmljYXRpb25IaXN0b3J5UmVzcG9uc2USRwoKZGVsaXZlcmllcxgBIAMoCzInLmZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvbkRlbGl2ZXJ5UgpkZWxpdmVyaWVzEhQKBXRvdGFsGAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZVNpemUSGQoIaGFzX21vcmUYBSABKAhSB2hhc01vcmU=');
@$core.Deprecated('Use getCrowdfundLeaderboardRequestDescriptor instead')
const GetCrowdfundLeaderboardRequest$json = const {
  '1': 'GetCrowdfundLeaderboardRequest',
  '2': const [
    const {'1': 'sort_by', '3': 1, '4': 1, '5': 14, '6': '.financialproducts.LeaderboardSortBy', '10': 'sortBy'},
    const {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetCrowdfundLeaderboardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundLeaderboardRequestDescriptor = $convert.base64Decode('Ch5HZXRDcm93ZGZ1bmRMZWFkZXJib2FyZFJlcXVlc3QSPQoHc29ydF9ieRgBIAEoDjIkLmZpbmFuY2lhbHByb2R1Y3RzLkxlYWRlcmJvYXJkU29ydEJ5UgZzb3J0QnkSGgoIY2F0ZWdvcnkYAiABKAlSCGNhdGVnb3J5EhQKBWxpbWl0GAMgASgFUgVsaW1pdBIWCgZvZmZzZXQYBCABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getCrowdfundLeaderboardResponseDescriptor instead')
const GetCrowdfundLeaderboardResponse$json = const {
  '1': 'GetCrowdfundLeaderboardResponse',
  '2': const [
    const {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.LeaderboardCrowdfundEntry', '10': 'entries'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetCrowdfundLeaderboardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundLeaderboardResponseDescriptor = $convert.base64Decode('Ch9HZXRDcm93ZGZ1bmRMZWFkZXJib2FyZFJlc3BvbnNlEkYKB2VudHJpZXMYASADKAsyLC5maW5hbmNpYWxwcm9kdWN0cy5MZWFkZXJib2FyZENyb3dkZnVuZEVudHJ5UgdlbnRyaWVzEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50');
@$core.Deprecated('Use leaderboardCrowdfundEntryDescriptor instead')
const LeaderboardCrowdfundEntry$json = const {
  '1': 'LeaderboardCrowdfundEntry',
  '2': const [
    const {'1': 'rank', '3': 1, '4': 1, '5': 5, '10': 'rank'},
    const {'1': 'crowdfund', '3': 2, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
  ],
};

/// Descriptor for `LeaderboardCrowdfundEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardCrowdfundEntryDescriptor = $convert.base64Decode('ChlMZWFkZXJib2FyZENyb3dkZnVuZEVudHJ5EhIKBHJhbmsYASABKAVSBHJhbmsSOgoJY3Jvd2RmdW5kGAIgASgLMhwuZmluYW5jaWFscHJvZHVjdHMuQ3Jvd2RmdW5kUgljcm93ZGZ1bmQ=');
@$core.Deprecated('Use myCoverCustomerDescriptor instead')
const MyCoverCustomer$json = const {
  '1': 'MyCoverCustomer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
    const {'1': 'date_of_birth', '3': 7, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `MyCoverCustomer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List myCoverCustomerDescriptor = $convert.base64Decode('Cg9NeUNvdmVyQ3VzdG9tZXISDgoCaWQYASABKAlSAmlkEh0KCmZpcnN0X25hbWUYAiABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUYAyABKAlSCGxhc3ROYW1lEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEhYKBmdlbmRlchgGIAEoCVIGZ2VuZGVyEiIKDWRhdGVfb2ZfYmlydGgYByABKAlSC2RhdGVPZkJpcnRoEh0KCmNyZWF0ZWRfYXQYCCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAkgASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use myCoverPurchaseDescriptor instead')
const MyCoverPurchase$json = const {
  '1': 'MyCoverPurchase',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'app_mode', '3': 2, '4': 1, '5': 9, '10': 'appMode'},
    const {'1': 'is_renewal', '3': 3, '4': 1, '5': 8, '10': 'isRenewal'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 9, '10': 'amount'},
    const {'1': 'customer_id', '3': 5, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'distributor_id', '3': 6, '4': 1, '5': 9, '10': 'distributorId'},
    const {'1': 'payment_channel', '3': 7, '4': 1, '5': 9, '10': 'paymentChannel'},
    const {'1': 'payment_option', '3': 8, '4': 1, '5': 9, '10': 'paymentOption'},
    const {'1': 'policy_id', '3': 9, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'product_category_id', '3': 10, '4': 1, '5': 9, '10': 'productCategoryId'},
    const {'1': 'product_id', '3': 11, '4': 1, '5': 9, '10': 'productId'},
    const {'1': 'provider_id', '3': 12, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'country_id', '3': 13, '4': 1, '5': 9, '10': 'countryId'},
    const {'1': 'currency_id', '3': 14, '4': 1, '5': 9, '10': 'currencyId'},
    const {'1': 'created_at', '3': 15, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 16, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'customer_name', '3': 17, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'customer_email', '3': 18, '4': 1, '5': 9, '10': 'customerEmail'},
    const {'1': 'customer_phone', '3': 19, '4': 1, '5': 9, '10': 'customerPhone'},
    const {'1': 'policy_number', '3': 20, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'certificate_url', '3': 21, '4': 1, '5': 9, '10': 'certificateUrl'},
    const {'1': 'policy_is_active', '3': 22, '4': 1, '5': 8, '10': 'policyIsActive'},
    const {'1': 'policy_amount', '3': 23, '4': 1, '5': 9, '10': 'policyAmount'},
    const {'1': 'provider_name', '3': 24, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'product_name', '3': 25, '4': 1, '5': 9, '10': 'productName'},
    const {'1': 'product_category_name', '3': 26, '4': 1, '5': 9, '10': 'productCategoryName'},
  ],
};

/// Descriptor for `MyCoverPurchase`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List myCoverPurchaseDescriptor = $convert.base64Decode('Cg9NeUNvdmVyUHVyY2hhc2USDgoCaWQYASABKAlSAmlkEhkKCGFwcF9tb2RlGAIgASgJUgdhcHBNb2RlEh0KCmlzX3JlbmV3YWwYAyABKAhSCWlzUmVuZXdhbBIWCgZhbW91bnQYBCABKAlSBmFtb3VudBIfCgtjdXN0b21lcl9pZBgFIAEoCVIKY3VzdG9tZXJJZBIlCg5kaXN0cmlidXRvcl9pZBgGIAEoCVINZGlzdHJpYnV0b3JJZBInCg9wYXltZW50X2NoYW5uZWwYByABKAlSDnBheW1lbnRDaGFubmVsEiUKDnBheW1lbnRfb3B0aW9uGAggASgJUg1wYXltZW50T3B0aW9uEhsKCXBvbGljeV9pZBgJIAEoCVIIcG9saWN5SWQSLgoTcHJvZHVjdF9jYXRlZ29yeV9pZBgKIAEoCVIRcHJvZHVjdENhdGVnb3J5SWQSHQoKcHJvZHVjdF9pZBgLIAEoCVIJcHJvZHVjdElkEh8KC3Byb3ZpZGVyX2lkGAwgASgJUgpwcm92aWRlcklkEh0KCmNvdW50cnlfaWQYDSABKAlSCWNvdW50cnlJZBIfCgtjdXJyZW5jeV9pZBgOIAEoCVIKY3VycmVuY3lJZBIdCgpjcmVhdGVkX2F0GA8gASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgQIAEoCVIJdXBkYXRlZEF0EiMKDWN1c3RvbWVyX25hbWUYESABKAlSDGN1c3RvbWVyTmFtZRIlCg5jdXN0b21lcl9lbWFpbBgSIAEoCVINY3VzdG9tZXJFbWFpbBIlCg5jdXN0b21lcl9waG9uZRgTIAEoCVINY3VzdG9tZXJQaG9uZRIjCg1wb2xpY3lfbnVtYmVyGBQgASgJUgxwb2xpY3lOdW1iZXISJwoPY2VydGlmaWNhdGVfdXJsGBUgASgJUg5jZXJ0aWZpY2F0ZVVybBIoChBwb2xpY3lfaXNfYWN0aXZlGBYgASgIUg5wb2xpY3lJc0FjdGl2ZRIjCg1wb2xpY3lfYW1vdW50GBcgASgJUgxwb2xpY3lBbW91bnQSIwoNcHJvdmlkZXJfbmFtZRgYIAEoCVIMcHJvdmlkZXJOYW1lEiEKDHByb2R1Y3RfbmFtZRgZIAEoCVILcHJvZHVjdE5hbWUSMgoVcHJvZHVjdF9jYXRlZ29yeV9uYW1lGBogASgJUhNwcm9kdWN0Q2F0ZWdvcnlOYW1l');
@$core.Deprecated('Use myCoverClaimDescriptor instead')
const MyCoverClaim$json = const {
  '1': 'MyCoverClaim',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'policy_id', '3': 6, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'customer_id', '3': 7, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'claim_number', '3': 8, '4': 1, '5': 9, '10': 'claimNumber'},
    const {'1': 'documents', '3': 9, '4': 3, '5': 9, '10': 'documents'},
    const {'1': 'rejection_reason', '3': 10, '4': 1, '5': 9, '10': 'rejectionReason'},
    const {'1': 'approved_amount', '3': 11, '4': 1, '5': 1, '10': 'approvedAmount'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `MyCoverClaim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List myCoverClaimDescriptor = $convert.base64Decode('CgxNeUNvdmVyQ2xhaW0SDgoCaWQYASABKAlSAmlkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhIKBHR5cGUYAyABKAlSBHR5cGUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEhsKCXBvbGljeV9pZBgGIAEoCVIIcG9saWN5SWQSHwoLY3VzdG9tZXJfaWQYByABKAlSCmN1c3RvbWVySWQSIQoMY2xhaW1fbnVtYmVyGAggASgJUgtjbGFpbU51bWJlchIcCglkb2N1bWVudHMYCSADKAlSCWRvY3VtZW50cxIpChByZWplY3Rpb25fcmVhc29uGAogASgJUg9yZWplY3Rpb25SZWFzb24SJwoPYXBwcm92ZWRfYW1vdW50GAsgASgBUg5hcHByb3ZlZEFtb3VudBIdCgpjcmVhdGVkX2F0GAwgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgNIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use getMyCoverCustomersRequestDescriptor instead')
const GetMyCoverCustomersRequest$json = const {
  '1': 'GetMyCoverCustomersRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetMyCoverCustomersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverCustomersRequestDescriptor = $convert.base64Decode('ChpHZXRNeUNvdmVyQ3VzdG9tZXJzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getMyCoverCustomersResponseDescriptor instead')
const GetMyCoverCustomersResponse$json = const {
  '1': 'GetMyCoverCustomersResponse',
  '2': const [
    const {'1': 'customers', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.MyCoverCustomer', '10': 'customers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyCoverCustomersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverCustomersResponseDescriptor = $convert.base64Decode('ChtHZXRNeUNvdmVyQ3VzdG9tZXJzUmVzcG9uc2USQAoJY3VzdG9tZXJzGAEgAygLMiIuZmluYW5jaWFscHJvZHVjdHMuTXlDb3ZlckN1c3RvbWVyUgljdXN0b21lcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getMyCoverCustomerByIdRequestDescriptor instead')
const GetMyCoverCustomerByIdRequest$json = const {
  '1': 'GetMyCoverCustomerByIdRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
  ],
};

/// Descriptor for `GetMyCoverCustomerByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverCustomerByIdRequestDescriptor = $convert.base64Decode('Ch1HZXRNeUNvdmVyQ3VzdG9tZXJCeUlkUmVxdWVzdBIfCgtjdXN0b21lcl9pZBgBIAEoCVIKY3VzdG9tZXJJZA==');
@$core.Deprecated('Use getMyCoverCustomerByIdResponseDescriptor instead')
const GetMyCoverCustomerByIdResponse$json = const {
  '1': 'GetMyCoverCustomerByIdResponse',
  '2': const [
    const {'1': 'customer', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.MyCoverCustomer', '10': 'customer'},
  ],
};

/// Descriptor for `GetMyCoverCustomerByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverCustomerByIdResponseDescriptor = $convert.base64Decode('Ch5HZXRNeUNvdmVyQ3VzdG9tZXJCeUlkUmVzcG9uc2USPgoIY3VzdG9tZXIYASABKAsyIi5maW5hbmNpYWxwcm9kdWN0cy5NeUNvdmVyQ3VzdG9tZXJSCGN1c3RvbWVy');
@$core.Deprecated('Use getMyCoverCustomerPoliciesRequestDescriptor instead')
const GetMyCoverCustomerPoliciesRequest$json = const {
  '1': 'GetMyCoverCustomerPoliciesRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetMyCoverCustomerPoliciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverCustomerPoliciesRequestDescriptor = $convert.base64Decode('CiFHZXRNeUNvdmVyQ3VzdG9tZXJQb2xpY2llc1JlcXVlc3QSHwoLY3VzdG9tZXJfaWQYASABKAlSCmN1c3RvbWVySWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getMyCoverCustomerPoliciesResponseDescriptor instead')
const GetMyCoverCustomerPoliciesResponse$json = const {
  '1': 'GetMyCoverCustomerPoliciesResponse',
  '2': const [
    const {'1': 'policies', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsurancePolicyDetail', '10': 'policies'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyCoverCustomerPoliciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverCustomerPoliciesResponseDescriptor = $convert.base64Decode('CiJHZXRNeUNvdmVyQ3VzdG9tZXJQb2xpY2llc1Jlc3BvbnNlEkQKCHBvbGljaWVzGAEgAygLMiguZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUG9saWN5RGV0YWlsUghwb2xpY2llcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use getMyCoverCustomerPurchasesRequestDescriptor instead')
const GetMyCoverCustomerPurchasesRequest$json = const {
  '1': 'GetMyCoverCustomerPurchasesRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetMyCoverCustomerPurchasesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverCustomerPurchasesRequestDescriptor = $convert.base64Decode('CiJHZXRNeUNvdmVyQ3VzdG9tZXJQdXJjaGFzZXNSZXF1ZXN0Eh8KC2N1c3RvbWVyX2lkGAEgASgJUgpjdXN0b21lcklkEhIKBHBhZ2UYAiABKAVSBHBhZ2USFAoFbGltaXQYAyABKAVSBWxpbWl0');
@$core.Deprecated('Use getMyCoverCustomerPurchasesResponseDescriptor instead')
const GetMyCoverCustomerPurchasesResponse$json = const {
  '1': 'GetMyCoverCustomerPurchasesResponse',
  '2': const [
    const {'1': 'purchases', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.MyCoverPurchase', '10': 'purchases'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyCoverCustomerPurchasesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverCustomerPurchasesResponseDescriptor = $convert.base64Decode('CiNHZXRNeUNvdmVyQ3VzdG9tZXJQdXJjaGFzZXNSZXNwb25zZRJACglwdXJjaGFzZXMYASADKAsyIi5maW5hbmNpYWxwcm9kdWN0cy5NeUNvdmVyUHVyY2hhc2VSCXB1cmNoYXNlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use getMyCoverPurchasesRequestDescriptor instead')
const GetMyCoverPurchasesRequest$json = const {
  '1': 'GetMyCoverPurchasesRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetMyCoverPurchasesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverPurchasesRequestDescriptor = $convert.base64Decode('ChpHZXRNeUNvdmVyUHVyY2hhc2VzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getMyCoverPurchasesResponseDescriptor instead')
const GetMyCoverPurchasesResponse$json = const {
  '1': 'GetMyCoverPurchasesResponse',
  '2': const [
    const {'1': 'purchases', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.MyCoverPurchase', '10': 'purchases'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyCoverPurchasesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverPurchasesResponseDescriptor = $convert.base64Decode('ChtHZXRNeUNvdmVyUHVyY2hhc2VzUmVzcG9uc2USQAoJcHVyY2hhc2VzGAEgAygLMiIuZmluYW5jaWFscHJvZHVjdHMuTXlDb3ZlclB1cmNoYXNlUglwdXJjaGFzZXMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getMyCoverPurchaseByIdRequestDescriptor instead')
const GetMyCoverPurchaseByIdRequest$json = const {
  '1': 'GetMyCoverPurchaseByIdRequest',
  '2': const [
    const {'1': 'purchase_id', '3': 1, '4': 1, '5': 9, '10': 'purchaseId'},
  ],
};

/// Descriptor for `GetMyCoverPurchaseByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverPurchaseByIdRequestDescriptor = $convert.base64Decode('Ch1HZXRNeUNvdmVyUHVyY2hhc2VCeUlkUmVxdWVzdBIfCgtwdXJjaGFzZV9pZBgBIAEoCVIKcHVyY2hhc2VJZA==');
@$core.Deprecated('Use getMyCoverPurchaseByIdResponseDescriptor instead')
const GetMyCoverPurchaseByIdResponse$json = const {
  '1': 'GetMyCoverPurchaseByIdResponse',
  '2': const [
    const {'1': 'purchase', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.MyCoverPurchase', '10': 'purchase'},
  ],
};

/// Descriptor for `GetMyCoverPurchaseByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverPurchaseByIdResponseDescriptor = $convert.base64Decode('Ch5HZXRNeUNvdmVyUHVyY2hhc2VCeUlkUmVzcG9uc2USPgoIcHVyY2hhc2UYASABKAsyIi5maW5hbmNpYWxwcm9kdWN0cy5NeUNvdmVyUHVyY2hhc2VSCHB1cmNoYXNl');
@$core.Deprecated('Use getMyCoverClaimsRequestDescriptor instead')
const GetMyCoverClaimsRequest$json = const {
  '1': 'GetMyCoverClaimsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetMyCoverClaimsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverClaimsRequestDescriptor = $convert.base64Decode('ChdHZXRNeUNvdmVyQ2xhaW1zUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxISCgRwYWdlGAIgASgFUgRwYWdlEhQKBWxpbWl0GAMgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getMyCoverClaimsResponseDescriptor instead')
const GetMyCoverClaimsResponse$json = const {
  '1': 'GetMyCoverClaimsResponse',
  '2': const [
    const {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.MyCoverClaim', '10': 'claims'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyCoverClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverClaimsResponseDescriptor = $convert.base64Decode('ChhHZXRNeUNvdmVyQ2xhaW1zUmVzcG9uc2USNwoGY2xhaW1zGAEgAygLMh8uZmluYW5jaWFscHJvZHVjdHMuTXlDb3ZlckNsYWltUgZjbGFpbXMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getMyCoverClaimByIdRequestDescriptor instead')
const GetMyCoverClaimByIdRequest$json = const {
  '1': 'GetMyCoverClaimByIdRequest',
  '2': const [
    const {'1': 'claim_id', '3': 1, '4': 1, '5': 9, '10': 'claimId'},
  ],
};

/// Descriptor for `GetMyCoverClaimByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverClaimByIdRequestDescriptor = $convert.base64Decode('ChpHZXRNeUNvdmVyQ2xhaW1CeUlkUmVxdWVzdBIZCghjbGFpbV9pZBgBIAEoCVIHY2xhaW1JZA==');
@$core.Deprecated('Use getMyCoverClaimByIdResponseDescriptor instead')
const GetMyCoverClaimByIdResponse$json = const {
  '1': 'GetMyCoverClaimByIdResponse',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.MyCoverClaim', '10': 'claim'},
  ],
};

/// Descriptor for `GetMyCoverClaimByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverClaimByIdResponseDescriptor = $convert.base64Decode('ChtHZXRNeUNvdmVyQ2xhaW1CeUlkUmVzcG9uc2USNQoFY2xhaW0YASABKAsyHy5maW5hbmNpYWxwcm9kdWN0cy5NeUNvdmVyQ2xhaW1SBWNsYWlt');
@$core.Deprecated('Use fileCreditLifeClaimRequestDescriptor instead')
const FileCreditLifeClaimRequest$json = const {
  '1': 'FileCreditLifeClaimRequest',
  '2': const [
    const {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    const {'1': 'claim_type', '3': 2, '4': 1, '5': 9, '10': 'claimType'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'documents', '3': 5, '4': 3, '5': 9, '10': 'documents'},
    const {'1': 'additional_info', '3': 6, '4': 3, '5': 11, '6': '.financialproducts.FileCreditLifeClaimRequest.AdditionalInfoEntry', '10': 'additionalInfo'},
  ],
  '3': const [FileCreditLifeClaimRequest_AdditionalInfoEntry$json],
};

@$core.Deprecated('Use fileCreditLifeClaimRequestDescriptor instead')
const FileCreditLifeClaimRequest_AdditionalInfoEntry$json = const {
  '1': 'AdditionalInfoEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `FileCreditLifeClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileCreditLifeClaimRequestDescriptor = $convert.base64Decode('ChpGaWxlQ3JlZGl0TGlmZUNsYWltUmVxdWVzdBIbCglwb2xpY3lfaWQYASABKAlSCHBvbGljeUlkEh0KCmNsYWltX3R5cGUYAiABKAlSCWNsYWltVHlwZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SFgoGYW1vdW50GAQgASgBUgZhbW91bnQSHAoJZG9jdW1lbnRzGAUgAygJUglkb2N1bWVudHMSagoPYWRkaXRpb25hbF9pbmZvGAYgAygLMkEuZmluYW5jaWFscHJvZHVjdHMuRmlsZUNyZWRpdExpZmVDbGFpbVJlcXVlc3QuQWRkaXRpb25hbEluZm9FbnRyeVIOYWRkaXRpb25hbEluZm8aQQoTQWRkaXRpb25hbEluZm9FbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use fileCreditLifeClaimResponseDescriptor instead')
const FileCreditLifeClaimResponse$json = const {
  '1': 'FileCreditLifeClaimResponse',
  '2': const [
    const {'1': 'claim_id', '3': 1, '4': 1, '5': 9, '10': 'claimId'},
    const {'1': 'claim_number', '3': 2, '4': 1, '5': 9, '10': 'claimNumber'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `FileCreditLifeClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileCreditLifeClaimResponseDescriptor = $convert.base64Decode('ChtGaWxlQ3JlZGl0TGlmZUNsYWltUmVzcG9uc2USGQoIY2xhaW1faWQYASABKAlSB2NsYWltSWQSIQoMY2xhaW1fbnVtYmVyGAIgASgJUgtjbGFpbU51bWJlchIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getInsuranceStatesRequestDescriptor instead')
const GetInsuranceStatesRequest$json = const {
  '1': 'GetInsuranceStatesRequest',
};

/// Descriptor for `GetInsuranceStatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceStatesRequestDescriptor = $convert.base64Decode('ChlHZXRJbnN1cmFuY2VTdGF0ZXNSZXF1ZXN0');
@$core.Deprecated('Use getInsuranceStatesResponseDescriptor instead')
const GetInsuranceStatesResponse$json = const {
  '1': 'GetInsuranceStatesResponse',
  '2': const [
    const {'1': 'states', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsuranceAuxiliaryItem', '10': 'states'},
  ],
};

/// Descriptor for `GetInsuranceStatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceStatesResponseDescriptor = $convert.base64Decode('ChpHZXRJbnN1cmFuY2VTdGF0ZXNSZXNwb25zZRJBCgZzdGF0ZXMYASADKAsyKS5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VBdXhpbGlhcnlJdGVtUgZzdGF0ZXM=');
@$core.Deprecated('Use getInsuranceVehicleMakesRequestDescriptor instead')
const GetInsuranceVehicleMakesRequest$json = const {
  '1': 'GetInsuranceVehicleMakesRequest',
};

/// Descriptor for `GetInsuranceVehicleMakesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceVehicleMakesRequestDescriptor = $convert.base64Decode('Ch9HZXRJbnN1cmFuY2VWZWhpY2xlTWFrZXNSZXF1ZXN0');
@$core.Deprecated('Use getInsuranceVehicleMakesResponseDescriptor instead')
const GetInsuranceVehicleMakesResponse$json = const {
  '1': 'GetInsuranceVehicleMakesResponse',
  '2': const [
    const {'1': 'makes', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsuranceAuxiliaryItem', '10': 'makes'},
  ],
};

/// Descriptor for `GetInsuranceVehicleMakesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceVehicleMakesResponseDescriptor = $convert.base64Decode('CiBHZXRJbnN1cmFuY2VWZWhpY2xlTWFrZXNSZXNwb25zZRI/CgVtYWtlcxgBIAMoCzIpLmZpbmFuY2lhbHByb2R1Y3RzLkluc3VyYW5jZUF1eGlsaWFyeUl0ZW1SBW1ha2Vz');
@$core.Deprecated('Use insurancePolicyDetailDescriptor instead')
const InsurancePolicyDetail$json = const {
  '1': 'InsurancePolicyDetail',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'app_mode', '3': 2, '4': 1, '5': 9, '10': 'appMode'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'date_of_birth', '3': 7, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'activation_date', '3': 8, '4': 1, '5': 9, '10': 'activationDate'},
    const {'1': 'start_date', '3': 9, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'expiration_date', '3': 10, '4': 1, '5': 9, '10': 'expirationDate'},
    const {'1': 'amount', '3': 11, '4': 1, '5': 9, '10': 'amount'},
    const {'1': 'is_active', '3': 12, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'is_submitted_to_provider', '3': 13, '4': 1, '5': 8, '10': 'isSubmittedToProvider'},
    const {'1': 'customer_id', '3': 14, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'product_id', '3': 15, '4': 1, '5': 9, '10': 'productId'},
    const {'1': 'product_category_id', '3': 16, '4': 1, '5': 9, '10': 'productCategoryId'},
    const {'1': 'provider_id', '3': 17, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'purchase_id', '3': 18, '4': 1, '5': 9, '10': 'purchaseId'},
    const {'1': 'policy_number', '3': 19, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'certificate_url', '3': 20, '4': 1, '5': 9, '10': 'certificateUrl'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 22, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'provider_name', '3': 23, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'product_name', '3': 24, '4': 1, '5': 9, '10': 'productName'},
  ],
};

/// Descriptor for `InsurancePolicyDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePolicyDetailDescriptor = $convert.base64Decode('ChVJbnN1cmFuY2VQb2xpY3lEZXRhaWwSDgoCaWQYASABKAlSAmlkEhkKCGFwcF9tb2RlGAIgASgJUgdhcHBNb2RlEh0KCmZpcnN0X25hbWUYAyABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUYBCABKAlSCGxhc3ROYW1lEhQKBWVtYWlsGAUgASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYBiABKAlSC3Bob25lTnVtYmVyEiIKDWRhdGVfb2ZfYmlydGgYByABKAlSC2RhdGVPZkJpcnRoEicKD2FjdGl2YXRpb25fZGF0ZRgIIAEoCVIOYWN0aXZhdGlvbkRhdGUSHQoKc3RhcnRfZGF0ZRgJIAEoCVIJc3RhcnREYXRlEicKD2V4cGlyYXRpb25fZGF0ZRgKIAEoCVIOZXhwaXJhdGlvbkRhdGUSFgoGYW1vdW50GAsgASgJUgZhbW91bnQSGwoJaXNfYWN0aXZlGAwgASgIUghpc0FjdGl2ZRI3Chhpc19zdWJtaXR0ZWRfdG9fcHJvdmlkZXIYDSABKAhSFWlzU3VibWl0dGVkVG9Qcm92aWRlchIfCgtjdXN0b21lcl9pZBgOIAEoCVIKY3VzdG9tZXJJZBIdCgpwcm9kdWN0X2lkGA8gASgJUglwcm9kdWN0SWQSLgoTcHJvZHVjdF9jYXRlZ29yeV9pZBgQIAEoCVIRcHJvZHVjdENhdGVnb3J5SWQSHwoLcHJvdmlkZXJfaWQYESABKAlSCnByb3ZpZGVySWQSHwoLcHVyY2hhc2VfaWQYEiABKAlSCnB1cmNoYXNlSWQSIwoNcG9saWN5X251bWJlchgTIAEoCVIMcG9saWN5TnVtYmVyEicKD2NlcnRpZmljYXRlX3VybBgUIAEoCVIOY2VydGlmaWNhdGVVcmwSHQoKY3JlYXRlZF9hdBgVIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFiABKAlSCXVwZGF0ZWRBdBIjCg1wcm92aWRlcl9uYW1lGBcgASgJUgxwcm92aWRlck5hbWUSIQoMcHJvZHVjdF9uYW1lGBggASgJUgtwcm9kdWN0TmFtZQ==');
@$core.Deprecated('Use myCoverNotificationPreferenceDescriptor instead')
const MyCoverNotificationPreference$json = const {
  '1': 'MyCoverNotificationPreference',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'label', '3': 3, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'enabled', '3': 5, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `MyCoverNotificationPreference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List myCoverNotificationPreferenceDescriptor = $convert.base64Decode('Ch1NeUNvdmVyTm90aWZpY2F0aW9uUHJlZmVyZW5jZRIQCgNrZXkYASABKAlSA2tleRIaCghjYXRlZ29yeRgCIAEoCVIIY2F0ZWdvcnkSFAoFbGFiZWwYAyABKAlSBWxhYmVsEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIYCgdlbmFibGVkGAUgASgIUgdlbmFibGVk');
@$core.Deprecated('Use getMyCoverNotificationPreferencesRequestDescriptor instead')
const GetMyCoverNotificationPreferencesRequest$json = const {
  '1': 'GetMyCoverNotificationPreferencesRequest',
};

/// Descriptor for `GetMyCoverNotificationPreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverNotificationPreferencesRequestDescriptor = $convert.base64Decode('CihHZXRNeUNvdmVyTm90aWZpY2F0aW9uUHJlZmVyZW5jZXNSZXF1ZXN0');
@$core.Deprecated('Use getMyCoverNotificationPreferencesResponseDescriptor instead')
const GetMyCoverNotificationPreferencesResponse$json = const {
  '1': 'GetMyCoverNotificationPreferencesResponse',
  '2': const [
    const {'1': 'preferences', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.MyCoverNotificationPreference', '10': 'preferences'},
  ],
};

/// Descriptor for `GetMyCoverNotificationPreferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverNotificationPreferencesResponseDescriptor = $convert.base64Decode('CilHZXRNeUNvdmVyTm90aWZpY2F0aW9uUHJlZmVyZW5jZXNSZXNwb25zZRJSCgtwcmVmZXJlbmNlcxgBIAMoCzIwLmZpbmFuY2lhbHByb2R1Y3RzLk15Q292ZXJOb3RpZmljYXRpb25QcmVmZXJlbmNlUgtwcmVmZXJlbmNlcw==');
@$core.Deprecated('Use updateMyCoverNotificationPreferencesRequestDescriptor instead')
const UpdateMyCoverNotificationPreferencesRequest$json = const {
  '1': 'UpdateMyCoverNotificationPreferencesRequest',
  '2': const [
    const {'1': 'preferences', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.MyCoverNotificationPreference', '10': 'preferences'},
  ],
};

/// Descriptor for `UpdateMyCoverNotificationPreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMyCoverNotificationPreferencesRequestDescriptor = $convert.base64Decode('CitVcGRhdGVNeUNvdmVyTm90aWZpY2F0aW9uUHJlZmVyZW5jZXNSZXF1ZXN0ElIKC3ByZWZlcmVuY2VzGAEgAygLMjAuZmluYW5jaWFscHJvZHVjdHMuTXlDb3Zlck5vdGlmaWNhdGlvblByZWZlcmVuY2VSC3ByZWZlcmVuY2Vz');
@$core.Deprecated('Use updateMyCoverNotificationPreferencesResponseDescriptor instead')
const UpdateMyCoverNotificationPreferencesResponse$json = const {
  '1': 'UpdateMyCoverNotificationPreferencesResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateMyCoverNotificationPreferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMyCoverNotificationPreferencesResponseDescriptor = $convert.base64Decode('CixVcGRhdGVNeUNvdmVyTm90aWZpY2F0aW9uUHJlZmVyZW5jZXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getMyCoverWalletBalanceRequestDescriptor instead')
const GetMyCoverWalletBalanceRequest$json = const {
  '1': 'GetMyCoverWalletBalanceRequest',
};

/// Descriptor for `GetMyCoverWalletBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverWalletBalanceRequestDescriptor = $convert.base64Decode('Ch5HZXRNeUNvdmVyV2FsbGV0QmFsYW5jZVJlcXVlc3Q=');
@$core.Deprecated('Use getMyCoverWalletBalanceResponseDescriptor instead')
const GetMyCoverWalletBalanceResponse$json = const {
  '1': 'GetMyCoverWalletBalanceResponse',
  '2': const [
    const {'1': 'balance', '3': 1, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GetMyCoverWalletBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCoverWalletBalanceResponseDescriptor = $convert.base64Decode('Ch9HZXRNeUNvdmVyV2FsbGV0QmFsYW5jZVJlc3BvbnNlEhgKB2JhbGFuY2UYASABKAFSB2JhbGFuY2USGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EhgKB3N1Y2Nlc3MYAyABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use requestInsuranceRefundRequestDescriptor instead')
const RequestInsuranceRefundRequest$json = const {
  '1': 'RequestInsuranceRefundRequest',
  '2': const [
    const {'1': 'policy_reference', '3': 1, '4': 1, '5': 9, '10': 'policyReference'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RequestInsuranceRefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestInsuranceRefundRequestDescriptor = $convert.base64Decode('Ch1SZXF1ZXN0SW5zdXJhbmNlUmVmdW5kUmVxdWVzdBIpChBwb2xpY3lfcmVmZXJlbmNlGAEgASgJUg9wb2xpY3lSZWZlcmVuY2USFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');
@$core.Deprecated('Use requestInsuranceRefundResponseDescriptor instead')
const RequestInsuranceRefundResponse$json = const {
  '1': 'RequestInsuranceRefundResponse',
  '2': const [
    const {'1': 'refund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsuranceRefundInfo', '10': 'refund'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RequestInsuranceRefundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestInsuranceRefundResponseDescriptor = $convert.base64Decode('Ch5SZXF1ZXN0SW5zdXJhbmNlUmVmdW5kUmVzcG9uc2USPgoGcmVmdW5kGAEgASgLMiYuZmluYW5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUmVmdW5kSW5mb1IGcmVmdW5kEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getInsuranceRefundStatusRequestDescriptor instead')
const GetInsuranceRefundStatusRequest$json = const {
  '1': 'GetInsuranceRefundStatusRequest',
  '2': const [
    const {'1': 'policy_reference', '3': 1, '4': 1, '5': 9, '10': 'policyReference'},
  ],
};

/// Descriptor for `GetInsuranceRefundStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceRefundStatusRequestDescriptor = $convert.base64Decode('Ch9HZXRJbnN1cmFuY2VSZWZ1bmRTdGF0dXNSZXF1ZXN0EikKEHBvbGljeV9yZWZlcmVuY2UYASABKAlSD3BvbGljeVJlZmVyZW5jZQ==');
@$core.Deprecated('Use getInsuranceRefundStatusResponseDescriptor instead')
const GetInsuranceRefundStatusResponse$json = const {
  '1': 'GetInsuranceRefundStatusResponse',
  '2': const [
    const {'1': 'refund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsuranceRefundInfo', '10': 'refund'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GetInsuranceRefundStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceRefundStatusResponseDescriptor = $convert.base64Decode('CiBHZXRJbnN1cmFuY2VSZWZ1bmRTdGF0dXNSZXNwb25zZRI+CgZyZWZ1bmQYASABKAsyJi5maW5hbmNpYWxwcm9kdWN0cy5JbnN1cmFuY2VSZWZ1bmRJbmZvUgZyZWZ1bmQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use insuranceRefundInfoDescriptor instead')
const InsuranceRefundInfo$json = const {
  '1': 'InsuranceRefundInfo',
  '2': const [
    const {'1': 'refund_id', '3': 1, '4': 1, '5': 9, '10': 'refundId'},
    const {'1': 'policy_reference', '3': 2, '4': 1, '5': 9, '10': 'policyReference'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'provider_refunded', '3': 6, '4': 1, '5': 8, '10': 'providerRefunded'},
    const {'1': 'wallet_credited', '3': 7, '4': 1, '5': 8, '10': 'walletCredited'},
    const {'1': 'reason', '3': 8, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'failure_reason', '3': 9, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'initiated_at', '3': 10, '4': 1, '5': 9, '10': 'initiatedAt'},
    const {'1': 'completed_at', '3': 11, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `InsuranceRefundInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceRefundInfoDescriptor = $convert.base64Decode('ChNJbnN1cmFuY2VSZWZ1bmRJbmZvEhsKCXJlZnVuZF9pZBgBIAEoCVIIcmVmdW5kSWQSKQoQcG9saWN5X3JlZmVyZW5jZRgCIAEoCVIPcG9saWN5UmVmZXJlbmNlEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIrChFwcm92aWRlcl9yZWZ1bmRlZBgGIAEoCFIQcHJvdmlkZXJSZWZ1bmRlZBInCg93YWxsZXRfY3JlZGl0ZWQYByABKAhSDndhbGxldENyZWRpdGVkEhYKBnJlYXNvbhgIIAEoCVIGcmVhc29uEiUKDmZhaWx1cmVfcmVhc29uGAkgASgJUg1mYWlsdXJlUmVhc29uEiEKDGluaXRpYXRlZF9hdBgKIAEoCVILaW5pdGlhdGVkQXQSIQoMY29tcGxldGVkX2F0GAsgASgJUgtjb21wbGV0ZWRBdA==');
