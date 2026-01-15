///
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use startVoiceSessionRequestDescriptor instead')
const StartVoiceSessionRequest$json = const {
  '1': 'StartVoiceSessionRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'preferred_agent_language', '3': 2, '4': 1, '5': 9, '10': 'preferredAgentLanguage'},
  ],
};

/// Descriptor for `StartVoiceSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startVoiceSessionRequestDescriptor = $convert.base64Decode('ChhTdGFydFZvaWNlU2Vzc2lvblJlcXVlc3QSIQoMc2VydmljZV9uYW1lGAEgASgJUgtzZXJ2aWNlTmFtZRI4ChhwcmVmZXJyZWRfYWdlbnRfbGFuZ3VhZ2UYAiABKAlSFnByZWZlcnJlZEFnZW50TGFuZ3VhZ2U=');
@$core.Deprecated('Use startVoiceSessionResponseDescriptor instead')
const StartVoiceSessionResponse$json = const {
  '1': 'StartVoiceSessionResponse',
  '2': const [
    const {'1': 'room_name', '3': 1, '4': 1, '5': 9, '10': 'roomName'},
    const {'1': 'livekit_token', '3': 2, '4': 1, '5': 9, '10': 'livekitToken'},
    const {'1': 'agent_id', '3': 3, '4': 1, '5': 9, '10': 'agentId'},
    const {'1': 'agent_url', '3': 4, '4': 1, '5': 9, '10': 'agentUrl'},
    const {'1': 'agent_port', '3': 5, '4': 1, '5': 5, '10': 'agentPort'},
  ],
};

/// Descriptor for `StartVoiceSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startVoiceSessionResponseDescriptor = $convert.base64Decode('ChlTdGFydFZvaWNlU2Vzc2lvblJlc3BvbnNlEhsKCXJvb21fbmFtZRgBIAEoCVIIcm9vbU5hbWUSIwoNbGl2ZWtpdF90b2tlbhgCIAEoCVIMbGl2ZWtpdFRva2VuEhkKCGFnZW50X2lkGAMgASgJUgdhZ2VudElkEhsKCWFnZW50X3VybBgEIAEoCVIIYWdlbnRVcmwSHQoKYWdlbnRfcG9ydBgFIAEoBVIJYWdlbnRQb3J0');
@$core.Deprecated('Use processVoiceNoteRequestDescriptor instead')
const ProcessVoiceNoteRequest$json = const {
  '1': 'ProcessVoiceNoteRequest',
  '2': const [
    const {'1': 'tx_history', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'txHistory'},
  ],
  '7': const {},
};

/// Descriptor for `ProcessVoiceNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processVoiceNoteRequestDescriptor = $convert.base64Decode('ChdQcm9jZXNzVm9pY2VOb3RlUmVxdWVzdBJYCgp0eF9oaXN0b3J5GAEgASgJQjmSQTYyNE9wdGlvbmFsIEpTT04gc3RyaW5nIGNvbnRhaW5pbmcgcmVjZW50IHRyYW5zYWN0aW9ucy5SCXR4SGlzdG9yeTpekkFbClkqGlByb2Nlc3MgVm9pY2UgTm90ZSBSZXF1ZXN0MjtSZXF1ZXN0IHRvIHByb2Nlc3MgYW4gYXVkaW8gZmlsZSB2aWEgbXVsdGlwYXJ0IGZvcm0gdXBsb2FkLg==');
@$core.Deprecated('Use processVoiceNoteResponseDescriptor instead')
const ProcessVoiceNoteResponse$json = const {
  '1': 'ProcessVoiceNoteResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '8': const {}, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'msg'},
    const {'1': 'response', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'response'},
    const {'1': 'transcribed_text', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'transcribedText'},
    const {'1': 'processing_time_ms', '3': 5, '4': 1, '5': 3, '8': const {}, '10': 'processingTimeMs'},
  ],
  '7': const {},
};

/// Descriptor for `ProcessVoiceNoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processVoiceNoteResponseDescriptor = $convert.base64Decode('ChhQcm9jZXNzVm9pY2VOb3RlUmVzcG9uc2USVgoHc3VjY2VzcxgBIAEoCEI8kkE5MjdJbmRpY2F0ZXMgaWYgdGhlIHZvaWNlIG5vdGUgd2FzIHN1Y2Nlc3NmdWxseSBwcm9jZXNzZWQuUgdzdWNjZXNzEkAKA21zZxgCIAEoCUIukkErMilTdGF0dXMgbWVzc2FnZSByZWxhdGVkIHRvIHRoZSBwcm9jZXNzaW5nLlIDbXNnEk8KCHJlc3BvbnNlGAMgASgJQjOSQTAyLkFJJ3MgcmVzcG9uc2UgYmFzZWQgb24gdGhlIHZvaWNlIG5vdGUgY29udGVudC5SCHJlc3BvbnNlElUKEHRyYW5zY3JpYmVkX3RleHQYBCABKAlCKpJBJzIlVHJhbnNjcmliZWQgdGV4dCBmcm9tIHRoZSBhdWRpbyBmaWxlLlIPdHJhbnNjcmliZWRUZXh0ElMKEnByb2Nlc3NpbmdfdGltZV9tcxgFIAEoA0IlkkEiMiBQcm9jZXNzaW5nIHRpbWUgaW4gbWlsbGlzZWNvbmRzLlIQcHJvY2Vzc2luZ1RpbWVNczpokkFlCmMqG1Byb2Nlc3MgVm9pY2UgTm90ZSBSZXNwb25zZTJEUmVzcG9uc2UgY29udGFpbmluZyBBSSBhbmFseXNpcyBhbmQgdHJhbnNjcmlwdGlvbiBvZiB0aGUgdm9pY2Ugbm90ZS4=');
