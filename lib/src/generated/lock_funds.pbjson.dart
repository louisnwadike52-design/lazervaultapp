///
//  Generated code. Do not modify.
//  source: lock_funds.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use lockTypeDescriptor instead')
const LockType$json = const {
  '1': 'LockType',
  '2': const [
    const {'1': 'LOCK_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'LOCK_TYPE_SAVINGS', '2': 1},
    const {'1': 'LOCK_TYPE_INVESTMENT', '2': 2},
    const {'1': 'LOCK_TYPE_EMERGENCY_FUND', '2': 3},
    const {'1': 'LOCK_TYPE_GOAL_BASED', '2': 4},
  ],
};

/// Descriptor for `LockType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lockTypeDescriptor = $convert.base64Decode('CghMb2NrVHlwZRIZChVMT0NLX1RZUEVfVU5TUEVDSUZJRUQQABIVChFMT0NLX1RZUEVfU0FWSU5HUxABEhgKFExPQ0tfVFlQRV9JTlZFU1RNRU5UEAISHAoYTE9DS19UWVBFX0VNRVJHRU5DWV9GVU5EEAMSGAoUTE9DS19UWVBFX0dPQUxfQkFTRUQQBA==');
@$core.Deprecated('Use lockStatusDescriptor instead')
const LockStatus$json = const {
  '1': 'LockStatus',
  '2': const [
    const {'1': 'LOCK_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'LOCK_STATUS_ACTIVE', '2': 1},
    const {'1': 'LOCK_STATUS_MATURED', '2': 2},
    const {'1': 'LOCK_STATUS_UNLOCKED', '2': 3},
    const {'1': 'LOCK_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `LockStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lockStatusDescriptor = $convert.base64Decode('CgpMb2NrU3RhdHVzEhsKF0xPQ0tfU1RBVFVTX1VOU1BFQ0lGSUVEEAASFgoSTE9DS19TVEFUVVNfQUNUSVZFEAESFwoTTE9DS19TVEFUVVNfTUFUVVJFRBACEhgKFExPQ0tfU1RBVFVTX1VOTE9DS0VEEAMSGQoVTE9DS19TVEFUVVNfQ0FOQ0VMTEVEEAQ=');
@$core.Deprecated('Use lockFundDescriptor instead')
const LockFund$json = const {
  '1': 'LockFund',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'lock_type', '3': 3, '4': 1, '5': 14, '6': '.pb.LockType', '10': 'lockType'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'lock_duration_days', '3': 6, '4': 1, '5': 5, '10': 'lockDurationDays'},
    const {'1': 'interest_rate', '3': 7, '4': 1, '5': 1, '10': 'interestRate'},
    const {'1': 'locked_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lockedAt'},
    const {'1': 'unlock_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'unlockAt'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.LockStatus', '10': 'status'},
    const {'1': 'auto_renew', '3': 11, '4': 1, '5': 8, '10': 'autoRenew'},
    const {'1': 'goal_name', '3': 12, '4': 1, '5': 9, '10': 'goalName'},
    const {'1': 'goal_description', '3': 13, '4': 1, '5': 9, '10': 'goalDescription'},
    const {'1': 'early_unlock_penalty_percent', '3': 14, '4': 1, '5': 1, '10': 'earlyUnlockPenaltyPercent'},
    const {'1': 'accrued_interest', '3': 15, '4': 1, '5': 1, '10': 'accruedInterest'},
    const {'1': 'payment_method', '3': 16, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'transaction_id', '3': 17, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'days_remaining', '3': 20, '4': 1, '5': 5, '10': 'daysRemaining'},
    const {'1': 'progress_percent', '3': 21, '4': 1, '5': 1, '10': 'progressPercent'},
    const {'1': 'total_value', '3': 22, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'can_unlock_early', '3': 23, '4': 1, '5': 8, '10': 'canUnlockEarly'},
    const {'1': 'source_account_id', '3': 24, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account_id', '3': 25, '4': 1, '5': 9, '10': 'destinationAccountId'},
  ],
};

/// Descriptor for `LockFund`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockFundDescriptor = $convert.base64Decode('CghMb2NrRnVuZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoBFIGdXNlcklkEikKCWxvY2tfdHlwZRgDIAEoDjIMLnBiLkxvY2tUeXBlUghsb2NrVHlwZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSLAoSbG9ja19kdXJhdGlvbl9kYXlzGAYgASgFUhBsb2NrRHVyYXRpb25EYXlzEiMKDWludGVyZXN0X3JhdGUYByABKAFSDGludGVyZXN0UmF0ZRI3Cglsb2NrZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghsb2NrZWRBdBI3Cgl1bmxvY2tfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgh1bmxvY2tBdBImCgZzdGF0dXMYCiABKA4yDi5wYi5Mb2NrU3RhdHVzUgZzdGF0dXMSHQoKYXV0b19yZW5ldxgLIAEoCFIJYXV0b1JlbmV3EhsKCWdvYWxfbmFtZRgMIAEoCVIIZ29hbE5hbWUSKQoQZ29hbF9kZXNjcmlwdGlvbhgNIAEoCVIPZ29hbERlc2NyaXB0aW9uEj8KHGVhcmx5X3VubG9ja19wZW5hbHR5X3BlcmNlbnQYDiABKAFSGWVhcmx5VW5sb2NrUGVuYWx0eVBlcmNlbnQSKQoQYWNjcnVlZF9pbnRlcmVzdBgPIAEoAVIPYWNjcnVlZEludGVyZXN0EiUKDnBheW1lbnRfbWV0aG9kGBAgASgJUg1wYXltZW50TWV0aG9kEiUKDnRyYW5zYWN0aW9uX2lkGBEgASgJUg10cmFuc2FjdGlvbklkEjkKCmNyZWF0ZWRfYXQYEiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgTIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBIlCg5kYXlzX3JlbWFpbmluZxgUIAEoBVINZGF5c1JlbWFpbmluZxIpChBwcm9ncmVzc19wZXJjZW50GBUgASgBUg9wcm9ncmVzc1BlcmNlbnQSHwoLdG90YWxfdmFsdWUYFiABKAFSCnRvdGFsVmFsdWUSKAoQY2FuX3VubG9ja19lYXJseRgXIAEoCFIOY2FuVW5sb2NrRWFybHkSKgoRc291cmNlX2FjY291bnRfaWQYGCABKAlSD3NvdXJjZUFjY291bnRJZBI0ChZkZXN0aW5hdGlvbl9hY2NvdW50X2lkGBkgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZA==');
@$core.Deprecated('Use lockTransactionDescriptor instead')
const LockTransaction$json = const {
  '1': 'LockTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'lock_fund_id', '3': 2, '4': 1, '5': 9, '10': 'lockFundId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'transaction_type', '3': 4, '4': 1, '5': 9, '10': 'transactionType'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_method', '3': 7, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'transaction_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `LockTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockTransactionDescriptor = $convert.base64Decode('Cg9Mb2NrVHJhbnNhY3Rpb24SDgoCaWQYASABKAlSAmlkEiAKDGxvY2tfZnVuZF9pZBgCIAEoCVIKbG9ja0Z1bmRJZBIXCgd1c2VyX2lkGAMgASgEUgZ1c2VySWQSKQoQdHJhbnNhY3Rpb25fdHlwZRgEIAEoCVIPdHJhbnNhY3Rpb25UeXBlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIlCg5wYXltZW50X21ldGhvZBgHIAEoCVINcGF5bWVudE1ldGhvZBIWCgZzdGF0dXMYCCABKAlSBnN0YXR1cxJFChB0cmFuc2FjdGlvbl9kYXRlGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25EYXRlEiAKC2Rlc2NyaXB0aW9uGAogASgJUgtkZXNjcmlwdGlvbg==');
@$core.Deprecated('Use createLockFundRequestDescriptor instead')
const CreateLockFundRequest$json = const {
  '1': 'CreateLockFundRequest',
  '2': const [
    const {'1': 'lock_type', '3': 1, '4': 1, '5': 14, '6': '.pb.LockType', '10': 'lockType'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'lock_duration_days', '3': 4, '4': 1, '5': 5, '10': 'lockDurationDays'},
    const {'1': 'auto_renew', '3': 5, '4': 1, '5': 8, '10': 'autoRenew'},
    const {'1': 'goal_name', '3': 6, '4': 1, '5': 9, '10': 'goalName'},
    const {'1': 'goal_description', '3': 7, '4': 1, '5': 9, '10': 'goalDescription'},
    const {'1': 'payment_method', '3': 8, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'source_account_id', '3': 9, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'transaction_pin', '3': 10, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `CreateLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundRequestDescriptor = $convert.base64Decode('ChVDcmVhdGVMb2NrRnVuZFJlcXVlc3QSKQoJbG9ja190eXBlGAEgASgOMgwucGIuTG9ja1R5cGVSCGxvY2tUeXBlEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIsChJsb2NrX2R1cmF0aW9uX2RheXMYBCABKAVSEGxvY2tEdXJhdGlvbkRheXMSHQoKYXV0b19yZW5ldxgFIAEoCFIJYXV0b1JlbmV3EhsKCWdvYWxfbmFtZRgGIAEoCVIIZ29hbE5hbWUSKQoQZ29hbF9kZXNjcmlwdGlvbhgHIAEoCVIPZ29hbERlc2NyaXB0aW9uEiUKDnBheW1lbnRfbWV0aG9kGAggASgJUg1wYXltZW50TWV0aG9kEioKEXNvdXJjZV9hY2NvdW50X2lkGAkgASgJUg9zb3VyY2VBY2NvdW50SWQSJwoPdHJhbnNhY3Rpb25fcGluGAogASgJUg50cmFuc2FjdGlvblBpbg==');
@$core.Deprecated('Use createLockFundResponseDescriptor instead')
const CreateLockFundResponse$json = const {
  '1': 'CreateLockFundResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'lock_fund', '3': 3, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'lockFund'},
    const {'1': 'payment_url', '3': 4, '4': 1, '5': 9, '10': 'paymentUrl'},
  ],
};

/// Descriptor for `CreateLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundResponseDescriptor = $convert.base64Decode('ChZDcmVhdGVMb2NrRnVuZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIpCglsb2NrX2Z1bmQYAyABKAsyDC5wYi5Mb2NrRnVuZFIIbG9ja0Z1bmQSHwoLcGF5bWVudF91cmwYBCABKAlSCnBheW1lbnRVcmw=');
@$core.Deprecated('Use getLockFundsRequestDescriptor instead')
const GetLockFundsRequest$json = const {
  '1': 'GetLockFundsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.pb.LockStatus', '10': 'status'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetLockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundsRequestDescriptor = $convert.base64Decode('ChNHZXRMb2NrRnVuZHNSZXF1ZXN0EiYKBnN0YXR1cxgBIAEoDjIOLnBiLkxvY2tTdGF0dXNSBnN0YXR1cxISCgRwYWdlGAIgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAMgASgFUgdwZXJQYWdl');
@$core.Deprecated('Use getLockFundsResponseDescriptor instead')
const GetLockFundsResponse$json = const {
  '1': 'GetLockFundsResponse',
  '2': const [
    const {'1': 'lock_funds', '3': 1, '4': 3, '5': 11, '6': '.pb.LockFund', '10': 'lockFunds'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_locked_amount', '3': 5, '4': 1, '5': 1, '10': 'totalLockedAmount'},
    const {'1': 'total_accrued_interest', '3': 6, '4': 1, '5': 1, '10': 'totalAccruedInterest'},
    const {'1': 'active_locks_count', '3': 7, '4': 1, '5': 5, '10': 'activeLocksCount'},
  ],
};

/// Descriptor for `GetLockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundsResponseDescriptor = $convert.base64Decode('ChRHZXRMb2NrRnVuZHNSZXNwb25zZRIrCgpsb2NrX2Z1bmRzGAEgAygLMgwucGIuTG9ja0Z1bmRSCWxvY2tGdW5kcxIfCgt0b3RhbF9jb3VudBgCIAEoBVIKdG90YWxDb3VudBISCgRwYWdlGAMgASgFUgRwYWdlEh8KC3RvdGFsX3BhZ2VzGAQgASgFUgp0b3RhbFBhZ2VzEi4KE3RvdGFsX2xvY2tlZF9hbW91bnQYBSABKAFSEXRvdGFsTG9ja2VkQW1vdW50EjQKFnRvdGFsX2FjY3J1ZWRfaW50ZXJlc3QYBiABKAFSFHRvdGFsQWNjcnVlZEludGVyZXN0EiwKEmFjdGl2ZV9sb2Nrc19jb3VudBgHIAEoBVIQYWN0aXZlTG9ja3NDb3VudA==');
@$core.Deprecated('Use getLockFundRequestDescriptor instead')
const GetLockFundRequest$json = const {
  '1': 'GetLockFundRequest',
  '2': const [
    const {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
  ],
};

/// Descriptor for `GetLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundRequestDescriptor = $convert.base64Decode('ChJHZXRMb2NrRnVuZFJlcXVlc3QSIAoMbG9ja19mdW5kX2lkGAEgASgJUgpsb2NrRnVuZElk');
@$core.Deprecated('Use getLockFundResponseDescriptor instead')
const GetLockFundResponse$json = const {
  '1': 'GetLockFundResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'lock_fund', '3': 2, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'lockFund'},
  ],
};

/// Descriptor for `GetLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundResponseDescriptor = $convert.base64Decode('ChNHZXRMb2NrRnVuZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSKQoJbG9ja19mdW5kGAIgASgLMgwucGIuTG9ja0Z1bmRSCGxvY2tGdW5k');
@$core.Deprecated('Use unlockFundRequestDescriptor instead')
const UnlockFundRequest$json = const {
  '1': 'UnlockFundRequest',
  '2': const [
    const {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    const {'1': 'force_early_unlock', '3': 2, '4': 1, '5': 8, '10': 'forceEarlyUnlock'},
    const {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
  ],
};

/// Descriptor for `UnlockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockFundRequestDescriptor = $convert.base64Decode('ChFVbmxvY2tGdW5kUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2tGdW5kSWQSLAoSZm9yY2VfZWFybHlfdW5sb2NrGAIgASgIUhBmb3JjZUVhcmx5VW5sb2NrEicKD3RyYW5zYWN0aW9uX3BpbhgDIAEoCVIOdHJhbnNhY3Rpb25QaW4SNAoWZGVzdGluYXRpb25fYWNjb3VudF9pZBgEIAEoCVIUZGVzdGluYXRpb25BY2NvdW50SWQ=');
@$core.Deprecated('Use unlockFundResponseDescriptor instead')
const UnlockFundResponse$json = const {
  '1': 'UnlockFundResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'amount_returned', '3': 3, '4': 1, '5': 1, '10': 'amountReturned'},
    const {'1': 'penalty_amount', '3': 4, '4': 1, '5': 1, '10': 'penaltyAmount'},
    const {'1': 'interest_earned', '3': 5, '4': 1, '5': 1, '10': 'interestEarned'},
    const {'1': 'updated_lock_fund', '3': 6, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'updatedLockFund'},
    const {'1': 'credited_account_id', '3': 7, '4': 1, '5': 9, '10': 'creditedAccountId'},
  ],
};

/// Descriptor for `UnlockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockFundResponseDescriptor = $convert.base64Decode('ChJVbmxvY2tGdW5kUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEicKD2Ftb3VudF9yZXR1cm5lZBgDIAEoAVIOYW1vdW50UmV0dXJuZWQSJQoOcGVuYWx0eV9hbW91bnQYBCABKAFSDXBlbmFsdHlBbW91bnQSJwoPaW50ZXJlc3RfZWFybmVkGAUgASgBUg5pbnRlcmVzdEVhcm5lZBI4ChF1cGRhdGVkX2xvY2tfZnVuZBgGIAEoCzIMLnBiLkxvY2tGdW5kUg91cGRhdGVkTG9ja0Z1bmQSLgoTY3JlZGl0ZWRfYWNjb3VudF9pZBgHIAEoCVIRY3JlZGl0ZWRBY2NvdW50SWQ=');
@$core.Deprecated('Use getLockTransactionsRequestDescriptor instead')
const GetLockTransactionsRequest$json = const {
  '1': 'GetLockTransactionsRequest',
  '2': const [
    const {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetLockTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockTransactionsRequestDescriptor = $convert.base64Decode('ChpHZXRMb2NrVHJhbnNhY3Rpb25zUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2tGdW5kSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgDIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use getLockTransactionsResponseDescriptor instead')
const GetLockTransactionsResponse$json = const {
  '1': 'GetLockTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.LockTransaction', '10': 'transactions'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetLockTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockTransactionsResponseDescriptor = $convert.base64Decode('ChtHZXRMb2NrVHJhbnNhY3Rpb25zUmVzcG9uc2USNwoMdHJhbnNhY3Rpb25zGAEgAygLMhMucGIuTG9ja1RyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSHwoLdG90YWxfY291bnQYAiABKAVSCnRvdGFsQ291bnQSEgoEcGFnZRgDIAEoBVIEcGFnZRIfCgt0b3RhbF9wYWdlcxgEIAEoBVIKdG90YWxQYWdlcw==');
@$core.Deprecated('Use calculateInterestRequestDescriptor instead')
const CalculateInterestRequest$json = const {
  '1': 'CalculateInterestRequest',
  '2': const [
    const {'1': 'lock_type', '3': 1, '4': 1, '5': 14, '6': '.pb.LockType', '10': 'lockType'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'lock_duration_days', '3': 3, '4': 1, '5': 5, '10': 'lockDurationDays'},
  ],
};

/// Descriptor for `CalculateInterestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateInterestRequestDescriptor = $convert.base64Decode('ChhDYWxjdWxhdGVJbnRlcmVzdFJlcXVlc3QSKQoJbG9ja190eXBlGAEgASgOMgwucGIuTG9ja1R5cGVSCGxvY2tUeXBlEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EiwKEmxvY2tfZHVyYXRpb25fZGF5cxgDIAEoBVIQbG9ja0R1cmF0aW9uRGF5cw==');
@$core.Deprecated('Use calculateInterestResponseDescriptor instead')
const CalculateInterestResponse$json = const {
  '1': 'CalculateInterestResponse',
  '2': const [
    const {'1': 'interest_rate', '3': 1, '4': 1, '5': 1, '10': 'interestRate'},
    const {'1': 'estimated_interest', '3': 2, '4': 1, '5': 1, '10': 'estimatedInterest'},
    const {'1': 'total_return', '3': 3, '4': 1, '5': 1, '10': 'totalReturn'},
    const {'1': 'apy', '3': 4, '4': 1, '5': 1, '10': 'apy'},
  ],
};

/// Descriptor for `CalculateInterestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateInterestResponseDescriptor = $convert.base64Decode('ChlDYWxjdWxhdGVJbnRlcmVzdFJlc3BvbnNlEiMKDWludGVyZXN0X3JhdGUYASABKAFSDGludGVyZXN0UmF0ZRItChJlc3RpbWF0ZWRfaW50ZXJlc3QYAiABKAFSEWVzdGltYXRlZEludGVyZXN0EiEKDHRvdGFsX3JldHVybhgDIAEoAVILdG90YWxSZXR1cm4SEAoDYXB5GAQgASgBUgNhcHk=');
@$core.Deprecated('Use renewLockFundRequestDescriptor instead')
const RenewLockFundRequest$json = const {
  '1': 'RenewLockFundRequest',
  '2': const [
    const {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    const {'1': 'new_duration_days', '3': 2, '4': 1, '5': 5, '10': 'newDurationDays'},
  ],
};

/// Descriptor for `RenewLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renewLockFundRequestDescriptor = $convert.base64Decode('ChRSZW5ld0xvY2tGdW5kUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2tGdW5kSWQSKgoRbmV3X2R1cmF0aW9uX2RheXMYAiABKAVSD25ld0R1cmF0aW9uRGF5cw==');
@$core.Deprecated('Use renewLockFundResponseDescriptor instead')
const RenewLockFundResponse$json = const {
  '1': 'RenewLockFundResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'renewed_lock_fund', '3': 3, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'renewedLockFund'},
  ],
};

/// Descriptor for `RenewLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renewLockFundResponseDescriptor = $convert.base64Decode('ChVSZW5ld0xvY2tGdW5kUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjgKEXJlbmV3ZWRfbG9ja19mdW5kGAMgASgLMgwucGIuTG9ja0Z1bmRSD3JlbmV3ZWRMb2NrRnVuZA==');
@$core.Deprecated('Use cancelLockFundRequestDescriptor instead')
const CancelLockFundRequest$json = const {
  '1': 'CancelLockFundRequest',
  '2': const [
    const {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelLockFundRequestDescriptor = $convert.base64Decode('ChVDYW5jZWxMb2NrRnVuZFJlcXVlc3QSIAoMbG9ja19mdW5kX2lkGAEgASgJUgpsb2NrRnVuZElkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');
@$core.Deprecated('Use cancelLockFundResponseDescriptor instead')
const CancelLockFundResponse$json = const {
  '1': 'CancelLockFundResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'refund_amount', '3': 3, '4': 1, '5': 1, '10': 'refundAmount'},
  ],
};

/// Descriptor for `CancelLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelLockFundResponseDescriptor = $convert.base64Decode('ChZDYW5jZWxMb2NrRnVuZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIjCg1yZWZ1bmRfYW1vdW50GAMgASgBUgxyZWZ1bmRBbW91bnQ=');
