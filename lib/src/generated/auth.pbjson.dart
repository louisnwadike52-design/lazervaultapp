///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use primaryContactTypeDescriptor instead')
const PrimaryContactType$json = const {
  '1': 'PrimaryContactType',
  '2': const [
    const {'1': 'EMAIL', '2': 0},
    const {'1': 'PHONE', '2': 1},
  ],
};

/// Descriptor for `PrimaryContactType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List primaryContactTypeDescriptor = $convert.base64Decode('ChJQcmltYXJ5Q29udGFjdFR5cGUSCQoFRU1BSUwQABIJCgVQSE9ORRAB');
@$core.Deprecated('Use signupStatusDescriptor instead')
const SignupStatus$json = const {
  '1': 'SignupStatus',
  '2': const [
    const {'1': 'SIGNUP_STATUS_CREATED', '2': 0},
    const {'1': 'SIGNUP_STATUS_EMAIL_VERIFIED', '2': 1},
    const {'1': 'SIGNUP_STATUS_PHONE_VERIFIED', '2': 2},
    const {'1': 'SIGNUP_STATUS_PASSCODE_SET', '2': 3},
    const {'1': 'SIGNUP_STATUS_COMPLETE', '2': 4},
  ],
};

/// Descriptor for `SignupStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List signupStatusDescriptor = $convert.base64Decode('CgxTaWdudXBTdGF0dXMSGQoVU0lHTlVQX1NUQVRVU19DUkVBVEVEEAASIAocU0lHTlVQX1NUQVRVU19FTUFJTF9WRVJJRklFRBABEiAKHFNJR05VUF9TVEFUVVNfUEhPTkVfVkVSSUZJRUQQAhIeChpTSUdOVVBfU1RBVFVTX1BBU1NDT0RFX1NFVBADEhoKFlNJR05VUF9TVEFUVVNfQ09NUExFVEUQBA==');
@$core.Deprecated('Use stepStatusDescriptor instead')
const StepStatus$json = const {
  '1': 'StepStatus',
  '2': const [
    const {'1': 'STEP_STATUS_PENDING', '2': 0},
    const {'1': 'STEP_STATUS_IN_PROGRESS', '2': 1},
    const {'1': 'STEP_STATUS_COMPLETED', '2': 2},
    const {'1': 'STEP_STATUS_SKIPPED', '2': 3},
  ],
};

/// Descriptor for `StepStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List stepStatusDescriptor = $convert.base64Decode('CgpTdGVwU3RhdHVzEhcKE1NURVBfU1RBVFVTX1BFTkRJTkcQABIbChdTVEVQX1NUQVRVU19JTl9QUk9HUkVTUxABEhkKFVNURVBfU1RBVFVTX0NPTVBMRVRFRBACEhcKE1NURVBfU1RBVFVTX1NLSVBQRUQQAw==');
@$core.Deprecated('Use identityTypeDescriptor instead')
const IdentityType$json = const {
  '1': 'IdentityType',
  '2': const [
    const {'1': 'IDENTITY_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'IDENTITY_TYPE_BVN', '2': 1},
    const {'1': 'IDENTITY_TYPE_NIN', '2': 2},
  ],
};

/// Descriptor for `IdentityType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List identityTypeDescriptor = $convert.base64Decode('CgxJZGVudGl0eVR5cGUSHQoZSURFTlRJVFlfVFlQRV9VTlNQRUNJRklFRBAAEhUKEUlERU5USVRZX1RZUEVfQlZOEAESFQoRSURFTlRJVFlfVFlQRV9OSU4QAg==');
@$core.Deprecated('Use signupRequestDescriptor instead')
const SignupRequest$json = const {
  '1': 'SignupRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'device_id', '3': 7, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'device_name', '3': 8, '4': 1, '5': 9, '10': 'deviceName'},
    const {'1': 'primary_contact_type', '3': 9, '4': 1, '5': 14, '6': '.auth.PrimaryContactType', '10': 'primaryContactType'},
    const {'1': 'username', '3': 10, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'referral_code', '3': 11, '4': 1, '5': 9, '10': 'referralCode'},
    const {'1': 'date_of_birth', '3': 12, '4': 1, '5': 9, '10': 'dateOfBirth'},
  ],
};

/// Descriptor for `SignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupRequestDescriptor = $convert.base64Decode('Cg1TaWdudXBSZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbBIaCghwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSFAoFcGhvbmUYBSABKAlSBXBob25lEiEKDGNvdW50cnlfY29kZRgGIAEoCVILY291bnRyeUNvZGUSGwoJZGV2aWNlX2lkGAcgASgJUghkZXZpY2VJZBIfCgtkZXZpY2VfbmFtZRgIIAEoCVIKZGV2aWNlTmFtZRJKChRwcmltYXJ5X2NvbnRhY3RfdHlwZRgJIAEoDjIYLmF1dGguUHJpbWFyeUNvbnRhY3RUeXBlUhJwcmltYXJ5Q29udGFjdFR5cGUSGgoIdXNlcm5hbWUYCiABKAlSCHVzZXJuYW1lEiMKDXJlZmVycmFsX2NvZGUYCyABKAlSDHJlZmVycmFsQ29kZRIiCg1kYXRlX29mX2JpcnRoGAwgASgJUgtkYXRlT2ZCaXJ0aA==');
@$core.Deprecated('Use signupResponseDescriptor instead')
const SignupResponse$json = const {
  '1': 'SignupResponse',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'email_verification_required', '3': 4, '4': 1, '5': 8, '10': 'emailVerificationRequired'},
    const {'1': 'access_token', '3': 5, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 6, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'expires_in', '3': 7, '4': 1, '5': 3, '10': 'expiresIn'},
    const {'1': 'user', '3': 8, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
    const {'1': 'phone_verification_required', '3': 9, '4': 1, '5': 8, '10': 'phoneVerificationRequired'},
    const {'1': 'verification_sent_to', '3': 10, '4': 1, '5': 9, '10': 'verificationSentTo'},
  ],
};

/// Descriptor for `SignupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupResponseDescriptor = $convert.base64Decode('Cg5TaWdudXBSZXNwb25zZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFZW1haWwYAiABKAlSBWVtYWlsEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USPgobZW1haWxfdmVyaWZpY2F0aW9uX3JlcXVpcmVkGAQgASgIUhllbWFpbFZlcmlmaWNhdGlvblJlcXVpcmVkEiEKDGFjY2Vzc190b2tlbhgFIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgGIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YByABKANSCWV4cGlyZXNJbhIeCgR1c2VyGAggASgLMgouYXV0aC5Vc2VyUgR1c2VyEj4KG3Bob25lX3ZlcmlmaWNhdGlvbl9yZXF1aXJlZBgJIAEoCFIZcGhvbmVWZXJpZmljYXRpb25SZXF1aXJlZBIwChR2ZXJpZmljYXRpb25fc2VudF90bxgKIAEoCVISdmVyaWZpY2F0aW9uU2VudFRv');
@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = const {
  '1': 'LoginRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'device_id', '3': 3, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'device_name', '3': 4, '4': 1, '5': 9, '10': 'deviceName'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode('CgxMb2dpblJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3N3b3JkGAIgASgJUghwYXNzd29yZBIbCglkZXZpY2VfaWQYAyABKAlSCGRldmljZUlkEh8KC2RldmljZV9uYW1lGAQgASgJUgpkZXZpY2VOYW1lEhQKBXBob25lGAUgASgJUgVwaG9uZQ==');
@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'expires_in', '3': 5, '4': 1, '5': 3, '10': 'expiresIn'},
    const {'1': 'data', '3': 6, '4': 1, '5': 11, '6': '.auth.LoginData', '10': 'data'},
    const {'1': 'two_factor_required', '3': 7, '4': 1, '5': 8, '10': 'twoFactorRequired'},
    const {'1': 'two_factor_token', '3': 8, '4': 1, '5': 9, '10': 'twoFactorToken'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode('Cg1Mb2dpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZXNoX3Rva2VuGAQgASgJUgxyZWZyZXNoVG9rZW4SHQoKZXhwaXJlc19pbhgFIAEoA1IJZXhwaXJlc0luEiMKBGRhdGEYBiABKAsyDy5hdXRoLkxvZ2luRGF0YVIEZGF0YRIuChN0d29fZmFjdG9yX3JlcXVpcmVkGAcgASgIUhF0d29GYWN0b3JSZXF1aXJlZBIoChB0d29fZmFjdG9yX3Rva2VuGAggASgJUg50d29GYWN0b3JUb2tlbg==');
@$core.Deprecated('Use loginDataDescriptor instead')
const LoginData$json = const {
  '1': 'LoginData',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
    const {'1': 'session', '3': 2, '4': 1, '5': 11, '6': '.auth.Session', '10': 'session'},
  ],
};

/// Descriptor for `LoginData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginDataDescriptor = $convert.base64Decode('CglMb2dpbkRhdGESHgoEdXNlchgBIAEoCzIKLmF1dGguVXNlclIEdXNlchInCgdzZXNzaW9uGAIgASgLMg0uYXV0aC5TZXNzaW9uUgdzZXNzaW9u');
@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode('CgdTZXNzaW9uEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJbhIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQ=');
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
    const {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `RefreshTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenResponseDescriptor = $convert.base64Decode('ChRSZWZyZXNoVG9rZW5SZXNwb25zZRIhCgxhY2Nlc3NfdG9rZW4YASABKAlSC2FjY2Vzc1Rva2VuEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbhIdCgpleHBpcmVzX2luGAMgASgDUglleHBpcmVzSW4SHgoEdXNlchgEIAEoCzIKLmF1dGguVXNlclIEdXNlcg==');
@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = const {
  '1': 'LogoutRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert.base64Decode('Cg1Mb2dvdXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIjCg1yZWZyZXNoX3Rva2VuGAIgASgJUgxyZWZyZXNoVG9rZW4=');
@$core.Deprecated('Use logoutResponseDescriptor instead')
const LogoutResponse$json = const {
  '1': 'LogoutResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `LogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutResponseDescriptor = $convert.base64Decode('Cg5Mb2dvdXRSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use verifyEmailRequestDescriptor instead')
const VerifyEmailRequest$json = const {
  '1': 'VerifyEmailRequest',
  '2': const [
    const {'1': 'verificationCode', '3': 1, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
};

/// Descriptor for `VerifyEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailRequestDescriptor = $convert.base64Decode('ChJWZXJpZnlFbWFpbFJlcXVlc3QSKgoQdmVyaWZpY2F0aW9uQ29kZRgBIAEoCVIQdmVyaWZpY2F0aW9uQ29kZQ==');
@$core.Deprecated('Use verifyEmailResponseDescriptor instead')
const VerifyEmailResponse$json = const {
  '1': 'VerifyEmailResponse',
  '2': const [
    const {'1': 'msg', '3': 1, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `VerifyEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailResponseDescriptor = $convert.base64Decode('ChNWZXJpZnlFbWFpbFJlc3BvbnNlEhAKA21zZxgBIAEoCVIDbXNnEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3M=');
@$core.Deprecated('Use resendVerificationEmailRequestDescriptor instead')
const ResendVerificationEmailRequest$json = const {
  '1': 'ResendVerificationEmailRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `ResendVerificationEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendVerificationEmailRequestDescriptor = $convert.base64Decode('Ch5SZXNlbmRWZXJpZmljYXRpb25FbWFpbFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');
@$core.Deprecated('Use resendVerificationEmailResponseDescriptor instead')
const ResendVerificationEmailResponse$json = const {
  '1': 'ResendVerificationEmailResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'cooldown_seconds', '3': 3, '4': 1, '5': 5, '10': 'cooldownSeconds'},
  ],
};

/// Descriptor for `ResendVerificationEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendVerificationEmailResponseDescriptor = $convert.base64Decode('Ch9SZXNlbmRWZXJpZmljYXRpb25FbWFpbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIpChBjb29sZG93bl9zZWNvbmRzGAMgASgFUg9jb29sZG93blNlY29uZHM=');
@$core.Deprecated('Use verifyPhoneRequestDescriptor instead')
const VerifyPhoneRequest$json = const {
  '1': 'VerifyPhoneRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `VerifyPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneRequestDescriptor = $convert.base64Decode('ChJWZXJpZnlQaG9uZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhIKBGNvZGUYAiABKAlSBGNvZGUSFAoFcGhvbmUYAyABKAlSBXBob25l');
@$core.Deprecated('Use verifyPhoneResponseDescriptor instead')
const VerifyPhoneResponse$json = const {
  '1': 'VerifyPhoneResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `VerifyPhoneResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneResponseDescriptor = $convert.base64Decode('ChNWZXJpZnlQaG9uZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2Vzcw==');
@$core.Deprecated('Use resendPhoneVerificationRequestDescriptor instead')
const ResendPhoneVerificationRequest$json = const {
  '1': 'ResendPhoneVerificationRequest',
  '2': const [
    const {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `ResendPhoneVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendPhoneVerificationRequestDescriptor = $convert.base64Decode('Ch5SZXNlbmRQaG9uZVZlcmlmaWNhdGlvblJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use resendPhoneVerificationResponseDescriptor instead')
const ResendPhoneVerificationResponse$json = const {
  '1': 'ResendPhoneVerificationResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ResendPhoneVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendPhoneVerificationResponseDescriptor = $convert.base64Decode('Ch9SZXNlbmRQaG9uZVZlcmlmaWNhdGlvblJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2Vzcw==');
@$core.Deprecated('Use forgotPasswordRequestDescriptor instead')
const ForgotPasswordRequest$json = const {
  '1': 'ForgotPasswordRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `ForgotPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordRequestDescriptor = $convert.base64Decode('ChVGb3Jnb3RQYXNzd29yZFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');
@$core.Deprecated('Use forgotPasswordResponseDescriptor instead')
const ForgotPasswordResponse$json = const {
  '1': 'ForgotPasswordResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ForgotPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordResponseDescriptor = $convert.base64Decode('ChZGb3Jnb3RQYXNzd29yZFJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use resetPasswordRequestDescriptor instead')
const ResetPasswordRequest$json = const {
  '1': 'ResetPasswordRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ResetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordRequestDescriptor = $convert.base64Decode('ChRSZXNldFBhc3N3b3JkUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SIQoMbmV3X3Bhc3N3b3JkGAIgASgJUgtuZXdQYXNzd29yZA==');
@$core.Deprecated('Use resetPasswordResponseDescriptor instead')
const ResetPasswordResponse$json = const {
  '1': 'ResetPasswordResponse',
  '2': const [
    const {'1': 'msg', '3': 1, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ResetPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordResponseDescriptor = $convert.base64Decode('ChVSZXNldFBhc3N3b3JkUmVzcG9uc2USEAoDbXNnGAEgASgJUgNtc2cSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2Vzcw==');
@$core.Deprecated('Use changePasswordRequestDescriptor instead')
const ChangePasswordRequest$json = const {
  '1': 'ChangePasswordRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'current_password', '3': 2, '4': 1, '5': 9, '10': 'currentPassword'},
    const {'1': 'new_password', '3': 3, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ChangePasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasswordRequestDescriptor = $convert.base64Decode('ChVDaGFuZ2VQYXNzd29yZFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEikKEGN1cnJlbnRfcGFzc3dvcmQYAiABKAlSD2N1cnJlbnRQYXNzd29yZBIhCgxuZXdfcGFzc3dvcmQYAyABKAlSC25ld1Bhc3N3b3Jk');
@$core.Deprecated('Use changePasswordResponseDescriptor instead')
const ChangePasswordResponse$json = const {
  '1': 'ChangePasswordResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ChangePasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasswordResponseDescriptor = $convert.base64Decode('ChZDaGFuZ2VQYXNzd29yZFJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getMeRequestDescriptor instead')
const GetMeRequest$json = const {
  '1': 'GetMeRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetMeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeRequestDescriptor = $convert.base64Decode('CgxHZXRNZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');
@$core.Deprecated('Use getMeResponseDescriptor instead')
const GetMeResponse$json = const {
  '1': 'GetMeResponse',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `GetMeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeResponseDescriptor = $convert.base64Decode('Cg1HZXRNZVJlc3BvbnNlEh4KBHVzZXIYASABKAsyCi5hdXRoLlVzZXJSBHVzZXI=');
@$core.Deprecated('Use facialLoginRequestDescriptor instead')
const FacialLoginRequest$json = const {
  '1': 'FacialLoginRequest',
  '2': const [
    const {'1': 'facial_data', '3': 1, '4': 1, '5': 12, '10': 'facialData'},
    const {'1': 'device_id', '3': 2, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `FacialLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialLoginRequestDescriptor = $convert.base64Decode('ChJGYWNpYWxMb2dpblJlcXVlc3QSHwoLZmFjaWFsX2RhdGEYASABKAxSCmZhY2lhbERhdGESGwoJZGV2aWNlX2lkGAIgASgJUghkZXZpY2VJZA==');
@$core.Deprecated('Use facialLoginResponseDescriptor instead')
const FacialLoginResponse$json = const {
  '1': 'FacialLoginResponse',
  '2': const [
    const {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `FacialLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialLoginResponseDescriptor = $convert.base64Decode('ChNGYWNpYWxMb2dpblJlc3BvbnNlEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJbhIeCgR1c2VyGAQgASgLMgouYXV0aC5Vc2VyUgR1c2Vy');
@$core.Deprecated('Use socialLoginRequestDescriptor instead')
const SocialLoginRequest$json = const {
  '1': 'SocialLoginRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'first_name', '3': 4, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 5, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'provider_user_id', '3': 6, '4': 1, '5': 9, '10': 'providerUserId'},
  ],
};

/// Descriptor for `SocialLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialLoginRequestDescriptor = $convert.base64Decode('ChJTb2NpYWxMb2dpblJlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEiUKDnByb3ZpZGVyX3Rva2VuGAIgASgJUg1wcm92aWRlclRva2VuEhQKBWVtYWlsGAMgASgJUgVlbWFpbBIdCgpmaXJzdF9uYW1lGAQgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAUgASgJUghsYXN0TmFtZRIoChBwcm92aWRlcl91c2VyX2lkGAYgASgJUg5wcm92aWRlclVzZXJJZA==');
@$core.Deprecated('Use socialLoginResponseDescriptor instead')
const SocialLoginResponse$json = const {
  '1': 'SocialLoginResponse',
  '2': const [
    const {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
    const {'1': 'is_new_user', '3': 5, '4': 1, '5': 8, '10': 'isNewUser'},
  ],
};

/// Descriptor for `SocialLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialLoginResponseDescriptor = $convert.base64Decode('ChNTb2NpYWxMb2dpblJlc3BvbnNlEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJbhIeCgR1c2VyGAQgASgLMgouYXV0aC5Vc2VyUgR1c2VyEh4KC2lzX25ld191c2VyGAUgASgIUglpc05ld1VzZXI=');
@$core.Deprecated('Use enableTwoFactorRequestDescriptor instead')
const EnableTwoFactorRequest$json = const {
  '1': 'EnableTwoFactorRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
  ],
};

/// Descriptor for `EnableTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableTwoFactorRequestDescriptor = $convert.base64Decode('ChZFbmFibGVUd29GYWN0b3JSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIWCgZtZXRob2QYAiABKAlSBm1ldGhvZA==');
@$core.Deprecated('Use enableTwoFactorResponseDescriptor instead')
const EnableTwoFactorResponse$json = const {
  '1': 'EnableTwoFactorResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'qr_code', '3': 2, '4': 1, '5': 9, '10': 'qrCode'},
    const {'1': 'secret', '3': 3, '4': 1, '5': 9, '10': 'secret'},
  ],
};

/// Descriptor for `EnableTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableTwoFactorResponseDescriptor = $convert.base64Decode('ChdFbmFibGVUd29GYWN0b3JSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEhcKB3FyX2NvZGUYAiABKAlSBnFyQ29kZRIWCgZzZWNyZXQYAyABKAlSBnNlY3JldA==');
@$core.Deprecated('Use verifyTwoFactorRequestDescriptor instead')
const VerifyTwoFactorRequest$json = const {
  '1': 'VerifyTwoFactorRequest',
  '2': const [
    const {'1': 'two_factor_token', '3': 1, '4': 1, '5': 9, '10': 'twoFactorToken'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'method', '3': 3, '4': 1, '5': 9, '10': 'method'},
  ],
};

/// Descriptor for `VerifyTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTwoFactorRequestDescriptor = $convert.base64Decode('ChZWZXJpZnlUd29GYWN0b3JSZXF1ZXN0EigKEHR3b19mYWN0b3JfdG9rZW4YASABKAlSDnR3b0ZhY3RvclRva2VuEhIKBGNvZGUYAiABKAlSBGNvZGUSFgoGbWV0aG9kGAMgASgJUgZtZXRob2Q=');
@$core.Deprecated('Use verifyTwoFactorResponseDescriptor instead')
const VerifyTwoFactorResponse$json = const {
  '1': 'VerifyTwoFactorResponse',
  '2': const [
    const {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `VerifyTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTwoFactorResponseDescriptor = $convert.base64Decode('ChdWZXJpZnlUd29GYWN0b3JSZXNwb25zZRIhCgxhY2Nlc3NfdG9rZW4YASABKAlSC2FjY2Vzc1Rva2VuEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbhIdCgpleHBpcmVzX2luGAMgASgDUglleHBpcmVzSW4SHgoEdXNlchgEIAEoCzIKLmF1dGguVXNlclIEdXNlcg==');
@$core.Deprecated('Use validateTokenRequestDescriptor instead')
const ValidateTokenRequest$json = const {
  '1': 'ValidateTokenRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `ValidateTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTokenRequestDescriptor = $convert.base64Decode('ChRWYWxpZGF0ZVRva2VuUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');
@$core.Deprecated('Use validateTokenResponseDescriptor instead')
const ValidateTokenResponse$json = const {
  '1': 'ValidateTokenResponse',
  '2': const [
    const {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'expires_at', '3': 4, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `ValidateTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTokenResponseDescriptor = $convert.base64Decode('ChVWYWxpZGF0ZVRva2VuUmVzcG9uc2USFAoFdmFsaWQYASABKAhSBXZhbGlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIUCgVlbWFpbBgDIAEoCVIFZW1haWwSHQoKZXhwaXJlc19hdBgEIAEoA1IJZXhwaXJlc0F0');
@$core.Deprecated('Use loginWithPasscodeRequestDescriptor instead')
const LoginWithPasscodeRequest$json = const {
  '1': 'LoginWithPasscodeRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'passcode', '3': 2, '4': 1, '5': 9, '10': 'passcode'},
    const {'1': 'device_id', '3': 3, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'device_name', '3': 4, '4': 1, '5': 9, '10': 'deviceName'},
  ],
};

/// Descriptor for `LoginWithPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginWithPasscodeRequestDescriptor = $convert.base64Decode('ChhMb2dpbldpdGhQYXNzY29kZVJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3Njb2RlGAIgASgJUghwYXNzY29kZRIbCglkZXZpY2VfaWQYAyABKAlSCGRldmljZUlkEh8KC2RldmljZV9uYW1lGAQgASgJUgpkZXZpY2VOYW1l');
@$core.Deprecated('Use registerPasscodeRequestDescriptor instead')
const RegisterPasscodeRequest$json = const {
  '1': 'RegisterPasscodeRequest',
  '2': const [
    const {'1': 'passcode', '3': 1, '4': 1, '5': 9, '10': 'passcode'},
  ],
};

/// Descriptor for `RegisterPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPasscodeRequestDescriptor = $convert.base64Decode('ChdSZWdpc3RlclBhc3Njb2RlUmVxdWVzdBIaCghwYXNzY29kZRgBIAEoCVIIcGFzc2NvZGU=');
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
@$core.Deprecated('Use changePasscodeRequestDescriptor instead')
const ChangePasscodeRequest$json = const {
  '1': 'ChangePasscodeRequest',
  '2': const [
    const {'1': 'current_passcode', '3': 1, '4': 1, '5': 9, '10': 'currentPasscode'},
    const {'1': 'new_passcode', '3': 2, '4': 1, '5': 9, '10': 'newPasscode'},
  ],
};

/// Descriptor for `ChangePasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasscodeRequestDescriptor = $convert.base64Decode('ChVDaGFuZ2VQYXNzY29kZVJlcXVlc3QSKQoQY3VycmVudF9wYXNzY29kZRgBIAEoCVIPY3VycmVudFBhc3Njb2RlEiEKDG5ld19wYXNzY29kZRgCIAEoCVILbmV3UGFzc2NvZGU=');
@$core.Deprecated('Use changePasscodeResponseDescriptor instead')
const ChangePasscodeResponse$json = const {
  '1': 'ChangePasscodeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `ChangePasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasscodeResponseDescriptor = $convert.base64Decode('ChZDaGFuZ2VQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2c=');
@$core.Deprecated('Use requestPasswordResetRequestDescriptor instead')
const RequestPasswordResetRequest$json = const {
  '1': 'RequestPasswordResetRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RequestPasswordResetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetRequestDescriptor = $convert.base64Decode('ChtSZXF1ZXN0UGFzc3dvcmRSZXNldFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');
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
@$core.Deprecated('Use requestEmailVerificationRequestDescriptor instead')
const RequestEmailVerificationRequest$json = const {
  '1': 'RequestEmailVerificationRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RequestEmailVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestEmailVerificationRequestDescriptor = $convert.base64Decode('Ch9SZXF1ZXN0RW1haWxWZXJpZmljYXRpb25SZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbA==');
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
@$core.Deprecated('Use checkEmailAvailabilityRequestDescriptor instead')
const CheckEmailAvailabilityRequest$json = const {
  '1': 'CheckEmailAvailabilityRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `CheckEmailAvailabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEmailAvailabilityRequestDescriptor = $convert.base64Decode('Ch1DaGVja0VtYWlsQXZhaWxhYmlsaXR5UmVxdWVzdBIUCgVlbWFpbBgBIAEoCVIFZW1haWw=');
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
@$core.Deprecated('Use requestPhoneVerificationRequestDescriptor instead')
const RequestPhoneVerificationRequest$json = const {
  '1': 'RequestPhoneVerificationRequest',
  '2': const [
    const {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `RequestPhoneVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhoneVerificationRequestDescriptor = $convert.base64Decode('Ch9SZXF1ZXN0UGhvbmVWZXJpZmljYXRpb25SZXF1ZXN0EhQKBXBob25lGAEgASgJUgVwaG9uZRIhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2Rl');
@$core.Deprecated('Use requestPhoneVerificationResponseDescriptor instead')
const RequestPhoneVerificationResponse$json = const {
  '1': 'RequestPhoneVerificationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'verification_id', '3': 3, '4': 1, '5': 9, '10': 'verificationId'},
    const {'1': 'expires_in', '3': 4, '4': 1, '5': 3, '10': 'expiresIn'},
  ],
};

/// Descriptor for `RequestPhoneVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhoneVerificationResponseDescriptor = $convert.base64Decode('CiBSZXF1ZXN0UGhvbmVWZXJpZmljYXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNnEicKD3ZlcmlmaWNhdGlvbl9pZBgDIAEoCVIOdmVyaWZpY2F0aW9uSWQSHQoKZXhwaXJlc19pbhgEIAEoA1IJZXhwaXJlc0lu');
@$core.Deprecated('Use verifyPhoneNumberRequestDescriptor instead')
const VerifyPhoneNumberRequest$json = const {
  '1': 'VerifyPhoneNumberRequest',
  '2': const [
    const {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'verification_id', '3': 4, '4': 1, '5': 9, '10': 'verificationId'},
  ],
};

/// Descriptor for `VerifyPhoneNumberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneNumberRequestDescriptor = $convert.base64Decode('ChhWZXJpZnlQaG9uZU51bWJlclJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEiEKDGNvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGUSEgoEY29kZRgDIAEoCVIEY29kZRInCg92ZXJpZmljYXRpb25faWQYBCABKAlSDnZlcmlmaWNhdGlvbklk');
@$core.Deprecated('Use verifyPhoneNumberResponseDescriptor instead')
const VerifyPhoneNumberResponse$json = const {
  '1': 'VerifyPhoneNumberResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'is_verified', '3': 3, '4': 1, '5': 8, '10': 'isVerified'},
  ],
};

/// Descriptor for `VerifyPhoneNumberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneNumberResponseDescriptor = $convert.base64Decode('ChlWZXJpZnlQaG9uZU51bWJlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSHwoLaXNfdmVyaWZpZWQYAyABKAhSCmlzVmVyaWZpZWQ=');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'email_verified', '3': 7, '4': 1, '5': 8, '10': 'emailVerified'},
    const {'1': 'phone_verified', '3': 8, '4': 1, '5': 8, '10': 'phoneVerified'},
    const {'1': 'two_factor_enabled', '3': 9, '4': 1, '5': 8, '10': 'twoFactorEnabled'},
    const {'1': 'two_factor_method', '3': 10, '4': 1, '5': 9, '10': 'twoFactorMethod'},
    const {'1': 'profile_picture', '3': 11, '4': 1, '5': 9, '10': 'profilePicture'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSFAoFcGhvbmUYBSABKAlSBXBob25lEiEKDGNvdW50cnlfY29kZRgGIAEoCVILY291bnRyeUNvZGUSJQoOZW1haWxfdmVyaWZpZWQYByABKAhSDWVtYWlsVmVyaWZpZWQSJQoOcGhvbmVfdmVyaWZpZWQYCCABKAhSDXBob25lVmVyaWZpZWQSLAoSdHdvX2ZhY3Rvcl9lbmFibGVkGAkgASgIUhB0d29GYWN0b3JFbmFibGVkEioKEXR3b19mYWN0b3JfbWV0aG9kGAogASgJUg90d29GYWN0b3JNZXRob2QSJwoPcHJvZmlsZV9waWN0dXJlGAsgASgJUg5wcm9maWxlUGljdHVyZRIdCgpjcmVhdGVkX2F0GAwgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgNIAEoCVIJdXBkYXRlZEF0');
@$core.Deprecated('Use signupProgressDescriptor instead')
const SignupProgress$json = const {
  '1': 'SignupProgress',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.auth.SignupStatus', '10': 'status'},
    const {'1': 'current_step', '3': 3, '4': 1, '5': 9, '10': 'currentStep'},
    const {'1': 'steps', '3': 4, '4': 3, '5': 11, '6': '.auth.SignupStepProgress', '10': 'steps'},
    const {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 6, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'completed_at', '3': 7, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `SignupProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupProgressDescriptor = $convert.base64Decode('Cg5TaWdudXBQcm9ncmVzcxIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKgoGc3RhdHVzGAIgASgOMhIuYXV0aC5TaWdudXBTdGF0dXNSBnN0YXR1cxIhCgxjdXJyZW50X3N0ZXAYAyABKAlSC2N1cnJlbnRTdGVwEi4KBXN0ZXBzGAQgAygLMhguYXV0aC5TaWdudXBTdGVwUHJvZ3Jlc3NSBXN0ZXBzEh0KCmNyZWF0ZWRfYXQYBSABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAYgASgJUgl1cGRhdGVkQXQSIQoMY29tcGxldGVkX2F0GAcgASgJUgtjb21wbGV0ZWRBdA==');
@$core.Deprecated('Use signupStepProgressDescriptor instead')
const SignupStepProgress$json = const {
  '1': 'SignupStepProgress',
  '2': const [
    const {'1': 'step_name', '3': 1, '4': 1, '5': 9, '10': 'stepName'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.auth.StepStatus', '10': 'status'},
    const {'1': 'step_data', '3': 3, '4': 1, '5': 9, '10': 'stepData'},
    const {'1': 'completed_at', '3': 4, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `SignupStepProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupStepProgressDescriptor = $convert.base64Decode('ChJTaWdudXBTdGVwUHJvZ3Jlc3MSGwoJc3RlcF9uYW1lGAEgASgJUghzdGVwTmFtZRIoCgZzdGF0dXMYAiABKA4yEC5hdXRoLlN0ZXBTdGF0dXNSBnN0YXR1cxIbCglzdGVwX2RhdGEYAyABKAlSCHN0ZXBEYXRhEiEKDGNvbXBsZXRlZF9hdBgEIAEoCVILY29tcGxldGVkQXQ=');
@$core.Deprecated('Use getSignupProgressRequestDescriptor instead')
const GetSignupProgressRequest$json = const {
  '1': 'GetSignupProgressRequest',
};

/// Descriptor for `GetSignupProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSignupProgressRequestDescriptor = $convert.base64Decode('ChhHZXRTaWdudXBQcm9ncmVzc1JlcXVlc3Q=');
@$core.Deprecated('Use getSignupProgressResponseDescriptor instead')
const GetSignupProgressResponse$json = const {
  '1': 'GetSignupProgressResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.auth.SignupProgress', '10': 'progress'},
  ],
};

/// Descriptor for `GetSignupProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSignupProgressResponseDescriptor = $convert.base64Decode('ChlHZXRTaWdudXBQcm9ncmVzc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIwCghwcm9ncmVzcxgDIAEoCzIULmF1dGguU2lnbnVwUHJvZ3Jlc3NSCHByb2dyZXNz');
@$core.Deprecated('Use updateSignupStepRequestDescriptor instead')
const UpdateSignupStepRequest$json = const {
  '1': 'UpdateSignupStepRequest',
  '2': const [
    const {'1': 'step_name', '3': 1, '4': 1, '5': 9, '10': 'stepName'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.auth.StepStatus', '10': 'status'},
    const {'1': 'step_data', '3': 3, '4': 1, '5': 9, '10': 'stepData'},
  ],
};

/// Descriptor for `UpdateSignupStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSignupStepRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVTaWdudXBTdGVwUmVxdWVzdBIbCglzdGVwX25hbWUYASABKAlSCHN0ZXBOYW1lEigKBnN0YXR1cxgCIAEoDjIQLmF1dGguU3RlcFN0YXR1c1IGc3RhdHVzEhsKCXN0ZXBfZGF0YRgDIAEoCVIIc3RlcERhdGE=');
@$core.Deprecated('Use updateSignupStepResponseDescriptor instead')
const UpdateSignupStepResponse$json = const {
  '1': 'UpdateSignupStepResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.auth.SignupProgress', '10': 'progress'},
  ],
};

/// Descriptor for `UpdateSignupStepResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSignupStepResponseDescriptor = $convert.base64Decode('ChhVcGRhdGVTaWdudXBTdGVwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjAKCHByb2dyZXNzGAMgASgLMhQuYXV0aC5TaWdudXBQcm9ncmVzc1IIcHJvZ3Jlc3M=');
@$core.Deprecated('Use completeSignupRequestDescriptor instead')
const CompleteSignupRequest$json = const {
  '1': 'CompleteSignupRequest',
};

/// Descriptor for `CompleteSignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeSignupRequestDescriptor = $convert.base64Decode('ChVDb21wbGV0ZVNpZ251cFJlcXVlc3Q=');
@$core.Deprecated('Use completeSignupResponseDescriptor instead')
const CompleteSignupResponse$json = const {
  '1': 'CompleteSignupResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.auth.SignupProgress', '10': 'progress'},
  ],
};

/// Descriptor for `CompleteSignupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeSignupResponseDescriptor = $convert.base64Decode('ChZDb21wbGV0ZVNpZ251cFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIwCghwcm9ncmVzcxgDIAEoCzIULmF1dGguU2lnbnVwUHJvZ3Jlc3NSCHByb2dyZXNz');
@$core.Deprecated('Use verifyIdentityRequestDescriptor instead')
const VerifyIdentityRequest$json = const {
  '1': 'VerifyIdentityRequest',
  '2': const [
    const {'1': 'identity_type', '3': 1, '4': 1, '5': 14, '6': '.auth.IdentityType', '10': 'identityType'},
    const {'1': 'identity_number', '3': 2, '4': 1, '5': 9, '10': 'identityNumber'},
    const {'1': 'date_of_birth', '3': 3, '4': 1, '5': 9, '10': 'dateOfBirth'},
  ],
};

/// Descriptor for `VerifyIdentityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIdentityRequestDescriptor = $convert.base64Decode('ChVWZXJpZnlJZGVudGl0eVJlcXVlc3QSNwoNaWRlbnRpdHlfdHlwZRgBIAEoDjISLmF1dGguSWRlbnRpdHlUeXBlUgxpZGVudGl0eVR5cGUSJwoPaWRlbnRpdHlfbnVtYmVyGAIgASgJUg5pZGVudGl0eU51bWJlchIiCg1kYXRlX29mX2JpcnRoGAMgASgJUgtkYXRlT2ZCaXJ0aA==');
@$core.Deprecated('Use verifiedIdentityDescriptor instead')
const VerifiedIdentity$json = const {
  '1': 'VerifiedIdentity',
  '2': const [
    const {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'middle_name', '3': 3, '4': 1, '5': 9, '10': 'middleName'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
    const {'1': 'photo_url', '3': 7, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'address', '3': 8, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'state_of_origin', '3': 9, '4': 1, '5': 9, '10': 'stateOfOrigin'},
    const {'1': 'lga_of_origin', '3': 10, '4': 1, '5': 9, '10': 'lgaOfOrigin'},
  ],
};

/// Descriptor for `VerifiedIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifiedIdentityDescriptor = $convert.base64Decode('ChBWZXJpZmllZElkZW50aXR5Eh0KCmZpcnN0X25hbWUYASABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUYAiABKAlSCGxhc3ROYW1lEh8KC21pZGRsZV9uYW1lGAMgASgJUgptaWRkbGVOYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISIgoNZGF0ZV9vZl9iaXJ0aBgFIAEoCVILZGF0ZU9mQmlydGgSFgoGZ2VuZGVyGAYgASgJUgZnZW5kZXISGwoJcGhvdG9fdXJsGAcgASgJUghwaG90b1VybBIYCgdhZGRyZXNzGAggASgJUgdhZGRyZXNzEiYKD3N0YXRlX29mX29yaWdpbhgJIAEoCVINc3RhdGVPZk9yaWdpbhIiCg1sZ2Ffb2Zfb3JpZ2luGAogASgJUgtsZ2FPZk9yaWdpbg==');
@$core.Deprecated('Use virtualAccountInfoDescriptor instead')
const VirtualAccountInfo$json = const {
  '1': 'VirtualAccountInfo',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'bank_name', '3': 2, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'bank_code', '3': 3, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'provider', '3': 6, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `VirtualAccountInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountInfoDescriptor = $convert.base64Decode('ChJWaXJ0dWFsQWNjb3VudEluZm8SJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW1iZXISGwoJYmFua19uYW1lGAIgASgJUghiYW5rTmFtZRIbCgliYW5rX2NvZGUYAyABKAlSCGJhbmtDb2RlEiEKDGFjY291bnRfbmFtZRgEIAEoCVILYWNjb3VudE5hbWUSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhoKCHByb3ZpZGVyGAYgASgJUghwcm92aWRlcg==');
@$core.Deprecated('Use verifyIdentityResponseDescriptor instead')
const VerifyIdentityResponse$json = const {
  '1': 'VerifyIdentityResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'error_code', '3': 3, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'identity', '3': 5, '4': 1, '5': 11, '6': '.auth.VerifiedIdentity', '10': 'identity'},
    const {'1': 'virtual_account', '3': 6, '4': 1, '5': 11, '6': '.auth.VirtualAccountInfo', '10': 'virtualAccount'},
  ],
};

/// Descriptor for `VerifyIdentityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIdentityResponseDescriptor = $convert.base64Decode('ChZWZXJpZnlJZGVudGl0eVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGgoIdmVyaWZpZWQYAiABKAhSCHZlcmlmaWVkEh0KCmVycm9yX2NvZGUYAyABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAQgASgJUgxlcnJvck1lc3NhZ2USMgoIaWRlbnRpdHkYBSABKAsyFi5hdXRoLlZlcmlmaWVkSWRlbnRpdHlSCGlkZW50aXR5EkEKD3ZpcnR1YWxfYWNjb3VudBgGIAEoCzIYLmF1dGguVmlydHVhbEFjY291bnRJbmZvUg52aXJ0dWFsQWNjb3VudA==');
