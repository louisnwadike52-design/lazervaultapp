///
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use invoicePaymentDetailsDescriptor instead')
const InvoicePaymentDetails$json = const {
  '1': 'InvoicePaymentDetails',
  '2': const [
    const {'1': 'method', '3': 1, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'method'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'card_last4', '3': 4, '4': 1, '5': 9, '10': 'cardLast4'},
    const {'1': 'account_id', '3': 5, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'metadata', '3': 7, '4': 3, '5': 11, '6': '.pb.InvoicePaymentDetails.MetadataEntry', '10': 'metadata'},
    const {'1': 'crypto_wallet_address', '3': 8, '4': 1, '5': 9, '10': 'cryptoWalletAddress'},
    const {'1': 'crypto_transaction_hash', '3': 9, '4': 1, '5': 9, '10': 'cryptoTransactionHash'},
    const {'1': 'fee_amount', '3': 10, '4': 1, '5': 1, '10': 'feeAmount'},
    const {'1': 'payment_processor', '3': 11, '4': 1, '5': 9, '10': 'paymentProcessor'},
  ],
  '3': const [InvoicePaymentDetails_MetadataEntry$json],
};

@$core.Deprecated('Use invoicePaymentDetailsDescriptor instead')
const InvoicePaymentDetails_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `InvoicePaymentDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicePaymentDetailsDescriptor = $convert.base64Decode('ChVJbnZvaWNlUGF5bWVudERldGFpbHMSLQoGbWV0aG9kGAEgASgOMhUucGIuUGF5bWVudE1ldGhvZFR5cGVSBm1ldGhvZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSHQoKY2FyZF9sYXN0NBgEIAEoCVIJY2FyZExhc3Q0Eh0KCmFjY291bnRfaWQYBSABKAlSCWFjY291bnRJZBIcCglyZWZlcmVuY2UYBiABKAlSCXJlZmVyZW5jZRJDCghtZXRhZGF0YRgHIAMoCzInLnBiLkludm9pY2VQYXltZW50RGV0YWlscy5NZXRhZGF0YUVudHJ5UghtZXRhZGF0YRIyChVjcnlwdG9fd2FsbGV0X2FkZHJlc3MYCCABKAlSE2NyeXB0b1dhbGxldEFkZHJlc3MSNgoXY3J5cHRvX3RyYW5zYWN0aW9uX2hhc2gYCSABKAlSFWNyeXB0b1RyYW5zYWN0aW9uSGFzaBIdCgpmZWVfYW1vdW50GAogASgBUglmZWVBbW91bnQSKwoRcGF5bWVudF9wcm9jZXNzb3IYCyABKAlSEHBheW1lbnRQcm9jZXNzb3IaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use invoicePaymentResultDescriptor instead')
const InvoicePaymentResult$json = const {
  '1': 'InvoicePaymentResult',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'payment_reference', '3': 3, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'status'},
    const {'1': 'processed_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processedAt'},
    const {'1': 'amount_processed', '3': 7, '4': 1, '5': 1, '10': 'amountProcessed'},
    const {'1': 'fee_amount', '3': 8, '4': 1, '5': 1, '10': 'feeAmount'},
    const {'1': 'receipt_url', '3': 9, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'confirmation_code', '3': 10, '4': 1, '5': 9, '10': 'confirmationCode'},
  ],
};

/// Descriptor for `InvoicePaymentResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicePaymentResultDescriptor = $convert.base64Decode('ChRJbnZvaWNlUGF5bWVudFJlc3VsdBIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiUKDnRyYW5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklkEisKEXBheW1lbnRfcmVmZXJlbmNlGAMgASgJUhBwYXltZW50UmVmZXJlbmNlEiMKDWVycm9yX21lc3NhZ2UYBCABKAlSDGVycm9yTWVzc2FnZRIwCgZzdGF0dXMYBSABKA4yGC5wYi5JbnZvaWNlUGF5bWVudFN0YXR1c1IGc3RhdHVzEj0KDHByb2Nlc3NlZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3Byb2Nlc3NlZEF0EikKEGFtb3VudF9wcm9jZXNzZWQYByABKAFSD2Ftb3VudFByb2Nlc3NlZBIdCgpmZWVfYW1vdW50GAggASgBUglmZWVBbW91bnQSHwoLcmVjZWlwdF91cmwYCSABKAlSCnJlY2VpcHRVcmwSKwoRY29uZmlybWF0aW9uX2NvZGUYCiABKAlSEGNvbmZpcm1hdGlvbkNvZGU=');
@$core.Deprecated('Use invoicePaymentTransactionDescriptor instead')
const InvoicePaymentTransaction$json = const {
  '1': 'InvoicePaymentTransaction',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'invoice_id', '3': 2, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_method', '3': 6, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'paymentMethod'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'status'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'processed_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processedAt'},
    const {'1': 'reference', '3': 10, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'fee_amount', '3': 12, '4': 1, '5': 1, '10': 'feeAmount'},
    const {'1': 'metadata', '3': 13, '4': 3, '5': 11, '6': '.pb.InvoicePaymentTransaction.MetadataEntry', '10': 'metadata'},
    const {'1': 'payment_processor_id', '3': 14, '4': 1, '5': 9, '10': 'paymentProcessorId'},
    const {'1': 'receipt_url', '3': 15, '4': 1, '5': 9, '10': 'receiptUrl'},
  ],
  '3': const [InvoicePaymentTransaction_MetadataEntry$json],
};

@$core.Deprecated('Use invoicePaymentTransactionDescriptor instead')
const InvoicePaymentTransaction_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `InvoicePaymentTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicePaymentTransactionDescriptor = $convert.base64Decode('ChlJbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklkEh0KCmludm9pY2VfaWQYAiABKAlSCWludm9pY2VJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EjwKDnBheW1lbnRfbWV0aG9kGAYgASgOMhUucGIuUGF5bWVudE1ldGhvZFR5cGVSDXBheW1lbnRNZXRob2QSMAoGc3RhdHVzGAcgASgOMhgucGIuSW52b2ljZVBheW1lbnRTdGF0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDHByb2Nlc3NlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3Byb2Nlc3NlZEF0EhwKCXJlZmVyZW5jZRgKIAEoCVIJcmVmZXJlbmNlEiAKC2Rlc2NyaXB0aW9uGAsgASgJUgtkZXNjcmlwdGlvbhIdCgpmZWVfYW1vdW50GAwgASgBUglmZWVBbW91bnQSRwoIbWV0YWRhdGEYDSADKAsyKy5wYi5JbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhEjAKFHBheW1lbnRfcHJvY2Vzc29yX2lkGA4gASgJUhJwYXltZW50UHJvY2Vzc29ySWQSHwoLcmVjZWlwdF91cmwYDyABKAlSCnJlY2VpcHRVcmwaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use userAccountBalanceDescriptor instead')
const UserAccountBalance$json = const {
  '1': 'UserAccountBalance',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'available_balance', '3': 3, '4': 1, '5': 1, '10': 'availableBalance'},
    const {'1': 'pending_balance', '3': 4, '4': 1, '5': 1, '10': 'pendingBalance'},
    const {'1': 'total_balance', '3': 5, '4': 1, '5': 1, '10': 'totalBalance'},
    const {'1': 'account_type', '3': 6, '4': 1, '5': 14, '6': '.pb.AccountType', '10': 'accountType'},
    const {'1': 'account_number', '3': 7, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'last_updated', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    const {'1': 'account_name', '3': 9, '4': 1, '5': 9, '10': 'accountName'},
    const {'1': 'is_primary', '3': 10, '4': 1, '5': 8, '10': 'isPrimary'},
  ],
};

/// Descriptor for `UserAccountBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userAccountBalanceDescriptor = $convert.base64Decode('ChJVc2VyQWNjb3VudEJhbGFuY2USFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhoKCGN1cnJlbmN5GAIgASgJUghjdXJyZW5jeRIrChFhdmFpbGFibGVfYmFsYW5jZRgDIAEoAVIQYXZhaWxhYmxlQmFsYW5jZRInCg9wZW5kaW5nX2JhbGFuY2UYBCABKAFSDnBlbmRpbmdCYWxhbmNlEiMKDXRvdGFsX2JhbGFuY2UYBSABKAFSDHRvdGFsQmFsYW5jZRIyCgxhY2NvdW50X3R5cGUYBiABKA4yDy5wYi5BY2NvdW50VHlwZVILYWNjb3VudFR5cGUSJQoOYWNjb3VudF9udW1iZXIYByABKAlSDWFjY291bnROdW1iZXISPQoMbGFzdF91cGRhdGVkGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFVwZGF0ZWQSIQoMYWNjb3VudF9uYW1lGAkgASgJUgthY2NvdW50TmFtZRIdCgppc19wcmltYXJ5GAogASgIUglpc1ByaW1hcnk=');
@$core.Deprecated('Use paymentMethodDescriptor instead')
const PaymentMethod$json = const {
  '1': 'PaymentMethod',
  '2': const [
    const {'1': 'method_id', '3': 1, '4': 1, '5': 9, '10': 'methodId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'type'},
    const {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'last4', '3': 5, '4': 1, '5': 9, '10': 'last4'},
    const {'1': 'brand', '3': 6, '4': 1, '5': 9, '10': 'brand'},
    const {'1': 'is_default', '3': 7, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'is_verified', '3': 8, '4': 1, '5': 8, '10': 'isVerified'},
    const {'1': 'expires_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'metadata', '3': 11, '4': 3, '5': 11, '6': '.pb.PaymentMethod.MetadataEntry', '10': 'metadata'},
    const {'1': 'billing_address', '3': 12, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
  '3': const [PaymentMethod_MetadataEntry$json],
};

@$core.Deprecated('Use paymentMethodDescriptor instead')
const PaymentMethod_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `PaymentMethod`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentMethodDescriptor = $convert.base64Decode('Cg1QYXltZW50TWV0aG9kEhsKCW1ldGhvZF9pZBgBIAEoCVIIbWV0aG9kSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEikKBHR5cGUYAyABKA4yFS5wYi5QYXltZW50TWV0aG9kVHlwZVIEdHlwZRIhCgxkaXNwbGF5X25hbWUYBCABKAlSC2Rpc3BsYXlOYW1lEhQKBWxhc3Q0GAUgASgJUgVsYXN0NBIUCgVicmFuZBgGIAEoCVIFYnJhbmQSHQoKaXNfZGVmYXVsdBgHIAEoCFIJaXNEZWZhdWx0Eh8KC2lzX3ZlcmlmaWVkGAggASgIUgppc1ZlcmlmaWVkEjkKCmV4cGlyZXNfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQSOQoKY3JlYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI7CghtZXRhZGF0YRgLIAMoCzIfLnBiLlBheW1lbnRNZXRob2QuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGESJwoPYmlsbGluZ19hZGRyZXNzGAwgASgJUg5iaWxsaW5nQWRkcmVzcxo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use cryptoWalletDescriptor instead')
const CryptoWallet$json = const {
  '1': 'CryptoWallet',
  '2': const [
    const {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'wallet_address', '3': 3, '4': 1, '5': 9, '10': 'walletAddress'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'balance', '3': 5, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'is_verified', '3': 6, '4': 1, '5': 8, '10': 'isVerified'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'last_sync', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSync'},
    const {'1': 'network', '3': 9, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'wallet_type', '3': 10, '4': 1, '5': 9, '10': 'walletType'},
  ],
};

/// Descriptor for `CryptoWallet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptoWalletDescriptor = $convert.base64Decode('CgxDcnlwdG9XYWxsZXQSGwoJd2FsbGV0X2lkGAEgASgJUgh3YWxsZXRJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOd2FsbGV0X2FkZHJlc3MYAyABKAlSDXdhbGxldEFkZHJlc3MSGgoIY3VycmVuY3kYBCABKAlSCGN1cnJlbmN5EhgKB2JhbGFuY2UYBSABKAFSB2JhbGFuY2USHwoLaXNfdmVyaWZpZWQYBiABKAhSCmlzVmVyaWZpZWQSOQoKY3JlYXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI3CglsYXN0X3N5bmMYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghsYXN0U3luYxIYCgduZXR3b3JrGAkgASgJUgduZXR3b3JrEh8KC3dhbGxldF90eXBlGAogASgJUgp3YWxsZXRUeXBl');
@$core.Deprecated('Use paymentExtensionRequestDescriptor instead')
const PaymentExtensionRequest$json = const {
  '1': 'PaymentExtensionRequest',
  '2': const [
    const {'1': 'extension_id', '3': 1, '4': 1, '5': 9, '10': 'extensionId'},
    const {'1': 'invoice_id', '3': 2, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'new_due_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'newDueDate'},
    const {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'requested_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'requestedAt'},
    const {'1': 'approved_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'approvedAt'},
    const {'1': 'approved_by', '3': 9, '4': 1, '5': 9, '10': 'approvedBy'},
    const {'1': 'rejection_reason', '3': 10, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `PaymentExtensionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentExtensionRequestDescriptor = $convert.base64Decode('ChdQYXltZW50RXh0ZW5zaW9uUmVxdWVzdBIhCgxleHRlbnNpb25faWQYASABKAlSC2V4dGVuc2lvbklkEh0KCmludm9pY2VfaWQYAiABKAlSCWludm9pY2VJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSPAoMbmV3X2R1ZV9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbmV3RHVlRGF0ZRIWCgZyZWFzb24YBSABKAlSBnJlYXNvbhIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxI9CgxyZXF1ZXN0ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtyZXF1ZXN0ZWRBdBI7CgthcHByb3ZlZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmFwcHJvdmVkQXQSHwoLYXBwcm92ZWRfYnkYCSABKAlSCmFwcHJvdmVkQnkSKQoQcmVqZWN0aW9uX3JlYXNvbhgKIAEoCVIPcmVqZWN0aW9uUmVhc29u');
@$core.Deprecated('Use paymentDisputeDescriptor instead')
const PaymentDispute$json = const {
  '1': 'PaymentDispute',
  '2': const [
    const {'1': 'dispute_id', '3': 1, '4': 1, '5': 9, '10': 'disputeId'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'invoice_id', '3': 3, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.pb.DisputeStatus', '10': 'status'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'resolved_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'resolvedAt'},
    const {'1': 'resolution', '3': 12, '4': 1, '5': 9, '10': 'resolution'},
    const {'1': 'evidence_files', '3': 13, '4': 3, '5': 9, '10': 'evidenceFiles'},
  ],
};

/// Descriptor for `PaymentDispute`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentDisputeDescriptor = $convert.base64Decode('Cg5QYXltZW50RGlzcHV0ZRIdCgpkaXNwdXRlX2lkGAEgASgJUglkaXNwdXRlSWQSJQoOdHJhbnNhY3Rpb25faWQYAiABKAlSDXRyYW5zYWN0aW9uSWQSHQoKaW52b2ljZV9pZBgDIAEoCVIJaW52b2ljZUlkEhcKB3VzZXJfaWQYBCABKAlSBnVzZXJJZBIWCgZyZWFzb24YBSABKAlSBnJlYXNvbhIgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SKQoGc3RhdHVzGAcgASgOMhEucGIuRGlzcHV0ZVN0YXR1c1IGc3RhdHVzEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeRI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjsKC3Jlc29sdmVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKcmVzb2x2ZWRBdBIeCgpyZXNvbHV0aW9uGAwgASgJUgpyZXNvbHV0aW9uEiUKDmV2aWRlbmNlX2ZpbGVzGA0gAygJUg1ldmlkZW5jZUZpbGVz');
@$core.Deprecated('Use processInvoicePaymentRequestDescriptor instead')
const ProcessInvoicePaymentRequest$json = const {
  '1': 'ProcessInvoicePaymentRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'payment_method_id', '3': 2, '4': 1, '5': 9, '10': 'paymentMethodId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 6, '4': 3, '5': 11, '6': '.pb.ProcessInvoicePaymentRequest.MetadataEntry', '10': 'metadata'},
    const {'1': 'save_payment_method', '3': 7, '4': 1, '5': 8, '10': 'savePaymentMethod'},
    const {'1': 'billing_address', '3': 8, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
  '3': const [ProcessInvoicePaymentRequest_MetadataEntry$json],
};

@$core.Deprecated('Use processInvoicePaymentRequestDescriptor instead')
const ProcessInvoicePaymentRequest_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ProcessInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processInvoicePaymentRequestDescriptor = $convert.base64Decode('ChxQcm9jZXNzSW52b2ljZVBheW1lbnRSZXF1ZXN0Eh0KCmludm9pY2VfaWQYASABKAlSCWludm9pY2VJZBIqChFwYXltZW50X21ldGhvZF9pZBgCIAEoCVIPcGF5bWVudE1ldGhvZElkEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SSgoIbWV0YWRhdGEYBiADKAsyLi5wYi5Qcm9jZXNzSW52b2ljZVBheW1lbnRSZXF1ZXN0Lk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhEi4KE3NhdmVfcGF5bWVudF9tZXRob2QYByABKAhSEXNhdmVQYXltZW50TWV0aG9kEicKD2JpbGxpbmdfYWRkcmVzcxgIIAEoCVIOYmlsbGluZ0FkZHJlc3MaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use processInvoicePaymentResponseDescriptor instead')
const ProcessInvoicePaymentResponse$json = const {
  '1': 'ProcessInvoicePaymentResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.pb.InvoicePaymentResult', '10': 'result'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'next_action', '3': 4, '4': 1, '5': 9, '10': 'nextAction'},
    const {'1': 'additional_data', '3': 5, '4': 3, '5': 11, '6': '.pb.ProcessInvoicePaymentResponse.AdditionalDataEntry', '10': 'additionalData'},
  ],
  '3': const [ProcessInvoicePaymentResponse_AdditionalDataEntry$json],
};

@$core.Deprecated('Use processInvoicePaymentResponseDescriptor instead')
const ProcessInvoicePaymentResponse_AdditionalDataEntry$json = const {
  '1': 'AdditionalDataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ProcessInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processInvoicePaymentResponseDescriptor = $convert.base64Decode('Ch1Qcm9jZXNzSW52b2ljZVBheW1lbnRSZXNwb25zZRIwCgZyZXN1bHQYASABKAsyGC5wYi5JbnZvaWNlUGF5bWVudFJlc3VsdFIGcmVzdWx0EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2VzcxIfCgtuZXh0X2FjdGlvbhgEIAEoCVIKbmV4dEFjdGlvbhJeCg9hZGRpdGlvbmFsX2RhdGEYBSADKAsyNS5wYi5Qcm9jZXNzSW52b2ljZVBheW1lbnRSZXNwb25zZS5BZGRpdGlvbmFsRGF0YUVudHJ5Ug5hZGRpdGlvbmFsRGF0YRpBChNBZGRpdGlvbmFsRGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use processPartialInvoicePaymentRequestDescriptor instead')
const ProcessPartialInvoicePaymentRequest$json = const {
  '1': 'ProcessPartialInvoicePaymentRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'payment_method_id', '3': 2, '4': 1, '5': 9, '10': 'paymentMethodId'},
    const {'1': 'partial_amount', '3': 3, '4': 1, '5': 1, '10': 'partialAmount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'metadata', '3': 6, '4': 3, '5': 11, '6': '.pb.ProcessPartialInvoicePaymentRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': const [ProcessPartialInvoicePaymentRequest_MetadataEntry$json],
};

@$core.Deprecated('Use processPartialInvoicePaymentRequestDescriptor instead')
const ProcessPartialInvoicePaymentRequest_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ProcessPartialInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPartialInvoicePaymentRequestDescriptor = $convert.base64Decode('CiNQcm9jZXNzUGFydGlhbEludm9pY2VQYXltZW50UmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSKgoRcGF5bWVudF9tZXRob2RfaWQYAiABKAlSD3BheW1lbnRNZXRob2RJZBIlCg5wYXJ0aWFsX2Ftb3VudBgDIAEoAVINcGFydGlhbEFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uElEKCG1ldGFkYXRhGAYgAygLMjUucGIuUHJvY2Vzc1BhcnRpYWxJbnZvaWNlUGF5bWVudFJlcXVlc3QuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use processPartialInvoicePaymentResponseDescriptor instead')
const ProcessPartialInvoicePaymentResponse$json = const {
  '1': 'ProcessPartialInvoicePaymentResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.pb.InvoicePaymentResult', '10': 'result'},
    const {'1': 'remaining_amount', '3': 2, '4': 1, '5': 1, '10': 'remainingAmount'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'success', '3': 4, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ProcessPartialInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPartialInvoicePaymentResponseDescriptor = $convert.base64Decode('CiRQcm9jZXNzUGFydGlhbEludm9pY2VQYXltZW50UmVzcG9uc2USMAoGcmVzdWx0GAEgASgLMhgucGIuSW52b2ljZVBheW1lbnRSZXN1bHRSBnJlc3VsdBIpChByZW1haW5pbmdfYW1vdW50GAIgASgBUg9yZW1haW5pbmdBbW91bnQSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRIYCgdzdWNjZXNzGAQgASgIUgdzdWNjZXNz');
@$core.Deprecated('Use validateInvoicePaymentRequestDescriptor instead')
const ValidateInvoicePaymentRequest$json = const {
  '1': 'ValidateInvoicePaymentRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'payment_method_id', '3': 2, '4': 1, '5': 9, '10': 'paymentMethodId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `ValidateInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoicePaymentRequestDescriptor = $convert.base64Decode('Ch1WYWxpZGF0ZUludm9pY2VQYXltZW50UmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSKgoRcGF5bWVudF9tZXRob2RfaWQYAiABKAlSD3BheW1lbnRNZXRob2RJZBIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use validateInvoicePaymentResponseDescriptor instead')
const ValidateInvoicePaymentResponse$json = const {
  '1': 'ValidateInvoicePaymentResponse',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'validation_message', '3': 2, '4': 1, '5': 9, '10': 'validationMessage'},
    const {'1': 'errors', '3': 3, '4': 3, '5': 9, '10': 'errors'},
    const {'1': 'available_balance', '3': 4, '4': 1, '5': 1, '10': 'availableBalance'},
    const {'1': 'payment_fees', '3': 5, '4': 1, '5': 1, '10': 'paymentFees'},
  ],
};

/// Descriptor for `ValidateInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoicePaymentResponseDescriptor = $convert.base64Decode('Ch5WYWxpZGF0ZUludm9pY2VQYXltZW50UmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSLQoSdmFsaWRhdGlvbl9tZXNzYWdlGAIgASgJUhF2YWxpZGF0aW9uTWVzc2FnZRIWCgZlcnJvcnMYAyADKAlSBmVycm9ycxIrChFhdmFpbGFibGVfYmFsYW5jZRgEIAEoAVIQYXZhaWxhYmxlQmFsYW5jZRIhCgxwYXltZW50X2ZlZXMYBSABKAFSC3BheW1lbnRGZWVz');
@$core.Deprecated('Use getInvoicePaymentStatusRequestDescriptor instead')
const GetInvoicePaymentStatusRequest$json = const {
  '1': 'GetInvoicePaymentStatusRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetInvoicePaymentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentStatusRequestDescriptor = $convert.base64Decode('Ch5HZXRJbnZvaWNlUGF5bWVudFN0YXR1c1JlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use getInvoicePaymentStatusResponseDescriptor instead')
const GetInvoicePaymentStatusResponse$json = const {
  '1': 'GetInvoicePaymentStatusResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.pb.InvoicePaymentTransaction', '10': 'transaction'},
    const {'1': 'current_status', '3': 2, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'currentStatus'},
    const {'1': 'status_message', '3': 3, '4': 1, '5': 9, '10': 'statusMessage'},
    const {'1': 'last_updated', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
  ],
};

/// Descriptor for `GetInvoicePaymentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentStatusResponseDescriptor = $convert.base64Decode('Ch9HZXRJbnZvaWNlUGF5bWVudFN0YXR1c1Jlc3BvbnNlEj8KC3RyYW5zYWN0aW9uGAEgASgLMh0ucGIuSW52b2ljZVBheW1lbnRUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24SPwoOY3VycmVudF9zdGF0dXMYAiABKA4yGC5wYi5JbnZvaWNlUGF5bWVudFN0YXR1c1INY3VycmVudFN0YXR1cxIlCg5zdGF0dXNfbWVzc2FnZRgDIAEoCVINc3RhdHVzTWVzc2FnZRI9CgxsYXN0X3VwZGF0ZWQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsYXN0VXBkYXRlZA==');
@$core.Deprecated('Use cancelInvoicePaymentRequestDescriptor instead')
const CancelInvoicePaymentRequest$json = const {
  '1': 'CancelInvoicePaymentRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoicePaymentRequestDescriptor = $convert.base64Decode('ChtDYW5jZWxJbnZvaWNlUGF5bWVudFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');
@$core.Deprecated('Use cancelInvoicePaymentResponseDescriptor instead')
const CancelInvoicePaymentResponse$json = const {
  '1': 'CancelInvoicePaymentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'new_status', '3': 3, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'newStatus'},
    const {'1': 'refund_amount', '3': 4, '4': 1, '5': 1, '10': 'refundAmount'},
  ],
};

/// Descriptor for `CancelInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoicePaymentResponseDescriptor = $convert.base64Decode('ChxDYW5jZWxJbnZvaWNlUGF5bWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI3CgpuZXdfc3RhdHVzGAMgASgOMhgucGIuSW52b2ljZVBheW1lbnRTdGF0dXNSCW5ld1N0YXR1cxIjCg1yZWZ1bmRfYW1vdW50GAQgASgBUgxyZWZ1bmRBbW91bnQ=');
@$core.Deprecated('Use getUserInvoicePaymentMethodsRequestDescriptor instead')
const GetUserInvoicePaymentMethodsRequest$json = const {
  '1': 'GetUserInvoicePaymentMethodsRequest',
  '2': const [
    const {'1': 'type_filter', '3': 1, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'typeFilter'},
  ],
};

/// Descriptor for `GetUserInvoicePaymentMethodsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInvoicePaymentMethodsRequestDescriptor = $convert.base64Decode('CiNHZXRVc2VySW52b2ljZVBheW1lbnRNZXRob2RzUmVxdWVzdBI2Cgt0eXBlX2ZpbHRlchgBIAEoDjIVLnBiLlBheW1lbnRNZXRob2RUeXBlUgp0eXBlRmlsdGVy');
@$core.Deprecated('Use getUserInvoicePaymentMethodsResponseDescriptor instead')
const GetUserInvoicePaymentMethodsResponse$json = const {
  '1': 'GetUserInvoicePaymentMethodsResponse',
  '2': const [
    const {'1': 'payment_methods', '3': 1, '4': 3, '5': 11, '6': '.pb.PaymentMethod', '10': 'paymentMethods'},
    const {'1': 'default_method', '3': 2, '4': 1, '5': 11, '6': '.pb.PaymentMethod', '10': 'defaultMethod'},
  ],
};

/// Descriptor for `GetUserInvoicePaymentMethodsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInvoicePaymentMethodsResponseDescriptor = $convert.base64Decode('CiRHZXRVc2VySW52b2ljZVBheW1lbnRNZXRob2RzUmVzcG9uc2USOgoPcGF5bWVudF9tZXRob2RzGAEgAygLMhEucGIuUGF5bWVudE1ldGhvZFIOcGF5bWVudE1ldGhvZHMSOAoOZGVmYXVsdF9tZXRob2QYAiABKAsyES5wYi5QYXltZW50TWV0aG9kUg1kZWZhdWx0TWV0aG9k');
@$core.Deprecated('Use addInvoicePaymentMethodRequestDescriptor instead')
const AddInvoicePaymentMethodRequest$json = const {
  '1': 'AddInvoicePaymentMethodRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'type'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'payment_details', '3': 3, '4': 3, '5': 11, '6': '.pb.AddInvoicePaymentMethodRequest.PaymentDetailsEntry', '10': 'paymentDetails'},
    const {'1': 'set_as_default', '3': 4, '4': 1, '5': 8, '10': 'setAsDefault'},
    const {'1': 'billing_address', '3': 5, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
  '3': const [AddInvoicePaymentMethodRequest_PaymentDetailsEntry$json],
};

@$core.Deprecated('Use addInvoicePaymentMethodRequestDescriptor instead')
const AddInvoicePaymentMethodRequest_PaymentDetailsEntry$json = const {
  '1': 'PaymentDetailsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `AddInvoicePaymentMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addInvoicePaymentMethodRequestDescriptor = $convert.base64Decode('Ch5BZGRJbnZvaWNlUGF5bWVudE1ldGhvZFJlcXVlc3QSKQoEdHlwZRgBIAEoDjIVLnBiLlBheW1lbnRNZXRob2RUeXBlUgR0eXBlEiEKDGRpc3BsYXlfbmFtZRgCIAEoCVILZGlzcGxheU5hbWUSXwoPcGF5bWVudF9kZXRhaWxzGAMgAygLMjYucGIuQWRkSW52b2ljZVBheW1lbnRNZXRob2RSZXF1ZXN0LlBheW1lbnREZXRhaWxzRW50cnlSDnBheW1lbnREZXRhaWxzEiQKDnNldF9hc19kZWZhdWx0GAQgASgIUgxzZXRBc0RlZmF1bHQSJwoPYmlsbGluZ19hZGRyZXNzGAUgASgJUg5iaWxsaW5nQWRkcmVzcxpBChNQYXltZW50RGV0YWlsc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use addInvoicePaymentMethodResponseDescriptor instead')
const AddInvoicePaymentMethodResponse$json = const {
  '1': 'AddInvoicePaymentMethodResponse',
  '2': const [
    const {'1': 'payment_method', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentMethod', '10': 'paymentMethod'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'verification_url', '3': 4, '4': 1, '5': 9, '10': 'verificationUrl'},
  ],
};

/// Descriptor for `AddInvoicePaymentMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addInvoicePaymentMethodResponseDescriptor = $convert.base64Decode('Ch9BZGRJbnZvaWNlUGF5bWVudE1ldGhvZFJlc3BvbnNlEjgKDnBheW1lbnRfbWV0aG9kGAEgASgLMhEucGIuUGF5bWVudE1ldGhvZFINcGF5bWVudE1ldGhvZBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USKQoQdmVyaWZpY2F0aW9uX3VybBgEIAEoCVIPdmVyaWZpY2F0aW9uVXJs');
@$core.Deprecated('Use removeInvoicePaymentMethodRequestDescriptor instead')
const RemoveInvoicePaymentMethodRequest$json = const {
  '1': 'RemoveInvoicePaymentMethodRequest',
  '2': const [
    const {'1': 'method_id', '3': 1, '4': 1, '5': 9, '10': 'methodId'},
  ],
};

/// Descriptor for `RemoveInvoicePaymentMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeInvoicePaymentMethodRequestDescriptor = $convert.base64Decode('CiFSZW1vdmVJbnZvaWNlUGF5bWVudE1ldGhvZFJlcXVlc3QSGwoJbWV0aG9kX2lkGAEgASgJUghtZXRob2RJZA==');
@$core.Deprecated('Use removeInvoicePaymentMethodResponseDescriptor instead')
const RemoveInvoicePaymentMethodResponse$json = const {
  '1': 'RemoveInvoicePaymentMethodResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemoveInvoicePaymentMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeInvoicePaymentMethodResponseDescriptor = $convert.base64Decode('CiJSZW1vdmVJbnZvaWNlUGF5bWVudE1ldGhvZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use validateInvoicePaymentMethodRequestDescriptor instead')
const ValidateInvoicePaymentMethodRequest$json = const {
  '1': 'ValidateInvoicePaymentMethodRequest',
  '2': const [
    const {'1': 'method_id', '3': 1, '4': 1, '5': 9, '10': 'methodId'},
    const {'1': 'test_amount', '3': 2, '4': 1, '5': 1, '10': 'testAmount'},
  ],
};

/// Descriptor for `ValidateInvoicePaymentMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoicePaymentMethodRequestDescriptor = $convert.base64Decode('CiNWYWxpZGF0ZUludm9pY2VQYXltZW50TWV0aG9kUmVxdWVzdBIbCgltZXRob2RfaWQYASABKAlSCG1ldGhvZElkEh8KC3Rlc3RfYW1vdW50GAIgASgBUgp0ZXN0QW1vdW50');
@$core.Deprecated('Use validateInvoicePaymentMethodResponseDescriptor instead')
const ValidateInvoicePaymentMethodResponse$json = const {
  '1': 'ValidateInvoicePaymentMethodResponse',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'validation_message', '3': 2, '4': 1, '5': 9, '10': 'validationMessage'},
    const {'1': 'validated_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'validatedAt'},
  ],
};

/// Descriptor for `ValidateInvoicePaymentMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoicePaymentMethodResponseDescriptor = $convert.base64Decode('CiRWYWxpZGF0ZUludm9pY2VQYXltZW50TWV0aG9kUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSLQoSdmFsaWRhdGlvbl9tZXNzYWdlGAIgASgJUhF2YWxpZGF0aW9uTWVzc2FnZRI9Cgx2YWxpZGF0ZWRfYXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgt2YWxpZGF0ZWRBdA==');
@$core.Deprecated('Use updateInvoicePaymentMethodRequestDescriptor instead')
const UpdateInvoicePaymentMethodRequest$json = const {
  '1': 'UpdateInvoicePaymentMethodRequest',
  '2': const [
    const {'1': 'method_id', '3': 1, '4': 1, '5': 9, '10': 'methodId'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'is_default', '3': 3, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'billing_address', '3': 4, '4': 1, '5': 9, '10': 'billingAddress'},
    const {'1': 'metadata', '3': 5, '4': 3, '5': 11, '6': '.pb.UpdateInvoicePaymentMethodRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': const [UpdateInvoicePaymentMethodRequest_MetadataEntry$json],
};

@$core.Deprecated('Use updateInvoicePaymentMethodRequestDescriptor instead')
const UpdateInvoicePaymentMethodRequest_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `UpdateInvoicePaymentMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoicePaymentMethodRequestDescriptor = $convert.base64Decode('CiFVcGRhdGVJbnZvaWNlUGF5bWVudE1ldGhvZFJlcXVlc3QSGwoJbWV0aG9kX2lkGAEgASgJUghtZXRob2RJZBIhCgxkaXNwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEh0KCmlzX2RlZmF1bHQYAyABKAhSCWlzRGVmYXVsdBInCg9iaWxsaW5nX2FkZHJlc3MYBCABKAlSDmJpbGxpbmdBZGRyZXNzEk8KCG1ldGFkYXRhGAUgAygLMjMucGIuVXBkYXRlSW52b2ljZVBheW1lbnRNZXRob2RSZXF1ZXN0Lk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use updateInvoicePaymentMethodResponseDescriptor instead')
const UpdateInvoicePaymentMethodResponse$json = const {
  '1': 'UpdateInvoicePaymentMethodResponse',
  '2': const [
    const {'1': 'payment_method', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentMethod', '10': 'paymentMethod'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInvoicePaymentMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoicePaymentMethodResponseDescriptor = $convert.base64Decode('CiJVcGRhdGVJbnZvaWNlUGF5bWVudE1ldGhvZFJlc3BvbnNlEjgKDnBheW1lbnRfbWV0aG9kGAEgASgLMhEucGIuUGF5bWVudE1ldGhvZFINcGF5bWVudE1ldGhvZBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getUserAccountBalanceRequestDescriptor instead')
const GetUserAccountBalanceRequest$json = const {
  '1': 'GetUserAccountBalanceRequest',
  '2': const [
    const {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'account_type', '3': 2, '4': 1, '5': 14, '6': '.pb.AccountType', '10': 'accountType'},
  ],
};

/// Descriptor for `GetUserAccountBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountBalanceRequestDescriptor = $convert.base64Decode('ChxHZXRVc2VyQWNjb3VudEJhbGFuY2VSZXF1ZXN0EhoKCGN1cnJlbmN5GAEgASgJUghjdXJyZW5jeRIyCgxhY2NvdW50X3R5cGUYAiABKA4yDy5wYi5BY2NvdW50VHlwZVILYWNjb3VudFR5cGU=');
@$core.Deprecated('Use getUserAccountBalanceResponseDescriptor instead')
const GetUserAccountBalanceResponse$json = const {
  '1': 'GetUserAccountBalanceResponse',
  '2': const [
    const {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.pb.UserAccountBalance', '10': 'accounts'},
    const {'1': 'total_balance', '3': 2, '4': 1, '5': 1, '10': 'totalBalance'},
    const {'1': 'primary_currency', '3': 3, '4': 1, '5': 9, '10': 'primaryCurrency'},
  ],
};

/// Descriptor for `GetUserAccountBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountBalanceResponseDescriptor = $convert.base64Decode('Ch1HZXRVc2VyQWNjb3VudEJhbGFuY2VSZXNwb25zZRIyCghhY2NvdW50cxgBIAMoCzIWLnBiLlVzZXJBY2NvdW50QmFsYW5jZVIIYWNjb3VudHMSIwoNdG90YWxfYmFsYW5jZRgCIAEoAVIMdG90YWxCYWxhbmNlEikKEHByaW1hcnlfY3VycmVuY3kYAyABKAlSD3ByaW1hcnlDdXJyZW5jeQ==');
@$core.Deprecated('Use getAccountBalanceHistoryRequestDescriptor instead')
const GetAccountBalanceHistoryRequest$json = const {
  '1': 'GetAccountBalanceHistoryRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 5, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `GetAccountBalanceHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountBalanceHistoryRequestDescriptor = $convert.base64Decode('Ch9HZXRBY2NvdW50QmFsYW5jZUhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBI5CgpzdGFydF9kYXRlGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRIbCglwYWdlX3NpemUYBCABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YBSABKAlSCXBhZ2VUb2tlbg==');
@$core.Deprecated('Use getAccountBalanceHistoryResponseDescriptor instead')
const GetAccountBalanceHistoryResponse$json = const {
  '1': 'GetAccountBalanceHistoryResponse',
  '2': const [
    const {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.pb.BalanceHistoryEntry', '10': 'entries'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `GetAccountBalanceHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountBalanceHistoryResponseDescriptor = $convert.base64Decode('CiBHZXRBY2NvdW50QmFsYW5jZUhpc3RvcnlSZXNwb25zZRIxCgdlbnRyaWVzGAEgAygLMhcucGIuQmFsYW5jZUhpc3RvcnlFbnRyeVIHZW50cmllcxImCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4=');
@$core.Deprecated('Use balanceHistoryEntryDescriptor instead')
const BalanceHistoryEntry$json = const {
  '1': 'BalanceHistoryEntry',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    const {'1': 'balance', '3': 2, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'change_amount', '3': 3, '4': 1, '5': 1, '10': 'changeAmount'},
    const {'1': 'transaction_type', '3': 4, '4': 1, '5': 9, '10': 'transactionType'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `BalanceHistoryEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceHistoryEntryDescriptor = $convert.base64Decode('ChNCYWxhbmNlSGlzdG9yeUVudHJ5EjgKCXRpbWVzdGFtcBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBIYCgdiYWxhbmNlGAIgASgBUgdiYWxhbmNlEiMKDWNoYW5nZV9hbW91bnQYAyABKAFSDGNoYW5nZUFtb3VudBIpChB0cmFuc2FjdGlvbl90eXBlGAQgASgJUg90cmFuc2FjdGlvblR5cGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEhwKCXJlZmVyZW5jZRgGIAEoCVIJcmVmZXJlbmNl');
@$core.Deprecated('Use transferFundsForInvoicePaymentRequestDescriptor instead')
const TransferFundsForInvoicePaymentRequest$json = const {
  '1': 'TransferFundsForInvoicePaymentRequest',
  '2': const [
    const {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    const {'1': 'to_account_id', '3': 2, '4': 1, '5': 9, '10': 'toAccountId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'invoice_id', '3': 5, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `TransferFundsForInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferFundsForInvoicePaymentRequestDescriptor = $convert.base64Decode('CiVUcmFuc2ZlckZ1bmRzRm9ySW52b2ljZVBheW1lbnRSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF9pZBgBIAEoCVINZnJvbUFjY291bnRJZBIiCg10b19hY2NvdW50X2lkGAIgASgJUgt0b0FjY291bnRJZBIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3kSHQoKaW52b2ljZV9pZBgFIAEoCVIJaW52b2ljZUlkEiAKC2Rlc2NyaXB0aW9uGAYgASgJUgtkZXNjcmlwdGlvbg==');
@$core.Deprecated('Use transferFundsForInvoicePaymentResponseDescriptor instead')
const TransferFundsForInvoicePaymentResponse$json = const {
  '1': 'TransferFundsForInvoicePaymentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
  ],
};

/// Descriptor for `TransferFundsForInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferFundsForInvoicePaymentResponseDescriptor = $convert.base64Decode('CiZUcmFuc2ZlckZ1bmRzRm9ySW52b2ljZVBheW1lbnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiUKDnRyYW5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklkEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USHwoLbmV3X2JhbGFuY2UYBCABKAFSCm5ld0JhbGFuY2U=');
@$core.Deprecated('Use processCryptoInvoicePaymentRequestDescriptor instead')
const ProcessCryptoInvoicePaymentRequest$json = const {
  '1': 'ProcessCryptoInvoicePaymentRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'wallet_address', '3': 2, '4': 1, '5': 9, '10': 'walletAddress'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_hash', '3': 5, '4': 1, '5': 9, '10': 'transactionHash'},
    const {'1': 'network', '3': 6, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `ProcessCryptoInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processCryptoInvoicePaymentRequestDescriptor = $convert.base64Decode('CiJQcm9jZXNzQ3J5cHRvSW52b2ljZVBheW1lbnRSZXF1ZXN0Eh0KCmludm9pY2VfaWQYASABKAlSCWludm9pY2VJZBIlCg53YWxsZXRfYWRkcmVzcxgCIAEoCVINd2FsbGV0QWRkcmVzcxIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSKQoQdHJhbnNhY3Rpb25faGFzaBgFIAEoCVIPdHJhbnNhY3Rpb25IYXNoEhgKB25ldHdvcmsYBiABKAlSB25ldHdvcms=');
@$core.Deprecated('Use processCryptoInvoicePaymentResponseDescriptor instead')
const ProcessCryptoInvoicePaymentResponse$json = const {
  '1': 'ProcessCryptoInvoicePaymentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'confirmation_status', '3': 3, '4': 1, '5': 9, '10': 'confirmationStatus'},
    const {'1': 'confirmations_required', '3': 4, '4': 1, '5': 5, '10': 'confirmationsRequired'},
    const {'1': 'current_confirmations', '3': 5, '4': 1, '5': 5, '10': 'currentConfirmations'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessCryptoInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processCryptoInvoicePaymentResponseDescriptor = $convert.base64Decode('CiNQcm9jZXNzQ3J5cHRvSW52b2ljZVBheW1lbnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiUKDnRyYW5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklkEi8KE2NvbmZpcm1hdGlvbl9zdGF0dXMYAyABKAlSEmNvbmZpcm1hdGlvblN0YXR1cxI1ChZjb25maXJtYXRpb25zX3JlcXVpcmVkGAQgASgFUhVjb25maXJtYXRpb25zUmVxdWlyZWQSMwoVY3VycmVudF9jb25maXJtYXRpb25zGAUgASgFUhRjdXJyZW50Q29uZmlybWF0aW9ucxIYCgdtZXNzYWdlGAYgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getCryptoWalletBalanceRequestDescriptor instead')
const GetCryptoWalletBalanceRequest$json = const {
  '1': 'GetCryptoWalletBalanceRequest',
  '2': const [
    const {'1': 'wallet_address', '3': 1, '4': 1, '5': 9, '10': 'walletAddress'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetCryptoWalletBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoWalletBalanceRequestDescriptor = $convert.base64Decode('Ch1HZXRDcnlwdG9XYWxsZXRCYWxhbmNlUmVxdWVzdBIlCg53YWxsZXRfYWRkcmVzcxgBIAEoCVINd2FsbGV0QWRkcmVzcxIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3kSGAoHbmV0d29yaxgDIAEoCVIHbmV0d29yaw==');
@$core.Deprecated('Use getCryptoWalletBalanceResponseDescriptor instead')
const GetCryptoWalletBalanceResponse$json = const {
  '1': 'GetCryptoWalletBalanceResponse',
  '2': const [
    const {'1': 'balance', '3': 1, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'last_updated', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    const {'1': 'network', '3': 4, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetCryptoWalletBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoWalletBalanceResponseDescriptor = $convert.base64Decode('Ch5HZXRDcnlwdG9XYWxsZXRCYWxhbmNlUmVzcG9uc2USGAoHYmFsYW5jZRgBIAEoAVIHYmFsYW5jZRIaCghjdXJyZW5jeRgCIAEoCVIIY3VycmVuY3kSPQoMbGFzdF91cGRhdGVkGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFVwZGF0ZWQSGAoHbmV0d29yaxgEIAEoCVIHbmV0d29yaw==');
@$core.Deprecated('Use validateCryptoWalletRequestDescriptor instead')
const ValidateCryptoWalletRequest$json = const {
  '1': 'ValidateCryptoWalletRequest',
  '2': const [
    const {'1': 'wallet_address', '3': 1, '4': 1, '5': 9, '10': 'walletAddress'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `ValidateCryptoWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateCryptoWalletRequestDescriptor = $convert.base64Decode('ChtWYWxpZGF0ZUNyeXB0b1dhbGxldFJlcXVlc3QSJQoOd2FsbGV0X2FkZHJlc3MYASABKAlSDXdhbGxldEFkZHJlc3MSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EhgKB25ldHdvcmsYAyABKAlSB25ldHdvcms=');
@$core.Deprecated('Use validateCryptoWalletResponseDescriptor instead')
const ValidateCryptoWalletResponse$json = const {
  '1': 'ValidateCryptoWalletResponse',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'validation_message', '3': 2, '4': 1, '5': 9, '10': 'validationMessage'},
    const {'1': 'is_contract', '3': 3, '4': 1, '5': 8, '10': 'isContract'},
    const {'1': 'wallet_type', '3': 4, '4': 1, '5': 9, '10': 'walletType'},
  ],
};

/// Descriptor for `ValidateCryptoWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateCryptoWalletResponseDescriptor = $convert.base64Decode('ChxWYWxpZGF0ZUNyeXB0b1dhbGxldFJlc3BvbnNlEhkKCGlzX3ZhbGlkGAEgASgIUgdpc1ZhbGlkEi0KEnZhbGlkYXRpb25fbWVzc2FnZRgCIAEoCVIRdmFsaWRhdGlvbk1lc3NhZ2USHwoLaXNfY29udHJhY3QYAyABKAhSCmlzQ29udHJhY3QSHwoLd2FsbGV0X3R5cGUYBCABKAlSCndhbGxldFR5cGU=');
@$core.Deprecated('Use getCryptoInvoicePaymentStatusRequestDescriptor instead')
const GetCryptoInvoicePaymentStatusRequest$json = const {
  '1': 'GetCryptoInvoicePaymentStatusRequest',
  '2': const [
    const {'1': 'transaction_hash', '3': 1, '4': 1, '5': 9, '10': 'transactionHash'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetCryptoInvoicePaymentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoInvoicePaymentStatusRequestDescriptor = $convert.base64Decode('CiRHZXRDcnlwdG9JbnZvaWNlUGF5bWVudFN0YXR1c1JlcXVlc3QSKQoQdHJhbnNhY3Rpb25faGFzaBgBIAEoCVIPdHJhbnNhY3Rpb25IYXNoEhgKB25ldHdvcmsYAiABKAlSB25ldHdvcms=');
@$core.Deprecated('Use getCryptoInvoicePaymentStatusResponseDescriptor instead')
const GetCryptoInvoicePaymentStatusResponse$json = const {
  '1': 'GetCryptoInvoicePaymentStatusResponse',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'confirmations', '3': 2, '4': 1, '5': 5, '10': 'confirmations'},
    const {'1': 'required_confirmations', '3': 3, '4': 1, '5': 5, '10': 'requiredConfirmations'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'timestamp', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `GetCryptoInvoicePaymentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoInvoicePaymentStatusResponseDescriptor = $convert.base64Decode('CiVHZXRDcnlwdG9JbnZvaWNlUGF5bWVudFN0YXR1c1Jlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEiQKDWNvbmZpcm1hdGlvbnMYAiABKAVSDWNvbmZpcm1hdGlvbnMSNQoWcmVxdWlyZWRfY29uZmlybWF0aW9ucxgDIAEoBVIVcmVxdWlyZWRDb25maXJtYXRpb25zEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRI4Cgl0aW1lc3RhbXAYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use requestInvoicePaymentExtensionRequestDescriptor instead')
const RequestInvoicePaymentExtensionRequest$json = const {
  '1': 'RequestInvoicePaymentExtensionRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'new_due_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'newDueDate'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'justification', '3': 4, '4': 1, '5': 9, '10': 'justification'},
  ],
};

/// Descriptor for `RequestInvoicePaymentExtensionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestInvoicePaymentExtensionRequestDescriptor = $convert.base64Decode('CiVSZXF1ZXN0SW52b2ljZVBheW1lbnRFeHRlbnNpb25SZXF1ZXN0Eh0KCmludm9pY2VfaWQYASABKAlSCWludm9pY2VJZBI8CgxuZXdfZHVlX2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpuZXdEdWVEYXRlEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29uEiQKDWp1c3RpZmljYXRpb24YBCABKAlSDWp1c3RpZmljYXRpb24=');
@$core.Deprecated('Use requestInvoicePaymentExtensionResponseDescriptor instead')
const RequestInvoicePaymentExtensionResponse$json = const {
  '1': 'RequestInvoicePaymentExtensionResponse',
  '2': const [
    const {'1': 'extension_request', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentExtensionRequest', '10': 'extensionRequest'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'request_id', '3': 4, '4': 1, '5': 9, '10': 'requestId'},
  ],
};

/// Descriptor for `RequestInvoicePaymentExtensionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestInvoicePaymentExtensionResponseDescriptor = $convert.base64Decode('CiZSZXF1ZXN0SW52b2ljZVBheW1lbnRFeHRlbnNpb25SZXNwb25zZRJIChFleHRlbnNpb25fcmVxdWVzdBgBIAEoCzIbLnBiLlBheW1lbnRFeHRlbnNpb25SZXF1ZXN0UhBleHRlbnNpb25SZXF1ZXN0EhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRIdCgpyZXF1ZXN0X2lkGAQgASgJUglyZXF1ZXN0SWQ=');
@$core.Deprecated('Use approveInvoicePaymentExtensionRequestDescriptor instead')
const ApproveInvoicePaymentExtensionRequest$json = const {
  '1': 'ApproveInvoicePaymentExtensionRequest',
  '2': const [
    const {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    const {'1': 'approved', '3': 2, '4': 1, '5': 8, '10': 'approved'},
    const {'1': 'approval_reason', '3': 3, '4': 1, '5': 9, '10': 'approvalReason'},
    const {'1': 'approved_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'approvedDate'},
  ],
};

/// Descriptor for `ApproveInvoicePaymentExtensionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approveInvoicePaymentExtensionRequestDescriptor = $convert.base64Decode('CiVBcHByb3ZlSW52b2ljZVBheW1lbnRFeHRlbnNpb25SZXF1ZXN0Eh0KCnJlcXVlc3RfaWQYASABKAlSCXJlcXVlc3RJZBIaCghhcHByb3ZlZBgCIAEoCFIIYXBwcm92ZWQSJwoPYXBwcm92YWxfcmVhc29uGAMgASgJUg5hcHByb3ZhbFJlYXNvbhI/Cg1hcHByb3ZlZF9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMYXBwcm92ZWREYXRl');
@$core.Deprecated('Use approveInvoicePaymentExtensionResponseDescriptor instead')
const ApproveInvoicePaymentExtensionResponse$json = const {
  '1': 'ApproveInvoicePaymentExtensionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'updated_request', '3': 3, '4': 1, '5': 11, '6': '.pb.PaymentExtensionRequest', '10': 'updatedRequest'},
  ],
};

/// Descriptor for `ApproveInvoicePaymentExtensionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approveInvoicePaymentExtensionResponseDescriptor = $convert.base64Decode('CiZBcHByb3ZlSW52b2ljZVBheW1lbnRFeHRlbnNpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USRAoPdXBkYXRlZF9yZXF1ZXN0GAMgASgLMhsucGIuUGF5bWVudEV4dGVuc2lvblJlcXVlc3RSDnVwZGF0ZWRSZXF1ZXN0');
@$core.Deprecated('Use disputeInvoicePaymentRequestDescriptor instead')
const DisputeInvoicePaymentRequest$json = const {
  '1': 'DisputeInvoicePaymentRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'evidence_files', '3': 4, '4': 3, '5': 9, '10': 'evidenceFiles'},
    const {'1': 'disputed_amount', '3': 5, '4': 1, '5': 1, '10': 'disputedAmount'},
  ],
};

/// Descriptor for `DisputeInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disputeInvoicePaymentRequestDescriptor = $convert.base64Decode('ChxEaXNwdXRlSW52b2ljZVBheW1lbnRSZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29uEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIlCg5ldmlkZW5jZV9maWxlcxgEIAMoCVINZXZpZGVuY2VGaWxlcxInCg9kaXNwdXRlZF9hbW91bnQYBSABKAFSDmRpc3B1dGVkQW1vdW50');
@$core.Deprecated('Use disputeInvoicePaymentResponseDescriptor instead')
const DisputeInvoicePaymentResponse$json = const {
  '1': 'DisputeInvoicePaymentResponse',
  '2': const [
    const {'1': 'dispute', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentDispute', '10': 'dispute'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'dispute_id', '3': 4, '4': 1, '5': 9, '10': 'disputeId'},
  ],
};

/// Descriptor for `DisputeInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disputeInvoicePaymentResponseDescriptor = $convert.base64Decode('Ch1EaXNwdXRlSW52b2ljZVBheW1lbnRSZXNwb25zZRIsCgdkaXNwdXRlGAEgASgLMhIucGIuUGF5bWVudERpc3B1dGVSB2Rpc3B1dGUSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEh0KCmRpc3B1dGVfaWQYBCABKAlSCWRpc3B1dGVJZA==');
@$core.Deprecated('Use resolveInvoicePaymentDisputeRequestDescriptor instead')
const ResolveInvoicePaymentDisputeRequest$json = const {
  '1': 'ResolveInvoicePaymentDisputeRequest',
  '2': const [
    const {'1': 'dispute_id', '3': 1, '4': 1, '5': 9, '10': 'disputeId'},
    const {'1': 'resolution', '3': 2, '4': 1, '5': 9, '10': 'resolution'},
    const {'1': 'refund_amount', '3': 3, '4': 1, '5': 1, '10': 'refundAmount'},
    const {'1': 'resolution_notes', '3': 4, '4': 1, '5': 9, '10': 'resolutionNotes'},
  ],
};

/// Descriptor for `ResolveInvoicePaymentDisputeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveInvoicePaymentDisputeRequestDescriptor = $convert.base64Decode('CiNSZXNvbHZlSW52b2ljZVBheW1lbnREaXNwdXRlUmVxdWVzdBIdCgpkaXNwdXRlX2lkGAEgASgJUglkaXNwdXRlSWQSHgoKcmVzb2x1dGlvbhgCIAEoCVIKcmVzb2x1dGlvbhIjCg1yZWZ1bmRfYW1vdW50GAMgASgBUgxyZWZ1bmRBbW91bnQSKQoQcmVzb2x1dGlvbl9ub3RlcxgEIAEoCVIPcmVzb2x1dGlvbk5vdGVz');
@$core.Deprecated('Use resolveInvoicePaymentDisputeResponseDescriptor instead')
const ResolveInvoicePaymentDisputeResponse$json = const {
  '1': 'ResolveInvoicePaymentDisputeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'updated_dispute', '3': 3, '4': 1, '5': 11, '6': '.pb.PaymentDispute', '10': 'updatedDispute'},
    const {'1': 'refund_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'refundTransactionId'},
  ],
};

/// Descriptor for `ResolveInvoicePaymentDisputeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveInvoicePaymentDisputeResponseDescriptor = $convert.base64Decode('CiRSZXNvbHZlSW52b2ljZVBheW1lbnREaXNwdXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjsKD3VwZGF0ZWRfZGlzcHV0ZRgDIAEoCzISLnBiLlBheW1lbnREaXNwdXRlUg51cGRhdGVkRGlzcHV0ZRIyChVyZWZ1bmRfdHJhbnNhY3Rpb25faWQYBCABKAlSE3JlZnVuZFRyYW5zYWN0aW9uSWQ=');
@$core.Deprecated('Use getInvoicePaymentHistoryRequestDescriptor instead')
const GetInvoicePaymentHistoryRequest$json = const {
  '1': 'GetInvoicePaymentHistoryRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 4, '4': 1, '5': 9, '10': 'pageToken'},
    const {'1': 'status_filter', '3': 5, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetInvoicePaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentHistoryRequestDescriptor = $convert.base64Decode('Ch9HZXRJbnZvaWNlUGF5bWVudEhpc3RvcnlSZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgEIAEoCVIJcGFnZVRva2VuEj0KDXN0YXR1c19maWx0ZXIYBSABKA4yGC5wYi5JbnZvaWNlUGF5bWVudFN0YXR1c1IMc3RhdHVzRmlsdGVy');
@$core.Deprecated('Use getInvoicePaymentHistoryResponseDescriptor instead')
const GetInvoicePaymentHistoryResponse$json = const {
  '1': 'GetInvoicePaymentHistoryResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.InvoicePaymentTransaction', '10': 'transactions'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetInvoicePaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentHistoryResponseDescriptor = $convert.base64Decode('CiBHZXRJbnZvaWNlUGF5bWVudEhpc3RvcnlSZXNwb25zZRJBCgx0cmFuc2FjdGlvbnMYASADKAsyHS5wYi5JbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2VuEh8KC3RvdGFsX2NvdW50GAMgASgEUgp0b3RhbENvdW50');
@$core.Deprecated('Use getInvoicePaymentStatisticsRequestDescriptor instead')
const GetInvoicePaymentStatisticsRequest$json = const {
  '1': 'GetInvoicePaymentStatisticsRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetInvoicePaymentStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentStatisticsRequestDescriptor = $convert.base64Decode('CiJHZXRJbnZvaWNlUGF5bWVudFN0YXRpc3RpY3NSZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRl');
@$core.Deprecated('Use getInvoicePaymentStatisticsResponseDescriptor instead')
const GetInvoicePaymentStatisticsResponse$json = const {
  '1': 'GetInvoicePaymentStatisticsResponse',
  '2': const [
    const {'1': 'total_payments', '3': 1, '4': 1, '5': 4, '10': 'totalPayments'},
    const {'1': 'successful_payments', '3': 2, '4': 1, '5': 4, '10': 'successfulPayments'},
    const {'1': 'failed_payments', '3': 3, '4': 1, '5': 4, '10': 'failedPayments'},
    const {'1': 'total_amount', '3': 4, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'total_fees', '3': 5, '4': 1, '5': 1, '10': 'totalFees'},
    const {'1': 'average_payment_amount', '3': 6, '4': 1, '5': 1, '10': 'averagePaymentAmount'},
    const {'1': 'payment_method_usage', '3': 7, '4': 3, '5': 11, '6': '.pb.GetInvoicePaymentStatisticsResponse.PaymentMethodUsageEntry', '10': 'paymentMethodUsage'},
    const {'1': 'success_rate', '3': 8, '4': 1, '5': 1, '10': 'successRate'},
  ],
  '3': const [GetInvoicePaymentStatisticsResponse_PaymentMethodUsageEntry$json],
};

@$core.Deprecated('Use getInvoicePaymentStatisticsResponseDescriptor instead')
const GetInvoicePaymentStatisticsResponse_PaymentMethodUsageEntry$json = const {
  '1': 'PaymentMethodUsageEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 4, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetInvoicePaymentStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentStatisticsResponseDescriptor = $convert.base64Decode('CiNHZXRJbnZvaWNlUGF5bWVudFN0YXRpc3RpY3NSZXNwb25zZRIlCg50b3RhbF9wYXltZW50cxgBIAEoBFINdG90YWxQYXltZW50cxIvChNzdWNjZXNzZnVsX3BheW1lbnRzGAIgASgEUhJzdWNjZXNzZnVsUGF5bWVudHMSJwoPZmFpbGVkX3BheW1lbnRzGAMgASgEUg5mYWlsZWRQYXltZW50cxIhCgx0b3RhbF9hbW91bnQYBCABKAFSC3RvdGFsQW1vdW50Eh0KCnRvdGFsX2ZlZXMYBSABKAFSCXRvdGFsRmVlcxI0ChZhdmVyYWdlX3BheW1lbnRfYW1vdW50GAYgASgBUhRhdmVyYWdlUGF5bWVudEFtb3VudBJxChRwYXltZW50X21ldGhvZF91c2FnZRgHIAMoCzI/LnBiLkdldEludm9pY2VQYXltZW50U3RhdGlzdGljc1Jlc3BvbnNlLlBheW1lbnRNZXRob2RVc2FnZUVudHJ5UhJwYXltZW50TWV0aG9kVXNhZ2USIQoMc3VjY2Vzc19yYXRlGAggASgBUgtzdWNjZXNzUmF0ZRpFChdQYXltZW50TWV0aG9kVXNhZ2VFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoBFIFdmFsdWU6AjgB');
@$core.Deprecated('Use getRecentInvoicePaymentTransactionsRequestDescriptor instead')
const GetRecentInvoicePaymentTransactionsRequest$json = const {
  '1': 'GetRecentInvoicePaymentTransactionsRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetRecentInvoicePaymentTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentInvoicePaymentTransactionsRequestDescriptor = $convert.base64Decode('CipHZXRSZWNlbnRJbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0');
@$core.Deprecated('Use getRecentInvoicePaymentTransactionsResponseDescriptor instead')
const GetRecentInvoicePaymentTransactionsResponse$json = const {
  '1': 'GetRecentInvoicePaymentTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.InvoicePaymentTransaction', '10': 'transactions'},
  ],
};

/// Descriptor for `GetRecentInvoicePaymentTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentInvoicePaymentTransactionsResponseDescriptor = $convert.base64Decode('CitHZXRSZWNlbnRJbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uc1Jlc3BvbnNlEkEKDHRyYW5zYWN0aW9ucxgBIAMoCzIdLnBiLkludm9pY2VQYXltZW50VHJhbnNhY3Rpb25SDHRyYW5zYWN0aW9ucw==');
@$core.Deprecated('Use generateInvoicePaymentReceiptRequestDescriptor instead')
const GenerateInvoicePaymentReceiptRequest$json = const {
  '1': 'GenerateInvoicePaymentReceiptRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'template_id', '3': 2, '4': 1, '5': 9, '10': 'templateId'},
    const {'1': 'include_invoice_details', '3': 3, '4': 1, '5': 8, '10': 'includeInvoiceDetails'},
  ],
};

/// Descriptor for `GenerateInvoicePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateInvoicePaymentReceiptRequestDescriptor = $convert.base64Decode('CiRHZW5lcmF0ZUludm9pY2VQYXltZW50UmVjZWlwdFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSHwoLdGVtcGxhdGVfaWQYAiABKAlSCnRlbXBsYXRlSWQSNgoXaW5jbHVkZV9pbnZvaWNlX2RldGFpbHMYAyABKAhSFWluY2x1ZGVJbnZvaWNlRGV0YWlscw==');
@$core.Deprecated('Use generateInvoicePaymentReceiptResponseDescriptor instead')
const GenerateInvoicePaymentReceiptResponse$json = const {
  '1': 'GenerateInvoicePaymentReceiptResponse',
  '2': const [
    const {'1': 'receipt_url', '3': 1, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'receipt_data', '3': 2, '4': 1, '5': 12, '10': 'receiptData'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'success', '3': 4, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `GenerateInvoicePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateInvoicePaymentReceiptResponseDescriptor = $convert.base64Decode('CiVHZW5lcmF0ZUludm9pY2VQYXltZW50UmVjZWlwdFJlc3BvbnNlEh8KC3JlY2VpcHRfdXJsGAEgASgJUgpyZWNlaXB0VXJsEiEKDHJlY2VpcHRfZGF0YRgCIAEoDFILcmVjZWlwdERhdGESGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRIYCgdzdWNjZXNzGAQgASgIUgdzdWNjZXNz');
@$core.Deprecated('Use emailInvoicePaymentReceiptRequestDescriptor instead')
const EmailInvoicePaymentReceiptRequest$json = const {
  '1': 'EmailInvoicePaymentReceiptRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'custom_message', '3': 3, '4': 1, '5': 9, '10': 'customMessage'},
  ],
};

/// Descriptor for `EmailInvoicePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailInvoicePaymentReceiptRequestDescriptor = $convert.base64Decode('CiFFbWFpbEludm9pY2VQYXltZW50UmVjZWlwdFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDXRyYW5zYWN0aW9uSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5jdXN0b21fbWVzc2FnZRgDIAEoCVINY3VzdG9tTWVzc2FnZQ==');
@$core.Deprecated('Use emailInvoicePaymentReceiptResponseDescriptor instead')
const EmailInvoicePaymentReceiptResponse$json = const {
  '1': 'EmailInvoicePaymentReceiptResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'tracking_id', '3': 3, '4': 1, '5': 9, '10': 'trackingId'},
  ],
};

/// Descriptor for `EmailInvoicePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailInvoicePaymentReceiptResponseDescriptor = $convert.base64Decode('CiJFbWFpbEludm9pY2VQYXltZW50UmVjZWlwdFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgt0cmFja2luZ19pZBgDIAEoCVIKdHJhY2tpbmdJZA==');
@$core.Deprecated('Use getInvoicePaymentReceiptRequestDescriptor instead')
const GetInvoicePaymentReceiptRequest$json = const {
  '1': 'GetInvoicePaymentReceiptRequest',
  '2': const [
    const {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetInvoicePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentReceiptRequestDescriptor = $convert.base64Decode('Ch9HZXRJbnZvaWNlUGF5bWVudFJlY2VpcHRSZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cmFuc2FjdGlvbklk');
@$core.Deprecated('Use getInvoicePaymentReceiptResponseDescriptor instead')
const GetInvoicePaymentReceiptResponse$json = const {
  '1': 'GetInvoicePaymentReceiptResponse',
  '2': const [
    const {'1': 'receipt_url', '3': 1, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'receipt_data', '3': 2, '4': 1, '5': 12, '10': 'receiptData'},
    const {'1': 'generated_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
  ],
};

/// Descriptor for `GetInvoicePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentReceiptResponseDescriptor = $convert.base64Decode('CiBHZXRJbnZvaWNlUGF5bWVudFJlY2VpcHRSZXNwb25zZRIfCgtyZWNlaXB0X3VybBgBIAEoCVIKcmVjZWlwdFVybBIhCgxyZWNlaXB0X2RhdGEYAiABKAxSC3JlY2VpcHREYXRhEj0KDGdlbmVyYXRlZF9hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2dlbmVyYXRlZEF0');
