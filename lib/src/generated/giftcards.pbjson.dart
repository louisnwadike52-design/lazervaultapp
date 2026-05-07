///
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use buyErrorCodeDescriptor instead')
const BuyErrorCode$json = const {
  '1': 'BuyErrorCode',
  '2': const [
    const {'1': 'BUY_ERROR_UNSPECIFIED', '2': 0},
    const {'1': 'BUY_ERROR_INSUFFICIENT_FUNDS', '2': 1},
    const {'1': 'BUY_ERROR_PROVIDER_WALLET_LOW', '2': 2},
    const {'1': 'BUY_ERROR_INVALID_AMOUNT', '2': 3},
    const {'1': 'BUY_ERROR_PROVIDER_BUSY', '2': 4},
    const {'1': 'BUY_ERROR_PROVIDER_MISMATCH', '2': 5},
    const {'1': 'BUY_ERROR_OUT_OF_STOCK', '2': 6},
    const {'1': 'BUY_ERROR_PRODUCT_UNAVAILABLE', '2': 7},
    const {'1': 'BUY_ERROR_DUPLICATE_ORDER', '2': 8},
    const {'1': 'BUY_ERROR_RATE_LIMITED', '2': 9},
    const {'1': 'BUY_ERROR_SELF_SEND', '2': 10},
    const {'1': 'BUY_ERROR_ACCOUNT_NOT_ACTIVE', '2': 11},
    const {'1': 'BUY_ERROR_SPENDING_LIMIT', '2': 12},
    const {'1': 'BUY_ERROR_INTERNAL', '2': 100},
  ],
};

/// Descriptor for `BuyErrorCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List buyErrorCodeDescriptor = $convert.base64Decode('CgxCdXlFcnJvckNvZGUSGQoVQlVZX0VSUk9SX1VOU1BFQ0lGSUVEEAASIAocQlVZX0VSUk9SX0lOU1VGRklDSUVOVF9GVU5EUxABEiEKHUJVWV9FUlJPUl9QUk9WSURFUl9XQUxMRVRfTE9XEAISHAoYQlVZX0VSUk9SX0lOVkFMSURfQU1PVU5UEAMSGwoXQlVZX0VSUk9SX1BST1ZJREVSX0JVU1kQBBIfChtCVVlfRVJST1JfUFJPVklERVJfTUlTTUFUQ0gQBRIaChZCVVlfRVJST1JfT1VUX09GX1NUT0NLEAYSIQodQlVZX0VSUk9SX1BST0RVQ1RfVU5BVkFJTEFCTEUQBxIdChlCVVlfRVJST1JfRFVQTElDQVRFX09SREVSEAgSGgoWQlVZX0VSUk9SX1JBVEVfTElNSVRFRBAJEhcKE0JVWV9FUlJPUl9TRUxGX1NFTkQQChIgChxCVVlfRVJST1JfQUNDT1VOVF9OT1RfQUNUSVZFEAsSHAoYQlVZX0VSUk9SX1NQRU5ESU5HX0xJTUlUEAwSFgoSQlVZX0VSUk9SX0lOVEVSTkFMEGQ=');
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
    const {'1': 'reference', '3': 34, '4': 1, '5': 9, '10': 'reference'},
  ],
  '9': const [
    const {'1': 6, '2': 7},
    const {'1': 7, '2': 8},
    const {'1': 9, '2': 10},
    const {'1': 17, '2': 18},
  ],
};

/// Descriptor for `GiftCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDescriptor = $convert.base64Decode('CghHaWZ0Q2FyZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIZCghicmFuZF9pZBgEIAEoCVIHYnJhbmRJZBIdCgpicmFuZF9uYW1lGAUgASgJUglicmFuZE5hbWUSJwoPb3JpZ2luYWxfYW1vdW50GAggASgBUg5vcmlnaW5hbEFtb3VudBIaCghjdXJyZW5jeRgKIAEoCVIIY3VycmVuY3kSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSIwoNcHVyY2hhc2VfZGF0ZRgMIAEoCVIMcHVyY2hhc2VEYXRlEh8KC2V4cGlyeV9kYXRlGA0gASgJUgpleHBpcnlEYXRlEicKD3JlY2lwaWVudF9lbWFpbBgOIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYDyABKAlSDXJlY2lwaWVudE5hbWUSGAoHbWVzc2FnZRgQIAEoCVIHbWVzc2FnZRIaCghtZXRhZGF0YRgSIAEoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgTIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFCABKAlSCXVwZGF0ZWRBdBI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgVIAEoCVIVcHJvdmlkZXJUcmFuc2FjdGlvbklkEicKD3JlZGVtcHRpb25fY29kZRgWIAEoCVIOcmVkZW1wdGlvbkNvZGUSJQoOcmVkZW1wdGlvbl9waW4YFyABKAlSDXJlZGVtcHRpb25QaW4SIQoMY291bnRyeV9jb2RlGBggASgJUgtjb3VudHJ5Q29kZRIZCghsb2dvX3VybBgZIAEoCVIHbG9nb1VybBIuChNwcm92aWRlcl9wcm9kdWN0X2lkGBogASgDUhFwcm92aWRlclByb2R1Y3RJZBIvChNkaXNjb3VudF9wZXJjZW50YWdlGBsgASgBUhJkaXNjb3VudFBlcmNlbnRhZ2USIwoNc2VuZGVyX2Ftb3VudBgcIAEoAVIMc2VuZGVyQW1vdW50EicKD3NlbmRlcl9jdXJyZW5jeRgdIAEoCVIOc2VuZGVyQ3VycmVuY3kSLgoTdHJhbnNmZXJyZWRfZnJvbV9pZBgeIAEoCVIRdHJhbnNmZXJyZWRGcm9tSWQSJAoOc2VuZGVyX3VzZXJfaWQYHyABKAlSDHNlbmRlclVzZXJJZBIjCg10cmFuc2Zlcl90eXBlGCAgASgJUgx0cmFuc2ZlclR5cGUSNwoXcmVkZW1wdGlvbl9pbnN0cnVjdGlvbnMYISABKAlSFnJlZGVtcHRpb25JbnN0cnVjdGlvbnMSHAoJcmVmZXJlbmNlGCIgASgJUglyZWZlcmVuY2VKBAgGEAdKBAgHEAhKBAgJEApKBAgREBI=');
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
    const {'1': 'denomination_type', '3': 25, '4': 1, '5': 9, '10': 'denominationType'},
  ],
};

/// Descriptor for `GiftCardBrand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardBrandDescriptor = $convert.base64Decode('Cg1HaWZ0Q2FyZEJyYW5kEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SJAoNZGVub21pbmF0aW9ucxgGIAMoAVINZGVub21pbmF0aW9ucxIdCgptaW5fYW1vdW50GAcgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgIIAEoAVIJbWF4QW1vdW50EhsKCWlzX2FjdGl2ZRgJIAEoCFIIaXNBY3RpdmUSMAoUdGVybXNfYW5kX2NvbmRpdGlvbnMYCiABKAlSEnRlcm1zQW5kQ29uZGl0aW9ucxIjCg1wcm92aWRlcl9uYW1lGBEgASgJUgxwcm92aWRlck5hbWUSHQoKcHJvZHVjdF9pZBgLIAEoA1IJcHJvZHVjdElkEiEKDGNvdW50cnlfY29kZRgMIAEoCVILY291bnRyeUNvZGUSUAoTZml4ZWRfZGVub21pbmF0aW9ucxgNIAMoCzIfLmdpZnRjYXJkcy5HaWZ0Q2FyZERlbm9taW5hdGlvblISZml4ZWREZW5vbWluYXRpb25zEi8KE2Rpc2NvdW50X3BlcmNlbnRhZ2UYDiABKAFSEmRpc2NvdW50UGVyY2VudGFnZRIjCg1jdXJyZW5jeV9jb2RlGA8gASgJUgxjdXJyZW5jeUNvZGUSNwoXcmVkZW1wdGlvbl9pbnN0cnVjdGlvbnMYECABKAlSFnJlZGVtcHRpb25JbnN0cnVjdGlvbnMSMAoUc2VuZGVyX2N1cnJlbmN5X2NvZGUYEiABKAlSEnNlbmRlckN1cnJlbmN5Q29kZRIxChRzZW5kZXJfZGVub21pbmF0aW9ucxgTIAMoAVITc2VuZGVyRGVub21pbmF0aW9ucxIqChFtaW5fc2VuZGVyX2Ftb3VudBgUIAEoAVIPbWluU2VuZGVyQW1vdW50EioKEW1heF9zZW5kZXJfYW1vdW50GBUgASgBUg9tYXhTZW5kZXJBbW91bnQSHQoKc2VuZGVyX2ZlZRgWIAEoAVIJc2VuZGVyRmVlEjIKFXNlbmRlcl9mZWVfcGVyY2VudGFnZRgXIAEoAVITc2VuZGVyRmVlUGVyY2VudGFnZRJdChpmaXhlZF9zZW5kZXJfZGVub21pbmF0aW9ucxgYIAMoCzIfLmdpZnRjYXJkcy5HaWZ0Q2FyZERlbm9taW5hdGlvblIYZml4ZWRTZW5kZXJEZW5vbWluYXRpb25zEisKEWRlbm9taW5hdGlvbl90eXBlGBkgASgJUhBkZW5vbWluYXRpb25UeXBl');
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
@$core.Deprecated('Use buyErrorDescriptor instead')
const BuyError$json = const {
  '1': 'BuyError',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 14, '6': '.giftcards.BuyErrorCode', '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyErrorDescriptor = $convert.base64Decode('CghCdXlFcnJvchIrCgRjb2RlGAEgASgOMhcuZ2lmdGNhcmRzLkJ1eUVycm9yQ29kZVIEY29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
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
    const {'1': 'form', '3': 10, '4': 1, '5': 9, '10': 'form'},
    const {'1': 'subcategory_id', '3': 11, '4': 1, '5': 9, '10': 'subcategoryId'},
    const {'1': 'country', '3': 12, '4': 1, '5': 9, '10': 'country'},
  ],
};

/// Descriptor for `SellableCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellableCardDescriptor = $convert.base64Decode('CgxTZWxsYWJsZUNhcmQSGwoJY2FyZF90eXBlGAEgASgJUghjYXJkVHlwZRIhCgxkaXNwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhoKCGNhdGVnb3J5GAQgASgJUghjYXRlZ29yeRIkCg1kZW5vbWluYXRpb25zGAUgAygBUg1kZW5vbWluYXRpb25zEh4KCmN1cnJlbmNpZXMYBiADKAlSCmN1cnJlbmNpZXMSKQoQbWluX2Rlbm9taW5hdGlvbhgHIAEoAVIPbWluRGVub21pbmF0aW9uEikKEG1heF9kZW5vbWluYXRpb24YCCABKAFSD21heERlbm9taW5hdGlvbhIjCg1wcm92aWRlcl9uYW1lGAkgASgJUgxwcm92aWRlck5hbWUSEgoEZm9ybRgKIAEoCVIEZm9ybRIlCg5zdWJjYXRlZ29yeV9pZBgLIAEoCVINc3ViY2F0ZWdvcnlJZBIYCgdjb3VudHJ5GAwgASgJUgdjb3VudHJ5');
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
    const {'1': 'payout_lower_bound', '3': 7, '4': 1, '5': 1, '10': 'payoutLowerBound'},
    const {'1': 'payout_upper_bound', '3': 8, '4': 1, '5': 1, '10': 'payoutUpperBound'},
    const {'1': 'is_manual_mode', '3': 9, '4': 1, '5': 8, '10': 'isManualMode'},
  ],
};

/// Descriptor for `SellRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellRateDescriptor = $convert.base64Decode('CghTZWxsUmF0ZRIbCgljYXJkX3R5cGUYASABKAlSCGNhcmRUeXBlEiIKDGRlbm9taW5hdGlvbhgCIAEoAVIMZGVub21pbmF0aW9uEicKD3JhdGVfcGVyY2VudGFnZRgDIAEoAVIOcmF0ZVBlcmNlbnRhZ2USIwoNcGF5b3V0X2Ftb3VudBgEIAEoAVIMcGF5b3V0QW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIdCgpleHBpcmVzX2F0GAYgASgJUglleHBpcmVzQXQSLAoScGF5b3V0X2xvd2VyX2JvdW5kGAcgASgBUhBwYXlvdXRMb3dlckJvdW5kEiwKEnBheW91dF91cHBlcl9ib3VuZBgIIAEoAVIQcGF5b3V0VXBwZXJCb3VuZBIkCg5pc19tYW51YWxfbW9kZRgJIAEoCFIMaXNNYW51YWxNb2Rl');
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
    const {'1': 'payout_error', '3': 18, '4': 1, '5': 9, '10': 'payoutError'},
    const {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 20, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'image_urls', '3': 21, '4': 3, '5': 9, '10': 'imageUrls'},
    const {'1': 'ocr_brand', '3': 22, '4': 1, '5': 9, '10': 'ocrBrand'},
    const {'1': 'ocr_card_number', '3': 23, '4': 1, '5': 9, '10': 'ocrCardNumber'},
    const {'1': 'ocr_pin', '3': 24, '4': 1, '5': 9, '10': 'ocrPin'},
    const {'1': 'ocr_denomination', '3': 25, '4': 1, '5': 1, '10': 'ocrDenomination'},
    const {'1': 'ocr_currency', '3': 26, '4': 1, '5': 9, '10': 'ocrCurrency'},
    const {'1': 'admin_reviewer_id', '3': 27, '4': 1, '5': 9, '10': 'adminReviewerId'},
    const {'1': 'rejection_reason', '3': 28, '4': 1, '5': 9, '10': 'rejectionReason'},
    const {'1': 'admin_notes', '3': 29, '4': 1, '5': 9, '10': 'adminNotes'},
    const {'1': 'card_pin', '3': 30, '4': 1, '5': 9, '10': 'cardPin'},
    const {'1': 'exit_rate_percent', '3': 31, '4': 1, '5': 1, '10': 'exitRatePercent'},
    const {'1': 'base_margin_percent', '3': 32, '4': 1, '5': 1, '10': 'baseMarginPercent'},
    const {'1': 'risk_buffer_percent', '3': 33, '4': 1, '5': 1, '10': 'riskBufferPercent'},
    const {'1': 'commission_amount', '3': 34, '4': 1, '5': 1, '10': 'commissionAmount'},
    const {'1': 'risk_score', '3': 35, '4': 1, '5': 5, '10': 'riskScore'},
    const {'1': 'risk_level', '3': 36, '4': 1, '5': 9, '10': 'riskLevel'},
    const {'1': 'risk_flags', '3': 37, '4': 3, '5': 9, '10': 'riskFlags'},
    const {'1': 'risk_action', '3': 38, '4': 1, '5': 9, '10': 'riskAction'},
    const {'1': 'card_country', '3': 39, '4': 1, '5': 9, '10': 'cardCountry'},
    const {'1': 'card_format', '3': 40, '4': 1, '5': 9, '10': 'cardFormat'},
    const {'1': 'brand_name', '3': 41, '4': 1, '5': 9, '10': 'brandName'},
    const {'1': 'original_amount', '3': 42, '4': 1, '5': 1, '10': 'originalAmount'},
    const {'1': 'retail_amount', '3': 43, '4': 1, '5': 1, '10': 'retailAmount'},
    const {'1': 'retail_currency', '3': 44, '4': 1, '5': 9, '10': 'retailCurrency'},
    const {'1': 'wholesale_amount', '3': 45, '4': 1, '5': 1, '10': 'wholesaleAmount'},
    const {'1': 'wholesale_currency', '3': 46, '4': 1, '5': 9, '10': 'wholesaleCurrency'},
    const {'1': 'commission_amount_buy', '3': 47, '4': 1, '5': 1, '10': 'commissionAmountBuy'},
    const {'1': 'commission_currency', '3': 48, '4': 1, '5': 9, '10': 'commissionCurrency'},
    const {'1': 'sender_amount', '3': 49, '4': 1, '5': 1, '10': 'senderAmount'},
    const {'1': 'sender_currency', '3': 50, '4': 1, '5': 9, '10': 'senderCurrency'},
    const {'1': 'fx_rate', '3': 51, '4': 1, '5': 1, '10': 'fxRate'},
    const {'1': 'fee_percentage', '3': 52, '4': 1, '5': 1, '10': 'feePercentage'},
    const {'1': 'redemption_code', '3': 53, '4': 1, '5': 9, '10': 'redemptionCode'},
    const {'1': 'redemption_pin', '3': 54, '4': 1, '5': 9, '10': 'redemptionPin'},
    const {'1': 'provider_transaction_id', '3': 55, '4': 1, '5': 9, '10': 'providerTransactionId'},
    const {'1': 'completed_at', '3': 56, '4': 1, '5': 9, '10': 'completedAt'},
    const {'1': 'request_json', '3': 57, '4': 1, '5': 9, '10': 'requestJson'},
    const {'1': 'response_json', '3': 58, '4': 1, '5': 9, '10': 'responseJson'},
    const {'1': 'provider_http_status', '3': 59, '4': 1, '5': 5, '10': 'providerHttpStatus'},
    const {'1': 'provider_duration_ms', '3': 60, '4': 1, '5': 3, '10': 'providerDurationMs'},
    const {'1': 'failure_reason', '3': 61, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'quote_provider', '3': 62, '4': 1, '5': 9, '10': 'quoteProvider'},
    const {'1': 'settlement_status', '3': 63, '4': 1, '5': 9, '10': 'settlementStatus'},
    const {'1': 'display_status', '3': 64, '4': 1, '5': 9, '10': 'displayStatus'},
    const {'1': 'escalated_at', '3': 65, '4': 1, '5': 9, '10': 'escalatedAt'},
    const {'1': 'escalation_reason', '3': 66, '4': 1, '5': 9, '10': 'escalationReason'},
  ],
};

/// Descriptor for `GiftCardSale`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardSaleDescriptor = $convert.base64Decode('CgxHaWZ0Q2FyZFNhbGUSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSGwoJY2FyZF90eXBlGAQgASgJUghjYXJkVHlwZRIfCgtjYXJkX251bWJlchgFIAEoCVIKY2FyZE51bWJlchIiCgxkZW5vbWluYXRpb24YBiABKAFSDGRlbm9taW5hdGlvbhIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSJwoPcmF0ZV9wZXJjZW50YWdlGAggASgBUg5yYXRlUGVyY2VudGFnZRInCg9leHBlY3RlZF9wYXlvdXQYCSABKAFSDmV4cGVjdGVkUGF5b3V0EiMKDWFjdHVhbF9wYXlvdXQYCiABKAFSDGFjdHVhbFBheW91dBIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxIoChBwcm92aWRlcl9zYWxlX2lkGAwgASgJUg5wcm92aWRlclNhbGVJZBIjCg1wcm92aWRlcl9uYW1lGA0gASgJUgxwcm92aWRlck5hbWUSHAoJcmVmZXJlbmNlGA4gASgJUglyZWZlcmVuY2USIQoMc3VibWl0dGVkX2F0GA8gASgJUgtzdWJtaXR0ZWRBdBIfCgtyZXZpZXdlZF9hdBgQIAEoCVIKcmV2aWV3ZWRBdBIXCgdwYWlkX2F0GBEgASgJUgZwYWlkQXQSIQoMcGF5b3V0X2Vycm9yGBIgASgJUgtwYXlvdXRFcnJvchIdCgpjcmVhdGVkX2F0GBMgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgUIAEoCVIJdXBkYXRlZEF0Eh0KCmltYWdlX3VybHMYFSADKAlSCWltYWdlVXJscxIbCglvY3JfYnJhbmQYFiABKAlSCG9jckJyYW5kEiYKD29jcl9jYXJkX251bWJlchgXIAEoCVINb2NyQ2FyZE51bWJlchIXCgdvY3JfcGluGBggASgJUgZvY3JQaW4SKQoQb2NyX2Rlbm9taW5hdGlvbhgZIAEoAVIPb2NyRGVub21pbmF0aW9uEiEKDG9jcl9jdXJyZW5jeRgaIAEoCVILb2NyQ3VycmVuY3kSKgoRYWRtaW5fcmV2aWV3ZXJfaWQYGyABKAlSD2FkbWluUmV2aWV3ZXJJZBIpChByZWplY3Rpb25fcmVhc29uGBwgASgJUg9yZWplY3Rpb25SZWFzb24SHwoLYWRtaW5fbm90ZXMYHSABKAlSCmFkbWluTm90ZXMSGQoIY2FyZF9waW4YHiABKAlSB2NhcmRQaW4SKgoRZXhpdF9yYXRlX3BlcmNlbnQYHyABKAFSD2V4aXRSYXRlUGVyY2VudBIuChNiYXNlX21hcmdpbl9wZXJjZW50GCAgASgBUhFiYXNlTWFyZ2luUGVyY2VudBIuChNyaXNrX2J1ZmZlcl9wZXJjZW50GCEgASgBUhFyaXNrQnVmZmVyUGVyY2VudBIrChFjb21taXNzaW9uX2Ftb3VudBgiIAEoAVIQY29tbWlzc2lvbkFtb3VudBIdCgpyaXNrX3Njb3JlGCMgASgFUglyaXNrU2NvcmUSHQoKcmlza19sZXZlbBgkIAEoCVIJcmlza0xldmVsEh0KCnJpc2tfZmxhZ3MYJSADKAlSCXJpc2tGbGFncxIfCgtyaXNrX2FjdGlvbhgmIAEoCVIKcmlza0FjdGlvbhIhCgxjYXJkX2NvdW50cnkYJyABKAlSC2NhcmRDb3VudHJ5Eh8KC2NhcmRfZm9ybWF0GCggASgJUgpjYXJkRm9ybWF0Eh0KCmJyYW5kX25hbWUYKSABKAlSCWJyYW5kTmFtZRInCg9vcmlnaW5hbF9hbW91bnQYKiABKAFSDm9yaWdpbmFsQW1vdW50EiMKDXJldGFpbF9hbW91bnQYKyABKAFSDHJldGFpbEFtb3VudBInCg9yZXRhaWxfY3VycmVuY3kYLCABKAlSDnJldGFpbEN1cnJlbmN5EikKEHdob2xlc2FsZV9hbW91bnQYLSABKAFSD3dob2xlc2FsZUFtb3VudBItChJ3aG9sZXNhbGVfY3VycmVuY3kYLiABKAlSEXdob2xlc2FsZUN1cnJlbmN5EjIKFWNvbW1pc3Npb25fYW1vdW50X2J1eRgvIAEoAVITY29tbWlzc2lvbkFtb3VudEJ1eRIvChNjb21taXNzaW9uX2N1cnJlbmN5GDAgASgJUhJjb21taXNzaW9uQ3VycmVuY3kSIwoNc2VuZGVyX2Ftb3VudBgxIAEoAVIMc2VuZGVyQW1vdW50EicKD3NlbmRlcl9jdXJyZW5jeRgyIAEoCVIOc2VuZGVyQ3VycmVuY3kSFwoHZnhfcmF0ZRgzIAEoAVIGZnhSYXRlEiUKDmZlZV9wZXJjZW50YWdlGDQgASgBUg1mZWVQZXJjZW50YWdlEicKD3JlZGVtcHRpb25fY29kZRg1IAEoCVIOcmVkZW1wdGlvbkNvZGUSJQoOcmVkZW1wdGlvbl9waW4YNiABKAlSDXJlZGVtcHRpb25QaW4SNgoXcHJvdmlkZXJfdHJhbnNhY3Rpb25faWQYNyABKAlSFXByb3ZpZGVyVHJhbnNhY3Rpb25JZBIhCgxjb21wbGV0ZWRfYXQYOCABKAlSC2NvbXBsZXRlZEF0EiEKDHJlcXVlc3RfanNvbhg5IAEoCVILcmVxdWVzdEpzb24SIwoNcmVzcG9uc2VfanNvbhg6IAEoCVIMcmVzcG9uc2VKc29uEjAKFHByb3ZpZGVyX2h0dHBfc3RhdHVzGDsgASgFUhJwcm92aWRlckh0dHBTdGF0dXMSMAoUcHJvdmlkZXJfZHVyYXRpb25fbXMYPCABKANSEnByb3ZpZGVyRHVyYXRpb25NcxIlCg5mYWlsdXJlX3JlYXNvbhg9IAEoCVINZmFpbHVyZVJlYXNvbhIlCg5xdW90ZV9wcm92aWRlchg+IAEoCVINcXVvdGVQcm92aWRlchIrChFzZXR0bGVtZW50X3N0YXR1cxg/IAEoCVIQc2V0dGxlbWVudFN0YXR1cxIlCg5kaXNwbGF5X3N0YXR1cxhAIAEoCVINZGlzcGxheVN0YXR1cxIhCgxlc2NhbGF0ZWRfYXQYQSABKAlSC2VzY2FsYXRlZEF0EisKEWVzY2FsYXRpb25fcmVhc29uGEIgASgJUhBlc2NhbGF0aW9uUmVhc29u');
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
    const {'1': 'mode', '3': 3, '4': 1, '5': 9, '10': 'mode'},
    const {'1': 'async_enabled', '3': 4, '4': 1, '5': 8, '10': 'asyncEnabled'},
  ],
};

/// Descriptor for `GetSellProviderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSellProviderResponseDescriptor = $convert.base64Decode('ChdHZXRTZWxsUHJvdmlkZXJSZXNwb25zZRIaCghwcm92aWRlchgBIAEoCVIIcHJvdmlkZXISIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEhIKBG1vZGUYAyABKAlSBG1vZGUSIwoNYXN5bmNfZW5hYmxlZBgEIAEoCFIMYXN5bmNFbmFibGVk');
@$core.Deprecated('Use updateFeatureFlagRequestDescriptor instead')
const UpdateFeatureFlagRequest$json = const {
  '1': 'UpdateFeatureFlagRequest',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `UpdateFeatureFlagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeatureFlagRequestDescriptor = $convert.base64Decode('ChhVcGRhdGVGZWF0dXJlRmxhZ1JlcXVlc3QSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29u');
@$core.Deprecated('Use updateFeatureFlagResponseDescriptor instead')
const UpdateFeatureFlagResponse$json = const {
  '1': 'UpdateFeatureFlagResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateFeatureFlagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFeatureFlagResponseDescriptor = $convert.base64Decode('ChlVcGRhdGVGZWF0dXJlRmxhZ1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getPayoutMethodsRequestDescriptor instead')
const GetPayoutMethodsRequest$json = const {
  '1': 'GetPayoutMethodsRequest',
};

/// Descriptor for `GetPayoutMethodsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutMethodsRequestDescriptor = $convert.base64Decode('ChdHZXRQYXlvdXRNZXRob2RzUmVxdWVzdA==');
@$core.Deprecated('Use payoutMethodDescriptor instead')
const PayoutMethod$json = const {
  '1': 'PayoutMethod',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'available', '3': 2, '4': 1, '5': 8, '10': 'available'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `PayoutMethod`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payoutMethodDescriptor = $convert.base64Decode('CgxQYXlvdXRNZXRob2QSEgoEbmFtZRgBIAEoCVIEbmFtZRIcCglhdmFpbGFibGUYAiABKAhSCWF2YWlsYWJsZRIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use getPayoutMethodsResponseDescriptor instead')
const GetPayoutMethodsResponse$json = const {
  '1': 'GetPayoutMethodsResponse',
  '2': const [
    const {'1': 'methods', '3': 1, '4': 3, '5': 11, '6': '.giftcards.PayoutMethod', '10': 'methods'},
  ],
};

/// Descriptor for `GetPayoutMethodsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayoutMethodsResponseDescriptor = $convert.base64Decode('ChhHZXRQYXlvdXRNZXRob2RzUmVzcG9uc2USMQoHbWV0aG9kcxgBIAMoCzIXLmdpZnRjYXJkcy5QYXlvdXRNZXRob2RSB21ldGhvZHM=');
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
    const {'1': 'ocr_confidence', '3': 20, '4': 1, '5': 1, '10': 'ocrConfidence'},
    const {'1': 'subcategory_id', '3': 21, '4': 1, '5': 9, '10': 'subcategoryId'},
    const {'1': 'form', '3': 22, '4': 1, '5': 9, '10': 'form'},
    const {'1': 'payout_method', '3': 23, '4': 1, '5': 9, '10': 'payoutMethod'},
    const {'1': 'card_code', '3': 24, '4': 1, '5': 9, '10': 'cardCode'},
    const {'1': 'disclaimer_accepted', '3': 25, '4': 1, '5': 8, '10': 'disclaimerAccepted'},
  ],
};

/// Descriptor for `SellGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardRequestDescriptor = $convert.base64Decode('ChNTZWxsR2lmdENhcmRSZXF1ZXN0EhsKCWNhcmRfdHlwZRgBIAEoCVIIY2FyZFR5cGUSHwoLY2FyZF9udW1iZXIYAiABKAlSCmNhcmROdW1iZXISGQoIY2FyZF9waW4YAyABKAlSB2NhcmRQaW4SIgoMZGVub21pbmF0aW9uGAQgASgBUgxkZW5vbWluYXRpb24SGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhYKBmltYWdlcxgGIAMoCVIGaW1hZ2VzEicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVuY3lLZXkSJQoOdHJhbnNhY3Rpb25faWQYCCABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAkgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIjCg1wcm92aWRlcl9uYW1lGAogASgJUgxwcm92aWRlck5hbWUSHQoKaW1hZ2VfdXJscxgLIAMoCVIJaW1hZ2VVcmxzEh0KCmltYWdlX2tleXMYDCADKAlSCWltYWdlS2V5cxIbCglvY3JfYnJhbmQYDSABKAlSCG9jckJyYW5kEiYKD29jcl9jYXJkX251bWJlchgOIAEoCVINb2NyQ2FyZE51bWJlchIXCgdvY3JfcGluGA8gASgJUgZvY3JQaW4SKQoQb2NyX2Rlbm9taW5hdGlvbhgQIAEoAVIPb2NyRGVub21pbmF0aW9uEiEKDG9jcl9jdXJyZW5jeRgRIAEoCVILb2NyQ3VycmVuY3kSIQoMY2FyZF9jb3VudHJ5GBIgASgJUgtjYXJkQ291bnRyeRIfCgtjYXJkX2Zvcm1hdBgTIAEoCVIKY2FyZEZvcm1hdBIlCg5vY3JfY29uZmlkZW5jZRgUIAEoAVINb2NyQ29uZmlkZW5jZRIlCg5zdWJjYXRlZ29yeV9pZBgVIAEoCVINc3ViY2F0ZWdvcnlJZBISCgRmb3JtGBYgASgJUgRmb3JtEiMKDXBheW91dF9tZXRob2QYFyABKAlSDHBheW91dE1ldGhvZBIbCgljYXJkX2NvZGUYGCABKAlSCGNhcmRDb2RlEi8KE2Rpc2NsYWltZXJfYWNjZXB0ZWQYGSABKAhSEmRpc2NsYWltZXJBY2NlcHRlZA==');
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
@$core.Deprecated('Use adminListSellSettlementsRequestDescriptor instead')
const AdminListSellSettlementsRequest$json = const {
  '1': 'AdminListSellSettlementsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'source', '3': 2, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListSellSettlementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellSettlementsRequestDescriptor = $convert.base64Decode('Ch9BZG1pbkxpc3RTZWxsU2V0dGxlbWVudHNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhYKBnNvdXJjZRgCIAEoCVIGc291cmNlEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');
@$core.Deprecated('Use adminSellSettlementDescriptor instead')
const AdminSellSettlement$json = const {
  '1': 'AdminSellSettlement',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'brand', '3': 4, '4': 1, '5': 9, '10': 'brand'},
    const {'1': 'face_value', '3': 5, '4': 1, '5': 1, '10': 'faceValue'},
    const {'1': 'face_currency', '3': 6, '4': 1, '5': 9, '10': 'faceCurrency'},
    const {'1': 'payout_currency', '3': 7, '4': 1, '5': 9, '10': 'payoutCurrency'},
    const {'1': 'fx_rate', '3': 8, '4': 1, '5': 1, '10': 'fxRate'},
    const {'1': 'pre_margin_payout', '3': 9, '4': 1, '5': 1, '10': 'preMarginPayout'},
    const {'1': 'paid_to_user', '3': 10, '4': 1, '5': 1, '10': 'paidToUser'},
    const {'1': 'sale_proceeds', '3': 11, '4': 1, '5': 1, '10': 'saleProceeds'},
    const {'1': 'sale_proceeds_currency', '3': 12, '4': 1, '5': 9, '10': 'saleProceedsCurrency'},
    const {'1': 'total_revenue', '3': 13, '4': 1, '5': 1, '10': 'totalRevenue'},
    const {'1': 'total_revenue_currency', '3': 14, '4': 1, '5': 9, '10': 'totalRevenueCurrency'},
    const {'1': 'margin_percentage', '3': 15, '4': 1, '5': 1, '10': 'marginPercentage'},
    const {'1': 'flat_fee', '3': 16, '4': 1, '5': 1, '10': 'flatFee'},
    const {'1': 'source', '3': 17, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'provider_name', '3': 19, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'paid_at', '3': 20, '4': 1, '5': 9, '10': 'paidAt'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `AdminSellSettlement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSellSettlementDescriptor = $convert.base64Decode('ChNBZG1pblNlbGxTZXR0bGVtZW50Eg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSFAoFYnJhbmQYBCABKAlSBWJyYW5kEh0KCmZhY2VfdmFsdWUYBSABKAFSCWZhY2VWYWx1ZRIjCg1mYWNlX2N1cnJlbmN5GAYgASgJUgxmYWNlQ3VycmVuY3kSJwoPcGF5b3V0X2N1cnJlbmN5GAcgASgJUg5wYXlvdXRDdXJyZW5jeRIXCgdmeF9yYXRlGAggASgBUgZmeFJhdGUSKgoRcHJlX21hcmdpbl9wYXlvdXQYCSABKAFSD3ByZU1hcmdpblBheW91dBIgCgxwYWlkX3RvX3VzZXIYCiABKAFSCnBhaWRUb1VzZXISIwoNc2FsZV9wcm9jZWVkcxgLIAEoAVIMc2FsZVByb2NlZWRzEjQKFnNhbGVfcHJvY2VlZHNfY3VycmVuY3kYDCABKAlSFHNhbGVQcm9jZWVkc0N1cnJlbmN5EiMKDXRvdGFsX3JldmVudWUYDSABKAFSDHRvdGFsUmV2ZW51ZRI0ChZ0b3RhbF9yZXZlbnVlX2N1cnJlbmN5GA4gASgJUhR0b3RhbFJldmVudWVDdXJyZW5jeRIrChFtYXJnaW5fcGVyY2VudGFnZRgPIAEoAVIQbWFyZ2luUGVyY2VudGFnZRIZCghmbGF0X2ZlZRgQIAEoAVIHZmxhdEZlZRIWCgZzb3VyY2UYESABKAlSBnNvdXJjZRIWCgZzdGF0dXMYEiABKAlSBnN0YXR1cxIjCg1wcm92aWRlcl9uYW1lGBMgASgJUgxwcm92aWRlck5hbWUSFwoHcGFpZF9hdBgUIAEoCVIGcGFpZEF0Eh0KCmNyZWF0ZWRfYXQYFSABKAlSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use adminListSellSettlementsResponseDescriptor instead')
const AdminListSellSettlementsResponse$json = const {
  '1': 'AdminListSellSettlementsResponse',
  '2': const [
    const {'1': 'settlements', '3': 1, '4': 3, '5': 11, '6': '.giftcards.AdminSellSettlement', '10': 'settlements'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListSellSettlementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListSellSettlementsResponseDescriptor = $convert.base64Decode('CiBBZG1pbkxpc3RTZWxsU2V0dGxlbWVudHNSZXNwb25zZRJACgtzZXR0bGVtZW50cxgBIAMoCzIeLmdpZnRjYXJkcy5BZG1pblNlbGxTZXR0bGVtZW50UgtzZXR0bGVtZW50cxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use adminListBuyTransactionsRequestDescriptor instead')
const AdminListBuyTransactionsRequest$json = const {
  '1': 'AdminListBuyTransactionsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'search', '3': 2, '4': 1, '5': 9, '10': 'search'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListBuyTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListBuyTransactionsRequestDescriptor = $convert.base64Decode('Ch9BZG1pbkxpc3RCdXlUcmFuc2FjdGlvbnNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhYKBnNlYXJjaBgCIAEoCVIGc2VhcmNoEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');
@$core.Deprecated('Use adminBuyTransactionDescriptor instead')
const AdminBuyTransaction$json = const {
  '1': 'AdminBuyTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'brand_name', '3': 3, '4': 1, '5': 9, '10': 'brandName'},
    const {'1': 'original_amount', '3': 4, '4': 1, '5': 1, '10': 'originalAmount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 9, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'recipient_email', '3': 10, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 11, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'reference', '3': 12, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'retail_amount', '3': 13, '4': 1, '5': 1, '10': 'retailAmount'},
    const {'1': 'retail_currency', '3': 14, '4': 1, '5': 9, '10': 'retailCurrency'},
    const {'1': 'wholesale_amount', '3': 15, '4': 1, '5': 1, '10': 'wholesaleAmount'},
    const {'1': 'wholesale_currency', '3': 16, '4': 1, '5': 9, '10': 'wholesaleCurrency'},
    const {'1': 'commission_amount', '3': 17, '4': 1, '5': 1, '10': 'commissionAmount'},
    const {'1': 'commission_currency', '3': 18, '4': 1, '5': 9, '10': 'commissionCurrency'},
    const {'1': 'sender_amount', '3': 19, '4': 1, '5': 1, '10': 'senderAmount'},
    const {'1': 'sender_currency', '3': 20, '4': 1, '5': 9, '10': 'senderCurrency'},
    const {'1': 'fx_rate', '3': 21, '4': 1, '5': 1, '10': 'fxRate'},
    const {'1': 'fee_percentage', '3': 22, '4': 1, '5': 1, '10': 'feePercentage'},
    const {'1': 'completed_at', '3': 23, '4': 1, '5': 9, '10': 'completedAt'},
    const {'1': 'provider_name', '3': 24, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'failure_reason', '3': 25, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'redemption_code', '3': 26, '4': 1, '5': 9, '10': 'redemptionCode'},
    const {'1': 'redemption_pin', '3': 27, '4': 1, '5': 9, '10': 'redemptionPin'},
    const {'1': 'provider_transaction_id', '3': 28, '4': 1, '5': 9, '10': 'providerTransactionId'},
    const {'1': 'mode', '3': 29, '4': 1, '5': 9, '10': 'mode'},
    const {'1': 'has_refund_entry', '3': 30, '4': 1, '5': 8, '10': 'hasRefundEntry'},
    const {'1': 'flat_fee', '3': 41, '4': 1, '5': 1, '10': 'flatFee'},
    const {'1': 'refund_state', '3': 35, '4': 1, '5': 9, '10': 'refundState'},
    const {'1': 'refund_source', '3': 36, '4': 1, '5': 9, '10': 'refundSource'},
    const {'1': 'refund_reason', '3': 37, '4': 1, '5': 9, '10': 'refundReason'},
    const {'1': 'final_gateway', '3': 38, '4': 1, '5': 9, '10': 'finalGateway'},
    const {'1': 'source', '3': 39, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'failover', '3': 40, '4': 1, '5': 9, '10': 'failover'},
    const {'1': 'request_json', '3': 31, '4': 1, '5': 9, '10': 'requestJson'},
    const {'1': 'response_json', '3': 32, '4': 1, '5': 9, '10': 'responseJson'},
    const {'1': 'provider_http_status', '3': 33, '4': 1, '5': 5, '10': 'providerHttpStatus'},
    const {'1': 'provider_duration_ms', '3': 34, '4': 1, '5': 3, '10': 'providerDurationMs'},
  ],
};

/// Descriptor for `AdminBuyTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminBuyTransactionDescriptor = $convert.base64Decode('ChNBZG1pbkJ1eVRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYnJhbmRfbmFtZRgDIAEoCVIJYnJhbmROYW1lEicKD29yaWdpbmFsX2Ftb3VudBgEIAEoAVIOb3JpZ2luYWxBbW91bnQSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgGIAEoCVIGc3RhdHVzEicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVuY3lLZXkSHQoKY3JlYXRlZF9hdBgIIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYCSABKAlSCXVwZGF0ZWRBdBInCg9yZWNpcGllbnRfZW1haWwYCiABKAlSDnJlY2lwaWVudEVtYWlsEiUKDnJlY2lwaWVudF9uYW1lGAsgASgJUg1yZWNpcGllbnROYW1lEhwKCXJlZmVyZW5jZRgMIAEoCVIJcmVmZXJlbmNlEiMKDXJldGFpbF9hbW91bnQYDSABKAFSDHJldGFpbEFtb3VudBInCg9yZXRhaWxfY3VycmVuY3kYDiABKAlSDnJldGFpbEN1cnJlbmN5EikKEHdob2xlc2FsZV9hbW91bnQYDyABKAFSD3dob2xlc2FsZUFtb3VudBItChJ3aG9sZXNhbGVfY3VycmVuY3kYECABKAlSEXdob2xlc2FsZUN1cnJlbmN5EisKEWNvbW1pc3Npb25fYW1vdW50GBEgASgBUhBjb21taXNzaW9uQW1vdW50Ei8KE2NvbW1pc3Npb25fY3VycmVuY3kYEiABKAlSEmNvbW1pc3Npb25DdXJyZW5jeRIjCg1zZW5kZXJfYW1vdW50GBMgASgBUgxzZW5kZXJBbW91bnQSJwoPc2VuZGVyX2N1cnJlbmN5GBQgASgJUg5zZW5kZXJDdXJyZW5jeRIXCgdmeF9yYXRlGBUgASgBUgZmeFJhdGUSJQoOZmVlX3BlcmNlbnRhZ2UYFiABKAFSDWZlZVBlcmNlbnRhZ2USIQoMY29tcGxldGVkX2F0GBcgASgJUgtjb21wbGV0ZWRBdBIjCg1wcm92aWRlcl9uYW1lGBggASgJUgxwcm92aWRlck5hbWUSJQoOZmFpbHVyZV9yZWFzb24YGSABKAlSDWZhaWx1cmVSZWFzb24SJwoPcmVkZW1wdGlvbl9jb2RlGBogASgJUg5yZWRlbXB0aW9uQ29kZRIlCg5yZWRlbXB0aW9uX3BpbhgbIAEoCVINcmVkZW1wdGlvblBpbhI2Chdwcm92aWRlcl90cmFuc2FjdGlvbl9pZBgcIAEoCVIVcHJvdmlkZXJUcmFuc2FjdGlvbklkEhIKBG1vZGUYHSABKAlSBG1vZGUSKAoQaGFzX3JlZnVuZF9lbnRyeRgeIAEoCFIOaGFzUmVmdW5kRW50cnkSGQoIZmxhdF9mZWUYKSABKAFSB2ZsYXRGZWUSIQoMcmVmdW5kX3N0YXRlGCMgASgJUgtyZWZ1bmRTdGF0ZRIjCg1yZWZ1bmRfc291cmNlGCQgASgJUgxyZWZ1bmRTb3VyY2USIwoNcmVmdW5kX3JlYXNvbhglIAEoCVIMcmVmdW5kUmVhc29uEiMKDWZpbmFsX2dhdGV3YXkYJiABKAlSDGZpbmFsR2F0ZXdheRIWCgZzb3VyY2UYJyABKAlSBnNvdXJjZRIaCghmYWlsb3ZlchgoIAEoCVIIZmFpbG92ZXISIQoMcmVxdWVzdF9qc29uGB8gASgJUgtyZXF1ZXN0SnNvbhIjCg1yZXNwb25zZV9qc29uGCAgASgJUgxyZXNwb25zZUpzb24SMAoUcHJvdmlkZXJfaHR0cF9zdGF0dXMYISABKAVSEnByb3ZpZGVySHR0cFN0YXR1cxIwChRwcm92aWRlcl9kdXJhdGlvbl9tcxgiIAEoA1IScHJvdmlkZXJEdXJhdGlvbk1z');
@$core.Deprecated('Use adminListBuyTransactionsResponseDescriptor instead')
const AdminListBuyTransactionsResponse$json = const {
  '1': 'AdminListBuyTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.giftcards.AdminBuyTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListBuyTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListBuyTransactionsResponseDescriptor = $convert.base64Decode('CiBBZG1pbkxpc3RCdXlUcmFuc2FjdGlvbnNSZXNwb25zZRJCCgx0cmFuc2FjdGlvbnMYASADKAsyHi5naWZ0Y2FyZHMuQWRtaW5CdXlUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');
@$core.Deprecated('Use adminListRefundLedgerRequestDescriptor instead')
const AdminListRefundLedgerRequest$json = const {
  '1': 'AdminListRefundLedgerRequest',
  '2': const [
    const {'1': 'side', '3': 1, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListRefundLedgerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListRefundLedgerRequestDescriptor = $convert.base64Decode('ChxBZG1pbkxpc3RSZWZ1bmRMZWRnZXJSZXF1ZXN0EhIKBHNpZGUYASABKAlSBHNpZGUSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use adminRefundLedgerEntryDescriptor instead')
const AdminRefundLedgerEntry$json = const {
  '1': 'AdminRefundLedgerEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'original_reference', '3': 2, '4': 1, '5': 9, '10': 'originalReference'},
    const {'1': 'refund_reference', '3': 3, '4': 1, '5': 9, '10': 'refundReference'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 5, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'direction', '3': 8, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'reason', '3': 9, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'confirmation_status', '3': 10, '4': 1, '5': 9, '10': 'confirmationStatus'},
    const {'1': 'settlement_status', '3': 11, '4': 1, '5': 9, '10': 'settlementStatus'},
    const {'1': 'provider_transaction_id', '3': 12, '4': 1, '5': 9, '10': 'providerTransactionId'},
    const {'1': 'provider_status', '3': 13, '4': 1, '5': 9, '10': 'providerStatus'},
    const {'1': 'notes', '3': 14, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'executed_at', '3': 15, '4': 1, '5': 9, '10': 'executedAt'},
    const {'1': 'confirmed_at', '3': 16, '4': 1, '5': 9, '10': 'confirmedAt'},
    const {'1': 'escalated_at', '3': 17, '4': 1, '5': 9, '10': 'escalatedAt'},
    const {'1': 'verification_attempts', '3': 18, '4': 1, '5': 5, '10': 'verificationAttempts'},
    const {'1': 'max_verification_retries', '3': 19, '4': 1, '5': 5, '10': 'maxVerificationRetries'},
    const {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'side', '3': 22, '4': 1, '5': 9, '10': 'side'},
    const {'1': 'source', '3': 23, '4': 1, '5': 9, '10': 'source'},
  ],
};

/// Descriptor for `AdminRefundLedgerEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRefundLedgerEntryDescriptor = $convert.base64Decode('ChZBZG1pblJlZnVuZExlZGdlckVudHJ5Eg4KAmlkGAEgASgJUgJpZBItChJvcmlnaW5hbF9yZWZlcmVuY2UYAiABKAlSEW9yaWdpbmFsUmVmZXJlbmNlEikKEHJlZnVuZF9yZWZlcmVuY2UYAyABKAlSD3JlZnVuZFJlZmVyZW5jZRIXCgd1c2VyX2lkGAQgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgFIAEoCVIJYWNjb3VudElkEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIcCglkaXJlY3Rpb24YCCABKAlSCWRpcmVjdGlvbhIWCgZyZWFzb24YCSABKAlSBnJlYXNvbhIvChNjb25maXJtYXRpb25fc3RhdHVzGAogASgJUhJjb25maXJtYXRpb25TdGF0dXMSKwoRc2V0dGxlbWVudF9zdGF0dXMYCyABKAlSEHNldHRsZW1lbnRTdGF0dXMSNgoXcHJvdmlkZXJfdHJhbnNhY3Rpb25faWQYDCABKAlSFXByb3ZpZGVyVHJhbnNhY3Rpb25JZBInCg9wcm92aWRlcl9zdGF0dXMYDSABKAlSDnByb3ZpZGVyU3RhdHVzEhQKBW5vdGVzGA4gASgJUgVub3RlcxIfCgtleGVjdXRlZF9hdBgPIAEoCVIKZXhlY3V0ZWRBdBIhCgxjb25maXJtZWRfYXQYECABKAlSC2NvbmZpcm1lZEF0EiEKDGVzY2FsYXRlZF9hdBgRIAEoCVILZXNjYWxhdGVkQXQSMwoVdmVyaWZpY2F0aW9uX2F0dGVtcHRzGBIgASgFUhR2ZXJpZmljYXRpb25BdHRlbXB0cxI4ChhtYXhfdmVyaWZpY2F0aW9uX3JldHJpZXMYEyABKAVSFm1heFZlcmlmaWNhdGlvblJldHJpZXMSHQoKY3JlYXRlZF9hdBgUIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFSABKAlSCXVwZGF0ZWRBdBISCgRzaWRlGBYgASgJUgRzaWRlEhYKBnNvdXJjZRgXIAEoCVIGc291cmNl');
@$core.Deprecated('Use adminListRefundLedgerResponseDescriptor instead')
const AdminListRefundLedgerResponse$json = const {
  '1': 'AdminListRefundLedgerResponse',
  '2': const [
    const {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.giftcards.AdminRefundLedgerEntry', '10': 'entries'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `AdminListRefundLedgerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminListRefundLedgerResponseDescriptor = $convert.base64Decode('Ch1BZG1pbkxpc3RSZWZ1bmRMZWRnZXJSZXNwb25zZRI7CgdlbnRyaWVzGAEgAygLMiEuZ2lmdGNhcmRzLkFkbWluUmVmdW5kTGVkZ2VyRW50cnlSB2VudHJpZXMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');
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
@$core.Deprecated('Use adminProcessPayoutRequestDescriptor instead')
const AdminProcessPayoutRequest$json = const {
  '1': 'AdminProcessPayoutRequest',
  '2': const [
    const {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
  ],
};

/// Descriptor for `AdminProcessPayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminProcessPayoutRequestDescriptor = $convert.base64Decode('ChlBZG1pblByb2Nlc3NQYXlvdXRSZXF1ZXN0EhcKB3NhbGVfaWQYASABKAlSBnNhbGVJZA==');
@$core.Deprecated('Use adminProcessPayoutResponseDescriptor instead')
const AdminProcessPayoutResponse$json = const {
  '1': 'AdminProcessPayoutResponse',
  '2': const [
    const {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminProcessPayoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminProcessPayoutResponseDescriptor = $convert.base64Decode('ChpBZG1pblByb2Nlc3NQYXlvdXRSZXNwb25zZRIrCgRzYWxlGAEgASgLMhcuZ2lmdGNhcmRzLkdpZnRDYXJkU2FsZVIEc2FsZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
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
@$core.Deprecated('Use adminRetryHoldReleaseRequestDescriptor instead')
const AdminRetryHoldReleaseRequest$json = const {
  '1': 'AdminRetryHoldReleaseRequest',
  '2': const [
    const {'1': 'card_id', '3': 1, '4': 1, '5': 9, '10': 'cardId'},
    const {'1': 'admin_id', '3': 2, '4': 1, '5': 9, '10': 'adminId'},
  ],
};

/// Descriptor for `AdminRetryHoldReleaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRetryHoldReleaseRequestDescriptor = $convert.base64Decode('ChxBZG1pblJldHJ5SG9sZFJlbGVhc2VSZXF1ZXN0EhcKB2NhcmRfaWQYASABKAlSBmNhcmRJZBIZCghhZG1pbl9pZBgCIAEoCVIHYWRtaW5JZA==');
@$core.Deprecated('Use adminRetryHoldReleaseResponseDescriptor instead')
const AdminRetryHoldReleaseResponse$json = const {
  '1': 'AdminRetryHoldReleaseResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `AdminRetryHoldReleaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminRetryHoldReleaseResponseDescriptor = $convert.base64Decode('Ch1BZG1pblJldHJ5SG9sZFJlbGVhc2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEiMKDWVycm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZQ==');
@$core.Deprecated('Use adminManualRefundPurchaseRequestDescriptor instead')
const AdminManualRefundPurchaseRequest$json = const {
  '1': 'AdminManualRefundPurchaseRequest',
  '2': const [
    const {'1': 'card_id', '3': 1, '4': 1, '5': 9, '10': 'cardId'},
    const {'1': 'admin_id', '3': 2, '4': 1, '5': 9, '10': 'adminId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'notes', '3': 4, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `AdminManualRefundPurchaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminManualRefundPurchaseRequestDescriptor = $convert.base64Decode('CiBBZG1pbk1hbnVhbFJlZnVuZFB1cmNoYXNlUmVxdWVzdBIXCgdjYXJkX2lkGAEgASgJUgZjYXJkSWQSGQoIYWRtaW5faWQYAiABKAlSB2FkbWluSWQSFgoGcmVhc29uGAMgASgJUgZyZWFzb24SFAoFbm90ZXMYBCABKAlSBW5vdGVz');
@$core.Deprecated('Use adminManualRefundPurchaseResponseDescriptor instead')
const AdminManualRefundPurchaseResponse$json = const {
  '1': 'AdminManualRefundPurchaseResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminManualRefundPurchaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminManualRefundPurchaseResponseDescriptor = $convert.base64Decode('CiFBZG1pbk1hbnVhbFJlZnVuZFB1cmNoYXNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use adminForceReconcilePurchaseRequestDescriptor instead')
const AdminForceReconcilePurchaseRequest$json = const {
  '1': 'AdminForceReconcilePurchaseRequest',
  '2': const [
    const {'1': 'card_id', '3': 1, '4': 1, '5': 9, '10': 'cardId'},
    const {'1': 'admin_id', '3': 2, '4': 1, '5': 9, '10': 'adminId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdminForceReconcilePurchaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceReconcilePurchaseRequestDescriptor = $convert.base64Decode('CiJBZG1pbkZvcmNlUmVjb25jaWxlUHVyY2hhc2VSZXF1ZXN0EhcKB2NhcmRfaWQYASABKAlSBmNhcmRJZBIZCghhZG1pbl9pZBgCIAEoCVIHYWRtaW5JZBIWCgZyZWFzb24YAyABKAlSBnJlYXNvbg==');
@$core.Deprecated('Use adminForceReconcilePurchaseResponseDescriptor instead')
const AdminForceReconcilePurchaseResponse$json = const {
  '1': 'AdminForceReconcilePurchaseResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminForceReconcilePurchaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminForceReconcilePurchaseResponseDescriptor = $convert.base64Decode('CiNBZG1pbkZvcmNlUmVjb25jaWxlUHVyY2hhc2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhYKBmFjdGlvbhgCIAEoCVIGYWN0aW9uEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use adminSetSellPayoutOverrideRequestDescriptor instead')
const AdminSetSellPayoutOverrideRequest$json = const {
  '1': 'AdminSetSellPayoutOverrideRequest',
  '2': const [
    const {'1': 'sale_id', '3': 1, '4': 1, '5': 9, '10': 'saleId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'note', '3': 4, '4': 1, '5': 9, '10': 'note'},
    const {'1': 'admin_id', '3': 5, '4': 1, '5': 9, '10': 'adminId'},
  ],
};

/// Descriptor for `AdminSetSellPayoutOverrideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetSellPayoutOverrideRequestDescriptor = $convert.base64Decode('CiFBZG1pblNldFNlbGxQYXlvdXRPdmVycmlkZVJlcXVlc3QSFwoHc2FsZV9pZBgBIAEoCVIGc2FsZUlkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRISCgRub3RlGAQgASgJUgRub3RlEhkKCGFkbWluX2lkGAUgASgJUgdhZG1pbklk');
@$core.Deprecated('Use adminSetSellPayoutOverrideResponseDescriptor instead')
const AdminSetSellPayoutOverrideResponse$json = const {
  '1': 'AdminSetSellPayoutOverrideResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'override_amount', '3': 2, '4': 1, '5': 1, '10': 'overrideAmount'},
    const {'1': 'override_currency', '3': 3, '4': 1, '5': 9, '10': 'overrideCurrency'},
    const {'1': 'resolved_ngn', '3': 4, '4': 1, '5': 1, '10': 'resolvedNgn'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AdminSetSellPayoutOverrideResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetSellPayoutOverrideResponseDescriptor = $convert.base64Decode('CiJBZG1pblNldFNlbGxQYXlvdXRPdmVycmlkZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSJwoPb3ZlcnJpZGVfYW1vdW50GAIgASgBUg5vdmVycmlkZUFtb3VudBIrChFvdmVycmlkZV9jdXJyZW5jeRgDIAEoCVIQb3ZlcnJpZGVDdXJyZW5jeRIhCgxyZXNvbHZlZF9uZ24YBCABKAFSC3Jlc29sdmVkTmduEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');
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
@$core.Deprecated('Use getGiftCardsAnalyticsRequestDescriptor instead')
const GetGiftCardsAnalyticsRequest$json = const {
  '1': 'GetGiftCardsAnalyticsRequest',
  '2': const [
    const {'1': 'time_range', '3': 1, '4': 1, '5': 9, '10': 'timeRange'},
    const {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `GetGiftCardsAnalyticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardsAnalyticsRequestDescriptor = $convert.base64Decode('ChxHZXRHaWZ0Q2FyZHNBbmFseXRpY3NSZXF1ZXN0Eh0KCnRpbWVfcmFuZ2UYASABKAlSCXRpbWVSYW5nZRIaCghwcm92aWRlchgCIAEoCVIIcHJvdmlkZXI=');
@$core.Deprecated('Use revenuePointDescriptor instead')
const RevenuePoint$json = const {
  '1': 'RevenuePoint',
  '2': const [
    const {'1': 'date', '3': 1, '4': 1, '5': 9, '10': 'date'},
    const {'1': 'revenue', '3': 2, '4': 1, '5': 1, '10': 'revenue'},
    const {'1': 'payouts', '3': 3, '4': 1, '5': 1, '10': 'payouts'},
  ],
};

/// Descriptor for `RevenuePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revenuePointDescriptor = $convert.base64Decode('CgxSZXZlbnVlUG9pbnQSEgoEZGF0ZRgBIAEoCVIEZGF0ZRIYCgdyZXZlbnVlGAIgASgBUgdyZXZlbnVlEhgKB3BheW91dHMYAyABKAFSB3BheW91dHM=');
@$core.Deprecated('Use providerSliceDescriptor instead')
const ProviderSlice$json = const {
  '1': 'ProviderSlice',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'sales', '3': 2, '4': 1, '5': 3, '10': 'sales'},
    const {'1': 'revenue', '3': 3, '4': 1, '5': 1, '10': 'revenue'},
  ],
};

/// Descriptor for `ProviderSlice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerSliceDescriptor = $convert.base64Decode('Cg1Qcm92aWRlclNsaWNlEhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIUCgVzYWxlcxgCIAEoA1IFc2FsZXMSGAoHcmV2ZW51ZRgDIAEoAVIHcmV2ZW51ZQ==');
@$core.Deprecated('Use topCardTypeDescriptor instead')
const TopCardType$json = const {
  '1': 'TopCardType',
  '2': const [
    const {'1': 'card_type', '3': 1, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'sales', '3': 2, '4': 1, '5': 3, '10': 'sales'},
    const {'1': 'revenue', '3': 3, '4': 1, '5': 1, '10': 'revenue'},
  ],
};

/// Descriptor for `TopCardType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topCardTypeDescriptor = $convert.base64Decode('CgtUb3BDYXJkVHlwZRIbCgljYXJkX3R5cGUYASABKAlSCGNhcmRUeXBlEhQKBXNhbGVzGAIgASgDUgVzYWxlcxIYCgdyZXZlbnVlGAMgASgBUgdyZXZlbnVl');
@$core.Deprecated('Use settlementSliceDescriptor instead')
const SettlementSlice$json = const {
  '1': 'SettlementSlice',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'count', '3': 2, '4': 1, '5': 3, '10': 'count'},
  ],
};

/// Descriptor for `SettlementSlice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settlementSliceDescriptor = $convert.base64Decode('Cg9TZXR0bGVtZW50U2xpY2USFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSFAoFY291bnQYAiABKANSBWNvdW50');
@$core.Deprecated('Use providerPerformanceDescriptor instead')
const ProviderPerformance$json = const {
  '1': 'ProviderPerformance',
  '2': const [
    const {'1': 'provider', '3': 1, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'success_rate', '3': 2, '4': 1, '5': 1, '10': 'successRate'},
    const {'1': 'average_latency_ms', '3': 3, '4': 1, '5': 1, '10': 'averageLatencyMs'},
    const {'1': 'errors', '3': 4, '4': 1, '5': 3, '10': 'errors'},
  ],
};

/// Descriptor for `ProviderPerformance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerPerformanceDescriptor = $convert.base64Decode('ChNQcm92aWRlclBlcmZvcm1hbmNlEhoKCHByb3ZpZGVyGAEgASgJUghwcm92aWRlchIhCgxzdWNjZXNzX3JhdGUYAiABKAFSC3N1Y2Nlc3NSYXRlEiwKEmF2ZXJhZ2VfbGF0ZW5jeV9tcxgDIAEoAVIQYXZlcmFnZUxhdGVuY3lNcxIWCgZlcnJvcnMYBCABKANSBmVycm9ycw==');
@$core.Deprecated('Use getGiftCardsAnalyticsResponseDescriptor instead')
const GetGiftCardsAnalyticsResponse$json = const {
  '1': 'GetGiftCardsAnalyticsResponse',
  '2': const [
    const {'1': 'total_revenue', '3': 1, '4': 1, '5': 1, '10': 'totalRevenue'},
    const {'1': 'total_payouts', '3': 2, '4': 1, '5': 1, '10': 'totalPayouts'},
    const {'1': 'gross_profit', '3': 3, '4': 1, '5': 1, '10': 'grossProfit'},
    const {'1': 'profit_margin', '3': 4, '4': 1, '5': 1, '10': 'profitMargin'},
    const {'1': 'total_sales', '3': 5, '4': 1, '5': 3, '10': 'totalSales'},
    const {'1': 'approval_rate', '3': 6, '4': 1, '5': 1, '10': 'approvalRate'},
    const {'1': 'revenue_change_percent', '3': 7, '4': 1, '5': 1, '10': 'revenueChangePercent'},
    const {'1': 'payouts_change_percent', '3': 8, '4': 1, '5': 1, '10': 'payoutsChangePercent'},
    const {'1': 'profit_change_percent', '3': 9, '4': 1, '5': 1, '10': 'profitChangePercent'},
    const {'1': 'sales_change_percent', '3': 10, '4': 1, '5': 1, '10': 'salesChangePercent'},
    const {'1': 'revenue_over_time', '3': 11, '4': 3, '5': 11, '6': '.giftcards.RevenuePoint', '10': 'revenueOverTime'},
    const {'1': 'sales_by_provider', '3': 12, '4': 3, '5': 11, '6': '.giftcards.ProviderSlice', '10': 'salesByProvider'},
    const {'1': 'top_card_types', '3': 13, '4': 3, '5': 11, '6': '.giftcards.TopCardType', '10': 'topCardTypes'},
    const {'1': 'settlement_status', '3': 14, '4': 3, '5': 11, '6': '.giftcards.SettlementSlice', '10': 'settlementStatus'},
    const {'1': 'provider_performance', '3': 15, '4': 3, '5': 11, '6': '.giftcards.ProviderPerformance', '10': 'providerPerformance'},
  ],
};

/// Descriptor for `GetGiftCardsAnalyticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardsAnalyticsResponseDescriptor = $convert.base64Decode('Ch1HZXRHaWZ0Q2FyZHNBbmFseXRpY3NSZXNwb25zZRIjCg10b3RhbF9yZXZlbnVlGAEgASgBUgx0b3RhbFJldmVudWUSIwoNdG90YWxfcGF5b3V0cxgCIAEoAVIMdG90YWxQYXlvdXRzEiEKDGdyb3NzX3Byb2ZpdBgDIAEoAVILZ3Jvc3NQcm9maXQSIwoNcHJvZml0X21hcmdpbhgEIAEoAVIMcHJvZml0TWFyZ2luEh8KC3RvdGFsX3NhbGVzGAUgASgDUgp0b3RhbFNhbGVzEiMKDWFwcHJvdmFsX3JhdGUYBiABKAFSDGFwcHJvdmFsUmF0ZRI0ChZyZXZlbnVlX2NoYW5nZV9wZXJjZW50GAcgASgBUhRyZXZlbnVlQ2hhbmdlUGVyY2VudBI0ChZwYXlvdXRzX2NoYW5nZV9wZXJjZW50GAggASgBUhRwYXlvdXRzQ2hhbmdlUGVyY2VudBIyChVwcm9maXRfY2hhbmdlX3BlcmNlbnQYCSABKAFSE3Byb2ZpdENoYW5nZVBlcmNlbnQSMAoUc2FsZXNfY2hhbmdlX3BlcmNlbnQYCiABKAFSEnNhbGVzQ2hhbmdlUGVyY2VudBJDChFyZXZlbnVlX292ZXJfdGltZRgLIAMoCzIXLmdpZnRjYXJkcy5SZXZlbnVlUG9pbnRSD3JldmVudWVPdmVyVGltZRJEChFzYWxlc19ieV9wcm92aWRlchgMIAMoCzIYLmdpZnRjYXJkcy5Qcm92aWRlclNsaWNlUg9zYWxlc0J5UHJvdmlkZXISPAoOdG9wX2NhcmRfdHlwZXMYDSADKAsyFi5naWZ0Y2FyZHMuVG9wQ2FyZFR5cGVSDHRvcENhcmRUeXBlcxJHChFzZXR0bGVtZW50X3N0YXR1cxgOIAMoCzIaLmdpZnRjYXJkcy5TZXR0bGVtZW50U2xpY2VSEHNldHRsZW1lbnRTdGF0dXMSUQoUcHJvdmlkZXJfcGVyZm9ybWFuY2UYDyADKAsyHi5naWZ0Y2FyZHMuUHJvdmlkZXJQZXJmb3JtYW5jZVITcHJvdmlkZXJQZXJmb3JtYW5jZQ==');
@$core.Deprecated('Use reconciliationRunDescriptor instead')
const ReconciliationRun$json = const {
  '1': 'ReconciliationRun',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 9, '10': 'timestamp'},
    const {'1': 'items_processed', '3': 5, '4': 1, '5': 3, '10': 'itemsProcessed'},
    const {'1': 'resolved', '3': 6, '4': 1, '5': 3, '10': 'resolved'},
    const {'1': 'escalated', '3': 7, '4': 1, '5': 3, '10': 'escalated'},
    const {'1': 'duration', '3': 8, '4': 1, '5': 9, '10': 'duration'},
  ],
};

/// Descriptor for `ReconciliationRun`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reconciliationRunDescriptor = $convert.base64Decode('ChFSZWNvbmNpbGlhdGlvblJ1bhIOCgJpZBgBIAEoCVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIcCgl0aW1lc3RhbXAYBCABKAlSCXRpbWVzdGFtcBInCg9pdGVtc19wcm9jZXNzZWQYBSABKANSDml0ZW1zUHJvY2Vzc2VkEhoKCHJlc29sdmVkGAYgASgDUghyZXNvbHZlZBIcCgllc2NhbGF0ZWQYByABKANSCWVzY2FsYXRlZBIaCghkdXJhdGlvbhgIIAEoCVIIZHVyYXRpb24=');
@$core.Deprecated('Use getReconciliationOverviewRequestDescriptor instead')
const GetReconciliationOverviewRequest$json = const {
  '1': 'GetReconciliationOverviewRequest',
};

/// Descriptor for `GetReconciliationOverviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationOverviewRequestDescriptor = $convert.base64Decode('CiBHZXRSZWNvbmNpbGlhdGlvbk92ZXJ2aWV3UmVxdWVzdA==');
@$core.Deprecated('Use getReconciliationOverviewResponseDescriptor instead')
const GetReconciliationOverviewResponse$json = const {
  '1': 'GetReconciliationOverviewResponse',
  '2': const [
    const {'1': 'orphaned_transactions', '3': 1, '4': 1, '5': 3, '10': 'orphanedTransactions'},
    const {'1': 'pending_verification', '3': 2, '4': 1, '5': 3, '10': 'pendingVerification'},
    const {'1': 'escalated_items', '3': 3, '4': 1, '5': 3, '10': 'escalatedItems'},
    const {'1': 'resolved_today', '3': 4, '4': 1, '5': 3, '10': 'resolvedToday'},
    const {'1': 'float_variance', '3': 5, '4': 1, '5': 1, '10': 'floatVariance'},
    const {'1': 'float_variance_critical', '3': 6, '4': 1, '5': 8, '10': 'floatVarianceCritical'},
    const {'1': 'last_reconciliation', '3': 7, '4': 1, '5': 11, '6': '.giftcards.ReconciliationRun', '10': 'lastReconciliation'},
  ],
};

/// Descriptor for `GetReconciliationOverviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationOverviewResponseDescriptor = $convert.base64Decode('CiFHZXRSZWNvbmNpbGlhdGlvbk92ZXJ2aWV3UmVzcG9uc2USMwoVb3JwaGFuZWRfdHJhbnNhY3Rpb25zGAEgASgDUhRvcnBoYW5lZFRyYW5zYWN0aW9ucxIxChRwZW5kaW5nX3ZlcmlmaWNhdGlvbhgCIAEoA1ITcGVuZGluZ1ZlcmlmaWNhdGlvbhInCg9lc2NhbGF0ZWRfaXRlbXMYAyABKANSDmVzY2FsYXRlZEl0ZW1zEiUKDnJlc29sdmVkX3RvZGF5GAQgASgDUg1yZXNvbHZlZFRvZGF5EiUKDmZsb2F0X3ZhcmlhbmNlGAUgASgBUg1mbG9hdFZhcmlhbmNlEjYKF2Zsb2F0X3ZhcmlhbmNlX2NyaXRpY2FsGAYgASgIUhVmbG9hdFZhcmlhbmNlQ3JpdGljYWwSTQoTbGFzdF9yZWNvbmNpbGlhdGlvbhgHIAEoCzIcLmdpZnRjYXJkcy5SZWNvbmNpbGlhdGlvblJ1blISbGFzdFJlY29uY2lsaWF0aW9u');
@$core.Deprecated('Use orphanedTransactionDescriptor instead')
const OrphanedTransaction$json = const {
  '1': 'OrphanedTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'issue', '3': 5, '4': 1, '5': 9, '10': 'issue'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `OrphanedTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orphanedTransactionDescriptor = $convert.base64Decode('ChNPcnBoYW5lZFRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBISCgR0eXBlGAIgASgJUgR0eXBlEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhQKBWlzc3VlGAUgASgJUgVpc3N1ZRIdCgpjcmVhdGVkX2F0GAYgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use getOrphanedTransactionsRequestDescriptor instead')
const GetOrphanedTransactionsRequest$json = const {
  '1': 'GetOrphanedTransactionsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetOrphanedTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrphanedTransactionsRequestDescriptor = $convert.base64Decode('Ch5HZXRPcnBoYW5lZFRyYW5zYWN0aW9uc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getOrphanedTransactionsResponseDescriptor instead')
const GetOrphanedTransactionsResponse$json = const {
  '1': 'GetOrphanedTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.giftcards.OrphanedTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetOrphanedTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrphanedTransactionsResponseDescriptor = $convert.base64Decode('Ch9HZXRPcnBoYW5lZFRyYW5zYWN0aW9uc1Jlc3BvbnNlEkIKDHRyYW5zYWN0aW9ucxgBIAMoCzIeLmdpZnRjYXJkcy5PcnBoYW5lZFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSFAoFdG90YWwYAiABKANSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');
@$core.Deprecated('Use resolveOrphanedTransactionRequestDescriptor instead')
const ResolveOrphanedTransactionRequest$json = const {
  '1': 'ResolveOrphanedTransactionRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'resolution', '3': 2, '4': 1, '5': 9, '10': 'resolution'},
    const {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `ResolveOrphanedTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveOrphanedTransactionRequestDescriptor = $convert.base64Decode('CiFSZXNvbHZlT3JwaGFuZWRUcmFuc2FjdGlvblJlcXVlc3QSDgoCaWQYASABKAlSAmlkEh4KCnJlc29sdXRpb24YAiABKAlSCnJlc29sdXRpb24SFAoFbm90ZXMYAyABKAlSBW5vdGVz');
@$core.Deprecated('Use resolveOrphanedTransactionResponseDescriptor instead')
const ResolveOrphanedTransactionResponse$json = const {
  '1': 'ResolveOrphanedTransactionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResolveOrphanedTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveOrphanedTransactionResponseDescriptor = $convert.base64Decode('CiJSZXNvbHZlT3JwaGFuZWRUcmFuc2FjdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use pendingVerificationDescriptor instead')
const PendingVerification$json = const {
  '1': 'PendingVerification',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'card_type', '3': 3, '4': 1, '5': 9, '10': 'cardType'},
    const {'1': 'denomination', '3': 4, '4': 1, '5': 1, '10': 'denomination'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'verification_attempts', '3': 6, '4': 1, '5': 5, '10': 'verificationAttempts'},
    const {'1': 'last_checked', '3': 7, '4': 1, '5': 9, '10': 'lastChecked'},
    const {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `PendingVerification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingVerificationDescriptor = $convert.base64Decode('ChNQZW5kaW5nVmVyaWZpY2F0aW9uEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIbCgljYXJkX3R5cGUYAyABKAlSCGNhcmRUeXBlEiIKDGRlbm9taW5hdGlvbhgEIAEoAVIMZGVub21pbmF0aW9uEhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIzChV2ZXJpZmljYXRpb25fYXR0ZW1wdHMYBiABKAVSFHZlcmlmaWNhdGlvbkF0dGVtcHRzEiEKDGxhc3RfY2hlY2tlZBgHIAEoCVILbGFzdENoZWNrZWQSFgoGc3RhdHVzGAggASgJUgZzdGF0dXM=');
@$core.Deprecated('Use getPendingVerificationsRequestDescriptor instead')
const GetPendingVerificationsRequest$json = const {
  '1': 'GetPendingVerificationsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetPendingVerificationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingVerificationsRequestDescriptor = $convert.base64Decode('Ch5HZXRQZW5kaW5nVmVyaWZpY2F0aW9uc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getPendingVerificationsResponseDescriptor instead')
const GetPendingVerificationsResponse$json = const {
  '1': 'GetPendingVerificationsResponse',
  '2': const [
    const {'1': 'verifications', '3': 1, '4': 3, '5': 11, '6': '.giftcards.PendingVerification', '10': 'verifications'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetPendingVerificationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingVerificationsResponseDescriptor = $convert.base64Decode('Ch9HZXRQZW5kaW5nVmVyaWZpY2F0aW9uc1Jlc3BvbnNlEkQKDXZlcmlmaWNhdGlvbnMYASADKAsyHi5naWZ0Y2FyZHMuUGVuZGluZ1ZlcmlmaWNhdGlvblINdmVyaWZpY2F0aW9ucxIUCgV0b3RhbBgCIAEoA1IFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use escalatedItemDescriptor instead')
const EscalatedItem$json = const {
  '1': 'EscalatedItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'escalated_at', '3': 5, '4': 1, '5': 9, '10': 'escalatedAt'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'assigned_to', '3': 7, '4': 1, '5': 9, '10': 'assignedTo'},
  ],
};

/// Descriptor for `EscalatedItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List escalatedItemDescriptor = $convert.base64Decode('Cg1Fc2NhbGF0ZWRJdGVtEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIWCgZyZWFzb24YBCABKAlSBnJlYXNvbhIhCgxlc2NhbGF0ZWRfYXQYBSABKAlSC2VzY2FsYXRlZEF0EhYKBnN0YXR1cxgGIAEoCVIGc3RhdHVzEh8KC2Fzc2lnbmVkX3RvGAcgASgJUgphc3NpZ25lZFRv');
@$core.Deprecated('Use getEscalatedItemsRequestDescriptor instead')
const GetEscalatedItemsRequest$json = const {
  '1': 'GetEscalatedItemsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetEscalatedItemsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEscalatedItemsRequestDescriptor = $convert.base64Decode('ChhHZXRFc2NhbGF0ZWRJdGVtc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getEscalatedItemsResponseDescriptor instead')
const GetEscalatedItemsResponse$json = const {
  '1': 'GetEscalatedItemsResponse',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.giftcards.EscalatedItem', '10': 'items'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetEscalatedItemsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEscalatedItemsResponseDescriptor = $convert.base64Decode('ChlHZXRFc2NhbGF0ZWRJdGVtc1Jlc3BvbnNlEi4KBWl0ZW1zGAEgAygLMhguZ2lmdGNhcmRzLkVzY2FsYXRlZEl0ZW1SBWl0ZW1zEhQKBXRvdGFsGAIgASgDUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');
@$core.Deprecated('Use resolveEscalatedItemRequestDescriptor instead')
const ResolveEscalatedItemRequest$json = const {
  '1': 'ResolveEscalatedItemRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'resolution', '3': 2, '4': 1, '5': 9, '10': 'resolution'},
    const {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `ResolveEscalatedItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveEscalatedItemRequestDescriptor = $convert.base64Decode('ChtSZXNvbHZlRXNjYWxhdGVkSXRlbVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEh4KCnJlc29sdXRpb24YAiABKAlSCnJlc29sdXRpb24SFAoFbm90ZXMYAyABKAlSBW5vdGVz');
@$core.Deprecated('Use resolveEscalatedItemResponseDescriptor instead')
const ResolveEscalatedItemResponse$json = const {
  '1': 'ResolveEscalatedItemResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResolveEscalatedItemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveEscalatedItemResponseDescriptor = $convert.base64Decode('ChxSZXNvbHZlRXNjYWxhdGVkSXRlbVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getReconciliationHistoryRequestDescriptor instead')
const GetReconciliationHistoryRequest$json = const {
  '1': 'GetReconciliationHistoryRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetReconciliationHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationHistoryRequestDescriptor = $convert.base64Decode('Ch9HZXRSZWNvbmNpbGlhdGlvbkhpc3RvcnlSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getReconciliationHistoryResponseDescriptor instead')
const GetReconciliationHistoryResponse$json = const {
  '1': 'GetReconciliationHistoryResponse',
  '2': const [
    const {'1': 'runs', '3': 1, '4': 3, '5': 11, '6': '.giftcards.ReconciliationRun', '10': 'runs'},
  ],
};

/// Descriptor for `GetReconciliationHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReconciliationHistoryResponseDescriptor = $convert.base64Decode('CiBHZXRSZWNvbmNpbGlhdGlvbkhpc3RvcnlSZXNwb25zZRIwCgRydW5zGAEgAygLMhwuZ2lmdGNhcmRzLlJlY29uY2lsaWF0aW9uUnVuUgRydW5z');
@$core.Deprecated('Use userSummaryDescriptor instead')
const UserSummary$json = const {
  '1': 'UserSummary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'total_gift_card_sales', '3': 5, '4': 1, '5': 3, '10': 'totalGiftCardSales'},
    const {'1': 'total_payouts', '3': 6, '4': 1, '5': 1, '10': 'totalPayouts'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `UserSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSummaryDescriptor = $convert.base64Decode('CgtVc2VyU3VtbWFyeRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWwSFAoFcGhvbmUYBCABKAlSBXBob25lEjEKFXRvdGFsX2dpZnRfY2FyZF9zYWxlcxgFIAEoA1ISdG90YWxHaWZ0Q2FyZFNhbGVzEiMKDXRvdGFsX3BheW91dHMYBiABKAFSDHRvdGFsUGF5b3V0cxIdCgpjcmVhdGVkX2F0GAcgASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use lookupUserRequestDescriptor instead')
const LookupUserRequest$json = const {
  '1': 'LookupUserRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
  ],
};

/// Descriptor for `LookupUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserRequestDescriptor = $convert.base64Decode('ChFMb29rdXBVc2VyUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSEgoEdHlwZRgCIAEoCVIEdHlwZQ==');
@$core.Deprecated('Use lookupUserResponseDescriptor instead')
const LookupUserResponse$json = const {
  '1': 'LookupUserResponse',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.giftcards.UserSummary', '10': 'users'},
  ],
};

/// Descriptor for `LookupUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupUserResponseDescriptor = $convert.base64Decode('ChJMb29rdXBVc2VyUmVzcG9uc2USLAoFdXNlcnMYASADKAsyFi5naWZ0Y2FyZHMuVXNlclN1bW1hcnlSBXVzZXJz');
@$core.Deprecated('Use getUserDetailsRequestDescriptor instead')
const GetUserDetailsRequest$json = const {
  '1': 'GetUserDetailsRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDetailsRequestDescriptor = $convert.base64Decode('ChVHZXRVc2VyRGV0YWlsc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');
@$core.Deprecated('Use getUserDetailsResponseDescriptor instead')
const GetUserDetailsResponse$json = const {
  '1': 'GetUserDetailsResponse',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.giftcards.UserSummary', '10': 'user'},
    const {'1': 'recent_sales', '3': 2, '4': 3, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'recentSales'},
  ],
};

/// Descriptor for `GetUserDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserDetailsResponseDescriptor = $convert.base64Decode('ChZHZXRVc2VyRGV0YWlsc1Jlc3BvbnNlEioKBHVzZXIYASABKAsyFi5naWZ0Y2FyZHMuVXNlclN1bW1hcnlSBHVzZXISOgoMcmVjZW50X3NhbGVzGAIgAygLMhcuZ2lmdGNhcmRzLkdpZnRDYXJkU2FsZVILcmVjZW50U2FsZXM=');
@$core.Deprecated('Use auditLogEntryDescriptor instead')
const AuditLogEntry$json = const {
  '1': 'AuditLogEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 9, '10': 'timestamp'},
    const {'1': 'admin', '3': 3, '4': 1, '5': 9, '10': 'admin'},
    const {'1': 'action', '3': 4, '4': 1, '5': 9, '10': 'action'},
    const {'1': 'target', '3': 5, '4': 1, '5': 9, '10': 'target'},
    const {'1': 'details', '3': 6, '4': 1, '5': 9, '10': 'details'},
  ],
};

/// Descriptor for `AuditLogEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditLogEntryDescriptor = $convert.base64Decode('Cg1BdWRpdExvZ0VudHJ5Eg4KAmlkGAEgASgJUgJpZBIcCgl0aW1lc3RhbXAYAiABKAlSCXRpbWVzdGFtcBIUCgVhZG1pbhgDIAEoCVIFYWRtaW4SFgoGYWN0aW9uGAQgASgJUgZhY3Rpb24SFgoGdGFyZ2V0GAUgASgJUgZ0YXJnZXQSGAoHZGV0YWlscxgGIAEoCVIHZGV0YWlscw==');
@$core.Deprecated('Use searchGiftCardTransactionRequestDescriptor instead')
const SearchGiftCardTransactionRequest$json = const {
  '1': 'SearchGiftCardTransactionRequest',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `SearchGiftCardTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchGiftCardTransactionRequestDescriptor = $convert.base64Decode('CiBTZWFyY2hHaWZ0Q2FyZFRyYW5zYWN0aW9uUmVxdWVzdBIcCglyZWZlcmVuY2UYASABKAlSCXJlZmVyZW5jZQ==');
@$core.Deprecated('Use searchGiftCardTransactionResponseDescriptor instead')
const SearchGiftCardTransactionResponse$json = const {
  '1': 'SearchGiftCardTransactionResponse',
  '2': const [
    const {'1': 'sale', '3': 1, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
    const {'1': 'events', '3': 2, '4': 3, '5': 11, '6': '.giftcards.AuditLogEntry', '10': 'events'},
  ],
};

/// Descriptor for `SearchGiftCardTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchGiftCardTransactionResponseDescriptor = $convert.base64Decode('CiFTZWFyY2hHaWZ0Q2FyZFRyYW5zYWN0aW9uUmVzcG9uc2USKwoEc2FsZRgBIAEoCzIXLmdpZnRjYXJkcy5HaWZ0Q2FyZFNhbGVSBHNhbGUSMAoGZXZlbnRzGAIgAygLMhguZ2lmdGNhcmRzLkF1ZGl0TG9nRW50cnlSBmV2ZW50cw==');
@$core.Deprecated('Use bulkPerformManualOperationRequestDescriptor instead')
const BulkPerformManualOperationRequest$json = const {
  '1': 'BulkPerformManualOperationRequest',
  '2': const [
    const {'1': 'transaction_ids', '3': 1, '4': 3, '5': 9, '10': 'transactionIds'},
    const {'1': 'operation', '3': 2, '4': 1, '5': 9, '10': 'operation'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'notes', '3': 4, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `BulkPerformManualOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkPerformManualOperationRequestDescriptor = $convert.base64Decode('CiFCdWxrUGVyZm9ybU1hbnVhbE9wZXJhdGlvblJlcXVlc3QSJwoPdHJhbnNhY3Rpb25faWRzGAEgAygJUg50cmFuc2FjdGlvbklkcxIcCglvcGVyYXRpb24YAiABKAlSCW9wZXJhdGlvbhIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhIUCgVub3RlcxgEIAEoCVIFbm90ZXM=');
@$core.Deprecated('Use bulkPerformManualOperationResultDescriptor instead')
const BulkPerformManualOperationResult$json = const {
  '1': 'BulkPerformManualOperationResult',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `BulkPerformManualOperationResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkPerformManualOperationResultDescriptor = $convert.base64Decode('CiBCdWxrUGVyZm9ybU1hbnVhbE9wZXJhdGlvblJlc3VsdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhQKBWVycm9yGAMgASgJUgVlcnJvcg==');
@$core.Deprecated('Use bulkPerformManualOperationResponseDescriptor instead')
const BulkPerformManualOperationResponse$json = const {
  '1': 'BulkPerformManualOperationResponse',
  '2': const [
    const {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.giftcards.BulkPerformManualOperationResult', '10': 'results'},
    const {'1': 'succeeded', '3': 2, '4': 1, '5': 5, '10': 'succeeded'},
    const {'1': 'failed', '3': 3, '4': 1, '5': 5, '10': 'failed'},
  ],
};

/// Descriptor for `BulkPerformManualOperationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkPerformManualOperationResponseDescriptor = $convert.base64Decode('CiJCdWxrUGVyZm9ybU1hbnVhbE9wZXJhdGlvblJlc3BvbnNlEkUKB3Jlc3VsdHMYASADKAsyKy5naWZ0Y2FyZHMuQnVsa1BlcmZvcm1NYW51YWxPcGVyYXRpb25SZXN1bHRSB3Jlc3VsdHMSHAoJc3VjY2VlZGVkGAIgASgFUglzdWNjZWVkZWQSFgoGZmFpbGVkGAMgASgFUgZmYWlsZWQ=');
@$core.Deprecated('Use performManualOperationRequestDescriptor instead')
const PerformManualOperationRequest$json = const {
  '1': 'PerformManualOperationRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'operation', '3': 2, '4': 1, '5': 9, '10': 'operation'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'notes', '3': 4, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'amount_override', '3': 5, '4': 1, '5': 1, '10': 'amountOverride'},
  ],
};

/// Descriptor for `PerformManualOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List performManualOperationRequestDescriptor = $convert.base64Decode('Ch1QZXJmb3JtTWFudWFsT3BlcmF0aW9uUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIcCglvcGVyYXRpb24YAiABKAlSCW9wZXJhdGlvbhIWCgZyZWFzb24YAyABKAlSBnJlYXNvbhIUCgVub3RlcxgEIAEoCVIFbm90ZXMSJwoPYW1vdW50X292ZXJyaWRlGAUgASgBUg5hbW91bnRPdmVycmlkZQ==');
@$core.Deprecated('Use performManualOperationResponseDescriptor instead')
const PerformManualOperationResponse$json = const {
  '1': 'PerformManualOperationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'sale', '3': 3, '4': 1, '5': 11, '6': '.giftcards.GiftCardSale', '10': 'sale'},
  ],
};

/// Descriptor for `PerformManualOperationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List performManualOperationResponseDescriptor = $convert.base64Decode('Ch5QZXJmb3JtTWFudWFsT3BlcmF0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEisKBHNhbGUYAyABKAsyFy5naWZ0Y2FyZHMuR2lmdENhcmRTYWxlUgRzYWxl');
@$core.Deprecated('Use getGiftCardAuditLogRequestDescriptor instead')
const GetGiftCardAuditLogRequest$json = const {
  '1': 'GetGiftCardAuditLogRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetGiftCardAuditLogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardAuditLogRequestDescriptor = $convert.base64Decode('ChpHZXRHaWZ0Q2FyZEF1ZGl0TG9nUmVxdWVzdBIlCg50cmFuc2FjdGlvbl9pZBgBIAEoCVINdHJhbnNhY3Rpb25JZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getGiftCardAuditLogResponseDescriptor instead')
const GetGiftCardAuditLogResponse$json = const {
  '1': 'GetGiftCardAuditLogResponse',
  '2': const [
    const {'1': 'logs', '3': 1, '4': 3, '5': 11, '6': '.giftcards.AuditLogEntry', '10': 'logs'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetGiftCardAuditLogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardAuditLogResponseDescriptor = $convert.base64Decode('ChtHZXRHaWZ0Q2FyZEF1ZGl0TG9nUmVzcG9uc2USLAoEbG9ncxgBIAMoCzIYLmdpZnRjYXJkcy5BdWRpdExvZ0VudHJ5UgRsb2dzEhQKBXRvdGFsGAIgASgDUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');
@$core.Deprecated('Use systemSettingDescriptor instead')
const SystemSetting$json = const {
  '1': 'SystemSetting',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'updated_at', '3': 5, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `SystemSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemSettingDescriptor = $convert.base64Decode('Cg1TeXN0ZW1TZXR0aW5nEhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZRIaCghjYXRlZ29yeRgDIAEoCVIIY2F0ZWdvcnkSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEh0KCnVwZGF0ZWRfYXQYBSABKAlSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use listSystemSettingsRequestDescriptor instead')
const ListSystemSettingsRequest$json = const {
  '1': 'ListSystemSettingsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `ListSystemSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSystemSettingsRequestDescriptor = $convert.base64Decode('ChlMaXN0U3lzdGVtU2V0dGluZ3NSZXF1ZXN0EhoKCGNhdGVnb3J5GAEgASgJUghjYXRlZ29yeQ==');
@$core.Deprecated('Use listSystemSettingsResponseDescriptor instead')
const ListSystemSettingsResponse$json = const {
  '1': 'ListSystemSettingsResponse',
  '2': const [
    const {'1': 'settings', '3': 1, '4': 3, '5': 11, '6': '.giftcards.SystemSetting', '10': 'settings'},
  ],
};

/// Descriptor for `ListSystemSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSystemSettingsResponseDescriptor = $convert.base64Decode('ChpMaXN0U3lzdGVtU2V0dGluZ3NSZXNwb25zZRI0CghzZXR0aW5ncxgBIAMoCzIYLmdpZnRjYXJkcy5TeXN0ZW1TZXR0aW5nUghzZXR0aW5ncw==');
@$core.Deprecated('Use updateSystemSettingRequestDescriptor instead')
const UpdateSystemSettingRequest$json = const {
  '1': 'UpdateSystemSettingRequest',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `UpdateSystemSettingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSystemSettingRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVTeXN0ZW1TZXR0aW5nUmVxdWVzdBIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU=');
@$core.Deprecated('Use updateSystemSettingResponseDescriptor instead')
const UpdateSystemSettingResponse$json = const {
  '1': 'UpdateSystemSettingResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'setting', '3': 3, '4': 1, '5': 11, '6': '.giftcards.SystemSetting', '10': 'setting'},
  ],
};

/// Descriptor for `UpdateSystemSettingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSystemSettingResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVTeXN0ZW1TZXR0aW5nUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjIKB3NldHRpbmcYAyABKAsyGC5naWZ0Y2FyZHMuU3lzdGVtU2V0dGluZ1IHc2V0dGluZw==');
