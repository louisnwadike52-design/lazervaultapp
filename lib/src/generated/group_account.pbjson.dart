//
//  Generated code. Do not modify.
//  source: group_account.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use groupAccountStatusDescriptor instead')
const GroupAccountStatus$json = {
  '1': 'GroupAccountStatus',
  '2': [
    {'1': 'GROUP_ACCOUNT_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'GROUP_ACCOUNT_STATUS_ACTIVE', '2': 1},
    {'1': 'GROUP_ACCOUNT_STATUS_SUSPENDED', '2': 2},
    {'1': 'GROUP_ACCOUNT_STATUS_CLOSED', '2': 3},
  ],
};

/// Descriptor for `GroupAccountStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupAccountStatusDescriptor = $convert.base64Decode(
    'ChJHcm91cEFjY291bnRTdGF0dXMSJAogR1JPVVBfQUNDT1VOVF9TVEFUVVNfVU5TUEVDSUZJRU'
    'QQABIfChtHUk9VUF9BQ0NPVU5UX1NUQVRVU19BQ1RJVkUQARIiCh5HUk9VUF9BQ0NPVU5UX1NU'
    'QVRVU19TVVNQRU5ERUQQAhIfChtHUk9VUF9BQ0NPVU5UX1NUQVRVU19DTE9TRUQQAw==');

@$core.Deprecated('Use groupMemberRoleDescriptor instead')
const GroupMemberRole$json = {
  '1': 'GroupMemberRole',
  '2': [
    {'1': 'GROUP_MEMBER_ROLE_UNSPECIFIED', '2': 0},
    {'1': 'GROUP_MEMBER_ROLE_ADMIN', '2': 1},
    {'1': 'GROUP_MEMBER_ROLE_MEMBER', '2': 2},
    {'1': 'GROUP_MEMBER_ROLE_VIEWER', '2': 3},
  ],
};

/// Descriptor for `GroupMemberRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupMemberRoleDescriptor = $convert.base64Decode(
    'Cg9Hcm91cE1lbWJlclJvbGUSIQodR1JPVVBfTUVNQkVSX1JPTEVfVU5TUEVDSUZJRUQQABIbCh'
    'dHUk9VUF9NRU1CRVJfUk9MRV9BRE1JThABEhwKGEdST1VQX01FTUJFUl9ST0xFX01FTUJFUhAC'
    'EhwKGEdST1VQX01FTUJFUl9ST0xFX1ZJRVdFUhAD');

@$core.Deprecated('Use groupMemberStatusDescriptor instead')
const GroupMemberStatus$json = {
  '1': 'GroupMemberStatus',
  '2': [
    {'1': 'GROUP_MEMBER_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'GROUP_MEMBER_STATUS_ACTIVE', '2': 1},
    {'1': 'GROUP_MEMBER_STATUS_INACTIVE', '2': 2},
    {'1': 'GROUP_MEMBER_STATUS_SUSPENDED', '2': 3},
    {'1': 'GROUP_MEMBER_STATUS_REMOVED', '2': 4},
  ],
};

/// Descriptor for `GroupMemberStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupMemberStatusDescriptor = $convert.base64Decode(
    'ChFHcm91cE1lbWJlclN0YXR1cxIjCh9HUk9VUF9NRU1CRVJfU1RBVFVTX1VOU1BFQ0lGSUVEEA'
    'ASHgoaR1JPVVBfTUVNQkVSX1NUQVRVU19BQ1RJVkUQARIgChxHUk9VUF9NRU1CRVJfU1RBVFVT'
    'X0lOQUNUSVZFEAISIQodR1JPVVBfTUVNQkVSX1NUQVRVU19TVVNQRU5ERUQQAxIfChtHUk9VUF'
    '9NRU1CRVJfU1RBVFVTX1JFTU9WRUQQBA==');

@$core.Deprecated('Use contributionTypeDescriptor instead')
const ContributionType$json = {
  '1': 'ContributionType',
  '2': [
    {'1': 'CONTRIBUTION_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'CONTRIBUTION_TYPE_ONE_TIME', '2': 1},
    {'1': 'CONTRIBUTION_TYPE_RECURRING', '2': 2},
    {'1': 'CONTRIBUTION_TYPE_ROTATING_SAVINGS', '2': 3},
  ],
};

/// Descriptor for `ContributionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contributionTypeDescriptor = $convert.base64Decode(
    'ChBDb250cmlidXRpb25UeXBlEiEKHUNPTlRSSUJVVElPTl9UWVBFX1VOU1BFQ0lGSUVEEAASHg'
    'oaQ09OVFJJQlVUSU9OX1RZUEVfT05FX1RJTUUQARIfChtDT05UUklCVVRJT05fVFlQRV9SRUNV'
    'UlJJTkcQAhImCiJDT05UUklCVVRJT05fVFlQRV9ST1RBVElOR19TQVZJTkdTEAM=');

@$core.Deprecated('Use contributionFrequencyDescriptor instead')
const ContributionFrequency$json = {
  '1': 'ContributionFrequency',
  '2': [
    {'1': 'CONTRIBUTION_FREQUENCY_UNSPECIFIED', '2': 0},
    {'1': 'CONTRIBUTION_FREQUENCY_DAILY', '2': 1},
    {'1': 'CONTRIBUTION_FREQUENCY_WEEKLY', '2': 2},
    {'1': 'CONTRIBUTION_FREQUENCY_BIWEEKLY', '2': 3},
    {'1': 'CONTRIBUTION_FREQUENCY_MONTHLY', '2': 4},
    {'1': 'CONTRIBUTION_FREQUENCY_QUARTERLY', '2': 5},
    {'1': 'CONTRIBUTION_FREQUENCY_YEARLY', '2': 6},
  ],
};

/// Descriptor for `ContributionFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contributionFrequencyDescriptor = $convert.base64Decode(
    'ChVDb250cmlidXRpb25GcmVxdWVuY3kSJgoiQ09OVFJJQlVUSU9OX0ZSRVFVRU5DWV9VTlNQRU'
    'NJRklFRBAAEiAKHENPTlRSSUJVVElPTl9GUkVRVUVOQ1lfREFJTFkQARIhCh1DT05UUklCVVRJ'
    'T05fRlJFUVVFTkNZX1dFRUtMWRACEiMKH0NPTlRSSUJVVElPTl9GUkVRVUVOQ1lfQklXRUVLTF'
    'kQAxIiCh5DT05UUklCVVRJT05fRlJFUVVFTkNZX01PTlRITFkQBBIkCiBDT05UUklCVVRJT05f'
    'RlJFUVVFTkNZX1FVQVJURVJMWRAFEiEKHUNPTlRSSUJVVElPTl9GUkVRVUVOQ1lfWUVBUkxZEA'
    'Y=');

@$core.Deprecated('Use contributionStatusDescriptor instead')
const ContributionStatus$json = {
  '1': 'ContributionStatus',
  '2': [
    {'1': 'CONTRIBUTION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'CONTRIBUTION_STATUS_ACTIVE', '2': 1},
    {'1': 'CONTRIBUTION_STATUS_PAUSED', '2': 2},
    {'1': 'CONTRIBUTION_STATUS_COMPLETED', '2': 3},
    {'1': 'CONTRIBUTION_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `ContributionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contributionStatusDescriptor = $convert.base64Decode(
    'ChJDb250cmlidXRpb25TdGF0dXMSIwofQ09OVFJJQlVUSU9OX1NUQVRVU19VTlNQRUNJRklFRB'
    'AAEh4KGkNPTlRSSUJVVElPTl9TVEFUVVNfQUNUSVZFEAESHgoaQ09OVFJJQlVUSU9OX1NUQVRV'
    'U19QQVVTRUQQAhIhCh1DT05UUklCVVRJT05fU1RBVFVTX0NPTVBMRVRFRBADEiEKHUNPTlRSSU'
    'JVVElPTl9TVEFUVVNfQ0FOQ0VMTEVEEAQ=');

@$core.Deprecated('Use paymentStatusDescriptor instead')
const PaymentStatus$json = {
  '1': 'PaymentStatus',
  '2': [
    {'1': 'PAYMENT_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'PAYMENT_STATUS_PENDING', '2': 1},
    {'1': 'PAYMENT_STATUS_PROCESSING', '2': 2},
    {'1': 'PAYMENT_STATUS_COMPLETED', '2': 3},
    {'1': 'PAYMENT_STATUS_FAILED', '2': 4},
    {'1': 'PAYMENT_STATUS_REFUNDED', '2': 5},
  ],
};

/// Descriptor for `PaymentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentStatusDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50U3RhdHVzEh4KGlBBWU1FTlRfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGgoWUEFZTU'
    'VOVF9TVEFUVVNfUEVORElORxABEh0KGVBBWU1FTlRfU1RBVFVTX1BST0NFU1NJTkcQAhIcChhQ'
    'QVlNRU5UX1NUQVRVU19DT01QTEVURUQQAxIZChVQQVlNRU5UX1NUQVRVU19GQUlMRUQQBBIbCh'
    'dQQVlNRU5UX1NUQVRVU19SRUZVTkRFRBAF');

@$core.Deprecated('Use payoutStatusDescriptor instead')
const PayoutStatus$json = {
  '1': 'PayoutStatus',
  '2': [
    {'1': 'PAYOUT_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'PAYOUT_STATUS_PENDING', '2': 1},
    {'1': 'PAYOUT_STATUS_COMPLETED', '2': 2},
    {'1': 'PAYOUT_STATUS_CANCELLED', '2': 3},
  ],
};

/// Descriptor for `PayoutStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payoutStatusDescriptor = $convert.base64Decode(
    'CgxQYXlvdXRTdGF0dXMSHQoZUEFZT1VUX1NUQVRVU19VTlNQRUNJRklFRBAAEhkKFVBBWU9VVF'
    '9TVEFUVVNfUEVORElORxABEhsKF1BBWU9VVF9TVEFUVVNfQ09NUExFVEVEEAISGwoXUEFZT1VU'
    'X1NUQVRVU19DQU5DRUxMRUQQAw==');

@$core.Deprecated('Use payoutTransactionStatusDescriptor instead')
const PayoutTransactionStatus$json = {
  '1': 'PayoutTransactionStatus',
  '2': [
    {'1': 'PAYOUT_TRANSACTION_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'PAYOUT_TRANSACTION_STATUS_PENDING', '2': 1},
    {'1': 'PAYOUT_TRANSACTION_STATUS_PROCESSING', '2': 2},
    {'1': 'PAYOUT_TRANSACTION_STATUS_COMPLETED', '2': 3},
    {'1': 'PAYOUT_TRANSACTION_STATUS_FAILED', '2': 4},
    {'1': 'PAYOUT_TRANSACTION_STATUS_REFUNDED', '2': 5},
  ],
};

/// Descriptor for `PayoutTransactionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payoutTransactionStatusDescriptor = $convert.base64Decode(
    'ChdQYXlvdXRUcmFuc2FjdGlvblN0YXR1cxIpCiVQQVlPVVRfVFJBTlNBQ1RJT05fU1RBVFVTX1'
    'VOU1BFQ0lGSUVEEAASJQohUEFZT1VUX1RSQU5TQUNUSU9OX1NUQVRVU19QRU5ESU5HEAESKAok'
    'UEFZT1VUX1RSQU5TQUNUSU9OX1NUQVRVU19QUk9DRVNTSU5HEAISJwojUEFZT1VUX1RSQU5TQU'
    'NUSU9OX1NUQVRVU19DT01QTEVURUQQAxIkCiBQQVlPVVRfVFJBTlNBQ1RJT05fU1RBVFVTX0ZB'
    'SUxFRBAEEiYKIlBBWU9VVF9UUkFOU0FDVElPTl9TVEFUVVNfUkVGVU5ERUQQBQ==');

@$core.Deprecated('Use groupVisibilityDescriptor instead')
const GroupVisibility$json = {
  '1': 'GroupVisibility',
  '2': [
    {'1': 'GROUP_VISIBILITY_UNSPECIFIED', '2': 0},
    {'1': 'GROUP_VISIBILITY_PRIVATE', '2': 1},
    {'1': 'GROUP_VISIBILITY_PUBLIC', '2': 2},
  ],
};

/// Descriptor for `GroupVisibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupVisibilityDescriptor = $convert.base64Decode(
    'Cg9Hcm91cFZpc2liaWxpdHkSIAocR1JPVVBfVklTSUJJTElUWV9VTlNQRUNJRklFRBAAEhwKGE'
    'dST1VQX1ZJU0lCSUxJVFlfUFJJVkFURRABEhsKF0dST1VQX1ZJU0lCSUxJVFlfUFVCTElDEAI=');

@$core.Deprecated('Use groupAccountMessageDescriptor instead')
const GroupAccountMessage$json = {
  '1': 'GroupAccountMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'admin_id', '3': 4, '4': 1, '5': 9, '10': 'adminId'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.GroupAccountStatus', '10': 'status'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'members', '3': 9, '4': 3, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'members'},
    {'1': 'contributions', '3': 10, '4': 3, '5': 11, '6': '.pb.ContributionMessage', '10': 'contributions'},
    {'1': 'visibility', '3': 11, '4': 1, '5': 14, '6': '.pb.GroupVisibility', '10': 'visibility'},
    {'1': 'member_count', '3': 12, '4': 1, '5': 5, '10': 'memberCount'},
    {'1': 'total_raised', '3': 13, '4': 1, '5': 4, '10': 'totalRaised'},
    {'1': 'image_url', '3': 14, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `GroupAccountMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupAccountMessageDescriptor = $convert.base64Decode(
    'ChNHcm91cEFjY291bnRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIZCghhZG1pbl9pZBgEIAEoCVIH'
    'YWRtaW5JZBIuCgZzdGF0dXMYBSABKA4yFi5wYi5Hcm91cEFjY291bnRTdGF0dXNSBnN0YXR1cx'
    'I5CgpjcmVhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRl'
    'ZEF0EjkKCnVwZGF0ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cG'
    'RhdGVkQXQSGgoIbWV0YWRhdGEYCCABKAlSCG1ldGFkYXRhEjAKB21lbWJlcnMYCSADKAsyFi5w'
    'Yi5Hcm91cE1lbWJlck1lc3NhZ2VSB21lbWJlcnMSPQoNY29udHJpYnV0aW9ucxgKIAMoCzIXLn'
    'BiLkNvbnRyaWJ1dGlvbk1lc3NhZ2VSDWNvbnRyaWJ1dGlvbnMSMwoKdmlzaWJpbGl0eRgLIAEo'
    'DjITLnBiLkdyb3VwVmlzaWJpbGl0eVIKdmlzaWJpbGl0eRIhCgxtZW1iZXJfY291bnQYDCABKA'
    'VSC21lbWJlckNvdW50EiEKDHRvdGFsX3JhaXNlZBgNIAEoBFILdG90YWxSYWlzZWQSGwoJaW1h'
    'Z2VfdXJsGA4gASgJUghpbWFnZVVybA==');

@$core.Deprecated('Use groupMemberMessageDescriptor instead')
const GroupMemberMessage$json = {
  '1': 'GroupMemberMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'user_name', '3': 4, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'profile_image', '3': 6, '4': 1, '5': 9, '10': 'profileImage'},
    {'1': 'role', '3': 7, '4': 1, '5': 14, '6': '.pb.GroupMemberRole', '10': 'role'},
    {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.GroupMemberStatus', '10': 'status'},
    {'1': 'joined_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'joinedAt'},
    {'1': 'permissions', '3': 10, '4': 1, '5': 9, '10': 'permissions'},
    {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'is_partial', '3': 12, '4': 1, '5': 8, '10': 'isPartial'},
    {'1': 'user_username', '3': 13, '4': 1, '5': 9, '10': 'userUsername'},
  ],
};

/// Descriptor for `GroupMemberMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupMemberMessageDescriptor = $convert.base64Decode(
    'ChJHcm91cE1lbWJlck1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhkKCGdyb3VwX2lkGAIgASgJUg'
    'dncm91cElkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIbCgl1c2VyX25hbWUYBCABKAlSCHVz'
    'ZXJOYW1lEhQKBWVtYWlsGAUgASgJUgVlbWFpbBIjCg1wcm9maWxlX2ltYWdlGAYgASgJUgxwcm'
    '9maWxlSW1hZ2USJwoEcm9sZRgHIAEoDjITLnBiLkdyb3VwTWVtYmVyUm9sZVIEcm9sZRItCgZz'
    'dGF0dXMYCCABKA4yFS5wYi5Hcm91cE1lbWJlclN0YXR1c1IGc3RhdHVzEjcKCWpvaW5lZF9hdB'
    'gJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGpvaW5lZEF0EiAKC3Blcm1pc3Np'
    'b25zGAogASgJUgtwZXJtaXNzaW9ucxIhCgxwaG9uZV9udW1iZXIYCyABKAlSC3Bob25lTnVtYm'
    'VyEh0KCmlzX3BhcnRpYWwYDCABKAhSCWlzUGFydGlhbBIjCg11c2VyX3VzZXJuYW1lGA0gASgJ'
    'Ugx1c2VyVXNlcm5hbWU=');

@$core.Deprecated('Use contributionMessageDescriptor instead')
const ContributionMessage$json = {
  '1': 'ContributionMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'target_amount', '3': 5, '4': 1, '5': 4, '10': 'targetAmount'},
    {'1': 'current_amount', '3': 6, '4': 1, '5': 4, '10': 'currentAmount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'deadline', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.pb.ContributionStatus', '10': 'status'},
    {'1': 'created_by', '3': 10, '4': 1, '5': 9, '10': 'createdBy'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'type', '3': 14, '4': 1, '5': 14, '6': '.pb.ContributionType', '10': 'type'},
    {'1': 'frequency', '3': 15, '4': 1, '5': 14, '6': '.pb.ContributionFrequency', '10': 'frequency'},
    {'1': 'regular_amount', '3': 16, '4': 1, '5': 4, '10': 'regularAmount'},
    {'1': 'next_payment_date', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPaymentDate'},
    {'1': 'start_date', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'total_cycles', '3': 19, '4': 1, '5': 5, '10': 'totalCycles'},
    {'1': 'current_cycle', '3': 20, '4': 1, '5': 5, '10': 'currentCycle'},
    {'1': 'current_payout_recipient', '3': 21, '4': 1, '5': 9, '10': 'currentPayoutRecipient'},
    {'1': 'next_payout_date', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPayoutDate'},
    {'1': 'auto_pay_enabled', '3': 23, '4': 1, '5': 8, '10': 'autoPayEnabled'},
    {'1': 'penalty_amount', '3': 24, '4': 1, '5': 4, '10': 'penaltyAmount'},
    {'1': 'grace_period_days', '3': 25, '4': 1, '5': 5, '10': 'gracePeriodDays'},
    {'1': 'allow_partial_payments', '3': 26, '4': 1, '5': 8, '10': 'allowPartialPayments'},
    {'1': 'minimum_balance', '3': 27, '4': 1, '5': 4, '10': 'minimumBalance'},
    {'1': 'payments', '3': 28, '4': 3, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payments'},
    {'1': 'payout_schedule', '3': 29, '4': 3, '5': 11, '6': '.pb.PayoutScheduleMessage', '10': 'payoutSchedule'},
    {'1': 'payout_history', '3': 30, '4': 3, '5': 11, '6': '.pb.PayoutTransactionMessage', '10': 'payoutHistory'},
    {'1': 'members', '3': 31, '4': 3, '5': 11, '6': '.pb.ContributionMemberMessage', '10': 'members'},
  ],
};

/// Descriptor for `ContributionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionMessageDescriptor = $convert.base64Decode(
    'ChNDb250cmlidXRpb25NZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIZCghncm91cF9pZBgCIAEoCV'
    'IHZ3JvdXBJZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rl'
    'c2NyaXB0aW9uEiMKDXRhcmdldF9hbW91bnQYBSABKARSDHRhcmdldEFtb3VudBIlCg5jdXJyZW'
    '50X2Ftb3VudBgGIAEoBFINY3VycmVudEFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVu'
    'Y3kSNgoIZGVhZGxpbmUYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbG'
    'luZRIuCgZzdGF0dXMYCSABKA4yFi5wYi5Db250cmlidXRpb25TdGF0dXNSBnN0YXR1cxIdCgpj'
    'cmVhdGVkX2J5GAogASgJUgljcmVhdGVkQnkSOQoKY3JlYXRlZF9hdBgLIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAwgASgLMhouZ29v'
    'Z2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0EhoKCG1ldGFkYXRhGA0gASgJUghtZX'
    'RhZGF0YRIoCgR0eXBlGA4gASgOMhQucGIuQ29udHJpYnV0aW9uVHlwZVIEdHlwZRI3CglmcmVx'
    'dWVuY3kYDyABKA4yGS5wYi5Db250cmlidXRpb25GcmVxdWVuY3lSCWZyZXF1ZW5jeRIlCg5yZW'
    'd1bGFyX2Ftb3VudBgQIAEoBFINcmVndWxhckFtb3VudBJGChFuZXh0X3BheW1lbnRfZGF0ZRgR'
    'IAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD25leHRQYXltZW50RGF0ZRI5CgpzdG'
    'FydF9kYXRlGBIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEiEK'
    'DHRvdGFsX2N5Y2xlcxgTIAEoBVILdG90YWxDeWNsZXMSIwoNY3VycmVudF9jeWNsZRgUIAEoBV'
    'IMY3VycmVudEN5Y2xlEjgKGGN1cnJlbnRfcGF5b3V0X3JlY2lwaWVudBgVIAEoCVIWY3VycmVu'
    'dFBheW91dFJlY2lwaWVudBJEChBuZXh0X3BheW91dF9kYXRlGBYgASgLMhouZ29vZ2xlLnByb3'
    'RvYnVmLlRpbWVzdGFtcFIObmV4dFBheW91dERhdGUSKAoQYXV0b19wYXlfZW5hYmxlZBgXIAEo'
    'CFIOYXV0b1BheUVuYWJsZWQSJQoOcGVuYWx0eV9hbW91bnQYGCABKARSDXBlbmFsdHlBbW91bn'
    'QSKgoRZ3JhY2VfcGVyaW9kX2RheXMYGSABKAVSD2dyYWNlUGVyaW9kRGF5cxI0ChZhbGxvd19w'
    'YXJ0aWFsX3BheW1lbnRzGBogASgIUhRhbGxvd1BhcnRpYWxQYXltZW50cxInCg9taW5pbXVtX2'
    'JhbGFuY2UYGyABKARSDm1pbmltdW1CYWxhbmNlEjoKCHBheW1lbnRzGBwgAygLMh4ucGIuQ29u'
    'dHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSCHBheW1lbnRzEkIKD3BheW91dF9zY2hlZHVsZRgdIA'
    'MoCzIZLnBiLlBheW91dFNjaGVkdWxlTWVzc2FnZVIOcGF5b3V0U2NoZWR1bGUSQwoOcGF5b3V0'
    'X2hpc3RvcnkYHiADKAsyHC5wYi5QYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2VSDXBheW91dEhpc3'
    'RvcnkSNwoHbWVtYmVycxgfIAMoCzIdLnBiLkNvbnRyaWJ1dGlvbk1lbWJlck1lc3NhZ2VSB21l'
    'bWJlcnM=');

@$core.Deprecated('Use contributionMemberMessageDescriptor instead')
const ContributionMemberMessage$json = {
  '1': 'ContributionMemberMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'user_name', '3': 4, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'profile_image', '3': 6, '4': 1, '5': 9, '10': 'profileImage'},
    {'1': 'joined_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'joinedAt'},
    {'1': 'total_paid', '3': 8, '4': 1, '5': 4, '10': 'totalPaid'},
    {'1': 'expected_amount', '3': 9, '4': 1, '5': 4, '10': 'expectedAmount'},
    {'1': 'has_paid_current_cycle', '3': 10, '4': 1, '5': 8, '10': 'hasPaidCurrentCycle'},
  ],
};

/// Descriptor for `ContributionMemberMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionMemberMessageDescriptor = $convert.base64Decode(
    'ChlDb250cmlidXRpb25NZW1iZXJNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBInCg9jb250cmlidX'
    'Rpb25faWQYAiABKAlSDmNvbnRyaWJ1dGlvbklkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIb'
    'Cgl1c2VyX25hbWUYBCABKAlSCHVzZXJOYW1lEhQKBWVtYWlsGAUgASgJUgVlbWFpbBIjCg1wcm'
    '9maWxlX2ltYWdlGAYgASgJUgxwcm9maWxlSW1hZ2USNwoJam9pbmVkX2F0GAcgASgLMhouZ29v'
    'Z2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIam9pbmVkQXQSHQoKdG90YWxfcGFpZBgIIAEoBFIJdG'
    '90YWxQYWlkEicKD2V4cGVjdGVkX2Ftb3VudBgJIAEoBFIOZXhwZWN0ZWRBbW91bnQSMwoWaGFz'
    'X3BhaWRfY3VycmVudF9jeWNsZRgKIAEoCFITaGFzUGFpZEN1cnJlbnRDeWNsZQ==');

@$core.Deprecated('Use contributionPaymentMessageDescriptor instead')
const ContributionPaymentMessage$json = {
  '1': 'ContributionPaymentMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'user_name', '3': 5, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payment_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paymentDate'},
    {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.pb.PaymentStatus', '10': 'status'},
    {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'receipt_id', '3': 11, '4': 1, '5': 9, '10': 'receiptId'},
    {'1': 'notes', '3': 12, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ContributionPaymentMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionPaymentMessageDescriptor = $convert.base64Decode(
    'ChpDb250cmlidXRpb25QYXltZW50TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSJwoPY29udHJpYn'
    'V0aW9uX2lkGAIgASgJUg5jb250cmlidXRpb25JZBIZCghncm91cF9pZBgDIAEoCVIHZ3JvdXBJ'
    'ZBIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQSGwoJdXNlcl9uYW1lGAUgASgJUgh1c2VyTmFtZR'
    'IWCgZhbW91bnQYBiABKARSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSPQoM'
    'cGF5bWVudF9kYXRlGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcGF5bWVudE'
    'RhdGUSKQoGc3RhdHVzGAkgASgOMhEucGIuUGF5bWVudFN0YXR1c1IGc3RhdHVzEiUKDnRyYW5z'
    'YWN0aW9uX2lkGAogASgJUg10cmFuc2FjdGlvbklkEh0KCnJlY2VpcHRfaWQYCyABKAlSCXJlY2'
    'VpcHRJZBIUCgVub3RlcxgMIAEoCVIFbm90ZXMSGgoIbWV0YWRhdGEYDSABKAlSCG1ldGFkYXRh');

@$core.Deprecated('Use payoutScheduleMessageDescriptor instead')
const PayoutScheduleMessage$json = {
  '1': 'PayoutScheduleMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'user_name', '3': 3, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'position', '3': 4, '4': 1, '5': 5, '10': 'position'},
    {'1': 'scheduled_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledDate'},
    {'1': 'expected_amount', '3': 6, '4': 1, '5': 4, '10': 'expectedAmount'},
    {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.pb.PayoutStatus', '10': 'status'},
    {'1': 'received_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'receivedDate'},
    {'1': 'actual_amount', '3': 9, '4': 1, '5': 4, '10': 'actualAmount'},
    {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `PayoutScheduleMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutScheduleMessageDescriptor = $convert.base64Decode(
    'ChVQYXlvdXRTY2hlZHVsZU1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKA'
    'lSBnVzZXJJZBIbCgl1c2VyX25hbWUYAyABKAlSCHVzZXJOYW1lEhoKCHBvc2l0aW9uGAQgASgF'
    'Ughwb3NpdGlvbhJBCg5zY2hlZHVsZWRfZGF0ZRgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSDXNjaGVkdWxlZERhdGUSJwoPZXhwZWN0ZWRfYW1vdW50GAYgASgEUg5leHBlY3Rl'
    'ZEFtb3VudBIoCgZzdGF0dXMYByABKA4yEC5wYi5QYXlvdXRTdGF0dXNSBnN0YXR1cxI/Cg1yZW'
    'NlaXZlZF9kYXRlGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVjZWl2ZWRE'
    'YXRlEiMKDWFjdHVhbF9hbW91bnQYCSABKARSDGFjdHVhbEFtb3VudBIUCgVub3RlcxgKIAEoCV'
    'IFbm90ZXM=');

@$core.Deprecated('Use payoutTransactionMessageDescriptor instead')
const PayoutTransactionMessage$json = {
  '1': 'PayoutTransactionMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'recipient_user_id', '3': 4, '4': 1, '5': 9, '10': 'recipientUserId'},
    {'1': 'recipient_user_name', '3': 5, '4': 1, '5': 9, '10': 'recipientUserName'},
    {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payout_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'payoutDate'},
    {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.pb.PayoutTransactionStatus', '10': 'status'},
    {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'payment_method', '3': 11, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'failure_reason', '3': 12, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `PayoutTransactionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutTransactionMessageDescriptor = $convert.base64Decode(
    'ChhQYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2USDgoCaWQYASABKAlSAmlkEicKD2NvbnRyaWJ1dG'
    'lvbl9pZBgCIAEoCVIOY29udHJpYnV0aW9uSWQSGQoIZ3JvdXBfaWQYAyABKAlSB2dyb3VwSWQS'
    'KgoRcmVjaXBpZW50X3VzZXJfaWQYBCABKAlSD3JlY2lwaWVudFVzZXJJZBIuChNyZWNpcGllbn'
    'RfdXNlcl9uYW1lGAUgASgJUhFyZWNpcGllbnRVc2VyTmFtZRIWCgZhbW91bnQYBiABKARSBmFt'
    'b3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSOwoLcGF5b3V0X2RhdGUYCCABKAsyGi'
    '5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpwYXlvdXREYXRlEjMKBnN0YXR1cxgJIAEoDjIb'
    'LnBiLlBheW91dFRyYW5zYWN0aW9uU3RhdHVzUgZzdGF0dXMSJQoOdHJhbnNhY3Rpb25faWQYCi'
    'ABKAlSDXRyYW5zYWN0aW9uSWQSJQoOcGF5bWVudF9tZXRob2QYCyABKAlSDXBheW1lbnRNZXRo'
    'b2QSJQoOZmFpbHVyZV9yZWFzb24YDCABKAlSDWZhaWx1cmVSZWFzb24SGgoIbWV0YWRhdGEYDS'
    'ABKAlSCG1ldGFkYXRh');

@$core.Deprecated('Use contributionReceiptMessageDescriptor instead')
const ContributionReceiptMessage$json = {
  '1': 'ContributionReceiptMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'payment_id', '3': 2, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'contribution_id', '3': 3, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'group_id', '3': 4, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'user_name', '3': 6, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'amount', '3': 7, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payment_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paymentDate'},
    {'1': 'generated_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
    {'1': 'receipt_number', '3': 11, '4': 1, '5': 9, '10': 'receiptNumber'},
    {'1': 'receipt_data', '3': 12, '4': 1, '5': 9, '10': 'receiptData'},
  ],
};

/// Descriptor for `ContributionReceiptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionReceiptMessageDescriptor = $convert.base64Decode(
    'ChpDb250cmlidXRpb25SZWNlaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHQoKcGF5bWVudF'
    '9pZBgCIAEoCVIJcGF5bWVudElkEicKD2NvbnRyaWJ1dGlvbl9pZBgDIAEoCVIOY29udHJpYnV0'
    'aW9uSWQSGQoIZ3JvdXBfaWQYBCABKAlSB2dyb3VwSWQSFwoHdXNlcl9pZBgFIAEoCVIGdXNlck'
    'lkEhsKCXVzZXJfbmFtZRgGIAEoCVIIdXNlck5hbWUSFgoGYW1vdW50GAcgASgEUgZhbW91bnQS'
    'GgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5Ej0KDHBheW1lbnRfZGF0ZRgJIAEoCzIaLmdvb2'
    'dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3BheW1lbnREYXRlEj0KDGdlbmVyYXRlZF9hdBgKIAEo'
    'CzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2dlbmVyYXRlZEF0EiUKDnJlY2VpcHRfbn'
    'VtYmVyGAsgASgJUg1yZWNlaXB0TnVtYmVyEiEKDHJlY2VpcHRfZGF0YRgMIAEoCVILcmVjZWlw'
    'dERhdGE=');

@$core.Deprecated('Use contributionTranscriptMessageDescriptor instead')
const ContributionTranscriptMessage$json = {
  '1': 'ContributionTranscriptMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'generated_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
    {'1': 'payments', '3': 5, '4': 3, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payments'},
    {'1': 'total_amount', '3': 6, '4': 1, '5': 4, '10': 'totalAmount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'member_contributions', '3': 8, '4': 1, '5': 9, '10': 'memberContributions'},
  ],
};

/// Descriptor for `ContributionTranscriptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionTranscriptMessageDescriptor = $convert.base64Decode(
    'Ch1Db250cmlidXRpb25UcmFuc2NyaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSJwoPY29udH'
    'JpYnV0aW9uX2lkGAIgASgJUg5jb250cmlidXRpb25JZBIZCghncm91cF9pZBgDIAEoCVIHZ3Jv'
    'dXBJZBI9CgxnZW5lcmF0ZWRfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg'
    'tnZW5lcmF0ZWRBdBI6CghwYXltZW50cxgFIAMoCzIeLnBiLkNvbnRyaWJ1dGlvblBheW1lbnRN'
    'ZXNzYWdlUghwYXltZW50cxIhCgx0b3RhbF9hbW91bnQYBiABKARSC3RvdGFsQW1vdW50EhoKCG'
    'N1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIxChRtZW1iZXJfY29udHJpYnV0aW9ucxgIIAEoCVIT'
    'bWVtYmVyQ29udHJpYnV0aW9ucw==');

@$core.Deprecated('Use createGroupRequestDescriptor instead')
const CreateGroupRequest$json = {
  '1': 'CreateGroupRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 3, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'visibility', '3': 4, '4': 1, '5': 14, '6': '.pb.GroupVisibility', '10': 'visibility'},
    {'1': 'image_url', '3': 5, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `CreateGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVHcm91cFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbh'
    'gCIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYAyABKAlSCG1ldGFkYXRhEjMKCnZpc2li'
    'aWxpdHkYBCABKA4yEy5wYi5Hcm91cFZpc2liaWxpdHlSCnZpc2liaWxpdHkSGwoJaW1hZ2VfdX'
    'JsGAUgASgJUghpbWFnZVVybA==');

@$core.Deprecated('Use createGroupResponseDescriptor instead')
const CreateGroupResponse$json = {
  '1': 'CreateGroupResponse',
  '2': [
    {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `CreateGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVHcm91cFJlc3BvbnNlEi0KBWdyb3VwGAEgASgLMhcucGIuR3JvdXBBY2NvdW50TW'
    'Vzc2FnZVIFZ3JvdXA=');

@$core.Deprecated('Use getGroupRequestDescriptor instead')
const GetGroupRequest$json = {
  '1': 'GetGroupRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQ=');

@$core.Deprecated('Use getGroupResponseDescriptor instead')
const GetGroupResponse$json = {
  '1': 'GetGroupResponse',
  '2': [
    {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `GetGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupResponseDescriptor = $convert.base64Decode(
    'ChBHZXRHcm91cFJlc3BvbnNlEi0KBWdyb3VwGAEgASgLMhcucGIuR3JvdXBBY2NvdW50TWVzc2'
    'FnZVIFZ3JvdXA=');

@$core.Deprecated('Use listUserGroupsRequestDescriptor instead')
const ListUserGroupsRequest$json = {
  '1': 'ListUserGroupsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ListUserGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserGroupsRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0VXNlckdyb3Vwc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3Npem'
    'UYAiABKAVSCHBhZ2VTaXplEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use listUserGroupsResponseDescriptor instead')
const ListUserGroupsResponse$json = {
  '1': 'ListUserGroupsResponse',
  '2': [
    {'1': 'groups', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'groups'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.GroupPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListUserGroupsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserGroupsResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0VXNlckdyb3Vwc1Jlc3BvbnNlEi8KBmdyb3VwcxgBIAMoCzIXLnBiLkdyb3VwQWNjb3'
    'VudE1lc3NhZ2VSBmdyb3VwcxI3CgpwYWdpbmF0aW9uGAIgASgLMhcucGIuR3JvdXBQYWdpbmF0'
    'aW9uSW5mb1IKcGFnaW5hdGlvbg==');

@$core.Deprecated('Use updateGroupRequestDescriptor instead')
const UpdateGroupRequest$json = {
  '1': 'UpdateGroupRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.pb.GroupAccountStatus', '10': 'status'},
    {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'visibility', '3': 6, '4': 1, '5': 14, '6': '.pb.GroupVisibility', '10': 'visibility'},
    {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `UpdateGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateGroupRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSEgoEbmFtZR'
    'gCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SLgoGc3RhdHVz'
    'GAQgASgOMhYucGIuR3JvdXBBY2NvdW50U3RhdHVzUgZzdGF0dXMSGgoIbWV0YWRhdGEYBSABKA'
    'lSCG1ldGFkYXRhEjMKCnZpc2liaWxpdHkYBiABKA4yEy5wYi5Hcm91cFZpc2liaWxpdHlSCnZp'
    'c2liaWxpdHkSGwoJaW1hZ2VfdXJsGAcgASgJUghpbWFnZVVybA==');

@$core.Deprecated('Use updateGroupResponseDescriptor instead')
const UpdateGroupResponse$json = {
  '1': 'UpdateGroupResponse',
  '2': [
    {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `UpdateGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateGroupResponseDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVHcm91cFJlc3BvbnNlEi0KBWdyb3VwGAEgASgLMhcucGIuR3JvdXBBY2NvdW50TW'
    'Vzc2FnZVIFZ3JvdXA=');

@$core.Deprecated('Use deleteGroupRequestDescriptor instead')
const DeleteGroupRequest$json = {
  '1': 'DeleteGroupRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `DeleteGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteGroupRequestDescriptor = $convert.base64Decode(
    'ChJEZWxldGVHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQ=');

@$core.Deprecated('Use deleteGroupResponseDescriptor instead')
const DeleteGroupResponse$json = {
  '1': 'DeleteGroupResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteGroupResponseDescriptor = $convert.base64Decode(
    'ChNEZWxldGVHcm91cFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');

@$core.Deprecated('Use getGroupMembersRequestDescriptor instead')
const GetGroupMembersRequest$json = {
  '1': 'GetGroupMembersRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupMembersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupMembersRequestDescriptor = $convert.base64Decode(
    'ChZHZXRHcm91cE1lbWJlcnNSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');

@$core.Deprecated('Use getGroupMembersResponseDescriptor instead')
const GetGroupMembersResponse$json = {
  '1': 'GetGroupMembersResponse',
  '2': [
    {'1': 'members', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'members'},
  ],
};

/// Descriptor for `GetGroupMembersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupMembersResponseDescriptor = $convert.base64Decode(
    'ChdHZXRHcm91cE1lbWJlcnNSZXNwb25zZRIwCgdtZW1iZXJzGAEgAygLMhYucGIuR3JvdXBNZW'
    '1iZXJNZXNzYWdlUgdtZW1iZXJz');

@$core.Deprecated('Use addMemberRequestDescriptor instead')
const AddMemberRequest$json = {
  '1': 'AddMemberRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'role', '3': 3, '4': 1, '5': 14, '6': '.pb.GroupMemberRole', '10': 'role'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'lookup_username', '3': 6, '4': 1, '5': 9, '10': 'lookupUsername'},
  ],
};

/// Descriptor for `AddMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMemberRequestDescriptor = $convert.base64Decode(
    'ChBBZGRNZW1iZXJSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElkEhcKB3VzZXJfaW'
    'QYAiABKAlSBnVzZXJJZBInCgRyb2xlGAMgASgOMhMucGIuR3JvdXBNZW1iZXJSb2xlUgRyb2xl'
    'EhQKBWVtYWlsGAQgASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYm'
    'VyEicKD2xvb2t1cF91c2VybmFtZRgGIAEoCVIObG9va3VwVXNlcm5hbWU=');

@$core.Deprecated('Use addMemberResponseDescriptor instead')
const AddMemberResponse$json = {
  '1': 'AddMemberResponse',
  '2': [
    {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'member'},
  ],
};

/// Descriptor for `AddMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMemberResponseDescriptor = $convert.base64Decode(
    'ChFBZGRNZW1iZXJSZXNwb25zZRIuCgZtZW1iZXIYASABKAsyFi5wYi5Hcm91cE1lbWJlck1lc3'
    'NhZ2VSBm1lbWJlcg==');

@$core.Deprecated('Use updateMemberRoleRequestDescriptor instead')
const UpdateMemberRoleRequest$json = {
  '1': 'UpdateMemberRoleRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'new_role', '3': 3, '4': 1, '5': 14, '6': '.pb.GroupMemberRole', '10': 'newRole'},
  ],
};

/// Descriptor for `UpdateMemberRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMemberRoleRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVNZW1iZXJSb2xlUmVxdWVzdBIZCghncm91cF9pZBgBIAEoCVIHZ3JvdXBJZBIbCg'
    'ltZW1iZXJfaWQYAiABKAlSCG1lbWJlcklkEi4KCG5ld19yb2xlGAMgASgOMhMucGIuR3JvdXBN'
    'ZW1iZXJSb2xlUgduZXdSb2xl');

@$core.Deprecated('Use updateMemberRoleResponseDescriptor instead')
const UpdateMemberRoleResponse$json = {
  '1': 'UpdateMemberRoleResponse',
  '2': [
    {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'member'},
  ],
};

/// Descriptor for `UpdateMemberRoleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMemberRoleResponseDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVNZW1iZXJSb2xlUmVzcG9uc2USLgoGbWVtYmVyGAEgASgLMhYucGIuR3JvdXBNZW'
    '1iZXJNZXNzYWdlUgZtZW1iZXI=');

@$core.Deprecated('Use removeMemberRequestDescriptor instead')
const RemoveMemberRequest$json = {
  '1': 'RemoveMemberRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
  ],
};

/// Descriptor for `RemoveMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberRequestDescriptor = $convert.base64Decode(
    'ChNSZW1vdmVNZW1iZXJSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElkEhsKCW1lbW'
    'Jlcl9pZBgCIAEoCVIIbWVtYmVySWQ=');

@$core.Deprecated('Use removeMemberResponseDescriptor instead')
const RemoveMemberResponse$json = {
  '1': 'RemoveMemberResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `RemoveMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberResponseDescriptor = $convert.base64Decode(
    'ChRSZW1vdmVNZW1iZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use searchUsersRequestDescriptor instead')
const SearchUsersRequest$json = {
  '1': 'SearchUsersRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersRequestDescriptor = $convert.base64Decode(
    'ChJTZWFyY2hVc2Vyc1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EhQKBWxpbWl0GAIgAS'
    'gFUgVsaW1pdA==');

@$core.Deprecated('Use searchUsersResponseDescriptor instead')
const SearchUsersResponse$json = {
  '1': 'SearchUsersResponse',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'users'},
  ],
};

/// Descriptor for `SearchUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersResponseDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hVc2Vyc1Jlc3BvbnNlEiwKBXVzZXJzGAEgAygLMhYucGIuR3JvdXBNZW1iZXJNZX'
    'NzYWdlUgV1c2Vycw==');

@$core.Deprecated('Use createContributionRequestDescriptor instead')
const CreateContributionRequest$json = {
  '1': 'CreateContributionRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'target_amount', '3': 4, '4': 1, '5': 4, '10': 'targetAmount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'deadline', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    {'1': 'type', '3': 7, '4': 1, '5': 14, '6': '.pb.ContributionType', '10': 'type'},
    {'1': 'frequency', '3': 8, '4': 1, '5': 14, '6': '.pb.ContributionFrequency', '10': 'frequency'},
    {'1': 'regular_amount', '3': 9, '4': 1, '5': 4, '10': 'regularAmount'},
    {'1': 'start_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'total_cycles', '3': 11, '4': 1, '5': 5, '10': 'totalCycles'},
    {'1': 'member_rotation_order', '3': 12, '4': 3, '5': 9, '10': 'memberRotationOrder'},
    {'1': 'auto_pay_enabled', '3': 13, '4': 1, '5': 8, '10': 'autoPayEnabled'},
    {'1': 'penalty_amount', '3': 14, '4': 1, '5': 4, '10': 'penaltyAmount'},
    {'1': 'grace_period_days', '3': 15, '4': 1, '5': 5, '10': 'gracePeriodDays'},
    {'1': 'allow_partial_payments', '3': 16, '4': 1, '5': 8, '10': 'allowPartialPayments'},
    {'1': 'minimum_balance', '3': 17, '4': 1, '5': 4, '10': 'minimumBalance'},
    {'1': 'metadata', '3': 18, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CreateContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createContributionRequestDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVDb250cmlidXRpb25SZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElkEh'
    'QKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24S'
    'IwoNdGFyZ2V0X2Ftb3VudBgEIAEoBFIMdGFyZ2V0QW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUg'
    'hjdXJyZW5jeRI2CghkZWFkbGluZRgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'CGRlYWRsaW5lEigKBHR5cGUYByABKA4yFC5wYi5Db250cmlidXRpb25UeXBlUgR0eXBlEjcKCW'
    'ZyZXF1ZW5jeRgIIAEoDjIZLnBiLkNvbnRyaWJ1dGlvbkZyZXF1ZW5jeVIJZnJlcXVlbmN5EiUK'
    'DnJlZ3VsYXJfYW1vdW50GAkgASgEUg1yZWd1bGFyQW1vdW50EjkKCnN0YXJ0X2RhdGUYCiABKA'
    'syGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSIQoMdG90YWxfY3ljbGVz'
    'GAsgASgFUgt0b3RhbEN5Y2xlcxIyChVtZW1iZXJfcm90YXRpb25fb3JkZXIYDCADKAlSE21lbW'
    'JlclJvdGF0aW9uT3JkZXISKAoQYXV0b19wYXlfZW5hYmxlZBgNIAEoCFIOYXV0b1BheUVuYWJs'
    'ZWQSJQoOcGVuYWx0eV9hbW91bnQYDiABKARSDXBlbmFsdHlBbW91bnQSKgoRZ3JhY2VfcGVyaW'
    '9kX2RheXMYDyABKAVSD2dyYWNlUGVyaW9kRGF5cxI0ChZhbGxvd19wYXJ0aWFsX3BheW1lbnRz'
    'GBAgASgIUhRhbGxvd1BhcnRpYWxQYXltZW50cxInCg9taW5pbXVtX2JhbGFuY2UYESABKARSDm'
    '1pbmltdW1CYWxhbmNlEhoKCG1ldGFkYXRhGBIgASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use createContributionResponseDescriptor instead')
const CreateContributionResponse$json = {
  '1': 'CreateContributionResponse',
  '2': [
    {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `CreateContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createContributionResponseDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVDb250cmlidXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy5wYi'
    '5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');

@$core.Deprecated('Use getContributionRequestDescriptor instead')
const GetContributionRequest$json = {
  '1': 'GetContributionRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GetContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionRequestDescriptor = $convert.base64Decode(
    'ChZHZXRDb250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udH'
    'JpYnV0aW9uSWQ=');

@$core.Deprecated('Use getContributionResponseDescriptor instead')
const GetContributionResponse$json = {
  '1': 'GetContributionResponse',
  '2': [
    {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `GetContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionResponseDescriptor = $convert.base64Decode(
    'ChdHZXRDb250cmlidXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy5wYi5Db2'
    '50cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');

@$core.Deprecated('Use listGroupContributionsRequestDescriptor instead')
const ListGroupContributionsRequest$json = {
  '1': 'ListGroupContributionsRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ListGroupContributionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupContributionsRequestDescriptor = $convert.base64Decode(
    'Ch1MaXN0R3JvdXBDb250cmlidXRpb25zUmVxdWVzdBIZCghncm91cF9pZBgBIAEoCVIHZ3JvdX'
    'BJZBISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemUSFgoG'
    'c3RhdHVzGAQgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use listGroupContributionsResponseDescriptor instead')
const ListGroupContributionsResponse$json = {
  '1': 'ListGroupContributionsResponse',
  '2': [
    {'1': 'contributions', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionMessage', '10': 'contributions'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.ContributionPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListGroupContributionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupContributionsResponseDescriptor = $convert.base64Decode(
    'Ch5MaXN0R3JvdXBDb250cmlidXRpb25zUmVzcG9uc2USPQoNY29udHJpYnV0aW9ucxgBIAMoCz'
    'IXLnBiLkNvbnRyaWJ1dGlvbk1lc3NhZ2VSDWNvbnRyaWJ1dGlvbnMSPgoKcGFnaW5hdGlvbhgC'
    'IAEoCzIeLnBiLkNvbnRyaWJ1dGlvblBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use updateContributionRequestDescriptor instead')
const UpdateContributionRequest$json = {
  '1': 'UpdateContributionRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'target_amount', '3': 4, '4': 1, '5': 4, '10': 'targetAmount'},
    {'1': 'deadline', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.pb.ContributionStatus', '10': 'status'},
    {'1': 'metadata', '3': 7, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `UpdateContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateContributionRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVDb250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY2'
    '9udHJpYnV0aW9uSWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJ'
    'UgtkZXNjcmlwdGlvbhIjCg10YXJnZXRfYW1vdW50GAQgASgEUgx0YXJnZXRBbW91bnQSNgoIZG'
    'VhZGxpbmUYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRIuCgZz'
    'dGF0dXMYBiABKA4yFi5wYi5Db250cmlidXRpb25TdGF0dXNSBnN0YXR1cxIaCghtZXRhZGF0YR'
    'gHIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use updateContributionResponseDescriptor instead')
const UpdateContributionResponse$json = {
  '1': 'UpdateContributionResponse',
  '2': [
    {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `UpdateContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateContributionResponseDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVDb250cmlidXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy5wYi'
    '5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');

@$core.Deprecated('Use deleteContributionRequestDescriptor instead')
const DeleteContributionRequest$json = {
  '1': 'DeleteContributionRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `DeleteContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteContributionRequestDescriptor = $convert.base64Decode(
    'ChlEZWxldGVDb250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY2'
    '9udHJpYnV0aW9uSWQ=');

@$core.Deprecated('Use deleteContributionResponseDescriptor instead')
const DeleteContributionResponse$json = {
  '1': 'DeleteContributionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteContributionResponseDescriptor = $convert.base64Decode(
    'ChpEZWxldGVDb250cmlidXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use addMembersToContributionRequestDescriptor instead')
const AddMembersToContributionRequest$json = {
  '1': 'AddMembersToContributionRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'member_user_ids', '3': 2, '4': 3, '5': 9, '10': 'memberUserIds'},
  ],
};

/// Descriptor for `AddMembersToContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMembersToContributionRequestDescriptor = $convert.base64Decode(
    'Ch9BZGRNZW1iZXJzVG9Db250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIA'
    'EoCVIOY29udHJpYnV0aW9uSWQSJgoPbWVtYmVyX3VzZXJfaWRzGAIgAygJUg1tZW1iZXJVc2Vy'
    'SWRz');

@$core.Deprecated('Use addMembersToContributionResponseDescriptor instead')
const AddMembersToContributionResponse$json = {
  '1': 'AddMembersToContributionResponse',
  '2': [
    {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
    {'1': 'added_members', '3': 2, '4': 3, '5': 11, '6': '.pb.ContributionMemberMessage', '10': 'addedMembers'},
  ],
};

/// Descriptor for `AddMembersToContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMembersToContributionResponseDescriptor = $convert.base64Decode(
    'CiBBZGRNZW1iZXJzVG9Db250cmlidXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKA'
    'syFy5wYi5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24SQgoNYWRkZWRfbWVtYmVy'
    'cxgCIAMoCzIdLnBiLkNvbnRyaWJ1dGlvbk1lbWJlck1lc3NhZ2VSDGFkZGVkTWVtYmVycw==');

@$core.Deprecated('Use removeMemberFromContributionRequestDescriptor instead')
const RemoveMemberFromContributionRequest$json = {
  '1': 'RemoveMemberFromContributionRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'member_user_id', '3': 2, '4': 1, '5': 9, '10': 'memberUserId'},
  ],
};

/// Descriptor for `RemoveMemberFromContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberFromContributionRequestDescriptor = $convert.base64Decode(
    'CiNSZW1vdmVNZW1iZXJGcm9tQ29udHJpYnV0aW9uUmVxdWVzdBInCg9jb250cmlidXRpb25faW'
    'QYASABKAlSDmNvbnRyaWJ1dGlvbklkEiQKDm1lbWJlcl91c2VyX2lkGAIgASgJUgxtZW1iZXJV'
    'c2VySWQ=');

@$core.Deprecated('Use removeMemberFromContributionResponseDescriptor instead')
const RemoveMemberFromContributionResponse$json = {
  '1': 'RemoveMemberFromContributionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `RemoveMemberFromContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberFromContributionResponseDescriptor = $convert.base64Decode(
    'CiRSZW1vdmVNZW1iZXJGcm9tQ29udHJpYnV0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCF'
    'IHc3VjY2Vzcw==');

@$core.Deprecated('Use getContributionMembersRequestDescriptor instead')
const GetContributionMembersRequest$json = {
  '1': 'GetContributionMembersRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GetContributionMembersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionMembersRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRDb250cmlidXRpb25NZW1iZXJzUmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKA'
    'lSDmNvbnRyaWJ1dGlvbklk');

@$core.Deprecated('Use getContributionMembersResponseDescriptor instead')
const GetContributionMembersResponse$json = {
  '1': 'GetContributionMembersResponse',
  '2': [
    {'1': 'members', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionMemberMessage', '10': 'members'},
  ],
};

/// Descriptor for `GetContributionMembersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionMembersResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRDb250cmlidXRpb25NZW1iZXJzUmVzcG9uc2USNwoHbWVtYmVycxgBIAMoCzIdLnBiLk'
    'NvbnRyaWJ1dGlvbk1lbWJlck1lc3NhZ2VSB21lbWJlcnM=');

@$core.Deprecated('Use makePaymentRequestDescriptor instead')
const MakePaymentRequest$json = {
  '1': 'MakePaymentRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'transaction_pin', '3': 5, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `MakePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makePaymentRequestDescriptor = $convert.base64Decode(
    'ChJNYWtlUGF5bWVudFJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidX'
    'Rpb25JZBIWCgZhbW91bnQYAiABKARSBmFtb3VudBIUCgVub3RlcxgDIAEoCVIFbm90ZXMSKgoR'
    'c291cmNlX2FjY291bnRfaWQYBCABKAlSD3NvdXJjZUFjY291bnRJZBInCg90cmFuc2FjdGlvbl'
    '9waW4YBSABKAlSDnRyYW5zYWN0aW9uUGluEicKD2lkZW1wb3RlbmN5X2tleRgGIAEoCVIOaWRl'
    'bXBvdGVuY3lLZXk=');

@$core.Deprecated('Use makePaymentResponseDescriptor instead')
const MakePaymentResponse$json = {
  '1': 'MakePaymentResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payment'},
  ],
};

/// Descriptor for `MakePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makePaymentResponseDescriptor = $convert.base64Decode(
    'ChNNYWtlUGF5bWVudFJlc3BvbnNlEjgKB3BheW1lbnQYASABKAsyHi5wYi5Db250cmlidXRpb2'
    '5QYXltZW50TWVzc2FnZVIHcGF5bWVudA==');

@$core.Deprecated('Use getContributionPaymentsRequestDescriptor instead')
const GetContributionPaymentsRequest$json = {
  '1': 'GetContributionPaymentsRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetContributionPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionPaymentsRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRDb250cmlidXRpb25QYXltZW50c1JlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgAS'
    'gJUg5jb250cmlidXRpb25JZBISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEo'
    'BVIIcGFnZVNpemU=');

@$core.Deprecated('Use getContributionPaymentsResponseDescriptor instead')
const GetContributionPaymentsResponse$json = {
  '1': 'GetContributionPaymentsResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payments'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaymentPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetContributionPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionPaymentsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRDb250cmlidXRpb25QYXltZW50c1Jlc3BvbnNlEjoKCHBheW1lbnRzGAEgAygLMh4ucG'
    'IuQ29udHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSCHBheW1lbnRzEjkKCnBhZ2luYXRpb24YAiAB'
    'KAsyGS5wYi5QYXltZW50UGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');

@$core.Deprecated('Use updatePaymentStatusRequestDescriptor instead')
const UpdatePaymentStatusRequest$json = {
  '1': 'UpdatePaymentStatusRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.PaymentStatus', '10': 'status'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `UpdatePaymentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePaymentStatusRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVQYXltZW50U3RhdHVzUmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW'
    '50SWQSKQoGc3RhdHVzGAIgASgOMhEucGIuUGF5bWVudFN0YXR1c1IGc3RhdHVzEiUKDnRyYW5z'
    'YWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklk');

@$core.Deprecated('Use updatePaymentStatusResponseDescriptor instead')
const UpdatePaymentStatusResponse$json = {
  '1': 'UpdatePaymentStatusResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payment'},
  ],
};

/// Descriptor for `UpdatePaymentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePaymentStatusResponseDescriptor = $convert.base64Decode(
    'ChtVcGRhdGVQYXltZW50U3RhdHVzUmVzcG9uc2USOAoHcGF5bWVudBgBIAEoCzIeLnBiLkNvbn'
    'RyaWJ1dGlvblBheW1lbnRNZXNzYWdlUgdwYXltZW50');

@$core.Deprecated('Use processScheduledPaymentsRequestDescriptor instead')
const ProcessScheduledPaymentsRequest$json = {
  '1': 'ProcessScheduledPaymentsRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `ProcessScheduledPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processScheduledPaymentsRequestDescriptor = $convert.base64Decode(
    'Ch9Qcm9jZXNzU2NoZWR1bGVkUGF5bWVudHNSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIA'
    'EoCVIOY29udHJpYnV0aW9uSWQ=');

@$core.Deprecated('Use processScheduledPaymentsResponseDescriptor instead')
const ProcessScheduledPaymentsResponse$json = {
  '1': 'ProcessScheduledPaymentsResponse',
  '2': [
    {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
    {'1': 'payments_processed', '3': 2, '4': 3, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'paymentsProcessed'},
  ],
};

/// Descriptor for `ProcessScheduledPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processScheduledPaymentsResponseDescriptor = $convert.base64Decode(
    'CiBQcm9jZXNzU2NoZWR1bGVkUGF5bWVudHNSZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKA'
    'syFy5wYi5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24STQoScGF5bWVudHNfcHJv'
    'Y2Vzc2VkGAIgAygLMh4ucGIuQ29udHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSEXBheW1lbnRzUH'
    'JvY2Vzc2Vk');

@$core.Deprecated('Use getOverdueContributionsRequestDescriptor instead')
const GetOverdueContributionsRequest$json = {
  '1': 'GetOverdueContributionsRequest',
};

/// Descriptor for `GetOverdueContributionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueContributionsRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRPdmVyZHVlQ29udHJpYnV0aW9uc1JlcXVlc3Q=');

@$core.Deprecated('Use getOverdueContributionsResponseDescriptor instead')
const GetOverdueContributionsResponse$json = {
  '1': 'GetOverdueContributionsResponse',
  '2': [
    {'1': 'contributions', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionMessage', '10': 'contributions'},
  ],
};

/// Descriptor for `GetOverdueContributionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueContributionsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRPdmVyZHVlQ29udHJpYnV0aW9uc1Jlc3BvbnNlEj0KDWNvbnRyaWJ1dGlvbnMYASADKA'
    'syFy5wYi5Db250cmlidXRpb25NZXNzYWdlUg1jb250cmlidXRpb25z');

@$core.Deprecated('Use getPayoutScheduleRequestDescriptor instead')
const GetPayoutScheduleRequest$json = {
  '1': 'GetPayoutScheduleRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GetPayoutScheduleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutScheduleRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQYXlvdXRTY2hlZHVsZVJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb2'
    '50cmlidXRpb25JZA==');

@$core.Deprecated('Use getPayoutScheduleResponseDescriptor instead')
const GetPayoutScheduleResponse$json = {
  '1': 'GetPayoutScheduleResponse',
  '2': [
    {'1': 'schedule', '3': 1, '4': 3, '5': 11, '6': '.pb.PayoutScheduleMessage', '10': 'schedule'},
  ],
};

/// Descriptor for `GetPayoutScheduleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutScheduleResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQYXlvdXRTY2hlZHVsZVJlc3BvbnNlEjUKCHNjaGVkdWxlGAEgAygLMhkucGIuUGF5b3'
    'V0U2NoZWR1bGVNZXNzYWdlUghzY2hlZHVsZQ==');

@$core.Deprecated('Use processPayoutRequestDescriptor instead')
const ProcessPayoutRequest$json = {
  '1': 'ProcessPayoutRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `ProcessPayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayoutRequestDescriptor = $convert.base64Decode(
    'ChRQcm9jZXNzUGF5b3V0UmVxdWVzdBInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaW'
    'J1dGlvbklk');

@$core.Deprecated('Use processPayoutResponseDescriptor instead')
const ProcessPayoutResponse$json = {
  '1': 'ProcessPayoutResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.pb.PayoutTransactionMessage', '10': 'transaction'},
  ],
};

/// Descriptor for `ProcessPayoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayoutResponseDescriptor = $convert.base64Decode(
    'ChVQcm9jZXNzUGF5b3V0UmVzcG9uc2USPgoLdHJhbnNhY3Rpb24YASABKAsyHC5wYi5QYXlvdX'
    'RUcmFuc2FjdGlvbk1lc3NhZ2VSC3RyYW5zYWN0aW9u');

@$core.Deprecated('Use updatePayoutStatusRequestDescriptor instead')
const UpdatePayoutStatusRequest$json = {
  '1': 'UpdatePayoutStatusRequest',
  '2': [
    {'1': 'payout_id', '3': 1, '4': 1, '5': 9, '10': 'payoutId'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.PayoutTransactionStatus', '10': 'status'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'failure_reason', '3': 4, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `UpdatePayoutStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePayoutStatusRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVQYXlvdXRTdGF0dXNSZXF1ZXN0EhsKCXBheW91dF9pZBgBIAEoCVIIcGF5b3V0SW'
    'QSMwoGc3RhdHVzGAIgASgOMhsucGIuUGF5b3V0VHJhbnNhY3Rpb25TdGF0dXNSBnN0YXR1cxIl'
    'Cg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBIlCg5mYWlsdXJlX3JlYXNvbh'
    'gEIAEoCVINZmFpbHVyZVJlYXNvbg==');

@$core.Deprecated('Use updatePayoutStatusResponseDescriptor instead')
const UpdatePayoutStatusResponse$json = {
  '1': 'UpdatePayoutStatusResponse',
  '2': [
    {'1': 'payout', '3': 1, '4': 1, '5': 11, '6': '.pb.PayoutTransactionMessage', '10': 'payout'},
  ],
};

/// Descriptor for `UpdatePayoutStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePayoutStatusResponseDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVQYXlvdXRTdGF0dXNSZXNwb25zZRI0CgZwYXlvdXQYASABKAsyHC5wYi5QYXlvdX'
    'RUcmFuc2FjdGlvbk1lc3NhZ2VSBnBheW91dA==');

@$core.Deprecated('Use advancePayoutRotationRequestDescriptor instead')
const AdvancePayoutRotationRequest$json = {
  '1': 'AdvancePayoutRotationRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `AdvancePayoutRotationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List advancePayoutRotationRequestDescriptor = $convert.base64Decode(
    'ChxBZHZhbmNlUGF5b3V0Um90YXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCV'
    'IOY29udHJpYnV0aW9uSWQ=');

@$core.Deprecated('Use advancePayoutRotationResponseDescriptor instead')
const AdvancePayoutRotationResponse$json = {
  '1': 'AdvancePayoutRotationResponse',
  '2': [
    {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `AdvancePayoutRotationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List advancePayoutRotationResponseDescriptor = $convert.base64Decode(
    'Ch1BZHZhbmNlUGF5b3V0Um90YXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy'
    '5wYi5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');

@$core.Deprecated('Use generateReceiptRequestDescriptor instead')
const GenerateReceiptRequest$json = {
  '1': 'GenerateReceiptRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GenerateReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateReceiptRequestDescriptor = $convert.base64Decode(
    'ChZHZW5lcmF0ZVJlY2VpcHRSZXF1ZXN0Eh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZA'
    '==');

@$core.Deprecated('Use generateReceiptResponseDescriptor instead')
const GenerateReceiptResponse$json = {
  '1': 'GenerateReceiptResponse',
  '2': [
    {'1': 'receipt', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionReceiptMessage', '10': 'receipt'},
  ],
};

/// Descriptor for `GenerateReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateReceiptResponseDescriptor = $convert.base64Decode(
    'ChdHZW5lcmF0ZVJlY2VpcHRSZXNwb25zZRI4CgdyZWNlaXB0GAEgASgLMh4ucGIuQ29udHJpYn'
    'V0aW9uUmVjZWlwdE1lc3NhZ2VSB3JlY2VpcHQ=');

@$core.Deprecated('Use getUserContributionReceiptsRequestDescriptor instead')
const GetUserContributionReceiptsRequest$json = {
  '1': 'GetUserContributionReceiptsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetUserContributionReceiptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionReceiptsRequestDescriptor = $convert.base64Decode(
    'CiJHZXRVc2VyQ29udHJpYnV0aW9uUmVjZWlwdHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2'
    'USGwoJcGFnZV9zaXplGAIgASgFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use getUserContributionReceiptsResponseDescriptor instead')
const GetUserContributionReceiptsResponse$json = {
  '1': 'GetUserContributionReceiptsResponse',
  '2': [
    {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionReceiptMessage', '10': 'receipts'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.ReceiptPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserContributionReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionReceiptsResponseDescriptor = $convert.base64Decode(
    'CiNHZXRVc2VyQ29udHJpYnV0aW9uUmVjZWlwdHNSZXNwb25zZRI6CghyZWNlaXB0cxgBIAMoCz'
    'IeLnBiLkNvbnRyaWJ1dGlvblJlY2VpcHRNZXNzYWdlUghyZWNlaXB0cxI5CgpwYWdpbmF0aW9u'
    'GAIgASgLMhkucGIuUmVjZWlwdFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use generateTranscriptRequestDescriptor instead')
const GenerateTranscriptRequest$json = {
  '1': 'GenerateTranscriptRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GenerateTranscriptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateTranscriptRequestDescriptor = $convert.base64Decode(
    'ChlHZW5lcmF0ZVRyYW5zY3JpcHRSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY2'
    '9udHJpYnV0aW9uSWQ=');

@$core.Deprecated('Use generateTranscriptResponseDescriptor instead')
const GenerateTranscriptResponse$json = {
  '1': 'GenerateTranscriptResponse',
  '2': [
    {'1': 'transcript', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionTranscriptMessage', '10': 'transcript'},
  ],
};

/// Descriptor for `GenerateTranscriptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateTranscriptResponseDescriptor = $convert.base64Decode(
    'ChpHZW5lcmF0ZVRyYW5zY3JpcHRSZXNwb25zZRJBCgp0cmFuc2NyaXB0GAEgASgLMiEucGIuQ2'
    '9udHJpYnV0aW9uVHJhbnNjcmlwdE1lc3NhZ2VSCnRyYW5zY3JpcHQ=');

@$core.Deprecated('Use getGroupStatisticsRequestDescriptor instead')
const GetGroupStatisticsRequest$json = {
  '1': 'GetGroupStatisticsRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetGroupStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupStatisticsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRHcm91cFN0YXRpc3RpY3NSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');

@$core.Deprecated('Use getGroupStatisticsResponseDescriptor instead')
const GetGroupStatisticsResponse$json = {
  '1': 'GetGroupStatisticsResponse',
  '2': [
    {'1': 'member_count', '3': 1, '4': 1, '5': 5, '10': 'memberCount'},
    {'1': 'total_contributions', '3': 2, '4': 1, '5': 5, '10': 'totalContributions'},
    {'1': 'completed_contributions', '3': 3, '4': 1, '5': 5, '10': 'completedContributions'},
    {'1': 'active_contributions', '3': 4, '4': 1, '5': 5, '10': 'activeContributions'},
    {'1': 'total_target_amount', '3': 5, '4': 1, '5': 4, '10': 'totalTargetAmount'},
    {'1': 'total_current_amount', '3': 6, '4': 1, '5': 4, '10': 'totalCurrentAmount'},
    {'1': 'completion_rate', '3': 7, '4': 1, '5': 1, '10': 'completionRate'},
  ],
};

/// Descriptor for `GetGroupStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupStatisticsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRHcm91cFN0YXRpc3RpY3NSZXNwb25zZRIhCgxtZW1iZXJfY291bnQYASABKAVSC21lbW'
    'JlckNvdW50Ei8KE3RvdGFsX2NvbnRyaWJ1dGlvbnMYAiABKAVSEnRvdGFsQ29udHJpYnV0aW9u'
    'cxI3Chdjb21wbGV0ZWRfY29udHJpYnV0aW9ucxgDIAEoBVIWY29tcGxldGVkQ29udHJpYnV0aW'
    '9ucxIxChRhY3RpdmVfY29udHJpYnV0aW9ucxgEIAEoBVITYWN0aXZlQ29udHJpYnV0aW9ucxIu'
    'ChN0b3RhbF90YXJnZXRfYW1vdW50GAUgASgEUhF0b3RhbFRhcmdldEFtb3VudBIwChR0b3RhbF'
    '9jdXJyZW50X2Ftb3VudBgGIAEoBFISdG90YWxDdXJyZW50QW1vdW50EicKD2NvbXBsZXRpb25f'
    'cmF0ZRgHIAEoAVIOY29tcGxldGlvblJhdGU=');

@$core.Deprecated('Use getUserContributionStatsRequestDescriptor instead')
const GetUserContributionStatsRequest$json = {
  '1': 'GetUserContributionStatsRequest',
};

/// Descriptor for `GetUserContributionStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionStatsRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRVc2VyQ29udHJpYnV0aW9uU3RhdHNSZXF1ZXN0');

@$core.Deprecated('Use getUserContributionStatsResponseDescriptor instead')
const GetUserContributionStatsResponse$json = {
  '1': 'GetUserContributionStatsResponse',
  '2': [
    {'1': 'total_payments', '3': 1, '4': 1, '5': 5, '10': 'totalPayments'},
    {'1': 'total_amount', '3': 2, '4': 1, '5': 4, '10': 'totalAmount'},
    {'1': 'groups_count', '3': 3, '4': 1, '5': 5, '10': 'groupsCount'},
    {'1': 'average_payment', '3': 4, '4': 1, '5': 1, '10': 'averagePayment'},
  ],
};

/// Descriptor for `GetUserContributionStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionStatsResponseDescriptor = $convert.base64Decode(
    'CiBHZXRVc2VyQ29udHJpYnV0aW9uU3RhdHNSZXNwb25zZRIlCg50b3RhbF9wYXltZW50cxgBIA'
    'EoBVINdG90YWxQYXltZW50cxIhCgx0b3RhbF9hbW91bnQYAiABKARSC3RvdGFsQW1vdW50EiEK'
    'DGdyb3Vwc19jb3VudBgDIAEoBVILZ3JvdXBzQ291bnQSJwoPYXZlcmFnZV9wYXltZW50GAQgAS'
    'gBUg5hdmVyYWdlUGF5bWVudA==');

@$core.Deprecated('Use getContributionAnalyticsRequestDescriptor instead')
const GetContributionAnalyticsRequest$json = {
  '1': 'GetContributionAnalyticsRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
  ],
};

/// Descriptor for `GetContributionAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionAnalyticsRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRDb250cmlidXRpb25BbmFseXRpY3NSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIA'
    'EoCVIOY29udHJpYnV0aW9uSWQ=');

@$core.Deprecated('Use getContributionAnalyticsResponseDescriptor instead')
const GetContributionAnalyticsResponse$json = {
  '1': 'GetContributionAnalyticsResponse',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'progress_percentage', '3': 3, '4': 1, '5': 1, '10': 'progressPercentage'},
    {'1': 'total_payments', '3': 4, '4': 1, '5': 5, '10': 'totalPayments'},
    {'1': 'average_payment', '3': 5, '4': 1, '5': 1, '10': 'averagePayment'},
    {'1': 'current_amount', '3': 6, '4': 1, '5': 4, '10': 'currentAmount'},
    {'1': 'target_amount', '3': 7, '4': 1, '5': 4, '10': 'targetAmount'},
    {'1': 'member_participation', '3': 8, '4': 1, '5': 11, '6': '.pb.GetContributionAnalyticsResponse.MemberParticipation', '10': 'memberParticipation'},
    {'1': 'schedule', '3': 9, '4': 1, '5': 11, '6': '.pb.GetContributionAnalyticsResponse.Schedule', '10': 'schedule'},
    {'1': 'payout', '3': 10, '4': 1, '5': 11, '6': '.pb.GetContributionAnalyticsResponse.Payout', '10': 'payout'},
    {'1': 'member_stats', '3': 11, '4': 1, '5': 9, '10': 'memberStats'},
  ],
  '3': [GetContributionAnalyticsResponse_MemberParticipation$json, GetContributionAnalyticsResponse_Schedule$json, GetContributionAnalyticsResponse_Payout$json],
};

@$core.Deprecated('Use getContributionAnalyticsResponseDescriptor instead')
const GetContributionAnalyticsResponse_MemberParticipation$json = {
  '1': 'MemberParticipation',
  '2': [
    {'1': 'total_members', '3': 1, '4': 1, '5': 5, '10': 'totalMembers'},
    {'1': 'participating_members', '3': 2, '4': 1, '5': 5, '10': 'participatingMembers'},
    {'1': 'participation_rate', '3': 3, '4': 1, '5': 1, '10': 'participationRate'},
  ],
};

@$core.Deprecated('Use getContributionAnalyticsResponseDescriptor instead')
const GetContributionAnalyticsResponse_Schedule$json = {
  '1': 'Schedule',
  '2': [
    {'1': 'is_on_schedule', '3': 1, '4': 1, '5': 8, '10': 'isOnSchedule'},
    {'1': 'days_behind_schedule', '3': 2, '4': 1, '5': 5, '10': 'daysBehindSchedule'},
    {'1': 'next_payment_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPaymentDate'},
    {'1': 'current_cycle', '3': 4, '4': 1, '5': 5, '10': 'currentCycle'},
    {'1': 'total_cycles', '3': 5, '4': 1, '5': 5, '10': 'totalCycles'},
  ],
};

@$core.Deprecated('Use getContributionAnalyticsResponseDescriptor instead')
const GetContributionAnalyticsResponse_Payout$json = {
  '1': 'Payout',
  '2': [
    {'1': 'current_recipient', '3': 1, '4': 1, '5': 9, '10': 'currentRecipient'},
    {'1': 'next_payout_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPayoutDate'},
    {'1': 'completed_payouts', '3': 3, '4': 1, '5': 5, '10': 'completedPayouts'},
    {'1': 'pending_payouts', '3': 4, '4': 1, '5': 5, '10': 'pendingPayouts'},
  ],
};

/// Descriptor for `GetContributionAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionAnalyticsResponseDescriptor = $convert.base64Decode(
    'CiBHZXRDb250cmlidXRpb25BbmFseXRpY3NSZXNwb25zZRInCg9jb250cmlidXRpb25faWQYAS'
    'ABKAlSDmNvbnRyaWJ1dGlvbklkEhIKBHR5cGUYAiABKAlSBHR5cGUSLwoTcHJvZ3Jlc3NfcGVy'
    'Y2VudGFnZRgDIAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdlEiUKDnRvdGFsX3BheW1lbnRzGAQgAS'
    'gFUg10b3RhbFBheW1lbnRzEicKD2F2ZXJhZ2VfcGF5bWVudBgFIAEoAVIOYXZlcmFnZVBheW1l'
    'bnQSJQoOY3VycmVudF9hbW91bnQYBiABKARSDWN1cnJlbnRBbW91bnQSIwoNdGFyZ2V0X2Ftb3'
    'VudBgHIAEoBFIMdGFyZ2V0QW1vdW50EmsKFG1lbWJlcl9wYXJ0aWNpcGF0aW9uGAggASgLMjgu'
    'cGIuR2V0Q29udHJpYnV0aW9uQW5hbHl0aWNzUmVzcG9uc2UuTWVtYmVyUGFydGljaXBhdGlvbl'
    'ITbWVtYmVyUGFydGljaXBhdGlvbhJJCghzY2hlZHVsZRgJIAEoCzItLnBiLkdldENvbnRyaWJ1'
    'dGlvbkFuYWx5dGljc1Jlc3BvbnNlLlNjaGVkdWxlUghzY2hlZHVsZRJDCgZwYXlvdXQYCiABKA'
    'syKy5wYi5HZXRDb250cmlidXRpb25BbmFseXRpY3NSZXNwb25zZS5QYXlvdXRSBnBheW91dBIh'
    'CgxtZW1iZXJfc3RhdHMYCyABKAlSC21lbWJlclN0YXRzGp4BChNNZW1iZXJQYXJ0aWNpcGF0aW'
    '9uEiMKDXRvdGFsX21lbWJlcnMYASABKAVSDHRvdGFsTWVtYmVycxIzChVwYXJ0aWNpcGF0aW5n'
    'X21lbWJlcnMYAiABKAVSFHBhcnRpY2lwYXRpbmdNZW1iZXJzEi0KEnBhcnRpY2lwYXRpb25fcm'
    'F0ZRgDIAEoAVIRcGFydGljaXBhdGlvblJhdGUa8gEKCFNjaGVkdWxlEiQKDmlzX29uX3NjaGVk'
    'dWxlGAEgASgIUgxpc09uU2NoZWR1bGUSMAoUZGF5c19iZWhpbmRfc2NoZWR1bGUYAiABKAVSEm'
    'RheXNCZWhpbmRTY2hlZHVsZRJGChFuZXh0X3BheW1lbnRfZGF0ZRgDIAEoCzIaLmdvb2dsZS5w'
    'cm90b2J1Zi5UaW1lc3RhbXBSD25leHRQYXltZW50RGF0ZRIjCg1jdXJyZW50X2N5Y2xlGAQgAS'
    'gFUgxjdXJyZW50Q3ljbGUSIQoMdG90YWxfY3ljbGVzGAUgASgFUgt0b3RhbEN5Y2xlcxrRAQoG'
    'UGF5b3V0EisKEWN1cnJlbnRfcmVjaXBpZW50GAEgASgJUhBjdXJyZW50UmVjaXBpZW50EkQKEG'
    '5leHRfcGF5b3V0X2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg5uZXh0'
    'UGF5b3V0RGF0ZRIrChFjb21wbGV0ZWRfcGF5b3V0cxgDIAEoBVIQY29tcGxldGVkUGF5b3V0cx'
    'InCg9wZW5kaW5nX3BheW91dHMYBCABKAVSDnBlbmRpbmdQYXlvdXRz');

@$core.Deprecated('Use listPublicGroupsRequestDescriptor instead')
const ListPublicGroupsRequest$json = {
  '1': 'ListPublicGroupsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'sort_by', '3': 3, '4': 1, '5': 9, '10': 'sortBy'},
    {'1': 'search_query', '3': 4, '4': 1, '5': 9, '10': 'searchQuery'},
  ],
};

/// Descriptor for `ListPublicGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPublicGroupsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0UHVibGljR3JvdXBzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2'
    'l6ZRgCIAEoBVIIcGFnZVNpemUSFwoHc29ydF9ieRgDIAEoCVIGc29ydEJ5EiEKDHNlYXJjaF9x'
    'dWVyeRgEIAEoCVILc2VhcmNoUXVlcnk=');

@$core.Deprecated('Use listPublicGroupsResponseDescriptor instead')
const ListPublicGroupsResponse$json = {
  '1': 'ListPublicGroupsResponse',
  '2': [
    {'1': 'groups', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'groups'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.GroupPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListPublicGroupsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPublicGroupsResponseDescriptor = $convert.base64Decode(
    'ChhMaXN0UHVibGljR3JvdXBzUmVzcG9uc2USLwoGZ3JvdXBzGAEgAygLMhcucGIuR3JvdXBBY2'
    'NvdW50TWVzc2FnZVIGZ3JvdXBzEjcKCnBhZ2luYXRpb24YAiABKAsyFy5wYi5Hcm91cFBhZ2lu'
    'YXRpb25JbmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getPublicGroupRequestDescriptor instead')
const GetPublicGroupRequest$json = {
  '1': 'GetPublicGroupRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `GetPublicGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPublicGroupRequestDescriptor = $convert.base64Decode(
    'ChVHZXRQdWJsaWNHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQ=');

@$core.Deprecated('Use publicGroupContributorDescriptor instead')
const PublicGroupContributor$json = {
  '1': 'PublicGroupContributor',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'profile_image', '3': 3, '4': 1, '5': 9, '10': 'profileImage'},
    {'1': 'total_contributed', '3': 4, '4': 1, '5': 4, '10': 'totalContributed'},
    {'1': 'contribution_count', '3': 5, '4': 1, '5': 5, '10': 'contributionCount'},
  ],
};

/// Descriptor for `PublicGroupContributor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicGroupContributorDescriptor = $convert.base64Decode(
    'ChZQdWJsaWNHcm91cENvbnRyaWJ1dG9yEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIhCgxkaX'
    'NwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEiMKDXByb2ZpbGVfaW1hZ2UYAyABKAlSDHBy'
    'b2ZpbGVJbWFnZRIrChF0b3RhbF9jb250cmlidXRlZBgEIAEoBFIQdG90YWxDb250cmlidXRlZB'
    'ItChJjb250cmlidXRpb25fY291bnQYBSABKAVSEWNvbnRyaWJ1dGlvbkNvdW50');

@$core.Deprecated('Use getPublicGroupResponseDescriptor instead')
const GetPublicGroupResponse$json = {
  '1': 'GetPublicGroupResponse',
  '2': [
    {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'group'},
    {'1': 'statistics', '3': 2, '4': 1, '5': 11, '6': '.pb.GetGroupStatisticsResponse', '10': 'statistics'},
    {'1': 'top_contributors', '3': 3, '4': 3, '5': 11, '6': '.pb.PublicGroupContributor', '10': 'topContributors'},
    {'1': 'is_member', '3': 4, '4': 1, '5': 8, '10': 'isMember'},
  ],
};

/// Descriptor for `GetPublicGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPublicGroupResponseDescriptor = $convert.base64Decode(
    'ChZHZXRQdWJsaWNHcm91cFJlc3BvbnNlEi0KBWdyb3VwGAEgASgLMhcucGIuR3JvdXBBY2NvdW'
    '50TWVzc2FnZVIFZ3JvdXASPgoKc3RhdGlzdGljcxgCIAEoCzIeLnBiLkdldEdyb3VwU3RhdGlz'
    'dGljc1Jlc3BvbnNlUgpzdGF0aXN0aWNzEkUKEHRvcF9jb250cmlidXRvcnMYAyADKAsyGi5wYi'
    '5QdWJsaWNHcm91cENvbnRyaWJ1dG9yUg90b3BDb250cmlidXRvcnMSGwoJaXNfbWVtYmVyGAQg'
    'ASgIUghpc01lbWJlcg==');

@$core.Deprecated('Use joinPublicGroupRequestDescriptor instead')
const JoinPublicGroupRequest$json = {
  '1': 'JoinPublicGroupRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
  ],
};

/// Descriptor for `JoinPublicGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinPublicGroupRequestDescriptor = $convert.base64Decode(
    'ChZKb2luUHVibGljR3JvdXBSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElk');

@$core.Deprecated('Use joinPublicGroupResponseDescriptor instead')
const JoinPublicGroupResponse$json = {
  '1': 'JoinPublicGroupResponse',
  '2': [
    {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'member'},
    {'1': 'group', '3': 2, '4': 1, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'group'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `JoinPublicGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinPublicGroupResponseDescriptor = $convert.base64Decode(
    'ChdKb2luUHVibGljR3JvdXBSZXNwb25zZRIuCgZtZW1iZXIYASABKAsyFi5wYi5Hcm91cE1lbW'
    'Jlck1lc3NhZ2VSBm1lbWJlchItCgVncm91cBgCIAEoCzIXLnBiLkdyb3VwQWNjb3VudE1lc3Nh'
    'Z2VSBWdyb3VwEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use groupPaginationInfoDescriptor instead')
const GroupPaginationInfo$json = {
  '1': 'GroupPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `GroupPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupPaginationInfoDescriptor = $convert.base64Decode(
    'ChNHcm91cFBhZ2luYXRpb25JbmZvEiEKDGN1cnJlbnRfcGFnZRgBIAEoBVILY3VycmVudFBhZ2'
    'USHwoLdG90YWxfcGFnZXMYAiABKAVSCnRvdGFsUGFnZXMSHwoLdG90YWxfaXRlbXMYAyABKAVS'
    'CnRvdGFsSXRlbXMSJAoOaXRlbXNfcGVyX3BhZ2UYBCABKAVSDGl0ZW1zUGVyUGFnZRIZCghoYX'
    'NfbmV4dBgFIAEoCFIHaGFzTmV4dBIZCghoYXNfcHJldhgGIAEoCFIHaGFzUHJldg==');

@$core.Deprecated('Use contributionPaginationInfoDescriptor instead')
const ContributionPaginationInfo$json = {
  '1': 'ContributionPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `ContributionPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionPaginationInfoDescriptor = $convert.base64Decode(
    'ChpDb250cmlidXRpb25QYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cn'
    'JlbnRQYWdlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1z'
    'GAMgASgFUgp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2'
    'USGQoIaGFzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');

@$core.Deprecated('Use paymentPaginationInfoDescriptor instead')
const PaymentPaginationInfo$json = {
  '1': 'PaymentPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `PaymentPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentPaginationInfoDescriptor = $convert.base64Decode(
    'ChVQYXltZW50UGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UG'
    'FnZRIfCgt0b3RhbF9wYWdlcxgCIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9pdGVtcxgDIAEo'
    'BVIKdG90YWxJdGVtcxIkCg5pdGVtc19wZXJfcGFnZRgEIAEoBVIMaXRlbXNQZXJQYWdlEhkKCG'
    'hhc19uZXh0GAUgASgIUgdoYXNOZXh0EhkKCGhhc19wcmV2GAYgASgIUgdoYXNQcmV2');

@$core.Deprecated('Use receiptPaginationInfoDescriptor instead')
const ReceiptPaginationInfo$json = {
  '1': 'ReceiptPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `ReceiptPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiptPaginationInfoDescriptor = $convert.base64Decode(
    'ChVSZWNlaXB0UGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UG'
    'FnZRIfCgt0b3RhbF9wYWdlcxgCIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9pdGVtcxgDIAEo'
    'BVIKdG90YWxJdGVtcxIkCg5pdGVtc19wZXJfcGFnZRgEIAEoBVIMaXRlbXNQZXJQYWdlEhkKCG'
    'hhc19uZXh0GAUgASgIUgdoYXNOZXh0EhkKCGhhc19wcmV2GAYgASgIUgdoYXNQcmV2');

@$core.Deprecated('Use activityLogPaginationInfoDescriptor instead')
const ActivityLogPaginationInfo$json = {
  '1': 'ActivityLogPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_count', '3': 3, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'has_more', '3': 4, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `ActivityLogPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activityLogPaginationInfoDescriptor = $convert.base64Decode(
    'ChlBY3Rpdml0eUxvZ1BhZ2luYXRpb25JbmZvEiEKDGN1cnJlbnRfcGFnZRgBIAEoBVILY3Vycm'
    'VudFBhZ2USHwoLdG90YWxfcGFnZXMYAiABKAVSCnRvdGFsUGFnZXMSHwoLdG90YWxfY291bnQY'
    'AyABKAVSCnRvdGFsQ291bnQSGQoIaGFzX21vcmUYBCABKAhSB2hhc01vcmU=');

@$core.Deprecated('Use groupActivityLogMessageDescriptor instead')
const GroupActivityLogMessage$json = {
  '1': 'GroupActivityLogMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'contribution_id', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'contributionId', '17': true},
    {'1': 'actor_user_id', '3': 4, '4': 1, '5': 9, '10': 'actorUserId'},
    {'1': 'actor_name', '3': 5, '4': 1, '5': 9, '10': 'actorName'},
    {'1': 'action_type', '3': 6, '4': 1, '5': 9, '10': 'actionType'},
    {'1': 'target_type', '3': 7, '4': 1, '5': 9, '10': 'targetType'},
    {'1': 'target_id', '3': 8, '4': 1, '5': 9, '9': 1, '10': 'targetId', '17': true},
    {'1': 'details', '3': 9, '4': 1, '5': 9, '10': 'details'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
  '8': [
    {'1': '_contribution_id'},
    {'1': '_target_id'},
  ],
};

/// Descriptor for `GroupActivityLogMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupActivityLogMessageDescriptor = $convert.base64Decode(
    'ChdHcm91cEFjdGl2aXR5TG9nTWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSGQoIZ3JvdXBfaWQYAi'
    'ABKAlSB2dyb3VwSWQSLAoPY29udHJpYnV0aW9uX2lkGAMgASgJSABSDmNvbnRyaWJ1dGlvbklk'
    'iAEBEiIKDWFjdG9yX3VzZXJfaWQYBCABKAlSC2FjdG9yVXNlcklkEh0KCmFjdG9yX25hbWUYBS'
    'ABKAlSCWFjdG9yTmFtZRIfCgthY3Rpb25fdHlwZRgGIAEoCVIKYWN0aW9uVHlwZRIfCgt0YXJn'
    'ZXRfdHlwZRgHIAEoCVIKdGFyZ2V0VHlwZRIgCgl0YXJnZXRfaWQYCCABKAlIAVIIdGFyZ2V0SW'
    'SIAQESGAoHZGV0YWlscxgJIAEoCVIHZGV0YWlscxI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29v'
    'Z2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0QhIKEF9jb250cmlidXRpb25faWRCDA'
    'oKX3RhcmdldF9pZA==');

@$core.Deprecated('Use getGroupActivityLogsRequestDescriptor instead')
const GetGroupActivityLogsRequest$json = {
  '1': 'GetGroupActivityLogsRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'action_type_filter', '3': 4, '4': 1, '5': 9, '10': 'actionTypeFilter'},
  ],
};

/// Descriptor for `GetGroupActivityLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupActivityLogsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRHcm91cEFjdGl2aXR5TG9nc1JlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSW'
    'QSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXplEiwKEmFj'
    'dGlvbl90eXBlX2ZpbHRlchgEIAEoCVIQYWN0aW9uVHlwZUZpbHRlcg==');

@$core.Deprecated('Use getGroupActivityLogsResponseDescriptor instead')
const GetGroupActivityLogsResponse$json = {
  '1': 'GetGroupActivityLogsResponse',
  '2': [
    {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupActivityLogMessage', '10': 'logs'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.ActivityLogPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetGroupActivityLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupActivityLogsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRHcm91cEFjdGl2aXR5TG9nc1Jlc3BvbnNlEi8KBGxvZ3MYASADKAsyGy5wYi5Hcm91cE'
    'FjdGl2aXR5TG9nTWVzc2FnZVIEbG9ncxI9CgpwYWdpbmF0aW9uGAIgASgLMh0ucGIuQWN0aXZp'
    'dHlMb2dQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');

@$core.Deprecated('Use getContributionActivityLogsRequestDescriptor instead')
const GetContributionActivityLogsRequest$json = {
  '1': 'GetContributionActivityLogsRequest',
  '2': [
    {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetContributionActivityLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionActivityLogsRequestDescriptor = $convert.base64Decode(
    'CiJHZXRDb250cmlidXRpb25BY3Rpdml0eUxvZ3NSZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZB'
    'gBIAEoCVIOY29udHJpYnV0aW9uSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUY'
    'AyABKAVSCHBhZ2VTaXpl');

@$core.Deprecated('Use getContributionActivityLogsResponseDescriptor instead')
const GetContributionActivityLogsResponse$json = {
  '1': 'GetContributionActivityLogsResponse',
  '2': [
    {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupActivityLogMessage', '10': 'logs'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.ActivityLogPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetContributionActivityLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionActivityLogsResponseDescriptor = $convert.base64Decode(
    'CiNHZXRDb250cmlidXRpb25BY3Rpdml0eUxvZ3NSZXNwb25zZRIvCgRsb2dzGAEgAygLMhsucG'
    'IuR3JvdXBBY3Rpdml0eUxvZ01lc3NhZ2VSBGxvZ3MSPQoKcGFnaW5hdGlvbhgCIAEoCzIdLnBi'
    'LkFjdGl2aXR5TG9nUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');

