//
//  Generated code. Do not modify.
//  source: multi_country.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use localeAccountGroupDescriptor instead')
const LocaleAccountGroup$json = {
  '1': 'LocaleAccountGroup',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'currency_code', '3': 4, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'currency_symbol', '3': 5, '4': 1, '5': 9, '10': 'currencySymbol'},
    {'1': 'flag_emoji', '3': 6, '4': 1, '5': 9, '10': 'flagEmoji'},
    {'1': 'accounts', '3': 7, '4': 3, '5': 11, '6': '.accounts.Account', '10': 'accounts'},
    {'1': 'total_balance', '3': 8, '4': 1, '5': 1, '10': 'totalBalance'},
    {'1': 'has_accounts', '3': 9, '4': 1, '5': 8, '10': 'hasAccounts'},
    {'1': 'is_signup_locale', '3': 10, '4': 1, '5': 8, '10': 'isSignupLocale'},
  ],
};

/// Descriptor for `LocaleAccountGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List localeAccountGroupDescriptor = $convert.base64Decode(
    'ChJMb2NhbGVBY2NvdW50R3JvdXASFgoGbG9jYWxlGAEgASgJUgZsb2NhbGUSIQoMY291bnRyeV'
    '9jb2RlGAIgASgJUgtjb3VudHJ5Q29kZRIhCgxjb3VudHJ5X25hbWUYAyABKAlSC2NvdW50cnlO'
    'YW1lEiMKDWN1cnJlbmN5X2NvZGUYBCABKAlSDGN1cnJlbmN5Q29kZRInCg9jdXJyZW5jeV9zeW'
    '1ib2wYBSABKAlSDmN1cnJlbmN5U3ltYm9sEh0KCmZsYWdfZW1vamkYBiABKAlSCWZsYWdFbW9q'
    'aRItCghhY2NvdW50cxgHIAMoCzIRLmFjY291bnRzLkFjY291bnRSCGFjY291bnRzEiMKDXRvdG'
    'FsX2JhbGFuY2UYCCABKAFSDHRvdGFsQmFsYW5jZRIhCgxoYXNfYWNjb3VudHMYCSABKAhSC2hh'
    'c0FjY291bnRzEigKEGlzX3NpZ251cF9sb2NhbGUYCiABKAhSDmlzU2lnbnVwTG9jYWxl');

@$core.Deprecated('Use getAccountsByLocaleRequestDescriptor instead')
const GetAccountsByLocaleRequest$json = {
  '1': 'GetAccountsByLocaleRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetAccountsByLocaleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsByLocaleRequestDescriptor = $convert.base64Decode(
    'ChpHZXRBY2NvdW50c0J5TG9jYWxlUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use getAccountsByLocaleResponseDescriptor instead')
const GetAccountsByLocaleResponse$json = {
  '1': 'GetAccountsByLocaleResponse',
  '2': [
    {'1': 'locales', '3': 1, '4': 3, '5': 11, '6': '.accounts.LocaleAccountGroup', '10': 'locales'},
    {'1': 'active_locale', '3': 2, '4': 1, '5': 9, '10': 'activeLocale'},
    {'1': 'signup_locale', '3': 3, '4': 1, '5': 9, '10': 'signupLocale'},
    {'1': 'total_locales', '3': 4, '4': 1, '5': 5, '10': 'totalLocales'},
    {'1': 'locales_with_accounts', '3': 5, '4': 1, '5': 5, '10': 'localesWithAccounts'},
  ],
};

/// Descriptor for `GetAccountsByLocaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountsByLocaleResponseDescriptor = $convert.base64Decode(
    'ChtHZXRBY2NvdW50c0J5TG9jYWxlUmVzcG9uc2USNgoHbG9jYWxlcxgBIAMoCzIcLmFjY291bn'
    'RzLkxvY2FsZUFjY291bnRHcm91cFIHbG9jYWxlcxIjCg1hY3RpdmVfbG9jYWxlGAIgASgJUgxh'
    'Y3RpdmVMb2NhbGUSIwoNc2lnbnVwX2xvY2FsZRgDIAEoCVIMc2lnbnVwTG9jYWxlEiMKDXRvdG'
    'FsX2xvY2FsZXMYBCABKAVSDHRvdGFsTG9jYWxlcxIyChVsb2NhbGVzX3dpdGhfYWNjb3VudHMY'
    'BSABKAVSE2xvY2FsZXNXaXRoQWNjb3VudHM=');

@$core.Deprecated('Use createLocaleAccountRequestDescriptor instead')
const CreateLocaleAccountRequest$json = {
  '1': 'CreateLocaleAccountRequest',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'account_type', '3': 2, '4': 1, '5': 9, '10': 'accountType'},
    {'1': 'account_name', '3': 3, '4': 1, '5': 9, '10': 'accountName'},
  ],
};

/// Descriptor for `CreateLocaleAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLocaleAccountRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVMb2NhbGVBY2NvdW50UmVxdWVzdBIWCgZsb2NhbGUYASABKAlSBmxvY2FsZRIhCg'
    'xhY2NvdW50X3R5cGUYAiABKAlSC2FjY291bnRUeXBlEiEKDGFjY291bnRfbmFtZRgDIAEoCVIL'
    'YWNjb3VudE5hbWU=');

@$core.Deprecated('Use createLocaleAccountResponseDescriptor instead')
const CreateLocaleAccountResponse$json = {
  '1': 'CreateLocaleAccountResponse',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.accounts.Account', '10': 'account'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'created', '3': 3, '4': 1, '5': 8, '10': 'created'},
  ],
};

/// Descriptor for `CreateLocaleAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLocaleAccountResponseDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVMb2NhbGVBY2NvdW50UmVzcG9uc2USKwoHYWNjb3VudBgBIAEoCzIRLmFjY291bn'
    'RzLkFjY291bnRSB2FjY291bnQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIYCgdjcmVhdGVk'
    'GAMgASgIUgdjcmVhdGVk');

@$core.Deprecated('Use supportedLocaleDescriptor instead')
const SupportedLocale$json = {
  '1': 'SupportedLocale',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'currency_code', '3': 4, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'currency_symbol', '3': 5, '4': 1, '5': 9, '10': 'currencySymbol'},
    {'1': 'flag_emoji', '3': 6, '4': 1, '5': 9, '10': 'flagEmoji'},
    {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'is_beta', '3': 8, '4': 1, '5': 8, '10': 'isBeta'},
    {'1': 'available_account_types', '3': 9, '4': 3, '5': 9, '10': 'availableAccountTypes'},
    {'1': 'user_has_account', '3': 10, '4': 1, '5': 8, '10': 'userHasAccount'},
  ],
};

/// Descriptor for `SupportedLocale`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List supportedLocaleDescriptor = $convert.base64Decode(
    'Cg9TdXBwb3J0ZWRMb2NhbGUSFgoGbG9jYWxlGAEgASgJUgZsb2NhbGUSIQoMY291bnRyeV9jb2'
    'RlGAIgASgJUgtjb3VudHJ5Q29kZRIhCgxjb3VudHJ5X25hbWUYAyABKAlSC2NvdW50cnlOYW1l'
    'EiMKDWN1cnJlbmN5X2NvZGUYBCABKAlSDGN1cnJlbmN5Q29kZRInCg9jdXJyZW5jeV9zeW1ib2'
    'wYBSABKAlSDmN1cnJlbmN5U3ltYm9sEh0KCmZsYWdfZW1vamkYBiABKAlSCWZsYWdFbW9qaRIb'
    'Cglpc19hY3RpdmUYByABKAhSCGlzQWN0aXZlEhcKB2lzX2JldGEYCCABKAhSBmlzQmV0YRI2Ch'
    'dhdmFpbGFibGVfYWNjb3VudF90eXBlcxgJIAMoCVIVYXZhaWxhYmxlQWNjb3VudFR5cGVzEigK'
    'EHVzZXJfaGFzX2FjY291bnQYCiABKAhSDnVzZXJIYXNBY2NvdW50');

@$core.Deprecated('Use getSupportedLocalesRequestDescriptor instead')
const GetSupportedLocalesRequest$json = {
  '1': 'GetSupportedLocalesRequest',
};

/// Descriptor for `GetSupportedLocalesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedLocalesRequestDescriptor = $convert.base64Decode(
    'ChpHZXRTdXBwb3J0ZWRMb2NhbGVzUmVxdWVzdA==');

@$core.Deprecated('Use getSupportedLocalesResponseDescriptor instead')
const GetSupportedLocalesResponse$json = {
  '1': 'GetSupportedLocalesResponse',
  '2': [
    {'1': 'locales', '3': 1, '4': 3, '5': 11, '6': '.accounts.SupportedLocale', '10': 'locales'},
  ],
};

/// Descriptor for `GetSupportedLocalesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedLocalesResponseDescriptor = $convert.base64Decode(
    'ChtHZXRTdXBwb3J0ZWRMb2NhbGVzUmVzcG9uc2USMwoHbG9jYWxlcxgBIAMoCzIZLmFjY291bn'
    'RzLlN1cHBvcnRlZExvY2FsZVIHbG9jYWxlcw==');

@$core.Deprecated('Use getUserLocaleRequestDescriptor instead')
const GetUserLocaleRequest$json = {
  '1': 'GetUserLocaleRequest',
};

/// Descriptor for `GetUserLocaleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserLocaleRequestDescriptor = $convert.base64Decode(
    'ChRHZXRVc2VyTG9jYWxlUmVxdWVzdA==');

@$core.Deprecated('Use getUserLocaleResponseDescriptor instead')
const GetUserLocaleResponse$json = {
  '1': 'GetUserLocaleResponse',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'currency_code', '3': 3, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'signup_locale', '3': 4, '4': 1, '5': 9, '10': 'signupLocale'},
  ],
};

/// Descriptor for `GetUserLocaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserLocaleResponseDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyTG9jYWxlUmVzcG9uc2USFgoGbG9jYWxlGAEgASgJUgZsb2NhbGUSIQoMY291bn'
    'RyeV9jb2RlGAIgASgJUgtjb3VudHJ5Q29kZRIjCg1jdXJyZW5jeV9jb2RlGAMgASgJUgxjdXJy'
    'ZW5jeUNvZGUSIwoNc2lnbnVwX2xvY2FsZRgEIAEoCVIMc2lnbnVwTG9jYWxl');

@$core.Deprecated('Use setUserLocaleRequestDescriptor instead')
const SetUserLocaleRequest$json = {
  '1': 'SetUserLocaleRequest',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `SetUserLocaleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setUserLocaleRequestDescriptor = $convert.base64Decode(
    'ChRTZXRVc2VyTG9jYWxlUmVxdWVzdBIWCgZsb2NhbGUYASABKAlSBmxvY2FsZQ==');

@$core.Deprecated('Use setUserLocaleResponseDescriptor instead')
const SetUserLocaleResponse$json = {
  '1': 'SetUserLocaleResponse',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SetUserLocaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setUserLocaleResponseDescriptor = $convert.base64Decode(
    'ChVTZXRVc2VyTG9jYWxlUmVzcG9uc2USFgoGbG9jYWxlGAEgASgJUgZsb2NhbGUSGAoHbWVzc2'
    'FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use triggerMultiCountryCreationRequestDescriptor instead')
const TriggerMultiCountryCreationRequest$json = {
  '1': 'TriggerMultiCountryCreationRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'signup_locale', '3': 2, '4': 1, '5': 9, '10': 'signupLocale'},
  ],
};

/// Descriptor for `TriggerMultiCountryCreationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerMultiCountryCreationRequestDescriptor = $convert.base64Decode(
    'CiJUcmlnZ2VyTXVsdGlDb3VudHJ5Q3JlYXRpb25SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBn'
    'VzZXJJZBIjCg1zaWdudXBfbG9jYWxlGAIgASgJUgxzaWdudXBMb2NhbGU=');

@$core.Deprecated('Use triggerMultiCountryCreationResponseDescriptor instead')
const TriggerMultiCountryCreationResponse$json = {
  '1': 'TriggerMultiCountryCreationResponse',
  '2': [
    {'1': 'triggered', '3': 1, '4': 1, '5': 8, '10': 'triggered'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'job_id', '3': 3, '4': 1, '5': 9, '10': 'jobId'},
  ],
};

/// Descriptor for `TriggerMultiCountryCreationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List triggerMultiCountryCreationResponseDescriptor = $convert.base64Decode(
    'CiNUcmlnZ2VyTXVsdGlDb3VudHJ5Q3JlYXRpb25SZXNwb25zZRIcCgl0cmlnZ2VyZWQYASABKA'
    'hSCXRyaWdnZXJlZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEhUKBmpvYl9pZBgDIAEoCVIF'
    'am9iSWQ=');

@$core.Deprecated('Use localeAccountCreationStatusDescriptor instead')
const LocaleAccountCreationStatus$json = {
  '1': 'LocaleAccountCreationStatus',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `LocaleAccountCreationStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List localeAccountCreationStatusDescriptor = $convert.base64Decode(
    'ChtMb2NhbGVBY2NvdW50Q3JlYXRpb25TdGF0dXMSFgoGbG9jYWxlGAEgASgJUgZsb2NhbGUSIQ'
    'oMY291bnRyeV9jb2RlGAIgASgJUgtjb3VudHJ5Q29kZRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1'
    'cxIjCg1lcnJvcl9tZXNzYWdlGAQgASgJUgxlcnJvck1lc3NhZ2USOQoKY3JlYXRlZF9hdBgFIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9Cgxjb21wbGV0ZWRf'
    'YXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtjb21wbGV0ZWRBdA==');

@$core.Deprecated('Use getAccountCreationStatusRequestDescriptor instead')
const GetAccountCreationStatusRequest$json = {
  '1': 'GetAccountCreationStatusRequest',
  '2': [
    {'1': 'job_id', '3': 1, '4': 1, '5': 9, '10': 'jobId'},
  ],
};

/// Descriptor for `GetAccountCreationStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCreationStatusRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRBY2NvdW50Q3JlYXRpb25TdGF0dXNSZXF1ZXN0EhUKBmpvYl9pZBgBIAEoCVIFam9iSW'
    'Q=');

@$core.Deprecated('Use getAccountCreationStatusResponseDescriptor instead')
const GetAccountCreationStatusResponse$json = {
  '1': 'GetAccountCreationStatusResponse',
  '2': [
    {'1': 'overall_status', '3': 1, '4': 1, '5': 9, '10': 'overallStatus'},
    {'1': 'total_locales', '3': 2, '4': 1, '5': 5, '10': 'totalLocales'},
    {'1': 'completed_locales', '3': 3, '4': 1, '5': 5, '10': 'completedLocales'},
    {'1': 'locale_statuses', '3': 4, '4': 3, '5': 11, '6': '.accounts.LocaleAccountCreationStatus', '10': 'localeStatuses'},
  ],
};

/// Descriptor for `GetAccountCreationStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCreationStatusResponseDescriptor = $convert.base64Decode(
    'CiBHZXRBY2NvdW50Q3JlYXRpb25TdGF0dXNSZXNwb25zZRIlCg5vdmVyYWxsX3N0YXR1cxgBIA'
    'EoCVINb3ZlcmFsbFN0YXR1cxIjCg10b3RhbF9sb2NhbGVzGAIgASgFUgx0b3RhbExvY2FsZXMS'
    'KwoRY29tcGxldGVkX2xvY2FsZXMYAyABKAVSEGNvbXBsZXRlZExvY2FsZXMSTgoPbG9jYWxlX3'
    'N0YXR1c2VzGAQgAygLMiUuYWNjb3VudHMuTG9jYWxlQWNjb3VudENyZWF0aW9uU3RhdHVzUg5s'
    'b2NhbGVTdGF0dXNlcw==');

