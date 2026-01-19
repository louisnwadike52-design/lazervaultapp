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
  ],
  '7': const {},
  '8': const [
    const {'1': '_uploaded_file'},
  ],
};

/// Descriptor for `ProcessChatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processChatRequestDescriptor = $convert.base64Decode('ChJQcm9jZXNzQ2hhdFJlcXVlc3QSPAoFcXVlcnkYASABKAlCJpJBIzIhVGhlIHVzZXIncyBpbnB1dC9xdWVyeSB0byB0aGUgQUkuUgVxdWVyeRJTCgp0eF9oaXN0b3J5GAIgASgJQjSSQTEyL0pTT04gc3RyaW5nIGNvbnRhaW5pbmcgdGhlIGxhc3QgNSB0cmFuc2FjdGlvbnMuUgl0eEhpc3RvcnkSRAoHdXNlcl9pZBgDIAEoDUIrkkEoMiZUaGUgSUQgb2YgdGhlIHVzZXIgbWFraW5nIHRoZSByZXF1ZXN0LlIGdXNlcklkEnIKDXVwbG9hZGVkX2ZpbGUYBCABKAsyDC5wYi5DaGF0RmlsZUI6kkE3MjVPcHRpb25hbCBmaWxlIHVwbG9hZGVkIGJ5IHRoZSB1c2VyIGZvciBBSSBwcm9jZXNzaW5nLkgAUgx1cGxvYWRlZEZpbGWIAQE6fJJBeQp3KhdBSSBQcm9jZXNzIENoYXQgUmVxdWVzdDJKUGF5bG9hZCBjb250YWluaW5nIHRoZSB1c2VyJ3MgcXVlcnkgZm9yIHRoZSBBSSBjaGF0Ym90IHdpdGggb3B0aW9uYWwgZmlsZS7SAQVxdWVyedIBB3VzZXJfaWRCEAoOX3VwbG9hZGVkX2ZpbGU=');
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
  ],
  '7': const {},
};

/// Descriptor for `ProcessChatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processChatResponseDescriptor = $convert.base64Decode('ChNQcm9jZXNzQ2hhdFJlc3BvbnNlElEKB3N1Y2Nlc3MYASABKAhCN5JBNDIySW5kaWNhdGVzIGlmIHRoZSBxdWVyeSB3YXMgc3VjY2Vzc2Z1bGx5IHByb2Nlc3NlZC5SB3N1Y2Nlc3MSQgoDbXNnGAIgASgJQjCSQS0yK0Egc3RhdHVzIG1lc3NhZ2UgcmVsYXRlZCB0byB0aGUgcHJvY2Vzc2luZy5SA21zZxI/CgVxdWVyeRgDIAEoCUIpkkEmMiRUaGUgb3JpZ2luYWwgcXVlcnkgc2VudCBieSB0aGUgdXNlci5SBXF1ZXJ5EjMKCHJlc3BvbnNlGAQgASgJQheSQRQyElRoZSBBSSdzIHJlc3BvbnNlLlIIcmVzcG9uc2USbwoPZ2VuZXJhdGVkX2ZpbGVzGAUgAygLMgwucGIuQ2hhdEZpbGVCOJJBNTIzRmlsZXMgZ2VuZXJhdGVkIGJ5IHRoZSBBSSBpbiByZXNwb25zZSB0byB0aGUgcXVlcnkuUg5nZW5lcmF0ZWRGaWxlcxJfCg1maWxlX2FuYWx5c2lzGAYgASgLMhAucGIuRmlsZUFuYWx5c2lzQiiSQSUyI0FuYWx5c2lzIHJlc3VsdHMgb2YgdXBsb2FkZWQgZmlsZXMuUgxmaWxlQW5hbHlzaXM6VpJBUwpRKhhBSSBQcm9jZXNzIENoYXQgUmVzcG9uc2UyNUNvbnRhaW5zIHRoZSBBSSBjaGF0Ym90J3MgcmVzcG9uc2UgYWxvbmcgd2l0aCBzdGF0dXMu');
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
