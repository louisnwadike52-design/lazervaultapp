//
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use primaryContactTypeDescriptor instead')
const PrimaryContactType$json = {
  '1': 'PrimaryContactType',
  '2': [
    {'1': 'EMAIL', '2': 0},
    {'1': 'PHONE', '2': 1},
  ],
};

/// Descriptor for `PrimaryContactType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List primaryContactTypeDescriptor = $convert.base64Decode(
    'ChJQcmltYXJ5Q29udGFjdFR5cGUSCQoFRU1BSUwQABIJCgVQSE9ORRAB');

@$core.Deprecated('Use passwordResetDeliveryMethodDescriptor instead')
const PasswordResetDeliveryMethod$json = {
  '1': 'PasswordResetDeliveryMethod',
  '2': [
    {'1': 'DELIVERY_METHOD_UNSPECIFIED', '2': 0},
    {'1': 'DELIVERY_METHOD_EMAIL', '2': 1},
    {'1': 'DELIVERY_METHOD_SMS', '2': 2},
  ],
};

/// Descriptor for `PasswordResetDeliveryMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List passwordResetDeliveryMethodDescriptor = $convert.base64Decode(
    'ChtQYXNzd29yZFJlc2V0RGVsaXZlcnlNZXRob2QSHwobREVMSVZFUllfTUVUSE9EX1VOU1BFQ0'
    'lGSUVEEAASGQoVREVMSVZFUllfTUVUSE9EX0VNQUlMEAESFwoTREVMSVZFUllfTUVUSE9EX1NN'
    'UxAC');

@$core.Deprecated('Use signupStatusDescriptor instead')
const SignupStatus$json = {
  '1': 'SignupStatus',
  '2': [
    {'1': 'SIGNUP_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'SIGNUP_STATUS_CREATED', '2': 1},
    {'1': 'SIGNUP_STATUS_EMAIL_VERIFIED', '2': 2},
    {'1': 'SIGNUP_STATUS_PHONE_VERIFIED', '2': 3},
    {'1': 'SIGNUP_STATUS_IDENTITY_VERIFIED', '2': 4},
    {'1': 'SIGNUP_STATUS_PASSCODE_SET', '2': 5},
    {'1': 'SIGNUP_STATUS_COMPLETE', '2': 6},
  ],
};

/// Descriptor for `SignupStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List signupStatusDescriptor = $convert.base64Decode(
    'CgxTaWdudXBTdGF0dXMSHQoZU0lHTlVQX1NUQVRVU19VTlNQRUNJRklFRBAAEhkKFVNJR05VUF'
    '9TVEFUVVNfQ1JFQVRFRBABEiAKHFNJR05VUF9TVEFUVVNfRU1BSUxfVkVSSUZJRUQQAhIgChxT'
    'SUdOVVBfU1RBVFVTX1BIT05FX1ZFUklGSUVEEAMSIwofU0lHTlVQX1NUQVRVU19JREVOVElUWV'
    '9WRVJJRklFRBAEEh4KGlNJR05VUF9TVEFUVVNfUEFTU0NPREVfU0VUEAUSGgoWU0lHTlVQX1NU'
    'QVRVU19DT01QTEVURRAG');

@$core.Deprecated('Use stepStatusDescriptor instead')
const StepStatus$json = {
  '1': 'StepStatus',
  '2': [
    {'1': 'STEP_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'STEP_STATUS_PENDING', '2': 1},
    {'1': 'STEP_STATUS_IN_PROGRESS', '2': 2},
    {'1': 'STEP_STATUS_COMPLETED', '2': 3},
    {'1': 'STEP_STATUS_SKIPPED', '2': 4},
  ],
};

/// Descriptor for `StepStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List stepStatusDescriptor = $convert.base64Decode(
    'CgpTdGVwU3RhdHVzEhsKF1NURVBfU1RBVFVTX1VOU1BFQ0lGSUVEEAASFwoTU1RFUF9TVEFUVV'
    'NfUEVORElORxABEhsKF1NURVBfU1RBVFVTX0lOX1BST0dSRVNTEAISGQoVU1RFUF9TVEFUVVNf'
    'Q09NUExFVEVEEAMSFwoTU1RFUF9TVEFUVVNfU0tJUFBFRBAE');

@$core.Deprecated('Use identityTypeDescriptor instead')
const IdentityType$json = {
  '1': 'IdentityType',
  '2': [
    {'1': 'IDENTITY_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'IDENTITY_TYPE_BVN', '2': 1},
    {'1': 'IDENTITY_TYPE_NIN', '2': 2},
    {'1': 'IDENTITY_TYPE_GHANA_CARD', '2': 3},
    {'1': 'IDENTITY_TYPE_KENYA_NATIONAL_ID', '2': 4},
    {'1': 'IDENTITY_TYPE_KRA_PIN', '2': 5},
    {'1': 'IDENTITY_TYPE_SA_ID', '2': 6},
    {'1': 'IDENTITY_TYPE_SA_PASSPORT', '2': 7},
    {'1': 'IDENTITY_TYPE_UK_PASSPORT', '2': 8},
    {'1': 'IDENTITY_TYPE_UK_DRIVING_LICENSE', '2': 9},
    {'1': 'IDENTITY_TYPE_US_SSN', '2': 10},
    {'1': 'IDENTITY_TYPE_US_STATE_ID', '2': 11},
    {'1': 'IDENTITY_TYPE_US_PASSPORT', '2': 12},
    {'1': 'IDENTITY_TYPE_DRIVERS_LICENSE', '2': 13},
    {'1': 'IDENTITY_TYPE_INTERNATIONAL_PASSPORT', '2': 14},
  ],
};

/// Descriptor for `IdentityType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List identityTypeDescriptor = $convert.base64Decode(
    'CgxJZGVudGl0eVR5cGUSHQoZSURFTlRJVFlfVFlQRV9VTlNQRUNJRklFRBAAEhUKEUlERU5USV'
    'RZX1RZUEVfQlZOEAESFQoRSURFTlRJVFlfVFlQRV9OSU4QAhIcChhJREVOVElUWV9UWVBFX0dI'
    'QU5BX0NBUkQQAxIjCh9JREVOVElUWV9UWVBFX0tFTllBX05BVElPTkFMX0lEEAQSGQoVSURFTl'
    'RJVFlfVFlQRV9LUkFfUElOEAUSFwoTSURFTlRJVFlfVFlQRV9TQV9JRBAGEh0KGUlERU5USVRZ'
    'X1RZUEVfU0FfUEFTU1BPUlQQBxIdChlJREVOVElUWV9UWVBFX1VLX1BBU1NQT1JUEAgSJAogSU'
    'RFTlRJVFlfVFlQRV9VS19EUklWSU5HX0xJQ0VOU0UQCRIYChRJREVOVElUWV9UWVBFX1VTX1NT'
    'ThAKEh0KGUlERU5USVRZX1RZUEVfVVNfU1RBVEVfSUQQCxIdChlJREVOVElUWV9UWVBFX1VTX1'
    'BBU1NQT1JUEAwSIQodSURFTlRJVFlfVFlQRV9EUklWRVJTX0xJQ0VOU0UQDRIoCiRJREVOVElU'
    'WV9UWVBFX0lOVEVSTkFUSU9OQUxfUEFTU1BPUlQQDg==');

@$core.Deprecated('Use kYCTierDescriptor instead')
const KYCTier$json = {
  '1': 'KYCTier',
  '2': [
    {'1': 'KYC_TIER_UNKNOWN', '2': 0},
    {'1': 'KYC_TIER_1', '2': 1},
    {'1': 'KYC_TIER_2', '2': 2},
    {'1': 'KYC_TIER_3', '2': 3},
  ],
};

/// Descriptor for `KYCTier`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCTierDescriptor = $convert.base64Decode(
    'CgdLWUNUaWVyEhQKEEtZQ19USUVSX1VOS05PV04QABIOCgpLWUNfVElFUl8xEAESDgoKS1lDX1'
    'RJRVJfMhACEg4KCktZQ19USUVSXzMQAw==');

@$core.Deprecated('Use documentTypeDescriptor instead')
const DocumentType$json = {
  '1': 'DocumentType',
  '2': [
    {'1': 'DOCUMENT_TYPE_UNKNOWN', '2': 0},
    {'1': 'DOCUMENT_TYPE_BVN', '2': 1},
    {'1': 'DOCUMENT_TYPE_NIN', '2': 2},
    {'1': 'DOCUMENT_TYPE_DRIVERS_LICENSE', '2': 3},
    {'1': 'DOCUMENT_TYPE_PASSPORT', '2': 4},
    {'1': 'DOCUMENT_TYPE_VOTERS_CARD', '2': 5},
    {'1': 'DOCUMENT_TYPE_PROOF_OF_ADDRESS', '2': 6},
    {'1': 'DOCUMENT_TYPE_SELFIE', '2': 7},
  ],
};

/// Descriptor for `DocumentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentTypeDescriptor = $convert.base64Decode(
    'CgxEb2N1bWVudFR5cGUSGQoVRE9DVU1FTlRfVFlQRV9VTktOT1dOEAASFQoRRE9DVU1FTlRfVF'
    'lQRV9CVk4QARIVChFET0NVTUVOVF9UWVBFX05JThACEiEKHURPQ1VNRU5UX1RZUEVfRFJJVkVS'
    'U19MSUNFTlNFEAMSGgoWRE9DVU1FTlRfVFlQRV9QQVNTUE9SVBAEEh0KGURPQ1VNRU5UX1RZUE'
    'VfVk9URVJTX0NBUkQQBRIiCh5ET0NVTUVOVF9UWVBFX1BST09GX09GX0FERFJFU1MQBhIYChRE'
    'T0NVTUVOVF9UWVBFX1NFTEZJRRAH');

@$core.Deprecated('Use documentStatusDescriptor instead')
const DocumentStatus$json = {
  '1': 'DocumentStatus',
  '2': [
    {'1': 'DOCUMENT_STATUS_UNKNOWN', '2': 0},
    {'1': 'DOCUMENT_STATUS_PENDING_UPLOAD', '2': 1},
    {'1': 'DOCUMENT_STATUS_UPLOADED', '2': 2},
    {'1': 'DOCUMENT_STATUS_UNDER_REVIEW', '2': 3},
    {'1': 'DOCUMENT_STATUS_APPROVED', '2': 4},
    {'1': 'DOCUMENT_STATUS_REJECTED', '2': 5},
  ],
};

/// Descriptor for `DocumentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentStatusDescriptor = $convert.base64Decode(
    'Cg5Eb2N1bWVudFN0YXR1cxIbChdET0NVTUVOVF9TVEFUVVNfVU5LTk9XThAAEiIKHkRPQ1VNRU'
    '5UX1NUQVRVU19QRU5ESU5HX1VQTE9BRBABEhwKGERPQ1VNRU5UX1NUQVRVU19VUExPQURFRBAC'
    'EiAKHERPQ1VNRU5UX1NUQVRVU19VTkRFUl9SRVZJRVcQAxIcChhET0NVTUVOVF9TVEFUVVNfQV'
    'BQUk9WRUQQBBIcChhET0NVTUVOVF9TVEFUVVNfUkVKRUNURUQQBQ==');

@$core.Deprecated('Use signupRequestDescriptor instead')
const SignupRequest$json = {
  '1': 'SignupRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'device_id', '3': 6, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 7, '4': 1, '5': 9, '10': 'deviceName'},
    {'1': 'primary_contact_type', '3': 8, '4': 1, '5': 14, '6': '.auth.PrimaryContactType', '10': 'primaryContactType'},
    {'1': 'username', '3': 9, '4': 1, '5': 9, '10': 'username'},
    {'1': 'referral_code', '3': 10, '4': 1, '5': 9, '10': 'referralCode'},
    {'1': 'date_of_birth', '3': 11, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'locale', '3': 12, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'bvn', '3': 13, '4': 1, '5': 9, '10': 'bvn'},
    {'1': 'nin', '3': 14, '4': 1, '5': 9, '10': 'nin'},
    {
      '1': 'country_code',
      '3': 15,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'countryCode',
    },
    {
      '1': 'currency_code',
      '3': 16,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'currencyCode',
    },
  ],
};

/// Descriptor for `SignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupRequestDescriptor = $convert.base64Decode(
    'Cg1TaWdudXBSZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbBIaCghwYXNzd29yZBgCIAEoCV'
    'IIcGFzc3dvcmQSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgE'
    'IAEoCVIIbGFzdE5hbWUSFAoFcGhvbmUYBSABKAlSBXBob25lEhsKCWRldmljZV9pZBgGIAEoCV'
    'IIZGV2aWNlSWQSHwoLZGV2aWNlX25hbWUYByABKAlSCmRldmljZU5hbWUSSgoUcHJpbWFyeV9j'
    'b250YWN0X3R5cGUYCCABKA4yGC5hdXRoLlByaW1hcnlDb250YWN0VHlwZVIScHJpbWFyeUNvbn'
    'RhY3RUeXBlEhoKCHVzZXJuYW1lGAkgASgJUgh1c2VybmFtZRIjCg1yZWZlcnJhbF9jb2RlGAog'
    'ASgJUgxyZWZlcnJhbENvZGUSIgoNZGF0ZV9vZl9iaXJ0aBgLIAEoCVILZGF0ZU9mQmlydGgSFg'
    'oGbG9jYWxlGAwgASgJUgZsb2NhbGUSEAoDYnZuGA0gASgJUgNidm4SEAoDbmluGA4gASgJUgNu'
    'aW4SJQoMY291bnRyeV9jb2RlGA8gASgJQgIYAVILY291bnRyeUNvZGUSJwoNY3VycmVuY3lfY2'
    '9kZRgQIAEoCUICGAFSDGN1cnJlbmN5Q29kZQ==');

@$core.Deprecated('Use signupResponseDescriptor instead')
const SignupResponse$json = {
  '1': 'SignupResponse',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'email_verification_required', '3': 4, '4': 1, '5': 8, '10': 'emailVerificationRequired'},
    {'1': 'access_token', '3': 5, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 6, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 7, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 8, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
    {'1': 'phone_verification_required', '3': 9, '4': 1, '5': 8, '10': 'phoneVerificationRequired'},
    {'1': 'verification_sent_to', '3': 10, '4': 1, '5': 9, '10': 'verificationSentTo'},
    {'1': 'phone_verification_id', '3': 11, '4': 1, '5': 9, '10': 'phoneVerificationId'},
    {'1': 'phone_verification_expires_in', '3': 12, '4': 1, '5': 3, '10': 'phoneVerificationExpiresIn'},
  ],
};

/// Descriptor for `SignupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupResponseDescriptor = $convert.base64Decode(
    'Cg5TaWdudXBSZXNwb25zZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFZW1haWwYAiABKA'
    'lSBWVtYWlsEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USPgobZW1haWxfdmVyaWZpY2F0aW9u'
    'X3JlcXVpcmVkGAQgASgIUhllbWFpbFZlcmlmaWNhdGlvblJlcXVpcmVkEiEKDGFjY2Vzc190b2'
    'tlbhgFIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF90b2tlbhgGIAEoCVIMcmVmcmVzaFRv'
    'a2VuEh0KCmV4cGlyZXNfaW4YByABKANSCWV4cGlyZXNJbhIeCgR1c2VyGAggASgLMgouYXV0aC'
    '5Vc2VyUgR1c2VyEj4KG3Bob25lX3ZlcmlmaWNhdGlvbl9yZXF1aXJlZBgJIAEoCFIZcGhvbmVW'
    'ZXJpZmljYXRpb25SZXF1aXJlZBIwChR2ZXJpZmljYXRpb25fc2VudF90bxgKIAEoCVISdmVyaW'
    'ZpY2F0aW9uU2VudFRvEjIKFXBob25lX3ZlcmlmaWNhdGlvbl9pZBgLIAEoCVITcGhvbmVWZXJp'
    'ZmljYXRpb25JZBJBCh1waG9uZV92ZXJpZmljYXRpb25fZXhwaXJlc19pbhgMIAEoA1IacGhvbm'
    'VWZXJpZmljYXRpb25FeHBpcmVzSW4=');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'device_id', '3': 3, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 4, '4': 1, '5': 9, '10': 'deviceName'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3N3b3JkGAIgASgJUg'
    'hwYXNzd29yZBIbCglkZXZpY2VfaWQYAyABKAlSCGRldmljZUlkEh8KC2RldmljZV9uYW1lGAQg'
    'ASgJUgpkZXZpY2VOYW1lEhQKBXBob25lGAUgASgJUgVwaG9uZQ==');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 5, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'data', '3': 6, '4': 1, '5': 11, '6': '.auth.LoginData', '10': 'data'},
    {'1': 'two_factor_required', '3': 7, '4': 1, '5': 8, '10': 'twoFactorRequired'},
    {'1': 'two_factor_token', '3': 8, '4': 1, '5': 9, '10': 'twoFactorToken'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode(
    'Cg1Mb2dpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUg'
    'Ntc2cSIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZXNoX3Rva2Vu'
    'GAQgASgJUgxyZWZyZXNoVG9rZW4SHQoKZXhwaXJlc19pbhgFIAEoA1IJZXhwaXJlc0luEiMKBG'
    'RhdGEYBiABKAsyDy5hdXRoLkxvZ2luRGF0YVIEZGF0YRIuChN0d29fZmFjdG9yX3JlcXVpcmVk'
    'GAcgASgIUhF0d29GYWN0b3JSZXF1aXJlZBIoChB0d29fZmFjdG9yX3Rva2VuGAggASgJUg50d2'
    '9GYWN0b3JUb2tlbg==');

@$core.Deprecated('Use loginDataDescriptor instead')
const LoginData$json = {
  '1': 'LoginData',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
    {'1': 'session', '3': 2, '4': 1, '5': 11, '6': '.auth.Session', '10': 'session'},
    {'1': 'has_passcode', '3': 3, '4': 1, '5': 8, '10': 'hasPasscode'},
    {'1': 'has_transaction_pin', '3': 4, '4': 1, '5': 8, '10': 'hasTransactionPin'},
  ],
};

/// Descriptor for `LoginData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginDataDescriptor = $convert.base64Decode(
    'CglMb2dpbkRhdGESHgoEdXNlchgBIAEoCzIKLmF1dGguVXNlclIEdXNlchInCgdzZXNzaW9uGA'
    'IgASgLMg0uYXV0aC5TZXNzaW9uUgdzZXNzaW9uEiEKDGhhc19wYXNzY29kZRgDIAEoCFILaGFz'
    'UGFzc2NvZGUSLgoTaGFzX3RyYW5zYWN0aW9uX3BpbhgEIAEoCFIRaGFzVHJhbnNhY3Rpb25QaW'
    '4=');

@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = {
  '1': 'Session',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode(
    'CgdTZXNzaW9uEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcmVzaF'
    '90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyABKANSCWV4cGlyZXNJ'
    'bhIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use refreshTokenRequestDescriptor instead')
const RefreshTokenRequest$json = {
  '1': 'RefreshTokenRequest',
  '2': [
    {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `RefreshTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenRequestDescriptor = $convert.base64Decode(
    'ChNSZWZyZXNoVG9rZW5SZXF1ZXN0EiMKDXJlZnJlc2hfdG9rZW4YASABKAlSDHJlZnJlc2hUb2'
    'tlbg==');

@$core.Deprecated('Use refreshTokenResponseDescriptor instead')
const RefreshTokenResponse$json = {
  '1': 'RefreshTokenResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `RefreshTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenResponseDescriptor = $convert.base64Decode(
    'ChRSZWZyZXNoVG9rZW5SZXNwb25zZRIhCgxhY2Nlc3NfdG9rZW4YASABKAlSC2FjY2Vzc1Rva2'
    'VuEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbhIdCgpleHBpcmVzX2luGAMg'
    'ASgDUglleHBpcmVzSW4SHgoEdXNlchgEIAEoCzIKLmF1dGguVXNlclIEdXNlcg==');

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert.base64Decode(
    'Cg1Mb2dvdXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIjCg1yZWZyZXNoX3Rva2'
    'VuGAIgASgJUgxyZWZyZXNoVG9rZW4=');

@$core.Deprecated('Use logoutResponseDescriptor instead')
const LogoutResponse$json = {
  '1': 'LogoutResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `LogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutResponseDescriptor = $convert.base64Decode(
    'Cg5Mb2dvdXRSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use verifyEmailRequestDescriptor instead')
const VerifyEmailRequest$json = {
  '1': 'VerifyEmailRequest',
  '2': [
    {'1': 'verificationCode', '3': 1, '4': 1, '5': 9, '10': 'verificationCode'},
  ],
};

/// Descriptor for `VerifyEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailRequestDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlFbWFpbFJlcXVlc3QSKgoQdmVyaWZpY2F0aW9uQ29kZRgBIAEoCVIQdmVyaWZpY2'
    'F0aW9uQ29kZQ==');

@$core.Deprecated('Use verifyEmailResponseDescriptor instead')
const VerifyEmailResponse$json = {
  '1': 'VerifyEmailResponse',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `VerifyEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailResponseDescriptor = $convert.base64Decode(
    'ChNWZXJpZnlFbWFpbFJlc3BvbnNlEhAKA21zZxgBIAEoCVIDbXNnEhgKB3N1Y2Nlc3MYAiABKA'
    'hSB3N1Y2Nlc3M=');

@$core.Deprecated('Use resendVerificationEmailRequestDescriptor instead')
const ResendVerificationEmailRequest$json = {
  '1': 'ResendVerificationEmailRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `ResendVerificationEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendVerificationEmailRequestDescriptor = $convert.base64Decode(
    'Ch5SZXNlbmRWZXJpZmljYXRpb25FbWFpbFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');

@$core.Deprecated('Use resendVerificationEmailResponseDescriptor instead')
const ResendVerificationEmailResponse$json = {
  '1': 'ResendVerificationEmailResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'cooldown_seconds', '3': 3, '4': 1, '5': 5, '10': 'cooldownSeconds'},
  ],
};

/// Descriptor for `ResendVerificationEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendVerificationEmailResponseDescriptor = $convert.base64Decode(
    'Ch9SZXNlbmRWZXJpZmljYXRpb25FbWFpbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIpChBjb29sZG93bl9zZWNvbmRzGAMgASgF'
    'Ug9jb29sZG93blNlY29uZHM=');

@$core.Deprecated('Use verifyPhoneRequestDescriptor instead')
const VerifyPhoneRequest$json = {
  '1': 'VerifyPhoneRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `VerifyPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneRequestDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlQaG9uZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhIKBGNvZGUYAi'
    'ABKAlSBGNvZGUSFAoFcGhvbmUYAyABKAlSBXBob25l');

@$core.Deprecated('Use verifyPhoneResponseDescriptor instead')
const VerifyPhoneResponse$json = {
  '1': 'VerifyPhoneResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `VerifyPhoneResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneResponseDescriptor = $convert.base64Decode(
    'ChNWZXJpZnlQaG9uZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USGAoHc3VjY2'
    'VzcxgCIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use resendPhoneVerificationRequestDescriptor instead')
const ResendPhoneVerificationRequest$json = {
  '1': 'ResendPhoneVerificationRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `ResendPhoneVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendPhoneVerificationRequestDescriptor = $convert.base64Decode(
    'Ch5SZXNlbmRQaG9uZVZlcmlmaWNhdGlvblJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEh'
    'cKB3VzZXJfaWQYAiABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use resendPhoneVerificationResponseDescriptor instead')
const ResendPhoneVerificationResponse$json = {
  '1': 'ResendPhoneVerificationResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ResendPhoneVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendPhoneVerificationResponseDescriptor = $convert.base64Decode(
    'Ch9SZXNlbmRQaG9uZVZlcmlmaWNhdGlvblJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3'
    'NhZ2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use forgotPasswordRequestDescriptor instead')
const ForgotPasswordRequest$json = {
  '1': 'ForgotPasswordRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 2, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'delivery_method', '3': 3, '4': 1, '5': 14, '6': '.auth.PasswordResetDeliveryMethod', '10': 'deliveryMethod'},
  ],
};

/// Descriptor for `ForgotPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordRequestDescriptor = $convert.base64Decode(
    'ChVGb3Jnb3RQYXNzd29yZFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhQKBXBob25lGA'
    'IgASgJUgVwaG9uZRJKCg9kZWxpdmVyeV9tZXRob2QYAyABKA4yIS5hdXRoLlBhc3N3b3JkUmVz'
    'ZXREZWxpdmVyeU1ldGhvZFIOZGVsaXZlcnlNZXRob2Q=');

@$core.Deprecated('Use forgotPasswordResponseDescriptor instead')
const ForgotPasswordResponse$json = {
  '1': 'ForgotPasswordResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'delivery_method', '3': 3, '4': 1, '5': 9, '10': 'deliveryMethod'},
    {'1': 'masked_contact', '3': 4, '4': 1, '5': 9, '10': 'maskedContact'},
    {'1': 'expires_in_seconds', '3': 5, '4': 1, '5': 3, '10': 'expiresInSeconds'},
    {'1': 'user_found', '3': 6, '4': 1, '5': 8, '10': 'userFound'},
  ],
};

/// Descriptor for `ForgotPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgotPasswordResponseDescriptor = $convert.base64Decode(
    'ChZGb3Jnb3RQYXNzd29yZFJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USGAoHc3'
    'VjY2VzcxgCIAEoCFIHc3VjY2VzcxInCg9kZWxpdmVyeV9tZXRob2QYAyABKAlSDmRlbGl2ZXJ5'
    'TWV0aG9kEiUKDm1hc2tlZF9jb250YWN0GAQgASgJUg1tYXNrZWRDb250YWN0EiwKEmV4cGlyZX'
    'NfaW5fc2Vjb25kcxgFIAEoA1IQZXhwaXJlc0luU2Vjb25kcxIdCgp1c2VyX2ZvdW5kGAYgASgI'
    'Ugl1c2VyRm91bmQ=');

@$core.Deprecated('Use verifyPasswordResetCodeRequestDescriptor instead')
const VerifyPasswordResetCodeRequest$json = {
  '1': 'VerifyPasswordResetCodeRequest',
  '2': [
    {'1': 'contact', '3': 1, '4': 1, '5': 9, '10': 'contact'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'delivery_method', '3': 3, '4': 1, '5': 14, '6': '.auth.PasswordResetDeliveryMethod', '10': 'deliveryMethod'},
  ],
};

/// Descriptor for `VerifyPasswordResetCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasswordResetCodeRequestDescriptor = $convert.base64Decode(
    'Ch5WZXJpZnlQYXNzd29yZFJlc2V0Q29kZVJlcXVlc3QSGAoHY29udGFjdBgBIAEoCVIHY29udG'
    'FjdBISCgRjb2RlGAIgASgJUgRjb2RlEkoKD2RlbGl2ZXJ5X21ldGhvZBgDIAEoDjIhLmF1dGgu'
    'UGFzc3dvcmRSZXNldERlbGl2ZXJ5TWV0aG9kUg5kZWxpdmVyeU1ldGhvZA==');

@$core.Deprecated('Use verifyPasswordResetCodeResponseDescriptor instead')
const VerifyPasswordResetCodeResponse$json = {
  '1': 'VerifyPasswordResetCodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'reset_token', '3': 3, '4': 1, '5': 9, '10': 'resetToken'},
    {'1': 'expires_in_seconds', '3': 4, '4': 1, '5': 3, '10': 'expiresInSeconds'},
  ],
};

/// Descriptor for `VerifyPasswordResetCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasswordResetCodeResponseDescriptor = $convert.base64Decode(
    'Ch9WZXJpZnlQYXNzd29yZFJlc2V0Q29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgtyZXNldF90b2tlbhgDIAEoCVIKcmVz'
    'ZXRUb2tlbhIsChJleHBpcmVzX2luX3NlY29uZHMYBCABKANSEGV4cGlyZXNJblNlY29uZHM=');

@$core.Deprecated('Use resetPasswordRequestDescriptor instead')
const ResetPasswordRequest$json = {
  '1': 'ResetPasswordRequest',
  '2': [
    {'1': 'reset_token', '3': 1, '4': 1, '5': 9, '10': 'resetToken'},
    {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ResetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordRequestDescriptor = $convert.base64Decode(
    'ChRSZXNldFBhc3N3b3JkUmVxdWVzdBIfCgtyZXNldF90b2tlbhgBIAEoCVIKcmVzZXRUb2tlbh'
    'IhCgxuZXdfcGFzc3dvcmQYAiABKAlSC25ld1Bhc3N3b3Jk');

@$core.Deprecated('Use resetPasswordResponseDescriptor instead')
const ResetPasswordResponse$json = {
  '1': 'ResetPasswordResponse',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ResetPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordResponseDescriptor = $convert.base64Decode(
    'ChVSZXNldFBhc3N3b3JkUmVzcG9uc2USEAoDbXNnGAEgASgJUgNtc2cSGAoHc3VjY2VzcxgCIA'
    'EoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use changePasswordRequestDescriptor instead')
const ChangePasswordRequest$json = {
  '1': 'ChangePasswordRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'current_password', '3': 2, '4': 1, '5': 9, '10': 'currentPassword'},
    {'1': 'new_password', '3': 3, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ChangePasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasswordRequestDescriptor = $convert.base64Decode(
    'ChVDaGFuZ2VQYXNzd29yZFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEikKEGN1cn'
    'JlbnRfcGFzc3dvcmQYAiABKAlSD2N1cnJlbnRQYXNzd29yZBIhCgxuZXdfcGFzc3dvcmQYAyAB'
    'KAlSC25ld1Bhc3N3b3Jk');

@$core.Deprecated('Use changePasswordResponseDescriptor instead')
const ChangePasswordResponse$json = {
  '1': 'ChangePasswordResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ChangePasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasswordResponseDescriptor = $convert.base64Decode(
    'ChZDaGFuZ2VQYXNzd29yZFJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getMeRequestDescriptor instead')
const GetMeRequest$json = {
  '1': 'GetMeRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetMeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeRequestDescriptor = $convert.base64Decode(
    'CgxHZXRNZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getMeResponseDescriptor instead')
const GetMeResponse$json = {
  '1': 'GetMeResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `GetMeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeResponseDescriptor = $convert.base64Decode(
    'Cg1HZXRNZVJlc3BvbnNlEh4KBHVzZXIYASABKAsyCi5hdXRoLlVzZXJSBHVzZXI=');

@$core.Deprecated('Use updateProfileRequestDescriptor instead')
const UpdateProfileRequest$json = {
  '1': 'UpdateProfileRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'profile_picture', '3': 6, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `UpdateProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProfileRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVQcm9maWxlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHQoKZmlyc3'
    'RfbmFtZRgCIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgDIAEoCVIIbGFzdE5hbWUSGgoI'
    'dXNlcm5hbWUYBCABKAlSCHVzZXJuYW1lEhQKBXBob25lGAUgASgJUgVwaG9uZRInCg9wcm9maW'
    'xlX3BpY3R1cmUYBiABKAlSDnByb2ZpbGVQaWN0dXJl');

@$core.Deprecated('Use updateProfileResponseDescriptor instead')
const UpdateProfileResponse$json = {
  '1': 'UpdateProfileResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `UpdateProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProfileResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVQcm9maWxlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2'
    'cYAiABKAlSA21zZxIeCgR1c2VyGAMgASgLMgouYXV0aC5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use facialLoginRequestDescriptor instead')
const FacialLoginRequest$json = {
  '1': 'FacialLoginRequest',
  '2': [
    {'1': 'facial_data', '3': 1, '4': 1, '5': 12, '10': 'facialData'},
    {'1': 'device_id', '3': 2, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `FacialLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialLoginRequestDescriptor = $convert.base64Decode(
    'ChJGYWNpYWxMb2dpblJlcXVlc3QSHwoLZmFjaWFsX2RhdGEYASABKAxSCmZhY2lhbERhdGESGw'
    'oJZGV2aWNlX2lkGAIgASgJUghkZXZpY2VJZA==');

@$core.Deprecated('Use facialLoginResponseDescriptor instead')
const FacialLoginResponse$json = {
  '1': 'FacialLoginResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `FacialLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialLoginResponseDescriptor = $convert.base64Decode(
    'ChNGYWNpYWxMb2dpblJlc3BvbnNlEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW'
    '4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyAB'
    'KANSCWV4cGlyZXNJbhIeCgR1c2VyGAQgASgLMgouYXV0aC5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use socialLoginRequestDescriptor instead')
const SocialLoginRequest$json = {
  '1': 'SocialLoginRequest',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'first_name', '3': 4, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 5, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'provider_user_id', '3': 6, '4': 1, '5': 9, '10': 'providerUserId'},
  ],
};

/// Descriptor for `SocialLoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialLoginRequestDescriptor = $convert.base64Decode(
    'ChJTb2NpYWxMb2dpblJlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEiUKDnByb3'
    'ZpZGVyX3Rva2VuGAIgASgJUg1wcm92aWRlclRva2VuEhQKBWVtYWlsGAMgASgJUgVlbWFpbBId'
    'CgpmaXJzdF9uYW1lGAQgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAUgASgJUghsYXN0Tm'
    'FtZRIoChBwcm92aWRlcl91c2VyX2lkGAYgASgJUg5wcm92aWRlclVzZXJJZA==');

@$core.Deprecated('Use socialLoginResponseDescriptor instead')
const SocialLoginResponse$json = {
  '1': 'SocialLoginResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
    {'1': 'is_new_user', '3': 5, '4': 1, '5': 8, '10': 'isNewUser'},
  ],
};

/// Descriptor for `SocialLoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List socialLoginResponseDescriptor = $convert.base64Decode(
    'ChNTb2NpYWxMb2dpblJlc3BvbnNlEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW'
    '4SIwoNcmVmcmVzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEh0KCmV4cGlyZXNfaW4YAyAB'
    'KANSCWV4cGlyZXNJbhIeCgR1c2VyGAQgASgLMgouYXV0aC5Vc2VyUgR1c2VyEh4KC2lzX25ld1'
    '91c2VyGAUgASgIUglpc05ld1VzZXI=');

@$core.Deprecated('Use linkedSocialAccountDescriptor instead')
const LinkedSocialAccount$json = {
  '1': 'LinkedSocialAccount',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_user_id', '3': 4, '4': 1, '5': 9, '10': 'providerUserId'},
    {'1': 'provider_email', '3': 5, '4': 1, '5': 9, '10': 'providerEmail'},
    {'1': 'display_name', '3': 6, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'profile_picture_url', '3': 7, '4': 1, '5': 9, '10': 'profilePictureUrl'},
    {'1': 'profile_url', '3': 8, '4': 1, '5': 9, '10': 'profileUrl'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'is_primary', '3': 10, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'linked_at', '3': 11, '4': 1, '5': 9, '10': 'linkedAt'},
    {'1': 'last_used_at', '3': 12, '4': 1, '5': 9, '10': 'lastUsedAt'},
  ],
};

/// Descriptor for `LinkedSocialAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkedSocialAccountDescriptor = $convert.base64Decode(
    'ChNMaW5rZWRTb2NpYWxBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSGgoIcHJvdmlkZXIYAyABKAlSCHByb3ZpZGVyEigKEHByb3ZpZGVyX3VzZXJfaWQY'
    'BCABKAlSDnByb3ZpZGVyVXNlcklkEiUKDnByb3ZpZGVyX2VtYWlsGAUgASgJUg1wcm92aWRlck'
    'VtYWlsEiEKDGRpc3BsYXlfbmFtZRgGIAEoCVILZGlzcGxheU5hbWUSLgoTcHJvZmlsZV9waWN0'
    'dXJlX3VybBgHIAEoCVIRcHJvZmlsZVBpY3R1cmVVcmwSHwoLcHJvZmlsZV91cmwYCCABKAlSCn'
    'Byb2ZpbGVVcmwSFgoGc3RhdHVzGAkgASgJUgZzdGF0dXMSHQoKaXNfcHJpbWFyeRgKIAEoCFIJ'
    'aXNQcmltYXJ5EhsKCWxpbmtlZF9hdBgLIAEoCVIIbGlua2VkQXQSIAoMbGFzdF91c2VkX2F0GA'
    'wgASgJUgpsYXN0VXNlZEF0');

@$core.Deprecated('Use getLinkedSocialAccountsRequestDescriptor instead')
const GetLinkedSocialAccountsRequest$json = {
  '1': 'GetLinkedSocialAccountsRequest',
};

/// Descriptor for `GetLinkedSocialAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedSocialAccountsRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRMaW5rZWRTb2NpYWxBY2NvdW50c1JlcXVlc3Q=');

@$core.Deprecated('Use getLinkedSocialAccountsResponseDescriptor instead')
const GetLinkedSocialAccountsResponse$json = {
  '1': 'GetLinkedSocialAccountsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'accounts', '3': 2, '4': 3, '5': 11, '6': '.auth.LinkedSocialAccount', '10': 'accounts'},
    {'1': 'total_count', '3': 3, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetLinkedSocialAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLinkedSocialAccountsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRMaW5rZWRTb2NpYWxBY2NvdW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSNQoIYWNjb3VudHMYAiADKAsyGS5hdXRoLkxpbmtlZFNvY2lhbEFjY291bnRSCGFjY291'
    'bnRzEh8KC3RvdGFsX2NvdW50GAMgASgFUgp0b3RhbENvdW50');

@$core.Deprecated('Use linkSocialAccountRequestDescriptor instead')
const LinkSocialAccountRequest$json = {
  '1': 'LinkSocialAccountRequest',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
    {'1': 'provider_user_id', '3': 3, '4': 1, '5': 9, '10': 'providerUserId'},
    {'1': 'provider_email', '3': 4, '4': 1, '5': 9, '10': 'providerEmail'},
    {'1': 'display_name', '3': 5, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'profile_picture_url', '3': 6, '4': 1, '5': 9, '10': 'profilePictureUrl'},
    {'1': 'profile_url', '3': 7, '4': 1, '5': 9, '10': 'profileUrl'},
    {'1': 'set_as_primary', '3': 8, '4': 1, '5': 8, '10': 'setAsPrimary'},
  ],
};

/// Descriptor for `LinkSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkSocialAccountRequestDescriptor = $convert.base64Decode(
    'ChhMaW5rU29jaWFsQWNjb3VudFJlcXVlc3QSGgoIcHJvdmlkZXIYASABKAlSCHByb3ZpZGVyEi'
    'UKDnByb3ZpZGVyX3Rva2VuGAIgASgJUg1wcm92aWRlclRva2VuEigKEHByb3ZpZGVyX3VzZXJf'
    'aWQYAyABKAlSDnByb3ZpZGVyVXNlcklkEiUKDnByb3ZpZGVyX2VtYWlsGAQgASgJUg1wcm92aW'
    'RlckVtYWlsEiEKDGRpc3BsYXlfbmFtZRgFIAEoCVILZGlzcGxheU5hbWUSLgoTcHJvZmlsZV9w'
    'aWN0dXJlX3VybBgGIAEoCVIRcHJvZmlsZVBpY3R1cmVVcmwSHwoLcHJvZmlsZV91cmwYByABKA'
    'lSCnByb2ZpbGVVcmwSJAoOc2V0X2FzX3ByaW1hcnkYCCABKAhSDHNldEFzUHJpbWFyeQ==');

@$core.Deprecated('Use linkSocialAccountResponseDescriptor instead')
const LinkSocialAccountResponse$json = {
  '1': 'LinkSocialAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'account', '3': 3, '4': 1, '5': 11, '6': '.auth.LinkedSocialAccount', '10': 'account'},
  ],
};

/// Descriptor for `LinkSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkSocialAccountResponseDescriptor = $convert.base64Decode(
    'ChlMaW5rU29jaWFsQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIzCgdhY2NvdW50GAMgASgLMhkuYXV0aC5MaW5rZWRT'
    'b2NpYWxBY2NvdW50UgdhY2NvdW50');

@$core.Deprecated('Use unlinkSocialAccountRequestDescriptor instead')
const UnlinkSocialAccountRequest$json = {
  '1': 'UnlinkSocialAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `UnlinkSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkSocialAccountRequestDescriptor = $convert.base64Decode(
    'ChpVbmxpbmtTb2NpYWxBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW'
    '50SWQ=');

@$core.Deprecated('Use unlinkSocialAccountResponseDescriptor instead')
const UnlinkSocialAccountResponse$json = {
  '1': 'UnlinkSocialAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnlinkSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkSocialAccountResponseDescriptor = $convert.base64Decode(
    'ChtVbmxpbmtTb2NpYWxBY2NvdW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use setPrimarySocialAccountRequestDescriptor instead')
const SetPrimarySocialAccountRequest$json = {
  '1': 'SetPrimarySocialAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `SetPrimarySocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrimarySocialAccountRequestDescriptor = $convert.base64Decode(
    'Ch5TZXRQcmltYXJ5U29jaWFsQWNjb3VudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYW'
    'Njb3VudElk');

@$core.Deprecated('Use setPrimarySocialAccountResponseDescriptor instead')
const SetPrimarySocialAccountResponse$json = {
  '1': 'SetPrimarySocialAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'account', '3': 3, '4': 1, '5': 11, '6': '.auth.LinkedSocialAccount', '10': 'account'},
  ],
};

/// Descriptor for `SetPrimarySocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrimarySocialAccountResponseDescriptor = $convert.base64Decode(
    'Ch9TZXRQcmltYXJ5U29jaWFsQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIzCgdhY2NvdW50GAMgASgLMhkuYXV0aC5M'
    'aW5rZWRTb2NpYWxBY2NvdW50UgdhY2NvdW50');

@$core.Deprecated('Use reauthorizeSocialAccountRequestDescriptor instead')
const ReauthorizeSocialAccountRequest$json = {
  '1': 'ReauthorizeSocialAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'provider_token', '3': 2, '4': 1, '5': 9, '10': 'providerToken'},
  ],
};

/// Descriptor for `ReauthorizeSocialAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reauthorizeSocialAccountRequestDescriptor = $convert.base64Decode(
    'Ch9SZWF1dGhvcml6ZVNvY2lhbEFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCW'
    'FjY291bnRJZBIlCg5wcm92aWRlcl90b2tlbhgCIAEoCVINcHJvdmlkZXJUb2tlbg==');

@$core.Deprecated('Use reauthorizeSocialAccountResponseDescriptor instead')
const ReauthorizeSocialAccountResponse$json = {
  '1': 'ReauthorizeSocialAccountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'account', '3': 3, '4': 1, '5': 11, '6': '.auth.LinkedSocialAccount', '10': 'account'},
  ],
};

/// Descriptor for `ReauthorizeSocialAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reauthorizeSocialAccountResponseDescriptor = $convert.base64Decode(
    'CiBSZWF1dGhvcml6ZVNvY2lhbEFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
    'NjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USMwoHYWNjb3VudBgDIAEoCzIZLmF1dGgu'
    'TGlua2VkU29jaWFsQWNjb3VudFIHYWNjb3VudA==');

@$core.Deprecated('Use enableTwoFactorRequestDescriptor instead')
const EnableTwoFactorRequest$json = {
  '1': 'EnableTwoFactorRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
  ],
};

/// Descriptor for `EnableTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableTwoFactorRequestDescriptor = $convert.base64Decode(
    'ChZFbmFibGVUd29GYWN0b3JSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIWCgZtZX'
    'Rob2QYAiABKAlSBm1ldGhvZA==');

@$core.Deprecated('Use enableTwoFactorResponseDescriptor instead')
const EnableTwoFactorResponse$json = {
  '1': 'EnableTwoFactorResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'qr_code', '3': 2, '4': 1, '5': 9, '10': 'qrCode'},
    {'1': 'secret', '3': 3, '4': 1, '5': 9, '10': 'secret'},
    {'1': 'backup_codes', '3': 4, '4': 3, '5': 9, '10': 'backupCodes'},
    {'1': 'method_name', '3': 5, '4': 1, '5': 9, '10': 'methodName'},
    {'1': 'verification_required', '3': 6, '4': 1, '5': 8, '10': 'verificationRequired'},
  ],
};

/// Descriptor for `EnableTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableTwoFactorResponseDescriptor = $convert.base64Decode(
    'ChdFbmFibGVUd29GYWN0b3JSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEhcKB3'
    'FyX2NvZGUYAiABKAlSBnFyQ29kZRIWCgZzZWNyZXQYAyABKAlSBnNlY3JldBIhCgxiYWNrdXBf'
    'Y29kZXMYBCADKAlSC2JhY2t1cENvZGVzEh8KC21ldGhvZF9uYW1lGAUgASgJUgptZXRob2ROYW'
    '1lEjMKFXZlcmlmaWNhdGlvbl9yZXF1aXJlZBgGIAEoCFIUdmVyaWZpY2F0aW9uUmVxdWlyZWQ=');

@$core.Deprecated('Use verifyTwoFactorRequestDescriptor instead')
const VerifyTwoFactorRequest$json = {
  '1': 'VerifyTwoFactorRequest',
  '2': [
    {'1': 'two_factor_token', '3': 1, '4': 1, '5': 9, '10': 'twoFactorToken'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'method', '3': 3, '4': 1, '5': 9, '10': 'method'},
  ],
};

/// Descriptor for `VerifyTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTwoFactorRequestDescriptor = $convert.base64Decode(
    'ChZWZXJpZnlUd29GYWN0b3JSZXF1ZXN0EigKEHR3b19mYWN0b3JfdG9rZW4YASABKAlSDnR3b0'
    'ZhY3RvclRva2VuEhIKBGNvZGUYAiABKAlSBGNvZGUSFgoGbWV0aG9kGAMgASgJUgZtZXRob2Q=');

@$core.Deprecated('Use verifyTwoFactorResponseDescriptor instead')
const VerifyTwoFactorResponse$json = {
  '1': 'VerifyTwoFactorResponse',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.User', '10': 'user'},
  ],
};

/// Descriptor for `VerifyTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTwoFactorResponseDescriptor = $convert.base64Decode(
    'ChdWZXJpZnlUd29GYWN0b3JSZXNwb25zZRIhCgxhY2Nlc3NfdG9rZW4YASABKAlSC2FjY2Vzc1'
    'Rva2VuEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbhIdCgpleHBpcmVzX2lu'
    'GAMgASgDUglleHBpcmVzSW4SHgoEdXNlchgEIAEoCzIKLmF1dGguVXNlclIEdXNlcg==');

@$core.Deprecated('Use completeTwoFactorSetupRequestDescriptor instead')
const CompleteTwoFactorSetupRequest$json = {
  '1': 'CompleteTwoFactorSetupRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `CompleteTwoFactorSetupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeTwoFactorSetupRequestDescriptor = $convert.base64Decode(
    'Ch1Db21wbGV0ZVR3b0ZhY3RvclNldHVwUmVxdWVzdBISCgRjb2RlGAEgASgJUgRjb2Rl');

@$core.Deprecated('Use completeTwoFactorSetupResponseDescriptor instead')
const CompleteTwoFactorSetupResponse$json = {
  '1': 'CompleteTwoFactorSetupResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CompleteTwoFactorSetupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeTwoFactorSetupResponseDescriptor = $convert.base64Decode(
    'Ch5Db21wbGV0ZVR3b0ZhY3RvclNldHVwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
    'VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use disableTwoFactorRequestDescriptor instead')
const DisableTwoFactorRequest$json = {
  '1': 'DisableTwoFactorRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `DisableTwoFactorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableTwoFactorRequestDescriptor = $convert.base64Decode(
    'ChdEaXNhYmxlVHdvRmFjdG9yUmVxdWVzdBISCgRjb2RlGAEgASgJUgRjb2Rl');

@$core.Deprecated('Use disableTwoFactorResponseDescriptor instead')
const DisableTwoFactorResponse$json = {
  '1': 'DisableTwoFactorResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DisableTwoFactorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableTwoFactorResponseDescriptor = $convert.base64Decode(
    'ChhEaXNhYmxlVHdvRmFjdG9yUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getTwoFactorStatusRequestDescriptor instead')
const GetTwoFactorStatusRequest$json = {
  '1': 'GetTwoFactorStatusRequest',
};

/// Descriptor for `GetTwoFactorStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTwoFactorStatusRequestDescriptor = $convert.base64Decode(
    'ChlHZXRUd29GYWN0b3JTdGF0dXNSZXF1ZXN0');

@$core.Deprecated('Use getTwoFactorStatusResponseDescriptor instead')
const GetTwoFactorStatusResponse$json = {
  '1': 'GetTwoFactorStatusResponse',
  '2': [
    {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
    {'1': 'method_name', '3': 3, '4': 1, '5': 9, '10': 'methodName'},
    {'1': 'method_description', '3': 4, '4': 1, '5': 9, '10': 'methodDescription'},
    {'1': 'backup_codes_count', '3': 5, '4': 1, '5': 5, '10': 'backupCodesCount'},
    {'1': 'has_backup_codes', '3': 6, '4': 1, '5': 8, '10': 'hasBackupCodes'},
  ],
};

/// Descriptor for `GetTwoFactorStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTwoFactorStatusResponseDescriptor = $convert.base64Decode(
    'ChpHZXRUd29GYWN0b3JTdGF0dXNSZXNwb25zZRIYCgdlbmFibGVkGAEgASgIUgdlbmFibGVkEh'
    'YKBm1ldGhvZBgCIAEoCVIGbWV0aG9kEh8KC21ldGhvZF9uYW1lGAMgASgJUgptZXRob2ROYW1l'
    'Ei0KEm1ldGhvZF9kZXNjcmlwdGlvbhgEIAEoCVIRbWV0aG9kRGVzY3JpcHRpb24SLAoSYmFja3'
    'VwX2NvZGVzX2NvdW50GAUgASgFUhBiYWNrdXBDb2Rlc0NvdW50EigKEGhhc19iYWNrdXBfY29k'
    'ZXMYBiABKAhSDmhhc0JhY2t1cENvZGVz');

@$core.Deprecated('Use regenerateBackupCodesRequestDescriptor instead')
const RegenerateBackupCodesRequest$json = {
  '1': 'RegenerateBackupCodesRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `RegenerateBackupCodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List regenerateBackupCodesRequestDescriptor = $convert.base64Decode(
    'ChxSZWdlbmVyYXRlQmFja3VwQ29kZXNSZXF1ZXN0EhIKBGNvZGUYASABKAlSBGNvZGU=');

@$core.Deprecated('Use regenerateBackupCodesResponseDescriptor instead')
const RegenerateBackupCodesResponse$json = {
  '1': 'RegenerateBackupCodesResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'backup_codes', '3': 3, '4': 3, '5': 9, '10': 'backupCodes'},
  ],
};

/// Descriptor for `RegenerateBackupCodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List regenerateBackupCodesResponseDescriptor = $convert.base64Decode(
    'Ch1SZWdlbmVyYXRlQmFja3VwQ29kZXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIQoMYmFja3VwX2NvZGVzGAMgAygJUgtiYWNr'
    'dXBDb2Rlcw==');

@$core.Deprecated('Use sendTwoFactorCodeRequestDescriptor instead')
const SendTwoFactorCodeRequest$json = {
  '1': 'SendTwoFactorCodeRequest',
};

/// Descriptor for `SendTwoFactorCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendTwoFactorCodeRequestDescriptor = $convert.base64Decode(
    'ChhTZW5kVHdvRmFjdG9yQ29kZVJlcXVlc3Q=');

@$core.Deprecated('Use sendTwoFactorCodeResponseDescriptor instead')
const SendTwoFactorCodeResponse$json = {
  '1': 'SendTwoFactorCodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'expires_in', '3': 3, '4': 1, '5': 3, '10': 'expiresIn'},
  ],
};

/// Descriptor for `SendTwoFactorCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendTwoFactorCodeResponseDescriptor = $convert.base64Decode(
    'ChlTZW5kVHdvRmFjdG9yQ29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIdCgpleHBpcmVzX2luGAMgASgDUglleHBpcmVzSW4=');

@$core.Deprecated('Use getAvailable2FAMethodsRequestDescriptor instead')
const GetAvailable2FAMethodsRequest$json = {
  '1': 'GetAvailable2FAMethodsRequest',
};

/// Descriptor for `GetAvailable2FAMethodsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailable2FAMethodsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRBdmFpbGFibGUyRkFNZXRob2RzUmVxdWVzdA==');

@$core.Deprecated('Use twoFactorMethodInfoDescriptor instead')
const TwoFactorMethodInfo$json = {
  '1': 'TwoFactorMethodInfo',
  '2': [
    {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'icon', '3': 4, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'available', '3': 5, '4': 1, '5': 8, '10': 'available'},
  ],
};

/// Descriptor for `TwoFactorMethodInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List twoFactorMethodInfoDescriptor = $convert.base64Decode(
    'ChNUd29GYWN0b3JNZXRob2RJbmZvEhYKBm1ldGhvZBgBIAEoCVIGbWV0aG9kEhIKBG5hbWUYAi'
    'ABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhIKBGljb24YBCAB'
    'KAlSBGljb24SHAoJYXZhaWxhYmxlGAUgASgIUglhdmFpbGFibGU=');

@$core.Deprecated('Use getAvailable2FAMethodsResponseDescriptor instead')
const GetAvailable2FAMethodsResponse$json = {
  '1': 'GetAvailable2FAMethodsResponse',
  '2': [
    {'1': 'methods', '3': 1, '4': 3, '5': 11, '6': '.auth.TwoFactorMethodInfo', '10': 'methods'},
  ],
};

/// Descriptor for `GetAvailable2FAMethodsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAvailable2FAMethodsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRBdmFpbGFibGUyRkFNZXRob2RzUmVzcG9uc2USMwoHbWV0aG9kcxgBIAMoCzIZLmF1dG'
    'guVHdvRmFjdG9yTWV0aG9kSW5mb1IHbWV0aG9kcw==');

@$core.Deprecated('Use validateTokenRequestDescriptor instead')
const ValidateTokenRequest$json = {
  '1': 'ValidateTokenRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `ValidateTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTokenRequestDescriptor = $convert.base64Decode(
    'ChRWYWxpZGF0ZVRva2VuUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use validateTokenResponseDescriptor instead')
const ValidateTokenResponse$json = {
  '1': 'ValidateTokenResponse',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'expires_at', '3': 4, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `ValidateTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTokenResponseDescriptor = $convert.base64Decode(
    'ChVWYWxpZGF0ZVRva2VuUmVzcG9uc2USFAoFdmFsaWQYASABKAhSBXZhbGlkEhcKB3VzZXJfaW'
    'QYAiABKAlSBnVzZXJJZBIUCgVlbWFpbBgDIAEoCVIFZW1haWwSHQoKZXhwaXJlc19hdBgEIAEo'
    'A1IJZXhwaXJlc0F0');

@$core.Deprecated('Use loginWithPasscodeRequestDescriptor instead')
const LoginWithPasscodeRequest$json = {
  '1': 'LoginWithPasscodeRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'passcode', '3': 2, '4': 1, '5': 9, '10': 'passcode'},
    {'1': 'device_id', '3': 3, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 4, '4': 1, '5': 9, '10': 'deviceName'},
  ],
};

/// Descriptor for `LoginWithPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginWithPasscodeRequestDescriptor = $convert.base64Decode(
    'ChhMb2dpbldpdGhQYXNzY29kZVJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3'
    'Njb2RlGAIgASgJUghwYXNzY29kZRIbCglkZXZpY2VfaWQYAyABKAlSCGRldmljZUlkEh8KC2Rl'
    'dmljZV9uYW1lGAQgASgJUgpkZXZpY2VOYW1l');

@$core.Deprecated('Use registerPasscodeRequestDescriptor instead')
const RegisterPasscodeRequest$json = {
  '1': 'RegisterPasscodeRequest',
  '2': [
    {'1': 'passcode', '3': 1, '4': 1, '5': 9, '10': 'passcode'},
  ],
};

/// Descriptor for `RegisterPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPasscodeRequestDescriptor = $convert.base64Decode(
    'ChdSZWdpc3RlclBhc3Njb2RlUmVxdWVzdBIaCghwYXNzY29kZRgBIAEoCVIIcGFzc2NvZGU=');

@$core.Deprecated('Use registerPasscodeResponseDescriptor instead')
const RegisterPasscodeResponse$json = {
  '1': 'RegisterPasscodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RegisterPasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPasscodeResponseDescriptor = $convert.base64Decode(
    'ChhSZWdpc3RlclBhc3Njb2RlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCg'
    'Ntc2cYAiABKAlSA21zZw==');

@$core.Deprecated('Use changePasscodeRequestDescriptor instead')
const ChangePasscodeRequest$json = {
  '1': 'ChangePasscodeRequest',
  '2': [
    {'1': 'current_passcode', '3': 1, '4': 1, '5': 9, '10': 'currentPasscode'},
    {'1': 'new_passcode', '3': 2, '4': 1, '5': 9, '10': 'newPasscode'},
  ],
};

/// Descriptor for `ChangePasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasscodeRequestDescriptor = $convert.base64Decode(
    'ChVDaGFuZ2VQYXNzY29kZVJlcXVlc3QSKQoQY3VycmVudF9wYXNzY29kZRgBIAEoCVIPY3Vycm'
    'VudFBhc3Njb2RlEiEKDG5ld19wYXNzY29kZRgCIAEoCVILbmV3UGFzc2NvZGU=');

@$core.Deprecated('Use changePasscodeResponseDescriptor instead')
const ChangePasscodeResponse$json = {
  '1': 'ChangePasscodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `ChangePasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changePasscodeResponseDescriptor = $convert.base64Decode(
    'ChZDaGFuZ2VQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbX'
    'NnGAIgASgJUgNtc2c=');

@$core.Deprecated('Use requestPasswordResetRequestDescriptor instead')
const RequestPasswordResetRequest$json = {
  '1': 'RequestPasswordResetRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RequestPasswordResetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetRequestDescriptor = $convert.base64Decode(
    'ChtSZXF1ZXN0UGFzc3dvcmRSZXNldFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');

@$core.Deprecated('Use requestPasswordResetResponseDescriptor instead')
const RequestPasswordResetResponse$json = {
  '1': 'RequestPasswordResetResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RequestPasswordResetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetResponseDescriptor = $convert.base64Decode(
    'ChxSZXF1ZXN0UGFzc3dvcmRSZXNldFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSEAoDbXNnGAIgASgJUgNtc2c=');

@$core.Deprecated('Use requestEmailVerificationRequestDescriptor instead')
const RequestEmailVerificationRequest$json = {
  '1': 'RequestEmailVerificationRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RequestEmailVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestEmailVerificationRequestDescriptor = $convert.base64Decode(
    'Ch9SZXF1ZXN0RW1haWxWZXJpZmljYXRpb25SZXF1ZXN0EhQKBWVtYWlsGAEgASgJUgVlbWFpbA'
    '==');

@$core.Deprecated('Use requestEmailVerificationResponseDescriptor instead')
const RequestEmailVerificationResponse$json = {
  '1': 'RequestEmailVerificationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `RequestEmailVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestEmailVerificationResponseDescriptor = $convert.base64Decode(
    'CiBSZXF1ZXN0RW1haWxWZXJpZmljYXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
    'NjZXNzEhAKA21zZxgCIAEoCVIDbXNn');

@$core.Deprecated('Use checkEmailAvailabilityRequestDescriptor instead')
const CheckEmailAvailabilityRequest$json = {
  '1': 'CheckEmailAvailabilityRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `CheckEmailAvailabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEmailAvailabilityRequestDescriptor = $convert.base64Decode(
    'Ch1DaGVja0VtYWlsQXZhaWxhYmlsaXR5UmVxdWVzdBIUCgVlbWFpbBgBIAEoCVIFZW1haWw=');

@$core.Deprecated('Use checkEmailAvailabilityResponseDescriptor instead')
const CheckEmailAvailabilityResponse$json = {
  '1': 'CheckEmailAvailabilityResponse',
  '2': [
    {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CheckEmailAvailabilityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEmailAvailabilityResponseDescriptor = $convert.base64Decode(
    'Ch5DaGVja0VtYWlsQXZhaWxhYmlsaXR5UmVzcG9uc2USHAoJYXZhaWxhYmxlGAEgASgIUglhdm'
    'FpbGFibGUSEAoDbXNnGAIgASgJUgNtc2c=');

@$core.Deprecated('Use requestPhoneVerificationRequestDescriptor instead')
const RequestPhoneVerificationRequest$json = {
  '1': 'RequestPhoneVerificationRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `RequestPhoneVerificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhoneVerificationRequestDescriptor = $convert.base64Decode(
    'Ch9SZXF1ZXN0UGhvbmVWZXJpZmljYXRpb25SZXF1ZXN0EhQKBXBob25lGAEgASgJUgVwaG9uZR'
    'IhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2Rl');

@$core.Deprecated('Use requestPhoneVerificationResponseDescriptor instead')
const RequestPhoneVerificationResponse$json = {
  '1': 'RequestPhoneVerificationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'verification_id', '3': 3, '4': 1, '5': 9, '10': 'verificationId'},
    {'1': 'expires_in', '3': 4, '4': 1, '5': 3, '10': 'expiresIn'},
  ],
};

/// Descriptor for `RequestPhoneVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPhoneVerificationResponseDescriptor = $convert.base64Decode(
    'CiBSZXF1ZXN0UGhvbmVWZXJpZmljYXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
    'NjZXNzEhAKA21zZxgCIAEoCVIDbXNnEicKD3ZlcmlmaWNhdGlvbl9pZBgDIAEoCVIOdmVyaWZp'
    'Y2F0aW9uSWQSHQoKZXhwaXJlc19pbhgEIAEoA1IJZXhwaXJlc0lu');

@$core.Deprecated('Use verifyPhoneNumberRequestDescriptor instead')
const VerifyPhoneNumberRequest$json = {
  '1': 'VerifyPhoneNumberRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    {'1': 'verification_id', '3': 4, '4': 1, '5': 9, '10': 'verificationId'},
  ],
};

/// Descriptor for `VerifyPhoneNumberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneNumberRequestDescriptor = $convert.base64Decode(
    'ChhWZXJpZnlQaG9uZU51bWJlclJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEiEKDGNvdW'
    '50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGUSEgoEY29kZRgDIAEoCVIEY29kZRInCg92ZXJp'
    'ZmljYXRpb25faWQYBCABKAlSDnZlcmlmaWNhdGlvbklk');

@$core.Deprecated('Use verifyPhoneNumberResponseDescriptor instead')
const VerifyPhoneNumberResponse$json = {
  '1': 'VerifyPhoneNumberResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'is_verified', '3': 3, '4': 1, '5': 8, '10': 'isVerified'},
  ],
};

/// Descriptor for `VerifyPhoneNumberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPhoneNumberResponseDescriptor = $convert.base64Decode(
    'ChlWZXJpZnlQaG9uZU51bWJlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEA'
    'oDbXNnGAIgASgJUgNtc2cSHwoLaXNfdmVyaWZpZWQYAyABKAhSCmlzVmVyaWZpZWQ=');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'email_verified', '3': 7, '4': 1, '5': 8, '10': 'emailVerified'},
    {'1': 'phone_verified', '3': 8, '4': 1, '5': 8, '10': 'phoneVerified'},
    {'1': 'two_factor_enabled', '3': 9, '4': 1, '5': 8, '10': 'twoFactorEnabled'},
    {'1': 'two_factor_method', '3': 10, '4': 1, '5': 9, '10': 'twoFactorMethod'},
    {'1': 'profile_picture', '3': 11, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'signup_status', '3': 14, '4': 1, '5': 9, '10': 'signupStatus'},
    {'1': 'current_signup_step', '3': 15, '4': 1, '5': 9, '10': 'currentSignupStep'},
    {'1': 'username', '3': 16, '4': 1, '5': 9, '10': 'username'},
    {'1': 'identity_verified', '3': 17, '4': 1, '5': 8, '10': 'identityVerified'},
    {'1': 'identity_type', '3': 18, '4': 1, '5': 9, '10': 'identityType'},
    {'1': 'identity_verified_at', '3': 19, '4': 1, '5': 9, '10': 'identityVerifiedAt'},
    {'1': 'date_of_birth', '3': 20, '4': 1, '5': 9, '10': 'dateOfBirth'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSHQoKZmlyc3Rfbm'
    'FtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSFAoFcGhv'
    'bmUYBSABKAlSBXBob25lEiEKDGNvdW50cnlfY29kZRgGIAEoCVILY291bnRyeUNvZGUSJQoOZW'
    '1haWxfdmVyaWZpZWQYByABKAhSDWVtYWlsVmVyaWZpZWQSJQoOcGhvbmVfdmVyaWZpZWQYCCAB'
    'KAhSDXBob25lVmVyaWZpZWQSLAoSdHdvX2ZhY3Rvcl9lbmFibGVkGAkgASgIUhB0d29GYWN0b3'
    'JFbmFibGVkEioKEXR3b19mYWN0b3JfbWV0aG9kGAogASgJUg90d29GYWN0b3JNZXRob2QSJwoP'
    'cHJvZmlsZV9waWN0dXJlGAsgASgJUg5wcm9maWxlUGljdHVyZRIdCgpjcmVhdGVkX2F0GAwgAS'
    'gJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgNIAEoCVIJdXBkYXRlZEF0EiMKDXNpZ251cF9z'
    'dGF0dXMYDiABKAlSDHNpZ251cFN0YXR1cxIuChNjdXJyZW50X3NpZ251cF9zdGVwGA8gASgJUh'
    'FjdXJyZW50U2lnbnVwU3RlcBIaCgh1c2VybmFtZRgQIAEoCVIIdXNlcm5hbWUSKwoRaWRlbnRp'
    'dHlfdmVyaWZpZWQYESABKAhSEGlkZW50aXR5VmVyaWZpZWQSIwoNaWRlbnRpdHlfdHlwZRgSIA'
    'EoCVIMaWRlbnRpdHlUeXBlEjAKFGlkZW50aXR5X3ZlcmlmaWVkX2F0GBMgASgJUhJpZGVudGl0'
    'eVZlcmlmaWVkQXQSIgoNZGF0ZV9vZl9iaXJ0aBgUIAEoCVILZGF0ZU9mQmlydGg=');

@$core.Deprecated('Use signupStepProgressDescriptor instead')
const SignupStepProgress$json = {
  '1': 'SignupStepProgress',
  '2': [
    {'1': 'step_name', '3': 1, '4': 1, '5': 9, '10': 'stepName'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.auth.StepStatus', '10': 'status'},
    {'1': 'step_data', '3': 3, '4': 1, '5': 9, '10': 'stepData'},
    {'1': 'completed_at', '3': 4, '4': 1, '5': 9, '10': 'completedAt'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 6, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SignupStepProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupStepProgressDescriptor = $convert.base64Decode(
    'ChJTaWdudXBTdGVwUHJvZ3Jlc3MSGwoJc3RlcF9uYW1lGAEgASgJUghzdGVwTmFtZRIoCgZzdG'
    'F0dXMYAiABKA4yEC5hdXRoLlN0ZXBTdGF0dXNSBnN0YXR1cxIbCglzdGVwX2RhdGEYAyABKAlS'
    'CHN0ZXBEYXRhEiEKDGNvbXBsZXRlZF9hdBgEIAEoCVILY29tcGxldGVkQXQSHQoKY3JlYXRlZF'
    '9hdBgFIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYBiABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use signupProgressDescriptor instead')
const SignupProgress$json = {
  '1': 'SignupProgress',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.auth.SignupStatus', '10': 'status'},
    {'1': 'current_step', '3': 3, '4': 1, '5': 9, '10': 'currentStep'},
    {'1': 'steps', '3': 4, '4': 3, '5': 11, '6': '.auth.SignupStepProgress', '10': 'steps'},
    {'1': 'signup_completed_at', '3': 5, '4': 1, '5': 9, '10': 'signupCompletedAt'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SignupProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupProgressDescriptor = $convert.base64Decode(
    'Cg5TaWdudXBQcm9ncmVzcxIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSKgoGc3RhdHVzGAIgAS'
    'gOMhIuYXV0aC5TaWdudXBTdGF0dXNSBnN0YXR1cxIhCgxjdXJyZW50X3N0ZXAYAyABKAlSC2N1'
    'cnJlbnRTdGVwEi4KBXN0ZXBzGAQgAygLMhguYXV0aC5TaWdudXBTdGVwUHJvZ3Jlc3NSBXN0ZX'
    'BzEi4KE3NpZ251cF9jb21wbGV0ZWRfYXQYBSABKAlSEXNpZ251cENvbXBsZXRlZEF0Eh0KCmNy'
    'ZWF0ZWRfYXQYBiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAcgASgJUgl1cGRhdGVkQX'
    'Q=');

@$core.Deprecated('Use getSignupProgressRequestDescriptor instead')
const GetSignupProgressRequest$json = {
  '1': 'GetSignupProgressRequest',
};

/// Descriptor for `GetSignupProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSignupProgressRequestDescriptor = $convert.base64Decode(
    'ChhHZXRTaWdudXBQcm9ncmVzc1JlcXVlc3Q=');

@$core.Deprecated('Use getSignupProgressResponseDescriptor instead')
const GetSignupProgressResponse$json = {
  '1': 'GetSignupProgressResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.auth.SignupProgress', '10': 'progress'},
    {'1': 'next_step', '3': 4, '4': 1, '5': 9, '10': 'nextStep'},
    {'1': 'is_complete', '3': 5, '4': 1, '5': 8, '10': 'isComplete'},
  ],
};

/// Descriptor for `GetSignupProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSignupProgressResponseDescriptor = $convert.base64Decode(
    'ChlHZXRTaWdudXBQcm9ncmVzc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEA'
    'oDbXNnGAIgASgJUgNtc2cSMAoIcHJvZ3Jlc3MYAyABKAsyFC5hdXRoLlNpZ251cFByb2dyZXNz'
    'Ughwcm9ncmVzcxIbCgluZXh0X3N0ZXAYBCABKAlSCG5leHRTdGVwEh8KC2lzX2NvbXBsZXRlGA'
    'UgASgIUgppc0NvbXBsZXRl');

@$core.Deprecated('Use updateSignupStepRequestDescriptor instead')
const UpdateSignupStepRequest$json = {
  '1': 'UpdateSignupStepRequest',
  '2': [
    {'1': 'step_name', '3': 1, '4': 1, '5': 9, '10': 'stepName'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.auth.StepStatus', '10': 'status'},
    {'1': 'step_data', '3': 3, '4': 1, '5': 9, '10': 'stepData'},
  ],
};

/// Descriptor for `UpdateSignupStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSignupStepRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVTaWdudXBTdGVwUmVxdWVzdBIbCglzdGVwX25hbWUYASABKAlSCHN0ZXBOYW1lEi'
    'gKBnN0YXR1cxgCIAEoDjIQLmF1dGguU3RlcFN0YXR1c1IGc3RhdHVzEhsKCXN0ZXBfZGF0YRgD'
    'IAEoCVIIc3RlcERhdGE=');

@$core.Deprecated('Use updateSignupStepResponseDescriptor instead')
const UpdateSignupStepResponse$json = {
  '1': 'UpdateSignupStepResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.auth.SignupProgress', '10': 'progress'},
    {'1': 'next_step', '3': 4, '4': 1, '5': 9, '10': 'nextStep'},
  ],
};

/// Descriptor for `UpdateSignupStepResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSignupStepResponseDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVTaWdudXBTdGVwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCg'
    'Ntc2cYAiABKAlSA21zZxIwCghwcm9ncmVzcxgDIAEoCzIULmF1dGguU2lnbnVwUHJvZ3Jlc3NS'
    'CHByb2dyZXNzEhsKCW5leHRfc3RlcBgEIAEoCVIIbmV4dFN0ZXA=');

@$core.Deprecated('Use completeSignupRequestDescriptor instead')
const CompleteSignupRequest$json = {
  '1': 'CompleteSignupRequest',
};

/// Descriptor for `CompleteSignupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeSignupRequestDescriptor = $convert.base64Decode(
    'ChVDb21wbGV0ZVNpZ251cFJlcXVlc3Q=');

@$core.Deprecated('Use completeSignupResponseDescriptor instead')
const CompleteSignupResponse$json = {
  '1': 'CompleteSignupResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'progress', '3': 3, '4': 1, '5': 11, '6': '.auth.SignupProgress', '10': 'progress'},
  ],
};

/// Descriptor for `CompleteSignupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeSignupResponseDescriptor = $convert.base64Decode(
    'ChZDb21wbGV0ZVNpZ251cFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSEAoDbX'
    'NnGAIgASgJUgNtc2cSMAoIcHJvZ3Jlc3MYAyABKAsyFC5hdXRoLlNpZ251cFByb2dyZXNzUghw'
    'cm9ncmVzcw==');

@$core.Deprecated('Use verifyIdentityRequestDescriptor instead')
const VerifyIdentityRequest$json = {
  '1': 'VerifyIdentityRequest',
  '2': [
    {'1': 'identity_type', '3': 1, '4': 1, '5': 14, '6': '.auth.IdentityType', '10': 'identityType'},
    {'1': 'identity_number', '3': 2, '4': 1, '5': 9, '10': 'identityNumber'},
    {'1': 'date_of_birth', '3': 3, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'first_name', '3': 5, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 6, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyIdentityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIdentityRequestDescriptor = $convert.base64Decode(
    'ChVWZXJpZnlJZGVudGl0eVJlcXVlc3QSNwoNaWRlbnRpdHlfdHlwZRgBIAEoDjISLmF1dGguSW'
    'RlbnRpdHlUeXBlUgxpZGVudGl0eVR5cGUSJwoPaWRlbnRpdHlfbnVtYmVyGAIgASgJUg5pZGVu'
    'dGl0eU51bWJlchIiCg1kYXRlX29mX2JpcnRoGAMgASgJUgtkYXRlT2ZCaXJ0aBIhCgxjb3VudH'
    'J5X2NvZGUYBCABKAlSC2NvdW50cnlDb2RlEh0KCmZpcnN0X25hbWUYBSABKAlSCWZpcnN0TmFt'
    'ZRIbCglsYXN0X25hbWUYBiABKAlSCGxhc3ROYW1lEiEKDHBob25lX251bWJlchgHIAEoCVILcG'
    'hvbmVOdW1iZXI=');

@$core.Deprecated('Use verifiedIdentityDescriptor instead')
const VerifiedIdentity$json = {
  '1': 'VerifiedIdentity',
  '2': [
    {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'middle_name', '3': 3, '4': 1, '5': 9, '10': 'middleName'},
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'date_of_birth', '3': 5, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'photo_url', '3': 7, '4': 1, '5': 9, '10': 'photoUrl'},
    {'1': 'address', '3': 8, '4': 1, '5': 9, '10': 'address'},
    {'1': 'state_of_origin', '3': 9, '4': 1, '5': 9, '10': 'stateOfOrigin'},
    {'1': 'lga_of_origin', '3': 10, '4': 1, '5': 9, '10': 'lgaOfOrigin'},
  ],
};

/// Descriptor for `VerifiedIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifiedIdentityDescriptor = $convert.base64Decode(
    'ChBWZXJpZmllZElkZW50aXR5Eh0KCmZpcnN0X25hbWUYASABKAlSCWZpcnN0TmFtZRIbCglsYX'
    'N0X25hbWUYAiABKAlSCGxhc3ROYW1lEh8KC21pZGRsZV9uYW1lGAMgASgJUgptaWRkbGVOYW1l'
    'EiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISIgoNZGF0ZV9vZl9iaXJ0aBgFIA'
    'EoCVILZGF0ZU9mQmlydGgSFgoGZ2VuZGVyGAYgASgJUgZnZW5kZXISGwoJcGhvdG9fdXJsGAcg'
    'ASgJUghwaG90b1VybBIYCgdhZGRyZXNzGAggASgJUgdhZGRyZXNzEiYKD3N0YXRlX29mX29yaW'
    'dpbhgJIAEoCVINc3RhdGVPZk9yaWdpbhIiCg1sZ2Ffb2Zfb3JpZ2luGAogASgJUgtsZ2FPZk9y'
    'aWdpbg==');

@$core.Deprecated('Use verifyIdentityResponseDescriptor instead')
const VerifyIdentityResponse$json = {
  '1': 'VerifyIdentityResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'verified', '3': 2, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'error_code', '3': 3, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'identity', '3': 5, '4': 1, '5': 11, '6': '.auth.VerifiedIdentity', '10': 'identity'},
    {'1': 'virtual_account', '3': 6, '4': 1, '5': 11, '6': '.auth.VirtualAccountInfo', '10': 'virtualAccount'},
    {'1': 'verification_id', '3': 7, '4': 1, '5': 9, '10': 'verificationId'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'session_url', '3': 9, '4': 1, '5': 9, '10': 'sessionUrl'},
    {'1': 'session_token', '3': 10, '4': 1, '5': 9, '10': 'sessionToken'},
  ],
};

/// Descriptor for `VerifyIdentityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIdentityResponseDescriptor = $convert.base64Decode(
    'ChZWZXJpZnlJZGVudGl0eVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGgoIdm'
    'VyaWZpZWQYAiABKAhSCHZlcmlmaWVkEh0KCmVycm9yX2NvZGUYAyABKAlSCWVycm9yQ29kZRIj'
    'Cg1lcnJvcl9tZXNzYWdlGAQgASgJUgxlcnJvck1lc3NhZ2USMgoIaWRlbnRpdHkYBSABKAsyFi'
    '5hdXRoLlZlcmlmaWVkSWRlbnRpdHlSCGlkZW50aXR5EkEKD3ZpcnR1YWxfYWNjb3VudBgGIAEo'
    'CzIYLmF1dGguVmlydHVhbEFjY291bnRJbmZvUg52aXJ0dWFsQWNjb3VudBInCg92ZXJpZmljYX'
    'Rpb25faWQYByABKAlSDnZlcmlmaWNhdGlvbklkEhYKBnN0YXR1cxgIIAEoCVIGc3RhdHVzEh8K'
    'C3Nlc3Npb25fdXJsGAkgASgJUgpzZXNzaW9uVXJsEiMKDXNlc3Npb25fdG9rZW4YCiABKAlSDH'
    'Nlc3Npb25Ub2tlbg==');

@$core.Deprecated('Use virtualAccountInfoDescriptor instead')
const VirtualAccountInfo$json = {
  '1': 'VirtualAccountInfo',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'bank_name', '3': 2, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 3, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'provider', '3': 6, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `VirtualAccountInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List virtualAccountInfoDescriptor = $convert.base64Decode(
    'ChJWaXJ0dWFsQWNjb3VudEluZm8SJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW'
    '1iZXISGwoJYmFua19uYW1lGAIgASgJUghiYW5rTmFtZRIbCgliYW5rX2NvZGUYAyABKAlSCGJh'
    'bmtDb2RlEiEKDGFjY291bnRfbmFtZRgEIAEoCVILYWNjb3VudE5hbWUSGgoIY3VycmVuY3kYBS'
    'ABKAlSCGN1cnJlbmN5EhoKCHByb3ZpZGVyGAYgASgJUghwcm92aWRlcg==');

@$core.Deprecated('Use getIdentityVerificationStatusRequestDescriptor instead')
const GetIdentityVerificationStatusRequest$json = {
  '1': 'GetIdentityVerificationStatusRequest',
};

/// Descriptor for `GetIdentityVerificationStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIdentityVerificationStatusRequestDescriptor = $convert.base64Decode(
    'CiRHZXRJZGVudGl0eVZlcmlmaWNhdGlvblN0YXR1c1JlcXVlc3Q=');

@$core.Deprecated('Use getIdentityVerificationStatusResponseDescriptor instead')
const GetIdentityVerificationStatusResponse$json = {
  '1': 'GetIdentityVerificationStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'identity_verified', '3': 3, '4': 1, '5': 8, '10': 'identityVerified'},
    {'1': 'identity_type', '3': 4, '4': 1, '5': 14, '6': '.auth.IdentityType', '10': 'identityType'},
    {'1': 'identity_verified_at', '3': 5, '4': 1, '5': 9, '10': 'identityVerifiedAt'},
    {'1': 'masked_identity_number', '3': 6, '4': 1, '5': 9, '10': 'maskedIdentityNumber'},
  ],
};

/// Descriptor for `GetIdentityVerificationStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIdentityVerificationStatusResponseDescriptor = $convert.base64Decode(
    'CiVHZXRJZGVudGl0eVZlcmlmaWNhdGlvblN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKA'
    'hSB3N1Y2Nlc3MSEAoDbXNnGAIgASgJUgNtc2cSKwoRaWRlbnRpdHlfdmVyaWZpZWQYAyABKAhS'
    'EGlkZW50aXR5VmVyaWZpZWQSNwoNaWRlbnRpdHlfdHlwZRgEIAEoDjISLmF1dGguSWRlbnRpdH'
    'lUeXBlUgxpZGVudGl0eVR5cGUSMAoUaWRlbnRpdHlfdmVyaWZpZWRfYXQYBSABKAlSEmlkZW50'
    'aXR5VmVyaWZpZWRBdBI0ChZtYXNrZWRfaWRlbnRpdHlfbnVtYmVyGAYgASgJUhRtYXNrZWRJZG'
    'VudGl0eU51bWJlcg==');

@$core.Deprecated('Use lookupUserByUsernameRequestDescriptor instead')
const LookupUserByUsernameRequest$json = {
  '1': 'LookupUserByUsernameRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `LookupUserByUsernameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserByUsernameRequestDescriptor = $convert.base64Decode(
    'ChtMb29rdXBVc2VyQnlVc2VybmFtZVJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW'
    '1l');

@$core.Deprecated('Use lookupUserByPhoneRequestDescriptor instead')
const LookupUserByPhoneRequest$json = {
  '1': 'LookupUserByPhoneRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `LookupUserByPhoneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserByPhoneRequestDescriptor = $convert.base64Decode(
    'ChhMb29rdXBVc2VyQnlQaG9uZVJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25l');

@$core.Deprecated('Use userLookupResponseDescriptor instead')
const UserLookupResponse$json = {
  '1': 'UserLookupResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'found', '3': 3, '4': 1, '5': 8, '10': 'found'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.auth.UserLookupResult', '10': 'user'},
  ],
};

/// Descriptor for `UserLookupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLookupResponseDescriptor = $convert.base64Decode(
    'ChJVc2VyTG9va3VwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAi'
    'ABKAlSA21zZxIUCgVmb3VuZBgDIAEoCFIFZm91bmQSKgoEdXNlchgEIAEoCzIWLmF1dGguVXNl'
    'ckxvb2t1cFJlc3VsdFIEdXNlcg==');

@$core.Deprecated('Use userLookupResultDescriptor instead')
const UserLookupResult$json = {
  '1': 'UserLookupResult',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'profile_picture', '3': 5, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'is_lazervault_user', '3': 6, '4': 1, '5': 8, '10': 'isLazervaultUser'},
    {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'email', '3': 8, '4': 1, '5': 9, '10': 'email'},
    {'1': 'primary_account_id', '3': 9, '4': 1, '5': 9, '10': 'primaryAccountId'},
    {'1': 'country_code', '3': 10, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `UserLookupResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userLookupResultDescriptor = $convert.base64Decode(
    'ChBVc2VyTG9va3VwUmVzdWx0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZR'
    'gCIAEoCVIIdXNlcm5hbWUSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3Rf'
    'bmFtZRgEIAEoCVIIbGFzdE5hbWUSJwoPcHJvZmlsZV9waWN0dXJlGAUgASgJUg5wcm9maWxlUG'
    'ljdHVyZRIsChJpc19sYXplcnZhdWx0X3VzZXIYBiABKAhSEGlzTGF6ZXJ2YXVsdFVzZXISIQoM'
    'cGhvbmVfbnVtYmVyGAcgASgJUgtwaG9uZU51bWJlchIUCgVlbWFpbBgIIAEoCVIFZW1haWwSLA'
    'oScHJpbWFyeV9hY2NvdW50X2lkGAkgASgJUhBwcmltYXJ5QWNjb3VudElkEiEKDGNvdW50cnlf'
    'Y29kZRgKIAEoCVILY291bnRyeUNvZGU=');

@$core.Deprecated('Use userSearchRequestDescriptor instead')
const UserSearchRequest$json = {
  '1': 'UserSearchRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'search_type', '3': 3, '4': 1, '5': 9, '10': 'searchType'},
    {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `UserSearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSearchRequestDescriptor = $convert.base64Decode(
    'ChFVc2VyU2VhcmNoUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSFAoFbGltaXQYAiABKA'
    'VSBWxpbWl0Eh8KC3NlYXJjaF90eXBlGAMgASgJUgpzZWFyY2hUeXBlEiEKDGNvdW50cnlfY29k'
    'ZRgEIAEoCVILY291bnRyeUNvZGU=');

@$core.Deprecated('Use userSearchResponseDescriptor instead')
const UserSearchResponse$json = {
  '1': 'UserSearchResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
    {'1': 'users', '3': 3, '4': 3, '5': 11, '6': '.auth.UserLookupResult', '10': 'users'},
  ],
};

/// Descriptor for `UserSearchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSearchResponseDescriptor = $convert.base64Decode(
    'ChJVc2VyU2VhcmNoUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIQCgNtc2cYAi'
    'ABKAlSA21zZxIsCgV1c2VycxgDIAMoCzIWLmF1dGguVXNlckxvb2t1cFJlc3VsdFIFdXNlcnM=');

@$core.Deprecated('Use initiateKYCRequestDescriptor instead')
const InitiateKYCRequest$json = {
  '1': 'InitiateKYCRequest',
  '2': [
    {'1': 'target_tier', '3': 1, '4': 1, '5': 14, '6': '.auth.KYCTier', '10': 'targetTier'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `InitiateKYCRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCRequestDescriptor = $convert.base64Decode(
    'ChJJbml0aWF0ZUtZQ1JlcXVlc3QSLgoLdGFyZ2V0X3RpZXIYASABKA4yDS5hdXRoLktZQ1RpZX'
    'JSCnRhcmdldFRpZXISIQoMY291bnRyeV9jb2RlGAIgASgJUgtjb3VudHJ5Q29kZQ==');

@$core.Deprecated('Use initiateKYCResponseDescriptor instead')
const InitiateKYCResponse$json = {
  '1': 'InitiateKYCResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'required_documents', '3': 3, '4': 3, '5': 9, '10': 'requiredDocuments'},
    {'1': 'required_fields', '3': 4, '4': 3, '5': 9, '10': 'requiredFields'},
    {'1': 'redirect_url', '3': 5, '4': 1, '5': 9, '10': 'redirectUrl'},
    {'1': 'error_message', '3': 6, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `InitiateKYCResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCResponseDescriptor = $convert.base64Decode(
    'ChNJbml0aWF0ZUtZQ1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKc2Vzc2'
    'lvbl9pZBgCIAEoCVIJc2Vzc2lvbklkEi0KEnJlcXVpcmVkX2RvY3VtZW50cxgDIAMoCVIRcmVx'
    'dWlyZWREb2N1bWVudHMSJwoPcmVxdWlyZWRfZmllbGRzGAQgAygJUg5yZXF1aXJlZEZpZWxkcx'
    'IhCgxyZWRpcmVjdF91cmwYBSABKAlSC3JlZGlyZWN0VXJsEiMKDWVycm9yX21lc3NhZ2UYBiAB'
    'KAlSDGVycm9yTWVzc2FnZQ==');

@$core.Deprecated('Use uploadDocumentRequestDescriptor instead')
const UploadDocumentRequest$json = {
  '1': 'UploadDocumentRequest',
  '2': [
    {'1': 'document_type', '3': 1, '4': 1, '5': 14, '6': '.auth.DocumentType', '10': 'documentType'},
    {'1': 'document_front_url', '3': 2, '4': 1, '5': 9, '10': 'documentFrontUrl'},
    {'1': 'document_back_url', '3': 3, '4': 1, '5': 9, '10': 'documentBackUrl'},
    {'1': 'selfie_url', '3': 4, '4': 1, '5': 9, '10': 'selfieUrl'},
    {'1': 'proof_of_address_url', '3': 5, '4': 1, '5': 9, '10': 'proofOfAddressUrl'},
  ],
};

/// Descriptor for `UploadDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadDocumentRequestDescriptor = $convert.base64Decode(
    'ChVVcGxvYWREb2N1bWVudFJlcXVlc3QSNwoNZG9jdW1lbnRfdHlwZRgBIAEoDjISLmF1dGguRG'
    '9jdW1lbnRUeXBlUgxkb2N1bWVudFR5cGUSLAoSZG9jdW1lbnRfZnJvbnRfdXJsGAIgASgJUhBk'
    'b2N1bWVudEZyb250VXJsEioKEWRvY3VtZW50X2JhY2tfdXJsGAMgASgJUg9kb2N1bWVudEJhY2'
    'tVcmwSHQoKc2VsZmllX3VybBgEIAEoCVIJc2VsZmllVXJsEi8KFHByb29mX29mX2FkZHJlc3Nf'
    'dXJsGAUgASgJUhFwcm9vZk9mQWRkcmVzc1VybA==');

@$core.Deprecated('Use uploadDocumentResponseDescriptor instead')
const UploadDocumentResponse$json = {
  '1': 'UploadDocumentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'document_id', '3': 3, '4': 1, '5': 9, '10': 'documentId'},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.auth.DocumentStatus', '10': 'status'},
  ],
};

/// Descriptor for `UploadDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadDocumentResponseDescriptor = $convert.base64Decode(
    'ChZVcGxvYWREb2N1bWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgtkb2N1bWVudF9pZBgDIAEoCVIKZG9jdW1lbnRJZBIs'
    'CgZzdGF0dXMYBCABKA4yFC5hdXRoLkRvY3VtZW50U3RhdHVzUgZzdGF0dXM=');

@$core.Deprecated('Use skipKYCUpgradeRequestDescriptor instead')
const SkipKYCUpgradeRequest$json = {
  '1': 'SkipKYCUpgradeRequest',
  '2': [
    {'1': 'skip_tier_2', '3': 1, '4': 1, '5': 8, '10': 'skipTier2'},
    {'1': 'skip_tier_3', '3': 2, '4': 1, '5': 8, '10': 'skipTier3'},
  ],
};

/// Descriptor for `SkipKYCUpgradeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCUpgradeRequestDescriptor = $convert.base64Decode(
    'ChVTa2lwS1lDVXBncmFkZVJlcXVlc3QSHgoLc2tpcF90aWVyXzIYASABKAhSCXNraXBUaWVyMh'
    'IeCgtza2lwX3RpZXJfMxgCIAEoCFIJc2tpcFRpZXIz');

@$core.Deprecated('Use skipKYCUpgradeResponseDescriptor instead')
const SkipKYCUpgradeResponse$json = {
  '1': 'SkipKYCUpgradeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'assigned_tier', '3': 2, '4': 1, '5': 14, '6': '.auth.KYCTier', '10': 'assignedTier'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'next_steps', '3': 4, '4': 3, '5': 9, '10': 'nextSteps'},
  ],
};

/// Descriptor for `SkipKYCUpgradeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCUpgradeResponseDescriptor = $convert.base64Decode(
    'ChZTa2lwS1lDVXBncmFkZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSMgoNYX'
    'NzaWduZWRfdGllchgCIAEoDjINLmF1dGguS1lDVGllclIMYXNzaWduZWRUaWVyEhgKB21lc3Nh'
    'Z2UYAyABKAlSB21lc3NhZ2USHQoKbmV4dF9zdGVwcxgEIAMoCVIJbmV4dFN0ZXBz');

@$core.Deprecated('Use getUserDocumentsRequestDescriptor instead')
const GetUserDocumentsRequest$json = {
  '1': 'GetUserDocumentsRequest',
};

/// Descriptor for `GetUserDocumentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyRG9jdW1lbnRzUmVxdWVzdA==');

@$core.Deprecated('Use verificationDocumentDescriptor instead')
const VerificationDocument$json = {
  '1': 'VerificationDocument',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'document_type', '3': 2, '4': 1, '5': 14, '6': '.auth.DocumentType', '10': 'documentType'},
    {'1': 'document_url', '3': 3, '4': 1, '5': 9, '10': 'documentUrl'},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.auth.DocumentStatus', '10': 'status'},
    {'1': 'uploaded_at', '3': 5, '4': 1, '5': 9, '10': 'uploadedAt'},
    {'1': 'verified_at', '3': 6, '4': 1, '5': 9, '10': 'verifiedAt'},
    {'1': 'rejection_reason', '3': 7, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `VerificationDocument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verificationDocumentDescriptor = $convert.base64Decode(
    'ChRWZXJpZmljYXRpb25Eb2N1bWVudBIOCgJpZBgBIAEoCVICaWQSNwoNZG9jdW1lbnRfdHlwZR'
    'gCIAEoDjISLmF1dGguRG9jdW1lbnRUeXBlUgxkb2N1bWVudFR5cGUSIQoMZG9jdW1lbnRfdXJs'
    'GAMgASgJUgtkb2N1bWVudFVybBIsCgZzdGF0dXMYBCABKA4yFC5hdXRoLkRvY3VtZW50U3RhdH'
    'VzUgZzdGF0dXMSHwoLdXBsb2FkZWRfYXQYBSABKAlSCnVwbG9hZGVkQXQSHwoLdmVyaWZpZWRf'
    'YXQYBiABKAlSCnZlcmlmaWVkQXQSKQoQcmVqZWN0aW9uX3JlYXNvbhgHIAEoCVIPcmVqZWN0aW'
    '9uUmVhc29u');

@$core.Deprecated('Use getUserDocumentsResponseDescriptor instead')
const GetUserDocumentsResponse$json = {
  '1': 'GetUserDocumentsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'documents', '3': 2, '4': 3, '5': 11, '6': '.auth.VerificationDocument', '10': 'documents'},
  ],
};

/// Descriptor for `GetUserDocumentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VyRG9jdW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxI4Cg'
    'lkb2N1bWVudHMYAiADKAsyGi5hdXRoLlZlcmlmaWNhdGlvbkRvY3VtZW50Uglkb2N1bWVudHM=');

