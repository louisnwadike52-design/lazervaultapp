///
//  Generated code. Do not modify.
//  source: ai_chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use processChatRequestDescriptor instead')
const ProcessChatRequest$json = const {
  '1': 'ProcessChatRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'query'},
    const {'1': 'tx_history', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'txHistory'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 13, '8': const {}, '10': 'userId'},
    const {'1': 'uploaded_file', '3': 4, '4': 1, '5': 11, '6': '.pb.ChatFile', '8': const {}, '9': 0, '10': 'uploadedFile', '17': true},
    const {'1': 'session_id', '3': 5, '4': 1, '5': 9, '8': const {}, '10': 'sessionId'},
    const {'1': 'source_context', '3': 6, '4': 1, '5': 9, '8': const {}, '10': 'sourceContext'},
    const {'1': 'language', '3': 7, '4': 1, '5': 9, '8': const {}, '10': 'language'},
    const {'1': 'account_id', '3': 8, '4': 1, '5': 9, '8': const {}, '10': 'accountId'},
    const {'1': 'user_country', '3': 9, '4': 1, '5': 9, '8': const {}, '10': 'userCountry'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '8': const {}, '10': 'currency'},
  ],
  '7': const {},
  '8': const [
    const {'1': '_uploaded_file'},
  ],
};

/// Descriptor for `ProcessChatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processChatRequestDescriptor = $convert.base64Decode('ChJQcm9jZXNzQ2hhdFJlcXVlc3QSPAoFcXVlcnkYASABKAlCJpJBIzIhVGhlIHVzZXIncyBpbnB1dC9xdWVyeSB0byB0aGUgQUkuUgVxdWVyeRJTCgp0eF9oaXN0b3J5GAIgASgJQjSSQTEyL0pTT04gc3RyaW5nIGNvbnRhaW5pbmcgdGhlIGxhc3QgNSB0cmFuc2FjdGlvbnMuUgl0eEhpc3RvcnkSRAoHdXNlcl9pZBgDIAEoDUIrkkEoMiZUaGUgSUQgb2YgdGhlIHVzZXIgbWFraW5nIHRoZSByZXF1ZXN0LlIGdXNlcklkEnIKDXVwbG9hZGVkX2ZpbGUYBCABKAsyDC5wYi5DaGF0RmlsZUI6kkE3MjVPcHRpb25hbCBmaWxlIHVwbG9hZGVkIGJ5IHRoZSB1c2VyIGZvciBBSSBwcm9jZXNzaW5nLkgAUgx1cGxvYWRlZEZpbGWIAQESUwoKc2Vzc2lvbl9pZBgFIAEoCUI0kkExMi9TZXNzaW9uIGlkZW50aWZpZXIgZm9yIGNvbnZlcnNhdGlvbiBjb250aW51aXR5LlIJc2Vzc2lvbklkEmsKDnNvdXJjZV9jb250ZXh0GAYgASgJQkSSQUEyP1doZXJlIHRoZSBjaGF0IHdhcyBpbml0aWF0ZWQgZnJvbSAoZS5nLiwgZGFzaGJvYXJkLCB0cmFuc2ZlcnMpLlINc291cmNlQ29udGV4dBJPCghsYW5ndWFnZRgHIAEoCUIzkkEwMi5Vc2VyJ3MgcHJlZmVycmVkIGxhbmd1YWdlIGNvZGUgKGUuZy4sIGVuLCBmcikuUghsYW5ndWFnZRI9CgphY2NvdW50X2lkGAggASgJQh6SQRsyGVVzZXIncyBhY3RpdmUgYWNjb3VudCBJRC5SCWFjY291bnRJZBJLCgx1c2VyX2NvdW50cnkYCSABKAlCKJJBJTIjVXNlcidzIGNvdW50cnkgY29kZSAoZS5nLiwgTkcsIEdIKS5SC3VzZXJDb3VudHJ5EkcKCGN1cnJlbmN5GAogASgJQiuSQSgyJlVzZXIncyBjdXJyZW5jeSBjb2RlIChlLmcuLCBOR04sIEdIUykuUghjdXJyZW5jeTp8kkF5CncqF0FJIFByb2Nlc3MgQ2hhdCBSZXF1ZXN0MkpQYXlsb2FkIGNvbnRhaW5pbmcgdGhlIHVzZXIncyBxdWVyeSBmb3IgdGhlIEFJIGNoYXRib3Qgd2l0aCBvcHRpb25hbCBmaWxlLtIBBXF1ZXJ50gEHdXNlcl9pZEIQCg5fdXBsb2FkZWRfZmlsZQ==');
@$core.Deprecated('Use processChatResponseDescriptor instead')
const ProcessChatResponse$json = const {
  '1': 'ProcessChatResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '8': const {}, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'msg'},
    const {'1': 'query', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'query'},
    const {'1': 'response', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'response'},
    const {'1': 'generated_files', '3': 5, '4': 3, '5': 11, '6': '.pb.ChatFile', '8': const {}, '10': 'generatedFiles'},
    const {'1': 'file_analysis', '3': 6, '4': 1, '5': 11, '6': '.pb.FileAnalysis', '8': const {}, '10': 'fileAnalysis'},
    const {'1': 'intent', '3': 7, '4': 1, '5': 9, '8': const {}, '10': 'intent'},
    const {'1': 'entities', '3': 8, '4': 3, '5': 11, '6': '.pb.ProcessChatResponse.EntitiesEntry', '8': const {}, '10': 'entities'},
    const {'1': 'requires_confirmation', '3': 9, '4': 1, '5': 8, '8': const {}, '10': 'requiresConfirmation'},
    const {'1': 'action_buttons', '3': 10, '4': 3, '5': 11, '6': '.pb.ActionButton', '8': const {}, '10': 'actionButtons'},
    const {'1': 'session_id', '3': 11, '4': 1, '5': 9, '8': const {}, '10': 'sessionId'},
    const {'1': 'confirmation_data', '3': 12, '4': 1, '5': 11, '6': '.pb.ConfirmationData', '8': const {}, '10': 'confirmationData'},
    const {'1': 'conversation_state', '3': 13, '4': 1, '5': 9, '8': const {}, '10': 'conversationState'},
  ],
  '3': const [ProcessChatResponse_EntitiesEntry$json],
  '7': const {},
};

@$core.Deprecated('Use processChatResponseDescriptor instead')
const ProcessChatResponse_EntitiesEntry$json = const {
  '1': 'EntitiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ProcessChatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processChatResponseDescriptor = $convert.base64Decode('ChNQcm9jZXNzQ2hhdFJlc3BvbnNlElEKB3N1Y2Nlc3MYASABKAhCN5JBNDIySW5kaWNhdGVzIGlmIHRoZSBxdWVyeSB3YXMgc3VjY2Vzc2Z1bGx5IHByb2Nlc3NlZC5SB3N1Y2Nlc3MSQgoDbXNnGAIgASgJQjCSQS0yK0Egc3RhdHVzIG1lc3NhZ2UgcmVsYXRlZCB0byB0aGUgcHJvY2Vzc2luZy5SA21zZxI/CgVxdWVyeRgDIAEoCUIpkkEmMiRUaGUgb3JpZ2luYWwgcXVlcnkgc2VudCBieSB0aGUgdXNlci5SBXF1ZXJ5EjMKCHJlc3BvbnNlGAQgASgJQheSQRQyElRoZSBBSSdzIHJlc3BvbnNlLlIIcmVzcG9uc2USbwoPZ2VuZXJhdGVkX2ZpbGVzGAUgAygLMgwucGIuQ2hhdEZpbGVCOJJBNTIzRmlsZXMgZ2VuZXJhdGVkIGJ5IHRoZSBBSSBpbiByZXNwb25zZSB0byB0aGUgcXVlcnkuUg5nZW5lcmF0ZWRGaWxlcxJfCg1maWxlX2FuYWx5c2lzGAYgASgLMhAucGIuRmlsZUFuYWx5c2lzQiiSQSUyI0FuYWx5c2lzIHJlc3VsdHMgb2YgdXBsb2FkZWQgZmlsZXMuUgxmaWxlQW5hbHlzaXMSRQoGaW50ZW50GAcgASgJQi2SQSoyKENsYXNzaWZpZWQgaW50ZW50IG9mIHRoZSB1c2VyJ3MgbWVzc2FnZS5SBmludGVudBJ1CghlbnRpdGllcxgIIAMoCzIlLnBiLlByb2Nlc3NDaGF0UmVzcG9uc2UuRW50aXRpZXNFbnRyeUIykkEvMi1FeHRyYWN0ZWQgZW50aXRpZXMgKGFtb3VudCwgcmVjaXBpZW50LCBldGMuKS5SCGVudGl0aWVzEmIKFXJlcXVpcmVzX2NvbmZpcm1hdGlvbhgJIAEoCEItkkEqMihXaGV0aGVyIHRoZSB1c2VyIG11c3QgY29uZmlybSBhbiBhY3Rpb24uUhRyZXF1aXJlc0NvbmZpcm1hdGlvbhJkCg5hY3Rpb25fYnV0dG9ucxgKIAMoCzIQLnBiLkFjdGlvbkJ1dHRvbkIrkkEoMiZTdWdnZXN0ZWQgYWN0aW9uIGJ1dHRvbnMgZm9yIHRoZSB1c2VyLlINYWN0aW9uQnV0dG9ucxJLCgpzZXNzaW9uX2lkGAsgASgJQiySQSkyJ1Nlc3Npb24gSUQgZm9yIGNvbnZlcnNhdGlvbiBjb250aW51aXR5LlIJc2Vzc2lvbklkEnUKEWNvbmZpcm1hdGlvbl9kYXRhGAwgASgLMhQucGIuQ29uZmlybWF0aW9uRGF0YUIykkEvMi1TdHJ1Y3R1cmVkIGRhdGEgZm9yIHRyYW5zYWN0aW9uIGNvbmZpcm1hdGlvbi5SEGNvbmZpcm1hdGlvbkRhdGEScwoSY29udmVyc2F0aW9uX3N0YXRlGA0gASgJQkSSQUEyP0N1cnJlbnQgY29udmVyc2F0aW9uIHN0YXRlIChJRExFLCBBV0FJVElOR19DT05GSVJNQVRJT04sIGV0Yy4pLlIRY29udmVyc2F0aW9uU3RhdGUaOwoNRW50aXRpZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBOlaSQVMKUSoYQUkgUHJvY2VzcyBDaGF0IFJlc3BvbnNlMjVDb250YWlucyB0aGUgQUkgY2hhdGJvdCdzIHJlc3BvbnNlIGFsb25nIHdpdGggc3RhdHVzLg==');
@$core.Deprecated('Use chatFileDescriptor instead')
const ChatFile$json = const {
  '1': 'ChatFile',
  '2': const [
    const {'1': 'filename', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'filename'},
    const {'1': 'content_type', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'contentType'},
    const {'1': 'file_content', '3': 3, '4': 1, '5': 12, '8': const {}, '10': 'fileContent'},
    const {'1': 'file_id', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'fileId'},
    const {'1': 'file_url', '3': 5, '4': 1, '5': 9, '8': const {}, '10': 'fileUrl'},
    const {'1': 'file_size', '3': 6, '4': 1, '5': 3, '8': const {}, '10': 'fileSize'},
    const {'1': 'upload_timestamp', '3': 7, '4': 1, '5': 9, '8': const {}, '10': 'uploadTimestamp'},
  ],
  '7': const {},
};

/// Descriptor for `ChatFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatFileDescriptor = $convert.base64Decode('CghDaGF0RmlsZRJKCghmaWxlbmFtZRgBIAEoCUIukkErMilPcmlnaW5hbCBmaWxlbmFtZSAocmVxdWlyZWQgZm9yIHVwbG9hZHMpLlIIZmlsZW5hbWUSVQoMY29udGVudF90eXBlGAIgASgJQjKSQS8yLU1JTUUgdHlwZSBvZiB0aGUgZmlsZSAocmVxdWlyZWQgZm9yIHVwbG9hZHMpLlILY29udGVudFR5cGUSWgoMZmlsZV9jb250ZW50GAMgASgMQjeSQTQyMkJpbmFyeSBjb250ZW50IG9mIHRoZSBmaWxlIChyZXF1aXJlZCBmb3IgdXBsb2FkcykuUgtmaWxlQ29udGVudBJNCgdmaWxlX2lkGAQgASgJQjSSQTEyL1VuaXF1ZSBpZGVudGlmaWVyIGZvciB0aGUgZmlsZSAoc2V0IGJ5IHNlcnZlcikuUgZmaWxlSWQSZQoIZmlsZV91cmwYBSABKAlCSpJBRzJFVVJMIHRvIGFjY2VzcyB0aGUgZmlsZSAoc2V0IGJ5IHNlcnZlciBmb3IgZG93bmxvYWRzL2dlbmVyYXRlZCBmaWxlcykuUgdmaWxlVXJsEkwKCWZpbGVfc2l6ZRgGIAEoA0IvkkEsMipTaXplIG9mIHRoZSBmaWxlIGluIGJ5dGVzIChzZXQgYnkgc2VydmVyKS5SCGZpbGVTaXplEm0KEHVwbG9hZF90aW1lc3RhbXAYByABKAlCQpJBPzI9V2hlbiB0aGUgZmlsZSB3YXMgdXBsb2FkZWQgaW4gUkZDMzMzOSBmb3JtYXQgKHNldCBieSBzZXJ2ZXIpLlIPdXBsb2FkVGltZXN0YW1wOlGSQU4KTCoJQ2hhdCBGaWxlMj9SZXByZXNlbnRzIGEgZmlsZSBpbiB0aGUgY2hhdCBjb250ZXh0IChmb3IgdXBsb2FkIG9yIGRvd25sb2FkKS4=');
@$core.Deprecated('Use fileAnalysisDescriptor instead')
const FileAnalysis$json = const {
  '1': 'FileAnalysis',
  '2': const [
    const {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.pb.FileAnalysisResult', '8': const {}, '10': 'results'},
    const {'1': 'summary', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'summary'},
  ],
  '7': const {},
};

/// Descriptor for `FileAnalysis`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileAnalysisDescriptor = $convert.base64Decode('CgxGaWxlQW5hbHlzaXMSYAoHcmVzdWx0cxgBIAMoCzIWLnBiLkZpbGVBbmFseXNpc1Jlc3VsdEIukkErMilBbmFseXNpcyByZXN1bHRzIGZvciBlYWNoIHByb2Nlc3NlZCBmaWxlLlIHcmVzdWx0cxJACgdzdW1tYXJ5GAIgASgJQiaSQSMyIU92ZXJhbGwgc3VtbWFyeSBvZiBmaWxlIGFuYWx5c2lzLlIHc3VtbWFyeTpMkkFJCkcqDUZpbGUgQW5hbHlzaXMyNkFuYWx5c2lzIHJlc3VsdHMgZnJvbSBBSSBwcm9jZXNzaW5nIG9mIHVwbG9hZGVkIGZpbGVzLg==');
@$core.Deprecated('Use fileAnalysisResultDescriptor instead')
const FileAnalysisResult$json = const {
  '1': 'FileAnalysisResult',
  '2': const [
    const {'1': 'file_id', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'fileId'},
    const {'1': 'filename', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'filename'},
    const {'1': 'analysis_type', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'analysisType'},
    const {'1': 'analysis_result', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'analysisResult'},
    const {'1': 'metadata', '3': 5, '4': 3, '5': 11, '6': '.pb.FileAnalysisResult.MetadataEntry', '8': const {}, '10': 'metadata'},
    const {'1': 'processing_success', '3': 6, '4': 1, '5': 8, '8': const {}, '10': 'processingSuccess'},
    const {'1': 'error_message', '3': 7, '4': 1, '5': 9, '8': const {}, '10': 'errorMessage'},
  ],
  '3': const [FileAnalysisResult_MetadataEntry$json],
  '7': const {},
};

@$core.Deprecated('Use fileAnalysisResultDescriptor instead')
const FileAnalysisResult_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `FileAnalysisResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileAnalysisResultDescriptor = $convert.base64Decode('ChJGaWxlQW5hbHlzaXNSZXN1bHQSNgoHZmlsZV9pZBgBIAEoCUIdkkEaMhhJRCBvZiB0aGUgYW5hbHl6ZWQgZmlsZS5SBmZpbGVJZBI7CghmaWxlbmFtZRgCIAEoCUIfkkEcMhpOYW1lIG9mIHRoZSBhbmFseXplZCBmaWxlLlIIZmlsZW5hbWUShQEKDWFuYWx5c2lzX3R5cGUYAyABKAlCYJJBXTJbVHlwZSBvZiBhbmFseXNpcyBwZXJmb3JtZWQgKGUuZy4sICd0ZXh0X2V4dHJhY3Rpb24nLCAnaW1hZ2VfcmVjb2duaXRpb24nLCAnZGF0YV9hbmFseXNpcycpLlIMYW5hbHlzaXNUeXBlEkgKD2FuYWx5c2lzX3Jlc3VsdBgEIAEoCUIfkkEcMhpEZXRhaWxlZCBhbmFseXNpcyByZXN1bHRzLlIOYW5hbHlzaXNSZXN1bHQScwoIbWV0YWRhdGEYBSADKAsyJC5wYi5GaWxlQW5hbHlzaXNSZXN1bHQuTWV0YWRhdGFFbnRyeUIxkkEuMixBZGRpdGlvbmFsIG1ldGFkYXRhIGV4dHJhY3RlZCBmcm9tIHRoZSBmaWxlLlIIbWV0YWRhdGESWwoScHJvY2Vzc2luZ19zdWNjZXNzGAYgASgIQiySQSkyJ1doZXRoZXIgZmlsZSBwcm9jZXNzaW5nIHdhcyBzdWNjZXNzZnVsLlIRcHJvY2Vzc2luZ1N1Y2Nlc3MSTQoNZXJyb3JfbWVzc2FnZRgHIAEoCUIokkElMiNFcnJvciBtZXNzYWdlIGlmIHByb2Nlc3NpbmcgZmFpbGVkLlIMZXJyb3JNZXNzYWdlGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ATo/kkE8CjoqFEZpbGUgQW5hbHlzaXMgUmVzdWx0MiJBbmFseXNpcyByZXN1bHQgZm9yIGEgc2luZ2xlIGZpbGUu');
@$core.Deprecated('Use indexChatHistoryRequestDescriptor instead')
const IndexChatHistoryRequest$json = const {
  '1': 'IndexChatHistoryRequest',
  '7': const {},
};

/// Descriptor for `IndexChatHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexChatHistoryRequestDescriptor = $convert.base64Decode('ChdJbmRleENoYXRIaXN0b3J5UmVxdWVzdDp3kkF0CnIqGkluZGV4IENoYXQgSGlzdG9yeSBSZXF1ZXN0MlRUcmlnZ2VycyB0aGUgaW5kZXhpbmcgcHJvY2VzcyBmb3IgdGhlIGF1dGhlbnRpY2F0ZWQgdXNlcidzIGxhdGVzdCBjaGF0IGhpc3RvcnkgZmlsZS4=');
@$core.Deprecated('Use indexChatHistoryResponseDescriptor instead')
const IndexChatHistoryResponse$json = const {
  '1': 'IndexChatHistoryResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '8': const {}, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'msg'},
  ],
  '7': const {},
};

/// Descriptor for `IndexChatHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexChatHistoryResponseDescriptor = $convert.base64Decode('ChhJbmRleENoYXRIaXN0b3J5UmVzcG9uc2USWQoHc3VjY2VzcxgBIAEoCEI/kkE8MjpJbmRpY2F0ZXMgaWYgdGhlIGluZGV4aW5nIHRhc2sgd2FzIHN1Y2Nlc3NmdWxseSB0cmlnZ2VyZWQuUgdzdWNjZXNzElkKA21zZxgCIAEoCUJHkkFEMkJBIHN0YXR1cyBtZXNzYWdlIChlLmcuLCAnSW5kZXhpbmcgdHJpZ2dlcmVkJyBvciAnRmlsZSBub3QgZm91bmQnKS5SA21zZzplkkFiCmAqG0luZGV4IENoYXQgSGlzdG9yeSBSZXNwb25zZTJBUmVzcG9uc2UgY29uZmlybWluZyB0aGUgY2hhdCBoaXN0b3J5IGluZGV4aW5nIHRhc2sgd2FzIHRyaWdnZXJlZC4=');
@$core.Deprecated('Use indexTransactionFileRequestDescriptor instead')
const IndexTransactionFileRequest$json = const {
  '1': 'IndexTransactionFileRequest',
  '7': const {},
};

/// Descriptor for `IndexTransactionFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexTransactionFileRequestDescriptor = $convert.base64Decode('ChtJbmRleFRyYW5zYWN0aW9uRmlsZVJlcXVlc3Q6epJBdwp1Kh5JbmRleCBUcmFuc2FjdGlvbiBGaWxlIFJlcXVlc3QyU1RyaWdnZXJzIHRoZSBpbmRleGluZyBwcm9jZXNzIGZvciB0aGUgYXV0aGVudGljYXRlZCB1c2VyJ3MgbGF0ZXN0IHRyYW5zYWN0aW9uIGZpbGUu');
@$core.Deprecated('Use indexTransactionFileResponseDescriptor instead')
const IndexTransactionFileResponse$json = const {
  '1': 'IndexTransactionFileResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '8': const {}, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'msg'},
  ],
  '7': const {},
};

/// Descriptor for `IndexTransactionFileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexTransactionFileResponseDescriptor = $convert.base64Decode('ChxJbmRleFRyYW5zYWN0aW9uRmlsZVJlc3BvbnNlElkKB3N1Y2Nlc3MYASABKAhCP5JBPDI6SW5kaWNhdGVzIGlmIHRoZSBpbmRleGluZyB0YXNrIHdhcyBzdWNjZXNzZnVsbHkgdHJpZ2dlcmVkLlIHc3VjY2VzcxJZCgNtc2cYAiABKAlCR5JBRDJCQSBzdGF0dXMgbWVzc2FnZSAoZS5nLiwgJ0luZGV4aW5nIHRyaWdnZXJlZCcgb3IgJ0ZpbGUgbm90IGZvdW5kJykuUgNtc2c6bZJBagpoKh9JbmRleCBUcmFuc2FjdGlvbiBGaWxlIFJlc3BvbnNlMkVSZXNwb25zZSBjb25maXJtaW5nIHRoZSB0cmFuc2FjdGlvbiBmaWxlIGluZGV4aW5nIHRhc2sgd2FzIHRyaWdnZXJlZC4=');
@$core.Deprecated('Use aIChatHistoryEntryDescriptor instead')
const AIChatHistoryEntry$json = const {
  '1': 'AIChatHistoryEntry',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'query'},
    const {'1': 'response', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'response'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'timestamp'},
  ],
  '7': const {},
};

/// Descriptor for `AIChatHistoryEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aIChatHistoryEntryDescriptor = $convert.base64Decode('ChJBSUNoYXRIaXN0b3J5RW50cnkSLAoFcXVlcnkYASABKAlCFpJBEzIRVGhlIHVzZXIncyBxdWVyeS5SBXF1ZXJ5EjMKCHJlc3BvbnNlGAIgASgJQheSQRQyElRoZSBBSSdzIHJlc3BvbnNlLlIIcmVzcG9uc2USUQoJdGltZXN0YW1wGAMgASgJQjOSQTAyLlRpbWVzdGFtcCBvZiB0aGUgaW50ZXJhY3Rpb24gKFJGQzMzMzkgZm9ybWF0KS5SCXRpbWVzdGFtcDpUkkFRCk8qFUFJIENoYXQgSGlzdG9yeSBFbnRyeTI2QSBzaW5nbGUgcXVlcnktcmVzcG9uc2UgcGFpciBmcm9tIHRoZSBBSSBjaGF0IGhpc3Rvcnku');
@$core.Deprecated('Use getAIChatHistoryRequestDescriptor instead')
const GetAIChatHistoryRequest$json = const {
  '1': 'GetAIChatHistoryRequest',
  '7': const {},
};

/// Descriptor for `GetAIChatHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIChatHistoryRequestDescriptor = $convert.base64Decode('ChdHZXRBSUNoYXRIaXN0b3J5UmVxdWVzdDpkkkFhCl8qG0dldCBBSSBDaGF0IEhpc3RvcnkgUmVxdWVzdDJAUmVxdWVzdCB0byBmZXRjaCB0aGUgQUkgY2hhdCBoaXN0b3J5IGZvciB0aGUgYXV0aGVudGljYXRlZCB1c2VyLg==');
@$core.Deprecated('Use getAIChatHistoryResponseDescriptor instead')
const GetAIChatHistoryResponse$json = const {
  '1': 'GetAIChatHistoryResponse',
  '2': const [
    const {'1': 'history', '3': 1, '4': 3, '5': 11, '6': '.pb.AIChatHistoryEntry', '8': const {}, '10': 'history'},
  ],
  '7': const {},
};

/// Descriptor for `GetAIChatHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAIChatHistoryResponseDescriptor = $convert.base64Decode('ChhHZXRBSUNoYXRIaXN0b3J5UmVzcG9uc2UScAoHaGlzdG9yeRgBIAMoCzIWLnBiLkFJQ2hhdEhpc3RvcnlFbnRyeUI+kkE7MjlMaXN0IG9mIEFJIGNoYXQgaGlzdG9yeSBlbnRyaWVzLCBvcmRlcmVkIGNocm9ub2xvZ2ljYWxseS5SB2hpc3Rvcnk6VJJBUQpPKhxHZXQgQUkgQ2hhdCBIaXN0b3J5IFJlc3BvbnNlMi9BIGxpc3Qgb2YgQUkgY2hhdCBoaXN0b3J5IGVudHJpZXMgZm9yIHRoZSB1c2VyLg==');
@$core.Deprecated('Use actionButtonDescriptor instead')
const ActionButton$json = const {
  '1': 'ActionButton',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'label'},
    const {'1': 'action_type', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'actionType'},
    const {'1': 'payload', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'payload'},
    const {'1': 'icon', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'icon'},
  ],
};

/// Descriptor for `ActionButton`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionButtonDescriptor = $convert.base64Decode('CgxBY3Rpb25CdXR0b24SNwoFbGFiZWwYASABKAlCIZJBHjIcRGlzcGxheSB0ZXh0IGZvciB0aGUgYnV0dG9uLlIFbGFiZWwSVQoLYWN0aW9uX3R5cGUYAiABKAlCNJJBMTIvVHlwZSBvZiBhY3Rpb246IG5hdmlnYXRlLCBjb25maXJtLCBxdWlja19yZXBseS5SCmFjdGlvblR5cGUSNwoHcGF5bG9hZBgDIAEoCUIdkkEaMhhBY3Rpb24gcGF5bG9hZCBvciByb3V0ZS5SB3BheWxvYWQSLAoEaWNvbhgEIAEoCUIYkkEVMhNPcHRpb25hbCBpY29uIG5hbWUuUgRpY29u');
@$core.Deprecated('Use confirmationDataDescriptor instead')
const ConfirmationData$json = const {
  '1': 'ConfirmationData',
  '2': const [
    const {'1': 'action_type', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'actionType'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'currency'},
    const {'1': 'recipient_name', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'recipientName'},
    const {'1': 'recipient_id', '3': 5, '4': 1, '5': 9, '8': const {}, '10': 'recipientId'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '8': const {}, '10': 'description'},
    const {'1': 'extra', '3': 7, '4': 3, '5': 11, '6': '.pb.ConfirmationData.ExtraEntry', '8': const {}, '10': 'extra'},
  ],
  '3': const [ConfirmationData_ExtraEntry$json],
};

@$core.Deprecated('Use confirmationDataDescriptor instead')
const ConfirmationData_ExtraEntry$json = const {
  '1': 'ExtraEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ConfirmationData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmationDataDescriptor = $convert.base64Decode('ChBDb25maXJtYXRpb25EYXRhElkKC2FjdGlvbl90eXBlGAEgASgJQjiSQTUyM1R5cGUgb2YgZmluYW5jaWFsIGFjdGlvbiAodHJhbnNmZXIsIHRhZ19wYXksIGV0Yy4pLlIKYWN0aW9uVHlwZRI/CgZhbW91bnQYAiABKAlCJ5JBJDIiVHJhbnNhY3Rpb24gYW1vdW50IGluIG1pbm9yIHVuaXRzLlIGYW1vdW50EkAKCGN1cnJlbmN5GAMgASgJQiSSQSEyH0N1cnJlbmN5IGNvZGUgKE5HTiwgVVNELCBldGMuKS5SCGN1cnJlbmN5EkMKDnJlY2lwaWVudF9uYW1lGAQgASgJQhySQRkyF1JlY2lwaWVudCBkaXNwbGF5IG5hbWUuUg1yZWNpcGllbnROYW1lEkUKDHJlY2lwaWVudF9pZBgFIAEoCUIikkEfMh1SZWNpcGllbnQgdXNlciBvciBhY2NvdW50IElELlILcmVjaXBpZW50SWQSPwoLZGVzY3JpcHRpb24YBiABKAlCHZJBGjIYVHJhbnNhY3Rpb24gZGVzY3JpcHRpb24uUgtkZXNjcmlwdGlvbhJrCgVleHRyYRgHIAMoCzIfLnBiLkNvbmZpcm1hdGlvbkRhdGEuRXh0cmFFbnRyeUI0kkExMi9BZGRpdGlvbmFsIGtleS12YWx1ZSBkYXRhIGZvciB0aGUgY29uZmlybWF0aW9uLlIFZXh0cmEaOAoKRXh0cmFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
