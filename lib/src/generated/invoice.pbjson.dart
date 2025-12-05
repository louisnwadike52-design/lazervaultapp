///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use invoiceStatusDescriptor instead')
const InvoiceStatus$json = const {
  '1': 'InvoiceStatus',
  '2': const [
    const {'1': 'DRAFT', '2': 0},
    const {'1': 'SENT', '2': 1},
    const {'1': 'PAID', '2': 2},
    const {'1': 'VOID', '2': 3},
    const {'1': 'OVERDUE', '2': 4},
  ],
};

/// Descriptor for `InvoiceStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List invoiceStatusDescriptor = $convert.base64Decode('Cg1JbnZvaWNlU3RhdHVzEgkKBURSQUZUEAASCAoEU0VOVBABEggKBFBBSUQQAhIICgRWT0lEEAMSCwoHT1ZFUkRVRRAE');
@$core.Deprecated('Use customerDetailsDescriptor instead')
const CustomerDetails$json = const {
  '1': 'CustomerDetails',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'address', '3': 3, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `CustomerDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customerDetailsDescriptor = $convert.base64Decode('Cg9DdXN0b21lckRldGFpbHMSEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgVlbWFpbBgCIAEoCVIFZW1haWwSGAoHYWRkcmVzcxgDIAEoCVIHYWRkcmVzcw==');
@$core.Deprecated('Use invoiceItemDescriptor instead')
const InvoiceItem$json = const {
  '1': 'InvoiceItem',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'quantity', '3': 3, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'unit_price', '3': 4, '4': 1, '5': 1, '10': 'unitPrice'},
    const {'1': 'total_price', '3': 5, '4': 1, '5': 1, '10': 'totalPrice'},
  ],
};

/// Descriptor for `InvoiceItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceItemDescriptor = $convert.base64Decode('CgtJbnZvaWNlSXRlbRIXCgdpdGVtX2lkGAEgASgJUgZpdGVtSWQSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEhoKCHF1YW50aXR5GAMgASgFUghxdWFudGl0eRIdCgp1bml0X3ByaWNlGAQgASgBUgl1bml0UHJpY2USHwoLdG90YWxfcHJpY2UYBSABKAFSCnRvdGFsUHJpY2U=');
@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice$json = const {
  '1': 'Invoice',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'invoice_number', '3': 3, '4': 1, '5': 9, '10': 'invoiceNumber'},
    const {'1': 'customer_details', '3': 4, '4': 1, '5': 11, '6': '.pb.CustomerDetails', '10': 'customerDetails'},
    const {'1': 'items', '3': 5, '4': 3, '5': 11, '6': '.pb.InvoiceItem', '10': 'items'},
    const {'1': 'subtotal', '3': 6, '4': 1, '5': 1, '10': 'subtotal'},
    const {'1': 'tax', '3': 7, '4': 1, '5': 1, '10': 'tax'},
    const {'1': 'total_amount', '3': 8, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'currency_code', '3': 9, '4': 1, '5': 9, '10': 'currencyCode'},
    const {'1': 'issue_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'issueDate'},
    const {'1': 'due_date', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dueDate'},
    const {'1': 'status', '3': 12, '4': 1, '5': 14, '6': '.pb.InvoiceStatus', '10': 'status'},
    const {'1': 'notes', '3': 13, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `Invoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceDescriptor = $convert.base64Decode('CgdJbnZvaWNlEh0KCmludm9pY2VfaWQYASABKAlSCWludm9pY2VJZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOaW52b2ljZV9udW1iZXIYAyABKAlSDWludm9pY2VOdW1iZXISPgoQY3VzdG9tZXJfZGV0YWlscxgEIAEoCzITLnBiLkN1c3RvbWVyRGV0YWlsc1IPY3VzdG9tZXJEZXRhaWxzEiUKBWl0ZW1zGAUgAygLMg8ucGIuSW52b2ljZUl0ZW1SBWl0ZW1zEhoKCHN1YnRvdGFsGAYgASgBUghzdWJ0b3RhbBIQCgN0YXgYByABKAFSA3RheBIhCgx0b3RhbF9hbW91bnQYCCABKAFSC3RvdGFsQW1vdW50EiMKDWN1cnJlbmN5X2NvZGUYCSABKAlSDGN1cnJlbmN5Q29kZRI5Cgppc3N1ZV9kYXRlGAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJaXNzdWVEYXRlEjUKCGR1ZV9kYXRlGAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZHVlRGF0ZRIpCgZzdGF0dXMYDCABKA4yES5wYi5JbnZvaWNlU3RhdHVzUgZzdGF0dXMSFAoFbm90ZXMYDSABKAlSBW5vdGVzEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use createInvoiceRequestDescriptor instead')
const CreateInvoiceRequest$json = const {
  '1': 'CreateInvoiceRequest',
  '2': const [
    const {'1': 'customer_details', '3': 2, '4': 1, '5': 11, '6': '.pb.CustomerDetails', '8': const {}, '10': 'customerDetails'},
    const {'1': 'items', '3': 3, '4': 3, '5': 11, '6': '.pb.InvoiceItem', '8': const {}, '10': 'items'},
    const {'1': 'tax', '3': 4, '4': 1, '5': 1, '8': const {}, '10': 'tax'},
    const {'1': 'currency_code', '3': 5, '4': 1, '5': 9, '8': const {}, '10': 'currencyCode'},
    const {'1': 'due_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '8': const {}, '10': 'dueDate'},
    const {'1': 'notes', '3': 7, '4': 1, '5': 9, '8': const {}, '10': 'notes'},
  ],
  '7': const {},
};

/// Descriptor for `CreateInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvoiceRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVJbnZvaWNlUmVxdWVzdBJsChBjdXN0b21lcl9kZXRhaWxzGAIgASgLMhMucGIuQ3VzdG9tZXJEZXRhaWxzQiySQSkyJ0RldGFpbHMgb2YgdGhlIGN1c3RvbWVyIGJlaW5nIGludm9pY2VkLlIPY3VzdG9tZXJEZXRhaWxzEkcKBWl0ZW1zGAMgAygLMg8ucGIuSW52b2ljZUl0ZW1CIJJBHTIbTGluZSBpdGVtcyBmb3IgdGhlIGludm9pY2UuUgVpdGVtcxIrCgN0YXgYBCABKAFCGZJBFjIUT3B0aW9uYWwgdGF4IGFtb3VudC5SA3RheBJNCg1jdXJyZW5jeV9jb2RlGAUgASgJQiiSQSUyIzMtbGV0dGVyIGN1cnJlbmN5IGNvZGUgKGUuZy4sIFVTRCkuUgxjdXJyZW5jeUNvZGUSTQoIZHVlX2RhdGUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wQhaSQRMyEVBheW1lbnQgZHVlIGRhdGUuUgdkdWVEYXRlEjMKBW5vdGVzGAcgASgJQh2SQRoyGE9wdGlvbmFsIG5vdGVzIG9yIHRlcm1zLlIFbm90ZXM6dZJBcgpwKhZDcmVhdGUgSW52b2ljZSBSZXF1ZXN0MiBQYXlsb2FkIHRvIGNyZWF0ZSBhIG5ldyBpbnZvaWNlLtIBEGN1c3RvbWVyX2RldGFpbHPSAQVpdGVtc9IBDWN1cnJlbmN5X2NvZGXSAQhkdWVfZGF0ZQ==');
@$core.Deprecated('Use createInvoiceResponseDescriptor instead')
const CreateInvoiceResponse$json = const {
  '1': 'CreateInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.pb.Invoice', '10': 'invoice'},
  ],
  '7': const {},
};

/// Descriptor for `CreateInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvoiceResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVJbnZvaWNlUmVzcG9uc2USJQoHaW52b2ljZRgBIAEoCzILLnBiLkludm9pY2VSB2ludm9pY2U6UpJBTwpNKhdDcmVhdGUgSW52b2ljZSBSZXNwb25zZTIyQ29udGFpbnMgdGhlIGRldGFpbHMgb2YgdGhlIG5ld2x5IGNyZWF0ZWQgaW52b2ljZS4=');
@$core.Deprecated('Use getInvoiceRequestDescriptor instead')
const GetInvoiceRequest$json = const {
  '1': 'GetInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'invoiceId'},
  ],
  '7': const {},
};

/// Descriptor for `GetInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceRequestDescriptor = $convert.base64Decode('ChFHZXRJbnZvaWNlUmVxdWVzdBJNCgppbnZvaWNlX2lkGAEgASgJQi6SQSsyKVRoZSB1bmlxdWUgSUQgb2YgdGhlIGludm9pY2UgdG8gcmV0cmlldmUuUglpbnZvaWNlSWQ6WpJBVwpVKhNHZXQgSW52b2ljZSBSZXF1ZXN0MjFQYXlsb2FkIHRvIHJldHJpZXZlIGEgc3BlY2lmaWMgaW52b2ljZSBieSBpdHMgSUQu0gEKaW52b2ljZV9pZA==');
@$core.Deprecated('Use listInvoicesRequestDescriptor instead')
const ListInvoicesRequest$json = const {
  '1': 'ListInvoicesRequest',
  '2': const [
    const {'1': 'page_size', '3': 1, '4': 1, '5': 5, '8': const {}, '10': 'pageSize'},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'pageToken'},
    const {'1': 'status_filter', '3': 3, '4': 1, '5': 14, '6': '.pb.InvoiceStatus', '8': const {}, '10': 'statusFilter'},
  ],
  '7': const {},
};

/// Descriptor for `ListInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInvoicesRequestDescriptor = $convert.base64Decode('ChNMaXN0SW52b2ljZXNSZXF1ZXN0EksKCXBhZ2Vfc2l6ZRgBIAEoBUIukkErMilOdW1iZXIgb2YgaW52b2ljZXMgcGVyIHBhZ2UuIERlZmF1bHQ6IDIwLlIIcGFnZVNpemUSTwoKcGFnZV90b2tlbhgCIAEoCUIwkkEtMitUb2tlbiBmb3IgZmV0Y2hpbmcgdGhlIG5leHQgcGFnZS4gT3B0aW9uYWwuUglwYWdlVG9rZW4SXwoNc3RhdHVzX2ZpbHRlchgDIAEoDjIRLnBiLkludm9pY2VTdGF0dXNCJ5JBJDIiT3B0aW9uYWwgZmlsdGVyIGJ5IGludm9pY2Ugc3RhdHVzLlIMc3RhdHVzRmlsdGVyOm2SQWoKaCoVTGlzdCBJbnZvaWNlcyBSZXF1ZXN0Mk9QYXlsb2FkIHRvIHJldHJpZXZlIGEgbGlzdCBvZiBpbnZvaWNlcywgd2l0aCBvcHRpb25hbCBmaWx0ZXJpbmcgYW5kIHBhZ2luYXRpb24u');
@$core.Deprecated('Use listInvoicesResponseDescriptor instead')
const ListInvoicesResponse$json = const {
  '1': 'ListInvoicesResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.Invoice', '10': 'invoices'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
  '7': const {},
};

/// Descriptor for `ListInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInvoicesResponseDescriptor = $convert.base64Decode('ChRMaXN0SW52b2ljZXNSZXNwb25zZRInCghpbnZvaWNlcxgBIAMoCzILLnBiLkludm9pY2VSCGludm9pY2VzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbjpPkkFMCkoqFkxpc3QgSW52b2ljZXMgUmVzcG9uc2UyMENvbnRhaW5zIGEgbGlzdCBvZiBpbnZvaWNlcyBhbmQgcGFnaW5hdGlvbiBpbmZvLg==');
