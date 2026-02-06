//
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use verificationStatusDescriptor instead')
const VerificationStatus$json = {
  '1': 'VerificationStatus',
  '2': [
    {'1': 'VERIFICATION_UNKNOWN', '2': 0},
    {'1': 'VERIFICATION_SUCCESS', '2': 1},
    {'1': 'VERIFICATION_FAILED', '2': 2},
    {'1': 'VERIFICATION_NO_ENROLLMENT', '2': 3},
    {'1': 'VERIFICATION_POOR_QUALITY', '2': 4},
    {'1': 'VERIFICATION_THRESHOLD_NOT_MET', '2': 5},
  ],
};

/// Descriptor for `VerificationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List verificationStatusDescriptor = $convert.base64Decode(
    'ChJWZXJpZmljYXRpb25TdGF0dXMSGAoUVkVSSUZJQ0FUSU9OX1VOS05PV04QABIYChRWRVJJRk'
    'lDQVRJT05fU1VDQ0VTUxABEhcKE1ZFUklGSUNBVElPTl9GQUlMRUQQAhIeChpWRVJJRklDQVRJ'
    'T05fTk9fRU5ST0xMTUVOVBADEh0KGVZFUklGSUNBVElPTl9QT09SX1FVQUxJVFkQBBIiCh5WRV'
    'JJRklDQVRJT05fVEhSRVNIT0xEX05PVF9NRVQQBQ==');

@$core.Deprecated('Use enrollVoiceRequestDescriptor instead')
const EnrollVoiceRequest$json = {
  '1': 'EnrollVoiceRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'audio_samples', '3': 2, '4': 3, '5': 12, '10': 'audioSamples'},
    {'1': 'format', '3': 3, '4': 1, '5': 11, '6': '.voicebiometrics.AudioFormat', '10': 'format'},
    {'1': 'metadata', '3': 4, '4': 3, '5': 11, '6': '.voicebiometrics.EnrollVoiceRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': [EnrollVoiceRequest_MetadataEntry$json],
};

@$core.Deprecated('Use enrollVoiceRequestDescriptor instead')
const EnrollVoiceRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `EnrollVoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollVoiceRequestDescriptor = $convert.base64Decode(
    'ChJFbnJvbGxWb2ljZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiMKDWF1ZGlvX3'
    'NhbXBsZXMYAiADKAxSDGF1ZGlvU2FtcGxlcxI0CgZmb3JtYXQYAyABKAsyHC52b2ljZWJpb21l'
    'dHJpY3MuQXVkaW9Gb3JtYXRSBmZvcm1hdBJNCghtZXRhZGF0YRgEIAMoCzIxLnZvaWNlYmlvbW'
    'V0cmljcy5FbnJvbGxWb2ljZVJlcXVlc3QuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0'
    'YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use enrollVoiceResponseDescriptor instead')
const EnrollVoiceResponse$json = {
  '1': 'EnrollVoiceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'enrollment_id', '3': 2, '4': 1, '5': 9, '10': 'enrollmentId'},
    {'1': 'samples_count', '3': 3, '4': 1, '5': 5, '10': 'samplesCount'},
    {'1': 'quality_score', '3': 4, '4': 1, '5': 2, '10': 'qualityScore'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    {'1': 'voice_profile', '3': 6, '4': 1, '5': 11, '6': '.voicebiometrics.VoiceProfile', '10': 'voiceProfile'},
  ],
};

/// Descriptor for `EnrollVoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollVoiceResponseDescriptor = $convert.base64Decode(
    'ChNFbnJvbGxWb2ljZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIwoNZW5yb2'
    'xsbWVudF9pZBgCIAEoCVIMZW5yb2xsbWVudElkEiMKDXNhbXBsZXNfY291bnQYAyABKAVSDHNh'
    'bXBsZXNDb3VudBIjCg1xdWFsaXR5X3Njb3JlGAQgASgCUgxxdWFsaXR5U2NvcmUSGAoHbWVzc2'
    'FnZRgFIAEoCVIHbWVzc2FnZRJCCg12b2ljZV9wcm9maWxlGAYgASgLMh0udm9pY2ViaW9tZXRy'
    'aWNzLlZvaWNlUHJvZmlsZVIMdm9pY2VQcm9maWxl');

@$core.Deprecated('Use verifyVoiceRequestDescriptor instead')
const VerifyVoiceRequest$json = {
  '1': 'VerifyVoiceRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'audio_sample', '3': 2, '4': 1, '5': 12, '10': 'audioSample'},
    {'1': 'format', '3': 3, '4': 1, '5': 11, '6': '.voicebiometrics.AudioFormat', '10': 'format'},
    {'1': 'threshold', '3': 4, '4': 1, '5': 2, '10': 'threshold'},
    {'1': 'metadata', '3': 5, '4': 3, '5': 11, '6': '.voicebiometrics.VerifyVoiceRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': [VerifyVoiceRequest_MetadataEntry$json],
};

@$core.Deprecated('Use verifyVoiceRequestDescriptor instead')
const VerifyVoiceRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `VerifyVoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyVoiceRequestDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlWb2ljZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiEKDGF1ZGlvX3'
    'NhbXBsZRgCIAEoDFILYXVkaW9TYW1wbGUSNAoGZm9ybWF0GAMgASgLMhwudm9pY2ViaW9tZXRy'
    'aWNzLkF1ZGlvRm9ybWF0UgZmb3JtYXQSHAoJdGhyZXNob2xkGAQgASgCUgl0aHJlc2hvbGQSTQ'
    'oIbWV0YWRhdGEYBSADKAsyMS52b2ljZWJpb21ldHJpY3MuVmVyaWZ5Vm9pY2VSZXF1ZXN0Lk1l'
    'dGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZX'
    'kSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use verifyVoiceResponseDescriptor instead')
const VerifyVoiceResponse$json = {
  '1': 'VerifyVoiceResponse',
  '2': [
    {'1': 'verified', '3': 1, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'similarity_score', '3': 2, '4': 1, '5': 2, '10': 'similarityScore'},
    {'1': 'confidence', '3': 3, '4': 1, '5': 2, '10': 'confidence'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.voicebiometrics.VerificationStatus', '10': 'status'},
    {'1': 'verification_timestamp', '3': 6, '4': 1, '5': 3, '10': 'verificationTimestamp'},
  ],
};

/// Descriptor for `VerifyVoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyVoiceResponseDescriptor = $convert.base64Decode(
    'ChNWZXJpZnlWb2ljZVJlc3BvbnNlEhoKCHZlcmlmaWVkGAEgASgIUgh2ZXJpZmllZBIpChBzaW'
    '1pbGFyaXR5X3Njb3JlGAIgASgCUg9zaW1pbGFyaXR5U2NvcmUSHgoKY29uZmlkZW5jZRgDIAEo'
    'AlIKY29uZmlkZW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlEjsKBnN0YXR1cxgFIAEoDj'
    'IjLnZvaWNlYmlvbWV0cmljcy5WZXJpZmljYXRpb25TdGF0dXNSBnN0YXR1cxI1ChZ2ZXJpZmlj'
    'YXRpb25fdGltZXN0YW1wGAYgASgDUhV2ZXJpZmljYXRpb25UaW1lc3RhbXA=');

@$core.Deprecated('Use checkEnrollmentStatusRequestDescriptor instead')
const CheckEnrollmentStatusRequest$json = {
  '1': 'CheckEnrollmentStatusRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `CheckEnrollmentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEnrollmentStatusRequestDescriptor = $convert.base64Decode(
    'ChxDaGVja0Vucm9sbG1lbnRTdGF0dXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA'
    '==');

@$core.Deprecated('Use checkEnrollmentStatusResponseDescriptor instead')
const CheckEnrollmentStatusResponse$json = {
  '1': 'CheckEnrollmentStatusResponse',
  '2': [
    {'1': 'is_enrolled', '3': 1, '4': 1, '5': 8, '10': 'isEnrolled'},
    {'1': 'enrollment_id', '3': 2, '4': 1, '5': 9, '10': 'enrollmentId'},
    {'1': 'enrolled_at', '3': 3, '4': 1, '5': 3, '10': 'enrolledAt'},
    {'1': 'samples_count', '3': 4, '4': 1, '5': 5, '10': 'samplesCount'},
    {'1': 'quality_score', '3': 5, '4': 1, '5': 2, '10': 'qualityScore'},
    {'1': 'voice_profile', '3': 6, '4': 1, '5': 11, '6': '.voicebiometrics.VoiceProfile', '10': 'voiceProfile'},
  ],
};

/// Descriptor for `CheckEnrollmentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEnrollmentStatusResponseDescriptor = $convert.base64Decode(
    'Ch1DaGVja0Vucm9sbG1lbnRTdGF0dXNSZXNwb25zZRIfCgtpc19lbnJvbGxlZBgBIAEoCFIKaX'
    'NFbnJvbGxlZBIjCg1lbnJvbGxtZW50X2lkGAIgASgJUgxlbnJvbGxtZW50SWQSHwoLZW5yb2xs'
    'ZWRfYXQYAyABKANSCmVucm9sbGVkQXQSIwoNc2FtcGxlc19jb3VudBgEIAEoBVIMc2FtcGxlc0'
    'NvdW50EiMKDXF1YWxpdHlfc2NvcmUYBSABKAJSDHF1YWxpdHlTY29yZRJCCg12b2ljZV9wcm9m'
    'aWxlGAYgASgLMh0udm9pY2ViaW9tZXRyaWNzLlZvaWNlUHJvZmlsZVIMdm9pY2VQcm9maWxl');

@$core.Deprecated('Use deleteVoiceEnrollmentRequestDescriptor instead')
const DeleteVoiceEnrollmentRequest$json = {
  '1': 'DeleteVoiceEnrollmentRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `DeleteVoiceEnrollmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteVoiceEnrollmentRequestDescriptor = $convert.base64Decode(
    'ChxEZWxldGVWb2ljZUVucm9sbG1lbnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA'
    '==');

@$core.Deprecated('Use deleteVoiceEnrollmentResponseDescriptor instead')
const DeleteVoiceEnrollmentResponse$json = {
  '1': 'DeleteVoiceEnrollmentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteVoiceEnrollmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteVoiceEnrollmentResponseDescriptor = $convert.base64Decode(
    'Ch1EZWxldGVWb2ljZUVucm9sbG1lbnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use updateVoiceEnrollmentRequestDescriptor instead')
const UpdateVoiceEnrollmentRequest$json = {
  '1': 'UpdateVoiceEnrollmentRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'audio_samples', '3': 2, '4': 3, '5': 12, '10': 'audioSamples'},
    {'1': 'format', '3': 3, '4': 1, '5': 11, '6': '.voicebiometrics.AudioFormat', '10': 'format'},
  ],
};

/// Descriptor for `UpdateVoiceEnrollmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateVoiceEnrollmentRequestDescriptor = $convert.base64Decode(
    'ChxVcGRhdGVWb2ljZUVucm9sbG1lbnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZB'
    'IjCg1hdWRpb19zYW1wbGVzGAIgAygMUgxhdWRpb1NhbXBsZXMSNAoGZm9ybWF0GAMgASgLMhwu'
    'dm9pY2ViaW9tZXRyaWNzLkF1ZGlvRm9ybWF0UgZmb3JtYXQ=');

@$core.Deprecated('Use updateVoiceEnrollmentResponseDescriptor instead')
const UpdateVoiceEnrollmentResponse$json = {
  '1': 'UpdateVoiceEnrollmentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'new_samples_count', '3': 2, '4': 1, '5': 5, '10': 'newSamplesCount'},
    {'1': 'updated_quality_score', '3': 3, '4': 1, '5': 2, '10': 'updatedQualityScore'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateVoiceEnrollmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateVoiceEnrollmentResponseDescriptor = $convert.base64Decode(
    'Ch1VcGRhdGVWb2ljZUVucm9sbG1lbnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEioKEW5ld19zYW1wbGVzX2NvdW50GAIgASgFUg9uZXdTYW1wbGVzQ291bnQSMgoVdXBkYXRl'
    'ZF9xdWFsaXR5X3Njb3JlGAMgASgCUhN1cGRhdGVkUXVhbGl0eVNjb3JlEhgKB21lc3NhZ2UYBC'
    'ABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getVoiceEnrollmentRequestDescriptor instead')
const GetVoiceEnrollmentRequest$json = {
  '1': 'GetVoiceEnrollmentRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetVoiceEnrollmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVoiceEnrollmentRequestDescriptor = $convert.base64Decode(
    'ChlHZXRWb2ljZUVucm9sbG1lbnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use getVoiceEnrollmentResponseDescriptor instead')
const GetVoiceEnrollmentResponse$json = {
  '1': 'GetVoiceEnrollmentResponse',
  '2': [
    {'1': 'exists', '3': 1, '4': 1, '5': 8, '10': 'exists'},
    {'1': 'voice_profile', '3': 2, '4': 1, '5': 11, '6': '.voicebiometrics.VoiceProfile', '10': 'voiceProfile'},
    {'1': 'metadata', '3': 3, '4': 1, '5': 11, '6': '.voicebiometrics.EnrollmentMetadata', '10': 'metadata'},
  ],
};

/// Descriptor for `GetVoiceEnrollmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVoiceEnrollmentResponseDescriptor = $convert.base64Decode(
    'ChpHZXRWb2ljZUVucm9sbG1lbnRSZXNwb25zZRIWCgZleGlzdHMYASABKAhSBmV4aXN0cxJCCg'
    '12b2ljZV9wcm9maWxlGAIgASgLMh0udm9pY2ViaW9tZXRyaWNzLlZvaWNlUHJvZmlsZVIMdm9p'
    'Y2VQcm9maWxlEj8KCG1ldGFkYXRhGAMgASgLMiMudm9pY2ViaW9tZXRyaWNzLkVucm9sbG1lbn'
    'RNZXRhZGF0YVIIbWV0YWRhdGE=');

@$core.Deprecated('Use voiceProfileDescriptor instead')
const VoiceProfile$json = {
  '1': 'VoiceProfile',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'enrollment_id', '3': 2, '4': 1, '5': 9, '10': 'enrollmentId'},
    {'1': 'created_at', '3': 3, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'updated_at', '3': 4, '4': 1, '5': 3, '10': 'updatedAt'},
    {'1': 'samples_count', '3': 5, '4': 1, '5': 5, '10': 'samplesCount'},
    {'1': 'quality_score', '3': 6, '4': 1, '5': 2, '10': 'qualityScore'},
    {'1': 'verification_count', '3': 7, '4': 1, '5': 5, '10': 'verificationCount'},
    {'1': 'last_verified_at', '3': 8, '4': 1, '5': 3, '10': 'lastVerifiedAt'},
  ],
};

/// Descriptor for `VoiceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voiceProfileDescriptor = $convert.base64Decode(
    'CgxWb2ljZVByb2ZpbGUSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiMKDWVucm9sbG1lbnRfaW'
    'QYAiABKAlSDGVucm9sbG1lbnRJZBIdCgpjcmVhdGVkX2F0GAMgASgDUgljcmVhdGVkQXQSHQoK'
    'dXBkYXRlZF9hdBgEIAEoA1IJdXBkYXRlZEF0EiMKDXNhbXBsZXNfY291bnQYBSABKAVSDHNhbX'
    'BsZXNDb3VudBIjCg1xdWFsaXR5X3Njb3JlGAYgASgCUgxxdWFsaXR5U2NvcmUSLQoSdmVyaWZp'
    'Y2F0aW9uX2NvdW50GAcgASgFUhF2ZXJpZmljYXRpb25Db3VudBIoChBsYXN0X3ZlcmlmaWVkX2'
    'F0GAggASgDUg5sYXN0VmVyaWZpZWRBdA==');

@$core.Deprecated('Use enrollmentMetadataDescriptor instead')
const EnrollmentMetadata$json = {
  '1': 'EnrollmentMetadata',
  '2': [
    {'1': 'device_info', '3': 1, '4': 1, '5': 9, '10': 'deviceInfo'},
    {'1': 'audio_quality', '3': 2, '4': 1, '5': 9, '10': 'audioQuality'},
    {'1': 'sample_ids', '3': 3, '4': 3, '5': 9, '10': 'sampleIds'},
    {'1': 'custom_fields', '3': 4, '4': 3, '5': 11, '6': '.voicebiometrics.EnrollmentMetadata.CustomFieldsEntry', '10': 'customFields'},
  ],
  '3': [EnrollmentMetadata_CustomFieldsEntry$json],
};

@$core.Deprecated('Use enrollmentMetadataDescriptor instead')
const EnrollmentMetadata_CustomFieldsEntry$json = {
  '1': 'CustomFieldsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `EnrollmentMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollmentMetadataDescriptor = $convert.base64Decode(
    'ChJFbnJvbGxtZW50TWV0YWRhdGESHwoLZGV2aWNlX2luZm8YASABKAlSCmRldmljZUluZm8SIw'
    'oNYXVkaW9fcXVhbGl0eRgCIAEoCVIMYXVkaW9RdWFsaXR5Eh0KCnNhbXBsZV9pZHMYAyADKAlS'
    'CXNhbXBsZUlkcxJaCg1jdXN0b21fZmllbGRzGAQgAygLMjUudm9pY2ViaW9tZXRyaWNzLkVucm'
    '9sbG1lbnRNZXRhZGF0YS5DdXN0b21GaWVsZHNFbnRyeVIMY3VzdG9tRmllbGRzGj8KEUN1c3Rv'
    'bUZpZWxkc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOA'
    'E=');

@$core.Deprecated('Use audioFormatDescriptor instead')
const AudioFormat$json = {
  '1': 'AudioFormat',
  '2': [
    {'1': 'codec', '3': 1, '4': 1, '5': 9, '10': 'codec'},
    {'1': 'sample_rate', '3': 2, '4': 1, '5': 5, '10': 'sampleRate'},
    {'1': 'channels', '3': 3, '4': 1, '5': 5, '10': 'channels'},
    {'1': 'bit_depth', '3': 4, '4': 1, '5': 5, '10': 'bitDepth'},
  ],
};

/// Descriptor for `AudioFormat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioFormatDescriptor = $convert.base64Decode(
    'CgtBdWRpb0Zvcm1hdBIUCgVjb2RlYxgBIAEoCVIFY29kZWMSHwoLc2FtcGxlX3JhdGUYAiABKA'
    'VSCnNhbXBsZVJhdGUSGgoIY2hhbm5lbHMYAyABKAVSCGNoYW5uZWxzEhsKCWJpdF9kZXB0aBgE'
    'IAEoBVIIYml0RGVwdGg=');

