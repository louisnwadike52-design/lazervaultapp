//
//  Generated code. Do not modify.
//  source: invoice_payment.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use invoicePaymentDetailsDescriptor instead')
const InvoicePaymentDetails$json = {
  '1': 'InvoicePaymentDetails',
  '2': [
    {'1': 'method', '3': 1, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'method'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'card_last4', '3': 4, '4': 1, '5': 9, '10': 'cardLast4'},
    {'1': 'account_id', '3': 5, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'metadata', '3': 7, '4': 3, '5': 11, '6': '.pb.InvoicePaymentDetails.MetadataEntry', '10': 'metadata'},
    {'1': 'crypto_wallet_address', '3': 8, '4': 1, '5': 9, '10': 'cryptoWalletAddress'},
    {'1': 'crypto_transaction_hash', '3': 9, '4': 1, '5': 9, '10': 'cryptoTransactionHash'},
    {'1': 'fee_amount', '3': 10, '4': 1, '5': 1, '10': 'feeAmount'},
    {'1': 'payment_processor', '3': 11, '4': 1, '5': 9, '10': 'paymentProcessor'},
  ],
  '3': [InvoicePaymentDetails_MetadataEntry$json],
};

@$core.Deprecated('Use invoicePaymentDetailsDescriptor instead')
const InvoicePaymentDetails_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InvoicePaymentDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicePaymentDetailsDescriptor = $convert.base64Decode(
    'ChVJbnZvaWNlUGF5bWVudERldGFpbHMSLQoGbWV0aG9kGAEgASgOMhUucGIuUGF5bWVudE1ldG'
    'hvZFR5cGVSBm1ldGhvZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEo'
    'CVIIY3VycmVuY3kSHQoKY2FyZF9sYXN0NBgEIAEoCVIJY2FyZExhc3Q0Eh0KCmFjY291bnRfaW'
    'QYBSABKAlSCWFjY291bnRJZBIcCglyZWZlcmVuY2UYBiABKAlSCXJlZmVyZW5jZRJDCghtZXRh'
    'ZGF0YRgHIAMoCzInLnBiLkludm9pY2VQYXltZW50RGV0YWlscy5NZXRhZGF0YUVudHJ5UghtZX'
    'RhZGF0YRIyChVjcnlwdG9fd2FsbGV0X2FkZHJlc3MYCCABKAlSE2NyeXB0b1dhbGxldEFkZHJl'
    'c3MSNgoXY3J5cHRvX3RyYW5zYWN0aW9uX2hhc2gYCSABKAlSFWNyeXB0b1RyYW5zYWN0aW9uSG'
    'FzaBIdCgpmZWVfYW1vdW50GAogASgBUglmZWVBbW91bnQSKwoRcGF5bWVudF9wcm9jZXNzb3IY'
    'CyABKAlSEHBheW1lbnRQcm9jZXNzb3IaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2'
    'tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use invoicePaymentResultDescriptor instead')
const InvoicePaymentResult$json = {
  '1': 'InvoicePaymentResult',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'payment_reference', '3': 3, '4': 1, '5': 9, '10': 'paymentReference'},
    {'1': 'error_message', '3': 4, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'status'},
    {'1': 'processed_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processedAt'},
    {'1': 'amount_processed', '3': 7, '4': 1, '5': 1, '10': 'amountProcessed'},
    {'1': 'fee_amount', '3': 8, '4': 1, '5': 1, '10': 'feeAmount'},
    {'1': 'receipt_url', '3': 9, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'confirmation_code', '3': 10, '4': 1, '5': 9, '10': 'confirmationCode'},
  ],
};

/// Descriptor for `InvoicePaymentResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicePaymentResultDescriptor = $convert.base64Decode(
    'ChRJbnZvaWNlUGF5bWVudFJlc3VsdBIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiUKDnRyYW'
    '5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklkEisKEXBheW1lbnRfcmVmZXJlbmNlGAMg'
    'ASgJUhBwYXltZW50UmVmZXJlbmNlEiMKDWVycm9yX21lc3NhZ2UYBCABKAlSDGVycm9yTWVzc2'
    'FnZRIwCgZzdGF0dXMYBSABKA4yGC5wYi5JbnZvaWNlUGF5bWVudFN0YXR1c1IGc3RhdHVzEj0K'
    'DHByb2Nlc3NlZF9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3Byb2Nlc3'
    'NlZEF0EikKEGFtb3VudF9wcm9jZXNzZWQYByABKAFSD2Ftb3VudFByb2Nlc3NlZBIdCgpmZWVf'
    'YW1vdW50GAggASgBUglmZWVBbW91bnQSHwoLcmVjZWlwdF91cmwYCSABKAlSCnJlY2VpcHRVcm'
    'wSKwoRY29uZmlybWF0aW9uX2NvZGUYCiABKAlSEGNvbmZpcm1hdGlvbkNvZGU=');

@$core.Deprecated('Use invoicePaymentTransactionDescriptor instead')
const InvoicePaymentTransaction$json = {
  '1': 'InvoicePaymentTransaction',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'invoice_id', '3': 2, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payment_method', '3': 6, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'paymentMethod'},
    {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'status'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'processed_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processedAt'},
    {'1': 'reference', '3': 10, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'description', '3': 11, '4': 1, '5': 9, '10': 'description'},
    {'1': 'fee_amount', '3': 12, '4': 1, '5': 1, '10': 'feeAmount'},
    {'1': 'metadata', '3': 13, '4': 3, '5': 11, '6': '.pb.InvoicePaymentTransaction.MetadataEntry', '10': 'metadata'},
    {'1': 'payment_processor_id', '3': 14, '4': 1, '5': 9, '10': 'paymentProcessorId'},
    {'1': 'receipt_url', '3': 15, '4': 1, '5': 9, '10': 'receiptUrl'},
  ],
  '3': [InvoicePaymentTransaction_MetadataEntry$json],
};

@$core.Deprecated('Use invoicePaymentTransactionDescriptor instead')
const InvoicePaymentTransaction_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InvoicePaymentTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicePaymentTransactionDescriptor = $convert.base64Decode(
    'ChlJbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uEiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg10cm'
    'Fuc2FjdGlvbklkEh0KCmludm9pY2VfaWQYAiABKAlSCWludm9pY2VJZBIXCgd1c2VyX2lkGAMg'
    'ASgJUgZ1c2VySWQSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBSABKAlSCG'
    'N1cnJlbmN5EjwKDnBheW1lbnRfbWV0aG9kGAYgASgOMhUucGIuUGF5bWVudE1ldGhvZFR5cGVS'
    'DXBheW1lbnRNZXRob2QSMAoGc3RhdHVzGAcgASgOMhgucGIuSW52b2ljZVBheW1lbnRTdGF0dX'
    'NSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIJY3JlYXRlZEF0Ej0KDHByb2Nlc3NlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSC3Byb2Nlc3NlZEF0EhwKCXJlZmVyZW5jZRgKIAEoCVIJcmVmZXJlbmNlEiAKC2Rl'
    'c2NyaXB0aW9uGAsgASgJUgtkZXNjcmlwdGlvbhIdCgpmZWVfYW1vdW50GAwgASgBUglmZWVBbW'
    '91bnQSRwoIbWV0YWRhdGEYDSADKAsyKy5wYi5JbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uLk1l'
    'dGFkYXRhRW50cnlSCG1ldGFkYXRhEjAKFHBheW1lbnRfcHJvY2Vzc29yX2lkGA4gASgJUhJwYX'
    'ltZW50UHJvY2Vzc29ySWQSHwoLcmVjZWlwdF91cmwYDyABKAlSCnJlY2VpcHRVcmwaOwoNTWV0'
    'YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use userAccountBalanceDescriptor instead')
const UserAccountBalance$json = {
  '1': 'UserAccountBalance',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'available_balance', '3': 3, '4': 1, '5': 1, '10': 'availableBalance'},
    {'1': 'pending_balance', '3': 4, '4': 1, '5': 1, '10': 'pendingBalance'},
    {'1': 'total_balance', '3': 5, '4': 1, '5': 1, '10': 'totalBalance'},
    {'1': 'account_type', '3': 6, '4': 1, '5': 14, '6': '.pb.VirtualAccountType', '10': 'accountType'},
    {'1': 'account_number', '3': 7, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'last_updated', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    {'1': 'account_name', '3': 9, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'is_primary', '3': 10, '4': 1, '5': 8, '10': 'isPrimary'},
  ],
};

/// Descriptor for `UserAccountBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userAccountBalanceDescriptor = $convert.base64Decode(
    'ChJVc2VyQWNjb3VudEJhbGFuY2USFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhoKCGN1cnJlbm'
    'N5GAIgASgJUghjdXJyZW5jeRIrChFhdmFpbGFibGVfYmFsYW5jZRgDIAEoAVIQYXZhaWxhYmxl'
    'QmFsYW5jZRInCg9wZW5kaW5nX2JhbGFuY2UYBCABKAFSDnBlbmRpbmdCYWxhbmNlEiMKDXRvdG'
    'FsX2JhbGFuY2UYBSABKAFSDHRvdGFsQmFsYW5jZRI5CgxhY2NvdW50X3R5cGUYBiABKA4yFi5w'
    'Yi5WaXJ0dWFsQWNjb3VudFR5cGVSC2FjY291bnRUeXBlEiUKDmFjY291bnRfbnVtYmVyGAcgAS'
    'gJUg1hY2NvdW50TnVtYmVyEj0KDGxhc3RfdXBkYXRlZBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1'
    'Zi5UaW1lc3RhbXBSC2xhc3RVcGRhdGVkEiEKDGFjY291bnRfbmFtZRgJIAEoCVILYWNjb3VudE'
    '5hbWUSHQoKaXNfcHJpbWFyeRgKIAEoCFIJaXNQcmltYXJ5');

@$core.Deprecated('Use paymentMethodDescriptor instead')
const PaymentMethod$json = {
  '1': 'PaymentMethod',
  '2': [
    {'1': 'method_id', '3': 1, '4': 1, '5': 9, '10': 'methodId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'type'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'last4', '3': 5, '4': 1, '5': 9, '10': 'last4'},
    {'1': 'brand', '3': 6, '4': 1, '5': 9, '10': 'brand'},
    {'1': 'is_default', '3': 7, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'is_verified', '3': 8, '4': 1, '5': 8, '10': 'isVerified'},
    {'1': 'expires_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'metadata', '3': 11, '4': 3, '5': 11, '6': '.pb.PaymentMethod.MetadataEntry', '10': 'metadata'},
    {'1': 'billing_address', '3': 12, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
  '3': [PaymentMethod_MetadataEntry$json],
};

@$core.Deprecated('Use paymentMethodDescriptor instead')
const PaymentMethod_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `PaymentMethod`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentMethodDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50TWV0aG9kEhsKCW1ldGhvZF9pZBgBIAEoCVIIbWV0aG9kSWQSFwoHdXNlcl9pZB'
    'gCIAEoCVIGdXNlcklkEikKBHR5cGUYAyABKA4yFS5wYi5QYXltZW50TWV0aG9kVHlwZVIEdHlw'
    'ZRIhCgxkaXNwbGF5X25hbWUYBCABKAlSC2Rpc3BsYXlOYW1lEhQKBWxhc3Q0GAUgASgJUgVsYX'
    'N0NBIUCgVicmFuZBgGIAEoCVIFYnJhbmQSHQoKaXNfZGVmYXVsdBgHIAEoCFIJaXNEZWZhdWx0'
    'Eh8KC2lzX3ZlcmlmaWVkGAggASgIUgppc1ZlcmlmaWVkEjkKCmV4cGlyZXNfYXQYCSABKAsyGi'
    '5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQSOQoKY3JlYXRlZF9hdBgKIAEo'
    'CzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI7CghtZXRhZGF0YRgLIA'
    'MoCzIfLnBiLlBheW1lbnRNZXRob2QuTWV0YWRhdGFFbnRyeVIIbWV0YWRhdGESJwoPYmlsbGlu'
    'Z19hZGRyZXNzGAwgASgJUg5iaWxsaW5nQWRkcmVzcxo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleR'
    'gBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use invoiceCryptoWalletDescriptor instead')
const InvoiceCryptoWallet$json = {
  '1': 'InvoiceCryptoWallet',
  '2': [
    {'1': 'wallet_id', '3': 1, '4': 1, '5': 9, '10': 'walletId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'wallet_address', '3': 3, '4': 1, '5': 9, '10': 'walletAddress'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'balance', '3': 5, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'is_verified', '3': 6, '4': 1, '5': 8, '10': 'isVerified'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'last_sync', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSync'},
    {'1': 'network', '3': 9, '4': 1, '5': 9, '10': 'network'},
    {'1': 'wallet_type', '3': 10, '4': 1, '5': 9, '10': 'walletType'},
  ],
};

/// Descriptor for `InvoiceCryptoWallet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceCryptoWalletDescriptor = $convert.base64Decode(
    'ChNJbnZvaWNlQ3J5cHRvV2FsbGV0EhsKCXdhbGxldF9pZBgBIAEoCVIId2FsbGV0SWQSFwoHdX'
    'Nlcl9pZBgCIAEoCVIGdXNlcklkEiUKDndhbGxldF9hZGRyZXNzGAMgASgJUg13YWxsZXRBZGRy'
    'ZXNzEhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIYCgdiYWxhbmNlGAUgASgBUgdiYWxhbm'
    'NlEh8KC2lzX3ZlcmlmaWVkGAYgASgIUgppc1ZlcmlmaWVkEjkKCmNyZWF0ZWRfYXQYByABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSNwoJbGFzdF9zeW5jGAggAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIbGFzdFN5bmMSGAoHbmV0d29yaxgJIAEo'
    'CVIHbmV0d29yaxIfCgt3YWxsZXRfdHlwZRgKIAEoCVIKd2FsbGV0VHlwZQ==');

@$core.Deprecated('Use paymentExtensionRequestDescriptor instead')
const PaymentExtensionRequest$json = {
  '1': 'PaymentExtensionRequest',
  '2': [
    {'1': 'extension_id', '3': 1, '4': 1, '5': 9, '10': 'extensionId'},
    {'1': 'invoice_id', '3': 2, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'new_due_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'newDueDate'},
    {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'requested_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'requestedAt'},
    {'1': 'approved_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'approvedAt'},
    {'1': 'approved_by', '3': 9, '4': 1, '5': 9, '10': 'approvedBy'},
    {'1': 'rejection_reason', '3': 10, '4': 1, '5': 9, '10': 'rejectionReason'},
  ],
};

/// Descriptor for `PaymentExtensionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentExtensionRequestDescriptor = $convert.base64Decode(
    'ChdQYXltZW50RXh0ZW5zaW9uUmVxdWVzdBIhCgxleHRlbnNpb25faWQYASABKAlSC2V4dGVuc2'
    'lvbklkEh0KCmludm9pY2VfaWQYAiABKAlSCWludm9pY2VJZBIXCgd1c2VyX2lkGAMgASgJUgZ1'
    'c2VySWQSPAoMbmV3X2R1ZV9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'IKbmV3RHVlRGF0ZRIWCgZyZWFzb24YBSABKAlSBnJlYXNvbhIWCgZzdGF0dXMYBiABKAlSBnN0'
    'YXR1cxI9CgxyZXF1ZXN0ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg'
    'tyZXF1ZXN0ZWRBdBI7CgthcHByb3ZlZF9hdBgIIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1l'
    'c3RhbXBSCmFwcHJvdmVkQXQSHwoLYXBwcm92ZWRfYnkYCSABKAlSCmFwcHJvdmVkQnkSKQoQcm'
    'VqZWN0aW9uX3JlYXNvbhgKIAEoCVIPcmVqZWN0aW9uUmVhc29u');

@$core.Deprecated('Use paymentDisputeDescriptor instead')
const PaymentDispute$json = {
  '1': 'PaymentDispute',
  '2': [
    {'1': 'dispute_id', '3': 1, '4': 1, '5': 9, '10': 'disputeId'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'invoice_id', '3': 3, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.pb.DisputeStatus', '10': 'status'},
    {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'resolved_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'resolvedAt'},
    {'1': 'resolution', '3': 12, '4': 1, '5': 9, '10': 'resolution'},
    {'1': 'evidence_files', '3': 13, '4': 3, '5': 9, '10': 'evidenceFiles'},
  ],
};

/// Descriptor for `PaymentDispute`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentDisputeDescriptor = $convert.base64Decode(
    'Cg5QYXltZW50RGlzcHV0ZRIdCgpkaXNwdXRlX2lkGAEgASgJUglkaXNwdXRlSWQSJQoOdHJhbn'
    'NhY3Rpb25faWQYAiABKAlSDXRyYW5zYWN0aW9uSWQSHQoKaW52b2ljZV9pZBgDIAEoCVIJaW52'
    'b2ljZUlkEhcKB3VzZXJfaWQYBCABKAlSBnVzZXJJZBIWCgZyZWFzb24YBSABKAlSBnJlYXNvbh'
    'IgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SKQoGc3RhdHVzGAcgASgOMhEucGIu'
    'RGlzcHV0ZVN0YXR1c1IGc3RhdHVzEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50EhoKCGN1cnJlbm'
    'N5GAkgASgJUghjdXJyZW5jeRI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIJY3JlYXRlZEF0EjsKC3Jlc29sdmVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3'
    'RvYnVmLlRpbWVzdGFtcFIKcmVzb2x2ZWRBdBIeCgpyZXNvbHV0aW9uGAwgASgJUgpyZXNvbHV0'
    'aW9uEiUKDmV2aWRlbmNlX2ZpbGVzGA0gAygJUg1ldmlkZW5jZUZpbGVz');

@$core.Deprecated('Use processInvoicePaymentRequestDescriptor instead')
const ProcessInvoicePaymentRequest$json = {
  '1': 'ProcessInvoicePaymentRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'payment_method_id', '3': 2, '4': 1, '5': 9, '10': 'paymentMethodId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 6, '4': 3, '5': 11, '6': '.pb.ProcessInvoicePaymentRequest.MetadataEntry', '10': 'metadata'},
    {'1': 'save_payment_method', '3': 7, '4': 1, '5': 8, '10': 'savePaymentMethod'},
    {'1': 'billing_address', '3': 8, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
  '3': [ProcessInvoicePaymentRequest_MetadataEntry$json],
};

@$core.Deprecated('Use processInvoicePaymentRequestDescriptor instead')
const ProcessInvoicePaymentRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ProcessInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processInvoicePaymentRequestDescriptor = $convert.base64Decode(
    'ChxQcm9jZXNzSW52b2ljZVBheW1lbnRSZXF1ZXN0Eh0KCmludm9pY2VfaWQYASABKAlSCWludm'
    '9pY2VJZBIqChFwYXltZW50X21ldGhvZF9pZBgCIAEoCVIPcGF5bWVudE1ldGhvZElkEhYKBmFt'
    'b3VudBgDIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIgCgtkZXNjcm'
    'lwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SSgoIbWV0YWRhdGEYBiADKAsyLi5wYi5Qcm9jZXNz'
    'SW52b2ljZVBheW1lbnRSZXF1ZXN0Lk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhEi4KE3NhdmVfcG'
    'F5bWVudF9tZXRob2QYByABKAhSEXNhdmVQYXltZW50TWV0aG9kEicKD2JpbGxpbmdfYWRkcmVz'
    'cxgIIAEoCVIOYmlsbGluZ0FkZHJlc3MaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2'
    'tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use processInvoicePaymentResponseDescriptor instead')
const ProcessInvoicePaymentResponse$json = {
  '1': 'ProcessInvoicePaymentResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.pb.InvoicePaymentResult', '10': 'result'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'next_action', '3': 4, '4': 1, '5': 9, '10': 'nextAction'},
    {'1': 'additional_data', '3': 5, '4': 3, '5': 11, '6': '.pb.ProcessInvoicePaymentResponse.AdditionalDataEntry', '10': 'additionalData'},
  ],
  '3': [ProcessInvoicePaymentResponse_AdditionalDataEntry$json],
};

@$core.Deprecated('Use processInvoicePaymentResponseDescriptor instead')
const ProcessInvoicePaymentResponse_AdditionalDataEntry$json = {
  '1': 'AdditionalDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ProcessInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processInvoicePaymentResponseDescriptor = $convert.base64Decode(
    'Ch1Qcm9jZXNzSW52b2ljZVBheW1lbnRSZXNwb25zZRIwCgZyZXN1bHQYASABKAsyGC5wYi5Jbn'
    'ZvaWNlUGF5bWVudFJlc3VsdFIGcmVzdWx0EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USGAoH'
    'c3VjY2VzcxgDIAEoCFIHc3VjY2VzcxIfCgtuZXh0X2FjdGlvbhgEIAEoCVIKbmV4dEFjdGlvbh'
    'JeCg9hZGRpdGlvbmFsX2RhdGEYBSADKAsyNS5wYi5Qcm9jZXNzSW52b2ljZVBheW1lbnRSZXNw'
    'b25zZS5BZGRpdGlvbmFsRGF0YUVudHJ5Ug5hZGRpdGlvbmFsRGF0YRpBChNBZGRpdGlvbmFsRG'
    'F0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use processPartialInvoicePaymentRequestDescriptor instead')
const ProcessPartialInvoicePaymentRequest$json = {
  '1': 'ProcessPartialInvoicePaymentRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'payment_method_id', '3': 2, '4': 1, '5': 9, '10': 'paymentMethodId'},
    {'1': 'partial_amount', '3': 3, '4': 1, '5': 1, '10': 'partialAmount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'metadata', '3': 6, '4': 3, '5': 11, '6': '.pb.ProcessPartialInvoicePaymentRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': [ProcessPartialInvoicePaymentRequest_MetadataEntry$json],
};

@$core.Deprecated('Use processPartialInvoicePaymentRequestDescriptor instead')
const ProcessPartialInvoicePaymentRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ProcessPartialInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPartialInvoicePaymentRequestDescriptor = $convert.base64Decode(
    'CiNQcm9jZXNzUGFydGlhbEludm9pY2VQYXltZW50UmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgAS'
    'gJUglpbnZvaWNlSWQSKgoRcGF5bWVudF9tZXRob2RfaWQYAiABKAlSD3BheW1lbnRNZXRob2RJ'
    'ZBIlCg5wYXJ0aWFsX2Ftb3VudBgDIAEoAVINcGFydGlhbEFtb3VudBIaCghjdXJyZW5jeRgEIA'
    'EoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uElEKCG1ldGFk'
    'YXRhGAYgAygLMjUucGIuUHJvY2Vzc1BhcnRpYWxJbnZvaWNlUGF5bWVudFJlcXVlc3QuTWV0YW'
    'RhdGFFbnRyeVIIbWV0YWRhdGEaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIU'
    'CgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use processPartialInvoicePaymentResponseDescriptor instead')
const ProcessPartialInvoicePaymentResponse$json = {
  '1': 'ProcessPartialInvoicePaymentResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.pb.InvoicePaymentResult', '10': 'result'},
    {'1': 'remaining_amount', '3': 2, '4': 1, '5': 1, '10': 'remainingAmount'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 4, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ProcessPartialInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPartialInvoicePaymentResponseDescriptor = $convert.base64Decode(
    'CiRQcm9jZXNzUGFydGlhbEludm9pY2VQYXltZW50UmVzcG9uc2USMAoGcmVzdWx0GAEgASgLMh'
    'gucGIuSW52b2ljZVBheW1lbnRSZXN1bHRSBnJlc3VsdBIpChByZW1haW5pbmdfYW1vdW50GAIg'
    'ASgBUg9yZW1haW5pbmdBbW91bnQSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRIYCgdzdWNjZX'
    'NzGAQgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use validateInvoicePaymentRequestDescriptor instead')
const ValidateInvoicePaymentRequest$json = {
  '1': 'ValidateInvoicePaymentRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'payment_method_id', '3': 2, '4': 1, '5': 9, '10': 'paymentMethodId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `ValidateInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoicePaymentRequestDescriptor = $convert.base64Decode(
    'Ch1WYWxpZGF0ZUludm9pY2VQYXltZW50UmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbn'
    'ZvaWNlSWQSKgoRcGF5bWVudF9tZXRob2RfaWQYAiABKAlSD3BheW1lbnRNZXRob2RJZBIWCgZh'
    'bW91bnQYAyABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3k=');

@$core.Deprecated('Use validateInvoicePaymentResponseDescriptor instead')
const ValidateInvoicePaymentResponse$json = {
  '1': 'ValidateInvoicePaymentResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'validation_message', '3': 2, '4': 1, '5': 9, '10': 'validationMessage'},
    {'1': 'errors', '3': 3, '4': 3, '5': 9, '10': 'errors'},
    {'1': 'available_balance', '3': 4, '4': 1, '5': 1, '10': 'availableBalance'},
    {'1': 'payment_fees', '3': 5, '4': 1, '5': 1, '10': 'paymentFees'},
  ],
};

/// Descriptor for `ValidateInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoicePaymentResponseDescriptor = $convert.base64Decode(
    'Ch5WYWxpZGF0ZUludm9pY2VQYXltZW50UmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVm'
    'FsaWQSLQoSdmFsaWRhdGlvbl9tZXNzYWdlGAIgASgJUhF2YWxpZGF0aW9uTWVzc2FnZRIWCgZl'
    'cnJvcnMYAyADKAlSBmVycm9ycxIrChFhdmFpbGFibGVfYmFsYW5jZRgEIAEoAVIQYXZhaWxhYm'
    'xlQmFsYW5jZRIhCgxwYXltZW50X2ZlZXMYBSABKAFSC3BheW1lbnRGZWVz');

@$core.Deprecated('Use getInvoicePaymentStatusRequestDescriptor instead')
const GetInvoicePaymentStatusRequest$json = {
  '1': 'GetInvoicePaymentStatusRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetInvoicePaymentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentStatusRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRJbnZvaWNlUGF5bWVudFN0YXR1c1JlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKA'
    'lSDXRyYW5zYWN0aW9uSWQ=');

@$core.Deprecated('Use getInvoicePaymentStatusResponseDescriptor instead')
const GetInvoicePaymentStatusResponse$json = {
  '1': 'GetInvoicePaymentStatusResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.pb.InvoicePaymentTransaction', '10': 'transaction'},
    {'1': 'current_status', '3': 2, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'currentStatus'},
    {'1': 'status_message', '3': 3, '4': 1, '5': 9, '10': 'statusMessage'},
    {'1': 'last_updated', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
  ],
};

/// Descriptor for `GetInvoicePaymentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentStatusResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRJbnZvaWNlUGF5bWVudFN0YXR1c1Jlc3BvbnNlEj8KC3RyYW5zYWN0aW9uGAEgASgLMh'
    '0ucGIuSW52b2ljZVBheW1lbnRUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24SPwoOY3VycmVudF9z'
    'dGF0dXMYAiABKA4yGC5wYi5JbnZvaWNlUGF5bWVudFN0YXR1c1INY3VycmVudFN0YXR1cxIlCg'
    '5zdGF0dXNfbWVzc2FnZRgDIAEoCVINc3RhdHVzTWVzc2FnZRI9CgxsYXN0X3VwZGF0ZWQYBCAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsYXN0VXBkYXRlZA==');

@$core.Deprecated('Use cancelInvoicePaymentRequestDescriptor instead')
const CancelInvoicePaymentRequest$json = {
  '1': 'CancelInvoicePaymentRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoicePaymentRequestDescriptor = $convert.base64Decode(
    'ChtDYW5jZWxJbnZvaWNlUGF5bWVudFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYASABKAlSDX'
    'RyYW5zYWN0aW9uSWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use cancelInvoicePaymentResponseDescriptor instead')
const CancelInvoicePaymentResponse$json = {
  '1': 'CancelInvoicePaymentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'new_status', '3': 3, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'newStatus'},
    {'1': 'refund_amount', '3': 4, '4': 1, '5': 1, '10': 'refundAmount'},
  ],
};

/// Descriptor for `CancelInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoicePaymentResponseDescriptor = $convert.base64Decode(
    'ChxDYW5jZWxJbnZvaWNlUGF5bWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3'
    'MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI3CgpuZXdfc3RhdHVzGAMgASgOMhgucGIuSW52'
    'b2ljZVBheW1lbnRTdGF0dXNSCW5ld1N0YXR1cxIjCg1yZWZ1bmRfYW1vdW50GAQgASgBUgxyZW'
    'Z1bmRBbW91bnQ=');

@$core.Deprecated('Use getUserInvoicePaymentMethodsRequestDescriptor instead')
const GetUserInvoicePaymentMethodsRequest$json = {
  '1': 'GetUserInvoicePaymentMethodsRequest',
  '2': [
    {'1': 'type_filter', '3': 1, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'typeFilter'},
  ],
};

/// Descriptor for `GetUserInvoicePaymentMethodsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInvoicePaymentMethodsRequestDescriptor = $convert.base64Decode(
    'CiNHZXRVc2VySW52b2ljZVBheW1lbnRNZXRob2RzUmVxdWVzdBI2Cgt0eXBlX2ZpbHRlchgBIA'
    'EoDjIVLnBiLlBheW1lbnRNZXRob2RUeXBlUgp0eXBlRmlsdGVy');

@$core.Deprecated('Use getUserInvoicePaymentMethodsResponseDescriptor instead')
const GetUserInvoicePaymentMethodsResponse$json = {
  '1': 'GetUserInvoicePaymentMethodsResponse',
  '2': [
    {'1': 'payment_methods', '3': 1, '4': 3, '5': 11, '6': '.pb.PaymentMethod', '10': 'paymentMethods'},
    {'1': 'default_method', '3': 2, '4': 1, '5': 11, '6': '.pb.PaymentMethod', '10': 'defaultMethod'},
  ],
};

/// Descriptor for `GetUserInvoicePaymentMethodsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInvoicePaymentMethodsResponseDescriptor = $convert.base64Decode(
    'CiRHZXRVc2VySW52b2ljZVBheW1lbnRNZXRob2RzUmVzcG9uc2USOgoPcGF5bWVudF9tZXRob2'
    'RzGAEgAygLMhEucGIuUGF5bWVudE1ldGhvZFIOcGF5bWVudE1ldGhvZHMSOAoOZGVmYXVsdF9t'
    'ZXRob2QYAiABKAsyES5wYi5QYXltZW50TWV0aG9kUg1kZWZhdWx0TWV0aG9k');

@$core.Deprecated('Use addInvoicePaymentMethodRequestDescriptor instead')
const AddInvoicePaymentMethodRequest$json = {
  '1': 'AddInvoicePaymentMethodRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.pb.PaymentMethodType', '10': 'type'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'payment_details', '3': 3, '4': 3, '5': 11, '6': '.pb.AddInvoicePaymentMethodRequest.PaymentDetailsEntry', '10': 'paymentDetails'},
    {'1': 'set_as_default', '3': 4, '4': 1, '5': 8, '10': 'setAsDefault'},
    {'1': 'billing_address', '3': 5, '4': 1, '5': 9, '10': 'billingAddress'},
  ],
  '3': [AddInvoicePaymentMethodRequest_PaymentDetailsEntry$json],
};

@$core.Deprecated('Use addInvoicePaymentMethodRequestDescriptor instead')
const AddInvoicePaymentMethodRequest_PaymentDetailsEntry$json = {
  '1': 'PaymentDetailsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `AddInvoicePaymentMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addInvoicePaymentMethodRequestDescriptor = $convert.base64Decode(
    'Ch5BZGRJbnZvaWNlUGF5bWVudE1ldGhvZFJlcXVlc3QSKQoEdHlwZRgBIAEoDjIVLnBiLlBheW'
    '1lbnRNZXRob2RUeXBlUgR0eXBlEiEKDGRpc3BsYXlfbmFtZRgCIAEoCVILZGlzcGxheU5hbWUS'
    'XwoPcGF5bWVudF9kZXRhaWxzGAMgAygLMjYucGIuQWRkSW52b2ljZVBheW1lbnRNZXRob2RSZX'
    'F1ZXN0LlBheW1lbnREZXRhaWxzRW50cnlSDnBheW1lbnREZXRhaWxzEiQKDnNldF9hc19kZWZh'
    'dWx0GAQgASgIUgxzZXRBc0RlZmF1bHQSJwoPYmlsbGluZ19hZGRyZXNzGAUgASgJUg5iaWxsaW'
    '5nQWRkcmVzcxpBChNQYXltZW50RGV0YWlsc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZh'
    'bHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use addInvoicePaymentMethodResponseDescriptor instead')
const AddInvoicePaymentMethodResponse$json = {
  '1': 'AddInvoicePaymentMethodResponse',
  '2': [
    {'1': 'payment_method', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentMethod', '10': 'paymentMethod'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'verification_url', '3': 4, '4': 1, '5': 9, '10': 'verificationUrl'},
  ],
};

/// Descriptor for `AddInvoicePaymentMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addInvoicePaymentMethodResponseDescriptor = $convert.base64Decode(
    'Ch9BZGRJbnZvaWNlUGF5bWVudE1ldGhvZFJlc3BvbnNlEjgKDnBheW1lbnRfbWV0aG9kGAEgAS'
    'gLMhEucGIuUGF5bWVudE1ldGhvZFINcGF5bWVudE1ldGhvZBIYCgdzdWNjZXNzGAIgASgIUgdz'
    'dWNjZXNzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USKQoQdmVyaWZpY2F0aW9uX3VybBgEIA'
    'EoCVIPdmVyaWZpY2F0aW9uVXJs');

@$core.Deprecated('Use removeInvoicePaymentMethodRequestDescriptor instead')
const RemoveInvoicePaymentMethodRequest$json = {
  '1': 'RemoveInvoicePaymentMethodRequest',
  '2': [
    {'1': 'method_id', '3': 1, '4': 1, '5': 9, '10': 'methodId'},
  ],
};

/// Descriptor for `RemoveInvoicePaymentMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeInvoicePaymentMethodRequestDescriptor = $convert.base64Decode(
    'CiFSZW1vdmVJbnZvaWNlUGF5bWVudE1ldGhvZFJlcXVlc3QSGwoJbWV0aG9kX2lkGAEgASgJUg'
    'htZXRob2RJZA==');

@$core.Deprecated('Use removeInvoicePaymentMethodResponseDescriptor instead')
const RemoveInvoicePaymentMethodResponse$json = {
  '1': 'RemoveInvoicePaymentMethodResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemoveInvoicePaymentMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeInvoicePaymentMethodResponseDescriptor = $convert.base64Decode(
    'CiJSZW1vdmVJbnZvaWNlUGF5bWVudE1ldGhvZFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3'
    'N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use validateInvoicePaymentMethodRequestDescriptor instead')
const ValidateInvoicePaymentMethodRequest$json = {
  '1': 'ValidateInvoicePaymentMethodRequest',
  '2': [
    {'1': 'method_id', '3': 1, '4': 1, '5': 9, '10': 'methodId'},
    {'1': 'test_amount', '3': 2, '4': 1, '5': 1, '10': 'testAmount'},
  ],
};

/// Descriptor for `ValidateInvoicePaymentMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoicePaymentMethodRequestDescriptor = $convert.base64Decode(
    'CiNWYWxpZGF0ZUludm9pY2VQYXltZW50TWV0aG9kUmVxdWVzdBIbCgltZXRob2RfaWQYASABKA'
    'lSCG1ldGhvZElkEh8KC3Rlc3RfYW1vdW50GAIgASgBUgp0ZXN0QW1vdW50');

@$core.Deprecated('Use validateInvoicePaymentMethodResponseDescriptor instead')
const ValidateInvoicePaymentMethodResponse$json = {
  '1': 'ValidateInvoicePaymentMethodResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'validation_message', '3': 2, '4': 1, '5': 9, '10': 'validationMessage'},
    {'1': 'validated_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'validatedAt'},
  ],
};

/// Descriptor for `ValidateInvoicePaymentMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoicePaymentMethodResponseDescriptor = $convert.base64Decode(
    'CiRWYWxpZGF0ZUludm9pY2VQYXltZW50TWV0aG9kUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKA'
    'hSB2lzVmFsaWQSLQoSdmFsaWRhdGlvbl9tZXNzYWdlGAIgASgJUhF2YWxpZGF0aW9uTWVzc2Fn'
    'ZRI9Cgx2YWxpZGF0ZWRfYXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgt2YW'
    'xpZGF0ZWRBdA==');

@$core.Deprecated('Use updateInvoicePaymentMethodRequestDescriptor instead')
const UpdateInvoicePaymentMethodRequest$json = {
  '1': 'UpdateInvoicePaymentMethodRequest',
  '2': [
    {'1': 'method_id', '3': 1, '4': 1, '5': 9, '10': 'methodId'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'is_default', '3': 3, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'billing_address', '3': 4, '4': 1, '5': 9, '10': 'billingAddress'},
    {'1': 'metadata', '3': 5, '4': 3, '5': 11, '6': '.pb.UpdateInvoicePaymentMethodRequest.MetadataEntry', '10': 'metadata'},
  ],
  '3': [UpdateInvoicePaymentMethodRequest_MetadataEntry$json],
};

@$core.Deprecated('Use updateInvoicePaymentMethodRequestDescriptor instead')
const UpdateInvoicePaymentMethodRequest_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `UpdateInvoicePaymentMethodRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoicePaymentMethodRequestDescriptor = $convert.base64Decode(
    'CiFVcGRhdGVJbnZvaWNlUGF5bWVudE1ldGhvZFJlcXVlc3QSGwoJbWV0aG9kX2lkGAEgASgJUg'
    'htZXRob2RJZBIhCgxkaXNwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEh0KCmlzX2RlZmF1'
    'bHQYAyABKAhSCWlzRGVmYXVsdBInCg9iaWxsaW5nX2FkZHJlc3MYBCABKAlSDmJpbGxpbmdBZG'
    'RyZXNzEk8KCG1ldGFkYXRhGAUgAygLMjMucGIuVXBkYXRlSW52b2ljZVBheW1lbnRNZXRob2RS'
    'ZXF1ZXN0Lk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhGjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GA'
    'EgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use updateInvoicePaymentMethodResponseDescriptor instead')
const UpdateInvoicePaymentMethodResponse$json = {
  '1': 'UpdateInvoicePaymentMethodResponse',
  '2': [
    {'1': 'payment_method', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentMethod', '10': 'paymentMethod'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInvoicePaymentMethodResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoicePaymentMethodResponseDescriptor = $convert.base64Decode(
    'CiJVcGRhdGVJbnZvaWNlUGF5bWVudE1ldGhvZFJlc3BvbnNlEjgKDnBheW1lbnRfbWV0aG9kGA'
    'EgASgLMhEucGIuUGF5bWVudE1ldGhvZFINcGF5bWVudE1ldGhvZBIYCgdzdWNjZXNzGAIgASgI'
    'UgdzdWNjZXNzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getUserAccountBalanceRequestDescriptor instead')
const GetUserAccountBalanceRequest$json = {
  '1': 'GetUserAccountBalanceRequest',
  '2': [
    {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'account_type', '3': 2, '4': 1, '5': 14, '6': '.pb.VirtualAccountType', '10': 'accountType'},
  ],
};

/// Descriptor for `GetUserAccountBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountBalanceRequestDescriptor = $convert.base64Decode(
    'ChxHZXRVc2VyQWNjb3VudEJhbGFuY2VSZXF1ZXN0EhoKCGN1cnJlbmN5GAEgASgJUghjdXJyZW'
    '5jeRI5CgxhY2NvdW50X3R5cGUYAiABKA4yFi5wYi5WaXJ0dWFsQWNjb3VudFR5cGVSC2FjY291'
    'bnRUeXBl');

@$core.Deprecated('Use getUserAccountBalanceResponseDescriptor instead')
const GetUserAccountBalanceResponse$json = {
  '1': 'GetUserAccountBalanceResponse',
  '2': [
    {'1': 'accounts', '3': 1, '4': 3, '5': 11, '6': '.pb.UserAccountBalance', '10': 'accounts'},
    {'1': 'total_balance', '3': 2, '4': 1, '5': 1, '10': 'totalBalance'},
    {'1': 'primary_currency', '3': 3, '4': 1, '5': 9, '10': 'primaryCurrency'},
  ],
};

/// Descriptor for `GetUserAccountBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountBalanceResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRVc2VyQWNjb3VudEJhbGFuY2VSZXNwb25zZRIyCghhY2NvdW50cxgBIAMoCzIWLnBiLl'
    'VzZXJBY2NvdW50QmFsYW5jZVIIYWNjb3VudHMSIwoNdG90YWxfYmFsYW5jZRgCIAEoAVIMdG90'
    'YWxCYWxhbmNlEikKEHByaW1hcnlfY3VycmVuY3kYAyABKAlSD3ByaW1hcnlDdXJyZW5jeQ==');

@$core.Deprecated('Use getAccountBalanceHistoryRequestDescriptor instead')
const GetAccountBalanceHistoryRequest$json = {
  '1': 'GetAccountBalanceHistoryRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'start_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 5, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `GetAccountBalanceHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountBalanceHistoryRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRBY2NvdW50QmFsYW5jZUhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCW'
    'FjY291bnRJZBI5CgpzdGFydF9kYXRlGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIHZW5kRGF0ZRIbCglwYWdlX3NpemUYBCABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4Y'
    'BSABKAlSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use getAccountBalanceHistoryResponseDescriptor instead')
const GetAccountBalanceHistoryResponse$json = {
  '1': 'GetAccountBalanceHistoryResponse',
  '2': [
    {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.pb.BalanceHistoryEntry', '10': 'entries'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `GetAccountBalanceHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAccountBalanceHistoryResponseDescriptor = $convert.base64Decode(
    'CiBHZXRBY2NvdW50QmFsYW5jZUhpc3RvcnlSZXNwb25zZRIxCgdlbnRyaWVzGAEgAygLMhcucG'
    'IuQmFsYW5jZUhpc3RvcnlFbnRyeVIHZW50cmllcxImCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlS'
    'DW5leHRQYWdlVG9rZW4=');

@$core.Deprecated('Use balanceHistoryEntryDescriptor instead')
const BalanceHistoryEntry$json = {
  '1': 'BalanceHistoryEntry',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'balance', '3': 2, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'change_amount', '3': 3, '4': 1, '5': 1, '10': 'changeAmount'},
    {'1': 'transaction_type', '3': 4, '4': 1, '5': 9, '10': 'transactionType'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `BalanceHistoryEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceHistoryEntryDescriptor = $convert.base64Decode(
    'ChNCYWxhbmNlSGlzdG9yeUVudHJ5EjgKCXRpbWVzdGFtcBgBIAEoCzIaLmdvb2dsZS5wcm90b2'
    'J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcBIYCgdiYWxhbmNlGAIgASgBUgdiYWxhbmNlEiMKDWNo'
    'YW5nZV9hbW91bnQYAyABKAFSDGNoYW5nZUFtb3VudBIpChB0cmFuc2FjdGlvbl90eXBlGAQgAS'
    'gJUg90cmFuc2FjdGlvblR5cGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEhwK'
    'CXJlZmVyZW5jZRgGIAEoCVIJcmVmZXJlbmNl');

@$core.Deprecated('Use transferFundsForInvoicePaymentRequestDescriptor instead')
const TransferFundsForInvoicePaymentRequest$json = {
  '1': 'TransferFundsForInvoicePaymentRequest',
  '2': [
    {'1': 'from_account_id', '3': 1, '4': 1, '5': 9, '10': 'fromAccountId'},
    {'1': 'to_account_id', '3': 2, '4': 1, '5': 9, '10': 'toAccountId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'invoice_id', '3': 5, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `TransferFundsForInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferFundsForInvoicePaymentRequestDescriptor = $convert.base64Decode(
    'CiVUcmFuc2ZlckZ1bmRzRm9ySW52b2ljZVBheW1lbnRSZXF1ZXN0EiYKD2Zyb21fYWNjb3VudF'
    '9pZBgBIAEoCVINZnJvbUFjY291bnRJZBIiCg10b19hY2NvdW50X2lkGAIgASgJUgt0b0FjY291'
    'bnRJZBIWCgZhbW91bnQYAyABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgEIAEoCVIIY3VycmVuY3'
    'kSHQoKaW52b2ljZV9pZBgFIAEoCVIJaW52b2ljZUlkEiAKC2Rlc2NyaXB0aW9uGAYgASgJUgtk'
    'ZXNjcmlwdGlvbg==');

@$core.Deprecated('Use transferFundsForInvoicePaymentResponseDescriptor instead')
const TransferFundsForInvoicePaymentResponse$json = {
  '1': 'TransferFundsForInvoicePaymentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'new_balance', '3': 4, '4': 1, '5': 1, '10': 'newBalance'},
  ],
};

/// Descriptor for `TransferFundsForInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferFundsForInvoicePaymentResponseDescriptor = $convert.base64Decode(
    'CiZUcmFuc2ZlckZ1bmRzRm9ySW52b2ljZVBheW1lbnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgAS'
    'gIUgdzdWNjZXNzEiUKDnRyYW5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklkEhgKB21l'
    'c3NhZ2UYAyABKAlSB21lc3NhZ2USHwoLbmV3X2JhbGFuY2UYBCABKAFSCm5ld0JhbGFuY2U=');

@$core.Deprecated('Use processCryptoInvoicePaymentRequestDescriptor instead')
const ProcessCryptoInvoicePaymentRequest$json = {
  '1': 'ProcessCryptoInvoicePaymentRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'wallet_address', '3': 2, '4': 1, '5': 9, '10': 'walletAddress'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_hash', '3': 5, '4': 1, '5': 9, '10': 'transactionHash'},
    {'1': 'network', '3': 6, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `ProcessCryptoInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processCryptoInvoicePaymentRequestDescriptor = $convert.base64Decode(
    'CiJQcm9jZXNzQ3J5cHRvSW52b2ljZVBheW1lbnRSZXF1ZXN0Eh0KCmludm9pY2VfaWQYASABKA'
    'lSCWludm9pY2VJZBIlCg53YWxsZXRfYWRkcmVzcxgCIAEoCVINd2FsbGV0QWRkcmVzcxIaCghj'
    'dXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSKQoQdHJhbn'
    'NhY3Rpb25faGFzaBgFIAEoCVIPdHJhbnNhY3Rpb25IYXNoEhgKB25ldHdvcmsYBiABKAlSB25l'
    'dHdvcms=');

@$core.Deprecated('Use processCryptoInvoicePaymentResponseDescriptor instead')
const ProcessCryptoInvoicePaymentResponse$json = {
  '1': 'ProcessCryptoInvoicePaymentResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'confirmation_status', '3': 3, '4': 1, '5': 9, '10': 'confirmationStatus'},
    {'1': 'confirmations_required', '3': 4, '4': 1, '5': 5, '10': 'confirmationsRequired'},
    {'1': 'current_confirmations', '3': 5, '4': 1, '5': 5, '10': 'currentConfirmations'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ProcessCryptoInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processCryptoInvoicePaymentResponseDescriptor = $convert.base64Decode(
    'CiNQcm9jZXNzQ3J5cHRvSW52b2ljZVBheW1lbnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUg'
    'dzdWNjZXNzEiUKDnRyYW5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklkEi8KE2NvbmZp'
    'cm1hdGlvbl9zdGF0dXMYAyABKAlSEmNvbmZpcm1hdGlvblN0YXR1cxI1ChZjb25maXJtYXRpb2'
    '5zX3JlcXVpcmVkGAQgASgFUhVjb25maXJtYXRpb25zUmVxdWlyZWQSMwoVY3VycmVudF9jb25m'
    'aXJtYXRpb25zGAUgASgFUhRjdXJyZW50Q29uZmlybWF0aW9ucxIYCgdtZXNzYWdlGAYgASgJUg'
    'dtZXNzYWdl');

@$core.Deprecated('Use getInvoiceCryptoWalletBalanceRequestDescriptor instead')
const GetInvoiceCryptoWalletBalanceRequest$json = {
  '1': 'GetInvoiceCryptoWalletBalanceRequest',
  '2': [
    {'1': 'wallet_address', '3': 1, '4': 1, '5': 9, '10': 'walletAddress'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetInvoiceCryptoWalletBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceCryptoWalletBalanceRequestDescriptor = $convert.base64Decode(
    'CiRHZXRJbnZvaWNlQ3J5cHRvV2FsbGV0QmFsYW5jZVJlcXVlc3QSJQoOd2FsbGV0X2FkZHJlc3'
    'MYASABKAlSDXdhbGxldEFkZHJlc3MSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5EhgKB25l'
    'dHdvcmsYAyABKAlSB25ldHdvcms=');

@$core.Deprecated('Use getInvoiceCryptoWalletBalanceResponseDescriptor instead')
const GetInvoiceCryptoWalletBalanceResponse$json = {
  '1': 'GetInvoiceCryptoWalletBalanceResponse',
  '2': [
    {'1': 'balance', '3': 1, '4': 1, '5': 1, '10': 'balance'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'last_updated', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
    {'1': 'network', '3': 4, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetInvoiceCryptoWalletBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceCryptoWalletBalanceResponseDescriptor = $convert.base64Decode(
    'CiVHZXRJbnZvaWNlQ3J5cHRvV2FsbGV0QmFsYW5jZVJlc3BvbnNlEhgKB2JhbGFuY2UYASABKA'
    'FSB2JhbGFuY2USGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5Ej0KDGxhc3RfdXBkYXRlZBgD'
    'IAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RVcGRhdGVkEhgKB25ldHdvcm'
    'sYBCABKAlSB25ldHdvcms=');

@$core.Deprecated('Use validateInvoiceCryptoWalletRequestDescriptor instead')
const ValidateInvoiceCryptoWalletRequest$json = {
  '1': 'ValidateInvoiceCryptoWalletRequest',
  '2': [
    {'1': 'wallet_address', '3': 1, '4': 1, '5': 9, '10': 'walletAddress'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `ValidateInvoiceCryptoWalletRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoiceCryptoWalletRequestDescriptor = $convert.base64Decode(
    'CiJWYWxpZGF0ZUludm9pY2VDcnlwdG9XYWxsZXRSZXF1ZXN0EiUKDndhbGxldF9hZGRyZXNzGA'
    'EgASgJUg13YWxsZXRBZGRyZXNzEhoKCGN1cnJlbmN5GAIgASgJUghjdXJyZW5jeRIYCgduZXR3'
    'b3JrGAMgASgJUgduZXR3b3Jr');

@$core.Deprecated('Use validateInvoiceCryptoWalletResponseDescriptor instead')
const ValidateInvoiceCryptoWalletResponse$json = {
  '1': 'ValidateInvoiceCryptoWalletResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'validation_message', '3': 2, '4': 1, '5': 9, '10': 'validationMessage'},
    {'1': 'is_contract', '3': 3, '4': 1, '5': 8, '10': 'isContract'},
    {'1': 'wallet_type', '3': 4, '4': 1, '5': 9, '10': 'walletType'},
  ],
};

/// Descriptor for `ValidateInvoiceCryptoWalletResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInvoiceCryptoWalletResponseDescriptor = $convert.base64Decode(
    'CiNWYWxpZGF0ZUludm9pY2VDcnlwdG9XYWxsZXRSZXNwb25zZRIZCghpc192YWxpZBgBIAEoCF'
    'IHaXNWYWxpZBItChJ2YWxpZGF0aW9uX21lc3NhZ2UYAiABKAlSEXZhbGlkYXRpb25NZXNzYWdl'
    'Eh8KC2lzX2NvbnRyYWN0GAMgASgIUgppc0NvbnRyYWN0Eh8KC3dhbGxldF90eXBlGAQgASgJUg'
    'p3YWxsZXRUeXBl');

@$core.Deprecated('Use getCryptoInvoicePaymentStatusRequestDescriptor instead')
const GetCryptoInvoicePaymentStatusRequest$json = {
  '1': 'GetCryptoInvoicePaymentStatusRequest',
  '2': [
    {'1': 'transaction_hash', '3': 1, '4': 1, '5': 9, '10': 'transactionHash'},
    {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetCryptoInvoicePaymentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoInvoicePaymentStatusRequestDescriptor = $convert.base64Decode(
    'CiRHZXRDcnlwdG9JbnZvaWNlUGF5bWVudFN0YXR1c1JlcXVlc3QSKQoQdHJhbnNhY3Rpb25faG'
    'FzaBgBIAEoCVIPdHJhbnNhY3Rpb25IYXNoEhgKB25ldHdvcmsYAiABKAlSB25ldHdvcms=');

@$core.Deprecated('Use getCryptoInvoicePaymentStatusResponseDescriptor instead')
const GetCryptoInvoicePaymentStatusResponse$json = {
  '1': 'GetCryptoInvoicePaymentStatusResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'confirmations', '3': 2, '4': 1, '5': 5, '10': 'confirmations'},
    {'1': 'required_confirmations', '3': 3, '4': 1, '5': 5, '10': 'requiredConfirmations'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'timestamp', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `GetCryptoInvoicePaymentStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCryptoInvoicePaymentStatusResponseDescriptor = $convert.base64Decode(
    'CiVHZXRDcnlwdG9JbnZvaWNlUGF5bWVudFN0YXR1c1Jlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCV'
    'IGc3RhdHVzEiQKDWNvbmZpcm1hdGlvbnMYAiABKAVSDWNvbmZpcm1hdGlvbnMSNQoWcmVxdWly'
    'ZWRfY29uZmlybWF0aW9ucxgDIAEoBVIVcmVxdWlyZWRDb25maXJtYXRpb25zEhYKBmFtb3VudB'
    'gEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRI4Cgl0aW1lc3RhbXAY'
    'BiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXA=');

@$core.Deprecated('Use requestInvoicePaymentExtensionRequestDescriptor instead')
const RequestInvoicePaymentExtensionRequest$json = {
  '1': 'RequestInvoicePaymentExtensionRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'new_due_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'newDueDate'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'justification', '3': 4, '4': 1, '5': 9, '10': 'justification'},
  ],
};

/// Descriptor for `RequestInvoicePaymentExtensionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestInvoicePaymentExtensionRequestDescriptor = $convert.base64Decode(
    'CiVSZXF1ZXN0SW52b2ljZVBheW1lbnRFeHRlbnNpb25SZXF1ZXN0Eh0KCmludm9pY2VfaWQYAS'
    'ABKAlSCWludm9pY2VJZBI8CgxuZXdfZHVlX2RhdGUYAiABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUgpuZXdEdWVEYXRlEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29uEiQKDWp1c3RpZm'
    'ljYXRpb24YBCABKAlSDWp1c3RpZmljYXRpb24=');

@$core.Deprecated('Use requestInvoicePaymentExtensionResponseDescriptor instead')
const RequestInvoicePaymentExtensionResponse$json = {
  '1': 'RequestInvoicePaymentExtensionResponse',
  '2': [
    {'1': 'extension_request', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentExtensionRequest', '10': 'extensionRequest'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'request_id', '3': 4, '4': 1, '5': 9, '10': 'requestId'},
  ],
};

/// Descriptor for `RequestInvoicePaymentExtensionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestInvoicePaymentExtensionResponseDescriptor = $convert.base64Decode(
    'CiZSZXF1ZXN0SW52b2ljZVBheW1lbnRFeHRlbnNpb25SZXNwb25zZRJIChFleHRlbnNpb25fcm'
    'VxdWVzdBgBIAEoCzIbLnBiLlBheW1lbnRFeHRlbnNpb25SZXF1ZXN0UhBleHRlbnNpb25SZXF1'
    'ZXN0EhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZR'
    'IdCgpyZXF1ZXN0X2lkGAQgASgJUglyZXF1ZXN0SWQ=');

@$core.Deprecated('Use approveInvoicePaymentExtensionRequestDescriptor instead')
const ApproveInvoicePaymentExtensionRequest$json = {
  '1': 'ApproveInvoicePaymentExtensionRequest',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'approved', '3': 2, '4': 1, '5': 8, '10': 'approved'},
    {'1': 'approval_reason', '3': 3, '4': 1, '5': 9, '10': 'approvalReason'},
    {'1': 'approved_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'approvedDate'},
  ],
};

/// Descriptor for `ApproveInvoicePaymentExtensionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approveInvoicePaymentExtensionRequestDescriptor = $convert.base64Decode(
    'CiVBcHByb3ZlSW52b2ljZVBheW1lbnRFeHRlbnNpb25SZXF1ZXN0Eh0KCnJlcXVlc3RfaWQYAS'
    'ABKAlSCXJlcXVlc3RJZBIaCghhcHByb3ZlZBgCIAEoCFIIYXBwcm92ZWQSJwoPYXBwcm92YWxf'
    'cmVhc29uGAMgASgJUg5hcHByb3ZhbFJlYXNvbhI/Cg1hcHByb3ZlZF9kYXRlGAQgASgLMhouZ2'
    '9vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMYXBwcm92ZWREYXRl');

@$core.Deprecated('Use approveInvoicePaymentExtensionResponseDescriptor instead')
const ApproveInvoicePaymentExtensionResponse$json = {
  '1': 'ApproveInvoicePaymentExtensionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'updated_request', '3': 3, '4': 1, '5': 11, '6': '.pb.PaymentExtensionRequest', '10': 'updatedRequest'},
  ],
};

/// Descriptor for `ApproveInvoicePaymentExtensionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approveInvoicePaymentExtensionResponseDescriptor = $convert.base64Decode(
    'CiZBcHByb3ZlSW52b2ljZVBheW1lbnRFeHRlbnNpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgAS'
    'gIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USRAoPdXBkYXRlZF9yZXF1ZXN0'
    'GAMgASgLMhsucGIuUGF5bWVudEV4dGVuc2lvblJlcXVlc3RSDnVwZGF0ZWRSZXF1ZXN0');

@$core.Deprecated('Use disputeInvoicePaymentRequestDescriptor instead')
const DisputeInvoicePaymentRequest$json = {
  '1': 'DisputeInvoicePaymentRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'evidence_files', '3': 4, '4': 3, '5': 9, '10': 'evidenceFiles'},
    {'1': 'disputed_amount', '3': 5, '4': 1, '5': 1, '10': 'disputedAmount'},
  ],
};

/// Descriptor for `DisputeInvoicePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disputeInvoicePaymentRequestDescriptor = $convert.base64Decode(
    'ChxEaXNwdXRlSW52b2ljZVBheW1lbnRSZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgASgJUg'
    '10cmFuc2FjdGlvbklkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29uEiAKC2Rlc2NyaXB0aW9uGAMg'
    'ASgJUgtkZXNjcmlwdGlvbhIlCg5ldmlkZW5jZV9maWxlcxgEIAMoCVINZXZpZGVuY2VGaWxlcx'
    'InCg9kaXNwdXRlZF9hbW91bnQYBSABKAFSDmRpc3B1dGVkQW1vdW50');

@$core.Deprecated('Use disputeInvoicePaymentResponseDescriptor instead')
const DisputeInvoicePaymentResponse$json = {
  '1': 'DisputeInvoicePaymentResponse',
  '2': [
    {'1': 'dispute', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentDispute', '10': 'dispute'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'dispute_id', '3': 4, '4': 1, '5': 9, '10': 'disputeId'},
  ],
};

/// Descriptor for `DisputeInvoicePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disputeInvoicePaymentResponseDescriptor = $convert.base64Decode(
    'Ch1EaXNwdXRlSW52b2ljZVBheW1lbnRSZXNwb25zZRIsCgdkaXNwdXRlGAEgASgLMhIucGIuUG'
    'F5bWVudERpc3B1dGVSB2Rpc3B1dGUSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNz'
    'YWdlGAMgASgJUgdtZXNzYWdlEh0KCmRpc3B1dGVfaWQYBCABKAlSCWRpc3B1dGVJZA==');

@$core.Deprecated('Use resolveInvoicePaymentDisputeRequestDescriptor instead')
const ResolveInvoicePaymentDisputeRequest$json = {
  '1': 'ResolveInvoicePaymentDisputeRequest',
  '2': [
    {'1': 'dispute_id', '3': 1, '4': 1, '5': 9, '10': 'disputeId'},
    {'1': 'resolution', '3': 2, '4': 1, '5': 9, '10': 'resolution'},
    {'1': 'refund_amount', '3': 3, '4': 1, '5': 1, '10': 'refundAmount'},
    {'1': 'resolution_notes', '3': 4, '4': 1, '5': 9, '10': 'resolutionNotes'},
  ],
};

/// Descriptor for `ResolveInvoicePaymentDisputeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveInvoicePaymentDisputeRequestDescriptor = $convert.base64Decode(
    'CiNSZXNvbHZlSW52b2ljZVBheW1lbnREaXNwdXRlUmVxdWVzdBIdCgpkaXNwdXRlX2lkGAEgAS'
    'gJUglkaXNwdXRlSWQSHgoKcmVzb2x1dGlvbhgCIAEoCVIKcmVzb2x1dGlvbhIjCg1yZWZ1bmRf'
    'YW1vdW50GAMgASgBUgxyZWZ1bmRBbW91bnQSKQoQcmVzb2x1dGlvbl9ub3RlcxgEIAEoCVIPcm'
    'Vzb2x1dGlvbk5vdGVz');

@$core.Deprecated('Use resolveInvoicePaymentDisputeResponseDescriptor instead')
const ResolveInvoicePaymentDisputeResponse$json = {
  '1': 'ResolveInvoicePaymentDisputeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'updated_dispute', '3': 3, '4': 1, '5': 11, '6': '.pb.PaymentDispute', '10': 'updatedDispute'},
    {'1': 'refund_transaction_id', '3': 4, '4': 1, '5': 9, '10': 'refundTransactionId'},
  ],
};

/// Descriptor for `ResolveInvoicePaymentDisputeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveInvoicePaymentDisputeResponseDescriptor = $convert.base64Decode(
    'CiRSZXNvbHZlSW52b2ljZVBheW1lbnREaXNwdXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCF'
    'IHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjsKD3VwZGF0ZWRfZGlzcHV0ZRgD'
    'IAEoCzISLnBiLlBheW1lbnREaXNwdXRlUg51cGRhdGVkRGlzcHV0ZRIyChVyZWZ1bmRfdHJhbn'
    'NhY3Rpb25faWQYBCABKAlSE3JlZnVuZFRyYW5zYWN0aW9uSWQ=');

@$core.Deprecated('Use getInvoicePaymentHistoryRequestDescriptor instead')
const GetInvoicePaymentHistoryRequest$json = {
  '1': 'GetInvoicePaymentHistoryRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 4, '4': 1, '5': 9, '10': 'pageToken'},
    {'1': 'status_filter', '3': 5, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetInvoicePaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentHistoryRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRJbnZvaWNlUGF5bWVudEhpc3RvcnlSZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKAsyGi'
    '5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRlEhsKCXBhZ2Vfc2l6ZRgDIAEoBV'
    'IIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgEIAEoCVIJcGFnZVRva2VuEj0KDXN0YXR1c19maWx0'
    'ZXIYBSABKA4yGC5wYi5JbnZvaWNlUGF5bWVudFN0YXR1c1IMc3RhdHVzRmlsdGVy');

@$core.Deprecated('Use getInvoicePaymentHistoryResponseDescriptor instead')
const GetInvoicePaymentHistoryResponse$json = {
  '1': 'GetInvoicePaymentHistoryResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.InvoicePaymentTransaction', '10': 'transactions'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetInvoicePaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentHistoryResponseDescriptor = $convert.base64Decode(
    'CiBHZXRJbnZvaWNlUGF5bWVudEhpc3RvcnlSZXNwb25zZRJBCgx0cmFuc2FjdGlvbnMYASADKA'
    'syHS5wYi5JbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSJgoPbmV4dF9w'
    'YWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2VuEh8KC3RvdGFsX2NvdW50GAMgASgEUgp0b3'
    'RhbENvdW50');

@$core.Deprecated('Use getInvoicePaymentStatisticsRequestDescriptor instead')
const GetInvoicePaymentStatisticsRequest$json = {
  '1': 'GetInvoicePaymentStatisticsRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `GetInvoicePaymentStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentStatisticsRequestDescriptor = $convert.base64Decode(
    'CiJHZXRJbnZvaWNlUGF5bWVudFN0YXRpc3RpY3NSZXF1ZXN0EjkKCnN0YXJ0X2RhdGUYASABKA'
    'syGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglzdGFydERhdGUSNQoIZW5kX2RhdGUYAiAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmREYXRl');

@$core.Deprecated('Use getInvoicePaymentStatisticsResponseDescriptor instead')
const GetInvoicePaymentStatisticsResponse$json = {
  '1': 'GetInvoicePaymentStatisticsResponse',
  '2': [
    {'1': 'total_payments', '3': 1, '4': 1, '5': 4, '10': 'totalPayments'},
    {'1': 'successful_payments', '3': 2, '4': 1, '5': 4, '10': 'successfulPayments'},
    {'1': 'failed_payments', '3': 3, '4': 1, '5': 4, '10': 'failedPayments'},
    {'1': 'total_amount', '3': 4, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'total_fees', '3': 5, '4': 1, '5': 1, '10': 'totalFees'},
    {'1': 'average_payment_amount', '3': 6, '4': 1, '5': 1, '10': 'averagePaymentAmount'},
    {'1': 'payment_method_usage', '3': 7, '4': 3, '5': 11, '6': '.pb.GetInvoicePaymentStatisticsResponse.PaymentMethodUsageEntry', '10': 'paymentMethodUsage'},
    {'1': 'success_rate', '3': 8, '4': 1, '5': 1, '10': 'successRate'},
  ],
  '3': [GetInvoicePaymentStatisticsResponse_PaymentMethodUsageEntry$json],
};

@$core.Deprecated('Use getInvoicePaymentStatisticsResponseDescriptor instead')
const GetInvoicePaymentStatisticsResponse_PaymentMethodUsageEntry$json = {
  '1': 'PaymentMethodUsageEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 4, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInvoicePaymentStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentStatisticsResponseDescriptor = $convert.base64Decode(
    'CiNHZXRJbnZvaWNlUGF5bWVudFN0YXRpc3RpY3NSZXNwb25zZRIlCg50b3RhbF9wYXltZW50cx'
    'gBIAEoBFINdG90YWxQYXltZW50cxIvChNzdWNjZXNzZnVsX3BheW1lbnRzGAIgASgEUhJzdWNj'
    'ZXNzZnVsUGF5bWVudHMSJwoPZmFpbGVkX3BheW1lbnRzGAMgASgEUg5mYWlsZWRQYXltZW50cx'
    'IhCgx0b3RhbF9hbW91bnQYBCABKAFSC3RvdGFsQW1vdW50Eh0KCnRvdGFsX2ZlZXMYBSABKAFS'
    'CXRvdGFsRmVlcxI0ChZhdmVyYWdlX3BheW1lbnRfYW1vdW50GAYgASgBUhRhdmVyYWdlUGF5bW'
    'VudEFtb3VudBJxChRwYXltZW50X21ldGhvZF91c2FnZRgHIAMoCzI/LnBiLkdldEludm9pY2VQ'
    'YXltZW50U3RhdGlzdGljc1Jlc3BvbnNlLlBheW1lbnRNZXRob2RVc2FnZUVudHJ5UhJwYXltZW'
    '50TWV0aG9kVXNhZ2USIQoMc3VjY2Vzc19yYXRlGAggASgBUgtzdWNjZXNzUmF0ZRpFChdQYXlt'
    'ZW50TWV0aG9kVXNhZ2VFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoBFIFdm'
    'FsdWU6AjgB');

@$core.Deprecated('Use getRecentInvoicePaymentTransactionsRequestDescriptor instead')
const GetRecentInvoicePaymentTransactionsRequest$json = {
  '1': 'GetRecentInvoicePaymentTransactionsRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetRecentInvoicePaymentTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentInvoicePaymentTransactionsRequestDescriptor = $convert.base64Decode(
    'CipHZXRSZWNlbnRJbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uc1JlcXVlc3QSFAoFbGltaXQYAS'
    'ABKAVSBWxpbWl0');

@$core.Deprecated('Use getRecentInvoicePaymentTransactionsResponseDescriptor instead')
const GetRecentInvoicePaymentTransactionsResponse$json = {
  '1': 'GetRecentInvoicePaymentTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.InvoicePaymentTransaction', '10': 'transactions'},
  ],
};

/// Descriptor for `GetRecentInvoicePaymentTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentInvoicePaymentTransactionsResponseDescriptor = $convert.base64Decode(
    'CitHZXRSZWNlbnRJbnZvaWNlUGF5bWVudFRyYW5zYWN0aW9uc1Jlc3BvbnNlEkEKDHRyYW5zYW'
    'N0aW9ucxgBIAMoCzIdLnBiLkludm9pY2VQYXltZW50VHJhbnNhY3Rpb25SDHRyYW5zYWN0aW9u'
    'cw==');

@$core.Deprecated('Use generateInvoicePaymentReceiptRequestDescriptor instead')
const GenerateInvoicePaymentReceiptRequest$json = {
  '1': 'GenerateInvoicePaymentReceiptRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'template_id', '3': 2, '4': 1, '5': 9, '10': 'templateId'},
    {'1': 'include_invoice_details', '3': 3, '4': 1, '5': 8, '10': 'includeInvoiceDetails'},
  ],
};

/// Descriptor for `GenerateInvoicePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateInvoicePaymentReceiptRequestDescriptor = $convert.base64Decode(
    'CiRHZW5lcmF0ZUludm9pY2VQYXltZW50UmVjZWlwdFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faW'
    'QYASABKAlSDXRyYW5zYWN0aW9uSWQSHwoLdGVtcGxhdGVfaWQYAiABKAlSCnRlbXBsYXRlSWQS'
    'NgoXaW5jbHVkZV9pbnZvaWNlX2RldGFpbHMYAyABKAhSFWluY2x1ZGVJbnZvaWNlRGV0YWlscw'
    '==');

@$core.Deprecated('Use generateInvoicePaymentReceiptResponseDescriptor instead')
const GenerateInvoicePaymentReceiptResponse$json = {
  '1': 'GenerateInvoicePaymentReceiptResponse',
  '2': [
    {'1': 'receipt_url', '3': 1, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'receipt_data', '3': 2, '4': 1, '5': 12, '10': 'receiptData'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 4, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `GenerateInvoicePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateInvoicePaymentReceiptResponseDescriptor = $convert.base64Decode(
    'CiVHZW5lcmF0ZUludm9pY2VQYXltZW50UmVjZWlwdFJlc3BvbnNlEh8KC3JlY2VpcHRfdXJsGA'
    'EgASgJUgpyZWNlaXB0VXJsEiEKDHJlY2VpcHRfZGF0YRgCIAEoDFILcmVjZWlwdERhdGESGAoH'
    'bWVzc2FnZRgDIAEoCVIHbWVzc2FnZRIYCgdzdWNjZXNzGAQgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use emailInvoicePaymentReceiptRequestDescriptor instead')
const EmailInvoicePaymentReceiptRequest$json = {
  '1': 'EmailInvoicePaymentReceiptRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'custom_message', '3': 3, '4': 1, '5': 9, '10': 'customMessage'},
  ],
};

/// Descriptor for `EmailInvoicePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailInvoicePaymentReceiptRequestDescriptor = $convert.base64Decode(
    'CiFFbWFpbEludm9pY2VQYXltZW50UmVjZWlwdFJlcXVlc3QSJQoOdHJhbnNhY3Rpb25faWQYAS'
    'ABKAlSDXRyYW5zYWN0aW9uSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRF'
    'bWFpbBIlCg5jdXN0b21fbWVzc2FnZRgDIAEoCVINY3VzdG9tTWVzc2FnZQ==');

@$core.Deprecated('Use emailInvoicePaymentReceiptResponseDescriptor instead')
const EmailInvoicePaymentReceiptResponse$json = {
  '1': 'EmailInvoicePaymentReceiptResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'tracking_id', '3': 3, '4': 1, '5': 9, '10': 'trackingId'},
  ],
};

/// Descriptor for `EmailInvoicePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailInvoicePaymentReceiptResponseDescriptor = $convert.base64Decode(
    'CiJFbWFpbEludm9pY2VQYXltZW50UmVjZWlwdFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3'
    'N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIfCgt0cmFja2luZ19pZBgDIAEoCVIK'
    'dHJhY2tpbmdJZA==');

@$core.Deprecated('Use getInvoicePaymentReceiptRequestDescriptor instead')
const GetInvoicePaymentReceiptRequest$json = {
  '1': 'GetInvoicePaymentReceiptRequest',
  '2': [
    {'1': 'transaction_id', '3': 1, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `GetInvoicePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentReceiptRequestDescriptor = $convert.base64Decode(
    'Ch9HZXRJbnZvaWNlUGF5bWVudFJlY2VpcHRSZXF1ZXN0EiUKDnRyYW5zYWN0aW9uX2lkGAEgAS'
    'gJUg10cmFuc2FjdGlvbklk');

@$core.Deprecated('Use getInvoicePaymentReceiptResponseDescriptor instead')
const GetInvoicePaymentReceiptResponse$json = {
  '1': 'GetInvoicePaymentReceiptResponse',
  '2': [
    {'1': 'receipt_url', '3': 1, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'receipt_data', '3': 2, '4': 1, '5': 12, '10': 'receiptData'},
    {'1': 'generated_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'generatedAt'},
  ],
};

/// Descriptor for `GetInvoicePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentReceiptResponseDescriptor = $convert.base64Decode(
    'CiBHZXRJbnZvaWNlUGF5bWVudFJlY2VpcHRSZXNwb25zZRIfCgtyZWNlaXB0X3VybBgBIAEoCV'
    'IKcmVjZWlwdFVybBIhCgxyZWNlaXB0X2RhdGEYAiABKAxSC3JlY2VpcHREYXRhEj0KDGdlbmVy'
    'YXRlZF9hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2dlbmVyYXRlZEF0');

