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

@$core.Deprecated('Use buyErrorCodeDescriptor instead')
const BuyErrorCode$json = {
  '1': 'BuyErrorCode',
  '2': [
    {'1': 'BUY_ERROR_UNSPECIFIED', '2': 0},
    {'1': 'BUY_ERROR_INSUFFICIENT_FUNDS', '2': 1},
    {'1': 'BUY_ERROR_PROVIDER_WALLET_LOW', '2': 2},
    {'1': 'BUY_ERROR_INVALID_AMOUNT', '2': 3},
    {'1': 'BUY_ERROR_PROVIDER_BUSY', '2': 4},
    {'1': 'BUY_ERROR_PROVIDER_MISMATCH', '2': 5},
    {'1': 'BUY_ERROR_OUT_OF_STOCK', '2': 6},
    {'1': 'BUY_ERROR_PRODUCT_UNAVAILABLE', '2': 7},
    {'1': 'BUY_ERROR_DUPLICATE_ORDER', '2': 8},
    {'1': 'BUY_ERROR_RATE_LIMITED', '2': 9},
    {'1': 'BUY_ERROR_SELF_SEND', '2': 10},
    {'1': 'BUY_ERROR_ACCOUNT_NOT_ACTIVE', '2': 11},
    {'1': 'BUY_ERROR_SPENDING_LIMIT', '2': 12},
    {'1': 'BUY_ERROR_INTERNAL', '2': 100},
  ],
};

/// Descriptor for `BuyErrorCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List buyErrorCodeDescriptor = $convert.base64Decode(
    'CgxCdXlFcnJvckNvZGUSGQoVQlVZX0VSUk9SX1VOU1BFQ0lGSUVEEAASIAocQlVZX0VSUk9SX0'
    'lOU1VGRklDSUVOVF9GVU5EUxABEiEKHUJVWV9FUlJPUl9QUk9WSURFUl9XQUxMRVRfTE9XEAIS'
    'HAoYQlVZX0VSUk9SX0lOVkFMSURfQU1PVU5UEAMSGwoXQlVZX0VSUk9SX1BST1ZJREVSX0JVU1'
    'kQBBIfChtCVVlfRVJST1JfUFJPVklERVJfTUlTTUFUQ0gQBRIaChZCVVlfRVJST1JfT1VUX09G'
    'X1NUT0NLEAYSIQodQlVZX0VSUk9SX1BST0RVQ1RfVU5BVkFJTEFCTEUQBxIdChlCVVlfRVJST1'
    'JfRFVQTElDQVRFX09SREVSEAgSGgoWQlVZX0VSUk9SX1JBVEVfTElNSVRFRBAJEhcKE0JVWV9F'
    'UlJPUl9TRUxGX1NFTkQQChIgChxCVVlfRVJST1JfQUNDT1VOVF9OT1RfQUNUSVZFEAsSHAoYQl'
    'VZX0VSUk9SX1NQRU5ESU5HX0xJTUlUEAwSFgoSQlVZX0VSUk9SX0lOVEVSTkFMEGQ=');

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
    {'1': 'provider_transaction_id', '3': 21, '4': 1, '5': 9, '10': 'providerTransactionId'},
    {'1': 'redemption_code', '3': 22, '4': 1, '5': 9, '10': 'redemptionCode'},
    {'1': 'redemption_pin', '3': 23, '4': 1, '5': 9, '10': 'redemptionPin'},
    {'1': 'country_code', '3': 24, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'logo_url', '3': 25, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'provider_product_id', '3': 26, '4': 1, '5': 3, '10': 'providerProductId'},
    {'1': 'discount_percentage', '3': 27, '4': 1, '5': 1, '10': 'discountPercentage'},
    {'1': 'sender_amount', '3': 28, '4': 1, '5': 1, '10': 'senderAmount'},
    {'1': 'sender_currency', '3': 29, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'transferred_from_id', '3': 30, '4': 1, '5': 9, '10': 'transferredFromId'},
    {'1': 'sender_user_id', '3': 31, '4': 1, '5': 9, '10': 'senderUserId'},
    {'1': 'transfer_type', '3': 32, '4': 1, '5': 9, '10': 'transferType'},
    {'1': 'redemption_instructions', '3': 33, '4': 1, '5': 9, '10': 'redemptionInstructions'},
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
    {'1': 'terms_and_conditions', '3': 10, '4': 1, '5': 9, '10': 'termsAndConditions'},
    {'1': 'provider_name', '3': 17, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'product_id', '3': 11, '4': 1, '5': 3, '10': 'productId'},
    {'1': 'country_code', '3': 12, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'fixed_denominations', '3': 13, '4': 3, '5': 11, '6': '.giftcards.GiftCardDenomination', '10': 'fixedDenominations'},
    {'1': 'discount_percentage', '3': 14, '4': 1, '5': 1, '10': 'discountPercentage'},
    {'1': 'currency_code', '3': 15, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'redemption_instructions', '3': 16, '4': 1, '5': 9, '10': 'redemptionInstructions'},
    {'1': 'sender_currency_code', '3': 18, '4': 1, '5': 9, '10': 'senderCurrencyCode'},
    {'1': 'sender_denominations', '3': 19, '4': 3, '5': 1, '10': 'senderDenominations'},
    {'1': 'min_sender_amount', '3': 20, '4': 1, '5': 1, '10': 'minSenderAmount'},
    {'1': 'max_sender_amount', '3': 21, '4': 1, '5': 1, '10': 'maxSenderAmount'},
    {'1': 'sender_fee', '3': 22, '4': 1, '5': 1, '10': 'senderFee'},
    {'1': 'sender_fee_percentage', '3': 23, '4': 1, '5': 1, '10': 'senderFeePercentage'},
    {'1': 'fixed_sender_denominations', '3': 24, '4': 3, '5': 11, '6': '.giftcards.GiftCardDenomination', '10': 'fixedSenderDenominations'},
    {'1': 'denomination_type', '3': 25, '4': 1, '5': 9, '10': 'denominationType'},
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
    'ZXJEZW5vbWluYXRpb25zEisKEWRlbm9taW5hdGlvbl90eXBlGBkgASgJUhBkZW5vbWluYXRpb2'
    '5UeXBl');

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
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCard', '10': 'giftCard'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'provider_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'providerTransactionId'},
    {'1': 'sender_amount', '3': 5, '4': 1, '5': 1, '10': 'senderAmount'},
    {'1': 'sender_currency', '3': 6, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'recipient_amount', '3': 7, '4': 1, '5': 1, '10': 'recipientAmount'},
    {'1': 'recipient_currency', '3': 8, '4': 1, '5': 9, '10': 'recipientCurrency'},
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

@$core.Deprecated('Use buyErrorDescriptor instead')
const BuyError$json = {
  '1': 'BuyError',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 14, '6': '.giftcards.BuyErrorCode', '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyErrorDescriptor = $convert.base64Decode(
    'CghCdXlFcnJvchIrCgRjb2RlGAEgASgOMhcuZ2lmdGNhcmRzLkJ1eUVycm9yQ29kZVIEY29kZR'
    'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

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
    {'1': 'redemption_instructions', '3': 5, '4': 1, '5': 9, '10': 'redemptionInstructions'},
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
    {'1': 'brands', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardBrand', '10': 'brands'},
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
    {'1': 'provider_name', '3': 9, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'form', '3': 10, '4': 1, '5': 9, '10': 'form'},
    {'1': 'subcategory_id', '3': 11, '4': 1, '5': 9, '10': 'subcategoryId'},
    {'1': 'country', '3': 12, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `SellableCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellableCardDescriptor = $convert.base64Decode(
    'CgxTZWxsYWJsZUNhcmQSGwoJY2FyZF90eXBlGAEgASgJUghjYXJkVHlwZRIhCgxkaXNwbGF5X2'
    '5hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNh'
    'dGVnb3J5GAQgASgJUghjYXRlZ29yeRIkCg1kZW5vbWluYXRpb25zGAUgAygBUg1kZW5vbWluYX'
    'Rpb25zEh4KCmN1cnJlbmNpZXMYBiADKAlSCmN1cnJlbmNpZXMSKQoQbWluX2Rlbm9taW5hdGlv'
    'bhgHIAEoAVIPbWluRGVub21pbmF0aW9uEikKEG1heF9kZW5vbWluYXRpb24YCCABKAFSD21heE'
    'Rlbm9taW5hdGlvbhIjCg1wcm92aWRlcl9uYW1lGAkgASgJUgxwcm92aWRlck5hbWUSEgoEZm9y'
    'bRgKIAEoCVIEZm9ybRIlCg5zdWJjYXRlZ29yeV9pZBgLIAEoCVINc3ViY2F0ZWdvcnlJZBIYCg'
    'djb3VudHJ5GAwgASgJUgdjb3VudHJ5');

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
    {'1': 'payout_lower_bound', '3': 7, '4': 1, '5': 1, '10': 'payoutLowerBound'},
    {'1': 'payout_upper_bound', '3': 8, '4': 1, '5': 1, '10': 'payoutUpperBound'},
    {'1': 'is_manual_mode', '3': 9, '4': 1, '5': 8, '10': 'isManualMode'},
  ],
};

/// Descriptor for `SellRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellRateDescriptor = $convert.base64Decode(
    'CghTZWxsUmF0ZRIbCgljYXJkX3R5cGUYASABKAlSCGNhcmRUeXBlEiIKDGRlbm9taW5hdGlvbh'
    'gCIAEoAVIMZGVub21pbmF0aW9uEicKD3JhdGVfcGVyY2VudGFnZRgDIAEoAVIOcmF0ZVBlcmNl'
    'bnRhZ2USIwoNcGF5b3V0X2Ftb3VudBgEIAEoAVIMcGF5b3V0QW1vdW50EhoKCGN1cnJlbmN5GA'
    'UgASgJUghjdXJyZW5jeRIdCgpleHBpcmVzX2F0GAYgASgJUglleHBpcmVzQXQSLAoScGF5b3V0'
    'X2xvd2VyX2JvdW5kGAcgASgBUhBwYXlvdXRMb3dlckJvdW5kEiwKEnBheW91dF91cHBlcl9ib3'
    'VuZBgIIAEoAVIQcGF5b3V0VXBwZXJCb3VuZBIkCg5pc19tYW51YWxfbW9kZRgJIAEoCFIMaXNN'
    'YW51YWxNb2Rl');

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
    {'1': 'payout_error', '3': 18, '4': 1, '5': 9, '10': 'payoutError'},
    {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 20, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'image_urls', '3': 21, '4': 3, '5': 9, '10': 'imageUrls'},
    {'1': 'ocr_brand', '3': 22, '4': 1, '5': 9, '10': 'ocrBrand'},
    {'1': 'ocr_card_number', '3': 23, '4': 1, '5': 9, '10': 'ocrCardNumber'},
    {'1': 'ocr_pin', '3': 24, '4': 1, '5': 9, '10': 'ocrPin'},
    {'1': 'ocr_denomination', '3': 25, '4': 1, '5': 1, '10': 'ocrDenomination'},
    {'1': 'ocr_currency', '3': 26, '4': 1, '5': 9, '10': 'ocrCurrency'},
    {'1': 'admin_reviewer_id', '3': 27, '4': 1, '5': 9, '10': 'adminReviewerId'},
    {'1': 'rejection_reason', '3': 28, '4': 1, '5': 9, '10': 'rejectionReason'},
    {'1': 'admin_notes', '3': 29, '4': 1, '5': 9, '10': 'adminNotes'},
    {'1': 'card_pin', '3': 30, '4': 1, '5': 9, '10': 'cardPin'},
    {'1': 'exit_rate_percent', '3': 31, '4': 1, '5': 1, '10': 'exitRatePercent'},
    {'1': 'base_margin_percent', '3': 32, '4': 1, '5': 1, '10': 'baseMarginPercent'},
    {'1': 'risk_buffer_percent', '3': 33, '4': 1, '5': 1, '10': 'riskBufferPercent'},
    {'1': 'commission_amount', '3': 34, '4': 1, '5': 1, '10': 'commissionAmount'},
    {'1': 'risk_score', '3': 35, '4': 1, '5': 5, '10': 'riskScore'},
    {'1': 'risk_level', '3': 36, '4': 1, '5': 9, '10': 'riskLevel'},
    {'1': 'risk_flags', '3': 37, '4': 3, '5': 9, '10': 'riskFlags'},
    {'1': 'risk_action', '3': 38, '4': 1, '5': 9, '10': 'riskAction'},
    {'1': 'card_country', '3': 39, '4': 1, '5': 9, '10': 'cardCountry'},
    {'1': 'card_format', '3': 40, '4': 1, '5': 9, '10': 'cardFormat'},
    {'1': 'brand_name', '3': 41, '4': 1, '5': 9, '10': 'brandName'},
    {'1': 'original_amount', '3': 42, '4': 1, '5': 1, '10': 'originalAmount'},
    {'1': 'retail_amount', '3': 43, '4': 1, '5': 1, '10': 'retailAmount'},
    {'1': 'retail_currency', '3': 44, '4': 1, '5': 9, '10': 'retailCurrency'},
    {'1': 'wholesale_amount', '3': 45, '4': 1, '5': 1, '10': 'wholesaleAmount'},
    {'1': 'wholesale_currency', '3': 46, '4': 1, '5': 9, '10': 'wholesaleCurrency'},
    {'1': 'commission_amount_buy', '3': 47, '4': 1, '5': 1, '10': 'commissionAmountBuy'},
    {'1': 'commission_currency', '3': 48, '4': 1, '5': 9, '10': 'commissionCurrency'},
    {'1': 'sender_amount', '3': 49, '4': 1, '5': 1, '10': 'senderAmount'},
    {'1': 'sender_currency', '3': 50, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'fx_rate', '3': 51, '4': 1, '5': 1, '10': 'fxRate'},
    {'1': 'fee_percentage', '3': 52, '4': 1, '5': 1, '10': 'feePercentage'},
    {'1': 'redemption_code', '3': 53, '4': 1, '5': 9, '10': 'redemptionCode'},
    {'1': 'redemption_pin', '3': 54, '4': 1, '5': 9, '10': 'redemptionPin'},
    {'1': 'provider_transaction_id', '3': 55, '4': 1, '5': 9, '10': 'providerTransactionId'},
    {'1': 'completed_at', '3': 56, '4': 1, '5': 9, '10': 'completedAt'},
    {'1': 'request_json', '3': 57, '4': 1, '5': 9, '10': 'requestJson'},
    {'1': 'response_json', '3': 58, '4': 1, '5': 9, '10': 'responseJson'},
    {'1': 'provider_http_status', '3': 59, '4': 1, '5': 5, '10': 'providerHttpStatus'},
    {'1': 'provider_duration_ms', '3': 60, '4': 1, '5': 3, '10': 'providerDurationMs'},
    {'1': 'failure_reason', '3': 61, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'quote_provider', '3': 62, '4': 1, '5': 9, '10': 'quoteProvider'},
    {'1': 'settlement_status', '3': 63, '4': 1, '5': 9, '10': 'settlementStatus'},
    {'1': 'display_status', '3': 64, '4': 1, '5': 9, '10': 'displayStatus'},
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
    'QXQSIQoMcGF5b3V0X2Vycm9yGBIgASgJUgtwYXlvdXRFcnJvchIdCgpjcmVhdGVkX2F0GBMgAS'
    'gJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgUIAEoCVIJdXBkYXRlZEF0Eh0KCmltYWdlX3Vy'
    'bHMYFSADKAlSCWltYWdlVXJscxIbCglvY3JfYnJhbmQYFiABKAlSCG9jckJyYW5kEiYKD29jcl'
    '9jYXJkX251bWJlchgXIAEoCVINb2NyQ2FyZE51bWJlchIXCgdvY3JfcGluGBggASgJUgZvY3JQ'
    'aW4SKQoQb2NyX2Rlbm9taW5hdGlvbhgZIAEoAVIPb2NyRGVub21pbmF0aW9uEiEKDG9jcl9jdX'
    'JyZW5jeRgaIAEoCVILb2NyQ3VycmVuY3kSKgoRYWRtaW5fcmV2aWV3ZXJfaWQYGyABKAlSD2Fk'
    'bWluUmV2aWV3ZXJJZBIpChByZWplY3Rpb25fcmVhc29uGBwgASgJUg9yZWplY3Rpb25SZWFzb2'
    '4SHwoLYWRtaW5fbm90ZXMYHSABKAlSCmFkbWluTm90ZXMSGQoIY2FyZF9waW4YHiABKAlSB2Nh'
    'cmRQaW4SKgoRZXhpdF9yYXRlX3BlcmNlbnQYHyABKAFSD2V4aXRSYXRlUGVyY2VudBIuChNiYX'
    'NlX21hcmdpbl9wZXJjZW50GCAgASgBUhFiYXNlTWFyZ2luUGVyY2VudBIuChNyaXNrX2J1ZmZl'
    'cl9wZXJjZW50GCEgASgBUhFyaXNrQnVmZmVyUGVyY2VudBIrChFjb21taXNzaW9uX2Ftb3VudB'
    'giIAEoAVIQY29tbWlzc2lvbkFtb3VudBIdCgpyaXNrX3Njb3JlGCMgASgFUglyaXNrU2NvcmUS'
    'HQoKcmlza19sZXZlbBgkIAEoCVIJcmlza0xldmVsEh0KCnJpc2tfZmxhZ3MYJSADKAlSCXJpc2'
    'tGbGFncxIfCgtyaXNrX2FjdGlvbhgmIAEoCVIKcmlza0FjdGlvbhIhCgxjYXJkX2NvdW50cnkY'
    'JyABKAlSC2NhcmRDb3VudHJ5Eh8KC2NhcmRfZm9ybWF0GCggASgJUgpjYXJkRm9ybWF0Eh0KCm'
    'JyYW5kX25hbWUYKSABKAlSCWJyYW5kTmFtZRInCg9vcmlnaW5hbF9hbW91bnQYKiABKAFSDm9y'
    'aWdpbmFsQW1vdW50EiMKDXJldGFpbF9hbW91bnQYKyABKAFSDHJldGFpbEFtb3VudBInCg9yZX'
    'RhaWxfY3VycmVuY3kYLCABKAlSDnJldGFpbEN1cnJlbmN5EikKEHdob2xlc2FsZV9hbW91bnQY'
    'LSABKAFSD3dob2xlc2FsZUFtb3VudBItChJ3aG9sZXNhbGVfY3VycmVuY3kYLiABKAlSEXdob2'
    'xlc2FsZUN1cnJlbmN5EjIKFWNvbW1pc3Npb25fYW1vdW50X2J1eRgvIAEoAVITY29tbWlzc2lv'
    'bkFtb3VudEJ1eRIvChNjb21taXNzaW9uX2N1cnJlbmN5GDAgASgJUhJjb21taXNzaW9uQ3Vycm'
    'VuY3kSIwoNc2VuZGVyX2Ftb3VudBgxIAEoAVIMc2VuZGVyQW1vdW50EicKD3NlbmRlcl9jdXJy'
    'ZW5jeRgyIAEoCVIOc2VuZGVyQ3VycmVuY3kSFwoHZnhfcmF0ZRgzIAEoAVIGZnhSYXRlEiUKDm'
    'ZlZV9wZXJjZW50YWdlGDQgASgBUg1mZWVQZXJjZW50YWdlEicKD3JlZGVtcHRpb25fY29kZRg1'
    'IAEoCVIOcmVkZW1wdGlvbkNvZGUSJQoOcmVkZW1wdGlvbl9waW4YNiABKAlSDXJlZGVtcHRpb2'
    '5QaW4SNgoXcHJvdmlkZXJfdHJhbnNhY3Rpb25faWQYNyABKAlSFXByb3ZpZGVyVHJhbnNhY3Rp'
    'b25JZBIhCgxjb21wbGV0ZWRfYXQYOCABKAlSC2NvbXBsZXRlZEF0EiEKDHJlcXVlc3RfanNvbh'
    'g5IAEoCVILcmVxdWVzdEpzb24SIwoNcmVzcG9uc2VfanNvbhg6IAEoCVIMcmVzcG9uc2VKc29u'
    'EjAKFHByb3ZpZGVyX2h0dHBfc3RhdHVzGDsgASgFUhJwcm92aWRlckh0dHBTdGF0dXMSMAoUcH'
    'JvdmlkZXJfZHVyYXRpb25fbXMYPCABKANSEnByb3ZpZGVyRHVyYXRpb25NcxIlCg5mYWlsdXJl'
    'X3JlYXNvbhg9IAEoCVINZmFpbHVyZVJlYXNvbhIlCg5xdW90ZV9wcm92aWRlchg+IAEoCVINcX'
    'VvdGVQcm92aWRlchIrChFzZXR0bGVtZW50X3N0YXR1cxg/IAEoCVIQc2V0dGxlbWVudFN0YXR1'
    'cxIlCg5kaXNwbGF5X3N0YXR1cxhAIAEoCVINZGlzcGxheVN0YXR1cw==');

@$core.Deprecated('Use getSellableCardsRequestDescriptor instead')
const GetSellableCardsRequest$json = {
  '1': 'GetSellableCardsRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetSellableCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellableCardsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRTZWxsYWJsZUNhcmRzUmVxdWVzdBIhCgxjb3VudHJ5X2NvZGUYASABKAlSC2NvdW50cn'
    'lDb2Rl');

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

@$core.Deprecated('Use getSellProviderRequestDescriptor instead')
const GetSellProviderRequest$json = {
  '1': 'GetSellProviderRequest',
};

/// Descriptor for `GetSellProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellProviderRequestDescriptor = $convert.base64Decode(
    'ChZHZXRTZWxsUHJvdmlkZXJSZXF1ZXN0');

@$core.Deprecated('Use getSellProviderResponseDescriptor instead')
const GetSellProviderResponse$json = {
  '1': 'GetSellProviderResponse',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'mode', '3': 3, '4': 1, '5': 9, '10': 'mode'},
    {'1': 'async_enabled', '3': 4, '4': 1, '5': 8, '10': 'asyncEnabled'},
  ],
};

/// Descriptor for `GetSellProviderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellProviderResponseDescriptor = $convert.base64Decode(
    'ChdHZXRTZWxsUHJvdmlkZXJSZXNwb25zZRIaCghwcm92aWRlchgBIAEoCVIIcHJvdmlkZXISIA'
    'oLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEhIKBG1vZGUYAyABKAlSBG1vZGUSIwoN'
    'YXN5bmNfZW5hYmxlZBgEIAEoCFIMYXN5bmNFbmFibGVk');

@$core.Deprecated('Use updateFeatureFlagRequestDescriptor instead')
const UpdateFeatureFlagRequest$json = {
  '1': 'UpdateFeatureFlagRequest',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `UpdateFeatureFlagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeatureFlagRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVGZWF0dXJlRmxhZ1JlcXVlc3QSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAi'
    'ABKAlSBXZhbHVlEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29u');

@$core.Deprecated('Use updateFeatureFlagResponseDescriptor instead')
const UpdateFeatureFlagResponse$json = {
  '1': 'UpdateFeatureFlagResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateFeatureFlagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeatureFlagResponseDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVGZWF0dXJlRmxhZ1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getPayoutMethodsRequestDescriptor instead')
const GetPayoutMethodsRequest$json = {
  '1': 'GetPayoutMethodsRequest',
};

/// Descriptor for `GetPayoutMethodsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutMethodsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRQYXlvdXRNZXRob2RzUmVxdWVzdA==');

@$core.Deprecated('Use payoutMethodDescriptor instead')
const PayoutMethod$json = {
  '1': 'PayoutMethod',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'available', '3': 2, '4': 1, '5': 8, '10': 'available'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `PayoutMethod`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutMethodDescriptor = $convert.base64Decode(
    'CgxQYXlvdXRNZXRob2QSEgoEbmFtZRgBIAEoCVIEbmFtZRIcCglhdmFpbGFibGUYAiABKAhSCW'
    'F2YWlsYWJsZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3k=');

@$core.Deprecated('Use getPayoutMethodsResponseDescriptor instead')
const GetPayoutMethodsResponse$json = {
  '1': 'GetPayoutMethodsResponse',
  '2': [
    {'1': 'methods', '3': 1, '4': 3, '5': 11, '6': '.giftcards.PayoutMethod', '10': 'methods'},
  ],
};

/// Descriptor for `GetPayoutMethodsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutMethodsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRQYXlvdXRNZXRob2RzUmVzcG9uc2USMQoHbWV0aG9kcxgBIAMoCzIXLmdpZnRjYXJkcy'
    '5QYXlvdXRNZXRob2RSB21ldGhvZHM=');

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
    {'1': 'ocr_confidence', '3': 20, '4': 1, '5': 1, '10': 'ocrConfidence'},
    {'1': 'subcategory_id', '3': 21, '4': 1, '5': 9, '10': 'subcategoryId'},
    {'1': 'form', '3': 22, '4': 1, '5': 9, '10': 'form'},
    {'1': 'payout_method', '3': 23, '4': 1, '5': 9, '10': 'payoutMethod'},
    {'1': 'card_code', '3': 24, '4': 1, '5': 9, '10': 'cardCode'},
    {'1': 'disclaimer_accepted', '3': 25, '4': 1, '5': 8, '10': 'disclaimerAccepted'},
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
    'J5GBIgASgJUgtjYXJkQ291bnRyeRIfCgtjYXJkX2Zvcm1hdBgTIAEoCVIKY2FyZEZvcm1hdBIl'
    'Cg5vY3JfY29uZmlkZW5jZRgUIAEoAVINb2NyQ29uZmlkZW5jZRIlCg5zdWJjYXRlZ29yeV9pZB'
    'gVIAEoCVINc3ViY2F0ZWdvcnlJZBISCgRmb3JtGBYgASgJUgRmb3JtEiMKDXBheW91dF9tZXRo'
    'b2QYFyABKAlSDHBheW91dE1ldGhvZBIbCgljYXJkX2NvZGUYGCABKAlSCGNhcmRDb2RlEi8KE2'
    'Rpc2NsYWltZXJfYWNjZXB0ZWQYGSABKAhSEmRpc2NsYWltZXJBY2NlcHRlZA==');

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
final $typed_data.Uint8List uploadSellImageResponseDescriptor = $convert.base64Decode(
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
final $typed_data.Uint8List extractCardDetailsRequestDescriptor = $convert.base64Decode(
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
final $typed_data.Uint8List adminListPendingSalesRequestDescriptor = $convert.base64Decode(
    'ChxBZG1pbkxpc3RQZW5kaW5nU2FsZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEh'
    'QKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldA==');

@$core.Deprecated('Use adminListPendingSalesResponseDescriptor instead')
const AdminListPendingSalesResponse$json = {
  '1': 'AdminListPendingSalesResponse',
  '2': [
    {'1': 'sales', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sales'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListPendingSalesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListPendingSalesResponseDescriptor = $convert.base64Decode(
    'Ch1BZG1pbkxpc3RQZW5kaW5nU2FsZXNSZXNwb25zZRItCgVzYWxlcxgBIAMoCzIXLmdpZnRjYX'
    'Jkcy5HaWZ0Q2FyZFNhbGVSBXNhbGVzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use adminListSellSettlementsRequestDescriptor instead')
const AdminListSellSettlementsRequest$json = {
  '1': 'AdminListSellSettlementsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'source', '3': 2, '4': 1, '5': 9, '10': 'source'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListSellSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellSettlementsRequestDescriptor = $convert.base64Decode(
    'Ch9BZG1pbkxpc3RTZWxsU2V0dGxlbWVudHNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdH'
    'VzEhYKBnNvdXJjZRgCIAEoCVIGc291cmNlEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQY'
    'BCABKAVSBWxpbWl0');

@$core.Deprecated('Use adminSellSettlementDescriptor instead')
const AdminSellSettlement$json = {
  '1': 'AdminSellSettlement',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'brand', '3': 4, '4': 1, '5': 9, '10': 'brand'},
    {'1': 'face_value', '3': 5, '4': 1, '5': 1, '10': 'faceValue'},
    {'1': 'face_currency', '3': 6, '4': 1, '5': 9, '10': 'faceCurrency'},
    {'1': 'payout_currency', '3': 7, '4': 1, '5': 9, '10': 'payoutCurrency'},
    {'1': 'fx_rate', '3': 8, '4': 1, '5': 1, '10': 'fxRate'},
    {'1': 'pre_margin_payout', '3': 9, '4': 1, '5': 1, '10': 'preMarginPayout'},
    {'1': 'paid_to_user', '3': 10, '4': 1, '5': 1, '10': 'paidToUser'},
    {'1': 'sale_proceeds', '3': 11, '4': 1, '5': 1, '10': 'saleProceeds'},
    {'1': 'sale_proceeds_currency', '3': 12, '4': 1, '5': 9, '10': 'saleProceedsCurrency'},
    {'1': 'total_revenue', '3': 13, '4': 1, '5': 1, '10': 'totalRevenue'},
    {'1': 'total_revenue_currency', '3': 14, '4': 1, '5': 9, '10': 'totalRevenueCurrency'},
    {'1': 'margin_percentage', '3': 15, '4': 1, '5': 1, '10': 'marginPercentage'},
    {'1': 'flat_fee', '3': 16, '4': 1, '5': 1, '10': 'flatFee'},
    {'1': 'source', '3': 17, '4': 1, '5': 9, '10': 'source'},
    {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    {'1': 'provider_name', '3': 19, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'paid_at', '3': 20, '4': 1, '5': 9, '10': 'paidAt'},
    {'1': 'created_at', '3': 21, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `AdminSellSettlement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSellSettlementDescriptor = $convert.base64Decode(
    'ChNBZG1pblNlbGxTZXR0bGVtZW50Eg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKA'
    'lSCXJlZmVyZW5jZRIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSFAoFYnJhbmQYBCABKAlSBWJy'
    'YW5kEh0KCmZhY2VfdmFsdWUYBSABKAFSCWZhY2VWYWx1ZRIjCg1mYWNlX2N1cnJlbmN5GAYgAS'
    'gJUgxmYWNlQ3VycmVuY3kSJwoPcGF5b3V0X2N1cnJlbmN5GAcgASgJUg5wYXlvdXRDdXJyZW5j'
    'eRIXCgdmeF9yYXRlGAggASgBUgZmeFJhdGUSKgoRcHJlX21hcmdpbl9wYXlvdXQYCSABKAFSD3'
    'ByZU1hcmdpblBheW91dBIgCgxwYWlkX3RvX3VzZXIYCiABKAFSCnBhaWRUb1VzZXISIwoNc2Fs'
    'ZV9wcm9jZWVkcxgLIAEoAVIMc2FsZVByb2NlZWRzEjQKFnNhbGVfcHJvY2VlZHNfY3VycmVuY3'
    'kYDCABKAlSFHNhbGVQcm9jZWVkc0N1cnJlbmN5EiMKDXRvdGFsX3JldmVudWUYDSABKAFSDHRv'
    'dGFsUmV2ZW51ZRI0ChZ0b3RhbF9yZXZlbnVlX2N1cnJlbmN5GA4gASgJUhR0b3RhbFJldmVudW'
    'VDdXJyZW5jeRIrChFtYXJnaW5fcGVyY2VudGFnZRgPIAEoAVIQbWFyZ2luUGVyY2VudGFnZRIZ'
    'CghmbGF0X2ZlZRgQIAEoAVIHZmxhdEZlZRIWCgZzb3VyY2UYESABKAlSBnNvdXJjZRIWCgZzdG'
    'F0dXMYEiABKAlSBnN0YXR1cxIjCg1wcm92aWRlcl9uYW1lGBMgASgJUgxwcm92aWRlck5hbWUS'
    'FwoHcGFpZF9hdBgUIAEoCVIGcGFpZEF0Eh0KCmNyZWF0ZWRfYXQYFSABKAlSCWNyZWF0ZWRBdA'
    '==');

@$core.Deprecated('Use adminListSellSettlementsResponseDescriptor instead')
const AdminListSellSettlementsResponse$json = {
  '1': 'AdminListSellSettlementsResponse',
  '2': [
    {'1': 'settlements', '3': 1, '4': 3, '5': 11, '6': '.giftcards.AdminSellSettlement', '10': 'settlements'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListSellSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellSettlementsResponseDescriptor = $convert.base64Decode(
    'CiBBZG1pbkxpc3RTZWxsU2V0dGxlbWVudHNSZXNwb25zZRJACgtzZXR0bGVtZW50cxgBIAMoCz'
    'IeLmdpZnRjYXJkcy5BZG1pblNlbGxTZXR0bGVtZW50UgtzZXR0bGVtZW50cxIUCgV0b3RhbBgC'
    'IAEoBVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use adminListBuyTransactionsRequestDescriptor instead')
const AdminListBuyTransactionsRequest$json = {
  '1': 'AdminListBuyTransactionsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'search', '3': 2, '4': 1, '5': 9, '10': 'search'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListBuyTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListBuyTransactionsRequestDescriptor = $convert.base64Decode(
    'Ch9BZG1pbkxpc3RCdXlUcmFuc2FjdGlvbnNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdH'
    'VzEhYKBnNlYXJjaBgCIAEoCVIGc2VhcmNoEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQY'
    'BCABKAVSBWxpbWl0');

@$core.Deprecated('Use adminBuyTransactionDescriptor instead')
const AdminBuyTransaction$json = {
  '1': 'AdminBuyTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'brand_name', '3': 3, '4': 1, '5': 9, '10': 'brandName'},
    {'1': 'original_amount', '3': 4, '4': 1, '5': 1, '10': 'originalAmount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'recipient_email', '3': 10, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 11, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'reference', '3': 12, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'retail_amount', '3': 13, '4': 1, '5': 1, '10': 'retailAmount'},
    {'1': 'retail_currency', '3': 14, '4': 1, '5': 9, '10': 'retailCurrency'},
    {'1': 'wholesale_amount', '3': 15, '4': 1, '5': 1, '10': 'wholesaleAmount'},
    {'1': 'wholesale_currency', '3': 16, '4': 1, '5': 9, '10': 'wholesaleCurrency'},
    {'1': 'commission_amount', '3': 17, '4': 1, '5': 1, '10': 'commissionAmount'},
    {'1': 'commission_currency', '3': 18, '4': 1, '5': 9, '10': 'commissionCurrency'},
    {'1': 'sender_amount', '3': 19, '4': 1, '5': 1, '10': 'senderAmount'},
    {'1': 'sender_currency', '3': 20, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'fx_rate', '3': 21, '4': 1, '5': 1, '10': 'fxRate'},
    {'1': 'fee_percentage', '3': 22, '4': 1, '5': 1, '10': 'feePercentage'},
    {'1': 'completed_at', '3': 23, '4': 1, '5': 9, '10': 'completedAt'},
    {'1': 'provider_name', '3': 24, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'failure_reason', '3': 25, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'redemption_code', '3': 26, '4': 1, '5': 9, '10': 'redemptionCode'},
    {'1': 'redemption_pin', '3': 27, '4': 1, '5': 9, '10': 'redemptionPin'},
    {'1': 'provider_transaction_id', '3': 28, '4': 1, '5': 9, '10': 'providerTransactionId'},
    {'1': 'mode', '3': 29, '4': 1, '5': 9, '10': 'mode'},
    {'1': 'has_refund_entry', '3': 30, '4': 1, '5': 8, '10': 'hasRefundEntry'},
    {'1': 'flat_fee', '3': 41, '4': 1, '5': 1, '10': 'flatFee'},
    {'1': 'refund_state', '3': 35, '4': 1, '5': 9, '10': 'refundState'},
    {'1': 'refund_source', '3': 36, '4': 1, '5': 9, '10': 'refundSource'},
    {'1': 'refund_reason', '3': 37, '4': 1, '5': 9, '10': 'refundReason'},
    {'1': 'final_gateway', '3': 38, '4': 1, '5': 9, '10': 'finalGateway'},
    {'1': 'source', '3': 39, '4': 1, '5': 9, '10': 'source'},
    {'1': 'failover', '3': 40, '4': 1, '5': 9, '10': 'failover'},
    {'1': 'request_json', '3': 31, '4': 1, '5': 9, '10': 'requestJson'},
    {'1': 'response_json', '3': 32, '4': 1, '5': 9, '10': 'responseJson'},
    {'1': 'provider_http_status', '3': 33, '4': 1, '5': 5, '10': 'providerHttpStatus'},
    {'1': 'provider_duration_ms', '3': 34, '4': 1, '5': 3, '10': 'providerDurationMs'},
  ],
};

/// Descriptor for `AdminBuyTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminBuyTransactionDescriptor = $convert.base64Decode(
    'ChNBZG1pbkJ1eVRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSHQoKYnJhbmRfbmFtZRgDIAEoCVIJYnJhbmROYW1lEicKD29yaWdpbmFsX2Ftb3Vu'
    'dBgEIAEoAVIOb3JpZ2luYWxBbW91bnQSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhYKBn'
    'N0YXR1cxgGIAEoCVIGc3RhdHVzEicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVu'
    'Y3lLZXkSHQoKY3JlYXRlZF9hdBgIIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYCSABKA'
    'lSCXVwZGF0ZWRBdBInCg9yZWNpcGllbnRfZW1haWwYCiABKAlSDnJlY2lwaWVudEVtYWlsEiUK'
    'DnJlY2lwaWVudF9uYW1lGAsgASgJUg1yZWNpcGllbnROYW1lEhwKCXJlZmVyZW5jZRgMIAEoCV'
    'IJcmVmZXJlbmNlEiMKDXJldGFpbF9hbW91bnQYDSABKAFSDHJldGFpbEFtb3VudBInCg9yZXRh'
    'aWxfY3VycmVuY3kYDiABKAlSDnJldGFpbEN1cnJlbmN5EikKEHdob2xlc2FsZV9hbW91bnQYDy'
    'ABKAFSD3dob2xlc2FsZUFtb3VudBItChJ3aG9sZXNhbGVfY3VycmVuY3kYECABKAlSEXdob2xl'
    'c2FsZUN1cnJlbmN5EisKEWNvbW1pc3Npb25fYW1vdW50GBEgASgBUhBjb21taXNzaW9uQW1vdW'
    '50Ei8KE2NvbW1pc3Npb25fY3VycmVuY3kYEiABKAlSEmNvbW1pc3Npb25DdXJyZW5jeRIjCg1z'
    'ZW5kZXJfYW1vdW50GBMgASgBUgxzZW5kZXJBbW91bnQSJwoPc2VuZGVyX2N1cnJlbmN5GBQgAS'
    'gJUg5zZW5kZXJDdXJyZW5jeRIXCgdmeF9yYXRlGBUgASgBUgZmeFJhdGUSJQoOZmVlX3BlcmNl'
    'bnRhZ2UYFiABKAFSDWZlZVBlcmNlbnRhZ2USIQoMY29tcGxldGVkX2F0GBcgASgJUgtjb21wbG'
    'V0ZWRBdBIjCg1wcm92aWRlcl9uYW1lGBggASgJUgxwcm92aWRlck5hbWUSJQoOZmFpbHVyZV9y'
    'ZWFzb24YGSABKAlSDWZhaWx1cmVSZWFzb24SJwoPcmVkZW1wdGlvbl9jb2RlGBogASgJUg5yZW'
    'RlbXB0aW9uQ29kZRIlCg5yZWRlbXB0aW9uX3BpbhgbIAEoCVINcmVkZW1wdGlvblBpbhI2Chdw'
    'cm92aWRlcl90cmFuc2FjdGlvbl9pZBgcIAEoCVIVcHJvdmlkZXJUcmFuc2FjdGlvbklkEhIKBG'
    '1vZGUYHSABKAlSBG1vZGUSKAoQaGFzX3JlZnVuZF9lbnRyeRgeIAEoCFIOaGFzUmVmdW5kRW50'
    'cnkSGQoIZmxhdF9mZWUYKSABKAFSB2ZsYXRGZWUSIQoMcmVmdW5kX3N0YXRlGCMgASgJUgtyZW'
    'Z1bmRTdGF0ZRIjCg1yZWZ1bmRfc291cmNlGCQgASgJUgxyZWZ1bmRTb3VyY2USIwoNcmVmdW5k'
    'X3JlYXNvbhglIAEoCVIMcmVmdW5kUmVhc29uEiMKDWZpbmFsX2dhdGV3YXkYJiABKAlSDGZpbm'
    'FsR2F0ZXdheRIWCgZzb3VyY2UYJyABKAlSBnNvdXJjZRIaCghmYWlsb3ZlchgoIAEoCVIIZmFp'
    'bG92ZXISIQoMcmVxdWVzdF9qc29uGB8gASgJUgtyZXF1ZXN0SnNvbhIjCg1yZXNwb25zZV9qc2'
    '9uGCAgASgJUgxyZXNwb25zZUpzb24SMAoUcHJvdmlkZXJfaHR0cF9zdGF0dXMYISABKAVSEnBy'
    'b3ZpZGVySHR0cFN0YXR1cxIwChRwcm92aWRlcl9kdXJhdGlvbl9tcxgiIAEoA1IScHJvdmlkZX'
    'JEdXJhdGlvbk1z');

@$core.Deprecated('Use adminListBuyTransactionsResponseDescriptor instead')
const AdminListBuyTransactionsResponse$json = {
  '1': 'AdminListBuyTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.giftcards.AdminBuyTransaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListBuyTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListBuyTransactionsResponseDescriptor = $convert.base64Decode(
    'CiBBZG1pbkxpc3RCdXlUcmFuc2FjdGlvbnNSZXNwb25zZRJCCgx0cmFuc2FjdGlvbnMYASADKA'
    'syHi5naWZ0Y2FyZHMuQWRtaW5CdXlUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFs'
    'GAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA'
    '==');

@$core.Deprecated('Use adminListRefundLedgerRequestDescriptor instead')
const AdminListRefundLedgerRequest$json = {
  '1': 'AdminListRefundLedgerRequest',
  '2': [
    {'1': 'side', '3': 1, '4': 1, '5': 9, '10': 'side'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListRefundLedgerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListRefundLedgerRequestDescriptor = $convert.base64Decode(
    'ChxBZG1pbkxpc3RSZWZ1bmRMZWRnZXJSZXF1ZXN0EhIKBHNpZGUYASABKAlSBHNpZGUSFgoGc3'
    'RhdHVzGAIgASgJUgZzdGF0dXMSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIF'
    'bGltaXQ=');

@$core.Deprecated('Use adminRefundLedgerEntryDescriptor instead')
const AdminRefundLedgerEntry$json = {
  '1': 'AdminRefundLedgerEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'original_reference', '3': 2, '4': 1, '5': 9, '10': 'originalReference'},
    {'1': 'refund_reference', '3': 3, '4': 1, '5': 9, '10': 'refundReference'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 5, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'direction', '3': 8, '4': 1, '5': 9, '10': 'direction'},
    {'1': 'reason', '3': 9, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'confirmation_status', '3': 10, '4': 1, '5': 9, '10': 'confirmationStatus'},
    {'1': 'settlement_status', '3': 11, '4': 1, '5': 9, '10': 'settlementStatus'},
    {'1': 'provider_transaction_id', '3': 12, '4': 1, '5': 9, '10': 'providerTransactionId'},
    {'1': 'provider_status', '3': 13, '4': 1, '5': 9, '10': 'providerStatus'},
    {'1': 'notes', '3': 14, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'executed_at', '3': 15, '4': 1, '5': 9, '10': 'executedAt'},
    {'1': 'confirmed_at', '3': 16, '4': 1, '5': 9, '10': 'confirmedAt'},
    {'1': 'escalated_at', '3': 17, '4': 1, '5': 9, '10': 'escalatedAt'},
    {'1': 'verification_attempts', '3': 18, '4': 1, '5': 5, '10': 'verificationAttempts'},
    {'1': 'max_verification_retries', '3': 19, '4': 1, '5': 5, '10': 'maxVerificationRetries'},
    {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'side', '3': 22, '4': 1, '5': 9, '10': 'side'},
    {'1': 'source', '3': 23, '4': 1, '5': 9, '10': 'source'},
  ],
};

/// Descriptor for `AdminRefundLedgerEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRefundLedgerEntryDescriptor = $convert.base64Decode(
    'ChZBZG1pblJlZnVuZExlZGdlckVudHJ5Eg4KAmlkGAEgASgJUgJpZBItChJvcmlnaW5hbF9yZW'
    'ZlcmVuY2UYAiABKAlSEW9yaWdpbmFsUmVmZXJlbmNlEikKEHJlZnVuZF9yZWZlcmVuY2UYAyAB'
    'KAlSD3JlZnVuZFJlZmVyZW5jZRIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQSHQoKYWNjb3VudF'
    '9pZBgFIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5'
    'GAcgASgJUghjdXJyZW5jeRIcCglkaXJlY3Rpb24YCCABKAlSCWRpcmVjdGlvbhIWCgZyZWFzb2'
    '4YCSABKAlSBnJlYXNvbhIvChNjb25maXJtYXRpb25fc3RhdHVzGAogASgJUhJjb25maXJtYXRp'
    'b25TdGF0dXMSKwoRc2V0dGxlbWVudF9zdGF0dXMYCyABKAlSEHNldHRsZW1lbnRTdGF0dXMSNg'
    'oXcHJvdmlkZXJfdHJhbnNhY3Rpb25faWQYDCABKAlSFXByb3ZpZGVyVHJhbnNhY3Rpb25JZBIn'
    'Cg9wcm92aWRlcl9zdGF0dXMYDSABKAlSDnByb3ZpZGVyU3RhdHVzEhQKBW5vdGVzGA4gASgJUg'
    'Vub3RlcxIfCgtleGVjdXRlZF9hdBgPIAEoCVIKZXhlY3V0ZWRBdBIhCgxjb25maXJtZWRfYXQY'
    'ECABKAlSC2NvbmZpcm1lZEF0EiEKDGVzY2FsYXRlZF9hdBgRIAEoCVILZXNjYWxhdGVkQXQSMw'
    'oVdmVyaWZpY2F0aW9uX2F0dGVtcHRzGBIgASgFUhR2ZXJpZmljYXRpb25BdHRlbXB0cxI4Chht'
    'YXhfdmVyaWZpY2F0aW9uX3JldHJpZXMYEyABKAVSFm1heFZlcmlmaWNhdGlvblJldHJpZXMSHQ'
    'oKY3JlYXRlZF9hdBgUIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFSABKAlSCXVwZGF0'
    'ZWRBdBISCgRzaWRlGBYgASgJUgRzaWRlEhYKBnNvdXJjZRgXIAEoCVIGc291cmNl');

@$core.Deprecated('Use adminListRefundLedgerResponseDescriptor instead')
const AdminListRefundLedgerResponse$json = {
  '1': 'AdminListRefundLedgerResponse',
  '2': [
    {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.giftcards.AdminRefundLedgerEntry', '10': 'entries'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListRefundLedgerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListRefundLedgerResponseDescriptor = $convert.base64Decode(
    'Ch1BZG1pbkxpc3RSZWZ1bmRMZWRnZXJSZXNwb25zZRI7CgdlbnRyaWVzGAEgAygLMiEuZ2lmdG'
    'NhcmRzLkFkbWluUmVmdW5kTGVkZ2VyRW50cnlSB2VudHJpZXMSFAoFdG90YWwYAiABKAVSBXRv'
    'dGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');

@$core.Deprecated('Use adminGetSaleDetailRequestDescriptor instead')
const AdminGetSaleDetailRequest$json = {
  '1': 'AdminGetSaleDetailRequest',
  '2': [
    {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
  ],
};

/// Descriptor for `AdminGetSaleDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminGetSaleDetailRequestDescriptor = $convert.base64Decode(
    'ChlBZG1pbkdldFNhbGVEZXRhaWxSZXF1ZXN0EhcKB3NhbGVfaWQYASABKAlSBnNhbGVJZA==');

@$core.Deprecated('Use adminGetSaleDetailResponseDescriptor instead')
const AdminGetSaleDetailResponse$json = {
  '1': 'AdminGetSaleDetailResponse',
  '2': [
    {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    {'1': 'image_download_urls', '3': 2, '4': 3, '5': 9, '10': 'imageDownloadUrls'},
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
final $typed_data.Uint8List adminApproveSaleRequestDescriptor = $convert.base64Decode(
    'ChdBZG1pbkFwcHJvdmVTYWxlUmVxdWVzdBIXCgdzYWxlX2lkGAEgASgJUgZzYWxlSWQSHwoLYW'
    'RtaW5fbm90ZXMYAiABKAlSCmFkbWluTm90ZXM=');

@$core.Deprecated('Use adminApproveSaleResponseDescriptor instead')
const AdminApproveSaleResponse$json = {
  '1': 'AdminApproveSaleResponse',
  '2': [
    {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminApproveSaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminApproveSaleResponseDescriptor = $convert.base64Decode(
    'ChhBZG1pbkFwcHJvdmVTYWxlUmVzcG9uc2USKwoEc2FsZRgBIAEoCzIXLmdpZnRjYXJkcy5HaW'
    'Z0Q2FyZFNhbGVSBHNhbGUSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use adminProcessPayoutRequestDescriptor instead')
const AdminProcessPayoutRequest$json = {
  '1': 'AdminProcessPayoutRequest',
  '2': [
    {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
  ],
};

/// Descriptor for `AdminProcessPayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminProcessPayoutRequestDescriptor = $convert.base64Decode(
    'ChlBZG1pblByb2Nlc3NQYXlvdXRSZXF1ZXN0EhcKB3NhbGVfaWQYASABKAlSBnNhbGVJZA==');

@$core.Deprecated('Use adminProcessPayoutResponseDescriptor instead')
const AdminProcessPayoutResponse$json = {
  '1': 'AdminProcessPayoutResponse',
  '2': [
    {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminProcessPayoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminProcessPayoutResponseDescriptor = $convert.base64Decode(
    'ChpBZG1pblByb2Nlc3NQYXlvdXRSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLk'
    'dpZnRDYXJkU2FsZVIEc2FsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

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
    {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminRejectSaleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRejectSaleResponseDescriptor = $convert.base64Decode(
    'ChdBZG1pblJlamVjdFNhbGVSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLkdpZn'
    'RDYXJkU2FsZVIEc2FsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use adminRetryHoldReleaseRequestDescriptor instead')
const AdminRetryHoldReleaseRequest$json = {
  '1': 'AdminRetryHoldReleaseRequest',
  '2': [
    {'1': 'card_id', '3': 1, '4': 1, '5': 9, '10': 'cardId'},
    {'1': 'admin_id', '3': 2, '4': 1, '5': 9, '10': 'adminId'},
  ],
};

/// Descriptor for `AdminRetryHoldReleaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRetryHoldReleaseRequestDescriptor = $convert.base64Decode(
    'ChxBZG1pblJldHJ5SG9sZFJlbGVhc2VSZXF1ZXN0EhcKB2NhcmRfaWQYASABKAlSBmNhcmRJZB'
    'IZCghhZG1pbl9pZBgCIAEoCVIHYWRtaW5JZA==');

@$core.Deprecated('Use adminRetryHoldReleaseResponseDescriptor instead')
const AdminRetryHoldReleaseResponse$json = {
  '1': 'AdminRetryHoldReleaseResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `AdminRetryHoldReleaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRetryHoldReleaseResponseDescriptor = $convert.base64Decode(
    'Ch1BZG1pblJldHJ5SG9sZFJlbGVhc2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZX'
    'NzEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9y'
    'TWVzc2FnZQ==');

@$core.Deprecated('Use adminManualRefundPurchaseRequestDescriptor instead')
const AdminManualRefundPurchaseRequest$json = {
  '1': 'AdminManualRefundPurchaseRequest',
  '2': [
    {'1': 'card_id', '3': 1, '4': 1, '5': 9, '10': 'cardId'},
    {'1': 'admin_id', '3': 2, '4': 1, '5': 9, '10': 'adminId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'notes', '3': 4, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `AdminManualRefundPurchaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminManualRefundPurchaseRequestDescriptor = $convert.base64Decode(
    'CiBBZG1pbk1hbnVhbFJlZnVuZFB1cmNoYXNlUmVxdWVzdBIXCgdjYXJkX2lkGAEgASgJUgZjYX'
    'JkSWQSGQoIYWRtaW5faWQYAiABKAlSB2FkbWluSWQSFgoGcmVhc29uGAMgASgJUgZyZWFzb24S'
    'FAoFbm90ZXMYBCABKAlSBW5vdGVz');

@$core.Deprecated('Use adminManualRefundPurchaseResponseDescriptor instead')
const AdminManualRefundPurchaseResponse$json = {
  '1': 'AdminManualRefundPurchaseResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminManualRefundPurchaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminManualRefundPurchaseResponseDescriptor = $convert.base64Decode(
    'CiFBZG1pbk1hbnVhbFJlZnVuZFB1cmNoYXNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3'
    'VjY2VzcxIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use adminForceReconcilePurchaseRequestDescriptor instead')
const AdminForceReconcilePurchaseRequest$json = {
  '1': 'AdminForceReconcilePurchaseRequest',
  '2': [
    {'1': 'card_id', '3': 1, '4': 1, '5': 9, '10': 'cardId'},
    {'1': 'admin_id', '3': 2, '4': 1, '5': 9, '10': 'adminId'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminForceReconcilePurchaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceReconcilePurchaseRequestDescriptor = $convert.base64Decode(
    'CiJBZG1pbkZvcmNlUmVjb25jaWxlUHVyY2hhc2VSZXF1ZXN0EhcKB2NhcmRfaWQYASABKAlSBm'
    'NhcmRJZBIZCghhZG1pbl9pZBgCIAEoCVIHYWRtaW5JZBIWCgZyZWFzb24YAyABKAlSBnJlYXNv'
    'bg==');

@$core.Deprecated('Use adminForceReconcilePurchaseResponseDescriptor instead')
const AdminForceReconcilePurchaseResponse$json = {
  '1': 'AdminForceReconcilePurchaseResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminForceReconcilePurchaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceReconcilePurchaseResponseDescriptor = $convert.base64Decode(
    'CiNBZG1pbkZvcmNlUmVjb25jaWxlUHVyY2hhc2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUg'
    'dzdWNjZXNzEhYKBmFjdGlvbhgCIAEoCVIGYWN0aW9uEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVz'
    'EhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use adminSetSellPayoutOverrideRequestDescriptor instead')
const AdminSetSellPayoutOverrideRequest$json = {
  '1': 'AdminSetSellPayoutOverrideRequest',
  '2': [
    {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'note', '3': 4, '4': 1, '5': 9, '10': 'note'},
    {'1': 'admin_id', '3': 5, '4': 1, '5': 9, '10': 'adminId'},
  ],
};

/// Descriptor for `AdminSetSellPayoutOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetSellPayoutOverrideRequestDescriptor = $convert.base64Decode(
    'CiFBZG1pblNldFNlbGxQYXlvdXRPdmVycmlkZVJlcXVlc3QSFwoHc2FsZV9pZBgBIAEoCVIGc2'
    'FsZUlkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5j'
    'eRISCgRub3RlGAQgASgJUgRub3RlEhkKCGFkbWluX2lkGAUgASgJUgdhZG1pbklk');

@$core.Deprecated('Use adminSetSellPayoutOverrideResponseDescriptor instead')
const AdminSetSellPayoutOverrideResponse$json = {
  '1': 'AdminSetSellPayoutOverrideResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'override_amount', '3': 2, '4': 1, '5': 1, '10': 'overrideAmount'},
    {'1': 'override_currency', '3': 3, '4': 1, '5': 9, '10': 'overrideCurrency'},
    {'1': 'resolved_ngn', '3': 4, '4': 1, '5': 1, '10': 'resolvedNgn'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminSetSellPayoutOverrideResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetSellPayoutOverrideResponseDescriptor = $convert.base64Decode(
    'CiJBZG1pblNldFNlbGxQYXlvdXRPdmVycmlkZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3'
    'N1Y2Nlc3MSJwoPb3ZlcnJpZGVfYW1vdW50GAIgASgBUg5vdmVycmlkZUFtb3VudBIrChFvdmVy'
    'cmlkZV9jdXJyZW5jeRgDIAEoCVIQb3ZlcnJpZGVDdXJyZW5jeRIhCgxyZXNvbHZlZF9uZ24YBC'
    'ABKAFSC3Jlc29sdmVkTmduEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');

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
    {'1': 'buy_rate_percentage', '3': 11, '4': 1, '5': 1, '10': 'buyRatePercentage'},
    {'1': 'commission_percentage', '3': 12, '4': 1, '5': 1, '10': 'commissionPercentage'},
    {'1': 'payout_rate_percentage', '3': 13, '4': 1, '5': 1, '10': 'payoutRatePercentage'},
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
    {'1': 'rates', '3': 1, '4': 3, '5': 11, '6': '.giftcards.SellRateConfig', '10': 'rates'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `AdminListSellRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellRatesResponseDescriptor = $convert.base64Decode(
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
    {'1': 'buy_rate_percentage', '3': 10, '4': 1, '5': 1, '10': 'buyRatePercentage'},
    {'1': 'commission_percentage', '3': 11, '4': 1, '5': 1, '10': 'commissionPercentage'},
    {'1': 'payout_rate_percentage', '3': 12, '4': 1, '5': 1, '10': 'payoutRatePercentage'},
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
    {'1': 'rate', '3': 1, '4': 1, '5': 11, '6': '.giftcards.SellRateConfig', '10': 'rate'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminCreateSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCreateSellRateResponseDescriptor = $convert.base64Decode(
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
    {'1': 'buy_rate_percentage', '3': 11, '4': 1, '5': 1, '10': 'buyRatePercentage'},
    {'1': 'commission_percentage', '3': 12, '4': 1, '5': 1, '10': 'commissionPercentage'},
    {'1': 'payout_rate_percentage', '3': 13, '4': 1, '5': 1, '10': 'payoutRatePercentage'},
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
    {'1': 'rate', '3': 1, '4': 1, '5': 11, '6': '.giftcards.SellRateConfig', '10': 'rate'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminUpdateSellRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminUpdateSellRateResponseDescriptor = $convert.base64Decode(
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
final $typed_data.Uint8List adminToggleSellRateRequestDescriptor = $convert.base64Decode(
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
final $typed_data.Uint8List adminToggleSellRateResponseDescriptor = $convert.base64Decode(
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
final $typed_data.Uint8List getSupportedCountriesRequestDescriptor = $convert.base64Decode(
    'ChxHZXRTdXBwb3J0ZWRDb3VudHJpZXNSZXF1ZXN0');

@$core.Deprecated('Use getSupportedCountriesResponseDescriptor instead')
const GetSupportedCountriesResponse$json = {
  '1': 'GetSupportedCountriesResponse',
  '2': [
    {'1': 'countries', '3': 1, '4': 3, '5': 11, '6': '.giftcards.GiftCardCountry', '10': 'countries'},
  ],
};

/// Descriptor for `GetSupportedCountriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSupportedCountriesResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRTdXBwb3J0ZWRDb3VudHJpZXNSZXNwb25zZRI4Cgljb3VudHJpZXMYASADKAsyGi5naW'
    'Z0Y2FyZHMuR2lmdENhcmRDb3VudHJ5Ugljb3VudHJpZXM=');

@$core.Deprecated('Use getGiftCardsAnalyticsRequestDescriptor instead')
const GetGiftCardsAnalyticsRequest$json = {
  '1': 'GetGiftCardsAnalyticsRequest',
  '2': [
    {'1': 'time_range', '3': 1, '4': 1, '5': 9, '10': 'timeRange'},
    {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `GetGiftCardsAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardsAnalyticsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRHaWZ0Q2FyZHNBbmFseXRpY3NSZXF1ZXN0Eh0KCnRpbWVfcmFuZ2UYASABKAlSCXRpbW'
    'VSYW5nZRIaCghwcm92aWRlchgCIAEoCVIIcHJvdmlkZXI=');

@$core.Deprecated('Use revenuePointDescriptor instead')
const RevenuePoint$json = {
  '1': 'RevenuePoint',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
    {'1': 'revenue', '3': 2, '4': 1, '5': 1, '10': 'revenue'},
    {'1': 'payouts', '3': 3, '4': 1, '5': 1, '10': 'payouts'},
  ],
};

/// Descriptor for `RevenuePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revenuePointDescriptor = $convert.base64Decode(
    'CgxSZXZlbnVlUG9pbnQSEgoEZGF0ZRgBIAEoCVIEZGF0ZRIYCgdyZXZlbnVlGAIgASgBUgdyZX'
    'ZlbnVlEhgKB3BheW91dHMYAyABKAFSB3BheW91dHM=');

@$core.Deprecated('Use providerSliceDescriptor instead')
const ProviderSlice$json = {
  '1': 'ProviderSlice',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'sales', '3': 2, '4': 1, '5': 3, '10': 'sales'},
    {'1': 'revenue', '3': 3, '4': 1, '5': 1, '10': 'revenue'},
  ],
};

/// Descriptor for `ProviderSlice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerSliceDescriptor = $convert.base64Decode(
    'Cg1Qcm92aWRlclNsaWNlEhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIUCgVzYWxlcxgCIA'
    'EoA1IFc2FsZXMSGAoHcmV2ZW51ZRgDIAEoAVIHcmV2ZW51ZQ==');

@$core.Deprecated('Use topCardTypeDescriptor instead')
const TopCardType$json = {
  '1': 'TopCardType',
  '2': [
    {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'sales', '3': 2, '4': 1, '5': 3, '10': 'sales'},
    {'1': 'revenue', '3': 3, '4': 1, '5': 1, '10': 'revenue'},
  ],
};

/// Descriptor for `TopCardType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topCardTypeDescriptor = $convert.base64Decode(
    'CgtUb3BDYXJkVHlwZRIbCgljYXJkX3R5cGUYASABKAlSCGNhcmRUeXBlEhQKBXNhbGVzGAIgAS'
    'gDUgVzYWxlcxIYCgdyZXZlbnVlGAMgASgBUgdyZXZlbnVl');

@$core.Deprecated('Use settlementSliceDescriptor instead')
const SettlementSlice$json = {
  '1': 'SettlementSlice',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'count', '3': 2, '4': 1, '5': 3, '10': 'count'},
  ],
};

/// Descriptor for `SettlementSlice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settlementSliceDescriptor = $convert.base64Decode(
    'Cg9TZXR0bGVtZW50U2xpY2USFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSFAoFY291bnQYAiABKA'
    'NSBWNvdW50');

@$core.Deprecated('Use providerPerformanceDescriptor instead')
const ProviderPerformance$json = {
  '1': 'ProviderPerformance',
  '2': [
    {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'success_rate', '3': 2, '4': 1, '5': 1, '10': 'successRate'},
    {'1': 'average_latency_ms', '3': 3, '4': 1, '5': 1, '10': 'averageLatencyMs'},
    {'1': 'errors', '3': 4, '4': 1, '5': 3, '10': 'errors'},
  ],
};

/// Descriptor for `ProviderPerformance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerPerformanceDescriptor = $convert.base64Decode(
    'ChNQcm92aWRlclBlcmZvcm1hbmNlEhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIhCgxzdW'
    'NjZXNzX3JhdGUYAiABKAFSC3N1Y2Nlc3NSYXRlEiwKEmF2ZXJhZ2VfbGF0ZW5jeV9tcxgDIAEo'
    'AVIQYXZlcmFnZUxhdGVuY3lNcxIWCgZlcnJvcnMYBCABKANSBmVycm9ycw==');

@$core.Deprecated('Use getGiftCardsAnalyticsResponseDescriptor instead')
const GetGiftCardsAnalyticsResponse$json = {
  '1': 'GetGiftCardsAnalyticsResponse',
  '2': [
    {'1': 'total_revenue', '3': 1, '4': 1, '5': 1, '10': 'totalRevenue'},
    {'1': 'total_payouts', '3': 2, '4': 1, '5': 1, '10': 'totalPayouts'},
    {'1': 'gross_profit', '3': 3, '4': 1, '5': 1, '10': 'grossProfit'},
    {'1': 'profit_margin', '3': 4, '4': 1, '5': 1, '10': 'profitMargin'},
    {'1': 'total_sales', '3': 5, '4': 1, '5': 3, '10': 'totalSales'},
    {'1': 'approval_rate', '3': 6, '4': 1, '5': 1, '10': 'approvalRate'},
    {'1': 'revenue_change_percent', '3': 7, '4': 1, '5': 1, '10': 'revenueChangePercent'},
    {'1': 'payouts_change_percent', '3': 8, '4': 1, '5': 1, '10': 'payoutsChangePercent'},
    {'1': 'profit_change_percent', '3': 9, '4': 1, '5': 1, '10': 'profitChangePercent'},
    {'1': 'sales_change_percent', '3': 10, '4': 1, '5': 1, '10': 'salesChangePercent'},
    {'1': 'revenue_over_time', '3': 11, '4': 3, '5': 11, '6': '.giftcards.RevenuePoint', '10': 'revenueOverTime'},
    {'1': 'sales_by_provider', '3': 12, '4': 3, '5': 11, '6': '.giftcards.ProviderSlice', '10': 'salesByProvider'},
    {'1': 'top_card_types', '3': 13, '4': 3, '5': 11, '6': '.giftcards.TopCardType', '10': 'topCardTypes'},
    {'1': 'settlement_status', '3': 14, '4': 3, '5': 11, '6': '.giftcards.SettlementSlice', '10': 'settlementStatus'},
    {'1': 'provider_performance', '3': 15, '4': 3, '5': 11, '6': '.giftcards.ProviderPerformance', '10': 'providerPerformance'},
  ],
};

/// Descriptor for `GetGiftCardsAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardsAnalyticsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRHaWZ0Q2FyZHNBbmFseXRpY3NSZXNwb25zZRIjCg10b3RhbF9yZXZlbnVlGAEgASgBUg'
    'x0b3RhbFJldmVudWUSIwoNdG90YWxfcGF5b3V0cxgCIAEoAVIMdG90YWxQYXlvdXRzEiEKDGdy'
    'b3NzX3Byb2ZpdBgDIAEoAVILZ3Jvc3NQcm9maXQSIwoNcHJvZml0X21hcmdpbhgEIAEoAVIMcH'
    'JvZml0TWFyZ2luEh8KC3RvdGFsX3NhbGVzGAUgASgDUgp0b3RhbFNhbGVzEiMKDWFwcHJvdmFs'
    'X3JhdGUYBiABKAFSDGFwcHJvdmFsUmF0ZRI0ChZyZXZlbnVlX2NoYW5nZV9wZXJjZW50GAcgAS'
    'gBUhRyZXZlbnVlQ2hhbmdlUGVyY2VudBI0ChZwYXlvdXRzX2NoYW5nZV9wZXJjZW50GAggASgB'
    'UhRwYXlvdXRzQ2hhbmdlUGVyY2VudBIyChVwcm9maXRfY2hhbmdlX3BlcmNlbnQYCSABKAFSE3'
    'Byb2ZpdENoYW5nZVBlcmNlbnQSMAoUc2FsZXNfY2hhbmdlX3BlcmNlbnQYCiABKAFSEnNhbGVz'
    'Q2hhbmdlUGVyY2VudBJDChFyZXZlbnVlX292ZXJfdGltZRgLIAMoCzIXLmdpZnRjYXJkcy5SZX'
    'ZlbnVlUG9pbnRSD3JldmVudWVPdmVyVGltZRJEChFzYWxlc19ieV9wcm92aWRlchgMIAMoCzIY'
    'LmdpZnRjYXJkcy5Qcm92aWRlclNsaWNlUg9zYWxlc0J5UHJvdmlkZXISPAoOdG9wX2NhcmRfdH'
    'lwZXMYDSADKAsyFi5naWZ0Y2FyZHMuVG9wQ2FyZFR5cGVSDHRvcENhcmRUeXBlcxJHChFzZXR0'
    'bGVtZW50X3N0YXR1cxgOIAMoCzIaLmdpZnRjYXJkcy5TZXR0bGVtZW50U2xpY2VSEHNldHRsZW'
    '1lbnRTdGF0dXMSUQoUcHJvdmlkZXJfcGVyZm9ybWFuY2UYDyADKAsyHi5naWZ0Y2FyZHMuUHJv'
    'dmlkZXJQZXJmb3JtYW5jZVITcHJvdmlkZXJQZXJmb3JtYW5jZQ==');

@$core.Deprecated('Use reconciliationRunDescriptor instead')
const ReconciliationRun$json = {
  '1': 'ReconciliationRun',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'items_processed', '3': 5, '4': 1, '5': 3, '10': 'itemsProcessed'},
    {'1': 'resolved', '3': 6, '4': 1, '5': 3, '10': 'resolved'},
    {'1': 'escalated', '3': 7, '4': 1, '5': 3, '10': 'escalated'},
    {'1': 'duration', '3': 8, '4': 1, '5': 9, '10': 'duration'},
  ],
};

/// Descriptor for `ReconciliationRun`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationRunDescriptor = $convert.base64Decode(
    'ChFSZWNvbmNpbGlhdGlvblJ1bhIOCgJpZBgBIAEoCVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZR'
    'IWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIcCgl0aW1lc3RhbXAYBCABKAlSCXRpbWVzdGFtcBIn'
    'Cg9pdGVtc19wcm9jZXNzZWQYBSABKANSDml0ZW1zUHJvY2Vzc2VkEhoKCHJlc29sdmVkGAYgAS'
    'gDUghyZXNvbHZlZBIcCgllc2NhbGF0ZWQYByABKANSCWVzY2FsYXRlZBIaCghkdXJhdGlvbhgI'
    'IAEoCVIIZHVyYXRpb24=');

@$core.Deprecated('Use getReconciliationOverviewRequestDescriptor instead')
const GetReconciliationOverviewRequest$json = {
  '1': 'GetReconciliationOverviewRequest',
};

/// Descriptor for `GetReconciliationOverviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationOverviewRequestDescriptor = $convert.base64Decode(
    'CiBHZXRSZWNvbmNpbGlhdGlvbk92ZXJ2aWV3UmVxdWVzdA==');

@$core.Deprecated('Use getReconciliationOverviewResponseDescriptor instead')
const GetReconciliationOverviewResponse$json = {
  '1': 'GetReconciliationOverviewResponse',
  '2': [
    {'1': 'orphaned_transactions', '3': 1, '4': 1, '5': 3, '10': 'orphanedTransactions'},
    {'1': 'pending_verification', '3': 2, '4': 1, '5': 3, '10': 'pendingVerification'},
    {'1': 'escalated_items', '3': 3, '4': 1, '5': 3, '10': 'escalatedItems'},
    {'1': 'resolved_today', '3': 4, '4': 1, '5': 3, '10': 'resolvedToday'},
    {'1': 'float_variance', '3': 5, '4': 1, '5': 1, '10': 'floatVariance'},
    {'1': 'float_variance_critical', '3': 6, '4': 1, '5': 8, '10': 'floatVarianceCritical'},
    {'1': 'last_reconciliation', '3': 7, '4': 1, '5': 11, '6': '.giftcards.ReconciliationRun', '10': 'lastReconciliation'},
  ],
};

/// Descriptor for `GetReconciliationOverviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationOverviewResponseDescriptor = $convert.base64Decode(
    'CiFHZXRSZWNvbmNpbGlhdGlvbk92ZXJ2aWV3UmVzcG9uc2USMwoVb3JwaGFuZWRfdHJhbnNhY3'
    'Rpb25zGAEgASgDUhRvcnBoYW5lZFRyYW5zYWN0aW9ucxIxChRwZW5kaW5nX3ZlcmlmaWNhdGlv'
    'bhgCIAEoA1ITcGVuZGluZ1ZlcmlmaWNhdGlvbhInCg9lc2NhbGF0ZWRfaXRlbXMYAyABKANSDm'
    'VzY2FsYXRlZEl0ZW1zEiUKDnJlc29sdmVkX3RvZGF5GAQgASgDUg1yZXNvbHZlZFRvZGF5EiUK'
    'DmZsb2F0X3ZhcmlhbmNlGAUgASgBUg1mbG9hdFZhcmlhbmNlEjYKF2Zsb2F0X3ZhcmlhbmNlX2'
    'NyaXRpY2FsGAYgASgIUhVmbG9hdFZhcmlhbmNlQ3JpdGljYWwSTQoTbGFzdF9yZWNvbmNpbGlh'
    'dGlvbhgHIAEoCzIcLmdpZnRjYXJkcy5SZWNvbmNpbGlhdGlvblJ1blISbGFzdFJlY29uY2lsaW'
    'F0aW9u');

@$core.Deprecated('Use orphanedTransactionDescriptor instead')
const OrphanedTransaction$json = {
  '1': 'OrphanedTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'issue', '3': 5, '4': 1, '5': 9, '10': 'issue'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `OrphanedTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orphanedTransactionDescriptor = $convert.base64Decode(
    'ChNPcnBoYW5lZFRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBISCgR0eXBlGAIgASgJUgR0eX'
    'BlEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50'
    'EhQKBWlzc3VlGAUgASgJUgVpc3N1ZRIdCgpjcmVhdGVkX2F0GAYgASgJUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use getOrphanedTransactionsRequestDescriptor instead')
const GetOrphanedTransactionsRequest$json = {
  '1': 'GetOrphanedTransactionsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetOrphanedTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrphanedTransactionsRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRPcnBoYW5lZFRyYW5zYWN0aW9uc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCg'
    'VsaW1pdBgCIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getOrphanedTransactionsResponseDescriptor instead')
const GetOrphanedTransactionsResponse$json = {
  '1': 'GetOrphanedTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.giftcards.OrphanedTransaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetOrphanedTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrphanedTransactionsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRPcnBoYW5lZFRyYW5zYWN0aW9uc1Jlc3BvbnNlEkIKDHRyYW5zYWN0aW9ucxgBIAMoCz'
    'IeLmdpZnRjYXJkcy5PcnBoYW5lZFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSFAoFdG90YWwY'
    'AiABKANSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');

@$core.Deprecated('Use resolveOrphanedTransactionRequestDescriptor instead')
const ResolveOrphanedTransactionRequest$json = {
  '1': 'ResolveOrphanedTransactionRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'resolution', '3': 2, '4': 1, '5': 9, '10': 'resolution'},
    {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `ResolveOrphanedTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveOrphanedTransactionRequestDescriptor = $convert.base64Decode(
    'CiFSZXNvbHZlT3JwaGFuZWRUcmFuc2FjdGlvblJlcXVlc3QSDgoCaWQYASABKAlSAmlkEh4KCn'
    'Jlc29sdXRpb24YAiABKAlSCnJlc29sdXRpb24SFAoFbm90ZXMYAyABKAlSBW5vdGVz');

@$core.Deprecated('Use resolveOrphanedTransactionResponseDescriptor instead')
const ResolveOrphanedTransactionResponse$json = {
  '1': 'ResolveOrphanedTransactionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResolveOrphanedTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveOrphanedTransactionResponseDescriptor = $convert.base64Decode(
    'CiJSZXNvbHZlT3JwaGFuZWRUcmFuc2FjdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3'
    'N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use pendingVerificationDescriptor instead')
const PendingVerification$json = {
  '1': 'PendingVerification',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'card_type', '3': 3, '4': 1, '5': 9, '10': 'cardType'},
    {'1': 'denomination', '3': 4, '4': 1, '5': 1, '10': 'denomination'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'verification_attempts', '3': 6, '4': 1, '5': 5, '10': 'verificationAttempts'},
    {'1': 'last_checked', '3': 7, '4': 1, '5': 9, '10': 'lastChecked'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `PendingVerification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingVerificationDescriptor = $convert.base64Decode(
    'ChNQZW5kaW5nVmVyaWZpY2F0aW9uEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKA'
    'lSCXJlZmVyZW5jZRIbCgljYXJkX3R5cGUYAyABKAlSCGNhcmRUeXBlEiIKDGRlbm9taW5hdGlv'
    'bhgEIAEoAVIMZGVub21pbmF0aW9uEhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIzChV2ZX'
    'JpZmljYXRpb25fYXR0ZW1wdHMYBiABKAVSFHZlcmlmaWNhdGlvbkF0dGVtcHRzEiEKDGxhc3Rf'
    'Y2hlY2tlZBgHIAEoCVILbGFzdENoZWNrZWQSFgoGc3RhdHVzGAggASgJUgZzdGF0dXM=');

@$core.Deprecated('Use getPendingVerificationsRequestDescriptor instead')
const GetPendingVerificationsRequest$json = {
  '1': 'GetPendingVerificationsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetPendingVerificationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingVerificationsRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRQZW5kaW5nVmVyaWZpY2F0aW9uc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCg'
    'VsaW1pdBgCIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getPendingVerificationsResponseDescriptor instead')
const GetPendingVerificationsResponse$json = {
  '1': 'GetPendingVerificationsResponse',
  '2': [
    {'1': 'verifications', '3': 1, '4': 3, '5': 11, '6': '.giftcards.PendingVerification', '10': 'verifications'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetPendingVerificationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingVerificationsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRQZW5kaW5nVmVyaWZpY2F0aW9uc1Jlc3BvbnNlEkQKDXZlcmlmaWNhdGlvbnMYASADKA'
    'syHi5naWZ0Y2FyZHMuUGVuZGluZ1ZlcmlmaWNhdGlvblINdmVyaWZpY2F0aW9ucxIUCgV0b3Rh'
    'bBgCIAEoA1IFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIFbGltaX'
    'Q=');

@$core.Deprecated('Use escalatedItemDescriptor instead')
const EscalatedItem$json = {
  '1': 'EscalatedItem',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'escalated_at', '3': 5, '4': 1, '5': 9, '10': 'escalatedAt'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'assigned_to', '3': 7, '4': 1, '5': 9, '10': 'assignedTo'},
  ],
};

/// Descriptor for `EscalatedItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List escalatedItemDescriptor = $convert.base64Decode(
    'Cg1Fc2NhbGF0ZWRJdGVtEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZm'
    'VyZW5jZRIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIWCgZyZWFzb24YBCABKAlSBnJlYXNvbhIh'
    'Cgxlc2NhbGF0ZWRfYXQYBSABKAlSC2VzY2FsYXRlZEF0EhYKBnN0YXR1cxgGIAEoCVIGc3RhdH'
    'VzEh8KC2Fzc2lnbmVkX3RvGAcgASgJUgphc3NpZ25lZFRv');

@$core.Deprecated('Use getEscalatedItemsRequestDescriptor instead')
const GetEscalatedItemsRequest$json = {
  '1': 'GetEscalatedItemsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetEscalatedItemsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEscalatedItemsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRFc2NhbGF0ZWRJdGVtc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdB'
    'gCIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getEscalatedItemsResponseDescriptor instead')
const GetEscalatedItemsResponse$json = {
  '1': 'GetEscalatedItemsResponse',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.giftcards.EscalatedItem', '10': 'items'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetEscalatedItemsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEscalatedItemsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRFc2NhbGF0ZWRJdGVtc1Jlc3BvbnNlEi4KBWl0ZW1zGAEgAygLMhguZ2lmdGNhcmRzLk'
    'VzY2FsYXRlZEl0ZW1SBWl0ZW1zEhQKBXRvdGFsGAIgASgDUgV0b3RhbBISCgRwYWdlGAMgASgF'
    'UgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');

@$core.Deprecated('Use resolveEscalatedItemRequestDescriptor instead')
const ResolveEscalatedItemRequest$json = {
  '1': 'ResolveEscalatedItemRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'resolution', '3': 2, '4': 1, '5': 9, '10': 'resolution'},
    {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `ResolveEscalatedItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveEscalatedItemRequestDescriptor = $convert.base64Decode(
    'ChtSZXNvbHZlRXNjYWxhdGVkSXRlbVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEh4KCnJlc29sdX'
    'Rpb24YAiABKAlSCnJlc29sdXRpb24SFAoFbm90ZXMYAyABKAlSBW5vdGVz');

@$core.Deprecated('Use resolveEscalatedItemResponseDescriptor instead')
const ResolveEscalatedItemResponse$json = {
  '1': 'ResolveEscalatedItemResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResolveEscalatedItemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveEscalatedItemResponseDescriptor = $convert.base64Decode(
    'ChxSZXNvbHZlRXNjYWxhdGVkSXRlbVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getReconciliationHistoryRequestDescriptor instead')
const GetReconciliationHistoryRequest$json = {
  '1': 'GetReconciliationHistoryRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetReconciliationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationHistoryRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRSZWNvbmNpbGlhdGlvbkhpc3RvcnlSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdA'
    '==');

@$core.Deprecated('Use getReconciliationHistoryResponseDescriptor instead')
const GetReconciliationHistoryResponse$json = {
  '1': 'GetReconciliationHistoryResponse',
  '2': [
    {'1': 'runs', '3': 1, '4': 3, '5': 11, '6': '.giftcards.ReconciliationRun', '10': 'runs'},
  ],
};

/// Descriptor for `GetReconciliationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationHistoryResponseDescriptor = $convert.base64Decode(
    'CiBHZXRSZWNvbmNpbGlhdGlvbkhpc3RvcnlSZXNwb25zZRIwCgRydW5zGAEgAygLMhwuZ2lmdG'
    'NhcmRzLlJlY29uY2lsaWF0aW9uUnVuUgRydW5z');

@$core.Deprecated('Use userSummaryDescriptor instead')
const UserSummary$json = {
  '1': 'UserSummary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'total_gift_card_sales', '3': 5, '4': 1, '5': 3, '10': 'totalGiftCardSales'},
    {'1': 'total_payouts', '3': 6, '4': 1, '5': 1, '10': 'totalPayouts'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `UserSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSummaryDescriptor = $convert.base64Decode(
    'CgtVc2VyU3VtbWFyeRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVlbW'
    'FpbBgDIAEoCVIFZW1haWwSFAoFcGhvbmUYBCABKAlSBXBob25lEjEKFXRvdGFsX2dpZnRfY2Fy'
    'ZF9zYWxlcxgFIAEoA1ISdG90YWxHaWZ0Q2FyZFNhbGVzEiMKDXRvdGFsX3BheW91dHMYBiABKA'
    'FSDHRvdGFsUGF5b3V0cxIdCgpjcmVhdGVkX2F0GAcgASgJUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use lookupUserRequestDescriptor instead')
const LookupUserRequest$json = {
  '1': 'LookupUserRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
  ],
};

/// Descriptor for `LookupUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserRequestDescriptor = $convert.base64Decode(
    'ChFMb29rdXBVc2VyUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSEgoEdHlwZRgCIAEoCV'
    'IEdHlwZQ==');

@$core.Deprecated('Use lookupUserResponseDescriptor instead')
const LookupUserResponse$json = {
  '1': 'LookupUserResponse',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.giftcards.UserSummary', '10': 'users'},
  ],
};

/// Descriptor for `LookupUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserResponseDescriptor = $convert.base64Decode(
    'ChJMb29rdXBVc2VyUmVzcG9uc2USLAoFdXNlcnMYASADKAsyFi5naWZ0Y2FyZHMuVXNlclN1bW'
    '1hcnlSBXVzZXJz');

@$core.Deprecated('Use getUserDetailsRequestDescriptor instead')
const GetUserDetailsRequest$json = {
  '1': 'GetUserDetailsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDetailsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyRGV0YWlsc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getUserDetailsResponseDescriptor instead')
const GetUserDetailsResponse$json = {
  '1': 'GetUserDetailsResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.giftcards.UserSummary', '10': 'user'},
    {'1': 'recent_sales', '3': 2, '4': 3, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'recentSales'},
  ],
};

/// Descriptor for `GetUserDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDetailsResponseDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyRGV0YWlsc1Jlc3BvbnNlEioKBHVzZXIYASABKAsyFi5naWZ0Y2FyZHMuVXNlcl'
    'N1bW1hcnlSBHVzZXISOgoMcmVjZW50X3NhbGVzGAIgAygLMhcuZ2lmdGNhcmRzLkdpZnRDYXJk'
    'U2FsZVILcmVjZW50U2FsZXM=');

@$core.Deprecated('Use auditLogEntryDescriptor instead')
const AuditLogEntry$json = {
  '1': 'AuditLogEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'timestamp', '3': 2, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'admin', '3': 3, '4': 1, '5': 9, '10': 'admin'},
    {'1': 'action', '3': 4, '4': 1, '5': 9, '10': 'action'},
    {'1': 'target', '3': 5, '4': 1, '5': 9, '10': 'target'},
    {'1': 'details', '3': 6, '4': 1, '5': 9, '10': 'details'},
  ],
};

/// Descriptor for `AuditLogEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditLogEntryDescriptor = $convert.base64Decode(
    'Cg1BdWRpdExvZ0VudHJ5Eg4KAmlkGAEgASgJUgJpZBIcCgl0aW1lc3RhbXAYAiABKAlSCXRpbW'
    'VzdGFtcBIUCgVhZG1pbhgDIAEoCVIFYWRtaW4SFgoGYWN0aW9uGAQgASgJUgZhY3Rpb24SFgoG'
    'dGFyZ2V0GAUgASgJUgZ0YXJnZXQSGAoHZGV0YWlscxgGIAEoCVIHZGV0YWlscw==');

@$core.Deprecated('Use searchGiftCardTransactionRequestDescriptor instead')
const SearchGiftCardTransactionRequest$json = {
  '1': 'SearchGiftCardTransactionRequest',
  '2': [
    {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `SearchGiftCardTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchGiftCardTransactionRequestDescriptor = $convert.base64Decode(
    'CiBTZWFyY2hHaWZ0Q2FyZFRyYW5zYWN0aW9uUmVxdWVzdBIcCglyZWZlcmVuY2UYASABKAlSCX'
    'JlZmVyZW5jZQ==');

@$core.Deprecated('Use searchGiftCardTransactionResponseDescriptor instead')
const SearchGiftCardTransactionResponse$json = {
  '1': 'SearchGiftCardTransactionResponse',
  '2': [
    {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    {'1': 'events', '3': 2, '4': 3, '5': 11, '6': '.giftcards.AuditLogEntry', '10': 'events'},
  ],
};

/// Descriptor for `SearchGiftCardTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchGiftCardTransactionResponseDescriptor = $convert.base64Decode(
    'CiFTZWFyY2hHaWZ0Q2FyZFRyYW5zYWN0aW9uUmVzcG9uc2USKwoEc2FsZRgBIAEoCzIXLmdpZn'
    'RjYXJkcy5HaWZ0Q2FyZFNhbGVSBHNhbGUSMAoGZXZlbnRzGAIgAygLMhguZ2lmdGNhcmRzLkF1'
    'ZGl0TG9nRW50cnlSBmV2ZW50cw==');

@$core.Deprecated('Use bulkPerformManualOperationRequestDescriptor instead')
const BulkPerformManualOperationRequest$json = {
  '1': 'BulkPerformManualOperationRequest',
  '2': [
    {'1': 'transaction_ids', '3': 1, '4': 3, '5': 9, '10': 'transactionIds'},
    {'1': 'operation', '3': 2, '4': 1, '5': 9, '10': 'operation'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'notes', '3': 4, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `BulkPerformManualOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkPerformManualOperationRequestDescriptor = $convert.base64Decode(
    'CiFCdWxrUGVyZm9ybU1hbnVhbE9wZXJhdGlvblJlcXVlc3QSJwoPdHJhbnNhY3Rpb25faWRzGA'
    'EgAygJUg50cmFuc2FjdGlvbklkcxIcCglvcGVyYXRpb24YAiABKAlSCW9wZXJhdGlvbhIWCgZy'
    'ZWFzb24YAyABKAlSBnJlYXNvbhIUCgVub3RlcxgEIAEoCVIFbm90ZXM=');

@$core.Deprecated('Use bulkPerformManualOperationResultDescriptor instead')
const BulkPerformManualOperationResult$json = {
  '1': 'BulkPerformManualOperationResult',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `BulkPerformManualOperationResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkPerformManualOperationResultDescriptor = $convert.base64Decode(
    'CiBCdWxrUGVyZm9ybU1hbnVhbE9wZXJhdGlvblJlc3VsdBIlCg50cmFuc2FjdGlvbl9pZBgBIA'
    'EoCVINdHJhbnNhY3Rpb25JZBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhQKBWVycm9yGAMg'
    'ASgJUgVlcnJvcg==');

@$core.Deprecated('Use bulkPerformManualOperationResponseDescriptor instead')
const BulkPerformManualOperationResponse$json = {
  '1': 'BulkPerformManualOperationResponse',
  '2': [
    {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.giftcards.BulkPerformManualOperationResult', '10': 'results'},
    {'1': 'succeeded', '3': 2, '4': 1, '5': 5, '10': 'succeeded'},
    {'1': 'failed', '3': 3, '4': 1, '5': 5, '10': 'failed'},
  ],
};

/// Descriptor for `BulkPerformManualOperationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkPerformManualOperationResponseDescriptor = $convert.base64Decode(
    'CiJCdWxrUGVyZm9ybU1hbnVhbE9wZXJhdGlvblJlc3BvbnNlEkUKB3Jlc3VsdHMYASADKAsyKy'
    '5naWZ0Y2FyZHMuQnVsa1BlcmZvcm1NYW51YWxPcGVyYXRpb25SZXN1bHRSB3Jlc3VsdHMSHAoJ'
    'c3VjY2VlZGVkGAIgASgFUglzdWNjZWVkZWQSFgoGZmFpbGVkGAMgASgFUgZmYWlsZWQ=');

@$core.Deprecated('Use performManualOperationRequestDescriptor instead')
const PerformManualOperationRequest$json = {
  '1': 'PerformManualOperationRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'operation', '3': 2, '4': 1, '5': 9, '10': 'operation'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'notes', '3': 4, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'amount_override', '3': 5, '4': 1, '5': 1, '10': 'amountOverride'},
  ],
};

/// Descriptor for `PerformManualOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List performManualOperationRequestDescriptor = $convert.base64Decode(
    'Ch1QZXJmb3JtTWFudWFsT3BlcmF0aW9uUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCV'
    'INdHJhbnNhY3Rpb25JZBIcCglvcGVyYXRpb24YAiABKAlSCW9wZXJhdGlvbhIWCgZyZWFzb24Y'
    'AyABKAlSBnJlYXNvbhIUCgVub3RlcxgEIAEoCVIFbm90ZXMSJwoPYW1vdW50X292ZXJyaWRlGA'
    'UgASgBUg5hbW91bnRPdmVycmlkZQ==');

@$core.Deprecated('Use performManualOperationResponseDescriptor instead')
const PerformManualOperationResponse$json = {
  '1': 'PerformManualOperationResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'sale', '3': 3, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
  ],
};

/// Descriptor for `PerformManualOperationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List performManualOperationResponseDescriptor = $convert.base64Decode(
    'Ch5QZXJmb3JtTWFudWFsT3BlcmF0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2'
    'VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEisKBHNhbGUYAyABKAsyFy5naWZ0Y2FyZHMu'
    'R2lmdENhcmRTYWxlUgRzYWxl');

@$core.Deprecated('Use getGiftCardAuditLogRequestDescriptor instead')
const GetGiftCardAuditLogRequest$json = {
  '1': 'GetGiftCardAuditLogRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetGiftCardAuditLogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardAuditLogRequestDescriptor = $convert.base64Decode(
    'ChpHZXRHaWZ0Q2FyZEF1ZGl0TG9nUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdH'
    'JhbnNhY3Rpb25JZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSEgoEcGFnZRgDIAEoBVIEcGFn'
    'ZRIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getGiftCardAuditLogResponseDescriptor instead')
const GetGiftCardAuditLogResponse$json = {
  '1': 'GetGiftCardAuditLogResponse',
  '2': [
    {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.giftcards.AuditLogEntry', '10': 'logs'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetGiftCardAuditLogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardAuditLogResponseDescriptor = $convert.base64Decode(
    'ChtHZXRHaWZ0Q2FyZEF1ZGl0TG9nUmVzcG9uc2USLAoEbG9ncxgBIAMoCzIYLmdpZnRjYXJkcy'
    '5BdWRpdExvZ0VudHJ5UgRsb2dzEhQKBXRvdGFsGAIgASgDUgV0b3RhbBISCgRwYWdlGAMgASgF'
    'UgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');

@$core.Deprecated('Use systemSettingDescriptor instead')
const SystemSetting$json = {
  '1': 'SystemSetting',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
    {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'updated_at', '3': 5, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SystemSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemSettingDescriptor = $convert.base64Decode(
    'Cg1TeXN0ZW1TZXR0aW5nEhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZR'
    'IaCghjYXRlZ29yeRgDIAEoCVIIY2F0ZWdvcnkSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2Ny'
    'aXB0aW9uEh0KCnVwZGF0ZWRfYXQYBSABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use listSystemSettingsRequestDescriptor instead')
const ListSystemSettingsRequest$json = {
  '1': 'ListSystemSettingsRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `ListSystemSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSystemSettingsRequestDescriptor = $convert.base64Decode(
    'ChlMaXN0U3lzdGVtU2V0dGluZ3NSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ29yeQ'
    '==');

@$core.Deprecated('Use listSystemSettingsResponseDescriptor instead')
const ListSystemSettingsResponse$json = {
  '1': 'ListSystemSettingsResponse',
  '2': [
    {'1': 'settings', '3': 1, '4': 3, '5': 11, '6': '.giftcards.SystemSetting', '10': 'settings'},
  ],
};

/// Descriptor for `ListSystemSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSystemSettingsResponseDescriptor = $convert.base64Decode(
    'ChpMaXN0U3lzdGVtU2V0dGluZ3NSZXNwb25zZRI0CghzZXR0aW5ncxgBIAMoCzIYLmdpZnRjYX'
    'Jkcy5TeXN0ZW1TZXR0aW5nUghzZXR0aW5ncw==');

@$core.Deprecated('Use updateSystemSettingRequestDescriptor instead')
const UpdateSystemSettingRequest$json = {
  '1': 'UpdateSystemSettingRequest',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `UpdateSystemSettingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSystemSettingRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVTeXN0ZW1TZXR0aW5nUmVxdWVzdBIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZR'
    'gCIAEoCVIFdmFsdWU=');

@$core.Deprecated('Use updateSystemSettingResponseDescriptor instead')
const UpdateSystemSettingResponse$json = {
  '1': 'UpdateSystemSettingResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'setting', '3': 3, '4': 1, '5': 11, '6': '.giftcards.SystemSetting', '10': 'setting'},
  ],
};

/// Descriptor for `UpdateSystemSettingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSystemSettingResponseDescriptor = $convert.base64Decode(
    'ChtVcGRhdGVTeXN0ZW1TZXR0aW5nUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjIKB3NldHRpbmcYAyABKAsyGC5naWZ0Y2FyZHMu'
    'U3lzdGVtU2V0dGluZ1IHc2V0dGluZw==');

