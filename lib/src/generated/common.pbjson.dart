///
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use invoicePaymentStatusDescriptor instead')
const InvoicePaymentStatus$json = const {
  '1': 'InvoicePaymentStatus',
  '2': const [
    const {'1': 'INVOICE_PAYMENT_STATUS_PENDING', '2': 0},
    const {'1': 'INVOICE_PAYMENT_STATUS_PROCESSING', '2': 1},
    const {'1': 'INVOICE_PAYMENT_STATUS_COMPLETED', '2': 2},
    const {'1': 'INVOICE_PAYMENT_STATUS_FAILED', '2': 3},
    const {'1': 'INVOICE_PAYMENT_STATUS_CANCELLED', '2': 4},
    const {'1': 'INVOICE_PAYMENT_STATUS_PARTIALLY_PAID', '2': 5},
    const {'1': 'INVOICE_PAYMENT_STATUS_REFUNDED', '2': 6},
    const {'1': 'INVOICE_PAYMENT_STATUS_DISPUTED', '2': 7},
    const {'1': 'INVOICE_PAYMENT_STATUS_OVERDUE', '2': 8},
  ],
};

/// Descriptor for `InvoicePaymentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List invoicePaymentStatusDescriptor = $convert.base64Decode('ChRJbnZvaWNlUGF5bWVudFN0YXR1cxIiCh5JTlZPSUNFX1BBWU1FTlRfU1RBVFVTX1BFTkRJTkcQABIlCiFJTlZPSUNFX1BBWU1FTlRfU1RBVFVTX1BST0NFU1NJTkcQARIkCiBJTlZPSUNFX1BBWU1FTlRfU1RBVFVTX0NPTVBMRVRFRBACEiEKHUlOVk9JQ0VfUEFZTUVOVF9TVEFUVVNfRkFJTEVEEAMSJAogSU5WT0lDRV9QQVlNRU5UX1NUQVRVU19DQU5DRUxMRUQQBBIpCiVJTlZPSUNFX1BBWU1FTlRfU1RBVFVTX1BBUlRJQUxMWV9QQUlEEAUSIwofSU5WT0lDRV9QQVlNRU5UX1NUQVRVU19SRUZVTkRFRBAGEiMKH0lOVk9JQ0VfUEFZTUVOVF9TVEFUVVNfRElTUFVURUQQBxIiCh5JTlZPSUNFX1BBWU1FTlRfU1RBVFVTX09WRVJEVUUQCA==');
@$core.Deprecated('Use paymentMethodTypeDescriptor instead')
const PaymentMethodType$json = const {
  '1': 'PaymentMethodType',
  '2': const [
    const {'1': 'PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE', '2': 0},
    const {'1': 'PAYMENT_METHOD_TYPE_CREDIT_CARD', '2': 1},
    const {'1': 'PAYMENT_METHOD_TYPE_DEBIT_CARD', '2': 2},
    const {'1': 'PAYMENT_METHOD_TYPE_PAYPAL', '2': 3},
    const {'1': 'PAYMENT_METHOD_TYPE_APPLE_PAY', '2': 4},
    const {'1': 'PAYMENT_METHOD_TYPE_GOOGLE_PAY', '2': 5},
    const {'1': 'PAYMENT_METHOD_TYPE_BITCOIN', '2': 6},
    const {'1': 'PAYMENT_METHOD_TYPE_ETHEREUM', '2': 7},
    const {'1': 'PAYMENT_METHOD_TYPE_USDC', '2': 8},
    const {'1': 'PAYMENT_METHOD_TYPE_BANK_TRANSFER', '2': 9},
  ],
};

/// Descriptor for `PaymentMethodType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentMethodTypeDescriptor = $convert.base64Decode('ChFQYXltZW50TWV0aG9kVHlwZRInCiNQQVlNRU5UX01FVEhPRF9UWVBFX0FDQ09VTlRfQkFMQU5DRRAAEiMKH1BBWU1FTlRfTUVUSE9EX1RZUEVfQ1JFRElUX0NBUkQQARIiCh5QQVlNRU5UX01FVEhPRF9UWVBFX0RFQklUX0NBUkQQAhIeChpQQVlNRU5UX01FVEhPRF9UWVBFX1BBWVBBTBADEiEKHVBBWU1FTlRfTUVUSE9EX1RZUEVfQVBQTEVfUEFZEAQSIgoeUEFZTUVOVF9NRVRIT0RfVFlQRV9HT09HTEVfUEFZEAUSHwobUEFZTUVOVF9NRVRIT0RfVFlQRV9CSVRDT0lOEAYSIAocUEFZTUVOVF9NRVRIT0RfVFlQRV9FVEhFUkVVTRAHEhwKGFBBWU1FTlRfTUVUSE9EX1RZUEVfVVNEQxAIEiUKIVBBWU1FTlRfTUVUSE9EX1RZUEVfQkFOS19UUkFOU0ZFUhAJ');
@$core.Deprecated('Use accountTypeDescriptor instead')
const AccountType$json = const {
  '1': 'AccountType',
  '2': const [
    const {'1': 'ACCOUNT_TYPE_PERSONAL', '2': 0},
    const {'1': 'ACCOUNT_TYPE_SAVINGS', '2': 1},
    const {'1': 'ACCOUNT_TYPE_INVESTMENT', '2': 2},
    const {'1': 'ACCOUNT_TYPE_BUSINESS', '2': 3},
  ],
};

/// Descriptor for `AccountType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List accountTypeDescriptor = $convert.base64Decode('CgtBY2NvdW50VHlwZRIZChVBQ0NPVU5UX1RZUEVfUEVSU09OQUwQABIYChRBQ0NPVU5UX1RZUEVfU0FWSU5HUxABEhsKF0FDQ09VTlRfVFlQRV9JTlZFU1RNRU5UEAISGQoVQUNDT1VOVF9UWVBFX0JVU0lORVNTEAM=');
@$core.Deprecated('Use disputeStatusDescriptor instead')
const DisputeStatus$json = const {
  '1': 'DisputeStatus',
  '2': const [
    const {'1': 'DISPUTE_STATUS_PENDING', '2': 0},
    const {'1': 'DISPUTE_STATUS_INVESTIGATING', '2': 1},
    const {'1': 'DISPUTE_STATUS_RESOLVED', '2': 2},
    const {'1': 'DISPUTE_STATUS_REJECTED', '2': 3},
    const {'1': 'DISPUTE_STATUS_ESCALATED', '2': 4},
  ],
};

/// Descriptor for `DisputeStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List disputeStatusDescriptor = $convert.base64Decode('Cg1EaXNwdXRlU3RhdHVzEhoKFkRJU1BVVEVfU1RBVFVTX1BFTkRJTkcQABIgChxESVNQVVRFX1NUQVRVU19JTlZFU1RJR0FUSU5HEAESGwoXRElTUFVURV9TVEFUVVNfUkVTT0xWRUQQAhIbChdESVNQVVRFX1NUQVRVU19SRUpFQ1RFRBADEhwKGERJU1BVVEVfU1RBVFVTX0VTQ0FMQVRFRBAE');
@$core.Deprecated('Use invoicePriorityDescriptor instead')
const InvoicePriority$json = const {
  '1': 'InvoicePriority',
  '2': const [
    const {'1': 'INVOICE_PRIORITY_LOW', '2': 0},
    const {'1': 'INVOICE_PRIORITY_MEDIUM', '2': 1},
    const {'1': 'INVOICE_PRIORITY_HIGH', '2': 2},
    const {'1': 'INVOICE_PRIORITY_URGENT', '2': 3},
  ],
};

/// Descriptor for `InvoicePriority`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List invoicePriorityDescriptor = $convert.base64Decode('Cg9JbnZvaWNlUHJpb3JpdHkSGAoUSU5WT0lDRV9QUklPUklUWV9MT1cQABIbChdJTlZPSUNFX1BSSU9SSVRZX01FRElVTRABEhkKFUlOVk9JQ0VfUFJJT1JJVFlfSElHSBACEhsKF0lOVk9JQ0VfUFJJT1JJVFlfVVJHRU5UEAM=');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'username', '3': 6, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'role', '3': 7, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'verified', '3': 8, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'is_email_verified', '3': 9, '4': 1, '5': 8, '10': 'isEmailVerified'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'language', '3': 12, '4': 1, '5': 9, '10': 'language'},
    const {'1': 'currency', '3': 13, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'country', '3': 14, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'profile_picture', '3': 15, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgEUgJpZBIdCgpmaXJzdF9uYW1lGAIgASgJUglmaXJzdE5hbWUSGwoJbGFzdF9uYW1lGAMgASgJUghsYXN0TmFtZRIUCgVlbWFpbBgEIAEoCVIFZW1haWwSIQoMcGhvbmVfbnVtYmVyGAUgASgJUgtwaG9uZU51bWJlchIaCgh1c2VybmFtZRgGIAEoCVIIdXNlcm5hbWUSEgoEcm9sZRgHIAEoCVIEcm9sZRIaCgh2ZXJpZmllZBgIIAEoCFIIdmVyaWZpZWQSKgoRaXNfZW1haWxfdmVyaWZpZWQYCSABKAhSD2lzRW1haWxWZXJpZmllZBI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSGgoIbGFuZ3VhZ2UYDCABKAlSCGxhbmd1YWdlEhoKCGN1cnJlbmN5GA0gASgJUghjdXJyZW5jeRIYCgdjb3VudHJ5GA4gASgJUgdjb3VudHJ5EicKD3Byb2ZpbGVfcGljdHVyZRgPIAEoCVIOcHJvZmlsZVBpY3R1cmU=');
@$core.Deprecated('Use dataDescriptor instead')
const Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '9': 0, '10': 'user', '17': true},
    const {'1': 'session', '3': 2, '4': 1, '5': 11, '6': '.pb.Session', '9': 1, '10': 'session', '17': true},
  ],
  '8': const [
    const {'1': '_user'},
    const {'1': '_session'},
  ],
};

/// Descriptor for `Data`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataDescriptor = $convert.base64Decode('CgREYXRhEiEKBHVzZXIYASABKAsyCC5wYi5Vc2VySABSBHVzZXKIAQESKgoHc2Vzc2lvbhgCIAEoCzILLnBiLlNlc3Npb25IAVIHc2Vzc2lvbogBAUIHCgVfdXNlckIKCghfc2Vzc2lvbg==');
@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 4, '10': 'userId'},
    const {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    const {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    const {'1': 'access_token_expires_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'accessTokenExpiresAt'},
    const {'1': 'refresh_token_expires_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'refreshTokenExpiresAt'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode('CgdTZXNzaW9uEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgEUgZ1c2VySWQSIQoMYWNjZXNzX3Rva2VuGAMgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZXNoX3Rva2VuGAQgASgJUgxyZWZyZXNoVG9rZW4SUQoXYWNjZXNzX3Rva2VuX2V4cGlyZXNfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUhRhY2Nlc3NUb2tlbkV4cGlyZXNBdBJTChhyZWZyZXNoX3Rva2VuX2V4cGlyZXNfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUhVyZWZyZXNoVG9rZW5FeHBpcmVzQXQ=');
@$core.Deprecated('Use paginationInfoDescriptor instead')
const PaginationInfo$json = const {
  '1': 'PaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    const {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    const {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `PaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationInfoDescriptor = $convert.base64Decode('Cg5QYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbnRQYWdlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMgASgFUgp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQoIaGFzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');
