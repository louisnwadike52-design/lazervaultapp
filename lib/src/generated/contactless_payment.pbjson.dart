///
//  Generated code. Do not modify.
//  source: contactless_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use createPaymentSessionRequestDescriptor instead')
const CreatePaymentSessionRequest$json = const {
  '1': 'CreatePaymentSessionRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'validity_seconds', '3': 5, '4': 1, '5': 5, '10': 'validitySeconds'},
  ],
};

/// Descriptor for `CreatePaymentSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentSessionRequestDescriptor = $convert.base64Decode('ChtDcmVhdGVQYXltZW50U2Vzc2lvblJlcXVlc3QSFgoGYW1vdW50GAEgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SKQoQdmFsaWRpdHlfc2Vjb25kcxgFIAEoBVIPdmFsaWRpdHlTZWNvbmRz');
@$core.Deprecated('Use createPaymentSessionResponseDescriptor instead')
const CreatePaymentSessionResponse$json = const {
  '1': 'CreatePaymentSessionResponse',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 11, '6': '.contactless_payment.PaymentSession', '10': 'session'},
    const {'1': 'nfc_payload', '3': 2, '4': 1, '5': 9, '10': 'nfcPayload'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreatePaymentSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentSessionResponseDescriptor = $convert.base64Decode('ChxDcmVhdGVQYXltZW50U2Vzc2lvblJlc3BvbnNlEj0KB3Nlc3Npb24YASABKAsyIy5jb250YWN0bGVzc19wYXltZW50LlBheW1lbnRTZXNzaW9uUgdzZXNzaW9uEh8KC25mY19wYXlsb2FkGAIgASgJUgpuZmNQYXlsb2FkEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getPaymentSessionRequestDescriptor instead')
const GetPaymentSessionRequest$json = const {
  '1': 'GetPaymentSessionRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `GetPaymentSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentSessionRequestDescriptor = $convert.base64Decode('ChhHZXRQYXltZW50U2Vzc2lvblJlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbklk');
@$core.Deprecated('Use getPaymentSessionResponseDescriptor instead')
const GetPaymentSessionResponse$json = const {
  '1': 'GetPaymentSessionResponse',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 11, '6': '.contactless_payment.PaymentSession', '10': 'session'},
  ],
};

/// Descriptor for `GetPaymentSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentSessionResponseDescriptor = $convert.base64Decode('ChlHZXRQYXltZW50U2Vzc2lvblJlc3BvbnNlEj0KB3Nlc3Npb24YASABKAsyIy5jb250YWN0bGVzc19wYXltZW50LlBheW1lbnRTZXNzaW9uUgdzZXNzaW9u');
@$core.Deprecated('Use processContactlessPaymentRequestDescriptor instead')
const ProcessContactlessPaymentRequest$json = const {
  '1': 'ProcessContactlessPaymentRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `ProcessContactlessPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processContactlessPaymentRequestDescriptor = $convert.base64Decode('CiBQcm9jZXNzQ29udGFjdGxlc3NQYXltZW50UmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgJUglzZXNzaW9uSWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBIlCg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBCABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use processContactlessPaymentResponseDescriptor instead')
const ProcessContactlessPaymentResponse$json = const {
  '1': 'ProcessContactlessPaymentResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.contactless_payment.ContactlessTransaction', '10': 'transaction'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessContactlessPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processContactlessPaymentResponseDescriptor = $convert.base64Decode('CiFQcm9jZXNzQ29udGFjdGxlc3NQYXltZW50UmVzcG9uc2USTQoLdHJhbnNhY3Rpb24YASABKAsyKy5jb250YWN0bGVzc19wYXltZW50LkNvbnRhY3RsZXNzVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use cancelPaymentSessionRequestDescriptor instead')
const CancelPaymentSessionRequest$json = const {
  '1': 'CancelPaymentSessionRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `CancelPaymentSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelPaymentSessionRequestDescriptor = $convert.base64Decode('ChtDYW5jZWxQYXltZW50U2Vzc2lvblJlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbklk');
@$core.Deprecated('Use cancelPaymentSessionResponseDescriptor instead')
const CancelPaymentSessionResponse$json = const {
  '1': 'CancelPaymentSessionResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelPaymentSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelPaymentSessionResponseDescriptor = $convert.base64Decode('ChxDYW5jZWxQYXltZW50U2Vzc2lvblJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getMyPaymentSessionsRequestDescriptor instead')
const GetMyPaymentSessionsRequest$json = const {
  '1': 'GetMyPaymentSessionsRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'status_filter', '3': 3, '4': 1, '5': 9, '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetMyPaymentSessionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyPaymentSessionsRequestDescriptor = $convert.base64Decode('ChtHZXRNeVBheW1lbnRTZXNzaW9uc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm9mZnNldBgCIAEoBVIGb2Zmc2V0EiMKDXN0YXR1c19maWx0ZXIYAyABKAlSDHN0YXR1c0ZpbHRlcg==');
@$core.Deprecated('Use getMyPaymentSessionsResponseDescriptor instead')
const GetMyPaymentSessionsResponse$json = const {
  '1': 'GetMyPaymentSessionsResponse',
  '2': const [
    const {'1': 'sessions', '3': 1, '4': 3, '5': 11, '6': '.contactless_payment.PaymentSession', '10': 'sessions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyPaymentSessionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyPaymentSessionsResponseDescriptor = $convert.base64Decode('ChxHZXRNeVBheW1lbnRTZXNzaW9uc1Jlc3BvbnNlEj8KCHNlc3Npb25zGAEgAygLMiMuY29udGFjdGxlc3NfcGF5bWVudC5QYXltZW50U2Vzc2lvblIIc2Vzc2lvbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getMyContactlessPaymentsRequestDescriptor instead')
const GetMyContactlessPaymentsRequest$json = const {
  '1': 'GetMyContactlessPaymentsRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'role_filter', '3': 3, '4': 1, '5': 9, '10': 'roleFilter'},
  ],
};

/// Descriptor for `GetMyContactlessPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyContactlessPaymentsRequestDescriptor = $convert.base64Decode('Ch9HZXRNeUNvbnRhY3RsZXNzUGF5bWVudHNSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIWCgZvZmZzZXQYAiABKAVSBm9mZnNldBIfCgtyb2xlX2ZpbHRlchgDIAEoCVIKcm9sZUZpbHRlcg==');
@$core.Deprecated('Use getMyContactlessPaymentsResponseDescriptor instead')
const GetMyContactlessPaymentsResponse$json = const {
  '1': 'GetMyContactlessPaymentsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.contactless_payment.ContactlessTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyContactlessPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyContactlessPaymentsResponseDescriptor = $convert.base64Decode('CiBHZXRNeUNvbnRhY3RsZXNzUGF5bWVudHNSZXNwb25zZRJPCgx0cmFuc2FjdGlvbnMYASADKAsyKy5jb250YWN0bGVzc19wYXltZW50LkNvbnRhY3RsZXNzVHJhbnNhY3Rpb25SDHRyYW5zYWN0aW9ucxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use checkSessionStatusRequestDescriptor instead')
const CheckSessionStatusRequest$json = const {
  '1': 'CheckSessionStatusRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `CheckSessionStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkSessionStatusRequestDescriptor = $convert.base64Decode('ChlDaGVja1Nlc3Npb25TdGF0dXNSZXF1ZXN0Eh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb25JZA==');
@$core.Deprecated('Use checkSessionStatusResponseDescriptor instead')
const CheckSessionStatusResponse$json = const {
  '1': 'CheckSessionStatusResponse',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'payer_name', '3': 2, '4': 1, '5': 9, '10': 'payerName'},
    const {'1': 'updated_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `CheckSessionStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkSessionStatusResponseDescriptor = $convert.base64Decode('ChpDaGVja1Nlc3Npb25TdGF0dXNSZXNwb25zZRIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIdCgpwYXllcl9uYW1lGAIgASgJUglwYXllck5hbWUSOQoKdXBkYXRlZF9hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use acknowledgeSessionReadRequestDescriptor instead')
const AcknowledgeSessionReadRequest$json = const {
  '1': 'AcknowledgeSessionReadRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `AcknowledgeSessionReadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acknowledgeSessionReadRequestDescriptor = $convert.base64Decode('Ch1BY2tub3dsZWRnZVNlc3Npb25SZWFkUmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgJUglzZXNzaW9uSWQ=');
@$core.Deprecated('Use acknowledgeSessionReadResponseDescriptor instead')
const AcknowledgeSessionReadResponse$json = const {
  '1': 'AcknowledgeSessionReadResponse',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 11, '6': '.contactless_payment.PaymentSession', '10': 'session'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AcknowledgeSessionReadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acknowledgeSessionReadResponseDescriptor = $convert.base64Decode('Ch5BY2tub3dsZWRnZVNlc3Npb25SZWFkUmVzcG9uc2USPQoHc2Vzc2lvbhgBIAEoCzIjLmNvbnRhY3RsZXNzX3BheW1lbnQuUGF5bWVudFNlc3Npb25SB3Nlc3Npb24SGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use paymentSessionDescriptor instead')
const PaymentSession$json = const {
  '1': 'PaymentSession',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'receiver_id', '3': 2, '4': 1, '5': 9, '10': 'receiverId'},
    const {'1': 'receiver_username', '3': 3, '4': 1, '5': 9, '10': 'receiverUsername'},
    const {'1': 'receiver_name', '3': 4, '4': 1, '5': 9, '10': 'receiverName'},
    const {'1': 'receiver_account_id', '3': 5, '4': 1, '5': 9, '10': 'receiverAccountId'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'payer_id', '3': 11, '4': 1, '5': 9, '10': 'payerId'},
    const {'1': 'payer_name', '3': 12, '4': 1, '5': 9, '10': 'payerName'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'expires_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'read_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'readAt'},
    const {'1': 'completed_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `PaymentSession`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentSessionDescriptor = $convert.base64Decode('Cg5QYXltZW50U2Vzc2lvbhIOCgJpZBgBIAEoCVICaWQSHwoLcmVjZWl2ZXJfaWQYAiABKAlSCnJlY2VpdmVySWQSKwoRcmVjZWl2ZXJfdXNlcm5hbWUYAyABKAlSEHJlY2VpdmVyVXNlcm5hbWUSIwoNcmVjZWl2ZXJfbmFtZRgEIAEoCVIMcmVjZWl2ZXJOYW1lEi4KE3JlY2VpdmVyX2FjY291bnRfaWQYBSABKAlSEXJlY2VpdmVyQWNjb3VudElkEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIaCghjYXRlZ29yeRgIIAEoCVIIY2F0ZWdvcnkSIAoLZGVzY3JpcHRpb24YCSABKAlSC2Rlc2NyaXB0aW9uEhYKBnN0YXR1cxgKIAEoCVIGc3RhdHVzEhkKCHBheWVyX2lkGAsgASgJUgdwYXllcklkEh0KCnBheWVyX25hbWUYDCABKAlSCXBheWVyTmFtZRI5CgpjcmVhdGVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCmV4cGlyZXNfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQSMwoHcmVhZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBnJlYWRBdBI9Cgxjb21wbGV0ZWRfYXQYECABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtjb21wbGV0ZWRBdA==');
@$core.Deprecated('Use contactlessTransactionDescriptor instead')
const ContactlessTransaction$json = const {
  '1': 'ContactlessTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'payer_id', '3': 3, '4': 1, '5': 9, '10': 'payerId'},
    const {'1': 'payer_username', '3': 4, '4': 1, '5': 9, '10': 'payerUsername'},
    const {'1': 'payer_name', '3': 5, '4': 1, '5': 9, '10': 'payerName'},
    const {'1': 'payer_account_id', '3': 6, '4': 1, '5': 9, '10': 'payerAccountId'},
    const {'1': 'receiver_id', '3': 7, '4': 1, '5': 9, '10': 'receiverId'},
    const {'1': 'receiver_username', '3': 8, '4': 1, '5': 9, '10': 'receiverUsername'},
    const {'1': 'receiver_name', '3': 9, '4': 1, '5': 9, '10': 'receiverName'},
    const {'1': 'receiver_account_id', '3': 10, '4': 1, '5': 9, '10': 'receiverAccountId'},
    const {'1': 'amount', '3': 11, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 12, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 13, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 14, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reference_number', '3': 15, '4': 1, '5': 9, '10': 'referenceNumber'},
    const {'1': 'status', '3': 16, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `ContactlessTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactlessTransactionDescriptor = $convert.base64Decode('ChZDb250YWN0bGVzc1RyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIdCgpzZXNzaW9uX2lkGAIgASgJUglzZXNzaW9uSWQSGQoIcGF5ZXJfaWQYAyABKAlSB3BheWVySWQSJQoOcGF5ZXJfdXNlcm5hbWUYBCABKAlSDXBheWVyVXNlcm5hbWUSHQoKcGF5ZXJfbmFtZRgFIAEoCVIJcGF5ZXJOYW1lEigKEHBheWVyX2FjY291bnRfaWQYBiABKAlSDnBheWVyQWNjb3VudElkEh8KC3JlY2VpdmVyX2lkGAcgASgJUgpyZWNlaXZlcklkEisKEXJlY2VpdmVyX3VzZXJuYW1lGAggASgJUhByZWNlaXZlclVzZXJuYW1lEiMKDXJlY2VpdmVyX25hbWUYCSABKAlSDHJlY2VpdmVyTmFtZRIuChNyZWNlaXZlcl9hY2NvdW50X2lkGAogASgJUhFyZWNlaXZlckFjY291bnRJZBIWCgZhbW91bnQYCyABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgMIAEoCVIIY3VycmVuY3kSGgoIY2F0ZWdvcnkYDSABKAlSCGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGA4gASgJUgtkZXNjcmlwdGlvbhIpChByZWZlcmVuY2VfbnVtYmVyGA8gASgJUg9yZWZlcmVuY2VOdW1iZXISFgoGc3RhdHVzGBAgASgJUgZzdGF0dXMSOQoKY3JlYXRlZF9hdBgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use nfcPayloadDataDescriptor instead')
const NfcPayloadData$json = const {
  '1': 'NfcPayloadData',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'receiver_id', '3': 3, '4': 1, '5': 9, '10': 'receiverId'},
    const {'1': 'receiver_username', '3': 4, '4': 1, '5': 9, '10': 'receiverUsername'},
    const {'1': 'receiver_name', '3': 5, '4': 1, '5': 9, '10': 'receiverName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'category', '3': 8, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'expires_at', '3': 10, '4': 1, '5': 3, '10': 'expiresAt'},
    const {'1': 'signature', '3': 11, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `NfcPayloadData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nfcPayloadDataDescriptor = $convert.base64Decode('Cg5OZmNQYXlsb2FkRGF0YRISCgR0eXBlGAEgASgJUgR0eXBlEh0KCnNlc3Npb25faWQYAiABKAlSCXNlc3Npb25JZBIfCgtyZWNlaXZlcl9pZBgDIAEoCVIKcmVjZWl2ZXJJZBIrChFyZWNlaXZlcl91c2VybmFtZRgEIAEoCVIQcmVjZWl2ZXJVc2VybmFtZRIjCg1yZWNlaXZlcl9uYW1lGAUgASgJUgxyZWNlaXZlck5hbWUSFgoGYW1vdW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EhoKCGNhdGVnb3J5GAggASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgJIAEoCVILZGVzY3JpcHRpb24SHQoKZXhwaXJlc19hdBgKIAEoA1IJZXhwaXJlc0F0EhwKCXNpZ25hdHVyZRgLIAEoCVIJc2lnbmF0dXJl');
