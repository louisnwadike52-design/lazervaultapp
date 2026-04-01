///
//  Generated code. Do not modify.
//  source: withdraw.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use withdrawalStatusDescriptor instead')
const WithdrawalStatus$json = const {
  '1': 'WithdrawalStatus',
  '2': const [
    const {'1': 'WITHDRAWAL_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'WITHDRAWAL_STATUS_PENDING', '2': 1},
    const {'1': 'WITHDRAWAL_STATUS_PROCESSING', '2': 2},
    const {'1': 'WITHDRAWAL_STATUS_COMPLETED', '2': 3},
    const {'1': 'WITHDRAWAL_STATUS_FAILED', '2': 4},
  ],
};

/// Descriptor for `WithdrawalStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List withdrawalStatusDescriptor = $convert.base64Decode('ChBXaXRoZHJhd2FsU3RhdHVzEiEKHVdJVEhEUkFXQUxfU1RBVFVTX1VOU1BFQ0lGSUVEEAASHQoZV0lUSERSQVdBTF9TVEFUVVNfUEVORElORxABEiAKHFdJVEhEUkFXQUxfU1RBVFVTX1BST0NFU1NJTkcQAhIfChtXSVRIRFJBV0FMX1NUQVRVU19DT01QTEVURUQQAxIcChhXSVRIRFJBV0FMX1NUQVRVU19GQUlMRUQQBA==');
@$core.Deprecated('Use withdrawalTransactionDescriptor instead')
const WithdrawalTransaction$json = const {
  '1': 'WithdrawalTransaction',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 4, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'target_bank_name', '3': 7, '4': 1, '5': 9, '10': 'targetBankName'},
    const {'1': 'target_account_number', '3': 8, '4': 1, '5': 9, '10': 'targetAccountNumber'},
    const {'1': 'target_sort_code', '3': 9, '4': 1, '5': 9, '10': 'targetSortCode'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.WithdrawalStatus', '10': 'status'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'completed_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    const {'1': 'failed_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failedAt'},
    const {'1': 'failure_reason', '3': 14, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `WithdrawalTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalTransactionDescriptor = $convert.base64Decode('ChVXaXRoZHJhd2FsVHJhbnNhY3Rpb24SJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKARSD3NvdXJjZUFjY291bnRJZBIWCgZhbW91bnQYAyABKARSBmFtb3VudBIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSKAoQdGFyZ2V0X2JhbmtfbmFtZRgHIAEoCVIOdGFyZ2V0QmFua05hbWUSMgoVdGFyZ2V0X2FjY291bnRfbnVtYmVyGAggASgJUhN0YXJnZXRBY2NvdW50TnVtYmVyEigKEHRhcmdldF9zb3J0X2NvZGUYCSABKAlSDnRhcmdldFNvcnRDb2RlEiwKBnN0YXR1cxgKIAEoDjIULnBiLldpdGhkcmF3YWxTdGF0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2NvbXBsZXRlZEF0EjcKCWZhaWxlZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGZhaWxlZEF0EiUKDmZhaWx1cmVfcmVhc29uGA4gASgJUg1mYWlsdXJlUmVhc29u');
@$core.Deprecated('Use initiateWithdrawalRequestDescriptor instead')
const InitiateWithdrawalRequest$json = const {
  '1': 'InitiateWithdrawalRequest',
  '2': const [
    const {'1': 'source_account_id', '3': 1, '4': 1, '5': 4, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'target_bank_name', '3': 4, '4': 1, '5': 9, '10': 'targetBankName'},
    const {'1': 'target_account_number', '3': 5, '4': 1, '5': 9, '10': 'targetAccountNumber'},
    const {'1': 'target_sort_code', '3': 6, '4': 1, '5': 9, '10': 'targetSortCode'},
  ],
  '7': const {},
};

/// Descriptor for `InitiateWithdrawalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateWithdrawalRequestDescriptor = $convert.base64Decode('ChlJbml0aWF0ZVdpdGhkcmF3YWxSZXF1ZXN0EioKEXNvdXJjZV9hY2NvdW50X2lkGAEgASgEUg9zb3VyY2VBY2NvdW50SWQSFgoGYW1vdW50GAIgASgEUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EigKEHRhcmdldF9iYW5rX25hbWUYBCABKAlSDnRhcmdldEJhbmtOYW1lEjIKFXRhcmdldF9hY2NvdW50X251bWJlchgFIAEoCVITdGFyZ2V0QWNjb3VudE51bWJlchIoChB0YXJnZXRfc29ydF9jb2RlGAYgASgJUg50YXJnZXRTb3J0Q29kZTpYkkFVClPSARFzb3VyY2VfYWNjb3VudF9pZNIBBmFtb3VudNIBCGN1cnJlbmN50gEQdGFyZ2V0X2JhbmtfbmFtZdIBFXRhcmdldF9hY2NvdW50X251bWJlcg==');
@$core.Deprecated('Use initiateWithdrawalResponseDescriptor instead')
const InitiateWithdrawalResponse$json = const {
  '1': 'InitiateWithdrawalResponse',
  '2': const [
    const {'1': 'withdrawal_id', '3': 1, '4': 1, '5': 9, '10': 'withdrawal_id'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.WithdrawalStatus', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiateWithdrawalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateWithdrawalResponseDescriptor = $convert.base64Decode('ChpJbml0aWF0ZVdpdGhkcmF3YWxSZXNwb25zZRIkCg13aXRoZHJhd2FsX2lkGAEgASgJUg13aXRoZHJhd2FsX2lkEiwKBnN0YXR1cxgCIAEoDjIULnBiLldpdGhkcmF3YWxTdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getWithdrawalDetailsRequestDescriptor instead')
const GetWithdrawalDetailsRequest$json = const {
  '1': 'GetWithdrawalDetailsRequest',
  '2': const [
    const {'1': 'withdrawal_id', '3': 1, '4': 1, '5': 9, '10': 'withdrawal_id'},
  ],
};

/// Descriptor for `GetWithdrawalDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWithdrawalDetailsRequestDescriptor = $convert.base64Decode('ChtHZXRXaXRoZHJhd2FsRGV0YWlsc1JlcXVlc3QSJAoNd2l0aGRyYXdhbF9pZBgBIAEoCVINd2l0aGRyYXdhbF9pZA==');
@$core.Deprecated('Use getWithdrawalDetailsResponseDescriptor instead')
const GetWithdrawalDetailsResponse$json = const {
  '1': 'GetWithdrawalDetailsResponse',
  '2': const [
    const {'1': 'withdrawal_id', '3': 1, '4': 1, '5': 9, '10': 'withdrawal_id'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 4, '10': 'source_account_id'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'target_bank_name', '3': 5, '4': 1, '5': 9, '10': 'target_bank_name'},
    const {'1': 'target_account_number', '3': 6, '4': 1, '5': 9, '10': 'target_account_number'},
    const {'1': 'target_sort_code', '3': 7, '4': 1, '5': 9, '10': 'target_sort_code'},
    const {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.WithdrawalStatus', '10': 'status'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created_at'},
    const {'1': 'processing_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processing_at'},
    const {'1': 'completed_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completed_at'},
    const {'1': 'failed_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failed_at'},
    const {'1': 'failure_reason', '3': 13, '4': 1, '5': 9, '10': 'failure_reason'},
    const {'1': 'external_transaction_id', '3': 14, '4': 1, '5': 9, '10': 'external_transaction_id'},
  ],
};

/// Descriptor for `GetWithdrawalDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWithdrawalDetailsResponseDescriptor = $convert.base64Decode('ChxHZXRXaXRoZHJhd2FsRGV0YWlsc1Jlc3BvbnNlEiQKDXdpdGhkcmF3YWxfaWQYASABKAlSDXdpdGhkcmF3YWxfaWQSLAoRc291cmNlX2FjY291bnRfaWQYAiABKARSEXNvdXJjZV9hY2NvdW50X2lkEhYKBmFtb3VudBgDIAEoBFIGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIqChB0YXJnZXRfYmFua19uYW1lGAUgASgJUhB0YXJnZXRfYmFua19uYW1lEjQKFXRhcmdldF9hY2NvdW50X251bWJlchgGIAEoCVIVdGFyZ2V0X2FjY291bnRfbnVtYmVyEioKEHRhcmdldF9zb3J0X2NvZGUYByABKAlSEHRhcmdldF9zb3J0X2NvZGUSLAoGc3RhdHVzGAggASgOMhQucGIuV2l0aGRyYXdhbFN0YXR1c1IGc3RhdHVzEjoKCmNyZWF0ZWRfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpjcmVhdGVkX2F0EkAKDXByb2Nlc3NpbmdfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg1wcm9jZXNzaW5nX2F0Ej4KDGNvbXBsZXRlZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGNvbXBsZXRlZF9hdBI4CglmYWlsZWRfYXQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglmYWlsZWRfYXQSJgoOZmFpbHVyZV9yZWFzb24YDSABKAlSDmZhaWx1cmVfcmVhc29uEjgKF2V4dGVybmFsX3RyYW5zYWN0aW9uX2lkGA4gASgJUhdleHRlcm5hbF90cmFuc2FjdGlvbl9pZA==');
