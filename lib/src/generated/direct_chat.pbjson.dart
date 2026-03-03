//
//  Generated code. Do not modify.
//  source: direct_chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use sendDirectMessageRequestDescriptor instead')
const SendDirectMessageRequest$json = {
  '1': 'SendDirectMessageRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'source_context', '3': 3, '4': 1, '5': 9, '10': 'sourceContext'},
    {'1': 'language', '3': 4, '4': 1, '5': 9, '10': 'language'},
    {'1': 'locale', '3': 5, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_country', '3': 7, '4': 1, '5': 9, '10': 'userCountry'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'entities', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Struct', '10': 'entities'},
    {'1': 'response_style_instruction', '3': 10, '4': 1, '5': 9, '10': 'responseStyleInstruction'},
  ],
};

/// Descriptor for `SendDirectMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendDirectMessageRequestDescriptor = $convert.base64Decode(
    'ChhTZW5kRGlyZWN0TWVzc2FnZVJlcXVlc3QSGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZRIdCg'
    'pzZXNzaW9uX2lkGAIgASgJUglzZXNzaW9uSWQSJQoOc291cmNlX2NvbnRleHQYAyABKAlSDXNv'
    'dXJjZUNvbnRleHQSGgoIbGFuZ3VhZ2UYBCABKAlSCGxhbmd1YWdlEhYKBmxvY2FsZRgFIAEoCV'
    'IGbG9jYWxlEh0KCmFjY291bnRfaWQYBiABKAlSCWFjY291bnRJZBIhCgx1c2VyX2NvdW50cnkY'
    'ByABKAlSC3VzZXJDb3VudHJ5EhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIzCghlbnRpdG'
    'llcxgJIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RSCGVudGl0aWVzEjwKGnJlc3BvbnNl'
    'X3N0eWxlX2luc3RydWN0aW9uGAogASgJUhhyZXNwb25zZVN0eWxlSW5zdHJ1Y3Rpb24=');

@$core.Deprecated('Use sendDirectMessageResponseDescriptor instead')
const SendDirectMessageResponse$json = {
  '1': 'SendDirectMessageResponse',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'response', '3': 2, '4': 1, '5': 9, '10': 'response'},
    {'1': 'service_routed_to', '3': 3, '4': 1, '5': 9, '10': 'serviceRoutedTo'},
    {'1': 'session_id', '3': 4, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'entities', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Struct', '10': 'entities'},
    {'1': 'conversation_state', '3': 6, '4': 1, '5': 9, '10': 'conversationState'},
  ],
};

/// Descriptor for `SendDirectMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendDirectMessageResponseDescriptor = $convert.base64Decode(
    'ChlTZW5kRGlyZWN0TWVzc2FnZVJlc3BvbnNlEh0KCm1lc3NhZ2VfaWQYASABKAlSCW1lc3NhZ2'
    'VJZBIaCghyZXNwb25zZRgCIAEoCVIIcmVzcG9uc2USKgoRc2VydmljZV9yb3V0ZWRfdG8YAyAB'
    'KAlSD3NlcnZpY2VSb3V0ZWRUbxIdCgpzZXNzaW9uX2lkGAQgASgJUglzZXNzaW9uSWQSMwoIZW'
    '50aXRpZXMYBSABKAsyFy5nb29nbGUucHJvdG9idWYuU3RydWN0UghlbnRpdGllcxItChJjb252'
    'ZXJzYXRpb25fc3RhdGUYBiABKAlSEWNvbnZlcnNhdGlvblN0YXRl');

@$core.Deprecated('Use getDirectChatHistoryRequestDescriptor instead')
const GetDirectChatHistoryRequest$json = {
  '1': 'GetDirectChatHistoryRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'source_context', '3': 2, '4': 1, '5': 9, '10': 'sourceContext'},
    {'1': 'locale', '3': 3, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 5, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetDirectChatHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDirectChatHistoryRequestDescriptor = $convert.base64Decode(
    'ChtHZXREaXJlY3RDaGF0SGlzdG9yeVJlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoCVIJc2Vzc2'
    'lvbklkEiUKDnNvdXJjZV9jb250ZXh0GAIgASgJUg1zb3VyY2VDb250ZXh0EhYKBmxvY2FsZRgD'
    'IAEoCVIGbG9jYWxlEhQKBWxpbWl0GAQgASgFUgVsaW1pdBIWCgZvZmZzZXQYBSABKAVSBm9mZn'
    'NldA==');

@$core.Deprecated('Use directChatHistoryMessageDescriptor instead')
const DirectChatHistoryMessage$json = {
  '1': 'DirectChatHistoryMessage',
  '2': [
    {'1': 'role', '3': 1, '4': 1, '5': 9, '10': 'role'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {'1': 'service', '3': 3, '4': 1, '5': 9, '10': 'service'},
    {'1': 'source_context', '3': 4, '4': 1, '5': 9, '10': 'sourceContext'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `DirectChatHistoryMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directChatHistoryMessageDescriptor = $convert.base64Decode(
    'ChhEaXJlY3RDaGF0SGlzdG9yeU1lc3NhZ2USEgoEcm9sZRgBIAEoCVIEcm9sZRIYCgdjb250ZW'
    '50GAIgASgJUgdjb250ZW50EhgKB3NlcnZpY2UYAyABKAlSB3NlcnZpY2USJQoOc291cmNlX2Nv'
    'bnRleHQYBCABKAlSDXNvdXJjZUNvbnRleHQSHQoKY3JlYXRlZF9hdBgFIAEoCVIJY3JlYXRlZE'
    'F0');

@$core.Deprecated('Use getDirectChatHistoryResponseDescriptor instead')
const GetDirectChatHistoryResponse$json = {
  '1': 'GetDirectChatHistoryResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.directchat.DirectChatHistoryMessage', '10': 'messages'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'session_id', '3': 3, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `GetDirectChatHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDirectChatHistoryResponseDescriptor = $convert.base64Decode(
    'ChxHZXREaXJlY3RDaGF0SGlzdG9yeVJlc3BvbnNlEkAKCG1lc3NhZ2VzGAEgAygLMiQuZGlyZW'
    'N0Y2hhdC5EaXJlY3RDaGF0SGlzdG9yeU1lc3NhZ2VSCG1lc3NhZ2VzEhQKBXRvdGFsGAIgASgF'
    'UgV0b3RhbBIdCgpzZXNzaW9uX2lkGAMgASgJUglzZXNzaW9uSWQ=');

