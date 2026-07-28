///
//  Generated code. Do not modify.
//  source: rmb.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use rmbRailDescriptor instead')
const RmbRail$json = const {
  '1': 'RmbRail',
  '2': const [
    const {'1': 'RAIL_UNSPECIFIED', '2': 0},
    const {'1': 'ALIPAY', '2': 1},
    const {'1': 'WECHAT', '2': 2},
    const {'1': 'UNIONPAY', '2': 3},
    const {'1': 'BANK', '2': 4},
  ],
};

/// Descriptor for `RmbRail`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List rmbRailDescriptor = $convert.base64Decode('CgdSbWJSYWlsEhQKEFJBSUxfVU5TUEVDSUZJRUQQABIKCgZBTElQQVkQARIKCgZXRUNIQVQQAhIMCghVTklPTlBBWRADEggKBEJBTksQBA==');
@$core.Deprecated('Use rmbStatusDescriptor instead')
const RmbStatus$json = const {
  '1': 'RmbStatus',
  '2': const [
    const {'1': 'RMB_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'RMB_PENDING', '2': 1},
    const {'1': 'RMB_PROCESSING', '2': 2},
    const {'1': 'RMB_COMPLETED', '2': 3},
    const {'1': 'RMB_FAILED', '2': 4},
    const {'1': 'RMB_REFUNDED', '2': 5},
    const {'1': 'RMB_PENDING_COMPLIANCE', '2': 6},
    const {'1': 'RMB_CANCELLED', '2': 7},
  ],
};

/// Descriptor for `RmbStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List rmbStatusDescriptor = $convert.base64Decode('CglSbWJTdGF0dXMSGgoWUk1CX1NUQVRVU19VTlNQRUNJRklFRBAAEg8KC1JNQl9QRU5ESU5HEAESEgoOUk1CX1BST0NFU1NJTkcQAhIRCg1STUJfQ09NUExFVEVEEAMSDgoKUk1CX0ZBSUxFRBAEEhAKDFJNQl9SRUZVTkRFRBAFEhoKFlJNQl9QRU5ESU5HX0NPTVBMSUFOQ0UQBhIRCg1STUJfQ0FOQ0VMTEVEEAc=');
@$core.Deprecated('Use getProviderConfigRequestDescriptor instead')
const GetProviderConfigRequest$json = const {
  '1': 'GetProviderConfigRequest',
};

/// Descriptor for `GetProviderConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProviderConfigRequestDescriptor = $convert.base64Decode('ChhHZXRQcm92aWRlckNvbmZpZ1JlcXVlc3Q=');
@$core.Deprecated('Use railStatusDescriptor instead')
const RailStatus$json = const {
  '1': 'RailStatus',
  '2': const [
    const {'1': 'rail', '3': 1, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    const {'1': 'enabled', '3': 2, '4': 1, '5': 8, '10': 'enabled'},
    const {'1': 'min_amount_minor', '3': 3, '4': 1, '5': 3, '10': 'minAmountMinor'},
    const {'1': 'max_amount_minor', '3': 4, '4': 1, '5': 3, '10': 'maxAmountMinor'},
  ],
};

/// Descriptor for `RailStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List railStatusDescriptor = $convert.base64Decode('CgpSYWlsU3RhdHVzEiAKBHJhaWwYASABKA4yDC5ybWIuUm1iUmFpbFIEcmFpbBIYCgdlbmFibGVkGAIgASgIUgdlbmFibGVkEigKEG1pbl9hbW91bnRfbWlub3IYAyABKANSDm1pbkFtb3VudE1pbm9yEigKEG1heF9hbW91bnRfbWlub3IYBCABKANSDm1heEFtb3VudE1pbm9y');
@$core.Deprecated('Use rateTierDescriptor instead')
const RateTier$json = const {
  '1': 'RateTier',
  '2': const [
    const {'1': 'min_cny_minor', '3': 1, '4': 1, '5': 3, '10': 'minCnyMinor'},
    const {'1': 'margin_percent', '3': 2, '4': 1, '5': 1, '10': 'marginPercent'},
    const {'1': 'ngn_per_cny', '3': 3, '4': 1, '5': 1, '10': 'ngnPerCny'},
  ],
};

/// Descriptor for `RateTier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rateTierDescriptor = $convert.base64Decode('CghSYXRlVGllchIiCg1taW5fY255X21pbm9yGAEgASgDUgttaW5DbnlNaW5vchIlCg5tYXJnaW5fcGVyY2VudBgCIAEoAVINbWFyZ2luUGVyY2VudBIeCgtuZ25fcGVyX2NueRgDIAEoAVIJbmduUGVyQ255');
@$core.Deprecated('Use providerConfigResponseDescriptor instead')
const ProviderConfigResponse$json = const {
  '1': 'ProviderConfigResponse',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'rails', '3': 2, '4': 3, '5': 11, '6': '.rmb.RailStatus', '10': 'rails'},
    const {'1': 'maintenance', '3': 3, '4': 1, '5': 8, '10': 'maintenance'},
    const {'1': 'maintenance_message', '3': 4, '4': 1, '5': 9, '10': 'maintenanceMessage'},
    const {'1': 'indicative_fx_rate', '3': 5, '4': 1, '5': 1, '10': 'indicativeFxRate'},
    const {'1': 'rate_tiers', '3': 6, '4': 3, '5': 11, '6': '.rmb.RateTier', '10': 'rateTiers'},
  ],
};

/// Descriptor for `ProviderConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerConfigResponseDescriptor = $convert.base64Decode('ChZQcm92aWRlckNvbmZpZ1Jlc3BvbnNlEhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIlCgVyYWlscxgCIAMoCzIPLnJtYi5SYWlsU3RhdHVzUgVyYWlscxIgCgttYWludGVuYW5jZRgDIAEoCFILbWFpbnRlbmFuY2USLwoTbWFpbnRlbmFuY2VfbWVzc2FnZRgEIAEoCVISbWFpbnRlbmFuY2VNZXNzYWdlEiwKEmluZGljYXRpdmVfZnhfcmF0ZRgFIAEoAVIQaW5kaWNhdGl2ZUZ4UmF0ZRIsCgpyYXRlX3RpZXJzGAYgAygLMg0ucm1iLlJhdGVUaWVyUglyYXRlVGllcnM=');
@$core.Deprecated('Use resolveBanksRequestDescriptor instead')
const ResolveBanksRequest$json = const {
  '1': 'ResolveBanksRequest',
  '2': const [
    const {'1': 'rail', '3': 1, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
  ],
};

/// Descriptor for `ResolveBanksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveBanksRequestDescriptor = $convert.base64Decode('ChNSZXNvbHZlQmFua3NSZXF1ZXN0EiAKBHJhaWwYASABKA4yDC5ybWIuUm1iUmFpbFIEcmFpbA==');
@$core.Deprecated('Use bankDescriptor instead')
const Bank$json = const {
  '1': 'Bank',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Bank`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bankDescriptor = $convert.base64Decode('CgRCYW5rEhIKBGNvZGUYASABKAlSBGNvZGUSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use resolveBanksResponseDescriptor instead')
const ResolveBanksResponse$json = const {
  '1': 'ResolveBanksResponse',
  '2': const [
    const {'1': 'banks', '3': 1, '4': 3, '5': 11, '6': '.rmb.Bank', '10': 'banks'},
  ],
};

/// Descriptor for `ResolveBanksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveBanksResponseDescriptor = $convert.base64Decode('ChRSZXNvbHZlQmFua3NSZXNwb25zZRIfCgViYW5rcxgBIAMoCzIJLnJtYi5CYW5rUgViYW5rcw==');
@$core.Deprecated('Use getQuoteRequestDescriptor instead')
const GetQuoteRequest$json = const {
  '1': 'GetQuoteRequest',
  '2': const [
    const {'1': 'rail', '3': 1, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    const {'1': 'cny_amount_minor', '3': 2, '4': 1, '5': 3, '10': 'cnyAmountMinor'},
  ],
};

/// Descriptor for `GetQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQuoteRequestDescriptor = $convert.base64Decode('Cg9HZXRRdW90ZVJlcXVlc3QSIAoEcmFpbBgBIAEoDjIMLnJtYi5SbWJSYWlsUgRyYWlsEigKEGNueV9hbW91bnRfbWlub3IYAiABKANSDmNueUFtb3VudE1pbm9y');
@$core.Deprecated('Use quoteResponseDescriptor instead')
const QuoteResponse$json = const {
  '1': 'QuoteResponse',
  '2': const [
    const {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'rail', '3': 3, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    const {'1': 'fx_rate', '3': 4, '4': 1, '5': 1, '10': 'fxRate'},
    const {'1': 'dest_amount_minor', '3': 5, '4': 1, '5': 3, '10': 'destAmountMinor'},
    const {'1': 'source_amount_minor', '3': 6, '4': 1, '5': 3, '10': 'sourceAmountMinor'},
    const {'1': 'provider_fee_minor', '3': 7, '4': 1, '5': 3, '10': 'providerFeeMinor'},
    const {'1': 'our_fee_minor', '3': 8, '4': 1, '5': 3, '10': 'ourFeeMinor'},
    const {'1': 'total_minor', '3': 9, '4': 1, '5': 3, '10': 'totalMinor'},
    const {'1': 'expires_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
  ],
};

/// Descriptor for `QuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteResponseDescriptor = $convert.base64Decode('Cg1RdW90ZVJlc3BvbnNlEhkKCHF1b3RlX2lkGAEgASgJUgdxdW90ZUlkEhoKCHByb3ZpZGVyGAIgASgJUghwcm92aWRlchIgCgRyYWlsGAMgASgOMgwucm1iLlJtYlJhaWxSBHJhaWwSFwoHZnhfcmF0ZRgEIAEoAVIGZnhSYXRlEioKEWRlc3RfYW1vdW50X21pbm9yGAUgASgDUg9kZXN0QW1vdW50TWlub3ISLgoTc291cmNlX2Ftb3VudF9taW5vchgGIAEoA1IRc291cmNlQW1vdW50TWlub3ISLAoScHJvdmlkZXJfZmVlX21pbm9yGAcgASgDUhBwcm92aWRlckZlZU1pbm9yEiIKDW91cl9mZWVfbWlub3IYCCABKANSC291ckZlZU1pbm9yEh8KC3RvdGFsX21pbm9yGAkgASgDUgp0b3RhbE1pbm9yEjkKCmV4cGlyZXNfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQ=');
@$core.Deprecated('Use beneficiaryDescriptor instead')
const Beneficiary$json = const {
  '1': 'Beneficiary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'rail', '3': 2, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'favourite', '3': 4, '4': 1, '5': 8, '10': 'favourite'},
    const {'1': 'account_id', '3': 10, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'account_id_type', '3': 11, '4': 1, '5': 9, '10': 'accountIdType'},
    const {'1': 'account_number', '3': 12, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'receiver_first_name', '3': 20, '4': 1, '5': 9, '10': 'receiverFirstName'},
    const {'1': 'receiver_last_name', '3': 21, '4': 1, '5': 9, '10': 'receiverLastName'},
    const {'1': 'receiver_id_number', '3': 22, '4': 1, '5': 9, '10': 'receiverIdNumber'},
    const {'1': 'receiver_id_type', '3': 23, '4': 1, '5': 9, '10': 'receiverIdType'},
    const {'1': 'receiver_mobile', '3': 24, '4': 1, '5': 9, '10': 'receiverMobile'},
    const {'1': 'receiver_relationship', '3': 25, '4': 1, '5': 9, '10': 'receiverRelationship'},
    const {'1': 'card_number', '3': 30, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'card_holder_name', '3': 31, '4': 1, '5': 9, '10': 'cardHolderName'},
    const {'1': 'account_name', '3': 40, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'account_type', '3': 41, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'bank_code', '3': 42, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 43, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'last_used_at', '3': 50, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
  ],
};

/// Descriptor for `Beneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beneficiaryDescriptor = $convert.base64Decode('CgtCZW5lZmljaWFyeRIOCgJpZBgBIAEoCVICaWQSIAoEcmFpbBgCIAEoDjIMLnJtYi5SbWJSYWlsUgRyYWlsEiEKDGRpc3BsYXlfbmFtZRgDIAEoCVILZGlzcGxheU5hbWUSHAoJZmF2b3VyaXRlGAQgASgIUglmYXZvdXJpdGUSHQoKYWNjb3VudF9pZBgKIAEoCVIJYWNjb3VudElkEiYKD2FjY291bnRfaWRfdHlwZRgLIAEoCVINYWNjb3VudElkVHlwZRIlCg5hY2NvdW50X251bWJlchgMIAEoCVINYWNjb3VudE51bWJlchIuChNyZWNlaXZlcl9maXJzdF9uYW1lGBQgASgJUhFyZWNlaXZlckZpcnN0TmFtZRIsChJyZWNlaXZlcl9sYXN0X25hbWUYFSABKAlSEHJlY2VpdmVyTGFzdE5hbWUSLAoScmVjZWl2ZXJfaWRfbnVtYmVyGBYgASgJUhByZWNlaXZlcklkTnVtYmVyEigKEHJlY2VpdmVyX2lkX3R5cGUYFyABKAlSDnJlY2VpdmVySWRUeXBlEicKD3JlY2VpdmVyX21vYmlsZRgYIAEoCVIOcmVjZWl2ZXJNb2JpbGUSMwoVcmVjZWl2ZXJfcmVsYXRpb25zaGlwGBkgASgJUhRyZWNlaXZlclJlbGF0aW9uc2hpcBIfCgtjYXJkX251bWJlchgeIAEoCVIKY2FyZE51bWJlchIoChBjYXJkX2hvbGRlcl9uYW1lGB8gASgJUg5jYXJkSG9sZGVyTmFtZRIhCgxhY2NvdW50X25hbWUYKCABKAlSC2FjY291bnROYW1lEiEKDGFjY291bnRfdHlwZRgpIAEoCVILYWNjb3VudFR5cGUSGwoJYmFua19jb2RlGCogASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYKyABKAlSCGJhbmtOYW1lEjwKDGxhc3RfdXNlZF9hdBgyIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmxhc3RVc2VkQXQ=');
@$core.Deprecated('Use listBeneficiariesRequestDescriptor instead')
const ListBeneficiariesRequest$json = const {
  '1': 'ListBeneficiariesRequest',
  '2': const [
    const {'1': 'rail', '3': 1, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
  ],
};

/// Descriptor for `ListBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBeneficiariesRequestDescriptor = $convert.base64Decode('ChhMaXN0QmVuZWZpY2lhcmllc1JlcXVlc3QSIAoEcmFpbBgBIAEoDjIMLnJtYi5SbWJSYWlsUgRyYWls');
@$core.Deprecated('Use listBeneficiariesResponseDescriptor instead')
const ListBeneficiariesResponse$json = const {
  '1': 'ListBeneficiariesResponse',
  '2': const [
    const {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.rmb.Beneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `ListBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBeneficiariesResponseDescriptor = $convert.base64Decode('ChlMaXN0QmVuZWZpY2lhcmllc1Jlc3BvbnNlEjYKDWJlbmVmaWNpYXJpZXMYASADKAsyEC5ybWIuQmVuZWZpY2lhcnlSDWJlbmVmaWNpYXJpZXM=');
@$core.Deprecated('Use saveBeneficiaryRequestDescriptor instead')
const SaveBeneficiaryRequest$json = const {
  '1': 'SaveBeneficiaryRequest',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.rmb.Beneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `SaveBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBeneficiaryRequestDescriptor = $convert.base64Decode('ChZTYXZlQmVuZWZpY2lhcnlSZXF1ZXN0EjIKC2JlbmVmaWNpYXJ5GAEgASgLMhAucm1iLkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');
@$core.Deprecated('Use saveBeneficiaryResponseDescriptor instead')
const SaveBeneficiaryResponse$json = const {
  '1': 'SaveBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.rmb.Beneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `SaveBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBeneficiaryResponseDescriptor = $convert.base64Decode('ChdTYXZlQmVuZWZpY2lhcnlSZXNwb25zZRIyCgtiZW5lZmljaWFyeRgBIAEoCzIQLnJtYi5CZW5lZmljaWFyeVILYmVuZWZpY2lhcnk=');
@$core.Deprecated('Use updateBeneficiaryRequestDescriptor instead')
const UpdateBeneficiaryRequest$json = const {
  '1': 'UpdateBeneficiaryRequest',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.rmb.Beneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `UpdateBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBeneficiaryRequestDescriptor = $convert.base64Decode('ChhVcGRhdGVCZW5lZmljaWFyeVJlcXVlc3QSMgoLYmVuZWZpY2lhcnkYASABKAsyEC5ybWIuQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5');
@$core.Deprecated('Use updateBeneficiaryResponseDescriptor instead')
const UpdateBeneficiaryResponse$json = const {
  '1': 'UpdateBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.rmb.Beneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `UpdateBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBeneficiaryResponseDescriptor = $convert.base64Decode('ChlVcGRhdGVCZW5lZmljaWFyeVJlc3BvbnNlEjIKC2JlbmVmaWNpYXJ5GAEgASgLMhAucm1iLkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');
@$core.Deprecated('Use deleteBeneficiaryRequestDescriptor instead')
const DeleteBeneficiaryRequest$json = const {
  '1': 'DeleteBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBeneficiaryRequestDescriptor = $convert.base64Decode('ChhEZWxldGVCZW5lZmljaWFyeVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use deleteBeneficiaryResponseDescriptor instead')
const DeleteBeneficiaryResponse$json = const {
  '1': 'DeleteBeneficiaryResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBeneficiaryResponseDescriptor = $convert.base64Decode('ChlEZWxldGVCZW5lZmljaWFyeVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');
@$core.Deprecated('Use favouriteBeneficiaryRequestDescriptor instead')
const FavouriteBeneficiaryRequest$json = const {
  '1': 'FavouriteBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'favourite', '3': 2, '4': 1, '5': 8, '10': 'favourite'},
  ],
};

/// Descriptor for `FavouriteBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List favouriteBeneficiaryRequestDescriptor = $convert.base64Decode('ChtGYXZvdXJpdGVCZW5lZmljaWFyeVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEhwKCWZhdm91cml0ZRgCIAEoCFIJZmF2b3VyaXRl');
@$core.Deprecated('Use favouriteBeneficiaryResponseDescriptor instead')
const FavouriteBeneficiaryResponse$json = const {
  '1': 'FavouriteBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.rmb.Beneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `FavouriteBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List favouriteBeneficiaryResponseDescriptor = $convert.base64Decode('ChxGYXZvdXJpdGVCZW5lZmljaWFyeVJlc3BvbnNlEjIKC2JlbmVmaWNpYXJ5GAEgASgLMhAucm1iLkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');
@$core.Deprecated('Use addressDescriptor instead')
const Address$json = const {
  '1': 'Address',
  '2': const [
    const {'1': 'city', '3': 1, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'postcode', '3': 3, '4': 1, '5': 9, '10': 'postcode'},
    const {'1': 'state', '3': 4, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'street_address', '3': 5, '4': 1, '5': 9, '10': 'streetAddress'},
  ],
};

/// Descriptor for `Address`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressDescriptor = $convert.base64Decode('CgdBZGRyZXNzEhIKBGNpdHkYASABKAlSBGNpdHkSIQoMY291bnRyeV9jb2RlGAIgASgJUgtjb3VudHJ5Q29kZRIaCghwb3N0Y29kZRgDIAEoCVIIcG9zdGNvZGUSFAoFc3RhdGUYBCABKAlSBXN0YXRlEiUKDnN0cmVldF9hZGRyZXNzGAUgASgJUg1zdHJlZXRBZGRyZXNz');
@$core.Deprecated('Use complianceProfileDescriptor instead')
const ComplianceProfile$json = const {
  '1': 'ComplianceProfile',
  '2': const [
    const {'1': 'sender_first_name', '3': 1, '4': 1, '5': 9, '10': 'senderFirstName'},
    const {'1': 'sender_last_name', '3': 2, '4': 1, '5': 9, '10': 'senderLastName'},
    const {'1': 'sender_id_number', '3': 3, '4': 1, '5': 9, '10': 'senderIdNumber'},
    const {'1': 'sender_id_type', '3': 4, '4': 1, '5': 9, '10': 'senderIdType'},
    const {'1': 'sender_nationality', '3': 5, '4': 1, '5': 9, '10': 'senderNationality'},
    const {'1': 'sender_birth_date', '3': 6, '4': 1, '5': 9, '10': 'senderBirthDate'},
    const {'1': 'sender_address', '3': 7, '4': 1, '5': 11, '6': '.rmb.Address', '10': 'senderAddress'},
    const {'1': 'complete', '3': 8, '4': 1, '5': 8, '10': 'complete'},
  ],
};

/// Descriptor for `ComplianceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List complianceProfileDescriptor = $convert.base64Decode('ChFDb21wbGlhbmNlUHJvZmlsZRIqChFzZW5kZXJfZmlyc3RfbmFtZRgBIAEoCVIPc2VuZGVyRmlyc3ROYW1lEigKEHNlbmRlcl9sYXN0X25hbWUYAiABKAlSDnNlbmRlckxhc3ROYW1lEigKEHNlbmRlcl9pZF9udW1iZXIYAyABKAlSDnNlbmRlcklkTnVtYmVyEiQKDnNlbmRlcl9pZF90eXBlGAQgASgJUgxzZW5kZXJJZFR5cGUSLQoSc2VuZGVyX25hdGlvbmFsaXR5GAUgASgJUhFzZW5kZXJOYXRpb25hbGl0eRIqChFzZW5kZXJfYmlydGhfZGF0ZRgGIAEoCVIPc2VuZGVyQmlydGhEYXRlEjMKDnNlbmRlcl9hZGRyZXNzGAcgASgLMgwucm1iLkFkZHJlc3NSDXNlbmRlckFkZHJlc3MSGgoIY29tcGxldGUYCCABKAhSCGNvbXBsZXRl');
@$core.Deprecated('Use getComplianceProfileRequestDescriptor instead')
const GetComplianceProfileRequest$json = const {
  '1': 'GetComplianceProfileRequest',
};

/// Descriptor for `GetComplianceProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getComplianceProfileRequestDescriptor = $convert.base64Decode('ChtHZXRDb21wbGlhbmNlUHJvZmlsZVJlcXVlc3Q=');
@$core.Deprecated('Use getComplianceProfileResponseDescriptor instead')
const GetComplianceProfileResponse$json = const {
  '1': 'GetComplianceProfileResponse',
  '2': const [
    const {'1': 'profile', '3': 1, '4': 1, '5': 11, '6': '.rmb.ComplianceProfile', '10': 'profile'},
  ],
};

/// Descriptor for `GetComplianceProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getComplianceProfileResponseDescriptor = $convert.base64Decode('ChxHZXRDb21wbGlhbmNlUHJvZmlsZVJlc3BvbnNlEjAKB3Byb2ZpbGUYASABKAsyFi5ybWIuQ29tcGxpYW5jZVByb2ZpbGVSB3Byb2ZpbGU=');
@$core.Deprecated('Use upsertComplianceProfileRequestDescriptor instead')
const UpsertComplianceProfileRequest$json = const {
  '1': 'UpsertComplianceProfileRequest',
  '2': const [
    const {'1': 'profile', '3': 1, '4': 1, '5': 11, '6': '.rmb.ComplianceProfile', '10': 'profile'},
  ],
};

/// Descriptor for `UpsertComplianceProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upsertComplianceProfileRequestDescriptor = $convert.base64Decode('Ch5VcHNlcnRDb21wbGlhbmNlUHJvZmlsZVJlcXVlc3QSMAoHcHJvZmlsZRgBIAEoCzIWLnJtYi5Db21wbGlhbmNlUHJvZmlsZVIHcHJvZmlsZQ==');
@$core.Deprecated('Use upsertComplianceProfileResponseDescriptor instead')
const UpsertComplianceProfileResponse$json = const {
  '1': 'UpsertComplianceProfileResponse',
  '2': const [
    const {'1': 'profile', '3': 1, '4': 1, '5': 11, '6': '.rmb.ComplianceProfile', '10': 'profile'},
  ],
};

/// Descriptor for `UpsertComplianceProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upsertComplianceProfileResponseDescriptor = $convert.base64Decode('Ch9VcHNlcnRDb21wbGlhbmNlUHJvZmlsZVJlc3BvbnNlEjAKB3Byb2ZpbGUYASABKAsyFi5ybWIuQ29tcGxpYW5jZVByb2ZpbGVSB3Byb2ZpbGU=');
@$core.Deprecated('Use transferDescriptor instead')
const Transfer$json = const {
  '1': 'Transfer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'rail', '3': 3, '4': 1, '5': 14, '6': '.rmb.RmbRail', '10': 'rail'},
    const {'1': 'provider', '3': 4, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.rmb.RmbStatus', '10': 'status'},
    const {'1': 'dest_amount_minor', '3': 6, '4': 1, '5': 3, '10': 'destAmountMinor'},
    const {'1': 'source_amount_minor', '3': 7, '4': 1, '5': 3, '10': 'sourceAmountMinor'},
    const {'1': 'fx_rate', '3': 8, '4': 1, '5': 1, '10': 'fxRate'},
    const {'1': 'provider_fee_minor', '3': 9, '4': 1, '5': 3, '10': 'providerFeeMinor'},
    const {'1': 'our_fee_minor', '3': 10, '4': 1, '5': 3, '10': 'ourFeeMinor'},
    const {'1': 'total_minor', '3': 11, '4': 1, '5': 3, '10': 'totalMinor'},
    const {'1': 'beneficiary_name', '3': 12, '4': 1, '5': 9, '10': 'beneficiaryName'},
    const {'1': 'beneficiary_id', '3': 13, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'purpose', '3': 14, '4': 1, '5': 9, '10': 'purpose'},
    const {'1': 'provider_ref', '3': 15, '4': 1, '5': 9, '10': 'providerRef'},
    const {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'compliance_status', '3': 17, '4': 1, '5': 9, '10': 'complianceStatus'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'receiver_first_name', '3': 20, '4': 1, '5': 9, '10': 'receiverFirstName'},
    const {'1': 'receiver_last_name', '3': 21, '4': 1, '5': 9, '10': 'receiverLastName'},
    const {'1': 'account_number', '3': 22, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_id_type', '3': 23, '4': 1, '5': 9, '10': 'accountIdType'},
    const {'1': 'bank_name', '3': 24, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'bank_code', '3': 25, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'card_holder_name', '3': 26, '4': 1, '5': 9, '10': 'cardHolderName'},
    const {'1': 'account_name', '3': 27, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'receiver_mobile', '3': 28, '4': 1, '5': 9, '10': 'receiverMobile'},
    const {'1': 'receiver_id_number', '3': 29, '4': 1, '5': 9, '10': 'receiverIdNumber'},
    const {'1': 'receiver_id_type', '3': 30, '4': 1, '5': 9, '10': 'receiverIdType'},
    const {'1': 'receiver_relationship', '3': 31, '4': 1, '5': 9, '10': 'receiverRelationship'},
  ],
};

/// Descriptor for `Transfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDescriptor = $convert.base64Decode('CghUcmFuc2ZlchIOCgJpZBgBIAEoCVICaWQSHAoJcmVmZXJlbmNlGAIgASgJUglyZWZlcmVuY2USIAoEcmFpbBgDIAEoDjIMLnJtYi5SbWJSYWlsUgRyYWlsEhoKCHByb3ZpZGVyGAQgASgJUghwcm92aWRlchImCgZzdGF0dXMYBSABKA4yDi5ybWIuUm1iU3RhdHVzUgZzdGF0dXMSKgoRZGVzdF9hbW91bnRfbWlub3IYBiABKANSD2Rlc3RBbW91bnRNaW5vchIuChNzb3VyY2VfYW1vdW50X21pbm9yGAcgASgDUhFzb3VyY2VBbW91bnRNaW5vchIXCgdmeF9yYXRlGAggASgBUgZmeFJhdGUSLAoScHJvdmlkZXJfZmVlX21pbm9yGAkgASgDUhBwcm92aWRlckZlZU1pbm9yEiIKDW91cl9mZWVfbWlub3IYCiABKANSC291ckZlZU1pbm9yEh8KC3RvdGFsX21pbm9yGAsgASgDUgp0b3RhbE1pbm9yEikKEGJlbmVmaWNpYXJ5X25hbWUYDCABKAlSD2JlbmVmaWNpYXJ5TmFtZRIlCg5iZW5lZmljaWFyeV9pZBgNIAEoCVINYmVuZWZpY2lhcnlJZBIYCgdwdXJwb3NlGA4gASgJUgdwdXJwb3NlEiEKDHByb3ZpZGVyX3JlZhgPIAEoCVILcHJvdmlkZXJSZWYSJQoOZmFpbHVyZV9yZWFzb24YECABKAlSDWZhaWx1cmVSZWFzb24SKwoRY29tcGxpYW5jZV9zdGF0dXMYESABKAlSEGNvbXBsaWFuY2VTdGF0dXMSOQoKY3JlYXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0Ei4KE3JlY2VpdmVyX2ZpcnN0X25hbWUYFCABKAlSEXJlY2VpdmVyRmlyc3ROYW1lEiwKEnJlY2VpdmVyX2xhc3RfbmFtZRgVIAEoCVIQcmVjZWl2ZXJMYXN0TmFtZRIlCg5hY2NvdW50X251bWJlchgWIAEoCVINYWNjb3VudE51bWJlchImCg9hY2NvdW50X2lkX3R5cGUYFyABKAlSDWFjY291bnRJZFR5cGUSGwoJYmFua19uYW1lGBggASgJUghiYW5rTmFtZRIbCgliYW5rX2NvZGUYGSABKAlSCGJhbmtDb2RlEigKEGNhcmRfaG9sZGVyX25hbWUYGiABKAlSDmNhcmRIb2xkZXJOYW1lEiEKDGFjY291bnRfbmFtZRgbIAEoCVILYWNjb3VudE5hbWUSJwoPcmVjZWl2ZXJfbW9iaWxlGBwgASgJUg5yZWNlaXZlck1vYmlsZRIsChJyZWNlaXZlcl9pZF9udW1iZXIYHSABKAlSEHJlY2VpdmVySWROdW1iZXISKAoQcmVjZWl2ZXJfaWRfdHlwZRgeIAEoCVIOcmVjZWl2ZXJJZFR5cGUSMwoVcmVjZWl2ZXJfcmVsYXRpb25zaGlwGB8gASgJUhRyZWNlaXZlclJlbGF0aW9uc2hpcA==');
@$core.Deprecated('Use initiateTransferRequestDescriptor instead')
const InitiateTransferRequest$json = const {
  '1': 'InitiateTransferRequest',
  '2': const [
    const {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    const {'1': 'beneficiary_id', '3': 2, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'beneficiary', '3': 3, '4': 1, '5': 11, '6': '.rmb.Beneficiary', '10': 'beneficiary'},
    const {'1': 'save_beneficiary', '3': 4, '4': 1, '5': 8, '10': 'saveBeneficiary'},
    const {'1': 'purpose', '3': 5, '4': 1, '5': 9, '10': 'purpose'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'source_account_id', '3': 8, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `InitiateTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferRequestDescriptor = $convert.base64Decode('ChdJbml0aWF0ZVRyYW5zZmVyUmVxdWVzdBIZCghxdW90ZV9pZBgBIAEoCVIHcXVvdGVJZBIlCg5iZW5lZmljaWFyeV9pZBgCIAEoCVINYmVuZWZpY2lhcnlJZBIyCgtiZW5lZmljaWFyeRgDIAEoCzIQLnJtYi5CZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSKQoQc2F2ZV9iZW5lZmljaWFyeRgEIAEoCFIPc2F2ZUJlbmVmaWNpYXJ5EhgKB3B1cnBvc2UYBSABKAlSB3B1cnBvc2USLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAYgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYByABKAlSDmlkZW1wb3RlbmN5S2V5EioKEXNvdXJjZV9hY2NvdW50X2lkGAggASgJUg9zb3VyY2VBY2NvdW50SWQ=');
@$core.Deprecated('Use initiateTransferResponseDescriptor instead')
const InitiateTransferResponse$json = const {
  '1': 'InitiateTransferResponse',
  '2': const [
    const {'1': 'transfer', '3': 1, '4': 1, '5': 11, '6': '.rmb.Transfer', '10': 'transfer'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiateTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateTransferResponseDescriptor = $convert.base64Decode('ChhJbml0aWF0ZVRyYW5zZmVyUmVzcG9uc2USKQoIdHJhbnNmZXIYASABKAsyDS5ybWIuVHJhbnNmZXJSCHRyYW5zZmVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getTransferRequestDescriptor instead')
const GetTransferRequest$json = const {
  '1': 'GetTransferRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferRequestDescriptor = $convert.base64Decode('ChJHZXRUcmFuc2ZlclJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use getTransferResponseDescriptor instead')
const GetTransferResponse$json = const {
  '1': 'GetTransferResponse',
  '2': const [
    const {'1': 'transfer', '3': 1, '4': 1, '5': 11, '6': '.rmb.Transfer', '10': 'transfer'},
  ],
};

/// Descriptor for `GetTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferResponseDescriptor = $convert.base64Decode('ChNHZXRUcmFuc2ZlclJlc3BvbnNlEikKCHRyYW5zZmVyGAEgASgLMg0ucm1iLlRyYW5zZmVyUgh0cmFuc2Zlcg==');
@$core.Deprecated('Use listTransfersRequestDescriptor instead')
const ListTransfersRequest$json = const {
  '1': 'ListTransfersRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.rmb.RmbStatus', '10': 'status'},
  ],
};

/// Descriptor for `ListTransfersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransfersRequestDescriptor = $convert.base64Decode('ChRMaXN0VHJhbnNmZXJzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSJgoGc3RhdHVzGAMgASgOMg4ucm1iLlJtYlN0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use listTransfersResponseDescriptor instead')
const ListTransfersResponse$json = const {
  '1': 'ListTransfersResponse',
  '2': const [
    const {'1': 'transfers', '3': 1, '4': 3, '5': 11, '6': '.rmb.Transfer', '10': 'transfers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListTransfersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransfersResponseDescriptor = $convert.base64Decode('ChVMaXN0VHJhbnNmZXJzUmVzcG9uc2USKwoJdHJhbnNmZXJzGAEgAygLMg0ucm1iLlRyYW5zZmVyUgl0cmFuc2ZlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZQ==');
