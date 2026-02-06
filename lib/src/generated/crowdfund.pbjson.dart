//
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use crowdfundStatusDescriptor instead')
const CrowdfundStatus$json = {
  '1': 'CrowdfundStatus',
  '2': [
    {'1': 'CROWDFUND_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'CROWDFUND_STATUS_ACTIVE', '2': 1},
    {'1': 'CROWDFUND_STATUS_PAUSED', '2': 2},
    {'1': 'CROWDFUND_STATUS_COMPLETED', '2': 3},
    {'1': 'CROWDFUND_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `CrowdfundStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List crowdfundStatusDescriptor = $convert.base64Decode(
    'Cg9Dcm93ZGZ1bmRTdGF0dXMSIAocQ1JPV0RGVU5EX1NUQVRVU19VTlNQRUNJRklFRBAAEhsKF0'
    'NST1dERlVORF9TVEFUVVNfQUNUSVZFEAESGwoXQ1JPV0RGVU5EX1NUQVRVU19QQVVTRUQQAhIe'
    'ChpDUk9XREZVTkRfU1RBVFVTX0NPTVBMRVRFRBADEh4KGkNST1dERlVORF9TVEFUVVNfQ0FOQ0'
    'VMTEVEEAQ=');

@$core.Deprecated('Use crowdfundVisibilityDescriptor instead')
const CrowdfundVisibility$json = {
  '1': 'CrowdfundVisibility',
  '2': [
    {'1': 'CROWDFUND_VISIBILITY_UNSPECIFIED', '2': 0},
    {'1': 'CROWDFUND_VISIBILITY_PUBLIC', '2': 1},
    {'1': 'CROWDFUND_VISIBILITY_PRIVATE', '2': 2},
    {'1': 'CROWDFUND_VISIBILITY_UNLISTED', '2': 3},
  ],
};

/// Descriptor for `CrowdfundVisibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List crowdfundVisibilityDescriptor = $convert.base64Decode(
    'ChNDcm93ZGZ1bmRWaXNpYmlsaXR5EiQKIENST1dERlVORF9WSVNJQklMSVRZX1VOU1BFQ0lGSU'
    'VEEAASHwobQ1JPV0RGVU5EX1ZJU0lCSUxJVFlfUFVCTElDEAESIAocQ1JPV0RGVU5EX1ZJU0lC'
    'SUxJVFlfUFJJVkFURRACEiEKHUNST1dERlVORF9WSVNJQklMSVRZX1VOTElTVEVEEAM=');

@$core.Deprecated('Use donationStatusDescriptor instead')
const DonationStatus$json = {
  '1': 'DonationStatus',
  '2': [
    {'1': 'DONATION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'DONATION_STATUS_PENDING', '2': 1},
    {'1': 'DONATION_STATUS_PROCESSING', '2': 2},
    {'1': 'DONATION_STATUS_COMPLETED', '2': 3},
    {'1': 'DONATION_STATUS_FAILED', '2': 4},
    {'1': 'DONATION_STATUS_REFUNDED', '2': 5},
  ],
};

/// Descriptor for `DonationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List donationStatusDescriptor = $convert.base64Decode(
    'Cg5Eb25hdGlvblN0YXR1cxIfChtET05BVElPTl9TVEFUVVNfVU5TUEVDSUZJRUQQABIbChdET0'
    '5BVElPTl9TVEFUVVNfUEVORElORxABEh4KGkRPTkFUSU9OX1NUQVRVU19QUk9DRVNTSU5HEAIS'
    'HQoZRE9OQVRJT05fU1RBVFVTX0NPTVBMRVRFRBADEhoKFkRPTkFUSU9OX1NUQVRVU19GQUlMRU'
    'QQBBIcChhET05BVElPTl9TVEFUVVNfUkVGVU5ERUQQBQ==');

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

@$core.Deprecated('Use crowdfundCreatorMessageDescriptor instead')
const CrowdfundCreatorMessage$json = {
  '1': 'CrowdfundCreatorMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'profile_picture', '3': 5, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'verified', '3': 6, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'verified_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
    {'1': 'facial_recognition_enabled', '3': 8, '4': 1, '5': 8, '10': 'facialRecognitionEnabled'},
  ],
};

/// Descriptor for `CrowdfundCreatorMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundCreatorMessageDescriptor = $convert.base64Decode(
    'ChdDcm93ZGZ1bmRDcmVhdG9yTWVzc2FnZRIXCgd1c2VyX2lkGAEgASgEUgZ1c2VySWQSGgoIdX'
    'Nlcm5hbWUYAiABKAlSCHVzZXJuYW1lEh0KCmZpcnN0X25hbWUYAyABKAlSCWZpcnN0TmFtZRIb'
    'CglsYXN0X25hbWUYBCABKAlSCGxhc3ROYW1lEicKD3Byb2ZpbGVfcGljdHVyZRgFIAEoCVIOcH'
    'JvZmlsZVBpY3R1cmUSGgoIdmVyaWZpZWQYBiABKAhSCHZlcmlmaWVkEjsKC3ZlcmlmaWVkX2F0'
    'GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdmVyaWZpZWRBdBI8ChpmYWNpYW'
    'xfcmVjb2duaXRpb25fZW5hYmxlZBgIIAEoCFIYZmFjaWFsUmVjb2duaXRpb25FbmFibGVk');

@$core.Deprecated('Use crowdfundMessageDescriptor instead')
const CrowdfundMessage$json = {
  '1': 'CrowdfundMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'creator_user_id', '3': 2, '4': 1, '5': 4, '10': 'creatorUserId'},
    {'1': 'creator', '3': 3, '4': 1, '5': 11, '6': '.pb.CrowdfundCreatorMessage', '10': 'creator'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'story', '3': 6, '4': 1, '5': 9, '10': 'story'},
    {'1': 'crowdfund_code', '3': 7, '4': 1, '5': 9, '10': 'crowdfundCode'},
    {'1': 'target_amount', '3': 8, '4': 1, '5': 4, '10': 'targetAmount'},
    {'1': 'current_amount', '3': 9, '4': 1, '5': 4, '10': 'currentAmount'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'deadline', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    {'1': 'category', '3': 12, '4': 1, '5': 9, '10': 'category'},
    {'1': 'status', '3': 13, '4': 1, '5': 14, '6': '.pb.CrowdfundStatus', '10': 'status'},
    {'1': 'image_url', '3': 14, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'visibility', '3': 15, '4': 1, '5': 14, '6': '.pb.CrowdfundVisibility', '10': 'visibility'},
    {'1': 'metadata', '3': 16, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'donor_count', '3': 17, '4': 1, '5': 5, '10': 'donorCount'},
    {'1': 'progress_percentage', '3': 18, '4': 1, '5': 1, '10': 'progressPercentage'},
    {'1': 'created_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'recent_donations', '3': 21, '4': 3, '5': 11, '6': '.pb.CrowdfundDonationMessage', '10': 'recentDonations'},
  ],
};

/// Descriptor for `CrowdfundMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundMessageDescriptor = $convert.base64Decode(
    'ChBDcm93ZGZ1bmRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBImCg9jcmVhdG9yX3VzZXJfaWQYAi'
    'ABKARSDWNyZWF0b3JVc2VySWQSNQoHY3JlYXRvchgDIAEoCzIbLnBiLkNyb3dkZnVuZENyZWF0'
    'b3JNZXNzYWdlUgdjcmVhdG9yEhQKBXRpdGxlGAQgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbh'
    'gFIAEoCVILZGVzY3JpcHRpb24SFAoFc3RvcnkYBiABKAlSBXN0b3J5EiUKDmNyb3dkZnVuZF9j'
    'b2RlGAcgASgJUg1jcm93ZGZ1bmRDb2RlEiMKDXRhcmdldF9hbW91bnQYCCABKARSDHRhcmdldE'
    'Ftb3VudBIlCg5jdXJyZW50X2Ftb3VudBgJIAEoBFINY3VycmVudEFtb3VudBIaCghjdXJyZW5j'
    'eRgKIAEoCVIIY3VycmVuY3kSNgoIZGVhZGxpbmUYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVG'
    'ltZXN0YW1wUghkZWFkbGluZRIaCghjYXRlZ29yeRgMIAEoCVIIY2F0ZWdvcnkSKwoGc3RhdHVz'
    'GA0gASgOMhMucGIuQ3Jvd2RmdW5kU3RhdHVzUgZzdGF0dXMSGwoJaW1hZ2VfdXJsGA4gASgJUg'
    'hpbWFnZVVybBI3Cgp2aXNpYmlsaXR5GA8gASgOMhcucGIuQ3Jvd2RmdW5kVmlzaWJpbGl0eVIK'
    'dmlzaWJpbGl0eRIaCghtZXRhZGF0YRgQIAEoCVIIbWV0YWRhdGESHwoLZG9ub3JfY291bnQYES'
    'ABKAVSCmRvbm9yQ291bnQSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgSIAEoAVIScHJvZ3Jlc3NQ'
    'ZXJjZW50YWdlEjkKCmNyZWF0ZWRfYXQYEyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgUIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1l'
    'c3RhbXBSCXVwZGF0ZWRBdBJHChByZWNlbnRfZG9uYXRpb25zGBUgAygLMhwucGIuQ3Jvd2RmdW'
    '5kRG9uYXRpb25NZXNzYWdlUg9yZWNlbnREb25hdGlvbnM=');

@$core.Deprecated('Use crowdfundDonorMessageDescriptor instead')
const CrowdfundDonorMessage$json = {
  '1': 'CrowdfundDonorMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'profile_picture', '3': 3, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'is_anonymous', '3': 4, '4': 1, '5': 8, '10': 'isAnonymous'},
    {'1': 'is_creator', '3': 5, '4': 1, '5': 8, '10': 'isCreator'},
  ],
};

/// Descriptor for `CrowdfundDonorMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundDonorMessageDescriptor = $convert.base64Decode(
    'ChVDcm93ZGZ1bmREb25vck1lc3NhZ2USFwoHdXNlcl9pZBgBIAEoBFIGdXNlcklkEiEKDGRpc3'
    'BsYXlfbmFtZRgCIAEoCVILZGlzcGxheU5hbWUSJwoPcHJvZmlsZV9waWN0dXJlGAMgASgJUg5w'
    'cm9maWxlUGljdHVyZRIhCgxpc19hbm9ueW1vdXMYBCABKAhSC2lzQW5vbnltb3VzEh0KCmlzX2'
    'NyZWF0b3IYBSABKAhSCWlzQ3JlYXRvcg==');

@$core.Deprecated('Use crowdfundDonationMessageDescriptor instead')
const CrowdfundDonationMessage$json = {
  '1': 'CrowdfundDonationMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'crowdfund_id', '3': 2, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'donor_user_id', '3': 3, '4': 1, '5': 4, '10': 'donorUserId'},
    {'1': 'donor', '3': 4, '4': 1, '5': 11, '6': '.pb.CrowdfundDonorMessage', '10': 'donor'},
    {'1': 'amount', '3': 5, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'donation_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'donationDate'},
    {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.DonationStatus', '10': 'status'},
    {'1': 'transaction_id', '3': 9, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'receipt_id', '3': 10, '4': 1, '5': 9, '10': 'receiptId'},
    {'1': 'message', '3': 11, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_anonymous', '3': 12, '4': 1, '5': 8, '10': 'isAnonymous'},
    {'1': 'payment_method', '3': 13, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'metadata', '3': 14, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CrowdfundDonationMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundDonationMessageDescriptor = $convert.base64Decode(
    'ChhDcm93ZGZ1bmREb25hdGlvbk1lc3NhZ2USDgoCaWQYASABKAlSAmlkEiEKDGNyb3dkZnVuZF'
    '9pZBgCIAEoCVILY3Jvd2RmdW5kSWQSIgoNZG9ub3JfdXNlcl9pZBgDIAEoBFILZG9ub3JVc2Vy'
    'SWQSLwoFZG9ub3IYBCABKAsyGS5wYi5Dcm93ZGZ1bmREb25vck1lc3NhZ2VSBWRvbm9yEhYKBm'
    'Ftb3VudBgFIAEoBFIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRI/Cg1kb25h'
    'dGlvbl9kYXRlGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMZG9uYXRpb25EYX'
    'RlEioKBnN0YXR1cxgIIAEoDjISLnBiLkRvbmF0aW9uU3RhdHVzUgZzdGF0dXMSJQoOdHJhbnNh'
    'Y3Rpb25faWQYCSABKAlSDXRyYW5zYWN0aW9uSWQSHQoKcmVjZWlwdF9pZBgKIAEoCVIJcmVjZW'
    'lwdElkEhgKB21lc3NhZ2UYCyABKAlSB21lc3NhZ2USIQoMaXNfYW5vbnltb3VzGAwgASgIUgtp'
    'c0Fub255bW91cxIlCg5wYXltZW50X21ldGhvZBgNIAEoCVINcGF5bWVudE1ldGhvZBIaCghtZX'
    'RhZGF0YRgOIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use crowdfundReceiptMessageDescriptor instead')
const CrowdfundReceiptMessage$json = {
  '1': 'CrowdfundReceiptMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'donation_id', '3': 2, '4': 1, '5': 9, '10': 'donationId'},
    {'1': 'crowdfund_id', '3': 3, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'crowdfund_title', '3': 4, '4': 1, '5': 9, '10': 'crowdfundTitle'},
    {'1': 'donor_user_id', '3': 5, '4': 1, '5': 4, '10': 'donorUserId'},
    {'1': 'donor_name', '3': 6, '4': 1, '5': 9, '10': 'donorName'},
    {'1': 'amount', '3': 7, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'donation_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'donationDate'},
    {'1': 'generated_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
    {'1': 'receipt_number', '3': 11, '4': 1, '5': 9, '10': 'receiptNumber'},
    {'1': 'receipt_data', '3': 12, '4': 1, '5': 9, '10': 'receiptData'},
  ],
};

/// Descriptor for `CrowdfundReceiptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundReceiptMessageDescriptor = $convert.base64Decode(
    'ChdDcm93ZGZ1bmRSZWNlaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHwoLZG9uYXRpb25faW'
    'QYAiABKAlSCmRvbmF0aW9uSWQSIQoMY3Jvd2RmdW5kX2lkGAMgASgJUgtjcm93ZGZ1bmRJZBIn'
    'Cg9jcm93ZGZ1bmRfdGl0bGUYBCABKAlSDmNyb3dkZnVuZFRpdGxlEiIKDWRvbm9yX3VzZXJfaW'
    'QYBSABKARSC2Rvbm9yVXNlcklkEh0KCmRvbm9yX25hbWUYBiABKAlSCWRvbm9yTmFtZRIWCgZh'
    'bW91bnQYByABKARSBmFtb3VudBIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3kSPwoNZG9uYX'
    'Rpb25fZGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGRvbmF0aW9uRGF0'
    'ZRI9CgxnZW5lcmF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtnZW'
    '5lcmF0ZWRBdBIlCg5yZWNlaXB0X251bWJlchgLIAEoCVINcmVjZWlwdE51bWJlchIhCgxyZWNl'
    'aXB0X2RhdGEYDCABKAlSC3JlY2VpcHREYXRh');

@$core.Deprecated('Use createCrowdfundRequestDescriptor instead')
const CreateCrowdfundRequest$json = {
  '1': 'CreateCrowdfundRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'story', '3': 3, '4': 1, '5': 9, '10': 'story'},
    {'1': 'target_amount', '3': 4, '4': 1, '5': 4, '10': 'targetAmount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'deadline', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    {'1': 'category', '3': 7, '4': 1, '5': 9, '10': 'category'},
    {'1': 'image_url', '3': 8, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'visibility', '3': 9, '4': 1, '5': 14, '6': '.pb.CrowdfundVisibility', '10': 'visibility'},
    {'1': 'metadata', '3': 10, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CreateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVDcm93ZGZ1bmRSZXF1ZXN0EhQKBXRpdGxlGAEgASgJUgV0aXRsZRIgCgtkZXNjcm'
    'lwdGlvbhgCIAEoCVILZGVzY3JpcHRpb24SFAoFc3RvcnkYAyABKAlSBXN0b3J5EiMKDXRhcmdl'
    'dF9hbW91bnQYBCABKARSDHRhcmdldEFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3'
    'kSNgoIZGVhZGxpbmUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGlu'
    'ZRIaCghjYXRlZ29yeRgHIAEoCVIIY2F0ZWdvcnkSGwoJaW1hZ2VfdXJsGAggASgJUghpbWFnZV'
    'VybBI3Cgp2aXNpYmlsaXR5GAkgASgOMhcucGIuQ3Jvd2RmdW5kVmlzaWJpbGl0eVIKdmlzaWJp'
    'bGl0eRIaCghtZXRhZGF0YRgKIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use createCrowdfundResponseDescriptor instead')
const CreateCrowdfundResponse$json = {
  '1': 'CreateCrowdfundResponse',
  '2': [
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfund'},
  ],
};

/// Descriptor for `CreateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVDcm93ZGZ1bmRSZXNwb25zZRIyCgljcm93ZGZ1bmQYASABKAsyFC5wYi5Dcm93ZG'
    'Z1bmRNZXNzYWdlUgljcm93ZGZ1bmQ=');

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
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfund'},
  ],
};

/// Descriptor for `GetCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundResponseDescriptor = $convert.base64Decode(
    'ChRHZXRDcm93ZGZ1bmRSZXNwb25zZRIyCgljcm93ZGZ1bmQYASABKAsyFC5wYi5Dcm93ZGZ1bm'
    'RNZXNzYWdlUgljcm93ZGZ1bmQ=');

@$core.Deprecated('Use listCrowdfundsRequestDescriptor instead')
const ListCrowdfundsRequest$json = {
  '1': 'ListCrowdfundsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'my_crowdfunds_only', '3': 5, '4': 1, '5': 8, '10': 'myCrowdfundsOnly'},
  ],
};

/// Descriptor for `ListCrowdfundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCrowdfundsRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0Q3Jvd2RmdW5kc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3Npem'
    'UYAiABKAVSCHBhZ2VTaXplEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEhoKCGNhdGVnb3J5GAQg'
    'ASgJUghjYXRlZ29yeRIsChJteV9jcm93ZGZ1bmRzX29ubHkYBSABKAhSEG15Q3Jvd2RmdW5kc0'
    '9ubHk=');

@$core.Deprecated('Use listCrowdfundsResponseDescriptor instead')
const ListCrowdfundsResponse$json = {
  '1': 'ListCrowdfundsResponse',
  '2': [
    {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfunds'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CrowdfundPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCrowdfundsResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0Q3Jvd2RmdW5kc1Jlc3BvbnNlEjQKCmNyb3dkZnVuZHMYASADKAsyFC5wYi5Dcm93ZG'
    'Z1bmRNZXNzYWdlUgpjcm93ZGZ1bmRzEjsKCnBhZ2luYXRpb24YAiABKAsyGy5wYi5Dcm93ZGZ1'
    'bmRQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');

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
    {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfunds'},
  ],
};

/// Descriptor for `SearchCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCrowdfundsResponseDescriptor = $convert.base64Decode(
    'ChhTZWFyY2hDcm93ZGZ1bmRzUmVzcG9uc2USNAoKY3Jvd2RmdW5kcxgBIAMoCzIULnBiLkNyb3'
    'dkZnVuZE1lc3NhZ2VSCmNyb3dkZnVuZHM=');

@$core.Deprecated('Use updateCrowdfundRequestDescriptor instead')
const UpdateCrowdfundRequest$json = {
  '1': 'UpdateCrowdfundRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'story', '3': 4, '4': 1, '5': 9, '10': 'story'},
    {'1': 'deadline', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.pb.CrowdfundStatus', '10': 'status'},
    {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `UpdateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW'
    '5kSWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlw'
    'dGlvbhIUCgVzdG9yeRgEIAEoCVIFc3RvcnkSNgoIZGVhZGxpbmUYBSABKAsyGi5nb29nbGUucH'
    'JvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRIrCgZzdGF0dXMYBiABKA4yEy5wYi5Dcm93ZGZ1'
    'bmRTdGF0dXNSBnN0YXR1cxIbCglpbWFnZV91cmwYByABKAlSCGltYWdlVXJsEhoKCG1ldGFkYX'
    'RhGAggASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use updateCrowdfundResponseDescriptor instead')
const UpdateCrowdfundResponse$json = {
  '1': 'UpdateCrowdfundResponse',
  '2': [
    {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfund'},
  ],
};

/// Descriptor for `UpdateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCrowdfundResponseDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVDcm93ZGZ1bmRSZXNwb25zZRIyCgljcm93ZGZ1bmQYASABKAsyFC5wYi5Dcm93ZG'
    'Z1bmRNZXNzYWdlUgljcm93ZGZ1bmQ=');

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

@$core.Deprecated('Use makeDonationRequestDescriptor instead')
const MakeDonationRequest$json = {
  '1': 'MakeDonationRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_anonymous', '3': 4, '4': 1, '5': 8, '10': 'isAnonymous'},
    {'1': 'source_account_id', '3': 5, '4': 1, '5': 4, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `MakeDonationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeDonationRequestDescriptor = $convert.base64Decode(
    'ChNNYWtlRG9uYXRpb25SZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSW'
    'QSFgoGYW1vdW50GAIgASgEUgZhbW91bnQSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRIhCgxp'
    'c19hbm9ueW1vdXMYBCABKAhSC2lzQW5vbnltb3VzEioKEXNvdXJjZV9hY2NvdW50X2lkGAUgAS'
    'gEUg9zb3VyY2VBY2NvdW50SWQ=');

@$core.Deprecated('Use makeDonationResponseDescriptor instead')
const MakeDonationResponse$json = {
  '1': 'MakeDonationResponse',
  '2': [
    {'1': 'donation', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundDonationMessage', '10': 'donation'},
  ],
};

/// Descriptor for `MakeDonationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeDonationResponseDescriptor = $convert.base64Decode(
    'ChRNYWtlRG9uYXRpb25SZXNwb25zZRI4Cghkb25hdGlvbhgBIAEoCzIcLnBiLkNyb3dkZnVuZE'
    'RvbmF0aW9uTWVzc2FnZVIIZG9uYXRpb24=');

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
    {'1': 'donations', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundDonationMessage', '10': 'donations'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.DonationPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetCrowdfundDonationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundDonationsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRDcm93ZGZ1bmREb25hdGlvbnNSZXNwb25zZRI6Cglkb25hdGlvbnMYASADKAsyHC5wYi'
    '5Dcm93ZGZ1bmREb25hdGlvbk1lc3NhZ2VSCWRvbmF0aW9ucxI6CgpwYWdpbmF0aW9uGAIgASgL'
    'MhoucGIuRG9uYXRpb25QYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');

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
    {'1': 'donations', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundDonationMessage', '10': 'donations'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.DonationPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserDonationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDonationsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VyRG9uYXRpb25zUmVzcG9uc2USOgoJZG9uYXRpb25zGAEgAygLMhwucGIuQ3Jvd2'
    'RmdW5kRG9uYXRpb25NZXNzYWdlUglkb25hdGlvbnMSOgoKcGFnaW5hdGlvbhgCIAEoCzIaLnBi'
    'LkRvbmF0aW9uUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');

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
    {'1': 'receipt', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundReceiptMessage', '10': 'receipt'},
  ],
};

/// Descriptor for `GenerateDonationReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateDonationReceiptResponseDescriptor = $convert.base64Decode(
    'Ch9HZW5lcmF0ZURvbmF0aW9uUmVjZWlwdFJlc3BvbnNlEjUKB3JlY2VpcHQYASABKAsyGy5wYi'
    '5Dcm93ZGZ1bmRSZWNlaXB0TWVzc2FnZVIHcmVjZWlwdA==');

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
    {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundReceiptMessage', '10': 'receipts'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CrowdfundReceiptPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserCrowdfundReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCrowdfundReceiptsResponseDescriptor = $convert.base64Decode(
    'CiBHZXRVc2VyQ3Jvd2RmdW5kUmVjZWlwdHNSZXNwb25zZRI3CghyZWNlaXB0cxgBIAMoCzIbLn'
    'BiLkNyb3dkZnVuZFJlY2VpcHRNZXNzYWdlUghyZWNlaXB0cxJCCgpwYWdpbmF0aW9uGAIgASgL'
    'MiIucGIuQ3Jvd2RmdW5kUmVjZWlwdFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getCrowdfundStatisticsRequestDescriptor instead')
const GetCrowdfundStatisticsRequest$json = {
  '1': 'GetCrowdfundStatisticsRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `GetCrowdfundStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundStatisticsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRDcm93ZGZ1bmRTdGF0aXN0aWNzUmVxdWVzdBIhCgxjcm93ZGZ1bmRfaWQYASABKAlSC2'
    'Nyb3dkZnVuZElk');

@$core.Deprecated('Use getCrowdfundStatisticsResponseDescriptor instead')
const GetCrowdfundStatisticsResponse$json = {
  '1': 'GetCrowdfundStatisticsResponse',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'total_raised', '3': 2, '4': 1, '5': 4, '10': 'totalRaised'},
    {'1': 'target_amount', '3': 3, '4': 1, '5': 4, '10': 'targetAmount'},
    {'1': 'progress_percentage', '3': 4, '4': 1, '5': 1, '10': 'progressPercentage'},
    {'1': 'donor_count', '3': 5, '4': 1, '5': 5, '10': 'donorCount'},
    {'1': 'average_donation', '3': 6, '4': 1, '5': 4, '10': 'averageDonation'},
    {'1': 'largest_donation', '3': 7, '4': 1, '5': 4, '10': 'largestDonation'},
    {'1': 'days_remaining', '3': 8, '4': 1, '5': 5, '10': 'daysRemaining'},
    {'1': 'is_completed', '3': 9, '4': 1, '5': 8, '10': 'isCompleted'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'unique_donors', '3': 11, '4': 1, '5': 5, '10': 'uniqueDonors'},
    {'1': 'smallest_donation', '3': 12, '4': 1, '5': 4, '10': 'smallestDonation'},
    {'1': 'top_contributors', '3': 13, '4': 3, '5': 11, '6': '.pb.ContributorLeaderboardEntry', '10': 'topContributors'},
    {'1': 'daily_progress', '3': 14, '4': 3, '5': 11, '6': '.pb.DailyProgressEntry', '10': 'dailyProgress'},
    {'1': 'funding_velocity', '3': 15, '4': 1, '5': 1, '10': 'fundingVelocity'},
    {'1': 'projected_completion_date', '3': 16, '4': 1, '5': 9, '10': 'projectedCompletionDate'},
  ],
};

/// Descriptor for `GetCrowdfundStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundStatisticsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRDcm93ZGZ1bmRTdGF0aXN0aWNzUmVzcG9uc2USIQoMY3Jvd2RmdW5kX2lkGAEgASgJUg'
    'tjcm93ZGZ1bmRJZBIhCgx0b3RhbF9yYWlzZWQYAiABKARSC3RvdGFsUmFpc2VkEiMKDXRhcmdl'
    'dF9hbW91bnQYAyABKARSDHRhcmdldEFtb3VudBIvChNwcm9ncmVzc19wZXJjZW50YWdlGAQgAS'
    'gBUhJwcm9ncmVzc1BlcmNlbnRhZ2USHwoLZG9ub3JfY291bnQYBSABKAVSCmRvbm9yQ291bnQS'
    'KQoQYXZlcmFnZV9kb25hdGlvbhgGIAEoBFIPYXZlcmFnZURvbmF0aW9uEikKEGxhcmdlc3RfZG'
    '9uYXRpb24YByABKARSD2xhcmdlc3REb25hdGlvbhIlCg5kYXlzX3JlbWFpbmluZxgIIAEoBVIN'
    'ZGF5c1JlbWFpbmluZxIhCgxpc19jb21wbGV0ZWQYCSABKAhSC2lzQ29tcGxldGVkEjkKCmNyZW'
    'F0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSIwoN'
    'dW5pcXVlX2Rvbm9ycxgLIAEoBVIMdW5pcXVlRG9ub3JzEisKEXNtYWxsZXN0X2RvbmF0aW9uGA'
    'wgASgEUhBzbWFsbGVzdERvbmF0aW9uEkoKEHRvcF9jb250cmlidXRvcnMYDSADKAsyHy5wYi5D'
    'b250cmlidXRvckxlYWRlcmJvYXJkRW50cnlSD3RvcENvbnRyaWJ1dG9ycxI9Cg5kYWlseV9wcm'
    '9ncmVzcxgOIAMoCzIWLnBiLkRhaWx5UHJvZ3Jlc3NFbnRyeVINZGFpbHlQcm9ncmVzcxIpChBm'
    'dW5kaW5nX3ZlbG9jaXR5GA8gASgBUg9mdW5kaW5nVmVsb2NpdHkSOgoZcHJvamVjdGVkX2NvbX'
    'BsZXRpb25fZGF0ZRgQIAEoCVIXcHJvamVjdGVkQ29tcGxldGlvbkRhdGU=');

@$core.Deprecated('Use contributorLeaderboardEntryDescriptor instead')
const ContributorLeaderboardEntry$json = {
  '1': 'ContributorLeaderboardEntry',
  '2': [
    {'1': 'rank', '3': 1, '4': 1, '5': 5, '10': 'rank'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'total_amount', '3': 3, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'contribution_count', '3': 4, '4': 1, '5': 5, '10': 'contributionCount'},
    {'1': 'is_anonymous', '3': 5, '4': 1, '5': 8, '10': 'isAnonymous'},
  ],
};

/// Descriptor for `ContributorLeaderboardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributorLeaderboardEntryDescriptor = $convert.base64Decode(
    'ChtDb250cmlidXRvckxlYWRlcmJvYXJkRW50cnkSEgoEcmFuaxgBIAEoBVIEcmFuaxIhCgxkaX'
    'NwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEiEKDHRvdGFsX2Ftb3VudBgDIAEoAVILdG90'
    'YWxBbW91bnQSLQoSY29udHJpYnV0aW9uX2NvdW50GAQgASgFUhFjb250cmlidXRpb25Db3VudB'
    'IhCgxpc19hbm9ueW1vdXMYBSABKAhSC2lzQW5vbnltb3Vz');

@$core.Deprecated('Use dailyProgressEntryDescriptor instead')
const DailyProgressEntry$json = {
  '1': 'DailyProgressEntry',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'donation_count', '3': 3, '4': 1, '5': 5, '10': 'donationCount'},
    {'1': 'cumulative_amount', '3': 4, '4': 1, '5': 1, '10': 'cumulativeAmount'},
  ],
};

/// Descriptor for `DailyProgressEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyProgressEntryDescriptor = $convert.base64Decode(
    'ChJEYWlseVByb2dyZXNzRW50cnkSEgoEZGF0ZRgBIAEoCVIEZGF0ZRIWCgZhbW91bnQYAiABKA'
    'FSBmFtb3VudBIlCg5kb25hdGlvbl9jb3VudBgDIAEoBVINZG9uYXRpb25Db3VudBIrChFjdW11'
    'bGF0aXZlX2Ftb3VudBgEIAEoAVIQY3VtdWxhdGl2ZUFtb3VudA==');

@$core.Deprecated('Use withdrawFromCrowdfundRequestDescriptor instead')
const WithdrawFromCrowdfundRequest$json = {
  '1': 'WithdrawFromCrowdfundRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'destination_account_type', '3': 5, '4': 1, '5': 9, '10': 'destinationAccountType'},
  ],
};

/// Descriptor for `WithdrawFromCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCrowdfundRequestDescriptor = $convert.base64Decode(
    'ChxXaXRoZHJhd0Zyb21Dcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3'
    'Jvd2RmdW5kSWQSFgoGYW1vdW50GAIgASgEUgZhbW91bnQSJwoPdHJhbnNhY3Rpb25fcGluGAMg'
    'ASgJUg50cmFuc2FjdGlvblBpbhI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGAQgASgJUhRkZX'
    'N0aW5hdGlvbkFjY291bnRJZBI4ChhkZXN0aW5hdGlvbl9hY2NvdW50X3R5cGUYBSABKAlSFmRl'
    'c3RpbmF0aW9uQWNjb3VudFR5cGU=');

@$core.Deprecated('Use withdrawFromCrowdfundResponseDescriptor instead')
const WithdrawFromCrowdfundResponse$json = {
  '1': 'WithdrawFromCrowdfundResponse',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'amount_withdrawn', '3': 2, '4': 1, '5': 4, '10': 'amountWithdrawn'},
    {'1': 'remaining_balance', '3': 3, '4': 1, '5': 4, '10': 'remainingBalance'},
    {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
    {'1': 'destination_new_balance', '3': 5, '4': 1, '5': 4, '10': 'destinationNewBalance'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawFromCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawFromCrowdfundResponseDescriptor = $convert.base64Decode(
    'Ch1XaXRoZHJhd0Zyb21Dcm93ZGZ1bmRSZXNwb25zZRIhCgxjcm93ZGZ1bmRfaWQYASABKAlSC2'
    'Nyb3dkZnVuZElkEikKEGFtb3VudF93aXRoZHJhd24YAiABKARSD2Ftb3VudFdpdGhkcmF3bhIr'
    'ChFyZW1haW5pbmdfYmFsYW5jZRgDIAEoBFIQcmVtYWluaW5nQmFsYW5jZRI0ChZkZXN0aW5hdG'
    'lvbl9hY2NvdW50X2lkGAQgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZBI2ChdkZXN0aW5hdGlv'
    'bl9uZXdfYmFsYW5jZRgFIAEoBFIVZGVzdGluYXRpb25OZXdCYWxhbmNlEhgKB21lc3NhZ2UYBi'
    'ABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getMyCrowdfundsRequestDescriptor instead')
const GetMyCrowdfundsRequest$json = {
  '1': 'GetMyCrowdfundsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetMyCrowdfundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCrowdfundsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRNeUNyb3dkZnVuZHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGwoJcGFnZV9zaX'
    'plGAIgASgFUghwYWdlU2l6ZRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use getMyCrowdfundsResponseDescriptor instead')
const GetMyCrowdfundsResponse$json = {
  '1': 'GetMyCrowdfundsResponse',
  '2': [
    {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfunds'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CrowdfundPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetMyCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyCrowdfundsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRNeUNyb3dkZnVuZHNSZXNwb25zZRI0Cgpjcm93ZGZ1bmRzGAEgAygLMhQucGIuQ3Jvd2'
    'RmdW5kTWVzc2FnZVIKY3Jvd2RmdW5kcxI7CgpwYWdpbmF0aW9uGAIgASgLMhsucGIuQ3Jvd2Rm'
    'dW5kUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');

@$core.Deprecated('Use getCampaignWalletBalanceRequestDescriptor instead')
const GetCampaignWalletBalanceRequest$json = {
  '1': 'GetCampaignWalletBalanceRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `GetCampaignWalletBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCampaignWalletBalanceRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRDYW1wYWlnbldhbGxldEJhbGFuY2VSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCV'
    'ILY3Jvd2RmdW5kSWQ=');

@$core.Deprecated('Use getCampaignWalletBalanceResponseDescriptor instead')
const GetCampaignWalletBalanceResponse$json = {
  '1': 'GetCampaignWalletBalanceResponse',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'campaign_wallet_id', '3': 2, '4': 1, '5': 9, '10': 'campaignWalletId'},
    {'1': 'balance', '3': 3, '4': 1, '5': 4, '10': 'balance'},
    {'1': 'available_balance', '3': 4, '4': 1, '5': 4, '10': 'availableBalance'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetCampaignWalletBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCampaignWalletBalanceResponseDescriptor = $convert.base64Decode(
    'CiBHZXRDYW1wYWlnbldhbGxldEJhbGFuY2VSZXNwb25zZRIhCgxjcm93ZGZ1bmRfaWQYASABKA'
    'lSC2Nyb3dkZnVuZElkEiwKEmNhbXBhaWduX3dhbGxldF9pZBgCIAEoCVIQY2FtcGFpZ25XYWxs'
    'ZXRJZBIYCgdiYWxhbmNlGAMgASgEUgdiYWxhbmNlEisKEWF2YWlsYWJsZV9iYWxhbmNlGAQgAS'
    'gEUhBhdmFpbGFibGVCYWxhbmNlEhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeQ==');

@$core.Deprecated('Use crowdfundPaginationInfoDescriptor instead')
const CrowdfundPaginationInfo$json = {
  '1': 'CrowdfundPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `CrowdfundPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundPaginationInfoDescriptor = $convert.base64Decode(
    'ChdDcm93ZGZ1bmRQYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbn'
    'RQYWdlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMg'
    'ASgFUgp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQ'
    'oIaGFzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');

@$core.Deprecated('Use donationPaginationInfoDescriptor instead')
const DonationPaginationInfo$json = {
  '1': 'DonationPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `DonationPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List donationPaginationInfoDescriptor = $convert.base64Decode(
    'ChZEb25hdGlvblBhZ2luYXRpb25JbmZvEiEKDGN1cnJlbnRfcGFnZRgBIAEoBVILY3VycmVudF'
    'BhZ2USHwoLdG90YWxfcGFnZXMYAiABKAVSCnRvdGFsUGFnZXMSHwoLdG90YWxfaXRlbXMYAyAB'
    'KAVSCnRvdGFsSXRlbXMSJAoOaXRlbXNfcGVyX3BhZ2UYBCABKAVSDGl0ZW1zUGVyUGFnZRIZCg'
    'hoYXNfbmV4dBgFIAEoCFIHaGFzTmV4dBIZCghoYXNfcHJldhgGIAEoCFIHaGFzUHJldg==');

@$core.Deprecated('Use crowdfundReceiptPaginationInfoDescriptor instead')
const CrowdfundReceiptPaginationInfo$json = {
  '1': 'CrowdfundReceiptPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `CrowdfundReceiptPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundReceiptPaginationInfoDescriptor = $convert.base64Decode(
    'Ch5Dcm93ZGZ1bmRSZWNlaXB0UGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUg'
    'tjdXJyZW50UGFnZRIfCgt0b3RhbF9wYWdlcxgCIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9p'
    'dGVtcxgDIAEoBVIKdG90YWxJdGVtcxIkCg5pdGVtc19wZXJfcGFnZRgEIAEoBVIMaXRlbXNQZX'
    'JQYWdlEhkKCGhhc19uZXh0GAUgASgIUgdoYXNOZXh0EhkKCGhhc19wcmV2GAYgASgIUgdoYXNQ'
    'cmV2');

@$core.Deprecated('Use notificationChannelMessageDescriptor instead')
const NotificationChannelMessage$json = {
  '1': 'NotificationChannelMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'crowdfund_id', '3': 2, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'creator_user_id', '3': 3, '4': 1, '5': 9, '10': 'creatorUserId'},
    {'1': 'channel_type', '3': 4, '4': 1, '5': 14, '6': '.pb.NotificationChannelType', '10': 'channelType'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.NotificationChannelStatus', '10': 'status'},
    {'1': 'channel_name', '3': 6, '4': 1, '5': 9, '10': 'channelName'},
    {'1': 'channel_username', '3': 7, '4': 1, '5': 9, '10': 'channelUsername'},
    {'1': 'enabled_events', '3': 8, '4': 3, '5': 14, '6': '.pb.NotificationEventType', '10': 'enabledEvents'},
    {'1': 'preferences', '3': 9, '4': 1, '5': 11, '6': '.pb.NotificationPreferencesMessage', '10': 'preferences'},
    {'1': 'last_notification_at', '3': 10, '4': 1, '5': 9, '10': 'lastNotificationAt'},
    {'1': 'notification_count', '3': 11, '4': 1, '5': 5, '10': 'notificationCount'},
    {'1': 'failure_count', '3': 12, '4': 1, '5': 5, '10': 'failureCount'},
    {'1': 'last_error', '3': 13, '4': 1, '5': 9, '10': 'lastError'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 15, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `NotificationChannelMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationChannelMessageDescriptor = $convert.base64Decode(
    'ChpOb3RpZmljYXRpb25DaGFubmVsTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSIQoMY3Jvd2RmdW'
    '5kX2lkGAIgASgJUgtjcm93ZGZ1bmRJZBImCg9jcmVhdG9yX3VzZXJfaWQYAyABKAlSDWNyZWF0'
    'b3JVc2VySWQSPgoMY2hhbm5lbF90eXBlGAQgASgOMhsucGIuTm90aWZpY2F0aW9uQ2hhbm5lbF'
    'R5cGVSC2NoYW5uZWxUeXBlEjUKBnN0YXR1cxgFIAEoDjIdLnBiLk5vdGlmaWNhdGlvbkNoYW5u'
    'ZWxTdGF0dXNSBnN0YXR1cxIhCgxjaGFubmVsX25hbWUYBiABKAlSC2NoYW5uZWxOYW1lEikKEG'
    'NoYW5uZWxfdXNlcm5hbWUYByABKAlSD2NoYW5uZWxVc2VybmFtZRJACg5lbmFibGVkX2V2ZW50'
    'cxgIIAMoDjIZLnBiLk5vdGlmaWNhdGlvbkV2ZW50VHlwZVINZW5hYmxlZEV2ZW50cxJECgtwcm'
    'VmZXJlbmNlcxgJIAEoCzIiLnBiLk5vdGlmaWNhdGlvblByZWZlcmVuY2VzTWVzc2FnZVILcHJl'
    'ZmVyZW5jZXMSMAoUbGFzdF9ub3RpZmljYXRpb25fYXQYCiABKAlSEmxhc3ROb3RpZmljYXRpb2'
    '5BdBItChJub3RpZmljYXRpb25fY291bnQYCyABKAVSEW5vdGlmaWNhdGlvbkNvdW50EiMKDWZh'
    'aWx1cmVfY291bnQYDCABKAVSDGZhaWx1cmVDb3VudBIdCgpsYXN0X2Vycm9yGA0gASgJUglsYX'
    'N0RXJyb3ISHQoKY3JlYXRlZF9hdBgOIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYDyAB'
    'KAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use notificationPreferencesMessageDescriptor instead')
const NotificationPreferencesMessage$json = {
  '1': 'NotificationPreferencesMessage',
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

/// Descriptor for `NotificationPreferencesMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationPreferencesMessageDescriptor = $convert.base64Decode(
    'Ch5Ob3RpZmljYXRpb25QcmVmZXJlbmNlc01lc3NhZ2USLAoSaW5jbHVkZV9kb25vcl9uYW1lGA'
    'EgASgIUhBpbmNsdWRlRG9ub3JOYW1lEiUKDmluY2x1ZGVfYW1vdW50GAIgASgIUg1pbmNsdWRl'
    'QW1vdW50EicKD2luY2x1ZGVfbWVzc2FnZRgDIAEoCFIOaW5jbHVkZU1lc3NhZ2USKQoQaW5jbH'
    'VkZV9wcm9ncmVzcxgEIAEoCFIPaW5jbHVkZVByb2dyZXNzEi8KE2luY2x1ZGVfbGVhZGVyYm9h'
    'cmQYBSABKAhSEmluY2x1ZGVMZWFkZXJib2FyZBI4ChhsYXJnZV9kb25hdGlvbl90aHJlc2hvbG'
    'QYBiABKAFSFmxhcmdlRG9uYXRpb25UaHJlc2hvbGQSKQoQbWVzc2FnZV90ZW1wbGF0ZRgHIAEo'
    'CVIPbWVzc2FnZVRlbXBsYXRlEhoKCGxhbmd1YWdlGAggASgJUghsYW5ndWFnZRIuChNxdWlldF'
    '9ob3Vyc19lbmFibGVkGAkgASgIUhFxdWlldEhvdXJzRW5hYmxlZBIqChFxdWlldF9ob3Vyc19z'
    'dGFydBgKIAEoCVIPcXVpZXRIb3Vyc1N0YXJ0EiYKD3F1aWV0X2hvdXJzX2VuZBgLIAEoCVINcX'
    'VpZXRIb3Vyc0VuZBIaCgh0aW1lem9uZRgMIAEoCVIIdGltZXpvbmU=');

@$core.Deprecated('Use notificationDeliveryMessageDescriptor instead')
const NotificationDeliveryMessage$json = {
  '1': 'NotificationDeliveryMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'crowdfund_id', '3': 3, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'event_type', '3': 4, '4': 1, '5': 14, '6': '.pb.NotificationEventType', '10': 'eventType'},
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

/// Descriptor for `NotificationDeliveryMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationDeliveryMessageDescriptor = $convert.base64Decode(
    'ChtOb3RpZmljYXRpb25EZWxpdmVyeU1lc3NhZ2USDgoCaWQYASABKAlSAmlkEh0KCmNoYW5uZW'
    'xfaWQYAiABKAlSCWNoYW5uZWxJZBIhCgxjcm93ZGZ1bmRfaWQYAyABKAlSC2Nyb3dkZnVuZElk'
    'EjgKCmV2ZW50X3R5cGUYBCABKA4yGS5wYi5Ob3RpZmljYXRpb25FdmVudFR5cGVSCWV2ZW50VH'
    'lwZRIdCgpldmVudF9kYXRhGAUgASgJUglldmVudERhdGESJwoPbWVzc2FnZV9jb250ZW50GAYg'
    'ASgJUg5tZXNzYWdlQ29udGVudBIYCgdzdWNjZXNzGAcgASgIUgdzdWNjZXNzEiMKDWVycm9yX2'
    '1lc3NhZ2UYCCABKAlSDGVycm9yTWVzc2FnZRIfCgtyZXRyeV9jb3VudBgJIAEoBVIKcmV0cnlD'
    'b3VudBIuChNwbGF0Zm9ybV9tZXNzYWdlX2lkGAogASgJUhFwbGF0Zm9ybU1lc3NhZ2VJZBIdCg'
    'pjcmVhdGVkX2F0GAsgASgJUgljcmVhdGVkQXQSIQoMZGVsaXZlcmVkX2F0GAwgASgJUgtkZWxp'
    'dmVyZWRBdA==');

@$core.Deprecated('Use telegramConnectionDataMessageDescriptor instead')
const TelegramConnectionDataMessage$json = {
  '1': 'TelegramConnectionDataMessage',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 9, '10': 'chatId'},
    {'1': 'verification_code', '3': 2, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
};

/// Descriptor for `TelegramConnectionDataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List telegramConnectionDataMessageDescriptor = $convert.base64Decode(
    'Ch1UZWxlZ3JhbUNvbm5lY3Rpb25EYXRhTWVzc2FnZRIXCgdjaGF0X2lkGAEgASgJUgZjaGF0SW'
    'QSKwoRdmVyaWZpY2F0aW9uX2NvZGUYAiABKAlSEHZlcmlmaWNhdGlvbkNvZGU=');

@$core.Deprecated('Use discordConnectionDataMessageDescriptor instead')
const DiscordConnectionDataMessage$json = {
  '1': 'DiscordConnectionDataMessage',
  '2': [
    {'1': 'webhook_url', '3': 1, '4': 1, '5': 9, '10': 'webhookUrl'},
    {'1': 'server_name', '3': 2, '4': 1, '5': 9, '10': 'serverName'},
    {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `DiscordConnectionDataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List discordConnectionDataMessageDescriptor = $convert.base64Decode(
    'ChxEaXNjb3JkQ29ubmVjdGlvbkRhdGFNZXNzYWdlEh8KC3dlYmhvb2tfdXJsGAEgASgJUgp3ZW'
    'Job29rVXJsEh8KC3NlcnZlcl9uYW1lGAIgASgJUgpzZXJ2ZXJOYW1lEiEKDGNoYW5uZWxfbmFt'
    'ZRgDIAEoCVILY2hhbm5lbE5hbWU=');

@$core.Deprecated('Use whatsAppBusinessConnectionDataMessageDescriptor instead')
const WhatsAppBusinessConnectionDataMessage$json = {
  '1': 'WhatsAppBusinessConnectionDataMessage',
  '2': [
    {'1': 'phone_number_id', '3': 1, '4': 1, '5': 9, '10': 'phoneNumberId'},
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'recipient_id', '3': 3, '4': 1, '5': 9, '10': 'recipientId'},
  ],
};

/// Descriptor for `WhatsAppBusinessConnectionDataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List whatsAppBusinessConnectionDataMessageDescriptor = $convert.base64Decode(
    'CiVXaGF0c0FwcEJ1c2luZXNzQ29ubmVjdGlvbkRhdGFNZXNzYWdlEiYKD3Bob25lX251bWJlcl'
    '9pZBgBIAEoCVINcGhvbmVOdW1iZXJJZBIhCgxhY2Nlc3NfdG9rZW4YAiABKAlSC2FjY2Vzc1Rv'
    'a2VuEiEKDHJlY2lwaWVudF9pZBgDIAEoCVILcmVjaXBpZW50SWQ=');

@$core.Deprecated('Use slackConnectionDataMessageDescriptor instead')
const SlackConnectionDataMessage$json = {
  '1': 'SlackConnectionDataMessage',
  '2': [
    {'1': 'webhook_url', '3': 1, '4': 1, '5': 9, '10': 'webhookUrl'},
    {'1': 'workspace_name', '3': 2, '4': 1, '5': 9, '10': 'workspaceName'},
    {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `SlackConnectionDataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List slackConnectionDataMessageDescriptor = $convert.base64Decode(
    'ChpTbGFja0Nvbm5lY3Rpb25EYXRhTWVzc2FnZRIfCgt3ZWJob29rX3VybBgBIAEoCVIKd2ViaG'
    '9va1VybBIlCg53b3Jrc3BhY2VfbmFtZRgCIAEoCVINd29ya3NwYWNlTmFtZRIhCgxjaGFubmVs'
    'X25hbWUYAyABKAlSC2NoYW5uZWxOYW1l');

@$core.Deprecated('Use connectNotificationChannelRequestDescriptor instead')
const ConnectNotificationChannelRequest$json = {
  '1': 'ConnectNotificationChannelRequest',
  '2': [
    {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    {'1': 'channel_type', '3': 2, '4': 1, '5': 14, '6': '.pb.NotificationChannelType', '10': 'channelType'},
    {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
    {'1': 'telegram', '3': 4, '4': 1, '5': 11, '6': '.pb.TelegramConnectionDataMessage', '9': 0, '10': 'telegram'},
    {'1': 'discord', '3': 5, '4': 1, '5': 11, '6': '.pb.DiscordConnectionDataMessage', '9': 0, '10': 'discord'},
    {'1': 'whatsapp_business', '3': 6, '4': 1, '5': 11, '6': '.pb.WhatsAppBusinessConnectionDataMessage', '9': 0, '10': 'whatsappBusiness'},
    {'1': 'slack', '3': 7, '4': 1, '5': 11, '6': '.pb.SlackConnectionDataMessage', '9': 0, '10': 'slack'},
    {'1': 'enabled_events', '3': 8, '4': 3, '5': 14, '6': '.pb.NotificationEventType', '10': 'enabledEvents'},
    {'1': 'preferences', '3': 9, '4': 1, '5': 11, '6': '.pb.NotificationPreferencesMessage', '10': 'preferences'},
  ],
  '8': [
    {'1': 'connection_data'},
  ],
};

/// Descriptor for `ConnectNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectNotificationChannelRequestDescriptor = $convert.base64Decode(
    'CiFDb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlcXVlc3QSIQoMY3Jvd2RmdW5kX2lkGAEgAS'
    'gJUgtjcm93ZGZ1bmRJZBI+CgxjaGFubmVsX3R5cGUYAiABKA4yGy5wYi5Ob3RpZmljYXRpb25D'
    'aGFubmVsVHlwZVILY2hhbm5lbFR5cGUSIQoMY2hhbm5lbF9uYW1lGAMgASgJUgtjaGFubmVsTm'
    'FtZRI/Cgh0ZWxlZ3JhbRgEIAEoCzIhLnBiLlRlbGVncmFtQ29ubmVjdGlvbkRhdGFNZXNzYWdl'
    'SABSCHRlbGVncmFtEjwKB2Rpc2NvcmQYBSABKAsyIC5wYi5EaXNjb3JkQ29ubmVjdGlvbkRhdG'
    'FNZXNzYWdlSABSB2Rpc2NvcmQSWAoRd2hhdHNhcHBfYnVzaW5lc3MYBiABKAsyKS5wYi5XaGF0'
    'c0FwcEJ1c2luZXNzQ29ubmVjdGlvbkRhdGFNZXNzYWdlSABSEHdoYXRzYXBwQnVzaW5lc3MSNg'
    'oFc2xhY2sYByABKAsyHi5wYi5TbGFja0Nvbm5lY3Rpb25EYXRhTWVzc2FnZUgAUgVzbGFjaxJA'
    'Cg5lbmFibGVkX2V2ZW50cxgIIAMoDjIZLnBiLk5vdGlmaWNhdGlvbkV2ZW50VHlwZVINZW5hYm'
    'xlZEV2ZW50cxJECgtwcmVmZXJlbmNlcxgJIAEoCzIiLnBiLk5vdGlmaWNhdGlvblByZWZlcmVu'
    'Y2VzTWVzc2FnZVILcHJlZmVyZW5jZXNCEQoPY29ubmVjdGlvbl9kYXRh');

@$core.Deprecated('Use connectNotificationChannelResponseDescriptor instead')
const ConnectNotificationChannelResponse$json = {
  '1': 'ConnectNotificationChannelResponse',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.pb.NotificationChannelMessage', '10': 'channel'},
    {'1': 'requires_verification', '3': 2, '4': 1, '5': 8, '10': 'requiresVerification'},
    {'1': 'verification_instructions', '3': 3, '4': 1, '5': 9, '10': 'verificationInstructions'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ConnectNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectNotificationChannelResponseDescriptor = $convert.base64Decode(
    'CiJDb25uZWN0Tm90aWZpY2F0aW9uQ2hhbm5lbFJlc3BvbnNlEjgKB2NoYW5uZWwYASABKAsyHi'
    '5wYi5Ob3RpZmljYXRpb25DaGFubmVsTWVzc2FnZVIHY2hhbm5lbBIzChVyZXF1aXJlc192ZXJp'
    'ZmljYXRpb24YAiABKAhSFHJlcXVpcmVzVmVyaWZpY2F0aW9uEjsKGXZlcmlmaWNhdGlvbl9pbn'
    'N0cnVjdGlvbnMYAyABKAlSGHZlcmlmaWNhdGlvbkluc3RydWN0aW9ucxIYCgdtZXNzYWdlGAQg'
    'ASgJUgdtZXNzYWdl');

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
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.pb.NotificationChannelMessage', '10': 'channels'},
  ],
};

/// Descriptor for `GetNotificationChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationChannelsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXROb3RpZmljYXRpb25DaGFubmVsc1Jlc3BvbnNlEjoKCGNoYW5uZWxzGAEgAygLMh4ucG'
    'IuTm90aWZpY2F0aW9uQ2hhbm5lbE1lc3NhZ2VSCGNoYW5uZWxz');

@$core.Deprecated('Use updateNotificationChannelRequestDescriptor instead')
const UpdateNotificationChannelRequest$json = {
  '1': 'UpdateNotificationChannelRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'channel_name', '3': 2, '4': 1, '5': 9, '10': 'channelName'},
    {'1': 'enabled_events', '3': 3, '4': 3, '5': 14, '6': '.pb.NotificationEventType', '10': 'enabledEvents'},
    {'1': 'preferences', '3': 4, '4': 1, '5': 11, '6': '.pb.NotificationPreferencesMessage', '10': 'preferences'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.NotificationChannelStatus', '10': 'status'},
  ],
};

/// Descriptor for `UpdateNotificationChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotificationChannelRequestDescriptor = $convert.base64Decode(
    'CiBVcGRhdGVOb3RpZmljYXRpb25DaGFubmVsUmVxdWVzdBIdCgpjaGFubmVsX2lkGAEgASgJUg'
    'ljaGFubmVsSWQSIQoMY2hhbm5lbF9uYW1lGAIgASgJUgtjaGFubmVsTmFtZRJACg5lbmFibGVk'
    'X2V2ZW50cxgDIAMoDjIZLnBiLk5vdGlmaWNhdGlvbkV2ZW50VHlwZVINZW5hYmxlZEV2ZW50cx'
    'JECgtwcmVmZXJlbmNlcxgEIAEoCzIiLnBiLk5vdGlmaWNhdGlvblByZWZlcmVuY2VzTWVzc2Fn'
    'ZVILcHJlZmVyZW5jZXMSNQoGc3RhdHVzGAUgASgOMh0ucGIuTm90aWZpY2F0aW9uQ2hhbm5lbF'
    'N0YXR1c1IGc3RhdHVz');

@$core.Deprecated('Use updateNotificationChannelResponseDescriptor instead')
const UpdateNotificationChannelResponse$json = {
  '1': 'UpdateNotificationChannelResponse',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.pb.NotificationChannelMessage', '10': 'channel'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateNotificationChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotificationChannelResponseDescriptor = $convert.base64Decode(
    'CiFVcGRhdGVOb3RpZmljYXRpb25DaGFubmVsUmVzcG9uc2USOAoHY2hhbm5lbBgBIAEoCzIeLn'
    'BiLk5vdGlmaWNhdGlvbkNoYW5uZWxNZXNzYWdlUgdjaGFubmVsEhgKB21lc3NhZ2UYAiABKAlS'
    'B21lc3NhZ2U=');

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
    {'1': 'channel', '3': 2, '4': 1, '5': 11, '6': '.pb.NotificationChannelMessage', '10': 'channel'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `VerifyTelegramChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTelegramChannelResponseDescriptor = $convert.base64Decode(
    'Ch1WZXJpZnlUZWxlZ3JhbUNoYW5uZWxSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEjgKB2NoYW5uZWwYAiABKAsyHi5wYi5Ob3RpZmljYXRpb25DaGFubmVsTWVzc2FnZVIHY2hh'
    'bm5lbBIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');

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
    {'1': 'deliveries', '3': 1, '4': 3, '5': 11, '6': '.pb.NotificationDeliveryMessage', '10': 'deliveries'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetNotificationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNotificationHistoryResponseDescriptor = $convert.base64Decode(
    'Ch5HZXROb3RpZmljYXRpb25IaXN0b3J5UmVzcG9uc2USPwoKZGVsaXZlcmllcxgBIAMoCzIfLn'
    'BiLk5vdGlmaWNhdGlvbkRlbGl2ZXJ5TWVzc2FnZVIKZGVsaXZlcmllcxIUCgV0b3RhbBgCIAEo'
    'BVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYBCABKAVSCHBhZ2VTaX'
    'plEhkKCGhhc19tb3JlGAUgASgIUgdoYXNNb3Jl');

