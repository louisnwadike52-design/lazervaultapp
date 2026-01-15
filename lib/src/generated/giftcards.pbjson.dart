///
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use giftCardDescriptor instead')
const GiftCard$json = const {
  '1': 'GiftCard',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'brand_id', '3': 4, '4': 1, '5': 9, '10': 'brandId'},
    const {'1': 'brand_name', '3': 5, '4': 1, '5': 9, '10': 'brandName'},
    const {'1': 'card_number', '3': 6, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'pin', '3': 7, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'original_amount', '3': 8, '4': 1, '5': 1, '10': 'originalAmount'},
    const {'1': 'current_balance', '3': 9, '4': 1, '5': 1, '10': 'currentBalance'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'purchase_date', '3': 12, '4': 1, '5': 9, '10': 'purchaseDate'},
    const {'1': 'expiry_date', '3': 13, '4': 1, '5': 9, '10': 'expiryDate'},
    const {'1': 'recipient_email', '3': 14, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 15, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'message', '3': 16, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'qr_code', '3': 17, '4': 1, '5': 9, '10': 'qrCode'},
    const {'1': 'metadata', '3': 18, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 20, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `GiftCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDescriptor = $convert.base64Decode('CghHaWZ0Q2FyZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIZCghicmFuZF9pZBgEIAEoCVIHYnJhbmRJZBIdCgpicmFuZF9uYW1lGAUgASgJUglicmFuZE5hbWUSHwoLY2FyZF9udW1iZXIYBiABKAlSCmNhcmROdW1iZXISEAoDcGluGAcgASgJUgNwaW4SJwoPb3JpZ2luYWxfYW1vdW50GAggASgBUg5vcmlnaW5hbEFtb3VudBInCg9jdXJyZW50X2JhbGFuY2UYCSABKAFSDmN1cnJlbnRCYWxhbmNlEhoKCGN1cnJlbmN5GAogASgJUghjdXJyZW5jeRIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxIjCg1wdXJjaGFzZV9kYXRlGAwgASgJUgxwdXJjaGFzZURhdGUSHwoLZXhwaXJ5X2RhdGUYDSABKAlSCmV4cGlyeURhdGUSJwoPcmVjaXBpZW50X2VtYWlsGA4gASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGllbnRfbmFtZRgPIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGBAgASgJUgdtZXNzYWdlEhcKB3FyX2NvZGUYESABKAlSBnFyQ29kZRIaCghtZXRhZGF0YRgSIAEoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgTIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFCABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use giftCardBrandDescriptor instead')
const GiftCardBrand$json = const {
  '1': 'GiftCardBrand',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'denominations', '3': 6, '4': 3, '5': 1, '10': 'denominations'},
    const {'1': 'min_amount', '3': 7, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 8, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'is_active', '3': 9, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'terms_and_conditions', '3': 10, '4': 1, '5': 9, '10': 'termsAndConditions'},
  ],
};

/// Descriptor for `GiftCardBrand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardBrandDescriptor = $convert.base64Decode('Cg1HaWZ0Q2FyZEJyYW5kEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SJAoNZGVub21pbmF0aW9ucxgGIAMoAVINZGVub21pbmF0aW9ucxIdCgptaW5fYW1vdW50GAcgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgIIAEoAVIJbWF4QW1vdW50EhsKCWlzX2FjdGl2ZRgJIAEoCFIIaXNBY3RpdmUSMAoUdGVybXNfYW5kX2NvbmRpdGlvbnMYCiABKAlSEnRlcm1zQW5kQ29uZGl0aW9ucw==');
@$core.Deprecated('Use giftCardTransactionDescriptor instead')
const GiftCardTransaction$json = const {
  '1': 'GiftCardTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'gift_card_id', '3': 2, '4': 1, '5': 9, '10': 'giftCardId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'transaction_type', '3': 4, '4': 1, '5': 9, '10': 'transactionType'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'balance_before', '3': 6, '4': 1, '5': 1, '10': 'balanceBefore'},
    const {'1': 'balance_after', '3': 7, '4': 1, '5': 1, '10': 'balanceAfter'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `GiftCardTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardTransactionDescriptor = $convert.base64Decode('ChNHaWZ0Q2FyZFRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIgCgxnaWZ0X2NhcmRfaWQYAiABKAlSCmdpZnRDYXJkSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEikKEHRyYW5zYWN0aW9uX3R5cGUYBCABKAlSD3RyYW5zYWN0aW9uVHlwZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIlCg5iYWxhbmNlX2JlZm9yZRgGIAEoAVINYmFsYW5jZUJlZm9yZRIjCg1iYWxhbmNlX2FmdGVyGAcgASgBUgxiYWxhbmNlQWZ0ZXISIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEh0KCmNyZWF0ZWRfYXQYCSABKAlSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use buyGiftCardRequestDescriptor instead')
const BuyGiftCardRequest$json = const {
  '1': 'BuyGiftCardRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'brand_id', '3': 2, '4': 1, '5': 9, '10': 'brandId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'recipient_email', '3': 4, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 5, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'gift_message', '3': 6, '4': 1, '5': 9, '10': 'giftMessage'},
    const {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 8, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `BuyGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyGiftCardRequestDescriptor = $convert.base64Decode('ChJCdXlHaWZ0Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhkKCGJyYW5kX2lkGAIgASgJUgdicmFuZElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EicKD3JlY2lwaWVudF9lbWFpbBgEIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYBSABKAlSDXJlY2lwaWVudE5hbWUSIQoMZ2lmdF9tZXNzYWdlGAYgASgJUgtnaWZ0TWVzc2FnZRIlCg50cmFuc2FjdGlvbl9pZBgHIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YCCABKAlSEXZlcmlmaWNhdGlvblRva2Vu');
@$core.Deprecated('Use buyGiftCardResponseDescriptor instead')
const BuyGiftCardResponse$json = const {
  '1': 'BuyGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyGiftCardResponseDescriptor = $convert.base64Decode('ChNCdXlHaWZ0Q2FyZFJlc3BvbnNlEjAKCWdpZnRfY2FyZBgBIAEoCzITLmdpZnRjYXJkcy5HaWZ0Q2FyZFIIZ2lmdENhcmQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use redeemGiftCardRequestDescriptor instead')
const RedeemGiftCardRequest$json = const {
  '1': 'RedeemGiftCardRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'card_number', '3': 2, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'card_pin', '3': 3, '4': 1, '5': 9, '10': 'cardPin'},
  ],
};

/// Descriptor for `RedeemGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemGiftCardRequestDescriptor = $convert.base64Decode('ChVSZWRlZW1HaWZ0Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEh8KC2NhcmRfbnVtYmVyGAIgASgJUgpjYXJkTnVtYmVyEhkKCGNhcmRfcGluGAMgASgJUgdjYXJkUGlu');
@$core.Deprecated('Use redeemGiftCardResponseDescriptor instead')
const RedeemGiftCardResponse$json = const {
  '1': 'RedeemGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    const {'1': 'amount_redeemed', '3': 2, '4': 1, '5': 1, '10': 'amountRedeemed'},
    const {'1': 'new_balance', '3': 3, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RedeemGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemGiftCardResponseDescriptor = $convert.base64Decode('ChZSZWRlZW1HaWZ0Q2FyZFJlc3BvbnNlEjAKCWdpZnRfY2FyZBgBIAEoCzITLmdpZnRjYXJkcy5HaWZ0Q2FyZFIIZ2lmdENhcmQSJwoPYW1vdW50X3JlZGVlbWVkGAIgASgBUg5hbW91bnRSZWRlZW1lZBIfCgtuZXdfYmFsYW5jZRgDIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getGiftCardsRequestDescriptor instead')
const GetGiftCardsRequest$json = const {
  '1': 'GetGiftCardsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'brand_id', '3': 2, '4': 1, '5': 9, '10': 'brandId'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetGiftCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardsRequestDescriptor = $convert.base64Decode('ChNHZXRHaWZ0Q2FyZHNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhkKCGJyYW5kX2lkGAIgASgJUgdicmFuZElkEhQKBWxpbWl0GAMgASgFUgVsaW1pdBIWCgZvZmZzZXQYBCABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getGiftCardsResponseDescriptor instead')
const GetGiftCardsResponse$json = const {
  '1': 'GetGiftCardsResponse',
  '2': const [
    const {'1': 'gift_cards', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCards'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_value', '3': 3, '4': 1, '5': 1, '10': 'totalValue'},
  ],
};

/// Descriptor for `GetGiftCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardsResponseDescriptor = $convert.base64Decode('ChRHZXRHaWZ0Q2FyZHNSZXNwb25zZRIyCgpnaWZ0X2NhcmRzGAEgAygLMhMuZ2lmdGNhcmRzLkdpZnRDYXJkUglnaWZ0Q2FyZHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEh8KC3RvdGFsX3ZhbHVlGAMgASgBUgp0b3RhbFZhbHVl');
@$core.Deprecated('Use getGiftCardRequestDescriptor instead')
const GetGiftCardRequest$json = const {
  '1': 'GetGiftCardRequest',
  '2': const [
    const {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
  ],
};

/// Descriptor for `GetGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardRequestDescriptor = $convert.base64Decode('ChJHZXRHaWZ0Q2FyZFJlcXVlc3QSIAoMZ2lmdF9jYXJkX2lkGAEgASgJUgpnaWZ0Q2FyZElk');
@$core.Deprecated('Use getGiftCardResponseDescriptor instead')
const GetGiftCardResponse$json = const {
  '1': 'GetGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
  ],
};

/// Descriptor for `GetGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardResponseDescriptor = $convert.base64Decode('ChNHZXRHaWZ0Q2FyZFJlc3BvbnNlEjAKCWdpZnRfY2FyZBgBIAEoCzITLmdpZnRjYXJkcy5HaWZ0Q2FyZFIIZ2lmdENhcmQ=');
@$core.Deprecated('Use transferGiftCardRequestDescriptor instead')
const TransferGiftCardRequest$json = const {
  '1': 'TransferGiftCardRequest',
  '2': const [
    const {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    const {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `TransferGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardRequestDescriptor = $convert.base64Decode('ChdUcmFuc2ZlckdpZnRDYXJkUmVxdWVzdBIgCgxnaWZ0X2NhcmRfaWQYASABKAlSCmdpZnRDYXJkSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGllbnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlEiUKDnRyYW5zYWN0aW9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');
@$core.Deprecated('Use transferGiftCardResponseDescriptor instead')
const TransferGiftCardResponse$json = const {
  '1': 'TransferGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TransferGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardResponseDescriptor = $convert.base64Decode('ChhUcmFuc2ZlckdpZnRDYXJkUmVzcG9uc2USMAoJZ2lmdF9jYXJkGAEgASgLMhMuZ2lmdGNhcmRzLkdpZnRDYXJkUghnaWZ0Q2FyZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getGiftCardBalanceRequestDescriptor instead')
const GetGiftCardBalanceRequest$json = const {
  '1': 'GetGiftCardBalanceRequest',
  '2': const [
    const {'1': 'card_number', '3': 1, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'card_pin', '3': 2, '4': 1, '5': 9, '10': 'cardPin'},
  ],
};

/// Descriptor for `GetGiftCardBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBalanceRequestDescriptor = $convert.base64Decode('ChlHZXRHaWZ0Q2FyZEJhbGFuY2VSZXF1ZXN0Eh8KC2NhcmRfbnVtYmVyGAEgASgJUgpjYXJkTnVtYmVyEhkKCGNhcmRfcGluGAIgASgJUgdjYXJkUGlu');
@$core.Deprecated('Use getGiftCardBalanceResponseDescriptor instead')
const GetGiftCardBalanceResponse$json = const {
  '1': 'GetGiftCardBalanceResponse',
  '2': const [
    const {'1': 'balance', '3': 1, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'brand_name', '3': 2, '4': 1, '5': 9, '10': 'brandName'},
    const {'1': 'expiry_date', '3': 3, '4': 1, '5': 9, '10': 'expiryDate'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetGiftCardBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBalanceResponseDescriptor = $convert.base64Decode('ChpHZXRHaWZ0Q2FyZEJhbGFuY2VSZXNwb25zZRIYCgdiYWxhbmNlGAEgASgBUgdiYWxhbmNlEh0KCmJyYW5kX25hbWUYAiABKAlSCWJyYW5kTmFtZRIfCgtleHBpcnlfZGF0ZRgDIAEoCVIKZXhwaXJ5RGF0ZRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cw==');
@$core.Deprecated('Use getGiftCardBrandsRequestDescriptor instead')
const GetGiftCardBrandsRequest$json = const {
  '1': 'GetGiftCardBrandsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetGiftCardBrandsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBrandsRequestDescriptor = $convert.base64Decode('ChhHZXRHaWZ0Q2FyZEJyYW5kc1JlcXVlc3QSGgoIY2F0ZWdvcnkYASABKAlSCGNhdGVnb3J5Eh8KC2FjdGl2ZV9vbmx5GAIgASgIUgphY3RpdmVPbmx5');
@$core.Deprecated('Use getGiftCardBrandsResponseDescriptor instead')
const GetGiftCardBrandsResponse$json = const {
  '1': 'GetGiftCardBrandsResponse',
  '2': const [
    const {'1': 'brands', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardBrand', '10': 'brands'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetGiftCardBrandsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBrandsResponseDescriptor = $convert.base64Decode('ChlHZXRHaWZ0Q2FyZEJyYW5kc1Jlc3BvbnNlEjAKBmJyYW5kcxgBIAMoCzIYLmdpZnRjYXJkcy5HaWZ0Q2FyZEJyYW5kUgZicmFuZHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use getGiftCardHistoryRequestDescriptor instead')
const GetGiftCardHistoryRequest$json = const {
  '1': 'GetGiftCardHistoryRequest',
  '2': const [
    const {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    const {'1': 'transaction_type', '3': 2, '4': 1, '5': 9, '10': 'transactionType'},
    const {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 6, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetGiftCardHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardHistoryRequestDescriptor = $convert.base64Decode('ChlHZXRHaWZ0Q2FyZEhpc3RvcnlSZXF1ZXN0EiAKDGdpZnRfY2FyZF9pZBgBIAEoCVIKZ2lmdENhcmRJZBIpChB0cmFuc2FjdGlvbl90eXBlGAIgASgJUg90cmFuc2FjdGlvblR5cGUSHQoKc3RhcnRfZGF0ZRgDIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAQgASgJUgdlbmREYXRlEhQKBWxpbWl0GAUgASgFUgVsaW1pdBIWCgZvZmZzZXQYBiABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getGiftCardHistoryResponseDescriptor instead')
const GetGiftCardHistoryResponse$json = const {
  '1': 'GetGiftCardHistoryResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetGiftCardHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardHistoryResponseDescriptor = $convert.base64Decode('ChpHZXRHaWZ0Q2FyZEhpc3RvcnlSZXNwb25zZRJCCgx0cmFuc2FjdGlvbnMYASADKAsyHi5naWZ0Y2FyZHMuR2lmdENhcmRUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
