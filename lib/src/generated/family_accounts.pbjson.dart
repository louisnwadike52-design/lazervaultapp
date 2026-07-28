// This is a generated file - do not edit.
//
// Generated from family_accounts.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use fundDistributionModeDescriptor instead')
const FundDistributionMode$json = {
  '1': 'FundDistributionMode',
  '2': [
    {'1': 'FUND_DISTRIBUTION_MODE_UNSPECIFIED', '2': 0},
    {'1': 'SHARED_POOL', '2': 1},
    {'1': 'EQUAL_SPLIT', '2': 2},
    {'1': 'CUSTOM_ALLOCATION', '2': 3},
  ],
};

/// Descriptor for `FundDistributionMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fundDistributionModeDescriptor = $convert.base64Decode(
    'ChRGdW5kRGlzdHJpYnV0aW9uTW9kZRImCiJGVU5EX0RJU1RSSUJVVElPTl9NT0RFX1VOU1BFQ0'
    'lGSUVEEAASDwoLU0hBUkVEX1BPT0wQARIPCgtFUVVBTF9TUExJVBACEhUKEUNVU1RPTV9BTExP'
    'Q0FUSU9OEAM=');

@$core.Deprecated('Use adminListFamilyAccountsRequestDescriptor instead')
const AdminListFamilyAccountsRequest$json = {
  '1': 'AdminListFamilyAccountsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'creator_id', '3': 2, '4': 1, '5': 9, '10': 'creatorId'},
    {'1': 'min_members', '3': 3, '4': 1, '5': 5, '10': 'minMembers'},
    {'1': 'created_after', '3': 4, '4': 1, '5': 9, '10': 'createdAfter'},
    {'1': 'created_before', '3': 5, '4': 1, '5': 9, '10': 'createdBefore'},
    {'1': 'search', '3': 6, '4': 1, '5': 9, '10': 'search'},
    {'1': 'page', '3': 7, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 8, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `AdminListFamilyAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListFamilyAccountsRequestDescriptor = $convert.base64Decode(
    'Ch5BZG1pbkxpc3RGYW1pbHlBY2NvdW50c1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dX'
    'MSHQoKY3JlYXRvcl9pZBgCIAEoCVIJY3JlYXRvcklkEh8KC21pbl9tZW1iZXJzGAMgASgFUgpt'
    'aW5NZW1iZXJzEiMKDWNyZWF0ZWRfYWZ0ZXIYBCABKAlSDGNyZWF0ZWRBZnRlchIlCg5jcmVhdG'
    'VkX2JlZm9yZRgFIAEoCVINY3JlYXRlZEJlZm9yZRIWCgZzZWFyY2gYBiABKAlSBnNlYXJjaBIS'
    'CgRwYWdlGAcgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgIIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use adminListFamilyAccountsResponseDescriptor instead')
const AdminListFamilyAccountsResponse$json = {
  '1': 'AdminListFamilyAccountsResponse',
  '2': [
    {
      '1': 'family_accounts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccounts'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'total_pages', '3': 5, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `AdminListFamilyAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListFamilyAccountsResponseDescriptor = $convert.base64Decode(
    'Ch9BZG1pbkxpc3RGYW1pbHlBY2NvdW50c1Jlc3BvbnNlEkMKD2ZhbWlseV9hY2NvdW50cxgBIA'
    'MoCzIaLmFjY291bnRzLnYxLkZhbWlseUFjY291bnRSDmZhbWlseUFjY291bnRzEh8KC3RvdGFs'
    'X2NvdW50GAIgASgFUgp0b3RhbENvdW50EhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaX'
    'plGAQgASgFUghwYWdlU2l6ZRIfCgt0b3RhbF9wYWdlcxgFIAEoBVIKdG90YWxQYWdlcw==');

@$core.Deprecated('Use adminGetFamilyAccountRequestDescriptor instead')
const AdminGetFamilyAccountRequest$json = {
  '1': 'AdminGetFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
  ],
};

/// Descriptor for `AdminGetFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'ChxBZG1pbkdldEZhbWlseUFjY291bnRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaW'
        'x5SWQ=');

@$core.Deprecated('Use adminGetFamilyAccountResponseDescriptor instead')
const AdminGetFamilyAccountResponse$json = {
  '1': 'AdminGetFamilyAccountResponse',
  '2': [
    {
      '1': 'family_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {
      '1': 'recent_transactions',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.FamilyTransaction',
      '10': 'recentTransactions'
    },
    {
      '1': 'summary',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccountSummary',
      '10': 'summary'
    },
    {'1': 'admin_notes', '3': 4, '4': 1, '5': 9, '10': 'adminNotes'},
    {
      '1': 'admin_frozen_reason',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'adminFrozenReason'
    },
    {
      '1': 'last_admin_action_at',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'lastAdminActionAt'
    },
    {
      '1': 'last_admin_action_by',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'lastAdminActionBy'
    },
  ],
};

/// Descriptor for `AdminGetFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetFamilyAccountResponseDescriptor = $convert.base64Decode(
    'Ch1BZG1pbkdldEZhbWlseUFjY291bnRSZXNwb25zZRJBCg5mYW1pbHlfYWNjb3VudBgBIAEoCz'
    'IaLmFjY291bnRzLnYxLkZhbWlseUFjY291bnRSDWZhbWlseUFjY291bnQSTwoTcmVjZW50X3Ry'
    'YW5zYWN0aW9ucxgCIAMoCzIeLmFjY291bnRzLnYxLkZhbWlseVRyYW5zYWN0aW9uUhJyZWNlbn'
    'RUcmFuc2FjdGlvbnMSOwoHc3VtbWFyeRgDIAEoCzIhLmFjY291bnRzLnYxLkZhbWlseUFjY291'
    'bnRTdW1tYXJ5UgdzdW1tYXJ5Eh8KC2FkbWluX25vdGVzGAQgASgJUgphZG1pbk5vdGVzEi4KE2'
    'FkbWluX2Zyb3plbl9yZWFzb24YBSABKAlSEWFkbWluRnJvemVuUmVhc29uEi8KFGxhc3RfYWRt'
    'aW5fYWN0aW9uX2F0GAYgASgJUhFsYXN0QWRtaW5BY3Rpb25BdBIvChRsYXN0X2FkbWluX2FjdG'
    'lvbl9ieRgHIAEoCVIRbGFzdEFkbWluQWN0aW9uQnk=');

@$core.Deprecated('Use adminFreezeFamilyAccountRequestDescriptor instead')
const AdminFreezeFamilyAccountRequest$json = {
  '1': 'AdminFreezeFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminFreezeFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFreezeFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'Ch9BZG1pbkZyZWV6ZUZhbWlseUFjY291bnRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZm'
        'FtaWx5SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use adminFreezeFamilyAccountResponseDescriptor instead')
const AdminFreezeFamilyAccountResponse$json = {
  '1': 'AdminFreezeFamilyAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'family_account',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminFreezeFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFreezeFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'CiBBZG1pbkZyZWV6ZUZhbWlseUFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
        'NjZXNzEkEKDmZhbWlseV9hY2NvdW50GAIgASgLMhouYWNjb3VudHMudjEuRmFtaWx5QWNjb3Vu'
        'dFINZmFtaWx5QWNjb3VudBIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use adminUnfreezeFamilyAccountRequestDescriptor instead')
const AdminUnfreezeFamilyAccountRequest$json = {
  '1': 'AdminUnfreezeFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminUnfreezeFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUnfreezeFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'CiFBZG1pblVuZnJlZXplRmFtaWx5QWNjb3VudFJlcXVlc3QSGwoJZmFtaWx5X2lkGAEgASgJUg'
        'hmYW1pbHlJZBIWCgZyZWFzb24YAiABKAlSBnJlYXNvbg==');

@$core.Deprecated('Use adminUnfreezeFamilyAccountResponseDescriptor instead')
const AdminUnfreezeFamilyAccountResponse$json = {
  '1': 'AdminUnfreezeFamilyAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'family_account',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminUnfreezeFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUnfreezeFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'CiJBZG1pblVuZnJlZXplRmFtaWx5QWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3'
        'N1Y2Nlc3MSQQoOZmFtaWx5X2FjY291bnQYAiABKAsyGi5hY2NvdW50cy52MS5GYW1pbHlBY2Nv'
        'dW50Ug1mYW1pbHlBY2NvdW50EhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use adminDeleteFamilyAccountRequestDescriptor instead')
const AdminDeleteFamilyAccountRequest$json = {
  '1': 'AdminDeleteFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminDeleteFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDeleteFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'Ch9BZG1pbkRlbGV0ZUZhbWlseUFjY291bnRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZm'
        'FtaWx5SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use adminDeleteFamilyAccountResponseDescriptor instead')
const AdminDeleteFamilyAccountResponse$json = {
  '1': 'AdminDeleteFamilyAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'returned_balance', '3': 2, '4': 1, '5': 1, '10': 'returnedBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminDeleteFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDeleteFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'CiBBZG1pbkRlbGV0ZUZhbWlseUFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
        'NjZXNzEikKEHJldHVybmVkX2JhbGFuY2UYAiABKAFSD3JldHVybmVkQmFsYW5jZRIYCgdtZXNz'
        'YWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use adminForceAllocateFundsRequestDescriptor instead')
const AdminForceAllocateFundsRequest$json = {
  '1': 'AdminForceAllocateFundsRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminForceAllocateFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceAllocateFundsRequestDescriptor =
    $convert.base64Decode(
        'Ch5BZG1pbkZvcmNlQWxsb2NhdGVGdW5kc1JlcXVlc3QSGwoJZmFtaWx5X2lkGAEgASgJUghmYW'
        '1pbHlJZBIbCgltZW1iZXJfaWQYAiABKAlSCG1lbWJlcklkEhYKBmFtb3VudBgDIAEoAVIGYW1v'
        'dW50EhYKBnJlYXNvbhgEIAEoCVIGcmVhc29u');

@$core.Deprecated('Use adminForceAllocateFundsResponseDescriptor instead')
const AdminForceAllocateFundsResponse$json = {
  '1': 'AdminForceAllocateFundsResponse',
  '2': [
    {
      '1': 'member',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyMember',
      '10': 'member'
    },
    {
      '1': 'transaction',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyTransaction',
      '10': 'transaction'
    },
    {
      '1': 'remaining_pool_balance',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'remainingPoolBalance'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminForceAllocateFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceAllocateFundsResponseDescriptor = $convert.base64Decode(
    'Ch9BZG1pbkZvcmNlQWxsb2NhdGVGdW5kc1Jlc3BvbnNlEjEKBm1lbWJlchgBIAEoCzIZLmFjY2'
    '91bnRzLnYxLkZhbWlseU1lbWJlclIGbWVtYmVyEkAKC3RyYW5zYWN0aW9uGAIgASgLMh4uYWNj'
    'b3VudHMudjEuRmFtaWx5VHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEjQKFnJlbWFpbmluZ19wb2'
    '9sX2JhbGFuY2UYAyABKAFSFHJlbWFpbmluZ1Bvb2xCYWxhbmNlEhgKB21lc3NhZ2UYBCABKAlS'
    'B21lc3NhZ2U=');

@$core.Deprecated('Use adminRemoveFamilyMemberRequestDescriptor instead')
const AdminRemoveFamilyMemberRequest$json = {
  '1': 'AdminRemoveFamilyMemberRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {
      '1': 'return_balance_to_pool',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'returnBalanceToPool'
    },
  ],
};

/// Descriptor for `AdminRemoveFamilyMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRemoveFamilyMemberRequestDescriptor =
    $convert.base64Decode(
        'Ch5BZG1pblJlbW92ZUZhbWlseU1lbWJlclJlcXVlc3QSGwoJZmFtaWx5X2lkGAEgASgJUghmYW'
        '1pbHlJZBIbCgltZW1iZXJfaWQYAiABKAlSCG1lbWJlcklkEhYKBnJlYXNvbhgDIAEoCVIGcmVh'
        'c29uEjMKFnJldHVybl9iYWxhbmNlX3RvX3Bvb2wYBCABKAhSE3JldHVybkJhbGFuY2VUb1Bvb2'
        'w=');

@$core.Deprecated('Use adminRemoveFamilyMemberResponseDescriptor instead')
const AdminRemoveFamilyMemberResponse$json = {
  '1': 'AdminRemoveFamilyMemberResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'returned_balance', '3': 2, '4': 1, '5': 1, '10': 'returnedBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminRemoveFamilyMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRemoveFamilyMemberResponseDescriptor =
    $convert.base64Decode(
        'Ch9BZG1pblJlbW92ZUZhbWlseU1lbWJlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
        'Nlc3MSKQoQcmV0dXJuZWRfYmFsYW5jZRgCIAEoAVIPcmV0dXJuZWRCYWxhbmNlEhgKB21lc3Nh'
        'Z2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use adminUpdateFamilyAccountNotesRequestDescriptor instead')
const AdminUpdateFamilyAccountNotesRequest$json = {
  '1': 'AdminUpdateFamilyAccountNotesRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'admin_notes', '3': 2, '4': 1, '5': 9, '10': 'adminNotes'},
  ],
};

/// Descriptor for `AdminUpdateFamilyAccountNotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateFamilyAccountNotesRequestDescriptor =
    $convert.base64Decode(
        'CiRBZG1pblVwZGF0ZUZhbWlseUFjY291bnROb3Rlc1JlcXVlc3QSGwoJZmFtaWx5X2lkGAEgAS'
        'gJUghmYW1pbHlJZBIfCgthZG1pbl9ub3RlcxgCIAEoCVIKYWRtaW5Ob3Rlcw==');

@$core.Deprecated('Use adminUpdateFamilyAccountNotesResponseDescriptor instead')
const AdminUpdateFamilyAccountNotesResponse$json = {
  '1': 'AdminUpdateFamilyAccountNotesResponse',
  '2': [
    {
      '1': 'family_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminUpdateFamilyAccountNotesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateFamilyAccountNotesResponseDescriptor =
    $convert.base64Decode(
        'CiVBZG1pblVwZGF0ZUZhbWlseUFjY291bnROb3Rlc1Jlc3BvbnNlEkEKDmZhbWlseV9hY2NvdW'
        '50GAEgASgLMhouYWNjb3VudHMudjEuRmFtaWx5QWNjb3VudFINZmFtaWx5QWNjb3VudBIYCgdt'
        'ZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use createFamilyAccountRequestDescriptor instead')
const CreateFamilyAccountRequest$json = {
  '1': 'CreateFamilyAccountRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'initial_currency', '3': 3, '4': 1, '5': 9, '10': 'initialCurrency'},
    {'1': 'initial_funding', '3': 4, '4': 1, '5': 1, '10': 'initialFunding'},
    {
      '1': 'allow_member_contributions',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'allowMemberContributions'
    },
  ],
};

/// Descriptor for `CreateFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFamilyAccountRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVGYW1pbHlBY2NvdW50UmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2'
    'NyaXB0aW9uGAIgASgJUgtkZXNjcmlwdGlvbhIpChBpbml0aWFsX2N1cnJlbmN5GAMgASgJUg9p'
    'bml0aWFsQ3VycmVuY3kSJwoPaW5pdGlhbF9mdW5kaW5nGAQgASgBUg5pbml0aWFsRnVuZGluZx'
    'I8ChphbGxvd19tZW1iZXJfY29udHJpYnV0aW9ucxgFIAEoCFIYYWxsb3dNZW1iZXJDb250cmli'
    'dXRpb25z');

@$core.Deprecated('Use createFamilyAccountResponseDescriptor instead')
const CreateFamilyAccountResponse$json = {
  '1': 'CreateFamilyAccountResponse',
  '2': [
    {
      '1': 'family_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'ChtDcmVhdGVGYW1pbHlBY2NvdW50UmVzcG9uc2USQQoOZmFtaWx5X2FjY291bnQYASABKAsyGi'
        '5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50EhgKB21lc3NhZ2UYAiAB'
        'KAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getFamilyAccountsRequestDescriptor instead')
const GetFamilyAccountsRequest$json = {
  '1': 'GetFamilyAccountsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetFamilyAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyAccountsRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRGYW1pbHlBY2NvdW50c1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use getFamilyAccountsResponseDescriptor instead')
const GetFamilyAccountsResponse$json = {
  '1': 'GetFamilyAccountsResponse',
  '2': [
    {
      '1': 'family_accounts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccounts'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetFamilyAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyAccountsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRGYW1pbHlBY2NvdW50c1Jlc3BvbnNlEkMKD2ZhbWlseV9hY2NvdW50cxgBIAMoCzIaLm'
    'FjY291bnRzLnYxLkZhbWlseUFjY291bnRSDmZhbWlseUFjY291bnRzEh8KC3RvdGFsX2NvdW50'
    'GAIgASgFUgp0b3RhbENvdW50');

@$core.Deprecated('Use getFamilyAccountRequestDescriptor instead')
const GetFamilyAccountRequest$json = {
  '1': 'GetFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
  ],
};

/// Descriptor for `GetFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRGYW1pbHlBY2NvdW50UmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseUlk');

@$core.Deprecated('Use getFamilyAccountResponseDescriptor instead')
const GetFamilyAccountResponse$json = {
  '1': 'GetFamilyAccountResponse',
  '2': [
    {
      '1': 'family_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {
      '1': 'recent_transactions',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.FamilyTransaction',
      '10': 'recentTransactions'
    },
    {
      '1': 'summary',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccountSummary',
      '10': 'summary'
    },
  ],
};

/// Descriptor for `GetFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyAccountResponseDescriptor = $convert.base64Decode(
    'ChhHZXRGYW1pbHlBY2NvdW50UmVzcG9uc2USQQoOZmFtaWx5X2FjY291bnQYASABKAsyGi5hY2'
    'NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50Ek8KE3JlY2VudF90cmFuc2Fj'
    'dGlvbnMYAiADKAsyHi5hY2NvdW50cy52MS5GYW1pbHlUcmFuc2FjdGlvblIScmVjZW50VHJhbn'
    'NhY3Rpb25zEjsKB3N1bW1hcnkYAyABKAsyIS5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50U3Vt'
    'bWFyeVIHc3VtbWFyeQ==');

@$core.Deprecated('Use addFamilyMemberRequestDescriptor instead')
const AddFamilyMemberRequest$json = {
  '1': 'AddFamilyMemberRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {
      '1': 'invitation_method',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'invitationMethod'
    },
    {
      '1': 'invitation_destination',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'invitationDestination'
    },
    {
      '1': 'initial_allocation',
      '3': 4,
      '4': 1,
      '5': 1,
      '10': 'initialAllocation'
    },
    {'1': 'daily_limit', '3': 5, '4': 1, '5': 1, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 6, '4': 1, '5': 1, '10': 'monthlyLimit'},
    {
      '1': 'per_transaction_limit',
      '3': 9,
      '4': 1,
      '5': 1,
      '10': 'perTransactionLimit'
    },
    {
      '1': 'allocation_percentage_cap',
      '3': 10,
      '4': 1,
      '5': 1,
      '10': 'allocationPercentageCap'
    },
    {'1': 'role', '3': 7, '4': 1, '5': 9, '10': 'role'},
    {'1': 'personal_message', '3': 8, '4': 1, '5': 9, '10': 'personalMessage'},
  ],
};

/// Descriptor for `AddFamilyMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFamilyMemberRequestDescriptor = $convert.base64Decode(
    'ChZBZGRGYW1pbHlNZW1iZXJSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSKw'
    'oRaW52aXRhdGlvbl9tZXRob2QYAiABKAlSEGludml0YXRpb25NZXRob2QSNQoWaW52aXRhdGlv'
    'bl9kZXN0aW5hdGlvbhgDIAEoCVIVaW52aXRhdGlvbkRlc3RpbmF0aW9uEi0KEmluaXRpYWxfYW'
    'xsb2NhdGlvbhgEIAEoAVIRaW5pdGlhbEFsbG9jYXRpb24SHwoLZGFpbHlfbGltaXQYBSABKAFS'
    'CmRhaWx5TGltaXQSIwoNbW9udGhseV9saW1pdBgGIAEoAVIMbW9udGhseUxpbWl0EjIKFXBlcl'
    '90cmFuc2FjdGlvbl9saW1pdBgJIAEoAVITcGVyVHJhbnNhY3Rpb25MaW1pdBI6ChlhbGxvY2F0'
    'aW9uX3BlcmNlbnRhZ2VfY2FwGAogASgBUhdhbGxvY2F0aW9uUGVyY2VudGFnZUNhcBISCgRyb2'
    'xlGAcgASgJUgRyb2xlEikKEHBlcnNvbmFsX21lc3NhZ2UYCCABKAlSD3BlcnNvbmFsTWVzc2Fn'
    'ZQ==');

@$core.Deprecated('Use addFamilyMemberResponseDescriptor instead')
const AddFamilyMemberResponse$json = {
  '1': 'AddFamilyMemberResponse',
  '2': [
    {
      '1': 'member',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyMember',
      '10': 'member'
    },
    {
      '1': 'invitation_message',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'invitationMessage'
    },
    {'1': 'invitation_link', '3': 3, '4': 1, '5': 9, '10': 'invitationLink'},
  ],
};

/// Descriptor for `AddFamilyMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFamilyMemberResponseDescriptor = $convert.base64Decode(
    'ChdBZGRGYW1pbHlNZW1iZXJSZXNwb25zZRIxCgZtZW1iZXIYASABKAsyGS5hY2NvdW50cy52MS'
    '5GYW1pbHlNZW1iZXJSBm1lbWJlchItChJpbnZpdGF0aW9uX21lc3NhZ2UYAiABKAlSEWludml0'
    'YXRpb25NZXNzYWdlEicKD2ludml0YXRpb25fbGluaxgDIAEoCVIOaW52aXRhdGlvbkxpbms=');

@$core.Deprecated('Use updateFamilyMemberRequestDescriptor instead')
const UpdateFamilyMemberRequest$json = {
  '1': 'UpdateFamilyMemberRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {
      '1': 'allocated_balance',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'allocatedBalance'
    },
    {
      '1': 'daily_spending_limit',
      '3': 4,
      '4': 1,
      '5': 1,
      '10': 'dailySpendingLimit'
    },
    {
      '1': 'monthly_spending_limit',
      '3': 5,
      '4': 1,
      '5': 1,
      '10': 'monthlySpendingLimit'
    },
    {
      '1': 'per_transaction_limit',
      '3': 7,
      '4': 1,
      '5': 1,
      '10': 'perTransactionLimit'
    },
    {
      '1': 'allocation_percentage_cap',
      '3': 8,
      '4': 1,
      '5': 1,
      '10': 'allocationPercentageCap'
    },
    {'1': 'role', '3': 6, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `UpdateFamilyMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFamilyMemberRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVGYW1pbHlNZW1iZXJSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SW'
    'QSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBIrChFhbGxvY2F0ZWRfYmFsYW5jZRgDIAEo'
    'AVIQYWxsb2NhdGVkQmFsYW5jZRIwChRkYWlseV9zcGVuZGluZ19saW1pdBgEIAEoAVISZGFpbH'
    'lTcGVuZGluZ0xpbWl0EjQKFm1vbnRobHlfc3BlbmRpbmdfbGltaXQYBSABKAFSFG1vbnRobHlT'
    'cGVuZGluZ0xpbWl0EjIKFXBlcl90cmFuc2FjdGlvbl9saW1pdBgHIAEoAVITcGVyVHJhbnNhY3'
    'Rpb25MaW1pdBI6ChlhbGxvY2F0aW9uX3BlcmNlbnRhZ2VfY2FwGAggASgBUhdhbGxvY2F0aW9u'
    'UGVyY2VudGFnZUNhcBISCgRyb2xlGAYgASgJUgRyb2xl');

@$core.Deprecated('Use updateFamilyMemberResponseDescriptor instead')
const UpdateFamilyMemberResponse$json = {
  '1': 'UpdateFamilyMemberResponse',
  '2': [
    {
      '1': 'member',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyMember',
      '10': 'member'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateFamilyMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFamilyMemberResponseDescriptor =
    $convert.base64Decode(
        'ChpVcGRhdGVGYW1pbHlNZW1iZXJSZXNwb25zZRIxCgZtZW1iZXIYASABKAsyGS5hY2NvdW50cy'
        '52MS5GYW1pbHlNZW1iZXJSBm1lbWJlchIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use removeFamilyMemberRequestDescriptor instead')
const RemoveFamilyMemberRequest$json = {
  '1': 'RemoveFamilyMemberRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {
      '1': 'return_balance_to_pool',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'returnBalanceToPool'
    },
  ],
};

/// Descriptor for `RemoveFamilyMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFamilyMemberRequestDescriptor = $convert.base64Decode(
    'ChlSZW1vdmVGYW1pbHlNZW1iZXJSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SW'
    'QSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhIz'
    'ChZyZXR1cm5fYmFsYW5jZV90b19wb29sGAQgASgIUhNyZXR1cm5CYWxhbmNlVG9Qb29s');

@$core.Deprecated('Use removeFamilyMemberResponseDescriptor instead')
const RemoveFamilyMemberResponse$json = {
  '1': 'RemoveFamilyMemberResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'returned_balance', '3': 3, '4': 1, '5': 1, '10': 'returnedBalance'},
  ],
};

/// Descriptor for `RemoveFamilyMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFamilyMemberResponseDescriptor =
    $convert.base64Decode(
        'ChpSZW1vdmVGYW1pbHlNZW1iZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
        'gKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USKQoQcmV0dXJuZWRfYmFsYW5jZRgDIAEoAVIPcmV0'
        'dXJuZWRCYWxhbmNl');

@$core.Deprecated('Use acceptFamilyInvitationRequestDescriptor instead')
const AcceptFamilyInvitationRequest$json = {
  '1': 'AcceptFamilyInvitationRequest',
  '2': [
    {'1': 'invitation_token', '3': 1, '4': 1, '5': 9, '10': 'invitationToken'},
  ],
};

/// Descriptor for `AcceptFamilyInvitationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptFamilyInvitationRequestDescriptor =
    $convert.base64Decode(
        'Ch1BY2NlcHRGYW1pbHlJbnZpdGF0aW9uUmVxdWVzdBIpChBpbnZpdGF0aW9uX3Rva2VuGAEgAS'
        'gJUg9pbnZpdGF0aW9uVG9rZW4=');

@$core.Deprecated('Use acceptFamilyInvitationResponseDescriptor instead')
const AcceptFamilyInvitationResponse$json = {
  '1': 'AcceptFamilyInvitationResponse',
  '2': [
    {
      '1': 'family_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {
      '1': 'member',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyMember',
      '10': 'member'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AcceptFamilyInvitationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptFamilyInvitationResponseDescriptor =
    $convert.base64Decode(
        'Ch5BY2NlcHRGYW1pbHlJbnZpdGF0aW9uUmVzcG9uc2USQQoOZmFtaWx5X2FjY291bnQYASABKA'
        'syGi5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50EjEKBm1lbWJlchgC'
        'IAEoCzIZLmFjY291bnRzLnYxLkZhbWlseU1lbWJlclIGbWVtYmVyEhgKB21lc3NhZ2UYAyABKA'
        'lSB21lc3NhZ2U=');

@$core.Deprecated('Use declineFamilyInvitationRequestDescriptor instead')
const DeclineFamilyInvitationRequest$json = {
  '1': 'DeclineFamilyInvitationRequest',
  '2': [
    {'1': 'invitation_token', '3': 1, '4': 1, '5': 9, '10': 'invitationToken'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `DeclineFamilyInvitationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineFamilyInvitationRequestDescriptor =
    $convert.base64Decode(
        'Ch5EZWNsaW5lRmFtaWx5SW52aXRhdGlvblJlcXVlc3QSKQoQaW52aXRhdGlvbl90b2tlbhgBIA'
        'EoCVIPaW52aXRhdGlvblRva2VuEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');

@$core.Deprecated('Use declineFamilyInvitationResponseDescriptor instead')
const DeclineFamilyInvitationResponse$json = {
  '1': 'DeclineFamilyInvitationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeclineFamilyInvitationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineFamilyInvitationResponseDescriptor =
    $convert.base64Decode(
        'Ch9EZWNsaW5lRmFtaWx5SW52aXRhdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
        'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getPendingInvitationsRequestDescriptor instead')
const GetPendingInvitationsRequest$json = {
  '1': 'GetPendingInvitationsRequest',
};

/// Descriptor for `GetPendingInvitationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingInvitationsRequestDescriptor =
    $convert.base64Decode('ChxHZXRQZW5kaW5nSW52aXRhdGlvbnNSZXF1ZXN0');

@$core.Deprecated('Use getPendingInvitationsResponseDescriptor instead')
const GetPendingInvitationsResponse$json = {
  '1': 'GetPendingInvitationsResponse',
  '2': [
    {
      '1': 'invitations',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.PendingInvitation',
      '10': 'invitations'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetPendingInvitationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingInvitationsResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRQZW5kaW5nSW52aXRhdGlvbnNSZXNwb25zZRJACgtpbnZpdGF0aW9ucxgBIAMoCzIeLm'
        'FjY291bnRzLnYxLlBlbmRpbmdJbnZpdGF0aW9uUgtpbnZpdGF0aW9ucxIfCgt0b3RhbF9jb3Vu'
        'dBgCIAEoBVIKdG90YWxDb3VudA==');

@$core.Deprecated('Use getMyInvitationHistoryRequestDescriptor instead')
const GetMyInvitationHistoryRequest$json = {
  '1': 'GetMyInvitationHistoryRequest',
  '2': [
    {'1': 'status_filter', '3': 1, '4': 1, '5': 9, '10': 'statusFilter'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetMyInvitationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyInvitationHistoryRequestDescriptor =
    $convert.base64Decode(
        'Ch1HZXRNeUludml0YXRpb25IaXN0b3J5UmVxdWVzdBIjCg1zdGF0dXNfZmlsdGVyGAEgASgJUg'
        'xzdGF0dXNGaWx0ZXISEgoEcGFnZRgCIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAyABKAVSCHBh'
        'Z2VTaXpl');

@$core.Deprecated('Use invitationHistoryEntryDescriptor instead')
const InvitationHistoryEntry$json = {
  '1': 'InvitationHistoryEntry',
  '2': [
    {'1': 'invitation_token', '3': 1, '4': 1, '5': 9, '10': 'invitationToken'},
    {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'family_name', '3': 3, '4': 1, '5': 9, '10': 'familyName'},
    {'1': 'creator_name', '3': 4, '4': 1, '5': 9, '10': 'creatorName'},
    {'1': 'creator_avatar', '3': 5, '4': 1, '5': 9, '10': 'creatorAvatar'},
    {'1': 'invited_by', '3': 6, '4': 1, '5': 9, '10': 'invitedBy'},
    {
      '1': 'invitation_status',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'invitationStatus'
    },
    {
      '1': 'initial_allocation',
      '3': 8,
      '4': 1,
      '5': 1,
      '10': 'initialAllocation'
    },
    {'1': 'daily_limit', '3': 9, '4': 1, '5': 1, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 10, '4': 1, '5': 1, '10': 'monthlyLimit'},
    {
      '1': 'invitation_method',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'invitationMethod'
    },
    {
      '1': 'invitation_destination',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'invitationDestination'
    },
    {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'expires_at', '3': 14, '4': 1, '5': 9, '10': 'expiresAt'},
    {'1': 'responded_at', '3': 15, '4': 1, '5': 9, '10': 'respondedAt'},
  ],
};

/// Descriptor for `InvitationHistoryEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invitationHistoryEntryDescriptor = $convert.base64Decode(
    'ChZJbnZpdGF0aW9uSGlzdG9yeUVudHJ5EikKEGludml0YXRpb25fdG9rZW4YASABKAlSD2ludm'
    'l0YXRpb25Ub2tlbhIbCglmYW1pbHlfaWQYAiABKAlSCGZhbWlseUlkEh8KC2ZhbWlseV9uYW1l'
    'GAMgASgJUgpmYW1pbHlOYW1lEiEKDGNyZWF0b3JfbmFtZRgEIAEoCVILY3JlYXRvck5hbWUSJQ'
    'oOY3JlYXRvcl9hdmF0YXIYBSABKAlSDWNyZWF0b3JBdmF0YXISHQoKaW52aXRlZF9ieRgGIAEo'
    'CVIJaW52aXRlZEJ5EisKEWludml0YXRpb25fc3RhdHVzGAcgASgJUhBpbnZpdGF0aW9uU3RhdH'
    'VzEi0KEmluaXRpYWxfYWxsb2NhdGlvbhgIIAEoAVIRaW5pdGlhbEFsbG9jYXRpb24SHwoLZGFp'
    'bHlfbGltaXQYCSABKAFSCmRhaWx5TGltaXQSIwoNbW9udGhseV9saW1pdBgKIAEoAVIMbW9udG'
    'hseUxpbWl0EisKEWludml0YXRpb25fbWV0aG9kGAsgASgJUhBpbnZpdGF0aW9uTWV0aG9kEjUK'
    'Fmludml0YXRpb25fZGVzdGluYXRpb24YDCABKAlSFWludml0YXRpb25EZXN0aW5hdGlvbhIdCg'
    'pjcmVhdGVkX2F0GA0gASgJUgljcmVhdGVkQXQSHQoKZXhwaXJlc19hdBgOIAEoCVIJZXhwaXJl'
    'c0F0EiEKDHJlc3BvbmRlZF9hdBgPIAEoCVILcmVzcG9uZGVkQXQ=');

@$core.Deprecated('Use getMyInvitationHistoryResponseDescriptor instead')
const GetMyInvitationHistoryResponse$json = {
  '1': 'GetMyInvitationHistoryResponse',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.InvitationHistoryEntry',
      '10': 'entries'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'total_pages', '3': 5, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetMyInvitationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyInvitationHistoryResponseDescriptor =
    $convert.base64Decode(
        'Ch5HZXRNeUludml0YXRpb25IaXN0b3J5UmVzcG9uc2USPQoHZW50cmllcxgBIAMoCzIjLmFjY2'
        '91bnRzLnYxLkludml0YXRpb25IaXN0b3J5RW50cnlSB2VudHJpZXMSHwoLdG90YWxfY291bnQY'
        'AiABKAVSCnRvdGFsQ291bnQSEgoEcGFnZRgDIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYBCABKA'
        'VSCHBhZ2VTaXplEh8KC3RvdGFsX3BhZ2VzGAUgASgFUgp0b3RhbFBhZ2Vz');

@$core.Deprecated('Use getSentInvitationsRequestDescriptor instead')
const GetSentInvitationsRequest$json = {
  '1': 'GetSentInvitationsRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'status_filter', '3': 2, '4': 1, '5': 9, '10': 'statusFilter'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetSentInvitationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSentInvitationsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRTZW50SW52aXRhdGlvbnNSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SW'
    'QSIwoNc3RhdHVzX2ZpbHRlchgCIAEoCVIMc3RhdHVzRmlsdGVyEhIKBHBhZ2UYAyABKAVSBHBh'
    'Z2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use sentInvitationEntryDescriptor instead')
const SentInvitationEntry$json = {
  '1': 'SentInvitationEntry',
  '2': [
    {'1': 'member_id', '3': 1, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'family_name', '3': 3, '4': 1, '5': 9, '10': 'familyName'},
    {
      '1': 'invitation_method',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'invitationMethod'
    },
    {
      '1': 'invitation_destination',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'invitationDestination'
    },
    {
      '1': 'invitation_status',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'invitationStatus'
    },
    {'1': 'invited_user_id', '3': 7, '4': 1, '5': 9, '10': 'invitedUserId'},
    {'1': 'invited_user_name', '3': 8, '4': 1, '5': 9, '10': 'invitedUserName'},
    {
      '1': 'invited_user_avatar',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'invitedUserAvatar'
    },
    {
      '1': 'initial_allocation',
      '3': 10,
      '4': 1,
      '5': 1,
      '10': 'initialAllocation'
    },
    {'1': 'daily_limit', '3': 11, '4': 1, '5': 1, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 12, '4': 1, '5': 1, '10': 'monthlyLimit'},
    {'1': 'role', '3': 13, '4': 1, '5': 9, '10': 'role'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'expires_at', '3': 15, '4': 1, '5': 9, '10': 'expiresAt'},
    {'1': 'responded_at', '3': 16, '4': 1, '5': 9, '10': 'respondedAt'},
  ],
};

/// Descriptor for `SentInvitationEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sentInvitationEntryDescriptor = $convert.base64Decode(
    'ChNTZW50SW52aXRhdGlvbkVudHJ5EhsKCW1lbWJlcl9pZBgBIAEoCVIIbWVtYmVySWQSGwoJZm'
    'FtaWx5X2lkGAIgASgJUghmYW1pbHlJZBIfCgtmYW1pbHlfbmFtZRgDIAEoCVIKZmFtaWx5TmFt'
    'ZRIrChFpbnZpdGF0aW9uX21ldGhvZBgEIAEoCVIQaW52aXRhdGlvbk1ldGhvZBI1ChZpbnZpdG'
    'F0aW9uX2Rlc3RpbmF0aW9uGAUgASgJUhVpbnZpdGF0aW9uRGVzdGluYXRpb24SKwoRaW52aXRh'
    'dGlvbl9zdGF0dXMYBiABKAlSEGludml0YXRpb25TdGF0dXMSJgoPaW52aXRlZF91c2VyX2lkGA'
    'cgASgJUg1pbnZpdGVkVXNlcklkEioKEWludml0ZWRfdXNlcl9uYW1lGAggASgJUg9pbnZpdGVk'
    'VXNlck5hbWUSLgoTaW52aXRlZF91c2VyX2F2YXRhchgJIAEoCVIRaW52aXRlZFVzZXJBdmF0YX'
    'ISLQoSaW5pdGlhbF9hbGxvY2F0aW9uGAogASgBUhFpbml0aWFsQWxsb2NhdGlvbhIfCgtkYWls'
    'eV9saW1pdBgLIAEoAVIKZGFpbHlMaW1pdBIjCg1tb250aGx5X2xpbWl0GAwgASgBUgxtb250aG'
    'x5TGltaXQSEgoEcm9sZRgNIAEoCVIEcm9sZRIdCgpjcmVhdGVkX2F0GA4gASgJUgljcmVhdGVk'
    'QXQSHQoKZXhwaXJlc19hdBgPIAEoCVIJZXhwaXJlc0F0EiEKDHJlc3BvbmRlZF9hdBgQIAEoCV'
    'ILcmVzcG9uZGVkQXQ=');

@$core.Deprecated('Use getSentInvitationsResponseDescriptor instead')
const GetSentInvitationsResponse$json = {
  '1': 'GetSentInvitationsResponse',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.SentInvitationEntry',
      '10': 'entries'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'total_pages', '3': 5, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetSentInvitationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSentInvitationsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRTZW50SW52aXRhdGlvbnNSZXNwb25zZRI6CgdlbnRyaWVzGAEgAygLMiAuYWNjb3VudH'
    'MudjEuU2VudEludml0YXRpb25FbnRyeVIHZW50cmllcxIfCgt0b3RhbF9jb3VudBgCIAEoBVIK'
    'dG90YWxDb3VudBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZV'
    'NpemUSHwoLdG90YWxfcGFnZXMYBSABKAVSCnRvdGFsUGFnZXM=');

@$core.Deprecated('Use getFamilyTransactionsRequestDescriptor instead')
const GetFamilyTransactionsRequest$json = {
  '1': 'GetFamilyTransactionsRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 5, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'start_date', '3': 6, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 7, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetFamilyTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyTransactionsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRGYW1pbHlUcmFuc2FjdGlvbnNSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaW'
    'x5SWQSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBISCgR0eXBlGAMgASgJUgR0eXBlEhIK'
    'BHBhZ2UYBCABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAUgASgFUghwYWdlU2l6ZRIdCgpzdGFydF'
    '9kYXRlGAYgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYByABKAlSB2VuZERhdGU=');

@$core.Deprecated('Use getFamilyTransactionsResponseDescriptor instead')
const GetFamilyTransactionsResponse$json = {
  '1': 'GetFamilyTransactionsResponse',
  '2': [
    {
      '1': 'transactions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.FamilyTransaction',
      '10': 'transactions'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'total_pages', '3': 5, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetFamilyTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyTransactionsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRGYW1pbHlUcmFuc2FjdGlvbnNSZXNwb25zZRJCCgx0cmFuc2FjdGlvbnMYASADKAsyHi'
    '5hY2NvdW50cy52MS5GYW1pbHlUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEh8KC3RvdGFsX2Nv'
    'dW50GAIgASgFUgp0b3RhbENvdW50EhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGA'
    'QgASgFUghwYWdlU2l6ZRIfCgt0b3RhbF9wYWdlcxgFIAEoBVIKdG90YWxQYWdlcw==');

@$core.Deprecated('Use allocateFundsRequestDescriptor instead')
const AllocateFundsRequest$json = {
  '1': 'AllocateFundsRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `AllocateFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allocateFundsRequestDescriptor = $convert.base64Decode(
    'ChRBbGxvY2F0ZUZ1bmRzUmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseUlkEhsKCW'
    '1lbWJlcl9pZBgCIAEoCVIIbWVtYmVySWQSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSIAoLZGVz'
    'Y3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEicKD2lkZW1wb3RlbmN5X2tleRgFIAEoCVIOaW'
    'RlbXBvdGVuY3lLZXk=');

@$core.Deprecated('Use allocateFundsResponseDescriptor instead')
const AllocateFundsResponse$json = {
  '1': 'AllocateFundsResponse',
  '2': [
    {
      '1': 'member',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyMember',
      '10': 'member'
    },
    {
      '1': 'transaction',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyTransaction',
      '10': 'transaction'
    },
    {
      '1': 'remaining_pool_balance',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'remainingPoolBalance'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AllocateFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allocateFundsResponseDescriptor = $convert.base64Decode(
    'ChVBbGxvY2F0ZUZ1bmRzUmVzcG9uc2USMQoGbWVtYmVyGAEgASgLMhkuYWNjb3VudHMudjEuRm'
    'FtaWx5TWVtYmVyUgZtZW1iZXISQAoLdHJhbnNhY3Rpb24YAiABKAsyHi5hY2NvdW50cy52MS5G'
    'YW1pbHlUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24SNAoWcmVtYWluaW5nX3Bvb2xfYmFsYW5jZR'
    'gDIAEoAVIUcmVtYWluaW5nUG9vbEJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use generateMemberCardRequestDescriptor instead')
const GenerateMemberCardRequest$json = {
  '1': 'GenerateMemberCardRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'card_name', '3': 3, '4': 1, '5': 9, '10': 'cardName'},
  ],
};

/// Descriptor for `GenerateMemberCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateMemberCardRequestDescriptor = $convert.base64Decode(
    'ChlHZW5lcmF0ZU1lbWJlckNhcmRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SW'
    'QSGwoJbWVtYmVyX2lkGAIgASgJUghtZW1iZXJJZBIbCgljYXJkX25hbWUYAyABKAlSCGNhcmRO'
    'YW1l');

@$core.Deprecated('Use generateMemberCardResponseDescriptor instead')
const GenerateMemberCardResponse$json = {
  '1': 'GenerateMemberCardResponse',
  '2': [
    {
      '1': 'card',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.AccountCard',
      '10': 'card'
    },
    {
      '1': 'member',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyMember',
      '10': 'member'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateMemberCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateMemberCardResponseDescriptor =
    $convert.base64Decode(
        'ChpHZW5lcmF0ZU1lbWJlckNhcmRSZXNwb25zZRIpCgRjYXJkGAEgASgLMhUuYWNjb3VudHMuQW'
        'Njb3VudENhcmRSBGNhcmQSMQoGbWVtYmVyGAIgASgLMhkuYWNjb3VudHMudjEuRmFtaWx5TWVt'
        'YmVyUgZtZW1iZXISGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use freezeFamilyAccountRequestDescriptor instead')
const FreezeFamilyAccountRequest$json = {
  '1': 'FreezeFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `FreezeFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'ChpGcmVlemVGYW1pbHlBY2NvdW50UmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseU'
        'lkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');

@$core.Deprecated('Use freezeFamilyAccountResponseDescriptor instead')
const FreezeFamilyAccountResponse$json = {
  '1': 'FreezeFamilyAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'family_account',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
  ],
};

/// Descriptor for `FreezeFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'ChtGcmVlemVGYW1pbHlBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
        'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEkEKDmZhbWlseV9hY2NvdW50GAMgASgLMhouYWNj'
        'b3VudHMudjEuRmFtaWx5QWNjb3VudFINZmFtaWx5QWNjb3VudA==');

@$core.Deprecated('Use unfreezeFamilyAccountRequestDescriptor instead')
const UnfreezeFamilyAccountRequest$json = {
  '1': 'UnfreezeFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
  ],
};

/// Descriptor for `UnfreezeFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'ChxVbmZyZWV6ZUZhbWlseUFjY291bnRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaW'
        'x5SWQ=');

@$core.Deprecated('Use unfreezeFamilyAccountResponseDescriptor instead')
const UnfreezeFamilyAccountResponse$json = {
  '1': 'UnfreezeFamilyAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'family_account',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
  ],
};

/// Descriptor for `UnfreezeFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'Ch1VbmZyZWV6ZUZhbWlseUFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
        'NzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USQQoOZmFtaWx5X2FjY291bnQYAyABKAsyGi5h'
        'Y2NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50');

@$core.Deprecated('Use deleteFamilyAccountRequestDescriptor instead')
const DeleteFamilyAccountRequest$json = {
  '1': 'DeleteFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {
      '1': 'confirmation_code',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'confirmationCode'
    },
  ],
};

/// Descriptor for `DeleteFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'ChpEZWxldGVGYW1pbHlBY2NvdW50UmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseU'
        'lkEisKEWNvbmZpcm1hdGlvbl9jb2RlGAIgASgJUhBjb25maXJtYXRpb25Db2Rl');

@$core.Deprecated('Use deleteFamilyAccountResponseDescriptor instead')
const DeleteFamilyAccountResponse$json = {
  '1': 'DeleteFamilyAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'returned_balance', '3': 3, '4': 1, '5': 1, '10': 'returnedBalance'},
  ],
};

/// Descriptor for `DeleteFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'ChtEZWxldGVGYW1pbHlBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
        'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEikKEHJldHVybmVkX2JhbGFuY2UYAyABKAFSD3Jl'
        'dHVybmVkQmFsYW5jZQ==');

@$core.Deprecated('Use leaveFamilyAccountRequestDescriptor instead')
const LeaveFamilyAccountRequest$json = {
  '1': 'LeaveFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
  ],
};

/// Descriptor for `LeaveFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveFamilyAccountRequestDescriptor =
    $convert.base64Decode(
        'ChlMZWF2ZUZhbWlseUFjY291bnRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SW'
        'Q=');

@$core.Deprecated('Use leaveFamilyAccountResponseDescriptor instead')
const LeaveFamilyAccountResponse$json = {
  '1': 'LeaveFamilyAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'returned_balance', '3': 3, '4': 1, '5': 1, '10': 'returnedBalance'},
  ],
};

/// Descriptor for `LeaveFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'ChpMZWF2ZUZhbWlseUFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
        'gKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USKQoQcmV0dXJuZWRfYmFsYW5jZRgDIAEoAVIPcmV0'
        'dXJuZWRCYWxhbmNl');

@$core.Deprecated('Use processMemberContributionRequestDescriptor instead')
const ProcessMemberContributionRequest$json = {
  '1': 'ProcessMemberContributionRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 2, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ProcessMemberContributionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processMemberContributionRequestDescriptor =
    $convert.base64Decode(
        'CiBQcm9jZXNzTWVtYmVyQ29udHJpYnV0aW9uUmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCG'
        'ZhbWlseUlkEhsKCW1lbWJlcl9pZBgCIAEoCVIIbWVtYmVySWQSFgoGYW1vdW50GAMgASgBUgZh'
        'bW91bnQSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEicKD2lkZW1wb3RlbmN5X2'
        'tleRgFIAEoCVIOaWRlbXBvdGVuY3lLZXk=');

@$core.Deprecated('Use processMemberContributionResponseDescriptor instead')
const ProcessMemberContributionResponse$json = {
  '1': 'ProcessMemberContributionResponse',
  '2': [
    {
      '1': 'family_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {
      '1': 'transaction',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyTransaction',
      '10': 'transaction'
    },
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessMemberContributionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processMemberContributionResponseDescriptor =
    $convert.base64Decode(
        'CiFQcm9jZXNzTWVtYmVyQ29udHJpYnV0aW9uUmVzcG9uc2USQQoOZmFtaWx5X2FjY291bnQYAS'
        'ABKAsyGi5hY2NvdW50cy52MS5GYW1pbHlBY2NvdW50Ug1mYW1pbHlBY2NvdW50EkAKC3RyYW5z'
        'YWN0aW9uGAIgASgLMh4uYWNjb3VudHMudjEuRmFtaWx5VHJhbnNhY3Rpb25SC3RyYW5zYWN0aW'
        '9uEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use setupFamilyAccountRequestDescriptor instead')
const SetupFamilyAccountRequest$json = {
  '1': 'SetupFamilyAccountRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {
      '1': 'fund_distribution_mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.accounts.v1.FundDistributionMode',
      '10': 'fundDistributionMode'
    },
    {
      '1': 'spending_visibility_enabled',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'spendingVisibilityEnabled'
    },
    {
      '1': 'allocations',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.MemberAllocation',
      '10': 'allocations'
    },
  ],
};

/// Descriptor for `SetupFamilyAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setupFamilyAccountRequestDescriptor = $convert.base64Decode(
    'ChlTZXR1cEZhbWlseUFjY291bnRSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SW'
    'QSVwoWZnVuZF9kaXN0cmlidXRpb25fbW9kZRgCIAEoDjIhLmFjY291bnRzLnYxLkZ1bmREaXN0'
    'cmlidXRpb25Nb2RlUhRmdW5kRGlzdHJpYnV0aW9uTW9kZRI+ChtzcGVuZGluZ192aXNpYmlsaX'
    'R5X2VuYWJsZWQYAyABKAhSGXNwZW5kaW5nVmlzaWJpbGl0eUVuYWJsZWQSPwoLYWxsb2NhdGlv'
    'bnMYBCADKAsyHS5hY2NvdW50cy52MS5NZW1iZXJBbGxvY2F0aW9uUgthbGxvY2F0aW9ucw==');

@$core.Deprecated('Use memberAllocationDescriptor instead')
const MemberAllocation$json = {
  '1': 'MemberAllocation',
  '2': [
    {'1': 'member_id', '3': 1, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `MemberAllocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberAllocationDescriptor = $convert.base64Decode(
    'ChBNZW1iZXJBbGxvY2F0aW9uEhsKCW1lbWJlcl9pZBgBIAEoCVIIbWVtYmVySWQSFgoGYW1vdW'
    '50GAIgASgBUgZhbW91bnQ=');

@$core.Deprecated('Use setupFamilyAccountResponseDescriptor instead')
const SetupFamilyAccountResponse$json = {
  '1': 'SetupFamilyAccountResponse',
  '2': [
    {
      '1': 'family_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SetupFamilyAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setupFamilyAccountResponseDescriptor =
    $convert.base64Decode(
        'ChpTZXR1cEZhbWlseUFjY291bnRSZXNwb25zZRJBCg5mYW1pbHlfYWNjb3VudBgBIAEoCzIaLm'
        'FjY291bnRzLnYxLkZhbWlseUFjY291bnRSDWZhbWlseUFjY291bnQSGAoHbWVzc2FnZRgCIAEo'
        'CVIHbWVzc2FnZQ==');

@$core.Deprecated('Use updateFundDistributionModeRequestDescriptor instead')
const UpdateFundDistributionModeRequest$json = {
  '1': 'UpdateFundDistributionModeRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {
      '1': 'fund_distribution_mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.accounts.v1.FundDistributionMode',
      '10': 'fundDistributionMode'
    },
    {
      '1': 'allocations',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.MemberAllocation',
      '10': 'allocations'
    },
  ],
};

/// Descriptor for `UpdateFundDistributionModeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFundDistributionModeRequestDescriptor =
    $convert.base64Decode(
        'CiFVcGRhdGVGdW5kRGlzdHJpYnV0aW9uTW9kZVJlcXVlc3QSGwoJZmFtaWx5X2lkGAEgASgJUg'
        'hmYW1pbHlJZBJXChZmdW5kX2Rpc3RyaWJ1dGlvbl9tb2RlGAIgASgOMiEuYWNjb3VudHMudjEu'
        'RnVuZERpc3RyaWJ1dGlvbk1vZGVSFGZ1bmREaXN0cmlidXRpb25Nb2RlEj8KC2FsbG9jYXRpb2'
        '5zGAMgAygLMh0uYWNjb3VudHMudjEuTWVtYmVyQWxsb2NhdGlvblILYWxsb2NhdGlvbnM=');

@$core.Deprecated('Use updateFundDistributionModeResponseDescriptor instead')
const UpdateFundDistributionModeResponse$json = {
  '1': 'UpdateFundDistributionModeResponse',
  '2': [
    {
      '1': 'family_account',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.accounts.v1.FamilyAccount',
      '10': 'familyAccount'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateFundDistributionModeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFundDistributionModeResponseDescriptor =
    $convert.base64Decode(
        'CiJVcGRhdGVGdW5kRGlzdHJpYnV0aW9uTW9kZVJlc3BvbnNlEkEKDmZhbWlseV9hY2NvdW50GA'
        'EgASgLMhouYWNjb3VudHMudjEuRmFtaWx5QWNjb3VudFINZmFtaWx5QWNjb3VudBIYCgdtZXNz'
        'YWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use familyAccountDescriptor instead')
const FamilyAccount$json = {
  '1': 'FamilyAccount',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'creator_id', '3': 2, '4': 1, '5': 9, '10': 'creatorId'},
    {'1': 'creator_name', '3': 3, '4': 1, '5': 9, '10': 'creatorName'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'total_allocated_balance',
      '3': 6,
      '4': 1,
      '5': 1,
      '10': 'totalAllocatedBalance'
    },
    {
      '1': 'total_pool_balance',
      '3': 7,
      '4': 1,
      '5': 1,
      '10': 'totalPoolBalance'
    },
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 9, '10': 'updatedAt'},
    {
      '1': 'members',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.FamilyMember',
      '10': 'members'
    },
    {'1': 'member_count', '3': 12, '4': 1, '5': 5, '10': 'memberCount'},
    {
      '1': 'active_member_count',
      '3': 13,
      '4': 1,
      '5': 5,
      '10': 'activeMemberCount'
    },
    {
      '1': 'allow_member_contributions',
      '3': 14,
      '4': 1,
      '5': 8,
      '10': 'allowMemberContributions'
    },
    {'1': 'total_balance', '3': 15, '4': 1, '5': 1, '10': 'totalBalance'},
    {
      '1': 'fund_distribution_mode',
      '3': 16,
      '4': 1,
      '5': 14,
      '6': '.accounts.v1.FundDistributionMode',
      '10': 'fundDistributionMode'
    },
    {'1': 'setup_completed', '3': 17, '4': 1, '5': 8, '10': 'setupCompleted'},
    {
      '1': 'spending_visibility_enabled',
      '3': 18,
      '4': 1,
      '5': 8,
      '10': 'spendingVisibilityEnabled'
    },
    {'1': 'currency', '3': 19, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'virtual_account_id',
      '3': 20,
      '4': 1,
      '5': 9,
      '10': 'virtualAccountId'
    },
  ],
};

/// Descriptor for `FamilyAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyAccountDescriptor = $convert.base64Decode(
    'Cg1GYW1pbHlBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIdCgpjcmVhdG9yX2lkGAIgASgJUgljcm'
    'VhdG9ySWQSIQoMY3JlYXRvcl9uYW1lGAMgASgJUgtjcmVhdG9yTmFtZRISCgRuYW1lGAQgASgJ'
    'UgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhI2Chd0b3RhbF9hbGxvY2'
    'F0ZWRfYmFsYW5jZRgGIAEoAVIVdG90YWxBbGxvY2F0ZWRCYWxhbmNlEiwKEnRvdGFsX3Bvb2xf'
    'YmFsYW5jZRgHIAEoAVIQdG90YWxQb29sQmFsYW5jZRIWCgZzdGF0dXMYCCABKAlSBnN0YXR1cx'
    'IdCgpjcmVhdGVkX2F0GAkgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgKIAEoCVIJdXBk'
    'YXRlZEF0EjMKB21lbWJlcnMYCyADKAsyGS5hY2NvdW50cy52MS5GYW1pbHlNZW1iZXJSB21lbW'
    'JlcnMSIQoMbWVtYmVyX2NvdW50GAwgASgFUgttZW1iZXJDb3VudBIuChNhY3RpdmVfbWVtYmVy'
    'X2NvdW50GA0gASgFUhFhY3RpdmVNZW1iZXJDb3VudBI8ChphbGxvd19tZW1iZXJfY29udHJpYn'
    'V0aW9ucxgOIAEoCFIYYWxsb3dNZW1iZXJDb250cmlidXRpb25zEiMKDXRvdGFsX2JhbGFuY2UY'
    'DyABKAFSDHRvdGFsQmFsYW5jZRJXChZmdW5kX2Rpc3RyaWJ1dGlvbl9tb2RlGBAgASgOMiEuYW'
    'Njb3VudHMudjEuRnVuZERpc3RyaWJ1dGlvbk1vZGVSFGZ1bmREaXN0cmlidXRpb25Nb2RlEicK'
    'D3NldHVwX2NvbXBsZXRlZBgRIAEoCFIOc2V0dXBDb21wbGV0ZWQSPgobc3BlbmRpbmdfdmlzaW'
    'JpbGl0eV9lbmFibGVkGBIgASgIUhlzcGVuZGluZ1Zpc2liaWxpdHlFbmFibGVkEhoKCGN1cnJl'
    'bmN5GBMgASgJUghjdXJyZW5jeRIsChJ2aXJ0dWFsX2FjY291bnRfaWQYFCABKAlSEHZpcnR1YW'
    'xBY2NvdW50SWQ=');

@$core.Deprecated('Use familyMemberDescriptor instead')
const FamilyMember$json = {
  '1': 'FamilyMember',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'full_name', '3': 4, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'username', '3': 7, '4': 1, '5': 9, '10': 'username'},
    {'1': 'avatar_url', '3': 8, '4': 1, '5': 9, '10': 'avatarUrl'},
    {'1': 'role', '3': 9, '4': 1, '5': 9, '10': 'role'},
    {
      '1': 'allocated_balance',
      '3': 10,
      '4': 1,
      '5': 1,
      '10': 'allocatedBalance'
    },
    {
      '1': 'daily_spending_limit',
      '3': 11,
      '4': 1,
      '5': 1,
      '10': 'dailySpendingLimit'
    },
    {
      '1': 'monthly_spending_limit',
      '3': 12,
      '4': 1,
      '5': 1,
      '10': 'monthlySpendingLimit'
    },
    {'1': 'spent_this_month', '3': 13, '4': 1, '5': 1, '10': 'spentThisMonth'},
    {'1': 'spent_today', '3': 14, '4': 1, '5': 1, '10': 'spentToday'},
    {
      '1': 'invitation_status',
      '3': 15,
      '4': 1,
      '5': 9,
      '10': 'invitationStatus'
    },
    {'1': 'invitation_token', '3': 16, '4': 1, '5': 9, '10': 'invitationToken'},
    {
      '1': 'invitation_expires_at',
      '3': 17,
      '4': 1,
      '5': 9,
      '10': 'invitationExpiresAt'
    },
    {'1': 'card_last_four', '3': 18, '4': 1, '5': 9, '10': 'cardLastFour'},
    {'1': 'has_card', '3': 19, '4': 1, '5': 8, '10': 'hasCard'},
    {'1': 'joined_at', '3': 20, '4': 1, '5': 9, '10': 'joinedAt'},
    {'1': 'created_at', '3': 21, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 22, '4': 1, '5': 9, '10': 'updatedAt'},
    {
      '1': 'per_transaction_limit',
      '3': 23,
      '4': 1,
      '5': 1,
      '10': 'perTransactionLimit'
    },
    {
      '1': 'allocation_percentage_cap',
      '3': 24,
      '4': 1,
      '5': 1,
      '10': 'allocationPercentageCap'
    },
    {
      '1': 'remaining_balance',
      '3': 25,
      '4': 1,
      '5': 1,
      '10': 'remainingBalance'
    },
  ],
};

/// Descriptor for `FamilyMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyMemberDescriptor = $convert.base64Decode(
    'CgxGYW1pbHlNZW1iZXISDgoCaWQYASABKAlSAmlkEhsKCWZhbWlseV9pZBgCIAEoCVIIZmFtaW'
    'x5SWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhsKCWZ1bGxfbmFtZRgEIAEoCVIIZnVsbE5h'
    'bWUSFAoFZW1haWwYBSABKAlSBWVtYWlsEhQKBXBob25lGAYgASgJUgVwaG9uZRIaCgh1c2Vybm'
    'FtZRgHIAEoCVIIdXNlcm5hbWUSHQoKYXZhdGFyX3VybBgIIAEoCVIJYXZhdGFyVXJsEhIKBHJv'
    'bGUYCSABKAlSBHJvbGUSKwoRYWxsb2NhdGVkX2JhbGFuY2UYCiABKAFSEGFsbG9jYXRlZEJhbG'
    'FuY2USMAoUZGFpbHlfc3BlbmRpbmdfbGltaXQYCyABKAFSEmRhaWx5U3BlbmRpbmdMaW1pdBI0'
    'ChZtb250aGx5X3NwZW5kaW5nX2xpbWl0GAwgASgBUhRtb250aGx5U3BlbmRpbmdMaW1pdBIoCh'
    'BzcGVudF90aGlzX21vbnRoGA0gASgBUg5zcGVudFRoaXNNb250aBIfCgtzcGVudF90b2RheRgO'
    'IAEoAVIKc3BlbnRUb2RheRIrChFpbnZpdGF0aW9uX3N0YXR1cxgPIAEoCVIQaW52aXRhdGlvbl'
    'N0YXR1cxIpChBpbnZpdGF0aW9uX3Rva2VuGBAgASgJUg9pbnZpdGF0aW9uVG9rZW4SMgoVaW52'
    'aXRhdGlvbl9leHBpcmVzX2F0GBEgASgJUhNpbnZpdGF0aW9uRXhwaXJlc0F0EiQKDmNhcmRfbG'
    'FzdF9mb3VyGBIgASgJUgxjYXJkTGFzdEZvdXISGQoIaGFzX2NhcmQYEyABKAhSB2hhc0NhcmQS'
    'GwoJam9pbmVkX2F0GBQgASgJUghqb2luZWRBdBIdCgpjcmVhdGVkX2F0GBUgASgJUgljcmVhdG'
    'VkQXQSHQoKdXBkYXRlZF9hdBgWIAEoCVIJdXBkYXRlZEF0EjIKFXBlcl90cmFuc2FjdGlvbl9s'
    'aW1pdBgXIAEoAVITcGVyVHJhbnNhY3Rpb25MaW1pdBI6ChlhbGxvY2F0aW9uX3BlcmNlbnRhZ2'
    'VfY2FwGBggASgBUhdhbGxvY2F0aW9uUGVyY2VudGFnZUNhcBIrChFyZW1haW5pbmdfYmFsYW5j'
    'ZRgZIAEoAVIQcmVtYWluaW5nQmFsYW5jZQ==');

@$core.Deprecated('Use familyTransactionDescriptor instead')
const FamilyTransaction$json = {
  '1': 'FamilyTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'member_id', '3': 3, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'member_name', '3': 4, '4': 1, '5': 9, '10': 'memberName'},
    {'1': 'member_avatar', '3': 5, '4': 1, '5': 9, '10': 'memberAvatar'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'type', '3': 8, '4': 1, '5': 9, '10': 'type'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    {'1': 'merchant_name', '3': 10, '4': 1, '5': 9, '10': 'merchantName'},
    {
      '1': 'merchant_category',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'merchantCategory'
    },
    {
      '1': 'metadata',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.FamilyTransaction.MetadataEntry',
      '10': 'metadata'
    },
    {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
  ],
  '3': [FamilyTransaction_MetadataEntry$json],
};

@$core.Deprecated('Use familyTransactionDescriptor instead')
const FamilyTransaction_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `FamilyTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyTransactionDescriptor = $convert.base64Decode(
    'ChFGYW1pbHlUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSGwoJZmFtaWx5X2lkGAIgASgJUg'
    'hmYW1pbHlJZBIbCgltZW1iZXJfaWQYAyABKAlSCG1lbWJlcklkEh8KC21lbWJlcl9uYW1lGAQg'
    'ASgJUgptZW1iZXJOYW1lEiMKDW1lbWJlcl9hdmF0YXIYBSABKAlSDG1lbWJlckF2YXRhchIlCg'
    '50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBIWCgZhbW91bnQYByABKAFSBmFt'
    'b3VudBISCgR0eXBlGAggASgJUgR0eXBlEiAKC2Rlc2NyaXB0aW9uGAkgASgJUgtkZXNjcmlwdG'
    'lvbhIjCg1tZXJjaGFudF9uYW1lGAogASgJUgxtZXJjaGFudE5hbWUSKwoRbWVyY2hhbnRfY2F0'
    'ZWdvcnkYCyABKAlSEG1lcmNoYW50Q2F0ZWdvcnkSSAoIbWV0YWRhdGEYDCADKAsyLC5hY2NvdW'
    '50cy52MS5GYW1pbHlUcmFuc2FjdGlvbi5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRIdCgpjcmVh'
    'dGVkX2F0GA0gASgJUgljcmVhdGVkQXQaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2'
    'tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use pendingInvitationDescriptor instead')
const PendingInvitation$json = {
  '1': 'PendingInvitation',
  '2': [
    {'1': 'invitation_token', '3': 1, '4': 1, '5': 9, '10': 'invitationToken'},
    {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'family_name', '3': 3, '4': 1, '5': 9, '10': 'familyName'},
    {'1': 'creator_name', '3': 4, '4': 1, '5': 9, '10': 'creatorName'},
    {'1': 'creator_avatar', '3': 5, '4': 1, '5': 9, '10': 'creatorAvatar'},
    {
      '1': 'initial_allocation',
      '3': 6,
      '4': 1,
      '5': 1,
      '10': 'initialAllocation'
    },
    {'1': 'daily_limit', '3': 7, '4': 1, '5': 1, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 8, '4': 1, '5': 1, '10': 'monthlyLimit'},
    {'1': 'invited_by', '3': 9, '4': 1, '5': 9, '10': 'invitedBy'},
    {'1': 'expires_at', '3': 10, '4': 1, '5': 9, '10': 'expiresAt'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `PendingInvitation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingInvitationDescriptor = $convert.base64Decode(
    'ChFQZW5kaW5nSW52aXRhdGlvbhIpChBpbnZpdGF0aW9uX3Rva2VuGAEgASgJUg9pbnZpdGF0aW'
    '9uVG9rZW4SGwoJZmFtaWx5X2lkGAIgASgJUghmYW1pbHlJZBIfCgtmYW1pbHlfbmFtZRgDIAEo'
    'CVIKZmFtaWx5TmFtZRIhCgxjcmVhdG9yX25hbWUYBCABKAlSC2NyZWF0b3JOYW1lEiUKDmNyZW'
    'F0b3JfYXZhdGFyGAUgASgJUg1jcmVhdG9yQXZhdGFyEi0KEmluaXRpYWxfYWxsb2NhdGlvbhgG'
    'IAEoAVIRaW5pdGlhbEFsbG9jYXRpb24SHwoLZGFpbHlfbGltaXQYByABKAFSCmRhaWx5TGltaX'
    'QSIwoNbW9udGhseV9saW1pdBgIIAEoAVIMbW9udGhseUxpbWl0Eh0KCmludml0ZWRfYnkYCSAB'
    'KAlSCWludml0ZWRCeRIdCgpleHBpcmVzX2F0GAogASgJUglleHBpcmVzQXQSHQoKY3JlYXRlZF'
    '9hdBgLIAEoCVIJY3JlYXRlZEF0');

@$core.Deprecated('Use familyAccountSummaryDescriptor instead')
const FamilyAccountSummary$json = {
  '1': 'FamilyAccountSummary',
  '2': [
    {'1': 'total_allocated', '3': 1, '4': 1, '5': 1, '10': 'totalAllocated'},
    {
      '1': 'total_spent_this_month',
      '3': 2,
      '4': 1,
      '5': 1,
      '10': 'totalSpentThisMonth'
    },
    {'1': 'total_spent_today', '3': 3, '4': 1, '5': 1, '10': 'totalSpentToday'},
    {
      '1': 'transaction_count_this_month',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'transactionCountThisMonth'
    },
    {
      '1': 'top_spenders',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.accounts.v1.FamilyMemberSpending',
      '10': 'topSpenders'
    },
  ],
};

/// Descriptor for `FamilyAccountSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyAccountSummaryDescriptor = $convert.base64Decode(
    'ChRGYW1pbHlBY2NvdW50U3VtbWFyeRInCg90b3RhbF9hbGxvY2F0ZWQYASABKAFSDnRvdGFsQW'
    'xsb2NhdGVkEjMKFnRvdGFsX3NwZW50X3RoaXNfbW9udGgYAiABKAFSE3RvdGFsU3BlbnRUaGlz'
    'TW9udGgSKgoRdG90YWxfc3BlbnRfdG9kYXkYAyABKAFSD3RvdGFsU3BlbnRUb2RheRI/Chx0cm'
    'Fuc2FjdGlvbl9jb3VudF90aGlzX21vbnRoGAQgASgFUhl0cmFuc2FjdGlvbkNvdW50VGhpc01v'
    'bnRoEkQKDHRvcF9zcGVuZGVycxgFIAMoCzIhLmFjY291bnRzLnYxLkZhbWlseU1lbWJlclNwZW'
    '5kaW5nUgt0b3BTcGVuZGVycw==');

@$core.Deprecated('Use familyMemberSpendingDescriptor instead')
const FamilyMemberSpending$json = {
  '1': 'FamilyMemberSpending',
  '2': [
    {'1': 'member_id', '3': 1, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'member_name', '3': 2, '4': 1, '5': 9, '10': 'memberName'},
    {'1': 'member_avatar', '3': 3, '4': 1, '5': 9, '10': 'memberAvatar'},
    {'1': 'amount_spent', '3': 4, '4': 1, '5': 1, '10': 'amountSpent'},
    {
      '1': 'transaction_count',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'transactionCount'
    },
  ],
};

/// Descriptor for `FamilyMemberSpending`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyMemberSpendingDescriptor = $convert.base64Decode(
    'ChRGYW1pbHlNZW1iZXJTcGVuZGluZxIbCgltZW1iZXJfaWQYASABKAlSCG1lbWJlcklkEh8KC2'
    '1lbWJlcl9uYW1lGAIgASgJUgptZW1iZXJOYW1lEiMKDW1lbWJlcl9hdmF0YXIYAyABKAlSDG1l'
    'bWJlckF2YXRhchIhCgxhbW91bnRfc3BlbnQYBCABKAFSC2Ftb3VudFNwZW50EisKEXRyYW5zYW'
    'N0aW9uX2NvdW50GAUgASgFUhB0cmFuc2FjdGlvbkNvdW50');
