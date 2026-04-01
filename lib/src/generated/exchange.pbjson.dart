///
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use exchangeStatusDescriptor instead')
const ExchangeStatus$json = const {
  '1': 'ExchangeStatus',
  '2': const [
    const {'1': 'PENDING', '2': 0},
    const {'1': 'PROCESSING', '2': 1},
    const {'1': 'COMPLETED', '2': 2},
    const {'1': 'FAILED', '2': 3},
    const {'1': 'CANCELLED', '2': 4},
  ],
};

/// Descriptor for `ExchangeStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List exchangeStatusDescriptor = $convert.base64Decode('Cg5FeGNoYW5nZVN0YXR1cxILCgdQRU5ESU5HEAASDgoKUFJPQ0VTU0lORxABEg0KCUNPTVBMRVRFRBACEgoKBkZBSUxFRBADEg0KCUNBTkNFTExFRBAE');
@$core.Deprecated('Use exchangeTypeDescriptor instead')
const ExchangeType$json = const {
  '1': 'ExchangeType',
  '2': const [
    const {'1': 'EXCHANGE_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'CONVERSION', '2': 1},
    const {'1': 'INTERNATIONAL', '2': 2},
  ],
};

/// Descriptor for `ExchangeType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List exchangeTypeDescriptor = $convert.base64Decode('CgxFeGNoYW5nZVR5cGUSHQoZRVhDSEFOR0VfVFlQRV9VTlNQRUNJRklFRBAAEg4KCkNPTlZFUlNJT04QARIRCg1JTlRFUk5BVElPTkFMEAI=');
@$core.Deprecated('Use getExchangeRateRequestDescriptor instead')
const GetExchangeRateRequest$json = const {
  '1': 'GetExchangeRateRequest',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'toCurrency'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '8': const {}, '10': 'amount'},
  ],
  '7': const {},
};

/// Descriptor for `GetExchangeRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateRequestDescriptor = $convert.base64Decode('ChZHZXRFeGNoYW5nZVJhdGVSZXF1ZXN0ElgKDWZyb21fY3VycmVuY3kYASABKAlCM5JBMDIuVGhlIGN1cnJlbmN5IGNvZGUgdG8gY29udmVydCBmcm9tIChlLmcuLCBOR04pLlIMZnJvbUN1cnJlbmN5ElIKC3RvX2N1cnJlbmN5GAIgASgJQjGSQS4yLFRoZSBjdXJyZW5jeSBjb2RlIHRvIGNvbnZlcnQgdG8gKGUuZy4sIFVTRCkuUgp0b0N1cnJlbmN5EkEKBmFtb3VudBgDIAEoAUIpkkEmMiRPcHRpb25hbCBhbW91bnQgZm9yIGZlZSBjYWxjdWxhdGlvbi5SBmFtb3VudDp8kkF5CncqGUdldCBFeGNoYW5nZSBSYXRlIFJlcXVlc3QyPFBheWxvYWQgdG8gcmVxdWVzdCB0aGUgZXhjaGFuZ2UgcmF0ZSBiZXR3ZWVuIHR3byBjdXJyZW5jaWVzLtIBDWZyb21fY3VycmVuY3nSAQt0b19jdXJyZW5jeQ==');
@$core.Deprecated('Use getExchangeRateResponseDescriptor instead')
const GetExchangeRateResponse$json = const {
  '1': 'GetExchangeRateResponse',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    const {'1': 'fee', '3': 5, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'fee_percentage', '3': 6, '4': 1, '5': 1, '10': 'feePercentage'},
    const {'1': 'rate_valid_seconds', '3': 7, '4': 1, '5': 5, '10': 'rateValidSeconds'},
    const {'1': 'rate_id', '3': 8, '4': 1, '5': 9, '10': 'rateId'},
  ],
  '7': const {},
};

/// Descriptor for `GetExchangeRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateResponseDescriptor = $convert.base64Decode('ChdHZXRFeGNoYW5nZVJhdGVSZXNwb25zZRIjCg1mcm9tX2N1cnJlbmN5GAEgASgJUgxmcm9tQ3VycmVuY3kSHwoLdG9fY3VycmVuY3kYAiABKAlSCnRvQ3VycmVuY3kSEgoEcmF0ZRgDIAEoAVIEcmF0ZRI4Cgl0aW1lc3RhbXAYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXASEAoDZmVlGAUgASgBUgNmZWUSJQoOZmVlX3BlcmNlbnRhZ2UYBiABKAFSDWZlZVBlcmNlbnRhZ2USLAoScmF0ZV92YWxpZF9zZWNvbmRzGAcgASgFUhByYXRlVmFsaWRTZWNvbmRzEhcKB3JhdGVfaWQYCCABKAlSBnJhdGVJZDpZkkFWClQqGkdldCBFeGNoYW5nZSBSYXRlIFJlc3BvbnNlMjZDb250YWlucyB0aGUgY3VycmVudCBleGNoYW5nZSByYXRlIHdpdGggZmVlIGJyZWFrZG93bi4=');
@$core.Deprecated('Use receiverDetailsDescriptor instead')
const ReceiverDetails$json = const {
  '1': 'ReceiverDetails',
  '2': const [
    const {'1': 'full_name', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_name', '3': 3, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'swift_bic_code', '3': 4, '4': 1, '5': 9, '10': 'swiftBicCode'},
    const {'1': 'country', '3': 5, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'bank_code', '3': 6, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'email', '3': 7, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'routing_number', '3': 8, '4': 1, '5': 9, '10': 'routingNumber'},
    const {'1': 'branch_code', '3': 9, '4': 1, '5': 9, '10': 'branchCode'},
    const {'1': 'phone', '3': 10, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'address', '3': 11, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `ReceiverDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiverDetailsDescriptor = $convert.base64Decode('Cg9SZWNlaXZlckRldGFpbHMSGwoJZnVsbF9uYW1lGAEgASgJUghmdWxsTmFtZRIlCg5hY2NvdW50X251bWJlchgCIAEoCVINYWNjb3VudE51bWJlchIbCgliYW5rX25hbWUYAyABKAlSCGJhbmtOYW1lEiQKDnN3aWZ0X2JpY19jb2RlGAQgASgJUgxzd2lmdEJpY0NvZGUSGAoHY291bnRyeRgFIAEoCVIHY291bnRyeRIbCgliYW5rX2NvZGUYBiABKAlSCGJhbmtDb2RlEhQKBWVtYWlsGAcgASgJUgVlbWFpbBIlCg5yb3V0aW5nX251bWJlchgIIAEoCVINcm91dGluZ051bWJlchIfCgticmFuY2hfY29kZRgJIAEoCVIKYnJhbmNoQ29kZRIUCgVwaG9uZRgKIAEoCVIFcGhvbmUSGAoHYWRkcmVzcxgLIAEoCVIHYWRkcmVzcw==');
@$core.Deprecated('Use initiateInternationalTransferRequestDescriptor instead')
const InitiateInternationalTransferRequest$json = const {
  '1': 'InitiateInternationalTransferRequest',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'toCurrency'},
    const {'1': 'amount_from', '3': 3, '4': 1, '5': 1, '8': const {}, '10': 'amountFrom'},
    const {'1': 'receiver_details', '3': 4, '4': 1, '5': 11, '6': '.exchange.ReceiverDetails', '8': const {}, '10': 'receiverDetails'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '8': const {}, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '8': const {}, '10': 'idempotencyKey'},
    const {'1': 'rate_id', '3': 7, '4': 1, '5': 9, '8': const {}, '10': 'rateId'},
    const {'1': 'purpose_of_payment', '3': 8, '4': 1, '5': 9, '8': const {}, '10': 'purposeOfPayment'},
  ],
  '7': const {},
};

/// Descriptor for `InitiateInternationalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferRequestDescriptor = $convert.base64Decode('CiRJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlcXVlc3QSVQoNZnJvbV9jdXJyZW5jeRgBIAEoCUIwkkEtMitUaGUgY3VycmVuY3kgY29kZSB0byBzZW5kIGZyb20gKGUuZy4sIE5HTikuUgxmcm9tQ3VycmVuY3kSVgoLdG9fY3VycmVuY3kYAiABKAlCNZJBMjIwVGhlIGN1cnJlbmN5IGNvZGUgdGhlIHJlY2VpdmVyIGdldHMgKGUuZy4sIFVTRCkuUgp0b0N1cnJlbmN5ElMKC2Ftb3VudF9mcm9tGAMgASgBQjKSQS8yLVRoZSBhbW91bnQgdG8gYmUgc2VudCBpbiB0aGUgJ2Zyb21fY3VycmVuY3knLlIKYW1vdW50RnJvbRJkChByZWNlaXZlcl9kZXRhaWxzGAQgASgLMhkuZXhjaGFuZ2UuUmVjZWl2ZXJEZXRhaWxzQh6SQRsyGURldGFpbHMgb2YgdGhlIHJlY2lwaWVudC5SD3JlY2VpdmVyRGV0YWlscxJdChJ2ZXJpZmljYXRpb25fdG9rZW4YBSABKAlCLpJBKzIpUElOIHZlcmlmaWNhdGlvbiB0b2tlbiBmcm9tIGF1dGgtc2VydmljZS5SEXZlcmlmaWNhdGlvblRva2VuEl0KD2lkZW1wb3RlbmN5X2tleRgGIAEoCUI0kkExMi9DbGllbnQtZ2VuZXJhdGVkIFVVSUQgZm9yIGR1cGxpY2F0ZSBwcmV2ZW50aW9uLlIOaWRlbXBvdGVuY3lLZXkSTwoHcmF0ZV9pZBgHIAEoCUI2kkEzMjFSYXRlIElEIGZyb20gR2V0RXhjaGFuZ2VSYXRlIGZvciBzdGFsZW5lc3MgY2hlY2suUgZyYXRlSWQSaAoScHVycG9zZV9vZl9wYXltZW50GAggASgJQjqSQTcyNVJlYXNvbiBmb3IgdHJhbnNmZXIgKGUuZy4sIGZhbWlseV9zdXBwb3J0LCBidXNpbmVzcykuUhBwdXJwb3NlT2ZQYXltZW50OtkBkkHVAQrSASonSW5pdGlhdGUgSW50ZXJuYXRpb25hbCBUcmFuc2ZlciBSZXF1ZXN0MkFQYXlsb2FkIHRvIHN0YXJ0IGFuIGludGVybmF0aW9uYWwgY3VycmVuY3kgZXhjaGFuZ2UgYW5kIHRyYW5zZmVyLtIBDWZyb21fY3VycmVuY3nSAQt0b19jdXJyZW5jedIBC2Ftb3VudF9mcm9t0gEQcmVjZWl2ZXJfZGV0YWlsc9IBEnZlcmlmaWNhdGlvbl90b2tlbtIBD2lkZW1wb3RlbmN5X2tleQ==');
@$core.Deprecated('Use exchangeTransactionDescriptor instead')
const ExchangeTransaction$json = const {
  '1': 'ExchangeTransaction',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'from_currency', '3': 3, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 4, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'amount_from', '3': 5, '4': 1, '5': 1, '10': 'amountFrom'},
    const {'1': 'amount_to', '3': 6, '4': 1, '5': 1, '10': 'amountTo'},
    const {'1': 'exchange_rate', '3': 7, '4': 1, '5': 1, '10': 'exchangeRate'},
    const {'1': 'fees', '3': 8, '4': 1, '5': 1, '10': 'fees'},
    const {'1': 'receiver_details', '3': 9, '4': 1, '5': 11, '6': '.exchange.ReceiverDetails', '10': 'receiverDetails'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.exchange.ExchangeStatus', '10': 'status'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'provider_reference', '3': 14, '4': 1, '5': 9, '10': 'providerReference'},
    const {'1': 'exchange_type', '3': 15, '4': 1, '5': 14, '6': '.exchange.ExchangeType', '10': 'exchangeType'},
    const {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `ExchangeTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeTransactionDescriptor = $convert.base64Decode('ChNFeGNoYW5nZVRyYW5zYWN0aW9uEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIjCg1mcm9tX2N1cnJlbmN5GAMgASgJUgxmcm9tQ3VycmVuY3kSHwoLdG9fY3VycmVuY3kYBCABKAlSCnRvQ3VycmVuY3kSHwoLYW1vdW50X2Zyb20YBSABKAFSCmFtb3VudEZyb20SGwoJYW1vdW50X3RvGAYgASgBUghhbW91bnRUbxIjCg1leGNoYW5nZV9yYXRlGAcgASgBUgxleGNoYW5nZVJhdGUSEgoEZmVlcxgIIAEoAVIEZmVlcxJEChByZWNlaXZlcl9kZXRhaWxzGAkgASgLMhkuZXhjaGFuZ2UuUmVjZWl2ZXJEZXRhaWxzUg9yZWNlaXZlckRldGFpbHMSMAoGc3RhdHVzGAogASgOMhguZXhjaGFuZ2UuRXhjaGFuZ2VTdGF0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSHAoJcmVmZXJlbmNlGA0gASgJUglyZWZlcmVuY2USLQoScHJvdmlkZXJfcmVmZXJlbmNlGA4gASgJUhFwcm92aWRlclJlZmVyZW5jZRI7Cg1leGNoYW5nZV90eXBlGA8gASgOMhYuZXhjaGFuZ2UuRXhjaGFuZ2VUeXBlUgxleGNoYW5nZVR5cGUSJQoOZmFpbHVyZV9yZWFzb24YECABKAlSDWZhaWx1cmVSZWFzb24=');
@$core.Deprecated('Use initiateInternationalTransferResponseDescriptor instead')
const InitiateInternationalTransferResponse$json = const {
  '1': 'InitiateInternationalTransferResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.exchange.ExchangeTransaction', '10': 'transaction'},
  ],
  '7': const {},
};

/// Descriptor for `InitiateInternationalTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferResponseDescriptor = $convert.base64Decode('CiVJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlc3BvbnNlEj8KC3RyYW5zYWN0aW9uGAEgASgLMh0uZXhjaGFuZ2UuRXhjaGFuZ2VUcmFuc2FjdGlvblILdHJhbnNhY3Rpb246XJJBWQpXKihJbml0aWF0ZSBJbnRlcm5hdGlvbmFsIFRyYW5zZmVyIFJlc3BvbnNlMitDb250YWlucyBkZXRhaWxzIG9mIHRoZSBpbml0aWF0ZWQgdHJhbnNmZXIu');
@$core.Deprecated('Use getRecentExchangesRequestDescriptor instead')
const GetRecentExchangesRequest$json = const {
  '1': 'GetRecentExchangesRequest',
  '2': const [
    const {'1': 'page_size', '3': 1, '4': 1, '5': 5, '8': const {}, '10': 'pageSize'},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'pageToken'},
  ],
  '7': const {},
};

/// Descriptor for `GetRecentExchangesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentExchangesRequestDescriptor = $convert.base64Decode('ChlHZXRSZWNlbnRFeGNoYW5nZXNSZXF1ZXN0Ek8KCXBhZ2Vfc2l6ZRgBIAEoBUIykkEvMi1OdW1iZXIgb2YgdHJhbnNhY3Rpb25zIHBlciBwYWdlLiBEZWZhdWx0OiAyMC5SCHBhZ2VTaXplEkUKCnBhZ2VfdG9rZW4YAiABKAlCJpJBIzIhVG9rZW4gZm9yIGZldGNoaW5nIHRoZSBuZXh0IHBhZ2UuUglwYWdlVG9rZW46WZJBVgpUKhxHZXQgUmVjZW50IEV4Y2hhbmdlcyBSZXF1ZXN0MjRQYXlsb2FkIGZvciByZXRyaWV2aW5nIHJlY2VudCBleGNoYW5nZSB0cmFuc2FjdGlvbnMu');
@$core.Deprecated('Use getRecentExchangesResponseDescriptor instead')
const GetRecentExchangesResponse$json = const {
  '1': 'GetRecentExchangesResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.exchange.ExchangeTransaction', '10': 'transactions'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
  '7': const {},
};

/// Descriptor for `GetRecentExchangesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentExchangesResponseDescriptor = $convert.base64Decode('ChpHZXRSZWNlbnRFeGNoYW5nZXNSZXNwb25zZRJBCgx0cmFuc2FjdGlvbnMYASADKAsyHS5leGNoYW5nZS5FeGNoYW5nZVRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2VuOkuSQUgKRiodR2V0IFJlY2VudCBFeGNoYW5nZXMgUmVzcG9uc2UyJUxpc3Qgb2YgcmVjZW50IGV4Y2hhbmdlIHRyYW5zYWN0aW9ucy4=');
@$core.Deprecated('Use convertCurrencyRequestDescriptor instead')
const ConvertCurrencyRequest$json = const {
  '1': 'ConvertCurrencyRequest',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'toCurrency'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '8': const {}, '10': 'amount'},
    const {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '8': const {}, '10': 'idempotencyKey'},
    const {'1': 'rate_id', '3': 6, '4': 1, '5': 9, '8': const {}, '10': 'rateId'},
  ],
  '7': const {},
};

/// Descriptor for `ConvertCurrencyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCurrencyRequestDescriptor = $convert.base64Decode('ChZDb252ZXJ0Q3VycmVuY3lSZXF1ZXN0EksKDWZyb21fY3VycmVuY3kYASABKAlCJpJBIzIhU291cmNlIGN1cnJlbmN5IGNvZGUgKGUuZy4sIE5HTikuUgxmcm9tQ3VycmVuY3kSTAoLdG9fY3VycmVuY3kYAiABKAlCK5JBKDImRGVzdGluYXRpb24gY3VycmVuY3kgY29kZSAoZS5nLiwgVVNEKS5SCnRvQ3VycmVuY3kSQgoGYW1vdW50GAMgASgBQiqSQScyJUFtb3VudCB0byBjb252ZXJ0IGluIHNvdXJjZSBjdXJyZW5jeS5SBmFtb3VudBJLChJ2ZXJpZmljYXRpb25fdG9rZW4YBCABKAlCHJJBGTIXUElOIHZlcmlmaWNhdGlvbiB0b2tlbi5SEXZlcmlmaWNhdGlvblRva2VuEl0KD2lkZW1wb3RlbmN5X2tleRgFIAEoCUI0kkExMi9DbGllbnQtZ2VuZXJhdGVkIFVVSUQgZm9yIGR1cGxpY2F0ZSBwcmV2ZW50aW9uLlIOaWRlbXBvdGVuY3lLZXkSPwoHcmF0ZV9pZBgGIAEoCUImkkEjMiFSYXRlIElEIGZvciBzdGFsZW5lc3MgdmFsaWRhdGlvbi5SBnJhdGVJZDqiAZJBngEKmwEqGENvbnZlcnQgQ3VycmVuY3kgUmVxdWVzdDIxUGF5bG9hZCBmb3Igd2FsbGV0LXRvLXdhbGxldCBjdXJyZW5jeSBjb252ZXJzaW9uLtIBDWZyb21fY3VycmVuY3nSAQt0b19jdXJyZW5jedIBBmFtb3VudNIBEnZlcmlmaWNhdGlvbl90b2tlbtIBD2lkZW1wb3RlbmN5X2tleQ==');
@$core.Deprecated('Use convertCurrencyResponseDescriptor instead')
const ConvertCurrencyResponse$json = const {
  '1': 'ConvertCurrencyResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.exchange.ExchangeTransaction', '10': 'transaction'},
  ],
  '7': const {},
};

/// Descriptor for `ConvertCurrencyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCurrencyResponseDescriptor = $convert.base64Decode('ChdDb252ZXJ0Q3VycmVuY3lSZXNwb25zZRI/Cgt0cmFuc2FjdGlvbhgBIAEoCzIdLmV4Y2hhbmdlLkV4Y2hhbmdlVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uOkiSQUUKQyoZQ29udmVydCBDdXJyZW5jeSBSZXNwb25zZTImUmVzdWx0IG9mIHdhbGxldC10by13YWxsZXQgY29udmVyc2lvbi4=');
@$core.Deprecated('Use getTransactionStatusRequestDescriptor instead')
const GetTransactionStatusRequest$json = const {
  '1': 'GetTransactionStatusRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'transactionId'},
  ],
  '7': const {},
};

/// Descriptor for `GetTransactionStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatusRequestDescriptor = $convert.base64Decode('ChtHZXRUcmFuc2FjdGlvblN0YXR1c1JlcXVlc3QSSAoOdHJhbnNhY3Rpb25faWQYASABKAlCIZJBHjIcVGhlIGV4Y2hhbmdlIHRyYW5zYWN0aW9uIElELlINdHJhbnNhY3Rpb25JZDpdkkFaClgqHkdldCBUcmFuc2FjdGlvbiBTdGF0dXMgUmVxdWVzdDIlUG9sbCBmb3IgZXhjaGFuZ2UgdHJhbnNhY3Rpb24gc3RhdHVzLtIBDnRyYW5zYWN0aW9uX2lk');
@$core.Deprecated('Use getTransactionStatusResponseDescriptor instead')
const GetTransactionStatusResponse$json = const {
  '1': 'GetTransactionStatusResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.exchange.ExchangeTransaction', '10': 'transaction'},
  ],
  '7': const {},
};

/// Descriptor for `GetTransactionStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatusResponseDescriptor = $convert.base64Decode('ChxHZXRUcmFuc2FjdGlvblN0YXR1c1Jlc3BvbnNlEj8KC3RyYW5zYWN0aW9uGAEgASgLMh0uZXhjaGFuZ2UuRXhjaGFuZ2VUcmFuc2FjdGlvblILdHJhbnNhY3Rpb246UpJBTwpNKh9HZXQgVHJhbnNhY3Rpb24gU3RhdHVzIFJlc3BvbnNlMipDdXJyZW50IHN0YXR1cyBvZiBhbiBleGNoYW5nZSB0cmFuc2FjdGlvbi4=');
@$core.Deprecated('Use getSupportedCurrenciesRequestDescriptor instead')
const GetSupportedCurrenciesRequest$json = const {
  '1': 'GetSupportedCurrenciesRequest',
  '7': const {},
};

/// Descriptor for `GetSupportedCurrenciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCurrenciesRequestDescriptor = $convert.base64Decode('Ch1HZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVxdWVzdDpPkkFMCkoqIEdldCBTdXBwb3J0ZWQgQ3VycmVuY2llcyBSZXF1ZXN0MiZSZXF1ZXN0IHN1cHBvcnRlZCBleGNoYW5nZSBjdXJyZW5jaWVzLg==');
@$core.Deprecated('Use supportedCurrencyDescriptor instead')
const SupportedCurrency$json = const {
  '1': 'SupportedCurrency',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'symbol', '3': 3, '4': 1, '5': 9, '10': 'symbol'},
    const {'1': 'country', '3': 4, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'supports_conversion', '3': 5, '4': 1, '5': 8, '10': 'supportsConversion'},
    const {'1': 'supports_international', '3': 6, '4': 1, '5': 8, '10': 'supportsInternational'},
    const {'1': 'min_amount', '3': 7, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 8, '4': 1, '5': 1, '10': 'maxAmount'},
  ],
};

/// Descriptor for `SupportedCurrency`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List supportedCurrencyDescriptor = $convert.base64Decode('ChFTdXBwb3J0ZWRDdXJyZW5jeRISCgRjb2RlGAEgASgJUgRjb2RlEhIKBG5hbWUYAiABKAlSBG5hbWUSFgoGc3ltYm9sGAMgASgJUgZzeW1ib2wSGAoHY291bnRyeRgEIAEoCVIHY291bnRyeRIvChNzdXBwb3J0c19jb252ZXJzaW9uGAUgASgIUhJzdXBwb3J0c0NvbnZlcnNpb24SNQoWc3VwcG9ydHNfaW50ZXJuYXRpb25hbBgGIAEoCFIVc3VwcG9ydHNJbnRlcm5hdGlvbmFsEh0KCm1pbl9hbW91bnQYByABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAggASgBUgltYXhBbW91bnQ=');
@$core.Deprecated('Use getSupportedCurrenciesResponseDescriptor instead')
const GetSupportedCurrenciesResponse$json = const {
  '1': 'GetSupportedCurrenciesResponse',
  '2': const [
    const {'1': 'currencies', '3': 1, '4': 3, '5': 11, '6': '.exchange.SupportedCurrency', '10': 'currencies'},
  ],
  '7': const {},
};

/// Descriptor for `GetSupportedCurrenciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCurrenciesResponseDescriptor = $convert.base64Decode('Ch5HZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVzcG9uc2USOwoKY3VycmVuY2llcxgBIAMoCzIbLmV4Y2hhbmdlLlN1cHBvcnRlZEN1cnJlbmN5UgpjdXJyZW5jaWVzOlCSQU0KSyohR2V0IFN1cHBvcnRlZCBDdXJyZW5jaWVzIFJlc3BvbnNlMiZMaXN0IG9mIHN1cHBvcnRlZCBleGNoYW5nZSBjdXJyZW5jaWVzLg==');
@$core.Deprecated('Use getExchangeLimitsRequestDescriptor instead')
const GetExchangeLimitsRequest$json = const {
  '1': 'GetExchangeLimitsRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'currency'},
  ],
  '7': const {},
};

/// Descriptor for `GetExchangeLimitsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeLimitsRequestDescriptor = $convert.base64Decode('ChhHZXRFeGNoYW5nZUxpbWl0c1JlcXVlc3QSTQoIY3VycmVuY3kYASABKAlCMZJBLjIsU291cmNlIGN1cnJlbmN5IGZvciBsaW1pdCBjaGVjayAoZS5nLiwgTkdOKS5SCGN1cnJlbmN5OlCSQU0KSyobR2V0IEV4Y2hhbmdlIExpbWl0cyBSZXF1ZXN0MixSZXF1ZXN0IGN1cnJlbnQgdXNlcidzIEZYIGNvbnZlcnNpb24gbGltaXRzLg==');
@$core.Deprecated('Use getExchangeLimitsResponseDescriptor instead')
const GetExchangeLimitsResponse$json = const {
  '1': 'GetExchangeLimitsResponse',
  '2': const [
    const {'1': 'kyc_tier', '3': 1, '4': 1, '5': 5, '10': 'kycTier'},
    const {'1': 'daily_limit', '3': 2, '4': 1, '5': 1, '10': 'dailyLimit'},
    const {'1': 'daily_used', '3': 3, '4': 1, '5': 1, '10': 'dailyUsed'},
    const {'1': 'daily_remaining', '3': 4, '4': 1, '5': 1, '10': 'dailyRemaining'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'min_per_transaction', '3': 6, '4': 1, '5': 1, '10': 'minPerTransaction'},
    const {'1': 'max_per_transaction', '3': 7, '4': 1, '5': 1, '10': 'maxPerTransaction'},
  ],
  '7': const {},
};

/// Descriptor for `GetExchangeLimitsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeLimitsResponseDescriptor = $convert.base64Decode('ChlHZXRFeGNoYW5nZUxpbWl0c1Jlc3BvbnNlEhkKCGt5Y190aWVyGAEgASgFUgdreWNUaWVyEh8KC2RhaWx5X2xpbWl0GAIgASgBUgpkYWlseUxpbWl0Eh0KCmRhaWx5X3VzZWQYAyABKAFSCWRhaWx5VXNlZBInCg9kYWlseV9yZW1haW5pbmcYBCABKAFSDmRhaWx5UmVtYWluaW5nEhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIuChNtaW5fcGVyX3RyYW5zYWN0aW9uGAYgASgBUhFtaW5QZXJUcmFuc2FjdGlvbhIuChNtYXhfcGVyX3RyYW5zYWN0aW9uGAcgASgBUhFtYXhQZXJUcmFuc2FjdGlvbjpbkkFYClYqHEdldCBFeGNoYW5nZSBMaW1pdHMgUmVzcG9uc2UyNkN1cnJlbnQgdXNlcidzIEZYIGNvbnZlcnNpb24gbGltaXRzIGJhc2VkIG9uIEtZQyB0aWVyLg==');
