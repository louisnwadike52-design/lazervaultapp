//
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use startVoiceSessionRequestDescriptor instead')
const StartVoiceSessionRequest$json = {
  '1': 'StartVoiceSessionRequest',
  '2': [
    {'1': 'service_name', '3': 1, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'preferred_agent_language', '3': 2, '4': 1, '5': 9, '10': 'preferredAgentLanguage'},
  ],
};

/// Descriptor for `StartVoiceSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startVoiceSessionRequestDescriptor = $convert.base64Decode(
    'ChhTdGFydFZvaWNlU2Vzc2lvblJlcXVlc3QSIQoMc2VydmljZV9uYW1lGAEgASgJUgtzZXJ2aW'
    'NlTmFtZRI4ChhwcmVmZXJyZWRfYWdlbnRfbGFuZ3VhZ2UYAiABKAlSFnByZWZlcnJlZEFnZW50'
    'TGFuZ3VhZ2U=');

@$core.Deprecated('Use startVoiceSessionResponseDescriptor instead')
const StartVoiceSessionResponse$json = {
  '1': 'StartVoiceSessionResponse',
  '2': [
    {'1': 'room_name', '3': 1, '4': 1, '5': 9, '10': 'roomName'},
    {'1': 'livekit_token', '3': 2, '4': 1, '5': 9, '10': 'livekitToken'},
    {'1': 'agent_id', '3': 3, '4': 1, '5': 9, '10': 'agentId'},
    {'1': 'agent_url', '3': 4, '4': 1, '5': 9, '10': 'agentUrl'},
    {'1': 'agent_port', '3': 5, '4': 1, '5': 5, '10': 'agentPort'},
  ],
};

/// Descriptor for `StartVoiceSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startVoiceSessionResponseDescriptor = $convert.base64Decode(
    'ChlTdGFydFZvaWNlU2Vzc2lvblJlc3BvbnNlEhsKCXJvb21fbmFtZRgBIAEoCVIIcm9vbU5hbW'
    'USIwoNbGl2ZWtpdF90b2tlbhgCIAEoCVIMbGl2ZWtpdFRva2VuEhkKCGFnZW50X2lkGAMgASgJ'
    'UgdhZ2VudElkEhsKCWFnZW50X3VybBgEIAEoCVIIYWdlbnRVcmwSHQoKYWdlbnRfcG9ydBgFIA'
    'EoBVIJYWdlbnRQb3J0');

@$core.Deprecated('Use processVoiceNoteRequestDescriptor instead')
const ProcessVoiceNoteRequest$json = {
  '1': 'ProcessVoiceNoteRequest',
  '2': [
    {'1': 'tx_history', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'txHistory'},
  ],
  '7': {},
};

/// Descriptor for `ProcessVoiceNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processVoiceNoteRequestDescriptor = $convert.base64Decode(
    'ChdQcm9jZXNzVm9pY2VOb3RlUmVxdWVzdBJYCgp0eF9oaXN0b3J5GAEgASgJQjmSQTYyNE9wdG'
    'lvbmFsIEpTT04gc3RyaW5nIGNvbnRhaW5pbmcgcmVjZW50IHRyYW5zYWN0aW9ucy5SCXR4SGlz'
    'dG9yeTpekkFbClkqGlByb2Nlc3MgVm9pY2UgTm90ZSBSZXF1ZXN0MjtSZXF1ZXN0IHRvIHByb2'
    'Nlc3MgYW4gYXVkaW8gZmlsZSB2aWEgbXVsdGlwYXJ0IGZvcm0gdXBsb2FkLg==');

@$core.Deprecated('Use processVoiceNoteResponseDescriptor instead')
const ProcessVoiceNoteResponse$json = {
  '1': 'ProcessVoiceNoteResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '8': {}, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'msg'},
    {'1': 'response', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'response'},
    {'1': 'transcribed_text', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'transcribedText'},
    {'1': 'processing_time_ms', '3': 5, '4': 1, '5': 3, '8': {}, '10': 'processingTimeMs'},
  ],
  '7': {},
};

/// Descriptor for `ProcessVoiceNoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processVoiceNoteResponseDescriptor = $convert.base64Decode(
    'ChhQcm9jZXNzVm9pY2VOb3RlUmVzcG9uc2USVgoHc3VjY2VzcxgBIAEoCEI8kkE5MjdJbmRpY2'
    'F0ZXMgaWYgdGhlIHZvaWNlIG5vdGUgd2FzIHN1Y2Nlc3NmdWxseSBwcm9jZXNzZWQuUgdzdWNj'
    'ZXNzEkAKA21zZxgCIAEoCUIukkErMilTdGF0dXMgbWVzc2FnZSByZWxhdGVkIHRvIHRoZSBwcm'
    '9jZXNzaW5nLlIDbXNnEk8KCHJlc3BvbnNlGAMgASgJQjOSQTAyLkFJJ3MgcmVzcG9uc2UgYmFz'
    'ZWQgb24gdGhlIHZvaWNlIG5vdGUgY29udGVudC5SCHJlc3BvbnNlElUKEHRyYW5zY3JpYmVkX3'
    'RleHQYBCABKAlCKpJBJzIlVHJhbnNjcmliZWQgdGV4dCBmcm9tIHRoZSBhdWRpbyBmaWxlLlIP'
    'dHJhbnNjcmliZWRUZXh0ElMKEnByb2Nlc3NpbmdfdGltZV9tcxgFIAEoA0IlkkEiMiBQcm9jZX'
    'NzaW5nIHRpbWUgaW4gbWlsbGlzZWNvbmRzLlIQcHJvY2Vzc2luZ1RpbWVNczpokkFlCmMqG1By'
    'b2Nlc3MgVm9pY2UgTm90ZSBSZXNwb25zZTJEUmVzcG9uc2UgY29udGFpbmluZyBBSSBhbmFseX'
    'NpcyBhbmQgdHJhbnNjcmlwdGlvbiBvZiB0aGUgdm9pY2Ugbm90ZS4=');

