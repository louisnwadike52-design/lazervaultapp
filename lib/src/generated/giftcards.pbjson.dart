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
    const {'1': 'original_amount', '3': 8, '4': 1, '5': 1, '10': 'originalAmount'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'purchase_date', '3': 12, '4': 1, '5': 9, '10': 'purchaseDate'},
    const {'1': 'expiry_date', '3': 13, '4': 1, '5': 9, '10': 'expiryDate'},
    const {'1': 'recipient_email', '3': 14, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 15, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'message', '3': 16, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'metadata', '3': 18, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 20, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'provider_transaction_id', '3': 21, '4': 1, '5': 9, '10': 'providerTransactionId'},
    const {'1': 'redemption_code', '3': 22, '4': 1, '5': 9, '10': 'redemptionCode'},
    const {'1': 'redemption_pin', '3': 23, '4': 1, '5': 9, '10': 'redemptionPin'},
    const {'1': 'country_code', '3': 24, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'logo_url', '3': 25, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'provider_product_id', '3': 26, '4': 1, '5': 3, '10': 'providerProductId'},
    const {'1': 'discount_percentage', '3': 27, '4': 1, '5': 1, '10': 'discountPercentage'},
    const {'1': 'sender_amount', '3': 28, '4': 1, '5': 1, '10': 'senderAmount'},
    const {'1': 'sender_currency', '3': 29, '4': 1, '5': 9, '10': 'senderCurrency'},
    const {'1': 'transferred_from_id', '3': 30, '4': 1, '5': 9, '10': 'transferredFromId'},
    const {'1': 'sender_user_id', '3': 31, '4': 1, '5': 9, '10': 'senderUserId'},
    const {'1': 'transfer_type', '3': 32, '4': 1, '5': 9, '10': 'transferType'},
    const {'1': 'redemption_instructions', '3': 33, '4': 1, '5': 9, '10': 'redemptionInstructions'},
  ],
  '9': const [
    const {'1': 6, '2': 7},
    const {'1': 7, '2': 8},
    const {'1': 9, '2': 10},
    const {'1': 17, '2': 18},
  ],
};

/// Descriptor for `GiftCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDescriptor = $convert.base64Decode('CghHaWZ0Q2FyZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIZCghicmFuZF9pZBgEIAEoCVIHYnJhbmRJZBIdCgpicmFuZF9uYW1lGAUgASgJUglicmFuZE5hbWUSJwoPb3JpZ2luYWxfYW1vdW50GAggASgBUg5vcmlnaW5hbEFtb3VudBIaCghjdXJyZW5jeRgKIAEoCVIIY3VycmVuY3kSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSIwoNcHVyY2hhc2VfZGF0ZRgMIAEoCVIMcHVyY2hhc2VEYXRlEh8KC2V4cGlyeV9kYXRlGA0gASgJUgpleHBpcnlEYXRlEicKD3JlY2lwaWVudF9lbWFpbBgOIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYDyABKAlSDXJlY2lwaWVudE5hbWUSGAoHbWVzc2FnZRgQIAEoCVIHbWVzc2FnZRIaCghtZXRhZGF0YRgSIAEoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgTIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFCABKAlSCXVwZGF0ZWRBdBI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgVIAEoCVIVcHJvdmlkZXJUcmFuc2FjdGlvbklkEicKD3JlZGVtcHRpb25fY29kZRgWIAEoCVIOcmVkZW1wdGlvbkNvZGUSJQoOcmVkZW1wdGlvbl9waW4YFyABKAlSDXJlZGVtcHRpb25QaW4SIQoMY291bnRyeV9jb2RlGBggASgJUgtjb3VudHJ5Q29kZRIZCghsb2dvX3VybBgZIAEoCVIHbG9nb1VybBIuChNwcm92aWRlcl9wcm9kdWN0X2lkGBogASgDUhFwcm92aWRlclByb2R1Y3RJZBIvChNkaXNjb3VudF9wZXJjZW50YWdlGBsgASgBUhJkaXNjb3VudFBlcmNlbnRhZ2USIwoNc2VuZGVyX2Ftb3VudBgcIAEoAVIMc2VuZGVyQW1vdW50EicKD3NlbmRlcl9jdXJyZW5jeRgdIAEoCVIOc2VuZGVyQ3VycmVuY3kSLgoTdHJhbnNmZXJyZWRfZnJvbV9pZBgeIAEoCVIRdHJhbnNmZXJyZWRGcm9tSWQSJAoOc2VuZGVyX3VzZXJfaWQYHyABKAlSDHNlbmRlclVzZXJJZBIjCg10cmFuc2Zlcl90eXBlGCAgASgJUgx0cmFuc2ZlclR5cGUSNwoXcmVkZW1wdGlvbl9pbnN0cnVjdGlvbnMYISABKAlSFnJlZGVtcHRpb25JbnN0cnVjdGlvbnNKBAgGEAdKBAgHEAhKBAgJEApKBAgREBI=');
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
    const {'1': 'provider_name', '3': 17, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'product_id', '3': 11, '4': 1, '5': 3, '10': 'productId'},
    const {'1': 'country_code', '3': 12, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'fixed_denominations', '3': 13, '4': 3, '5': 11, '6': '.giftcards.GiftCardDenomination', '10': 'fixedDenominations'},
    const {'1': 'discount_percentage', '3': 14, '4': 1, '5': 1, '10': 'discountPercentage'},
    const {'1': 'currency_code', '3': 15, '4': 1, '5': 9, '10': 'currencyCode'},
    const {'1': 'redemption_instructions', '3': 16, '4': 1, '5': 9, '10': 'redemptionInstructions'},
    const {'1': 'sender_currency_code', '3': 18, '4': 1, '5': 9, '10': 'senderCurrencyCode'},
    const {'1': 'sender_denominations', '3': 19, '4': 3, '5': 1, '10': 'senderDenominations'},
    const {'1': 'min_sender_amount', '3': 20, '4': 1, '5': 1, '10': 'minSenderAmount'},
    const {'1': 'max_sender_amount', '3': 21, '4': 1, '5': 1, '10': 'maxSenderAmount'},
    const {'1': 'sender_fee', '3': 22, '4': 1, '5': 1, '10': 'senderFee'},
    const {'1': 'sender_fee_percentage', '3': 23, '4': 1, '5': 1, '10': 'senderFeePercentage'},
    const {'1': 'fixed_sender_denominations', '3': 24, '4': 3, '5': 11, '6': '.giftcards.GiftCardDenomination', '10': 'fixedSenderDenominations'},
  ],
};

/// Descriptor for `GiftCardBrand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardBrandDescriptor = $convert.base64Decode('Cg1HaWZ0Q2FyZEJyYW5kEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SJAoNZGVub21pbmF0aW9ucxgGIAMoAVINZGVub21pbmF0aW9ucxIdCgptaW5fYW1vdW50GAcgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgIIAEoAVIJbWF4QW1vdW50EhsKCWlzX2FjdGl2ZRgJIAEoCFIIaXNBY3RpdmUSMAoUdGVybXNfYW5kX2NvbmRpdGlvbnMYCiABKAlSEnRlcm1zQW5kQ29uZGl0aW9ucxIjCg1wcm92aWRlcl9uYW1lGBEgASgJUgxwcm92aWRlck5hbWUSHQoKcHJvZHVjdF9pZBgLIAEoA1IJcHJvZHVjdElkEiEKDGNvdW50cnlfY29kZRgMIAEoCVILY291bnRyeUNvZGUSUAoTZml4ZWRfZGVub21pbmF0aW9ucxgNIAMoCzIfLmdpZnRjYXJkcy5HaWZ0Q2FyZERlbm9taW5hdGlvblISZml4ZWREZW5vbWluYXRpb25zEi8KE2Rpc2NvdW50X3BlcmNlbnRhZ2UYDiABKAFSEmRpc2NvdW50UGVyY2VudGFnZRIjCg1jdXJyZW5jeV9jb2RlGA8gASgJUgxjdXJyZW5jeUNvZGUSNwoXcmVkZW1wdGlvbl9pbnN0cnVjdGlvbnMYECABKAlSFnJlZGVtcHRpb25JbnN0cnVjdGlvbnMSMAoUc2VuZGVyX2N1cnJlbmN5X2NvZGUYEiABKAlSEnNlbmRlckN1cnJlbmN5Q29kZRIxChRzZW5kZXJfZGVub21pbmF0aW9ucxgTIAMoAVITc2VuZGVyRGVub21pbmF0aW9ucxIqChFtaW5fc2VuZGVyX2Ftb3VudBgUIAEoAVIPbWluU2VuZGVyQW1vdW50EioKEW1heF9zZW5kZXJfYW1vdW50GBUgASgBUg9tYXhTZW5kZXJBbW91bnQSHQoKc2VuZGVyX2ZlZRgWIAEoAVIJc2VuZGVyRmVlEjIKFXNlbmRlcl9mZWVfcGVyY2VudGFnZRgXIAEoAVITc2VuZGVyRmVlUGVyY2VudGFnZRJdChpmaXhlZF9zZW5kZXJfZGVub21pbmF0aW9ucxgYIAMoCzIfLmdpZnRjYXJkcy5HaWZ0Q2FyZERlbm9taW5hdGlvblIYZml4ZWRTZW5kZXJEZW5vbWluYXRpb25z');
@$core.Deprecated('Use giftCardDenominationDescriptor instead')
const GiftCardDenomination$json = const {
  '1': 'GiftCardDenomination',
  '2': const [
    const {'1': 'price', '3': 1, '4': 1, '5': 1, '10': 'price'},
    const {'1': 'currency_code', '3': 2, '4': 1, '5': 9, '10': 'currencyCode'},
  ],
};

/// Descriptor for `GiftCardDenomination`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDenominationDescriptor = $convert.base64Decode('ChRHaWZ0Q2FyZERlbm9taW5hdGlvbhIUCgVwcmljZRgBIAEoAVIFcHJpY2USIwoNY3VycmVuY3lfY29kZRgCIAEoCVIMY3VycmVuY3lDb2Rl');
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
    const {'1': 'provider_transaction_id', '3': 10, '4': 1, '5': 9, '10': 'providerTransactionId'},
    const {'1': 'reference', '3': 11, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GiftCardTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardTransactionDescriptor = $convert.base64Decode('ChNHaWZ0Q2FyZFRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIgCgxnaWZ0X2NhcmRfaWQYAiABKAlSCmdpZnRDYXJkSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEikKEHRyYW5zYWN0aW9uX3R5cGUYBCABKAlSD3RyYW5zYWN0aW9uVHlwZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIlCg5iYWxhbmNlX2JlZm9yZRgGIAEoAVINYmFsYW5jZUJlZm9yZRIjCg1iYWxhbmNlX2FmdGVyGAcgASgBUgxiYWxhbmNlQWZ0ZXISIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEh0KCmNyZWF0ZWRfYXQYCSABKAlSCWNyZWF0ZWRBdBI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgKIAEoCVIVcHJvdmlkZXJUcmFuc2FjdGlvbklkEhwKCXJlZmVyZW5jZRgLIAEoCVIJcmVmZXJlbmNl');
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
    const {'1': 'provider_name', '3': 15, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'sender_name', '3': 10, '4': 1, '5': 9, '10': 'senderName'},
    const {'1': 'recipient_phone', '3': 11, '4': 1, '5': 9, '10': 'recipientPhone'},
    const {'1': 'product_id', '3': 12, '4': 1, '5': 3, '10': 'productId'},
    const {'1': 'country_code', '3': 13, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'quantity', '3': 14, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'sender_amount', '3': 16, '4': 1, '5': 1, '10': 'senderAmount'},
    const {'1': 'sender_currency', '3': 17, '4': 1, '5': 9, '10': 'senderCurrency'},
  ],
};

/// Descriptor for `BuyGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyGiftCardRequestDescriptor = $convert.base64Decode('ChJCdXlHaWZ0Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhkKCGJyYW5kX2lkGAIgASgJUgdicmFuZElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EicKD3JlY2lwaWVudF9lbWFpbBgEIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYBSABKAlSDXJlY2lwaWVudE5hbWUSIQoMZ2lmdF9tZXNzYWdlGAYgASgJUgtnaWZ0TWVzc2FnZRIlCg50cmFuc2FjdGlvbl9pZBgHIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YCCABKAlSEXZlcmlmaWNhdGlvblRva2VuEiMKDXByb3ZpZGVyX25hbWUYDyABKAlSDHByb3ZpZGVyTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2V5Eh8KC3NlbmRlcl9uYW1lGAogASgJUgpzZW5kZXJOYW1lEicKD3JlY2lwaWVudF9waG9uZRgLIAEoCVIOcmVjaXBpZW50UGhvbmUSHQoKcHJvZHVjdF9pZBgMIAEoA1IJcHJvZHVjdElkEiEKDGNvdW50cnlfY29kZRgNIAEoCVILY291bnRyeUNvZGUSGgoIcXVhbnRpdHkYDiABKAVSCHF1YW50aXR5EiMKDXNlbmRlcl9hbW91bnQYECABKAFSDHNlbmRlckFtb3VudBInCg9zZW5kZXJfY3VycmVuY3kYESABKAlSDnNlbmRlckN1cnJlbmN5');
@$core.Deprecated('Use buyGiftCardResponseDescriptor instead')
const BuyGiftCardResponse$json = const {
  '1': 'BuyGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'provider_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'providerTransactionId'},
    const {'1': 'sender_amount', '3': 5, '4': 1, '5': 1, '10': 'senderAmount'},
    const {'1': 'sender_currency', '3': 6, '4': 1, '5': 9, '10': 'senderCurrency'},
    const {'1': 'recipient_amount', '3': 7, '4': 1, '5': 1, '10': 'recipientAmount'},
    const {'1': 'recipient_currency', '3': 8, '4': 1, '5': 9, '10': 'recipientCurrency'},
  ],
};

/// Descriptor for `BuyGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyGiftCardResponseDescriptor = $convert.base64Decode('ChNCdXlHaWZ0Q2FyZFJlc3BvbnNlEjAKCWdpZnRfY2FyZBgBIAEoCzITLmdpZnRjYXJkcy5HaWZ0Q2FyZFIIZ2lmdENhcmQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgEIAEoCVIVcHJvdmlkZXJUcmFuc2FjdGlvbklkEiMKDXNlbmRlcl9hbW91bnQYBSABKAFSDHNlbmRlckFtb3VudBInCg9zZW5kZXJfY3VycmVuY3kYBiABKAlSDnNlbmRlckN1cnJlbmN5EikKEHJlY2lwaWVudF9hbW91bnQYByABKAFSD3JlY2lwaWVudEFtb3VudBItChJyZWNpcGllbnRfY3VycmVuY3kYCCABKAlSEXJlY2lwaWVudEN1cnJlbmN5');
@$core.Deprecated('Use getRedeemCodeRequestDescriptor instead')
const GetRedeemCodeRequest$json = const {
  '1': 'GetRedeemCodeRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'force_refresh', '3': 2, '4': 1, '5': 8, '10': 'forceRefresh'},
  ],
};

/// Descriptor for `GetRedeemCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRedeemCodeRequestDescriptor = $convert.base64Decode('ChRHZXRSZWRlZW1Db2RlUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIjCg1mb3JjZV9yZWZyZXNoGAIgASgIUgxmb3JjZVJlZnJlc2g=');
@$core.Deprecated('Use getRedeemCodeResponseDescriptor instead')
const GetRedeemCodeResponse$json = const {
  '1': 'GetRedeemCodeResponse',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'redemption_code', '3': 2, '4': 1, '5': 9, '10': 'redemptionCode'},
    const {'1': 'redemption_pin', '3': 3, '4': 1, '5': 9, '10': 'redemptionPin'},
    const {'1': 'brand_name', '3': 4, '4': 1, '5': 9, '10': 'brandName'},
    const {'1': 'redemption_instructions', '3': 5, '4': 1, '5': 9, '10': 'redemptionInstructions'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GetRedeemCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRedeemCodeResponseDescriptor = $convert.base64Decode('ChVHZXRSZWRlZW1Db2RlUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSJwoPcmVkZW1wdGlvbl9jb2RlGAIgASgJUg5yZWRlbXB0aW9uQ29kZRIlCg5yZWRlbXB0aW9uX3BpbhgDIAEoCVINcmVkZW1wdGlvblBpbhIdCgpicmFuZF9uYW1lGAQgASgJUglicmFuZE5hbWUSNwoXcmVkZW1wdGlvbl9pbnN0cnVjdGlvbnMYBSABKAlSFnJlZGVtcHRpb25JbnN0cnVjdGlvbnMSFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSGAoHbWVzc2FnZRgHIAEoCVIHbWVzc2FnZQ==');
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
    const {'1': 'recipient_user_id', '3': 7, '4': 1, '5': 9, '10': 'recipientUserId'},
    const {'1': 'transfer_type', '3': 8, '4': 1, '5': 9, '10': 'transferType'},
  ],
};

/// Descriptor for `TransferGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardRequestDescriptor = $convert.base64Decode('ChdUcmFuc2ZlckdpZnRDYXJkUmVxdWVzdBIgCgxnaWZ0X2NhcmRfaWQYASABKAlSCmdpZnRDYXJkSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGllbnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlEiUKDnRyYW5zYWN0aW9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SKgoRcmVjaXBpZW50X3VzZXJfaWQYByABKAlSD3JlY2lwaWVudFVzZXJJZBIjCg10cmFuc2Zlcl90eXBlGAggASgJUgx0cmFuc2ZlclR5cGU=');
@$core.Deprecated('Use transferGiftCardResponseDescriptor instead')
const TransferGiftCardResponse$json = const {
  '1': 'TransferGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'recipient_gift_card', '3': 3, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'recipientGiftCard'},
  ],
};

/// Descriptor for `TransferGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardResponseDescriptor = $convert.base64Decode('ChhUcmFuc2ZlckdpZnRDYXJkUmVzcG9uc2USMAoJZ2lmdF9jYXJkGAEgASgLMhMuZ2lmdGNhcmRzLkdpZnRDYXJkUghnaWZ0Q2FyZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEkMKE3JlY2lwaWVudF9naWZ0X2NhcmQYAyABKAsyEy5naWZ0Y2FyZHMuR2lmdENhcmRSEXJlY2lwaWVudEdpZnRDYXJk');
@$core.Deprecated('Use getGiftCardBrandsRequestDescriptor instead')
const GetGiftCardBrandsRequest$json = const {
  '1': 'GetGiftCardBrandsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
    const {'1': 'country_code', '3': 3, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'page_size', '3': 5, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'search_query', '3': 6, '4': 1, '5': 9, '10': 'searchQuery'},
  ],
};

/// Descriptor for `GetGiftCardBrandsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBrandsRequestDescriptor = $convert.base64Decode('ChhHZXRHaWZ0Q2FyZEJyYW5kc1JlcXVlc3QSGgoIY2F0ZWdvcnkYASABKAlSCGNhdGVnb3J5Eh8KC2FjdGl2ZV9vbmx5GAIgASgIUgphY3RpdmVPbmx5EiEKDGNvdW50cnlfY29kZRgDIAEoCVILY291bnRyeUNvZGUSEgoEcGFnZRgEIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYBSABKAVSCHBhZ2VTaXplEiEKDHNlYXJjaF9xdWVyeRgGIAEoCVILc2VhcmNoUXVlcnk=');
@$core.Deprecated('Use getGiftCardBrandsResponseDescriptor instead')
const GetGiftCardBrandsResponse$json = const {
  '1': 'GetGiftCardBrandsResponse',
  '2': const [
    const {'1': 'brands', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardBrand', '10': 'brands'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_pages', '3': 3, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'current_page', '3': 4, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'page_size', '3': 6, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetGiftCardBrandsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBrandsResponseDescriptor = $convert.base64Decode('ChlHZXRHaWZ0Q2FyZEJyYW5kc1Jlc3BvbnNlEjAKBmJyYW5kcxgBIAMoCzIYLmdpZnRjYXJkcy5HaWZ0Q2FyZEJyYW5kUgZicmFuZHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEh8KC3RvdGFsX3BhZ2VzGAMgASgFUgp0b3RhbFBhZ2VzEiEKDGN1cnJlbnRfcGFnZRgEIAEoBVILY3VycmVudFBhZ2USGQoIaGFzX25leHQYBSABKAhSB2hhc05leHQSGwoJcGFnZV9zaXplGAYgASgFUghwYWdlU2l6ZQ==');
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
@$core.Deprecated('Use sellableCardDescriptor instead')
const SellableCard$json = const {
  '1': 'SellableCard',
  '2': const [
    const {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'denominations', '3': 5, '4': 3, '5': 1, '10': 'denominations'},
    const {'1': 'currencies', '3': 6, '4': 3, '5': 9, '10': 'currencies'},
    const {'1': 'min_denomination', '3': 7, '4': 1, '5': 1, '10': 'minDenomination'},
    const {'1': 'max_denomination', '3': 8, '4': 1, '5': 1, '10': 'maxDenomination'},
    const {'1': 'provider_name', '3': 9, '4': 1, '5': 9, '10': 'providerName'},
  ],
};

/// Descriptor for `SellableCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellableCardDescriptor = $convert.base64Decode('CgxTZWxsYWJsZUNhcmQSGwoJY2FyZF90eXBlGAEgASgJUghjYXJkVHlwZRIhCgxkaXNwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIkCg1kZW5vbWluYXRpb25zGAUgAygBUg1kZW5vbWluYXRpb25zEh4KCmN1cnJlbmNpZXMYBiADKAlSCmN1cnJlbmNpZXMSKQoQbWluX2Rlbm9taW5hdGlvbhgHIAEoAVIPbWluRGVub21pbmF0aW9uEikKEG1heF9kZW5vbWluYXRpb24YCCABKAFSD21heERlbm9taW5hdGlvbhIjCg1wcm92aWRlcl9uYW1lGAkgASgJUgxwcm92aWRlck5hbWU=');
@$core.Deprecated('Use sellRateDescriptor instead')
const SellRate$json = const {
  '1': 'SellRate',
  '2': const [
    const {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'denomination', '3': 2, '4': 1, '5': 1, '10': 'denomination'},
    const {'1': 'rate_percentage', '3': 3, '4': 1, '5': 1, '10': 'ratePercentage'},
    const {'1': 'payout_amount', '3': 4, '4': 1, '5': 1, '10': 'payoutAmount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'expires_at', '3': 6, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `SellRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellRateDescriptor = $convert.base64Decode('CghTZWxsUmF0ZRIbCgljYXJkX3R5cGUYASABKAlSCGNhcmRUeXBlEiIKDGRlbm9taW5hdGlvbhgCIAEoAVIMZGVub21pbmF0aW9uEicKD3JhdGVfcGVyY2VudGFnZRgDIAEoAVIOcmF0ZVBlcmNlbnRhZ2USIwoNcGF5b3V0X2Ftb3VudBgEIAEoAVIMcGF5b3V0QW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIdCgpleHBpcmVzX2F0GAYgASgJUglleHBpcmVzQXQ=');
@$core.Deprecated('Use giftCardSaleDescriptor instead')
const GiftCardSale$json = const {
  '1': 'GiftCardSale',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'card_type', '3': 4, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'card_number', '3': 5, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'denomination', '3': 6, '4': 1, '5': 1, '10': 'denomination'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'rate_percentage', '3': 8, '4': 1, '5': 1, '10': 'ratePercentage'},
    const {'1': 'expected_payout', '3': 9, '4': 1, '5': 1, '10': 'expectedPayout'},
    const {'1': 'actual_payout', '3': 10, '4': 1, '5': 1, '10': 'actualPayout'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'provider_sale_id', '3': 12, '4': 1, '5': 9, '10': 'providerSaleId'},
    const {'1': 'provider_name', '3': 13, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'reference', '3': 14, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'submitted_at', '3': 15, '4': 1, '5': 9, '10': 'submittedAt'},
    const {'1': 'reviewed_at', '3': 16, '4': 1, '5': 9, '10': 'reviewedAt'},
    const {'1': 'paid_at', '3': 17, '4': 1, '5': 9, '10': 'paidAt'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'image_urls', '3': 20, '4': 3, '5': 9, '10': 'imageUrls'},
    const {'1': 'ocr_brand', '3': 21, '4': 1, '5': 9, '10': 'ocrBrand'},
    const {'1': 'ocr_card_number', '3': 22, '4': 1, '5': 9, '10': 'ocrCardNumber'},
    const {'1': 'ocr_pin', '3': 23, '4': 1, '5': 9, '10': 'ocrPin'},
    const {'1': 'ocr_denomination', '3': 24, '4': 1, '5': 1, '10': 'ocrDenomination'},
    const {'1': 'ocr_currency', '3': 25, '4': 1, '5': 9, '10': 'ocrCurrency'},
    const {'1': 'admin_reviewer_id', '3': 26, '4': 1, '5': 9, '10': 'adminReviewerId'},
    const {'1': 'rejection_reason', '3': 27, '4': 1, '5': 9, '10': 'rejectionReason'},
    const {'1': 'admin_notes', '3': 28, '4': 1, '5': 9, '10': 'adminNotes'},
    const {'1': 'card_pin', '3': 29, '4': 1, '5': 9, '10': 'cardPin'},
    const {'1': 'exit_rate_percent', '3': 30, '4': 1, '5': 1, '10': 'exitRatePercent'},
    const {'1': 'base_margin_percent', '3': 31, '4': 1, '5': 1, '10': 'baseMarginPercent'},
    const {'1': 'risk_buffer_percent', '3': 32, '4': 1, '5': 1, '10': 'riskBufferPercent'},
    const {'1': 'commission_amount', '3': 33, '4': 1, '5': 1, '10': 'commissionAmount'},
    const {'1': 'risk_score', '3': 34, '4': 1, '5': 5, '10': 'riskScore'},
    const {'1': 'risk_level', '3': 35, '4': 1, '5': 9, '10': 'riskLevel'},
    const {'1': 'risk_flags', '3': 36, '4': 3, '5': 9, '10': 'riskFlags'},
    const {'1': 'risk_action', '3': 37, '4': 1, '5': 9, '10': 'riskAction'},
    const {'1': 'card_country', '3': 38, '4': 1, '5': 9, '10': 'cardCountry'},
    const {'1': 'card_format', '3': 39, '4': 1, '5': 9, '10': 'cardFormat'},
  ],
};

/// Descriptor for `GiftCardSale`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardSaleDescriptor = $convert.base64Decode('CgxHaWZ0Q2FyZFNhbGUSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSGwoJY2FyZF90eXBlGAQgASgJUghjYXJkVHlwZRIfCgtjYXJkX251bWJlchgFIAEoCVIKY2FyZE51bWJlchIiCgxkZW5vbWluYXRpb24YBiABKAFSDGRlbm9taW5hdGlvbhIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSJwoPcmF0ZV9wZXJjZW50YWdlGAggASgBUg5yYXRlUGVyY2VudGFnZRInCg9leHBlY3RlZF9wYXlvdXQYCSABKAFSDmV4cGVjdGVkUGF5b3V0EiMKDWFjdHVhbF9wYXlvdXQYCiABKAFSDGFjdHVhbFBheW91dBIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxIoChBwcm92aWRlcl9zYWxlX2lkGAwgASgJUg5wcm92aWRlclNhbGVJZBIjCg1wcm92aWRlcl9uYW1lGA0gASgJUgxwcm92aWRlck5hbWUSHAoJcmVmZXJlbmNlGA4gASgJUglyZWZlcmVuY2USIQoMc3VibWl0dGVkX2F0GA8gASgJUgtzdWJtaXR0ZWRBdBIfCgtyZXZpZXdlZF9hdBgQIAEoCVIKcmV2aWV3ZWRBdBIXCgdwYWlkX2F0GBEgASgJUgZwYWlkQXQSHQoKY3JlYXRlZF9hdBgSIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYEyABKAlSCXVwZGF0ZWRBdBIdCgppbWFnZV91cmxzGBQgAygJUglpbWFnZVVybHMSGwoJb2NyX2JyYW5kGBUgASgJUghvY3JCcmFuZBImCg9vY3JfY2FyZF9udW1iZXIYFiABKAlSDW9jckNhcmROdW1iZXISFwoHb2NyX3BpbhgXIAEoCVIGb2NyUGluEikKEG9jcl9kZW5vbWluYXRpb24YGCABKAFSD29jckRlbm9taW5hdGlvbhIhCgxvY3JfY3VycmVuY3kYGSABKAlSC29jckN1cnJlbmN5EioKEWFkbWluX3Jldmlld2VyX2lkGBogASgJUg9hZG1pblJldmlld2VySWQSKQoQcmVqZWN0aW9uX3JlYXNvbhgbIAEoCVIPcmVqZWN0aW9uUmVhc29uEh8KC2FkbWluX25vdGVzGBwgASgJUgphZG1pbk5vdGVzEhkKCGNhcmRfcGluGB0gASgJUgdjYXJkUGluEioKEWV4aXRfcmF0ZV9wZXJjZW50GB4gASgBUg9leGl0UmF0ZVBlcmNlbnQSLgoTYmFzZV9tYXJnaW5fcGVyY2VudBgfIAEoAVIRYmFzZU1hcmdpblBlcmNlbnQSLgoTcmlza19idWZmZXJfcGVyY2VudBggIAEoAVIRcmlza0J1ZmZlclBlcmNlbnQSKwoRY29tbWlzc2lvbl9hbW91bnQYISABKAFSEGNvbW1pc3Npb25BbW91bnQSHQoKcmlza19zY29yZRgiIAEoBVIJcmlza1Njb3JlEh0KCnJpc2tfbGV2ZWwYIyABKAlSCXJpc2tMZXZlbBIdCgpyaXNrX2ZsYWdzGCQgAygJUglyaXNrRmxhZ3MSHwoLcmlza19hY3Rpb24YJSABKAlSCnJpc2tBY3Rpb24SIQoMY2FyZF9jb3VudHJ5GCYgASgJUgtjYXJkQ291bnRyeRIfCgtjYXJkX2Zvcm1hdBgnIAEoCVIKY2FyZEZvcm1hdA==');
@$core.Deprecated('Use getSellableCardsRequestDescriptor instead')
const GetSellableCardsRequest$json = const {
  '1': 'GetSellableCardsRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetSellableCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellableCardsRequestDescriptor = $convert.base64Decode('ChdHZXRTZWxsYWJsZUNhcmRzUmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2NvdW50cnlDb2Rl');
@$core.Deprecated('Use getSellableCardsResponseDescriptor instead')
const GetSellableCardsResponse$json = const {
  '1': 'GetSellableCardsResponse',
  '2': const [
    const {'1': 'cards', '3': 1, '4': 3, '5': 11, '6': '.giftcards.SellableCard', '10': 'cards'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetSellableCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellableCardsResponseDescriptor = $convert.base64Decode('ChhHZXRTZWxsYWJsZUNhcmRzUmVzcG9uc2USLQoFY2FyZHMYASADKAsyFy5naWZ0Y2FyZHMuU2VsbGFibGVDYXJkUgVjYXJkcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use getSellRateRequestDescriptor instead')
const GetSellRateRequest$json = const {
  '1': 'GetSellRateRequest',
  '2': const [
    const {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'denomination', '3': 2, '4': 1, '5': 1, '10': 'denomination'},
  ],
};

/// Descriptor for `GetSellRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellRateRequestDescriptor = $convert.base64Decode('ChJHZXRTZWxsUmF0ZVJlcXVlc3QSGwoJY2FyZF90eXBlGAEgASgJUghjYXJkVHlwZRIiCgxkZW5vbWluYXRpb24YAiABKAFSDGRlbm9taW5hdGlvbg==');
@$core.Deprecated('Use getSellRateResponseDescriptor instead')
const GetSellRateResponse$json = const {
  '1': 'GetSellRateResponse',
  '2': const [
    const {'1': 'rate', '3': 1, '4': 1, '5': 11, '6': '.giftcards.SellRate', '10': 'rate'},
  ],
};

/// Descriptor for `GetSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellRateResponseDescriptor = $convert.base64Decode('ChNHZXRTZWxsUmF0ZVJlc3BvbnNlEicKBHJhdGUYASABKAsyEy5naWZ0Y2FyZHMuU2VsbFJhdGVSBHJhdGU=');
@$core.Deprecated('Use getSellProviderRequestDescriptor instead')
const GetSellProviderRequest$json = const {
  '1': 'GetSellProviderRequest',
};

/// Descriptor for `GetSellProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellProviderRequestDescriptor = $convert.base64Decode('ChZHZXRTZWxsUHJvdmlkZXJSZXF1ZXN0');
@$core.Deprecated('Use getSellProviderResponseDescriptor instead')
const GetSellProviderResponse$json = const {
  '1': 'GetSellProviderResponse',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `GetSellProviderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellProviderResponseDescriptor = $convert.base64Decode('ChdHZXRTZWxsUHJvdmlkZXJSZXNwb25zZRIaCghwcm92aWRlchgBIAEoCVIIcHJvdmlkZXISIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use sellGiftCardRequestDescriptor instead')
const SellGiftCardRequest$json = const {
  '1': 'SellGiftCardRequest',
  '2': const [
    const {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'card_number', '3': 2, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'card_pin', '3': 3, '4': 1, '5': 9, '10': 'cardPin'},
    const {'1': 'denomination', '3': 4, '4': 1, '5': 1, '10': 'denomination'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'images', '3': 6, '4': 3, '5': 9, '10': 'images'},
    const {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'transaction_id', '3': 8, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 9, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'provider_name', '3': 10, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'image_urls', '3': 11, '4': 3, '5': 9, '10': 'imageUrls'},
    const {'1': 'image_keys', '3': 12, '4': 3, '5': 9, '10': 'imageKeys'},
    const {'1': 'ocr_brand', '3': 13, '4': 1, '5': 9, '10': 'ocrBrand'},
    const {'1': 'ocr_card_number', '3': 14, '4': 1, '5': 9, '10': 'ocrCardNumber'},
    const {'1': 'ocr_pin', '3': 15, '4': 1, '5': 9, '10': 'ocrPin'},
    const {'1': 'ocr_denomination', '3': 16, '4': 1, '5': 1, '10': 'ocrDenomination'},
    const {'1': 'ocr_currency', '3': 17, '4': 1, '5': 9, '10': 'ocrCurrency'},
    const {'1': 'card_country', '3': 18, '4': 1, '5': 9, '10': 'cardCountry'},
    const {'1': 'card_format', '3': 19, '4': 1, '5': 9, '10': 'cardFormat'},
  ],
};

/// Descriptor for `SellGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardRequestDescriptor = $convert.base64Decode('ChNTZWxsR2lmdENhcmRSZXF1ZXN0EhsKCWNhcmRfdHlwZRgBIAEoCVIIY2FyZFR5cGUSHwoLY2FyZF9udW1iZXIYAiABKAlSCmNhcmROdW1iZXISGQoIY2FyZF9waW4YAyABKAlSB2NhcmRQaW4SIgoMZGVub21pbmF0aW9uGAQgASgBUgxkZW5vbWluYXRpb24SGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhYKBmltYWdlcxgGIAMoCVIGaW1hZ2VzEicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVuY3lLZXkSJQoOdHJhbnNhY3Rpb25faWQYCCABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAkgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIjCg1wcm92aWRlcl9uYW1lGAogASgJUgxwcm92aWRlck5hbWUSHQoKaW1hZ2VfdXJscxgLIAMoCVIJaW1hZ2VVcmxzEh0KCmltYWdlX2tleXMYDCADKAlSCWltYWdlS2V5cxIbCglvY3JfYnJhbmQYDSABKAlSCG9jckJyYW5kEiYKD29jcl9jYXJkX251bWJlchgOIAEoCVINb2NyQ2FyZE51bWJlchIXCgdvY3JfcGluGA8gASgJUgZvY3JQaW4SKQoQb2NyX2Rlbm9taW5hdGlvbhgQIAEoAVIPb2NyRGVub21pbmF0aW9uEiEKDG9jcl9jdXJyZW5jeRgRIAEoCVILb2NyQ3VycmVuY3kSIQoMY2FyZF9jb3VudHJ5GBIgASgJUgtjYXJkQ291bnRyeRIfCgtjYXJkX2Zvcm1hdBgTIAEoCVIKY2FyZEZvcm1hdA==');
@$core.Deprecated('Use sellGiftCardResponseDescriptor instead')
const SellGiftCardResponse$json = const {
  '1': 'SellGiftCardResponse',
  '2': const [
    const {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SellGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardResponseDescriptor = $convert.base64Decode('ChRTZWxsR2lmdENhcmRSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLkdpZnRDYXJkU2FsZVIEc2FsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getSellStatusRequestDescriptor instead')
const GetSellStatusRequest$json = const {
  '1': 'GetSellStatusRequest',
  '2': const [
    const {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
  ],
};

/// Descriptor for `GetSellStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellStatusRequestDescriptor = $convert.base64Decode('ChRHZXRTZWxsU3RhdHVzUmVxdWVzdBIXCgdzYWxlX2lkGAEgASgJUgZzYWxlSWQ=');
@$core.Deprecated('Use getSellStatusResponseDescriptor instead')
const GetSellStatusResponse$json = const {
  '1': 'GetSellStatusResponse',
  '2': const [
    const {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
  ],
};

/// Descriptor for `GetSellStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellStatusResponseDescriptor = $convert.base64Decode('ChVHZXRTZWxsU3RhdHVzUmVzcG9uc2USKwoEc2FsZRgBIAEoCzIXLmdpZnRjYXJkcy5HaWZ0Q2FyZFNhbGVSBHNhbGU=');
@$core.Deprecated('Use getMySalesRequestDescriptor instead')
const GetMySalesRequest$json = const {
  '1': 'GetMySalesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetMySalesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMySalesRequestDescriptor = $convert.base64Decode('ChFHZXRNeVNhbGVzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getMySalesResponseDescriptor instead')
const GetMySalesResponse$json = const {
  '1': 'GetMySalesResponse',
  '2': const [
    const {'1': 'sales', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sales'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMySalesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMySalesResponseDescriptor = $convert.base64Decode('ChJHZXRNeVNhbGVzUmVzcG9uc2USLQoFc2FsZXMYASADKAsyFy5naWZ0Y2FyZHMuR2lmdENhcmRTYWxlUgVzYWxlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use uploadSellImageRequestDescriptor instead')
const UploadSellImageRequest$json = const {
  '1': 'UploadSellImageRequest',
  '2': const [
    const {'1': 'image_data', '3': 1, '4': 1, '5': 9, '10': 'imageData'},
    const {'1': 'content_type', '3': 2, '4': 1, '5': 9, '10': 'contentType'},
    const {'1': 'filename', '3': 3, '4': 1, '5': 9, '10': 'filename'},
  ],
};

/// Descriptor for `UploadSellImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadSellImageRequestDescriptor = $convert.base64Decode('ChZVcGxvYWRTZWxsSW1hZ2VSZXF1ZXN0Eh0KCmltYWdlX2RhdGEYASABKAlSCWltYWdlRGF0YRIhCgxjb250ZW50X3R5cGUYAiABKAlSC2NvbnRlbnRUeXBlEhoKCGZpbGVuYW1lGAMgASgJUghmaWxlbmFtZQ==');
@$core.Deprecated('Use uploadSellImageResponseDescriptor instead')
const UploadSellImageResponse$json = const {
  '1': 'UploadSellImageResponse',
  '2': const [
    const {'1': 'image_url', '3': 1, '4': 1, '5': 9, '10': 'imageUrl'},
    const {'1': 'image_key', '3': 2, '4': 1, '5': 9, '10': 'imageKey'},
  ],
};

/// Descriptor for `UploadSellImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadSellImageResponseDescriptor = $convert.base64Decode('ChdVcGxvYWRTZWxsSW1hZ2VSZXNwb25zZRIbCglpbWFnZV91cmwYASABKAlSCGltYWdlVXJsEhsKCWltYWdlX2tleRgCIAEoCVIIaW1hZ2VLZXk=');
@$core.Deprecated('Use extractCardDetailsRequestDescriptor instead')
const ExtractCardDetailsRequest$json = const {
  '1': 'ExtractCardDetailsRequest',
  '2': const [
    const {'1': 'image_urls', '3': 1, '4': 3, '5': 9, '10': 'imageUrls'},
  ],
};

/// Descriptor for `ExtractCardDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractCardDetailsRequestDescriptor = $convert.base64Decode('ChlFeHRyYWN0Q2FyZERldGFpbHNSZXF1ZXN0Eh0KCmltYWdlX3VybHMYASADKAlSCWltYWdlVXJscw==');
@$core.Deprecated('Use extractCardDetailsResponseDescriptor instead')
const ExtractCardDetailsResponse$json = const {
  '1': 'ExtractCardDetailsResponse',
  '2': const [
    const {'1': 'brand', '3': 1, '4': 1, '5': 9, '10': 'brand'},
    const {'1': 'card_number', '3': 2, '4': 1, '5': 9, '10': 'cardNumber'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'denomination', '3': 4, '4': 1, '5': 1, '10': 'denomination'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'confidence', '3': 6, '4': 1, '5': 1, '10': 'confidence'},
    const {'1': 'raw_text', '3': 7, '4': 1, '5': 9, '10': 'rawText'},
  ],
};

/// Descriptor for `ExtractCardDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractCardDetailsResponseDescriptor = $convert.base64Decode('ChpFeHRyYWN0Q2FyZERldGFpbHNSZXNwb25zZRIUCgVicmFuZBgBIAEoCVIFYnJhbmQSHwoLY2FyZF9udW1iZXIYAiABKAlSCmNhcmROdW1iZXISEAoDcGluGAMgASgJUgNwaW4SIgoMZGVub21pbmF0aW9uGAQgASgBUgxkZW5vbWluYXRpb24SGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5Eh4KCmNvbmZpZGVuY2UYBiABKAFSCmNvbmZpZGVuY2USGQoIcmF3X3RleHQYByABKAlSB3Jhd1RleHQ=');
@$core.Deprecated('Use adminListPendingSalesRequestDescriptor instead')
const AdminListPendingSalesRequest$json = const {
  '1': 'AdminListPendingSalesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `AdminListPendingSalesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListPendingSalesRequestDescriptor = $convert.base64Decode('ChxBZG1pbkxpc3RQZW5kaW5nU2FsZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldA==');
@$core.Deprecated('Use adminListPendingSalesResponseDescriptor instead')
const AdminListPendingSalesResponse$json = const {
  '1': 'AdminListPendingSalesResponse',
  '2': const [
    const {'1': 'sales', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sales'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListPendingSalesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListPendingSalesResponseDescriptor = $convert.base64Decode('Ch1BZG1pbkxpc3RQZW5kaW5nU2FsZXNSZXNwb25zZRItCgVzYWxlcxgBIAMoCzIXLmdpZnRjYXJkcy5HaWZ0Q2FyZFNhbGVSBXNhbGVzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use adminGetSaleDetailRequestDescriptor instead')
const AdminGetSaleDetailRequest$json = const {
  '1': 'AdminGetSaleDetailRequest',
  '2': const [
    const {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
  ],
};

/// Descriptor for `AdminGetSaleDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSaleDetailRequestDescriptor = $convert.base64Decode('ChlBZG1pbkdldFNhbGVEZXRhaWxSZXF1ZXN0EhcKB3NhbGVfaWQYASABKAlSBnNhbGVJZA==');
@$core.Deprecated('Use adminGetSaleDetailResponseDescriptor instead')
const AdminGetSaleDetailResponse$json = const {
  '1': 'AdminGetSaleDetailResponse',
  '2': const [
    const {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    const {'1': 'image_download_urls', '3': 2, '4': 3, '5': 9, '10': 'imageDownloadUrls'},
    const {'1': 'user_email', '3': 3, '4': 1, '5': 9, '10': 'userEmail'},
    const {'1': 'user_name', '3': 4, '4': 1, '5': 9, '10': 'userName'},
  ],
};

/// Descriptor for `AdminGetSaleDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSaleDetailResponseDescriptor = $convert.base64Decode('ChpBZG1pbkdldFNhbGVEZXRhaWxSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLkdpZnRDYXJkU2FsZVIEc2FsZRIuChNpbWFnZV9kb3dubG9hZF91cmxzGAIgAygJUhFpbWFnZURvd25sb2FkVXJscxIdCgp1c2VyX2VtYWlsGAMgASgJUgl1c2VyRW1haWwSGwoJdXNlcl9uYW1lGAQgASgJUgh1c2VyTmFtZQ==');
@$core.Deprecated('Use adminApproveSaleRequestDescriptor instead')
const AdminApproveSaleRequest$json = const {
  '1': 'AdminApproveSaleRequest',
  '2': const [
    const {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
    const {'1': 'admin_notes', '3': 2, '4': 1, '5': 9, '10': 'adminNotes'},
  ],
};

/// Descriptor for `AdminApproveSaleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminApproveSaleRequestDescriptor = $convert.base64Decode('ChdBZG1pbkFwcHJvdmVTYWxlUmVxdWVzdBIXCgdzYWxlX2lkGAEgASgJUgZzYWxlSWQSHwoLYWRtaW5fbm90ZXMYAiABKAlSCmFkbWluTm90ZXM=');
@$core.Deprecated('Use adminApproveSaleResponseDescriptor instead')
const AdminApproveSaleResponse$json = const {
  '1': 'AdminApproveSaleResponse',
  '2': const [
    const {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminApproveSaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminApproveSaleResponseDescriptor = $convert.base64Decode('ChhBZG1pbkFwcHJvdmVTYWxlUmVzcG9uc2USKwoEc2FsZRgBIAEoCzIXLmdpZnRjYXJkcy5HaWZ0Q2FyZFNhbGVSBHNhbGUSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use adminRejectSaleRequestDescriptor instead')
const AdminRejectSaleRequest$json = const {
  '1': 'AdminRejectSaleRequest',
  '2': const [
    const {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'admin_notes', '3': 3, '4': 1, '5': 9, '10': 'adminNotes'},
  ],
};

/// Descriptor for `AdminRejectSaleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRejectSaleRequestDescriptor = $convert.base64Decode('ChZBZG1pblJlamVjdFNhbGVSZXF1ZXN0EhcKB3NhbGVfaWQYASABKAlSBnNhbGVJZBIWCgZyZWFzb24YAiABKAlSBnJlYXNvbhIfCgthZG1pbl9ub3RlcxgDIAEoCVIKYWRtaW5Ob3Rlcw==');
@$core.Deprecated('Use adminRejectSaleResponseDescriptor instead')
const AdminRejectSaleResponse$json = const {
  '1': 'AdminRejectSaleResponse',
  '2': const [
    const {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminRejectSaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRejectSaleResponseDescriptor = $convert.base64Decode('ChdBZG1pblJlamVjdFNhbGVSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLkdpZnRDYXJkU2FsZVIEc2FsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use sellRateConfigDescriptor instead')
const SellRateConfig$json = const {
  '1': 'SellRateConfig',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'card_brand', '3': 2, '4': 1, '5': 9, '10': 'cardBrand'},
    const {'1': 'card_type_slug', '3': 3, '4': 1, '5': 9, '10': 'cardTypeSlug'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'denominations', '3': 6, '4': 3, '5': 1, '10': 'denominations'},
    const {'1': 'currencies', '3': 7, '4': 3, '5': 9, '10': 'currencies'},
    const {'1': 'countries', '3': 8, '4': 3, '5': 9, '10': 'countries'},
    const {'1': 'min_denomination', '3': 9, '4': 1, '5': 1, '10': 'minDenomination'},
    const {'1': 'max_denomination', '3': 10, '4': 1, '5': 1, '10': 'maxDenomination'},
    const {'1': 'buy_rate_percentage', '3': 11, '4': 1, '5': 1, '10': 'buyRatePercentage'},
    const {'1': 'commission_percentage', '3': 12, '4': 1, '5': 1, '10': 'commissionPercentage'},
    const {'1': 'payout_rate_percentage', '3': 13, '4': 1, '5': 1, '10': 'payoutRatePercentage'},
    const {'1': 'payout_currency', '3': 14, '4': 1, '5': 9, '10': 'payoutCurrency'},
    const {'1': 'card_type', '3': 15, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'is_active', '3': 16, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SellRateConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellRateConfigDescriptor = $convert.base64Decode('Cg5TZWxsUmF0ZUNvbmZpZxIOCgJpZBgBIAEoCVICaWQSHQoKY2FyZF9icmFuZBgCIAEoCVIJY2FyZEJyYW5kEiQKDmNhcmRfdHlwZV9zbHVnGAMgASgJUgxjYXJkVHlwZVNsdWcSGQoIbG9nb191cmwYBCABKAlSB2xvZ29VcmwSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EiQKDWRlbm9taW5hdGlvbnMYBiADKAFSDWRlbm9taW5hdGlvbnMSHgoKY3VycmVuY2llcxgHIAMoCVIKY3VycmVuY2llcxIcCgljb3VudHJpZXMYCCADKAlSCWNvdW50cmllcxIpChBtaW5fZGVub21pbmF0aW9uGAkgASgBUg9taW5EZW5vbWluYXRpb24SKQoQbWF4X2Rlbm9taW5hdGlvbhgKIAEoAVIPbWF4RGVub21pbmF0aW9uEi4KE2J1eV9yYXRlX3BlcmNlbnRhZ2UYCyABKAFSEWJ1eVJhdGVQZXJjZW50YWdlEjMKFWNvbW1pc3Npb25fcGVyY2VudGFnZRgMIAEoAVIUY29tbWlzc2lvblBlcmNlbnRhZ2USNAoWcGF5b3V0X3JhdGVfcGVyY2VudGFnZRgNIAEoAVIUcGF5b3V0UmF0ZVBlcmNlbnRhZ2USJwoPcGF5b3V0X2N1cnJlbmN5GA4gASgJUg5wYXlvdXRDdXJyZW5jeRIbCgljYXJkX3R5cGUYDyABKAlSCGNhcmRUeXBlEhsKCWlzX2FjdGl2ZRgQIAEoCFIIaXNBY3RpdmUSHQoKY3JlYXRlZF9hdBgRIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYEiABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use adminListSellRatesRequestDescriptor instead')
const AdminListSellRatesRequest$json = const {
  '1': 'AdminListSellRatesRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `AdminListSellRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellRatesRequestDescriptor = $convert.base64Decode('ChlBZG1pbkxpc3RTZWxsUmF0ZXNSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ29yeRIfCgthY3RpdmVfb25seRgCIAEoCFIKYWN0aXZlT25seRIUCgVsaW1pdBgDIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAQgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use adminListSellRatesResponseDescriptor instead')
const AdminListSellRatesResponse$json = const {
  '1': 'AdminListSellRatesResponse',
  '2': const [
    const {'1': 'rates', '3': 1, '4': 3, '5': 11, '6': '.giftcards.SellRateConfig', '10': 'rates'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListSellRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellRatesResponseDescriptor = $convert.base64Decode('ChpBZG1pbkxpc3RTZWxsUmF0ZXNSZXNwb25zZRIvCgVyYXRlcxgBIAMoCzIZLmdpZnRjYXJkcy5TZWxsUmF0ZUNvbmZpZ1IFcmF0ZXMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use adminCreateSellRateRequestDescriptor instead')
const AdminCreateSellRateRequest$json = const {
  '1': 'AdminCreateSellRateRequest',
  '2': const [
    const {'1': 'card_brand', '3': 1, '4': 1, '5': 9, '10': 'cardBrand'},
    const {'1': 'card_type_slug', '3': 2, '4': 1, '5': 9, '10': 'cardTypeSlug'},
    const {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'denominations', '3': 5, '4': 3, '5': 1, '10': 'denominations'},
    const {'1': 'currencies', '3': 6, '4': 3, '5': 9, '10': 'currencies'},
    const {'1': 'countries', '3': 7, '4': 3, '5': 9, '10': 'countries'},
    const {'1': 'min_denomination', '3': 8, '4': 1, '5': 1, '10': 'minDenomination'},
    const {'1': 'max_denomination', '3': 9, '4': 1, '5': 1, '10': 'maxDenomination'},
    const {'1': 'buy_rate_percentage', '3': 10, '4': 1, '5': 1, '10': 'buyRatePercentage'},
    const {'1': 'commission_percentage', '3': 11, '4': 1, '5': 1, '10': 'commissionPercentage'},
    const {'1': 'payout_rate_percentage', '3': 12, '4': 1, '5': 1, '10': 'payoutRatePercentage'},
    const {'1': 'payout_currency', '3': 13, '4': 1, '5': 9, '10': 'payoutCurrency'},
    const {'1': 'card_type', '3': 14, '4': 1, '5': 9, '10': 'cardType'},
  ],
};

/// Descriptor for `AdminCreateSellRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCreateSellRateRequestDescriptor = $convert.base64Decode('ChpBZG1pbkNyZWF0ZVNlbGxSYXRlUmVxdWVzdBIdCgpjYXJkX2JyYW5kGAEgASgJUgljYXJkQnJhbmQSJAoOY2FyZF90eXBlX3NsdWcYAiABKAlSDGNhcmRUeXBlU2x1ZxIZCghsb2dvX3VybBgDIAEoCVIHbG9nb1VybBIaCghjYXRlZ29yeRgEIAEoCVIIY2F0ZWdvcnkSJAoNZGVub21pbmF0aW9ucxgFIAMoAVINZGVub21pbmF0aW9ucxIeCgpjdXJyZW5jaWVzGAYgAygJUgpjdXJyZW5jaWVzEhwKCWNvdW50cmllcxgHIAMoCVIJY291bnRyaWVzEikKEG1pbl9kZW5vbWluYXRpb24YCCABKAFSD21pbkRlbm9taW5hdGlvbhIpChBtYXhfZGVub21pbmF0aW9uGAkgASgBUg9tYXhEZW5vbWluYXRpb24SLgoTYnV5X3JhdGVfcGVyY2VudGFnZRgKIAEoAVIRYnV5UmF0ZVBlcmNlbnRhZ2USMwoVY29tbWlzc2lvbl9wZXJjZW50YWdlGAsgASgBUhRjb21taXNzaW9uUGVyY2VudGFnZRI0ChZwYXlvdXRfcmF0ZV9wZXJjZW50YWdlGAwgASgBUhRwYXlvdXRSYXRlUGVyY2VudGFnZRInCg9wYXlvdXRfY3VycmVuY3kYDSABKAlSDnBheW91dEN1cnJlbmN5EhsKCWNhcmRfdHlwZRgOIAEoCVIIY2FyZFR5cGU=');
@$core.Deprecated('Use adminCreateSellRateResponseDescriptor instead')
const AdminCreateSellRateResponse$json = const {
  '1': 'AdminCreateSellRateResponse',
  '2': const [
    const {'1': 'rate', '3': 1, '4': 1, '5': 11, '6': '.giftcards.SellRateConfig', '10': 'rate'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminCreateSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCreateSellRateResponseDescriptor = $convert.base64Decode('ChtBZG1pbkNyZWF0ZVNlbGxSYXRlUmVzcG9uc2USLQoEcmF0ZRgBIAEoCzIZLmdpZnRjYXJkcy5TZWxsUmF0ZUNvbmZpZ1IEcmF0ZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use adminUpdateSellRateRequestDescriptor instead')
const AdminUpdateSellRateRequest$json = const {
  '1': 'AdminUpdateSellRateRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'card_brand', '3': 2, '4': 1, '5': 9, '10': 'cardBrand'},
    const {'1': 'card_type_slug', '3': 3, '4': 1, '5': 9, '10': 'cardTypeSlug'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'denominations', '3': 6, '4': 3, '5': 1, '10': 'denominations'},
    const {'1': 'currencies', '3': 7, '4': 3, '5': 9, '10': 'currencies'},
    const {'1': 'countries', '3': 8, '4': 3, '5': 9, '10': 'countries'},
    const {'1': 'min_denomination', '3': 9, '4': 1, '5': 1, '10': 'minDenomination'},
    const {'1': 'max_denomination', '3': 10, '4': 1, '5': 1, '10': 'maxDenomination'},
    const {'1': 'buy_rate_percentage', '3': 11, '4': 1, '5': 1, '10': 'buyRatePercentage'},
    const {'1': 'commission_percentage', '3': 12, '4': 1, '5': 1, '10': 'commissionPercentage'},
    const {'1': 'payout_rate_percentage', '3': 13, '4': 1, '5': 1, '10': 'payoutRatePercentage'},
    const {'1': 'payout_currency', '3': 14, '4': 1, '5': 9, '10': 'payoutCurrency'},
    const {'1': 'card_type', '3': 15, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'is_active', '3': 16, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `AdminUpdateSellRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateSellRateRequestDescriptor = $convert.base64Decode('ChpBZG1pblVwZGF0ZVNlbGxSYXRlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSHQoKY2FyZF9icmFuZBgCIAEoCVIJY2FyZEJyYW5kEiQKDmNhcmRfdHlwZV9zbHVnGAMgASgJUgxjYXJkVHlwZVNsdWcSGQoIbG9nb191cmwYBCABKAlSB2xvZ29VcmwSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EiQKDWRlbm9taW5hdGlvbnMYBiADKAFSDWRlbm9taW5hdGlvbnMSHgoKY3VycmVuY2llcxgHIAMoCVIKY3VycmVuY2llcxIcCgljb3VudHJpZXMYCCADKAlSCWNvdW50cmllcxIpChBtaW5fZGVub21pbmF0aW9uGAkgASgBUg9taW5EZW5vbWluYXRpb24SKQoQbWF4X2Rlbm9taW5hdGlvbhgKIAEoAVIPbWF4RGVub21pbmF0aW9uEi4KE2J1eV9yYXRlX3BlcmNlbnRhZ2UYCyABKAFSEWJ1eVJhdGVQZXJjZW50YWdlEjMKFWNvbW1pc3Npb25fcGVyY2VudGFnZRgMIAEoAVIUY29tbWlzc2lvblBlcmNlbnRhZ2USNAoWcGF5b3V0X3JhdGVfcGVyY2VudGFnZRgNIAEoAVIUcGF5b3V0UmF0ZVBlcmNlbnRhZ2USJwoPcGF5b3V0X2N1cnJlbmN5GA4gASgJUg5wYXlvdXRDdXJyZW5jeRIbCgljYXJkX3R5cGUYDyABKAlSCGNhcmRUeXBlEhsKCWlzX2FjdGl2ZRgQIAEoCFIIaXNBY3RpdmU=');
@$core.Deprecated('Use adminUpdateSellRateResponseDescriptor instead')
const AdminUpdateSellRateResponse$json = const {
  '1': 'AdminUpdateSellRateResponse',
  '2': const [
    const {'1': 'rate', '3': 1, '4': 1, '5': 11, '6': '.giftcards.SellRateConfig', '10': 'rate'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminUpdateSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateSellRateResponseDescriptor = $convert.base64Decode('ChtBZG1pblVwZGF0ZVNlbGxSYXRlUmVzcG9uc2USLQoEcmF0ZRgBIAEoCzIZLmdpZnRjYXJkcy5TZWxsUmF0ZUNvbmZpZ1IEcmF0ZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use adminToggleSellRateRequestDescriptor instead')
const AdminToggleSellRateRequest$json = const {
  '1': 'AdminToggleSellRateRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'is_active', '3': 2, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `AdminToggleSellRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminToggleSellRateRequestDescriptor = $convert.base64Decode('ChpBZG1pblRvZ2dsZVNlbGxSYXRlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSGwoJaXNfYWN0aXZlGAIgASgIUghpc0FjdGl2ZQ==');
@$core.Deprecated('Use adminToggleSellRateResponseDescriptor instead')
const AdminToggleSellRateResponse$json = const {
  '1': 'AdminToggleSellRateResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminToggleSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminToggleSellRateResponseDescriptor = $convert.base64Decode('ChtBZG1pblRvZ2dsZVNlbGxSYXRlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use giftCardCountryDescriptor instead')
const GiftCardCountry$json = const {
  '1': 'GiftCardCountry',
  '2': const [
    const {'1': 'iso_code', '3': 1, '4': 1, '5': 9, '10': 'isoCode'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'flag_url', '3': 3, '4': 1, '5': 9, '10': 'flagUrl'},
    const {'1': 'currency_code', '3': 4, '4': 1, '5': 9, '10': 'currencyCode'},
    const {'1': 'currency_name', '3': 5, '4': 1, '5': 9, '10': 'currencyName'},
  ],
};

/// Descriptor for `GiftCardCountry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardCountryDescriptor = $convert.base64Decode('Cg9HaWZ0Q2FyZENvdW50cnkSGQoIaXNvX2NvZGUYASABKAlSB2lzb0NvZGUSEgoEbmFtZRgCIAEoCVIEbmFtZRIZCghmbGFnX3VybBgDIAEoCVIHZmxhZ1VybBIjCg1jdXJyZW5jeV9jb2RlGAQgASgJUgxjdXJyZW5jeUNvZGUSIwoNY3VycmVuY3lfbmFtZRgFIAEoCVIMY3VycmVuY3lOYW1l');
@$core.Deprecated('Use getSupportedCountriesRequestDescriptor instead')
const GetSupportedCountriesRequest$json = const {
  '1': 'GetSupportedCountriesRequest',
};

/// Descriptor for `GetSupportedCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCountriesRequestDescriptor = $convert.base64Decode('ChxHZXRTdXBwb3J0ZWRDb3VudHJpZXNSZXF1ZXN0');
@$core.Deprecated('Use getSupportedCountriesResponseDescriptor instead')
const GetSupportedCountriesResponse$json = const {
  '1': 'GetSupportedCountriesResponse',
  '2': const [
    const {'1': 'countries', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardCountry', '10': 'countries'},
  ],
};

/// Descriptor for `GetSupportedCountriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCountriesResponseDescriptor = $convert.base64Decode('Ch1HZXRTdXBwb3J0ZWRDb3VudHJpZXNSZXNwb25zZRI4Cgljb3VudHJpZXMYASADKAsyGi5naWZ0Y2FyZHMuR2lmdENhcmRDb3VudHJ5Ugljb3VudHJpZXM=');
