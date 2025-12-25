///
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use crowdfundStatusDescriptor instead')
const CrowdfundStatus$json = const {
  '1': 'CrowdfundStatus',
  '2': const [
    const {'1': 'CROWDFUND_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'CROWDFUND_STATUS_ACTIVE', '2': 1},
    const {'1': 'CROWDFUND_STATUS_PAUSED', '2': 2},
    const {'1': 'CROWDFUND_STATUS_COMPLETED', '2': 3},
    const {'1': 'CROWDFUND_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `CrowdfundStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List crowdfundStatusDescriptor = $convert.base64Decode('Cg9Dcm93ZGZ1bmRTdGF0dXMSIAocQ1JPV0RGVU5EX1NUQVRVU19VTlNQRUNJRklFRBAAEhsKF0NST1dERlVORF9TVEFUVVNfQUNUSVZFEAESGwoXQ1JPV0RGVU5EX1NUQVRVU19QQVVTRUQQAhIeChpDUk9XREZVTkRfU1RBVFVTX0NPTVBMRVRFRBADEh4KGkNST1dERlVORF9TVEFUVVNfQ0FOQ0VMTEVEEAQ=');
@$core.Deprecated('Use crowdfundVisibilityDescriptor instead')
const CrowdfundVisibility$json = const {
  '1': 'CrowdfundVisibility',
  '2': const [
    const {'1': 'CROWDFUND_VISIBILITY_UNSPECIFIED', '2': 0},
    const {'1': 'CROWDFUND_VISIBILITY_PUBLIC', '2': 1},
    const {'1': 'CROWDFUND_VISIBILITY_PRIVATE', '2': 2},
    const {'1': 'CROWDFUND_VISIBILITY_UNLISTED', '2': 3},
  ],
};

/// Descriptor for `CrowdfundVisibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List crowdfundVisibilityDescriptor = $convert.base64Decode('ChNDcm93ZGZ1bmRWaXNpYmlsaXR5EiQKIENST1dERlVORF9WSVNJQklMSVRZX1VOU1BFQ0lGSUVEEAASHwobQ1JPV0RGVU5EX1ZJU0lCSUxJVFlfUFVCTElDEAESIAocQ1JPV0RGVU5EX1ZJU0lCSUxJVFlfUFJJVkFURRACEiEKHUNST1dERlVORF9WSVNJQklMSVRZX1VOTElTVEVEEAM=');
@$core.Deprecated('Use donationStatusDescriptor instead')
const DonationStatus$json = const {
  '1': 'DonationStatus',
  '2': const [
    const {'1': 'DONATION_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'DONATION_STATUS_PENDING', '2': 1},
    const {'1': 'DONATION_STATUS_PROCESSING', '2': 2},
    const {'1': 'DONATION_STATUS_COMPLETED', '2': 3},
    const {'1': 'DONATION_STATUS_FAILED', '2': 4},
    const {'1': 'DONATION_STATUS_REFUNDED', '2': 5},
  ],
};

/// Descriptor for `DonationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List donationStatusDescriptor = $convert.base64Decode('Cg5Eb25hdGlvblN0YXR1cxIfChtET05BVElPTl9TVEFUVVNfVU5TUEVDSUZJRUQQABIbChdET05BVElPTl9TVEFUVVNfUEVORElORxABEh4KGkRPTkFUSU9OX1NUQVRVU19QUk9DRVNTSU5HEAISHQoZRE9OQVRJT05fU1RBVFVTX0NPTVBMRVRFRBADEhoKFkRPTkFUSU9OX1NUQVRVU19GQUlMRUQQBBIcChhET05BVElPTl9TVEFUVVNfUkVGVU5ERUQQBQ==');
@$core.Deprecated('Use crowdfundCreatorMessageDescriptor instead')
const CrowdfundCreatorMessage$json = const {
  '1': 'CrowdfundCreatorMessage',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'profile_picture', '3': 5, '4': 1, '5': 9, '10': 'profilePicture'},
    const {'1': 'verified', '3': 6, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'verified_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
    const {'1': 'facial_recognition_enabled', '3': 8, '4': 1, '5': 8, '10': 'facialRecognitionEnabled'},
  ],
};

/// Descriptor for `CrowdfundCreatorMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundCreatorMessageDescriptor = $convert.base64Decode('ChdDcm93ZGZ1bmRDcmVhdG9yTWVzc2FnZRIXCgd1c2VyX2lkGAEgASgEUgZ1c2VySWQSGgoIdXNlcm5hbWUYAiABKAlSCHVzZXJuYW1lEh0KCmZpcnN0X25hbWUYAyABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUYBCABKAlSCGxhc3ROYW1lEicKD3Byb2ZpbGVfcGljdHVyZRgFIAEoCVIOcHJvZmlsZVBpY3R1cmUSGgoIdmVyaWZpZWQYBiABKAhSCHZlcmlmaWVkEjsKC3ZlcmlmaWVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdmVyaWZpZWRBdBI8ChpmYWNpYWxfcmVjb2duaXRpb25fZW5hYmxlZBgIIAEoCFIYZmFjaWFsUmVjb2duaXRpb25FbmFibGVk');
@$core.Deprecated('Use crowdfundMessageDescriptor instead')
const CrowdfundMessage$json = const {
  '1': 'CrowdfundMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'creator_user_id', '3': 2, '4': 1, '5': 4, '10': 'creatorUserId'},
    const {'1': 'creator', '3': 3, '4': 1, '5': 11, '6': '.pb.CrowdfundCreatorMessage', '10': 'creator'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'story', '3': 6, '4': 1, '5': 9, '10': 'story'},
    const {'1': 'crowdfund_code', '3': 7, '4': 1, '5': 9, '10': 'crowdfundCode'},
    const {'1': 'target_amount', '3': 8, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'current_amount', '3': 9, '4': 1, '5': 4, '10': 'currentAmount'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'deadline', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    const {'1': 'category', '3': 12, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'status', '3': 13, '4': 1, '5': 14, '6': '.pb.CrowdfundStatus', '10': 'status'},
    const {'1': 'image_url', '3': 14, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'visibility', '3': 15, '4': 1, '5': 14, '6': '.pb.CrowdfundVisibility', '10': 'visibility'},
    const {'1': 'metadata', '3': 16, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'donor_count', '3': 17, '4': 1, '5': 5, '10': 'donorCount'},
    const {'1': 'progress_percentage', '3': 18, '4': 1, '5': 1, '10': 'progressPercentage'},
    const {'1': 'created_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'recent_donations', '3': 21, '4': 3, '5': 11, '6': '.pb.CrowdfundDonationMessage', '10': 'recentDonations'},
  ],
};

/// Descriptor for `CrowdfundMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundMessageDescriptor = $convert.base64Decode('ChBDcm93ZGZ1bmRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBImCg9jcmVhdG9yX3VzZXJfaWQYAiABKARSDWNyZWF0b3JVc2VySWQSNQoHY3JlYXRvchgDIAEoCzIbLnBiLkNyb3dkZnVuZENyZWF0b3JNZXNzYWdlUgdjcmVhdG9yEhQKBXRpdGxlGAQgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SFAoFc3RvcnkYBiABKAlSBXN0b3J5EiUKDmNyb3dkZnVuZF9jb2RlGAcgASgJUg1jcm93ZGZ1bmRDb2RlEiMKDXRhcmdldF9hbW91bnQYCCABKARSDHRhcmdldEFtb3VudBIlCg5jdXJyZW50X2Ftb3VudBgJIAEoBFINY3VycmVudEFtb3VudBIaCghjdXJyZW5jeRgKIAEoCVIIY3VycmVuY3kSNgoIZGVhZGxpbmUYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRIaCghjYXRlZ29yeRgMIAEoCVIIY2F0ZWdvcnkSKwoGc3RhdHVzGA0gASgOMhMucGIuQ3Jvd2RmdW5kU3RhdHVzUgZzdGF0dXMSGwoJaW1hZ2VfdXJsGA4gASgJUghpbWFnZVVybBI3Cgp2aXNpYmlsaXR5GA8gASgOMhcucGIuQ3Jvd2RmdW5kVmlzaWJpbGl0eVIKdmlzaWJpbGl0eRIaCghtZXRhZGF0YRgQIAEoCVIIbWV0YWRhdGESHwoLZG9ub3JfY291bnQYESABKAVSCmRvbm9yQ291bnQSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgSIAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdlEjkKCmNyZWF0ZWRfYXQYEyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgUIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBJHChByZWNlbnRfZG9uYXRpb25zGBUgAygLMhwucGIuQ3Jvd2RmdW5kRG9uYXRpb25NZXNzYWdlUg9yZWNlbnREb25hdGlvbnM=');
@$core.Deprecated('Use crowdfundDonorMessageDescriptor instead')
const CrowdfundDonorMessage$json = const {
  '1': 'CrowdfundDonorMessage',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'profile_picture', '3': 3, '4': 1, '5': 9, '10': 'profilePicture'},
    const {'1': 'is_anonymous', '3': 4, '4': 1, '5': 8, '10': 'isAnonymous'},
    const {'1': 'is_creator', '3': 5, '4': 1, '5': 8, '10': 'isCreator'},
  ],
};

/// Descriptor for `CrowdfundDonorMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundDonorMessageDescriptor = $convert.base64Decode('ChVDcm93ZGZ1bmREb25vck1lc3NhZ2USFwoHdXNlcl9pZBgBIAEoBFIGdXNlcklkEiEKDGRpc3BsYXlfbmFtZRgCIAEoCVILZGlzcGxheU5hbWUSJwoPcHJvZmlsZV9waWN0dXJlGAMgASgJUg5wcm9maWxlUGljdHVyZRIhCgxpc19hbm9ueW1vdXMYBCABKAhSC2lzQW5vbnltb3VzEh0KCmlzX2NyZWF0b3IYBSABKAhSCWlzQ3JlYXRvcg==');
@$core.Deprecated('Use crowdfundDonationMessageDescriptor instead')
const CrowdfundDonationMessage$json = const {
  '1': 'CrowdfundDonationMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'crowdfund_id', '3': 2, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'donor_user_id', '3': 3, '4': 1, '5': 4, '10': 'donorUserId'},
    const {'1': 'donor', '3': 4, '4': 1, '5': 11, '6': '.pb.CrowdfundDonorMessage', '10': 'donor'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'donation_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'donationDate'},
    const {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.DonationStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 9, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'receipt_id', '3': 10, '4': 1, '5': 9, '10': 'receiptId'},
    const {'1': 'message', '3': 11, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_anonymous', '3': 12, '4': 1, '5': 8, '10': 'isAnonymous'},
    const {'1': 'payment_method', '3': 13, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'metadata', '3': 14, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CrowdfundDonationMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundDonationMessageDescriptor = $convert.base64Decode('ChhDcm93ZGZ1bmREb25hdGlvbk1lc3NhZ2USDgoCaWQYASABKAlSAmlkEiEKDGNyb3dkZnVuZF9pZBgCIAEoCVILY3Jvd2RmdW5kSWQSIgoNZG9ub3JfdXNlcl9pZBgDIAEoBFILZG9ub3JVc2VySWQSLwoFZG9ub3IYBCABKAsyGS5wYi5Dcm93ZGZ1bmREb25vck1lc3NhZ2VSBWRvbm9yEhYKBmFtb3VudBgFIAEoBFIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRI/Cg1kb25hdGlvbl9kYXRlGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMZG9uYXRpb25EYXRlEioKBnN0YXR1cxgIIAEoDjISLnBiLkRvbmF0aW9uU3RhdHVzUgZzdGF0dXMSJQoOdHJhbnNhY3Rpb25faWQYCSABKAlSDXRyYW5zYWN0aW9uSWQSHQoKcmVjZWlwdF9pZBgKIAEoCVIJcmVjZWlwdElkEhgKB21lc3NhZ2UYCyABKAlSB21lc3NhZ2USIQoMaXNfYW5vbnltb3VzGAwgASgIUgtpc0Fub255bW91cxIlCg5wYXltZW50X21ldGhvZBgNIAEoCVINcGF5bWVudE1ldGhvZBIaCghtZXRhZGF0YRgOIAEoCVIIbWV0YWRhdGE=');
@$core.Deprecated('Use crowdfundReceiptMessageDescriptor instead')
const CrowdfundReceiptMessage$json = const {
  '1': 'CrowdfundReceiptMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'donation_id', '3': 2, '4': 1, '5': 9, '10': 'donationId'},
    const {'1': 'crowdfund_id', '3': 3, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'crowdfund_title', '3': 4, '4': 1, '5': 9, '10': 'crowdfundTitle'},
    const {'1': 'donor_user_id', '3': 5, '4': 1, '5': 4, '10': 'donorUserId'},
    const {'1': 'donor_name', '3': 6, '4': 1, '5': 9, '10': 'donorName'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'donation_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'donationDate'},
    const {'1': 'generated_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
    const {'1': 'receipt_number', '3': 11, '4': 1, '5': 9, '10': 'receiptNumber'},
    const {'1': 'receipt_data', '3': 12, '4': 1, '5': 9, '10': 'receiptData'},
  ],
};

/// Descriptor for `CrowdfundReceiptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundReceiptMessageDescriptor = $convert.base64Decode('ChdDcm93ZGZ1bmRSZWNlaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHwoLZG9uYXRpb25faWQYAiABKAlSCmRvbmF0aW9uSWQSIQoMY3Jvd2RmdW5kX2lkGAMgASgJUgtjcm93ZGZ1bmRJZBInCg9jcm93ZGZ1bmRfdGl0bGUYBCABKAlSDmNyb3dkZnVuZFRpdGxlEiIKDWRvbm9yX3VzZXJfaWQYBSABKARSC2Rvbm9yVXNlcklkEh0KCmRvbm9yX25hbWUYBiABKAlSCWRvbm9yTmFtZRIWCgZhbW91bnQYByABKARSBmFtb3VudBIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3kSPwoNZG9uYXRpb25fZGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGRvbmF0aW9uRGF0ZRI9CgxnZW5lcmF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtnZW5lcmF0ZWRBdBIlCg5yZWNlaXB0X251bWJlchgLIAEoCVINcmVjZWlwdE51bWJlchIhCgxyZWNlaXB0X2RhdGEYDCABKAlSC3JlY2VpcHREYXRh');
@$core.Deprecated('Use createCrowdfundRequestDescriptor instead')
const CreateCrowdfundRequest$json = const {
  '1': 'CreateCrowdfundRequest',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'story', '3': 3, '4': 1, '5': 9, '10': 'story'},
    const {'1': 'target_amount', '3': 4, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'deadline', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    const {'1': 'category', '3': 7, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'image_url', '3': 8, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'visibility', '3': 9, '4': 1, '5': 14, '6': '.pb.CrowdfundVisibility', '10': 'visibility'},
    const {'1': 'metadata', '3': 10, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CreateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVDcm93ZGZ1bmRSZXF1ZXN0EhQKBXRpdGxlGAEgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgCIAEoCVILZGVzY3JpcHRpb24SFAoFc3RvcnkYAyABKAlSBXN0b3J5EiMKDXRhcmdldF9hbW91bnQYBCABKARSDHRhcmdldEFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSNgoIZGVhZGxpbmUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRIaCghjYXRlZ29yeRgHIAEoCVIIY2F0ZWdvcnkSGwoJaW1hZ2VfdXJsGAggASgJUghpbWFnZVVybBI3Cgp2aXNpYmlsaXR5GAkgASgOMhcucGIuQ3Jvd2RmdW5kVmlzaWJpbGl0eVIKdmlzaWJpbGl0eRIaCghtZXRhZGF0YRgKIAEoCVIIbWV0YWRhdGE=');
@$core.Deprecated('Use createCrowdfundResponseDescriptor instead')
const CreateCrowdfundResponse$json = const {
  '1': 'CreateCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfund'},
  ],
};

/// Descriptor for `CreateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCrowdfundResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVDcm93ZGZ1bmRSZXNwb25zZRIyCgljcm93ZGZ1bmQYASABKAsyFC5wYi5Dcm93ZGZ1bmRNZXNzYWdlUgljcm93ZGZ1bmQ=');
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
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfund'},
  ],
};

/// Descriptor for `GetCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundResponseDescriptor = $convert.base64Decode('ChRHZXRDcm93ZGZ1bmRSZXNwb25zZRIyCgljcm93ZGZ1bmQYASABKAsyFC5wYi5Dcm93ZGZ1bmRNZXNzYWdlUgljcm93ZGZ1bmQ=');
@$core.Deprecated('Use listCrowdfundsRequestDescriptor instead')
const ListCrowdfundsRequest$json = const {
  '1': 'ListCrowdfundsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'my_crowdfunds_only', '3': 5, '4': 1, '5': 8, '10': 'myCrowdfundsOnly'},
  ],
};

/// Descriptor for `ListCrowdfundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCrowdfundsRequestDescriptor = $convert.base64Decode('ChVMaXN0Q3Jvd2RmdW5kc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIsChJteV9jcm93ZGZ1bmRzX29ubHkYBSABKAhSEG15Q3Jvd2RmdW5kc09ubHk=');
@$core.Deprecated('Use listCrowdfundsResponseDescriptor instead')
const ListCrowdfundsResponse$json = const {
  '1': 'ListCrowdfundsResponse',
  '2': const [
    const {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfunds'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CrowdfundPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCrowdfundsResponseDescriptor = $convert.base64Decode('ChZMaXN0Q3Jvd2RmdW5kc1Jlc3BvbnNlEjQKCmNyb3dkZnVuZHMYASADKAsyFC5wYi5Dcm93ZGZ1bmRNZXNzYWdlUgpjcm93ZGZ1bmRzEjsKCnBhZ2luYXRpb24YAiABKAsyGy5wYi5Dcm93ZGZ1bmRQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');
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
    const {'1': 'crowdfunds', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfunds'},
  ],
};

/// Descriptor for `SearchCrowdfundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchCrowdfundsResponseDescriptor = $convert.base64Decode('ChhTZWFyY2hDcm93ZGZ1bmRzUmVzcG9uc2USNAoKY3Jvd2RmdW5kcxgBIAMoCzIULnBiLkNyb3dkZnVuZE1lc3NhZ2VSCmNyb3dkZnVuZHM=');
@$core.Deprecated('Use updateCrowdfundRequestDescriptor instead')
const UpdateCrowdfundRequest$json = const {
  '1': 'UpdateCrowdfundRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'story', '3': 4, '4': 1, '5': 9, '10': 'story'},
    const {'1': 'deadline', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.pb.CrowdfundStatus', '10': 'status'},
    const {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `UpdateCrowdfundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCrowdfundRequestDescriptor = $convert.base64Decode('ChZVcGRhdGVDcm93ZGZ1bmRSZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIUCgVzdG9yeRgEIAEoCVIFc3RvcnkSNgoIZGVhZGxpbmUYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRIrCgZzdGF0dXMYBiABKA4yEy5wYi5Dcm93ZGZ1bmRTdGF0dXNSBnN0YXR1cxIbCglpbWFnZV91cmwYByABKAlSCGltYWdlVXJsEhoKCG1ldGFkYXRhGAggASgJUghtZXRhZGF0YQ==');
@$core.Deprecated('Use updateCrowdfundResponseDescriptor instead')
const UpdateCrowdfundResponse$json = const {
  '1': 'UpdateCrowdfundResponse',
  '2': const [
    const {'1': 'crowdfund', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundMessage', '10': 'crowdfund'},
  ],
};

/// Descriptor for `UpdateCrowdfundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCrowdfundResponseDescriptor = $convert.base64Decode('ChdVcGRhdGVDcm93ZGZ1bmRSZXNwb25zZRIyCgljcm93ZGZ1bmQYASABKAsyFC5wYi5Dcm93ZGZ1bmRNZXNzYWdlUgljcm93ZGZ1bmQ=');
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
@$core.Deprecated('Use makeDonationRequestDescriptor instead')
const MakeDonationRequest$json = const {
  '1': 'MakeDonationRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_anonymous', '3': 4, '4': 1, '5': 8, '10': 'isAnonymous'},
    const {'1': 'source_account_id', '3': 5, '4': 1, '5': 4, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `MakeDonationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeDonationRequestDescriptor = $convert.base64Decode('ChNNYWtlRG9uYXRpb25SZXF1ZXN0EiEKDGNyb3dkZnVuZF9pZBgBIAEoCVILY3Jvd2RmdW5kSWQSFgoGYW1vdW50GAIgASgEUgZhbW91bnQSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRIhCgxpc19hbm9ueW1vdXMYBCABKAhSC2lzQW5vbnltb3VzEioKEXNvdXJjZV9hY2NvdW50X2lkGAUgASgEUg9zb3VyY2VBY2NvdW50SWQ=');
@$core.Deprecated('Use makeDonationResponseDescriptor instead')
const MakeDonationResponse$json = const {
  '1': 'MakeDonationResponse',
  '2': const [
    const {'1': 'donation', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundDonationMessage', '10': 'donation'},
  ],
};

/// Descriptor for `MakeDonationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeDonationResponseDescriptor = $convert.base64Decode('ChRNYWtlRG9uYXRpb25SZXNwb25zZRI4Cghkb25hdGlvbhgBIAEoCzIcLnBiLkNyb3dkZnVuZERvbmF0aW9uTWVzc2FnZVIIZG9uYXRpb24=');
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
    const {'1': 'donations', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundDonationMessage', '10': 'donations'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.DonationPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetCrowdfundDonationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundDonationsResponseDescriptor = $convert.base64Decode('Ch1HZXRDcm93ZGZ1bmREb25hdGlvbnNSZXNwb25zZRI6Cglkb25hdGlvbnMYASADKAsyHC5wYi5Dcm93ZGZ1bmREb25hdGlvbk1lc3NhZ2VSCWRvbmF0aW9ucxI6CgpwYWdpbmF0aW9uGAIgASgLMhoucGIuRG9uYXRpb25QYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');
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
    const {'1': 'donations', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundDonationMessage', '10': 'donations'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.DonationPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserDonationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDonationsResponseDescriptor = $convert.base64Decode('ChhHZXRVc2VyRG9uYXRpb25zUmVzcG9uc2USOgoJZG9uYXRpb25zGAEgAygLMhwucGIuQ3Jvd2RmdW5kRG9uYXRpb25NZXNzYWdlUglkb25hdGlvbnMSOgoKcGFnaW5hdGlvbhgCIAEoCzIaLnBiLkRvbmF0aW9uUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');
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
    const {'1': 'receipt', '3': 1, '4': 1, '5': 11, '6': '.pb.CrowdfundReceiptMessage', '10': 'receipt'},
  ],
};

/// Descriptor for `GenerateDonationReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateDonationReceiptResponseDescriptor = $convert.base64Decode('Ch9HZW5lcmF0ZURvbmF0aW9uUmVjZWlwdFJlc3BvbnNlEjUKB3JlY2VpcHQYASABKAsyGy5wYi5Dcm93ZGZ1bmRSZWNlaXB0TWVzc2FnZVIHcmVjZWlwdA==');
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
    const {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.pb.CrowdfundReceiptMessage', '10': 'receipts'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.CrowdfundReceiptPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserCrowdfundReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCrowdfundReceiptsResponseDescriptor = $convert.base64Decode('CiBHZXRVc2VyQ3Jvd2RmdW5kUmVjZWlwdHNSZXNwb25zZRI3CghyZWNlaXB0cxgBIAMoCzIbLnBiLkNyb3dkZnVuZFJlY2VpcHRNZXNzYWdlUghyZWNlaXB0cxJCCgpwYWdpbmF0aW9uGAIgASgLMiIucGIuQ3Jvd2RmdW5kUmVjZWlwdFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getCrowdfundStatisticsRequestDescriptor instead')
const GetCrowdfundStatisticsRequest$json = const {
  '1': 'GetCrowdfundStatisticsRequest',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
  ],
};

/// Descriptor for `GetCrowdfundStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundStatisticsRequestDescriptor = $convert.base64Decode('Ch1HZXRDcm93ZGZ1bmRTdGF0aXN0aWNzUmVxdWVzdBIhCgxjcm93ZGZ1bmRfaWQYASABKAlSC2Nyb3dkZnVuZElk');
@$core.Deprecated('Use getCrowdfundStatisticsResponseDescriptor instead')
const GetCrowdfundStatisticsResponse$json = const {
  '1': 'GetCrowdfundStatisticsResponse',
  '2': const [
    const {'1': 'crowdfund_id', '3': 1, '4': 1, '5': 9, '10': 'crowdfundId'},
    const {'1': 'total_raised', '3': 2, '4': 1, '5': 4, '10': 'totalRaised'},
    const {'1': 'target_amount', '3': 3, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'progress_percentage', '3': 4, '4': 1, '5': 1, '10': 'progressPercentage'},
    const {'1': 'donor_count', '3': 5, '4': 1, '5': 5, '10': 'donorCount'},
    const {'1': 'average_donation', '3': 6, '4': 1, '5': 4, '10': 'averageDonation'},
    const {'1': 'largest_donation', '3': 7, '4': 1, '5': 4, '10': 'largestDonation'},
    const {'1': 'days_remaining', '3': 8, '4': 1, '5': 5, '10': 'daysRemaining'},
    const {'1': 'is_completed', '3': 9, '4': 1, '5': 8, '10': 'isCompleted'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `GetCrowdfundStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrowdfundStatisticsResponseDescriptor = $convert.base64Decode('Ch5HZXRDcm93ZGZ1bmRTdGF0aXN0aWNzUmVzcG9uc2USIQoMY3Jvd2RmdW5kX2lkGAEgASgJUgtjcm93ZGZ1bmRJZBIhCgx0b3RhbF9yYWlzZWQYAiABKARSC3RvdGFsUmFpc2VkEiMKDXRhcmdldF9hbW91bnQYAyABKARSDHRhcmdldEFtb3VudBIvChNwcm9ncmVzc19wZXJjZW50YWdlGAQgASgBUhJwcm9ncmVzc1BlcmNlbnRhZ2USHwoLZG9ub3JfY291bnQYBSABKAVSCmRvbm9yQ291bnQSKQoQYXZlcmFnZV9kb25hdGlvbhgGIAEoBFIPYXZlcmFnZURvbmF0aW9uEikKEGxhcmdlc3RfZG9uYXRpb24YByABKARSD2xhcmdlc3REb25hdGlvbhIlCg5kYXlzX3JlbWFpbmluZxgIIAEoBVINZGF5c1JlbWFpbmluZxIhCgxpc19jb21wbGV0ZWQYCSABKAhSC2lzQ29tcGxldGVkEjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use crowdfundPaginationInfoDescriptor instead')
const CrowdfundPaginationInfo$json = const {
  '1': 'CrowdfundPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `CrowdfundPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundPaginationInfoDescriptor = $convert.base64Decode('ChdDcm93ZGZ1bmRQYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYWdlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMgASgFUgp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQoIaGFzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');
@$core.Deprecated('Use donationPaginationInfoDescriptor instead')
const DonationPaginationInfo$json = const {
  '1': 'DonationPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `DonationPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List donationPaginationInfoDescriptor = $convert.base64Decode('ChZEb25hdGlvblBhZ2luYXRpb25JbmZvEiEKDGN1cnJlbnRfcGFnZRgBIAEoBVILY3VycmVudFBhZ2USHwoLdG90YWxfcGFnZXMYAiABKAVSCnRvdGFsUGFnZXMSHwoLdG90YWxfaXRlbXMYAyABKAVSCnRvdGFsSXRlbXMSJAoOaXRlbXNfcGVyX3BhZ2UYBCABKAVSDGl0ZW1zUGVyUGFnZRIZCghoYXNfbmV4dBgFIAEoCFIHaGFzTmV4dBIZCghoYXNfcHJldhgGIAEoCFIHaGFzUHJldg==');
@$core.Deprecated('Use crowdfundReceiptPaginationInfoDescriptor instead')
const CrowdfundReceiptPaginationInfo$json = const {
  '1': 'CrowdfundReceiptPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `CrowdfundReceiptPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crowdfundReceiptPaginationInfoDescriptor = $convert.base64Decode('Ch5Dcm93ZGZ1bmRSZWNlaXB0UGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UGFnZRIfCgt0b3RhbF9wYWdlcxgCIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9pdGVtcxgDIAEoBVIKdG90YWxJdGVtcxIkCg5pdGVtc19wZXJfcGFnZRgEIAEoBVIMaXRlbXNQZXJQYWdlEhkKCGhhc19uZXh0GAUgASgIUgdoYXNOZXh0EhkKCGhhc19wcmV2GAYgASgIUgdoYXNQcmV2');
