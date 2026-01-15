///
//  Generated code. Do not modify.
//  source: payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use paymentDescriptor instead')
const Payment$json = const {
  '1': 'Payment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'payment_type', '3': 4, '4': 1, '5': 9, '10': 'paymentType'},
    const {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'recipient', '3': 9, '4': 1, '5': 9, '10': 'recipient'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 11, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Payment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentDescriptor = $convert.base64Decode('CgdQYXltZW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEiEKDHBheW1lbnRfdHlwZRgEIAEoCVILcGF5bWVudFR5cGUSHAoJcmVmZXJlbmNlGAUgASgJUglyZWZlcmVuY2USFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgIIAEoCVIGc3RhdHVzEhwKCXJlY2lwaWVudBgJIAEoCVIJcmVjaXBpZW50EiAKC2Rlc2NyaXB0aW9uGAogASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgLIAEoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgMIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYDSABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use billProviderDescriptor instead')
const BillProvider$json = const {
  '1': 'BillProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'min_amount', '3': 6, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 7, '4': 1, '5': 1, '10': 'maxAmount'},
  ],
};

/// Descriptor for `BillProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billProviderDescriptor = $convert.base64Decode('CgxCaWxsUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEdHlwZRgDIAEoCVIEdHlwZRIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEh0KCm1pbl9hbW91bnQYBiABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAcgASgBUgltYXhBbW91bnQ=');
@$core.Deprecated('Use airtimeProviderDescriptor instead')
const AirtimeProvider$json = const {
  '1': 'AirtimeProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'denominations', '3': 6, '4': 3, '5': 9, '10': 'denominations'},
  ],
};

/// Descriptor for `AirtimeProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeProviderDescriptor = $convert.base64Decode('Cg9BaXJ0aW1lUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGAoHbmV0d29yaxgDIAEoCVIHbmV0d29yaxIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEiQKDWRlbm9taW5hdGlvbnMYBiADKAlSDWRlbm9taW5hdGlvbnM=');
@$core.Deprecated('Use sendFundsRequestDescriptor instead')
const SendFundsRequest$json = const {
  '1': 'SendFundsRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'to_account_number', '3': 2, '4': 1, '5': 9, '10': 'toAccountNumber'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `SendFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendFundsRequestDescriptor = $convert.base64Decode('ChBTZW5kRnVuZHNSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZnJvbUFjY291bnRJZBIqChF0b19hY2NvdW50X251bWJlchgCIAEoCVIPdG9BY2NvdW50TnVtYmVyEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIlCg50cmFuc2FjdGlvbl9pZBgFIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBiABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use sendFundsResponseDescriptor instead')
const SendFundsResponse$json = const {
  '1': 'SendFundsResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SendFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendFundsResponseDescriptor = $convert.base64Decode('ChFTZW5kRnVuZHNSZXNwb25zZRIrCgdwYXltZW50GAEgASgLMhEucGF5bWVudHMuUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIlCg5yZWNpcGllbnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use batchTransferItemDescriptor instead')
const BatchTransferItem$json = const {
  '1': 'BatchTransferItem',
  '2': const [
    const {'1': 'to_account_number', '3': 1, '4': 1, '5': 9, '10': 'toAccountNumber'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `BatchTransferItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferItemDescriptor = $convert.base64Decode('ChFCYXRjaFRyYW5zZmVySXRlbRIqChF0b19hY2NvdW50X251bWJlchgBIAEoCVIPdG9BY2NvdW50TnVtYmVyEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbg==');
@$core.Deprecated('Use batchTransferRequestDescriptor instead')
const BatchTransferRequest$json = const {
  '1': 'BatchTransferRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'transfers', '3': 2, '4': 3, '5': 11, '6': '.payments.BatchTransferItem', '10': 'transfers'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BatchTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferRequestDescriptor = $convert.base64Decode('ChRCYXRjaFRyYW5zZmVyUmVxdWVzdBImCg9mcm9tX2FjY291bnRfaWQYASABKAlSDWZyb21BY2NvdW50SWQSOQoJdHJhbnNmZXJzGAIgAygLMhsucGF5bWVudHMuQmF0Y2hUcmFuc2Zlckl0ZW1SCXRyYW5zZmVycxIlCg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBCABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use batchTransferResponseDescriptor instead')
const BatchTransferResponse$json = const {
  '1': 'BatchTransferResponse',
  '2': const [
    const {'1': 'total_transfers', '3': 1, '4': 1, '5': 5, '10': 'totalTransfers'},
    const {'1': 'successful_transfers', '3': 2, '4': 1, '5': 5, '10': 'successfulTransfers'},
    const {'1': 'failed_transfers', '3': 3, '4': 1, '5': 5, '10': 'failedTransfers'},
    const {'1': 'payments', '3': 4, '4': 3, '5': 11, '6': '.payments.Payment', '10': 'payments'},
    const {'1': 'new_balance', '3': 5, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BatchTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferResponseDescriptor = $convert.base64Decode('ChVCYXRjaFRyYW5zZmVyUmVzcG9uc2USJwoPdG90YWxfdHJhbnNmZXJzGAEgASgFUg50b3RhbFRyYW5zZmVycxIxChRzdWNjZXNzZnVsX3RyYW5zZmVycxgCIAEoBVITc3VjY2Vzc2Z1bFRyYW5zZmVycxIpChBmYWlsZWRfdHJhbnNmZXJzGAMgASgFUg9mYWlsZWRUcmFuc2ZlcnMSLQoIcGF5bWVudHMYBCADKAsyES5wYXltZW50cy5QYXltZW50UghwYXltZW50cxIfCgtuZXdfYmFsYW5jZRgFIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAYgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use withdrawRequestDescriptor instead')
const WithdrawRequest$json = const {
  '1': 'WithdrawRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'location', '3': 4, '4': 1, '5': 9, '10': 'location'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `WithdrawRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawRequestDescriptor = $convert.base64Decode('Cg9XaXRoZHJhd1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIaCghsb2NhdGlvbhgEIAEoCVIIbG9jYXRpb24SJQoOdHJhbnNhY3Rpb25faWQYBSABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAYgASgJUhF2ZXJpZmljYXRpb25Ub2tlbg==');
@$core.Deprecated('Use withdrawResponseDescriptor instead')
const WithdrawResponse$json = const {
  '1': 'WithdrawResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'available_balance', '3': 3, '4': 1, '5': 1, '10': 'availableBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `WithdrawResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawResponseDescriptor = $convert.base64Decode('ChBXaXRoZHJhd1Jlc3BvbnNlEisKB3BheW1lbnQYASABKAsyES5wYXltZW50cy5QYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEisKEWF2YWlsYWJsZV9iYWxhbmNlGAMgASgBUhBhdmFpbGFibGVCYWxhbmNlEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use depositRequestDescriptor instead')
const DepositRequest$json = const {
  '1': 'DepositRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'location', '3': 4, '4': 1, '5': 9, '10': 'location'},
    const {'1': 'deposit_type', '3': 5, '4': 1, '5': 9, '10': 'depositType'},
  ],
};

/// Descriptor for `DepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositRequestDescriptor = $convert.base64Decode('Cg5EZXBvc2l0UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhoKCGxvY2F0aW9uGAQgASgJUghsb2NhdGlvbhIhCgxkZXBvc2l0X3R5cGUYBSABKAlSC2RlcG9zaXRUeXBl');
@$core.Deprecated('Use depositResponseDescriptor instead')
const DepositResponse$json = const {
  '1': 'DepositResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'available_balance', '3': 3, '4': 1, '5': 1, '10': 'availableBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List depositResponseDescriptor = $convert.base64Decode('Cg9EZXBvc2l0UmVzcG9uc2USKwoHcGF5bWVudBgBIAEoCzIRLnBheW1lbnRzLlBheW1lbnRSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USKwoRYXZhaWxhYmxlX2JhbGFuY2UYAyABKAFSEGF2YWlsYWJsZUJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use payWithTagRequestDescriptor instead')
const PayWithTagRequest$json = const {
  '1': 'PayWithTagRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'recipient_tag', '3': 2, '4': 1, '5': 9, '10': 'recipientTag'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `PayWithTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWithTagRequestDescriptor = $convert.base64Decode('ChFQYXlXaXRoVGFnUmVxdWVzdBImCg9mcm9tX2FjY291bnRfaWQYASABKAlSDWZyb21BY2NvdW50SWQSIwoNcmVjaXBpZW50X3RhZxgCIAEoCVIMcmVjaXBpZW50VGFnEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIlCg50cmFuc2FjdGlvbl9pZBgFIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBiABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use payWithTagResponseDescriptor instead')
const PayWithTagResponse$json = const {
  '1': 'PayWithTagResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'recipient_account', '3': 4, '4': 1, '5': 9, '10': 'recipientAccount'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayWithTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWithTagResponseDescriptor = $convert.base64Decode('ChJQYXlXaXRoVGFnUmVzcG9uc2USKwoHcGF5bWVudBgBIAEoCzIRLnBheW1lbnRzLlBheW1lbnRSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USJQoOcmVjaXBpZW50X25hbWUYAyABKAlSDXJlY2lwaWVudE5hbWUSKwoRcmVjaXBpZW50X2FjY291bnQYBCABKAlSEHJlY2lwaWVudEFjY291bnQSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use payElectricityBillRequestDescriptor instead')
const PayElectricityBillRequest$json = const {
  '1': 'PayElectricityBillRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'provider_id', '3': 2, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'meter_number', '3': 3, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'meter_type', '3': 5, '4': 1, '5': 9, '10': 'meterType'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `PayElectricityBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payElectricityBillRequestDescriptor = $convert.base64Decode('ChlQYXlFbGVjdHJpY2l0eUJpbGxSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIfCgtwcm92aWRlcl9pZBgCIAEoCVIKcHJvdmlkZXJJZBIhCgxtZXRlcl9udW1iZXIYAyABKAlSC21ldGVyTnVtYmVyEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50Eh0KCm1ldGVyX3R5cGUYBSABKAlSCW1ldGVyVHlwZRIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use payElectricityBillResponseDescriptor instead')
const PayElectricityBillResponse$json = const {
  '1': 'PayElectricityBillResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'units', '3': 4, '4': 1, '5': 9, '10': 'units'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayElectricityBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payElectricityBillResponseDescriptor = $convert.base64Decode('ChpQYXlFbGVjdHJpY2l0eUJpbGxSZXNwb25zZRIrCgdwYXltZW50GAEgASgLMhEucGF5bWVudHMuUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIUCgV0b2tlbhgDIAEoCVIFdG9rZW4SFAoFdW5pdHMYBCABKAlSBXVuaXRzEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use buyAirtimeRequestDescriptor instead')
const BuyAirtimeRequest$json = const {
  '1': 'BuyAirtimeRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'provider_id', '3': 2, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'airtime_type', '3': 5, '4': 1, '5': 9, '10': 'airtimeType'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeRequestDescriptor = $convert.base64Decode('ChFCdXlBaXJ0aW1lUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSHwoLcHJvdmlkZXJfaWQYAiABKAlSCnByb3ZpZGVySWQSIQoMcGhvbmVfbnVtYmVyGAMgASgJUgtwaG9uZU51bWJlchIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIhCgxhaXJ0aW1lX3R5cGUYBSABKAlSC2FpcnRpbWVUeXBlEiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');
@$core.Deprecated('Use buyAirtimeResponseDescriptor instead')
const BuyAirtimeResponse$json = const {
  '1': 'BuyAirtimeResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeResponseDescriptor = $convert.base64Decode('ChJCdXlBaXJ0aW1lUmVzcG9uc2USKwoHcGF5bWVudBgBIAEoCzIRLnBheW1lbnRzLlBheW1lbnRSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USIQoMcGhvbmVfbnVtYmVyGAMgASgJUgtwaG9uZU51bWJlchIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use barcodePayRequestDescriptor instead')
const BarcodePayRequest$json = const {
  '1': 'BarcodePayRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'barcode_data', '3': 2, '4': 1, '5': 9, '10': 'barcodeData'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BarcodePayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePayRequestDescriptor = $convert.base64Decode('ChFCYXJjb2RlUGF5UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSIQoMYmFyY29kZV9kYXRhGAIgASgJUgtiYXJjb2RlRGF0YRIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIlCg50cmFuc2FjdGlvbl9pZBgEIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBSABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use barcodePayResponseDescriptor instead')
const BarcodePayResponse$json = const {
  '1': 'BarcodePayResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BarcodePayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePayResponseDescriptor = $convert.base64Decode('ChJCYXJjb2RlUGF5UmVzcG9uc2USKwoHcGF5bWVudBgBIAEoCzIRLnBheW1lbnRzLlBheW1lbnRSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USIwoNbWVyY2hhbnRfbmFtZRgDIAEoCVIMbWVyY2hhbnROYW1lEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use scanToPayRequestDescriptor instead')
const ScanToPayRequest$json = const {
  '1': 'ScanToPayRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'image_data', '3': 2, '4': 1, '5': 12, '10': 'imageData'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `ScanToPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanToPayRequestDescriptor = $convert.base64Decode('ChBTY2FuVG9QYXlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIdCgppbWFnZV9kYXRhGAIgASgMUglpbWFnZURhdGESFgoGYW1vdW50GAMgASgBUgZhbW91bnQSJQoOdHJhbnNhY3Rpb25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAUgASgJUhF2ZXJpZmljYXRpb25Ub2tlbg==');
@$core.Deprecated('Use scanToPayResponseDescriptor instead')
const ScanToPayResponse$json = const {
  '1': 'ScanToPayResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    const {'1': 'extracted_amount', '3': 4, '4': 1, '5': 1, '10': 'extractedAmount'},
    const {'1': 'bill_details', '3': 5, '4': 1, '5': 9, '10': 'billDetails'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ScanToPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanToPayResponseDescriptor = $convert.base64Decode('ChFTY2FuVG9QYXlSZXNwb25zZRIrCgdwYXltZW50GAEgASgLMhEucGF5bWVudHMuUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIjCg1tZXJjaGFudF9uYW1lGAMgASgJUgxtZXJjaGFudE5hbWUSKQoQZXh0cmFjdGVkX2Ftb3VudBgEIAEoAVIPZXh0cmFjdGVkQW1vdW50EiEKDGJpbGxfZGV0YWlscxgFIAEoCVILYmlsbERldGFpbHMSGAoHbWVzc2FnZRgGIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getPaymentHistoryRequestDescriptor instead')
const GetPaymentHistoryRequest$json = const {
  '1': 'GetPaymentHistoryRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'payment_type', '3': 2, '4': 1, '5': 9, '10': 'paymentType'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'start_date', '3': 4, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 5, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 6, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 7, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetPaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryRequestDescriptor = $convert.base64Decode('ChhHZXRQYXltZW50SGlzdG9yeVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEiEKDHBheW1lbnRfdHlwZRgCIAEoCVILcGF5bWVudFR5cGUSFgoGc3RhdHVzGAMgASgJUgZzdGF0dXMSHQoKc3RhcnRfZGF0ZRgEIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAUgASgJUgdlbmREYXRlEhQKBWxpbWl0GAYgASgFUgVsaW1pdBIWCgZvZmZzZXQYByABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getPaymentHistoryResponseDescriptor instead')
const GetPaymentHistoryResponse$json = const {
  '1': 'GetPaymentHistoryResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.payments.Payment', '10': 'payments'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryResponseDescriptor = $convert.base64Decode('ChlHZXRQYXltZW50SGlzdG9yeVJlc3BvbnNlEi0KCHBheW1lbnRzGAEgAygLMhEucGF5bWVudHMuUGF5bWVudFIIcGF5bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getBillProvidersRequestDescriptor instead')
const GetBillProvidersRequest$json = const {
  '1': 'GetBillProvidersRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetBillProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillProvidersRequestDescriptor = $convert.base64Decode('ChdHZXRCaWxsUHJvdmlkZXJzUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEh8KC2FjdGl2ZV9vbmx5GAIgASgIUgphY3RpdmVPbmx5');
@$core.Deprecated('Use getBillProvidersResponseDescriptor instead')
const GetBillProvidersResponse$json = const {
  '1': 'GetBillProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.payments.BillProvider', '10': 'providers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetBillProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillProvidersResponseDescriptor = $convert.base64Decode('ChhHZXRCaWxsUHJvdmlkZXJzUmVzcG9uc2USNAoJcHJvdmlkZXJzGAEgAygLMhYucGF5bWVudHMuQmlsbFByb3ZpZGVyUglwcm92aWRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getAirtimeProvidersRequestDescriptor instead')
const GetAirtimeProvidersRequest$json = const {
  '1': 'GetAirtimeProvidersRequest',
  '2': const [
    const {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetAirtimeProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersRequestDescriptor = $convert.base64Decode('ChpHZXRBaXJ0aW1lUHJvdmlkZXJzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aXZlT25seQ==');
@$core.Deprecated('Use getAirtimeProvidersResponseDescriptor instead')
const GetAirtimeProvidersResponse$json = const {
  '1': 'GetAirtimeProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.payments.AirtimeProvider', '10': 'providers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAirtimeProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersResponseDescriptor = $convert.base64Decode('ChtHZXRBaXJ0aW1lUHJvdmlkZXJzUmVzcG9uc2USNwoJcHJvdmlkZXJzGAEgAygLMhkucGF5bWVudHMuQWlydGltZVByb3ZpZGVyUglwcm92aWRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use resolveTagRequestDescriptor instead')
const ResolveTagRequest$json = const {
  '1': 'ResolveTagRequest',
  '2': const [
    const {'1': 'tag', '3': 1, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `ResolveTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveTagRequestDescriptor = $convert.base64Decode('ChFSZXNvbHZlVGFnUmVxdWVzdBIQCgN0YWcYASABKAlSA3RhZw==');
@$core.Deprecated('Use resolveTagResponseDescriptor instead')
const ResolveTagResponse$json = const {
  '1': 'ResolveTagResponse',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 2, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'tag', '3': 3, '4': 1, '5': 9, '10': 'tag'},
    const {'1': 'is_valid', '3': 4, '4': 1, '5': 8, '10': 'isValid'},
  ],
};

/// Descriptor for `ResolveTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveTagResponseDescriptor = $convert.base64Decode('ChJSZXNvbHZlVGFnUmVzcG9uc2USJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAIgASgJUgthY2NvdW50TmFtZRIQCgN0YWcYAyABKAlSA3RhZxIZCghpc192YWxpZBgEIAEoCFIHaXNWYWxpZA==');
