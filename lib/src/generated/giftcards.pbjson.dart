// This is a generated file - do not edit.
//
// Generated from giftcards.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

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
    {'1': 'original_amount', '3': 8, '4': 1, '5': 1, '10': 'originalAmount'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {'1': 'purchase_date', '3': 12, '4': 1, '5': 9, '10': 'purchaseDate'},
    {'1': 'expiry_date', '3': 13, '4': 1, '5': 9, '10': 'expiryDate'},
    {'1': 'recipient_email', '3': 14, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 15, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'message', '3': 16, '4': 1, '5': 9, '10': 'message'},
    {'1': 'metadata', '3': 18, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 20, '4': 1, '5': 9, '10': 'updatedAt'},
    {
      '1': 'provider_transaction_id',
      '3': 21,
      '4': 1,
      '5': 9,
      '10': 'providerTransactionId'
    },
    {'1': 'redemption_code', '3': 22, '4': 1, '5': 9, '10': 'redemptionCode'},
    {'1': 'redemption_pin', '3': 23, '4': 1, '5': 9, '10': 'redemptionPin'},
    {'1': 'country_code', '3': 24, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'logo_url', '3': 25, '4': 1, '5': 9, '10': 'logoUrl'},
    {
      '1': 'provider_product_id',
      '3': 26,
      '4': 1,
      '5': 3,
      '10': 'providerProductId'
    },
    {
      '1': 'discount_percentage',
      '3': 27,
      '4': 1,
      '5': 1,
      '10': 'discountPercentage'
    },
    {'1': 'sender_amount', '3': 28, '4': 1, '5': 1, '10': 'senderAmount'},
    {'1': 'sender_currency', '3': 29, '4': 1, '5': 9, '10': 'senderCurrency'},
    {
      '1': 'transferred_from_id',
      '3': 30,
      '4': 1,
      '5': 9,
      '10': 'transferredFromId'
    },
    {'1': 'sender_user_id', '3': 31, '4': 1, '5': 9, '10': 'senderUserId'},
    {'1': 'transfer_type', '3': 32, '4': 1, '5': 9, '10': 'transferType'},
    {
      '1': 'redemption_instructions',
      '3': 33,
      '4': 1,
      '5': 9,
      '10': 'redemptionInstructions'
    },
  ],
  '9': [
    {'1': 6, '2': 7},
    {'1': 7, '2': 8},
    {'1': 9, '2': 10},
    {'1': 17, '2': 18},
  ],
};

/// Descriptor for `GiftCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDescriptor = $convert.base64Decode(
    'CghHaWZ0Q2FyZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCm'
    'FjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIZCghicmFuZF9pZBgEIAEoCVIHYnJhbmRJZBId'
    'CgpicmFuZF9uYW1lGAUgASgJUglicmFuZE5hbWUSJwoPb3JpZ2luYWxfYW1vdW50GAggASgBUg'
    '5vcmlnaW5hbEFtb3VudBIaCghjdXJyZW5jeRgKIAEoCVIIY3VycmVuY3kSFgoGc3RhdHVzGAsg'
    'ASgJUgZzdGF0dXMSIwoNcHVyY2hhc2VfZGF0ZRgMIAEoCVIMcHVyY2hhc2VEYXRlEh8KC2V4cG'
    'lyeV9kYXRlGA0gASgJUgpleHBpcnlEYXRlEicKD3JlY2lwaWVudF9lbWFpbBgOIAEoCVIOcmVj'
    'aXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYDyABKAlSDXJlY2lwaWVudE5hbWUSGAoHbW'
    'Vzc2FnZRgQIAEoCVIHbWVzc2FnZRIaCghtZXRhZGF0YRgSIAEoCVIIbWV0YWRhdGESHQoKY3Jl'
    'YXRlZF9hdBgTIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFCABKAlSCXVwZGF0ZWRBdB'
    'I2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgVIAEoCVIVcHJvdmlkZXJUcmFuc2FjdGlvbklk'
    'EicKD3JlZGVtcHRpb25fY29kZRgWIAEoCVIOcmVkZW1wdGlvbkNvZGUSJQoOcmVkZW1wdGlvbl'
    '9waW4YFyABKAlSDXJlZGVtcHRpb25QaW4SIQoMY291bnRyeV9jb2RlGBggASgJUgtjb3VudHJ5'
    'Q29kZRIZCghsb2dvX3VybBgZIAEoCVIHbG9nb1VybBIuChNwcm92aWRlcl9wcm9kdWN0X2lkGB'
    'ogASgDUhFwcm92aWRlclByb2R1Y3RJZBIvChNkaXNjb3VudF9wZXJjZW50YWdlGBsgASgBUhJk'
    'aXNjb3VudFBlcmNlbnRhZ2USIwoNc2VuZGVyX2Ftb3VudBgcIAEoAVIMc2VuZGVyQW1vdW50Ei'
    'cKD3NlbmRlcl9jdXJyZW5jeRgdIAEoCVIOc2VuZGVyQ3VycmVuY3kSLgoTdHJhbnNmZXJyZWRf'
    'ZnJvbV9pZBgeIAEoCVIRdHJhbnNmZXJyZWRGcm9tSWQSJAoOc2VuZGVyX3VzZXJfaWQYHyABKA'
    'lSDHNlbmRlclVzZXJJZBIjCg10cmFuc2Zlcl90eXBlGCAgASgJUgx0cmFuc2ZlclR5cGUSNwoX'
    'cmVkZW1wdGlvbl9pbnN0cnVjdGlvbnMYISABKAlSFnJlZGVtcHRpb25JbnN0cnVjdGlvbnNKBA'
    'gGEAdKBAgHEAhKBAgJEApKBAgREBI=');

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
    {
      '1': 'terms_and_conditions',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'termsAndConditions'
    },
    {'1': 'provider_name', '3': 17, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'product_id', '3': 11, '4': 1, '5': 3, '10': 'productId'},
    {'1': 'country_code', '3': 12, '4': 1, '5': 9, '10': 'countryCode'},
    {
      '1': 'fixed_denominations',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.giftcards.GiftCardDenomination',
      '10': 'fixedDenominations'
    },
    {
      '1': 'discount_percentage',
      '3': 14,
      '4': 1,
      '5': 1,
      '10': 'discountPercentage'
    },
    {'1': 'currency_code', '3': 15, '4': 1, '5': 9, '10': 'currencyCode'},
    {
      '1': 'redemption_instructions',
      '3': 16,
      '4': 1,
      '5': 9,
      '10': 'redemptionInstructions'
    },
    {
      '1': 'sender_currency_code',
      '3': 18,
      '4': 1,
      '5': 9,
      '10': 'senderCurrencyCode'
    },
    {
      '1': 'sender_denominations',
      '3': 19,
      '4': 3,
      '5': 1,
      '10': 'senderDenominations'
    },
    {
      '1': 'min_sender_amount',
      '3': 20,
      '4': 1,
      '5': 1,
      '10': 'minSenderAmount'
    },
    {
      '1': 'max_sender_amount',
      '3': 21,
      '4': 1,
      '5': 1,
      '10': 'maxSenderAmount'
    },
    {'1': 'sender_fee', '3': 22, '4': 1, '5': 1, '10': 'senderFee'},
    {
      '1': 'sender_fee_percentage',
      '3': 23,
      '4': 1,
      '5': 1,
      '10': 'senderFeePercentage'
    },
    {
      '1': 'fixed_sender_denominations',
      '3': 24,
      '4': 3,
      '5': 11,
      '6': '.giftcards.GiftCardDenomination',
      '10': 'fixedSenderDenominations'
    },
  ],
};

/// Descriptor for `GiftCardBrand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardBrandDescriptor = $convert.base64Decode(
    'Cg1HaWZ0Q2FyZEJyYW5kEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhkKCG'
    'xvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIgCgtk'
    'ZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SJAoNZGVub21pbmF0aW9ucxgGIAMoAVINZG'
    'Vub21pbmF0aW9ucxIdCgptaW5fYW1vdW50GAcgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3Vu'
    'dBgIIAEoAVIJbWF4QW1vdW50EhsKCWlzX2FjdGl2ZRgJIAEoCFIIaXNBY3RpdmUSMAoUdGVybX'
    'NfYW5kX2NvbmRpdGlvbnMYCiABKAlSEnRlcm1zQW5kQ29uZGl0aW9ucxIjCg1wcm92aWRlcl9u'
    'YW1lGBEgASgJUgxwcm92aWRlck5hbWUSHQoKcHJvZHVjdF9pZBgLIAEoA1IJcHJvZHVjdElkEi'
    'EKDGNvdW50cnlfY29kZRgMIAEoCVILY291bnRyeUNvZGUSUAoTZml4ZWRfZGVub21pbmF0aW9u'
    'cxgNIAMoCzIfLmdpZnRjYXJkcy5HaWZ0Q2FyZERlbm9taW5hdGlvblISZml4ZWREZW5vbWluYX'
    'Rpb25zEi8KE2Rpc2NvdW50X3BlcmNlbnRhZ2UYDiABKAFSEmRpc2NvdW50UGVyY2VudGFnZRIj'
    'Cg1jdXJyZW5jeV9jb2RlGA8gASgJUgxjdXJyZW5jeUNvZGUSNwoXcmVkZW1wdGlvbl9pbnN0cn'
    'VjdGlvbnMYECABKAlSFnJlZGVtcHRpb25JbnN0cnVjdGlvbnMSMAoUc2VuZGVyX2N1cnJlbmN5'
    'X2NvZGUYEiABKAlSEnNlbmRlckN1cnJlbmN5Q29kZRIxChRzZW5kZXJfZGVub21pbmF0aW9ucx'
    'gTIAMoAVITc2VuZGVyRGVub21pbmF0aW9ucxIqChFtaW5fc2VuZGVyX2Ftb3VudBgUIAEoAVIP'
    'bWluU2VuZGVyQW1vdW50EioKEW1heF9zZW5kZXJfYW1vdW50GBUgASgBUg9tYXhTZW5kZXJBbW'
    '91bnQSHQoKc2VuZGVyX2ZlZRgWIAEoAVIJc2VuZGVyRmVlEjIKFXNlbmRlcl9mZWVfcGVyY2Vu'
    'dGFnZRgXIAEoAVITc2VuZGVyRmVlUGVyY2VudGFnZRJdChpmaXhlZF9zZW5kZXJfZGVub21pbm'
    'F0aW9ucxgYIAMoCzIfLmdpZnRjYXJkcy5HaWZ0Q2FyZERlbm9taW5hdGlvblIYZml4ZWRTZW5k'
    'ZXJEZW5vbWluYXRpb25z');

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
    {
      '1': 'provider_transaction_id',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'providerTransactionId'
    },
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
    {
      '1': 'verification_token',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'provider_name', '3': 15, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'sender_name', '3': 10, '4': 1, '5': 9, '10': 'senderName'},
    {'1': 'recipient_phone', '3': 11, '4': 1, '5': 9, '10': 'recipientPhone'},
    {'1': 'product_id', '3': 12, '4': 1, '5': 3, '10': 'productId'},
    {'1': 'country_code', '3': 13, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'quantity', '3': 14, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'sender_amount', '3': 16, '4': 1, '5': 1, '10': 'senderAmount'},
    {'1': 'sender_currency', '3': 17, '4': 1, '5': 9, '10': 'senderCurrency'},
  ],
};

/// Descriptor for `BuyGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyGiftCardRequestDescriptor = $convert.base64Decode(
    'ChJCdXlHaWZ0Q2FyZFJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhkKCG'
    'JyYW5kX2lkGAIgASgJUgdicmFuZElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EicKD3JlY2lw'
    'aWVudF9lbWFpbBgEIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYBSABKA'
    'lSDXJlY2lwaWVudE5hbWUSIQoMZ2lmdF9tZXNzYWdlGAYgASgJUgtnaWZ0TWVzc2FnZRIlCg50'
    'cmFuc2FjdGlvbl9pZBgHIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW'
    '4YCCABKAlSEXZlcmlmaWNhdGlvblRva2VuEiMKDXByb3ZpZGVyX25hbWUYDyABKAlSDHByb3Zp'
    'ZGVyTmFtZRInCg9pZGVtcG90ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2V5Eh8KC3Nlbm'
    'Rlcl9uYW1lGAogASgJUgpzZW5kZXJOYW1lEicKD3JlY2lwaWVudF9waG9uZRgLIAEoCVIOcmVj'
    'aXBpZW50UGhvbmUSHQoKcHJvZHVjdF9pZBgMIAEoA1IJcHJvZHVjdElkEiEKDGNvdW50cnlfY2'
    '9kZRgNIAEoCVILY291bnRyeUNvZGUSGgoIcXVhbnRpdHkYDiABKAVSCHF1YW50aXR5EiMKDXNl'
    'bmRlcl9hbW91bnQYECABKAFSDHNlbmRlckFtb3VudBInCg9zZW5kZXJfY3VycmVuY3kYESABKA'
    'lSDnNlbmRlckN1cnJlbmN5');

@$core.Deprecated('Use buyGiftCardResponseDescriptor instead')
const BuyGiftCardResponse$json = {
  '1': 'BuyGiftCardResponse',
  '2': [
    {
      '1': 'gift_card',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCard',
      '10': 'giftCard'
    },
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'provider_transaction_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'providerTransactionId'
    },
    {'1': 'sender_amount', '3': 5, '4': 1, '5': 1, '10': 'senderAmount'},
    {'1': 'sender_currency', '3': 6, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'recipient_amount', '3': 7, '4': 1, '5': 1, '10': 'recipientAmount'},
    {
      '1': 'recipient_currency',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'recipientCurrency'
    },
  ],
};

/// Descriptor for `BuyGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyGiftCardResponseDescriptor = $convert.base64Decode(
    'ChNCdXlHaWZ0Q2FyZFJlc3BvbnNlEjAKCWdpZnRfY2FyZBgBIAEoCzITLmdpZnRjYXJkcy5HaW'
    'Z0Q2FyZFIIZ2lmdENhcmQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USGAoHbWVz'
    'c2FnZRgDIAEoCVIHbWVzc2FnZRI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgEIAEoCVIVcH'
    'JvdmlkZXJUcmFuc2FjdGlvbklkEiMKDXNlbmRlcl9hbW91bnQYBSABKAFSDHNlbmRlckFtb3Vu'
    'dBInCg9zZW5kZXJfY3VycmVuY3kYBiABKAlSDnNlbmRlckN1cnJlbmN5EikKEHJlY2lwaWVudF'
    '9hbW91bnQYByABKAFSD3JlY2lwaWVudEFtb3VudBItChJyZWNpcGllbnRfY3VycmVuY3kYCCAB'
    'KAlSEXJlY2lwaWVudEN1cnJlbmN5');

@$core.Deprecated('Use getRedeemCodeRequestDescriptor instead')
const GetRedeemCodeRequest$json = {
  '1': 'GetRedeemCodeRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'force_refresh', '3': 2, '4': 1, '5': 8, '10': 'forceRefresh'},
  ],
};

/// Descriptor for `GetRedeemCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRedeemCodeRequestDescriptor = $convert.base64Decode(
    'ChRHZXRSZWRlZW1Db2RlUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3'
    'Rpb25JZBIjCg1mb3JjZV9yZWZyZXNoGAIgASgIUgxmb3JjZVJlZnJlc2g=');

@$core.Deprecated('Use getRedeemCodeResponseDescriptor instead')
const GetRedeemCodeResponse$json = {
  '1': 'GetRedeemCodeResponse',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'redemption_code', '3': 2, '4': 1, '5': 9, '10': 'redemptionCode'},
    {'1': 'redemption_pin', '3': 3, '4': 1, '5': 9, '10': 'redemptionPin'},
    {'1': 'brand_name', '3': 4, '4': 1, '5': 9, '10': 'brandName'},
    {
      '1': 'redemption_instructions',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'redemptionInstructions'
    },
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `GetRedeemCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRedeemCodeResponseDescriptor = $convert.base64Decode(
    'ChVHZXRSZWRlZW1Db2RlUmVzcG9uc2USJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYW'
    'N0aW9uSWQSJwoPcmVkZW1wdGlvbl9jb2RlGAIgASgJUg5yZWRlbXB0aW9uQ29kZRIlCg5yZWRl'
    'bXB0aW9uX3BpbhgDIAEoCVINcmVkZW1wdGlvblBpbhIdCgpicmFuZF9uYW1lGAQgASgJUglicm'
    'FuZE5hbWUSNwoXcmVkZW1wdGlvbl9pbnN0cnVjdGlvbnMYBSABKAlSFnJlZGVtcHRpb25JbnN0'
    'cnVjdGlvbnMSFgoGc3RhdHVzGAYgASgJUgZzdGF0dXMSGAoHbWVzc2FnZRgHIAEoCVIHbWVzc2'
    'FnZQ==');

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
    {
      '1': 'gift_cards',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.giftcards.GiftCard',
      '10': 'giftCards'
    },
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
    {
      '1': 'gift_card',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCard',
      '10': 'giftCard'
    },
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
    {
      '1': 'verification_token',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'recipient_user_id', '3': 7, '4': 1, '5': 9, '10': 'recipientUserId'},
    {'1': 'transfer_type', '3': 8, '4': 1, '5': 9, '10': 'transferType'},
  ],
};

/// Descriptor for `TransferGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardRequestDescriptor = $convert.base64Decode(
    'ChdUcmFuc2ZlckdpZnRDYXJkUmVxdWVzdBIgCgxnaWZ0X2NhcmRfaWQYASABKAlSCmdpZnRDYX'
    'JkSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGll'
    'bnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlEi'
    'UKDnRyYW5zYWN0aW9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90'
    'b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SKgoRcmVjaXBpZW50X3VzZXJfaWQYByABKA'
    'lSD3JlY2lwaWVudFVzZXJJZBIjCg10cmFuc2Zlcl90eXBlGAggASgJUgx0cmFuc2ZlclR5cGU=');

@$core.Deprecated('Use transferGiftCardResponseDescriptor instead')
const TransferGiftCardResponse$json = {
  '1': 'TransferGiftCardResponse',
  '2': [
    {
      '1': 'gift_card',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCard',
      '10': 'giftCard'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'recipient_gift_card',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCard',
      '10': 'recipientGiftCard'
    },
  ],
};

/// Descriptor for `TransferGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardResponseDescriptor = $convert.base64Decode(
    'ChhUcmFuc2ZlckdpZnRDYXJkUmVzcG9uc2USMAoJZ2lmdF9jYXJkGAEgASgLMhMuZ2lmdGNhcm'
    'RzLkdpZnRDYXJkUghnaWZ0Q2FyZBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEkMKE3JlY2lw'
    'aWVudF9naWZ0X2NhcmQYAyABKAsyEy5naWZ0Y2FyZHMuR2lmdENhcmRSEXJlY2lwaWVudEdpZn'
    'RDYXJk');

@$core.Deprecated('Use getGiftCardBrandsRequestDescriptor instead')
const GetGiftCardBrandsRequest$json = {
  '1': 'GetGiftCardBrandsRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
    {'1': 'country_code', '3': 3, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 5, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'search_query', '3': 6, '4': 1, '5': 9, '10': 'searchQuery'},
  ],
};

/// Descriptor for `GetGiftCardBrandsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBrandsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRHaWZ0Q2FyZEJyYW5kc1JlcXVlc3QSGgoIY2F0ZWdvcnkYASABKAlSCGNhdGVnb3J5Eh'
    '8KC2FjdGl2ZV9vbmx5GAIgASgIUgphY3RpdmVPbmx5EiEKDGNvdW50cnlfY29kZRgDIAEoCVIL'
    'Y291bnRyeUNvZGUSEgoEcGFnZRgEIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYBSABKAVSCHBhZ2'
    'VTaXplEiEKDHNlYXJjaF9xdWVyeRgGIAEoCVILc2VhcmNoUXVlcnk=');

@$core.Deprecated('Use getGiftCardBrandsResponseDescriptor instead')
const GetGiftCardBrandsResponse$json = {
  '1': 'GetGiftCardBrandsResponse',
  '2': [
    {
      '1': 'brands',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.giftcards.GiftCardBrand',
      '10': 'brands'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_pages', '3': 3, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'current_page', '3': 4, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'page_size', '3': 6, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetGiftCardBrandsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardBrandsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRHaWZ0Q2FyZEJyYW5kc1Jlc3BvbnNlEjAKBmJyYW5kcxgBIAMoCzIYLmdpZnRjYXJkcy'
    '5HaWZ0Q2FyZEJyYW5kUgZicmFuZHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEh8KC3RvdGFsX3Bh'
    'Z2VzGAMgASgFUgp0b3RhbFBhZ2VzEiEKDGN1cnJlbnRfcGFnZRgEIAEoBVILY3VycmVudFBhZ2'
    'USGQoIaGFzX25leHQYBSABKAhSB2hhc05leHQSGwoJcGFnZV9zaXplGAYgASgFUghwYWdlU2l6'
    'ZQ==');

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
    {
      '1': 'transactions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.giftcards.GiftCardTransaction',
      '10': 'transactions'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetGiftCardHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardHistoryResponseDescriptor =
    $convert.base64Decode(
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
    {'1': 'provider_name', '3': 9, '4': 1, '5': 9, '10': 'providerName'},
  ],
};

/// Descriptor for `SellableCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellableCardDescriptor = $convert.base64Decode(
    'CgxTZWxsYWJsZUNhcmQSGwoJY2FyZF90eXBlGAEgASgJUghjYXJkVHlwZRIhCgxkaXNwbGF5X2'
    '5hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNh'
    'dGVnb3J5GAQgASgJUghjYXRlZ29yeRIkCg1kZW5vbWluYXRpb25zGAUgAygBUg1kZW5vbWluYX'
    'Rpb25zEh4KCmN1cnJlbmNpZXMYBiADKAlSCmN1cnJlbmNpZXMSKQoQbWluX2Rlbm9taW5hdGlv'
    'bhgHIAEoAVIPbWluRGVub21pbmF0aW9uEikKEG1heF9kZW5vbWluYXRpb24YCCABKAFSD21heE'
    'Rlbm9taW5hdGlvbhIjCg1wcm92aWRlcl9uYW1lGAkgASgJUgxwcm92aWRlck5hbWU=');

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
    {'1': 'image_urls', '3': 20, '4': 3, '5': 9, '10': 'imageUrls'},
    {'1': 'ocr_brand', '3': 21, '4': 1, '5': 9, '10': 'ocrBrand'},
    {'1': 'ocr_card_number', '3': 22, '4': 1, '5': 9, '10': 'ocrCardNumber'},
    {'1': 'ocr_pin', '3': 23, '4': 1, '5': 9, '10': 'ocrPin'},
    {'1': 'ocr_denomination', '3': 24, '4': 1, '5': 1, '10': 'ocrDenomination'},
    {'1': 'ocr_currency', '3': 25, '4': 1, '5': 9, '10': 'ocrCurrency'},
    {
      '1': 'admin_reviewer_id',
      '3': 26,
      '4': 1,
      '5': 9,
      '10': 'adminReviewerId'
    },
    {'1': 'rejection_reason', '3': 27, '4': 1, '5': 9, '10': 'rejectionReason'},
    {'1': 'admin_notes', '3': 28, '4': 1, '5': 9, '10': 'adminNotes'},
    {'1': 'card_pin', '3': 29, '4': 1, '5': 9, '10': 'cardPin'},
    {
      '1': 'exit_rate_percent',
      '3': 30,
      '4': 1,
      '5': 1,
      '10': 'exitRatePercent'
    },
    {
      '1': 'base_margin_percent',
      '3': 31,
      '4': 1,
      '5': 1,
      '10': 'baseMarginPercent'
    },
    {
      '1': 'risk_buffer_percent',
      '3': 32,
      '4': 1,
      '5': 1,
      '10': 'riskBufferPercent'
    },
    {
      '1': 'commission_amount',
      '3': 33,
      '4': 1,
      '5': 1,
      '10': 'commissionAmount'
    },
    {'1': 'risk_score', '3': 34, '4': 1, '5': 5, '10': 'riskScore'},
    {'1': 'risk_level', '3': 35, '4': 1, '5': 9, '10': 'riskLevel'},
    {'1': 'risk_flags', '3': 36, '4': 3, '5': 9, '10': 'riskFlags'},
    {'1': 'risk_action', '3': 37, '4': 1, '5': 9, '10': 'riskAction'},
    {'1': 'card_country', '3': 38, '4': 1, '5': 9, '10': 'cardCountry'},
    {'1': 'card_format', '3': 39, '4': 1, '5': 9, '10': 'cardFormat'},
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
    'VwZGF0ZWRBdBIdCgppbWFnZV91cmxzGBQgAygJUglpbWFnZVVybHMSGwoJb2NyX2JyYW5kGBUg'
    'ASgJUghvY3JCcmFuZBImCg9vY3JfY2FyZF9udW1iZXIYFiABKAlSDW9jckNhcmROdW1iZXISFw'
    'oHb2NyX3BpbhgXIAEoCVIGb2NyUGluEikKEG9jcl9kZW5vbWluYXRpb24YGCABKAFSD29jckRl'
    'bm9taW5hdGlvbhIhCgxvY3JfY3VycmVuY3kYGSABKAlSC29jckN1cnJlbmN5EioKEWFkbWluX3'
    'Jldmlld2VyX2lkGBogASgJUg9hZG1pblJldmlld2VySWQSKQoQcmVqZWN0aW9uX3JlYXNvbhgb'
    'IAEoCVIPcmVqZWN0aW9uUmVhc29uEh8KC2FkbWluX25vdGVzGBwgASgJUgphZG1pbk5vdGVzEh'
    'kKCGNhcmRfcGluGB0gASgJUgdjYXJkUGluEioKEWV4aXRfcmF0ZV9wZXJjZW50GB4gASgBUg9l'
    'eGl0UmF0ZVBlcmNlbnQSLgoTYmFzZV9tYXJnaW5fcGVyY2VudBgfIAEoAVIRYmFzZU1hcmdpbl'
    'BlcmNlbnQSLgoTcmlza19idWZmZXJfcGVyY2VudBggIAEoAVIRcmlza0J1ZmZlclBlcmNlbnQS'
    'KwoRY29tbWlzc2lvbl9hbW91bnQYISABKAFSEGNvbW1pc3Npb25BbW91bnQSHQoKcmlza19zY2'
    '9yZRgiIAEoBVIJcmlza1Njb3JlEh0KCnJpc2tfbGV2ZWwYIyABKAlSCXJpc2tMZXZlbBIdCgpy'
    'aXNrX2ZsYWdzGCQgAygJUglyaXNrRmxhZ3MSHwoLcmlza19hY3Rpb24YJSABKAlSCnJpc2tBY3'
    'Rpb24SIQoMY2FyZF9jb3VudHJ5GCYgASgJUgtjYXJkQ291bnRyeRIfCgtjYXJkX2Zvcm1hdBgn'
    'IAEoCVIKY2FyZEZvcm1hdA==');

@$core.Deprecated('Use getSellableCardsRequestDescriptor instead')
const GetSellableCardsRequest$json = {
  '1': 'GetSellableCardsRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetSellableCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellableCardsRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRTZWxsYWJsZUNhcmRzUmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2NvdW50cn'
        'lDb2Rl');

@$core.Deprecated('Use getSellableCardsResponseDescriptor instead')
const GetSellableCardsResponse$json = {
  '1': 'GetSellableCardsResponse',
  '2': [
    {
      '1': 'cards',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.giftcards.SellableCard',
      '10': 'cards'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetSellableCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellableCardsResponseDescriptor =
    $convert.base64Decode(
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
    {
      '1': 'rate',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.SellRate',
      '10': 'rate'
    },
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
    {
      '1': 'verification_token',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'provider_name', '3': 10, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'image_urls', '3': 11, '4': 3, '5': 9, '10': 'imageUrls'},
    {'1': 'image_keys', '3': 12, '4': 3, '5': 9, '10': 'imageKeys'},
    {'1': 'ocr_brand', '3': 13, '4': 1, '5': 9, '10': 'ocrBrand'},
    {'1': 'ocr_card_number', '3': 14, '4': 1, '5': 9, '10': 'ocrCardNumber'},
    {'1': 'ocr_pin', '3': 15, '4': 1, '5': 9, '10': 'ocrPin'},
    {'1': 'ocr_denomination', '3': 16, '4': 1, '5': 1, '10': 'ocrDenomination'},
    {'1': 'ocr_currency', '3': 17, '4': 1, '5': 9, '10': 'ocrCurrency'},
    {'1': 'card_country', '3': 18, '4': 1, '5': 9, '10': 'cardCountry'},
    {'1': 'card_format', '3': 19, '4': 1, '5': 9, '10': 'cardFormat'},
  ],
};

/// Descriptor for `SellGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardRequestDescriptor = $convert.base64Decode(
    'ChNTZWxsR2lmdENhcmRSZXF1ZXN0EhsKCWNhcmRfdHlwZRgBIAEoCVIIY2FyZFR5cGUSHwoLY2'
    'FyZF9udW1iZXIYAiABKAlSCmNhcmROdW1iZXISGQoIY2FyZF9waW4YAyABKAlSB2NhcmRQaW4S'
    'IgoMZGVub21pbmF0aW9uGAQgASgBUgxkZW5vbWluYXRpb24SGgoIY3VycmVuY3kYBSABKAlSCG'
    'N1cnJlbmN5EhYKBmltYWdlcxgGIAMoCVIGaW1hZ2VzEicKD2lkZW1wb3RlbmN5X2tleRgHIAEo'
    'CVIOaWRlbXBvdGVuY3lLZXkSJQoOdHJhbnNhY3Rpb25faWQYCCABKAlSDXRyYW5zYWN0aW9uSW'
    'QSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAkgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIjCg1wcm92'
    'aWRlcl9uYW1lGAogASgJUgxwcm92aWRlck5hbWUSHQoKaW1hZ2VfdXJscxgLIAMoCVIJaW1hZ2'
    'VVcmxzEh0KCmltYWdlX2tleXMYDCADKAlSCWltYWdlS2V5cxIbCglvY3JfYnJhbmQYDSABKAlS'
    'CG9jckJyYW5kEiYKD29jcl9jYXJkX251bWJlchgOIAEoCVINb2NyQ2FyZE51bWJlchIXCgdvY3'
    'JfcGluGA8gASgJUgZvY3JQaW4SKQoQb2NyX2Rlbm9taW5hdGlvbhgQIAEoAVIPb2NyRGVub21p'
    'bmF0aW9uEiEKDG9jcl9jdXJyZW5jeRgRIAEoCVILb2NyQ3VycmVuY3kSIQoMY2FyZF9jb3VudH'
    'J5GBIgASgJUgtjYXJkQ291bnRyeRIfCgtjYXJkX2Zvcm1hdBgTIAEoCVIKY2FyZEZvcm1hdA==');

@$core.Deprecated('Use sellGiftCardResponseDescriptor instead')
const SellGiftCardResponse$json = {
  '1': 'SellGiftCardResponse',
  '2': [
    {
      '1': 'sale',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCardSale',
      '10': 'sale'
    },
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
final $typed_data.Uint8List getSellStatusRequestDescriptor =
    $convert.base64Decode(
        'ChRHZXRTZWxsU3RhdHVzUmVxdWVzdBIXCgdzYWxlX2lkGAEgASgJUgZzYWxlSWQ=');

@$core.Deprecated('Use getSellStatusResponseDescriptor instead')
const GetSellStatusResponse$json = {
  '1': 'GetSellStatusResponse',
  '2': [
    {
      '1': 'sale',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCardSale',
      '10': 'sale'
    },
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
    {
      '1': 'sales',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.giftcards.GiftCardSale',
      '10': 'sales'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMySalesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMySalesResponseDescriptor = $convert.base64Decode(
    'ChJHZXRNeVNhbGVzUmVzcG9uc2USLQoFc2FsZXMYASADKAsyFy5naWZ0Y2FyZHMuR2lmdENhcm'
    'RTYWxlUgVzYWxlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use uploadSellImageRequestDescriptor instead')
const UploadSellImageRequest$json = {
  '1': 'UploadSellImageRequest',
  '2': [
    {'1': 'image_data', '3': 1, '4': 1, '5': 9, '10': 'imageData'},
    {'1': 'content_type', '3': 2, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'filename', '3': 3, '4': 1, '5': 9, '10': 'filename'},
  ],
};

/// Descriptor for `UploadSellImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadSellImageRequestDescriptor = $convert.base64Decode(
    'ChZVcGxvYWRTZWxsSW1hZ2VSZXF1ZXN0Eh0KCmltYWdlX2RhdGEYASABKAlSCWltYWdlRGF0YR'
    'IhCgxjb250ZW50X3R5cGUYAiABKAlSC2NvbnRlbnRUeXBlEhoKCGZpbGVuYW1lGAMgASgJUghm'
    'aWxlbmFtZQ==');

@$core.Deprecated('Use uploadSellImageResponseDescriptor instead')
const UploadSellImageResponse$json = {
  '1': 'UploadSellImageResponse',
  '2': [
    {'1': 'image_url', '3': 1, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'image_key', '3': 2, '4': 1, '5': 9, '10': 'imageKey'},
  ],
};

/// Descriptor for `UploadSellImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadSellImageResponseDescriptor =
    $convert.base64Decode(
        'ChdVcGxvYWRTZWxsSW1hZ2VSZXNwb25zZRIbCglpbWFnZV91cmwYASABKAlSCGltYWdlVXJsEh'
        'sKCWltYWdlX2tleRgCIAEoCVIIaW1hZ2VLZXk=');

@$core.Deprecated('Use extractCardDetailsRequestDescriptor instead')
const ExtractCardDetailsRequest$json = {
  '1': 'ExtractCardDetailsRequest',
  '2': [
    {'1': 'image_urls', '3': 1, '4': 3, '5': 9, '10': 'imageUrls'},
  ],
};

/// Descriptor for `ExtractCardDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractCardDetailsRequestDescriptor =
    $convert.base64Decode(
        'ChlFeHRyYWN0Q2FyZERldGFpbHNSZXF1ZXN0Eh0KCmltYWdlX3VybHMYASADKAlSCWltYWdlVX'
        'Jscw==');

@$core.Deprecated('Use extractCardDetailsResponseDescriptor instead')
const ExtractCardDetailsResponse$json = {
  '1': 'ExtractCardDetailsResponse',
  '2': [
    {'1': 'brand', '3': 1, '4': 1, '5': 9, '10': 'brand'},
    {'1': 'card_number', '3': 2, '4': 1, '5': 9, '10': 'cardNumber'},
    {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'denomination', '3': 4, '4': 1, '5': 1, '10': 'denomination'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'confidence', '3': 6, '4': 1, '5': 1, '10': 'confidence'},
    {'1': 'raw_text', '3': 7, '4': 1, '5': 9, '10': 'rawText'},
  ],
};

/// Descriptor for `ExtractCardDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractCardDetailsResponseDescriptor = $convert.base64Decode(
    'ChpFeHRyYWN0Q2FyZERldGFpbHNSZXNwb25zZRIUCgVicmFuZBgBIAEoCVIFYnJhbmQSHwoLY2'
    'FyZF9udW1iZXIYAiABKAlSCmNhcmROdW1iZXISEAoDcGluGAMgASgJUgNwaW4SIgoMZGVub21p'
    'bmF0aW9uGAQgASgBUgxkZW5vbWluYXRpb24SGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5Eh'
    '4KCmNvbmZpZGVuY2UYBiABKAFSCmNvbmZpZGVuY2USGQoIcmF3X3RleHQYByABKAlSB3Jhd1Rl'
    'eHQ=');

@$core.Deprecated('Use adminListPendingSalesRequestDescriptor instead')
const AdminListPendingSalesRequest$json = {
  '1': 'AdminListPendingSalesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `AdminListPendingSalesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListPendingSalesRequestDescriptor =
    $convert.base64Decode(
        'ChxBZG1pbkxpc3RQZW5kaW5nU2FsZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEh'
        'QKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldA==');

@$core.Deprecated('Use adminListPendingSalesResponseDescriptor instead')
const AdminListPendingSalesResponse$json = {
  '1': 'AdminListPendingSalesResponse',
  '2': [
    {
      '1': 'sales',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.giftcards.GiftCardSale',
      '10': 'sales'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListPendingSalesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListPendingSalesResponseDescriptor =
    $convert.base64Decode(
        'Ch1BZG1pbkxpc3RQZW5kaW5nU2FsZXNSZXNwb25zZRItCgVzYWxlcxgBIAMoCzIXLmdpZnRjYX'
        'Jkcy5HaWZ0Q2FyZFNhbGVSBXNhbGVzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use adminGetSaleDetailRequestDescriptor instead')
const AdminGetSaleDetailRequest$json = {
  '1': 'AdminGetSaleDetailRequest',
  '2': [
    {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
  ],
};

/// Descriptor for `AdminGetSaleDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSaleDetailRequestDescriptor =
    $convert.base64Decode(
        'ChlBZG1pbkdldFNhbGVEZXRhaWxSZXF1ZXN0EhcKB3NhbGVfaWQYASABKAlSBnNhbGVJZA==');

@$core.Deprecated('Use adminGetSaleDetailResponseDescriptor instead')
const AdminGetSaleDetailResponse$json = {
  '1': 'AdminGetSaleDetailResponse',
  '2': [
    {
      '1': 'sale',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCardSale',
      '10': 'sale'
    },
    {
      '1': 'image_download_urls',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'imageDownloadUrls'
    },
    {'1': 'user_email', '3': 3, '4': 1, '5': 9, '10': 'userEmail'},
    {'1': 'user_name', '3': 4, '4': 1, '5': 9, '10': 'userName'},
  ],
};

/// Descriptor for `AdminGetSaleDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSaleDetailResponseDescriptor = $convert.base64Decode(
    'ChpBZG1pbkdldFNhbGVEZXRhaWxSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLk'
    'dpZnRDYXJkU2FsZVIEc2FsZRIuChNpbWFnZV9kb3dubG9hZF91cmxzGAIgAygJUhFpbWFnZURv'
    'd25sb2FkVXJscxIdCgp1c2VyX2VtYWlsGAMgASgJUgl1c2VyRW1haWwSGwoJdXNlcl9uYW1lGA'
    'QgASgJUgh1c2VyTmFtZQ==');

@$core.Deprecated('Use adminApproveSaleRequestDescriptor instead')
const AdminApproveSaleRequest$json = {
  '1': 'AdminApproveSaleRequest',
  '2': [
    {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
    {'1': 'admin_notes', '3': 2, '4': 1, '5': 9, '10': 'adminNotes'},
  ],
};

/// Descriptor for `AdminApproveSaleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminApproveSaleRequestDescriptor =
    $convert.base64Decode(
        'ChdBZG1pbkFwcHJvdmVTYWxlUmVxdWVzdBIXCgdzYWxlX2lkGAEgASgJUgZzYWxlSWQSHwoLYW'
        'RtaW5fbm90ZXMYAiABKAlSCmFkbWluTm90ZXM=');

@$core.Deprecated('Use adminApproveSaleResponseDescriptor instead')
const AdminApproveSaleResponse$json = {
  '1': 'AdminApproveSaleResponse',
  '2': [
    {
      '1': 'sale',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCardSale',
      '10': 'sale'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminApproveSaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminApproveSaleResponseDescriptor =
    $convert.base64Decode(
        'ChhBZG1pbkFwcHJvdmVTYWxlUmVzcG9uc2USKwoEc2FsZRgBIAEoCzIXLmdpZnRjYXJkcy5HaW'
        'Z0Q2FyZFNhbGVSBHNhbGUSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use adminRejectSaleRequestDescriptor instead')
const AdminRejectSaleRequest$json = {
  '1': 'AdminRejectSaleRequest',
  '2': [
    {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'admin_notes', '3': 3, '4': 1, '5': 9, '10': 'adminNotes'},
  ],
};

/// Descriptor for `AdminRejectSaleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRejectSaleRequestDescriptor = $convert.base64Decode(
    'ChZBZG1pblJlamVjdFNhbGVSZXF1ZXN0EhcKB3NhbGVfaWQYASABKAlSBnNhbGVJZBIWCgZyZW'
    'Fzb24YAiABKAlSBnJlYXNvbhIfCgthZG1pbl9ub3RlcxgDIAEoCVIKYWRtaW5Ob3Rlcw==');

@$core.Deprecated('Use adminRejectSaleResponseDescriptor instead')
const AdminRejectSaleResponse$json = {
  '1': 'AdminRejectSaleResponse',
  '2': [
    {
      '1': 'sale',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.GiftCardSale',
      '10': 'sale'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminRejectSaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRejectSaleResponseDescriptor =
    $convert.base64Decode(
        'ChdBZG1pblJlamVjdFNhbGVSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLkdpZn'
        'RDYXJkU2FsZVIEc2FsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use sellRateConfigDescriptor instead')
const SellRateConfig$json = {
  '1': 'SellRateConfig',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'card_brand', '3': 2, '4': 1, '5': 9, '10': 'cardBrand'},
    {'1': 'card_type_slug', '3': 3, '4': 1, '5': 9, '10': 'cardTypeSlug'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'denominations', '3': 6, '4': 3, '5': 1, '10': 'denominations'},
    {'1': 'currencies', '3': 7, '4': 3, '5': 9, '10': 'currencies'},
    {'1': 'countries', '3': 8, '4': 3, '5': 9, '10': 'countries'},
    {'1': 'min_denomination', '3': 9, '4': 1, '5': 1, '10': 'minDenomination'},
    {'1': 'max_denomination', '3': 10, '4': 1, '5': 1, '10': 'maxDenomination'},
    {
      '1': 'buy_rate_percentage',
      '3': 11,
      '4': 1,
      '5': 1,
      '10': 'buyRatePercentage'
    },
    {
      '1': 'commission_percentage',
      '3': 12,
      '4': 1,
      '5': 1,
      '10': 'commissionPercentage'
    },
    {
      '1': 'payout_rate_percentage',
      '3': 13,
      '4': 1,
      '5': 1,
      '10': 'payoutRatePercentage'
    },
    {'1': 'payout_currency', '3': 14, '4': 1, '5': 9, '10': 'payoutCurrency'},
    {'1': 'card_type', '3': 15, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'is_active', '3': 16, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SellRateConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellRateConfigDescriptor = $convert.base64Decode(
    'Cg5TZWxsUmF0ZUNvbmZpZxIOCgJpZBgBIAEoCVICaWQSHQoKY2FyZF9icmFuZBgCIAEoCVIJY2'
    'FyZEJyYW5kEiQKDmNhcmRfdHlwZV9zbHVnGAMgASgJUgxjYXJkVHlwZVNsdWcSGQoIbG9nb191'
    'cmwYBCABKAlSB2xvZ29VcmwSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3J5EiQKDWRlbm9taW'
    '5hdGlvbnMYBiADKAFSDWRlbm9taW5hdGlvbnMSHgoKY3VycmVuY2llcxgHIAMoCVIKY3VycmVu'
    'Y2llcxIcCgljb3VudHJpZXMYCCADKAlSCWNvdW50cmllcxIpChBtaW5fZGVub21pbmF0aW9uGA'
    'kgASgBUg9taW5EZW5vbWluYXRpb24SKQoQbWF4X2Rlbm9taW5hdGlvbhgKIAEoAVIPbWF4RGVu'
    'b21pbmF0aW9uEi4KE2J1eV9yYXRlX3BlcmNlbnRhZ2UYCyABKAFSEWJ1eVJhdGVQZXJjZW50YW'
    'dlEjMKFWNvbW1pc3Npb25fcGVyY2VudGFnZRgMIAEoAVIUY29tbWlzc2lvblBlcmNlbnRhZ2US'
    'NAoWcGF5b3V0X3JhdGVfcGVyY2VudGFnZRgNIAEoAVIUcGF5b3V0UmF0ZVBlcmNlbnRhZ2USJw'
    'oPcGF5b3V0X2N1cnJlbmN5GA4gASgJUg5wYXlvdXRDdXJyZW5jeRIbCgljYXJkX3R5cGUYDyAB'
    'KAlSCGNhcmRUeXBlEhsKCWlzX2FjdGl2ZRgQIAEoCFIIaXNBY3RpdmUSHQoKY3JlYXRlZF9hdB'
    'gRIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYEiABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use adminListSellRatesRequestDescriptor instead')
const AdminListSellRatesRequest$json = {
  '1': 'AdminListSellRatesRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 4, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `AdminListSellRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellRatesRequestDescriptor = $convert.base64Decode(
    'ChlBZG1pbkxpc3RTZWxsUmF0ZXNSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ29yeR'
    'IfCgthY3RpdmVfb25seRgCIAEoCFIKYWN0aXZlT25seRIUCgVsaW1pdBgDIAEoBVIFbGltaXQS'
    'FgoGb2Zmc2V0GAQgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use adminListSellRatesResponseDescriptor instead')
const AdminListSellRatesResponse$json = {
  '1': 'AdminListSellRatesResponse',
  '2': [
    {
      '1': 'rates',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.giftcards.SellRateConfig',
      '10': 'rates'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListSellRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellRatesResponseDescriptor =
    $convert.base64Decode(
        'ChpBZG1pbkxpc3RTZWxsUmF0ZXNSZXNwb25zZRIvCgVyYXRlcxgBIAMoCzIZLmdpZnRjYXJkcy'
        '5TZWxsUmF0ZUNvbmZpZ1IFcmF0ZXMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use adminCreateSellRateRequestDescriptor instead')
const AdminCreateSellRateRequest$json = {
  '1': 'AdminCreateSellRateRequest',
  '2': [
    {'1': 'card_brand', '3': 1, '4': 1, '5': 9, '10': 'cardBrand'},
    {'1': 'card_type_slug', '3': 2, '4': 1, '5': 9, '10': 'cardTypeSlug'},
    {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'denominations', '3': 5, '4': 3, '5': 1, '10': 'denominations'},
    {'1': 'currencies', '3': 6, '4': 3, '5': 9, '10': 'currencies'},
    {'1': 'countries', '3': 7, '4': 3, '5': 9, '10': 'countries'},
    {'1': 'min_denomination', '3': 8, '4': 1, '5': 1, '10': 'minDenomination'},
    {'1': 'max_denomination', '3': 9, '4': 1, '5': 1, '10': 'maxDenomination'},
    {
      '1': 'buy_rate_percentage',
      '3': 10,
      '4': 1,
      '5': 1,
      '10': 'buyRatePercentage'
    },
    {
      '1': 'commission_percentage',
      '3': 11,
      '4': 1,
      '5': 1,
      '10': 'commissionPercentage'
    },
    {
      '1': 'payout_rate_percentage',
      '3': 12,
      '4': 1,
      '5': 1,
      '10': 'payoutRatePercentage'
    },
    {'1': 'payout_currency', '3': 13, '4': 1, '5': 9, '10': 'payoutCurrency'},
    {'1': 'card_type', '3': 14, '4': 1, '5': 9, '10': 'cardType'},
  ],
};

/// Descriptor for `AdminCreateSellRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCreateSellRateRequestDescriptor = $convert.base64Decode(
    'ChpBZG1pbkNyZWF0ZVNlbGxSYXRlUmVxdWVzdBIdCgpjYXJkX2JyYW5kGAEgASgJUgljYXJkQn'
    'JhbmQSJAoOY2FyZF90eXBlX3NsdWcYAiABKAlSDGNhcmRUeXBlU2x1ZxIZCghsb2dvX3VybBgD'
    'IAEoCVIHbG9nb1VybBIaCghjYXRlZ29yeRgEIAEoCVIIY2F0ZWdvcnkSJAoNZGVub21pbmF0aW'
    '9ucxgFIAMoAVINZGVub21pbmF0aW9ucxIeCgpjdXJyZW5jaWVzGAYgAygJUgpjdXJyZW5jaWVz'
    'EhwKCWNvdW50cmllcxgHIAMoCVIJY291bnRyaWVzEikKEG1pbl9kZW5vbWluYXRpb24YCCABKA'
    'FSD21pbkRlbm9taW5hdGlvbhIpChBtYXhfZGVub21pbmF0aW9uGAkgASgBUg9tYXhEZW5vbWlu'
    'YXRpb24SLgoTYnV5X3JhdGVfcGVyY2VudGFnZRgKIAEoAVIRYnV5UmF0ZVBlcmNlbnRhZ2USMw'
    'oVY29tbWlzc2lvbl9wZXJjZW50YWdlGAsgASgBUhRjb21taXNzaW9uUGVyY2VudGFnZRI0ChZw'
    'YXlvdXRfcmF0ZV9wZXJjZW50YWdlGAwgASgBUhRwYXlvdXRSYXRlUGVyY2VudGFnZRInCg9wYX'
    'lvdXRfY3VycmVuY3kYDSABKAlSDnBheW91dEN1cnJlbmN5EhsKCWNhcmRfdHlwZRgOIAEoCVII'
    'Y2FyZFR5cGU=');

@$core.Deprecated('Use adminCreateSellRateResponseDescriptor instead')
const AdminCreateSellRateResponse$json = {
  '1': 'AdminCreateSellRateResponse',
  '2': [
    {
      '1': 'rate',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.SellRateConfig',
      '10': 'rate'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminCreateSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCreateSellRateResponseDescriptor =
    $convert.base64Decode(
        'ChtBZG1pbkNyZWF0ZVNlbGxSYXRlUmVzcG9uc2USLQoEcmF0ZRgBIAEoCzIZLmdpZnRjYXJkcy'
        '5TZWxsUmF0ZUNvbmZpZ1IEcmF0ZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use adminUpdateSellRateRequestDescriptor instead')
const AdminUpdateSellRateRequest$json = {
  '1': 'AdminUpdateSellRateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'card_brand', '3': 2, '4': 1, '5': 9, '10': 'cardBrand'},
    {'1': 'card_type_slug', '3': 3, '4': 1, '5': 9, '10': 'cardTypeSlug'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    {'1': 'denominations', '3': 6, '4': 3, '5': 1, '10': 'denominations'},
    {'1': 'currencies', '3': 7, '4': 3, '5': 9, '10': 'currencies'},
    {'1': 'countries', '3': 8, '4': 3, '5': 9, '10': 'countries'},
    {'1': 'min_denomination', '3': 9, '4': 1, '5': 1, '10': 'minDenomination'},
    {'1': 'max_denomination', '3': 10, '4': 1, '5': 1, '10': 'maxDenomination'},
    {
      '1': 'buy_rate_percentage',
      '3': 11,
      '4': 1,
      '5': 1,
      '10': 'buyRatePercentage'
    },
    {
      '1': 'commission_percentage',
      '3': 12,
      '4': 1,
      '5': 1,
      '10': 'commissionPercentage'
    },
    {
      '1': 'payout_rate_percentage',
      '3': 13,
      '4': 1,
      '5': 1,
      '10': 'payoutRatePercentage'
    },
    {'1': 'payout_currency', '3': 14, '4': 1, '5': 9, '10': 'payoutCurrency'},
    {'1': 'card_type', '3': 15, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'is_active', '3': 16, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `AdminUpdateSellRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateSellRateRequestDescriptor = $convert.base64Decode(
    'ChpBZG1pblVwZGF0ZVNlbGxSYXRlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSHQoKY2FyZF9icm'
    'FuZBgCIAEoCVIJY2FyZEJyYW5kEiQKDmNhcmRfdHlwZV9zbHVnGAMgASgJUgxjYXJkVHlwZVNs'
    'dWcSGQoIbG9nb191cmwYBCABKAlSB2xvZ29VcmwSGgoIY2F0ZWdvcnkYBSABKAlSCGNhdGVnb3'
    'J5EiQKDWRlbm9taW5hdGlvbnMYBiADKAFSDWRlbm9taW5hdGlvbnMSHgoKY3VycmVuY2llcxgH'
    'IAMoCVIKY3VycmVuY2llcxIcCgljb3VudHJpZXMYCCADKAlSCWNvdW50cmllcxIpChBtaW5fZG'
    'Vub21pbmF0aW9uGAkgASgBUg9taW5EZW5vbWluYXRpb24SKQoQbWF4X2Rlbm9taW5hdGlvbhgK'
    'IAEoAVIPbWF4RGVub21pbmF0aW9uEi4KE2J1eV9yYXRlX3BlcmNlbnRhZ2UYCyABKAFSEWJ1eV'
    'JhdGVQZXJjZW50YWdlEjMKFWNvbW1pc3Npb25fcGVyY2VudGFnZRgMIAEoAVIUY29tbWlzc2lv'
    'blBlcmNlbnRhZ2USNAoWcGF5b3V0X3JhdGVfcGVyY2VudGFnZRgNIAEoAVIUcGF5b3V0UmF0ZV'
    'BlcmNlbnRhZ2USJwoPcGF5b3V0X2N1cnJlbmN5GA4gASgJUg5wYXlvdXRDdXJyZW5jeRIbCglj'
    'YXJkX3R5cGUYDyABKAlSCGNhcmRUeXBlEhsKCWlzX2FjdGl2ZRgQIAEoCFIIaXNBY3RpdmU=');

@$core.Deprecated('Use adminUpdateSellRateResponseDescriptor instead')
const AdminUpdateSellRateResponse$json = {
  '1': 'AdminUpdateSellRateResponse',
  '2': [
    {
      '1': 'rate',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.giftcards.SellRateConfig',
      '10': 'rate'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminUpdateSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateSellRateResponseDescriptor =
    $convert.base64Decode(
        'ChtBZG1pblVwZGF0ZVNlbGxSYXRlUmVzcG9uc2USLQoEcmF0ZRgBIAEoCzIZLmdpZnRjYXJkcy'
        '5TZWxsUmF0ZUNvbmZpZ1IEcmF0ZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use adminToggleSellRateRequestDescriptor instead')
const AdminToggleSellRateRequest$json = {
  '1': 'AdminToggleSellRateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'is_active', '3': 2, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `AdminToggleSellRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminToggleSellRateRequestDescriptor =
    $convert.base64Decode(
        'ChpBZG1pblRvZ2dsZVNlbGxSYXRlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSGwoJaXNfYWN0aX'
        'ZlGAIgASgIUghpc0FjdGl2ZQ==');

@$core.Deprecated('Use adminToggleSellRateResponseDescriptor instead')
const AdminToggleSellRateResponse$json = {
  '1': 'AdminToggleSellRateResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminToggleSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminToggleSellRateResponseDescriptor =
    $convert.base64Decode(
        'ChtBZG1pblRvZ2dsZVNlbGxSYXRlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ'
        '==');

@$core.Deprecated('Use giftCardCountryDescriptor instead')
const GiftCardCountry$json = {
  '1': 'GiftCardCountry',
  '2': [
    {'1': 'iso_code', '3': 1, '4': 1, '5': 9, '10': 'isoCode'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'flag_url', '3': 3, '4': 1, '5': 9, '10': 'flagUrl'},
    {'1': 'currency_code', '3': 4, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'currency_name', '3': 5, '4': 1, '5': 9, '10': 'currencyName'},
  ],
};

/// Descriptor for `GiftCardCountry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardCountryDescriptor = $convert.base64Decode(
    'Cg9HaWZ0Q2FyZENvdW50cnkSGQoIaXNvX2NvZGUYASABKAlSB2lzb0NvZGUSEgoEbmFtZRgCIA'
    'EoCVIEbmFtZRIZCghmbGFnX3VybBgDIAEoCVIHZmxhZ1VybBIjCg1jdXJyZW5jeV9jb2RlGAQg'
    'ASgJUgxjdXJyZW5jeUNvZGUSIwoNY3VycmVuY3lfbmFtZRgFIAEoCVIMY3VycmVuY3lOYW1l');

@$core.Deprecated('Use getSupportedCountriesRequestDescriptor instead')
const GetSupportedCountriesRequest$json = {
  '1': 'GetSupportedCountriesRequest',
};

/// Descriptor for `GetSupportedCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCountriesRequestDescriptor =
    $convert.base64Decode('ChxHZXRTdXBwb3J0ZWRDb3VudHJpZXNSZXF1ZXN0');

@$core.Deprecated('Use getSupportedCountriesResponseDescriptor instead')
const GetSupportedCountriesResponse$json = {
  '1': 'GetSupportedCountriesResponse',
  '2': [
    {
      '1': 'countries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.giftcards.GiftCardCountry',
      '10': 'countries'
    },
  ],
};

/// Descriptor for `GetSupportedCountriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCountriesResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRTdXBwb3J0ZWRDb3VudHJpZXNSZXNwb25zZRI4Cgljb3VudHJpZXMYASADKAsyGi5naW'
        'Z0Y2FyZHMuR2lmdENhcmRDb3VudHJ5Ugljb3VudHJpZXM=');
