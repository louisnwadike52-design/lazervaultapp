///
//  Generated code. Do not modify.
//  source: invoice.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use addressDetailsDescriptor instead')
const AddressDetails$json = const {
  '1': 'AddressDetails',
  '2': const [
    const {'1': 'company_name', '3': 1, '4': 1, '5': 9, '10': 'companyName'},
    const {'1': 'contact_name', '3': 2, '4': 1, '5': 9, '10': 'contactName'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'address_line1', '3': 5, '4': 1, '5': 9, '10': 'addressLine1'},
    const {'1': 'address_line2', '3': 6, '4': 1, '5': 9, '10': 'addressLine2'},
    const {'1': 'city', '3': 7, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'state', '3': 8, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'postcode', '3': 9, '4': 1, '5': 9, '10': 'postcode'},
    const {'1': 'country', '3': 10, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'bank_account', '3': 11, '4': 1, '5': 9, '10': 'bankAccount'},
    const {'1': 'bic_number', '3': 12, '4': 1, '5': 9, '10': 'bicNumber'},
    const {'1': 'iban', '3': 13, '4': 1, '5': 9, '10': 'iban'},
    const {'1': 'routing_number', '3': 14, '4': 1, '5': 9, '10': 'routingNumber'},
    const {'1': 'tax_id', '3': 15, '4': 1, '5': 9, '10': 'taxId'},
  ],
};

/// Descriptor for `AddressDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressDetailsDescriptor = $convert.base64Decode('Cg5BZGRyZXNzRGV0YWlscxIhCgxjb21wYW55X25hbWUYASABKAlSC2NvbXBhbnlOYW1lEiEKDGNvbnRhY3RfbmFtZRgCIAEoCVILY29udGFjdE5hbWUSFAoFZW1haWwYAyABKAlSBWVtYWlsEhQKBXBob25lGAQgASgJUgVwaG9uZRIjCg1hZGRyZXNzX2xpbmUxGAUgASgJUgxhZGRyZXNzTGluZTESIwoNYWRkcmVzc19saW5lMhgGIAEoCVIMYWRkcmVzc0xpbmUyEhIKBGNpdHkYByABKAlSBGNpdHkSFAoFc3RhdGUYCCABKAlSBXN0YXRlEhoKCHBvc3Rjb2RlGAkgASgJUghwb3N0Y29kZRIYCgdjb3VudHJ5GAogASgJUgdjb3VudHJ5EiEKDGJhbmtfYWNjb3VudBgLIAEoCVILYmFua0FjY291bnQSHQoKYmljX251bWJlchgMIAEoCVIJYmljTnVtYmVyEhIKBGliYW4YDSABKAlSBGliYW4SJQoOcm91dGluZ19udW1iZXIYDiABKAlSDXJvdXRpbmdOdW1iZXISFQoGdGF4X2lkGA8gASgJUgV0YXhJZA==');
@$core.Deprecated('Use invoiceItemDescriptor instead')
const InvoiceItem$json = const {
  '1': 'InvoiceItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'quantity', '3': 4, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'unit_price', '3': 5, '4': 1, '5': 1, '10': 'unitPrice'},
    const {'1': 'total_price', '3': 6, '4': 1, '5': 1, '10': 'totalPrice'},
    const {'1': 'category', '3': 7, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `InvoiceItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceItemDescriptor = $convert.base64Decode('CgtJbnZvaWNlSXRlbRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SGgoIcXVhbnRpdHkYBCABKAFSCHF1YW50aXR5Eh0KCnVuaXRfcHJpY2UYBSABKAFSCXVuaXRQcmljZRIfCgt0b3RhbF9wcmljZRgGIAEoAVIKdG90YWxQcmljZRIaCghjYXRlZ29yeRgHIAEoCVIIY2F0ZWdvcnk=');
@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice$json = const {
  '1': 'Invoice',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'recipient_id', '3': 3, '4': 1, '5': 9, '10': 'recipientId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'due_date', '3': 8, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'is_paid', '3': 9, '4': 1, '5': 8, '10': 'isPaid'},
    const {'1': 'payment_method_id', '3': 10, '4': 1, '5': 9, '10': 'paymentMethodId'},
    const {'1': 'payment_reference', '3': 11, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'items', '3': 14, '4': 3, '5': 11, '6': '.pb.InvoiceItem', '10': 'items'},
    const {'1': 'notes', '3': 15, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'tax_amount', '3': 16, '4': 1, '5': 1, '10': 'taxAmount'},
    const {'1': 'discount_amount', '3': 17, '4': 1, '5': 1, '10': 'discountAmount'},
    const {'1': 'total_amount', '3': 18, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'recipient_details', '3': 19, '4': 1, '5': 11, '6': '.pb.AddressDetails', '10': 'recipientDetails'},
    const {'1': 'payer_details', '3': 20, '4': 1, '5': 11, '6': '.pb.AddressDetails', '10': 'payerDetails'},
    const {'1': 'to_email', '3': 21, '4': 1, '5': 9, '10': 'toEmail'},
    const {'1': 'to_name', '3': 22, '4': 1, '5': 9, '10': 'toName'},
  ],
};

/// Descriptor for `Invoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceDescriptor = $convert.base64Decode('CgdJbnZvaWNlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSIQoMcmVjaXBpZW50X2lkGAMgASgJUgtyZWNpcGllbnRJZBIUCgV0aXRsZRgEIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIZCghkdWVfZGF0ZRgIIAEoCVIHZHVlRGF0ZRIXCgdpc19wYWlkGAkgASgIUgZpc1BhaWQSKgoRcGF5bWVudF9tZXRob2RfaWQYCiABKAlSD3BheW1lbnRNZXRob2RJZBIrChFwYXltZW50X3JlZmVyZW5jZRgLIAEoCVIQcGF5bWVudFJlZmVyZW5jZRI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSJQoFaXRlbXMYDiADKAsyDy5wYi5JbnZvaWNlSXRlbVIFaXRlbXMSFAoFbm90ZXMYDyABKAlSBW5vdGVzEh0KCnRheF9hbW91bnQYECABKAFSCXRheEFtb3VudBInCg9kaXNjb3VudF9hbW91bnQYESABKAFSDmRpc2NvdW50QW1vdW50EiEKDHRvdGFsX2Ftb3VudBgSIAEoAVILdG90YWxBbW91bnQSPwoRcmVjaXBpZW50X2RldGFpbHMYEyABKAsyEi5wYi5BZGRyZXNzRGV0YWlsc1IQcmVjaXBpZW50RGV0YWlscxI3Cg1wYXllcl9kZXRhaWxzGBQgASgLMhIucGIuQWRkcmVzc0RldGFpbHNSDHBheWVyRGV0YWlscxIZCgh0b19lbWFpbBgVIAEoCVIHdG9FbWFpbBIXCgd0b19uYW1lGBYgASgJUgZ0b05hbWU=');
@$core.Deprecated('Use getInvoicesRequestDescriptor instead')
const GetInvoicesRequest$json = const {
  '1': 'GetInvoicesRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInvoicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesRequestDescriptor = $convert.base64Decode('ChJHZXRJbnZvaWNlc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getInvoicesResponseDescriptor instead')
const GetInvoicesResponse$json = const {
  '1': 'GetInvoicesResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.Invoice', '10': 'invoices'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetInvoicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesResponseDescriptor = $convert.base64Decode('ChNHZXRJbnZvaWNlc1Jlc3BvbnNlEicKCGludm9pY2VzGAEgAygLMgsucGIuSW52b2ljZVIIaW52b2ljZXMSFAoFdG90YWwYAiABKANSBXRvdGFs');
@$core.Deprecated('Use getInvoiceByIdRequestDescriptor instead')
const GetInvoiceByIdRequest$json = const {
  '1': 'GetInvoiceByIdRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `GetInvoiceByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceByIdRequestDescriptor = $convert.base64Decode('ChVHZXRJbnZvaWNlQnlJZFJlcXVlc3QSHQoKaW52b2ljZV9pZBgBIAEoCVIJaW52b2ljZUlk');
@$core.Deprecated('Use getInvoiceByIdResponseDescriptor instead')
const GetInvoiceByIdResponse$json = const {
  '1': 'GetInvoiceByIdResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.pb.Invoice', '10': 'invoice'},
  ],
};

/// Descriptor for `GetInvoiceByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceByIdResponseDescriptor = $convert.base64Decode('ChZHZXRJbnZvaWNlQnlJZFJlc3BvbnNlEiUKB2ludm9pY2UYASABKAsyCy5wYi5JbnZvaWNlUgdpbnZvaWNl');
@$core.Deprecated('Use createInvoiceRequestDescriptor instead')
const CreateInvoiceRequest$json = const {
  '1': 'CreateInvoiceRequest',
  '2': const [
    const {'1': 'recipient_id', '3': 1, '4': 1, '5': 9, '10': 'recipientId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'due_date', '3': 6, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'items', '3': 7, '4': 3, '5': 11, '6': '.pb.InvoiceItem', '10': 'items'},
    const {'1': 'notes', '3': 8, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'tax_amount', '3': 9, '4': 1, '5': 1, '10': 'taxAmount'},
    const {'1': 'discount_amount', '3': 10, '4': 1, '5': 1, '10': 'discountAmount'},
    const {'1': 'total_amount', '3': 11, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'recipient_details', '3': 12, '4': 1, '5': 11, '6': '.pb.AddressDetails', '10': 'recipientDetails'},
    const {'1': 'payer_details', '3': 13, '4': 1, '5': 11, '6': '.pb.AddressDetails', '10': 'payerDetails'},
    const {'1': 'to_email', '3': 14, '4': 1, '5': 9, '10': 'toEmail'},
    const {'1': 'to_name', '3': 15, '4': 1, '5': 9, '10': 'toName'},
  ],
};

/// Descriptor for `CreateInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvoiceRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVJbnZvaWNlUmVxdWVzdBIhCgxyZWNpcGllbnRfaWQYASABKAlSC3JlY2lwaWVudElkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SFgoGYW1vdW50GAQgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhkKCGR1ZV9kYXRlGAYgASgJUgdkdWVEYXRlEiUKBWl0ZW1zGAcgAygLMg8ucGIuSW52b2ljZUl0ZW1SBWl0ZW1zEhQKBW5vdGVzGAggASgJUgVub3RlcxIdCgp0YXhfYW1vdW50GAkgASgBUgl0YXhBbW91bnQSJwoPZGlzY291bnRfYW1vdW50GAogASgBUg5kaXNjb3VudEFtb3VudBIhCgx0b3RhbF9hbW91bnQYCyABKAFSC3RvdGFsQW1vdW50Ej8KEXJlY2lwaWVudF9kZXRhaWxzGAwgASgLMhIucGIuQWRkcmVzc0RldGFpbHNSEHJlY2lwaWVudERldGFpbHMSNwoNcGF5ZXJfZGV0YWlscxgNIAEoCzISLnBiLkFkZHJlc3NEZXRhaWxzUgxwYXllckRldGFpbHMSGQoIdG9fZW1haWwYDiABKAlSB3RvRW1haWwSFwoHdG9fbmFtZRgPIAEoCVIGdG9OYW1l');
@$core.Deprecated('Use createInvoiceResponseDescriptor instead')
const CreateInvoiceResponse$json = const {
  '1': 'CreateInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.pb.Invoice', '10': 'invoice'},
  ],
};

/// Descriptor for `CreateInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInvoiceResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVJbnZvaWNlUmVzcG9uc2USJQoHaW52b2ljZRgBIAEoCzILLnBiLkludm9pY2VSB2ludm9pY2U=');
@$core.Deprecated('Use updateInvoiceRequestDescriptor instead')
const UpdateInvoiceRequest$json = const {
  '1': 'UpdateInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'recipient_id', '3': 2, '4': 1, '5': 9, '10': 'recipientId'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'due_date', '3': 7, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'items', '3': 8, '4': 3, '5': 11, '6': '.pb.InvoiceItem', '10': 'items'},
    const {'1': 'notes', '3': 9, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'tax_amount', '3': 10, '4': 1, '5': 1, '10': 'taxAmount'},
    const {'1': 'discount_amount', '3': 11, '4': 1, '5': 1, '10': 'discountAmount'},
    const {'1': 'total_amount', '3': 12, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'recipient_details', '3': 13, '4': 1, '5': 11, '6': '.pb.AddressDetails', '10': 'recipientDetails'},
    const {'1': 'payer_details', '3': 14, '4': 1, '5': 11, '6': '.pb.AddressDetails', '10': 'payerDetails'},
    const {'1': 'to_email', '3': 15, '4': 1, '5': 9, '10': 'toEmail'},
    const {'1': 'to_name', '3': 16, '4': 1, '5': 9, '10': 'toName'},
  ],
};

/// Descriptor for `UpdateInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVJbnZvaWNlUmVxdWVzdBIdCgppbnZvaWNlX2lkGAEgASgJUglpbnZvaWNlSWQSIQoMcmVjaXBpZW50X2lkGAIgASgJUgtyZWNpcGllbnRJZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIZCghkdWVfZGF0ZRgHIAEoCVIHZHVlRGF0ZRIlCgVpdGVtcxgIIAMoCzIPLnBiLkludm9pY2VJdGVtUgVpdGVtcxIUCgVub3RlcxgJIAEoCVIFbm90ZXMSHQoKdGF4X2Ftb3VudBgKIAEoAVIJdGF4QW1vdW50EicKD2Rpc2NvdW50X2Ftb3VudBgLIAEoAVIOZGlzY291bnRBbW91bnQSIQoMdG90YWxfYW1vdW50GAwgASgBUgt0b3RhbEFtb3VudBI/ChFyZWNpcGllbnRfZGV0YWlscxgNIAEoCzISLnBiLkFkZHJlc3NEZXRhaWxzUhByZWNpcGllbnREZXRhaWxzEjcKDXBheWVyX2RldGFpbHMYDiABKAsyEi5wYi5BZGRyZXNzRGV0YWlsc1IMcGF5ZXJEZXRhaWxzEhkKCHRvX2VtYWlsGA8gASgJUgd0b0VtYWlsEhcKB3RvX25hbWUYECABKAlSBnRvTmFtZQ==');
@$core.Deprecated('Use updateInvoiceResponseDescriptor instead')
const UpdateInvoiceResponse$json = const {
  '1': 'UpdateInvoiceResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.pb.Invoice', '10': 'invoice'},
  ],
};

/// Descriptor for `UpdateInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInvoiceResponseDescriptor = $convert.base64Decode('ChVVcGRhdGVJbnZvaWNlUmVzcG9uc2USJQoHaW52b2ljZRgBIAEoCzILLnBiLkludm9pY2VSB2ludm9pY2U=');
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
  ],
};

/// Descriptor for `DeleteInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInvoiceResponseDescriptor = $convert.base64Decode('ChVEZWxldGVJbnZvaWNlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');
@$core.Deprecated('Use getInvoicesByStatusRequestDescriptor instead')
const GetInvoicesByStatusRequest$json = const {
  '1': 'GetInvoicesByStatusRequest',
  '2': const [
    const {'1': 'is_paid', '3': 1, '4': 1, '5': 8, '10': 'isPaid'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInvoicesByStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesByStatusRequestDescriptor = $convert.base64Decode('ChpHZXRJbnZvaWNlc0J5U3RhdHVzUmVxdWVzdBIXCgdpc19wYWlkGAEgASgIUgZpc1BhaWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getInvoicesByStatusResponseDescriptor instead')
const GetInvoicesByStatusResponse$json = const {
  '1': 'GetInvoicesByStatusResponse',
  '2': const [
    const {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.pb.Invoice', '10': 'invoices'},
    const {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetInvoicesByStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoicesByStatusResponseDescriptor = $convert.base64Decode('ChtHZXRJbnZvaWNlc0J5U3RhdHVzUmVzcG9uc2USJwoIaW52b2ljZXMYASADKAsyCy5wYi5JbnZvaWNlUghpbnZvaWNlcxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');
@$core.Deprecated('Use markInvoiceAsPaidRequestDescriptor instead')
const MarkInvoiceAsPaidRequest$json = const {
  '1': 'MarkInvoiceAsPaidRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'payment_method', '3': 2, '4': 1, '5': 11, '6': '.pb.PaymentMethod', '10': 'paymentMethod'},
    const {'1': 'payment_reference', '3': 3, '4': 1, '5': 9, '10': 'paymentReference'},
  ],
};

/// Descriptor for `MarkInvoiceAsPaidRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markInvoiceAsPaidRequestDescriptor = $convert.base64Decode('ChhNYXJrSW52b2ljZUFzUGFpZFJlcXVlc3QSHQoKaW52b2ljZV9pZBgBIAEoCVIJaW52b2ljZUlkEjgKDnBheW1lbnRfbWV0aG9kGAIgASgLMhEucGIuUGF5bWVudE1ldGhvZFINcGF5bWVudE1ldGhvZBIrChFwYXltZW50X3JlZmVyZW5jZRgDIAEoCVIQcGF5bWVudFJlZmVyZW5jZQ==');
@$core.Deprecated('Use markInvoiceAsPaidResponseDescriptor instead')
const MarkInvoiceAsPaidResponse$json = const {
  '1': 'MarkInvoiceAsPaidResponse',
  '2': const [
    const {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.pb.Invoice', '10': 'invoice'},
  ],
};

/// Descriptor for `MarkInvoiceAsPaidResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markInvoiceAsPaidResponseDescriptor = $convert.base64Decode('ChlNYXJrSW52b2ljZUFzUGFpZFJlc3BvbnNlEiUKB2ludm9pY2UYASABKAsyCy5wYi5JbnZvaWNlUgdpbnZvaWNl');
@$core.Deprecated('Use sendInvoiceRequestDescriptor instead')
const SendInvoiceRequest$json = const {
  '1': 'SendInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
  ],
};

/// Descriptor for `SendInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendInvoiceRequestDescriptor = $convert.base64Decode('ChJTZW5kSW52b2ljZVJlcXVlc3QSHQoKaW52b2ljZV9pZBgBIAEoCVIJaW52b2ljZUlk');
@$core.Deprecated('Use sendInvoiceResponseDescriptor instead')
const SendInvoiceResponse$json = const {
  '1': 'SendInvoiceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `SendInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendInvoiceResponseDescriptor = $convert.base64Decode('ChNTZW5kSW52b2ljZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');
@$core.Deprecated('Use tagUsersToInvoiceRequestDescriptor instead')
const TagUsersToInvoiceRequest$json = const {
  '1': 'TagUsersToInvoiceRequest',
  '2': const [
    const {'1': 'invoice_id', '3': 1, '4': 1, '5': 9, '10': 'invoiceId'},
    const {'1': 'user_ids', '3': 2, '4': 3, '5': 9, '10': 'userIds'},
    const {'1': 'emails', '3': 3, '4': 3, '5': 9, '10': 'emails'},
    const {'1': 'phone_numbers', '3': 4, '4': 3, '5': 9, '10': 'phoneNumbers'},
  ],
};

/// Descriptor for `TagUsersToInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagUsersToInvoiceRequestDescriptor = $convert.base64Decode('ChhUYWdVc2Vyc1RvSW52b2ljZVJlcXVlc3QSHQoKaW52b2ljZV9pZBgBIAEoCVIJaW52b2ljZUlkEhkKCHVzZXJfaWRzGAIgAygJUgd1c2VySWRzEhYKBmVtYWlscxgDIAMoCVIGZW1haWxzEiMKDXBob25lX251bWJlcnMYBCADKAlSDHBob25lTnVtYmVycw==');
@$core.Deprecated('Use tagUsersToInvoiceResponseDescriptor instead')
const TagUsersToInvoiceResponse$json = const {
  '1': 'TagUsersToInvoiceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'tagged_user_ids', '3': 2, '4': 3, '5': 9, '10': 'taggedUserIds'},
    const {'1': 'invited_emails', '3': 3, '4': 3, '5': 9, '10': 'invitedEmails'},
    const {'1': 'invited_phones', '3': 4, '4': 3, '5': 9, '10': 'invitedPhones'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TagUsersToInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagUsersToInvoiceResponseDescriptor = $convert.base64Decode('ChlUYWdVc2Vyc1RvSW52b2ljZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSJgoPdGFnZ2VkX3VzZXJfaWRzGAIgAygJUg10YWdnZWRVc2VySWRzEiUKDmludml0ZWRfZW1haWxzGAMgAygJUg1pbnZpdGVkRW1haWxzEiUKDmludml0ZWRfcGhvbmVzGAQgAygJUg1pbnZpdGVkUGhvbmVzEhgKB21lc3NhZ2UYBSABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use searchInvoiceUsersRequestDescriptor instead')
const SearchInvoiceUsersRequest$json = const {
  '1': 'SearchInvoiceUsersRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchInvoiceUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchInvoiceUsersRequestDescriptor = $convert.base64Decode('ChlTZWFyY2hJbnZvaWNlVXNlcnNSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use invoiceUserResultDescriptor instead')
const InvoiceUserResult$json = const {
  '1': 'InvoiceUserResult',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'is_online', '3': 6, '4': 1, '5': 8, '10': 'isOnline'},
  ],
};

/// Descriptor for `InvoiceUserResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceUserResultDescriptor = $convert.base64Decode('ChFJbnZvaWNlVXNlclJlc3VsdBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWwSGgoIdXNlcm5hbWUYBCABKAlSCHVzZXJuYW1lEhQKBXBob25lGAUgASgJUgVwaG9uZRIbCglpc19vbmxpbmUYBiABKAhSCGlzT25saW5l');
@$core.Deprecated('Use searchInvoiceUsersResponseDescriptor instead')
const SearchInvoiceUsersResponse$json = const {
  '1': 'SearchInvoiceUsersResponse',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.pb.InvoiceUserResult', '10': 'users'},
  ],
};

/// Descriptor for `SearchInvoiceUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchInvoiceUsersResponseDescriptor = $convert.base64Decode('ChpTZWFyY2hJbnZvaWNlVXNlcnNSZXNwb25zZRIrCgV1c2VycxgBIAMoCzIVLnBiLkludm9pY2VVc2VyUmVzdWx0UgV1c2Vycw==');
