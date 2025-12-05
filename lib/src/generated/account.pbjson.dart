///
//  Generated code. Do not modify.
//  source: account.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
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
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode('CgdBY2NvdW50Eg4KAmlkGAEgASgEUgJpZBIhCgxhY2NvdW50X3R5cGUYAiABKAlSC2FjY291bnRUeXBlEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIYCgdiYWxhbmNlGAQgASgBUgdiYWxhbmNlEiUKDmFjY291bnRfbnVtYmVyGAUgASgJUg1hY2NvdW50TnVtYmVyEhsKCWlzX2FjdGl2ZRgGIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
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
  ],
};

/// Descriptor for `AccountSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSummaryDescriptor = $convert.base64Decode('Cg5BY2NvdW50U3VtbWFyeRIOCgJpZBgBIAEoBFICaWQSIQoMYWNjb3VudF90eXBlGAIgASgJUgthY2NvdW50VHlwZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSGAoHYmFsYW5jZRgEIAEoBFIHYmFsYW5jZRIyChVtYXNrZWRfYWNjb3VudF9udW1iZXIYBSABKAlSE21hc2tlZEFjY291bnROdW1iZXISFgoGc3RhdHVzGAYgASgJUgZzdGF0dXM=');
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
