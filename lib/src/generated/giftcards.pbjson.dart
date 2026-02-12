//
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use giftCardDescriptor instead')
const GiftCard$json = {
  '1': 'GiftCard',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'brand_id', '3': 4, '4': 1, '5': 9, '10': 'brandId'},
    {'1': 'brand_name', '3': 5, '4': 1, '5': 9, '10': 'brandName'},
    {'1': 'card_number', '3': 6, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'pin', '3': 7, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'original_amount', '3': 8, '4': 1, '5': 1, '10': 'originalAmount'},
    {'1': 'current_balance', '3': 9, '4': 1, '5': 1, '10': 'currentBalance'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'purchase_date', '3': 12, '4': 1, '5': 9, '10': 'purchaseDate'},
    {'1': 'expiry_date', '3': 13, '4': 1, '5': 9, '10': 'expiryDate'},
    {'1': 'recipient_email', '3': 14, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 15, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'message', '3': 16, '4': 1, '5': 9, '10': 'message'},
    {'1': 'qr_code', '3': 17, '4': 1, '5': 9, '10': 'qrCode'},
    {'1': 'metadata', '3': 18, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 20, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'provider_transaction_id', '3': 21, '4': 1, '5': 9, '10': 'providerTransactionId'},
    {'1': 'redemption_code', '3': 22, '4': 1, '5': 9, '10': 'redemptionCode'},
    {'1': 'redemption_pin', '3': 23, '4': 1, '5': 9, '10': 'redemptionPin'},
    {'1': 'country_code', '3': 24, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'logo_url', '3': 25, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'provider_product_id', '3': 26, '4': 1, '5': 3, '10': 'providerProductId'},
    {'1': 'discount_percentage', '3': 27, '4': 1, '5': 1, '10': 'discountPercentage'},
  ],
};

/// Descriptor for `GiftCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDescriptor = $convert.base64Decode(
    'CghHaWZ0Q2FyZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCm'
    'FjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIZCghicmFuZF9pZBgEIAEoCVIHYnJhbmRJZBId'
    'CgpicmFuZF9uYW1lGAUgASgJUglicmFuZE5hbWUSHwoLY2FyZF9udW1iZXIYBiABKAlSCmNhcm'
    'ROdW1iZXISEAoDcGluGAcgASgJUgNwaW4SJwoPb3JpZ2luYWxfYW1vdW50GAggASgBUg5vcmln'
    'aW5hbEFtb3VudBInCg9jdXJyZW50X2JhbGFuY2UYCSABKAFSDmN1cnJlbnRCYWxhbmNlEhoKCG'
    'N1cnJlbmN5GAogASgJUghjdXJyZW5jeRIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxIjCg1wdXJj'
    'aGFzZV9kYXRlGAwgASgJUgxwdXJjaGFzZURhdGUSHwoLZXhwaXJ5X2RhdGUYDSABKAlSCmV4cG'
    'lyeURhdGUSJwoPcmVjaXBpZW50X2VtYWlsGA4gASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNp'
    'cGllbnRfbmFtZRgPIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGBAgASgJUgdtZXNzYW'
    'dlEhcKB3FyX2NvZGUYESABKAlSBnFyQ29kZRIaCghtZXRhZGF0YRgSIAEoCVIIbWV0YWRhdGES'
    'HQoKY3JlYXRlZF9hdBgTIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFCABKAlSCXVwZG'
    'F0ZWRBdBI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgVIAEoCVIVcHJvdmlkZXJUcmFuc2Fj'
    'dGlvbklkEicKD3JlZGVtcHRpb25fY29kZRgWIAEoCVIOcmVkZW1wdGlvbkNvZGUSJQoOcmVkZW'
    '1wdGlvbl9waW4YFyABKAlSDXJlZGVtcHRpb25QaW4SIQoMY291bnRyeV9jb2RlGBggASgJUgtj'
    'b3VudHJ5Q29kZRIZCghsb2dvX3VybBgZIAEoCVIHbG9nb1VybBIuChNwcm92aWRlcl9wcm9kdW'
    'N0X2lkGBogASgDUhFwcm92aWRlclByb2R1Y3RJZBIvChNkaXNjb3VudF9wZXJjZW50YWdlGBsg'
    'ASgBUhJkaXNjb3VudFBlcmNlbnRhZ2U=');

@$core.Deprecated('Use giftCardBrandDescriptor instead')
const GiftCardBrand$json = {
  '1': 'GiftCardBrand',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'denominations', '3': 6, '4': 3, '5': 1, '10': 'denominations'},
    {'1': 'min_amount', '3': 7, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 8, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'is_active', '3': 9, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'terms_and_conditions', '3': 10, '4': 1, '5': 9, '10': 'termsAndConditions'},
    {'1': 'product_id', '3': 11, '4': 1, '5': 3, '10': 'productId'},
    {'1': 'country_code', '3': 12, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'fixed_denominations', '3': 13, '4': 3, '5': 11, '6': '.giftcards.GiftCardDenomination', '10': 'fixedDenominations'},
    {'1': 'discount_percentage', '3': 14, '4': 1, '5': 1, '10': 'discountPercentage'},
    {'1': 'currency_code', '3': 15, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'redemption_instructions', '3': 16, '4': 1, '5': 9, '10': 'redemptionInstructions'},
  ],
};

/// Descriptor for `GiftCardBrand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardBrandDescriptor = $convert.base64Decode(
    'Cg1HaWZ0Q2FyZEJyYW5kEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhkKCG'
    'xvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIgCgtk'
    'ZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SJAoNZGVub21pbmF0aW9ucxgGIAMoAVINZG'
    'Vub21pbmF0aW9ucxIdCgptaW5fYW1vdW50GAcgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3Vu'
    'dBgIIAEoAVIJbWF4QW1vdW50EhsKCWlzX2FjdGl2ZRgJIAEoCFIIaXNBY3RpdmUSMAoUdGVybX'
    'NfYW5kX2NvbmRpdGlvbnMYCiABKAlSEnRlcm1zQW5kQ29uZGl0aW9ucxIdCgpwcm9kdWN0X2lk'
    'GAsgASgDUglwcm9kdWN0SWQSIQoMY291bnRyeV9jb2RlGAwgASgJUgtjb3VudHJ5Q29kZRJQCh'
    'NmaXhlZF9kZW5vbWluYXRpb25zGA0gAygLMh8uZ2lmdGNhcmRzLkdpZnRDYXJkRGVub21pbmF0'
    'aW9uUhJmaXhlZERlbm9taW5hdGlvbnMSLwoTZGlzY291bnRfcGVyY2VudGFnZRgOIAEoAVISZG'
    'lzY291bnRQZXJjZW50YWdlEiMKDWN1cnJlbmN5X2NvZGUYDyABKAlSDGN1cnJlbmN5Q29kZRI3'
    'ChdyZWRlbXB0aW9uX2luc3RydWN0aW9ucxgQIAEoCVIWcmVkZW1wdGlvbkluc3RydWN0aW9ucw'
    '==');

@$core.Deprecated('Use giftCardDenominationDescriptor instead')
const GiftCardDenomination$json = {
  '1': 'GiftCardDenomination',
  '2': [
    {'1': 'price', '3': 1, '4': 1, '5': 1, '10': 'price'},
    {'1': 'currency_code', '3': 2, '4': 1, '5': 9, '10': 'currencyCode'},
  ],
};

/// Descriptor for `GiftCardDenomination`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDenominationDescriptor = $convert.base64Decode(
    'ChRHaWZ0Q2FyZERlbm9taW5hdGlvbhIUCgVwcmljZRgBIAEoAVIFcHJpY2USIwoNY3VycmVuY3'
    'lfY29kZRgCIAEoCVIMY3VycmVuY3lDb2Rl');

@$core.Deprecated('Use giftCardTransactionDescriptor instead')
const GiftCardTransaction$json = {
  '1': 'GiftCardTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'gift_card_id', '3': 2, '4': 1, '5': 9, '10': 'giftCardId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'transaction_type', '3': 4, '4': 1, '5': 9, '10': 'transactionType'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'balance_before', '3': 6, '4': 1, '5': 1, '10': 'balanceBefore'},
    {'1': 'balance_after', '3': 7, '4': 1, '5': 1, '10': 'balanceAfter'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'provider_transaction_id', '3': 10, '4': 1, '5': 9, '10': 'providerTransactionId'},
    {'1': 'reference', '3': 11, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GiftCardTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardTransactionDescriptor = $convert.base64Decode(
    'ChNHaWZ0Q2FyZFRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIgCgxnaWZ0X2NhcmRfaWQYAi'
    'ABKAlSCmdpZnRDYXJkSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEikKEHRyYW5zYWN0aW9u'
    'X3R5cGUYBCABKAlSD3RyYW5zYWN0aW9uVHlwZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIlCg'
    '5iYWxhbmNlX2JlZm9yZRgGIAEoAVINYmFsYW5jZUJlZm9yZRIjCg1iYWxhbmNlX2FmdGVyGAcg'
    'ASgBUgxiYWxhbmNlQWZ0ZXISIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEh0KCm'
    'NyZWF0ZWRfYXQYCSABKAlSCWNyZWF0ZWRBdBI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgK'
    'IAEoCVIVcHJvdmlkZXJUcmFuc2FjdGlvbklkEhwKCXJlZmVyZW5jZRgLIAEoCVIJcmVmZXJlbm'
    'Nl');

@$core.Deprecated('Use buyGiftCardRequestDescriptor instead')
const BuyGiftCardRequest$json = {
  '1': 'BuyGiftCardRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'brand_id', '3': 2, '4': 1, '5': 9, '10': 'brandId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'recipient_email', '3': 4, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 5, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'gift_message', '3': 6, '4': 1, '5': 9, '10': 'giftMessage'},
    {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 8, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'sender_name', '3': 10, '4': 1, '5': 9, '10': 'senderName'},
    {'1': 'recipient_phone', '3': 11, '4': 1, '5': 9, '10': 'recipientPhone'},
    {'1': 'product_id', '3': 12, '4': 1, '5': 3, '10': 'productId'},
    {'1': 'country_code', '3': 13, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'quantity', '3': 14, '4': 1, '5': 5, '10': 'quantity'},
  ],
};

/// Descriptor for `BuyGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyGiftCardRequestDescriptor = $convert.base64Decode(
    'ChJCdXlHaWZ0Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhkKCG'
    'JyYW5kX2lkGAIgASgJUgdicmFuZElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EicKD3JlY2lw'
    'aWVudF9lbWFpbBgEIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYBSABKA'
    'lSDXJlY2lwaWVudE5hbWUSIQoMZ2lmdF9tZXNzYWdlGAYgASgJUgtnaWZ0TWVzc2FnZRIlCg50'
    'cmFuc2FjdGlvbl9pZBgHIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW'
    '4YCCABKAlSEXZlcmlmaWNhdGlvblRva2VuEicKD2lkZW1wb3RlbmN5X2tleRgJIAEoCVIOaWRl'
    'bXBvdGVuY3lLZXkSHwoLc2VuZGVyX25hbWUYCiABKAlSCnNlbmRlck5hbWUSJwoPcmVjaXBpZW'
    '50X3Bob25lGAsgASgJUg5yZWNpcGllbnRQaG9uZRIdCgpwcm9kdWN0X2lkGAwgASgDUglwcm9k'
    'dWN0SWQSIQoMY291bnRyeV9jb2RlGA0gASgJUgtjb3VudHJ5Q29kZRIaCghxdWFudGl0eRgOIA'
    'EoBVIIcXVhbnRpdHk=');

@$core.Deprecated('Use buyGiftCardResponseDescriptor instead')
const BuyGiftCardResponse$json = {
  '1': 'BuyGiftCardResponse',
  '2': [
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'provider_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'providerTransactionId'},
  ],
};

/// Descriptor for `BuyGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyGiftCardResponseDescriptor = $convert.base64Decode(
    'ChNCdXlHaWZ0Q2FyZFJlc3BvbnNlEjAKCWdpZnRfY2FyZBgBIAEoCzITLmdpZnRjYXJkcy5HaW'
    'Z0Q2FyZFIIZ2lmdENhcmQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USGAoHbWVz'
    'c2FnZRgDIAEoCVIHbWVzc2FnZRI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgEIAEoCVIVcH'
    'JvdmlkZXJUcmFuc2FjdGlvbklk');

@$core.Deprecated('Use redeemGiftCardRequestDescriptor instead')
const RedeemGiftCardRequest$json = {
  '1': 'RedeemGiftCardRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'card_number', '3': 2, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'card_pin', '3': 3, '4': 1, '5': 9, '10': 'cardPin'},
  ],
};

/// Descriptor for `RedeemGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemGiftCardRequestDescriptor = $convert.base64Decode(
    'ChVSZWRlZW1HaWZ0Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEh'
    '8KC2NhcmRfbnVtYmVyGAIgASgJUgpjYXJkTnVtYmVyEhkKCGNhcmRfcGluGAMgASgJUgdjYXJk'
    'UGlu');

@$core.Deprecated('Use redeemGiftCardResponseDescriptor instead')
const RedeemGiftCardResponse$json = {
  '1': 'RedeemGiftCardResponse',
  '2': [
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    {'1': 'amount_redeemed', '3': 2, '4': 1, '5': 1, '10': 'amountRedeemed'},
    {'1': 'new_balance', '3': 3, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RedeemGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemGiftCardResponseDescriptor = $convert.base64Decode(
    'ChZSZWRlZW1HaWZ0Q2FyZFJlc3BvbnNlEjAKCWdpZnRfY2FyZBgBIAEoCzITLmdpZnRjYXJkcy'
    '5HaWZ0Q2FyZFIIZ2lmdENhcmQSJwoPYW1vdW50X3JlZGVlbWVkGAIgASgBUg5hbW91bnRSZWRl'
    'ZW1lZBIfCgtuZXdfYmFsYW5jZRgDIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAQgASgJUg'
    'dtZXNzYWdl');

@$core.Deprecated('Use getGiftCardsRequestDescriptor instead')
const GetGiftCardsRequest$json = {
  '1': 'GetGiftCardsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'brand_id', '3': 2, '4': 1, '5': 9, '10': 'brandId'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetGiftCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardsRequestDescriptor = $convert.base64Decode(
    'ChNHZXRHaWZ0Q2FyZHNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhkKCGJyYW5kX2'
    'lkGAIgASgJUgdicmFuZElkEhQKBWxpbWl0GAMgASgFUgVsaW1pdBIWCgZvZmZzZXQYBCABKAVS'
    'Bm9mZnNldA==');

@$core.Deprecated('Use getGiftCardsResponseDescriptor instead')
const GetGiftCardsResponse$json = {
  '1': 'GetGiftCardsResponse',
  '2': [
    {'1': 'gift_cards', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCards'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_value', '3': 3, '4': 1, '5': 1, '10': 'totalValue'},
  ],
};

/// Descriptor for `GetGiftCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardsResponseDescriptor = $convert.base64Decode(
    'ChRHZXRHaWZ0Q2FyZHNSZXNwb25zZRIyCgpnaWZ0X2NhcmRzGAEgAygLMhMuZ2lmdGNhcmRzLk'
    'dpZnRDYXJkUglnaWZ0Q2FyZHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEh8KC3RvdGFsX3ZhbHVl'
    'GAMgASgBUgp0b3RhbFZhbHVl');

@$core.Deprecated('Use getGiftCardRequestDescriptor instead')
const GetGiftCardRequest$json = {
  '1': 'GetGiftCardRequest',
  '2': [
    {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
  ],
};

/// Descriptor for `GetGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardRequestDescriptor = $convert.base64Decode(
    'ChJHZXRHaWZ0Q2FyZFJlcXVlc3QSIAoMZ2lmdF9jYXJkX2lkGAEgASgJUgpnaWZ0Q2FyZElk');

@$core.Deprecated('Use getGiftCardResponseDescriptor instead')
const GetGiftCardResponse$json = {
  '1': 'GetGiftCardResponse',
  '2': [
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
  ],
};

/// Descriptor for `GetGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardResponseDescriptor = $convert.base64Decode(
    'ChNHZXRHaWZ0Q2FyZFJlc3BvbnNlEjAKCWdpZnRfY2FyZBgBIAEoCzITLmdpZnRjYXJkcy5HaW'
    'Z0Q2FyZFIIZ2lmdENhcmQ=');

@$core.Deprecated('Use transferGiftCardRequestDescriptor instead')
const TransferGiftCardRequest$json = {
  '1': 'TransferGiftCardRequest',
  '2': [
    {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `TransferGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardRequestDescriptor = $convert.base64Decode(
    'ChdUcmFuc2ZlckdpZnRDYXJkUmVxdWVzdBIgCgxnaWZ0X2NhcmRfaWQYASABKAlSCmdpZnRDYX'
    'JkSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGll'
    'bnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlEi'
    'UKDnRyYW5zYWN0aW9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90'
    'b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4=');

@$core.Deprecated('Use transferGiftCardResponseDescriptor instead')
const TransferGiftCardResponse$json = {
  '1': 'TransferGiftCardResponse',
  '2': [
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TransferGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardResponseDescriptor = $convert.base64Decode(
    'ChhUcmFuc2ZlckdpZnRDYXJkUmVzcG9uc2USMAoJZ2lmdF9jYXJkGAEgASgLMhMuZ2lmdGNhcm'
    'RzLkdpZnRDYXJkUghnaWZ0Q2FyZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getGiftCardBalanceRequestDescriptor instead')
const GetGiftCardBalanceRequest$json = {
  '1': 'GetGiftCardBalanceRequest',
  '2': [
    {'1': 'card_number', '3': 1, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'card_pin', '3': 2, '4': 1, '5': 9, '10': 'cardPin'},
  ],
};

/// Descriptor for `GetGiftCardBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBalanceRequestDescriptor = $convert.base64Decode(
    'ChlHZXRHaWZ0Q2FyZEJhbGFuY2VSZXF1ZXN0Eh8KC2NhcmRfbnVtYmVyGAEgASgJUgpjYXJkTn'
    'VtYmVyEhkKCGNhcmRfcGluGAIgASgJUgdjYXJkUGlu');

@$core.Deprecated('Use getGiftCardBalanceResponseDescriptor instead')
const GetGiftCardBalanceResponse$json = {
  '1': 'GetGiftCardBalanceResponse',
  '2': [
    {'1': 'balance', '3': 1, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'brand_name', '3': 2, '4': 1, '5': 9, '10': 'brandName'},
    {'1': 'expiry_date', '3': 3, '4': 1, '5': 9, '10': 'expiryDate'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetGiftCardBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBalanceResponseDescriptor = $convert.base64Decode(
    'ChpHZXRHaWZ0Q2FyZEJhbGFuY2VSZXNwb25zZRIYCgdiYWxhbmNlGAEgASgBUgdiYWxhbmNlEh'
    '0KCmJyYW5kX25hbWUYAiABKAlSCWJyYW5kTmFtZRIfCgtleHBpcnlfZGF0ZRgDIAEoCVIKZXhw'
    'aXJ5RGF0ZRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use getGiftCardBrandsRequestDescriptor instead')
const GetGiftCardBrandsRequest$json = {
  '1': 'GetGiftCardBrandsRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
    {'1': 'country_code', '3': 3, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetGiftCardBrandsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBrandsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRHaWZ0Q2FyZEJyYW5kc1JlcXVlc3QSGgoIY2F0ZWdvcnkYASABKAlSCGNhdGVnb3J5Eh'
    '8KC2FjdGl2ZV9vbmx5GAIgASgIUgphY3RpdmVPbmx5EiEKDGNvdW50cnlfY29kZRgDIAEoCVIL'
    'Y291bnRyeUNvZGU=');

@$core.Deprecated('Use getGiftCardBrandsResponseDescriptor instead')
const GetGiftCardBrandsResponse$json = {
  '1': 'GetGiftCardBrandsResponse',
  '2': [
    {'1': 'brands', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardBrand', '10': 'brands'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetGiftCardBrandsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBrandsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRHaWZ0Q2FyZEJyYW5kc1Jlc3BvbnNlEjAKBmJyYW5kcxgBIAMoCzIYLmdpZnRjYXJkcy'
    '5HaWZ0Q2FyZEJyYW5kUgZicmFuZHMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use getGiftCardHistoryRequestDescriptor instead')
const GetGiftCardHistoryRequest$json = {
  '1': 'GetGiftCardHistoryRequest',
  '2': [
    {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    {'1': 'transaction_type', '3': 2, '4': 1, '5': 9, '10': 'transactionType'},
    {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 6, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetGiftCardHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardHistoryRequestDescriptor = $convert.base64Decode(
    'ChlHZXRHaWZ0Q2FyZEhpc3RvcnlSZXF1ZXN0EiAKDGdpZnRfY2FyZF9pZBgBIAEoCVIKZ2lmdE'
    'NhcmRJZBIpChB0cmFuc2FjdGlvbl90eXBlGAIgASgJUg90cmFuc2FjdGlvblR5cGUSHQoKc3Rh'
    'cnRfZGF0ZRgDIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAQgASgJUgdlbmREYXRlEhQKBW'
    'xpbWl0GAUgASgFUgVsaW1pdBIWCgZvZmZzZXQYBiABKAVSBm9mZnNldA==');

@$core.Deprecated('Use getGiftCardHistoryResponseDescriptor instead')
const GetGiftCardHistoryResponse$json = {
  '1': 'GetGiftCardHistoryResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardTransaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetGiftCardHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardHistoryResponseDescriptor = $convert.base64Decode(
    'ChpHZXRHaWZ0Q2FyZEhpc3RvcnlSZXNwb25zZRJCCgx0cmFuc2FjdGlvbnMYASADKAsyHi5naW'
    'Z0Y2FyZHMuR2lmdENhcmRUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgF'
    'UgV0b3RhbA==');

@$core.Deprecated('Use sellableCardDescriptor instead')
const SellableCard$json = {
  '1': 'SellableCard',
  '2': [
    {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'denominations', '3': 5, '4': 3, '5': 1, '10': 'denominations'},
    {'1': 'currencies', '3': 6, '4': 3, '5': 9, '10': 'currencies'},
    {'1': 'min_denomination', '3': 7, '4': 1, '5': 1, '10': 'minDenomination'},
    {'1': 'max_denomination', '3': 8, '4': 1, '5': 1, '10': 'maxDenomination'},
  ],
};

/// Descriptor for `SellableCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellableCardDescriptor = $convert.base64Decode(
    'CgxTZWxsYWJsZUNhcmQSGwoJY2FyZF90eXBlGAEgASgJUghjYXJkVHlwZRIhCgxkaXNwbGF5X2'
    '5hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNh'
    'dGVnb3J5GAQgASgJUghjYXRlZ29yeRIkCg1kZW5vbWluYXRpb25zGAUgAygBUg1kZW5vbWluYX'
    'Rpb25zEh4KCmN1cnJlbmNpZXMYBiADKAlSCmN1cnJlbmNpZXMSKQoQbWluX2Rlbm9taW5hdGlv'
    'bhgHIAEoAVIPbWluRGVub21pbmF0aW9uEikKEG1heF9kZW5vbWluYXRpb24YCCABKAFSD21heE'
    'Rlbm9taW5hdGlvbg==');

@$core.Deprecated('Use sellRateDescriptor instead')
const SellRate$json = {
  '1': 'SellRate',
  '2': [
    {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'denomination', '3': 2, '4': 1, '5': 1, '10': 'denomination'},
    {'1': 'rate_percentage', '3': 3, '4': 1, '5': 1, '10': 'ratePercentage'},
    {'1': 'payout_amount', '3': 4, '4': 1, '5': 1, '10': 'payoutAmount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'expires_at', '3': 6, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `SellRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellRateDescriptor = $convert.base64Decode(
    'CghTZWxsUmF0ZRIbCgljYXJkX3R5cGUYASABKAlSCGNhcmRUeXBlEiIKDGRlbm9taW5hdGlvbh'
    'gCIAEoAVIMZGVub21pbmF0aW9uEicKD3JhdGVfcGVyY2VudGFnZRgDIAEoAVIOcmF0ZVBlcmNl'
    'bnRhZ2USIwoNcGF5b3V0X2Ftb3VudBgEIAEoAVIMcGF5b3V0QW1vdW50EhoKCGN1cnJlbmN5GA'
    'UgASgJUghjdXJyZW5jeRIdCgpleHBpcmVzX2F0GAYgASgJUglleHBpcmVzQXQ=');

@$core.Deprecated('Use giftCardSaleDescriptor instead')
const GiftCardSale$json = {
  '1': 'GiftCardSale',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'card_type', '3': 4, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'card_number', '3': 5, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'denomination', '3': 6, '4': 1, '5': 1, '10': 'denomination'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'rate_percentage', '3': 8, '4': 1, '5': 1, '10': 'ratePercentage'},
    {'1': 'expected_payout', '3': 9, '4': 1, '5': 1, '10': 'expectedPayout'},
    {'1': 'actual_payout', '3': 10, '4': 1, '5': 1, '10': 'actualPayout'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'provider_sale_id', '3': 12, '4': 1, '5': 9, '10': 'providerSaleId'},
    {'1': 'provider_name', '3': 13, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'reference', '3': 14, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'submitted_at', '3': 15, '4': 1, '5': 9, '10': 'submittedAt'},
    {'1': 'reviewed_at', '3': 16, '4': 1, '5': 9, '10': 'reviewedAt'},
    {'1': 'paid_at', '3': 17, '4': 1, '5': 9, '10': 'paidAt'},
    {'1': 'created_at', '3': 18, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 19, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `GiftCardSale`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardSaleDescriptor = $convert.base64Decode(
    'CgxHaWZ0Q2FyZFNhbGUSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'IdCgphY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSGwoJY2FyZF90eXBlGAQgASgJUghjYXJk'
    'VHlwZRIfCgtjYXJkX251bWJlchgFIAEoCVIKY2FyZE51bWJlchIiCgxkZW5vbWluYXRpb24YBi'
    'ABKAFSDGRlbm9taW5hdGlvbhIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSJwoPcmF0ZV9w'
    'ZXJjZW50YWdlGAggASgBUg5yYXRlUGVyY2VudGFnZRInCg9leHBlY3RlZF9wYXlvdXQYCSABKA'
    'FSDmV4cGVjdGVkUGF5b3V0EiMKDWFjdHVhbF9wYXlvdXQYCiABKAFSDGFjdHVhbFBheW91dBIW'
    'CgZzdGF0dXMYCyABKAlSBnN0YXR1cxIoChBwcm92aWRlcl9zYWxlX2lkGAwgASgJUg5wcm92aW'
    'RlclNhbGVJZBIjCg1wcm92aWRlcl9uYW1lGA0gASgJUgxwcm92aWRlck5hbWUSHAoJcmVmZXJl'
    'bmNlGA4gASgJUglyZWZlcmVuY2USIQoMc3VibWl0dGVkX2F0GA8gASgJUgtzdWJtaXR0ZWRBdB'
    'IfCgtyZXZpZXdlZF9hdBgQIAEoCVIKcmV2aWV3ZWRBdBIXCgdwYWlkX2F0GBEgASgJUgZwYWlk'
    'QXQSHQoKY3JlYXRlZF9hdBgSIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYEyABKAlSCX'
    'VwZGF0ZWRBdA==');

@$core.Deprecated('Use getSellableCardsRequestDescriptor instead')
const GetSellableCardsRequest$json = {
  '1': 'GetSellableCardsRequest',
};

/// Descriptor for `GetSellableCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellableCardsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRTZWxsYWJsZUNhcmRzUmVxdWVzdA==');

@$core.Deprecated('Use getSellableCardsResponseDescriptor instead')
const GetSellableCardsResponse$json = {
  '1': 'GetSellableCardsResponse',
  '2': [
    {'1': 'cards', '3': 1, '4': 3, '5': 11, '6': '.giftcards.SellableCard', '10': 'cards'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetSellableCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellableCardsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRTZWxsYWJsZUNhcmRzUmVzcG9uc2USLQoFY2FyZHMYASADKAsyFy5naWZ0Y2FyZHMuU2'
    'VsbGFibGVDYXJkUgVjYXJkcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use getSellRateRequestDescriptor instead')
const GetSellRateRequest$json = {
  '1': 'GetSellRateRequest',
  '2': [
    {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'denomination', '3': 2, '4': 1, '5': 1, '10': 'denomination'},
  ],
};

/// Descriptor for `GetSellRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellRateRequestDescriptor = $convert.base64Decode(
    'ChJHZXRTZWxsUmF0ZVJlcXVlc3QSGwoJY2FyZF90eXBlGAEgASgJUghjYXJkVHlwZRIiCgxkZW'
    '5vbWluYXRpb24YAiABKAFSDGRlbm9taW5hdGlvbg==');

@$core.Deprecated('Use getSellRateResponseDescriptor instead')
const GetSellRateResponse$json = {
  '1': 'GetSellRateResponse',
  '2': [
    {'1': 'rate', '3': 1, '4': 1, '5': 11, '6': '.giftcards.SellRate', '10': 'rate'},
  ],
};

/// Descriptor for `GetSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellRateResponseDescriptor = $convert.base64Decode(
    'ChNHZXRTZWxsUmF0ZVJlc3BvbnNlEicKBHJhdGUYASABKAsyEy5naWZ0Y2FyZHMuU2VsbFJhdG'
    'VSBHJhdGU=');

@$core.Deprecated('Use sellGiftCardRequestDescriptor instead')
const SellGiftCardRequest$json = {
  '1': 'SellGiftCardRequest',
  '2': [
    {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'card_number', '3': 2, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'card_pin', '3': 3, '4': 1, '5': 9, '10': 'cardPin'},
    {'1': 'denomination', '3': 4, '4': 1, '5': 1, '10': 'denomination'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'images', '3': 6, '4': 3, '5': 9, '10': 'images'},
    {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'transaction_id', '3': 8, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 9, '4': 1, '5': 9, '10': 'verificationToken'},
  ],
};

/// Descriptor for `SellGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardRequestDescriptor = $convert.base64Decode(
    'ChNTZWxsR2lmdENhcmRSZXF1ZXN0EhsKCWNhcmRfdHlwZRgBIAEoCVIIY2FyZFR5cGUSHwoLY2'
    'FyZF9udW1iZXIYAiABKAlSCmNhcmROdW1iZXISGQoIY2FyZF9waW4YAyABKAlSB2NhcmRQaW4S'
    'IgoMZGVub21pbmF0aW9uGAQgASgBUgxkZW5vbWluYXRpb24SGgoIY3VycmVuY3kYBSABKAlSCG'
    'N1cnJlbmN5EhYKBmltYWdlcxgGIAMoCVIGaW1hZ2VzEicKD2lkZW1wb3RlbmN5X2tleRgHIAEo'
    'CVIOaWRlbXBvdGVuY3lLZXkSJQoOdHJhbnNhY3Rpb25faWQYCCABKAlSDXRyYW5zYWN0aW9uSW'
    'QSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAkgASgJUhF2ZXJpZmljYXRpb25Ub2tlbg==');

@$core.Deprecated('Use sellGiftCardResponseDescriptor instead')
const SellGiftCardResponse$json = {
  '1': 'SellGiftCardResponse',
  '2': [
    {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SellGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardResponseDescriptor = $convert.base64Decode(
    'ChRTZWxsR2lmdENhcmRSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLkdpZnRDYX'
    'JkU2FsZVIEc2FsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getSellStatusRequestDescriptor instead')
const GetSellStatusRequest$json = {
  '1': 'GetSellStatusRequest',
  '2': [
    {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
  ],
};

/// Descriptor for `GetSellStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellStatusRequestDescriptor = $convert.base64Decode(
    'ChRHZXRTZWxsU3RhdHVzUmVxdWVzdBIXCgdzYWxlX2lkGAEgASgJUgZzYWxlSWQ=');

@$core.Deprecated('Use getSellStatusResponseDescriptor instead')
const GetSellStatusResponse$json = {
  '1': 'GetSellStatusResponse',
  '2': [
    {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
  ],
};

/// Descriptor for `GetSellStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellStatusResponseDescriptor = $convert.base64Decode(
    'ChVHZXRTZWxsU3RhdHVzUmVzcG9uc2USKwoEc2FsZRgBIAEoCzIXLmdpZnRjYXJkcy5HaWZ0Q2'
    'FyZFNhbGVSBHNhbGU=');

@$core.Deprecated('Use getMySalesRequestDescriptor instead')
const GetMySalesRequest$json = {
  '1': 'GetMySalesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetMySalesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMySalesRequestDescriptor = $convert.base64Decode(
    'ChFHZXRNeVNhbGVzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIUCgVsaW1pdBgCIA'
    'EoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getMySalesResponseDescriptor instead')
const GetMySalesResponse$json = {
  '1': 'GetMySalesResponse',
  '2': [
    {'1': 'sales', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sales'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMySalesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMySalesResponseDescriptor = $convert.base64Decode(
    'ChJHZXRNeVNhbGVzUmVzcG9uc2USLQoFc2FsZXMYASADKAsyFy5naWZ0Y2FyZHMuR2lmdENhcm'
    'RTYWxlUgVzYWxlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

