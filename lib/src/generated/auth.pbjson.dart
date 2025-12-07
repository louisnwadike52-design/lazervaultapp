///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = const {
  '1': 'LoginRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode('CgxMb2dpblJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3N3b3JkGAIgASgJUghwYXNzd29yZA==');
@$core.Deprecated('Use loginWithPasscodeRequestDescriptor instead')
const LoginWithPasscodeRequest$json = const {
  '1': 'LoginWithPasscodeRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'login_passcode', '3': 2, '4': 1, '5': 9, '10': 'loginPasscode'},
  ],
};

/// Descriptor for `LoginWithPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginWithPasscodeRequestDescriptor = $convert.base64Decode('ChhMb2dpbldpdGhQYXNzY29kZVJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEiUKDmxvZ2luX3Bhc3Njb2RlGAIgASgJUg1sb2dpblBhc3Njb2Rl');
@$core.Deprecated('Use registerPasscodeRequestDescriptor instead')
const RegisterPasscodeRequest$json = const {
  '1': 'RegisterPasscodeRequest',
  '2': const [
    const {'1': 'login_passcode', '3': 1, '4': 1, '5': 9, '10': 'loginPasscode'},
  ],
};

/// Descriptor for `RegisterPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPasscodeRequestDescriptor = $convert.base64Decode('ChdSZWdpc3RlclBhc3Njb2RlUmVxdWVzdBIlCg5sb2dpbl9wYXNzY29kZRgBIAEoCVINbG9naW5QYXNzY29kZQ==');
@$core.Deprecated('Use registerPasscodeResponseDescriptor instead')
const RegisterPasscodeResponse$json = const {
  '1': 'RegisterPasscodeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RegisterPasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPasscodeResponseDescriptor = $convert.base64Decode('ChhSZWdpc3RlclBhc3Njb2RlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAiABKAlSA21zZw==');
@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.pb.Data', '10': 'data'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode('Cg1Mb2dpblJlc3BvbnNlEhwKBGRhdGEYASABKAsyCC5wYi5EYXRhUgRkYXRhEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJUgNtc2c=');
@$core.Deprecated('Use refreshTokenRequestDescriptor instead')
const RefreshTokenRequest$json = const {
  '1': 'RefreshTokenRequest',
  '2': const [
    const {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `RefreshTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenRequestDescriptor = $convert.base64Decode('ChNSZWZyZXNoVG9rZW5SZXF1ZXN0EiMKDXJlZnJlc2hfdG9rZW4YASABKAlSDHJlZnJlc2hUb2tlbg==');
@$core.Deprecated('Use refreshTokenResponseDescriptor instead')
const RefreshTokenResponse$json = const {
  '1': 'RefreshTokenResponse',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 11, '6': '.pb.Data', '10': 'data'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RefreshTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenResponseDescriptor = $convert.base64Decode('ChRSZWZyZXNoVG9rZW5SZXNwb25zZRIcCgRkYXRhGAEgASgLMggucGIuRGF0YVIEZGF0YRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVIDbXNn');
@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = const {
  '1': 'LogoutRequest',
  '2': const [
    const {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert.base64Decode('Cg1Mb2dvdXRSZXF1ZXN0Eh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb25JZA==');
@$core.Deprecated('Use logoutResponseDescriptor instead')
const LogoutResponse$json = const {
  '1': 'LogoutResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `LogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutResponseDescriptor = $convert.base64Decode('Cg5Mb2dvdXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNn');
@$core.Deprecated('Use requestEmailVerificationRequestDescriptor instead')
const RequestEmailVerificationRequest$json = const {
  '1': 'RequestEmailVerificationRequest',
};

/// Descriptor for `RequestEmailVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestEmailVerificationRequestDescriptor = $convert.base64Decode('Ch9SZXF1ZXN0RW1haWxWZXJpZmljYXRpb25SZXF1ZXN0');
@$core.Deprecated('Use requestEmailVerificationResponseDescriptor instead')
const RequestEmailVerificationResponse$json = const {
  '1': 'RequestEmailVerificationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RequestEmailVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestEmailVerificationResponseDescriptor = $convert.base64Decode('CiBSZXF1ZXN0RW1haWxWZXJpZmljYXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNn');
@$core.Deprecated('Use verifyEmailRequestDescriptor instead')
const VerifyEmailRequest$json = const {
  '1': 'VerifyEmailRequest',
  '2': const [
    const {'1': 'verification_code', '3': 1, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
  '7': const {},
};

/// Descriptor for `VerifyEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailRequestDescriptor = $convert.base64Decode('ChJWZXJpZnlFbWFpbFJlcXVlc3QSKwoRdmVyaWZpY2F0aW9uX2NvZGUYASABKAlSEHZlcmlmaWNhdGlvbkNvZGU6GZJBFgoU0gERdmVyaWZpY2F0aW9uX2NvZGU=');
@$core.Deprecated('Use verifyEmailResponseDescriptor instead')
const VerifyEmailResponse$json = const {
  '1': 'VerifyEmailResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `VerifyEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailResponseDescriptor = $convert.base64Decode('ChNWZXJpZnlFbWFpbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2c=');
@$core.Deprecated('Use requestPasswordResetRequestDescriptor instead')
const RequestPasswordResetRequest$json = const {
  '1': 'RequestPasswordResetRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
  '7': const {},
};

/// Descriptor for `RequestPasswordResetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetRequestDescriptor = $convert.base64Decode('ChtSZXF1ZXN0UGFzc3dvcmRSZXNldFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsOg2SQQoKCNIBBWVtYWls');
@$core.Deprecated('Use requestPasswordResetResponseDescriptor instead')
const RequestPasswordResetResponse$json = const {
  '1': 'RequestPasswordResetResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RequestPasswordResetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetResponseDescriptor = $convert.base64Decode('ChxSZXF1ZXN0UGFzc3dvcmRSZXNldFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2c=');
@$core.Deprecated('Use resetPasswordRequestDescriptor instead')
const ResetPasswordRequest$json = const {
  '1': 'ResetPasswordRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'new_password', '3': 3, '4': 1, '5': 9, '10': 'newPassword'},
  ],
  '7': const {},
};

/// Descriptor for `ResetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordRequestDescriptor = $convert.base64Decode('ChRSZXNldFBhc3N3b3JkUmVxdWVzdBIUCgVlbWFpbBgBIAEoCVIFZW1haWwSFAoFdG9rZW4YAiABKAlSBXRva2VuEiEKDG5ld19wYXNzd29yZBgDIAEoCVILbmV3UGFzc3dvcmQ6JJJBIQof0gEFZW1haWzSAQV0b2tlbtIBDG5ld19wYXNzd29yZA==');
@$core.Deprecated('Use resetPasswordResponseDescriptor instead')
const ResetPasswordResponse$json = const {
  '1': 'ResetPasswordResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `ResetPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordResponseDescriptor = $convert.base64Decode('ChVSZXNldFBhc3N3b3JkUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAiABKAlSA21zZw==');
@$core.Deprecated('Use signInWithGoogleRequestDescriptor instead')
const SignInWithGoogleRequest$json = const {
  '1': 'SignInWithGoogleRequest',
  '2': const [
    const {'1': 'id_token', '3': 1, '4': 1, '5': 9, '10': 'idToken'},
  ],
  '7': const {},
};

/// Descriptor for `SignInWithGoogleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signInWithGoogleRequestDescriptor = $convert.base64Decode('ChdTaWduSW5XaXRoR29vZ2xlUmVxdWVzdBIZCghpZF90b2tlbhgBIAEoCVIHaWRUb2tlbjoQkkENCgvSAQhpZF90b2tlbg==');
@$core.Deprecated('Use signInWithAppleRequestDescriptor instead')
const SignInWithAppleRequest$json = const {
  '1': 'SignInWithAppleRequest',
  '2': const [
    const {'1': 'identity_token', '3': 1, '4': 1, '5': 9, '10': 'identityToken'},
    const {'1': 'user_identifier', '3': 2, '4': 1, '5': 9, '10': 'userIdentifier'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'given_name', '3': 4, '4': 1, '5': 9, '10': 'givenName'},
    const {'1': 'family_name', '3': 5, '4': 1, '5': 9, '10': 'familyName'},
  ],
  '7': const {},
};

/// Descriptor for `SignInWithAppleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signInWithAppleRequestDescriptor = $convert.base64Decode('ChZTaWduSW5XaXRoQXBwbGVSZXF1ZXN0EiUKDmlkZW50aXR5X3Rva2VuGAEgASgJUg1pZGVudGl0eVRva2VuEicKD3VzZXJfaWRlbnRpZmllchgCIAEoCVIOdXNlcklkZW50aWZpZXISFAoFZW1haWwYAyABKAlSBWVtYWlsEh0KCmdpdmVuX25hbWUYBCABKAlSCWdpdmVuTmFtZRIfCgtmYW1pbHlfbmFtZRgFIAEoCVIKZmFtaWx5TmFtZTookkElCiPSAQ5pZGVudGl0eV90b2tlbtIBD3VzZXJfaWRlbnRpZmllcg==');
@$core.Deprecated('Use checkEmailAvailabilityRequestDescriptor instead')
const CheckEmailAvailabilityRequest$json = const {
  '1': 'CheckEmailAvailabilityRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
  '7': const {},
};

/// Descriptor for `CheckEmailAvailabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEmailAvailabilityRequestDescriptor = $convert.base64Decode('Ch1DaGVja0VtYWlsQXZhaWxhYmlsaXR5UmVxdWVzdBIUCgVlbWFpbBgBIAEoCVIFZW1haWw6DZJBCgoI0gEFZW1haWw=');
@$core.Deprecated('Use checkEmailAvailabilityResponseDescriptor instead')
const CheckEmailAvailabilityResponse$json = const {
  '1': 'CheckEmailAvailabilityResponse',
  '2': const [
    const {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CheckEmailAvailabilityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEmailAvailabilityResponseDescriptor = $convert.base64Decode('Ch5DaGVja0VtYWlsQXZhaWxhYmlsaXR5UmVzcG9uc2USHAoJYXZhaWxhYmxlGAEgASgIUglhdmFpbGFibGUSEAoDbXNnGAIgASgJUgNtc2c=');
@$core.Deprecated('Use verifyPinRequestDescriptor instead')
const VerifyPinRequest$json = const {
  '1': 'VerifyPinRequest',
  '2': const [
    const {'1': 'pin', '3': 1, '4': 1, '5': 9, '10': 'pin'},
  ],
  '7': const {},
};

/// Descriptor for `VerifyPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPinRequestDescriptor = $convert.base64Decode('ChBWZXJpZnlQaW5SZXF1ZXN0EhAKA3BpbhgBIAEoCVIDcGluOguSQQgKBtIBA3Bpbg==');
@$core.Deprecated('Use verifyPinResponseDescriptor instead')
const VerifyPinResponse$json = const {
  '1': 'VerifyPinResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `VerifyPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPinResponseDescriptor = $convert.base64Decode('ChFWZXJpZnlQaW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNn');
