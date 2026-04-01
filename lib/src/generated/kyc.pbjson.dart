///
//  Generated code. Do not modify.
//  source: kyc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use kYCTierDescriptor instead')
const KYCTier$json = const {
  '1': 'KYCTier',
  '2': const [
    const {'1': 'TIER_UNKNOWN', '2': 0},
    const {'1': 'TIER_1', '2': 1},
    const {'1': 'TIER_2', '2': 2},
    const {'1': 'TIER_3', '2': 3},
  ],
};

/// Descriptor for `KYCTier`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCTierDescriptor = $convert.base64Decode('CgdLWUNUaWVyEhAKDFRJRVJfVU5LTk9XThAAEgoKBlRJRVJfMRABEgoKBlRJRVJfMhACEgoKBlRJRVJfMxAD');
@$core.Deprecated('Use kYCStatusDescriptor instead')
const KYCStatus$json = const {
  '1': 'KYCStatus',
  '2': const [
    const {'1': 'STATUS_UNKNOWN', '2': 0},
    const {'1': 'NOT_STARTED', '2': 1},
    const {'1': 'IN_PROGRESS', '2': 2},
    const {'1': 'PENDING_REVIEW', '2': 3},
    const {'1': 'APPROVED', '2': 4},
    const {'1': 'REJECTED', '2': 5},
    const {'1': 'EXPIRED', '2': 6},
  ],
};

/// Descriptor for `KYCStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCStatusDescriptor = $convert.base64Decode('CglLWUNTdGF0dXMSEgoOU1RBVFVTX1VOS05PV04QABIPCgtOT1RfU1RBUlRFRBABEg8KC0lOX1BST0dSRVNTEAISEgoOUEVORElOR19SRVZJRVcQAxIMCghBUFBST1ZFRBAEEgwKCFJFSkVDVEVEEAUSCwoHRVhQSVJFRBAG');
@$core.Deprecated('Use iDTypeDescriptor instead')
const IDType$json = const {
  '1': 'IDType',
  '2': const [
    const {'1': 'ID_UNKNOWN', '2': 0},
    const {'1': 'BVN', '2': 1},
    const {'1': 'NIN', '2': 2},
    const {'1': 'DRIVERS_LICENSE', '2': 3},
    const {'1': 'INTERNATIONAL_PASSPORT', '2': 4},
    const {'1': 'VOTERS_CARD', '2': 5},
    const {'1': 'GHANA_CARD', '2': 10},
    const {'1': 'KENYA_NATIONAL_ID', '2': 20},
    const {'1': 'KRA_PIN', '2': 21},
    const {'1': 'SA_ID_CARD', '2': 30},
    const {'1': 'SA_PASSPORT', '2': 31},
    const {'1': 'UK_PASSPORT', '2': 40},
    const {'1': 'UK_DRIVING_LICENSE', '2': 41},
    const {'1': 'US_SSN', '2': 50},
    const {'1': 'US_STATE_ID', '2': 51},
    const {'1': 'US_PASSPORT', '2': 52},
  ],
};

/// Descriptor for `IDType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List iDTypeDescriptor = $convert.base64Decode('CgZJRFR5cGUSDgoKSURfVU5LTk9XThAAEgcKA0JWThABEgcKA05JThACEhMKD0RSSVZFUlNfTElDRU5TRRADEhoKFklOVEVSTkFUSU9OQUxfUEFTU1BPUlQQBBIPCgtWT1RFUlNfQ0FSRBAFEg4KCkdIQU5BX0NBUkQQChIVChFLRU5ZQV9OQVRJT05BTF9JRBAUEgsKB0tSQV9QSU4QFRIOCgpTQV9JRF9DQVJEEB4SDwoLU0FfUEFTU1BPUlQQHxIPCgtVS19QQVNTUE9SVBAoEhYKElVLX0RSSVZJTkdfTElDRU5TRRApEgoKBlVTX1NTThAyEg8KC1VTX1NUQVRFX0lEEDMSDwoLVVNfUEFTU1BPUlQQNA==');
@$core.Deprecated('Use documentStatusDescriptor instead')
const DocumentStatus$json = const {
  '1': 'DocumentStatus',
  '2': const [
    const {'1': 'DOC_STATUS_UNKNOWN', '2': 0},
    const {'1': 'DOC_PENDING_UPLOAD', '2': 1},
    const {'1': 'DOC_UPLOADED', '2': 2},
    const {'1': 'DOC_UNDER_REVIEW', '2': 3},
    const {'1': 'DOC_APPROVED', '2': 4},
    const {'1': 'DOC_REJECTED', '2': 5},
  ],
};

/// Descriptor for `DocumentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentStatusDescriptor = $convert.base64Decode('Cg5Eb2N1bWVudFN0YXR1cxIWChJET0NfU1RBVFVTX1VOS05PV04QABIWChJET0NfUEVORElOR19VUExPQUQQARIQCgxET0NfVVBMT0FERUQQAhIUChBET0NfVU5ERVJfUkVWSUVXEAMSEAoMRE9DX0FQUFJPVkVEEAQSEAoMRE9DX1JFSkVDVEVEEAU=');
@$core.Deprecated('Use countryKYCRequirementsDescriptor instead')
const CountryKYCRequirements$json = const {
  '1': 'CountryKYCRequirements',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'accepted_id_types', '3': 2, '4': 3, '5': 14, '6': '.kyc.IDType', '10': 'acceptedIdTypes'},
    const {'1': 'mandatory_id_types', '3': 3, '4': 3, '5': 14, '6': '.kyc.IDType', '10': 'mandatoryIdTypes'},
    const {'1': 'address_proof_required', '3': 4, '4': 1, '5': 8, '10': 'addressProofRequired'},
    const {'1': 'liveness_check_required', '3': 5, '4': 1, '5': 8, '10': 'livenessCheckRequired'},
    const {'1': 'tier_1_daily_limit', '3': 6, '4': 1, '5': 3, '10': 'tier1DailyLimit'},
    const {'1': 'tier_2_daily_limit', '3': 7, '4': 1, '5': 3, '10': 'tier2DailyLimit'},
    const {'1': 'tier_3_daily_limit', '3': 8, '4': 1, '5': 3, '10': 'tier3DailyLimit'},
  ],
};

/// Descriptor for `CountryKYCRequirements`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countryKYCRequirementsDescriptor = $convert.base64Decode('ChZDb3VudHJ5S1lDUmVxdWlyZW1lbnRzEiEKDGNvdW50cnlfY29kZRgBIAEoCVILY291bnRyeUNvZGUSNwoRYWNjZXB0ZWRfaWRfdHlwZXMYAiADKA4yCy5reWMuSURUeXBlUg9hY2NlcHRlZElkVHlwZXMSOQoSbWFuZGF0b3J5X2lkX3R5cGVzGAMgAygOMgsua3ljLklEVHlwZVIQbWFuZGF0b3J5SWRUeXBlcxI0ChZhZGRyZXNzX3Byb29mX3JlcXVpcmVkGAQgASgIUhRhZGRyZXNzUHJvb2ZSZXF1aXJlZBI2ChdsaXZlbmVzc19jaGVja19yZXF1aXJlZBgFIAEoCFIVbGl2ZW5lc3NDaGVja1JlcXVpcmVkEisKEnRpZXJfMV9kYWlseV9saW1pdBgGIAEoA1IPdGllcjFEYWlseUxpbWl0EisKEnRpZXJfMl9kYWlseV9saW1pdBgHIAEoA1IPdGllcjJEYWlseUxpbWl0EisKEnRpZXJfM19kYWlseV9saW1pdBgIIAEoA1IPdGllcjNEYWlseUxpbWl0');
@$core.Deprecated('Use kYCTierInfoDescriptor instead')
const KYCTierInfo$json = const {
  '1': 'KYCTierInfo',
  '2': const [
    const {'1': 'tier', '3': 1, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'tier'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'benefits', '3': 5, '4': 3, '5': 9, '10': 'benefits'},
    const {'1': 'daily_transaction_limit', '3': 6, '4': 1, '5': 3, '10': 'dailyTransactionLimit'},
    const {'1': 'daily_receive_limit', '3': 7, '4': 1, '5': 3, '10': 'dailyReceiveLimit'},
    const {'1': 'max_balance', '3': 8, '4': 1, '5': 3, '10': 'maxBalance'},
    const {'1': 'verified_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
    const {'1': 'expires_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'is_current', '3': 11, '4': 1, '5': 8, '10': 'isCurrent'},
    const {'1': 'is_locked', '3': 12, '4': 1, '5': 8, '10': 'isLocked'},
  ],
};

/// Descriptor for `KYCTierInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kYCTierInfoDescriptor = $convert.base64Decode('CgtLWUNUaWVySW5mbxIgCgR0aWVyGAEgASgOMgwua3ljLktZQ1RpZXJSBHRpZXISJgoGc3RhdHVzGAIgASgOMg4ua3ljLktZQ1N0YXR1c1IGc3RhdHVzEiEKDGRpc3BsYXlfbmFtZRgDIAEoCVILZGlzcGxheU5hbWUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhoKCGJlbmVmaXRzGAUgAygJUghiZW5lZml0cxI2ChdkYWlseV90cmFuc2FjdGlvbl9saW1pdBgGIAEoA1IVZGFpbHlUcmFuc2FjdGlvbkxpbWl0Ei4KE2RhaWx5X3JlY2VpdmVfbGltaXQYByABKANSEWRhaWx5UmVjZWl2ZUxpbWl0Eh8KC21heF9iYWxhbmNlGAggASgDUgptYXhCYWxhbmNlEjsKC3ZlcmlmaWVkX2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdmVyaWZpZWRBdBI5CgpleHBpcmVzX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZXhwaXJlc0F0Eh0KCmlzX2N1cnJlbnQYCyABKAhSCWlzQ3VycmVudBIbCglpc19sb2NrZWQYDCABKAhSCGlzTG9ja2Vk');
@$core.Deprecated('Use verifyIDRequestDescriptor instead')
const VerifyIDRequest$json = const {
  '1': 'VerifyIDRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'id_type', '3': 2, '4': 1, '5': 14, '6': '.kyc.IDType', '10': 'idType'},
    const {'1': 'id_number', '3': 3, '4': 1, '5': 9, '10': 'idNumber'},
    const {'1': 'first_name', '3': 4, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 5, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'date_of_birth', '3': 6, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyIDRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIDRequestDescriptor = $convert.base64Decode('Cg9WZXJpZnlJRFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiQKB2lkX3R5cGUYAiABKA4yCy5reWMuSURUeXBlUgZpZFR5cGUSGwoJaWRfbnVtYmVyGAMgASgJUghpZE51bWJlchIdCgpmaXJzdF9uYW1lGAQgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAUgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAYgASgJUgtkYXRlT2ZCaXJ0aBIhCgxwaG9uZV9udW1iZXIYByABKAlSC3Bob25lTnVtYmVy');
@$core.Deprecated('Use uploadDocumentRequestDescriptor instead')
const UploadDocumentRequest$json = const {
  '1': 'UploadDocumentRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'document_type', '3': 2, '4': 1, '5': 14, '6': '.kyc.IDType', '10': 'documentType'},
    const {'1': 'document_front_url', '3': 3, '4': 1, '5': 9, '10': 'documentFrontUrl'},
    const {'1': 'document_back_url', '3': 4, '4': 1, '5': 9, '10': 'documentBackUrl'},
    const {'1': 'selfie_url', '3': 5, '4': 1, '5': 9, '10': 'selfieUrl'},
    const {'1': 'proof_of_address_url', '3': 6, '4': 1, '5': 9, '10': 'proofOfAddressUrl'},
  ],
};

/// Descriptor for `UploadDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadDocumentRequestDescriptor = $convert.base64Decode('ChVVcGxvYWREb2N1bWVudFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEjAKDWRvY3VtZW50X3R5cGUYAiABKA4yCy5reWMuSURUeXBlUgxkb2N1bWVudFR5cGUSLAoSZG9jdW1lbnRfZnJvbnRfdXJsGAMgASgJUhBkb2N1bWVudEZyb250VXJsEioKEWRvY3VtZW50X2JhY2tfdXJsGAQgASgJUg9kb2N1bWVudEJhY2tVcmwSHQoKc2VsZmllX3VybBgFIAEoCVIJc2VsZmllVXJsEi8KFHByb29mX29mX2FkZHJlc3NfdXJsGAYgASgJUhFwcm9vZk9mQWRkcmVzc1VybA==');
@$core.Deprecated('Use verifyIDResponseDescriptor instead')
const VerifyIDResponse$json = const {
  '1': 'VerifyIDResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
    const {'1': 'current_tier', '3': 4, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'currentTier'},
    const {'1': 'verified_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `VerifyIDResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIDResponseDescriptor = $convert.base64Decode('ChBWZXJpZnlJRFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRImCgZzdGF0dXMYAyABKA4yDi5reWMuS1lDU3RhdHVzUgZzdGF0dXMSLwoMY3VycmVudF90aWVyGAQgASgOMgwua3ljLktZQ1RpZXJSC2N1cnJlbnRUaWVyEjsKC3ZlcmlmaWVkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdmVyaWZpZWRBdBIcCglyZWZlcmVuY2UYBiABKAlSCXJlZmVyZW5jZQ==');
@$core.Deprecated('Use getKYCStatusRequestDescriptor instead')
const GetKYCStatusRequest$json = const {
  '1': 'GetKYCStatusRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetKYCStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCStatusRequestDescriptor = $convert.base64Decode('ChNHZXRLWUNTdGF0dXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use getKYCStatusResponseDescriptor instead')
const GetKYCStatusResponse$json = const {
  '1': 'GetKYCStatusResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
    const {'1': 'current_tier', '3': 3, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'currentTier'},
    const {'1': 'tier_info', '3': 4, '4': 3, '5': 11, '6': '.kyc.KYCTierInfo', '10': 'tierInfo'},
    const {'1': 'last_updated', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    const {'1': 'rejection_reason', '3': 6, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `GetKYCStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCStatusResponseDescriptor = $convert.base64Decode('ChRHZXRLWUNTdGF0dXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiYKBnN0YXR1cxgCIAEoDjIOLmt5Yy5LWUNTdGF0dXNSBnN0YXR1cxIvCgxjdXJyZW50X3RpZXIYAyABKA4yDC5reWMuS1lDVGllclILY3VycmVudFRpZXISLQoJdGllcl9pbmZvGAQgAygLMhAua3ljLktZQ1RpZXJJbmZvUgh0aWVySW5mbxI9CgxsYXN0X3VwZGF0ZWQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsYXN0VXBkYXRlZBIpChByZWplY3Rpb25fcmVhc29uGAYgASgJUg9yZWplY3Rpb25SZWFzb24=');
@$core.Deprecated('Use skipKYCRequestDescriptor instead')
const SkipKYCRequest$json = const {
  '1': 'SkipKYCRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'skip_tier_2', '3': 2, '4': 1, '5': 8, '10': 'skipTier2'},
  ],
};

/// Descriptor for `SkipKYCRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCRequestDescriptor = $convert.base64Decode('Cg5Ta2lwS1lDUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHgoLc2tpcF90aWVyXzIYAiABKAhSCXNraXBUaWVyMg==');
@$core.Deprecated('Use skipKYCResponseDescriptor instead')
const SkipKYCResponse$json = const {
  '1': 'SkipKYCResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'assigned_tier', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'assignedTier'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'next_steps', '3': 4, '4': 3, '5': 9, '10': 'nextSteps'},
  ],
};

/// Descriptor for `SkipKYCResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCResponseDescriptor = $convert.base64Decode('Cg9Ta2lwS1lDUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIxCg1hc3NpZ25lZF90aWVyGAIgASgOMgwua3ljLktZQ1RpZXJSDGFzc2lnbmVkVGllchIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEh0KCm5leHRfc3RlcHMYBCADKAlSCW5leHRTdGVwcw==');
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
    const {'1': 'requirements', '3': 2, '4': 1, '5': 11, '6': '.kyc.CountryKYCRequirements', '10': 'requirements'},
  ],
};

/// Descriptor for `GetCountryRequirementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRequirementsResponseDescriptor = $convert.base64Decode('Ch5HZXRDb3VudHJ5UmVxdWlyZW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxI/CgxyZXF1aXJlbWVudHMYAiABKAsyGy5reWMuQ291bnRyeUtZQ1JlcXVpcmVtZW50c1IMcmVxdWlyZW1lbnRz');
@$core.Deprecated('Use initiateKYCRequestDescriptor instead')
const InitiateKYCRequest$json = const {
  '1': 'InitiateKYCRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'target_tier', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'targetTier'},
  ],
};

/// Descriptor for `InitiateKYCRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCRequestDescriptor = $convert.base64Decode('ChJJbml0aWF0ZUtZQ1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEi0KC3RhcmdldF90aWVyGAIgASgOMgwua3ljLktZQ1RpZXJSCnRhcmdldFRpZXI=');
@$core.Deprecated('Use initiateKYCResponseDescriptor instead')
const InitiateKYCResponse$json = const {
  '1': 'InitiateKYCResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'required_documents', '3': 3, '4': 3, '5': 9, '10': 'requiredDocuments'},
    const {'1': 'required_fields', '3': 4, '4': 3, '5': 9, '10': 'requiredFields'},
    const {'1': 'redirect_url', '3': 5, '4': 1, '5': 9, '10': 'redirectUrl'},
  ],
};

/// Descriptor for `InitiateKYCResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCResponseDescriptor = $convert.base64Decode('ChNJbml0aWF0ZUtZQ1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKc2Vzc2lvbl9pZBgCIAEoCVIJc2Vzc2lvbklkEi0KEnJlcXVpcmVkX2RvY3VtZW50cxgDIAMoCVIRcmVxdWlyZWREb2N1bWVudHMSJwoPcmVxdWlyZWRfZmllbGRzGAQgAygJUg5yZXF1aXJlZEZpZWxkcxIhCgxyZWRpcmVjdF91cmwYBSABKAlSC3JlZGlyZWN0VXJs');
@$core.Deprecated('Use verificationDocumentDescriptor instead')
const VerificationDocument$json = const {
  '1': 'VerificationDocument',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'document_type', '3': 2, '4': 1, '5': 14, '6': '.kyc.IDType', '10': 'documentType'},
    const {'1': 'document_url', '3': 3, '4': 1, '5': 9, '10': 'documentUrl'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.kyc.DocumentStatus', '10': 'status'},
    const {'1': 'uploaded_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'uploadedAt'},
    const {'1': 'verified_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
    const {'1': 'rejection_reason', '3': 7, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `VerificationDocument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verificationDocumentDescriptor = $convert.base64Decode('ChRWZXJpZmljYXRpb25Eb2N1bWVudBIOCgJpZBgBIAEoCVICaWQSMAoNZG9jdW1lbnRfdHlwZRgCIAEoDjILLmt5Yy5JRFR5cGVSDGRvY3VtZW50VHlwZRIhCgxkb2N1bWVudF91cmwYAyABKAlSC2RvY3VtZW50VXJsEisKBnN0YXR1cxgEIAEoDjITLmt5Yy5Eb2N1bWVudFN0YXR1c1IGc3RhdHVzEjsKC3VwbG9hZGVkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdXBsb2FkZWRBdBI7Cgt2ZXJpZmllZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnZlcmlmaWVkQXQSKQoQcmVqZWN0aW9uX3JlYXNvbhgHIAEoCVIPcmVqZWN0aW9uUmVhc29u');
@$core.Deprecated('Use getUserDocumentsRequestDescriptor instead')
const GetUserDocumentsRequest$json = const {
  '1': 'GetUserDocumentsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserDocumentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsRequestDescriptor = $convert.base64Decode('ChdHZXRVc2VyRG9jdW1lbnRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');
@$core.Deprecated('Use getUserDocumentsResponseDescriptor instead')
const GetUserDocumentsResponse$json = const {
  '1': 'GetUserDocumentsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'documents', '3': 2, '4': 3, '5': 11, '6': '.kyc.VerificationDocument', '10': 'documents'},
  ],
};

/// Descriptor for `GetUserDocumentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsResponseDescriptor = $convert.base64Decode('ChhHZXRVc2VyRG9jdW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxI3Cglkb2N1bWVudHMYAiADKAsyGS5reWMuVmVyaWZpY2F0aW9uRG9jdW1lbnRSCWRvY3VtZW50cw==');
@$core.Deprecated('Use createVerificationSessionRequestDescriptor instead')
const CreateVerificationSessionRequest$json = const {
  '1': 'CreateVerificationSessionRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'target_tier', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'targetTier'},
    const {'1': 'country_code', '3': 3, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'id_type', '3': 4, '4': 1, '5': 14, '6': '.kyc.IDType', '10': 'idType'},
    const {'1': 'id_number', '3': 5, '4': 1, '5': 9, '10': 'idNumber'},
    const {'1': 'first_name', '3': 6, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 7, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'date_of_birth', '3': 8, '4': 1, '5': 9, '10': 'dateOfBirth'},
    const {'1': 'phone_number', '3': 9, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `CreateVerificationSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVerificationSessionRequestDescriptor = $convert.base64Decode('CiBDcmVhdGVWZXJpZmljYXRpb25TZXNzaW9uUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSLQoLdGFyZ2V0X3RpZXIYAiABKA4yDC5reWMuS1lDVGllclIKdGFyZ2V0VGllchIhCgxjb3VudHJ5X2NvZGUYAyABKAlSC2NvdW50cnlDb2RlEiQKB2lkX3R5cGUYBCABKA4yCy5reWMuSURUeXBlUgZpZFR5cGUSGwoJaWRfbnVtYmVyGAUgASgJUghpZE51bWJlchIdCgpmaXJzdF9uYW1lGAYgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAcgASgJUghsYXN0TmFtZRIiCg1kYXRlX29mX2JpcnRoGAggASgJUgtkYXRlT2ZCaXJ0aBIhCgxwaG9uZV9udW1iZXIYCSABKAlSC3Bob25lTnVtYmVy');
@$core.Deprecated('Use createVerificationSessionResponseDescriptor instead')
const CreateVerificationSessionResponse$json = const {
  '1': 'CreateVerificationSessionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'verification_id', '3': 2, '4': 1, '5': 9, '10': 'verificationId'},
    const {'1': 'session_url', '3': 3, '4': 1, '5': 9, '10': 'sessionUrl'},
    const {'1': 'session_token', '3': 4, '4': 1, '5': 9, '10': 'sessionToken'},
    const {'1': 'provider', '3': 5, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
    const {'1': 'error_message', '3': 7, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `CreateVerificationSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVerificationSessionResponseDescriptor = $convert.base64Decode('CiFDcmVhdGVWZXJpZmljYXRpb25TZXNzaW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxInCg92ZXJpZmljYXRpb25faWQYAiABKAlSDnZlcmlmaWNhdGlvbklkEh8KC3Nlc3Npb25fdXJsGAMgASgJUgpzZXNzaW9uVXJsEiMKDXNlc3Npb25fdG9rZW4YBCABKAlSDHNlc3Npb25Ub2tlbhIaCghwcm92aWRlchgFIAEoCVIIcHJvdmlkZXISJgoGc3RhdHVzGAYgASgOMg4ua3ljLktZQ1N0YXR1c1IGc3RhdHVzEiMKDWVycm9yX21lc3NhZ2UYByABKAlSDGVycm9yTWVzc2FnZQ==');
@$core.Deprecated('Use confirmVerificationRequestDescriptor instead')
const ConfirmVerificationRequest$json = const {
  '1': 'ConfirmVerificationRequest',
  '2': const [
    const {'1': 'verification_id', '3': 1, '4': 1, '5': 9, '10': 'verificationId'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_auth_code', '3': 3, '4': 1, '5': 9, '10': 'providerAuthCode'},
    const {'1': 'metadata', '3': 4, '4': 3, '5': 11, '6': '.kyc.ConfirmVerificationRequest.MetadataEntry', '10': 'metadata'},
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
final $typed_data.Uint8List confirmVerificationRequestDescriptor = $convert.base64Decode('ChpDb25maXJtVmVyaWZpY2F0aW9uUmVxdWVzdBInCg92ZXJpZmljYXRpb25faWQYASABKAlSDnZlcmlmaWNhdGlvbklkEhoKCHByb3ZpZGVyGAIgASgJUghwcm92aWRlchIsChJwcm92aWRlcl9hdXRoX2NvZGUYAyABKAlSEHByb3ZpZGVyQXV0aENvZGUSSQoIbWV0YWRhdGEYBCADKAsyLS5reWMuQ29uZmlybVZlcmlmaWNhdGlvblJlcXVlc3QuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use confirmVerificationResponseDescriptor instead')
const ConfirmVerificationResponse$json = const {
  '1': 'ConfirmVerificationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
    const {'1': 'current_tier', '3': 3, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'currentTier'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ConfirmVerificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmVerificationResponseDescriptor = $convert.base64Decode('ChtDb25maXJtVmVyaWZpY2F0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxImCgZzdGF0dXMYAiABKA4yDi5reWMuS1lDU3RhdHVzUgZzdGF0dXMSLwoMY3VycmVudF90aWVyGAMgASgOMgwua3ljLktZQ1RpZXJSC2N1cnJlbnRUaWVyEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
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
@$core.Deprecated('Use submitDocumentsForReviewRequestDescriptor instead')
const SubmitDocumentsForReviewRequest$json = const {
  '1': 'SubmitDocumentsForReviewRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'documents', '3': 2, '4': 3, '5': 11, '6': '.kyc.DocumentSubmission', '10': 'documents'},
  ],
};

/// Descriptor for `SubmitDocumentsForReviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitDocumentsForReviewRequestDescriptor = $convert.base64Decode('Ch9TdWJtaXREb2N1bWVudHNGb3JSZXZpZXdSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBI1Cglkb2N1bWVudHMYAiADKAsyFy5reWMuRG9jdW1lbnRTdWJtaXNzaW9uUglkb2N1bWVudHM=');
@$core.Deprecated('Use documentSubmissionDescriptor instead')
const DocumentSubmission$json = const {
  '1': 'DocumentSubmission',
  '2': const [
    const {'1': 'storage_key', '3': 1, '4': 1, '5': 9, '10': 'storageKey'},
    const {'1': 'document_type', '3': 2, '4': 1, '5': 9, '10': 'documentType'},
    const {'1': 'content_type', '3': 3, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `DocumentSubmission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List documentSubmissionDescriptor = $convert.base64Decode('ChJEb2N1bWVudFN1Ym1pc3Npb24SHwoLc3RvcmFnZV9rZXkYASABKAlSCnN0b3JhZ2VLZXkSIwoNZG9jdW1lbnRfdHlwZRgCIAEoCVIMZG9jdW1lbnRUeXBlEiEKDGNvbnRlbnRfdHlwZRgDIAEoCVILY29udGVudFR5cGU=');
@$core.Deprecated('Use submitDocumentsForReviewResponseDescriptor instead')
const SubmitDocumentsForReviewResponse$json = const {
  '1': 'SubmitDocumentsForReviewResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
  ],
};

/// Descriptor for `SubmitDocumentsForReviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List submitDocumentsForReviewResponseDescriptor = $convert.base64Decode('CiBTdWJtaXREb2N1bWVudHNGb3JSZXZpZXdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USJgoGc3RhdHVzGAMgASgOMg4ua3ljLktZQ1N0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use getPendingReviewsRequestDescriptor instead')
const GetPendingReviewsRequest$json = const {
  '1': 'GetPendingReviewsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetPendingReviewsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingReviewsRequestDescriptor = $convert.base64Decode('ChhHZXRQZW5kaW5nUmV2aWV3c1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getPendingReviewsResponseDescriptor instead')
const GetPendingReviewsResponse$json = const {
  '1': 'GetPendingReviewsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.kyc.PendingReviewItem', '10': 'items'},
    const {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPendingReviewsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingReviewsResponseDescriptor = $convert.base64Decode('ChlHZXRQZW5kaW5nUmV2aWV3c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSLAoFaXRlbXMYAiADKAsyFi5reWMuUGVuZGluZ1Jldmlld0l0ZW1SBWl0ZW1zEhQKBXRvdGFsGAMgASgFUgV0b3RhbA==');
@$core.Deprecated('Use pendingReviewItemDescriptor instead')
const PendingReviewItem$json = const {
  '1': 'PendingReviewItem',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_name', '3': 2, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'country_code', '3': 3, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'current_tier', '3': 4, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'currentTier'},
    const {'1': 'target_tier', '3': 5, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'targetTier'},
    const {'1': 'documents', '3': 6, '4': 3, '5': 11, '6': '.kyc.VerificationDocument', '10': 'documents'},
    const {'1': 'submitted_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'submittedAt'},
  ],
};

/// Descriptor for `PendingReviewItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingReviewItemDescriptor = $convert.base64Decode('ChFQZW5kaW5nUmV2aWV3SXRlbRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGwoJdXNlcl9uYW1lGAIgASgJUgh1c2VyTmFtZRIhCgxjb3VudHJ5X2NvZGUYAyABKAlSC2NvdW50cnlDb2RlEi8KDGN1cnJlbnRfdGllchgEIAEoDjIMLmt5Yy5LWUNUaWVyUgtjdXJyZW50VGllchItCgt0YXJnZXRfdGllchgFIAEoDjIMLmt5Yy5LWUNUaWVyUgp0YXJnZXRUaWVyEjcKCWRvY3VtZW50cxgGIAMoCzIZLmt5Yy5WZXJpZmljYXRpb25Eb2N1bWVudFIJZG9jdW1lbnRzEj0KDHN1Ym1pdHRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3N1Ym1pdHRlZEF0');
@$core.Deprecated('Use reviewDocumentRequestDescriptor instead')
const ReviewDocumentRequest$json = const {
  '1': 'ReviewDocumentRequest',
  '2': const [
    const {'1': 'document_id', '3': 1, '4': 1, '5': 9, '10': 'documentId'},
    const {'1': 'approved', '3': 2, '4': 1, '5': 8, '10': 'approved'},
    const {'1': 'rejection_reason', '3': 3, '4': 1, '5': 9, '10': 'rejectionReason'},
    const {'1': 'admin_notes', '3': 4, '4': 1, '5': 9, '10': 'adminNotes'},
  ],
};

/// Descriptor for `ReviewDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewDocumentRequestDescriptor = $convert.base64Decode('ChVSZXZpZXdEb2N1bWVudFJlcXVlc3QSHwoLZG9jdW1lbnRfaWQYASABKAlSCmRvY3VtZW50SWQSGgoIYXBwcm92ZWQYAiABKAhSCGFwcHJvdmVkEikKEHJlamVjdGlvbl9yZWFzb24YAyABKAlSD3JlamVjdGlvblJlYXNvbhIfCgthZG1pbl9ub3RlcxgEIAEoCVIKYWRtaW5Ob3Rlcw==');
@$core.Deprecated('Use reviewDocumentResponseDescriptor instead')
const ReviewDocumentResponse$json = const {
  '1': 'ReviewDocumentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ReviewDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewDocumentResponseDescriptor = $convert.base64Decode('ChZSZXZpZXdEb2N1bWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
