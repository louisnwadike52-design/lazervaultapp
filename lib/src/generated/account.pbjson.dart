//
//  Generated code. Do not modify.
//  source: account.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use virtualAccountTypeDescriptor instead')
const VirtualAccountType$json = {
  '1': 'VirtualAccountType',
  '2': [
    {'1': 'ACCOUNT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'ACCOUNT_TYPE_PERSONAL', '2': 1},
    {'1': 'ACCOUNT_TYPE_SAVINGS', '2': 2},
    {'1': 'ACCOUNT_TYPE_INVESTMENT', '2': 3},
    {'1': 'ACCOUNT_TYPE_FAMILY', '2': 4},
    {'1': 'ACCOUNT_TYPE_BUSINESS', '2': 5},
    {'1': 'ACCOUNT_TYPE_MAIN', '2': 6},
    {'1': 'ACCOUNT_TYPE_USD', '2': 7},
    {'1': 'ACCOUNT_TYPE_GBP', '2': 8},
    {'1': 'ACCOUNT_TYPE_EUR', '2': 9},
  ],
};

/// Descriptor for `VirtualAccountType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List virtualAccountTypeDescriptor = $convert.base64Decode(
    'ChJWaXJ0dWFsQWNjb3VudFR5cGUSHAoYQUNDT1VOVF9UWVBFX1VOU1BFQ0lGSUVEEAASGQoVQU'
    'NDT1VOVF9UWVBFX1BFUlNPTkFMEAESGAoUQUNDT1VOVF9UWVBFX1NBVklOR1MQAhIbChdBQ0NP'
    'VU5UX1RZUEVfSU5WRVNUTUVOVBADEhcKE0FDQ09VTlRfVFlQRV9GQU1JTFkQBBIZChVBQ0NPVU'
    '5UX1RZUEVfQlVTSU5FU1MQBRIVChFBQ0NPVU5UX1RZUEVfTUFJThAGEhQKEEFDQ09VTlRfVFlQ'
    'RV9VU0QQBxIUChBBQ0NPVU5UX1RZUEVfR0JQEAgSFAoQQUNDT1VOVF9UWVBFX0VVUhAJ');

@$core.Deprecated('Use accountDescriptor instead')
const Account$json = {
  '1': 'Account',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'balance', '3': 4, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'account_number', '3': 5, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'is_primary', '3': 9, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'account_label', '3': 10, '4': 1, '5': 9, '10': 'accountLabel'},
    {'1': 'bank_name', '3': 11, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 12, '4': 1, '5': 9, '10': 'bankCode'},
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode(
    'CgdBY2NvdW50Eg4KAmlkGAEgASgEUgJpZBIhCgxhY2NvdW50X3R5cGUYAiABKAlSC2FjY291bn'
    'RUeXBlEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIYCgdiYWxhbmNlGAQgASgBUgdiYWxh'
    'bmNlEiUKDmFjY291bnRfbnVtYmVyGAUgASgJUg1hY2NvdW50TnVtYmVyEhsKCWlzX2FjdGl2ZR'
    'gGIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5U'
    'aW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIJdXBkYXRlZEF0Eh0KCmlzX3ByaW1hcnkYCSABKAhSCWlzUHJpbWFyeRIj'
    'Cg1hY2NvdW50X2xhYmVsGAogASgJUgxhY2NvdW50TGFiZWwSGwoJYmFua19uYW1lGAsgASgJUg'
    'hiYW5rTmFtZRIbCgliYW5rX2NvZGUYDCABKAlSCGJhbmtDb2Rl');

@$core.Deprecated('Use createAccountRequestDescriptor instead')
const CreateAccountRequest$json = {
  '1': 'CreateAccountRequest',
  '2': [
    {'1': 'account_type', '3': 1, '4': 1, '5': 9, '10': 'account_type'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'pin', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'pin', '17': true},
  ],
  '7': {},
  '8': [
    {'1': '_pin'},
  ],
};

/// Descriptor for `CreateAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVBY2NvdW50UmVxdWVzdBIiCgxhY2NvdW50X3R5cGUYASABKAlSDGFjY291bnRfdH'
    'lwZRIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3kSFQoDcGluGAMgASgJSABSA3BpbogBATof'
    'kkEcChrSAQxhY2NvdW50X3R5cGXSAQhjdXJyZW5jeUIGCgRfcGlu');

@$core.Deprecated('Use createAccountResponseDescriptor instead')
const CreateAccountResponse$json = {
  '1': 'CreateAccountResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'account'},
  ],
};

/// Descriptor for `CreateAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVBY2NvdW50UmVzcG9uc2USLAoHYWNjb3VudBgBIAEoCzISLnBiLkFjY291bnREZX'
    'RhaWxzUgdhY2NvdW50');

@$core.Deprecated('Use getAccountsRequestDescriptor instead')
const GetAccountsRequest$json = {
  '1': 'GetAccountsRequest',
};

/// Descriptor for `GetAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsRequestDescriptor = $convert.base64Decode(
    'ChJHZXRBY2NvdW50c1JlcXVlc3Q=');

@$core.Deprecated('Use getAccountsResponseDescriptor instead')
const GetAccountsResponse$json = {
  '1': 'GetAccountsResponse',
  '2': [
    {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.pb.Account', '10': 'accounts'},
  ],
};

/// Descriptor for `GetAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsResponseDescriptor = $convert.base64Decode(
    'ChNHZXRBY2NvdW50c1Jlc3BvbnNlEicKCGFjY291bnRzGAEgAygLMgsucGIuQWNjb3VudFIIYW'
    'Njb3VudHM=');

@$core.Deprecated('Use accountSummaryDescriptor instead')
const AccountSummary$json = {
  '1': 'AccountSummary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'balance', '3': 4, '4': 1, '5': 4, '10': 'balance'},
    {'1': 'masked_account_number', '3': 5, '4': 1, '5': 9, '10': 'maskedAccountNumber'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'is_primary', '3': 7, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'account_label', '3': 8, '4': 1, '5': 9, '10': 'accountLabel'},
    {'1': 'bank_name', '3': 9, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'trend_percentage', '3': 10, '4': 1, '5': 1, '10': 'trendPercentage'},
    {'1': 'is_family_account', '3': 11, '4': 1, '5': 8, '10': 'isFamilyAccount'},
    {'1': 'family_total_balance', '3': 12, '4': 1, '5': 4, '10': 'familyTotalBalance'},
    {'1': 'member_allocated_balance', '3': 13, '4': 1, '5': 4, '10': 'memberAllocatedBalance'},
    {'1': 'member_count', '3': 14, '4': 1, '5': 5, '10': 'memberCount'},
  ],
};

/// Descriptor for `AccountSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSummaryDescriptor = $convert.base64Decode(
    'Cg5BY2NvdW50U3VtbWFyeRIOCgJpZBgBIAEoBFICaWQSIQoMYWNjb3VudF90eXBlGAIgASgJUg'
    'thY2NvdW50VHlwZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSGAoHYmFsYW5jZRgEIAEo'
    'BFIHYmFsYW5jZRIyChVtYXNrZWRfYWNjb3VudF9udW1iZXIYBSABKAlSE21hc2tlZEFjY291bn'
    'ROdW1iZXISFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSHQoKaXNfcHJpbWFyeRgHIAEoCFIJaXNQ'
    'cmltYXJ5EiMKDWFjY291bnRfbGFiZWwYCCABKAlSDGFjY291bnRMYWJlbBIbCgliYW5rX25hbW'
    'UYCSABKAlSCGJhbmtOYW1lEikKEHRyZW5kX3BlcmNlbnRhZ2UYCiABKAFSD3RyZW5kUGVyY2Vu'
    'dGFnZRIqChFpc19mYW1pbHlfYWNjb3VudBgLIAEoCFIPaXNGYW1pbHlBY2NvdW50EjAKFGZhbW'
    'lseV90b3RhbF9iYWxhbmNlGAwgASgEUhJmYW1pbHlUb3RhbEJhbGFuY2USOAoYbWVtYmVyX2Fs'
    'bG9jYXRlZF9iYWxhbmNlGA0gASgEUhZtZW1iZXJBbGxvY2F0ZWRCYWxhbmNlEiEKDG1lbWJlcl'
    '9jb3VudBgOIAEoBVILbWVtYmVyQ291bnQ=');

@$core.Deprecated('Use accountDetailsDescriptor instead')
const AccountDetails$json = {
  '1': 'AccountDetails',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'balance', '3': 4, '4': 1, '5': 4, '10': 'balance'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'card_holder_name', '3': 7, '4': 1, '5': 9, '10': 'cardHolderName'},
    {'1': 'card_type', '3': 8, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'expiry_date', '3': 9, '4': 1, '5': 9, '10': 'expiryDate'},
    {'1': 'daily_limit', '3': 10, '4': 1, '5': 4, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 11, '4': 1, '5': 4, '10': 'monthlyLimit'},
    {'1': 'enable_3d_secure', '3': 12, '4': 1, '5': 8, '10': 'enable3dSecure'},
    {'1': 'enable_contactless', '3': 13, '4': 1, '5': 8, '10': 'enableContactless'},
    {'1': 'enable_online_payments', '3': 14, '4': 1, '5': 8, '10': 'enableOnlinePayments'},
    {'1': 'account_number', '3': 15, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'iban', '3': 16, '4': 1, '5': 9, '10': 'iban'},
    {'1': 'bic_swift', '3': 17, '4': 1, '5': 9, '10': 'bicSwift'},
    {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `AccountDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDetailsDescriptor = $convert.base64Decode(
    'Cg5BY2NvdW50RGV0YWlscxIOCgJpZBgBIAEoBFICaWQSIQoMYWNjb3VudF90eXBlGAIgASgJUg'
    'thY2NvdW50VHlwZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSGAoHYmFsYW5jZRgEIAEo'
    'BFIHYmFsYW5jZRIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIoChBjYXJkX2hvbGRlcl9uYW1lGA'
    'cgASgJUg5jYXJkSG9sZGVyTmFtZRIbCgljYXJkX3R5cGUYCCABKAlSCGNhcmRUeXBlEh8KC2V4'
    'cGlyeV9kYXRlGAkgASgJUgpleHBpcnlEYXRlEh8KC2RhaWx5X2xpbWl0GAogASgEUgpkYWlseU'
    'xpbWl0EiMKDW1vbnRobHlfbGltaXQYCyABKARSDG1vbnRobHlMaW1pdBIoChBlbmFibGVfM2Rf'
    'c2VjdXJlGAwgASgIUg5lbmFibGUzZFNlY3VyZRItChJlbmFibGVfY29udGFjdGxlc3MYDSABKA'
    'hSEWVuYWJsZUNvbnRhY3RsZXNzEjQKFmVuYWJsZV9vbmxpbmVfcGF5bWVudHMYDiABKAhSFGVu'
    'YWJsZU9ubGluZVBheW1lbnRzEiUKDmFjY291bnRfbnVtYmVyGA8gASgJUg1hY2NvdW50TnVtYm'
    'VyEhIKBGliYW4YECABKAlSBGliYW4SGwoJYmljX3N3aWZ0GBEgASgJUghiaWNTd2lmdBI5Cgpj'
    'cmVhdGVkX2F0GBIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej'
    'kKCnVwZGF0ZWRfYXQYEyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVk'
    'QXQ=');

@$core.Deprecated('Use securitySettingsDescriptor instead')
const SecuritySettings$json = {
  '1': 'SecuritySettings',
  '2': [
    {'1': 'enable_3d_secure', '3': 1, '4': 1, '5': 8, '10': 'enable3dSecure'},
    {'1': 'enable_contactless', '3': 2, '4': 1, '5': 8, '10': 'enableContactless'},
    {'1': 'enable_online_payments', '3': 3, '4': 1, '5': 8, '10': 'enableOnlinePayments'},
  ],
};

/// Descriptor for `SecuritySettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List securitySettingsDescriptor = $convert.base64Decode(
    'ChBTZWN1cml0eVNldHRpbmdzEigKEGVuYWJsZV8zZF9zZWN1cmUYASABKAhSDmVuYWJsZTNkU2'
    'VjdXJlEi0KEmVuYWJsZV9jb250YWN0bGVzcxgCIAEoCFIRZW5hYmxlQ29udGFjdGxlc3MSNAoW'
    'ZW5hYmxlX29ubGluZV9wYXltZW50cxgDIAEoCFIUZW5hYmxlT25saW5lUGF5bWVudHM=');

@$core.Deprecated('Use getUserAccountsRequestDescriptor instead')
const GetUserAccountsRequest$json = {
  '1': 'GetUserAccountsRequest',
};

/// Descriptor for `GetUserAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyQWNjb3VudHNSZXF1ZXN0');

@$core.Deprecated('Use getUserAccountsResponseDescriptor instead')
const GetUserAccountsResponse$json = {
  '1': 'GetUserAccountsResponse',
  '2': [
    {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.pb.AccountSummary', '10': 'accounts'},
  ],
};

/// Descriptor for `GetUserAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyQWNjb3VudHNSZXNwb25zZRIuCghhY2NvdW50cxgBIAMoCzISLnBiLkFjY291bn'
    'RTdW1tYXJ5UghhY2NvdW50cw==');

@$core.Deprecated('Use getAccountDetailsRequestDescriptor instead')
const GetAccountDetailsRequest$json = {
  '1': 'GetAccountDetailsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountDetailsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRBY2NvdW50RGV0YWlsc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudE'
    'lk');

@$core.Deprecated('Use getAccountDetailsResponseDescriptor instead')
const GetAccountDetailsResponse$json = {
  '1': 'GetAccountDetailsResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'account'},
  ],
};

/// Descriptor for `GetAccountDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountDetailsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRBY2NvdW50RGV0YWlsc1Jlc3BvbnNlEiwKB2FjY291bnQYASABKAsyEi5wYi5BY2NvdW'
    '50RGV0YWlsc1IHYWNjb3VudA==');

@$core.Deprecated('Use updateAccountStatusRequestDescriptor instead')
const UpdateAccountStatusRequest$json = {
  '1': 'UpdateAccountStatusRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `UpdateAccountStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountStatusRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVBY2NvdW50U3RhdHVzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgEUglhY2NvdW'
    '50SWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSFgoGcmVhc29uGAMgASgJUgZyZWFzb24=');

@$core.Deprecated('Use updateAccountStatusResponseDescriptor instead')
const UpdateAccountStatusResponse$json = {
  '1': 'UpdateAccountStatusResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'account'},
  ],
};

/// Descriptor for `UpdateAccountStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountStatusResponseDescriptor = $convert.base64Decode(
    'ChtVcGRhdGVBY2NvdW50U3RhdHVzUmVzcG9uc2USLAoHYWNjb3VudBgBIAEoCzISLnBiLkFjY2'
    '91bnREZXRhaWxzUgdhY2NvdW50');

@$core.Deprecated('Use updateSecuritySettingsRequestDescriptor instead')
const UpdateSecuritySettingsRequest$json = {
  '1': 'UpdateSecuritySettingsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'settings', '3': 2, '4': 1, '5': 11, '6': '.pb.SecuritySettings', '10': 'settings'},
  ],
};

/// Descriptor for `UpdateSecuritySettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSecuritySettingsRequestDescriptor = $convert.base64Decode(
    'Ch1VcGRhdGVTZWN1cml0eVNldHRpbmdzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgEUglhY2'
    'NvdW50SWQSMAoIc2V0dGluZ3MYAiABKAsyFC5wYi5TZWN1cml0eVNldHRpbmdzUghzZXR0aW5n'
    'cw==');

@$core.Deprecated('Use updateSecuritySettingsResponseDescriptor instead')
const UpdateSecuritySettingsResponse$json = {
  '1': 'UpdateSecuritySettingsResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'account'},
  ],
};

/// Descriptor for `UpdateSecuritySettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSecuritySettingsResponseDescriptor = $convert.base64Decode(
    'Ch5VcGRhdGVTZWN1cml0eVNldHRpbmdzUmVzcG9uc2USLAoHYWNjb3VudBgBIAEoCzISLnBiLk'
    'FjY291bnREZXRhaWxzUgdhY2NvdW50');

@$core.Deprecated('Use revealPINRequestDescriptor instead')
const RevealPINRequest$json = {
  '1': 'RevealPINRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
  ],
};

/// Descriptor for `RevealPINRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealPINRequestDescriptor = $convert.base64Decode(
    'ChBSZXZlYWxQSU5SZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKARSCWFjY291bnRJZA==');

@$core.Deprecated('Use revealPINResponseDescriptor instead')
const RevealPINResponse$json = {
  '1': 'RevealPINResponse',
  '2': [
    {'1': 'pin', '3': 1, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `RevealPINResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealPINResponseDescriptor = $convert.base64Decode(
    'ChFSZXZlYWxQSU5SZXNwb25zZRIQCgNwaW4YASABKAlSA3Bpbg==');

@$core.Deprecated('Use createSignupAccountsRequestDescriptor instead')
const CreateSignupAccountsRequest$json = {
  '1': 'CreateSignupAccountsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'bvn', '3': 7, '4': 1, '5': 9, '10': 'bvn'},
  ],
};

/// Descriptor for `CreateSignupAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSignupAccountsRequestDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVTaWdudXBBY2NvdW50c1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh'
    '0KCmZpcnN0X25hbWUYAiABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUYAyABKAlSCGxhc3RO'
    'YW1lEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTn'
    'VtYmVyEiEKDGNvdW50cnlfY29kZRgGIAEoCVILY291bnRyeUNvZGUSEAoDYnZuGAcgASgJUgNi'
    'dm4=');

@$core.Deprecated('Use signupAccountInfoDescriptor instead')
const SignupAccountInfo$json = {
  '1': 'SignupAccountInfo',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 3, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'account_type', '3': 4, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'account_label', '3': 5, '4': 1, '5': 9, '10': 'accountLabel'},
    {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_primary', '3': 9, '4': 1, '5': 8, '10': 'isPrimary'},
  ],
};

/// Descriptor for `SignupAccountInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupAccountInfoDescriptor = $convert.base64Decode(
    'ChFTaWdudXBBY2NvdW50SW5mbxIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSJQoOYW'
    'Njb3VudF9udW1iZXIYAiABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAMgASgJ'
    'UgthY2NvdW50TmFtZRIhCgxhY2NvdW50X3R5cGUYBCABKAlSC2FjY291bnRUeXBlEiMKDWFjY2'
    '91bnRfbGFiZWwYBSABKAlSDGFjY291bnRMYWJlbBIbCgliYW5rX25hbWUYBiABKAlSCGJhbmtO'
    'YW1lEhsKCWJhbmtfY29kZRgHIAEoCVIIYmFua0NvZGUSGgoIY3VycmVuY3kYCCABKAlSCGN1cn'
    'JlbmN5Eh0KCmlzX3ByaW1hcnkYCSABKAhSCWlzUHJpbWFyeQ==');

@$core.Deprecated('Use createSignupAccountsResponseDescriptor instead')
const CreateSignupAccountsResponse$json = {
  '1': 'CreateSignupAccountsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'accounts', '3': 4, '4': 3, '5': 11, '6': '.pb.SignupAccountInfo', '10': 'accounts'},
  ],
};

/// Descriptor for `CreateSignupAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSignupAccountsResponseDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVTaWdudXBBY2NvdW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlS'
    'DGVycm9yTWVzc2FnZRIxCghhY2NvdW50cxgEIAMoCzIVLnBiLlNpZ251cEFjY291bnRJbmZvUg'
    'hhY2NvdW50cw==');

