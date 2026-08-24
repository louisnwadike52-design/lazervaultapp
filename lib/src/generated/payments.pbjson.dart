///
//  Generated code. Do not modify.
//  source: payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use recurringFrequencyDescriptor instead')
const RecurringFrequency$json = const {
  '1': 'RecurringFrequency',
  '2': const [
    const {'1': 'RECURRING_FREQUENCY_UNSPECIFIED', '2': 0},
    const {'1': 'RECURRING_FREQUENCY_DAILY', '2': 1},
    const {'1': 'RECURRING_FREQUENCY_WEEKLY', '2': 2},
    const {'1': 'RECURRING_FREQUENCY_BIWEEKLY', '2': 3},
    const {'1': 'RECURRING_FREQUENCY_MONTHLY', '2': 4},
  ],
};

/// Descriptor for `RecurringFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List recurringFrequencyDescriptor = $convert.base64Decode('ChJSZWN1cnJpbmdGcmVxdWVuY3kSIwofUkVDVVJSSU5HX0ZSRVFVRU5DWV9VTlNQRUNJRklFRBAAEh0KGVJFQ1VSUklOR19GUkVRVUVOQ1lfREFJTFkQARIeChpSRUNVUlJJTkdfRlJFUVVFTkNZX1dFRUtMWRACEiAKHFJFQ1VSUklOR19GUkVRVUVOQ1lfQklXRUVLTFkQAxIfChtSRUNVUlJJTkdfRlJFUVVFTkNZX01PTlRITFkQBA==');
@$core.Deprecated('Use recurringTransferStatusDescriptor instead')
const RecurringTransferStatus$json = const {
  '1': 'RecurringTransferStatus',
  '2': const [
    const {'1': 'RECURRING_TRANSFER_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'RECURRING_TRANSFER_STATUS_ACTIVE', '2': 1},
    const {'1': 'RECURRING_TRANSFER_STATUS_PAUSED', '2': 2},
    const {'1': 'RECURRING_TRANSFER_STATUS_CANCELLED', '2': 3},
    const {'1': 'RECURRING_TRANSFER_STATUS_EXPIRED', '2': 4},
  ],
};

/// Descriptor for `RecurringTransferStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List recurringTransferStatusDescriptor = $convert.base64Decode('ChdSZWN1cnJpbmdUcmFuc2ZlclN0YXR1cxIpCiVSRUNVUlJJTkdfVFJBTlNGRVJfU1RBVFVTX1VOU1BFQ0lGSUVEEAASJAogUkVDVVJSSU5HX1RSQU5TRkVSX1NUQVRVU19BQ1RJVkUQARIkCiBSRUNVUlJJTkdfVFJBTlNGRVJfU1RBVFVTX1BBVVNFRBACEicKI1JFQ1VSUklOR19UUkFOU0ZFUl9TVEFUVVNfQ0FOQ0VMTEVEEAMSJQohUkVDVVJSSU5HX1RSQU5TRkVSX1NUQVRVU19FWFBJUkVEEAQ=');
@$core.Deprecated('Use getFraudDetectionSettingRequestDescriptor instead')
const GetFraudDetectionSettingRequest$json = const {
  '1': 'GetFraudDetectionSettingRequest',
};

/// Descriptor for `GetFraudDetectionSettingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFraudDetectionSettingRequestDescriptor = $convert.base64Decode('Ch9HZXRGcmF1ZERldGVjdGlvblNldHRpbmdSZXF1ZXN0');
@$core.Deprecated('Use setFraudDetectionSettingRequestDescriptor instead')
const SetFraudDetectionSettingRequest$json = const {
  '1': 'SetFraudDetectionSettingRequest',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `SetFraudDetectionSettingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setFraudDetectionSettingRequestDescriptor = $convert.base64Decode('Ch9TZXRGcmF1ZERldGVjdGlvblNldHRpbmdSZXF1ZXN0EhgKB2VuYWJsZWQYASABKAhSB2VuYWJsZWQ=');
@$core.Deprecated('Use fraudDetectionSettingDescriptor instead')
const FraudDetectionSetting$json = const {
  '1': 'FraudDetectionSetting',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `FraudDetectionSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fraudDetectionSettingDescriptor = $convert.base64Decode('ChVGcmF1ZERldGVjdGlvblNldHRpbmcSGAoHZW5hYmxlZBgBIAEoCFIHZW5hYmxlZA==');
@$core.Deprecated('Use getFraudFreezeStatusRequestDescriptor instead')
const GetFraudFreezeStatusRequest$json = const {
  '1': 'GetFraudFreezeStatusRequest',
};

/// Descriptor for `GetFraudFreezeStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFraudFreezeStatusRequestDescriptor = $convert.base64Decode('ChtHZXRGcmF1ZEZyZWV6ZVN0YXR1c1JlcXVlc3Q=');
@$core.Deprecated('Use fraudFreezeStatusDescriptor instead')
const FraudFreezeStatus$json = const {
  '1': 'FraudFreezeStatus',
  '2': const [
    const {'1': 'frozen', '3': 1, '4': 1, '5': 8, '10': 'frozen'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'amount_minor', '3': 3, '4': 1, '5': 3, '10': 'amountMinor'},
    const {'1': 'limit_minor', '3': 4, '4': 1, '5': 3, '10': 'limitMinor'},
    const {'1': 'blocked_at', '3': 5, '4': 1, '5': 9, '10': 'blockedAt'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'blocked_id', '3': 7, '4': 1, '5': 9, '10': 'blockedId'},
  ],
};

/// Descriptor for `FraudFreezeStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fraudFreezeStatusDescriptor = $convert.base64Decode('ChFGcmF1ZEZyZWV6ZVN0YXR1cxIWCgZmcm96ZW4YASABKAhSBmZyb3plbhIWCgZyZWFzb24YAiABKAlSBnJlYXNvbhIhCgxhbW91bnRfbWlub3IYAyABKANSC2Ftb3VudE1pbm9yEh8KC2xpbWl0X21pbm9yGAQgASgDUgpsaW1pdE1pbm9yEh0KCmJsb2NrZWRfYXQYBSABKAlSCWJsb2NrZWRBdBIcCglyZWZlcmVuY2UYBiABKAlSCXJlZmVyZW5jZRIdCgpibG9ja2VkX2lkGAcgASgJUglibG9ja2VkSWQ=');
@$core.Deprecated('Use requestFraudUnfreezeRequestDescriptor instead')
const RequestFraudUnfreezeRequest$json = const {
  '1': 'RequestFraudUnfreezeRequest',
  '2': const [
    const {'1': 'verification_token', '3': 1, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `RequestFraudUnfreezeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestFraudUnfreezeRequestDescriptor = $convert.base64Decode('ChtSZXF1ZXN0RnJhdWRVbmZyZWV6ZVJlcXVlc3QSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAEgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIlCg50cmFuc2FjdGlvbl9pZBgCIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use requestFraudUnfreezeResponseDescriptor instead')
const RequestFraudUnfreezeResponse$json = const {
  '1': 'RequestFraudUnfreezeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RequestFraudUnfreezeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestFraudUnfreezeResponseDescriptor = $convert.base64Decode('ChxSZXF1ZXN0RnJhdWRVbmZyZWV6ZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
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
    const {'1': 'to_account_id', '3': 9, '4': 1, '5': 9, '10': 'toAccountId'},
    const {'1': 'type', '3': 10, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'destination_bank_code', '3': 7, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'beneficiary_name', '3': 8, '4': 1, '5': 9, '10': 'beneficiaryName'},
    const {'1': 'expense_category', '3': 11, '4': 1, '5': 5, '10': 'expenseCategory'},
    const {'1': 'idempotency_key', '3': 12, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `SendFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendFundsRequestDescriptor = $convert.base64Decode('ChBTZW5kRnVuZHNSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZnJvbUFjY291bnRJZBIqChF0b19hY2NvdW50X251bWJlchgCIAEoCVIPdG9BY2NvdW50TnVtYmVyEiIKDXRvX2FjY291bnRfaWQYCSABKAlSC3RvQWNjb3VudElkEhIKBHR5cGUYCiABKAlSBHR5cGUSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEiUKDnRyYW5zYWN0aW9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SMgoVZGVzdGluYXRpb25fYmFua19jb2RlGAcgASgJUhNkZXN0aW5hdGlvbkJhbmtDb2RlEikKEGJlbmVmaWNpYXJ5X25hbWUYCCABKAlSD2JlbmVmaWNpYXJ5TmFtZRIpChBleHBlbnNlX2NhdGVnb3J5GAsgASgFUg9leHBlbnNlQ2F0ZWdvcnkSJwoPaWRlbXBvdGVuY3lfa2V5GAwgASgJUg5pZGVtcG90ZW5jeUtleQ==');
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
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'destination_bank_code', '3': 6, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'beneficiary_name', '3': 7, '4': 1, '5': 9, '10': 'beneficiaryName'},
    const {'1': 'destination_bank_name', '3': 8, '4': 1, '5': 9, '10': 'destinationBankName'},
  ],
};

/// Descriptor for `BatchTransferItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferItemDescriptor = $convert.base64Decode('ChFCYXRjaFRyYW5zZmVySXRlbRIqChF0b19hY2NvdW50X251bWJlchgBIAEoCVIPdG9BY2NvdW50TnVtYmVyEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIcCglyZWZlcmVuY2UYBCABKAlSCXJlZmVyZW5jZRIaCghjYXRlZ29yeRgFIAEoCVIIY2F0ZWdvcnkSMgoVZGVzdGluYXRpb25fYmFua19jb2RlGAYgASgJUhNkZXN0aW5hdGlvbkJhbmtDb2RlEikKEGJlbmVmaWNpYXJ5X25hbWUYByABKAlSD2JlbmVmaWNpYXJ5TmFtZRIyChVkZXN0aW5hdGlvbl9iYW5rX25hbWUYCCABKAlSE2Rlc3RpbmF0aW9uQmFua05hbWU=');
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
    const {'1': 'batch_id', '3': 1, '4': 1, '5': 9, '10': 'batchId'},
    const {'1': 'total_transfers', '3': 2, '4': 1, '5': 5, '10': 'totalTransfers'},
    const {'1': 'successful_transfers', '3': 3, '4': 1, '5': 5, '10': 'successfulTransfers'},
    const {'1': 'failed_transfers', '3': 4, '4': 1, '5': 5, '10': 'failedTransfers'},
    const {'1': 'results', '3': 5, '4': 3, '5': 11, '6': '.payments.BatchTransferResultItem', '10': 'results'},
    const {'1': 'new_balance', '3': 6, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'total_amount', '3': 9, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'total_fee', '3': 10, '4': 1, '5': 1, '10': 'totalFee'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'completed_at', '3': 12, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `BatchTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferResponseDescriptor = $convert.base64Decode('ChVCYXRjaFRyYW5zZmVyUmVzcG9uc2USGQoIYmF0Y2hfaWQYASABKAlSB2JhdGNoSWQSJwoPdG90YWxfdHJhbnNmZXJzGAIgASgFUg50b3RhbFRyYW5zZmVycxIxChRzdWNjZXNzZnVsX3RyYW5zZmVycxgDIAEoBVITc3VjY2Vzc2Z1bFRyYW5zZmVycxIpChBmYWlsZWRfdHJhbnNmZXJzGAQgASgFUg9mYWlsZWRUcmFuc2ZlcnMSOwoHcmVzdWx0cxgFIAMoCzIhLnBheW1lbnRzLkJhdGNoVHJhbnNmZXJSZXN1bHRJdGVtUgdyZXN1bHRzEh8KC25ld19iYWxhbmNlGAYgASgBUgpuZXdCYWxhbmNlEhgKB21lc3NhZ2UYByABKAlSB21lc3NhZ2USFgoGc3RhdHVzGAggASgJUgZzdGF0dXMSIQoMdG90YWxfYW1vdW50GAkgASgBUgt0b3RhbEFtb3VudBIbCgl0b3RhbF9mZWUYCiABKAFSCHRvdGFsRmVlEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIhCgxjb21wbGV0ZWRfYXQYDCABKAlSC2NvbXBsZXRlZEF0');
@$core.Deprecated('Use batchTransferResultItemDescriptor instead')
const BatchTransferResultItem$json = const {
  '1': 'BatchTransferResultItem',
  '2': const [
    const {'1': 'transfer_id', '3': 1, '4': 1, '5': 9, '10': 'transferId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'fee', '3': 4, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'recipient_name', '3': 5, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'recipient_account', '3': 6, '4': 1, '5': 9, '10': 'recipientAccount'},
    const {'1': 'failure_reason', '3': 7, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'destination_bank_code', '3': 9, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'destination_bank_name', '3': 10, '4': 1, '5': 9, '10': 'destinationBankName'},
    const {'1': 'transfer_type', '3': 11, '4': 1, '5': 9, '10': 'transferType'},
    const {'1': 'beneficiary_name', '3': 12, '4': 1, '5': 9, '10': 'beneficiaryName'},
    const {'1': 'recipient_user_id', '3': 13, '4': 1, '5': 9, '10': 'recipientUserId'},
  ],
};

/// Descriptor for `BatchTransferResultItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferResultItemDescriptor = $convert.base64Decode('ChdCYXRjaFRyYW5zZmVyUmVzdWx0SXRlbRIfCgt0cmFuc2Zlcl9pZBgBIAEoCVIKdHJhbnNmZXJJZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIQCgNmZWUYBCABKAFSA2ZlZRIlCg5yZWNpcGllbnRfbmFtZRgFIAEoCVINcmVjaXBpZW50TmFtZRIrChFyZWNpcGllbnRfYWNjb3VudBgGIAEoCVIQcmVjaXBpZW50QWNjb3VudBIlCg5mYWlsdXJlX3JlYXNvbhgHIAEoCVINZmFpbHVyZVJlYXNvbhIcCglyZWZlcmVuY2UYCCABKAlSCXJlZmVyZW5jZRIyChVkZXN0aW5hdGlvbl9iYW5rX2NvZGUYCSABKAlSE2Rlc3RpbmF0aW9uQmFua0NvZGUSMgoVZGVzdGluYXRpb25fYmFua19uYW1lGAogASgJUhNkZXN0aW5hdGlvbkJhbmtOYW1lEiMKDXRyYW5zZmVyX3R5cGUYCyABKAlSDHRyYW5zZmVyVHlwZRIpChBiZW5lZmljaWFyeV9uYW1lGAwgASgJUg9iZW5lZmljaWFyeU5hbWUSKgoRcmVjaXBpZW50X3VzZXJfaWQYDSABKAlSD3JlY2lwaWVudFVzZXJJZA==');
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
@$core.Deprecated('Use transactionItemDescriptor instead')
const TransactionItem$json = const {
  '1': 'TransactionItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 3, '10': 'createdAt'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 9, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'fee', '3': 10, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'total_amount', '3': 11, '4': 1, '5': 9, '10': 'totalAmount'},
    const {'1': 'source_account_id', '3': 12, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'source_account_number', '3': 13, '4': 1, '5': 9, '10': 'sourceAccountNumber'},
    const {'1': 'destination_account_id', '3': 14, '4': 1, '5': 9, '10': 'destinationAccountId'},
    const {'1': 'destination_account_number', '3': 15, '4': 1, '5': 9, '10': 'destinationAccountNumber'},
    const {'1': 'destination_name', '3': 16, '4': 1, '5': 9, '10': 'destinationName'},
    const {'1': 'destination_bank_code', '3': 17, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'destination_bank_name', '3': 18, '4': 1, '5': 9, '10': 'destinationBankName'},
    const {'1': 'payment_type', '3': 19, '4': 1, '5': 9, '10': 'paymentType'},
    const {'1': 'transfer_type', '3': 20, '4': 1, '5': 9, '10': 'transferType'},
    const {'1': 'metadata', '3': 21, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'completed_at', '3': 22, '4': 1, '5': 3, '10': 'completedAt'},
    const {'1': 'failed_at', '3': 23, '4': 1, '5': 3, '10': 'failedAt'},
  ],
};

/// Descriptor for `TransactionItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionItemDescriptor = $convert.base64Decode('Cg9UcmFuc2FjdGlvbkl0ZW0SDgoCaWQYASABKAlSAmlkEhIKBHR5cGUYAiABKAlSBHR5cGUSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEh0KCmNyZWF0ZWRfYXQYBCABKANSCWNyZWF0ZWRBdBIWCgZhbW91bnQYBSABKAlSBmFtb3VudBIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSFgoGc3RhdHVzGAcgASgJUgZzdGF0dXMSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEhwKCXJlZmVyZW5jZRgJIAEoCVIJcmVmZXJlbmNlEhAKA2ZlZRgKIAEoAVIDZmVlEiEKDHRvdGFsX2Ftb3VudBgLIAEoCVILdG90YWxBbW91bnQSKgoRc291cmNlX2FjY291bnRfaWQYDCABKAlSD3NvdXJjZUFjY291bnRJZBIyChVzb3VyY2VfYWNjb3VudF9udW1iZXIYDSABKAlSE3NvdXJjZUFjY291bnROdW1iZXISNAoWZGVzdGluYXRpb25fYWNjb3VudF9pZBgOIAEoCVIUZGVzdGluYXRpb25BY2NvdW50SWQSPAoaZGVzdGluYXRpb25fYWNjb3VudF9udW1iZXIYDyABKAlSGGRlc3RpbmF0aW9uQWNjb3VudE51bWJlchIpChBkZXN0aW5hdGlvbl9uYW1lGBAgASgJUg9kZXN0aW5hdGlvbk5hbWUSMgoVZGVzdGluYXRpb25fYmFua19jb2RlGBEgASgJUhNkZXN0aW5hdGlvbkJhbmtDb2RlEjIKFWRlc3RpbmF0aW9uX2JhbmtfbmFtZRgSIAEoCVITZGVzdGluYXRpb25CYW5rTmFtZRIhCgxwYXltZW50X3R5cGUYEyABKAlSC3BheW1lbnRUeXBlEiMKDXRyYW5zZmVyX3R5cGUYFCABKAlSDHRyYW5zZmVyVHlwZRIaCghtZXRhZGF0YRgVIAEoCVIIbWV0YWRhdGESIQoMY29tcGxldGVkX2F0GBYgASgDUgtjb21wbGV0ZWRBdBIbCglmYWlsZWRfYXQYFyABKANSCGZhaWxlZEF0');
@$core.Deprecated('Use getPaymentHistoryResponseDescriptor instead')
const GetPaymentHistoryResponse$json = const {
  '1': 'GetPaymentHistoryResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.payments.TransactionItem', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryResponseDescriptor = $convert.base64Decode('ChlHZXRQYXltZW50SGlzdG9yeVJlc3BvbnNlEj0KDHRyYW5zYWN0aW9ucxgBIAMoCzIZLnBheW1lbnRzLlRyYW5zYWN0aW9uSXRlbVIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use getFrequentBanksRequestDescriptor instead')
const GetFrequentBanksRequest$json = const {
  '1': 'GetFrequentBanksRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetFrequentBanksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFrequentBanksRequestDescriptor = $convert.base64Decode('ChdHZXRGcmVxdWVudEJhbmtzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use frequentBankDescriptor instead')
const FrequentBank$json = const {
  '1': 'FrequentBank',
  '2': const [
    const {'1': 'bank_code', '3': 1, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 2, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'count', '3': 3, '4': 1, '5': 3, '10': 'count'},
  ],
};

/// Descriptor for `FrequentBank`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List frequentBankDescriptor = $convert.base64Decode('CgxGcmVxdWVudEJhbmsSGwoJYmFua19jb2RlGAEgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYAiABKAlSCGJhbmtOYW1lEhQKBWNvdW50GAMgASgDUgVjb3VudA==');
@$core.Deprecated('Use getFrequentBanksResponseDescriptor instead')
const GetFrequentBanksResponse$json = const {
  '1': 'GetFrequentBanksResponse',
  '2': const [
    const {'1': 'banks', '3': 1, '4': 3, '5': 11, '6': '.payments.FrequentBank', '10': 'banks'},
  ],
};

/// Descriptor for `GetFrequentBanksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFrequentBanksResponseDescriptor = $convert.base64Decode('ChhHZXRGcmVxdWVudEJhbmtzUmVzcG9uc2USLAoFYmFua3MYASADKAsyFi5wYXltZW50cy5GcmVxdWVudEJhbmtSBWJhbmtz');
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
@$core.Deprecated('Use bankDetailsDescriptor instead')
const BankDetails$json = const {
  '1': 'BankDetails',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 2, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'bank_name', '3': 3, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'bank_code', '3': 4, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'routing_number', '3': 5, '4': 1, '5': 9, '10': 'routingNumber'},
    const {'1': 'account_type', '3': 6, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'confidence_score', '3': 7, '4': 1, '5': 1, '10': 'confidenceScore'},
    const {'1': 'mono_account_id', '3': 8, '4': 1, '5': 9, '10': 'monoAccountId'},
    const {'1': 'balance', '3': 9, '4': 1, '5': 1, '10': 'balance'},
  ],
};

/// Descriptor for `BankDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankDetailsDescriptor = $convert.base64Decode('CgtCYW5rRGV0YWlscxIlCg5hY2NvdW50X251bWJlchgBIAEoCVINYWNjb3VudE51bWJlchIhCgxhY2NvdW50X25hbWUYAiABKAlSC2FjY291bnROYW1lEhsKCWJhbmtfbmFtZRgDIAEoCVIIYmFua05hbWUSGwoJYmFua19jb2RlGAQgASgJUghiYW5rQ29kZRIlCg5yb3V0aW5nX251bWJlchgFIAEoCVINcm91dGluZ051bWJlchIhCgxhY2NvdW50X3R5cGUYBiABKAlSC2FjY291bnRUeXBlEikKEGNvbmZpZGVuY2Vfc2NvcmUYByABKAFSD2NvbmZpZGVuY2VTY29yZRImCg9tb25vX2FjY291bnRfaWQYCCABKAlSDW1vbm9BY2NvdW50SWQSGAoHYmFsYW5jZRgJIAEoAVIHYmFsYW5jZQ==');
@$core.Deprecated('Use payWithBankDetailsRequestDescriptor instead')
const PayWithBankDetailsRequest$json = const {
  '1': 'PayWithBankDetailsRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'bank_details', '3': 2, '4': 1, '5': 11, '6': '.payments.BankDetails', '10': 'bankDetails'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `PayWithBankDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWithBankDetailsRequestDescriptor = $convert.base64Decode('ChlQYXlXaXRoQmFua0RldGFpbHNSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZnJvbUFjY291bnRJZBI4CgxiYW5rX2RldGFpbHMYAiABKAsyFS5wYXltZW50cy5CYW5rRGV0YWlsc1ILYmFua0RldGFpbHMSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YByABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use payWithBankDetailsResponseDescriptor instead')
const PayWithBankDetailsResponse$json = const {
  '1': 'PayWithBankDetailsResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.payments.Payment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'transfer_reference', '3': 4, '4': 1, '5': 9, '10': 'transferReference'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayWithBankDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWithBankDetailsResponseDescriptor = $convert.base64Decode('ChpQYXlXaXRoQmFua0RldGFpbHNSZXNwb25zZRIrCgdwYXltZW50GAEgASgLMhEucGF5bWVudHMuUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIlCg5yZWNpcGllbnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRItChJ0cmFuc2Zlcl9yZWZlcmVuY2UYBCABKAlSEXRyYW5zZmVyUmVmZXJlbmNlEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use verifyBankAccountRequestDescriptor instead')
const VerifyBankAccountRequest$json = const {
  '1': 'VerifyBankAccountRequest',
  '2': const [
    const {'1': 'bank_code', '3': 1, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'country', '3': 3, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `VerifyBankAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBankAccountRequestDescriptor = $convert.base64Decode('ChhWZXJpZnlCYW5rQWNjb3VudFJlcXVlc3QSGwoJYmFua19jb2RlGAEgASgJUghiYW5rQ29kZRIlCg5hY2NvdW50X251bWJlchgCIAEoCVINYWNjb3VudE51bWJlchIYCgdjb3VudHJ5GAMgASgJUgdjb3VudHJ5');
@$core.Deprecated('Use verifyBankAccountResponseDescriptor instead')
const VerifyBankAccountResponse$json = const {
  '1': 'VerifyBankAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 3, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'bank_name', '3': 4, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'bank_code', '3': 5, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'verification_status', '3': 6, '4': 1, '5': 9, '10': 'verificationStatus'},
    const {'1': 'error_code', '3': 7, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 8, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'user_message', '3': 9, '4': 1, '5': 9, '10': 'userMessage'},
    const {'1': 'provider', '3': 10, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `VerifyBankAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBankAccountResponseDescriptor = $convert.base64Decode('ChlWZXJpZnlCYW5rQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSJQoOYWNjb3VudF9udW1iZXIYAiABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAMgASgJUgthY2NvdW50TmFtZRIbCgliYW5rX25hbWUYBCABKAlSCGJhbmtOYW1lEhsKCWJhbmtfY29kZRgFIAEoCVIIYmFua0NvZGUSLwoTdmVyaWZpY2F0aW9uX3N0YXR1cxgGIAEoCVISdmVyaWZpY2F0aW9uU3RhdHVzEh0KCmVycm9yX2NvZGUYByABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAggASgJUgxlcnJvck1lc3NhZ2USIQoMdXNlcl9tZXNzYWdlGAkgASgJUgt1c2VyTWVzc2FnZRIaCghwcm92aWRlchgKIAEoCVIIcHJvdmlkZXI=');
@$core.Deprecated('Use suggestBankAccountsRequestDescriptor instead')
const SuggestBankAccountsRequest$json = const {
  '1': 'SuggestBankAccountsRequest',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'country', '3': 2, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `SuggestBankAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List suggestBankAccountsRequestDescriptor = $convert.base64Decode('ChpTdWdnZXN0QmFua0FjY291bnRzUmVxdWVzdBIlCg5hY2NvdW50X251bWJlchgBIAEoCVINYWNjb3VudE51bWJlchIYCgdjb3VudHJ5GAIgASgJUgdjb3VudHJ5');
@$core.Deprecated('Use bankAccountMatchDescriptor instead')
const BankAccountMatch$json = const {
  '1': 'BankAccountMatch',
  '2': const [
    const {'1': 'bank_code', '3': 1, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 2, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'account_name', '3': 3, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `BankAccountMatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankAccountMatchDescriptor = $convert.base64Decode('ChBCYW5rQWNjb3VudE1hdGNoEhsKCWJhbmtfY29kZRgBIAEoCVIIYmFua0NvZGUSGwoJYmFua19uYW1lGAIgASgJUghiYW5rTmFtZRIhCgxhY2NvdW50X25hbWUYAyABKAlSC2FjY291bnROYW1lEiUKDmFjY291bnRfbnVtYmVyGAQgASgJUg1hY2NvdW50TnVtYmVy');
@$core.Deprecated('Use suggestBankAccountsResponseDescriptor instead')
const SuggestBankAccountsResponse$json = const {
  '1': 'SuggestBankAccountsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'matches', '3': 2, '4': 3, '5': 11, '6': '.payments.BankAccountMatch', '10': 'matches'},
    const {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `SuggestBankAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List suggestBankAccountsResponseDescriptor = $convert.base64Decode('ChtTdWdnZXN0QmFua0FjY291bnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxI0CgdtYXRjaGVzGAIgAygLMhoucGF5bWVudHMuQmFua0FjY291bnRNYXRjaFIHbWF0Y2hlcxIaCghwcm92aWRlchgDIAEoCVIIcHJvdmlkZXISIwoNZXJyb3JfbWVzc2FnZRgEIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use initiateDomesticTransferRequestDescriptor instead')
const InitiateDomesticTransferRequest$json = const {
  '1': 'InitiateDomesticTransferRequest',
  '2': const [
    const {'1': 'source_account_id', '3': 1, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'destination_account', '3': 4, '4': 1, '5': 9, '10': 'destinationAccount'},
    const {'1': 'destination_bank_code', '3': 5, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'destination_name', '3': 6, '4': 1, '5': 9, '10': 'destinationName'},
    const {'1': 'narration', '3': 7, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 10, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 11, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `InitiateDomesticTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateDomesticTransferRequestDescriptor = $convert.base64Decode('Ch9Jbml0aWF0ZURvbWVzdGljVHJhbnNmZXJSZXF1ZXN0EioKEXNvdXJjZV9hY2NvdW50X2lkGAEgASgJUg9zb3VyY2VBY2NvdW50SWQSFgoGYW1vdW50GAIgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5Ei8KE2Rlc3RpbmF0aW9uX2FjY291bnQYBCABKAlSEmRlc3RpbmF0aW9uQWNjb3VudBIyChVkZXN0aW5hdGlvbl9iYW5rX2NvZGUYBSABKAlSE2Rlc3RpbmF0aW9uQmFua0NvZGUSKQoQZGVzdGluYXRpb25fbmFtZRgGIAEoCVIPZGVzdGluYXRpb25OYW1lEhwKCW5hcnJhdGlvbhgHIAEoCVIJbmFycmF0aW9uEhwKCXJlZmVyZW5jZRgIIAEoCVIJcmVmZXJlbmNlEicKD2lkZW1wb3RlbmN5X2tleRgJIAEoCVIOaWRlbXBvdGVuY3lLZXkSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAogASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIlCg50cmFuc2FjdGlvbl9pZBgLIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use initiateInternalTransferRequestDescriptor instead')
const InitiateInternalTransferRequest$json = const {
  '1': 'InitiateInternalTransferRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'to_account_id', '3': 2, '4': 1, '5': 9, '10': 'toAccountId'},
    const {'1': 'to_username', '3': 3, '4': 1, '5': 9, '10': 'toUsername'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'narration', '3': 6, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 9, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'recipient_info', '3': 11, '4': 1, '5': 11, '6': '.payments.RecipientInfo', '10': 'recipientInfo'},
  ],
};

/// Descriptor for `InitiateInternalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternalTransferRequestDescriptor = $convert.base64Decode('Ch9Jbml0aWF0ZUludGVybmFsVHJhbnNmZXJSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZnJvbUFjY291bnRJZBIiCg10b19hY2NvdW50X2lkGAIgASgJUgt0b0FjY291bnRJZBIfCgt0b191c2VybmFtZRgDIAEoCVIKdG9Vc2VybmFtZRIWCgZhbW91bnQYBCABKANSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSHAoJbmFycmF0aW9uGAYgASgJUgluYXJyYXRpb24SHAoJcmVmZXJlbmNlGAcgASgJUglyZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAggASgJUg5pZGVtcG90ZW5jeUtleRItChJ2ZXJpZmljYXRpb25fdG9rZW4YCSABKAlSEXZlcmlmaWNhdGlvblRva2VuEiUKDnRyYW5zYWN0aW9uX2lkGAogASgJUg10cmFuc2FjdGlvbklkEj4KDnJlY2lwaWVudF9pbmZvGAsgASgLMhcucGF5bWVudHMuUmVjaXBpZW50SW5mb1INcmVjaXBpZW50SW5mbw==');
@$core.Deprecated('Use recipientInfoDescriptor instead')
const RecipientInfo$json = const {
  '1': 'RecipientInfo',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'recipient_type', '3': 2, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'recipient_source', '3': 3, '4': 1, '5': 9, '10': 'recipientSource'},
    const {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 8, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'phone_number', '3': 9, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `RecipientInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recipientInfoDescriptor = $convert.base64Decode('Cg1SZWNpcGllbnRJbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSJQoOcmVjaXBpZW50X3R5cGUYAiABKAlSDXJlY2lwaWVudFR5cGUSKQoQcmVjaXBpZW50X3NvdXJjZRgDIAEoCVIPcmVjaXBpZW50U291cmNlEhoKCHVzZXJuYW1lGAQgASgJUgh1c2VybmFtZRIXCgd1c2VyX2lkGAUgASgJUgZ1c2VySWQSJQoOYWNjb3VudF9udW1iZXIYBiABKAlSDWFjY291bnROdW1iZXISGwoJYmFua19jb2RlGAcgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYCCABKAlSCGJhbmtOYW1lEiEKDHBob25lX251bWJlchgJIAEoCVILcGhvbmVOdW1iZXI=');
@$core.Deprecated('Use initiateInternationalTransferRequestDescriptor instead')
const InitiateInternationalTransferRequest$json = const {
  '1': 'InitiateInternationalTransferRequest',
  '2': const [
    const {'1': 'source_account_id', '3': 1, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'source_currency', '3': 3, '4': 1, '5': 9, '10': 'sourceCurrency'},
    const {'1': 'destination_currency', '3': 4, '4': 1, '5': 9, '10': 'destinationCurrency'},
    const {'1': 'destination_country', '3': 5, '4': 1, '5': 9, '10': 'destinationCountry'},
    const {'1': 'recipient_type', '3': 6, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'recipient_details', '3': 7, '4': 3, '5': 11, '6': '.payments.InitiateInternationalTransferRequest.RecipientDetailsEntry', '10': 'recipientDetails'},
    const {'1': 'narration', '3': 8, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 11, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 12, '4': 1, '5': 9, '10': 'transactionId'},
  ],
  '3': const [InitiateInternationalTransferRequest_RecipientDetailsEntry$json],
};

@$core.Deprecated('Use initiateInternationalTransferRequestDescriptor instead')
const InitiateInternationalTransferRequest_RecipientDetailsEntry$json = const {
  '1': 'RecipientDetailsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `InitiateInternationalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferRequestDescriptor = $convert.base64Decode('CiRJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlcXVlc3QSKgoRc291cmNlX2FjY291bnRfaWQYASABKAlSD3NvdXJjZUFjY291bnRJZBIWCgZhbW91bnQYAiABKANSBmFtb3VudBInCg9zb3VyY2VfY3VycmVuY3kYAyABKAlSDnNvdXJjZUN1cnJlbmN5EjEKFGRlc3RpbmF0aW9uX2N1cnJlbmN5GAQgASgJUhNkZXN0aW5hdGlvbkN1cnJlbmN5Ei8KE2Rlc3RpbmF0aW9uX2NvdW50cnkYBSABKAlSEmRlc3RpbmF0aW9uQ291bnRyeRIlCg5yZWNpcGllbnRfdHlwZRgGIAEoCVINcmVjaXBpZW50VHlwZRJxChFyZWNpcGllbnRfZGV0YWlscxgHIAMoCzJELnBheW1lbnRzLkluaXRpYXRlSW50ZXJuYXRpb25hbFRyYW5zZmVyUmVxdWVzdC5SZWNpcGllbnREZXRhaWxzRW50cnlSEHJlY2lwaWVudERldGFpbHMSHAoJbmFycmF0aW9uGAggASgJUgluYXJyYXRpb24SHAoJcmVmZXJlbmNlGAkgASgJUglyZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAogASgJUg5pZGVtcG90ZW5jeUtleRItChJ2ZXJpZmljYXRpb25fdG9rZW4YCyABKAlSEXZlcmlmaWNhdGlvblRva2VuEiUKDnRyYW5zYWN0aW9uX2lkGAwgASgJUg10cmFuc2FjdGlvbklkGkMKFVJlY2lwaWVudERldGFpbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use initiateUserTransferRequestDescriptor instead')
const InitiateUserTransferRequest$json = const {
  '1': 'InitiateUserTransferRequest',
  '2': const [
    const {'1': 'recipient', '3': 1, '4': 1, '5': 9, '10': 'recipient'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'narration', '3': 4, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `InitiateUserTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateUserTransferRequestDescriptor = $convert.base64Decode('ChtJbml0aWF0ZVVzZXJUcmFuc2ZlclJlcXVlc3QSHAoJcmVjaXBpZW50GAEgASgJUglyZWNpcGllbnQSFgoGYW1vdW50GAIgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EhwKCW5hcnJhdGlvbhgEIAEoCVIJbmFycmF0aW9uEicKD2lkZW1wb3RlbmN5X2tleRgFIAEoCVIOaWRlbXBvdGVuY3lLZXkSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAYgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIlCg50cmFuc2FjdGlvbl9pZBgHIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use initiatePhoneTransferRequestDescriptor instead')
const InitiatePhoneTransferRequest$json = const {
  '1': 'InitiatePhoneTransferRequest',
  '2': const [
    const {'1': 'to_phone', '3': 1, '4': 1, '5': 9, '10': 'toPhone'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'narration', '3': 4, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `InitiatePhoneTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiatePhoneTransferRequestDescriptor = $convert.base64Decode('ChxJbml0aWF0ZVBob25lVHJhbnNmZXJSZXF1ZXN0EhkKCHRvX3Bob25lGAEgASgJUgd0b1Bob25lEhYKBmFtb3VudBgCIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIcCgluYXJyYXRpb24YBCABKAlSCW5hcnJhdGlvbhInCg9pZGVtcG90ZW5jeV9rZXkYBSABKAlSDmlkZW1wb3RlbmN5S2V5Ei0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJQoOdHJhbnNhY3Rpb25faWQYByABKAlSDXRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use initiateTransferResponseDescriptor instead')
const InitiateTransferResponse$json = const {
  '1': 'InitiateTransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transfer', '3': 4, '4': 1, '5': 11, '6': '.payments.TransferDetail', '10': 'transfer'},
  ],
};

/// Descriptor for `InitiateTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferResponseDescriptor = $convert.base64Decode('ChhJbml0aWF0ZVRyYW5zZmVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjQKCHRyYW5zZmVyGAQgASgLMhgucGF5bWVudHMuVHJhbnNmZXJEZXRhaWxSCHRyYW5zZmVy');
@$core.Deprecated('Use transferDetailDescriptor instead')
const TransferDetail$json = const {
  '1': 'TransferDetail',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'fee', '3': 7, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'destination_account', '3': 9, '4': 1, '5': 9, '10': 'destinationAccount'},
    const {'1': 'destination_bank_code', '3': 10, '4': 1, '5': 9, '10': 'destinationBankCode'},
    const {'1': 'destination_bank_name', '3': 11, '4': 1, '5': 9, '10': 'destinationBankName'},
    const {'1': 'destination_name', '3': 12, '4': 1, '5': 9, '10': 'destinationName'},
    const {'1': 'destination_country', '3': 13, '4': 1, '5': 9, '10': 'destinationCountry'},
    const {'1': 'reference', '3': 14, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'provider_ref', '3': 15, '4': 1, '5': 9, '10': 'providerRef'},
    const {'1': 'provider', '3': 16, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'narration', '3': 17, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'failure_reason', '3': 18, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'completed_at', '3': 20, '4': 1, '5': 9, '10': 'completedAt'},
    const {'1': 'scheduled_at', '3': 21, '4': 1, '5': 9, '10': 'scheduledAt'},
  ],
};

/// Descriptor for `TransferDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDetailDescriptor = $convert.base64Decode('Cg5UcmFuc2ZlckRldGFpbBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhIKBHR5cGUYAyABKAlSBHR5cGUSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSFgoGYW1vdW50GAUgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EhAKA2ZlZRgHIAEoA1IDZmVlEioKEXNvdXJjZV9hY2NvdW50X2lkGAggASgJUg9zb3VyY2VBY2NvdW50SWQSLwoTZGVzdGluYXRpb25fYWNjb3VudBgJIAEoCVISZGVzdGluYXRpb25BY2NvdW50EjIKFWRlc3RpbmF0aW9uX2JhbmtfY29kZRgKIAEoCVITZGVzdGluYXRpb25CYW5rQ29kZRIyChVkZXN0aW5hdGlvbl9iYW5rX25hbWUYCyABKAlSE2Rlc3RpbmF0aW9uQmFua05hbWUSKQoQZGVzdGluYXRpb25fbmFtZRgMIAEoCVIPZGVzdGluYXRpb25OYW1lEi8KE2Rlc3RpbmF0aW9uX2NvdW50cnkYDSABKAlSEmRlc3RpbmF0aW9uQ291bnRyeRIcCglyZWZlcmVuY2UYDiABKAlSCXJlZmVyZW5jZRIhCgxwcm92aWRlcl9yZWYYDyABKAlSC3Byb3ZpZGVyUmVmEhoKCHByb3ZpZGVyGBAgASgJUghwcm92aWRlchIcCgluYXJyYXRpb24YESABKAlSCW5hcnJhdGlvbhIlCg5mYWlsdXJlX3JlYXNvbhgSIAEoCVINZmFpbHVyZVJlYXNvbhIdCgpjcmVhdGVkX2F0GBMgASgJUgljcmVhdGVkQXQSIQoMY29tcGxldGVkX2F0GBQgASgJUgtjb21wbGV0ZWRBdBIhCgxzY2hlZHVsZWRfYXQYFSABKAlSC3NjaGVkdWxlZEF0');
@$core.Deprecated('Use getTransferStatusRequestDescriptor instead')
const GetTransferStatusRequest$json = const {
  '1': 'GetTransferStatusRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GetTransferStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferStatusRequestDescriptor = $convert.base64Decode('ChhHZXRUcmFuc2ZlclN0YXR1c1JlcXVlc3QSHAoJcmVmZXJlbmNlGAEgASgJUglyZWZlcmVuY2U=');
@$core.Deprecated('Use getTransferStatusResponseDescriptor instead')
const GetTransferStatusResponse$json = const {
  '1': 'GetTransferStatusResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transfer', '3': 4, '4': 1, '5': 11, '6': '.payments.TransferDetail', '10': 'transfer'},
  ],
};

/// Descriptor for `GetTransferStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferStatusResponseDescriptor = $convert.base64Decode('ChlHZXRUcmFuc2ZlclN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRI0Cgh0cmFuc2ZlchgEIAEoCzIYLnBheW1lbnRzLlRyYW5zZmVyRGV0YWlsUgh0cmFuc2Zlcg==');
@$core.Deprecated('Use cancelScheduledTransferRequestDescriptor instead')
const CancelScheduledTransferRequest$json = const {
  '1': 'CancelScheduledTransferRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `CancelScheduledTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelScheduledTransferRequestDescriptor = $convert.base64Decode('Ch5DYW5jZWxTY2hlZHVsZWRUcmFuc2ZlclJlcXVlc3QSHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudElk');
@$core.Deprecated('Use cancelScheduledTransferResponseDescriptor instead')
const CancelScheduledTransferResponse$json = const {
  '1': 'CancelScheduledTransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_message', '3': 2, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `CancelScheduledTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelScheduledTransferResponseDescriptor = $convert.base64Decode('Ch9DYW5jZWxTY2hlZHVsZWRUcmFuc2ZlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIwoNZXJyb3JfbWVzc2FnZRgCIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use getUserTransfersRequestDescriptor instead')
const GetUserTransfersRequest$json = const {
  '1': 'GetUserTransfersRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'transfer_type', '3': 3, '4': 1, '5': 9, '10': 'transferType'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetUserTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserTransfersRequestDescriptor = $convert.base64Decode('ChdHZXRVc2VyVHJhbnNmZXJzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAIgASgFUgZvZmZzZXQSIwoNdHJhbnNmZXJfdHlwZRgDIAEoCVIMdHJhbnNmZXJUeXBlEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use getUserTransfersResponseDescriptor instead')
const GetUserTransfersResponse$json = const {
  '1': 'GetUserTransfersResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transfers', '3': 4, '4': 3, '5': 11, '6': '.payments.TransferDetail', '10': 'transfers'},
    const {'1': 'total', '3': 5, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetUserTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserTransfersResponseDescriptor = $convert.base64Decode('ChhHZXRVc2VyVHJhbnNmZXJzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjYKCXRyYW5zZmVycxgEIAMoCzIYLnBheW1lbnRzLlRyYW5zZmVyRGV0YWlsUgl0cmFuc2ZlcnMSFAoFdG90YWwYBSABKAVSBXRvdGFs');
@$core.Deprecated('Use getTransferFeeRequestDescriptor instead')
const GetTransferFeeRequest$json = const {
  '1': 'GetTransferFeeRequest',
  '2': const [
    const {'1': 'transfer_type', '3': 1, '4': 1, '5': 9, '10': 'transferType'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'destination_country', '3': 4, '4': 1, '5': 9, '10': 'destinationCountry'},
  ],
};

/// Descriptor for `GetTransferFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferFeeRequestDescriptor = $convert.base64Decode('ChVHZXRUcmFuc2ZlckZlZVJlcXVlc3QSIwoNdHJhbnNmZXJfdHlwZRgBIAEoCVIMdHJhbnNmZXJUeXBlEhYKBmFtb3VudBgCIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIvChNkZXN0aW5hdGlvbl9jb3VudHJ5GAQgASgJUhJkZXN0aW5hdGlvbkNvdW50cnk=');
@$core.Deprecated('Use getTransferFeeResponseDescriptor instead')
const GetTransferFeeResponse$json = const {
  '1': 'GetTransferFeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'fee', '3': 4, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetTransferFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferFeeResponseDescriptor = $convert.base64Decode('ChZHZXRUcmFuc2ZlckZlZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIQCgNmZWUYBCABKANSA2ZlZRIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use getDailyUsageRequestDescriptor instead')
const GetDailyUsageRequest$json = const {
  '1': 'GetDailyUsageRequest',
};

/// Descriptor for `GetDailyUsageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDailyUsageRequestDescriptor = $convert.base64Decode('ChRHZXREYWlseVVzYWdlUmVxdWVzdA==');
@$core.Deprecated('Use getDailyUsageResponseDescriptor instead')
const GetDailyUsageResponse$json = const {
  '1': 'GetDailyUsageResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'total_transferred', '3': 4, '4': 1, '5': 3, '10': 'totalTransferred'},
    const {'1': 'transfer_count', '3': 5, '4': 1, '5': 5, '10': 'transferCount'},
    const {'1': 'daily_limit', '3': 6, '4': 1, '5': 3, '10': 'dailyLimit'},
    const {'1': 'remaining_limit', '3': 7, '4': 1, '5': 3, '10': 'remainingLimit'},
  ],
};

/// Descriptor for `GetDailyUsageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDailyUsageResponseDescriptor = $convert.base64Decode('ChVHZXREYWlseVVzYWdlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEisKEXRvdGFsX3RyYW5zZmVycmVkGAQgASgDUhB0b3RhbFRyYW5zZmVycmVkEiUKDnRyYW5zZmVyX2NvdW50GAUgASgFUg10cmFuc2ZlckNvdW50Eh8KC2RhaWx5X2xpbWl0GAYgASgDUgpkYWlseUxpbWl0EicKD3JlbWFpbmluZ19saW1pdBgHIAEoA1IOcmVtYWluaW5nTGltaXQ=');
@$core.Deprecated('Use getExchangeRateRequestDescriptor instead')
const GetExchangeRateRequest$json = const {
  '1': 'GetExchangeRateRequest',
  '2': const [
    const {'1': 'source_currency', '3': 1, '4': 1, '5': 9, '10': 'sourceCurrency'},
    const {'1': 'destination_currency', '3': 2, '4': 1, '5': 9, '10': 'destinationCurrency'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
  ],
};

/// Descriptor for `GetExchangeRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateRequestDescriptor = $convert.base64Decode('ChZHZXRFeGNoYW5nZVJhdGVSZXF1ZXN0EicKD3NvdXJjZV9jdXJyZW5jeRgBIAEoCVIOc291cmNlQ3VycmVuY3kSMQoUZGVzdGluYXRpb25fY3VycmVuY3kYAiABKAlSE2Rlc3RpbmF0aW9uQ3VycmVuY3kSFgoGYW1vdW50GAMgASgDUgZhbW91bnQ=');
@$core.Deprecated('Use getExchangeRateResponseDescriptor instead')
const GetExchangeRateResponse$json = const {
  '1': 'GetExchangeRateResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'source_currency', '3': 4, '4': 1, '5': 9, '10': 'sourceCurrency'},
    const {'1': 'destination_currency', '3': 5, '4': 1, '5': 9, '10': 'destinationCurrency'},
    const {'1': 'rate', '3': 6, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'fee', '3': 7, '4': 1, '5': 3, '10': 'fee'},
    const {'1': 'destination_amount', '3': 8, '4': 1, '5': 3, '10': 'destinationAmount'},
  ],
};

/// Descriptor for `GetExchangeRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateResponseDescriptor = $convert.base64Decode('ChdHZXRFeGNoYW5nZVJhdGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USJwoPc291cmNlX2N1cnJlbmN5GAQgASgJUg5zb3VyY2VDdXJyZW5jeRIxChRkZXN0aW5hdGlvbl9jdXJyZW5jeRgFIAEoCVITZGVzdGluYXRpb25DdXJyZW5jeRISCgRyYXRlGAYgASgBUgRyYXRlEhAKA2ZlZRgHIAEoA1IDZmVlEi0KEmRlc3RpbmF0aW9uX2Ftb3VudBgIIAEoA1IRZGVzdGluYXRpb25BbW91bnQ=');
@$core.Deprecated('Use handleTransferWebhookRequestDescriptor instead')
const HandleTransferWebhookRequest$json = const {
  '1': 'HandleTransferWebhookRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'payload', '3': 2, '4': 1, '5': 12, '10': 'payload'},
    const {'1': 'signature', '3': 3, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `HandleTransferWebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handleTransferWebhookRequestDescriptor = $convert.base64Decode('ChxIYW5kbGVUcmFuc2ZlcldlYmhvb2tSZXF1ZXN0EhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIYCgdwYXlsb2FkGAIgASgMUgdwYXlsb2FkEhwKCXNpZ25hdHVyZRgDIAEoCVIJc2lnbmF0dXJl');
@$core.Deprecated('Use handleTransferWebhookResponseDescriptor instead')
const HandleTransferWebhookResponse$json = const {
  '1': 'HandleTransferWebhookResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HandleTransferWebhookResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handleTransferWebhookResponseDescriptor = $convert.base64Decode('Ch1IYW5kbGVUcmFuc2ZlcldlYmhvb2tSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use payPlatformFeeRequestDescriptor instead')
const PayPlatformFeeRequest$json = const {
  '1': 'PayPlatformFeeRequest',
  '2': const [
    const {'1': 'user_account_id', '3': 1, '4': 1, '5': 9, '10': 'userAccountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 9, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 10, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'wallet_code', '3': 11, '4': 1, '5': 9, '10': 'walletCode'},
  ],
};

/// Descriptor for `PayPlatformFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payPlatformFeeRequestDescriptor = $convert.base64Decode('ChVQYXlQbGF0Zm9ybUZlZVJlcXVlc3QSJgoPdXNlcl9hY2NvdW50X2lkGAEgASgJUg11c2VyQWNjb3VudElkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIWCgZhbW91bnQYAyABKANSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGAYgASgJUgtkZXNjcmlwdGlvbhIcCglyZWZlcmVuY2UYByABKAlSCXJlZmVyZW5jZRInCg9pZGVtcG90ZW5jeV9rZXkYCCABKAlSDmlkZW1wb3RlbmN5S2V5Ei0KEnZlcmlmaWNhdGlvbl90b2tlbhgJIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJQoOdHJhbnNhY3Rpb25faWQYCiABKAlSDXRyYW5zYWN0aW9uSWQSHwoLd2FsbGV0X2NvZGUYCyABKAlSCndhbGxldENvZGU=');
@$core.Deprecated('Use payPlatformFeeResponseDescriptor instead')
const PayPlatformFeeResponse$json = const {
  '1': 'PayPlatformFeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'debit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'debitTransactionId'},
    const {'1': 'platform_transaction_id', '3': 5, '4': 1, '5': 9, '10': 'platformTransactionId'},
    const {'1': 'user_new_balance', '3': 6, '4': 1, '5': 3, '10': 'userNewBalance'},
    const {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `PayPlatformFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payPlatformFeeResponseDescriptor = $convert.base64Decode('ChZQYXlQbGF0Zm9ybUZlZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIwChRkZWJpdF90cmFuc2FjdGlvbl9pZBgEIAEoCVISZGViaXRUcmFuc2FjdGlvbklkEjYKF3BsYXRmb3JtX3RyYW5zYWN0aW9uX2lkGAUgASgJUhVwbGF0Zm9ybVRyYW5zYWN0aW9uSWQSKAoQdXNlcl9uZXdfYmFsYW5jZRgGIAEoA1IOdXNlck5ld0JhbGFuY2USHAoJcmVmZXJlbmNlGAcgASgJUglyZWZlcmVuY2U=');
@$core.Deprecated('Use refundFromPlatformWalletRequestDescriptor instead')
const RefundFromPlatformWalletRequest$json = const {
  '1': 'RefundFromPlatformWalletRequest',
  '2': const [
    const {'1': 'user_account_id', '3': 1, '4': 1, '5': 9, '10': 'userAccountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'wallet_code', '3': 9, '4': 1, '5': 9, '10': 'walletCode'},
  ],
};

/// Descriptor for `RefundFromPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refundFromPlatformWalletRequestDescriptor = $convert.base64Decode('Ch9SZWZ1bmRGcm9tUGxhdGZvcm1XYWxsZXRSZXF1ZXN0EiYKD3VzZXJfYWNjb3VudF9pZBgBIAEoCVINdXNlckFjY291bnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhoKCGNhdGVnb3J5GAUgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SHAoJcmVmZXJlbmNlGAcgASgJUglyZWZlcmVuY2USJwoPaWRlbXBvdGVuY3lfa2V5GAggASgJUg5pZGVtcG90ZW5jeUtleRIfCgt3YWxsZXRfY29kZRgJIAEoCVIKd2FsbGV0Q29kZQ==');
@$core.Deprecated('Use refundFromPlatformWalletResponseDescriptor instead')
const RefundFromPlatformWalletResponse$json = const {
  '1': 'RefundFromPlatformWalletResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'credit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'creditTransactionId'},
    const {'1': 'user_new_balance', '3': 5, '4': 1, '5': 3, '10': 'userNewBalance'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `RefundFromPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refundFromPlatformWalletResponseDescriptor = $convert.base64Decode('CiBSZWZ1bmRGcm9tUGxhdGZvcm1XYWxsZXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USMgoVY3JlZGl0X3RyYW5zYWN0aW9uX2lkGAQgASgJUhNjcmVkaXRUcmFuc2FjdGlvbklkEigKEHVzZXJfbmV3X2JhbGFuY2UYBSABKANSDnVzZXJOZXdCYWxhbmNlEhwKCXJlZmVyZW5jZRgGIAEoCVIJcmVmZXJlbmNl');
@$core.Deprecated('Use generateQRTokenRequestDescriptor instead')
const GenerateQRTokenRequest$json = const {
  '1': 'GenerateQRTokenRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'expiry_minutes', '3': 4, '4': 1, '5': 5, '10': 'expiryMinutes'},
  ],
};

/// Descriptor for `GenerateQRTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateQRTokenRequestDescriptor = $convert.base64Decode('ChZHZW5lcmF0ZVFSVG9rZW5SZXF1ZXN0EhYKBmFtb3VudBgBIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAIgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SJQoOZXhwaXJ5X21pbnV0ZXMYBCABKAVSDWV4cGlyeU1pbnV0ZXM=');
@$core.Deprecated('Use generateQRTokenResponseDescriptor instead')
const GenerateQRTokenResponse$json = const {
  '1': 'GenerateQRTokenResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'qr_token', '3': 4, '4': 1, '5': 9, '10': 'qrToken'},
    const {'1': 'qr_data', '3': 5, '4': 1, '5': 9, '10': 'qrData'},
    const {'1': 'expires_at', '3': 6, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `GenerateQRTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateQRTokenResponseDescriptor = $convert.base64Decode('ChdHZW5lcmF0ZVFSVG9rZW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USGQoIcXJfdG9rZW4YBCABKAlSB3FyVG9rZW4SFwoHcXJfZGF0YRgFIAEoCVIGcXJEYXRhEh0KCmV4cGlyZXNfYXQYBiABKAlSCWV4cGlyZXNBdA==');
@$core.Deprecated('Use validateQRTokenRequestDescriptor instead')
const ValidateQRTokenRequest$json = const {
  '1': 'ValidateQRTokenRequest',
  '2': const [
    const {'1': 'qr_token', '3': 1, '4': 1, '5': 9, '10': 'qrToken'},
  ],
};

/// Descriptor for `ValidateQRTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateQRTokenRequestDescriptor = $convert.base64Decode('ChZWYWxpZGF0ZVFSVG9rZW5SZXF1ZXN0EhkKCHFyX3Rva2VuGAEgASgJUgdxclRva2Vu');
@$core.Deprecated('Use validateQRTokenResponseDescriptor instead')
const ValidateQRTokenResponse$json = const {
  '1': 'ValidateQRTokenResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'recipient_user_id', '3': 4, '4': 1, '5': 9, '10': 'recipientUserId'},
    const {'1': 'recipient_username', '3': 5, '4': 1, '5': 9, '10': 'recipientUsername'},
    const {'1': 'recipient_name', '3': 6, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'recipient_account_id', '3': 7, '4': 1, '5': 9, '10': 'recipientAccountId'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_expired', '3': 10, '4': 1, '5': 8, '10': 'isExpired'},
  ],
};

/// Descriptor for `ValidateQRTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateQRTokenResponseDescriptor = $convert.base64Decode('ChdWYWxpZGF0ZVFSVG9rZW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USKgoRcmVjaXBpZW50X3VzZXJfaWQYBCABKAlSD3JlY2lwaWVudFVzZXJJZBItChJyZWNpcGllbnRfdXNlcm5hbWUYBSABKAlSEXJlY2lwaWVudFVzZXJuYW1lEiUKDnJlY2lwaWVudF9uYW1lGAYgASgJUg1yZWNpcGllbnROYW1lEjAKFHJlY2lwaWVudF9hY2NvdW50X2lkGAcgASgJUhJyZWNpcGllbnRBY2NvdW50SWQSFgoGYW1vdW50GAggASgDUgZhbW91bnQSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5Eh0KCmlzX2V4cGlyZWQYCiABKAhSCWlzRXhwaXJlZA==');
@$core.Deprecated('Use getBatchTransfersRequestDescriptor instead')
const GetBatchTransfersRequest$json = const {
  '1': 'GetBatchTransfersRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetBatchTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchTransfersRequestDescriptor = $convert.base64Decode('ChhHZXRCYXRjaFRyYW5zZmVyc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXpl');
@$core.Deprecated('Use batchTransferSummaryDescriptor instead')
const BatchTransferSummary$json = const {
  '1': 'BatchTransferSummary',
  '2': const [
    const {'1': 'batch_id', '3': 1, '4': 1, '5': 9, '10': 'batchId'},
    const {'1': 'total_recipients', '3': 2, '4': 1, '5': 5, '10': 'totalRecipients'},
    const {'1': 'successful', '3': 3, '4': 1, '5': 5, '10': 'successful'},
    const {'1': 'failed', '3': 4, '4': 1, '5': 5, '10': 'failed'},
    const {'1': 'total_amount', '3': 5, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'total_fees', '3': 6, '4': 1, '5': 1, '10': 'totalFees'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `BatchTransferSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchTransferSummaryDescriptor = $convert.base64Decode('ChRCYXRjaFRyYW5zZmVyU3VtbWFyeRIZCghiYXRjaF9pZBgBIAEoCVIHYmF0Y2hJZBIpChB0b3RhbF9yZWNpcGllbnRzGAIgASgFUg90b3RhbFJlY2lwaWVudHMSHgoKc3VjY2Vzc2Z1bBgDIAEoBVIKc3VjY2Vzc2Z1bBIWCgZmYWlsZWQYBCABKAVSBmZhaWxlZBIhCgx0b3RhbF9hbW91bnQYBSABKAFSC3RvdGFsQW1vdW50Eh0KCnRvdGFsX2ZlZXMYBiABKAFSCXRvdGFsRmVlcxIWCgZzdGF0dXMYByABKAlSBnN0YXR1cxIdCgpjcmVhdGVkX2F0GAggASgJUgljcmVhdGVkQXQSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use getBatchTransfersResponseDescriptor instead')
const GetBatchTransfersResponse$json = const {
  '1': 'GetBatchTransfersResponse',
  '2': const [
    const {'1': 'batches', '3': 1, '4': 3, '5': 11, '6': '.payments.BatchTransferSummary', '10': 'batches'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetBatchTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchTransfersResponseDescriptor = $convert.base64Decode('ChlHZXRCYXRjaFRyYW5zZmVyc1Jlc3BvbnNlEjgKB2JhdGNoZXMYASADKAsyHi5wYXltZW50cy5CYXRjaFRyYW5zZmVyU3VtbWFyeVIHYmF0Y2hlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYBCABKAVSCHBhZ2VTaXpl');
@$core.Deprecated('Use getBatchTransferDetailRequestDescriptor instead')
const GetBatchTransferDetailRequest$json = const {
  '1': 'GetBatchTransferDetailRequest',
  '2': const [
    const {'1': 'batch_id', '3': 1, '4': 1, '5': 9, '10': 'batchId'},
  ],
};

/// Descriptor for `GetBatchTransferDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchTransferDetailRequestDescriptor = $convert.base64Decode('Ch1HZXRCYXRjaFRyYW5zZmVyRGV0YWlsUmVxdWVzdBIZCghiYXRjaF9pZBgBIAEoCVIHYmF0Y2hJZA==');
@$core.Deprecated('Use getBatchTransferDetailResponseDescriptor instead')
const GetBatchTransferDetailResponse$json = const {
  '1': 'GetBatchTransferDetailResponse',
  '2': const [
    const {'1': 'summary', '3': 1, '4': 1, '5': 11, '6': '.payments.BatchTransferSummary', '10': 'summary'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.payments.BatchTransferResultItem', '10': 'items'},
    const {'1': 'source_account_number', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountNumber'},
    const {'1': 'source_account_name', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountName'},
  ],
};

/// Descriptor for `GetBatchTransferDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchTransferDetailResponseDescriptor = $convert.base64Decode('Ch5HZXRCYXRjaFRyYW5zZmVyRGV0YWlsUmVzcG9uc2USOAoHc3VtbWFyeRgBIAEoCzIeLnBheW1lbnRzLkJhdGNoVHJhbnNmZXJTdW1tYXJ5UgdzdW1tYXJ5EjcKBWl0ZW1zGAIgAygLMiEucGF5bWVudHMuQmF0Y2hUcmFuc2ZlclJlc3VsdEl0ZW1SBWl0ZW1zEjIKFXNvdXJjZV9hY2NvdW50X251bWJlchgDIAEoCVITc291cmNlQWNjb3VudE51bWJlchIuChNzb3VyY2VfYWNjb3VudF9uYW1lGAQgASgJUhFzb3VyY2VBY2NvdW50TmFtZQ==');
@$core.Deprecated('Use verifyMultiCountryIdentityRequestDescriptor instead')
const VerifyMultiCountryIdentityRequest$json = const {
  '1': 'VerifyMultiCountryIdentityRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'id_type', '3': 3, '4': 1, '5': 9, '10': 'idType'},
    const {'1': 'id_number', '3': 4, '4': 1, '5': 9, '10': 'idNumber'},
    const {'1': 'first_name', '3': 5, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 6, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'date_of_birth', '3': 7, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'phone_number', '3': 8, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyMultiCountryIdentityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyMultiCountryIdentityRequestDescriptor = $convert.base64Decode('CiFWZXJpZnlNdWx0aUNvdW50cnlJZGVudGl0eVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiEKDGNvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGUSFwoHaWRfdHlwZRgDIAEoCVIGaWRUeXBlEhsKCWlkX251bWJlchgEIAEoCVIIaWROdW1iZXISHQoKZmlyc3RfbmFtZRgFIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgGIAEoCVIIbGFzdE5hbWUSIgoNZGF0ZV9vZl9iaXJ0aBgHIAEoCVILZGF0ZU9mQmlydGgSIQoMcGhvbmVfbnVtYmVyGAggASgJUgtwaG9uZU51bWJlcg==');
@$core.Deprecated('Use verifyMultiCountryIdentityResponseDescriptor instead')
const VerifyMultiCountryIdentityResponse$json = const {
  '1': 'VerifyMultiCountryIdentityResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'verification_id', '3': 3, '4': 1, '5': 9, '10': 'verificationId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'session_url', '3': 5, '4': 1, '5': 9, '10': 'sessionUrl'},
    const {'1': 'session_token', '3': 6, '4': 1, '5': 9, '10': 'sessionToken'},
    const {'1': 'error_code', '3': 7, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 8, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'provider', '3': 9, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'verified_identity', '3': 10, '4': 1, '5': 11, '6': '.payments.VerifiedIdentityInfo', '10': 'verifiedIdentity'},
  ],
};

/// Descriptor for `VerifyMultiCountryIdentityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyMultiCountryIdentityResponseDescriptor = $convert.base64Decode('CiJWZXJpZnlNdWx0aUNvdW50cnlJZGVudGl0eVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGgoIdmVyaWZpZWQYAiABKAhSCHZlcmlmaWVkEicKD3ZlcmlmaWNhdGlvbl9pZBgDIAEoCVIOdmVyaWZpY2F0aW9uSWQSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSHwoLc2Vzc2lvbl91cmwYBSABKAlSCnNlc3Npb25VcmwSIwoNc2Vzc2lvbl90b2tlbhgGIAEoCVIMc2Vzc2lvblRva2VuEh0KCmVycm9yX2NvZGUYByABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAggASgJUgxlcnJvck1lc3NhZ2USGgoIcHJvdmlkZXIYCSABKAlSCHByb3ZpZGVyEksKEXZlcmlmaWVkX2lkZW50aXR5GAogASgLMh4ucGF5bWVudHMuVmVyaWZpZWRJZGVudGl0eUluZm9SEHZlcmlmaWVkSWRlbnRpdHk=');
@$core.Deprecated('Use verifiedIdentityInfoDescriptor instead')
const VerifiedIdentityInfo$json = const {
  '1': 'VerifiedIdentityInfo',
  '2': const [
    const {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'middle_name', '3': 3, '4': 1, '5': 9, '10': 'middleName'},
    const {'1': 'date_of_birth', '3': 4, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'gender', '3': 5, '4': 1, '5': 9, '10': 'gender'},
    const {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'photo_url', '3': 7, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'address', '3': 8, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `VerifiedIdentityInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifiedIdentityInfoDescriptor = $convert.base64Decode('ChRWZXJpZmllZElkZW50aXR5SW5mbxIdCgpmaXJzdF9uYW1lGAEgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAIgASgJUghsYXN0TmFtZRIfCgttaWRkbGVfbmFtZRgDIAEoCVIKbWlkZGxlTmFtZRIiCg1kYXRlX29mX2JpcnRoGAQgASgJUgtkYXRlT2ZCaXJ0aBIWCgZnZW5kZXIYBSABKAlSBmdlbmRlchIhCgxwaG9uZV9udW1iZXIYBiABKAlSC3Bob25lTnVtYmVyEhsKCXBob3RvX3VybBgHIAEoCVIIcGhvdG9VcmwSGAoHYWRkcmVzcxgIIAEoCVIHYWRkcmVzcw==');
@$core.Deprecated('Use getKYCVerificationStatusRequestDescriptor instead')
const GetKYCVerificationStatusRequest$json = const {
  '1': 'GetKYCVerificationStatusRequest',
  '2': const [
    const {'1': 'verification_id', '3': 1, '4': 1, '5': 9, '10': 'verificationId'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `GetKYCVerificationStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCVerificationStatusRequestDescriptor = $convert.base64Decode('Ch9HZXRLWUNWZXJpZmljYXRpb25TdGF0dXNSZXF1ZXN0EicKD3ZlcmlmaWNhdGlvbl9pZBgBIAEoCVIOdmVyaWZpY2F0aW9uSWQSGgoIcHJvdmlkZXIYAiABKAlSCHByb3ZpZGVy');
@$core.Deprecated('Use getKYCVerificationStatusResponseDescriptor instead')
const GetKYCVerificationStatusResponse$json = const {
  '1': 'GetKYCVerificationStatusResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'verified', '3': 3, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'identity', '3': 5, '4': 1, '5': 11, '6': '.payments.VerifiedIdentityInfo', '10': 'identity'},
  ],
};

/// Descriptor for `GetKYCVerificationStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCVerificationStatusResponseDescriptor = $convert.base64Decode('CiBHZXRLWUNWZXJpZmljYXRpb25TdGF0dXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhoKCHZlcmlmaWVkGAMgASgIUgh2ZXJpZmllZBIjCg1lcnJvcl9tZXNzYWdlGAQgASgJUgxlcnJvck1lc3NhZ2USOgoIaWRlbnRpdHkYBSABKAsyHi5wYXltZW50cy5WZXJpZmllZElkZW50aXR5SW5mb1IIaWRlbnRpdHk=');
@$core.Deprecated('Use recurringTransferDetailDescriptor instead')
const RecurringTransferDetail$json = const {
  '1': 'RecurringTransferDetail',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'recipient_account_number', '3': 4, '4': 1, '5': 9, '10': 'recipientAccountNumber'},
    const {'1': 'recipient_name', '3': 5, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'recipient_bank_code', '3': 6, '4': 1, '5': 9, '10': 'recipientBankCode'},
    const {'1': 'recipient_bank_name', '3': 7, '4': 1, '5': 9, '10': 'recipientBankName'},
    const {'1': 'transfer_type', '3': 8, '4': 1, '5': 9, '10': 'transferType'},
    const {'1': 'amount', '3': 9, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'frequency', '3': 12, '4': 1, '5': 14, '6': '.payments.RecurringFrequency', '10': 'frequency'},
    const {'1': 'schedule_day', '3': 13, '4': 1, '5': 5, '10': 'scheduleDay'},
    const {'1': 'schedule_time', '3': 14, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'status', '3': 15, '4': 1, '5': 14, '6': '.payments.RecurringTransferStatus', '10': 'status'},
    const {'1': 'start_date', '3': 16, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 17, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'next_run_at', '3': 18, '4': 1, '5': 9, '10': 'nextRunAt'},
    const {'1': 'total_executions', '3': 19, '4': 1, '5': 5, '10': 'totalExecutions'},
    const {'1': 'successful_executions', '3': 20, '4': 1, '5': 5, '10': 'successfulExecutions'},
    const {'1': 'failed_executions', '3': 21, '4': 1, '5': 5, '10': 'failedExecutions'},
    const {'1': 'consecutive_failures', '3': 22, '4': 1, '5': 5, '10': 'consecutiveFailures'},
    const {'1': 'last_executed_at', '3': 23, '4': 1, '5': 9, '10': 'lastExecutedAt'},
    const {'1': 'last_failure_reason', '3': 24, '4': 1, '5': 9, '10': 'lastFailureReason'},
    const {'1': 'created_at', '3': 25, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 26, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `RecurringTransferDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringTransferDetailDescriptor = $convert.base64Decode('ChdSZWN1cnJpbmdUcmFuc2ZlckRldGFpbBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBI4ChhyZWNpcGllbnRfYWNjb3VudF9udW1iZXIYBCABKAlSFnJlY2lwaWVudEFjY291bnROdW1iZXISJQoOcmVjaXBpZW50X25hbWUYBSABKAlSDXJlY2lwaWVudE5hbWUSLgoTcmVjaXBpZW50X2JhbmtfY29kZRgGIAEoCVIRcmVjaXBpZW50QmFua0NvZGUSLgoTcmVjaXBpZW50X2JhbmtfbmFtZRgHIAEoCVIRcmVjaXBpZW50QmFua05hbWUSIwoNdHJhbnNmZXJfdHlwZRgIIAEoCVIMdHJhbnNmZXJUeXBlEhYKBmFtb3VudBgJIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAogASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgLIAEoCVILZGVzY3JpcHRpb24SOgoJZnJlcXVlbmN5GAwgASgOMhwucGF5bWVudHMuUmVjdXJyaW5nRnJlcXVlbmN5UglmcmVxdWVuY3kSIQoMc2NoZWR1bGVfZGF5GA0gASgFUgtzY2hlZHVsZURheRIjCg1zY2hlZHVsZV90aW1lGA4gASgJUgxzY2hlZHVsZVRpbWUSOQoGc3RhdHVzGA8gASgOMiEucGF5bWVudHMuUmVjdXJyaW5nVHJhbnNmZXJTdGF0dXNSBnN0YXR1cxIdCgpzdGFydF9kYXRlGBAgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYESABKAlSB2VuZERhdGUSHgoLbmV4dF9ydW5fYXQYEiABKAlSCW5leHRSdW5BdBIpChB0b3RhbF9leGVjdXRpb25zGBMgASgFUg90b3RhbEV4ZWN1dGlvbnMSMwoVc3VjY2Vzc2Z1bF9leGVjdXRpb25zGBQgASgFUhRzdWNjZXNzZnVsRXhlY3V0aW9ucxIrChFmYWlsZWRfZXhlY3V0aW9ucxgVIAEoBVIQZmFpbGVkRXhlY3V0aW9ucxIxChRjb25zZWN1dGl2ZV9mYWlsdXJlcxgWIAEoBVITY29uc2VjdXRpdmVGYWlsdXJlcxIoChBsYXN0X2V4ZWN1dGVkX2F0GBcgASgJUg5sYXN0RXhlY3V0ZWRBdBIuChNsYXN0X2ZhaWx1cmVfcmVhc29uGBggASgJUhFsYXN0RmFpbHVyZVJlYXNvbhIdCgpjcmVhdGVkX2F0GBkgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgaIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use recurringTransferExecutionDetailDescriptor instead')
const RecurringTransferExecutionDetail$json = const {
  '1': 'RecurringTransferExecutionDetail',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'recurring_transfer_id', '3': 2, '4': 1, '5': 9, '10': 'recurringTransferId'},
    const {'1': 'payment_id', '3': 3, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'fee', '3': 7, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'failure_reason', '3': 9, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'scheduled_for', '3': 10, '4': 1, '5': 9, '10': 'scheduledFor'},
    const {'1': 'executed_at', '3': 11, '4': 1, '5': 9, '10': 'executedAt'},
  ],
};

/// Descriptor for `RecurringTransferExecutionDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringTransferExecutionDetailDescriptor = $convert.base64Decode('CiBSZWN1cnJpbmdUcmFuc2ZlckV4ZWN1dGlvbkRldGFpbBIOCgJpZBgBIAEoCVICaWQSMgoVcmVjdXJyaW5nX3RyYW5zZmVyX2lkGAIgASgJUhNyZWN1cnJpbmdUcmFuc2ZlcklkEh0KCnBheW1lbnRfaWQYAyABKAlSCXBheW1lbnRJZBIcCglyZWZlcmVuY2UYBCABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYBSABKAlSBnN0YXR1cxIWCgZhbW91bnQYBiABKAFSBmFtb3VudBIQCgNmZWUYByABKAFSA2ZlZRIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3kSJQoOZmFpbHVyZV9yZWFzb24YCSABKAlSDWZhaWx1cmVSZWFzb24SIwoNc2NoZWR1bGVkX2ZvchgKIAEoCVIMc2NoZWR1bGVkRm9yEh8KC2V4ZWN1dGVkX2F0GAsgASgJUgpleGVjdXRlZEF0');
@$core.Deprecated('Use createRecurringTransferRequestDescriptor instead')
const CreateRecurringTransferRequest$json = const {
  '1': 'CreateRecurringTransferRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'to_account_number', '3': 2, '4': 1, '5': 9, '10': 'toAccountNumber'},
    const {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'recipient_bank_code', '3': 4, '4': 1, '5': 9, '10': 'recipientBankCode'},
    const {'1': 'recipient_bank_name', '3': 5, '4': 1, '5': 9, '10': 'recipientBankName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'frequency', '3': 8, '4': 1, '5': 14, '6': '.payments.RecurringFrequency', '10': 'frequency'},
    const {'1': 'schedule_day', '3': 9, '4': 1, '5': 5, '10': 'scheduleDay'},
    const {'1': 'schedule_time', '3': 10, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'end_date', '3': 11, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'transaction_id', '3': 12, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 13, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `CreateRecurringTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecurringTransferRequestDescriptor = $convert.base64Decode('Ch5DcmVhdGVSZWN1cnJpbmdUcmFuc2ZlclJlcXVlc3QSJgoPZnJvbV9hY2NvdW50X2lkGAEgASgJUg1mcm9tQWNjb3VudElkEioKEXRvX2FjY291bnRfbnVtYmVyGAIgASgJUg90b0FjY291bnROdW1iZXISJQoOcmVjaXBpZW50X25hbWUYAyABKAlSDXJlY2lwaWVudE5hbWUSLgoTcmVjaXBpZW50X2JhbmtfY29kZRgEIAEoCVIRcmVjaXBpZW50QmFua0NvZGUSLgoTcmVjaXBpZW50X2JhbmtfbmFtZRgFIAEoCVIRcmVjaXBpZW50QmFua05hbWUSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSIAoLZGVzY3JpcHRpb24YByABKAlSC2Rlc2NyaXB0aW9uEjoKCWZyZXF1ZW5jeRgIIAEoDjIcLnBheW1lbnRzLlJlY3VycmluZ0ZyZXF1ZW5jeVIJZnJlcXVlbmN5EiEKDHNjaGVkdWxlX2RheRgJIAEoBVILc2NoZWR1bGVEYXkSIwoNc2NoZWR1bGVfdGltZRgKIAEoCVIMc2NoZWR1bGVUaW1lEhkKCGVuZF9kYXRlGAsgASgJUgdlbmREYXRlEiUKDnRyYW5zYWN0aW9uX2lkGAwgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgNIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');
@$core.Deprecated('Use createRecurringTransferResponseDescriptor instead')
const CreateRecurringTransferResponse$json = const {
  '1': 'CreateRecurringTransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'recurring_transfer', '3': 4, '4': 1, '5': 11, '6': '.payments.RecurringTransferDetail', '10': 'recurringTransfer'},
  ],
};

/// Descriptor for `CreateRecurringTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecurringTransferResponseDescriptor = $convert.base64Decode('Ch9DcmVhdGVSZWN1cnJpbmdUcmFuc2ZlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRJQChJyZWN1cnJpbmdfdHJhbnNmZXIYBCABKAsyIS5wYXltZW50cy5SZWN1cnJpbmdUcmFuc2ZlckRldGFpbFIRcmVjdXJyaW5nVHJhbnNmZXI=');
@$core.Deprecated('Use getRecurringTransfersRequestDescriptor instead')
const GetRecurringTransfersRequest$json = const {
  '1': 'GetRecurringTransfersRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetRecurringTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringTransfersRequestDescriptor = $convert.base64Decode('ChxHZXRSZWN1cnJpbmdUcmFuc2ZlcnNSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIWCgZvZmZzZXQYAiABKAVSBm9mZnNldBIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cw==');
@$core.Deprecated('Use getRecurringTransfersResponseDescriptor instead')
const GetRecurringTransfersResponse$json = const {
  '1': 'GetRecurringTransfersResponse',
  '2': const [
    const {'1': 'recurring_transfers', '3': 1, '4': 3, '5': 11, '6': '.payments.RecurringTransferDetail', '10': 'recurringTransfers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetRecurringTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringTransfersResponseDescriptor = $convert.base64Decode('Ch1HZXRSZWN1cnJpbmdUcmFuc2ZlcnNSZXNwb25zZRJSChNyZWN1cnJpbmdfdHJhbnNmZXJzGAEgAygLMiEucGF5bWVudHMuUmVjdXJyaW5nVHJhbnNmZXJEZXRhaWxSEnJlY3VycmluZ1RyYW5zZmVycxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use getRecurringTransferRequestDescriptor instead')
const GetRecurringTransferRequest$json = const {
  '1': 'GetRecurringTransferRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetRecurringTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringTransferRequestDescriptor = $convert.base64Decode('ChtHZXRSZWN1cnJpbmdUcmFuc2ZlclJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use getRecurringTransferResponseDescriptor instead')
const GetRecurringTransferResponse$json = const {
  '1': 'GetRecurringTransferResponse',
  '2': const [
    const {'1': 'recurring_transfer', '3': 1, '4': 1, '5': 11, '6': '.payments.RecurringTransferDetail', '10': 'recurringTransfer'},
  ],
};

/// Descriptor for `GetRecurringTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringTransferResponseDescriptor = $convert.base64Decode('ChxHZXRSZWN1cnJpbmdUcmFuc2ZlclJlc3BvbnNlElAKEnJlY3VycmluZ190cmFuc2ZlchgBIAEoCzIhLnBheW1lbnRzLlJlY3VycmluZ1RyYW5zZmVyRGV0YWlsUhFyZWN1cnJpbmdUcmFuc2Zlcg==');
@$core.Deprecated('Use updateRecurringTransferRequestDescriptor instead')
const UpdateRecurringTransferRequest$json = const {
  '1': 'UpdateRecurringTransferRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'schedule_time', '3': 4, '4': 1, '5': 9, '10': 'scheduleTime'},
    const {'1': 'end_date', '3': 5, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `UpdateRecurringTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecurringTransferRequestDescriptor = $convert.base64Decode('Ch5VcGRhdGVSZWN1cnJpbmdUcmFuc2ZlclJlcXVlc3QSDgoCaWQYASABKAlSAmlkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EiMKDXNjaGVkdWxlX3RpbWUYBCABKAlSDHNjaGVkdWxlVGltZRIZCghlbmRfZGF0ZRgFIAEoCVIHZW5kRGF0ZRIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24=');
@$core.Deprecated('Use updateRecurringTransferResponseDescriptor instead')
const UpdateRecurringTransferResponse$json = const {
  '1': 'UpdateRecurringTransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'recurring_transfer', '3': 4, '4': 1, '5': 11, '6': '.payments.RecurringTransferDetail', '10': 'recurringTransfer'},
  ],
};

/// Descriptor for `UpdateRecurringTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecurringTransferResponseDescriptor = $convert.base64Decode('Ch9VcGRhdGVSZWN1cnJpbmdUcmFuc2ZlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRJQChJyZWN1cnJpbmdfdHJhbnNmZXIYBCABKAsyIS5wYXltZW50cy5SZWN1cnJpbmdUcmFuc2ZlckRldGFpbFIRcmVjdXJyaW5nVHJhbnNmZXI=');
@$core.Deprecated('Use deleteRecurringTransferRequestDescriptor instead')
const DeleteRecurringTransferRequest$json = const {
  '1': 'DeleteRecurringTransferRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteRecurringTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRecurringTransferRequestDescriptor = $convert.base64Decode('Ch5EZWxldGVSZWN1cnJpbmdUcmFuc2ZlclJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use deleteRecurringTransferResponseDescriptor instead')
const DeleteRecurringTransferResponse$json = const {
  '1': 'DeleteRecurringTransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteRecurringTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRecurringTransferResponseDescriptor = $convert.base64Decode('Ch9EZWxldGVSZWN1cnJpbmdUcmFuc2ZlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getRecurringTransferExecutionsRequestDescriptor instead')
const GetRecurringTransferExecutionsRequest$json = const {
  '1': 'GetRecurringTransferExecutionsRequest',
  '2': const [
    const {'1': 'recurring_transfer_id', '3': 1, '4': 1, '5': 9, '10': 'recurringTransferId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetRecurringTransferExecutionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringTransferExecutionsRequestDescriptor = $convert.base64Decode('CiVHZXRSZWN1cnJpbmdUcmFuc2ZlckV4ZWN1dGlvbnNSZXF1ZXN0EjIKFXJlY3VycmluZ190cmFuc2Zlcl9pZBgBIAEoCVITcmVjdXJyaW5nVHJhbnNmZXJJZBIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getRecurringTransferExecutionsResponseDescriptor instead')
const GetRecurringTransferExecutionsResponse$json = const {
  '1': 'GetRecurringTransferExecutionsResponse',
  '2': const [
    const {'1': 'executions', '3': 1, '4': 3, '5': 11, '6': '.payments.RecurringTransferExecutionDetail', '10': 'executions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetRecurringTransferExecutionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringTransferExecutionsResponseDescriptor = $convert.base64Decode('CiZHZXRSZWN1cnJpbmdUcmFuc2ZlckV4ZWN1dGlvbnNSZXNwb25zZRJKCgpleGVjdXRpb25zGAEgAygLMioucGF5bWVudHMuUmVjdXJyaW5nVHJhbnNmZXJFeGVjdXRpb25EZXRhaWxSCmV4ZWN1dGlvbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getRecurringTransfersByRecipientRequestDescriptor instead')
const GetRecurringTransfersByRecipientRequest$json = const {
  '1': 'GetRecurringTransfersByRecipientRequest',
  '2': const [
    const {'1': 'recipient_account', '3': 1, '4': 1, '5': 9, '10': 'recipientAccount'},
  ],
};

/// Descriptor for `GetRecurringTransfersByRecipientRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringTransfersByRecipientRequestDescriptor = $convert.base64Decode('CidHZXRSZWN1cnJpbmdUcmFuc2ZlcnNCeVJlY2lwaWVudFJlcXVlc3QSKwoRcmVjaXBpZW50X2FjY291bnQYASABKAlSEHJlY2lwaWVudEFjY291bnQ=');
@$core.Deprecated('Use getRecurringTransfersByRecipientResponseDescriptor instead')
const GetRecurringTransfersByRecipientResponse$json = const {
  '1': 'GetRecurringTransfersByRecipientResponse',
  '2': const [
    const {'1': 'recurring_transfers', '3': 1, '4': 3, '5': 11, '6': '.payments.RecurringTransferDetail', '10': 'recurringTransfers'},
  ],
};

/// Descriptor for `GetRecurringTransfersByRecipientResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringTransfersByRecipientResponseDescriptor = $convert.base64Decode('CihHZXRSZWN1cnJpbmdUcmFuc2ZlcnNCeVJlY2lwaWVudFJlc3BvbnNlElIKE3JlY3VycmluZ190cmFuc2ZlcnMYASADKAsyIS5wYXltZW50cy5SZWN1cnJpbmdUcmFuc2ZlckRldGFpbFIScmVjdXJyaW5nVHJhbnNmZXJz');
@$core.Deprecated('Use adminRunReconciliationRequestDescriptor instead')
const AdminRunReconciliationRequest$json = const {
  '1': 'AdminRunReconciliationRequest',
  '2': const [
    const {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
  ],
};

/// Descriptor for `AdminRunReconciliationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRunReconciliationRequestDescriptor = $convert.base64Decode('Ch1BZG1pblJ1blJlY29uY2lsaWF0aW9uUmVxdWVzdBISCgRkYXRlGAEgASgJUgRkYXRl');
@$core.Deprecated('Use adminReconciliationResultDescriptor instead')
const AdminReconciliationResult$json = const {
  '1': 'AdminReconciliationResult',
  '2': const [
    const {'1': 'reconciliation_id', '3': 1, '4': 1, '5': 9, '10': 'reconciliationId'},
    const {'1': 'date', '3': 2, '4': 1, '5': 9, '10': 'date'},
    const {'1': 'total_ledger_balance', '3': 3, '4': 1, '5': 3, '10': 'totalLedgerBalance'},
    const {'1': 'pooled_account_balance', '3': 4, '4': 1, '5': 3, '10': 'pooledAccountBalance'},
    const {'1': 'discrepancy', '3': 5, '4': 1, '5': 3, '10': 'discrepancy'},
    const {'1': 'discrepancy_percent', '3': 6, '4': 1, '5': 1, '10': 'discrepancyPercent'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'expired_holds_released', '3': 8, '4': 1, '5': 5, '10': 'expiredHoldsReleased'},
    const {'1': 'stuck_transfers_fixed', '3': 9, '4': 1, '5': 5, '10': 'stuckTransfersFixed'},
    const {'1': 'stuck_deposits_fixed', '3': 10, '4': 1, '5': 5, '10': 'stuckDepositsFixed'},
    const {'1': 'errors', '3': 11, '4': 3, '5': 9, '10': 'errors'},
    const {'1': 'warnings', '3': 12, '4': 3, '5': 9, '10': 'warnings'},
  ],
};

/// Descriptor for `AdminReconciliationResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminReconciliationResultDescriptor = $convert.base64Decode('ChlBZG1pblJlY29uY2lsaWF0aW9uUmVzdWx0EisKEXJlY29uY2lsaWF0aW9uX2lkGAEgASgJUhByZWNvbmNpbGlhdGlvbklkEhIKBGRhdGUYAiABKAlSBGRhdGUSMAoUdG90YWxfbGVkZ2VyX2JhbGFuY2UYAyABKANSEnRvdGFsTGVkZ2VyQmFsYW5jZRI0ChZwb29sZWRfYWNjb3VudF9iYWxhbmNlGAQgASgDUhRwb29sZWRBY2NvdW50QmFsYW5jZRIgCgtkaXNjcmVwYW5jeRgFIAEoA1ILZGlzY3JlcGFuY3kSLwoTZGlzY3JlcGFuY3lfcGVyY2VudBgGIAEoAVISZGlzY3JlcGFuY3lQZXJjZW50EhYKBnN0YXR1cxgHIAEoCVIGc3RhdHVzEjQKFmV4cGlyZWRfaG9sZHNfcmVsZWFzZWQYCCABKAVSFGV4cGlyZWRIb2xkc1JlbGVhc2VkEjIKFXN0dWNrX3RyYW5zZmVyc19maXhlZBgJIAEoBVITc3R1Y2tUcmFuc2ZlcnNGaXhlZBIwChRzdHVja19kZXBvc2l0c19maXhlZBgKIAEoBVISc3R1Y2tEZXBvc2l0c0ZpeGVkEhYKBmVycm9ycxgLIAMoCVIGZXJyb3JzEhoKCHdhcm5pbmdzGAwgAygJUgh3YXJuaW5ncw==');
@$core.Deprecated('Use adminReconciliationHistoryRequestDescriptor instead')
const AdminReconciliationHistoryRequest$json = const {
  '1': 'AdminReconciliationHistoryRequest',
  '2': const [
    const {'1': 'days', '3': 1, '4': 1, '5': 5, '10': 'days'},
  ],
};

/// Descriptor for `AdminReconciliationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminReconciliationHistoryRequestDescriptor = $convert.base64Decode('CiFBZG1pblJlY29uY2lsaWF0aW9uSGlzdG9yeVJlcXVlc3QSEgoEZGF5cxgBIAEoBVIEZGF5cw==');
@$core.Deprecated('Use adminReconciliationHistoryResponseDescriptor instead')
const AdminReconciliationHistoryResponse$json = const {
  '1': 'AdminReconciliationHistoryResponse',
  '2': const [
    const {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.payments.AdminReconciliationResult', '10': 'results'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminReconciliationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminReconciliationHistoryResponseDescriptor = $convert.base64Decode('CiJBZG1pblJlY29uY2lsaWF0aW9uSGlzdG9yeVJlc3BvbnNlEj0KB3Jlc3VsdHMYASADKAsyIy5wYXltZW50cy5BZG1pblJlY29uY2lsaWF0aW9uUmVzdWx0UgdyZXN1bHRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use adminGetLastReconciliationRequestDescriptor instead')
const AdminGetLastReconciliationRequest$json = const {
  '1': 'AdminGetLastReconciliationRequest',
};

/// Descriptor for `AdminGetLastReconciliationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetLastReconciliationRequestDescriptor = $convert.base64Decode('CiFBZG1pbkdldExhc3RSZWNvbmNpbGlhdGlvblJlcXVlc3Q=');
@$core.Deprecated('Use adminGetWithdrawalHoldsSummaryRequestDescriptor instead')
const AdminGetWithdrawalHoldsSummaryRequest$json = const {
  '1': 'AdminGetWithdrawalHoldsSummaryRequest',
};

/// Descriptor for `AdminGetWithdrawalHoldsSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetWithdrawalHoldsSummaryRequestDescriptor = $convert.base64Decode('CiVBZG1pbkdldFdpdGhkcmF3YWxIb2xkc1N1bW1hcnlSZXF1ZXN0');
@$core.Deprecated('Use adminGetWithdrawalHoldsSummaryResponseDescriptor instead')
const AdminGetWithdrawalHoldsSummaryResponse$json = const {
  '1': 'AdminGetWithdrawalHoldsSummaryResponse',
  '2': const [
    const {'1': 'holds', '3': 1, '4': 3, '5': 11, '6': '.payments.WithdrawalHoldsByCurrency', '10': 'holds'},
  ],
};

/// Descriptor for `AdminGetWithdrawalHoldsSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetWithdrawalHoldsSummaryResponseDescriptor = $convert.base64Decode('CiZBZG1pbkdldFdpdGhkcmF3YWxIb2xkc1N1bW1hcnlSZXNwb25zZRI5CgVob2xkcxgBIAMoCzIjLnBheW1lbnRzLldpdGhkcmF3YWxIb2xkc0J5Q3VycmVuY3lSBWhvbGRz');
@$core.Deprecated('Use withdrawalHoldsByCurrencyDescriptor instead')
const WithdrawalHoldsByCurrency$json = const {
  '1': 'WithdrawalHoldsByCurrency',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'total', '3': 2, '4': 1, '5': 1, '10': 'total'},
    const {'1': 'hold_count', '3': 3, '4': 1, '5': 5, '10': 'holdCount'},
  ],
};

/// Descriptor for `WithdrawalHoldsByCurrency`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List withdrawalHoldsByCurrencyDescriptor = $convert.base64Decode('ChlXaXRoZHJhd2FsSG9sZHNCeUN1cnJlbmN5EhoKCGN1cnJlbmN5GAEgASgJUghjdXJyZW5jeRIUCgV0b3RhbBgCIAEoAVIFdG90YWwSHQoKaG9sZF9jb3VudBgDIAEoBVIJaG9sZENvdW50');
@$core.Deprecated('Use adminAutoResolveRequestDescriptor instead')
const AdminAutoResolveRequest$json = const {
  '1': 'AdminAutoResolveRequest',
  '2': const [
    const {'1': 'stale_threshold_minutes', '3': 1, '4': 1, '5': 5, '10': 'staleThresholdMinutes'},
    const {'1': 'dry_run', '3': 2, '4': 1, '5': 8, '10': 'dryRun'},
  ],
};

/// Descriptor for `AdminAutoResolveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAutoResolveRequestDescriptor = $convert.base64Decode('ChdBZG1pbkF1dG9SZXNvbHZlUmVxdWVzdBI2ChdzdGFsZV90aHJlc2hvbGRfbWludXRlcxgBIAEoBVIVc3RhbGVUaHJlc2hvbGRNaW51dGVzEhcKB2RyeV9ydW4YAiABKAhSBmRyeVJ1bg==');
@$core.Deprecated('Use adminAutoResolveResponseDescriptor instead')
const AdminAutoResolveResponse$json = const {
  '1': 'AdminAutoResolveResponse',
  '2': const [
    const {'1': 'total_stale_holds', '3': 1, '4': 1, '5': 5, '10': 'totalStaleHolds'},
    const {'1': 'resolved_count', '3': 2, '4': 1, '5': 5, '10': 'resolvedCount'},
    const {'1': 'skipped_count', '3': 3, '4': 1, '5': 5, '10': 'skippedCount'},
    const {'1': 'error_count', '3': 4, '4': 1, '5': 5, '10': 'errorCount'},
    const {'1': 'resolutions', '3': 5, '4': 3, '5': 11, '6': '.payments.AdminHoldResolution', '10': 'resolutions'},
    const {'1': 'summary', '3': 6, '4': 1, '5': 9, '10': 'summary'},
  ],
};

/// Descriptor for `AdminAutoResolveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAutoResolveResponseDescriptor = $convert.base64Decode('ChhBZG1pbkF1dG9SZXNvbHZlUmVzcG9uc2USKgoRdG90YWxfc3RhbGVfaG9sZHMYASABKAVSD3RvdGFsU3RhbGVIb2xkcxIlCg5yZXNvbHZlZF9jb3VudBgCIAEoBVINcmVzb2x2ZWRDb3VudBIjCg1za2lwcGVkX2NvdW50GAMgASgFUgxza2lwcGVkQ291bnQSHwoLZXJyb3JfY291bnQYBCABKAVSCmVycm9yQ291bnQSPwoLcmVzb2x1dGlvbnMYBSADKAsyHS5wYXltZW50cy5BZG1pbkhvbGRSZXNvbHV0aW9uUgtyZXNvbHV0aW9ucxIYCgdzdW1tYXJ5GAYgASgJUgdzdW1tYXJ5');
@$core.Deprecated('Use adminHoldResolutionDescriptor instead')
const AdminHoldResolution$json = const {
  '1': 'AdminHoldResolution',
  '2': const [
    const {'1': 'hold_id', '3': 1, '4': 1, '5': 9, '10': 'holdId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'transfer_reference', '3': 5, '4': 1, '5': 9, '10': 'transferReference'},
    const {'1': 'provider_status', '3': 6, '4': 1, '5': 9, '10': 'providerStatus'},
    const {'1': 'action_taken', '3': 7, '4': 1, '5': 9, '10': 'actionTaken'},
    const {'1': 'reason', '3': 8, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'error_message', '3': 9, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'expires_at', '3': 11, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `AdminHoldResolution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminHoldResolutionDescriptor = $convert.base64Decode('ChNBZG1pbkhvbGRSZXNvbHV0aW9uEhcKB2hvbGRfaWQYASABKAlSBmhvbGRJZBIdCgphY2NvdW50X2lkGAIgASgJUglhY2NvdW50SWQSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5Ei0KEnRyYW5zZmVyX3JlZmVyZW5jZRgFIAEoCVIRdHJhbnNmZXJSZWZlcmVuY2USJwoPcHJvdmlkZXJfc3RhdHVzGAYgASgJUg5wcm92aWRlclN0YXR1cxIhCgxhY3Rpb25fdGFrZW4YByABKAlSC2FjdGlvblRha2VuEhYKBnJlYXNvbhgIIAEoCVIGcmVhc29uEiMKDWVycm9yX21lc3NhZ2UYCSABKAlSDGVycm9yTWVzc2FnZRIdCgpjcmVhdGVkX2F0GAogASgJUgljcmVhdGVkQXQSHQoKZXhwaXJlc19hdBgLIAEoCVIJZXhwaXJlc0F0');
@$core.Deprecated('Use adminCheckHoldProviderRequestDescriptor instead')
const AdminCheckHoldProviderRequest$json = const {
  '1': 'AdminCheckHoldProviderRequest',
  '2': const [
    const {'1': 'hold_reference', '3': 1, '4': 1, '5': 9, '10': 'holdReference'},
  ],
};

/// Descriptor for `AdminCheckHoldProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCheckHoldProviderRequestDescriptor = $convert.base64Decode('Ch1BZG1pbkNoZWNrSG9sZFByb3ZpZGVyUmVxdWVzdBIlCg5ob2xkX3JlZmVyZW5jZRgBIAEoCVINaG9sZFJlZmVyZW5jZQ==');
@$core.Deprecated('Use adminProviderStatusResponseDescriptor instead')
const AdminProviderStatusResponse$json = const {
  '1': 'AdminProviderStatusResponse',
  '2': const [
    const {'1': 'hold_id', '3': 1, '4': 1, '5': 9, '10': 'holdId'},
    const {'1': 'transfer_reference', '3': 2, '4': 1, '5': 9, '10': 'transferReference'},
    const {'1': 'hold_status', '3': 3, '4': 1, '5': 9, '10': 'holdStatus'},
    const {'1': 'hold_amount', '3': 4, '4': 1, '5': 3, '10': 'holdAmount'},
    const {'1': 'hold_currency', '3': 5, '4': 1, '5': 9, '10': 'holdCurrency'},
    const {'1': 'hold_created_at', '3': 6, '4': 1, '5': 9, '10': 'holdCreatedAt'},
    const {'1': 'hold_expires_at', '3': 7, '4': 1, '5': 9, '10': 'holdExpiresAt'},
    const {'1': 'provider_name', '3': 8, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'provider_status', '3': 9, '4': 1, '5': 9, '10': 'providerStatus'},
    const {'1': 'provider_message', '3': 10, '4': 1, '5': 9, '10': 'providerMessage'},
    const {'1': 'mapped_status', '3': 11, '4': 1, '5': 9, '10': 'mappedStatus'},
    const {'1': 'transfer_id', '3': 12, '4': 1, '5': 9, '10': 'transferId'},
    const {'1': 'transfer_status', '3': 13, '4': 1, '5': 9, '10': 'transferStatus'},
    const {'1': 'account_id', '3': 14, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 15, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `AdminProviderStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminProviderStatusResponseDescriptor = $convert.base64Decode('ChtBZG1pblByb3ZpZGVyU3RhdHVzUmVzcG9uc2USFwoHaG9sZF9pZBgBIAEoCVIGaG9sZElkEi0KEnRyYW5zZmVyX3JlZmVyZW5jZRgCIAEoCVIRdHJhbnNmZXJSZWZlcmVuY2USHwoLaG9sZF9zdGF0dXMYAyABKAlSCmhvbGRTdGF0dXMSHwoLaG9sZF9hbW91bnQYBCABKANSCmhvbGRBbW91bnQSIwoNaG9sZF9jdXJyZW5jeRgFIAEoCVIMaG9sZEN1cnJlbmN5EiYKD2hvbGRfY3JlYXRlZF9hdBgGIAEoCVINaG9sZENyZWF0ZWRBdBImCg9ob2xkX2V4cGlyZXNfYXQYByABKAlSDWhvbGRFeHBpcmVzQXQSIwoNcHJvdmlkZXJfbmFtZRgIIAEoCVIMcHJvdmlkZXJOYW1lEicKD3Byb3ZpZGVyX3N0YXR1cxgJIAEoCVIOcHJvdmlkZXJTdGF0dXMSKQoQcHJvdmlkZXJfbWVzc2FnZRgKIAEoCVIPcHJvdmlkZXJNZXNzYWdlEiMKDW1hcHBlZF9zdGF0dXMYCyABKAlSDG1hcHBlZFN0YXR1cxIfCgt0cmFuc2Zlcl9pZBgMIAEoCVIKdHJhbnNmZXJJZBInCg90cmFuc2Zlcl9zdGF0dXMYDSABKAlSDnRyYW5zZmVyU3RhdHVzEh0KCmFjY291bnRfaWQYDiABKAlSCWFjY291bnRJZBIXCgd1c2VyX2lkGA8gASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use adminGetFailedOperationsRequestDescriptor instead')
const AdminGetFailedOperationsRequest$json = const {
  '1': 'AdminGetFailedOperationsRequest',
  '2': const [
    const {'1': 'hours', '3': 1, '4': 1, '5': 5, '10': 'hours'},
    const {'1': 'operation_type', '3': 2, '4': 1, '5': 9, '10': 'operationType'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `AdminGetFailedOperationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetFailedOperationsRequestDescriptor = $convert.base64Decode('Ch9BZG1pbkdldEZhaWxlZE9wZXJhdGlvbnNSZXF1ZXN0EhQKBWhvdXJzGAEgASgFUgVob3VycxIlCg5vcGVyYXRpb25fdHlwZRgCIAEoCVINb3BlcmF0aW9uVHlwZRISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgEIAEoBVIIcGFnZVNpemU=');
@$core.Deprecated('Use adminGetFailedOperationsResponseDescriptor instead')
const AdminGetFailedOperationsResponse$json = const {
  '1': 'AdminGetFailedOperationsResponse',
  '2': const [
    const {'1': 'operations', '3': 1, '4': 3, '5': 11, '6': '.payments.AdminFailedOperation', '10': 'operations'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `AdminGetFailedOperationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetFailedOperationsResponseDescriptor = $convert.base64Decode('CiBBZG1pbkdldEZhaWxlZE9wZXJhdGlvbnNSZXNwb25zZRI+CgpvcGVyYXRpb25zGAEgAygLMh4ucGF5bWVudHMuQWRtaW5GYWlsZWRPcGVyYXRpb25SCm9wZXJhdGlvbnMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');
@$core.Deprecated('Use adminFailedOperationDescriptor instead')
const AdminFailedOperation$json = const {
  '1': 'AdminFailedOperation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 5, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'failure_code', '3': 9, '4': 1, '5': 9, '10': 'failureCode'},
    const {'1': 'failure_reason', '3': 10, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'provider', '3': 11, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_ref', '3': 12, '4': 1, '5': 9, '10': 'providerRef'},
    const {'1': 'has_fund_hold', '3': 13, '4': 1, '5': 8, '10': 'hasFundHold'},
    const {'1': 'fund_hold_status', '3': 14, '4': 1, '5': 9, '10': 'fundHoldStatus'},
    const {'1': 'has_rollback_record', '3': 15, '4': 1, '5': 8, '10': 'hasRollbackRecord'},
    const {'1': 'rollback_status', '3': 16, '4': 1, '5': 9, '10': 'rollbackStatus'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'failed_at', '3': 18, '4': 1, '5': 9, '10': 'failedAt'},
    const {'1': 'metadata', '3': 19, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `AdminFailedOperation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFailedOperationDescriptor = $convert.base64Decode('ChRBZG1pbkZhaWxlZE9wZXJhdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZRIcCglyZWZlcmVuY2UYAyABKAlSCXJlZmVyZW5jZRIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgFIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgGIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIWCgZzdGF0dXMYCCABKAlSBnN0YXR1cxIhCgxmYWlsdXJlX2NvZGUYCSABKAlSC2ZhaWx1cmVDb2RlEiUKDmZhaWx1cmVfcmVhc29uGAogASgJUg1mYWlsdXJlUmVhc29uEhoKCHByb3ZpZGVyGAsgASgJUghwcm92aWRlchIhCgxwcm92aWRlcl9yZWYYDCABKAlSC3Byb3ZpZGVyUmVmEiIKDWhhc19mdW5kX2hvbGQYDSABKAhSC2hhc0Z1bmRIb2xkEigKEGZ1bmRfaG9sZF9zdGF0dXMYDiABKAlSDmZ1bmRIb2xkU3RhdHVzEi4KE2hhc19yb2xsYmFja19yZWNvcmQYDyABKAhSEWhhc1JvbGxiYWNrUmVjb3JkEicKD3JvbGxiYWNrX3N0YXR1cxgQIAEoCVIOcm9sbGJhY2tTdGF0dXMSHQoKY3JlYXRlZF9hdBgRIAEoCVIJY3JlYXRlZEF0EhsKCWZhaWxlZF9hdBgSIAEoCVIIZmFpbGVkQXQSGgoIbWV0YWRhdGEYEyABKAlSCG1ldGFkYXRh');
@$core.Deprecated('Use listTransfersRequestDescriptor instead')
const ListTransfersRequest$json = const {
  '1': 'ListTransfersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'start_date', '3': 5, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 6, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'min_amount', '3': 7, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 8, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'page', '3': 9, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 10, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransfersRequestDescriptor = $convert.base64Decode('ChRMaXN0VHJhbnNmZXJzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxISCgR0eXBlGAIgASgJUgR0eXBlEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIcCglyZWZlcmVuY2UYBCABKAlSCXJlZmVyZW5jZRIdCgpzdGFydF9kYXRlGAUgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYBiABKAlSB2VuZERhdGUSHQoKbWluX2Ftb3VudBgHIAEoAVIJbWluQW1vdW50Eh0KCm1heF9hbW91bnQYCCABKAFSCW1heEFtb3VudBISCgRwYWdlGAkgASgFUgRwYWdlEhQKBWxpbWl0GAogASgFUgVsaW1pdA==');
@$core.Deprecated('Use listTransfersResponseDescriptor instead')
const ListTransfersResponse$json = const {
  '1': 'ListTransfersResponse',
  '2': const [
    const {'1': 'transfers', '3': 1, '4': 3, '5': 11, '6': '.payments.AdminTransferDetail', '10': 'transfers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransfersResponseDescriptor = $convert.base64Decode('ChVMaXN0VHJhbnNmZXJzUmVzcG9uc2USOwoJdHJhbnNmZXJzGAEgAygLMh0ucGF5bWVudHMuQWRtaW5UcmFuc2ZlckRldGFpbFIJdHJhbnNmZXJzEhQKBXRvdGFsGAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');
@$core.Deprecated('Use adminTransferDetailDescriptor instead')
const AdminTransferDetail$json = const {
  '1': 'AdminTransferDetail',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'type', '3': 8, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'recipient_account', '3': 9, '4': 1, '5': 9, '10': 'recipientAccount'},
    const {'1': 'recipient_name', '3': 10, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'bank_code', '3': 11, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 12, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'description', '3': 13, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'fee_code', '3': 14, '4': 1, '5': 9, '10': 'feeCode'},
    const {'1': 'fee_amount', '3': 15, '4': 1, '5': 1, '10': 'feeAmount'},
    const {'1': 'provider', '3': 16, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_ref', '3': 17, '4': 1, '5': 9, '10': 'providerRef'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'scheduled_at', '3': 20, '4': 1, '5': 9, '10': 'scheduledAt'},
    const {'1': 'metadata', '3': 21, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `AdminTransferDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminTransferDetailDescriptor = $convert.base64Decode('ChNBZG1pblRyYW5zZmVyRGV0YWlsEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEhwKCXJlZmVyZW5jZRgEIAEoCVIJcmVmZXJlbmNlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIWCgZzdGF0dXMYByABKAlSBnN0YXR1cxISCgR0eXBlGAggASgJUgR0eXBlEisKEXJlY2lwaWVudF9hY2NvdW50GAkgASgJUhByZWNpcGllbnRBY2NvdW50EiUKDnJlY2lwaWVudF9uYW1lGAogASgJUg1yZWNpcGllbnROYW1lEhsKCWJhbmtfY29kZRgLIAEoCVIIYmFua0NvZGUSGwoJYmFua19uYW1lGAwgASgJUghiYW5rTmFtZRIgCgtkZXNjcmlwdGlvbhgNIAEoCVILZGVzY3JpcHRpb24SGQoIZmVlX2NvZGUYDiABKAlSB2ZlZUNvZGUSHQoKZmVlX2Ftb3VudBgPIAEoAVIJZmVlQW1vdW50EhoKCHByb3ZpZGVyGBAgASgJUghwcm92aWRlchIhCgxwcm92aWRlcl9yZWYYESABKAlSC3Byb3ZpZGVyUmVmEh0KCmNyZWF0ZWRfYXQYEiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GBMgASgJUgl1cGRhdGVkQXQSIQoMc2NoZWR1bGVkX2F0GBQgASgJUgtzY2hlZHVsZWRBdBIaCghtZXRhZGF0YRgVIAEoCVIIbWV0YWRhdGE=');
@$core.Deprecated('Use getTransferByReferenceRequestDescriptor instead')
const GetTransferByReferenceRequest$json = const {
  '1': 'GetTransferByReferenceRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GetTransferByReferenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferByReferenceRequestDescriptor = $convert.base64Decode('Ch1HZXRUcmFuc2ZlckJ5UmVmZXJlbmNlUmVxdWVzdBIcCglyZWZlcmVuY2UYASABKAlSCXJlZmVyZW5jZQ==');
@$core.Deprecated('Use ledgerEntryDescriptor instead')
const LedgerEntry$json = const {
  '1': 'LedgerEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'balance_before', '3': 7, '4': 1, '5': 1, '10': 'balanceBefore'},
    const {'1': 'balance_after', '3': 8, '4': 1, '5': 1, '10': 'balanceAfter'},
    const {'1': 'counterparty_name', '3': 9, '4': 1, '5': 9, '10': 'counterpartyName'},
    const {'1': 'counterparty_account', '3': 10, '4': 1, '5': 9, '10': 'counterpartyAccount'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'description', '3': 12, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `LedgerEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ledgerEntryDescriptor = $convert.base64Decode('CgtMZWRnZXJFbnRyeRIOCgJpZBgBIAEoCVICaWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhIKBHR5cGUYBCABKAlSBHR5cGUSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EiUKDmJhbGFuY2VfYmVmb3JlGAcgASgBUg1iYWxhbmNlQmVmb3JlEiMKDWJhbGFuY2VfYWZ0ZXIYCCABKAFSDGJhbGFuY2VBZnRlchIrChFjb3VudGVycGFydHlfbmFtZRgJIAEoCVIQY291bnRlcnBhcnR5TmFtZRIxChRjb3VudGVycGFydHlfYWNjb3VudBgKIAEoCVITY291bnRlcnBhcnR5QWNjb3VudBIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxIgCgtkZXNjcmlwdGlvbhgMIAEoCVILZGVzY3JpcHRpb24SHQoKY3JlYXRlZF9hdBgNIAEoCVIJY3JlYXRlZEF0');
@$core.Deprecated('Use familySpendRecordDescriptor instead')
const FamilySpendRecord$json = const {
  '1': 'FamilySpendRecord',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'phase', '3': 3, '4': 1, '5': 9, '10': 'phase'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `FamilySpendRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familySpendRecordDescriptor = $convert.base64Decode('ChFGYW1pbHlTcGVuZFJlY29yZBIcCglyZWZlcmVuY2UYASABKAlSCXJlZmVyZW5jZRIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIUCgVwaGFzZRgDIAEoCVIFcGhhc2USHQoKY3JlYXRlZF9hdBgEIAEoCVIJY3JlYXRlZEF0');
@$core.Deprecated('Use internalTransferDetailDescriptor instead')
const InternalTransferDetail$json = const {
  '1': 'InternalTransferDetail',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'payment_type', '3': 9, '4': 1, '5': 9, '10': 'paymentType'},
    const {'1': 'recipient', '3': 10, '4': 1, '5': 9, '10': 'recipient'},
    const {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 12, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 14, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'ledger', '3': 15, '4': 3, '5': 11, '6': '.payments.LedgerEntry', '10': 'ledger'},
    const {'1': 'family_spend', '3': 16, '4': 3, '5': 11, '6': '.payments.FamilySpendRecord', '10': 'familySpend'},
  ],
};

/// Descriptor for `InternalTransferDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internalTransferDetailDescriptor = $convert.base64Decode('ChZJbnRlcm5hbFRyYW5zZmVyRGV0YWlsEh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEhwKCXJlZmVyZW5jZRgEIAEoCVIJcmVmZXJlbmNlEicKD2lkZW1wb3RlbmN5X2tleRgFIAEoCVIOaWRlbXBvdGVuY3lLZXkSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgIIAEoCVIGc3RhdHVzEiEKDHBheW1lbnRfdHlwZRgJIAEoCVILcGF5bWVudFR5cGUSHAoJcmVjaXBpZW50GAogASgJUglyZWNpcGllbnQSIAoLZGVzY3JpcHRpb24YCyABKAlSC2Rlc2NyaXB0aW9uEhoKCG1ldGFkYXRhGAwgASgJUghtZXRhZGF0YRIdCgpjcmVhdGVkX2F0GA0gASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgOIAEoCVIJdXBkYXRlZEF0Ei0KBmxlZGdlchgPIAMoCzIVLnBheW1lbnRzLkxlZGdlckVudHJ5UgZsZWRnZXISPgoMZmFtaWx5X3NwZW5kGBAgAygLMhsucGF5bWVudHMuRmFtaWx5U3BlbmRSZWNvcmRSC2ZhbWlseVNwZW5k');
@$core.Deprecated('Use listPaymentsRequestDescriptor instead')
const ListPaymentsRequest$json = const {
  '1': 'ListPaymentsRequest',
  '2': const [
    const {'1': 'payment_type', '3': 1, '4': 1, '5': 9, '10': 'paymentType'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 4, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'start_date', '3': 6, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 7, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'page', '3': 8, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 9, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaymentsRequestDescriptor = $convert.base64Decode('ChNMaXN0UGF5bWVudHNSZXF1ZXN0EiEKDHBheW1lbnRfdHlwZRgBIAEoCVILcGF5bWVudFR5cGUSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYBCABKAlSCWFjY291bnRJZBIcCglyZWZlcmVuY2UYBSABKAlSCXJlZmVyZW5jZRIdCgpzdGFydF9kYXRlGAYgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYByABKAlSB2VuZERhdGUSEgoEcGFnZRgIIAEoBVIEcGFnZRIUCgVsaW1pdBgJIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use listPaymentsResponseDescriptor instead')
const ListPaymentsResponse$json = const {
  '1': 'ListPaymentsResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.payments.PaymentDetail', '10': 'payments'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaymentsResponseDescriptor = $convert.base64Decode('ChRMaXN0UGF5bWVudHNSZXNwb25zZRIzCghwYXltZW50cxgBIAMoCzIXLnBheW1lbnRzLlBheW1lbnREZXRhaWxSCHBheW1lbnRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');
@$core.Deprecated('Use paymentDetailDescriptor instead')
const PaymentDetail$json = const {
  '1': 'PaymentDetail',
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
    const {'1': 'scheduled_at', '3': 14, '4': 1, '5': 9, '10': 'scheduledAt'},
  ],
};

/// Descriptor for `PaymentDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentDetailDescriptor = $convert.base64Decode('Cg1QYXltZW50RGV0YWlsEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEiEKDHBheW1lbnRfdHlwZRgEIAEoCVILcGF5bWVudFR5cGUSHAoJcmVmZXJlbmNlGAUgASgJUglyZWZlcmVuY2USFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgIIAEoCVIGc3RhdHVzEhwKCXJlY2lwaWVudBgJIAEoCVIJcmVjaXBpZW50EiAKC2Rlc2NyaXB0aW9uGAogASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgLIAEoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgMIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYDSABKAlSCXVwZGF0ZWRBdBIhCgxzY2hlZHVsZWRfYXQYDiABKAlSC3NjaGVkdWxlZEF0');
@$core.Deprecated('Use adminGetDailyUsageRequestDescriptor instead')
const AdminGetDailyUsageRequest$json = const {
  '1': 'AdminGetDailyUsageRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminGetDailyUsageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetDailyUsageRequestDescriptor = $convert.base64Decode('ChlBZG1pbkdldERhaWx5VXNhZ2VSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIdCgpzdGFydF9kYXRlGAIgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYAyABKAlSB2VuZERhdGUSEgoEcGFnZRgEIAEoBVIEcGFnZRIUCgVsaW1pdBgFIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use adminGetDailyUsageResponseDescriptor instead')
const AdminGetDailyUsageResponse$json = const {
  '1': 'AdminGetDailyUsageResponse',
  '2': const [
    const {'1': 'records', '3': 1, '4': 3, '5': 11, '6': '.payments.DailyUsageRecord', '10': 'records'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'summary', '3': 3, '4': 1, '5': 11, '6': '.payments.DailyUsageSummary', '10': 'summary'},
  ],
};

/// Descriptor for `AdminGetDailyUsageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetDailyUsageResponseDescriptor = $convert.base64Decode('ChpBZG1pbkdldERhaWx5VXNhZ2VSZXNwb25zZRI0CgdyZWNvcmRzGAEgAygLMhoucGF5bWVudHMuRGFpbHlVc2FnZVJlY29yZFIHcmVjb3JkcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSNQoHc3VtbWFyeRgDIAEoCzIbLnBheW1lbnRzLkRhaWx5VXNhZ2VTdW1tYXJ5UgdzdW1tYXJ5');
@$core.Deprecated('Use dailyUsageRecordDescriptor instead')
const DailyUsageRecord$json = const {
  '1': 'DailyUsageRecord',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'usage_date', '3': 3, '4': 1, '5': 9, '10': 'usageDate'},
    const {'1': 'total_transferred', '3': 4, '4': 1, '5': 3, '10': 'totalTransferred'},
    const {'1': 'transfer_count', '3': 5, '4': 1, '5': 5, '10': 'transferCount'},
    const {'1': 'internal_transfer_count', '3': 6, '4': 1, '5': 5, '10': 'internalTransferCount'},
    const {'1': 'external_transfer_count', '3': 7, '4': 1, '5': 5, '10': 'externalTransferCount'},
    const {'1': 'total_withdrawn', '3': 8, '4': 1, '5': 3, '10': 'totalWithdrawn'},
    const {'1': 'withdrawal_count', '3': 9, '4': 1, '5': 5, '10': 'withdrawalCount'},
    const {'1': 'total_international', '3': 10, '4': 1, '5': 3, '10': 'totalInternational'},
    const {'1': 'international_count', '3': 11, '4': 1, '5': 5, '10': 'internationalCount'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `DailyUsageRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyUsageRecordDescriptor = $convert.base64Decode('ChBEYWlseVVzYWdlUmVjb3JkEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKdXNhZ2VfZGF0ZRgDIAEoCVIJdXNhZ2VEYXRlEisKEXRvdGFsX3RyYW5zZmVycmVkGAQgASgDUhB0b3RhbFRyYW5zZmVycmVkEiUKDnRyYW5zZmVyX2NvdW50GAUgASgFUg10cmFuc2ZlckNvdW50EjYKF2ludGVybmFsX3RyYW5zZmVyX2NvdW50GAYgASgFUhVpbnRlcm5hbFRyYW5zZmVyQ291bnQSNgoXZXh0ZXJuYWxfdHJhbnNmZXJfY291bnQYByABKAVSFWV4dGVybmFsVHJhbnNmZXJDb3VudBInCg90b3RhbF93aXRoZHJhd24YCCABKANSDnRvdGFsV2l0aGRyYXduEikKEHdpdGhkcmF3YWxfY291bnQYCSABKAVSD3dpdGhkcmF3YWxDb3VudBIvChN0b3RhbF9pbnRlcm5hdGlvbmFsGAogASgDUhJ0b3RhbEludGVybmF0aW9uYWwSLwoTaW50ZXJuYXRpb25hbF9jb3VudBgLIAEoBVISaW50ZXJuYXRpb25hbENvdW50Eh0KCmNyZWF0ZWRfYXQYDCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GA0gASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use dailyUsageSummaryDescriptor instead')
const DailyUsageSummary$json = const {
  '1': 'DailyUsageSummary',
  '2': const [
    const {'1': 'total_amount_transferred', '3': 1, '4': 1, '5': 3, '10': 'totalAmountTransferred'},
    const {'1': 'total_transfers', '3': 2, '4': 1, '5': 5, '10': 'totalTransfers'},
    const {'1': 'total_withdrawn', '3': 3, '4': 1, '5': 3, '10': 'totalWithdrawn'},
    const {'1': 'total_withdrawals', '3': 4, '4': 1, '5': 5, '10': 'totalWithdrawals'},
    const {'1': 'total_international', '3': 5, '4': 1, '5': 3, '10': 'totalInternational'},
    const {'1': 'total_international_transfers', '3': 6, '4': 1, '5': 5, '10': 'totalInternationalTransfers'},
    const {'1': 'unique_users', '3': 7, '4': 1, '5': 5, '10': 'uniqueUsers'},
    const {'1': 'period_start', '3': 8, '4': 1, '5': 9, '10': 'periodStart'},
    const {'1': 'period_end', '3': 9, '4': 1, '5': 9, '10': 'periodEnd'},
  ],
};

/// Descriptor for `DailyUsageSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyUsageSummaryDescriptor = $convert.base64Decode('ChFEYWlseVVzYWdlU3VtbWFyeRI4Chh0b3RhbF9hbW91bnRfdHJhbnNmZXJyZWQYASABKANSFnRvdGFsQW1vdW50VHJhbnNmZXJyZWQSJwoPdG90YWxfdHJhbnNmZXJzGAIgASgFUg50b3RhbFRyYW5zZmVycxInCg90b3RhbF93aXRoZHJhd24YAyABKANSDnRvdGFsV2l0aGRyYXduEisKEXRvdGFsX3dpdGhkcmF3YWxzGAQgASgFUhB0b3RhbFdpdGhkcmF3YWxzEi8KE3RvdGFsX2ludGVybmF0aW9uYWwYBSABKANSEnRvdGFsSW50ZXJuYXRpb25hbBJCCh10b3RhbF9pbnRlcm5hdGlvbmFsX3RyYW5zZmVycxgGIAEoBVIbdG90YWxJbnRlcm5hdGlvbmFsVHJhbnNmZXJzEiEKDHVuaXF1ZV91c2VycxgHIAEoBVILdW5pcXVlVXNlcnMSIQoMcGVyaW9kX3N0YXJ0GAggASgJUgtwZXJpb2RTdGFydBIdCgpwZXJpb2RfZW5kGAkgASgJUglwZXJpb2RFbmQ=');
@$core.Deprecated('Use getProviderBalancesRequestDescriptor instead')
const GetProviderBalancesRequest$json = const {
  '1': 'GetProviderBalancesRequest',
};

/// Descriptor for `GetProviderBalancesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProviderBalancesRequestDescriptor = $convert.base64Decode('ChpHZXRQcm92aWRlckJhbGFuY2VzUmVxdWVzdA==');
@$core.Deprecated('Use providerBalancesDescriptor instead')
const ProviderBalances$json = const {
  '1': 'ProviderBalances',
  '2': const [
    const {'1': 'balances', '3': 1, '4': 3, '5': 11, '6': '.payments.ProviderBalance', '10': 'balances'},
    const {'1': 'last_checked_at', '3': 2, '4': 1, '5': 9, '10': 'lastCheckedAt'},
  ],
};

/// Descriptor for `ProviderBalances`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerBalancesDescriptor = $convert.base64Decode('ChBQcm92aWRlckJhbGFuY2VzEjUKCGJhbGFuY2VzGAEgAygLMhkucGF5bWVudHMuUHJvdmlkZXJCYWxhbmNlUghiYWxhbmNlcxImCg9sYXN0X2NoZWNrZWRfYXQYAiABKAlSDWxhc3RDaGVja2VkQXQ=');
@$core.Deprecated('Use providerBalanceDescriptor instead')
const ProviderBalance$json = const {
  '1': 'ProviderBalance',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'balance_type', '3': 2, '4': 1, '5': 9, '10': 'balanceType'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'last_updated', '3': 6, '4': 1, '5': 9, '10': 'lastUpdated'},
    const {'1': 'error_message', '3': 7, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `ProviderBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerBalanceDescriptor = $convert.base64Decode('Cg9Qcm92aWRlckJhbGFuY2USGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEiEKDGJhbGFuY2VfdHlwZRgCIAEoCVILYmFsYW5jZVR5cGUSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgFIAEoCVIGc3RhdHVzEiEKDGxhc3RfdXBkYXRlZBgGIAEoCVILbGFzdFVwZGF0ZWQSIwoNZXJyb3JfbWVzc2FnZRgHIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use providerSettlementReportDescriptor instead')
const ProviderSettlementReport$json = const {
  '1': 'ProviderSettlementReport',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'period_start', '3': 2, '4': 1, '5': 9, '10': 'periodStart'},
    const {'1': 'period_end', '3': 3, '4': 1, '5': 9, '10': 'periodEnd'},
    const {'1': 'total_debits', '3': 4, '4': 1, '5': 1, '10': 'totalDebits'},
    const {'1': 'total_credits', '3': 5, '4': 1, '5': 1, '10': 'totalCredits'},
    const {'1': 'net_settlement', '3': 6, '4': 1, '5': 1, '10': 'netSettlement'},
    const {'1': 'transaction_count', '3': 7, '4': 1, '5': 5, '10': 'transactionCount'},
    const {'1': 'our_ledger_balance', '3': 8, '4': 1, '5': 1, '10': 'ourLedgerBalance'},
    const {'1': 'provider_ledger_balance', '3': 9, '4': 1, '5': 1, '10': 'providerLedgerBalance'},
    const {'1': 'discrepancy', '3': 10, '4': 1, '5': 1, '10': 'discrepancy'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'discrepancies', '3': 12, '4': 3, '5': 9, '10': 'discrepancies'},
    const {'1': 'generated_at', '3': 13, '4': 1, '5': 9, '10': 'generatedAt'},
  ],
};

/// Descriptor for `ProviderSettlementReport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerSettlementReportDescriptor = $convert.base64Decode('ChhQcm92aWRlclNldHRsZW1lbnRSZXBvcnQSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEiEKDHBlcmlvZF9zdGFydBgCIAEoCVILcGVyaW9kU3RhcnQSHQoKcGVyaW9kX2VuZBgDIAEoCVIJcGVyaW9kRW5kEiEKDHRvdGFsX2RlYml0cxgEIAEoAVILdG90YWxEZWJpdHMSIwoNdG90YWxfY3JlZGl0cxgFIAEoAVIMdG90YWxDcmVkaXRzEiUKDm5ldF9zZXR0bGVtZW50GAYgASgBUg1uZXRTZXR0bGVtZW50EisKEXRyYW5zYWN0aW9uX2NvdW50GAcgASgFUhB0cmFuc2FjdGlvbkNvdW50EiwKEm91cl9sZWRnZXJfYmFsYW5jZRgIIAEoAVIQb3VyTGVkZ2VyQmFsYW5jZRI2Chdwcm92aWRlcl9sZWRnZXJfYmFsYW5jZRgJIAEoAVIVcHJvdmlkZXJMZWRnZXJCYWxhbmNlEiAKC2Rpc2NyZXBhbmN5GAogASgBUgtkaXNjcmVwYW5jeRIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxIkCg1kaXNjcmVwYW5jaWVzGAwgAygJUg1kaXNjcmVwYW5jaWVzEiEKDGdlbmVyYXRlZF9hdBgNIAEoCVILZ2VuZXJhdGVkQXQ=');
@$core.Deprecated('Use getWebhookAuditTrailRequestDescriptor instead')
const GetWebhookAuditTrailRequest$json = const {
  '1': 'GetWebhookAuditTrailRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'start_date', '3': 4, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 5, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'page', '3': 6, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 7, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetWebhookAuditTrailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWebhookAuditTrailRequestDescriptor = $convert.base64Decode('ChtHZXRXZWJob29rQXVkaXRUcmFpbFJlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEhwKCXJlZmVyZW5jZRgCIAEoCVIJcmVmZXJlbmNlEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEh0KCnN0YXJ0X2RhdGUYBCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgFIAEoCVIHZW5kRGF0ZRISCgRwYWdlGAYgASgFUgRwYWdlEhQKBWxpbWl0GAcgASgFUgVsaW1pdA==');
@$core.Deprecated('Use webhookAuditTrailResponseDescriptor instead')
const WebhookAuditTrailResponse$json = const {
  '1': 'WebhookAuditTrailResponse',
  '2': const [
    const {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.payments.WebhookAuditEntry', '10': 'entries'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'summary', '3': 3, '4': 1, '5': 11, '6': '.payments.WebhookAuditSummary', '10': 'summary'},
  ],
};

/// Descriptor for `WebhookAuditTrailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookAuditTrailResponseDescriptor = $convert.base64Decode('ChlXZWJob29rQXVkaXRUcmFpbFJlc3BvbnNlEjUKB2VudHJpZXMYASADKAsyGy5wYXltZW50cy5XZWJob29rQXVkaXRFbnRyeVIHZW50cmllcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSNwoHc3VtbWFyeRgDIAEoCzIdLnBheW1lbnRzLldlYmhvb2tBdWRpdFN1bW1hcnlSB3N1bW1hcnk=');
@$core.Deprecated('Use webhookAuditEntryDescriptor instead')
const WebhookAuditEntry$json = const {
  '1': 'WebhookAuditEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'event_type', '3': 3, '4': 1, '5': 9, '10': 'eventType'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'provider_ref', '3': 5, '4': 1, '5': 9, '10': 'providerRef'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'http_status_code', '3': 7, '4': 1, '5': 5, '10': 'httpStatusCode'},
    const {'1': 'request_payload', '3': 8, '4': 1, '5': 9, '10': 'requestPayload'},
    const {'1': 'response_body', '3': 9, '4': 1, '5': 9, '10': 'responseBody'},
    const {'1': 'error_message', '3': 10, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'processed_at', '3': 11, '4': 1, '5': 9, '10': 'processedAt'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'ip_address', '3': 13, '4': 1, '5': 9, '10': 'ipAddress'},
    const {'1': 'signature', '3': 14, '4': 1, '5': 9, '10': 'signature'},
    const {'1': 'signature_valid', '3': 15, '4': 1, '5': 8, '10': 'signatureValid'},
  ],
};

/// Descriptor for `WebhookAuditEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookAuditEntryDescriptor = $convert.base64Decode('ChFXZWJob29rQXVkaXRFbnRyeRIOCgJpZBgBIAEoCVICaWQSGgoIcHJvdmlkZXIYAiABKAlSCHByb3ZpZGVyEh0KCmV2ZW50X3R5cGUYAyABKAlSCWV2ZW50VHlwZRIcCglyZWZlcmVuY2UYBCABKAlSCXJlZmVyZW5jZRIhCgxwcm92aWRlcl9yZWYYBSABKAlSC3Byb3ZpZGVyUmVmEhYKBnN0YXR1cxgGIAEoCVIGc3RhdHVzEigKEGh0dHBfc3RhdHVzX2NvZGUYByABKAVSDmh0dHBTdGF0dXNDb2RlEicKD3JlcXVlc3RfcGF5bG9hZBgIIAEoCVIOcmVxdWVzdFBheWxvYWQSIwoNcmVzcG9uc2VfYm9keRgJIAEoCVIMcmVzcG9uc2VCb2R5EiMKDWVycm9yX21lc3NhZ2UYCiABKAlSDGVycm9yTWVzc2FnZRIhCgxwcm9jZXNzZWRfYXQYCyABKAlSC3Byb2Nlc3NlZEF0Eh0KCmNyZWF0ZWRfYXQYDCABKAlSCWNyZWF0ZWRBdBIdCgppcF9hZGRyZXNzGA0gASgJUglpcEFkZHJlc3MSHAoJc2lnbmF0dXJlGA4gASgJUglzaWduYXR1cmUSJwoPc2lnbmF0dXJlX3ZhbGlkGA8gASgIUg5zaWduYXR1cmVWYWxpZA==');
@$core.Deprecated('Use webhookAuditSummaryDescriptor instead')
const WebhookAuditSummary$json = const {
  '1': 'WebhookAuditSummary',
  '2': const [
    const {'1': 'total_webhooks', '3': 1, '4': 1, '5': 5, '10': 'totalWebhooks'},
    const {'1': 'successful_webhooks', '3': 2, '4': 1, '5': 5, '10': 'successfulWebhooks'},
    const {'1': 'failed_webhooks', '3': 3, '4': 1, '5': 5, '10': 'failedWebhooks'},
    const {'1': 'pending_webhooks', '3': 4, '4': 1, '5': 5, '10': 'pendingWebhooks'},
    const {'1': 'by_provider', '3': 5, '4': 3, '5': 11, '6': '.payments.WebhookAuditSummary.ByProviderEntry', '10': 'byProvider'},
    const {'1': 'by_event_type', '3': 6, '4': 3, '5': 11, '6': '.payments.WebhookAuditSummary.ByEventTypeEntry', '10': 'byEventType'},
  ],
  '3': const [WebhookAuditSummary_ByProviderEntry$json, WebhookAuditSummary_ByEventTypeEntry$json],
};

@$core.Deprecated('Use webhookAuditSummaryDescriptor instead')
const WebhookAuditSummary_ByProviderEntry$json = const {
  '1': 'ByProviderEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use webhookAuditSummaryDescriptor instead')
const WebhookAuditSummary_ByEventTypeEntry$json = const {
  '1': 'ByEventTypeEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `WebhookAuditSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webhookAuditSummaryDescriptor = $convert.base64Decode('ChNXZWJob29rQXVkaXRTdW1tYXJ5EiUKDnRvdGFsX3dlYmhvb2tzGAEgASgFUg10b3RhbFdlYmhvb2tzEi8KE3N1Y2Nlc3NmdWxfd2ViaG9va3MYAiABKAVSEnN1Y2Nlc3NmdWxXZWJob29rcxInCg9mYWlsZWRfd2ViaG9va3MYAyABKAVSDmZhaWxlZFdlYmhvb2tzEikKEHBlbmRpbmdfd2ViaG9va3MYBCABKAVSD3BlbmRpbmdXZWJob29rcxJOCgtieV9wcm92aWRlchgFIAMoCzItLnBheW1lbnRzLldlYmhvb2tBdWRpdFN1bW1hcnkuQnlQcm92aWRlckVudHJ5UgpieVByb3ZpZGVyElIKDWJ5X2V2ZW50X3R5cGUYBiADKAsyLi5wYXltZW50cy5XZWJob29rQXVkaXRTdW1tYXJ5LkJ5RXZlbnRUeXBlRW50cnlSC2J5RXZlbnRUeXBlGj0KD0J5UHJvdmlkZXJFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoBVIFdmFsdWU6AjgBGj4KEEJ5RXZlbnRUeXBlRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAVSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use getTransferAsyncConfigRequestDescriptor instead')
const GetTransferAsyncConfigRequest$json = const {
  '1': 'GetTransferAsyncConfigRequest',
};

/// Descriptor for `GetTransferAsyncConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferAsyncConfigRequestDescriptor = $convert.base64Decode('Ch1HZXRUcmFuc2ZlckFzeW5jQ29uZmlnUmVxdWVzdA==');
@$core.Deprecated('Use updateTransferAsyncConfigRequestDescriptor instead')
const UpdateTransferAsyncConfigRequest$json = const {
  '1': 'UpdateTransferAsyncConfigRequest',
  '2': const [
    const {'1': 'async_external_transfer_enabled', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'asyncExternalTransferEnabled', '17': true},
    const {'1': 'async_batch_transfer_enabled', '3': 2, '4': 1, '5': 8, '9': 1, '10': 'asyncBatchTransferEnabled', '17': true},
    const {'1': 'flutterwave_webhook_url', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'flutterwaveWebhookUrl', '17': true},
    const {'1': 'stale_reconciler_interval_seconds', '3': 10, '4': 1, '5': 5, '9': 3, '10': 'staleReconcilerIntervalSeconds', '17': true},
    const {'1': 'rollback_processor_interval_seconds', '3': 11, '4': 1, '5': 5, '9': 4, '10': 'rollbackProcessorIntervalSeconds', '17': true},
    const {'1': 'hold_extension_interval_seconds', '3': 12, '4': 1, '5': 5, '9': 5, '10': 'holdExtensionIntervalSeconds', '17': true},
    const {'1': 'batch_supervisor_interval_seconds', '3': 13, '4': 1, '5': 5, '9': 6, '10': 'batchSupervisorIntervalSeconds', '17': true},
    const {'1': 'batch_settlement_interval_seconds', '3': 14, '4': 1, '5': 5, '9': 7, '10': 'batchSettlementIntervalSeconds', '17': true},
    const {'1': 'batch_rollback_interval_seconds', '3': 15, '4': 1, '5': 5, '9': 8, '10': 'batchRollbackIntervalSeconds', '17': true},
    const {'1': 'batch_hold_expiry_interval_seconds', '3': 16, '4': 1, '5': 5, '9': 9, '10': 'batchHoldExpiryIntervalSeconds', '17': true},
  ],
  '8': const [
    const {'1': '_async_external_transfer_enabled'},
    const {'1': '_async_batch_transfer_enabled'},
    const {'1': '_flutterwave_webhook_url'},
    const {'1': '_stale_reconciler_interval_seconds'},
    const {'1': '_rollback_processor_interval_seconds'},
    const {'1': '_hold_extension_interval_seconds'},
    const {'1': '_batch_supervisor_interval_seconds'},
    const {'1': '_batch_settlement_interval_seconds'},
    const {'1': '_batch_rollback_interval_seconds'},
    const {'1': '_batch_hold_expiry_interval_seconds'},
  ],
};

/// Descriptor for `UpdateTransferAsyncConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTransferAsyncConfigRequestDescriptor = $convert.base64Decode('CiBVcGRhdGVUcmFuc2ZlckFzeW5jQ29uZmlnUmVxdWVzdBJKCh9hc3luY19leHRlcm5hbF90cmFuc2Zlcl9lbmFibGVkGAEgASgISABSHGFzeW5jRXh0ZXJuYWxUcmFuc2ZlckVuYWJsZWSIAQESRAocYXN5bmNfYmF0Y2hfdHJhbnNmZXJfZW5hYmxlZBgCIAEoCEgBUhlhc3luY0JhdGNoVHJhbnNmZXJFbmFibGVkiAEBEjsKF2ZsdXR0ZXJ3YXZlX3dlYmhvb2tfdXJsGAMgASgJSAJSFWZsdXR0ZXJ3YXZlV2ViaG9va1VybIgBARJOCiFzdGFsZV9yZWNvbmNpbGVyX2ludGVydmFsX3NlY29uZHMYCiABKAVIA1Iec3RhbGVSZWNvbmNpbGVySW50ZXJ2YWxTZWNvbmRziAEBElIKI3JvbGxiYWNrX3Byb2Nlc3Nvcl9pbnRlcnZhbF9zZWNvbmRzGAsgASgFSARSIHJvbGxiYWNrUHJvY2Vzc29ySW50ZXJ2YWxTZWNvbmRziAEBEkoKH2hvbGRfZXh0ZW5zaW9uX2ludGVydmFsX3NlY29uZHMYDCABKAVIBVIcaG9sZEV4dGVuc2lvbkludGVydmFsU2Vjb25kc4gBARJOCiFiYXRjaF9zdXBlcnZpc29yX2ludGVydmFsX3NlY29uZHMYDSABKAVIBlIeYmF0Y2hTdXBlcnZpc29ySW50ZXJ2YWxTZWNvbmRziAEBEk4KIWJhdGNoX3NldHRsZW1lbnRfaW50ZXJ2YWxfc2Vjb25kcxgOIAEoBUgHUh5iYXRjaFNldHRsZW1lbnRJbnRlcnZhbFNlY29uZHOIAQESSgofYmF0Y2hfcm9sbGJhY2tfaW50ZXJ2YWxfc2Vjb25kcxgPIAEoBUgIUhxiYXRjaFJvbGxiYWNrSW50ZXJ2YWxTZWNvbmRziAEBEk8KImJhdGNoX2hvbGRfZXhwaXJ5X2ludGVydmFsX3NlY29uZHMYECABKAVICVIeYmF0Y2hIb2xkRXhwaXJ5SW50ZXJ2YWxTZWNvbmRziAEBQiIKIF9hc3luY19leHRlcm5hbF90cmFuc2Zlcl9lbmFibGVkQh8KHV9hc3luY19iYXRjaF90cmFuc2Zlcl9lbmFibGVkQhoKGF9mbHV0dGVyd2F2ZV93ZWJob29rX3VybEIkCiJfc3RhbGVfcmVjb25jaWxlcl9pbnRlcnZhbF9zZWNvbmRzQiYKJF9yb2xsYmFja19wcm9jZXNzb3JfaW50ZXJ2YWxfc2Vjb25kc0IiCiBfaG9sZF9leHRlbnNpb25faW50ZXJ2YWxfc2Vjb25kc0IkCiJfYmF0Y2hfc3VwZXJ2aXNvcl9pbnRlcnZhbF9zZWNvbmRzQiQKIl9iYXRjaF9zZXR0bGVtZW50X2ludGVydmFsX3NlY29uZHNCIgogX2JhdGNoX3JvbGxiYWNrX2ludGVydmFsX3NlY29uZHNCJQojX2JhdGNoX2hvbGRfZXhwaXJ5X2ludGVydmFsX3NlY29uZHM=');
@$core.Deprecated('Use transferAsyncConfigDescriptor instead')
const TransferAsyncConfig$json = const {
  '1': 'TransferAsyncConfig',
  '2': const [
    const {'1': 'async_external_transfer_enabled', '3': 1, '4': 1, '5': 8, '10': 'asyncExternalTransferEnabled'},
    const {'1': 'async_batch_transfer_enabled', '3': 2, '4': 1, '5': 8, '10': 'asyncBatchTransferEnabled'},
    const {'1': 'flutterwave_webhook_url', '3': 3, '4': 1, '5': 9, '10': 'flutterwaveWebhookUrl'},
    const {'1': 'flutterwave_webhook_url_updated_at', '3': 4, '4': 1, '5': 9, '10': 'flutterwaveWebhookUrlUpdatedAt'},
    const {'1': 'stale_reconciler_interval_seconds', '3': 10, '4': 1, '5': 5, '10': 'staleReconcilerIntervalSeconds'},
    const {'1': 'rollback_processor_interval_seconds', '3': 11, '4': 1, '5': 5, '10': 'rollbackProcessorIntervalSeconds'},
    const {'1': 'hold_extension_interval_seconds', '3': 12, '4': 1, '5': 5, '10': 'holdExtensionIntervalSeconds'},
    const {'1': 'batch_supervisor_interval_seconds', '3': 13, '4': 1, '5': 5, '10': 'batchSupervisorIntervalSeconds'},
    const {'1': 'batch_settlement_interval_seconds', '3': 14, '4': 1, '5': 5, '10': 'batchSettlementIntervalSeconds'},
    const {'1': 'batch_rollback_interval_seconds', '3': 15, '4': 1, '5': 5, '10': 'batchRollbackIntervalSeconds'},
    const {'1': 'batch_hold_expiry_interval_seconds', '3': 16, '4': 1, '5': 5, '10': 'batchHoldExpiryIntervalSeconds'},
  ],
};

/// Descriptor for `TransferAsyncConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferAsyncConfigDescriptor = $convert.base64Decode('ChNUcmFuc2ZlckFzeW5jQ29uZmlnEkUKH2FzeW5jX2V4dGVybmFsX3RyYW5zZmVyX2VuYWJsZWQYASABKAhSHGFzeW5jRXh0ZXJuYWxUcmFuc2ZlckVuYWJsZWQSPwocYXN5bmNfYmF0Y2hfdHJhbnNmZXJfZW5hYmxlZBgCIAEoCFIZYXN5bmNCYXRjaFRyYW5zZmVyRW5hYmxlZBI2ChdmbHV0dGVyd2F2ZV93ZWJob29rX3VybBgDIAEoCVIVZmx1dHRlcndhdmVXZWJob29rVXJsEkoKImZsdXR0ZXJ3YXZlX3dlYmhvb2tfdXJsX3VwZGF0ZWRfYXQYBCABKAlSHmZsdXR0ZXJ3YXZlV2ViaG9va1VybFVwZGF0ZWRBdBJJCiFzdGFsZV9yZWNvbmNpbGVyX2ludGVydmFsX3NlY29uZHMYCiABKAVSHnN0YWxlUmVjb25jaWxlckludGVydmFsU2Vjb25kcxJNCiNyb2xsYmFja19wcm9jZXNzb3JfaW50ZXJ2YWxfc2Vjb25kcxgLIAEoBVIgcm9sbGJhY2tQcm9jZXNzb3JJbnRlcnZhbFNlY29uZHMSRQofaG9sZF9leHRlbnNpb25faW50ZXJ2YWxfc2Vjb25kcxgMIAEoBVIcaG9sZEV4dGVuc2lvbkludGVydmFsU2Vjb25kcxJJCiFiYXRjaF9zdXBlcnZpc29yX2ludGVydmFsX3NlY29uZHMYDSABKAVSHmJhdGNoU3VwZXJ2aXNvckludGVydmFsU2Vjb25kcxJJCiFiYXRjaF9zZXR0bGVtZW50X2ludGVydmFsX3NlY29uZHMYDiABKAVSHmJhdGNoU2V0dGxlbWVudEludGVydmFsU2Vjb25kcxJFCh9iYXRjaF9yb2xsYmFja19pbnRlcnZhbF9zZWNvbmRzGA8gASgFUhxiYXRjaFJvbGxiYWNrSW50ZXJ2YWxTZWNvbmRzEkoKImJhdGNoX2hvbGRfZXhwaXJ5X2ludGVydmFsX3NlY29uZHMYECABKAVSHmJhdGNoSG9sZEV4cGlyeUludGVydmFsU2Vjb25kcw==');
@$core.Deprecated('Use adminForceRefundTransferRequestDescriptor instead')
const AdminForceRefundTransferRequest$json = const {
  '1': 'AdminForceRefundTransferRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminForceRefundTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceRefundTransferRequestDescriptor = $convert.base64Decode('Ch9BZG1pbkZvcmNlUmVmdW5kVHJhbnNmZXJSZXF1ZXN0EhwKCXJlZmVyZW5jZRgBIAEoCVIJcmVmZXJlbmNlEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29u');
@$core.Deprecated('Use adminForceRefundTransferResponseDescriptor instead')
const AdminForceRefundTransferResponse$json = const {
  '1': 'AdminForceRefundTransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'rollback_record_id', '3': 2, '4': 1, '5': 9, '10': 'rollbackRecordId'},
    const {'1': 'payment_id', '3': 3, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminForceRefundTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceRefundTransferResponseDescriptor = $convert.base64Decode('CiBBZG1pbkZvcmNlUmVmdW5kVHJhbnNmZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiwKEnJvbGxiYWNrX3JlY29yZF9pZBgCIAEoCVIQcm9sbGJhY2tSZWNvcmRJZBIdCgpwYXltZW50X2lkGAMgASgJUglwYXltZW50SWQSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use adminManualReconcileTransferRequestDescriptor instead')
const AdminManualReconcileTransferRequest$json = const {
  '1': 'AdminManualReconcileTransferRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminManualReconcileTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminManualReconcileTransferRequestDescriptor = $convert.base64Decode('CiNBZG1pbk1hbnVhbFJlY29uY2lsZVRyYW5zZmVyUmVxdWVzdBIcCglyZWZlcmVuY2UYASABKAlSCXJlZmVyZW5jZRIWCgZyZWFzb24YAiABKAlSBnJlYXNvbg==');
@$core.Deprecated('Use adminManualReconcileTransferResponseDescriptor instead')
const AdminManualReconcileTransferResponse$json = const {
  '1': 'AdminManualReconcileTransferResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'payment_id', '3': 2, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'old_status', '3': 3, '4': 1, '5': 9, '10': 'oldStatus'},
    const {'1': 'new_status', '3': 4, '4': 1, '5': 9, '10': 'newStatus'},
    const {'1': 'provider_status', '3': 5, '4': 1, '5': 9, '10': 'providerStatus'},
    const {'1': 'complete_message', '3': 6, '4': 1, '5': 9, '10': 'completeMessage'},
    const {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminManualReconcileTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminManualReconcileTransferResponseDescriptor = $convert.base64Decode('CiRBZG1pbk1hbnVhbFJlY29uY2lsZVRyYW5zZmVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgpwYXltZW50X2lkGAIgASgJUglwYXltZW50SWQSHQoKb2xkX3N0YXR1cxgDIAEoCVIJb2xkU3RhdHVzEh0KCm5ld19zdGF0dXMYBCABKAlSCW5ld1N0YXR1cxInCg9wcm92aWRlcl9zdGF0dXMYBSABKAlSDnByb3ZpZGVyU3RhdHVzEikKEGNvbXBsZXRlX21lc3NhZ2UYBiABKAlSD2NvbXBsZXRlTWVzc2FnZRIYCgdtZXNzYWdlGAcgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use adminGetExternalTransferFeeAuditRequestDescriptor instead')
const AdminGetExternalTransferFeeAuditRequest$json = const {
  '1': 'AdminGetExternalTransferFeeAuditRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `AdminGetExternalTransferFeeAuditRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetExternalTransferFeeAuditRequestDescriptor = $convert.base64Decode('CidBZG1pbkdldEV4dGVybmFsVHJhbnNmZXJGZWVBdWRpdFJlcXVlc3QSHQoKc3RhcnRfZGF0ZRgBIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAIgASgJUgdlbmREYXRlEhQKBWxpbWl0GAMgASgFUgVsaW1pdBIWCgZvZmZzZXQYBCABKAVSBm9mZnNldA==');
@$core.Deprecated('Use externalTransferFeeAuditRowDescriptor instead')
const ExternalTransferFeeAuditRow$json = const {
  '1': 'ExternalTransferFeeAuditRow',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'amount_minor', '3': 2, '4': 1, '5': 3, '10': 'amountMinor'},
    const {'1': 'estimate_minor', '3': 3, '4': 1, '5': 3, '10': 'estimateMinor'},
    const {'1': 'actual_minor', '3': 4, '4': 1, '5': 3, '10': 'actualMinor'},
    const {'1': 'delta_minor', '3': 5, '4': 1, '5': 3, '10': 'deltaMinor'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'has_actual', '3': 8, '4': 1, '5': 8, '10': 'hasActual'},
  ],
};

/// Descriptor for `ExternalTransferFeeAuditRow`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List externalTransferFeeAuditRowDescriptor = $convert.base64Decode('ChtFeHRlcm5hbFRyYW5zZmVyRmVlQXVkaXRSb3cSHAoJcmVmZXJlbmNlGAEgASgJUglyZWZlcmVuY2USIQoMYW1vdW50X21pbm9yGAIgASgDUgthbW91bnRNaW5vchIlCg5lc3RpbWF0ZV9taW5vchgDIAEoA1INZXN0aW1hdGVNaW5vchIhCgxhY3R1YWxfbWlub3IYBCABKANSC2FjdHVhbE1pbm9yEh8KC2RlbHRhX21pbm9yGAUgASgDUgpkZWx0YU1pbm9yEhYKBnN0YXR1cxgGIAEoCVIGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYByABKAlSCWNyZWF0ZWRBdBIdCgpoYXNfYWN0dWFsGAggASgIUgloYXNBY3R1YWw=');
@$core.Deprecated('Use externalTransferFeeAuditSummaryDescriptor instead')
const ExternalTransferFeeAuditSummary$json = const {
  '1': 'ExternalTransferFeeAuditSummary',
  '2': const [
    const {'1': 'count', '3': 1, '4': 1, '5': 3, '10': 'count'},
    const {'1': 'with_actual_count', '3': 2, '4': 1, '5': 3, '10': 'withActualCount'},
    const {'1': 'total_estimate_minor', '3': 3, '4': 1, '5': 3, '10': 'totalEstimateMinor'},
    const {'1': 'total_actual_minor', '3': 4, '4': 1, '5': 3, '10': 'totalActualMinor'},
    const {'1': 'total_overcollected_minor', '3': 5, '4': 1, '5': 3, '10': 'totalOvercollectedMinor'},
    const {'1': 'total_undercollected_minor', '3': 6, '4': 1, '5': 3, '10': 'totalUndercollectedMinor'},
    const {'1': 'net_minor', '3': 7, '4': 1, '5': 3, '10': 'netMinor'},
  ],
};

/// Descriptor for `ExternalTransferFeeAuditSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List externalTransferFeeAuditSummaryDescriptor = $convert.base64Decode('Ch9FeHRlcm5hbFRyYW5zZmVyRmVlQXVkaXRTdW1tYXJ5EhQKBWNvdW50GAEgASgDUgVjb3VudBIqChF3aXRoX2FjdHVhbF9jb3VudBgCIAEoA1IPd2l0aEFjdHVhbENvdW50EjAKFHRvdGFsX2VzdGltYXRlX21pbm9yGAMgASgDUhJ0b3RhbEVzdGltYXRlTWlub3ISLAoSdG90YWxfYWN0dWFsX21pbm9yGAQgASgDUhB0b3RhbEFjdHVhbE1pbm9yEjoKGXRvdGFsX292ZXJjb2xsZWN0ZWRfbWlub3IYBSABKANSF3RvdGFsT3ZlcmNvbGxlY3RlZE1pbm9yEjwKGnRvdGFsX3VuZGVyY29sbGVjdGVkX21pbm9yGAYgASgDUhh0b3RhbFVuZGVyY29sbGVjdGVkTWlub3ISGwoJbmV0X21pbm9yGAcgASgDUghuZXRNaW5vcg==');
@$core.Deprecated('Use adminGetExternalTransferFeeAuditResponseDescriptor instead')
const AdminGetExternalTransferFeeAuditResponse$json = const {
  '1': 'AdminGetExternalTransferFeeAuditResponse',
  '2': const [
    const {'1': 'rows', '3': 1, '4': 3, '5': 11, '6': '.payments.ExternalTransferFeeAuditRow', '10': 'rows'},
    const {'1': 'summary', '3': 2, '4': 1, '5': 11, '6': '.payments.ExternalTransferFeeAuditSummary', '10': 'summary'},
  ],
};

/// Descriptor for `AdminGetExternalTransferFeeAuditResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetExternalTransferFeeAuditResponseDescriptor = $convert.base64Decode('CihBZG1pbkdldEV4dGVybmFsVHJhbnNmZXJGZWVBdWRpdFJlc3BvbnNlEjkKBHJvd3MYASADKAsyJS5wYXltZW50cy5FeHRlcm5hbFRyYW5zZmVyRmVlQXVkaXRSb3dSBHJvd3MSQwoHc3VtbWFyeRgCIAEoCzIpLnBheW1lbnRzLkV4dGVybmFsVHJhbnNmZXJGZWVBdWRpdFN1bW1hcnlSB3N1bW1hcnk=');
@$core.Deprecated('Use getTransferSuccessPredictionRequestDescriptor instead')
const GetTransferSuccessPredictionRequest$json = const {
  '1': 'GetTransferSuccessPredictionRequest',
  '2': const [
    const {'1': 'bank_code', '3': 1, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `GetTransferSuccessPredictionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferSuccessPredictionRequestDescriptor = $convert.base64Decode('CiNHZXRUcmFuc2ZlclN1Y2Nlc3NQcmVkaWN0aW9uUmVxdWVzdBIbCgliYW5rX2NvZGUYASABKAlSCGJhbmtDb2RlEiUKDmFjY291bnRfbnVtYmVyGAIgASgJUg1hY2NvdW50TnVtYmVy');
@$core.Deprecated('Use getTransferSuccessPredictionResponseDescriptor instead')
const GetTransferSuccessPredictionResponse$json = const {
  '1': 'GetTransferSuccessPredictionResponse',
  '2': const [
    const {'1': 'bank_availability_pct', '3': 1, '4': 1, '5': 5, '10': 'bankAvailabilityPct'},
    const {'1': 'bank_band', '3': 2, '4': 1, '5': 9, '10': 'bankBand'},
    const {'1': 'bank_sample_size', '3': 3, '4': 1, '5': 5, '10': 'bankSampleSize'},
    const {'1': 'recipient_trust_band', '3': 4, '4': 1, '5': 9, '10': 'recipientTrustBand'},
    const {'1': 'prior_transfer_count', '3': 5, '4': 1, '5': 5, '10': 'priorTransferCount'},
    const {'1': 'recipient_known_since_unix', '3': 6, '4': 1, '5': 3, '10': 'recipientKnownSinceUnix'},
    const {'1': 'blocklisted', '3': 7, '4': 1, '5': 8, '10': 'blocklisted'},
  ],
};

/// Descriptor for `GetTransferSuccessPredictionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferSuccessPredictionResponseDescriptor = $convert.base64Decode('CiRHZXRUcmFuc2ZlclN1Y2Nlc3NQcmVkaWN0aW9uUmVzcG9uc2USMgoVYmFua19hdmFpbGFiaWxpdHlfcGN0GAEgASgFUhNiYW5rQXZhaWxhYmlsaXR5UGN0EhsKCWJhbmtfYmFuZBgCIAEoCVIIYmFua0JhbmQSKAoQYmFua19zYW1wbGVfc2l6ZRgDIAEoBVIOYmFua1NhbXBsZVNpemUSMAoUcmVjaXBpZW50X3RydXN0X2JhbmQYBCABKAlSEnJlY2lwaWVudFRydXN0QmFuZBIwChRwcmlvcl90cmFuc2Zlcl9jb3VudBgFIAEoBVIScHJpb3JUcmFuc2ZlckNvdW50EjsKGnJlY2lwaWVudF9rbm93bl9zaW5jZV91bml4GAYgASgDUhdyZWNpcGllbnRLbm93blNpbmNlVW5peBIgCgtibG9ja2xpc3RlZBgHIAEoCFILYmxvY2tsaXN0ZWQ=');
@$core.Deprecated('Use savedBatchItemInputDescriptor instead')
const SavedBatchItemInput$json = const {
  '1': 'SavedBatchItemInput',
  '2': const [
    const {'1': 'recipient_type', '3': 1, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'recipient_user_id', '3': 2, '4': 1, '5': 9, '10': 'recipientUserId'},
    const {'1': 'bank_code', '3': 3, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'beneficiary_name', '3': 5, '4': 1, '5': 9, '10': 'beneficiaryName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'narration', '3': 7, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'sort_order', '3': 8, '4': 1, '5': 5, '10': 'sortOrder'},
  ],
};

/// Descriptor for `SavedBatchItemInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List savedBatchItemInputDescriptor = $convert.base64Decode('ChNTYXZlZEJhdGNoSXRlbUlucHV0EiUKDnJlY2lwaWVudF90eXBlGAEgASgJUg1yZWNpcGllbnRUeXBlEioKEXJlY2lwaWVudF91c2VyX2lkGAIgASgJUg9yZWNpcGllbnRVc2VySWQSGwoJYmFua19jb2RlGAMgASgJUghiYW5rQ29kZRIlCg5hY2NvdW50X251bWJlchgEIAEoCVINYWNjb3VudE51bWJlchIpChBiZW5lZmljaWFyeV9uYW1lGAUgASgJUg9iZW5lZmljaWFyeU5hbWUSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSHAoJbmFycmF0aW9uGAcgASgJUgluYXJyYXRpb24SHQoKc29ydF9vcmRlchgIIAEoBVIJc29ydE9yZGVy');
@$core.Deprecated('Use savedBatchItemDescriptor instead')
const SavedBatchItem$json = const {
  '1': 'SavedBatchItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'saved_batch_id', '3': 2, '4': 1, '5': 9, '10': 'savedBatchId'},
    const {'1': 'recipient_type', '3': 3, '4': 1, '5': 9, '10': 'recipientType'},
    const {'1': 'recipient_user_id', '3': 4, '4': 1, '5': 9, '10': 'recipientUserId'},
    const {'1': 'bank_code', '3': 5, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'account_number', '3': 6, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'beneficiary_name', '3': 7, '4': 1, '5': 9, '10': 'beneficiaryName'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'narration', '3': 9, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'sort_order', '3': 10, '4': 1, '5': 5, '10': 'sortOrder'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SavedBatchItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List savedBatchItemDescriptor = $convert.base64Decode('Cg5TYXZlZEJhdGNoSXRlbRIOCgJpZBgBIAEoCVICaWQSJAoOc2F2ZWRfYmF0Y2hfaWQYAiABKAlSDHNhdmVkQmF0Y2hJZBIlCg5yZWNpcGllbnRfdHlwZRgDIAEoCVINcmVjaXBpZW50VHlwZRIqChFyZWNpcGllbnRfdXNlcl9pZBgEIAEoCVIPcmVjaXBpZW50VXNlcklkEhsKCWJhbmtfY29kZRgFIAEoCVIIYmFua0NvZGUSJQoOYWNjb3VudF9udW1iZXIYBiABKAlSDWFjY291bnROdW1iZXISKQoQYmVuZWZpY2lhcnlfbmFtZRgHIAEoCVIPYmVuZWZpY2lhcnlOYW1lEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50EhwKCW5hcnJhdGlvbhgJIAEoCVIJbmFycmF0aW9uEh0KCnNvcnRfb3JkZXIYCiABKAVSCXNvcnRPcmRlchIdCgpjcmVhdGVkX2F0GAsgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgMIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use savedBatchDescriptor instead')
const SavedBatch$json = const {
  '1': 'SavedBatch',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'source_account_id', '3': 5, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'total_amount', '3': 6, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'item_count', '3': 7, '4': 1, '5': 5, '10': 'itemCount'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'items', '3': 10, '4': 3, '5': 11, '6': '.payments.SavedBatchItem', '10': 'items'},
  ],
};

/// Descriptor for `SavedBatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List savedBatchDescriptor = $convert.base64Decode('CgpTYXZlZEJhdGNoEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSKgoRc291cmNlX2FjY291bnRfaWQYBSABKAlSD3NvdXJjZUFjY291bnRJZBIhCgx0b3RhbF9hbW91bnQYBiABKAFSC3RvdGFsQW1vdW50Eh0KCml0ZW1fY291bnQYByABKAVSCWl0ZW1Db3VudBIdCgpjcmVhdGVkX2F0GAggASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgJIAEoCVIJdXBkYXRlZEF0Ei4KBWl0ZW1zGAogAygLMhgucGF5bWVudHMuU2F2ZWRCYXRjaEl0ZW1SBWl0ZW1z');
@$core.Deprecated('Use saveBatchDraftRequestDescriptor instead')
const SaveBatchDraftRequest$json = const {
  '1': 'SaveBatchDraftRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'source_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'items', '3': 4, '4': 3, '5': 11, '6': '.payments.SavedBatchItemInput', '10': 'items'},
  ],
};

/// Descriptor for `SaveBatchDraftRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBatchDraftRequestDescriptor = $convert.base64Decode('ChVTYXZlQmF0Y2hEcmFmdFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3kSKgoRc291cmNlX2FjY291bnRfaWQYAyABKAlSD3NvdXJjZUFjY291bnRJZBIzCgVpdGVtcxgEIAMoCzIdLnBheW1lbnRzLlNhdmVkQmF0Y2hJdGVtSW5wdXRSBWl0ZW1z');
@$core.Deprecated('Use listSavedBatchesRequestDescriptor instead')
const ListSavedBatchesRequest$json = const {
  '1': 'ListSavedBatchesRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `ListSavedBatchesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSavedBatchesRequestDescriptor = $convert.base64Decode('ChdMaXN0U2F2ZWRCYXRjaGVzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAIgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use listSavedBatchesResponseDescriptor instead')
const ListSavedBatchesResponse$json = const {
  '1': 'ListSavedBatchesResponse',
  '2': const [
    const {'1': 'batches', '3': 1, '4': 3, '5': 11, '6': '.payments.SavedBatch', '10': 'batches'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `ListSavedBatchesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSavedBatchesResponseDescriptor = $convert.base64Decode('ChhMaXN0U2F2ZWRCYXRjaGVzUmVzcG9uc2USLgoHYmF0Y2hlcxgBIAMoCzIULnBheW1lbnRzLlNhdmVkQmF0Y2hSB2JhdGNoZXMSFAoFdG90YWwYAiABKANSBXRvdGFsEhQKBWxpbWl0GAMgASgFUgVsaW1pdBIWCgZvZmZzZXQYBCABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getSavedBatchRequestDescriptor instead')
const GetSavedBatchRequest$json = const {
  '1': 'GetSavedBatchRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetSavedBatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSavedBatchRequestDescriptor = $convert.base64Decode('ChRHZXRTYXZlZEJhdGNoUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use updateSavedBatchRequestDescriptor instead')
const UpdateSavedBatchRequest$json = const {
  '1': 'UpdateSavedBatchRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `UpdateSavedBatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSavedBatchRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVTYXZlZEJhdGNoUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use deleteSavedBatchRequestDescriptor instead')
const DeleteSavedBatchRequest$json = const {
  '1': 'DeleteSavedBatchRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteSavedBatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSavedBatchRequestDescriptor = $convert.base64Decode('ChdEZWxldGVTYXZlZEJhdGNoUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use deleteSavedBatchResponseDescriptor instead')
const DeleteSavedBatchResponse$json = const {
  '1': 'DeleteSavedBatchResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteSavedBatchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSavedBatchResponseDescriptor = $convert.base64Decode('ChhEZWxldGVTYXZlZEJhdGNoUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');
@$core.Deprecated('Use addSavedBatchItemRequestDescriptor instead')
const AddSavedBatchItemRequest$json = const {
  '1': 'AddSavedBatchItemRequest',
  '2': const [
    const {'1': 'saved_batch_id', '3': 1, '4': 1, '5': 9, '10': 'savedBatchId'},
    const {'1': 'item', '3': 2, '4': 1, '5': 11, '6': '.payments.SavedBatchItemInput', '10': 'item'},
  ],
};

/// Descriptor for `AddSavedBatchItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addSavedBatchItemRequestDescriptor = $convert.base64Decode('ChhBZGRTYXZlZEJhdGNoSXRlbVJlcXVlc3QSJAoOc2F2ZWRfYmF0Y2hfaWQYASABKAlSDHNhdmVkQmF0Y2hJZBIxCgRpdGVtGAIgASgLMh0ucGF5bWVudHMuU2F2ZWRCYXRjaEl0ZW1JbnB1dFIEaXRlbQ==');
@$core.Deprecated('Use removeSavedBatchItemRequestDescriptor instead')
const RemoveSavedBatchItemRequest$json = const {
  '1': 'RemoveSavedBatchItemRequest',
  '2': const [
    const {'1': 'saved_batch_id', '3': 1, '4': 1, '5': 9, '10': 'savedBatchId'},
    const {'1': 'item_id', '3': 2, '4': 1, '5': 9, '10': 'itemId'},
  ],
};

/// Descriptor for `RemoveSavedBatchItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeSavedBatchItemRequestDescriptor = $convert.base64Decode('ChtSZW1vdmVTYXZlZEJhdGNoSXRlbVJlcXVlc3QSJAoOc2F2ZWRfYmF0Y2hfaWQYASABKAlSDHNhdmVkQmF0Y2hJZBIXCgdpdGVtX2lkGAIgASgJUgZpdGVtSWQ=');
@$core.Deprecated('Use updateSavedBatchItemAmountRequestDescriptor instead')
const UpdateSavedBatchItemAmountRequest$json = const {
  '1': 'UpdateSavedBatchItemAmountRequest',
  '2': const [
    const {'1': 'saved_batch_id', '3': 1, '4': 1, '5': 9, '10': 'savedBatchId'},
    const {'1': 'item_id', '3': 2, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `UpdateSavedBatchItemAmountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSavedBatchItemAmountRequestDescriptor = $convert.base64Decode('CiFVcGRhdGVTYXZlZEJhdGNoSXRlbUFtb3VudFJlcXVlc3QSJAoOc2F2ZWRfYmF0Y2hfaWQYASABKAlSDHNhdmVkQmF0Y2hJZBIXCgdpdGVtX2lkGAIgASgJUgZpdGVtSWQSFgoGYW1vdW50GAMgASgBUgZhbW91bnQ=');
@$core.Deprecated('Use applyCollectiveAmountRequestDescriptor instead')
const ApplyCollectiveAmountRequest$json = const {
  '1': 'ApplyCollectiveAmountRequest',
  '2': const [
    const {'1': 'saved_batch_id', '3': 1, '4': 1, '5': 9, '10': 'savedBatchId'},
    const {'1': 'multiplier', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'multiplier'},
    const {'1': 'amount_per_item', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'amountPerItem'},
  ],
  '8': const [
    const {'1': 'mode'},
  ],
};

/// Descriptor for `ApplyCollectiveAmountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List applyCollectiveAmountRequestDescriptor = $convert.base64Decode('ChxBcHBseUNvbGxlY3RpdmVBbW91bnRSZXF1ZXN0EiQKDnNhdmVkX2JhdGNoX2lkGAEgASgJUgxzYXZlZEJhdGNoSWQSIAoKbXVsdGlwbGllchgCIAEoAUgAUgptdWx0aXBsaWVyEigKD2Ftb3VudF9wZXJfaXRlbRgDIAEoAUgAUg1hbW91bnRQZXJJdGVtQgYKBG1vZGU=');
@$core.Deprecated('Use executeFromSavedBatchRequestDescriptor instead')
const ExecuteFromSavedBatchRequest$json = const {
  '1': 'ExecuteFromSavedBatchRequest',
  '2': const [
    const {'1': 'saved_batch_id', '3': 1, '4': 1, '5': 9, '10': 'savedBatchId'},
    const {'1': 'idempotency_key', '3': 2, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'per_item_overrides', '3': 5, '4': 3, '5': 11, '6': '.payments.ExecuteFromSavedBatchRequest.PerItemOverridesEntry', '10': 'perItemOverrides'},
    const {'1': 'source_account_id', '3': 6, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
  '3': const [ExecuteFromSavedBatchRequest_PerItemOverridesEntry$json],
};

@$core.Deprecated('Use executeFromSavedBatchRequestDescriptor instead')
const ExecuteFromSavedBatchRequest_PerItemOverridesEntry$json = const {
  '1': 'PerItemOverridesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ExecuteFromSavedBatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executeFromSavedBatchRequestDescriptor = $convert.base64Decode('ChxFeGVjdXRlRnJvbVNhdmVkQmF0Y2hSZXF1ZXN0EiQKDnNhdmVkX2JhdGNoX2lkGAEgASgJUgxzYXZlZEJhdGNoSWQSJwoPaWRlbXBvdGVuY3lfa2V5GAIgASgJUg5pZGVtcG90ZW5jeUtleRIlCg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBCABKAlSEXZlcmlmaWNhdGlvblRva2VuEmoKEnBlcl9pdGVtX292ZXJyaWRlcxgFIAMoCzI8LnBheW1lbnRzLkV4ZWN1dGVGcm9tU2F2ZWRCYXRjaFJlcXVlc3QuUGVySXRlbU92ZXJyaWRlc0VudHJ5UhBwZXJJdGVtT3ZlcnJpZGVzEioKEXNvdXJjZV9hY2NvdW50X2lkGAYgASgJUg9zb3VyY2VBY2NvdW50SWQaQwoVUGVySXRlbU92ZXJyaWRlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgBUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use batchReceiptItemDescriptor instead')
const BatchReceiptItem$json = const {
  '1': 'BatchReceiptItem',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'fee', '3': 4, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'recipient_name', '3': 7, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'recipient_account', '3': 8, '4': 1, '5': 9, '10': 'recipientAccount'},
    const {'1': 'bank_code', '3': 9, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 10, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'transfer_type', '3': 11, '4': 1, '5': 9, '10': 'transferType'},
    const {'1': 'narration', '3': 12, '4': 1, '5': 9, '10': 'narration'},
    const {'1': 'failure_reason', '3': 13, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'classification', '3': 14, '4': 1, '5': 9, '10': 'classification'},
    const {'1': 'provider_name', '3': 15, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'provider_ref', '3': 16, '4': 1, '5': 9, '10': 'providerRef'},
    const {'1': 'provider_status', '3': 17, '4': 1, '5': 9, '10': 'providerStatus'},
    const {'1': 'payment_id', '3': 18, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'payment_status', '3': 19, '4': 1, '5': 9, '10': 'paymentStatus'},
    const {'1': 'payment_reference', '3': 20, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 22, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'transaction_date', '3': 23, '4': 1, '5': 9, '10': 'transactionDate'},
    const {'1': 'hold_captured_at', '3': 24, '4': 1, '5': 9, '10': 'holdCapturedAt'},
    const {'1': 'hold_released_at', '3': 25, '4': 1, '5': 9, '10': 'holdReleasedAt'},
  ],
};

/// Descriptor for `BatchReceiptItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchReceiptItemDescriptor = $convert.base64Decode('ChBCYXRjaFJlY2VpcHRJdGVtEhcKB2l0ZW1faWQYASABKAlSBml0ZW1JZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIQCgNmZWUYBCABKAFSA2ZlZRIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSHAoJcmVmZXJlbmNlGAYgASgJUglyZWZlcmVuY2USJQoOcmVjaXBpZW50X25hbWUYByABKAlSDXJlY2lwaWVudE5hbWUSKwoRcmVjaXBpZW50X2FjY291bnQYCCABKAlSEHJlY2lwaWVudEFjY291bnQSGwoJYmFua19jb2RlGAkgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYCiABKAlSCGJhbmtOYW1lEiMKDXRyYW5zZmVyX3R5cGUYCyABKAlSDHRyYW5zZmVyVHlwZRIcCgluYXJyYXRpb24YDCABKAlSCW5hcnJhdGlvbhIlCg5mYWlsdXJlX3JlYXNvbhgNIAEoCVINZmFpbHVyZVJlYXNvbhImCg5jbGFzc2lmaWNhdGlvbhgOIAEoCVIOY2xhc3NpZmljYXRpb24SIwoNcHJvdmlkZXJfbmFtZRgPIAEoCVIMcHJvdmlkZXJOYW1lEiEKDHByb3ZpZGVyX3JlZhgQIAEoCVILcHJvdmlkZXJSZWYSJwoPcHJvdmlkZXJfc3RhdHVzGBEgASgJUg5wcm92aWRlclN0YXR1cxIdCgpwYXltZW50X2lkGBIgASgJUglwYXltZW50SWQSJQoOcGF5bWVudF9zdGF0dXMYEyABKAlSDXBheW1lbnRTdGF0dXMSKwoRcGF5bWVudF9yZWZlcmVuY2UYFCABKAlSEHBheW1lbnRSZWZlcmVuY2USHQoKY3JlYXRlZF9hdBgVIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFiABKAlSCXVwZGF0ZWRBdBIpChB0cmFuc2FjdGlvbl9kYXRlGBcgASgJUg90cmFuc2FjdGlvbkRhdGUSKAoQaG9sZF9jYXB0dXJlZF9hdBgYIAEoCVIOaG9sZENhcHR1cmVkQXQSKAoQaG9sZF9yZWxlYXNlZF9hdBgZIAEoCVIOaG9sZFJlbGVhc2VkQXQ=');
@$core.Deprecated('Use batchReceiptDescriptor instead')
const BatchReceipt$json = const {
  '1': 'BatchReceipt',
  '2': const [
    const {'1': 'batch_id', '3': 1, '4': 1, '5': 9, '10': 'batchId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'total_transfers', '3': 5, '4': 1, '5': 5, '10': 'totalTransfers'},
    const {'1': 'successful_transfers', '3': 6, '4': 1, '5': 5, '10': 'successfulTransfers'},
    const {'1': 'failed_transfers', '3': 7, '4': 1, '5': 5, '10': 'failedTransfers'},
    const {'1': 'total_amount', '3': 8, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'total_fees', '3': 9, '4': 1, '5': 1, '10': 'totalFees'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'finalized_at', '3': 12, '4': 1, '5': 9, '10': 'finalizedAt'},
    const {'1': 'source_account_id', '3': 13, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'source_account_number', '3': 14, '4': 1, '5': 9, '10': 'sourceAccountNumber'},
    const {'1': 'source_account_name', '3': 15, '4': 1, '5': 9, '10': 'sourceAccountName'},
    const {'1': 'items', '3': 20, '4': 3, '5': 11, '6': '.payments.BatchReceiptItem', '10': 'items'},
  ],
};

/// Descriptor for `BatchReceipt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchReceiptDescriptor = $convert.base64Decode('CgxCYXRjaFJlY2VpcHQSGQoIYmF0Y2hfaWQYASABKAlSB2JhdGNoSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRInCg90b3RhbF90cmFuc2ZlcnMYBSABKAVSDnRvdGFsVHJhbnNmZXJzEjEKFHN1Y2Nlc3NmdWxfdHJhbnNmZXJzGAYgASgFUhNzdWNjZXNzZnVsVHJhbnNmZXJzEikKEGZhaWxlZF90cmFuc2ZlcnMYByABKAVSD2ZhaWxlZFRyYW5zZmVycxIhCgx0b3RhbF9hbW91bnQYCCABKAFSC3RvdGFsQW1vdW50Eh0KCnRvdGFsX2ZlZXMYCSABKAFSCXRvdGFsRmVlcxIdCgpjcmVhdGVkX2F0GAogASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgLIAEoCVIJdXBkYXRlZEF0EiEKDGZpbmFsaXplZF9hdBgMIAEoCVILZmluYWxpemVkQXQSKgoRc291cmNlX2FjY291bnRfaWQYDSABKAlSD3NvdXJjZUFjY291bnRJZBIyChVzb3VyY2VfYWNjb3VudF9udW1iZXIYDiABKAlSE3NvdXJjZUFjY291bnROdW1iZXISLgoTc291cmNlX2FjY291bnRfbmFtZRgPIAEoCVIRc291cmNlQWNjb3VudE5hbWUSMAoFaXRlbXMYFCADKAsyGi5wYXltZW50cy5CYXRjaFJlY2VpcHRJdGVtUgVpdGVtcw==');
@$core.Deprecated('Use getBatchReceiptRequestDescriptor instead')
const GetBatchReceiptRequest$json = const {
  '1': 'GetBatchReceiptRequest',
  '2': const [
    const {'1': 'batch_id', '3': 1, '4': 1, '5': 9, '10': 'batchId'},
  ],
};

/// Descriptor for `GetBatchReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchReceiptRequestDescriptor = $convert.base64Decode('ChZHZXRCYXRjaFJlY2VpcHRSZXF1ZXN0EhkKCGJhdGNoX2lkGAEgASgJUgdiYXRjaElk');
@$core.Deprecated('Use getBatchItemReceiptRequestDescriptor instead')
const GetBatchItemReceiptRequest$json = const {
  '1': 'GetBatchItemReceiptRequest',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
  ],
};

/// Descriptor for `GetBatchItemReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBatchItemReceiptRequestDescriptor = $convert.base64Decode('ChpHZXRCYXRjaEl0ZW1SZWNlaXB0UmVxdWVzdBIXCgdpdGVtX2lkGAEgASgJUgZpdGVtSWQ=');
@$core.Deprecated('Use batchItemReceiptDescriptor instead')
const BatchItemReceipt$json = const {
  '1': 'BatchItemReceipt',
  '2': const [
    const {'1': 'batch_id', '3': 1, '4': 1, '5': 9, '10': 'batchId'},
    const {'1': 'batch_status', '3': 2, '4': 1, '5': 9, '10': 'batchStatus'},
    const {'1': 'source_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'source_account_number', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountNumber'},
    const {'1': 'source_account_name', '3': 5, '4': 1, '5': 9, '10': 'sourceAccountName'},
    const {'1': 'item', '3': 6, '4': 1, '5': 11, '6': '.payments.BatchReceiptItem', '10': 'item'},
  ],
};

/// Descriptor for `BatchItemReceipt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchItemReceiptDescriptor = $convert.base64Decode('ChBCYXRjaEl0ZW1SZWNlaXB0EhkKCGJhdGNoX2lkGAEgASgJUgdiYXRjaElkEiEKDGJhdGNoX3N0YXR1cxgCIAEoCVILYmF0Y2hTdGF0dXMSKgoRc291cmNlX2FjY291bnRfaWQYAyABKAlSD3NvdXJjZUFjY291bnRJZBIyChVzb3VyY2VfYWNjb3VudF9udW1iZXIYBCABKAlSE3NvdXJjZUFjY291bnROdW1iZXISLgoTc291cmNlX2FjY291bnRfbmFtZRgFIAEoCVIRc291cmNlQWNjb3VudE5hbWUSLgoEaXRlbRgGIAEoCzIaLnBheW1lbnRzLkJhdGNoUmVjZWlwdEl0ZW1SBGl0ZW0=');
