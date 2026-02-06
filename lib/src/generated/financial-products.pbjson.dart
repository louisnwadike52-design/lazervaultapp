//
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use notificationChannelTypeDescriptor instead')
const NotificationChannelType$json = {
  '1': 'NotificationChannelType',
  '2': [
    {'1': 'NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'NOTIFICATION_CHANNEL_TYPE_TELEGRAM', '2': 1},
    {'1': 'NOTIFICATION_CHANNEL_TYPE_DISCORD', '2': 2},
    {'1': 'NOTIFICATION_CHANNEL_TYPE_WHATSAPP_BUSINESS', '2': 3},
    {'1': 'NOTIFICATION_CHANNEL_TYPE_SLACK', '2': 4},
  ],
};

/// Descriptor for `NotificationChannelType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List notificationChannelTypeDescriptor = $convert.base64Decode(
    'ChdOb3RpZmljYXRpb25DaGFubmVsVHlwZRIpCiVOT1RJRklDQVRJT05fQ0hBTk5FTF9UWVBFX1'
    'VOU1BFQ0lGSUVEEAASJgoiTk9USUZJQ0FUSU9OX0NIQU5ORUxfVFlQRV9URUxFR1JBTRABEiUK'
    'IU5PVElGSUNBVElPTl9DSEFOTkVMX1RZUEVfRElTQ09SRBACEi8KK05PVElGSUNBVElPTl9DSE'
    'FOTkVMX1RZUEVfV0hBVFNBUFBfQlVTSU5FU1MQAxIjCh9OT1RJRklDQVRJT05fQ0hBTk5FTF9U'
    'WVBFX1NMQUNLEAQ=');

@$core.Deprecated('Use notificationChannelStatusDescriptor instead')
const NotificationChannelStatus$json = {
  '1': 'NotificationChannelStatus',
  '2': [
    {'1': 'NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'NOTIFICATION_CHANNEL_STATUS_PENDING', '2': 1},
    {'1': 'NOTIFICATION_CHANNEL_STATUS_ACTIVE', '2': 2},
    {'1': 'NOTIFICATION_CHANNEL_STATUS_PAUSED', '2': 3},
    {'1': 'NOTIFICATION_CHANNEL_STATUS_ERROR', '2': 4},
    {'1': 'NOTIFICATION_CHANNEL_STATUS_DISCONNECTED', '2': 5},
  ],
};

/// Descriptor for `NotificationChannelStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List notificationChannelStatusDescriptor = $convert.base64Decode(
    'ChlOb3RpZmljYXRpb25DaGFubmVsU3RhdHVzEisKJ05PVElGSUNBVElPTl9DSEFOTkVMX1NUQV'
    'RVU19VTlNQRUNJRklFRBAAEicKI05PVElGSUNBVElPTl9DSEFOTkVMX1NUQVRVU19QRU5ESU5H'
    'EAESJgoiTk9USUZJQ0FUSU9OX0NIQU5ORUxfU1RBVFVTX0FDVElWRRACEiYKIk5PVElGSUNBVE'
    'lPTl9DSEFOTkVMX1NUQVRVU19QQVVTRUQQAxIlCiFOT1RJRklDQVRJT05fQ0hBTk5FTF9TVEFU'
    'VVNfRVJST1IQBBIsCihOT1RJRklDQVRJT05fQ0hBTk5FTF9TVEFUVVNfRElTQ09OTkVDVEVEEA'
    'U=');

@$core.Deprecated('Use notificationEventTypeDescriptor instead')
const NotificationEventType$json = {
  '1': 'NotificationEventType',
  '2': [
    {'1': 'NOTIFICATION_EVENT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'NOTIFICATION_EVENT_TYPE_NEW_DONATION', '2': 1},
    {'1': 'NOTIFICATION_EVENT_TYPE_MILESTONE_REACHED', '2': 2},
    {'1': 'NOTIFICATION_EVENT_TYPE_GOAL_REACHED', '2': 3},
    {'1': 'NOTIFICATION_EVENT_TYPE_NEW_CONTRIBUTOR', '2': 4},
    {'1': 'NOTIFICATION_EVENT_TYPE_LARGE_DONATION', '2': 5},
    {'1': 'NOTIFICATION_EVENT_TYPE_DAILY_SUMMARY', '2': 6},
    {'1': 'NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDING', '2': 7},
    {'1': 'NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDED', '2': 8},
    {'1': 'NOTIFICATION_EVENT_TYPE_WITHDRAWAL', '2': 9},
  ],
};

/// Descriptor for `NotificationEventType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List notificationEventTypeDescriptor = $convert.base64Decode(
    'ChVOb3RpZmljYXRpb25FdmVudFR5cGUSJwojTk9USUZJQ0FUSU9OX0VWRU5UX1RZUEVfVU5TUE'
    'VDSUZJRUQQABIoCiROT1RJRklDQVRJT05fRVZFTlRfVFlQRV9ORVdfRE9OQVRJT04QARItCilO'
    'T1RJRklDQVRJT05fRVZFTlRfVFlQRV9NSUxFU1RPTkVfUkVBQ0hFRBACEigKJE5PVElGSUNBVE'
    'lPTl9FVkVOVF9UWVBFX0dPQUxfUkVBQ0hFRBADEisKJ05PVElGSUNBVElPTl9FVkVOVF9UWVBF'
    'X05FV19DT05UUklCVVRPUhAEEioKJk5PVElGSUNBVElPTl9FVkVOVF9UWVBFX0xBUkdFX0RPTk'
    'FUSU9OEAUSKQolTk9USUZJQ0FUSU9OX0VWRU5UX1RZUEVfREFJTFlfU1VNTUFSWRAGEisKJ05P'
    'VElGSUNBVElPTl9FVkVOVF9UWVBFX0NBTVBBSUdOX0VORElORxAHEioKJk5PVElGSUNBVElPTl'
    '9FVkVOVF9UWVBFX0NBTVBBSUdOX0VOREVEEAgSJgoiTk9USUZJQ0FUSU9OX0VWRU5UX1RZUEVf'
    'V0lUSERSQVdBTBAJ');

@$core.Deprecated('Use groupAccountDescriptor instead')
const GroupAccount$json = {
  '1': 'GroupAccount',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'creator_id', '3': 4, '4': 1, '5': 9, '10': 'creatorId'},
    {'1': 'balance', '3': 5, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'target_amount', '3': 6, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    {'1': 'members', '3': 8, '4': 3, '5': 11, '6': '.financialproducts.GroupMember', '10': 'members'},
    {'1': 'withdrawal_rules', '3': 9, '4': 1, '5': 9, '10': 'withdrawalRules'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `GroupAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupAccountDescriptor = $convert.base64Decode(
    'CgxHcm91cEFjY291bnQSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIAoLZG'
    'VzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEh0KCmNyZWF0b3JfaWQYBCABKAlSCWNyZWF0'
    'b3JJZBIYCgdiYWxhbmNlGAUgASgBUgdiYWxhbmNlEiMKDXRhcmdldF9hbW91bnQYBiABKAFSDH'
    'RhcmdldEFtb3VudBIWCgZzdGF0dXMYByABKAlSBnN0YXR1cxI4CgdtZW1iZXJzGAggAygLMh4u'
    'ZmluYW5jaWFscHJvZHVjdHMuR3JvdXBNZW1iZXJSB21lbWJlcnMSKQoQd2l0aGRyYXdhbF9ydW'
    'xlcxgJIAEoCVIPd2l0aGRyYXdhbFJ1bGVzEh0KCmNyZWF0ZWRfYXQYCiABKAlSCWNyZWF0ZWRB'
    'dBIdCgp1cGRhdGVkX2F0GAsgASgJUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use groupMemberDescriptor instead')
const GroupMember$json = {
  '1': 'GroupMember',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
    {'1': 'contribution', '3': 4, '4': 1, '5': 1, '10': 'contribution'},
    {'1': 'joined_at', '3': 5, '4': 1, '5': 9, '10': 'joinedAt'},
  ],
};

/// Descriptor for `GroupMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupMemberDescriptor = $convert.base64Decode(
    'CgtHcm91cE1lbWJlchIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSEgoEbmFtZRgCIAEoCVIEbm'
    'FtZRISCgRyb2xlGAMgASgJUgRyb2xlEiIKDGNvbnRyaWJ1dGlvbhgEIAEoAVIMY29udHJpYnV0'
    'aW9uEhsKCWpvaW5lZF9hdBgFIAEoCVIIam9pbmVkQXQ=');

@$core.Deprecated('Use insuranceDescriptor instead')
const Insurance$json = {
  '1': 'Insurance',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'policy_number', '3': 4, '4': 1, '5': 9, '10': 'policyNumber'},
    {'1': 'plan_id', '3': 5, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'plan_name', '3': 6, '4': 1, '5': 9, '10': 'planName'},
    {'1': 'coverage_type', '3': 7, '4': 1, '5': 9, '10': 'coverageType'},
    {'1': 'premium', '3': 8, '4': 1, '5': 1, '10': 'premium'},
    {'1': 'coverage_amount', '3': 9, '4': 1, '5': 1, '10': 'coverageAmount'},
    {'1': 'payment_frequency', '3': 10, '4': 1, '5': 9, '10': 'paymentFrequency'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'start_date', '3': 12, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 13, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'next_payment_date', '3': 14, '4': 1, '5': 9, '10': 'nextPaymentDate'},
    {'1': 'beneficiary', '3': 15, '4': 1, '5': 9, '10': 'beneficiary'},
    {'1': 'metadata', '3': 16, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Insurance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceDescriptor = $convert.base64Decode(
    'CglJbnN1cmFuY2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCg'
    'phY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSIwoNcG9saWN5X251bWJlchgEIAEoCVIMcG9s'
    'aWN5TnVtYmVyEhcKB3BsYW5faWQYBSABKAlSBnBsYW5JZBIbCglwbGFuX25hbWUYBiABKAlSCH'
    'BsYW5OYW1lEiMKDWNvdmVyYWdlX3R5cGUYByABKAlSDGNvdmVyYWdlVHlwZRIYCgdwcmVtaXVt'
    'GAggASgBUgdwcmVtaXVtEicKD2NvdmVyYWdlX2Ftb3VudBgJIAEoAVIOY292ZXJhZ2VBbW91bn'
    'QSKwoRcGF5bWVudF9mcmVxdWVuY3kYCiABKAlSEHBheW1lbnRGcmVxdWVuY3kSFgoGc3RhdHVz'
    'GAsgASgJUgZzdGF0dXMSHQoKc3RhcnRfZGF0ZRgMIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYX'
    'RlGA0gASgJUgdlbmREYXRlEioKEW5leHRfcGF5bWVudF9kYXRlGA4gASgJUg9uZXh0UGF5bWVu'
    'dERhdGUSIAoLYmVuZWZpY2lhcnkYDyABKAlSC2JlbmVmaWNpYXJ5EhoKCG1ldGFkYXRhGBAgAS'
    'gJUghtZXRhZGF0YRIdCgpjcmVhdGVkX2F0GBEgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9h'
    'dBgSIAEoCVIJdXBkYXRlZEF0');

@$core.Deprecated('Use insurancePlanDescriptor instead')
const InsurancePlan$json = {
  '1': 'InsurancePlan',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'coverage_type', '3': 3, '4': 1, '5': 9, '10': 'coverageType'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'min_premium', '3': 5, '4': 1, '5': 1, '10': 'minPremium'},
    {'1': 'max_premium', '3': 6, '4': 1, '5': 1, '10': 'maxPremium'},
    {'1': 'coverage_amount', '3': 7, '4': 1, '5': 1, '10': 'coverageAmount'},
    {'1': 'benefits', '3': 8, '4': 3, '5': 9, '10': 'benefits'},
    {'1': 'terms', '3': 9, '4': 1, '5': 9, '10': 'terms'},
    {'1': 'is_active', '3': 10, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `InsurancePlan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePlanDescriptor = $convert.base64Decode(
    'Cg1JbnN1cmFuY2VQbGFuEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiMKDW'
    'NvdmVyYWdlX3R5cGUYAyABKAlSDGNvdmVyYWdlVHlwZRIgCgtkZXNjcmlwdGlvbhgEIAEoCVIL'
    'ZGVzY3JpcHRpb24SHwoLbWluX3ByZW1pdW0YBSABKAFSCm1pblByZW1pdW0SHwoLbWF4X3ByZW'
    '1pdW0YBiABKAFSCm1heFByZW1pdW0SJwoPY292ZXJhZ2VfYW1vdW50GAcgASgBUg5jb3ZlcmFn'
    'ZUFtb3VudBIaCghiZW5lZml0cxgIIAMoCVIIYmVuZWZpdHMSFAoFdGVybXMYCSABKAlSBXRlcm'
    '1zEhsKCWlzX2FjdGl2ZRgKIAEoCFIIaXNBY3RpdmU=');

@$core.Deprecated('Use insuranceClaimDescriptor instead')
const InsuranceClaim$json = {
  '1': 'InsuranceClaim',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'policy_id', '3': 2, '4': 1, '5': 9, '10': 'policyId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'claim_amount', '3': 4, '4': 1, '5': 1, '10': 'claimAmount'},
    {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'documents', '3': 7, '4': 1, '5': 9, '10': 'documents'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `InsuranceClaim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceClaimDescriptor = $convert.base64Decode(
    'Cg5JbnN1cmFuY2VDbGFpbRIOCgJpZBgBIAEoCVICaWQSGwoJcG9saWN5X2lkGAIgASgJUghwb2'
    'xpY3lJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSIQoMY2xhaW1fYW1vdW50GAQgASgBUgtj'
    'bGFpbUFtb3VudBIWCgZyZWFzb24YBSABKAlSBnJlYXNvbhIWCgZzdGF0dXMYBiABKAlSBnN0YX'
    'R1cxIcCglkb2N1bWVudHMYByABKAlSCWRvY3VtZW50cxIdCgpjcmVhdGVkX2F0GAggASgJUglj'
    'cmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgJIAEoCVIJdXBkYXRlZEF0');

@$core.Deprecated('Use crowdfundDescriptor instead')
const Crowdfund$json = {
  '1': 'Crowdfund',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
    {'1': 'target_amount', '3': 7, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'current_amount', '3': 8, '4': 1, '5': 1, '10': 'currentAmount'},
    {'1': 'percentage_funded', '3': 9, '4': 1, '5': 1, '10': 'percentageFunded'},
    {'1': 'total_contributors', '3': 10, '4': 1, '5': 5, '10': 'totalContributors'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'image_url', '3': 12, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'deadline', '3': 13, '4': 1, '5': 9, '10': 'deadline'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 15, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Crowdfund`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundDescriptor = $convert.base64Decode(
    'CglDcm93ZGZ1bmQSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCg'
    'phY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSFAoFdGl0bGUYBCABKAlSBXRpdGxlEiAKC2Rl'
    'c2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIaCghjYXRlZ29yeRgGIAEoCVIIY2F0ZWdvcn'
    'kSIwoNdGFyZ2V0X2Ftb3VudBgHIAEoAVIMdGFyZ2V0QW1vdW50EiUKDmN1cnJlbnRfYW1vdW50'
    'GAggASgBUg1jdXJyZW50QW1vdW50EisKEXBlcmNlbnRhZ2VfZnVuZGVkGAkgASgBUhBwZXJjZW'
    '50YWdlRnVuZGVkEi0KEnRvdGFsX2NvbnRyaWJ1dG9ycxgKIAEoBVIRdG90YWxDb250cmlidXRv'
    'cnMSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSGwoJaW1hZ2VfdXJsGAwgASgJUghpbWFnZVVybB'
    'IaCghkZWFkbGluZRgNIAEoCVIIZGVhZGxpbmUSHQoKY3JlYXRlZF9hdBgOIAEoCVIJY3JlYXRl'
    'ZEF0Eh0KCnVwZGF0ZWRfYXQYDyABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use crowdfundContributionDescriptor instead')
const CrowdfundContribution$json = {
  '1': 'CrowdfundContribution',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'crowdfund_id', '3': 2, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_anonymous', '3': 6, '4': 1, '5': 8, '10': 'isAnonymous'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `CrowdfundContribution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundContributionDescriptor = $convert.base64Decode(
    'ChVDcm93ZGZ1bmRDb250cmlidXRpb24SDgoCaWQYASABKAlSAmlkEiEKDGNyb3dkZnVuZF9pZB'
    'gCIAEoCVILY3Jvd2RmdW5kSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhYKBmFtb3VudBgE'
    'IAEoAVIGYW1vdW50EhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2USIQoMaXNfYW5vbnltb3VzGA'
    'YgASgIUgtpc0Fub255bW91cxIdCgpjcmVhdGVkX2F0GAcgASgJUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use createGroupAccountRequestDescriptor instead')
const CreateGroupAccountRequest$json = {
  '1': 'CreateGroupAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'target_amount', '3': 4, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'withdrawal_rules', '3': 5, '4': 1, '5': 9, '10': 'withdrawalRules'},
    {'1': 'member_ids', '3': 6, '4': 3, '5': 9, '10': 'memberIds'},
  ],
};

/// Descriptor for `CreateGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupAccountRequestDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVHcm91cEFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bn'
    'RJZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlv'
    'bhIjCg10YXJnZXRfYW1vdW50GAQgASgBUgx0YXJnZXRBbW91bnQSKQoQd2l0aGRyYXdhbF9ydW'
    'xlcxgFIAEoCVIPd2l0aGRyYXdhbFJ1bGVzEh0KCm1lbWJlcl9pZHMYBiADKAlSCW1lbWJlcklk'
    'cw==');

@$core.Deprecated('Use createGroupAccountResponseDescriptor instead')
const CreateGroupAccountResponse$json = {
  '1': 'CreateGroupAccountResponse',
  '2': [
    {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupAccountResponseDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVHcm91cEFjY291bnRSZXNwb25zZRJECg1ncm91cF9hY2NvdW50GAEgASgLMh8uZm'
    'luYW5jaWFscHJvZHVjdHMuR3JvdXBBY2NvdW50Ugxncm91cEFjY291bnQSGAoHbWVzc2FnZRgC'
    'IAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getGroupAccountsRequestDescriptor instead')
const GetGroupAccountsRequest$json = {
  '1': 'GetGroupAccountsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetGroupAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRHcm91cEFjY291bnRzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIUCgVsaW'
    '1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getGroupAccountsResponseDescriptor instead')
const GetGroupAccountsResponse$json = {
  '1': 'GetGroupAccountsResponse',
  '2': [
    {'1': 'group_accounts', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccounts'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetGroupAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRHcm91cEFjY291bnRzUmVzcG9uc2USRgoOZ3JvdXBfYWNjb3VudHMYASADKAsyHy5maW'
    '5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDWdyb3VwQWNjb3VudHMSFAoFdG90YWwYAiAB'
    'KAVSBXRvdGFs');

@$core.Deprecated('Use getGroupAccountRequestDescriptor instead')
const GetGroupAccountRequest$json = {
  '1': 'GetGroupAccountRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountRequestDescriptor = $convert.base64Decode(
    'ChZHZXRHcm91cEFjY291bnRSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');

@$core.Deprecated('Use getGroupAccountResponseDescriptor instead')
const GetGroupAccountResponse$json = {
  '1': 'GetGroupAccountResponse',
  '2': [
    {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
  ],
};

/// Descriptor for `GetGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupAccountResponseDescriptor = $convert.base64Decode(
    'ChdHZXRHcm91cEFjY291bnRSZXNwb25zZRJECg1ncm91cF9hY2NvdW50GAEgASgLMh8uZmluYW'
    '5jaWFscHJvZHVjdHMuR3JvdXBBY2NvdW50Ugxncm91cEFjY291bnQ=');

@$core.Deprecated('Use addGroupMemberRequestDescriptor instead')
const AddGroupMemberRequest$json = {
  '1': 'AddGroupMemberRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `AddGroupMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupMemberRequestDescriptor = $convert.base64Decode(
    'ChVBZGRHcm91cE1lbWJlclJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSGwoJbW'
    'VtYmVyX2lkGAIgASgJUghtZW1iZXJJZBISCgRyb2xlGAMgASgJUgRyb2xl');

@$core.Deprecated('Use addGroupMemberResponseDescriptor instead')
const AddGroupMemberResponse$json = {
  '1': 'AddGroupMemberResponse',
  '2': [
    {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AddGroupMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupMemberResponseDescriptor = $convert.base64Decode(
    'ChZBZGRHcm91cE1lbWJlclJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW5hbm'
    'NpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIgASgJ'
    'UgdtZXNzYWdl');

@$core.Deprecated('Use removeGroupMemberRequestDescriptor instead')
const RemoveGroupMemberRequest$json = {
  '1': 'RemoveGroupMemberRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
  ],
};

/// Descriptor for `RemoveGroupMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeGroupMemberRequestDescriptor = $convert.base64Decode(
    'ChhSZW1vdmVHcm91cE1lbWJlclJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSGw'
    'oJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZA==');

@$core.Deprecated('Use removeGroupMemberResponseDescriptor instead')
const RemoveGroupMemberResponse$json = {
  '1': 'RemoveGroupMemberResponse',
  '2': [
    {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemoveGroupMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeGroupMemberResponseDescriptor = $convert.base64Decode(
    'ChlSZW1vdmVHcm91cE1lbWJlclJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW'
    '5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIg'
    'ASgJUgdtZXNzYWdl');

@$core.Deprecated('Use contributeToGroupRequestDescriptor instead')
const ContributeToGroupRequest$json = {
  '1': 'ContributeToGroupRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'pin', '3': 4, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `ContributeToGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToGroupRequestDescriptor = $convert.base64Decode(
    'ChhDb250cmlidXRlVG9Hcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSHQ'
    'oKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhAK'
    'A3BpbhgEIAEoCVIDcGlu');

@$core.Deprecated('Use contributeToGroupResponseDescriptor instead')
const ContributeToGroupResponse$json = {
  '1': 'ContributeToGroupResponse',
  '2': [
    {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ContributeToGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToGroupResponseDescriptor = $convert.base64Decode(
    'ChlDb250cmlidXRlVG9Hcm91cFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW'
    '5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIfCgtuZXdfYmFsYW5j'
    'ZRgCIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use withdrawFromGroupRequestDescriptor instead')
const WithdrawFromGroupRequest$json = {
  '1': 'WithdrawFromGroupRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'pin', '3': 4, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `WithdrawFromGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromGroupRequestDescriptor = $convert.base64Decode(
    'ChhXaXRoZHJhd0Zyb21Hcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSFg'
    'oGYW1vdW50GAIgASgBUgZhbW91bnQSFgoGcmVhc29uGAMgASgJUgZyZWFzb24SEAoDcGluGAQg'
    'ASgJUgNwaW4=');

@$core.Deprecated('Use withdrawFromGroupResponseDescriptor instead')
const WithdrawFromGroupResponse$json = {
  '1': 'WithdrawFromGroupResponse',
  '2': [
    {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawFromGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromGroupResponseDescriptor = $convert.base64Decode(
    'ChlXaXRoZHJhd0Zyb21Hcm91cFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW'
    '5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIg'
    'ASgJUgdtZXNzYWdl');

@$core.Deprecated('Use closeGroupAccountRequestDescriptor instead')
const CloseGroupAccountRequest$json = {
  '1': 'CloseGroupAccountRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `CloseGroupAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeGroupAccountRequestDescriptor = $convert.base64Decode(
    'ChhDbG9zZUdyb3VwQWNjb3VudFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSEA'
    'oDcGluGAIgASgJUgNwaW4=');

@$core.Deprecated('Use closeGroupAccountResponseDescriptor instead')
const CloseGroupAccountResponse$json = {
  '1': 'CloseGroupAccountResponse',
  '2': [
    {'1': 'group_account', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.GroupAccount', '10': 'groupAccount'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CloseGroupAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeGroupAccountResponseDescriptor = $convert.base64Decode(
    'ChlDbG9zZUdyb3VwQWNjb3VudFJlc3BvbnNlEkQKDWdyb3VwX2FjY291bnQYASABKAsyHy5maW'
    '5hbmNpYWxwcm9kdWN0cy5Hcm91cEFjY291bnRSDGdyb3VwQWNjb3VudBIYCgdtZXNzYWdlGAIg'
    'ASgJUgdtZXNzYWdl');

@$core.Deprecated('Use buyInsuranceRequestDescriptor instead')
const BuyInsuranceRequest$json = {
  '1': 'BuyInsuranceRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'plan_id', '3': 2, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'coverage_amount', '3': 3, '4': 1, '5': 1, '10': 'coverageAmount'},
    {'1': 'payment_frequency', '3': 4, '4': 1, '5': 9, '10': 'paymentFrequency'},
    {'1': 'beneficiary', '3': 5, '4': 1, '5': 9, '10': 'beneficiary'},
    {'1': 'pin', '3': 6, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `BuyInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyInsuranceRequestDescriptor = $convert.base64Decode(
    'ChNCdXlJbnN1cmFuY2VSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIXCg'
    'dwbGFuX2lkGAIgASgJUgZwbGFuSWQSJwoPY292ZXJhZ2VfYW1vdW50GAMgASgBUg5jb3ZlcmFn'
    'ZUFtb3VudBIrChFwYXltZW50X2ZyZXF1ZW5jeRgEIAEoCVIQcGF5bWVudEZyZXF1ZW5jeRIgCg'
    'tiZW5lZmljaWFyeRgFIAEoCVILYmVuZWZpY2lhcnkSEAoDcGluGAYgASgJUgNwaW4=');

@$core.Deprecated('Use buyInsuranceResponseDescriptor instead')
const BuyInsuranceResponse$json = {
  '1': 'BuyInsuranceResponse',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
    {'1': 'first_premium', '3': 2, '4': 1, '5': 1, '10': 'firstPremium'},
    {'1': 'new_balance', '3': 3, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyInsuranceResponseDescriptor = $convert.base64Decode(
    'ChRCdXlJbnN1cmFuY2VSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYWxwcm'
    '9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZRIjCg1maXJzdF9wcmVtaXVtGAIgASgBUgxmaXJz'
    'dFByZW1pdW0SHwoLbmV3X2JhbGFuY2UYAyABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgEIA'
    'EoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getInsurancePoliciesRequestDescriptor instead')
const GetInsurancePoliciesRequest$json = {
  '1': 'GetInsurancePoliciesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInsurancePoliciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePoliciesRequestDescriptor = $convert.base64Decode(
    'ChtHZXRJbnN1cmFuY2VQb2xpY2llc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSFA'
    'oFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use getInsurancePoliciesResponseDescriptor instead')
const GetInsurancePoliciesResponse$json = {
  '1': 'GetInsurancePoliciesResponse',
  '2': [
    {'1': 'policies', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.Insurance', '10': 'policies'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_coverage', '3': 3, '4': 1, '5': 1, '10': 'totalCoverage'},
    {'1': 'total_premiums_paid', '3': 4, '4': 1, '5': 1, '10': 'totalPremiumsPaid'},
  ],
};

/// Descriptor for `GetInsurancePoliciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePoliciesResponseDescriptor = $convert.base64Decode(
    'ChxHZXRJbnN1cmFuY2VQb2xpY2llc1Jlc3BvbnNlEjgKCHBvbGljaWVzGAEgAygLMhwuZmluYW'
    '5jaWFscHJvZHVjdHMuSW5zdXJhbmNlUghwb2xpY2llcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwS'
    'JQoOdG90YWxfY292ZXJhZ2UYAyABKAFSDXRvdGFsQ292ZXJhZ2USLgoTdG90YWxfcHJlbWl1bX'
    'NfcGFpZBgEIAEoAVIRdG90YWxQcmVtaXVtc1BhaWQ=');

@$core.Deprecated('Use getInsurancePolicyRequestDescriptor instead')
const GetInsurancePolicyRequest$json = {
  '1': 'GetInsurancePolicyRequest',
  '2': [
    {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
  ],
};

/// Descriptor for `GetInsurancePolicyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePolicyRequestDescriptor = $convert.base64Decode(
    'ChlHZXRJbnN1cmFuY2VQb2xpY3lSZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SW'
    'Q=');

@$core.Deprecated('Use getInsurancePolicyResponseDescriptor instead')
const GetInsurancePolicyResponse$json = {
  '1': 'GetInsurancePolicyResponse',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `GetInsurancePolicyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePolicyResponseDescriptor = $convert.base64Decode(
    'ChpHZXRJbnN1cmFuY2VQb2xpY3lSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbm'
    'NpYWxwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZQ==');

@$core.Deprecated('Use makeInsuranceClaimRequestDescriptor instead')
const MakeInsuranceClaimRequest$json = {
  '1': 'MakeInsuranceClaimRequest',
  '2': [
    {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    {'1': 'claim_amount', '3': 2, '4': 1, '5': 1, '10': 'claimAmount'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'documents', '3': 4, '4': 3, '5': 9, '10': 'documents'},
  ],
};

/// Descriptor for `MakeInsuranceClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeInsuranceClaimRequestDescriptor = $convert.base64Decode(
    'ChlNYWtlSW5zdXJhbmNlQ2xhaW1SZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SW'
    'QSIQoMY2xhaW1fYW1vdW50GAIgASgBUgtjbGFpbUFtb3VudBIWCgZyZWFzb24YAyABKAlSBnJl'
    'YXNvbhIcCglkb2N1bWVudHMYBCADKAlSCWRvY3VtZW50cw==');

@$core.Deprecated('Use makeInsuranceClaimResponseDescriptor instead')
const MakeInsuranceClaimResponse$json = {
  '1': 'MakeInsuranceClaimResponse',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.InsuranceClaim', '10': 'claim'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MakeInsuranceClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeInsuranceClaimResponseDescriptor = $convert.base64Decode(
    'ChpNYWtlSW5zdXJhbmNlQ2xhaW1SZXNwb25zZRI3CgVjbGFpbRgBIAEoCzIhLmZpbmFuY2lhbH'
    'Byb2R1Y3RzLkluc3VyYW5jZUNsYWltUgVjbGFpbRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use cancelInsuranceRequestDescriptor instead')
const CancelInsuranceRequest$json = {
  '1': 'CancelInsuranceRequest',
  '2': [
    {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInsuranceRequestDescriptor = $convert.base64Decode(
    'ChZDYW5jZWxJbnN1cmFuY2VSZXF1ZXN0EhsKCXBvbGljeV9pZBgBIAEoCVIIcG9saWN5SWQSFg'
    'oGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use cancelInsuranceResponseDescriptor instead')
const CancelInsuranceResponse$json = {
  '1': 'CancelInsuranceResponse',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Insurance', '10': 'insurance'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInsuranceResponseDescriptor = $convert.base64Decode(
    'ChdDYW5jZWxJbnN1cmFuY2VSZXNwb25zZRI6CglpbnN1cmFuY2UYASABKAsyHC5maW5hbmNpYW'
    'xwcm9kdWN0cy5JbnN1cmFuY2VSCWluc3VyYW5jZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getInsurancePlansRequestDescriptor instead')
const GetInsurancePlansRequest$json = {
  '1': 'GetInsurancePlansRequest',
  '2': [
    {'1': 'coverage_type', '3': 1, '4': 1, '5': 9, '10': 'coverageType'},
  ],
};

/// Descriptor for `GetInsurancePlansRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePlansRequestDescriptor = $convert.base64Decode(
    'ChhHZXRJbnN1cmFuY2VQbGFuc1JlcXVlc3QSIwoNY292ZXJhZ2VfdHlwZRgBIAEoCVIMY292ZX'
    'JhZ2VUeXBl');

@$core.Deprecated('Use getInsurancePlansResponseDescriptor instead')
const GetInsurancePlansResponse$json = {
  '1': 'GetInsurancePlansResponse',
  '2': [
    {'1': 'plans', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.InsurancePlan', '10': 'plans'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInsurancePlansResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePlansResponseDescriptor = $convert.base64Decode(
    'ChlHZXRJbnN1cmFuY2VQbGFuc1Jlc3BvbnNlEjYKBXBsYW5zGAEgAygLMiAuZmluYW5jaWFscH'
    'JvZHVjdHMuSW5zdXJhbmNlUGxhblIFcGxhbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use createCrowdfundRequestDescriptor instead')
const CreateCrowdfundRequest$json = {
  '1': 'CreateCrowdfundRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'deadline', '3': 6, '4': 1, '5': 9, '10': 'deadline'},
    {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `CreateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVDcm93ZGZ1bmRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZB'
    'IUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9u'
    'EhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIjCg10YXJnZXRfYW1vdW50GAUgASgBUgx0YX'
    'JnZXRBbW91bnQSGgoIZGVhZGxpbmUYBiABKAlSCGRlYWRsaW5lEhsKCWltYWdlX3VybBgHIAEo'
    'CVIIaW1hZ2VVcmw=');

@$core.Deprecated('Use createCrowdfundResponseDescriptor instead')
const CreateCrowdfundResponse$json = {
  '1': 'CreateCrowdfundResponse',
  '2': [
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVDcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYW'
    'xwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getCrowdfundsRequestDescriptor instead')
const GetCrowdfundsRequest$json = {
  '1': 'GetCrowdfundsRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetCrowdfundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundsRequestDescriptor = $convert.base64Decode(
    'ChRHZXRDcm93ZGZ1bmRzUmVxdWVzdBIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnkSFgoGc3'
    'RhdHVzGAIgASgJUgZzdGF0dXMSFAoFbGltaXQYAyABKAVSBWxpbWl0EhYKBm9mZnNldBgEIAEo'
    'BVIGb2Zmc2V0');

@$core.Deprecated('Use getCrowdfundsResponseDescriptor instead')
const GetCrowdfundsResponse$json = {
  '1': 'GetCrowdfundsResponse',
  '2': [
    {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfunds'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRDcm93ZGZ1bmRzUmVzcG9uc2USPAoKY3Jvd2RmdW5kcxgBIAMoCzIcLmZpbmFuY2lhbH'
    'Byb2R1Y3RzLkNyb3dkZnVuZFIKY3Jvd2RmdW5kcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use getCrowdfundRequestDescriptor instead')
const GetCrowdfundRequest$json = {
  '1': 'GetCrowdfundRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `GetCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChNHZXRDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSW'
    'Q=');

@$core.Deprecated('Use getCrowdfundResponseDescriptor instead')
const GetCrowdfundResponse$json = {
  '1': 'GetCrowdfundResponse',
  '2': [
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    {'1': 'recent_contributions', '3': 2, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'recentContributions'},
  ],
};

/// Descriptor for `GetCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundResponseDescriptor = $convert.base64Decode(
    'ChRHZXRDcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYWxwcm'
    '9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBJbChRyZWNlbnRfY29udHJpYnV0aW9ucxgCIAMo'
    'CzIoLmZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZENvbnRyaWJ1dGlvblITcmVjZW50Q29udH'
    'JpYnV0aW9ucw==');

@$core.Deprecated('Use contributeToCrowdfundRequestDescriptor instead')
const ContributeToCrowdfundRequest$json = {
  '1': 'ContributeToCrowdfundRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_anonymous', '3': 5, '4': 1, '5': 8, '10': 'isAnonymous'},
    {'1': 'pin', '3': 6, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `ContributeToCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChxDb250cmlidXRlVG9Dcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3'
    'Jvd2RmdW5kSWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgDIAEo'
    'AVIGYW1vdW50EhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2USIQoMaXNfYW5vbnltb3VzGAUgAS'
    'gIUgtpc0Fub255bW91cxIQCgNwaW4YBiABKAlSA3Bpbg==');

@$core.Deprecated('Use contributeToCrowdfundResponseDescriptor instead')
const ContributeToCrowdfundResponse$json = {
  '1': 'ContributeToCrowdfundResponse',
  '2': [
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    {'1': 'contribution', '3': 2, '4': 1, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'contribution'},
    {'1': 'new_balance', '3': 3, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ContributeToCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributeToCrowdfundResponseDescriptor = $convert.base64Decode(
    'Ch1Db250cmlidXRlVG9Dcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW'
    '5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBJMCgxjb250cmlidXRpb24YAiAB'
    'KAsyKC5maW5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRDb250cmlidXRpb25SDGNvbnRyaWJ1dG'
    'lvbhIfCgtuZXdfYmFsYW5jZRgDIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAQgASgJUgdt'
    'ZXNzYWdl');

@$core.Deprecated('Use withdrawFromCrowdfundRequestDescriptor instead')
const WithdrawFromCrowdfundRequest$json = {
  '1': 'WithdrawFromCrowdfundRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'destination_account_type', '3': 5, '4': 1, '5': 9, '10': 'destinationAccountType'},
  ],
};

/// Descriptor for `WithdrawFromCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChxXaXRoZHJhd0Zyb21Dcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3'
    'Jvd2RmdW5kSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSEAoDcGluGAMgASgJUgNwaW4SNAoW'
    'ZGVzdGluYXRpb25fYWNjb3VudF9pZBgEIAEoCVIUZGVzdGluYXRpb25BY2NvdW50SWQSOAoYZG'
    'VzdGluYXRpb25fYWNjb3VudF90eXBlGAUgASgJUhZkZXN0aW5hdGlvbkFjY291bnRUeXBl');

@$core.Deprecated('Use withdrawFromCrowdfundResponseDescriptor instead')
const WithdrawFromCrowdfundResponse$json = {
  '1': 'WithdrawFromCrowdfundResponse',
  '2': [
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    {'1': 'amount_withdrawn', '3': 2, '4': 1, '5': 1, '10': 'amountWithdrawn'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'destination_new_balance', '3': 5, '4': 1, '5': 1, '10': 'destinationNewBalance'},
  ],
};

/// Descriptor for `WithdrawFromCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCrowdfundResponseDescriptor = $convert.base64Decode(
    'Ch1XaXRoZHJhd0Zyb21Dcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW'
    '5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBIpChBhbW91bnRfd2l0aGRyYXdu'
    'GAIgASgBUg9hbW91bnRXaXRoZHJhd24SGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRI0ChZkZX'
    'N0aW5hdGlvbl9hY2NvdW50X2lkGAQgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBI2ChdkZXN0'
    'aW5hdGlvbl9uZXdfYmFsYW5jZRgFIAEoAVIVZGVzdGluYXRpb25OZXdCYWxhbmNl');

@$core.Deprecated('Use closeCrowdfundRequestDescriptor instead')
const CloseCrowdfundRequest$json = {
  '1': 'CloseCrowdfundRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `CloseCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChVDbG9zZUNyb3dkZnVuZFJlcXVlc3QSIQoMY3Jvd2RmdW5kX2lkGAEgASgJUgtjcm93ZGZ1bm'
    'RJZA==');

@$core.Deprecated('Use closeCrowdfundResponseDescriptor instead')
const CloseCrowdfundResponse$json = {
  '1': 'CloseCrowdfundResponse',
  '2': [
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CloseCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeCrowdfundResponseDescriptor = $convert.base64Decode(
    'ChZDbG9zZUNyb3dkZnVuZFJlc3BvbnNlEjoKCWNyb3dkZnVuZBgBIAEoCzIcLmZpbmFuY2lhbH'
    'Byb2R1Y3RzLkNyb3dkZnVuZFIJY3Jvd2RmdW5kEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getCrowdfundStatisticsRequestDescriptor instead')
const GetCrowdfundStatisticsRequest$json = {
  '1': 'GetCrowdfundStatisticsRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'include_leaderboard', '3': 2, '4': 1, '5': 8, '10': 'includeLeaderboard'},
    {'1': 'include_daily_progress', '3': 3, '4': 1, '5': 8, '10': 'includeDailyProgress'},
    {'1': 'leaderboard_limit', '3': 4, '4': 1, '5': 5, '10': 'leaderboardLimit'},
    {'1': 'progress_days', '3': 5, '4': 1, '5': 5, '10': 'progressDays'},
  ],
};

/// Descriptor for `GetCrowdfundStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundStatisticsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRDcm93ZGZ1bmRTdGF0aXN0aWNzUmVxdWVzdBIhCgxjcm93ZGZ1bmRfaWQYASABKAlSC2'
    'Nyb3dkZnVuZElkEi8KE2luY2x1ZGVfbGVhZGVyYm9hcmQYAiABKAhSEmluY2x1ZGVMZWFkZXJi'
    'b2FyZBI0ChZpbmNsdWRlX2RhaWx5X3Byb2dyZXNzGAMgASgIUhRpbmNsdWRlRGFpbHlQcm9ncm'
    'VzcxIrChFsZWFkZXJib2FyZF9saW1pdBgEIAEoBVIQbGVhZGVyYm9hcmRMaW1pdBIjCg1wcm9n'
    'cmVzc19kYXlzGAUgASgFUgxwcm9ncmVzc0RheXM=');

@$core.Deprecated('Use getCrowdfundStatisticsResponseDescriptor instead')
const GetCrowdfundStatisticsResponse$json = {
  '1': 'GetCrowdfundStatisticsResponse',
  '2': [
    {'1': 'statistics', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.CrowdfundStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetCrowdfundStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundStatisticsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRDcm93ZGZ1bmRTdGF0aXN0aWNzUmVzcG9uc2USRgoKc3RhdGlzdGljcxgBIAEoCzImLm'
    'ZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFN0YXRpc3RpY3NSCnN0YXRpc3RpY3M=');

@$core.Deprecated('Use crowdfundStatisticsDescriptor instead')
const CrowdfundStatistics$json = {
  '1': 'CrowdfundStatistics',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'total_raised', '3': 2, '4': 1, '5': 1, '10': 'totalRaised'},
    {'1': 'target_amount', '3': 3, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'progress_percentage', '3': 4, '4': 1, '5': 1, '10': 'progressPercentage'},
    {'1': 'donor_count', '3': 5, '4': 1, '5': 5, '10': 'donorCount'},
    {'1': 'average_donation', '3': 6, '4': 1, '5': 1, '10': 'averageDonation'},
    {'1': 'largest_donation', '3': 7, '4': 1, '5': 1, '10': 'largestDonation'},
    {'1': 'smallest_donation', '3': 8, '4': 1, '5': 1, '10': 'smallestDonation'},
    {'1': 'days_remaining', '3': 9, '4': 1, '5': 5, '10': 'daysRemaining'},
    {'1': 'days_active', '3': 10, '4': 1, '5': 5, '10': 'daysActive'},
    {'1': 'is_completed', '3': 11, '4': 1, '5': 8, '10': 'isCompleted'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'top_contributors', '3': 13, '4': 3, '5': 11, '6': '.financialproducts.ContributorLeaderboardEntry', '10': 'topContributors'},
    {'1': 'daily_progress', '3': 14, '4': 3, '5': 11, '6': '.financialproducts.DailyProgress', '10': 'dailyProgress'},
    {'1': 'funding_velocity', '3': 15, '4': 1, '5': 1, '10': 'fundingVelocity'},
    {'1': 'projected_completion_date', '3': 16, '4': 1, '5': 9, '10': 'projectedCompletionDate'},
    {'1': 'new_donors_today', '3': 17, '4': 1, '5': 5, '10': 'newDonorsToday'},
    {'1': 'new_donors_this_week', '3': 18, '4': 1, '5': 5, '10': 'newDonorsThisWeek'},
    {'1': 'amount_raised_today', '3': 19, '4': 1, '5': 1, '10': 'amountRaisedToday'},
    {'1': 'amount_raised_this_week', '3': 20, '4': 1, '5': 1, '10': 'amountRaisedThisWeek'},
  ],
};

/// Descriptor for `CrowdfundStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundStatisticsDescriptor = $convert.base64Decode(
    'ChNDcm93ZGZ1bmRTdGF0aXN0aWNzEiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSW'
    'QSIQoMdG90YWxfcmFpc2VkGAIgASgBUgt0b3RhbFJhaXNlZBIjCg10YXJnZXRfYW1vdW50GAMg'
    'ASgBUgx0YXJnZXRBbW91bnQSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgEIAEoAVIScHJvZ3Jlc3'
    'NQZXJjZW50YWdlEh8KC2Rvbm9yX2NvdW50GAUgASgFUgpkb25vckNvdW50EikKEGF2ZXJhZ2Vf'
    'ZG9uYXRpb24YBiABKAFSD2F2ZXJhZ2VEb25hdGlvbhIpChBsYXJnZXN0X2RvbmF0aW9uGAcgAS'
    'gBUg9sYXJnZXN0RG9uYXRpb24SKwoRc21hbGxlc3RfZG9uYXRpb24YCCABKAFSEHNtYWxsZXN0'
    'RG9uYXRpb24SJQoOZGF5c19yZW1haW5pbmcYCSABKAVSDWRheXNSZW1haW5pbmcSHwoLZGF5c1'
    '9hY3RpdmUYCiABKAVSCmRheXNBY3RpdmUSIQoMaXNfY29tcGxldGVkGAsgASgIUgtpc0NvbXBs'
    'ZXRlZBIdCgpjcmVhdGVkX2F0GAwgASgJUgljcmVhdGVkQXQSWQoQdG9wX2NvbnRyaWJ1dG9ycx'
    'gNIAMoCzIuLmZpbmFuY2lhbHByb2R1Y3RzLkNvbnRyaWJ1dG9yTGVhZGVyYm9hcmRFbnRyeVIP'
    'dG9wQ29udHJpYnV0b3JzEkcKDmRhaWx5X3Byb2dyZXNzGA4gAygLMiAuZmluYW5jaWFscHJvZH'
    'VjdHMuRGFpbHlQcm9ncmVzc1INZGFpbHlQcm9ncmVzcxIpChBmdW5kaW5nX3ZlbG9jaXR5GA8g'
    'ASgBUg9mdW5kaW5nVmVsb2NpdHkSOgoZcHJvamVjdGVkX2NvbXBsZXRpb25fZGF0ZRgQIAEoCV'
    'IXcHJvamVjdGVkQ29tcGxldGlvbkRhdGUSKAoQbmV3X2Rvbm9yc190b2RheRgRIAEoBVIObmV3'
    'RG9ub3JzVG9kYXkSLwoUbmV3X2Rvbm9yc190aGlzX3dlZWsYEiABKAVSEW5ld0Rvbm9yc1RoaX'
    'NXZWVrEi4KE2Ftb3VudF9yYWlzZWRfdG9kYXkYEyABKAFSEWFtb3VudFJhaXNlZFRvZGF5EjUK'
    'F2Ftb3VudF9yYWlzZWRfdGhpc193ZWVrGBQgASgBUhRhbW91bnRSYWlzZWRUaGlzV2Vlaw==');

@$core.Deprecated('Use contributorLeaderboardEntryDescriptor instead')
const ContributorLeaderboardEntry$json = {
  '1': 'ContributorLeaderboardEntry',
  '2': [
    {'1': 'rank', '3': 1, '4': 1, '5': 5, '10': 'rank'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'profile_picture', '3': 4, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'total_amount', '3': 5, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'contribution_count', '3': 6, '4': 1, '5': 5, '10': 'contributionCount'},
    {'1': 'is_anonymous', '3': 7, '4': 1, '5': 8, '10': 'isAnonymous'},
    {'1': 'first_contribution_date', '3': 8, '4': 1, '5': 9, '10': 'firstContributionDate'},
    {'1': 'last_contribution_date', '3': 9, '4': 1, '5': 9, '10': 'lastContributionDate'},
  ],
};

/// Descriptor for `ContributorLeaderboardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributorLeaderboardEntryDescriptor = $convert.base64Decode(
    'ChtDb250cmlidXRvckxlYWRlcmJvYXJkRW50cnkSEgoEcmFuaxgBIAEoBVIEcmFuaxIXCgd1c2'
    'VyX2lkGAIgASgJUgZ1c2VySWQSIQoMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIn'
    'Cg9wcm9maWxlX3BpY3R1cmUYBCABKAlSDnByb2ZpbGVQaWN0dXJlEiEKDHRvdGFsX2Ftb3VudB'
    'gFIAEoAVILdG90YWxBbW91bnQSLQoSY29udHJpYnV0aW9uX2NvdW50GAYgASgFUhFjb250cmli'
    'dXRpb25Db3VudBIhCgxpc19hbm9ueW1vdXMYByABKAhSC2lzQW5vbnltb3VzEjYKF2ZpcnN0X2'
    'NvbnRyaWJ1dGlvbl9kYXRlGAggASgJUhVmaXJzdENvbnRyaWJ1dGlvbkRhdGUSNAoWbGFzdF9j'
    'b250cmlidXRpb25fZGF0ZRgJIAEoCVIUbGFzdENvbnRyaWJ1dGlvbkRhdGU=');

@$core.Deprecated('Use dailyProgressDescriptor instead')
const DailyProgress$json = {
  '1': 'DailyProgress',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
    {'1': 'amount_raised', '3': 2, '4': 1, '5': 1, '10': 'amountRaised'},
    {'1': 'new_donors', '3': 3, '4': 1, '5': 5, '10': 'newDonors'},
    {'1': 'total_contributions', '3': 4, '4': 1, '5': 5, '10': 'totalContributions'},
    {'1': 'cumulative_amount', '3': 5, '4': 1, '5': 1, '10': 'cumulativeAmount'},
    {'1': 'progress_percentage', '3': 6, '4': 1, '5': 1, '10': 'progressPercentage'},
  ],
};

/// Descriptor for `DailyProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyProgressDescriptor = $convert.base64Decode(
    'Cg1EYWlseVByb2dyZXNzEhIKBGRhdGUYASABKAlSBGRhdGUSIwoNYW1vdW50X3JhaXNlZBgCIA'
    'EoAVIMYW1vdW50UmFpc2VkEh0KCm5ld19kb25vcnMYAyABKAVSCW5ld0Rvbm9ycxIvChN0b3Rh'
    'bF9jb250cmlidXRpb25zGAQgASgFUhJ0b3RhbENvbnRyaWJ1dGlvbnMSKwoRY3VtdWxhdGl2ZV'
    '9hbW91bnQYBSABKAFSEGN1bXVsYXRpdmVBbW91bnQSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgG'
    'IAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdl');

@$core.Deprecated('Use searchCrowdfundsRequestDescriptor instead')
const SearchCrowdfundsRequest$json = {
  '1': 'SearchCrowdfundsRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchCrowdfundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCrowdfundsRequestDescriptor = $convert.base64Decode(
    'ChdTZWFyY2hDcm93ZGZ1bmRzUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSFAoFbGltaX'
    'QYAiABKAVSBWxpbWl0');

@$core.Deprecated('Use searchCrowdfundsResponseDescriptor instead')
const SearchCrowdfundsResponse$json = {
  '1': 'SearchCrowdfundsResponse',
  '2': [
    {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfunds'},
  ],
};

/// Descriptor for `SearchCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCrowdfundsResponseDescriptor = $convert.base64Decode(
    'ChhTZWFyY2hDcm93ZGZ1bmRzUmVzcG9uc2USPAoKY3Jvd2RmdW5kcxgBIAMoCzIcLmZpbmFuY2'
    'lhbHByb2R1Y3RzLkNyb3dkZnVuZFIKY3Jvd2RmdW5kcw==');

@$core.Deprecated('Use updateCrowdfundRequestDescriptor instead')
const UpdateCrowdfundRequest$json = {
  '1': 'UpdateCrowdfundRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'deadline', '3': 6, '4': 1, '5': 9, '10': 'deadline'},
    {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `UpdateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW'
    '5kSWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlw'
    'dGlvbhIaCghjYXRlZ29yeRgEIAEoCVIIY2F0ZWdvcnkSIwoNdGFyZ2V0X2Ftb3VudBgFIAEoAV'
    'IMdGFyZ2V0QW1vdW50EhoKCGRlYWRsaW5lGAYgASgJUghkZWFkbGluZRIbCglpbWFnZV91cmwY'
    'ByABKAlSCGltYWdlVXJsEhYKBnN0YXR1cxgIIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use updateCrowdfundResponseDescriptor instead')
const UpdateCrowdfundResponse$json = {
  '1': 'UpdateCrowdfundResponse',
  '2': [
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.Crowdfund', '10': 'crowdfund'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCrowdfundResponseDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVDcm93ZGZ1bmRSZXNwb25zZRI6Cgljcm93ZGZ1bmQYASABKAsyHC5maW5hbmNpYW'
    'xwcm9kdWN0cy5Dcm93ZGZ1bmRSCWNyb3dkZnVuZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use deleteCrowdfundRequestDescriptor instead')
const DeleteCrowdfundRequest$json = {
  '1': 'DeleteCrowdfundRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `DeleteCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChZEZWxldGVDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW'
    '5kSWQ=');

@$core.Deprecated('Use deleteCrowdfundResponseDescriptor instead')
const DeleteCrowdfundResponse$json = {
  '1': 'DeleteCrowdfundResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCrowdfundResponseDescriptor = $convert.base64Decode(
    'ChdEZWxldGVDcm93ZGZ1bmRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getCrowdfundDonationsRequestDescriptor instead')
const GetCrowdfundDonationsRequest$json = {
  '1': 'GetCrowdfundDonationsRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetCrowdfundDonationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundDonationsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRDcm93ZGZ1bmREb25hdGlvbnNSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3'
    'Jvd2RmdW5kSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VT'
    'aXpl');

@$core.Deprecated('Use getCrowdfundDonationsResponseDescriptor instead')
const GetCrowdfundDonationsResponse$json = {
  '1': 'GetCrowdfundDonationsResponse',
  '2': [
    {'1': 'donations', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'donations'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetCrowdfundDonationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundDonationsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRDcm93ZGZ1bmREb25hdGlvbnNSZXNwb25zZRJGCglkb25hdGlvbnMYASADKAsyKC5maW'
    '5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRDb250cmlidXRpb25SCWRvbmF0aW9ucxIUCgV0b3Rh'
    'bBgCIAEoBVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYBCABKAVSCH'
    'BhZ2VTaXplEhkKCGhhc19tb3JlGAUgASgIUgdoYXNNb3Jl');

@$core.Deprecated('Use getUserDonationsRequestDescriptor instead')
const GetUserDonationsRequest$json = {
  '1': 'GetUserDonationsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetUserDonationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDonationsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyRG9uYXRpb25zUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2'
    'l6ZRgCIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use getUserDonationsResponseDescriptor instead')
const GetUserDonationsResponse$json = {
  '1': 'GetUserDonationsResponse',
  '2': [
    {'1': 'donations', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundContribution', '10': 'donations'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetUserDonationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDonationsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VyRG9uYXRpb25zUmVzcG9uc2USRgoJZG9uYXRpb25zGAEgAygLMiguZmluYW5jaW'
    'FscHJvZHVjdHMuQ3Jvd2RmdW5kQ29udHJpYnV0aW9uUglkb25hdGlvbnMSFAoFdG90YWwYAiAB'
    'KAVSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2'
    'l6ZRIZCghoYXNfbW9yZRgFIAEoCFIHaGFzTW9yZQ==');

@$core.Deprecated('Use generateDonationReceiptRequestDescriptor instead')
const GenerateDonationReceiptRequest$json = {
  '1': 'GenerateDonationReceiptRequest',
  '2': [
    {'1': 'donation_id', '3': 1, '4': 1, '5': 9, '10': 'donationId'},
  ],
};

/// Descriptor for `GenerateDonationReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateDonationReceiptRequestDescriptor = $convert.base64Decode(
    'Ch5HZW5lcmF0ZURvbmF0aW9uUmVjZWlwdFJlcXVlc3QSHwoLZG9uYXRpb25faWQYASABKAlSCm'
    'RvbmF0aW9uSWQ=');

@$core.Deprecated('Use generateDonationReceiptResponseDescriptor instead')
const GenerateDonationReceiptResponse$json = {
  '1': 'GenerateDonationReceiptResponse',
  '2': [
    {'1': 'receipt', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.CrowdfundReceipt', '10': 'receipt'},
  ],
};

/// Descriptor for `GenerateDonationReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateDonationReceiptResponseDescriptor = $convert.base64Decode(
    'Ch9HZW5lcmF0ZURvbmF0aW9uUmVjZWlwdFJlc3BvbnNlEj0KB3JlY2VpcHQYASABKAsyIy5maW'
    '5hbmNpYWxwcm9kdWN0cy5Dcm93ZGZ1bmRSZWNlaXB0UgdyZWNlaXB0');

@$core.Deprecated('Use getUserCrowdfundReceiptsRequestDescriptor instead')
const GetUserCrowdfundReceiptsRequest$json = {
  '1': 'GetUserCrowdfundReceiptsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetUserCrowdfundReceiptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCrowdfundReceiptsRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRVc2VyQ3Jvd2RmdW5kUmVjZWlwdHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGw'
    'oJcGFnZV9zaXplGAIgASgFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use getUserCrowdfundReceiptsResponseDescriptor instead')
const GetUserCrowdfundReceiptsResponse$json = {
  '1': 'GetUserCrowdfundReceiptsResponse',
  '2': [
    {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.CrowdfundReceipt', '10': 'receipts'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetUserCrowdfundReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCrowdfundReceiptsResponseDescriptor = $convert.base64Decode(
    'CiBHZXRVc2VyQ3Jvd2RmdW5kUmVjZWlwdHNSZXNwb25zZRI/CghyZWNlaXB0cxgBIAMoCzIjLm'
    'ZpbmFuY2lhbHByb2R1Y3RzLkNyb3dkZnVuZFJlY2VpcHRSCHJlY2VpcHRzEhQKBXRvdGFsGAIg'
    'ASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZV'
    'NpemUSGQoIaGFzX21vcmUYBSABKAhSB2hhc01vcmU=');

@$core.Deprecated('Use crowdfundReceiptDescriptor instead')
const CrowdfundReceipt$json = {
  '1': 'CrowdfundReceipt',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'donation_id', '3': 2, '4': 1, '5': 9, '10': 'donationId'},
    {'1': 'crowdfund_id', '3': 3, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'crowdfund_title', '3': 4, '4': 1, '5': 9, '10': 'crowdfundTitle'},
    {'1': 'donor_user_id', '3': 5, '4': 1, '5': 9, '10': 'donorUserId'},
    {'1': 'donor_name', '3': 6, '4': 1, '5': 9, '10': 'donorName'},
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'donation_date', '3': 9, '4': 1, '5': 9, '10': 'donationDate'},
    {'1': 'generated_at', '3': 10, '4': 1, '5': 9, '10': 'generatedAt'},
    {'1': 'receipt_number', '3': 11, '4': 1, '5': 9, '10': 'receiptNumber'},
    {'1': 'receipt_data', '3': 12, '4': 1, '5': 9, '10': 'receiptData'},
  ],
};

/// Descriptor for `CrowdfundReceipt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundReceiptDescriptor = $convert.base64Decode(
    'ChBDcm93ZGZ1bmRSZWNlaXB0Eg4KAmlkGAEgASgJUgJpZBIfCgtkb25hdGlvbl9pZBgCIAEoCV'
    'IKZG9uYXRpb25JZBIhCgxjcm93ZGZ1bmRfaWQYAyABKAlSC2Nyb3dkZnVuZElkEicKD2Nyb3dk'
    'ZnVuZF90aXRsZRgEIAEoCVIOY3Jvd2RmdW5kVGl0bGUSIgoNZG9ub3JfdXNlcl9pZBgFIAEoCV'
    'ILZG9ub3JVc2VySWQSHQoKZG9ub3JfbmFtZRgGIAEoCVIJZG9ub3JOYW1lEhYKBmFtb3VudBgH'
    'IAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIjCg1kb25hdGlvbl9kYX'
    'RlGAkgASgJUgxkb25hdGlvbkRhdGUSIQoMZ2VuZXJhdGVkX2F0GAogASgJUgtnZW5lcmF0ZWRB'
    'dBIlCg5yZWNlaXB0X251bWJlchgLIAEoCVINcmVjZWlwdE51bWJlchIhCgxyZWNlaXB0X2RhdG'
    'EYDCABKAlSC3JlY2VpcHREYXRh');

@$core.Deprecated('Use notificationChannelDescriptor instead')
const NotificationChannel$json = {
  '1': 'NotificationChannel',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'crowdfund_id', '3': 2, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'creator_user_id', '3': 3, '4': 1, '5': 9, '10': 'creatorUserId'},
    {'1': 'channel_type', '3': 4, '4': 1, '5': 14, '6': '.financialproducts.NotificationChannelType', '10': 'channelType'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.financialproducts.NotificationChannelStatus', '10': 'status'},
    {'1': 'channel_name', '3': 6, '4': 1, '5': 9, '10': 'channelName'},
    {'1': 'channel_identifier', '3': 7, '4': 1, '5': 9, '10': 'channelIdentifier'},
    {'1': 'channel_username', '3': 8, '4': 1, '5': 9, '10': 'channelUsername'},
    {'1': 'enabled_events', '3': 9, '4': 3, '5': 14, '6': '.financialproducts.NotificationEventType', '10': 'enabledEvents'},
    {'1': 'preferences', '3': 10, '4': 1, '5': 11, '6': '.financialproducts.NotificationPreferences', '10': 'preferences'},
    {'1': 'last_notification_at', '3': 11, '4': 1, '5': 9, '10': 'lastNotificationAt'},
    {'1': 'notification_count', '3': 12, '4': 1, '5': 5, '10': 'notificationCount'},
    {'1': 'failure_count', '3': 13, '4': 1, '5': 5, '10': 'failureCount'},
    {'1': 'last_error', '3': 14, '4': 1, '5': 9, '10': 'lastError'},
    {'1': 'created_at', '3': 15, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 16, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `NotificationChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationChannelDescriptor = $convert.base64Decode(
    'ChNOb3RpZmljYXRpb25DaGFubmVsEg4KAmlkGAEgASgJUgJpZBIhCgxjcm93ZGZ1bmRfaWQYAi'
    'ABKAlSC2Nyb3dkZnVuZElkEiYKD2NyZWF0b3JfdXNlcl9pZBgDIAEoCVINY3JlYXRvclVzZXJJ'
    'ZBJNCgxjaGFubmVsX3R5cGUYBCABKA4yKi5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb2'
    '5DaGFubmVsVHlwZVILY2hhbm5lbFR5cGUSRAoGc3RhdHVzGAUgASgOMiwuZmluYW5jaWFscHJv'
    'ZHVjdHMuTm90aWZpY2F0aW9uQ2hhbm5lbFN0YXR1c1IGc3RhdHVzEiEKDGNoYW5uZWxfbmFtZR'
    'gGIAEoCVILY2hhbm5lbE5hbWUSLQoSY2hhbm5lbF9pZGVudGlmaWVyGAcgASgJUhFjaGFubmVs'
    'SWRlbnRpZmllchIpChBjaGFubmVsX3VzZXJuYW1lGAggASgJUg9jaGFubmVsVXNlcm5hbWUSTw'
    'oOZW5hYmxlZF9ldmVudHMYCSADKA4yKC5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25F'
    'dmVudFR5cGVSDWVuYWJsZWRFdmVudHMSTAoLcHJlZmVyZW5jZXMYCiABKAsyKi5maW5hbmNpYW'
    'xwcm9kdWN0cy5Ob3RpZmljYXRpb25QcmVmZXJlbmNlc1ILcHJlZmVyZW5jZXMSMAoUbGFzdF9u'
    'b3RpZmljYXRpb25fYXQYCyABKAlSEmxhc3ROb3RpZmljYXRpb25BdBItChJub3RpZmljYXRpb2'
    '5fY291bnQYDCABKAVSEW5vdGlmaWNhdGlvbkNvdW50EiMKDWZhaWx1cmVfY291bnQYDSABKAVS'
    'DGZhaWx1cmVDb3VudBIdCgpsYXN0X2Vycm9yGA4gASgJUglsYXN0RXJyb3ISHQoKY3JlYXRlZF'
    '9hdBgPIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYECABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use notificationPreferencesDescriptor instead')
const NotificationPreferences$json = {
  '1': 'NotificationPreferences',
  '2': [
    {'1': 'include_donor_name', '3': 1, '4': 1, '5': 8, '10': 'includeDonorName'},
    {'1': 'include_amount', '3': 2, '4': 1, '5': 8, '10': 'includeAmount'},
    {'1': 'include_message', '3': 3, '4': 1, '5': 8, '10': 'includeMessage'},
    {'1': 'include_progress', '3': 4, '4': 1, '5': 8, '10': 'includeProgress'},
    {'1': 'include_leaderboard', '3': 5, '4': 1, '5': 8, '10': 'includeLeaderboard'},
    {'1': 'large_donation_threshold', '3': 6, '4': 1, '5': 1, '10': 'largeDonationThreshold'},
    {'1': 'message_template', '3': 7, '4': 1, '5': 9, '10': 'messageTemplate'},
    {'1': 'language', '3': 8, '4': 1, '5': 9, '10': 'language'},
    {'1': 'quiet_hours_enabled', '3': 9, '4': 1, '5': 8, '10': 'quietHoursEnabled'},
    {'1': 'quiet_hours_start', '3': 10, '4': 1, '5': 9, '10': 'quietHoursStart'},
    {'1': 'quiet_hours_end', '3': 11, '4': 1, '5': 9, '10': 'quietHoursEnd'},
    {'1': 'timezone', '3': 12, '4': 1, '5': 9, '10': 'timezone'},
  ],
};

/// Descriptor for `NotificationPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationPreferencesDescriptor = $convert.base64Decode(
    'ChdOb3RpZmljYXRpb25QcmVmZXJlbmNlcxIsChJpbmNsdWRlX2Rvbm9yX25hbWUYASABKAhSEG'
    'luY2x1ZGVEb25vck5hbWUSJQoOaW5jbHVkZV9hbW91bnQYAiABKAhSDWluY2x1ZGVBbW91bnQS'
    'JwoPaW5jbHVkZV9tZXNzYWdlGAMgASgIUg5pbmNsdWRlTWVzc2FnZRIpChBpbmNsdWRlX3Byb2'
    'dyZXNzGAQgASgIUg9pbmNsdWRlUHJvZ3Jlc3MSLwoTaW5jbHVkZV9sZWFkZXJib2FyZBgFIAEo'
    'CFISaW5jbHVkZUxlYWRlcmJvYXJkEjgKGGxhcmdlX2RvbmF0aW9uX3RocmVzaG9sZBgGIAEoAV'
    'IWbGFyZ2VEb25hdGlvblRocmVzaG9sZBIpChBtZXNzYWdlX3RlbXBsYXRlGAcgASgJUg9tZXNz'
    'YWdlVGVtcGxhdGUSGgoIbGFuZ3VhZ2UYCCABKAlSCGxhbmd1YWdlEi4KE3F1aWV0X2hvdXJzX2'
    'VuYWJsZWQYCSABKAhSEXF1aWV0SG91cnNFbmFibGVkEioKEXF1aWV0X2hvdXJzX3N0YXJ0GAog'
    'ASgJUg9xdWlldEhvdXJzU3RhcnQSJgoPcXVpZXRfaG91cnNfZW5kGAsgASgJUg1xdWlldEhvdX'
    'JzRW5kEhoKCHRpbWV6b25lGAwgASgJUgh0aW1lem9uZQ==');

@$core.Deprecated('Use notificationDeliveryDescriptor instead')
const NotificationDelivery$json = {
  '1': 'NotificationDelivery',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'crowdfund_id', '3': 3, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'event_type', '3': 4, '4': 1, '5': 14, '6': '.financialproducts.NotificationEventType', '10': 'eventType'},
    {'1': 'event_data', '3': 5, '4': 1, '5': 9, '10': 'eventData'},
    {'1': 'message_content', '3': 6, '4': 1, '5': 9, '10': 'messageContent'},
    {'1': 'success', '3': 7, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_message', '3': 8, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'retry_count', '3': 9, '4': 1, '5': 5, '10': 'retryCount'},
    {'1': 'platform_message_id', '3': 10, '4': 1, '5': 9, '10': 'platformMessageId'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'delivered_at', '3': 12, '4': 1, '5': 9, '10': 'deliveredAt'},
  ],
};

/// Descriptor for `NotificationDelivery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationDeliveryDescriptor = $convert.base64Decode(
    'ChROb3RpZmljYXRpb25EZWxpdmVyeRIOCgJpZBgBIAEoCVICaWQSHQoKY2hhbm5lbF9pZBgCIA'
    'EoCVIJY2hhbm5lbElkEiEKDGNyb3dkZnVuZF9pZBgDIAEoCVILY3Jvd2RmdW5kSWQSRwoKZXZl'
    'bnRfdHlwZRgEIAEoDjIoLmZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvbkV2ZW50VHlwZV'
    'IJZXZlbnRUeXBlEh0KCmV2ZW50X2RhdGEYBSABKAlSCWV2ZW50RGF0YRInCg9tZXNzYWdlX2Nv'
    'bnRlbnQYBiABKAlSDm1lc3NhZ2VDb250ZW50EhgKB3N1Y2Nlc3MYByABKAhSB3N1Y2Nlc3MSIw'
    'oNZXJyb3JfbWVzc2FnZRgIIAEoCVIMZXJyb3JNZXNzYWdlEh8KC3JldHJ5X2NvdW50GAkgASgF'
    'UgpyZXRyeUNvdW50Ei4KE3BsYXRmb3JtX21lc3NhZ2VfaWQYCiABKAlSEXBsYXRmb3JtTWVzc2'
    'FnZUlkEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIhCgxkZWxpdmVyZWRfYXQYDCAB'
    'KAlSC2RlbGl2ZXJlZEF0');

@$core.Deprecated('Use connectNotificationChannelRequestDescriptor instead')
const ConnectNotificationChannelRequest$json = {
  '1': 'ConnectNotificationChannelRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'channel_type', '3': 2, '4': 1, '5': 14, '6': '.financialproducts.NotificationChannelType', '10': 'channelType'},
    {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
    {'1': 'telegram', '3': 4, '4': 1, '5': 11, '6': '.financialproducts.TelegramConnectionData', '9': 0, '10': 'telegram'},
    {'1': 'discord', '3': 5, '4': 1, '5': 11, '6': '.financialproducts.DiscordConnectionData', '9': 0, '10': 'discord'},
    {'1': 'whatsapp_business', '3': 6, '4': 1, '5': 11, '6': '.financialproducts.WhatsAppBusinessConnectionData', '9': 0, '10': 'whatsappBusiness'},
    {'1': 'slack', '3': 7, '4': 1, '5': 11, '6': '.financialproducts.SlackConnectionData', '9': 0, '10': 'slack'},
    {'1': 'enabled_events', '3': 8, '4': 3, '5': 14, '6': '.financialproducts.NotificationEventType', '10': 'enabledEvents'},
    {'1': 'preferences', '3': 9, '4': 1, '5': 11, '6': '.financialproducts.NotificationPreferences', '10': 'preferences'},
  ],
  '8': [
    {'1': 'connection_data'},
  ],
};

/// Descriptor for `ConnectNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectNotificationChannelRequestDescriptor = $convert.base64Decode(
    'CiFDb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlcXVlc3QSIQoMY3Jvd2RmdW5kX2lkGAEgAS'
    'gJUgtjcm93ZGZ1bmRJZBJNCgxjaGFubmVsX3R5cGUYAiABKA4yKi5maW5hbmNpYWxwcm9kdWN0'
    'cy5Ob3RpZmljYXRpb25DaGFubmVsVHlwZVILY2hhbm5lbFR5cGUSIQoMY2hhbm5lbF9uYW1lGA'
    'MgASgJUgtjaGFubmVsTmFtZRJHCgh0ZWxlZ3JhbRgEIAEoCzIpLmZpbmFuY2lhbHByb2R1Y3Rz'
    'LlRlbGVncmFtQ29ubmVjdGlvbkRhdGFIAFIIdGVsZWdyYW0SRAoHZGlzY29yZBgFIAEoCzIoLm'
    'ZpbmFuY2lhbHByb2R1Y3RzLkRpc2NvcmRDb25uZWN0aW9uRGF0YUgAUgdkaXNjb3JkEmAKEXdo'
    'YXRzYXBwX2J1c2luZXNzGAYgASgLMjEuZmluYW5jaWFscHJvZHVjdHMuV2hhdHNBcHBCdXNpbm'
    'Vzc0Nvbm5lY3Rpb25EYXRhSABSEHdoYXRzYXBwQnVzaW5lc3MSPgoFc2xhY2sYByABKAsyJi5m'
    'aW5hbmNpYWxwcm9kdWN0cy5TbGFja0Nvbm5lY3Rpb25EYXRhSABSBXNsYWNrEk8KDmVuYWJsZW'
    'RfZXZlbnRzGAggAygOMiguZmluYW5jaWFscHJvZHVjdHMuTm90aWZpY2F0aW9uRXZlbnRUeXBl'
    'Ug1lbmFibGVkRXZlbnRzEkwKC3ByZWZlcmVuY2VzGAkgASgLMiouZmluYW5jaWFscHJvZHVjdH'
    'MuTm90aWZpY2F0aW9uUHJlZmVyZW5jZXNSC3ByZWZlcmVuY2VzQhEKD2Nvbm5lY3Rpb25fZGF0'
    'YQ==');

@$core.Deprecated('Use telegramConnectionDataDescriptor instead')
const TelegramConnectionData$json = {
  '1': 'TelegramConnectionData',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 9, '10': 'chatId'},
    {'1': 'verification_code', '3': 2, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
};

/// Descriptor for `TelegramConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List telegramConnectionDataDescriptor = $convert.base64Decode(
    'ChZUZWxlZ3JhbUNvbm5lY3Rpb25EYXRhEhcKB2NoYXRfaWQYASABKAlSBmNoYXRJZBIrChF2ZX'
    'JpZmljYXRpb25fY29kZRgCIAEoCVIQdmVyaWZpY2F0aW9uQ29kZQ==');

@$core.Deprecated('Use discordConnectionDataDescriptor instead')
const DiscordConnectionData$json = {
  '1': 'DiscordConnectionData',
  '2': [
    {'1': 'webhook_url', '3': 1, '4': 1, '5': 9, '10': 'webhookUrl'},
    {'1': 'server_name', '3': 2, '4': 1, '5': 9, '10': 'serverName'},
    {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `DiscordConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List discordConnectionDataDescriptor = $convert.base64Decode(
    'ChVEaXNjb3JkQ29ubmVjdGlvbkRhdGESHwoLd2ViaG9va191cmwYASABKAlSCndlYmhvb2tVcm'
    'wSHwoLc2VydmVyX25hbWUYAiABKAlSCnNlcnZlck5hbWUSIQoMY2hhbm5lbF9uYW1lGAMgASgJ'
    'UgtjaGFubmVsTmFtZQ==');

@$core.Deprecated('Use whatsAppBusinessConnectionDataDescriptor instead')
const WhatsAppBusinessConnectionData$json = {
  '1': 'WhatsAppBusinessConnectionData',
  '2': [
    {'1': 'phone_number_id', '3': 1, '4': 1, '5': 9, '10': 'phoneNumberId'},
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'recipient_id', '3': 3, '4': 1, '5': 9, '10': 'recipientId'},
  ],
};

/// Descriptor for `WhatsAppBusinessConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List whatsAppBusinessConnectionDataDescriptor = $convert.base64Decode(
    'Ch5XaGF0c0FwcEJ1c2luZXNzQ29ubmVjdGlvbkRhdGESJgoPcGhvbmVfbnVtYmVyX2lkGAEgAS'
    'gJUg1waG9uZU51bWJlcklkEiEKDGFjY2Vzc190b2tlbhgCIAEoCVILYWNjZXNzVG9rZW4SIQoM'
    'cmVjaXBpZW50X2lkGAMgASgJUgtyZWNpcGllbnRJZA==');

@$core.Deprecated('Use slackConnectionDataDescriptor instead')
const SlackConnectionData$json = {
  '1': 'SlackConnectionData',
  '2': [
    {'1': 'webhook_url', '3': 1, '4': 1, '5': 9, '10': 'webhookUrl'},
    {'1': 'workspace_name', '3': 2, '4': 1, '5': 9, '10': 'workspaceName'},
    {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `SlackConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List slackConnectionDataDescriptor = $convert.base64Decode(
    'ChNTbGFja0Nvbm5lY3Rpb25EYXRhEh8KC3dlYmhvb2tfdXJsGAEgASgJUgp3ZWJob29rVXJsEi'
    'UKDndvcmtzcGFjZV9uYW1lGAIgASgJUg13b3Jrc3BhY2VOYW1lEiEKDGNoYW5uZWxfbmFtZRgD'
    'IAEoCVILY2hhbm5lbE5hbWU=');

@$core.Deprecated('Use connectNotificationChannelResponseDescriptor instead')
const ConnectNotificationChannelResponse$json = {
  '1': 'ConnectNotificationChannelResponse',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.NotificationChannel', '10': 'channel'},
    {'1': 'requires_verification', '3': 2, '4': 1, '5': 8, '10': 'requiresVerification'},
    {'1': 'verification_instructions', '3': 3, '4': 1, '5': 9, '10': 'verificationInstructions'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ConnectNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectNotificationChannelResponseDescriptor = $convert.base64Decode(
    'CiJDb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlc3BvbnNlEkAKB2NoYW5uZWwYASABKAsyJi'
    '5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25DaGFubmVsUgdjaGFubmVsEjMKFXJlcXVp'
    'cmVzX3ZlcmlmaWNhdGlvbhgCIAEoCFIUcmVxdWlyZXNWZXJpZmljYXRpb24SOwoZdmVyaWZpY2'
    'F0aW9uX2luc3RydWN0aW9ucxgDIAEoCVIYdmVyaWZpY2F0aW9uSW5zdHJ1Y3Rpb25zEhgKB21l'
    'c3NhZ2UYBCABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use disconnectNotificationChannelRequestDescriptor instead')
const DisconnectNotificationChannelRequest$json = {
  '1': 'DisconnectNotificationChannelRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `DisconnectNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectNotificationChannelRequestDescriptor = $convert.base64Decode(
    'CiREaXNjb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlcXVlc3QSHQoKY2hhbm5lbF9pZBgBIA'
    'EoCVIJY2hhbm5lbElk');

@$core.Deprecated('Use disconnectNotificationChannelResponseDescriptor instead')
const DisconnectNotificationChannelResponse$json = {
  '1': 'DisconnectNotificationChannelResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DisconnectNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectNotificationChannelResponseDescriptor = $convert.base64Decode(
    'CiVEaXNjb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKA'
    'hSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getNotificationChannelsRequestDescriptor instead')
const GetNotificationChannelsRequest$json = {
  '1': 'GetNotificationChannelsRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `GetNotificationChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationChannelsRequestDescriptor = $convert.base64Decode(
    'Ch5HZXROb3RpZmljYXRpb25DaGFubmVsc1JlcXVlc3QSIQoMY3Jvd2RmdW5kX2lkGAEgASgJUg'
    'tjcm93ZGZ1bmRJZA==');

@$core.Deprecated('Use getNotificationChannelsResponseDescriptor instead')
const GetNotificationChannelsResponse$json = {
  '1': 'GetNotificationChannelsResponse',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.NotificationChannel', '10': 'channels'},
  ],
};

/// Descriptor for `GetNotificationChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationChannelsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXROb3RpZmljYXRpb25DaGFubmVsc1Jlc3BvbnNlEkIKCGNoYW5uZWxzGAEgAygLMiYuZm'
    'luYW5jaWFscHJvZHVjdHMuTm90aWZpY2F0aW9uQ2hhbm5lbFIIY2hhbm5lbHM=');

@$core.Deprecated('Use updateNotificationChannelRequestDescriptor instead')
const UpdateNotificationChannelRequest$json = {
  '1': 'UpdateNotificationChannelRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'channel_name', '3': 2, '4': 1, '5': 9, '10': 'channelName'},
    {'1': 'enabled_events', '3': 3, '4': 3, '5': 14, '6': '.financialproducts.NotificationEventType', '10': 'enabledEvents'},
    {'1': 'preferences', '3': 4, '4': 1, '5': 11, '6': '.financialproducts.NotificationPreferences', '10': 'preferences'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.financialproducts.NotificationChannelStatus', '10': 'status'},
  ],
};

/// Descriptor for `UpdateNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotificationChannelRequestDescriptor = $convert.base64Decode(
    'CiBVcGRhdGVOb3RpZmljYXRpb25DaGFubmVsUmVxdWVzdBIdCgpjaGFubmVsX2lkGAEgASgJUg'
    'ljaGFubmVsSWQSIQoMY2hhbm5lbF9uYW1lGAIgASgJUgtjaGFubmVsTmFtZRJPCg5lbmFibGVk'
    'X2V2ZW50cxgDIAMoDjIoLmZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvbkV2ZW50VHlwZV'
    'INZW5hYmxlZEV2ZW50cxJMCgtwcmVmZXJlbmNlcxgEIAEoCzIqLmZpbmFuY2lhbHByb2R1Y3Rz'
    'Lk5vdGlmaWNhdGlvblByZWZlcmVuY2VzUgtwcmVmZXJlbmNlcxJECgZzdGF0dXMYBSABKA4yLC'
    '5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25DaGFubmVsU3RhdHVzUgZzdGF0dXM=');

@$core.Deprecated('Use updateNotificationChannelResponseDescriptor instead')
const UpdateNotificationChannelResponse$json = {
  '1': 'UpdateNotificationChannelResponse',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.financialproducts.NotificationChannel', '10': 'channel'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotificationChannelResponseDescriptor = $convert.base64Decode(
    'CiFVcGRhdGVOb3RpZmljYXRpb25DaGFubmVsUmVzcG9uc2USQAoHY2hhbm5lbBgBIAEoCzImLm'
    'ZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvbkNoYW5uZWxSB2NoYW5uZWwSGAoHbWVzc2Fn'
    'ZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use testNotificationChannelRequestDescriptor instead')
const TestNotificationChannelRequest$json = {
  '1': 'TestNotificationChannelRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `TestNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testNotificationChannelRequestDescriptor = $convert.base64Decode(
    'Ch5UZXN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlcXVlc3QSHQoKY2hhbm5lbF9pZBgBIAEoCVIJY2'
    'hhbm5lbElk');

@$core.Deprecated('Use testNotificationChannelResponseDescriptor instead')
const TestNotificationChannelResponse$json = {
  '1': 'TestNotificationChannelResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'platform_message_id', '3': 3, '4': 1, '5': 9, '10': 'platformMessageId'},
  ],
};

/// Descriptor for `TestNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testNotificationChannelResponseDescriptor = $convert.base64Decode(
    'Ch9UZXN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIuChNwbGF0Zm9ybV9tZXNzYWdlX2lkGAMg'
    'ASgJUhFwbGF0Zm9ybU1lc3NhZ2VJZA==');

@$core.Deprecated('Use getTelegramBotInfoRequestDescriptor instead')
const GetTelegramBotInfoRequest$json = {
  '1': 'GetTelegramBotInfoRequest',
};

/// Descriptor for `GetTelegramBotInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTelegramBotInfoRequestDescriptor = $convert.base64Decode(
    'ChlHZXRUZWxlZ3JhbUJvdEluZm9SZXF1ZXN0');

@$core.Deprecated('Use getTelegramBotInfoResponseDescriptor instead')
const GetTelegramBotInfoResponse$json = {
  '1': 'GetTelegramBotInfoResponse',
  '2': [
    {'1': 'bot_username', '3': 1, '4': 1, '5': 9, '10': 'botUsername'},
    {'1': 'bot_name', '3': 2, '4': 1, '5': 9, '10': 'botName'},
    {'1': 'bot_link', '3': 3, '4': 1, '5': 9, '10': 'botLink'},
    {'1': 'instructions', '3': 4, '4': 1, '5': 9, '10': 'instructions'},
  ],
};

/// Descriptor for `GetTelegramBotInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTelegramBotInfoResponseDescriptor = $convert.base64Decode(
    'ChpHZXRUZWxlZ3JhbUJvdEluZm9SZXNwb25zZRIhCgxib3RfdXNlcm5hbWUYASABKAlSC2JvdF'
    'VzZXJuYW1lEhkKCGJvdF9uYW1lGAIgASgJUgdib3ROYW1lEhkKCGJvdF9saW5rGAMgASgJUgdi'
    'b3RMaW5rEiIKDGluc3RydWN0aW9ucxgEIAEoCVIMaW5zdHJ1Y3Rpb25z');

@$core.Deprecated('Use verifyTelegramChannelRequestDescriptor instead')
const VerifyTelegramChannelRequest$json = {
  '1': 'VerifyTelegramChannelRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'chat_id', '3': 2, '4': 1, '5': 9, '10': 'chatId'},
    {'1': 'verification_code', '3': 3, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
};

/// Descriptor for `VerifyTelegramChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTelegramChannelRequestDescriptor = $convert.base64Decode(
    'ChxWZXJpZnlUZWxlZ3JhbUNoYW5uZWxSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3'
    'Jvd2RmdW5kSWQSFwoHY2hhdF9pZBgCIAEoCVIGY2hhdElkEisKEXZlcmlmaWNhdGlvbl9jb2Rl'
    'GAMgASgJUhB2ZXJpZmljYXRpb25Db2Rl');

@$core.Deprecated('Use verifyTelegramChannelResponseDescriptor instead')
const VerifyTelegramChannelResponse$json = {
  '1': 'VerifyTelegramChannelResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'channel', '3': 2, '4': 1, '5': 11, '6': '.financialproducts.NotificationChannel', '10': 'channel'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `VerifyTelegramChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTelegramChannelResponseDescriptor = $convert.base64Decode(
    'Ch1WZXJpZnlUZWxlZ3JhbUNoYW5uZWxSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEkAKB2NoYW5uZWwYAiABKAsyJi5maW5hbmNpYWxwcm9kdWN0cy5Ob3RpZmljYXRpb25DaGFu'
    'bmVsUgdjaGFubmVsEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getNotificationHistoryRequestDescriptor instead')
const GetNotificationHistoryRequest$json = {
  '1': 'GetNotificationHistoryRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetNotificationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationHistoryRequestDescriptor = $convert.base64Decode(
    'Ch1HZXROb3RpZmljYXRpb25IaXN0b3J5UmVxdWVzdBIhCgxjcm93ZGZ1bmRfaWQYASABKAlSC2'
    'Nyb3dkZnVuZElkEh0KCmNoYW5uZWxfaWQYAiABKAlSCWNoYW5uZWxJZBISCgRwYWdlGAMgASgF'
    'UgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use getNotificationHistoryResponseDescriptor instead')
const GetNotificationHistoryResponse$json = {
  '1': 'GetNotificationHistoryResponse',
  '2': [
    {'1': 'deliveries', '3': 1, '4': 3, '5': 11, '6': '.financialproducts.NotificationDelivery', '10': 'deliveries'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetNotificationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationHistoryResponseDescriptor = $convert.base64Decode(
    'Ch5HZXROb3RpZmljYXRpb25IaXN0b3J5UmVzcG9uc2USRwoKZGVsaXZlcmllcxgBIAMoCzInLm'
    'ZpbmFuY2lhbHByb2R1Y3RzLk5vdGlmaWNhdGlvbkRlbGl2ZXJ5UgpkZWxpdmVyaWVzEhQKBXRv'
    'dGFsGAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBV'
    'IIcGFnZVNpemUSGQoIaGFzX21vcmUYBSABKAhSB2hhc01vcmU=');

