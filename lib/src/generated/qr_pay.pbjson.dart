///
//  Generated code. Do not modify.
//  source: qr_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use qRTypeDescriptor instead')
const QRType$json = const {
  '1': 'QRType',
  '2': const [
    const {'1': 'QR_TYPE_DYNAMIC', '2': 0},
    const {'1': 'QR_TYPE_STATIC', '2': 1},
  ],
};

/// Descriptor for `QRType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List qRTypeDescriptor = $convert.base64Decode('CgZRUlR5cGUSEwoPUVJfVFlQRV9EWU5BTUlDEAASEgoOUVJfVFlQRV9TVEFUSUMQAQ==');
@$core.Deprecated('Use qRStatusDescriptor instead')
const QRStatus$json = const {
  '1': 'QRStatus',
  '2': const [
    const {'1': 'QR_STATUS_PENDING', '2': 0},
    const {'1': 'QR_STATUS_PAID', '2': 1},
    const {'1': 'QR_STATUS_CANCELLED', '2': 2},
    const {'1': 'QR_STATUS_EXPIRED', '2': 3},
  ],
};

/// Descriptor for `QRStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List qRStatusDescriptor = $convert.base64Decode('CghRUlN0YXR1cxIVChFRUl9TVEFUVVNfUEVORElORxAAEhIKDlFSX1NUQVRVU19QQUlEEAESFwoTUVJfU1RBVFVTX0NBTkNFTExFRBACEhUKEVFSX1NUQVRVU19FWFBJUkVEEAM=');
@$core.Deprecated('Use qRCodeDescriptor instead')
const QRCode$json = const {
  '1': 'QRCode',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'full_name', '3': 4, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'qr_code', '3': 5, '4': 1, '5': 9, '10': 'qrCode'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'qr_type', '3': 9, '4': 1, '5': 14, '6': '.qr_pay.QRType', '10': 'qrType'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.qr_pay.QRStatus', '10': 'status'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'expires_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'paid_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paidAt'},
  ],
};

/// Descriptor for `QRCode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List qRCodeDescriptor = $convert.base64Decode('CgZRUkNvZGUSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIaCgh1c2VybmFtZRgDIAEoCVIIdXNlcm5hbWUSGwoJZnVsbF9uYW1lGAQgASgJUghmdWxsTmFtZRIXCgdxcl9jb2RlGAUgASgJUgZxckNvZGUSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAggASgJUgtkZXNjcmlwdGlvbhInCgdxcl90eXBlGAkgASgOMg4ucXJfcGF5LlFSVHlwZVIGcXJUeXBlEigKBnN0YXR1cxgKIAEoDjIQLnFyX3BheS5RUlN0YXR1c1IGc3RhdHVzEjkKCmNyZWF0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKZXhwaXJlc19hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWV4cGlyZXNBdBIzCgdwYWlkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIGcGFpZEF0');
@$core.Deprecated('Use qRTransactionDescriptor instead')
const QRTransaction$json = const {
  '1': 'QRTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'qr_id', '3': 2, '4': 1, '5': 9, '10': 'qrId'},
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
    const {'1': 'status', '3': 13, '4': 1, '5': 14, '6': '.qr_pay.QRStatus', '10': 'status'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `QRTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List qRTransactionDescriptor = $convert.base64Decode('Cg1RUlRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBITCgVxcl9pZBgCIAEoCVIEcXJJZBIZCghwYXllcl9pZBgDIAEoCVIHcGF5ZXJJZBIlCg5wYXllcl91c2VybmFtZRgEIAEoCVINcGF5ZXJVc2VybmFtZRIdCgpwYXllcl9uYW1lGAUgASgJUglwYXllck5hbWUSIQoMcmVjaXBpZW50X2lkGAYgASgJUgtyZWNpcGllbnRJZBItChJyZWNpcGllbnRfdXNlcm5hbWUYByABKAlSEXJlY2lwaWVudFVzZXJuYW1lEiUKDnJlY2lwaWVudF9uYW1lGAggASgJUg1yZWNpcGllbnROYW1lEhYKBmFtb3VudBgJIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAogASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgLIAEoCVILZGVzY3JpcHRpb24SKQoQcmVmZXJlbmNlX251bWJlchgMIAEoCVIPcmVmZXJlbmNlTnVtYmVyEigKBnN0YXR1cxgNIAEoDjIQLnFyX3BheS5RUlN0YXR1c1IGc3RhdHVzEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use generateQRRequestDescriptor instead')
const GenerateQRRequest$json = const {
  '1': 'GenerateQRRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'qr_type', '3': 4, '4': 1, '5': 14, '6': '.qr_pay.QRType', '10': 'qrType'},
    const {'1': 'validity_minutes', '3': 5, '4': 1, '5': 5, '10': 'validityMinutes'},
  ],
};

/// Descriptor for `GenerateQRRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateQRRequestDescriptor = $convert.base64Decode('ChFHZW5lcmF0ZVFSUmVxdWVzdBIWCgZhbW91bnQYASABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEicKB3FyX3R5cGUYBCABKA4yDi5xcl9wYXkuUVJUeXBlUgZxclR5cGUSKQoQdmFsaWRpdHlfbWludXRlcxgFIAEoBVIPdmFsaWRpdHlNaW51dGVz');
@$core.Deprecated('Use generateQRResponseDescriptor instead')
const GenerateQRResponse$json = const {
  '1': 'GenerateQRResponse',
  '2': const [
    const {'1': 'qr_code', '3': 1, '4': 1, '5': 11, '6': '.qr_pay.QRCode', '10': 'qrCode'},
    const {'1': 'qr_data', '3': 2, '4': 1, '5': 9, '10': 'qrData'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateQRResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateQRResponseDescriptor = $convert.base64Decode('ChJHZW5lcmF0ZVFSUmVzcG9uc2USJwoHcXJfY29kZRgBIAEoCzIOLnFyX3BheS5RUkNvZGVSBnFyQ29kZRIXCgdxcl9kYXRhGAIgASgJUgZxckRhdGESGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getQRDetailsRequestDescriptor instead')
const GetQRDetailsRequest$json = const {
  '1': 'GetQRDetailsRequest',
  '2': const [
    const {'1': 'qr_code', '3': 1, '4': 1, '5': 9, '10': 'qrCode'},
  ],
};

/// Descriptor for `GetQRDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQRDetailsRequestDescriptor = $convert.base64Decode('ChNHZXRRUkRldGFpbHNSZXF1ZXN0EhcKB3FyX2NvZGUYASABKAlSBnFyQ29kZQ==');
@$core.Deprecated('Use getQRDetailsResponseDescriptor instead')
const GetQRDetailsResponse$json = const {
  '1': 'GetQRDetailsResponse',
  '2': const [
    const {'1': 'qr_code', '3': 1, '4': 1, '5': 11, '6': '.qr_pay.QRCode', '10': 'qrCode'},
  ],
};

/// Descriptor for `GetQRDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQRDetailsResponseDescriptor = $convert.base64Decode('ChRHZXRRUkRldGFpbHNSZXNwb25zZRInCgdxcl9jb2RlGAEgASgLMg4ucXJfcGF5LlFSQ29kZVIGcXJDb2Rl');
@$core.Deprecated('Use processQRPaymentRequestDescriptor instead')
const ProcessQRPaymentRequest$json = const {
  '1': 'ProcessQRPaymentRequest',
  '2': const [
    const {'1': 'qr_code', '3': 1, '4': 1, '5': 9, '10': 'qrCode'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_pin', '3': 4, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ProcessQRPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processQRPaymentRequestDescriptor = $convert.base64Decode('ChdQcm9jZXNzUVJQYXltZW50UmVxdWVzdBIXCgdxcl9jb2RlGAEgASgJUgZxckNvZGUSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBIWCgZhbW91bnQYAyABKAFSBmFtb3VudBInCg90cmFuc2FjdGlvbl9waW4YBCABKAlSDnRyYW5zYWN0aW9uUGluEicKD2lkZW1wb3RlbmN5X2tleRgFIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use processQRPaymentResponseDescriptor instead')
const ProcessQRPaymentResponse$json = const {
  '1': 'ProcessQRPaymentResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.qr_pay.QRTransaction', '10': 'transaction'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessQRPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processQRPaymentResponseDescriptor = $convert.base64Decode('ChhQcm9jZXNzUVJQYXltZW50UmVzcG9uc2USNwoLdHJhbnNhY3Rpb24YASABKAsyFS5xcl9wYXkuUVJUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24SHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getMyGeneratedQRCodesRequestDescriptor instead')
const GetMyGeneratedQRCodesRequest$json = const {
  '1': 'GetMyGeneratedQRCodesRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'status_filter', '3': 3, '4': 1, '5': 14, '6': '.qr_pay.QRStatus', '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetMyGeneratedQRCodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyGeneratedQRCodesRequestDescriptor = $convert.base64Decode('ChxHZXRNeUdlbmVyYXRlZFFSQ29kZXNSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIWCgZvZmZzZXQYAiABKAVSBm9mZnNldBI1Cg1zdGF0dXNfZmlsdGVyGAMgASgOMhAucXJfcGF5LlFSU3RhdHVzUgxzdGF0dXNGaWx0ZXI=');
@$core.Deprecated('Use getMyGeneratedQRCodesResponseDescriptor instead')
const GetMyGeneratedQRCodesResponse$json = const {
  '1': 'GetMyGeneratedQRCodesResponse',
  '2': const [
    const {'1': 'qr_codes', '3': 1, '4': 3, '5': 11, '6': '.qr_pay.QRCode', '10': 'qrCodes'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyGeneratedQRCodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyGeneratedQRCodesResponseDescriptor = $convert.base64Decode('Ch1HZXRNeUdlbmVyYXRlZFFSQ29kZXNSZXNwb25zZRIpCghxcl9jb2RlcxgBIAMoCzIOLnFyX3BheS5RUkNvZGVSB3FyQ29kZXMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getMyQRPaymentsRequestDescriptor instead')
const GetMyQRPaymentsRequest$json = const {
  '1': 'GetMyQRPaymentsRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetMyQRPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyQRPaymentsRequestDescriptor = $convert.base64Decode('ChZHZXRNeVFSUGF5bWVudHNSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIWCgZvZmZzZXQYAiABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getMyQRPaymentsResponseDescriptor instead')
const GetMyQRPaymentsResponse$json = const {
  '1': 'GetMyQRPaymentsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.qr_pay.QRTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyQRPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyQRPaymentsResponseDescriptor = $convert.base64Decode('ChdHZXRNeVFSUGF5bWVudHNSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS5xcl9wYXkuUVJUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use cancelQRRequestDescriptor instead')
const CancelQRRequest$json = const {
  '1': 'CancelQRRequest',
  '2': const [
    const {'1': 'qr_id', '3': 1, '4': 1, '5': 9, '10': 'qrId'},
  ],
};

/// Descriptor for `CancelQRRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelQRRequestDescriptor = $convert.base64Decode('Cg9DYW5jZWxRUlJlcXVlc3QSEwoFcXJfaWQYASABKAlSBHFySWQ=');
@$core.Deprecated('Use cancelQRResponseDescriptor instead')
const CancelQRResponse$json = const {
  '1': 'CancelQRResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelQRResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelQRResponseDescriptor = $convert.base64Decode('ChBDYW5jZWxRUlJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getQRTransactionReceiptRequestDescriptor instead')
const GetQRTransactionReceiptRequest$json = const {
  '1': 'GetQRTransactionReceiptRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetQRTransactionReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQRTransactionReceiptRequestDescriptor = $convert.base64Decode('Ch5HZXRRUlRyYW5zYWN0aW9uUmVjZWlwdFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use getQRTransactionReceiptResponseDescriptor instead')
const GetQRTransactionReceiptResponse$json = const {
  '1': 'GetQRTransactionReceiptResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.qr_pay.QRTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `GetQRTransactionReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQRTransactionReceiptResponseDescriptor = $convert.base64Decode('Ch9HZXRRUlRyYW5zYWN0aW9uUmVjZWlwdFJlc3BvbnNlEjcKC3RyYW5zYWN0aW9uGAEgASgLMhUucXJfcGF5LlFSVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9u');
