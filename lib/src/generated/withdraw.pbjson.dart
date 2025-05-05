//
//  Generated code. Do not modify.
//  source: withdraw.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use withdrawalStatusDescriptor instead')
const WithdrawalStatus$json = {
  '1': 'WithdrawalStatus',
  '2': [
    {'1': 'WITHDRAWAL_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'WITHDRAWAL_STATUS_PENDING', '2': 1},
    {'1': 'WITHDRAWAL_STATUS_PROCESSING', '2': 2},
    {'1': 'WITHDRAWAL_STATUS_COMPLETED', '2': 3},
    {'1': 'WITHDRAWAL_STATUS_FAILED', '2': 4},
  ],
};

/// Descriptor for `WithdrawalStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List withdrawalStatusDescriptor = $convert.base64Decode(
    'ChBXaXRoZHJhd2FsU3RhdHVzEiEKHVdJVEhEUkFXQUxfU1RBVFVTX1VOU1BFQ0lGSUVEEAASHQ'
    'oZV0lUSERSQVdBTF9TVEFUVVNfUEVORElORxABEiAKHFdJVEhEUkFXQUxfU1RBVFVTX1BST0NF'
    'U1NJTkcQAhIfChtXSVRIRFJBV0FMX1NUQVRVU19DT01QTEVURUQQAxIcChhXSVRIRFJBV0FMX1'
    'NUQVRVU19GQUlMRUQQBA==');

@$core.Deprecated('Use withdrawalTransactionDescriptor instead')
const WithdrawalTransaction$json = {
  '1': 'WithdrawalTransaction',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 4, '10': 'sourceAccountId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'target_bank_name', '3': 7, '4': 1, '5': 9, '10': 'targetBankName'},
    {'1': 'target_account_number', '3': 8, '4': 1, '5': 9, '10': 'targetAccountNumber'},
    {'1': 'target_sort_code', '3': 9, '4': 1, '5': 9, '10': 'targetSortCode'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.WithdrawalStatus', '10': 'status'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    {'1': 'failed_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failedAt'},
    {'1': 'failure_reason', '3': 14, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `WithdrawalTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalTransactionDescriptor = $convert.base64Decode(
    'ChVXaXRoZHJhd2FsVHJhbnNhY3Rpb24SJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYW'
    'N0aW9uSWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKARSD3NvdXJjZUFjY291bnRJZBIWCgZh'
    'bW91bnQYAyABKARSBmFtb3VudBIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSKAoQdGFyZ2'
    'V0X2JhbmtfbmFtZRgHIAEoCVIOdGFyZ2V0QmFua05hbWUSMgoVdGFyZ2V0X2FjY291bnRfbnVt'
    'YmVyGAggASgJUhN0YXJnZXRBY2NvdW50TnVtYmVyEigKEHRhcmdldF9zb3J0X2NvZGUYCSABKA'
    'lSDnRhcmdldFNvcnRDb2RlEiwKBnN0YXR1cxgKIAEoDjIULnBiLldpdGhkcmF3YWxTdGF0dXNS'
    'BnN0YXR1cxI5CgpjcmVhdGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'IJY3JlYXRlZEF0Ej0KDGNvbXBsZXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1l'
    'c3RhbXBSC2NvbXBsZXRlZEF0EjcKCWZhaWxlZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSCGZhaWxlZEF0EiUKDmZhaWx1cmVfcmVhc29uGA4gASgJUg1mYWlsdXJlUmVh'
    'c29u');

@$core.Deprecated('Use initiateWithdrawalRequestDescriptor instead')
const InitiateWithdrawalRequest$json = {
  '1': 'InitiateWithdrawalRequest',
  '2': [
    {'1': 'source_account_id', '3': 1, '4': 1, '5': 4, '10': 'sourceAccountId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'target_bank_name', '3': 4, '4': 1, '5': 9, '10': 'targetBankName'},
    {'1': 'target_account_number', '3': 5, '4': 1, '5': 9, '10': 'targetAccountNumber'},
    {'1': 'target_sort_code', '3': 6, '4': 1, '5': 9, '10': 'targetSortCode'},
  ],
  '7': {},
};

/// Descriptor for `InitiateWithdrawalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateWithdrawalRequestDescriptor = $convert.base64Decode(
    'ChlJbml0aWF0ZVdpdGhkcmF3YWxSZXF1ZXN0EioKEXNvdXJjZV9hY2NvdW50X2lkGAEgASgEUg'
    '9zb3VyY2VBY2NvdW50SWQSFgoGYW1vdW50GAIgASgEUgZhbW91bnQSGgoIY3VycmVuY3kYAyAB'
    'KAlSCGN1cnJlbmN5EigKEHRhcmdldF9iYW5rX25hbWUYBCABKAlSDnRhcmdldEJhbmtOYW1lEj'
    'IKFXRhcmdldF9hY2NvdW50X251bWJlchgFIAEoCVITdGFyZ2V0QWNjb3VudE51bWJlchIoChB0'
    'YXJnZXRfc29ydF9jb2RlGAYgASgJUg50YXJnZXRTb3J0Q29kZTpYkkFVClPSARFzb3VyY2VfYW'
    'Njb3VudF9pZNIBBmFtb3VudNIBCGN1cnJlbmN50gEQdGFyZ2V0X2JhbmtfbmFtZdIBFXRhcmdl'
    'dF9hY2NvdW50X251bWJlcg==');

@$core.Deprecated('Use initiateWithdrawalResponseDescriptor instead')
const InitiateWithdrawalResponse$json = {
  '1': 'InitiateWithdrawalResponse',
  '2': [
    {'1': 'withdrawal_id', '3': 1, '4': 1, '5': 9, '10': 'withdrawal_id'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.WithdrawalStatus', '10': 'status'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiateWithdrawalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateWithdrawalResponseDescriptor = $convert.base64Decode(
    'ChpJbml0aWF0ZVdpdGhkcmF3YWxSZXNwb25zZRIkCg13aXRoZHJhd2FsX2lkGAEgASgJUg13aX'
    'RoZHJhd2FsX2lkEiwKBnN0YXR1cxgCIAEoDjIULnBiLldpdGhkcmF3YWxTdGF0dXNSBnN0YXR1'
    'cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getWithdrawalDetailsRequestDescriptor instead')
const GetWithdrawalDetailsRequest$json = {
  '1': 'GetWithdrawalDetailsRequest',
  '2': [
    {'1': 'withdrawal_id', '3': 1, '4': 1, '5': 9, '10': 'withdrawal_id'},
  ],
};

/// Descriptor for `GetWithdrawalDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWithdrawalDetailsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRXaXRoZHJhd2FsRGV0YWlsc1JlcXVlc3QSJAoNd2l0aGRyYXdhbF9pZBgBIAEoCVINd2'
    'l0aGRyYXdhbF9pZA==');

@$core.Deprecated('Use getWithdrawalDetailsResponseDescriptor instead')
const GetWithdrawalDetailsResponse$json = {
  '1': 'GetWithdrawalDetailsResponse',
  '2': [
    {'1': 'withdrawal_id', '3': 1, '4': 1, '5': 9, '10': 'withdrawal_id'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 4, '10': 'source_account_id'},
    {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'target_bank_name', '3': 5, '4': 1, '5': 9, '10': 'target_bank_name'},
    {'1': 'target_account_number', '3': 6, '4': 1, '5': 9, '10': 'target_account_number'},
    {'1': 'target_sort_code', '3': 7, '4': 1, '5': 9, '10': 'target_sort_code'},
    {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.WithdrawalStatus', '10': 'status'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created_at'},
    {'1': 'processing_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processing_at'},
    {'1': 'completed_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completed_at'},
    {'1': 'failed_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failed_at'},
    {'1': 'failure_reason', '3': 13, '4': 1, '5': 9, '10': 'failure_reason'},
    {'1': 'external_transaction_id', '3': 14, '4': 1, '5': 9, '10': 'external_transaction_id'},
  ],
};

/// Descriptor for `GetWithdrawalDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWithdrawalDetailsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRXaXRoZHJhd2FsRGV0YWlsc1Jlc3BvbnNlEiQKDXdpdGhkcmF3YWxfaWQYASABKAlSDX'
    'dpdGhkcmF3YWxfaWQSLAoRc291cmNlX2FjY291bnRfaWQYAiABKARSEXNvdXJjZV9hY2NvdW50'
    'X2lkEhYKBmFtb3VudBgDIAEoBFIGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeR'
    'IqChB0YXJnZXRfYmFua19uYW1lGAUgASgJUhB0YXJnZXRfYmFua19uYW1lEjQKFXRhcmdldF9h'
    'Y2NvdW50X251bWJlchgGIAEoCVIVdGFyZ2V0X2FjY291bnRfbnVtYmVyEioKEHRhcmdldF9zb3'
    'J0X2NvZGUYByABKAlSEHRhcmdldF9zb3J0X2NvZGUSLAoGc3RhdHVzGAggASgOMhQucGIuV2l0'
    'aGRyYXdhbFN0YXR1c1IGc3RhdHVzEjoKCmNyZWF0ZWRfYXQYCSABKAsyGi5nb29nbGUucHJvdG'
    '9idWYuVGltZXN0YW1wUgpjcmVhdGVkX2F0EkAKDXByb2Nlc3NpbmdfYXQYCiABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuVGltZXN0YW1wUg1wcm9jZXNzaW5nX2F0Ej4KDGNvbXBsZXRlZF9hdBgLIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGNvbXBsZXRlZF9hdBI4CglmYWlsZWRf'
    'YXQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglmYWlsZWRfYXQSJgoOZmFpbH'
    'VyZV9yZWFzb24YDSABKAlSDmZhaWx1cmVfcmVhc29uEjgKF2V4dGVybmFsX3RyYW5zYWN0aW9u'
    'X2lkGA4gASgJUhdleHRlcm5hbF90cmFuc2FjdGlvbl9pZA==');

