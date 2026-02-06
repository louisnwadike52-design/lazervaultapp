//
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use documentTypeDescriptor instead')
const DocumentType$json = {
  '1': 'DocumentType',
  '2': [
    {'1': 'DOCUMENT_TYPE_PASSPORT', '2': 0},
    {'1': 'DOCUMENT_TYPE_DRIVERS_LICENSE', '2': 1},
    {'1': 'DOCUMENT_TYPE_NATIONAL_ID', '2': 2},
    {'1': 'DOCUMENT_TYPE_RESIDENCE_PERMIT', '2': 3},
    {'1': 'DOCUMENT_TYPE_BVN', '2': 4},
    {'1': 'DOCUMENT_TYPE_NIN', '2': 5},
    {'1': 'DOCUMENT_TYPE_NIN_NUMBER', '2': 6},
    {'1': 'DOCUMENT_TYPE_SSN', '2': 7},
    {'1': 'DOCUMENT_TYPE_SSN_LAST4', '2': 8},
    {'1': 'DOCUMENT_TYPE_STATE_ID', '2': 9},
    {'1': 'DOCUMENT_TYPE_ITIN', '2': 10},
    {'1': 'DOCUMENT_TYPE_GHANA_CARD', '2': 11},
    {'1': 'DOCUMENT_TYPE_VOTER_CARD', '2': 12},
    {'1': 'DOCUMENT_TYPE_SSNIT', '2': 13},
    {'1': 'DOCUMENT_TYPE_KRA_PIN', '2': 14},
    {'1': 'DOCUMENT_TYPE_ALIEN_ID', '2': 15},
  ],
};

/// Descriptor for `DocumentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentTypeDescriptor = $convert.base64Decode(
    'CgxEb2N1bWVudFR5cGUSGgoWRE9DVU1FTlRfVFlQRV9QQVNTUE9SVBAAEiEKHURPQ1VNRU5UX1'
    'RZUEVfRFJJVkVSU19MSUNFTlNFEAESHQoZRE9DVU1FTlRfVFlQRV9OQVRJT05BTF9JRBACEiIK'
    'HkRPQ1VNRU5UX1RZUEVfUkVTSURFTkNFX1BFUk1JVBADEhUKEURPQ1VNRU5UX1RZUEVfQlZOEA'
    'QSFQoRRE9DVU1FTlRfVFlQRV9OSU4QBRIcChhET0NVTUVOVF9UWVBFX05JTl9OVU1CRVIQBhIV'
    'ChFET0NVTUVOVF9UWVBFX1NTThAHEhsKF0RPQ1VNRU5UX1RZUEVfU1NOX0xBU1Q0EAgSGgoWRE'
    '9DVU1FTlRfVFlQRV9TVEFURV9JRBAJEhYKEkRPQ1VNRU5UX1RZUEVfSVRJThAKEhwKGERPQ1VN'
    'RU5UX1RZUEVfR0hBTkFfQ0FSRBALEhwKGERPQ1VNRU5UX1RZUEVfVk9URVJfQ0FSRBAMEhcKE0'
    'RPQ1VNRU5UX1RZUEVfU1NOSVQQDRIZChVET0NVTUVOVF9UWVBFX0tSQV9QSU4QDhIaChZET0NV'
    'TUVOVF9UWVBFX0FMSUVOX0lEEA8=');

@$core.Deprecated('Use verificationStatusDescriptor instead')
const VerificationStatus$json = {
  '1': 'VerificationStatus',
  '2': [
    {'1': 'VERIFICATION_STATUS_PENDING', '2': 0},
    {'1': 'VERIFICATION_STATUS_PROCESSING', '2': 1},
    {'1': 'VERIFICATION_STATUS_VERIFIED', '2': 2},
    {'1': 'VERIFICATION_STATUS_REJECTED', '2': 3},
    {'1': 'VERIFICATION_STATUS_EXPIRED', '2': 4},
  ],
};

/// Descriptor for `VerificationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List verificationStatusDescriptor = $convert.base64Decode(
    'ChJWZXJpZmljYXRpb25TdGF0dXMSHwobVkVSSUZJQ0FUSU9OX1NUQVRVU19QRU5ESU5HEAASIg'
    'oeVkVSSUZJQ0FUSU9OX1NUQVRVU19QUk9DRVNTSU5HEAESIAocVkVSSUZJQ0FUSU9OX1NUQVRV'
    'U19WRVJJRklFRBACEiAKHFZFUklGSUNBVElPTl9TVEFUVVNfUkVKRUNURUQQAxIfChtWRVJJRk'
    'lDQVRJT05fU1RBVFVTX0VYUElSRUQQBA==');

@$core.Deprecated('Use permissionTypeDescriptor instead')
const PermissionType$json = {
  '1': 'PermissionType',
  '2': [
    {'1': 'PERMISSION_TYPE_CAMERA', '2': 0},
    {'1': 'PERMISSION_TYPE_LOCATION', '2': 1},
    {'1': 'PERMISSION_TYPE_MICROPHONE', '2': 2},
    {'1': 'PERMISSION_TYPE_STORAGE', '2': 3},
    {'1': 'PERMISSION_TYPE_CONTACTS', '2': 4},
    {'1': 'PERMISSION_TYPE_BIOMETRIC', '2': 5},
  ],
};

/// Descriptor for `PermissionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List permissionTypeDescriptor = $convert.base64Decode(
    'Cg5QZXJtaXNzaW9uVHlwZRIaChZQRVJNSVNTSU9OX1RZUEVfQ0FNRVJBEAASHAoYUEVSTUlTU0'
    'lPTl9UWVBFX0xPQ0FUSU9OEAESHgoaUEVSTUlTU0lPTl9UWVBFX01JQ1JPUEhPTkUQAhIbChdQ'
    'RVJNSVNTSU9OX1RZUEVfU1RPUkFHRRADEhwKGFBFUk1JU1NJT05fVFlQRV9DT05UQUNUUxAEEh'
    '0KGVBFUk1JU1NJT05fVFlQRV9CSU9NRVRSSUMQBQ==');

@$core.Deprecated('Use createUserRequestDescriptor instead')
const CreateUserRequest$json = {
  '1': 'CreateUserRequest',
  '2': [
    {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 4, '4': 1, '5': 9, '10': 'password'},
    {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'role', '3': 6, '4': 1, '5': 9, '10': 'role'},
    {'1': 'login_passcode', '3': 7, '4': 1, '5': 9, '10': 'loginPasscode'},
    {'1': 'username', '3': 8, '4': 1, '5': 9, '10': 'username'},
    {'1': 'referral_code', '3': 9, '4': 1, '5': 9, '10': 'referralCode'},
  ],
};

/// Descriptor for `CreateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVVc2VyUmVxdWVzdBIdCgpmaXJzdF9uYW1lGAEgASgJUglmaXJzdE5hbWUSGwoJbG'
    'FzdF9uYW1lGAIgASgJUghsYXN0TmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWwSGgoIcGFzc3dv'
    'cmQYBCABKAlSCHBhc3N3b3JkEiEKDHBob25lX251bWJlchgFIAEoCVILcGhvbmVOdW1iZXISEg'
    'oEcm9sZRgGIAEoCVIEcm9sZRIlCg5sb2dpbl9wYXNzY29kZRgHIAEoCVINbG9naW5QYXNzY29k'
    'ZRIaCgh1c2VybmFtZRgIIAEoCVIIdXNlcm5hbWUSIwoNcmVmZXJyYWxfY29kZRgJIAEoCVIMcm'
    'VmZXJyYWxDb2Rl');

@$core.Deprecated('Use createUserResponseDescriptor instead')
const CreateUserResponse$json = {
  '1': 'CreateUserResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'data', '3': 3, '4': 1, '5': 11, '6': '.pb.Data', '10': 'data'},
  ],
};

/// Descriptor for `CreateUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserResponseDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVVc2VyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYW'
    'dlGAIgASgJUgdtZXNzYWdlEhwKBGRhdGEYAyABKAsyCC5wYi5EYXRhUgRkYXRh');

@$core.Deprecated('Use getUserProfileRequestDescriptor instead')
const GetUserProfileRequest$json = {
  '1': 'GetUserProfileRequest',
};

/// Descriptor for `GetUserProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserProfileRequestDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyUHJvZmlsZVJlcXVlc3Q=');

@$core.Deprecated('Use getUserProfileResponseDescriptor instead')
const GetUserProfileResponse$json = {
  '1': 'GetUserProfileResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {'1': 'preferences', '3': 4, '4': 1, '5': 11, '6': '.pb.UserPreferences', '10': 'preferences'},
  ],
};

/// Descriptor for `GetUserProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserProfileResponseDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyUHJvZmlsZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIcCgR1c2VyGAMgASgLMggucGIuVXNlclIEdXNlchI1Cgtw'
    'cmVmZXJlbmNlcxgEIAEoCzITLnBiLlVzZXJQcmVmZXJlbmNlc1ILcHJlZmVyZW5jZXM=');

@$core.Deprecated('Use updateUserProfileRequestDescriptor instead')
const UpdateUserProfileRequest$json = {
  '1': 'UpdateUserProfileRequest',
  '2': [
    {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'language', '3': 5, '4': 1, '5': 9, '10': 'language'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'country', '3': 7, '4': 1, '5': 9, '10': 'country'},
    {'1': 'profile_picture', '3': 8, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `UpdateUserProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserProfileRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVVc2VyUHJvZmlsZVJlcXVlc3QSHQoKZmlyc3RfbmFtZRgBIAEoCVIJZmlyc3ROYW'
    '1lEhsKCWxhc3RfbmFtZRgCIAEoCVIIbGFzdE5hbWUSGgoIdXNlcm5hbWUYAyABKAlSCHVzZXJu'
    'YW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGgoIbGFuZ3VhZ2UYBSABKA'
    'lSCGxhbmd1YWdlEhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIYCgdjb3VudHJ5GAcgASgJ'
    'Ugdjb3VudHJ5EicKD3Byb2ZpbGVfcGljdHVyZRgIIAEoCVIOcHJvZmlsZVBpY3R1cmU=');

@$core.Deprecated('Use updateUserProfileResponseDescriptor instead')
const UpdateUserProfileResponse$json = {
  '1': 'UpdateUserProfileResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `UpdateUserProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserProfileResponseDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVVc2VyUHJvZmlsZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIcCgR1c2VyGAMgASgLMggucGIuVXNlclIEdXNlcg==');

@$core.Deprecated('Use updatePasswordRequestDescriptor instead')
const UpdatePasswordRequest$json = {
  '1': 'UpdatePasswordRequest',
  '2': [
    {'1': 'current_password', '3': 1, '4': 1, '5': 9, '10': 'currentPassword'},
    {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `UpdatePasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePasswordRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVQYXNzd29yZFJlcXVlc3QSKQoQY3VycmVudF9wYXNzd29yZBgBIAEoCVIPY3Vycm'
    'VudFBhc3N3b3JkEiEKDG5ld19wYXNzd29yZBgCIAEoCVILbmV3UGFzc3dvcmQ=');

@$core.Deprecated('Use updatePasswordResponseDescriptor instead')
const UpdatePasswordResponse$json = {
  '1': 'UpdatePasswordResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdatePasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePasswordResponseDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVQYXNzd29yZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use updatePreferencesRequestDescriptor instead')
const UpdatePreferencesRequest$json = {
  '1': 'UpdatePreferencesRequest',
  '2': [
    {'1': 'push_notifications', '3': 1, '4': 1, '5': 8, '10': 'pushNotifications'},
    {'1': 'email_notifications', '3': 2, '4': 1, '5': 8, '10': 'emailNotifications'},
    {'1': 'sms_notifications', '3': 3, '4': 1, '5': 8, '10': 'smsNotifications'},
    {'1': 'dark_mode', '3': 4, '4': 1, '5': 8, '10': 'darkMode'},
    {'1': 'language', '3': 5, '4': 1, '5': 9, '10': 'language'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'preferred_countries', '3': 7, '4': 3, '5': 9, '10': 'preferredCountries'},
    {'1': 'active_country', '3': 8, '4': 1, '5': 9, '10': 'activeCountry'},
  ],
};

/// Descriptor for `UpdatePreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePreferencesRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVQcmVmZXJlbmNlc1JlcXVlc3QSLQoScHVzaF9ub3RpZmljYXRpb25zGAEgASgIUh'
    'FwdXNoTm90aWZpY2F0aW9ucxIvChNlbWFpbF9ub3RpZmljYXRpb25zGAIgASgIUhJlbWFpbE5v'
    'dGlmaWNhdGlvbnMSKwoRc21zX25vdGlmaWNhdGlvbnMYAyABKAhSEHNtc05vdGlmaWNhdGlvbn'
    'MSGwoJZGFya19tb2RlGAQgASgIUghkYXJrTW9kZRIaCghsYW5ndWFnZRgFIAEoCVIIbGFuZ3Vh'
    'Z2USGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5Ei8KE3ByZWZlcnJlZF9jb3VudHJpZXMYBy'
    'ADKAlSEnByZWZlcnJlZENvdW50cmllcxIlCg5hY3RpdmVfY291bnRyeRgIIAEoCVINYWN0aXZl'
    'Q291bnRyeQ==');

@$core.Deprecated('Use updatePreferencesResponseDescriptor instead')
const UpdatePreferencesResponse$json = {
  '1': 'UpdatePreferencesResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'preferences', '3': 3, '4': 1, '5': 11, '6': '.pb.UserPreferences', '10': 'preferences'},
  ],
};

/// Descriptor for `UpdatePreferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePreferencesResponseDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVQcmVmZXJlbmNlc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI1CgtwcmVmZXJlbmNlcxgDIAEoCzITLnBiLlVzZXJQ'
    'cmVmZXJlbmNlc1ILcHJlZmVyZW5jZXM=');

@$core.Deprecated('Use userPreferencesDescriptor instead')
const UserPreferences$json = {
  '1': 'UserPreferences',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'push_notifications', '3': 2, '4': 1, '5': 8, '10': 'pushNotifications'},
    {'1': 'email_notifications', '3': 3, '4': 1, '5': 8, '10': 'emailNotifications'},
    {'1': 'sms_notifications', '3': 4, '4': 1, '5': 8, '10': 'smsNotifications'},
    {'1': 'dark_mode', '3': 5, '4': 1, '5': 8, '10': 'darkMode'},
    {'1': 'language', '3': 6, '4': 1, '5': 9, '10': 'language'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'country', '3': 8, '4': 1, '5': 9, '10': 'country'},
    {'1': 'preferred_countries', '3': 9, '4': 3, '5': 9, '10': 'preferredCountries'},
    {'1': 'active_country', '3': 10, '4': 1, '5': 9, '10': 'activeCountry'},
  ],
};

/// Descriptor for `UserPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPreferencesDescriptor = $convert.base64Decode(
    'Cg9Vc2VyUHJlZmVyZW5jZXMSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEi0KEnB1c2hfbm90aW'
    'ZpY2F0aW9ucxgCIAEoCFIRcHVzaE5vdGlmaWNhdGlvbnMSLwoTZW1haWxfbm90aWZpY2F0aW9u'
    'cxgDIAEoCFISZW1haWxOb3RpZmljYXRpb25zEisKEXNtc19ub3RpZmljYXRpb25zGAQgASgIUh'
    'BzbXNOb3RpZmljYXRpb25zEhsKCWRhcmtfbW9kZRgFIAEoCFIIZGFya01vZGUSGgoIbGFuZ3Vh'
    'Z2UYBiABKAlSCGxhbmd1YWdlEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIYCgdjb3VudH'
    'J5GAggASgJUgdjb3VudHJ5Ei8KE3ByZWZlcnJlZF9jb3VudHJpZXMYCSADKAlSEnByZWZlcnJl'
    'ZENvdW50cmllcxIlCg5hY3RpdmVfY291bnRyeRgKIAEoCVINYWN0aXZlQ291bnRyeQ==');

@$core.Deprecated('Use iDDocumentDescriptor instead')
const IDDocument$json = {
  '1': 'IDDocument',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'document_type', '3': 3, '4': 1, '5': 14, '6': '.pb.DocumentType', '10': 'documentType'},
    {'1': 'document_number', '3': 4, '4': 1, '5': 9, '10': 'documentNumber'},
    {'1': 'full_name', '3': 5, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'date_of_birth', '3': 6, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'issue_date', '3': 7, '4': 1, '5': 9, '10': 'issueDate'},
    {'1': 'expiry_date', '3': 8, '4': 1, '5': 9, '10': 'expiryDate'},
    {'1': 'issuing_country', '3': 9, '4': 1, '5': 9, '10': 'issuingCountry'},
    {'1': 'document_front_url', '3': 10, '4': 1, '5': 9, '10': 'documentFrontUrl'},
    {'1': 'document_back_url', '3': 11, '4': 1, '5': 9, '10': 'documentBackUrl'},
    {'1': 'verification_status', '3': 12, '4': 1, '5': 14, '6': '.pb.VerificationStatus', '10': 'verificationStatus'},
    {'1': 'rejection_reason', '3': 13, '4': 1, '5': 9, '10': 'rejectionReason'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'verified_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
  ],
};

/// Descriptor for `IDDocument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iDDocumentDescriptor = $convert.base64Decode(
    'CgpJRERvY3VtZW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSNQ'
    'oNZG9jdW1lbnRfdHlwZRgDIAEoDjIQLnBiLkRvY3VtZW50VHlwZVIMZG9jdW1lbnRUeXBlEicK'
    'D2RvY3VtZW50X251bWJlchgEIAEoCVIOZG9jdW1lbnROdW1iZXISGwoJZnVsbF9uYW1lGAUgAS'
    'gJUghmdWxsTmFtZRIiCg1kYXRlX29mX2JpcnRoGAYgASgJUgtkYXRlT2ZCaXJ0aBIdCgppc3N1'
    'ZV9kYXRlGAcgASgJUglpc3N1ZURhdGUSHwoLZXhwaXJ5X2RhdGUYCCABKAlSCmV4cGlyeURhdG'
    'USJwoPaXNzdWluZ19jb3VudHJ5GAkgASgJUg5pc3N1aW5nQ291bnRyeRIsChJkb2N1bWVudF9m'
    'cm9udF91cmwYCiABKAlSEGRvY3VtZW50RnJvbnRVcmwSKgoRZG9jdW1lbnRfYmFja191cmwYCy'
    'ABKAlSD2RvY3VtZW50QmFja1VybBJHChN2ZXJpZmljYXRpb25fc3RhdHVzGAwgASgOMhYucGIu'
    'VmVyaWZpY2F0aW9uU3RhdHVzUhJ2ZXJpZmljYXRpb25TdGF0dXMSKQoQcmVqZWN0aW9uX3JlYX'
    'NvbhgNIAEoCVIPcmVqZWN0aW9uUmVhc29uEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUu'
    'cHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOwoLdmVyaWZpZWRfYXQYDyABKAsyGi5nb2'
    '9nbGUucHJvdG9idWYuVGltZXN0YW1wUgp2ZXJpZmllZEF0');

@$core.Deprecated('Use uploadIDDocumentRequestDescriptor instead')
const UploadIDDocumentRequest$json = {
  '1': 'UploadIDDocumentRequest',
  '2': [
    {'1': 'document_type', '3': 1, '4': 1, '5': 14, '6': '.pb.DocumentType', '10': 'documentType'},
    {'1': 'front_image', '3': 2, '4': 1, '5': 12, '10': 'frontImage'},
    {'1': 'back_image', '3': 3, '4': 1, '5': 12, '10': 'backImage'},
  ],
};

/// Descriptor for `UploadIDDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadIDDocumentRequestDescriptor = $convert.base64Decode(
    'ChdVcGxvYWRJRERvY3VtZW50UmVxdWVzdBI1Cg1kb2N1bWVudF90eXBlGAEgASgOMhAucGIuRG'
    '9jdW1lbnRUeXBlUgxkb2N1bWVudFR5cGUSHwoLZnJvbnRfaW1hZ2UYAiABKAxSCmZyb250SW1h'
    'Z2USHQoKYmFja19pbWFnZRgDIAEoDFIJYmFja0ltYWdl');

@$core.Deprecated('Use uploadIDDocumentResponseDescriptor instead')
const UploadIDDocumentResponse$json = {
  '1': 'UploadIDDocumentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'document', '3': 3, '4': 1, '5': 11, '6': '.pb.IDDocument', '10': 'document'},
  ],
};

/// Descriptor for `UploadIDDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadIDDocumentResponseDescriptor = $convert.base64Decode(
    'ChhVcGxvYWRJRERvY3VtZW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdlEioKCGRvY3VtZW50GAMgASgLMg4ucGIuSUREb2N1bWVu'
    'dFIIZG9jdW1lbnQ=');

@$core.Deprecated('Use getIDDocumentsRequestDescriptor instead')
const GetIDDocumentsRequest$json = {
  '1': 'GetIDDocumentsRequest',
};

/// Descriptor for `GetIDDocumentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIDDocumentsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRJRERvY3VtZW50c1JlcXVlc3Q=');

@$core.Deprecated('Use getIDDocumentsResponseDescriptor instead')
const GetIDDocumentsResponse$json = {
  '1': 'GetIDDocumentsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'documents', '3': 3, '4': 3, '5': 11, '6': '.pb.IDDocument', '10': 'documents'},
  ],
};

/// Descriptor for `GetIDDocumentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIDDocumentsResponseDescriptor = $convert.base64Decode(
    'ChZHZXRJRERvY3VtZW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIsCglkb2N1bWVudHMYAyADKAsyDi5wYi5JRERvY3VtZW50'
    'Uglkb2N1bWVudHM=');

@$core.Deprecated('Use verifyIDDocumentRequestDescriptor instead')
const VerifyIDDocumentRequest$json = {
  '1': 'VerifyIDDocumentRequest',
  '2': [
    {'1': 'document_id', '3': 1, '4': 1, '5': 9, '10': 'documentId'},
  ],
};

/// Descriptor for `VerifyIDDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIDDocumentRequestDescriptor = $convert.base64Decode(
    'ChdWZXJpZnlJRERvY3VtZW50UmVxdWVzdBIfCgtkb2N1bWVudF9pZBgBIAEoCVIKZG9jdW1lbn'
    'RJZA==');

@$core.Deprecated('Use verifyIDDocumentResponseDescriptor instead')
const VerifyIDDocumentResponse$json = {
  '1': 'VerifyIDDocumentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'document', '3': 3, '4': 1, '5': 11, '6': '.pb.IDDocument', '10': 'document'},
  ],
};

/// Descriptor for `VerifyIDDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIDDocumentResponseDescriptor = $convert.base64Decode(
    'ChhWZXJpZnlJRERvY3VtZW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdlEioKCGRvY3VtZW50GAMgASgLMg4ucGIuSUREb2N1bWVu'
    'dFIIZG9jdW1lbnQ=');

@$core.Deprecated('Use facialDataDescriptor instead')
const FacialData$json = {
  '1': 'FacialData',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    {'1': 'face_id', '3': 3, '4': 1, '5': 9, '10': 'faceId'},
    {'1': 'face_encoding', '3': 4, '4': 1, '5': 9, '10': 'faceEncoding'},
    {'1': 'image_url', '3': 5, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'is_verified', '3': 6, '4': 1, '5': 8, '10': 'isVerified'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'last_verified_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastVerifiedAt'},
  ],
};

/// Descriptor for `FacialData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialDataDescriptor = $convert.base64Decode(
    'CgpGYWNpYWxEYXRhEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSFw'
    'oHZmFjZV9pZBgDIAEoCVIGZmFjZUlkEiMKDWZhY2VfZW5jb2RpbmcYBCABKAlSDGZhY2VFbmNv'
    'ZGluZxIbCglpbWFnZV91cmwYBSABKAlSCGltYWdlVXJsEh8KC2lzX3ZlcmlmaWVkGAYgASgIUg'
    'ppc1ZlcmlmaWVkEjkKCmNyZWF0ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0'
    'YW1wUgljcmVhdGVkQXQSRAoQbGFzdF92ZXJpZmllZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2'
    'J1Zi5UaW1lc3RhbXBSDmxhc3RWZXJpZmllZEF0');

@$core.Deprecated('Use userRegisterFaceRequestDescriptor instead')
const UserRegisterFaceRequest$json = {
  '1': 'UserRegisterFaceRequest',
  '2': [
    {'1': 'face_image', '3': 1, '4': 1, '5': 12, '10': 'faceImage'},
  ],
};

/// Descriptor for `UserRegisterFaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRegisterFaceRequestDescriptor = $convert.base64Decode(
    'ChdVc2VyUmVnaXN0ZXJGYWNlUmVxdWVzdBIdCgpmYWNlX2ltYWdlGAEgASgMUglmYWNlSW1hZ2'
    'U=');

@$core.Deprecated('Use userRegisterFaceResponseDescriptor instead')
const UserRegisterFaceResponse$json = {
  '1': 'UserRegisterFaceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'facial_data', '3': 3, '4': 1, '5': 11, '6': '.pb.FacialData', '10': 'facialData'},
  ],
};

/// Descriptor for `UserRegisterFaceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRegisterFaceResponseDescriptor = $convert.base64Decode(
    'ChhVc2VyUmVnaXN0ZXJGYWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdlEi8KC2ZhY2lhbF9kYXRhGAMgASgLMg4ucGIuRmFjaWFs'
    'RGF0YVIKZmFjaWFsRGF0YQ==');

@$core.Deprecated('Use userVerifyFaceRequestDescriptor instead')
const UserVerifyFaceRequest$json = {
  '1': 'UserVerifyFaceRequest',
  '2': [
    {'1': 'face_image', '3': 1, '4': 1, '5': 12, '10': 'faceImage'},
  ],
};

/// Descriptor for `UserVerifyFaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userVerifyFaceRequestDescriptor = $convert.base64Decode(
    'ChVVc2VyVmVyaWZ5RmFjZVJlcXVlc3QSHQoKZmFjZV9pbWFnZRgBIAEoDFIJZmFjZUltYWdl');

@$core.Deprecated('Use userVerifyFaceResponseDescriptor instead')
const UserVerifyFaceResponse$json = {
  '1': 'UserVerifyFaceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_match', '3': 3, '4': 1, '5': 8, '10': 'isMatch'},
    {'1': 'confidence', '3': 4, '4': 1, '5': 2, '10': 'confidence'},
  ],
};

/// Descriptor for `UserVerifyFaceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userVerifyFaceResponseDescriptor = $convert.base64Decode(
    'ChZVc2VyVmVyaWZ5RmFjZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIZCghpc19tYXRjaBgDIAEoCFIHaXNNYXRjaBIeCgpjb25m'
    'aWRlbmNlGAQgASgCUgpjb25maWRlbmNl');

@$core.Deprecated('Use getFacialDataRequestDescriptor instead')
const GetFacialDataRequest$json = {
  '1': 'GetFacialDataRequest',
};

/// Descriptor for `GetFacialDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFacialDataRequestDescriptor = $convert.base64Decode(
    'ChRHZXRGYWNpYWxEYXRhUmVxdWVzdA==');

@$core.Deprecated('Use getFacialDataResponseDescriptor instead')
const GetFacialDataResponse$json = {
  '1': 'GetFacialDataResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'facial_data', '3': 3, '4': 1, '5': 11, '6': '.pb.FacialData', '10': 'facialData'},
  ],
};

/// Descriptor for `GetFacialDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFacialDataResponseDescriptor = $convert.base64Decode(
    'ChVHZXRGYWNpYWxEYXRhUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdlEi8KC2ZhY2lhbF9kYXRhGAMgASgLMg4ucGIuRmFjaWFsRGF0'
    'YVIKZmFjaWFsRGF0YQ==');

@$core.Deprecated('Use setPasscodeRequestDescriptor instead')
const SetPasscodeRequest$json = {
  '1': 'SetPasscodeRequest',
  '2': [
    {'1': 'passcode', '3': 1, '4': 1, '5': 9, '10': 'passcode'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `SetPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasscodeRequestDescriptor = $convert.base64Decode(
    'ChJTZXRQYXNzY29kZVJlcXVlc3QSGgoIcGFzc2NvZGUYASABKAlSCHBhc3Njb2RlEhoKCHBhc3'
    'N3b3JkGAIgASgJUghwYXNzd29yZA==');

@$core.Deprecated('Use setPasscodeResponseDescriptor instead')
const SetPasscodeResponse$json = {
  '1': 'SetPasscodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SetPasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasscodeResponseDescriptor = $convert.base64Decode(
    'ChNTZXRQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2'
    'FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use verifyPasscodeRequestDescriptor instead')
const VerifyPasscodeRequest$json = {
  '1': 'VerifyPasscodeRequest',
  '2': [
    {'1': 'passcode', '3': 1, '4': 1, '5': 9, '10': 'passcode'},
  ],
};

/// Descriptor for `VerifyPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasscodeRequestDescriptor = $convert.base64Decode(
    'ChVWZXJpZnlQYXNzY29kZVJlcXVlc3QSGgoIcGFzc2NvZGUYASABKAlSCHBhc3Njb2Rl');

@$core.Deprecated('Use verifyPasscodeResponseDescriptor instead')
const VerifyPasscodeResponse$json = {
  '1': 'VerifyPasscodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_valid', '3': 3, '4': 1, '5': 8, '10': 'isValid'},
  ],
};

/// Descriptor for `VerifyPasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasscodeResponseDescriptor = $convert.base64Decode(
    'ChZWZXJpZnlQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIZCghpc192YWxpZBgDIAEoCFIHaXNWYWxpZA==');

@$core.Deprecated('Use removePasscodeRequestDescriptor instead')
const RemovePasscodeRequest$json = {
  '1': 'RemovePasscodeRequest',
  '2': [
    {'1': 'password', '3': 1, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `RemovePasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removePasscodeRequestDescriptor = $convert.base64Decode(
    'ChVSZW1vdmVQYXNzY29kZVJlcXVlc3QSGgoIcGFzc3dvcmQYASABKAlSCHBhc3N3b3Jk');

@$core.Deprecated('Use removePasscodeResponseDescriptor instead')
const RemovePasscodeResponse$json = {
  '1': 'RemovePasscodeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemovePasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removePasscodeResponseDescriptor = $convert.base64Decode(
    'ChZSZW1vdmVQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use checkPasscodeExistsRequestDescriptor instead')
const CheckPasscodeExistsRequest$json = {
  '1': 'CheckPasscodeExistsRequest',
};

/// Descriptor for `CheckPasscodeExistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkPasscodeExistsRequestDescriptor = $convert.base64Decode(
    'ChpDaGVja1Bhc3Njb2RlRXhpc3RzUmVxdWVzdA==');

@$core.Deprecated('Use checkPasscodeExistsResponseDescriptor instead')
const CheckPasscodeExistsResponse$json = {
  '1': 'CheckPasscodeExistsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'has_passcode', '3': 2, '4': 1, '5': 8, '10': 'hasPasscode'},
  ],
};

/// Descriptor for `CheckPasscodeExistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkPasscodeExistsResponseDescriptor = $convert.base64Decode(
    'ChtDaGVja1Bhc3Njb2RlRXhpc3RzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IhCgxoYXNfcGFzc2NvZGUYAiABKAhSC2hhc1Bhc3Njb2Rl');

@$core.Deprecated('Use devicePermissionDescriptor instead')
const DevicePermission$json = {
  '1': 'DevicePermission',
  '2': [
    {'1': 'permission_type', '3': 1, '4': 1, '5': 14, '6': '.pb.PermissionType', '10': 'permissionType'},
    {'1': 'is_granted', '3': 2, '4': 1, '5': 8, '10': 'isGranted'},
    {'1': 'granted_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'grantedAt'},
  ],
};

/// Descriptor for `DevicePermission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List devicePermissionDescriptor = $convert.base64Decode(
    'ChBEZXZpY2VQZXJtaXNzaW9uEjsKD3Blcm1pc3Npb25fdHlwZRgBIAEoDjISLnBiLlBlcm1pc3'
    'Npb25UeXBlUg5wZXJtaXNzaW9uVHlwZRIdCgppc19ncmFudGVkGAIgASgIUglpc0dyYW50ZWQS'
    'OQoKZ3JhbnRlZF9hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWdyYW50ZW'
    'RBdA==');

@$core.Deprecated('Use updateDevicePermissionsRequestDescriptor instead')
const UpdateDevicePermissionsRequest$json = {
  '1': 'UpdateDevicePermissionsRequest',
  '2': [
    {'1': 'permissions', '3': 1, '4': 3, '5': 11, '6': '.pb.DevicePermission', '10': 'permissions'},
  ],
};

/// Descriptor for `UpdateDevicePermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDevicePermissionsRequestDescriptor = $convert.base64Decode(
    'Ch5VcGRhdGVEZXZpY2VQZXJtaXNzaW9uc1JlcXVlc3QSNgoLcGVybWlzc2lvbnMYASADKAsyFC'
    '5wYi5EZXZpY2VQZXJtaXNzaW9uUgtwZXJtaXNzaW9ucw==');

@$core.Deprecated('Use updateDevicePermissionsResponseDescriptor instead')
const UpdateDevicePermissionsResponse$json = {
  '1': 'UpdateDevicePermissionsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateDevicePermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDevicePermissionsResponseDescriptor = $convert.base64Decode(
    'Ch9VcGRhdGVEZXZpY2VQZXJtaXNzaW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getDevicePermissionsRequestDescriptor instead')
const GetDevicePermissionsRequest$json = {
  '1': 'GetDevicePermissionsRequest',
};

/// Descriptor for `GetDevicePermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDevicePermissionsRequestDescriptor = $convert.base64Decode(
    'ChtHZXREZXZpY2VQZXJtaXNzaW9uc1JlcXVlc3Q=');

@$core.Deprecated('Use getDevicePermissionsResponseDescriptor instead')
const GetDevicePermissionsResponse$json = {
  '1': 'GetDevicePermissionsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'permissions', '3': 3, '4': 3, '5': 11, '6': '.pb.DevicePermission', '10': 'permissions'},
  ],
};

/// Descriptor for `GetDevicePermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDevicePermissionsResponseDescriptor = $convert.base64Decode(
    'ChxHZXREZXZpY2VQZXJtaXNzaW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI2CgtwZXJtaXNzaW9ucxgDIAMoCzIULnBiLkRl'
    'dmljZVBlcm1pc3Npb25SC3Blcm1pc3Npb25z');

