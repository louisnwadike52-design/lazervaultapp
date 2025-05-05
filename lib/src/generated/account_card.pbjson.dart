//
//  Generated code. Do not modify.
//  source: account_card.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use accountCardDescriptor instead')
const AccountCard$json = {
  '1': 'AccountCard',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'card_holder_name', '3': 3, '4': 1, '5': 9, '10': 'cardHolderName'},
    {'1': 'brand', '3': 4, '4': 1, '5': 9, '10': 'brand'},
    {'1': 'last4', '3': 5, '4': 1, '5': 9, '10': 'last4'},
    {'1': 'card_expiry', '3': 6, '4': 1, '5': 9, '10': 'cardExpiry'},
    {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'is_default', '3': 8, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'card_type', '3': 11, '4': 1, '5': 9, '10': 'cardType'},
  ],
};

/// Descriptor for `AccountCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountCardDescriptor = $convert.base64Decode(
    'CgtBY2NvdW50Q2FyZBIOCgJpZBgBIAEoBFICaWQSHQoKYWNjb3VudF9pZBgCIAEoBFIJYWNjb3'
    'VudElkEigKEGNhcmRfaG9sZGVyX25hbWUYAyABKAlSDmNhcmRIb2xkZXJOYW1lEhQKBWJyYW5k'
    'GAQgASgJUgVicmFuZBIUCgVsYXN0NBgFIAEoCVIFbGFzdDQSHwoLY2FyZF9leHBpcnkYBiABKA'
    'lSCmNhcmRFeHBpcnkSGwoJaXNfYWN0aXZlGAcgASgIUghpc0FjdGl2ZRIdCgppc19kZWZhdWx0'
    'GAggASgIUglpc0RlZmF1bHQSOQoKY3JlYXRlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3Rv'
    'YnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0EhsKCWNhcmRfdHlwZRgLIAEoCVIIY2FyZFR5cGU=');

@$core.Deprecated('Use addAccountCardRequestDescriptor instead')
const AddAccountCardRequest$json = {
  '1': 'AddAccountCardRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'card_holder_name', '3': 2, '4': 1, '5': 9, '10': 'cardHolderName'},
    {'1': 'card_number', '3': 3, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'card_expiry', '3': 4, '4': 1, '5': 9, '10': 'cardExpiry'},
    {'1': 'card_type', '3': 5, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'make_default', '3': 6, '4': 1, '5': 8, '10': 'makeDefault'},
  ],
};

/// Descriptor for `AddAccountCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addAccountCardRequestDescriptor = $convert.base64Decode(
    'ChVBZGRBY2NvdW50Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudElkEi'
    'gKEGNhcmRfaG9sZGVyX25hbWUYAiABKAlSDmNhcmRIb2xkZXJOYW1lEh8KC2NhcmRfbnVtYmVy'
    'GAMgASgJUgpjYXJkTnVtYmVyEh8KC2NhcmRfZXhwaXJ5GAQgASgJUgpjYXJkRXhwaXJ5EhsKCW'
    'NhcmRfdHlwZRgFIAEoCVIIY2FyZFR5cGUSIQoMbWFrZV9kZWZhdWx0GAYgASgIUgttYWtlRGVm'
    'YXVsdA==');

@$core.Deprecated('Use addAccountCardResponseDescriptor instead')
const AddAccountCardResponse$json = {
  '1': 'AddAccountCardResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `AddAccountCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addAccountCardResponseDescriptor = $convert.base64Decode(
    'ChZBZGRBY2NvdW50Q2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZF'
    'IEY2FyZA==');

@$core.Deprecated('Use getAccountCardsRequestDescriptor instead')
const GetAccountCardsRequest$json = {
  '1': 'GetAccountCardsRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCardsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRBY2NvdW50Q2FyZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKARSCWFjY291bnRJZA'
    '==');

@$core.Deprecated('Use getAccountCardsResponseDescriptor instead')
const GetAccountCardsResponse$json = {
  '1': 'GetAccountCardsResponse',
  '2': [
    {'1': 'cards', '3': 1, '4': 3, '5': 11, '6': '.pb.AccountCard', '10': 'cards'},
  ],
};

/// Descriptor for `GetAccountCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCardsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRBY2NvdW50Q2FyZHNSZXNwb25zZRIlCgVjYXJkcxgBIAMoCzIPLnBiLkFjY291bnRDYX'
    'JkUgVjYXJkcw==');

@$core.Deprecated('Use updateAccountCardDefaultStatusRequestDescriptor instead')
const UpdateAccountCardDefaultStatusRequest$json = {
  '1': 'UpdateAccountCardDefaultStatusRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'card_id', '3': 2, '4': 1, '5': 4, '10': 'cardId'},
  ],
};

/// Descriptor for `UpdateAccountCardDefaultStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountCardDefaultStatusRequestDescriptor = $convert.base64Decode(
    'CiVVcGRhdGVBY2NvdW50Q2FyZERlZmF1bHRTdGF0dXNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYAS'
    'ABKARSCWFjY291bnRJZBIXCgdjYXJkX2lkGAIgASgEUgZjYXJkSWQ=');

@$core.Deprecated('Use updateAccountCardDefaultStatusResponseDescriptor instead')
const UpdateAccountCardDefaultStatusResponse$json = {
  '1': 'UpdateAccountCardDefaultStatusResponse',
  '2': [
    {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `UpdateAccountCardDefaultStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountCardDefaultStatusResponseDescriptor = $convert.base64Decode(
    'CiZVcGRhdGVBY2NvdW50Q2FyZERlZmF1bHRTdGF0dXNSZXNwb25zZRIjCgRjYXJkGAEgASgLMg'
    '8ucGIuQWNjb3VudENhcmRSBGNhcmQ=');

@$core.Deprecated('Use deleteAccountCardRequestDescriptor instead')
const DeleteAccountCardRequest$json = {
  '1': 'DeleteAccountCardRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    {'1': 'card_id', '3': 2, '4': 1, '5': 4, '10': 'cardId'},
  ],
};

/// Descriptor for `DeleteAccountCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAccountCardRequestDescriptor = $convert.base64Decode(
    'ChhEZWxldGVBY2NvdW50Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudE'
    'lkEhcKB2NhcmRfaWQYAiABKARSBmNhcmRJZA==');

