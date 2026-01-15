///
//  Generated code. Do not modify.
//  source: voice-biometrics.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use verificationStatusDescriptor instead')
const VerificationStatus$json = const {
  '1': 'VerificationStatus',
  '2': const [
    const {'1': 'VERIFICATION_UNKNOWN', '2': 0},
    const {'1': 'VERIFICATION_SUCCESS', '2': 1},
    const {'1': 'VERIFICATION_FAILED', '2': 2},
    const {'1': 'VERIFICATION_NO_ENROLLMENT', '2': 3},
    const {'1': 'VERIFICATION_POOR_QUALITY', '2': 4},
    const {'1': 'VERIFICATION_THRESHOLD_NOT_MET', '2': 5},
  ],
};

/// Descriptor for `VerificationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List verificationStatusDescriptor = $convert.base64Decode('ChJWZXJpZmljYXRpb25TdGF0dXMSGAoUVkVSSUZJQ0FUSU9OX1VOS05PV04QABIYChRWRVJJRklDQVRJT05fU1VDQ0VTUxABEhcKE1ZFUklGSUNBVElPTl9GQUlMRUQQAhIeChpWRVJJRklDQVRJT05fTk9fRU5ST0xMTUVOVBADEh0KGVZFUklGSUNBVElPTl9QT09SX1FVQUxJVFkQBBIiCh5WRVJJRklDQVRJT05fVEhSRVNIT0xEX05PVF9NRVQQBQ==');
@$core.Deprecated('Use enrollVoiceRequestDescriptor instead')
const EnrollVoiceRequest$json = const {
  '1': 'EnrollVoiceRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'audio_samples', '3': 2, '4': 3, '5': 12, '10': 'audioSamples'},
    const {'1': 'format', '3': 3, '4': 1, '5': 11, '6': '.voicebiometrics.AudioFormat', '10': 'format'},
    const {'1': 'metadata', '3': 4, '4': 3, '5': 11, '6': '.voicebiometrics.EnrollVoiceRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': const [EnrollVoiceRequest_MetadataEntry$json],
};

@$core.Deprecated('Use enrollVoiceRequestDescriptor instead')
const EnrollVoiceRequest_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `EnrollVoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollVoiceRequestDescriptor = $convert.base64Decode('ChJFbnJvbGxWb2ljZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiMKDWF1ZGlvX3NhbXBsZXMYAiADKAxSDGF1ZGlvU2FtcGxlcxI0CgZmb3JtYXQYAyABKAsyHC52b2ljZWJpb21ldHJpY3MuQXVkaW9Gb3JtYXRSBmZvcm1hdBJNCghtZXRhZGF0YRgEIAMoCzIxLnZvaWNlYmlvbWV0cmljcy5FbnJvbGxWb2ljZVJlcXVlc3QuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use enrollVoiceResponseDescriptor instead')
const EnrollVoiceResponse$json = const {
  '1': 'EnrollVoiceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'enrollment_id', '3': 2, '4': 1, '5': 9, '10': 'enrollmentId'},
    const {'1': 'samples_count', '3': 3, '4': 1, '5': 5, '10': 'samplesCount'},
    const {'1': 'quality_score', '3': 4, '4': 1, '5': 2, '10': 'qualityScore'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'voice_profile', '3': 6, '4': 1, '5': 11, '6': '.voicebiometrics.VoiceProfile', '10': 'voiceProfile'},
  ],
};

/// Descriptor for `EnrollVoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollVoiceResponseDescriptor = $convert.base64Decode('ChNFbnJvbGxWb2ljZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIwoNZW5yb2xsbWVudF9pZBgCIAEoCVIMZW5yb2xsbWVudElkEiMKDXNhbXBsZXNfY291bnQYAyABKAVSDHNhbXBsZXNDb3VudBIjCg1xdWFsaXR5X3Njb3JlGAQgASgCUgxxdWFsaXR5U2NvcmUSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZRJCCg12b2ljZV9wcm9maWxlGAYgASgLMh0udm9pY2ViaW9tZXRyaWNzLlZvaWNlUHJvZmlsZVIMdm9pY2VQcm9maWxl');
@$core.Deprecated('Use verifyVoiceRequestDescriptor instead')
const VerifyVoiceRequest$json = const {
  '1': 'VerifyVoiceRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'audio_sample', '3': 2, '4': 1, '5': 12, '10': 'audioSample'},
    const {'1': 'format', '3': 3, '4': 1, '5': 11, '6': '.voicebiometrics.AudioFormat', '10': 'format'},
    const {'1': 'threshold', '3': 4, '4': 1, '5': 2, '10': 'threshold'},
    const {'1': 'metadata', '3': 5, '4': 3, '5': 11, '6': '.voicebiometrics.VerifyVoiceRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': const [VerifyVoiceRequest_MetadataEntry$json],
};

@$core.Deprecated('Use verifyVoiceRequestDescriptor instead')
const VerifyVoiceRequest_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `VerifyVoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyVoiceRequestDescriptor = $convert.base64Decode('ChJWZXJpZnlWb2ljZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiEKDGF1ZGlvX3NhbXBsZRgCIAEoDFILYXVkaW9TYW1wbGUSNAoGZm9ybWF0GAMgASgLMhwudm9pY2ViaW9tZXRyaWNzLkF1ZGlvRm9ybWF0UgZmb3JtYXQSHAoJdGhyZXNob2xkGAQgASgCUgl0aHJlc2hvbGQSTQoIbWV0YWRhdGEYBSADKAsyMS52b2ljZWJpb21ldHJpY3MuVmVyaWZ5Vm9pY2VSZXF1ZXN0Lk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use verifyVoiceResponseDescriptor instead')
const VerifyVoiceResponse$json = const {
  '1': 'VerifyVoiceResponse',
  '2': const [
    const {'1': 'verified', '3': 1, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'similarity_score', '3': 2, '4': 1, '5': 2, '10': 'similarityScore'},
    const {'1': 'confidence', '3': 3, '4': 1, '5': 2, '10': 'confidence'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.voicebiometrics.VerificationStatus', '10': 'status'},
    const {'1': 'verification_timestamp', '3': 6, '4': 1, '5': 3, '10': 'verificationTimestamp'},
  ],
};

/// Descriptor for `VerifyVoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyVoiceResponseDescriptor = $convert.base64Decode('ChNWZXJpZnlWb2ljZVJlc3BvbnNlEhoKCHZlcmlmaWVkGAEgASgIUgh2ZXJpZmllZBIpChBzaW1pbGFyaXR5X3Njb3JlGAIgASgCUg9zaW1pbGFyaXR5U2NvcmUSHgoKY29uZmlkZW5jZRgDIAEoAlIKY29uZmlkZW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlEjsKBnN0YXR1cxgFIAEoDjIjLnZvaWNlYmlvbWV0cmljcy5WZXJpZmljYXRpb25TdGF0dXNSBnN0YXR1cxI1ChZ2ZXJpZmljYXRpb25fdGltZXN0YW1wGAYgASgDUhV2ZXJpZmljYXRpb25UaW1lc3RhbXA=');
@$core.Deprecated('Use checkEnrollmentStatusRequestDescriptor instead')
const CheckEnrollmentStatusRequest$json = const {
  '1': 'CheckEnrollmentStatusRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `CheckEnrollmentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEnrollmentStatusRequestDescriptor = $convert.base64Decode('ChxDaGVja0Vucm9sbG1lbnRTdGF0dXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use checkEnrollmentStatusResponseDescriptor instead')
const CheckEnrollmentStatusResponse$json = const {
  '1': 'CheckEnrollmentStatusResponse',
  '2': const [
    const {'1': 'is_enrolled', '3': 1, '4': 1, '5': 8, '10': 'isEnrolled'},
    const {'1': 'enrollment_id', '3': 2, '4': 1, '5': 9, '10': 'enrollmentId'},
    const {'1': 'enrolled_at', '3': 3, '4': 1, '5': 3, '10': 'enrolledAt'},
    const {'1': 'samples_count', '3': 4, '4': 1, '5': 5, '10': 'samplesCount'},
    const {'1': 'quality_score', '3': 5, '4': 1, '5': 2, '10': 'qualityScore'},
    const {'1': 'voice_profile', '3': 6, '4': 1, '5': 11, '6': '.voicebiometrics.VoiceProfile', '10': 'voiceProfile'},
  ],
};

/// Descriptor for `CheckEnrollmentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEnrollmentStatusResponseDescriptor = $convert.base64Decode('Ch1DaGVja0Vucm9sbG1lbnRTdGF0dXNSZXNwb25zZRIfCgtpc19lbnJvbGxlZBgBIAEoCFIKaXNFbnJvbGxlZBIjCg1lbnJvbGxtZW50X2lkGAIgASgJUgxlbnJvbGxtZW50SWQSHwoLZW5yb2xsZWRfYXQYAyABKANSCmVucm9sbGVkQXQSIwoNc2FtcGxlc19jb3VudBgEIAEoBVIMc2FtcGxlc0NvdW50EiMKDXF1YWxpdHlfc2NvcmUYBSABKAJSDHF1YWxpdHlTY29yZRJCCg12b2ljZV9wcm9maWxlGAYgASgLMh0udm9pY2ViaW9tZXRyaWNzLlZvaWNlUHJvZmlsZVIMdm9pY2VQcm9maWxl');
@$core.Deprecated('Use deleteVoiceEnrollmentRequestDescriptor instead')
const DeleteVoiceEnrollmentRequest$json = const {
  '1': 'DeleteVoiceEnrollmentRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `DeleteVoiceEnrollmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteVoiceEnrollmentRequestDescriptor = $convert.base64Decode('ChxEZWxldGVWb2ljZUVucm9sbG1lbnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use deleteVoiceEnrollmentResponseDescriptor instead')
const DeleteVoiceEnrollmentResponse$json = const {
  '1': 'DeleteVoiceEnrollmentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteVoiceEnrollmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteVoiceEnrollmentResponseDescriptor = $convert.base64Decode('Ch1EZWxldGVWb2ljZUVucm9sbG1lbnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use updateVoiceEnrollmentRequestDescriptor instead')
const UpdateVoiceEnrollmentRequest$json = const {
  '1': 'UpdateVoiceEnrollmentRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'audio_samples', '3': 2, '4': 3, '5': 12, '10': 'audioSamples'},
    const {'1': 'format', '3': 3, '4': 1, '5': 11, '6': '.voicebiometrics.AudioFormat', '10': 'format'},
  ],
};

/// Descriptor for `UpdateVoiceEnrollmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateVoiceEnrollmentRequestDescriptor = $convert.base64Decode('ChxVcGRhdGVWb2ljZUVucm9sbG1lbnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIjCg1hdWRpb19zYW1wbGVzGAIgAygMUgxhdWRpb1NhbXBsZXMSNAoGZm9ybWF0GAMgASgLMhwudm9pY2ViaW9tZXRyaWNzLkF1ZGlvRm9ybWF0UgZmb3JtYXQ=');
@$core.Deprecated('Use updateVoiceEnrollmentResponseDescriptor instead')
const UpdateVoiceEnrollmentResponse$json = const {
  '1': 'UpdateVoiceEnrollmentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'new_samples_count', '3': 2, '4': 1, '5': 5, '10': 'newSamplesCount'},
    const {'1': 'updated_quality_score', '3': 3, '4': 1, '5': 2, '10': 'updatedQualityScore'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateVoiceEnrollmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateVoiceEnrollmentResponseDescriptor = $convert.base64Decode('Ch1VcGRhdGVWb2ljZUVucm9sbG1lbnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEioKEW5ld19zYW1wbGVzX2NvdW50GAIgASgFUg9uZXdTYW1wbGVzQ291bnQSMgoVdXBkYXRlZF9xdWFsaXR5X3Njb3JlGAMgASgCUhN1cGRhdGVkUXVhbGl0eVNjb3JlEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getVoiceEnrollmentRequestDescriptor instead')
const GetVoiceEnrollmentRequest$json = const {
  '1': 'GetVoiceEnrollmentRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetVoiceEnrollmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVoiceEnrollmentRequestDescriptor = $convert.base64Decode('ChlHZXRWb2ljZUVucm9sbG1lbnRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use getVoiceEnrollmentResponseDescriptor instead')
const GetVoiceEnrollmentResponse$json = const {
  '1': 'GetVoiceEnrollmentResponse',
  '2': const [
    const {'1': 'exists', '3': 1, '4': 1, '5': 8, '10': 'exists'},
    const {'1': 'voice_profile', '3': 2, '4': 1, '5': 11, '6': '.voicebiometrics.VoiceProfile', '10': 'voiceProfile'},
    const {'1': 'metadata', '3': 3, '4': 1, '5': 11, '6': '.voicebiometrics.EnrollmentMetadata', '10': 'metadata'},
  ],
};

/// Descriptor for `GetVoiceEnrollmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVoiceEnrollmentResponseDescriptor = $convert.base64Decode('ChpHZXRWb2ljZUVucm9sbG1lbnRSZXNwb25zZRIWCgZleGlzdHMYASABKAhSBmV4aXN0cxJCCg12b2ljZV9wcm9maWxlGAIgASgLMh0udm9pY2ViaW9tZXRyaWNzLlZvaWNlUHJvZmlsZVIMdm9pY2VQcm9maWxlEj8KCG1ldGFkYXRhGAMgASgLMiMudm9pY2ViaW9tZXRyaWNzLkVucm9sbG1lbnRNZXRhZGF0YVIIbWV0YWRhdGE=');
@$core.Deprecated('Use voiceProfileDescriptor instead')
const VoiceProfile$json = const {
  '1': 'VoiceProfile',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'enrollment_id', '3': 2, '4': 1, '5': 9, '10': 'enrollmentId'},
    const {'1': 'created_at', '3': 3, '4': 1, '5': 3, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 4, '4': 1, '5': 3, '10': 'updatedAt'},
    const {'1': 'samples_count', '3': 5, '4': 1, '5': 5, '10': 'samplesCount'},
    const {'1': 'quality_score', '3': 6, '4': 1, '5': 2, '10': 'qualityScore'},
    const {'1': 'verification_count', '3': 7, '4': 1, '5': 5, '10': 'verificationCount'},
    const {'1': 'last_verified_at', '3': 8, '4': 1, '5': 3, '10': 'lastVerifiedAt'},
  ],
};

/// Descriptor for `VoiceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voiceProfileDescriptor = $convert.base64Decode('CgxWb2ljZVByb2ZpbGUSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiMKDWVucm9sbG1lbnRfaWQYAiABKAlSDGVucm9sbG1lbnRJZBIdCgpjcmVhdGVkX2F0GAMgASgDUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgEIAEoA1IJdXBkYXRlZEF0EiMKDXNhbXBsZXNfY291bnQYBSABKAVSDHNhbXBsZXNDb3VudBIjCg1xdWFsaXR5X3Njb3JlGAYgASgCUgxxdWFsaXR5U2NvcmUSLQoSdmVyaWZpY2F0aW9uX2NvdW50GAcgASgFUhF2ZXJpZmljYXRpb25Db3VudBIoChBsYXN0X3ZlcmlmaWVkX2F0GAggASgDUg5sYXN0VmVyaWZpZWRBdA==');
@$core.Deprecated('Use enrollmentMetadataDescriptor instead')
const EnrollmentMetadata$json = const {
  '1': 'EnrollmentMetadata',
  '2': const [
    const {'1': 'device_info', '3': 1, '4': 1, '5': 9, '10': 'deviceInfo'},
    const {'1': 'audio_quality', '3': 2, '4': 1, '5': 9, '10': 'audioQuality'},
    const {'1': 'sample_ids', '3': 3, '4': 3, '5': 9, '10': 'sampleIds'},
    const {'1': 'custom_fields', '3': 4, '4': 3, '5': 11, '6': '.voicebiometrics.EnrollmentMetadata.CustomFieldsEntry', '10': 'customFields'},
  ],
  '3': const [EnrollmentMetadata_CustomFieldsEntry$json],
};

@$core.Deprecated('Use enrollmentMetadataDescriptor instead')
const EnrollmentMetadata_CustomFieldsEntry$json = const {
  '1': 'CustomFieldsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `EnrollmentMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enrollmentMetadataDescriptor = $convert.base64Decode('ChJFbnJvbGxtZW50TWV0YWRhdGESHwoLZGV2aWNlX2luZm8YASABKAlSCmRldmljZUluZm8SIwoNYXVkaW9fcXVhbGl0eRgCIAEoCVIMYXVkaW9RdWFsaXR5Eh0KCnNhbXBsZV9pZHMYAyADKAlSCXNhbXBsZUlkcxJaCg1jdXN0b21fZmllbGRzGAQgAygLMjUudm9pY2ViaW9tZXRyaWNzLkVucm9sbG1lbnRNZXRhZGF0YS5DdXN0b21GaWVsZHNFbnRyeVIMY3VzdG9tRmllbGRzGj8KEUN1c3RvbUZpZWxkc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use audioFormatDescriptor instead')
const AudioFormat$json = const {
  '1': 'AudioFormat',
  '2': const [
    const {'1': 'codec', '3': 1, '4': 1, '5': 9, '10': 'codec'},
    const {'1': 'sample_rate', '3': 2, '4': 1, '5': 5, '10': 'sampleRate'},
    const {'1': 'channels', '3': 3, '4': 1, '5': 5, '10': 'channels'},
    const {'1': 'bit_depth', '3': 4, '4': 1, '5': 5, '10': 'bitDepth'},
  ],
};

/// Descriptor for `AudioFormat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioFormatDescriptor = $convert.base64Decode('CgtBdWRpb0Zvcm1hdBIUCgVjb2RlYxgBIAEoCVIFY29kZWMSHwoLc2FtcGxlX3JhdGUYAiABKAVSCnNhbXBsZVJhdGUSGgoIY2hhbm5lbHMYAyABKAVSCGNoYW5uZWxzEhsKCWJpdF9kZXB0aBgEIAEoBVIIYml0RGVwdGg=');
