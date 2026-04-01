///
//  Generated code. Do not modify.
//  source: tagged_invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use taggedInvoiceDescriptor instead')
const TaggedInvoice$json = const {
  '1': 'TaggedInvoice',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'invoice_id', '3': 2, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'payment_status', '3': 4, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'paymentStatus'},
    const {'1': 'priority', '3': 5, '4': 1, '5': 14, '6': '.pb.InvoicePriority', '10': 'priority'},
    const {'1': 'is_viewed', '3': 6, '4': 1, '5': 8, '10': 'isViewed'},
    const {'1': 'tagged_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'taggedAt'},
    const {'1': 'viewed_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'viewedAt'},
    const {'1': 'reminder_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'reminder_sent', '3': 10, '4': 1, '5': 8, '10': 'reminderSent'},
    const {'1': 'notes', '3': 11, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'amount', '3': 12, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 13, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `TaggedInvoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taggedInvoiceDescriptor = $convert.base64Decode('Cg1UYWdnZWRJbnZvaWNlEg4KAmlkGAEgASgJUgJpZBIdCgppbnZvaWNlX2lkGAIgASgJUglpbnZvaWNlSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEj8KDnBheW1lbnRfc3RhdHVzGAQgASgOMhgucGIuSW52b2ljZVBheW1lbnRTdGF0dXNSDXBheW1lbnRTdGF0dXMSLwoIcHJpb3JpdHkYBSABKA4yEy5wYi5JbnZvaWNlUHJpb3JpdHlSCHByaW9yaXR5EhsKCWlzX3ZpZXdlZBgGIAEoCFIIaXNWaWV3ZWQSNwoJdGFnZ2VkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIdGFnZ2VkQXQSNwoJdmlld2VkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIdmlld2VkQXQSPwoNcmVtaW5kZXJfZGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIjCg1yZW1pbmRlcl9zZW50GAogASgIUgxyZW1pbmRlclNlbnQSFAoFbm90ZXMYCyABKAlSBW5vdGVzEhYKBmFtb3VudBgMIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GA0gASgJUghjdXJyZW5jeRI5CgpjcmVhdGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use paymentReminderDescriptor instead')
const PaymentReminder$json = const {
  '1': 'PaymentReminder',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'reminder_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `PaymentReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentReminderDescriptor = $convert.base64Decode('Cg9QYXltZW50UmVtaW5kZXISHQoKaW52b2ljZV9pZBgBIAEoCVIJaW52b2ljZUlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBI/Cg1yZW1pbmRlcl9kYXRlGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use invoicePaymentNotificationDescriptor instead')
const InvoicePaymentNotification$json = const {
  '1': 'InvoicePaymentNotification',
  '2': const [
    const {'1': 'notification_id', '3': 1, '4': 1, '5': 9, '10': 'notificationId'},
    const {'1': 'invoice_id', '3': 2, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'notification_type', '3': 4, '4': 1, '5': 9, '10': 'notificationType'},
    const {'1': 'title', '3': 5, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_read', '3': 7, '4': 1, '5': 8, '10': 'isRead'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'read_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'readAt'},
  ],
};

/// Descriptor for `InvoicePaymentNotification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoicePaymentNotificationDescriptor = $convert.base64Decode('ChpJbnZvaWNlUGF5bWVudE5vdGlmaWNhdGlvbhInCg9ub3RpZmljYXRpb25faWQYASABKAlSDm5vdGlmaWNhdGlvbklkEh0KCmludm9pY2VfaWQYAiABKAlSCWludm9pY2VJZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSKwoRbm90aWZpY2F0aW9uX3R5cGUYBCABKAlSEG5vdGlmaWNhdGlvblR5cGUSFAoFdGl0bGUYBSABKAlSBXRpdGxlEhgKB21lc3NhZ2UYBiABKAlSB21lc3NhZ2USFwoHaXNfcmVhZBgHIAEoCFIGaXNSZWFkEjkKCmNyZWF0ZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSMwoHcmVhZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBnJlYWRBdA==');
@$core.Deprecated('Use getTaggedInvoicesRequestDescriptor instead')
const GetTaggedInvoicesRequest$json = const {
  '1': 'GetTaggedInvoicesRequest',
  '2': const [
    const {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9, '10': 'pageToken'},
    const {'1': 'status_filter', '3': 3, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'statusFilter'},
    const {'1': 'priority_filter', '3': 4, '4': 1, '5': 14, '6': '.pb.InvoicePriority', '10': 'priorityFilter'},
  ],
};

/// Descriptor for `GetTaggedInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaggedInvoicesRequestDescriptor = $convert.base64Decode('ChhHZXRUYWdnZWRJbnZvaWNlc1JlcXVlc3QSGwoJcGFnZV9zaXplGAEgASgFUghwYWdlU2l6ZRIdCgpwYWdlX3Rva2VuGAIgASgJUglwYWdlVG9rZW4SPQoNc3RhdHVzX2ZpbHRlchgDIAEoDjIYLnBiLkludm9pY2VQYXltZW50U3RhdHVzUgxzdGF0dXNGaWx0ZXISPAoPcHJpb3JpdHlfZmlsdGVyGAQgASgOMhMucGIuSW52b2ljZVByaW9yaXR5Ug5wcmlvcml0eUZpbHRlcg==');
@$core.Deprecated('Use getTaggedInvoicesResponseDescriptor instead')
const GetTaggedInvoicesResponse$json = const {
  '1': 'GetTaggedInvoicesResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
    const {'1': 'summary', '3': 4, '4': 1, '5': 11, '6': '.pb.TaggedInvoicesSummary', '10': 'summary'},
  ],
};

/// Descriptor for `GetTaggedInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaggedInvoicesResponseDescriptor = $convert.base64Decode('ChlHZXRUYWdnZWRJbnZvaWNlc1Jlc3BvbnNlEi0KCGludm9pY2VzGAEgAygLMhEucGIuVGFnZ2VkSW52b2ljZVIIaW52b2ljZXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2VuEh8KC3RvdGFsX2NvdW50GAMgASgEUgp0b3RhbENvdW50EjMKB3N1bW1hcnkYBCABKAsyGS5wYi5UYWdnZWRJbnZvaWNlc1N1bW1hcnlSB3N1bW1hcnk=');
@$core.Deprecated('Use taggedInvoicesSummaryDescriptor instead')
const TaggedInvoicesSummary$json = const {
  '1': 'TaggedInvoicesSummary',
  '2': const [
    const {'1': 'total_invoices', '3': 1, '4': 1, '5': 4, '10': 'totalInvoices'},
    const {'1': 'pending_invoices', '3': 2, '4': 1, '5': 4, '10': 'pendingInvoices'},
    const {'1': 'overdue_invoices', '3': 3, '4': 1, '5': 4, '10': 'overdueInvoices'},
    const {'1': 'paid_invoices', '3': 4, '4': 1, '5': 4, '10': 'paidInvoices'},
    const {'1': 'total_amount', '3': 5, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'pending_amount', '3': 6, '4': 1, '5': 1, '10': 'pendingAmount'},
    const {'1': 'overdue_amount', '3': 7, '4': 1, '5': 1, '10': 'overdueAmount'},
  ],
};

/// Descriptor for `TaggedInvoicesSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taggedInvoicesSummaryDescriptor = $convert.base64Decode('ChVUYWdnZWRJbnZvaWNlc1N1bW1hcnkSJQoOdG90YWxfaW52b2ljZXMYASABKARSDXRvdGFsSW52b2ljZXMSKQoQcGVuZGluZ19pbnZvaWNlcxgCIAEoBFIPcGVuZGluZ0ludm9pY2VzEikKEG92ZXJkdWVfaW52b2ljZXMYAyABKARSD292ZXJkdWVJbnZvaWNlcxIjCg1wYWlkX2ludm9pY2VzGAQgASgEUgxwYWlkSW52b2ljZXMSIQoMdG90YWxfYW1vdW50GAUgASgBUgt0b3RhbEFtb3VudBIlCg5wZW5kaW5nX2Ftb3VudBgGIAEoAVINcGVuZGluZ0Ftb3VudBIlCg5vdmVyZHVlX2Ftb3VudBgHIAEoAVINb3ZlcmR1ZUFtb3VudA==');
@$core.Deprecated('Use getTaggedInvoicesByStatusRequestDescriptor instead')
const GetTaggedInvoicesByStatusRequest$json = const {
  '1': 'GetTaggedInvoicesByStatusRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'status'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `GetTaggedInvoicesByStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaggedInvoicesByStatusRequestDescriptor = $convert.base64Decode('CiBHZXRUYWdnZWRJbnZvaWNlc0J5U3RhdHVzUmVxdWVzdBIwCgZzdGF0dXMYASABKA4yGC5wYi5JbnZvaWNlUGF5bWVudFN0YXR1c1IGc3RhdHVzEhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZVRva2Vu');
@$core.Deprecated('Use getTaggedInvoicesByStatusResponseDescriptor instead')
const GetTaggedInvoicesByStatusResponse$json = const {
  '1': 'GetTaggedInvoicesByStatusResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetTaggedInvoicesByStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaggedInvoicesByStatusResponseDescriptor = $convert.base64Decode('CiFHZXRUYWdnZWRJbnZvaWNlc0J5U3RhdHVzUmVzcG9uc2USLQoIaW52b2ljZXMYASADKAsyES5wYi5UYWdnZWRJbnZvaWNlUghpbnZvaWNlcxImCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4SHwoLdG90YWxfY291bnQYAyABKARSCnRvdGFsQ291bnQ=');
@$core.Deprecated('Use getTaggedInvoiceByIdRequestDescriptor instead')
const GetTaggedInvoiceByIdRequest$json = const {
  '1': 'GetTaggedInvoiceByIdRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `GetTaggedInvoiceByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaggedInvoiceByIdRequestDescriptor = $convert.base64Decode('ChtHZXRUYWdnZWRJbnZvaWNlQnlJZFJlcXVlc3QSHQoKaW52b2ljZV9pZBgBIAEoCVIJaW52b2ljZUlk');
@$core.Deprecated('Use getTaggedInvoiceByIdResponseDescriptor instead')
const GetTaggedInvoiceByIdResponse$json = const {
  '1': 'GetTaggedInvoiceByIdResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoice'},
  ],
};

/// Descriptor for `GetTaggedInvoiceByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaggedInvoiceByIdResponseDescriptor = $convert.base64Decode('ChxHZXRUYWdnZWRJbnZvaWNlQnlJZFJlc3BvbnNlEisKB2ludm9pY2UYASABKAsyES5wYi5UYWdnZWRJbnZvaWNlUgdpbnZvaWNl');
@$core.Deprecated('Use getOverdueTaggedInvoicesRequestDescriptor instead')
const GetOverdueTaggedInvoicesRequest$json = const {
  '1': 'GetOverdueTaggedInvoicesRequest',
  '2': const [
    const {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9, '10': 'pageToken'},
    const {'1': 'days_overdue', '3': 3, '4': 1, '5': 5, '10': 'daysOverdue'},
  ],
};

/// Descriptor for `GetOverdueTaggedInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueTaggedInvoicesRequestDescriptor = $convert.base64Decode('Ch9HZXRPdmVyZHVlVGFnZ2VkSW52b2ljZXNSZXF1ZXN0EhsKCXBhZ2Vfc2l6ZRgBIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgCIAEoCVIJcGFnZVRva2VuEiEKDGRheXNfb3ZlcmR1ZRgDIAEoBVILZGF5c092ZXJkdWU=');
@$core.Deprecated('Use getOverdueTaggedInvoicesResponseDescriptor instead')
const GetOverdueTaggedInvoicesResponse$json = const {
  '1': 'GetOverdueTaggedInvoicesResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
    const {'1': 'total_overdue_amount', '3': 4, '4': 1, '5': 1, '10': 'totalOverdueAmount'},
  ],
};

/// Descriptor for `GetOverdueTaggedInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverdueTaggedInvoicesResponseDescriptor = $convert.base64Decode('CiBHZXRPdmVyZHVlVGFnZ2VkSW52b2ljZXNSZXNwb25zZRItCghpbnZvaWNlcxgBIAMoCzIRLnBiLlRhZ2dlZEludm9pY2VSCGludm9pY2VzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbhIfCgt0b3RhbF9jb3VudBgDIAEoBFIKdG90YWxDb3VudBIwChR0b3RhbF9vdmVyZHVlX2Ftb3VudBgEIAEoAVISdG90YWxPdmVyZHVlQW1vdW50');
@$core.Deprecated('Use getUpcomingTaggedInvoicesRequestDescriptor instead')
const GetUpcomingTaggedInvoicesRequest$json = const {
  '1': 'GetUpcomingTaggedInvoicesRequest',
  '2': const [
    const {'1': 'days_ahead', '3': 1, '4': 1, '5': 5, '10': 'daysAhead'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `GetUpcomingTaggedInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpcomingTaggedInvoicesRequestDescriptor = $convert.base64Decode('CiBHZXRVcGNvbWluZ1RhZ2dlZEludm9pY2VzUmVxdWVzdBIdCgpkYXlzX2FoZWFkGAEgASgFUglkYXlzQWhlYWQSGwoJcGFnZV9zaXplGAIgASgFUghwYWdlU2l6ZRIdCgpwYWdlX3Rva2VuGAMgASgJUglwYWdlVG9rZW4=');
@$core.Deprecated('Use getUpcomingTaggedInvoicesResponseDescriptor instead')
const GetUpcomingTaggedInvoicesResponse$json = const {
  '1': 'GetUpcomingTaggedInvoicesResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetUpcomingTaggedInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUpcomingTaggedInvoicesResponseDescriptor = $convert.base64Decode('CiFHZXRVcGNvbWluZ1RhZ2dlZEludm9pY2VzUmVzcG9uc2USLQoIaW52b2ljZXMYASADKAsyES5wYi5UYWdnZWRJbnZvaWNlUghpbnZvaWNlcxImCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4SHwoLdG90YWxfY291bnQYAyABKARSCnRvdGFsQ291bnQ=');
@$core.Deprecated('Use searchTaggedInvoicesRequestDescriptor instead')
const SearchTaggedInvoicesRequest$json = const {
  '1': 'SearchTaggedInvoicesRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
    const {'1': 'statuses', '3': 4, '4': 3, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'statuses'},
    const {'1': 'priorities', '3': 5, '4': 3, '5': 14, '6': '.pb.InvoicePriority', '10': 'priorities'},
    const {'1': 'start_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
};

/// Descriptor for `SearchTaggedInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTaggedInvoicesRequestDescriptor = $convert.base64Decode('ChtTZWFyY2hUYWdnZWRJbnZvaWNlc1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgDIAEoCVIJcGFnZVRva2VuEjQKCHN0YXR1c2VzGAQgAygOMhgucGIuSW52b2ljZVBheW1lbnRTdGF0dXNSCHN0YXR1c2VzEjMKCnByaW9yaXRpZXMYBSADKA4yEy5wYi5JbnZvaWNlUHJpb3JpdHlSCnByaW9yaXRpZXMSOQoKc3RhcnRfZGF0ZRgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0ZRI1CghlbmRfZGF0ZRgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdGU=');
@$core.Deprecated('Use searchTaggedInvoicesResponseDescriptor instead')
const SearchTaggedInvoicesResponse$json = const {
  '1': 'SearchTaggedInvoicesResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
  ],
};

/// Descriptor for `SearchTaggedInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTaggedInvoicesResponseDescriptor = $convert.base64Decode('ChxTZWFyY2hUYWdnZWRJbnZvaWNlc1Jlc3BvbnNlEi0KCGludm9pY2VzGAEgAygLMhEucGIuVGFnZ2VkSW52b2ljZVIIaW52b2ljZXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2VuEh8KC3RvdGFsX2NvdW50GAMgASgEUgp0b3RhbENvdW50');
@$core.Deprecated('Use filterTaggedInvoicesByPriorityRequestDescriptor instead')
const FilterTaggedInvoicesByPriorityRequest$json = const {
  '1': 'FilterTaggedInvoicesByPriorityRequest',
  '2': const [
    const {'1': 'priority', '3': 1, '4': 1, '5': 14, '6': '.pb.InvoicePriority', '10': 'priority'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `FilterTaggedInvoicesByPriorityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filterTaggedInvoicesByPriorityRequestDescriptor = $convert.base64Decode('CiVGaWx0ZXJUYWdnZWRJbnZvaWNlc0J5UHJpb3JpdHlSZXF1ZXN0Ei8KCHByaW9yaXR5GAEgASgOMhMucGIuSW52b2ljZVByaW9yaXR5Ughwcmlvcml0eRIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YAyABKAlSCXBhZ2VUb2tlbg==');
@$core.Deprecated('Use filterTaggedInvoicesByPriorityResponseDescriptor instead')
const FilterTaggedInvoicesByPriorityResponse$json = const {
  '1': 'FilterTaggedInvoicesByPriorityResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
  ],
};

/// Descriptor for `FilterTaggedInvoicesByPriorityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filterTaggedInvoicesByPriorityResponseDescriptor = $convert.base64Decode('CiZGaWx0ZXJUYWdnZWRJbnZvaWNlc0J5UHJpb3JpdHlSZXNwb25zZRItCghpbnZvaWNlcxgBIAMoCzIRLnBiLlRhZ2dlZEludm9pY2VSCGludm9pY2VzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbhIfCgt0b3RhbF9jb3VudBgDIAEoBFIKdG90YWxDb3VudA==');
@$core.Deprecated('Use filterTaggedInvoicesByDateRangeRequestDescriptor instead')
const FilterTaggedInvoicesByDateRangeRequest$json = const {
  '1': 'FilterTaggedInvoicesByDateRangeRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 4, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `FilterTaggedInvoicesByDateRangeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filterTaggedInvoicesByDateRangeRequestDescriptor = $convert.base64Decode('CiZGaWx0ZXJUYWdnZWRJbnZvaWNlc0J5RGF0ZVJhbmdlUmVxdWVzdBI5CgpzdGFydF9kYXRlGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRIbCglwYWdlX3NpemUYAyABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YBCABKAlSCXBhZ2VUb2tlbg==');
@$core.Deprecated('Use filterTaggedInvoicesByDateRangeResponseDescriptor instead')
const FilterTaggedInvoicesByDateRangeResponse$json = const {
  '1': 'FilterTaggedInvoicesByDateRangeResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
  ],
};

/// Descriptor for `FilterTaggedInvoicesByDateRangeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filterTaggedInvoicesByDateRangeResponseDescriptor = $convert.base64Decode('CidGaWx0ZXJUYWdnZWRJbnZvaWNlc0J5RGF0ZVJhbmdlUmVzcG9uc2USLQoIaW52b2ljZXMYASADKAsyES5wYi5UYWdnZWRJbnZvaWNlUghpbnZvaWNlcxImCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4SHwoLdG90YWxfY291bnQYAyABKARSCnRvdGFsQ291bnQ=');
@$core.Deprecated('Use filterTaggedInvoicesByAmountRequestDescriptor instead')
const FilterTaggedInvoicesByAmountRequest$json = const {
  '1': 'FilterTaggedInvoicesByAmountRequest',
  '2': const [
    const {'1': 'min_amount', '3': 1, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 2, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 4, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `FilterTaggedInvoicesByAmountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filterTaggedInvoicesByAmountRequestDescriptor = $convert.base64Decode('CiNGaWx0ZXJUYWdnZWRJbnZvaWNlc0J5QW1vdW50UmVxdWVzdBIdCgptaW5fYW1vdW50GAEgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgCIAEoAVIJbWF4QW1vdW50EhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgEIAEoCVIJcGFnZVRva2Vu');
@$core.Deprecated('Use filterTaggedInvoicesByAmountResponseDescriptor instead')
const FilterTaggedInvoicesByAmountResponse$json = const {
  '1': 'FilterTaggedInvoicesByAmountResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
  ],
};

/// Descriptor for `FilterTaggedInvoicesByAmountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filterTaggedInvoicesByAmountResponseDescriptor = $convert.base64Decode('CiRGaWx0ZXJUYWdnZWRJbnZvaWNlc0J5QW1vdW50UmVzcG9uc2USLQoIaW52b2ljZXMYASADKAsyES5wYi5UYWdnZWRJbnZvaWNlUghpbnZvaWNlcxImCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4SHwoLdG90YWxfY291bnQYAyABKARSCnRvdGFsQ291bnQ=');
@$core.Deprecated('Use markTaggedInvoiceAsViewedRequestDescriptor instead')
const MarkTaggedInvoiceAsViewedRequest$json = const {
  '1': 'MarkTaggedInvoiceAsViewedRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `MarkTaggedInvoiceAsViewedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markTaggedInvoiceAsViewedRequestDescriptor = $convert.base64Decode('CiBNYXJrVGFnZ2VkSW52b2ljZUFzVmlld2VkUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQ=');
@$core.Deprecated('Use markTaggedInvoiceAsViewedResponseDescriptor instead')
const MarkTaggedInvoiceAsViewedResponse$json = const {
  '1': 'MarkTaggedInvoiceAsViewedResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoice'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkTaggedInvoiceAsViewedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markTaggedInvoiceAsViewedResponseDescriptor = $convert.base64Decode('CiFNYXJrVGFnZ2VkSW52b2ljZUFzVmlld2VkUmVzcG9uc2USKwoHaW52b2ljZRgBIAEoCzIRLnBiLlRhZ2dlZEludm9pY2VSB2ludm9pY2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use setInvoicePaymentReminderRequestDescriptor instead')
const SetInvoicePaymentReminderRequest$json = const {
  '1': 'SetInvoicePaymentReminderRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'reminder_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
  ],
};

/// Descriptor for `SetInvoicePaymentReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setInvoicePaymentReminderRequestDescriptor = $convert.base64Decode('CiBTZXRJbnZvaWNlUGF5bWVudFJlbWluZGVyUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSPwoNcmVtaW5kZXJfZGF0ZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZQ==');
@$core.Deprecated('Use setInvoicePaymentReminderResponseDescriptor instead')
const SetInvoicePaymentReminderResponse$json = const {
  '1': 'SetInvoicePaymentReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.pb.PaymentReminder', '10': 'reminder'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SetInvoicePaymentReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setInvoicePaymentReminderResponseDescriptor = $convert.base64Decode('CiFTZXRJbnZvaWNlUGF5bWVudFJlbWluZGVyUmVzcG9uc2USLwoIcmVtaW5kZXIYASABKAsyEy5wYi5QYXltZW50UmVtaW5kZXJSCHJlbWluZGVyEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use requestTaggedInvoiceDetailsRequestDescriptor instead')
const RequestTaggedInvoiceDetailsRequest$json = const {
  '1': 'RequestTaggedInvoiceDetailsRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `RequestTaggedInvoiceDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestTaggedInvoiceDetailsRequestDescriptor = $convert.base64Decode('CiJSZXF1ZXN0VGFnZ2VkSW52b2ljZURldGFpbHNSZXF1ZXN0Eh0KCmludm9pY2VfaWQYASABKAlSCWludm9pY2VJZA==');
@$core.Deprecated('Use requestTaggedInvoiceDetailsResponseDescriptor instead')
const RequestTaggedInvoiceDetailsResponse$json = const {
  '1': 'RequestTaggedInvoiceDetailsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'request_id', '3': 3, '4': 1, '5': 9, '10': 'requestId'},
  ],
};

/// Descriptor for `RequestTaggedInvoiceDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestTaggedInvoiceDetailsResponseDescriptor = $convert.base64Decode('CiNSZXF1ZXN0VGFnZ2VkSW52b2ljZURldGFpbHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USHQoKcmVxdWVzdF9pZBgDIAEoCVIJcmVxdWVzdElk');
@$core.Deprecated('Use getInvoicePaymentNotificationsRequestDescriptor instead')
const GetInvoicePaymentNotificationsRequest$json = const {
  '1': 'GetInvoicePaymentNotificationsRequest',
  '2': const [
    const {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9, '10': 'pageToken'},
    const {'1': 'unread_only', '3': 3, '4': 1, '5': 8, '10': 'unreadOnly'},
  ],
};

/// Descriptor for `GetInvoicePaymentNotificationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentNotificationsRequestDescriptor = $convert.base64Decode('CiVHZXRJbnZvaWNlUGF5bWVudE5vdGlmaWNhdGlvbnNSZXF1ZXN0EhsKCXBhZ2Vfc2l6ZRgBIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgCIAEoCVIJcGFnZVRva2VuEh8KC3VucmVhZF9vbmx5GAMgASgIUgp1bnJlYWRPbmx5');
@$core.Deprecated('Use getInvoicePaymentNotificationsResponseDescriptor instead')
const GetInvoicePaymentNotificationsResponse$json = const {
  '1': 'GetInvoicePaymentNotificationsResponse',
  '2': const [
    const {'1': 'notifications', '3': 1, '4': 3, '5': 11, '6': '.pb.InvoicePaymentNotification', '10': 'notifications'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
    const {'1': 'total_count', '3': 3, '4': 1, '5': 4, '10': 'totalCount'},
    const {'1': 'unread_count', '3': 4, '4': 1, '5': 4, '10': 'unreadCount'},
  ],
};

/// Descriptor for `GetInvoicePaymentNotificationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicePaymentNotificationsResponseDescriptor = $convert.base64Decode('CiZHZXRJbnZvaWNlUGF5bWVudE5vdGlmaWNhdGlvbnNSZXNwb25zZRJECg1ub3RpZmljYXRpb25zGAEgAygLMh4ucGIuSW52b2ljZVBheW1lbnROb3RpZmljYXRpb25SDW5vdGlmaWNhdGlvbnMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2VuEh8KC3RvdGFsX2NvdW50GAMgASgEUgp0b3RhbENvdW50EiEKDHVucmVhZF9jb3VudBgEIAEoBFILdW5yZWFkQ291bnQ=');
@$core.Deprecated('Use updateTaggedInvoiceStatusRequestDescriptor instead')
const UpdateTaggedInvoiceStatusRequest$json = const {
  '1': 'UpdateTaggedInvoiceStatusRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'new_status', '3': 2, '4': 1, '5': 14, '6': '.pb.InvoicePaymentStatus', '10': 'newStatus'},
    const {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateTaggedInvoiceStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTaggedInvoiceStatusRequestDescriptor = $convert.base64Decode('CiBVcGRhdGVUYWdnZWRJbnZvaWNlU3RhdHVzUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSNwoKbmV3X3N0YXR1cxgCIAEoDjIYLnBiLkludm9pY2VQYXltZW50U3RhdHVzUgluZXdTdGF0dXMSFAoFbm90ZXMYAyABKAlSBW5vdGVz');
@$core.Deprecated('Use updateTaggedInvoiceStatusResponseDescriptor instead')
const UpdateTaggedInvoiceStatusResponse$json = const {
  '1': 'UpdateTaggedInvoiceStatusResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.pb.TaggedInvoice', '10': 'invoice'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateTaggedInvoiceStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTaggedInvoiceStatusResponseDescriptor = $convert.base64Decode('CiFVcGRhdGVUYWdnZWRJbnZvaWNlU3RhdHVzUmVzcG9uc2USKwoHaW52b2ljZRgBIAEoCzIRLnBiLlRhZ2dlZEludm9pY2VSB2ludm9pY2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteTaggedInvoiceRequestDescriptor instead')
const DeleteTaggedInvoiceRequest$json = const {
  '1': 'DeleteTaggedInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `DeleteTaggedInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTaggedInvoiceRequestDescriptor = $convert.base64Decode('ChpEZWxldGVUYWdnZWRJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQ=');
@$core.Deprecated('Use deleteTaggedInvoiceResponseDescriptor instead')
const DeleteTaggedInvoiceResponse$json = const {
  '1': 'DeleteTaggedInvoiceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteTaggedInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTaggedInvoiceResponseDescriptor = $convert.base64Decode('ChtEZWxldGVUYWdnZWRJbnZvaWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use markMultipleInvoicesAsViewedRequestDescriptor instead')
const MarkMultipleInvoicesAsViewedRequest$json = const {
  '1': 'MarkMultipleInvoicesAsViewedRequest',
  '2': const [
    const {'1': 'invoice_ids', '3': 1, '4': 3, '5': 9, '10': 'invoiceIds'},
  ],
};

/// Descriptor for `MarkMultipleInvoicesAsViewedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markMultipleInvoicesAsViewedRequestDescriptor = $convert.base64Decode('CiNNYXJrTXVsdGlwbGVJbnZvaWNlc0FzVmlld2VkUmVxdWVzdBIfCgtpbnZvaWNlX2lkcxgBIAMoCVIKaW52b2ljZUlkcw==');
@$core.Deprecated('Use markMultipleInvoicesAsViewedResponseDescriptor instead')
const MarkMultipleInvoicesAsViewedResponse$json = const {
  '1': 'MarkMultipleInvoicesAsViewedResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'updated_count', '3': 3, '4': 1, '5': 4, '10': 'updatedCount'},
  ],
};

/// Descriptor for `MarkMultipleInvoicesAsViewedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markMultipleInvoicesAsViewedResponseDescriptor = $convert.base64Decode('CiRNYXJrTXVsdGlwbGVJbnZvaWNlc0FzVmlld2VkUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiMKDXVwZGF0ZWRfY291bnQYAyABKARSDHVwZGF0ZWRDb3VudA==');
@$core.Deprecated('Use bulkSetPaymentRemindersRequestDescriptor instead')
const BulkSetPaymentRemindersRequest$json = const {
  '1': 'BulkSetPaymentRemindersRequest',
  '2': const [
    const {'1': 'invoice_ids', '3': 1, '4': 3, '5': 9, '10': 'invoiceIds'},
    const {'1': 'reminder_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
  ],
};

/// Descriptor for `BulkSetPaymentRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkSetPaymentRemindersRequestDescriptor = $convert.base64Decode('Ch5CdWxrU2V0UGF5bWVudFJlbWluZGVyc1JlcXVlc3QSHwoLaW52b2ljZV9pZHMYASADKAlSCmludm9pY2VJZHMSPwoNcmVtaW5kZXJfZGF0ZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZQ==');
@$core.Deprecated('Use bulkSetPaymentRemindersResponseDescriptor instead')
const BulkSetPaymentRemindersResponse$json = const {
  '1': 'BulkSetPaymentRemindersResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'updated_count', '3': 3, '4': 1, '5': 4, '10': 'updatedCount'},
  ],
};

/// Descriptor for `BulkSetPaymentRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bulkSetPaymentRemindersResponseDescriptor = $convert.base64Decode('Ch9CdWxrU2V0UGF5bWVudFJlbWluZGVyc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIjCg11cGRhdGVkX2NvdW50GAMgASgEUgx1cGRhdGVkQ291bnQ=');
@$core.Deprecated('Use getTaggedInvoiceStatisticsRequestDescriptor instead')
const GetTaggedInvoiceStatisticsRequest$json = const {
  '1': 'GetTaggedInvoiceStatisticsRequest',
};

/// Descriptor for `GetTaggedInvoiceStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaggedInvoiceStatisticsRequestDescriptor = $convert.base64Decode('CiFHZXRUYWdnZWRJbnZvaWNlU3RhdGlzdGljc1JlcXVlc3Q=');
@$core.Deprecated('Use getTaggedInvoiceStatisticsResponseDescriptor instead')
const GetTaggedInvoiceStatisticsResponse$json = const {
  '1': 'GetTaggedInvoiceStatisticsResponse',
  '2': const [
    const {'1': 'statistics', '3': 1, '4': 1, '5': 11, '6': '.pb.TaggedInvoiceStatistics', '10': 'statistics'},
  ],
};

/// Descriptor for `GetTaggedInvoiceStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaggedInvoiceStatisticsResponseDescriptor = $convert.base64Decode('CiJHZXRUYWdnZWRJbnZvaWNlU3RhdGlzdGljc1Jlc3BvbnNlEjsKCnN0YXRpc3RpY3MYASABKAsyGy5wYi5UYWdnZWRJbnZvaWNlU3RhdGlzdGljc1IKc3RhdGlzdGljcw==');
@$core.Deprecated('Use taggedInvoiceStatisticsDescriptor instead')
const TaggedInvoiceStatistics$json = const {
  '1': 'TaggedInvoiceStatistics',
  '2': const [
    const {'1': 'total_invoices', '3': 1, '4': 1, '5': 4, '10': 'totalInvoices'},
    const {'1': 'pending_invoices', '3': 2, '4': 1, '5': 4, '10': 'pendingInvoices'},
    const {'1': 'overdue_invoices', '3': 3, '4': 1, '5': 4, '10': 'overdueInvoices'},
    const {'1': 'completed_invoices', '3': 4, '4': 1, '5': 4, '10': 'completedInvoices'},
    const {'1': 'total_amount', '3': 5, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'pending_amount', '3': 6, '4': 1, '5': 1, '10': 'pendingAmount'},
    const {'1': 'overdue_amount', '3': 7, '4': 1, '5': 1, '10': 'overdueAmount'},
    const {'1': 'completed_amount', '3': 8, '4': 1, '5': 1, '10': 'completedAmount'},
    const {'1': 'average_amount', '3': 9, '4': 1, '5': 1, '10': 'averageAmount'},
    const {'1': 'most_common_priority', '3': 10, '4': 1, '5': 14, '6': '.pb.InvoicePriority', '10': 'mostCommonPriority'},
  ],
};

/// Descriptor for `TaggedInvoiceStatistics`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taggedInvoiceStatisticsDescriptor = $convert.base64Decode('ChdUYWdnZWRJbnZvaWNlU3RhdGlzdGljcxIlCg50b3RhbF9pbnZvaWNlcxgBIAEoBFINdG90YWxJbnZvaWNlcxIpChBwZW5kaW5nX2ludm9pY2VzGAIgASgEUg9wZW5kaW5nSW52b2ljZXMSKQoQb3ZlcmR1ZV9pbnZvaWNlcxgDIAEoBFIPb3ZlcmR1ZUludm9pY2VzEi0KEmNvbXBsZXRlZF9pbnZvaWNlcxgEIAEoBFIRY29tcGxldGVkSW52b2ljZXMSIQoMdG90YWxfYW1vdW50GAUgASgBUgt0b3RhbEFtb3VudBIlCg5wZW5kaW5nX2Ftb3VudBgGIAEoAVINcGVuZGluZ0Ftb3VudBIlCg5vdmVyZHVlX2Ftb3VudBgHIAEoAVINb3ZlcmR1ZUFtb3VudBIpChBjb21wbGV0ZWRfYW1vdW50GAggASgBUg9jb21wbGV0ZWRBbW91bnQSJQoOYXZlcmFnZV9hbW91bnQYCSABKAFSDWF2ZXJhZ2VBbW91bnQSRQoUbW9zdF9jb21tb25fcHJpb3JpdHkYCiABKA4yEy5wYi5JbnZvaWNlUHJpb3JpdHlSEm1vc3RDb21tb25Qcmlvcml0eQ==');
