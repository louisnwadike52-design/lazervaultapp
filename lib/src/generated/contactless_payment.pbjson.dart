//
//  Generated code. Do not modify.
//  source: contactless_payment.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use createPaymentSessionRequestDescriptor instead')
const CreatePaymentSessionRequest$json = {
  '1': 'CreatePaymentSessionRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'validity_seconds', '3': 5, '4': 1, '5': 5, '10': 'validitySeconds'},
  ],
};

/// Descriptor for `CreatePaymentSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentSessionRequestDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVQYXltZW50U2Vzc2lvblJlcXVlc3QSFgoGYW1vdW50GAEgASgBUgZhbW91bnQSGg'
    'oIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIg'
    'CgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SKQoQdmFsaWRpdHlfc2Vjb25kcxgFIA'
    'EoBVIPdmFsaWRpdHlTZWNvbmRz');

@$core.Deprecated('Use createPaymentSessionResponseDescriptor instead')
const CreatePaymentSessionResponse$json = {
  '1': 'CreatePaymentSessionResponse',
  '2': [
    {'1': 'session', '3': 1, '4': 1, '5': 11, '6': '.contactless.PaymentSession', '10': 'session'},
    {'1': 'nfc_payload', '3': 2, '4': 1, '5': 9, '10': 'nfcPayload'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreatePaymentSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentSessionResponseDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVQYXltZW50U2Vzc2lvblJlc3BvbnNlEjUKB3Nlc3Npb24YASABKAsyGy5jb250YW'
    'N0bGVzcy5QYXltZW50U2Vzc2lvblIHc2Vzc2lvbhIfCgtuZmNfcGF5bG9hZBgCIAEoCVIKbmZj'
    'UGF5bG9hZBIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getPaymentSessionRequestDescriptor instead')
const GetPaymentSessionRequest$json = {
  '1': 'GetPaymentSessionRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `GetPaymentSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentSessionRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQYXltZW50U2Vzc2lvblJlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbk'
    'lk');

@$core.Deprecated('Use getPaymentSessionResponseDescriptor instead')
const GetPaymentSessionResponse$json = {
  '1': 'GetPaymentSessionResponse',
  '2': [
    {'1': 'session', '3': 1, '4': 1, '5': 11, '6': '.contactless.PaymentSession', '10': 'session'},
  ],
};

/// Descriptor for `GetPaymentSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentSessionResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQYXltZW50U2Vzc2lvblJlc3BvbnNlEjUKB3Nlc3Npb24YASABKAsyGy5jb250YWN0bG'
    'Vzcy5QYXltZW50U2Vzc2lvblIHc2Vzc2lvbg==');

@$core.Deprecated('Use processContactlessPaymentRequestDescriptor instead')
const ProcessContactlessPaymentRequest$json = {
  '1': 'ProcessContactlessPaymentRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `ProcessContactlessPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processContactlessPaymentRequestDescriptor = $convert.base64Decode(
    'CiBQcm9jZXNzQ29udGFjdGxlc3NQYXltZW50UmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgJUg'
    'lzZXNzaW9uSWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBIl'
    'Cg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG'
    '9rZW4YBCABKAlSEXZlcmlmaWNhdGlvblRva2Vu');

@$core.Deprecated('Use processContactlessPaymentResponseDescriptor instead')
const ProcessContactlessPaymentResponse$json = {
  '1': 'ProcessContactlessPaymentResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.contactless.ContactlessTransaction', '10': 'transaction'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessContactlessPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processContactlessPaymentResponseDescriptor = $convert.base64Decode(
    'CiFQcm9jZXNzQ29udGFjdGxlc3NQYXltZW50UmVzcG9uc2USRQoLdHJhbnNhY3Rpb24YASABKA'
    'syIy5jb250YWN0bGVzcy5Db250YWN0bGVzc1RyYW5zYWN0aW9uUgt0cmFuc2FjdGlvbhIfCgtu'
    'ZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use cancelPaymentSessionRequestDescriptor instead')
const CancelPaymentSessionRequest$json = {
  '1': 'CancelPaymentSessionRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `CancelPaymentSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelPaymentSessionRequestDescriptor = $convert.base64Decode(
    'ChtDYW5jZWxQYXltZW50U2Vzc2lvblJlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2'
    'lvbklk');

@$core.Deprecated('Use cancelPaymentSessionResponseDescriptor instead')
const CancelPaymentSessionResponse$json = {
  '1': 'CancelPaymentSessionResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelPaymentSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelPaymentSessionResponseDescriptor = $convert.base64Decode(
    'ChxDYW5jZWxQYXltZW50U2Vzc2lvblJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2'
    'U=');

@$core.Deprecated('Use getMyPaymentSessionsRequestDescriptor instead')
const GetMyPaymentSessionsRequest$json = {
  '1': 'GetMyPaymentSessionsRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'status_filter', '3': 3, '4': 1, '5': 9, '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetMyPaymentSessionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyPaymentSessionsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRNeVBheW1lbnRTZXNzaW9uc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm'
    '9mZnNldBgCIAEoBVIGb2Zmc2V0EiMKDXN0YXR1c19maWx0ZXIYAyABKAlSDHN0YXR1c0ZpbHRl'
    'cg==');

@$core.Deprecated('Use getMyPaymentSessionsResponseDescriptor instead')
const GetMyPaymentSessionsResponse$json = {
  '1': 'GetMyPaymentSessionsResponse',
  '2': [
    {'1': 'sessions', '3': 1, '4': 3, '5': 11, '6': '.contactless.PaymentSession', '10': 'sessions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyPaymentSessionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyPaymentSessionsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRNeVBheW1lbnRTZXNzaW9uc1Jlc3BvbnNlEjcKCHNlc3Npb25zGAEgAygLMhsuY29udG'
    'FjdGxlc3MuUGF5bWVudFNlc3Npb25SCHNlc3Npb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use getMyContactlessPaymentsRequestDescriptor instead')
const GetMyContactlessPaymentsRequest$json = {
  '1': 'GetMyContactlessPaymentsRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'role_filter', '3': 3, '4': 1, '5': 9, '10': 'roleFilter'},
  ],
};

/// Descriptor for `GetMyContactlessPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyContactlessPaymentsRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRNeUNvbnRhY3RsZXNzUGF5bWVudHNSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdB'
    'IWCgZvZmZzZXQYAiABKAVSBm9mZnNldBIfCgtyb2xlX2ZpbHRlchgDIAEoCVIKcm9sZUZpbHRl'
    'cg==');

@$core.Deprecated('Use getMyContactlessPaymentsResponseDescriptor instead')
const GetMyContactlessPaymentsResponse$json = {
  '1': 'GetMyContactlessPaymentsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.contactless.ContactlessTransaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyContactlessPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyContactlessPaymentsResponseDescriptor = $convert.base64Decode(
    'CiBHZXRNeUNvbnRhY3RsZXNzUGF5bWVudHNSZXNwb25zZRJHCgx0cmFuc2FjdGlvbnMYASADKA'
    'syIy5jb250YWN0bGVzcy5Db250YWN0bGVzc1RyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSFAoF'
    'dG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use checkSessionStatusRequestDescriptor instead')
const CheckSessionStatusRequest$json = {
  '1': 'CheckSessionStatusRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `CheckSessionStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkSessionStatusRequestDescriptor = $convert.base64Decode(
    'ChlDaGVja1Nlc3Npb25TdGF0dXNSZXF1ZXN0Eh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb2'
    '5JZA==');

@$core.Deprecated('Use checkSessionStatusResponseDescriptor instead')
const CheckSessionStatusResponse$json = {
  '1': 'CheckSessionStatusResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'payer_name', '3': 2, '4': 1, '5': 9, '10': 'payerName'},
    {'1': 'updated_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `CheckSessionStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkSessionStatusResponseDescriptor = $convert.base64Decode(
    'ChpDaGVja1Nlc3Npb25TdGF0dXNSZXNwb25zZRIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIdCg'
    'pwYXllcl9uYW1lGAIgASgJUglwYXllck5hbWUSOQoKdXBkYXRlZF9hdBgDIAEoCzIaLmdvb2ds'
    'ZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use acknowledgeSessionReadRequestDescriptor instead')
const AcknowledgeSessionReadRequest$json = {
  '1': 'AcknowledgeSessionReadRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `AcknowledgeSessionReadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acknowledgeSessionReadRequestDescriptor = $convert.base64Decode(
    'Ch1BY2tub3dsZWRnZVNlc3Npb25SZWFkUmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgJUglzZX'
    'NzaW9uSWQ=');

@$core.Deprecated('Use acknowledgeSessionReadResponseDescriptor instead')
const AcknowledgeSessionReadResponse$json = {
  '1': 'AcknowledgeSessionReadResponse',
  '2': [
    {'1': 'session', '3': 1, '4': 1, '5': 11, '6': '.contactless.PaymentSession', '10': 'session'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AcknowledgeSessionReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acknowledgeSessionReadResponseDescriptor = $convert.base64Decode(
    'Ch5BY2tub3dsZWRnZVNlc3Npb25SZWFkUmVzcG9uc2USNQoHc2Vzc2lvbhgBIAEoCzIbLmNvbn'
    'RhY3RsZXNzLlBheW1lbnRTZXNzaW9uUgdzZXNzaW9uEhgKB21lc3NhZ2UYAiABKAlSB21lc3Nh'
    'Z2U=');

@$core.Deprecated('Use paymentSessionDescriptor instead')
const PaymentSession$json = {
  '1': 'PaymentSession',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'receiver_id', '3': 2, '4': 1, '5': 9, '10': 'receiverId'},
    {'1': 'receiver_username', '3': 3, '4': 1, '5': 9, '10': 'receiverUsername'},
    {'1': 'receiver_name', '3': 4, '4': 1, '5': 9, '10': 'receiverName'},
    {'1': 'receiver_account_id', '3': 5, '4': 1, '5': 9, '10': 'receiverAccountId'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {'1': 'payer_id', '3': 11, '4': 1, '5': 9, '10': 'payerId'},
    {'1': 'payer_name', '3': 12, '4': 1, '5': 9, '10': 'payerName'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'expires_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    {'1': 'read_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'readAt'},
    {'1': 'completed_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `PaymentSession`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentSessionDescriptor = $convert.base64Decode(
    'Cg5QYXltZW50U2Vzc2lvbhIOCgJpZBgBIAEoCVICaWQSHwoLcmVjZWl2ZXJfaWQYAiABKAlSCn'
    'JlY2VpdmVySWQSKwoRcmVjZWl2ZXJfdXNlcm5hbWUYAyABKAlSEHJlY2VpdmVyVXNlcm5hbWUS'
    'IwoNcmVjZWl2ZXJfbmFtZRgEIAEoCVIMcmVjZWl2ZXJOYW1lEi4KE3JlY2VpdmVyX2FjY291bn'
    'RfaWQYBSABKAlSEXJlY2VpdmVyQWNjb3VudElkEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EhoK'
    'CGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIaCghjYXRlZ29yeRgIIAEoCVIIY2F0ZWdvcnkSIA'
    'oLZGVzY3JpcHRpb24YCSABKAlSC2Rlc2NyaXB0aW9uEhYKBnN0YXR1cxgKIAEoCVIGc3RhdHVz'
    'EhkKCHBheWVyX2lkGAsgASgJUgdwYXllcklkEh0KCnBheWVyX25hbWUYDCABKAlSCXBheWVyTm'
    'FtZRI5CgpjcmVhdGVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3Jl'
    'YXRlZEF0EjkKCmV4cGlyZXNfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg'
    'lleHBpcmVzQXQSMwoHcmVhZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'BnJlYWRBdBI9Cgxjb21wbGV0ZWRfYXQYECABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgtjb21wbGV0ZWRBdA==');

@$core.Deprecated('Use contactlessTransactionDescriptor instead')
const ContactlessTransaction$json = {
  '1': 'ContactlessTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'payer_id', '3': 3, '4': 1, '5': 9, '10': 'payerId'},
    {'1': 'payer_username', '3': 4, '4': 1, '5': 9, '10': 'payerUsername'},
    {'1': 'payer_name', '3': 5, '4': 1, '5': 9, '10': 'payerName'},
    {'1': 'payer_account_id', '3': 6, '4': 1, '5': 9, '10': 'payerAccountId'},
    {'1': 'receiver_id', '3': 7, '4': 1, '5': 9, '10': 'receiverId'},
    {'1': 'receiver_username', '3': 8, '4': 1, '5': 9, '10': 'receiverUsername'},
    {'1': 'receiver_name', '3': 9, '4': 1, '5': 9, '10': 'receiverName'},
    {'1': 'receiver_account_id', '3': 10, '4': 1, '5': 9, '10': 'receiverAccountId'},
    {'1': 'amount', '3': 11, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 12, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 13, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 14, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reference_number', '3': 15, '4': 1, '5': 9, '10': 'referenceNumber'},
    {'1': 'status', '3': 16, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `ContactlessTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactlessTransactionDescriptor = $convert.base64Decode(
    'ChZDb250YWN0bGVzc1RyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIdCgpzZXNzaW9uX2lkGA'
    'IgASgJUglzZXNzaW9uSWQSGQoIcGF5ZXJfaWQYAyABKAlSB3BheWVySWQSJQoOcGF5ZXJfdXNl'
    'cm5hbWUYBCABKAlSDXBheWVyVXNlcm5hbWUSHQoKcGF5ZXJfbmFtZRgFIAEoCVIJcGF5ZXJOYW'
    '1lEigKEHBheWVyX2FjY291bnRfaWQYBiABKAlSDnBheWVyQWNjb3VudElkEh8KC3JlY2VpdmVy'
    'X2lkGAcgASgJUgpyZWNlaXZlcklkEisKEXJlY2VpdmVyX3VzZXJuYW1lGAggASgJUhByZWNlaX'
    'ZlclVzZXJuYW1lEiMKDXJlY2VpdmVyX25hbWUYCSABKAlSDHJlY2VpdmVyTmFtZRIuChNyZWNl'
    'aXZlcl9hY2NvdW50X2lkGAogASgJUhFyZWNlaXZlckFjY291bnRJZBIWCgZhbW91bnQYCyABKA'
    'FSBmFtb3VudBIaCghjdXJyZW5jeRgMIAEoCVIIY3VycmVuY3kSGgoIY2F0ZWdvcnkYDSABKAlS'
    'CGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGA4gASgJUgtkZXNjcmlwdGlvbhIpChByZWZlcmVuY2'
    'VfbnVtYmVyGA8gASgJUg9yZWZlcmVuY2VOdW1iZXISFgoGc3RhdHVzGBAgASgJUgZzdGF0dXMS'
    'OQoKY3JlYXRlZF9hdBgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZW'
    'RBdA==');

@$core.Deprecated('Use nfcPayloadDataDescriptor instead')
const NfcPayloadData$json = {
  '1': 'NfcPayloadData',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'receiver_id', '3': 3, '4': 1, '5': 9, '10': 'receiverId'},
    {'1': 'receiver_username', '3': 4, '4': 1, '5': 9, '10': 'receiverUsername'},
    {'1': 'receiver_name', '3': 5, '4': 1, '5': 9, '10': 'receiverName'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    {'1': 'expires_at', '3': 10, '4': 1, '5': 3, '10': 'expiresAt'},
    {'1': 'signature', '3': 11, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `NfcPayloadData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nfcPayloadDataDescriptor = $convert.base64Decode(
    'Cg5OZmNQYXlsb2FkRGF0YRISCgR0eXBlGAEgASgJUgR0eXBlEh0KCnNlc3Npb25faWQYAiABKA'
    'lSCXNlc3Npb25JZBIfCgtyZWNlaXZlcl9pZBgDIAEoCVIKcmVjZWl2ZXJJZBIrChFyZWNlaXZl'
    'cl91c2VybmFtZRgEIAEoCVIQcmVjZWl2ZXJVc2VybmFtZRIjCg1yZWNlaXZlcl9uYW1lGAUgAS'
    'gJUgxyZWNlaXZlck5hbWUSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByAB'
    'KAlSCGN1cnJlbmN5EhoKCGNhdGVnb3J5GAggASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbh'
    'gJIAEoCVILZGVzY3JpcHRpb24SHQoKZXhwaXJlc19hdBgKIAEoA1IJZXhwaXJlc0F0EhwKCXNp'
    'Z25hdHVyZRgLIAEoCVIJc2lnbmF0dXJl');

