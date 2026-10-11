// This is a generated file - do not edit.
//
// Generated from rmb.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use rmbRailDescriptor instead')
const RmbRail$json = {
  '1': 'RmbRail',
  '2': [
    {'1': 'RAIL_UNSPECIFIED', '2': 0},
    {'1': 'ALIPAY', '2': 1},
    {'1': 'WECHAT', '2': 2},
    {'1': 'UNIONPAY', '2': 3},
    {'1': 'BANK', '2': 4},
  ],
};

/// Descriptor for `RmbRail`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List rmbRailDescriptor = $convert.base64Decode(
    'CgdSbWJSYWlsEhQKEFJBSUxfVU5TUEVDSUZJRUQQABIKCgZBTElQQVkQARIKCgZXRUNIQVQQAh'
    'IMCghVTklPTlBBWRADEggKBEJBTksQBA==');

@$core.Deprecated('Use rmbStatusDescriptor instead')
const RmbStatus$json = {
  '1': 'RmbStatus',
  '2': [
    {'1': 'RMB_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'RMB_PENDING', '2': 1},
    {'1': 'RMB_PROCESSING', '2': 2},
    {'1': 'RMB_COMPLETED', '2': 3},
    {'1': 'RMB_FAILED', '2': 4},
    {'1': 'RMB_REFUNDED', '2': 5},
    {'1': 'RMB_PENDING_COMPLIANCE', '2': 6},
    {'1': 'RMB_CANCELLED', '2': 7},
  ],
};

/// Descriptor for `RmbStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List rmbStatusDescriptor = $convert.base64Decode(
    'CglSbWJTdGF0dXMSGgoWUk1CX1NUQVRVU19VTlNQRUNJRklFRBAAEg8KC1JNQl9QRU5ESU5HEA'
    'ESEgoOUk1CX1BST0NFU1NJTkcQAhIRCg1STUJfQ09NUExFVEVEEAMSDgoKUk1CX0ZBSUxFRBAE'
    'EhAKDFJNQl9SRUZVTkRFRBAFEhoKFlJNQl9QRU5ESU5HX0NPTVBMSUFOQ0UQBhIRCg1STUJfQ0'
    'FOQ0VMTEVEEAc=');

@$core.Deprecated('Use getProviderConfigRequestDescriptor instead')
const GetProviderConfigRequest$json = {
  '1': 'GetProviderConfigRequest',
};

/// Descriptor for `GetProviderConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProviderConfigRequestDescriptor =
    $convert.base64Decode('ChhHZXRQcm92aWRlckNvbmZpZ1JlcXVlc3Q=');

@$core.Deprecated('Use railStatusDescriptor instead')
const RailStatus$json = {
  '1': 'RailStatus',
  '2': [
    {'1': 'rail', '3': 1, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    {'1': 'enabled', '3': 2, '4': 1, '5': 8, '10': 'enabled'},
    {'1': 'min_amount_minor', '3': 3, '4': 1, '5': 3, '10': 'minAmountMinor'},
    {'1': 'max_amount_minor', '3': 4, '4': 1, '5': 3, '10': 'maxAmountMinor'},
  ],
};

/// Descriptor for `RailStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List railStatusDescriptor = $convert.base64Decode(
    'CgpSYWlsU3RhdHVzEiAKBHJhaWwYASABKA4yDC5ybWIuUm1iUmFpbFIEcmFpbBIYCgdlbmFibG'
    'VkGAIgASgIUgdlbmFibGVkEigKEG1pbl9hbW91bnRfbWlub3IYAyABKANSDm1pbkFtb3VudE1p'
    'bm9yEigKEG1heF9hbW91bnRfbWlub3IYBCABKANSDm1heEFtb3VudE1pbm9y');

@$core.Deprecated('Use rateTierDescriptor instead')
const RateTier$json = {
  '1': 'RateTier',
  '2': [
    {'1': 'min_cny_minor', '3': 1, '4': 1, '5': 3, '10': 'minCnyMinor'},
    {'1': 'margin_percent', '3': 2, '4': 1, '5': 1, '10': 'marginPercent'},
    {'1': 'ngn_per_cny', '3': 3, '4': 1, '5': 1, '10': 'ngnPerCny'},
  ],
};

/// Descriptor for `RateTier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rateTierDescriptor = $convert.base64Decode(
    'CghSYXRlVGllchIiCg1taW5fY255X21pbm9yGAEgASgDUgttaW5DbnlNaW5vchIlCg5tYXJnaW'
    '5fcGVyY2VudBgCIAEoAVINbWFyZ2luUGVyY2VudBIeCgtuZ25fcGVyX2NueRgDIAEoAVIJbmdu'
    'UGVyQ255');

@$core.Deprecated('Use providerConfigResponseDescriptor instead')
const ProviderConfigResponse$json = {
  '1': 'ProviderConfigResponse',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {
      '1': 'rails',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.rmb.RailStatus',
      '10': 'rails'
    },
    {'1': 'maintenance', '3': 3, '4': 1, '5': 8, '10': 'maintenance'},
    {
      '1': 'maintenance_message',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'maintenanceMessage'
    },
    {
      '1': 'indicative_fx_rate',
      '3': 5,
      '4': 1,
      '5': 1,
      '10': 'indicativeFxRate'
    },
    {
      '1': 'rate_tiers',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.rmb.RateTier',
      '10': 'rateTiers'
    },
  ],
};

/// Descriptor for `ProviderConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerConfigResponseDescriptor = $convert.base64Decode(
    'ChZQcm92aWRlckNvbmZpZ1Jlc3BvbnNlEhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIlCg'
    'VyYWlscxgCIAMoCzIPLnJtYi5SYWlsU3RhdHVzUgVyYWlscxIgCgttYWludGVuYW5jZRgDIAEo'
    'CFILbWFpbnRlbmFuY2USLwoTbWFpbnRlbmFuY2VfbWVzc2FnZRgEIAEoCVISbWFpbnRlbmFuY2'
    'VNZXNzYWdlEiwKEmluZGljYXRpdmVfZnhfcmF0ZRgFIAEoAVIQaW5kaWNhdGl2ZUZ4UmF0ZRIs'
    'CgpyYXRlX3RpZXJzGAYgAygLMg0ucm1iLlJhdGVUaWVyUglyYXRlVGllcnM=');

@$core.Deprecated('Use resolveBanksRequestDescriptor instead')
const ResolveBanksRequest$json = {
  '1': 'ResolveBanksRequest',
  '2': [
    {'1': 'rail', '3': 1, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
  ],
};

/// Descriptor for `ResolveBanksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveBanksRequestDescriptor = $convert.base64Decode(
    'ChNSZXNvbHZlQmFua3NSZXF1ZXN0EiAKBHJhaWwYASABKA4yDC5ybWIuUm1iUmFpbFIEcmFpbA'
    '==');

@$core.Deprecated('Use bankDescriptor instead')
const Bank$json = {
  '1': 'Bank',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Bank`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankDescriptor = $convert.base64Decode(
    'CgRCYW5rEhIKBGNvZGUYASABKAlSBGNvZGUSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use resolveBanksResponseDescriptor instead')
const ResolveBanksResponse$json = {
  '1': 'ResolveBanksResponse',
  '2': [
    {'1': 'banks', '3': 1, '4': 3, '5': 11, '6': '.rmb.Bank', '10': 'banks'},
  ],
};

/// Descriptor for `ResolveBanksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveBanksResponseDescriptor = $convert.base64Decode(
    'ChRSZXNvbHZlQmFua3NSZXNwb25zZRIfCgViYW5rcxgBIAMoCzIJLnJtYi5CYW5rUgViYW5rcw'
    '==');

@$core.Deprecated('Use getQuoteRequestDescriptor instead')
const GetQuoteRequest$json = {
  '1': 'GetQuoteRequest',
  '2': [
    {'1': 'rail', '3': 1, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    {'1': 'cny_amount_minor', '3': 2, '4': 1, '5': 3, '10': 'cnyAmountMinor'},
  ],
};

/// Descriptor for `GetQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQuoteRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRRdW90ZVJlcXVlc3QSIAoEcmFpbBgBIAEoDjIMLnJtYi5SbWJSYWlsUgRyYWlsEigKEG'
    'NueV9hbW91bnRfbWlub3IYAiABKANSDmNueUFtb3VudE1pbm9y');

@$core.Deprecated('Use quoteResponseDescriptor instead')
const QuoteResponse$json = {
  '1': 'QuoteResponse',
  '2': [
    {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'rail', '3': 3, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    {'1': 'fx_rate', '3': 4, '4': 1, '5': 1, '10': 'fxRate'},
    {'1': 'dest_amount_minor', '3': 5, '4': 1, '5': 3, '10': 'destAmountMinor'},
    {
      '1': 'source_amount_minor',
      '3': 6,
      '4': 1,
      '5': 3,
      '10': 'sourceAmountMinor'
    },
    {
      '1': 'provider_fee_minor',
      '3': 7,
      '4': 1,
      '5': 3,
      '10': 'providerFeeMinor'
    },
    {'1': 'our_fee_minor', '3': 8, '4': 1, '5': 3, '10': 'ourFeeMinor'},
    {'1': 'total_minor', '3': 9, '4': 1, '5': 3, '10': 'totalMinor'},
    {
      '1': 'expires_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expiresAt'
    },
  ],
};

/// Descriptor for `QuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteResponseDescriptor = $convert.base64Decode(
    'Cg1RdW90ZVJlc3BvbnNlEhkKCHF1b3RlX2lkGAEgASgJUgdxdW90ZUlkEhoKCHByb3ZpZGVyGA'
    'IgASgJUghwcm92aWRlchIgCgRyYWlsGAMgASgOMgwucm1iLlJtYlJhaWxSBHJhaWwSFwoHZnhf'
    'cmF0ZRgEIAEoAVIGZnhSYXRlEioKEWRlc3RfYW1vdW50X21pbm9yGAUgASgDUg9kZXN0QW1vdW'
    '50TWlub3ISLgoTc291cmNlX2Ftb3VudF9taW5vchgGIAEoA1IRc291cmNlQW1vdW50TWlub3IS'
    'LAoScHJvdmlkZXJfZmVlX21pbm9yGAcgASgDUhBwcm92aWRlckZlZU1pbm9yEiIKDW91cl9mZW'
    'VfbWlub3IYCCABKANSC291ckZlZU1pbm9yEh8KC3RvdGFsX21pbm9yGAkgASgDUgp0b3RhbE1p'
    'bm9yEjkKCmV4cGlyZXNfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleH'
    'BpcmVzQXQ=');

@$core.Deprecated('Use beneficiaryDescriptor instead')
const Beneficiary$json = {
  '1': 'Beneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'rail', '3': 2, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'favourite', '3': 4, '4': 1, '5': 8, '10': 'favourite'},
    {'1': 'account_id', '3': 10, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'account_id_type', '3': 11, '4': 1, '5': 9, '10': 'accountIdType'},
    {'1': 'account_number', '3': 12, '4': 1, '5': 9, '10': 'accountNumber'},
    {
      '1': 'receiver_first_name',
      '3': 20,
      '4': 1,
      '5': 9,
      '10': 'receiverFirstName'
    },
    {
      '1': 'receiver_last_name',
      '3': 21,
      '4': 1,
      '5': 9,
      '10': 'receiverLastName'
    },
    {
      '1': 'receiver_id_number',
      '3': 22,
      '4': 1,
      '5': 9,
      '10': 'receiverIdNumber'
    },
    {'1': 'receiver_id_type', '3': 23, '4': 1, '5': 9, '10': 'receiverIdType'},
    {'1': 'receiver_mobile', '3': 24, '4': 1, '5': 9, '10': 'receiverMobile'},
    {
      '1': 'receiver_relationship',
      '3': 25,
      '4': 1,
      '5': 9,
      '10': 'receiverRelationship'
    },
    {'1': 'card_number', '3': 30, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'card_holder_name', '3': 31, '4': 1, '5': 9, '10': 'cardHolderName'},
    {'1': 'account_name', '3': 40, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'account_type', '3': 41, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'bank_code', '3': 42, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 43, '4': 1, '5': 9, '10': 'bankName'},
    {
      '1': 'last_used_at',
      '3': 50,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastUsedAt'
    },
  ],
};

/// Descriptor for `Beneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beneficiaryDescriptor = $convert.base64Decode(
    'CgtCZW5lZmljaWFyeRIOCgJpZBgBIAEoCVICaWQSIAoEcmFpbBgCIAEoDjIMLnJtYi5SbWJSYW'
    'lsUgRyYWlsEiEKDGRpc3BsYXlfbmFtZRgDIAEoCVILZGlzcGxheU5hbWUSHAoJZmF2b3VyaXRl'
    'GAQgASgIUglmYXZvdXJpdGUSHQoKYWNjb3VudF9pZBgKIAEoCVIJYWNjb3VudElkEiYKD2FjY2'
    '91bnRfaWRfdHlwZRgLIAEoCVINYWNjb3VudElkVHlwZRIlCg5hY2NvdW50X251bWJlchgMIAEo'
    'CVINYWNjb3VudE51bWJlchIuChNyZWNlaXZlcl9maXJzdF9uYW1lGBQgASgJUhFyZWNlaXZlck'
    'ZpcnN0TmFtZRIsChJyZWNlaXZlcl9sYXN0X25hbWUYFSABKAlSEHJlY2VpdmVyTGFzdE5hbWUS'
    'LAoScmVjZWl2ZXJfaWRfbnVtYmVyGBYgASgJUhByZWNlaXZlcklkTnVtYmVyEigKEHJlY2Vpdm'
    'VyX2lkX3R5cGUYFyABKAlSDnJlY2VpdmVySWRUeXBlEicKD3JlY2VpdmVyX21vYmlsZRgYIAEo'
    'CVIOcmVjZWl2ZXJNb2JpbGUSMwoVcmVjZWl2ZXJfcmVsYXRpb25zaGlwGBkgASgJUhRyZWNlaX'
    'ZlclJlbGF0aW9uc2hpcBIfCgtjYXJkX251bWJlchgeIAEoCVIKY2FyZE51bWJlchIoChBjYXJk'
    'X2hvbGRlcl9uYW1lGB8gASgJUg5jYXJkSG9sZGVyTmFtZRIhCgxhY2NvdW50X25hbWUYKCABKA'
    'lSC2FjY291bnROYW1lEiEKDGFjY291bnRfdHlwZRgpIAEoCVILYWNjb3VudFR5cGUSGwoJYmFu'
    'a19jb2RlGCogASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYKyABKAlSCGJhbmtOYW1lEjwKDG'
    'xhc3RfdXNlZF9hdBgyIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmxhc3RVc2Vk'
    'QXQ=');

@$core.Deprecated('Use listBeneficiariesRequestDescriptor instead')
const ListBeneficiariesRequest$json = {
  '1': 'ListBeneficiariesRequest',
  '2': [
    {'1': 'rail', '3': 1, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
  ],
};

/// Descriptor for `ListBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBeneficiariesRequestDescriptor =
    $convert.base64Decode(
        'ChhMaXN0QmVuZWZpY2lhcmllc1JlcXVlc3QSIAoEcmFpbBgBIAEoDjIMLnJtYi5SbWJSYWlsUg'
        'RyYWls');

@$core.Deprecated('Use listBeneficiariesResponseDescriptor instead')
const ListBeneficiariesResponse$json = {
  '1': 'ListBeneficiariesResponse',
  '2': [
    {
      '1': 'beneficiaries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.rmb.Beneficiary',
      '10': 'beneficiaries'
    },
  ],
};

/// Descriptor for `ListBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBeneficiariesResponseDescriptor =
    $convert.base64Decode(
        'ChlMaXN0QmVuZWZpY2lhcmllc1Jlc3BvbnNlEjYKDWJlbmVmaWNpYXJpZXMYASADKAsyEC5ybW'
        'IuQmVuZWZpY2lhcnlSDWJlbmVmaWNpYXJpZXM=');

@$core.Deprecated('Use saveBeneficiaryRequestDescriptor instead')
const SaveBeneficiaryRequest$json = {
  '1': 'SaveBeneficiaryRequest',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.Beneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `SaveBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'ChZTYXZlQmVuZWZpY2lhcnlSZXF1ZXN0EjIKC2JlbmVmaWNpYXJ5GAEgASgLMhAucm1iLkJlbm'
        'VmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');

@$core.Deprecated('Use saveBeneficiaryResponseDescriptor instead')
const SaveBeneficiaryResponse$json = {
  '1': 'SaveBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.Beneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `SaveBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'ChdTYXZlQmVuZWZpY2lhcnlSZXNwb25zZRIyCgtiZW5lZmljaWFyeRgBIAEoCzIQLnJtYi5CZW'
        '5lZmljaWFyeVILYmVuZWZpY2lhcnk=');

@$core.Deprecated('Use updateBeneficiaryRequestDescriptor instead')
const UpdateBeneficiaryRequest$json = {
  '1': 'UpdateBeneficiaryRequest',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.Beneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `UpdateBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'ChhVcGRhdGVCZW5lZmljaWFyeVJlcXVlc3QSMgoLYmVuZWZpY2lhcnkYASABKAsyEC5ybWIuQm'
        'VuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5');

@$core.Deprecated('Use updateBeneficiaryResponseDescriptor instead')
const UpdateBeneficiaryResponse$json = {
  '1': 'UpdateBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.Beneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `UpdateBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'ChlVcGRhdGVCZW5lZmljaWFyeVJlc3BvbnNlEjIKC2JlbmVmaWNpYXJ5GAEgASgLMhAucm1iLk'
        'JlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');

@$core.Deprecated('Use deleteBeneficiaryRequestDescriptor instead')
const DeleteBeneficiaryRequest$json = {
  '1': 'DeleteBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBeneficiaryRequestDescriptor = $convert
    .base64Decode('ChhEZWxldGVCZW5lZmljaWFyeVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use deleteBeneficiaryResponseDescriptor instead')
const DeleteBeneficiaryResponse$json = {
  '1': 'DeleteBeneficiaryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'ChlEZWxldGVCZW5lZmljaWFyeVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');

@$core.Deprecated('Use favouriteBeneficiaryRequestDescriptor instead')
const FavouriteBeneficiaryRequest$json = {
  '1': 'FavouriteBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'favourite', '3': 2, '4': 1, '5': 8, '10': 'favourite'},
  ],
};

/// Descriptor for `FavouriteBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List favouriteBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'ChtGYXZvdXJpdGVCZW5lZmljaWFyeVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEhwKCWZhdm91cm'
        'l0ZRgCIAEoCFIJZmF2b3VyaXRl');

@$core.Deprecated('Use favouriteBeneficiaryResponseDescriptor instead')
const FavouriteBeneficiaryResponse$json = {
  '1': 'FavouriteBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.Beneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `FavouriteBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List favouriteBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'ChxGYXZvdXJpdGVCZW5lZmljaWFyeVJlc3BvbnNlEjIKC2JlbmVmaWNpYXJ5GAEgASgLMhAucm'
        '1iLkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');

@$core.Deprecated('Use addressDescriptor instead')
const Address$json = {
  '1': 'Address',
  '2': [
    {'1': 'city', '3': 1, '4': 1, '5': 9, '10': 'city'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'postcode', '3': 3, '4': 1, '5': 9, '10': 'postcode'},
    {'1': 'state', '3': 4, '4': 1, '5': 9, '10': 'state'},
    {'1': 'street_address', '3': 5, '4': 1, '5': 9, '10': 'streetAddress'},
  ],
};

/// Descriptor for `Address`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressDescriptor = $convert.base64Decode(
    'CgdBZGRyZXNzEhIKBGNpdHkYASABKAlSBGNpdHkSIQoMY291bnRyeV9jb2RlGAIgASgJUgtjb3'
    'VudHJ5Q29kZRIaCghwb3N0Y29kZRgDIAEoCVIIcG9zdGNvZGUSFAoFc3RhdGUYBCABKAlSBXN0'
    'YXRlEiUKDnN0cmVldF9hZGRyZXNzGAUgASgJUg1zdHJlZXRBZGRyZXNz');

@$core.Deprecated('Use complianceProfileDescriptor instead')
const ComplianceProfile$json = {
  '1': 'ComplianceProfile',
  '2': [
    {'1': 'sender_first_name', '3': 1, '4': 1, '5': 9, '10': 'senderFirstName'},
    {'1': 'sender_last_name', '3': 2, '4': 1, '5': 9, '10': 'senderLastName'},
    {'1': 'sender_id_number', '3': 3, '4': 1, '5': 9, '10': 'senderIdNumber'},
    {'1': 'sender_id_type', '3': 4, '4': 1, '5': 9, '10': 'senderIdType'},
    {
      '1': 'sender_nationality',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'senderNationality'
    },
    {'1': 'sender_birth_date', '3': 6, '4': 1, '5': 9, '10': 'senderBirthDate'},
    {
      '1': 'sender_address',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.rmb.Address',
      '10': 'senderAddress'
    },
    {'1': 'complete', '3': 8, '4': 1, '5': 8, '10': 'complete'},
    {'1': 'locked_fields', '3': 9, '4': 3, '5': 9, '10': 'lockedFields'},
  ],
};

/// Descriptor for `ComplianceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List complianceProfileDescriptor = $convert.base64Decode(
    'ChFDb21wbGlhbmNlUHJvZmlsZRIqChFzZW5kZXJfZmlyc3RfbmFtZRgBIAEoCVIPc2VuZGVyRm'
    'lyc3ROYW1lEigKEHNlbmRlcl9sYXN0X25hbWUYAiABKAlSDnNlbmRlckxhc3ROYW1lEigKEHNl'
    'bmRlcl9pZF9udW1iZXIYAyABKAlSDnNlbmRlcklkTnVtYmVyEiQKDnNlbmRlcl9pZF90eXBlGA'
    'QgASgJUgxzZW5kZXJJZFR5cGUSLQoSc2VuZGVyX25hdGlvbmFsaXR5GAUgASgJUhFzZW5kZXJO'
    'YXRpb25hbGl0eRIqChFzZW5kZXJfYmlydGhfZGF0ZRgGIAEoCVIPc2VuZGVyQmlydGhEYXRlEj'
    'MKDnNlbmRlcl9hZGRyZXNzGAcgASgLMgwucm1iLkFkZHJlc3NSDXNlbmRlckFkZHJlc3MSGgoI'
    'Y29tcGxldGUYCCABKAhSCGNvbXBsZXRlEiMKDWxvY2tlZF9maWVsZHMYCSADKAlSDGxvY2tlZE'
    'ZpZWxkcw==');

@$core.Deprecated('Use getComplianceProfileRequestDescriptor instead')
const GetComplianceProfileRequest$json = {
  '1': 'GetComplianceProfileRequest',
};

/// Descriptor for `GetComplianceProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getComplianceProfileRequestDescriptor =
    $convert.base64Decode('ChtHZXRDb21wbGlhbmNlUHJvZmlsZVJlcXVlc3Q=');

@$core.Deprecated('Use getComplianceProfileResponseDescriptor instead')
const GetComplianceProfileResponse$json = {
  '1': 'GetComplianceProfileResponse',
  '2': [
    {
      '1': 'profile',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.ComplianceProfile',
      '10': 'profile'
    },
  ],
};

/// Descriptor for `GetComplianceProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getComplianceProfileResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXRDb21wbGlhbmNlUHJvZmlsZVJlc3BvbnNlEjAKB3Byb2ZpbGUYASABKAsyFi5ybWIuQ2'
        '9tcGxpYW5jZVByb2ZpbGVSB3Byb2ZpbGU=');

@$core.Deprecated('Use upsertComplianceProfileRequestDescriptor instead')
const UpsertComplianceProfileRequest$json = {
  '1': 'UpsertComplianceProfileRequest',
  '2': [
    {
      '1': 'profile',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.ComplianceProfile',
      '10': 'profile'
    },
  ],
};

/// Descriptor for `UpsertComplianceProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upsertComplianceProfileRequestDescriptor =
    $convert.base64Decode(
        'Ch5VcHNlcnRDb21wbGlhbmNlUHJvZmlsZVJlcXVlc3QSMAoHcHJvZmlsZRgBIAEoCzIWLnJtYi'
        '5Db21wbGlhbmNlUHJvZmlsZVIHcHJvZmlsZQ==');

@$core.Deprecated('Use upsertComplianceProfileResponseDescriptor instead')
const UpsertComplianceProfileResponse$json = {
  '1': 'UpsertComplianceProfileResponse',
  '2': [
    {
      '1': 'profile',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.ComplianceProfile',
      '10': 'profile'
    },
  ],
};

/// Descriptor for `UpsertComplianceProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upsertComplianceProfileResponseDescriptor =
    $convert.base64Decode(
        'Ch9VcHNlcnRDb21wbGlhbmNlUHJvZmlsZVJlc3BvbnNlEjAKB3Byb2ZpbGUYASABKAsyFi5ybW'
        'IuQ29tcGxpYW5jZVByb2ZpbGVSB3Byb2ZpbGU=');

@$core.Deprecated('Use transferDescriptor instead')
const Transfer$json = {
  '1': 'Transfer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'rail', '3': 3, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    {'1': 'provider', '3': 4, '4': 1, '5': 9, '10': 'provider'},
    {
      '1': 'status',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.rmb.RmbStatus',
      '10': 'status'
    },
    {'1': 'dest_amount_minor', '3': 6, '4': 1, '5': 3, '10': 'destAmountMinor'},
    {
      '1': 'source_amount_minor',
      '3': 7,
      '4': 1,
      '5': 3,
      '10': 'sourceAmountMinor'
    },
    {'1': 'fx_rate', '3': 8, '4': 1, '5': 1, '10': 'fxRate'},
    {
      '1': 'provider_fee_minor',
      '3': 9,
      '4': 1,
      '5': 3,
      '10': 'providerFeeMinor'
    },
    {'1': 'our_fee_minor', '3': 10, '4': 1, '5': 3, '10': 'ourFeeMinor'},
    {'1': 'total_minor', '3': 11, '4': 1, '5': 3, '10': 'totalMinor'},
    {'1': 'beneficiary_name', '3': 12, '4': 1, '5': 9, '10': 'beneficiaryName'},
    {'1': 'beneficiary_id', '3': 13, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'purpose', '3': 14, '4': 1, '5': 9, '10': 'purpose'},
    {'1': 'provider_ref', '3': 15, '4': 1, '5': 9, '10': 'providerRef'},
    {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
    {
      '1': 'compliance_status',
      '3': 17,
      '4': 1,
      '5': 9,
      '10': 'complianceStatus'
    },
    {
      '1': 'created_at',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {
      '1': 'receiver_first_name',
      '3': 20,
      '4': 1,
      '5': 9,
      '10': 'receiverFirstName'
    },
    {
      '1': 'receiver_last_name',
      '3': 21,
      '4': 1,
      '5': 9,
      '10': 'receiverLastName'
    },
    {'1': 'account_number', '3': 22, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_id_type', '3': 23, '4': 1, '5': 9, '10': 'accountIdType'},
    {'1': 'bank_name', '3': 24, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 25, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'card_holder_name', '3': 26, '4': 1, '5': 9, '10': 'cardHolderName'},
    {'1': 'account_name', '3': 27, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'receiver_mobile', '3': 28, '4': 1, '5': 9, '10': 'receiverMobile'},
    {
      '1': 'receiver_id_number',
      '3': 29,
      '4': 1,
      '5': 9,
      '10': 'receiverIdNumber'
    },
    {'1': 'receiver_id_type', '3': 30, '4': 1, '5': 9, '10': 'receiverIdType'},
    {
      '1': 'receiver_relationship',
      '3': 31,
      '4': 1,
      '5': 9,
      '10': 'receiverRelationship'
    },
  ],
};

/// Descriptor for `Transfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDescriptor = $convert.base64Decode(
    'CghUcmFuc2ZlchIOCgJpZBgBIAEoCVICaWQSHAoJcmVmZXJlbmNlGAIgASgJUglyZWZlcmVuY2'
    'USIAoEcmFpbBgDIAEoDjIMLnJtYi5SbWJSYWlsUgRyYWlsEhoKCHByb3ZpZGVyGAQgASgJUghw'
    'cm92aWRlchImCgZzdGF0dXMYBSABKA4yDi5ybWIuUm1iU3RhdHVzUgZzdGF0dXMSKgoRZGVzdF'
    '9hbW91bnRfbWlub3IYBiABKANSD2Rlc3RBbW91bnRNaW5vchIuChNzb3VyY2VfYW1vdW50X21p'
    'bm9yGAcgASgDUhFzb3VyY2VBbW91bnRNaW5vchIXCgdmeF9yYXRlGAggASgBUgZmeFJhdGUSLA'
    'oScHJvdmlkZXJfZmVlX21pbm9yGAkgASgDUhBwcm92aWRlckZlZU1pbm9yEiIKDW91cl9mZWVf'
    'bWlub3IYCiABKANSC291ckZlZU1pbm9yEh8KC3RvdGFsX21pbm9yGAsgASgDUgp0b3RhbE1pbm'
    '9yEikKEGJlbmVmaWNpYXJ5X25hbWUYDCABKAlSD2JlbmVmaWNpYXJ5TmFtZRIlCg5iZW5lZmlj'
    'aWFyeV9pZBgNIAEoCVINYmVuZWZpY2lhcnlJZBIYCgdwdXJwb3NlGA4gASgJUgdwdXJwb3NlEi'
    'EKDHByb3ZpZGVyX3JlZhgPIAEoCVILcHJvdmlkZXJSZWYSJQoOZmFpbHVyZV9yZWFzb24YECAB'
    'KAlSDWZhaWx1cmVSZWFzb24SKwoRY29tcGxpYW5jZV9zdGF0dXMYESABKAlSEGNvbXBsaWFuY2'
    'VTdGF0dXMSOQoKY3JlYXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'CWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIJdXBkYXRlZEF0Ei4KE3JlY2VpdmVyX2ZpcnN0X25hbWUYFCABKAlSEXJlY2VpdmVyRmly'
    'c3ROYW1lEiwKEnJlY2VpdmVyX2xhc3RfbmFtZRgVIAEoCVIQcmVjZWl2ZXJMYXN0TmFtZRIlCg'
    '5hY2NvdW50X251bWJlchgWIAEoCVINYWNjb3VudE51bWJlchImCg9hY2NvdW50X2lkX3R5cGUY'
    'FyABKAlSDWFjY291bnRJZFR5cGUSGwoJYmFua19uYW1lGBggASgJUghiYW5rTmFtZRIbCgliYW'
    '5rX2NvZGUYGSABKAlSCGJhbmtDb2RlEigKEGNhcmRfaG9sZGVyX25hbWUYGiABKAlSDmNhcmRI'
    'b2xkZXJOYW1lEiEKDGFjY291bnRfbmFtZRgbIAEoCVILYWNjb3VudE5hbWUSJwoPcmVjZWl2ZX'
    'JfbW9iaWxlGBwgASgJUg5yZWNlaXZlck1vYmlsZRIsChJyZWNlaXZlcl9pZF9udW1iZXIYHSAB'
    'KAlSEHJlY2VpdmVySWROdW1iZXISKAoQcmVjZWl2ZXJfaWRfdHlwZRgeIAEoCVIOcmVjZWl2ZX'
    'JJZFR5cGUSMwoVcmVjZWl2ZXJfcmVsYXRpb25zaGlwGB8gASgJUhRyZWNlaXZlclJlbGF0aW9u'
    'c2hpcA==');

@$core.Deprecated('Use initiateTransferRequestDescriptor instead')
const InitiateTransferRequest$json = {
  '1': 'InitiateTransferRequest',
  '2': [
    {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    {'1': 'beneficiary_id', '3': 2, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {
      '1': 'beneficiary',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.rmb.Beneficiary',
      '10': 'beneficiary'
    },
    {'1': 'save_beneficiary', '3': 4, '4': 1, '5': 8, '10': 'saveBeneficiary'},
    {'1': 'purpose', '3': 5, '4': 1, '5': 9, '10': 'purpose'},
    {
      '1': 'verification_token',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `InitiateTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferRequestDescriptor = $convert.base64Decode(
    'ChdJbml0aWF0ZVRyYW5zZmVyUmVxdWVzdBIZCghxdW90ZV9pZBgBIAEoCVIHcXVvdGVJZBIlCg'
    '5iZW5lZmljaWFyeV9pZBgCIAEoCVINYmVuZWZpY2lhcnlJZBIyCgtiZW5lZmljaWFyeRgDIAEo'
    'CzIQLnJtYi5CZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSKQoQc2F2ZV9iZW5lZmljaWFyeRgEIA'
    'EoCFIPc2F2ZUJlbmVmaWNpYXJ5EhgKB3B1cnBvc2UYBSABKAlSB3B1cnBvc2USLQoSdmVyaWZp'
    'Y2F0aW9uX3Rva2VuGAYgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZX'
    'kYByABKAlSDmlkZW1wb3RlbmN5S2V5EioKEXNvdXJjZV9hY2NvdW50X2lkGAggASgJUg9zb3Vy'
    'Y2VBY2NvdW50SWQ=');

@$core.Deprecated('Use initiateTransferResponseDescriptor instead')
const InitiateTransferResponse$json = {
  '1': 'InitiateTransferResponse',
  '2': [
    {
      '1': 'transfer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.Transfer',
      '10': 'transfer'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiateTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferResponseDescriptor =
    $convert.base64Decode(
        'ChhJbml0aWF0ZVRyYW5zZmVyUmVzcG9uc2USKQoIdHJhbnNmZXIYASABKAsyDS5ybWIuVHJhbn'
        'NmZXJSCHRyYW5zZmVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getTransferRequestDescriptor instead')
const GetTransferRequest$json = {
  '1': 'GetTransferRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferRequestDescriptor =
    $convert.base64Decode('ChJHZXRUcmFuc2ZlclJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use getTransferResponseDescriptor instead')
const GetTransferResponse$json = {
  '1': 'GetTransferResponse',
  '2': [
    {
      '1': 'transfer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rmb.Transfer',
      '10': 'transfer'
    },
  ],
};

/// Descriptor for `GetTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferResponseDescriptor = $convert.base64Decode(
    'ChNHZXRUcmFuc2ZlclJlc3BvbnNlEikKCHRyYW5zZmVyGAEgASgLMg0ucm1iLlRyYW5zZmVyUg'
    'h0cmFuc2Zlcg==');

@$core.Deprecated('Use listTransfersRequestDescriptor instead')
const ListTransfersRequest$json = {
  '1': 'ListTransfersRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.rmb.RmbStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `ListTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransfersRequestDescriptor = $convert.base64Decode(
    'ChRMaXN0VHJhbnNmZXJzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZR'
    'gCIAEoBVIIcGFnZVNpemUSJgoGc3RhdHVzGAMgASgOMg4ucm1iLlJtYlN0YXR1c1IGc3RhdHVz');

@$core.Deprecated('Use listTransfersResponseDescriptor instead')
const ListTransfersResponse$json = {
  '1': 'ListTransfersResponse',
  '2': [
    {
      '1': 'transfers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.rmb.Transfer',
      '10': 'transfers'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransfersResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0VHJhbnNmZXJzUmVzcG9uc2USKwoJdHJhbnNmZXJzGAEgAygLMg0ucm1iLlRyYW5zZm'
    'VyUgl0cmFuc2ZlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2US'
    'GwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');
