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
@$core.Deprecated('Use passwordResetDeliveryMethodDescriptor instead')
const PasswordResetDeliveryMethod$json = const {
  '1': 'PasswordResetDeliveryMethod',
  '2': const [
    const {'1': 'DELIVERY_METHOD_UNSPECIFIED', '2': 0},
    const {'1': 'DELIVERY_METHOD_EMAIL', '2': 1},
    const {'1': 'DELIVERY_METHOD_SMS', '2': 2},
  ],
};

/// Descriptor for `PasswordResetDeliveryMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List passwordResetDeliveryMethodDescriptor = $convert.base64Decode('ChtQYXNzd29yZFJlc2V0RGVsaXZlcnlNZXRob2QSHwobREVMSVZFUllfTUVUSE9EX1VOU1BFQ0lGSUVEEAASGQoVREVMSVZFUllfTUVUSE9EX0VNQUlMEAESFwoTREVMSVZFUllfTUVUSE9EX1NNUxAC');
@$core.Deprecated('Use signupStatusDescriptor instead')
const SignupStatus$json = const {
  '1': 'SignupStatus',
  '2': const [
    const {'1': 'SIGNUP_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'SIGNUP_STATUS_CREATED', '2': 1},
    const {'1': 'SIGNUP_STATUS_EMAIL_VERIFIED', '2': 2},
    const {'1': 'SIGNUP_STATUS_PHONE_VERIFIED', '2': 3},
    const {'1': 'SIGNUP_STATUS_IDENTITY_VERIFIED', '2': 4},
    const {'1': 'SIGNUP_STATUS_PASSCODE_SET', '2': 5},
    const {'1': 'SIGNUP_STATUS_COMPLETE', '2': 6},
  ],
};

/// Descriptor for `SignupStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List signupStatusDescriptor = $convert.base64Decode('CgxTaWdudXBTdGF0dXMSHQoZU0lHTlVQX1NUQVRVU19VTlNQRUNJRklFRBAAEhkKFVNJR05VUF9TVEFUVVNfQ1JFQVRFRBABEiAKHFNJR05VUF9TVEFUVVNfRU1BSUxfVkVSSUZJRUQQAhIgChxTSUdOVVBfU1RBVFVTX1BIT05FX1ZFUklGSUVEEAMSIwofU0lHTlVQX1NUQVRVU19JREVOVElUWV9WRVJJRklFRBAEEh4KGlNJR05VUF9TVEFUVVNfUEFTU0NPREVfU0VUEAUSGgoWU0lHTlVQX1NUQVRVU19DT01QTEVURRAG');
@$core.Deprecated('Use stepStatusDescriptor instead')
const StepStatus$json = const {
  '1': 'StepStatus',
  '2': const [
    const {'1': 'STEP_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'STEP_STATUS_PENDING', '2': 1},
    const {'1': 'STEP_STATUS_IN_PROGRESS', '2': 2},
    const {'1': 'STEP_STATUS_COMPLETED', '2': 3},
    const {'1': 'STEP_STATUS_SKIPPED', '2': 4},
  ],
};

/// Descriptor for `StepStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List stepStatusDescriptor = $convert.base64Decode('CgpTdGVwU3RhdHVzEhsKF1NURVBfU1RBVFVTX1VOU1BFQ0lGSUVEEAASFwoTU1RFUF9TVEFUVVNfUEVORElORxABEhsKF1NURVBfU1RBVFVTX0lOX1BST0dSRVNTEAISGQoVU1RFUF9TVEFUVVNfQ09NUExFVEVEEAMSFwoTU1RFUF9TVEFUVVNfU0tJUFBFRBAE');
@$core.Deprecated('Use identityTypeDescriptor instead')
const IdentityType$json = const {
  '1': 'IdentityType',
  '2': const [
    const {'1': 'IDENTITY_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'IDENTITY_TYPE_BVN', '2': 1},
    const {'1': 'IDENTITY_TYPE_NIN', '2': 2},
    const {'1': 'IDENTITY_TYPE_GHANA_CARD', '2': 3},
    const {'1': 'IDENTITY_TYPE_KENYA_NATIONAL_ID', '2': 4},
    const {'1': 'IDENTITY_TYPE_KRA_PIN', '2': 5},
    const {'1': 'IDENTITY_TYPE_SA_ID', '2': 6},
    const {'1': 'IDENTITY_TYPE_SA_PASSPORT', '2': 7},
    const {'1': 'IDENTITY_TYPE_UK_PASSPORT', '2': 8},
    const {'1': 'IDENTITY_TYPE_UK_DRIVING_LICENSE', '2': 9},
    const {'1': 'IDENTITY_TYPE_US_SSN', '2': 10},
    const {'1': 'IDENTITY_TYPE_US_STATE_ID', '2': 11},
    const {'1': 'IDENTITY_TYPE_US_PASSPORT', '2': 12},
    const {'1': 'IDENTITY_TYPE_DRIVERS_LICENSE', '2': 13},
    const {'1': 'IDENTITY_TYPE_INTERNATIONAL_PASSPORT', '2': 14},
  ],
};

/// Descriptor for `IdentityType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List identityTypeDescriptor = $convert.base64Decode('CgxJZGVudGl0eVR5cGUSHQoZSURFTlRJVFlfVFlQRV9VTlNQRUNJRklFRBAAEhUKEUlERU5USVRZX1RZUEVfQlZOEAESFQoRSURFTlRJVFlfVFlQRV9OSU4QAhIcChhJREVOVElUWV9UWVBFX0dIQU5BX0NBUkQQAxIjCh9JREVOVElUWV9UWVBFX0tFTllBX05BVElPTkFMX0lEEAQSGQoVSURFTlRJVFlfVFlQRV9LUkFfUElOEAUSFwoTSURFTlRJVFlfVFlQRV9TQV9JRBAGEh0KGUlERU5USVRZX1RZUEVfU0FfUEFTU1BPUlQQBxIdChlJREVOVElUWV9UWVBFX1VLX1BBU1NQT1JUEAgSJAogSURFTlRJVFlfVFlQRV9VS19EUklWSU5HX0xJQ0VOU0UQCRIYChRJREVOVElUWV9UWVBFX1VTX1NTThAKEh0KGUlERU5USVRZX1RZUEVfVVNfU1RBVEVfSUQQCxIdChlJREVOVElUWV9UWVBFX1VTX1BBU1NQT1JUEAwSIQodSURFTlRJVFlfVFlQRV9EUklWRVJTX0xJQ0VOU0UQDRIoCiRJREVOVElUWV9UWVBFX0lOVEVSTkFUSU9OQUxfUEFTU1BPUlQQDg==');
@$core.Deprecated('Use kYCTierDescriptor instead')
const KYCTier$json = const {
  '1': 'KYCTier',
  '2': const [
    const {'1': 'KYC_TIER_UNKNOWN', '2': 0},
    const {'1': 'KYC_TIER_1', '2': 1},
    const {'1': 'KYC_TIER_2', '2': 2},
    const {'1': 'KYC_TIER_3', '2': 3},
  ],
};

/// Descriptor for `KYCTier`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCTierDescriptor = $convert.base64Decode('CgdLWUNUaWVyEhQKEEtZQ19USUVSX1VOS05PV04QABIOCgpLWUNfVElFUl8xEAESDgoKS1lDX1RJRVJfMhACEg4KCktZQ19USUVSXzMQAw==');
@$core.Deprecated('Use documentTypeDescriptor instead')
const DocumentType$json = const {
  '1': 'DocumentType',
  '2': const [
    const {'1': 'DOCUMENT_TYPE_UNKNOWN', '2': 0},
    const {'1': 'DOCUMENT_TYPE_BVN', '2': 1},
    const {'1': 'DOCUMENT_TYPE_NIN', '2': 2},
    const {'1': 'DOCUMENT_TYPE_DRIVERS_LICENSE', '2': 3},
    const {'1': 'DOCUMENT_TYPE_PASSPORT', '2': 4},
    const {'1': 'DOCUMENT_TYPE_VOTERS_CARD', '2': 5},
    const {'1': 'DOCUMENT_TYPE_PROOF_OF_ADDRESS', '2': 6},
    const {'1': 'DOCUMENT_TYPE_SELFIE', '2': 7},
  ],
};

/// Descriptor for `DocumentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentTypeDescriptor = $convert.base64Decode('CgxEb2N1bWVudFR5cGUSGQoVRE9DVU1FTlRfVFlQRV9VTktOT1dOEAASFQoRRE9DVU1FTlRfVFlQRV9CVk4QARIVChFET0NVTUVOVF9UWVBFX05JThACEiEKHURPQ1VNRU5UX1RZUEVfRFJJVkVSU19MSUNFTlNFEAMSGgoWRE9DVU1FTlRfVFlQRV9QQVNTUE9SVBAEEh0KGURPQ1VNRU5UX1RZUEVfVk9URVJTX0NBUkQQBRIiCh5ET0NVTUVOVF9UWVBFX1BST09GX09GX0FERFJFU1MQBhIYChRET0NVTUVOVF9UWVBFX1NFTEZJRRAH');
@$core.Deprecated('Use documentStatusDescriptor instead')
const DocumentStatus$json = const {
  '1': 'DocumentStatus',
  '2': const [
    const {'1': 'DOCUMENT_STATUS_UNKNOWN', '2': 0},
    const {'1': 'DOCUMENT_STATUS_PENDING_UPLOAD', '2': 1},
    const {'1': 'DOCUMENT_STATUS_UPLOADED', '2': 2},
    const {'1': 'DOCUMENT_STATUS_UNDER_REVIEW', '2': 3},
    const {'1': 'DOCUMENT_STATUS_APPROVED', '2': 4},
    const {'1': 'DOCUMENT_STATUS_REJECTED', '2': 5},
  ],
};

/// Descriptor for `DocumentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentStatusDescriptor = $convert.base64Decode('Cg5Eb2N1bWVudFN0YXR1cxIbChdET0NVTUVOVF9TVEFUVVNfVU5LTk9XThAAEiIKHkRPQ1VNRU5UX1NUQVRVU19QRU5ESU5HX1VQTE9BRBABEhwKGERPQ1VNRU5UX1NUQVRVU19VUExPQURFRBACEiAKHERPQ1VNRU5UX1NUQVRVU19VTkRFUl9SRVZJRVcQAxIcChhET0NVTUVOVF9TVEFUVVNfQVBQUk9WRUQQBBIcChhET0NVTUVOVF9TVEFUVVNfUkVKRUNURUQQBQ==');
@$core.Deprecated('Use kYCVerificationStatusDescriptor instead')
const KYCVerificationStatus$json = const {
  '1': 'KYCVerificationStatus',
  '2': const [
    const {'1': 'KYC_STATUS_UNKNOWN', '2': 0},
    const {'1': 'KYC_STATUS_NOT_STARTED', '2': 1},
    const {'1': 'KYC_STATUS_IN_PROGRESS', '2': 2},
    const {'1': 'KYC_STATUS_PENDING_REVIEW', '2': 3},
    const {'1': 'KYC_STATUS_APPROVED', '2': 4},
    const {'1': 'KYC_STATUS_REJECTED', '2': 5},
    const {'1': 'KYC_STATUS_EXPIRED', '2': 6},
  ],
};

/// Descriptor for `KYCVerificationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCVerificationStatusDescriptor = $convert.base64Decode('ChVLWUNWZXJpZmljYXRpb25TdGF0dXMSFgoSS1lDX1NUQVRVU19VTktOT1dOEAASGgoWS1lDX1NUQVRVU19OT1RfU1RBUlRFRBABEhoKFktZQ19TVEFUVVNfSU5fUFJPR1JFU1MQAhIdChlLWUNfU1RBVFVTX1BFTkRJTkdfUkVWSUVXEAMSFwoTS1lDX1NUQVRVU19BUFBST1ZFRBAEEhcKE0tZQ19TVEFUVVNfUkVKRUNURUQQBRIWChJLWUNfU1RBVFVTX0VYUElSRUQQBg==');
@$core.Deprecated('Use signupRequestDescriptor instead')
const SignupRequest$json = const {
  '1': 'SignupRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'device_id', '3': 6, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'device_name', '3': 7, '4': 1, '5': 9, '10': 'deviceName'},
    const {'1': 'primary_contact_type', '3': 8, '4': 1, '5': 14, '6': '.pb.PrimaryContactType', '10': 'primaryContactType'},
    const {'1': 'username', '3': 9, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'referral_code', '3': 10, '4': 1, '5': 9, '10': 'referralCode'},
    const {'1': 'date_of_birth', '3': 11, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'locale', '3': 12, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'bvn', '3': 13, '4': 1, '5': 9, '10': 'bvn'},
    const {'1': 'nin', '3': 14, '4': 1, '5': 9, '10': 'nin'},
    const {
      '1': 'country_code',
      '3': 15,
      '4': 1,
      '5': 9,
      '8': const {'3': true},
      '10': 'countryCode',
    },
    const {
      '1': 'currency_code',
      '3': 16,
      '4': 1,
      '5': 9,
      '8': const {'3': true},
      '10': 'currencyCode',
    },
  ],
};

/// Descriptor for `SignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupRequestDescriptor = $convert.base64Decode('Cg1TaWdudXBSZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbBIaCghwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSFAoFcGhvbmUYBSABKAlSBXBob25lEhsKCWRldmljZV9pZBgGIAEoCVIIZGV2aWNlSWQSHwoLZGV2aWNlX25hbWUYByABKAlSCmRldmljZU5hbWUSSAoUcHJpbWFyeV9jb250YWN0X3R5cGUYCCABKA4yFi5wYi5QcmltYXJ5Q29udGFjdFR5cGVSEnByaW1hcnlDb250YWN0VHlwZRIaCgh1c2VybmFtZRgJIAEoCVIIdXNlcm5hbWUSIwoNcmVmZXJyYWxfY29kZRgKIAEoCVIMcmVmZXJyYWxDb2RlEiIKDWRhdGVfb2ZfYmlydGgYCyABKAlSC2RhdGVPZkJpcnRoEhYKBmxvY2FsZRgMIAEoCVIGbG9jYWxlEhAKA2J2bhgNIAEoCVIDYnZuEhAKA25pbhgOIAEoCVIDbmluEiUKDGNvdW50cnlfY29kZRgPIAEoCUICGAFSC2NvdW50cnlDb2RlEicKDWN1cnJlbmN5X2NvZGUYECABKAlCAhgBUgxjdXJyZW5jeUNvZGU=');
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
    const {'1': 'user', '3': 8, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    const {'1': 'phone_verification_required', '3': 9, '4': 1, '5': 8, '10': 'phoneVerificationRequired'},
    const {'1': 'verification_sent_to', '3': 10, '4': 1, '5': 9, '10': 'verificationSentTo'},
    const {'1': 'phone_verification_id', '3': 11, '4': 1, '5': 9, '10': 'phoneVerificationId'},
    const {'1': 'phone_verification_expires_in', '3': 12, '4': 1, '5': 3, '10': 'phoneVerificationExpiresIn'},
  ],
};

/// Descriptor for `SignupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupResponseDescriptor = $convert.base64Decode('Cg5TaWdudXBSZXNwb25zZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFZW1haWwYAiABKAlSBWVtYWlsEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USPgobZW1haWxfdmVyaWZpY2F0aW9uX3JlcXVpcmVkGAQgASgIUhllbWFpbFZlcmlmaWNhdGlvblJlcXVpcmVkEiEKDGFjY2Vzc190b2tlbhgFIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgGIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YByABKANSCWV4cGlyZXNJbhIcCgR1c2VyGAggASgLMggucGIuVXNlclIEdXNlchI+ChtwaG9uZV92ZXJpZmljYXRpb25fcmVxdWlyZWQYCSABKAhSGXBob25lVmVyaWZpY2F0aW9uUmVxdWlyZWQSMAoUdmVyaWZpY2F0aW9uX3NlbnRfdG8YCiABKAlSEnZlcmlmaWNhdGlvblNlbnRUbxIyChVwaG9uZV92ZXJpZmljYXRpb25faWQYCyABKAlSE3Bob25lVmVyaWZpY2F0aW9uSWQSQQodcGhvbmVfdmVyaWZpY2F0aW9uX2V4cGlyZXNfaW4YDCABKANSGnBob25lVmVyaWZpY2F0aW9uRXhwaXJlc0lu');
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
    const {'1': 'data', '3': 6, '4': 1, '5': 11, '6': '.pb.LoginData', '10': 'data'},
    const {'1': 'two_factor_required', '3': 7, '4': 1, '5': 8, '10': 'twoFactorRequired'},
    const {'1': 'two_factor_token', '3': 8, '4': 1, '5': 9, '10': 'twoFactorToken'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode('Cg1Mb2dpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZXNoX3Rva2VuGAQgASgJUgxyZWZyZXNoVG9rZW4SHQoKZXhwaXJlc19pbhgFIAEoA1IJZXhwaXJlc0luEiEKBGRhdGEYBiABKAsyDS5wYi5Mb2dpbkRhdGFSBGRhdGESLgoTdHdvX2ZhY3Rvcl9yZXF1aXJlZBgHIAEoCFIRdHdvRmFjdG9yUmVxdWlyZWQSKAoQdHdvX2ZhY3Rvcl90b2tlbhgIIAEoCVIOdHdvRmFjdG9yVG9rZW4=');
@$core.Deprecated('Use loginDataDescriptor instead')
const LoginData$json = const {
  '1': 'LoginData',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    const {'1': 'session', '3': 2, '4': 1, '5': 11, '6': '.pb.Session', '10': 'session'},
    const {'1': 'has_passcode', '3': 3, '4': 1, '5': 8, '10': 'hasPasscode'},
    const {'1': 'has_transaction_pin', '3': 4, '4': 1, '5': 8, '10': 'hasTransactionPin'},
  ],
};

/// Descriptor for `LoginData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginDataDescriptor = $convert.base64Decode('CglMb2dpbkRhdGESHAoEdXNlchgBIAEoCzIILnBiLlVzZXJSBHVzZXISJQoHc2Vzc2lvbhgCIAEoCzILLnBiLlNlc3Npb25SB3Nlc3Npb24SIQoMaGFzX3Bhc3Njb2RlGAMgASgIUgtoYXNQYXNzY29kZRIuChNoYXNfdHJhbnNhY3Rpb25fcGluGAQgASgIUhFoYXNUcmFuc2FjdGlvblBpbg==');
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
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `RefreshTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenResponseDescriptor = $convert.base64Decode('ChRSZWZyZXNoVG9rZW5SZXNwb25zZRIhCgxhY2Nlc3NfdG9rZW4YASABKAlSC2FjY2Vzc1Rva2VuEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbhIdCgpleHBpcmVzX2luGAMgASgDUglleHBpcmVzSW4SHAoEdXNlchgEIAEoCzIILnBiLlVzZXJSBHVzZXI=');
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
    const {'1': 'phone', '3': 2, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'delivery_method', '3': 3, '4': 1, '5': 14, '6': '.pb.PasswordResetDeliveryMethod', '10': 'deliveryMethod'},
  ],
};

/// Descriptor for `ForgotPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordRequestDescriptor = $convert.base64Decode('ChVGb3Jnb3RQYXNzd29yZFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhQKBXBob25lGAIgASgJUgVwaG9uZRJICg9kZWxpdmVyeV9tZXRob2QYAyABKA4yHy5wYi5QYXNzd29yZFJlc2V0RGVsaXZlcnlNZXRob2RSDmRlbGl2ZXJ5TWV0aG9k');
@$core.Deprecated('Use forgotPasswordResponseDescriptor instead')
const ForgotPasswordResponse$json = const {
  '1': 'ForgotPasswordResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'delivery_method', '3': 3, '4': 1, '5': 9, '10': 'deliveryMethod'},
    const {'1': 'masked_contact', '3': 4, '4': 1, '5': 9, '10': 'maskedContact'},
    const {'1': 'expires_in_seconds', '3': 5, '4': 1, '5': 3, '10': 'expiresInSeconds'},
    const {'1': 'user_found', '3': 6, '4': 1, '5': 8, '10': 'userFound'},
  ],
};

/// Descriptor for `ForgotPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordResponseDescriptor = $convert.base64Decode('ChZGb3Jnb3RQYXNzd29yZFJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxInCg9kZWxpdmVyeV9tZXRob2QYAyABKAlSDmRlbGl2ZXJ5TWV0aG9kEiUKDm1hc2tlZF9jb250YWN0GAQgASgJUg1tYXNrZWRDb250YWN0EiwKEmV4cGlyZXNfaW5fc2Vjb25kcxgFIAEoA1IQZXhwaXJlc0luU2Vjb25kcxIdCgp1c2VyX2ZvdW5kGAYgASgIUgl1c2VyRm91bmQ=');
@$core.Deprecated('Use verifyPasswordResetCodeRequestDescriptor instead')
const VerifyPasswordResetCodeRequest$json = const {
  '1': 'VerifyPasswordResetCodeRequest',
  '2': const [
    const {'1': 'contact', '3': 1, '4': 1, '5': 9, '10': 'contact'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'delivery_method', '3': 3, '4': 1, '5': 14, '6': '.pb.PasswordResetDeliveryMethod', '10': 'deliveryMethod'},
  ],
};

/// Descriptor for `VerifyPasswordResetCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasswordResetCodeRequestDescriptor = $convert.base64Decode('Ch5WZXJpZnlQYXNzd29yZFJlc2V0Q29kZVJlcXVlc3QSGAoHY29udGFjdBgBIAEoCVIHY29udGFjdBISCgRjb2RlGAIgASgJUgRjb2RlEkgKD2RlbGl2ZXJ5X21ldGhvZBgDIAEoDjIfLnBiLlBhc3N3b3JkUmVzZXREZWxpdmVyeU1ldGhvZFIOZGVsaXZlcnlNZXRob2Q=');
@$core.Deprecated('Use verifyPasswordResetCodeResponseDescriptor instead')
const VerifyPasswordResetCodeResponse$json = const {
  '1': 'VerifyPasswordResetCodeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'reset_token', '3': 3, '4': 1, '5': 9, '10': 'resetToken'},
    const {'1': 'expires_in_seconds', '3': 4, '4': 1, '5': 3, '10': 'expiresInSeconds'},
  ],
};

/// Descriptor for `VerifyPasswordResetCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasswordResetCodeResponseDescriptor = $convert.base64Decode('Ch9WZXJpZnlQYXNzd29yZFJlc2V0Q29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgtyZXNldF90b2tlbhgDIAEoCVIKcmVzZXRUb2tlbhIsChJleHBpcmVzX2luX3NlY29uZHMYBCABKANSEGV4cGlyZXNJblNlY29uZHM=');
@$core.Deprecated('Use resetPasswordRequestDescriptor instead')
const ResetPasswordRequest$json = const {
  '1': 'ResetPasswordRequest',
  '2': const [
    const {'1': 'reset_token', '3': 1, '4': 1, '5': 9, '10': 'resetToken'},
    const {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ResetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordRequestDescriptor = $convert.base64Decode('ChRSZXNldFBhc3N3b3JkUmVxdWVzdBIfCgtyZXNldF90b2tlbhgBIAEoCVIKcmVzZXRUb2tlbhIhCgxuZXdfcGFzc3dvcmQYAiABKAlSC25ld1Bhc3N3b3Jk');
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
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `GetMeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeResponseDescriptor = $convert.base64Decode('Cg1HZXRNZVJlc3BvbnNlEhwKBHVzZXIYASABKAsyCC5wYi5Vc2VyUgR1c2Vy');
@$core.Deprecated('Use updateProfileRequestDescriptor instead')
const UpdateProfileRequest$json = const {
  '1': 'UpdateProfileRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'profile_picture', '3': 6, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `UpdateProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProfileRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVQcm9maWxlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHQoKZmlyc3RfbmFtZRgCIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgDIAEoCVIIbGFzdE5hbWUSGgoIdXNlcm5hbWUYBCABKAlSCHVzZXJuYW1lEhQKBXBob25lGAUgASgJUgVwaG9uZRInCg9wcm9maWxlX3BpY3R1cmUYBiABKAlSDnByb2ZpbGVQaWN0dXJl');
@$core.Deprecated('Use updateProfileResponseDescriptor instead')
const UpdateProfileResponse$json = const {
  '1': 'UpdateProfileResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `UpdateProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProfileResponseDescriptor = $convert.base64Decode('ChVVcGRhdGVQcm9maWxlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAiABKAlSA21zZxIcCgR1c2VyGAMgASgLMggucGIuVXNlclIEdXNlcg==');
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
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `FacialLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialLoginResponseDescriptor = $convert.base64Decode('ChNGYWNpYWxMb2dpblJlc3BvbnNlEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJbhIcCgR1c2VyGAQgASgLMggucGIuVXNlclIEdXNlcg==');
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
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    const {'1': 'is_new_user', '3': 5, '4': 1, '5': 8, '10': 'isNewUser'},
  ],
};

/// Descriptor for `SocialLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialLoginResponseDescriptor = $convert.base64Decode('ChNTb2NpYWxMb2dpblJlc3BvbnNlEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJbhIcCgR1c2VyGAQgASgLMggucGIuVXNlclIEdXNlchIeCgtpc19uZXdfdXNlchgFIAEoCFIJaXNOZXdVc2Vy');
@$core.Deprecated('Use linkedSocialAccountDescriptor instead')
const LinkedSocialAccount$json = const {
  '1': 'LinkedSocialAccount',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_user_id', '3': 4, '4': 1, '5': 9, '10': 'providerUserId'},
    const {'1': 'provider_email', '3': 5, '4': 1, '5': 9, '10': 'providerEmail'},
    const {'1': 'display_name', '3': 6, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'profile_picture_url', '3': 7, '4': 1, '5': 9, '10': 'profilePictureUrl'},
    const {'1': 'profile_url', '3': 8, '4': 1, '5': 9, '10': 'profileUrl'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'is_primary', '3': 10, '4': 1, '5': 8, '10': 'isPrimary'},
    const {'1': 'linked_at', '3': 11, '4': 1, '5': 9, '10': 'linkedAt'},
    const {'1': 'last_used_at', '3': 12, '4': 1, '5': 9, '10': 'lastUsedAt'},
  ],
};

/// Descriptor for `LinkedSocialAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedSocialAccountDescriptor = $convert.base64Decode('ChNMaW5rZWRTb2NpYWxBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSGgoIcHJvdmlkZXIYAyABKAlSCHByb3ZpZGVyEigKEHByb3ZpZGVyX3VzZXJfaWQYBCABKAlSDnByb3ZpZGVyVXNlcklkEiUKDnByb3ZpZGVyX2VtYWlsGAUgASgJUg1wcm92aWRlckVtYWlsEiEKDGRpc3BsYXlfbmFtZRgGIAEoCVILZGlzcGxheU5hbWUSLgoTcHJvZmlsZV9waWN0dXJlX3VybBgHIAEoCVIRcHJvZmlsZVBpY3R1cmVVcmwSHwoLcHJvZmlsZV91cmwYCCABKAlSCnByb2ZpbGVVcmwSFgoGc3RhdHVzGAkgASgJUgZzdGF0dXMSHQoKaXNfcHJpbWFyeRgKIAEoCFIJaXNQcmltYXJ5EhsKCWxpbmtlZF9hdBgLIAEoCVIIbGlua2VkQXQSIAoMbGFzdF91c2VkX2F0GAwgASgJUgpsYXN0VXNlZEF0');
@$core.Deprecated('Use getLinkedSocialAccountsRequestDescriptor instead')
const GetLinkedSocialAccountsRequest$json = const {
  '1': 'GetLinkedSocialAccountsRequest',
};

/// Descriptor for `GetLinkedSocialAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedSocialAccountsRequestDescriptor = $convert.base64Decode('Ch5HZXRMaW5rZWRTb2NpYWxBY2NvdW50c1JlcXVlc3Q=');
@$core.Deprecated('Use getLinkedSocialAccountsResponseDescriptor instead')
const GetLinkedSocialAccountsResponse$json = const {
  '1': 'GetLinkedSocialAccountsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'accounts', '3': 2, '4': 3, '5': 11, '6': '.pb.LinkedSocialAccount', '10': 'accounts'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetLinkedSocialAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedSocialAccountsResponseDescriptor = $convert.base64Decode('Ch9HZXRMaW5rZWRTb2NpYWxBY2NvdW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSMwoIYWNjb3VudHMYAiADKAsyFy5wYi5MaW5rZWRTb2NpYWxBY2NvdW50UghhY2NvdW50cxIfCgt0b3RhbF9jb3VudBgDIAEoBVIKdG90YWxDb3VudA==');
@$core.Deprecated('Use linkSocialAccountRequestDescriptor instead')
const LinkSocialAccountRequest$json = const {
  '1': 'LinkSocialAccountRequest',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
    const {'1': 'provider_user_id', '3': 3, '4': 1, '5': 9, '10': 'providerUserId'},
    const {'1': 'provider_email', '3': 4, '4': 1, '5': 9, '10': 'providerEmail'},
    const {'1': 'display_name', '3': 5, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'profile_picture_url', '3': 6, '4': 1, '5': 9, '10': 'profilePictureUrl'},
    const {'1': 'profile_url', '3': 7, '4': 1, '5': 9, '10': 'profileUrl'},
    const {'1': 'set_as_primary', '3': 8, '4': 1, '5': 8, '10': 'setAsPrimary'},
  ],
};

/// Descriptor for `LinkSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkSocialAccountRequestDescriptor = $convert.base64Decode('ChhMaW5rU29jaWFsQWNjb3VudFJlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEiUKDnByb3ZpZGVyX3Rva2VuGAIgASgJUg1wcm92aWRlclRva2VuEigKEHByb3ZpZGVyX3VzZXJfaWQYAyABKAlSDnByb3ZpZGVyVXNlcklkEiUKDnByb3ZpZGVyX2VtYWlsGAQgASgJUg1wcm92aWRlckVtYWlsEiEKDGRpc3BsYXlfbmFtZRgFIAEoCVILZGlzcGxheU5hbWUSLgoTcHJvZmlsZV9waWN0dXJlX3VybBgGIAEoCVIRcHJvZmlsZVBpY3R1cmVVcmwSHwoLcHJvZmlsZV91cmwYByABKAlSCnByb2ZpbGVVcmwSJAoOc2V0X2FzX3ByaW1hcnkYCCABKAhSDHNldEFzUHJpbWFyeQ==');
@$core.Deprecated('Use linkSocialAccountResponseDescriptor instead')
const LinkSocialAccountResponse$json = const {
  '1': 'LinkSocialAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'account', '3': 3, '4': 1, '5': 11, '6': '.pb.LinkedSocialAccount', '10': 'account'},
  ],
};

/// Descriptor for `LinkSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkSocialAccountResponseDescriptor = $convert.base64Decode('ChlMaW5rU29jaWFsQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIxCgdhY2NvdW50GAMgASgLMhcucGIuTGlua2VkU29jaWFsQWNjb3VudFIHYWNjb3VudA==');
@$core.Deprecated('Use unlinkSocialAccountRequestDescriptor instead')
const UnlinkSocialAccountRequest$json = const {
  '1': 'UnlinkSocialAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `UnlinkSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkSocialAccountRequestDescriptor = $convert.base64Decode('ChpVbmxpbmtTb2NpYWxBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');
@$core.Deprecated('Use unlinkSocialAccountResponseDescriptor instead')
const UnlinkSocialAccountResponse$json = const {
  '1': 'UnlinkSocialAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnlinkSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkSocialAccountResponseDescriptor = $convert.base64Decode('ChtVbmxpbmtTb2NpYWxBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use setPrimarySocialAccountRequestDescriptor instead')
const SetPrimarySocialAccountRequest$json = const {
  '1': 'SetPrimarySocialAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `SetPrimarySocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrimarySocialAccountRequestDescriptor = $convert.base64Decode('Ch5TZXRQcmltYXJ5U29jaWFsQWNjb3VudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElk');
@$core.Deprecated('Use setPrimarySocialAccountResponseDescriptor instead')
const SetPrimarySocialAccountResponse$json = const {
  '1': 'SetPrimarySocialAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'account', '3': 3, '4': 1, '5': 11, '6': '.pb.LinkedSocialAccount', '10': 'account'},
  ],
};

/// Descriptor for `SetPrimarySocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrimarySocialAccountResponseDescriptor = $convert.base64Decode('Ch9TZXRQcmltYXJ5U29jaWFsQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIxCgdhY2NvdW50GAMgASgLMhcucGIuTGlua2VkU29jaWFsQWNjb3VudFIHYWNjb3VudA==');
@$core.Deprecated('Use reauthorizeSocialAccountRequestDescriptor instead')
const ReauthorizeSocialAccountRequest$json = const {
  '1': 'ReauthorizeSocialAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
  ],
};

/// Descriptor for `ReauthorizeSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reauthorizeSocialAccountRequestDescriptor = $convert.base64Decode('Ch9SZWF1dGhvcml6ZVNvY2lhbEFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIlCg5wcm92aWRlcl90b2tlbhgCIAEoCVINcHJvdmlkZXJUb2tlbg==');
@$core.Deprecated('Use reauthorizeSocialAccountResponseDescriptor instead')
const ReauthorizeSocialAccountResponse$json = const {
  '1': 'ReauthorizeSocialAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'account', '3': 3, '4': 1, '5': 11, '6': '.pb.LinkedSocialAccount', '10': 'account'},
  ],
};

/// Descriptor for `ReauthorizeSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reauthorizeSocialAccountResponseDescriptor = $convert.base64Decode('CiBSZWF1dGhvcml6ZVNvY2lhbEFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USMQoHYWNjb3VudBgDIAEoCzIXLnBiLkxpbmtlZFNvY2lhbEFjY291bnRSB2FjY291bnQ=');
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
    const {'1': 'backup_codes', '3': 4, '4': 3, '5': 9, '10': 'backupCodes'},
    const {'1': 'method_name', '3': 5, '4': 1, '5': 9, '10': 'methodName'},
    const {'1': 'verification_required', '3': 6, '4': 1, '5': 8, '10': 'verificationRequired'},
  ],
};

/// Descriptor for `EnableTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableTwoFactorResponseDescriptor = $convert.base64Decode('ChdFbmFibGVUd29GYWN0b3JSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEhcKB3FyX2NvZGUYAiABKAlSBnFyQ29kZRIWCgZzZWNyZXQYAyABKAlSBnNlY3JldBIhCgxiYWNrdXBfY29kZXMYBCADKAlSC2JhY2t1cENvZGVzEh8KC21ldGhvZF9uYW1lGAUgASgJUgptZXRob2ROYW1lEjMKFXZlcmlmaWNhdGlvbl9yZXF1aXJlZBgGIAEoCFIUdmVyaWZpY2F0aW9uUmVxdWlyZWQ=');
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
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `VerifyTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTwoFactorResponseDescriptor = $convert.base64Decode('ChdWZXJpZnlUd29GYWN0b3JSZXNwb25zZRIhCgxhY2Nlc3NfdG9rZW4YASABKAlSC2FjY2Vzc1Rva2VuEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbhIdCgpleHBpcmVzX2luGAMgASgDUglleHBpcmVzSW4SHAoEdXNlchgEIAEoCzIILnBiLlVzZXJSBHVzZXI=');
@$core.Deprecated('Use completeTwoFactorSetupRequestDescriptor instead')
const CompleteTwoFactorSetupRequest$json = const {
  '1': 'CompleteTwoFactorSetupRequest',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `CompleteTwoFactorSetupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeTwoFactorSetupRequestDescriptor = $convert.base64Decode('Ch1Db21wbGV0ZVR3b0ZhY3RvclNldHVwUmVxdWVzdBISCgRjb2RlGAEgASgJUgRjb2Rl');
@$core.Deprecated('Use completeTwoFactorSetupResponseDescriptor instead')
const CompleteTwoFactorSetupResponse$json = const {
  '1': 'CompleteTwoFactorSetupResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CompleteTwoFactorSetupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeTwoFactorSetupResponseDescriptor = $convert.base64Decode('Ch5Db21wbGV0ZVR3b0ZhY3RvclNldHVwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use disableTwoFactorRequestDescriptor instead')
const DisableTwoFactorRequest$json = const {
  '1': 'DisableTwoFactorRequest',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `DisableTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableTwoFactorRequestDescriptor = $convert.base64Decode('ChdEaXNhYmxlVHdvRmFjdG9yUmVxdWVzdBISCgRjb2RlGAEgASgJUgRjb2Rl');
@$core.Deprecated('Use disableTwoFactorResponseDescriptor instead')
const DisableTwoFactorResponse$json = const {
  '1': 'DisableTwoFactorResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DisableTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableTwoFactorResponseDescriptor = $convert.base64Decode('ChhEaXNhYmxlVHdvRmFjdG9yUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getTwoFactorStatusRequestDescriptor instead')
const GetTwoFactorStatusRequest$json = const {
  '1': 'GetTwoFactorStatusRequest',
};

/// Descriptor for `GetTwoFactorStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTwoFactorStatusRequestDescriptor = $convert.base64Decode('ChlHZXRUd29GYWN0b3JTdGF0dXNSZXF1ZXN0');
@$core.Deprecated('Use getTwoFactorStatusResponseDescriptor instead')
const GetTwoFactorStatusResponse$json = const {
  '1': 'GetTwoFactorStatusResponse',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    const {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
    const {'1': 'method_name', '3': 3, '4': 1, '5': 9, '10': 'methodName'},
    const {'1': 'method_description', '3': 4, '4': 1, '5': 9, '10': 'methodDescription'},
    const {'1': 'backup_codes_count', '3': 5, '4': 1, '5': 5, '10': 'backupCodesCount'},
    const {'1': 'has_backup_codes', '3': 6, '4': 1, '5': 8, '10': 'hasBackupCodes'},
  ],
};

/// Descriptor for `GetTwoFactorStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTwoFactorStatusResponseDescriptor = $convert.base64Decode('ChpHZXRUd29GYWN0b3JTdGF0dXNSZXNwb25zZRIYCgdlbmFibGVkGAEgASgIUgdlbmFibGVkEhYKBm1ldGhvZBgCIAEoCVIGbWV0aG9kEh8KC21ldGhvZF9uYW1lGAMgASgJUgptZXRob2ROYW1lEi0KEm1ldGhvZF9kZXNjcmlwdGlvbhgEIAEoCVIRbWV0aG9kRGVzY3JpcHRpb24SLAoSYmFja3VwX2NvZGVzX2NvdW50GAUgASgFUhBiYWNrdXBDb2Rlc0NvdW50EigKEGhhc19iYWNrdXBfY29kZXMYBiABKAhSDmhhc0JhY2t1cENvZGVz');
@$core.Deprecated('Use regenerateBackupCodesRequestDescriptor instead')
const RegenerateBackupCodesRequest$json = const {
  '1': 'RegenerateBackupCodesRequest',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `RegenerateBackupCodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List regenerateBackupCodesRequestDescriptor = $convert.base64Decode('ChxSZWdlbmVyYXRlQmFja3VwQ29kZXNSZXF1ZXN0EhIKBGNvZGUYASABKAlSBGNvZGU=');
@$core.Deprecated('Use regenerateBackupCodesResponseDescriptor instead')
const RegenerateBackupCodesResponse$json = const {
  '1': 'RegenerateBackupCodesResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'backup_codes', '3': 3, '4': 3, '5': 9, '10': 'backupCodes'},
  ],
};

/// Descriptor for `RegenerateBackupCodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List regenerateBackupCodesResponseDescriptor = $convert.base64Decode('Ch1SZWdlbmVyYXRlQmFja3VwQ29kZXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIQoMYmFja3VwX2NvZGVzGAMgAygJUgtiYWNrdXBDb2Rlcw==');
@$core.Deprecated('Use sendTwoFactorCodeRequestDescriptor instead')
const SendTwoFactorCodeRequest$json = const {
  '1': 'SendTwoFactorCodeRequest',
};

/// Descriptor for `SendTwoFactorCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendTwoFactorCodeRequestDescriptor = $convert.base64Decode('ChhTZW5kVHdvRmFjdG9yQ29kZVJlcXVlc3Q=');
@$core.Deprecated('Use sendTwoFactorCodeResponseDescriptor instead')
const SendTwoFactorCodeResponse$json = const {
  '1': 'SendTwoFactorCodeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
  ],
};

/// Descriptor for `SendTwoFactorCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendTwoFactorCodeResponseDescriptor = $convert.base64Decode('ChlTZW5kVHdvRmFjdG9yQ29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIdCgpleHBpcmVzX2luGAMgASgDUglleHBpcmVzSW4=');
@$core.Deprecated('Use getAvailable2FAMethodsRequestDescriptor instead')
const GetAvailable2FAMethodsRequest$json = const {
  '1': 'GetAvailable2FAMethodsRequest',
};

/// Descriptor for `GetAvailable2FAMethodsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailable2FAMethodsRequestDescriptor = $convert.base64Decode('Ch1HZXRBdmFpbGFibGUyRkFNZXRob2RzUmVxdWVzdA==');
@$core.Deprecated('Use twoFactorMethodInfoDescriptor instead')
const TwoFactorMethodInfo$json = const {
  '1': 'TwoFactorMethodInfo',
  '2': const [
    const {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'icon', '3': 4, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'available', '3': 5, '4': 1, '5': 8, '10': 'available'},
  ],
};

/// Descriptor for `TwoFactorMethodInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List twoFactorMethodInfoDescriptor = $convert.base64Decode('ChNUd29GYWN0b3JNZXRob2RJbmZvEhYKBm1ldGhvZBgBIAEoCVIGbWV0aG9kEhIKBG5hbWUYAiABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhIKBGljb24YBCABKAlSBGljb24SHAoJYXZhaWxhYmxlGAUgASgIUglhdmFpbGFibGU=');
@$core.Deprecated('Use getAvailable2FAMethodsResponseDescriptor instead')
const GetAvailable2FAMethodsResponse$json = const {
  '1': 'GetAvailable2FAMethodsResponse',
  '2': const [
    const {'1': 'methods', '3': 1, '4': 3, '5': 11, '6': '.pb.TwoFactorMethodInfo', '10': 'methods'},
  ],
};

/// Descriptor for `GetAvailable2FAMethodsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailable2FAMethodsResponseDescriptor = $convert.base64Decode('Ch5HZXRBdmFpbGFibGUyRkFNZXRob2RzUmVzcG9uc2USMQoHbWV0aG9kcxgBIAMoCzIXLnBiLlR3b0ZhY3Rvck1ldGhvZEluZm9SB21ldGhvZHM=');
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
    const {'1': 'signup_status', '3': 14, '4': 1, '5': 9, '10': 'signupStatus'},
    const {'1': 'current_signup_step', '3': 15, '4': 1, '5': 9, '10': 'currentSignupStep'},
    const {'1': 'username', '3': 16, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'identity_verified', '3': 17, '4': 1, '5': 8, '10': 'identityVerified'},
    const {'1': 'identity_type', '3': 18, '4': 1, '5': 9, '10': 'identityType'},
    const {'1': 'identity_verified_at', '3': 19, '4': 1, '5': 9, '10': 'identityVerifiedAt'},
    const {'1': 'date_of_birth', '3': 20, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'kyc_tier', '3': 21, '4': 1, '5': 5, '10': 'kycTier'},
    const {'1': 'kyc_status', '3': 22, '4': 1, '5': 9, '10': 'kycStatus'},
    const {'1': 'roles', '3': 23, '4': 3, '5': 9, '10': 'roles'},
    const {'1': 'role', '3': 24, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSFAoFcGhvbmUYBSABKAlSBXBob25lEiEKDGNvdW50cnlfY29kZRgGIAEoCVILY291bnRyeUNvZGUSJQoOZW1haWxfdmVyaWZpZWQYByABKAhSDWVtYWlsVmVyaWZpZWQSJQoOcGhvbmVfdmVyaWZpZWQYCCABKAhSDXBob25lVmVyaWZpZWQSLAoSdHdvX2ZhY3Rvcl9lbmFibGVkGAkgASgIUhB0d29GYWN0b3JFbmFibGVkEioKEXR3b19mYWN0b3JfbWV0aG9kGAogASgJUg90d29GYWN0b3JNZXRob2QSJwoPcHJvZmlsZV9waWN0dXJlGAsgASgJUg5wcm9maWxlUGljdHVyZRIdCgpjcmVhdGVkX2F0GAwgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgNIAEoCVIJdXBkYXRlZEF0EiMKDXNpZ251cF9zdGF0dXMYDiABKAlSDHNpZ251cFN0YXR1cxIuChNjdXJyZW50X3NpZ251cF9zdGVwGA8gASgJUhFjdXJyZW50U2lnbnVwU3RlcBIaCgh1c2VybmFtZRgQIAEoCVIIdXNlcm5hbWUSKwoRaWRlbnRpdHlfdmVyaWZpZWQYESABKAhSEGlkZW50aXR5VmVyaWZpZWQSIwoNaWRlbnRpdHlfdHlwZRgSIAEoCVIMaWRlbnRpdHlUeXBlEjAKFGlkZW50aXR5X3ZlcmlmaWVkX2F0GBMgASgJUhJpZGVudGl0eVZlcmlmaWVkQXQSIgoNZGF0ZV9vZl9iaXJ0aBgUIAEoCVILZGF0ZU9mQmlydGgSGQoIa3ljX3RpZXIYFSABKAVSB2t5Y1RpZXISHQoKa3ljX3N0YXR1cxgWIAEoCVIJa3ljU3RhdHVzEhQKBXJvbGVzGBcgAygJUgVyb2xlcxISCgRyb2xlGBggASgJUgRyb2xl');
@$core.Deprecated('Use signupStepProgressDescriptor instead')
const SignupStepProgress$json = const {
  '1': 'SignupStepProgress',
  '2': const [
    const {'1': 'step_name', '3': 1, '4': 1, '5': 9, '10': 'stepName'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.StepStatus', '10': 'status'},
    const {'1': 'step_data', '3': 3, '4': 1, '5': 9, '10': 'stepData'},
    const {'1': 'completed_at', '3': 4, '4': 1, '5': 9, '10': 'completedAt'},
    const {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 6, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SignupStepProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupStepProgressDescriptor = $convert.base64Decode('ChJTaWdudXBTdGVwUHJvZ3Jlc3MSGwoJc3RlcF9uYW1lGAEgASgJUghzdGVwTmFtZRImCgZzdGF0dXMYAiABKA4yDi5wYi5TdGVwU3RhdHVzUgZzdGF0dXMSGwoJc3RlcF9kYXRhGAMgASgJUghzdGVwRGF0YRIhCgxjb21wbGV0ZWRfYXQYBCABKAlSC2NvbXBsZXRlZEF0Eh0KCmNyZWF0ZWRfYXQYBSABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAYgASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use signupProgressDescriptor instead')
const SignupProgress$json = const {
  '1': 'SignupProgress',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.SignupStatus', '10': 'status'},
    const {'1': 'current_step', '3': 3, '4': 1, '5': 9, '10': 'currentStep'},
    const {'1': 'steps', '3': 4, '4': 3, '5': 11, '6': '.pb.SignupStepProgress', '10': 'steps'},
    const {'1': 'signup_completed_at', '3': 5, '4': 1, '5': 9, '10': 'signupCompletedAt'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 7, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SignupProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupProgressDescriptor = $convert.base64Decode('Cg5TaWdudXBQcm9ncmVzcxIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKAoGc3RhdHVzGAIgASgOMhAucGIuU2lnbnVwU3RhdHVzUgZzdGF0dXMSIQoMY3VycmVudF9zdGVwGAMgASgJUgtjdXJyZW50U3RlcBIsCgVzdGVwcxgEIAMoCzIWLnBiLlNpZ251cFN0ZXBQcm9ncmVzc1IFc3RlcHMSLgoTc2lnbnVwX2NvbXBsZXRlZF9hdBgFIAEoCVIRc2lnbnVwQ29tcGxldGVkQXQSHQoKY3JlYXRlZF9hdBgGIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYByABKAlSCXVwZGF0ZWRBdA==');
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
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.pb.SignupProgress', '10': 'progress'},
    const {'1': 'next_step', '3': 4, '4': 1, '5': 9, '10': 'nextStep'},
    const {'1': 'is_complete', '3': 5, '4': 1, '5': 8, '10': 'isComplete'},
  ],
};

/// Descriptor for `GetSignupProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSignupProgressResponseDescriptor = $convert.base64Decode('ChlHZXRTaWdudXBQcm9ncmVzc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSLgoIcHJvZ3Jlc3MYAyABKAsyEi5wYi5TaWdudXBQcm9ncmVzc1IIcHJvZ3Jlc3MSGwoJbmV4dF9zdGVwGAQgASgJUghuZXh0U3RlcBIfCgtpc19jb21wbGV0ZRgFIAEoCFIKaXNDb21wbGV0ZQ==');
@$core.Deprecated('Use updateSignupStepRequestDescriptor instead')
const UpdateSignupStepRequest$json = const {
  '1': 'UpdateSignupStepRequest',
  '2': const [
    const {'1': 'step_name', '3': 1, '4': 1, '5': 9, '10': 'stepName'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.StepStatus', '10': 'status'},
    const {'1': 'step_data', '3': 3, '4': 1, '5': 9, '10': 'stepData'},
  ],
};

/// Descriptor for `UpdateSignupStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSignupStepRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVTaWdudXBTdGVwUmVxdWVzdBIbCglzdGVwX25hbWUYASABKAlSCHN0ZXBOYW1lEiYKBnN0YXR1cxgCIAEoDjIOLnBiLlN0ZXBTdGF0dXNSBnN0YXR1cxIbCglzdGVwX2RhdGEYAyABKAlSCHN0ZXBEYXRh');
@$core.Deprecated('Use updateSignupStepResponseDescriptor instead')
const UpdateSignupStepResponse$json = const {
  '1': 'UpdateSignupStepResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.pb.SignupProgress', '10': 'progress'},
    const {'1': 'next_step', '3': 4, '4': 1, '5': 9, '10': 'nextStep'},
  ],
};

/// Descriptor for `UpdateSignupStepResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSignupStepResponseDescriptor = $convert.base64Decode('ChhVcGRhdGVTaWdudXBTdGVwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAiABKAlSA21zZxIuCghwcm9ncmVzcxgDIAEoCzISLnBiLlNpZ251cFByb2dyZXNzUghwcm9ncmVzcxIbCgluZXh0X3N0ZXAYBCABKAlSCG5leHRTdGVw');
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
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.pb.SignupProgress', '10': 'progress'},
  ],
};

/// Descriptor for `CompleteSignupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeSignupResponseDescriptor = $convert.base64Decode('ChZDb21wbGV0ZVNpZ251cFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSLgoIcHJvZ3Jlc3MYAyABKAsyEi5wYi5TaWdudXBQcm9ncmVzc1IIcHJvZ3Jlc3M=');
@$core.Deprecated('Use verifyIdentityRequestDescriptor instead')
const VerifyIdentityRequest$json = const {
  '1': 'VerifyIdentityRequest',
  '2': const [
    const {'1': 'identity_type', '3': 1, '4': 1, '5': 14, '6': '.pb.IdentityType', '10': 'identityType'},
    const {'1': 'identity_number', '3': 2, '4': 1, '5': 9, '10': 'identityNumber'},
    const {'1': 'date_of_birth', '3': 3, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'first_name', '3': 5, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 6, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyIdentityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIdentityRequestDescriptor = $convert.base64Decode('ChVWZXJpZnlJZGVudGl0eVJlcXVlc3QSNQoNaWRlbnRpdHlfdHlwZRgBIAEoDjIQLnBiLklkZW50aXR5VHlwZVIMaWRlbnRpdHlUeXBlEicKD2lkZW50aXR5X251bWJlchgCIAEoCVIOaWRlbnRpdHlOdW1iZXISIgoNZGF0ZV9vZl9iaXJ0aBgDIAEoCVILZGF0ZU9mQmlydGgSIQoMY291bnRyeV9jb2RlGAQgASgJUgtjb3VudHJ5Q29kZRIdCgpmaXJzdF9uYW1lGAUgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAYgASgJUghsYXN0TmFtZRIhCgxwaG9uZV9udW1iZXIYByABKAlSC3Bob25lTnVtYmVy');
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
@$core.Deprecated('Use verifyIdentityResponseDescriptor instead')
const VerifyIdentityResponse$json = const {
  '1': 'VerifyIdentityResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'error_code', '3': 3, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'identity', '3': 5, '4': 1, '5': 11, '6': '.pb.VerifiedIdentity', '10': 'identity'},
    const {'1': 'virtual_account', '3': 6, '4': 1, '5': 11, '6': '.pb.VirtualAccountInfo', '10': 'virtualAccount'},
    const {'1': 'verification_id', '3': 7, '4': 1, '5': 9, '10': 'verificationId'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'session_url', '3': 9, '4': 1, '5': 9, '10': 'sessionUrl'},
    const {'1': 'session_token', '3': 10, '4': 1, '5': 9, '10': 'sessionToken'},
    const {'1': 'reconciliation', '3': 11, '4': 1, '5': 11, '6': '.pb.DataReconciliation', '10': 'reconciliation'},
  ],
};

/// Descriptor for `VerifyIdentityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIdentityResponseDescriptor = $convert.base64Decode('ChZWZXJpZnlJZGVudGl0eVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGgoIdmVyaWZpZWQYAiABKAhSCHZlcmlmaWVkEh0KCmVycm9yX2NvZGUYAyABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAQgASgJUgxlcnJvck1lc3NhZ2USMAoIaWRlbnRpdHkYBSABKAsyFC5wYi5WZXJpZmllZElkZW50aXR5UghpZGVudGl0eRI/Cg92aXJ0dWFsX2FjY291bnQYBiABKAsyFi5wYi5WaXJ0dWFsQWNjb3VudEluZm9SDnZpcnR1YWxBY2NvdW50EicKD3ZlcmlmaWNhdGlvbl9pZBgHIAEoCVIOdmVyaWZpY2F0aW9uSWQSFgoGc3RhdHVzGAggASgJUgZzdGF0dXMSHwoLc2Vzc2lvbl91cmwYCSABKAlSCnNlc3Npb25VcmwSIwoNc2Vzc2lvbl90b2tlbhgKIAEoCVIMc2Vzc2lvblRva2VuEj4KDnJlY29uY2lsaWF0aW9uGAsgASgLMhYucGIuRGF0YVJlY29uY2lsaWF0aW9uUg5yZWNvbmNpbGlhdGlvbg==');
@$core.Deprecated('Use dataReconciliationDescriptor instead')
const DataReconciliation$json = const {
  '1': 'DataReconciliation',
  '2': const [
    const {'1': 'name_action', '3': 1, '4': 1, '5': 9, '10': 'nameAction'},
    const {'1': 'name_match_score', '3': 2, '4': 1, '5': 1, '10': 'nameMatchScore'},
    const {'1': 'verified_name', '3': 3, '4': 1, '5': 9, '10': 'verifiedName'},
    const {'1': 'profile_name', '3': 4, '4': 1, '5': 9, '10': 'profileName'},
    const {'1': 'dob_mismatch', '3': 5, '4': 1, '5': 8, '10': 'dobMismatch'},
    const {'1': 'verified_dob', '3': 6, '4': 1, '5': 9, '10': 'verifiedDob'},
    const {'1': 'profile_dob', '3': 7, '4': 1, '5': 9, '10': 'profileDob'},
    const {'1': 'phone_mismatch', '3': 8, '4': 1, '5': 8, '10': 'phoneMismatch'},
  ],
};

/// Descriptor for `DataReconciliation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataReconciliationDescriptor = $convert.base64Decode('ChJEYXRhUmVjb25jaWxpYXRpb24SHwoLbmFtZV9hY3Rpb24YASABKAlSCm5hbWVBY3Rpb24SKAoQbmFtZV9tYXRjaF9zY29yZRgCIAEoAVIObmFtZU1hdGNoU2NvcmUSIwoNdmVyaWZpZWRfbmFtZRgDIAEoCVIMdmVyaWZpZWROYW1lEiEKDHByb2ZpbGVfbmFtZRgEIAEoCVILcHJvZmlsZU5hbWUSIQoMZG9iX21pc21hdGNoGAUgASgIUgtkb2JNaXNtYXRjaBIhCgx2ZXJpZmllZF9kb2IYBiABKAlSC3ZlcmlmaWVkRG9iEh8KC3Byb2ZpbGVfZG9iGAcgASgJUgpwcm9maWxlRG9iEiUKDnBob25lX21pc21hdGNoGAggASgIUg1waG9uZU1pc21hdGNo');
@$core.Deprecated('Use confirmBVNNameRequestDescriptor instead')
const ConfirmBVNNameRequest$json = const {
  '1': 'ConfirmBVNNameRequest',
  '2': const [
    const {'1': 'action', '3': 1, '4': 1, '5': 9, '10': 'action'},
    const {'1': 'verification_id', '3': 2, '4': 1, '5': 9, '10': 'verificationId'},
  ],
};

/// Descriptor for `ConfirmBVNNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmBVNNameRequestDescriptor = $convert.base64Decode('ChVDb25maXJtQlZOTmFtZVJlcXVlc3QSFgoGYWN0aW9uGAEgASgJUgZhY3Rpb24SJwoPdmVyaWZpY2F0aW9uX2lkGAIgASgJUg52ZXJpZmljYXRpb25JZA==');
@$core.Deprecated('Use confirmBVNNameResponseDescriptor instead')
const ConfirmBVNNameResponse$json = const {
  '1': 'ConfirmBVNNameResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.KYCVerificationStatus', '10': 'status'},
    const {'1': 'current_tier', '3': 4, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'currentTier'},
  ],
};

/// Descriptor for `ConfirmBVNNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmBVNNameResponseDescriptor = $convert.base64Decode('ChZDb25maXJtQlZOTmFtZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIxCgZzdGF0dXMYAyABKA4yGS5wYi5LWUNWZXJpZmljYXRpb25TdGF0dXNSBnN0YXR1cxIuCgxjdXJyZW50X3RpZXIYBCABKA4yCy5wYi5LWUNUaWVyUgtjdXJyZW50VGllcg==');
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
@$core.Deprecated('Use getIdentityVerificationStatusRequestDescriptor instead')
const GetIdentityVerificationStatusRequest$json = const {
  '1': 'GetIdentityVerificationStatusRequest',
};

/// Descriptor for `GetIdentityVerificationStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIdentityVerificationStatusRequestDescriptor = $convert.base64Decode('CiRHZXRJZGVudGl0eVZlcmlmaWNhdGlvblN0YXR1c1JlcXVlc3Q=');
@$core.Deprecated('Use getIdentityVerificationStatusResponseDescriptor instead')
const GetIdentityVerificationStatusResponse$json = const {
  '1': 'GetIdentityVerificationStatusResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'identity_verified', '3': 3, '4': 1, '5': 8, '10': 'identityVerified'},
    const {'1': 'identity_type', '3': 4, '4': 1, '5': 14, '6': '.pb.IdentityType', '10': 'identityType'},
    const {'1': 'identity_verified_at', '3': 5, '4': 1, '5': 9, '10': 'identityVerifiedAt'},
    const {'1': 'masked_identity_number', '3': 6, '4': 1, '5': 9, '10': 'maskedIdentityNumber'},
  ],
};

/// Descriptor for `GetIdentityVerificationStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIdentityVerificationStatusResponseDescriptor = $convert.base64Decode('CiVHZXRJZGVudGl0eVZlcmlmaWNhdGlvblN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSKwoRaWRlbnRpdHlfdmVyaWZpZWQYAyABKAhSEGlkZW50aXR5VmVyaWZpZWQSNQoNaWRlbnRpdHlfdHlwZRgEIAEoDjIQLnBiLklkZW50aXR5VHlwZVIMaWRlbnRpdHlUeXBlEjAKFGlkZW50aXR5X3ZlcmlmaWVkX2F0GAUgASgJUhJpZGVudGl0eVZlcmlmaWVkQXQSNAoWbWFza2VkX2lkZW50aXR5X251bWJlchgGIAEoCVIUbWFza2VkSWRlbnRpdHlOdW1iZXI=');
@$core.Deprecated('Use lookupUserByUsernameRequestDescriptor instead')
const LookupUserByUsernameRequest$json = const {
  '1': 'LookupUserByUsernameRequest',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `LookupUserByUsernameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserByUsernameRequestDescriptor = $convert.base64Decode('ChtMb29rdXBVc2VyQnlVc2VybmFtZVJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW1l');
@$core.Deprecated('Use lookupUserByPhoneRequestDescriptor instead')
const LookupUserByPhoneRequest$json = const {
  '1': 'LookupUserByPhoneRequest',
  '2': const [
    const {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `LookupUserByPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserByPhoneRequestDescriptor = $convert.base64Decode('ChhMb29rdXBVc2VyQnlQaG9uZVJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25l');
@$core.Deprecated('Use userLookupResponseDescriptor instead')
const UserLookupResponse$json = const {
  '1': 'UserLookupResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'found', '3': 3, '4': 1, '5': 8, '10': 'found'},
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.pb.UserLookupResult', '10': 'user'},
  ],
};

/// Descriptor for `UserLookupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLookupResponseDescriptor = $convert.base64Decode('ChJVc2VyTG9va3VwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAiABKAlSA21zZxIUCgVmb3VuZBgDIAEoCFIFZm91bmQSKAoEdXNlchgEIAEoCzIULnBiLlVzZXJMb29rdXBSZXN1bHRSBHVzZXI=');
@$core.Deprecated('Use userLookupResultDescriptor instead')
const UserLookupResult$json = const {
  '1': 'UserLookupResult',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'profile_picture', '3': 5, '4': 1, '5': 9, '10': 'profilePicture'},
    const {'1': 'is_lazervault_user', '3': 6, '4': 1, '5': 8, '10': 'isLazervaultUser'},
    const {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'email', '3': 8, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'primary_account_id', '3': 9, '4': 1, '5': 9, '10': 'primaryAccountId'},
    const {'1': 'country_code', '3': 10, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'email_matches_search_query', '3': 11, '4': 1, '5': 8, '10': 'emailMatchesSearchQuery'},
    const {'1': 'phone_matches_search_query_exact', '3': 12, '4': 1, '5': 8, '10': 'phoneMatchesSearchQueryExact'},
  ],
};

/// Descriptor for `UserLookupResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLookupResultDescriptor = $convert.base64Decode('ChBVc2VyTG9va3VwUmVzdWx0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSJwoPcHJvZmlsZV9waWN0dXJlGAUgASgJUg5wcm9maWxlUGljdHVyZRIsChJpc19sYXplcnZhdWx0X3VzZXIYBiABKAhSEGlzTGF6ZXJ2YXVsdFVzZXISIQoMcGhvbmVfbnVtYmVyGAcgASgJUgtwaG9uZU51bWJlchIUCgVlbWFpbBgIIAEoCVIFZW1haWwSLAoScHJpbWFyeV9hY2NvdW50X2lkGAkgASgJUhBwcmltYXJ5QWNjb3VudElkEiEKDGNvdW50cnlfY29kZRgKIAEoCVILY291bnRyeUNvZGUSOwoaZW1haWxfbWF0Y2hlc19zZWFyY2hfcXVlcnkYCyABKAhSF2VtYWlsTWF0Y2hlc1NlYXJjaFF1ZXJ5EkYKIHBob25lX21hdGNoZXNfc2VhcmNoX3F1ZXJ5X2V4YWN0GAwgASgIUhxwaG9uZU1hdGNoZXNTZWFyY2hRdWVyeUV4YWN0');
@$core.Deprecated('Use userSearchRequestDescriptor instead')
const UserSearchRequest$json = const {
  '1': 'UserSearchRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'search_type', '3': 3, '4': 1, '5': 9, '10': 'searchType'},
    const {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `UserSearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSearchRequestDescriptor = $convert.base64Decode('ChFVc2VyU2VhcmNoUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSFAoFbGltaXQYAiABKAVSBWxpbWl0Eh8KC3NlYXJjaF90eXBlGAMgASgJUgpzZWFyY2hUeXBlEiEKDGNvdW50cnlfY29kZRgEIAEoCVILY291bnRyeUNvZGU=');
@$core.Deprecated('Use userSearchResponseDescriptor instead')
const UserSearchResponse$json = const {
  '1': 'UserSearchResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'users', '3': 3, '4': 3, '5': 11, '6': '.pb.UserLookupResult', '10': 'users'},
  ],
};

/// Descriptor for `UserSearchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSearchResponseDescriptor = $convert.base64Decode('ChJVc2VyU2VhcmNoUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAiABKAlSA21zZxIqCgV1c2VycxgDIAMoCzIULnBiLlVzZXJMb29rdXBSZXN1bHRSBXVzZXJz');
@$core.Deprecated('Use initiateKYCRequestDescriptor instead')
const InitiateKYCRequest$json = const {
  '1': 'InitiateKYCRequest',
  '2': const [
    const {'1': 'target_tier', '3': 1, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'targetTier'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `InitiateKYCRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCRequestDescriptor = $convert.base64Decode('ChJJbml0aWF0ZUtZQ1JlcXVlc3QSLAoLdGFyZ2V0X3RpZXIYASABKA4yCy5wYi5LWUNUaWVyUgp0YXJnZXRUaWVyEiEKDGNvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGU=');
@$core.Deprecated('Use initiateKYCResponseDescriptor instead')
const InitiateKYCResponse$json = const {
  '1': 'InitiateKYCResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'required_documents', '3': 3, '4': 3, '5': 9, '10': 'requiredDocuments'},
    const {'1': 'required_fields', '3': 4, '4': 3, '5': 9, '10': 'requiredFields'},
    const {'1': 'redirect_url', '3': 5, '4': 1, '5': 9, '10': 'redirectUrl'},
    const {'1': 'error_message', '3': 6, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `InitiateKYCResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCResponseDescriptor = $convert.base64Decode('ChNJbml0aWF0ZUtZQ1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKc2Vzc2lvbl9pZBgCIAEoCVIJc2Vzc2lvbklkEi0KEnJlcXVpcmVkX2RvY3VtZW50cxgDIAMoCVIRcmVxdWlyZWREb2N1bWVudHMSJwoPcmVxdWlyZWRfZmllbGRzGAQgAygJUg5yZXF1aXJlZEZpZWxkcxIhCgxyZWRpcmVjdF91cmwYBSABKAlSC3JlZGlyZWN0VXJsEiMKDWVycm9yX21lc3NhZ2UYBiABKAlSDGVycm9yTWVzc2FnZQ==');
@$core.Deprecated('Use uploadDocumentRequestDescriptor instead')
const UploadDocumentRequest$json = const {
  '1': 'UploadDocumentRequest',
  '2': const [
    const {'1': 'document_type', '3': 1, '4': 1, '5': 14, '6': '.pb.DocumentType', '10': 'documentType'},
    const {'1': 'document_front_url', '3': 2, '4': 1, '5': 9, '10': 'documentFrontUrl'},
    const {'1': 'document_back_url', '3': 3, '4': 1, '5': 9, '10': 'documentBackUrl'},
    const {'1': 'selfie_url', '3': 4, '4': 1, '5': 9, '10': 'selfieUrl'},
    const {'1': 'proof_of_address_url', '3': 5, '4': 1, '5': 9, '10': 'proofOfAddressUrl'},
  ],
};

/// Descriptor for `UploadDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadDocumentRequestDescriptor = $convert.base64Decode('ChVVcGxvYWREb2N1bWVudFJlcXVlc3QSNQoNZG9jdW1lbnRfdHlwZRgBIAEoDjIQLnBiLkRvY3VtZW50VHlwZVIMZG9jdW1lbnRUeXBlEiwKEmRvY3VtZW50X2Zyb250X3VybBgCIAEoCVIQZG9jdW1lbnRGcm9udFVybBIqChFkb2N1bWVudF9iYWNrX3VybBgDIAEoCVIPZG9jdW1lbnRCYWNrVXJsEh0KCnNlbGZpZV91cmwYBCABKAlSCXNlbGZpZVVybBIvChRwcm9vZl9vZl9hZGRyZXNzX3VybBgFIAEoCVIRcHJvb2ZPZkFkZHJlc3NVcmw=');
@$core.Deprecated('Use uploadDocumentResponseDescriptor instead')
const UploadDocumentResponse$json = const {
  '1': 'UploadDocumentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'document_id', '3': 3, '4': 1, '5': 9, '10': 'documentId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.pb.DocumentStatus', '10': 'status'},
  ],
};

/// Descriptor for `UploadDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadDocumentResponseDescriptor = $convert.base64Decode('ChZVcGxvYWREb2N1bWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgtkb2N1bWVudF9pZBgDIAEoCVIKZG9jdW1lbnRJZBIqCgZzdGF0dXMYBCABKA4yEi5wYi5Eb2N1bWVudFN0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use skipKYCUpgradeRequestDescriptor instead')
const SkipKYCUpgradeRequest$json = const {
  '1': 'SkipKYCUpgradeRequest',
  '2': const [
    const {'1': 'skip_tier_2', '3': 1, '4': 1, '5': 8, '10': 'skipTier2'},
    const {'1': 'skip_tier_3', '3': 2, '4': 1, '5': 8, '10': 'skipTier3'},
  ],
};

/// Descriptor for `SkipKYCUpgradeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCUpgradeRequestDescriptor = $convert.base64Decode('ChVTa2lwS1lDVXBncmFkZVJlcXVlc3QSHgoLc2tpcF90aWVyXzIYASABKAhSCXNraXBUaWVyMhIeCgtza2lwX3RpZXJfMxgCIAEoCFIJc2tpcFRpZXIz');
@$core.Deprecated('Use skipKYCUpgradeResponseDescriptor instead')
const SkipKYCUpgradeResponse$json = const {
  '1': 'SkipKYCUpgradeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'assigned_tier', '3': 2, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'assignedTier'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'next_steps', '3': 4, '4': 3, '5': 9, '10': 'nextSteps'},
  ],
};

/// Descriptor for `SkipKYCUpgradeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCUpgradeResponseDescriptor = $convert.base64Decode('ChZTa2lwS1lDVXBncmFkZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSMAoNYXNzaWduZWRfdGllchgCIAEoDjILLnBiLktZQ1RpZXJSDGFzc2lnbmVkVGllchIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEh0KCm5leHRfc3RlcHMYBCADKAlSCW5leHRTdGVwcw==');
@$core.Deprecated('Use getUserDocumentsRequestDescriptor instead')
const GetUserDocumentsRequest$json = const {
  '1': 'GetUserDocumentsRequest',
};

/// Descriptor for `GetUserDocumentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsRequestDescriptor = $convert.base64Decode('ChdHZXRVc2VyRG9jdW1lbnRzUmVxdWVzdA==');
@$core.Deprecated('Use verificationDocumentDescriptor instead')
const VerificationDocument$json = const {
  '1': 'VerificationDocument',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'document_type', '3': 2, '4': 1, '5': 14, '6': '.pb.DocumentType', '10': 'documentType'},
    const {'1': 'document_url', '3': 3, '4': 1, '5': 9, '10': 'documentUrl'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.pb.DocumentStatus', '10': 'status'},
    const {'1': 'uploaded_at', '3': 5, '4': 1, '5': 9, '10': 'uploadedAt'},
    const {'1': 'verified_at', '3': 6, '4': 1, '5': 9, '10': 'verifiedAt'},
    const {'1': 'rejection_reason', '3': 7, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `VerificationDocument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verificationDocumentDescriptor = $convert.base64Decode('ChRWZXJpZmljYXRpb25Eb2N1bWVudBIOCgJpZBgBIAEoCVICaWQSNQoNZG9jdW1lbnRfdHlwZRgCIAEoDjIQLnBiLkRvY3VtZW50VHlwZVIMZG9jdW1lbnRUeXBlEiEKDGRvY3VtZW50X3VybBgDIAEoCVILZG9jdW1lbnRVcmwSKgoGc3RhdHVzGAQgASgOMhIucGIuRG9jdW1lbnRTdGF0dXNSBnN0YXR1cxIfCgt1cGxvYWRlZF9hdBgFIAEoCVIKdXBsb2FkZWRBdBIfCgt2ZXJpZmllZF9hdBgGIAEoCVIKdmVyaWZpZWRBdBIpChByZWplY3Rpb25fcmVhc29uGAcgASgJUg9yZWplY3Rpb25SZWFzb24=');
@$core.Deprecated('Use getUserDocumentsResponseDescriptor instead')
const GetUserDocumentsResponse$json = const {
  '1': 'GetUserDocumentsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'documents', '3': 2, '4': 3, '5': 11, '6': '.pb.VerificationDocument', '10': 'documents'},
  ],
};

/// Descriptor for `GetUserDocumentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsResponseDescriptor = $convert.base64Decode('ChhHZXRVc2VyRG9jdW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxI2Cglkb2N1bWVudHMYAiADKAsyGC5wYi5WZXJpZmljYXRpb25Eb2N1bWVudFIJZG9jdW1lbnRz');
@$core.Deprecated('Use kYCTierInfoDescriptor instead')
const KYCTierInfo$json = const {
  '1': 'KYCTierInfo',
  '2': const [
    const {'1': 'tier', '3': 1, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'tier'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.KYCVerificationStatus', '10': 'status'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'benefits', '3': 5, '4': 3, '5': 9, '10': 'benefits'},
    const {'1': 'daily_transaction_limit', '3': 6, '4': 1, '5': 3, '10': 'dailyTransactionLimit'},
    const {'1': 'daily_receive_limit', '3': 7, '4': 1, '5': 3, '10': 'dailyReceiveLimit'},
    const {'1': 'max_balance', '3': 8, '4': 1, '5': 3, '10': 'maxBalance'},
    const {'1': 'verified_at', '3': 9, '4': 1, '5': 9, '10': 'verifiedAt'},
    const {'1': 'expires_at', '3': 10, '4': 1, '5': 9, '10': 'expiresAt'},
    const {'1': 'is_current', '3': 11, '4': 1, '5': 8, '10': 'isCurrent'},
    const {'1': 'is_locked', '3': 12, '4': 1, '5': 8, '10': 'isLocked'},
  ],
};

/// Descriptor for `KYCTierInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kYCTierInfoDescriptor = $convert.base64Decode('CgtLWUNUaWVySW5mbxIfCgR0aWVyGAEgASgOMgsucGIuS1lDVGllclIEdGllchIxCgZzdGF0dXMYAiABKA4yGS5wYi5LWUNWZXJpZmljYXRpb25TdGF0dXNSBnN0YXR1cxIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIaCghiZW5lZml0cxgFIAMoCVIIYmVuZWZpdHMSNgoXZGFpbHlfdHJhbnNhY3Rpb25fbGltaXQYBiABKANSFWRhaWx5VHJhbnNhY3Rpb25MaW1pdBIuChNkYWlseV9yZWNlaXZlX2xpbWl0GAcgASgDUhFkYWlseVJlY2VpdmVMaW1pdBIfCgttYXhfYmFsYW5jZRgIIAEoA1IKbWF4QmFsYW5jZRIfCgt2ZXJpZmllZF9hdBgJIAEoCVIKdmVyaWZpZWRBdBIdCgpleHBpcmVzX2F0GAogASgJUglleHBpcmVzQXQSHQoKaXNfY3VycmVudBgLIAEoCFIJaXNDdXJyZW50EhsKCWlzX2xvY2tlZBgMIAEoCFIIaXNMb2NrZWQ=');
@$core.Deprecated('Use getKYCStatusRequestDescriptor instead')
const GetKYCStatusRequest$json = const {
  '1': 'GetKYCStatusRequest',
};

/// Descriptor for `GetKYCStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCStatusRequestDescriptor = $convert.base64Decode('ChNHZXRLWUNTdGF0dXNSZXF1ZXN0');
@$core.Deprecated('Use getKYCStatusResponseDescriptor instead')
const GetKYCStatusResponse$json = const {
  '1': 'GetKYCStatusResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.KYCVerificationStatus', '10': 'status'},
    const {'1': 'current_tier', '3': 3, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'currentTier'},
    const {'1': 'tier_info', '3': 4, '4': 3, '5': 11, '6': '.pb.KYCTierInfo', '10': 'tierInfo'},
    const {'1': 'last_updated', '3': 5, '4': 1, '5': 9, '10': 'lastUpdated'},
    const {'1': 'rejection_reason', '3': 6, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `GetKYCStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCStatusResponseDescriptor = $convert.base64Decode('ChRHZXRLWUNTdGF0dXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEjEKBnN0YXR1cxgCIAEoDjIZLnBiLktZQ1ZlcmlmaWNhdGlvblN0YXR1c1IGc3RhdHVzEi4KDGN1cnJlbnRfdGllchgDIAEoDjILLnBiLktZQ1RpZXJSC2N1cnJlbnRUaWVyEiwKCXRpZXJfaW5mbxgEIAMoCzIPLnBiLktZQ1RpZXJJbmZvUgh0aWVySW5mbxIhCgxsYXN0X3VwZGF0ZWQYBSABKAlSC2xhc3RVcGRhdGVkEikKEHJlamVjdGlvbl9yZWFzb24YBiABKAlSD3JlamVjdGlvblJlYXNvbg==');
@$core.Deprecated('Use countryKYCRequirementsDescriptor instead')
const CountryKYCRequirements$json = const {
  '1': 'CountryKYCRequirements',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'accepted_id_types', '3': 2, '4': 3, '5': 14, '6': '.pb.IdentityType', '10': 'acceptedIdTypes'},
    const {'1': 'mandatory_id_types', '3': 3, '4': 3, '5': 14, '6': '.pb.IdentityType', '10': 'mandatoryIdTypes'},
    const {'1': 'address_proof_required', '3': 4, '4': 1, '5': 8, '10': 'addressProofRequired'},
    const {'1': 'liveness_check_required', '3': 5, '4': 1, '5': 8, '10': 'livenessCheckRequired'},
    const {'1': 'tier_1_daily_limit', '3': 6, '4': 1, '5': 3, '10': 'tier1DailyLimit'},
    const {'1': 'tier_2_daily_limit', '3': 7, '4': 1, '5': 3, '10': 'tier2DailyLimit'},
    const {'1': 'tier_3_daily_limit', '3': 8, '4': 1, '5': 3, '10': 'tier3DailyLimit'},
  ],
};

/// Descriptor for `CountryKYCRequirements`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countryKYCRequirementsDescriptor = $convert.base64Decode('ChZDb3VudHJ5S1lDUmVxdWlyZW1lbnRzEiEKDGNvdW50cnlfY29kZRgBIAEoCVILY291bnRyeUNvZGUSPAoRYWNjZXB0ZWRfaWRfdHlwZXMYAiADKA4yEC5wYi5JZGVudGl0eVR5cGVSD2FjY2VwdGVkSWRUeXBlcxI+ChJtYW5kYXRvcnlfaWRfdHlwZXMYAyADKA4yEC5wYi5JZGVudGl0eVR5cGVSEG1hbmRhdG9yeUlkVHlwZXMSNAoWYWRkcmVzc19wcm9vZl9yZXF1aXJlZBgEIAEoCFIUYWRkcmVzc1Byb29mUmVxdWlyZWQSNgoXbGl2ZW5lc3NfY2hlY2tfcmVxdWlyZWQYBSABKAhSFWxpdmVuZXNzQ2hlY2tSZXF1aXJlZBIrChJ0aWVyXzFfZGFpbHlfbGltaXQYBiABKANSD3RpZXIxRGFpbHlMaW1pdBIrChJ0aWVyXzJfZGFpbHlfbGltaXQYByABKANSD3RpZXIyRGFpbHlMaW1pdBIrChJ0aWVyXzNfZGFpbHlfbGltaXQYCCABKANSD3RpZXIzRGFpbHlMaW1pdA==');
@$core.Deprecated('Use getCountryRequirementsRequestDescriptor instead')
const GetCountryRequirementsRequest$json = const {
  '1': 'GetCountryRequirementsRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetCountryRequirementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRequirementsRequestDescriptor = $convert.base64Decode('Ch1HZXRDb3VudHJ5UmVxdWlyZW1lbnRzUmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2NvdW50cnlDb2Rl');
@$core.Deprecated('Use getCountryRequirementsResponseDescriptor instead')
const GetCountryRequirementsResponse$json = const {
  '1': 'GetCountryRequirementsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'requirements', '3': 2, '4': 1, '5': 11, '6': '.pb.CountryKYCRequirements', '10': 'requirements'},
  ],
};

/// Descriptor for `GetCountryRequirementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRequirementsResponseDescriptor = $convert.base64Decode('Ch5HZXRDb3VudHJ5UmVxdWlyZW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxI+CgxyZXF1aXJlbWVudHMYAiABKAsyGi5wYi5Db3VudHJ5S1lDUmVxdWlyZW1lbnRzUgxyZXF1aXJlbWVudHM=');
@$core.Deprecated('Use createVerificationSessionRequestDescriptor instead')
const CreateVerificationSessionRequest$json = const {
  '1': 'CreateVerificationSessionRequest',
  '2': const [
    const {'1': 'target_tier', '3': 1, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'targetTier'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'id_type', '3': 3, '4': 1, '5': 14, '6': '.pb.IdentityType', '10': 'idType'},
    const {'1': 'id_number', '3': 4, '4': 1, '5': 9, '10': 'idNumber'},
    const {'1': 'first_name', '3': 5, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 6, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'date_of_birth', '3': 7, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'phone_number', '3': 8, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `CreateVerificationSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVerificationSessionRequestDescriptor = $convert.base64Decode('CiBDcmVhdGVWZXJpZmljYXRpb25TZXNzaW9uUmVxdWVzdBIsCgt0YXJnZXRfdGllchgBIAEoDjILLnBiLktZQ1RpZXJSCnRhcmdldFRpZXISIQoMY291bnRyeV9jb2RlGAIgASgJUgtjb3VudHJ5Q29kZRIpCgdpZF90eXBlGAMgASgOMhAucGIuSWRlbnRpdHlUeXBlUgZpZFR5cGUSGwoJaWRfbnVtYmVyGAQgASgJUghpZE51bWJlchIdCgpmaXJzdF9uYW1lGAUgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAYgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAcgASgJUgtkYXRlT2ZCaXJ0aBIhCgxwaG9uZV9udW1iZXIYCCABKAlSC3Bob25lTnVtYmVy');
@$core.Deprecated('Use createVerificationSessionResponseDescriptor instead')
const CreateVerificationSessionResponse$json = const {
  '1': 'CreateVerificationSessionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'verification_id', '3': 2, '4': 1, '5': 9, '10': 'verificationId'},
    const {'1': 'session_url', '3': 3, '4': 1, '5': 9, '10': 'sessionUrl'},
    const {'1': 'session_token', '3': 4, '4': 1, '5': 9, '10': 'sessionToken'},
    const {'1': 'provider', '3': 5, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.pb.KYCVerificationStatus', '10': 'status'},
    const {'1': 'error_message', '3': 7, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `CreateVerificationSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVerificationSessionResponseDescriptor = $convert.base64Decode('CiFDcmVhdGVWZXJpZmljYXRpb25TZXNzaW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxInCg92ZXJpZmljYXRpb25faWQYAiABKAlSDnZlcmlmaWNhdGlvbklkEh8KC3Nlc3Npb25fdXJsGAMgASgJUgpzZXNzaW9uVXJsEiMKDXNlc3Npb25fdG9rZW4YBCABKAlSDHNlc3Npb25Ub2tlbhIaCghwcm92aWRlchgFIAEoCVIIcHJvdmlkZXISMQoGc3RhdHVzGAYgASgOMhkucGIuS1lDVmVyaWZpY2F0aW9uU3RhdHVzUgZzdGF0dXMSIwoNZXJyb3JfbWVzc2FnZRgHIAEoCVIMZXJyb3JNZXNzYWdl');
@$core.Deprecated('Use confirmVerificationRequestDescriptor instead')
const ConfirmVerificationRequest$json = const {
  '1': 'ConfirmVerificationRequest',
  '2': const [
    const {'1': 'verification_id', '3': 1, '4': 1, '5': 9, '10': 'verificationId'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_auth_code', '3': 3, '4': 1, '5': 9, '10': 'providerAuthCode'},
    const {'1': 'metadata', '3': 4, '4': 3, '5': 11, '6': '.pb.ConfirmVerificationRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': const [ConfirmVerificationRequest_MetadataEntry$json],
};

@$core.Deprecated('Use confirmVerificationRequestDescriptor instead')
const ConfirmVerificationRequest_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ConfirmVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmVerificationRequestDescriptor = $convert.base64Decode('ChpDb25maXJtVmVyaWZpY2F0aW9uUmVxdWVzdBInCg92ZXJpZmljYXRpb25faWQYASABKAlSDnZlcmlmaWNhdGlvbklkEhoKCHByb3ZpZGVyGAIgASgJUghwcm92aWRlchIsChJwcm92aWRlcl9hdXRoX2NvZGUYAyABKAlSEHByb3ZpZGVyQXV0aENvZGUSSAoIbWV0YWRhdGEYBCADKAsyLC5wYi5Db25maXJtVmVyaWZpY2F0aW9uUmVxdWVzdC5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use bVNNameReconciliationDescriptor instead')
const BVNNameReconciliation$json = const {
  '1': 'BVNNameReconciliation',
  '2': const [
    const {'1': 'name_action', '3': 1, '4': 1, '5': 9, '10': 'nameAction'},
    const {'1': 'name_match_score', '3': 2, '4': 1, '5': 1, '10': 'nameMatchScore'},
    const {'1': 'verified_name', '3': 3, '4': 1, '5': 9, '10': 'verifiedName'},
    const {'1': 'profile_name', '3': 4, '4': 1, '5': 9, '10': 'profileName'},
  ],
};

/// Descriptor for `BVNNameReconciliation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bVNNameReconciliationDescriptor = $convert.base64Decode('ChVCVk5OYW1lUmVjb25jaWxpYXRpb24SHwoLbmFtZV9hY3Rpb24YASABKAlSCm5hbWVBY3Rpb24SKAoQbmFtZV9tYXRjaF9zY29yZRgCIAEoAVIObmFtZU1hdGNoU2NvcmUSIwoNdmVyaWZpZWRfbmFtZRgDIAEoCVIMdmVyaWZpZWROYW1lEiEKDHByb2ZpbGVfbmFtZRgEIAEoCVILcHJvZmlsZU5hbWU=');
@$core.Deprecated('Use confirmVerificationResponseDescriptor instead')
const ConfirmVerificationResponse$json = const {
  '1': 'ConfirmVerificationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.KYCVerificationStatus', '10': 'status'},
    const {'1': 'current_tier', '3': 3, '4': 1, '5': 14, '6': '.pb.KYCTier', '10': 'currentTier'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'bvn_name_reconciliation', '3': 5, '4': 1, '5': 11, '6': '.pb.BVNNameReconciliation', '10': 'bvnNameReconciliation'},
  ],
};

/// Descriptor for `ConfirmVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmVerificationResponseDescriptor = $convert.base64Decode('ChtDb25maXJtVmVyaWZpY2F0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIxCgZzdGF0dXMYAiABKA4yGS5wYi5LWUNWZXJpZmljYXRpb25TdGF0dXNSBnN0YXR1cxIuCgxjdXJyZW50X3RpZXIYAyABKA4yCy5wYi5LWUNUaWVyUgtjdXJyZW50VGllchIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlElEKF2J2bl9uYW1lX3JlY29uY2lsaWF0aW9uGAUgASgLMhkucGIuQlZOTmFtZVJlY29uY2lsaWF0aW9uUhVidm5OYW1lUmVjb25jaWxpYXRpb24=');
@$core.Deprecated('Use getDocumentUploadURLRequestDescriptor instead')
const GetDocumentUploadURLRequest$json = const {
  '1': 'GetDocumentUploadURLRequest',
  '2': const [
    const {'1': 'document_type', '3': 1, '4': 1, '5': 9, '10': 'documentType'},
    const {'1': 'content_type', '3': 2, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `GetDocumentUploadURLRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDocumentUploadURLRequestDescriptor = $convert.base64Decode('ChtHZXREb2N1bWVudFVwbG9hZFVSTFJlcXVlc3QSIwoNZG9jdW1lbnRfdHlwZRgBIAEoCVIMZG9jdW1lbnRUeXBlEiEKDGNvbnRlbnRfdHlwZRgCIAEoCVILY29udGVudFR5cGU=');
@$core.Deprecated('Use getDocumentUploadURLResponseDescriptor instead')
const GetDocumentUploadURLResponse$json = const {
  '1': 'GetDocumentUploadURLResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'upload_url', '3': 2, '4': 1, '5': 9, '10': 'uploadUrl'},
    const {'1': 'storage_key', '3': 3, '4': 1, '5': 9, '10': 'storageKey'},
    const {'1': 'expires_at', '3': 4, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `GetDocumentUploadURLResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDocumentUploadURLResponseDescriptor = $convert.base64Decode('ChxHZXREb2N1bWVudFVwbG9hZFVSTFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKdXBsb2FkX3VybBgCIAEoCVIJdXBsb2FkVXJsEh8KC3N0b3JhZ2Vfa2V5GAMgASgJUgpzdG9yYWdlS2V5Eh0KCmV4cGlyZXNfYXQYBCABKANSCWV4cGlyZXNBdA==');
@$core.Deprecated('Use documentSubmissionItemDescriptor instead')
const DocumentSubmissionItem$json = const {
  '1': 'DocumentSubmissionItem',
  '2': const [
    const {'1': 'storage_key', '3': 1, '4': 1, '5': 9, '10': 'storageKey'},
    const {'1': 'document_type', '3': 2, '4': 1, '5': 9, '10': 'documentType'},
    const {'1': 'content_type', '3': 3, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `DocumentSubmissionItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List documentSubmissionItemDescriptor = $convert.base64Decode('ChZEb2N1bWVudFN1Ym1pc3Npb25JdGVtEh8KC3N0b3JhZ2Vfa2V5GAEgASgJUgpzdG9yYWdlS2V5EiMKDWRvY3VtZW50X3R5cGUYAiABKAlSDGRvY3VtZW50VHlwZRIhCgxjb250ZW50X3R5cGUYAyABKAlSC2NvbnRlbnRUeXBl');
@$core.Deprecated('Use submitDocumentsForReviewRequestDescriptor instead')
const SubmitDocumentsForReviewRequest$json = const {
  '1': 'SubmitDocumentsForReviewRequest',
  '2': const [
    const {'1': 'documents', '3': 1, '4': 3, '5': 11, '6': '.pb.DocumentSubmissionItem', '10': 'documents'},
  ],
};

/// Descriptor for `SubmitDocumentsForReviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitDocumentsForReviewRequestDescriptor = $convert.base64Decode('Ch9TdWJtaXREb2N1bWVudHNGb3JSZXZpZXdSZXF1ZXN0EjgKCWRvY3VtZW50cxgBIAMoCzIaLnBiLkRvY3VtZW50U3VibWlzc2lvbkl0ZW1SCWRvY3VtZW50cw==');
@$core.Deprecated('Use submitDocumentsForReviewResponseDescriptor instead')
const SubmitDocumentsForReviewResponse$json = const {
  '1': 'SubmitDocumentsForReviewResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.KYCVerificationStatus', '10': 'status'},
  ],
};

/// Descriptor for `SubmitDocumentsForReviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitDocumentsForReviewResponseDescriptor = $convert.base64Decode('CiBTdWJtaXREb2N1bWVudHNGb3JSZXZpZXdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USMQoGc3RhdHVzGAMgASgOMhkucGIuS1lDVmVyaWZpY2F0aW9uU3RhdHVzUgZzdGF0dXM=');
@$core.Deprecated('Use channelLoginRequestDescriptor instead')
const ChannelLoginRequest$json = const {
  '1': 'ChannelLoginRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'channel_type', '3': 2, '4': 1, '5': 9, '10': 'channelType'},
  ],
};

/// Descriptor for `ChannelLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelLoginRequestDescriptor = $convert.base64Decode('ChNDaGFubmVsTG9naW5SZXF1ZXN0EiEKDHBob25lX251bWJlchgBIAEoCVILcGhvbmVOdW1iZXISIQoMY2hhbm5lbF90eXBlGAIgASgJUgtjaGFubmVsVHlwZQ==');
@$core.Deprecated('Use channelLoginResponseDescriptor instead')
const ChannelLoginResponse$json = const {
  '1': 'ChannelLoginResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'user_country', '3': 8, '4': 1, '5': 9, '10': 'userCountry'},
    const {'1': 'expires_in', '3': 9, '4': 1, '5': 5, '10': 'expiresIn'},
  ],
};

/// Descriptor for `ChannelLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelLoginResponseDescriptor = $convert.base64Decode('ChRDaGFubmVsTG9naW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZXNoX3Rva2VuGAQgASgJUgxyZWZyZXNoVG9rZW4SFwoHdXNlcl9pZBgFIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYBiABKAlSCWFjY291bnRJZBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSIQoMdXNlcl9jb3VudHJ5GAggASgJUgt1c2VyQ291bnRyeRIdCgpleHBpcmVzX2luGAkgASgFUglleHBpcmVzSW4=');
@$core.Deprecated('Use channelRegisterRequestDescriptor instead')
const ChannelRegisterRequest$json = const {
  '1': 'ChannelRegisterRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'channel_type', '3': 5, '4': 1, '5': 9, '10': 'channelType'},
    const {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `ChannelRegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelRegisterRequestDescriptor = $convert.base64Decode('ChZDaGFubmVsUmVnaXN0ZXJSZXF1ZXN0EiEKDHBob25lX251bWJlchgBIAEoCVILcGhvbmVOdW1iZXISHQoKZmlyc3RfbmFtZRgCIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgDIAEoCVIIbGFzdE5hbWUSFAoFZW1haWwYBCABKAlSBWVtYWlsEiEKDGNoYW5uZWxfdHlwZRgFIAEoCVILY2hhbm5lbFR5cGUSIQoMY291bnRyeV9jb2RlGAYgASgJUgtjb3VudHJ5Q29kZQ==');
@$core.Deprecated('Use channelRegisterResponseDescriptor instead')
const ChannelRegisterResponse$json = const {
  '1': 'ChannelRegisterResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'otp_sent', '3': 4, '4': 1, '5': 8, '10': 'otpSent'},
    const {'1': 'masked_email', '3': 5, '4': 1, '5': 9, '10': 'maskedEmail'},
    const {'1': 'otp_expires_in_seconds', '3': 6, '4': 1, '5': 5, '10': 'otpExpiresInSeconds'},
  ],
};

/// Descriptor for `ChannelRegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelRegisterResponseDescriptor = $convert.base64Decode('ChdDaGFubmVsUmVnaXN0ZXJSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhkKCG90cF9zZW50GAQgASgIUgdvdHBTZW50EiEKDG1hc2tlZF9lbWFpbBgFIAEoCVILbWFza2VkRW1haWwSMwoWb3RwX2V4cGlyZXNfaW5fc2Vjb25kcxgGIAEoBVITb3RwRXhwaXJlc0luU2Vjb25kcw==');
@$core.Deprecated('Use channelVerifyRegistrationRequestDescriptor instead')
const ChannelVerifyRegistrationRequest$json = const {
  '1': 'ChannelVerifyRegistrationRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'otp_code', '3': 2, '4': 1, '5': 9, '10': 'otpCode'},
    const {'1': 'channel_type', '3': 3, '4': 1, '5': 9, '10': 'channelType'},
  ],
};

/// Descriptor for `ChannelVerifyRegistrationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelVerifyRegistrationRequestDescriptor = $convert.base64Decode('CiBDaGFubmVsVmVyaWZ5UmVnaXN0cmF0aW9uUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEhkKCG90cF9jb2RlGAIgASgJUgdvdHBDb2RlEiEKDGNoYW5uZWxfdHlwZRgDIAEoCVILY2hhbm5lbFR5cGU=');
@$core.Deprecated('Use channelVerifyRegistrationResponseDescriptor instead')
const ChannelVerifyRegistrationResponse$json = const {
  '1': 'ChannelVerifyRegistrationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'user_country', '3': 8, '4': 1, '5': 9, '10': 'userCountry'},
    const {'1': 'expires_in', '3': 9, '4': 1, '5': 5, '10': 'expiresIn'},
  ],
};

/// Descriptor for `ChannelVerifyRegistrationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelVerifyRegistrationResponseDescriptor = $convert.base64Decode('CiFDaGFubmVsVmVyaWZ5UmVnaXN0cmF0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiEKDGFjY2Vzc190b2tlbhgDIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgEIAEoCVIMcmVmcmVzaFRva2VuEhcKB3VzZXJfaWQYBSABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAYgASgJUglhY2NvdW50SWQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EiEKDHVzZXJfY291bnRyeRgIIAEoCVILdXNlckNvdW50cnkSHQoKZXhwaXJlc19pbhgJIAEoBVIJZXhwaXJlc0lu');
@$core.Deprecated('Use adminGenerateTokenByPhoneRequestDescriptor instead')
const AdminGenerateTokenByPhoneRequest$json = const {
  '1': 'AdminGenerateTokenByPhoneRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'admin_secret', '3': 2, '4': 1, '5': 9, '10': 'adminSecret'},
    const {'1': 'channel_type', '3': 3, '4': 1, '5': 9, '10': 'channelType'},
  ],
};

/// Descriptor for `AdminGenerateTokenByPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGenerateTokenByPhoneRequestDescriptor = $convert.base64Decode('CiBBZG1pbkdlbmVyYXRlVG9rZW5CeVBob25lUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEiEKDGFkbWluX3NlY3JldBgCIAEoCVILYWRtaW5TZWNyZXQSIQoMY2hhbm5lbF90eXBlGAMgASgJUgtjaGFubmVsVHlwZQ==');
@$core.Deprecated('Use adminGenerateTokenByPhoneResponseDescriptor instead')
const AdminGenerateTokenByPhoneResponse$json = const {
  '1': 'AdminGenerateTokenByPhoneResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'user_country', '3': 8, '4': 1, '5': 9, '10': 'userCountry'},
    const {'1': 'expires_in', '3': 9, '4': 1, '5': 5, '10': 'expiresIn'},
    const {'1': 'user_found', '3': 10, '4': 1, '5': 8, '10': 'userFound'},
    const {'1': 'first_name', '3': 11, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 12, '4': 1, '5': 9, '10': 'lastName'},
  ],
};

/// Descriptor for `AdminGenerateTokenByPhoneResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGenerateTokenByPhoneResponseDescriptor = $convert.base64Decode('CiFBZG1pbkdlbmVyYXRlVG9rZW5CeVBob25lUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiEKDGFjY2Vzc190b2tlbhgDIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgEIAEoCVIMcmVmcmVzaFRva2VuEhcKB3VzZXJfaWQYBSABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAYgASgJUglhY2NvdW50SWQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EiEKDHVzZXJfY291bnRyeRgIIAEoCVILdXNlckNvdW50cnkSHQoKZXhwaXJlc19pbhgJIAEoBVIJZXhwaXJlc0luEh0KCnVzZXJfZm91bmQYCiABKAhSCXVzZXJGb3VuZBIdCgpmaXJzdF9uYW1lGAsgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAwgASgJUghsYXN0TmFtZQ==');
