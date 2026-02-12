//
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use createTransactionPinRequestDescriptor instead')
const CreateTransactionPinRequest$json = {
  '1': 'CreateTransactionPinRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'confirm_pin', '3': 3, '4': 1, '5': 9, '10': 'confirmPin'},
    {'1': 'device_id', '3': 4, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 5, '4': 1, '5': 9, '10': 'deviceName'},
  ],
};

/// Descriptor for `CreateTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionPinRequestDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVUcmFuc2FjdGlvblBpblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh'
    'AKA3BpbhgCIAEoCVIDcGluEh8KC2NvbmZpcm1fcGluGAMgASgJUgpjb25maXJtUGluEhsKCWRl'
    'dmljZV9pZBgEIAEoCVIIZGV2aWNlSWQSHwoLZGV2aWNlX25hbWUYBSABKAlSCmRldmljZU5hbW'
    'U=');

@$core.Deprecated('Use createTransactionPinResponseDescriptor instead')
const CreateTransactionPinResponse$json = {
  '1': 'CreateTransactionPinResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'pin_details', '3': 3, '4': 1, '5': 11, '6': '.auth.TransactionPinDetails', '10': 'pinDetails'},
  ],
};

/// Descriptor for `CreateTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTransactionPinResponseDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVUcmFuc2FjdGlvblBpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI8CgtwaW5fZGV0YWlscxgDIAEoCzIbLmF1dGgu'
    'VHJhbnNhY3Rpb25QaW5EZXRhaWxzUgpwaW5EZXRhaWxz');

@$core.Deprecated('Use verifyTransactionPinRequestDescriptor instead')
const VerifyTransactionPinRequest$json = {
  '1': 'VerifyTransactionPinRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'transaction_type', '3': 4, '4': 1, '5': 9, '10': 'transactionType'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'device_id', '3': 7, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `VerifyTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTransactionPinRequestDescriptor = $convert.base64Decode(
    'ChtWZXJpZnlUcmFuc2FjdGlvblBpblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh'
    'AKA3BpbhgCIAEoCVIDcGluEiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklk'
    'EikKEHRyYW5zYWN0aW9uX3R5cGUYBCABKAlSD3RyYW5zYWN0aW9uVHlwZRIWCgZhbW91bnQYBS'
    'ABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSGwoJZGV2aWNlX2lkGAcg'
    'ASgJUghkZXZpY2VJZA==');

@$core.Deprecated('Use verifyTransactionPinResponseDescriptor instead')
const VerifyTransactionPinResponse$json = {
  '1': 'VerifyTransactionPinResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'verification_token', '3': 3, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'expires_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    {'1': 'remaining_attempts', '3': 5, '4': 1, '5': 5, '10': 'remainingAttempts'},
    {'1': 'is_locked', '3': 6, '4': 1, '5': 8, '10': 'isLocked'},
  ],
};

/// Descriptor for `VerifyTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyTransactionPinResponseDescriptor = $convert.base64Decode(
    'ChxWZXJpZnlUcmFuc2FjdGlvblBpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRItChJ2ZXJpZmljYXRpb25fdG9rZW4YAyABKAlS'
    'EXZlcmlmaWNhdGlvblRva2VuEjkKCmV4cGlyZXNfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wUglleHBpcmVzQXQSLQoScmVtYWluaW5nX2F0dGVtcHRzGAUgASgFUhFyZW1h'
    'aW5pbmdBdHRlbXB0cxIbCglpc19sb2NrZWQYBiABKAhSCGlzTG9ja2Vk');

@$core.Deprecated('Use changeTransactionPinRequestDescriptor instead')
const ChangeTransactionPinRequest$json = {
  '1': 'ChangeTransactionPinRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'current_pin', '3': 2, '4': 1, '5': 9, '10': 'currentPin'},
    {'1': 'new_pin', '3': 3, '4': 1, '5': 9, '10': 'newPin'},
    {'1': 'confirm_new_pin', '3': 4, '4': 1, '5': 9, '10': 'confirmNewPin'},
  ],
};

/// Descriptor for `ChangeTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeTransactionPinRequestDescriptor = $convert.base64Decode(
    'ChtDaGFuZ2VUcmFuc2FjdGlvblBpblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEh'
    '8KC2N1cnJlbnRfcGluGAIgASgJUgpjdXJyZW50UGluEhcKB25ld19waW4YAyABKAlSBm5ld1Bp'
    'bhImCg9jb25maXJtX25ld19waW4YBCABKAlSDWNvbmZpcm1OZXdQaW4=');

@$core.Deprecated('Use changeTransactionPinResponseDescriptor instead')
const ChangeTransactionPinResponse$json = {
  '1': 'ChangeTransactionPinResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ChangeTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeTransactionPinResponseDescriptor = $convert.base64Decode(
    'ChxDaGFuZ2VUcmFuc2FjdGlvblBpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use resetTransactionPinRequestDescriptor instead')
const ResetTransactionPinRequest$json = {
  '1': 'ResetTransactionPinRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'verification_method', '3': 2, '4': 1, '5': 9, '10': 'verificationMethod'},
    {'1': 'verification_code', '3': 3, '4': 1, '5': 9, '10': 'verificationCode'},
    {'1': 'new_pin', '3': 4, '4': 1, '5': 9, '10': 'newPin'},
    {'1': 'confirm_new_pin', '3': 5, '4': 1, '5': 9, '10': 'confirmNewPin'},
  ],
};

/// Descriptor for `ResetTransactionPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetTransactionPinRequestDescriptor = $convert.base64Decode(
    'ChpSZXNldFRyYW5zYWN0aW9uUGluUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSLw'
    'oTdmVyaWZpY2F0aW9uX21ldGhvZBgCIAEoCVISdmVyaWZpY2F0aW9uTWV0aG9kEisKEXZlcmlm'
    'aWNhdGlvbl9jb2RlGAMgASgJUhB2ZXJpZmljYXRpb25Db2RlEhcKB25ld19waW4YBCABKAlSBm'
    '5ld1BpbhImCg9jb25maXJtX25ld19waW4YBSABKAlSDWNvbmZpcm1OZXdQaW4=');

@$core.Deprecated('Use resetTransactionPinResponseDescriptor instead')
const ResetTransactionPinResponse$json = {
  '1': 'ResetTransactionPinResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResetTransactionPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetTransactionPinResponseDescriptor = $convert.base64Decode(
    'ChtSZXNldFRyYW5zYWN0aW9uUGluUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use checkUserHasPinRequestDescriptor instead')
const CheckUserHasPinRequest$json = {
  '1': 'CheckUserHasPinRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `CheckUserHasPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkUserHasPinRequestDescriptor = $convert.base64Decode(
    'ChZDaGVja1VzZXJIYXNQaW5SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use checkUserHasPinResponseDescriptor instead')
const CheckUserHasPinResponse$json = {
  '1': 'CheckUserHasPinResponse',
  '2': [
    {'1': 'has_pin', '3': 1, '4': 1, '5': 8, '10': 'hasPin'},
    {'1': 'is_active', '3': 2, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'last_changed_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastChangedAt'},
  ],
};

/// Descriptor for `CheckUserHasPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkUserHasPinResponseDescriptor = $convert.base64Decode(
    'ChdDaGVja1VzZXJIYXNQaW5SZXNwb25zZRIXCgdoYXNfcGluGAEgASgIUgZoYXNQaW4SGwoJaX'
    'NfYWN0aXZlGAIgASgIUghpc0FjdGl2ZRI5CgpjcmVhdGVkX2F0GAMgASgLMhouZ29vZ2xlLnBy'
    'b3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EkIKD2xhc3RfY2hhbmdlZF9hdBgEIAEoCzIaLm'
    'dvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDWxhc3RDaGFuZ2VkQXQ=');

@$core.Deprecated('Use validateTransactionPinTokenRequestDescriptor instead')
const ValidateTransactionPinTokenRequest$json = {
  '1': 'ValidateTransactionPinTokenRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `ValidateTransactionPinTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTransactionPinTokenRequestDescriptor = $convert.base64Decode(
    'CiJWYWxpZGF0ZVRyYW5zYWN0aW9uUGluVG9rZW5SZXF1ZXN0EhQKBXRva2VuGAEgASgJUgV0b2'
    'tlbhIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOdHJhbnNhY3Rpb25faWQYAyABKAlSDXRy'
    'YW5zYWN0aW9uSWQ=');

@$core.Deprecated('Use validateTransactionPinTokenResponseDescriptor instead')
const ValidateTransactionPinTokenResponse$json = {
  '1': 'ValidateTransactionPinTokenResponse',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'expires_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
  ],
};

/// Descriptor for `ValidateTransactionPinTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateTransactionPinTokenResponseDescriptor = $convert.base64Decode(
    'CiNWYWxpZGF0ZVRyYW5zYWN0aW9uUGluVG9rZW5SZXNwb25zZRIUCgV2YWxpZBgBIAEoCFIFdm'
    'FsaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10'
    'cmFuc2FjdGlvbklkEjkKCmV4cGlyZXNfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZX'
    'N0YW1wUglleHBpcmVzQXQ=');

@$core.Deprecated('Use transactionPinDetailsDescriptor instead')
const TransactionPinDetails$json = {
  '1': 'TransactionPinDetails',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'is_active', '3': 3, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'last_used_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
    {'1': 'failed_attempts', '3': 7, '4': 1, '5': 5, '10': 'failedAttempts'},
    {'1': 'is_locked', '3': 8, '4': 1, '5': 8, '10': 'isLocked'},
    {'1': 'locked_until', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lockedUntil'},
  ],
};

/// Descriptor for `TransactionPinDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionPinDetailsDescriptor = $convert.base64Decode(
    'ChVUcmFuc2FjdGlvblBpbkRldGFpbHMSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKA'
    'lSBnVzZXJJZBIbCglpc19hY3RpdmUYAyABKAhSCGlzQWN0aXZlEjkKCmNyZWF0ZWRfYXQYBCAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdB'
    'gFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBI8CgxsYXN0X3Vz'
    'ZWRfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpsYXN0VXNlZEF0EicKD2'
    'ZhaWxlZF9hdHRlbXB0cxgHIAEoBVIOZmFpbGVkQXR0ZW1wdHMSGwoJaXNfbG9ja2VkGAggASgI'
    'Ughpc0xvY2tlZBI9Cgxsb2NrZWRfdW50aWwYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZX'
    'N0YW1wUgtsb2NrZWRVbnRpbA==');

@$core.Deprecated('Use pinConfigDescriptor instead')
const PinConfig$json = {
  '1': 'PinConfig',
  '2': [
    {'1': 'min_length', '3': 1, '4': 1, '5': 5, '10': 'minLength'},
    {'1': 'max_length', '3': 2, '4': 1, '5': 5, '10': 'maxLength'},
    {'1': 'max_attempts', '3': 3, '4': 1, '5': 5, '10': 'maxAttempts'},
    {'1': 'lockout_duration_minutes', '3': 4, '4': 1, '5': 5, '10': 'lockoutDurationMinutes'},
    {'1': 'token_expiry_minutes', '3': 5, '4': 1, '5': 5, '10': 'tokenExpiryMinutes'},
  ],
};

/// Descriptor for `PinConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pinConfigDescriptor = $convert.base64Decode(
    'CglQaW5Db25maWcSHQoKbWluX2xlbmd0aBgBIAEoBVIJbWluTGVuZ3RoEh0KCm1heF9sZW5ndG'
    'gYAiABKAVSCW1heExlbmd0aBIhCgxtYXhfYXR0ZW1wdHMYAyABKAVSC21heEF0dGVtcHRzEjgK'
    'GGxvY2tvdXRfZHVyYXRpb25fbWludXRlcxgEIAEoBVIWbG9ja291dER1cmF0aW9uTWludXRlcx'
    'IwChR0b2tlbl9leHBpcnlfbWludXRlcxgFIAEoBVISdG9rZW5FeHBpcnlNaW51dGVz');

@$core.Deprecated('Use initiatePinOTPRequestDescriptor instead')
const InitiatePinOTPRequest$json = {
  '1': 'InitiatePinOTPRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'operation_type', '3': 2, '4': 1, '5': 9, '10': 'operationType'},
    {'1': 'channel', '3': 3, '4': 1, '5': 9, '10': 'channel'},
    {'1': 'device_id', '3': 4, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `InitiatePinOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiatePinOTPRequestDescriptor = $convert.base64Decode(
    'ChVJbml0aWF0ZVBpbk9UUFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiUKDm9wZX'
    'JhdGlvbl90eXBlGAIgASgJUg1vcGVyYXRpb25UeXBlEhgKB2NoYW5uZWwYAyABKAlSB2NoYW5u'
    'ZWwSGwoJZGV2aWNlX2lkGAQgASgJUghkZXZpY2VJZA==');

@$core.Deprecated('Use initiatePinOTPResponseDescriptor instead')
const InitiatePinOTPResponse$json = {
  '1': 'InitiatePinOTPResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'channel', '3': 3, '4': 1, '5': 9, '10': 'channel'},
    {'1': 'masked_destination', '3': 4, '4': 1, '5': 9, '10': 'maskedDestination'},
    {'1': 'expires_in_seconds', '3': 5, '4': 1, '5': 5, '10': 'expiresInSeconds'},
    {'1': 'cooldown_seconds', '3': 6, '4': 1, '5': 5, '10': 'cooldownSeconds'},
  ],
};

/// Descriptor for `InitiatePinOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiatePinOTPResponseDescriptor = $convert.base64Decode(
    'ChZJbml0aWF0ZVBpbk9UUFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIYCgdjaGFubmVsGAMgASgJUgdjaGFubmVsEi0KEm1hc2tl'
    'ZF9kZXN0aW5hdGlvbhgEIAEoCVIRbWFza2VkRGVzdGluYXRpb24SLAoSZXhwaXJlc19pbl9zZW'
    'NvbmRzGAUgASgFUhBleHBpcmVzSW5TZWNvbmRzEikKEGNvb2xkb3duX3NlY29uZHMYBiABKAVS'
    'D2Nvb2xkb3duU2Vjb25kcw==');

@$core.Deprecated('Use verifyPinOTPRequestDescriptor instead')
const VerifyPinOTPRequest$json = {
  '1': 'VerifyPinOTPRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'otp_code', '3': 2, '4': 1, '5': 9, '10': 'otpCode'},
    {'1': 'operation_type', '3': 3, '4': 1, '5': 9, '10': 'operationType'},
    {'1': 'current_pin', '3': 4, '4': 1, '5': 9, '10': 'currentPin'},
    {'1': 'new_pin', '3': 5, '4': 1, '5': 9, '10': 'newPin'},
    {'1': 'confirm_new_pin', '3': 6, '4': 1, '5': 9, '10': 'confirmNewPin'},
    {'1': 'device_id', '3': 7, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'device_name', '3': 8, '4': 1, '5': 9, '10': 'deviceName'},
  ],
};

/// Descriptor for `VerifyPinOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPinOTPRequestDescriptor = $convert.base64Decode(
    'ChNWZXJpZnlQaW5PVFBSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIZCghvdHBfY2'
    '9kZRgCIAEoCVIHb3RwQ29kZRIlCg5vcGVyYXRpb25fdHlwZRgDIAEoCVINb3BlcmF0aW9uVHlw'
    'ZRIfCgtjdXJyZW50X3BpbhgEIAEoCVIKY3VycmVudFBpbhIXCgduZXdfcGluGAUgASgJUgZuZX'
    'dQaW4SJgoPY29uZmlybV9uZXdfcGluGAYgASgJUg1jb25maXJtTmV3UGluEhsKCWRldmljZV9p'
    'ZBgHIAEoCVIIZGV2aWNlSWQSHwoLZGV2aWNlX25hbWUYCCABKAlSCmRldmljZU5hbWU=');

@$core.Deprecated('Use verifyPinOTPResponseDescriptor instead')
const VerifyPinOTPResponse$json = {
  '1': 'VerifyPinOTPResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'remaining_attempts', '3': 3, '4': 1, '5': 5, '10': 'remainingAttempts'},
  ],
};

/// Descriptor for `VerifyPinOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPinOTPResponseDescriptor = $convert.base64Decode(
    'ChRWZXJpZnlQaW5PVFBSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2USLQoScmVtYWluaW5nX2F0dGVtcHRzGAMgASgFUhFyZW1haW5p'
    'bmdBdHRlbXB0cw==');

@$core.Deprecated('Use getPinOTPChannelsRequestDescriptor instead')
const GetPinOTPChannelsRequest$json = {
  '1': 'GetPinOTPChannelsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetPinOTPChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPinOTPChannelsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQaW5PVFBDaGFubmVsc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getPinOTPChannelsResponseDescriptor instead')
const GetPinOTPChannelsResponse$json = {
  '1': 'GetPinOTPChannelsResponse',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.auth.OTPChannel', '10': 'channels'},
    {'1': 'recommended_channel', '3': 2, '4': 1, '5': 9, '10': 'recommendedChannel'},
  ],
};

/// Descriptor for `GetPinOTPChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPinOTPChannelsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQaW5PVFBDaGFubmVsc1Jlc3BvbnNlEiwKCGNoYW5uZWxzGAEgAygLMhAuYXV0aC5PVF'
    'BDaGFubmVsUghjaGFubmVscxIvChNyZWNvbW1lbmRlZF9jaGFubmVsGAIgASgJUhJyZWNvbW1l'
    'bmRlZENoYW5uZWw=');

@$core.Deprecated('Use oTPChannelDescriptor instead')
const OTPChannel$json = {
  '1': 'OTPChannel',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'masked_destination', '3': 2, '4': 1, '5': 9, '10': 'maskedDestination'},
    {'1': 'is_verified', '3': 3, '4': 1, '5': 8, '10': 'isVerified'},
    {'1': 'is_available', '3': 4, '4': 1, '5': 8, '10': 'isAvailable'},
  ],
};

/// Descriptor for `OTPChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oTPChannelDescriptor = $convert.base64Decode(
    'CgpPVFBDaGFubmVsEhIKBHR5cGUYASABKAlSBHR5cGUSLQoSbWFza2VkX2Rlc3RpbmF0aW9uGA'
    'IgASgJUhFtYXNrZWREZXN0aW5hdGlvbhIfCgtpc192ZXJpZmllZBgDIAEoCFIKaXNWZXJpZmll'
    'ZBIhCgxpc19hdmFpbGFibGUYBCABKAhSC2lzQXZhaWxhYmxl');

@$core.Deprecated('Use completeForgotPinRequestDescriptor instead')
const CompleteForgotPinRequest$json = {
  '1': 'CompleteForgotPinRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'otp_code', '3': 2, '4': 1, '5': 9, '10': 'otpCode'},
    {'1': 'new_pin', '3': 3, '4': 1, '5': 9, '10': 'newPin'},
    {'1': 'confirm_new_pin', '3': 4, '4': 1, '5': 9, '10': 'confirmNewPin'},
    {'1': 'device_id', '3': 5, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `CompleteForgotPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeForgotPinRequestDescriptor = $convert.base64Decode(
    'ChhDb21wbGV0ZUZvcmdvdFBpblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhkKCG'
    '90cF9jb2RlGAIgASgJUgdvdHBDb2RlEhcKB25ld19waW4YAyABKAlSBm5ld1BpbhImCg9jb25m'
    'aXJtX25ld19waW4YBCABKAlSDWNvbmZpcm1OZXdQaW4SGwoJZGV2aWNlX2lkGAUgASgJUghkZX'
    'ZpY2VJZA==');

@$core.Deprecated('Use completeForgotPinResponseDescriptor instead')
const CompleteForgotPinResponse$json = {
  '1': 'CompleteForgotPinResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'remaining_attempts', '3': 3, '4': 1, '5': 5, '10': 'remainingAttempts'},
  ],
};

/// Descriptor for `CompleteForgotPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeForgotPinResponseDescriptor = $convert.base64Decode(
    'ChlDb21wbGV0ZUZvcmdvdFBpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRItChJyZW1haW5pbmdfYXR0ZW1wdHMYAyABKAVSEXJl'
    'bWFpbmluZ0F0dGVtcHRz');

