//
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use exchangeStatusDescriptor instead')
const ExchangeStatus$json = {
  '1': 'ExchangeStatus',
  '2': [
    {'1': 'PENDING', '2': 0},
    {'1': 'PROCESSING', '2': 1},
    {'1': 'COMPLETED', '2': 2},
    {'1': 'FAILED', '2': 3},
    {'1': 'CANCELLED', '2': 4},
  ],
};

/// Descriptor for `ExchangeStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List exchangeStatusDescriptor = $convert.base64Decode(
    'Cg5FeGNoYW5nZVN0YXR1cxILCgdQRU5ESU5HEAASDgoKUFJPQ0VTU0lORxABEg0KCUNPTVBMRV'
    'RFRBACEgoKBkZBSUxFRBADEg0KCUNBTkNFTExFRBAE');

@$core.Deprecated('Use getExchangeRateRequestDescriptor instead')
const GetExchangeRateRequest$json = {
  '1': 'GetExchangeRateRequest',
  '2': [
    {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'toCurrency'},
  ],
  '7': {},
};

/// Descriptor for `GetExchangeRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateRequestDescriptor = $convert.base64Decode(
    'ChZHZXRFeGNoYW5nZVJhdGVSZXF1ZXN0ElgKDWZyb21fY3VycmVuY3kYASABKAlCM5JBMDIuVG'
    'hlIGN1cnJlbmN5IGNvZGUgdG8gY29udmVydCBmcm9tIChlLmcuLCBHQlApLlIMZnJvbUN1cnJl'
    'bmN5ElIKC3RvX2N1cnJlbmN5GAIgASgJQjGSQS4yLFRoZSBjdXJyZW5jeSBjb2RlIHRvIGNvbn'
    'ZlcnQgdG8gKGUuZy4sIFVTRCkuUgp0b0N1cnJlbmN5OnySQXkKdyoZR2V0IEV4Y2hhbmdlIFJh'
    'dGUgUmVxdWVzdDI8UGF5bG9hZCB0byByZXF1ZXN0IHRoZSBleGNoYW5nZSByYXRlIGJldHdlZW'
    '4gdHdvIGN1cnJlbmNpZXMu0gENZnJvbV9jdXJyZW5jedIBC3RvX2N1cnJlbmN5');

@$core.Deprecated('Use getExchangeRateResponseDescriptor instead')
const GetExchangeRateResponse$json = {
  '1': 'GetExchangeRateResponse',
  '2': [
    {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
  '7': {},
};

/// Descriptor for `GetExchangeRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateResponseDescriptor = $convert.base64Decode(
    'ChdHZXRFeGNoYW5nZVJhdGVSZXNwb25zZRIjCg1mcm9tX2N1cnJlbmN5GAEgASgJUgxmcm9tQ3'
    'VycmVuY3kSHwoLdG9fY3VycmVuY3kYAiABKAlSCnRvQ3VycmVuY3kSEgoEcmF0ZRgDIAEoAVIE'
    'cmF0ZRI4Cgl0aW1lc3RhbXAYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW'
    '1lc3RhbXA6RpJBQwpBKhpHZXQgRXhjaGFuZ2UgUmF0ZSBSZXNwb25zZTIjQ29udGFpbnMgdGhl'
    'IGN1cnJlbnQgZXhjaGFuZ2UgcmF0ZS4=');

@$core.Deprecated('Use receiverDetailsDescriptor instead')
const ReceiverDetails$json = {
  '1': 'ReceiverDetails',
  '2': [
    {'1': 'full_name', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_name', '3': 3, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'swift_bic_code', '3': 4, '4': 1, '5': 9, '10': 'swiftBicCode'},
  ],
};

/// Descriptor for `ReceiverDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiverDetailsDescriptor = $convert.base64Decode(
    'Cg9SZWNlaXZlckRldGFpbHMSGwoJZnVsbF9uYW1lGAEgASgJUghmdWxsTmFtZRIlCg5hY2NvdW'
    '50X251bWJlchgCIAEoCVINYWNjb3VudE51bWJlchIbCgliYW5rX25hbWUYAyABKAlSCGJhbmtO'
    'YW1lEiQKDnN3aWZ0X2JpY19jb2RlGAQgASgJUgxzd2lmdEJpY0NvZGU=');

@$core.Deprecated('Use initiateInternationalTransferRequestDescriptor instead')
const InitiateInternationalTransferRequest$json = {
  '1': 'InitiateInternationalTransferRequest',
  '2': [
    {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'toCurrency'},
    {'1': 'amount_from', '3': 3, '4': 1, '5': 1, '8': {}, '10': 'amountFrom'},
    {'1': 'receiver_details', '3': 4, '4': 1, '5': 11, '6': '.pb.ReceiverDetails', '8': {}, '10': 'receiverDetails'},
  ],
  '7': {},
};

/// Descriptor for `InitiateInternationalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferRequestDescriptor = $convert.base64Decode(
    'CiRJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlcXVlc3QSVQoNZnJvbV9jdXJyZW5jeR'
    'gBIAEoCUIwkkEtMitUaGUgY3VycmVuY3kgY29kZSB0byBzZW5kIGZyb20gKGUuZy4sIEdCUCku'
    'Ugxmcm9tQ3VycmVuY3kSVgoLdG9fY3VycmVuY3kYAiABKAlCNZJBMjIwVGhlIGN1cnJlbmN5IG'
    'NvZGUgdGhlIHJlY2VpdmVyIGdldHMgKGUuZy4sIFVTRCkuUgp0b0N1cnJlbmN5ElMKC2Ftb3Vu'
    'dF9mcm9tGAMgASgBQjKSQS8yLVRoZSBhbW91bnQgdG8gYmUgc2VudCBpbiB0aGUgJ2Zyb21fY3'
    'VycmVuY3knLlIKYW1vdW50RnJvbRJeChByZWNlaXZlcl9kZXRhaWxzGAQgASgLMhMucGIuUmVj'
    'ZWl2ZXJEZXRhaWxzQh6SQRsyGURldGFpbHMgb2YgdGhlIHJlY2lwaWVudC5SD3JlY2VpdmVyRG'
    'V0YWlsczqyAZJBrgEKqwEqJ0luaXRpYXRlIEludGVybmF0aW9uYWwgVHJhbnNmZXIgUmVxdWVz'
    'dDJBUGF5bG9hZCB0byBzdGFydCBhbiBpbnRlcm5hdGlvbmFsIGN1cnJlbmN5IGV4Y2hhbmdlIG'
    'FuZCB0cmFuc2Zlci7SAQ1mcm9tX2N1cnJlbmN50gELdG9fY3VycmVuY3nSAQthbW91bnRfZnJv'
    'bdIBEHJlY2VpdmVyX2RldGFpbHM=');

@$core.Deprecated('Use exchangeTransactionDescriptor instead')
const ExchangeTransaction$json = {
  '1': 'ExchangeTransaction',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'from_currency', '3': 3, '4': 1, '5': 9, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 4, '4': 1, '5': 9, '10': 'toCurrency'},
    {'1': 'amount_from', '3': 5, '4': 1, '5': 1, '10': 'amountFrom'},
    {'1': 'amount_to', '3': 6, '4': 1, '5': 1, '10': 'amountTo'},
    {'1': 'exchange_rate', '3': 7, '4': 1, '5': 1, '10': 'exchangeRate'},
    {'1': 'fees', '3': 8, '4': 1, '5': 1, '10': 'fees'},
    {'1': 'receiver_details', '3': 9, '4': 1, '5': 11, '6': '.pb.ReceiverDetails', '10': 'receiverDetails'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.ExchangeStatus', '10': 'status'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `ExchangeTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeTransactionDescriptor = $convert.base64Decode(
    'ChNFeGNoYW5nZVRyYW5zYWN0aW9uEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdG'
    'lvbklkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIjCg1mcm9tX2N1cnJlbmN5GAMgASgJUgxm'
    'cm9tQ3VycmVuY3kSHwoLdG9fY3VycmVuY3kYBCABKAlSCnRvQ3VycmVuY3kSHwoLYW1vdW50X2'
    'Zyb20YBSABKAFSCmFtb3VudEZyb20SGwoJYW1vdW50X3RvGAYgASgBUghhbW91bnRUbxIjCg1l'
    'eGNoYW5nZV9yYXRlGAcgASgBUgxleGNoYW5nZVJhdGUSEgoEZmVlcxgIIAEoAVIEZmVlcxI+Ch'
    'ByZWNlaXZlcl9kZXRhaWxzGAkgASgLMhMucGIuUmVjZWl2ZXJEZXRhaWxzUg9yZWNlaXZlckRl'
    'dGFpbHMSKgoGc3RhdHVzGAogASgOMhIucGIuRXhjaGFuZ2VTdGF0dXNSBnN0YXR1cxI5Cgpjcm'
    'VhdGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkK'
    'CnVwZGF0ZWRfYXQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQX'
    'Q=');

@$core.Deprecated('Use initiateInternationalTransferResponseDescriptor instead')
const InitiateInternationalTransferResponse$json = {
  '1': 'InitiateInternationalTransferResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.pb.ExchangeTransaction', '10': 'transaction'},
  ],
  '7': {},
};

/// Descriptor for `InitiateInternationalTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferResponseDescriptor = $convert.base64Decode(
    'CiVJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlc3BvbnNlEjkKC3RyYW5zYWN0aW9uGA'
    'EgASgLMhcucGIuRXhjaGFuZ2VUcmFuc2FjdGlvblILdHJhbnNhY3Rpb246XJJBWQpXKihJbml0'
    'aWF0ZSBJbnRlcm5hdGlvbmFsIFRyYW5zZmVyIFJlc3BvbnNlMitDb250YWlucyBkZXRhaWxzIG'
    '9mIHRoZSBpbml0aWF0ZWQgdHJhbnNmZXIu');

@$core.Deprecated('Use getRecentExchangesRequestDescriptor instead')
const GetRecentExchangesRequest$json = {
  '1': 'GetRecentExchangesRequest',
  '2': [
    {'1': 'page_size', '3': 1, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
    {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
  ],
  '7': {},
};

/// Descriptor for `GetRecentExchangesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentExchangesRequestDescriptor = $convert.base64Decode(
    'ChlHZXRSZWNlbnRFeGNoYW5nZXNSZXF1ZXN0Ek8KCXBhZ2Vfc2l6ZRgBIAEoBUIykkEvMi1OdW'
    '1iZXIgb2YgdHJhbnNhY3Rpb25zIHBlciBwYWdlLiBEZWZhdWx0OiAyMC5SCHBhZ2VTaXplEmsK'
    'CnBhZ2VfdG9rZW4YAiABKAlCTJJBSTJHVG9rZW4gZm9yIGZldGNoaW5nIHRoZSBuZXh0IHBhZ2'
    'UgKGUuZy4sIGxhc3QgdHJhbnNhY3Rpb24gSUQpLiBPcHRpb25hbC5SCXBhZ2VUb2tlbjpnkkFk'
    'CmIqHEdldCBSZWNlbnQgRXhjaGFuZ2VzIFJlcXVlc3QyQlBheWxvYWQgZm9yIHJldHJpZXZpbm'
    'cgcmVjZW50IGludGVybmF0aW9uYWwgZXhjaGFuZ2UgdHJhbnNhY3Rpb25zLg==');

@$core.Deprecated('Use getRecentExchangesResponseDescriptor instead')
const GetRecentExchangesResponse$json = {
  '1': 'GetRecentExchangesResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.ExchangeTransaction', '10': 'transactions'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
  '7': {},
};

/// Descriptor for `GetRecentExchangesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentExchangesResponseDescriptor = $convert.base64Decode(
    'ChpHZXRSZWNlbnRFeGNoYW5nZXNSZXNwb25zZRI7Cgx0cmFuc2FjdGlvbnMYASADKAsyFy5wYi'
    '5FeGNoYW5nZVRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSJgoPbmV4dF9wYWdlX3Rva2VuGAIg'
    'ASgJUg1uZXh0UGFnZVRva2VuOlmSQVYKVCodR2V0IFJlY2VudCBFeGNoYW5nZXMgUmVzcG9uc2'
    'UyM0xpc3Qgb2YgcmVjZW50IGludGVybmF0aW9uYWwgZXhjaGFuZ2UgdHJhbnNhY3Rpb25zLg==');

