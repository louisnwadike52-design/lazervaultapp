//
//  Generated code. Do not modify.
//  source: ai_scan.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use scanTypeDescriptor instead')
const ScanType$json = {
  '1': 'ScanType',
  '2': [
    {'1': 'SCAN_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'INVOICE', '2': 1},
    {'1': 'UTILITY_BILL', '2': 2},
    {'1': 'QR_CODE', '2': 3},
    {'1': 'BARCODE', '2': 4},
    {'1': 'ACCOUNT_DETAILS', '2': 5},
    {'1': 'GIFT_CARD', '2': 6},
    {'1': 'RECEIPT', '2': 7},
    {'1': 'BANK_DETAILS', '2': 8},
  ],
};

/// Descriptor for `ScanType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scanTypeDescriptor = $convert.base64Decode(
    'CghTY2FuVHlwZRIZChVTQ0FOX1RZUEVfVU5TUEVDSUZJRUQQABILCgdJTlZPSUNFEAESEAoMVV'
    'RJTElUWV9CSUxMEAISCwoHUVJfQ09ERRADEgsKB0JBUkNPREUQBBITCg9BQ0NPVU5UX0RFVEFJ'
    'TFMQBRINCglHSUZUX0NBUkQQBhILCgdSRUNFSVBUEAcSEAoMQkFOS19ERVRBSUxTEAg=');

@$core.Deprecated('Use scanStatusDescriptor instead')
const ScanStatus$json = {
  '1': 'ScanStatus',
  '2': [
    {'1': 'SCAN_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'PENDING', '2': 1},
    {'1': 'PROCESSING', '2': 2},
    {'1': 'COMPLETED', '2': 3},
    {'1': 'FAILED', '2': 4},
  ],
};

/// Descriptor for `ScanStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scanStatusDescriptor = $convert.base64Decode(
    'CgpTY2FuU3RhdHVzEhsKF1NDQU5fU1RBVFVTX1VOU1BFQ0lGSUVEEAASCwoHUEVORElORxABEg'
    '4KClBST0NFU1NJTkcQAhINCglDT01QTEVURUQQAxIKCgZGQUlMRUQQBA==');

@$core.Deprecated('Use startScanSessionRequestDescriptor instead')
const StartScanSessionRequest$json = {
  '1': 'StartScanSessionRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'scan_type', '3': 2, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
  ],
};

/// Descriptor for `StartScanSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startScanSessionRequestDescriptor = $convert.base64Decode(
    'ChdTdGFydFNjYW5TZXNzaW9uUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSLgoJc2'
    'Nhbl90eXBlGAIgASgOMhEuYWlfc2Nhbi5TY2FuVHlwZVIIc2NhblR5cGU=');

@$core.Deprecated('Use startScanSessionResponseDescriptor instead')
const StartScanSessionResponse$json = {
  '1': 'StartScanSessionResponse',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'scan_type', '3': 2, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.ai_scan.ScanStatus', '10': 'status'},
    {'1': 'created_at', '3': 4, '4': 1, '5': 3, '10': 'createdAt'},
  ],
};

/// Descriptor for `StartScanSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startScanSessionResponseDescriptor = $convert.base64Decode(
    'ChhTdGFydFNjYW5TZXNzaW9uUmVzcG9uc2USHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbk'
    'lkEi4KCXNjYW5fdHlwZRgCIAEoDjIRLmFpX3NjYW4uU2NhblR5cGVSCHNjYW5UeXBlEisKBnN0'
    'YXR1cxgDIAEoDjITLmFpX3NjYW4uU2NhblN0YXR1c1IGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYBC'
    'ABKANSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use processImageRequestDescriptor instead')
const ProcessImageRequest$json = {
  '1': 'ProcessImageRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'image_data', '3': 2, '4': 1, '5': 12, '10': 'imageData'},
    {'1': 'scan_type', '3': 3, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
  ],
};

/// Descriptor for `ProcessImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processImageRequestDescriptor = $convert.base64Decode(
    'ChNQcm9jZXNzSW1hZ2VSZXF1ZXN0Eh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb25JZBIdCg'
    'ppbWFnZV9kYXRhGAIgASgMUglpbWFnZURhdGESLgoJc2Nhbl90eXBlGAMgASgOMhEuYWlfc2Nh'
    'bi5TY2FuVHlwZVIIc2NhblR5cGU=');

@$core.Deprecated('Use extractedDataDescriptor instead')
const ExtractedData$json = {
  '1': 'ExtractedData',
  '2': [
    {'1': 'recipient', '3': 1, '4': 1, '5': 9, '10': 'recipient'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'due_date', '3': 5, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'account_number', '3': 7, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'routing_number', '3': 8, '4': 1, '5': 9, '10': 'routingNumber'},
    {'1': 'bank_name', '3': 9, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'additional_fields', '3': 10, '4': 3, '5': 11, '6': '.ai_scan.ExtractedData.AdditionalFieldsEntry', '10': 'additionalFields'},
    {'1': 'confidence_score', '3': 11, '4': 1, '5': 2, '10': 'confidenceScore'},
  ],
  '3': [ExtractedData_AdditionalFieldsEntry$json],
};

@$core.Deprecated('Use extractedDataDescriptor instead')
const ExtractedData_AdditionalFieldsEntry$json = {
  '1': 'AdditionalFieldsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ExtractedData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractedDataDescriptor = $convert.base64Decode(
    'Cg1FeHRyYWN0ZWREYXRhEhwKCXJlY2lwaWVudBgBIAEoCVIJcmVjaXBpZW50EhYKBmFtb3VudB'
    'gCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UY'
    'BCABKAlSCXJlZmVyZW5jZRIZCghkdWVfZGF0ZRgFIAEoCVIHZHVlRGF0ZRIgCgtkZXNjcmlwdG'
    'lvbhgGIAEoCVILZGVzY3JpcHRpb24SJQoOYWNjb3VudF9udW1iZXIYByABKAlSDWFjY291bnRO'
    'dW1iZXISJQoOcm91dGluZ19udW1iZXIYCCABKAlSDXJvdXRpbmdOdW1iZXISGwoJYmFua19uYW'
    '1lGAkgASgJUghiYW5rTmFtZRJZChFhZGRpdGlvbmFsX2ZpZWxkcxgKIAMoCzIsLmFpX3NjYW4u'
    'RXh0cmFjdGVkRGF0YS5BZGRpdGlvbmFsRmllbGRzRW50cnlSEGFkZGl0aW9uYWxGaWVsZHMSKQ'
    'oQY29uZmlkZW5jZV9zY29yZRgLIAEoAlIPY29uZmlkZW5jZVNjb3JlGkMKFUFkZGl0aW9uYWxG'
    'aWVsZHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use processImageResponseDescriptor instead')
const ProcessImageResponse$json = {
  '1': 'ProcessImageResponse',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'extracted_data', '3': 2, '4': 1, '5': 11, '6': '.ai_scan.ExtractedData', '10': 'extractedData'},
    {'1': 'ai_message', '3': 3, '4': 1, '5': 9, '10': 'aiMessage'},
    {'1': 'success', '3': 4, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_message', '3': 5, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `ProcessImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processImageResponseDescriptor = $convert.base64Decode(
    'ChRQcm9jZXNzSW1hZ2VSZXNwb25zZRIdCgpzZXNzaW9uX2lkGAEgASgJUglzZXNzaW9uSWQSPQ'
    'oOZXh0cmFjdGVkX2RhdGEYAiABKAsyFi5haV9zY2FuLkV4dHJhY3RlZERhdGFSDWV4dHJhY3Rl'
    'ZERhdGESHQoKYWlfbWVzc2FnZRgDIAEoCVIJYWlNZXNzYWdlEhgKB3N1Y2Nlc3MYBCABKAhSB3'
    'N1Y2Nlc3MSIwoNZXJyb3JfbWVzc2FnZRgFIAEoCVIMZXJyb3JNZXNzYWdl');

@$core.Deprecated('Use sendChatMessageRequestDescriptor instead')
const SendChatMessageRequest$json = {
  '1': 'SendChatMessageRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'user_message', '3': 2, '4': 1, '5': 9, '10': 'userMessage'},
    {'1': 'context_data', '3': 3, '4': 1, '5': 11, '6': '.ai_scan.ExtractedData', '10': 'contextData'},
  ],
};

/// Descriptor for `SendChatMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendChatMessageRequestDescriptor = $convert.base64Decode(
    'ChZTZW5kQ2hhdE1lc3NhZ2VSZXF1ZXN0Eh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb25JZB'
    'IhCgx1c2VyX21lc3NhZ2UYAiABKAlSC3VzZXJNZXNzYWdlEjkKDGNvbnRleHRfZGF0YRgDIAEo'
    'CzIWLmFpX3NjYW4uRXh0cmFjdGVkRGF0YVILY29udGV4dERhdGE=');

@$core.Deprecated('Use sendChatMessageResponseDescriptor instead')
const SendChatMessageResponse$json = {
  '1': 'SendChatMessageResponse',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'ai_response', '3': 2, '4': 1, '5': 9, '10': 'aiResponse'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `SendChatMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendChatMessageResponseDescriptor = $convert.base64Decode(
    'ChdTZW5kQ2hhdE1lc3NhZ2VSZXNwb25zZRIdCgptZXNzYWdlX2lkGAEgASgJUgltZXNzYWdlSW'
    'QSHwoLYWlfcmVzcG9uc2UYAiABKAlSCmFpUmVzcG9uc2USHAoJdGltZXN0YW1wGAMgASgDUgl0'
    'aW1lc3RhbXA=');

@$core.Deprecated('Use generatePaymentInstructionRequestDescriptor instead')
const GeneratePaymentInstructionRequest$json = {
  '1': 'GeneratePaymentInstructionRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'extracted_data', '3': 2, '4': 1, '5': 11, '6': '.ai_scan.ExtractedData', '10': 'extractedData'},
    {'1': 'scan_type', '3': 3, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
  ],
};

/// Descriptor for `GeneratePaymentInstructionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatePaymentInstructionRequestDescriptor = $convert.base64Decode(
    'CiFHZW5lcmF0ZVBheW1lbnRJbnN0cnVjdGlvblJlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoCV'
    'IJc2Vzc2lvbklkEj0KDmV4dHJhY3RlZF9kYXRhGAIgASgLMhYuYWlfc2Nhbi5FeHRyYWN0ZWRE'
    'YXRhUg1leHRyYWN0ZWREYXRhEi4KCXNjYW5fdHlwZRgDIAEoDjIRLmFpX3NjYW4uU2NhblR5cG'
    'VSCHNjYW5UeXBl');

@$core.Deprecated('Use paymentInstructionDescriptor instead')
const PaymentInstruction$json = {
  '1': 'PaymentInstruction',
  '2': [
    {'1': 'instruction_id', '3': 1, '4': 1, '5': 9, '10': 'instructionId'},
    {'1': 'recipient', '3': 2, '4': 1, '5': 9, '10': 'recipient'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 7, '4': 3, '5': 11, '6': '.ai_scan.PaymentInstruction.MetadataEntry', '10': 'metadata'},
  ],
  '3': [PaymentInstruction_MetadataEntry$json],
};

@$core.Deprecated('Use paymentInstructionDescriptor instead')
const PaymentInstruction_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `PaymentInstruction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentInstructionDescriptor = $convert.base64Decode(
    'ChJQYXltZW50SW5zdHJ1Y3Rpb24SJQoOaW5zdHJ1Y3Rpb25faWQYASABKAlSDWluc3RydWN0aW'
    '9uSWQSHAoJcmVjaXBpZW50GAIgASgJUglyZWNpcGllbnQSFgoGYW1vdW50GAMgASgBUgZhbW91'
    'bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgFIAEoCVIJcmVmZX'
    'JlbmNlEiAKC2Rlc2NyaXB0aW9uGAYgASgJUgtkZXNjcmlwdGlvbhJFCghtZXRhZGF0YRgHIAMo'
    'CzIpLmFpX3NjYW4uUGF5bWVudEluc3RydWN0aW9uLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGj'
    'sKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVl'
    'OgI4AQ==');

@$core.Deprecated('Use generatePaymentInstructionResponseDescriptor instead')
const GeneratePaymentInstructionResponse$json = {
  '1': 'GeneratePaymentInstructionResponse',
  '2': [
    {'1': 'instruction', '3': 1, '4': 1, '5': 11, '6': '.ai_scan.PaymentInstruction', '10': 'instruction'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `GeneratePaymentInstructionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatePaymentInstructionResponseDescriptor = $convert.base64Decode(
    'CiJHZW5lcmF0ZVBheW1lbnRJbnN0cnVjdGlvblJlc3BvbnNlEj0KC2luc3RydWN0aW9uGAEgAS'
    'gLMhsuYWlfc2Nhbi5QYXltZW50SW5zdHJ1Y3Rpb25SC2luc3RydWN0aW9uEhgKB3N1Y2Nlc3MY'
    'AiABKAhSB3N1Y2Nlc3MSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdl');

@$core.Deprecated('Use scanProcessPaymentRequestDescriptor instead')
const ScanProcessPaymentRequest$json = {
  '1': 'ScanProcessPaymentRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'instruction', '3': 3, '4': 1, '5': 11, '6': '.ai_scan.PaymentInstruction', '10': 'instruction'},
  ],
};

/// Descriptor for `ScanProcessPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanProcessPaymentRequestDescriptor = $convert.base64Decode(
    'ChlTY2FuUHJvY2Vzc1BheW1lbnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIdCg'
    'pzZXNzaW9uX2lkGAIgASgJUglzZXNzaW9uSWQSPQoLaW5zdHJ1Y3Rpb24YAyABKAsyGy5haV9z'
    'Y2FuLlBheW1lbnRJbnN0cnVjdGlvblILaW5zdHJ1Y3Rpb24=');

@$core.Deprecated('Use scanProcessPaymentResponseDescriptor instead')
const ScanProcessPaymentResponse$json = {
  '1': 'ScanProcessPaymentResponse',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `ScanProcessPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanProcessPaymentResponseDescriptor = $convert.base64Decode(
    'ChpTY2FuUHJvY2Vzc1BheW1lbnRSZXNwb25zZRIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdH'
    'JhbnNhY3Rpb25JZBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhYKBnN0YXR1cxgDIAEoCVIG'
    'c3RhdHVzEiMKDWVycm9yX21lc3NhZ2UYBCABKAlSDGVycm9yTWVzc2FnZRIcCgl0aW1lc3RhbX'
    'AYBSABKANSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use getScanHistoryRequestDescriptor instead')
const GetScanHistoryRequest$json = {
  '1': 'GetScanHistoryRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetScanHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getScanHistoryRequestDescriptor = $convert.base64Decode(
    'ChVHZXRTY2FuSGlzdG9yeVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhIKBHBhZ2'
    'UYAiABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAMgASgFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use scanSessionHistoryDescriptor instead')
const ScanSessionHistory$json = {
  '1': 'ScanSessionHistory',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'scan_type', '3': 2, '4': 1, '5': 14, '6': '.ai_scan.ScanType', '10': 'scanType'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.ai_scan.ScanStatus', '10': 'status'},
    {'1': 'created_at', '3': 4, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'extracted_data', '3': 5, '4': 1, '5': 11, '6': '.ai_scan.ExtractedData', '10': 'extractedData'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `ScanSessionHistory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanSessionHistoryDescriptor = $convert.base64Decode(
    'ChJTY2FuU2Vzc2lvbkhpc3RvcnkSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2lvbklkEi4KCX'
    'NjYW5fdHlwZRgCIAEoDjIRLmFpX3NjYW4uU2NhblR5cGVSCHNjYW5UeXBlEisKBnN0YXR1cxgD'
    'IAEoDjITLmFpX3NjYW4uU2NhblN0YXR1c1IGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYBCABKANSCW'
    'NyZWF0ZWRBdBI9Cg5leHRyYWN0ZWRfZGF0YRgFIAEoCzIWLmFpX3NjYW4uRXh0cmFjdGVkRGF0'
    'YVINZXh0cmFjdGVkRGF0YRIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZA'
    '==');

@$core.Deprecated('Use getScanHistoryResponseDescriptor instead')
const GetScanHistoryResponse$json = {
  '1': 'GetScanHistoryResponse',
  '2': [
    {'1': 'sessions', '3': 1, '4': 3, '5': 11, '6': '.ai_scan.ScanSessionHistory', '10': 'sessions'},
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetScanHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getScanHistoryResponseDescriptor = $convert.base64Decode(
    'ChZHZXRTY2FuSGlzdG9yeVJlc3BvbnNlEjcKCHNlc3Npb25zGAEgAygLMhsuYWlfc2Nhbi5TY2'
    'FuU2Vzc2lvbkhpc3RvcnlSCHNlc3Npb25zEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENv'
    'dW50EhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');

