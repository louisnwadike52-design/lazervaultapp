///
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use createTransactionPinRequestDescriptor instead')
const CreateTransactionPinRequest$json = const {
  '1': 'CreateTransactionPinRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'confirm_pin', '3': 3, '4': 1, '5': 9, '10': 'confirmPin'},
    const {'1': 'device_id', '3': 4, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'device_name', '3': 5, '4': 1, '5': 9, '10': 'deviceName'},
  ],
};

/// Descriptor for `CreateTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionPinRequestDescriptor = $convert.base64Decode('ChtDcmVhdGVUcmFuc2FjdGlvblBpblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhAKA3BpbhgCIAEoCVIDcGluEh8KC2NvbmZpcm1fcGluGAMgASgJUgpjb25maXJtUGluEhsKCWRldmljZV9pZBgEIAEoCVIIZGV2aWNlSWQSHwoLZGV2aWNlX25hbWUYBSABKAlSCmRldmljZU5hbWU=');
@$core.Deprecated('Use createTransactionPinResponseDescriptor instead')
const CreateTransactionPinResponse$json = const {
  '1': 'CreateTransactionPinResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'pin_details', '3': 3, '4': 1, '5': 11, '6': '.auth.TransactionPinDetails', '10': 'pinDetails'},
  ],
};

/// Descriptor for `CreateTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionPinResponseDescriptor = $convert.base64Decode('ChxDcmVhdGVUcmFuc2FjdGlvblBpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI8CgtwaW5fZGV0YWlscxgDIAEoCzIbLmF1dGguVHJhbnNhY3Rpb25QaW5EZXRhaWxzUgpwaW5EZXRhaWxz');
@$core.Deprecated('Use verifyTransactionPinRequestDescriptor instead')
const VerifyTransactionPinRequest$json = const {
  '1': 'VerifyTransactionPinRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'transaction_type', '3': 4, '4': 1, '5': 9, '10': 'transactionType'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'device_id', '3': 7, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `VerifyTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTransactionPinRequestDescriptor = $convert.base64Decode('ChtWZXJpZnlUcmFuc2FjdGlvblBpblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhAKA3BpbhgCIAEoCVIDcGluEiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklkEikKEHRyYW5zYWN0aW9uX3R5cGUYBCABKAlSD3RyYW5zYWN0aW9uVHlwZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSGwoJZGV2aWNlX2lkGAcgASgJUghkZXZpY2VJZA==');
@$core.Deprecated('Use verifyTransactionPinResponseDescriptor instead')
const VerifyTransactionPinResponse$json = const {
  '1': 'VerifyTransactionPinResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'verification_token', '3': 3, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'expires_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'remaining_attempts', '3': 5, '4': 1, '5': 5, '10': 'remainingAttempts'},
    const {'1': 'is_locked', '3': 6, '4': 1, '5': 8, '10': 'isLocked'},
  ],
};

/// Descriptor for `VerifyTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTransactionPinResponseDescriptor = $convert.base64Decode('ChxWZXJpZnlUcmFuc2FjdGlvblBpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRItChJ2ZXJpZmljYXRpb25fdG9rZW4YAyABKAlSEXZlcmlmaWNhdGlvblRva2VuEjkKCmV4cGlyZXNfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQSLQoScmVtYWluaW5nX2F0dGVtcHRzGAUgASgFUhFyZW1haW5pbmdBdHRlbXB0cxIbCglpc19sb2NrZWQYBiABKAhSCGlzTG9ja2Vk');
@$core.Deprecated('Use changeTransactionPinRequestDescriptor instead')
const ChangeTransactionPinRequest$json = const {
  '1': 'ChangeTransactionPinRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'current_pin', '3': 2, '4': 1, '5': 9, '10': 'currentPin'},
    const {'1': 'new_pin', '3': 3, '4': 1, '5': 9, '10': 'newPin'},
    const {'1': 'confirm_new_pin', '3': 4, '4': 1, '5': 9, '10': 'confirmNewPin'},
  ],
};

/// Descriptor for `ChangeTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeTransactionPinRequestDescriptor = $convert.base64Decode('ChtDaGFuZ2VUcmFuc2FjdGlvblBpblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh8KC2N1cnJlbnRfcGluGAIgASgJUgpjdXJyZW50UGluEhcKB25ld19waW4YAyABKAlSBm5ld1BpbhImCg9jb25maXJtX25ld19waW4YBCABKAlSDWNvbmZpcm1OZXdQaW4=');
@$core.Deprecated('Use changeTransactionPinResponseDescriptor instead')
const ChangeTransactionPinResponse$json = const {
  '1': 'ChangeTransactionPinResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ChangeTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeTransactionPinResponseDescriptor = $convert.base64Decode('ChxDaGFuZ2VUcmFuc2FjdGlvblBpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use resetTransactionPinRequestDescriptor instead')
const ResetTransactionPinRequest$json = const {
  '1': 'ResetTransactionPinRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'verification_method', '3': 2, '4': 1, '5': 9, '10': 'verificationMethod'},
    const {'1': 'verification_code', '3': 3, '4': 1, '5': 9, '10': 'verificationCode'},
    const {'1': 'new_pin', '3': 4, '4': 1, '5': 9, '10': 'newPin'},
    const {'1': 'confirm_new_pin', '3': 5, '4': 1, '5': 9, '10': 'confirmNewPin'},
  ],
};

/// Descriptor for `ResetTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetTransactionPinRequestDescriptor = $convert.base64Decode('ChpSZXNldFRyYW5zYWN0aW9uUGluUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSLwoTdmVyaWZpY2F0aW9uX21ldGhvZBgCIAEoCVISdmVyaWZpY2F0aW9uTWV0aG9kEisKEXZlcmlmaWNhdGlvbl9jb2RlGAMgASgJUhB2ZXJpZmljYXRpb25Db2RlEhcKB25ld19waW4YBCABKAlSBm5ld1BpbhImCg9jb25maXJtX25ld19waW4YBSABKAlSDWNvbmZpcm1OZXdQaW4=');
@$core.Deprecated('Use resetTransactionPinResponseDescriptor instead')
const ResetTransactionPinResponse$json = const {
  '1': 'ResetTransactionPinResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResetTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetTransactionPinResponseDescriptor = $convert.base64Decode('ChtSZXNldFRyYW5zYWN0aW9uUGluUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use checkUserHasPinRequestDescriptor instead')
const CheckUserHasPinRequest$json = const {
  '1': 'CheckUserHasPinRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `CheckUserHasPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkUserHasPinRequestDescriptor = $convert.base64Decode('ChZDaGVja1VzZXJIYXNQaW5SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
@$core.Deprecated('Use checkUserHasPinResponseDescriptor instead')
const CheckUserHasPinResponse$json = const {
  '1': 'CheckUserHasPinResponse',
  '2': const [
    const {'1': 'has_pin', '3': 1, '4': 1, '5': 8, '10': 'hasPin'},
    const {'1': 'is_active', '3': 2, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'created_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'last_changed_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastChangedAt'},
  ],
};

/// Descriptor for `CheckUserHasPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkUserHasPinResponseDescriptor = $convert.base64Decode('ChdDaGVja1VzZXJIYXNQaW5SZXNwb25zZRIXCgdoYXNfcGluGAEgASgIUgZoYXNQaW4SGwoJaXNfYWN0aXZlGAIgASgIUghpc0FjdGl2ZRI5CgpjcmVhdGVkX2F0GAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EkIKD2xhc3RfY2hhbmdlZF9hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDWxhc3RDaGFuZ2VkQXQ=');
@$core.Deprecated('Use validateTransactionPinTokenRequestDescriptor instead')
const ValidateTransactionPinTokenRequest$json = const {
  '1': 'ValidateTransactionPinTokenRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `ValidateTransactionPinTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTransactionPinTokenRequestDescriptor = $convert.base64Decode('CiJWYWxpZGF0ZVRyYW5zYWN0aW9uUGluVG9rZW5SZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2tlbhIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOdHJhbnNhY3Rpb25faWQYAyABKAlSDXRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use validateTransactionPinTokenResponseDescriptor instead')
const ValidateTransactionPinTokenResponse$json = const {
  '1': 'ValidateTransactionPinTokenResponse',
  '2': const [
    const {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'expires_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
  ],
};

/// Descriptor for `ValidateTransactionPinTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTransactionPinTokenResponseDescriptor = $convert.base64Decode('CiNWYWxpZGF0ZVRyYW5zYWN0aW9uUGluVG9rZW5SZXNwb25zZRIUCgV2YWxpZBgBIAEoCFIFdmFsaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklkEjkKCmV4cGlyZXNfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQ=');
@$core.Deprecated('Use transactionPinDetailsDescriptor instead')
const TransactionPinDetails$json = const {
  '1': 'TransactionPinDetails',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'is_active', '3': 3, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'last_used_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
    const {'1': 'failed_attempts', '3': 7, '4': 1, '5': 5, '10': 'failedAttempts'},
    const {'1': 'is_locked', '3': 8, '4': 1, '5': 8, '10': 'isLocked'},
    const {'1': 'locked_until', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lockedUntil'},
  ],
};

/// Descriptor for `TransactionPinDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionPinDetailsDescriptor = $convert.base64Decode('ChVUcmFuc2FjdGlvblBpbkRldGFpbHMSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIbCglpc19hY3RpdmUYAyABKAhSCGlzQWN0aXZlEjkKCmNyZWF0ZWRfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBI8CgxsYXN0X3VzZWRfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpsYXN0VXNlZEF0EicKD2ZhaWxlZF9hdHRlbXB0cxgHIAEoBVIOZmFpbGVkQXR0ZW1wdHMSGwoJaXNfbG9ja2VkGAggASgIUghpc0xvY2tlZBI9Cgxsb2NrZWRfdW50aWwYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsb2NrZWRVbnRpbA==');
@$core.Deprecated('Use pinConfigDescriptor instead')
const PinConfig$json = const {
  '1': 'PinConfig',
  '2': const [
    const {'1': 'min_length', '3': 1, '4': 1, '5': 5, '10': 'minLength'},
    const {'1': 'max_length', '3': 2, '4': 1, '5': 5, '10': 'maxLength'},
    const {'1': 'max_attempts', '3': 3, '4': 1, '5': 5, '10': 'maxAttempts'},
    const {'1': 'lockout_duration_minutes', '3': 4, '4': 1, '5': 5, '10': 'lockoutDurationMinutes'},
    const {'1': 'token_expiry_minutes', '3': 5, '4': 1, '5': 5, '10': 'tokenExpiryMinutes'},
  ],
};

/// Descriptor for `PinConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pinConfigDescriptor = $convert.base64Decode('CglQaW5Db25maWcSHQoKbWluX2xlbmd0aBgBIAEoBVIJbWluTGVuZ3RoEh0KCm1heF9sZW5ndGgYAiABKAVSCW1heExlbmd0aBIhCgxtYXhfYXR0ZW1wdHMYAyABKAVSC21heEF0dGVtcHRzEjgKGGxvY2tvdXRfZHVyYXRpb25fbWludXRlcxgEIAEoBVIWbG9ja291dER1cmF0aW9uTWludXRlcxIwChR0b2tlbl9leHBpcnlfbWludXRlcxgFIAEoBVISdG9rZW5FeHBpcnlNaW51dGVz');
