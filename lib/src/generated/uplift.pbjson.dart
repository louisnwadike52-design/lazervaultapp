// This is a generated file - do not edit.
//
// Generated from uplift.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use upliftFundStatusDescriptor instead')
const UpliftFundStatus$json = {
  '1': 'UpliftFundStatus',
  '2': [
    {'1': 'UPLIFT_FUND_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'UPLIFT_FUND_STATUS_DRAFT', '2': 1},
    {'1': 'UPLIFT_FUND_STATUS_OPEN', '2': 2},
    {'1': 'UPLIFT_FUND_STATUS_REVIEWING', '2': 3},
    {'1': 'UPLIFT_FUND_STATUS_FUNDING', '2': 4},
    {'1': 'UPLIFT_FUND_STATUS_COMPLETED', '2': 5},
    {'1': 'UPLIFT_FUND_STATUS_PAUSED', '2': 6},
    {'1': 'UPLIFT_FUND_STATUS_CANCELLED', '2': 7},
    {'1': 'UPLIFT_FUND_STATUS_EXPIRED', '2': 8},
  ],
};

/// Descriptor for `UpliftFundStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List upliftFundStatusDescriptor = $convert.base64Decode(
    'ChBVcGxpZnRGdW5kU3RhdHVzEiIKHlVQTElGVF9GVU5EX1NUQVRVU19VTlNQRUNJRklFRBAAEh'
    'wKGFVQTElGVF9GVU5EX1NUQVRVU19EUkFGVBABEhsKF1VQTElGVF9GVU5EX1NUQVRVU19PUEVO'
    'EAISIAocVVBMSUZUX0ZVTkRfU1RBVFVTX1JFVklFV0lORxADEh4KGlVQTElGVF9GVU5EX1NUQV'
    'RVU19GVU5ESU5HEAQSIAocVVBMSUZUX0ZVTkRfU1RBVFVTX0NPTVBMRVRFRBAFEh0KGVVQTElG'
    'VF9GVU5EX1NUQVRVU19QQVVTRUQQBhIgChxVUExJRlRfRlVORF9TVEFUVVNfQ0FOQ0VMTEVEEA'
    'cSHgoaVVBMSUZUX0ZVTkRfU1RBVFVTX0VYUElSRUQQCA==');

@$core.Deprecated('Use upliftApplicationStatusDescriptor instead')
const UpliftApplicationStatus$json = {
  '1': 'UpliftApplicationStatus',
  '2': [
    {'1': 'UPLIFT_APPLICATION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'UPLIFT_APPLICATION_STATUS_SUBMITTED', '2': 1},
    {'1': 'UPLIFT_APPLICATION_STATUS_UNDER_REVIEW', '2': 2},
    {'1': 'UPLIFT_APPLICATION_STATUS_SHORTLISTED', '2': 3},
    {'1': 'UPLIFT_APPLICATION_STATUS_SELECTED', '2': 4},
    {'1': 'UPLIFT_APPLICATION_STATUS_ACCEPTED', '2': 5},
    {'1': 'UPLIFT_APPLICATION_STATUS_FUNDING_IN_PROGRESS', '2': 6},
    {'1': 'UPLIFT_APPLICATION_STATUS_COMPLETED', '2': 7},
    {'1': 'UPLIFT_APPLICATION_STATUS_REJECTED', '2': 8},
    {'1': 'UPLIFT_APPLICATION_STATUS_DECLINED', '2': 9},
    {'1': 'UPLIFT_APPLICATION_STATUS_WITHDRAWN', '2': 10},
    {'1': 'UPLIFT_APPLICATION_STATUS_OFFER_EXPIRED', '2': 11},
    {'1': 'UPLIFT_APPLICATION_STATUS_NEGOTIATING', '2': 12},
  ],
};

/// Descriptor for `UpliftApplicationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List upliftApplicationStatusDescriptor = $convert.base64Decode(
    'ChdVcGxpZnRBcHBsaWNhdGlvblN0YXR1cxIpCiVVUExJRlRfQVBQTElDQVRJT05fU1RBVFVTX1'
    'VOU1BFQ0lGSUVEEAASJwojVVBMSUZUX0FQUExJQ0FUSU9OX1NUQVRVU19TVUJNSVRURUQQARIq'
    'CiZVUExJRlRfQVBQTElDQVRJT05fU1RBVFVTX1VOREVSX1JFVklFVxACEikKJVVQTElGVF9BUF'
    'BMSUNBVElPTl9TVEFUVVNfU0hPUlRMSVNURUQQAxImCiJVUExJRlRfQVBQTElDQVRJT05fU1RB'
    'VFVTX1NFTEVDVEVEEAQSJgoiVVBMSUZUX0FQUExJQ0FUSU9OX1NUQVRVU19BQ0NFUFRFRBAFEj'
    'EKLVVQTElGVF9BUFBMSUNBVElPTl9TVEFUVVNfRlVORElOR19JTl9QUk9HUkVTUxAGEicKI1VQ'
    'TElGVF9BUFBMSUNBVElPTl9TVEFUVVNfQ09NUExFVEVEEAcSJgoiVVBMSUZUX0FQUExJQ0FUSU'
    '9OX1NUQVRVU19SRUpFQ1RFRBAIEiYKIlVQTElGVF9BUFBMSUNBVElPTl9TVEFUVVNfREVDTElO'
    'RUQQCRInCiNVUExJRlRfQVBQTElDQVRJT05fU1RBVFVTX1dJVEhEUkFXThAKEisKJ1VQTElGVF'
    '9BUFBMSUNBVElPTl9TVEFUVVNfT0ZGRVJfRVhQSVJFRBALEikKJVVQTElGVF9BUFBMSUNBVElP'
    'Tl9TVEFUVVNfTkVHT1RJQVRJTkcQDA==');

@$core.Deprecated('Use upliftMilestoneStatusDescriptor instead')
const UpliftMilestoneStatus$json = {
  '1': 'UpliftMilestoneStatus',
  '2': [
    {'1': 'UPLIFT_MILESTONE_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'UPLIFT_MILESTONE_STATUS_PLANNED', '2': 1},
    {'1': 'UPLIFT_MILESTONE_STATUS_EVIDENCE_SUBMITTED', '2': 2},
    {'1': 'UPLIFT_MILESTONE_STATUS_APPROVED', '2': 3},
    {'1': 'UPLIFT_MILESTONE_STATUS_PENDING', '2': 4},
    {'1': 'UPLIFT_MILESTONE_STATUS_PROCESSING', '2': 5},
    {'1': 'UPLIFT_MILESTONE_STATUS_RELEASED', '2': 6},
    {'1': 'UPLIFT_MILESTONE_STATUS_REJECTED', '2': 7},
    {'1': 'UPLIFT_MILESTONE_STATUS_FAILED', '2': 8},
    {'1': 'UPLIFT_MILESTONE_STATUS_CLAWED_BACK', '2': 9},
  ],
};

/// Descriptor for `UpliftMilestoneStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List upliftMilestoneStatusDescriptor = $convert.base64Decode(
    'ChVVcGxpZnRNaWxlc3RvbmVTdGF0dXMSJwojVVBMSUZUX01JTEVTVE9ORV9TVEFUVVNfVU5TUE'
    'VDSUZJRUQQABIjCh9VUExJRlRfTUlMRVNUT05FX1NUQVRVU19QTEFOTkVEEAESLgoqVVBMSUZU'
    'X01JTEVTVE9ORV9TVEFUVVNfRVZJREVOQ0VfU1VCTUlUVEVEEAISJAogVVBMSUZUX01JTEVTVE'
    '9ORV9TVEFUVVNfQVBQUk9WRUQQAxIjCh9VUExJRlRfTUlMRVNUT05FX1NUQVRVU19QRU5ESU5H'
    'EAQSJgoiVVBMSUZUX01JTEVTVE9ORV9TVEFUVVNfUFJPQ0VTU0lORxAFEiQKIFVQTElGVF9NSU'
    'xFU1RPTkVfU1RBVFVTX1JFTEVBU0VEEAYSJAogVVBMSUZUX01JTEVTVE9ORV9TVEFUVVNfUkVK'
    'RUNURUQQBxIiCh5VUExJRlRfTUlMRVNUT05FX1NUQVRVU19GQUlMRUQQCBInCiNVUExJRlRfTU'
    'lMRVNUT05FX1NUQVRVU19DTEFXRURfQkFDSxAJ');

@$core.Deprecated('Use upliftFundVisibilityDescriptor instead')
const UpliftFundVisibility$json = {
  '1': 'UpliftFundVisibility',
  '2': [
    {'1': 'UPLIFT_FUND_VISIBILITY_UNSPECIFIED', '2': 0},
    {'1': 'UPLIFT_FUND_VISIBILITY_PUBLIC', '2': 1},
    {'1': 'UPLIFT_FUND_VISIBILITY_PRIVATE', '2': 2},
    {'1': 'UPLIFT_FUND_VISIBILITY_UNLISTED', '2': 3},
  ],
};

/// Descriptor for `UpliftFundVisibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List upliftFundVisibilityDescriptor = $convert.base64Decode(
    'ChRVcGxpZnRGdW5kVmlzaWJpbGl0eRImCiJVUExJRlRfRlVORF9WSVNJQklMSVRZX1VOU1BFQ0'
    'lGSUVEEAASIQodVVBMSUZUX0ZVTkRfVklTSUJJTElUWV9QVUJMSUMQARIiCh5VUExJRlRfRlVO'
    'RF9WSVNJQklMSVRZX1BSSVZBVEUQAhIjCh9VUExJRlRfRlVORF9WSVNJQklMSVRZX1VOTElTVE'
    'VEEAM=');

@$core.Deprecated('Use upliftUserMessageDescriptor instead')
const UpliftUserMessage$json = {
  '1': 'UpliftUserMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'display_name', '3': 5, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'profile_picture', '3': 6, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'verified', '3': 7, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'user_uuid', '3': 8, '4': 1, '5': 9, '10': 'userUuid'},
  ],
};

/// Descriptor for `UpliftUserMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftUserMessageDescriptor = $convert.base64Decode(
    'ChFVcGxpZnRVc2VyTWVzc2FnZRIXCgd1c2VyX2lkGAEgASgEUgZ1c2VySWQSGgoIdXNlcm5hbW'
    'UYAiABKAlSCHVzZXJuYW1lEh0KCmZpcnN0X25hbWUYAyABKAlSCWZpcnN0TmFtZRIbCglsYXN0'
    'X25hbWUYBCABKAlSCGxhc3ROYW1lEiEKDGRpc3BsYXlfbmFtZRgFIAEoCVILZGlzcGxheU5hbW'
    'USJwoPcHJvZmlsZV9waWN0dXJlGAYgASgJUg5wcm9maWxlUGljdHVyZRIaCgh2ZXJpZmllZBgH'
    'IAEoCFIIdmVyaWZpZWQ=');

@$core.Deprecated('Use upliftFundMessageDescriptor instead')
const UpliftFundMessage$json = {
  '1': 'UpliftFundMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'uplift_code', '3': 2, '4': 1, '5': 9, '10': 'upliftCode'},
    {'1': 'funder_user_id', '3': 3, '4': 1, '5': 4, '10': 'funderUserId'},
    {
      '1': 'funder',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftUserMessage',
      '10': 'funder'
    },
    {'1': 'title', '3': 5, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'story', '3': 7, '4': 1, '5': 9, '10': 'story'},
    {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'per_business_cap', '3': 10, '4': 1, '5': 4, '10': 'perBusinessCap'},
    {'1': 'target_count', '3': 11, '4': 1, '5': 5, '10': 'targetCount'},
    {'1': 'committed_pool', '3': 12, '4': 1, '5': 4, '10': 'committedPool'},
    {'1': 'released_total', '3': 13, '4': 1, '5': 4, '10': 'releasedTotal'},
    {'1': 'refunded_total', '3': 14, '4': 1, '5': 4, '10': 'refundedTotal'},
    {
      '1': 'escrow_account_id',
      '3': 15,
      '4': 1,
      '5': 9,
      '10': 'escrowAccountId'
    },
    {
      '1': 'status',
      '3': 16,
      '4': 1,
      '5': 14,
      '6': '.pb.UpliftFundStatus',
      '10': 'status'
    },
    {
      '1': 'visibility',
      '3': 17,
      '4': 1,
      '5': 14,
      '6': '.pb.UpliftFundVisibility',
      '10': 'visibility'
    },
    {'1': 'cover_image_url', '3': 18, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'gallery', '3': 19, '4': 3, '5': 9, '10': 'gallery'},
    {
      '1': 'application_deadline',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'applicationDeadline'
    },
    {
      '1': 'funding_deadline',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'fundingDeadline'
    },
    {
      '1': 'application_count',
      '3': 22,
      '4': 1,
      '5': 5,
      '10': 'applicationCount'
    },
    {'1': 'selected_count', '3': 23, '4': 1, '5': 5, '10': 'selectedCount'},
    {
      '1': 'endorsement_count',
      '3': 24,
      '4': 1,
      '5': 5,
      '10': 'endorsementCount'
    },
    {'1': 'metadata', '3': 25, '4': 1, '5': 9, '10': 'metadata'},
    {
      '1': 'created_at',
      '3': 26,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 27,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {'1': 'cancel_reason', '3': 28, '4': 1, '5': 9, '10': 'cancelReason'},
    {
      '1': 'cancelled_at',
      '3': 29,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'cancelledAt'
    },
    {'1': 'escrow_available', '3': 30, '4': 1, '5': 4, '10': 'escrowAvailable'},
    {'1': 'is_funder', '3': 31, '4': 1, '5': 8, '10': 'isFunder'},
    {
      '1': 'my_application_id',
      '3': 32,
      '4': 1,
      '5': 9,
      '10': 'myApplicationId'
    },
    {
      '1': 'my_application_status',
      '3': 33,
      '4': 1,
      '5': 14,
      '6': '.pb.UpliftApplicationStatus',
      '10': 'myApplicationStatus'
    },
  ],
};

/// Descriptor for `UpliftFundMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftFundMessageDescriptor = $convert.base64Decode(
    'ChFVcGxpZnRGdW5kTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHwoLdXBsaWZ0X2NvZGUYAiABKA'
    'lSCnVwbGlmdENvZGUSJAoOZnVuZGVyX3VzZXJfaWQYAyABKARSDGZ1bmRlclVzZXJJZBItCgZm'
    'dW5kZXIYBCABKAsyFS5wYi5VcGxpZnRVc2VyTWVzc2FnZVIGZnVuZGVyEhQKBXRpdGxlGAUgAS'
    'gJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SFAoFc3RvcnkYByAB'
    'KAlSBXN0b3J5EhoKCGNhdGVnb3J5GAggASgJUghjYXRlZ29yeRIaCghjdXJyZW5jeRgJIAEoCV'
    'IIY3VycmVuY3kSKAoQcGVyX2J1c2luZXNzX2NhcBgKIAEoBFIOcGVyQnVzaW5lc3NDYXASIQoM'
    'dGFyZ2V0X2NvdW50GAsgASgFUgt0YXJnZXRDb3VudBIlCg5jb21taXR0ZWRfcG9vbBgMIAEoBF'
    'INY29tbWl0dGVkUG9vbBIlCg5yZWxlYXNlZF90b3RhbBgNIAEoBFINcmVsZWFzZWRUb3RhbBIl'
    'Cg5yZWZ1bmRlZF90b3RhbBgOIAEoBFINcmVmdW5kZWRUb3RhbBIqChFlc2Nyb3dfYWNjb3VudF'
    '9pZBgPIAEoCVIPZXNjcm93QWNjb3VudElkEiwKBnN0YXR1cxgQIAEoDjIULnBiLlVwbGlmdEZ1'
    'bmRTdGF0dXNSBnN0YXR1cxI4Cgp2aXNpYmlsaXR5GBEgASgOMhgucGIuVXBsaWZ0RnVuZFZpc2'
    'liaWxpdHlSCnZpc2liaWxpdHkSJgoPY292ZXJfaW1hZ2VfdXJsGBIgASgJUg1jb3ZlckltYWdl'
    'VXJsEhgKB2dhbGxlcnkYEyADKAlSB2dhbGxlcnkSTQoUYXBwbGljYXRpb25fZGVhZGxpbmUYFC'
    'ABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUhNhcHBsaWNhdGlvbkRlYWRsaW5lEkUK'
    'EGZ1bmRpbmdfZGVhZGxpbmUYFSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg9mdW'
    '5kaW5nRGVhZGxpbmUSKwoRYXBwbGljYXRpb25fY291bnQYFiABKAVSEGFwcGxpY2F0aW9uQ291'
    'bnQSJQoOc2VsZWN0ZWRfY291bnQYFyABKAVSDXNlbGVjdGVkQ291bnQSKwoRZW5kb3JzZW1lbn'
    'RfY291bnQYGCABKAVSEGVuZG9yc2VtZW50Q291bnQSGgoIbWV0YWRhdGEYGSABKAlSCG1ldGFk'
    'YXRhEjkKCmNyZWF0ZWRfYXQYGiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcm'
    'VhdGVkQXQSOQoKdXBkYXRlZF9hdBgbIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'CXVwZGF0ZWRBdBIjCg1jYW5jZWxfcmVhc29uGBwgASgJUgxjYW5jZWxSZWFzb24SPQoMY2FuY2'
    'VsbGVkX2F0GB0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILY2FuY2VsbGVkQXQS'
    'KQoQZXNjcm93X2F2YWlsYWJsZRgeIAEoBFIPZXNjcm93QXZhaWxhYmxlEhsKCWlzX2Z1bmRlch'
    'gfIAEoCFIIaXNGdW5kZXISKgoRbXlfYXBwbGljYXRpb25faWQYICABKAlSD215QXBwbGljYXRp'
    'b25JZBJPChVteV9hcHBsaWNhdGlvbl9zdGF0dXMYISABKA4yGy5wYi5VcGxpZnRBcHBsaWNhdG'
    'lvblN0YXR1c1ITbXlBcHBsaWNhdGlvblN0YXR1cw==');

@$core.Deprecated('Use upliftApplicationMessageDescriptor instead')
const UpliftApplicationMessage$json = {
  '1': 'UpliftApplicationMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'fund_id', '3': 2, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'applicant_user_id', '3': 3, '4': 1, '5': 4, '10': 'applicantUserId'},
    {
      '1': 'applicant',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftUserMessage',
      '10': 'applicant'
    },
    {'1': 'business_name', '3': 5, '4': 1, '5': 9, '10': 'businessName'},
    {
      '1': 'business_category',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'businessCategory'
    },
    {'1': 'pitch', '3': 7, '4': 1, '5': 9, '10': 'pitch'},
    {'1': 'requested_amount', '3': 8, '4': 1, '5': 4, '10': 'requestedAmount'},
    {'1': 'approved_amount', '3': 9, '4': 1, '5': 4, '10': 'approvedAmount'},
    {
      '1': 'status',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.pb.UpliftApplicationStatus',
      '10': 'status'
    },
    {'1': 'images', '3': 11, '4': 3, '5': 9, '10': 'images'},
    {'1': 'doc_urls', '3': 12, '4': 3, '5': 9, '10': 'docUrls'},
    {
      '1': 'endorsement_count',
      '3': 13,
      '4': 1,
      '5': 5,
      '10': 'endorsementCount'
    },
    {
      '1': 'viewer_has_endorsed',
      '3': 14,
      '4': 1,
      '5': 8,
      '10': 'viewerHasEndorsed'
    },
    {
      '1': 'business_account_id',
      '3': 15,
      '4': 1,
      '5': 9,
      '10': 'businessAccountId'
    },
    {
      '1': 'offer_expires_at',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'offerExpiresAt'
    },
    {'1': 'reject_reason', '3': 17, '4': 1, '5': 9, '10': 'rejectReason'},
    {
      '1': 'milestones',
      '3': 18,
      '4': 3,
      '5': 11,
      '6': '.pb.UpliftMilestoneMessage',
      '10': 'milestones'
    },
    {
      '1': 'created_at',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {'1': 'fund_title', '3': 21, '4': 1, '5': 9, '10': 'fundTitle'},
    {'1': 'currency', '3': 22, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'proposed_equity_pct',
      '3': 23,
      '4': 1,
      '5': 13,
      '10': 'proposedEquityPct'
    },
    {
      '1': 'agreed_equity_pct',
      '3': 24,
      '4': 1,
      '5': 13,
      '10': 'agreedEquityPct'
    },
    {'1': 'equity_note', '3': 25, '4': 1, '5': 9, '10': 'equityNote'},
    {'1': 'investment_type', '3': 26, '4': 1, '5': 9, '10': 'investmentType'},
    {'1': 'counter_amount', '3': 27, '4': 1, '5': 4, '10': 'counterAmount'},
    {
      '1': 'counter_equity_pct',
      '3': 28,
      '4': 1,
      '5': 13,
      '10': 'counterEquityPct'
    },
    {'1': 'counter_note', '3': 29, '4': 1, '5': 9, '10': 'counterNote'},
    {'1': 'has_counter', '3': 30, '4': 1, '5': 8, '10': 'hasCounter'},
  ],
};

/// Descriptor for `UpliftApplicationMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftApplicationMessageDescriptor = $convert.base64Decode(
    'ChhVcGxpZnRBcHBsaWNhdGlvbk1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhcKB2Z1bmRfaWQYAi'
    'ABKAlSBmZ1bmRJZBIqChFhcHBsaWNhbnRfdXNlcl9pZBgDIAEoBFIPYXBwbGljYW50VXNlcklk'
    'EjMKCWFwcGxpY2FudBgEIAEoCzIVLnBiLlVwbGlmdFVzZXJNZXNzYWdlUglhcHBsaWNhbnQSIw'
    'oNYnVzaW5lc3NfbmFtZRgFIAEoCVIMYnVzaW5lc3NOYW1lEisKEWJ1c2luZXNzX2NhdGVnb3J5'
    'GAYgASgJUhBidXNpbmVzc0NhdGVnb3J5EhQKBXBpdGNoGAcgASgJUgVwaXRjaBIpChByZXF1ZX'
    'N0ZWRfYW1vdW50GAggASgEUg9yZXF1ZXN0ZWRBbW91bnQSJwoPYXBwcm92ZWRfYW1vdW50GAkg'
    'ASgEUg5hcHByb3ZlZEFtb3VudBIzCgZzdGF0dXMYCiABKA4yGy5wYi5VcGxpZnRBcHBsaWNhdG'
    'lvblN0YXR1c1IGc3RhdHVzEhYKBmltYWdlcxgLIAMoCVIGaW1hZ2VzEhkKCGRvY191cmxzGAwg'
    'AygJUgdkb2NVcmxzEisKEWVuZG9yc2VtZW50X2NvdW50GA0gASgFUhBlbmRvcnNlbWVudENvdW'
    '50Ei4KE3ZpZXdlcl9oYXNfZW5kb3JzZWQYDiABKAhSEXZpZXdlckhhc0VuZG9yc2VkEi4KE2J1'
    'c2luZXNzX2FjY291bnRfaWQYDyABKAlSEWJ1c2luZXNzQWNjb3VudElkEkQKEG9mZmVyX2V4cG'
    'lyZXNfYXQYECABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg5vZmZlckV4cGlyZXNB'
    'dBIjCg1yZWplY3RfcmVhc29uGBEgASgJUgxyZWplY3RSZWFzb24SOgoKbWlsZXN0b25lcxgSIA'
    'MoCzIaLnBiLlVwbGlmdE1pbGVzdG9uZU1lc3NhZ2VSCm1pbGVzdG9uZXMSOQoKY3JlYXRlZF9h'
    'dBgTIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdG'
    'VkX2F0GBQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0Eh0KCmZ1'
    'bmRfdGl0bGUYFSABKAlSCWZ1bmRUaXRsZRIaCghjdXJyZW5jeRgWIAEoCVIIY3VycmVuY3kSLg'
    'oTcHJvcG9zZWRfZXF1aXR5X3BjdBgXIAEoDVIRcHJvcG9zZWRFcXVpdHlQY3QSKgoRYWdyZWVk'
    'X2VxdWl0eV9wY3QYGCABKA1SD2FncmVlZEVxdWl0eVBjdBIfCgtlcXVpdHlfbm90ZRgZIAEoCV'
    'IKZXF1aXR5Tm90ZRInCg9pbnZlc3RtZW50X3R5cGUYGiABKAlSDmludmVzdG1lbnRUeXBlEiUK'
    'DmNvdW50ZXJfYW1vdW50GBsgASgEUg1jb3VudGVyQW1vdW50EiwKEmNvdW50ZXJfZXF1aXR5X3'
    'BjdBgcIAEoDVIQY291bnRlckVxdWl0eVBjdBIhCgxjb3VudGVyX25vdGUYHSABKAlSC2NvdW50'
    'ZXJOb3RlEh8KC2hhc19jb3VudGVyGB4gASgIUgpoYXNDb3VudGVy');

@$core.Deprecated('Use upliftMilestoneMessageDescriptor instead')
const UpliftMilestoneMessage$json = {
  '1': 'UpliftMilestoneMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'application_id', '3': 2, '4': 1, '5': 9, '10': 'applicationId'},
    {'1': 'fund_id', '3': 3, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'sequence', '3': 4, '4': 1, '5': 5, '10': 'sequence'},
    {'1': 'title', '3': 5, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'amount', '3': 7, '4': 1, '5': 4, '10': 'amount'},
    {
      '1': 'status',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.pb.UpliftMilestoneStatus',
      '10': 'status'
    },
    {'1': 'evidence', '3': 9, '4': 3, '5': 9, '10': 'evidence'},
    {'1': 'evidence_note', '3': 10, '4': 1, '5': 9, '10': 'evidenceNote'},
    {'1': 'reject_reason', '3': 11, '4': 1, '5': 9, '10': 'rejectReason'},
    {'1': 'release_id', '3': 12, '4': 1, '5': 9, '10': 'releaseId'},
    {
      '1': 'approved_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'approvedAt'
    },
    {
      '1': 'released_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'releasedAt'
    },
    {
      '1': 'created_at',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `UpliftMilestoneMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftMilestoneMessageDescriptor = $convert.base64Decode(
    'ChZVcGxpZnRNaWxlc3RvbmVNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIlCg5hcHBsaWNhdGlvbl'
    '9pZBgCIAEoCVINYXBwbGljYXRpb25JZBIXCgdmdW5kX2lkGAMgASgJUgZmdW5kSWQSGgoIc2Vx'
    'dWVuY2UYBCABKAVSCHNlcXVlbmNlEhQKBXRpdGxlGAUgASgJUgV0aXRsZRIgCgtkZXNjcmlwdG'
    'lvbhgGIAEoCVILZGVzY3JpcHRpb24SFgoGYW1vdW50GAcgASgEUgZhbW91bnQSMQoGc3RhdHVz'
    'GAggASgOMhkucGIuVXBsaWZ0TWlsZXN0b25lU3RhdHVzUgZzdGF0dXMSGgoIZXZpZGVuY2UYCS'
    'ADKAlSCGV2aWRlbmNlEiMKDWV2aWRlbmNlX25vdGUYCiABKAlSDGV2aWRlbmNlTm90ZRIjCg1y'
    'ZWplY3RfcmVhc29uGAsgASgJUgxyZWplY3RSZWFzb24SHQoKcmVsZWFzZV9pZBgMIAEoCVIJcm'
    'VsZWFzZUlkEjsKC2FwcHJvdmVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIKYXBwcm92ZWRBdBI7CgtyZWxlYXNlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSCnJlbGVhc2VkQXQSOQoKY3JlYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1'
    'Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBAgASgLMhouZ29vZ2xlLnByb3'
    'RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use upliftMilestoneReleaseRecordDescriptor instead')
const UpliftMilestoneReleaseRecord$json = {
  '1': 'UpliftMilestoneReleaseRecord',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'milestone_id', '3': 2, '4': 1, '5': 9, '10': 'milestoneId'},
    {'1': 'application_id', '3': 3, '4': 1, '5': 9, '10': 'applicationId'},
    {'1': 'fund_id', '3': 4, '4': 1, '5': 9, '10': 'fundId'},
    {
      '1': 'business_account_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'businessAccountId'
    },
    {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    {'1': 'attempt_count', '3': 8, '4': 1, '5': 5, '10': 'attemptCount'},
    {'1': 'last_error', '3': 9, '4': 1, '5': 9, '10': 'lastError'},
    {'1': 'debit_reference', '3': 10, '4': 1, '5': 9, '10': 'debitReference'},
    {'1': 'credit_reference', '3': 11, '4': 1, '5': 9, '10': 'creditReference'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `UpliftMilestoneReleaseRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftMilestoneReleaseRecordDescriptor = $convert.base64Decode(
    'ChxVcGxpZnRNaWxlc3RvbmVSZWxlYXNlUmVjb3JkEg4KAmlkGAEgASgJUgJpZBIhCgxtaWxlc3'
    'RvbmVfaWQYAiABKAlSC21pbGVzdG9uZUlkEiUKDmFwcGxpY2F0aW9uX2lkGAMgASgJUg1hcHBs'
    'aWNhdGlvbklkEhcKB2Z1bmRfaWQYBCABKAlSBmZ1bmRJZBIuChNidXNpbmVzc19hY2NvdW50X2'
    'lkGAUgASgJUhFidXNpbmVzc0FjY291bnRJZBIWCgZhbW91bnQYBiABKARSBmFtb3VudBIWCgZz'
    'dGF0dXMYByABKAlSBnN0YXR1cxIjCg1hdHRlbXB0X2NvdW50GAggASgFUgxhdHRlbXB0Q291bn'
    'QSHQoKbGFzdF9lcnJvchgJIAEoCVIJbGFzdEVycm9yEicKD2RlYml0X3JlZmVyZW5jZRgKIAEo'
    'CVIOZGViaXRSZWZlcmVuY2USKQoQY3JlZGl0X3JlZmVyZW5jZRgLIAEoCVIPY3JlZGl0UmVmZX'
    'JlbmNlEh0KCmNyZWF0ZWRfYXQYDCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GA0gASgJ'
    'Ugl1cGRhdGVkQXQ=');

@$core.Deprecated('Use upliftEscrowRefundRecordDescriptor instead')
const UpliftEscrowRefundRecord$json = {
  '1': 'UpliftEscrowRefundRecord',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'fund_id', '3': 2, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'attempt_count', '3': 5, '4': 1, '5': 5, '10': 'attemptCount'},
    {'1': 'last_error', '3': 6, '4': 1, '5': 9, '10': 'lastError'},
    {'1': 'reason', '3': 7, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `UpliftEscrowRefundRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftEscrowRefundRecordDescriptor = $convert.base64Decode(
    'ChhVcGxpZnRFc2Nyb3dSZWZ1bmRSZWNvcmQSDgoCaWQYASABKAlSAmlkEhcKB2Z1bmRfaWQYAi'
    'ABKAlSBmZ1bmRJZBIWCgZhbW91bnQYAyABKARSBmFtb3VudBIWCgZzdGF0dXMYBCABKAlSBnN0'
    'YXR1cxIjCg1hdHRlbXB0X2NvdW50GAUgASgFUgxhdHRlbXB0Q291bnQSHQoKbGFzdF9lcnJvch'
    'gGIAEoCVIJbGFzdEVycm9yEhYKBnJlYXNvbhgHIAEoCVIGcmVhc29uEh0KCmNyZWF0ZWRfYXQY'
    'CCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAkgASgJUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use upliftReceiptMessageDescriptor instead')
const UpliftReceiptMessage$json = {
  '1': 'UpliftReceiptMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference_id', '3': 2, '4': 1, '5': 9, '10': 'referenceId'},
    {'1': 'reference_type', '3': 3, '4': 1, '5': 9, '10': 'referenceType'},
    {'1': 'fund_id', '3': 4, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'fund_title', '3': 5, '4': 1, '5': 9, '10': 'fundTitle'},
    {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'receipt_number', '3': 8, '4': 1, '5': 9, '10': 'receiptNumber'},
    {'1': 'receipt_data', '3': 9, '4': 1, '5': 9, '10': 'receiptData'},
    {
      '1': 'generated_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'generatedAt'
    },
  ],
};

/// Descriptor for `UpliftReceiptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftReceiptMessageDescriptor = $convert.base64Decode(
    'ChRVcGxpZnRSZWNlaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSIQoMcmVmZXJlbmNlX2lkGA'
    'IgASgJUgtyZWZlcmVuY2VJZBIlCg5yZWZlcmVuY2VfdHlwZRgDIAEoCVINcmVmZXJlbmNlVHlw'
    'ZRIXCgdmdW5kX2lkGAQgASgJUgZmdW5kSWQSHQoKZnVuZF90aXRsZRgFIAEoCVIJZnVuZFRpdG'
    'xlEhYKBmFtb3VudBgGIAEoBFIGYW1vdW50EhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIl'
    'Cg5yZWNlaXB0X251bWJlchgIIAEoCVINcmVjZWlwdE51bWJlchIhCgxyZWNlaXB0X2RhdGEYCS'
    'ABKAlSC3JlY2VpcHREYXRhEj0KDGdlbmVyYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1'
    'Zi5UaW1lc3RhbXBSC2dlbmVyYXRlZEF0');

@$core.Deprecated('Use upliftPaginationInfoDescriptor instead')
const UpliftPaginationInfo$json = {
  '1': 'UpliftPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `UpliftPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftPaginationInfoDescriptor = $convert.base64Decode(
    'ChRVcGxpZnRQYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYW'
    'dlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMgASgF'
    'Ugp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQoIaG'
    'FzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');

@$core.Deprecated('Use createUpliftFundRequestDescriptor instead')
const CreateUpliftFundRequest$json = {
  '1': 'CreateUpliftFundRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'story', '3': 3, '4': 1, '5': 9, '10': 'story'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'per_business_cap', '3': 6, '4': 1, '5': 4, '10': 'perBusinessCap'},
    {'1': 'target_count', '3': 7, '4': 1, '5': 5, '10': 'targetCount'},
    {
      '1': 'application_deadline',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'applicationDeadline'
    },
    {
      '1': 'funding_deadline',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'fundingDeadline'
    },
    {'1': 'cover_image_url', '3': 10, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'gallery', '3': 11, '4': 3, '5': 9, '10': 'gallery'},
    {
      '1': 'visibility',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.pb.UpliftFundVisibility',
      '10': 'visibility'
    },
    {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'publish_now', '3': 14, '4': 1, '5': 8, '10': 'publishNow'},
  ],
};

/// Descriptor for `CreateUpliftFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpliftFundRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVVcGxpZnRGdW5kUmVxdWVzdBIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSIAoLZGVzY3'
    'JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEhQKBXN0b3J5GAMgASgJUgVzdG9yeRIaCghjYXRl'
    'Z29yeRgEIAEoCVIIY2F0ZWdvcnkSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EigKEHBlcl'
    '9idXNpbmVzc19jYXAYBiABKARSDnBlckJ1c2luZXNzQ2FwEiEKDHRhcmdldF9jb3VudBgHIAEo'
    'BVILdGFyZ2V0Q291bnQSTQoUYXBwbGljYXRpb25fZGVhZGxpbmUYCCABKAsyGi5nb29nbGUucH'
    'JvdG9idWYuVGltZXN0YW1wUhNhcHBsaWNhdGlvbkRlYWRsaW5lEkUKEGZ1bmRpbmdfZGVhZGxp'
    'bmUYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg9mdW5kaW5nRGVhZGxpbmUSJg'
    'oPY292ZXJfaW1hZ2VfdXJsGAogASgJUg1jb3ZlckltYWdlVXJsEhgKB2dhbGxlcnkYCyADKAlS'
    'B2dhbGxlcnkSOAoKdmlzaWJpbGl0eRgMIAEoDjIYLnBiLlVwbGlmdEZ1bmRWaXNpYmlsaXR5Ug'
    'p2aXNpYmlsaXR5EhoKCG1ldGFkYXRhGA0gASgJUghtZXRhZGF0YRIfCgtwdWJsaXNoX25vdxgO'
    'IAEoCFIKcHVibGlzaE5vdw==');

@$core.Deprecated('Use createUpliftFundResponseDescriptor instead')
const CreateUpliftFundResponse$json = {
  '1': 'CreateUpliftFundResponse',
  '2': [
    {
      '1': 'fund',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'fund'
    },
  ],
};

/// Descriptor for `CreateUpliftFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpliftFundResponseDescriptor =
    $convert.base64Decode(
        'ChhDcmVhdGVVcGxpZnRGdW5kUmVzcG9uc2USKQoEZnVuZBgBIAEoCzIVLnBiLlVwbGlmdEZ1bm'
        'RNZXNzYWdlUgRmdW5k');

@$core.Deprecated('Use updateUpliftFundRequestDescriptor instead')
const UpdateUpliftFundRequest$json = {
  '1': 'UpdateUpliftFundRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'story', '3': 4, '4': 1, '5': 9, '10': 'story'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'per_business_cap', '3': 6, '4': 1, '5': 4, '10': 'perBusinessCap'},
    {'1': 'target_count', '3': 7, '4': 1, '5': 5, '10': 'targetCount'},
    {
      '1': 'application_deadline',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'applicationDeadline'
    },
    {
      '1': 'funding_deadline',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'fundingDeadline'
    },
    {'1': 'cover_image_url', '3': 10, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'gallery', '3': 11, '4': 3, '5': 9, '10': 'gallery'},
    {
      '1': 'visibility',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.pb.UpliftFundVisibility',
      '10': 'visibility'
    },
    {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `UpdateUpliftFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUpliftFundRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVVcGxpZnRGdW5kUmVxdWVzdBIXCgdmdW5kX2lkGAEgASgJUgZmdW5kSWQSFAoFdG'
    'l0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIUCgVz'
    'dG9yeRgEIAEoCVIFc3RvcnkSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EigKEHBlcl9idX'
    'NpbmVzc19jYXAYBiABKARSDnBlckJ1c2luZXNzQ2FwEiEKDHRhcmdldF9jb3VudBgHIAEoBVIL'
    'dGFyZ2V0Q291bnQSTQoUYXBwbGljYXRpb25fZGVhZGxpbmUYCCABKAsyGi5nb29nbGUucHJvdG'
    '9idWYuVGltZXN0YW1wUhNhcHBsaWNhdGlvbkRlYWRsaW5lEkUKEGZ1bmRpbmdfZGVhZGxpbmUY'
    'CSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg9mdW5kaW5nRGVhZGxpbmUSJgoPY2'
    '92ZXJfaW1hZ2VfdXJsGAogASgJUg1jb3ZlckltYWdlVXJsEhgKB2dhbGxlcnkYCyADKAlSB2dh'
    'bGxlcnkSOAoKdmlzaWJpbGl0eRgMIAEoDjIYLnBiLlVwbGlmdEZ1bmRWaXNpYmlsaXR5Ugp2aX'
    'NpYmlsaXR5EhoKCG1ldGFkYXRhGA0gASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use updateUpliftFundResponseDescriptor instead')
const UpdateUpliftFundResponse$json = {
  '1': 'UpdateUpliftFundResponse',
  '2': [
    {
      '1': 'fund',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'fund'
    },
  ],
};

/// Descriptor for `UpdateUpliftFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUpliftFundResponseDescriptor =
    $convert.base64Decode(
        'ChhVcGRhdGVVcGxpZnRGdW5kUmVzcG9uc2USKQoEZnVuZBgBIAEoCzIVLnBiLlVwbGlmdEZ1bm'
        'RNZXNzYWdlUgRmdW5k');

@$core.Deprecated('Use publishUpliftFundRequestDescriptor instead')
const PublishUpliftFundRequest$json = {
  '1': 'PublishUpliftFundRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
  ],
};

/// Descriptor for `PublishUpliftFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishUpliftFundRequestDescriptor =
    $convert.base64Decode(
        'ChhQdWJsaXNoVXBsaWZ0RnVuZFJlcXVlc3QSFwoHZnVuZF9pZBgBIAEoCVIGZnVuZElk');

@$core.Deprecated('Use publishUpliftFundResponseDescriptor instead')
const PublishUpliftFundResponse$json = {
  '1': 'PublishUpliftFundResponse',
  '2': [
    {
      '1': 'fund',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'fund'
    },
  ],
};

/// Descriptor for `PublishUpliftFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishUpliftFundResponseDescriptor =
    $convert.base64Decode(
        'ChlQdWJsaXNoVXBsaWZ0RnVuZFJlc3BvbnNlEikKBGZ1bmQYASABKAsyFS5wYi5VcGxpZnRGdW'
        '5kTWVzc2FnZVIEZnVuZA==');

@$core.Deprecated('Use getUpliftFundRequestDescriptor instead')
const GetUpliftFundRequest$json = {
  '1': 'GetUpliftFundRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
  ],
};

/// Descriptor for `GetUpliftFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftFundRequestDescriptor =
    $convert.base64Decode(
        'ChRHZXRVcGxpZnRGdW5kUmVxdWVzdBIXCgdmdW5kX2lkGAEgASgJUgZmdW5kSWQ=');

@$core.Deprecated('Use getUpliftFundResponseDescriptor instead')
const GetUpliftFundResponse$json = {
  '1': 'GetUpliftFundResponse',
  '2': [
    {
      '1': 'fund',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'fund'
    },
  ],
};

/// Descriptor for `GetUpliftFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftFundResponseDescriptor = $convert.base64Decode(
    'ChVHZXRVcGxpZnRGdW5kUmVzcG9uc2USKQoEZnVuZBgBIAEoCzIVLnBiLlVwbGlmdEZ1bmRNZX'
    'NzYWdlUgRmdW5k');

@$core.Deprecated('Use listUpliftFundsRequestDescriptor instead')
const ListUpliftFundsRequest$json = {
  '1': 'ListUpliftFundsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'query', '3': 5, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `ListUpliftFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftFundsRequestDescriptor = $convert.base64Decode(
    'ChZMaXN0VXBsaWZ0RnVuZHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGwoJcGFnZV9zaX'
    'plGAIgASgFUghwYWdlU2l6ZRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIaCghjYXRlZ29yeRgE'
    'IAEoCVIIY2F0ZWdvcnkSFAoFcXVlcnkYBSABKAlSBXF1ZXJ5');

@$core.Deprecated('Use listUpliftFundsResponseDescriptor instead')
const ListUpliftFundsResponse$json = {
  '1': 'ListUpliftFundsResponse',
  '2': [
    {
      '1': 'funds',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'funds'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftPaginationInfo',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `ListUpliftFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftFundsResponseDescriptor = $convert.base64Decode(
    'ChdMaXN0VXBsaWZ0RnVuZHNSZXNwb25zZRIrCgVmdW5kcxgBIAMoCzIVLnBiLlVwbGlmdEZ1bm'
    'RNZXNzYWdlUgVmdW5kcxI4CgpwYWdpbmF0aW9uGAIgASgLMhgucGIuVXBsaWZ0UGFnaW5hdGlv'
    'bkluZm9SCnBhZ2luYXRpb24=');

@$core.Deprecated('Use getMyUpliftFundsRequestDescriptor instead')
const GetMyUpliftFundsRequest$json = {
  '1': 'GetMyUpliftFundsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetMyUpliftFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyUpliftFundsRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRNeVVwbGlmdEZ1bmRzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2'
        'l6ZRgCIAEoBVIIcGFnZVNpemUSFgoGc3RhdHVzGAMgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use getMyUpliftFundsResponseDescriptor instead')
const GetMyUpliftFundsResponse$json = {
  '1': 'GetMyUpliftFundsResponse',
  '2': [
    {
      '1': 'funds',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'funds'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftPaginationInfo',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `GetMyUpliftFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyUpliftFundsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRNeVVwbGlmdEZ1bmRzUmVzcG9uc2USKwoFZnVuZHMYASADKAsyFS5wYi5VcGxpZnRGdW'
    '5kTWVzc2FnZVIFZnVuZHMSOAoKcGFnaW5hdGlvbhgCIAEoCzIYLnBiLlVwbGlmdFBhZ2luYXRp'
    'b25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use pauseUpliftFundRequestDescriptor instead')
const PauseUpliftFundRequest$json = {
  '1': 'PauseUpliftFundRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'resume', '3': 2, '4': 1, '5': 8, '10': 'resume'},
  ],
};

/// Descriptor for `PauseUpliftFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseUpliftFundRequestDescriptor =
    $convert.base64Decode(
        'ChZQYXVzZVVwbGlmdEZ1bmRSZXF1ZXN0EhcKB2Z1bmRfaWQYASABKAlSBmZ1bmRJZBIWCgZyZX'
        'N1bWUYAiABKAhSBnJlc3VtZQ==');

@$core.Deprecated('Use pauseUpliftFundResponseDescriptor instead')
const PauseUpliftFundResponse$json = {
  '1': 'PauseUpliftFundResponse',
  '2': [
    {
      '1': 'fund',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'fund'
    },
  ],
};

/// Descriptor for `PauseUpliftFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseUpliftFundResponseDescriptor =
    $convert.base64Decode(
        'ChdQYXVzZVVwbGlmdEZ1bmRSZXNwb25zZRIpCgRmdW5kGAEgASgLMhUucGIuVXBsaWZ0RnVuZE'
        '1lc3NhZ2VSBGZ1bmQ=');

@$core.Deprecated('Use cancelUpliftFundRequestDescriptor instead')
const CancelUpliftFundRequest$json = {
  '1': 'CancelUpliftFundRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `CancelUpliftFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelUpliftFundRequestDescriptor = $convert.base64Decode(
    'ChdDYW5jZWxVcGxpZnRGdW5kUmVxdWVzdBIXCgdmdW5kX2lkGAEgASgJUgZmdW5kSWQSFgoGcm'
    'Vhc29uGAIgASgJUgZyZWFzb24SJwoPdHJhbnNhY3Rpb25fcGluGAMgASgJUg50cmFuc2FjdGlv'
    'blBpbhIlCg50cmFuc2FjdGlvbl9pZBgEIAEoCVINdHJhbnNhY3Rpb25JZA==');

@$core.Deprecated('Use cancelUpliftFundResponseDescriptor instead')
const CancelUpliftFundResponse$json = {
  '1': 'CancelUpliftFundResponse',
  '2': [
    {
      '1': 'fund',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'fund'
    },
    {'1': 'refund_amount', '3': 2, '4': 1, '5': 4, '10': 'refundAmount'},
    {
      '1': 'applications_rejected',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'applicationsRejected'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelUpliftFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelUpliftFundResponseDescriptor = $convert.base64Decode(
    'ChhDYW5jZWxVcGxpZnRGdW5kUmVzcG9uc2USKQoEZnVuZBgBIAEoCzIVLnBiLlVwbGlmdEZ1bm'
    'RNZXNzYWdlUgRmdW5kEiMKDXJlZnVuZF9hbW91bnQYAiABKARSDHJlZnVuZEFtb3VudBIzChVh'
    'cHBsaWNhdGlvbnNfcmVqZWN0ZWQYAyABKAVSFGFwcGxpY2F0aW9uc1JlamVjdGVkEhgKB21lc3'
    'NhZ2UYBCABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use commitUpliftPoolRequestDescriptor instead')
const CommitUpliftPoolRequest$json = {
  '1': 'CommitUpliftPoolRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'source_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'transaction_pin', '3': 4, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `CommitUpliftPoolRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitUpliftPoolRequestDescriptor = $convert.base64Decode(
    'ChdDb21taXRVcGxpZnRQb29sUmVxdWVzdBIXCgdmdW5kX2lkGAEgASgJUgZmdW5kSWQSFgoGYW'
    '1vdW50GAIgASgEUgZhbW91bnQSKgoRc291cmNlX2FjY291bnRfaWQYAyABKAlSD3NvdXJjZUFj'
    'Y291bnRJZBInCg90cmFuc2FjdGlvbl9waW4YBCABKAlSDnRyYW5zYWN0aW9uUGluEiUKDnRyYW'
    '5zYWN0aW9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklk');

@$core.Deprecated('Use commitUpliftPoolResponseDescriptor instead')
const CommitUpliftPoolResponse$json = {
  '1': 'CommitUpliftPoolResponse',
  '2': [
    {
      '1': 'fund',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftFundMessage',
      '10': 'fund'
    },
    {'1': 'committed_pool', '3': 2, '4': 1, '5': 4, '10': 'committedPool'},
    {'1': 'escrow_available', '3': 3, '4': 1, '5': 4, '10': 'escrowAvailable'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CommitUpliftPoolResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitUpliftPoolResponseDescriptor = $convert.base64Decode(
    'ChhDb21taXRVcGxpZnRQb29sUmVzcG9uc2USKQoEZnVuZBgBIAEoCzIVLnBiLlVwbGlmdEZ1bm'
    'RNZXNzYWdlUgRmdW5kEiUKDmNvbW1pdHRlZF9wb29sGAIgASgEUg1jb21taXR0ZWRQb29sEikK'
    'EGVzY3Jvd19hdmFpbGFibGUYAyABKARSD2VzY3Jvd0F2YWlsYWJsZRIYCgdtZXNzYWdlGAQgAS'
    'gJUgdtZXNzYWdl');

@$core.Deprecated('Use getUpliftEscrowBalanceRequestDescriptor instead')
const GetUpliftEscrowBalanceRequest$json = {
  '1': 'GetUpliftEscrowBalanceRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
  ],
};

/// Descriptor for `GetUpliftEscrowBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftEscrowBalanceRequestDescriptor =
    $convert.base64Decode(
        'Ch1HZXRVcGxpZnRFc2Nyb3dCYWxhbmNlUmVxdWVzdBIXCgdmdW5kX2lkGAEgASgJUgZmdW5kSW'
        'Q=');

@$core.Deprecated('Use getUpliftEscrowBalanceResponseDescriptor instead')
const GetUpliftEscrowBalanceResponse$json = {
  '1': 'GetUpliftEscrowBalanceResponse',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'escrow_account_id', '3': 2, '4': 1, '5': 9, '10': 'escrowAccountId'},
    {'1': 'committed_pool', '3': 3, '4': 1, '5': 4, '10': 'committedPool'},
    {'1': 'released_total', '3': 4, '4': 1, '5': 4, '10': 'releasedTotal'},
    {'1': 'refunded_total', '3': 5, '4': 1, '5': 4, '10': 'refundedTotal'},
    {'1': 'balance', '3': 6, '4': 1, '5': 4, '10': 'balance'},
    {'1': 'available', '3': 7, '4': 1, '5': 4, '10': 'available'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetUpliftEscrowBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftEscrowBalanceResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRVcGxpZnRFc2Nyb3dCYWxhbmNlUmVzcG9uc2USFwoHZnVuZF9pZBgBIAEoCVIGZnVuZE'
    'lkEioKEWVzY3Jvd19hY2NvdW50X2lkGAIgASgJUg9lc2Nyb3dBY2NvdW50SWQSJQoOY29tbWl0'
    'dGVkX3Bvb2wYAyABKARSDWNvbW1pdHRlZFBvb2wSJQoOcmVsZWFzZWRfdG90YWwYBCABKARSDX'
    'JlbGVhc2VkVG90YWwSJQoOcmVmdW5kZWRfdG90YWwYBSABKARSDXJlZnVuZGVkVG90YWwSGAoH'
    'YmFsYW5jZRgGIAEoBFIHYmFsYW5jZRIcCglhdmFpbGFibGUYByABKARSCWF2YWlsYWJsZRIaCg'
    'hjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3k=');

@$core.Deprecated('Use applyToUpliftFundRequestDescriptor instead')
const ApplyToUpliftFundRequest$json = {
  '1': 'ApplyToUpliftFundRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'business_name', '3': 2, '4': 1, '5': 9, '10': 'businessName'},
    {
      '1': 'business_category',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'businessCategory'
    },
    {'1': 'pitch', '3': 4, '4': 1, '5': 9, '10': 'pitch'},
    {'1': 'requested_amount', '3': 5, '4': 1, '5': 4, '10': 'requestedAmount'},
    {'1': 'images', '3': 6, '4': 3, '5': 9, '10': 'images'},
    {'1': 'doc_urls', '3': 7, '4': 3, '5': 9, '10': 'docUrls'},
    {
      '1': 'business_account_id',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'businessAccountId'
    },
    {
      '1': 'proposed_equity_pct',
      '3': 9,
      '4': 1,
      '5': 13,
      '10': 'proposedEquityPct'
    },
    {'1': 'equity_note', '3': 10, '4': 1, '5': 9, '10': 'equityNote'},
  ],
};

/// Descriptor for `ApplyToUpliftFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List applyToUpliftFundRequestDescriptor = $convert.base64Decode(
    'ChhBcHBseVRvVXBsaWZ0RnVuZFJlcXVlc3QSFwoHZnVuZF9pZBgBIAEoCVIGZnVuZElkEiMKDW'
    'J1c2luZXNzX25hbWUYAiABKAlSDGJ1c2luZXNzTmFtZRIrChFidXNpbmVzc19jYXRlZ29yeRgD'
    'IAEoCVIQYnVzaW5lc3NDYXRlZ29yeRIUCgVwaXRjaBgEIAEoCVIFcGl0Y2gSKQoQcmVxdWVzdG'
    'VkX2Ftb3VudBgFIAEoBFIPcmVxdWVzdGVkQW1vdW50EhYKBmltYWdlcxgGIAMoCVIGaW1hZ2Vz'
    'EhkKCGRvY191cmxzGAcgAygJUgdkb2NVcmxzEi4KE2J1c2luZXNzX2FjY291bnRfaWQYCCABKA'
    'lSEWJ1c2luZXNzQWNjb3VudElkEi4KE3Byb3Bvc2VkX2VxdWl0eV9wY3QYCSABKA1SEXByb3Bv'
    'c2VkRXF1aXR5UGN0Eh8KC2VxdWl0eV9ub3RlGAogASgJUgplcXVpdHlOb3Rl');

@$core.Deprecated('Use applyToUpliftFundResponseDescriptor instead')
const ApplyToUpliftFundResponse$json = {
  '1': 'ApplyToUpliftFundResponse',
  '2': [
    {
      '1': 'application',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftApplicationMessage',
      '10': 'application'
    },
  ],
};

/// Descriptor for `ApplyToUpliftFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List applyToUpliftFundResponseDescriptor =
    $convert.base64Decode(
        'ChlBcHBseVRvVXBsaWZ0RnVuZFJlc3BvbnNlEj4KC2FwcGxpY2F0aW9uGAEgASgLMhwucGIuVX'
        'BsaWZ0QXBwbGljYXRpb25NZXNzYWdlUgthcHBsaWNhdGlvbg==');

@$core.Deprecated('Use withdrawUpliftApplicationRequestDescriptor instead')
const WithdrawUpliftApplicationRequest$json = {
  '1': 'WithdrawUpliftApplicationRequest',
  '2': [
    {'1': 'application_id', '3': 1, '4': 1, '5': 9, '10': 'applicationId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `WithdrawUpliftApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawUpliftApplicationRequestDescriptor =
    $convert.base64Decode(
        'CiBXaXRoZHJhd1VwbGlmdEFwcGxpY2F0aW9uUmVxdWVzdBIlCg5hcHBsaWNhdGlvbl9pZBgBIA'
        'EoCVINYXBwbGljYXRpb25JZBIWCgZyZWFzb24YAiABKAlSBnJlYXNvbg==');

@$core.Deprecated('Use withdrawUpliftApplicationResponseDescriptor instead')
const WithdrawUpliftApplicationResponse$json = {
  '1': 'WithdrawUpliftApplicationResponse',
  '2': [
    {
      '1': 'application',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftApplicationMessage',
      '10': 'application'
    },
  ],
};

/// Descriptor for `WithdrawUpliftApplicationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawUpliftApplicationResponseDescriptor =
    $convert.base64Decode(
        'CiFXaXRoZHJhd1VwbGlmdEFwcGxpY2F0aW9uUmVzcG9uc2USPgoLYXBwbGljYXRpb24YASABKA'
        'syHC5wYi5VcGxpZnRBcHBsaWNhdGlvbk1lc3NhZ2VSC2FwcGxpY2F0aW9u');

@$core.Deprecated('Use getUpliftApplicationRequestDescriptor instead')
const GetUpliftApplicationRequest$json = {
  '1': 'GetUpliftApplicationRequest',
  '2': [
    {'1': 'application_id', '3': 1, '4': 1, '5': 9, '10': 'applicationId'},
  ],
};

/// Descriptor for `GetUpliftApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftApplicationRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRVcGxpZnRBcHBsaWNhdGlvblJlcXVlc3QSJQoOYXBwbGljYXRpb25faWQYASABKAlSDW'
        'FwcGxpY2F0aW9uSWQ=');

@$core.Deprecated('Use getUpliftApplicationResponseDescriptor instead')
const GetUpliftApplicationResponse$json = {
  '1': 'GetUpliftApplicationResponse',
  '2': [
    {
      '1': 'application',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftApplicationMessage',
      '10': 'application'
    },
  ],
};

/// Descriptor for `GetUpliftApplicationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftApplicationResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXRVcGxpZnRBcHBsaWNhdGlvblJlc3BvbnNlEj4KC2FwcGxpY2F0aW9uGAEgASgLMhwucG'
        'IuVXBsaWZ0QXBwbGljYXRpb25NZXNzYWdlUgthcHBsaWNhdGlvbg==');

@$core.Deprecated('Use listUpliftApplicationsRequestDescriptor instead')
const ListUpliftApplicationsRequest$json = {
  '1': 'ListUpliftApplicationsRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'mine_only', '3': 2, '4': 1, '5': 8, '10': 'mineOnly'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 5, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'sort_by', '3': 6, '4': 1, '5': 9, '10': 'sortBy'},
  ],
};

/// Descriptor for `ListUpliftApplicationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftApplicationsRequestDescriptor = $convert.base64Decode(
    'Ch1MaXN0VXBsaWZ0QXBwbGljYXRpb25zUmVxdWVzdBIXCgdmdW5kX2lkGAEgASgJUgZmdW5kSW'
    'QSGwoJbWluZV9vbmx5GAIgASgIUghtaW5lT25seRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIS'
    'CgRwYWdlGAQgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgFIAEoBVIIcGFnZVNpemUSFwoHc29ydF'
    '9ieRgGIAEoCVIGc29ydEJ5');

@$core.Deprecated('Use listUpliftApplicationsResponseDescriptor instead')
const ListUpliftApplicationsResponse$json = {
  '1': 'ListUpliftApplicationsResponse',
  '2': [
    {
      '1': 'applications',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.UpliftApplicationMessage',
      '10': 'applications'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftPaginationInfo',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `ListUpliftApplicationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftApplicationsResponseDescriptor =
    $convert.base64Decode(
        'Ch5MaXN0VXBsaWZ0QXBwbGljYXRpb25zUmVzcG9uc2USQAoMYXBwbGljYXRpb25zGAEgAygLMh'
        'wucGIuVXBsaWZ0QXBwbGljYXRpb25NZXNzYWdlUgxhcHBsaWNhdGlvbnMSOAoKcGFnaW5hdGlv'
        'bhgCIAEoCzIYLnBiLlVwbGlmdFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use endorseUpliftApplicationRequestDescriptor instead')
const EndorseUpliftApplicationRequest$json = {
  '1': 'EndorseUpliftApplicationRequest',
  '2': [
    {'1': 'application_id', '3': 1, '4': 1, '5': 9, '10': 'applicationId'},
    {'1': 'remove', '3': 2, '4': 1, '5': 8, '10': 'remove'},
  ],
};

/// Descriptor for `EndorseUpliftApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endorseUpliftApplicationRequestDescriptor =
    $convert.base64Decode(
        'Ch9FbmRvcnNlVXBsaWZ0QXBwbGljYXRpb25SZXF1ZXN0EiUKDmFwcGxpY2F0aW9uX2lkGAEgAS'
        'gJUg1hcHBsaWNhdGlvbklkEhYKBnJlbW92ZRgCIAEoCFIGcmVtb3Zl');

@$core.Deprecated('Use endorseUpliftApplicationResponseDescriptor instead')
const EndorseUpliftApplicationResponse$json = {
  '1': 'EndorseUpliftApplicationResponse',
  '2': [
    {'1': 'application_id', '3': 1, '4': 1, '5': 9, '10': 'applicationId'},
    {
      '1': 'endorsement_count',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'endorsementCount'
    },
    {'1': 'endorsed', '3': 3, '4': 1, '5': 8, '10': 'endorsed'},
  ],
};

/// Descriptor for `EndorseUpliftApplicationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endorseUpliftApplicationResponseDescriptor =
    $convert.base64Decode(
        'CiBFbmRvcnNlVXBsaWZ0QXBwbGljYXRpb25SZXNwb25zZRIlCg5hcHBsaWNhdGlvbl9pZBgBIA'
        'EoCVINYXBwbGljYXRpb25JZBIrChFlbmRvcnNlbWVudF9jb3VudBgCIAEoBVIQZW5kb3JzZW1l'
        'bnRDb3VudBIaCghlbmRvcnNlZBgDIAEoCFIIZW5kb3JzZWQ=');

@$core.Deprecated('Use reviewUpliftApplicationRequestDescriptor instead')
const ReviewUpliftApplicationRequest$json = {
  '1': 'ReviewUpliftApplicationRequest',
  '2': [
    {'1': 'application_id', '3': 1, '4': 1, '5': 9, '10': 'applicationId'},
    {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `ReviewUpliftApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewUpliftApplicationRequestDescriptor =
    $convert.base64Decode(
        'Ch5SZXZpZXdVcGxpZnRBcHBsaWNhdGlvblJlcXVlc3QSJQoOYXBwbGljYXRpb25faWQYASABKA'
        'lSDWFwcGxpY2F0aW9uSWQSFgoGYWN0aW9uGAIgASgJUgZhY3Rpb24SFgoGcmVhc29uGAMgASgJ'
        'UgZyZWFzb24=');

@$core.Deprecated('Use reviewUpliftApplicationResponseDescriptor instead')
const ReviewUpliftApplicationResponse$json = {
  '1': 'ReviewUpliftApplicationResponse',
  '2': [
    {
      '1': 'application',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftApplicationMessage',
      '10': 'application'
    },
  ],
};

/// Descriptor for `ReviewUpliftApplicationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewUpliftApplicationResponseDescriptor =
    $convert.base64Decode(
        'Ch9SZXZpZXdVcGxpZnRBcHBsaWNhdGlvblJlc3BvbnNlEj4KC2FwcGxpY2F0aW9uGAEgASgLMh'
        'wucGIuVXBsaWZ0QXBwbGljYXRpb25NZXNzYWdlUgthcHBsaWNhdGlvbg==');

@$core.Deprecated('Use upliftMilestonePlanInputDescriptor instead')
const UpliftMilestonePlanInput$json = {
  '1': 'UpliftMilestonePlanInput',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 5, '10': 'sequence'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'amount', '3': 4, '4': 1, '5': 4, '10': 'amount'},
  ],
};

/// Descriptor for `UpliftMilestonePlanInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upliftMilestonePlanInputDescriptor = $convert.base64Decode(
    'ChhVcGxpZnRNaWxlc3RvbmVQbGFuSW5wdXQSGgoIc2VxdWVuY2UYASABKAVSCHNlcXVlbmNlEh'
    'QKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24S'
    'FgoGYW1vdW50GAQgASgEUgZhbW91bnQ=');

@$core.Deprecated('Use selectUpliftApplicationRequestDescriptor instead')
const SelectUpliftApplicationRequest$json = {
  '1': 'SelectUpliftApplicationRequest',
  '2': [
    {'1': 'application_id', '3': 1, '4': 1, '5': 9, '10': 'applicationId'},
    {'1': 'approved_amount', '3': 2, '4': 1, '5': 4, '10': 'approvedAmount'},
    {
      '1': 'milestones',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.pb.UpliftMilestonePlanInput',
      '10': 'milestones'
    },
    {
      '1': 'offer_expiry_hours',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'offerExpiryHours'
    },
    {'1': 'note', '3': 5, '4': 1, '5': 9, '10': 'note'},
    {'1': 'equity_pct', '3': 6, '4': 1, '5': 13, '10': 'equityPct'},
  ],
};

/// Descriptor for `SelectUpliftApplicationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectUpliftApplicationRequestDescriptor = $convert.base64Decode(
    'Ch5TZWxlY3RVcGxpZnRBcHBsaWNhdGlvblJlcXVlc3QSJQoOYXBwbGljYXRpb25faWQYASABKA'
    'lSDWFwcGxpY2F0aW9uSWQSJwoPYXBwcm92ZWRfYW1vdW50GAIgASgEUg5hcHByb3ZlZEFtb3Vu'
    'dBI8CgptaWxlc3RvbmVzGAMgAygLMhwucGIuVXBsaWZ0TWlsZXN0b25lUGxhbklucHV0UgptaW'
    'xlc3RvbmVzEiwKEm9mZmVyX2V4cGlyeV9ob3VycxgEIAEoBVIQb2ZmZXJFeHBpcnlIb3VycxIS'
    'CgRub3RlGAUgASgJUgRub3RlEh0KCmVxdWl0eV9wY3QYBiABKA1SCWVxdWl0eVBjdA==');

@$core.Deprecated('Use selectUpliftApplicationResponseDescriptor instead')
const SelectUpliftApplicationResponse$json = {
  '1': 'SelectUpliftApplicationResponse',
  '2': [
    {
      '1': 'application',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftApplicationMessage',
      '10': 'application'
    },
  ],
};

/// Descriptor for `SelectUpliftApplicationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectUpliftApplicationResponseDescriptor =
    $convert.base64Decode(
        'Ch9TZWxlY3RVcGxpZnRBcHBsaWNhdGlvblJlc3BvbnNlEj4KC2FwcGxpY2F0aW9uGAEgASgLMh'
        'wucGIuVXBsaWZ0QXBwbGljYXRpb25NZXNzYWdlUgthcHBsaWNhdGlvbg==');

@$core.Deprecated('Use respondToUpliftOfferRequestDescriptor instead')
const RespondToUpliftOfferRequest$json = {
  '1': 'RespondToUpliftOfferRequest',
  '2': [
    {'1': 'application_id', '3': 1, '4': 1, '5': 9, '10': 'applicationId'},
    {'1': 'accept', '3': 2, '4': 1, '5': 8, '10': 'accept'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {
      '1': 'business_account_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'businessAccountId'
    },
    {'1': 'counter', '3': 5, '4': 1, '5': 8, '10': 'counter'},
    {'1': 'counter_amount', '3': 6, '4': 1, '5': 4, '10': 'counterAmount'},
    {
      '1': 'counter_equity_pct',
      '3': 7,
      '4': 1,
      '5': 13,
      '10': 'counterEquityPct'
    },
    {'1': 'counter_note', '3': 8, '4': 1, '5': 9, '10': 'counterNote'},
  ],
};

/// Descriptor for `RespondToUpliftOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List respondToUpliftOfferRequestDescriptor = $convert.base64Decode(
    'ChtSZXNwb25kVG9VcGxpZnRPZmZlclJlcXVlc3QSJQoOYXBwbGljYXRpb25faWQYASABKAlSDW'
    'FwcGxpY2F0aW9uSWQSFgoGYWNjZXB0GAIgASgIUgZhY2NlcHQSFgoGcmVhc29uGAMgASgJUgZy'
    'ZWFzb24SLgoTYnVzaW5lc3NfYWNjb3VudF9pZBgEIAEoCVIRYnVzaW5lc3NBY2NvdW50SWQSGA'
    'oHY291bnRlchgFIAEoCFIHY291bnRlchIlCg5jb3VudGVyX2Ftb3VudBgGIAEoBFINY291bnRl'
    'ckFtb3VudBIsChJjb3VudGVyX2VxdWl0eV9wY3QYByABKA1SEGNvdW50ZXJFcXVpdHlQY3QSIQ'
    'oMY291bnRlcl9ub3RlGAggASgJUgtjb3VudGVyTm90ZQ==');

@$core.Deprecated('Use respondToUpliftOfferResponseDescriptor instead')
const RespondToUpliftOfferResponse$json = {
  '1': 'RespondToUpliftOfferResponse',
  '2': [
    {
      '1': 'application',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftApplicationMessage',
      '10': 'application'
    },
  ],
};

/// Descriptor for `RespondToUpliftOfferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List respondToUpliftOfferResponseDescriptor =
    $convert.base64Decode(
        'ChxSZXNwb25kVG9VcGxpZnRPZmZlclJlc3BvbnNlEj4KC2FwcGxpY2F0aW9uGAEgASgLMhwucG'
        'IuVXBsaWZ0QXBwbGljYXRpb25NZXNzYWdlUgthcHBsaWNhdGlvbg==');

@$core.Deprecated('Use submitMilestoneEvidenceRequestDescriptor instead')
const SubmitMilestoneEvidenceRequest$json = {
  '1': 'SubmitMilestoneEvidenceRequest',
  '2': [
    {'1': 'milestone_id', '3': 1, '4': 1, '5': 9, '10': 'milestoneId'},
    {'1': 'evidence', '3': 2, '4': 3, '5': 9, '10': 'evidence'},
    {'1': 'note', '3': 3, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `SubmitMilestoneEvidenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitMilestoneEvidenceRequestDescriptor =
    $convert.base64Decode(
        'Ch5TdWJtaXRNaWxlc3RvbmVFdmlkZW5jZVJlcXVlc3QSIQoMbWlsZXN0b25lX2lkGAEgASgJUg'
        'ttaWxlc3RvbmVJZBIaCghldmlkZW5jZRgCIAMoCVIIZXZpZGVuY2USEgoEbm90ZRgDIAEoCVIE'
        'bm90ZQ==');

@$core.Deprecated('Use submitMilestoneEvidenceResponseDescriptor instead')
const SubmitMilestoneEvidenceResponse$json = {
  '1': 'SubmitMilestoneEvidenceResponse',
  '2': [
    {
      '1': 'milestone',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftMilestoneMessage',
      '10': 'milestone'
    },
  ],
};

/// Descriptor for `SubmitMilestoneEvidenceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitMilestoneEvidenceResponseDescriptor =
    $convert.base64Decode(
        'Ch9TdWJtaXRNaWxlc3RvbmVFdmlkZW5jZVJlc3BvbnNlEjgKCW1pbGVzdG9uZRgBIAEoCzIaLn'
        'BiLlVwbGlmdE1pbGVzdG9uZU1lc3NhZ2VSCW1pbGVzdG9uZQ==');

@$core.Deprecated('Use reviewMilestoneRequestDescriptor instead')
const ReviewMilestoneRequest$json = {
  '1': 'ReviewMilestoneRequest',
  '2': [
    {'1': 'milestone_id', '3': 1, '4': 1, '5': 9, '10': 'milestoneId'},
    {'1': 'approve', '3': 2, '4': 1, '5': 8, '10': 'approve'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'transaction_pin', '3': 4, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `ReviewMilestoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewMilestoneRequestDescriptor = $convert.base64Decode(
    'ChZSZXZpZXdNaWxlc3RvbmVSZXF1ZXN0EiEKDG1pbGVzdG9uZV9pZBgBIAEoCVILbWlsZXN0b2'
    '5lSWQSGAoHYXBwcm92ZRgCIAEoCFIHYXBwcm92ZRIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhIn'
    'Cg90cmFuc2FjdGlvbl9waW4YBCABKAlSDnRyYW5zYWN0aW9uUGluEiUKDnRyYW5zYWN0aW9uX2'
    'lkGAUgASgJUg10cmFuc2FjdGlvbklk');

@$core.Deprecated('Use reviewMilestoneResponseDescriptor instead')
const ReviewMilestoneResponse$json = {
  '1': 'ReviewMilestoneResponse',
  '2': [
    {
      '1': 'milestone',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftMilestoneMessage',
      '10': 'milestone'
    },
    {'1': 'release_id', '3': 2, '4': 1, '5': 9, '10': 'releaseId'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ReviewMilestoneResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewMilestoneResponseDescriptor = $convert.base64Decode(
    'ChdSZXZpZXdNaWxlc3RvbmVSZXNwb25zZRI4CgltaWxlc3RvbmUYASABKAsyGi5wYi5VcGxpZn'
    'RNaWxlc3RvbmVNZXNzYWdlUgltaWxlc3RvbmUSHQoKcmVsZWFzZV9pZBgCIAEoCVIJcmVsZWFz'
    'ZUlkEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use listUpliftMilestoneReleasesRequestDescriptor instead')
const ListUpliftMilestoneReleasesRequest$json = {
  '1': 'ListUpliftMilestoneReleasesRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'application_id', '3': 2, '4': 1, '5': 9, '10': 'applicationId'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 5, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListUpliftMilestoneReleasesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftMilestoneReleasesRequestDescriptor =
    $convert.base64Decode(
        'CiJMaXN0VXBsaWZ0TWlsZXN0b25lUmVsZWFzZXNSZXF1ZXN0EhcKB2Z1bmRfaWQYASABKAlSBm'
        'Z1bmRJZBIlCg5hcHBsaWNhdGlvbl9pZBgCIAEoCVINYXBwbGljYXRpb25JZBIWCgZzdGF0dXMY'
        'AyABKAlSBnN0YXR1cxISCgRwYWdlGAQgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgFIAEoBVIIcG'
        'FnZVNpemU=');

@$core.Deprecated('Use listUpliftMilestoneReleasesResponseDescriptor instead')
const ListUpliftMilestoneReleasesResponse$json = {
  '1': 'ListUpliftMilestoneReleasesResponse',
  '2': [
    {
      '1': 'releases',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.UpliftMilestoneReleaseRecord',
      '10': 'releases'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `ListUpliftMilestoneReleasesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftMilestoneReleasesResponseDescriptor =
    $convert.base64Decode(
        'CiNMaXN0VXBsaWZ0TWlsZXN0b25lUmVsZWFzZXNSZXNwb25zZRI8CghyZWxlYXNlcxgBIAMoCz'
        'IgLnBiLlVwbGlmdE1pbGVzdG9uZVJlbGVhc2VSZWNvcmRSCHJlbGVhc2VzEhQKBXRvdGFsGAIg'
        'ASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZV'
        'NpemUSGQoIaGFzX21vcmUYBSABKAhSB2hhc01vcmU=');

@$core.Deprecated('Use listUpliftEscrowRefundsRequestDescriptor instead')
const ListUpliftEscrowRefundsRequest$json = {
  '1': 'ListUpliftEscrowRefundsRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListUpliftEscrowRefundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftEscrowRefundsRequestDescriptor =
    $convert.base64Decode(
        'Ch5MaXN0VXBsaWZ0RXNjcm93UmVmdW5kc1JlcXVlc3QSFwoHZnVuZF9pZBgBIAEoCVIGZnVuZE'
        'lkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9z'
        'aXplGAQgASgFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use listUpliftEscrowRefundsResponseDescriptor instead')
const ListUpliftEscrowRefundsResponse$json = {
  '1': 'ListUpliftEscrowRefundsResponse',
  '2': [
    {
      '1': 'refunds',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.UpliftEscrowRefundRecord',
      '10': 'refunds'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `ListUpliftEscrowRefundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftEscrowRefundsResponseDescriptor =
    $convert.base64Decode(
        'Ch9MaXN0VXBsaWZ0RXNjcm93UmVmdW5kc1Jlc3BvbnNlEjYKB3JlZnVuZHMYASADKAsyHC5wYi'
        '5VcGxpZnRFc2Nyb3dSZWZ1bmRSZWNvcmRSB3JlZnVuZHMSFAoFdG90YWwYAiABKAVSBXRvdGFs'
        'EhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZRIZCghoYX'
        'NfbW9yZRgFIAEoCFIHaGFzTW9yZQ==');

@$core.Deprecated('Use getUpliftReceiptRequestDescriptor instead')
const GetUpliftReceiptRequest$json = {
  '1': 'GetUpliftReceiptRequest',
  '2': [
    {'1': 'reference_id', '3': 1, '4': 1, '5': 9, '10': 'referenceId'},
    {'1': 'reference_type', '3': 2, '4': 1, '5': 9, '10': 'referenceType'},
  ],
};

/// Descriptor for `GetUpliftReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftReceiptRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRVcGxpZnRSZWNlaXB0UmVxdWVzdBIhCgxyZWZlcmVuY2VfaWQYASABKAlSC3JlZmVyZW'
        '5jZUlkEiUKDnJlZmVyZW5jZV90eXBlGAIgASgJUg1yZWZlcmVuY2VUeXBl');

@$core.Deprecated('Use getUpliftReceiptResponseDescriptor instead')
const GetUpliftReceiptResponse$json = {
  '1': 'GetUpliftReceiptResponse',
  '2': [
    {
      '1': 'receipt',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftReceiptMessage',
      '10': 'receipt'
    },
  ],
};

/// Descriptor for `GetUpliftReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftReceiptResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRVcGxpZnRSZWNlaXB0UmVzcG9uc2USMgoHcmVjZWlwdBgBIAEoCzIYLnBiLlVwbGlmdF'
        'JlY2VpcHRNZXNzYWdlUgdyZWNlaXB0');

@$core.Deprecated('Use listUpliftReceiptsRequestDescriptor instead')
const ListUpliftReceiptsRequest$json = {
  '1': 'ListUpliftReceiptsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListUpliftReceiptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftReceiptsRequestDescriptor =
    $convert.base64Decode(
        'ChlMaXN0VXBsaWZ0UmVjZWlwdHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGwoJcGFnZV'
        '9zaXplGAIgASgFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use listUpliftReceiptsResponseDescriptor instead')
const ListUpliftReceiptsResponse$json = {
  '1': 'ListUpliftReceiptsResponse',
  '2': [
    {
      '1': 'receipts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.UpliftReceiptMessage',
      '10': 'receipts'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.UpliftPaginationInfo',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `ListUpliftReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUpliftReceiptsResponseDescriptor =
    $convert.base64Decode(
        'ChpMaXN0VXBsaWZ0UmVjZWlwdHNSZXNwb25zZRI0CghyZWNlaXB0cxgBIAMoCzIYLnBiLlVwbG'
        'lmdFJlY2VpcHRNZXNzYWdlUghyZWNlaXB0cxI4CgpwYWdpbmF0aW9uGAIgASgLMhgucGIuVXBs'
        'aWZ0UGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');

@$core.Deprecated('Use getUpliftFeeQuoteRequestDescriptor instead')
const GetUpliftFeeQuoteRequest$json = {
  '1': 'GetUpliftFeeQuoteRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 4, '10': 'amount'},
  ],
};

/// Descriptor for `GetUpliftFeeQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftFeeQuoteRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRVcGxpZnRGZWVRdW90ZVJlcXVlc3QSFgoGYW1vdW50GAEgASgEUgZhbW91bnQ=');

@$core.Deprecated('Use getUpliftFeeQuoteResponseDescriptor instead')
const GetUpliftFeeQuoteResponse$json = {
  '1': 'GetUpliftFeeQuoteResponse',
  '2': [
    {'1': 'gross', '3': 1, '4': 1, '5': 4, '10': 'gross'},
    {'1': 'fee', '3': 2, '4': 1, '5': 4, '10': 'fee'},
    {'1': 'net', '3': 3, '4': 1, '5': 4, '10': 'net'},
    {'1': 'fee_enabled', '3': 4, '4': 1, '5': 8, '10': 'feeEnabled'},
    {'1': 'fee_type', '3': 5, '4': 1, '5': 9, '10': 'feeType'},
    {
      '1': 'fee_percentage_bps',
      '3': 6,
      '4': 1,
      '5': 13,
      '10': 'feePercentageBps'
    },
    {'1': 'fee_fixed_kobo', '3': 7, '4': 1, '5': 4, '10': 'feeFixedKobo'},
  ],
};

/// Descriptor for `GetUpliftFeeQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftFeeQuoteResponseDescriptor = $convert.base64Decode(
    'ChlHZXRVcGxpZnRGZWVRdW90ZVJlc3BvbnNlEhQKBWdyb3NzGAEgASgEUgVncm9zcxIQCgNmZW'
    'UYAiABKARSA2ZlZRIQCgNuZXQYAyABKARSA25ldBIfCgtmZWVfZW5hYmxlZBgEIAEoCFIKZmVl'
    'RW5hYmxlZBIZCghmZWVfdHlwZRgFIAEoCVIHZmVlVHlwZRIsChJmZWVfcGVyY2VudGFnZV9icH'
    'MYBiABKA1SEGZlZVBlcmNlbnRhZ2VCcHMSJAoOZmVlX2ZpeGVkX2tvYm8YByABKARSDGZlZUZp'
    'eGVkS29ibw==');

@$core.Deprecated('Use getUpliftStatisticsRequestDescriptor instead')
const GetUpliftStatisticsRequest$json = {
  '1': 'GetUpliftStatisticsRequest',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
  ],
};

/// Descriptor for `GetUpliftStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftStatisticsRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRVcGxpZnRTdGF0aXN0aWNzUmVxdWVzdBIXCgdmdW5kX2lkGAEgASgJUgZmdW5kSWQ=');

@$core.Deprecated('Use getUpliftStatisticsResponseDescriptor instead')
const GetUpliftStatisticsResponse$json = {
  '1': 'GetUpliftStatisticsResponse',
  '2': [
    {'1': 'fund_id', '3': 1, '4': 1, '5': 9, '10': 'fundId'},
    {'1': 'committed_pool', '3': 2, '4': 1, '5': 4, '10': 'committedPool'},
    {'1': 'released_total', '3': 3, '4': 1, '5': 4, '10': 'releasedTotal'},
    {'1': 'refunded_total', '3': 4, '4': 1, '5': 4, '10': 'refundedTotal'},
    {'1': 'escrow_available', '3': 5, '4': 1, '5': 4, '10': 'escrowAvailable'},
    {'1': 'target_count', '3': 6, '4': 1, '5': 5, '10': 'targetCount'},
    {
      '1': 'application_count',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'applicationCount'
    },
    {'1': 'selected_count', '3': 8, '4': 1, '5': 5, '10': 'selectedCount'},
    {'1': 'completed_count', '3': 9, '4': 1, '5': 5, '10': 'completedCount'},
    {
      '1': 'endorsement_count',
      '3': 10,
      '4': 1,
      '5': 5,
      '10': 'endorsementCount'
    },
    {
      '1': 'funded_percentage',
      '3': 11,
      '4': 1,
      '5': 1,
      '10': 'fundedPercentage'
    },
    {'1': 'days_remaining', '3': 12, '4': 1, '5': 5, '10': 'daysRemaining'},
    {'1': 'currency', '3': 13, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetUpliftStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpliftStatisticsResponseDescriptor = $convert.base64Decode(
    'ChtHZXRVcGxpZnRTdGF0aXN0aWNzUmVzcG9uc2USFwoHZnVuZF9pZBgBIAEoCVIGZnVuZElkEi'
    'UKDmNvbW1pdHRlZF9wb29sGAIgASgEUg1jb21taXR0ZWRQb29sEiUKDnJlbGVhc2VkX3RvdGFs'
    'GAMgASgEUg1yZWxlYXNlZFRvdGFsEiUKDnJlZnVuZGVkX3RvdGFsGAQgASgEUg1yZWZ1bmRlZF'
    'RvdGFsEikKEGVzY3Jvd19hdmFpbGFibGUYBSABKARSD2VzY3Jvd0F2YWlsYWJsZRIhCgx0YXJn'
    'ZXRfY291bnQYBiABKAVSC3RhcmdldENvdW50EisKEWFwcGxpY2F0aW9uX2NvdW50GAcgASgFUh'
    'BhcHBsaWNhdGlvbkNvdW50EiUKDnNlbGVjdGVkX2NvdW50GAggASgFUg1zZWxlY3RlZENvdW50'
    'EicKD2NvbXBsZXRlZF9jb3VudBgJIAEoBVIOY29tcGxldGVkQ291bnQSKwoRZW5kb3JzZW1lbn'
    'RfY291bnQYCiABKAVSEGVuZG9yc2VtZW50Q291bnQSKwoRZnVuZGVkX3BlcmNlbnRhZ2UYCyAB'
    'KAFSEGZ1bmRlZFBlcmNlbnRhZ2USJQoOZGF5c19yZW1haW5pbmcYDCABKAVSDWRheXNSZW1haW'
    '5pbmcSGgoIY3VycmVuY3kYDSABKAlSCGN1cnJlbmN5');
