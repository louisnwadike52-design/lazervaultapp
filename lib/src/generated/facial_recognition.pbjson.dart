///
//  Generated code. Do not modify.
//  source: facial_recognition.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use registerFaceRequestDescriptor instead')
const RegisterFaceRequest$json = const {
  '1': 'RegisterFaceRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'user_id'},
    const {'1': 'face_id', '3': 2, '4': 1, '5': 9, '10': 'face_id'},
    const {'1': 'allow_duplicates', '3': 3, '4': 1, '5': 8, '10': 'allow_duplicates'},
    const {'1': 'duplicate_threshold', '3': 4, '4': 1, '5': 1, '10': 'duplicate_threshold'},
    const {'1': 'image_data', '3': 5, '4': 1, '5': 12, '10': 'image_data'},
    const {'1': 'image_filename', '3': 6, '4': 1, '5': 9, '10': 'image_filename'},
    const {'1': 'image_content_type', '3': 7, '4': 1, '5': 9, '10': 'image_content_type'},
  ],
  '7': const {},
};

/// Descriptor for `RegisterFaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerFaceRequestDescriptor = $convert.base64Decode('ChNSZWdpc3RlckZhY2VSZXF1ZXN0EhgKB3VzZXJfaWQYASABKAlSB3VzZXJfaWQSGAoHZmFjZV9pZBgCIAEoCVIHZmFjZV9pZBIqChBhbGxvd19kdXBsaWNhdGVzGAMgASgIUhBhbGxvd19kdXBsaWNhdGVzEjAKE2R1cGxpY2F0ZV90aHJlc2hvbGQYBCABKAFSE2R1cGxpY2F0ZV90aHJlc2hvbGQSHgoKaW1hZ2VfZGF0YRgFIAEoDFIKaW1hZ2VfZGF0YRImCg5pbWFnZV9maWxlbmFtZRgGIAEoCVIOaW1hZ2VfZmlsZW5hbWUSLgoSaW1hZ2VfY29udGVudF90eXBlGAcgASgJUhJpbWFnZV9jb250ZW50X3R5cGU6apJBZwplKhVSZWdpc3RlciBGYWNlIFJlcXVlc3QyNVJlcXVlc3QgdG8gcmVnaXN0ZXIgYSBuZXcgZmFjZSBmb3IgZmFjaWFsIHJlY29nbml0aW9u0gEHdXNlcl9pZNIBCmltYWdlX2RhdGE=');
@$core.Deprecated('Use registerFaceResponseDescriptor instead')
const RegisterFaceResponse$json = const {
  '1': 'RegisterFaceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'face_id', '3': 2, '4': 1, '5': 9, '10': 'faceId'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'error', '3': 4, '4': 1, '5': 9, '10': 'error'},
    const {'1': 'num_faces_detected', '3': 5, '4': 1, '5': 5, '10': 'numFacesDetected'},
    const {'1': 'duplicate_details', '3': 6, '4': 1, '5': 11, '6': '.pb.DuplicateDetails', '10': 'duplicateDetails'},
  ],
};

/// Descriptor for `RegisterFaceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerFaceResponseDescriptor = $convert.base64Decode('ChRSZWdpc3RlckZhY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhcKB2ZhY2VfaWQYAiABKAlSBmZhY2VJZBIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEhQKBWVycm9yGAQgASgJUgVlcnJvchIsChJudW1fZmFjZXNfZGV0ZWN0ZWQYBSABKAVSEG51bUZhY2VzRGV0ZWN0ZWQSQQoRZHVwbGljYXRlX2RldGFpbHMYBiABKAsyFC5wYi5EdXBsaWNhdGVEZXRhaWxzUhBkdXBsaWNhdGVEZXRhaWxz');
@$core.Deprecated('Use verifyFaceRequestDescriptor instead')
const VerifyFaceRequest$json = const {
  '1': 'VerifyFaceRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'user_id'},
    const {'1': 'threshold', '3': 2, '4': 1, '5': 1, '10': 'threshold'},
    const {'1': 'image_data', '3': 3, '4': 1, '5': 12, '10': 'image_data'},
    const {'1': 'image_filename', '3': 4, '4': 1, '5': 9, '10': 'image_filename'},
    const {'1': 'image_content_type', '3': 5, '4': 1, '5': 9, '10': 'image_content_type'},
  ],
  '7': const {},
};

/// Descriptor for `VerifyFaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyFaceRequestDescriptor = $convert.base64Decode('ChFWZXJpZnlGYWNlUmVxdWVzdBIYCgd1c2VyX2lkGAEgASgJUgd1c2VyX2lkEhwKCXRocmVzaG9sZBgCIAEoAVIJdGhyZXNob2xkEh4KCmltYWdlX2RhdGEYAyABKAxSCmltYWdlX2RhdGESJgoOaW1hZ2VfZmlsZW5hbWUYBCABKAlSDmltYWdlX2ZpbGVuYW1lEi4KEmltYWdlX2NvbnRlbnRfdHlwZRgFIAEoCVISaW1hZ2VfY29udGVudF90eXBlOmuSQWgKZioTVmVyaWZ5IEZhY2UgUmVxdWVzdDI4UmVxdWVzdCB0byB2ZXJpZnkgYSB1c2VyJ3MgZmFjZSBhZ2FpbnN0IHJlZ2lzdGVyZWQgZmFjZXPSAQd1c2VyX2lk0gEKaW1hZ2VfZGF0YQ==');
@$core.Deprecated('Use verifyFaceResponseDescriptor instead')
const VerifyFaceResponse$json = const {
  '1': 'VerifyFaceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'confidence', '3': 3, '4': 1, '5': 1, '10': 'confidence'},
    const {'1': 'matched_face_id', '3': 4, '4': 1, '5': 9, '10': 'matchedFaceId'},
    const {'1': 'threshold', '3': 5, '4': 1, '5': 1, '10': 'threshold'},
    const {'1': 'distance', '3': 6, '4': 1, '5': 1, '10': 'distance'},
    const {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'error', '3': 8, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `VerifyFaceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyFaceResponseDescriptor = $convert.base64Decode('ChJWZXJpZnlGYWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIaCgh2ZXJpZmllZBgCIAEoCFIIdmVyaWZpZWQSHgoKY29uZmlkZW5jZRgDIAEoAVIKY29uZmlkZW5jZRImCg9tYXRjaGVkX2ZhY2VfaWQYBCABKAlSDW1hdGNoZWRGYWNlSWQSHAoJdGhyZXNob2xkGAUgASgBUgl0aHJlc2hvbGQSGgoIZGlzdGFuY2UYBiABKAFSCGRpc3RhbmNlEhgKB21lc3NhZ2UYByABKAlSB21lc3NhZ2USFAoFZXJyb3IYCCABKAlSBWVycm9y');
@$core.Deprecated('Use duplicateDetailsDescriptor instead')
const DuplicateDetails$json = const {
  '1': 'DuplicateDetails',
  '2': const [
    const {'1': 'is_duplicate', '3': 1, '4': 1, '5': 8, '10': 'isDuplicate'},
    const {'1': 'threshold', '3': 2, '4': 1, '5': 1, '10': 'threshold'},
    const {'1': 'total_matches', '3': 3, '4': 1, '5': 5, '10': 'totalMatches'},
    const {'1': 'primary_match', '3': 4, '4': 1, '5': 11, '6': '.pb.PrimaryMatch', '10': 'primaryMatch'},
    const {'1': 'all_matches', '3': 5, '4': 3, '5': 11, '6': '.pb.Match', '10': 'allMatches'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'security_note', '3': 7, '4': 1, '5': 9, '10': 'securityNote'},
  ],
};

/// Descriptor for `DuplicateDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List duplicateDetailsDescriptor = $convert.base64Decode('ChBEdXBsaWNhdGVEZXRhaWxzEiEKDGlzX2R1cGxpY2F0ZRgBIAEoCFILaXNEdXBsaWNhdGUSHAoJdGhyZXNob2xkGAIgASgBUgl0aHJlc2hvbGQSIwoNdG90YWxfbWF0Y2hlcxgDIAEoBVIMdG90YWxNYXRjaGVzEjUKDXByaW1hcnlfbWF0Y2gYBCABKAsyEC5wYi5QcmltYXJ5TWF0Y2hSDHByaW1hcnlNYXRjaBIqCgthbGxfbWF0Y2hlcxgFIAMoCzIJLnBiLk1hdGNoUgphbGxNYXRjaGVzEhgKB21lc3NhZ2UYBiABKAlSB21lc3NhZ2USIwoNc2VjdXJpdHlfbm90ZRgHIAEoCVIMc2VjdXJpdHlOb3Rl');
@$core.Deprecated('Use primaryMatchDescriptor instead')
const PrimaryMatch$json = const {
  '1': 'PrimaryMatch',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'face_id', '3': 2, '4': 1, '5': 9, '10': 'faceId'},
    const {'1': 'confidence', '3': 3, '4': 1, '5': 1, '10': 'confidence'},
    const {'1': 'registered_at', '3': 4, '4': 1, '5': 9, '10': 'registeredAt'},
  ],
};

/// Descriptor for `PrimaryMatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List primaryMatchDescriptor = $convert.base64Decode('CgxQcmltYXJ5TWF0Y2gSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhcKB2ZhY2VfaWQYAiABKAlSBmZhY2VJZBIeCgpjb25maWRlbmNlGAMgASgBUgpjb25maWRlbmNlEiMKDXJlZ2lzdGVyZWRfYXQYBCABKAlSDHJlZ2lzdGVyZWRBdA==');
@$core.Deprecated('Use matchDescriptor instead')
const Match$json = const {
  '1': 'Match',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'face_id', '3': 2, '4': 1, '5': 9, '10': 'faceId'},
    const {'1': 'confidence', '3': 3, '4': 1, '5': 1, '10': 'confidence'},
    const {'1': 'registered_at', '3': 4, '4': 1, '5': 9, '10': 'registeredAt'},
  ],
};

/// Descriptor for `Match`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchDescriptor = $convert.base64Decode('CgVNYXRjaBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFwoHZmFjZV9pZBgCIAEoCVIGZmFjZUlkEh4KCmNvbmZpZGVuY2UYAyABKAFSCmNvbmZpZGVuY2USIwoNcmVnaXN0ZXJlZF9hdBgEIAEoCVIMcmVnaXN0ZXJlZEF0');
@$core.Deprecated('Use healthCheckRequestDescriptor instead')
const HealthCheckRequest$json = const {
  '1': 'HealthCheckRequest',
};

/// Descriptor for `HealthCheckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckRequestDescriptor = $convert.base64Decode('ChJIZWFsdGhDaGVja1JlcXVlc3Q=');
@$core.Deprecated('Use healthCheckResponseDescriptor instead')
const HealthCheckResponse$json = const {
  '1': 'HealthCheckResponse',
  '2': const [
    const {'1': 'healthy', '3': 1, '4': 1, '5': 8, '10': 'healthy'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'service_version', '3': 3, '4': 1, '5': 9, '10': 'service_version'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `HealthCheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckResponseDescriptor = $convert.base64Decode('ChNIZWFsdGhDaGVja1Jlc3BvbnNlEhgKB2hlYWx0aHkYASABKAhSB2hlYWx0aHkSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCg9zZXJ2aWNlX3ZlcnNpb24YAyABKAlSD3NlcnZpY2VfdmVyc2lvbhI4Cgl0aW1lc3RhbXAYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXA=');
