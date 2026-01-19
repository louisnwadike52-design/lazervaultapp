///
//  Generated code. Do not modify.
//  source: ai_scan.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use scanTypeDescriptor instead')
const ScanType$json = const {
  '1': 'ScanType',
  '2': const [
    const {'1': 'SCAN_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'INVOICE', '2': 1},
    const {'1': 'UTILITY_BILL', '2': 2},
    const {'1': 'QR_CODE', '2': 3},
    const {'1': 'BARCODE', '2': 4},
    const {'1': 'ACCOUNT_DETAILS', '2': 5},
    const {'1': 'GIFT_CARD', '2': 6},
    const {'1': 'RECEIPT', '2': 7},
    const {'1': 'BANK_DETAILS', '2': 8},
  ],
};

/// Descriptor for `ScanType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scanTypeDescriptor = $convert.base64Decode('CghTY2FuVHlwZRIZChVTQ0FOX1RZUEVfVU5TUEVDSUZJRUQQABILCgdJTlZPSUNFEAESEAoMVVRJTElUWV9CSUxMEAISCwoHUVJfQ09ERRADEgsKB0JBUkNPREUQBBITCg9BQ0NPVU5UX0RFVEFJTFMQBRINCglHSUZUX0NBUkQQBhILCgdSRUNFSVBUEAcSEAoMQkFOS19ERVRBSUxTEAg=');
@$core.Deprecated('Use scanStatusDescriptor instead')
const ScanStatus$json = const {
  '1': 'ScanStatus',
  '2': const [
    const {'1': 'SCAN_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'PENDING', '2': 1},
    const {'1': 'PROCESSING', '2': 2},
    const {'1': 'COMPLETED', '2': 3},
    const {'1': 'FAILED', '2': 4},
  ],
};

/// Descriptor for `ScanStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scanStatusDescriptor = $convert.base64Decode('CgpTY2FuU3RhdHVzEhsKF1NDQU5fU1RBVFVTX1VOU1BFQ0lGSUVEEAASCwoHUEVORElORxABEg4KClBST0NFU1NJTkcQAhINCglDT01QTEVURUQQAxIKCgZGQUlMRUQQBA==');
@$core.Deprecated('Use startScanSessionRequestDescriptor instead')
const StartScanSessionRequest$json = const {
  '1': 'StartScanSessionRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'scan_type', '3': 2, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
  ],
};

/// Descriptor for `StartScanSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startScanSessionRequestDescriptor = $convert.base64Decode('ChdTdGFydFNjYW5TZXNzaW9uUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSLgoJc2Nhbl90eXBlGAIgASgOMhEuYWlfc2Nhbi5TY2FuVHlwZVIIc2NhblR5cGU=');
@$core.Deprecated('Use startScanSessionResponseDescriptor instead')
const StartScanSessionResponse$json = const {
  '1': 'StartScanSessionResponse',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'scan_type', '3': 2, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.ai_scan.ScanStatus', '10': 'status'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 3, '10': 'createdAt'},
  ],
};

/// Descriptor for `StartScanSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startScanSessionResponseDescriptor = $convert.base64Decode('ChhTdGFydFNjYW5TZXNzaW9uUmVzcG9uc2USHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbklkEi4KCXNjYW5fdHlwZRgCIAEoDjIRLmFpX3NjYW4uU2NhblR5cGVSCHNjYW5UeXBlEisKBnN0YXR1cxgDIAEoDjITLmFpX3NjYW4uU2NhblN0YXR1c1IGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYBCABKANSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use processImageRequestDescriptor instead')
const ProcessImageRequest$json = const {
  '1': 'ProcessImageRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'image_data', '3': 2, '4': 1, '5': 12, '10': 'imageData'},
    const {'1': 'scan_type', '3': 3, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
  ],
};

/// Descriptor for `ProcessImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processImageRequestDescriptor = $convert.base64Decode('ChNQcm9jZXNzSW1hZ2VSZXF1ZXN0Eh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb25JZBIdCgppbWFnZV9kYXRhGAIgASgMUglpbWFnZURhdGESLgoJc2Nhbl90eXBlGAMgASgOMhEuYWlfc2Nhbi5TY2FuVHlwZVIIc2NhblR5cGU=');
@$core.Deprecated('Use extractedDataDescriptor instead')
const ExtractedData$json = const {
  '1': 'ExtractedData',
  '2': const [
    const {'1': 'recipient', '3': 1, '4': 1, '5': 9, '10': 'recipient'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'due_date', '3': 5, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'account_number', '3': 7, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'routing_number', '3': 8, '4': 1, '5': 9, '10': 'routingNumber'},
    const {'1': 'bank_name', '3': 9, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'additional_fields', '3': 10, '4': 3, '5': 11, '6': '.ai_scan.ExtractedData.AdditionalFieldsEntry', '10': 'additionalFields'},
    const {'1': 'confidence_score', '3': 11, '4': 1, '5': 2, '10': 'confidenceScore'},
  ],
  '3': const [ExtractedData_AdditionalFieldsEntry$json],
};

@$core.Deprecated('Use extractedDataDescriptor instead')
const ExtractedData_AdditionalFieldsEntry$json = const {
  '1': 'AdditionalFieldsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ExtractedData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractedDataDescriptor = $convert.base64Decode('Cg1FeHRyYWN0ZWREYXRhEhwKCXJlY2lwaWVudBgBIAEoCVIJcmVjaXBpZW50EhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYBCABKAlSCXJlZmVyZW5jZRIZCghkdWVfZGF0ZRgFIAEoCVIHZHVlRGF0ZRIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SJQoOYWNjb3VudF9udW1iZXIYByABKAlSDWFjY291bnROdW1iZXISJQoOcm91dGluZ19udW1iZXIYCCABKAlSDXJvdXRpbmdOdW1iZXISGwoJYmFua19uYW1lGAkgASgJUghiYW5rTmFtZRJZChFhZGRpdGlvbmFsX2ZpZWxkcxgKIAMoCzIsLmFpX3NjYW4uRXh0cmFjdGVkRGF0YS5BZGRpdGlvbmFsRmllbGRzRW50cnlSEGFkZGl0aW9uYWxGaWVsZHMSKQoQY29uZmlkZW5jZV9zY29yZRgLIAEoAlIPY29uZmlkZW5jZVNjb3JlGkMKFUFkZGl0aW9uYWxGaWVsZHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use processImageResponseDescriptor instead')
const ProcessImageResponse$json = const {
  '1': 'ProcessImageResponse',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'extracted_data', '3': 2, '4': 1, '5': 11, '6': '.ai_scan.ExtractedData', '10': 'extractedData'},
    const {'1': 'ai_message', '3': 3, '4': 1, '5': 9, '10': 'aiMessage'},
    const {'1': 'success', '3': 4, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_message', '3': 5, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `ProcessImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processImageResponseDescriptor = $convert.base64Decode('ChRQcm9jZXNzSW1hZ2VSZXNwb25zZRIdCgpzZXNzaW9uX2lkGAEgASgJUglzZXNzaW9uSWQSPQoOZXh0cmFjdGVkX2RhdGEYAiABKAsyFi5haV9zY2FuLkV4dHJhY3RlZERhdGFSDWV4dHJhY3RlZERhdGESHQoKYWlfbWVzc2FnZRgDIAEoCVIJYWlNZXNzYWdlEhgKB3N1Y2Nlc3MYBCABKAhSB3N1Y2Nlc3MSIwoNZXJyb3JfbWVzc2FnZRgFIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use sendChatMessageRequestDescriptor instead')
const SendChatMessageRequest$json = const {
  '1': 'SendChatMessageRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'user_message', '3': 2, '4': 1, '5': 9, '10': 'userMessage'},
    const {'1': 'context_data', '3': 3, '4': 1, '5': 11, '6': '.ai_scan.ExtractedData', '10': 'contextData'},
  ],
};

/// Descriptor for `SendChatMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendChatMessageRequestDescriptor = $convert.base64Decode('ChZTZW5kQ2hhdE1lc3NhZ2VSZXF1ZXN0Eh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb25JZBIhCgx1c2VyX21lc3NhZ2UYAiABKAlSC3VzZXJNZXNzYWdlEjkKDGNvbnRleHRfZGF0YRgDIAEoCzIWLmFpX3NjYW4uRXh0cmFjdGVkRGF0YVILY29udGV4dERhdGE=');
@$core.Deprecated('Use sendChatMessageResponseDescriptor instead')
const SendChatMessageResponse$json = const {
  '1': 'SendChatMessageResponse',
  '2': const [
    const {'1': 'message_id', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    const {'1': 'ai_response', '3': 2, '4': 1, '5': 9, '10': 'aiResponse'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `SendChatMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendChatMessageResponseDescriptor = $convert.base64Decode('ChdTZW5kQ2hhdE1lc3NhZ2VSZXNwb25zZRIdCgptZXNzYWdlX2lkGAEgASgJUgltZXNzYWdlSWQSHwoLYWlfcmVzcG9uc2UYAiABKAlSCmFpUmVzcG9uc2USHAoJdGltZXN0YW1wGAMgASgDUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use generatePaymentInstructionRequestDescriptor instead')
const GeneratePaymentInstructionRequest$json = const {
  '1': 'GeneratePaymentInstructionRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'extracted_data', '3': 2, '4': 1, '5': 11, '6': '.ai_scan.ExtractedData', '10': 'extractedData'},
    const {'1': 'scan_type', '3': 3, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
  ],
};

/// Descriptor for `GeneratePaymentInstructionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatePaymentInstructionRequestDescriptor = $convert.base64Decode('CiFHZW5lcmF0ZVBheW1lbnRJbnN0cnVjdGlvblJlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbklkEj0KDmV4dHJhY3RlZF9kYXRhGAIgASgLMhYuYWlfc2Nhbi5FeHRyYWN0ZWREYXRhUg1leHRyYWN0ZWREYXRhEi4KCXNjYW5fdHlwZRgDIAEoDjIRLmFpX3NjYW4uU2NhblR5cGVSCHNjYW5UeXBl');
@$core.Deprecated('Use paymentInstructionDescriptor instead')
const PaymentInstruction$json = const {
  '1': 'PaymentInstruction',
  '2': const [
    const {'1': 'instruction_id', '3': 1, '4': 1, '5': 9, '10': 'instructionId'},
    const {'1': 'recipient', '3': 2, '4': 1, '5': 9, '10': 'recipient'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 7, '4': 3, '5': 11, '6': '.ai_scan.PaymentInstruction.MetadataEntry', '10': 'metadata'},
  ],
  '3': const [PaymentInstruction_MetadataEntry$json],
};

@$core.Deprecated('Use paymentInstructionDescriptor instead')
const PaymentInstruction_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `PaymentInstruction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentInstructionDescriptor = $convert.base64Decode('ChJQYXltZW50SW5zdHJ1Y3Rpb24SJQoOaW5zdHJ1Y3Rpb25faWQYASABKAlSDWluc3RydWN0aW9uSWQSHAoJcmVjaXBpZW50GAIgASgJUglyZWNpcGllbnQSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgFIAEoCVIJcmVmZXJlbmNlEiAKC2Rlc2NyaXB0aW9uGAYgASgJUgtkZXNjcmlwdGlvbhJFCghtZXRhZGF0YRgHIAMoCzIpLmFpX3NjYW4uUGF5bWVudEluc3RydWN0aW9uLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use generatePaymentInstructionResponseDescriptor instead')
const GeneratePaymentInstructionResponse$json = const {
  '1': 'GeneratePaymentInstructionResponse',
  '2': const [
    const {'1': 'instruction', '3': 1, '4': 1, '5': 11, '6': '.ai_scan.PaymentInstruction', '10': 'instruction'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `GeneratePaymentInstructionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatePaymentInstructionResponseDescriptor = $convert.base64Decode('CiJHZW5lcmF0ZVBheW1lbnRJbnN0cnVjdGlvblJlc3BvbnNlEj0KC2luc3RydWN0aW9uGAEgASgLMhsuYWlfc2Nhbi5QYXltZW50SW5zdHJ1Y3Rpb25SC2luc3RydWN0aW9uEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use scanProcessPaymentRequestDescriptor instead')
const ScanProcessPaymentRequest$json = const {
  '1': 'ScanProcessPaymentRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'instruction', '3': 3, '4': 1, '5': 11, '6': '.ai_scan.PaymentInstruction', '10': 'instruction'},
  ],
};

/// Descriptor for `ScanProcessPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanProcessPaymentRequestDescriptor = $convert.base64Decode('ChlTY2FuUHJvY2Vzc1BheW1lbnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIdCgpzZXNzaW9uX2lkGAIgASgJUglzZXNzaW9uSWQSPQoLaW5zdHJ1Y3Rpb24YAyABKAsyGy5haV9zY2FuLlBheW1lbnRJbnN0cnVjdGlvblILaW5zdHJ1Y3Rpb24=');
@$core.Deprecated('Use scanProcessPaymentResponseDescriptor instead')
const ScanProcessPaymentResponse$json = const {
  '1': 'ScanProcessPaymentResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'timestamp', '3': 5, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `ScanProcessPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanProcessPaymentResponseDescriptor = $convert.base64Decode('ChpTY2FuUHJvY2Vzc1BheW1lbnRSZXNwb25zZRIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEiMKDWVycm9yX21lc3NhZ2UYBCABKAlSDGVycm9yTWVzc2FnZRIcCgl0aW1lc3RhbXAYBSABKANSCXRpbWVzdGFtcA==');
@$core.Deprecated('Use getScanHistoryRequestDescriptor instead')
const GetScanHistoryRequest$json = const {
  '1': 'GetScanHistoryRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetScanHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getScanHistoryRequestDescriptor = $convert.base64Decode('ChVHZXRTY2FuSGlzdG9yeVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhIKBHBhZ2UYAiABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAMgASgFUghwYWdlU2l6ZQ==');
@$core.Deprecated('Use scanSessionHistoryDescriptor instead')
const ScanSessionHistory$json = const {
  '1': 'ScanSessionHistory',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'scan_type', '3': 2, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.ai_scan.ScanStatus', '10': 'status'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 3, '10': 'createdAt'},
    const {'1': 'extracted_data', '3': 5, '4': 1, '5': 11, '6': '.ai_scan.ExtractedData', '10': 'extractedData'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `ScanSessionHistory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanSessionHistoryDescriptor = $convert.base64Decode('ChJTY2FuU2Vzc2lvbkhpc3RvcnkSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbklkEi4KCXNjYW5fdHlwZRgCIAEoDjIRLmFpX3NjYW4uU2NhblR5cGVSCHNjYW5UeXBlEisKBnN0YXR1cxgDIAEoDjITLmFpX3NjYW4uU2NhblN0YXR1c1IGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYBCABKANSCWNyZWF0ZWRBdBI9Cg5leHRyYWN0ZWRfZGF0YRgFIAEoCzIWLmFpX3NjYW4uRXh0cmFjdGVkRGF0YVINZXh0cmFjdGVkRGF0YRIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use getScanHistoryResponseDescriptor instead')
const GetScanHistoryResponse$json = const {
  '1': 'GetScanHistoryResponse',
  '2': const [
    const {'1': 'sessions', '3': 1, '4': 3, '5': 11, '6': '.ai_scan.ScanSessionHistory', '10': 'sessions'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetScanHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getScanHistoryResponseDescriptor = $convert.base64Decode('ChZHZXRTY2FuSGlzdG9yeVJlc3BvbnNlEjcKCHNlc3Npb25zGAEgAygLMhsuYWlfc2Nhbi5TY2FuU2Vzc2lvbkhpc3RvcnlSCHNlc3Npb25zEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50EhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');
