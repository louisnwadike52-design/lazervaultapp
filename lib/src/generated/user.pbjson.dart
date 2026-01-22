///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
import 'common.pbjson.dart' as $0;
import 'google/protobuf/timestamp.pbjson.dart' as $1;

@$core.Deprecated('Use documentTypeDescriptor instead')
const DocumentType$json = const {
  '1': 'DocumentType',
  '2': const [
    const {'1': 'DOCUMENT_TYPE_PASSPORT', '2': 0},
    const {'1': 'DOCUMENT_TYPE_DRIVERS_LICENSE', '2': 1},
    const {'1': 'DOCUMENT_TYPE_NATIONAL_ID', '2': 2},
    const {'1': 'DOCUMENT_TYPE_RESIDENCE_PERMIT', '2': 3},
    const {'1': 'DOCUMENT_TYPE_BVN', '2': 4},
    const {'1': 'DOCUMENT_TYPE_NIN', '2': 5},
    const {'1': 'DOCUMENT_TYPE_NIN_NUMBER', '2': 6},
    const {'1': 'DOCUMENT_TYPE_SSN', '2': 7},
    const {'1': 'DOCUMENT_TYPE_SSN_LAST4', '2': 8},
    const {'1': 'DOCUMENT_TYPE_STATE_ID', '2': 9},
    const {'1': 'DOCUMENT_TYPE_ITIN', '2': 10},
    const {'1': 'DOCUMENT_TYPE_GHANA_CARD', '2': 11},
    const {'1': 'DOCUMENT_TYPE_VOTER_CARD', '2': 12},
    const {'1': 'DOCUMENT_TYPE_SSNIT', '2': 13},
    const {'1': 'DOCUMENT_TYPE_KRA_PIN', '2': 14},
    const {'1': 'DOCUMENT_TYPE_ALIEN_ID', '2': 15},
  ],
};

/// Descriptor for `DocumentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentTypeDescriptor = $convert.base64Decode('CgxEb2N1bWVudFR5cGUSGgoWRE9DVU1FTlRfVFlQRV9QQVNTUE9SVBAAEiEKHURPQ1VNRU5UX1RZUEVfRFJJVkVSU19MSUNFTlNFEAESHQoZRE9DVU1FTlRfVFlQRV9OQVRJT05BTF9JRBACEiIKHkRPQ1VNRU5UX1RZUEVfUkVTSURFTkNFX1BFUk1JVBADEhUKEURPQ1VNRU5UX1RZUEVfQlZOEAQSFQoRRE9DVU1FTlRfVFlQRV9OSU4QBRIcChhET0NVTUVOVF9UWVBFX05JTl9OVU1CRVIQBhIVChFET0NVTUVOVF9UWVBFX1NTThAHEhsKF0RPQ1VNRU5UX1RZUEVfU1NOX0xBU1Q0EAgSGgoWRE9DVU1FTlRfVFlQRV9TVEFURV9JRBAJEhYKEkRPQ1VNRU5UX1RZUEVfSVRJThAKEhwKGERPQ1VNRU5UX1RZUEVfR0hBTkFfQ0FSRBALEhwKGERPQ1VNRU5UX1RZUEVfVk9URVJfQ0FSRBAMEhcKE0RPQ1VNRU5UX1RZUEVfU1NOSVQQDRIZChVET0NVTUVOVF9UWVBFX0tSQV9QSU4QDhIaChZET0NVTUVOVF9UWVBFX0FMSUVOX0lEEA8=');
@$core.Deprecated('Use verificationStatusDescriptor instead')
const VerificationStatus$json = const {
  '1': 'VerificationStatus',
  '2': const [
    const {'1': 'VERIFICATION_STATUS_PENDING', '2': 0},
    const {'1': 'VERIFICATION_STATUS_PROCESSING', '2': 1},
    const {'1': 'VERIFICATION_STATUS_VERIFIED', '2': 2},
    const {'1': 'VERIFICATION_STATUS_REJECTED', '2': 3},
    const {'1': 'VERIFICATION_STATUS_EXPIRED', '2': 4},
  ],
};

/// Descriptor for `VerificationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List verificationStatusDescriptor = $convert.base64Decode('ChJWZXJpZmljYXRpb25TdGF0dXMSHwobVkVSSUZJQ0FUSU9OX1NUQVRVU19QRU5ESU5HEAASIgoeVkVSSUZJQ0FUSU9OX1NUQVRVU19QUk9DRVNTSU5HEAESIAocVkVSSUZJQ0FUSU9OX1NUQVRVU19WRVJJRklFRBACEiAKHFZFUklGSUNBVElPTl9TVEFUVVNfUkVKRUNURUQQAxIfChtWRVJJRklDQVRJT05fU1RBVFVTX0VYUElSRUQQBA==');
@$core.Deprecated('Use permissionTypeDescriptor instead')
const PermissionType$json = const {
  '1': 'PermissionType',
  '2': const [
    const {'1': 'PERMISSION_TYPE_CAMERA', '2': 0},
    const {'1': 'PERMISSION_TYPE_LOCATION', '2': 1},
    const {'1': 'PERMISSION_TYPE_MICROPHONE', '2': 2},
    const {'1': 'PERMISSION_TYPE_STORAGE', '2': 3},
    const {'1': 'PERMISSION_TYPE_CONTACTS', '2': 4},
    const {'1': 'PERMISSION_TYPE_BIOMETRIC', '2': 5},
  ],
};

/// Descriptor for `PermissionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List permissionTypeDescriptor = $convert.base64Decode('Cg5QZXJtaXNzaW9uVHlwZRIaChZQRVJNSVNTSU9OX1RZUEVfQ0FNRVJBEAASHAoYUEVSTUlTU0lPTl9UWVBFX0xPQ0FUSU9OEAESHgoaUEVSTUlTU0lPTl9UWVBFX01JQ1JPUEhPTkUQAhIbChdQRVJNSVNTSU9OX1RZUEVfU1RPUkFHRRADEhwKGFBFUk1JU1NJT05fVFlQRV9DT05UQUNUUxAEEh0KGVBFUk1JU1NJT05fVFlQRV9CSU9NRVRSSUMQBQ==');
@$core.Deprecated('Use createUserRequestDescriptor instead')
const CreateUserRequest$json = const {
  '1': 'CreateUserRequest',
  '2': const [
    const {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 4, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'role', '3': 6, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'login_passcode', '3': 7, '4': 1, '5': 9, '10': 'loginPasscode'},
    const {'1': 'username', '3': 8, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'referral_code', '3': 9, '4': 1, '5': 9, '10': 'referralCode'},
  ],
};

/// Descriptor for `CreateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserRequestDescriptor = $convert.base64Decode('ChFDcmVhdGVVc2VyUmVxdWVzdBIdCgpmaXJzdF9uYW1lGAEgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAIgASgJUghsYXN0TmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWwSGgoIcGFzc3dvcmQYBCABKAlSCHBhc3N3b3JkEiEKDHBob25lX251bWJlchgFIAEoCVILcGhvbmVOdW1iZXISEgoEcm9sZRgGIAEoCVIEcm9sZRIlCg5sb2dpbl9wYXNzY29kZRgHIAEoCVINbG9naW5QYXNzY29kZRIaCgh1c2VybmFtZRgIIAEoCVIIdXNlcm5hbWUSIwoNcmVmZXJyYWxfY29kZRgJIAEoCVIMcmVmZXJyYWxDb2Rl');
@$core.Deprecated('Use createUserResponseDescriptor instead')
const CreateUserResponse$json = const {
  '1': 'CreateUserResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'data', '3': 3, '4': 1, '5': 11, '6': '.pb.Data', '10': 'data'},
  ],
};

/// Descriptor for `CreateUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserResponseDescriptor = $convert.base64Decode('ChJDcmVhdGVVc2VyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEhwKBGRhdGEYAyABKAsyCC5wYi5EYXRhUgRkYXRh');
@$core.Deprecated('Use getUserProfileRequestDescriptor instead')
const GetUserProfileRequest$json = const {
  '1': 'GetUserProfileRequest',
};

/// Descriptor for `GetUserProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserProfileRequestDescriptor = $convert.base64Decode('ChVHZXRVc2VyUHJvZmlsZVJlcXVlc3Q=');
@$core.Deprecated('Use getUserProfileResponseDescriptor instead')
const GetUserProfileResponse$json = const {
  '1': 'GetUserProfileResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    const {'1': 'preferences', '3': 4, '4': 1, '5': 11, '6': '.pb.UserPreferences', '10': 'preferences'},
  ],
};

/// Descriptor for `GetUserProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserProfileResponseDescriptor = $convert.base64Decode('ChZHZXRVc2VyUHJvZmlsZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIcCgR1c2VyGAMgASgLMggucGIuVXNlclIEdXNlchI1CgtwcmVmZXJlbmNlcxgEIAEoCzITLnBiLlVzZXJQcmVmZXJlbmNlc1ILcHJlZmVyZW5jZXM=');
@$core.Deprecated('Use updateUserProfileRequestDescriptor instead')
const UpdateUserProfileRequest$json = const {
  '1': 'UpdateUserProfileRequest',
  '2': const [
    const {'1': 'first_name', '3': 1, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 2, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'language', '3': 5, '4': 1, '5': 9, '10': 'language'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'country', '3': 7, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'profile_picture', '3': 8, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `UpdateUserProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserProfileRequestDescriptor = $convert.base64Decode('ChhVcGRhdGVVc2VyUHJvZmlsZVJlcXVlc3QSHQoKZmlyc3RfbmFtZRgBIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgCIAEoCVIIbGFzdE5hbWUSGgoIdXNlcm5hbWUYAyABKAlSCHVzZXJuYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGgoIbGFuZ3VhZ2UYBSABKAlSCGxhbmd1YWdlEhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIYCgdjb3VudHJ5GAcgASgJUgdjb3VudHJ5EicKD3Byb2ZpbGVfcGljdHVyZRgIIAEoCVIOcHJvZmlsZVBpY3R1cmU=');
@$core.Deprecated('Use updateUserProfileResponseDescriptor instead')
const UpdateUserProfileResponse$json = const {
  '1': 'UpdateUserProfileResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `UpdateUserProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserProfileResponseDescriptor = $convert.base64Decode('ChlVcGRhdGVVc2VyUHJvZmlsZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIcCgR1c2VyGAMgASgLMggucGIuVXNlclIEdXNlcg==');
@$core.Deprecated('Use updatePasswordRequestDescriptor instead')
const UpdatePasswordRequest$json = const {
  '1': 'UpdatePasswordRequest',
  '2': const [
    const {'1': 'current_password', '3': 1, '4': 1, '5': 9, '10': 'currentPassword'},
    const {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `UpdatePasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePasswordRequestDescriptor = $convert.base64Decode('ChVVcGRhdGVQYXNzd29yZFJlcXVlc3QSKQoQY3VycmVudF9wYXNzd29yZBgBIAEoCVIPY3VycmVudFBhc3N3b3JkEiEKDG5ld19wYXNzd29yZBgCIAEoCVILbmV3UGFzc3dvcmQ=');
@$core.Deprecated('Use updatePasswordResponseDescriptor instead')
const UpdatePasswordResponse$json = const {
  '1': 'UpdatePasswordResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdatePasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePasswordResponseDescriptor = $convert.base64Decode('ChZVcGRhdGVQYXNzd29yZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use updatePreferencesRequestDescriptor instead')
const UpdatePreferencesRequest$json = const {
  '1': 'UpdatePreferencesRequest',
  '2': const [
    const {'1': 'push_notifications', '3': 1, '4': 1, '5': 8, '10': 'pushNotifications'},
    const {'1': 'email_notifications', '3': 2, '4': 1, '5': 8, '10': 'emailNotifications'},
    const {'1': 'sms_notifications', '3': 3, '4': 1, '5': 8, '10': 'smsNotifications'},
    const {'1': 'dark_mode', '3': 4, '4': 1, '5': 8, '10': 'darkMode'},
    const {'1': 'language', '3': 5, '4': 1, '5': 9, '10': 'language'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'preferred_countries', '3': 7, '4': 3, '5': 9, '10': 'preferredCountries'},
    const {'1': 'active_country', '3': 8, '4': 1, '5': 9, '10': 'activeCountry'},
  ],
};

/// Descriptor for `UpdatePreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePreferencesRequestDescriptor = $convert.base64Decode('ChhVcGRhdGVQcmVmZXJlbmNlc1JlcXVlc3QSLQoScHVzaF9ub3RpZmljYXRpb25zGAEgASgIUhFwdXNoTm90aWZpY2F0aW9ucxIvChNlbWFpbF9ub3RpZmljYXRpb25zGAIgASgIUhJlbWFpbE5vdGlmaWNhdGlvbnMSKwoRc21zX25vdGlmaWNhdGlvbnMYAyABKAhSEHNtc05vdGlmaWNhdGlvbnMSGwoJZGFya19tb2RlGAQgASgIUghkYXJrTW9kZRIaCghsYW5ndWFnZRgFIAEoCVIIbGFuZ3VhZ2USGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5Ei8KE3ByZWZlcnJlZF9jb3VudHJpZXMYByADKAlSEnByZWZlcnJlZENvdW50cmllcxIlCg5hY3RpdmVfY291bnRyeRgIIAEoCVINYWN0aXZlQ291bnRyeQ==');
@$core.Deprecated('Use updatePreferencesResponseDescriptor instead')
const UpdatePreferencesResponse$json = const {
  '1': 'UpdatePreferencesResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'preferences', '3': 3, '4': 1, '5': 11, '6': '.pb.UserPreferences', '10': 'preferences'},
  ],
};

/// Descriptor for `UpdatePreferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePreferencesResponseDescriptor = $convert.base64Decode('ChlVcGRhdGVQcmVmZXJlbmNlc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI1CgtwcmVmZXJlbmNlcxgDIAEoCzITLnBiLlVzZXJQcmVmZXJlbmNlc1ILcHJlZmVyZW5jZXM=');
@$core.Deprecated('Use userPreferencesDescriptor instead')
const UserPreferences$json = const {
  '1': 'UserPreferences',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'push_notifications', '3': 2, '4': 1, '5': 8, '10': 'pushNotifications'},
    const {'1': 'email_notifications', '3': 3, '4': 1, '5': 8, '10': 'emailNotifications'},
    const {'1': 'sms_notifications', '3': 4, '4': 1, '5': 8, '10': 'smsNotifications'},
    const {'1': 'dark_mode', '3': 5, '4': 1, '5': 8, '10': 'darkMode'},
    const {'1': 'language', '3': 6, '4': 1, '5': 9, '10': 'language'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'country', '3': 8, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'preferred_countries', '3': 9, '4': 3, '5': 9, '10': 'preferredCountries'},
    const {'1': 'active_country', '3': 10, '4': 1, '5': 9, '10': 'activeCountry'},
  ],
};

/// Descriptor for `UserPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPreferencesDescriptor = $convert.base64Decode('Cg9Vc2VyUHJlZmVyZW5jZXMSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEi0KEnB1c2hfbm90aWZpY2F0aW9ucxgCIAEoCFIRcHVzaE5vdGlmaWNhdGlvbnMSLwoTZW1haWxfbm90aWZpY2F0aW9ucxgDIAEoCFISZW1haWxOb3RpZmljYXRpb25zEisKEXNtc19ub3RpZmljYXRpb25zGAQgASgIUhBzbXNOb3RpZmljYXRpb25zEhsKCWRhcmtfbW9kZRgFIAEoCFIIZGFya01vZGUSGgoIbGFuZ3VhZ2UYBiABKAlSCGxhbmd1YWdlEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIYCgdjb3VudHJ5GAggASgJUgdjb3VudHJ5Ei8KE3ByZWZlcnJlZF9jb3VudHJpZXMYCSADKAlSEnByZWZlcnJlZENvdW50cmllcxIlCg5hY3RpdmVfY291bnRyeRgKIAEoCVINYWN0aXZlQ291bnRyeQ==');
@$core.Deprecated('Use iDDocumentDescriptor instead')
const IDDocument$json = const {
  '1': 'IDDocument',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'document_type', '3': 3, '4': 1, '5': 14, '6': '.pb.DocumentType', '10': 'documentType'},
    const {'1': 'document_number', '3': 4, '4': 1, '5': 9, '10': 'documentNumber'},
    const {'1': 'full_name', '3': 5, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'date_of_birth', '3': 6, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'issue_date', '3': 7, '4': 1, '5': 9, '10': 'issueDate'},
    const {'1': 'expiry_date', '3': 8, '4': 1, '5': 9, '10': 'expiryDate'},
    const {'1': 'issuing_country', '3': 9, '4': 1, '5': 9, '10': 'issuingCountry'},
    const {'1': 'document_front_url', '3': 10, '4': 1, '5': 9, '10': 'documentFrontUrl'},
    const {'1': 'document_back_url', '3': 11, '4': 1, '5': 9, '10': 'documentBackUrl'},
    const {'1': 'verification_status', '3': 12, '4': 1, '5': 14, '6': '.pb.VerificationStatus', '10': 'verificationStatus'},
    const {'1': 'rejection_reason', '3': 13, '4': 1, '5': 9, '10': 'rejectionReason'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'verified_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
  ],
};

/// Descriptor for `IDDocument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iDDocumentDescriptor = $convert.base64Decode('CgpJRERvY3VtZW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSNQoNZG9jdW1lbnRfdHlwZRgDIAEoDjIQLnBiLkRvY3VtZW50VHlwZVIMZG9jdW1lbnRUeXBlEicKD2RvY3VtZW50X251bWJlchgEIAEoCVIOZG9jdW1lbnROdW1iZXISGwoJZnVsbF9uYW1lGAUgASgJUghmdWxsTmFtZRIiCg1kYXRlX29mX2JpcnRoGAYgASgJUgtkYXRlT2ZCaXJ0aBIdCgppc3N1ZV9kYXRlGAcgASgJUglpc3N1ZURhdGUSHwoLZXhwaXJ5X2RhdGUYCCABKAlSCmV4cGlyeURhdGUSJwoPaXNzdWluZ19jb3VudHJ5GAkgASgJUg5pc3N1aW5nQ291bnRyeRIsChJkb2N1bWVudF9mcm9udF91cmwYCiABKAlSEGRvY3VtZW50RnJvbnRVcmwSKgoRZG9jdW1lbnRfYmFja191cmwYCyABKAlSD2RvY3VtZW50QmFja1VybBJHChN2ZXJpZmljYXRpb25fc3RhdHVzGAwgASgOMhYucGIuVmVyaWZpY2F0aW9uU3RhdHVzUhJ2ZXJpZmljYXRpb25TdGF0dXMSKQoQcmVqZWN0aW9uX3JlYXNvbhgNIAEoCVIPcmVqZWN0aW9uUmVhc29uEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOwoLdmVyaWZpZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgp2ZXJpZmllZEF0');
@$core.Deprecated('Use uploadIDDocumentRequestDescriptor instead')
const UploadIDDocumentRequest$json = const {
  '1': 'UploadIDDocumentRequest',
  '2': const [
    const {'1': 'document_type', '3': 1, '4': 1, '5': 14, '6': '.pb.DocumentType', '10': 'documentType'},
    const {'1': 'front_image', '3': 2, '4': 1, '5': 12, '10': 'frontImage'},
    const {'1': 'back_image', '3': 3, '4': 1, '5': 12, '10': 'backImage'},
  ],
};

/// Descriptor for `UploadIDDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadIDDocumentRequestDescriptor = $convert.base64Decode('ChdVcGxvYWRJRERvY3VtZW50UmVxdWVzdBI1Cg1kb2N1bWVudF90eXBlGAEgASgOMhAucGIuRG9jdW1lbnRUeXBlUgxkb2N1bWVudFR5cGUSHwoLZnJvbnRfaW1hZ2UYAiABKAxSCmZyb250SW1hZ2USHQoKYmFja19pbWFnZRgDIAEoDFIJYmFja0ltYWdl');
@$core.Deprecated('Use uploadIDDocumentResponseDescriptor instead')
const UploadIDDocumentResponse$json = const {
  '1': 'UploadIDDocumentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'document', '3': 3, '4': 1, '5': 11, '6': '.pb.IDDocument', '10': 'document'},
  ],
};

/// Descriptor for `UploadIDDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadIDDocumentResponseDescriptor = $convert.base64Decode('ChhVcGxvYWRJRERvY3VtZW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEioKCGRvY3VtZW50GAMgASgLMg4ucGIuSUREb2N1bWVudFIIZG9jdW1lbnQ=');
@$core.Deprecated('Use getIDDocumentsRequestDescriptor instead')
const GetIDDocumentsRequest$json = const {
  '1': 'GetIDDocumentsRequest',
};

/// Descriptor for `GetIDDocumentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIDDocumentsRequestDescriptor = $convert.base64Decode('ChVHZXRJRERvY3VtZW50c1JlcXVlc3Q=');
@$core.Deprecated('Use getIDDocumentsResponseDescriptor instead')
const GetIDDocumentsResponse$json = const {
  '1': 'GetIDDocumentsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'documents', '3': 3, '4': 3, '5': 11, '6': '.pb.IDDocument', '10': 'documents'},
  ],
};

/// Descriptor for `GetIDDocumentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIDDocumentsResponseDescriptor = $convert.base64Decode('ChZHZXRJRERvY3VtZW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIsCglkb2N1bWVudHMYAyADKAsyDi5wYi5JRERvY3VtZW50Uglkb2N1bWVudHM=');
@$core.Deprecated('Use verifyIDDocumentRequestDescriptor instead')
const VerifyIDDocumentRequest$json = const {
  '1': 'VerifyIDDocumentRequest',
  '2': const [
    const {'1': 'document_id', '3': 1, '4': 1, '5': 9, '10': 'documentId'},
  ],
};

/// Descriptor for `VerifyIDDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIDDocumentRequestDescriptor = $convert.base64Decode('ChdWZXJpZnlJRERvY3VtZW50UmVxdWVzdBIfCgtkb2N1bWVudF9pZBgBIAEoCVIKZG9jdW1lbnRJZA==');
@$core.Deprecated('Use verifyIDDocumentResponseDescriptor instead')
const VerifyIDDocumentResponse$json = const {
  '1': 'VerifyIDDocumentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'document', '3': 3, '4': 1, '5': 11, '6': '.pb.IDDocument', '10': 'document'},
  ],
};

/// Descriptor for `VerifyIDDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIDDocumentResponseDescriptor = $convert.base64Decode('ChhWZXJpZnlJRERvY3VtZW50UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEioKCGRvY3VtZW50GAMgASgLMg4ucGIuSUREb2N1bWVudFIIZG9jdW1lbnQ=');
@$core.Deprecated('Use facialDataDescriptor instead')
const FacialData$json = const {
  '1': 'FacialData',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'face_id', '3': 3, '4': 1, '5': 9, '10': 'faceId'},
    const {'1': 'face_encoding', '3': 4, '4': 1, '5': 9, '10': 'faceEncoding'},
    const {'1': 'image_url', '3': 5, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'is_verified', '3': 6, '4': 1, '5': 8, '10': 'isVerified'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'last_verified_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastVerifiedAt'},
  ],
};

/// Descriptor for `FacialData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List facialDataDescriptor = $convert.base64Decode('CgpGYWNpYWxEYXRhEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSFwoHZmFjZV9pZBgDIAEoCVIGZmFjZUlkEiMKDWZhY2VfZW5jb2RpbmcYBCABKAlSDGZhY2VFbmNvZGluZxIbCglpbWFnZV91cmwYBSABKAlSCGltYWdlVXJsEh8KC2lzX3ZlcmlmaWVkGAYgASgIUgppc1ZlcmlmaWVkEjkKCmNyZWF0ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSRAoQbGFzdF92ZXJpZmllZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDmxhc3RWZXJpZmllZEF0');
@$core.Deprecated('Use userRegisterFaceRequestDescriptor instead')
const UserRegisterFaceRequest$json = const {
  '1': 'UserRegisterFaceRequest',
  '2': const [
    const {'1': 'face_image', '3': 1, '4': 1, '5': 12, '10': 'faceImage'},
  ],
};

/// Descriptor for `UserRegisterFaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRegisterFaceRequestDescriptor = $convert.base64Decode('ChdVc2VyUmVnaXN0ZXJGYWNlUmVxdWVzdBIdCgpmYWNlX2ltYWdlGAEgASgMUglmYWNlSW1hZ2U=');
@$core.Deprecated('Use userRegisterFaceResponseDescriptor instead')
const UserRegisterFaceResponse$json = const {
  '1': 'UserRegisterFaceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'facial_data', '3': 3, '4': 1, '5': 11, '6': '.pb.FacialData', '10': 'facialData'},
  ],
};

/// Descriptor for `UserRegisterFaceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRegisterFaceResponseDescriptor = $convert.base64Decode('ChhVc2VyUmVnaXN0ZXJGYWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEi8KC2ZhY2lhbF9kYXRhGAMgASgLMg4ucGIuRmFjaWFsRGF0YVIKZmFjaWFsRGF0YQ==');
@$core.Deprecated('Use userVerifyFaceRequestDescriptor instead')
const UserVerifyFaceRequest$json = const {
  '1': 'UserVerifyFaceRequest',
  '2': const [
    const {'1': 'face_image', '3': 1, '4': 1, '5': 12, '10': 'faceImage'},
  ],
};

/// Descriptor for `UserVerifyFaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userVerifyFaceRequestDescriptor = $convert.base64Decode('ChVVc2VyVmVyaWZ5RmFjZVJlcXVlc3QSHQoKZmFjZV9pbWFnZRgBIAEoDFIJZmFjZUltYWdl');
@$core.Deprecated('Use userVerifyFaceResponseDescriptor instead')
const UserVerifyFaceResponse$json = const {
  '1': 'UserVerifyFaceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_match', '3': 3, '4': 1, '5': 8, '10': 'isMatch'},
    const {'1': 'confidence', '3': 4, '4': 1, '5': 2, '10': 'confidence'},
  ],
};

/// Descriptor for `UserVerifyFaceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userVerifyFaceResponseDescriptor = $convert.base64Decode('ChZVc2VyVmVyaWZ5RmFjZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIZCghpc19tYXRjaBgDIAEoCFIHaXNNYXRjaBIeCgpjb25maWRlbmNlGAQgASgCUgpjb25maWRlbmNl');
@$core.Deprecated('Use getFacialDataRequestDescriptor instead')
const GetFacialDataRequest$json = const {
  '1': 'GetFacialDataRequest',
};

/// Descriptor for `GetFacialDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFacialDataRequestDescriptor = $convert.base64Decode('ChRHZXRGYWNpYWxEYXRhUmVxdWVzdA==');
@$core.Deprecated('Use getFacialDataResponseDescriptor instead')
const GetFacialDataResponse$json = const {
  '1': 'GetFacialDataResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'facial_data', '3': 3, '4': 1, '5': 11, '6': '.pb.FacialData', '10': 'facialData'},
  ],
};

/// Descriptor for `GetFacialDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFacialDataResponseDescriptor = $convert.base64Decode('ChVHZXRGYWNpYWxEYXRhUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEi8KC2ZhY2lhbF9kYXRhGAMgASgLMg4ucGIuRmFjaWFsRGF0YVIKZmFjaWFsRGF0YQ==');
@$core.Deprecated('Use setPasscodeRequestDescriptor instead')
const SetPasscodeRequest$json = const {
  '1': 'SetPasscodeRequest',
  '2': const [
    const {'1': 'passcode', '3': 1, '4': 1, '5': 9, '10': 'passcode'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `SetPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasscodeRequestDescriptor = $convert.base64Decode('ChJTZXRQYXNzY29kZVJlcXVlc3QSGgoIcGFzc2NvZGUYASABKAlSCHBhc3Njb2RlEhoKCHBhc3N3b3JkGAIgASgJUghwYXNzd29yZA==');
@$core.Deprecated('Use setPasscodeResponseDescriptor instead')
const SetPasscodeResponse$json = const {
  '1': 'SetPasscodeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SetPasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasscodeResponseDescriptor = $convert.base64Decode('ChNTZXRQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use verifyPasscodeRequestDescriptor instead')
const VerifyPasscodeRequest$json = const {
  '1': 'VerifyPasscodeRequest',
  '2': const [
    const {'1': 'passcode', '3': 1, '4': 1, '5': 9, '10': 'passcode'},
  ],
};

/// Descriptor for `VerifyPasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasscodeRequestDescriptor = $convert.base64Decode('ChVWZXJpZnlQYXNzY29kZVJlcXVlc3QSGgoIcGFzc2NvZGUYASABKAlSCHBhc3Njb2Rl');
@$core.Deprecated('Use verifyPasscodeResponseDescriptor instead')
const VerifyPasscodeResponse$json = const {
  '1': 'VerifyPasscodeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_valid', '3': 3, '4': 1, '5': 8, '10': 'isValid'},
  ],
};

/// Descriptor for `VerifyPasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPasscodeResponseDescriptor = $convert.base64Decode('ChZWZXJpZnlQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIZCghpc192YWxpZBgDIAEoCFIHaXNWYWxpZA==');
@$core.Deprecated('Use removePasscodeRequestDescriptor instead')
const RemovePasscodeRequest$json = const {
  '1': 'RemovePasscodeRequest',
  '2': const [
    const {'1': 'password', '3': 1, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `RemovePasscodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removePasscodeRequestDescriptor = $convert.base64Decode('ChVSZW1vdmVQYXNzY29kZVJlcXVlc3QSGgoIcGFzc3dvcmQYASABKAlSCHBhc3N3b3Jk');
@$core.Deprecated('Use removePasscodeResponseDescriptor instead')
const RemovePasscodeResponse$json = const {
  '1': 'RemovePasscodeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemovePasscodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removePasscodeResponseDescriptor = $convert.base64Decode('ChZSZW1vdmVQYXNzY29kZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use checkPasscodeExistsRequestDescriptor instead')
const CheckPasscodeExistsRequest$json = const {
  '1': 'CheckPasscodeExistsRequest',
};

/// Descriptor for `CheckPasscodeExistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkPasscodeExistsRequestDescriptor = $convert.base64Decode('ChpDaGVja1Bhc3Njb2RlRXhpc3RzUmVxdWVzdA==');
@$core.Deprecated('Use checkPasscodeExistsResponseDescriptor instead')
const CheckPasscodeExistsResponse$json = const {
  '1': 'CheckPasscodeExistsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'has_passcode', '3': 2, '4': 1, '5': 8, '10': 'hasPasscode'},
  ],
};

/// Descriptor for `CheckPasscodeExistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkPasscodeExistsResponseDescriptor = $convert.base64Decode('ChtDaGVja1Bhc3Njb2RlRXhpc3RzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIhCgxoYXNfcGFzc2NvZGUYAiABKAhSC2hhc1Bhc3Njb2Rl');
@$core.Deprecated('Use devicePermissionDescriptor instead')
const DevicePermission$json = const {
  '1': 'DevicePermission',
  '2': const [
    const {'1': 'permission_type', '3': 1, '4': 1, '5': 14, '6': '.pb.PermissionType', '10': 'permissionType'},
    const {'1': 'is_granted', '3': 2, '4': 1, '5': 8, '10': 'isGranted'},
    const {'1': 'granted_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'grantedAt'},
  ],
};

/// Descriptor for `DevicePermission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List devicePermissionDescriptor = $convert.base64Decode('ChBEZXZpY2VQZXJtaXNzaW9uEjsKD3Blcm1pc3Npb25fdHlwZRgBIAEoDjISLnBiLlBlcm1pc3Npb25UeXBlUg5wZXJtaXNzaW9uVHlwZRIdCgppc19ncmFudGVkGAIgASgIUglpc0dyYW50ZWQSOQoKZ3JhbnRlZF9hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWdyYW50ZWRBdA==');
@$core.Deprecated('Use updateDevicePermissionsRequestDescriptor instead')
const UpdateDevicePermissionsRequest$json = const {
  '1': 'UpdateDevicePermissionsRequest',
  '2': const [
    const {'1': 'permissions', '3': 1, '4': 3, '5': 11, '6': '.pb.DevicePermission', '10': 'permissions'},
  ],
};

/// Descriptor for `UpdateDevicePermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDevicePermissionsRequestDescriptor = $convert.base64Decode('Ch5VcGRhdGVEZXZpY2VQZXJtaXNzaW9uc1JlcXVlc3QSNgoLcGVybWlzc2lvbnMYASADKAsyFC5wYi5EZXZpY2VQZXJtaXNzaW9uUgtwZXJtaXNzaW9ucw==');
@$core.Deprecated('Use updateDevicePermissionsResponseDescriptor instead')
const UpdateDevicePermissionsResponse$json = const {
  '1': 'UpdateDevicePermissionsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateDevicePermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDevicePermissionsResponseDescriptor = $convert.base64Decode('Ch9VcGRhdGVEZXZpY2VQZXJtaXNzaW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getDevicePermissionsRequestDescriptor instead')
const GetDevicePermissionsRequest$json = const {
  '1': 'GetDevicePermissionsRequest',
};

/// Descriptor for `GetDevicePermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDevicePermissionsRequestDescriptor = $convert.base64Decode('ChtHZXREZXZpY2VQZXJtaXNzaW9uc1JlcXVlc3Q=');
@$core.Deprecated('Use getDevicePermissionsResponseDescriptor instead')
const GetDevicePermissionsResponse$json = const {
  '1': 'GetDevicePermissionsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'permissions', '3': 3, '4': 3, '5': 11, '6': '.pb.DevicePermission', '10': 'permissions'},
  ],
};

/// Descriptor for `GetDevicePermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDevicePermissionsResponseDescriptor = $convert.base64Decode('ChxHZXREZXZpY2VQZXJtaXNzaW9uc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI2CgtwZXJtaXNzaW9ucxgDIAMoCzIULnBiLkRldmljZVBlcm1pc3Npb25SC3Blcm1pc3Npb25z');
const $core.Map<$core.String, $core.dynamic> UserServiceBase$json = const {
  '1': 'UserService',
  '2': const [
    const {'1': 'CreateUser', '2': '.pb.CreateUserRequest', '3': '.pb.CreateUserResponse', '4': const {}},
    const {'1': 'GetUserProfile', '2': '.pb.GetUserProfileRequest', '3': '.pb.GetUserProfileResponse', '4': const {}},
    const {'1': 'UpdateUserProfile', '2': '.pb.UpdateUserProfileRequest', '3': '.pb.UpdateUserProfileResponse', '4': const {}},
    const {'1': 'UpdatePassword', '2': '.pb.UpdatePasswordRequest', '3': '.pb.UpdatePasswordResponse', '4': const {}},
    const {'1': 'UpdatePreferences', '2': '.pb.UpdatePreferencesRequest', '3': '.pb.UpdatePreferencesResponse', '4': const {}},
    const {'1': 'UploadIDDocument', '2': '.pb.UploadIDDocumentRequest', '3': '.pb.UploadIDDocumentResponse', '4': const {}},
    const {'1': 'GetIDDocuments', '2': '.pb.GetIDDocumentsRequest', '3': '.pb.GetIDDocumentsResponse', '4': const {}},
    const {'1': 'VerifyIDDocument', '2': '.pb.VerifyIDDocumentRequest', '3': '.pb.VerifyIDDocumentResponse', '4': const {}},
    const {'1': 'RegisterFace', '2': '.pb.UserRegisterFaceRequest', '3': '.pb.UserRegisterFaceResponse', '4': const {}},
    const {'1': 'VerifyFace', '2': '.pb.UserVerifyFaceRequest', '3': '.pb.UserVerifyFaceResponse', '4': const {}},
    const {'1': 'GetFacialData', '2': '.pb.GetFacialDataRequest', '3': '.pb.GetFacialDataResponse', '4': const {}},
    const {'1': 'SetPasscode', '2': '.pb.SetPasscodeRequest', '3': '.pb.SetPasscodeResponse', '4': const {}},
    const {'1': 'VerifyPasscode', '2': '.pb.VerifyPasscodeRequest', '3': '.pb.VerifyPasscodeResponse', '4': const {}},
    const {'1': 'RemovePasscode', '2': '.pb.RemovePasscodeRequest', '3': '.pb.RemovePasscodeResponse', '4': const {}},
    const {'1': 'CheckPasscodeExists', '2': '.pb.CheckPasscodeExistsRequest', '3': '.pb.CheckPasscodeExistsResponse', '4': const {}},
    const {'1': 'UpdateDevicePermissions', '2': '.pb.UpdateDevicePermissionsRequest', '3': '.pb.UpdateDevicePermissionsResponse', '4': const {}},
    const {'1': 'GetDevicePermissions', '2': '.pb.GetDevicePermissionsRequest', '3': '.pb.GetDevicePermissionsResponse', '4': const {}},
  ],
};

@$core.Deprecated('Use userServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> UserServiceBase$messageJson = const {
  '.pb.CreateUserRequest': CreateUserRequest$json,
  '.pb.CreateUserResponse': CreateUserResponse$json,
  '.pb.Data': $0.Data$json,
  '.pb.User': $0.User$json,
  '.google.protobuf.Timestamp': $1.Timestamp$json,
  '.pb.Session': $0.Session$json,
  '.pb.GetUserProfileRequest': GetUserProfileRequest$json,
  '.pb.GetUserProfileResponse': GetUserProfileResponse$json,
  '.pb.UserPreferences': UserPreferences$json,
  '.pb.UpdateUserProfileRequest': UpdateUserProfileRequest$json,
  '.pb.UpdateUserProfileResponse': UpdateUserProfileResponse$json,
  '.pb.UpdatePasswordRequest': UpdatePasswordRequest$json,
  '.pb.UpdatePasswordResponse': UpdatePasswordResponse$json,
  '.pb.UpdatePreferencesRequest': UpdatePreferencesRequest$json,
  '.pb.UpdatePreferencesResponse': UpdatePreferencesResponse$json,
  '.pb.UploadIDDocumentRequest': UploadIDDocumentRequest$json,
  '.pb.UploadIDDocumentResponse': UploadIDDocumentResponse$json,
  '.pb.IDDocument': IDDocument$json,
  '.pb.GetIDDocumentsRequest': GetIDDocumentsRequest$json,
  '.pb.GetIDDocumentsResponse': GetIDDocumentsResponse$json,
  '.pb.VerifyIDDocumentRequest': VerifyIDDocumentRequest$json,
  '.pb.VerifyIDDocumentResponse': VerifyIDDocumentResponse$json,
  '.pb.UserRegisterFaceRequest': UserRegisterFaceRequest$json,
  '.pb.UserRegisterFaceResponse': UserRegisterFaceResponse$json,
  '.pb.FacialData': FacialData$json,
  '.pb.UserVerifyFaceRequest': UserVerifyFaceRequest$json,
  '.pb.UserVerifyFaceResponse': UserVerifyFaceResponse$json,
  '.pb.GetFacialDataRequest': GetFacialDataRequest$json,
  '.pb.GetFacialDataResponse': GetFacialDataResponse$json,
  '.pb.SetPasscodeRequest': SetPasscodeRequest$json,
  '.pb.SetPasscodeResponse': SetPasscodeResponse$json,
  '.pb.VerifyPasscodeRequest': VerifyPasscodeRequest$json,
  '.pb.VerifyPasscodeResponse': VerifyPasscodeResponse$json,
  '.pb.RemovePasscodeRequest': RemovePasscodeRequest$json,
  '.pb.RemovePasscodeResponse': RemovePasscodeResponse$json,
  '.pb.CheckPasscodeExistsRequest': CheckPasscodeExistsRequest$json,
  '.pb.CheckPasscodeExistsResponse': CheckPasscodeExistsResponse$json,
  '.pb.UpdateDevicePermissionsRequest': UpdateDevicePermissionsRequest$json,
  '.pb.DevicePermission': DevicePermission$json,
  '.pb.UpdateDevicePermissionsResponse': UpdateDevicePermissionsResponse$json,
  '.pb.GetDevicePermissionsRequest': GetDevicePermissionsRequest$json,
  '.pb.GetDevicePermissionsResponse': GetDevicePermissionsResponse$json,
};

/// Descriptor for `UserService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List userServiceDescriptor = $convert.base64Decode('CgtVc2VyU2VydmljZRKcAQoKQ3JlYXRlVXNlchIVLnBiLkNyZWF0ZVVzZXJSZXF1ZXN0GhYucGIuQ3JlYXRlVXNlclJlc3BvbnNlIl+SQUgKBXVzZXJzEhFDcmVhdGUgYSBuZXcgdXNlchosQ3JlYXRlcyBhIG5ldyB1c2VyIHdpdGggdGhlIHByb3ZpZGVkIGRldGFpbHOC0+STAg4iCS92MS91c2VyczoBKhK2AQoOR2V0VXNlclByb2ZpbGUSGS5wYi5HZXRVc2VyUHJvZmlsZVJlcXVlc3QaGi5wYi5HZXRVc2VyUHJvZmlsZVJlc3BvbnNlIm2SQVEKBXVzZXJzEhBHZXQgdXNlciBwcm9maWxlGiRHZXQgdGhlIGF1dGhlbnRpY2F0ZWQgdXNlcidzIHByb2ZpbGViEAoOCgpiZWFyZXJBdXRoEgCC0+STAhMSES92MS91c2Vycy9wcm9maWxlEsgBChFVcGRhdGVVc2VyUHJvZmlsZRIcLnBiLlVwZGF0ZVVzZXJQcm9maWxlUmVxdWVzdBodLnBiLlVwZGF0ZVVzZXJQcm9maWxlUmVzcG9uc2UidpJBVwoFdXNlcnMSE1VwZGF0ZSB1c2VyIHByb2ZpbGUaJ1VwZGF0ZSB0aGUgYXV0aGVudGljYXRlZCB1c2VyJ3MgcHJvZmlsZWIQCg4KCmJlYXJlckF1dGgSAILT5JMCFhoRL3YxL3VzZXJzL3Byb2ZpbGU6ASoSvQEKDlVwZGF0ZVBhc3N3b3JkEhkucGIuVXBkYXRlUGFzc3dvcmRSZXF1ZXN0GhoucGIuVXBkYXRlUGFzc3dvcmRSZXNwb25zZSJ0kkFUCgV1c2VycxIPVXBkYXRlIHBhc3N3b3JkGihVcGRhdGUgdGhlIGF1dGhlbnRpY2F0ZWQgdXNlcidzIHBhc3N3b3JkYhAKDgoKYmVhcmVyQXV0aBIAgtPkkwIXGhIvdjEvdXNlcnMvcGFzc3dvcmQ6ASoS1QEKEVVwZGF0ZVByZWZlcmVuY2VzEhwucGIuVXBkYXRlUHJlZmVyZW5jZXNSZXF1ZXN0Gh0ucGIuVXBkYXRlUHJlZmVyZW5jZXNSZXNwb25zZSKCAZJBXwoFdXNlcnMSF1VwZGF0ZSB1c2VyIHByZWZlcmVuY2VzGitVcGRhdGUgdGhlIGF1dGhlbnRpY2F0ZWQgdXNlcidzIHByZWZlcmVuY2VzYhAKDgoKYmVhcmVyQXV0aBIAgtPkkwIaGhUvdjEvdXNlcnMvcHJlZmVyZW5jZXM6ASoS0gEKEFVwbG9hZElERG9jdW1lbnQSGy5wYi5VcGxvYWRJRERvY3VtZW50UmVxdWVzdBocLnBiLlVwbG9hZElERG9jdW1lbnRSZXNwb25zZSKCAZJBWAoIaWRlbnRpdHkSElVwbG9hZCBJRCBkb2N1bWVudBomVXBsb2FkIGFuZCB2ZXJpZnkgYW4gaWRlbnRpdHkgZG9jdW1lbnRiEAoOCgpiZWFyZXJBdXRoEgCC0+STAiEiHC92MS91c2Vycy9pZGVudGl0eS9kb2N1bWVudHM6ASoS0AEKDkdldElERG9jdW1lbnRzEhkucGIuR2V0SUREb2N1bWVudHNSZXF1ZXN0GhoucGIuR2V0SUREb2N1bWVudHNSZXNwb25zZSKGAZJBXwoIaWRlbnRpdHkSEEdldCBJRCBkb2N1bWVudHMaL0dldCBhbGwgSUQgZG9jdW1lbnRzIGZvciB0aGUgYXV0aGVudGljYXRlZCB1c2VyYhAKDgoKYmVhcmVyQXV0aBIAgtPkkwIeEhwvdjEvdXNlcnMvaWRlbnRpdHkvZG9jdW1lbnRzEvABChBWZXJpZnlJRERvY3VtZW50EhsucGIuVmVyaWZ5SUREb2N1bWVudFJlcXVlc3QaHC5wYi5WZXJpZnlJRERvY3VtZW50UmVzcG9uc2UioAGSQWEKCGlkZW50aXR5EhJWZXJpZnkgSUQgZG9jdW1lbnQaL01hbnVhbGx5IHRyaWdnZXIgdmVyaWZpY2F0aW9uIG9mIGFuIElEIGRvY3VtZW50YhAKDgoKYmVhcmVyQXV0aBIAgtPkkwI2IjEvdjEvdXNlcnMvaWRlbnRpdHkvZG9jdW1lbnRzL3tkb2N1bWVudF9pZH0vdmVyaWZ5OgEqErsBCgxSZWdpc3RlckZhY2USGy5wYi5Vc2VyUmVnaXN0ZXJGYWNlUmVxdWVzdBocLnBiLlVzZXJSZWdpc3RlckZhY2VSZXNwb25zZSJwkkFLCghpZGVudGl0eRINUmVnaXN0ZXIgZmFjZRoeUmVnaXN0ZXIgZmFjaWFsIGJpb21ldHJpYyBkYXRhYhAKDgoKYmVhcmVyQXV0aBIAgtPkkwIcIhcvdjEvdXNlcnMvaWRlbnRpdHkvZmFjZToBKhLKAQoKVmVyaWZ5RmFjZRIZLnBiLlVzZXJWZXJpZnlGYWNlUmVxdWVzdBoaLnBiLlVzZXJWZXJpZnlGYWNlUmVzcG9uc2UihAGSQVgKCGlkZW50aXR5EgtWZXJpZnkgZmFjZRotVmVyaWZ5IGZhY2UgYWdhaW5zdCByZWdpc3RlcmVkIGJpb21ldHJpYyBkYXRhYhAKDgoKYmVhcmVyQXV0aBIAgtPkkwIjIh4vdjEvdXNlcnMvaWRlbnRpdHkvZmFjZS92ZXJpZnk6ASoSuwEKDUdldEZhY2lhbERhdGESGC5wYi5HZXRGYWNpYWxEYXRhUmVxdWVzdBoZLnBiLkdldEZhY2lhbERhdGFSZXNwb25zZSJ1kkFTCghpZGVudGl0eRIPR2V0IGZhY2lhbCBkYXRhGiRHZXQgcmVnaXN0ZXJlZCBmYWNpYWwgYmlvbWV0cmljIGRhdGFiEAoOCgpiZWFyZXJBdXRoEgCC0+STAhkSFy92MS91c2Vycy9pZGVudGl0eS9mYWNlEqgBCgtTZXRQYXNzY29kZRIWLnBiLlNldFBhc3Njb2RlUmVxdWVzdBoXLnBiLlNldFBhc3Njb2RlUmVzcG9uc2UiaJJBSAoIc2VjdXJpdHkSDFNldCBwYXNzY29kZRocU2V0IG9yIHVwZGF0ZSBsb2dpbiBwYXNzY29kZWIQCg4KCmJlYXJlckF1dGgSAILT5JMCFyISL3YxL3VzZXJzL3Bhc3Njb2RlOgEqErQBCg5WZXJpZnlQYXNzY29kZRIZLnBiLlZlcmlmeVBhc3Njb2RlUmVxdWVzdBoaLnBiLlZlcmlmeVBhc3Njb2RlUmVzcG9uc2Uia5JBRAoIc2VjdXJpdHkSD1ZlcmlmeSBwYXNzY29kZRoVVmVyaWZ5IGxvZ2luIHBhc3Njb2RlYhAKDgoKYmVhcmVyQXV0aBIAgtPkkwIeIhkvdjEvdXNlcnMvcGFzc2NvZGUvdmVyaWZ5OgEqErQBCg5SZW1vdmVQYXNzY29kZRIZLnBiLlJlbW92ZVBhc3Njb2RlUmVxdWVzdBoaLnBiLlJlbW92ZVBhc3Njb2RlUmVzcG9uc2Uia5JBRAoIc2VjdXJpdHkSD1JlbW92ZSBwYXNzY29kZRoVUmVtb3ZlIGxvZ2luIHBhc3Njb2RlYhAKDgoKYmVhcmVyQXV0aBIAgtPkkwIeIhkvdjEvdXNlcnMvcGFzc2NvZGUvcmVtb3ZlOgEqEtEBChNDaGVja1Bhc3Njb2RlRXhpc3RzEh4ucGIuQ2hlY2tQYXNzY29kZUV4aXN0c1JlcXVlc3QaHy5wYi5DaGVja1Bhc3Njb2RlRXhpc3RzUmVzcG9uc2UieZJBVQoIc2VjdXJpdHkSFUNoZWNrIHBhc3Njb2RlIGV4aXN0cxogQ2hlY2sgaWYgdXNlciBoYXMgYSBwYXNzY29kZSBzZXRiEAoOCgpiZWFyZXJBdXRoEgCC0+STAhsSGS92MS91c2Vycy9wYXNzY29kZS9leGlzdHMS6AEKF1VwZGF0ZURldmljZVBlcm1pc3Npb25zEiIucGIuVXBkYXRlRGV2aWNlUGVybWlzc2lvbnNSZXF1ZXN0GiMucGIuVXBkYXRlRGV2aWNlUGVybWlzc2lvbnNSZXNwb25zZSKDAZJBYAoLcGVybWlzc2lvbnMSGVVwZGF0ZSBkZXZpY2UgcGVybWlzc2lvbnMaJFVwZGF0ZSBkZXZpY2UgcGVybWlzc2lvbiBwcmVmZXJlbmNlc2IQCg4KCmJlYXJlckF1dGgSAILT5JMCGhoVL3YxL3VzZXJzL3Blcm1pc3Npb25zOgEqEtABChRHZXREZXZpY2VQZXJtaXNzaW9ucxIfLnBiLkdldERldmljZVBlcm1pc3Npb25zUmVxdWVzdBogLnBiLkdldERldmljZVBlcm1pc3Npb25zUmVzcG9uc2UidZJBVQoLcGVybWlzc2lvbnMSFkdldCBkZXZpY2UgcGVybWlzc2lvbnMaHEdldCBkZXZpY2UgcGVybWlzc2lvbiBzdGF0dXNiEAoOCgpiZWFyZXJBdXRoEgCC0+STAhcSFS92MS91c2Vycy9wZXJtaXNzaW9ucw==');
