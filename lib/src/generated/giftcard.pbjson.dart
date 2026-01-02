///
//  Generated code. Do not modify.
//  source: giftcard.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use giftCardStatusDescriptor instead')
const GiftCardStatus$json = const {
  '1': 'GiftCardStatus',
  '2': const [
    const {'1': 'GIFTCARD_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'GIFTCARD_STATUS_ACTIVE', '2': 1},
    const {'1': 'GIFTCARD_STATUS_USED', '2': 2},
    const {'1': 'GIFTCARD_STATUS_EXPIRED', '2': 3},
    const {'1': 'GIFTCARD_STATUS_PENDING', '2': 4},
    const {'1': 'GIFTCARD_STATUS_CANCELLED', '2': 5},
    const {'1': 'GIFTCARD_STATUS_PARTIALLY_REDEEMED', '2': 6},
  ],
};

/// Descriptor for `GiftCardStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List giftCardStatusDescriptor = $convert.base64Decode('Cg5HaWZ0Q2FyZFN0YXR1cxIfChtHSUZUQ0FSRF9TVEFUVVNfVU5TUEVDSUZJRUQQABIaChZHSUZUQ0FSRF9TVEFUVVNfQUNUSVZFEAESGAoUR0lGVENBUkRfU1RBVFVTX1VTRUQQAhIbChdHSUZUQ0FSRF9TVEFUVVNfRVhQSVJFRBADEhsKF0dJRlRDQVJEX1NUQVRVU19QRU5ESU5HEAQSHQoZR0lGVENBUkRfU1RBVFVTX0NBTkNFTExFRBAFEiYKIkdJRlRDQVJEX1NUQVRVU19QQVJUSUFMTFlfUkVERUVNRUQQBg==');
@$core.Deprecated('Use giftCardTypeDescriptor instead')
const GiftCardType$json = const {
  '1': 'GiftCardType',
  '2': const [
    const {'1': 'GIFTCARD_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'GIFTCARD_TYPE_DIGITAL', '2': 1},
    const {'1': 'GIFTCARD_TYPE_PHYSICAL', '2': 2},
  ],
};

/// Descriptor for `GiftCardType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List giftCardTypeDescriptor = $convert.base64Decode('CgxHaWZ0Q2FyZFR5cGUSHQoZR0lGVENBUkRfVFlQRV9VTlNQRUNJRklFRBAAEhkKFUdJRlRDQVJEX1RZUEVfRElHSVRBTBABEhoKFkdJRlRDQVJEX1RZUEVfUEhZU0lDQUwQAg==');
@$core.Deprecated('Use giftCardCategoryDescriptor instead')
const GiftCardCategory$json = const {
  '1': 'GiftCardCategory',
  '2': const [
    const {'1': 'GIFTCARD_CATEGORY_UNSPECIFIED', '2': 0},
    const {'1': 'GIFTCARD_CATEGORY_ENTERTAINMENT', '2': 1},
    const {'1': 'GIFTCARD_CATEGORY_SHOPPING', '2': 2},
    const {'1': 'GIFTCARD_CATEGORY_DINING', '2': 3},
    const {'1': 'GIFTCARD_CATEGORY_TRAVEL', '2': 4},
    const {'1': 'GIFTCARD_CATEGORY_GAMING', '2': 5},
    const {'1': 'GIFTCARD_CATEGORY_OTHER', '2': 6},
  ],
};

/// Descriptor for `GiftCardCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List giftCardCategoryDescriptor = $convert.base64Decode('ChBHaWZ0Q2FyZENhdGVnb3J5EiEKHUdJRlRDQVJEX0NBVEVHT1JZX1VOU1BFQ0lGSUVEEAASIwofR0lGVENBUkRfQ0FURUdPUllfRU5URVJUQUlOTUVOVBABEh4KGkdJRlRDQVJEX0NBVEVHT1JZX1NIT1BQSU5HEAISHAoYR0lGVENBUkRfQ0FURUdPUllfRElOSU5HEAMSHAoYR0lGVENBUkRfQ0FURUdPUllfVFJBVkVMEAQSHAoYR0lGVENBUkRfQ0FURUdPUllfR0FNSU5HEAUSGwoXR0lGVENBUkRfQ0FURUdPUllfT1RIRVIQBg==');
@$core.Deprecated('Use transactionTypeDescriptor instead')
const TransactionType$json = const {
  '1': 'TransactionType',
  '2': const [
    const {'1': 'TRANSACTION_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'TRANSACTION_TYPE_PURCHASE', '2': 1},
    const {'1': 'TRANSACTION_TYPE_REDEEM', '2': 2},
    const {'1': 'TRANSACTION_TYPE_TRANSFER', '2': 3},
    const {'1': 'TRANSACTION_TYPE_REFUND', '2': 4},
    const {'1': 'TRANSACTION_TYPE_SELL', '2': 5},
  ],
};

/// Descriptor for `TransactionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transactionTypeDescriptor = $convert.base64Decode('Cg9UcmFuc2FjdGlvblR5cGUSIAocVFJBTlNBQ1RJT05fVFlQRV9VTlNQRUNJRklFRBAAEh0KGVRSQU5TQUNUSU9OX1RZUEVfUFVSQ0hBU0UQARIbChdUUkFOU0FDVElPTl9UWVBFX1JFREVFTRACEh0KGVRSQU5TQUNUSU9OX1RZUEVfVFJBTlNGRVIQAxIbChdUUkFOU0FDVElPTl9UWVBFX1JFRlVORBAEEhkKFVRSQU5TQUNUSU9OX1RZUEVfU0VMTBAF');
@$core.Deprecated('Use paymentMethodDescriptor instead')
const PaymentMethod$json = const {
  '1': 'PaymentMethod',
  '2': const [
    const {'1': 'PAYMENT_METHOD_UNSPECIFIED', '2': 0},
    const {'1': 'PAYMENT_METHOD_WALLET', '2': 1},
    const {'1': 'PAYMENT_METHOD_CARD', '2': 2},
    const {'1': 'PAYMENT_METHOD_BANK_TRANSFER', '2': 3},
    const {'1': 'PAYMENT_METHOD_MOBILE_MONEY', '2': 4},
    const {'1': 'PAYMENT_METHOD_CRYPTO', '2': 5},
  ],
};

/// Descriptor for `PaymentMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentMethodDescriptor = $convert.base64Decode('Cg1QYXltZW50TWV0aG9kEh4KGlBBWU1FTlRfTUVUSE9EX1VOU1BFQ0lGSUVEEAASGQoVUEFZTUVOVF9NRVRIT0RfV0FMTEVUEAESFwoTUEFZTUVOVF9NRVRIT0RfQ0FSRBACEiAKHFBBWU1FTlRfTUVUSE9EX0JBTktfVFJBTlNGRVIQAxIfChtQQVlNRU5UX01FVEhPRF9NT0JJTEVfTU9ORVkQBBIZChVQQVlNRU5UX01FVEhPRF9DUllQVE8QBQ==');
@$core.Deprecated('Use giftCardBrandDescriptor instead')
const GiftCardBrand$json = const {
  '1': 'GiftCardBrand',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 5, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    const {'1': 'discount_percentage', '3': 6, '4': 1, '5': 1, '10': 'discountPercentage'},
    const {'1': 'is_popular', '3': 7, '4': 1, '5': 8, '10': 'isPopular'},
    const {'1': 'available_denominations', '3': 8, '4': 3, '5': 9, '10': 'availableDenominations'},
    const {'1': 'min_amount', '3': 9, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 10, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'terms_and_conditions', '3': 11, '4': 1, '5': 9, '10': 'termsAndConditions'},
    const {'1': 'is_available', '3': 12, '4': 1, '5': 8, '10': 'isAvailable'},
    const {'1': 'stock_count', '3': 13, '4': 1, '5': 5, '10': 'stockCount'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `GiftCardBrand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardBrandDescriptor = $convert.base64Decode('Cg1HaWZ0Q2FyZEJyYW5kEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhI2CghjYXRlZ29yeRgFIAEoDjIaLmdpZnRjYXJkLkdpZnRDYXJkQ2F0ZWdvcnlSCGNhdGVnb3J5Ei8KE2Rpc2NvdW50X3BlcmNlbnRhZ2UYBiABKAFSEmRpc2NvdW50UGVyY2VudGFnZRIdCgppc19wb3B1bGFyGAcgASgIUglpc1BvcHVsYXISNwoXYXZhaWxhYmxlX2Rlbm9taW5hdGlvbnMYCCADKAlSFmF2YWlsYWJsZURlbm9taW5hdGlvbnMSHQoKbWluX2Ftb3VudBgJIAEoAVIJbWluQW1vdW50Eh0KCm1heF9hbW91bnQYCiABKAFSCW1heEFtb3VudBIwChR0ZXJtc19hbmRfY29uZGl0aW9ucxgLIAEoCVISdGVybXNBbmRDb25kaXRpb25zEiEKDGlzX2F2YWlsYWJsZRgMIAEoCFILaXNBdmFpbGFibGUSHwoLc3RvY2tfY291bnQYDSABKAVSCnN0b2NrQ291bnQSOQoKY3JlYXRlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use giftCardDescriptor instead')
const GiftCard$json = const {
  '1': 'GiftCard',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'brand_id', '3': 3, '4': 1, '5': 9, '10': 'brandId'},
    const {'1': 'brand_name', '3': 4, '4': 1, '5': 9, '10': 'brandName'},
    const {'1': 'logo_url', '3': 5, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'discount_percentage', '3': 7, '4': 1, '5': 1, '10': 'discountPercentage'},
    const {'1': 'final_price', '3': 8, '4': 1, '5': 1, '10': 'finalPrice'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.giftcard.GiftCardStatus', '10': 'status'},
    const {'1': 'type', '3': 11, '4': 1, '5': 14, '6': '.giftcard.GiftCardType', '10': 'type'},
    const {'1': 'category', '3': 12, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    const {'1': 'description', '3': 13, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'terms_and_conditions', '3': 14, '4': 1, '5': 9, '10': 'termsAndConditions'},
    const {'1': 'expiry_date', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiryDate'},
    const {'1': 'purchase_date', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'purchaseDate'},
    const {'1': 'recipient_email', '3': 17, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 18, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'message', '3': 19, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'code', '3': 20, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'pin', '3': 21, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'is_redeemed', '3': 22, '4': 1, '5': 8, '10': 'isRedeemed'},
    const {'1': 'transaction_id', '3': 23, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'available_denominations', '3': 24, '4': 3, '5': 9, '10': 'availableDenominations'},
    const {'1': 'qr_code_url', '3': 25, '4': 1, '5': 9, '10': 'qrCodeUrl'},
    const {'1': 'barcode_url', '3': 26, '4': 1, '5': 9, '10': 'barcodeUrl'},
    const {'1': 'created_at', '3': 27, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 28, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'redeemed_at', '3': 29, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'redeemedAt'},
    const {'1': 'redemption_location', '3': 30, '4': 1, '5': 9, '10': 'redemptionLocation'},
    const {'1': 'remaining_balance', '3': 31, '4': 1, '5': 1, '10': 'remainingBalance'},
    const {'1': 'original_amount', '3': 32, '4': 1, '5': 1, '10': 'originalAmount'},
  ],
};

/// Descriptor for `GiftCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDescriptor = $convert.base64Decode('CghHaWZ0Q2FyZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhkKCGJyYW5kX2lkGAMgASgJUgdicmFuZElkEh0KCmJyYW5kX25hbWUYBCABKAlSCWJyYW5kTmFtZRIZCghsb2dvX3VybBgFIAEoCVIHbG9nb1VybBIWCgZhbW91bnQYBiABKAFSBmFtb3VudBIvChNkaXNjb3VudF9wZXJjZW50YWdlGAcgASgBUhJkaXNjb3VudFBlcmNlbnRhZ2USHwoLZmluYWxfcHJpY2UYCCABKAFSCmZpbmFsUHJpY2USGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EjAKBnN0YXR1cxgKIAEoDjIYLmdpZnRjYXJkLkdpZnRDYXJkU3RhdHVzUgZzdGF0dXMSKgoEdHlwZRgLIAEoDjIWLmdpZnRjYXJkLkdpZnRDYXJkVHlwZVIEdHlwZRI2CghjYXRlZ29yeRgMIAEoDjIaLmdpZnRjYXJkLkdpZnRDYXJkQ2F0ZWdvcnlSCGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGA0gASgJUgtkZXNjcmlwdGlvbhIwChR0ZXJtc19hbmRfY29uZGl0aW9ucxgOIAEoCVISdGVybXNBbmRDb25kaXRpb25zEjsKC2V4cGlyeV9kYXRlGA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKZXhwaXJ5RGF0ZRI/Cg1wdXJjaGFzZV9kYXRlGBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcHVyY2hhc2VEYXRlEicKD3JlY2lwaWVudF9lbWFpbBgRIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYEiABKAlSDXJlY2lwaWVudE5hbWUSGAoHbWVzc2FnZRgTIAEoCVIHbWVzc2FnZRISCgRjb2RlGBQgASgJUgRjb2RlEhAKA3BpbhgVIAEoCVIDcGluEh8KC2lzX3JlZGVlbWVkGBYgASgIUgppc1JlZGVlbWVkEiUKDnRyYW5zYWN0aW9uX2lkGBcgASgJUg10cmFuc2FjdGlvbklkEjcKF2F2YWlsYWJsZV9kZW5vbWluYXRpb25zGBggAygJUhZhdmFpbGFibGVEZW5vbWluYXRpb25zEh4KC3FyX2NvZGVfdXJsGBkgASgJUglxckNvZGVVcmwSHwoLYmFyY29kZV91cmwYGiABKAlSCmJhcmNvZGVVcmwSOQoKY3JlYXRlZF9hdBgbIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0EjsKC3JlZGVlbWVkX2F0GB0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKcmVkZWVtZWRBdBIvChNyZWRlbXB0aW9uX2xvY2F0aW9uGB4gASgJUhJyZWRlbXB0aW9uTG9jYXRpb24SKwoRcmVtYWluaW5nX2JhbGFuY2UYHyABKAFSEHJlbWFpbmluZ0JhbGFuY2USJwoPb3JpZ2luYWxfYW1vdW50GCAgASgBUg5vcmlnaW5hbEFtb3VudA==');
@$core.Deprecated('Use giftCardTransactionDescriptor instead')
const GiftCardTransaction$json = const {
  '1': 'GiftCardTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'gift_card_id', '3': 2, '4': 1, '5': 9, '10': 'giftCardId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'transaction_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'transaction_type', '3': 7, '4': 1, '5': 14, '6': '.giftcard.TransactionType', '10': 'transactionType'},
    const {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.giftcard.GiftCardStatus', '10': 'status'},
    const {'1': 'failure_reason', '3': 9, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'payment_method', '3': 10, '4': 1, '5': 14, '6': '.giftcard.PaymentMethod', '10': 'paymentMethod'},
    const {'1': 'payment_reference', '3': 11, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'receipt_url', '3': 12, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'recipient_email', '3': 13, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 14, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `GiftCardTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardTransactionDescriptor = $convert.base64Decode('ChNHaWZ0Q2FyZFRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIgCgxnaWZ0X2NhcmRfaWQYAiABKAlSCmdpZnRDYXJkSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRJFChB0cmFuc2FjdGlvbl9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25EYXRlEkQKEHRyYW5zYWN0aW9uX3R5cGUYByABKA4yGS5naWZ0Y2FyZC5UcmFuc2FjdGlvblR5cGVSD3RyYW5zYWN0aW9uVHlwZRIwCgZzdGF0dXMYCCABKA4yGC5naWZ0Y2FyZC5HaWZ0Q2FyZFN0YXR1c1IGc3RhdHVzEiUKDmZhaWx1cmVfcmVhc29uGAkgASgJUg1mYWlsdXJlUmVhc29uEj4KDnBheW1lbnRfbWV0aG9kGAogASgOMhcuZ2lmdGNhcmQuUGF5bWVudE1ldGhvZFINcGF5bWVudE1ldGhvZBIrChFwYXltZW50X3JlZmVyZW5jZRgLIAEoCVIQcGF5bWVudFJlZmVyZW5jZRIfCgtyZWNlaXB0X3VybBgMIAEoCVIKcmVjZWlwdFVybBInCg9yZWNpcGllbnRfZW1haWwYDSABKAlSDnJlY2lwaWVudEVtYWlsEiUKDnJlY2lwaWVudF9uYW1lGA4gASgJUg1yZWNpcGllbnROYW1lEjkKCmNyZWF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use statisticsDescriptor instead')
const Statistics$json = const {
  '1': 'Statistics',
  '2': const [
    const {'1': 'total_cards', '3': 1, '4': 1, '5': 3, '10': 'totalCards'},
    const {'1': 'active_cards', '3': 2, '4': 1, '5': 3, '10': 'activeCards'},
    const {'1': 'used_cards', '3': 3, '4': 1, '5': 3, '10': 'usedCards'},
    const {'1': 'pending_cards', '3': 4, '4': 1, '5': 3, '10': 'pendingCards'},
    const {'1': 'expired_cards', '3': 5, '4': 1, '5': 3, '10': 'expiredCards'},
    const {'1': 'total_value', '3': 6, '4': 1, '5': 1, '10': 'totalValue'},
    const {'1': 'total_spent', '3': 7, '4': 1, '5': 1, '10': 'totalSpent'},
    const {'1': 'total_saved', '3': 8, '4': 1, '5': 1, '10': 'totalSaved'},
    const {'1': 'recent_cards', '3': 9, '4': 3, '5': 11, '6': '.giftcard.GiftCard', '10': 'recentCards'},
    const {'1': 'recent_transactions', '3': 10, '4': 3, '5': 11, '6': '.giftcard.GiftCardTransaction', '10': 'recentTransactions'},
  ],
};

/// Descriptor for `Statistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statisticsDescriptor = $convert.base64Decode('CgpTdGF0aXN0aWNzEh8KC3RvdGFsX2NhcmRzGAEgASgDUgp0b3RhbENhcmRzEiEKDGFjdGl2ZV9jYXJkcxgCIAEoA1ILYWN0aXZlQ2FyZHMSHQoKdXNlZF9jYXJkcxgDIAEoA1IJdXNlZENhcmRzEiMKDXBlbmRpbmdfY2FyZHMYBCABKANSDHBlbmRpbmdDYXJkcxIjCg1leHBpcmVkX2NhcmRzGAUgASgDUgxleHBpcmVkQ2FyZHMSHwoLdG90YWxfdmFsdWUYBiABKAFSCnRvdGFsVmFsdWUSHwoLdG90YWxfc3BlbnQYByABKAFSCnRvdGFsU3BlbnQSHwoLdG90YWxfc2F2ZWQYCCABKAFSCnRvdGFsU2F2ZWQSNQoMcmVjZW50X2NhcmRzGAkgAygLMhIuZ2lmdGNhcmQuR2lmdENhcmRSC3JlY2VudENhcmRzEk4KE3JlY2VudF90cmFuc2FjdGlvbnMYCiADKAsyHS5naWZ0Y2FyZC5HaWZ0Q2FyZFRyYW5zYWN0aW9uUhJyZWNlbnRUcmFuc2FjdGlvbnM=');
@$core.Deprecated('Use getBrandsRequestDescriptor instead')
const GetBrandsRequest$json = const {
  '1': 'GetBrandsRequest',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    const {'1': 'popular_only', '3': 2, '4': 1, '5': 8, '10': 'popularOnly'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetBrandsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrandsRequestDescriptor = $convert.base64Decode('ChBHZXRCcmFuZHNSZXF1ZXN0EjYKCGNhdGVnb3J5GAEgASgOMhouZ2lmdGNhcmQuR2lmdENhcmRDYXRlZ29yeVIIY2F0ZWdvcnkSIQoMcG9wdWxhcl9vbmx5GAIgASgIUgtwb3B1bGFyT25seRISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getBrandsResponseDescriptor instead')
const GetBrandsResponse$json = const {
  '1': 'GetBrandsResponse',
  '2': const [
    const {'1': 'brands', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCardBrand', '10': 'brands'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetBrandsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrandsResponseDescriptor = $convert.base64Decode('ChFHZXRCcmFuZHNSZXNwb25zZRIvCgZicmFuZHMYASADKAsyFy5naWZ0Y2FyZC5HaWZ0Q2FyZEJyYW5kUgZicmFuZHMSFAoFdG90YWwYAiABKANSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');
@$core.Deprecated('Use getBrandByIdRequestDescriptor instead')
const GetBrandByIdRequest$json = const {
  '1': 'GetBrandByIdRequest',
  '2': const [
    const {'1': 'brand_id', '3': 1, '4': 1, '5': 9, '10': 'brandId'},
  ],
};

/// Descriptor for `GetBrandByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrandByIdRequestDescriptor = $convert.base64Decode('ChNHZXRCcmFuZEJ5SWRSZXF1ZXN0EhkKCGJyYW5kX2lkGAEgASgJUgdicmFuZElk');
@$core.Deprecated('Use getBrandByIdResponseDescriptor instead')
const GetBrandByIdResponse$json = const {
  '1': 'GetBrandByIdResponse',
  '2': const [
    const {'1': 'brand', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCardBrand', '10': 'brand'},
  ],
};

/// Descriptor for `GetBrandByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrandByIdResponseDescriptor = $convert.base64Decode('ChRHZXRCcmFuZEJ5SWRSZXNwb25zZRItCgVicmFuZBgBIAEoCzIXLmdpZnRjYXJkLkdpZnRDYXJkQnJhbmRSBWJyYW5k');
@$core.Deprecated('Use searchBrandsRequestDescriptor instead')
const SearchBrandsRequest$json = const {
  '1': 'SearchBrandsRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'category', '3': 2, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchBrandsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchBrandsRequestDescriptor = $convert.base64Decode('ChNTZWFyY2hCcmFuZHNSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRI2CghjYXRlZ29yeRgCIAEoDjIaLmdpZnRjYXJkLkdpZnRDYXJkQ2F0ZWdvcnlSCGNhdGVnb3J5EhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');
@$core.Deprecated('Use searchBrandsResponseDescriptor instead')
const SearchBrandsResponse$json = const {
  '1': 'SearchBrandsResponse',
  '2': const [
    const {'1': 'brands', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCardBrand', '10': 'brands'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'query', '3': 3, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `SearchBrandsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchBrandsResponseDescriptor = $convert.base64Decode('ChRTZWFyY2hCcmFuZHNSZXNwb25zZRIvCgZicmFuZHMYASADKAsyFy5naWZ0Y2FyZC5HaWZ0Q2FyZEJyYW5kUgZicmFuZHMSFAoFdG90YWwYAiABKANSBXRvdGFsEhQKBXF1ZXJ5GAMgASgJUgVxdWVyeQ==');
@$core.Deprecated('Use getUserGiftCardsRequestDescriptor instead')
const GetUserGiftCardsRequest$json = const {
  '1': 'GetUserGiftCardsRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.giftcard.GiftCardStatus', '10': 'status'},
    const {'1': 'category', '3': 2, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    const {'1': 'search_query', '3': 3, '4': 1, '5': 9, '10': 'searchQuery'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserGiftCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserGiftCardsRequestDescriptor = $convert.base64Decode('ChdHZXRVc2VyR2lmdENhcmRzUmVxdWVzdBIwCgZzdGF0dXMYASABKA4yGC5naWZ0Y2FyZC5HaWZ0Q2FyZFN0YXR1c1IGc3RhdHVzEjYKCGNhdGVnb3J5GAIgASgOMhouZ2lmdGNhcmQuR2lmdENhcmRDYXRlZ29yeVIIY2F0ZWdvcnkSIQoMc2VhcmNoX3F1ZXJ5GAMgASgJUgtzZWFyY2hRdWVyeRISCgRwYWdlGAQgASgFUgRwYWdlEhQKBWxpbWl0GAUgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getUserGiftCardsResponseDescriptor instead')
const GetUserGiftCardsResponse$json = const {
  '1': 'GetUserGiftCardsResponse',
  '2': const [
    const {'1': 'gift_cards', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCards'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    const {'1': 'statistics', '3': 3, '4': 1, '5': 11, '6': '.giftcard.Statistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetUserGiftCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserGiftCardsResponseDescriptor = $convert.base64Decode('ChhHZXRVc2VyR2lmdENhcmRzUmVzcG9uc2USMQoKZ2lmdF9jYXJkcxgBIAMoCzISLmdpZnRjYXJkLkdpZnRDYXJkUglnaWZ0Q2FyZHMSFAoFdG90YWwYAiABKANSBXRvdGFsEjQKCnN0YXRpc3RpY3MYAyABKAsyFC5naWZ0Y2FyZC5TdGF0aXN0aWNzUgpzdGF0aXN0aWNz');
@$core.Deprecated('Use getGiftCardByIdRequestDescriptor instead')
const GetGiftCardByIdRequest$json = const {
  '1': 'GetGiftCardByIdRequest',
  '2': const [
    const {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
  ],
};

/// Descriptor for `GetGiftCardByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardByIdRequestDescriptor = $convert.base64Decode('ChZHZXRHaWZ0Q2FyZEJ5SWRSZXF1ZXN0EiAKDGdpZnRfY2FyZF9pZBgBIAEoCVIKZ2lmdENhcmRJZA==');
@$core.Deprecated('Use getGiftCardByIdResponseDescriptor instead')
const GetGiftCardByIdResponse$json = const {
  '1': 'GetGiftCardByIdResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
  ],
};

/// Descriptor for `GetGiftCardByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardByIdResponseDescriptor = $convert.base64Decode('ChdHZXRHaWZ0Q2FyZEJ5SWRSZXNwb25zZRIvCglnaWZ0X2NhcmQYASABKAsyEi5naWZ0Y2FyZC5HaWZ0Q2FyZFIIZ2lmdENhcmQ=');
@$core.Deprecated('Use purchaseGiftCardRequestDescriptor instead')
const PurchaseGiftCardRequest$json = const {
  '1': 'PurchaseGiftCardRequest',
  '2': const [
    const {'1': 'brand_id', '3': 1, '4': 1, '5': 9, '10': 'brandId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_method', '3': 4, '4': 1, '5': 14, '6': '.giftcard.PaymentMethod', '10': 'paymentMethod'},
    const {'1': 'recipient_email', '3': 5, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 6, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_for_self', '3': 8, '4': 1, '5': 8, '10': 'isForSelf'},
    const {'1': 'scheduled_delivery', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledDelivery'},
  ],
};

/// Descriptor for `PurchaseGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseGiftCardRequestDescriptor = $convert.base64Decode('ChdQdXJjaGFzZUdpZnRDYXJkUmVxdWVzdBIZCghicmFuZF9pZBgBIAEoCVIHYnJhbmRJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSPgoOcGF5bWVudF9tZXRob2QYBCABKA4yFy5naWZ0Y2FyZC5QYXltZW50TWV0aG9kUg1wYXltZW50TWV0aG9kEicKD3JlY2lwaWVudF9lbWFpbBgFIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYBiABKAlSDXJlY2lwaWVudE5hbWUSGAoHbWVzc2FnZRgHIAEoCVIHbWVzc2FnZRIeCgtpc19mb3Jfc2VsZhgIIAEoCFIJaXNGb3JTZWxmEkkKEnNjaGVkdWxlZF9kZWxpdmVyeRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEXNjaGVkdWxlZERlbGl2ZXJ5');
@$core.Deprecated('Use purchaseGiftCardResponseDescriptor instead')
const PurchaseGiftCardResponse$json = const {
  '1': 'PurchaseGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
    const {'1': 'receipt_url', '3': 2, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PurchaseGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseGiftCardResponseDescriptor = $convert.base64Decode('ChhQdXJjaGFzZUdpZnRDYXJkUmVzcG9uc2USLwoJZ2lmdF9jYXJkGAEgASgLMhIuZ2lmdGNhcmQuR2lmdENhcmRSCGdpZnRDYXJkEh8KC3JlY2VpcHRfdXJsGAIgASgJUgpyZWNlaXB0VXJsEiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklkEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use validatePurchaseRequestDescriptor instead')
const ValidatePurchaseRequest$json = const {
  '1': 'ValidatePurchaseRequest',
  '2': const [
    const {'1': 'brand_id', '3': 1, '4': 1, '5': 9, '10': 'brandId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'payment_method', '3': 3, '4': 1, '5': 14, '6': '.giftcard.PaymentMethod', '10': 'paymentMethod'},
  ],
};

/// Descriptor for `ValidatePurchaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatePurchaseRequestDescriptor = $convert.base64Decode('ChdWYWxpZGF0ZVB1cmNoYXNlUmVxdWVzdBIZCghicmFuZF9pZBgBIAEoCVIHYnJhbmRJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBI+Cg5wYXltZW50X21ldGhvZBgDIAEoDjIXLmdpZnRjYXJkLlBheW1lbnRNZXRob2RSDXBheW1lbnRNZXRob2Q=');
@$core.Deprecated('Use validatePurchaseResponseDescriptor instead')
const ValidatePurchaseResponse$json = const {
  '1': 'ValidatePurchaseResponse',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'discount_applied', '3': 3, '4': 1, '5': 1, '10': 'discountApplied'},
    const {'1': 'final_price', '3': 4, '4': 1, '5': 1, '10': 'finalPrice'},
  ],
};

/// Descriptor for `ValidatePurchaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatePurchaseResponseDescriptor = $convert.base64Decode('ChhWYWxpZGF0ZVB1cmNoYXNlUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIpChBkaXNjb3VudF9hcHBsaWVkGAMgASgBUg9kaXNjb3VudEFwcGxpZWQSHwoLZmluYWxfcHJpY2UYBCABKAFSCmZpbmFsUHJpY2U=');
@$core.Deprecated('Use validateCodeRequestDescriptor instead')
const ValidateCodeRequest$json = const {
  '1': 'ValidateCodeRequest',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `ValidateCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateCodeRequestDescriptor = $convert.base64Decode('ChNWYWxpZGF0ZUNvZGVSZXF1ZXN0EhIKBGNvZGUYASABKAlSBGNvZGUSEAoDcGluGAIgASgJUgNwaW4=');
@$core.Deprecated('Use validateCodeResponseDescriptor instead')
const ValidateCodeResponse$json = const {
  '1': 'ValidateCodeResponse',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'is_expired', '3': 2, '4': 1, '5': 8, '10': 'isExpired'},
    const {'1': 'is_redeemed', '3': 3, '4': 1, '5': 8, '10': 'isRedeemed'},
    const {'1': 'gift_card', '3': 4, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ValidateCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateCodeResponseDescriptor = $convert.base64Decode('ChRWYWxpZGF0ZUNvZGVSZXNwb25zZRIZCghpc192YWxpZBgBIAEoCFIHaXNWYWxpZBIdCgppc19leHBpcmVkGAIgASgIUglpc0V4cGlyZWQSHwoLaXNfcmVkZWVtZWQYAyABKAhSCmlzUmVkZWVtZWQSLwoJZ2lmdF9jYXJkGAQgASgLMhIuZ2lmdGNhcmQuR2lmdENhcmRSCGdpZnRDYXJkEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use redeemGiftCardRequestDescriptor instead')
const RedeemGiftCardRequest$json = const {
  '1': 'RedeemGiftCardRequest',
  '2': const [
    const {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'amount_to_redeem', '3': 4, '4': 1, '5': 1, '10': 'amountToRedeem'},
    const {'1': 'location', '3': 5, '4': 1, '5': 9, '10': 'location'},
  ],
};

/// Descriptor for `RedeemGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemGiftCardRequestDescriptor = $convert.base64Decode('ChVSZWRlZW1HaWZ0Q2FyZFJlcXVlc3QSIAoMZ2lmdF9jYXJkX2lkGAEgASgJUgpnaWZ0Q2FyZElkEhIKBGNvZGUYAiABKAlSBGNvZGUSEAoDcGluGAMgASgJUgNwaW4SKAoQYW1vdW50X3RvX3JlZGVlbRgEIAEoAVIOYW1vdW50VG9SZWRlZW0SGgoIbG9jYXRpb24YBSABKAlSCGxvY2F0aW9u');
@$core.Deprecated('Use redeemGiftCardResponseDescriptor instead')
const RedeemGiftCardResponse$json = const {
  '1': 'RedeemGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
    const {'1': 'redeemed_amount', '3': 2, '4': 1, '5': 1, '10': 'redeemedAmount'},
    const {'1': 'remaining_balance', '3': 3, '4': 1, '5': 1, '10': 'remainingBalance'},
    const {'1': 'receipt_url', '3': 4, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RedeemGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemGiftCardResponseDescriptor = $convert.base64Decode('ChZSZWRlZW1HaWZ0Q2FyZFJlc3BvbnNlEi8KCWdpZnRfY2FyZBgBIAEoCzISLmdpZnRjYXJkLkdpZnRDYXJkUghnaWZ0Q2FyZBInCg9yZWRlZW1lZF9hbW91bnQYAiABKAFSDnJlZGVlbWVkQW1vdW50EisKEXJlbWFpbmluZ19iYWxhbmNlGAMgASgBUhByZW1haW5pbmdCYWxhbmNlEh8KC3JlY2VpcHRfdXJsGAQgASgJUgpyZWNlaXB0VXJsEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use checkBalanceRequestDescriptor instead')
const CheckBalanceRequest$json = const {
  '1': 'CheckBalanceRequest',
  '2': const [
    const {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `CheckBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkBalanceRequestDescriptor = $convert.base64Decode('ChNDaGVja0JhbGFuY2VSZXF1ZXN0EiAKDGdpZnRfY2FyZF9pZBgBIAEoCVIKZ2lmdENhcmRJZBISCgRjb2RlGAIgASgJUgRjb2RlEhAKA3BpbhgDIAEoCVIDcGlu');
@$core.Deprecated('Use checkBalanceResponseDescriptor instead')
const CheckBalanceResponse$json = const {
  '1': 'CheckBalanceResponse',
  '2': const [
    const {'1': 'remaining_balance', '3': 1, '4': 1, '5': 1, '10': 'remainingBalance'},
    const {'1': 'original_amount', '3': 2, '4': 1, '5': 1, '10': 'originalAmount'},
    const {'1': 'redeemed_amount', '3': 3, '4': 1, '5': 1, '10': 'redeemedAmount'},
    const {'1': 'last_used', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsed'},
    const {'1': 'gift_card', '3': 5, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
  ],
};

/// Descriptor for `CheckBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkBalanceResponseDescriptor = $convert.base64Decode('ChRDaGVja0JhbGFuY2VSZXNwb25zZRIrChFyZW1haW5pbmdfYmFsYW5jZRgBIAEoAVIQcmVtYWluaW5nQmFsYW5jZRInCg9vcmlnaW5hbF9hbW91bnQYAiABKAFSDm9yaWdpbmFsQW1vdW50EicKD3JlZGVlbWVkX2Ftb3VudBgDIAEoAVIOcmVkZWVtZWRBbW91bnQSNwoJbGFzdF91c2VkGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIbGFzdFVzZWQSLwoJZ2lmdF9jYXJkGAUgASgLMhIuZ2lmdGNhcmQuR2lmdENhcmRSCGdpZnRDYXJk');
@$core.Deprecated('Use transferGiftCardRequestDescriptor instead')
const TransferGiftCardRequest$json = const {
  '1': 'TransferGiftCardRequest',
  '2': const [
    const {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    const {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TransferGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardRequestDescriptor = $convert.base64Decode('ChdUcmFuc2ZlckdpZnRDYXJkUmVxdWVzdBIgCgxnaWZ0X2NhcmRfaWQYASABKAlSCmdpZnRDYXJkSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGllbnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use transferGiftCardResponseDescriptor instead')
const TransferGiftCardResponse$json = const {
  '1': 'TransferGiftCardResponse',
  '2': const [
    const {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TransferGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardResponseDescriptor = $convert.base64Decode('ChhUcmFuc2ZlckdpZnRDYXJkUmVzcG9uc2USLwoJZ2lmdF9jYXJkGAEgASgLMhIuZ2lmdGNhcmQuR2lmdENhcmRSCGdpZnRDYXJkEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use sellGiftCardRequestDescriptor instead')
const SellGiftCardRequest$json = const {
  '1': 'SellGiftCardRequest',
  '2': const [
    const {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    const {'1': 'asking_price', '3': 2, '4': 1, '5': 1, '10': 'askingPrice'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `SellGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardRequestDescriptor = $convert.base64Decode('ChNTZWxsR2lmdENhcmRSZXF1ZXN0EiAKDGdpZnRfY2FyZF9pZBgBIAEoCVIKZ2lmdENhcmRJZBIhCgxhc2tpbmdfcHJpY2UYAiABKAFSC2Fza2luZ1ByaWNlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbg==');
@$core.Deprecated('Use sellGiftCardResponseDescriptor instead')
const SellGiftCardResponse$json = const {
  '1': 'SellGiftCardResponse',
  '2': const [
    const {'1': 'listing_id', '3': 1, '4': 1, '5': 9, '10': 'listingId'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SellGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardResponseDescriptor = $convert.base64Decode('ChRTZWxsR2lmdENhcmRSZXNwb25zZRIdCgpsaXN0aW5nX2lkGAEgASgJUglsaXN0aW5nSWQSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getResellableCardsRequestDescriptor instead')
const GetResellableCardsRequest$json = const {
  '1': 'GetResellableCardsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetResellableCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getResellableCardsRequestDescriptor = $convert.base64Decode('ChlHZXRSZXNlbGxhYmxlQ2FyZHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBWxpbWl0');
@$core.Deprecated('Use getResellableCardsResponseDescriptor instead')
const GetResellableCardsResponse$json = const {
  '1': 'GetResellableCardsResponse',
  '2': const [
    const {'1': 'gift_cards', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCards'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetResellableCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getResellableCardsResponseDescriptor = $convert.base64Decode('ChpHZXRSZXNlbGxhYmxlQ2FyZHNSZXNwb25zZRIxCgpnaWZ0X2NhcmRzGAEgAygLMhIuZ2lmdGNhcmQuR2lmdENhcmRSCWdpZnRDYXJkcxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');
@$core.Deprecated('Use getTransactionsRequestDescriptor instead')
const GetTransactionsRequest$json = const {
  '1': 'GetTransactionsRequest',
  '2': const [
    const {'1': 'transaction_type', '3': 1, '4': 1, '5': 14, '6': '.giftcard.TransactionType', '10': 'transactionType'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsRequestDescriptor = $convert.base64Decode('ChZHZXRUcmFuc2FjdGlvbnNSZXF1ZXN0EkQKEHRyYW5zYWN0aW9uX3R5cGUYASABKA4yGS5naWZ0Y2FyZC5UcmFuc2FjdGlvblR5cGVSD3RyYW5zYWN0aW9uVHlwZRI5CgpzdGFydF9kYXRlGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRISCgRwYWdlGAQgASgFUgRwYWdlEhQKBWxpbWl0GAUgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getTransactionsResponseDescriptor instead')
const GetTransactionsResponse$json = const {
  '1': 'GetTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCardTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsResponseDescriptor = $convert.base64Decode('ChdHZXRUcmFuc2FjdGlvbnNSZXNwb25zZRJBCgx0cmFuc2FjdGlvbnMYASADKAsyHS5naWZ0Y2FyZC5HaWZ0Q2FyZFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSFAoFdG90YWwYAiABKANSBXRvdGFs');
@$core.Deprecated('Use getTransactionByIdRequestDescriptor instead')
const GetTransactionByIdRequest$json = const {
  '1': 'GetTransactionByIdRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetTransactionByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionByIdRequestDescriptor = $convert.base64Decode('ChlHZXRUcmFuc2FjdGlvbkJ5SWRSZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklk');
@$core.Deprecated('Use getTransactionByIdResponseDescriptor instead')
const GetTransactionByIdResponse$json = const {
  '1': 'GetTransactionByIdResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCardTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `GetTransactionByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionByIdResponseDescriptor = $convert.base64Decode('ChpHZXRUcmFuc2FjdGlvbkJ5SWRSZXNwb25zZRI/Cgt0cmFuc2FjdGlvbhgBIAEoCzIdLmdpZnRjYXJkLkdpZnRDYXJkVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9u');
@$core.Deprecated('Use getStatisticsRequestDescriptor instead')
const GetStatisticsRequest$json = const {
  '1': 'GetStatisticsRequest',
};

/// Descriptor for `GetStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatisticsRequestDescriptor = $convert.base64Decode('ChRHZXRTdGF0aXN0aWNzUmVxdWVzdA==');
@$core.Deprecated('Use getStatisticsResponseDescriptor instead')
const GetStatisticsResponse$json = const {
  '1': 'GetStatisticsResponse',
  '2': const [
    const {'1': 'statistics', '3': 1, '4': 1, '5': 11, '6': '.giftcard.Statistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatisticsResponseDescriptor = $convert.base64Decode('ChVHZXRTdGF0aXN0aWNzUmVzcG9uc2USNAoKc3RhdGlzdGljcxgBIAEoCzIULmdpZnRjYXJkLlN0YXRpc3RpY3NSCnN0YXRpc3RpY3M=');
