//
//  Generated code. Do not modify.
//  source: payments.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use paymentDescriptor instead')
const Payment$json = {
  '1': 'Payment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'payment_type', '3': 4, '4': 1, '5': 9, '10': 'paymentType'},
    {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'recipient', '3': 9, '4': 1, '5': 9, '10': 'recipient'},
    {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 11, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Payment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentDescriptor = $convert.base64Decode(
    'CgdQYXltZW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYW'
    'Njb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEiEKDHBheW1lbnRfdHlwZRgEIAEoCVILcGF5bWVu'
    'dFR5cGUSHAoJcmVmZXJlbmNlGAUgASgJUglyZWZlcmVuY2USFgoGYW1vdW50GAYgASgBUgZhbW'
    '91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgIIAEoCVIGc3RhdHVz'
    'EhwKCXJlY2lwaWVudBgJIAEoCVIJcmVjaXBpZW50EiAKC2Rlc2NyaXB0aW9uGAogASgJUgtkZX'
    'NjcmlwdGlvbhIaCghtZXRhZGF0YRgLIAEoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgMIAEo'
    'CVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYDSABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use billProviderDescriptor instead')
const BillProvider$json = {
  '1': 'BillProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'min_amount', '3': 6, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 7, '4': 1, '5': 1, '10': 'maxAmount'},
  ],
};

/// Descriptor for `BillProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billProviderDescriptor = $convert.base64Decode(
    'CgxCaWxsUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEdH'
    'lwZRgDIAEoCVIEdHlwZRIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUY'
    'BSABKAhSCGlzQWN0aXZlEh0KCm1pbl9hbW91bnQYBiABKAFSCW1pbkFtb3VudBIdCgptYXhfYW'
    '1vdW50GAcgASgBUgltYXhBbW91bnQ=');

@$core.Deprecated('Use airtimeProviderDescriptor instead')
const AirtimeProvider$json = {
  '1': 'AirtimeProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'denominations', '3': 6, '4': 3, '5': 9, '10': 'denominations'},
  ],
};

/// Descriptor for `AirtimeProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeProviderDescriptor = $convert.base64Decode(
    'Cg9BaXJ0aW1lUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGA'
    'oHbmV0d29yaxgDIAEoCVIHbmV0d29yaxIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglp'
    'c19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEiQKDWRlbm9taW5hdGlvbnMYBiADKAlSDWRlbm9taW'
    '5hdGlvbnM=');

@$core.Deprecated('Use sendFundsRequestDescriptor instead')
const SendFundsRequest$json = {
  '1': 'SendFundsRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'to_account_number', '3': 2, '4': 1, '5': 9, '10': 'toAccountNumber'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'destination_bank_code', '3': 7, '4': 1, '5': 9, '10': 'destinationBankCode'},
    {'1': 'beneficiary_name', '3': 8, '4': 1, '5': 9, '10': 'beneficiaryName'},
  ],
};

/// Descriptor for `SendFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendFundsRequestDescriptor = $convert.base64Decode(
    'ChBTZW5kRnVuZHNSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZnJvbUFjY291bn'
    'RJZBIqChF0b19hY2NvdW50X251bWJlchgCIAEoCVIPdG9BY2NvdW50TnVtYmVyEhYKBmFtb3Vu'
    'dBgDIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIlCg50cm'
    'Fuc2FjdGlvbl9pZBgFIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4Y'
    'BiABKAlSEXZlcmlmaWNhdGlvblRva2VuEjIKFWRlc3RpbmF0aW9uX2JhbmtfY29kZRgHIAEoCV'
    'ITZGVzdGluYXRpb25CYW5rQ29kZRIpChBiZW5lZmljaWFyeV9uYW1lGAggASgJUg9iZW5lZmlj'
    'aWFyeU5hbWU=');

@$core.Deprecated('Use sendFundsResponseDescriptor instead')
const SendFundsResponse$json = {
  '1': 'SendFundsResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SendFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendFundsResponseDescriptor = $convert.base64Decode(
    'ChFTZW5kRnVuZHNSZXNwb25zZRIrCgdwYXltZW50GAEgASgLMhEucGF5bWVudHMuUGF5bWVudF'
    'IHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIlCg5yZWNpcGllbnRf'
    'bmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use batchTransferItemDescriptor instead')
const BatchTransferItem$json = {
  '1': 'BatchTransferItem',
  '2': [
    {'1': 'to_account_number', '3': 1, '4': 1, '5': 9, '10': 'toAccountNumber'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `BatchTransferItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferItemDescriptor = $convert.base64Decode(
    'ChFCYXRjaFRyYW5zZmVySXRlbRIqChF0b19hY2NvdW50X251bWJlchgBIAEoCVIPdG9BY2NvdW'
    '50TnVtYmVyEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtk'
    'ZXNjcmlwdGlvbhIcCglyZWZlcmVuY2UYBCABKAlSCXJlZmVyZW5jZRIaCghjYXRlZ29yeRgFIA'
    'EoCVIIY2F0ZWdvcnk=');

@$core.Deprecated('Use batchTransferRequestDescriptor instead')
const BatchTransferRequest$json = {
  '1': 'BatchTransferRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'transfers', '3': 2, '4': 3, '5': 11, '6': '.payments.BatchTransferItem', '10': 'transfers'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BatchTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferRequestDescriptor = $convert.base64Decode(
    'ChRCYXRjaFRyYW5zZmVyUmVxdWVzdBImCg9mcm9tX2FjY291bnRfaWQYASABKAlSDWZyb21BY2'
    'NvdW50SWQSOQoJdHJhbnNmZXJzGAIgAygLMhsucGF5bWVudHMuQmF0Y2hUcmFuc2Zlckl0ZW1S'
    'CXRyYW5zZmVycxIlCg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZX'
    'JpZmljYXRpb25fdG9rZW4YBCABKAlSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use batchTransferResponseDescriptor instead')
const BatchTransferResponse$json = {
  '1': 'BatchTransferResponse',
  '2': [
    {'1': 'batch_id', '3': 1, '4': 1, '5': 9, '10': 'batchId'},
    {'1': 'total_transfers', '3': 2, '4': 1, '5': 5, '10': 'totalTransfers'},
    {'1': 'successful_transfers', '3': 3, '4': 1, '5': 5, '10': 'successfulTransfers'},
    {'1': 'failed_transfers', '3': 4, '4': 1, '5': 5, '10': 'failedTransfers'},
    {'1': 'results', '3': 5, '4': 3, '5': 11, '6': '.payments.BatchTransferResultItem', '10': 'results'},
    {'1': 'new_balance', '3': 6, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'total_amount', '3': 9, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'total_fee', '3': 10, '4': 1, '5': 1, '10': 'totalFee'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'completed_at', '3': 12, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `BatchTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferResponseDescriptor = $convert.base64Decode(
    'ChVCYXRjaFRyYW5zZmVyUmVzcG9uc2USGQoIYmF0Y2hfaWQYASABKAlSB2JhdGNoSWQSJwoPdG'
    '90YWxfdHJhbnNmZXJzGAIgASgFUg50b3RhbFRyYW5zZmVycxIxChRzdWNjZXNzZnVsX3RyYW5z'
    'ZmVycxgDIAEoBVITc3VjY2Vzc2Z1bFRyYW5zZmVycxIpChBmYWlsZWRfdHJhbnNmZXJzGAQgAS'
    'gFUg9mYWlsZWRUcmFuc2ZlcnMSOwoHcmVzdWx0cxgFIAMoCzIhLnBheW1lbnRzLkJhdGNoVHJh'
    'bnNmZXJSZXN1bHRJdGVtUgdyZXN1bHRzEh8KC25ld19iYWxhbmNlGAYgASgBUgpuZXdCYWxhbm'
    'NlEhgKB21lc3NhZ2UYByABKAlSB21lc3NhZ2USFgoGc3RhdHVzGAggASgJUgZzdGF0dXMSIQoM'
    'dG90YWxfYW1vdW50GAkgASgBUgt0b3RhbEFtb3VudBIbCgl0b3RhbF9mZWUYCiABKAFSCHRvdG'
    'FsRmVlEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIhCgxjb21wbGV0ZWRfYXQYDCAB'
    'KAlSC2NvbXBsZXRlZEF0');

@$core.Deprecated('Use batchTransferResultItemDescriptor instead')
const BatchTransferResultItem$json = {
  '1': 'BatchTransferResultItem',
  '2': [
    {'1': 'transfer_id', '3': 1, '4': 1, '5': 9, '10': 'transferId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'fee', '3': 4, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'recipient_name', '3': 5, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'recipient_account', '3': 6, '4': 1, '5': 9, '10': 'recipientAccount'},
    {'1': 'failure_reason', '3': 7, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `BatchTransferResultItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferResultItemDescriptor = $convert.base64Decode(
    'ChdCYXRjaFRyYW5zZmVyUmVzdWx0SXRlbRIfCgt0cmFuc2Zlcl9pZBgBIAEoCVIKdHJhbnNmZX'
    'JJZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIQCgNm'
    'ZWUYBCABKAFSA2ZlZRIlCg5yZWNpcGllbnRfbmFtZRgFIAEoCVINcmVjaXBpZW50TmFtZRIrCh'
    'FyZWNpcGllbnRfYWNjb3VudBgGIAEoCVIQcmVjaXBpZW50QWNjb3VudBIlCg5mYWlsdXJlX3Jl'
    'YXNvbhgHIAEoCVINZmFpbHVyZVJlYXNvbhIcCglyZWZlcmVuY2UYCCABKAlSCXJlZmVyZW5jZQ'
    '==');

@$core.Deprecated('Use withdrawRequestDescriptor instead')
const WithdrawRequest$json = {
  '1': 'WithdrawRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'location', '3': 4, '4': 1, '5': 9, '10': 'location'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `WithdrawRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawRequestDescriptor = $convert.base64Decode(
    'Cg9XaXRoZHJhd1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhYKBmFtb3'
    'VudBgCIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIaCghs'
    'b2NhdGlvbhgEIAEoCVIIbG9jYXRpb24SJQoOdHJhbnNhY3Rpb25faWQYBSABKAlSDXRyYW5zYW'
    'N0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAYgASgJUhF2ZXJpZmljYXRpb25Ub2tlbg==');

@$core.Deprecated('Use withdrawResponseDescriptor instead')
const WithdrawResponse$json = {
  '1': 'WithdrawResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'available_balance', '3': 3, '4': 1, '5': 1, '10': 'availableBalance'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawResponseDescriptor = $convert.base64Decode(
    'ChBXaXRoZHJhd1Jlc3BvbnNlEisKB3BheW1lbnQYASABKAsyES5wYXltZW50cy5QYXltZW50Ug'
    'dwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEisKEWF2YWlsYWJsZV9i'
    'YWxhbmNlGAMgASgBUhBhdmFpbGFibGVCYWxhbmNlEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2'
    'U=');

@$core.Deprecated('Use depositRequestDescriptor instead')
const DepositRequest$json = {
  '1': 'DepositRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'location', '3': 4, '4': 1, '5': 9, '10': 'location'},
    {'1': 'deposit_type', '3': 5, '4': 1, '5': 9, '10': 'depositType'},
  ],
};

/// Descriptor for `DepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositRequestDescriptor = $convert.base64Decode(
    'Cg5EZXBvc2l0UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFgoGYW1vdW'
    '50GAIgASgBUgZhbW91bnQSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhoKCGxv'
    'Y2F0aW9uGAQgASgJUghsb2NhdGlvbhIhCgxkZXBvc2l0X3R5cGUYBSABKAlSC2RlcG9zaXRUeX'
    'Bl');

@$core.Deprecated('Use depositResponseDescriptor instead')
const DepositResponse$json = {
  '1': 'DepositResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'available_balance', '3': 3, '4': 1, '5': 1, '10': 'availableBalance'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositResponseDescriptor = $convert.base64Decode(
    'Cg9EZXBvc2l0UmVzcG9uc2USKwoHcGF5bWVudBgBIAEoCzIRLnBheW1lbnRzLlBheW1lbnRSB3'
    'BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USKwoRYXZhaWxhYmxlX2Jh'
    'bGFuY2UYAyABKAFSEGF2YWlsYWJsZUJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ'
    '==');

@$core.Deprecated('Use payWithTagRequestDescriptor instead')
const PayWithTagRequest$json = {
  '1': 'PayWithTagRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'recipient_tag', '3': 2, '4': 1, '5': 9, '10': 'recipientTag'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `PayWithTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWithTagRequestDescriptor = $convert.base64Decode(
    'ChFQYXlXaXRoVGFnUmVxdWVzdBImCg9mcm9tX2FjY291bnRfaWQYASABKAlSDWZyb21BY2NvdW'
    '50SWQSIwoNcmVjaXBpZW50X3RhZxgCIAEoCVIMcmVjaXBpZW50VGFnEhYKBmFtb3VudBgDIAEo'
    'AVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIlCg50cmFuc2FjdG'
    'lvbl9pZBgFIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBiABKAlS'
    'EXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use payWithTagResponseDescriptor instead')
const PayWithTagResponse$json = {
  '1': 'PayWithTagResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'recipient_account', '3': 4, '4': 1, '5': 9, '10': 'recipientAccount'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayWithTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWithTagResponseDescriptor = $convert.base64Decode(
    'ChJQYXlXaXRoVGFnUmVzcG9uc2USKwoHcGF5bWVudBgBIAEoCzIRLnBheW1lbnRzLlBheW1lbn'
    'RSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USJQoOcmVjaXBpZW50'
    'X25hbWUYAyABKAlSDXJlY2lwaWVudE5hbWUSKwoRcmVjaXBpZW50X2FjY291bnQYBCABKAlSEH'
    'JlY2lwaWVudEFjY291bnQSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use payElectricityBillRequestDescriptor instead')
const PayElectricityBillRequest$json = {
  '1': 'PayElectricityBillRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'provider_id', '3': 2, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'meter_number', '3': 3, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'meter_type', '3': 5, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `PayElectricityBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payElectricityBillRequestDescriptor = $convert.base64Decode(
    'ChlQYXlFbGVjdHJpY2l0eUJpbGxSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bn'
    'RJZBIfCgtwcm92aWRlcl9pZBgCIAEoCVIKcHJvdmlkZXJJZBIhCgxtZXRlcl9udW1iZXIYAyAB'
    'KAlSC21ldGVyTnVtYmVyEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50Eh0KCm1ldGVyX3R5cGUYBS'
    'ABKAlSCW1ldGVyVHlwZRIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBIt'
    'ChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use payElectricityBillResponseDescriptor instead')
const PayElectricityBillResponse$json = {
  '1': 'PayElectricityBillResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    {'1': 'units', '3': 4, '4': 1, '5': 9, '10': 'units'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayElectricityBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payElectricityBillResponseDescriptor = $convert.base64Decode(
    'ChpQYXlFbGVjdHJpY2l0eUJpbGxSZXNwb25zZRIrCgdwYXltZW50GAEgASgLMhEucGF5bWVudH'
    'MuUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIUCgV0'
    'b2tlbhgDIAEoCVIFdG9rZW4SFAoFdW5pdHMYBCABKAlSBXVuaXRzEhgKB21lc3NhZ2UYBSABKA'
    'lSB21lc3NhZ2U=');

@$core.Deprecated('Use buyAirtimeRequestDescriptor instead')
const BuyAirtimeRequest$json = {
  '1': 'BuyAirtimeRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'provider_id', '3': 2, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'airtime_type', '3': 5, '4': 1, '5': 9, '10': 'airtimeType'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeRequestDescriptor = $convert.base64Decode(
    'ChFCdXlBaXJ0aW1lUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSHwoLcH'
    'JvdmlkZXJfaWQYAiABKAlSCnByb3ZpZGVySWQSIQoMcGhvbmVfbnVtYmVyGAMgASgJUgtwaG9u'
    'ZU51bWJlchIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIhCgxhaXJ0aW1lX3R5cGUYBSABKAlSC2'
    'FpcnRpbWVUeXBlEiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0KEnZl'
    'cmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');

@$core.Deprecated('Use buyAirtimeResponseDescriptor instead')
const BuyAirtimeResponse$json = {
  '1': 'BuyAirtimeResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeResponseDescriptor = $convert.base64Decode(
    'ChJCdXlBaXJ0aW1lUmVzcG9uc2USKwoHcGF5bWVudBgBIAEoCzIRLnBheW1lbnRzLlBheW1lbn'
    'RSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USIQoMcGhvbmVfbnVt'
    'YmVyGAMgASgJUgtwaG9uZU51bWJlchIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use barcodePayRequestDescriptor instead')
const BarcodePayRequest$json = {
  '1': 'BarcodePayRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'barcode_data', '3': 2, '4': 1, '5': 9, '10': 'barcodeData'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BarcodePayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePayRequestDescriptor = $convert.base64Decode(
    'ChFCYXJjb2RlUGF5UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSIQoMYm'
    'FyY29kZV9kYXRhGAIgASgJUgtiYXJjb2RlRGF0YRIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIl'
    'Cg50cmFuc2FjdGlvbl9pZBgEIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG'
    '9rZW4YBSABKAlSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use barcodePayResponseDescriptor instead')
const BarcodePayResponse$json = {
  '1': 'BarcodePayResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BarcodePayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePayResponseDescriptor = $convert.base64Decode(
    'ChJCYXJjb2RlUGF5UmVzcG9uc2USKwoHcGF5bWVudBgBIAEoCzIRLnBheW1lbnRzLlBheW1lbn'
    'RSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USIwoNbWVyY2hhbnRf'
    'bmFtZRgDIAEoCVIMbWVyY2hhbnROYW1lEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use scanToPayRequestDescriptor instead')
const ScanToPayRequest$json = {
  '1': 'ScanToPayRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'image_data', '3': 2, '4': 1, '5': 12, '10': 'imageData'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `ScanToPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanToPayRequestDescriptor = $convert.base64Decode(
    'ChBTY2FuVG9QYXlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIdCgppbW'
    'FnZV9kYXRhGAIgASgMUglpbWFnZURhdGESFgoGYW1vdW50GAMgASgBUgZhbW91bnQSJQoOdHJh'
    'bnNhY3Rpb25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGA'
    'UgASgJUhF2ZXJpZmljYXRpb25Ub2tlbg==');

@$core.Deprecated('Use scanToPayResponseDescriptor instead')
const ScanToPayResponse$json = {
  '1': 'ScanToPayResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    {'1': 'extracted_amount', '3': 4, '4': 1, '5': 1, '10': 'extractedAmount'},
    {'1': 'bill_details', '3': 5, '4': 1, '5': 9, '10': 'billDetails'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ScanToPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanToPayResponseDescriptor = $convert.base64Decode(
    'ChFTY2FuVG9QYXlSZXNwb25zZRIrCgdwYXltZW50GAEgASgLMhEucGF5bWVudHMuUGF5bWVudF'
    'IHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIjCg1tZXJjaGFudF9u'
    'YW1lGAMgASgJUgxtZXJjaGFudE5hbWUSKQoQZXh0cmFjdGVkX2Ftb3VudBgEIAEoAVIPZXh0cm'
    'FjdGVkQW1vdW50EiEKDGJpbGxfZGV0YWlscxgFIAEoCVILYmlsbERldGFpbHMSGAoHbWVzc2Fn'
    'ZRgGIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getPaymentHistoryRequestDescriptor instead')
const GetPaymentHistoryRequest$json = {
  '1': 'GetPaymentHistoryRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'payment_type', '3': 2, '4': 1, '5': 9, '10': 'paymentType'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'start_date', '3': 4, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 5, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 6, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 7, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetPaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQYXltZW50SGlzdG9yeVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudE'
    'lkEiEKDHBheW1lbnRfdHlwZRgCIAEoCVILcGF5bWVudFR5cGUSFgoGc3RhdHVzGAMgASgJUgZz'
    'dGF0dXMSHQoKc3RhcnRfZGF0ZRgEIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAUgASgJUg'
    'dlbmREYXRlEhQKBWxpbWl0GAYgASgFUgVsaW1pdBIWCgZvZmZzZXQYByABKAVSBm9mZnNldA==');

@$core.Deprecated('Use getPaymentHistoryResponseDescriptor instead')
const GetPaymentHistoryResponse$json = {
  '1': 'GetPaymentHistoryResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.payments.Payment', '10': 'payments'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQYXltZW50SGlzdG9yeVJlc3BvbnNlEi0KCHBheW1lbnRzGAEgAygLMhEucGF5bWVudH'
    'MuUGF5bWVudFIIcGF5bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use getBillProvidersRequestDescriptor instead')
const GetBillProvidersRequest$json = {
  '1': 'GetBillProvidersRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetBillProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillProvidersRequestDescriptor = $convert.base64Decode(
    'ChdHZXRCaWxsUHJvdmlkZXJzUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEh8KC2FjdGl2ZV'
    '9vbmx5GAIgASgIUgphY3RpdmVPbmx5');

@$core.Deprecated('Use getBillProvidersResponseDescriptor instead')
const GetBillProvidersResponse$json = {
  '1': 'GetBillProvidersResponse',
  '2': [
    {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.payments.BillProvider', '10': 'providers'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetBillProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillProvidersResponseDescriptor = $convert.base64Decode(
    'ChhHZXRCaWxsUHJvdmlkZXJzUmVzcG9uc2USNAoJcHJvdmlkZXJzGAEgAygLMhYucGF5bWVudH'
    'MuQmlsbFByb3ZpZGVyUglwcm92aWRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use getAirtimeProvidersRequestDescriptor instead')
const GetAirtimeProvidersRequest$json = {
  '1': 'GetAirtimeProvidersRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetAirtimeProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersRequestDescriptor = $convert.base64Decode(
    'ChpHZXRBaXJ0aW1lUHJvdmlkZXJzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aX'
    'ZlT25seQ==');

@$core.Deprecated('Use getAirtimeProvidersResponseDescriptor instead')
const GetAirtimeProvidersResponse$json = {
  '1': 'GetAirtimeProvidersResponse',
  '2': [
    {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.payments.AirtimeProvider', '10': 'providers'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAirtimeProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersResponseDescriptor = $convert.base64Decode(
    'ChtHZXRBaXJ0aW1lUHJvdmlkZXJzUmVzcG9uc2USNwoJcHJvdmlkZXJzGAEgAygLMhkucGF5bW'
    'VudHMuQWlydGltZVByb3ZpZGVyUglwcm92aWRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use resolveTagRequestDescriptor instead')
const ResolveTagRequest$json = {
  '1': 'ResolveTagRequest',
  '2': [
    {'1': 'tag', '3': 1, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `ResolveTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveTagRequestDescriptor = $convert.base64Decode(
    'ChFSZXNvbHZlVGFnUmVxdWVzdBIQCgN0YWcYASABKAlSA3RhZw==');

@$core.Deprecated('Use resolveTagResponseDescriptor instead')
const ResolveTagResponse$json = {
  '1': 'ResolveTagResponse',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 2, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'tag', '3': 3, '4': 1, '5': 9, '10': 'tag'},
    {'1': 'is_valid', '3': 4, '4': 1, '5': 8, '10': 'isValid'},
  ],
};

/// Descriptor for `ResolveTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveTagResponseDescriptor = $convert.base64Decode(
    'ChJSZXNvbHZlVGFnUmVzcG9uc2USJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW'
    '1iZXISIQoMYWNjb3VudF9uYW1lGAIgASgJUgthY2NvdW50TmFtZRIQCgN0YWcYAyABKAlSA3Rh'
    'ZxIZCghpc192YWxpZBgEIAEoCFIHaXNWYWxpZA==');

@$core.Deprecated('Use bankDetailsDescriptor instead')
const BankDetails$json = {
  '1': 'BankDetails',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 2, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'bank_name', '3': 3, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 4, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'routing_number', '3': 5, '4': 1, '5': 9, '10': 'routingNumber'},
    {'1': 'account_type', '3': 6, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'confidence_score', '3': 7, '4': 1, '5': 1, '10': 'confidenceScore'},
    {'1': 'mono_account_id', '3': 8, '4': 1, '5': 9, '10': 'monoAccountId'},
    {'1': 'balance', '3': 9, '4': 1, '5': 1, '10': 'balance'},
  ],
};

/// Descriptor for `BankDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankDetailsDescriptor = $convert.base64Decode(
    'CgtCYW5rRGV0YWlscxIlCg5hY2NvdW50X251bWJlchgBIAEoCVINYWNjb3VudE51bWJlchIhCg'
    'xhY2NvdW50X25hbWUYAiABKAlSC2FjY291bnROYW1lEhsKCWJhbmtfbmFtZRgDIAEoCVIIYmFu'
    'a05hbWUSGwoJYmFua19jb2RlGAQgASgJUghiYW5rQ29kZRIlCg5yb3V0aW5nX251bWJlchgFIA'
    'EoCVINcm91dGluZ051bWJlchIhCgxhY2NvdW50X3R5cGUYBiABKAlSC2FjY291bnRUeXBlEikK'
    'EGNvbmZpZGVuY2Vfc2NvcmUYByABKAFSD2NvbmZpZGVuY2VTY29yZRImCg9tb25vX2FjY291bn'
    'RfaWQYCCABKAlSDW1vbm9BY2NvdW50SWQSGAoHYmFsYW5jZRgJIAEoAVIHYmFsYW5jZQ==');

@$core.Deprecated('Use payWithBankDetailsRequestDescriptor instead')
const PayWithBankDetailsRequest$json = {
  '1': 'PayWithBankDetailsRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'bank_details', '3': 2, '4': 1, '5': 11, '6': '.payments.BankDetails', '10': 'bankDetails'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `PayWithBankDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWithBankDetailsRequestDescriptor = $convert.base64Decode(
    'ChlQYXlXaXRoQmFua0RldGFpbHNSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZn'
    'JvbUFjY291bnRJZBI4CgxiYW5rX2RldGFpbHMYAiABKAsyFS5wYXltZW50cy5CYW5rRGV0YWls'
    'c1ILYmFua0RldGFpbHMSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKA'
    'lSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIlCg50cmFuc2Fj'
    'dGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKA'
    'lSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use payWithBankDetailsResponseDescriptor instead')
const PayWithBankDetailsResponse$json = {
  '1': 'PayWithBankDetailsResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'transfer_reference', '3': 4, '4': 1, '5': 9, '10': 'transferReference'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayWithBankDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWithBankDetailsResponseDescriptor = $convert.base64Decode(
    'ChpQYXlXaXRoQmFua0RldGFpbHNSZXNwb25zZRIrCgdwYXltZW50GAEgASgLMhEucGF5bWVudH'
    'MuUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIlCg5y'
    'ZWNpcGllbnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRItChJ0cmFuc2Zlcl9yZWZlcmVuY2'
    'UYBCABKAlSEXRyYW5zZmVyUmVmZXJlbmNlEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use verifyBankAccountRequestDescriptor instead')
const VerifyBankAccountRequest$json = {
  '1': 'VerifyBankAccountRequest',
  '2': [
    {'1': 'bank_code', '3': 1, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'country', '3': 3, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `VerifyBankAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBankAccountRequestDescriptor = $convert.base64Decode(
    'ChhWZXJpZnlCYW5rQWNjb3VudFJlcXVlc3QSGwoJYmFua19jb2RlGAEgASgJUghiYW5rQ29kZR'
    'IlCg5hY2NvdW50X251bWJlchgCIAEoCVINYWNjb3VudE51bWJlchIYCgdjb3VudHJ5GAMgASgJ'
    'Ugdjb3VudHJ5');

@$core.Deprecated('Use verifyBankAccountResponseDescriptor instead')
const VerifyBankAccountResponse$json = {
  '1': 'VerifyBankAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 3, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'bank_name', '3': 4, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 5, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'verification_status', '3': 6, '4': 1, '5': 9, '10': 'verificationStatus'},
    {'1': 'error_code', '3': 7, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 8, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'user_message', '3': 9, '4': 1, '5': 9, '10': 'userMessage'},
  ],
};

/// Descriptor for `VerifyBankAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBankAccountResponseDescriptor = $convert.base64Decode(
    'ChlWZXJpZnlCYW5rQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSJQ'
    'oOYWNjb3VudF9udW1iZXIYAiABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAMg'
    'ASgJUgthY2NvdW50TmFtZRIbCgliYW5rX25hbWUYBCABKAlSCGJhbmtOYW1lEhsKCWJhbmtfY2'
    '9kZRgFIAEoCVIIYmFua0NvZGUSLwoTdmVyaWZpY2F0aW9uX3N0YXR1cxgGIAEoCVISdmVyaWZp'
    'Y2F0aW9uU3RhdHVzEh0KCmVycm9yX2NvZGUYByABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZX'
    'NzYWdlGAggASgJUgxlcnJvck1lc3NhZ2USIQoMdXNlcl9tZXNzYWdlGAkgASgJUgt1c2VyTWVz'
    'c2FnZQ==');

@$core.Deprecated('Use initiateDomesticTransferRequestDescriptor instead')
const InitiateDomesticTransferRequest$json = {
  '1': 'InitiateDomesticTransferRequest',
  '2': [
    {'1': 'source_account_id', '3': 1, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'destination_account', '3': 4, '4': 1, '5': 9, '10': 'destinationAccount'},
    {'1': 'destination_bank_code', '3': 5, '4': 1, '5': 9, '10': 'destinationBankCode'},
    {'1': 'destination_name', '3': 6, '4': 1, '5': 9, '10': 'destinationName'},
    {'1': 'narration', '3': 7, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'verification_token', '3': 10, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'transaction_id', '3': 11, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `InitiateDomesticTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateDomesticTransferRequestDescriptor = $convert.base64Decode(
    'Ch9Jbml0aWF0ZURvbWVzdGljVHJhbnNmZXJSZXF1ZXN0EioKEXNvdXJjZV9hY2NvdW50X2lkGA'
    'EgASgJUg9zb3VyY2VBY2NvdW50SWQSFgoGYW1vdW50GAIgASgDUgZhbW91bnQSGgoIY3VycmVu'
    'Y3kYAyABKAlSCGN1cnJlbmN5Ei8KE2Rlc3RpbmF0aW9uX2FjY291bnQYBCABKAlSEmRlc3Rpbm'
    'F0aW9uQWNjb3VudBIyChVkZXN0aW5hdGlvbl9iYW5rX2NvZGUYBSABKAlSE2Rlc3RpbmF0aW9u'
    'QmFua0NvZGUSKQoQZGVzdGluYXRpb25fbmFtZRgGIAEoCVIPZGVzdGluYXRpb25OYW1lEhwKCW'
    '5hcnJhdGlvbhgHIAEoCVIJbmFycmF0aW9uEhwKCXJlZmVyZW5jZRgIIAEoCVIJcmVmZXJlbmNl'
    'EicKD2lkZW1wb3RlbmN5X2tleRgJIAEoCVIOaWRlbXBvdGVuY3lLZXkSLQoSdmVyaWZpY2F0aW'
    '9uX3Rva2VuGAogASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIlCg50cmFuc2FjdGlvbl9pZBgLIAEo'
    'CVINdHJhbnNhY3Rpb25JZA==');

@$core.Deprecated('Use initiateInternalTransferRequestDescriptor instead')
const InitiateInternalTransferRequest$json = {
  '1': 'InitiateInternalTransferRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'to_account_id', '3': 2, '4': 1, '5': 9, '10': 'toAccountId'},
    {'1': 'to_username', '3': 3, '4': 1, '5': 9, '10': 'toUsername'},
    {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'narration', '3': 6, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'verification_token', '3': 9, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'recipient_info', '3': 11, '4': 1, '5': 11, '6': '.payments.RecipientInfo', '10': 'recipientInfo'},
  ],
};

/// Descriptor for `InitiateInternalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternalTransferRequestDescriptor = $convert.base64Decode(
    'Ch9Jbml0aWF0ZUludGVybmFsVHJhbnNmZXJSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIA'
    'EoCVINZnJvbUFjY291bnRJZBIiCg10b19hY2NvdW50X2lkGAIgASgJUgt0b0FjY291bnRJZBIf'
    'Cgt0b191c2VybmFtZRgDIAEoCVIKdG9Vc2VybmFtZRIWCgZhbW91bnQYBCABKANSBmFtb3VudB'
    'IaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSHAoJbmFycmF0aW9uGAYgASgJUgluYXJyYXRp'
    'b24SHAoJcmVmZXJlbmNlGAcgASgJUglyZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAggAS'
    'gJUg5pZGVtcG90ZW5jeUtleRItChJ2ZXJpZmljYXRpb25fdG9rZW4YCSABKAlSEXZlcmlmaWNh'
    'dGlvblRva2VuEiUKDnRyYW5zYWN0aW9uX2lkGAogASgJUg10cmFuc2FjdGlvbklkEj4KDnJlY2'
    'lwaWVudF9pbmZvGAsgASgLMhcucGF5bWVudHMuUmVjaXBpZW50SW5mb1INcmVjaXBpZW50SW5m'
    'bw==');

@$core.Deprecated('Use recipientInfoDescriptor instead')
const RecipientInfo$json = {
  '1': 'RecipientInfo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'recipient_type', '3': 2, '4': 1, '5': 9, '10': 'recipientType'},
    {'1': 'recipient_source', '3': 3, '4': 1, '5': 9, '10': 'recipientSource'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 8, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'phone_number', '3': 9, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `RecipientInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientInfoDescriptor = $convert.base64Decode(
    'Cg1SZWNpcGllbnRJbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSJQoOcmVjaXBpZW50X3R5cGUYAi'
    'ABKAlSDXJlY2lwaWVudFR5cGUSKQoQcmVjaXBpZW50X3NvdXJjZRgDIAEoCVIPcmVjaXBpZW50'
    'U291cmNlEhoKCHVzZXJuYW1lGAQgASgJUgh1c2VybmFtZRIXCgd1c2VyX2lkGAUgASgJUgZ1c2'
    'VySWQSJQoOYWNjb3VudF9udW1iZXIYBiABKAlSDWFjY291bnROdW1iZXISGwoJYmFua19jb2Rl'
    'GAcgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYCCABKAlSCGJhbmtOYW1lEiEKDHBob25lX2'
    '51bWJlchgJIAEoCVILcGhvbmVOdW1iZXI=');

@$core.Deprecated('Use initiateInternationalTransferRequestDescriptor instead')
const InitiateInternationalTransferRequest$json = {
  '1': 'InitiateInternationalTransferRequest',
  '2': [
    {'1': 'source_account_id', '3': 1, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'source_currency', '3': 3, '4': 1, '5': 9, '10': 'sourceCurrency'},
    {'1': 'destination_currency', '3': 4, '4': 1, '5': 9, '10': 'destinationCurrency'},
    {'1': 'destination_country', '3': 5, '4': 1, '5': 9, '10': 'destinationCountry'},
    {'1': 'recipient_type', '3': 6, '4': 1, '5': 9, '10': 'recipientType'},
    {'1': 'recipient_details', '3': 7, '4': 3, '5': 11, '6': '.payments.InitiateInternationalTransferRequest.RecipientDetailsEntry', '10': 'recipientDetails'},
    {'1': 'narration', '3': 8, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'verification_token', '3': 11, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'transaction_id', '3': 12, '4': 1, '5': 9, '10': 'transactionId'},
  ],
  '3': [InitiateInternationalTransferRequest_RecipientDetailsEntry$json],
};

@$core.Deprecated('Use initiateInternationalTransferRequestDescriptor instead')
const InitiateInternationalTransferRequest_RecipientDetailsEntry$json = {
  '1': 'RecipientDetailsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InitiateInternationalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferRequestDescriptor = $convert.base64Decode(
    'CiRJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlcXVlc3QSKgoRc291cmNlX2FjY291bn'
    'RfaWQYASABKAlSD3NvdXJjZUFjY291bnRJZBIWCgZhbW91bnQYAiABKANSBmFtb3VudBInCg9z'
    'b3VyY2VfY3VycmVuY3kYAyABKAlSDnNvdXJjZUN1cnJlbmN5EjEKFGRlc3RpbmF0aW9uX2N1cn'
    'JlbmN5GAQgASgJUhNkZXN0aW5hdGlvbkN1cnJlbmN5Ei8KE2Rlc3RpbmF0aW9uX2NvdW50cnkY'
    'BSABKAlSEmRlc3RpbmF0aW9uQ291bnRyeRIlCg5yZWNpcGllbnRfdHlwZRgGIAEoCVINcmVjaX'
    'BpZW50VHlwZRJxChFyZWNpcGllbnRfZGV0YWlscxgHIAMoCzJELnBheW1lbnRzLkluaXRpYXRl'
    'SW50ZXJuYXRpb25hbFRyYW5zZmVyUmVxdWVzdC5SZWNpcGllbnREZXRhaWxzRW50cnlSEHJlY2'
    'lwaWVudERldGFpbHMSHAoJbmFycmF0aW9uGAggASgJUgluYXJyYXRpb24SHAoJcmVmZXJlbmNl'
    'GAkgASgJUglyZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAogASgJUg5pZGVtcG90ZW5jeU'
    'tleRItChJ2ZXJpZmljYXRpb25fdG9rZW4YCyABKAlSEXZlcmlmaWNhdGlvblRva2VuEiUKDnRy'
    'YW5zYWN0aW9uX2lkGAwgASgJUg10cmFuc2FjdGlvbklkGkMKFVJlY2lwaWVudERldGFpbHNFbn'
    'RyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use initiateUsernameTransferRequestDescriptor instead')
const InitiateUsernameTransferRequest$json = {
  '1': 'InitiateUsernameTransferRequest',
  '2': [
    {'1': 'to_username', '3': 1, '4': 1, '5': 9, '10': 'toUsername'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'narration', '3': 4, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `InitiateUsernameTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateUsernameTransferRequestDescriptor = $convert.base64Decode(
    'Ch9Jbml0aWF0ZVVzZXJuYW1lVHJhbnNmZXJSZXF1ZXN0Eh8KC3RvX3VzZXJuYW1lGAEgASgJUg'
    'p0b1VzZXJuYW1lEhYKBmFtb3VudBgCIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghj'
    'dXJyZW5jeRIcCgluYXJyYXRpb24YBCABKAlSCW5hcnJhdGlvbhInCg9pZGVtcG90ZW5jeV9rZX'
    'kYBSABKAlSDmlkZW1wb3RlbmN5S2V5Ei0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVy'
    'aWZpY2F0aW9uVG9rZW4SJQoOdHJhbnNhY3Rpb25faWQYByABKAlSDXRyYW5zYWN0aW9uSWQ=');

@$core.Deprecated('Use initiatePhoneTransferRequestDescriptor instead')
const InitiatePhoneTransferRequest$json = {
  '1': 'InitiatePhoneTransferRequest',
  '2': [
    {'1': 'to_phone', '3': 1, '4': 1, '5': 9, '10': 'toPhone'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'narration', '3': 4, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `InitiatePhoneTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiatePhoneTransferRequestDescriptor = $convert.base64Decode(
    'ChxJbml0aWF0ZVBob25lVHJhbnNmZXJSZXF1ZXN0EhkKCHRvX3Bob25lGAEgASgJUgd0b1Bob2'
    '5lEhYKBmFtb3VudBgCIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIc'
    'CgluYXJyYXRpb24YBCABKAlSCW5hcnJhdGlvbhInCg9pZGVtcG90ZW5jeV9rZXkYBSABKAlSDm'
    'lkZW1wb3RlbmN5S2V5Ei0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9u'
    'VG9rZW4SJQoOdHJhbnNhY3Rpb25faWQYByABKAlSDXRyYW5zYWN0aW9uSWQ=');

@$core.Deprecated('Use initiateTransferResponseDescriptor instead')
const InitiateTransferResponse$json = {
  '1': 'InitiateTransferResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transfer', '3': 4, '4': 1, '5': 11, '6': '.payments.TransferDetail', '10': 'transfer'},
  ],
};

/// Descriptor for `InitiateTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferResponseDescriptor = $convert.base64Decode(
    'ChhJbml0aWF0ZVRyYW5zZmVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCg'
    'plcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJy'
    'b3JNZXNzYWdlEjQKCHRyYW5zZmVyGAQgASgLMhgucGF5bWVudHMuVHJhbnNmZXJEZXRhaWxSCH'
    'RyYW5zZmVy');

@$core.Deprecated('Use transferDetailDescriptor instead')
const TransferDetail$json = {
  '1': 'TransferDetail',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'fee', '3': 7, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'destination_account', '3': 9, '4': 1, '5': 9, '10': 'destinationAccount'},
    {'1': 'destination_bank_code', '3': 10, '4': 1, '5': 9, '10': 'destinationBankCode'},
    {'1': 'destination_bank_name', '3': 11, '4': 1, '5': 9, '10': 'destinationBankName'},
    {'1': 'destination_name', '3': 12, '4': 1, '5': 9, '10': 'destinationName'},
    {'1': 'destination_country', '3': 13, '4': 1, '5': 9, '10': 'destinationCountry'},
    {'1': 'reference', '3': 14, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'provider_ref', '3': 15, '4': 1, '5': 9, '10': 'providerRef'},
    {'1': 'provider', '3': 16, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'narration', '3': 17, '4': 1, '5': 9, '10': 'narration'},
    {'1': 'failure_reason', '3': 18, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'completed_at', '3': 20, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `TransferDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDetailDescriptor = $convert.base64Decode(
    'Cg5UcmFuc2ZlckRldGFpbBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlck'
    'lkEhIKBHR5cGUYAyABKAlSBHR5cGUSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSFgoGYW1vdW50'
    'GAUgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EhAKA2ZlZRgHIAEoA1'
    'IDZmVlEioKEXNvdXJjZV9hY2NvdW50X2lkGAggASgJUg9zb3VyY2VBY2NvdW50SWQSLwoTZGVz'
    'dGluYXRpb25fYWNjb3VudBgJIAEoCVISZGVzdGluYXRpb25BY2NvdW50EjIKFWRlc3RpbmF0aW'
    '9uX2JhbmtfY29kZRgKIAEoCVITZGVzdGluYXRpb25CYW5rQ29kZRIyChVkZXN0aW5hdGlvbl9i'
    'YW5rX25hbWUYCyABKAlSE2Rlc3RpbmF0aW9uQmFua05hbWUSKQoQZGVzdGluYXRpb25fbmFtZR'
    'gMIAEoCVIPZGVzdGluYXRpb25OYW1lEi8KE2Rlc3RpbmF0aW9uX2NvdW50cnkYDSABKAlSEmRl'
    'c3RpbmF0aW9uQ291bnRyeRIcCglyZWZlcmVuY2UYDiABKAlSCXJlZmVyZW5jZRIhCgxwcm92aW'
    'Rlcl9yZWYYDyABKAlSC3Byb3ZpZGVyUmVmEhoKCHByb3ZpZGVyGBAgASgJUghwcm92aWRlchIc'
    'CgluYXJyYXRpb24YESABKAlSCW5hcnJhdGlvbhIlCg5mYWlsdXJlX3JlYXNvbhgSIAEoCVINZm'
    'FpbHVyZVJlYXNvbhIdCgpjcmVhdGVkX2F0GBMgASgJUgljcmVhdGVkQXQSIQoMY29tcGxldGVk'
    'X2F0GBQgASgJUgtjb21wbGV0ZWRBdA==');

@$core.Deprecated('Use getTransferStatusRequestDescriptor instead')
const GetTransferStatusRequest$json = {
  '1': 'GetTransferStatusRequest',
  '2': [
    {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GetTransferStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferStatusRequestDescriptor = $convert.base64Decode(
    'ChhHZXRUcmFuc2ZlclN0YXR1c1JlcXVlc3QSHAoJcmVmZXJlbmNlGAEgASgJUglyZWZlcmVuY2'
    'U=');

@$core.Deprecated('Use getTransferStatusResponseDescriptor instead')
const GetTransferStatusResponse$json = {
  '1': 'GetTransferStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transfer', '3': 4, '4': 1, '5': 11, '6': '.payments.TransferDetail', '10': 'transfer'},
  ],
};

/// Descriptor for `GetTransferStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferStatusResponseDescriptor = $convert.base64Decode(
    'ChlHZXRUcmFuc2ZlclN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQ'
    'oKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVy'
    'cm9yTWVzc2FnZRI0Cgh0cmFuc2ZlchgEIAEoCzIYLnBheW1lbnRzLlRyYW5zZmVyRGV0YWlsUg'
    'h0cmFuc2Zlcg==');

@$core.Deprecated('Use getUserTransfersRequestDescriptor instead')
const GetUserTransfersRequest$json = {
  '1': 'GetUserTransfersRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'transfer_type', '3': 3, '4': 1, '5': 9, '10': 'transferType'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetUserTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserTransfersRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyVHJhbnNmZXJzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2'
    'V0GAIgASgFUgZvZmZzZXQSIwoNdHJhbnNmZXJfdHlwZRgDIAEoCVIMdHJhbnNmZXJUeXBlEhYK'
    'BnN0YXR1cxgEIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use getUserTransfersResponseDescriptor instead')
const GetUserTransfersResponse$json = {
  '1': 'GetUserTransfersResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transfers', '3': 4, '4': 3, '5': 11, '6': '.payments.TransferDetail', '10': 'transfers'},
    {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetUserTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserTransfersResponseDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VyVHJhbnNmZXJzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCg'
    'plcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJy'
    'b3JNZXNzYWdlEjYKCXRyYW5zZmVycxgEIAMoCzIYLnBheW1lbnRzLlRyYW5zZmVyRGV0YWlsUg'
    'l0cmFuc2ZlcnMSFAoFdG90YWwYBSABKAVSBXRvdGFs');

@$core.Deprecated('Use getTransferFeeRequestDescriptor instead')
const GetTransferFeeRequest$json = {
  '1': 'GetTransferFeeRequest',
  '2': [
    {'1': 'transfer_type', '3': 1, '4': 1, '5': 9, '10': 'transferType'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'destination_country', '3': 4, '4': 1, '5': 9, '10': 'destinationCountry'},
  ],
};

/// Descriptor for `GetTransferFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferFeeRequestDescriptor = $convert.base64Decode(
    'ChVHZXRUcmFuc2ZlckZlZVJlcXVlc3QSIwoNdHJhbnNmZXJfdHlwZRgBIAEoCVIMdHJhbnNmZX'
    'JUeXBlEhYKBmFtb3VudBgCIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5j'
    'eRIvChNkZXN0aW5hdGlvbl9jb3VudHJ5GAQgASgJUhJkZXN0aW5hdGlvbkNvdW50cnk=');

@$core.Deprecated('Use getTransferFeeResponseDescriptor instead')
const GetTransferFeeResponse$json = {
  '1': 'GetTransferFeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'fee', '3': 4, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetTransferFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferFeeResponseDescriptor = $convert.base64Decode(
    'ChZHZXRUcmFuc2ZlckZlZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZX'
    'Jyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9y'
    'TWVzc2FnZRIQCgNmZWUYBCABKANSA2ZlZRIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3k=');

@$core.Deprecated('Use getDailyUsageRequestDescriptor instead')
const GetDailyUsageRequest$json = {
  '1': 'GetDailyUsageRequest',
};

/// Descriptor for `GetDailyUsageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDailyUsageRequestDescriptor = $convert.base64Decode(
    'ChRHZXREYWlseVVzYWdlUmVxdWVzdA==');

@$core.Deprecated('Use getDailyUsageResponseDescriptor instead')
const GetDailyUsageResponse$json = {
  '1': 'GetDailyUsageResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'total_transferred', '3': 4, '4': 1, '5': 3, '10': 'totalTransferred'},
    {'1': 'transfer_count', '3': 5, '4': 1, '5': 5, '10': 'transferCount'},
    {'1': 'daily_limit', '3': 6, '4': 1, '5': 3, '10': 'dailyLimit'},
    {'1': 'remaining_limit', '3': 7, '4': 1, '5': 3, '10': 'remainingLimit'},
  ],
};

/// Descriptor for `GetDailyUsageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDailyUsageResponseDescriptor = $convert.base64Decode(
    'ChVHZXREYWlseVVzYWdlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcn'
    'Jvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JN'
    'ZXNzYWdlEisKEXRvdGFsX3RyYW5zZmVycmVkGAQgASgDUhB0b3RhbFRyYW5zZmVycmVkEiUKDn'
    'RyYW5zZmVyX2NvdW50GAUgASgFUg10cmFuc2ZlckNvdW50Eh8KC2RhaWx5X2xpbWl0GAYgASgD'
    'UgpkYWlseUxpbWl0EicKD3JlbWFpbmluZ19saW1pdBgHIAEoA1IOcmVtYWluaW5nTGltaXQ=');

@$core.Deprecated('Use getExchangeRateRequestDescriptor instead')
const GetExchangeRateRequest$json = {
  '1': 'GetExchangeRateRequest',
  '2': [
    {'1': 'source_currency', '3': 1, '4': 1, '5': 9, '10': 'sourceCurrency'},
    {'1': 'destination_currency', '3': 2, '4': 1, '5': 9, '10': 'destinationCurrency'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `GetExchangeRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateRequestDescriptor = $convert.base64Decode(
    'ChZHZXRFeGNoYW5nZVJhdGVSZXF1ZXN0EicKD3NvdXJjZV9jdXJyZW5jeRgBIAEoCVIOc291cm'
    'NlQ3VycmVuY3kSMQoUZGVzdGluYXRpb25fY3VycmVuY3kYAiABKAlSE2Rlc3RpbmF0aW9uQ3Vy'
    'cmVuY3kSFgoGYW1vdW50GAMgASgDUgZhbW91bnQ=');

@$core.Deprecated('Use getExchangeRateResponseDescriptor instead')
const GetExchangeRateResponse$json = {
  '1': 'GetExchangeRateResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'source_currency', '3': 4, '4': 1, '5': 9, '10': 'sourceCurrency'},
    {'1': 'destination_currency', '3': 5, '4': 1, '5': 9, '10': 'destinationCurrency'},
    {'1': 'rate', '3': 6, '4': 1, '5': 1, '10': 'rate'},
    {'1': 'fee', '3': 7, '4': 1, '5': 3, '10': 'fee'},
    {'1': 'destination_amount', '3': 8, '4': 1, '5': 3, '10': 'destinationAmount'},
  ],
};

/// Descriptor for `GetExchangeRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateResponseDescriptor = $convert.base64Decode(
    'ChdHZXRFeGNoYW5nZVJhdGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCm'
    'Vycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJv'
    'ck1lc3NhZ2USJwoPc291cmNlX2N1cnJlbmN5GAQgASgJUg5zb3VyY2VDdXJyZW5jeRIxChRkZX'
    'N0aW5hdGlvbl9jdXJyZW5jeRgFIAEoCVITZGVzdGluYXRpb25DdXJyZW5jeRISCgRyYXRlGAYg'
    'ASgBUgRyYXRlEhAKA2ZlZRgHIAEoA1IDZmVlEi0KEmRlc3RpbmF0aW9uX2Ftb3VudBgIIAEoA1'
    'IRZGVzdGluYXRpb25BbW91bnQ=');

@$core.Deprecated('Use handleTransferWebhookRequestDescriptor instead')
const HandleTransferWebhookRequest$json = {
  '1': 'HandleTransferWebhookRequest',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'payload', '3': 2, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 3, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `HandleTransferWebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handleTransferWebhookRequestDescriptor = $convert.base64Decode(
    'ChxIYW5kbGVUcmFuc2ZlcldlYmhvb2tSZXF1ZXN0EhoKCHByb3ZpZGVyGAEgASgJUghwcm92aW'
    'RlchIYCgdwYXlsb2FkGAIgASgMUgdwYXlsb2FkEhwKCXNpZ25hdHVyZRgDIAEoCVIJc2lnbmF0'
    'dXJl');

@$core.Deprecated('Use handleTransferWebhookResponseDescriptor instead')
const HandleTransferWebhookResponse$json = {
  '1': 'HandleTransferWebhookResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HandleTransferWebhookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handleTransferWebhookResponseDescriptor = $convert.base64Decode(
    'Ch1IYW5kbGVUcmFuc2ZlcldlYmhvb2tSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use payPlatformFeeRequestDescriptor instead')
const PayPlatformFeeRequest$json = {
  '1': 'PayPlatformFeeRequest',
  '2': [
    {'1': 'user_account_id', '3': 1, '4': 1, '5': 9, '10': 'userAccountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'verification_token', '3': 9, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'wallet_code', '3': 11, '4': 1, '5': 9, '10': 'walletCode'},
  ],
};

/// Descriptor for `PayPlatformFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payPlatformFeeRequestDescriptor = $convert.base64Decode(
    'ChVQYXlQbGF0Zm9ybUZlZVJlcXVlc3QSJgoPdXNlcl9hY2NvdW50X2lkGAEgASgJUg11c2VyQW'
    'Njb3VudElkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIWCgZhbW91bnQYAyABKANSBmFtb3Vu'
    'dBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3'
    'J5EiAKC2Rlc2NyaXB0aW9uGAYgASgJUgtkZXNjcmlwdGlvbhIcCglyZWZlcmVuY2UYByABKAlS'
    'CXJlZmVyZW5jZRInCg9pZGVtcG90ZW5jeV9rZXkYCCABKAlSDmlkZW1wb3RlbmN5S2V5Ei0KEn'
    'ZlcmlmaWNhdGlvbl90b2tlbhgJIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJQoOdHJhbnNhY3Rp'
    'b25faWQYCiABKAlSDXRyYW5zYWN0aW9uSWQSHwoLd2FsbGV0X2NvZGUYCyABKAlSCndhbGxldE'
    'NvZGU=');

@$core.Deprecated('Use payPlatformFeeResponseDescriptor instead')
const PayPlatformFeeResponse$json = {
  '1': 'PayPlatformFeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'debit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'debitTransactionId'},
    {'1': 'platform_transaction_id', '3': 5, '4': 1, '5': 9, '10': 'platformTransactionId'},
    {'1': 'user_new_balance', '3': 6, '4': 1, '5': 3, '10': 'userNewBalance'},
    {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `PayPlatformFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payPlatformFeeResponseDescriptor = $convert.base64Decode(
    'ChZQYXlQbGF0Zm9ybUZlZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZX'
    'Jyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9y'
    'TWVzc2FnZRIwChRkZWJpdF90cmFuc2FjdGlvbl9pZBgEIAEoCVISZGViaXRUcmFuc2FjdGlvbk'
    'lkEjYKF3BsYXRmb3JtX3RyYW5zYWN0aW9uX2lkGAUgASgJUhVwbGF0Zm9ybVRyYW5zYWN0aW9u'
    'SWQSKAoQdXNlcl9uZXdfYmFsYW5jZRgGIAEoA1IOdXNlck5ld0JhbGFuY2USHAoJcmVmZXJlbm'
    'NlGAcgASgJUglyZWZlcmVuY2U=');

@$core.Deprecated('Use refundFromPlatformWalletRequestDescriptor instead')
const RefundFromPlatformWalletRequest$json = {
  '1': 'RefundFromPlatformWalletRequest',
  '2': [
    {'1': 'user_account_id', '3': 1, '4': 1, '5': 9, '10': 'userAccountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'wallet_code', '3': 9, '4': 1, '5': 9, '10': 'walletCode'},
  ],
};

/// Descriptor for `RefundFromPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refundFromPlatformWalletRequestDescriptor = $convert.base64Decode(
    'Ch9SZWZ1bmRGcm9tUGxhdGZvcm1XYWxsZXRSZXF1ZXN0EiYKD3VzZXJfYWNjb3VudF9pZBgBIA'
    'EoCVINdXNlckFjY291bnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSFgoGYW1vdW50GAMg'
    'ASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhoKCGNhdGVnb3J5GAUgAS'
    'gJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SHAoJcmVmZXJl'
    'bmNlGAcgASgJUglyZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAggASgJUg5pZGVtcG90ZW'
    '5jeUtleRIfCgt3YWxsZXRfY29kZRgJIAEoCVIKd2FsbGV0Q29kZQ==');

@$core.Deprecated('Use refundFromPlatformWalletResponseDescriptor instead')
const RefundFromPlatformWalletResponse$json = {
  '1': 'RefundFromPlatformWalletResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'credit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'creditTransactionId'},
    {'1': 'user_new_balance', '3': 5, '4': 1, '5': 3, '10': 'userNewBalance'},
    {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `RefundFromPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refundFromPlatformWalletResponseDescriptor = $convert.base64Decode(
    'CiBSZWZ1bmRGcm9tUGxhdGZvcm1XYWxsZXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
    'NjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMg'
    'ASgJUgxlcnJvck1lc3NhZ2USMgoVY3JlZGl0X3RyYW5zYWN0aW9uX2lkGAQgASgJUhNjcmVkaX'
    'RUcmFuc2FjdGlvbklkEigKEHVzZXJfbmV3X2JhbGFuY2UYBSABKANSDnVzZXJOZXdCYWxhbmNl'
    'EhwKCXJlZmVyZW5jZRgGIAEoCVIJcmVmZXJlbmNl');

@$core.Deprecated('Use generateQRTokenRequestDescriptor instead')
const GenerateQRTokenRequest$json = {
  '1': 'GenerateQRTokenRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'expiry_minutes', '3': 4, '4': 1, '5': 5, '10': 'expiryMinutes'},
  ],
};

/// Descriptor for `GenerateQRTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateQRTokenRequestDescriptor = $convert.base64Decode(
    'ChZHZW5lcmF0ZVFSVG9rZW5SZXF1ZXN0EhYKBmFtb3VudBgBIAEoA1IGYW1vdW50EhoKCGN1cn'
    'JlbmN5GAIgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24S'
    'JQoOZXhwaXJ5X21pbnV0ZXMYBCABKAVSDWV4cGlyeU1pbnV0ZXM=');

@$core.Deprecated('Use generateQRTokenResponseDescriptor instead')
const GenerateQRTokenResponse$json = {
  '1': 'GenerateQRTokenResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'qr_token', '3': 4, '4': 1, '5': 9, '10': 'qrToken'},
    {'1': 'qr_data', '3': 5, '4': 1, '5': 9, '10': 'qrData'},
    {'1': 'expires_at', '3': 6, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `GenerateQRTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateQRTokenResponseDescriptor = $convert.base64Decode(
    'ChdHZW5lcmF0ZVFSVG9rZW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCm'
    'Vycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJv'
    'ck1lc3NhZ2USGQoIcXJfdG9rZW4YBCABKAlSB3FyVG9rZW4SFwoHcXJfZGF0YRgFIAEoCVIGcX'
    'JEYXRhEh0KCmV4cGlyZXNfYXQYBiABKAlSCWV4cGlyZXNBdA==');

@$core.Deprecated('Use validateQRTokenRequestDescriptor instead')
const ValidateQRTokenRequest$json = {
  '1': 'ValidateQRTokenRequest',
  '2': [
    {'1': 'qr_token', '3': 1, '4': 1, '5': 9, '10': 'qrToken'},
  ],
};

/// Descriptor for `ValidateQRTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateQRTokenRequestDescriptor = $convert.base64Decode(
    'ChZWYWxpZGF0ZVFSVG9rZW5SZXF1ZXN0EhkKCHFyX3Rva2VuGAEgASgJUgdxclRva2Vu');

@$core.Deprecated('Use validateQRTokenResponseDescriptor instead')
const ValidateQRTokenResponse$json = {
  '1': 'ValidateQRTokenResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'recipient_user_id', '3': 4, '4': 1, '5': 9, '10': 'recipientUserId'},
    {'1': 'recipient_username', '3': 5, '4': 1, '5': 9, '10': 'recipientUsername'},
    {'1': 'recipient_name', '3': 6, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'recipient_account_id', '3': 7, '4': 1, '5': 9, '10': 'recipientAccountId'},
    {'1': 'amount', '3': 8, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_expired', '3': 10, '4': 1, '5': 8, '10': 'isExpired'},
  ],
};

/// Descriptor for `ValidateQRTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateQRTokenResponseDescriptor = $convert.base64Decode(
    'ChdWYWxpZGF0ZVFSVG9rZW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCm'
    'Vycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJv'
    'ck1lc3NhZ2USKgoRcmVjaXBpZW50X3VzZXJfaWQYBCABKAlSD3JlY2lwaWVudFVzZXJJZBItCh'
    'JyZWNpcGllbnRfdXNlcm5hbWUYBSABKAlSEXJlY2lwaWVudFVzZXJuYW1lEiUKDnJlY2lwaWVu'
    'dF9uYW1lGAYgASgJUg1yZWNpcGllbnROYW1lEjAKFHJlY2lwaWVudF9hY2NvdW50X2lkGAcgAS'
    'gJUhJyZWNpcGllbnRBY2NvdW50SWQSFgoGYW1vdW50GAggASgDUgZhbW91bnQSGgoIY3VycmVu'
    'Y3kYCSABKAlSCGN1cnJlbmN5Eh0KCmlzX2V4cGlyZWQYCiABKAhSCWlzRXhwaXJlZA==');

