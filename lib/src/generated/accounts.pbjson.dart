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
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode('CgdBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYWNjb3VudF9udW1iZXIYAyABKAlSDWFjY291bnROdW1iZXISIQoMYWNjb3VudF9uYW1lGAQgASgJUgthY2NvdW50TmFtZRIhCgxhY2NvdW50X3R5cGUYBSABKAlSC2FjY291bnRUeXBlEhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIWCgZsb2NhbGUYByABKAlSBmxvY2FsZRIYCgdiYWxhbmNlGAggASgBUgdiYWxhbmNlEisKEWF2YWlsYWJsZV9iYWxhbmNlGAkgASgBUhBhdmFpbGFibGVCYWxhbmNlEhYKBnN0YXR1cxgKIAEoCVIGc3RhdHVzEh0KCmlzX3ByaW1hcnkYCyABKAhSCWlzUHJpbWFyeRIbCgliYW5rX2NvZGUYDCABKAlSCGJhbmtDb2RlEh8KC2JyYW5jaF9jb2RlGA0gASgJUgpicmFuY2hDb2RlEiwKEmZyZWV6ZV9yZWFzb25fY29kZRgOIAEoBVIQZnJlZXplUmVhc29uQ29kZRIjCg1mcmVlemVfcmVhc29uGA8gASgJUgxmcmVlemVSZWFzb24SGwoJZnJvemVuX2F0GBAgASgJUghmcm96ZW5BdBIbCglmcm96ZW5fYnkYESABKAlSCGZyb3plbkJ5Eh8KC2RhaWx5X2xpbWl0GBIgASgBUgpkYWlseUxpbWl0EiMKDW1vbnRobHlfbGltaXQYEyABKAFSDG1vbnRobHlMaW1pdBIdCgpjcmVhdGVkX2F0GBQgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgVIAEoCVIJdXBkYXRlZEF0');
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
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode('CgtUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhIKBHR5cGUYBCABKAlSBHR5cGUSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EiUKDmJhbGFuY2VfYmVmb3JlGAcgASgBUg1iYWxhbmNlQmVmb3JlEiMKDWJhbGFuY2VfYWZ0ZXIYCCABKAFSDGJhbGFuY2VBZnRlchIgCgtkZXNjcmlwdGlvbhgJIAEoCVILZGVzY3JpcHRpb24SGgoIbWV0YWRhdGEYCiABKAlSCG1ldGFkYXRhEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEhYKBmxvY2FsZRgMIAEoCVIGbG9jYWxlEiEKDHNlcnZpY2VfbmFtZRgNIAEoCVILc2VydmljZU5hbWUSHQoKY3JlYXRlZF9hdBgOIAEoCVIJY3JlYXRlZEF0');
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
  ],
};

/// Descriptor for `UpdateBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBalanceRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVCYWxhbmNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSHAoJb3BlcmF0aW9uGAMgASgJUglvcGVyYXRpb24SHAoJcmVmZXJlbmNlGAQgASgJUglyZWZlcmVuY2USIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEhoKCGNhdGVnb3J5GAYgASgJUghjYXRlZ29yeQ==');
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
  ],
};

/// Descriptor for `LockFunds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lockFundsDescriptor = $convert.base64Decode('CglMb2NrRnVuZHMSDgoCaWQYASABKAlSAmlkEh0KCmFjY291bnRfaWQYAiABKAlSCWFjY291bnRJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSEgoEbmFtZRgEIAEoCVIEbmFtZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIbCglsb2NrX3R5cGUYBiABKAlSCGxvY2tUeXBlEhYKBnN0YXR1cxgHIAEoCVIGc3RhdHVzEh8KC3VubG9ja19kYXRlGAggASgJUgp1bmxvY2tEYXRlEiMKDXRhcmdldF9hbW91bnQYCSABKAFSDHRhcmdldEFtb3VudBIhCgxwZW5hbHR5X3JhdGUYCiABKAFSC3BlbmFsdHlSYXRlEh0KCmNyZWF0ZWRfYXQYCyABKAlSCWNyZWF0ZWRBdBIdCgptYXR1cmVkX2F0GAwgASgJUgltYXR1cmVkQXQ=');
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
  ],
};

/// Descriptor for `CreateLockFundsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundsRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVMb2NrRnVuZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgRuYW1lGAIgASgJUgRuYW1lEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhsKCWxvY2tfdHlwZRgEIAEoCVIIbG9ja1R5cGUSHwoLdW5sb2NrX2RhdGUYBSABKAlSCnVubG9ja0RhdGUSIwoNdGFyZ2V0X2Ftb3VudBgGIAEoAVIMdGFyZ2V0QW1vdW50EiEKDHBlbmFsdHlfcmF0ZRgHIAEoAVILcGVuYWx0eVJhdGUSEAoDcGluGAggASgJUgNwaW4=');
@$core.Deprecated('Use createLockFundsResponseDescriptor instead')
const CreateLockFundsResponse$json = const {
  '1': 'CreateLockFundsResponse',
  '2': const [
    const {'1': 'lockfunds', '3': 1, '4': 1, '5': 11, '6': '.accounts.LockFunds', '10': 'lockfunds'},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.accounts.Transaction', '10': 'transaction'},
    const {'1': 'new_available_balance', '3': 3, '4': 1, '5': 1, '10': 'newAvailableBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateLockFundsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLockFundsResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVMb2NrRnVuZHNSZXNwb25zZRIxCglsb2NrZnVuZHMYASABKAsyEy5hY2NvdW50cy5Mb2NrRnVuZHNSCWxvY2tmdW5kcxI3Cgt0cmFuc2FjdGlvbhgCIAEoCzIVLmFjY291bnRzLlRyYW5zYWN0aW9uUgt0cmFuc2FjdGlvbhIyChVuZXdfYXZhaWxhYmxlX2JhbGFuY2UYAyABKAFSE25ld0F2YWlsYWJsZUJhbGFuY2USGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
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
  ],
};

/// Descriptor for `CreateTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionRequestDescriptor = $convert.base64Decode('ChhDcmVhdGVUcmFuc2FjdGlvblJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhIKBHR5cGUYAiABKAlSBHR5cGUSGgoIY2F0ZWdvcnkYAyABKAlSCGNhdGVnb3J5EhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhIaCghtZXRhZGF0YRgGIAEoCVIIbWV0YWRhdGESIQoMc2VydmljZV9uYW1lGAcgASgJUgtzZXJ2aWNlTmFtZRIcCglyZWZlcmVuY2UYCCABKAlSCXJlZmVyZW5jZQ==');
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
  ],
};

/// Descriptor for `GetTransactionHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionHistoryRequestDescriptor = $convert.base64Decode('ChxHZXRUcmFuc2FjdGlvbkhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBISCgR0eXBlGAIgASgJUgR0eXBlEhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxIhCgxzZXJ2aWNlX25hbWUYBSABKAlSC3NlcnZpY2VOYW1lEh0KCnN0YXJ0X2RhdGUYBiABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgHIAEoCVIHZW5kRGF0ZRIUCgVsaW1pdBgIIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAkgASgFUgZvZmZzZXQ=');
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
  ],
};

/// Descriptor for `GetTransactionStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionStatisticsRequestDescriptor = $convert.base64Decode('Ch9HZXRUcmFuc2FjdGlvblN0YXRpc3RpY3NSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIdCgpzdGFydF9kYXRlGAIgASgJUglzdGFydERhdGUSGQoIZW5kX2RhdGUYAyABKAlSB2VuZERhdGU=');
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
