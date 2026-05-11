///
//  Generated code. Do not modify.
//  source: accounts.proto
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
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'account_type', '3': 5, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'locale', '3': 7, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'balance', '3': 8, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'available_balance', '3': 9, '4': 1, '5': 1, '10': 'availableBalance'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'is_primary', '3': 11, '4': 1, '5': 8, '10': 'isPrimary'},
    const {'1': 'bank_code', '3': 12, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'branch_code', '3': 13, '4': 1, '5': 9, '10': 'branchCode'},
    const {'1': 'freeze_reason_code', '3': 14, '4': 1, '5': 5, '10': 'freezeReasonCode'},
    const {'1': 'freeze_reason', '3': 15, '4': 1, '5': 9, '10': 'freezeReason'},
    const {'1': 'frozen_at', '3': 16, '4': 1, '5': 9, '10': 'frozenAt'},
    const {'1': 'frozen_by', '3': 17, '4': 1, '5': 9, '10': 'frozenBy'},
    const {'1': 'daily_limit', '3': 18, '4': 1, '5': 1, '10': 'dailyLimit'},
    const {'1': 'monthly_limit', '3': 19, '4': 1, '5': 1, '10': 'monthlyLimit'},
    const {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'is_virtual', '3': 22, '4': 1, '5': 8, '10': 'isVirtual'},
    const {'1': 'provider', '3': 23, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_ref', '3': 24, '4': 1, '5': 9, '10': 'providerRef'},
    const {'1': 'bank_name', '3': 25, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'single_transaction_limit', '3': 26, '4': 1, '5': 1, '10': 'singleTransactionLimit'},
    const {'1': 'reserved_balance', '3': 27, '4': 1, '5': 1, '10': 'reservedBalance'},
    const {'1': 'kyc_tier', '3': 28, '4': 1, '5': 5, '10': 'kycTier'},
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode('CgdBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYWNjb3VudF9udW1iZXIYAyABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAQgASgJUgthY2NvdW50TmFtZRIhCgxhY2NvdW50X3R5cGUYBSABKAlSC2FjY291bnRUeXBlEhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIWCgZsb2NhbGUYByABKAlSBmxvY2FsZRIYCgdiYWxhbmNlGAggASgBUgdiYWxhbmNlEisKEWF2YWlsYWJsZV9iYWxhbmNlGAkgASgBUhBhdmFpbGFibGVCYWxhbmNlEhYKBnN0YXR1cxgKIAEoCVIGc3RhdHVzEh0KCmlzX3ByaW1hcnkYCyABKAhSCWlzUHJpbWFyeRIbCgliYW5rX2NvZGUYDCABKAlSCGJhbmtDb2RlEh8KC2JyYW5jaF9jb2RlGA0gASgJUgpicmFuY2hDb2RlEiwKEmZyZWV6ZV9yZWFzb25fY29kZRgOIAEoBVIQZnJlZXplUmVhc29uQ29kZRIjCg1mcmVlemVfcmVhc29uGA8gASgJUgxmcmVlemVSZWFzb24SGwoJZnJvemVuX2F0GBAgASgJUghmcm96ZW5BdBIbCglmcm96ZW5fYnkYESABKAlSCGZyb3plbkJ5Eh8KC2RhaWx5X2xpbWl0GBIgASgBUgpkYWlseUxpbWl0EiMKDW1vbnRobHlfbGltaXQYEyABKAFSDG1vbnRobHlMaW1pdBIdCgpjcmVhdGVkX2F0GBQgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgVIAEoCVIJdXBkYXRlZEF0Eh0KCmlzX3ZpcnR1YWwYFiABKAhSCWlzVmlydHVhbBIaCghwcm92aWRlchgXIAEoCVIIcHJvdmlkZXISIQoMcHJvdmlkZXJfcmVmGBggASgJUgtwcm92aWRlclJlZhIbCgliYW5rX25hbWUYGSABKAlSCGJhbmtOYW1lEjgKGHNpbmdsZV90cmFuc2FjdGlvbl9saW1pdBgaIAEoAVIWc2luZ2xlVHJhbnNhY3Rpb25MaW1pdBIpChByZXNlcnZlZF9iYWxhbmNlGBsgASgBUg9yZXNlcnZlZEJhbGFuY2USGQoIa3ljX3RpZXIYHCABKAVSB2t5Y1RpZXI=');
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
    const {'1': 'uuid', '3': 7, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'account_number', '3': 8, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'available_balance', '3': 9, '4': 1, '5': 4, '10': 'availableBalance'},
    const {'1': 'reserved_balance', '3': 10, '4': 1, '5': 4, '10': 'reservedBalance'},
    const {'1': 'account_name', '3': 11, '4': 1, '5': 9, '10': 'accountName'},
  ],
};

/// Descriptor for `AccountSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSummaryDescriptor = $convert.base64Decode('Cg5BY2NvdW50U3VtbWFyeRIOCgJpZBgBIAEoBFICaWQSIQoMYWNjb3VudF90eXBlGAIgASgJUgthY2NvdW50VHlwZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSGAoHYmFsYW5jZRgEIAEoBFIHYmFsYW5jZRIyChVtYXNrZWRfYWNjb3VudF9udW1iZXIYBSABKAlSE21hc2tlZEFjY291bnROdW1iZXISFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSEgoEdXVpZBgHIAEoCVIEdXVpZBIlCg5hY2NvdW50X251bWJlchgIIAEoCVINYWNjb3VudE51bWJlchIrChFhdmFpbGFibGVfYmFsYW5jZRgJIAEoBFIQYXZhaWxhYmxlQmFsYW5jZRIpChByZXNlcnZlZF9iYWxhbmNlGAogASgEUg9yZXNlcnZlZEJhbGFuY2USIQoMYWNjb3VudF9uYW1lGAsgASgJUgthY2NvdW50TmFtZQ==');
@$core.Deprecated('Use getUserAccountsRequestDescriptor instead')
const GetUserAccountsRequest$json = const {
  '1': 'GetUserAccountsRequest',
  '2': const [
    const {'1': 'target_user_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'targetUserId', '17': true},
  ],
  '8': const [
    const {'1': '_target_user_id'},
  ],
};

/// Descriptor for `GetUserAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountsRequestDescriptor = $convert.base64Decode('ChZHZXRVc2VyQWNjb3VudHNSZXF1ZXN0EikKDnRhcmdldF91c2VyX2lkGAEgASgJSABSDHRhcmdldFVzZXJJZIgBAUIRCg9fdGFyZ2V0X3VzZXJfaWQ=');
@$core.Deprecated('Use getUserAccountsResponseDescriptor instead')
const GetUserAccountsResponse$json = const {
  '1': 'GetUserAccountsResponse',
  '2': const [
    const {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.accounts.AccountSummary', '10': 'accounts'},
  ],
};

/// Descriptor for `GetUserAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountsResponseDescriptor = $convert.base64Decode('ChdHZXRVc2VyQWNjb3VudHNSZXNwb25zZRI0CghhY2NvdW50cxgBIAMoCzIYLmFjY291bnRzLkFjY291bnRTdW1tYXJ5UghhY2NvdW50cw==');
@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = const {
  '1': 'Transaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'balance_before', '3': 7, '4': 1, '5': 1, '10': 'balanceBefore'},
    const {'1': 'balance_after', '3': 8, '4': 1, '5': 1, '10': 'balanceAfter'},
    const {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 10, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'locale', '3': 12, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'service_name', '3': 13, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'counterparty_name', '3': 15, '4': 1, '5': 9, '10': 'counterpartyName'},
    const {'1': 'counterparty_account', '3': 16, '4': 1, '5': 9, '10': 'counterpartyAccount'},
    const {'1': 'updated_at', '3': 17, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode('CgtUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhIKBHR5cGUYBCABKAlSBHR5cGUSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EiUKDmJhbGFuY2VfYmVmb3JlGAcgASgBUg1iYWxhbmNlQmVmb3JlEiMKDWJhbGFuY2VfYWZ0ZXIYCCABKAFSDGJhbGFuY2VBZnRlchIgCgtkZXNjcmlwdGlvbhgJIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYCiABKAlSCG1ldGFkYXRhEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEhYKBmxvY2FsZRgMIAEoCVIGbG9jYWxlEiEKDHNlcnZpY2VfbmFtZRgNIAEoCVILc2VydmljZU5hbWUSHQoKY3JlYXRlZF9hdBgOIAEoCVIJY3JlYXRlZEF0EisKEWNvdW50ZXJwYXJ0eV9uYW1lGA8gASgJUhBjb3VudGVycGFydHlOYW1lEjEKFGNvdW50ZXJwYXJ0eV9hY2NvdW50GBAgASgJUhNjb3VudGVycGFydHlBY2NvdW50Eh0KCnVwZGF0ZWRfYXQYESABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use createAccountRequestDescriptor instead')
const CreateAccountRequest$json = const {
  '1': 'CreateAccountRequest',
  '2': const [
    const {'1': 'account_name', '3': 1, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'locale', '3': 4, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'is_primary', '3': 5, '4': 1, '5': 8, '10': 'isPrimary'},
    const {'1': 'daily_limit', '3': 6, '4': 1, '5': 1, '10': 'dailyLimit'},
    const {'1': 'monthly_limit', '3': 7, '4': 1, '5': 1, '10': 'monthlyLimit'},
  ],
};

/// Descriptor for `CreateAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVBY2NvdW50UmVxdWVzdBIhCgxhY2NvdW50X25hbWUYASABKAlSC2FjY291bnROYW1lEiEKDGFjY291bnRfdHlwZRgCIAEoCVILYWNjb3VudFR5cGUSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EhYKBmxvY2FsZRgEIAEoCVIGbG9jYWxlEh0KCmlzX3ByaW1hcnkYBSABKAhSCWlzUHJpbWFyeRIfCgtkYWlseV9saW1pdBgGIAEoAVIKZGFpbHlMaW1pdBIjCg1tb250aGx5X2xpbWl0GAcgASgBUgxtb250aGx5TGltaXQ=');
@$core.Deprecated('Use createAccountResponseDescriptor instead')
const CreateAccountResponse$json = const {
  '1': 'CreateAccountResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY291bnRSB2FjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getAccountsRequestDescriptor instead')
const GetAccountsRequest$json = const {
  '1': 'GetAccountsRequest',
  '2': const [
    const {'1': 'account_type', '3': 1, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsRequestDescriptor = $convert.base64Decode('ChJHZXRBY2NvdW50c1JlcXVlc3QSIQoMYWNjb3VudF90eXBlGAEgASgJUgthY2NvdW50VHlwZRIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAQgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getAccountsResponseDescriptor instead')
const GetAccountsResponse$json = const {
  '1': 'GetAccountsResponse',
  '2': const [
    const {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.accounts.Account', '10': 'accounts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsResponseDescriptor = $convert.base64Decode('ChNHZXRBY2NvdW50c1Jlc3BvbnNlEi0KCGFjY291bnRzGAEgAygLMhEuYWNjb3VudHMuQWNjb3VudFIIYWNjb3VudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getAccountRequestDescriptor instead')
const GetAccountRequest$json = const {
  '1': 'GetAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountRequestDescriptor = $convert.base64Decode('ChFHZXRBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');
@$core.Deprecated('Use getAccountResponseDescriptor instead')
const GetAccountResponse$json = const {
  '1': 'GetAccountResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
  ],
};

/// Descriptor for `GetAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountResponseDescriptor = $convert.base64Decode('ChJHZXRBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY291bnRSB2FjY291bnQ=');
@$core.Deprecated('Use getAccountByNumberRequestDescriptor instead')
const GetAccountByNumberRequest$json = const {
  '1': 'GetAccountByNumberRequest',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `GetAccountByNumberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountByNumberRequestDescriptor = $convert.base64Decode('ChlHZXRBY2NvdW50QnlOdW1iZXJSZXF1ZXN0EiUKDmFjY291bnRfbnVtYmVyGAEgASgJUg1hY2NvdW50TnVtYmVy');
@$core.Deprecated('Use getAccountByNumberResponseDescriptor instead')
const GetAccountByNumberResponse$json = const {
  '1': 'GetAccountByNumberResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
  ],
};

/// Descriptor for `GetAccountByNumberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountByNumberResponseDescriptor = $convert.base64Decode('ChpHZXRBY2NvdW50QnlOdW1iZXJSZXNwb25zZRIrCgdhY2NvdW50GAEgASgLMhEuYWNjb3VudHMuQWNjb3VudFIHYWNjb3VudA==');
@$core.Deprecated('Use updateAccountRequestDescriptor instead')
const UpdateAccountRequest$json = const {
  '1': 'UpdateAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'account_name', '3': 2, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'daily_limit', '3': 3, '4': 1, '5': 1, '10': 'dailyLimit'},
    const {'1': 'monthly_limit', '3': 4, '4': 1, '5': 1, '10': 'monthlyLimit'},
    const {'1': 'is_primary', '3': 5, '4': 1, '5': 8, '10': 'isPrimary'},
  ],
};

/// Descriptor for `UpdateAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSIQoMYWNjb3VudF9uYW1lGAIgASgJUgthY2NvdW50TmFtZRIfCgtkYWlseV9saW1pdBgDIAEoAVIKZGFpbHlMaW1pdBIjCg1tb250aGx5X2xpbWl0GAQgASgBUgxtb250aGx5TGltaXQSHQoKaXNfcHJpbWFyeRgFIAEoCFIJaXNQcmltYXJ5');
@$core.Deprecated('Use updateAccountResponseDescriptor instead')
const UpdateAccountResponse$json = const {
  '1': 'UpdateAccountResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountResponseDescriptor = $convert.base64Decode('ChVVcGRhdGVBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY291bnRSB2FjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteAccountRequestDescriptor instead')
const DeleteAccountRequest$json = const {
  '1': 'DeleteAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `DeleteAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAccountRequestDescriptor = $convert.base64Decode('ChREZWxldGVBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');
@$core.Deprecated('Use deleteAccountResponseDescriptor instead')
const DeleteAccountResponse$json = const {
  '1': 'DeleteAccountResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAccountResponseDescriptor = $convert.base64Decode('ChVEZWxldGVBY2NvdW50UmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNz');
@$core.Deprecated('Use getBalanceRequestDescriptor instead')
const GetBalanceRequest$json = const {
  '1': 'GetBalanceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBalanceRequestDescriptor = $convert.base64Decode('ChFHZXRCYWxhbmNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');
@$core.Deprecated('Use getBalanceResponseDescriptor instead')
const GetBalanceResponse$json = const {
  '1': 'GetBalanceResponse',
  '2': const [
    const {'1': 'balance', '3': 1, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'available_balance', '3': 2, '4': 1, '5': 1, '10': 'availableBalance'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'last_updated', '3': 4, '4': 1, '5': 9, '10': 'lastUpdated'},
  ],
};

/// Descriptor for `GetBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBalanceResponseDescriptor = $convert.base64Decode('ChJHZXRCYWxhbmNlUmVzcG9uc2USGAoHYmFsYW5jZRgBIAEoAVIHYmFsYW5jZRIrChFhdmFpbGFibGVfYmFsYW5jZRgCIAEoAVIQYXZhaWxhYmxlQmFsYW5jZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSIQoMbGFzdF91cGRhdGVkGAQgASgJUgtsYXN0VXBkYXRlZA==');
@$core.Deprecated('Use updateBalanceRequestDescriptor instead')
const UpdateBalanceRequest$json = const {
  '1': 'UpdateBalanceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'operation', '3': 3, '4': 1, '5': 9, '10': 'operation'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'reactive', '3': 7, '4': 1, '5': 8, '10': 'reactive'},
  ],
};

/// Descriptor for `UpdateBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBalanceRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVCYWxhbmNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSHAoJb3BlcmF0aW9uGAMgASgJUglvcGVyYXRpb24SHAoJcmVmZXJlbmNlGAQgASgJUglyZWZlcmVuY2USIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEhoKCGNhdGVnb3J5GAYgASgJUghjYXRlZ29yeRIaCghyZWFjdGl2ZRgHIAEoCFIIcmVhY3RpdmU=');
@$core.Deprecated('Use updateBalanceResponseDescriptor instead')
const UpdateBalanceResponse$json = const {
  '1': 'UpdateBalanceResponse',
  '2': const [
    const {'1': 'new_balance', '3': 1, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'available_balance', '3': 2, '4': 1, '5': 1, '10': 'availableBalance'},
    const {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
  ],
};

/// Descriptor for `UpdateBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBalanceResponseDescriptor = $convert.base64Decode('ChVVcGRhdGVCYWxhbmNlUmVzcG9uc2USHwoLbmV3X2JhbGFuY2UYASABKAFSCm5ld0JhbGFuY2USKwoRYXZhaWxhYmxlX2JhbGFuY2UYAiABKAFSEGF2YWlsYWJsZUJhbGFuY2USNwoLdHJhbnNhY3Rpb24YAyABKAsyFS5hY2NvdW50cy5UcmFuc2FjdGlvblILdHJhbnNhY3Rpb24=');
@$core.Deprecated('Use getTransactionsRequestDescriptor instead')
const GetTransactionsRequest$json = const {
  '1': 'GetTransactionsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'start_date', '3': 5, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 6, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 7, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 8, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsRequestDescriptor = $convert.base64Decode('ChZHZXRUcmFuc2FjdGlvbnNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgR0eXBlGAIgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxIdCgpzdGFydF9kYXRlGAUgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYBiABKAlSB2VuZERhdGUSFAoFbGltaXQYByABKAVSBWxpbWl0EhYKBm9mZnNldBgIIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getTransactionsResponseDescriptor instead')
const GetTransactionsResponse$json = const {
  '1': 'GetTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.Transaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_credits', '3': 3, '4': 1, '5': 1, '10': 'totalCredits'},
    const {'1': 'total_debits', '3': 4, '4': 1, '5': 1, '10': 'totalDebits'},
  ],
};

/// Descriptor for `GetTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsResponseDescriptor = $convert.base64Decode('ChdHZXRUcmFuc2FjdGlvbnNSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS5hY2NvdW50cy5UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbBIjCg10b3RhbF9jcmVkaXRzGAMgASgBUgx0b3RhbENyZWRpdHMSIQoMdG90YWxfZGViaXRzGAQgASgBUgt0b3RhbERlYml0cw==');
@$core.Deprecated('Use freezeAccountRequestDescriptor instead')
const FreezeAccountRequest$json = const {
  '1': 'FreezeAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'reason_code', '3': 3, '4': 1, '5': 5, '10': 'reasonCode'},
    const {'1': 'frozen_by', '3': 4, '4': 1, '5': 9, '10': 'frozenBy'},
  ],
};

/// Descriptor for `FreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeAccountRequestDescriptor = $convert.base64Decode('ChRGcmVlemVBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24SHwoLcmVhc29uX2NvZGUYAyABKAVSCnJlYXNvbkNvZGUSGwoJZnJvemVuX2J5GAQgASgJUghmcm96ZW5CeQ==');
@$core.Deprecated('Use freezeAccountResponseDescriptor instead')
const FreezeAccountResponse$json = const {
  '1': 'FreezeAccountResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `FreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeAccountResponseDescriptor = $convert.base64Decode('ChVGcmVlemVBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY291bnRSB2FjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use unfreezeAccountRequestDescriptor instead')
const UnfreezeAccountRequest$json = const {
  '1': 'UnfreezeAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'unfrozen_by', '3': 2, '4': 1, '5': 9, '10': 'unfrozenBy'},
  ],
};

/// Descriptor for `UnfreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeAccountRequestDescriptor = $convert.base64Decode('ChZVbmZyZWV6ZUFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIfCgt1bmZyb3plbl9ieRgCIAEoCVIKdW5mcm96ZW5CeQ==');
@$core.Deprecated('Use unfreezeAccountResponseDescriptor instead')
const UnfreezeAccountResponse$json = const {
  '1': 'UnfreezeAccountResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnfreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeAccountResponseDescriptor = $convert.base64Decode('ChdVbmZyZWV6ZUFjY291bnRSZXNwb25zZRIrCgdhY2NvdW50GAEgASgLMhEuYWNjb3VudHMuQWNjb3VudFIHYWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use autoSaveDescriptor instead')
const AutoSave$json = const {
  '1': 'AutoSave',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 6, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'trigger', '3': 7, '4': 1, '5': 9, '10': 'trigger'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'target_account_id', '3': 9, '4': 1, '5': 9, '10': 'targetAccountId'},
    const {'1': 'target_amount', '3': 10, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AutoSave`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveDescriptor = $convert.base64Decode('CghBdXRvU2F2ZRIOCgJpZBgBIAEoCVICaWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBISCgRuYW1lGAQgASgJUgRuYW1lEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhwKCWZyZXF1ZW5jeRgGIAEoCVIJZnJlcXVlbmN5EhgKB3RyaWdnZXIYByABKAlSB3RyaWdnZXISFgoGc3RhdHVzGAggASgJUgZzdGF0dXMSKgoRdGFyZ2V0X2FjY291bnRfaWQYCSABKAlSD3RhcmdldEFjY291bnRJZBIjCg10YXJnZXRfYW1vdW50GAogASgBUgx0YXJnZXRBbW91bnQSHQoKY3JlYXRlZF9hdBgLIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYDCABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use createAutoSaveRequestDescriptor instead')
const CreateAutoSaveRequest$json = const {
  '1': 'CreateAutoSaveRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'trigger', '3': 5, '4': 1, '5': 9, '10': 'trigger'},
    const {'1': 'target_account_id', '3': 6, '4': 1, '5': 9, '10': 'targetAccountId'},
    const {'1': 'target_amount', '3': 7, '4': 1, '5': 1, '10': 'targetAmount'},
  ],
};

/// Descriptor for `CreateAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveRequestDescriptor = $convert.base64Decode('ChVDcmVhdGVBdXRvU2F2ZVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhIKBG5hbWUYAiABKAlSBG5hbWUSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSHAoJZnJlcXVlbmN5GAQgASgJUglmcmVxdWVuY3kSGAoHdHJpZ2dlchgFIAEoCVIHdHJpZ2dlchIqChF0YXJnZXRfYWNjb3VudF9pZBgGIAEoCVIPdGFyZ2V0QWNjb3VudElkEiMKDXRhcmdldF9hbW91bnQYByABKAFSDHRhcmdldEFtb3VudA==');
@$core.Deprecated('Use createAutoSaveResponseDescriptor instead')
const CreateAutoSaveResponse$json = const {
  '1': 'CreateAutoSaveResponse',
  '2': const [
    const {'1': 'autosave', '3': 1, '4': 1, '5': 11, '6': '.accounts.AutoSave', '10': 'autosave'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveResponseDescriptor = $convert.base64Decode('ChZDcmVhdGVBdXRvU2F2ZVJlc3BvbnNlEi4KCGF1dG9zYXZlGAEgASgLMhIuYWNjb3VudHMuQXV0b1NhdmVSCGF1dG9zYXZlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getAutoSavesRequestDescriptor instead')
const GetAutoSavesRequest$json = const {
  '1': 'GetAutoSavesRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetAutoSavesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSavesRequestDescriptor = $convert.base64Decode('ChNHZXRBdXRvU2F2ZXNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cw==');
@$core.Deprecated('Use getAutoSavesResponseDescriptor instead')
const GetAutoSavesResponse$json = const {
  '1': 'GetAutoSavesResponse',
  '2': const [
    const {'1': 'autosaves', '3': 1, '4': 3, '5': 11, '6': '.accounts.AutoSave', '10': 'autosaves'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAutoSavesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSavesResponseDescriptor = $convert.base64Decode('ChRHZXRBdXRvU2F2ZXNSZXNwb25zZRIwCglhdXRvc2F2ZXMYASADKAsyEi5hY2NvdW50cy5BdXRvU2F2ZVIJYXV0b3NhdmVzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use updateAutoSaveRequestDescriptor instead')
const UpdateAutoSaveRequest$json = const {
  '1': 'UpdateAutoSaveRequest',
  '2': const [
    const {'1': 'autosave_id', '3': 1, '4': 1, '5': 9, '10': 'autosaveId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
  ],
};

/// Descriptor for `UpdateAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveRequestDescriptor = $convert.base64Decode('ChVVcGRhdGVBdXRvU2F2ZVJlcXVlc3QSHwoLYXV0b3NhdmVfaWQYASABKAlSCmF1dG9zYXZlSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSHAoJZnJlcXVlbmN5GAMgASgJUglmcmVxdWVuY3kSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSIwoNdGFyZ2V0X2Ftb3VudBgFIAEoAVIMdGFyZ2V0QW1vdW50');
@$core.Deprecated('Use updateAutoSaveResponseDescriptor instead')
const UpdateAutoSaveResponse$json = const {
  '1': 'UpdateAutoSaveResponse',
  '2': const [
    const {'1': 'autosave', '3': 1, '4': 1, '5': 11, '6': '.accounts.AutoSave', '10': 'autosave'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveResponseDescriptor = $convert.base64Decode('ChZVcGRhdGVBdXRvU2F2ZVJlc3BvbnNlEi4KCGF1dG9zYXZlGAEgASgLMhIuYWNjb3VudHMuQXV0b1NhdmVSCGF1dG9zYXZlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteAutoSaveRequestDescriptor instead')
const DeleteAutoSaveRequest$json = const {
  '1': 'DeleteAutoSaveRequest',
  '2': const [
    const {'1': 'autosave_id', '3': 1, '4': 1, '5': 9, '10': 'autosaveId'},
  ],
};

/// Descriptor for `DeleteAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveRequestDescriptor = $convert.base64Decode('ChVEZWxldGVBdXRvU2F2ZVJlcXVlc3QSHwoLYXV0b3NhdmVfaWQYASABKAlSCmF1dG9zYXZlSWQ=');
@$core.Deprecated('Use deleteAutoSaveResponseDescriptor instead')
const DeleteAutoSaveResponse$json = const {
  '1': 'DeleteAutoSaveResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveResponseDescriptor = $convert.base64Decode('ChZEZWxldGVBdXRvU2F2ZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use lockFundsDescriptor instead')
const LockFunds$json = const {
  '1': 'LockFunds',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'lock_type', '3': 6, '4': 1, '5': 9, '10': 'lockType'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'unlock_date', '3': 8, '4': 1, '5': 9, '10': 'unlockDate'},
    const {'1': 'target_amount', '3': 9, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'penalty_rate', '3': 10, '4': 1, '5': 1, '10': 'penaltyRate'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'matured_at', '3': 12, '4': 1, '5': 9, '10': 'maturedAt'},
    const {'1': 'auto_renew', '3': 13, '4': 1, '5': 8, '10': 'autoRenew'},
  ],
};

/// Descriptor for `LockFunds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockFundsDescriptor = $convert.base64Decode('CglMb2NrRnVuZHMSDgoCaWQYASABKAlSAmlkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSEgoEbmFtZRgEIAEoCVIEbmFtZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIbCglsb2NrX3R5cGUYBiABKAlSCGxvY2tUeXBlEhYKBnN0YXR1cxgHIAEoCVIGc3RhdHVzEh8KC3VubG9ja19kYXRlGAggASgJUgp1bmxvY2tEYXRlEiMKDXRhcmdldF9hbW91bnQYCSABKAFSDHRhcmdldEFtb3VudBIhCgxwZW5hbHR5X3JhdGUYCiABKAFSC3BlbmFsdHlSYXRlEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIdCgptYXR1cmVkX2F0GAwgASgJUgltYXR1cmVkQXQSHQoKYXV0b19yZW5ldxgNIAEoCFIJYXV0b1JlbmV3');
@$core.Deprecated('Use createLockFundsRequestDescriptor instead')
const CreateLockFundsRequest$json = const {
  '1': 'CreateLockFundsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'lock_type', '3': 4, '4': 1, '5': 9, '10': 'lockType'},
    const {'1': 'unlock_date', '3': 5, '4': 1, '5': 9, '10': 'unlockDate'},
    const {'1': 'target_amount', '3': 6, '4': 1, '5': 1, '10': 'targetAmount'},
    const {'1': 'penalty_rate', '3': 7, '4': 1, '5': 1, '10': 'penaltyRate'},
    const {'1': 'pin', '3': 8, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'auto_renew', '3': 9, '4': 1, '5': 8, '10': 'autoRenew'},
    const {'1': 'interest_destination_account_id', '3': 10, '4': 1, '5': 9, '10': 'interestDestinationAccountId'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateLockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundsRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVMb2NrRnVuZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgRuYW1lGAIgASgJUgRuYW1lEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhsKCWxvY2tfdHlwZRgEIAEoCVIIbG9ja1R5cGUSHwoLdW5sb2NrX2RhdGUYBSABKAlSCnVubG9ja0RhdGUSIwoNdGFyZ2V0X2Ftb3VudBgGIAEoAVIMdGFyZ2V0QW1vdW50EiEKDHBlbmFsdHlfcmF0ZRgHIAEoAVILcGVuYWx0eVJhdGUSEAoDcGluGAggASgJUgNwaW4SHQoKYXV0b19yZW5ldxgJIAEoCFIJYXV0b1JlbmV3EkUKH2ludGVyZXN0X2Rlc3RpbmF0aW9uX2FjY291bnRfaWQYCiABKAlSHGludGVyZXN0RGVzdGluYXRpb25BY2NvdW50SWQSGgoIY3VycmVuY3kYCyABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use createLockFundsResponseDescriptor instead')
const CreateLockFundsResponse$json = const {
  '1': 'CreateLockFundsResponse',
  '2': const [
    const {'1': 'lockfunds', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFunds', '10': 'lockfunds'},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
    const {'1': 'new_available_balance', '3': 3, '4': 1, '5': 1, '10': 'newAvailableBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'upfront_interest_paid', '3': 5, '4': 1, '5': 1, '10': 'upfrontInterestPaid'},
    const {'1': 'upfront_interest_destination', '3': 6, '4': 1, '5': 9, '10': 'upfrontInterestDestination'},
  ],
};

/// Descriptor for `CreateLockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundsResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVMb2NrRnVuZHNSZXNwb25zZRIxCglsb2NrZnVuZHMYASABKAsyEy5hY2NvdW50cy5Mb2NrRnVuZHNSCWxvY2tmdW5kcxI3Cgt0cmFuc2FjdGlvbhgCIAEoCzIVLmFjY291bnRzLlRyYW5zYWN0aW9uUgt0cmFuc2FjdGlvbhIyChVuZXdfYXZhaWxhYmxlX2JhbGFuY2UYAyABKAFSE25ld0F2YWlsYWJsZUJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZRIyChV1cGZyb250X2ludGVyZXN0X3BhaWQYBSABKAFSE3VwZnJvbnRJbnRlcmVzdFBhaWQSQAocdXBmcm9udF9pbnRlcmVzdF9kZXN0aW5hdGlvbhgGIAEoCVIadXBmcm9udEludGVyZXN0RGVzdGluYXRpb24=');
@$core.Deprecated('Use getLockFundsRequestDescriptor instead')
const GetLockFundsRequest$json = const {
  '1': 'GetLockFundsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetLockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundsRequestDescriptor = $convert.base64Decode('ChNHZXRMb2NrRnVuZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cw==');
@$core.Deprecated('Use getLockFundsResponseDescriptor instead')
const GetLockFundsResponse$json = const {
  '1': 'GetLockFundsResponse',
  '2': const [
    const {'1': 'lockfunds', '3': 1, '4': 3, '5': 11, '6': '.accounts.LockFunds', '10': 'lockfunds'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_locked_amount', '3': 3, '4': 1, '5': 1, '10': 'totalLockedAmount'},
  ],
};

/// Descriptor for `GetLockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundsResponseDescriptor = $convert.base64Decode('ChRHZXRMb2NrRnVuZHNSZXNwb25zZRIxCglsb2NrZnVuZHMYASADKAsyEy5hY2NvdW50cy5Mb2NrRnVuZHNSCWxvY2tmdW5kcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSLgoTdG90YWxfbG9ja2VkX2Ftb3VudBgDIAEoAVIRdG90YWxMb2NrZWRBbW91bnQ=');
@$core.Deprecated('Use unlockFundsRequestDescriptor instead')
const UnlockFundsRequest$json = const {
  '1': 'UnlockFundsRequest',
  '2': const [
    const {'1': 'lockfunds_id', '3': 1, '4': 1, '5': 9, '10': 'lockfundsId'},
    const {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'force_unlock', '3': 3, '4': 1, '5': 8, '10': 'forceUnlock'},
  ],
};

/// Descriptor for `UnlockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockFundsRequestDescriptor = $convert.base64Decode('ChJVbmxvY2tGdW5kc1JlcXVlc3QSIQoMbG9ja2Z1bmRzX2lkGAEgASgJUgtsb2NrZnVuZHNJZBIQCgNwaW4YAiABKAlSA3BpbhIhCgxmb3JjZV91bmxvY2sYAyABKAhSC2ZvcmNlVW5sb2Nr');
@$core.Deprecated('Use unlockFundsResponseDescriptor instead')
const UnlockFundsResponse$json = const {
  '1': 'UnlockFundsResponse',
  '2': const [
    const {'1': 'lockfunds', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFunds', '10': 'lockfunds'},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
    const {'1': 'penalty_amount', '3': 3, '4': 1, '5': 1, '10': 'penaltyAmount'},
    const {'1': 'released_amount', '3': 4, '4': 1, '5': 1, '10': 'releasedAmount'},
    const {'1': 'new_available_balance', '3': 5, '4': 1, '5': 1, '10': 'newAvailableBalance'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnlockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockFundsResponseDescriptor = $convert.base64Decode('ChNVbmxvY2tGdW5kc1Jlc3BvbnNlEjEKCWxvY2tmdW5kcxgBIAEoCzITLmFjY291bnRzLkxvY2tGdW5kc1IJbG9ja2Z1bmRzEjcKC3RyYW5zYWN0aW9uGAIgASgLMhUuYWNjb3VudHMuVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEiUKDnBlbmFsdHlfYW1vdW50GAMgASgBUg1wZW5hbHR5QW1vdW50EicKD3JlbGVhc2VkX2Ftb3VudBgEIAEoAVIOcmVsZWFzZWRBbW91bnQSMgoVbmV3X2F2YWlsYWJsZV9iYWxhbmNlGAUgASgBUhNuZXdBdmFpbGFibGVCYWxhbmNlEhgKB21lc3NhZ2UYBiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use piggyVaultConfigProtoDescriptor instead')
const PiggyVaultConfigProto$json = const {
  '1': 'PiggyVaultConfigProto',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'lock_type', '3': 2, '4': 1, '5': 9, '10': 'lockType'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'base_interest_rate', '3': 5, '4': 1, '5': 1, '10': 'baseInterestRate'},
    const {'1': 'max_interest_rate', '3': 6, '4': 1, '5': 1, '10': 'maxInterestRate'},
    const {'1': 'early_withdrawal_penalty', '3': 7, '4': 1, '5': 1, '10': 'earlyWithdrawalPenalty'},
    const {'1': 'min_duration_days', '3': 8, '4': 1, '5': 5, '10': 'minDurationDays'},
    const {'1': 'max_duration_days', '3': 9, '4': 1, '5': 5, '10': 'maxDurationDays'},
    const {'1': 'min_amount', '3': 10, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 11, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'allows_early_withdrawal', '3': 12, '4': 1, '5': 8, '10': 'allowsEarlyWithdrawal'},
    const {'1': 'supports_auto_renew', '3': 13, '4': 1, '5': 8, '10': 'supportsAutoRenew'},
    const {'1': 'supports_top_up', '3': 14, '4': 1, '5': 8, '10': 'supportsTopUp'},
    const {'1': 'supports_auto_save', '3': 15, '4': 1, '5': 8, '10': 'supportsAutoSave'},
    const {'1': 'supports_upfront_interest', '3': 16, '4': 1, '5': 8, '10': 'supportsUpfrontInterest'},
    const {'1': 'duration_bonus_tiers', '3': 17, '4': 1, '5': 9, '10': 'durationBonusTiers'},
    const {'1': 'is_active', '3': 18, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'description', '3': 19, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'is_fixed_amount', '3': 20, '4': 1, '5': 8, '10': 'isFixedAmount'},
    const {'1': 'fixed_amount', '3': 21, '4': 1, '5': 1, '10': 'fixedAmount'},
    const {'1': 'duration_options', '3': 22, '4': 1, '5': 9, '10': 'durationOptions'},
    const {'1': 'quick_amount_options', '3': 23, '4': 1, '5': 9, '10': 'quickAmountOptions'},
    const {'1': 'confirmation_notes', '3': 24, '4': 1, '5': 9, '10': 'confirmationNotes'},
    const {'1': 'confirmation_notes_renew_on', '3': 25, '4': 1, '5': 9, '10': 'confirmationNotesRenewOn'},
    const {'1': 'confirmation_notes_renew_off', '3': 26, '4': 1, '5': 9, '10': 'confirmationNotesRenewOff'},
  ],
};

/// Descriptor for `PiggyVaultConfigProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List piggyVaultConfigProtoDescriptor = $convert.base64Decode('ChVQaWdneVZhdWx0Q29uZmlnUHJvdG8SDgoCaWQYASABKAlSAmlkEhsKCWxvY2tfdHlwZRgCIAEoCVIIbG9ja1R5cGUSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EiEKDGRpc3BsYXlfbmFtZRgEIAEoCVILZGlzcGxheU5hbWUSLAoSYmFzZV9pbnRlcmVzdF9yYXRlGAUgASgBUhBiYXNlSW50ZXJlc3RSYXRlEioKEW1heF9pbnRlcmVzdF9yYXRlGAYgASgBUg9tYXhJbnRlcmVzdFJhdGUSOAoYZWFybHlfd2l0aGRyYXdhbF9wZW5hbHR5GAcgASgBUhZlYXJseVdpdGhkcmF3YWxQZW5hbHR5EioKEW1pbl9kdXJhdGlvbl9kYXlzGAggASgFUg9taW5EdXJhdGlvbkRheXMSKgoRbWF4X2R1cmF0aW9uX2RheXMYCSABKAVSD21heER1cmF0aW9uRGF5cxIdCgptaW5fYW1vdW50GAogASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgLIAEoAVIJbWF4QW1vdW50EjYKF2FsbG93c19lYXJseV93aXRoZHJhd2FsGAwgASgIUhVhbGxvd3NFYXJseVdpdGhkcmF3YWwSLgoTc3VwcG9ydHNfYXV0b19yZW5ldxgNIAEoCFIRc3VwcG9ydHNBdXRvUmVuZXcSJgoPc3VwcG9ydHNfdG9wX3VwGA4gASgIUg1zdXBwb3J0c1RvcFVwEiwKEnN1cHBvcnRzX2F1dG9fc2F2ZRgPIAEoCFIQc3VwcG9ydHNBdXRvU2F2ZRI6ChlzdXBwb3J0c191cGZyb250X2ludGVyZXN0GBAgASgIUhdzdXBwb3J0c1VwZnJvbnRJbnRlcmVzdBIwChRkdXJhdGlvbl9ib251c190aWVycxgRIAEoCVISZHVyYXRpb25Cb251c1RpZXJzEhsKCWlzX2FjdGl2ZRgSIAEoCFIIaXNBY3RpdmUSIAoLZGVzY3JpcHRpb24YEyABKAlSC2Rlc2NyaXB0aW9uEiYKD2lzX2ZpeGVkX2Ftb3VudBgUIAEoCFINaXNGaXhlZEFtb3VudBIhCgxmaXhlZF9hbW91bnQYFSABKAFSC2ZpeGVkQW1vdW50EikKEGR1cmF0aW9uX29wdGlvbnMYFiABKAlSD2R1cmF0aW9uT3B0aW9ucxIwChRxdWlja19hbW91bnRfb3B0aW9ucxgXIAEoCVIScXVpY2tBbW91bnRPcHRpb25zEi0KEmNvbmZpcm1hdGlvbl9ub3RlcxgYIAEoCVIRY29uZmlybWF0aW9uTm90ZXMSPQobY29uZmlybWF0aW9uX25vdGVzX3JlbmV3X29uGBkgASgJUhhjb25maXJtYXRpb25Ob3Rlc1JlbmV3T24SPwocY29uZmlybWF0aW9uX25vdGVzX3JlbmV3X29mZhgaIAEoCVIZY29uZmlybWF0aW9uTm90ZXNSZW5ld09mZg==');
@$core.Deprecated('Use getPiggyVaultConfigRequestDescriptor instead')
const GetPiggyVaultConfigRequest$json = const {
  '1': 'GetPiggyVaultConfigRequest',
  '2': const [
    const {'1': 'lock_type', '3': 1, '4': 1, '5': 9, '10': 'lockType'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetPiggyVaultConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPiggyVaultConfigRequestDescriptor = $convert.base64Decode('ChpHZXRQaWdneVZhdWx0Q29uZmlnUmVxdWVzdBIbCglsb2NrX3R5cGUYASABKAlSCGxvY2tUeXBlEhoKCGN1cnJlbmN5GAIgASgJUghjdXJyZW5jeQ==');
@$core.Deprecated('Use getPiggyVaultConfigResponseDescriptor instead')
const GetPiggyVaultConfigResponse$json = const {
  '1': 'GetPiggyVaultConfigResponse',
  '2': const [
    const {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.accounts.PiggyVaultConfigProto', '10': 'config'},
  ],
};

/// Descriptor for `GetPiggyVaultConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPiggyVaultConfigResponseDescriptor = $convert.base64Decode('ChtHZXRQaWdneVZhdWx0Q29uZmlnUmVzcG9uc2USNwoGY29uZmlnGAEgASgLMh8uYWNjb3VudHMuUGlnZ3lWYXVsdENvbmZpZ1Byb3RvUgZjb25maWc=');
@$core.Deprecated('Use getAllPiggyVaultConfigsRequestDescriptor instead')
const GetAllPiggyVaultConfigsRequest$json = const {
  '1': 'GetAllPiggyVaultConfigsRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `GetAllPiggyVaultConfigsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllPiggyVaultConfigsRequestDescriptor = $convert.base64Decode('Ch5HZXRBbGxQaWdneVZhdWx0Q29uZmlnc1JlcXVlc3QSGgoIY3VycmVuY3kYASABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use getAllPiggyVaultConfigsResponseDescriptor instead')
const GetAllPiggyVaultConfigsResponse$json = const {
  '1': 'GetAllPiggyVaultConfigsResponse',
  '2': const [
    const {'1': 'configs', '3': 1, '4': 3, '5': 11, '6': '.accounts.PiggyVaultConfigProto', '10': 'configs'},
  ],
};

/// Descriptor for `GetAllPiggyVaultConfigsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllPiggyVaultConfigsResponseDescriptor = $convert.base64Decode('Ch9HZXRBbGxQaWdneVZhdWx0Q29uZmlnc1Jlc3BvbnNlEjkKB2NvbmZpZ3MYASADKAsyHy5hY2NvdW50cy5QaWdneVZhdWx0Q29uZmlnUHJvdG9SB2NvbmZpZ3M=');
@$core.Deprecated('Use updatePiggyVaultConfigRequestDescriptor instead')
const UpdatePiggyVaultConfigRequest$json = const {
  '1': 'UpdatePiggyVaultConfigRequest',
  '2': const [
    const {'1': 'lock_type', '3': 1, '4': 1, '5': 9, '10': 'lockType'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'base_interest_rate', '3': 3, '4': 1, '5': 1, '10': 'baseInterestRate'},
    const {'1': 'max_interest_rate', '3': 4, '4': 1, '5': 1, '10': 'maxInterestRate'},
    const {'1': 'early_withdrawal_penalty', '3': 5, '4': 1, '5': 1, '10': 'earlyWithdrawalPenalty'},
    const {'1': 'min_duration_days', '3': 6, '4': 1, '5': 5, '10': 'minDurationDays'},
    const {'1': 'max_duration_days', '3': 7, '4': 1, '5': 5, '10': 'maxDurationDays'},
    const {'1': 'min_amount', '3': 8, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 9, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'allows_early_withdrawal', '3': 10, '4': 1, '5': 8, '10': 'allowsEarlyWithdrawal'},
    const {'1': 'supports_auto_renew', '3': 11, '4': 1, '5': 8, '10': 'supportsAutoRenew'},
    const {'1': 'supports_top_up', '3': 12, '4': 1, '5': 8, '10': 'supportsTopUp'},
    const {'1': 'supports_auto_save', '3': 13, '4': 1, '5': 8, '10': 'supportsAutoSave'},
    const {'1': 'supports_upfront_interest', '3': 14, '4': 1, '5': 8, '10': 'supportsUpfrontInterest'},
    const {'1': 'duration_bonus_tiers', '3': 15, '4': 1, '5': 9, '10': 'durationBonusTiers'},
    const {'1': 'is_active', '3': 16, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'description', '3': 17, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'display_name', '3': 18, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'is_fixed_amount', '3': 19, '4': 1, '5': 8, '10': 'isFixedAmount'},
    const {'1': 'fixed_amount', '3': 20, '4': 1, '5': 1, '10': 'fixedAmount'},
    const {'1': 'duration_options', '3': 21, '4': 1, '5': 9, '10': 'durationOptions'},
    const {'1': 'quick_amount_options', '3': 22, '4': 1, '5': 9, '10': 'quickAmountOptions'},
    const {'1': 'confirmation_notes', '3': 23, '4': 1, '5': 9, '10': 'confirmationNotes'},
    const {'1': 'confirmation_notes_renew_on', '3': 24, '4': 1, '5': 9, '10': 'confirmationNotesRenewOn'},
    const {'1': 'confirmation_notes_renew_off', '3': 25, '4': 1, '5': 9, '10': 'confirmationNotesRenewOff'},
  ],
};

/// Descriptor for `UpdatePiggyVaultConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePiggyVaultConfigRequestDescriptor = $convert.base64Decode('Ch1VcGRhdGVQaWdneVZhdWx0Q29uZmlnUmVxdWVzdBIbCglsb2NrX3R5cGUYASABKAlSCGxvY2tUeXBlEhoKCGN1cnJlbmN5GAIgASgJUghjdXJyZW5jeRIsChJiYXNlX2ludGVyZXN0X3JhdGUYAyABKAFSEGJhc2VJbnRlcmVzdFJhdGUSKgoRbWF4X2ludGVyZXN0X3JhdGUYBCABKAFSD21heEludGVyZXN0UmF0ZRI4ChhlYXJseV93aXRoZHJhd2FsX3BlbmFsdHkYBSABKAFSFmVhcmx5V2l0aGRyYXdhbFBlbmFsdHkSKgoRbWluX2R1cmF0aW9uX2RheXMYBiABKAVSD21pbkR1cmF0aW9uRGF5cxIqChFtYXhfZHVyYXRpb25fZGF5cxgHIAEoBVIPbWF4RHVyYXRpb25EYXlzEh0KCm1pbl9hbW91bnQYCCABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAkgASgBUgltYXhBbW91bnQSNgoXYWxsb3dzX2Vhcmx5X3dpdGhkcmF3YWwYCiABKAhSFWFsbG93c0Vhcmx5V2l0aGRyYXdhbBIuChNzdXBwb3J0c19hdXRvX3JlbmV3GAsgASgIUhFzdXBwb3J0c0F1dG9SZW5ldxImCg9zdXBwb3J0c190b3BfdXAYDCABKAhSDXN1cHBvcnRzVG9wVXASLAoSc3VwcG9ydHNfYXV0b19zYXZlGA0gASgIUhBzdXBwb3J0c0F1dG9TYXZlEjoKGXN1cHBvcnRzX3VwZnJvbnRfaW50ZXJlc3QYDiABKAhSF3N1cHBvcnRzVXBmcm9udEludGVyZXN0EjAKFGR1cmF0aW9uX2JvbnVzX3RpZXJzGA8gASgJUhJkdXJhdGlvbkJvbnVzVGllcnMSGwoJaXNfYWN0aXZlGBAgASgIUghpc0FjdGl2ZRIgCgtkZXNjcmlwdGlvbhgRIAEoCVILZGVzY3JpcHRpb24SIQoMZGlzcGxheV9uYW1lGBIgASgJUgtkaXNwbGF5TmFtZRImCg9pc19maXhlZF9hbW91bnQYEyABKAhSDWlzRml4ZWRBbW91bnQSIQoMZml4ZWRfYW1vdW50GBQgASgBUgtmaXhlZEFtb3VudBIpChBkdXJhdGlvbl9vcHRpb25zGBUgASgJUg9kdXJhdGlvbk9wdGlvbnMSMAoUcXVpY2tfYW1vdW50X29wdGlvbnMYFiABKAlSEnF1aWNrQW1vdW50T3B0aW9ucxItChJjb25maXJtYXRpb25fbm90ZXMYFyABKAlSEWNvbmZpcm1hdGlvbk5vdGVzEj0KG2NvbmZpcm1hdGlvbl9ub3Rlc19yZW5ld19vbhgYIAEoCVIYY29uZmlybWF0aW9uTm90ZXNSZW5ld09uEj8KHGNvbmZpcm1hdGlvbl9ub3Rlc19yZW5ld19vZmYYGSABKAlSGWNvbmZpcm1hdGlvbk5vdGVzUmVuZXdPZmY=');
@$core.Deprecated('Use updatePiggyVaultConfigResponseDescriptor instead')
const UpdatePiggyVaultConfigResponse$json = const {
  '1': 'UpdatePiggyVaultConfigResponse',
  '2': const [
    const {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.accounts.PiggyVaultConfigProto', '10': 'config'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdatePiggyVaultConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePiggyVaultConfigResponseDescriptor = $convert.base64Decode('Ch5VcGRhdGVQaWdneVZhdWx0Q29uZmlnUmVzcG9uc2USNwoGY29uZmlnGAEgASgLMh8uYWNjb3VudHMuUGlnZ3lWYXVsdENvbmZpZ1Byb3RvUgZjb25maWcSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use topUpLockFundsRequestDescriptor instead')
const TopUpLockFundsRequest$json = const {
  '1': 'TopUpLockFundsRequest',
  '2': const [
    const {'1': 'lockfunds_id', '3': 1, '4': 1, '5': 9, '10': 'lockfundsId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `TopUpLockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topUpLockFundsRequestDescriptor = $convert.base64Decode('ChVUb3BVcExvY2tGdW5kc1JlcXVlc3QSIQoMbG9ja2Z1bmRzX2lkGAEgASgJUgtsb2NrZnVuZHNJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIQCgNwaW4YAyABKAlSA3BpbhIqChFzb3VyY2VfYWNjb3VudF9pZBgEIAEoCVIPc291cmNlQWNjb3VudElk');
@$core.Deprecated('Use topUpLockFundsResponseDescriptor instead')
const TopUpLockFundsResponse$json = const {
  '1': 'TopUpLockFundsResponse',
  '2': const [
    const {'1': 'lockfunds', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFunds', '10': 'lockfunds'},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
    const {'1': 'new_available_balance', '3': 3, '4': 1, '5': 1, '10': 'newAvailableBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TopUpLockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topUpLockFundsResponseDescriptor = $convert.base64Decode('ChZUb3BVcExvY2tGdW5kc1Jlc3BvbnNlEjEKCWxvY2tmdW5kcxgBIAEoCzITLmFjY291bnRzLkxvY2tGdW5kc1IJbG9ja2Z1bmRzEjcKC3RyYW5zYWN0aW9uGAIgASgLMhUuYWNjb3VudHMuVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEjIKFW5ld19hdmFpbGFibGVfYmFsYW5jZRgDIAEoAVITbmV3QXZhaWxhYmxlQmFsYW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use lockFundAutoSaveProtoDescriptor instead')
const LockFundAutoSaveProto$json = const {
  '1': 'LockFundAutoSaveProto',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'lock_fund_id', '3': 2, '4': 1, '5': 9, '10': 'lockFundId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 6, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'next_run_at', '3': 8, '4': 1, '5': 9, '10': 'nextRunAt'},
    const {'1': 'last_run_at', '3': 9, '4': 1, '5': 9, '10': 'lastRunAt'},
    const {'1': 'total_saved', '3': 10, '4': 1, '5': 1, '10': 'totalSaved'},
    const {'1': 'run_count', '3': 11, '4': 1, '5': 5, '10': 'runCount'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `LockFundAutoSaveProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockFundAutoSaveProtoDescriptor = $convert.base64Decode('ChVMb2NrRnVuZEF1dG9TYXZlUHJvdG8SDgoCaWQYASABKAlSAmlkEiAKDGxvY2tfZnVuZF9pZBgCIAEoCVIKbG9ja0Z1bmRJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSKgoRc291cmNlX2FjY291bnRfaWQYBCABKAlSD3NvdXJjZUFjY291bnRJZBIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIcCglmcmVxdWVuY3kYBiABKAlSCWZyZXF1ZW5jeRIWCgZzdGF0dXMYByABKAlSBnN0YXR1cxIeCgtuZXh0X3J1bl9hdBgIIAEoCVIJbmV4dFJ1bkF0Eh4KC2xhc3RfcnVuX2F0GAkgASgJUglsYXN0UnVuQXQSHwoLdG90YWxfc2F2ZWQYCiABKAFSCnRvdGFsU2F2ZWQSGwoJcnVuX2NvdW50GAsgASgFUghydW5Db3VudBIdCgpjcmVhdGVkX2F0GAwgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use createLockFundAutoSaveRequestDescriptor instead')
const CreateLockFundAutoSaveRequest$json = const {
  '1': 'CreateLockFundAutoSaveRequest',
  '2': const [
    const {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
  ],
};

/// Descriptor for `CreateLockFundAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundAutoSaveRequestDescriptor = $convert.base64Decode('Ch1DcmVhdGVMb2NrRnVuZEF1dG9TYXZlUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2tGdW5kSWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIcCglmcmVxdWVuY3kYBCABKAlSCWZyZXF1ZW5jeQ==');
@$core.Deprecated('Use createLockFundAutoSaveResponseDescriptor instead')
const CreateLockFundAutoSaveResponse$json = const {
  '1': 'CreateLockFundAutoSaveResponse',
  '2': const [
    const {'1': 'autosave', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFundAutoSaveProto', '10': 'autosave'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateLockFundAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundAutoSaveResponseDescriptor = $convert.base64Decode('Ch5DcmVhdGVMb2NrRnVuZEF1dG9TYXZlUmVzcG9uc2USOwoIYXV0b3NhdmUYASABKAsyHy5hY2NvdW50cy5Mb2NrRnVuZEF1dG9TYXZlUHJvdG9SCGF1dG9zYXZlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getLockFundAutoSaveRequestDescriptor instead')
const GetLockFundAutoSaveRequest$json = const {
  '1': 'GetLockFundAutoSaveRequest',
  '2': const [
    const {'1': 'lock_fund_id', '3': 1, '4': 1, '5': 9, '10': 'lockFundId'},
  ],
};

/// Descriptor for `GetLockFundAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundAutoSaveRequestDescriptor = $convert.base64Decode('ChpHZXRMb2NrRnVuZEF1dG9TYXZlUmVxdWVzdBIgCgxsb2NrX2Z1bmRfaWQYASABKAlSCmxvY2tGdW5kSWQ=');
@$core.Deprecated('Use getLockFundAutoSaveResponseDescriptor instead')
const GetLockFundAutoSaveResponse$json = const {
  '1': 'GetLockFundAutoSaveResponse',
  '2': const [
    const {'1': 'autosave', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFundAutoSaveProto', '10': 'autosave'},
  ],
};

/// Descriptor for `GetLockFundAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundAutoSaveResponseDescriptor = $convert.base64Decode('ChtHZXRMb2NrRnVuZEF1dG9TYXZlUmVzcG9uc2USOwoIYXV0b3NhdmUYASABKAsyHy5hY2NvdW50cy5Mb2NrRnVuZEF1dG9TYXZlUHJvdG9SCGF1dG9zYXZl');
@$core.Deprecated('Use updateLockFundAutoSaveRequestDescriptor instead')
const UpdateLockFundAutoSaveRequest$json = const {
  '1': 'UpdateLockFundAutoSaveRequest',
  '2': const [
    const {'1': 'autosave_id', '3': 1, '4': 1, '5': 9, '10': 'autosaveId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `UpdateLockFundAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLockFundAutoSaveRequestDescriptor = $convert.base64Decode('Ch1VcGRhdGVMb2NrRnVuZEF1dG9TYXZlUmVxdWVzdBIfCgthdXRvc2F2ZV9pZBgBIAEoCVIKYXV0b3NhdmVJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIcCglmcmVxdWVuY3kYAyABKAlSCWZyZXF1ZW5jeRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cw==');
@$core.Deprecated('Use updateLockFundAutoSaveResponseDescriptor instead')
const UpdateLockFundAutoSaveResponse$json = const {
  '1': 'UpdateLockFundAutoSaveResponse',
  '2': const [
    const {'1': 'autosave', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFundAutoSaveProto', '10': 'autosave'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateLockFundAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLockFundAutoSaveResponseDescriptor = $convert.base64Decode('Ch5VcGRhdGVMb2NrRnVuZEF1dG9TYXZlUmVzcG9uc2USOwoIYXV0b3NhdmUYASABKAsyHy5hY2NvdW50cy5Mb2NrRnVuZEF1dG9TYXZlUHJvdG9SCGF1dG9zYXZlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteLockFundAutoSaveRequestDescriptor instead')
const DeleteLockFundAutoSaveRequest$json = const {
  '1': 'DeleteLockFundAutoSaveRequest',
  '2': const [
    const {'1': 'autosave_id', '3': 1, '4': 1, '5': 9, '10': 'autosaveId'},
  ],
};

/// Descriptor for `DeleteLockFundAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteLockFundAutoSaveRequestDescriptor = $convert.base64Decode('Ch1EZWxldGVMb2NrRnVuZEF1dG9TYXZlUmVxdWVzdBIfCgthdXRvc2F2ZV9pZBgBIAEoCVIKYXV0b3NhdmVJZA==');
@$core.Deprecated('Use deleteLockFundAutoSaveResponseDescriptor instead')
const DeleteLockFundAutoSaveResponse$json = const {
  '1': 'DeleteLockFundAutoSaveResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteLockFundAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteLockFundAutoSaveResponseDescriptor = $convert.base64Decode('Ch5EZWxldGVMb2NrRnVuZEF1dG9TYXZlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use createTransactionRequestDescriptor instead')
const CreateTransactionRequest$json = const {
  '1': 'CreateTransactionRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 6, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 7, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'counterparty_name', '3': 10, '4': 1, '5': 9, '10': 'counterpartyName'},
    const {'1': 'counterparty_account', '3': 11, '4': 1, '5': 9, '10': 'counterpartyAccount'},
  ],
};

/// Descriptor for `CreateTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionRequestDescriptor = $convert.base64Decode('ChhDcmVhdGVUcmFuc2FjdGlvblJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhIKBHR5cGUYAiABKAlSBHR5cGUSGgoIY2F0ZWdvcnkYAyABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgGIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAcgASgJUgtzZXJ2aWNlTmFtZRIcCglyZWZlcmVuY2UYCCABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYCSABKAlSBnN0YXR1cxIrChFjb3VudGVycGFydHlfbmFtZRgKIAEoCVIQY291bnRlcnBhcnR5TmFtZRIxChRjb3VudGVycGFydHlfYWNjb3VudBgLIAEoCVITY291bnRlcnBhcnR5QWNjb3VudA==');
@$core.Deprecated('Use createTransactionResponseDescriptor instead')
const CreateTransactionResponse$json = const {
  '1': 'CreateTransactionResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionResponseDescriptor = $convert.base64Decode('ChlDcmVhdGVUcmFuc2FjdGlvblJlc3BvbnNlEjcKC3RyYW5zYWN0aW9uGAEgASgLMhUuYWNjb3VudHMuVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use updateTransactionStatusRequestDescriptor instead')
const UpdateTransactionStatusRequest$json = const {
  '1': 'UpdateTransactionStatusRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'failure_reason', '3': 3, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `UpdateTransactionStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTransactionStatusRequestDescriptor = $convert.base64Decode('Ch5VcGRhdGVUcmFuc2FjdGlvblN0YXR1c1JlcXVlc3QSHAoJcmVmZXJlbmNlGAEgASgJUglyZWZlcmVuY2USFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSJQoOZmFpbHVyZV9yZWFzb24YAyABKAlSDWZhaWx1cmVSZWFzb24=');
@$core.Deprecated('Use updateTransactionStatusResponseDescriptor instead')
const UpdateTransactionStatusResponse$json = const {
  '1': 'UpdateTransactionStatusResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateTransactionStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTransactionStatusResponseDescriptor = $convert.base64Decode('Ch9VcGRhdGVUcmFuc2FjdGlvblN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use lookupTransactionByReferenceRequestDescriptor instead')
const LookupTransactionByReferenceRequest$json = const {
  '1': 'LookupTransactionByReferenceRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `LookupTransactionByReferenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupTransactionByReferenceRequestDescriptor = $convert.base64Decode('CiNMb29rdXBUcmFuc2FjdGlvbkJ5UmVmZXJlbmNlUmVxdWVzdBIcCglyZWZlcmVuY2UYASABKAlSCXJlZmVyZW5jZQ==');
@$core.Deprecated('Use lookupTransactionByReferenceResponseDescriptor instead')
const LookupTransactionByReferenceResponse$json = const {
  '1': 'LookupTransactionByReferenceResponse',
  '2': const [
    const {'1': 'found', '3': 1, '4': 1, '5': 8, '10': 'found'},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
  ],
};

/// Descriptor for `LookupTransactionByReferenceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupTransactionByReferenceResponseDescriptor = $convert.base64Decode('CiRMb29rdXBUcmFuc2FjdGlvbkJ5UmVmZXJlbmNlUmVzcG9uc2USFAoFZm91bmQYASABKAhSBWZvdW5kEjcKC3RyYW5zYWN0aW9uGAIgASgLMhUuYWNjb3VudHMuVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9u');
@$core.Deprecated('Use getTransactionHistoryRequestDescriptor instead')
const GetTransactionHistoryRequest$json = const {
  '1': 'GetTransactionHistoryRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'service_name', '3': 5, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'start_date', '3': 6, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 7, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 8, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 9, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'include_external_banks', '3': 10, '4': 1, '5': 8, '10': 'includeExternalBanks'},
    const {'1': 'counterparty_account', '3': 11, '4': 1, '5': 9, '10': 'counterpartyAccount'},
    const {'1': 'locale', '3': 12, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `GetTransactionHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionHistoryRequestDescriptor = $convert.base64Decode('ChxHZXRUcmFuc2FjdGlvbkhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgR0eXBlGAIgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxIhCgxzZXJ2aWNlX25hbWUYBSABKAlSC3NlcnZpY2VOYW1lEh0KCnN0YXJ0X2RhdGUYBiABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgHIAEoCVIHZW5kRGF0ZRIUCgVsaW1pdBgIIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAkgASgFUgZvZmZzZXQSNAoWaW5jbHVkZV9leHRlcm5hbF9iYW5rcxgKIAEoCFIUaW5jbHVkZUV4dGVybmFsQmFua3MSMQoUY291bnRlcnBhcnR5X2FjY291bnQYCyABKAlSE2NvdW50ZXJwYXJ0eUFjY291bnQSFgoGbG9jYWxlGAwgASgJUgZsb2NhbGU=');
@$core.Deprecated('Use getTransactionHistoryResponseDescriptor instead')
const GetTransactionHistoryResponse$json = const {
  '1': 'GetTransactionHistoryResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.Transaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_credits', '3': 3, '4': 1, '5': 1, '10': 'totalCredits'},
    const {'1': 'total_debits', '3': 4, '4': 1, '5': 1, '10': 'totalDebits'},
  ],
};

/// Descriptor for `GetTransactionHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionHistoryResponseDescriptor = $convert.base64Decode('Ch1HZXRUcmFuc2FjdGlvbkhpc3RvcnlSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS5hY2NvdW50cy5UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbBIjCg10b3RhbF9jcmVkaXRzGAMgASgBUgx0b3RhbENyZWRpdHMSIQoMdG90YWxfZGViaXRzGAQgASgBUgt0b3RhbERlYml0cw==');
@$core.Deprecated('Use getTransactionStatisticsRequestDescriptor instead')
const GetTransactionStatisticsRequest$json = const {
  '1': 'GetTransactionStatisticsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'include_external_banks', '3': 4, '4': 1, '5': 8, '10': 'includeExternalBanks'},
    const {'1': 'locale', '3': 5, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `GetTransactionStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatisticsRequestDescriptor = $convert.base64Decode('Ch9HZXRUcmFuc2FjdGlvblN0YXRpc3RpY3NSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIdCgpzdGFydF9kYXRlGAIgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYAyABKAlSB2VuZERhdGUSNAoWaW5jbHVkZV9leHRlcm5hbF9iYW5rcxgEIAEoCFIUaW5jbHVkZUV4dGVybmFsQmFua3MSFgoGbG9jYWxlGAUgASgJUgZsb2NhbGU=');
@$core.Deprecated('Use getTransactionStatisticsResponseDescriptor instead')
const GetTransactionStatisticsResponse$json = const {
  '1': 'GetTransactionStatisticsResponse',
  '2': const [
    const {'1': 'total_transactions', '3': 1, '4': 1, '5': 5, '10': 'totalTransactions'},
    const {'1': 'total_credits', '3': 2, '4': 1, '5': 1, '10': 'totalCredits'},
    const {'1': 'total_debits', '3': 3, '4': 1, '5': 1, '10': 'totalDebits'},
    const {'1': 'net_balance', '3': 4, '4': 1, '5': 1, '10': 'netBalance'},
    const {'1': 'transactions_by_service', '3': 5, '4': 3, '5': 11, '6': '.accounts.GetTransactionStatisticsResponse.TransactionsByServiceEntry', '10': 'transactionsByService'},
    const {'1': 'amount_by_service', '3': 6, '4': 3, '5': 11, '6': '.accounts.GetTransactionStatisticsResponse.AmountByServiceEntry', '10': 'amountByService'},
  ],
  '3': const [GetTransactionStatisticsResponse_TransactionsByServiceEntry$json, GetTransactionStatisticsResponse_AmountByServiceEntry$json],
};

@$core.Deprecated('Use getTransactionStatisticsResponseDescriptor instead')
const GetTransactionStatisticsResponse_TransactionsByServiceEntry$json = const {
  '1': 'TransactionsByServiceEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use getTransactionStatisticsResponseDescriptor instead')
const GetTransactionStatisticsResponse_AmountByServiceEntry$json = const {
  '1': 'AmountByServiceEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetTransactionStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatisticsResponseDescriptor = $convert.base64Decode('CiBHZXRUcmFuc2FjdGlvblN0YXRpc3RpY3NSZXNwb25zZRItChJ0b3RhbF90cmFuc2FjdGlvbnMYASABKAVSEXRvdGFsVHJhbnNhY3Rpb25zEiMKDXRvdGFsX2NyZWRpdHMYAiABKAFSDHRvdGFsQ3JlZGl0cxIhCgx0b3RhbF9kZWJpdHMYAyABKAFSC3RvdGFsRGViaXRzEh8KC25ldF9iYWxhbmNlGAQgASgBUgpuZXRCYWxhbmNlEn0KF3RyYW5zYWN0aW9uc19ieV9zZXJ2aWNlGAUgAygLMkUuYWNjb3VudHMuR2V0VHJhbnNhY3Rpb25TdGF0aXN0aWNzUmVzcG9uc2UuVHJhbnNhY3Rpb25zQnlTZXJ2aWNlRW50cnlSFXRyYW5zYWN0aW9uc0J5U2VydmljZRJrChFhbW91bnRfYnlfc2VydmljZRgGIAMoCzI/LmFjY291bnRzLkdldFRyYW5zYWN0aW9uU3RhdGlzdGljc1Jlc3BvbnNlLkFtb3VudEJ5U2VydmljZUVudHJ5Ug9hbW91bnRCeVNlcnZpY2UaSAoaVHJhbnNhY3Rpb25zQnlTZXJ2aWNlRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKANSBXZhbHVlOgI4ARpCChRBbW91bnRCeVNlcnZpY2VFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoAVIFdmFsdWU6AjgB');
@$core.Deprecated('Use transferDescriptor instead')
const Transfer$json = const {
  '1': 'Transfer',
  '2': const [
    const {'1': 'transfer_id', '3': 1, '4': 1, '5': 9, '10': 'transferId'},
    const {'1': 'from_account_id', '3': 2, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'to_account_id', '3': 3, '4': 1, '5': 9, '10': 'toAccountId'},
    const {'1': 'from_account_number', '3': 4, '4': 1, '5': 9, '10': 'fromAccountNumber'},
    const {'1': 'to_account_number', '3': 5, '4': 1, '5': 9, '10': 'toAccountNumber'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'category', '3': 11, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'fee', '3': 12, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'total_amount', '3': 13, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'completed_at', '3': 15, '4': 1, '5': 9, '10': 'completedAt'},
    const {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `Transfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDescriptor = $convert.base64Decode('CghUcmFuc2ZlchIfCgt0cmFuc2Zlcl9pZBgBIAEoCVIKdHJhbnNmZXJJZBImCg9mcm9tX2FjY291bnRfaWQYAiABKAlSDWZyb21BY2NvdW50SWQSIgoNdG9fYWNjb3VudF9pZBgDIAEoCVILdG9BY2NvdW50SWQSLgoTZnJvbV9hY2NvdW50X251bWJlchgEIAEoCVIRZnJvbUFjY291bnROdW1iZXISKgoRdG9fYWNjb3VudF9udW1iZXIYBSABKAlSD3RvQWNjb3VudE51bWJlchIWCgZhbW91bnQYBiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEhwKCXJlZmVyZW5jZRgJIAEoCVIJcmVmZXJlbmNlEhYKBnN0YXR1cxgKIAEoCVIGc3RhdHVzEhoKCGNhdGVnb3J5GAsgASgJUghjYXRlZ29yeRIQCgNmZWUYDCABKAFSA2ZlZRIhCgx0b3RhbF9hbW91bnQYDSABKAFSC3RvdGFsQW1vdW50Eh0KCmNyZWF0ZWRfYXQYDiABKAlSCWNyZWF0ZWRBdBIhCgxjb21wbGV0ZWRfYXQYDyABKAlSC2NvbXBsZXRlZEF0EiUKDmZhaWx1cmVfcmVhc29uGBAgASgJUg1mYWlsdXJlUmVhc29u');
@$core.Deprecated('Use createTransferRequestDescriptor instead')
const CreateTransferRequest$json = const {
  '1': 'CreateTransferRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'from_account', '3': 2, '4': 1, '5': 9, '10': 'fromAccount'},
    const {'1': 'to_account', '3': 3, '4': 1, '5': 9, '10': 'toAccount'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'pin', '3': 7, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `CreateTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransferRequestDescriptor = $convert.base64Decode('ChVDcmVhdGVUcmFuc2ZlclJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiEKDGZyb21fYWNjb3VudBgCIAEoCVILZnJvbUFjY291bnQSHQoKdG9fYWNjb3VudBgDIAEoCVIJdG9BY2NvdW50EhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SEAoDcGluGAcgASgJUgNwaW4SHAoJcmVmZXJlbmNlGAggASgJUglyZWZlcmVuY2U=');
@$core.Deprecated('Use createTransferResponseDescriptor instead')
const CreateTransferResponse$json = const {
  '1': 'CreateTransferResponse',
  '2': const [
    const {'1': 'transfer', '3': 1, '4': 1, '5': 11, '6': '.accounts.Transfer', '10': 'transfer'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransferResponseDescriptor = $convert.base64Decode('ChZDcmVhdGVUcmFuc2ZlclJlc3BvbnNlEi4KCHRyYW5zZmVyGAEgASgLMhIuYWNjb3VudHMuVHJhbnNmZXJSCHRyYW5zZmVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getTransferRequestDescriptor instead')
const GetTransferRequest$json = const {
  '1': 'GetTransferRequest',
  '2': const [
    const {'1': 'transfer_id', '3': 1, '4': 1, '5': 9, '10': 'transferId'},
  ],
};

/// Descriptor for `GetTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferRequestDescriptor = $convert.base64Decode('ChJHZXRUcmFuc2ZlclJlcXVlc3QSHwoLdHJhbnNmZXJfaWQYASABKAlSCnRyYW5zZmVySWQ=');
@$core.Deprecated('Use getTransferResponseDescriptor instead')
const GetTransferResponse$json = const {
  '1': 'GetTransferResponse',
  '2': const [
    const {'1': 'transfer', '3': 1, '4': 1, '5': 11, '6': '.accounts.Transfer', '10': 'transfer'},
  ],
};

/// Descriptor for `GetTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferResponseDescriptor = $convert.base64Decode('ChNHZXRUcmFuc2ZlclJlc3BvbnNlEi4KCHRyYW5zZmVyGAEgASgLMhIuYWNjb3VudHMuVHJhbnNmZXJSCHRyYW5zZmVy');
@$core.Deprecated('Use createVirtualAccountRequestDescriptor instead')
const CreateVirtualAccountRequest$json = const {
  '1': 'CreateVirtualAccountRequest',
  '2': const [
    const {'1': 'account_name', '3': 1, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'locale', '3': 4, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'is_primary', '3': 5, '4': 1, '5': 8, '10': 'isPrimary'},
    const {'1': 'daily_limit', '3': 6, '4': 1, '5': 1, '10': 'dailyLimit'},
    const {'1': 'monthly_limit', '3': 7, '4': 1, '5': 1, '10': 'monthlyLimit'},
    const {'1': 'email', '3': 8, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'first_name', '3': 9, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 10, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'bvn', '3': 12, '4': 1, '5': 9, '10': 'bvn'},
  ],
};

/// Descriptor for `CreateVirtualAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualAccountRequestDescriptor = $convert.base64Decode('ChtDcmVhdGVWaXJ0dWFsQWNjb3VudFJlcXVlc3QSIQoMYWNjb3VudF9uYW1lGAEgASgJUgthY2NvdW50TmFtZRIhCgxhY2NvdW50X3R5cGUYAiABKAlSC2FjY291bnRUeXBlEhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIWCgZsb2NhbGUYBCABKAlSBmxvY2FsZRIdCgppc19wcmltYXJ5GAUgASgIUglpc1ByaW1hcnkSHwoLZGFpbHlfbGltaXQYBiABKAFSCmRhaWx5TGltaXQSIwoNbW9udGhseV9saW1pdBgHIAEoAVIMbW9udGhseUxpbWl0EhQKBWVtYWlsGAggASgJUgVlbWFpbBIdCgpmaXJzdF9uYW1lGAkgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAogASgJUghsYXN0TmFtZRIhCgxwaG9uZV9udW1iZXIYCyABKAlSC3Bob25lTnVtYmVyEhAKA2J2bhgMIAEoCVIDYnZu');
@$core.Deprecated('Use createVirtualAccountResponseDescriptor instead')
const CreateVirtualAccountResponse$json = const {
  '1': 'CreateVirtualAccountResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `CreateVirtualAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualAccountResponseDescriptor = $convert.base64Decode('ChxDcmVhdGVWaXJ0dWFsQWNjb3VudFJlc3BvbnNlEisKB2FjY291bnQYASABKAsyES5hY2NvdW50cy5BY2NvdW50UgdhY2NvdW50EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USGgoIcHJvdmlkZXIYAyABKAlSCHByb3ZpZGVy');
@$core.Deprecated('Use creditBalanceRequestDescriptor instead')
const CreditBalanceRequest$json = const {
  '1': 'CreditBalanceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'type', '3': 6, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 9, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'counterparty_name', '3': 11, '4': 1, '5': 9, '10': 'counterpartyName'},
    const {'1': 'counterparty_account', '3': 12, '4': 1, '5': 9, '10': 'counterpartyAccount'},
  ],
};

/// Descriptor for `CreditBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditBalanceRequestDescriptor = $convert.base64Decode('ChRDcmVkaXRCYWxhbmNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBmFtb3VudBgDIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYBSABKAlSCXJlZmVyZW5jZRISCgR0eXBlGAYgASgJUgR0eXBlEiAKC2Rlc2NyaXB0aW9uGAcgASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgIIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAkgASgJUgtzZXJ2aWNlTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYCiABKAlSDmlkZW1wb3RlbmN5S2V5EisKEWNvdW50ZXJwYXJ0eV9uYW1lGAsgASgJUhBjb3VudGVycGFydHlOYW1lEjEKFGNvdW50ZXJwYXJ0eV9hY2NvdW50GAwgASgJUhNjb3VudGVycGFydHlBY2NvdW50');
@$core.Deprecated('Use creditBalanceResponseDescriptor instead')
const CreditBalanceResponse$json = const {
  '1': 'CreditBalanceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'new_balance', '3': 5, '4': 1, '5': 3, '10': 'newBalance'},
    const {'1': 'new_available_balance', '3': 6, '4': 1, '5': 3, '10': 'newAvailableBalance'},
  ],
};

/// Descriptor for `CreditBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditBalanceResponseDescriptor = $convert.base64Decode('ChVDcmVkaXRCYWxhbmNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEiUKDnRyYW5zYWN0aW9uX2lkGAQgASgJUg10cmFuc2FjdGlvbklkEh8KC25ld19iYWxhbmNlGAUgASgDUgpuZXdCYWxhbmNlEjIKFW5ld19hdmFpbGFibGVfYmFsYW5jZRgGIAEoA1ITbmV3QXZhaWxhYmxlQmFsYW5jZQ==');
@$core.Deprecated('Use debitBalanceRequestDescriptor instead')
const DebitBalanceRequest$json = const {
  '1': 'DebitBalanceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'type', '3': 6, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 9, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'require_hold', '3': 11, '4': 1, '5': 8, '10': 'requireHold'},
    const {'1': 'hold_id', '3': 12, '4': 1, '5': 9, '10': 'holdId'},
    const {'1': 'counterparty_name', '3': 13, '4': 1, '5': 9, '10': 'counterpartyName'},
    const {'1': 'counterparty_account', '3': 14, '4': 1, '5': 9, '10': 'counterpartyAccount'},
    const {'1': 'reactive', '3': 15, '4': 1, '5': 8, '10': 'reactive'},
  ],
};

/// Descriptor for `DebitBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debitBalanceRequestDescriptor = $convert.base64Decode('ChNEZWJpdEJhbGFuY2VSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgFIAEoCVIJcmVmZXJlbmNlEhIKBHR5cGUYBiABKAlSBHR5cGUSIAoLZGVzY3JpcHRpb24YByABKAlSC2Rlc2NyaXB0aW9uEhoKCG1ldGFkYXRhGAggASgJUghtZXRhZGF0YRIhCgxzZXJ2aWNlX25hbWUYCSABKAlSC3NlcnZpY2VOYW1lEicKD2lkZW1wb3RlbmN5X2tleRgKIAEoCVIOaWRlbXBvdGVuY3lLZXkSIQoMcmVxdWlyZV9ob2xkGAsgASgIUgtyZXF1aXJlSG9sZBIXCgdob2xkX2lkGAwgASgJUgZob2xkSWQSKwoRY291bnRlcnBhcnR5X25hbWUYDSABKAlSEGNvdW50ZXJwYXJ0eU5hbWUSMQoUY291bnRlcnBhcnR5X2FjY291bnQYDiABKAlSE2NvdW50ZXJwYXJ0eUFjY291bnQSGgoIcmVhY3RpdmUYDyABKAhSCHJlYWN0aXZl');
@$core.Deprecated('Use debitBalanceResponseDescriptor instead')
const DebitBalanceResponse$json = const {
  '1': 'DebitBalanceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'new_balance', '3': 5, '4': 1, '5': 3, '10': 'newBalance'},
    const {'1': 'new_available_balance', '3': 6, '4': 1, '5': 3, '10': 'newAvailableBalance'},
    const {'1': 'daily_spent_today', '3': 7, '4': 1, '5': 3, '10': 'dailySpentToday'},
    const {'1': 'monthly_spent', '3': 8, '4': 1, '5': 3, '10': 'monthlySpent'},
    const {'1': 'remaining_daily_limit', '3': 9, '4': 1, '5': 3, '10': 'remainingDailyLimit'},
    const {'1': 'remaining_monthly_limit', '3': 10, '4': 1, '5': 3, '10': 'remainingMonthlyLimit'},
    const {'1': 'remaining_single_transaction_limit', '3': 11, '4': 1, '5': 3, '10': 'remainingSingleTransactionLimit'},
  ],
};

/// Descriptor for `DebitBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debitBalanceResponseDescriptor = $convert.base64Decode('ChREZWJpdEJhbGFuY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USJQoOdHJhbnNhY3Rpb25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSHwoLbmV3X2JhbGFuY2UYBSABKANSCm5ld0JhbGFuY2USMgoVbmV3X2F2YWlsYWJsZV9iYWxhbmNlGAYgASgDUhNuZXdBdmFpbGFibGVCYWxhbmNlEioKEWRhaWx5X3NwZW50X3RvZGF5GAcgASgDUg9kYWlseVNwZW50VG9kYXkSIwoNbW9udGhseV9zcGVudBgIIAEoA1IMbW9udGhseVNwZW50EjIKFXJlbWFpbmluZ19kYWlseV9saW1pdBgJIAEoA1ITcmVtYWluaW5nRGFpbHlMaW1pdBI2ChdyZW1haW5pbmdfbW9udGhseV9saW1pdBgKIAEoA1IVcmVtYWluaW5nTW9udGhseUxpbWl0EksKInJlbWFpbmluZ19zaW5nbGVfdHJhbnNhY3Rpb25fbGltaXQYCyABKANSH3JlbWFpbmluZ1NpbmdsZVRyYW5zYWN0aW9uTGltaXQ=');
@$core.Deprecated('Use transferBalanceRequestDescriptor instead')
const TransferBalanceRequest$json = const {
  '1': 'TransferBalanceRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'to_account_id', '3': 2, '4': 1, '5': 9, '10': 'toAccountId'},
    const {'1': 'from_user_id', '3': 3, '4': 1, '5': 9, '10': 'fromUserId'},
    const {'1': 'to_user_id', '3': 4, '4': 1, '5': 9, '10': 'toUserId'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 9, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 10, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `TransferBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferBalanceRequestDescriptor = $convert.base64Decode('ChZUcmFuc2ZlckJhbGFuY2VSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZnJvbUFjY291bnRJZBIiCg10b19hY2NvdW50X2lkGAIgASgJUgt0b0FjY291bnRJZBIgCgxmcm9tX3VzZXJfaWQYAyABKAlSCmZyb21Vc2VySWQSHAoKdG9fdXNlcl9pZBgEIAEoCVIIdG9Vc2VySWQSFgoGYW1vdW50GAUgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgHIAEoCVIJcmVmZXJlbmNlEiAKC2Rlc2NyaXB0aW9uGAggASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgJIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAogASgJUgtzZXJ2aWNlTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYCyABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use transferBalanceResponseDescriptor instead')
const TransferBalanceResponse$json = const {
  '1': 'TransferBalanceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'debit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'debitTransactionId'},
    const {'1': 'credit_transaction_id', '3': 5, '4': 1, '5': 9, '10': 'creditTransactionId'},
    const {'1': 'from_new_balance', '3': 6, '4': 1, '5': 3, '10': 'fromNewBalance'},
    const {'1': 'to_new_balance', '3': 7, '4': 1, '5': 3, '10': 'toNewBalance'},
  ],
};

/// Descriptor for `TransferBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferBalanceResponseDescriptor = $convert.base64Decode('ChdUcmFuc2ZlckJhbGFuY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USMAoUZGViaXRfdHJhbnNhY3Rpb25faWQYBCABKAlSEmRlYml0VHJhbnNhY3Rpb25JZBIyChVjcmVkaXRfdHJhbnNhY3Rpb25faWQYBSABKAlSE2NyZWRpdFRyYW5zYWN0aW9uSWQSKAoQZnJvbV9uZXdfYmFsYW5jZRgGIAEoA1IOZnJvbU5ld0JhbGFuY2USJAoOdG9fbmV3X2JhbGFuY2UYByABKANSDHRvTmV3QmFsYW5jZQ==');
@$core.Deprecated('Use holdFundsRequestDescriptor instead')
const HoldFundsRequest$json = const {
  '1': 'HoldFundsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'reason', '3': 6, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'expires_in_seconds', '3': 7, '4': 1, '5': 5, '10': 'expiresInSeconds'},
    const {'1': 'service_name', '3': 8, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `HoldFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdFundsRequestDescriptor = $convert.base64Decode('ChBIb2xkRnVuZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgFIAEoCVIJcmVmZXJlbmNlEhYKBnJlYXNvbhgGIAEoCVIGcmVhc29uEiwKEmV4cGlyZXNfaW5fc2Vjb25kcxgHIAEoBVIQZXhwaXJlc0luU2Vjb25kcxIhCgxzZXJ2aWNlX25hbWUYCCABKAlSC3NlcnZpY2VOYW1lEicKD2lkZW1wb3RlbmN5X2tleRgJIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use holdFundsResponseDescriptor instead')
const HoldFundsResponse$json = const {
  '1': 'HoldFundsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'hold_id', '3': 4, '4': 1, '5': 9, '10': 'holdId'},
    const {'1': 'new_available_balance', '3': 5, '4': 1, '5': 3, '10': 'newAvailableBalance'},
    const {'1': 'expires_at', '3': 6, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `HoldFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdFundsResponseDescriptor = $convert.base64Decode('ChFIb2xkRnVuZHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USFwoHaG9sZF9pZBgEIAEoCVIGaG9sZElkEjIKFW5ld19hdmFpbGFibGVfYmFsYW5jZRgFIAEoA1ITbmV3QXZhaWxhYmxlQmFsYW5jZRIdCgpleHBpcmVzX2F0GAYgASgJUglleHBpcmVzQXQ=');
@$core.Deprecated('Use captureHoldRequestDescriptor instead')
const CaptureHoldRequest$json = const {
  '1': 'CaptureHoldRequest',
  '2': const [
    const {'1': 'hold_id', '3': 1, '4': 1, '5': 9, '10': 'holdId'},
    const {'1': 'service_name', '3': 2, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'actual_amount', '3': 5, '4': 1, '5': 1, '10': 'actualAmount'},
  ],
};

/// Descriptor for `CaptureHoldRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List captureHoldRequestDescriptor = $convert.base64Decode('ChJDYXB0dXJlSG9sZFJlcXVlc3QSFwoHaG9sZF9pZBgBIAEoCVIGaG9sZElkEiEKDHNlcnZpY2VfbmFtZRgCIAEoCVILc2VydmljZU5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhoKCG1ldGFkYXRhGAQgASgJUghtZXRhZGF0YRIjCg1hY3R1YWxfYW1vdW50GAUgASgBUgxhY3R1YWxBbW91bnQ=');
@$core.Deprecated('Use captureHoldResponseDescriptor instead')
const CaptureHoldResponse$json = const {
  '1': 'CaptureHoldResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'new_balance', '3': 5, '4': 1, '5': 3, '10': 'newBalance'},
    const {'1': 'captured_amount', '3': 6, '4': 1, '5': 1, '10': 'capturedAmount'},
    const {'1': 'overage_amount', '3': 7, '4': 1, '5': 1, '10': 'overageAmount'},
    const {'1': 'refund_amount', '3': 8, '4': 1, '5': 1, '10': 'refundAmount'},
  ],
};

/// Descriptor for `CaptureHoldResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List captureHoldResponseDescriptor = $convert.base64Decode('ChNDYXB0dXJlSG9sZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIlCg50cmFuc2FjdGlvbl9pZBgEIAEoCVINdHJhbnNhY3Rpb25JZBIfCgtuZXdfYmFsYW5jZRgFIAEoA1IKbmV3QmFsYW5jZRInCg9jYXB0dXJlZF9hbW91bnQYBiABKAFSDmNhcHR1cmVkQW1vdW50EiUKDm92ZXJhZ2VfYW1vdW50GAcgASgBUg1vdmVyYWdlQW1vdW50EiMKDXJlZnVuZF9hbW91bnQYCCABKAFSDHJlZnVuZEFtb3VudA==');
@$core.Deprecated('Use releaseHoldRequestDescriptor instead')
const ReleaseHoldRequest$json = const {
  '1': 'ReleaseHoldRequest',
  '2': const [
    const {'1': 'hold_id', '3': 1, '4': 1, '5': 9, '10': 'holdId'},
    const {'1': 'service_name', '3': 2, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `ReleaseHoldRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List releaseHoldRequestDescriptor = $convert.base64Decode('ChJSZWxlYXNlSG9sZFJlcXVlc3QSFwoHaG9sZF9pZBgBIAEoCVIGaG9sZElkEiEKDHNlcnZpY2VfbmFtZRgCIAEoCVILc2VydmljZU5hbWUSFgoGcmVhc29uGAMgASgJUgZyZWFzb24=');
@$core.Deprecated('Use releaseHoldResponseDescriptor instead')
const ReleaseHoldResponse$json = const {
  '1': 'ReleaseHoldResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'new_available_balance', '3': 4, '4': 1, '5': 3, '10': 'newAvailableBalance'},
  ],
};

/// Descriptor for `ReleaseHoldResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List releaseHoldResponseDescriptor = $convert.base64Decode('ChNSZWxlYXNlSG9sZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIyChVuZXdfYXZhaWxhYmxlX2JhbGFuY2UYBCABKANSE25ld0F2YWlsYWJsZUJhbGFuY2U=');
@$core.Deprecated('Use platformWalletMsgDescriptor instead')
const PlatformWalletMsg$json = const {
  '1': 'PlatformWalletMsg',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'wallet_code', '3': 2, '4': 1, '5': 9, '10': 'walletCode'},
    const {'1': 'wallet_name', '3': 3, '4': 1, '5': 9, '10': 'walletName'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'balance', '3': 5, '4': 1, '5': 3, '10': 'balance'},
    const {'1': 'available_balance', '3': 6, '4': 1, '5': 3, '10': 'availableBalance'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 10, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `PlatformWalletMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List platformWalletMsgDescriptor = $convert.base64Decode('ChFQbGF0Zm9ybVdhbGxldE1zZxIOCgJpZBgBIAEoCVICaWQSHwoLd2FsbGV0X2NvZGUYAiABKAlSCndhbGxldENvZGUSHwoLd2FsbGV0X25hbWUYAyABKAlSCndhbGxldE5hbWUSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhgKB2JhbGFuY2UYBSABKANSB2JhbGFuY2USKwoRYXZhaWxhYmxlX2JhbGFuY2UYBiABKANSEGF2YWlsYWJsZUJhbGFuY2USFgoGc3RhdHVzGAcgASgJUgZzdGF0dXMSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEh0KCmNyZWF0ZWRfYXQYCSABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAogASgJUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use platformWalletTransactionMsgDescriptor instead')
const PlatformWalletTransactionMsg$json = const {
  '1': 'PlatformWalletTransactionMsg',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'wallet_id', '3': 2, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'balance_before', '3': 7, '4': 1, '5': 3, '10': 'balanceBefore'},
    const {'1': 'balance_after', '3': 8, '4': 1, '5': 3, '10': 'balanceAfter'},
    const {'1': 'counterparty_account_id', '3': 9, '4': 1, '5': 9, '10': 'counterpartyAccountId'},
    const {'1': 'counterparty_user_id', '3': 10, '4': 1, '5': 9, '10': 'counterpartyUserId'},
    const {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 12, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 13, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'status', '3': 14, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 15, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `PlatformWalletTransactionMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List platformWalletTransactionMsgDescriptor = $convert.base64Decode('ChxQbGF0Zm9ybVdhbGxldFRyYW5zYWN0aW9uTXNnEg4KAmlkGAEgASgJUgJpZBIbCgl3YWxsZXRfaWQYAiABKAlSCHdhbGxldElkEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhIKBHR5cGUYBCABKAlSBHR5cGUSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgGIAEoA1IGYW1vdW50EiUKDmJhbGFuY2VfYmVmb3JlGAcgASgDUg1iYWxhbmNlQmVmb3JlEiMKDWJhbGFuY2VfYWZ0ZXIYCCABKANSDGJhbGFuY2VBZnRlchI2Chdjb3VudGVycGFydHlfYWNjb3VudF9pZBgJIAEoCVIVY291bnRlcnBhcnR5QWNjb3VudElkEjAKFGNvdW50ZXJwYXJ0eV91c2VyX2lkGAogASgJUhJjb3VudGVycGFydHlVc2VySWQSIAoLZGVzY3JpcHRpb24YCyABKAlSC2Rlc2NyaXB0aW9uEhoKCG1ldGFkYXRhGAwgASgJUghtZXRhZGF0YRIhCgxzZXJ2aWNlX25hbWUYDSABKAlSC3NlcnZpY2VOYW1lEhYKBnN0YXR1cxgOIAEoCVIGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYDyABKAlSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use transferToPlatformWalletRequestDescriptor instead')
const TransferToPlatformWalletRequest$json = const {
  '1': 'TransferToPlatformWalletRequest',
  '2': const [
    const {'1': 'user_account_id', '3': 1, '4': 1, '5': 9, '10': 'userAccountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'wallet_code', '3': 3, '4': 1, '5': 9, '10': 'walletCode'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'category', '3': 7, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 9, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 10, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `TransferToPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferToPlatformWalletRequestDescriptor = $convert.base64Decode('Ch9UcmFuc2ZlclRvUGxhdGZvcm1XYWxsZXRSZXF1ZXN0EiYKD3VzZXJfYWNjb3VudF9pZBgBIAEoCVINdXNlckFjY291bnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHwoLd2FsbGV0X2NvZGUYAyABKAlSCndhbGxldENvZGUSFgoGYW1vdW50GAQgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgGIAEoCVIJcmVmZXJlbmNlEhoKCGNhdGVnb3J5GAcgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgIIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYCSABKAlSCG1ldGFkYXRhEiEKDHNlcnZpY2VfbmFtZRgKIAEoCVILc2VydmljZU5hbWUSJwoPaWRlbXBvdGVuY3lfa2V5GAsgASgJUg5pZGVtcG90ZW5jeUtleQ==');
@$core.Deprecated('Use transferToPlatformWalletResponseDescriptor instead')
const TransferToPlatformWalletResponse$json = const {
  '1': 'TransferToPlatformWalletResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'debit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'debitTransactionId'},
    const {'1': 'platform_transaction_id', '3': 5, '4': 1, '5': 9, '10': 'platformTransactionId'},
    const {'1': 'user_new_balance', '3': 6, '4': 1, '5': 3, '10': 'userNewBalance'},
    const {'1': 'wallet_new_balance', '3': 7, '4': 1, '5': 3, '10': 'walletNewBalance'},
  ],
};

/// Descriptor for `TransferToPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferToPlatformWalletResponseDescriptor = $convert.base64Decode('CiBUcmFuc2ZlclRvUGxhdGZvcm1XYWxsZXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USMAoUZGViaXRfdHJhbnNhY3Rpb25faWQYBCABKAlSEmRlYml0VHJhbnNhY3Rpb25JZBI2ChdwbGF0Zm9ybV90cmFuc2FjdGlvbl9pZBgFIAEoCVIVcGxhdGZvcm1UcmFuc2FjdGlvbklkEigKEHVzZXJfbmV3X2JhbGFuY2UYBiABKANSDnVzZXJOZXdCYWxhbmNlEiwKEndhbGxldF9uZXdfYmFsYW5jZRgHIAEoA1IQd2FsbGV0TmV3QmFsYW5jZQ==');
@$core.Deprecated('Use transferFromPlatformWalletRequestDescriptor instead')
const TransferFromPlatformWalletRequest$json = const {
  '1': 'TransferFromPlatformWalletRequest',
  '2': const [
    const {'1': 'wallet_code', '3': 1, '4': 1, '5': 9, '10': 'walletCode'},
    const {'1': 'user_account_id', '3': 2, '4': 1, '5': 9, '10': 'userAccountId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'category', '3': 7, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 9, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 10, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `TransferFromPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferFromPlatformWalletRequestDescriptor = $convert.base64Decode('CiFUcmFuc2ZlckZyb21QbGF0Zm9ybVdhbGxldFJlcXVlc3QSHwoLd2FsbGV0X2NvZGUYASABKAlSCndhbGxldENvZGUSJgoPdXNlcl9hY2NvdW50X2lkGAIgASgJUg11c2VyQWNjb3VudElkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIWCgZhbW91bnQYBCABKANSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSHAoJcmVmZXJlbmNlGAYgASgJUglyZWZlcmVuY2USGgoIY2F0ZWdvcnkYByABKAlSCGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGAggASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgJIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAogASgJUgtzZXJ2aWNlTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYCyABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use transferFromPlatformWalletResponseDescriptor instead')
const TransferFromPlatformWalletResponse$json = const {
  '1': 'TransferFromPlatformWalletResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'credit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'creditTransactionId'},
    const {'1': 'platform_transaction_id', '3': 5, '4': 1, '5': 9, '10': 'platformTransactionId'},
    const {'1': 'user_new_balance', '3': 6, '4': 1, '5': 3, '10': 'userNewBalance'},
    const {'1': 'wallet_new_balance', '3': 7, '4': 1, '5': 3, '10': 'walletNewBalance'},
  ],
};

/// Descriptor for `TransferFromPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferFromPlatformWalletResponseDescriptor = $convert.base64Decode('CiJUcmFuc2ZlckZyb21QbGF0Zm9ybVdhbGxldFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRIyChVjcmVkaXRfdHJhbnNhY3Rpb25faWQYBCABKAlSE2NyZWRpdFRyYW5zYWN0aW9uSWQSNgoXcGxhdGZvcm1fdHJhbnNhY3Rpb25faWQYBSABKAlSFXBsYXRmb3JtVHJhbnNhY3Rpb25JZBIoChB1c2VyX25ld19iYWxhbmNlGAYgASgDUg51c2VyTmV3QmFsYW5jZRIsChJ3YWxsZXRfbmV3X2JhbGFuY2UYByABKANSEHdhbGxldE5ld0JhbGFuY2U=');
@$core.Deprecated('Use creditPlatformWalletRequestDescriptor instead')
const CreditPlatformWalletRequest$json = const {
  '1': 'CreditPlatformWalletRequest',
  '2': const [
    const {'1': 'wallet_code', '3': 1, '4': 1, '5': 9, '10': 'walletCode'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 7, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 8, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'source_account_id', '3': 10, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'source_user_id', '3': 11, '4': 1, '5': 9, '10': 'sourceUserId'},
    const {'1': 'source_payment_id', '3': 12, '4': 1, '5': 9, '10': 'sourcePaymentId'},
  ],
};

/// Descriptor for `CreditPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditPlatformWalletRequestDescriptor = $convert.base64Decode('ChtDcmVkaXRQbGF0Zm9ybVdhbGxldFJlcXVlc3QSHwoLd2FsbGV0X2NvZGUYASABKAlSCndhbGxldENvZGUSFgoGYW1vdW50GAIgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgEIAEoCVIJcmVmZXJlbmNlEhoKCGNhdGVnb3J5GAUgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYByABKAlSCG1ldGFkYXRhEiEKDHNlcnZpY2VfbmFtZRgIIAEoCVILc2VydmljZU5hbWUSJwoPaWRlbXBvdGVuY3lfa2V5GAkgASgJUg5pZGVtcG90ZW5jeUtleRIqChFzb3VyY2VfYWNjb3VudF9pZBgKIAEoCVIPc291cmNlQWNjb3VudElkEiQKDnNvdXJjZV91c2VyX2lkGAsgASgJUgxzb3VyY2VVc2VySWQSKgoRc291cmNlX3BheW1lbnRfaWQYDCABKAlSD3NvdXJjZVBheW1lbnRJZA==');
@$core.Deprecated('Use creditPlatformWalletResponseDescriptor instead')
const CreditPlatformWalletResponse$json = const {
  '1': 'CreditPlatformWalletResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'platform_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'platformTransactionId'},
    const {'1': 'wallet_new_balance', '3': 5, '4': 1, '5': 3, '10': 'walletNewBalance'},
  ],
};

/// Descriptor for `CreditPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditPlatformWalletResponseDescriptor = $convert.base64Decode('ChxDcmVkaXRQbGF0Zm9ybVdhbGxldFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRI2ChdwbGF0Zm9ybV90cmFuc2FjdGlvbl9pZBgEIAEoCVIVcGxhdGZvcm1UcmFuc2FjdGlvbklkEiwKEndhbGxldF9uZXdfYmFsYW5jZRgFIAEoA1IQd2FsbGV0TmV3QmFsYW5jZQ==');
@$core.Deprecated('Use debitPlatformWalletRequestDescriptor instead')
const DebitPlatformWalletRequest$json = const {
  '1': 'DebitPlatformWalletRequest',
  '2': const [
    const {'1': 'wallet_code', '3': 1, '4': 1, '5': 9, '10': 'walletCode'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 7, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 8, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'source_account_id', '3': 10, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'source_user_id', '3': 11, '4': 1, '5': 9, '10': 'sourceUserId'},
    const {'1': 'source_payment_id', '3': 12, '4': 1, '5': 9, '10': 'sourcePaymentId'},
  ],
};

/// Descriptor for `DebitPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debitPlatformWalletRequestDescriptor = $convert.base64Decode('ChpEZWJpdFBsYXRmb3JtV2FsbGV0UmVxdWVzdBIfCgt3YWxsZXRfY29kZRgBIAEoCVIKd2FsbGV0Q29kZRIWCgZhbW91bnQYAiABKANSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSHAoJcmVmZXJlbmNlGAQgASgJUglyZWZlcmVuY2USGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGAYgASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgHIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAggASgJUgtzZXJ2aWNlTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2V5EioKEXNvdXJjZV9hY2NvdW50X2lkGAogASgJUg9zb3VyY2VBY2NvdW50SWQSJAoOc291cmNlX3VzZXJfaWQYCyABKAlSDHNvdXJjZVVzZXJJZBIqChFzb3VyY2VfcGF5bWVudF9pZBgMIAEoCVIPc291cmNlUGF5bWVudElk');
@$core.Deprecated('Use debitPlatformWalletResponseDescriptor instead')
const DebitPlatformWalletResponse$json = const {
  '1': 'DebitPlatformWalletResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'platform_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'platformTransactionId'},
    const {'1': 'wallet_new_balance', '3': 5, '4': 1, '5': 3, '10': 'walletNewBalance'},
  ],
};

/// Descriptor for `DebitPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debitPlatformWalletResponseDescriptor = $convert.base64Decode('ChtEZWJpdFBsYXRmb3JtV2FsbGV0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEjYKF3BsYXRmb3JtX3RyYW5zYWN0aW9uX2lkGAQgASgJUhVwbGF0Zm9ybVRyYW5zYWN0aW9uSWQSLAoSd2FsbGV0X25ld19iYWxhbmNlGAUgASgDUhB3YWxsZXROZXdCYWxhbmNl');
@$core.Deprecated('Use getPlatformWalletRequestDescriptor instead')
const GetPlatformWalletRequest$json = const {
  '1': 'GetPlatformWalletRequest',
  '2': const [
    const {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'wallet_code', '3': 2, '4': 1, '5': 9, '10': 'walletCode'},
  ],
};

/// Descriptor for `GetPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformWalletRequestDescriptor = $convert.base64Decode('ChhHZXRQbGF0Zm9ybVdhbGxldFJlcXVlc3QSGwoJd2FsbGV0X2lkGAEgASgJUgh3YWxsZXRJZBIfCgt3YWxsZXRfY29kZRgCIAEoCVIKd2FsbGV0Q29kZQ==');
@$core.Deprecated('Use getPlatformWalletResponseDescriptor instead')
const GetPlatformWalletResponse$json = const {
  '1': 'GetPlatformWalletResponse',
  '2': const [
    const {'1': 'wallet', '3': 1, '4': 1, '5': 11, '6': '.accounts.PlatformWalletMsg', '10': 'wallet'},
  ],
};

/// Descriptor for `GetPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformWalletResponseDescriptor = $convert.base64Decode('ChlHZXRQbGF0Zm9ybVdhbGxldFJlc3BvbnNlEjMKBndhbGxldBgBIAEoCzIbLmFjY291bnRzLlBsYXRmb3JtV2FsbGV0TXNnUgZ3YWxsZXQ=');
@$core.Deprecated('Use getPlatformWalletTransactionsRequestDescriptor instead')
const GetPlatformWalletTransactionsRequest$json = const {
  '1': 'GetPlatformWalletTransactionsRequest',
  '2': const [
    const {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'wallet_code', '3': 2, '4': 1, '5': 9, '10': 'walletCode'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'start_date', '3': 5, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 6, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 7, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 8, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetPlatformWalletTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformWalletTransactionsRequestDescriptor = $convert.base64Decode('CiRHZXRQbGF0Zm9ybVdhbGxldFRyYW5zYWN0aW9uc1JlcXVlc3QSGwoJd2FsbGV0X2lkGAEgASgJUgh3YWxsZXRJZBIfCgt3YWxsZXRfY29kZRgCIAEoCVIKd2FsbGV0Q29kZRISCgR0eXBlGAMgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIdCgpzdGFydF9kYXRlGAUgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYBiABKAlSB2VuZERhdGUSFAoFbGltaXQYByABKAVSBWxpbWl0EhYKBm9mZnNldBgIIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getPlatformWalletTransactionsResponseDescriptor instead')
const GetPlatformWalletTransactionsResponse$json = const {
  '1': 'GetPlatformWalletTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.PlatformWalletTransactionMsg', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPlatformWalletTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformWalletTransactionsResponseDescriptor = $convert.base64Decode('CiVHZXRQbGF0Zm9ybVdhbGxldFRyYW5zYWN0aW9uc1Jlc3BvbnNlEkoKDHRyYW5zYWN0aW9ucxgBIAMoCzImLmFjY291bnRzLlBsYXRmb3JtV2FsbGV0VHJhbnNhY3Rpb25Nc2dSDHRyYW5zYWN0aW9ucxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use periodTotalsDescriptor instead')
const PeriodTotals$json = const {
  '1': 'PeriodTotals',
  '2': const [
    const {'1': 'total_income', '3': 1, '4': 1, '5': 1, '10': 'totalIncome'},
    const {'1': 'total_expenses', '3': 2, '4': 1, '5': 1, '10': 'totalExpenses'},
    const {'1': 'net', '3': 3, '4': 1, '5': 1, '10': 'net'},
    const {'1': 'transaction_count', '3': 4, '4': 1, '5': 5, '10': 'transactionCount'},
  ],
};

/// Descriptor for `PeriodTotals`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List periodTotalsDescriptor = $convert.base64Decode('CgxQZXJpb2RUb3RhbHMSIQoMdG90YWxfaW5jb21lGAEgASgBUgt0b3RhbEluY29tZRIlCg50b3RhbF9leHBlbnNlcxgCIAEoAVINdG90YWxFeHBlbnNlcxIQCgNuZXQYAyABKAFSA25ldBIrChF0cmFuc2FjdGlvbl9jb3VudBgEIAEoBVIQdHJhbnNhY3Rpb25Db3VudA==');
@$core.Deprecated('Use getFinancialAnalyticsRequestDescriptor instead')
const GetFinancialAnalyticsRequest$json = const {
  '1': 'GetFinancialAnalyticsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'period', '3': 2, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'include_external_banks', '3': 5, '4': 1, '5': 8, '10': 'includeExternalBanks'},
    const {'1': 'locale', '3': 6, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `GetFinancialAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialAnalyticsRequestDescriptor = $convert.base64Decode('ChxHZXRGaW5hbmNpYWxBbmFseXRpY3NSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIWCgZwZXJpb2QYAiABKAlSBnBlcmlvZBIdCgpzdGFydF9kYXRlGAMgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYBCABKAlSB2VuZERhdGUSNAoWaW5jbHVkZV9leHRlcm5hbF9iYW5rcxgFIAEoCFIUaW5jbHVkZUV4dGVybmFsQmFua3MSFgoGbG9jYWxlGAYgASgJUgZsb2NhbGU=');
@$core.Deprecated('Use getFinancialAnalyticsResponseDescriptor instead')
const GetFinancialAnalyticsResponse$json = const {
  '1': 'GetFinancialAnalyticsResponse',
  '2': const [
    const {'1': 'current_period', '3': 1, '4': 1, '5': 11, '6': '.accounts.PeriodTotals', '10': 'currentPeriod'},
    const {'1': 'previous_period', '3': 2, '4': 1, '5': 11, '6': '.accounts.PeriodTotals', '10': 'previousPeriod'},
    const {'1': 'income_change_percent', '3': 3, '4': 1, '5': 1, '10': 'incomeChangePercent'},
    const {'1': 'expense_change_percent', '3': 4, '4': 1, '5': 1, '10': 'expenseChangePercent'},
    const {'1': 'period_label', '3': 5, '4': 1, '5': 9, '10': 'periodLabel'},
  ],
};

/// Descriptor for `GetFinancialAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialAnalyticsResponseDescriptor = $convert.base64Decode('Ch1HZXRGaW5hbmNpYWxBbmFseXRpY3NSZXNwb25zZRI9Cg5jdXJyZW50X3BlcmlvZBgBIAEoCzIWLmFjY291bnRzLlBlcmlvZFRvdGFsc1INY3VycmVudFBlcmlvZBI/Cg9wcmV2aW91c19wZXJpb2QYAiABKAsyFi5hY2NvdW50cy5QZXJpb2RUb3RhbHNSDnByZXZpb3VzUGVyaW9kEjIKFWluY29tZV9jaGFuZ2VfcGVyY2VudBgDIAEoAVITaW5jb21lQ2hhbmdlUGVyY2VudBI0ChZleHBlbnNlX2NoYW5nZV9wZXJjZW50GAQgASgBUhRleHBlbnNlQ2hhbmdlUGVyY2VudBIhCgxwZXJpb2RfbGFiZWwYBSABKAlSC3BlcmlvZExhYmVs');
@$core.Deprecated('Use subCategoryItemDescriptor instead')
const SubCategoryItem$json = const {
  '1': 'SubCategoryItem',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_count', '3': 3, '4': 1, '5': 5, '10': 'transactionCount'},
    const {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
  ],
};

/// Descriptor for `SubCategoryItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subCategoryItemDescriptor = $convert.base64Decode('Cg9TdWJDYXRlZ29yeUl0ZW0SEgoEbmFtZRgBIAEoCVIEbmFtZRIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIrChF0cmFuc2FjdGlvbl9jb3VudBgDIAEoBVIQdHJhbnNhY3Rpb25Db3VudBIeCgpwZXJjZW50YWdlGAQgASgBUgpwZXJjZW50YWdl');
@$core.Deprecated('Use categoryBreakdownItemDescriptor instead')
const CategoryBreakdownItem$json = const {
  '1': 'CategoryBreakdownItem',
  '2': const [
    const {'1': 'category_name', '3': 1, '4': 1, '5': 9, '10': 'categoryName'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_count', '3': 3, '4': 1, '5': 5, '10': 'transactionCount'},
    const {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
    const {'1': 'sub_categories', '3': 5, '4': 3, '5': 11, '6': '.accounts.SubCategoryItem', '10': 'subCategories'},
  ],
};

/// Descriptor for `CategoryBreakdownItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryBreakdownItemDescriptor = $convert.base64Decode('ChVDYXRlZ29yeUJyZWFrZG93bkl0ZW0SIwoNY2F0ZWdvcnlfbmFtZRgBIAEoCVIMY2F0ZWdvcnlOYW1lEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EisKEXRyYW5zYWN0aW9uX2NvdW50GAMgASgFUhB0cmFuc2FjdGlvbkNvdW50Eh4KCnBlcmNlbnRhZ2UYBCABKAFSCnBlcmNlbnRhZ2USQAoOc3ViX2NhdGVnb3JpZXMYBSADKAsyGS5hY2NvdW50cy5TdWJDYXRlZ29yeUl0ZW1SDXN1YkNhdGVnb3JpZXM=');
@$core.Deprecated('Use getCategoryAnalyticsRequestDescriptor instead')
const GetCategoryAnalyticsRequest$json = const {
  '1': 'GetCategoryAnalyticsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'include_external_banks', '3': 4, '4': 1, '5': 8, '10': 'includeExternalBanks'},
    const {'1': 'locale', '3': 5, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `GetCategoryAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryAnalyticsRequestDescriptor = $convert.base64Decode('ChtHZXRDYXRlZ29yeUFuYWx5dGljc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEh0KCnN0YXJ0X2RhdGUYAiABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgDIAEoCVIHZW5kRGF0ZRI0ChZpbmNsdWRlX2V4dGVybmFsX2JhbmtzGAQgASgIUhRpbmNsdWRlRXh0ZXJuYWxCYW5rcxIWCgZsb2NhbGUYBSABKAlSBmxvY2FsZQ==');
@$core.Deprecated('Use getCategoryAnalyticsResponseDescriptor instead')
const GetCategoryAnalyticsResponse$json = const {
  '1': 'GetCategoryAnalyticsResponse',
  '2': const [
    const {'1': 'expense_categories', '3': 1, '4': 3, '5': 11, '6': '.accounts.CategoryBreakdownItem', '10': 'expenseCategories'},
    const {'1': 'income_categories', '3': 2, '4': 3, '5': 11, '6': '.accounts.CategoryBreakdownItem', '10': 'incomeCategories'},
    const {'1': 'total_expenses', '3': 3, '4': 1, '5': 1, '10': 'totalExpenses'},
    const {'1': 'total_income', '3': 4, '4': 1, '5': 1, '10': 'totalIncome'},
  ],
};

/// Descriptor for `GetCategoryAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryAnalyticsResponseDescriptor = $convert.base64Decode('ChxHZXRDYXRlZ29yeUFuYWx5dGljc1Jlc3BvbnNlEk4KEmV4cGVuc2VfY2F0ZWdvcmllcxgBIAMoCzIfLmFjY291bnRzLkNhdGVnb3J5QnJlYWtkb3duSXRlbVIRZXhwZW5zZUNhdGVnb3JpZXMSTAoRaW5jb21lX2NhdGVnb3JpZXMYAiADKAsyHy5hY2NvdW50cy5DYXRlZ29yeUJyZWFrZG93bkl0ZW1SEGluY29tZUNhdGVnb3JpZXMSJQoOdG90YWxfZXhwZW5zZXMYAyABKAFSDXRvdGFsRXhwZW5zZXMSIQoMdG90YWxfaW5jb21lGAQgASgBUgt0b3RhbEluY29tZQ==');
@$core.Deprecated('Use monthlyDataPointDescriptor instead')
const MonthlyDataPoint$json = const {
  '1': 'MonthlyDataPoint',
  '2': const [
    const {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    const {'1': 'month_label', '3': 2, '4': 1, '5': 9, '10': 'monthLabel'},
    const {'1': 'income', '3': 3, '4': 1, '5': 1, '10': 'income'},
    const {'1': 'expenses', '3': 4, '4': 1, '5': 1, '10': 'expenses'},
  ],
};

/// Descriptor for `MonthlyDataPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monthlyDataPointDescriptor = $convert.base64Decode('ChBNb250aGx5RGF0YVBvaW50EhQKBW1vbnRoGAEgASgJUgVtb250aBIfCgttb250aF9sYWJlbBgCIAEoCVIKbW9udGhMYWJlbBIWCgZpbmNvbWUYAyABKAFSBmluY29tZRIaCghleHBlbnNlcxgEIAEoAVIIZXhwZW5zZXM=');
@$core.Deprecated('Use getMonthlyTrendsRequestDescriptor instead')
const GetMonthlyTrendsRequest$json = const {
  '1': 'GetMonthlyTrendsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'months', '3': 2, '4': 1, '5': 5, '10': 'months'},
    const {'1': 'locale', '3': 3, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `GetMonthlyTrendsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMonthlyTrendsRequestDescriptor = $convert.base64Decode('ChdHZXRNb250aGx5VHJlbmRzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFgoGbW9udGhzGAIgASgFUgZtb250aHMSFgoGbG9jYWxlGAMgASgJUgZsb2NhbGU=');
@$core.Deprecated('Use getMonthlyTrendsResponseDescriptor instead')
const GetMonthlyTrendsResponse$json = const {
  '1': 'GetMonthlyTrendsResponse',
  '2': const [
    const {'1': 'months', '3': 1, '4': 3, '5': 11, '6': '.accounts.MonthlyDataPoint', '10': 'months'},
  ],
};

/// Descriptor for `GetMonthlyTrendsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMonthlyTrendsResponseDescriptor = $convert.base64Decode('ChhHZXRNb250aGx5VHJlbmRzUmVzcG9uc2USMgoGbW9udGhzGAEgAygLMhouYWNjb3VudHMuTW9udGhseURhdGFQb2ludFIGbW9udGhz');
@$core.Deprecated('Use dailyExpensePointDescriptor instead')
const DailyExpensePoint$json = const {
  '1': 'DailyExpensePoint',
  '2': const [
    const {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `DailyExpensePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyExpensePointDescriptor = $convert.base64Decode('ChFEYWlseUV4cGVuc2VQb2ludBISCgRkYXRlGAEgASgJUgRkYXRlEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50');
@$core.Deprecated('Use getExpenseTimeSeriesRequestDescriptor instead')
const GetExpenseTimeSeriesRequest$json = const {
  '1': 'GetExpenseTimeSeriesRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'include_external_banks', '3': 4, '4': 1, '5': 8, '10': 'includeExternalBanks'},
    const {'1': 'locale', '3': 5, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `GetExpenseTimeSeriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpenseTimeSeriesRequestDescriptor = $convert.base64Decode('ChtHZXRFeHBlbnNlVGltZVNlcmllc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEh0KCnN0YXJ0X2RhdGUYAiABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgDIAEoCVIHZW5kRGF0ZRI0ChZpbmNsdWRlX2V4dGVybmFsX2JhbmtzGAQgASgIUhRpbmNsdWRlRXh0ZXJuYWxCYW5rcxIWCgZsb2NhbGUYBSABKAlSBmxvY2FsZQ==');
@$core.Deprecated('Use getExpenseTimeSeriesResponseDescriptor instead')
const GetExpenseTimeSeriesResponse$json = const {
  '1': 'GetExpenseTimeSeriesResponse',
  '2': const [
    const {'1': 'data_points', '3': 1, '4': 3, '5': 11, '6': '.accounts.DailyExpensePoint', '10': 'dataPoints'},
    const {'1': 'total_expenses', '3': 2, '4': 1, '5': 1, '10': 'totalExpenses'},
    const {'1': 'daily_average', '3': 3, '4': 1, '5': 1, '10': 'dailyAverage'},
  ],
};

/// Descriptor for `GetExpenseTimeSeriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpenseTimeSeriesResponseDescriptor = $convert.base64Decode('ChxHZXRFeHBlbnNlVGltZVNlcmllc1Jlc3BvbnNlEjwKC2RhdGFfcG9pbnRzGAEgAygLMhsuYWNjb3VudHMuRGFpbHlFeHBlbnNlUG9pbnRSCmRhdGFQb2ludHMSJQoOdG90YWxfZXhwZW5zZXMYAiABKAFSDXRvdGFsRXhwZW5zZXMSIwoNZGFpbHlfYXZlcmFnZRgDIAEoAVIMZGFpbHlBdmVyYWdl');
@$core.Deprecated('Use userCategoryMappingItemDescriptor instead')
const UserCategoryMappingItem$json = const {
  '1': 'UserCategoryMappingItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'original_category', '3': 2, '4': 1, '5': 9, '10': 'originalCategory'},
    const {'1': 'custom_category', '3': 3, '4': 1, '5': 9, '10': 'customCategory'},
    const {'1': 'display_order', '3': 4, '4': 1, '5': 5, '10': 'displayOrder'},
    const {'1': 'parent_category', '3': 5, '4': 1, '5': 9, '10': 'parentCategory'},
  ],
};

/// Descriptor for `UserCategoryMappingItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userCategoryMappingItemDescriptor = $convert.base64Decode('ChdVc2VyQ2F0ZWdvcnlNYXBwaW5nSXRlbRIOCgJpZBgBIAEoCVICaWQSKwoRb3JpZ2luYWxfY2F0ZWdvcnkYAiABKAlSEG9yaWdpbmFsQ2F0ZWdvcnkSJwoPY3VzdG9tX2NhdGVnb3J5GAMgASgJUg5jdXN0b21DYXRlZ29yeRIjCg1kaXNwbGF5X29yZGVyGAQgASgFUgxkaXNwbGF5T3JkZXISJwoPcGFyZW50X2NhdGVnb3J5GAUgASgJUg5wYXJlbnRDYXRlZ29yeQ==');
@$core.Deprecated('Use getUserCategoryMappingsRequestDescriptor instead')
const GetUserCategoryMappingsRequest$json = const {
  '1': 'GetUserCategoryMappingsRequest',
};

/// Descriptor for `GetUserCategoryMappingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCategoryMappingsRequestDescriptor = $convert.base64Decode('Ch5HZXRVc2VyQ2F0ZWdvcnlNYXBwaW5nc1JlcXVlc3Q=');
@$core.Deprecated('Use getUserCategoryMappingsResponseDescriptor instead')
const GetUserCategoryMappingsResponse$json = const {
  '1': 'GetUserCategoryMappingsResponse',
  '2': const [
    const {'1': 'mappings', '3': 1, '4': 3, '5': 11, '6': '.accounts.UserCategoryMappingItem', '10': 'mappings'},
  ],
};

/// Descriptor for `GetUserCategoryMappingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCategoryMappingsResponseDescriptor = $convert.base64Decode('Ch9HZXRVc2VyQ2F0ZWdvcnlNYXBwaW5nc1Jlc3BvbnNlEj0KCG1hcHBpbmdzGAEgAygLMiEuYWNjb3VudHMuVXNlckNhdGVnb3J5TWFwcGluZ0l0ZW1SCG1hcHBpbmdz');
@$core.Deprecated('Use updateUserCategoryMappingRequestDescriptor instead')
const UpdateUserCategoryMappingRequest$json = const {
  '1': 'UpdateUserCategoryMappingRequest',
  '2': const [
    const {'1': 'original_category', '3': 1, '4': 1, '5': 9, '10': 'originalCategory'},
    const {'1': 'custom_category', '3': 2, '4': 1, '5': 9, '10': 'customCategory'},
    const {'1': 'parent_category', '3': 3, '4': 1, '5': 9, '10': 'parentCategory'},
  ],
};

/// Descriptor for `UpdateUserCategoryMappingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserCategoryMappingRequestDescriptor = $convert.base64Decode('CiBVcGRhdGVVc2VyQ2F0ZWdvcnlNYXBwaW5nUmVxdWVzdBIrChFvcmlnaW5hbF9jYXRlZ29yeRgBIAEoCVIQb3JpZ2luYWxDYXRlZ29yeRInCg9jdXN0b21fY2F0ZWdvcnkYAiABKAlSDmN1c3RvbUNhdGVnb3J5EicKD3BhcmVudF9jYXRlZ29yeRgDIAEoCVIOcGFyZW50Q2F0ZWdvcnk=');
@$core.Deprecated('Use updateUserCategoryMappingResponseDescriptor instead')
const UpdateUserCategoryMappingResponse$json = const {
  '1': 'UpdateUserCategoryMappingResponse',
  '2': const [
    const {'1': 'mapping', '3': 1, '4': 1, '5': 11, '6': '.accounts.UserCategoryMappingItem', '10': 'mapping'},
  ],
};

/// Descriptor for `UpdateUserCategoryMappingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserCategoryMappingResponseDescriptor = $convert.base64Decode('CiFVcGRhdGVVc2VyQ2F0ZWdvcnlNYXBwaW5nUmVzcG9uc2USOwoHbWFwcGluZxgBIAEoCzIhLmFjY291bnRzLlVzZXJDYXRlZ29yeU1hcHBpbmdJdGVtUgdtYXBwaW5n');
@$core.Deprecated('Use categoryOrderItemDescriptor instead')
const CategoryOrderItem$json = const {
  '1': 'CategoryOrderItem',
  '2': const [
    const {'1': 'original_category', '3': 1, '4': 1, '5': 9, '10': 'originalCategory'},
    const {'1': 'display_order', '3': 2, '4': 1, '5': 5, '10': 'displayOrder'},
  ],
};

/// Descriptor for `CategoryOrderItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryOrderItemDescriptor = $convert.base64Decode('ChFDYXRlZ29yeU9yZGVySXRlbRIrChFvcmlnaW5hbF9jYXRlZ29yeRgBIAEoCVIQb3JpZ2luYWxDYXRlZ29yeRIjCg1kaXNwbGF5X29yZGVyGAIgASgFUgxkaXNwbGF5T3JkZXI=');
@$core.Deprecated('Use reorderCategoriesRequestDescriptor instead')
const ReorderCategoriesRequest$json = const {
  '1': 'ReorderCategoriesRequest',
  '2': const [
    const {'1': 'orderings', '3': 1, '4': 3, '5': 11, '6': '.accounts.CategoryOrderItem', '10': 'orderings'},
  ],
};

/// Descriptor for `ReorderCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reorderCategoriesRequestDescriptor = $convert.base64Decode('ChhSZW9yZGVyQ2F0ZWdvcmllc1JlcXVlc3QSOQoJb3JkZXJpbmdzGAEgAygLMhsuYWNjb3VudHMuQ2F0ZWdvcnlPcmRlckl0ZW1SCW9yZGVyaW5ncw==');
@$core.Deprecated('Use reorderCategoriesResponseDescriptor instead')
const ReorderCategoriesResponse$json = const {
  '1': 'ReorderCategoriesResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ReorderCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reorderCategoriesResponseDescriptor = $convert.base64Decode('ChlSZW9yZGVyQ2F0ZWdvcmllc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');
@$core.Deprecated('Use updateSpendingLimitsRequestDescriptor instead')
const UpdateSpendingLimitsRequest$json = const {
  '1': 'UpdateSpendingLimitsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'daily_limit', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'dailyLimit', '17': true},
    const {'1': 'monthly_limit', '3': 3, '4': 1, '5': 1, '9': 1, '10': 'monthlyLimit', '17': true},
    const {'1': 'single_transaction_limit', '3': 4, '4': 1, '5': 1, '9': 2, '10': 'singleTransactionLimit', '17': true},
  ],
  '8': const [
    const {'1': '_daily_limit'},
    const {'1': '_monthly_limit'},
    const {'1': '_single_transaction_limit'},
  ],
};

/// Descriptor for `UpdateSpendingLimitsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSpendingLimitsRequestDescriptor = $convert.base64Decode('ChtVcGRhdGVTcGVuZGluZ0xpbWl0c1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEiQKC2RhaWx5X2xpbWl0GAIgASgBSABSCmRhaWx5TGltaXSIAQESKAoNbW9udGhseV9saW1pdBgDIAEoAUgBUgxtb250aGx5TGltaXSIAQESPQoYc2luZ2xlX3RyYW5zYWN0aW9uX2xpbWl0GAQgASgBSAJSFnNpbmdsZVRyYW5zYWN0aW9uTGltaXSIAQFCDgoMX2RhaWx5X2xpbWl0QhAKDl9tb250aGx5X2xpbWl0QhsKGV9zaW5nbGVfdHJhbnNhY3Rpb25fbGltaXQ=');
@$core.Deprecated('Use updateSpendingLimitsResponseDescriptor instead')
const UpdateSpendingLimitsResponse$json = const {
  '1': 'UpdateSpendingLimitsResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
  ],
};

/// Descriptor for `UpdateSpendingLimitsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSpendingLimitsResponseDescriptor = $convert.base64Decode('ChxVcGRhdGVTcGVuZGluZ0xpbWl0c1Jlc3BvbnNlEisKB2FjY291bnQYASABKAsyES5hY2NvdW50cy5BY2NvdW50UgdhY2NvdW50');
@$core.Deprecated('Use revealPINRequestDescriptor instead')
const RevealPINRequest$json = const {
  '1': 'RevealPINRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'transaction_pin', '3': 2, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `RevealPINRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealPINRequestDescriptor = $convert.base64Decode('ChBSZXZlYWxQSU5SZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBInCg90cmFuc2FjdGlvbl9waW4YAiABKAlSDnRyYW5zYWN0aW9uUGlu');
@$core.Deprecated('Use revealPINResponseDescriptor instead')
const RevealPINResponse$json = const {
  '1': 'RevealPINResponse',
  '2': const [
    const {'1': 'pin', '3': 1, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RevealPINResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealPINResponseDescriptor = $convert.base64Decode('ChFSZXZlYWxQSU5SZXNwb25zZRIQCgNwaW4YASABKAlSA3BpbhIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use revealCardDetailsRequestDescriptor instead')
const RevealCardDetailsRequest$json = const {
  '1': 'RevealCardDetailsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'transaction_pin', '3': 2, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `RevealCardDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealCardDetailsRequestDescriptor = $convert.base64Decode('ChhSZXZlYWxDYXJkRGV0YWlsc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEicKD3RyYW5zYWN0aW9uX3BpbhgCIAEoCVIOdHJhbnNhY3Rpb25QaW4=');
@$core.Deprecated('Use revealCardDetailsResponseDescriptor instead')
const RevealCardDetailsResponse$json = const {
  '1': 'RevealCardDetailsResponse',
  '2': const [
    const {'1': 'card_number', '3': 1, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'card_holder_name', '3': 2, '4': 1, '5': 9, '10': 'cardHolderName'},
    const {'1': 'expiry_date', '3': 3, '4': 1, '5': 9, '10': 'expiryDate'},
    const {'1': 'cvv', '3': 4, '4': 1, '5': 9, '10': 'cvv'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RevealCardDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revealCardDetailsResponseDescriptor = $convert.base64Decode('ChlSZXZlYWxDYXJkRGV0YWlsc1Jlc3BvbnNlEh8KC2NhcmRfbnVtYmVyGAEgASgJUgpjYXJkTnVtYmVyEigKEGNhcmRfaG9sZGVyX25hbWUYAiABKAlSDmNhcmRIb2xkZXJOYW1lEh8KC2V4cGlyeV9kYXRlGAMgASgJUgpleHBpcnlEYXRlEhAKA2N2dhgEIAEoCVIDY3Z2EhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use generateStatementRequestDescriptor instead')
const GenerateStatementRequest$json = const {
  '1': 'GenerateStatementRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 3, '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 3, '10': 'endDate'},
    const {'1': 'format', '3': 4, '4': 1, '5': 9, '10': 'format'},
  ],
};

/// Descriptor for `GenerateStatementRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateStatementRequestDescriptor = $convert.base64Decode('ChhHZW5lcmF0ZVN0YXRlbWVudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEh0KCnN0YXJ0X2RhdGUYAiABKANSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgDIAEoA1IHZW5kRGF0ZRIWCgZmb3JtYXQYBCABKAlSBmZvcm1hdA==');
@$core.Deprecated('Use generateStatementResponseDescriptor instead')
const GenerateStatementResponse$json = const {
  '1': 'GenerateStatementResponse',
  '2': const [
    const {'1': 'document_id', '3': 1, '4': 1, '5': 9, '10': 'documentId'},
    const {'1': 'download_url', '3': 2, '4': 1, '5': 9, '10': 'downloadUrl'},
    const {'1': 'valid_until', '3': 3, '4': 1, '5': 3, '10': 'validUntil'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateStatementResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateStatementResponseDescriptor = $convert.base64Decode('ChlHZW5lcmF0ZVN0YXRlbWVudFJlc3BvbnNlEh8KC2RvY3VtZW50X2lkGAEgASgJUgpkb2N1bWVudElkEiEKDGRvd25sb2FkX3VybBgCIAEoCVILZG93bmxvYWRVcmwSHwoLdmFsaWRfdW50aWwYAyABKANSCnZhbGlkVW50aWwSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use generateAccountConfirmationRequestDescriptor instead')
const GenerateAccountConfirmationRequest$json = const {
  '1': 'GenerateAccountConfirmationRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GenerateAccountConfirmationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateAccountConfirmationRequestDescriptor = $convert.base64Decode('CiJHZW5lcmF0ZUFjY291bnRDb25maXJtYXRpb25SZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZA==');
@$core.Deprecated('Use generateAccountConfirmationResponseDescriptor instead')
const GenerateAccountConfirmationResponse$json = const {
  '1': 'GenerateAccountConfirmationResponse',
  '2': const [
    const {'1': 'document_id', '3': 1, '4': 1, '5': 9, '10': 'documentId'},
    const {'1': 'download_url', '3': 2, '4': 1, '5': 9, '10': 'downloadUrl'},
    const {'1': 'valid_until', '3': 3, '4': 1, '5': 3, '10': 'validUntil'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateAccountConfirmationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateAccountConfirmationResponseDescriptor = $convert.base64Decode('CiNHZW5lcmF0ZUFjY291bnRDb25maXJtYXRpb25SZXNwb25zZRIfCgtkb2N1bWVudF9pZBgBIAEoCVIKZG9jdW1lbnRJZBIhCgxkb3dubG9hZF91cmwYAiABKAlSC2Rvd25sb2FkVXJsEh8KC3ZhbGlkX3VudGlsGAMgASgDUgp2YWxpZFVudGlsEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use generateProofOfFundsRequestDescriptor instead')
const GenerateProofOfFundsRequest$json = const {
  '1': 'GenerateProofOfFundsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GenerateProofOfFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateProofOfFundsRequestDescriptor = $convert.base64Decode('ChtHZW5lcmF0ZVByb29mT2ZGdW5kc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElk');
@$core.Deprecated('Use generateProofOfFundsResponseDescriptor instead')
const GenerateProofOfFundsResponse$json = const {
  '1': 'GenerateProofOfFundsResponse',
  '2': const [
    const {'1': 'document_id', '3': 1, '4': 1, '5': 9, '10': 'documentId'},
    const {'1': 'download_url', '3': 2, '4': 1, '5': 9, '10': 'downloadUrl'},
    const {'1': 'valid_until', '3': 3, '4': 1, '5': 3, '10': 'validUntil'},
    const {'1': 'current_balance', '3': 4, '4': 1, '5': 1, '10': 'currentBalance'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GenerateProofOfFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateProofOfFundsResponseDescriptor = $convert.base64Decode('ChxHZW5lcmF0ZVByb29mT2ZGdW5kc1Jlc3BvbnNlEh8KC2RvY3VtZW50X2lkGAEgASgJUgpkb2N1bWVudElkEiEKDGRvd25sb2FkX3VybBgCIAEoCVILZG93bmxvYWRVcmwSHwoLdmFsaWRfdW50aWwYAyABKANSCnZhbGlkVW50aWwSJwoPY3VycmVudF9iYWxhbmNlGAQgASgBUg5jdXJyZW50QmFsYW5jZRIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSGAoHbWVzc2FnZRgGIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use updateSecuritySettingsRequestDescriptor instead')
const UpdateSecuritySettingsRequest$json = const {
  '1': 'UpdateSecuritySettingsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'enable_3d_secure', '3': 2, '4': 1, '5': 8, '10': 'enable3dSecure'},
    const {'1': 'enable_contactless', '3': 3, '4': 1, '5': 8, '10': 'enableContactless'},
    const {'1': 'enable_online_payments', '3': 4, '4': 1, '5': 8, '10': 'enableOnlinePayments'},
    const {'1': 'enable_atm_withdrawals', '3': 5, '4': 1, '5': 8, '10': 'enableAtmWithdrawals'},
    const {'1': 'enable_international_payments', '3': 6, '4': 1, '5': 8, '10': 'enableInternationalPayments'},
  ],
};

/// Descriptor for `UpdateSecuritySettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSecuritySettingsRequestDescriptor = $convert.base64Decode('Ch1VcGRhdGVTZWN1cml0eVNldHRpbmdzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSKAoQZW5hYmxlXzNkX3NlY3VyZRgCIAEoCFIOZW5hYmxlM2RTZWN1cmUSLQoSZW5hYmxlX2NvbnRhY3RsZXNzGAMgASgIUhFlbmFibGVDb250YWN0bGVzcxI0ChZlbmFibGVfb25saW5lX3BheW1lbnRzGAQgASgIUhRlbmFibGVPbmxpbmVQYXltZW50cxI0ChZlbmFibGVfYXRtX3dpdGhkcmF3YWxzGAUgASgIUhRlbmFibGVBdG1XaXRoZHJhd2FscxJCCh1lbmFibGVfaW50ZXJuYXRpb25hbF9wYXltZW50cxgGIAEoCFIbZW5hYmxlSW50ZXJuYXRpb25hbFBheW1lbnRz');
@$core.Deprecated('Use updateSecuritySettingsResponseDescriptor instead')
const UpdateSecuritySettingsResponse$json = const {
  '1': 'UpdateSecuritySettingsResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'enable_3d_secure', '3': 3, '4': 1, '5': 8, '10': 'enable3dSecure'},
    const {'1': 'enable_contactless', '3': 4, '4': 1, '5': 8, '10': 'enableContactless'},
    const {'1': 'enable_online_payments', '3': 5, '4': 1, '5': 8, '10': 'enableOnlinePayments'},
    const {'1': 'enable_atm_withdrawals', '3': 6, '4': 1, '5': 8, '10': 'enableAtmWithdrawals'},
    const {'1': 'enable_international_payments', '3': 7, '4': 1, '5': 8, '10': 'enableInternationalPayments'},
  ],
};

/// Descriptor for `UpdateSecuritySettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSecuritySettingsResponseDescriptor = $convert.base64Decode('Ch5VcGRhdGVTZWN1cml0eVNldHRpbmdzUmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY291bnRSB2FjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoChBlbmFibGVfM2Rfc2VjdXJlGAMgASgIUg5lbmFibGUzZFNlY3VyZRItChJlbmFibGVfY29udGFjdGxlc3MYBCABKAhSEWVuYWJsZUNvbnRhY3RsZXNzEjQKFmVuYWJsZV9vbmxpbmVfcGF5bWVudHMYBSABKAhSFGVuYWJsZU9ubGluZVBheW1lbnRzEjQKFmVuYWJsZV9hdG1fd2l0aGRyYXdhbHMYBiABKAhSFGVuYWJsZUF0bVdpdGhkcmF3YWxzEkIKHWVuYWJsZV9pbnRlcm5hdGlvbmFsX3BheW1lbnRzGAcgASgIUhtlbmFibGVJbnRlcm5hdGlvbmFsUGF5bWVudHM=');
@$core.Deprecated('Use creditToClearingRequestDescriptor instead')
const CreditToClearingRequest$json = const {
  '1': 'CreditToClearingRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 7, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'service_name', '3': 8, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'provider', '3': 10, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_tx_id', '3': 11, '4': 1, '5': 9, '10': 'providerTxId'},
    const {'1': 'kyc_tier', '3': 12, '4': 1, '5': 5, '10': 'kycTier'},
    const {'1': 'deposit_type', '3': 13, '4': 1, '5': 9, '10': 'depositType'},
  ],
};

/// Descriptor for `CreditToClearingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditToClearingRequestDescriptor = $convert.base64Decode('ChdDcmVkaXRUb0NsZWFyaW5nUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBmFtb3VudBgDIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYBSABKAlSCXJlZmVyZW5jZRIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYByABKAlSCG1ldGFkYXRhEiEKDHNlcnZpY2VfbmFtZRgIIAEoCVILc2VydmljZU5hbWUSJwoPaWRlbXBvdGVuY3lfa2V5GAkgASgJUg5pZGVtcG90ZW5jeUtleRIaCghwcm92aWRlchgKIAEoCVIIcHJvdmlkZXISJAoOcHJvdmlkZXJfdHhfaWQYCyABKAlSDHByb3ZpZGVyVHhJZBIZCghreWNfdGllchgMIAEoBVIHa3ljVGllchIhCgxkZXBvc2l0X3R5cGUYDSABKAlSC2RlcG9zaXRUeXBl');
@$core.Deprecated('Use creditToClearingResponseDescriptor instead')
const CreditToClearingResponse$json = const {
  '1': 'CreditToClearingResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'clearing_record_id', '3': 4, '4': 1, '5': 9, '10': 'clearingRecordId'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'new_balance', '3': 6, '4': 1, '5': 3, '10': 'newBalance'},
    const {'1': 'new_available_balance', '3': 7, '4': 1, '5': 3, '10': 'newAvailableBalance'},
    const {'1': 'clears_at', '3': 8, '4': 1, '5': 9, '10': 'clearsAt'},
  ],
};

/// Descriptor for `CreditToClearingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditToClearingResponseDescriptor = $convert.base64Decode('ChhDcmVkaXRUb0NsZWFyaW5nUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEiwKEmNsZWFyaW5nX3JlY29yZF9pZBgEIAEoCVIQY2xlYXJpbmdSZWNvcmRJZBIlCg50cmFuc2FjdGlvbl9pZBgFIAEoCVINdHJhbnNhY3Rpb25JZBIfCgtuZXdfYmFsYW5jZRgGIAEoA1IKbmV3QmFsYW5jZRIyChVuZXdfYXZhaWxhYmxlX2JhbGFuY2UYByABKANSE25ld0F2YWlsYWJsZUJhbGFuY2USGwoJY2xlYXJzX2F0GAggASgJUghjbGVhcnNBdA==');
@$core.Deprecated('Use clearDepositRequestDescriptor instead')
const ClearDepositRequest$json = const {
  '1': 'ClearDepositRequest',
  '2': const [
    const {'1': 'clearing_record_id', '3': 1, '4': 1, '5': 9, '10': 'clearingRecordId'},
    const {'1': 'service_name', '3': 2, '4': 1, '5': 9, '10': 'serviceName'},
  ],
};

/// Descriptor for `ClearDepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearDepositRequestDescriptor = $convert.base64Decode('ChNDbGVhckRlcG9zaXRSZXF1ZXN0EiwKEmNsZWFyaW5nX3JlY29yZF9pZBgBIAEoCVIQY2xlYXJpbmdSZWNvcmRJZBIhCgxzZXJ2aWNlX25hbWUYAiABKAlSC3NlcnZpY2VOYW1l');
@$core.Deprecated('Use clearDepositResponseDescriptor instead')
const ClearDepositResponse$json = const {
  '1': 'ClearDepositResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'new_available_balance', '3': 4, '4': 1, '5': 3, '10': 'newAvailableBalance'},
  ],
};

/// Descriptor for `ClearDepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearDepositResponseDescriptor = $convert.base64Decode('ChRDbGVhckRlcG9zaXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3NhZ2USMgoVbmV3X2F2YWlsYWJsZV9iYWxhbmNlGAQgASgDUhNuZXdBdmFpbGFibGVCYWxhbmNl');
@$core.Deprecated('Use reverseClearingDepositRequestDescriptor instead')
const ReverseClearingDepositRequest$json = const {
  '1': 'ReverseClearingDepositRequest',
  '2': const [
    const {'1': 'clearing_record_id', '3': 1, '4': 1, '5': 9, '10': 'clearingRecordId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'service_name', '3': 3, '4': 1, '5': 9, '10': 'serviceName'},
  ],
};

/// Descriptor for `ReverseClearingDepositRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reverseClearingDepositRequestDescriptor = $convert.base64Decode('Ch1SZXZlcnNlQ2xlYXJpbmdEZXBvc2l0UmVxdWVzdBIsChJjbGVhcmluZ19yZWNvcmRfaWQYASABKAlSEGNsZWFyaW5nUmVjb3JkSWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24SIQoMc2VydmljZV9uYW1lGAMgASgJUgtzZXJ2aWNlTmFtZQ==');
@$core.Deprecated('Use reverseClearingDepositResponseDescriptor instead')
const ReverseClearingDepositResponse$json = const {
  '1': 'ReverseClearingDepositResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'new_balance', '3': 4, '4': 1, '5': 3, '10': 'newBalance'},
  ],
};

/// Descriptor for `ReverseClearingDepositResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reverseClearingDepositResponseDescriptor = $convert.base64Decode('Ch5SZXZlcnNlQ2xlYXJpbmdEZXBvc2l0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcnJvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JNZXNzYWdlEh8KC25ld19iYWxhbmNlGAQgASgDUgpuZXdCYWxhbmNl');
@$core.Deprecated('Use adminSearchAccountsRequestDescriptor instead')
const AdminSearchAccountsRequest$json = const {
  '1': 'AdminSearchAccountsRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'search_type', '3': 2, '4': 1, '5': 9, '10': 'searchType'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminSearchAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSearchAccountsRequestDescriptor = $convert.base64Decode('ChpBZG1pblNlYXJjaEFjY291bnRzUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSHwoLc2VhcmNoX3R5cGUYAiABKAlSCnNlYXJjaFR5cGUSEgoEcGFnZRgDIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgEIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use adminSearchAccountsResponseDescriptor instead')
const AdminSearchAccountsResponse$json = const {
  '1': 'AdminSearchAccountsResponse',
  '2': const [
    const {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminAccountSummary', '10': 'accounts'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminSearchAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSearchAccountsResponseDescriptor = $convert.base64Decode('ChtBZG1pblNlYXJjaEFjY291bnRzUmVzcG9uc2USOQoIYWNjb3VudHMYASADKAsyHS5hY2NvdW50cy5BZG1pbkFjY291bnRTdW1tYXJ5UghhY2NvdW50cxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');
@$core.Deprecated('Use adminAccountSummaryDescriptor instead')
const AdminAccountSummary$json = const {
  '1': 'AdminAccountSummary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'balance', '3': 4, '4': 1, '5': 3, '10': 'balance'},
    const {'1': 'available_balance', '3': 5, '4': 1, '5': 3, '10': 'availableBalance'},
    const {'1': 'reserved_balance', '3': 6, '4': 1, '5': 3, '10': 'reservedBalance'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'account_type', '3': 8, '4': 1, '5': 9, '10': 'accountType'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'user_email', '3': 10, '4': 1, '5': 9, '10': 'userEmail'},
    const {'1': 'user_name', '3': 11, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'user_phone', '3': 12, '4': 1, '5': 9, '10': 'userPhone'},
  ],
};

/// Descriptor for `AdminAccountSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAccountSummaryDescriptor = $convert.base64Decode('ChNBZG1pbkFjY291bnRTdW1tYXJ5Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EhgKB2JhbGFuY2UYBCABKANSB2JhbGFuY2USKwoRYXZhaWxhYmxlX2JhbGFuY2UYBSABKANSEGF2YWlsYWJsZUJhbGFuY2USKQoQcmVzZXJ2ZWRfYmFsYW5jZRgGIAEoA1IPcmVzZXJ2ZWRCYWxhbmNlEhYKBnN0YXR1cxgHIAEoCVIGc3RhdHVzEiEKDGFjY291bnRfdHlwZRgIIAEoCVILYWNjb3VudFR5cGUSHQoKY3JlYXRlZF9hdBgJIAEoCVIJY3JlYXRlZEF0Eh0KCnVzZXJfZW1haWwYCiABKAlSCXVzZXJFbWFpbBIbCgl1c2VyX25hbWUYCyABKAlSCHVzZXJOYW1lEh0KCnVzZXJfcGhvbmUYDCABKAlSCXVzZXJQaG9uZQ==');
@$core.Deprecated('Use adminGetAccountDetailRequestDescriptor instead')
const AdminGetAccountDetailRequest$json = const {
  '1': 'AdminGetAccountDetailRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `AdminGetAccountDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetAccountDetailRequestDescriptor = $convert.base64Decode('ChxBZG1pbkdldEFjY291bnREZXRhaWxSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZA==');
@$core.Deprecated('Use adminAccountDetailResponseDescriptor instead')
const AdminAccountDetailResponse$json = const {
  '1': 'AdminAccountDetailResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.AdminAccountSummary', '10': 'account'},
    const {'1': 'pending_clearing_amount', '3': 2, '4': 1, '5': 3, '10': 'pendingClearingAmount'},
    const {'1': 'active_holds_count', '3': 3, '4': 1, '5': 5, '10': 'activeHoldsCount'},
    const {'1': 'active_holds_amount', '3': 4, '4': 1, '5': 3, '10': 'activeHoldsAmount'},
    const {'1': 'pending_clearing_count', '3': 5, '4': 1, '5': 5, '10': 'pendingClearingCount'},
    const {'1': 'kyc_tier', '3': 6, '4': 1, '5': 9, '10': 'kycTier'},
    const {'1': 'locale', '3': 7, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'virtual_accounts', '3': 8, '4': 3, '5': 11, '6': '.accounts.AdminVirtualAccount', '10': 'virtualAccounts'},
  ],
};

/// Descriptor for `AdminAccountDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAccountDetailResponseDescriptor = $convert.base64Decode('ChpBZG1pbkFjY291bnREZXRhaWxSZXNwb25zZRI3CgdhY2NvdW50GAEgASgLMh0uYWNjb3VudHMuQWRtaW5BY2NvdW50U3VtbWFyeVIHYWNjb3VudBI2ChdwZW5kaW5nX2NsZWFyaW5nX2Ftb3VudBgCIAEoA1IVcGVuZGluZ0NsZWFyaW5nQW1vdW50EiwKEmFjdGl2ZV9ob2xkc19jb3VudBgDIAEoBVIQYWN0aXZlSG9sZHNDb3VudBIuChNhY3RpdmVfaG9sZHNfYW1vdW50GAQgASgDUhFhY3RpdmVIb2xkc0Ftb3VudBI0ChZwZW5kaW5nX2NsZWFyaW5nX2NvdW50GAUgASgFUhRwZW5kaW5nQ2xlYXJpbmdDb3VudBIZCghreWNfdGllchgGIAEoCVIHa3ljVGllchIWCgZsb2NhbGUYByABKAlSBmxvY2FsZRJIChB2aXJ0dWFsX2FjY291bnRzGAggAygLMh0uYWNjb3VudHMuQWRtaW5WaXJ0dWFsQWNjb3VudFIPdmlydHVhbEFjY291bnRz');
@$core.Deprecated('Use adminVirtualAccountDescriptor instead')
const AdminVirtualAccount$json = const {
  '1': 'AdminVirtualAccount',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'bank_name', '3': 2, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'provider', '3': 5, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AdminVirtualAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminVirtualAccountDescriptor = $convert.base64Decode('ChNBZG1pblZpcnR1YWxBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIbCgliYW5rX25hbWUYAiABKAlSCGJhbmtOYW1lEiUKDmFjY291bnRfbnVtYmVyGAMgASgJUg1hY2NvdW50TnVtYmVyEiEKDGFjY291bnRfbmFtZRgEIAEoCVILYWNjb3VudE5hbWUSGgoIcHJvdmlkZXIYBSABKAlSCHByb3ZpZGVyEhYKBnN0YXR1cxgGIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use adminGetAccountTransactionsRequestDescriptor instead')
const AdminGetAccountTransactionsRequest$json = const {
  '1': 'AdminGetAccountTransactionsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'from_date', '3': 4, '4': 1, '5': 9, '10': 'fromDate'},
    const {'1': 'to_date', '3': 5, '4': 1, '5': 9, '10': 'toDate'},
    const {'1': 'page', '3': 6, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 7, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminGetAccountTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetAccountTransactionsRequestDescriptor = $convert.base64Decode('CiJBZG1pbkdldEFjY291bnRUcmFuc2FjdGlvbnNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgR0eXBlGAIgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIbCglmcm9tX2RhdGUYBCABKAlSCGZyb21EYXRlEhcKB3RvX2RhdGUYBSABKAlSBnRvRGF0ZRISCgRwYWdlGAYgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAcgASgFUgdwZXJQYWdl');
@$core.Deprecated('Use adminAccountTransactionsResponseDescriptor instead')
const AdminAccountTransactionsResponse$json = const {
  '1': 'AdminAccountTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminAccountTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAccountTransactionsResponseDescriptor = $convert.base64Decode('CiBBZG1pbkFjY291bnRUcmFuc2FjdGlvbnNSZXNwb25zZRI+Cgx0cmFuc2FjdGlvbnMYASADKAsyGi5hY2NvdW50cy5BZG1pblRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSFAoFdG90YWwYAiABKANSBXRvdGFs');
@$core.Deprecated('Use adminTransactionDescriptor instead')
const AdminTransaction$json = const {
  '1': 'AdminTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'balance_before', '3': 6, '4': 1, '5': 3, '10': 'balanceBefore'},
    const {'1': 'balance_after', '3': 7, '4': 1, '5': 3, '10': 'balanceAfter'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'service_name', '3': 10, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'metadata', '3': 12, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `AdminTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminTransactionDescriptor = $convert.base64Decode('ChBBZG1pblRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRISCgR0eXBlGAMgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIWCgZhbW91bnQYBSABKANSBmFtb3VudBIlCg5iYWxhbmNlX2JlZm9yZRgGIAEoA1INYmFsYW5jZUJlZm9yZRIjCg1iYWxhbmNlX2FmdGVyGAcgASgDUgxiYWxhbmNlQWZ0ZXISIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEhYKBnN0YXR1cxgJIAEoCVIGc3RhdHVzEiEKDHNlcnZpY2VfbmFtZRgKIAEoCVILc2VydmljZU5hbWUSHQoKY3JlYXRlZF9hdBgLIAEoCVIJY3JlYXRlZEF0EhoKCG1ldGFkYXRhGAwgASgJUghtZXRhZGF0YQ==');
@$core.Deprecated('Use adminGetAccountHoldsRequestDescriptor instead')
const AdminGetAccountHoldsRequest$json = const {
  '1': 'AdminGetAccountHoldsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminGetAccountHoldsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetAccountHoldsRequestDescriptor = $convert.base64Decode('ChtBZG1pbkdldEFjY291bnRIb2xkc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhIKBHBhZ2UYAyABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBCABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminAccountHoldsResponseDescriptor instead')
const AdminAccountHoldsResponse$json = const {
  '1': 'AdminAccountHoldsResponse',
  '2': const [
    const {'1': 'holds', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminHold', '10': 'holds'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminAccountHoldsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAccountHoldsResponseDescriptor = $convert.base64Decode('ChlBZG1pbkFjY291bnRIb2xkc1Jlc3BvbnNlEikKBWhvbGRzGAEgAygLMhMuYWNjb3VudHMuQWRtaW5Ib2xkUgVob2xkcxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');
@$core.Deprecated('Use adminHoldDescriptor instead')
const AdminHold$json = const {
  '1': 'AdminHold',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'reason', '3': 6, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'service_name', '3': 8, '4': 1, '5': 9, '10': 'serviceName'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'expires_at', '3': 10, '4': 1, '5': 9, '10': 'expiresAt'},
    const {'1': 'captured_at', '3': 11, '4': 1, '5': 9, '10': 'capturedAt'},
    const {'1': 'released_at', '3': 12, '4': 1, '5': 9, '10': 'releasedAt'},
    const {'1': 'idempotency_key', '3': 13, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `AdminHold`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminHoldDescriptor = $convert.base64Decode('CglBZG1pbkhvbGQSDgoCaWQYASABKAlSAmlkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIWCgZhbW91bnQYAyABKANSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSHAoJcmVmZXJlbmNlGAUgASgJUglyZWZlcmVuY2USFgoGcmVhc29uGAYgASgJUgZyZWFzb24SFgoGc3RhdHVzGAcgASgJUgZzdGF0dXMSIQoMc2VydmljZV9uYW1lGAggASgJUgtzZXJ2aWNlTmFtZRIdCgpjcmVhdGVkX2F0GAkgASgJUgljcmVhdGVkQXQSHQoKZXhwaXJlc19hdBgKIAEoCVIJZXhwaXJlc0F0Eh8KC2NhcHR1cmVkX2F0GAsgASgJUgpjYXB0dXJlZEF0Eh8KC3JlbGVhc2VkX2F0GAwgASgJUgpyZWxlYXNlZEF0EicKD2lkZW1wb3RlbmN5X2tleRgNIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use adminGetAccountClearingRequestDescriptor instead')
const AdminGetAccountClearingRequest$json = const {
  '1': 'AdminGetAccountClearingRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminGetAccountClearingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetAccountClearingRequestDescriptor = $convert.base64Decode('Ch5BZG1pbkdldEFjY291bnRDbGVhcmluZ1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEhIKBHBhZ2UYAyABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBCABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminAccountClearingResponseDescriptor instead')
const AdminAccountClearingResponse$json = const {
  '1': 'AdminAccountClearingResponse',
  '2': const [
    const {'1': 'records', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminClearingRecord', '10': 'records'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminAccountClearingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAccountClearingResponseDescriptor = $convert.base64Decode('ChxBZG1pbkFjY291bnRDbGVhcmluZ1Jlc3BvbnNlEjcKB3JlY29yZHMYASADKAsyHS5hY2NvdW50cy5BZG1pbkNsZWFyaW5nUmVjb3JkUgdyZWNvcmRzEhQKBXRvdGFsGAIgASgDUgV0b3RhbA==');
@$core.Deprecated('Use adminListAllHoldsRequestDescriptor instead')
const AdminListAllHoldsRequest$json = const {
  '1': 'AdminListAllHoldsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'age_hours', '3': 3, '4': 1, '5': 5, '10': 'ageHours'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 5, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminListAllHoldsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListAllHoldsRequestDescriptor = $convert.base64Decode('ChhBZG1pbkxpc3RBbGxIb2xkc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhsKCWFnZV9ob3VycxgDIAEoBVIIYWdlSG91cnMSEgoEcGFnZRgEIAEoBVIEcGFnZRIZCghwZXJfcGFnZRgFIAEoBVIHcGVyUGFnZQ==');
@$core.Deprecated('Use adminListAllHoldsResponseDescriptor instead')
const AdminListAllHoldsResponse$json = const {
  '1': 'AdminListAllHoldsResponse',
  '2': const [
    const {'1': 'holds', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminHold', '10': 'holds'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminListAllHoldsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListAllHoldsResponseDescriptor = $convert.base64Decode('ChlBZG1pbkxpc3RBbGxIb2xkc1Jlc3BvbnNlEikKBWhvbGRzGAEgAygLMhMuYWNjb3VudHMuQWRtaW5Ib2xkUgVob2xkcxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');
@$core.Deprecated('Use adminGetStaleHoldsRequestDescriptor instead')
const AdminGetStaleHoldsRequest$json = const {
  '1': 'AdminGetStaleHoldsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 2, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminGetStaleHoldsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetStaleHoldsRequestDescriptor = $convert.base64Decode('ChlBZG1pbkdldFN0YWxlSG9sZHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYAiABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminGetStaleHoldsResponseDescriptor instead')
const AdminGetStaleHoldsResponse$json = const {
  '1': 'AdminGetStaleHoldsResponse',
  '2': const [
    const {'1': 'holds', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminHold', '10': 'holds'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminGetStaleHoldsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetStaleHoldsResponseDescriptor = $convert.base64Decode('ChpBZG1pbkdldFN0YWxlSG9sZHNSZXNwb25zZRIpCgVob2xkcxgBIAMoCzITLmFjY291bnRzLkFkbWluSG9sZFIFaG9sZHMSFAoFdG90YWwYAiABKANSBXRvdGFs');
@$core.Deprecated('Use adminGetAllPlatformWalletsRequestDescriptor instead')
const AdminGetAllPlatformWalletsRequest$json = const {
  '1': 'AdminGetAllPlatformWalletsRequest',
};

/// Descriptor for `AdminGetAllPlatformWalletsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetAllPlatformWalletsRequestDescriptor = $convert.base64Decode('CiFBZG1pbkdldEFsbFBsYXRmb3JtV2FsbGV0c1JlcXVlc3Q=');
@$core.Deprecated('Use adminGetAllPlatformWalletsResponseDescriptor instead')
const AdminGetAllPlatformWalletsResponse$json = const {
  '1': 'AdminGetAllPlatformWalletsResponse',
  '2': const [
    const {'1': 'wallets', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminPlatformWallet', '10': 'wallets'},
  ],
};

/// Descriptor for `AdminGetAllPlatformWalletsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetAllPlatformWalletsResponseDescriptor = $convert.base64Decode('CiJBZG1pbkdldEFsbFBsYXRmb3JtV2FsbGV0c1Jlc3BvbnNlEjcKB3dhbGxldHMYASADKAsyHS5hY2NvdW50cy5BZG1pblBsYXRmb3JtV2FsbGV0Ugd3YWxsZXRz');
@$core.Deprecated('Use adminPlatformWalletDescriptor instead')
const AdminPlatformWallet$json = const {
  '1': 'AdminPlatformWallet',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'balance', '3': 4, '4': 1, '5': 3, '10': 'balance'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `AdminPlatformWallet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminPlatformWalletDescriptor = $convert.base64Decode('ChNBZG1pblBsYXRmb3JtV2FsbGV0Eg4KAmlkGAEgASgJUgJpZBISCgRjb2RlGAIgASgJUgRjb2RlEhIKBG5hbWUYAyABKAlSBG5hbWUSGAoHYmFsYW5jZRgEIAEoA1IHYmFsYW5jZRIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YBiABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use adminGetPlatformWalletTransactionsRequestDescriptor instead')
const AdminGetPlatformWalletTransactionsRequest$json = const {
  '1': 'AdminGetPlatformWalletTransactionsRequest',
  '2': const [
    const {'1': 'wallet_code', '3': 1, '4': 1, '5': 9, '10': 'walletCode'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminGetPlatformWalletTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetPlatformWalletTransactionsRequestDescriptor = $convert.base64Decode('CilBZG1pbkdldFBsYXRmb3JtV2FsbGV0VHJhbnNhY3Rpb25zUmVxdWVzdBIfCgt3YWxsZXRfY29kZRgBIAEoCVIKd2FsbGV0Q29kZRISCgRwYWdlGAIgASgFUgRwYWdlEhkKCHBlcl9wYWdlGAMgASgFUgdwZXJQYWdl');
@$core.Deprecated('Use adminGetPlatformWalletTransactionsResponseDescriptor instead')
const AdminGetPlatformWalletTransactionsResponse$json = const {
  '1': 'AdminGetPlatformWalletTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminGetPlatformWalletTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetPlatformWalletTransactionsResponseDescriptor = $convert.base64Decode('CipBZG1pbkdldFBsYXRmb3JtV2FsbGV0VHJhbnNhY3Rpb25zUmVzcG9uc2USPgoMdHJhbnNhY3Rpb25zGAEgAygLMhouYWNjb3VudHMuQWRtaW5UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgDUgV0b3RhbA==');
@$core.Deprecated('Use adminGetClearingRecordsRequestDescriptor instead')
const AdminGetClearingRecordsRequest$json = const {
  '1': 'AdminGetClearingRecordsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'per_page', '3': 4, '4': 1, '5': 5, '10': 'perPage'},
  ],
};

/// Descriptor for `AdminGetClearingRecordsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetClearingRecordsRequestDescriptor = $convert.base64Decode('Ch5BZG1pbkdldENsZWFyaW5nUmVjb3Jkc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhIKBHBhZ2UYAyABKAVSBHBhZ2USGQoIcGVyX3BhZ2UYBCABKAVSB3BlclBhZ2U=');
@$core.Deprecated('Use adminGetClearingRecordsResponseDescriptor instead')
const AdminGetClearingRecordsResponse$json = const {
  '1': 'AdminGetClearingRecordsResponse',
  '2': const [
    const {'1': 'records', '3': 1, '4': 3, '5': 11, '6': '.accounts.AdminClearingRecord', '10': 'records'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `AdminGetClearingRecordsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetClearingRecordsResponseDescriptor = $convert.base64Decode('Ch9BZG1pbkdldENsZWFyaW5nUmVjb3Jkc1Jlc3BvbnNlEjcKB3JlY29yZHMYASADKAsyHS5hY2NvdW50cy5BZG1pbkNsZWFyaW5nUmVjb3JkUgdyZWNvcmRzEhQKBXRvdGFsGAIgASgDUgV0b3RhbA==');
@$core.Deprecated('Use adminClearingRecordDescriptor instead')
const AdminClearingRecord$json = const {
  '1': 'AdminClearingRecord',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'clearing_tier', '3': 7, '4': 1, '5': 9, '10': 'clearingTier'},
    const {'1': 'source_reference', '3': 8, '4': 1, '5': 9, '10': 'sourceReference'},
    const {'1': 'provider', '3': 9, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_tx_id', '3': 10, '4': 1, '5': 9, '10': 'providerTxId'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'clears_at', '3': 12, '4': 1, '5': 9, '10': 'clearsAt'},
    const {'1': 'cleared_at', '3': 13, '4': 1, '5': 9, '10': 'clearedAt'},
    const {'1': 'failure_reason', '3': 14, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `AdminClearingRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminClearingRecordDescriptor = $convert.base64Decode('ChNBZG1pbkNsZWFyaW5nUmVjb3JkEg4KAmlkGAEgASgJUgJpZBIdCgphY2NvdW50X2lkGAIgASgJUglhY2NvdW50SWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhYKBmFtb3VudBgEIAEoA1IGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIjCg1jbGVhcmluZ190aWVyGAcgASgJUgxjbGVhcmluZ1RpZXISKQoQc291cmNlX3JlZmVyZW5jZRgIIAEoCVIPc291cmNlUmVmZXJlbmNlEhoKCHByb3ZpZGVyGAkgASgJUghwcm92aWRlchIkCg5wcm92aWRlcl90eF9pZBgKIAEoCVIMcHJvdmlkZXJUeElkEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIbCgljbGVhcnNfYXQYDCABKAlSCGNsZWFyc0F0Eh0KCmNsZWFyZWRfYXQYDSABKAlSCWNsZWFyZWRBdBIlCg5mYWlsdXJlX3JlYXNvbhgOIAEoCVINZmFpbHVyZVJlYXNvbg==');
@$core.Deprecated('Use adminGetClearingHealthRequestDescriptor instead')
const AdminGetClearingHealthRequest$json = const {
  '1': 'AdminGetClearingHealthRequest',
};

/// Descriptor for `AdminGetClearingHealthRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetClearingHealthRequestDescriptor = $convert.base64Decode('Ch1BZG1pbkdldENsZWFyaW5nSGVhbHRoUmVxdWVzdA==');
@$core.Deprecated('Use adminGetClearingHealthResponseDescriptor instead')
const AdminGetClearingHealthResponse$json = const {
  '1': 'AdminGetClearingHealthResponse',
  '2': const [
    const {'1': 'pending_count', '3': 1, '4': 1, '5': 5, '10': 'pendingCount'},
    const {'1': 'cleared_today', '3': 2, '4': 1, '5': 5, '10': 'clearedToday'},
    const {'1': 'reversed_today', '3': 3, '4': 1, '5': 5, '10': 'reversedToday'},
    const {'1': 'failed_today', '3': 4, '4': 1, '5': 5, '10': 'failedToday'},
    const {'1': 'stuck_count', '3': 5, '4': 1, '5': 5, '10': 'stuckCount'},
    const {'1': 'avg_clear_seconds', '3': 6, '4': 1, '5': 1, '10': 'avgClearSeconds'},
  ],
};

/// Descriptor for `AdminGetClearingHealthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetClearingHealthResponseDescriptor = $convert.base64Decode('Ch5BZG1pbkdldENsZWFyaW5nSGVhbHRoUmVzcG9uc2USIwoNcGVuZGluZ19jb3VudBgBIAEoBVIMcGVuZGluZ0NvdW50EiMKDWNsZWFyZWRfdG9kYXkYAiABKAVSDGNsZWFyZWRUb2RheRIlCg5yZXZlcnNlZF90b2RheRgDIAEoBVINcmV2ZXJzZWRUb2RheRIhCgxmYWlsZWRfdG9kYXkYBCABKAVSC2ZhaWxlZFRvZGF5Eh8KC3N0dWNrX2NvdW50GAUgASgFUgpzdHVja0NvdW50EioKEWF2Z19jbGVhcl9zZWNvbmRzGAYgASgBUg9hdmdDbGVhclNlY29uZHM=');
@$core.Deprecated('Use adminFreezeAccountRequestDescriptor instead')
const AdminFreezeAccountRequest$json = const {
  '1': 'AdminFreezeAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'admin_user_id', '3': 3, '4': 1, '5': 9, '10': 'adminUserId'},
  ],
};

/// Descriptor for `AdminFreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFreezeAccountRequestDescriptor = $convert.base64Decode('ChlBZG1pbkZyZWV6ZUFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIWCgZyZWFzb24YAiABKAlSBnJlYXNvbhIiCg1hZG1pbl91c2VyX2lkGAMgASgJUgthZG1pblVzZXJJZA==');
@$core.Deprecated('Use adminFreezeAccountResponseDescriptor instead')
const AdminFreezeAccountResponse$json = const {
  '1': 'AdminFreezeAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminFreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFreezeAccountResponseDescriptor = $convert.base64Decode('ChpBZG1pbkZyZWV6ZUFjY291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use adminUnfreezeAccountRequestDescriptor instead')
const AdminUnfreezeAccountRequest$json = const {
  '1': 'AdminUnfreezeAccountRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'admin_user_id', '3': 3, '4': 1, '5': 9, '10': 'adminUserId'},
  ],
};

/// Descriptor for `AdminUnfreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUnfreezeAccountRequestDescriptor = $convert.base64Decode('ChtBZG1pblVuZnJlZXplQWNjb3VudFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29uEiIKDWFkbWluX3VzZXJfaWQYAyABKAlSC2FkbWluVXNlcklk');
@$core.Deprecated('Use adminUnfreezeAccountResponseDescriptor instead')
const AdminUnfreezeAccountResponse$json = const {
  '1': 'AdminUnfreezeAccountResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminUnfreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUnfreezeAccountResponseDescriptor = $convert.base64Decode('ChxBZG1pblVuZnJlZXplQWNjb3VudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
