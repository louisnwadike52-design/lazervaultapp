//
//  Generated code. Do not modify.
//  source: facial_recognition.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use registerFaceRequestDescriptor instead')
const RegisterFaceRequest$json = {
  '1': 'RegisterFaceRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'user_id'},
    {'1': 'face_id', '3': 2, '4': 1, '5': 9, '10': 'face_id'},
    {'1': 'allow_duplicates', '3': 3, '4': 1, '5': 8, '10': 'allow_duplicates'},
    {'1': 'duplicate_threshold', '3': 4, '4': 1, '5': 1, '10': 'duplicate_threshold'},
    {'1': 'image_data', '3': 5, '4': 1, '5': 12, '10': 'image_data'},
    {'1': 'image_filename', '3': 6, '4': 1, '5': 9, '10': 'image_filename'},
    {'1': 'image_content_type', '3': 7, '4': 1, '5': 9, '10': 'image_content_type'},
  ],
  '7': {},
};

/// Descriptor for `RegisterFaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerFaceRequestDescriptor = $convert.base64Decode(
    'ChNSZWdpc3RlckZhY2VSZXF1ZXN0EhgKB3VzZXJfaWQYASABKAlSB3VzZXJfaWQSGAoHZmFjZV'
    '9pZBgCIAEoCVIHZmFjZV9pZBIqChBhbGxvd19kdXBsaWNhdGVzGAMgASgIUhBhbGxvd19kdXBs'
    'aWNhdGVzEjAKE2R1cGxpY2F0ZV90aHJlc2hvbGQYBCABKAFSE2R1cGxpY2F0ZV90aHJlc2hvbG'
    'QSHgoKaW1hZ2VfZGF0YRgFIAEoDFIKaW1hZ2VfZGF0YRImCg5pbWFnZV9maWxlbmFtZRgGIAEo'
    'CVIOaW1hZ2VfZmlsZW5hbWUSLgoSaW1hZ2VfY29udGVudF90eXBlGAcgASgJUhJpbWFnZV9jb2'
    '50ZW50X3R5cGU6apJBZwplKhVSZWdpc3RlciBGYWNlIFJlcXVlc3QyNVJlcXVlc3QgdG8gcmVn'
    'aXN0ZXIgYSBuZXcgZmFjZSBmb3IgZmFjaWFsIHJlY29nbml0aW9u0gEHdXNlcl9pZNIBCmltYW'
    'dlX2RhdGE=');

@$core.Deprecated('Use registerFaceResponseDescriptor instead')
const RegisterFaceResponse$json = {
  '1': 'RegisterFaceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'face_id', '3': 2, '4': 1, '5': 9, '10': 'faceId'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'error', '3': 4, '4': 1, '5': 9, '10': 'error'},
    {'1': 'num_faces_detected', '3': 5, '4': 1, '5': 5, '10': 'numFacesDetected'},
    {'1': 'duplicate_details', '3': 6, '4': 1, '5': 11, '6': '.pb.DuplicateDetails', '10': 'duplicateDetails'},
  ],
};

/// Descriptor for `RegisterFaceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerFaceResponseDescriptor = $convert.base64Decode(
    'ChRSZWdpc3RlckZhY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhcKB2ZhY2'
    'VfaWQYAiABKAlSBmZhY2VJZBIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEhQKBWVycm9yGAQg'
    'ASgJUgVlcnJvchIsChJudW1fZmFjZXNfZGV0ZWN0ZWQYBSABKAVSEG51bUZhY2VzRGV0ZWN0ZW'
    'QSQQoRZHVwbGljYXRlX2RldGFpbHMYBiABKAsyFC5wYi5EdXBsaWNhdGVEZXRhaWxzUhBkdXBs'
    'aWNhdGVEZXRhaWxz');

@$core.Deprecated('Use verifyFaceRequestDescriptor instead')
const VerifyFaceRequest$json = {
  '1': 'VerifyFaceRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'user_id'},
    {'1': 'threshold', '3': 2, '4': 1, '5': 1, '10': 'threshold'},
    {'1': 'image_data', '3': 3, '4': 1, '5': 12, '10': 'image_data'},
    {'1': 'image_filename', '3': 4, '4': 1, '5': 9, '10': 'image_filename'},
    {'1': 'image_content_type', '3': 5, '4': 1, '5': 9, '10': 'image_content_type'},
  ],
  '7': {},
};

/// Descriptor for `VerifyFaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyFaceRequestDescriptor = $convert.base64Decode(
    'ChFWZXJpZnlGYWNlUmVxdWVzdBIYCgd1c2VyX2lkGAEgASgJUgd1c2VyX2lkEhwKCXRocmVzaG'
    '9sZBgCIAEoAVIJdGhyZXNob2xkEh4KCmltYWdlX2RhdGEYAyABKAxSCmltYWdlX2RhdGESJgoO'
    'aW1hZ2VfZmlsZW5hbWUYBCABKAlSDmltYWdlX2ZpbGVuYW1lEi4KEmltYWdlX2NvbnRlbnRfdH'
    'lwZRgFIAEoCVISaW1hZ2VfY29udGVudF90eXBlOmuSQWgKZioTVmVyaWZ5IEZhY2UgUmVxdWVz'
    'dDI4UmVxdWVzdCB0byB2ZXJpZnkgYSB1c2VyJ3MgZmFjZSBhZ2FpbnN0IHJlZ2lzdGVyZWQgZm'
    'FjZXPSAQd1c2VyX2lk0gEKaW1hZ2VfZGF0YQ==');

@$core.Deprecated('Use verifyFaceResponseDescriptor instead')
const VerifyFaceResponse$json = {
  '1': 'VerifyFaceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'confidence', '3': 3, '4': 1, '5': 1, '10': 'confidence'},
    {'1': 'matched_face_id', '3': 4, '4': 1, '5': 9, '10': 'matchedFaceId'},
    {'1': 'threshold', '3': 5, '4': 1, '5': 1, '10': 'threshold'},
    {'1': 'distance', '3': 6, '4': 1, '5': 1, '10': 'distance'},
    {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
    {'1': 'error', '3': 8, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `VerifyFaceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyFaceResponseDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlGYWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIaCgh2ZXJpZm'
    'llZBgCIAEoCFIIdmVyaWZpZWQSHgoKY29uZmlkZW5jZRgDIAEoAVIKY29uZmlkZW5jZRImCg9t'
    'YXRjaGVkX2ZhY2VfaWQYBCABKAlSDW1hdGNoZWRGYWNlSWQSHAoJdGhyZXNob2xkGAUgASgBUg'
    'l0aHJlc2hvbGQSGgoIZGlzdGFuY2UYBiABKAFSCGRpc3RhbmNlEhgKB21lc3NhZ2UYByABKAlS'
    'B21lc3NhZ2USFAoFZXJyb3IYCCABKAlSBWVycm9y');

@$core.Deprecated('Use duplicateDetailsDescriptor instead')
const DuplicateDetails$json = {
  '1': 'DuplicateDetails',
  '2': [
    {'1': 'is_duplicate', '3': 1, '4': 1, '5': 8, '10': 'isDuplicate'},
    {'1': 'threshold', '3': 2, '4': 1, '5': 1, '10': 'threshold'},
    {'1': 'total_matches', '3': 3, '4': 1, '5': 5, '10': 'totalMatches'},
    {'1': 'primary_match', '3': 4, '4': 1, '5': 11, '6': '.pb.PrimaryMatch', '10': 'primaryMatch'},
    {'1': 'all_matches', '3': 5, '4': 3, '5': 11, '6': '.pb.Match', '10': 'allMatches'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    {'1': 'security_note', '3': 7, '4': 1, '5': 9, '10': 'securityNote'},
  ],
};

/// Descriptor for `DuplicateDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List duplicateDetailsDescriptor = $convert.base64Decode(
    'ChBEdXBsaWNhdGVEZXRhaWxzEiEKDGlzX2R1cGxpY2F0ZRgBIAEoCFILaXNEdXBsaWNhdGUSHA'
    'oJdGhyZXNob2xkGAIgASgBUgl0aHJlc2hvbGQSIwoNdG90YWxfbWF0Y2hlcxgDIAEoBVIMdG90'
    'YWxNYXRjaGVzEjUKDXByaW1hcnlfbWF0Y2gYBCABKAsyEC5wYi5QcmltYXJ5TWF0Y2hSDHByaW'
    '1hcnlNYXRjaBIqCgthbGxfbWF0Y2hlcxgFIAMoCzIJLnBiLk1hdGNoUgphbGxNYXRjaGVzEhgK'
    'B21lc3NhZ2UYBiABKAlSB21lc3NhZ2USIwoNc2VjdXJpdHlfbm90ZRgHIAEoCVIMc2VjdXJpdH'
    'lOb3Rl');

@$core.Deprecated('Use primaryMatchDescriptor instead')
const PrimaryMatch$json = {
  '1': 'PrimaryMatch',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'face_id', '3': 2, '4': 1, '5': 9, '10': 'faceId'},
    {'1': 'confidence', '3': 3, '4': 1, '5': 1, '10': 'confidence'},
    {'1': 'registered_at', '3': 4, '4': 1, '5': 9, '10': 'registeredAt'},
  ],
};

/// Descriptor for `PrimaryMatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List primaryMatchDescriptor = $convert.base64Decode(
    'CgxQcmltYXJ5TWF0Y2gSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhcKB2ZhY2VfaWQYAiABKA'
    'lSBmZhY2VJZBIeCgpjb25maWRlbmNlGAMgASgBUgpjb25maWRlbmNlEiMKDXJlZ2lzdGVyZWRf'
    'YXQYBCABKAlSDHJlZ2lzdGVyZWRBdA==');

@$core.Deprecated('Use matchDescriptor instead')
const Match$json = {
  '1': 'Match',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'face_id', '3': 2, '4': 1, '5': 9, '10': 'faceId'},
    {'1': 'confidence', '3': 3, '4': 1, '5': 1, '10': 'confidence'},
    {'1': 'registered_at', '3': 4, '4': 1, '5': 9, '10': 'registeredAt'},
  ],
};

/// Descriptor for `Match`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchDescriptor = $convert.base64Decode(
    'CgVNYXRjaBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFwoHZmFjZV9pZBgCIAEoCVIGZmFjZU'
    'lkEh4KCmNvbmZpZGVuY2UYAyABKAFSCmNvbmZpZGVuY2USIwoNcmVnaXN0ZXJlZF9hdBgEIAEo'
    'CVIMcmVnaXN0ZXJlZEF0');

@$core.Deprecated('Use healthCheckRequestDescriptor instead')
const HealthCheckRequest$json = {
  '1': 'HealthCheckRequest',
};

/// Descriptor for `HealthCheckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckRequestDescriptor = $convert.base64Decode(
    'ChJIZWFsdGhDaGVja1JlcXVlc3Q=');

@$core.Deprecated('Use healthCheckResponseDescriptor instead')
const HealthCheckResponse$json = {
  '1': 'HealthCheckResponse',
  '2': [
    {'1': 'healthy', '3': 1, '4': 1, '5': 8, '10': 'healthy'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'service_version', '3': 3, '4': 1, '5': 9, '10': 'service_version'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `HealthCheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckResponseDescriptor = $convert.base64Decode(
    'ChNIZWFsdGhDaGVja1Jlc3BvbnNlEhgKB2hlYWx0aHkYASABKAhSB2hlYWx0aHkSGAoHbWVzc2'
    'FnZRgCIAEoCVIHbWVzc2FnZRIoCg9zZXJ2aWNlX3ZlcnNpb24YAyABKAlSD3NlcnZpY2VfdmVy'
    'c2lvbhI4Cgl0aW1lc3RhbXAYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW'
    '1lc3RhbXA=');

