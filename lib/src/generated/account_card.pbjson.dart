///
//  Generated code. Do not modify.
//  source: account_card.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use accountCardDescriptor instead')
const AccountCard$json = const {
  '1': 'AccountCard',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'card_holder_name', '3': 3, '4': 1, '5': 9, '10': 'cardHolderName'},
    const {'1': 'brand', '3': 4, '4': 1, '5': 9, '10': 'brand'},
    const {'1': 'last4', '3': 5, '4': 1, '5': 9, '10': 'last4'},
    const {'1': 'card_expiry', '3': 6, '4': 1, '5': 9, '10': 'cardExpiry'},
    const {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'is_default', '3': 8, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'card_type', '3': 11, '4': 1, '5': 9, '10': 'cardType'},
  ],
};

/// Descriptor for `AccountCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountCardDescriptor = $convert.base64Decode('CgtBY2NvdW50Q2FyZBIOCgJpZBgBIAEoBFICaWQSHQoKYWNjb3VudF9pZBgCIAEoBFIJYWNjb3VudElkEigKEGNhcmRfaG9sZGVyX25hbWUYAyABKAlSDmNhcmRIb2xkZXJOYW1lEhQKBWJyYW5kGAQgASgJUgVicmFuZBIUCgVsYXN0NBgFIAEoCVIFbGFzdDQSHwoLY2FyZF9leHBpcnkYBiABKAlSCmNhcmRFeHBpcnkSGwoJaXNfYWN0aXZlGAcgASgIUghpc0FjdGl2ZRIdCgppc19kZWZhdWx0GAggASgIUglpc0RlZmF1bHQSOQoKY3JlYXRlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0EhsKCWNhcmRfdHlwZRgLIAEoCVIIY2FyZFR5cGU=');
@$core.Deprecated('Use addAccountCardRequestDescriptor instead')
const AddAccountCardRequest$json = const {
  '1': 'AddAccountCardRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'card_holder_name', '3': 2, '4': 1, '5': 9, '10': 'cardHolderName'},
    const {'1': 'card_number', '3': 3, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'card_expiry', '3': 4, '4': 1, '5': 9, '10': 'cardExpiry'},
    const {'1': 'card_type', '3': 5, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'make_default', '3': 6, '4': 1, '5': 8, '10': 'makeDefault'},
  ],
};

/// Descriptor for `AddAccountCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addAccountCardRequestDescriptor = $convert.base64Decode('ChVBZGRBY2NvdW50Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudElkEigKEGNhcmRfaG9sZGVyX25hbWUYAiABKAlSDmNhcmRIb2xkZXJOYW1lEh8KC2NhcmRfbnVtYmVyGAMgASgJUgpjYXJkTnVtYmVyEh8KC2NhcmRfZXhwaXJ5GAQgASgJUgpjYXJkRXhwaXJ5EhsKCWNhcmRfdHlwZRgFIAEoCVIIY2FyZFR5cGUSIQoMbWFrZV9kZWZhdWx0GAYgASgIUgttYWtlRGVmYXVsdA==');
@$core.Deprecated('Use addAccountCardResponseDescriptor instead')
const AddAccountCardResponse$json = const {
  '1': 'AddAccountCardResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `AddAccountCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addAccountCardResponseDescriptor = $convert.base64Decode('ChZBZGRBY2NvdW50Q2FyZFJlc3BvbnNlEiMKBGNhcmQYASABKAsyDy5wYi5BY2NvdW50Q2FyZFIEY2FyZA==');
@$core.Deprecated('Use getAccountCardsRequestDescriptor instead')
const GetAccountCardsRequest$json = const {
  '1': 'GetAccountCardsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
  ],
};

/// Descriptor for `GetAccountCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCardsRequestDescriptor = $convert.base64Decode('ChZHZXRBY2NvdW50Q2FyZHNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKARSCWFjY291bnRJZA==');
@$core.Deprecated('Use getAccountCardsResponseDescriptor instead')
const GetAccountCardsResponse$json = const {
  '1': 'GetAccountCardsResponse',
  '2': const [
    const {'1': 'cards', '3': 1, '4': 3, '5': 11, '6': '.pb.AccountCard', '10': 'cards'},
  ],
};

/// Descriptor for `GetAccountCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountCardsResponseDescriptor = $convert.base64Decode('ChdHZXRBY2NvdW50Q2FyZHNSZXNwb25zZRIlCgVjYXJkcxgBIAMoCzIPLnBiLkFjY291bnRDYXJkUgVjYXJkcw==');
@$core.Deprecated('Use updateAccountCardDefaultStatusRequestDescriptor instead')
const UpdateAccountCardDefaultStatusRequest$json = const {
  '1': 'UpdateAccountCardDefaultStatusRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'card_id', '3': 2, '4': 1, '5': 4, '10': 'cardId'},
  ],
};

/// Descriptor for `UpdateAccountCardDefaultStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountCardDefaultStatusRequestDescriptor = $convert.base64Decode('CiVVcGRhdGVBY2NvdW50Q2FyZERlZmF1bHRTdGF0dXNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKARSCWFjY291bnRJZBIXCgdjYXJkX2lkGAIgASgEUgZjYXJkSWQ=');
@$core.Deprecated('Use updateAccountCardDefaultStatusResponseDescriptor instead')
const UpdateAccountCardDefaultStatusResponse$json = const {
  '1': 'UpdateAccountCardDefaultStatusResponse',
  '2': const [
    const {'1': 'card', '3': 1, '4': 1, '5': 11, '6': '.pb.AccountCard', '10': 'card'},
  ],
};

/// Descriptor for `UpdateAccountCardDefaultStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAccountCardDefaultStatusResponseDescriptor = $convert.base64Decode('CiZVcGRhdGVBY2NvdW50Q2FyZERlZmF1bHRTdGF0dXNSZXNwb25zZRIjCgRjYXJkGAEgASgLMg8ucGIuQWNjb3VudENhcmRSBGNhcmQ=');
@$core.Deprecated('Use deleteAccountCardRequestDescriptor instead')
const DeleteAccountCardRequest$json = const {
  '1': 'DeleteAccountCardRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 4, '10': 'accountId'},
    const {'1': 'card_id', '3': 2, '4': 1, '5': 4, '10': 'cardId'},
  ],
};

/// Descriptor for `DeleteAccountCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAccountCardRequestDescriptor = $convert.base64Decode('ChhEZWxldGVBY2NvdW50Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoBFIJYWNjb3VudElkEhcKB2NhcmRfaWQYAiABKARSBmNhcmRJZA==');
