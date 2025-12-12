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
  ],
};

/// Descriptor for `GroupMemberRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupMemberRoleDescriptor = $convert.base64Decode('Cg9Hcm91cE1lbWJlclJvbGUSIQodR1JPVVBfTUVNQkVSX1JPTEVfVU5TUEVDSUZJRUQQABIbChdHUk9VUF9NRU1CRVJfUk9MRV9BRE1JThABEhwKGEdST1VQX01FTUJFUl9ST0xFX01FTUJFUhACEhwKGEdST1VQX01FTUJFUl9ST0xFX1ZJRVdFUhAD');
@$core.Deprecated('Use groupMemberStatusDescriptor instead')
const GroupMemberStatus$json = const {
  '1': 'GroupMemberStatus',
  '2': const [
    const {'1': 'GROUP_MEMBER_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'GROUP_MEMBER_STATUS_ACTIVE', '2': 1},
    const {'1': 'GROUP_MEMBER_STATUS_INACTIVE', '2': 2},
    const {'1': 'GROUP_MEMBER_STATUS_SUSPENDED', '2': 3},
    const {'1': 'GROUP_MEMBER_STATUS_REMOVED', '2': 4},
  ],
};

/// Descriptor for `GroupMemberStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List groupMemberStatusDescriptor = $convert.base64Decode('ChFHcm91cE1lbWJlclN0YXR1cxIjCh9HUk9VUF9NRU1CRVJfU1RBVFVTX1VOU1BFQ0lGSUVEEAASHgoaR1JPVVBfTUVNQkVSX1NUQVRVU19BQ1RJVkUQARIgChxHUk9VUF9NRU1CRVJfU1RBVFVTX0lOQUNUSVZFEAISIQodR1JPVVBfTUVNQkVSX1NUQVRVU19TVVNQRU5ERUQQAxIfChtHUk9VUF9NRU1CRVJfU1RBVFVTX1JFTU9WRUQQBA==');
@$core.Deprecated('Use contributionTypeDescriptor instead')
const ContributionType$json = const {
  '1': 'ContributionType',
  '2': const [
    const {'1': 'CONTRIBUTION_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'CONTRIBUTION_TYPE_ONE_TIME', '2': 1},
    const {'1': 'CONTRIBUTION_TYPE_RECURRING', '2': 2},
    const {'1': 'CONTRIBUTION_TYPE_ROTATING_SAVINGS', '2': 3},
  ],
};

/// Descriptor for `ContributionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contributionTypeDescriptor = $convert.base64Decode('ChBDb250cmlidXRpb25UeXBlEiEKHUNPTlRSSUJVVElPTl9UWVBFX1VOU1BFQ0lGSUVEEAASHgoaQ09OVFJJQlVUSU9OX1RZUEVfT05FX1RJTUUQARIfChtDT05UUklCVVRJT05fVFlQRV9SRUNVUlJJTkcQAhImCiJDT05UUklCVVRJT05fVFlQRV9ST1RBVElOR19TQVZJTkdTEAM=');
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
  ],
};

/// Descriptor for `PaymentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentStatusDescriptor = $convert.base64Decode('Cg1QYXltZW50U3RhdHVzEh4KGlBBWU1FTlRfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGgoWUEFZTUVOVF9TVEFUVVNfUEVORElORxABEh0KGVBBWU1FTlRfU1RBVFVTX1BST0NFU1NJTkcQAhIcChhQQVlNRU5UX1NUQVRVU19DT01QTEVURUQQAxIZChVQQVlNRU5UX1NUQVRVU19GQUlMRUQQBBIbChdQQVlNRU5UX1NUQVRVU19SRUZVTkRFRBAF');
@$core.Deprecated('Use payoutStatusDescriptor instead')
const PayoutStatus$json = const {
  '1': 'PayoutStatus',
  '2': const [
    const {'1': 'PAYOUT_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'PAYOUT_STATUS_PENDING', '2': 1},
    const {'1': 'PAYOUT_STATUS_COMPLETED', '2': 2},
    const {'1': 'PAYOUT_STATUS_CANCELLED', '2': 3},
  ],
};

/// Descriptor for `PayoutStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payoutStatusDescriptor = $convert.base64Decode('CgxQYXlvdXRTdGF0dXMSHQoZUEFZT1VUX1NUQVRVU19VTlNQRUNJRklFRBAAEhkKFVBBWU9VVF9TVEFUVVNfUEVORElORxABEhsKF1BBWU9VVF9TVEFUVVNfQ09NUExFVEVEEAISGwoXUEFZT1VUX1NUQVRVU19DQU5DRUxMRUQQAw==');
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
@$core.Deprecated('Use groupAccountMessageDescriptor instead')
const GroupAccountMessage$json = const {
  '1': 'GroupAccountMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'admin_id', '3': 4, '4': 1, '5': 4, '10': 'adminId'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.GroupAccountStatus', '10': 'status'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'members', '3': 9, '4': 3, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'members'},
    const {'1': 'contributions', '3': 10, '4': 3, '5': 11, '6': '.pb.ContributionMessage', '10': 'contributions'},
  ],
};

/// Descriptor for `GroupAccountMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupAccountMessageDescriptor = $convert.base64Decode('ChNHcm91cEFjY291bnRNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIZCghhZG1pbl9pZBgEIAEoBFIHYWRtaW5JZBIuCgZzdGF0dXMYBSABKA4yFi5wYi5Hcm91cEFjY291bnRTdGF0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSGgoIbWV0YWRhdGEYCCABKAlSCG1ldGFkYXRhEjAKB21lbWJlcnMYCSADKAsyFi5wYi5Hcm91cE1lbWJlck1lc3NhZ2VSB21lbWJlcnMSPQoNY29udHJpYnV0aW9ucxgKIAMoCzIXLnBiLkNvbnRyaWJ1dGlvbk1lc3NhZ2VSDWNvbnRyaWJ1dGlvbnM=');
@$core.Deprecated('Use groupMemberMessageDescriptor instead')
const GroupMemberMessage$json = const {
  '1': 'GroupMemberMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'user_name', '3': 4, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'profile_image', '3': 6, '4': 1, '5': 9, '10': 'profileImage'},
    const {'1': 'role', '3': 7, '4': 1, '5': 14, '6': '.pb.GroupMemberRole', '10': 'role'},
    const {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.GroupMemberStatus', '10': 'status'},
    const {'1': 'joined_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'joinedAt'},
    const {'1': 'permissions', '3': 10, '4': 1, '5': 9, '10': 'permissions'},
    const {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'is_partial', '3': 12, '4': 1, '5': 8, '10': 'isPartial'},
    const {'1': 'user_username', '3': 13, '4': 1, '5': 9, '10': 'userUsername'},
  ],
};

/// Descriptor for `GroupMemberMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupMemberMessageDescriptor = $convert.base64Decode('ChJHcm91cE1lbWJlck1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhkKCGdyb3VwX2lkGAIgASgJUgdncm91cElkEhcKB3VzZXJfaWQYAyABKARSBnVzZXJJZBIbCgl1c2VyX25hbWUYBCABKAlSCHVzZXJOYW1lEhQKBWVtYWlsGAUgASgJUgVlbWFpbBIjCg1wcm9maWxlX2ltYWdlGAYgASgJUgxwcm9maWxlSW1hZ2USJwoEcm9sZRgHIAEoDjITLnBiLkdyb3VwTWVtYmVyUm9sZVIEcm9sZRItCgZzdGF0dXMYCCABKA4yFS5wYi5Hcm91cE1lbWJlclN0YXR1c1IGc3RhdHVzEjcKCWpvaW5lZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGpvaW5lZEF0EiAKC3Blcm1pc3Npb25zGAogASgJUgtwZXJtaXNzaW9ucxIhCgxwaG9uZV9udW1iZXIYCyABKAlSC3Bob25lTnVtYmVyEh0KCmlzX3BhcnRpYWwYDCABKAhSCWlzUGFydGlhbBIjCg11c2VyX3VzZXJuYW1lGA0gASgJUgx1c2VyVXNlcm5hbWU=');
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
    const {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.pb.ContributionStatus', '10': 'status'},
    const {'1': 'created_by', '3': 10, '4': 1, '5': 4, '10': 'createdBy'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'type', '3': 14, '4': 1, '5': 14, '6': '.pb.ContributionType', '10': 'type'},
    const {'1': 'frequency', '3': 15, '4': 1, '5': 14, '6': '.pb.ContributionFrequency', '10': 'frequency'},
    const {'1': 'regular_amount', '3': 16, '4': 1, '5': 4, '10': 'regularAmount'},
    const {'1': 'next_payment_date', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPaymentDate'},
    const {'1': 'start_date', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'total_cycles', '3': 19, '4': 1, '5': 5, '10': 'totalCycles'},
    const {'1': 'current_cycle', '3': 20, '4': 1, '5': 5, '10': 'currentCycle'},
    const {'1': 'current_payout_recipient', '3': 21, '4': 1, '5': 4, '10': 'currentPayoutRecipient'},
    const {'1': 'next_payout_date', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPayoutDate'},
    const {'1': 'auto_pay_enabled', '3': 23, '4': 1, '5': 8, '10': 'autoPayEnabled'},
    const {'1': 'penalty_amount', '3': 24, '4': 1, '5': 4, '10': 'penaltyAmount'},
    const {'1': 'grace_period_days', '3': 25, '4': 1, '5': 5, '10': 'gracePeriodDays'},
    const {'1': 'allow_partial_payments', '3': 26, '4': 1, '5': 8, '10': 'allowPartialPayments'},
    const {'1': 'minimum_balance', '3': 27, '4': 1, '5': 4, '10': 'minimumBalance'},
    const {'1': 'payments', '3': 28, '4': 3, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payments'},
    const {'1': 'payout_schedule', '3': 29, '4': 3, '5': 11, '6': '.pb.PayoutScheduleMessage', '10': 'payoutSchedule'},
    const {'1': 'payout_history', '3': 30, '4': 3, '5': 11, '6': '.pb.PayoutTransactionMessage', '10': 'payoutHistory'},
  ],
};

/// Descriptor for `ContributionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionMessageDescriptor = $convert.base64Decode('ChNDb250cmlidXRpb25NZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIZCghncm91cF9pZBgCIAEoCVIHZ3JvdXBJZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEiMKDXRhcmdldF9hbW91bnQYBSABKARSDHRhcmdldEFtb3VudBIlCg5jdXJyZW50X2Ftb3VudBgGIAEoBFINY3VycmVudEFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSNgoIZGVhZGxpbmUYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRIuCgZzdGF0dXMYCSABKA4yFi5wYi5Db250cmlidXRpb25TdGF0dXNSBnN0YXR1cxIdCgpjcmVhdGVkX2J5GAogASgEUgljcmVhdGVkQnkSOQoKY3JlYXRlZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0EhoKCG1ldGFkYXRhGA0gASgJUghtZXRhZGF0YRIoCgR0eXBlGA4gASgOMhQucGIuQ29udHJpYnV0aW9uVHlwZVIEdHlwZRI3CglmcmVxdWVuY3kYDyABKA4yGS5wYi5Db250cmlidXRpb25GcmVxdWVuY3lSCWZyZXF1ZW5jeRIlCg5yZWd1bGFyX2Ftb3VudBgQIAEoBFINcmVndWxhckFtb3VudBJGChFuZXh0X3BheW1lbnRfZGF0ZRgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD25leHRQYXltZW50RGF0ZRI5CgpzdGFydF9kYXRlGBIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEiEKDHRvdGFsX2N5Y2xlcxgTIAEoBVILdG90YWxDeWNsZXMSIwoNY3VycmVudF9jeWNsZRgUIAEoBVIMY3VycmVudEN5Y2xlEjgKGGN1cnJlbnRfcGF5b3V0X3JlY2lwaWVudBgVIAEoBFIWY3VycmVudFBheW91dFJlY2lwaWVudBJEChBuZXh0X3BheW91dF9kYXRlGBYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIObmV4dFBheW91dERhdGUSKAoQYXV0b19wYXlfZW5hYmxlZBgXIAEoCFIOYXV0b1BheUVuYWJsZWQSJQoOcGVuYWx0eV9hbW91bnQYGCABKARSDXBlbmFsdHlBbW91bnQSKgoRZ3JhY2VfcGVyaW9kX2RheXMYGSABKAVSD2dyYWNlUGVyaW9kRGF5cxI0ChZhbGxvd19wYXJ0aWFsX3BheW1lbnRzGBogASgIUhRhbGxvd1BhcnRpYWxQYXltZW50cxInCg9taW5pbXVtX2JhbGFuY2UYGyABKARSDm1pbmltdW1CYWxhbmNlEjoKCHBheW1lbnRzGBwgAygLMh4ucGIuQ29udHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSCHBheW1lbnRzEkIKD3BheW91dF9zY2hlZHVsZRgdIAMoCzIZLnBiLlBheW91dFNjaGVkdWxlTWVzc2FnZVIOcGF5b3V0U2NoZWR1bGUSQwoOcGF5b3V0X2hpc3RvcnkYHiADKAsyHC5wYi5QYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2VSDXBheW91dEhpc3Rvcnk=');
@$core.Deprecated('Use contributionPaymentMessageDescriptor instead')
const ContributionPaymentMessage$json = const {
  '1': 'ContributionPaymentMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'user_name', '3': 5, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paymentDate'},
    const {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.pb.PaymentStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'receipt_id', '3': 11, '4': 1, '5': 9, '10': 'receiptId'},
    const {'1': 'notes', '3': 12, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `ContributionPaymentMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionPaymentMessageDescriptor = $convert.base64Decode('ChpDb250cmlidXRpb25QYXltZW50TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSJwoPY29udHJpYnV0aW9uX2lkGAIgASgJUg5jb250cmlidXRpb25JZBIZCghncm91cF9pZBgDIAEoCVIHZ3JvdXBJZBIXCgd1c2VyX2lkGAQgASgEUgZ1c2VySWQSGwoJdXNlcl9uYW1lGAUgASgJUgh1c2VyTmFtZRIWCgZhbW91bnQYBiABKARSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSPQoMcGF5bWVudF9kYXRlGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcGF5bWVudERhdGUSKQoGc3RhdHVzGAkgASgOMhEucGIuUGF5bWVudFN0YXR1c1IGc3RhdHVzEiUKDnRyYW5zYWN0aW9uX2lkGAogASgJUg10cmFuc2FjdGlvbklkEh0KCnJlY2VpcHRfaWQYCyABKAlSCXJlY2VpcHRJZBIUCgVub3RlcxgMIAEoCVIFbm90ZXMSGgoIbWV0YWRhdGEYDSABKAlSCG1ldGFkYXRh');
@$core.Deprecated('Use payoutScheduleMessageDescriptor instead')
const PayoutScheduleMessage$json = const {
  '1': 'PayoutScheduleMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'user_name', '3': 3, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'position', '3': 4, '4': 1, '5': 5, '10': 'position'},
    const {'1': 'scheduled_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledDate'},
    const {'1': 'expected_amount', '3': 6, '4': 1, '5': 4, '10': 'expectedAmount'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.pb.PayoutStatus', '10': 'status'},
    const {'1': 'received_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'receivedDate'},
    const {'1': 'actual_amount', '3': 9, '4': 1, '5': 4, '10': 'actualAmount'},
    const {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `PayoutScheduleMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutScheduleMessageDescriptor = $convert.base64Decode('ChVQYXlvdXRTY2hlZHVsZU1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKARSBnVzZXJJZBIbCgl1c2VyX25hbWUYAyABKAlSCHVzZXJOYW1lEhoKCHBvc2l0aW9uGAQgASgFUghwb3NpdGlvbhJBCg5zY2hlZHVsZWRfZGF0ZRgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDXNjaGVkdWxlZERhdGUSJwoPZXhwZWN0ZWRfYW1vdW50GAYgASgEUg5leHBlY3RlZEFtb3VudBIoCgZzdGF0dXMYByABKA4yEC5wYi5QYXlvdXRTdGF0dXNSBnN0YXR1cxI/Cg1yZWNlaXZlZF9kYXRlGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVjZWl2ZWREYXRlEiMKDWFjdHVhbF9hbW91bnQYCSABKARSDGFjdHVhbEFtb3VudBIUCgVub3RlcxgKIAEoCVIFbm90ZXM=');
@$core.Deprecated('Use payoutTransactionMessageDescriptor instead')
const PayoutTransactionMessage$json = const {
  '1': 'PayoutTransactionMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'recipient_user_id', '3': 4, '4': 1, '5': 4, '10': 'recipientUserId'},
    const {'1': 'recipient_user_name', '3': 5, '4': 1, '5': 9, '10': 'recipientUserName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payout_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'payoutDate'},
    const {'1': 'status', '3': 9, '4': 1, '5': 14, '6': '.pb.PayoutTransactionStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'payment_method', '3': 11, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'failure_reason', '3': 12, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'metadata', '3': 13, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `PayoutTransactionMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutTransactionMessageDescriptor = $convert.base64Decode('ChhQYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2USDgoCaWQYASABKAlSAmlkEicKD2NvbnRyaWJ1dGlvbl9pZBgCIAEoCVIOY29udHJpYnV0aW9uSWQSGQoIZ3JvdXBfaWQYAyABKAlSB2dyb3VwSWQSKgoRcmVjaXBpZW50X3VzZXJfaWQYBCABKARSD3JlY2lwaWVudFVzZXJJZBIuChNyZWNpcGllbnRfdXNlcl9uYW1lGAUgASgJUhFyZWNpcGllbnRVc2VyTmFtZRIWCgZhbW91bnQYBiABKARSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSOwoLcGF5b3V0X2RhdGUYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpwYXlvdXREYXRlEjMKBnN0YXR1cxgJIAEoDjIbLnBiLlBheW91dFRyYW5zYWN0aW9uU3RhdHVzUgZzdGF0dXMSJQoOdHJhbnNhY3Rpb25faWQYCiABKAlSDXRyYW5zYWN0aW9uSWQSJQoOcGF5bWVudF9tZXRob2QYCyABKAlSDXBheW1lbnRNZXRob2QSJQoOZmFpbHVyZV9yZWFzb24YDCABKAlSDWZhaWx1cmVSZWFzb24SGgoIbWV0YWRhdGEYDSABKAlSCG1ldGFkYXRh');
@$core.Deprecated('Use contributionReceiptMessageDescriptor instead')
const ContributionReceiptMessage$json = const {
  '1': 'ContributionReceiptMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'payment_id', '3': 2, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'contribution_id', '3': 3, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 4, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 5, '4': 1, '5': 4, '10': 'userId'},
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
final $typed_data.Uint8List contributionReceiptMessageDescriptor = $convert.base64Decode('ChpDb250cmlidXRpb25SZWNlaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSHQoKcGF5bWVudF9pZBgCIAEoCVIJcGF5bWVudElkEicKD2NvbnRyaWJ1dGlvbl9pZBgDIAEoCVIOY29udHJpYnV0aW9uSWQSGQoIZ3JvdXBfaWQYBCABKAlSB2dyb3VwSWQSFwoHdXNlcl9pZBgFIAEoBFIGdXNlcklkEhsKCXVzZXJfbmFtZRgGIAEoCVIIdXNlck5hbWUSFgoGYW1vdW50GAcgASgEUgZhbW91bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5Ej0KDHBheW1lbnRfZGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3BheW1lbnREYXRlEj0KDGdlbmVyYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2dlbmVyYXRlZEF0EiUKDnJlY2VpcHRfbnVtYmVyGAsgASgJUg1yZWNlaXB0TnVtYmVyEiEKDHJlY2VpcHRfZGF0YRgMIAEoCVILcmVjZWlwdERhdGE=');
@$core.Deprecated('Use contributionTranscriptMessageDescriptor instead')
const ContributionTranscriptMessage$json = const {
  '1': 'ContributionTranscriptMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'contribution_id', '3': 2, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'generated_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
    const {'1': 'payments', '3': 5, '4': 3, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payments'},
    const {'1': 'total_amount', '3': 6, '4': 1, '5': 4, '10': 'totalAmount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'member_contributions', '3': 8, '4': 1, '5': 9, '10': 'memberContributions'},
  ],
};

/// Descriptor for `ContributionTranscriptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contributionTranscriptMessageDescriptor = $convert.base64Decode('Ch1Db250cmlidXRpb25UcmFuc2NyaXB0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSJwoPY29udHJpYnV0aW9uX2lkGAIgASgJUg5jb250cmlidXRpb25JZBIZCghncm91cF9pZBgDIAEoCVIHZ3JvdXBJZBI9CgxnZW5lcmF0ZWRfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtnZW5lcmF0ZWRBdBI6CghwYXltZW50cxgFIAMoCzIeLnBiLkNvbnRyaWJ1dGlvblBheW1lbnRNZXNzYWdlUghwYXltZW50cxIhCgx0b3RhbF9hbW91bnQYBiABKARSC3RvdGFsQW1vdW50EhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIxChRtZW1iZXJfY29udHJpYnV0aW9ucxgIIAEoCVITbWVtYmVyQ29udHJpYnV0aW9ucw==');
@$core.Deprecated('Use createGroupRequestDescriptor instead')
const CreateGroupRequest$json = const {
  '1': 'CreateGroupRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupRequestDescriptor = $convert.base64Decode('ChJDcmVhdGVHcm91cFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgCIAEoCVILZGVzY3JpcHRpb24=');
@$core.Deprecated('Use createGroupResponseDescriptor instead')
const CreateGroupResponse$json = const {
  '1': 'CreateGroupResponse',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `CreateGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupResponseDescriptor = $convert.base64Decode('ChNDcmVhdGVHcm91cFJlc3BvbnNlEi0KBWdyb3VwGAEgASgLMhcucGIuR3JvdXBBY2NvdW50TWVzc2FnZVIFZ3JvdXA=');
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
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `GetGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupResponseDescriptor = $convert.base64Decode('ChBHZXRHcm91cFJlc3BvbnNlEi0KBWdyb3VwGAEgASgLMhcucGIuR3JvdXBBY2NvdW50TWVzc2FnZVIFZ3JvdXA=');
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
    const {'1': 'groups', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'groups'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.GroupPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListUserGroupsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserGroupsResponseDescriptor = $convert.base64Decode('ChZMaXN0VXNlckdyb3Vwc1Jlc3BvbnNlEi8KBmdyb3VwcxgBIAMoCzIXLnBiLkdyb3VwQWNjb3VudE1lc3NhZ2VSBmdyb3VwcxI3CgpwYWdpbmF0aW9uGAIgASgLMhcucGIuR3JvdXBQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');
@$core.Deprecated('Use updateGroupRequestDescriptor instead')
const UpdateGroupRequest$json = const {
  '1': 'UpdateGroupRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.pb.GroupAccountStatus', '10': 'status'},
    const {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `UpdateGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateGroupRequestDescriptor = $convert.base64Decode('ChJVcGRhdGVHcm91cFJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SLgoGc3RhdHVzGAQgASgOMhYucGIuR3JvdXBBY2NvdW50U3RhdHVzUgZzdGF0dXMSGgoIbWV0YWRhdGEYBSABKAlSCG1ldGFkYXRh');
@$core.Deprecated('Use updateGroupResponseDescriptor instead')
const UpdateGroupResponse$json = const {
  '1': 'UpdateGroupResponse',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupAccountMessage', '10': 'group'},
  ],
};

/// Descriptor for `UpdateGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateGroupResponseDescriptor = $convert.base64Decode('ChNVcGRhdGVHcm91cFJlc3BvbnNlEi0KBWdyb3VwGAEgASgLMhcucGIuR3JvdXBBY2NvdW50TWVzc2FnZVIFZ3JvdXA=');
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
    const {'1': 'members', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'members'},
  ],
};

/// Descriptor for `GetGroupMembersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGroupMembersResponseDescriptor = $convert.base64Decode('ChdHZXRHcm91cE1lbWJlcnNSZXNwb25zZRIwCgdtZW1iZXJzGAEgAygLMhYucGIuR3JvdXBNZW1iZXJNZXNzYWdlUgdtZW1iZXJz');
@$core.Deprecated('Use addMemberRequestDescriptor instead')
const AddMemberRequest$json = const {
  '1': 'AddMemberRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'role', '3': 3, '4': 1, '5': 14, '6': '.pb.GroupMemberRole', '10': 'role'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'lookup_username', '3': 6, '4': 1, '5': 9, '10': 'lookupUsername'},
  ],
};

/// Descriptor for `AddMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMemberRequestDescriptor = $convert.base64Decode('ChBBZGRNZW1iZXJSZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElkEhcKB3VzZXJfaWQYAiABKARSBnVzZXJJZBInCgRyb2xlGAMgASgOMhMucGIuR3JvdXBNZW1iZXJSb2xlUgRyb2xlEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEicKD2xvb2t1cF91c2VybmFtZRgGIAEoCVIObG9va3VwVXNlcm5hbWU=');
@$core.Deprecated('Use addMemberResponseDescriptor instead')
const AddMemberResponse$json = const {
  '1': 'AddMemberResponse',
  '2': const [
    const {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'member'},
  ],
};

/// Descriptor for `AddMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMemberResponseDescriptor = $convert.base64Decode('ChFBZGRNZW1iZXJSZXNwb25zZRIuCgZtZW1iZXIYASABKAsyFi5wYi5Hcm91cE1lbWJlck1lc3NhZ2VSBm1lbWJlcg==');
@$core.Deprecated('Use updateMemberRoleRequestDescriptor instead')
const UpdateMemberRoleRequest$json = const {
  '1': 'UpdateMemberRoleRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    const {'1': 'new_role', '3': 3, '4': 1, '5': 14, '6': '.pb.GroupMemberRole', '10': 'newRole'},
  ],
};

/// Descriptor for `UpdateMemberRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMemberRoleRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVNZW1iZXJSb2xlUmVxdWVzdBIZCghncm91cF9pZBgBIAEoCVIHZ3JvdXBJZBIbCgltZW1iZXJfaWQYAiABKAlSCG1lbWJlcklkEi4KCG5ld19yb2xlGAMgASgOMhMucGIuR3JvdXBNZW1iZXJSb2xlUgduZXdSb2xl');
@$core.Deprecated('Use updateMemberRoleResponseDescriptor instead')
const UpdateMemberRoleResponse$json = const {
  '1': 'UpdateMemberRoleResponse',
  '2': const [
    const {'1': 'member', '3': 1, '4': 1, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'member'},
  ],
};

/// Descriptor for `UpdateMemberRoleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMemberRoleResponseDescriptor = $convert.base64Decode('ChhVcGRhdGVNZW1iZXJSb2xlUmVzcG9uc2USLgoGbWVtYmVyGAEgASgLMhYucGIuR3JvdXBNZW1iZXJNZXNzYWdlUgZtZW1iZXI=');
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
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.pb.GroupMemberMessage', '10': 'users'},
  ],
};

/// Descriptor for `SearchUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersResponseDescriptor = $convert.base64Decode('ChNTZWFyY2hVc2Vyc1Jlc3BvbnNlEiwKBXVzZXJzGAEgAygLMhYucGIuR3JvdXBNZW1iZXJNZXNzYWdlUgV1c2Vycw==');
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
    const {'1': 'type', '3': 7, '4': 1, '5': 14, '6': '.pb.ContributionType', '10': 'type'},
    const {'1': 'frequency', '3': 8, '4': 1, '5': 14, '6': '.pb.ContributionFrequency', '10': 'frequency'},
    const {'1': 'regular_amount', '3': 9, '4': 1, '5': 4, '10': 'regularAmount'},
    const {'1': 'start_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'total_cycles', '3': 11, '4': 1, '5': 5, '10': 'totalCycles'},
    const {'1': 'member_rotation_order', '3': 12, '4': 3, '5': 4, '10': 'memberRotationOrder'},
    const {'1': 'auto_pay_enabled', '3': 13, '4': 1, '5': 8, '10': 'autoPayEnabled'},
    const {'1': 'penalty_amount', '3': 14, '4': 1, '5': 4, '10': 'penaltyAmount'},
    const {'1': 'grace_period_days', '3': 15, '4': 1, '5': 5, '10': 'gracePeriodDays'},
    const {'1': 'allow_partial_payments', '3': 16, '4': 1, '5': 8, '10': 'allowPartialPayments'},
    const {'1': 'minimum_balance', '3': 17, '4': 1, '5': 4, '10': 'minimumBalance'},
  ],
};

/// Descriptor for `CreateContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createContributionRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVDb250cmlidXRpb25SZXF1ZXN0EhkKCGdyb3VwX2lkGAEgASgJUgdncm91cElkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SIwoNdGFyZ2V0X2Ftb3VudBgEIAEoBFIMdGFyZ2V0QW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRI2CghkZWFkbGluZRgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGRlYWRsaW5lEigKBHR5cGUYByABKA4yFC5wYi5Db250cmlidXRpb25UeXBlUgR0eXBlEjcKCWZyZXF1ZW5jeRgIIAEoDjIZLnBiLkNvbnRyaWJ1dGlvbkZyZXF1ZW5jeVIJZnJlcXVlbmN5EiUKDnJlZ3VsYXJfYW1vdW50GAkgASgEUg1yZWd1bGFyQW1vdW50EjkKCnN0YXJ0X2RhdGUYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSIQoMdG90YWxfY3ljbGVzGAsgASgFUgt0b3RhbEN5Y2xlcxIyChVtZW1iZXJfcm90YXRpb25fb3JkZXIYDCADKARSE21lbWJlclJvdGF0aW9uT3JkZXISKAoQYXV0b19wYXlfZW5hYmxlZBgNIAEoCFIOYXV0b1BheUVuYWJsZWQSJQoOcGVuYWx0eV9hbW91bnQYDiABKARSDXBlbmFsdHlBbW91bnQSKgoRZ3JhY2VfcGVyaW9kX2RheXMYDyABKAVSD2dyYWNlUGVyaW9kRGF5cxI0ChZhbGxvd19wYXJ0aWFsX3BheW1lbnRzGBAgASgIUhRhbGxvd1BhcnRpYWxQYXltZW50cxInCg9taW5pbXVtX2JhbGFuY2UYESABKARSDm1pbmltdW1CYWxhbmNl');
@$core.Deprecated('Use createContributionResponseDescriptor instead')
const CreateContributionResponse$json = const {
  '1': 'CreateContributionResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `CreateContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createContributionResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVDb250cmlidXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy5wYi5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');
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
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `GetContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionResponseDescriptor = $convert.base64Decode('ChdHZXRDb250cmlidXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy5wYi5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');
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
    const {'1': 'contributions', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionMessage', '10': 'contributions'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.ContributionPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListGroupContributionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupContributionsResponseDescriptor = $convert.base64Decode('Ch5MaXN0R3JvdXBDb250cmlidXRpb25zUmVzcG9uc2USPQoNY29udHJpYnV0aW9ucxgBIAMoCzIXLnBiLkNvbnRyaWJ1dGlvbk1lc3NhZ2VSDWNvbnRyaWJ1dGlvbnMSPgoKcGFnaW5hdGlvbhgCIAEoCzIeLnBiLkNvbnRyaWJ1dGlvblBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use updateContributionRequestDescriptor instead')
const UpdateContributionRequest$json = const {
  '1': 'UpdateContributionRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'target_amount', '3': 4, '4': 1, '5': 4, '10': 'targetAmount'},
    const {'1': 'deadline', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.pb.ContributionStatus', '10': 'status'},
  ],
};

/// Descriptor for `UpdateContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateContributionRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVDb250cmlidXRpb25SZXF1ZXN0EicKD2NvbnRyaWJ1dGlvbl9pZBgBIAEoCVIOY29udHJpYnV0aW9uSWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIjCg10YXJnZXRfYW1vdW50GAQgASgEUgx0YXJnZXRBbW91bnQSNgoIZGVhZGxpbmUYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghkZWFkbGluZRIuCgZzdGF0dXMYBiABKA4yFi5wYi5Db250cmlidXRpb25TdGF0dXNSBnN0YXR1cw==');
@$core.Deprecated('Use updateContributionResponseDescriptor instead')
const UpdateContributionResponse$json = const {
  '1': 'UpdateContributionResponse',
  '2': const [
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `UpdateContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateContributionResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVDb250cmlidXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy5wYi5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');
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
@$core.Deprecated('Use makePaymentRequestDescriptor instead')
const MakePaymentRequest$json = const {
  '1': 'MakePaymentRequest',
  '2': const [
    const {'1': 'contribution_id', '3': 1, '4': 1, '5': 9, '10': 'contributionId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `MakePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makePaymentRequestDescriptor = $convert.base64Decode('ChJNYWtlUGF5bWVudFJlcXVlc3QSJwoPY29udHJpYnV0aW9uX2lkGAEgASgJUg5jb250cmlidXRpb25JZBIWCgZhbW91bnQYAiABKARSBmFtb3VudBIUCgVub3RlcxgDIAEoCVIFbm90ZXM=');
@$core.Deprecated('Use makePaymentResponseDescriptor instead')
const MakePaymentResponse$json = const {
  '1': 'MakePaymentResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payment'},
  ],
};

/// Descriptor for `MakePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makePaymentResponseDescriptor = $convert.base64Decode('ChNNYWtlUGF5bWVudFJlc3BvbnNlEjgKB3BheW1lbnQYASABKAsyHi5wYi5Db250cmlidXRpb25QYXltZW50TWVzc2FnZVIHcGF5bWVudA==');
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
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payments'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaymentPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetContributionPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionPaymentsResponseDescriptor = $convert.base64Decode('Ch9HZXRDb250cmlidXRpb25QYXltZW50c1Jlc3BvbnNlEjoKCHBheW1lbnRzGAEgAygLMh4ucGIuQ29udHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSCHBheW1lbnRzEjkKCnBhZ2luYXRpb24YAiABKAsyGS5wYi5QYXltZW50UGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');
@$core.Deprecated('Use updatePaymentStatusRequestDescriptor instead')
const UpdatePaymentStatusRequest$json = const {
  '1': 'UpdatePaymentStatusRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.PaymentStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `UpdatePaymentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePaymentStatusRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVQYXltZW50U3RhdHVzUmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SWQSKQoGc3RhdHVzGAIgASgOMhEucGIuUGF5bWVudFN0YXR1c1IGc3RhdHVzEiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklk');
@$core.Deprecated('Use updatePaymentStatusResponseDescriptor instead')
const UpdatePaymentStatusResponse$json = const {
  '1': 'UpdatePaymentStatusResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'payment'},
  ],
};

/// Descriptor for `UpdatePaymentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePaymentStatusResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVQYXltZW50U3RhdHVzUmVzcG9uc2USOAoHcGF5bWVudBgBIAEoCzIeLnBiLkNvbnRyaWJ1dGlvblBheW1lbnRNZXNzYWdlUgdwYXltZW50');
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
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
    const {'1': 'payments_processed', '3': 2, '4': 3, '5': 11, '6': '.pb.ContributionPaymentMessage', '10': 'paymentsProcessed'},
  ],
};

/// Descriptor for `ProcessScheduledPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processScheduledPaymentsResponseDescriptor = $convert.base64Decode('CiBQcm9jZXNzU2NoZWR1bGVkUGF5bWVudHNSZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy5wYi5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24STQoScGF5bWVudHNfcHJvY2Vzc2VkGAIgAygLMh4ucGIuQ29udHJpYnV0aW9uUGF5bWVudE1lc3NhZ2VSEXBheW1lbnRzUHJvY2Vzc2Vk');
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
    const {'1': 'contributions', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionMessage', '10': 'contributions'},
  ],
};

/// Descriptor for `GetOverdueContributionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueContributionsResponseDescriptor = $convert.base64Decode('Ch9HZXRPdmVyZHVlQ29udHJpYnV0aW9uc1Jlc3BvbnNlEj0KDWNvbnRyaWJ1dGlvbnMYASADKAsyFy5wYi5Db250cmlidXRpb25NZXNzYWdlUg1jb250cmlidXRpb25z');
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
    const {'1': 'schedule', '3': 1, '4': 3, '5': 11, '6': '.pb.PayoutScheduleMessage', '10': 'schedule'},
  ],
};

/// Descriptor for `GetPayoutScheduleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutScheduleResponseDescriptor = $convert.base64Decode('ChlHZXRQYXlvdXRTY2hlZHVsZVJlc3BvbnNlEjUKCHNjaGVkdWxlGAEgAygLMhkucGIuUGF5b3V0U2NoZWR1bGVNZXNzYWdlUghzY2hlZHVsZQ==');
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
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.pb.PayoutTransactionMessage', '10': 'transaction'},
  ],
};

/// Descriptor for `ProcessPayoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayoutResponseDescriptor = $convert.base64Decode('ChVQcm9jZXNzUGF5b3V0UmVzcG9uc2USPgoLdHJhbnNhY3Rpb24YASABKAsyHC5wYi5QYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2VSC3RyYW5zYWN0aW9u');
@$core.Deprecated('Use updatePayoutStatusRequestDescriptor instead')
const UpdatePayoutStatusRequest$json = const {
  '1': 'UpdatePayoutStatusRequest',
  '2': const [
    const {'1': 'payout_id', '3': 1, '4': 1, '5': 9, '10': 'payoutId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.PayoutTransactionStatus', '10': 'status'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'failure_reason', '3': 4, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `UpdatePayoutStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePayoutStatusRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVQYXlvdXRTdGF0dXNSZXF1ZXN0EhsKCXBheW91dF9pZBgBIAEoCVIIcGF5b3V0SWQSMwoGc3RhdHVzGAIgASgOMhsucGIuUGF5b3V0VHJhbnNhY3Rpb25TdGF0dXNSBnN0YXR1cxIlCg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBIlCg5mYWlsdXJlX3JlYXNvbhgEIAEoCVINZmFpbHVyZVJlYXNvbg==');
@$core.Deprecated('Use updatePayoutStatusResponseDescriptor instead')
const UpdatePayoutStatusResponse$json = const {
  '1': 'UpdatePayoutStatusResponse',
  '2': const [
    const {'1': 'payout', '3': 1, '4': 1, '5': 11, '6': '.pb.PayoutTransactionMessage', '10': 'payout'},
  ],
};

/// Descriptor for `UpdatePayoutStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePayoutStatusResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVQYXlvdXRTdGF0dXNSZXNwb25zZRI0CgZwYXlvdXQYASABKAsyHC5wYi5QYXlvdXRUcmFuc2FjdGlvbk1lc3NhZ2VSBnBheW91dA==');
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
    const {'1': 'contribution', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionMessage', '10': 'contribution'},
  ],
};

/// Descriptor for `AdvancePayoutRotationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List advancePayoutRotationResponseDescriptor = $convert.base64Decode('Ch1BZHZhbmNlUGF5b3V0Um90YXRpb25SZXNwb25zZRI7Cgxjb250cmlidXRpb24YASABKAsyFy5wYi5Db250cmlidXRpb25NZXNzYWdlUgxjb250cmlidXRpb24=');
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
    const {'1': 'receipt', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionReceiptMessage', '10': 'receipt'},
  ],
};

/// Descriptor for `GenerateReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateReceiptResponseDescriptor = $convert.base64Decode('ChdHZW5lcmF0ZVJlY2VpcHRSZXNwb25zZRI4CgdyZWNlaXB0GAEgASgLMh4ucGIuQ29udHJpYnV0aW9uUmVjZWlwdE1lc3NhZ2VSB3JlY2VpcHQ=');
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
    const {'1': 'receipts', '3': 1, '4': 3, '5': 11, '6': '.pb.ContributionReceiptMessage', '10': 'receipts'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.ReceiptPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetUserContributionReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserContributionReceiptsResponseDescriptor = $convert.base64Decode('CiNHZXRVc2VyQ29udHJpYnV0aW9uUmVjZWlwdHNSZXNwb25zZRI6CghyZWNlaXB0cxgBIAMoCzIeLnBiLkNvbnRyaWJ1dGlvblJlY2VpcHRNZXNzYWdlUghyZWNlaXB0cxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUmVjZWlwdFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
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
    const {'1': 'transcript', '3': 1, '4': 1, '5': 11, '6': '.pb.ContributionTranscriptMessage', '10': 'transcript'},
  ],
};

/// Descriptor for `GenerateTranscriptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateTranscriptResponseDescriptor = $convert.base64Decode('ChpHZW5lcmF0ZVRyYW5zY3JpcHRSZXNwb25zZRJBCgp0cmFuc2NyaXB0GAEgASgLMiEucGIuQ29udHJpYnV0aW9uVHJhbnNjcmlwdE1lc3NhZ2VSCnRyYW5zY3JpcHQ=');
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
    const {'1': 'member_participation', '3': 8, '4': 1, '5': 11, '6': '.pb.GetContributionAnalyticsResponse.MemberParticipation', '10': 'memberParticipation'},
    const {'1': 'schedule', '3': 9, '4': 1, '5': 11, '6': '.pb.GetContributionAnalyticsResponse.Schedule', '10': 'schedule'},
    const {'1': 'payout', '3': 10, '4': 1, '5': 11, '6': '.pb.GetContributionAnalyticsResponse.Payout', '10': 'payout'},
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
    const {'1': 'current_recipient', '3': 1, '4': 1, '5': 4, '10': 'currentRecipient'},
    const {'1': 'next_payout_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextPayoutDate'},
    const {'1': 'completed_payouts', '3': 3, '4': 1, '5': 5, '10': 'completedPayouts'},
    const {'1': 'pending_payouts', '3': 4, '4': 1, '5': 5, '10': 'pendingPayouts'},
  ],
};

/// Descriptor for `GetContributionAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getContributionAnalyticsResponseDescriptor = $convert.base64Decode('CiBHZXRDb250cmlidXRpb25BbmFseXRpY3NSZXNwb25zZRInCg9jb250cmlidXRpb25faWQYASABKAlSDmNvbnRyaWJ1dGlvbklkEhIKBHR5cGUYAiABKAlSBHR5cGUSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgDIAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdlEiUKDnRvdGFsX3BheW1lbnRzGAQgASgFUg10b3RhbFBheW1lbnRzEicKD2F2ZXJhZ2VfcGF5bWVudBgFIAEoAVIOYXZlcmFnZVBheW1lbnQSJQoOY3VycmVudF9hbW91bnQYBiABKARSDWN1cnJlbnRBbW91bnQSIwoNdGFyZ2V0X2Ftb3VudBgHIAEoBFIMdGFyZ2V0QW1vdW50EmsKFG1lbWJlcl9wYXJ0aWNpcGF0aW9uGAggASgLMjgucGIuR2V0Q29udHJpYnV0aW9uQW5hbHl0aWNzUmVzcG9uc2UuTWVtYmVyUGFydGljaXBhdGlvblITbWVtYmVyUGFydGljaXBhdGlvbhJJCghzY2hlZHVsZRgJIAEoCzItLnBiLkdldENvbnRyaWJ1dGlvbkFuYWx5dGljc1Jlc3BvbnNlLlNjaGVkdWxlUghzY2hlZHVsZRJDCgZwYXlvdXQYCiABKAsyKy5wYi5HZXRDb250cmlidXRpb25BbmFseXRpY3NSZXNwb25zZS5QYXlvdXRSBnBheW91dBIhCgxtZW1iZXJfc3RhdHMYCyABKAlSC21lbWJlclN0YXRzGp4BChNNZW1iZXJQYXJ0aWNpcGF0aW9uEiMKDXRvdGFsX21lbWJlcnMYASABKAVSDHRvdGFsTWVtYmVycxIzChVwYXJ0aWNpcGF0aW5nX21lbWJlcnMYAiABKAVSFHBhcnRpY2lwYXRpbmdNZW1iZXJzEi0KEnBhcnRpY2lwYXRpb25fcmF0ZRgDIAEoAVIRcGFydGljaXBhdGlvblJhdGUa8gEKCFNjaGVkdWxlEiQKDmlzX29uX3NjaGVkdWxlGAEgASgIUgxpc09uU2NoZWR1bGUSMAoUZGF5c19iZWhpbmRfc2NoZWR1bGUYAiABKAVSEmRheXNCZWhpbmRTY2hlZHVsZRJGChFuZXh0X3BheW1lbnRfZGF0ZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD25leHRQYXltZW50RGF0ZRIjCg1jdXJyZW50X2N5Y2xlGAQgASgFUgxjdXJyZW50Q3ljbGUSIQoMdG90YWxfY3ljbGVzGAUgASgFUgt0b3RhbEN5Y2xlcxrRAQoGUGF5b3V0EisKEWN1cnJlbnRfcmVjaXBpZW50GAEgASgEUhBjdXJyZW50UmVjaXBpZW50EkQKEG5leHRfcGF5b3V0X2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg5uZXh0UGF5b3V0RGF0ZRIrChFjb21wbGV0ZWRfcGF5b3V0cxgDIAEoBVIQY29tcGxldGVkUGF5b3V0cxInCg9wZW5kaW5nX3BheW91dHMYBCABKAVSDnBlbmRpbmdQYXlvdXRz');
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
