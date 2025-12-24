///
//  Generated code. Do not modify.
//  source: barcode_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use generateBarcodeRequestDescriptor instead')
const GenerateBarcodeRequest$json = const {
  '1': 'GenerateBarcodeRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'validity_minutes', '3': 4, '4': 1, '5': 5, '10': 'validityMinutes'},
  ],
};

/// Descriptor for `GenerateBarcodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateBarcodeRequestDescriptor = $convert.base64Decode('ChZHZW5lcmF0ZUJhcmNvZGVSZXF1ZXN0EhYKBmFtb3VudBgBIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAIgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SKQoQdmFsaWRpdHlfbWludXRlcxgEIAEoBVIPdmFsaWRpdHlNaW51dGVz');
@$core.Deprecated('Use generateBarcodeResponseDescriptor instead')
const GenerateBarcodeResponse$json = const {
  '1': 'GenerateBarcodeResponse',
  '2': const [
    const {'1': 'barcode_id', '3': 1, '4': 1, '5': 9, '10': 'barcodeId'},
    const {'1': 'barcode_code', '3': 2, '4': 1, '5': 9, '10': 'barcodeCode'},
    const {'1': 'qr_data', '3': 3, '4': 1, '5': 9, '10': 'qrData'},
    const {'1': 'expires_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateBarcodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateBarcodeResponseDescriptor = $convert.base64Decode('ChdHZW5lcmF0ZUJhcmNvZGVSZXNwb25zZRIdCgpiYXJjb2RlX2lkGAEgASgJUgliYXJjb2RlSWQSIQoMYmFyY29kZV9jb2RlGAIgASgJUgtiYXJjb2RlQ29kZRIXCgdxcl9kYXRhGAMgASgJUgZxckRhdGESOQoKZXhwaXJlc19hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWV4cGlyZXNBdBIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getBarcodeDetailsRequestDescriptor instead')
const GetBarcodeDetailsRequest$json = const {
  '1': 'GetBarcodeDetailsRequest',
  '2': const [
    const {'1': 'barcode_code', '3': 1, '4': 1, '5': 9, '10': 'barcodeCode'},
  ],
};

/// Descriptor for `GetBarcodeDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBarcodeDetailsRequestDescriptor = $convert.base64Decode('ChhHZXRCYXJjb2RlRGV0YWlsc1JlcXVlc3QSIQoMYmFyY29kZV9jb2RlGAEgASgJUgtiYXJjb2RlQ29kZQ==');
@$core.Deprecated('Use getBarcodeDetailsResponseDescriptor instead')
const GetBarcodeDetailsResponse$json = const {
  '1': 'GetBarcodeDetailsResponse',
  '2': const [
    const {'1': 'barcode', '3': 1, '4': 1, '5': 11, '6': '.barcode_payment.BarcodePayment', '10': 'barcode'},
  ],
};

/// Descriptor for `GetBarcodeDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBarcodeDetailsResponseDescriptor = $convert.base64Decode('ChlHZXRCYXJjb2RlRGV0YWlsc1Jlc3BvbnNlEjkKB2JhcmNvZGUYASABKAsyHy5iYXJjb2RlX3BheW1lbnQuQmFyY29kZVBheW1lbnRSB2JhcmNvZGU=');
@$core.Deprecated('Use processBarcodePaymentRequestDescriptor instead')
const ProcessBarcodePaymentRequest$json = const {
  '1': 'ProcessBarcodePaymentRequest',
  '2': const [
    const {'1': 'barcode_code', '3': 1, '4': 1, '5': 9, '10': 'barcodeCode'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `ProcessBarcodePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processBarcodePaymentRequestDescriptor = $convert.base64Decode('ChxQcm9jZXNzQmFyY29kZVBheW1lbnRSZXF1ZXN0EiEKDGJhcmNvZGVfY29kZRgBIAEoCVILYmFyY29kZUNvZGUSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZA==');
@$core.Deprecated('Use processBarcodePaymentResponseDescriptor instead')
const ProcessBarcodePaymentResponse$json = const {
  '1': 'ProcessBarcodePaymentResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.barcode_payment.BarcodeTransaction', '10': 'transaction'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessBarcodePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processBarcodePaymentResponseDescriptor = $convert.base64Decode('Ch1Qcm9jZXNzQmFyY29kZVBheW1lbnRSZXNwb25zZRJFCgt0cmFuc2FjdGlvbhgBIAEoCzIjLmJhcmNvZGVfcGF5bWVudC5CYXJjb2RlVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getMyGeneratedBarcodesRequestDescriptor instead')
const GetMyGeneratedBarcodesRequest$json = const {
  '1': 'GetMyGeneratedBarcodesRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetMyGeneratedBarcodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyGeneratedBarcodesRequestDescriptor = $convert.base64Decode('Ch1HZXRNeUdlbmVyYXRlZEJhcmNvZGVzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAIgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getMyGeneratedBarcodesResponseDescriptor instead')
const GetMyGeneratedBarcodesResponse$json = const {
  '1': 'GetMyGeneratedBarcodesResponse',
  '2': const [
    const {'1': 'barcodes', '3': 1, '4': 3, '5': 11, '6': '.barcode_payment.BarcodePayment', '10': 'barcodes'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyGeneratedBarcodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyGeneratedBarcodesResponseDescriptor = $convert.base64Decode('Ch5HZXRNeUdlbmVyYXRlZEJhcmNvZGVzUmVzcG9uc2USOwoIYmFyY29kZXMYASADKAsyHy5iYXJjb2RlX3BheW1lbnQuQmFyY29kZVBheW1lbnRSCGJhcmNvZGVzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use getMyScannedBarcodesRequestDescriptor instead')
const GetMyScannedBarcodesRequest$json = const {
  '1': 'GetMyScannedBarcodesRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetMyScannedBarcodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyScannedBarcodesRequestDescriptor = $convert.base64Decode('ChtHZXRNeVNjYW5uZWRCYXJjb2Rlc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm9mZnNldBgCIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getMyScannedBarcodesResponseDescriptor instead')
const GetMyScannedBarcodesResponse$json = const {
  '1': 'GetMyScannedBarcodesResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.barcode_payment.BarcodeTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyScannedBarcodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyScannedBarcodesResponseDescriptor = $convert.base64Decode('ChxHZXRNeVNjYW5uZWRCYXJjb2Rlc1Jlc3BvbnNlEkcKDHRyYW5zYWN0aW9ucxgBIAMoCzIjLmJhcmNvZGVfcGF5bWVudC5CYXJjb2RlVHJhbnNhY3Rpb25SDHRyYW5zYWN0aW9ucxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use cancelBarcodeRequestDescriptor instead')
const CancelBarcodeRequest$json = const {
  '1': 'CancelBarcodeRequest',
  '2': const [
    const {'1': 'barcode_id', '3': 1, '4': 1, '5': 9, '10': 'barcodeId'},
  ],
};

/// Descriptor for `CancelBarcodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelBarcodeRequestDescriptor = $convert.base64Decode('ChRDYW5jZWxCYXJjb2RlUmVxdWVzdBIdCgpiYXJjb2RlX2lkGAEgASgJUgliYXJjb2RlSWQ=');
@$core.Deprecated('Use cancelBarcodeResponseDescriptor instead')
const CancelBarcodeResponse$json = const {
  '1': 'CancelBarcodeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelBarcodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelBarcodeResponseDescriptor = $convert.base64Decode('ChVDYW5jZWxCYXJjb2RlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use barcodePaymentDescriptor instead')
const BarcodePayment$json = const {
  '1': 'BarcodePayment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'full_name', '3': 4, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'barcode_code', '3': 5, '4': 1, '5': 9, '10': 'barcodeCode'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'expires_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'paid_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paidAt'},
  ],
};

/// Descriptor for `BarcodePayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePaymentDescriptor = $convert.base64Decode('Cg5CYXJjb2RlUGF5bWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhoKCHVzZXJuYW1lGAMgASgJUgh1c2VybmFtZRIbCglmdWxsX25hbWUYBCABKAlSCGZ1bGxOYW1lEiEKDGJhcmNvZGVfY29kZRgFIAEoCVILYmFyY29kZUNvZGUSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAggASgJUgtkZXNjcmlwdGlvbhIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCmV4cGlyZXNfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQSMwoHcGFpZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBnBhaWRBdA==');
@$core.Deprecated('Use barcodeTransactionDescriptor instead')
const BarcodeTransaction$json = const {
  '1': 'BarcodeTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'barcode_id', '3': 2, '4': 1, '5': 9, '10': 'barcodeId'},
    const {'1': 'payer_id', '3': 3, '4': 1, '5': 9, '10': 'payerId'},
    const {'1': 'payer_username', '3': 4, '4': 1, '5': 9, '10': 'payerUsername'},
    const {'1': 'payer_name', '3': 5, '4': 1, '5': 9, '10': 'payerName'},
    const {'1': 'recipient_id', '3': 6, '4': 1, '5': 9, '10': 'recipientId'},
    const {'1': 'recipient_username', '3': 7, '4': 1, '5': 9, '10': 'recipientUsername'},
    const {'1': 'recipient_name', '3': 8, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'amount', '3': 9, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reference_number', '3': 12, '4': 1, '5': 9, '10': 'referenceNumber'},
    const {'1': 'status', '3': 13, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `BarcodeTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodeTransactionDescriptor = $convert.base64Decode('ChJCYXJjb2RlVHJhbnNhY3Rpb24SDgoCaWQYASABKAlSAmlkEh0KCmJhcmNvZGVfaWQYAiABKAlSCWJhcmNvZGVJZBIZCghwYXllcl9pZBgDIAEoCVIHcGF5ZXJJZBIlCg5wYXllcl91c2VybmFtZRgEIAEoCVINcGF5ZXJVc2VybmFtZRIdCgpwYXllcl9uYW1lGAUgASgJUglwYXllck5hbWUSIQoMcmVjaXBpZW50X2lkGAYgASgJUgtyZWNpcGllbnRJZBItChJyZWNpcGllbnRfdXNlcm5hbWUYByABKAlSEXJlY2lwaWVudFVzZXJuYW1lEiUKDnJlY2lwaWVudF9uYW1lGAggASgJUg1yZWNpcGllbnROYW1lEhYKBmFtb3VudBgJIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAogASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgLIAEoCVILZGVzY3JpcHRpb24SKQoQcmVmZXJlbmNlX251bWJlchgMIAEoCVIPcmVmZXJlbmNlTnVtYmVyEhYKBnN0YXR1cxgNIAEoCVIGc3RhdHVzEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
