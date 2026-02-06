//
//  Generated code. Do not modify.
//  source: giftcard.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use giftCardStatusDescriptor instead')
const GiftCardStatus$json = {
  '1': 'GiftCardStatus',
  '2': [
    {'1': 'GIFTCARD_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'GIFTCARD_STATUS_ACTIVE', '2': 1},
    {'1': 'GIFTCARD_STATUS_USED', '2': 2},
    {'1': 'GIFTCARD_STATUS_EXPIRED', '2': 3},
    {'1': 'GIFTCARD_STATUS_PENDING', '2': 4},
    {'1': 'GIFTCARD_STATUS_CANCELLED', '2': 5},
    {'1': 'GIFTCARD_STATUS_PARTIALLY_REDEEMED', '2': 6},
  ],
};

/// Descriptor for `GiftCardStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List giftCardStatusDescriptor = $convert.base64Decode(
    'Cg5HaWZ0Q2FyZFN0YXR1cxIfChtHSUZUQ0FSRF9TVEFUVVNfVU5TUEVDSUZJRUQQABIaChZHSU'
    'ZUQ0FSRF9TVEFUVVNfQUNUSVZFEAESGAoUR0lGVENBUkRfU1RBVFVTX1VTRUQQAhIbChdHSUZU'
    'Q0FSRF9TVEFUVVNfRVhQSVJFRBADEhsKF0dJRlRDQVJEX1NUQVRVU19QRU5ESU5HEAQSHQoZR0'
    'lGVENBUkRfU1RBVFVTX0NBTkNFTExFRBAFEiYKIkdJRlRDQVJEX1NUQVRVU19QQVJUSUFMTFlf'
    'UkVERUVNRUQQBg==');

@$core.Deprecated('Use giftCardTypeDescriptor instead')
const GiftCardType$json = {
  '1': 'GiftCardType',
  '2': [
    {'1': 'GIFTCARD_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'GIFTCARD_TYPE_DIGITAL', '2': 1},
    {'1': 'GIFTCARD_TYPE_PHYSICAL', '2': 2},
  ],
};

/// Descriptor for `GiftCardType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List giftCardTypeDescriptor = $convert.base64Decode(
    'CgxHaWZ0Q2FyZFR5cGUSHQoZR0lGVENBUkRfVFlQRV9VTlNQRUNJRklFRBAAEhkKFUdJRlRDQV'
    'JEX1RZUEVfRElHSVRBTBABEhoKFkdJRlRDQVJEX1RZUEVfUEhZU0lDQUwQAg==');

@$core.Deprecated('Use giftCardCategoryDescriptor instead')
const GiftCardCategory$json = {
  '1': 'GiftCardCategory',
  '2': [
    {'1': 'GIFTCARD_CATEGORY_UNSPECIFIED', '2': 0},
    {'1': 'GIFTCARD_CATEGORY_ENTERTAINMENT', '2': 1},
    {'1': 'GIFTCARD_CATEGORY_SHOPPING', '2': 2},
    {'1': 'GIFTCARD_CATEGORY_DINING', '2': 3},
    {'1': 'GIFTCARD_CATEGORY_TRAVEL', '2': 4},
    {'1': 'GIFTCARD_CATEGORY_GAMING', '2': 5},
    {'1': 'GIFTCARD_CATEGORY_OTHER', '2': 6},
  ],
};

/// Descriptor for `GiftCardCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List giftCardCategoryDescriptor = $convert.base64Decode(
    'ChBHaWZ0Q2FyZENhdGVnb3J5EiEKHUdJRlRDQVJEX0NBVEVHT1JZX1VOU1BFQ0lGSUVEEAASIw'
    'ofR0lGVENBUkRfQ0FURUdPUllfRU5URVJUQUlOTUVOVBABEh4KGkdJRlRDQVJEX0NBVEVHT1JZ'
    'X1NIT1BQSU5HEAISHAoYR0lGVENBUkRfQ0FURUdPUllfRElOSU5HEAMSHAoYR0lGVENBUkRfQ0'
    'FURUdPUllfVFJBVkVMEAQSHAoYR0lGVENBUkRfQ0FURUdPUllfR0FNSU5HEAUSGwoXR0lGVENB'
    'UkRfQ0FURUdPUllfT1RIRVIQBg==');

@$core.Deprecated('Use transactionTypeDescriptor instead')
const TransactionType$json = {
  '1': 'TransactionType',
  '2': [
    {'1': 'TRANSACTION_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'TRANSACTION_TYPE_PURCHASE', '2': 1},
    {'1': 'TRANSACTION_TYPE_REDEEM', '2': 2},
    {'1': 'TRANSACTION_TYPE_TRANSFER', '2': 3},
    {'1': 'TRANSACTION_TYPE_REFUND', '2': 4},
    {'1': 'TRANSACTION_TYPE_SELL', '2': 5},
  ],
};

/// Descriptor for `TransactionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transactionTypeDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2FjdGlvblR5cGUSIAocVFJBTlNBQ1RJT05fVFlQRV9VTlNQRUNJRklFRBAAEh0KGV'
    'RSQU5TQUNUSU9OX1RZUEVfUFVSQ0hBU0UQARIbChdUUkFOU0FDVElPTl9UWVBFX1JFREVFTRAC'
    'Eh0KGVRSQU5TQUNUSU9OX1RZUEVfVFJBTlNGRVIQAxIbChdUUkFOU0FDVElPTl9UWVBFX1JFRl'
    'VORBAEEhkKFVRSQU5TQUNUSU9OX1RZUEVfU0VMTBAF');

@$core.Deprecated('Use paymentMethodDescriptor instead')
const PaymentMethod$json = {
  '1': 'PaymentMethod',
  '2': [
    {'1': 'PAYMENT_METHOD_UNSPECIFIED', '2': 0},
    {'1': 'PAYMENT_METHOD_WALLET', '2': 1},
    {'1': 'PAYMENT_METHOD_CARD', '2': 2},
    {'1': 'PAYMENT_METHOD_BANK_TRANSFER', '2': 3},
    {'1': 'PAYMENT_METHOD_MOBILE_MONEY', '2': 4},
    {'1': 'PAYMENT_METHOD_CRYPTO', '2': 5},
  ],
};

/// Descriptor for `PaymentMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentMethodDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50TWV0aG9kEh4KGlBBWU1FTlRfTUVUSE9EX1VOU1BFQ0lGSUVEEAASGQoVUEFZTU'
    'VOVF9NRVRIT0RfV0FMTEVUEAESFwoTUEFZTUVOVF9NRVRIT0RfQ0FSRBACEiAKHFBBWU1FTlRf'
    'TUVUSE9EX0JBTktfVFJBTlNGRVIQAxIfChtQQVlNRU5UX01FVEhPRF9NT0JJTEVfTU9ORVkQBB'
    'IZChVQQVlNRU5UX01FVEhPRF9DUllQVE8QBQ==');

@$core.Deprecated('Use giftCardBrandDescriptor instead')
const GiftCardBrand$json = {
  '1': 'GiftCardBrand',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'category', '3': 5, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    {'1': 'discount_percentage', '3': 6, '4': 1, '5': 1, '10': 'discountPercentage'},
    {'1': 'is_popular', '3': 7, '4': 1, '5': 8, '10': 'isPopular'},
    {'1': 'available_denominations', '3': 8, '4': 3, '5': 9, '10': 'availableDenominations'},
    {'1': 'min_amount', '3': 9, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 10, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'terms_and_conditions', '3': 11, '4': 1, '5': 9, '10': 'termsAndConditions'},
    {'1': 'is_available', '3': 12, '4': 1, '5': 8, '10': 'isAvailable'},
    {'1': 'stock_count', '3': 13, '4': 1, '5': 5, '10': 'stockCount'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `GiftCardBrand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardBrandDescriptor = $convert.base64Decode(
    'Cg1HaWZ0Q2FyZEJyYW5kEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhkKCG'
    'xvZ29fdXJsGAMgASgJUgdsb2dvVXJsEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlv'
    'bhI2CghjYXRlZ29yeRgFIAEoDjIaLmdpZnRjYXJkLkdpZnRDYXJkQ2F0ZWdvcnlSCGNhdGVnb3'
    'J5Ei8KE2Rpc2NvdW50X3BlcmNlbnRhZ2UYBiABKAFSEmRpc2NvdW50UGVyY2VudGFnZRIdCgpp'
    'c19wb3B1bGFyGAcgASgIUglpc1BvcHVsYXISNwoXYXZhaWxhYmxlX2Rlbm9taW5hdGlvbnMYCC'
    'ADKAlSFmF2YWlsYWJsZURlbm9taW5hdGlvbnMSHQoKbWluX2Ftb3VudBgJIAEoAVIJbWluQW1v'
    'dW50Eh0KCm1heF9hbW91bnQYCiABKAFSCW1heEFtb3VudBIwChR0ZXJtc19hbmRfY29uZGl0aW'
    '9ucxgLIAEoCVISdGVybXNBbmRDb25kaXRpb25zEiEKDGlzX2F2YWlsYWJsZRgMIAEoCFILaXNB'
    'dmFpbGFibGUSHwoLc3RvY2tfY291bnQYDSABKAVSCnN0b2NrQ291bnQSOQoKY3JlYXRlZF9hdB'
    'gOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVk'
    'X2F0GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use giftCardDescriptor instead')
const GiftCard$json = {
  '1': 'GiftCard',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'brand_id', '3': 3, '4': 1, '5': 9, '10': 'brandId'},
    {'1': 'brand_name', '3': 4, '4': 1, '5': 9, '10': 'brandName'},
    {'1': 'logo_url', '3': 5, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'discount_percentage', '3': 7, '4': 1, '5': 1, '10': 'discountPercentage'},
    {'1': 'final_price', '3': 8, '4': 1, '5': 1, '10': 'finalPrice'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.giftcard.GiftCardStatus', '10': 'status'},
    {'1': 'type', '3': 11, '4': 1, '5': 14, '6': '.giftcard.GiftCardType', '10': 'type'},
    {'1': 'category', '3': 12, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    {'1': 'description', '3': 13, '4': 1, '5': 9, '10': 'description'},
    {'1': 'terms_and_conditions', '3': 14, '4': 1, '5': 9, '10': 'termsAndConditions'},
    {'1': 'expiry_date', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiryDate'},
    {'1': 'purchase_date', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'purchaseDate'},
    {'1': 'recipient_email', '3': 17, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 18, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'message', '3': 19, '4': 1, '5': 9, '10': 'message'},
    {'1': 'code', '3': 20, '4': 1, '5': 9, '10': 'code'},
    {'1': 'pin', '3': 21, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'is_redeemed', '3': 22, '4': 1, '5': 8, '10': 'isRedeemed'},
    {'1': 'transaction_id', '3': 23, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'available_denominations', '3': 24, '4': 3, '5': 9, '10': 'availableDenominations'},
    {'1': 'qr_code_url', '3': 25, '4': 1, '5': 9, '10': 'qrCodeUrl'},
    {'1': 'barcode_url', '3': 26, '4': 1, '5': 9, '10': 'barcodeUrl'},
    {'1': 'created_at', '3': 27, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 28, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'redeemed_at', '3': 29, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'redeemedAt'},
    {'1': 'redemption_location', '3': 30, '4': 1, '5': 9, '10': 'redemptionLocation'},
    {'1': 'remaining_balance', '3': 31, '4': 1, '5': 1, '10': 'remainingBalance'},
    {'1': 'original_amount', '3': 32, '4': 1, '5': 1, '10': 'originalAmount'},
  ],
};

/// Descriptor for `GiftCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardDescriptor = $convert.base64Decode(
    'CghHaWZ0Q2FyZBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhkKCG'
    'JyYW5kX2lkGAMgASgJUgdicmFuZElkEh0KCmJyYW5kX25hbWUYBCABKAlSCWJyYW5kTmFtZRIZ'
    'Cghsb2dvX3VybBgFIAEoCVIHbG9nb1VybBIWCgZhbW91bnQYBiABKAFSBmFtb3VudBIvChNkaX'
    'Njb3VudF9wZXJjZW50YWdlGAcgASgBUhJkaXNjb3VudFBlcmNlbnRhZ2USHwoLZmluYWxfcHJp'
    'Y2UYCCABKAFSCmZpbmFsUHJpY2USGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EjAKBnN0YX'
    'R1cxgKIAEoDjIYLmdpZnRjYXJkLkdpZnRDYXJkU3RhdHVzUgZzdGF0dXMSKgoEdHlwZRgLIAEo'
    'DjIWLmdpZnRjYXJkLkdpZnRDYXJkVHlwZVIEdHlwZRI2CghjYXRlZ29yeRgMIAEoDjIaLmdpZn'
    'RjYXJkLkdpZnRDYXJkQ2F0ZWdvcnlSCGNhdGVnb3J5EiAKC2Rlc2NyaXB0aW9uGA0gASgJUgtk'
    'ZXNjcmlwdGlvbhIwChR0ZXJtc19hbmRfY29uZGl0aW9ucxgOIAEoCVISdGVybXNBbmRDb25kaX'
    'Rpb25zEjsKC2V4cGlyeV9kYXRlGA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIK'
    'ZXhwaXJ5RGF0ZRI/Cg1wdXJjaGFzZV9kYXRlGBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbW'
    'VzdGFtcFIMcHVyY2hhc2VEYXRlEicKD3JlY2lwaWVudF9lbWFpbBgRIAEoCVIOcmVjaXBpZW50'
    'RW1haWwSJQoOcmVjaXBpZW50X25hbWUYEiABKAlSDXJlY2lwaWVudE5hbWUSGAoHbWVzc2FnZR'
    'gTIAEoCVIHbWVzc2FnZRISCgRjb2RlGBQgASgJUgRjb2RlEhAKA3BpbhgVIAEoCVIDcGluEh8K'
    'C2lzX3JlZGVlbWVkGBYgASgIUgppc1JlZGVlbWVkEiUKDnRyYW5zYWN0aW9uX2lkGBcgASgJUg'
    '10cmFuc2FjdGlvbklkEjcKF2F2YWlsYWJsZV9kZW5vbWluYXRpb25zGBggAygJUhZhdmFpbGFi'
    'bGVEZW5vbWluYXRpb25zEh4KC3FyX2NvZGVfdXJsGBkgASgJUglxckNvZGVVcmwSHwoLYmFyY2'
    '9kZV91cmwYGiABKAlSCmJhcmNvZGVVcmwSOQoKY3JlYXRlZF9hdBgbIAEoCzIaLmdvb2dsZS5w'
    'cm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBwgASgLMhouZ29vZ2'
    'xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0EjsKC3JlZGVlbWVkX2F0GB0gASgLMhou'
    'Z29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKcmVkZWVtZWRBdBIvChNyZWRlbXB0aW9uX2xvY2'
    'F0aW9uGB4gASgJUhJyZWRlbXB0aW9uTG9jYXRpb24SKwoRcmVtYWluaW5nX2JhbGFuY2UYHyAB'
    'KAFSEHJlbWFpbmluZ0JhbGFuY2USJwoPb3JpZ2luYWxfYW1vdW50GCAgASgBUg5vcmlnaW5hbE'
    'Ftb3VudA==');

@$core.Deprecated('Use giftCardTransactionDescriptor instead')
const GiftCardTransaction$json = {
  '1': 'GiftCardTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'gift_card_id', '3': 2, '4': 1, '5': 9, '10': 'giftCardId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'transaction_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    {'1': 'transaction_type', '3': 7, '4': 1, '5': 14, '6': '.giftcard.TransactionType', '10': 'transactionType'},
    {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.giftcard.GiftCardStatus', '10': 'status'},
    {'1': 'failure_reason', '3': 9, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'payment_method', '3': 10, '4': 1, '5': 14, '6': '.giftcard.PaymentMethod', '10': 'paymentMethod'},
    {'1': 'payment_reference', '3': 11, '4': 1, '5': 9, '10': 'paymentReference'},
    {'1': 'receipt_url', '3': 12, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'recipient_email', '3': 13, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 14, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `GiftCardTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List giftCardTransactionDescriptor = $convert.base64Decode(
    'ChNHaWZ0Q2FyZFRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIgCgxnaWZ0X2NhcmRfaWQYAi'
    'ABKAlSCmdpZnRDYXJkSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEhYKBmFtb3VudBgEIAEo'
    'AVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRJFChB0cmFuc2FjdGlvbl9kYX'
    'RlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25EYXRlEkQK'
    'EHRyYW5zYWN0aW9uX3R5cGUYByABKA4yGS5naWZ0Y2FyZC5UcmFuc2FjdGlvblR5cGVSD3RyYW'
    '5zYWN0aW9uVHlwZRIwCgZzdGF0dXMYCCABKA4yGC5naWZ0Y2FyZC5HaWZ0Q2FyZFN0YXR1c1IG'
    'c3RhdHVzEiUKDmZhaWx1cmVfcmVhc29uGAkgASgJUg1mYWlsdXJlUmVhc29uEj4KDnBheW1lbn'
    'RfbWV0aG9kGAogASgOMhcuZ2lmdGNhcmQuUGF5bWVudE1ldGhvZFINcGF5bWVudE1ldGhvZBIr'
    'ChFwYXltZW50X3JlZmVyZW5jZRgLIAEoCVIQcGF5bWVudFJlZmVyZW5jZRIfCgtyZWNlaXB0X3'
    'VybBgMIAEoCVIKcmVjZWlwdFVybBInCg9yZWNpcGllbnRfZW1haWwYDSABKAlSDnJlY2lwaWVu'
    'dEVtYWlsEiUKDnJlY2lwaWVudF9uYW1lGA4gASgJUg1yZWNpcGllbnROYW1lEjkKCmNyZWF0ZW'
    'RfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use statisticsDescriptor instead')
const Statistics$json = {
  '1': 'Statistics',
  '2': [
    {'1': 'total_cards', '3': 1, '4': 1, '5': 3, '10': 'totalCards'},
    {'1': 'active_cards', '3': 2, '4': 1, '5': 3, '10': 'activeCards'},
    {'1': 'used_cards', '3': 3, '4': 1, '5': 3, '10': 'usedCards'},
    {'1': 'pending_cards', '3': 4, '4': 1, '5': 3, '10': 'pendingCards'},
    {'1': 'expired_cards', '3': 5, '4': 1, '5': 3, '10': 'expiredCards'},
    {'1': 'total_value', '3': 6, '4': 1, '5': 1, '10': 'totalValue'},
    {'1': 'total_spent', '3': 7, '4': 1, '5': 1, '10': 'totalSpent'},
    {'1': 'total_saved', '3': 8, '4': 1, '5': 1, '10': 'totalSaved'},
    {'1': 'recent_cards', '3': 9, '4': 3, '5': 11, '6': '.giftcard.GiftCard', '10': 'recentCards'},
    {'1': 'recent_transactions', '3': 10, '4': 3, '5': 11, '6': '.giftcard.GiftCardTransaction', '10': 'recentTransactions'},
  ],
};

/// Descriptor for `Statistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statisticsDescriptor = $convert.base64Decode(
    'CgpTdGF0aXN0aWNzEh8KC3RvdGFsX2NhcmRzGAEgASgDUgp0b3RhbENhcmRzEiEKDGFjdGl2ZV'
    '9jYXJkcxgCIAEoA1ILYWN0aXZlQ2FyZHMSHQoKdXNlZF9jYXJkcxgDIAEoA1IJdXNlZENhcmRz'
    'EiMKDXBlbmRpbmdfY2FyZHMYBCABKANSDHBlbmRpbmdDYXJkcxIjCg1leHBpcmVkX2NhcmRzGA'
    'UgASgDUgxleHBpcmVkQ2FyZHMSHwoLdG90YWxfdmFsdWUYBiABKAFSCnRvdGFsVmFsdWUSHwoL'
    'dG90YWxfc3BlbnQYByABKAFSCnRvdGFsU3BlbnQSHwoLdG90YWxfc2F2ZWQYCCABKAFSCnRvdG'
    'FsU2F2ZWQSNQoMcmVjZW50X2NhcmRzGAkgAygLMhIuZ2lmdGNhcmQuR2lmdENhcmRSC3JlY2Vu'
    'dENhcmRzEk4KE3JlY2VudF90cmFuc2FjdGlvbnMYCiADKAsyHS5naWZ0Y2FyZC5HaWZ0Q2FyZF'
    'RyYW5zYWN0aW9uUhJyZWNlbnRUcmFuc2FjdGlvbnM=');

@$core.Deprecated('Use getBrandsRequestDescriptor instead')
const GetBrandsRequest$json = {
  '1': 'GetBrandsRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    {'1': 'popular_only', '3': 2, '4': 1, '5': 8, '10': 'popularOnly'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetBrandsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrandsRequestDescriptor = $convert.base64Decode(
    'ChBHZXRCcmFuZHNSZXF1ZXN0EjYKCGNhdGVnb3J5GAEgASgOMhouZ2lmdGNhcmQuR2lmdENhcm'
    'RDYXRlZ29yeVIIY2F0ZWdvcnkSIQoMcG9wdWxhcl9vbmx5GAIgASgIUgtwb3B1bGFyT25seRIS'
    'CgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getBrandsResponseDescriptor instead')
const GetBrandsResponse$json = {
  '1': 'GetBrandsResponse',
  '2': [
    {'1': 'brands', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCardBrand', '10': 'brands'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetBrandsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrandsResponseDescriptor = $convert.base64Decode(
    'ChFHZXRCcmFuZHNSZXNwb25zZRIvCgZicmFuZHMYASADKAsyFy5naWZ0Y2FyZC5HaWZ0Q2FyZE'
    'JyYW5kUgZicmFuZHMSFAoFdG90YWwYAiABKANSBXRvdGFsEhIKBHBhZ2UYAyABKAVSBHBhZ2US'
    'FAoFbGltaXQYBCABKAVSBWxpbWl0');

@$core.Deprecated('Use getBrandByIdRequestDescriptor instead')
const GetBrandByIdRequest$json = {
  '1': 'GetBrandByIdRequest',
  '2': [
    {'1': 'brand_id', '3': 1, '4': 1, '5': 9, '10': 'brandId'},
  ],
};

/// Descriptor for `GetBrandByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrandByIdRequestDescriptor = $convert.base64Decode(
    'ChNHZXRCcmFuZEJ5SWRSZXF1ZXN0EhkKCGJyYW5kX2lkGAEgASgJUgdicmFuZElk');

@$core.Deprecated('Use getBrandByIdResponseDescriptor instead')
const GetBrandByIdResponse$json = {
  '1': 'GetBrandByIdResponse',
  '2': [
    {'1': 'brand', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCardBrand', '10': 'brand'},
  ],
};

/// Descriptor for `GetBrandByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBrandByIdResponseDescriptor = $convert.base64Decode(
    'ChRHZXRCcmFuZEJ5SWRSZXNwb25zZRItCgVicmFuZBgBIAEoCzIXLmdpZnRjYXJkLkdpZnRDYX'
    'JkQnJhbmRSBWJyYW5k');

@$core.Deprecated('Use searchBrandsRequestDescriptor instead')
const SearchBrandsRequest$json = {
  '1': 'SearchBrandsRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'category', '3': 2, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchBrandsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchBrandsRequestDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hCcmFuZHNSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRI2CghjYXRlZ29yeR'
    'gCIAEoDjIaLmdpZnRjYXJkLkdpZnRDYXJkQ2F0ZWdvcnlSCGNhdGVnb3J5EhIKBHBhZ2UYAyAB'
    'KAVSBHBhZ2USFAoFbGltaXQYBCABKAVSBWxpbWl0');

@$core.Deprecated('Use searchBrandsResponseDescriptor instead')
const SearchBrandsResponse$json = {
  '1': 'SearchBrandsResponse',
  '2': [
    {'1': 'brands', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCardBrand', '10': 'brands'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'query', '3': 3, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `SearchBrandsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchBrandsResponseDescriptor = $convert.base64Decode(
    'ChRTZWFyY2hCcmFuZHNSZXNwb25zZRIvCgZicmFuZHMYASADKAsyFy5naWZ0Y2FyZC5HaWZ0Q2'
    'FyZEJyYW5kUgZicmFuZHMSFAoFdG90YWwYAiABKANSBXRvdGFsEhQKBXF1ZXJ5GAMgASgJUgVx'
    'dWVyeQ==');

@$core.Deprecated('Use getUserGiftCardsRequestDescriptor instead')
const GetUserGiftCardsRequest$json = {
  '1': 'GetUserGiftCardsRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.giftcard.GiftCardStatus', '10': 'status'},
    {'1': 'category', '3': 2, '4': 1, '5': 14, '6': '.giftcard.GiftCardCategory', '10': 'category'},
    {'1': 'search_query', '3': 3, '4': 1, '5': 9, '10': 'searchQuery'},
    {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserGiftCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserGiftCardsRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyR2lmdENhcmRzUmVxdWVzdBIwCgZzdGF0dXMYASABKA4yGC5naWZ0Y2FyZC5HaW'
    'Z0Q2FyZFN0YXR1c1IGc3RhdHVzEjYKCGNhdGVnb3J5GAIgASgOMhouZ2lmdGNhcmQuR2lmdENh'
    'cmRDYXRlZ29yeVIIY2F0ZWdvcnkSIQoMc2VhcmNoX3F1ZXJ5GAMgASgJUgtzZWFyY2hRdWVyeR'
    'ISCgRwYWdlGAQgASgFUgRwYWdlEhQKBWxpbWl0GAUgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getUserGiftCardsResponseDescriptor instead')
const GetUserGiftCardsResponse$json = {
  '1': 'GetUserGiftCardsResponse',
  '2': [
    {'1': 'gift_cards', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCards'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'statistics', '3': 3, '4': 1, '5': 11, '6': '.giftcard.Statistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetUserGiftCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserGiftCardsResponseDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VyR2lmdENhcmRzUmVzcG9uc2USMQoKZ2lmdF9jYXJkcxgBIAMoCzISLmdpZnRjYX'
    'JkLkdpZnRDYXJkUglnaWZ0Q2FyZHMSFAoFdG90YWwYAiABKANSBXRvdGFsEjQKCnN0YXRpc3Rp'
    'Y3MYAyABKAsyFC5naWZ0Y2FyZC5TdGF0aXN0aWNzUgpzdGF0aXN0aWNz');

@$core.Deprecated('Use getGiftCardByIdRequestDescriptor instead')
const GetGiftCardByIdRequest$json = {
  '1': 'GetGiftCardByIdRequest',
  '2': [
    {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
  ],
};

/// Descriptor for `GetGiftCardByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardByIdRequestDescriptor = $convert.base64Decode(
    'ChZHZXRHaWZ0Q2FyZEJ5SWRSZXF1ZXN0EiAKDGdpZnRfY2FyZF9pZBgBIAEoCVIKZ2lmdENhcm'
    'RJZA==');

@$core.Deprecated('Use getGiftCardByIdResponseDescriptor instead')
const GetGiftCardByIdResponse$json = {
  '1': 'GetGiftCardByIdResponse',
  '2': [
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
  ],
};

/// Descriptor for `GetGiftCardByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getGiftCardByIdResponseDescriptor = $convert.base64Decode(
    'ChdHZXRHaWZ0Q2FyZEJ5SWRSZXNwb25zZRIvCglnaWZ0X2NhcmQYASABKAsyEi5naWZ0Y2FyZC'
    '5HaWZ0Q2FyZFIIZ2lmdENhcmQ=');

@$core.Deprecated('Use purchaseGiftCardRequestDescriptor instead')
const PurchaseGiftCardRequest$json = {
  '1': 'PurchaseGiftCardRequest',
  '2': [
    {'1': 'brand_id', '3': 1, '4': 1, '5': 9, '10': 'brandId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payment_method', '3': 4, '4': 1, '5': 14, '6': '.giftcard.PaymentMethod', '10': 'paymentMethod'},
    {'1': 'recipient_email', '3': 5, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 6, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'message', '3': 7, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_for_self', '3': 8, '4': 1, '5': 8, '10': 'isForSelf'},
    {'1': 'scheduled_delivery', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scheduledDelivery'},
  ],
};

/// Descriptor for `PurchaseGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseGiftCardRequestDescriptor = $convert.base64Decode(
    'ChdQdXJjaGFzZUdpZnRDYXJkUmVxdWVzdBIZCghicmFuZF9pZBgBIAEoCVIHYnJhbmRJZBIWCg'
    'ZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSPgoOcGF5'
    'bWVudF9tZXRob2QYBCABKA4yFy5naWZ0Y2FyZC5QYXltZW50TWV0aG9kUg1wYXltZW50TWV0aG'
    '9kEicKD3JlY2lwaWVudF9lbWFpbBgFIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50'
    'X25hbWUYBiABKAlSDXJlY2lwaWVudE5hbWUSGAoHbWVzc2FnZRgHIAEoCVIHbWVzc2FnZRIeCg'
    'tpc19mb3Jfc2VsZhgIIAEoCFIJaXNGb3JTZWxmEkkKEnNjaGVkdWxlZF9kZWxpdmVyeRgJIAEo'
    'CzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEXNjaGVkdWxlZERlbGl2ZXJ5');

@$core.Deprecated('Use purchaseGiftCardResponseDescriptor instead')
const PurchaseGiftCardResponse$json = {
  '1': 'PurchaseGiftCardResponse',
  '2': [
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
    {'1': 'receipt_url', '3': 2, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PurchaseGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseGiftCardResponseDescriptor = $convert.base64Decode(
    'ChhQdXJjaGFzZUdpZnRDYXJkUmVzcG9uc2USLwoJZ2lmdF9jYXJkGAEgASgLMhIuZ2lmdGNhcm'
    'QuR2lmdENhcmRSCGdpZnRDYXJkEh8KC3JlY2VpcHRfdXJsGAIgASgJUgpyZWNlaXB0VXJsEiUK'
    'DnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklkEhgKB21lc3NhZ2UYBCABKAlSB2'
    '1lc3NhZ2U=');

@$core.Deprecated('Use validatePurchaseRequestDescriptor instead')
const ValidatePurchaseRequest$json = {
  '1': 'ValidatePurchaseRequest',
  '2': [
    {'1': 'brand_id', '3': 1, '4': 1, '5': 9, '10': 'brandId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'payment_method', '3': 3, '4': 1, '5': 14, '6': '.giftcard.PaymentMethod', '10': 'paymentMethod'},
  ],
};

/// Descriptor for `ValidatePurchaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatePurchaseRequestDescriptor = $convert.base64Decode(
    'ChdWYWxpZGF0ZVB1cmNoYXNlUmVxdWVzdBIZCghicmFuZF9pZBgBIAEoCVIHYnJhbmRJZBIWCg'
    'ZhbW91bnQYAiABKAFSBmFtb3VudBI+Cg5wYXltZW50X21ldGhvZBgDIAEoDjIXLmdpZnRjYXJk'
    'LlBheW1lbnRNZXRob2RSDXBheW1lbnRNZXRob2Q=');

@$core.Deprecated('Use validatePurchaseResponseDescriptor instead')
const ValidatePurchaseResponse$json = {
  '1': 'ValidatePurchaseResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'discount_applied', '3': 3, '4': 1, '5': 1, '10': 'discountApplied'},
    {'1': 'final_price', '3': 4, '4': 1, '5': 1, '10': 'finalPrice'},
  ],
};

/// Descriptor for `ValidatePurchaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatePurchaseResponseDescriptor = $convert.base64Decode(
    'ChhWYWxpZGF0ZVB1cmNoYXNlUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIpChBkaXNjb3VudF9hcHBsaWVkGAMgASgBUg9kaXNj'
    'b3VudEFwcGxpZWQSHwoLZmluYWxfcHJpY2UYBCABKAFSCmZpbmFsUHJpY2U=');

@$core.Deprecated('Use validateCodeRequestDescriptor instead')
const ValidateCodeRequest$json = {
  '1': 'ValidateCodeRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'pin', '3': 2, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `ValidateCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateCodeRequestDescriptor = $convert.base64Decode(
    'ChNWYWxpZGF0ZUNvZGVSZXF1ZXN0EhIKBGNvZGUYASABKAlSBGNvZGUSEAoDcGluGAIgASgJUg'
    'NwaW4=');

@$core.Deprecated('Use validateCodeResponseDescriptor instead')
const ValidateCodeResponse$json = {
  '1': 'ValidateCodeResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'is_expired', '3': 2, '4': 1, '5': 8, '10': 'isExpired'},
    {'1': 'is_redeemed', '3': 3, '4': 1, '5': 8, '10': 'isRedeemed'},
    {'1': 'gift_card', '3': 4, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ValidateCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateCodeResponseDescriptor = $convert.base64Decode(
    'ChRWYWxpZGF0ZUNvZGVSZXNwb25zZRIZCghpc192YWxpZBgBIAEoCFIHaXNWYWxpZBIdCgppc1'
    '9leHBpcmVkGAIgASgIUglpc0V4cGlyZWQSHwoLaXNfcmVkZWVtZWQYAyABKAhSCmlzUmVkZWVt'
    'ZWQSLwoJZ2lmdF9jYXJkGAQgASgLMhIuZ2lmdGNhcmQuR2lmdENhcmRSCGdpZnRDYXJkEhgKB2'
    '1lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use redeemGiftCardRequestDescriptor instead')
const RedeemGiftCardRequest$json = {
  '1': 'RedeemGiftCardRequest',
  '2': [
    {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'amount_to_redeem', '3': 4, '4': 1, '5': 1, '10': 'amountToRedeem'},
    {'1': 'location', '3': 5, '4': 1, '5': 9, '10': 'location'},
  ],
};

/// Descriptor for `RedeemGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemGiftCardRequestDescriptor = $convert.base64Decode(
    'ChVSZWRlZW1HaWZ0Q2FyZFJlcXVlc3QSIAoMZ2lmdF9jYXJkX2lkGAEgASgJUgpnaWZ0Q2FyZE'
    'lkEhIKBGNvZGUYAiABKAlSBGNvZGUSEAoDcGluGAMgASgJUgNwaW4SKAoQYW1vdW50X3RvX3Jl'
    'ZGVlbRgEIAEoAVIOYW1vdW50VG9SZWRlZW0SGgoIbG9jYXRpb24YBSABKAlSCGxvY2F0aW9u');

@$core.Deprecated('Use redeemGiftCardResponseDescriptor instead')
const RedeemGiftCardResponse$json = {
  '1': 'RedeemGiftCardResponse',
  '2': [
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
    {'1': 'redeemed_amount', '3': 2, '4': 1, '5': 1, '10': 'redeemedAmount'},
    {'1': 'remaining_balance', '3': 3, '4': 1, '5': 1, '10': 'remainingBalance'},
    {'1': 'receipt_url', '3': 4, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RedeemGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemGiftCardResponseDescriptor = $convert.base64Decode(
    'ChZSZWRlZW1HaWZ0Q2FyZFJlc3BvbnNlEi8KCWdpZnRfY2FyZBgBIAEoCzISLmdpZnRjYXJkLk'
    'dpZnRDYXJkUghnaWZ0Q2FyZBInCg9yZWRlZW1lZF9hbW91bnQYAiABKAFSDnJlZGVlbWVkQW1v'
    'dW50EisKEXJlbWFpbmluZ19iYWxhbmNlGAMgASgBUhByZW1haW5pbmdCYWxhbmNlEh8KC3JlY2'
    'VpcHRfdXJsGAQgASgJUgpyZWNlaXB0VXJsEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use checkBalanceRequestDescriptor instead')
const CheckBalanceRequest$json = {
  '1': 'CheckBalanceRequest',
  '2': [
    {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
  ],
};

/// Descriptor for `CheckBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkBalanceRequestDescriptor = $convert.base64Decode(
    'ChNDaGVja0JhbGFuY2VSZXF1ZXN0EiAKDGdpZnRfY2FyZF9pZBgBIAEoCVIKZ2lmdENhcmRJZB'
    'ISCgRjb2RlGAIgASgJUgRjb2RlEhAKA3BpbhgDIAEoCVIDcGlu');

@$core.Deprecated('Use checkBalanceResponseDescriptor instead')
const CheckBalanceResponse$json = {
  '1': 'CheckBalanceResponse',
  '2': [
    {'1': 'remaining_balance', '3': 1, '4': 1, '5': 1, '10': 'remainingBalance'},
    {'1': 'original_amount', '3': 2, '4': 1, '5': 1, '10': 'originalAmount'},
    {'1': 'redeemed_amount', '3': 3, '4': 1, '5': 1, '10': 'redeemedAmount'},
    {'1': 'last_used', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsed'},
    {'1': 'gift_card', '3': 5, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
  ],
};

/// Descriptor for `CheckBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkBalanceResponseDescriptor = $convert.base64Decode(
    'ChRDaGVja0JhbGFuY2VSZXNwb25zZRIrChFyZW1haW5pbmdfYmFsYW5jZRgBIAEoAVIQcmVtYW'
    'luaW5nQmFsYW5jZRInCg9vcmlnaW5hbF9hbW91bnQYAiABKAFSDm9yaWdpbmFsQW1vdW50EicK'
    'D3JlZGVlbWVkX2Ftb3VudBgDIAEoAVIOcmVkZWVtZWRBbW91bnQSNwoJbGFzdF91c2VkGAQgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIbGFzdFVzZWQSLwoJZ2lmdF9jYXJkGAUg'
    'ASgLMhIuZ2lmdGNhcmQuR2lmdENhcmRSCGdpZnRDYXJk');

@$core.Deprecated('Use transferGiftCardRequestDescriptor instead')
const TransferGiftCardRequest$json = {
  '1': 'TransferGiftCardRequest',
  '2': [
    {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TransferGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardRequestDescriptor = $convert.base64Decode(
    'ChdUcmFuc2ZlckdpZnRDYXJkUmVxdWVzdBIgCgxnaWZ0X2NhcmRfaWQYASABKAlSCmdpZnRDYX'
    'JkSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGll'
    'bnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use transferGiftCardResponseDescriptor instead')
const TransferGiftCardResponse$json = {
  '1': 'TransferGiftCardResponse',
  '2': [
    {'1': 'gift_card', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCard'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TransferGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferGiftCardResponseDescriptor = $convert.base64Decode(
    'ChhUcmFuc2ZlckdpZnRDYXJkUmVzcG9uc2USLwoJZ2lmdF9jYXJkGAEgASgLMhIuZ2lmdGNhcm'
    'QuR2lmdENhcmRSCGdpZnRDYXJkEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use sellGiftCardRequestDescriptor instead')
const SellGiftCardRequest$json = {
  '1': 'SellGiftCardRequest',
  '2': [
    {'1': 'gift_card_id', '3': 1, '4': 1, '5': 9, '10': 'giftCardId'},
    {'1': 'asking_price', '3': 2, '4': 1, '5': 1, '10': 'askingPrice'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `SellGiftCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardRequestDescriptor = $convert.base64Decode(
    'ChNTZWxsR2lmdENhcmRSZXF1ZXN0EiAKDGdpZnRfY2FyZF9pZBgBIAEoCVIKZ2lmdENhcmRJZB'
    'IhCgxhc2tpbmdfcHJpY2UYAiABKAFSC2Fza2luZ1ByaWNlEiAKC2Rlc2NyaXB0aW9uGAMgASgJ'
    'UgtkZXNjcmlwdGlvbg==');

@$core.Deprecated('Use sellGiftCardResponseDescriptor instead')
const SellGiftCardResponse$json = {
  '1': 'SellGiftCardResponse',
  '2': [
    {'1': 'listing_id', '3': 1, '4': 1, '5': 9, '10': 'listingId'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SellGiftCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sellGiftCardResponseDescriptor = $convert.base64Decode(
    'ChRTZWxsR2lmdENhcmRSZXNwb25zZRIdCgpsaXN0aW5nX2lkGAEgASgJUglsaXN0aW5nSWQSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getResellableCardsRequestDescriptor instead')
const GetResellableCardsRequest$json = {
  '1': 'GetResellableCardsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetResellableCardsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getResellableCardsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRSZXNlbGxhYmxlQ2FyZHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaX'
    'QYAiABKAVSBWxpbWl0');

@$core.Deprecated('Use getResellableCardsResponseDescriptor instead')
const GetResellableCardsResponse$json = {
  '1': 'GetResellableCardsResponse',
  '2': [
    {'1': 'gift_cards', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCard', '10': 'giftCards'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetResellableCardsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getResellableCardsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRSZXNlbGxhYmxlQ2FyZHNSZXNwb25zZRIxCgpnaWZ0X2NhcmRzGAEgAygLMhIuZ2lmdG'
    'NhcmQuR2lmdENhcmRSCWdpZnRDYXJkcxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');

@$core.Deprecated('Use getTransactionsRequestDescriptor instead')
const GetTransactionsRequest$json = {
  '1': 'GetTransactionsRequest',
  '2': [
    {'1': 'transaction_type', '3': 1, '4': 1, '5': 14, '6': '.giftcard.TransactionType', '10': 'transactionType'},
    {'1': 'start_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRUcmFuc2FjdGlvbnNSZXF1ZXN0EkQKEHRyYW5zYWN0aW9uX3R5cGUYASABKA4yGS5naW'
    'Z0Y2FyZC5UcmFuc2FjdGlvblR5cGVSD3RyYW5zYWN0aW9uVHlwZRI5CgpzdGFydF9kYXRlGAIg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGA'
    'MgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRISCgRwYWdlGAQgASgF'
    'UgRwYWdlEhQKBWxpbWl0GAUgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getTransactionsResponseDescriptor instead')
const GetTransactionsResponse$json = {
  '1': 'GetTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.giftcard.GiftCardTransaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRUcmFuc2FjdGlvbnNSZXNwb25zZRJBCgx0cmFuc2FjdGlvbnMYASADKAsyHS5naWZ0Y2'
    'FyZC5HaWZ0Q2FyZFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSFAoFdG90YWwYAiABKANSBXRv'
    'dGFs');

@$core.Deprecated('Use getTransactionByIdRequestDescriptor instead')
const GetTransactionByIdRequest$json = {
  '1': 'GetTransactionByIdRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetTransactionByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionByIdRequestDescriptor = $convert.base64Decode(
    'ChlHZXRUcmFuc2FjdGlvbkJ5SWRSZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cm'
    'Fuc2FjdGlvbklk');

@$core.Deprecated('Use getTransactionByIdResponseDescriptor instead')
const GetTransactionByIdResponse$json = {
  '1': 'GetTransactionByIdResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.giftcard.GiftCardTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `GetTransactionByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionByIdResponseDescriptor = $convert.base64Decode(
    'ChpHZXRUcmFuc2FjdGlvbkJ5SWRSZXNwb25zZRI/Cgt0cmFuc2FjdGlvbhgBIAEoCzIdLmdpZn'
    'RjYXJkLkdpZnRDYXJkVHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9u');

@$core.Deprecated('Use getStatisticsRequestDescriptor instead')
const GetStatisticsRequest$json = {
  '1': 'GetStatisticsRequest',
};

/// Descriptor for `GetStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatisticsRequestDescriptor = $convert.base64Decode(
    'ChRHZXRTdGF0aXN0aWNzUmVxdWVzdA==');

@$core.Deprecated('Use getStatisticsResponseDescriptor instead')
const GetStatisticsResponse$json = {
  '1': 'GetStatisticsResponse',
  '2': [
    {'1': 'statistics', '3': 1, '4': 1, '5': 11, '6': '.giftcard.Statistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStatisticsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRTdGF0aXN0aWNzUmVzcG9uc2USNAoKc3RhdGlzdGljcxgBIAEoCzIULmdpZnRjYXJkLl'
    'N0YXRpc3RpY3NSCnN0YXRpc3RpY3M=');

