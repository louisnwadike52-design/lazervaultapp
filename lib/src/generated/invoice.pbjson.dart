//
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice$json = {
  '1': 'Invoice',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'invoice_number', '3': 4, '4': 1, '5': 9, '10': 'invoiceNumber'},
    {'1': 'recipient_email', '3': 5, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 6, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    {'1': 'due_date', '3': 11, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'items', '3': 12, '4': 3, '5': 11, '6': '.invoice.InvoiceItem', '10': 'items'},
    {'1': 'tax', '3': 13, '4': 1, '5': 1, '10': 'tax'},
    {'1': 'discount', '3': 14, '4': 1, '5': 1, '10': 'discount'},
    {'1': 'total_amount', '3': 15, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'payment_reference', '3': 16, '4': 1, '5': 9, '10': 'paymentReference'},
    {'1': 'paid_at', '3': 17, '4': 1, '5': 9, '10': 'paidAt'},
    {'1': 'notes', '3': 18, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'metadata', '3': 19, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'tagged_users', '3': 22, '4': 3, '5': 11, '6': '.invoice.TaggedUser', '10': 'taggedUsers'},
    {'1': 'is_unlocked', '3': 23, '4': 1, '5': 8, '10': 'isUnlocked'},
    {'1': 'unlock_payment_ref', '3': 24, '4': 1, '5': 9, '10': 'unlockPaymentRef'},
    {'1': 'payer_email', '3': 25, '4': 1, '5': 9, '10': 'payerEmail'},
    {'1': 'payer_logo_url', '3': 26, '4': 1, '5': 9, '10': 'payerLogoUrl'},
    {'1': 'recipient_logo_url', '3': 27, '4': 1, '5': 9, '10': 'recipientLogoUrl'},
  ],
};

/// Descriptor for `Invoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceDescriptor = $convert.base64Decode(
    'CgdJbnZvaWNlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSHQoKYW'
    'Njb3VudF9pZBgDIAEoCVIJYWNjb3VudElkEiUKDmludm9pY2VfbnVtYmVyGAQgASgJUg1pbnZv'
    'aWNlTnVtYmVyEicKD3JlY2lwaWVudF9lbWFpbBgFIAEoCVIOcmVjaXBpZW50RW1haWwSJQoOcm'
    'VjaXBpZW50X25hbWUYBiABKAlSDXJlY2lwaWVudE5hbWUSFgoGYW1vdW50GAcgASgBUgZhbW91'
    'bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgJIAEoCVIGc3RhdHVzEi'
    'AKC2Rlc2NyaXB0aW9uGAogASgJUgtkZXNjcmlwdGlvbhIZCghkdWVfZGF0ZRgLIAEoCVIHZHVl'
    'RGF0ZRIqCgVpdGVtcxgMIAMoCzIULmludm9pY2UuSW52b2ljZUl0ZW1SBWl0ZW1zEhAKA3RheB'
    'gNIAEoAVIDdGF4EhoKCGRpc2NvdW50GA4gASgBUghkaXNjb3VudBIhCgx0b3RhbF9hbW91bnQY'
    'DyABKAFSC3RvdGFsQW1vdW50EisKEXBheW1lbnRfcmVmZXJlbmNlGBAgASgJUhBwYXltZW50Um'
    'VmZXJlbmNlEhcKB3BhaWRfYXQYESABKAlSBnBhaWRBdBIUCgVub3RlcxgSIAEoCVIFbm90ZXMS'
    'GgoIbWV0YWRhdGEYEyABKAlSCG1ldGFkYXRhEh0KCmNyZWF0ZWRfYXQYFCABKAlSCWNyZWF0ZW'
    'RBdBIdCgp1cGRhdGVkX2F0GBUgASgJUgl1cGRhdGVkQXQSNgoMdGFnZ2VkX3VzZXJzGBYgAygL'
    'MhMuaW52b2ljZS5UYWdnZWRVc2VyUgt0YWdnZWRVc2VycxIfCgtpc191bmxvY2tlZBgXIAEoCF'
    'IKaXNVbmxvY2tlZBIsChJ1bmxvY2tfcGF5bWVudF9yZWYYGCABKAlSEHVubG9ja1BheW1lbnRS'
    'ZWYSHwoLcGF5ZXJfZW1haWwYGSABKAlSCnBheWVyRW1haWwSJAoOcGF5ZXJfbG9nb191cmwYGi'
    'ABKAlSDHBheWVyTG9nb1VybBIsChJyZWNpcGllbnRfbG9nb191cmwYGyABKAlSEHJlY2lwaWVu'
    'dExvZ29Vcmw=');

@$core.Deprecated('Use invoiceItemDescriptor instead')
const InvoiceItem$json = {
  '1': 'InvoiceItem',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    {'1': 'quantity', '3': 2, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'unit_price', '3': 3, '4': 1, '5': 1, '10': 'unitPrice'},
    {'1': 'total', '3': 4, '4': 1, '5': 1, '10': 'total'},
  ],
};

/// Descriptor for `InvoiceItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceItemDescriptor = $convert.base64Decode(
    'CgtJbnZvaWNlSXRlbRIgCgtkZXNjcmlwdGlvbhgBIAEoCVILZGVzY3JpcHRpb24SGgoIcXVhbn'
    'RpdHkYAiABKAVSCHF1YW50aXR5Eh0KCnVuaXRfcHJpY2UYAyABKAFSCXVuaXRQcmljZRIUCgV0'
    'b3RhbBgEIAEoAVIFdG90YWw=');

@$core.Deprecated('Use taggedUserDescriptor instead')
const TaggedUser$json = {
  '1': 'TaggedUser',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'profile_picture', '3': 5, '4': 1, '5': 9, '10': 'profilePicture'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'tagged_at', '3': 7, '4': 1, '5': 9, '10': 'taggedAt'},
    {'1': 'viewed_at', '3': 8, '4': 1, '5': 9, '10': 'viewedAt'},
    {'1': 'paid_at', '3': 9, '4': 1, '5': 9, '10': 'paidAt'},
  ],
};

/// Descriptor for `TaggedUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taggedUserDescriptor = $convert.base64Decode(
    'CgpUYWdnZWRVc2VyEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZRgCIAEoCV'
    'IIdXNlcm5hbWUSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgE'
    'IAEoCVIIbGFzdE5hbWUSJwoPcHJvZmlsZV9waWN0dXJlGAUgASgJUg5wcm9maWxlUGljdHVyZR'
    'IWCgZzdGF0dXMYBiABKAlSBnN0YXR1cxIbCgl0YWdnZWRfYXQYByABKAlSCHRhZ2dlZEF0EhsK'
    'CXZpZXdlZF9hdBgIIAEoCVIIdmlld2VkQXQSFwoHcGFpZF9hdBgJIAEoCVIGcGFpZEF0');

@$core.Deprecated('Use invoiceStatisticsDescriptor instead')
const InvoiceStatistics$json = {
  '1': 'InvoiceStatistics',
  '2': [
    {'1': 'total_sent', '3': 1, '4': 1, '5': 5, '10': 'totalSent'},
    {'1': 'total_received', '3': 2, '4': 1, '5': 5, '10': 'totalReceived'},
    {'1': 'total_paid', '3': 3, '4': 1, '5': 5, '10': 'totalPaid'},
    {'1': 'total_pending', '3': 4, '4': 1, '5': 5, '10': 'totalPending'},
    {'1': 'total_overdue', '3': 5, '4': 1, '5': 5, '10': 'totalOverdue'},
    {'1': 'total_amount_sent', '3': 6, '4': 1, '5': 1, '10': 'totalAmountSent'},
    {'1': 'total_amount_received', '3': 7, '4': 1, '5': 1, '10': 'totalAmountReceived'},
    {'1': 'total_amount_paid', '3': 8, '4': 1, '5': 1, '10': 'totalAmountPaid'},
    {'1': 'total_amount_pending', '3': 9, '4': 1, '5': 1, '10': 'totalAmountPending'},
    {'1': 'total_amount_overdue', '3': 10, '4': 1, '5': 1, '10': 'totalAmountOverdue'},
    {'1': 'collection_rate', '3': 11, '4': 1, '5': 1, '10': 'collectionRate'},
  ],
};

/// Descriptor for `InvoiceStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceStatisticsDescriptor = $convert.base64Decode(
    'ChFJbnZvaWNlU3RhdGlzdGljcxIdCgp0b3RhbF9zZW50GAEgASgFUgl0b3RhbFNlbnQSJQoOdG'
    '90YWxfcmVjZWl2ZWQYAiABKAVSDXRvdGFsUmVjZWl2ZWQSHQoKdG90YWxfcGFpZBgDIAEoBVIJ'
    'dG90YWxQYWlkEiMKDXRvdGFsX3BlbmRpbmcYBCABKAVSDHRvdGFsUGVuZGluZxIjCg10b3RhbF'
    '9vdmVyZHVlGAUgASgFUgx0b3RhbE92ZXJkdWUSKgoRdG90YWxfYW1vdW50X3NlbnQYBiABKAFS'
    'D3RvdGFsQW1vdW50U2VudBIyChV0b3RhbF9hbW91bnRfcmVjZWl2ZWQYByABKAFSE3RvdGFsQW'
    '1vdW50UmVjZWl2ZWQSKgoRdG90YWxfYW1vdW50X3BhaWQYCCABKAFSD3RvdGFsQW1vdW50UGFp'
    'ZBIwChR0b3RhbF9hbW91bnRfcGVuZGluZxgJIAEoAVISdG90YWxBbW91bnRQZW5kaW5nEjAKFH'
    'RvdGFsX2Ftb3VudF9vdmVyZHVlGAogASgBUhJ0b3RhbEFtb3VudE92ZXJkdWUSJwoPY29sbGVj'
    'dGlvbl9yYXRlGAsgASgBUg5jb2xsZWN0aW9uUmF0ZQ==');

@$core.Deprecated('Use invoicePaginationInfoDescriptor instead')
const InvoicePaginationInfo$json = {
  '1': 'InvoicePaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'total_count', '3': 3, '4': 1, '5': 5, '10': 'totalCount'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_previous', '3': 6, '4': 1, '5': 8, '10': 'hasPrevious'},
  ],
};

/// Descriptor for `InvoicePaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicePaginationInfoDescriptor = $convert.base64Decode(
    'ChVJbnZvaWNlUGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UG'
    'FnZRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEh8KC3RvdGFsX2NvdW50GAMgASgFUgp0'
    'b3RhbENvdW50Eh8KC3RvdGFsX3BhZ2VzGAQgASgFUgp0b3RhbFBhZ2VzEhkKCGhhc19uZXh0GA'
    'UgASgIUgdoYXNOZXh0EiEKDGhhc19wcmV2aW91cxgGIAEoCFILaGFzUHJldmlvdXM=');

@$core.Deprecated('Use createInvoiceRequestDescriptor instead')
const CreateInvoiceRequest$json = {
  '1': 'CreateInvoiceRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'due_date', '3': 6, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'items', '3': 7, '4': 3, '5': 11, '6': '.invoice.InvoiceItem', '10': 'items'},
    {'1': 'tax', '3': 8, '4': 1, '5': 1, '10': 'tax'},
    {'1': 'discount', '3': 9, '4': 1, '5': 1, '10': 'discount'},
    {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
    {'1': 'tagged_user_ids', '3': 11, '4': 3, '5': 9, '10': 'taggedUserIds'},
    {'1': 'idempotency_key', '3': 12, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'payer_email', '3': 13, '4': 1, '5': 9, '10': 'payerEmail'},
    {'1': 'currency', '3': 14, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payer_logo_url', '3': 15, '4': 1, '5': 9, '10': 'payerLogoUrl'},
    {'1': 'recipient_logo_url', '3': 16, '4': 1, '5': 9, '10': 'recipientLogoUrl'},
  ],
};

/// Descriptor for `CreateInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvoiceRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVJbnZvaWNlUmVxdWVzdBIdCgphY2NvdW50X2lkGAEgASgJUglhY2NvdW50SWQSJw'
    'oPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGllbnRfbmFt'
    'ZRgDIAEoCVINcmVjaXBpZW50TmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIgCgtkZXNjcm'
    'lwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SGQoIZHVlX2RhdGUYBiABKAlSB2R1ZURhdGUSKgoF'
    'aXRlbXMYByADKAsyFC5pbnZvaWNlLkludm9pY2VJdGVtUgVpdGVtcxIQCgN0YXgYCCABKAFSA3'
    'RheBIaCghkaXNjb3VudBgJIAEoAVIIZGlzY291bnQSFAoFbm90ZXMYCiABKAlSBW5vdGVzEiYK'
    'D3RhZ2dlZF91c2VyX2lkcxgLIAMoCVINdGFnZ2VkVXNlcklkcxInCg9pZGVtcG90ZW5jeV9rZX'
    'kYDCABKAlSDmlkZW1wb3RlbmN5S2V5Eh8KC3BheWVyX2VtYWlsGA0gASgJUgpwYXllckVtYWls'
    'EhoKCGN1cnJlbmN5GA4gASgJUghjdXJyZW5jeRIkCg5wYXllcl9sb2dvX3VybBgPIAEoCVIMcG'
    'F5ZXJMb2dvVXJsEiwKEnJlY2lwaWVudF9sb2dvX3VybBgQIAEoCVIQcmVjaXBpZW50TG9nb1Vy'
    'bA==');

@$core.Deprecated('Use createInvoiceResponseDescriptor instead')
const CreateInvoiceResponse$json = {
  '1': 'CreateInvoiceResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvoiceResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2'
    'ljZVIHaW52b2ljZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getInvoicesRequestDescriptor instead')
const GetInvoicesRequest$json = {
  '1': 'GetInvoicesRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 4, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 5, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 6, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'page', '3': 7, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 8, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRJbnZvaWNlc1JlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEhYKBn'
    'N0YXR1cxgCIAEoCVIGc3RhdHVzEh0KCnN0YXJ0X2RhdGUYAyABKAlSCXN0YXJ0RGF0ZRIZCghl'
    'bmRfZGF0ZRgEIAEoCVIHZW5kRGF0ZRIUCgVsaW1pdBgFIAEoBVIFbGltaXQSFgoGb2Zmc2V0GA'
    'YgASgFUgZvZmZzZXQSEgoEcGFnZRgHIAEoBVIEcGFnZRIbCglwYWdlX3NpemUYCCABKAVSCHBh'
    'Z2VTaXpl');

@$core.Deprecated('Use getInvoicesResponseDescriptor instead')
const GetInvoicesResponse$json = {
  '1': 'GetInvoicesResponse',
  '2': [
    {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.invoice.Invoice', '10': 'invoices'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_amount_pending', '3': 3, '4': 1, '5': 1, '10': 'totalAmountPending'},
    {'1': 'total_amount_paid', '3': 4, '4': 1, '5': 1, '10': 'totalAmountPaid'},
    {'1': 'pagination', '3': 5, '4': 1, '5': 11, '6': '.invoice.InvoicePaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRJbnZvaWNlc1Jlc3BvbnNlEiwKCGludm9pY2VzGAEgAygLMhAuaW52b2ljZS5JbnZvaW'
    'NlUghpbnZvaWNlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSMAoUdG90YWxfYW1vdW50X3BlbmRp'
    'bmcYAyABKAFSEnRvdGFsQW1vdW50UGVuZGluZxIqChF0b3RhbF9hbW91bnRfcGFpZBgEIAEoAV'
    'IPdG90YWxBbW91bnRQYWlkEj4KCnBhZ2luYXRpb24YBSABKAsyHi5pbnZvaWNlLkludm9pY2VQ'
    'YWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');

@$core.Deprecated('Use getInvoiceRequestDescriptor instead')
const GetInvoiceRequest$json = {
  '1': 'GetInvoiceRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `GetInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceRequestDescriptor = $convert.base64Decode(
    'ChFHZXRJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQ=');

@$core.Deprecated('Use getInvoiceResponseDescriptor instead')
const GetInvoiceResponse$json = {
  '1': 'GetInvoiceResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
  ],
};

/// Descriptor for `GetInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceResponseDescriptor = $convert.base64Decode(
    'ChJHZXRJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZV'
    'IHaW52b2ljZQ==');

@$core.Deprecated('Use payInvoiceRequestDescriptor instead')
const PayInvoiceRequest$json = {
  '1': 'PayInvoiceRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'idempotency_key', '3': 4, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `PayInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInvoiceRequestDescriptor = $convert.base64Decode(
    'ChFQYXlJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSHQoKYW'
    'Njb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhAKA3BpbhgDIAEoCVIDcGluEicKD2lkZW1wb3Rl'
    'bmN5X2tleRgEIAEoCVIOaWRlbXBvdGVuY3lLZXkSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAUgAS'
    'gJUhF2ZXJpZmljYXRpb25Ub2tlbhIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNhY3Rp'
    'b25JZA==');

@$core.Deprecated('Use payInvoiceResponseDescriptor instead')
const PayInvoiceResponse$json = {
  '1': 'PayInvoiceResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'payment_reference', '3': 3, '4': 1, '5': 9, '10': 'paymentReference'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInvoiceResponseDescriptor = $convert.base64Decode(
    'ChJQYXlJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2ljZV'
    'IHaW52b2ljZRIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIrChFwYXltZW50X3Jl'
    'ZmVyZW5jZRgDIAEoCVIQcGF5bWVudFJlZmVyZW5jZRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYW'
    'dl');

@$core.Deprecated('Use cancelInvoiceRequestDescriptor instead')
const CancelInvoiceRequest$json = {
  '1': 'CancelInvoiceRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `CancelInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoiceRequestDescriptor = $convert.base64Decode(
    'ChRDYW5jZWxJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSFg'
    'oGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use cancelInvoiceResponseDescriptor instead')
const CancelInvoiceResponse$json = {
  '1': 'CancelInvoiceResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoiceResponseDescriptor = $convert.base64Decode(
    'ChVDYW5jZWxJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2'
    'ljZVIHaW52b2ljZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use sendInvoiceReminderRequestDescriptor instead')
const SendInvoiceReminderRequest$json = {
  '1': 'SendInvoiceReminderRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `SendInvoiceReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendInvoiceReminderRequestDescriptor = $convert.base64Decode(
    'ChpTZW5kSW52b2ljZVJlbWluZGVyUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaW'
    'NlSWQ=');

@$core.Deprecated('Use sendInvoiceReminderResponseDescriptor instead')
const SendInvoiceReminderResponse$json = {
  '1': 'SendInvoiceReminderResponse',
  '2': [
    {'1': 'sent', '3': 1, '4': 1, '5': 8, '10': 'sent'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SendInvoiceReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendInvoiceReminderResponseDescriptor = $convert.base64Decode(
    'ChtTZW5kSW52b2ljZVJlbWluZGVyUmVzcG9uc2USEgoEc2VudBgBIAEoCFIEc2VudBIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use updateInvoiceStatusRequestDescriptor instead')
const UpdateInvoiceStatusRequest$json = {
  '1': 'UpdateInvoiceStatusRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `UpdateInvoiceStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceStatusRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVJbnZvaWNlU3RhdHVzUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaW'
    'NlSWQSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use updateInvoiceStatusResponseDescriptor instead')
const UpdateInvoiceStatusResponse$json = {
  '1': 'UpdateInvoiceStatusResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInvoiceStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceStatusResponseDescriptor = $convert.base64Decode(
    'ChtVcGRhdGVJbnZvaWNlU3RhdHVzUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2'
    'UuSW52b2ljZVIHaW52b2ljZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use tagUsersToInvoiceRequestDescriptor instead')
const TagUsersToInvoiceRequest$json = {
  '1': 'TagUsersToInvoiceRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'user_ids', '3': 2, '4': 3, '5': 9, '10': 'userIds'},
  ],
};

/// Descriptor for `TagUsersToInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagUsersToInvoiceRequestDescriptor = $convert.base64Decode(
    'ChhUYWdVc2Vyc1RvSW52b2ljZVJlcXVlc3QSHQoKaW52b2ljZV9pZBgBIAEoCVIJaW52b2ljZU'
    'lkEhkKCHVzZXJfaWRzGAIgAygJUgd1c2VySWRz');

@$core.Deprecated('Use tagUsersToInvoiceResponseDescriptor instead')
const TagUsersToInvoiceResponse$json = {
  '1': 'TagUsersToInvoiceResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'users_tagged', '3': 3, '4': 1, '5': 5, '10': 'usersTagged'},
  ],
};

/// Descriptor for `TagUsersToInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagUsersToInvoiceResponseDescriptor = $convert.base64Decode(
    'ChlUYWdVc2Vyc1RvSW52b2ljZVJlc3BvbnNlEioKB2ludm9pY2UYASABKAsyEC5pbnZvaWNlLk'
    'ludm9pY2VSB2ludm9pY2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIhCgx1c2Vyc190YWdn'
    'ZWQYAyABKAVSC3VzZXJzVGFnZ2Vk');

@$core.Deprecated('Use getInvoicesTaggedToUserRequestDescriptor instead')
const GetInvoicesTaggedToUserRequest$json = {
  '1': 'GetInvoicesTaggedToUserRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'page', '3': 5, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 6, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetInvoicesTaggedToUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesTaggedToUserRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRJbnZvaWNlc1RhZ2dlZFRvVXNlclJlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dX'
    'MSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0EhoKCGN1cnJl'
    'bmN5GAQgASgJUghjdXJyZW5jeRISCgRwYWdlGAUgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgGIA'
    'EoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use getInvoicesTaggedToUserResponseDescriptor instead')
const GetInvoicesTaggedToUserResponse$json = {
  '1': 'GetInvoicesTaggedToUserResponse',
  '2': [
    {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.invoice.Invoice', '10': 'invoices'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_amount_pending', '3': 3, '4': 1, '5': 1, '10': 'totalAmountPending'},
    {'1': 'total_amount_paid', '3': 4, '4': 1, '5': 1, '10': 'totalAmountPaid'},
    {'1': 'pagination', '3': 5, '4': 1, '5': 11, '6': '.invoice.InvoicePaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetInvoicesTaggedToUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesTaggedToUserResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRJbnZvaWNlc1RhZ2dlZFRvVXNlclJlc3BvbnNlEiwKCGludm9pY2VzGAEgAygLMhAuaW'
    '52b2ljZS5JbnZvaWNlUghpbnZvaWNlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSMAoUdG90YWxf'
    'YW1vdW50X3BlbmRpbmcYAyABKAFSEnRvdGFsQW1vdW50UGVuZGluZxIqChF0b3RhbF9hbW91bn'
    'RfcGFpZBgEIAEoAVIPdG90YWxBbW91bnRQYWlkEj4KCnBhZ2luYXRpb24YBSABKAsyHi5pbnZv'
    'aWNlLkludm9pY2VQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbg==');

@$core.Deprecated('Use getSentInvoicesRequestDescriptor instead')
const GetSentInvoicesRequest$json = {
  '1': 'GetSentInvoicesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'page', '3': 4, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 5, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `GetSentInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSentInvoicesRequestDescriptor = $convert.base64Decode(
    'ChZHZXRTZW50SW52b2ljZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhQKBWxpbW'
    'l0GAIgASgFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldBISCgRwYWdlGAQgASgFUgRw'
    'YWdlEhsKCXBhZ2Vfc2l6ZRgFIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use getSentInvoicesResponseDescriptor instead')
const GetSentInvoicesResponse$json = {
  '1': 'GetSentInvoicesResponse',
  '2': [
    {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.invoice.Invoice', '10': 'invoices'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_amount_pending', '3': 3, '4': 1, '5': 1, '10': 'totalAmountPending'},
    {'1': 'total_amount_paid', '3': 4, '4': 1, '5': 1, '10': 'totalAmountPaid'},
    {'1': 'pagination', '3': 5, '4': 1, '5': 11, '6': '.invoice.InvoicePaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetSentInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSentInvoicesResponseDescriptor = $convert.base64Decode(
    'ChdHZXRTZW50SW52b2ljZXNSZXNwb25zZRIsCghpbnZvaWNlcxgBIAMoCzIQLmludm9pY2UuSW'
    '52b2ljZVIIaW52b2ljZXMSFAoFdG90YWwYAiABKAVSBXRvdGFsEjAKFHRvdGFsX2Ftb3VudF9w'
    'ZW5kaW5nGAMgASgBUhJ0b3RhbEFtb3VudFBlbmRpbmcSKgoRdG90YWxfYW1vdW50X3BhaWQYBC'
    'ABKAFSD3RvdGFsQW1vdW50UGFpZBI+CgpwYWdpbmF0aW9uGAUgASgLMh4uaW52b2ljZS5JbnZv'
    'aWNlUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');

@$core.Deprecated('Use updateInvoiceRequestDescriptor instead')
const UpdateInvoiceRequest$json = {
  '1': 'UpdateInvoiceRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'recipient_email', '3': 2, '4': 1, '5': 9, '10': 'recipientEmail'},
    {'1': 'recipient_name', '3': 3, '4': 1, '5': 9, '10': 'recipientName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'due_date', '3': 6, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'items', '3': 7, '4': 3, '5': 11, '6': '.invoice.InvoiceItem', '10': 'items'},
    {'1': 'tax', '3': 8, '4': 1, '5': 1, '10': 'tax'},
    {'1': 'discount', '3': 9, '4': 1, '5': 1, '10': 'discount'},
    {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSJw'
    'oPcmVjaXBpZW50X2VtYWlsGAIgASgJUg5yZWNpcGllbnRFbWFpbBIlCg5yZWNpcGllbnRfbmFt'
    'ZRgDIAEoCVINcmVjaXBpZW50TmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIgCgtkZXNjcm'
    'lwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SGQoIZHVlX2RhdGUYBiABKAlSB2R1ZURhdGUSKgoF'
    'aXRlbXMYByADKAsyFC5pbnZvaWNlLkludm9pY2VJdGVtUgVpdGVtcxIQCgN0YXgYCCABKAFSA3'
    'RheBIaCghkaXNjb3VudBgJIAEoAVIIZGlzY291bnQSFAoFbm90ZXMYCiABKAlSBW5vdGVz');

@$core.Deprecated('Use updateInvoiceResponseDescriptor instead')
const UpdateInvoiceResponse$json = {
  '1': 'UpdateInvoiceResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2'
    'ljZVIHaW52b2ljZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use deleteInvoiceRequestDescriptor instead')
const DeleteInvoiceRequest$json = {
  '1': 'DeleteInvoiceRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `DeleteInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInvoiceRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQ=');

@$core.Deprecated('Use deleteInvoiceResponseDescriptor instead')
const DeleteInvoiceResponse$json = {
  '1': 'DeleteInvoiceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInvoiceResponseDescriptor = $convert.base64Decode(
    'ChVEZWxldGVJbnZvaWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getInvoiceStatisticsRequestDescriptor instead')
const GetInvoiceStatisticsRequest$json = {
  '1': 'GetInvoiceStatisticsRequest',
};

/// Descriptor for `GetInvoiceStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceStatisticsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRJbnZvaWNlU3RhdGlzdGljc1JlcXVlc3Q=');

@$core.Deprecated('Use getInvoiceStatisticsResponseDescriptor instead')
const GetInvoiceStatisticsResponse$json = {
  '1': 'GetInvoiceStatisticsResponse',
  '2': [
    {'1': 'statistics', '3': 1, '4': 1, '5': 11, '6': '.invoice.InvoiceStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetInvoiceStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceStatisticsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRJbnZvaWNlU3RhdGlzdGljc1Jlc3BvbnNlEjoKCnN0YXRpc3RpY3MYASABKAsyGi5pbn'
    'ZvaWNlLkludm9pY2VTdGF0aXN0aWNzUgpzdGF0aXN0aWNz');

@$core.Deprecated('Use unlockInvoiceRequestDescriptor instead')
const UnlockInvoiceRequest$json = {
  '1': 'UnlockInvoiceRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'account_id', '3': 2, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'pin', '3': 3, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'idempotency_key', '3': 4, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `UnlockInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockInvoiceRequestDescriptor = $convert.base64Decode(
    'ChRVbmxvY2tJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSHQ'
    'oKYWNjb3VudF9pZBgCIAEoCVIJYWNjb3VudElkEhAKA3BpbhgDIAEoCVIDcGluEicKD2lkZW1w'
    'b3RlbmN5X2tleRgEIAEoCVIOaWRlbXBvdGVuY3lLZXkSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGA'
    'UgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhIlCg50cmFuc2FjdGlvbl9pZBgGIAEoCVINdHJhbnNh'
    'Y3Rpb25JZA==');

@$core.Deprecated('Use unlockInvoiceResponseDescriptor instead')
const UnlockInvoiceResponse$json = {
  '1': 'UnlockInvoiceResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.invoice.Invoice', '10': 'invoice'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'unlock_payment_ref', '3': 3, '4': 1, '5': 9, '10': 'unlockPaymentRef'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UnlockInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlockInvoiceResponseDescriptor = $convert.base64Decode(
    'ChVVbmxvY2tJbnZvaWNlUmVzcG9uc2USKgoHaW52b2ljZRgBIAEoCzIQLmludm9pY2UuSW52b2'
    'ljZVIHaW52b2ljZRIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIsChJ1bmxvY2tf'
    'cGF5bWVudF9yZWYYAyABKAlSEHVubG9ja1BheW1lbnRSZWYSGAoHbWVzc2FnZRgEIAEoCVIHbW'
    'Vzc2FnZQ==');

@$core.Deprecated('Use uploadInvoiceImageRequestDescriptor instead')
const UploadInvoiceImageRequest$json = {
  '1': 'UploadInvoiceImageRequest',
  '2': [
    {'1': 'image_data', '3': 1, '4': 1, '5': 12, '10': 'imageData'},
    {'1': 'file_name', '3': 2, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'content_type', '3': 3, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `UploadInvoiceImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadInvoiceImageRequestDescriptor = $convert.base64Decode(
    'ChlVcGxvYWRJbnZvaWNlSW1hZ2VSZXF1ZXN0Eh0KCmltYWdlX2RhdGEYASABKAxSCWltYWdlRG'
    'F0YRIbCglmaWxlX25hbWUYAiABKAlSCGZpbGVOYW1lEiEKDGNvbnRlbnRfdHlwZRgDIAEoCVIL'
    'Y29udGVudFR5cGU=');

@$core.Deprecated('Use uploadInvoiceImageResponseDescriptor instead')
const UploadInvoiceImageResponse$json = {
  '1': 'UploadInvoiceImageResponse',
  '2': [
    {'1': 'image_url', '3': 1, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `UploadInvoiceImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadInvoiceImageResponseDescriptor = $convert.base64Decode(
    'ChpVcGxvYWRJbnZvaWNlSW1hZ2VSZXNwb25zZRIbCglpbWFnZV91cmwYASABKAlSCGltYWdlVX'
    'Js');

@$core.Deprecated('Use sendInvoiceToEmailRequestDescriptor instead')
const SendInvoiceToEmailRequest$json = {
  '1': 'SendInvoiceToEmailRequest',
  '2': [
    {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'locale', '3': 3, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `SendInvoiceToEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendInvoiceToEmailRequestDescriptor = $convert.base64Decode(
    'ChlTZW5kSW52b2ljZVRvRW1haWxSZXF1ZXN0Eh0KCmludm9pY2VfaWQYASABKAlSCWludm9pY2'
    'VJZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSFgoGbG9jYWxlGAMgASgJUgZsb2NhbGU=');

@$core.Deprecated('Use sendInvoiceToEmailResponseDescriptor instead')
const SendInvoiceToEmailResponse$json = {
  '1': 'SendInvoiceToEmailResponse',
  '2': [
    {'1': 'sent', '3': 1, '4': 1, '5': 8, '10': 'sent'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SendInvoiceToEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendInvoiceToEmailResponseDescriptor = $convert.base64Decode(
    'ChpTZW5kSW52b2ljZVRvRW1haWxSZXNwb25zZRISCgRzZW50GAEgASgIUgRzZW50EhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2U=');

