///
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'role', '3': 6, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'verified', '3': 7, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'is_email_verified', '3': 8, '4': 1, '5': 8, '10': 'isEmailVerified'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgEUgJpZBIdCgpmaXJzdF9uYW1lGAIgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAMgASgJUghsYXN0TmFtZRIUCgVlbWFpbBgEIAEoCVIFZW1haWwSIQoMcGhvbmVfbnVtYmVyGAUgASgJUgtwaG9uZU51bWJlchISCgRyb2xlGAYgASgJUgRyb2xlEhoKCHZlcmlmaWVkGAcgASgIUgh2ZXJpZmllZBIqChFpc19lbWFpbF92ZXJpZmllZBgIIAEoCFIPaXNFbWFpbFZlcmlmaWVkEjkKCmNyZWF0ZWRfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use dataDescriptor instead')
const Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '9': 0, '10': 'user', '17': true},
    const {'1': 'session', '3': 2, '4': 1, '5': 11, '6': '.pb.Session', '9': 1, '10': 'session', '17': true},
  ],
  '8': const [
    const {'1': '_user'},
    const {'1': '_session'},
  ],
};

/// Descriptor for `Data`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataDescriptor = $convert.base64Decode('CgREYXRhEiEKBHVzZXIYASABKAsyCC5wYi5Vc2VySABSBHVzZXKIAQESKgoHc2Vzc2lvbhgCIAEoCzILLnBiLlNlc3Npb25IAVIHc2Vzc2lvbogBAUIHCgVfdXNlckIKCghfc2Vzc2lvbg==');
@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'access_token_expires_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'accessTokenExpiresAt'},
    const {'1': 'refresh_token_expires_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'refreshTokenExpiresAt'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode('CgdTZXNzaW9uEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZXNoX3Rva2VuGAQgASgJUgxyZWZyZXNoVG9rZW4SUQoXYWNjZXNzX3Rva2VuX2V4cGlyZXNfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUhRhY2Nlc3NUb2tlbkV4cGlyZXNBdBJTChhyZWZyZXNoX3Rva2VuX2V4cGlyZXNfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUhVyZWZyZXNoVG9rZW5FeHBpcmVzQXQ=');
