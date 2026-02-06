//
//  Generated code. Do not modify.
//  source: barcode_payment.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use generateBarcodeRequestDescriptor instead')
const GenerateBarcodeRequest$json = {
  '1': 'GenerateBarcodeRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'validity_minutes', '3': 4, '4': 1, '5': 5, '10': 'validityMinutes'},
  ],
};

/// Descriptor for `GenerateBarcodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateBarcodeRequestDescriptor = $convert.base64Decode(
    'ChZHZW5lcmF0ZUJhcmNvZGVSZXF1ZXN0EhYKBmFtb3VudBgBIAEoAVIGYW1vdW50EhoKCGN1cn'
    'JlbmN5GAIgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24S'
    'KQoQdmFsaWRpdHlfbWludXRlcxgEIAEoBVIPdmFsaWRpdHlNaW51dGVz');

@$core.Deprecated('Use generateBarcodeResponseDescriptor instead')
const GenerateBarcodeResponse$json = {
  '1': 'GenerateBarcodeResponse',
  '2': [
    {'1': 'barcode_id', '3': 1, '4': 1, '5': 9, '10': 'barcodeId'},
    {'1': 'barcode_code', '3': 2, '4': 1, '5': 9, '10': 'barcodeCode'},
    {'1': 'qr_data', '3': 3, '4': 1, '5': 9, '10': 'qrData'},
    {'1': 'expires_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateBarcodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateBarcodeResponseDescriptor = $convert.base64Decode(
    'ChdHZW5lcmF0ZUJhcmNvZGVSZXNwb25zZRIdCgpiYXJjb2RlX2lkGAEgASgJUgliYXJjb2RlSW'
    'QSIQoMYmFyY29kZV9jb2RlGAIgASgJUgtiYXJjb2RlQ29kZRIXCgdxcl9kYXRhGAMgASgJUgZx'
    'ckRhdGESOQoKZXhwaXJlc19hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCW'
    'V4cGlyZXNBdBIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getBarcodeDetailsRequestDescriptor instead')
const GetBarcodeDetailsRequest$json = {
  '1': 'GetBarcodeDetailsRequest',
  '2': [
    {'1': 'barcode_code', '3': 1, '4': 1, '5': 9, '10': 'barcodeCode'},
  ],
};

/// Descriptor for `GetBarcodeDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBarcodeDetailsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRCYXJjb2RlRGV0YWlsc1JlcXVlc3QSIQoMYmFyY29kZV9jb2RlGAEgASgJUgtiYXJjb2'
    'RlQ29kZQ==');

@$core.Deprecated('Use getBarcodeDetailsResponseDescriptor instead')
const GetBarcodeDetailsResponse$json = {
  '1': 'GetBarcodeDetailsResponse',
  '2': [
    {'1': 'barcode', '3': 1, '4': 1, '5': 11, '6': '.barcode_payment.BarcodePayment', '10': 'barcode'},
  ],
};

/// Descriptor for `GetBarcodeDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBarcodeDetailsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRCYXJjb2RlRGV0YWlsc1Jlc3BvbnNlEjkKB2JhcmNvZGUYASABKAsyHy5iYXJjb2RlX3'
    'BheW1lbnQuQmFyY29kZVBheW1lbnRSB2JhcmNvZGU=');

@$core.Deprecated('Use processBarcodePaymentRequestDescriptor instead')
const ProcessBarcodePaymentRequest$json = {
  '1': 'ProcessBarcodePaymentRequest',
  '2': [
    {'1': 'barcode_code', '3': 1, '4': 1, '5': 9, '10': 'barcodeCode'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `ProcessBarcodePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processBarcodePaymentRequestDescriptor = $convert.base64Decode(
    'ChxQcm9jZXNzQmFyY29kZVBheW1lbnRSZXF1ZXN0EiEKDGJhcmNvZGVfY29kZRgBIAEoCVILYm'
    'FyY29kZUNvZGUSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZA==');

@$core.Deprecated('Use processBarcodePaymentResponseDescriptor instead')
const ProcessBarcodePaymentResponse$json = {
  '1': 'ProcessBarcodePaymentResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.barcode_payment.BarcodeTransaction', '10': 'transaction'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessBarcodePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processBarcodePaymentResponseDescriptor = $convert.base64Decode(
    'Ch1Qcm9jZXNzQmFyY29kZVBheW1lbnRSZXNwb25zZRJFCgt0cmFuc2FjdGlvbhgBIAEoCzIjLm'
    'JhcmNvZGVfcGF5bWVudC5CYXJjb2RlVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEhgKB21lc3Nh'
    'Z2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getMyGeneratedBarcodesRequestDescriptor instead')
const GetMyGeneratedBarcodesRequest$json = {
  '1': 'GetMyGeneratedBarcodesRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetMyGeneratedBarcodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyGeneratedBarcodesRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRNeUdlbmVyYXRlZEJhcmNvZGVzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFg'
    'oGb2Zmc2V0GAIgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getMyGeneratedBarcodesResponseDescriptor instead')
const GetMyGeneratedBarcodesResponse$json = {
  '1': 'GetMyGeneratedBarcodesResponse',
  '2': [
    {'1': 'barcodes', '3': 1, '4': 3, '5': 11, '6': '.barcode_payment.BarcodePayment', '10': 'barcodes'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyGeneratedBarcodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyGeneratedBarcodesResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRNeUdlbmVyYXRlZEJhcmNvZGVzUmVzcG9uc2USOwoIYmFyY29kZXMYASADKAsyHy5iYX'
    'Jjb2RlX3BheW1lbnQuQmFyY29kZVBheW1lbnRSCGJhcmNvZGVzEhQKBXRvdGFsGAIgASgFUgV0'
    'b3RhbA==');

@$core.Deprecated('Use getMyScannedBarcodesRequestDescriptor instead')
const GetMyScannedBarcodesRequest$json = {
  '1': 'GetMyScannedBarcodesRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetMyScannedBarcodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyScannedBarcodesRequestDescriptor = $convert.base64Decode(
    'ChtHZXRNeVNjYW5uZWRCYXJjb2Rlc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm'
    '9mZnNldBgCIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use getMyScannedBarcodesResponseDescriptor instead')
const GetMyScannedBarcodesResponse$json = {
  '1': 'GetMyScannedBarcodesResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.barcode_payment.BarcodeTransaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyScannedBarcodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyScannedBarcodesResponseDescriptor = $convert.base64Decode(
    'ChxHZXRNeVNjYW5uZWRCYXJjb2Rlc1Jlc3BvbnNlEkcKDHRyYW5zYWN0aW9ucxgBIAMoCzIjLm'
    'JhcmNvZGVfcGF5bWVudC5CYXJjb2RlVHJhbnNhY3Rpb25SDHRyYW5zYWN0aW9ucxIUCgV0b3Rh'
    'bBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use cancelBarcodeRequestDescriptor instead')
const CancelBarcodeRequest$json = {
  '1': 'CancelBarcodeRequest',
  '2': [
    {'1': 'barcode_id', '3': 1, '4': 1, '5': 9, '10': 'barcodeId'},
  ],
};

/// Descriptor for `CancelBarcodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelBarcodeRequestDescriptor = $convert.base64Decode(
    'ChRDYW5jZWxCYXJjb2RlUmVxdWVzdBIdCgpiYXJjb2RlX2lkGAEgASgJUgliYXJjb2RlSWQ=');

@$core.Deprecated('Use cancelBarcodeResponseDescriptor instead')
const CancelBarcodeResponse$json = {
  '1': 'CancelBarcodeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelBarcodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelBarcodeResponseDescriptor = $convert.base64Decode(
    'ChVDYW5jZWxCYXJjb2RlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use barcodePaymentDescriptor instead')
const BarcodePayment$json = {
  '1': 'BarcodePayment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    {'1': 'full_name', '3': 4, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'barcode_code', '3': 5, '4': 1, '5': 9, '10': 'barcodeCode'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'expires_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    {'1': 'paid_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paidAt'},
  ],
};

/// Descriptor for `BarcodePayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePaymentDescriptor = $convert.base64Decode(
    'Cg5CYXJjb2RlUGF5bWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlck'
    'lkEhoKCHVzZXJuYW1lGAMgASgJUgh1c2VybmFtZRIbCglmdWxsX25hbWUYBCABKAlSCGZ1bGxO'
    'YW1lEiEKDGJhcmNvZGVfY29kZRgFIAEoCVILYmFyY29kZUNvZGUSFgoGYW1vdW50GAYgASgBUg'
    'ZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAggASgJ'
    'UgtkZXNjcmlwdGlvbhIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAogAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCmV4cGlyZXNfYXQY'
    'CyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQSMwoHcGFpZF9hdB'
    'gMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBnBhaWRBdA==');

@$core.Deprecated('Use barcodeTransactionDescriptor instead')
const BarcodeTransaction$json = {
  '1': 'BarcodeTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'barcode_id', '3': 2, '4': 1, '5': 9, '10': 'barcodeId'},
    {'1': 'payer_id', '3': 3, '4': 1, '5': 9, '10': 'payerId'},
    {'1': 'payer_username', '3': 4, '4': 1, '5': 9, '10': 'payerUsername'},
    {'1': 'payer_name', '3': 5, '4': 1, '5': 9, '10': 'payerName'},
    {'1': 'recipient_id', '3': 6, '4': 1, '5': 9, '10': 'recipientId'},
    {'1': 'recipient_username', '3': 7, '4': 1, '5': 9, '10': 'recipientUsername'},
    {'1': 'recipient_name', '3': 8, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'amount', '3': 9, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reference_number', '3': 12, '4': 1, '5': 9, '10': 'referenceNumber'},
    {'1': 'status', '3': 13, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `BarcodeTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodeTransactionDescriptor = $convert.base64Decode(
    'ChJCYXJjb2RlVHJhbnNhY3Rpb24SDgoCaWQYASABKAlSAmlkEh0KCmJhcmNvZGVfaWQYAiABKA'
    'lSCWJhcmNvZGVJZBIZCghwYXllcl9pZBgDIAEoCVIHcGF5ZXJJZBIlCg5wYXllcl91c2VybmFt'
    'ZRgEIAEoCVINcGF5ZXJVc2VybmFtZRIdCgpwYXllcl9uYW1lGAUgASgJUglwYXllck5hbWUSIQ'
    'oMcmVjaXBpZW50X2lkGAYgASgJUgtyZWNpcGllbnRJZBItChJyZWNpcGllbnRfdXNlcm5hbWUY'
    'ByABKAlSEXJlY2lwaWVudFVzZXJuYW1lEiUKDnJlY2lwaWVudF9uYW1lGAggASgJUg1yZWNpcG'
    'llbnROYW1lEhYKBmFtb3VudBgJIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAogASgJUghjdXJy'
    'ZW5jeRIgCgtkZXNjcmlwdGlvbhgLIAEoCVILZGVzY3JpcHRpb24SKQoQcmVmZXJlbmNlX251bW'
    'JlchgMIAEoCVIPcmVmZXJlbmNlTnVtYmVyEhYKBnN0YXR1cxgNIAEoCVIGc3RhdHVzEjkKCmNy'
    'ZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

