///
//  Generated code. Do not modify.
//  source: account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use virtualAccountTypeDescriptor instead')
const VirtualAccountType$json = const {
  '1': 'VirtualAccountType',
  '2': const [
    const {'1': 'ACCOUNT_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'ACCOUNT_TYPE_PERSONAL', '2': 1},
    const {'1': 'ACCOUNT_TYPE_SAVINGS', '2': 2},
    const {'1': 'ACCOUNT_TYPE_INVESTMENT', '2': 3},
    const {'1': 'ACCOUNT_TYPE_FAMILY', '2': 4},
    const {'1': 'ACCOUNT_TYPE_BUSINESS', '2': 5},
    const {'1': 'ACCOUNT_TYPE_MAIN', '2': 6},
    const {'1': 'ACCOUNT_TYPE_USD', '2': 7},
    const {'1': 'ACCOUNT_TYPE_GBP', '2': 8},
    const {'1': 'ACCOUNT_TYPE_EUR', '2': 9},
  ],
};

/// Descriptor for `VirtualAccountType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List virtualAccountTypeDescriptor = $convert.base64Decode('ChJWaXJ0dWFsQWNjb3VudFR5cGUSHAoYQUNDT1VOVF9UWVBFX1VOU1BFQ0lGSUVEEAASGQoVQUNDT1VOVF9UWVBFX1BFUlNPTkFMEAESGAoUQUNDT1VOVF9UWVBFX1NBVklOR1MQAhIbChdBQ0NPVU5UX1RZUEVfSU5WRVNUTUVOVBADEhcKE0FDQ09VTlRfVFlQRV9GQU1JTFkQBBIZChVBQ0NPVU5UX1RZUEVfQlVTSU5FU1MQBRIVChFBQ0NPVU5UX1RZUEVfTUFJThAGEhQKEEFDQ09VTlRfVFlQRV9VU0QQBxIUChBBQ0NPVU5UX1RZUEVfR0JQEAgSFAoQQUNDT1VOVF9UWVBFX0VVUhAJ');
@$core.Deprecated('Use accountDescriptor instead')
const Account$json = const {
  '1': 'Account',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'balance', '3': 4, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'account_number', '3': 5, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'is_primary', '3': 9, '4': 1, '5': 8, '10': 'isPrimary'},
    const {'1': 'account_label', '3': 10, '4': 1, '5': 9, '10': 'accountLabel'},
    const {'1': 'bank_name', '3': 11, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'bank_code', '3': 12, '4': 1, '5': 9, '10': 'bankCode'},
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode('CgdBY2NvdW50Eg4KAmlkGAEgASgEUgJpZBIhCgxhY2NvdW50X3R5cGUYAiABKAlSC2FjY291bnRUeXBlEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIYCgdiYWxhbmNlGAQgASgBUgdiYWxhbmNlEiUKDmFjY291bnRfbnVtYmVyGAUgASgJUg1hY2NvdW50TnVtYmVyEhsKCWlzX2FjdGl2ZRgGIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0Eh0KCmlzX3ByaW1hcnkYCSABKAhSCWlzUHJpbWFyeRIjCg1hY2NvdW50X2xhYmVsGAogASgJUgxhY2NvdW50TGFiZWwSGwoJYmFua19uYW1lGAsgASgJUghiYW5rTmFtZRIbCgliYW5rX2NvZGUYDCABKAlSCGJhbmtDb2Rl');
@$core.Deprecated('Use createAccountRequestDescriptor instead')
const CreateAccountRequest$json = const {
  '1': 'CreateAccountRequest',
  '2': const [
    const {'1': 'account_type', '3': 1, '4': 1, '5': 9, '10': 'account_type'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'pin', '17': true},
  ],
  '7': const {},
  '8': const [
    const {'1': '_pin'},
  ],
};

/// Descriptor for `CreateAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVBY2NvdW50UmVxdWVzdBIiCgxhY2NvdW50X3R5cGUYASABKAlSDGFjY291bnRfdHlwZRIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3kSFQoDcGluGAMgASgJSABSA3BpbogBATofkkEcChrSAQxhY2NvdW50X3R5cGXSAQhjdXJyZW5jeUIGCgRfcGlu');
@$core.Deprecated('Use createAccountResponseDescriptor instead')
const CreateAccountResponse$json = const {
  '1': 'CreateAccountResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'account'},
  ],
};

/// Descriptor for `CreateAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVBY2NvdW50UmVzcG9uc2USLAoHYWNjb3VudBgBIAEoCzISLnBiLkFjY291bnREZXRhaWxzUgdhY2NvdW50');
@$core.Deprecated('Use getAccountsRequestDescriptor instead')
const GetAccountsRequest$json = const {
  '1': 'GetAccountsRequest',
};

/// Descriptor for `GetAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsRequestDescriptor = $convert.base64Decode('ChJHZXRBY2NvdW50c1JlcXVlc3Q=');
@$core.Deprecated('Use getAccountsResponseDescriptor instead')
const GetAccountsResponse$json = const {
  '1': 'GetAccountsResponse',
  '2': const [
    const {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.pb.Account', '10': 'accounts'},
  ],
};

/// Descriptor for `GetAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsResponseDescriptor = $convert.base64Decode('ChNHZXRBY2NvdW50c1Jlc3BvbnNlEicKCGFjY291bnRzGAEgAygLMgsucGIuQWNjb3VudFIIYWNjb3VudHM=');
@$core.Deprecated('Use accountSummaryDescriptor instead')
const AccountSummary$json = const {
  '1': 'AccountSummary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'balance', '3': 4, '4': 1, '5': 4, '10': 'balance'},
    const {'1': 'masked_account_number', '3': 5, '4': 1, '5': 9, '10': 'maskedAccountNumber'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'is_primary', '3': 7, '4': 1, '5': 8, '10': 'isPrimary'},
    const {'1': 'account_label', '3': 8, '4': 1, '5': 9, '10': 'accountLabel'},
    const {'1': 'bank_name', '3': 9, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'trend_percentage', '3': 10, '4': 1, '5': 1, '10': 'trendPercentage'},
    const {'1': 'is_family_account', '3': 11, '4': 1, '5': 8, '10': 'isFamilyAccount'},
    const {'1': 'family_total_balance', '3': 12, '4': 1, '5': 4, '10': 'familyTotalBalance'},
    const {'1': 'member_allocated_balance', '3': 13, '4': 1, '5': 4, '10': 'memberAllocatedBalance'},
    const {'1': 'member_count', '3': 14, '4': 1, '5': 5, '10': 'memberCount'},
  ],
};

/// Descriptor for `AccountSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSummaryDescriptor = $convert.base64Decode('Cg5BY2NvdW50U3VtbWFyeRIOCgJpZBgBIAEoBFICaWQSIQoMYWNjb3VudF90eXBlGAIgASgJUgthY2NvdW50VHlwZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSGAoHYmFsYW5jZRgEIAEoBFIHYmFsYW5jZRIyChVtYXNrZWRfYWNjb3VudF9udW1iZXIYBSABKAlSE21hc2tlZEFjY291bnROdW1iZXISFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSHQoKaXNfcHJpbWFyeRgHIAEoCFIJaXNQcmltYXJ5EiMKDWFjY291bnRfbGFiZWwYCCABKAlSDGFjY291bnRMYWJlbBIbCgliYW5rX25hbWUYCSABKAlSCGJhbmtOYW1lEikKEHRyZW5kX3BlcmNlbnRhZ2UYCiABKAFSD3RyZW5kUGVyY2VudGFnZRIqChFpc19mYW1pbHlfYWNjb3VudBgLIAEoCFIPaXNGYW1pbHlBY2NvdW50EjAKFGZhbWlseV90b3RhbF9iYWxhbmNlGAwgASgEUhJmYW1pbHlUb3RhbEJhbGFuY2USOAoYbWVtYmVyX2FsbG9jYXRlZF9iYWxhbmNlGA0gASgEUhZtZW1iZXJBbGxvY2F0ZWRCYWxhbmNlEiEKDG1lbWJlcl9jb3VudBgOIAEoBVILbWVtYmVyQ291bnQ=');
@$core.Deprecated('Use accountDetailsDescriptor instead')
const AccountDetails$json = const {
  '1': 'AccountDetails',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'balance', '3': 4, '4': 1, '5': 4, '10': 'balance'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'card_holder_name', '3': 7, '4': 1, '5': 9, '10': 'cardHolderName'},
    const {'1': 'card_type', '3': 8, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'expiry_date', '3': 9, '4': 1, '5': 9, '10': 'expiryDate'},
    const {'1': 'daily_limit', '3': 10, '4': 1, '5': 4, '10': 'dailyLimit'},
    const {'1': 'monthly_limit', '3': 11, '4': 1, '5': 4, '10': 'monthlyLimit'},
    const {'1': 'enable_3d_secure', '3': 12, '4': 1, '5': 8, '10': 'enable3dSecure'},
    const {'1': 'enable_contactless', '3': 13, '4': 1, '5': 8, '10': 'enableContactless'},
    const {'1': 'enable_online_payments', '3': 14, '4': 1, '5': 8, '10': 'enableOnlinePayments'},
    const {'1': 'account_number', '3': 15, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'iban', '3': 16, '4': 1, '5': 9, '10': 'iban'},
    const {'1': 'bic_swift', '3': 17, '4': 1, '5': 9, '10': 'bicSwift'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `AccountDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDetailsDescriptor = $convert.base64Decode('Cg5BY2NvdW50RGV0YWlscxIOCgJpZBgBIAEoBFICaWQSIQoMYWNjb3VudF90eXBlGAIgASgJUgthY2NvdW50VHlwZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSGAoHYmFsYW5jZRgEIAEoBFIHYmFsYW5jZRIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIoChBjYXJkX2hvbGRlcl9uYW1lGAcgASgJUg5jYXJkSG9sZGVyTmFtZRIbCgljYXJkX3R5cGUYCCABKAlSCGNhcmRUeXBlEh8KC2V4cGlyeV9kYXRlGAkgASgJUgpleHBpcnlEYXRlEh8KC2RhaWx5X2xpbWl0GAogASgEUgpkYWlseUxpbWl0EiMKDW1vbnRobHlfbGltaXQYCyABKARSDG1vbnRobHlMaW1pdBIoChBlbmFibGVfM2Rfc2VjdXJlGAwgASgIUg5lbmFibGUzZFNlY3VyZRItChJlbmFibGVfY29udGFjdGxlc3MYDSABKAhSEWVuYWJsZUNvbnRhY3RsZXNzEjQKFmVuYWJsZV9vbmxpbmVfcGF5bWVudHMYDiABKAhSFGVuYWJsZU9ubGluZVBheW1lbnRzEiUKDmFjY291bnRfbnVtYmVyGA8gASgJUg1hY2NvdW50TnVtYmVyEhIKBGliYW4YECABKAlSBGliYW4SGwoJYmljX3N3aWZ0GBEgASgJUghiaWNTd2lmdBI5CgpjcmVhdGVkX2F0GBIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYEyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use securitySettingsDescriptor instead')
const SecuritySettings$json = const {
  '1': 'SecuritySettings',
  '2': const [
    const {'1': 'enable_3d_secure', '3': 1, '4': 1, '5': 8, '10': 'enable3dSecure'},
    const {'1': 'enable_contactless', '3': 2, '4': 1, '5': 8, '10': 'enableContactless'},
    const {'1': 'enable_online_payments', '3': 3, '4': 1, '5': 8, '10': 'enableOnlinePayments'},
  ],
};

/// Descriptor for `SecuritySettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List securitySettingsDescriptor = $convert.base64Decode('ChBTZWN1cml0eVNldHRpbmdzEigKEGVuYWJsZV8zZF9zZWN1cmUYASABKAhSDmVuYWJsZTNkU2VjdXJlEi0KEmVuYWJsZV9jb250YWN0bGVzcxgCIAEoCFIRZW5hYmxlQ29udGFjdGxlc3MSNAoWZW5hYmxlX29ubGluZV9wYXltZW50cxgDIAEoCFIUZW5hYmxlT25saW5lUGF5bWVudHM=');
@$core.Deprecated('Use getUserAccountsRequestDescriptor instead')
const GetUserAccountsRequest$json = const {
  '1': 'GetUserAccountsRequest',
};

/// Descriptor for `GetUserAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountsRequestDescriptor = $convert.base64Decode('ChZHZXRVc2VyQWNjb3VudHNSZXF1ZXN0');
@$core.Deprecated('Use getUserAccountsResponseDescriptor instead')
const GetUserAccountsResponse$json = const {
  '1': 'GetUserAccountsResponse',
  '2': const [
    const {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.pb.AccountSummary', '10': 'accounts'},
  ],
};

/// Descriptor for `GetUserAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountsResponseDescriptor = $convert.base64Decode('ChdHZXRVc2VyQWNjb3VudHNSZXNwb25zZRIuCghhY2NvdW50cxgBIAMoCzISLnBiLkFjY291bnRTdW1tYXJ5UghhY2NvdW50cw==');
@$core.Deprecated('Use getAccountDetailsRequestDescriptor instead')
const GetAccountDetailsRequest$json = const {
  '1': 'GetAccountDetailsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountDetailsRequestDescriptor = $convert.base64Decode('ChhHZXRBY2NvdW50RGV0YWlsc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudElk');
@$core.Deprecated('Use getAccountDetailsResponseDescriptor instead')
const GetAccountDetailsResponse$json = const {
  '1': 'GetAccountDetailsResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'account'},
  ],
};

/// Descriptor for `GetAccountDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountDetailsResponseDescriptor = $convert.base64Decode('ChlHZXRBY2NvdW50RGV0YWlsc1Jlc3BvbnNlEiwKB2FjY291bnQYASABKAsyEi5wYi5BY2NvdW50RGV0YWlsc1IHYWNjb3VudA==');
@$core.Deprecated('Use updateAccountStatusRequestDescriptor instead')
const UpdateAccountStatusRequest$json = const {
  '1': 'UpdateAccountStatusRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `UpdateAccountStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountStatusRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVBY2NvdW50U3RhdHVzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgEUglhY2NvdW50SWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSFgoGcmVhc29uGAMgASgJUgZyZWFzb24=');
@$core.Deprecated('Use updateAccountStatusResponseDescriptor instead')
const UpdateAccountStatusResponse$json = const {
  '1': 'UpdateAccountStatusResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'account'},
  ],
};

/// Descriptor for `UpdateAccountStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountStatusResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVBY2NvdW50U3RhdHVzUmVzcG9uc2USLAoHYWNjb3VudBgBIAEoCzISLnBiLkFjY291bnREZXRhaWxzUgdhY2NvdW50');
@$core.Deprecated('Use updateSecuritySettingsRequestDescriptor instead')
const UpdateSecuritySettingsRequest$json = const {
  '1': 'UpdateSecuritySettingsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'settings', '3': 2, '4': 1, '5': 11, '6': '.pb.SecuritySettings', '10': 'settings'},
  ],
};

/// Descriptor for `UpdateSecuritySettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSecuritySettingsRequestDescriptor = $convert.base64Decode('Ch1VcGRhdGVTZWN1cml0eVNldHRpbmdzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgEUglhY2NvdW50SWQSMAoIc2V0dGluZ3MYAiABKAsyFC5wYi5TZWN1cml0eVNldHRpbmdzUghzZXR0aW5ncw==');
@$core.Deprecated('Use updateSecuritySettingsResponseDescriptor instead')
const UpdateSecuritySettingsResponse$json = const {
  '1': 'UpdateSecuritySettingsResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountDetails', '10': 'account'},
  ],
};

/// Descriptor for `UpdateSecuritySettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSecuritySettingsResponseDescriptor = $convert.base64Decode('Ch5VcGRhdGVTZWN1cml0eVNldHRpbmdzUmVzcG9uc2USLAoHYWNjb3VudBgBIAEoCzISLnBiLkFjY291bnREZXRhaWxzUgdhY2NvdW50');
@$core.Deprecated('Use revealPINRequestDescriptor instead')
const RevealPINRequest$json = const {
  '1': 'RevealPINRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
  ],
};

/// Descriptor for `RevealPINRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealPINRequestDescriptor = $convert.base64Decode('ChBSZXZlYWxQSU5SZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKARSCWFjY291bnRJZA==');
@$core.Deprecated('Use revealPINResponseDescriptor instead')
const RevealPINResponse$json = const {
  '1': 'RevealPINResponse',
  '2': const [
    const {'1': 'pin', '3': 1, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `RevealPINResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealPINResponseDescriptor = $convert.base64Decode('ChFSZXZlYWxQSU5SZXNwb25zZRIQCgNwaW4YASABKAlSA3Bpbg==');
@$core.Deprecated('Use createSignupAccountsRequestDescriptor instead')
const CreateSignupAccountsRequest$json = const {
  '1': 'CreateSignupAccountsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'bvn', '3': 7, '4': 1, '5': 9, '10': 'bvn'},
  ],
};

/// Descriptor for `CreateSignupAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSignupAccountsRequestDescriptor = $convert.base64Decode('ChtDcmVhdGVTaWdudXBBY2NvdW50c1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh0KCmZpcnN0X25hbWUYAiABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUYAyABKAlSCGxhc3ROYW1lEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEiEKDGNvdW50cnlfY29kZRgGIAEoCVILY291bnRyeUNvZGUSEAoDYnZuGAcgASgJUgNidm4=');
@$core.Deprecated('Use signupAccountInfoDescriptor instead')
const SignupAccountInfo$json = const {
  '1': 'SignupAccountInfo',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 3, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'account_type', '3': 4, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'account_label', '3': 5, '4': 1, '5': 9, '10': 'accountLabel'},
    const {'1': 'bank_name', '3': 6, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_primary', '3': 9, '4': 1, '5': 8, '10': 'isPrimary'},
  ],
};

/// Descriptor for `SignupAccountInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signupAccountInfoDescriptor = $convert.base64Decode('ChFTaWdudXBBY2NvdW50SW5mbxIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSJQoOYWNjb3VudF9udW1iZXIYAiABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAMgASgJUgthY2NvdW50TmFtZRIhCgxhY2NvdW50X3R5cGUYBCABKAlSC2FjY291bnRUeXBlEiMKDWFjY291bnRfbGFiZWwYBSABKAlSDGFjY291bnRMYWJlbBIbCgliYW5rX25hbWUYBiABKAlSCGJhbmtOYW1lEhsKCWJhbmtfY29kZRgHIAEoCVIIYmFua0NvZGUSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5Eh0KCmlzX3ByaW1hcnkYCSABKAhSCWlzUHJpbWFyeQ==');
@$core.Deprecated('Use createSignupAccountsResponseDescriptor instead')
const CreateSignupAccountsResponse$json = const {
  '1': 'CreateSignupAccountsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'accounts', '3': 4, '4': 3, '5': 11, '6': '.pb.SignupAccountInfo', '10': 'accounts'},
  ],
};

/// Descriptor for `CreateSignupAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSignupAccountsResponseDescriptor = $convert.base64Decode('ChxDcmVhdGVTaWdudXBBY2NvdW50c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIxCghhY2NvdW50cxgEIAMoCzIVLnBiLlNpZ251cEFjY291bnRJbmZvUghhY2NvdW50cw==');
