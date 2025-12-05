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
@$core.Deprecated('Use getExchangeRateRequestDescriptor instead')
const GetExchangeRateRequest$json = const {
  '1': 'GetExchangeRateRequest',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'toCurrency'},
  ],
  '7': const {},
};

/// Descriptor for `GetExchangeRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateRequestDescriptor = $convert.base64Decode('ChZHZXRFeGNoYW5nZVJhdGVSZXF1ZXN0ElgKDWZyb21fY3VycmVuY3kYASABKAlCM5JBMDIuVGhlIGN1cnJlbmN5IGNvZGUgdG8gY29udmVydCBmcm9tIChlLmcuLCBHQlApLlIMZnJvbUN1cnJlbmN5ElIKC3RvX2N1cnJlbmN5GAIgASgJQjGSQS4yLFRoZSBjdXJyZW5jeSBjb2RlIHRvIGNvbnZlcnQgdG8gKGUuZy4sIFVTRCkuUgp0b0N1cnJlbmN5OnySQXkKdyoZR2V0IEV4Y2hhbmdlIFJhdGUgUmVxdWVzdDI8UGF5bG9hZCB0byByZXF1ZXN0IHRoZSBleGNoYW5nZSByYXRlIGJldHdlZW4gdHdvIGN1cnJlbmNpZXMu0gENZnJvbV9jdXJyZW5jedIBC3RvX2N1cnJlbmN5');
@$core.Deprecated('Use getExchangeRateResponseDescriptor instead')
const GetExchangeRateResponse$json = const {
  '1': 'GetExchangeRateResponse',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    const {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
  '7': const {},
};

/// Descriptor for `GetExchangeRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateResponseDescriptor = $convert.base64Decode('ChdHZXRFeGNoYW5nZVJhdGVSZXNwb25zZRIjCg1mcm9tX2N1cnJlbmN5GAEgASgJUgxmcm9tQ3VycmVuY3kSHwoLdG9fY3VycmVuY3kYAiABKAlSCnRvQ3VycmVuY3kSEgoEcmF0ZRgDIAEoAVIEcmF0ZRI4Cgl0aW1lc3RhbXAYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXA6RpJBQwpBKhpHZXQgRXhjaGFuZ2UgUmF0ZSBSZXNwb25zZTIjQ29udGFpbnMgdGhlIGN1cnJlbnQgZXhjaGFuZ2UgcmF0ZS4=');
@$core.Deprecated('Use receiverDetailsDescriptor instead')
const ReceiverDetails$json = const {
  '1': 'ReceiverDetails',
  '2': const [
    const {'1': 'full_name', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_name', '3': 3, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'swift_bic_code', '3': 4, '4': 1, '5': 9, '10': 'swiftBicCode'},
  ],
};

/// Descriptor for `ReceiverDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiverDetailsDescriptor = $convert.base64Decode('Cg9SZWNlaXZlckRldGFpbHMSGwoJZnVsbF9uYW1lGAEgASgJUghmdWxsTmFtZRIlCg5hY2NvdW50X251bWJlchgCIAEoCVINYWNjb3VudE51bWJlchIbCgliYW5rX25hbWUYAyABKAlSCGJhbmtOYW1lEiQKDnN3aWZ0X2JpY19jb2RlGAQgASgJUgxzd2lmdEJpY0NvZGU=');
@$core.Deprecated('Use initiateInternationalTransferRequestDescriptor instead')
const InitiateInternationalTransferRequest$json = const {
  '1': 'InitiateInternationalTransferRequest',
  '2': const [
    const {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'fromCurrency'},
    const {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'toCurrency'},
    const {'1': 'amount_from', '3': 3, '4': 1, '5': 1, '8': const {}, '10': 'amountFrom'},
    const {'1': 'receiver_details', '3': 4, '4': 1, '5': 11, '6': '.pb.ReceiverDetails', '8': const {}, '10': 'receiverDetails'},
  ],
  '7': const {},
};

/// Descriptor for `InitiateInternationalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferRequestDescriptor = $convert.base64Decode('CiRJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlcXVlc3QSVQoNZnJvbV9jdXJyZW5jeRgBIAEoCUIwkkEtMitUaGUgY3VycmVuY3kgY29kZSB0byBzZW5kIGZyb20gKGUuZy4sIEdCUCkuUgxmcm9tQ3VycmVuY3kSVgoLdG9fY3VycmVuY3kYAiABKAlCNZJBMjIwVGhlIGN1cnJlbmN5IGNvZGUgdGhlIHJlY2VpdmVyIGdldHMgKGUuZy4sIFVTRCkuUgp0b0N1cnJlbmN5ElMKC2Ftb3VudF9mcm9tGAMgASgBQjKSQS8yLVRoZSBhbW91bnQgdG8gYmUgc2VudCBpbiB0aGUgJ2Zyb21fY3VycmVuY3knLlIKYW1vdW50RnJvbRJeChByZWNlaXZlcl9kZXRhaWxzGAQgASgLMhMucGIuUmVjZWl2ZXJEZXRhaWxzQh6SQRsyGURldGFpbHMgb2YgdGhlIHJlY2lwaWVudC5SD3JlY2VpdmVyRGV0YWlsczqyAZJBrgEKqwEqJ0luaXRpYXRlIEludGVybmF0aW9uYWwgVHJhbnNmZXIgUmVxdWVzdDJBUGF5bG9hZCB0byBzdGFydCBhbiBpbnRlcm5hdGlvbmFsIGN1cnJlbmN5IGV4Y2hhbmdlIGFuZCB0cmFuc2Zlci7SAQ1mcm9tX2N1cnJlbmN50gELdG9fY3VycmVuY3nSAQthbW91bnRfZnJvbdIBEHJlY2VpdmVyX2RldGFpbHM=');
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
    const {'1': 'receiver_details', '3': 9, '4': 1, '5': 11, '6': '.pb.ReceiverDetails', '10': 'receiverDetails'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.ExchangeStatus', '10': 'status'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `ExchangeTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeTransactionDescriptor = $convert.base64Decode('ChNFeGNoYW5nZVRyYW5zYWN0aW9uEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIjCg1mcm9tX2N1cnJlbmN5GAMgASgJUgxmcm9tQ3VycmVuY3kSHwoLdG9fY3VycmVuY3kYBCABKAlSCnRvQ3VycmVuY3kSHwoLYW1vdW50X2Zyb20YBSABKAFSCmFtb3VudEZyb20SGwoJYW1vdW50X3RvGAYgASgBUghhbW91bnRUbxIjCg1leGNoYW5nZV9yYXRlGAcgASgBUgxleGNoYW5nZVJhdGUSEgoEZmVlcxgIIAEoAVIEZmVlcxI+ChByZWNlaXZlcl9kZXRhaWxzGAkgASgLMhMucGIuUmVjZWl2ZXJEZXRhaWxzUg9yZWNlaXZlckRldGFpbHMSKgoGc3RhdHVzGAogASgOMhIucGIuRXhjaGFuZ2VTdGF0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use initiateInternationalTransferResponseDescriptor instead')
const InitiateInternationalTransferResponse$json = const {
  '1': 'InitiateInternationalTransferResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.pb.ExchangeTransaction', '10': 'transaction'},
  ],
  '7': const {},
};

/// Descriptor for `InitiateInternationalTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferResponseDescriptor = $convert.base64Decode('CiVJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlc3BvbnNlEjkKC3RyYW5zYWN0aW9uGAEgASgLMhcucGIuRXhjaGFuZ2VUcmFuc2FjdGlvblILdHJhbnNhY3Rpb246XJJBWQpXKihJbml0aWF0ZSBJbnRlcm5hdGlvbmFsIFRyYW5zZmVyIFJlc3BvbnNlMitDb250YWlucyBkZXRhaWxzIG9mIHRoZSBpbml0aWF0ZWQgdHJhbnNmZXIu');
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
final $typed_data.Uint8List getRecentExchangesRequestDescriptor = $convert.base64Decode('ChlHZXRSZWNlbnRFeGNoYW5nZXNSZXF1ZXN0Ek8KCXBhZ2Vfc2l6ZRgBIAEoBUIykkEvMi1OdW1iZXIgb2YgdHJhbnNhY3Rpb25zIHBlciBwYWdlLiBEZWZhdWx0OiAyMC5SCHBhZ2VTaXplEmsKCnBhZ2VfdG9rZW4YAiABKAlCTJJBSTJHVG9rZW4gZm9yIGZldGNoaW5nIHRoZSBuZXh0IHBhZ2UgKGUuZy4sIGxhc3QgdHJhbnNhY3Rpb24gSUQpLiBPcHRpb25hbC5SCXBhZ2VUb2tlbjpnkkFkCmIqHEdldCBSZWNlbnQgRXhjaGFuZ2VzIFJlcXVlc3QyQlBheWxvYWQgZm9yIHJldHJpZXZpbmcgcmVjZW50IGludGVybmF0aW9uYWwgZXhjaGFuZ2UgdHJhbnNhY3Rpb25zLg==');
@$core.Deprecated('Use getRecentExchangesResponseDescriptor instead')
const GetRecentExchangesResponse$json = const {
  '1': 'GetRecentExchangesResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.ExchangeTransaction', '10': 'transactions'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
  '7': const {},
};

/// Descriptor for `GetRecentExchangesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentExchangesResponseDescriptor = $convert.base64Decode('ChpHZXRSZWNlbnRFeGNoYW5nZXNSZXNwb25zZRI7Cgx0cmFuc2FjdGlvbnMYASADKAsyFy5wYi5FeGNoYW5nZVRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2VuOlmSQVYKVCodR2V0IFJlY2VudCBFeGNoYW5nZXMgUmVzcG9uc2UyM0xpc3Qgb2YgcmVjZW50IGludGVybmF0aW9uYWwgZXhjaGFuZ2UgdHJhbnNhY3Rpb25zLg==');
