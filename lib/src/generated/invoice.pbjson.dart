///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice$json = const {
  '1': 'Invoice',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'invoice_number', '3': 4, '4': 1, '5': 9, '10': 'invoiceNumber'},
    const {'1': 'recipient_email', '3': 5, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 6, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'due_date', '3': 11, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'items', '3': 12, '4': 3, '5': 11, '6': '.invoice.InvoiceItem', '10': 'items'},
    const {'1': 'tax', '3': 13, '4': 1, '5': 1, '10': 'tax'},
    const {'1': 'discount', '3': 14, '4': 1, '5': 1, '10': 'discount'},
    const {'1': 'total_amount', '3': 15, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'payment_reference', '3': 16, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'paid_at', '3': 17, '4': 1, '5': 9, '10': 'paidAt'},
    const {'1': 'notes', '3': 18, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'metadata', '3': 19, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
    const {'1': 'tagged_users', '3': 22, '4': 3, '5': 11, '6': '.invoice.TaggedUser', '10': 'taggedUsers'},
    const {'1': 'is_unlocked', '3': 23, '4': 1, '5': 8, '10': 'isUnlocked'},
    const {'1': 'unlock_payment_ref', '3': 24, '4': 1, '5': 9, '10': 'unlockPaymentRef'},
  ],
};

/// Descriptor for `Invoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceDescriptor = $convert.base64Decode('CgdJbnZvaWNlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYWNjb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEiUKDmludm9pY2VfbnVtYmVyGAQgASgJUg1pbnZvaWNlTnVtYmVyEicKD3JlY2lwaWVudF9lbWFpbBgFIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcmVjaXBpZW50X25hbWUYBiABKAlSDXJlY2lwaWVudE5hbWUSFgoGYW1vdW50GAcgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgJIAEoCVIGc3RhdHVzEiAKC2Rlc2NyaXB0aW9uGAogASgJUgtkZXNjcmlwdGlvbhIZCghkdWVfZGF0ZRgLIAEoCVIHZHVlRGF0ZRIqCgVpdGVtcxgMIAMoCzIULmludm9pY2UuSW52b2ljZUl0ZW1SBWl0ZW1zEhAKA3RheBgNIAEoAVIDdGF4EhoKCGRpc2NvdW50GA4gASgBUghkaXNjb3VudBIhCgx0b3RhbF9hbW91bnQYDyABKAFSC3RvdGFsQW1vdW50EisKEXBheW1lbnRfcmVmZXJlbmNlGBAgASgJUhBwYXltZW50UmVmZXJlbmNlEhcKB3BhaWRfYXQYESABKAlSBnBhaWRBdBIUCgVub3RlcxgSIAEoCVIFbm90ZXMSGgoIbWV0YWRhdGEYEyABKAlSCG1ldGFkYXRhEh0KCmNyZWF0ZWRfYXQYFCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GBUgASgJUgl1cGRhdGVkQXQSNgoMdGFnZ2VkX3VzZXJzGBYgAygLMhMuaW52b2ljZS5UYWdnZWRVc2VyUgt0YWdnZWRVc2VycxIfCgtpc191bmxvY2tlZBgXIAEoCFIKaXNVbmxvY2tlZBIsChJ1bmxvY2tfcGF5bWVudF9yZWYYGCABKAlSEHVubG9ja1BheW1lbnRSZWY=');
@$core.Deprecated('Use invoiceItemDescriptor instead')
const InvoiceItem$json = const {
  '1': 'InvoiceItem',
  '2': const [
    const {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'quantity', '3': 2, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'unit_price', '3': 3, '4': 1, '5': 1, '10': 'unitPrice'},
    const {'1': 'total', '3': 4, '4': 1, '5': 1, '10': 'total'},
  ],
};

/// Descriptor for `InvoiceItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceItemDescriptor = $convert.base64Decode('CgtJbnZvaWNlSXRlbRIgCgtkZXNjcmlwdGlvbhgBIAEoCVILZGVzY3JpcHRpb24SGgoIcXVhbnRpdHkYAiABKAVSCHF1YW50aXR5Eh0KCnVuaXRfcHJpY2UYAyABKAFSCXVuaXRQcmljZRIUCgV0b3RhbBgEIAEoAVIFdG90YWw=');
@$core.Deprecated('Use taggedUserDescriptor instead')
const TaggedUser$json = const {
  '1': 'TaggedUser',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'profile_picture', '3': 5, '4': 1, '5': 9, '10': 'profilePicture'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'tagged_at', '3': 7, '4': 1, '5': 9, '10': 'taggedAt'},
    const {'1': 'viewed_at', '3': 8, '4': 1, '5': 9, '10': 'viewedAt'},
    const {'1': 'paid_at', '3': 9, '4': 1, '5': 9, '10': 'paidAt'},
  ],
};

/// Descriptor for `TaggedUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taggedUserDescriptor = $convert.base64Decode('CgpUYWdnZWRVc2VyEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSJwoPcHJvZmlsZV9waWN0dXJlGAUgASgJUg5wcm9maWxlUGljdHVyZRIWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIbCgl0YWdnZWRfYXQYByABKAlSCHRhZ2dlZEF0EhsKCXZpZXdlZF9hdBgIIAEoCVIIdmlld2VkQXQSFwoHcGFpZF9hdBgJIAEoCVIGcGFpZEF0');
@$core.Deprecated('Use invoiceStatisticsDescriptor instead')
const InvoiceStatistics$json = const {
  '1': 'InvoiceStatistics',
  '2': const [
    const {'1': 'total_sent', '3': 1, '4': 1, '5': 5, '10': 'totalSent'},
    const {'1': 'total_received', '3': 2, '4': 1, '5': 5, '10': 'totalReceived'},
    const {'1': 'total_paid', '3': 3, '4': 1, '5': 5, '10': 'totalPaid'},
    const {'1': 'total_pending', '3': 4, '4': 1, '5': 5, '10': 'totalPending'},
    const {'1': 'total_overdue', '3': 5, '4': 1, '5': 5, '10': 'totalOverdue'},
    const {'1': 'total_amount_sent', '3': 6, '4': 1, '5': 1, '10': 'totalAmountSent'},
    const {'1': 'total_amount_received', '3': 7, '4': 1, '5': 1, '10': 'totalAmountReceived'},
    const {'1': 'total_amount_paid', '3': 8, '4': 1, '5': 1, '10': 'totalAmountPaid'},
    const {'1': 'total_amount_pending', '3': 9, '4': 1, '5': 1, '10': 'totalAmountPending'},
    const {'1': 'total_amount_overdue', '3': 10, '4': 1, '5': 1, '10': 'totalAmountOverdue'},
    const {'1': 'collection_rate', '3': 11, '4': 1, '5': 1, '10': 'collectionRate'},
  ],
};

/// Descriptor for `InvoiceStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceStatisticsDescriptor = $convert.base64Decode('ChFJbnZvaWNlU3RhdGlzdGljcxIdCgp0b3RhbF9zZW50GAEgASgFUgl0b3RhbFNlbnQSJQoOdG90YWxfcmVjZWl2ZWQYAiABKAVSDXRvdGFsUmVjZWl2ZWQSHQoKdG90YWxfcGFpZBgDIAEoBVIJdG90YWxQYWlkEiMKDXRvdGFsX3BlbmRpbmcYBCABKAVSDHRvdGFsUGVuZGluZxIjCg10b3RhbF9vdmVyZHVlGAUgASgFUgx0b3RhbE92ZXJkdWUSKgoRdG90YWxfYW1vdW50X3NlbnQYBiABKAFSD3RvdGFsQW1vdW50U2VudBIyChV0b3RhbF9hbW91bnRfcmVjZWl2ZWQYByABKAFSE3RvdGFsQW1vdW50UmVjZWl2ZWQSKgoRdG90YWxfYW1vdW50X3BhaWQYCCABKAFSD3RvdGFsQW1vdW50UGFpZBIwChR0b3RhbF9hbW91bnRfcGVuZGluZxgJIAEoAVISdG90YWxBbW91bnRQZW5kaW5nEjAKFHRvdGFsX2Ftb3VudF9vdmVyZHVlGAogASgBUhJ0b3RhbEFtb3VudE92ZXJkdWUSJwoPY29sbGVjdGlvbl9yYXRlGAsgASgBUg5jb2xsZWN0aW9uUmF0ZQ==');
@$core.Deprecated('Use createInvoiceRequestDescriptor instead')
const CreateInvoiceRequest$json = const {
  '1': 'CreateInvoiceRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'due_date', '3': 6, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'items', '3': 7, '4': 3, '5': 11, '6': '.invoice.InvoiceItem', '10': 'items'},
    const {'1': 'tax', '3': 8, '4': 1, '5': 1, '10': 'tax'},
    const {'1': 'discount', '3': 9, '4': 1, '5': 1, '10': 'discount'},
    const {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'tagged_user_ids', '3': 11, '4': 3, '5': 9, '10': 'taggedUserIds'},
    const {'1': 'idempotency_key', '3': 12, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `CreateInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvoiceRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVJbnZvaWNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGllbnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SGQoIZHVlX2RhdGUYBiABKAlSB2R1ZURhdGUSKgoFaXRlbXMYByADKAsyFC5pbnZvaWNlLkludm9pY2VJdGVtUgVpdGVtcxIQCgN0YXgYCCABKAFSA3RheBIaCghkaXNjb3VudBgJIAEoAVIIZGlzY291bnQSFAoFbm90ZXMYCiABKAlSBW5vdGVzEiYKD3RhZ2dlZF91c2VyX2lkcxgLIAMoCVINdGFnZ2VkVXNlcklkcxInCg9pZGVtcG90ZW5jeV9rZXkYDCABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use createInvoiceResponseDescriptor instead')
const CreateInvoiceResponse$json = const {
  '1': 'CreateInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvoiceResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZVIHaW52b2ljZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getInvoicesRequestDescriptor instead')
const GetInvoicesRequest$json = const {
  '1': 'GetInvoicesRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 6, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesRequestDescriptor = $convert.base64Decode('ChJHZXRJbnZvaWNlc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEh0KCnN0YXJ0X2RhdGUYAyABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgEIAEoCVIHZW5kRGF0ZRIUCgVsaW1pdBgFIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAYgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getInvoicesResponseDescriptor instead')
const GetInvoicesResponse$json = const {
  '1': 'GetInvoicesResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.invoice.Invoice', '10': 'invoices'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_amount_pending', '3': 3, '4': 1, '5': 1, '10': 'totalAmountPending'},
    const {'1': 'total_amount_paid', '3': 4, '4': 1, '5': 1, '10': 'totalAmountPaid'},
  ],
};

/// Descriptor for `GetInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesResponseDescriptor = $convert.base64Decode('ChNHZXRJbnZvaWNlc1Jlc3BvbnNlEiwKCGludm9pY2VzGAEgAygLMhAuaW52b2ljZS5JbnZvaWNlUghpbnZvaWNlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSMAoUdG90YWxfYW1vdW50X3BlbmRpbmcYAyABKAFSEnRvdGFsQW1vdW50UGVuZGluZxIqChF0b3RhbF9hbW91bnRfcGFpZBgEIAEoAVIPdG90YWxBbW91bnRQYWlk');
@$core.Deprecated('Use getInvoiceRequestDescriptor instead')
const GetInvoiceRequest$json = const {
  '1': 'GetInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `GetInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceRequestDescriptor = $convert.base64Decode('ChFHZXRJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQ=');
@$core.Deprecated('Use getInvoiceResponseDescriptor instead')
const GetInvoiceResponse$json = const {
  '1': 'GetInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
  ],
};

/// Descriptor for `GetInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceResponseDescriptor = $convert.base64Decode('ChJHZXRJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZVIHaW52b2ljZQ==');
@$core.Deprecated('Use payInvoiceRequestDescriptor instead')
const PayInvoiceRequest$json = const {
  '1': 'PayInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'idempotency_key', '3': 4, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `PayInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInvoiceRequestDescriptor = $convert.base64Decode('ChFQYXlJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhAKA3BpbhgDIAEoCVIDcGluEicKD2lkZW1wb3RlbmN5X2tleRgEIAEoCVIOaWRlbXBvdGVuY3lLZXkSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAUgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use payInvoiceResponseDescriptor instead')
const PayInvoiceResponse$json = const {
  '1': 'PayInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'payment_reference', '3': 3, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInvoiceResponseDescriptor = $convert.base64Decode('ChJQYXlJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZVIHaW52b2ljZRIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIrChFwYXltZW50X3JlZmVyZW5jZRgDIAEoCVIQcGF5bWVudFJlZmVyZW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use cancelInvoiceRequestDescriptor instead')
const CancelInvoiceRequest$json = const {
  '1': 'CancelInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoiceRequestDescriptor = $convert.base64Decode('ChRDYW5jZWxJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');
@$core.Deprecated('Use cancelInvoiceResponseDescriptor instead')
const CancelInvoiceResponse$json = const {
  '1': 'CancelInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoiceResponseDescriptor = $convert.base64Decode('ChVDYW5jZWxJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZVIHaW52b2ljZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use sendInvoiceReminderRequestDescriptor instead')
const SendInvoiceReminderRequest$json = const {
  '1': 'SendInvoiceReminderRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `SendInvoiceReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendInvoiceReminderRequestDescriptor = $convert.base64Decode('ChpTZW5kSW52b2ljZVJlbWluZGVyUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQ=');
@$core.Deprecated('Use sendInvoiceReminderResponseDescriptor instead')
const SendInvoiceReminderResponse$json = const {
  '1': 'SendInvoiceReminderResponse',
  '2': const [
    const {'1': 'sent', '3': 1, '4': 1, '5': 8, '10': 'sent'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SendInvoiceReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendInvoiceReminderResponseDescriptor = $convert.base64Decode('ChtTZW5kSW52b2ljZVJlbWluZGVyUmVzcG9uc2USEgoEc2VudBgBIAEoCFIEc2VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use updateInvoiceStatusRequestDescriptor instead')
const UpdateInvoiceStatusRequest$json = const {
  '1': 'UpdateInvoiceStatusRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `UpdateInvoiceStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceStatusRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVJbnZvaWNlU3RhdHVzUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use updateInvoiceStatusResponseDescriptor instead')
const UpdateInvoiceStatusResponse$json = const {
  '1': 'UpdateInvoiceStatusResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInvoiceStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceStatusResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVJbnZvaWNlU3RhdHVzUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZVIHaW52b2ljZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use tagUsersToInvoiceRequestDescriptor instead')
const TagUsersToInvoiceRequest$json = const {
  '1': 'TagUsersToInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_ids', '3': 2, '4': 3, '5': 9, '10': 'userIds'},
  ],
};

/// Descriptor for `TagUsersToInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagUsersToInvoiceRequestDescriptor = $convert.base64Decode('ChhUYWdVc2Vyc1RvSW52b2ljZVJlcXVlc3QSHQoKaW52b2ljZV9pZBgBIAEoCVIJaW52b2ljZUlkEhkKCHVzZXJfaWRzGAIgAygJUgd1c2VySWRz');
@$core.Deprecated('Use tagUsersToInvoiceResponseDescriptor instead')
const TagUsersToInvoiceResponse$json = const {
  '1': 'TagUsersToInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'users_tagged', '3': 3, '4': 1, '5': 5, '10': 'usersTagged'},
  ],
};

/// Descriptor for `TagUsersToInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagUsersToInvoiceResponseDescriptor = $convert.base64Decode('ChlUYWdVc2Vyc1RvSW52b2ljZVJlc3BvbnNlEioKB2ludm9pY2UYASABKAsyEC5pbnZvaWNlLkludm9pY2VSB2ludm9pY2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIhCgx1c2Vyc190YWdnZWQYAyABKAVSC3VzZXJzVGFnZ2Vk');
@$core.Deprecated('Use getInvoicesTaggedToUserRequestDescriptor instead')
const GetInvoicesTaggedToUserRequest$json = const {
  '1': 'GetInvoicesTaggedToUserRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetInvoicesTaggedToUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesTaggedToUserRequestDescriptor = $convert.base64Decode('Ch5HZXRJbnZvaWNlc1RhZ2dlZFRvVXNlclJlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getInvoicesTaggedToUserResponseDescriptor instead')
const GetInvoicesTaggedToUserResponse$json = const {
  '1': 'GetInvoicesTaggedToUserResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.invoice.Invoice', '10': 'invoices'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_amount_pending', '3': 3, '4': 1, '5': 1, '10': 'totalAmountPending'},
    const {'1': 'total_amount_paid', '3': 4, '4': 1, '5': 1, '10': 'totalAmountPaid'},
  ],
};

/// Descriptor for `GetInvoicesTaggedToUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesTaggedToUserResponseDescriptor = $convert.base64Decode('Ch9HZXRJbnZvaWNlc1RhZ2dlZFRvVXNlclJlc3BvbnNlEiwKCGludm9pY2VzGAEgAygLMhAuaW52b2ljZS5JbnZvaWNlUghpbnZvaWNlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSMAoUdG90YWxfYW1vdW50X3BlbmRpbmcYAyABKAFSEnRvdGFsQW1vdW50UGVuZGluZxIqChF0b3RhbF9hbW91bnRfcGFpZBgEIAEoAVIPdG90YWxBbW91bnRQYWlk');
@$core.Deprecated('Use getSentInvoicesRequestDescriptor instead')
const GetSentInvoicesRequest$json = const {
  '1': 'GetSentInvoicesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetSentInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSentInvoicesRequestDescriptor = $convert.base64Decode('ChZHZXRTZW50SW52b2ljZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldA==');
@$core.Deprecated('Use getSentInvoicesResponseDescriptor instead')
const GetSentInvoicesResponse$json = const {
  '1': 'GetSentInvoicesResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.invoice.Invoice', '10': 'invoices'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_amount_pending', '3': 3, '4': 1, '5': 1, '10': 'totalAmountPending'},
    const {'1': 'total_amount_paid', '3': 4, '4': 1, '5': 1, '10': 'totalAmountPaid'},
  ],
};

/// Descriptor for `GetSentInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSentInvoicesResponseDescriptor = $convert.base64Decode('ChdHZXRTZW50SW52b2ljZXNSZXNwb25zZRIsCghpbnZvaWNlcxgBIAMoCzIQLmludm9pY2UuSW52b2ljZVIIaW52b2ljZXMSFAoFdG90YWwYAiABKAVSBXRvdGFsEjAKFHRvdGFsX2Ftb3VudF9wZW5kaW5nGAMgASgBUhJ0b3RhbEFtb3VudFBlbmRpbmcSKgoRdG90YWxfYW1vdW50X3BhaWQYBCABKAFSD3RvdGFsQW1vdW50UGFpZA==');
@$core.Deprecated('Use updateInvoiceRequestDescriptor instead')
const UpdateInvoiceRequest$json = const {
  '1': 'UpdateInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    const {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'due_date', '3': 6, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'items', '3': 7, '4': 3, '5': 11, '6': '.invoice.InvoiceItem', '10': 'items'},
    const {'1': 'tax', '3': 8, '4': 1, '5': 1, '10': 'tax'},
    const {'1': 'discount', '3': 9, '4': 1, '5': 1, '10': 'discount'},
    const {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSJwoPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGllbnRfbmFtZRgDIAEoCVINcmVjaXBpZW50TmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SGQoIZHVlX2RhdGUYBiABKAlSB2R1ZURhdGUSKgoFaXRlbXMYByADKAsyFC5pbnZvaWNlLkludm9pY2VJdGVtUgVpdGVtcxIQCgN0YXgYCCABKAFSA3RheBIaCghkaXNjb3VudBgJIAEoAVIIZGlzY291bnQSFAoFbm90ZXMYCiABKAlSBW5vdGVz');
@$core.Deprecated('Use updateInvoiceResponseDescriptor instead')
const UpdateInvoiceResponse$json = const {
  '1': 'UpdateInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceResponseDescriptor = $convert.base64Decode('ChVVcGRhdGVJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZVIHaW52b2ljZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteInvoiceRequestDescriptor instead')
const DeleteInvoiceRequest$json = const {
  '1': 'DeleteInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `DeleteInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInvoiceRequestDescriptor = $convert.base64Decode('ChREZWxldGVJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQ=');
@$core.Deprecated('Use deleteInvoiceResponseDescriptor instead')
const DeleteInvoiceResponse$json = const {
  '1': 'DeleteInvoiceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInvoiceResponseDescriptor = $convert.base64Decode('ChVEZWxldGVJbnZvaWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getInvoiceStatisticsRequestDescriptor instead')
const GetInvoiceStatisticsRequest$json = const {
  '1': 'GetInvoiceStatisticsRequest',
};

/// Descriptor for `GetInvoiceStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceStatisticsRequestDescriptor = $convert.base64Decode('ChtHZXRJbnZvaWNlU3RhdGlzdGljc1JlcXVlc3Q=');
@$core.Deprecated('Use getInvoiceStatisticsResponseDescriptor instead')
const GetInvoiceStatisticsResponse$json = const {
  '1': 'GetInvoiceStatisticsResponse',
  '2': const [
    const {'1': 'statistics', '3': 1, '4': 1, '5': 11, '6': '.invoice.InvoiceStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetInvoiceStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceStatisticsResponseDescriptor = $convert.base64Decode('ChxHZXRJbnZvaWNlU3RhdGlzdGljc1Jlc3BvbnNlEjoKCnN0YXRpc3RpY3MYASABKAsyGi5pbnZvaWNlLkludm9pY2VTdGF0aXN0aWNzUgpzdGF0aXN0aWNz');
@$core.Deprecated('Use unlockInvoiceRequestDescriptor instead')
const UnlockInvoiceRequest$json = const {
  '1': 'UnlockInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'idempotency_key', '3': 4, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `UnlockInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockInvoiceRequestDescriptor = $convert.base64Decode('ChRVbmxvY2tJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSHQoKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhAKA3BpbhgDIAEoCVIDcGluEicKD2lkZW1wb3RlbmN5X2tleRgEIAEoCVIOaWRlbXBvdGVuY3lLZXkSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAUgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rpb25JZA==');
@$core.Deprecated('Use unlockInvoiceResponseDescriptor instead')
const UnlockInvoiceResponse$json = const {
  '1': 'UnlockInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'unlock_payment_ref', '3': 3, '4': 1, '5': 9, '10': 'unlockPaymentRef'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnlockInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockInvoiceResponseDescriptor = $convert.base64Decode('ChVVbmxvY2tJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZVIHaW52b2ljZRIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIsChJ1bmxvY2tfcGF5bWVudF9yZWYYAyABKAlSEHVubG9ja1BheW1lbnRSZWYSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
