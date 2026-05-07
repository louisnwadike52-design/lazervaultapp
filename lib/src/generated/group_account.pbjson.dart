///
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use groupAccountStatusDescriptor instead')
const GroupAccountStatus$json = const {
  '1': 'GroupAccountStatus',
  '2': const [
    const {'1': 'GROUP_ACCOUNT_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'GROUP_ACCOUNT_STATUS_ACTIVE', '2': 1},
    const {'1': 'GROUP_ACCOUNT_STATUS_SUSPENDED', '2': 2},
    const {'1': 'GROUP_ACCOUNT_STATUS_CLOSED', '2': 3},
  ],
};

/// Descriptor for `GroupAccountStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupAccountStatusDescriptor = $convert.base64Decode('ChJHcm91cEFjY291bnRTdGF0dXMSJAogR1JPVVBfQUNDT1VOVF9TVEFUVVNfVU5TUEVDSUZJRUQQABIfChtHUk9VUF9BQ0NPVU5UX1NUQVRVU19BQ1RJVkUQARIiCh5HUk9VUF9BQ0NPVU5UX1NUQVRVU19TVVNQRU5ERUQQAhIfChtHUk9VUF9BQ0NPVU5UX1NUQVRVU19DTE9TRUQQAw==');
@$core.Deprecated('Use groupMemberRoleDescriptor instead')
const GroupMemberRole$json = const {
  '1': 'GroupMemberRole',
  '2': const [
    const {'1': 'GROUP_MEMBER_ROLE_UNSPECIFIED', '2': 0},
    const {'1': 'GROUP_MEMBER_ROLE_ADMIN', '2': 1},
    const {'1': 'GROUP_MEMBER_ROLE_MEMBER', '2': 2},
    const {'1': 'GROUP_MEMBER_ROLE_VIEWER', '2': 3},
    const {'1': 'GROUP_MEMBER_ROLE_MODERATOR', '2': 4},
  ],
};

/// Descriptor for `GroupMemberRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupMemberRoleDescriptor = $convert.base64Decode('Cg9Hcm91cE1lbWJlclJvbGUSIQodR1JPVVBfTUVNQkVSX1JPTEVfVU5TUEVDSUZJRUQQABIbChdHUk9VUF9NRU1CRVJfUk9MRV9BRE1JThABEhwKGEdST1VQX01FTUJFUl9ST0xFX01FTUJFUhACEhwKGEdST1VQX01FTUJFUl9ST0xFX1ZJRVdFUhADEh8KG0dST1VQX01FTUJFUl9ST0xFX01PREVSQVRPUhAE');
@$core.Deprecated('Use groupMemberStatusDescriptor instead')
const GroupMemberStatus$json = const {
  '1': 'GroupMemberStatus',
  '2': const [
    const {'1': 'GROUP_MEMBER_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'GROUP_MEMBER_STATUS_ACTIVE', '2': 1},
    const {'1': 'GROUP_MEMBER_STATUS_INACTIVE', '2': 2},
    const {'1': 'GROUP_MEMBER_STATUS_SUSPENDED', '2': 3},
    const {'1': 'GROUP_MEMBER_STATUS_REMOVED', '2': 4},
    const {'1': 'GROUP_MEMBER_STATUS_PENDING', '2': 5},
  ],
};

/// Descriptor for `GroupMemberStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupMemberStatusDescriptor = $convert.base64Decode('ChFHcm91cE1lbWJlclN0YXR1cxIjCh9HUk9VUF9NRU1CRVJfU1RBVFVTX1VOU1BFQ0lGSUVEEAASHgoaR1JPVVBfTUVNQkVSX1NUQVRVU19BQ1RJVkUQARIgChxHUk9VUF9NRU1CRVJfU1RBVFVTX0lOQUNUSVZFEAISIQodR1JPVVBfTUVNQkVSX1NUQVRVU19TVVNQRU5ERUQQAxIfChtHUk9VUF9NRU1CRVJfU1RBVFVTX1JFTU9WRUQQBBIfChtHUk9VUF9NRU1CRVJfU1RBVFVTX1BFTkRJTkcQBQ==');
@$core.Deprecated('Use contributionTypeDescriptor instead')
const ContributionType$json = const {
  '1': 'ContributionType',
  '2': const [
    const {'1': 'CONTRIBUTION_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'CONTRIBUTION_TYPE_ONE_TIME', '2': 1},
    const {'1': 'CONTRIBUTION_TYPE_ROTATING_SAVINGS', '2': 3},
  ],
  '4': const [
    const {'1': 2, '2': 2},
  ],
  '5': const ['CONTRIBUTION_TYPE_RECURRING'],
};

/// Descriptor for `ContributionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contributionTypeDescriptor = $convert.base64Decode('ChBDb250cmlidXRpb25UeXBlEiEKHUNPTlRSSUJVVElPTl9UWVBFX1VOU1BFQ0lGSUVEEAASHgoaQ09OVFJJQlVUSU9OX1RZUEVfT05FX1RJTUUQARImCiJDT05UUklCVVRJT05fVFlQRV9ST1RBVElOR19TQVZJTkdTEAMiBAgCEAIqG0NPTlRSSUJVVElPTl9UWVBFX1JFQ1VSUklORw==');
@$core.Deprecated('Use contributionFrequencyDescriptor instead')
const ContributionFrequency$json = const {
  '1': 'ContributionFrequency',
  '2': const [
    const {'1': 'CONTRIBUTION_FREQUENCY_UNSPECIFIED', '2': 0},
    const {'1': 'CONTRIBUTION_FREQUENCY_DAILY', '2': 1},
    const {'1': 'CONTRIBUTION_FREQUENCY_WEEKLY', '2': 2},
    const {'1': 'CONTRIBUTION_FREQUENCY_BIWEEKLY', '2': 3},
    const {'1': 'CONTRIBUTION_FREQUENCY_MONTHLY', '2': 4},
    const {'1': 'CONTRIBUTION_FREQUENCY_QUARTERLY', '2': 5},
    const {'1': 'CONTRIBUTION_FREQUENCY_YEARLY', '2': 6},
  ],
};

/// Descriptor for `ContributionFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contributionFrequencyDescriptor = $convert.base64Decode('ChVDb250cmlidXRpb25GcmVxdWVuY3kSJgoiQ09OVFJJQlVUSU9OX0ZSRVFVRU5DWV9VTlNQRUNJRklFRBAAEiAKHENPTlRSSUJVVElPTl9GUkVRVUVOQ1lfREFJTFkQARIhCh1DT05UUklCVVRJT05fRlJFUVVFTkNZX1dFRUtMWRACEiMKH0NPTlRSSUJVVElPTl9GUkVRVUVOQ1lfQklXRUVLTFkQAxIiCh5DT05UUklCVVRJT05fRlJFUVVFTkNZX01PTlRITFkQBBIkCiBDT05UUklCVVRJT05fRlJFUVVFTkNZX1FVQVJURVJMWRAFEiEKHUNPTlRSSUJVVElPTl9GUkVRVUVOQ1lfWUVBUkxZEAY=');
@$core.Deprecated('Use contributionStatusDescriptor instead')
const ContributionStatus$json = const {
  '1': 'ContributionStatus',
  '2': const [
    const {'1': 'CONTRIBUTION_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'CONTRIBUTION_STATUS_ACTIVE', '2': 1},
    const {'1': 'CONTRIBUTION_STATUS_PAUSED', '2': 2},
    const {'1': 'CONTRIBUTION_STATUS_COMPLETED', '2': 3},
    const {'1': 'CONTRIBUTION_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `ContributionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contributionStatusDescriptor = $convert.base64Decode('ChJDb250cmlidXRpb25TdGF0dXMSIwofQ09OVFJJQlVUSU9OX1NUQVRVU19VTlNQRUNJRklFRBAAEh4KGkNPTlRSSUJVVElPTl9TVEFUVVNfQUNUSVZFEAESHgoaQ09OVFJJQlVUSU9OX1NUQVRVU19QQVVTRUQQAhIhCh1DT05UUklCVVRJT05fU1RBVFVTX0NPTVBMRVRFRBADEiEKHUNPTlRSSUJVVElPTl9TVEFUVVNfQ0FOQ0VMTEVEEAQ=');
@$core.Deprecated('Use paymentStatusDescriptor instead')
const PaymentStatus$json = const {
  '1': 'PaymentStatus',
  '2': const [
    const {'1': 'PAYMENT_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'PAYMENT_STATUS_PENDING', '2': 1},
    const {'1': 'PAYMENT_STATUS_PROCESSING', '2': 2},
    const {'1': 'PAYMENT_STATUS_COMPLETED', '2': 3},
    const {'1': 'PAYMENT_STATUS_FAILED', '2': 4},
    const {'1': 'PAYMENT_STATUS_REFUNDED', '2': 5},
    const {'1': 'PAYMENT_STATUS_AWAITING_VERIFICATION', '2': 6},
    const {'1': 'PAYMENT_STATUS_REFUNDING', '2': 7},
    const {'1': 'PAYMENT_STATUS_MANUAL_REVIEW', '2': 8},
  ],
};

/// Descriptor for `PaymentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentStatusDescriptor = $convert.base64Decode('Cg1QYXltZW50U3RhdHVzEh4KGlBBWU1FTlRfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGgoWUEFZTUVOVF9TVEFUVVNfUEVORElORxABEh0KGVBBWU1FTlRfU1RBVFVTX1BST0NFU1NJTkcQAhIcChhQQVlNRU5UX1NUQVRVU19DT01QTEVURUQQAxIZChVQQVlNRU5UX1NUQVRVU19GQUlMRUQQBBIbChdQQVlNRU5UX1NUQVRVU19SRUZVTkRFRBAFEigKJFBBWU1FTlRfU1RBVFVTX0FXQUlUSU5HX1ZFUklGSUNBVElPThAGEhwKGFBBWU1FTlRfU1RBVFVTX1JFRlVORElORxAHEiAKHFBBWU1FTlRfU1RBVFVTX01BTlVBTF9SRVZJRVcQCA==');
@$core.Deprecated('Use payoutStatusDescriptor instead')
const PayoutStatus$json = const {
  '1': 'PayoutStatus',
  '2': const [
    const {'1': 'PAYOUT_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'PAYOUT_STATUS_PENDING', '2': 1},
    const {'1': 'PAYOUT_STATUS_COMPLETED', '2': 2},
    const {'1': 'PAYOUT_STATUS_CANCELLED', '2': 3},
    const {'1': 'PAYOUT_STATUS_PROCESSING', '2': 4},
    const {'1': 'PAYOUT_STATUS_FAILED', '2': 5},
    const {'1': 'PAYOUT_STATUS_MANUAL_REVIEW', '2': 6},
  ],
};

/// Descriptor for `PayoutStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payoutStatusDescriptor = $convert.base64Decode('CgxQYXlvdXRTdGF0dXMSHQoZUEFZT1VUX1NUQVRVU19VTlNQRUNJRklFRBAAEhkKFVBBWU9VVF9TVEFUVVNfUEVORElORxABEhsKF1BBWU9VVF9TVEFUVVNfQ09NUExFVEVEEAISGwoXUEFZT1VUX1NUQVRVU19DQU5DRUxMRUQQAxIcChhQQVlPVVRfU1RBVFVTX1BST0NFU1NJTkcQBBIYChRQQVlPVVRfU1RBVFVTX0ZBSUxFRBAFEh8KG1BBWU9VVF9TVEFUVVNfTUFOVUFMX1JFVklFVxAG');
@$core.Deprecated('Use payoutTransactionStatusDescriptor instead')
const PayoutTransactionStatus$json = const {
  '1': 'PayoutTransactionStatus',
  '2': const [
    const {'1': 'PAYOUT_TRANSACTION_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'PAYOUT_TRANSACTION_STATUS_PENDING', '2': 1},
    const {'1': 'PAYOUT_TRANSACTION_STATUS_PROCESSING', '2': 2},
    const {'1': 'PAYOUT_TRANSACTION_STATUS_COMPLETED', '2': 3},
    const {'1': 'PAYOUT_TRANSACTION_STATUS_FAILED', '2': 4},
    const {'1': 'PAYOUT_TRANSACTION_STATUS_REFUNDED', '2': 5},
  ],
};

/// Descriptor for `PayoutTransactionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payoutTransactionStatusDescriptor = $convert.base64Decode('ChdQYXlvdXRUcmFuc2FjdGlvblN0YXR1cxIpCiVQQVlPVVRfVFJBTlNBQ1RJT05fU1RBVFVTX1VOU1BFQ0lGSUVEEAASJQohUEFZT1VUX1RSQU5TQUNUSU9OX1NUQVRVU19QRU5ESU5HEAESKAokUEFZT1VUX1RSQU5TQUNUSU9OX1NUQVRVU19QUk9DRVNTSU5HEAISJwojUEFZT1VUX1RSQU5TQUNUSU9OX1NUQVRVU19DT01QTEVURUQQAxIkCiBQQVlPVVRfVFJBTlNBQ1RJT05fU1RBVFVTX0ZBSUxFRBAEEiYKIlBBWU9VVF9UUkFOU0FDVElPTl9TVEFUVVNfUkVGVU5ERUQQBQ==');
@$core.Deprecated('Use groupVisibilityDescriptor instead')
const GroupVisibility$json = const {
  '1': 'GroupVisibility',
  '2': const [
    const {'1': 'GROUP_VISIBILITY_UNSPECIFIED', '2': 0},
    const {'1': 'GROUP_VISIBILITY_PRIVATE', '2': 1},
    const {'1': 'GROUP_VISIBILITY_PUBLIC', '2': 2},
  ],
};

/// Descriptor for `GroupVisibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupVisibilityDescriptor = $convert.base64Decode('Cg9Hcm91cFZpc2liaWxpdHkSIAocR1JPVVBfVklTSUJJTElUWV9VTlNQRUNJRklFRBAAEhwKGEdST1VQX1ZJU0lCSUxJVFlfUFJJVkFURRABEhsKF0dST1VQX1ZJU0lCSUxJVFlfUFVCTElDEAI=');
@$core.Deprecated('Use scheduledPayoutStatusDescriptor instead')
const ScheduledPayoutStatus$json = const {
  '1': 'ScheduledPayoutStatus',
  '2': const [
    const {'1': 'SCHEDULED_PAYOUT_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'SCHEDULED_PAYOUT_STATUS_PENDING_RECEIVER', '2': 1},
    const {'1': 'SCHEDULED_PAYOUT_STATUS_READY', '2': 2},
    const {'1': 'SCHEDULED_PAYOUT_STATUS_SCHEDULED', '2': 3},
    const {'1': 'SCHEDULED_PAYOUT_STATUS_IN_FLIGHT', '2': 4},
    const {'1': 'SCHEDULED_PAYOUT_STATUS_SETTLED', '2': 5},
    const {'1': 'SCHEDULED_PAYOUT_STATUS_FAILED', '2': 6},
    const {'1': 'SCHEDULED_PAYOUT_STATUS_EXHAUSTED', '2': 7},
    const {'1': 'SCHEDULED_PAYOUT_STATUS_CANCELED', '2': 8},
  ],
};

/// Descriptor for `ScheduledPayoutStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scheduledPayoutStatusDescriptor = $convert.base64Decode('ChVTY2hlZHVsZWRQYXlvdXRTdGF0dXMSJwojU0NIRURVTEVEX1BBWU9VVF9TVEFUVVNfVU5TUEVDSUZJRUQQABIsCihTQ0hFRFVMRURfUEFZT1VUX1NUQVRVU19QRU5ESU5HX1JFQ0VJVkVSEAESIQodU0NIRURVTEVEX1BBWU9VVF9TVEFUVVNfUkVBRFkQAhIlCiFTQ0hFRFVMRURfUEFZT1VUX1NUQVRVU19TQ0hFRFVMRUQQAxIlCiFTQ0hFRFVMRURfUEFZT1VUX1NUQVRVU19JTl9GTElHSFQQBBIjCh9TQ0hFRFVMRURfUEFZT1VUX1NUQVRVU19TRVRUTEVEEAUSIgoeU0NIRURVTEVEX1BBWU9VVF9TVEFUVVNfRkFJTEVEEAYSJQohU0NIRURVTEVEX1BBWU9VVF9TVEFUVVNfRVhIQVVTVEVEEAcSJAogU0NIRURVTEVEX1BBWU9VVF9TVEFUVVNfQ0FOQ0VMRUQQCA==');
@$core.Deprecated('Use payoutModeDescriptor instead')
const PayoutMode$json = const {
  '1': 'PayoutMode',
  '2': const [
    const {'1': 'PAYOUT_MODE_UNSPECIFIED', '2': 0},
    const {'1': 'PAYOUT_MODE_AUTO', '2': 1},
    const {'1': 'PAYOUT_MODE_MANUAL', '2': 2},
  ],
};

/// Descriptor for `PayoutMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payoutModeDescriptor = $convert.base64Decode('CgpQYXlvdXRNb2RlEhsKF1BBWU9VVF9NT0RFX1VOU1BFQ0lGSUVEEAASFAoQUEFZT1VUX01PREVfQVVUTxABEhYKElBBWU9VVF9NT0RFX01BTlVBTBAC');
@$core.Deprecated('Use groupAccountMessageDescriptor instead')
const GroupAccountMessage$json = const {
  '1': 'GroupAccountMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'admin_id', '3': 4, '4': 1, '5': 9, '10': 'adminId'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.group_accounts.GroupAccountStatus', '10': 'status'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'members', '3': 9, '4': 3, '5': 11, '6': '.group_accounts.GroupMemberMessage', '10': 'members'},
    const {'1': 'contributions', '3': 10, '4': 3, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contributions'},
    const {'1': 'visibility', '3': 11, '4': 1, '5': 14, '6': '.group_accounts.GroupVisibility', '10': 'visibility'},
    const {'1': 'member_count', '3': 12, '4': 1, '5': 5, '10': 'memberCount'},
    const {'1': 'total_raised', '3': 13, '4': 1, '5': 4, '10': 'totalRaised'},
    const {'1': 'image_url', '3': 14, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'contribution_count', '3': 15, '4': 1, '5': 5, '10': 'contributionCount'},
  ],
};

/// Descriptor for `GroupAccountMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupAccountMessageDescriptor = $convert.base64Decode('ChNHcm91cEFjY291bnRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIZCghhZG1pbl9pZBgEIAEoCVIHYWRtaW5JZBI6CgZzdGF0dXMYBSABKA4yIi5ncm91cF9hY2NvdW50cy5Hcm91cEFjY291bnRTdGF0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSGgoIbWV0YWRhdGEYCCABKAlSCG1ldGFkYXRhEjwKB21lbWJlcnMYCSADKAsyIi5ncm91cF9hY2NvdW50cy5Hcm91cE1lbWJlck1lc3NhZ2VSB21lbWJlcnMSSQoNY29udHJpYnV0aW9ucxgKIAMoCzIjLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvbk1lc3NhZ2VSDWNvbnRyaWJ1dGlvbnMSPwoKdmlzaWJpbGl0eRgLIAEoDjIfLmdyb3VwX2FjY291bnRzLkdyb3VwVmlzaWJpbGl0eVIKdmlzaWJpbGl0eRIhCgxtZW1iZXJfY291bnQYDCABKAVSC21lbWJlckNvdW50EiEKDHRvdGFsX3JhaXNlZBgNIAEoBFILdG90YWxSYWlzZWQSGwoJaW1hZ2VfdXJsGA4gASgJUghpbWFnZVVybBItChJjb250cmlidXRpb25fY291bnQYDyABKAVSEWNvbnRyaWJ1dGlvbkNvdW50');
@$core.Deprecated('Use groupMemberMessageDescriptor instead')
const GroupMemberMessage$json = const {
  '1': 'GroupMemberMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_name', '3': 4, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'profile_image', '3': 6, '4': 1, '5': 9, '10': 'profileImage'},
    const {'1': 'role', '3': 7, '4': 1, '5': 14, '6': '.group_accounts.GroupMemberRole', '10': 'role'},
    const {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.group_accounts.GroupMemberStatus', '10': 'status'},
    const {'1': 'joined_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'joinedAt'},
    const {'1': 'permissions', '3': 10, '4': 1, '5': 9, '10': 'permissions'},
    const {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'is_partial', '3': 12, '4': 1, '5': 8, '10': 'isPartial'},
    const {'1': 'user_username', '3': 13, '4': 1, '5': 9, '10': 'userUsername'},
    const {'1': 'email_matches_search_query', '3': 14, '4': 1, '5': 8, '10': 'emailMatchesSearchQuery'},
    const {'1': 'phone_matches_search_query_exact', '3': 15, '4': 1, '5': 8, '10': 'phoneMatchesSearchQueryExact'},
  ],
};

/// Descriptor for `GroupMemberMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupMemberMessageDescriptor = $convert.base64Decode('ChJHcm91cE1lbWJlck1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhkKCGdyb3VwX2lkGAIgASgJUgdncm91cElkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIbCgl1c2VyX25hbWUYBCABKAlSCHVzZXJOYW1lEhQKBWVtYWlsGAUgASgJUgVlbWFpbBIjCg1wcm9maWxlX2ltYWdlGAYgASgJUgxwcm9maWxlSW1hZ2USMwoEcm9sZRgHIAEoDjIfLmdyb3VwX2FjY291bnRzLkdyb3VwTWVtYmVyUm9sZVIEcm9sZRI5CgZzdGF0dXMYCCABKA4yIS5ncm91cF9hY2NvdW50cy5Hcm91cE1lbWJlclN0YXR1c1IGc3RhdHVzEjcKCWpvaW5lZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGpvaW5lZEF0EiAKC3Blcm1pc3Npb25zGAogASgJUgtwZXJtaXNzaW9ucxIhCgxwaG9uZV9udW1iZXIYCyABKAlSC3Bob25lTnVtYmVyEh0KCmlzX3BhcnRpYWwYDCABKAhSCWlzUGFydGlhbBIjCg11c2VyX3VzZXJuYW1lGA0gASgJUgx1c2VyVXNlcm5hbWUSOwoaZW1haWxfbWF0Y2hlc19zZWFyY2hfcXVlcnkYDiABKAhSF2VtYWlsTWF0Y2hlc1NlYXJjaFF1ZXJ5EkYKIHBob25lX21hdGNoZXNfc2VhcmNoX3F1ZXJ5X2V4YWN0GA8gASgIUhxwaG9uZU1hdGNoZXNTZWFyY2hRdWVyeUV4YWN0');
@$core.Deprecated('Use contributionMessageDescriptor instead')
const ContributionMessage$json = const {
  '1': 'ContributionMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'target_amount', '3': 5, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'current_amount', '3': 6, '4': 1, '5': 4, '10': 'currentAmount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'deadline', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    const {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.group_accounts.ContributionStatus', '10': 'status'},
    const {'1': 'created_by', '3': 10, '4': 1, '5': 9, '10': 'createdBy'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'type', '3': 14, '4': 1, '5': 14, '6': '.group_accounts.ContributionType', '10': 'type'},
    const {'1': 'frequency', '3': 15, '4': 1, '5': 14, '6': '.group_accounts.ContributionFrequency', '10': 'frequency'},
    const {'1': 'regular_amount', '3': 16, '4': 1, '5': 4, '10': 'regularAmount'},
    const {'1': 'next_payment_date', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPaymentDate'},
    const {'1': 'start_date', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'total_cycles', '3': 19, '4': 1, '5': 5, '10': 'totalCycles'},
    const {'1': 'current_cycle', '3': 20, '4': 1, '5': 5, '10': 'currentCycle'},
    const {'1': 'current_payout_recipient', '3': 21, '4': 1, '5': 9, '10': 'currentPayoutRecipient'},
    const {'1': 'next_payout_date', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPayoutDate'},
    const {'1': 'auto_pay_enabled', '3': 23, '4': 1, '5': 8, '10': 'autoPayEnabled'},
    const {'1': 'penalty_amount', '3': 24, '4': 1, '5': 4, '10': 'penaltyAmount'},
    const {'1': 'grace_period_days', '3': 25, '4': 1, '5': 5, '10': 'gracePeriodDays'},
    const {'1': 'allow_partial_payments', '3': 26, '4': 1, '5': 8, '10': 'allowPartialPayments'},
    const {'1': 'minimum_balance', '3': 27, '4': 1, '5': 4, '10': 'minimumBalance'},
    const {'1': 'payments', '3': 28, '4': 3, '5': 11, '6': '.group_accounts.ContributionPaymentMessage', '10': 'payments'},
    const {'1': 'payout_schedule', '3': 29, '4': 3, '5': 11, '6': '.group_accounts.PayoutScheduleMessage', '10': 'payoutSchedule'},
    const {'1': 'payout_history', '3': 30, '4': 3, '5': 11, '6': '.group_accounts.PayoutTransactionMessage', '10': 'payoutHistory'},
    const {'1': 'members', '3': 31, '4': 3, '5': 11, '6': '.group_accounts.ContributionMemberMessage', '10': 'members'},
    const {'1': 'auto_payout_enabled', '3': 32, '4': 1, '5': 8, '10': 'autoPayoutEnabled'},
  ],
};

/// Descriptor for `ContributionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionMessageDescriptor = $convert.base64Decode('ChNDb250cmlidXRpb25NZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIZCghncm91cF9pZBgCIAEoCVIHZ3JvdXBJZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEiMKDXRhcmdldF9hbW91bnQYBSABKARSDHRhcmdldEFtb3VudBIlCg5jdXJyZW50X2Ftb3VudBgGIAEoBFINY3VycmVudEFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSNgoIZGVhZGxpbmUYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRI6CgZzdGF0dXMYCSABKA4yIi5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25TdGF0dXNSBnN0YXR1cxIdCgpjcmVhdGVkX2J5GAogASgJUgljcmVhdGVkQnkSOQoKY3JlYXRlZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0EhoKCG1ldGFkYXRhGA0gASgJUghtZXRhZGF0YRI0CgR0eXBlGA4gASgOMiAuZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uVHlwZVIEdHlwZRJDCglmcmVxdWVuY3kYDyABKA4yJS5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25GcmVxdWVuY3lSCWZyZXF1ZW5jeRIlCg5yZWd1bGFyX2Ftb3VudBgQIAEoBFINcmVndWxhckFtb3VudBJGChFuZXh0X3BheW1lbnRfZGF0ZRgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD25leHRQYXltZW50RGF0ZRI5CgpzdGFydF9kYXRlGBIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEiEKDHRvdGFsX2N5Y2xlcxgTIAEoBVILdG90YWxDeWNsZXMSIwoNY3VycmVudF9jeWNsZRgUIAEoBVIMY3VycmVudEN5Y2xlEjgKGGN1cnJlbnRfcGF5b3V0X3JlY2lwaWVudBgVIAEoCVIWY3VycmVudFBheW91dFJlY2lwaWVudBJEChBuZXh0X3BheW91dF9kYXRlGBYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIObmV4dFBheW91dERhdGUSKAoQYXV0b19wYXlfZW5hYmxlZBgXIAEoCFIOYXV0b1BheUVuYWJsZWQSJQoOcGVuYWx0eV9hbW91bnQYGCABKARSDXBlbmFsdHlBbW91bnQSKgoRZ3JhY2VfcGVyaW9kX2RheXMYGSABKAVSD2dyYWNlUGVyaW9kRGF5cxI0ChZhbGxvd19wYXJ0aWFsX3BheW1lbnRzGBogASgIUhRhbGxvd1BhcnRpYWxQYXltZW50cxInCg9taW5pbXVtX2JhbGFuY2UYGyABKARSDm1pbmltdW1CYWxhbmNlEkYKCHBheW1lbnRzGBwgAygLMiouZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSCHBheW1lbnRzEk4KD3BheW91dF9zY2hlZHVsZRgdIAMoCzIlLmdyb3VwX2FjY291bnRzLlBheW91dFNjaGVkdWxlTWVzc2FnZVIOcGF5b3V0U2NoZWR1bGUSTwoOcGF5b3V0X2hpc3RvcnkYHiADKAsyKC5ncm91cF9hY2NvdW50cy5QYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2VSDXBheW91dEhpc3RvcnkSQwoHbWVtYmVycxgfIAMoCzIpLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvbk1lbWJlck1lc3NhZ2VSB21lbWJlcnMSLgoTYXV0b19wYXlvdXRfZW5hYmxlZBggIAEoCFIRYXV0b1BheW91dEVuYWJsZWQ=');
@$core.Deprecated('Use contributionMemberMessageDescriptor instead')
const ContributionMemberMessage$json = const {
  '1': 'ContributionMemberMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_name', '3': 4, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'profile_image', '3': 6, '4': 1, '5': 9, '10': 'profileImage'},
    const {'1': 'joined_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'joinedAt'},
    const {'1': 'total_paid', '3': 8, '4': 1, '5': 4, '10': 'totalPaid'},
    const {'1': 'expected_amount', '3': 9, '4': 1, '5': 4, '10': 'expectedAmount'},
    const {'1': 'has_paid_current_cycle', '3': 10, '4': 1, '5': 8, '10': 'hasPaidCurrentCycle'},
    const {'1': 'cycle_paid_amount', '3': 11, '4': 1, '5': 4, '10': 'cyclePaidAmount'},
    const {'1': 'missed_cycles', '3': 12, '4': 1, '5': 13, '10': 'missedCycles'},
    const {'1': 'membership_status', '3': 13, '4': 1, '5': 9, '10': 'membershipStatus'},
    const {'1': 'linked_invitation_id', '3': 14, '4': 1, '5': 9, '10': 'linkedInvitationId'},
  ],
};

/// Descriptor for `ContributionMemberMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionMemberMessageDescriptor = $convert.base64Decode('ChlDb250cmlidXRpb25NZW1iZXJNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBInCg9jb250cmlidXRpb25faWQYAiABKAlSDmNvbnRyaWJ1dGlvbklkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIbCgl1c2VyX25hbWUYBCABKAlSCHVzZXJOYW1lEhQKBWVtYWlsGAUgASgJUgVlbWFpbBIjCg1wcm9maWxlX2ltYWdlGAYgASgJUgxwcm9maWxlSW1hZ2USNwoJam9pbmVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIam9pbmVkQXQSHQoKdG90YWxfcGFpZBgIIAEoBFIJdG90YWxQYWlkEicKD2V4cGVjdGVkX2Ftb3VudBgJIAEoBFIOZXhwZWN0ZWRBbW91bnQSMwoWaGFzX3BhaWRfY3VycmVudF9jeWNsZRgKIAEoCFITaGFzUGFpZEN1cnJlbnRDeWNsZRIqChFjeWNsZV9wYWlkX2Ftb3VudBgLIAEoBFIPY3ljbGVQYWlkQW1vdW50EiMKDW1pc3NlZF9jeWNsZXMYDCABKA1SDG1pc3NlZEN5Y2xlcxIrChFtZW1iZXJzaGlwX3N0YXR1cxgNIAEoCVIQbWVtYmVyc2hpcFN0YXR1cxIwChRsaW5rZWRfaW52aXRhdGlvbl9pZBgOIAEoCVISbGlua2VkSW52aXRhdGlvbklk');
@$core.Deprecated('Use contributionPaymentMessageDescriptor instead')
const ContributionPaymentMessage$json = const {
  '1': 'ContributionPaymentMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_name', '3': 5, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paymentDate'},
    const {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.group_accounts.PaymentStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'receipt_id', '3': 11, '4': 1, '5': 9, '10': 'receiptId'},
    const {'1': 'notes', '3': 12, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ContributionPaymentMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionPaymentMessageDescriptor = $convert.base64Decode('ChpDb250cmlidXRpb25QYXltZW50TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSJwoPY29udHJpYnV0aW9uX2lkGAIgASgJUg5jb250cmlidXRpb25JZBIZCghncm91cF9pZBgDIAEoCVIHZ3JvdXBJZBIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQSGwoJdXNlcl9uYW1lGAUgASgJUgh1c2VyTmFtZRIWCgZhbW91bnQYBiABKARSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSPQoMcGF5bWVudF9kYXRlGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcGF5bWVudERhdGUSNQoGc3RhdHVzGAkgASgOMh0uZ3JvdXBfYWNjb3VudHMuUGF5bWVudFN0YXR1c1IGc3RhdHVzEiUKDnRyYW5zYWN0aW9uX2lkGAogASgJUg10cmFuc2FjdGlvbklkEh0KCnJlY2VpcHRfaWQYCyABKAlSCXJlY2VpcHRJZBIUCgVub3RlcxgMIAEoCVIFbm90ZXMSGgoIbWV0YWRhdGEYDSABKAlSCG1ldGFkYXRh');
@$core.Deprecated('Use payoutScheduleMessageDescriptor instead')
const PayoutScheduleMessage$json = const {
  '1': 'PayoutScheduleMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_name', '3': 3, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'position', '3': 4, '4': 1, '5': 5, '10': 'position'},
    const {'1': 'scheduled_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledDate'},
    const {'1': 'expected_amount', '3': 6, '4': 1, '5': 4, '10': 'expectedAmount'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.group_accounts.PayoutStatus', '10': 'status'},
    const {'1': 'received_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'receivedDate'},
    const {'1': 'actual_amount', '3': 9, '4': 1, '5': 4, '10': 'actualAmount'},
    const {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'contribution_id', '3': 11, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 12, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'attempts', '3': 13, '4': 1, '5': 5, '10': 'attempts'},
    const {'1': 'last_attempt_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastAttemptAt'},
    const {'1': 'next_attempt_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextAttemptAt'},
    const {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'version', '3': 17, '4': 1, '5': 3, '10': 'version'},
    const {'1': 'payout_transaction_id', '3': 18, '4': 1, '5': 9, '10': 'payoutTransactionId'},
  ],
};

/// Descriptor for `PayoutScheduleMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutScheduleMessageDescriptor = $convert.base64Decode('ChVQYXlvdXRTY2hlZHVsZU1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIbCgl1c2VyX25hbWUYAyABKAlSCHVzZXJOYW1lEhoKCHBvc2l0aW9uGAQgASgFUghwb3NpdGlvbhJBCg5zY2hlZHVsZWRfZGF0ZRgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDXNjaGVkdWxlZERhdGUSJwoPZXhwZWN0ZWRfYW1vdW50GAYgASgEUg5leHBlY3RlZEFtb3VudBI0CgZzdGF0dXMYByABKA4yHC5ncm91cF9hY2NvdW50cy5QYXlvdXRTdGF0dXNSBnN0YXR1cxI/Cg1yZWNlaXZlZF9kYXRlGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVjZWl2ZWREYXRlEiMKDWFjdHVhbF9hbW91bnQYCSABKARSDGFjdHVhbEFtb3VudBIUCgVub3RlcxgKIAEoCVIFbm90ZXMSJwoPY29udHJpYnV0aW9uX2lkGAsgASgJUg5jb250cmlidXRpb25JZBIZCghncm91cF9pZBgMIAEoCVIHZ3JvdXBJZBIaCghhdHRlbXB0cxgNIAEoBVIIYXR0ZW1wdHMSQgoPbGFzdF9hdHRlbXB0X2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFINbGFzdEF0dGVtcHRBdBJCCg9uZXh0X2F0dGVtcHRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg1uZXh0QXR0ZW1wdEF0EiUKDmZhaWx1cmVfcmVhc29uGBAgASgJUg1mYWlsdXJlUmVhc29uEhgKB3ZlcnNpb24YESABKANSB3ZlcnNpb24SMgoVcGF5b3V0X3RyYW5zYWN0aW9uX2lkGBIgASgJUhNwYXlvdXRUcmFuc2FjdGlvbklk');
@$core.Deprecated('Use payoutTransactionMessageDescriptor instead')
const PayoutTransactionMessage$json = const {
  '1': 'PayoutTransactionMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'recipient_user_id', '3': 4, '4': 1, '5': 9, '10': 'recipientUserId'},
    const {'1': 'recipient_user_name', '3': 5, '4': 1, '5': 9, '10': 'recipientUserName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payout_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'payoutDate'},
    const {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.group_accounts.PayoutTransactionStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'payment_method', '3': 11, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'failure_reason', '3': 12, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `PayoutTransactionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutTransactionMessageDescriptor = $convert.base64Decode('ChhQYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2USDgoCaWQYASABKAlSAmlkEicKD2NvbnRyaWJ1dGlvbl9pZBgCIAEoCVIOY29udHJpYnV0aW9uSWQSGQoIZ3JvdXBfaWQYAyABKAlSB2dyb3VwSWQSKgoRcmVjaXBpZW50X3VzZXJfaWQYBCABKAlSD3JlY2lwaWVudFVzZXJJZBIuChNyZWNpcGllbnRfdXNlcl9uYW1lGAUgASgJUhFyZWNpcGllbnRVc2VyTmFtZRIWCgZhbW91bnQYBiABKARSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSOwoLcGF5b3V0X2RhdGUYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpwYXlvdXREYXRlEj8KBnN0YXR1cxgJIAEoDjInLmdyb3VwX2FjY291bnRzLlBheW91dFRyYW5zYWN0aW9uU3RhdHVzUgZzdGF0dXMSJQoOdHJhbnNhY3Rpb25faWQYCiABKAlSDXRyYW5zYWN0aW9uSWQSJQoOcGF5bWVudF9tZXRob2QYCyABKAlSDXBheW1lbnRNZXRob2QSJQoOZmFpbHVyZV9yZWFzb24YDCABKAlSDWZhaWx1cmVSZWFzb24SGgoIbWV0YWRhdGEYDSABKAlSCG1ldGFkYXRh');
@$core.Deprecated('Use contributionReceiptMessageDescriptor instead')
const ContributionReceiptMessage$json = const {
  '1': 'ContributionReceiptMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'payment_id', '3': 2, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'contribution_id', '3': 3, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 4, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_name', '3': 6, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paymentDate'},
    const {'1': 'generated_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
    const {'1': 'receipt_number', '3': 11, '4': 1, '5': 9, '10': 'receiptNumber'},
    const {'1': 'receipt_data', '3': 12, '4': 1, '5': 9, '10': 'receiptData'},
  ],
};

/// Descriptor for `ContributionReceiptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionReceiptMessageDescriptor = $convert.base64Decode('ChpDb250cmlidXRpb25SZWNlaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHQoKcGF5bWVudF9pZBgCIAEoCVIJcGF5bWVudElkEicKD2NvbnRyaWJ1dGlvbl9pZBgDIAEoCVIOY29udHJpYnV0aW9uSWQSGQoIZ3JvdXBfaWQYBCABKAlSB2dyb3VwSWQSFwoHdXNlcl9pZBgFIAEoCVIGdXNlcklkEhsKCXVzZXJfbmFtZRgGIAEoCVIIdXNlck5hbWUSFgoGYW1vdW50GAcgASgEUgZhbW91bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5Ej0KDHBheW1lbnRfZGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3BheW1lbnREYXRlEj0KDGdlbmVyYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2dlbmVyYXRlZEF0EiUKDnJlY2VpcHRfbnVtYmVyGAsgASgJUg1yZWNlaXB0TnVtYmVyEiEKDHJlY2VpcHRfZGF0YRgMIAEoCVILcmVjZWlwdERhdGE=');
@$core.Deprecated('Use contributionTranscriptMessageDescriptor instead')
const ContributionTranscriptMessage$json = const {
  '1': 'ContributionTranscriptMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'generated_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
    const {'1': 'payments', '3': 5, '4': 3, '5': 11, '6': '.group_accounts.ContributionPaymentMessage', '10': 'payments'},
    const {'1': 'total_amount', '3': 6, '4': 1, '5': 4, '10': 'totalAmount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'member_contributions', '3': 8, '4': 1, '5': 9, '10': 'memberContributions'},
  ],
};

/// Descriptor for `ContributionTranscriptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionTranscriptMessageDescriptor = $convert.base64Decode('Ch1Db250cmlidXRpb25UcmFuc2NyaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSJwoPY29udHJpYnV0aW9uX2lkGAIgASgJUg5jb250cmlidXRpb25JZBIZCghncm91cF9pZBgDIAEoCVIHZ3JvdXBJZBI9CgxnZW5lcmF0ZWRfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtnZW5lcmF0ZWRBdBJGCghwYXltZW50cxgFIAMoCzIqLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvblBheW1lbnRNZXNzYWdlUghwYXltZW50cxIhCgx0b3RhbF9hbW91bnQYBiABKARSC3RvdGFsQW1vdW50EhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIxChRtZW1iZXJfY29udHJpYnV0aW9ucxgIIAEoCVITbWVtYmVyQ29udHJpYnV0aW9ucw==');
@$core.Deprecated('Use payoutReceiverMessageDescriptor instead')
const PayoutReceiverMessage$json = const {
  '1': 'PayoutReceiverMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 3, '4': 1, '5': 5, '10': 'cycleIndex'},
    const {'1': 'recipient_user_id', '3': 4, '4': 1, '5': 9, '10': 'recipientUserId'},
    const {'1': 'recipient_account_id', '3': 5, '4': 1, '5': 9, '10': 'recipientAccountId'},
    const {'1': 'recipient_name', '3': 6, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'recipient_username', '3': 7, '4': 1, '5': 9, '10': 'recipientUsername'},
    const {'1': 'assigned_by_user_id', '3': 8, '4': 1, '5': 9, '10': 'assignedByUserId'},
    const {'1': 'assigned_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'assignedAt'},
    const {'1': 'cleared_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'clearedAt'},
    const {'1': 'note', '3': 11, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `PayoutReceiverMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutReceiverMessageDescriptor = $convert.base64Decode('ChVQYXlvdXRSZWNlaXZlck1lc3NhZ2USDgoCaWQYASABKAlSAmlkEicKD2NvbnRyaWJ1dGlvbl9pZBgCIAEoCVIOY29udHJpYnV0aW9uSWQSHwoLY3ljbGVfaW5kZXgYAyABKAVSCmN5Y2xlSW5kZXgSKgoRcmVjaXBpZW50X3VzZXJfaWQYBCABKAlSD3JlY2lwaWVudFVzZXJJZBIwChRyZWNpcGllbnRfYWNjb3VudF9pZBgFIAEoCVIScmVjaXBpZW50QWNjb3VudElkEiUKDnJlY2lwaWVudF9uYW1lGAYgASgJUg1yZWNpcGllbnROYW1lEi0KEnJlY2lwaWVudF91c2VybmFtZRgHIAEoCVIRcmVjaXBpZW50VXNlcm5hbWUSLQoTYXNzaWduZWRfYnlfdXNlcl9pZBgIIAEoCVIQYXNzaWduZWRCeVVzZXJJZBI7Cgthc3NpZ25lZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmFzc2lnbmVkQXQSOQoKY2xlYXJlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNsZWFyZWRBdBISCgRub3RlGAsgASgJUgRub3Rl');
@$core.Deprecated('Use scheduledPayoutMessageDescriptor instead')
const ScheduledPayoutMessage$json = const {
  '1': 'ScheduledPayoutMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 3, '4': 1, '5': 5, '10': 'cycleIndex'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.group_accounts.ScheduledPayoutStatus', '10': 'status'},
    const {'1': 'scheduled_for', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledFor'},
    const {'1': 'payout_mode', '3': 6, '4': 1, '5': 14, '6': '.group_accounts.PayoutMode', '10': 'payoutMode'},
    const {'1': 'contribution_type', '3': 7, '4': 1, '5': 9, '10': 'contributionType'},
    const {'1': 'amount_minor', '3': 8, '4': 1, '5': 4, '10': 'amountMinor'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'recipient_user_id', '3': 10, '4': 1, '5': 9, '10': 'recipientUserId'},
    const {'1': 'recipient_account_id', '3': 11, '4': 1, '5': 9, '10': 'recipientAccountId'},
    const {'1': 'recipient_name', '3': 12, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'idempotency_key', '3': 13, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'attempts', '3': 14, '4': 1, '5': 5, '10': 'attempts'},
    const {'1': 'last_attempted_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastAttemptedAt'},
    const {'1': 'last_error', '3': 16, '4': 1, '5': 9, '10': 'lastError'},
    const {'1': 'fired_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'firedAt'},
    const {'1': 'settled_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'settledAt'},
    const {'1': 'payout_transaction_id', '3': 19, '4': 1, '5': 9, '10': 'payoutTransactionId'},
    const {'1': 'version', '3': 20, '4': 1, '5': 3, '10': 'version'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `ScheduledPayoutMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduledPayoutMessageDescriptor = $convert.base64Decode('ChZTY2hlZHVsZWRQYXlvdXRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBInCg9jb250cmlidXRpb25faWQYAiABKAlSDmNvbnRyaWJ1dGlvbklkEh8KC2N5Y2xlX2luZGV4GAMgASgFUgpjeWNsZUluZGV4Ej0KBnN0YXR1cxgEIAEoDjIlLmdyb3VwX2FjY291bnRzLlNjaGVkdWxlZFBheW91dFN0YXR1c1IGc3RhdHVzEj8KDXNjaGVkdWxlZF9mb3IYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxzY2hlZHVsZWRGb3ISOwoLcGF5b3V0X21vZGUYBiABKA4yGi5ncm91cF9hY2NvdW50cy5QYXlvdXRNb2RlUgpwYXlvdXRNb2RlEisKEWNvbnRyaWJ1dGlvbl90eXBlGAcgASgJUhBjb250cmlidXRpb25UeXBlEiEKDGFtb3VudF9taW5vchgIIAEoBFILYW1vdW50TWlub3ISGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EioKEXJlY2lwaWVudF91c2VyX2lkGAogASgJUg9yZWNpcGllbnRVc2VySWQSMAoUcmVjaXBpZW50X2FjY291bnRfaWQYCyABKAlSEnJlY2lwaWVudEFjY291bnRJZBIlCg5yZWNpcGllbnRfbmFtZRgMIAEoCVINcmVjaXBpZW50TmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYDSABKAlSDmlkZW1wb3RlbmN5S2V5EhoKCGF0dGVtcHRzGA4gASgFUghhdHRlbXB0cxJGChFsYXN0X2F0dGVtcHRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD2xhc3RBdHRlbXB0ZWRBdBIdCgpsYXN0X2Vycm9yGBAgASgJUglsYXN0RXJyb3ISNQoIZmlyZWRfYXQYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdmaXJlZEF0EjkKCnNldHRsZWRfYXQYEiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzZXR0bGVkQXQSMgoVcGF5b3V0X3RyYW5zYWN0aW9uX2lkGBMgASgJUhNwYXlvdXRUcmFuc2FjdGlvbklkEhgKB3ZlcnNpb24YFCABKANSB3ZlcnNpb24SOQoKY3JlYXRlZF9hdBgVIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use payoutEventMessageDescriptor instead')
const PayoutEventMessage$json = const {
  '1': 'PayoutEventMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'payout_id', '3': 2, '4': 1, '5': 9, '10': 'payoutId'},
    const {'1': 'contribution_id', '3': 3, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 4, '4': 1, '5': 5, '10': 'cycleIndex'},
    const {'1': 'event_type', '3': 5, '4': 1, '5': 9, '10': 'eventType'},
    const {'1': 'payload', '3': 6, '4': 1, '5': 9, '10': 'payload'},
    const {'1': 'actor_user_id', '3': 7, '4': 1, '5': 9, '10': 'actorUserId'},
    const {'1': 'occurred_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'occurredAt'},
  ],
};

/// Descriptor for `PayoutEventMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutEventMessageDescriptor = $convert.base64Decode('ChJQYXlvdXRFdmVudE1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhsKCXBheW91dF9pZBgCIAEoCVIIcGF5b3V0SWQSJwoPY29udHJpYnV0aW9uX2lkGAMgASgJUg5jb250cmlidXRpb25JZBIfCgtjeWNsZV9pbmRleBgEIAEoBVIKY3ljbGVJbmRleBIdCgpldmVudF90eXBlGAUgASgJUglldmVudFR5cGUSGAoHcGF5bG9hZBgGIAEoCVIHcGF5bG9hZBIiCg1hY3Rvcl91c2VyX2lkGAcgASgJUgthY3RvclVzZXJJZBI7CgtvY2N1cnJlZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCm9jY3VycmVkQXQ=');
@$core.Deprecated('Use setPayoutReceiverRequestDescriptor instead')
const SetPayoutReceiverRequest$json = const {
  '1': 'SetPayoutReceiverRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 2, '4': 1, '5': 5, '10': 'cycleIndex'},
    const {'1': 'recipient_user_id', '3': 3, '4': 1, '5': 9, '10': 'recipientUserId'},
    const {'1': 'recipient_account_id', '3': 4, '4': 1, '5': 9, '10': 'recipientAccountId'},
    const {'1': 'note', '3': 5, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `SetPayoutReceiverRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPayoutReceiverRequestDescriptor = $convert.base64Decode('ChhTZXRQYXlvdXRSZWNlaXZlclJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZBIfCgtjeWNsZV9pbmRleBgCIAEoBVIKY3ljbGVJbmRleBIqChFyZWNpcGllbnRfdXNlcl9pZBgDIAEoCVIPcmVjaXBpZW50VXNlcklkEjAKFHJlY2lwaWVudF9hY2NvdW50X2lkGAQgASgJUhJyZWNpcGllbnRBY2NvdW50SWQSEgoEbm90ZRgFIAEoCVIEbm90ZQ==');
@$core.Deprecated('Use setPayoutReceiverResponseDescriptor instead')
const SetPayoutReceiverResponse$json = const {
  '1': 'SetPayoutReceiverResponse',
  '2': const [
    const {'1': 'receiver', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.PayoutReceiverMessage', '10': 'receiver'},
    const {'1': 'scheduled_payout', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.ScheduledPayoutMessage', '10': 'scheduledPayout'},
  ],
};

/// Descriptor for `SetPayoutReceiverResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPayoutReceiverResponseDescriptor = $convert.base64Decode('ChlTZXRQYXlvdXRSZWNlaXZlclJlc3BvbnNlEkEKCHJlY2VpdmVyGAEgASgLMiUuZ3JvdXBfYWNjb3VudHMuUGF5b3V0UmVjZWl2ZXJNZXNzYWdlUghyZWNlaXZlchJRChBzY2hlZHVsZWRfcGF5b3V0GAIgASgLMiYuZ3JvdXBfYWNjb3VudHMuU2NoZWR1bGVkUGF5b3V0TWVzc2FnZVIPc2NoZWR1bGVkUGF5b3V0');
@$core.Deprecated('Use getPayoutReceiverRequestDescriptor instead')
const GetPayoutReceiverRequest$json = const {
  '1': 'GetPayoutReceiverRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 2, '4': 1, '5': 5, '10': 'cycleIndex'},
  ],
};

/// Descriptor for `GetPayoutReceiverRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutReceiverRequestDescriptor = $convert.base64Decode('ChhHZXRQYXlvdXRSZWNlaXZlclJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZBIfCgtjeWNsZV9pbmRleBgCIAEoBVIKY3ljbGVJbmRleA==');
@$core.Deprecated('Use getPayoutReceiverResponseDescriptor instead')
const GetPayoutReceiverResponse$json = const {
  '1': 'GetPayoutReceiverResponse',
  '2': const [
    const {'1': 'receiver', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.PayoutReceiverMessage', '10': 'receiver'},
    const {'1': 'scheduled_payout', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.ScheduledPayoutMessage', '10': 'scheduledPayout'},
  ],
};

/// Descriptor for `GetPayoutReceiverResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutReceiverResponseDescriptor = $convert.base64Decode('ChlHZXRQYXlvdXRSZWNlaXZlclJlc3BvbnNlEkEKCHJlY2VpdmVyGAEgASgLMiUuZ3JvdXBfYWNjb3VudHMuUGF5b3V0UmVjZWl2ZXJNZXNzYWdlUghyZWNlaXZlchJRChBzY2hlZHVsZWRfcGF5b3V0GAIgASgLMiYuZ3JvdXBfYWNjb3VudHMuU2NoZWR1bGVkUGF5b3V0TWVzc2FnZVIPc2NoZWR1bGVkUGF5b3V0');
@$core.Deprecated('Use clearPayoutReceiverRequestDescriptor instead')
const ClearPayoutReceiverRequest$json = const {
  '1': 'ClearPayoutReceiverRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 2, '4': 1, '5': 5, '10': 'cycleIndex'},
  ],
};

/// Descriptor for `ClearPayoutReceiverRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearPayoutReceiverRequestDescriptor = $convert.base64Decode('ChpDbGVhclBheW91dFJlY2VpdmVyUmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklkEh8KC2N5Y2xlX2luZGV4GAIgASgFUgpjeWNsZUluZGV4');
@$core.Deprecated('Use clearPayoutReceiverResponseDescriptor instead')
const ClearPayoutReceiverResponse$json = const {
  '1': 'ClearPayoutReceiverResponse',
  '2': const [
    const {'1': 'cleared', '3': 1, '4': 1, '5': 8, '10': 'cleared'},
    const {'1': 'scheduled_payout', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.ScheduledPayoutMessage', '10': 'scheduledPayout'},
  ],
};

/// Descriptor for `ClearPayoutReceiverResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearPayoutReceiverResponseDescriptor = $convert.base64Decode('ChtDbGVhclBheW91dFJlY2VpdmVyUmVzcG9uc2USGAoHY2xlYXJlZBgBIAEoCFIHY2xlYXJlZBJRChBzY2hlZHVsZWRfcGF5b3V0GAIgASgLMiYuZ3JvdXBfYWNjb3VudHMuU2NoZWR1bGVkUGF5b3V0TWVzc2FnZVIPc2NoZWR1bGVkUGF5b3V0');
@$core.Deprecated('Use triggerManualPayoutRequestDescriptor instead')
const TriggerManualPayoutRequest$json = const {
  '1': 'TriggerManualPayoutRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 2, '4': 1, '5': 5, '10': 'cycleIndex'},
  ],
};

/// Descriptor for `TriggerManualPayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerManualPayoutRequestDescriptor = $convert.base64Decode('ChpUcmlnZ2VyTWFudWFsUGF5b3V0UmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklkEh8KC2N5Y2xlX2luZGV4GAIgASgFUgpjeWNsZUluZGV4');
@$core.Deprecated('Use triggerManualPayoutResponseDescriptor instead')
const TriggerManualPayoutResponse$json = const {
  '1': 'TriggerManualPayoutResponse',
  '2': const [
    const {'1': 'scheduled_payout', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ScheduledPayoutMessage', '10': 'scheduledPayout'},
  ],
};

/// Descriptor for `TriggerManualPayoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerManualPayoutResponseDescriptor = $convert.base64Decode('ChtUcmlnZ2VyTWFudWFsUGF5b3V0UmVzcG9uc2USUQoQc2NoZWR1bGVkX3BheW91dBgBIAEoCzImLmdyb3VwX2FjY291bnRzLlNjaGVkdWxlZFBheW91dE1lc3NhZ2VSD3NjaGVkdWxlZFBheW91dA==');
@$core.Deprecated('Use listScheduledPayoutsRequestDescriptor instead')
const ListScheduledPayoutsRequest$json = const {
  '1': 'ListScheduledPayoutsRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'statuses', '3': 3, '4': 3, '5': 14, '6': '.group_accounts.ScheduledPayoutStatus', '10': 'statuses'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 5, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `ListScheduledPayoutsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listScheduledPayoutsRequestDescriptor = $convert.base64Decode('ChtMaXN0U2NoZWR1bGVkUGF5b3V0c1JlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZBIZCghncm91cF9pZBgCIAEoCVIHZ3JvdXBJZBJBCghzdGF0dXNlcxgDIAMoDjIlLmdyb3VwX2FjY291bnRzLlNjaGVkdWxlZFBheW91dFN0YXR1c1IIc3RhdHVzZXMSFAoFbGltaXQYBCABKAVSBWxpbWl0EhYKBm9mZnNldBgFIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use listScheduledPayoutsResponseDescriptor instead')
const ListScheduledPayoutsResponse$json = const {
  '1': 'ListScheduledPayoutsResponse',
  '2': const [
    const {'1': 'payouts', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.ScheduledPayoutMessage', '10': 'payouts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListScheduledPayoutsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listScheduledPayoutsResponseDescriptor = $convert.base64Decode('ChxMaXN0U2NoZWR1bGVkUGF5b3V0c1Jlc3BvbnNlEkAKB3BheW91dHMYASADKAsyJi5ncm91cF9hY2NvdW50cy5TY2hlZHVsZWRQYXlvdXRNZXNzYWdlUgdwYXlvdXRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use getScheduledPayoutRequestDescriptor instead')
const GetScheduledPayoutRequest$json = const {
  '1': 'GetScheduledPayoutRequest',
  '2': const [
    const {'1': 'payout_id', '3': 1, '4': 1, '5': 9, '10': 'payoutId'},
  ],
};

/// Descriptor for `GetScheduledPayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getScheduledPayoutRequestDescriptor = $convert.base64Decode('ChlHZXRTY2hlZHVsZWRQYXlvdXRSZXF1ZXN0EhsKCXBheW91dF9pZBgBIAEoCVIIcGF5b3V0SWQ=');
@$core.Deprecated('Use getScheduledPayoutResponseDescriptor instead')
const GetScheduledPayoutResponse$json = const {
  '1': 'GetScheduledPayoutResponse',
  '2': const [
    const {'1': 'payout', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ScheduledPayoutMessage', '10': 'payout'},
    const {'1': 'receiver', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.PayoutReceiverMessage', '10': 'receiver'},
    const {'1': 'events', '3': 3, '4': 3, '5': 11, '6': '.group_accounts.PayoutEventMessage', '10': 'events'},
  ],
};

/// Descriptor for `GetScheduledPayoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getScheduledPayoutResponseDescriptor = $convert.base64Decode('ChpHZXRTY2hlZHVsZWRQYXlvdXRSZXNwb25zZRI+CgZwYXlvdXQYASABKAsyJi5ncm91cF9hY2NvdW50cy5TY2hlZHVsZWRQYXlvdXRNZXNzYWdlUgZwYXlvdXQSQQoIcmVjZWl2ZXIYAiABKAsyJS5ncm91cF9hY2NvdW50cy5QYXlvdXRSZWNlaXZlck1lc3NhZ2VSCHJlY2VpdmVyEjoKBmV2ZW50cxgDIAMoCzIiLmdyb3VwX2FjY291bnRzLlBheW91dEV2ZW50TWVzc2FnZVIGZXZlbnRz');
@$core.Deprecated('Use createGroupRequestDescriptor instead')
const CreateGroupRequest$json = const {
  '1': 'CreateGroupRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 3, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'visibility', '3': 4, '4': 1, '5': 14, '6': '.group_accounts.GroupVisibility', '10': 'visibility'},
    const {'1': 'image_url', '3': 5, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `CreateGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupRequestDescriptor = $convert.base64Decode('ChJDcmVhdGVHcm91cFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgCIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYAyABKAlSCG1ldGFkYXRhEj8KCnZpc2liaWxpdHkYBCABKA4yHy5ncm91cF9hY2NvdW50cy5Hcm91cFZpc2liaWxpdHlSCnZpc2liaWxpdHkSGwoJaW1hZ2VfdXJsGAUgASgJUghpbWFnZVVybA==');
@$core.Deprecated('Use createGroupResponseDescriptor instead')
const CreateGroupResponse$json = const {
  '1': 'CreateGroupResponse',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `CreateGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupResponseDescriptor = $convert.base64Decode('ChNDcmVhdGVHcm91cFJlc3BvbnNlEjkKBWdyb3VwGAEgASgLMiMuZ3JvdXBfYWNjb3VudHMuR3JvdXBBY2NvdW50TWVzc2FnZVIFZ3JvdXA=');
@$core.Deprecated('Use getGroupRequestDescriptor instead')
const GetGroupRequest$json = const {
  '1': 'GetGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupRequestDescriptor = $convert.base64Decode('Cg9HZXRHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQ=');
@$core.Deprecated('Use getGroupResponseDescriptor instead')
const GetGroupResponse$json = const {
  '1': 'GetGroupResponse',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `GetGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupResponseDescriptor = $convert.base64Decode('ChBHZXRHcm91cFJlc3BvbnNlEjkKBWdyb3VwGAEgASgLMiMuZ3JvdXBfYWNjb3VudHMuR3JvdXBBY2NvdW50TWVzc2FnZVIFZ3JvdXA=');
@$core.Deprecated('Use listUserGroupsRequestDescriptor instead')
const ListUserGroupsRequest$json = const {
  '1': 'ListUserGroupsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ListUserGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserGroupsRequestDescriptor = $convert.base64Decode('ChVMaXN0VXNlckdyb3Vwc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use listUserGroupsResponseDescriptor instead')
const ListUserGroupsResponse$json = const {
  '1': 'ListUserGroupsResponse',
  '2': const [
    const {'1': 'groups', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.GroupAccountMessage', '10': 'groups'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.GroupPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListUserGroupsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserGroupsResponseDescriptor = $convert.base64Decode('ChZMaXN0VXNlckdyb3Vwc1Jlc3BvbnNlEjsKBmdyb3VwcxgBIAMoCzIjLmdyb3VwX2FjY291bnRzLkdyb3VwQWNjb3VudE1lc3NhZ2VSBmdyb3VwcxJDCgpwYWdpbmF0aW9uGAIgASgLMiMuZ3JvdXBfYWNjb3VudHMuR3JvdXBQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');
@$core.Deprecated('Use updateGroupRequestDescriptor instead')
const UpdateGroupRequest$json = const {
  '1': 'UpdateGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.group_accounts.GroupAccountStatus', '10': 'status'},
    const {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'visibility', '3': 6, '4': 1, '5': 14, '6': '.group_accounts.GroupVisibility', '10': 'visibility'},
    const {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `UpdateGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateGroupRequestDescriptor = $convert.base64Decode('ChJVcGRhdGVHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SOgoGc3RhdHVzGAQgASgOMiIuZ3JvdXBfYWNjb3VudHMuR3JvdXBBY2NvdW50U3RhdHVzUgZzdGF0dXMSGgoIbWV0YWRhdGEYBSABKAlSCG1ldGFkYXRhEj8KCnZpc2liaWxpdHkYBiABKA4yHy5ncm91cF9hY2NvdW50cy5Hcm91cFZpc2liaWxpdHlSCnZpc2liaWxpdHkSGwoJaW1hZ2VfdXJsGAcgASgJUghpbWFnZVVybA==');
@$core.Deprecated('Use updateGroupResponseDescriptor instead')
const UpdateGroupResponse$json = const {
  '1': 'UpdateGroupResponse',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `UpdateGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateGroupResponseDescriptor = $convert.base64Decode('ChNVcGRhdGVHcm91cFJlc3BvbnNlEjkKBWdyb3VwGAEgASgLMiMuZ3JvdXBfYWNjb3VudHMuR3JvdXBBY2NvdW50TWVzc2FnZVIFZ3JvdXA=');
@$core.Deprecated('Use deleteGroupRequestDescriptor instead')
const DeleteGroupRequest$json = const {
  '1': 'DeleteGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `DeleteGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteGroupRequestDescriptor = $convert.base64Decode('ChJEZWxldGVHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQ=');
@$core.Deprecated('Use deleteGroupResponseDescriptor instead')
const DeleteGroupResponse$json = const {
  '1': 'DeleteGroupResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteGroupResponseDescriptor = $convert.base64Decode('ChNEZWxldGVHcm91cFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');
@$core.Deprecated('Use getGroupMembersRequestDescriptor instead')
const GetGroupMembersRequest$json = const {
  '1': 'GetGroupMembersRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupMembersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupMembersRequestDescriptor = $convert.base64Decode('ChZHZXRHcm91cE1lbWJlcnNSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');
@$core.Deprecated('Use getGroupMembersResponseDescriptor instead')
const GetGroupMembersResponse$json = const {
  '1': 'GetGroupMembersResponse',
  '2': const [
    const {'1': 'members', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.GroupMemberMessage', '10': 'members'},
  ],
};

/// Descriptor for `GetGroupMembersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupMembersResponseDescriptor = $convert.base64Decode('ChdHZXRHcm91cE1lbWJlcnNSZXNwb25zZRI8CgdtZW1iZXJzGAEgAygLMiIuZ3JvdXBfYWNjb3VudHMuR3JvdXBNZW1iZXJNZXNzYWdlUgdtZW1iZXJz');
@$core.Deprecated('Use addMemberRequestDescriptor instead')
const AddMemberRequest$json = const {
  '1': 'AddMemberRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'role', '3': 3, '4': 1, '5': 14, '6': '.group_accounts.GroupMemberRole', '10': 'role'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'lookup_username', '3': 6, '4': 1, '5': 9, '10': 'lookupUsername'},
  ],
};

/// Descriptor for `AddMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMemberRequestDescriptor = $convert.base64Decode('ChBBZGRNZW1iZXJSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIzCgRyb2xlGAMgASgOMh8uZ3JvdXBfYWNjb3VudHMuR3JvdXBNZW1iZXJSb2xlUgRyb2xlEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEicKD2xvb2t1cF91c2VybmFtZRgGIAEoCVIObG9va3VwVXNlcm5hbWU=');
@$core.Deprecated('Use addMemberResponseDescriptor instead')
const AddMemberResponse$json = const {
  '1': 'AddMemberResponse',
  '2': const [
    const {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupMemberMessage', '10': 'member'},
  ],
};

/// Descriptor for `AddMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMemberResponseDescriptor = $convert.base64Decode('ChFBZGRNZW1iZXJSZXNwb25zZRI6CgZtZW1iZXIYASABKAsyIi5ncm91cF9hY2NvdW50cy5Hcm91cE1lbWJlck1lc3NhZ2VSBm1lbWJlcg==');
@$core.Deprecated('Use updateMemberRoleRequestDescriptor instead')
const UpdateMemberRoleRequest$json = const {
  '1': 'UpdateMemberRoleRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'new_role', '3': 3, '4': 1, '5': 14, '6': '.group_accounts.GroupMemberRole', '10': 'newRole'},
  ],
};

/// Descriptor for `UpdateMemberRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMemberRoleRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVNZW1iZXJSb2xlUmVxdWVzdBIZCghncm91cF9pZBgBIAEoCVIHZ3JvdXBJZBIbCgltZW1iZXJfaWQYAiABKAlSCG1lbWJlcklkEjoKCG5ld19yb2xlGAMgASgOMh8uZ3JvdXBfYWNjb3VudHMuR3JvdXBNZW1iZXJSb2xlUgduZXdSb2xl');
@$core.Deprecated('Use updateMemberRoleResponseDescriptor instead')
const UpdateMemberRoleResponse$json = const {
  '1': 'UpdateMemberRoleResponse',
  '2': const [
    const {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupMemberMessage', '10': 'member'},
  ],
};

/// Descriptor for `UpdateMemberRoleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMemberRoleResponseDescriptor = $convert.base64Decode('ChhVcGRhdGVNZW1iZXJSb2xlUmVzcG9uc2USOgoGbWVtYmVyGAEgASgLMiIuZ3JvdXBfYWNjb3VudHMuR3JvdXBNZW1iZXJNZXNzYWdlUgZtZW1iZXI=');
@$core.Deprecated('Use removeMemberRequestDescriptor instead')
const RemoveMemberRequest$json = const {
  '1': 'RemoveMemberRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
  ],
};

/// Descriptor for `RemoveMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberRequestDescriptor = $convert.base64Decode('ChNSZW1vdmVNZW1iZXJSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElkEhsKCW1lbWJlcl9pZBgCIAEoCVIIbWVtYmVySWQ=');
@$core.Deprecated('Use removeMemberResponseDescriptor instead')
const RemoveMemberResponse$json = const {
  '1': 'RemoveMemberResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `RemoveMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberResponseDescriptor = $convert.base64Decode('ChRSZW1vdmVNZW1iZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');
@$core.Deprecated('Use searchUsersRequestDescriptor instead')
const SearchUsersRequest$json = const {
  '1': 'SearchUsersRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersRequestDescriptor = $convert.base64Decode('ChJTZWFyY2hVc2Vyc1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');
@$core.Deprecated('Use searchUsersResponseDescriptor instead')
const SearchUsersResponse$json = const {
  '1': 'SearchUsersResponse',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.GroupMemberMessage', '10': 'users'},
  ],
};

/// Descriptor for `SearchUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersResponseDescriptor = $convert.base64Decode('ChNTZWFyY2hVc2Vyc1Jlc3BvbnNlEjgKBXVzZXJzGAEgAygLMiIuZ3JvdXBfYWNjb3VudHMuR3JvdXBNZW1iZXJNZXNzYWdlUgV1c2Vycw==');
@$core.Deprecated('Use createContributionRequestDescriptor instead')
const CreateContributionRequest$json = const {
  '1': 'CreateContributionRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'target_amount', '3': 4, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'deadline', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    const {'1': 'type', '3': 7, '4': 1, '5': 14, '6': '.group_accounts.ContributionType', '10': 'type'},
    const {'1': 'frequency', '3': 8, '4': 1, '5': 14, '6': '.group_accounts.ContributionFrequency', '10': 'frequency'},
    const {'1': 'regular_amount', '3': 9, '4': 1, '5': 4, '10': 'regularAmount'},
    const {'1': 'start_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'total_cycles', '3': 11, '4': 1, '5': 5, '10': 'totalCycles'},
    const {'1': 'member_rotation_order', '3': 12, '4': 3, '5': 9, '10': 'memberRotationOrder'},
    const {'1': 'auto_pay_enabled', '3': 13, '4': 1, '5': 8, '10': 'autoPayEnabled'},
    const {'1': 'penalty_amount', '3': 14, '4': 1, '5': 4, '10': 'penaltyAmount'},
    const {'1': 'grace_period_days', '3': 15, '4': 1, '5': 5, '10': 'gracePeriodDays'},
    const {'1': 'allow_partial_payments', '3': 16, '4': 1, '5': 8, '10': 'allowPartialPayments'},
    const {'1': 'minimum_balance', '3': 17, '4': 1, '5': 4, '10': 'minimumBalance'},
    const {'1': 'metadata', '3': 18, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'auto_payout_enabled', '3': 19, '4': 1, '5': 8, '10': 'autoPayoutEnabled'},
  ],
};

/// Descriptor for `CreateContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createContributionRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVDb250cmlidXRpb25SZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SIwoNdGFyZ2V0X2Ftb3VudBgEIAEoBFIMdGFyZ2V0QW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRI2CghkZWFkbGluZRgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGRlYWRsaW5lEjQKBHR5cGUYByABKA4yIC5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25UeXBlUgR0eXBlEkMKCWZyZXF1ZW5jeRgIIAEoDjIlLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvbkZyZXF1ZW5jeVIJZnJlcXVlbmN5EiUKDnJlZ3VsYXJfYW1vdW50GAkgASgEUg1yZWd1bGFyQW1vdW50EjkKCnN0YXJ0X2RhdGUYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSIQoMdG90YWxfY3ljbGVzGAsgASgFUgt0b3RhbEN5Y2xlcxIyChVtZW1iZXJfcm90YXRpb25fb3JkZXIYDCADKAlSE21lbWJlclJvdGF0aW9uT3JkZXISKAoQYXV0b19wYXlfZW5hYmxlZBgNIAEoCFIOYXV0b1BheUVuYWJsZWQSJQoOcGVuYWx0eV9hbW91bnQYDiABKARSDXBlbmFsdHlBbW91bnQSKgoRZ3JhY2VfcGVyaW9kX2RheXMYDyABKAVSD2dyYWNlUGVyaW9kRGF5cxI0ChZhbGxvd19wYXJ0aWFsX3BheW1lbnRzGBAgASgIUhRhbGxvd1BhcnRpYWxQYXltZW50cxInCg9taW5pbXVtX2JhbGFuY2UYESABKARSDm1pbmltdW1CYWxhbmNlEhoKCG1ldGFkYXRhGBIgASgJUghtZXRhZGF0YRIuChNhdXRvX3BheW91dF9lbmFibGVkGBMgASgIUhFhdXRvUGF5b3V0RW5hYmxlZA==');
@$core.Deprecated('Use createContributionResponseDescriptor instead')
const CreateContributionResponse$json = const {
  '1': 'CreateContributionResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `CreateContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createContributionResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVDb250cmlidXRpb25SZXNwb25zZRJHCgxjb250cmlidXRpb24YASABKAsyIy5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');
@$core.Deprecated('Use getContributionRequestDescriptor instead')
const GetContributionRequest$json = const {
  '1': 'GetContributionRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GetContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionRequestDescriptor = $convert.base64Decode('ChZHZXRDb250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQ=');
@$core.Deprecated('Use getContributionResponseDescriptor instead')
const GetContributionResponse$json = const {
  '1': 'GetContributionResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `GetContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionResponseDescriptor = $convert.base64Decode('ChdHZXRDb250cmlidXRpb25SZXNwb25zZRJHCgxjb250cmlidXRpb24YASABKAsyIy5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');
@$core.Deprecated('Use listGroupContributionsRequestDescriptor instead')
const ListGroupContributionsRequest$json = const {
  '1': 'ListGroupContributionsRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ListGroupContributionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupContributionsRequestDescriptor = $convert.base64Decode('Ch1MaXN0R3JvdXBDb250cmlidXRpb25zUmVxdWVzdBIZCghncm91cF9pZBgBIAEoCVIHZ3JvdXBJZBISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemUSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use listGroupContributionsResponseDescriptor instead')
const ListGroupContributionsResponse$json = const {
  '1': 'ListGroupContributionsResponse',
  '2': const [
    const {'1': 'contributions', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contributions'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.ContributionPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListGroupContributionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupContributionsResponseDescriptor = $convert.base64Decode('Ch5MaXN0R3JvdXBDb250cmlidXRpb25zUmVzcG9uc2USSQoNY29udHJpYnV0aW9ucxgBIAMoCzIjLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvbk1lc3NhZ2VSDWNvbnRyaWJ1dGlvbnMSSgoKcGFnaW5hdGlvbhgCIAEoCzIqLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvblBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use updateContributionRequestDescriptor instead')
const UpdateContributionRequest$json = const {
  '1': 'UpdateContributionRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'target_amount', '3': 4, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'deadline', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.group_accounts.ContributionStatus', '10': 'status'},
    const {'1': 'metadata', '3': 7, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'auto_payout_enabled', '3': 8, '4': 1, '5': 8, '10': 'autoPayoutEnabled'},
    const {'1': 'auto_payout_enabled_set', '3': 9, '4': 1, '5': 8, '10': 'autoPayoutEnabledSet'},
  ],
};

/// Descriptor for `UpdateContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateContributionRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVDb250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIjCg10YXJnZXRfYW1vdW50GAQgASgEUgx0YXJnZXRBbW91bnQSNgoIZGVhZGxpbmUYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRI6CgZzdGF0dXMYBiABKA4yIi5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25TdGF0dXNSBnN0YXR1cxIaCghtZXRhZGF0YRgHIAEoCVIIbWV0YWRhdGESLgoTYXV0b19wYXlvdXRfZW5hYmxlZBgIIAEoCFIRYXV0b1BheW91dEVuYWJsZWQSNQoXYXV0b19wYXlvdXRfZW5hYmxlZF9zZXQYCSABKAhSFGF1dG9QYXlvdXRFbmFibGVkU2V0');
@$core.Deprecated('Use updateContributionResponseDescriptor instead')
const UpdateContributionResponse$json = const {
  '1': 'UpdateContributionResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `UpdateContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateContributionResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVDb250cmlidXRpb25SZXNwb25zZRJHCgxjb250cmlidXRpb24YASABKAsyIy5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');
@$core.Deprecated('Use deleteContributionRequestDescriptor instead')
const DeleteContributionRequest$json = const {
  '1': 'DeleteContributionRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `DeleteContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteContributionRequestDescriptor = $convert.base64Decode('ChlEZWxldGVDb250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQ=');
@$core.Deprecated('Use deleteContributionResponseDescriptor instead')
const DeleteContributionResponse$json = const {
  '1': 'DeleteContributionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteContributionResponseDescriptor = $convert.base64Decode('ChpEZWxldGVDb250cmlidXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');
@$core.Deprecated('Use addMembersToContributionRequestDescriptor instead')
const AddMembersToContributionRequest$json = const {
  '1': 'AddMembersToContributionRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'member_user_ids', '3': 2, '4': 3, '5': 9, '10': 'memberUserIds'},
  ],
};

/// Descriptor for `AddMembersToContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMembersToContributionRequestDescriptor = $convert.base64Decode('Ch9BZGRNZW1iZXJzVG9Db250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQSJgoPbWVtYmVyX3VzZXJfaWRzGAIgAygJUg1tZW1iZXJVc2VySWRz');
@$core.Deprecated('Use addMembersToContributionResponseDescriptor instead')
const AddMembersToContributionResponse$json = const {
  '1': 'AddMembersToContributionResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contribution'},
    const {'1': 'added_members', '3': 2, '4': 3, '5': 11, '6': '.group_accounts.ContributionMemberMessage', '10': 'addedMembers'},
  ],
};

/// Descriptor for `AddMembersToContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMembersToContributionResponseDescriptor = $convert.base64Decode('CiBBZGRNZW1iZXJzVG9Db250cmlidXRpb25SZXNwb25zZRJHCgxjb250cmlidXRpb24YASABKAsyIy5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24STgoNYWRkZWRfbWVtYmVycxgCIAMoCzIpLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvbk1lbWJlck1lc3NhZ2VSDGFkZGVkTWVtYmVycw==');
@$core.Deprecated('Use groupInvitationMessageDescriptor instead')
const GroupInvitationMessage$json = const {
  '1': 'GroupInvitationMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'invitee_user_id', '3': 3, '4': 1, '5': 9, '10': 'inviteeUserId'},
    const {'1': 'inviter_user_id', '3': 4, '4': 1, '5': 9, '10': 'inviterUserId'},
    const {'1': 'role', '3': 5, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'invited_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'invitedAt'},
    const {'1': 'decided_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'decidedAt'},
    const {'1': 'expires_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'message', '3': 10, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'group_name', '3': 11, '4': 1, '5': 9, '10': 'groupName'},
    const {'1': 'group_description', '3': 12, '4': 1, '5': 9, '10': 'groupDescription'},
    const {'1': 'inviter_name', '3': 13, '4': 1, '5': 9, '10': 'inviterName'},
  ],
};

/// Descriptor for `GroupInvitationMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupInvitationMessageDescriptor = $convert.base64Decode('ChZHcm91cEludml0YXRpb25NZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIZCghncm91cF9pZBgCIAEoCVIHZ3JvdXBJZBImCg9pbnZpdGVlX3VzZXJfaWQYAyABKAlSDWludml0ZWVVc2VySWQSJgoPaW52aXRlcl91c2VyX2lkGAQgASgJUg1pbnZpdGVyVXNlcklkEhIKBHJvbGUYBSABKAlSBHJvbGUSFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSOQoKaW52aXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWludml0ZWRBdBI5CgpkZWNpZGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZGVjaWRlZEF0EjkKCmV4cGlyZXNfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQSGAoHbWVzc2FnZRgKIAEoCVIHbWVzc2FnZRIdCgpncm91cF9uYW1lGAsgASgJUglncm91cE5hbWUSKwoRZ3JvdXBfZGVzY3JpcHRpb24YDCABKAlSEGdyb3VwRGVzY3JpcHRpb24SIQoMaW52aXRlcl9uYW1lGA0gASgJUgtpbnZpdGVyTmFtZQ==');
@$core.Deprecated('Use inviteToGroupRequestDescriptor instead')
const InviteToGroupRequest$json = const {
  '1': 'InviteToGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'invitee_user_id', '3': 2, '4': 1, '5': 9, '10': 'inviteeUserId'},
    const {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InviteToGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteToGroupRequestDescriptor = $convert.base64Decode('ChRJbnZpdGVUb0dyb3VwUmVxdWVzdBIZCghncm91cF9pZBgBIAEoCVIHZ3JvdXBJZBImCg9pbnZpdGVlX3VzZXJfaWQYAiABKAlSDWludml0ZWVVc2VySWQSEgoEcm9sZRgDIAEoCVIEcm9sZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use inviteToGroupResponseDescriptor instead')
const InviteToGroupResponse$json = const {
  '1': 'InviteToGroupResponse',
  '2': const [
    const {'1': 'invitation', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupInvitationMessage', '10': 'invitation'},
  ],
};

/// Descriptor for `InviteToGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteToGroupResponseDescriptor = $convert.base64Decode('ChVJbnZpdGVUb0dyb3VwUmVzcG9uc2USRgoKaW52aXRhdGlvbhgBIAEoCzImLmdyb3VwX2FjY291bnRzLkdyb3VwSW52aXRhdGlvbk1lc3NhZ2VSCmludml0YXRpb24=');
@$core.Deprecated('Use respondToGroupInviteRequestDescriptor instead')
const RespondToGroupInviteRequest$json = const {
  '1': 'RespondToGroupInviteRequest',
  '2': const [
    const {'1': 'invitation_id', '3': 1, '4': 1, '5': 9, '10': 'invitationId'},
    const {'1': 'accept', '3': 2, '4': 1, '5': 8, '10': 'accept'},
  ],
};

/// Descriptor for `RespondToGroupInviteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List respondToGroupInviteRequestDescriptor = $convert.base64Decode('ChtSZXNwb25kVG9Hcm91cEludml0ZVJlcXVlc3QSIwoNaW52aXRhdGlvbl9pZBgBIAEoCVIMaW52aXRhdGlvbklkEhYKBmFjY2VwdBgCIAEoCFIGYWNjZXB0');
@$core.Deprecated('Use respondToGroupInviteResponseDescriptor instead')
const RespondToGroupInviteResponse$json = const {
  '1': 'RespondToGroupInviteResponse',
  '2': const [
    const {'1': 'invitation', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupInvitationMessage', '10': 'invitation'},
  ],
};

/// Descriptor for `RespondToGroupInviteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List respondToGroupInviteResponseDescriptor = $convert.base64Decode('ChxSZXNwb25kVG9Hcm91cEludml0ZVJlc3BvbnNlEkYKCmludml0YXRpb24YASABKAsyJi5ncm91cF9hY2NvdW50cy5Hcm91cEludml0YXRpb25NZXNzYWdlUgppbnZpdGF0aW9u');
@$core.Deprecated('Use cancelGroupInviteRequestDescriptor instead')
const CancelGroupInviteRequest$json = const {
  '1': 'CancelGroupInviteRequest',
  '2': const [
    const {'1': 'invitation_id', '3': 1, '4': 1, '5': 9, '10': 'invitationId'},
  ],
};

/// Descriptor for `CancelGroupInviteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelGroupInviteRequestDescriptor = $convert.base64Decode('ChhDYW5jZWxHcm91cEludml0ZVJlcXVlc3QSIwoNaW52aXRhdGlvbl9pZBgBIAEoCVIMaW52aXRhdGlvbklk');
@$core.Deprecated('Use cancelGroupInviteResponseDescriptor instead')
const CancelGroupInviteResponse$json = const {
  '1': 'CancelGroupInviteResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `CancelGroupInviteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelGroupInviteResponseDescriptor = $convert.base64Decode('ChlDYW5jZWxHcm91cEludml0ZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');
@$core.Deprecated('Use listMyInvitationsRequestDescriptor instead')
const ListMyInvitationsRequest$json = const {
  '1': 'ListMyInvitationsRequest',
  '2': const [
    const {'1': 'statuses', '3': 1, '4': 3, '5': 9, '10': 'statuses'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 13, '10': 'limit'},
  ],
};

/// Descriptor for `ListMyInvitationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyInvitationsRequestDescriptor = $convert.base64Decode('ChhMaXN0TXlJbnZpdGF0aW9uc1JlcXVlc3QSGgoIc3RhdHVzZXMYASADKAlSCHN0YXR1c2VzEhQKBWxpbWl0GAIgASgNUgVsaW1pdA==');
@$core.Deprecated('Use listMyInvitationsResponseDescriptor instead')
const ListMyInvitationsResponse$json = const {
  '1': 'ListMyInvitationsResponse',
  '2': const [
    const {'1': 'invitations', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.GroupInvitationMessage', '10': 'invitations'},
  ],
};

/// Descriptor for `ListMyInvitationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyInvitationsResponseDescriptor = $convert.base64Decode('ChlMaXN0TXlJbnZpdGF0aW9uc1Jlc3BvbnNlEkgKC2ludml0YXRpb25zGAEgAygLMiYuZ3JvdXBfYWNjb3VudHMuR3JvdXBJbnZpdGF0aW9uTWVzc2FnZVILaW52aXRhdGlvbnM=');
@$core.Deprecated('Use listGroupInvitationsRequestDescriptor instead')
const ListGroupInvitationsRequest$json = const {
  '1': 'ListGroupInvitationsRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'statuses', '3': 2, '4': 3, '5': 9, '10': 'statuses'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 13, '10': 'limit'},
  ],
};

/// Descriptor for `ListGroupInvitationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupInvitationsRequestDescriptor = $convert.base64Decode('ChtMaXN0R3JvdXBJbnZpdGF0aW9uc1JlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSGgoIc3RhdHVzZXMYAiADKAlSCHN0YXR1c2VzEhQKBWxpbWl0GAMgASgNUgVsaW1pdA==');
@$core.Deprecated('Use listGroupInvitationsResponseDescriptor instead')
const ListGroupInvitationsResponse$json = const {
  '1': 'ListGroupInvitationsResponse',
  '2': const [
    const {'1': 'invitations', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.GroupInvitationMessage', '10': 'invitations'},
  ],
};

/// Descriptor for `ListGroupInvitationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupInvitationsResponseDescriptor = $convert.base64Decode('ChxMaXN0R3JvdXBJbnZpdGF0aW9uc1Jlc3BvbnNlEkgKC2ludml0YXRpb25zGAEgAygLMiYuZ3JvdXBfYWNjb3VudHMuR3JvdXBJbnZpdGF0aW9uTWVzc2FnZVILaW52aXRhdGlvbnM=');
@$core.Deprecated('Use removeMemberFromContributionRequestDescriptor instead')
const RemoveMemberFromContributionRequest$json = const {
  '1': 'RemoveMemberFromContributionRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'member_user_id', '3': 2, '4': 1, '5': 9, '10': 'memberUserId'},
  ],
};

/// Descriptor for `RemoveMemberFromContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberFromContributionRequestDescriptor = $convert.base64Decode('CiNSZW1vdmVNZW1iZXJGcm9tQ29udHJpYnV0aW9uUmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklkEiQKDm1lbWJlcl91c2VyX2lkGAIgASgJUgxtZW1iZXJVc2VySWQ=');
@$core.Deprecated('Use removeMemberFromContributionResponseDescriptor instead')
const RemoveMemberFromContributionResponse$json = const {
  '1': 'RemoveMemberFromContributionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'refund_amount', '3': 2, '4': 1, '5': 4, '10': 'refundAmount'},
    const {'1': 'forfeited_amount', '3': 3, '4': 1, '5': 4, '10': 'forfeitedAmount'},
    const {'1': 'refund_status', '3': 4, '4': 1, '5': 9, '10': 'refundStatus'},
    const {'1': 'removal_reason', '3': 5, '4': 1, '5': 9, '10': 'removalReason'},
  ],
};

/// Descriptor for `RemoveMemberFromContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberFromContributionResponseDescriptor = $convert.base64Decode('CiRSZW1vdmVNZW1iZXJGcm9tQ29udHJpYnV0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIjCg1yZWZ1bmRfYW1vdW50GAIgASgEUgxyZWZ1bmRBbW91bnQSKQoQZm9yZmVpdGVkX2Ftb3VudBgDIAEoBFIPZm9yZmVpdGVkQW1vdW50EiMKDXJlZnVuZF9zdGF0dXMYBCABKAlSDHJlZnVuZFN0YXR1cxIlCg5yZW1vdmFsX3JlYXNvbhgFIAEoCVINcmVtb3ZhbFJlYXNvbg==');
@$core.Deprecated('Use removeContributionShadowRequestDescriptor instead')
const RemoveContributionShadowRequest$json = const {
  '1': 'RemoveContributionShadowRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'member_user_id', '3': 2, '4': 1, '5': 9, '10': 'memberUserId'},
  ],
};

/// Descriptor for `RemoveContributionShadowRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeContributionShadowRequestDescriptor = $convert.base64Decode('Ch9SZW1vdmVDb250cmlidXRpb25TaGFkb3dSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQSJAoObWVtYmVyX3VzZXJfaWQYAiABKAlSDG1lbWJlclVzZXJJZA==');
@$core.Deprecated('Use removeContributionShadowResponseDescriptor instead')
const RemoveContributionShadowResponse$json = const {
  '1': 'RemoveContributionShadowResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'removed_count', '3': 2, '4': 1, '5': 5, '10': 'removedCount'},
  ],
};

/// Descriptor for `RemoveContributionShadowResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeContributionShadowResponseDescriptor = $convert.base64Decode('CiBSZW1vdmVDb250cmlidXRpb25TaGFkb3dSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiMKDXJlbW92ZWRfY291bnQYAiABKAVSDHJlbW92ZWRDb3VudA==');
@$core.Deprecated('Use previewMemberExitRequestDescriptor instead')
const PreviewMemberExitRequest$json = const {
  '1': 'PreviewMemberExitRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'member_user_id', '3': 2, '4': 1, '5': 9, '10': 'memberUserId'},
  ],
};

/// Descriptor for `PreviewMemberExitRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List previewMemberExitRequestDescriptor = $convert.base64Decode('ChhQcmV2aWV3TWVtYmVyRXhpdFJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZBIkCg5tZW1iZXJfdXNlcl9pZBgCIAEoCVIMbWVtYmVyVXNlcklk');
@$core.Deprecated('Use previewMemberExitResponseDescriptor instead')
const PreviewMemberExitResponse$json = const {
  '1': 'PreviewMemberExitResponse',
  '2': const [
    const {'1': 'exit_allowed', '3': 1, '4': 1, '5': 8, '10': 'exitAllowed'},
    const {'1': 'blocked_reason', '3': 2, '4': 1, '5': 9, '10': 'blockedReason'},
    const {'1': 'removal_reason', '3': 3, '4': 1, '5': 9, '10': 'removalReason'},
    const {'1': 'refund_amount', '3': 4, '4': 1, '5': 4, '10': 'refundAmount'},
    const {'1': 'forfeited_amount', '3': 5, '4': 1, '5': 4, '10': 'forfeitedAmount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'member_has_received_payout', '3': 7, '4': 1, '5': 8, '10': 'memberHasReceivedPayout'},
    const {'1': 'current_cycle', '3': 8, '4': 1, '5': 13, '10': 'currentCycle'},
  ],
};

/// Descriptor for `PreviewMemberExitResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List previewMemberExitResponseDescriptor = $convert.base64Decode('ChlQcmV2aWV3TWVtYmVyRXhpdFJlc3BvbnNlEiEKDGV4aXRfYWxsb3dlZBgBIAEoCFILZXhpdEFsbG93ZWQSJQoOYmxvY2tlZF9yZWFzb24YAiABKAlSDWJsb2NrZWRSZWFzb24SJQoOcmVtb3ZhbF9yZWFzb24YAyABKAlSDXJlbW92YWxSZWFzb24SIwoNcmVmdW5kX2Ftb3VudBgEIAEoBFIMcmVmdW5kQW1vdW50EikKEGZvcmZlaXRlZF9hbW91bnQYBSABKARSD2ZvcmZlaXRlZEFtb3VudBIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSOwoabWVtYmVyX2hhc19yZWNlaXZlZF9wYXlvdXQYByABKAhSF21lbWJlckhhc1JlY2VpdmVkUGF5b3V0EiMKDWN1cnJlbnRfY3ljbGUYCCABKA1SDGN1cnJlbnRDeWNsZQ==');
@$core.Deprecated('Use getContributionMembersRequestDescriptor instead')
const GetContributionMembersRequest$json = const {
  '1': 'GetContributionMembersRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GetContributionMembersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionMembersRequestDescriptor = $convert.base64Decode('Ch1HZXRDb250cmlidXRpb25NZW1iZXJzUmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklk');
@$core.Deprecated('Use getContributionMembersResponseDescriptor instead')
const GetContributionMembersResponse$json = const {
  '1': 'GetContributionMembersResponse',
  '2': const [
    const {'1': 'members', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.ContributionMemberMessage', '10': 'members'},
  ],
};

/// Descriptor for `GetContributionMembersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionMembersResponseDescriptor = $convert.base64Decode('Ch5HZXRDb250cmlidXRpb25NZW1iZXJzUmVzcG9uc2USQwoHbWVtYmVycxgBIAMoCzIpLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvbk1lbWJlck1lc3NhZ2VSB21lbWJlcnM=');
@$core.Deprecated('Use makePaymentRequestDescriptor instead')
const MakePaymentRequest$json = const {
  '1': 'MakePaymentRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'transaction_pin', '3': 5, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `MakePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makePaymentRequestDescriptor = $convert.base64Decode('ChJNYWtlUGF5bWVudFJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZBIWCgZhbW91bnQYAiABKARSBmFtb3VudBIUCgVub3RlcxgDIAEoCVIFbm90ZXMSKgoRc291cmNlX2FjY291bnRfaWQYBCABKAlSD3NvdXJjZUFjY291bnRJZBInCg90cmFuc2FjdGlvbl9waW4YBSABKAlSDnRyYW5zYWN0aW9uUGluEicKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use makePaymentResponseDescriptor instead')
const MakePaymentResponse$json = const {
  '1': 'MakePaymentResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionPaymentMessage', '10': 'payment'},
  ],
};

/// Descriptor for `MakePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makePaymentResponseDescriptor = $convert.base64Decode('ChNNYWtlUGF5bWVudFJlc3BvbnNlEkQKB3BheW1lbnQYASABKAsyKi5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25QYXltZW50TWVzc2FnZVIHcGF5bWVudA==');
@$core.Deprecated('Use getContributionPaymentsRequestDescriptor instead')
const GetContributionPaymentsRequest$json = const {
  '1': 'GetContributionPaymentsRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetContributionPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionPaymentsRequestDescriptor = $convert.base64Decode('Ch5HZXRDb250cmlidXRpb25QYXltZW50c1JlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZBISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemU=');
@$core.Deprecated('Use getContributionPaymentsResponseDescriptor instead')
const GetContributionPaymentsResponse$json = const {
  '1': 'GetContributionPaymentsResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.ContributionPaymentMessage', '10': 'payments'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.PaymentPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetContributionPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionPaymentsResponseDescriptor = $convert.base64Decode('Ch9HZXRDb250cmlidXRpb25QYXltZW50c1Jlc3BvbnNlEkYKCHBheW1lbnRzGAEgAygLMiouZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSCHBheW1lbnRzEkUKCnBhZ2luYXRpb24YAiABKAsyJS5ncm91cF9hY2NvdW50cy5QYXltZW50UGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');
@$core.Deprecated('Use updatePaymentStatusRequestDescriptor instead')
const UpdatePaymentStatusRequest$json = const {
  '1': 'UpdatePaymentStatusRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.group_accounts.PaymentStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `UpdatePaymentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePaymentStatusRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVQYXltZW50U3RhdHVzUmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SWQSNQoGc3RhdHVzGAIgASgOMh0uZ3JvdXBfYWNjb3VudHMuUGF5bWVudFN0YXR1c1IGc3RhdHVzEiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklk');
@$core.Deprecated('Use updatePaymentStatusResponseDescriptor instead')
const UpdatePaymentStatusResponse$json = const {
  '1': 'UpdatePaymentStatusResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionPaymentMessage', '10': 'payment'},
  ],
};

/// Descriptor for `UpdatePaymentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePaymentStatusResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVQYXltZW50U3RhdHVzUmVzcG9uc2USRAoHcGF5bWVudBgBIAEoCzIqLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvblBheW1lbnRNZXNzYWdlUgdwYXltZW50');
@$core.Deprecated('Use processScheduledPaymentsRequestDescriptor instead')
const ProcessScheduledPaymentsRequest$json = const {
  '1': 'ProcessScheduledPaymentsRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `ProcessScheduledPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processScheduledPaymentsRequestDescriptor = $convert.base64Decode('Ch9Qcm9jZXNzU2NoZWR1bGVkUGF5bWVudHNSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQ=');
@$core.Deprecated('Use processScheduledPaymentsResponseDescriptor instead')
const ProcessScheduledPaymentsResponse$json = const {
  '1': 'ProcessScheduledPaymentsResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contribution'},
    const {'1': 'payments_processed', '3': 2, '4': 3, '5': 11, '6': '.group_accounts.ContributionPaymentMessage', '10': 'paymentsProcessed'},
  ],
};

/// Descriptor for `ProcessScheduledPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processScheduledPaymentsResponseDescriptor = $convert.base64Decode('CiBQcm9jZXNzU2NoZWR1bGVkUGF5bWVudHNSZXNwb25zZRJHCgxjb250cmlidXRpb24YASABKAsyIy5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24SWQoScGF5bWVudHNfcHJvY2Vzc2VkGAIgAygLMiouZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSEXBheW1lbnRzUHJvY2Vzc2Vk');
@$core.Deprecated('Use getPayoutScheduleRequestDescriptor instead')
const GetPayoutScheduleRequest$json = const {
  '1': 'GetPayoutScheduleRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GetPayoutScheduleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutScheduleRequestDescriptor = $convert.base64Decode('ChhHZXRQYXlvdXRTY2hlZHVsZVJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZA==');
@$core.Deprecated('Use getPayoutScheduleResponseDescriptor instead')
const GetPayoutScheduleResponse$json = const {
  '1': 'GetPayoutScheduleResponse',
  '2': const [
    const {'1': 'schedule', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.PayoutScheduleMessage', '10': 'schedule'},
  ],
};

/// Descriptor for `GetPayoutScheduleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutScheduleResponseDescriptor = $convert.base64Decode('ChlHZXRQYXlvdXRTY2hlZHVsZVJlc3BvbnNlEkEKCHNjaGVkdWxlGAEgAygLMiUuZ3JvdXBfYWNjb3VudHMuUGF5b3V0U2NoZWR1bGVNZXNzYWdlUghzY2hlZHVsZQ==');
@$core.Deprecated('Use processPayoutRequestDescriptor instead')
const ProcessPayoutRequest$json = const {
  '1': 'ProcessPayoutRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `ProcessPayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayoutRequestDescriptor = $convert.base64Decode('ChRQcm9jZXNzUGF5b3V0UmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklk');
@$core.Deprecated('Use processPayoutResponseDescriptor instead')
const ProcessPayoutResponse$json = const {
  '1': 'ProcessPayoutResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.PayoutTransactionMessage', '10': 'transaction'},
  ],
};

/// Descriptor for `ProcessPayoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayoutResponseDescriptor = $convert.base64Decode('ChVQcm9jZXNzUGF5b3V0UmVzcG9uc2USSgoLdHJhbnNhY3Rpb24YASABKAsyKC5ncm91cF9hY2NvdW50cy5QYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2VSC3RyYW5zYWN0aW9u');
@$core.Deprecated('Use updatePayoutStatusRequestDescriptor instead')
const UpdatePayoutStatusRequest$json = const {
  '1': 'UpdatePayoutStatusRequest',
  '2': const [
    const {'1': 'payout_id', '3': 1, '4': 1, '5': 9, '10': 'payoutId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.group_accounts.PayoutTransactionStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'failure_reason', '3': 4, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `UpdatePayoutStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePayoutStatusRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVQYXlvdXRTdGF0dXNSZXF1ZXN0EhsKCXBheW91dF9pZBgBIAEoCVIIcGF5b3V0SWQSPwoGc3RhdHVzGAIgASgOMicuZ3JvdXBfYWNjb3VudHMuUGF5b3V0VHJhbnNhY3Rpb25TdGF0dXNSBnN0YXR1cxIlCg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBIlCg5mYWlsdXJlX3JlYXNvbhgEIAEoCVINZmFpbHVyZVJlYXNvbg==');
@$core.Deprecated('Use updatePayoutStatusResponseDescriptor instead')
const UpdatePayoutStatusResponse$json = const {
  '1': 'UpdatePayoutStatusResponse',
  '2': const [
    const {'1': 'payout', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.PayoutTransactionMessage', '10': 'payout'},
  ],
};

/// Descriptor for `UpdatePayoutStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePayoutStatusResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVQYXlvdXRTdGF0dXNSZXNwb25zZRJACgZwYXlvdXQYASABKAsyKC5ncm91cF9hY2NvdW50cy5QYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2VSBnBheW91dA==');
@$core.Deprecated('Use advancePayoutRotationRequestDescriptor instead')
const AdvancePayoutRotationRequest$json = const {
  '1': 'AdvancePayoutRotationRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `AdvancePayoutRotationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List advancePayoutRotationRequestDescriptor = $convert.base64Decode('ChxBZHZhbmNlUGF5b3V0Um90YXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQ=');
@$core.Deprecated('Use advancePayoutRotationResponseDescriptor instead')
const AdvancePayoutRotationResponse$json = const {
  '1': 'AdvancePayoutRotationResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `AdvancePayoutRotationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List advancePayoutRotationResponseDescriptor = $convert.base64Decode('Ch1BZHZhbmNlUGF5b3V0Um90YXRpb25SZXNwb25zZRJHCgxjb250cmlidXRpb24YASABKAsyIy5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');
@$core.Deprecated('Use generateReceiptRequestDescriptor instead')
const GenerateReceiptRequest$json = const {
  '1': 'GenerateReceiptRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GenerateReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateReceiptRequestDescriptor = $convert.base64Decode('ChZHZW5lcmF0ZVJlY2VpcHRSZXF1ZXN0Eh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZA==');
@$core.Deprecated('Use generateReceiptResponseDescriptor instead')
const GenerateReceiptResponse$json = const {
  '1': 'GenerateReceiptResponse',
  '2': const [
    const {'1': 'receipt', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionReceiptMessage', '10': 'receipt'},
  ],
};

/// Descriptor for `GenerateReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateReceiptResponseDescriptor = $convert.base64Decode('ChdHZW5lcmF0ZVJlY2VpcHRSZXNwb25zZRJECgdyZWNlaXB0GAEgASgLMiouZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uUmVjZWlwdE1lc3NhZ2VSB3JlY2VpcHQ=');
@$core.Deprecated('Use getUserContributionReceiptsRequestDescriptor instead')
const GetUserContributionReceiptsRequest$json = const {
  '1': 'GetUserContributionReceiptsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetUserContributionReceiptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionReceiptsRequestDescriptor = $convert.base64Decode('CiJHZXRVc2VyQ29udHJpYnV0aW9uUmVjZWlwdHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAIgASgFUghwYWdlU2l6ZQ==');
@$core.Deprecated('Use getUserContributionReceiptsResponseDescriptor instead')
const GetUserContributionReceiptsResponse$json = const {
  '1': 'GetUserContributionReceiptsResponse',
  '2': const [
    const {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.ContributionReceiptMessage', '10': 'receipts'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.ReceiptPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserContributionReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionReceiptsResponseDescriptor = $convert.base64Decode('CiNHZXRVc2VyQ29udHJpYnV0aW9uUmVjZWlwdHNSZXNwb25zZRJGCghyZWNlaXB0cxgBIAMoCzIqLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvblJlY2VpcHRNZXNzYWdlUghyZWNlaXB0cxJFCgpwYWdpbmF0aW9uGAIgASgLMiUuZ3JvdXBfYWNjb3VudHMuUmVjZWlwdFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use generateTranscriptRequestDescriptor instead')
const GenerateTranscriptRequest$json = const {
  '1': 'GenerateTranscriptRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GenerateTranscriptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateTranscriptRequestDescriptor = $convert.base64Decode('ChlHZW5lcmF0ZVRyYW5zY3JpcHRSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQ=');
@$core.Deprecated('Use generateTranscriptResponseDescriptor instead')
const GenerateTranscriptResponse$json = const {
  '1': 'GenerateTranscriptResponse',
  '2': const [
    const {'1': 'transcript', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionTranscriptMessage', '10': 'transcript'},
  ],
};

/// Descriptor for `GenerateTranscriptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateTranscriptResponseDescriptor = $convert.base64Decode('ChpHZW5lcmF0ZVRyYW5zY3JpcHRSZXNwb25zZRJNCgp0cmFuc2NyaXB0GAEgASgLMi0uZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uVHJhbnNjcmlwdE1lc3NhZ2VSCnRyYW5zY3JpcHQ=');
@$core.Deprecated('Use contributionCycleSummaryDescriptor instead')
const ContributionCycleSummary$json = const {
  '1': 'ContributionCycleSummary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 3, '4': 1, '5': 5, '10': 'cycleIndex'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'started_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startedAt'},
    const {'1': 'ended_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endedAt'},
    const {'1': 'target_amount', '3': 7, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'raised_amount', '3': 8, '4': 1, '5': 4, '10': 'raisedAmount'},
    const {'1': 'deficit_amount', '3': 9, '4': 1, '5': 4, '10': 'deficitAmount'},
    const {'1': 'payout_transaction_id', '3': 10, '4': 1, '5': 9, '10': 'payoutTransactionId'},
    const {'1': 'receiver_user_id', '3': 11, '4': 1, '5': 9, '10': 'receiverUserId'},
    const {'1': 'receiver_name', '3': 12, '4': 1, '5': 9, '10': 'receiverName'},
    const {'1': 'payment_count', '3': 13, '4': 1, '5': 5, '10': 'paymentCount'},
    const {'1': 'members_count', '3': 14, '4': 1, '5': 5, '10': 'membersCount'},
    const {'1': 'pending_members_count', '3': 15, '4': 1, '5': 5, '10': 'pendingMembersCount'},
    const {'1': 'partial_members_count', '3': 16, '4': 1, '5': 5, '10': 'partialMembersCount'},
    const {'1': 'close_reason', '3': 17, '4': 1, '5': 9, '10': 'closeReason'},
    const {'1': 'currency', '3': 18, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `ContributionCycleSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionCycleSummaryDescriptor = $convert.base64Decode('ChhDb250cmlidXRpb25DeWNsZVN1bW1hcnkSDgoCaWQYASABKAlSAmlkEicKD2NvbnRyaWJ1dGlvbl9pZBgCIAEoCVIOY29udHJpYnV0aW9uSWQSHwoLY3ljbGVfaW5kZXgYAyABKAVSCmN5Y2xlSW5kZXgSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSOQoKc3RhcnRlZF9hdBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0ZWRBdBI1CghlbmRlZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZGVkQXQSIwoNdGFyZ2V0X2Ftb3VudBgHIAEoBFIMdGFyZ2V0QW1vdW50EiMKDXJhaXNlZF9hbW91bnQYCCABKARSDHJhaXNlZEFtb3VudBIlCg5kZWZpY2l0X2Ftb3VudBgJIAEoBFINZGVmaWNpdEFtb3VudBIyChVwYXlvdXRfdHJhbnNhY3Rpb25faWQYCiABKAlSE3BheW91dFRyYW5zYWN0aW9uSWQSKAoQcmVjZWl2ZXJfdXNlcl9pZBgLIAEoCVIOcmVjZWl2ZXJVc2VySWQSIwoNcmVjZWl2ZXJfbmFtZRgMIAEoCVIMcmVjZWl2ZXJOYW1lEiMKDXBheW1lbnRfY291bnQYDSABKAVSDHBheW1lbnRDb3VudBIjCg1tZW1iZXJzX2NvdW50GA4gASgFUgxtZW1iZXJzQ291bnQSMgoVcGVuZGluZ19tZW1iZXJzX2NvdW50GA8gASgFUhNwZW5kaW5nTWVtYmVyc0NvdW50EjIKFXBhcnRpYWxfbWVtYmVyc19jb3VudBgQIAEoBVITcGFydGlhbE1lbWJlcnNDb3VudBIhCgxjbG9zZV9yZWFzb24YESABKAlSC2Nsb3NlUmVhc29uEhoKCGN1cnJlbmN5GBIgASgJUghjdXJyZW5jeQ==');
@$core.Deprecated('Use contributionCycleMemberSnapshotDescriptor instead')
const ContributionCycleMemberSnapshot$json = const {
  '1': 'ContributionCycleMemberSnapshot',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_name', '3': 2, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'expected_amount', '3': 4, '4': 1, '5': 4, '10': 'expectedAmount'},
    const {'1': 'paid_amount', '3': 5, '4': 1, '5': 4, '10': 'paidAmount'},
    const {'1': 'has_paid', '3': 6, '4': 1, '5': 8, '10': 'hasPaid'},
    const {'1': 'was_receiver', '3': 7, '4': 1, '5': 8, '10': 'wasReceiver'},
    const {'1': 'missed_cycles_at_close', '3': 8, '4': 1, '5': 5, '10': 'missedCyclesAtClose'},
    const {'1': 'status_at_close', '3': 9, '4': 1, '5': 9, '10': 'statusAtClose'},
    const {'1': 'joined_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'joinedAt'},
  ],
};

/// Descriptor for `ContributionCycleMemberSnapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionCycleMemberSnapshotDescriptor = $convert.base64Decode('Ch9Db250cmlidXRpb25DeWNsZU1lbWJlclNuYXBzaG90EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgl1c2VyX25hbWUYAiABKAlSCHVzZXJOYW1lEhQKBWVtYWlsGAMgASgJUgVlbWFpbBInCg9leHBlY3RlZF9hbW91bnQYBCABKARSDmV4cGVjdGVkQW1vdW50Eh8KC3BhaWRfYW1vdW50GAUgASgEUgpwYWlkQW1vdW50EhkKCGhhc19wYWlkGAYgASgIUgdoYXNQYWlkEiEKDHdhc19yZWNlaXZlchgHIAEoCFILd2FzUmVjZWl2ZXISMwoWbWlzc2VkX2N5Y2xlc19hdF9jbG9zZRgIIAEoBVITbWlzc2VkQ3ljbGVzQXRDbG9zZRImCg9zdGF0dXNfYXRfY2xvc2UYCSABKAlSDXN0YXR1c0F0Q2xvc2USNwoJam9pbmVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIam9pbmVkQXQ=');
@$core.Deprecated('Use contributionCycleDetailsDescriptor instead')
const ContributionCycleDetails$json = const {
  '1': 'ContributionCycleDetails',
  '2': const [
    const {'1': 'summary', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionCycleSummary', '10': 'summary'},
    const {'1': 'members', '3': 2, '4': 3, '5': 11, '6': '.group_accounts.ContributionCycleMemberSnapshot', '10': 'members'},
    const {'1': 'payments', '3': 3, '4': 3, '5': 11, '6': '.group_accounts.ContributionPaymentMessage', '10': 'payments'},
  ],
};

/// Descriptor for `ContributionCycleDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionCycleDetailsDescriptor = $convert.base64Decode('ChhDb250cmlidXRpb25DeWNsZURldGFpbHMSQgoHc3VtbWFyeRgBIAEoCzIoLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvbkN5Y2xlU3VtbWFyeVIHc3VtbWFyeRJJCgdtZW1iZXJzGAIgAygLMi8uZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uQ3ljbGVNZW1iZXJTbmFwc2hvdFIHbWVtYmVycxJGCghwYXltZW50cxgDIAMoCzIqLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvblBheW1lbnRNZXNzYWdlUghwYXltZW50cw==');
@$core.Deprecated('Use listContributionCyclesRequestDescriptor instead')
const ListContributionCyclesRequest$json = const {
  '1': 'ListContributionCyclesRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'include_in_progress', '3': 2, '4': 1, '5': 8, '10': 'includeInProgress'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListContributionCyclesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listContributionCyclesRequestDescriptor = $convert.base64Decode('Ch1MaXN0Q29udHJpYnV0aW9uQ3ljbGVzUmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklkEi4KE2luY2x1ZGVfaW5fcHJvZ3Jlc3MYAiABKAhSEWluY2x1ZGVJblByb2dyZXNzEhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');
@$core.Deprecated('Use listContributionCyclesResponseDescriptor instead')
const ListContributionCyclesResponse$json = const {
  '1': 'ListContributionCyclesResponse',
  '2': const [
    const {'1': 'cycles', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.ContributionCycleSummary', '10': 'cycles'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'current_page', '3': 3, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'items_per_page', '3': 5, '4': 1, '5': 5, '10': 'itemsPerPage'},
  ],
};

/// Descriptor for `ListContributionCyclesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listContributionCyclesResponseDescriptor = $convert.base64Decode('Ch5MaXN0Q29udHJpYnV0aW9uQ3ljbGVzUmVzcG9uc2USQAoGY3ljbGVzGAEgAygLMiguZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uQ3ljbGVTdW1tYXJ5UgZjeWNsZXMSHwoLdG90YWxfY291bnQYAiABKAVSCnRvdGFsQ291bnQSIQoMY3VycmVudF9wYWdlGAMgASgFUgtjdXJyZW50UGFnZRIfCgt0b3RhbF9wYWdlcxgEIAEoBVIKdG90YWxQYWdlcxIkCg5pdGVtc19wZXJfcGFnZRgFIAEoBVIMaXRlbXNQZXJQYWdl');
@$core.Deprecated('Use getContributionCycleDetailsRequestDescriptor instead')
const GetContributionCycleDetailsRequest$json = const {
  '1': 'GetContributionCycleDetailsRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'cycle_index', '3': 2, '4': 1, '5': 5, '10': 'cycleIndex'},
  ],
};

/// Descriptor for `GetContributionCycleDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionCycleDetailsRequestDescriptor = $convert.base64Decode('CiJHZXRDb250cmlidXRpb25DeWNsZURldGFpbHNSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQSHwoLY3ljbGVfaW5kZXgYAiABKAVSCmN5Y2xlSW5kZXg=');
@$core.Deprecated('Use getContributionCycleDetailsResponseDescriptor instead')
const GetContributionCycleDetailsResponse$json = const {
  '1': 'GetContributionCycleDetailsResponse',
  '2': const [
    const {'1': 'details', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionCycleDetails', '10': 'details'},
  ],
};

/// Descriptor for `GetContributionCycleDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionCycleDetailsResponseDescriptor = $convert.base64Decode('CiNHZXRDb250cmlidXRpb25DeWNsZURldGFpbHNSZXNwb25zZRJCCgdkZXRhaWxzGAEgASgLMiguZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uQ3ljbGVEZXRhaWxzUgdkZXRhaWxz');
@$core.Deprecated('Use restartContributionRequestDescriptor instead')
const RestartContributionRequest$json = const {
  '1': 'RestartContributionRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'new_target_amount', '3': 2, '4': 1, '5': 4, '10': 'newTargetAmount'},
    const {'1': 'new_deadline', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'newDeadline'},
    const {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RestartContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restartContributionRequestDescriptor = $convert.base64Decode('ChpSZXN0YXJ0Q29udHJpYnV0aW9uUmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklkEioKEW5ld190YXJnZXRfYW1vdW50GAIgASgEUg9uZXdUYXJnZXRBbW91bnQSPQoMbmV3X2RlYWRsaW5lGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbmV3RGVhZGxpbmUSFgoGcmVhc29uGAQgASgJUgZyZWFzb24=');
@$core.Deprecated('Use restartContributionResponseDescriptor instead')
const RestartContributionResponse$json = const {
  '1': 'RestartContributionResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contribution'},
    const {'1': 'cycles_completed', '3': 2, '4': 1, '5': 5, '10': 'cyclesCompleted'},
    const {'1': 'new_current_cycle', '3': 3, '4': 1, '5': 5, '10': 'newCurrentCycle'},
  ],
};

/// Descriptor for `RestartContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restartContributionResponseDescriptor = $convert.base64Decode('ChtSZXN0YXJ0Q29udHJpYnV0aW9uUmVzcG9uc2USRwoMY29udHJpYnV0aW9uGAEgASgLMiMuZ3JvdXBfYWNjb3VudHMuQ29udHJpYnV0aW9uTWVzc2FnZVIMY29udHJpYnV0aW9uEikKEGN5Y2xlc19jb21wbGV0ZWQYAiABKAVSD2N5Y2xlc0NvbXBsZXRlZBIqChFuZXdfY3VycmVudF9jeWNsZRgDIAEoBVIPbmV3Q3VycmVudEN5Y2xl');
@$core.Deprecated('Use contributionMessageProtoDescriptor instead')
const ContributionMessageProto$json = const {
  '1': 'ContributionMessageProto',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'sender_id', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'sender_name', '3': 4, '4': 1, '5': 9, '10': 'senderName'},
    const {'1': 'kind', '3': 5, '4': 1, '5': 9, '10': 'kind'},
    const {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    const {'1': 'media_url', '3': 7, '4': 1, '5': 9, '10': 'mediaUrl'},
    const {'1': 'duration_ms', '3': 8, '4': 1, '5': 5, '10': 'durationMs'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `ContributionMessageProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionMessageProtoDescriptor = $convert.base64Decode('ChhDb250cmlidXRpb25NZXNzYWdlUHJvdG8SDgoCaWQYASABKAlSAmlkEicKD2NvbnRyaWJ1dGlvbl9pZBgCIAEoCVIOY29udHJpYnV0aW9uSWQSGwoJc2VuZGVyX2lkGAMgASgJUghzZW5kZXJJZBIfCgtzZW5kZXJfbmFtZRgEIAEoCVIKc2VuZGVyTmFtZRISCgRraW5kGAUgASgJUgRraW5kEhIKBGJvZHkYBiABKAlSBGJvZHkSGwoJbWVkaWFfdXJsGAcgASgJUghtZWRpYVVybBIfCgtkdXJhdGlvbl9tcxgIIAEoBVIKZHVyYXRpb25NcxIdCgpjcmVhdGVkX2F0GAkgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use sendContributionMessageRequestDescriptor instead')
const SendContributionMessageRequest$json = const {
  '1': 'SendContributionMessageRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    const {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
    const {'1': 'media_url', '3': 4, '4': 1, '5': 9, '10': 'mediaUrl'},
    const {'1': 'duration_ms', '3': 5, '4': 1, '5': 5, '10': 'durationMs'},
  ],
};

/// Descriptor for `SendContributionMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendContributionMessageRequestDescriptor = $convert.base64Decode('Ch5TZW5kQ29udHJpYnV0aW9uTWVzc2FnZVJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZBISCgRraW5kGAIgASgJUgRraW5kEhIKBGJvZHkYAyABKAlSBGJvZHkSGwoJbWVkaWFfdXJsGAQgASgJUghtZWRpYVVybBIfCgtkdXJhdGlvbl9tcxgFIAEoBVIKZHVyYXRpb25Ncw==');
@$core.Deprecated('Use sendContributionMessageResponseDescriptor instead')
const SendContributionMessageResponse$json = const {
  '1': 'SendContributionMessageResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.ContributionMessageProto', '10': 'message'},
  ],
};

/// Descriptor for `SendContributionMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendContributionMessageResponseDescriptor = $convert.base64Decode('Ch9TZW5kQ29udHJpYnV0aW9uTWVzc2FnZVJlc3BvbnNlEkIKB21lc3NhZ2UYASABKAsyKC5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25NZXNzYWdlUHJvdG9SB21lc3NhZ2U=');
@$core.Deprecated('Use listContributionMessagesRequestDescriptor instead')
const ListContributionMessagesRequest$json = const {
  '1': 'ListContributionMessagesRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'since_rfc3339', '3': 2, '4': 1, '5': 9, '10': 'sinceRfc3339'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListContributionMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listContributionMessagesRequestDescriptor = $convert.base64Decode('Ch9MaXN0Q29udHJpYnV0aW9uTWVzc2FnZXNSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQSIwoNc2luY2VfcmZjMzMzORgCIAEoCVIMc2luY2VSZmMzMzM5EhQKBWxpbWl0GAMgASgFUgVsaW1pdA==');
@$core.Deprecated('Use listContributionMessagesResponseDescriptor instead')
const ListContributionMessagesResponse$json = const {
  '1': 'ListContributionMessagesResponse',
  '2': const [
    const {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.ContributionMessageProto', '10': 'messages'},
  ],
};

/// Descriptor for `ListContributionMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listContributionMessagesResponseDescriptor = $convert.base64Decode('CiBMaXN0Q29udHJpYnV0aW9uTWVzc2FnZXNSZXNwb25zZRJECghtZXNzYWdlcxgBIAMoCzIoLmdyb3VwX2FjY291bnRzLkNvbnRyaWJ1dGlvbk1lc3NhZ2VQcm90b1IIbWVzc2FnZXM=');
@$core.Deprecated('Use getGroupStatisticsRequestDescriptor instead')
const GetGroupStatisticsRequest$json = const {
  '1': 'GetGroupStatisticsRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupStatisticsRequestDescriptor = $convert.base64Decode('ChlHZXRHcm91cFN0YXRpc3RpY3NSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');
@$core.Deprecated('Use getGroupStatisticsResponseDescriptor instead')
const GetGroupStatisticsResponse$json = const {
  '1': 'GetGroupStatisticsResponse',
  '2': const [
    const {'1': 'member_count', '3': 1, '4': 1, '5': 5, '10': 'memberCount'},
    const {'1': 'total_contributions', '3': 2, '4': 1, '5': 5, '10': 'totalContributions'},
    const {'1': 'completed_contributions', '3': 3, '4': 1, '5': 5, '10': 'completedContributions'},
    const {'1': 'active_contributions', '3': 4, '4': 1, '5': 5, '10': 'activeContributions'},
    const {'1': 'total_target_amount', '3': 5, '4': 1, '5': 4, '10': 'totalTargetAmount'},
    const {'1': 'total_current_amount', '3': 6, '4': 1, '5': 4, '10': 'totalCurrentAmount'},
    const {'1': 'completion_rate', '3': 7, '4': 1, '5': 1, '10': 'completionRate'},
  ],
};

/// Descriptor for `GetGroupStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupStatisticsResponseDescriptor = $convert.base64Decode('ChpHZXRHcm91cFN0YXRpc3RpY3NSZXNwb25zZRIhCgxtZW1iZXJfY291bnQYASABKAVSC21lbWJlckNvdW50Ei8KE3RvdGFsX2NvbnRyaWJ1dGlvbnMYAiABKAVSEnRvdGFsQ29udHJpYnV0aW9ucxI3Chdjb21wbGV0ZWRfY29udHJpYnV0aW9ucxgDIAEoBVIWY29tcGxldGVkQ29udHJpYnV0aW9ucxIxChRhY3RpdmVfY29udHJpYnV0aW9ucxgEIAEoBVITYWN0aXZlQ29udHJpYnV0aW9ucxIuChN0b3RhbF90YXJnZXRfYW1vdW50GAUgASgEUhF0b3RhbFRhcmdldEFtb3VudBIwChR0b3RhbF9jdXJyZW50X2Ftb3VudBgGIAEoBFISdG90YWxDdXJyZW50QW1vdW50EicKD2NvbXBsZXRpb25fcmF0ZRgHIAEoAVIOY29tcGxldGlvblJhdGU=');
@$core.Deprecated('Use getUserContributionStatsRequestDescriptor instead')
const GetUserContributionStatsRequest$json = const {
  '1': 'GetUserContributionStatsRequest',
};

/// Descriptor for `GetUserContributionStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionStatsRequestDescriptor = $convert.base64Decode('Ch9HZXRVc2VyQ29udHJpYnV0aW9uU3RhdHNSZXF1ZXN0');
@$core.Deprecated('Use getUserContributionStatsResponseDescriptor instead')
const GetUserContributionStatsResponse$json = const {
  '1': 'GetUserContributionStatsResponse',
  '2': const [
    const {'1': 'total_payments', '3': 1, '4': 1, '5': 5, '10': 'totalPayments'},
    const {'1': 'total_amount', '3': 2, '4': 1, '5': 4, '10': 'totalAmount'},
    const {'1': 'groups_count', '3': 3, '4': 1, '5': 5, '10': 'groupsCount'},
    const {'1': 'average_payment', '3': 4, '4': 1, '5': 1, '10': 'averagePayment'},
  ],
};

/// Descriptor for `GetUserContributionStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionStatsResponseDescriptor = $convert.base64Decode('CiBHZXRVc2VyQ29udHJpYnV0aW9uU3RhdHNSZXNwb25zZRIlCg50b3RhbF9wYXltZW50cxgBIAEoBVINdG90YWxQYXltZW50cxIhCgx0b3RhbF9hbW91bnQYAiABKARSC3RvdGFsQW1vdW50EiEKDGdyb3Vwc19jb3VudBgDIAEoBVILZ3JvdXBzQ291bnQSJwoPYXZlcmFnZV9wYXltZW50GAQgASgBUg5hdmVyYWdlUGF5bWVudA==');
@$core.Deprecated('Use getOverdueContributionsRequestDescriptor instead')
const GetOverdueContributionsRequest$json = const {
  '1': 'GetOverdueContributionsRequest',
};

/// Descriptor for `GetOverdueContributionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueContributionsRequestDescriptor = $convert.base64Decode('Ch5HZXRPdmVyZHVlQ29udHJpYnV0aW9uc1JlcXVlc3Q=');
@$core.Deprecated('Use getOverdueContributionsResponseDescriptor instead')
const GetOverdueContributionsResponse$json = const {
  '1': 'GetOverdueContributionsResponse',
  '2': const [
    const {'1': 'contributions', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.ContributionMessage', '10': 'contributions'},
  ],
};

/// Descriptor for `GetOverdueContributionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueContributionsResponseDescriptor = $convert.base64Decode('Ch9HZXRPdmVyZHVlQ29udHJpYnV0aW9uc1Jlc3BvbnNlEkkKDWNvbnRyaWJ1dGlvbnMYASADKAsyIy5ncm91cF9hY2NvdW50cy5Db250cmlidXRpb25NZXNzYWdlUg1jb250cmlidXRpb25z');
@$core.Deprecated('Use getContributionAnalyticsRequestDescriptor instead')
const GetContributionAnalyticsRequest$json = const {
  '1': 'GetContributionAnalyticsRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GetContributionAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionAnalyticsRequestDescriptor = $convert.base64Decode('Ch9HZXRDb250cmlidXRpb25BbmFseXRpY3NSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQ=');
@$core.Deprecated('Use getContributionAnalyticsResponseDescriptor instead')
const GetContributionAnalyticsResponse$json = const {
  '1': 'GetContributionAnalyticsResponse',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'progress_percentage', '3': 3, '4': 1, '5': 1, '10': 'progressPercentage'},
    const {'1': 'total_payments', '3': 4, '4': 1, '5': 5, '10': 'totalPayments'},
    const {'1': 'average_payment', '3': 5, '4': 1, '5': 1, '10': 'averagePayment'},
    const {'1': 'current_amount', '3': 6, '4': 1, '5': 4, '10': 'currentAmount'},
    const {'1': 'target_amount', '3': 7, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'member_participation', '3': 8, '4': 1, '5': 11, '6': '.group_accounts.GetContributionAnalyticsResponse.MemberParticipation', '10': 'memberParticipation'},
    const {'1': 'schedule', '3': 9, '4': 1, '5': 11, '6': '.group_accounts.GetContributionAnalyticsResponse.Schedule', '10': 'schedule'},
    const {'1': 'payout', '3': 10, '4': 1, '5': 11, '6': '.group_accounts.GetContributionAnalyticsResponse.Payout', '10': 'payout'},
    const {'1': 'member_stats', '3': 11, '4': 1, '5': 9, '10': 'memberStats'},
  ],
  '3': const [GetContributionAnalyticsResponse_MemberParticipation$json, GetContributionAnalyticsResponse_Schedule$json, GetContributionAnalyticsResponse_Payout$json],
};

@$core.Deprecated('Use getContributionAnalyticsResponseDescriptor instead')
const GetContributionAnalyticsResponse_MemberParticipation$json = const {
  '1': 'MemberParticipation',
  '2': const [
    const {'1': 'total_members', '3': 1, '4': 1, '5': 5, '10': 'totalMembers'},
    const {'1': 'participating_members', '3': 2, '4': 1, '5': 5, '10': 'participatingMembers'},
    const {'1': 'participation_rate', '3': 3, '4': 1, '5': 1, '10': 'participationRate'},
  ],
};

@$core.Deprecated('Use getContributionAnalyticsResponseDescriptor instead')
const GetContributionAnalyticsResponse_Schedule$json = const {
  '1': 'Schedule',
  '2': const [
    const {'1': 'is_on_schedule', '3': 1, '4': 1, '5': 8, '10': 'isOnSchedule'},
    const {'1': 'days_behind_schedule', '3': 2, '4': 1, '5': 5, '10': 'daysBehindSchedule'},
    const {'1': 'next_payment_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPaymentDate'},
    const {'1': 'current_cycle', '3': 4, '4': 1, '5': 5, '10': 'currentCycle'},
    const {'1': 'total_cycles', '3': 5, '4': 1, '5': 5, '10': 'totalCycles'},
  ],
};

@$core.Deprecated('Use getContributionAnalyticsResponseDescriptor instead')
const GetContributionAnalyticsResponse_Payout$json = const {
  '1': 'Payout',
  '2': const [
    const {'1': 'current_recipient', '3': 1, '4': 1, '5': 9, '10': 'currentRecipient'},
    const {'1': 'next_payout_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPayoutDate'},
    const {'1': 'completed_payouts', '3': 3, '4': 1, '5': 5, '10': 'completedPayouts'},
    const {'1': 'pending_payouts', '3': 4, '4': 1, '5': 5, '10': 'pendingPayouts'},
  ],
};

/// Descriptor for `GetContributionAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionAnalyticsResponseDescriptor = $convert.base64Decode('CiBHZXRDb250cmlidXRpb25BbmFseXRpY3NSZXNwb25zZRInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklkEhIKBHR5cGUYAiABKAlSBHR5cGUSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgDIAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdlEiUKDnRvdGFsX3BheW1lbnRzGAQgASgFUg10b3RhbFBheW1lbnRzEicKD2F2ZXJhZ2VfcGF5bWVudBgFIAEoAVIOYXZlcmFnZVBheW1lbnQSJQoOY3VycmVudF9hbW91bnQYBiABKARSDWN1cnJlbnRBbW91bnQSIwoNdGFyZ2V0X2Ftb3VudBgHIAEoBFIMdGFyZ2V0QW1vdW50EncKFG1lbWJlcl9wYXJ0aWNpcGF0aW9uGAggASgLMkQuZ3JvdXBfYWNjb3VudHMuR2V0Q29udHJpYnV0aW9uQW5hbHl0aWNzUmVzcG9uc2UuTWVtYmVyUGFydGljaXBhdGlvblITbWVtYmVyUGFydGljaXBhdGlvbhJVCghzY2hlZHVsZRgJIAEoCzI5Lmdyb3VwX2FjY291bnRzLkdldENvbnRyaWJ1dGlvbkFuYWx5dGljc1Jlc3BvbnNlLlNjaGVkdWxlUghzY2hlZHVsZRJPCgZwYXlvdXQYCiABKAsyNy5ncm91cF9hY2NvdW50cy5HZXRDb250cmlidXRpb25BbmFseXRpY3NSZXNwb25zZS5QYXlvdXRSBnBheW91dBIhCgxtZW1iZXJfc3RhdHMYCyABKAlSC21lbWJlclN0YXRzGp4BChNNZW1iZXJQYXJ0aWNpcGF0aW9uEiMKDXRvdGFsX21lbWJlcnMYASABKAVSDHRvdGFsTWVtYmVycxIzChVwYXJ0aWNpcGF0aW5nX21lbWJlcnMYAiABKAVSFHBhcnRpY2lwYXRpbmdNZW1iZXJzEi0KEnBhcnRpY2lwYXRpb25fcmF0ZRgDIAEoAVIRcGFydGljaXBhdGlvblJhdGUa8gEKCFNjaGVkdWxlEiQKDmlzX29uX3NjaGVkdWxlGAEgASgIUgxpc09uU2NoZWR1bGUSMAoUZGF5c19iZWhpbmRfc2NoZWR1bGUYAiABKAVSEmRheXNCZWhpbmRTY2hlZHVsZRJGChFuZXh0X3BheW1lbnRfZGF0ZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD25leHRQYXltZW50RGF0ZRIjCg1jdXJyZW50X2N5Y2xlGAQgASgFUgxjdXJyZW50Q3ljbGUSIQoMdG90YWxfY3ljbGVzGAUgASgFUgt0b3RhbEN5Y2xlcxrRAQoGUGF5b3V0EisKEWN1cnJlbnRfcmVjaXBpZW50GAEgASgJUhBjdXJyZW50UmVjaXBpZW50EkQKEG5leHRfcGF5b3V0X2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg5uZXh0UGF5b3V0RGF0ZRIrChFjb21wbGV0ZWRfcGF5b3V0cxgDIAEoBVIQY29tcGxldGVkUGF5b3V0cxInCg9wZW5kaW5nX3BheW91dHMYBCABKAVSDnBlbmRpbmdQYXlvdXRz');
@$core.Deprecated('Use listPublicGroupsRequestDescriptor instead')
const ListPublicGroupsRequest$json = const {
  '1': 'ListPublicGroupsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'sort_by', '3': 3, '4': 1, '5': 9, '10': 'sortBy'},
    const {'1': 'search_query', '3': 4, '4': 1, '5': 9, '10': 'searchQuery'},
  ],
};

/// Descriptor for `ListPublicGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPublicGroupsRequestDescriptor = $convert.base64Decode('ChdMaXN0UHVibGljR3JvdXBzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSFwoHc29ydF9ieRgDIAEoCVIGc29ydEJ5EiEKDHNlYXJjaF9xdWVyeRgEIAEoCVILc2VhcmNoUXVlcnk=');
@$core.Deprecated('Use listPublicGroupsResponseDescriptor instead')
const ListPublicGroupsResponse$json = const {
  '1': 'ListPublicGroupsResponse',
  '2': const [
    const {'1': 'groups', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.GroupAccountMessage', '10': 'groups'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.GroupPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListPublicGroupsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPublicGroupsResponseDescriptor = $convert.base64Decode('ChhMaXN0UHVibGljR3JvdXBzUmVzcG9uc2USOwoGZ3JvdXBzGAEgAygLMiMuZ3JvdXBfYWNjb3VudHMuR3JvdXBBY2NvdW50TWVzc2FnZVIGZ3JvdXBzEkMKCnBhZ2luYXRpb24YAiABKAsyIy5ncm91cF9hY2NvdW50cy5Hcm91cFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getPublicGroupRequestDescriptor instead')
const GetPublicGroupRequest$json = const {
  '1': 'GetPublicGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetPublicGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPublicGroupRequestDescriptor = $convert.base64Decode('ChVHZXRQdWJsaWNHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQ=');
@$core.Deprecated('Use publicGroupContributorDescriptor instead')
const PublicGroupContributor$json = const {
  '1': 'PublicGroupContributor',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'profile_image', '3': 3, '4': 1, '5': 9, '10': 'profileImage'},
    const {'1': 'total_contributed', '3': 4, '4': 1, '5': 4, '10': 'totalContributed'},
    const {'1': 'contribution_count', '3': 5, '4': 1, '5': 5, '10': 'contributionCount'},
  ],
};

/// Descriptor for `PublicGroupContributor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicGroupContributorDescriptor = $convert.base64Decode('ChZQdWJsaWNHcm91cENvbnRyaWJ1dG9yEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIhCgxkaXNwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEiMKDXByb2ZpbGVfaW1hZ2UYAyABKAlSDHByb2ZpbGVJbWFnZRIrChF0b3RhbF9jb250cmlidXRlZBgEIAEoBFIQdG90YWxDb250cmlidXRlZBItChJjb250cmlidXRpb25fY291bnQYBSABKAVSEWNvbnRyaWJ1dGlvbkNvdW50');
@$core.Deprecated('Use getPublicGroupResponseDescriptor instead')
const GetPublicGroupResponse$json = const {
  '1': 'GetPublicGroupResponse',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupAccountMessage', '10': 'group'},
    const {'1': 'statistics', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.GetGroupStatisticsResponse', '10': 'statistics'},
    const {'1': 'top_contributors', '3': 3, '4': 3, '5': 11, '6': '.group_accounts.PublicGroupContributor', '10': 'topContributors'},
    const {'1': 'is_member', '3': 4, '4': 1, '5': 8, '10': 'isMember'},
  ],
};

/// Descriptor for `GetPublicGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPublicGroupResponseDescriptor = $convert.base64Decode('ChZHZXRQdWJsaWNHcm91cFJlc3BvbnNlEjkKBWdyb3VwGAEgASgLMiMuZ3JvdXBfYWNjb3VudHMuR3JvdXBBY2NvdW50TWVzc2FnZVIFZ3JvdXASSgoKc3RhdGlzdGljcxgCIAEoCzIqLmdyb3VwX2FjY291bnRzLkdldEdyb3VwU3RhdGlzdGljc1Jlc3BvbnNlUgpzdGF0aXN0aWNzElEKEHRvcF9jb250cmlidXRvcnMYAyADKAsyJi5ncm91cF9hY2NvdW50cy5QdWJsaWNHcm91cENvbnRyaWJ1dG9yUg90b3BDb250cmlidXRvcnMSGwoJaXNfbWVtYmVyGAQgASgIUghpc01lbWJlcg==');
@$core.Deprecated('Use joinPublicGroupRequestDescriptor instead')
const JoinPublicGroupRequest$json = const {
  '1': 'JoinPublicGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `JoinPublicGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinPublicGroupRequestDescriptor = $convert.base64Decode('ChZKb2luUHVibGljR3JvdXBSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');
@$core.Deprecated('Use joinPublicGroupResponseDescriptor instead')
const JoinPublicGroupResponse$json = const {
  '1': 'JoinPublicGroupResponse',
  '2': const [
    const {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.group_accounts.GroupMemberMessage', '10': 'member'},
    const {'1': 'group', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.GroupAccountMessage', '10': 'group'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `JoinPublicGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinPublicGroupResponseDescriptor = $convert.base64Decode('ChdKb2luUHVibGljR3JvdXBSZXNwb25zZRI6CgZtZW1iZXIYASABKAsyIi5ncm91cF9hY2NvdW50cy5Hcm91cE1lbWJlck1lc3NhZ2VSBm1lbWJlchI5CgVncm91cBgCIAEoCzIjLmdyb3VwX2FjY291bnRzLkdyb3VwQWNjb3VudE1lc3NhZ2VSBWdyb3VwEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use groupPaginationInfoDescriptor instead')
const GroupPaginationInfo$json = const {
  '1': 'GroupPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `GroupPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupPaginationInfoDescriptor = $convert.base64Decode('ChNHcm91cFBhZ2luYXRpb25JbmZvEiEKDGN1cnJlbnRfcGFnZRgBIAEoBVILY3VycmVudFBhZ2USHwoLdG90YWxfcGFnZXMYAiABKAVSCnRvdGFsUGFnZXMSHwoLdG90YWxfaXRlbXMYAyABKAVSCnRvdGFsSXRlbXMSJAoOaXRlbXNfcGVyX3BhZ2UYBCABKAVSDGl0ZW1zUGVyUGFnZRIZCghoYXNfbmV4dBgFIAEoCFIHaGFzTmV4dBIZCghoYXNfcHJldhgGIAEoCFIHaGFzUHJldg==');
@$core.Deprecated('Use contributionPaginationInfoDescriptor instead')
const ContributionPaginationInfo$json = const {
  '1': 'ContributionPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `ContributionPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionPaginationInfoDescriptor = $convert.base64Decode('ChpDb250cmlidXRpb25QYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYWdlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMgASgFUgp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQoIaGFzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');
@$core.Deprecated('Use paymentPaginationInfoDescriptor instead')
const PaymentPaginationInfo$json = const {
  '1': 'PaymentPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `PaymentPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentPaginationInfoDescriptor = $convert.base64Decode('ChVQYXltZW50UGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UGFnZRIfCgt0b3RhbF9wYWdlcxgCIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9pdGVtcxgDIAEoBVIKdG90YWxJdGVtcxIkCg5pdGVtc19wZXJfcGFnZRgEIAEoBVIMaXRlbXNQZXJQYWdlEhkKCGhhc19uZXh0GAUgASgIUgdoYXNOZXh0EhkKCGhhc19wcmV2GAYgASgIUgdoYXNQcmV2');
@$core.Deprecated('Use receiptPaginationInfoDescriptor instead')
const ReceiptPaginationInfo$json = const {
  '1': 'ReceiptPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `ReceiptPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiptPaginationInfoDescriptor = $convert.base64Decode('ChVSZWNlaXB0UGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UGFnZRIfCgt0b3RhbF9wYWdlcxgCIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9pdGVtcxgDIAEoBVIKdG90YWxJdGVtcxIkCg5pdGVtc19wZXJfcGFnZRgEIAEoBVIMaXRlbXNQZXJQYWdlEhkKCGhhc19uZXh0GAUgASgIUgdoYXNOZXh0EhkKCGhhc19wcmV2GAYgASgIUgdoYXNQcmV2');
@$core.Deprecated('Use activityLogPaginationInfoDescriptor instead')
const ActivityLogPaginationInfo$json = const {
  '1': 'ActivityLogPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'has_more', '3': 4, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `ActivityLogPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activityLogPaginationInfoDescriptor = $convert.base64Decode('ChlBY3Rpdml0eUxvZ1BhZ2luYXRpb25JbmZvEiEKDGN1cnJlbnRfcGFnZRgBIAEoBVILY3VycmVudFBhZ2USHwoLdG90YWxfcGFnZXMYAiABKAVSCnRvdGFsUGFnZXMSHwoLdG90YWxfY291bnQYAyABKAVSCnRvdGFsQ291bnQSGQoIaGFzX21vcmUYBCABKAhSB2hhc01vcmU=');
@$core.Deprecated('Use groupActivityLogMessageDescriptor instead')
const GroupActivityLogMessage$json = const {
  '1': 'GroupActivityLogMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'contribution_id', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'contributionId', '17': true},
    const {'1': 'actor_user_id', '3': 4, '4': 1, '5': 9, '10': 'actorUserId'},
    const {'1': 'actor_name', '3': 5, '4': 1, '5': 9, '10': 'actorName'},
    const {'1': 'action_type', '3': 6, '4': 1, '5': 9, '10': 'actionType'},
    const {'1': 'target_type', '3': 7, '4': 1, '5': 9, '10': 'targetType'},
    const {'1': 'target_id', '3': 8, '4': 1, '5': 9, '9': 1, '10': 'targetId', '17': true},
    const {'1': 'details', '3': 9, '4': 1, '5': 9, '10': 'details'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
  '8': const [
    const {'1': '_contribution_id'},
    const {'1': '_target_id'},
  ],
};

/// Descriptor for `GroupActivityLogMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupActivityLogMessageDescriptor = $convert.base64Decode('ChdHcm91cEFjdGl2aXR5TG9nTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSGQoIZ3JvdXBfaWQYAiABKAlSB2dyb3VwSWQSLAoPY29udHJpYnV0aW9uX2lkGAMgASgJSABSDmNvbnRyaWJ1dGlvbklkiAEBEiIKDWFjdG9yX3VzZXJfaWQYBCABKAlSC2FjdG9yVXNlcklkEh0KCmFjdG9yX25hbWUYBSABKAlSCWFjdG9yTmFtZRIfCgthY3Rpb25fdHlwZRgGIAEoCVIKYWN0aW9uVHlwZRIfCgt0YXJnZXRfdHlwZRgHIAEoCVIKdGFyZ2V0VHlwZRIgCgl0YXJnZXRfaWQYCCABKAlIAVIIdGFyZ2V0SWSIAQESGAoHZGV0YWlscxgJIAEoCVIHZGV0YWlscxI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0QhIKEF9jb250cmlidXRpb25faWRCDAoKX3RhcmdldF9pZA==');
@$core.Deprecated('Use getGroupActivityLogsRequestDescriptor instead')
const GetGroupActivityLogsRequest$json = const {
  '1': 'GetGroupActivityLogsRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'action_type_filter', '3': 4, '4': 1, '5': 9, '10': 'actionTypeFilter'},
  ],
};

/// Descriptor for `GetGroupActivityLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupActivityLogsRequestDescriptor = $convert.base64Decode('ChtHZXRHcm91cEFjdGl2aXR5TG9nc1JlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXplEiwKEmFjdGlvbl90eXBlX2ZpbHRlchgEIAEoCVIQYWN0aW9uVHlwZUZpbHRlcg==');
@$core.Deprecated('Use getGroupActivityLogsResponseDescriptor instead')
const GetGroupActivityLogsResponse$json = const {
  '1': 'GetGroupActivityLogsResponse',
  '2': const [
    const {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.GroupActivityLogMessage', '10': 'logs'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.ActivityLogPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetGroupActivityLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupActivityLogsResponseDescriptor = $convert.base64Decode('ChxHZXRHcm91cEFjdGl2aXR5TG9nc1Jlc3BvbnNlEjsKBGxvZ3MYASADKAsyJy5ncm91cF9hY2NvdW50cy5Hcm91cEFjdGl2aXR5TG9nTWVzc2FnZVIEbG9ncxJJCgpwYWdpbmF0aW9uGAIgASgLMikuZ3JvdXBfYWNjb3VudHMuQWN0aXZpdHlMb2dQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');
@$core.Deprecated('Use getContributionActivityLogsRequestDescriptor instead')
const GetContributionActivityLogsRequest$json = const {
  '1': 'GetContributionActivityLogsRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetContributionActivityLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionActivityLogsRequestDescriptor = $convert.base64Decode('CiJHZXRDb250cmlidXRpb25BY3Rpdml0eUxvZ3NSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXpl');
@$core.Deprecated('Use getContributionActivityLogsResponseDescriptor instead')
const GetContributionActivityLogsResponse$json = const {
  '1': 'GetContributionActivityLogsResponse',
  '2': const [
    const {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.group_accounts.GroupActivityLogMessage', '10': 'logs'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.group_accounts.ActivityLogPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetContributionActivityLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionActivityLogsResponseDescriptor = $convert.base64Decode('CiNHZXRDb250cmlidXRpb25BY3Rpdml0eUxvZ3NSZXNwb25zZRI7CgRsb2dzGAEgAygLMicuZ3JvdXBfYWNjb3VudHMuR3JvdXBBY3Rpdml0eUxvZ01lc3NhZ2VSBGxvZ3MSSQoKcGFnaW5hdGlvbhgCIAEoCzIpLmdyb3VwX2FjY291bnRzLkFjdGl2aXR5TG9nUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');
