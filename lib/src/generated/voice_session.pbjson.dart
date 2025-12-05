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
};

/// Descriptor for `StartVoiceSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startVoiceSessionRequestDescriptor = $convert.base64Decode('ChhTdGFydFZvaWNlU2Vzc2lvblJlcXVlc3Q=');
@$core.Deprecated('Use startVoiceSessionResponseDescriptor instead')
const StartVoiceSessionResponse$json = const {
  '1': 'StartVoiceSessionResponse',
  '2': const [
    const {'1': 'room_name', '3': 1, '4': 1, '5': 9, '10': 'roomName'},
    const {'1': 'livekit_token', '3': 2, '4': 1, '5': 9, '10': 'livekitToken'},
    const {'1': 'agent_id', '3': 3, '4': 1, '5': 9, '10': 'agentId'},
  ],
};

/// Descriptor for `StartVoiceSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startVoiceSessionResponseDescriptor = $convert.base64Decode('ChlTdGFydFZvaWNlU2Vzc2lvblJlc3BvbnNlEhsKCXJvb21fbmFtZRgBIAEoCVIIcm9vbU5hbWUSIwoNbGl2ZWtpdF90b2tlbhgCIAEoCVIMbGl2ZWtpdFRva2VuEhkKCGFnZW50X2lkGAMgASgJUgdhZ2VudElk');
