///
//  Generated code. Do not modify.
//  source: deposit.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use depositStatusDescriptor instead')
const DepositStatus$json = const {
  '1': 'DepositStatus',
  '2': const [
    const {'1': 'DEPOSIT_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'DEPOSIT_STATUS_PENDING', '2': 1},
    const {'1': 'DEPOSIT_STATUS_PROCESSING', '2': 2},
    const {'1': 'DEPOSIT_STATUS_COMPLETED', '2': 3},
    const {'1': 'DEPOSIT_STATUS_FAILED', '2': 4},
  ],
};

/// Descriptor for `DepositStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List depositStatusDescriptor = $convert.base64Decode('Cg1EZXBvc2l0U3RhdHVzEh4KGkRFUE9TSVRfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGgoWREVQT1NJVF9TVEFUVVNfUEVORElORxABEh0KGURFUE9TSVRfU1RBVFVTX1BST0NFU1NJTkcQAhIcChhERVBPU0lUX1NUQVRVU19DT01QTEVURUQQAxIZChVERVBPU0lUX1NUQVRVU19GQUlMRUQQBA==');
@$core.Deprecated('Use initiateDepositRequestDescriptor instead')
const InitiateDepositRequest$json = const {
  '1': 'InitiateDepositRequest',
  '2': const [
    const {'1': 'target_account_id', '3': 1, '4': 1, '5': 4, '10': 'target_account_id'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'source_bank_name', '3': 4, '4': 1, '5': 9, '10': 'source_bank_name'},
  ],
  '7': const {},
};

/// Descriptor for `InitiateDepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateDepositRequestDescriptor = $convert.base64Decode('ChZJbml0aWF0ZURlcG9zaXRSZXF1ZXN0EiwKEXRhcmdldF9hY2NvdW50X2lkGAEgASgEUhF0YXJnZXRfYWNjb3VudF9pZBIWCgZhbW91bnQYAiABKARSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSKgoQc291cmNlX2JhbmtfbmFtZRgEIAEoCVIQc291cmNlX2JhbmtfbmFtZTpAkkE9CjvSARF0YXJnZXRfYWNjb3VudF9pZNIBBmFtb3VudNIBCGN1cnJlbmN50gEQc291cmNlX2JhbmtfbmFtZQ==');
@$core.Deprecated('Use initiateDepositResponseDescriptor instead')
const InitiateDepositResponse$json = const {
  '1': 'InitiateDepositResponse',
  '2': const [
    const {'1': 'deposit_id', '3': 1, '4': 1, '5': 9, '10': 'deposit_id'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.DepositStatus', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiateDepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateDepositResponseDescriptor = $convert.base64Decode('ChdJbml0aWF0ZURlcG9zaXRSZXNwb25zZRIeCgpkZXBvc2l0X2lkGAEgASgJUgpkZXBvc2l0X2lkEikKBnN0YXR1cxgCIAEoDjIRLnBiLkRlcG9zaXRTdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getDepositDetailsRequestDescriptor instead')
const GetDepositDetailsRequest$json = const {
  '1': 'GetDepositDetailsRequest',
  '2': const [
    const {'1': 'deposit_id', '3': 1, '4': 1, '5': 9, '10': 'deposit_id'},
  ],
};

/// Descriptor for `GetDepositDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDepositDetailsRequestDescriptor = $convert.base64Decode('ChhHZXREZXBvc2l0RGV0YWlsc1JlcXVlc3QSHgoKZGVwb3NpdF9pZBgBIAEoCVIKZGVwb3NpdF9pZA==');
@$core.Deprecated('Use getDepositDetailsResponseDescriptor instead')
const GetDepositDetailsResponse$json = const {
  '1': 'GetDepositDetailsResponse',
  '2': const [
    const {'1': 'deposit_id', '3': 1, '4': 1, '5': 9, '10': 'deposit_id'},
    const {'1': 'target_account_id', '3': 2, '4': 1, '5': 4, '10': 'target_account_id'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 4, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'source_bank_name', '3': 5, '4': 1, '5': 9, '10': 'source_bank_name'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.pb.DepositStatus', '10': 'status'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created_at'},
    const {'1': 'processing_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processing_at'},
    const {'1': 'completed_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completed_at'},
    const {'1': 'failed_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failed_at'},
    const {'1': 'failure_reason', '3': 11, '4': 1, '5': 9, '10': 'failure_reason'},
    const {'1': 'external_transaction_id', '3': 12, '4': 1, '5': 9, '10': 'external_transaction_id'},
    const {'1': 'updated_account', '3': 13, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'updated_account'},
  ],
};

/// Descriptor for `GetDepositDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDepositDetailsResponseDescriptor = $convert.base64Decode('ChlHZXREZXBvc2l0RGV0YWlsc1Jlc3BvbnNlEh4KCmRlcG9zaXRfaWQYASABKAlSCmRlcG9zaXRfaWQSLAoRdGFyZ2V0X2FjY291bnRfaWQYAiABKARSEXRhcmdldF9hY2NvdW50X2lkEhYKBmFtb3VudBgDIAEoBFIGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIqChBzb3VyY2VfYmFua19uYW1lGAUgASgJUhBzb3VyY2VfYmFua19uYW1lEikKBnN0YXR1cxgGIAEoDjIRLnBiLkRlcG9zaXRTdGF0dXNSBnN0YXR1cxI6CgpjcmVhdGVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKY3JlYXRlZF9hdBJACg1wcm9jZXNzaW5nX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFINcHJvY2Vzc2luZ19hdBI+Cgxjb21wbGV0ZWRfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxjb21wbGV0ZWRfYXQSOAoJZmFpbGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZmFpbGVkX2F0EiYKDmZhaWx1cmVfcmVhc29uGAsgASgJUg5mYWlsdXJlX3JlYXNvbhI4ChdleHRlcm5hbF90cmFuc2FjdGlvbl9pZBgMIAEoCVIXZXh0ZXJuYWxfdHJhbnNhY3Rpb25faWQSPAoPdXBkYXRlZF9hY2NvdW50GA0gASgLMhIucGIuQWNjb3VudERldGFpbHNSD3VwZGF0ZWRfYWNjb3VudA==');
