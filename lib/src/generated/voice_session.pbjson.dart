//
//  Generated code. Do not modify.
//  source: voice_session.proto
//
// @dart = 3.3

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
};

/// Descriptor for `StartVoiceSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startVoiceSessionRequestDescriptor = $convert.base64Decode(
    'ChhTdGFydFZvaWNlU2Vzc2lvblJlcXVlc3Q=');

@$core.Deprecated('Use startVoiceSessionResponseDescriptor instead')
const StartVoiceSessionResponse$json = {
  '1': 'StartVoiceSessionResponse',
  '2': [
    {'1': 'room_name', '3': 1, '4': 1, '5': 9, '10': 'roomName'},
    {'1': 'livekit_token', '3': 2, '4': 1, '5': 9, '10': 'livekitToken'},
    {'1': 'agent_id', '3': 3, '4': 1, '5': 9, '10': 'agentId'},
  ],
};

/// Descriptor for `StartVoiceSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startVoiceSessionResponseDescriptor = $convert.base64Decode(
    'ChlTdGFydFZvaWNlU2Vzc2lvblJlc3BvbnNlEhsKCXJvb21fbmFtZRgBIAEoCVIIcm9vbU5hbW'
    'USIwoNbGl2ZWtpdF90b2tlbhgCIAEoCVIMbGl2ZWtpdFRva2VuEhkKCGFnZW50X2lkGAMgASgJ'
    'UgdhZ2VudElk');

