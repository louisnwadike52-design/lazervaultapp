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
  ],
  '7': const {},
};

/// Descriptor for `ProcessChatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processChatRequestDescriptor = $convert.base64Decode('ChJQcm9jZXNzQ2hhdFJlcXVlc3QSPAoFcXVlcnkYASABKAlCJpJBIzIhVGhlIHVzZXIncyBpbnB1dC9xdWVyeSB0byB0aGUgQUkuUgVxdWVyeTpfkkFcCloqF0FJIFByb2Nlc3MgQ2hhdCBSZXF1ZXN0MjdQYXlsb2FkIGNvbnRhaW5pbmcgdGhlIHVzZXIncyBxdWVyeSBmb3IgdGhlIEFJIGNoYXRib3Qu0gEFcXVlcnk=');
@$core.Deprecated('Use processChatResponseDescriptor instead')
const ProcessChatResponse$json = const {
  '1': 'ProcessChatResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '8': const {}, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'msg'},
    const {'1': 'query', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'query'},
    const {'1': 'response', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'response'},
  ],
  '7': const {},
};

/// Descriptor for `ProcessChatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processChatResponseDescriptor = $convert.base64Decode('ChNQcm9jZXNzQ2hhdFJlc3BvbnNlElEKB3N1Y2Nlc3MYASABKAhCN5JBNDIySW5kaWNhdGVzIGlmIHRoZSBxdWVyeSB3YXMgc3VjY2Vzc2Z1bGx5IHByb2Nlc3NlZC5SB3N1Y2Nlc3MSQgoDbXNnGAIgASgJQjCSQS0yK0Egc3RhdHVzIG1lc3NhZ2UgcmVsYXRlZCB0byB0aGUgcHJvY2Vzc2luZy5SA21zZxI/CgVxdWVyeRgDIAEoCUIpkkEmMiRUaGUgb3JpZ2luYWwgcXVlcnkgc2VudCBieSB0aGUgdXNlci5SBXF1ZXJ5EjMKCHJlc3BvbnNlGAQgASgJQheSQRQyElRoZSBBSSdzIHJlc3BvbnNlLlIIcmVzcG9uc2U6VpJBUwpRKhhBSSBQcm9jZXNzIENoYXQgUmVzcG9uc2UyNUNvbnRhaW5zIHRoZSBBSSBjaGF0Ym90J3MgcmVzcG9uc2UgYWxvbmcgd2l0aCBzdGF0dXMu');
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
