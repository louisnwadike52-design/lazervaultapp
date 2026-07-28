// This is a generated file - do not edit.
//
// Generated from auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use primaryContactTypeDescriptor instead')
const PrimaryContactType$json = {
  '1': 'PrimaryContactType',
  '2': [
    {'1': 'EMAIL', '2': 0},
    {'1': 'PHONE', '2': 1},
  ],
};

/// Descriptor for `PrimaryContactType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List primaryContactTypeDescriptor = $convert
    .base64Decode('ChJQcmltYXJ5Q29udGFjdFR5cGUSCQoFRU1BSUwQABIJCgVQSE9ORRAB');

@$core.Deprecated('Use passwordResetDeliveryMethodDescriptor instead')
const PasswordResetDeliveryMethod$json = {
  '1': 'PasswordResetDeliveryMethod',
  '2': [
    {'1': 'DELIVERY_METHOD_UNSPECIFIED', '2': 0},
    {'1': 'DELIVERY_METHOD_EMAIL', '2': 1},
    {'1': 'DELIVERY_METHOD_SMS', '2': 2},
  ],
};

/// Descriptor for `PasswordResetDeliveryMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List passwordResetDeliveryMethodDescriptor =
    $convert.base64Decode(
        'ChtQYXNzd29yZFJlc2V0RGVsaXZlcnlNZXRob2QSHwobREVMSVZFUllfTUVUSE9EX1VOU1BFQ0'
        'lGSUVEEAASGQoVREVMSVZFUllfTUVUSE9EX0VNQUlMEAESFwoTREVMSVZFUllfTUVUSE9EX1NN'
        'UxAC');

@$core.Deprecated('Use signupStatusDescriptor instead')
const SignupStatus$json = {
  '1': 'SignupStatus',
  '2': [
    {'1': 'SIGNUP_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'SIGNUP_STATUS_CREATED', '2': 1},
    {'1': 'SIGNUP_STATUS_EMAIL_VERIFIED', '2': 2},
    {'1': 'SIGNUP_STATUS_PHONE_VERIFIED', '2': 3},
    {'1': 'SIGNUP_STATUS_IDENTITY_VERIFIED', '2': 4},
    {'1': 'SIGNUP_STATUS_PASSCODE_SET', '2': 5},
    {'1': 'SIGNUP_STATUS_COMPLETE', '2': 6},
  ],
};

/// Descriptor for `SignupStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List signupStatusDescriptor = $convert.base64Decode(
    'CgxTaWdudXBTdGF0dXMSHQoZU0lHTlVQX1NUQVRVU19VTlNQRUNJRklFRBAAEhkKFVNJR05VUF'
    '9TVEFUVVNfQ1JFQVRFRBABEiAKHFNJR05VUF9TVEFUVVNfRU1BSUxfVkVSSUZJRUQQAhIgChxT'
    'SUdOVVBfU1RBVFVTX1BIT05FX1ZFUklGSUVEEAMSIwofU0lHTlVQX1NUQVRVU19JREVOVElUWV'
    '9WRVJJRklFRBAEEh4KGlNJR05VUF9TVEFUVVNfUEFTU0NPREVfU0VUEAUSGgoWU0lHTlVQX1NU'
    'QVRVU19DT01QTEVURRAG');

@$core.Deprecated('Use stepStatusDescriptor instead')
const StepStatus$json = {
  '1': 'StepStatus',
  '2': [
    {'1': 'STEP_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'STEP_STATUS_PENDING', '2': 1},
    {'1': 'STEP_STATUS_IN_PROGRESS', '2': 2},
    {'1': 'STEP_STATUS_COMPLETED', '2': 3},
    {'1': 'STEP_STATUS_SKIPPED', '2': 4},
  ],
};

/// Descriptor for `StepStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List stepStatusDescriptor = $convert.base64Decode(
    'CgpTdGVwU3RhdHVzEhsKF1NURVBfU1RBVFVTX1VOU1BFQ0lGSUVEEAASFwoTU1RFUF9TVEFUVV'
    'NfUEVORElORxABEhsKF1NURVBfU1RBVFVTX0lOX1BST0dSRVNTEAISGQoVU1RFUF9TVEFUVVNf'
    'Q09NUExFVEVEEAMSFwoTU1RFUF9TVEFUVVNfU0tJUFBFRBAE');

@$core.Deprecated('Use identityTypeDescriptor instead')
const IdentityType$json = {
  '1': 'IdentityType',
  '2': [
    {'1': 'IDENTITY_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'IDENTITY_TYPE_BVN', '2': 1},
    {'1': 'IDENTITY_TYPE_NIN', '2': 2},
    {'1': 'IDENTITY_TYPE_GHANA_CARD', '2': 3},
    {'1': 'IDENTITY_TYPE_KENYA_NATIONAL_ID', '2': 4},
    {'1': 'IDENTITY_TYPE_KRA_PIN', '2': 5},
    {'1': 'IDENTITY_TYPE_SA_ID', '2': 6},
    {'1': 'IDENTITY_TYPE_SA_PASSPORT', '2': 7},
    {'1': 'IDENTITY_TYPE_UK_PASSPORT', '2': 8},
    {'1': 'IDENTITY_TYPE_UK_DRIVING_LICENSE', '2': 9},
    {'1': 'IDENTITY_TYPE_US_SSN', '2': 10},
    {'1': 'IDENTITY_TYPE_US_STATE_ID', '2': 11},
    {'1': 'IDENTITY_TYPE_US_PASSPORT', '2': 12},
    {'1': 'IDENTITY_TYPE_DRIVERS_LICENSE', '2': 13},
    {'1': 'IDENTITY_TYPE_INTERNATIONAL_PASSPORT', '2': 14},
  ],
};

/// Descriptor for `IdentityType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List identityTypeDescriptor = $convert.base64Decode(
    'CgxJZGVudGl0eVR5cGUSHQoZSURFTlRJVFlfVFlQRV9VTlNQRUNJRklFRBAAEhUKEUlERU5USV'
    'RZX1RZUEVfQlZOEAESFQoRSURFTlRJVFlfVFlQRV9OSU4QAhIcChhJREVOVElUWV9UWVBFX0dI'
    'QU5BX0NBUkQQAxIjCh9JREVOVElUWV9UWVBFX0tFTllBX05BVElPTkFMX0lEEAQSGQoVSURFTl'
    'RJVFlfVFlQRV9LUkFfUElOEAUSFwoTSURFTlRJVFlfVFlQRV9TQV9JRBAGEh0KGUlERU5USVRZ'
    'X1RZUEVfU0FfUEFTU1BPUlQQBxIdChlJREVOVElUWV9UWVBFX1VLX1BBU1NQT1JUEAgSJAogSU'
    'RFTlRJVFlfVFlQRV9VS19EUklWSU5HX0xJQ0VOU0UQCRIYChRJREVOVElUWV9UWVBFX1VTX1NT'
    'ThAKEh0KGUlERU5USVRZX1RZUEVfVVNfU1RBVEVfSUQQCxIdChlJREVOVElUWV9UWVBFX1VTX1'
    'BBU1NQT1JUEAwSIQodSURFTlRJVFlfVFlQRV9EUklWRVJTX0xJQ0VOU0UQDRIoCiRJREVOVElU'
    'WV9UWVBFX0lOVEVSTkFUSU9OQUxfUEFTU1BPUlQQDg==');

@$core.Deprecated('Use kYCTierDescriptor instead')
const KYCTier$json = {
  '1': 'KYCTier',
  '2': [
    {'1': 'KYC_TIER_UNKNOWN', '2': 0},
    {'1': 'KYC_TIER_1', '2': 1},
    {'1': 'KYC_TIER_2', '2': 2},
    {'1': 'KYC_TIER_3', '2': 3},
  ],
};

/// Descriptor for `KYCTier`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCTierDescriptor = $convert.base64Decode(
    'CgdLWUNUaWVyEhQKEEtZQ19USUVSX1VOS05PV04QABIOCgpLWUNfVElFUl8xEAESDgoKS1lDX1'
    'RJRVJfMhACEg4KCktZQ19USUVSXzMQAw==');

@$core.Deprecated('Use documentTypeDescriptor instead')
const DocumentType$json = {
  '1': 'DocumentType',
  '2': [
    {'1': 'DOCUMENT_TYPE_UNKNOWN', '2': 0},
    {'1': 'DOCUMENT_TYPE_BVN', '2': 1},
    {'1': 'DOCUMENT_TYPE_NIN', '2': 2},
    {'1': 'DOCUMENT_TYPE_DRIVERS_LICENSE', '2': 3},
    {'1': 'DOCUMENT_TYPE_PASSPORT', '2': 4},
    {'1': 'DOCUMENT_TYPE_VOTERS_CARD', '2': 5},
    {'1': 'DOCUMENT_TYPE_PROOF_OF_ADDRESS', '2': 6},
    {'1': 'DOCUMENT_TYPE_SELFIE', '2': 7},
  ],
};

/// Descriptor for `DocumentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentTypeDescriptor = $convert.base64Decode(
    'CgxEb2N1bWVudFR5cGUSGQoVRE9DVU1FTlRfVFlQRV9VTktOT1dOEAASFQoRRE9DVU1FTlRfVF'
    'lQRV9CVk4QARIVChFET0NVTUVOVF9UWVBFX05JThACEiEKHURPQ1VNRU5UX1RZUEVfRFJJVkVS'
    'U19MSUNFTlNFEAMSGgoWRE9DVU1FTlRfVFlQRV9QQVNTUE9SVBAEEh0KGURPQ1VNRU5UX1RZUE'
    'VfVk9URVJTX0NBUkQQBRIiCh5ET0NVTUVOVF9UWVBFX1BST09GX09GX0FERFJFU1MQBhIYChRE'
    'T0NVTUVOVF9UWVBFX1NFTEZJRRAH');

@$core.Deprecated('Use documentStatusDescriptor instead')
const DocumentStatus$json = {
  '1': 'DocumentStatus',
  '2': [
    {'1': 'DOCUMENT_STATUS_UNKNOWN', '2': 0},
    {'1': 'DOCUMENT_STATUS_PENDING_UPLOAD', '2': 1},
    {'1': 'DOCUMENT_STATUS_UPLOADED', '2': 2},
    {'1': 'DOCUMENT_STATUS_UNDER_REVIEW', '2': 3},
    {'1': 'DOCUMENT_STATUS_APPROVED', '2': 4},
    {'1': 'DOCUMENT_STATUS_REJECTED', '2': 5},
  ],
};

/// Descriptor for `DocumentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentStatusDescriptor = $convert.base64Decode(
    'Cg5Eb2N1bWVudFN0YXR1cxIbChdET0NVTUVOVF9TVEFUVVNfVU5LTk9XThAAEiIKHkRPQ1VNRU'
    '5UX1NUQVRVU19QRU5ESU5HX1VQTE9BRBABEhwKGERPQ1VNRU5UX1NUQVRVU19VUExPQURFRBAC'
    'EiAKHERPQ1VNRU5UX1NUQVRVU19VTkRFUl9SRVZJRVcQAxIcChhET0NVTUVOVF9TVEFUVVNfQV'
    'BQUk9WRUQQBBIcChhET0NVTUVOVF9TVEFUVVNfUkVKRUNURUQQBQ==');

@$core.Deprecated('Use kYCVerificationStatusDescriptor instead')
const KYCVerificationStatus$json = {
  '1': 'KYCVerificationStatus',
  '2': [
    {'1': 'KYC_STATUS_UNKNOWN', '2': 0},
    {'1': 'KYC_STATUS_NOT_STARTED', '2': 1},
    {'1': 'KYC_STATUS_IN_PROGRESS', '2': 2},
    {'1': 'KYC_STATUS_PENDING_REVIEW', '2': 3},
    {'1': 'KYC_STATUS_APPROVED', '2': 4},
    {'1': 'KYC_STATUS_REJECTED', '2': 5},
    {'1': 'KYC_STATUS_EXPIRED', '2': 6},
  ],
};

/// Descriptor for `KYCVerificationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCVerificationStatusDescriptor = $convert.base64Decode(
    'ChVLWUNWZXJpZmljYXRpb25TdGF0dXMSFgoSS1lDX1NUQVRVU19VTktOT1dOEAASGgoWS1lDX1'
    'NUQVRVU19OT1RfU1RBUlRFRBABEhoKFktZQ19TVEFUVVNfSU5fUFJPR1JFU1MQAhIdChlLWUNf'
    'U1RBVFVTX1BFTkRJTkdfUkVWSUVXEAMSFwoTS1lDX1NUQVRVU19BUFBST1ZFRBAEEhcKE0tZQ1'
    '9TVEFUVVNfUkVKRUNURUQQBRIWChJLWUNfU1RBVFVTX0VYUElSRUQQBg==');

@$core.Deprecated('Use requestAccountLockRequestDescriptor instead')
const RequestAccountLockRequest$json = {
  '1': 'RequestAccountLockRequest',
  '2': [
    {'1': 'duration_seconds', '3': 1, '4': 1, '5': 5, '10': 'durationSeconds'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RequestAccountLockRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAccountLockRequestDescriptor =
    $convert.base64Decode(
        'ChlSZXF1ZXN0QWNjb3VudExvY2tSZXF1ZXN0EikKEGR1cmF0aW9uX3NlY29uZHMYASABKAVSD2'
        'R1cmF0aW9uU2Vjb25kcxIWCgZyZWFzb24YAiABKAlSBnJlYXNvbg==');

@$core.Deprecated('Use requestAccountLockResponseDescriptor instead')
const RequestAccountLockResponse$json = {
  '1': 'RequestAccountLockResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'locked_until', '3': 2, '4': 1, '5': 9, '10': 'lockedUntil'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RequestAccountLockResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAccountLockResponseDescriptor =
    $convert.base64Decode(
        'ChpSZXF1ZXN0QWNjb3VudExvY2tSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEi'
        'EKDGxvY2tlZF91bnRpbBgCIAEoCVILbG9ja2VkVW50aWwSGAoHbWVzc2FnZRgDIAEoCVIHbWVz'
        'c2FnZQ==');

@$core.Deprecated('Use requestAccountDeletionRequestDescriptor instead')
const RequestAccountDeletionRequest$json = {
  '1': 'RequestAccountDeletionRequest',
  '2': [
    {'1': 'reason', '3': 1, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RequestAccountDeletionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAccountDeletionRequestDescriptor =
    $convert.base64Decode(
        'Ch1SZXF1ZXN0QWNjb3VudERlbGV0aW9uUmVxdWVzdBIWCgZyZWFzb24YASABKAlSBnJlYXNvbg'
        '==');

@$core.Deprecated('Use requestAccountDeletionResponseDescriptor instead')
const RequestAccountDeletionResponse$json = {
  '1': 'RequestAccountDeletionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'scheduled_at', '3': 3, '4': 1, '5': 9, '10': 'scheduledAt'},
    {'1': 'grace_period_days', '3': 4, '4': 1, '5': 5, '10': 'gracePeriodDays'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    {'1': 'error_code', '3': 6, '4': 1, '5': 9, '10': 'errorCode'},
  ],
};

/// Descriptor for `RequestAccountDeletionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAccountDeletionResponseDescriptor = $convert.base64Decode(
    'Ch5SZXF1ZXN0QWNjb3VudERlbGV0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
    'VzcxIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIhCgxzY2hlZHVsZWRfYXQYAyABKAlSC3NjaGVk'
    'dWxlZEF0EioKEWdyYWNlX3BlcmlvZF9kYXlzGAQgASgFUg9ncmFjZVBlcmlvZERheXMSGAoHbW'
    'Vzc2FnZRgFIAEoCVIHbWVzc2FnZRIdCgplcnJvcl9jb2RlGAYgASgJUgllcnJvckNvZGU=');

@$core.Deprecated('Use cancelAccountDeletionRequestDescriptor instead')
const CancelAccountDeletionRequest$json = {
  '1': 'CancelAccountDeletionRequest',
};

/// Descriptor for `CancelAccountDeletionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelAccountDeletionRequestDescriptor =
    $convert.base64Decode('ChxDYW5jZWxBY2NvdW50RGVsZXRpb25SZXF1ZXN0');

@$core.Deprecated('Use cancelAccountDeletionResponseDescriptor instead')
const CancelAccountDeletionResponse$json = {
  '1': 'CancelAccountDeletionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelAccountDeletionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelAccountDeletionResponseDescriptor =
    $convert.base64Decode(
        'Ch1DYW5jZWxBY2NvdW50RGVsZXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
        'NzEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use listDeletionAccountsRequestDescriptor instead')
const ListDeletionAccountsRequest$json = {
  '1': 'ListDeletionAccountsRequest',
  '2': [
    {
      '1': 'only_awaiting_admin',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'onlyAwaitingAdmin'
    },
  ],
};

/// Descriptor for `ListDeletionAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDeletionAccountsRequestDescriptor =
    $convert.base64Decode(
        'ChtMaXN0RGVsZXRpb25BY2NvdW50c1JlcXVlc3QSLgoTb25seV9hd2FpdGluZ19hZG1pbhgBIA'
        'EoCFIRb25seUF3YWl0aW5nQWRtaW4=');

@$core.Deprecated('Use deletionAccountDescriptor instead')
const DeletionAccount$json = {
  '1': 'DeletionAccount',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'deletion_status', '3': 6, '4': 1, '5': 9, '10': 'deletionStatus'},
    {'1': 'requested_at', '3': 7, '4': 1, '5': 9, '10': 'requestedAt'},
    {'1': 'scheduled_at', '3': 8, '4': 1, '5': 9, '10': 'scheduledAt'},
    {'1': 'past_grace', '3': 9, '4': 1, '5': 8, '10': 'pastGrace'},
  ],
};

/// Descriptor for `DeletionAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletionAccountDescriptor = $convert.base64Decode(
    'Cg9EZWxldGlvbkFjY291bnQSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhQKBWVtYWlsGAIgAS'
    'gJUgVlbWFpbBIdCgpmaXJzdF9uYW1lGAMgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAQg'
    'ASgJUghsYXN0TmFtZRIUCgVwaG9uZRgFIAEoCVIFcGhvbmUSJwoPZGVsZXRpb25fc3RhdHVzGA'
    'YgASgJUg5kZWxldGlvblN0YXR1cxIhCgxyZXF1ZXN0ZWRfYXQYByABKAlSC3JlcXVlc3RlZEF0'
    'EiEKDHNjaGVkdWxlZF9hdBgIIAEoCVILc2NoZWR1bGVkQXQSHQoKcGFzdF9ncmFjZRgJIAEoCF'
    'IJcGFzdEdyYWNl');

@$core.Deprecated('Use listDeletionAccountsResponseDescriptor instead')
const ListDeletionAccountsResponse$json = {
  '1': 'ListDeletionAccountsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'accounts',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.pb.DeletionAccount',
      '10': 'accounts'
    },
  ],
};

/// Descriptor for `ListDeletionAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDeletionAccountsResponseDescriptor =
    $convert.base64Decode(
        'ChxMaXN0RGVsZXRpb25BY2NvdW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
        'MSLwoIYWNjb3VudHMYAiADKAsyEy5wYi5EZWxldGlvbkFjY291bnRSCGFjY291bnRz');

@$core.Deprecated('Use adminAccountDeletionActionRequestDescriptor instead')
const AdminAccountDeletionActionRequest$json = {
  '1': 'AdminAccountDeletionActionRequest',
  '2': [
    {'1': 'target_user_id', '3': 1, '4': 1, '5': 9, '10': 'targetUserId'},
  ],
};

/// Descriptor for `AdminAccountDeletionActionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAccountDeletionActionRequestDescriptor =
    $convert.base64Decode(
        'CiFBZG1pbkFjY291bnREZWxldGlvbkFjdGlvblJlcXVlc3QSJAoOdGFyZ2V0X3VzZXJfaWQYAS'
        'ABKAlSDHRhcmdldFVzZXJJZA==');

@$core.Deprecated('Use adminAccountDeletionActionResponseDescriptor instead')
const AdminAccountDeletionActionResponse$json = {
  '1': 'AdminAccountDeletionActionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminAccountDeletionActionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAccountDeletionActionResponseDescriptor =
    $convert.base64Decode(
        'CiJBZG1pbkFjY291bnREZWxldGlvbkFjdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3'
        'N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use signupRequestDescriptor instead')
const SignupRequest$json = {
  '1': 'SignupRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'device_id', '3': 6, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 7, '4': 1, '5': 9, '10': 'deviceName'},
    {
      '1': 'primary_contact_type',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.pb.PrimaryContactType',
      '10': 'primaryContactType'
    },
    {'1': 'username', '3': 9, '4': 1, '5': 9, '10': 'username'},
    {'1': 'referral_code', '3': 10, '4': 1, '5': 9, '10': 'referralCode'},
    {'1': 'date_of_birth', '3': 11, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'locale', '3': 12, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'bvn', '3': 13, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'nin', '3': 14, '4': 1, '5': 9, '10': 'nin'},
    {
      '1': 'country_code',
      '3': 15,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'countryCode',
    },
    {
      '1': 'currency_code',
      '3': 16,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'currencyCode',
    },
  ],
};

/// Descriptor for `SignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupRequestDescriptor = $convert.base64Decode(
    'Cg1TaWdudXBSZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbBIaCghwYXNzd29yZBgCIAEoCV'
    'IIcGFzc3dvcmQSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgE'
    'IAEoCVIIbGFzdE5hbWUSFAoFcGhvbmUYBSABKAlSBXBob25lEhsKCWRldmljZV9pZBgGIAEoCV'
    'IIZGV2aWNlSWQSHwoLZGV2aWNlX25hbWUYByABKAlSCmRldmljZU5hbWUSSAoUcHJpbWFyeV9j'
    'b250YWN0X3R5cGUYCCABKA4yFi5wYi5QcmltYXJ5Q29udGFjdFR5cGVSEnByaW1hcnlDb250YW'
    'N0VHlwZRIaCgh1c2VybmFtZRgJIAEoCVIIdXNlcm5hbWUSIwoNcmVmZXJyYWxfY29kZRgKIAEo'
    'CVIMcmVmZXJyYWxDb2RlEiIKDWRhdGVfb2ZfYmlydGgYCyABKAlSC2RhdGVPZkJpcnRoEhYKBm'
    'xvY2FsZRgMIAEoCVIGbG9jYWxlEhAKA2J2bhgNIAEoCVIDYnZuEhAKA25pbhgOIAEoCVIDbmlu'
    'EiUKDGNvdW50cnlfY29kZRgPIAEoCUICGAFSC2NvdW50cnlDb2RlEicKDWN1cnJlbmN5X2NvZG'
    'UYECABKAlCAhgBUgxjdXJyZW5jeUNvZGU=');

@$core.Deprecated('Use signupResponseDescriptor instead')
const SignupResponse$json = {
  '1': 'SignupResponse',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'email_verification_required',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'emailVerificationRequired'
    },
    {'1': 'access_token', '3': 5, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 6, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 7, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 8, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {
      '1': 'phone_verification_required',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'phoneVerificationRequired'
    },
    {
      '1': 'verification_sent_to',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'verificationSentTo'
    },
    {
      '1': 'phone_verification_id',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'phoneVerificationId'
    },
    {
      '1': 'phone_verification_expires_in',
      '3': 12,
      '4': 1,
      '5': 3,
      '10': 'phoneVerificationExpiresIn'
    },
  ],
};

/// Descriptor for `SignupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupResponseDescriptor = $convert.base64Decode(
    'Cg5TaWdudXBSZXNwb25zZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFZW1haWwYAiABKA'
    'lSBWVtYWlsEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USPgobZW1haWxfdmVyaWZpY2F0aW9u'
    'X3JlcXVpcmVkGAQgASgIUhllbWFpbFZlcmlmaWNhdGlvblJlcXVpcmVkEiEKDGFjY2Vzc190b2'
    'tlbhgFIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgGIAEoCVIMcmVmcmVzaFRv'
    'a2VuEh0KCmV4cGlyZXNfaW4YByABKANSCWV4cGlyZXNJbhIcCgR1c2VyGAggASgLMggucGIuVX'
    'NlclIEdXNlchI+ChtwaG9uZV92ZXJpZmljYXRpb25fcmVxdWlyZWQYCSABKAhSGXBob25lVmVy'
    'aWZpY2F0aW9uUmVxdWlyZWQSMAoUdmVyaWZpY2F0aW9uX3NlbnRfdG8YCiABKAlSEnZlcmlmaW'
    'NhdGlvblNlbnRUbxIyChVwaG9uZV92ZXJpZmljYXRpb25faWQYCyABKAlSE3Bob25lVmVyaWZp'
    'Y2F0aW9uSWQSQQodcGhvbmVfdmVyaWZpY2F0aW9uX2V4cGlyZXNfaW4YDCABKANSGnBob25lVm'
    'VyaWZpY2F0aW9uRXhwaXJlc0lu');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'device_id', '3': 3, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 4, '4': 1, '5': 9, '10': 'deviceName'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3N3b3JkGAIgASgJUg'
    'hwYXNzd29yZBIbCglkZXZpY2VfaWQYAyABKAlSCGRldmljZUlkEh8KC2RldmljZV9uYW1lGAQg'
    'ASgJUgpkZXZpY2VOYW1lEhQKBXBob25lGAUgASgJUgVwaG9uZQ==');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 5, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'data', '3': 6, '4': 1, '5': 11, '6': '.pb.LoginData', '10': 'data'},
    {
      '1': 'two_factor_required',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'twoFactorRequired'
    },
    {'1': 'two_factor_token', '3': 8, '4': 1, '5': 9, '10': 'twoFactorToken'},
    {'1': 'step_up_required', '3': 9, '4': 1, '5': 8, '10': 'stepUpRequired'},
    {'1': 'step_up_token', '3': 10, '4': 1, '5': 9, '10': 'stepUpToken'},
    {'1': 'step_up_method', '3': 11, '4': 1, '5': 9, '10': 'stepUpMethod'},
    {
      '1': 'step_up_destination',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'stepUpDestination'
    },
    {
      '1': 'two_factor_method',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'twoFactorMethod'
    },
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode(
    'Cg1Mb2dpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUg'
    'Ntc2cSIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZXNoX3Rva2Vu'
    'GAQgASgJUgxyZWZyZXNoVG9rZW4SHQoKZXhwaXJlc19pbhgFIAEoA1IJZXhwaXJlc0luEiEKBG'
    'RhdGEYBiABKAsyDS5wYi5Mb2dpbkRhdGFSBGRhdGESLgoTdHdvX2ZhY3Rvcl9yZXF1aXJlZBgH'
    'IAEoCFIRdHdvRmFjdG9yUmVxdWlyZWQSKAoQdHdvX2ZhY3Rvcl90b2tlbhgIIAEoCVIOdHdvRm'
    'FjdG9yVG9rZW4SKAoQc3RlcF91cF9yZXF1aXJlZBgJIAEoCFIOc3RlcFVwUmVxdWlyZWQSIgoN'
    'c3RlcF91cF90b2tlbhgKIAEoCVILc3RlcFVwVG9rZW4SJAoOc3RlcF91cF9tZXRob2QYCyABKA'
    'lSDHN0ZXBVcE1ldGhvZBIuChNzdGVwX3VwX2Rlc3RpbmF0aW9uGAwgASgJUhFzdGVwVXBEZXN0'
    'aW5hdGlvbhIqChF0d29fZmFjdG9yX21ldGhvZBgNIAEoCVIPdHdvRmFjdG9yTWV0aG9k');

@$core.Deprecated('Use loginDataDescriptor instead')
const LoginData$json = {
  '1': 'LoginData',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {
      '1': 'session',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.Session',
      '10': 'session'
    },
    {'1': 'has_passcode', '3': 3, '4': 1, '5': 8, '10': 'hasPasscode'},
    {
      '1': 'has_transaction_pin',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'hasTransactionPin'
    },
    {'1': 'has_password', '3': 5, '4': 1, '5': 8, '10': 'hasPassword'},
  ],
};

/// Descriptor for `LoginData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginDataDescriptor = $convert.base64Decode(
    'CglMb2dpbkRhdGESHAoEdXNlchgBIAEoCzIILnBiLlVzZXJSBHVzZXISJQoHc2Vzc2lvbhgCIA'
    'EoCzILLnBiLlNlc3Npb25SB3Nlc3Npb24SIQoMaGFzX3Bhc3Njb2RlGAMgASgIUgtoYXNQYXNz'
    'Y29kZRIuChNoYXNfdHJhbnNhY3Rpb25fcGluGAQgASgIUhFoYXNUcmFuc2FjdGlvblBpbhIhCg'
    'xoYXNfcGFzc3dvcmQYBSABKAhSC2hhc1Bhc3N3b3Jk');

@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = {
  '1': 'Session',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode(
    'CgdTZXNzaW9uEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF'
    '90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJ'
    'bhIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use getAuthenticationConfigRequestDescriptor instead')
const GetAuthenticationConfigRequest$json = {
  '1': 'GetAuthenticationConfigRequest',
};

/// Descriptor for `GetAuthenticationConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAuthenticationConfigRequestDescriptor =
    $convert.base64Decode('Ch5HZXRBdXRoZW50aWNhdGlvbkNvbmZpZ1JlcXVlc3Q=');

@$core.Deprecated('Use getAuthenticationConfigResponseDescriptor instead')
const GetAuthenticationConfigResponse$json = {
  '1': 'GetAuthenticationConfigResponse',
  '2': [
    {
      '1': 'authentication_mode',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'authenticationMode'
    },
    {
      '1': 'email_verification_required',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'emailVerificationRequired'
    },
    {
      '1': 'phone_verification_required',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'phoneVerificationRequired'
    },
  ],
};

/// Descriptor for `GetAuthenticationConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAuthenticationConfigResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRBdXRoZW50aWNhdGlvbkNvbmZpZ1Jlc3BvbnNlEi8KE2F1dGhlbnRpY2F0aW9uX21vZG'
        'UYASABKAlSEmF1dGhlbnRpY2F0aW9uTW9kZRI+ChtlbWFpbF92ZXJpZmljYXRpb25fcmVxdWly'
        'ZWQYAiABKAhSGWVtYWlsVmVyaWZpY2F0aW9uUmVxdWlyZWQSPgobcGhvbmVfdmVyaWZpY2F0aW'
        '9uX3JlcXVpcmVkGAMgASgIUhlwaG9uZVZlcmlmaWNhdGlvblJlcXVpcmVk');

@$core.Deprecated('Use requestSignupPhoneOTPRequestDescriptor instead')
const RequestSignupPhoneOTPRequest$json = {
  '1': 'RequestSignupPhoneOTPRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `RequestSignupPhoneOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestSignupPhoneOTPRequestDescriptor =
    $convert.base64Decode(
        'ChxSZXF1ZXN0U2lnbnVwUGhvbmVPVFBSZXF1ZXN0EhQKBXBob25lGAEgASgJUgVwaG9uZRIhCg'
        'xjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2Rl');

@$core.Deprecated('Use requestSignupPhoneOTPResponseDescriptor instead')
const RequestSignupPhoneOTPResponse$json = {
  '1': 'RequestSignupPhoneOTPResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {
      '1': 'resend_after_seconds',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'resendAfterSeconds'
    },
  ],
};

/// Descriptor for `RequestSignupPhoneOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestSignupPhoneOTPResponseDescriptor =
    $convert.base64Decode(
        'Ch1SZXF1ZXN0U2lnbnVwUGhvbmVPVFBSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
        'NzEhAKA21zZxgCIAEoCVIDbXNnEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJbhIwChRy'
        'ZXNlbmRfYWZ0ZXJfc2Vjb25kcxgEIAEoBVIScmVzZW5kQWZ0ZXJTZWNvbmRz');

@$core.Deprecated('Use verifySignupPhoneOTPRequestDescriptor instead')
const VerifySignupPhoneOTPRequest$json = {
  '1': 'VerifySignupPhoneOTPRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `VerifySignupPhoneOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifySignupPhoneOTPRequestDescriptor =
    $convert.base64Decode(
        'ChtWZXJpZnlTaWdudXBQaG9uZU9UUFJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEhIKBG'
        'NvZGUYAiABKAlSBGNvZGU=');

@$core.Deprecated('Use verifySignupPhoneOTPResponseDescriptor instead')
const VerifySignupPhoneOTPResponse$json = {
  '1': 'VerifySignupPhoneOTPResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'signup_token', '3': 3, '4': 1, '5': 9, '10': 'signupToken'},
    {'1': 'expires_in', '3': 4, '4': 1, '5': 3, '10': 'expiresIn'},
  ],
};

/// Descriptor for `VerifySignupPhoneOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifySignupPhoneOTPResponseDescriptor =
    $convert.base64Decode(
        'ChxWZXJpZnlTaWdudXBQaG9uZU9UUFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
        'MSEAoDbXNnGAIgASgJUgNtc2cSIQoMc2lnbnVwX3Rva2VuGAMgASgJUgtzaWdudXBUb2tlbhId'
        'CgpleHBpcmVzX2luGAQgASgDUglleHBpcmVzSW4=');

@$core.Deprecated('Use signupWithPhoneRequestDescriptor instead')
const SignupWithPhoneRequest$json = {
  '1': 'SignupWithPhoneRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'signup_token', '3': 2, '4': 1, '5': 9, '10': 'signupToken'},
    {'1': 'passcode', '3': 3, '4': 1, '5': 9, '10': 'passcode'},
    {'1': 'first_name', '3': 4, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 5, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 6, '4': 1, '5': 9, '10': 'email'},
    {'1': 'country_code', '3': 7, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'locale', '3': 8, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'username', '3': 9, '4': 1, '5': 9, '10': 'username'},
    {'1': 'referral_code', '3': 10, '4': 1, '5': 9, '10': 'referralCode'},
    {'1': 'device_id', '3': 11, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 12, '4': 1, '5': 9, '10': 'deviceName'},
    {'1': 'date_of_birth', '3': 13, '4': 1, '5': 9, '10': 'dateOfBirth'},
  ],
};

/// Descriptor for `SignupWithPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupWithPhoneRequestDescriptor = $convert.base64Decode(
    'ChZTaWdudXBXaXRoUGhvbmVSZXF1ZXN0EhQKBXBob25lGAEgASgJUgVwaG9uZRIhCgxzaWdudX'
    'BfdG9rZW4YAiABKAlSC3NpZ251cFRva2VuEhoKCHBhc3Njb2RlGAMgASgJUghwYXNzY29kZRId'
    'CgpmaXJzdF9uYW1lGAQgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAUgASgJUghsYXN0Tm'
    'FtZRIUCgVlbWFpbBgGIAEoCVIFZW1haWwSIQoMY291bnRyeV9jb2RlGAcgASgJUgtjb3VudHJ5'
    'Q29kZRIWCgZsb2NhbGUYCCABKAlSBmxvY2FsZRIaCgh1c2VybmFtZRgJIAEoCVIIdXNlcm5hbW'
    'USIwoNcmVmZXJyYWxfY29kZRgKIAEoCVIMcmVmZXJyYWxDb2RlEhsKCWRldmljZV9pZBgLIAEo'
    'CVIIZGV2aWNlSWQSHwoLZGV2aWNlX25hbWUYDCABKAlSCmRldmljZU5hbWUSIgoNZGF0ZV9vZl'
    '9iaXJ0aBgNIAEoCVILZGF0ZU9mQmlydGg=');

@$core.Deprecated('Use loginWithPhonePasscodeRequestDescriptor instead')
const LoginWithPhonePasscodeRequest$json = {
  '1': 'LoginWithPhonePasscodeRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'passcode', '3': 2, '4': 1, '5': 9, '10': 'passcode'},
    {'1': 'device_id', '3': 3, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 4, '4': 1, '5': 9, '10': 'deviceName'},
  ],
};

/// Descriptor for `LoginWithPhonePasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginWithPhonePasscodeRequestDescriptor =
    $convert.base64Decode(
        'Ch1Mb2dpbldpdGhQaG9uZVBhc3Njb2RlUmVxdWVzdBIUCgVwaG9uZRgBIAEoCVIFcGhvbmUSGg'
        'oIcGFzc2NvZGUYAiABKAlSCHBhc3Njb2RlEhsKCWRldmljZV9pZBgDIAEoCVIIZGV2aWNlSWQS'
        'HwoLZGV2aWNlX25hbWUYBCABKAlSCmRldmljZU5hbWU=');

@$core.Deprecated('Use requestPasscodeResetRequestDescriptor instead')
const RequestPasscodeResetRequest$json = {
  '1': 'RequestPasscodeResetRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `RequestPasscodeResetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasscodeResetRequestDescriptor =
    $convert.base64Decode(
        'ChtSZXF1ZXN0UGFzc2NvZGVSZXNldFJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEiEKDG'
        'NvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGU=');

@$core.Deprecated('Use requestPasscodeResetResponseDescriptor instead')
const RequestPasscodeResetResponse$json = {
  '1': 'RequestPasscodeResetResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {
      '1': 'resend_after_seconds',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'resendAfterSeconds'
    },
  ],
};

/// Descriptor for `RequestPasscodeResetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasscodeResetResponseDescriptor =
    $convert.base64Decode(
        'ChxSZXF1ZXN0UGFzc2NvZGVSZXNldFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
        'MSEAoDbXNnGAIgASgJUgNtc2cSHQoKZXhwaXJlc19pbhgDIAEoA1IJZXhwaXJlc0luEjAKFHJl'
        'c2VuZF9hZnRlcl9zZWNvbmRzGAQgASgFUhJyZXNlbmRBZnRlclNlY29uZHM=');

@$core.Deprecated('Use resetPasscodeWithOTPRequestDescriptor instead')
const ResetPasscodeWithOTPRequest$json = {
  '1': 'ResetPasscodeWithOTPRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'new_passcode', '3': 3, '4': 1, '5': 9, '10': 'newPasscode'},
  ],
};

/// Descriptor for `ResetPasscodeWithOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasscodeWithOTPRequestDescriptor =
    $convert.base64Decode(
        'ChtSZXNldFBhc3Njb2RlV2l0aE9UUFJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEhIKBG'
        'NvZGUYAiABKAlSBGNvZGUSIQoMbmV3X3Bhc3Njb2RlGAMgASgJUgtuZXdQYXNzY29kZQ==');

@$core.Deprecated('Use resetPasscodeWithOTPResponseDescriptor instead')
const ResetPasscodeWithOTPResponse$json = {
  '1': 'ResetPasscodeWithOTPResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `ResetPasscodeWithOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasscodeWithOTPResponseDescriptor =
    $convert.base64Decode(
        'ChxSZXNldFBhc3Njb2RlV2l0aE9UUFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
        'MSEAoDbXNnGAIgASgJUgNtc2c=');

@$core.Deprecated('Use verifyPasscodeResetOTPRequestDescriptor instead')
const VerifyPasscodeResetOTPRequest$json = {
  '1': 'VerifyPasscodeResetOTPRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'country_code', '3': 3, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `VerifyPasscodeResetOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasscodeResetOTPRequestDescriptor =
    $convert.base64Decode(
        'Ch1WZXJpZnlQYXNzY29kZVJlc2V0T1RQUmVxdWVzdBIUCgVwaG9uZRgBIAEoCVIFcGhvbmUSEg'
        'oEY29kZRgCIAEoCVIEY29kZRIhCgxjb3VudHJ5X2NvZGUYAyABKAlSC2NvdW50cnlDb2Rl');

@$core.Deprecated('Use verifyPasscodeResetOTPResponseDescriptor instead')
const VerifyPasscodeResetOTPResponse$json = {
  '1': 'VerifyPasscodeResetOTPResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `VerifyPasscodeResetOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasscodeResetOTPResponseDescriptor =
    $convert.base64Decode(
        'Ch5WZXJpZnlQYXNzY29kZVJlc2V0T1RQUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
        'VzcxIQCgNtc2cYAiABKAlSA21zZw==');

@$core.Deprecated('Use requestPhoneChangeRequestDescriptor instead')
const RequestPhoneChangeRequest$json = {
  '1': 'RequestPhoneChangeRequest',
  '2': [
    {'1': 'new_phone', '3': 1, '4': 1, '5': 9, '10': 'newPhone'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `RequestPhoneChangeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhoneChangeRequestDescriptor =
    $convert.base64Decode(
        'ChlSZXF1ZXN0UGhvbmVDaGFuZ2VSZXF1ZXN0EhsKCW5ld19waG9uZRgBIAEoCVIIbmV3UGhvbm'
        'USIQoMY291bnRyeV9jb2RlGAIgASgJUgtjb3VudHJ5Q29kZQ==');

@$core.Deprecated('Use requestPhoneChangeResponseDescriptor instead')
const RequestPhoneChangeResponse$json = {
  '1': 'RequestPhoneChangeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {
      '1': 'resend_after_seconds',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'resendAfterSeconds'
    },
  ],
};

/// Descriptor for `RequestPhoneChangeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhoneChangeResponseDescriptor =
    $convert.base64Decode(
        'ChpSZXF1ZXN0UGhvbmVDaGFuZ2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
        'AKA21zZxgCIAEoCVIDbXNnEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJbhIwChRyZXNl'
        'bmRfYWZ0ZXJfc2Vjb25kcxgEIAEoBVIScmVzZW5kQWZ0ZXJTZWNvbmRz');

@$core.Deprecated('Use verifyPhoneChangeRequestDescriptor instead')
const VerifyPhoneChangeRequest$json = {
  '1': 'VerifyPhoneChangeRequest',
  '2': [
    {'1': 'new_phone', '3': 1, '4': 1, '5': 9, '10': 'newPhone'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'country_code', '3': 3, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `VerifyPhoneChangeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneChangeRequestDescriptor = $convert.base64Decode(
    'ChhWZXJpZnlQaG9uZUNoYW5nZVJlcXVlc3QSGwoJbmV3X3Bob25lGAEgASgJUghuZXdQaG9uZR'
    'ISCgRjb2RlGAIgASgJUgRjb2RlEiEKDGNvdW50cnlfY29kZRgDIAEoCVILY291bnRyeUNvZGU=');

@$core.Deprecated('Use verifyPhoneChangeResponseDescriptor instead')
const VerifyPhoneChangeResponse$json = {
  '1': 'VerifyPhoneChangeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `VerifyPhoneChangeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneChangeResponseDescriptor =
    $convert.base64Decode(
        'ChlWZXJpZnlQaG9uZUNoYW5nZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEA'
        'oDbXNnGAIgASgJUgNtc2cSFAoFcGhvbmUYAyABKAlSBXBob25l');

@$core.Deprecated('Use setPreferredLoginMethodRequestDescriptor instead')
const SetPreferredLoginMethodRequest$json = {
  '1': 'SetPreferredLoginMethodRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
  ],
};

/// Descriptor for `SetPreferredLoginMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPreferredLoginMethodRequestDescriptor =
    $convert.base64Decode(
        'Ch5TZXRQcmVmZXJyZWRMb2dpbk1ldGhvZFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlck'
        'lkEhYKBm1ldGhvZBgCIAEoCVIGbWV0aG9k');

@$core.Deprecated('Use setPreferredLoginMethodResponseDescriptor instead')
const SetPreferredLoginMethodResponse$json = {
  '1': 'SetPreferredLoginMethodResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {
      '1': 'preferred_login_method',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'preferredLoginMethod'
    },
  ],
};

/// Descriptor for `SetPreferredLoginMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPreferredLoginMethodResponseDescriptor =
    $convert.base64Decode(
        'Ch9TZXRQcmVmZXJyZWRMb2dpbk1ldGhvZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
        'Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSNAoWcHJlZmVycmVkX2xvZ2luX21ldGhvZBgDIAEoCVIU'
        'cHJlZmVycmVkTG9naW5NZXRob2Q=');

@$core.Deprecated('Use adminSetPreferredLoginMethodRequestDescriptor instead')
const AdminSetPreferredLoginMethodRequest$json = {
  '1': 'AdminSetPreferredLoginMethodRequest',
  '2': [
    {'1': 'target_user_id', '3': 1, '4': 1, '5': 9, '10': 'targetUserId'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
  ],
};

/// Descriptor for `AdminSetPreferredLoginMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetPreferredLoginMethodRequestDescriptor =
    $convert.base64Decode(
        'CiNBZG1pblNldFByZWZlcnJlZExvZ2luTWV0aG9kUmVxdWVzdBIkCg50YXJnZXRfdXNlcl9pZB'
        'gBIAEoCVIMdGFyZ2V0VXNlcklkEhYKBm1ldGhvZBgCIAEoCVIGbWV0aG9k');

@$core.Deprecated('Use setPasswordRequestDescriptor instead')
const SetPasswordRequest$json = {
  '1': 'SetPasswordRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `SetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasswordRequestDescriptor = $convert.base64Decode(
    'ChJTZXRQYXNzd29yZFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiEKDG5ld19wYX'
    'Nzd29yZBgCIAEoCVILbmV3UGFzc3dvcmQ=');

@$core.Deprecated('Use setPasswordResponseDescriptor instead')
const SetPasswordResponse$json = {
  '1': 'SetPasswordResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `SetPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasswordResponseDescriptor = $convert.base64Decode(
    'ChNTZXRQYXNzd29yZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGA'
    'IgASgJUgNtc2c=');

@$core.Deprecated('Use refreshTokenRequestDescriptor instead')
const RefreshTokenRequest$json = {
  '1': 'RefreshTokenRequest',
  '2': [
    {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `RefreshTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenRequestDescriptor = $convert.base64Decode(
    'ChNSZWZyZXNoVG9rZW5SZXF1ZXN0EiMKDXJlZnJlc2hfdG9rZW4YASABKAlSDHJlZnJlc2hUb2'
    'tlbg==');

@$core.Deprecated('Use refreshTokenResponseDescriptor instead')
const RefreshTokenResponse$json = {
  '1': 'RefreshTokenResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `RefreshTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenResponseDescriptor = $convert.base64Decode(
    'ChRSZWZyZXNoVG9rZW5SZXNwb25zZRIhCgxhY2Nlc3NfdG9rZW4YASABKAlSC2FjY2Vzc1Rva2'
    'VuEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbhIdCgpleHBpcmVzX2luGAMg'
    'ASgDUglleHBpcmVzSW4SHAoEdXNlchgEIAEoCzIILnBiLlVzZXJSBHVzZXI=');

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert.base64Decode(
    'Cg1Mb2dvdXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIjCg1yZWZyZXNoX3Rva2'
    'VuGAIgASgJUgxyZWZyZXNoVG9rZW4=');

@$core.Deprecated('Use logoutResponseDescriptor instead')
const LogoutResponse$json = {
  '1': 'LogoutResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `LogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutResponseDescriptor = $convert
    .base64Decode('Cg5Mb2dvdXRSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use verifyEmailRequestDescriptor instead')
const VerifyEmailRequest$json = {
  '1': 'VerifyEmailRequest',
  '2': [
    {'1': 'verificationCode', '3': 1, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
};

/// Descriptor for `VerifyEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailRequestDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlFbWFpbFJlcXVlc3QSKgoQdmVyaWZpY2F0aW9uQ29kZRgBIAEoCVIQdmVyaWZpY2'
    'F0aW9uQ29kZQ==');

@$core.Deprecated('Use verifyEmailResponseDescriptor instead')
const VerifyEmailResponse$json = {
  '1': 'VerifyEmailResponse',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `VerifyEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailResponseDescriptor = $convert.base64Decode(
    'ChNWZXJpZnlFbWFpbFJlc3BvbnNlEhAKA21zZxgBIAEoCVIDbXNnEhgKB3N1Y2Nlc3MYAiABKA'
    'hSB3N1Y2Nlc3M=');

@$core.Deprecated('Use resendVerificationEmailRequestDescriptor instead')
const ResendVerificationEmailRequest$json = {
  '1': 'ResendVerificationEmailRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `ResendVerificationEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendVerificationEmailRequestDescriptor =
    $convert.base64Decode(
        'Ch5SZXNlbmRWZXJpZmljYXRpb25FbWFpbFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');

@$core.Deprecated('Use resendVerificationEmailResponseDescriptor instead')
const ResendVerificationEmailResponse$json = {
  '1': 'ResendVerificationEmailResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'cooldown_seconds', '3': 3, '4': 1, '5': 5, '10': 'cooldownSeconds'},
  ],
};

/// Descriptor for `ResendVerificationEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendVerificationEmailResponseDescriptor =
    $convert.base64Decode(
        'Ch9SZXNlbmRWZXJpZmljYXRpb25FbWFpbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
        'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIpChBjb29sZG93bl9zZWNvbmRzGAMgASgF'
        'Ug9jb29sZG93blNlY29uZHM=');

@$core.Deprecated('Use verifyPhoneRequestDescriptor instead')
const VerifyPhoneRequest$json = {
  '1': 'VerifyPhoneRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `VerifyPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneRequestDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlQaG9uZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhIKBGNvZGUYAi'
    'ABKAlSBGNvZGUSFAoFcGhvbmUYAyABKAlSBXBob25l');

@$core.Deprecated('Use verifyPhoneResponseDescriptor instead')
const VerifyPhoneResponse$json = {
  '1': 'VerifyPhoneResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `VerifyPhoneResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneResponseDescriptor = $convert.base64Decode(
    'ChNWZXJpZnlQaG9uZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USGAoHc3VjY2'
    'VzcxgCIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use resendPhoneVerificationRequestDescriptor instead')
const ResendPhoneVerificationRequest$json = {
  '1': 'ResendPhoneVerificationRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `ResendPhoneVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendPhoneVerificationRequestDescriptor =
    $convert.base64Decode(
        'Ch5SZXNlbmRQaG9uZVZlcmlmaWNhdGlvblJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEh'
        'cKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use resendPhoneVerificationResponseDescriptor instead')
const ResendPhoneVerificationResponse$json = {
  '1': 'ResendPhoneVerificationResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ResendPhoneVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendPhoneVerificationResponseDescriptor =
    $convert.base64Decode(
        'Ch9SZXNlbmRQaG9uZVZlcmlmaWNhdGlvblJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3'
        'NhZ2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use forgotPasswordRequestDescriptor instead')
const ForgotPasswordRequest$json = {
  '1': 'ForgotPasswordRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 2, '4': 1, '5': 9, '10': 'phone'},
    {
      '1': 'delivery_method',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.PasswordResetDeliveryMethod',
      '10': 'deliveryMethod'
    },
  ],
};

/// Descriptor for `ForgotPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordRequestDescriptor = $convert.base64Decode(
    'ChVGb3Jnb3RQYXNzd29yZFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhQKBXBob25lGA'
    'IgASgJUgVwaG9uZRJICg9kZWxpdmVyeV9tZXRob2QYAyABKA4yHy5wYi5QYXNzd29yZFJlc2V0'
    'RGVsaXZlcnlNZXRob2RSDmRlbGl2ZXJ5TWV0aG9k');

@$core.Deprecated('Use forgotPasswordResponseDescriptor instead')
const ForgotPasswordResponse$json = {
  '1': 'ForgotPasswordResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'delivery_method', '3': 3, '4': 1, '5': 9, '10': 'deliveryMethod'},
    {'1': 'masked_contact', '3': 4, '4': 1, '5': 9, '10': 'maskedContact'},
    {
      '1': 'expires_in_seconds',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'expiresInSeconds'
    },
    {'1': 'user_found', '3': 6, '4': 1, '5': 8, '10': 'userFound'},
  ],
};

/// Descriptor for `ForgotPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordResponseDescriptor = $convert.base64Decode(
    'ChZGb3Jnb3RQYXNzd29yZFJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USGAoHc3'
    'VjY2VzcxgCIAEoCFIHc3VjY2VzcxInCg9kZWxpdmVyeV9tZXRob2QYAyABKAlSDmRlbGl2ZXJ5'
    'TWV0aG9kEiUKDm1hc2tlZF9jb250YWN0GAQgASgJUg1tYXNrZWRDb250YWN0EiwKEmV4cGlyZX'
    'NfaW5fc2Vjb25kcxgFIAEoA1IQZXhwaXJlc0luU2Vjb25kcxIdCgp1c2VyX2ZvdW5kGAYgASgI'
    'Ugl1c2VyRm91bmQ=');

@$core.Deprecated('Use verifyPasswordResetCodeRequestDescriptor instead')
const VerifyPasswordResetCodeRequest$json = {
  '1': 'VerifyPasswordResetCodeRequest',
  '2': [
    {'1': 'contact', '3': 1, '4': 1, '5': 9, '10': 'contact'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {
      '1': 'delivery_method',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.PasswordResetDeliveryMethod',
      '10': 'deliveryMethod'
    },
  ],
};

/// Descriptor for `VerifyPasswordResetCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasswordResetCodeRequestDescriptor =
    $convert.base64Decode(
        'Ch5WZXJpZnlQYXNzd29yZFJlc2V0Q29kZVJlcXVlc3QSGAoHY29udGFjdBgBIAEoCVIHY29udG'
        'FjdBISCgRjb2RlGAIgASgJUgRjb2RlEkgKD2RlbGl2ZXJ5X21ldGhvZBgDIAEoDjIfLnBiLlBh'
        'c3N3b3JkUmVzZXREZWxpdmVyeU1ldGhvZFIOZGVsaXZlcnlNZXRob2Q=');

@$core.Deprecated('Use verifyPasswordResetCodeResponseDescriptor instead')
const VerifyPasswordResetCodeResponse$json = {
  '1': 'VerifyPasswordResetCodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'reset_token', '3': 3, '4': 1, '5': 9, '10': 'resetToken'},
    {
      '1': 'expires_in_seconds',
      '3': 4,
      '4': 1,
      '5': 3,
      '10': 'expiresInSeconds'
    },
  ],
};

/// Descriptor for `VerifyPasswordResetCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasswordResetCodeResponseDescriptor =
    $convert.base64Decode(
        'Ch9WZXJpZnlQYXNzd29yZFJlc2V0Q29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
        'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgtyZXNldF90b2tlbhgDIAEoCVIKcmVz'
        'ZXRUb2tlbhIsChJleHBpcmVzX2luX3NlY29uZHMYBCABKANSEGV4cGlyZXNJblNlY29uZHM=');

@$core.Deprecated('Use resetPasswordRequestDescriptor instead')
const ResetPasswordRequest$json = {
  '1': 'ResetPasswordRequest',
  '2': [
    {'1': 'reset_token', '3': 1, '4': 1, '5': 9, '10': 'resetToken'},
    {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ResetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordRequestDescriptor = $convert.base64Decode(
    'ChRSZXNldFBhc3N3b3JkUmVxdWVzdBIfCgtyZXNldF90b2tlbhgBIAEoCVIKcmVzZXRUb2tlbh'
    'IhCgxuZXdfcGFzc3dvcmQYAiABKAlSC25ld1Bhc3N3b3Jk');

@$core.Deprecated('Use resetPasswordResponseDescriptor instead')
const ResetPasswordResponse$json = {
  '1': 'ResetPasswordResponse',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ResetPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordResponseDescriptor = $convert.base64Decode(
    'ChVSZXNldFBhc3N3b3JkUmVzcG9uc2USEAoDbXNnGAEgASgJUgNtc2cSGAoHc3VjY2VzcxgCIA'
    'EoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use changePasswordRequestDescriptor instead')
const ChangePasswordRequest$json = {
  '1': 'ChangePasswordRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'current_password', '3': 2, '4': 1, '5': 9, '10': 'currentPassword'},
    {'1': 'new_password', '3': 3, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ChangePasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasswordRequestDescriptor = $convert.base64Decode(
    'ChVDaGFuZ2VQYXNzd29yZFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEikKEGN1cn'
    'JlbnRfcGFzc3dvcmQYAiABKAlSD2N1cnJlbnRQYXNzd29yZBIhCgxuZXdfcGFzc3dvcmQYAyAB'
    'KAlSC25ld1Bhc3N3b3Jk');

@$core.Deprecated('Use changePasswordResponseDescriptor instead')
const ChangePasswordResponse$json = {
  '1': 'ChangePasswordResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ChangePasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasswordResponseDescriptor =
    $convert.base64Decode(
        'ChZDaGFuZ2VQYXNzd29yZFJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getMeRequestDescriptor instead')
const GetMeRequest$json = {
  '1': 'GetMeRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetMeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeRequestDescriptor = $convert
    .base64Decode('CgxHZXRNZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getMeResponseDescriptor instead')
const GetMeResponse$json = {
  '1': 'GetMeResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {'1': 'has_passcode', '3': 2, '4': 1, '5': 8, '10': 'hasPasscode'},
    {'1': 'has_password', '3': 3, '4': 1, '5': 8, '10': 'hasPassword'},
    {
      '1': 'preferred_login_method',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'preferredLoginMethod'
    },
  ],
};

/// Descriptor for `GetMeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeResponseDescriptor = $convert.base64Decode(
    'Cg1HZXRNZVJlc3BvbnNlEhwKBHVzZXIYASABKAsyCC5wYi5Vc2VyUgR1c2VyEiEKDGhhc19wYX'
    'NzY29kZRgCIAEoCFILaGFzUGFzc2NvZGUSIQoMaGFzX3Bhc3N3b3JkGAMgASgIUgtoYXNQYXNz'
    'd29yZBI0ChZwcmVmZXJyZWRfbG9naW5fbWV0aG9kGAQgASgJUhRwcmVmZXJyZWRMb2dpbk1ldG'
    'hvZA==');

@$core.Deprecated('Use updateProfileRequestDescriptor instead')
const UpdateProfileRequest$json = {
  '1': 'UpdateProfileRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'profile_picture', '3': 6, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `UpdateProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProfileRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVQcm9maWxlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHQoKZmlyc3'
    'RfbmFtZRgCIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgDIAEoCVIIbGFzdE5hbWUSGgoI'
    'dXNlcm5hbWUYBCABKAlSCHVzZXJuYW1lEhQKBXBob25lGAUgASgJUgVwaG9uZRInCg9wcm9maW'
    'xlX3BpY3R1cmUYBiABKAlSDnByb2ZpbGVQaWN0dXJl');

@$core.Deprecated('Use updateProfileResponseDescriptor instead')
const UpdateProfileResponse$json = {
  '1': 'UpdateProfileResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `UpdateProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProfileResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVQcm9maWxlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2'
    'cYAiABKAlSA21zZxIcCgR1c2VyGAMgASgLMggucGIuVXNlclIEdXNlcg==');

@$core.Deprecated('Use facialLoginRequestDescriptor instead')
const FacialLoginRequest$json = {
  '1': 'FacialLoginRequest',
  '2': [
    {'1': 'facial_data', '3': 1, '4': 1, '5': 12, '10': 'facialData'},
    {'1': 'device_id', '3': 2, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `FacialLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialLoginRequestDescriptor = $convert.base64Decode(
    'ChJGYWNpYWxMb2dpblJlcXVlc3QSHwoLZmFjaWFsX2RhdGEYASABKAxSCmZhY2lhbERhdGESGw'
    'oJZGV2aWNlX2lkGAIgASgJUghkZXZpY2VJZA==');

@$core.Deprecated('Use facialLoginResponseDescriptor instead')
const FacialLoginResponse$json = {
  '1': 'FacialLoginResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `FacialLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialLoginResponseDescriptor = $convert.base64Decode(
    'ChNGYWNpYWxMb2dpblJlc3BvbnNlEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW'
    '4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyAB'
    'KANSCWV4cGlyZXNJbhIcCgR1c2VyGAQgASgLMggucGIuVXNlclIEdXNlcg==');

@$core.Deprecated('Use socialLoginRequestDescriptor instead')
const SocialLoginRequest$json = {
  '1': 'SocialLoginRequest',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'first_name', '3': 4, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 5, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'provider_user_id', '3': 6, '4': 1, '5': 9, '10': 'providerUserId'},
  ],
};

/// Descriptor for `SocialLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialLoginRequestDescriptor = $convert.base64Decode(
    'ChJTb2NpYWxMb2dpblJlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEiUKDnByb3'
    'ZpZGVyX3Rva2VuGAIgASgJUg1wcm92aWRlclRva2VuEhQKBWVtYWlsGAMgASgJUgVlbWFpbBId'
    'CgpmaXJzdF9uYW1lGAQgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAUgASgJUghsYXN0Tm'
    'FtZRIoChBwcm92aWRlcl91c2VyX2lkGAYgASgJUg5wcm92aWRlclVzZXJJZA==');

@$core.Deprecated('Use socialLoginResponseDescriptor instead')
const SocialLoginResponse$json = {
  '1': 'SocialLoginResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {'1': 'is_new_user', '3': 5, '4': 1, '5': 8, '10': 'isNewUser'},
  ],
};

/// Descriptor for `SocialLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialLoginResponseDescriptor = $convert.base64Decode(
    'ChNTb2NpYWxMb2dpblJlc3BvbnNlEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW'
    '4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyAB'
    'KANSCWV4cGlyZXNJbhIcCgR1c2VyGAQgASgLMggucGIuVXNlclIEdXNlchIeCgtpc19uZXdfdX'
    'NlchgFIAEoCFIJaXNOZXdVc2Vy');

@$core.Deprecated('Use linkedSocialAccountDescriptor instead')
const LinkedSocialAccount$json = {
  '1': 'LinkedSocialAccount',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_user_id', '3': 4, '4': 1, '5': 9, '10': 'providerUserId'},
    {'1': 'provider_email', '3': 5, '4': 1, '5': 9, '10': 'providerEmail'},
    {'1': 'display_name', '3': 6, '4': 1, '5': 9, '10': 'displayName'},
    {
      '1': 'profile_picture_url',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'profilePictureUrl'
    },
    {'1': 'profile_url', '3': 8, '4': 1, '5': 9, '10': 'profileUrl'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'is_primary', '3': 10, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'linked_at', '3': 11, '4': 1, '5': 9, '10': 'linkedAt'},
    {'1': 'last_used_at', '3': 12, '4': 1, '5': 9, '10': 'lastUsedAt'},
  ],
};

/// Descriptor for `LinkedSocialAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedSocialAccountDescriptor = $convert.base64Decode(
    'ChNMaW5rZWRTb2NpYWxBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSGgoIcHJvdmlkZXIYAyABKAlSCHByb3ZpZGVyEigKEHByb3ZpZGVyX3VzZXJfaWQY'
    'BCABKAlSDnByb3ZpZGVyVXNlcklkEiUKDnByb3ZpZGVyX2VtYWlsGAUgASgJUg1wcm92aWRlck'
    'VtYWlsEiEKDGRpc3BsYXlfbmFtZRgGIAEoCVILZGlzcGxheU5hbWUSLgoTcHJvZmlsZV9waWN0'
    'dXJlX3VybBgHIAEoCVIRcHJvZmlsZVBpY3R1cmVVcmwSHwoLcHJvZmlsZV91cmwYCCABKAlSCn'
    'Byb2ZpbGVVcmwSFgoGc3RhdHVzGAkgASgJUgZzdGF0dXMSHQoKaXNfcHJpbWFyeRgKIAEoCFIJ'
    'aXNQcmltYXJ5EhsKCWxpbmtlZF9hdBgLIAEoCVIIbGlua2VkQXQSIAoMbGFzdF91c2VkX2F0GA'
    'wgASgJUgpsYXN0VXNlZEF0');

@$core.Deprecated('Use getLinkedSocialAccountsRequestDescriptor instead')
const GetLinkedSocialAccountsRequest$json = {
  '1': 'GetLinkedSocialAccountsRequest',
};

/// Descriptor for `GetLinkedSocialAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedSocialAccountsRequestDescriptor =
    $convert.base64Decode('Ch5HZXRMaW5rZWRTb2NpYWxBY2NvdW50c1JlcXVlc3Q=');

@$core.Deprecated('Use getLinkedSocialAccountsResponseDescriptor instead')
const GetLinkedSocialAccountsResponse$json = {
  '1': 'GetLinkedSocialAccountsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'accounts',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.pb.LinkedSocialAccount',
      '10': 'accounts'
    },
    {'1': 'total_count', '3': 3, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetLinkedSocialAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedSocialAccountsResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRMaW5rZWRTb2NpYWxBY2NvdW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
        'Nlc3MSMwoIYWNjb3VudHMYAiADKAsyFy5wYi5MaW5rZWRTb2NpYWxBY2NvdW50UghhY2NvdW50'
        'cxIfCgt0b3RhbF9jb3VudBgDIAEoBVIKdG90YWxDb3VudA==');

@$core.Deprecated('Use linkSocialAccountRequestDescriptor instead')
const LinkSocialAccountRequest$json = {
  '1': 'LinkSocialAccountRequest',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
    {'1': 'provider_user_id', '3': 3, '4': 1, '5': 9, '10': 'providerUserId'},
    {'1': 'provider_email', '3': 4, '4': 1, '5': 9, '10': 'providerEmail'},
    {'1': 'display_name', '3': 5, '4': 1, '5': 9, '10': 'displayName'},
    {
      '1': 'profile_picture_url',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'profilePictureUrl'
    },
    {'1': 'profile_url', '3': 7, '4': 1, '5': 9, '10': 'profileUrl'},
    {'1': 'set_as_primary', '3': 8, '4': 1, '5': 8, '10': 'setAsPrimary'},
  ],
};

/// Descriptor for `LinkSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkSocialAccountRequestDescriptor = $convert.base64Decode(
    'ChhMaW5rU29jaWFsQWNjb3VudFJlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEi'
    'UKDnByb3ZpZGVyX3Rva2VuGAIgASgJUg1wcm92aWRlclRva2VuEigKEHByb3ZpZGVyX3VzZXJf'
    'aWQYAyABKAlSDnByb3ZpZGVyVXNlcklkEiUKDnByb3ZpZGVyX2VtYWlsGAQgASgJUg1wcm92aW'
    'RlckVtYWlsEiEKDGRpc3BsYXlfbmFtZRgFIAEoCVILZGlzcGxheU5hbWUSLgoTcHJvZmlsZV9w'
    'aWN0dXJlX3VybBgGIAEoCVIRcHJvZmlsZVBpY3R1cmVVcmwSHwoLcHJvZmlsZV91cmwYByABKA'
    'lSCnByb2ZpbGVVcmwSJAoOc2V0X2FzX3ByaW1hcnkYCCABKAhSDHNldEFzUHJpbWFyeQ==');

@$core.Deprecated('Use linkSocialAccountResponseDescriptor instead')
const LinkSocialAccountResponse$json = {
  '1': 'LinkSocialAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'account',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pb.LinkedSocialAccount',
      '10': 'account'
    },
  ],
};

/// Descriptor for `LinkSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkSocialAccountResponseDescriptor = $convert.base64Decode(
    'ChlMaW5rU29jaWFsQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIxCgdhY2NvdW50GAMgASgLMhcucGIuTGlua2VkU29j'
    'aWFsQWNjb3VudFIHYWNjb3VudA==');

@$core.Deprecated('Use unlinkSocialAccountRequestDescriptor instead')
const UnlinkSocialAccountRequest$json = {
  '1': 'UnlinkSocialAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `UnlinkSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkSocialAccountRequestDescriptor =
    $convert.base64Decode(
        'ChpVbmxpbmtTb2NpYWxBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW'
        '50SWQ=');

@$core.Deprecated('Use unlinkSocialAccountResponseDescriptor instead')
const UnlinkSocialAccountResponse$json = {
  '1': 'UnlinkSocialAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnlinkSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkSocialAccountResponseDescriptor =
    $convert.base64Decode(
        'ChtVbmxpbmtTb2NpYWxBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
        'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use setPrimarySocialAccountRequestDescriptor instead')
const SetPrimarySocialAccountRequest$json = {
  '1': 'SetPrimarySocialAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `SetPrimarySocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrimarySocialAccountRequestDescriptor =
    $convert.base64Decode(
        'Ch5TZXRQcmltYXJ5U29jaWFsQWNjb3VudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYW'
        'Njb3VudElk');

@$core.Deprecated('Use setPrimarySocialAccountResponseDescriptor instead')
const SetPrimarySocialAccountResponse$json = {
  '1': 'SetPrimarySocialAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'account',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pb.LinkedSocialAccount',
      '10': 'account'
    },
  ],
};

/// Descriptor for `SetPrimarySocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrimarySocialAccountResponseDescriptor =
    $convert.base64Decode(
        'Ch9TZXRQcmltYXJ5U29jaWFsQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
        'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIxCgdhY2NvdW50GAMgASgLMhcucGIuTGlu'
        'a2VkU29jaWFsQWNjb3VudFIHYWNjb3VudA==');

@$core.Deprecated('Use reauthorizeSocialAccountRequestDescriptor instead')
const ReauthorizeSocialAccountRequest$json = {
  '1': 'ReauthorizeSocialAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
  ],
};

/// Descriptor for `ReauthorizeSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reauthorizeSocialAccountRequestDescriptor =
    $convert.base64Decode(
        'Ch9SZWF1dGhvcml6ZVNvY2lhbEFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCW'
        'FjY291bnRJZBIlCg5wcm92aWRlcl90b2tlbhgCIAEoCVINcHJvdmlkZXJUb2tlbg==');

@$core.Deprecated('Use reauthorizeSocialAccountResponseDescriptor instead')
const ReauthorizeSocialAccountResponse$json = {
  '1': 'ReauthorizeSocialAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'account',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pb.LinkedSocialAccount',
      '10': 'account'
    },
  ],
};

/// Descriptor for `ReauthorizeSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reauthorizeSocialAccountResponseDescriptor =
    $convert.base64Decode(
        'CiBSZWF1dGhvcml6ZVNvY2lhbEFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
        'NjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USMQoHYWNjb3VudBgDIAEoCzIXLnBiLkxp'
        'bmtlZFNvY2lhbEFjY291bnRSB2FjY291bnQ=');

@$core.Deprecated('Use enableTwoFactorRequestDescriptor instead')
const EnableTwoFactorRequest$json = {
  '1': 'EnableTwoFactorRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
  ],
};

/// Descriptor for `EnableTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableTwoFactorRequestDescriptor =
    $convert.base64Decode(
        'ChZFbmFibGVUd29GYWN0b3JSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIWCgZtZX'
        'Rob2QYAiABKAlSBm1ldGhvZA==');

@$core.Deprecated('Use enableTwoFactorResponseDescriptor instead')
const EnableTwoFactorResponse$json = {
  '1': 'EnableTwoFactorResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'qr_code', '3': 2, '4': 1, '5': 9, '10': 'qrCode'},
    {'1': 'secret', '3': 3, '4': 1, '5': 9, '10': 'secret'},
    {'1': 'backup_codes', '3': 4, '4': 3, '5': 9, '10': 'backupCodes'},
    {'1': 'method_name', '3': 5, '4': 1, '5': 9, '10': 'methodName'},
    {
      '1': 'verification_required',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'verificationRequired'
    },
  ],
};

/// Descriptor for `EnableTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableTwoFactorResponseDescriptor = $convert.base64Decode(
    'ChdFbmFibGVUd29GYWN0b3JSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEhcKB3'
    'FyX2NvZGUYAiABKAlSBnFyQ29kZRIWCgZzZWNyZXQYAyABKAlSBnNlY3JldBIhCgxiYWNrdXBf'
    'Y29kZXMYBCADKAlSC2JhY2t1cENvZGVzEh8KC21ldGhvZF9uYW1lGAUgASgJUgptZXRob2ROYW'
    '1lEjMKFXZlcmlmaWNhdGlvbl9yZXF1aXJlZBgGIAEoCFIUdmVyaWZpY2F0aW9uUmVxdWlyZWQ=');

@$core.Deprecated('Use verifyTwoFactorRequestDescriptor instead')
const VerifyTwoFactorRequest$json = {
  '1': 'VerifyTwoFactorRequest',
  '2': [
    {'1': 'two_factor_token', '3': 1, '4': 1, '5': 9, '10': 'twoFactorToken'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'method', '3': 3, '4': 1, '5': 9, '10': 'method'},
  ],
};

/// Descriptor for `VerifyTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTwoFactorRequestDescriptor = $convert.base64Decode(
    'ChZWZXJpZnlUd29GYWN0b3JSZXF1ZXN0EigKEHR3b19mYWN0b3JfdG9rZW4YASABKAlSDnR3b0'
    'ZhY3RvclRva2VuEhIKBGNvZGUYAiABKAlSBGNvZGUSFgoGbWV0aG9kGAMgASgJUgZtZXRob2Q=');

@$core.Deprecated('Use verifyTwoFactorResponseDescriptor instead')
const VerifyTwoFactorResponse$json = {
  '1': 'VerifyTwoFactorResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {'1': 'has_passcode', '3': 5, '4': 1, '5': 8, '10': 'hasPasscode'},
    {
      '1': 'has_transaction_pin',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'hasTransactionPin'
    },
  ],
};

/// Descriptor for `VerifyTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTwoFactorResponseDescriptor = $convert.base64Decode(
    'ChdWZXJpZnlUd29GYWN0b3JSZXNwb25zZRIhCgxhY2Nlc3NfdG9rZW4YASABKAlSC2FjY2Vzc1'
    'Rva2VuEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbhIdCgpleHBpcmVzX2lu'
    'GAMgASgDUglleHBpcmVzSW4SHAoEdXNlchgEIAEoCzIILnBiLlVzZXJSBHVzZXISIQoMaGFzX3'
    'Bhc3Njb2RlGAUgASgIUgtoYXNQYXNzY29kZRIuChNoYXNfdHJhbnNhY3Rpb25fcGluGAYgASgI'
    'UhFoYXNUcmFuc2FjdGlvblBpbg==');

@$core.Deprecated('Use completeTwoFactorSetupRequestDescriptor instead')
const CompleteTwoFactorSetupRequest$json = {
  '1': 'CompleteTwoFactorSetupRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `CompleteTwoFactorSetupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeTwoFactorSetupRequestDescriptor =
    $convert.base64Decode(
        'Ch1Db21wbGV0ZVR3b0ZhY3RvclNldHVwUmVxdWVzdBISCgRjb2RlGAEgASgJUgRjb2Rl');

@$core.Deprecated('Use completeTwoFactorSetupResponseDescriptor instead')
const CompleteTwoFactorSetupResponse$json = {
  '1': 'CompleteTwoFactorSetupResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CompleteTwoFactorSetupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeTwoFactorSetupResponseDescriptor =
    $convert.base64Decode(
        'Ch5Db21wbGV0ZVR3b0ZhY3RvclNldHVwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
        'VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use disableTwoFactorRequestDescriptor instead')
const DisableTwoFactorRequest$json = {
  '1': 'DisableTwoFactorRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `DisableTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableTwoFactorRequestDescriptor =
    $convert.base64Decode(
        'ChdEaXNhYmxlVHdvRmFjdG9yUmVxdWVzdBISCgRjb2RlGAEgASgJUgRjb2Rl');

@$core.Deprecated('Use disableTwoFactorResponseDescriptor instead')
const DisableTwoFactorResponse$json = {
  '1': 'DisableTwoFactorResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DisableTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableTwoFactorResponseDescriptor =
    $convert.base64Decode(
        'ChhEaXNhYmxlVHdvRmFjdG9yUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
        'dtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getTwoFactorStatusRequestDescriptor instead')
const GetTwoFactorStatusRequest$json = {
  '1': 'GetTwoFactorStatusRequest',
};

/// Descriptor for `GetTwoFactorStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTwoFactorStatusRequestDescriptor =
    $convert.base64Decode('ChlHZXRUd29GYWN0b3JTdGF0dXNSZXF1ZXN0');

@$core.Deprecated('Use getTwoFactorStatusResponseDescriptor instead')
const GetTwoFactorStatusResponse$json = {
  '1': 'GetTwoFactorStatusResponse',
  '2': [
    {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
    {'1': 'method_name', '3': 3, '4': 1, '5': 9, '10': 'methodName'},
    {
      '1': 'method_description',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'methodDescription'
    },
    {
      '1': 'backup_codes_count',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'backupCodesCount'
    },
    {'1': 'has_backup_codes', '3': 6, '4': 1, '5': 8, '10': 'hasBackupCodes'},
  ],
};

/// Descriptor for `GetTwoFactorStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTwoFactorStatusResponseDescriptor = $convert.base64Decode(
    'ChpHZXRUd29GYWN0b3JTdGF0dXNSZXNwb25zZRIYCgdlbmFibGVkGAEgASgIUgdlbmFibGVkEh'
    'YKBm1ldGhvZBgCIAEoCVIGbWV0aG9kEh8KC21ldGhvZF9uYW1lGAMgASgJUgptZXRob2ROYW1l'
    'Ei0KEm1ldGhvZF9kZXNjcmlwdGlvbhgEIAEoCVIRbWV0aG9kRGVzY3JpcHRpb24SLAoSYmFja3'
    'VwX2NvZGVzX2NvdW50GAUgASgFUhBiYWNrdXBDb2Rlc0NvdW50EigKEGhhc19iYWNrdXBfY29k'
    'ZXMYBiABKAhSDmhhc0JhY2t1cENvZGVz');

@$core.Deprecated('Use regenerateBackupCodesRequestDescriptor instead')
const RegenerateBackupCodesRequest$json = {
  '1': 'RegenerateBackupCodesRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `RegenerateBackupCodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List regenerateBackupCodesRequestDescriptor =
    $convert.base64Decode(
        'ChxSZWdlbmVyYXRlQmFja3VwQ29kZXNSZXF1ZXN0EhIKBGNvZGUYASABKAlSBGNvZGU=');

@$core.Deprecated('Use regenerateBackupCodesResponseDescriptor instead')
const RegenerateBackupCodesResponse$json = {
  '1': 'RegenerateBackupCodesResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'backup_codes', '3': 3, '4': 3, '5': 9, '10': 'backupCodes'},
  ],
};

/// Descriptor for `RegenerateBackupCodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List regenerateBackupCodesResponseDescriptor =
    $convert.base64Decode(
        'Ch1SZWdlbmVyYXRlQmFja3VwQ29kZXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
        'NzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIQoMYmFja3VwX2NvZGVzGAMgAygJUgtiYWNr'
        'dXBDb2Rlcw==');

@$core.Deprecated('Use sendTwoFactorCodeRequestDescriptor instead')
const SendTwoFactorCodeRequest$json = {
  '1': 'SendTwoFactorCodeRequest',
};

/// Descriptor for `SendTwoFactorCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendTwoFactorCodeRequestDescriptor =
    $convert.base64Decode('ChhTZW5kVHdvRmFjdG9yQ29kZVJlcXVlc3Q=');

@$core.Deprecated('Use sendTwoFactorCodeResponseDescriptor instead')
const SendTwoFactorCodeResponse$json = {
  '1': 'SendTwoFactorCodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
  ],
};

/// Descriptor for `SendTwoFactorCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendTwoFactorCodeResponseDescriptor = $convert.base64Decode(
    'ChlTZW5kVHdvRmFjdG9yQ29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIdCgpleHBpcmVzX2luGAMgASgDUglleHBpcmVzSW4=');

@$core.Deprecated('Use getAvailable2FAMethodsRequestDescriptor instead')
const GetAvailable2FAMethodsRequest$json = {
  '1': 'GetAvailable2FAMethodsRequest',
};

/// Descriptor for `GetAvailable2FAMethodsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailable2FAMethodsRequestDescriptor =
    $convert.base64Decode('Ch1HZXRBdmFpbGFibGUyRkFNZXRob2RzUmVxdWVzdA==');

@$core.Deprecated('Use twoFactorMethodInfoDescriptor instead')
const TwoFactorMethodInfo$json = {
  '1': 'TwoFactorMethodInfo',
  '2': [
    {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'icon', '3': 4, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'available', '3': 5, '4': 1, '5': 8, '10': 'available'},
  ],
};

/// Descriptor for `TwoFactorMethodInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List twoFactorMethodInfoDescriptor = $convert.base64Decode(
    'ChNUd29GYWN0b3JNZXRob2RJbmZvEhYKBm1ldGhvZBgBIAEoCVIGbWV0aG9kEhIKBG5hbWUYAi'
    'ABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhIKBGljb24YBCAB'
    'KAlSBGljb24SHAoJYXZhaWxhYmxlGAUgASgIUglhdmFpbGFibGU=');

@$core.Deprecated('Use getAvailable2FAMethodsResponseDescriptor instead')
const GetAvailable2FAMethodsResponse$json = {
  '1': 'GetAvailable2FAMethodsResponse',
  '2': [
    {
      '1': 'methods',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.TwoFactorMethodInfo',
      '10': 'methods'
    },
  ],
};

/// Descriptor for `GetAvailable2FAMethodsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailable2FAMethodsResponseDescriptor =
    $convert.base64Decode(
        'Ch5HZXRBdmFpbGFibGUyRkFNZXRob2RzUmVzcG9uc2USMQoHbWV0aG9kcxgBIAMoCzIXLnBiLl'
        'R3b0ZhY3Rvck1ldGhvZEluZm9SB21ldGhvZHM=');

@$core.Deprecated('Use validateTokenRequestDescriptor instead')
const ValidateTokenRequest$json = {
  '1': 'ValidateTokenRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `ValidateTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTokenRequestDescriptor =
    $convert.base64Decode(
        'ChRWYWxpZGF0ZVRva2VuUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use validateTokenResponseDescriptor instead')
const ValidateTokenResponse$json = {
  '1': 'ValidateTokenResponse',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'expires_at', '3': 4, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `ValidateTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTokenResponseDescriptor = $convert.base64Decode(
    'ChVWYWxpZGF0ZVRva2VuUmVzcG9uc2USFAoFdmFsaWQYASABKAhSBXZhbGlkEhcKB3VzZXJfaW'
    'QYAiABKAlSBnVzZXJJZBIUCgVlbWFpbBgDIAEoCVIFZW1haWwSHQoKZXhwaXJlc19hdBgEIAEo'
    'A1IJZXhwaXJlc0F0');

@$core.Deprecated('Use loginWithPasscodeRequestDescriptor instead')
const LoginWithPasscodeRequest$json = {
  '1': 'LoginWithPasscodeRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'passcode', '3': 2, '4': 1, '5': 9, '10': 'passcode'},
    {'1': 'device_id', '3': 3, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 4, '4': 1, '5': 9, '10': 'deviceName'},
  ],
};

/// Descriptor for `LoginWithPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginWithPasscodeRequestDescriptor = $convert.base64Decode(
    'ChhMb2dpbldpdGhQYXNzY29kZVJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3'
    'Njb2RlGAIgASgJUghwYXNzY29kZRIbCglkZXZpY2VfaWQYAyABKAlSCGRldmljZUlkEh8KC2Rl'
    'dmljZV9uYW1lGAQgASgJUgpkZXZpY2VOYW1l');

@$core.Deprecated('Use registerPasscodeRequestDescriptor instead')
const RegisterPasscodeRequest$json = {
  '1': 'RegisterPasscodeRequest',
  '2': [
    {'1': 'passcode', '3': 1, '4': 1, '5': 9, '10': 'passcode'},
  ],
};

/// Descriptor for `RegisterPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPasscodeRequestDescriptor =
    $convert.base64Decode(
        'ChdSZWdpc3RlclBhc3Njb2RlUmVxdWVzdBIaCghwYXNzY29kZRgBIAEoCVIIcGFzc2NvZGU=');

@$core.Deprecated('Use registerPasscodeResponseDescriptor instead')
const RegisterPasscodeResponse$json = {
  '1': 'RegisterPasscodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RegisterPasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPasscodeResponseDescriptor =
    $convert.base64Decode(
        'ChhSZWdpc3RlclBhc3Njb2RlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCg'
        'Ntc2cYAiABKAlSA21zZw==');

@$core.Deprecated('Use changePasscodeRequestDescriptor instead')
const ChangePasscodeRequest$json = {
  '1': 'ChangePasscodeRequest',
  '2': [
    {'1': 'current_passcode', '3': 1, '4': 1, '5': 9, '10': 'currentPasscode'},
    {'1': 'new_passcode', '3': 2, '4': 1, '5': 9, '10': 'newPasscode'},
  ],
};

/// Descriptor for `ChangePasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasscodeRequestDescriptor = $convert.base64Decode(
    'ChVDaGFuZ2VQYXNzY29kZVJlcXVlc3QSKQoQY3VycmVudF9wYXNzY29kZRgBIAEoCVIPY3Vycm'
    'VudFBhc3Njb2RlEiEKDG5ld19wYXNzY29kZRgCIAEoCVILbmV3UGFzc2NvZGU=');

@$core.Deprecated('Use changePasscodeResponseDescriptor instead')
const ChangePasscodeResponse$json = {
  '1': 'ChangePasscodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `ChangePasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasscodeResponseDescriptor =
    $convert.base64Decode(
        'ChZDaGFuZ2VQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbX'
        'NnGAIgASgJUgNtc2c=');

@$core.Deprecated('Use authDevicePermissionDescriptor instead')
const AuthDevicePermission$json = {
  '1': 'AuthDevicePermission',
  '2': [
    {'1': 'permission_type', '3': 1, '4': 1, '5': 9, '10': 'permissionType'},
    {'1': 'is_granted', '3': 2, '4': 1, '5': 8, '10': 'isGranted'},
    {'1': 'granted_at', '3': 3, '4': 1, '5': 9, '10': 'grantedAt'},
  ],
};

/// Descriptor for `AuthDevicePermission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authDevicePermissionDescriptor = $convert.base64Decode(
    'ChRBdXRoRGV2aWNlUGVybWlzc2lvbhInCg9wZXJtaXNzaW9uX3R5cGUYASABKAlSDnBlcm1pc3'
    'Npb25UeXBlEh0KCmlzX2dyYW50ZWQYAiABKAhSCWlzR3JhbnRlZBIdCgpncmFudGVkX2F0GAMg'
    'ASgJUglncmFudGVkQXQ=');

@$core.Deprecated('Use authUpdateDevicePermissionsRequestDescriptor instead')
const AuthUpdateDevicePermissionsRequest$json = {
  '1': 'AuthUpdateDevicePermissionsRequest',
  '2': [
    {
      '1': 'permissions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.AuthDevicePermission',
      '10': 'permissions'
    },
  ],
};

/// Descriptor for `AuthUpdateDevicePermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authUpdateDevicePermissionsRequestDescriptor =
    $convert.base64Decode(
        'CiJBdXRoVXBkYXRlRGV2aWNlUGVybWlzc2lvbnNSZXF1ZXN0EjoKC3Blcm1pc3Npb25zGAEgAy'
        'gLMhgucGIuQXV0aERldmljZVBlcm1pc3Npb25SC3Blcm1pc3Npb25z');

@$core.Deprecated('Use authUpdateDevicePermissionsResponseDescriptor instead')
const AuthUpdateDevicePermissionsResponse$json = {
  '1': 'AuthUpdateDevicePermissionsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AuthUpdateDevicePermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authUpdateDevicePermissionsResponseDescriptor =
    $convert.base64Decode(
        'CiNBdXRoVXBkYXRlRGV2aWNlUGVybWlzc2lvbnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUg'
        'dzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use authGetDevicePermissionsRequestDescriptor instead')
const AuthGetDevicePermissionsRequest$json = {
  '1': 'AuthGetDevicePermissionsRequest',
};

/// Descriptor for `AuthGetDevicePermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authGetDevicePermissionsRequestDescriptor =
    $convert.base64Decode('Ch9BdXRoR2V0RGV2aWNlUGVybWlzc2lvbnNSZXF1ZXN0');

@$core.Deprecated('Use authGetDevicePermissionsResponseDescriptor instead')
const AuthGetDevicePermissionsResponse$json = {
  '1': 'AuthGetDevicePermissionsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'permissions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.pb.AuthDevicePermission',
      '10': 'permissions'
    },
  ],
};

/// Descriptor for `AuthGetDevicePermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authGetDevicePermissionsResponseDescriptor =
    $convert.base64Decode(
        'CiBBdXRoR2V0RGV2aWNlUGVybWlzc2lvbnNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
        'NjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USOgoLcGVybWlzc2lvbnMYAyADKAsyGC5w'
        'Yi5BdXRoRGV2aWNlUGVybWlzc2lvblILcGVybWlzc2lvbnM=');

@$core.Deprecated('Use registerDeviceRequestDescriptor instead')
const RegisterDeviceRequest$json = {
  '1': 'RegisterDeviceRequest',
  '2': [
    {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
    {'1': 'platform', '3': 3, '4': 1, '5': 9, '10': 'platform'},
    {'1': 'model', '3': 4, '4': 1, '5': 9, '10': 'model'},
    {'1': 'os_version', '3': 5, '4': 1, '5': 9, '10': 'osVersion'},
    {'1': 'app_version', '3': 6, '4': 1, '5': 9, '10': 'appVersion'},
    {'1': 'fcm_token', '3': 7, '4': 1, '5': 9, '10': 'fcmToken'},
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['public_key'],
};

/// Descriptor for `RegisterDeviceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerDeviceRequestDescriptor = $convert.base64Decode(
    'ChVSZWdpc3RlckRldmljZVJlcXVlc3QSHwoLZGV2aWNlX3V1aWQYASABKAlSCmRldmljZVV1aW'
    'QSGgoIcGxhdGZvcm0YAyABKAlSCHBsYXRmb3JtEhQKBW1vZGVsGAQgASgJUgVtb2RlbBIdCgpv'
    'c192ZXJzaW9uGAUgASgJUglvc1ZlcnNpb24SHwoLYXBwX3ZlcnNpb24YBiABKAlSCmFwcFZlcn'
    'Npb24SGwoJZmNtX3Rva2VuGAcgASgJUghmY21Ub2tlbkoECAIQA1IKcHVibGljX2tleQ==');

@$core.Deprecated('Use registerDeviceResponseDescriptor instead')
const RegisterDeviceResponse$json = {
  '1': 'RegisterDeviceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'device_uuid', '3': 3, '4': 1, '5': 9, '10': 'deviceUuid'},
    {'1': 'trust_status', '3': 4, '4': 1, '5': 9, '10': 'trustStatus'},
  ],
};

/// Descriptor for `RegisterDeviceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerDeviceResponseDescriptor = $convert.base64Decode(
    'ChZSZWdpc3RlckRldmljZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgtkZXZpY2VfdXVpZBgDIAEoCVIKZGV2aWNlVXVpZBIh'
    'Cgx0cnVzdF9zdGF0dXMYBCABKAlSC3RydXN0U3RhdHVz');

@$core.Deprecated('Use deviceInfoDescriptor instead')
const DeviceInfo$json = {
  '1': 'DeviceInfo',
  '2': [
    {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
    {'1': 'platform', '3': 2, '4': 1, '5': 9, '10': 'platform'},
    {'1': 'model', '3': 3, '4': 1, '5': 9, '10': 'model'},
    {'1': 'os_version', '3': 4, '4': 1, '5': 9, '10': 'osVersion'},
    {'1': 'app_version', '3': 5, '4': 1, '5': 9, '10': 'appVersion'},
    {'1': 'trust_status', '3': 6, '4': 1, '5': 9, '10': 'trustStatus'},
    {'1': 'last_ip', '3': 7, '4': 1, '5': 9, '10': 'lastIp'},
    {'1': 'last_location', '3': 8, '4': 1, '5': 9, '10': 'lastLocation'},
    {'1': 'first_seen_at', '3': 9, '4': 1, '5': 3, '10': 'firstSeenAt'},
    {'1': 'last_login_at', '3': 10, '4': 1, '5': 3, '10': 'lastLoginAt'},
    {'1': 'current', '3': 11, '4': 1, '5': 8, '10': 'current'},
  ],
};

/// Descriptor for `DeviceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceInfoDescriptor = $convert.base64Decode(
    'CgpEZXZpY2VJbmZvEh8KC2RldmljZV91dWlkGAEgASgJUgpkZXZpY2VVdWlkEhoKCHBsYXRmb3'
    'JtGAIgASgJUghwbGF0Zm9ybRIUCgVtb2RlbBgDIAEoCVIFbW9kZWwSHQoKb3NfdmVyc2lvbhgE'
    'IAEoCVIJb3NWZXJzaW9uEh8KC2FwcF92ZXJzaW9uGAUgASgJUgphcHBWZXJzaW9uEiEKDHRydX'
    'N0X3N0YXR1cxgGIAEoCVILdHJ1c3RTdGF0dXMSFwoHbGFzdF9pcBgHIAEoCVIGbGFzdElwEiMK'
    'DWxhc3RfbG9jYXRpb24YCCABKAlSDGxhc3RMb2NhdGlvbhIiCg1maXJzdF9zZWVuX2F0GAkgAS'
    'gDUgtmaXJzdFNlZW5BdBIiCg1sYXN0X2xvZ2luX2F0GAogASgDUgtsYXN0TG9naW5BdBIYCgdj'
    'dXJyZW50GAsgASgIUgdjdXJyZW50');

@$core.Deprecated('Use listDevicesRequestDescriptor instead')
const ListDevicesRequest$json = {
  '1': 'ListDevicesRequest',
};

/// Descriptor for `ListDevicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDevicesRequestDescriptor =
    $convert.base64Decode('ChJMaXN0RGV2aWNlc1JlcXVlc3Q=');

@$core.Deprecated('Use listDevicesResponseDescriptor instead')
const ListDevicesResponse$json = {
  '1': 'ListDevicesResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'devices',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.pb.DeviceInfo',
      '10': 'devices'
    },
  ],
};

/// Descriptor for `ListDevicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDevicesResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0RGV2aWNlc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2'
    'FnZRgCIAEoCVIHbWVzc2FnZRIoCgdkZXZpY2VzGAMgAygLMg4ucGIuRGV2aWNlSW5mb1IHZGV2'
    'aWNlcw==');

@$core.Deprecated('Use revokeDeviceRequestDescriptor instead')
const RevokeDeviceRequest$json = {
  '1': 'RevokeDeviceRequest',
  '2': [
    {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
  ],
};

/// Descriptor for `RevokeDeviceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revokeDeviceRequestDescriptor = $convert.base64Decode(
    'ChNSZXZva2VEZXZpY2VSZXF1ZXN0Eh8KC2RldmljZV91dWlkGAEgASgJUgpkZXZpY2VVdWlk');

@$core.Deprecated('Use revokeDeviceResponseDescriptor instead')
const RevokeDeviceResponse$json = {
  '1': 'RevokeDeviceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RevokeDeviceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revokeDeviceResponseDescriptor = $convert.base64Decode(
    'ChRSZXZva2VEZXZpY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getLoginHistoryRequestDescriptor instead')
const GetLoginHistoryRequest$json = {
  '1': 'GetLoginHistoryRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetLoginHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLoginHistoryRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRMb2dpbkhpc3RvcnlSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIWCgZvZmZzZX'
        'QYAiABKAVSBm9mZnNldA==');

@$core.Deprecated('Use loginActivityEntryDescriptor instead')
const LoginActivityEntry$json = {
  '1': 'LoginActivityEntry',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'ip_address', '3': 2, '4': 1, '5': 9, '10': 'ipAddress'},
    {'1': 'device_name', '3': 3, '4': 1, '5': 9, '10': 'deviceName'},
    {'1': 'user_agent', '3': 4, '4': 1, '5': 9, '10': 'userAgent'},
    {'1': 'fail_reason', '3': 5, '4': 1, '5': 9, '10': 'failReason'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 3, '10': 'createdAt'},
  ],
};

/// Descriptor for `LoginActivityEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginActivityEntryDescriptor = $convert.base64Decode(
    'ChJMb2dpbkFjdGl2aXR5RW50cnkSGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgppcF9hZG'
    'RyZXNzGAIgASgJUglpcEFkZHJlc3MSHwoLZGV2aWNlX25hbWUYAyABKAlSCmRldmljZU5hbWUS'
    'HQoKdXNlcl9hZ2VudBgEIAEoCVIJdXNlckFnZW50Eh8KC2ZhaWxfcmVhc29uGAUgASgJUgpmYW'
    'lsUmVhc29uEh0KCmNyZWF0ZWRfYXQYBiABKANSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use getLoginHistoryResponseDescriptor instead')
const GetLoginHistoryResponse$json = {
  '1': 'GetLoginHistoryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'entries',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.pb.LoginActivityEntry',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `GetLoginHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLoginHistoryResponseDescriptor = $convert.base64Decode(
    'ChdHZXRMb2dpbkhpc3RvcnlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2USMAoHZW50cmllcxgDIAMoCzIWLnBiLkxvZ2luQWN0aXZp'
    'dHlFbnRyeVIHZW50cmllcw==');

@$core.Deprecated('Use verifyLoginOtpRequestDescriptor instead')
const VerifyLoginOtpRequest$json = {
  '1': 'VerifyLoginOtpRequest',
  '2': [
    {'1': 'step_up_token', '3': 1, '4': 1, '5': 9, '10': 'stepUpToken'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'device_id', '3': 3, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 4, '4': 1, '5': 9, '10': 'deviceName'},
  ],
};

/// Descriptor for `VerifyLoginOtpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyLoginOtpRequestDescriptor = $convert.base64Decode(
    'ChVWZXJpZnlMb2dpbk90cFJlcXVlc3QSIgoNc3RlcF91cF90b2tlbhgBIAEoCVILc3RlcFVwVG'
    '9rZW4SEgoEY29kZRgCIAEoCVIEY29kZRIbCglkZXZpY2VfaWQYAyABKAlSCGRldmljZUlkEh8K'
    'C2RldmljZV9uYW1lGAQgASgJUgpkZXZpY2VOYW1l');

@$core.Deprecated('Use verifyPasscodeRequestDescriptor instead')
const VerifyPasscodeRequest$json = {
  '1': 'VerifyPasscodeRequest',
  '2': [
    {'1': 'passcode', '3': 1, '4': 1, '5': 9, '10': 'passcode'},
  ],
};

/// Descriptor for `VerifyPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasscodeRequestDescriptor =
    $convert.base64Decode(
        'ChVWZXJpZnlQYXNzY29kZVJlcXVlc3QSGgoIcGFzc2NvZGUYASABKAlSCHBhc3Njb2Rl');

@$core.Deprecated('Use verifyPasscodeResponseDescriptor instead')
const VerifyPasscodeResponse$json = {
  '1': 'VerifyPasscodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'is_valid', '3': 3, '4': 1, '5': 8, '10': 'isValid'},
    {
      '1': 'attempts_remaining',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'attemptsRemaining'
    },
    {
      '1': 'retry_after_seconds',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'retryAfterSeconds'
    },
  ],
};

/// Descriptor for `VerifyPasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasscodeResponseDescriptor = $convert.base64Decode(
    'ChZWZXJpZnlQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbX'
    'NnGAIgASgJUgNtc2cSGQoIaXNfdmFsaWQYAyABKAhSB2lzVmFsaWQSLQoSYXR0ZW1wdHNfcmVt'
    'YWluaW5nGAQgASgFUhFhdHRlbXB0c1JlbWFpbmluZxIuChNyZXRyeV9hZnRlcl9zZWNvbmRzGA'
    'UgASgFUhFyZXRyeUFmdGVyU2Vjb25kcw==');

@$core.Deprecated('Use requestPasswordResetRequestDescriptor instead')
const RequestPasswordResetRequest$json = {
  '1': 'RequestPasswordResetRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RequestPasswordResetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetRequestDescriptor =
    $convert.base64Decode(
        'ChtSZXF1ZXN0UGFzc3dvcmRSZXNldFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');

@$core.Deprecated('Use requestPasswordResetResponseDescriptor instead')
const RequestPasswordResetResponse$json = {
  '1': 'RequestPasswordResetResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RequestPasswordResetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetResponseDescriptor =
    $convert.base64Decode(
        'ChxSZXF1ZXN0UGFzc3dvcmRSZXNldFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
        'MSEAoDbXNnGAIgASgJUgNtc2c=');

@$core.Deprecated('Use requestEmailVerificationRequestDescriptor instead')
const RequestEmailVerificationRequest$json = {
  '1': 'RequestEmailVerificationRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RequestEmailVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestEmailVerificationRequestDescriptor =
    $convert.base64Decode(
        'Ch9SZXF1ZXN0RW1haWxWZXJpZmljYXRpb25SZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbA'
        '==');

@$core.Deprecated('Use requestEmailVerificationResponseDescriptor instead')
const RequestEmailVerificationResponse$json = {
  '1': 'RequestEmailVerificationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RequestEmailVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestEmailVerificationResponseDescriptor =
    $convert.base64Decode(
        'CiBSZXF1ZXN0RW1haWxWZXJpZmljYXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
        'NjZXNzEhAKA21zZxgCIAEoCVIDbXNn');

@$core.Deprecated('Use checkEmailAvailabilityRequestDescriptor instead')
const CheckEmailAvailabilityRequest$json = {
  '1': 'CheckEmailAvailabilityRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `CheckEmailAvailabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEmailAvailabilityRequestDescriptor =
    $convert.base64Decode(
        'Ch1DaGVja0VtYWlsQXZhaWxhYmlsaXR5UmVxdWVzdBIUCgVlbWFpbBgBIAEoCVIFZW1haWw=');

@$core.Deprecated('Use checkEmailAvailabilityResponseDescriptor instead')
const CheckEmailAvailabilityResponse$json = {
  '1': 'CheckEmailAvailabilityResponse',
  '2': [
    {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CheckEmailAvailabilityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEmailAvailabilityResponseDescriptor =
    $convert.base64Decode(
        'Ch5DaGVja0VtYWlsQXZhaWxhYmlsaXR5UmVzcG9uc2USHAoJYXZhaWxhYmxlGAEgASgIUglhdm'
        'FpbGFibGUSEAoDbXNnGAIgASgJUgNtc2c=');

@$core.Deprecated('Use requestPhoneVerificationRequestDescriptor instead')
const RequestPhoneVerificationRequest$json = {
  '1': 'RequestPhoneVerificationRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `RequestPhoneVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhoneVerificationRequestDescriptor =
    $convert.base64Decode(
        'Ch9SZXF1ZXN0UGhvbmVWZXJpZmljYXRpb25SZXF1ZXN0EhQKBXBob25lGAEgASgJUgVwaG9uZR'
        'IhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2Rl');

@$core.Deprecated('Use requestPhoneVerificationResponseDescriptor instead')
const RequestPhoneVerificationResponse$json = {
  '1': 'RequestPhoneVerificationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'verification_id', '3': 3, '4': 1, '5': 9, '10': 'verificationId'},
    {'1': 'expires_in', '3': 4, '4': 1, '5': 3, '10': 'expiresIn'},
  ],
};

/// Descriptor for `RequestPhoneVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhoneVerificationResponseDescriptor =
    $convert.base64Decode(
        'CiBSZXF1ZXN0UGhvbmVWZXJpZmljYXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
        'NjZXNzEhAKA21zZxgCIAEoCVIDbXNnEicKD3ZlcmlmaWNhdGlvbl9pZBgDIAEoCVIOdmVyaWZp'
        'Y2F0aW9uSWQSHQoKZXhwaXJlc19pbhgEIAEoA1IJZXhwaXJlc0lu');

@$core.Deprecated('Use verifyPhoneNumberRequestDescriptor instead')
const VerifyPhoneNumberRequest$json = {
  '1': 'VerifyPhoneNumberRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    {'1': 'verification_id', '3': 4, '4': 1, '5': 9, '10': 'verificationId'},
  ],
};

/// Descriptor for `VerifyPhoneNumberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneNumberRequestDescriptor = $convert.base64Decode(
    'ChhWZXJpZnlQaG9uZU51bWJlclJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEiEKDGNvdW'
    '50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGUSEgoEY29kZRgDIAEoCVIEY29kZRInCg92ZXJp'
    'ZmljYXRpb25faWQYBCABKAlSDnZlcmlmaWNhdGlvbklk');

@$core.Deprecated('Use verifyPhoneNumberResponseDescriptor instead')
const VerifyPhoneNumberResponse$json = {
  '1': 'VerifyPhoneNumberResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'is_verified', '3': 3, '4': 1, '5': 8, '10': 'isVerified'},
  ],
};

/// Descriptor for `VerifyPhoneNumberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneNumberResponseDescriptor =
    $convert.base64Decode(
        'ChlWZXJpZnlQaG9uZU51bWJlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEA'
        'oDbXNnGAIgASgJUgNtc2cSHwoLaXNfdmVyaWZpZWQYAyABKAhSCmlzVmVyaWZpZWQ=');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'email_verified', '3': 7, '4': 1, '5': 8, '10': 'emailVerified'},
    {'1': 'phone_verified', '3': 8, '4': 1, '5': 8, '10': 'phoneVerified'},
    {
      '1': 'two_factor_enabled',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'twoFactorEnabled'
    },
    {
      '1': 'two_factor_method',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'twoFactorMethod'
    },
    {'1': 'profile_picture', '3': 11, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'signup_status', '3': 14, '4': 1, '5': 9, '10': 'signupStatus'},
    {
      '1': 'current_signup_step',
      '3': 15,
      '4': 1,
      '5': 9,
      '10': 'currentSignupStep'
    },
    {'1': 'username', '3': 16, '4': 1, '5': 9, '10': 'username'},
    {
      '1': 'identity_verified',
      '3': 17,
      '4': 1,
      '5': 8,
      '10': 'identityVerified'
    },
    {'1': 'identity_type', '3': 18, '4': 1, '5': 9, '10': 'identityType'},
    {
      '1': 'identity_verified_at',
      '3': 19,
      '4': 1,
      '5': 9,
      '10': 'identityVerifiedAt'
    },
    {'1': 'date_of_birth', '3': 20, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'kyc_tier', '3': 21, '4': 1, '5': 5, '10': 'kycTier'},
    {'1': 'kyc_status', '3': 22, '4': 1, '5': 9, '10': 'kycStatus'},
    {'1': 'roles', '3': 23, '4': 3, '5': 9, '10': 'roles'},
    {'1': 'role', '3': 24, '4': 1, '5': 9, '10': 'role'},
    {'1': 'auth_type', '3': 25, '4': 1, '5': 9, '10': 'authType'},
    {
      '1': 'preferred_login_method',
      '3': 26,
      '4': 1,
      '5': 9,
      '10': 'preferredLoginMethod'
    },
    {'1': 'has_password', '3': 27, '4': 1, '5': 8, '10': 'hasPassword'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSHQoKZmlyc3Rfbm'
    'FtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSFAoFcGhv'
    'bmUYBSABKAlSBXBob25lEiEKDGNvdW50cnlfY29kZRgGIAEoCVILY291bnRyeUNvZGUSJQoOZW'
    '1haWxfdmVyaWZpZWQYByABKAhSDWVtYWlsVmVyaWZpZWQSJQoOcGhvbmVfdmVyaWZpZWQYCCAB'
    'KAhSDXBob25lVmVyaWZpZWQSLAoSdHdvX2ZhY3Rvcl9lbmFibGVkGAkgASgIUhB0d29GYWN0b3'
    'JFbmFibGVkEioKEXR3b19mYWN0b3JfbWV0aG9kGAogASgJUg90d29GYWN0b3JNZXRob2QSJwoP'
    'cHJvZmlsZV9waWN0dXJlGAsgASgJUg5wcm9maWxlUGljdHVyZRIdCgpjcmVhdGVkX2F0GAwgAS'
    'gJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgNIAEoCVIJdXBkYXRlZEF0EiMKDXNpZ251cF9z'
    'dGF0dXMYDiABKAlSDHNpZ251cFN0YXR1cxIuChNjdXJyZW50X3NpZ251cF9zdGVwGA8gASgJUh'
    'FjdXJyZW50U2lnbnVwU3RlcBIaCgh1c2VybmFtZRgQIAEoCVIIdXNlcm5hbWUSKwoRaWRlbnRp'
    'dHlfdmVyaWZpZWQYESABKAhSEGlkZW50aXR5VmVyaWZpZWQSIwoNaWRlbnRpdHlfdHlwZRgSIA'
    'EoCVIMaWRlbnRpdHlUeXBlEjAKFGlkZW50aXR5X3ZlcmlmaWVkX2F0GBMgASgJUhJpZGVudGl0'
    'eVZlcmlmaWVkQXQSIgoNZGF0ZV9vZl9iaXJ0aBgUIAEoCVILZGF0ZU9mQmlydGgSGQoIa3ljX3'
    'RpZXIYFSABKAVSB2t5Y1RpZXISHQoKa3ljX3N0YXR1cxgWIAEoCVIJa3ljU3RhdHVzEhQKBXJv'
    'bGVzGBcgAygJUgVyb2xlcxISCgRyb2xlGBggASgJUgRyb2xlEhsKCWF1dGhfdHlwZRgZIAEoCV'
    'IIYXV0aFR5cGUSNAoWcHJlZmVycmVkX2xvZ2luX21ldGhvZBgaIAEoCVIUcHJlZmVycmVkTG9n'
    'aW5NZXRob2QSIQoMaGFzX3Bhc3N3b3JkGBsgASgIUgtoYXNQYXNzd29yZA==');

@$core.Deprecated('Use signupStepProgressDescriptor instead')
const SignupStepProgress$json = {
  '1': 'SignupStepProgress',
  '2': [
    {'1': 'step_name', '3': 1, '4': 1, '5': 9, '10': 'stepName'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.StepStatus',
      '10': 'status'
    },
    {'1': 'step_data', '3': 3, '4': 1, '5': 9, '10': 'stepData'},
    {'1': 'completed_at', '3': 4, '4': 1, '5': 9, '10': 'completedAt'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 6, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SignupStepProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupStepProgressDescriptor = $convert.base64Decode(
    'ChJTaWdudXBTdGVwUHJvZ3Jlc3MSGwoJc3RlcF9uYW1lGAEgASgJUghzdGVwTmFtZRImCgZzdG'
    'F0dXMYAiABKA4yDi5wYi5TdGVwU3RhdHVzUgZzdGF0dXMSGwoJc3RlcF9kYXRhGAMgASgJUghz'
    'dGVwRGF0YRIhCgxjb21wbGV0ZWRfYXQYBCABKAlSC2NvbXBsZXRlZEF0Eh0KCmNyZWF0ZWRfYX'
    'QYBSABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAYgASgJUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use signupProgressDescriptor instead')
const SignupProgress$json = {
  '1': 'SignupProgress',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.SignupStatus',
      '10': 'status'
    },
    {'1': 'current_step', '3': 3, '4': 1, '5': 9, '10': 'currentStep'},
    {
      '1': 'steps',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.pb.SignupStepProgress',
      '10': 'steps'
    },
    {
      '1': 'signup_completed_at',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'signupCompletedAt'
    },
    {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SignupProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupProgressDescriptor = $convert.base64Decode(
    'Cg5TaWdudXBQcm9ncmVzcxIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKAoGc3RhdHVzGAIgAS'
    'gOMhAucGIuU2lnbnVwU3RhdHVzUgZzdGF0dXMSIQoMY3VycmVudF9zdGVwGAMgASgJUgtjdXJy'
    'ZW50U3RlcBIsCgVzdGVwcxgEIAMoCzIWLnBiLlNpZ251cFN0ZXBQcm9ncmVzc1IFc3RlcHMSLg'
    'oTc2lnbnVwX2NvbXBsZXRlZF9hdBgFIAEoCVIRc2lnbnVwQ29tcGxldGVkQXQSHQoKY3JlYXRl'
    'ZF9hdBgGIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYByABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use getSignupProgressRequestDescriptor instead')
const GetSignupProgressRequest$json = {
  '1': 'GetSignupProgressRequest',
};

/// Descriptor for `GetSignupProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSignupProgressRequestDescriptor =
    $convert.base64Decode('ChhHZXRTaWdudXBQcm9ncmVzc1JlcXVlc3Q=');

@$core.Deprecated('Use getSignupProgressResponseDescriptor instead')
const GetSignupProgressResponse$json = {
  '1': 'GetSignupProgressResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {
      '1': 'progress',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pb.SignupProgress',
      '10': 'progress'
    },
    {'1': 'next_step', '3': 4, '4': 1, '5': 9, '10': 'nextStep'},
    {'1': 'is_complete', '3': 5, '4': 1, '5': 8, '10': 'isComplete'},
  ],
};

/// Descriptor for `GetSignupProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSignupProgressResponseDescriptor = $convert.base64Decode(
    'ChlHZXRTaWdudXBQcm9ncmVzc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEA'
    'oDbXNnGAIgASgJUgNtc2cSLgoIcHJvZ3Jlc3MYAyABKAsyEi5wYi5TaWdudXBQcm9ncmVzc1II'
    'cHJvZ3Jlc3MSGwoJbmV4dF9zdGVwGAQgASgJUghuZXh0U3RlcBIfCgtpc19jb21wbGV0ZRgFIA'
    'EoCFIKaXNDb21wbGV0ZQ==');

@$core.Deprecated('Use updateSignupStepRequestDescriptor instead')
const UpdateSignupStepRequest$json = {
  '1': 'UpdateSignupStepRequest',
  '2': [
    {'1': 'step_name', '3': 1, '4': 1, '5': 9, '10': 'stepName'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.StepStatus',
      '10': 'status'
    },
    {'1': 'step_data', '3': 3, '4': 1, '5': 9, '10': 'stepData'},
  ],
};

/// Descriptor for `UpdateSignupStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSignupStepRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVTaWdudXBTdGVwUmVxdWVzdBIbCglzdGVwX25hbWUYASABKAlSCHN0ZXBOYW1lEi'
    'YKBnN0YXR1cxgCIAEoDjIOLnBiLlN0ZXBTdGF0dXNSBnN0YXR1cxIbCglzdGVwX2RhdGEYAyAB'
    'KAlSCHN0ZXBEYXRh');

@$core.Deprecated('Use updateSignupStepResponseDescriptor instead')
const UpdateSignupStepResponse$json = {
  '1': 'UpdateSignupStepResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {
      '1': 'progress',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pb.SignupProgress',
      '10': 'progress'
    },
    {'1': 'next_step', '3': 4, '4': 1, '5': 9, '10': 'nextStep'},
  ],
};

/// Descriptor for `UpdateSignupStepResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSignupStepResponseDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVTaWdudXBTdGVwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCg'
    'Ntc2cYAiABKAlSA21zZxIuCghwcm9ncmVzcxgDIAEoCzISLnBiLlNpZ251cFByb2dyZXNzUghw'
    'cm9ncmVzcxIbCgluZXh0X3N0ZXAYBCABKAlSCG5leHRTdGVw');

@$core.Deprecated('Use completeSignupRequestDescriptor instead')
const CompleteSignupRequest$json = {
  '1': 'CompleteSignupRequest',
};

/// Descriptor for `CompleteSignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeSignupRequestDescriptor =
    $convert.base64Decode('ChVDb21wbGV0ZVNpZ251cFJlcXVlc3Q=');

@$core.Deprecated('Use completeSignupResponseDescriptor instead')
const CompleteSignupResponse$json = {
  '1': 'CompleteSignupResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {
      '1': 'progress',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pb.SignupProgress',
      '10': 'progress'
    },
  ],
};

/// Descriptor for `CompleteSignupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeSignupResponseDescriptor = $convert.base64Decode(
    'ChZDb21wbGV0ZVNpZ251cFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbX'
    'NnGAIgASgJUgNtc2cSLgoIcHJvZ3Jlc3MYAyABKAsyEi5wYi5TaWdudXBQcm9ncmVzc1IIcHJv'
    'Z3Jlc3M=');

@$core.Deprecated('Use verifyIdentityRequestDescriptor instead')
const VerifyIdentityRequest$json = {
  '1': 'VerifyIdentityRequest',
  '2': [
    {
      '1': 'identity_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.pb.IdentityType',
      '10': 'identityType'
    },
    {'1': 'identity_number', '3': 2, '4': 1, '5': 9, '10': 'identityNumber'},
    {'1': 'date_of_birth', '3': 3, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'first_name', '3': 5, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 6, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyIdentityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIdentityRequestDescriptor = $convert.base64Decode(
    'ChVWZXJpZnlJZGVudGl0eVJlcXVlc3QSNQoNaWRlbnRpdHlfdHlwZRgBIAEoDjIQLnBiLklkZW'
    '50aXR5VHlwZVIMaWRlbnRpdHlUeXBlEicKD2lkZW50aXR5X251bWJlchgCIAEoCVIOaWRlbnRp'
    'dHlOdW1iZXISIgoNZGF0ZV9vZl9iaXJ0aBgDIAEoCVILZGF0ZU9mQmlydGgSIQoMY291bnRyeV'
    '9jb2RlGAQgASgJUgtjb3VudHJ5Q29kZRIdCgpmaXJzdF9uYW1lGAUgASgJUglmaXJzdE5hbWUS'
    'GwoJbGFzdF9uYW1lGAYgASgJUghsYXN0TmFtZRIhCgxwaG9uZV9udW1iZXIYByABKAlSC3Bob2'
    '5lTnVtYmVy');

@$core.Deprecated('Use verifiedIdentityDescriptor instead')
const VerifiedIdentity$json = {
  '1': 'VerifiedIdentity',
  '2': [
    {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'middle_name', '3': 3, '4': 1, '5': 9, '10': 'middleName'},
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'photo_url', '3': 7, '4': 1, '5': 9, '10': 'photoUrl'},
    {'1': 'address', '3': 8, '4': 1, '5': 9, '10': 'address'},
    {'1': 'state_of_origin', '3': 9, '4': 1, '5': 9, '10': 'stateOfOrigin'},
    {'1': 'lga_of_origin', '3': 10, '4': 1, '5': 9, '10': 'lgaOfOrigin'},
  ],
};

/// Descriptor for `VerifiedIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifiedIdentityDescriptor = $convert.base64Decode(
    'ChBWZXJpZmllZElkZW50aXR5Eh0KCmZpcnN0X25hbWUYASABKAlSCWZpcnN0TmFtZRIbCglsYX'
    'N0X25hbWUYAiABKAlSCGxhc3ROYW1lEh8KC21pZGRsZV9uYW1lGAMgASgJUgptaWRkbGVOYW1l'
    'EiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISIgoNZGF0ZV9vZl9iaXJ0aBgFIA'
    'EoCVILZGF0ZU9mQmlydGgSFgoGZ2VuZGVyGAYgASgJUgZnZW5kZXISGwoJcGhvdG9fdXJsGAcg'
    'ASgJUghwaG90b1VybBIYCgdhZGRyZXNzGAggASgJUgdhZGRyZXNzEiYKD3N0YXRlX29mX29yaW'
    'dpbhgJIAEoCVINc3RhdGVPZk9yaWdpbhIiCg1sZ2Ffb2Zfb3JpZ2luGAogASgJUgtsZ2FPZk9y'
    'aWdpbg==');

@$core.Deprecated('Use verifyIdentityResponseDescriptor instead')
const VerifyIdentityResponse$json = {
  '1': 'VerifyIdentityResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'error_code', '3': 3, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    {
      '1': 'identity',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.pb.VerifiedIdentity',
      '10': 'identity'
    },
    {
      '1': 'virtual_account',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.pb.VirtualAccountInfo',
      '10': 'virtualAccount'
    },
    {'1': 'verification_id', '3': 7, '4': 1, '5': 9, '10': 'verificationId'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'session_url', '3': 9, '4': 1, '5': 9, '10': 'sessionUrl'},
    {'1': 'session_token', '3': 10, '4': 1, '5': 9, '10': 'sessionToken'},
    {
      '1': 'reconciliation',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.pb.DataReconciliation',
      '10': 'reconciliation'
    },
  ],
};

/// Descriptor for `VerifyIdentityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIdentityResponseDescriptor = $convert.base64Decode(
    'ChZWZXJpZnlJZGVudGl0eVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGgoIdm'
    'VyaWZpZWQYAiABKAhSCHZlcmlmaWVkEh0KCmVycm9yX2NvZGUYAyABKAlSCWVycm9yQ29kZRIj'
    'Cg1lcnJvcl9tZXNzYWdlGAQgASgJUgxlcnJvck1lc3NhZ2USMAoIaWRlbnRpdHkYBSABKAsyFC'
    '5wYi5WZXJpZmllZElkZW50aXR5UghpZGVudGl0eRI/Cg92aXJ0dWFsX2FjY291bnQYBiABKAsy'
    'Fi5wYi5WaXJ0dWFsQWNjb3VudEluZm9SDnZpcnR1YWxBY2NvdW50EicKD3ZlcmlmaWNhdGlvbl'
    '9pZBgHIAEoCVIOdmVyaWZpY2F0aW9uSWQSFgoGc3RhdHVzGAggASgJUgZzdGF0dXMSHwoLc2Vz'
    'c2lvbl91cmwYCSABKAlSCnNlc3Npb25VcmwSIwoNc2Vzc2lvbl90b2tlbhgKIAEoCVIMc2Vzc2'
    'lvblRva2VuEj4KDnJlY29uY2lsaWF0aW9uGAsgASgLMhYucGIuRGF0YVJlY29uY2lsaWF0aW9u'
    'Ug5yZWNvbmNpbGlhdGlvbg==');

@$core.Deprecated('Use dataReconciliationDescriptor instead')
const DataReconciliation$json = {
  '1': 'DataReconciliation',
  '2': [
    {'1': 'name_action', '3': 1, '4': 1, '5': 9, '10': 'nameAction'},
    {'1': 'name_match_score', '3': 2, '4': 1, '5': 1, '10': 'nameMatchScore'},
    {'1': 'verified_name', '3': 3, '4': 1, '5': 9, '10': 'verifiedName'},
    {'1': 'profile_name', '3': 4, '4': 1, '5': 9, '10': 'profileName'},
    {'1': 'dob_mismatch', '3': 5, '4': 1, '5': 8, '10': 'dobMismatch'},
    {'1': 'verified_dob', '3': 6, '4': 1, '5': 9, '10': 'verifiedDob'},
    {'1': 'profile_dob', '3': 7, '4': 1, '5': 9, '10': 'profileDob'},
    {'1': 'phone_mismatch', '3': 8, '4': 1, '5': 8, '10': 'phoneMismatch'},
  ],
};

/// Descriptor for `DataReconciliation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataReconciliationDescriptor = $convert.base64Decode(
    'ChJEYXRhUmVjb25jaWxpYXRpb24SHwoLbmFtZV9hY3Rpb24YASABKAlSCm5hbWVBY3Rpb24SKA'
    'oQbmFtZV9tYXRjaF9zY29yZRgCIAEoAVIObmFtZU1hdGNoU2NvcmUSIwoNdmVyaWZpZWRfbmFt'
    'ZRgDIAEoCVIMdmVyaWZpZWROYW1lEiEKDHByb2ZpbGVfbmFtZRgEIAEoCVILcHJvZmlsZU5hbW'
    'USIQoMZG9iX21pc21hdGNoGAUgASgIUgtkb2JNaXNtYXRjaBIhCgx2ZXJpZmllZF9kb2IYBiAB'
    'KAlSC3ZlcmlmaWVkRG9iEh8KC3Byb2ZpbGVfZG9iGAcgASgJUgpwcm9maWxlRG9iEiUKDnBob2'
    '5lX21pc21hdGNoGAggASgIUg1waG9uZU1pc21hdGNo');

@$core.Deprecated('Use confirmBVNNameRequestDescriptor instead')
const ConfirmBVNNameRequest$json = {
  '1': 'ConfirmBVNNameRequest',
  '2': [
    {'1': 'action', '3': 1, '4': 1, '5': 9, '10': 'action'},
    {'1': 'verification_id', '3': 2, '4': 1, '5': 9, '10': 'verificationId'},
  ],
};

/// Descriptor for `ConfirmBVNNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmBVNNameRequestDescriptor = $convert.base64Decode(
    'ChVDb25maXJtQlZOTmFtZVJlcXVlc3QSFgoGYWN0aW9uGAEgASgJUgZhY3Rpb24SJwoPdmVyaW'
    'ZpY2F0aW9uX2lkGAIgASgJUg52ZXJpZmljYXRpb25JZA==');

@$core.Deprecated('Use confirmBVNNameResponseDescriptor instead')
const ConfirmBVNNameResponse$json = {
  '1': 'ConfirmBVNNameResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCVerificationStatus',
      '10': 'status'
    },
    {
      '1': 'current_tier',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCTier',
      '10': 'currentTier'
    },
  ],
};

/// Descriptor for `ConfirmBVNNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmBVNNameResponseDescriptor = $convert.base64Decode(
    'ChZDb25maXJtQlZOTmFtZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIxCgZzdGF0dXMYAyABKA4yGS5wYi5LWUNWZXJpZmljYXRp'
    'b25TdGF0dXNSBnN0YXR1cxIuCgxjdXJyZW50X3RpZXIYBCABKA4yCy5wYi5LWUNUaWVyUgtjdX'
    'JyZW50VGllcg==');

@$core.Deprecated('Use virtualAccountInfoDescriptor instead')
const VirtualAccountInfo$json = {
  '1': 'VirtualAccountInfo',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_name', '3': 2, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 3, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'provider', '3': 6, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `VirtualAccountInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountInfoDescriptor = $convert.base64Decode(
    'ChJWaXJ0dWFsQWNjb3VudEluZm8SJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW'
    '1iZXISGwoJYmFua19uYW1lGAIgASgJUghiYW5rTmFtZRIbCgliYW5rX2NvZGUYAyABKAlSCGJh'
    'bmtDb2RlEiEKDGFjY291bnRfbmFtZRgEIAEoCVILYWNjb3VudE5hbWUSGgoIY3VycmVuY3kYBS'
    'ABKAlSCGN1cnJlbmN5EhoKCHByb3ZpZGVyGAYgASgJUghwcm92aWRlcg==');

@$core.Deprecated('Use getIdentityVerificationStatusRequestDescriptor instead')
const GetIdentityVerificationStatusRequest$json = {
  '1': 'GetIdentityVerificationStatusRequest',
};

/// Descriptor for `GetIdentityVerificationStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIdentityVerificationStatusRequestDescriptor =
    $convert
        .base64Decode('CiRHZXRJZGVudGl0eVZlcmlmaWNhdGlvblN0YXR1c1JlcXVlc3Q=');

@$core.Deprecated('Use getIdentityVerificationStatusResponseDescriptor instead')
const GetIdentityVerificationStatusResponse$json = {
  '1': 'GetIdentityVerificationStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {
      '1': 'identity_verified',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'identityVerified'
    },
    {
      '1': 'identity_type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.pb.IdentityType',
      '10': 'identityType'
    },
    {
      '1': 'identity_verified_at',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'identityVerifiedAt'
    },
    {
      '1': 'masked_identity_number',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'maskedIdentityNumber'
    },
  ],
};

/// Descriptor for `GetIdentityVerificationStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIdentityVerificationStatusResponseDescriptor = $convert.base64Decode(
    'CiVHZXRJZGVudGl0eVZlcmlmaWNhdGlvblN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKA'
    'hSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSKwoRaWRlbnRpdHlfdmVyaWZpZWQYAyABKAhS'
    'EGlkZW50aXR5VmVyaWZpZWQSNQoNaWRlbnRpdHlfdHlwZRgEIAEoDjIQLnBiLklkZW50aXR5VH'
    'lwZVIMaWRlbnRpdHlUeXBlEjAKFGlkZW50aXR5X3ZlcmlmaWVkX2F0GAUgASgJUhJpZGVudGl0'
    'eVZlcmlmaWVkQXQSNAoWbWFza2VkX2lkZW50aXR5X251bWJlchgGIAEoCVIUbWFza2VkSWRlbn'
    'RpdHlOdW1iZXI=');

@$core.Deprecated('Use lookupUserByUsernameRequestDescriptor instead')
const LookupUserByUsernameRequest$json = {
  '1': 'LookupUserByUsernameRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `LookupUserByUsernameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserByUsernameRequestDescriptor =
    $convert.base64Decode(
        'ChtMb29rdXBVc2VyQnlVc2VybmFtZVJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW'
        '1l');

@$core.Deprecated('Use lookupUserByPhoneRequestDescriptor instead')
const LookupUserByPhoneRequest$json = {
  '1': 'LookupUserByPhoneRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `LookupUserByPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserByPhoneRequestDescriptor =
    $convert.base64Decode(
        'ChhMb29rdXBVc2VyQnlQaG9uZVJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25l');

@$core.Deprecated('Use userLookupResponseDescriptor instead')
const UserLookupResponse$json = {
  '1': 'UserLookupResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'found', '3': 3, '4': 1, '5': 8, '10': 'found'},
    {
      '1': 'user',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.pb.UserLookupResult',
      '10': 'user'
    },
  ],
};

/// Descriptor for `UserLookupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLookupResponseDescriptor = $convert.base64Decode(
    'ChJVc2VyTG9va3VwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAi'
    'ABKAlSA21zZxIUCgVmb3VuZBgDIAEoCFIFZm91bmQSKAoEdXNlchgEIAEoCzIULnBiLlVzZXJM'
    'b29rdXBSZXN1bHRSBHVzZXI=');

@$core.Deprecated('Use userLookupResultDescriptor instead')
const UserLookupResult$json = {
  '1': 'UserLookupResult',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'profile_picture', '3': 5, '4': 1, '5': 9, '10': 'profilePicture'},
    {
      '1': 'is_lazervault_user',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'isLazervaultUser'
    },
    {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'email', '3': 8, '4': 1, '5': 9, '10': 'email'},
    {
      '1': 'primary_account_id',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'primaryAccountId'
    },
    {'1': 'country_code', '3': 10, '4': 1, '5': 9, '10': 'countryCode'},
    {
      '1': 'email_matches_search_query',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'emailMatchesSearchQuery'
    },
    {
      '1': 'phone_matches_search_query_exact',
      '3': 12,
      '4': 1,
      '5': 8,
      '10': 'phoneMatchesSearchQueryExact'
    },
  ],
};

/// Descriptor for `UserLookupResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLookupResultDescriptor = $convert.base64Decode(
    'ChBVc2VyTG9va3VwUmVzdWx0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZR'
    'gCIAEoCVIIdXNlcm5hbWUSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3Rf'
    'bmFtZRgEIAEoCVIIbGFzdE5hbWUSJwoPcHJvZmlsZV9waWN0dXJlGAUgASgJUg5wcm9maWxlUG'
    'ljdHVyZRIsChJpc19sYXplcnZhdWx0X3VzZXIYBiABKAhSEGlzTGF6ZXJ2YXVsdFVzZXISIQoM'
    'cGhvbmVfbnVtYmVyGAcgASgJUgtwaG9uZU51bWJlchIUCgVlbWFpbBgIIAEoCVIFZW1haWwSLA'
    'oScHJpbWFyeV9hY2NvdW50X2lkGAkgASgJUhBwcmltYXJ5QWNjb3VudElkEiEKDGNvdW50cnlf'
    'Y29kZRgKIAEoCVILY291bnRyeUNvZGUSOwoaZW1haWxfbWF0Y2hlc19zZWFyY2hfcXVlcnkYCy'
    'ABKAhSF2VtYWlsTWF0Y2hlc1NlYXJjaFF1ZXJ5EkYKIHBob25lX21hdGNoZXNfc2VhcmNoX3F1'
    'ZXJ5X2V4YWN0GAwgASgIUhxwaG9uZU1hdGNoZXNTZWFyY2hRdWVyeUV4YWN0');

@$core.Deprecated('Use userSearchRequestDescriptor instead')
const UserSearchRequest$json = {
  '1': 'UserSearchRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'search_type', '3': 3, '4': 1, '5': 9, '10': 'searchType'},
    {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'offset', '3': 5, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `UserSearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSearchRequestDescriptor = $convert.base64Decode(
    'ChFVc2VyU2VhcmNoUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSFAoFbGltaXQYAiABKA'
    'VSBWxpbWl0Eh8KC3NlYXJjaF90eXBlGAMgASgJUgpzZWFyY2hUeXBlEiEKDGNvdW50cnlfY29k'
    'ZRgEIAEoCVILY291bnRyeUNvZGUSFgoGb2Zmc2V0GAUgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use userSearchResponseDescriptor instead')
const UserSearchResponse$json = {
  '1': 'UserSearchResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {
      '1': 'users',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.pb.UserLookupResult',
      '10': 'users'
    },
  ],
};

/// Descriptor for `UserSearchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSearchResponseDescriptor = $convert.base64Decode(
    'ChJVc2VyU2VhcmNoUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAi'
    'ABKAlSA21zZxIqCgV1c2VycxgDIAMoCzIULnBiLlVzZXJMb29rdXBSZXN1bHRSBXVzZXJz');

@$core.Deprecated('Use initiateKYCRequestDescriptor instead')
const InitiateKYCRequest$json = {
  '1': 'InitiateKYCRequest',
  '2': [
    {
      '1': 'target_tier',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCTier',
      '10': 'targetTier'
    },
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `InitiateKYCRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCRequestDescriptor = $convert.base64Decode(
    'ChJJbml0aWF0ZUtZQ1JlcXVlc3QSLAoLdGFyZ2V0X3RpZXIYASABKA4yCy5wYi5LWUNUaWVyUg'
    'p0YXJnZXRUaWVyEiEKDGNvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGU=');

@$core.Deprecated('Use initiateKYCResponseDescriptor instead')
const InitiateKYCResponse$json = {
  '1': 'InitiateKYCResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {
      '1': 'required_documents',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'requiredDocuments'
    },
    {'1': 'required_fields', '3': 4, '4': 3, '5': 9, '10': 'requiredFields'},
    {'1': 'redirect_url', '3': 5, '4': 1, '5': 9, '10': 'redirectUrl'},
    {'1': 'error_message', '3': 6, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `InitiateKYCResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCResponseDescriptor = $convert.base64Decode(
    'ChNJbml0aWF0ZUtZQ1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKc2Vzc2'
    'lvbl9pZBgCIAEoCVIJc2Vzc2lvbklkEi0KEnJlcXVpcmVkX2RvY3VtZW50cxgDIAMoCVIRcmVx'
    'dWlyZWREb2N1bWVudHMSJwoPcmVxdWlyZWRfZmllbGRzGAQgAygJUg5yZXF1aXJlZEZpZWxkcx'
    'IhCgxyZWRpcmVjdF91cmwYBSABKAlSC3JlZGlyZWN0VXJsEiMKDWVycm9yX21lc3NhZ2UYBiAB'
    'KAlSDGVycm9yTWVzc2FnZQ==');

@$core.Deprecated('Use uploadDocumentRequestDescriptor instead')
const UploadDocumentRequest$json = {
  '1': 'UploadDocumentRequest',
  '2': [
    {
      '1': 'document_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.pb.DocumentType',
      '10': 'documentType'
    },
    {
      '1': 'document_front_url',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'documentFrontUrl'
    },
    {'1': 'document_back_url', '3': 3, '4': 1, '5': 9, '10': 'documentBackUrl'},
    {'1': 'selfie_url', '3': 4, '4': 1, '5': 9, '10': 'selfieUrl'},
    {
      '1': 'proof_of_address_url',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'proofOfAddressUrl'
    },
  ],
};

/// Descriptor for `UploadDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadDocumentRequestDescriptor = $convert.base64Decode(
    'ChVVcGxvYWREb2N1bWVudFJlcXVlc3QSNQoNZG9jdW1lbnRfdHlwZRgBIAEoDjIQLnBiLkRvY3'
    'VtZW50VHlwZVIMZG9jdW1lbnRUeXBlEiwKEmRvY3VtZW50X2Zyb250X3VybBgCIAEoCVIQZG9j'
    'dW1lbnRGcm9udFVybBIqChFkb2N1bWVudF9iYWNrX3VybBgDIAEoCVIPZG9jdW1lbnRCYWNrVX'
    'JsEh0KCnNlbGZpZV91cmwYBCABKAlSCXNlbGZpZVVybBIvChRwcm9vZl9vZl9hZGRyZXNzX3Vy'
    'bBgFIAEoCVIRcHJvb2ZPZkFkZHJlc3NVcmw=');

@$core.Deprecated('Use uploadDocumentResponseDescriptor instead')
const UploadDocumentResponse$json = {
  '1': 'UploadDocumentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'document_id', '3': 3, '4': 1, '5': 9, '10': 'documentId'},
    {
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.pb.DocumentStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `UploadDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadDocumentResponseDescriptor = $convert.base64Decode(
    'ChZVcGxvYWREb2N1bWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgtkb2N1bWVudF9pZBgDIAEoCVIKZG9jdW1lbnRJZBIq'
    'CgZzdGF0dXMYBCABKA4yEi5wYi5Eb2N1bWVudFN0YXR1c1IGc3RhdHVz');

@$core.Deprecated('Use skipKYCUpgradeRequestDescriptor instead')
const SkipKYCUpgradeRequest$json = {
  '1': 'SkipKYCUpgradeRequest',
  '2': [
    {'1': 'skip_tier_2', '3': 1, '4': 1, '5': 8, '10': 'skipTier2'},
    {'1': 'skip_tier_3', '3': 2, '4': 1, '5': 8, '10': 'skipTier3'},
  ],
};

/// Descriptor for `SkipKYCUpgradeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCUpgradeRequestDescriptor = $convert.base64Decode(
    'ChVTa2lwS1lDVXBncmFkZVJlcXVlc3QSHgoLc2tpcF90aWVyXzIYASABKAhSCXNraXBUaWVyMh'
    'IeCgtza2lwX3RpZXJfMxgCIAEoCFIJc2tpcFRpZXIz');

@$core.Deprecated('Use syncVerifiedKYCTierRequestDescriptor instead')
const SyncVerifiedKYCTierRequest$json = {
  '1': 'SyncVerifiedKYCTierRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'tier', '3': 2, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'tier'},
    {'1': 'source', '3': 3, '4': 1, '5': 9, '10': 'source'},
    {'1': 'bvn', '3': 4, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'nin', '3': 5, '4': 1, '5': 9, '10': 'nin'},
  ],
};

/// Descriptor for `SyncVerifiedKYCTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncVerifiedKYCTierRequestDescriptor =
    $convert.base64Decode(
        'ChpTeW5jVmVyaWZpZWRLWUNUaWVyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHw'
        'oEdGllchgCIAEoDjILLnBiLktZQ1RpZXJSBHRpZXISFgoGc291cmNlGAMgASgJUgZzb3VyY2US'
        'EAoDYnZuGAQgASgJUgNidm4SEAoDbmluGAUgASgJUgNuaW4=');

@$core.Deprecated('Use syncVerifiedKYCTierResponseDescriptor instead')
const SyncVerifiedKYCTierResponse$json = {
  '1': 'SyncVerifiedKYCTierResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'current_tier',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCTier',
      '10': 'currentTier'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SyncVerifiedKYCTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncVerifiedKYCTierResponseDescriptor =
    $convert.base64Decode(
        'ChtTeW5jVmVyaWZpZWRLWUNUaWVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
        'IuCgxjdXJyZW50X3RpZXIYAiABKA4yCy5wYi5LWUNUaWVyUgtjdXJyZW50VGllchIYCgdtZXNz'
        'YWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use adminOverrideKYCTierRequestDescriptor instead')
const AdminOverrideKYCTierRequest$json = {
  '1': 'AdminOverrideKYCTierRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'tier', '3': 2, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'tier'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'actor_admin_id', '3': 4, '4': 1, '5': 9, '10': 'actorAdminId'},
    {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminOverrideKYCTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminOverrideKYCTierRequestDescriptor = $convert.base64Decode(
    'ChtBZG1pbk92ZXJyaWRlS1lDVGllclJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh'
    '8KBHRpZXIYAiABKA4yCy5wYi5LWUNUaWVyUgR0aWVyEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVz'
    'EiQKDmFjdG9yX2FkbWluX2lkGAQgASgJUgxhY3RvckFkbWluSWQSFgoGcmVhc29uGAUgASgJUg'
    'ZyZWFzb24=');

@$core.Deprecated('Use adminOverrideKYCTierResponseDescriptor instead')
const AdminOverrideKYCTierResponse$json = {
  '1': 'AdminOverrideKYCTierResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'current_tier',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCTier',
      '10': 'currentTier'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminOverrideKYCTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminOverrideKYCTierResponseDescriptor =
    $convert.base64Decode(
        'ChxBZG1pbk92ZXJyaWRlS1lDVGllclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
        'MSLgoMY3VycmVudF90aWVyGAIgASgOMgsucGIuS1lDVGllclILY3VycmVudFRpZXISGAoHbWVz'
        'c2FnZRgDIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use adminResetTransactionPinRequestDescriptor instead')
const AdminResetTransactionPinRequest$json = {
  '1': 'AdminResetTransactionPinRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'actor_admin_id', '3': 2, '4': 1, '5': 9, '10': 'actorAdminId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminResetTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminResetTransactionPinRequestDescriptor =
    $convert.base64Decode(
        'Ch9BZG1pblJlc2V0VHJhbnNhY3Rpb25QaW5SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZX'
        'JJZBIkCg5hY3Rvcl9hZG1pbl9pZBgCIAEoCVIMYWN0b3JBZG1pbklkEhYKBnJlYXNvbhgDIAEo'
        'CVIGcmVhc29u');

@$core.Deprecated('Use adminResetTransactionPinResponseDescriptor instead')
const AdminResetTransactionPinResponse$json = {
  '1': 'AdminResetTransactionPinResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminResetTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminResetTransactionPinResponseDescriptor =
    $convert.base64Decode(
        'CiBBZG1pblJlc2V0VHJhbnNhY3Rpb25QaW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
        'NjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getKYCTierRequestDescriptor instead')
const GetKYCTierRequest$json = {
  '1': 'GetKYCTierRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetKYCTierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCTierRequestDescriptor = $convert.base64Decode(
    'ChFHZXRLWUNUaWVyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use getKYCTierResponseDescriptor instead')
const GetKYCTierResponse$json = {
  '1': 'GetKYCTierResponse',
  '2': [
    {'1': 'tier', '3': 1, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'tier'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetKYCTierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCTierResponseDescriptor = $convert.base64Decode(
    'ChJHZXRLWUNUaWVyUmVzcG9uc2USHwoEdGllchgBIAEoDjILLnBiLktZQ1RpZXJSBHRpZXISFg'
    'oGc3RhdHVzGAIgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use getUserIdentityForServiceRequestDescriptor instead')
const GetUserIdentityForServiceRequest$json = {
  '1': 'GetUserIdentityForServiceRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserIdentityForServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserIdentityForServiceRequestDescriptor =
    $convert.base64Decode(
        'CiBHZXRVc2VySWRlbnRpdHlGb3JTZXJ2aWNlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2'
        'VySWQ=');

@$core.Deprecated('Use markEmailBouncedByEmailRequestDescriptor instead')
const MarkEmailBouncedByEmailRequest$json = {
  '1': 'MarkEmailBouncedByEmailRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `MarkEmailBouncedByEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markEmailBouncedByEmailRequestDescriptor =
    $convert.base64Decode(
        'Ch5NYXJrRW1haWxCb3VuY2VkQnlFbWFpbFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEh'
        'YKBnJlYXNvbhgCIAEoCVIGcmVhc29u');

@$core.Deprecated('Use markEmailBouncedByEmailResponseDescriptor instead')
const MarkEmailBouncedByEmailResponse$json = {
  '1': 'MarkEmailBouncedByEmailResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'matched', '3': 2, '4': 1, '5': 8, '10': 'matched'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `MarkEmailBouncedByEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markEmailBouncedByEmailResponseDescriptor =
    $convert.base64Decode(
        'Ch9NYXJrRW1haWxCb3VuY2VkQnlFbWFpbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
        'Nlc3MSGAoHbWF0Y2hlZBgCIAEoCFIHbWF0Y2hlZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use getUserIdentityForServiceResponseDescriptor instead')
const GetUserIdentityForServiceResponse$json = {
  '1': 'GetUserIdentityForServiceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'date_of_birth', '3': 6, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'bvn', '3': 7, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'nin', '3': 8, '4': 1, '5': 9, '10': 'nin'},
    {
      '1': 'identity_verified',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'identityVerified'
    },
    {'1': 'identity_type', '3': 10, '4': 1, '5': 9, '10': 'identityType'},
  ],
};

/// Descriptor for `GetUserIdentityForServiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserIdentityForServiceResponseDescriptor = $convert.base64Decode(
    'CiFHZXRVc2VySWRlbnRpdHlGb3JTZXJ2aWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3'
    'VjY2VzcxIdCgpmaXJzdF9uYW1lGAIgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAMgASgJ'
    'UghsYXN0TmFtZRIUCgVlbWFpbBgEIAEoCVIFZW1haWwSFAoFcGhvbmUYBSABKAlSBXBob25lEi'
    'IKDWRhdGVfb2ZfYmlydGgYBiABKAlSC2RhdGVPZkJpcnRoEhAKA2J2bhgHIAEoCVIDYnZuEhAK'
    'A25pbhgIIAEoCVIDbmluEisKEWlkZW50aXR5X3ZlcmlmaWVkGAkgASgIUhBpZGVudGl0eVZlcm'
    'lmaWVkEiMKDWlkZW50aXR5X3R5cGUYCiABKAlSDGlkZW50aXR5VHlwZQ==');

@$core.Deprecated('Use getMyInsurancePrefillRequestDescriptor instead')
const GetMyInsurancePrefillRequest$json = {
  '1': 'GetMyInsurancePrefillRequest',
};

/// Descriptor for `GetMyInsurancePrefillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyInsurancePrefillRequestDescriptor =
    $convert.base64Decode('ChxHZXRNeUluc3VyYW5jZVByZWZpbGxSZXF1ZXN0');

@$core.Deprecated('Use getMyInsurancePrefillResponseDescriptor instead')
const GetMyInsurancePrefillResponse$json = {
  '1': 'GetMyInsurancePrefillResponse',
  '2': [
    {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'nin', '3': 6, '4': 1, '5': 9, '10': 'nin'},
    {'1': 'bvn', '3': 7, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'identity_type', '3': 8, '4': 1, '5': 9, '10': 'identityType'},
    {
      '1': 'identity_verified',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'identityVerified'
    },
  ],
};

/// Descriptor for `GetMyInsurancePrefillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyInsurancePrefillResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRNeUluc3VyYW5jZVByZWZpbGxSZXNwb25zZRIdCgpmaXJzdF9uYW1lGAEgASgJUglmaX'
    'JzdE5hbWUSGwoJbGFzdF9uYW1lGAIgASgJUghsYXN0TmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1h'
    'aWwSFAoFcGhvbmUYBCABKAlSBXBob25lEiIKDWRhdGVfb2ZfYmlydGgYBSABKAlSC2RhdGVPZk'
    'JpcnRoEhAKA25pbhgGIAEoCVIDbmluEhAKA2J2bhgHIAEoCVIDYnZuEiMKDWlkZW50aXR5X3R5'
    'cGUYCCABKAlSDGlkZW50aXR5VHlwZRIrChFpZGVudGl0eV92ZXJpZmllZBgJIAEoCFIQaWRlbn'
    'RpdHlWZXJpZmllZA==');

@$core.Deprecated('Use skipKYCUpgradeResponseDescriptor instead')
const SkipKYCUpgradeResponse$json = {
  '1': 'SkipKYCUpgradeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'assigned_tier',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCTier',
      '10': 'assignedTier'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'next_steps', '3': 4, '4': 3, '5': 9, '10': 'nextSteps'},
  ],
};

/// Descriptor for `SkipKYCUpgradeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCUpgradeResponseDescriptor = $convert.base64Decode(
    'ChZTa2lwS1lDVXBncmFkZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSMAoNYX'
    'NzaWduZWRfdGllchgCIAEoDjILLnBiLktZQ1RpZXJSDGFzc2lnbmVkVGllchIYCgdtZXNzYWdl'
    'GAMgASgJUgdtZXNzYWdlEh0KCm5leHRfc3RlcHMYBCADKAlSCW5leHRTdGVwcw==');

@$core.Deprecated('Use getUserDocumentsRequestDescriptor instead')
const GetUserDocumentsRequest$json = {
  '1': 'GetUserDocumentsRequest',
};

/// Descriptor for `GetUserDocumentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsRequestDescriptor =
    $convert.base64Decode('ChdHZXRVc2VyRG9jdW1lbnRzUmVxdWVzdA==');

@$core.Deprecated('Use verificationDocumentDescriptor instead')
const VerificationDocument$json = {
  '1': 'VerificationDocument',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'document_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.DocumentType',
      '10': 'documentType'
    },
    {'1': 'document_url', '3': 3, '4': 1, '5': 9, '10': 'documentUrl'},
    {
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.pb.DocumentStatus',
      '10': 'status'
    },
    {'1': 'uploaded_at', '3': 5, '4': 1, '5': 9, '10': 'uploadedAt'},
    {'1': 'verified_at', '3': 6, '4': 1, '5': 9, '10': 'verifiedAt'},
    {'1': 'rejection_reason', '3': 7, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `VerificationDocument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verificationDocumentDescriptor = $convert.base64Decode(
    'ChRWZXJpZmljYXRpb25Eb2N1bWVudBIOCgJpZBgBIAEoCVICaWQSNQoNZG9jdW1lbnRfdHlwZR'
    'gCIAEoDjIQLnBiLkRvY3VtZW50VHlwZVIMZG9jdW1lbnRUeXBlEiEKDGRvY3VtZW50X3VybBgD'
    'IAEoCVILZG9jdW1lbnRVcmwSKgoGc3RhdHVzGAQgASgOMhIucGIuRG9jdW1lbnRTdGF0dXNSBn'
    'N0YXR1cxIfCgt1cGxvYWRlZF9hdBgFIAEoCVIKdXBsb2FkZWRBdBIfCgt2ZXJpZmllZF9hdBgG'
    'IAEoCVIKdmVyaWZpZWRBdBIpChByZWplY3Rpb25fcmVhc29uGAcgASgJUg9yZWplY3Rpb25SZW'
    'Fzb24=');

@$core.Deprecated('Use getUserDocumentsResponseDescriptor instead')
const GetUserDocumentsResponse$json = {
  '1': 'GetUserDocumentsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'documents',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.pb.VerificationDocument',
      '10': 'documents'
    },
  ],
};

/// Descriptor for `GetUserDocumentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRVc2VyRG9jdW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxI2Cg'
        'lkb2N1bWVudHMYAiADKAsyGC5wYi5WZXJpZmljYXRpb25Eb2N1bWVudFIJZG9jdW1lbnRz');

@$core.Deprecated('Use kYCTierInfoDescriptor instead')
const KYCTierInfo$json = {
  '1': 'KYCTierInfo',
  '2': [
    {'1': 'tier', '3': 1, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'tier'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCVerificationStatus',
      '10': 'status'
    },
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'benefits', '3': 5, '4': 3, '5': 9, '10': 'benefits'},
    {
      '1': 'daily_transaction_limit',
      '3': 6,
      '4': 1,
      '5': 3,
      '10': 'dailyTransactionLimit'
    },
    {
      '1': 'daily_receive_limit',
      '3': 7,
      '4': 1,
      '5': 3,
      '10': 'dailyReceiveLimit'
    },
    {'1': 'max_balance', '3': 8, '4': 1, '5': 3, '10': 'maxBalance'},
    {'1': 'verified_at', '3': 9, '4': 1, '5': 9, '10': 'verifiedAt'},
    {'1': 'expires_at', '3': 10, '4': 1, '5': 9, '10': 'expiresAt'},
    {'1': 'is_current', '3': 11, '4': 1, '5': 8, '10': 'isCurrent'},
    {'1': 'is_locked', '3': 12, '4': 1, '5': 8, '10': 'isLocked'},
  ],
};

/// Descriptor for `KYCTierInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kYCTierInfoDescriptor = $convert.base64Decode(
    'CgtLWUNUaWVySW5mbxIfCgR0aWVyGAEgASgOMgsucGIuS1lDVGllclIEdGllchIxCgZzdGF0dX'
    'MYAiABKA4yGS5wYi5LWUNWZXJpZmljYXRpb25TdGF0dXNSBnN0YXR1cxIhCgxkaXNwbGF5X25h'
    'bWUYAyABKAlSC2Rpc3BsYXlOYW1lEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbh'
    'IaCghiZW5lZml0cxgFIAMoCVIIYmVuZWZpdHMSNgoXZGFpbHlfdHJhbnNhY3Rpb25fbGltaXQY'
    'BiABKANSFWRhaWx5VHJhbnNhY3Rpb25MaW1pdBIuChNkYWlseV9yZWNlaXZlX2xpbWl0GAcgAS'
    'gDUhFkYWlseVJlY2VpdmVMaW1pdBIfCgttYXhfYmFsYW5jZRgIIAEoA1IKbWF4QmFsYW5jZRIf'
    'Cgt2ZXJpZmllZF9hdBgJIAEoCVIKdmVyaWZpZWRBdBIdCgpleHBpcmVzX2F0GAogASgJUglleH'
    'BpcmVzQXQSHQoKaXNfY3VycmVudBgLIAEoCFIJaXNDdXJyZW50EhsKCWlzX2xvY2tlZBgMIAEo'
    'CFIIaXNMb2NrZWQ=');

@$core.Deprecated('Use getKYCStatusRequestDescriptor instead')
const GetKYCStatusRequest$json = {
  '1': 'GetKYCStatusRequest',
};

/// Descriptor for `GetKYCStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCStatusRequestDescriptor =
    $convert.base64Decode('ChNHZXRLWUNTdGF0dXNSZXF1ZXN0');

@$core.Deprecated('Use getKYCStatusResponseDescriptor instead')
const GetKYCStatusResponse$json = {
  '1': 'GetKYCStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCVerificationStatus',
      '10': 'status'
    },
    {
      '1': 'current_tier',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCTier',
      '10': 'currentTier'
    },
    {
      '1': 'tier_info',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.pb.KYCTierInfo',
      '10': 'tierInfo'
    },
    {'1': 'last_updated', '3': 5, '4': 1, '5': 9, '10': 'lastUpdated'},
    {'1': 'rejection_reason', '3': 6, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `GetKYCStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCStatusResponseDescriptor = $convert.base64Decode(
    'ChRHZXRLWUNTdGF0dXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEjEKBnN0YX'
    'R1cxgCIAEoDjIZLnBiLktZQ1ZlcmlmaWNhdGlvblN0YXR1c1IGc3RhdHVzEi4KDGN1cnJlbnRf'
    'dGllchgDIAEoDjILLnBiLktZQ1RpZXJSC2N1cnJlbnRUaWVyEiwKCXRpZXJfaW5mbxgEIAMoCz'
    'IPLnBiLktZQ1RpZXJJbmZvUgh0aWVySW5mbxIhCgxsYXN0X3VwZGF0ZWQYBSABKAlSC2xhc3RV'
    'cGRhdGVkEikKEHJlamVjdGlvbl9yZWFzb24YBiABKAlSD3JlamVjdGlvblJlYXNvbg==');

@$core.Deprecated('Use countryKYCRequirementsDescriptor instead')
const CountryKYCRequirements$json = {
  '1': 'CountryKYCRequirements',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
    {
      '1': 'accepted_id_types',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.pb.IdentityType',
      '10': 'acceptedIdTypes'
    },
    {
      '1': 'mandatory_id_types',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.pb.IdentityType',
      '10': 'mandatoryIdTypes'
    },
    {
      '1': 'address_proof_required',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'addressProofRequired'
    },
    {
      '1': 'liveness_check_required',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'livenessCheckRequired'
    },
    {
      '1': 'tier_1_daily_limit',
      '3': 6,
      '4': 1,
      '5': 3,
      '10': 'tier1DailyLimit'
    },
    {
      '1': 'tier_2_daily_limit',
      '3': 7,
      '4': 1,
      '5': 3,
      '10': 'tier2DailyLimit'
    },
    {
      '1': 'tier_3_daily_limit',
      '3': 8,
      '4': 1,
      '5': 3,
      '10': 'tier3DailyLimit'
    },
  ],
};

/// Descriptor for `CountryKYCRequirements`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countryKYCRequirementsDescriptor = $convert.base64Decode(
    'ChZDb3VudHJ5S1lDUmVxdWlyZW1lbnRzEiEKDGNvdW50cnlfY29kZRgBIAEoCVILY291bnRyeU'
    'NvZGUSPAoRYWNjZXB0ZWRfaWRfdHlwZXMYAiADKA4yEC5wYi5JZGVudGl0eVR5cGVSD2FjY2Vw'
    'dGVkSWRUeXBlcxI+ChJtYW5kYXRvcnlfaWRfdHlwZXMYAyADKA4yEC5wYi5JZGVudGl0eVR5cG'
    'VSEG1hbmRhdG9yeUlkVHlwZXMSNAoWYWRkcmVzc19wcm9vZl9yZXF1aXJlZBgEIAEoCFIUYWRk'
    'cmVzc1Byb29mUmVxdWlyZWQSNgoXbGl2ZW5lc3NfY2hlY2tfcmVxdWlyZWQYBSABKAhSFWxpdm'
    'VuZXNzQ2hlY2tSZXF1aXJlZBIrChJ0aWVyXzFfZGFpbHlfbGltaXQYBiABKANSD3RpZXIxRGFp'
    'bHlMaW1pdBIrChJ0aWVyXzJfZGFpbHlfbGltaXQYByABKANSD3RpZXIyRGFpbHlMaW1pdBIrCh'
    'J0aWVyXzNfZGFpbHlfbGltaXQYCCABKANSD3RpZXIzRGFpbHlMaW1pdA==');

@$core.Deprecated('Use getCountryRequirementsRequestDescriptor instead')
const GetCountryRequirementsRequest$json = {
  '1': 'GetCountryRequirementsRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetCountryRequirementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRequirementsRequestDescriptor =
    $convert.base64Decode(
        'Ch1HZXRDb3VudHJ5UmVxdWlyZW1lbnRzUmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2'
        'NvdW50cnlDb2Rl');

@$core.Deprecated('Use getCountryRequirementsResponseDescriptor instead')
const GetCountryRequirementsResponse$json = {
  '1': 'GetCountryRequirementsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'requirements',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.CountryKYCRequirements',
      '10': 'requirements'
    },
  ],
};

/// Descriptor for `GetCountryRequirementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRequirementsResponseDescriptor =
    $convert.base64Decode(
        'Ch5HZXRDb3VudHJ5UmVxdWlyZW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
        'VzcxI+CgxyZXF1aXJlbWVudHMYAiABKAsyGi5wYi5Db3VudHJ5S1lDUmVxdWlyZW1lbnRzUgxy'
        'ZXF1aXJlbWVudHM=');

@$core.Deprecated('Use createVerificationSessionRequestDescriptor instead')
const CreateVerificationSessionRequest$json = {
  '1': 'CreateVerificationSessionRequest',
  '2': [
    {
      '1': 'target_tier',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCTier',
      '10': 'targetTier'
    },
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {
      '1': 'id_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.IdentityType',
      '10': 'idType'
    },
    {'1': 'id_number', '3': 4, '4': 1, '5': 9, '10': 'idNumber'},
    {'1': 'first_name', '3': 5, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 6, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'date_of_birth', '3': 7, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'phone_number', '3': 8, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `CreateVerificationSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVerificationSessionRequestDescriptor = $convert.base64Decode(
    'CiBDcmVhdGVWZXJpZmljYXRpb25TZXNzaW9uUmVxdWVzdBIsCgt0YXJnZXRfdGllchgBIAEoDj'
    'ILLnBiLktZQ1RpZXJSCnRhcmdldFRpZXISIQoMY291bnRyeV9jb2RlGAIgASgJUgtjb3VudHJ5'
    'Q29kZRIpCgdpZF90eXBlGAMgASgOMhAucGIuSWRlbnRpdHlUeXBlUgZpZFR5cGUSGwoJaWRfbn'
    'VtYmVyGAQgASgJUghpZE51bWJlchIdCgpmaXJzdF9uYW1lGAUgASgJUglmaXJzdE5hbWUSGwoJ'
    'bGFzdF9uYW1lGAYgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAcgASgJUgtkYXRlT2'
    'ZCaXJ0aBIhCgxwaG9uZV9udW1iZXIYCCABKAlSC3Bob25lTnVtYmVy');

@$core.Deprecated('Use createVerificationSessionResponseDescriptor instead')
const CreateVerificationSessionResponse$json = {
  '1': 'CreateVerificationSessionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'verification_id', '3': 2, '4': 1, '5': 9, '10': 'verificationId'},
    {'1': 'session_url', '3': 3, '4': 1, '5': 9, '10': 'sessionUrl'},
    {'1': 'session_token', '3': 4, '4': 1, '5': 9, '10': 'sessionToken'},
    {'1': 'provider', '3': 5, '4': 1, '5': 9, '10': 'provider'},
    {
      '1': 'status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCVerificationStatus',
      '10': 'status'
    },
    {'1': 'error_message', '3': 7, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `CreateVerificationSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVerificationSessionResponseDescriptor = $convert.base64Decode(
    'CiFDcmVhdGVWZXJpZmljYXRpb25TZXNzaW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3'
    'VjY2VzcxInCg92ZXJpZmljYXRpb25faWQYAiABKAlSDnZlcmlmaWNhdGlvbklkEh8KC3Nlc3Np'
    'b25fdXJsGAMgASgJUgpzZXNzaW9uVXJsEiMKDXNlc3Npb25fdG9rZW4YBCABKAlSDHNlc3Npb2'
    '5Ub2tlbhIaCghwcm92aWRlchgFIAEoCVIIcHJvdmlkZXISMQoGc3RhdHVzGAYgASgOMhkucGIu'
    'S1lDVmVyaWZpY2F0aW9uU3RhdHVzUgZzdGF0dXMSIwoNZXJyb3JfbWVzc2FnZRgHIAEoCVIMZX'
    'Jyb3JNZXNzYWdl');

@$core.Deprecated('Use confirmVerificationRequestDescriptor instead')
const ConfirmVerificationRequest$json = {
  '1': 'ConfirmVerificationRequest',
  '2': [
    {'1': 'verification_id', '3': 1, '4': 1, '5': 9, '10': 'verificationId'},
    {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    {
      '1': 'provider_auth_code',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'providerAuthCode'
    },
    {
      '1': 'metadata',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.pb.ConfirmVerificationRequest.MetadataEntry',
      '10': 'metadata'
    },
  ],
  '3': [ConfirmVerificationRequest_MetadataEntry$json],
};

@$core.Deprecated('Use confirmVerificationRequestDescriptor instead')
const ConfirmVerificationRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ConfirmVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmVerificationRequestDescriptor = $convert.base64Decode(
    'ChpDb25maXJtVmVyaWZpY2F0aW9uUmVxdWVzdBInCg92ZXJpZmljYXRpb25faWQYASABKAlSDn'
    'ZlcmlmaWNhdGlvbklkEhoKCHByb3ZpZGVyGAIgASgJUghwcm92aWRlchIsChJwcm92aWRlcl9h'
    'dXRoX2NvZGUYAyABKAlSEHByb3ZpZGVyQXV0aENvZGUSSAoIbWV0YWRhdGEYBCADKAsyLC5wYi'
    '5Db25maXJtVmVyaWZpY2F0aW9uUmVxdWVzdC5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo7Cg1N'
    'ZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOA'
    'E=');

@$core.Deprecated('Use bVNNameReconciliationDescriptor instead')
const BVNNameReconciliation$json = {
  '1': 'BVNNameReconciliation',
  '2': [
    {'1': 'name_action', '3': 1, '4': 1, '5': 9, '10': 'nameAction'},
    {'1': 'name_match_score', '3': 2, '4': 1, '5': 1, '10': 'nameMatchScore'},
    {'1': 'verified_name', '3': 3, '4': 1, '5': 9, '10': 'verifiedName'},
    {'1': 'profile_name', '3': 4, '4': 1, '5': 9, '10': 'profileName'},
  ],
};

/// Descriptor for `BVNNameReconciliation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bVNNameReconciliationDescriptor = $convert.base64Decode(
    'ChVCVk5OYW1lUmVjb25jaWxpYXRpb24SHwoLbmFtZV9hY3Rpb24YASABKAlSCm5hbWVBY3Rpb2'
    '4SKAoQbmFtZV9tYXRjaF9zY29yZRgCIAEoAVIObmFtZU1hdGNoU2NvcmUSIwoNdmVyaWZpZWRf'
    'bmFtZRgDIAEoCVIMdmVyaWZpZWROYW1lEiEKDHByb2ZpbGVfbmFtZRgEIAEoCVILcHJvZmlsZU'
    '5hbWU=');

@$core.Deprecated('Use confirmVerificationResponseDescriptor instead')
const ConfirmVerificationResponse$json = {
  '1': 'ConfirmVerificationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCVerificationStatus',
      '10': 'status'
    },
    {
      '1': 'current_tier',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCTier',
      '10': 'currentTier'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'bvn_name_reconciliation',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.pb.BVNNameReconciliation',
      '10': 'bvnNameReconciliation'
    },
  ],
};

/// Descriptor for `ConfirmVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmVerificationResponseDescriptor = $convert.base64Decode(
    'ChtDb25maXJtVmVyaWZpY2F0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IxCgZzdGF0dXMYAiABKA4yGS5wYi5LWUNWZXJpZmljYXRpb25TdGF0dXNSBnN0YXR1cxIuCgxj'
    'dXJyZW50X3RpZXIYAyABKA4yCy5wYi5LWUNUaWVyUgtjdXJyZW50VGllchIYCgdtZXNzYWdlGA'
    'QgASgJUgdtZXNzYWdlElEKF2J2bl9uYW1lX3JlY29uY2lsaWF0aW9uGAUgASgLMhkucGIuQlZO'
    'TmFtZVJlY29uY2lsaWF0aW9uUhVidm5OYW1lUmVjb25jaWxpYXRpb24=');

@$core.Deprecated('Use getDocumentUploadURLRequestDescriptor instead')
const GetDocumentUploadURLRequest$json = {
  '1': 'GetDocumentUploadURLRequest',
  '2': [
    {'1': 'document_type', '3': 1, '4': 1, '5': 9, '10': 'documentType'},
    {'1': 'content_type', '3': 2, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `GetDocumentUploadURLRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDocumentUploadURLRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXREb2N1bWVudFVwbG9hZFVSTFJlcXVlc3QSIwoNZG9jdW1lbnRfdHlwZRgBIAEoCVIMZG'
        '9jdW1lbnRUeXBlEiEKDGNvbnRlbnRfdHlwZRgCIAEoCVILY29udGVudFR5cGU=');

@$core.Deprecated('Use getDocumentUploadURLResponseDescriptor instead')
const GetDocumentUploadURLResponse$json = {
  '1': 'GetDocumentUploadURLResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'upload_url', '3': 2, '4': 1, '5': 9, '10': 'uploadUrl'},
    {'1': 'storage_key', '3': 3, '4': 1, '5': 9, '10': 'storageKey'},
    {'1': 'expires_at', '3': 4, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `GetDocumentUploadURLResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDocumentUploadURLResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXREb2N1bWVudFVwbG9hZFVSTFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
        'MSHQoKdXBsb2FkX3VybBgCIAEoCVIJdXBsb2FkVXJsEh8KC3N0b3JhZ2Vfa2V5GAMgASgJUgpz'
        'dG9yYWdlS2V5Eh0KCmV4cGlyZXNfYXQYBCABKANSCWV4cGlyZXNBdA==');

@$core.Deprecated('Use documentSubmissionItemDescriptor instead')
const DocumentSubmissionItem$json = {
  '1': 'DocumentSubmissionItem',
  '2': [
    {'1': 'storage_key', '3': 1, '4': 1, '5': 9, '10': 'storageKey'},
    {'1': 'document_type', '3': 2, '4': 1, '5': 9, '10': 'documentType'},
    {'1': 'content_type', '3': 3, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `DocumentSubmissionItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List documentSubmissionItemDescriptor = $convert.base64Decode(
    'ChZEb2N1bWVudFN1Ym1pc3Npb25JdGVtEh8KC3N0b3JhZ2Vfa2V5GAEgASgJUgpzdG9yYWdlS2'
    'V5EiMKDWRvY3VtZW50X3R5cGUYAiABKAlSDGRvY3VtZW50VHlwZRIhCgxjb250ZW50X3R5cGUY'
    'AyABKAlSC2NvbnRlbnRUeXBl');

@$core.Deprecated('Use submitDocumentsForReviewRequestDescriptor instead')
const SubmitDocumentsForReviewRequest$json = {
  '1': 'SubmitDocumentsForReviewRequest',
  '2': [
    {
      '1': 'documents',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.DocumentSubmissionItem',
      '10': 'documents'
    },
  ],
};

/// Descriptor for `SubmitDocumentsForReviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitDocumentsForReviewRequestDescriptor =
    $convert.base64Decode(
        'Ch9TdWJtaXREb2N1bWVudHNGb3JSZXZpZXdSZXF1ZXN0EjgKCWRvY3VtZW50cxgBIAMoCzIaLn'
        'BiLkRvY3VtZW50U3VibWlzc2lvbkl0ZW1SCWRvY3VtZW50cw==');

@$core.Deprecated('Use submitDocumentsForReviewResponseDescriptor instead')
const SubmitDocumentsForReviewResponse$json = {
  '1': 'SubmitDocumentsForReviewResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.KYCVerificationStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `SubmitDocumentsForReviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitDocumentsForReviewResponseDescriptor =
    $convert.base64Decode(
        'CiBTdWJtaXREb2N1bWVudHNGb3JSZXZpZXdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
        'NjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USMQoGc3RhdHVzGAMgASgOMhkucGIuS1lD'
        'VmVyaWZpY2F0aW9uU3RhdHVzUgZzdGF0dXM=');

@$core.Deprecated('Use channelLoginRequestDescriptor instead')
const ChannelLoginRequest$json = {
  '1': 'ChannelLoginRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'channel_type', '3': 2, '4': 1, '5': 9, '10': 'channelType'},
  ],
};

/// Descriptor for `ChannelLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelLoginRequestDescriptor = $convert.base64Decode(
    'ChNDaGFubmVsTG9naW5SZXF1ZXN0EiEKDHBob25lX251bWJlchgBIAEoCVILcGhvbmVOdW1iZX'
    'ISIQoMY2hhbm5lbF90eXBlGAIgASgJUgtjaGFubmVsVHlwZQ==');

@$core.Deprecated('Use channelLoginResponseDescriptor instead')
const ChannelLoginResponse$json = {
  '1': 'ChannelLoginResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'user_country', '3': 8, '4': 1, '5': 9, '10': 'userCountry'},
    {'1': 'expires_in', '3': 9, '4': 1, '5': 5, '10': 'expiresIn'},
  ],
};

/// Descriptor for `ChannelLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelLoginResponseDescriptor = $convert.base64Decode(
    'ChRDaGFubmVsTG9naW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2USIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tlbhIj'
    'Cg1yZWZyZXNoX3Rva2VuGAQgASgJUgxyZWZyZXNoVG9rZW4SFwoHdXNlcl9pZBgFIAEoCVIGdX'
    'NlcklkEh0KCmFjY291bnRfaWQYBiABKAlSCWFjY291bnRJZBIaCghjdXJyZW5jeRgHIAEoCVII'
    'Y3VycmVuY3kSIQoMdXNlcl9jb3VudHJ5GAggASgJUgt1c2VyQ291bnRyeRIdCgpleHBpcmVzX2'
    'luGAkgASgFUglleHBpcmVzSW4=');

@$core.Deprecated('Use channelRegisterRequestDescriptor instead')
const ChannelRegisterRequest$json = {
  '1': 'ChannelRegisterRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'channel_type', '3': 5, '4': 1, '5': 9, '10': 'channelType'},
    {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `ChannelRegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelRegisterRequestDescriptor = $convert.base64Decode(
    'ChZDaGFubmVsUmVnaXN0ZXJSZXF1ZXN0EiEKDHBob25lX251bWJlchgBIAEoCVILcGhvbmVOdW'
    '1iZXISHQoKZmlyc3RfbmFtZRgCIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgDIAEoCVII'
    'bGFzdE5hbWUSFAoFZW1haWwYBCABKAlSBWVtYWlsEiEKDGNoYW5uZWxfdHlwZRgFIAEoCVILY2'
    'hhbm5lbFR5cGUSIQoMY291bnRyeV9jb2RlGAYgASgJUgtjb3VudHJ5Q29kZQ==');

@$core.Deprecated('Use channelRegisterResponseDescriptor instead')
const ChannelRegisterResponse$json = {
  '1': 'ChannelRegisterResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'otp_sent', '3': 4, '4': 1, '5': 8, '10': 'otpSent'},
    {'1': 'masked_email', '3': 5, '4': 1, '5': 9, '10': 'maskedEmail'},
    {
      '1': 'otp_expires_in_seconds',
      '3': 6,
      '4': 1,
      '5': 5,
      '10': 'otpExpiresInSeconds'
    },
  ],
};

/// Descriptor for `ChannelRegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelRegisterResponseDescriptor = $convert.base64Decode(
    'ChdDaGFubmVsUmVnaXN0ZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2USFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhkKCG90cF9z'
    'ZW50GAQgASgIUgdvdHBTZW50EiEKDG1hc2tlZF9lbWFpbBgFIAEoCVILbWFza2VkRW1haWwSMw'
    'oWb3RwX2V4cGlyZXNfaW5fc2Vjb25kcxgGIAEoBVITb3RwRXhwaXJlc0luU2Vjb25kcw==');

@$core.Deprecated('Use channelVerifyRegistrationRequestDescriptor instead')
const ChannelVerifyRegistrationRequest$json = {
  '1': 'ChannelVerifyRegistrationRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'otp_code', '3': 2, '4': 1, '5': 9, '10': 'otpCode'},
    {'1': 'channel_type', '3': 3, '4': 1, '5': 9, '10': 'channelType'},
  ],
};

/// Descriptor for `ChannelVerifyRegistrationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelVerifyRegistrationRequestDescriptor =
    $convert.base64Decode(
        'CiBDaGFubmVsVmVyaWZ5UmVnaXN0cmF0aW9uUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKA'
        'lSC3Bob25lTnVtYmVyEhkKCG90cF9jb2RlGAIgASgJUgdvdHBDb2RlEiEKDGNoYW5uZWxfdHlw'
        'ZRgDIAEoCVILY2hhbm5lbFR5cGU=');

@$core.Deprecated('Use channelVerifyRegistrationResponseDescriptor instead')
const ChannelVerifyRegistrationResponse$json = {
  '1': 'ChannelVerifyRegistrationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'user_country', '3': 8, '4': 1, '5': 9, '10': 'userCountry'},
    {'1': 'expires_in', '3': 9, '4': 1, '5': 5, '10': 'expiresIn'},
  ],
};

/// Descriptor for `ChannelVerifyRegistrationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelVerifyRegistrationResponseDescriptor = $convert.base64Decode(
    'CiFDaGFubmVsVmVyaWZ5UmVnaXN0cmF0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3'
    'VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiEKDGFjY2Vzc190b2tlbhgDIAEoCVIL'
    'YWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgEIAEoCVIMcmVmcmVzaFRva2VuEhcKB3VzZX'
    'JfaWQYBSABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAYgASgJUglhY2NvdW50SWQSGgoIY3Vy'
    'cmVuY3kYByABKAlSCGN1cnJlbmN5EiEKDHVzZXJfY291bnRyeRgIIAEoCVILdXNlckNvdW50cn'
    'kSHQoKZXhwaXJlc19pbhgJIAEoBVIJZXhwaXJlc0lu');

@$core.Deprecated('Use adminGenerateTokenByPhoneRequestDescriptor instead')
const AdminGenerateTokenByPhoneRequest$json = {
  '1': 'AdminGenerateTokenByPhoneRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'admin_secret', '3': 2, '4': 1, '5': 9, '10': 'adminSecret'},
    {'1': 'channel_type', '3': 3, '4': 1, '5': 9, '10': 'channelType'},
  ],
};

/// Descriptor for `AdminGenerateTokenByPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGenerateTokenByPhoneRequestDescriptor =
    $convert.base64Decode(
        'CiBBZG1pbkdlbmVyYXRlVG9rZW5CeVBob25lUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKA'
        'lSC3Bob25lTnVtYmVyEiEKDGFkbWluX3NlY3JldBgCIAEoCVILYWRtaW5TZWNyZXQSIQoMY2hh'
        'bm5lbF90eXBlGAMgASgJUgtjaGFubmVsVHlwZQ==');

@$core.Deprecated('Use adminGenerateTokenByPhoneResponseDescriptor instead')
const AdminGenerateTokenByPhoneResponse$json = {
  '1': 'AdminGenerateTokenByPhoneResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'user_country', '3': 8, '4': 1, '5': 9, '10': 'userCountry'},
    {'1': 'expires_in', '3': 9, '4': 1, '5': 5, '10': 'expiresIn'},
    {'1': 'user_found', '3': 10, '4': 1, '5': 8, '10': 'userFound'},
    {'1': 'first_name', '3': 11, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 12, '4': 1, '5': 9, '10': 'lastName'},
  ],
};

/// Descriptor for `AdminGenerateTokenByPhoneResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGenerateTokenByPhoneResponseDescriptor = $convert.base64Decode(
    'CiFBZG1pbkdlbmVyYXRlVG9rZW5CeVBob25lUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3'
    'VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiEKDGFjY2Vzc190b2tlbhgDIAEoCVIL'
    'YWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgEIAEoCVIMcmVmcmVzaFRva2VuEhcKB3VzZX'
    'JfaWQYBSABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAYgASgJUglhY2NvdW50SWQSGgoIY3Vy'
    'cmVuY3kYByABKAlSCGN1cnJlbmN5EiEKDHVzZXJfY291bnRyeRgIIAEoCVILdXNlckNvdW50cn'
    'kSHQoKZXhwaXJlc19pbhgJIAEoBVIJZXhwaXJlc0luEh0KCnVzZXJfZm91bmQYCiABKAhSCXVz'
    'ZXJGb3VuZBIdCgpmaXJzdF9uYW1lGAsgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAwgAS'
    'gJUghsYXN0TmFtZQ==');
