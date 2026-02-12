//
//  Generated code. Do not modify.
//  source: accounts.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use accountDescriptor instead')
const Account$json = {
  '1': 'Account',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'account_type', '3': 5, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'locale', '3': 7, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'balance', '3': 8, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'available_balance', '3': 9, '4': 1, '5': 1, '10': 'availableBalance'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {'1': 'is_primary', '3': 11, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'bank_code', '3': 12, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'branch_code', '3': 13, '4': 1, '5': 9, '10': 'branchCode'},
    {'1': 'freeze_reason_code', '3': 14, '4': 1, '5': 5, '10': 'freezeReasonCode'},
    {'1': 'freeze_reason', '3': 15, '4': 1, '5': 9, '10': 'freezeReason'},
    {'1': 'frozen_at', '3': 16, '4': 1, '5': 9, '10': 'frozenAt'},
    {'1': 'frozen_by', '3': 17, '4': 1, '5': 9, '10': 'frozenBy'},
    {'1': 'daily_limit', '3': 18, '4': 1, '5': 1, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 19, '4': 1, '5': 1, '10': 'monthlyLimit'},
    {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'is_virtual', '3': 22, '4': 1, '5': 8, '10': 'isVirtual'},
    {'1': 'provider', '3': 23, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_ref', '3': 24, '4': 1, '5': 9, '10': 'providerRef'},
    {'1': 'bank_name', '3': 25, '4': 1, '5': 9, '10': 'bankName'},
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode(
    'CgdBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYW'
    'Njb3VudF9udW1iZXIYAyABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAQgASgJ'
    'UgthY2NvdW50TmFtZRIhCgxhY2NvdW50X3R5cGUYBSABKAlSC2FjY291bnRUeXBlEhoKCGN1cn'
    'JlbmN5GAYgASgJUghjdXJyZW5jeRIWCgZsb2NhbGUYByABKAlSBmxvY2FsZRIYCgdiYWxhbmNl'
    'GAggASgBUgdiYWxhbmNlEisKEWF2YWlsYWJsZV9iYWxhbmNlGAkgASgBUhBhdmFpbGFibGVCYW'
    'xhbmNlEhYKBnN0YXR1cxgKIAEoCVIGc3RhdHVzEh0KCmlzX3ByaW1hcnkYCyABKAhSCWlzUHJp'
    'bWFyeRIbCgliYW5rX2NvZGUYDCABKAlSCGJhbmtDb2RlEh8KC2JyYW5jaF9jb2RlGA0gASgJUg'
    'picmFuY2hDb2RlEiwKEmZyZWV6ZV9yZWFzb25fY29kZRgOIAEoBVIQZnJlZXplUmVhc29uQ29k'
    'ZRIjCg1mcmVlemVfcmVhc29uGA8gASgJUgxmcmVlemVSZWFzb24SGwoJZnJvemVuX2F0GBAgAS'
    'gJUghmcm96ZW5BdBIbCglmcm96ZW5fYnkYESABKAlSCGZyb3plbkJ5Eh8KC2RhaWx5X2xpbWl0'
    'GBIgASgBUgpkYWlseUxpbWl0EiMKDW1vbnRobHlfbGltaXQYEyABKAFSDG1vbnRobHlMaW1pdB'
    'IdCgpjcmVhdGVkX2F0GBQgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgVIAEoCVIJdXBk'
    'YXRlZEF0Eh0KCmlzX3ZpcnR1YWwYFiABKAhSCWlzVmlydHVhbBIaCghwcm92aWRlchgXIAEoCV'
    'IIcHJvdmlkZXISIQoMcHJvdmlkZXJfcmVmGBggASgJUgtwcm92aWRlclJlZhIbCgliYW5rX25h'
    'bWUYGSABKAlSCGJhbmtOYW1l');

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
    {'1': 'uuid', '3': 7, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'account_number', '3': 8, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `AccountSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSummaryDescriptor = $convert.base64Decode(
    'Cg5BY2NvdW50U3VtbWFyeRIOCgJpZBgBIAEoBFICaWQSIQoMYWNjb3VudF90eXBlGAIgASgJUg'
    'thY2NvdW50VHlwZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSGAoHYmFsYW5jZRgEIAEo'
    'BFIHYmFsYW5jZRIyChVtYXNrZWRfYWNjb3VudF9udW1iZXIYBSABKAlSE21hc2tlZEFjY291bn'
    'ROdW1iZXISFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSEgoEdXVpZBgHIAEoCVIEdXVpZBIlCg5h'
    'Y2NvdW50X251bWJlchgIIAEoCVINYWNjb3VudE51bWJlcg==');

@$core.Deprecated('Use getUserAccountsRequestDescriptor instead')
const GetUserAccountsRequest$json = {
  '1': 'GetUserAccountsRequest',
  '2': [
    {'1': 'target_user_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'targetUserId', '17': true},
  ],
  '8': [
    {'1': '_target_user_id'},
  ],
};

/// Descriptor for `GetUserAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyQWNjb3VudHNSZXF1ZXN0EikKDnRhcmdldF91c2VyX2lkGAEgASgJSABSDHRhcm'
    'dldFVzZXJJZIgBAUIRCg9fdGFyZ2V0X3VzZXJfaWQ=');

@$core.Deprecated('Use getUserAccountsResponseDescriptor instead')
const GetUserAccountsResponse$json = {
  '1': 'GetUserAccountsResponse',
  '2': [
    {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.accounts.AccountSummary', '10': 'accounts'},
  ],
};

/// Descriptor for `GetUserAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyQWNjb3VudHNSZXNwb25zZRI0CghhY2NvdW50cxgBIAMoCzIYLmFjY291bnRzLk'
    'FjY291bnRTdW1tYXJ5UghhY2NvdW50cw==');

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = {
  '1': 'Transaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'balance_before', '3': 7, '4': 1, '5': 1, '10': 'balanceBefore'},
    {'1': 'balance_after', '3': 8, '4': 1, '5': 1, '10': 'balanceAfter'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 10, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'locale', '3': 12, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'service_name', '3': 13, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'counterparty_name', '3': 15, '4': 1, '5': 9, '10': 'counterpartyName'},
    {'1': 'counterparty_account', '3': 16, '4': 1, '5': 9, '10': 'counterpartyAccount'},
    {'1': 'updated_at', '3': 17, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3'
    'VudElkEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhIKBHR5cGUYBCABKAlSBHR5cGUS'
    'GgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EiUKDm'
    'JhbGFuY2VfYmVmb3JlGAcgASgBUg1iYWxhbmNlQmVmb3JlEiMKDWJhbGFuY2VfYWZ0ZXIYCCAB'
    'KAFSDGJhbGFuY2VBZnRlchIgCgtkZXNjcmlwdGlvbhgJIAEoCVILZGVzY3JpcHRpb24SGgoIbW'
    'V0YWRhdGEYCiABKAlSCG1ldGFkYXRhEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEhYKBmxvY2Fs'
    'ZRgMIAEoCVIGbG9jYWxlEiEKDHNlcnZpY2VfbmFtZRgNIAEoCVILc2VydmljZU5hbWUSHQoKY3'
    'JlYXRlZF9hdBgOIAEoCVIJY3JlYXRlZEF0EisKEWNvdW50ZXJwYXJ0eV9uYW1lGA8gASgJUhBj'
    'b3VudGVycGFydHlOYW1lEjEKFGNvdW50ZXJwYXJ0eV9hY2NvdW50GBAgASgJUhNjb3VudGVycG'
    'FydHlBY2NvdW50Eh0KCnVwZGF0ZWRfYXQYESABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use createAccountRequestDescriptor instead')
const CreateAccountRequest$json = {
  '1': 'CreateAccountRequest',
  '2': [
    {'1': 'account_name', '3': 1, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'locale', '3': 4, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'is_primary', '3': 5, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'daily_limit', '3': 6, '4': 1, '5': 1, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 7, '4': 1, '5': 1, '10': 'monthlyLimit'},
  ],
};

/// Descriptor for `CreateAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVBY2NvdW50UmVxdWVzdBIhCgxhY2NvdW50X25hbWUYASABKAlSC2FjY291bnROYW'
    '1lEiEKDGFjY291bnRfdHlwZRgCIAEoCVILYWNjb3VudFR5cGUSGgoIY3VycmVuY3kYAyABKAlS'
    'CGN1cnJlbmN5EhYKBmxvY2FsZRgEIAEoCVIGbG9jYWxlEh0KCmlzX3ByaW1hcnkYBSABKAhSCW'
    'lzUHJpbWFyeRIfCgtkYWlseV9saW1pdBgGIAEoAVIKZGFpbHlMaW1pdBIjCg1tb250aGx5X2xp'
    'bWl0GAcgASgBUgxtb250aGx5TGltaXQ=');

@$core.Deprecated('Use createAccountResponseDescriptor instead')
const CreateAccountResponse$json = {
  '1': 'CreateAccountResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAccountResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY2'
    '91bnRSB2FjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getAccountsRequestDescriptor instead')
const GetAccountsRequest$json = {
  '1': 'GetAccountsRequest',
  '2': [
    {'1': 'account_type', '3': 1, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAccountsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsRequestDescriptor = $convert.base64Decode(
    'ChJHZXRBY2NvdW50c1JlcXVlc3QSIQoMYWNjb3VudF90eXBlGAEgASgJUgthY2NvdW50VHlwZR'
    'IWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zmc2V0'
    'GAQgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getAccountsResponseDescriptor instead')
const GetAccountsResponse$json = {
  '1': 'GetAccountsResponse',
  '2': [
    {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.accounts.Account', '10': 'accounts'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAccountsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsResponseDescriptor = $convert.base64Decode(
    'ChNHZXRBY2NvdW50c1Jlc3BvbnNlEi0KCGFjY291bnRzGAEgAygLMhEuYWNjb3VudHMuQWNjb3'
    'VudFIIYWNjb3VudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use getAccountRequestDescriptor instead')
const GetAccountRequest$json = {
  '1': 'GetAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountRequestDescriptor = $convert.base64Decode(
    'ChFHZXRBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');

@$core.Deprecated('Use getAccountResponseDescriptor instead')
const GetAccountResponse$json = {
  '1': 'GetAccountResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
  ],
};

/// Descriptor for `GetAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountResponseDescriptor = $convert.base64Decode(
    'ChJHZXRBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY291bn'
    'RSB2FjY291bnQ=');

@$core.Deprecated('Use getAccountByNumberRequestDescriptor instead')
const GetAccountByNumberRequest$json = {
  '1': 'GetAccountByNumberRequest',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `GetAccountByNumberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountByNumberRequestDescriptor = $convert.base64Decode(
    'ChlHZXRBY2NvdW50QnlOdW1iZXJSZXF1ZXN0EiUKDmFjY291bnRfbnVtYmVyGAEgASgJUg1hY2'
    'NvdW50TnVtYmVy');

@$core.Deprecated('Use getAccountByNumberResponseDescriptor instead')
const GetAccountByNumberResponse$json = {
  '1': 'GetAccountByNumberResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
  ],
};

/// Descriptor for `GetAccountByNumberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountByNumberResponseDescriptor = $convert.base64Decode(
    'ChpHZXRBY2NvdW50QnlOdW1iZXJSZXNwb25zZRIrCgdhY2NvdW50GAEgASgLMhEuYWNjb3VudH'
    'MuQWNjb3VudFIHYWNjb3VudA==');

@$core.Deprecated('Use updateAccountRequestDescriptor instead')
const UpdateAccountRequest$json = {
  '1': 'UpdateAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'account_name', '3': 2, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'daily_limit', '3': 3, '4': 1, '5': 1, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 4, '4': 1, '5': 1, '10': 'monthlyLimit'},
    {'1': 'is_primary', '3': 5, '4': 1, '5': 8, '10': 'isPrimary'},
  ],
};

/// Descriptor for `UpdateAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSIQ'
    'oMYWNjb3VudF9uYW1lGAIgASgJUgthY2NvdW50TmFtZRIfCgtkYWlseV9saW1pdBgDIAEoAVIK'
    'ZGFpbHlMaW1pdBIjCg1tb250aGx5X2xpbWl0GAQgASgBUgxtb250aGx5TGltaXQSHQoKaXNfcH'
    'JpbWFyeRgFIAEoCFIJaXNQcmltYXJ5');

@$core.Deprecated('Use updateAccountResponseDescriptor instead')
const UpdateAccountResponse$json = {
  '1': 'UpdateAccountResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY2'
    '91bnRSB2FjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteAccountRequestDescriptor instead')
const DeleteAccountRequest$json = {
  '1': 'DeleteAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `DeleteAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAccountRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');

@$core.Deprecated('Use deleteAccountResponseDescriptor instead')
const DeleteAccountResponse$json = {
  '1': 'DeleteAccountResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAccountResponseDescriptor = $convert.base64Decode(
    'ChVEZWxldGVBY2NvdW50UmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZRIYCgdzdW'
    'NjZXNzGAIgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use getBalanceRequestDescriptor instead')
const GetBalanceRequest$json = {
  '1': 'GetBalanceRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `GetBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBalanceRequestDescriptor = $convert.base64Decode(
    'ChFHZXRCYWxhbmNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQ=');

@$core.Deprecated('Use getBalanceResponseDescriptor instead')
const GetBalanceResponse$json = {
  '1': 'GetBalanceResponse',
  '2': [
    {'1': 'balance', '3': 1, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'available_balance', '3': 2, '4': 1, '5': 1, '10': 'availableBalance'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'last_updated', '3': 4, '4': 1, '5': 9, '10': 'lastUpdated'},
  ],
};

/// Descriptor for `GetBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBalanceResponseDescriptor = $convert.base64Decode(
    'ChJHZXRCYWxhbmNlUmVzcG9uc2USGAoHYmFsYW5jZRgBIAEoAVIHYmFsYW5jZRIrChFhdmFpbG'
    'FibGVfYmFsYW5jZRgCIAEoAVIQYXZhaWxhYmxlQmFsYW5jZRIaCghjdXJyZW5jeRgDIAEoCVII'
    'Y3VycmVuY3kSIQoMbGFzdF91cGRhdGVkGAQgASgJUgtsYXN0VXBkYXRlZA==');

@$core.Deprecated('Use updateBalanceRequestDescriptor instead')
const UpdateBalanceRequest$json = {
  '1': 'UpdateBalanceRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'operation', '3': 3, '4': 1, '5': 9, '10': 'operation'},
    {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `UpdateBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBalanceRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVCYWxhbmNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFg'
    'oGYW1vdW50GAIgASgBUgZhbW91bnQSHAoJb3BlcmF0aW9uGAMgASgJUglvcGVyYXRpb24SHAoJ'
    'cmVmZXJlbmNlGAQgASgJUglyZWZlcmVuY2USIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaX'
    'B0aW9uEhoKCGNhdGVnb3J5GAYgASgJUghjYXRlZ29yeQ==');

@$core.Deprecated('Use updateBalanceResponseDescriptor instead')
const UpdateBalanceResponse$json = {
  '1': 'UpdateBalanceResponse',
  '2': [
    {'1': 'new_balance', '3': 1, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'available_balance', '3': 2, '4': 1, '5': 1, '10': 'availableBalance'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
  ],
};

/// Descriptor for `UpdateBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBalanceResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVCYWxhbmNlUmVzcG9uc2USHwoLbmV3X2JhbGFuY2UYASABKAFSCm5ld0JhbGFuY2'
    'USKwoRYXZhaWxhYmxlX2JhbGFuY2UYAiABKAFSEGF2YWlsYWJsZUJhbGFuY2USNwoLdHJhbnNh'
    'Y3Rpb24YAyABKAsyFS5hY2NvdW50cy5UcmFuc2FjdGlvblILdHJhbnNhY3Rpb24=');

@$core.Deprecated('Use getTransactionsRequestDescriptor instead')
const GetTransactionsRequest$json = {
  '1': 'GetTransactionsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'start_date', '3': 5, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 6, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 7, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 8, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRUcmFuc2FjdGlvbnNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZB'
    'ISCgR0eXBlGAIgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIWCgZzdGF0'
    'dXMYBCABKAlSBnN0YXR1cxIdCgpzdGFydF9kYXRlGAUgASgJUglzdGFydERhdGUSGQoIZW5kX2'
    'RhdGUYBiABKAlSB2VuZERhdGUSFAoFbGltaXQYByABKAVSBWxpbWl0EhYKBm9mZnNldBgIIAEo'
    'BVIGb2Zmc2V0');

@$core.Deprecated('Use getTransactionsResponseDescriptor instead')
const GetTransactionsResponse$json = {
  '1': 'GetTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.Transaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_credits', '3': 3, '4': 1, '5': 1, '10': 'totalCredits'},
    {'1': 'total_debits', '3': 4, '4': 1, '5': 1, '10': 'totalDebits'},
  ],
};

/// Descriptor for `GetTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRUcmFuc2FjdGlvbnNSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS5hY2NvdW'
    '50cy5UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbBIjCg10'
    'b3RhbF9jcmVkaXRzGAMgASgBUgx0b3RhbENyZWRpdHMSIQoMdG90YWxfZGViaXRzGAQgASgBUg'
    't0b3RhbERlYml0cw==');

@$core.Deprecated('Use freezeAccountRequestDescriptor instead')
const FreezeAccountRequest$json = {
  '1': 'FreezeAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'reason_code', '3': 3, '4': 1, '5': 5, '10': 'reasonCode'},
    {'1': 'frozen_by', '3': 4, '4': 1, '5': 9, '10': 'frozenBy'},
  ],
};

/// Descriptor for `FreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeAccountRequestDescriptor = $convert.base64Decode(
    'ChRGcmVlemVBY2NvdW50UmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFg'
    'oGcmVhc29uGAIgASgJUgZyZWFzb24SHwoLcmVhc29uX2NvZGUYAyABKAVSCnJlYXNvbkNvZGUS'
    'GwoJZnJvemVuX2J5GAQgASgJUghmcm96ZW5CeQ==');

@$core.Deprecated('Use freezeAccountResponseDescriptor instead')
const FreezeAccountResponse$json = {
  '1': 'FreezeAccountResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `FreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freezeAccountResponseDescriptor = $convert.base64Decode(
    'ChVGcmVlemVBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bnRzLkFjY2'
    '91bnRSB2FjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use unfreezeAccountRequestDescriptor instead')
const UnfreezeAccountRequest$json = {
  '1': 'UnfreezeAccountRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'unfrozen_by', '3': 2, '4': 1, '5': 9, '10': 'unfrozenBy'},
  ],
};

/// Descriptor for `UnfreezeAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeAccountRequestDescriptor = $convert.base64Decode(
    'ChZVbmZyZWV6ZUFjY291bnRSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZB'
    'IfCgt1bmZyb3plbl9ieRgCIAEoCVIKdW5mcm96ZW5CeQ==');

@$core.Deprecated('Use unfreezeAccountResponseDescriptor instead')
const UnfreezeAccountResponse$json = {
  '1': 'UnfreezeAccountResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnfreezeAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfreezeAccountResponseDescriptor = $convert.base64Decode(
    'ChdVbmZyZWV6ZUFjY291bnRSZXNwb25zZRIrCgdhY2NvdW50GAEgASgLMhEuYWNjb3VudHMuQW'
    'Njb3VudFIHYWNjb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use autoSaveDescriptor instead')
const AutoSave$json = {
  '1': 'AutoSave',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 6, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'trigger', '3': 7, '4': 1, '5': 9, '10': 'trigger'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'target_account_id', '3': 9, '4': 1, '5': 9, '10': 'targetAccountId'},
    {'1': 'target_amount', '3': 10, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 12, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AutoSave`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoSaveDescriptor = $convert.base64Decode(
    'CghBdXRvU2F2ZRIOCgJpZBgBIAEoCVICaWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudE'
    'lkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBISCgRuYW1lGAQgASgJUgRuYW1lEhYKBmFtb3Vu'
    'dBgFIAEoAVIGYW1vdW50EhwKCWZyZXF1ZW5jeRgGIAEoCVIJZnJlcXVlbmN5EhgKB3RyaWdnZX'
    'IYByABKAlSB3RyaWdnZXISFgoGc3RhdHVzGAggASgJUgZzdGF0dXMSKgoRdGFyZ2V0X2FjY291'
    'bnRfaWQYCSABKAlSD3RhcmdldEFjY291bnRJZBIjCg10YXJnZXRfYW1vdW50GAogASgBUgx0YX'
    'JnZXRBbW91bnQSHQoKY3JlYXRlZF9hdBgLIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQY'
    'DCABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use createAutoSaveRequestDescriptor instead')
const CreateAutoSaveRequest$json = {
  '1': 'CreateAutoSaveRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'trigger', '3': 5, '4': 1, '5': 9, '10': 'trigger'},
    {'1': 'target_account_id', '3': 6, '4': 1, '5': 9, '10': 'targetAccountId'},
    {'1': 'target_amount', '3': 7, '4': 1, '5': 1, '10': 'targetAmount'},
  ],
};

/// Descriptor for `CreateAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveRequestDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVBdXRvU2F2ZVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEh'
    'IKBG5hbWUYAiABKAlSBG5hbWUSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSHAoJZnJlcXVlbmN5'
    'GAQgASgJUglmcmVxdWVuY3kSGAoHdHJpZ2dlchgFIAEoCVIHdHJpZ2dlchIqChF0YXJnZXRfYW'
    'Njb3VudF9pZBgGIAEoCVIPdGFyZ2V0QWNjb3VudElkEiMKDXRhcmdldF9hbW91bnQYByABKAFS'
    'DHRhcmdldEFtb3VudA==');

@$core.Deprecated('Use createAutoSaveResponseDescriptor instead')
const CreateAutoSaveResponse$json = {
  '1': 'CreateAutoSaveResponse',
  '2': [
    {'1': 'autosave', '3': 1, '4': 1, '5': 11, '6': '.accounts.AutoSave', '10': 'autosave'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoSaveResponseDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVBdXRvU2F2ZVJlc3BvbnNlEi4KCGF1dG9zYXZlGAEgASgLMhIuYWNjb3VudHMuQX'
    'V0b1NhdmVSCGF1dG9zYXZlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getAutoSavesRequestDescriptor instead')
const GetAutoSavesRequest$json = {
  '1': 'GetAutoSavesRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetAutoSavesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSavesRequestDescriptor = $convert.base64Decode(
    'ChNHZXRBdXRvU2F2ZXNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIWCg'
    'ZzdGF0dXMYAiABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use getAutoSavesResponseDescriptor instead')
const GetAutoSavesResponse$json = {
  '1': 'GetAutoSavesResponse',
  '2': [
    {'1': 'autosaves', '3': 1, '4': 3, '5': 11, '6': '.accounts.AutoSave', '10': 'autosaves'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAutoSavesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoSavesResponseDescriptor = $convert.base64Decode(
    'ChRHZXRBdXRvU2F2ZXNSZXNwb25zZRIwCglhdXRvc2F2ZXMYASADKAsyEi5hY2NvdW50cy5BdX'
    'RvU2F2ZVIJYXV0b3NhdmVzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use updateAutoSaveRequestDescriptor instead')
const UpdateAutoSaveRequest$json = {
  '1': 'UpdateAutoSaveRequest',
  '2': [
    {'1': 'autosave_id', '3': 1, '4': 1, '5': 9, '10': 'autosaveId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'target_amount', '3': 5, '4': 1, '5': 1, '10': 'targetAmount'},
  ],
};

/// Descriptor for `UpdateAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVBdXRvU2F2ZVJlcXVlc3QSHwoLYXV0b3NhdmVfaWQYASABKAlSCmF1dG9zYXZlSW'
    'QSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSHAoJZnJlcXVlbmN5GAMgASgJUglmcmVxdWVuY3kS'
    'FgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSIwoNdGFyZ2V0X2Ftb3VudBgFIAEoAVIMdGFyZ2V0QW'
    '1vdW50');

@$core.Deprecated('Use updateAutoSaveResponseDescriptor instead')
const UpdateAutoSaveResponse$json = {
  '1': 'UpdateAutoSaveResponse',
  '2': [
    {'1': 'autosave', '3': 1, '4': 1, '5': 11, '6': '.accounts.AutoSave', '10': 'autosave'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoSaveResponseDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVBdXRvU2F2ZVJlc3BvbnNlEi4KCGF1dG9zYXZlGAEgASgLMhIuYWNjb3VudHMuQX'
    'V0b1NhdmVSCGF1dG9zYXZlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use deleteAutoSaveRequestDescriptor instead')
const DeleteAutoSaveRequest$json = {
  '1': 'DeleteAutoSaveRequest',
  '2': [
    {'1': 'autosave_id', '3': 1, '4': 1, '5': 9, '10': 'autosaveId'},
  ],
};

/// Descriptor for `DeleteAutoSaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVBdXRvU2F2ZVJlcXVlc3QSHwoLYXV0b3NhdmVfaWQYASABKAlSCmF1dG9zYXZlSW'
    'Q=');

@$core.Deprecated('Use deleteAutoSaveResponseDescriptor instead')
const DeleteAutoSaveResponse$json = {
  '1': 'DeleteAutoSaveResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAutoSaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoSaveResponseDescriptor = $convert.base64Decode(
    'ChZEZWxldGVBdXRvU2F2ZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use lockFundsDescriptor instead')
const LockFunds$json = {
  '1': 'LockFunds',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'lock_type', '3': 6, '4': 1, '5': 9, '10': 'lockType'},
    {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    {'1': 'unlock_date', '3': 8, '4': 1, '5': 9, '10': 'unlockDate'},
    {'1': 'target_amount', '3': 9, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'penalty_rate', '3': 10, '4': 1, '5': 1, '10': 'penaltyRate'},
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'matured_at', '3': 12, '4': 1, '5': 9, '10': 'maturedAt'},
  ],
};

/// Descriptor for `LockFunds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockFundsDescriptor = $convert.base64Decode(
    'CglMb2NrRnVuZHMSDgoCaWQYASABKAlSAmlkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bn'
    'RJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSEgoEbmFtZRgEIAEoCVIEbmFtZRIWCgZhbW91'
    'bnQYBSABKAFSBmFtb3VudBIbCglsb2NrX3R5cGUYBiABKAlSCGxvY2tUeXBlEhYKBnN0YXR1cx'
    'gHIAEoCVIGc3RhdHVzEh8KC3VubG9ja19kYXRlGAggASgJUgp1bmxvY2tEYXRlEiMKDXRhcmdl'
    'dF9hbW91bnQYCSABKAFSDHRhcmdldEFtb3VudBIhCgxwZW5hbHR5X3JhdGUYCiABKAFSC3Blbm'
    'FsdHlSYXRlEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIdCgptYXR1cmVkX2F0GAwg'
    'ASgJUgltYXR1cmVkQXQ=');

@$core.Deprecated('Use createLockFundsRequestDescriptor instead')
const CreateLockFundsRequest$json = {
  '1': 'CreateLockFundsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'lock_type', '3': 4, '4': 1, '5': 9, '10': 'lockType'},
    {'1': 'unlock_date', '3': 5, '4': 1, '5': 9, '10': 'unlockDate'},
    {'1': 'target_amount', '3': 6, '4': 1, '5': 1, '10': 'targetAmount'},
    {'1': 'penalty_rate', '3': 7, '4': 1, '5': 1, '10': 'penaltyRate'},
    {'1': 'pin', '3': 8, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `CreateLockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundsRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVMb2NrRnVuZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZB'
    'ISCgRuYW1lGAIgASgJUgRuYW1lEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhsKCWxvY2tfdHlw'
    'ZRgEIAEoCVIIbG9ja1R5cGUSHwoLdW5sb2NrX2RhdGUYBSABKAlSCnVubG9ja0RhdGUSIwoNdG'
    'FyZ2V0X2Ftb3VudBgGIAEoAVIMdGFyZ2V0QW1vdW50EiEKDHBlbmFsdHlfcmF0ZRgHIAEoAVIL'
    'cGVuYWx0eVJhdGUSEAoDcGluGAggASgJUgNwaW4=');

@$core.Deprecated('Use createLockFundsResponseDescriptor instead')
const CreateLockFundsResponse$json = {
  '1': 'CreateLockFundsResponse',
  '2': [
    {'1': 'lockfunds', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFunds', '10': 'lockfunds'},
    {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
    {'1': 'new_available_balance', '3': 3, '4': 1, '5': 1, '10': 'newAvailableBalance'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateLockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundsResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVMb2NrRnVuZHNSZXNwb25zZRIxCglsb2NrZnVuZHMYASABKAsyEy5hY2NvdW50cy'
    '5Mb2NrRnVuZHNSCWxvY2tmdW5kcxI3Cgt0cmFuc2FjdGlvbhgCIAEoCzIVLmFjY291bnRzLlRy'
    'YW5zYWN0aW9uUgt0cmFuc2FjdGlvbhIyChVuZXdfYXZhaWxhYmxlX2JhbGFuY2UYAyABKAFSE2'
    '5ld0F2YWlsYWJsZUJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getLockFundsRequestDescriptor instead')
const GetLockFundsRequest$json = {
  '1': 'GetLockFundsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetLockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundsRequestDescriptor = $convert.base64Decode(
    'ChNHZXRMb2NrRnVuZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIWCg'
    'ZzdGF0dXMYAiABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use getLockFundsResponseDescriptor instead')
const GetLockFundsResponse$json = {
  '1': 'GetLockFundsResponse',
  '2': [
    {'1': 'lockfunds', '3': 1, '4': 3, '5': 11, '6': '.accounts.LockFunds', '10': 'lockfunds'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_locked_amount', '3': 3, '4': 1, '5': 1, '10': 'totalLockedAmount'},
  ],
};

/// Descriptor for `GetLockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLockFundsResponseDescriptor = $convert.base64Decode(
    'ChRHZXRMb2NrRnVuZHNSZXNwb25zZRIxCglsb2NrZnVuZHMYASADKAsyEy5hY2NvdW50cy5Mb2'
    'NrRnVuZHNSCWxvY2tmdW5kcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSLgoTdG90YWxfbG9ja2Vk'
    'X2Ftb3VudBgDIAEoAVIRdG90YWxMb2NrZWRBbW91bnQ=');

@$core.Deprecated('Use unlockFundsRequestDescriptor instead')
const UnlockFundsRequest$json = {
  '1': 'UnlockFundsRequest',
  '2': [
    {'1': 'lockfunds_id', '3': 1, '4': 1, '5': 9, '10': 'lockfundsId'},
    {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'force_unlock', '3': 3, '4': 1, '5': 8, '10': 'forceUnlock'},
  ],
};

/// Descriptor for `UnlockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockFundsRequestDescriptor = $convert.base64Decode(
    'ChJVbmxvY2tGdW5kc1JlcXVlc3QSIQoMbG9ja2Z1bmRzX2lkGAEgASgJUgtsb2NrZnVuZHNJZB'
    'IQCgNwaW4YAiABKAlSA3BpbhIhCgxmb3JjZV91bmxvY2sYAyABKAhSC2ZvcmNlVW5sb2Nr');

@$core.Deprecated('Use unlockFundsResponseDescriptor instead')
const UnlockFundsResponse$json = {
  '1': 'UnlockFundsResponse',
  '2': [
    {'1': 'lockfunds', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFunds', '10': 'lockfunds'},
    {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
    {'1': 'penalty_amount', '3': 3, '4': 1, '5': 1, '10': 'penaltyAmount'},
    {'1': 'released_amount', '3': 4, '4': 1, '5': 1, '10': 'releasedAmount'},
    {'1': 'new_available_balance', '3': 5, '4': 1, '5': 1, '10': 'newAvailableBalance'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnlockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockFundsResponseDescriptor = $convert.base64Decode(
    'ChNVbmxvY2tGdW5kc1Jlc3BvbnNlEjEKCWxvY2tmdW5kcxgBIAEoCzITLmFjY291bnRzLkxvY2'
    'tGdW5kc1IJbG9ja2Z1bmRzEjcKC3RyYW5zYWN0aW9uGAIgASgLMhUuYWNjb3VudHMuVHJhbnNh'
    'Y3Rpb25SC3RyYW5zYWN0aW9uEiUKDnBlbmFsdHlfYW1vdW50GAMgASgBUg1wZW5hbHR5QW1vdW'
    '50EicKD3JlbGVhc2VkX2Ftb3VudBgEIAEoAVIOcmVsZWFzZWRBbW91bnQSMgoVbmV3X2F2YWls'
    'YWJsZV9iYWxhbmNlGAUgASgBUhNuZXdBdmFpbGFibGVCYWxhbmNlEhgKB21lc3NhZ2UYBiABKA'
    'lSB21lc3NhZ2U=');

@$core.Deprecated('Use createTransactionRequestDescriptor instead')
const CreateTransactionRequest$json = {
  '1': 'CreateTransactionRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 6, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'service_name', '3': 7, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'counterparty_name', '3': 10, '4': 1, '5': 9, '10': 'counterpartyName'},
    {'1': 'counterparty_account', '3': 11, '4': 1, '5': 9, '10': 'counterpartyAccount'},
  ],
};

/// Descriptor for `CreateTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionRequestDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVUcmFuc2FjdGlvblJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudE'
    'lkEhIKBHR5cGUYAiABKAlSBHR5cGUSGgoIY2F0ZWdvcnkYAyABKAlSCGNhdGVnb3J5EhYKBmFt'
    'b3VudBgEIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIaCg'
    'htZXRhZGF0YRgGIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAcgASgJUgtzZXJ2aWNl'
    'TmFtZRIcCglyZWZlcmVuY2UYCCABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYCSABKAlSBnN0YX'
    'R1cxIrChFjb3VudGVycGFydHlfbmFtZRgKIAEoCVIQY291bnRlcnBhcnR5TmFtZRIxChRjb3Vu'
    'dGVycGFydHlfYWNjb3VudBgLIAEoCVITY291bnRlcnBhcnR5QWNjb3VudA==');

@$core.Deprecated('Use createTransactionResponseDescriptor instead')
const CreateTransactionResponse$json = {
  '1': 'CreateTransactionResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionResponseDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVUcmFuc2FjdGlvblJlc3BvbnNlEjcKC3RyYW5zYWN0aW9uGAEgASgLMhUuYWNjb3'
    'VudHMuVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use updateTransactionStatusRequestDescriptor instead')
const UpdateTransactionStatusRequest$json = {
  '1': 'UpdateTransactionStatusRequest',
  '2': [
    {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'failure_reason', '3': 3, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `UpdateTransactionStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTransactionStatusRequestDescriptor = $convert.base64Decode(
    'Ch5VcGRhdGVUcmFuc2FjdGlvblN0YXR1c1JlcXVlc3QSHAoJcmVmZXJlbmNlGAEgASgJUglyZW'
    'ZlcmVuY2USFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSJQoOZmFpbHVyZV9yZWFzb24YAyABKAlS'
    'DWZhaWx1cmVSZWFzb24=');

@$core.Deprecated('Use updateTransactionStatusResponseDescriptor instead')
const UpdateTransactionStatusResponse$json = {
  '1': 'UpdateTransactionStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateTransactionStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTransactionStatusResponseDescriptor = $convert.base64Decode(
    'Ch9VcGRhdGVUcmFuc2FjdGlvblN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getTransactionHistoryRequestDescriptor instead')
const GetTransactionHistoryRequest$json = {
  '1': 'GetTransactionHistoryRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'service_name', '3': 5, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'start_date', '3': 6, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 7, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 8, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 9, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetTransactionHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionHistoryRequestDescriptor = $convert.base64Decode(
    'ChxHZXRUcmFuc2FjdGlvbkhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY2'
    '91bnRJZBISCgR0eXBlGAIgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIW'
    'CgZzdGF0dXMYBCABKAlSBnN0YXR1cxIhCgxzZXJ2aWNlX25hbWUYBSABKAlSC3NlcnZpY2VOYW'
    '1lEh0KCnN0YXJ0X2RhdGUYBiABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgHIAEoCVIHZW5k'
    'RGF0ZRIUCgVsaW1pdBgIIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAkgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getTransactionHistoryResponseDescriptor instead')
const GetTransactionHistoryResponse$json = {
  '1': 'GetTransactionHistoryResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.Transaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_credits', '3': 3, '4': 1, '5': 1, '10': 'totalCredits'},
    {'1': 'total_debits', '3': 4, '4': 1, '5': 1, '10': 'totalDebits'},
  ],
};

/// Descriptor for `GetTransactionHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionHistoryResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRUcmFuc2FjdGlvbkhpc3RvcnlSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS'
    '5hY2NvdW50cy5UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3Rh'
    'bBIjCg10b3RhbF9jcmVkaXRzGAMgASgBUgx0b3RhbENyZWRpdHMSIQoMdG90YWxfZGViaXRzGA'
    'QgASgBUgt0b3RhbERlYml0cw==');

@$core.Deprecated('Use getTransactionStatisticsRequestDescriptor instead')
const GetTransactionStatisticsRequest$json = {
  '1': 'GetTransactionStatisticsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetTransactionStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatisticsRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRUcmFuc2FjdGlvblN0YXRpc3RpY3NSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCW'
    'FjY291bnRJZBIdCgpzdGFydF9kYXRlGAIgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYAyAB'
    'KAlSB2VuZERhdGU=');

@$core.Deprecated('Use getTransactionStatisticsResponseDescriptor instead')
const GetTransactionStatisticsResponse$json = {
  '1': 'GetTransactionStatisticsResponse',
  '2': [
    {'1': 'total_transactions', '3': 1, '4': 1, '5': 5, '10': 'totalTransactions'},
    {'1': 'total_credits', '3': 2, '4': 1, '5': 1, '10': 'totalCredits'},
    {'1': 'total_debits', '3': 3, '4': 1, '5': 1, '10': 'totalDebits'},
    {'1': 'net_balance', '3': 4, '4': 1, '5': 1, '10': 'netBalance'},
    {'1': 'transactions_by_service', '3': 5, '4': 3, '5': 11, '6': '.accounts.GetTransactionStatisticsResponse.TransactionsByServiceEntry', '10': 'transactionsByService'},
    {'1': 'amount_by_service', '3': 6, '4': 3, '5': 11, '6': '.accounts.GetTransactionStatisticsResponse.AmountByServiceEntry', '10': 'amountByService'},
  ],
  '3': [GetTransactionStatisticsResponse_TransactionsByServiceEntry$json, GetTransactionStatisticsResponse_AmountByServiceEntry$json],
};

@$core.Deprecated('Use getTransactionStatisticsResponseDescriptor instead')
const GetTransactionStatisticsResponse_TransactionsByServiceEntry$json = {
  '1': 'TransactionsByServiceEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use getTransactionStatisticsResponseDescriptor instead')
const GetTransactionStatisticsResponse_AmountByServiceEntry$json = {
  '1': 'AmountByServiceEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetTransactionStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatisticsResponseDescriptor = $convert.base64Decode(
    'CiBHZXRUcmFuc2FjdGlvblN0YXRpc3RpY3NSZXNwb25zZRItChJ0b3RhbF90cmFuc2FjdGlvbn'
    'MYASABKAVSEXRvdGFsVHJhbnNhY3Rpb25zEiMKDXRvdGFsX2NyZWRpdHMYAiABKAFSDHRvdGFs'
    'Q3JlZGl0cxIhCgx0b3RhbF9kZWJpdHMYAyABKAFSC3RvdGFsRGViaXRzEh8KC25ldF9iYWxhbm'
    'NlGAQgASgBUgpuZXRCYWxhbmNlEn0KF3RyYW5zYWN0aW9uc19ieV9zZXJ2aWNlGAUgAygLMkUu'
    'YWNjb3VudHMuR2V0VHJhbnNhY3Rpb25TdGF0aXN0aWNzUmVzcG9uc2UuVHJhbnNhY3Rpb25zQn'
    'lTZXJ2aWNlRW50cnlSFXRyYW5zYWN0aW9uc0J5U2VydmljZRJrChFhbW91bnRfYnlfc2Vydmlj'
    'ZRgGIAMoCzI/LmFjY291bnRzLkdldFRyYW5zYWN0aW9uU3RhdGlzdGljc1Jlc3BvbnNlLkFtb3'
    'VudEJ5U2VydmljZUVudHJ5Ug9hbW91bnRCeVNlcnZpY2UaSAoaVHJhbnNhY3Rpb25zQnlTZXJ2'
    'aWNlRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKANSBXZhbHVlOgI4ARpCCh'
    'RBbW91bnRCeVNlcnZpY2VFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoAVIF'
    'dmFsdWU6AjgB');

@$core.Deprecated('Use transferDescriptor instead')
const Transfer$json = {
  '1': 'Transfer',
  '2': [
    {'1': 'transfer_id', '3': 1, '4': 1, '5': 9, '10': 'transferId'},
    {'1': 'from_account_id', '3': 2, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'to_account_id', '3': 3, '4': 1, '5': 9, '10': 'toAccountId'},
    {'1': 'from_account_number', '3': 4, '4': 1, '5': 9, '10': 'fromAccountNumber'},
    {'1': 'to_account_number', '3': 5, '4': 1, '5': 9, '10': 'toAccountNumber'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {'1': 'category', '3': 11, '4': 1, '5': 9, '10': 'category'},
    {'1': 'fee', '3': 12, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'total_amount', '3': 13, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'completed_at', '3': 15, '4': 1, '5': 9, '10': 'completedAt'},
    {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
  ],
};

/// Descriptor for `Transfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferDescriptor = $convert.base64Decode(
    'CghUcmFuc2ZlchIfCgt0cmFuc2Zlcl9pZBgBIAEoCVIKdHJhbnNmZXJJZBImCg9mcm9tX2FjY2'
    '91bnRfaWQYAiABKAlSDWZyb21BY2NvdW50SWQSIgoNdG9fYWNjb3VudF9pZBgDIAEoCVILdG9B'
    'Y2NvdW50SWQSLgoTZnJvbV9hY2NvdW50X251bWJlchgEIAEoCVIRZnJvbUFjY291bnROdW1iZX'
    'ISKgoRdG9fYWNjb3VudF9udW1iZXIYBSABKAlSD3RvQWNjb3VudE51bWJlchIWCgZhbW91bnQY'
    'BiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb2'
    '4YCCABKAlSC2Rlc2NyaXB0aW9uEhwKCXJlZmVyZW5jZRgJIAEoCVIJcmVmZXJlbmNlEhYKBnN0'
    'YXR1cxgKIAEoCVIGc3RhdHVzEhoKCGNhdGVnb3J5GAsgASgJUghjYXRlZ29yeRIQCgNmZWUYDC'
    'ABKAFSA2ZlZRIhCgx0b3RhbF9hbW91bnQYDSABKAFSC3RvdGFsQW1vdW50Eh0KCmNyZWF0ZWRf'
    'YXQYDiABKAlSCWNyZWF0ZWRBdBIhCgxjb21wbGV0ZWRfYXQYDyABKAlSC2NvbXBsZXRlZEF0Ei'
    'UKDmZhaWx1cmVfcmVhc29uGBAgASgJUg1mYWlsdXJlUmVhc29u');

@$core.Deprecated('Use createTransferRequestDescriptor instead')
const CreateTransferRequest$json = {
  '1': 'CreateTransferRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'from_account', '3': 2, '4': 1, '5': 9, '10': 'fromAccount'},
    {'1': 'to_account', '3': 3, '4': 1, '5': 9, '10': 'toAccount'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'pin', '3': 7, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'reference', '3': 8, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `CreateTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransferRequestDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVUcmFuc2ZlclJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiEKDGZyb2'
    '1fYWNjb3VudBgCIAEoCVILZnJvbUFjY291bnQSHQoKdG9fYWNjb3VudBgDIAEoCVIJdG9BY2Nv'
    'dW50EhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeR'
    'IgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SEAoDcGluGAcgASgJUgNwaW4SHAoJ'
    'cmVmZXJlbmNlGAggASgJUglyZWZlcmVuY2U=');

@$core.Deprecated('Use createTransferResponseDescriptor instead')
const CreateTransferResponse$json = {
  '1': 'CreateTransferResponse',
  '2': [
    {'1': 'transfer', '3': 1, '4': 1, '5': 11, '6': '.accounts.Transfer', '10': 'transfer'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransferResponseDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVUcmFuc2ZlclJlc3BvbnNlEi4KCHRyYW5zZmVyGAEgASgLMhIuYWNjb3VudHMuVH'
    'JhbnNmZXJSCHRyYW5zZmVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getTransferRequestDescriptor instead')
const GetTransferRequest$json = {
  '1': 'GetTransferRequest',
  '2': [
    {'1': 'transfer_id', '3': 1, '4': 1, '5': 9, '10': 'transferId'},
  ],
};

/// Descriptor for `GetTransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferRequestDescriptor = $convert.base64Decode(
    'ChJHZXRUcmFuc2ZlclJlcXVlc3QSHwoLdHJhbnNmZXJfaWQYASABKAlSCnRyYW5zZmVySWQ=');

@$core.Deprecated('Use getTransferResponseDescriptor instead')
const GetTransferResponse$json = {
  '1': 'GetTransferResponse',
  '2': [
    {'1': 'transfer', '3': 1, '4': 1, '5': 11, '6': '.accounts.Transfer', '10': 'transfer'},
  ],
};

/// Descriptor for `GetTransferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransferResponseDescriptor = $convert.base64Decode(
    'ChNHZXRUcmFuc2ZlclJlc3BvbnNlEi4KCHRyYW5zZmVyGAEgASgLMhIuYWNjb3VudHMuVHJhbn'
    'NmZXJSCHRyYW5zZmVy');

@$core.Deprecated('Use createVirtualAccountRequestDescriptor instead')
const CreateVirtualAccountRequest$json = {
  '1': 'CreateVirtualAccountRequest',
  '2': [
    {'1': 'account_name', '3': 1, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'locale', '3': 4, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'is_primary', '3': 5, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'daily_limit', '3': 6, '4': 1, '5': 1, '10': 'dailyLimit'},
    {'1': 'monthly_limit', '3': 7, '4': 1, '5': 1, '10': 'monthlyLimit'},
    {'1': 'email', '3': 8, '4': 1, '5': 9, '10': 'email'},
    {'1': 'first_name', '3': 9, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 10, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'bvn', '3': 12, '4': 1, '5': 9, '10': 'bvn'},
  ],
};

/// Descriptor for `CreateVirtualAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualAccountRequestDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVWaXJ0dWFsQWNjb3VudFJlcXVlc3QSIQoMYWNjb3VudF9uYW1lGAEgASgJUgthY2'
    'NvdW50TmFtZRIhCgxhY2NvdW50X3R5cGUYAiABKAlSC2FjY291bnRUeXBlEhoKCGN1cnJlbmN5'
    'GAMgASgJUghjdXJyZW5jeRIWCgZsb2NhbGUYBCABKAlSBmxvY2FsZRIdCgppc19wcmltYXJ5GA'
    'UgASgIUglpc1ByaW1hcnkSHwoLZGFpbHlfbGltaXQYBiABKAFSCmRhaWx5TGltaXQSIwoNbW9u'
    'dGhseV9saW1pdBgHIAEoAVIMbW9udGhseUxpbWl0EhQKBWVtYWlsGAggASgJUgVlbWFpbBIdCg'
    'pmaXJzdF9uYW1lGAkgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAogASgJUghsYXN0TmFt'
    'ZRIhCgxwaG9uZV9udW1iZXIYCyABKAlSC3Bob25lTnVtYmVyEhAKA2J2bhgMIAEoCVIDYnZu');

@$core.Deprecated('Use createVirtualAccountResponseDescriptor instead')
const CreateVirtualAccountResponse$json = {
  '1': 'CreateVirtualAccountResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `CreateVirtualAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createVirtualAccountResponseDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVWaXJ0dWFsQWNjb3VudFJlc3BvbnNlEisKB2FjY291bnQYASABKAsyES5hY2NvdW'
    '50cy5BY2NvdW50UgdhY2NvdW50EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USGgoIcHJvdmlk'
    'ZXIYAyABKAlSCHByb3ZpZGVy');

@$core.Deprecated('Use creditBalanceRequestDescriptor instead')
const CreditBalanceRequest$json = {
  '1': 'CreditBalanceRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'type', '3': 6, '4': 1, '5': 9, '10': 'type'},
    {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'service_name', '3': 9, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `CreditBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditBalanceRequestDescriptor = $convert.base64Decode(
    'ChRDcmVkaXRCYWxhbmNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFw'
    'oHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhYKBmFtb3VudBgDIAEoA1IGYW1vdW50EhoKCGN1cnJl'
    'bmN5GAQgASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYBSABKAlSCXJlZmVyZW5jZRISCgR0eX'
    'BlGAYgASgJUgR0eXBlEiAKC2Rlc2NyaXB0aW9uGAcgASgJUgtkZXNjcmlwdGlvbhIaCghtZXRh'
    'ZGF0YRgIIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAkgASgJUgtzZXJ2aWNlTmFtZR'
    'InCg9pZGVtcG90ZW5jeV9rZXkYCiABKAlSDmlkZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use creditBalanceResponseDescriptor instead')
const CreditBalanceResponse$json = {
  '1': 'CreditBalanceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'new_balance', '3': 5, '4': 1, '5': 3, '10': 'newBalance'},
    {'1': 'new_available_balance', '3': 6, '4': 1, '5': 3, '10': 'newAvailableBalance'},
  ],
};

/// Descriptor for `CreditBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List creditBalanceResponseDescriptor = $convert.base64Decode(
    'ChVDcmVkaXRCYWxhbmNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgplcn'
    'Jvcl9jb2RlGAIgASgJUgllcnJvckNvZGUSIwoNZXJyb3JfbWVzc2FnZRgDIAEoCVIMZXJyb3JN'
    'ZXNzYWdlEiUKDnRyYW5zYWN0aW9uX2lkGAQgASgJUg10cmFuc2FjdGlvbklkEh8KC25ld19iYW'
    'xhbmNlGAUgASgDUgpuZXdCYWxhbmNlEjIKFW5ld19hdmFpbGFibGVfYmFsYW5jZRgGIAEoA1IT'
    'bmV3QXZhaWxhYmxlQmFsYW5jZQ==');

@$core.Deprecated('Use debitBalanceRequestDescriptor instead')
const DebitBalanceRequest$json = {
  '1': 'DebitBalanceRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'type', '3': 6, '4': 1, '5': 9, '10': 'type'},
    {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'service_name', '3': 9, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'idempotency_key', '3': 10, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'require_hold', '3': 11, '4': 1, '5': 8, '10': 'requireHold'},
    {'1': 'hold_id', '3': 12, '4': 1, '5': 9, '10': 'holdId'},
  ],
};

/// Descriptor for `DebitBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debitBalanceRequestDescriptor = $convert.base64Decode(
    'ChNEZWJpdEJhbGFuY2VSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIXCg'
    'd1c2VyX2lkGAIgASgJUgZ1c2VySWQSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVu'
    'Y3kYBCABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgFIAEoCVIJcmVmZXJlbmNlEhIKBHR5cG'
    'UYBiABKAlSBHR5cGUSIAoLZGVzY3JpcHRpb24YByABKAlSC2Rlc2NyaXB0aW9uEhoKCG1ldGFk'
    'YXRhGAggASgJUghtZXRhZGF0YRIhCgxzZXJ2aWNlX25hbWUYCSABKAlSC3NlcnZpY2VOYW1lEi'
    'cKD2lkZW1wb3RlbmN5X2tleRgKIAEoCVIOaWRlbXBvdGVuY3lLZXkSIQoMcmVxdWlyZV9ob2xk'
    'GAsgASgIUgtyZXF1aXJlSG9sZBIXCgdob2xkX2lkGAwgASgJUgZob2xkSWQ=');

@$core.Deprecated('Use debitBalanceResponseDescriptor instead')
const DebitBalanceResponse$json = {
  '1': 'DebitBalanceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'new_balance', '3': 5, '4': 1, '5': 3, '10': 'newBalance'},
    {'1': 'new_available_balance', '3': 6, '4': 1, '5': 3, '10': 'newAvailableBalance'},
  ],
};

/// Descriptor for `DebitBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debitBalanceResponseDescriptor = $convert.base64Decode(
    'ChREZWJpdEJhbGFuY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm'
    '9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1l'
    'c3NhZ2USJQoOdHJhbnNhY3Rpb25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSHwoLbmV3X2JhbG'
    'FuY2UYBSABKANSCm5ld0JhbGFuY2USMgoVbmV3X2F2YWlsYWJsZV9iYWxhbmNlGAYgASgDUhNu'
    'ZXdBdmFpbGFibGVCYWxhbmNl');

@$core.Deprecated('Use transferBalanceRequestDescriptor instead')
const TransferBalanceRequest$json = {
  '1': 'TransferBalanceRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'to_account_id', '3': 2, '4': 1, '5': 9, '10': 'toAccountId'},
    {'1': 'from_user_id', '3': 3, '4': 1, '5': 9, '10': 'fromUserId'},
    {'1': 'to_user_id', '3': 4, '4': 1, '5': 9, '10': 'toUserId'},
    {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 7, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 9, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'service_name', '3': 10, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `TransferBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferBalanceRequestDescriptor = $convert.base64Decode(
    'ChZUcmFuc2ZlckJhbGFuY2VSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZnJvbU'
    'FjY291bnRJZBIiCg10b19hY2NvdW50X2lkGAIgASgJUgt0b0FjY291bnRJZBIgCgxmcm9tX3Vz'
    'ZXJfaWQYAyABKAlSCmZyb21Vc2VySWQSHAoKdG9fdXNlcl9pZBgEIAEoCVIIdG9Vc2VySWQSFg'
    'oGYW1vdW50GAUgASgDUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EhwKCXJl'
    'ZmVyZW5jZRgHIAEoCVIJcmVmZXJlbmNlEiAKC2Rlc2NyaXB0aW9uGAggASgJUgtkZXNjcmlwdG'
    'lvbhIaCghtZXRhZGF0YRgJIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAogASgJUgtz'
    'ZXJ2aWNlTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYCyABKAlSDmlkZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use transferBalanceResponseDescriptor instead')
const TransferBalanceResponse$json = {
  '1': 'TransferBalanceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'debit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'debitTransactionId'},
    {'1': 'credit_transaction_id', '3': 5, '4': 1, '5': 9, '10': 'creditTransactionId'},
    {'1': 'from_new_balance', '3': 6, '4': 1, '5': 3, '10': 'fromNewBalance'},
    {'1': 'to_new_balance', '3': 7, '4': 1, '5': 3, '10': 'toNewBalance'},
  ],
};

/// Descriptor for `TransferBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferBalanceResponseDescriptor = $convert.base64Decode(
    'ChdUcmFuc2ZlckJhbGFuY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCm'
    'Vycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJv'
    'ck1lc3NhZ2USMAoUZGViaXRfdHJhbnNhY3Rpb25faWQYBCABKAlSEmRlYml0VHJhbnNhY3Rpb2'
    '5JZBIyChVjcmVkaXRfdHJhbnNhY3Rpb25faWQYBSABKAlSE2NyZWRpdFRyYW5zYWN0aW9uSWQS'
    'KAoQZnJvbV9uZXdfYmFsYW5jZRgGIAEoA1IOZnJvbU5ld0JhbGFuY2USJAoOdG9fbmV3X2JhbG'
    'FuY2UYByABKANSDHRvTmV3QmFsYW5jZQ==');

@$core.Deprecated('Use holdFundsRequestDescriptor instead')
const HoldFundsRequest$json = {
  '1': 'HoldFundsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 5, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'reason', '3': 6, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'expires_in_seconds', '3': 7, '4': 1, '5': 5, '10': 'expiresInSeconds'},
    {'1': 'service_name', '3': 8, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `HoldFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdFundsRequestDescriptor = $convert.base64Decode(
    'ChBIb2xkRnVuZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIXCgd1c2'
    'VyX2lkGAIgASgJUgZ1c2VySWQSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGgoIY3VycmVuY3kY'
    'BCABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgFIAEoCVIJcmVmZXJlbmNlEhYKBnJlYXNvbh'
    'gGIAEoCVIGcmVhc29uEiwKEmV4cGlyZXNfaW5fc2Vjb25kcxgHIAEoBVIQZXhwaXJlc0luU2Vj'
    'b25kcxIhCgxzZXJ2aWNlX25hbWUYCCABKAlSC3NlcnZpY2VOYW1lEicKD2lkZW1wb3RlbmN5X2'
    'tleRgJIAEoCVIOaWRlbXBvdGVuY3lLZXk=');

@$core.Deprecated('Use holdFundsResponseDescriptor instead')
const HoldFundsResponse$json = {
  '1': 'HoldFundsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'hold_id', '3': 4, '4': 1, '5': 9, '10': 'holdId'},
    {'1': 'new_available_balance', '3': 5, '4': 1, '5': 3, '10': 'newAvailableBalance'},
    {'1': 'expires_at', '3': 6, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `HoldFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdFundsResponseDescriptor = $convert.base64Decode(
    'ChFIb2xkRnVuZHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh0KCmVycm9yX2'
    'NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMgASgJUgxlcnJvck1lc3Nh'
    'Z2USFwoHaG9sZF9pZBgEIAEoCVIGaG9sZElkEjIKFW5ld19hdmFpbGFibGVfYmFsYW5jZRgFIA'
    'EoA1ITbmV3QXZhaWxhYmxlQmFsYW5jZRIdCgpleHBpcmVzX2F0GAYgASgJUglleHBpcmVzQXQ=');

@$core.Deprecated('Use captureHoldRequestDescriptor instead')
const CaptureHoldRequest$json = {
  '1': 'CaptureHoldRequest',
  '2': [
    {'1': 'hold_id', '3': 1, '4': 1, '5': 9, '10': 'holdId'},
    {'1': 'service_name', '3': 2, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CaptureHoldRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List captureHoldRequestDescriptor = $convert.base64Decode(
    'ChJDYXB0dXJlSG9sZFJlcXVlc3QSFwoHaG9sZF9pZBgBIAEoCVIGaG9sZElkEiEKDHNlcnZpY2'
    'VfbmFtZRgCIAEoCVILc2VydmljZU5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0'
    'aW9uEhoKCG1ldGFkYXRhGAQgASgJUghtZXRhZGF0YQ==');

@$core.Deprecated('Use captureHoldResponseDescriptor instead')
const CaptureHoldResponse$json = {
  '1': 'CaptureHoldResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'new_balance', '3': 5, '4': 1, '5': 3, '10': 'newBalance'},
  ],
};

/// Descriptor for `CaptureHoldResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List captureHoldResponseDescriptor = $convert.base64Decode(
    'ChNDYXB0dXJlSG9sZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3'
    'JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVz'
    'c2FnZRIlCg50cmFuc2FjdGlvbl9pZBgEIAEoCVINdHJhbnNhY3Rpb25JZBIfCgtuZXdfYmFsYW'
    '5jZRgFIAEoA1IKbmV3QmFsYW5jZQ==');

@$core.Deprecated('Use releaseHoldRequestDescriptor instead')
const ReleaseHoldRequest$json = {
  '1': 'ReleaseHoldRequest',
  '2': [
    {'1': 'hold_id', '3': 1, '4': 1, '5': 9, '10': 'holdId'},
    {'1': 'service_name', '3': 2, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `ReleaseHoldRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List releaseHoldRequestDescriptor = $convert.base64Decode(
    'ChJSZWxlYXNlSG9sZFJlcXVlc3QSFwoHaG9sZF9pZBgBIAEoCVIGaG9sZElkEiEKDHNlcnZpY2'
    'VfbmFtZRgCIAEoCVILc2VydmljZU5hbWUSFgoGcmVhc29uGAMgASgJUgZyZWFzb24=');

@$core.Deprecated('Use releaseHoldResponseDescriptor instead')
const ReleaseHoldResponse$json = {
  '1': 'ReleaseHoldResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'new_available_balance', '3': 4, '4': 1, '5': 3, '10': 'newAvailableBalance'},
  ],
};

/// Descriptor for `ReleaseHoldResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List releaseHoldResponseDescriptor = $convert.base64Decode(
    'ChNSZWxlYXNlSG9sZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKZXJyb3'
    'JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVz'
    'c2FnZRIyChVuZXdfYXZhaWxhYmxlX2JhbGFuY2UYBCABKANSE25ld0F2YWlsYWJsZUJhbGFuY2'
    'U=');

@$core.Deprecated('Use platformWalletMsgDescriptor instead')
const PlatformWalletMsg$json = {
  '1': 'PlatformWalletMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'wallet_code', '3': 2, '4': 1, '5': 9, '10': 'walletCode'},
    {'1': 'wallet_name', '3': 3, '4': 1, '5': 9, '10': 'walletName'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'balance', '3': 5, '4': 1, '5': 3, '10': 'balance'},
    {'1': 'available_balance', '3': 6, '4': 1, '5': 3, '10': 'availableBalance'},
    {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `PlatformWalletMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List platformWalletMsgDescriptor = $convert.base64Decode(
    'ChFQbGF0Zm9ybVdhbGxldE1zZxIOCgJpZBgBIAEoCVICaWQSHwoLd2FsbGV0X2NvZGUYAiABKA'
    'lSCndhbGxldENvZGUSHwoLd2FsbGV0X25hbWUYAyABKAlSCndhbGxldE5hbWUSGgoIY3VycmVu'
    'Y3kYBCABKAlSCGN1cnJlbmN5EhgKB2JhbGFuY2UYBSABKANSB2JhbGFuY2USKwoRYXZhaWxhYm'
    'xlX2JhbGFuY2UYBiABKANSEGF2YWlsYWJsZUJhbGFuY2USFgoGc3RhdHVzGAcgASgJUgZzdGF0'
    'dXMSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEh0KCmNyZWF0ZWRfYXQYCSABKA'
    'lSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAogASgJUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use platformWalletTransactionMsgDescriptor instead')
const PlatformWalletTransactionMsg$json = {
  '1': 'PlatformWalletTransactionMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'wallet_id', '3': 2, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'amount', '3': 6, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'balance_before', '3': 7, '4': 1, '5': 3, '10': 'balanceBefore'},
    {'1': 'balance_after', '3': 8, '4': 1, '5': 3, '10': 'balanceAfter'},
    {'1': 'counterparty_account_id', '3': 9, '4': 1, '5': 9, '10': 'counterpartyAccountId'},
    {'1': 'counterparty_user_id', '3': 10, '4': 1, '5': 9, '10': 'counterpartyUserId'},
    {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 12, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'service_name', '3': 13, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'status', '3': 14, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 15, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `PlatformWalletTransactionMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List platformWalletTransactionMsgDescriptor = $convert.base64Decode(
    'ChxQbGF0Zm9ybVdhbGxldFRyYW5zYWN0aW9uTXNnEg4KAmlkGAEgASgJUgJpZBIbCgl3YWxsZX'
    'RfaWQYAiABKAlSCHdhbGxldElkEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhIKBHR5'
    'cGUYBCABKAlSBHR5cGUSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgGIA'
    'EoA1IGYW1vdW50EiUKDmJhbGFuY2VfYmVmb3JlGAcgASgDUg1iYWxhbmNlQmVmb3JlEiMKDWJh'
    'bGFuY2VfYWZ0ZXIYCCABKANSDGJhbGFuY2VBZnRlchI2Chdjb3VudGVycGFydHlfYWNjb3VudF'
    '9pZBgJIAEoCVIVY291bnRlcnBhcnR5QWNjb3VudElkEjAKFGNvdW50ZXJwYXJ0eV91c2VyX2lk'
    'GAogASgJUhJjb3VudGVycGFydHlVc2VySWQSIAoLZGVzY3JpcHRpb24YCyABKAlSC2Rlc2NyaX'
    'B0aW9uEhoKCG1ldGFkYXRhGAwgASgJUghtZXRhZGF0YRIhCgxzZXJ2aWNlX25hbWUYDSABKAlS'
    'C3NlcnZpY2VOYW1lEhYKBnN0YXR1cxgOIAEoCVIGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYDyABKA'
    'lSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use transferToPlatformWalletRequestDescriptor instead')
const TransferToPlatformWalletRequest$json = {
  '1': 'TransferToPlatformWalletRequest',
  '2': [
    {'1': 'user_account_id', '3': 1, '4': 1, '5': 9, '10': 'userAccountId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'wallet_code', '3': 3, '4': 1, '5': 9, '10': 'walletCode'},
    {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'category', '3': 7, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 9, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'service_name', '3': 10, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `TransferToPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferToPlatformWalletRequestDescriptor = $convert.base64Decode(
    'Ch9UcmFuc2ZlclRvUGxhdGZvcm1XYWxsZXRSZXF1ZXN0EiYKD3VzZXJfYWNjb3VudF9pZBgBIA'
    'EoCVINdXNlckFjY291bnRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHwoLd2FsbGV0X2Nv'
    'ZGUYAyABKAlSCndhbGxldENvZGUSFgoGYW1vdW50GAQgASgDUgZhbW91bnQSGgoIY3VycmVuY3'
    'kYBSABKAlSCGN1cnJlbmN5EhwKCXJlZmVyZW5jZRgGIAEoCVIJcmVmZXJlbmNlEhoKCGNhdGVn'
    'b3J5GAcgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgIIAEoCVILZGVzY3JpcHRpb24SGg'
    'oIbWV0YWRhdGEYCSABKAlSCG1ldGFkYXRhEiEKDHNlcnZpY2VfbmFtZRgKIAEoCVILc2Vydmlj'
    'ZU5hbWUSJwoPaWRlbXBvdGVuY3lfa2V5GAsgASgJUg5pZGVtcG90ZW5jeUtleQ==');

@$core.Deprecated('Use transferToPlatformWalletResponseDescriptor instead')
const TransferToPlatformWalletResponse$json = {
  '1': 'TransferToPlatformWalletResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'debit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'debitTransactionId'},
    {'1': 'platform_transaction_id', '3': 5, '4': 1, '5': 9, '10': 'platformTransactionId'},
    {'1': 'user_new_balance', '3': 6, '4': 1, '5': 3, '10': 'userNewBalance'},
    {'1': 'wallet_new_balance', '3': 7, '4': 1, '5': 3, '10': 'walletNewBalance'},
  ],
};

/// Descriptor for `TransferToPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferToPlatformWalletResponseDescriptor = $convert.base64Decode(
    'CiBUcmFuc2ZlclRvUGxhdGZvcm1XYWxsZXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdW'
    'NjZXNzEh0KCmVycm9yX2NvZGUYAiABKAlSCWVycm9yQ29kZRIjCg1lcnJvcl9tZXNzYWdlGAMg'
    'ASgJUgxlcnJvck1lc3NhZ2USMAoUZGViaXRfdHJhbnNhY3Rpb25faWQYBCABKAlSEmRlYml0VH'
    'JhbnNhY3Rpb25JZBI2ChdwbGF0Zm9ybV90cmFuc2FjdGlvbl9pZBgFIAEoCVIVcGxhdGZvcm1U'
    'cmFuc2FjdGlvbklkEigKEHVzZXJfbmV3X2JhbGFuY2UYBiABKANSDnVzZXJOZXdCYWxhbmNlEi'
    'wKEndhbGxldF9uZXdfYmFsYW5jZRgHIAEoA1IQd2FsbGV0TmV3QmFsYW5jZQ==');

@$core.Deprecated('Use transferFromPlatformWalletRequestDescriptor instead')
const TransferFromPlatformWalletRequest$json = {
  '1': 'TransferFromPlatformWalletRequest',
  '2': [
    {'1': 'wallet_code', '3': 1, '4': 1, '5': 9, '10': 'walletCode'},
    {'1': 'user_account_id', '3': 2, '4': 1, '5': 9, '10': 'userAccountId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'category', '3': 7, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 9, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'service_name', '3': 10, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'idempotency_key', '3': 11, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `TransferFromPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferFromPlatformWalletRequestDescriptor = $convert.base64Decode(
    'CiFUcmFuc2ZlckZyb21QbGF0Zm9ybVdhbGxldFJlcXVlc3QSHwoLd2FsbGV0X2NvZGUYASABKA'
    'lSCndhbGxldENvZGUSJgoPdXNlcl9hY2NvdW50X2lkGAIgASgJUg11c2VyQWNjb3VudElkEhcK'
    'B3VzZXJfaWQYAyABKAlSBnVzZXJJZBIWCgZhbW91bnQYBCABKANSBmFtb3VudBIaCghjdXJyZW'
    '5jeRgFIAEoCVIIY3VycmVuY3kSHAoJcmVmZXJlbmNlGAYgASgJUglyZWZlcmVuY2USGgoIY2F0'
    'ZWdvcnkYByABKAlSCGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGAggASgJUgtkZXNjcmlwdGlvbh'
    'IaCghtZXRhZGF0YRgJIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAogASgJUgtzZXJ2'
    'aWNlTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYCyABKAlSDmlkZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use transferFromPlatformWalletResponseDescriptor instead')
const TransferFromPlatformWalletResponse$json = {
  '1': 'TransferFromPlatformWalletResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'credit_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'creditTransactionId'},
    {'1': 'platform_transaction_id', '3': 5, '4': 1, '5': 9, '10': 'platformTransactionId'},
    {'1': 'user_new_balance', '3': 6, '4': 1, '5': 3, '10': 'userNewBalance'},
    {'1': 'wallet_new_balance', '3': 7, '4': 1, '5': 3, '10': 'walletNewBalance'},
  ],
};

/// Descriptor for `TransferFromPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferFromPlatformWalletResponseDescriptor = $convert.base64Decode(
    'CiJUcmFuc2ZlckZyb21QbGF0Zm9ybVdhbGxldFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3'
    'N1Y2Nlc3MSHQoKZXJyb3JfY29kZRgCIAEoCVIJZXJyb3JDb2RlEiMKDWVycm9yX21lc3NhZ2UY'
    'AyABKAlSDGVycm9yTWVzc2FnZRIyChVjcmVkaXRfdHJhbnNhY3Rpb25faWQYBCABKAlSE2NyZW'
    'RpdFRyYW5zYWN0aW9uSWQSNgoXcGxhdGZvcm1fdHJhbnNhY3Rpb25faWQYBSABKAlSFXBsYXRm'
    'b3JtVHJhbnNhY3Rpb25JZBIoChB1c2VyX25ld19iYWxhbmNlGAYgASgDUg51c2VyTmV3QmFsYW'
    '5jZRIsChJ3YWxsZXRfbmV3X2JhbGFuY2UYByABKANSEHdhbGxldE5ld0JhbGFuY2U=');

@$core.Deprecated('Use getPlatformWalletRequestDescriptor instead')
const GetPlatformWalletRequest$json = {
  '1': 'GetPlatformWalletRequest',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'wallet_code', '3': 2, '4': 1, '5': 9, '10': 'walletCode'},
  ],
};

/// Descriptor for `GetPlatformWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformWalletRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQbGF0Zm9ybVdhbGxldFJlcXVlc3QSGwoJd2FsbGV0X2lkGAEgASgJUgh3YWxsZXRJZB'
    'IfCgt3YWxsZXRfY29kZRgCIAEoCVIKd2FsbGV0Q29kZQ==');

@$core.Deprecated('Use getPlatformWalletResponseDescriptor instead')
const GetPlatformWalletResponse$json = {
  '1': 'GetPlatformWalletResponse',
  '2': [
    {'1': 'wallet', '3': 1, '4': 1, '5': 11, '6': '.accounts.PlatformWalletMsg', '10': 'wallet'},
  ],
};

/// Descriptor for `GetPlatformWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformWalletResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQbGF0Zm9ybVdhbGxldFJlc3BvbnNlEjMKBndhbGxldBgBIAEoCzIbLmFjY291bnRzLl'
    'BsYXRmb3JtV2FsbGV0TXNnUgZ3YWxsZXQ=');

@$core.Deprecated('Use getPlatformWalletTransactionsRequestDescriptor instead')
const GetPlatformWalletTransactionsRequest$json = {
  '1': 'GetPlatformWalletTransactionsRequest',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'wallet_code', '3': 2, '4': 1, '5': 9, '10': 'walletCode'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'start_date', '3': 5, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 6, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 7, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 8, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetPlatformWalletTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformWalletTransactionsRequestDescriptor = $convert.base64Decode(
    'CiRHZXRQbGF0Zm9ybVdhbGxldFRyYW5zYWN0aW9uc1JlcXVlc3QSGwoJd2FsbGV0X2lkGAEgAS'
    'gJUgh3YWxsZXRJZBIfCgt3YWxsZXRfY29kZRgCIAEoCVIKd2FsbGV0Q29kZRISCgR0eXBlGAMg'
    'ASgJUgR0eXBlEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIdCgpzdGFydF9kYXRlGAUgAS'
    'gJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYBiABKAlSB2VuZERhdGUSFAoFbGltaXQYByABKAVS'
    'BWxpbWl0EhYKBm9mZnNldBgIIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use getPlatformWalletTransactionsResponseDescriptor instead')
const GetPlatformWalletTransactionsResponse$json = {
  '1': 'GetPlatformWalletTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.accounts.PlatformWalletTransactionMsg', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPlatformWalletTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlatformWalletTransactionsResponseDescriptor = $convert.base64Decode(
    'CiVHZXRQbGF0Zm9ybVdhbGxldFRyYW5zYWN0aW9uc1Jlc3BvbnNlEkoKDHRyYW5zYWN0aW9ucx'
    'gBIAMoCzImLmFjY291bnRzLlBsYXRmb3JtV2FsbGV0VHJhbnNhY3Rpb25Nc2dSDHRyYW5zYWN0'
    'aW9ucxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use periodTotalsDescriptor instead')
const PeriodTotals$json = {
  '1': 'PeriodTotals',
  '2': [
    {'1': 'total_income', '3': 1, '4': 1, '5': 1, '10': 'totalIncome'},
    {'1': 'total_expenses', '3': 2, '4': 1, '5': 1, '10': 'totalExpenses'},
    {'1': 'net', '3': 3, '4': 1, '5': 1, '10': 'net'},
    {'1': 'transaction_count', '3': 4, '4': 1, '5': 5, '10': 'transactionCount'},
  ],
};

/// Descriptor for `PeriodTotals`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List periodTotalsDescriptor = $convert.base64Decode(
    'CgxQZXJpb2RUb3RhbHMSIQoMdG90YWxfaW5jb21lGAEgASgBUgt0b3RhbEluY29tZRIlCg50b3'
    'RhbF9leHBlbnNlcxgCIAEoAVINdG90YWxFeHBlbnNlcxIQCgNuZXQYAyABKAFSA25ldBIrChF0'
    'cmFuc2FjdGlvbl9jb3VudBgEIAEoBVIQdHJhbnNhY3Rpb25Db3VudA==');

@$core.Deprecated('Use getFinancialAnalyticsRequestDescriptor instead')
const GetFinancialAnalyticsRequest$json = {
  '1': 'GetFinancialAnalyticsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'period', '3': 2, '4': 1, '5': 9, '10': 'period'},
    {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetFinancialAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialAnalyticsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRGaW5hbmNpYWxBbmFseXRpY3NSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY2'
    '91bnRJZBIWCgZwZXJpb2QYAiABKAlSBnBlcmlvZBIdCgpzdGFydF9kYXRlGAMgASgJUglzdGFy'
    'dERhdGUSGQoIZW5kX2RhdGUYBCABKAlSB2VuZERhdGU=');

@$core.Deprecated('Use getFinancialAnalyticsResponseDescriptor instead')
const GetFinancialAnalyticsResponse$json = {
  '1': 'GetFinancialAnalyticsResponse',
  '2': [
    {'1': 'current_period', '3': 1, '4': 1, '5': 11, '6': '.accounts.PeriodTotals', '10': 'currentPeriod'},
    {'1': 'previous_period', '3': 2, '4': 1, '5': 11, '6': '.accounts.PeriodTotals', '10': 'previousPeriod'},
    {'1': 'income_change_percent', '3': 3, '4': 1, '5': 1, '10': 'incomeChangePercent'},
    {'1': 'expense_change_percent', '3': 4, '4': 1, '5': 1, '10': 'expenseChangePercent'},
    {'1': 'period_label', '3': 5, '4': 1, '5': 9, '10': 'periodLabel'},
  ],
};

/// Descriptor for `GetFinancialAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialAnalyticsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRGaW5hbmNpYWxBbmFseXRpY3NSZXNwb25zZRI9Cg5jdXJyZW50X3BlcmlvZBgBIAEoCz'
    'IWLmFjY291bnRzLlBlcmlvZFRvdGFsc1INY3VycmVudFBlcmlvZBI/Cg9wcmV2aW91c19wZXJp'
    'b2QYAiABKAsyFi5hY2NvdW50cy5QZXJpb2RUb3RhbHNSDnByZXZpb3VzUGVyaW9kEjIKFWluY2'
    '9tZV9jaGFuZ2VfcGVyY2VudBgDIAEoAVITaW5jb21lQ2hhbmdlUGVyY2VudBI0ChZleHBlbnNl'
    'X2NoYW5nZV9wZXJjZW50GAQgASgBUhRleHBlbnNlQ2hhbmdlUGVyY2VudBIhCgxwZXJpb2RfbG'
    'FiZWwYBSABKAlSC3BlcmlvZExhYmVs');

@$core.Deprecated('Use categoryBreakdownItemDescriptor instead')
const CategoryBreakdownItem$json = {
  '1': 'CategoryBreakdownItem',
  '2': [
    {'1': 'category_name', '3': 1, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_count', '3': 3, '4': 1, '5': 5, '10': 'transactionCount'},
    {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
  ],
};

/// Descriptor for `CategoryBreakdownItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryBreakdownItemDescriptor = $convert.base64Decode(
    'ChVDYXRlZ29yeUJyZWFrZG93bkl0ZW0SIwoNY2F0ZWdvcnlfbmFtZRgBIAEoCVIMY2F0ZWdvcn'
    'lOYW1lEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EisKEXRyYW5zYWN0aW9uX2NvdW50GAMgASgF'
    'UhB0cmFuc2FjdGlvbkNvdW50Eh4KCnBlcmNlbnRhZ2UYBCABKAFSCnBlcmNlbnRhZ2U=');

@$core.Deprecated('Use getCategoryAnalyticsRequestDescriptor instead')
const GetCategoryAnalyticsRequest$json = {
  '1': 'GetCategoryAnalyticsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetCategoryAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryAnalyticsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRDYXRlZ29yeUFuYWx5dGljc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3'
    'VudElkEh0KCnN0YXJ0X2RhdGUYAiABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgDIAEoCVIH'
    'ZW5kRGF0ZQ==');

@$core.Deprecated('Use getCategoryAnalyticsResponseDescriptor instead')
const GetCategoryAnalyticsResponse$json = {
  '1': 'GetCategoryAnalyticsResponse',
  '2': [
    {'1': 'expense_categories', '3': 1, '4': 3, '5': 11, '6': '.accounts.CategoryBreakdownItem', '10': 'expenseCategories'},
    {'1': 'income_categories', '3': 2, '4': 3, '5': 11, '6': '.accounts.CategoryBreakdownItem', '10': 'incomeCategories'},
    {'1': 'total_expenses', '3': 3, '4': 1, '5': 1, '10': 'totalExpenses'},
    {'1': 'total_income', '3': 4, '4': 1, '5': 1, '10': 'totalIncome'},
  ],
};

/// Descriptor for `GetCategoryAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryAnalyticsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRDYXRlZ29yeUFuYWx5dGljc1Jlc3BvbnNlEk4KEmV4cGVuc2VfY2F0ZWdvcmllcxgBIA'
    'MoCzIfLmFjY291bnRzLkNhdGVnb3J5QnJlYWtkb3duSXRlbVIRZXhwZW5zZUNhdGVnb3JpZXMS'
    'TAoRaW5jb21lX2NhdGVnb3JpZXMYAiADKAsyHy5hY2NvdW50cy5DYXRlZ29yeUJyZWFrZG93bk'
    'l0ZW1SEGluY29tZUNhdGVnb3JpZXMSJQoOdG90YWxfZXhwZW5zZXMYAyABKAFSDXRvdGFsRXhw'
    'ZW5zZXMSIQoMdG90YWxfaW5jb21lGAQgASgBUgt0b3RhbEluY29tZQ==');

@$core.Deprecated('Use monthlyDataPointDescriptor instead')
const MonthlyDataPoint$json = {
  '1': 'MonthlyDataPoint',
  '2': [
    {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    {'1': 'month_label', '3': 2, '4': 1, '5': 9, '10': 'monthLabel'},
    {'1': 'income', '3': 3, '4': 1, '5': 1, '10': 'income'},
    {'1': 'expenses', '3': 4, '4': 1, '5': 1, '10': 'expenses'},
  ],
};

/// Descriptor for `MonthlyDataPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monthlyDataPointDescriptor = $convert.base64Decode(
    'ChBNb250aGx5RGF0YVBvaW50EhQKBW1vbnRoGAEgASgJUgVtb250aBIfCgttb250aF9sYWJlbB'
    'gCIAEoCVIKbW9udGhMYWJlbBIWCgZpbmNvbWUYAyABKAFSBmluY29tZRIaCghleHBlbnNlcxgE'
    'IAEoAVIIZXhwZW5zZXM=');

@$core.Deprecated('Use getMonthlyTrendsRequestDescriptor instead')
const GetMonthlyTrendsRequest$json = {
  '1': 'GetMonthlyTrendsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'months', '3': 2, '4': 1, '5': 5, '10': 'months'},
  ],
};

/// Descriptor for `GetMonthlyTrendsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMonthlyTrendsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRNb250aGx5VHJlbmRzUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SW'
    'QSFgoGbW9udGhzGAIgASgFUgZtb250aHM=');

@$core.Deprecated('Use getMonthlyTrendsResponseDescriptor instead')
const GetMonthlyTrendsResponse$json = {
  '1': 'GetMonthlyTrendsResponse',
  '2': [
    {'1': 'months', '3': 1, '4': 3, '5': 11, '6': '.accounts.MonthlyDataPoint', '10': 'months'},
  ],
};

/// Descriptor for `GetMonthlyTrendsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMonthlyTrendsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRNb250aGx5VHJlbmRzUmVzcG9uc2USMgoGbW9udGhzGAEgAygLMhouYWNjb3VudHMuTW'
    '9udGhseURhdGFQb2ludFIGbW9udGhz');

@$core.Deprecated('Use dailyExpensePointDescriptor instead')
const DailyExpensePoint$json = {
  '1': 'DailyExpensePoint',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `DailyExpensePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dailyExpensePointDescriptor = $convert.base64Decode(
    'ChFEYWlseUV4cGVuc2VQb2ludBISCgRkYXRlGAEgASgJUgRkYXRlEhYKBmFtb3VudBgCIAEoAV'
    'IGYW1vdW50');

@$core.Deprecated('Use getExpenseTimeSeriesRequestDescriptor instead')
const GetExpenseTimeSeriesRequest$json = {
  '1': 'GetExpenseTimeSeriesRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetExpenseTimeSeriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpenseTimeSeriesRequestDescriptor = $convert.base64Decode(
    'ChtHZXRFeHBlbnNlVGltZVNlcmllc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3'
    'VudElkEh0KCnN0YXJ0X2RhdGUYAiABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgDIAEoCVIH'
    'ZW5kRGF0ZQ==');

@$core.Deprecated('Use getExpenseTimeSeriesResponseDescriptor instead')
const GetExpenseTimeSeriesResponse$json = {
  '1': 'GetExpenseTimeSeriesResponse',
  '2': [
    {'1': 'data_points', '3': 1, '4': 3, '5': 11, '6': '.accounts.DailyExpensePoint', '10': 'dataPoints'},
    {'1': 'total_expenses', '3': 2, '4': 1, '5': 1, '10': 'totalExpenses'},
    {'1': 'daily_average', '3': 3, '4': 1, '5': 1, '10': 'dailyAverage'},
  ],
};

/// Descriptor for `GetExpenseTimeSeriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpenseTimeSeriesResponseDescriptor = $convert.base64Decode(
    'ChxHZXRFeHBlbnNlVGltZVNlcmllc1Jlc3BvbnNlEjwKC2RhdGFfcG9pbnRzGAEgAygLMhsuYW'
    'Njb3VudHMuRGFpbHlFeHBlbnNlUG9pbnRSCmRhdGFQb2ludHMSJQoOdG90YWxfZXhwZW5zZXMY'
    'AiABKAFSDXRvdGFsRXhwZW5zZXMSIwoNZGFpbHlfYXZlcmFnZRgDIAEoAVIMZGFpbHlBdmVyYW'
    'dl');

