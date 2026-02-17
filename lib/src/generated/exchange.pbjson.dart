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

@$core.Deprecated('Use exchangeTypeDescriptor instead')
const ExchangeType$json = {
  '1': 'ExchangeType',
  '2': [
    {'1': 'EXCHANGE_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'CONVERSION', '2': 1},
    {'1': 'INTERNATIONAL', '2': 2},
  ],
};

/// Descriptor for `ExchangeType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List exchangeTypeDescriptor = $convert.base64Decode(
    'CgxFeGNoYW5nZVR5cGUSHQoZRVhDSEFOR0VfVFlQRV9VTlNQRUNJRklFRBAAEg4KCkNPTlZFUl'
    'NJT04QARIRCg1JTlRFUk5BVElPTkFMEAI=');

@$core.Deprecated('Use getExchangeRateRequestDescriptor instead')
const GetExchangeRateRequest$json = {
  '1': 'GetExchangeRateRequest',
  '2': [
    {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'toCurrency'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '8': {}, '10': 'amount'},
  ],
  '7': {},
};

/// Descriptor for `GetExchangeRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateRequestDescriptor = $convert.base64Decode(
    'ChZHZXRFeGNoYW5nZVJhdGVSZXF1ZXN0ElgKDWZyb21fY3VycmVuY3kYASABKAlCM5JBMDIuVG'
    'hlIGN1cnJlbmN5IGNvZGUgdG8gY29udmVydCBmcm9tIChlLmcuLCBOR04pLlIMZnJvbUN1cnJl'
    'bmN5ElIKC3RvX2N1cnJlbmN5GAIgASgJQjGSQS4yLFRoZSBjdXJyZW5jeSBjb2RlIHRvIGNvbn'
    'ZlcnQgdG8gKGUuZy4sIFVTRCkuUgp0b0N1cnJlbmN5EkEKBmFtb3VudBgDIAEoAUIpkkEmMiRP'
    'cHRpb25hbCBhbW91bnQgZm9yIGZlZSBjYWxjdWxhdGlvbi5SBmFtb3VudDp8kkF5CncqGUdldC'
    'BFeGNoYW5nZSBSYXRlIFJlcXVlc3QyPFBheWxvYWQgdG8gcmVxdWVzdCB0aGUgZXhjaGFuZ2Ug'
    'cmF0ZSBiZXR3ZWVuIHR3byBjdXJyZW5jaWVzLtIBDWZyb21fY3VycmVuY3nSAQt0b19jdXJyZW'
    '5jeQ==');

@$core.Deprecated('Use getExchangeRateResponseDescriptor instead')
const GetExchangeRateResponse$json = {
  '1': 'GetExchangeRateResponse',
  '2': [
    {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '10': 'toCurrency'},
    {'1': 'rate', '3': 3, '4': 1, '5': 1, '10': 'rate'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'fee', '3': 5, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'fee_percentage', '3': 6, '4': 1, '5': 1, '10': 'feePercentage'},
    {'1': 'rate_valid_seconds', '3': 7, '4': 1, '5': 5, '10': 'rateValidSeconds'},
    {'1': 'rate_id', '3': 8, '4': 1, '5': 9, '10': 'rateId'},
  ],
  '7': {},
};

/// Descriptor for `GetExchangeRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExchangeRateResponseDescriptor = $convert.base64Decode(
    'ChdHZXRFeGNoYW5nZVJhdGVSZXNwb25zZRIjCg1mcm9tX2N1cnJlbmN5GAEgASgJUgxmcm9tQ3'
    'VycmVuY3kSHwoLdG9fY3VycmVuY3kYAiABKAlSCnRvQ3VycmVuY3kSEgoEcmF0ZRgDIAEoAVIE'
    'cmF0ZRI4Cgl0aW1lc3RhbXAYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW'
    '1lc3RhbXASEAoDZmVlGAUgASgBUgNmZWUSJQoOZmVlX3BlcmNlbnRhZ2UYBiABKAFSDWZlZVBl'
    'cmNlbnRhZ2USLAoScmF0ZV92YWxpZF9zZWNvbmRzGAcgASgFUhByYXRlVmFsaWRTZWNvbmRzEh'
    'cKB3JhdGVfaWQYCCABKAlSBnJhdGVJZDpZkkFWClQqGkdldCBFeGNoYW5nZSBSYXRlIFJlc3Bv'
    'bnNlMjZDb250YWlucyB0aGUgY3VycmVudCBleGNoYW5nZSByYXRlIHdpdGggZmVlIGJyZWFrZG'
    '93bi4=');

@$core.Deprecated('Use receiverDetailsDescriptor instead')
const ReceiverDetails$json = {
  '1': 'ReceiverDetails',
  '2': [
    {'1': 'full_name', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_name', '3': 3, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'swift_bic_code', '3': 4, '4': 1, '5': 9, '10': 'swiftBicCode'},
    {'1': 'country', '3': 5, '4': 1, '5': 9, '10': 'country'},
    {'1': 'bank_code', '3': 6, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'email', '3': 7, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `ReceiverDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiverDetailsDescriptor = $convert.base64Decode(
    'Cg9SZWNlaXZlckRldGFpbHMSGwoJZnVsbF9uYW1lGAEgASgJUghmdWxsTmFtZRIlCg5hY2NvdW'
    '50X251bWJlchgCIAEoCVINYWNjb3VudE51bWJlchIbCgliYW5rX25hbWUYAyABKAlSCGJhbmtO'
    'YW1lEiQKDnN3aWZ0X2JpY19jb2RlGAQgASgJUgxzd2lmdEJpY0NvZGUSGAoHY291bnRyeRgFIA'
    'EoCVIHY291bnRyeRIbCgliYW5rX2NvZGUYBiABKAlSCGJhbmtDb2RlEhQKBWVtYWlsGAcgASgJ'
    'UgVlbWFpbA==');

@$core.Deprecated('Use initiateInternationalTransferRequestDescriptor instead')
const InitiateInternationalTransferRequest$json = {
  '1': 'InitiateInternationalTransferRequest',
  '2': [
    {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'toCurrency'},
    {'1': 'amount_from', '3': 3, '4': 1, '5': 1, '8': {}, '10': 'amountFrom'},
    {'1': 'receiver_details', '3': 4, '4': 1, '5': 11, '6': '.pb.ReceiverDetails', '8': {}, '10': 'receiverDetails'},
    {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '8': {}, '10': 'idempotencyKey'},
    {'1': 'rate_id', '3': 7, '4': 1, '5': 9, '8': {}, '10': 'rateId'},
    {'1': 'purpose_of_payment', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'purposeOfPayment'},
  ],
  '7': {},
};

/// Descriptor for `InitiateInternationalTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateInternationalTransferRequestDescriptor = $convert.base64Decode(
    'CiRJbml0aWF0ZUludGVybmF0aW9uYWxUcmFuc2ZlclJlcXVlc3QSVQoNZnJvbV9jdXJyZW5jeR'
    'gBIAEoCUIwkkEtMitUaGUgY3VycmVuY3kgY29kZSB0byBzZW5kIGZyb20gKGUuZy4sIE5HTiku'
    'Ugxmcm9tQ3VycmVuY3kSVgoLdG9fY3VycmVuY3kYAiABKAlCNZJBMjIwVGhlIGN1cnJlbmN5IG'
    'NvZGUgdGhlIHJlY2VpdmVyIGdldHMgKGUuZy4sIFVTRCkuUgp0b0N1cnJlbmN5ElMKC2Ftb3Vu'
    'dF9mcm9tGAMgASgBQjKSQS8yLVRoZSBhbW91bnQgdG8gYmUgc2VudCBpbiB0aGUgJ2Zyb21fY3'
    'VycmVuY3knLlIKYW1vdW50RnJvbRJeChByZWNlaXZlcl9kZXRhaWxzGAQgASgLMhMucGIuUmVj'
    'ZWl2ZXJEZXRhaWxzQh6SQRsyGURldGFpbHMgb2YgdGhlIHJlY2lwaWVudC5SD3JlY2VpdmVyRG'
    'V0YWlscxJdChJ2ZXJpZmljYXRpb25fdG9rZW4YBSABKAlCLpJBKzIpUElOIHZlcmlmaWNhdGlv'
    'biB0b2tlbiBmcm9tIGF1dGgtc2VydmljZS5SEXZlcmlmaWNhdGlvblRva2VuEl0KD2lkZW1wb3'
    'RlbmN5X2tleRgGIAEoCUI0kkExMi9DbGllbnQtZ2VuZXJhdGVkIFVVSUQgZm9yIGR1cGxpY2F0'
    'ZSBwcmV2ZW50aW9uLlIOaWRlbXBvdGVuY3lLZXkSTwoHcmF0ZV9pZBgHIAEoCUI2kkEzMjFSYX'
    'RlIElEIGZyb20gR2V0RXhjaGFuZ2VSYXRlIGZvciBzdGFsZW5lc3MgY2hlY2suUgZyYXRlSWQS'
    'aAoScHVycG9zZV9vZl9wYXltZW50GAggASgJQjqSQTcyNVJlYXNvbiBmb3IgdHJhbnNmZXIgKG'
    'UuZy4sIGZhbWlseV9zdXBwb3J0LCBidXNpbmVzcykuUhBwdXJwb3NlT2ZQYXltZW50OtkBkkHV'
    'AQrSASonSW5pdGlhdGUgSW50ZXJuYXRpb25hbCBUcmFuc2ZlciBSZXF1ZXN0MkFQYXlsb2FkIH'
    'RvIHN0YXJ0IGFuIGludGVybmF0aW9uYWwgY3VycmVuY3kgZXhjaGFuZ2UgYW5kIHRyYW5zZmVy'
    'LtIBDWZyb21fY3VycmVuY3nSAQt0b19jdXJyZW5jedIBC2Ftb3VudF9mcm9t0gEQcmVjZWl2ZX'
    'JfZGV0YWlsc9IBEnZlcmlmaWNhdGlvbl90b2tlbtIBD2lkZW1wb3RlbmN5X2tleQ==');

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
    {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'provider_reference', '3': 14, '4': 1, '5': 9, '10': 'providerReference'},
    {'1': 'exchange_type', '3': 15, '4': 1, '5': 14, '6': '.pb.ExchangeType', '10': 'exchangeType'},
    {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
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
    'QSHAoJcmVmZXJlbmNlGA0gASgJUglyZWZlcmVuY2USLQoScHJvdmlkZXJfcmVmZXJlbmNlGA4g'
    'ASgJUhFwcm92aWRlclJlZmVyZW5jZRI1Cg1leGNoYW5nZV90eXBlGA8gASgOMhAucGIuRXhjaG'
    'FuZ2VUeXBlUgxleGNoYW5nZVR5cGUSJQoOZmFpbHVyZV9yZWFzb24YECABKAlSDWZhaWx1cmVS'
    'ZWFzb24=');

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
    '1iZXIgb2YgdHJhbnNhY3Rpb25zIHBlciBwYWdlLiBEZWZhdWx0OiAyMC5SCHBhZ2VTaXplEkUK'
    'CnBhZ2VfdG9rZW4YAiABKAlCJpJBIzIhVG9rZW4gZm9yIGZldGNoaW5nIHRoZSBuZXh0IHBhZ2'
    'UuUglwYWdlVG9rZW46WZJBVgpUKhxHZXQgUmVjZW50IEV4Y2hhbmdlcyBSZXF1ZXN0MjRQYXls'
    'b2FkIGZvciByZXRyaWV2aW5nIHJlY2VudCBleGNoYW5nZSB0cmFuc2FjdGlvbnMu');

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
    'ASgJUg1uZXh0UGFnZVRva2VuOkuSQUgKRiodR2V0IFJlY2VudCBFeGNoYW5nZXMgUmVzcG9uc2'
    'UyJUxpc3Qgb2YgcmVjZW50IGV4Y2hhbmdlIHRyYW5zYWN0aW9ucy4=');

@$core.Deprecated('Use convertCurrencyRequestDescriptor instead')
const ConvertCurrencyRequest$json = {
  '1': 'ConvertCurrencyRequest',
  '2': [
    {'1': 'from_currency', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'fromCurrency'},
    {'1': 'to_currency', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'toCurrency'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '8': {}, '10': 'amount'},
    {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'idempotencyKey'},
    {'1': 'rate_id', '3': 6, '4': 1, '5': 9, '8': {}, '10': 'rateId'},
  ],
  '7': {},
};

/// Descriptor for `ConvertCurrencyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCurrencyRequestDescriptor = $convert.base64Decode(
    'ChZDb252ZXJ0Q3VycmVuY3lSZXF1ZXN0EksKDWZyb21fY3VycmVuY3kYASABKAlCJpJBIzIhU2'
    '91cmNlIGN1cnJlbmN5IGNvZGUgKGUuZy4sIE5HTikuUgxmcm9tQ3VycmVuY3kSTAoLdG9fY3Vy'
    'cmVuY3kYAiABKAlCK5JBKDImRGVzdGluYXRpb24gY3VycmVuY3kgY29kZSAoZS5nLiwgVVNEKS'
    '5SCnRvQ3VycmVuY3kSQgoGYW1vdW50GAMgASgBQiqSQScyJUFtb3VudCB0byBjb252ZXJ0IGlu'
    'IHNvdXJjZSBjdXJyZW5jeS5SBmFtb3VudBJLChJ2ZXJpZmljYXRpb25fdG9rZW4YBCABKAlCHJ'
    'JBGTIXUElOIHZlcmlmaWNhdGlvbiB0b2tlbi5SEXZlcmlmaWNhdGlvblRva2VuEl0KD2lkZW1w'
    'b3RlbmN5X2tleRgFIAEoCUI0kkExMi9DbGllbnQtZ2VuZXJhdGVkIFVVSUQgZm9yIGR1cGxpY2'
    'F0ZSBwcmV2ZW50aW9uLlIOaWRlbXBvdGVuY3lLZXkSPwoHcmF0ZV9pZBgGIAEoCUImkkEjMiFS'
    'YXRlIElEIGZvciBzdGFsZW5lc3MgdmFsaWRhdGlvbi5SBnJhdGVJZDqiAZJBngEKmwEqGENvbn'
    'ZlcnQgQ3VycmVuY3kgUmVxdWVzdDIxUGF5bG9hZCBmb3Igd2FsbGV0LXRvLXdhbGxldCBjdXJy'
    'ZW5jeSBjb252ZXJzaW9uLtIBDWZyb21fY3VycmVuY3nSAQt0b19jdXJyZW5jedIBBmFtb3VudN'
    'IBEnZlcmlmaWNhdGlvbl90b2tlbtIBD2lkZW1wb3RlbmN5X2tleQ==');

@$core.Deprecated('Use convertCurrencyResponseDescriptor instead')
const ConvertCurrencyResponse$json = {
  '1': 'ConvertCurrencyResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.pb.ExchangeTransaction', '10': 'transaction'},
  ],
  '7': {},
};

/// Descriptor for `ConvertCurrencyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertCurrencyResponseDescriptor = $convert.base64Decode(
    'ChdDb252ZXJ0Q3VycmVuY3lSZXNwb25zZRI5Cgt0cmFuc2FjdGlvbhgBIAEoCzIXLnBiLkV4Y2'
    'hhbmdlVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uOkiSQUUKQyoZQ29udmVydCBDdXJyZW5jeSBS'
    'ZXNwb25zZTImUmVzdWx0IG9mIHdhbGxldC10by13YWxsZXQgY29udmVyc2lvbi4=');

@$core.Deprecated('Use getTransactionStatusRequestDescriptor instead')
const GetTransactionStatusRequest$json = {
  '1': 'GetTransactionStatusRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'transactionId'},
  ],
  '7': {},
};

/// Descriptor for `GetTransactionStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatusRequestDescriptor = $convert.base64Decode(
    'ChtHZXRUcmFuc2FjdGlvblN0YXR1c1JlcXVlc3QSSAoOdHJhbnNhY3Rpb25faWQYASABKAlCIZ'
    'JBHjIcVGhlIGV4Y2hhbmdlIHRyYW5zYWN0aW9uIElELlINdHJhbnNhY3Rpb25JZDpdkkFaClgq'
    'HkdldCBUcmFuc2FjdGlvbiBTdGF0dXMgUmVxdWVzdDIlUG9sbCBmb3IgZXhjaGFuZ2UgdHJhbn'
    'NhY3Rpb24gc3RhdHVzLtIBDnRyYW5zYWN0aW9uX2lk');

@$core.Deprecated('Use getTransactionStatusResponseDescriptor instead')
const GetTransactionStatusResponse$json = {
  '1': 'GetTransactionStatusResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.pb.ExchangeTransaction', '10': 'transaction'},
  ],
  '7': {},
};

/// Descriptor for `GetTransactionStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatusResponseDescriptor = $convert.base64Decode(
    'ChxHZXRUcmFuc2FjdGlvblN0YXR1c1Jlc3BvbnNlEjkKC3RyYW5zYWN0aW9uGAEgASgLMhcucG'
    'IuRXhjaGFuZ2VUcmFuc2FjdGlvblILdHJhbnNhY3Rpb246UpJBTwpNKh9HZXQgVHJhbnNhY3Rp'
    'b24gU3RhdHVzIFJlc3BvbnNlMipDdXJyZW50IHN0YXR1cyBvZiBhbiBleGNoYW5nZSB0cmFuc2'
    'FjdGlvbi4=');

@$core.Deprecated('Use getSupportedCurrenciesRequestDescriptor instead')
const GetSupportedCurrenciesRequest$json = {
  '1': 'GetSupportedCurrenciesRequest',
  '7': {},
};

/// Descriptor for `GetSupportedCurrenciesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCurrenciesRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVxdWVzdDpPkkFMCkoqIEdldCBTdXBwb3J0ZWQgQ3'
    'VycmVuY2llcyBSZXF1ZXN0MiZSZXF1ZXN0IHN1cHBvcnRlZCBleGNoYW5nZSBjdXJyZW5jaWVz'
    'Lg==');

@$core.Deprecated('Use supportedCurrencyDescriptor instead')
const SupportedCurrency$json = {
  '1': 'SupportedCurrency',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'symbol', '3': 3, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'country', '3': 4, '4': 1, '5': 9, '10': 'country'},
    {'1': 'supports_conversion', '3': 5, '4': 1, '5': 8, '10': 'supportsConversion'},
    {'1': 'supports_international', '3': 6, '4': 1, '5': 8, '10': 'supportsInternational'},
    {'1': 'min_amount', '3': 7, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 8, '4': 1, '5': 1, '10': 'maxAmount'},
  ],
};

/// Descriptor for `SupportedCurrency`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List supportedCurrencyDescriptor = $convert.base64Decode(
    'ChFTdXBwb3J0ZWRDdXJyZW5jeRISCgRjb2RlGAEgASgJUgRjb2RlEhIKBG5hbWUYAiABKAlSBG'
    '5hbWUSFgoGc3ltYm9sGAMgASgJUgZzeW1ib2wSGAoHY291bnRyeRgEIAEoCVIHY291bnRyeRIv'
    'ChNzdXBwb3J0c19jb252ZXJzaW9uGAUgASgIUhJzdXBwb3J0c0NvbnZlcnNpb24SNQoWc3VwcG'
    '9ydHNfaW50ZXJuYXRpb25hbBgGIAEoCFIVc3VwcG9ydHNJbnRlcm5hdGlvbmFsEh0KCm1pbl9h'
    'bW91bnQYByABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAggASgBUgltYXhBbW91bnQ=');

@$core.Deprecated('Use getSupportedCurrenciesResponseDescriptor instead')
const GetSupportedCurrenciesResponse$json = {
  '1': 'GetSupportedCurrenciesResponse',
  '2': [
    {'1': 'currencies', '3': 1, '4': 3, '5': 11, '6': '.pb.SupportedCurrency', '10': 'currencies'},
  ],
  '7': {},
};

/// Descriptor for `GetSupportedCurrenciesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCurrenciesResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRTdXBwb3J0ZWRDdXJyZW5jaWVzUmVzcG9uc2USNQoKY3VycmVuY2llcxgBIAMoCzIVLn'
    'BiLlN1cHBvcnRlZEN1cnJlbmN5UgpjdXJyZW5jaWVzOlCSQU0KSyohR2V0IFN1cHBvcnRlZCBD'
    'dXJyZW5jaWVzIFJlc3BvbnNlMiZMaXN0IG9mIHN1cHBvcnRlZCBleGNoYW5nZSBjdXJyZW5jaW'
    'VzLg==');

