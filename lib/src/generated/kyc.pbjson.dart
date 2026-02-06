//
//  Generated code. Do not modify.
//  source: kyc.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use kYCTierDescriptor instead')
const KYCTier$json = {
  '1': 'KYCTier',
  '2': [
    {'1': 'TIER_UNKNOWN', '2': 0},
    {'1': 'TIER_1', '2': 1},
    {'1': 'TIER_2', '2': 2},
    {'1': 'TIER_3', '2': 3},
  ],
};

/// Descriptor for `KYCTier`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCTierDescriptor = $convert.base64Decode(
    'CgdLWUNUaWVyEhAKDFRJRVJfVU5LTk9XThAAEgoKBlRJRVJfMRABEgoKBlRJRVJfMhACEgoKBl'
    'RJRVJfMxAD');

@$core.Deprecated('Use kYCStatusDescriptor instead')
const KYCStatus$json = {
  '1': 'KYCStatus',
  '2': [
    {'1': 'STATUS_UNKNOWN', '2': 0},
    {'1': 'NOT_STARTED', '2': 1},
    {'1': 'IN_PROGRESS', '2': 2},
    {'1': 'PENDING_REVIEW', '2': 3},
    {'1': 'APPROVED', '2': 4},
    {'1': 'REJECTED', '2': 5},
    {'1': 'EXPIRED', '2': 6},
  ],
};

/// Descriptor for `KYCStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kYCStatusDescriptor = $convert.base64Decode(
    'CglLWUNTdGF0dXMSEgoOU1RBVFVTX1VOS05PV04QABIPCgtOT1RfU1RBUlRFRBABEg8KC0lOX1'
    'BST0dSRVNTEAISEgoOUEVORElOR19SRVZJRVcQAxIMCghBUFBST1ZFRBAEEgwKCFJFSkVDVEVE'
    'EAUSCwoHRVhQSVJFRBAG');

@$core.Deprecated('Use iDTypeDescriptor instead')
const IDType$json = {
  '1': 'IDType',
  '2': [
    {'1': 'ID_UNKNOWN', '2': 0},
    {'1': 'BVN', '2': 1},
    {'1': 'NIN', '2': 2},
    {'1': 'DRIVERS_LICENSE', '2': 3},
    {'1': 'INTERNATIONAL_PASSPORT', '2': 4},
    {'1': 'VOTERS_CARD', '2': 5},
    {'1': 'GHANA_CARD', '2': 10},
    {'1': 'KENYA_NATIONAL_ID', '2': 20},
    {'1': 'KRA_PIN', '2': 21},
    {'1': 'SA_ID_CARD', '2': 30},
    {'1': 'SA_PASSPORT', '2': 31},
    {'1': 'UK_PASSPORT', '2': 40},
    {'1': 'UK_DRIVING_LICENSE', '2': 41},
    {'1': 'US_SSN', '2': 50},
    {'1': 'US_STATE_ID', '2': 51},
    {'1': 'US_PASSPORT', '2': 52},
  ],
};

/// Descriptor for `IDType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List iDTypeDescriptor = $convert.base64Decode(
    'CgZJRFR5cGUSDgoKSURfVU5LTk9XThAAEgcKA0JWThABEgcKA05JThACEhMKD0RSSVZFUlNfTE'
    'lDRU5TRRADEhoKFklOVEVSTkFUSU9OQUxfUEFTU1BPUlQQBBIPCgtWT1RFUlNfQ0FSRBAFEg4K'
    'CkdIQU5BX0NBUkQQChIVChFLRU5ZQV9OQVRJT05BTF9JRBAUEgsKB0tSQV9QSU4QFRIOCgpTQV'
    '9JRF9DQVJEEB4SDwoLU0FfUEFTU1BPUlQQHxIPCgtVS19QQVNTUE9SVBAoEhYKElVLX0RSSVZJ'
    'TkdfTElDRU5TRRApEgoKBlVTX1NTThAyEg8KC1VTX1NUQVRFX0lEEDMSDwoLVVNfUEFTU1BPUl'
    'QQNA==');

@$core.Deprecated('Use documentStatusDescriptor instead')
const DocumentStatus$json = {
  '1': 'DocumentStatus',
  '2': [
    {'1': 'DOC_STATUS_UNKNOWN', '2': 0},
    {'1': 'DOC_PENDING_UPLOAD', '2': 1},
    {'1': 'DOC_UPLOADED', '2': 2},
    {'1': 'DOC_UNDER_REVIEW', '2': 3},
    {'1': 'DOC_APPROVED', '2': 4},
    {'1': 'DOC_REJECTED', '2': 5},
  ],
};

/// Descriptor for `DocumentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentStatusDescriptor = $convert.base64Decode(
    'Cg5Eb2N1bWVudFN0YXR1cxIWChJET0NfU1RBVFVTX1VOS05PV04QABIWChJET0NfUEVORElOR1'
    '9VUExPQUQQARIQCgxET0NfVVBMT0FERUQQAhIUChBET0NfVU5ERVJfUkVWSUVXEAMSEAoMRE9D'
    'X0FQUFJPVkVEEAQSEAoMRE9DX1JFSkVDVEVEEAU=');

@$core.Deprecated('Use countryKYCRequirementsDescriptor instead')
const CountryKYCRequirements$json = {
  '1': 'CountryKYCRequirements',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'accepted_id_types', '3': 2, '4': 3, '5': 14, '6': '.kyc.IDType', '10': 'acceptedIdTypes'},
    {'1': 'mandatory_id_types', '3': 3, '4': 3, '5': 14, '6': '.kyc.IDType', '10': 'mandatoryIdTypes'},
    {'1': 'address_proof_required', '3': 4, '4': 1, '5': 8, '10': 'addressProofRequired'},
    {'1': 'liveness_check_required', '3': 5, '4': 1, '5': 8, '10': 'livenessCheckRequired'},
    {'1': 'tier_1_daily_limit', '3': 6, '4': 1, '5': 3, '10': 'tier1DailyLimit'},
    {'1': 'tier_2_daily_limit', '3': 7, '4': 1, '5': 3, '10': 'tier2DailyLimit'},
    {'1': 'tier_3_daily_limit', '3': 8, '4': 1, '5': 3, '10': 'tier3DailyLimit'},
  ],
};

/// Descriptor for `CountryKYCRequirements`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countryKYCRequirementsDescriptor = $convert.base64Decode(
    'ChZDb3VudHJ5S1lDUmVxdWlyZW1lbnRzEiEKDGNvdW50cnlfY29kZRgBIAEoCVILY291bnRyeU'
    'NvZGUSNwoRYWNjZXB0ZWRfaWRfdHlwZXMYAiADKA4yCy5reWMuSURUeXBlUg9hY2NlcHRlZElk'
    'VHlwZXMSOQoSbWFuZGF0b3J5X2lkX3R5cGVzGAMgAygOMgsua3ljLklEVHlwZVIQbWFuZGF0b3'
    'J5SWRUeXBlcxI0ChZhZGRyZXNzX3Byb29mX3JlcXVpcmVkGAQgASgIUhRhZGRyZXNzUHJvb2ZS'
    'ZXF1aXJlZBI2ChdsaXZlbmVzc19jaGVja19yZXF1aXJlZBgFIAEoCFIVbGl2ZW5lc3NDaGVja1'
    'JlcXVpcmVkEisKEnRpZXJfMV9kYWlseV9saW1pdBgGIAEoA1IPdGllcjFEYWlseUxpbWl0EisK'
    'EnRpZXJfMl9kYWlseV9saW1pdBgHIAEoA1IPdGllcjJEYWlseUxpbWl0EisKEnRpZXJfM19kYW'
    'lseV9saW1pdBgIIAEoA1IPdGllcjNEYWlseUxpbWl0');

@$core.Deprecated('Use kYCTierInfoDescriptor instead')
const KYCTierInfo$json = {
  '1': 'KYCTierInfo',
  '2': [
    {'1': 'tier', '3': 1, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'tier'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'benefits', '3': 5, '4': 3, '5': 9, '10': 'benefits'},
    {'1': 'daily_transaction_limit', '3': 6, '4': 1, '5': 3, '10': 'dailyTransactionLimit'},
    {'1': 'daily_receive_limit', '3': 7, '4': 1, '5': 3, '10': 'dailyReceiveLimit'},
    {'1': 'max_balance', '3': 8, '4': 1, '5': 3, '10': 'maxBalance'},
    {'1': 'verified_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
    {'1': 'expires_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    {'1': 'is_current', '3': 11, '4': 1, '5': 8, '10': 'isCurrent'},
    {'1': 'is_locked', '3': 12, '4': 1, '5': 8, '10': 'isLocked'},
  ],
};

/// Descriptor for `KYCTierInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kYCTierInfoDescriptor = $convert.base64Decode(
    'CgtLWUNUaWVySW5mbxIgCgR0aWVyGAEgASgOMgwua3ljLktZQ1RpZXJSBHRpZXISJgoGc3RhdH'
    'VzGAIgASgOMg4ua3ljLktZQ1N0YXR1c1IGc3RhdHVzEiEKDGRpc3BsYXlfbmFtZRgDIAEoCVIL'
    'ZGlzcGxheU5hbWUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhoKCGJlbmVmaX'
    'RzGAUgAygJUghiZW5lZml0cxI2ChdkYWlseV90cmFuc2FjdGlvbl9saW1pdBgGIAEoA1IVZGFp'
    'bHlUcmFuc2FjdGlvbkxpbWl0Ei4KE2RhaWx5X3JlY2VpdmVfbGltaXQYByABKANSEWRhaWx5Um'
    'VjZWl2ZUxpbWl0Eh8KC21heF9iYWxhbmNlGAggASgDUgptYXhCYWxhbmNlEjsKC3ZlcmlmaWVk'
    'X2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdmVyaWZpZWRBdBI5CgpleH'
    'BpcmVzX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZXhwaXJlc0F0Eh0K'
    'CmlzX2N1cnJlbnQYCyABKAhSCWlzQ3VycmVudBIbCglpc19sb2NrZWQYDCABKAhSCGlzTG9ja2'
    'Vk');

@$core.Deprecated('Use verifyIDRequestDescriptor instead')
const VerifyIDRequest$json = {
  '1': 'VerifyIDRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'id_type', '3': 2, '4': 1, '5': 14, '6': '.kyc.IDType', '10': 'idType'},
    {'1': 'id_number', '3': 3, '4': 1, '5': 9, '10': 'idNumber'},
    {'1': 'first_name', '3': 4, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 5, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'date_of_birth', '3': 6, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `VerifyIDRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIDRequestDescriptor = $convert.base64Decode(
    'Cg9WZXJpZnlJRFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiQKB2lkX3R5cGUYAi'
    'ABKA4yCy5reWMuSURUeXBlUgZpZFR5cGUSGwoJaWRfbnVtYmVyGAMgASgJUghpZE51bWJlchId'
    'CgpmaXJzdF9uYW1lGAQgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAUgASgJUghsYXN0Tm'
    'FtZRIiCg1kYXRlX29mX2JpcnRoGAYgASgJUgtkYXRlT2ZCaXJ0aBIhCgxwaG9uZV9udW1iZXIY'
    'ByABKAlSC3Bob25lTnVtYmVy');

@$core.Deprecated('Use uploadDocumentRequestDescriptor instead')
const UploadDocumentRequest$json = {
  '1': 'UploadDocumentRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'document_type', '3': 2, '4': 1, '5': 14, '6': '.kyc.IDType', '10': 'documentType'},
    {'1': 'document_front_url', '3': 3, '4': 1, '5': 9, '10': 'documentFrontUrl'},
    {'1': 'document_back_url', '3': 4, '4': 1, '5': 9, '10': 'documentBackUrl'},
    {'1': 'selfie_url', '3': 5, '4': 1, '5': 9, '10': 'selfieUrl'},
    {'1': 'proof_of_address_url', '3': 6, '4': 1, '5': 9, '10': 'proofOfAddressUrl'},
  ],
};

/// Descriptor for `UploadDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadDocumentRequestDescriptor = $convert.base64Decode(
    'ChVVcGxvYWREb2N1bWVudFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEjAKDWRvY3'
    'VtZW50X3R5cGUYAiABKA4yCy5reWMuSURUeXBlUgxkb2N1bWVudFR5cGUSLAoSZG9jdW1lbnRf'
    'ZnJvbnRfdXJsGAMgASgJUhBkb2N1bWVudEZyb250VXJsEioKEWRvY3VtZW50X2JhY2tfdXJsGA'
    'QgASgJUg9kb2N1bWVudEJhY2tVcmwSHQoKc2VsZmllX3VybBgFIAEoCVIJc2VsZmllVXJsEi8K'
    'FHByb29mX29mX2FkZHJlc3NfdXJsGAYgASgJUhFwcm9vZk9mQWRkcmVzc1VybA==');

@$core.Deprecated('Use verifyIDResponseDescriptor instead')
const VerifyIDResponse$json = {
  '1': 'VerifyIDResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
    {'1': 'current_tier', '3': 4, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'currentTier'},
    {'1': 'verified_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
    {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `VerifyIDResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyIDResponseDescriptor = $convert.base64Decode(
    'ChBWZXJpZnlJRFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZR'
    'gCIAEoCVIHbWVzc2FnZRImCgZzdGF0dXMYAyABKA4yDi5reWMuS1lDU3RhdHVzUgZzdGF0dXMS'
    'LwoMY3VycmVudF90aWVyGAQgASgOMgwua3ljLktZQ1RpZXJSC2N1cnJlbnRUaWVyEjsKC3Zlcm'
    'lmaWVkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdmVyaWZpZWRBdBIc'
    'CglyZWZlcmVuY2UYBiABKAlSCXJlZmVyZW5jZQ==');

@$core.Deprecated('Use getKYCStatusRequestDescriptor instead')
const GetKYCStatusRequest$json = {
  '1': 'GetKYCStatusRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetKYCStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCStatusRequestDescriptor = $convert.base64Decode(
    'ChNHZXRLWUNTdGF0dXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use getKYCStatusResponseDescriptor instead')
const GetKYCStatusResponse$json = {
  '1': 'GetKYCStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCStatus', '10': 'status'},
    {'1': 'current_tier', '3': 3, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'currentTier'},
    {'1': 'tier_info', '3': 4, '4': 3, '5': 11, '6': '.kyc.KYCTierInfo', '10': 'tierInfo'},
    {'1': 'last_updated', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    {'1': 'rejection_reason', '3': 6, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `GetKYCStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getKYCStatusResponseDescriptor = $convert.base64Decode(
    'ChRHZXRLWUNTdGF0dXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiYKBnN0YX'
    'R1cxgCIAEoDjIOLmt5Yy5LWUNTdGF0dXNSBnN0YXR1cxIvCgxjdXJyZW50X3RpZXIYAyABKA4y'
    'DC5reWMuS1lDVGllclILY3VycmVudFRpZXISLQoJdGllcl9pbmZvGAQgAygLMhAua3ljLktZQ1'
    'RpZXJJbmZvUgh0aWVySW5mbxI9CgxsYXN0X3VwZGF0ZWQYBSABKAsyGi5nb29nbGUucHJvdG9i'
    'dWYuVGltZXN0YW1wUgtsYXN0VXBkYXRlZBIpChByZWplY3Rpb25fcmVhc29uGAYgASgJUg9yZW'
    'plY3Rpb25SZWFzb24=');

@$core.Deprecated('Use skipKYCRequestDescriptor instead')
const SkipKYCRequest$json = {
  '1': 'SkipKYCRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'skip_tier_2', '3': 2, '4': 1, '5': 8, '10': 'skipTier2'},
  ],
};

/// Descriptor for `SkipKYCRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCRequestDescriptor = $convert.base64Decode(
    'Cg5Ta2lwS1lDUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSHgoLc2tpcF90aWVyXz'
    'IYAiABKAhSCXNraXBUaWVyMg==');

@$core.Deprecated('Use skipKYCResponseDescriptor instead')
const SkipKYCResponse$json = {
  '1': 'SkipKYCResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'assigned_tier', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'assignedTier'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'next_steps', '3': 4, '4': 3, '5': 9, '10': 'nextSteps'},
  ],
};

/// Descriptor for `SkipKYCResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipKYCResponseDescriptor = $convert.base64Decode(
    'Cg9Ta2lwS1lDUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIxCg1hc3NpZ25lZF'
    '90aWVyGAIgASgOMgwua3ljLktZQ1RpZXJSDGFzc2lnbmVkVGllchIYCgdtZXNzYWdlGAMgASgJ'
    'UgdtZXNzYWdlEh0KCm5leHRfc3RlcHMYBCADKAlSCW5leHRTdGVwcw==');

@$core.Deprecated('Use getCountryRequirementsRequestDescriptor instead')
const GetCountryRequirementsRequest$json = {
  '1': 'GetCountryRequirementsRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetCountryRequirementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRequirementsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRDb3VudHJ5UmVxdWlyZW1lbnRzUmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2'
    'NvdW50cnlDb2Rl');

@$core.Deprecated('Use getCountryRequirementsResponseDescriptor instead')
const GetCountryRequirementsResponse$json = {
  '1': 'GetCountryRequirementsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'requirements', '3': 2, '4': 1, '5': 11, '6': '.kyc.CountryKYCRequirements', '10': 'requirements'},
  ],
};

/// Descriptor for `GetCountryRequirementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCountryRequirementsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRDb3VudHJ5UmVxdWlyZW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
    'VzcxI/CgxyZXF1aXJlbWVudHMYAiABKAsyGy5reWMuQ291bnRyeUtZQ1JlcXVpcmVtZW50c1IM'
    'cmVxdWlyZW1lbnRz');

@$core.Deprecated('Use initiateKYCRequestDescriptor instead')
const InitiateKYCRequest$json = {
  '1': 'InitiateKYCRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'target_tier', '3': 2, '4': 1, '5': 14, '6': '.kyc.KYCTier', '10': 'targetTier'},
  ],
};

/// Descriptor for `InitiateKYCRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCRequestDescriptor = $convert.base64Decode(
    'ChJJbml0aWF0ZUtZQ1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEi0KC3RhcmdldF'
    '90aWVyGAIgASgOMgwua3ljLktZQ1RpZXJSCnRhcmdldFRpZXI=');

@$core.Deprecated('Use initiateKYCResponseDescriptor instead')
const InitiateKYCResponse$json = {
  '1': 'InitiateKYCResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'required_documents', '3': 3, '4': 3, '5': 9, '10': 'requiredDocuments'},
    {'1': 'required_fields', '3': 4, '4': 3, '5': 9, '10': 'requiredFields'},
    {'1': 'redirect_url', '3': 5, '4': 1, '5': 9, '10': 'redirectUrl'},
  ],
};

/// Descriptor for `InitiateKYCResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateKYCResponseDescriptor = $convert.base64Decode(
    'ChNJbml0aWF0ZUtZQ1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKc2Vzc2'
    'lvbl9pZBgCIAEoCVIJc2Vzc2lvbklkEi0KEnJlcXVpcmVkX2RvY3VtZW50cxgDIAMoCVIRcmVx'
    'dWlyZWREb2N1bWVudHMSJwoPcmVxdWlyZWRfZmllbGRzGAQgAygJUg5yZXF1aXJlZEZpZWxkcx'
    'IhCgxyZWRpcmVjdF91cmwYBSABKAlSC3JlZGlyZWN0VXJs');

@$core.Deprecated('Use verificationDocumentDescriptor instead')
const VerificationDocument$json = {
  '1': 'VerificationDocument',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'document_type', '3': 2, '4': 1, '5': 14, '6': '.kyc.IDType', '10': 'documentType'},
    {'1': 'document_url', '3': 3, '4': 1, '5': 9, '10': 'documentUrl'},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.kyc.DocumentStatus', '10': 'status'},
    {'1': 'uploaded_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'uploadedAt'},
    {'1': 'verified_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'verifiedAt'},
    {'1': 'rejection_reason', '3': 7, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `VerificationDocument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verificationDocumentDescriptor = $convert.base64Decode(
    'ChRWZXJpZmljYXRpb25Eb2N1bWVudBIOCgJpZBgBIAEoCVICaWQSMAoNZG9jdW1lbnRfdHlwZR'
    'gCIAEoDjILLmt5Yy5JRFR5cGVSDGRvY3VtZW50VHlwZRIhCgxkb2N1bWVudF91cmwYAyABKAlS'
    'C2RvY3VtZW50VXJsEisKBnN0YXR1cxgEIAEoDjITLmt5Yy5Eb2N1bWVudFN0YXR1c1IGc3RhdH'
    'VzEjsKC3VwbG9hZGVkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKdXBs'
    'b2FkZWRBdBI7Cgt2ZXJpZmllZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbX'
    'BSCnZlcmlmaWVkQXQSKQoQcmVqZWN0aW9uX3JlYXNvbhgHIAEoCVIPcmVqZWN0aW9uUmVhc29u');

@$core.Deprecated('Use getUserDocumentsRequestDescriptor instead')
const GetUserDocumentsRequest$json = {
  '1': 'GetUserDocumentsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserDocumentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyRG9jdW1lbnRzUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use getUserDocumentsResponseDescriptor instead')
const GetUserDocumentsResponse$json = {
  '1': 'GetUserDocumentsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'documents', '3': 2, '4': 3, '5': 11, '6': '.kyc.VerificationDocument', '10': 'documents'},
  ],
};

/// Descriptor for `GetUserDocumentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDocumentsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VyRG9jdW1lbnRzUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxI3Cg'
    'lkb2N1bWVudHMYAiADKAsyGS5reWMuVmVyaWZpY2F0aW9uRG9jdW1lbnRSCWRvY3VtZW50cw==');

