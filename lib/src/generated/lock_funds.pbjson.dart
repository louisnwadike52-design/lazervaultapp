//
//  Generated code. Do not modify.
//  source: lock_funds.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use lockTypeDescriptor instead')
const LockType$json = {
  '1': 'LockType',
  '2': [
    {'1': 'LOCK_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'LOCK_TYPE_SAVINGS', '2': 1},
    {'1': 'LOCK_TYPE_INVESTMENT', '2': 2},
    {'1': 'LOCK_TYPE_EMERGENCY_FUND', '2': 3},
    {'1': 'LOCK_TYPE_GOAL_BASED', '2': 4},
  ],
};

/// Descriptor for `LockType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lockTypeDescriptor = $convert.base64Decode(
    'CghMb2NrVHlwZRIZChVMT0NLX1RZUEVfVU5TUEVDSUZJRUQQABIVChFMT0NLX1RZUEVfU0FWSU'
    '5HUxABEhgKFExPQ0tfVFlQRV9JTlZFU1RNRU5UEAISHAoYTE9DS19UWVBFX0VNRVJHRU5DWV9G'
    'VU5EEAMSGAoUTE9DS19UWVBFX0dPQUxfQkFTRUQQBA==');

@$core.Deprecated('Use lockStatusDescriptor instead')
const LockStatus$json = {
  '1': 'LockStatus',
  '2': [
    {'1': 'LOCK_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'LOCK_STATUS_ACTIVE', '2': 1},
    {'1': 'LOCK_STATUS_MATURED', '2': 2},
    {'1': 'LOCK_STATUS_UNLOCKED', '2': 3},
    {'1': 'LOCK_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `LockStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lockStatusDescriptor = $convert.base64Decode(
    'CgpMb2NrU3RhdHVzEhsKF0xPQ0tfU1RBVFVTX1VOU1BFQ0lGSUVEEAASFgoSTE9DS19TVEFUVV'
    'NfQUNUSVZFEAESFwoTTE9DS19TVEFUVVNfTUFUVVJFRBACEhgKFExPQ0tfU1RBVFVTX1VOTE9D'
    'S0VEEAMSGQoVTE9DS19TVEFUVVNfQ0FOQ0VMTEVEEAQ=');

@$core.Deprecated('Use lockFundDescriptor instead')
const LockFund$json = {
  '1': 'LockFund',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'lock_type', '3': 3, '4': 1, '5': 14, '6': '.pb.LockType', '10': 'lockType'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'lock_duration_days', '3': 6, '4': 1, '5': 5, '10': 'lockDurationDays'},
    {'1': 'interest_rate', '3': 7, '4': 1, '5': 1, '10': 'interestRate'},
    {'1': 'locked_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lockedAt'},
    {'1': 'unlock_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'unlockAt'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.LockStatus', '10': 'status'},
    {'1': 'auto_renew', '3': 11, '4': 1, '5': 8, '10': 'autoRenew'},
    {'1': 'goal_name', '3': 12, '4': 1, '5': 9, '10': 'goalName'},
    {'1': 'goal_description', '3': 13, '4': 1, '5': 9, '10': 'goalDescription'},
    {'1': 'early_unlock_penalty_percent', '3': 14, '4': 1, '5': 1, '10': 'earlyUnlockPenaltyPercent'},
    {'1': 'accrued_interest', '3': 15, '4': 1, '5': 1, '10': 'accruedInterest'},
    {'1': 'payment_method', '3': 16, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'transaction_id', '3': 17, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'days_remaining', '3': 20, '4': 1, '5': 5, '10': 'daysRemaining'},
    {'1': 'progress_percent', '3': 21, '4': 1, '5': 1, '10': 'progressPercent'},
    {'1': 'total_value', '3': 22, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'can_unlock_early', '3': 23, '4': 1, '5': 8, '10': 'canUnlockEarly'},
    {'1': 'source_account_id', '3': 24, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'destination_account_id', '3': 25, '4': 1, '5': 9, '10': 'destinationAccountId'},
  ],
};

/// Descriptor for `LockFund`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockFundDescriptor = $convert.base64Decode(
    'CghMb2NrRnVuZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoBFIGdXNlcklkEikKCW'
    'xvY2tfdHlwZRgDIAEoDjIMLnBiLkxvY2tUeXBlUghsb2NrVHlwZRIWCgZhbW91bnQYBCABKAFS'
    'BmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSLAoSbG9ja19kdXJhdGlvbl9kYX'
    'lzGAYgASgFUhBsb2NrRHVyYXRpb25EYXlzEiMKDWludGVyZXN0X3JhdGUYByABKAFSDGludGVy'
    'ZXN0UmF0ZRI3Cglsb2NrZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg'
    'hsb2NrZWRBdBI3Cgl1bmxvY2tfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1w'
    'Ugh1bmxvY2tBdBImCgZzdGF0dXMYCiABKA4yDi5wYi5Mb2NrU3RhdHVzUgZzdGF0dXMSHQoKYX'
    'V0b19yZW5ldxgLIAEoCFIJYXV0b1JlbmV3EhsKCWdvYWxfbmFtZRgMIAEoCVIIZ29hbE5hbWUS'
    'KQoQZ29hbF9kZXNjcmlwdGlvbhgNIAEoCVIPZ29hbERlc2NyaXB0aW9uEj8KHGVhcmx5X3VubG'
    '9ja19wZW5hbHR5X3BlcmNlbnQYDiABKAFSGWVhcmx5VW5sb2NrUGVuYWx0eVBlcmNlbnQSKQoQ'
    'YWNjcnVlZF9pbnRlcmVzdBgPIAEoAVIPYWNjcnVlZEludGVyZXN0EiUKDnBheW1lbnRfbWV0aG'
    '9kGBAgASgJUg1wYXltZW50TWV0aG9kEiUKDnRyYW5zYWN0aW9uX2lkGBEgASgJUg10cmFuc2Fj'
    'dGlvbklkEjkKCmNyZWF0ZWRfYXQYEiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg'
    'ljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgTIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBSCXVwZGF0ZWRBdBIlCg5kYXlzX3JlbWFpbmluZxgUIAEoBVINZGF5c1JlbWFpbmluZxIpCh'
    'Bwcm9ncmVzc19wZXJjZW50GBUgASgBUg9wcm9ncmVzc1BlcmNlbnQSHwoLdG90YWxfdmFsdWUY'
    'FiABKAFSCnRvdGFsVmFsdWUSKAoQY2FuX3VubG9ja19lYXJseRgXIAEoCFIOY2FuVW5sb2NrRW'
    'FybHkSKgoRc291cmNlX2FjY291bnRfaWQYGCABKAlSD3NvdXJjZUFjY291bnRJZBI0ChZkZXN0'
    'aW5hdGlvbl9hY2NvdW50X2lkGBkgASgJUhRkZXN0aW5hdGlvbkFjY291bnRJZA==');

@$core.Deprecated('Use lockTransactionDescriptor instead')
const LockTransaction$json = {
  '1': 'LockTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'lock_fund_id', '3': 2, '4': 1, '5': 9, '10': 'lockFundId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'transaction_type', '3': 4, '4': 1, '5': 9, '10': 'transactionType'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payment_method', '3': 7, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'transaction_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `LockTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockTransactionDescriptor = $convert.base64Decode(
    'Cg9Mb2NrVHJhbnNhY3Rpb24SDgoCaWQYASABKAlSAmlkEiAKDGxvY2tfZnVuZF9pZBgCIAEoCV'
    'IKbG9ja0Z1bmRJZBIXCgd1c2VyX2lkGAMgASgEUgZ1c2VySWQSKQoQdHJhbnNhY3Rpb25fdHlw'
    'ZRgEIAEoCVIPdHJhbnNhY3Rpb25UeXBlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cn'
    'JlbmN5GAYgASgJUghjdXJyZW5jeRIlCg5wYXltZW50X21ldGhvZBgHIAEoCVINcGF5bWVudE1l'
    'dGhvZBIWCgZzdGF0dXMYCCABKAlSBnN0YXR1cxJFChB0cmFuc2FjdGlvbl9kYXRlGAkgASgLMh'
    'ouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25EYXRlEiAKC2Rlc2NyaXB0'
    'aW9uGAogASgJUgtkZXNjcmlwdGlvbg==');

@$core.Deprecated('Use piggyVaultConfigDescriptor instead')
const PiggyVaultConfig$json = {
  '1': 'PiggyVaultConfig',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'lock_type', '3': 2, '4': 1, '5': 9, '10': 'lockType'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'base_interest_rate', '3': 5, '4': 1, '5': 1, '10': 'baseInterestRate'},
    {'1': 'max_interest_rate', '3': 6, '4': 1, '5': 1, '10': 'maxInterestRate'},
    {'1': 'early_withdrawal_penalty', '3': 7, '4': 1, '5': 1, '10': 'earlyWithdrawalPenalty'},
    {'1': 'min_duration_days', '3': 8, '4': 1, '5': 5, '10': 'minDurationDays'},
    {'1': 'max_duration_days', '3': 9, '4': 1, '5': 5, '10': 'maxDurationDays'},
    {'1': 'min_amount', '3': 10, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 11, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'allows_early_withdrawal', '3': 12, '4': 1, '5': 8, '10': 'allowsEarlyWithdrawal'},
    {'1': 'supports_auto_renew', '3': 13, '4': 1, '5': 8, '10': 'supportsAutoRenew'},
    {'1': 'supports_top_up', '3': 14, '4': 1, '5': 8, '10': 'supportsTopUp'},
    {'1': 'supports_auto_save', '3': 15, '4': 1, '5': 8, '10': 'supportsAutoSave'},
    {'1': 'supports_upfront_interest', '3': 16, '4': 1, '5': 8, '10': 'supportsUpfrontInterest'},
    {'1': 'duration_bonus_tiers', '3': 17, '4': 1, '5': 9, '10': 'durationBonusTiers'},
    {'1': 'is_active', '3': 18, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'description', '3': 19, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `PiggyVaultConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List piggyVaultConfigDescriptor = $convert.base64Decode(
    'ChBQaWdneVZhdWx0Q29uZmlnEg4KAmlkGAEgASgJUgJpZBIbCglsb2NrX3R5cGUYAiABKAlSCG'
    'xvY2tUeXBlEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIhCgxkaXNwbGF5X25hbWUYBCAB'
    'KAlSC2Rpc3BsYXlOYW1lEiwKEmJhc2VfaW50ZXJlc3RfcmF0ZRgFIAEoAVIQYmFzZUludGVyZX'
    'N0UmF0ZRIqChFtYXhfaW50ZXJlc3RfcmF0ZRgGIAEoAVIPbWF4SW50ZXJlc3RSYXRlEjgKGGVh'
    'cmx5X3dpdGhkcmF3YWxfcGVuYWx0eRgHIAEoAVIWZWFybHlXaXRoZHJhd2FsUGVuYWx0eRIqCh'
    'FtaW5fZHVyYXRpb25fZGF5cxgIIAEoBVIPbWluRHVyYXRpb25EYXlzEioKEW1heF9kdXJhdGlv'
    'bl9kYXlzGAkgASgFUg9tYXhEdXJhdGlvbkRheXMSHQoKbWluX2Ftb3VudBgKIAEoAVIJbWluQW'
    '1vdW50Eh0KCm1heF9hbW91bnQYCyABKAFSCW1heEFtb3VudBI2ChdhbGxvd3NfZWFybHlfd2l0'
    'aGRyYXdhbBgMIAEoCFIVYWxsb3dzRWFybHlXaXRoZHJhd2FsEi4KE3N1cHBvcnRzX2F1dG9fcm'
    'VuZXcYDSABKAhSEXN1cHBvcnRzQXV0b1JlbmV3EiYKD3N1cHBvcnRzX3RvcF91cBgOIAEoCFIN'
    'c3VwcG9ydHNUb3BVcBIsChJzdXBwb3J0c19hdXRvX3NhdmUYDyABKAhSEHN1cHBvcnRzQXV0b1'
    'NhdmUSOgoZc3VwcG9ydHNfdXBmcm9udF9pbnRlcmVzdBgQIAEoCFIXc3VwcG9ydHNVcGZyb250'
    'SW50ZXJlc3QSMAoUZHVyYXRpb25fYm9udXNfdGllcnMYESABKAlSEmR1cmF0aW9uQm9udXNUaW'
    'VycxIbCglpc19hY3RpdmUYEiABKAhSCGlzQWN0aXZlEiAKC2Rlc2NyaXB0aW9uGBMgASgJUgtk'
    'ZXNjcmlwdGlvbg==');

@$core.Deprecated('Use lockFundAutoSaveDescriptor instead')
const LockFundAutoSave$json = {
  '1': 'LockFundAutoSave',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'lock_fund_id', '3': 2, '4': 1, '5': 9, '10': 'lockFundId'},
    {'1': 'source_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 5, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'next_run_at', '3': 7, '4': 1, '5': 9, '10': 'nextRunAt'},
    {'1': 'last_run_at', '3': 8, '4': 1, '5': 9, '10': 'lastRunAt'},
    {'1': 'total_saved', '3': 9, '4': 1, '5': 1, '10': 'totalSaved'},
    {'1': 'run_count', '3': 10, '4': 1, '5': 5, '10': 'runCount'},
  ],
};

/// Descriptor for `LockFundAutoSave`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockFundAutoSaveDescriptor = $convert.base64Decode(
    'ChBMb2NrRnVuZEF1dG9TYXZlEg4KAmlkGAEgASgJUgJpZBIgCgxsb2NrX2Z1bmRfaWQYAiABKA'
    'lSCmxvY2tGdW5kSWQSKgoRc291cmNlX2FjY291bnRfaWQYAyABKAlSD3NvdXJjZUFjY291bnRJ'
    'ZBIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIcCglmcmVxdWVuY3kYBSABKAlSCWZyZXF1ZW5jeR'
    'IWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIeCgtuZXh0X3J1bl9hdBgHIAEoCVIJbmV4dFJ1bkF0'
    'Eh4KC2xhc3RfcnVuX2F0GAggASgJUglsYXN0UnVuQXQSHwoLdG90YWxfc2F2ZWQYCSABKAFSCn'
    'RvdGFsU2F2ZWQSGwoJcnVuX2NvdW50GAogASgFUghydW5Db3VudA==');

@$core.Deprecated('Use createLockFundRequestDescriptor instead')
const CreateLockFundRequest$json = {
  '1': 'CreateLockFundRequest',
  '2': [
    {'1': 'lock_type', '3': 1, '4': 1, '5': 14, '6': '.pb.LockType', '10': 'lockType'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'lock_duration_days', '3': 4, '4': 1, '5': 5, '10': 'lockDurationDays'},
    {'1': 'auto_renew', '3': 5, '4': 1, '5': 8, '10': 'autoRenew'},
    {'1': 'goal_name', '3': 6, '4': 1, '5': 9, '10': 'goalName'},
    {'1': 'goal_description', '3': 7, '4': 1, '5': 9, '10': 'goalDescription'},
    {'1': 'payment_method', '3': 8, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'source_account_id', '3': 9, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'transaction_pin', '3': 10, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `CreateLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundRequestDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVMb2NrRnVuZFJlcXVlc3QSKQoJbG9ja190eXBlGAEgASgOMgwucGIuTG9ja1R5cG'
    'VSCGxvY2tUeXBlEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghj'
    'dXJyZW5jeRIsChJsb2NrX2R1cmF0aW9uX2RheXMYBCABKAVSEGxvY2tEdXJhdGlvbkRheXMSHQ'
    'oKYXV0b19yZW5ldxgFIAEoCFIJYXV0b1JlbmV3EhsKCWdvYWxfbmFtZRgGIAEoCVIIZ29hbE5h'
    'bWUSKQoQZ29hbF9kZXNjcmlwdGlvbhgHIAEoCVIPZ29hbERlc2NyaXB0aW9uEiUKDnBheW1lbn'
    'RfbWV0aG9kGAggASgJUg1wYXltZW50TWV0aG9kEioKEXNvdXJjZV9hY2NvdW50X2lkGAkgASgJ'
    'Ug9zb3VyY2VBY2NvdW50SWQSJwoPdHJhbnNhY3Rpb25fcGluGAogASgJUg50cmFuc2FjdGlvbl'
    'Bpbg==');

@$core.Deprecated('Use createLockFundResponseDescriptor instead')
const CreateLockFundResponse$json = {
  '1': 'CreateLockFundResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'lock_fund', '3': 3, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'lockFund'},
    {'1': 'payment_url', '3': 4, '4': 1, '5': 9, '10': 'paymentUrl'},
  ],
};

/// Descriptor for `CreateLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundResponseDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVMb2NrRnVuZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIpCglsb2NrX2Z1bmQYAyABKAsyDC5wYi5Mb2NrRnVuZFII'
    'bG9ja0Z1bmQSHwoLcGF5bWVudF91cmwYBCABKAlSCnBheW1lbnRVcmw=');

@$core.Deprecated('Use getLockFundsRequestDescriptor instead')
const GetLockFundsRequest$json = {
  '1': 'GetLockFundsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.pb.LockStatus', '10': 'status'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetLockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundsRequestDescriptor = $convert.base64Decode(
    'ChNHZXRMb2NrRnVuZHNSZXF1ZXN0EiYKBnN0YXR1cxgBIAEoDjIOLnBiLkxvY2tTdGF0dXNSBn'
    'N0YXR1cxISCgRwYWdlGAIgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAMgASgFUgdwZXJQYWdl');

@$core.Deprecated('Use getLockFundsResponseDescriptor instead')
const GetLockFundsResponse$json = {
  '1': 'GetLockFundsResponse',
  '2': [
    {'1': 'lock_funds', '3': 1, '4': 3, '5': 11, '6': '.pb.LockFund', '10': 'lockFunds'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_locked_amount', '3': 5, '4': 1, '5': 1, '10': 'totalLockedAmount'},
    {'1': 'total_accrued_interest', '3': 6, '4': 1, '5': 1, '10': 'totalAccruedInterest'},
    {'1': 'active_locks_count', '3': 7, '4': 1, '5': 5, '10': 'activeLocksCount'},
  ],
};

/// Descriptor for `GetLockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundsResponseDescriptor = $convert.base64Decode(
    'ChRHZXRMb2NrRnVuZHNSZXNwb25zZRIrCgpsb2NrX2Z1bmRzGAEgAygLMgwucGIuTG9ja0Z1bm'
    'RSCWxvY2tGdW5kcxIfCgt0b3RhbF9jb3VudBgCIAEoBVIKdG90YWxDb3VudBISCgRwYWdlGAMg'
    'ASgFUgRwYWdlEh8KC3RvdGFsX3BhZ2VzGAQgASgFUgp0b3RhbFBhZ2VzEi4KE3RvdGFsX2xvY2'
    'tlZF9hbW91bnQYBSABKAFSEXRvdGFsTG9ja2VkQW1vdW50EjQKFnRvdGFsX2FjY3J1ZWRfaW50'
    'ZXJlc3QYBiABKAFSFHRvdGFsQWNjcnVlZEludGVyZXN0EiwKEmFjdGl2ZV9sb2Nrc19jb3VudB'
    'gHIAEoBVIQYWN0aXZlTG9ja3NDb3VudA==');

@$core.Deprecated('Use getLockFundRequestDescriptor instead')
const GetLockFundRequest$json = {
  '1': 'GetLockFundRequest',
  '2': [
    {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
  ],
};

/// Descriptor for `GetLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundRequestDescriptor = $convert.base64Decode(
    'ChJHZXRMb2NrRnVuZFJlcXVlc3QSIAoMbG9ja19mdW5kX2lkGAEgASgJUgpsb2NrRnVuZElk');

@$core.Deprecated('Use getLockFundResponseDescriptor instead')
const GetLockFundResponse$json = {
  '1': 'GetLockFundResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'lock_fund', '3': 2, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'lockFund'},
  ],
};

/// Descriptor for `GetLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundResponseDescriptor = $convert.base64Decode(
    'ChNHZXRMb2NrRnVuZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSKQoJbG9ja1'
    '9mdW5kGAIgASgLMgwucGIuTG9ja0Z1bmRSCGxvY2tGdW5k');

@$core.Deprecated('Use unlockFundRequestDescriptor instead')
const UnlockFundRequest$json = {
  '1': 'UnlockFundRequest',
  '2': [
    {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    {'1': 'force_early_unlock', '3': 2, '4': 1, '5': 8, '10': 'forceEarlyUnlock'},
    {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'destination_account_id', '3': 4, '4': 1, '5': 9, '10': 'destinationAccountId'},
  ],
};

/// Descriptor for `UnlockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockFundRequestDescriptor = $convert.base64Decode(
    'ChFVbmxvY2tGdW5kUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2tGdW5kSWQSLA'
    'oSZm9yY2VfZWFybHlfdW5sb2NrGAIgASgIUhBmb3JjZUVhcmx5VW5sb2NrEicKD3RyYW5zYWN0'
    'aW9uX3BpbhgDIAEoCVIOdHJhbnNhY3Rpb25QaW4SNAoWZGVzdGluYXRpb25fYWNjb3VudF9pZB'
    'gEIAEoCVIUZGVzdGluYXRpb25BY2NvdW50SWQ=');

@$core.Deprecated('Use unlockFundResponseDescriptor instead')
const UnlockFundResponse$json = {
  '1': 'UnlockFundResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'amount_returned', '3': 3, '4': 1, '5': 1, '10': 'amountReturned'},
    {'1': 'penalty_amount', '3': 4, '4': 1, '5': 1, '10': 'penaltyAmount'},
    {'1': 'interest_earned', '3': 5, '4': 1, '5': 1, '10': 'interestEarned'},
    {'1': 'updated_lock_fund', '3': 6, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'updatedLockFund'},
    {'1': 'credited_account_id', '3': 7, '4': 1, '5': 9, '10': 'creditedAccountId'},
  ],
};

/// Descriptor for `UnlockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockFundResponseDescriptor = $convert.base64Decode(
    'ChJVbmxvY2tGdW5kUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYW'
    'dlGAIgASgJUgdtZXNzYWdlEicKD2Ftb3VudF9yZXR1cm5lZBgDIAEoAVIOYW1vdW50UmV0dXJu'
    'ZWQSJQoOcGVuYWx0eV9hbW91bnQYBCABKAFSDXBlbmFsdHlBbW91bnQSJwoPaW50ZXJlc3RfZW'
    'FybmVkGAUgASgBUg5pbnRlcmVzdEVhcm5lZBI4ChF1cGRhdGVkX2xvY2tfZnVuZBgGIAEoCzIM'
    'LnBiLkxvY2tGdW5kUg91cGRhdGVkTG9ja0Z1bmQSLgoTY3JlZGl0ZWRfYWNjb3VudF9pZBgHIA'
    'EoCVIRY3JlZGl0ZWRBY2NvdW50SWQ=');

@$core.Deprecated('Use topUpLockFundRequestDescriptor instead')
const TopUpLockFundRequest$json = {
  '1': 'TopUpLockFundRequest',
  '2': [
    {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `TopUpLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topUpLockFundRequestDescriptor = $convert.base64Decode(
    'ChRUb3BVcExvY2tGdW5kUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2tGdW5kSW'
    'QSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSJwoPdHJhbnNhY3Rpb25fcGluGAMgASgJUg50cmFu'
    'c2FjdGlvblBpbhIqChFzb3VyY2VfYWNjb3VudF9pZBgEIAEoCVIPc291cmNlQWNjb3VudElk');

@$core.Deprecated('Use topUpLockFundResponseDescriptor instead')
const TopUpLockFundResponse$json = {
  '1': 'TopUpLockFundResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'updated_lock_fund', '3': 3, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'updatedLockFund'},
    {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
  ],
};

/// Descriptor for `TopUpLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topUpLockFundResponseDescriptor = $convert.base64Decode(
    'ChVUb3BVcExvY2tGdW5kUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdlEjgKEXVwZGF0ZWRfbG9ja19mdW5kGAMgASgLMgwucGIuTG9j'
    'a0Z1bmRSD3VwZGF0ZWRMb2NrRnVuZBIfCgtuZXdfYmFsYW5jZRgEIAEoAVIKbmV3QmFsYW5jZQ'
    '==');

@$core.Deprecated('Use getLockTransactionsRequestDescriptor instead')
const GetLockTransactionsRequest$json = {
  '1': 'GetLockTransactionsRequest',
  '2': [
    {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `GetLockTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockTransactionsRequestDescriptor = $convert.base64Decode(
    'ChpHZXRMb2NrVHJhbnNhY3Rpb25zUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2'
    'tGdW5kSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgDIAEoBVIHcGVyUGFnZQ==');

@$core.Deprecated('Use getLockTransactionsResponseDescriptor instead')
const GetLockTransactionsResponse$json = {
  '1': 'GetLockTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.LockTransaction', '10': 'transactions'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetLockTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockTransactionsResponseDescriptor = $convert.base64Decode(
    'ChtHZXRMb2NrVHJhbnNhY3Rpb25zUmVzcG9uc2USNwoMdHJhbnNhY3Rpb25zGAEgAygLMhMucG'
    'IuTG9ja1RyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSHwoLdG90YWxfY291bnQYAiABKAVSCnRv'
    'dGFsQ291bnQSEgoEcGFnZRgDIAEoBVIEcGFnZRIfCgt0b3RhbF9wYWdlcxgEIAEoBVIKdG90YW'
    'xQYWdlcw==');

@$core.Deprecated('Use calculateInterestRequestDescriptor instead')
const CalculateInterestRequest$json = {
  '1': 'CalculateInterestRequest',
  '2': [
    {'1': 'lock_type', '3': 1, '4': 1, '5': 14, '6': '.pb.LockType', '10': 'lockType'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'lock_duration_days', '3': 3, '4': 1, '5': 5, '10': 'lockDurationDays'},
  ],
};

/// Descriptor for `CalculateInterestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateInterestRequestDescriptor = $convert.base64Decode(
    'ChhDYWxjdWxhdGVJbnRlcmVzdFJlcXVlc3QSKQoJbG9ja190eXBlGAEgASgOMgwucGIuTG9ja1'
    'R5cGVSCGxvY2tUeXBlEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EiwKEmxvY2tfZHVyYXRpb25f'
    'ZGF5cxgDIAEoBVIQbG9ja0R1cmF0aW9uRGF5cw==');

@$core.Deprecated('Use calculateInterestResponseDescriptor instead')
const CalculateInterestResponse$json = {
  '1': 'CalculateInterestResponse',
  '2': [
    {'1': 'interest_rate', '3': 1, '4': 1, '5': 1, '10': 'interestRate'},
    {'1': 'estimated_interest', '3': 2, '4': 1, '5': 1, '10': 'estimatedInterest'},
    {'1': 'total_return', '3': 3, '4': 1, '5': 1, '10': 'totalReturn'},
    {'1': 'apy', '3': 4, '4': 1, '5': 1, '10': 'apy'},
  ],
};

/// Descriptor for `CalculateInterestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculateInterestResponseDescriptor = $convert.base64Decode(
    'ChlDYWxjdWxhdGVJbnRlcmVzdFJlc3BvbnNlEiMKDWludGVyZXN0X3JhdGUYASABKAFSDGludG'
    'VyZXN0UmF0ZRItChJlc3RpbWF0ZWRfaW50ZXJlc3QYAiABKAFSEWVzdGltYXRlZEludGVyZXN0'
    'EiEKDHRvdGFsX3JldHVybhgDIAEoAVILdG90YWxSZXR1cm4SEAoDYXB5GAQgASgBUgNhcHk=');

@$core.Deprecated('Use renewLockFundRequestDescriptor instead')
const RenewLockFundRequest$json = {
  '1': 'RenewLockFundRequest',
  '2': [
    {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    {'1': 'new_duration_days', '3': 2, '4': 1, '5': 5, '10': 'newDurationDays'},
  ],
};

/// Descriptor for `RenewLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renewLockFundRequestDescriptor = $convert.base64Decode(
    'ChRSZW5ld0xvY2tGdW5kUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2tGdW5kSW'
    'QSKgoRbmV3X2R1cmF0aW9uX2RheXMYAiABKAVSD25ld0R1cmF0aW9uRGF5cw==');

@$core.Deprecated('Use renewLockFundResponseDescriptor instead')
const RenewLockFundResponse$json = {
  '1': 'RenewLockFundResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'renewed_lock_fund', '3': 3, '4': 1, '5': 11, '6': '.pb.LockFund', '10': 'renewedLockFund'},
  ],
};

/// Descriptor for `RenewLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renewLockFundResponseDescriptor = $convert.base64Decode(
    'ChVSZW5ld0xvY2tGdW5kUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdlEjgKEXJlbmV3ZWRfbG9ja19mdW5kGAMgASgLMgwucGIuTG9j'
    'a0Z1bmRSD3JlbmV3ZWRMb2NrRnVuZA==');

@$core.Deprecated('Use cancelLockFundRequestDescriptor instead')
const CancelLockFundRequest$json = {
  '1': 'CancelLockFundRequest',
  '2': [
    {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelLockFundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelLockFundRequestDescriptor = $convert.base64Decode(
    'ChVDYW5jZWxMb2NrRnVuZFJlcXVlc3QSIAoMbG9ja19mdW5kX2lkGAEgASgJUgpsb2NrRnVuZE'
    'lkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');

@$core.Deprecated('Use cancelLockFundResponseDescriptor instead')
const CancelLockFundResponse$json = {
  '1': 'CancelLockFundResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'refund_amount', '3': 3, '4': 1, '5': 1, '10': 'refundAmount'},
  ],
};

/// Descriptor for `CancelLockFundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelLockFundResponseDescriptor = $convert.base64Decode(
    'ChZDYW5jZWxMb2NrRnVuZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIjCg1yZWZ1bmRfYW1vdW50GAMgASgBUgxyZWZ1bmRBbW91'
    'bnQ=');

@$core.Deprecated('Use getPiggyVaultConfigsRequestDescriptor instead')
const GetPiggyVaultConfigsRequest$json = {
  '1': 'GetPiggyVaultConfigsRequest',
  '2': [
    {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetPiggyVaultConfigsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPiggyVaultConfigsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRQaWdneVZhdWx0Q29uZmlnc1JlcXVlc3QSGgoIY3VycmVuY3kYASABKAlSCGN1cnJlbm'
    'N5');

@$core.Deprecated('Use getPiggyVaultConfigsResponseDescriptor instead')
const GetPiggyVaultConfigsResponse$json = {
  '1': 'GetPiggyVaultConfigsResponse',
  '2': [
    {'1': 'configs', '3': 1, '4': 3, '5': 11, '6': '.pb.PiggyVaultConfig', '10': 'configs'},
  ],
};

/// Descriptor for `GetPiggyVaultConfigsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPiggyVaultConfigsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRQaWdneVZhdWx0Q29uZmlnc1Jlc3BvbnNlEi4KB2NvbmZpZ3MYASADKAsyFC5wYi5QaW'
    'dneVZhdWx0Q29uZmlnUgdjb25maWdz');

@$core.Deprecated('Use createLockFundAutoSaveRequestDescriptor instead')
const CreateLockFundAutoSaveRequest$json = {
  '1': 'CreateLockFundAutoSaveRequest',
  '2': [
    {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
  ],
};

/// Descriptor for `CreateLockFundAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundAutoSaveRequestDescriptor = $convert.base64Decode(
    'Ch1DcmVhdGVMb2NrRnVuZEF1dG9TYXZlUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCm'
    'xvY2tGdW5kSWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBIW'
    'CgZhbW91bnQYAyABKAFSBmFtb3VudBIcCglmcmVxdWVuY3kYBCABKAlSCWZyZXF1ZW5jeQ==');

@$core.Deprecated('Use createLockFundAutoSaveResponseDescriptor instead')
const CreateLockFundAutoSaveResponse$json = {
  '1': 'CreateLockFundAutoSaveResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'autosave', '3': 3, '4': 1, '5': 11, '6': '.pb.LockFundAutoSave', '10': 'autosave'},
  ],
};

/// Descriptor for `CreateLockFundAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundAutoSaveResponseDescriptor = $convert.base64Decode(
    'Ch5DcmVhdGVMb2NrRnVuZEF1dG9TYXZlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
    'VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjAKCGF1dG9zYXZlGAMgASgLMhQucGIuTG9j'
    'a0Z1bmRBdXRvU2F2ZVIIYXV0b3NhdmU=');

@$core.Deprecated('Use getLockFundAutoSaveRequestDescriptor instead')
const GetLockFundAutoSaveRequest$json = {
  '1': 'GetLockFundAutoSaveRequest',
  '2': [
    {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
  ],
};

/// Descriptor for `GetLockFundAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundAutoSaveRequestDescriptor = $convert.base64Decode(
    'ChpHZXRMb2NrRnVuZEF1dG9TYXZlUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2'
    'tGdW5kSWQ=');

@$core.Deprecated('Use getLockFundAutoSaveResponseDescriptor instead')
const GetLockFundAutoSaveResponse$json = {
  '1': 'GetLockFundAutoSaveResponse',
  '2': [
    {'1': 'autosave', '3': 1, '4': 1, '5': 11, '6': '.pb.LockFundAutoSave', '10': 'autosave'},
  ],
};

/// Descriptor for `GetLockFundAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundAutoSaveResponseDescriptor = $convert.base64Decode(
    'ChtHZXRMb2NrRnVuZEF1dG9TYXZlUmVzcG9uc2USMAoIYXV0b3NhdmUYASABKAsyFC5wYi5Mb2'
    'NrRnVuZEF1dG9TYXZlUghhdXRvc2F2ZQ==');

@$core.Deprecated('Use updateLockFundAutoSaveRequestDescriptor instead')
const UpdateLockFundAutoSaveRequest$json = {
  '1': 'UpdateLockFundAutoSaveRequest',
  '2': [
    {'1': 'autosave_id', '3': 1, '4': 1, '5': 9, '10': 'autosaveId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `UpdateLockFundAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLockFundAutoSaveRequestDescriptor = $convert.base64Decode(
    'Ch1VcGRhdGVMb2NrRnVuZEF1dG9TYXZlUmVxdWVzdBIfCgthdXRvc2F2ZV9pZBgBIAEoCVIKYX'
    'V0b3NhdmVJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIcCglmcmVxdWVuY3kYAyABKAlSCWZy'
    'ZXF1ZW5jeRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use updateLockFundAutoSaveResponseDescriptor instead')
const UpdateLockFundAutoSaveResponse$json = {
  '1': 'UpdateLockFundAutoSaveResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'autosave', '3': 3, '4': 1, '5': 11, '6': '.pb.LockFundAutoSave', '10': 'autosave'},
  ],
};

/// Descriptor for `UpdateLockFundAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLockFundAutoSaveResponseDescriptor = $convert.base64Decode(
    'Ch5VcGRhdGVMb2NrRnVuZEF1dG9TYXZlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
    'VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjAKCGF1dG9zYXZlGAMgASgLMhQucGIuTG9j'
    'a0Z1bmRBdXRvU2F2ZVIIYXV0b3NhdmU=');

@$core.Deprecated('Use deleteLockFundAutoSaveRequestDescriptor instead')
const DeleteLockFundAutoSaveRequest$json = {
  '1': 'DeleteLockFundAutoSaveRequest',
  '2': [
    {'1': 'autosave_id', '3': 1, '4': 1, '5': 9, '10': 'autosaveId'},
  ],
};

/// Descriptor for `DeleteLockFundAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteLockFundAutoSaveRequestDescriptor = $convert.base64Decode(
    'Ch1EZWxldGVMb2NrRnVuZEF1dG9TYXZlUmVxdWVzdBIfCgthdXRvc2F2ZV9pZBgBIAEoCVIKYX'
    'V0b3NhdmVJZA==');

@$core.Deprecated('Use deleteLockFundAutoSaveResponseDescriptor instead')
const DeleteLockFundAutoSaveResponse$json = {
  '1': 'DeleteLockFundAutoSaveResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteLockFundAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteLockFundAutoSaveResponseDescriptor = $convert.base64Decode(
    'Ch5EZWxldGVMb2NrRnVuZEF1dG9TYXZlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
    'VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

