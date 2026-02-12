//
//  Generated code. Do not modify.
//  source: ai_chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use processChatRequestDescriptor instead')
const ProcessChatRequest$json = {
  '1': 'ProcessChatRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'query'},
    {'1': 'tx_history', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'txHistory'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 13, '8': {}, '10': 'userId'},
    {'1': 'uploaded_file', '3': 4, '4': 1, '5': 11, '6': '.pb.ChatFile', '8': {}, '9': 0, '10': 'uploadedFile', '17': true},
    {'1': 'session_id', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'sessionId'},
    {'1': 'source_context', '3': 6, '4': 1, '5': 9, '8': {}, '10': 'sourceContext'},
    {'1': 'language', '3': 7, '4': 1, '5': 9, '8': {}, '10': 'language'},
    {'1': 'account_id', '3': 8, '4': 1, '5': 9, '8': {}, '10': 'accountId'},
    {'1': 'user_country', '3': 9, '4': 1, '5': 9, '8': {}, '10': 'userCountry'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '8': {}, '10': 'currency'},
  ],
  '7': {},
  '8': [
    {'1': '_uploaded_file'},
  ],
};

/// Descriptor for `ProcessChatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processChatRequestDescriptor = $convert.base64Decode(
    'ChJQcm9jZXNzQ2hhdFJlcXVlc3QSPAoFcXVlcnkYASABKAlCJpJBIzIhVGhlIHVzZXIncyBpbn'
    'B1dC9xdWVyeSB0byB0aGUgQUkuUgVxdWVyeRJTCgp0eF9oaXN0b3J5GAIgASgJQjSSQTEyL0pT'
    'T04gc3RyaW5nIGNvbnRhaW5pbmcgdGhlIGxhc3QgNSB0cmFuc2FjdGlvbnMuUgl0eEhpc3Rvcn'
    'kSRAoHdXNlcl9pZBgDIAEoDUIrkkEoMiZUaGUgSUQgb2YgdGhlIHVzZXIgbWFraW5nIHRoZSBy'
    'ZXF1ZXN0LlIGdXNlcklkEnIKDXVwbG9hZGVkX2ZpbGUYBCABKAsyDC5wYi5DaGF0RmlsZUI6kk'
    'E3MjVPcHRpb25hbCBmaWxlIHVwbG9hZGVkIGJ5IHRoZSB1c2VyIGZvciBBSSBwcm9jZXNzaW5n'
    'LkgAUgx1cGxvYWRlZEZpbGWIAQESUwoKc2Vzc2lvbl9pZBgFIAEoCUI0kkExMi9TZXNzaW9uIG'
    'lkZW50aWZpZXIgZm9yIGNvbnZlcnNhdGlvbiBjb250aW51aXR5LlIJc2Vzc2lvbklkEmsKDnNv'
    'dXJjZV9jb250ZXh0GAYgASgJQkSSQUEyP1doZXJlIHRoZSBjaGF0IHdhcyBpbml0aWF0ZWQgZn'
    'JvbSAoZS5nLiwgZGFzaGJvYXJkLCB0cmFuc2ZlcnMpLlINc291cmNlQ29udGV4dBJPCghsYW5n'
    'dWFnZRgHIAEoCUIzkkEwMi5Vc2VyJ3MgcHJlZmVycmVkIGxhbmd1YWdlIGNvZGUgKGUuZy4sIG'
    'VuLCBmcikuUghsYW5ndWFnZRI9CgphY2NvdW50X2lkGAggASgJQh6SQRsyGVVzZXIncyBhY3Rp'
    'dmUgYWNjb3VudCBJRC5SCWFjY291bnRJZBJLCgx1c2VyX2NvdW50cnkYCSABKAlCKJJBJTIjVX'
    'NlcidzIGNvdW50cnkgY29kZSAoZS5nLiwgTkcsIEdIKS5SC3VzZXJDb3VudHJ5EkcKCGN1cnJl'
    'bmN5GAogASgJQiuSQSgyJlVzZXIncyBjdXJyZW5jeSBjb2RlIChlLmcuLCBOR04sIEdIUykuUg'
    'hjdXJyZW5jeTp8kkF5CncqF0FJIFByb2Nlc3MgQ2hhdCBSZXF1ZXN0MkpQYXlsb2FkIGNvbnRh'
    'aW5pbmcgdGhlIHVzZXIncyBxdWVyeSBmb3IgdGhlIEFJIGNoYXRib3Qgd2l0aCBvcHRpb25hbC'
    'BmaWxlLtIBBXF1ZXJ50gEHdXNlcl9pZEIQCg5fdXBsb2FkZWRfZmlsZQ==');

@$core.Deprecated('Use processChatResponseDescriptor instead')
const ProcessChatResponse$json = {
  '1': 'ProcessChatResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '8': {}, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'msg'},
    {'1': 'query', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'query'},
    {'1': 'response', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'response'},
    {'1': 'generated_files', '3': 5, '4': 3, '5': 11, '6': '.pb.ChatFile', '8': {}, '10': 'generatedFiles'},
    {'1': 'file_analysis', '3': 6, '4': 1, '5': 11, '6': '.pb.FileAnalysis', '8': {}, '10': 'fileAnalysis'},
    {'1': 'intent', '3': 7, '4': 1, '5': 9, '8': {}, '10': 'intent'},
    {'1': 'entities', '3': 8, '4': 3, '5': 11, '6': '.pb.ProcessChatResponse.EntitiesEntry', '8': {}, '10': 'entities'},
    {'1': 'requires_confirmation', '3': 9, '4': 1, '5': 8, '8': {}, '10': 'requiresConfirmation'},
    {'1': 'action_buttons', '3': 10, '4': 3, '5': 11, '6': '.pb.ActionButton', '8': {}, '10': 'actionButtons'},
    {'1': 'session_id', '3': 11, '4': 1, '5': 9, '8': {}, '10': 'sessionId'},
    {'1': 'confirmation_data', '3': 12, '4': 1, '5': 11, '6': '.pb.ConfirmationData', '8': {}, '10': 'confirmationData'},
    {'1': 'conversation_state', '3': 13, '4': 1, '5': 9, '8': {}, '10': 'conversationState'},
  ],
  '3': [ProcessChatResponse_EntitiesEntry$json],
  '7': {},
};

@$core.Deprecated('Use processChatResponseDescriptor instead')
const ProcessChatResponse_EntitiesEntry$json = {
  '1': 'EntitiesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ProcessChatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processChatResponseDescriptor = $convert.base64Decode(
    'ChNQcm9jZXNzQ2hhdFJlc3BvbnNlElEKB3N1Y2Nlc3MYASABKAhCN5JBNDIySW5kaWNhdGVzIG'
    'lmIHRoZSBxdWVyeSB3YXMgc3VjY2Vzc2Z1bGx5IHByb2Nlc3NlZC5SB3N1Y2Nlc3MSQgoDbXNn'
    'GAIgASgJQjCSQS0yK0Egc3RhdHVzIG1lc3NhZ2UgcmVsYXRlZCB0byB0aGUgcHJvY2Vzc2luZy'
    '5SA21zZxI/CgVxdWVyeRgDIAEoCUIpkkEmMiRUaGUgb3JpZ2luYWwgcXVlcnkgc2VudCBieSB0'
    'aGUgdXNlci5SBXF1ZXJ5EjMKCHJlc3BvbnNlGAQgASgJQheSQRQyElRoZSBBSSdzIHJlc3Bvbn'
    'NlLlIIcmVzcG9uc2USbwoPZ2VuZXJhdGVkX2ZpbGVzGAUgAygLMgwucGIuQ2hhdEZpbGVCOJJB'
    'NTIzRmlsZXMgZ2VuZXJhdGVkIGJ5IHRoZSBBSSBpbiByZXNwb25zZSB0byB0aGUgcXVlcnkuUg'
    '5nZW5lcmF0ZWRGaWxlcxJfCg1maWxlX2FuYWx5c2lzGAYgASgLMhAucGIuRmlsZUFuYWx5c2lz'
    'QiiSQSUyI0FuYWx5c2lzIHJlc3VsdHMgb2YgdXBsb2FkZWQgZmlsZXMuUgxmaWxlQW5hbHlzaX'
    'MSRQoGaW50ZW50GAcgASgJQi2SQSoyKENsYXNzaWZpZWQgaW50ZW50IG9mIHRoZSB1c2VyJ3Mg'
    'bWVzc2FnZS5SBmludGVudBJ1CghlbnRpdGllcxgIIAMoCzIlLnBiLlByb2Nlc3NDaGF0UmVzcG'
    '9uc2UuRW50aXRpZXNFbnRyeUIykkEvMi1FeHRyYWN0ZWQgZW50aXRpZXMgKGFtb3VudCwgcmVj'
    'aXBpZW50LCBldGMuKS5SCGVudGl0aWVzEmIKFXJlcXVpcmVzX2NvbmZpcm1hdGlvbhgJIAEoCE'
    'ItkkEqMihXaGV0aGVyIHRoZSB1c2VyIG11c3QgY29uZmlybSBhbiBhY3Rpb24uUhRyZXF1aXJl'
    'c0NvbmZpcm1hdGlvbhJkCg5hY3Rpb25fYnV0dG9ucxgKIAMoCzIQLnBiLkFjdGlvbkJ1dHRvbk'
    'IrkkEoMiZTdWdnZXN0ZWQgYWN0aW9uIGJ1dHRvbnMgZm9yIHRoZSB1c2VyLlINYWN0aW9uQnV0'
    'dG9ucxJLCgpzZXNzaW9uX2lkGAsgASgJQiySQSkyJ1Nlc3Npb24gSUQgZm9yIGNvbnZlcnNhdG'
    'lvbiBjb250aW51aXR5LlIJc2Vzc2lvbklkEnUKEWNvbmZpcm1hdGlvbl9kYXRhGAwgASgLMhQu'
    'cGIuQ29uZmlybWF0aW9uRGF0YUIykkEvMi1TdHJ1Y3R1cmVkIGRhdGEgZm9yIHRyYW5zYWN0aW'
    '9uIGNvbmZpcm1hdGlvbi5SEGNvbmZpcm1hdGlvbkRhdGEScwoSY29udmVyc2F0aW9uX3N0YXRl'
    'GA0gASgJQkSSQUEyP0N1cnJlbnQgY29udmVyc2F0aW9uIHN0YXRlIChJRExFLCBBV0FJVElOR1'
    '9DT05GSVJNQVRJT04sIGV0Yy4pLlIRY29udmVyc2F0aW9uU3RhdGUaOwoNRW50aXRpZXNFbnRy'
    'eRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBOlaSQVMKUSoYQU'
    'kgUHJvY2VzcyBDaGF0IFJlc3BvbnNlMjVDb250YWlucyB0aGUgQUkgY2hhdGJvdCdzIHJlc3Bv'
    'bnNlIGFsb25nIHdpdGggc3RhdHVzLg==');

@$core.Deprecated('Use chatFileDescriptor instead')
const ChatFile$json = {
  '1': 'ChatFile',
  '2': [
    {'1': 'filename', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'filename'},
    {'1': 'content_type', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'contentType'},
    {'1': 'file_content', '3': 3, '4': 1, '5': 12, '8': {}, '10': 'fileContent'},
    {'1': 'file_id', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'fileId'},
    {'1': 'file_url', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'fileUrl'},
    {'1': 'file_size', '3': 6, '4': 1, '5': 3, '8': {}, '10': 'fileSize'},
    {'1': 'upload_timestamp', '3': 7, '4': 1, '5': 9, '8': {}, '10': 'uploadTimestamp'},
  ],
  '7': {},
};

/// Descriptor for `ChatFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatFileDescriptor = $convert.base64Decode(
    'CghDaGF0RmlsZRJKCghmaWxlbmFtZRgBIAEoCUIukkErMilPcmlnaW5hbCBmaWxlbmFtZSAocm'
    'VxdWlyZWQgZm9yIHVwbG9hZHMpLlIIZmlsZW5hbWUSVQoMY29udGVudF90eXBlGAIgASgJQjKS'
    'QS8yLU1JTUUgdHlwZSBvZiB0aGUgZmlsZSAocmVxdWlyZWQgZm9yIHVwbG9hZHMpLlILY29udG'
    'VudFR5cGUSWgoMZmlsZV9jb250ZW50GAMgASgMQjeSQTQyMkJpbmFyeSBjb250ZW50IG9mIHRo'
    'ZSBmaWxlIChyZXF1aXJlZCBmb3IgdXBsb2FkcykuUgtmaWxlQ29udGVudBJNCgdmaWxlX2lkGA'
    'QgASgJQjSSQTEyL1VuaXF1ZSBpZGVudGlmaWVyIGZvciB0aGUgZmlsZSAoc2V0IGJ5IHNlcnZl'
    'cikuUgZmaWxlSWQSZQoIZmlsZV91cmwYBSABKAlCSpJBRzJFVVJMIHRvIGFjY2VzcyB0aGUgZm'
    'lsZSAoc2V0IGJ5IHNlcnZlciBmb3IgZG93bmxvYWRzL2dlbmVyYXRlZCBmaWxlcykuUgdmaWxl'
    'VXJsEkwKCWZpbGVfc2l6ZRgGIAEoA0IvkkEsMipTaXplIG9mIHRoZSBmaWxlIGluIGJ5dGVzIC'
    'hzZXQgYnkgc2VydmVyKS5SCGZpbGVTaXplEm0KEHVwbG9hZF90aW1lc3RhbXAYByABKAlCQpJB'
    'PzI9V2hlbiB0aGUgZmlsZSB3YXMgdXBsb2FkZWQgaW4gUkZDMzMzOSBmb3JtYXQgKHNldCBieS'
    'BzZXJ2ZXIpLlIPdXBsb2FkVGltZXN0YW1wOlGSQU4KTCoJQ2hhdCBGaWxlMj9SZXByZXNlbnRz'
    'IGEgZmlsZSBpbiB0aGUgY2hhdCBjb250ZXh0IChmb3IgdXBsb2FkIG9yIGRvd25sb2FkKS4=');

@$core.Deprecated('Use fileAnalysisDescriptor instead')
const FileAnalysis$json = {
  '1': 'FileAnalysis',
  '2': [
    {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.pb.FileAnalysisResult', '8': {}, '10': 'results'},
    {'1': 'summary', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'summary'},
  ],
  '7': {},
};

/// Descriptor for `FileAnalysis`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileAnalysisDescriptor = $convert.base64Decode(
    'CgxGaWxlQW5hbHlzaXMSYAoHcmVzdWx0cxgBIAMoCzIWLnBiLkZpbGVBbmFseXNpc1Jlc3VsdE'
    'IukkErMilBbmFseXNpcyByZXN1bHRzIGZvciBlYWNoIHByb2Nlc3NlZCBmaWxlLlIHcmVzdWx0'
    'cxJACgdzdW1tYXJ5GAIgASgJQiaSQSMyIU92ZXJhbGwgc3VtbWFyeSBvZiBmaWxlIGFuYWx5c2'
    'lzLlIHc3VtbWFyeTpMkkFJCkcqDUZpbGUgQW5hbHlzaXMyNkFuYWx5c2lzIHJlc3VsdHMgZnJv'
    'bSBBSSBwcm9jZXNzaW5nIG9mIHVwbG9hZGVkIGZpbGVzLg==');

@$core.Deprecated('Use fileAnalysisResultDescriptor instead')
const FileAnalysisResult$json = {
  '1': 'FileAnalysisResult',
  '2': [
    {'1': 'file_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'fileId'},
    {'1': 'filename', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'filename'},
    {'1': 'analysis_type', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'analysisType'},
    {'1': 'analysis_result', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'analysisResult'},
    {'1': 'metadata', '3': 5, '4': 3, '5': 11, '6': '.pb.FileAnalysisResult.MetadataEntry', '8': {}, '10': 'metadata'},
    {'1': 'processing_success', '3': 6, '4': 1, '5': 8, '8': {}, '10': 'processingSuccess'},
    {'1': 'error_message', '3': 7, '4': 1, '5': 9, '8': {}, '10': 'errorMessage'},
  ],
  '3': [FileAnalysisResult_MetadataEntry$json],
  '7': {},
};

@$core.Deprecated('Use fileAnalysisResultDescriptor instead')
const FileAnalysisResult_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `FileAnalysisResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileAnalysisResultDescriptor = $convert.base64Decode(
    'ChJGaWxlQW5hbHlzaXNSZXN1bHQSNgoHZmlsZV9pZBgBIAEoCUIdkkEaMhhJRCBvZiB0aGUgYW'
    '5hbHl6ZWQgZmlsZS5SBmZpbGVJZBI7CghmaWxlbmFtZRgCIAEoCUIfkkEcMhpOYW1lIG9mIHRo'
    'ZSBhbmFseXplZCBmaWxlLlIIZmlsZW5hbWUShQEKDWFuYWx5c2lzX3R5cGUYAyABKAlCYJJBXT'
    'JbVHlwZSBvZiBhbmFseXNpcyBwZXJmb3JtZWQgKGUuZy4sICd0ZXh0X2V4dHJhY3Rpb24nLCAn'
    'aW1hZ2VfcmVjb2duaXRpb24nLCAnZGF0YV9hbmFseXNpcycpLlIMYW5hbHlzaXNUeXBlEkgKD2'
    'FuYWx5c2lzX3Jlc3VsdBgEIAEoCUIfkkEcMhpEZXRhaWxlZCBhbmFseXNpcyByZXN1bHRzLlIO'
    'YW5hbHlzaXNSZXN1bHQScwoIbWV0YWRhdGEYBSADKAsyJC5wYi5GaWxlQW5hbHlzaXNSZXN1bH'
    'QuTWV0YWRhdGFFbnRyeUIxkkEuMixBZGRpdGlvbmFsIG1ldGFkYXRhIGV4dHJhY3RlZCBmcm9t'
    'IHRoZSBmaWxlLlIIbWV0YWRhdGESWwoScHJvY2Vzc2luZ19zdWNjZXNzGAYgASgIQiySQSkyJ1'
    'doZXRoZXIgZmlsZSBwcm9jZXNzaW5nIHdhcyBzdWNjZXNzZnVsLlIRcHJvY2Vzc2luZ1N1Y2Nl'
    'c3MSTQoNZXJyb3JfbWVzc2FnZRgHIAEoCUIokkElMiNFcnJvciBtZXNzYWdlIGlmIHByb2Nlc3'
    'NpbmcgZmFpbGVkLlIMZXJyb3JNZXNzYWdlGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJ'
    'UgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ATo/kkE8CjoqFEZpbGUgQW5hbHlzaXMgUm'
    'VzdWx0MiJBbmFseXNpcyByZXN1bHQgZm9yIGEgc2luZ2xlIGZpbGUu');

@$core.Deprecated('Use indexChatHistoryRequestDescriptor instead')
const IndexChatHistoryRequest$json = {
  '1': 'IndexChatHistoryRequest',
  '7': {},
};

/// Descriptor for `IndexChatHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexChatHistoryRequestDescriptor = $convert.base64Decode(
    'ChdJbmRleENoYXRIaXN0b3J5UmVxdWVzdDp3kkF0CnIqGkluZGV4IENoYXQgSGlzdG9yeSBSZX'
    'F1ZXN0MlRUcmlnZ2VycyB0aGUgaW5kZXhpbmcgcHJvY2VzcyBmb3IgdGhlIGF1dGhlbnRpY2F0'
    'ZWQgdXNlcidzIGxhdGVzdCBjaGF0IGhpc3RvcnkgZmlsZS4=');

@$core.Deprecated('Use indexChatHistoryResponseDescriptor instead')
const IndexChatHistoryResponse$json = {
  '1': 'IndexChatHistoryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '8': {}, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'msg'},
  ],
  '7': {},
};

/// Descriptor for `IndexChatHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexChatHistoryResponseDescriptor = $convert.base64Decode(
    'ChhJbmRleENoYXRIaXN0b3J5UmVzcG9uc2USWQoHc3VjY2VzcxgBIAEoCEI/kkE8MjpJbmRpY2'
    'F0ZXMgaWYgdGhlIGluZGV4aW5nIHRhc2sgd2FzIHN1Y2Nlc3NmdWxseSB0cmlnZ2VyZWQuUgdz'
    'dWNjZXNzElkKA21zZxgCIAEoCUJHkkFEMkJBIHN0YXR1cyBtZXNzYWdlIChlLmcuLCAnSW5kZX'
    'hpbmcgdHJpZ2dlcmVkJyBvciAnRmlsZSBub3QgZm91bmQnKS5SA21zZzplkkFiCmAqG0luZGV4'
    'IENoYXQgSGlzdG9yeSBSZXNwb25zZTJBUmVzcG9uc2UgY29uZmlybWluZyB0aGUgY2hhdCBoaX'
    'N0b3J5IGluZGV4aW5nIHRhc2sgd2FzIHRyaWdnZXJlZC4=');

@$core.Deprecated('Use indexTransactionFileRequestDescriptor instead')
const IndexTransactionFileRequest$json = {
  '1': 'IndexTransactionFileRequest',
  '7': {},
};

/// Descriptor for `IndexTransactionFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexTransactionFileRequestDescriptor = $convert.base64Decode(
    'ChtJbmRleFRyYW5zYWN0aW9uRmlsZVJlcXVlc3Q6epJBdwp1Kh5JbmRleCBUcmFuc2FjdGlvbi'
    'BGaWxlIFJlcXVlc3QyU1RyaWdnZXJzIHRoZSBpbmRleGluZyBwcm9jZXNzIGZvciB0aGUgYXV0'
    'aGVudGljYXRlZCB1c2VyJ3MgbGF0ZXN0IHRyYW5zYWN0aW9uIGZpbGUu');

@$core.Deprecated('Use indexTransactionFileResponseDescriptor instead')
const IndexTransactionFileResponse$json = {
  '1': 'IndexTransactionFileResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '8': {}, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'msg'},
  ],
  '7': {},
};

/// Descriptor for `IndexTransactionFileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexTransactionFileResponseDescriptor = $convert.base64Decode(
    'ChxJbmRleFRyYW5zYWN0aW9uRmlsZVJlc3BvbnNlElkKB3N1Y2Nlc3MYASABKAhCP5JBPDI6SW'
    '5kaWNhdGVzIGlmIHRoZSBpbmRleGluZyB0YXNrIHdhcyBzdWNjZXNzZnVsbHkgdHJpZ2dlcmVk'
    'LlIHc3VjY2VzcxJZCgNtc2cYAiABKAlCR5JBRDJCQSBzdGF0dXMgbWVzc2FnZSAoZS5nLiwgJ0'
    'luZGV4aW5nIHRyaWdnZXJlZCcgb3IgJ0ZpbGUgbm90IGZvdW5kJykuUgNtc2c6bZJBagpoKh9J'
    'bmRleCBUcmFuc2FjdGlvbiBGaWxlIFJlc3BvbnNlMkVSZXNwb25zZSBjb25maXJtaW5nIHRoZS'
    'B0cmFuc2FjdGlvbiBmaWxlIGluZGV4aW5nIHRhc2sgd2FzIHRyaWdnZXJlZC4=');

@$core.Deprecated('Use aIChatHistoryEntryDescriptor instead')
const AIChatHistoryEntry$json = {
  '1': 'AIChatHistoryEntry',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'query'},
    {'1': 'response', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'response'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'timestamp'},
  ],
  '7': {},
};

/// Descriptor for `AIChatHistoryEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aIChatHistoryEntryDescriptor = $convert.base64Decode(
    'ChJBSUNoYXRIaXN0b3J5RW50cnkSLAoFcXVlcnkYASABKAlCFpJBEzIRVGhlIHVzZXIncyBxdW'
    'VyeS5SBXF1ZXJ5EjMKCHJlc3BvbnNlGAIgASgJQheSQRQyElRoZSBBSSdzIHJlc3BvbnNlLlII'
    'cmVzcG9uc2USUQoJdGltZXN0YW1wGAMgASgJQjOSQTAyLlRpbWVzdGFtcCBvZiB0aGUgaW50ZX'
    'JhY3Rpb24gKFJGQzMzMzkgZm9ybWF0KS5SCXRpbWVzdGFtcDpUkkFRCk8qFUFJIENoYXQgSGlz'
    'dG9yeSBFbnRyeTI2QSBzaW5nbGUgcXVlcnktcmVzcG9uc2UgcGFpciBmcm9tIHRoZSBBSSBjaG'
    'F0IGhpc3Rvcnku');

@$core.Deprecated('Use getAIChatHistoryRequestDescriptor instead')
const GetAIChatHistoryRequest$json = {
  '1': 'GetAIChatHistoryRequest',
  '7': {},
};

/// Descriptor for `GetAIChatHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIChatHistoryRequestDescriptor = $convert.base64Decode(
    'ChdHZXRBSUNoYXRIaXN0b3J5UmVxdWVzdDpkkkFhCl8qG0dldCBBSSBDaGF0IEhpc3RvcnkgUm'
    'VxdWVzdDJAUmVxdWVzdCB0byBmZXRjaCB0aGUgQUkgY2hhdCBoaXN0b3J5IGZvciB0aGUgYXV0'
    'aGVudGljYXRlZCB1c2VyLg==');

@$core.Deprecated('Use getAIChatHistoryResponseDescriptor instead')
const GetAIChatHistoryResponse$json = {
  '1': 'GetAIChatHistoryResponse',
  '2': [
    {'1': 'history', '3': 1, '4': 3, '5': 11, '6': '.pb.AIChatHistoryEntry', '8': {}, '10': 'history'},
  ],
  '7': {},
};

/// Descriptor for `GetAIChatHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIChatHistoryResponseDescriptor = $convert.base64Decode(
    'ChhHZXRBSUNoYXRIaXN0b3J5UmVzcG9uc2UScAoHaGlzdG9yeRgBIAMoCzIWLnBiLkFJQ2hhdE'
    'hpc3RvcnlFbnRyeUI+kkE7MjlMaXN0IG9mIEFJIGNoYXQgaGlzdG9yeSBlbnRyaWVzLCBvcmRl'
    'cmVkIGNocm9ub2xvZ2ljYWxseS5SB2hpc3Rvcnk6VJJBUQpPKhxHZXQgQUkgQ2hhdCBIaXN0b3'
    'J5IFJlc3BvbnNlMi9BIGxpc3Qgb2YgQUkgY2hhdCBoaXN0b3J5IGVudHJpZXMgZm9yIHRoZSB1'
    'c2VyLg==');

@$core.Deprecated('Use actionButtonDescriptor instead')
const ActionButton$json = {
  '1': 'ActionButton',
  '2': [
    {'1': 'label', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'label'},
    {'1': 'action_type', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'actionType'},
    {'1': 'payload', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'payload'},
    {'1': 'icon', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'icon'},
  ],
};

/// Descriptor for `ActionButton`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionButtonDescriptor = $convert.base64Decode(
    'CgxBY3Rpb25CdXR0b24SNwoFbGFiZWwYASABKAlCIZJBHjIcRGlzcGxheSB0ZXh0IGZvciB0aG'
    'UgYnV0dG9uLlIFbGFiZWwSVQoLYWN0aW9uX3R5cGUYAiABKAlCNJJBMTIvVHlwZSBvZiBhY3Rp'
    'b246IG5hdmlnYXRlLCBjb25maXJtLCBxdWlja19yZXBseS5SCmFjdGlvblR5cGUSNwoHcGF5bG'
    '9hZBgDIAEoCUIdkkEaMhhBY3Rpb24gcGF5bG9hZCBvciByb3V0ZS5SB3BheWxvYWQSLAoEaWNv'
    'bhgEIAEoCUIYkkEVMhNPcHRpb25hbCBpY29uIG5hbWUuUgRpY29u');

@$core.Deprecated('Use confirmationDataDescriptor instead')
const ConfirmationData$json = {
  '1': 'ConfirmationData',
  '2': [
    {'1': 'action_type', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'actionType'},
    {'1': 'amount', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'currency'},
    {'1': 'recipient_name', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'recipientName'},
    {'1': 'recipient_id', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'recipientId'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '8': {}, '10': 'description'},
    {'1': 'extra', '3': 7, '4': 3, '5': 11, '6': '.pb.ConfirmationData.ExtraEntry', '8': {}, '10': 'extra'},
  ],
  '3': [ConfirmationData_ExtraEntry$json],
};

@$core.Deprecated('Use confirmationDataDescriptor instead')
const ConfirmationData_ExtraEntry$json = {
  '1': 'ExtraEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ConfirmationData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmationDataDescriptor = $convert.base64Decode(
    'ChBDb25maXJtYXRpb25EYXRhElkKC2FjdGlvbl90eXBlGAEgASgJQjiSQTUyM1R5cGUgb2YgZm'
    'luYW5jaWFsIGFjdGlvbiAodHJhbnNmZXIsIHRhZ19wYXksIGV0Yy4pLlIKYWN0aW9uVHlwZRI/'
    'CgZhbW91bnQYAiABKAlCJ5JBJDIiVHJhbnNhY3Rpb24gYW1vdW50IGluIG1pbm9yIHVuaXRzLl'
    'IGYW1vdW50EkAKCGN1cnJlbmN5GAMgASgJQiSSQSEyH0N1cnJlbmN5IGNvZGUgKE5HTiwgVVNE'
    'LCBldGMuKS5SCGN1cnJlbmN5EkMKDnJlY2lwaWVudF9uYW1lGAQgASgJQhySQRkyF1JlY2lwaW'
    'VudCBkaXNwbGF5IG5hbWUuUg1yZWNpcGllbnROYW1lEkUKDHJlY2lwaWVudF9pZBgFIAEoCUIi'
    'kkEfMh1SZWNpcGllbnQgdXNlciBvciBhY2NvdW50IElELlILcmVjaXBpZW50SWQSPwoLZGVzY3'
    'JpcHRpb24YBiABKAlCHZJBGjIYVHJhbnNhY3Rpb24gZGVzY3JpcHRpb24uUgtkZXNjcmlwdGlv'
    'bhJrCgVleHRyYRgHIAMoCzIfLnBiLkNvbmZpcm1hdGlvbkRhdGEuRXh0cmFFbnRyeUI0kkExMi'
    '9BZGRpdGlvbmFsIGtleS12YWx1ZSBkYXRhIGZvciB0aGUgY29uZmlybWF0aW9uLlIFZXh0cmEa'
    'OAoKRXh0cmFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6Aj'
    'gB');

