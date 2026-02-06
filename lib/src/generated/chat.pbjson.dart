//
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use messageTypeDescriptor instead')
const MessageType$json = {
  '1': 'MessageType',
  '2': [
    {'1': 'TEXT', '2': 0},
    {'1': 'IMAGE', '2': 1},
    {'1': 'VIDEO', '2': 2},
    {'1': 'FILE', '2': 3},
  ],
};

/// Descriptor for `MessageType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageTypeDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlVHlwZRIICgRURVhUEAASCQoFSU1BR0UQARIJCgVWSURFTxACEggKBEZJTEUQAw'
    '==');

@$core.Deprecated('Use chatMessageDescriptor instead')
const ChatMessage$json = {
  '1': 'ChatMessage',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'sender_user_id', '3': 2, '4': 1, '5': 9, '10': 'senderUserId'},
    {'1': 'receiver_user_id', '3': 3, '4': 1, '5': 9, '10': 'receiverUserId'},
    {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'message_type', '3': 6, '4': 1, '5': 14, '6': '.pb.MessageType', '10': 'messageType'},
    {'1': 'attachment_url', '3': 7, '4': 1, '5': 9, '10': 'attachmentUrl'},
    {'1': 'reply_to_message_id', '3': 8, '4': 1, '5': 9, '10': 'replyToMessageId'},
  ],
};

/// Descriptor for `ChatMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessageDescriptor = $convert.base64Decode(
    'CgtDaGF0TWVzc2FnZRIdCgptZXNzYWdlX2lkGAEgASgJUgltZXNzYWdlSWQSJAoOc2VuZGVyX3'
    'VzZXJfaWQYAiABKAlSDHNlbmRlclVzZXJJZBIoChByZWNlaXZlcl91c2VyX2lkGAMgASgJUg5y'
    'ZWNlaXZlclVzZXJJZBIYCgdjb250ZW50GAQgASgJUgdjb250ZW50EjgKCXRpbWVzdGFtcBgFIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBIyCgxtZXNzYWdlX3R5'
    'cGUYBiABKA4yDy5wYi5NZXNzYWdlVHlwZVILbWVzc2FnZVR5cGUSJQoOYXR0YWNobWVudF91cm'
    'wYByABKAlSDWF0dGFjaG1lbnRVcmwSLQoTcmVwbHlfdG9fbWVzc2FnZV9pZBgIIAEoCVIQcmVw'
    'bHlUb01lc3NhZ2VJZA==');

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'receiver_user_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'receiverUserId'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'content'},
    {'1': 'message_type', '3': 3, '4': 1, '5': 14, '6': '.pb.MessageType', '8': {}, '10': 'messageType'},
    {'1': 'attachment_url', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'attachmentUrl'},
    {'1': 'reply_to_message_id', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'replyToMessageId'},
  ],
  '7': {},
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSTAoQcmVjZWl2ZXJfdXNlcl9pZBgBIAEoCUIikkEfMh1UaG'
    'UgdXNlciBJRCBvZiB0aGUgcmVjaXBpZW50LlIOcmVjZWl2ZXJVc2VySWQScAoHY29udGVudBgC'
    'IAEoCUJWkkFTMlFUaGUgdGV4dCBjb250ZW50IG9mIHRoZSBtZXNzYWdlLCBvciBhIGRlc2NyaX'
    'B0aW9uL2ZpbGVuYW1lIGlmIGl0J3MgYW4gYXR0YWNobWVudC5SB2NvbnRlbnQSbAoMbWVzc2Fn'
    'ZV90eXBlGAMgASgOMg8ucGIuTWVzc2FnZVR5cGVCOJJBNTIzVGhlIHR5cGUgb2YgdGhlIG1lc3'
    'NhZ2UgKFRFWFQsIElNQUdFLCBWSURFTywgRklMRSkuUgttZXNzYWdlVHlwZRJ4Cg5hdHRhY2ht'
    'ZW50X3VybBgEIAEoCUJRkkFOMkxVUkwgb3IgaWRlbnRpZmllciBmb3IgdGhlIGF0dGFjaG1lbn'
    'QsIGlmIG1lc3NhZ2VfdHlwZSBpcyBub3QgVEVYVC4gT3B0aW9uYWwuUg1hdHRhY2htZW50VXJs'
    'EmcKE3JlcGx5X3RvX21lc3NhZ2VfaWQYBSABKAlCOJJBNTIzVGhlIElEIG9mIHRoZSBtZXNzYW'
    'dlIHRoaXMgaXMgYSByZXBseSB0by4gT3B0aW9uYWwuUhByZXBseVRvTWVzc2FnZUlkOnCSQW0K'
    'ayoUU2VuZCBNZXNzYWdlIFJlcXVlc3QyJ1BheWxvYWQgZm9yIHNlbmRpbmcgYSBuZXcgY2hhdC'
    'BtZXNzYWdlLtIBEHJlY2VpdmVyX3VzZXJfaWTSAQdjb250ZW500gEMbWVzc2FnZV90eXBl');

@$core.Deprecated('Use sendMessageResponseDescriptor instead')
const SendMessageResponse$json = {
  '1': 'SendMessageResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 11, '6': '.pb.ChatMessage', '10': 'message'},
  ],
  '7': {},
};

/// Descriptor for `SendMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageResponseDescriptor = $convert.base64Decode(
    'ChNTZW5kTWVzc2FnZVJlc3BvbnNlEikKB21lc3NhZ2UYASABKAsyDy5wYi5DaGF0TWVzc2FnZV'
    'IHbWVzc2FnZTpUkkFRCk8qFVNlbmQgTWVzc2FnZSBSZXNwb25zZTI2Q29udGFpbnMgdGhlIGRl'
    'dGFpbHMgb2YgdGhlIHN1Y2Nlc3NmdWxseSBzZW50IG1lc3NhZ2Uu');

@$core.Deprecated('Use getChatHistoryRequestDescriptor instead')
const GetChatHistoryRequest$json = {
  '1': 'GetChatHistoryRequest',
  '2': [
    {'1': 'peer_user_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'peerUserId'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '8': {}, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'pageToken'},
  ],
  '7': {},
};

/// Descriptor for `GetChatHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChatHistoryRequestDescriptor = $convert.base64Decode(
    'ChVHZXRDaGF0SGlzdG9yeVJlcXVlc3QSWAoMcGVlcl91c2VyX2lkGAEgASgJQjaSQTMyMVRoZS'
    'B1c2VyIElEIG9mIHRoZSBvdGhlciBwYXJ0aWNpcGFudCBpbiB0aGUgY2hhdC5SCnBlZXJVc2Vy'
    'SWQSVQoJcGFnZV9zaXplGAIgASgFQjiSQTUyM051bWJlciBvZiBtZXNzYWdlcyB0byByZXR1cm'
    '4gcGVyIHBhZ2UuIERlZmF1bHQ6IDUwLlIIcGFnZVNpemUSWgoKcGFnZV90b2tlbhgDIAEoCUI7'
    'kkE4MjZUb2tlbiBmb3IgZmV0Y2hpbmcgdGhlIG5leHQgcGFnZSBvZiByZXN1bHRzLiBPcHRpb2'
    '5hbC5SCXBhZ2VUb2tlbjpqkkFnCmUqGEdldCBDaGF0IEhpc3RvcnkgUmVxdWVzdDI6UGF5bG9h'
    'ZCBmb3IgcmV0cmlldmluZyB0aGUgY2hhdCBoaXN0b3J5IHdpdGggYW5vdGhlciB1c2VyLtIBDH'
    'BlZXJfdXNlcl9pZA==');

@$core.Deprecated('Use getChatHistoryResponseDescriptor instead')
const GetChatHistoryResponse$json = {
  '1': 'GetChatHistoryResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.pb.ChatMessage', '10': 'messages'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'nextPageToken'},
  ],
  '7': {},
};

/// Descriptor for `GetChatHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChatHistoryResponseDescriptor = $convert.base64Decode(
    'ChZHZXRDaGF0SGlzdG9yeVJlc3BvbnNlEisKCG1lc3NhZ2VzGAEgAygLMg8ucGIuQ2hhdE1lc3'
    'NhZ2VSCG1lc3NhZ2VzEoIBCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlCWpJBVzJVVG9rZW4gdG8g'
    'dXNlIGluIHRoZSBuZXh0IHJlcXVlc3QgdG8gZ2V0IHRoZSBmb2xsb3dpbmcgcGFnZS4gRW1wdH'
    'kgaWYgbm8gbW9yZSByZXN1bHRzLlINbmV4dFBhZ2VUb2tlbjpSkkFPCk0qGUdldCBDaGF0IEhp'
    'c3RvcnkgUmVzcG9uc2UyMENvbnRhaW5zIGEgbGlzdCBvZiBtZXNzYWdlcyBhbmQgcGFnaW5hdG'
    'lvbiBpbmZvLg==');

@$core.Deprecated('Use streamChatHistoryRequestDescriptor instead')
const StreamChatHistoryRequest$json = {
  '1': 'StreamChatHistoryRequest',
  '2': [
    {'1': 'peer_user_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'peerUserId'},
  ],
  '7': {},
};

/// Descriptor for `StreamChatHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamChatHistoryRequestDescriptor = $convert.base64Decode(
    'ChhTdHJlYW1DaGF0SGlzdG9yeVJlcXVlc3QSWAoMcGVlcl91c2VyX2lkGAEgASgJQjaSQTMyMV'
    'RoZSB1c2VyIElEIG9mIHRoZSBvdGhlciBwYXJ0aWNpcGFudCBpbiB0aGUgY2hhdC5SCnBlZXJV'
    'c2VySWQ6cZJBbgpsKhtTdHJlYW0gQ2hhdCBIaXN0b3J5IFJlcXVlc3QyPlBheWxvYWQgdG8gaW'
    '5pdGlhdGUgc3RyZWFtaW5nIGNoYXQgbWVzc2FnZXMgd2l0aCBhbm90aGVyIHVzZXIu0gEMcGVl'
    'cl91c2VyX2lk');

