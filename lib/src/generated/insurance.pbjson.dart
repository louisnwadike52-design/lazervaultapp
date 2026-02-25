//
//  Generated code. Do not modify.
//  source: insurance.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use insurancePaginationInfoDescriptor instead')
const InsurancePaginationInfo$json = {
  '1': 'InsurancePaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_prev', '3': 6, '4': 1, '5': 8, '10': 'hasPrev'},
  ],
};

/// Descriptor for `InsurancePaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePaginationInfoDescriptor = $convert.base64Decode(
    'ChdJbnN1cmFuY2VQYWdpbmF0aW9uSW5mbxIhCgxjdXJyZW50X3BhZ2UYASABKAVSC2N1cnJlbn'
    'RQYWdlEh8KC3RvdGFsX3BhZ2VzGAIgASgFUgp0b3RhbFBhZ2VzEh8KC3RvdGFsX2l0ZW1zGAMg'
    'ASgFUgp0b3RhbEl0ZW1zEiQKDml0ZW1zX3Blcl9wYWdlGAQgASgFUgxpdGVtc1BlclBhZ2USGQ'
    'oIaGFzX25leHQYBSABKAhSB2hhc05leHQSGQoIaGFzX3ByZXYYBiABKAhSB2hhc1ByZXY=');

@$core.Deprecated('Use getUserInsurancesRequestDescriptor instead')
const GetUserInsurancesRequest$json = {
  '1': 'GetUserInsurancesRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserInsurancesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsurancesRequestDescriptor = $convert.base64Decode(
    'ChhHZXRVc2VySW5zdXJhbmNlc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdB'
    'gCIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getUserInsurancesResponseDescriptor instead')
const GetUserInsurancesResponse$json = {
  '1': 'GetUserInsurancesResponse',
  '2': [
    {'1': 'insurances', '3': 1, '4': 3, '5': 11, '6': '.pb.Insurance', '10': 'insurances'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserInsurancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsurancesResponseDescriptor = $convert.base64Decode(
    'ChlHZXRVc2VySW5zdXJhbmNlc1Jlc3BvbnNlEi0KCmluc3VyYW5jZXMYASADKAsyDS5wYi5Jbn'
    'N1cmFuY2VSCmluc3VyYW5jZXMSOwoKcGFnaW5hdGlvbhgCIAEoCzIbLnBiLkluc3VyYW5jZVBh'
    'Z2luYXRpb25JbmZvUgpwYWdpbmF0aW9uEhgKB3N1Y2Nlc3MYAyABKAhSB3N1Y2Nlc3MSEAoDbX'
    'NnGAQgASgJUgNtc2c=');

@$core.Deprecated('Use getInsuranceByIdRequestDescriptor instead')
const GetInsuranceByIdRequest$json = {
  '1': 'GetInsuranceByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetInsuranceByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceByIdRequestDescriptor = $convert.base64Decode(
    'ChdHZXRJbnN1cmFuY2VCeUlkUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use getInsuranceByIdResponseDescriptor instead')
const GetInsuranceByIdResponse$json = {
  '1': 'GetInsuranceByIdResponse',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceByIdResponseDescriptor = $convert.base64Decode(
    'ChhHZXRJbnN1cmFuY2VCeUlkUmVzcG9uc2USKwoJaW5zdXJhbmNlGAEgASgLMg0ucGIuSW5zdX'
    'JhbmNlUglpbnN1cmFuY2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIQCgNtc2cYAyABKAlS'
    'A21zZw==');

@$core.Deprecated('Use createInsuranceRequestDescriptor instead')
const CreateInsuranceRequest$json = {
  '1': 'CreateInsuranceRequest',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `CreateInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInsuranceRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVJbnN1cmFuY2VSZXF1ZXN0EisKCWluc3VyYW5jZRgBIAEoCzINLnBiLkluc3VyYW'
    '5jZVIJaW5zdXJhbmNl');

@$core.Deprecated('Use createInsuranceResponseDescriptor instead')
const CreateInsuranceResponse$json = {
  '1': 'CreateInsuranceResponse',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreateInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInsuranceResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVJbnN1cmFuY2VSZXNwb25zZRIrCglpbnN1cmFuY2UYASABKAsyDS5wYi5JbnN1cm'
    'FuY2VSCWluc3VyYW5jZRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVID'
    'bXNn');

@$core.Deprecated('Use updateInsuranceRequestDescriptor instead')
const UpdateInsuranceRequest$json = {
  '1': 'UpdateInsuranceRequest',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `UpdateInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsuranceRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVJbnN1cmFuY2VSZXF1ZXN0EisKCWluc3VyYW5jZRgBIAEoCzINLnBiLkluc3VyYW'
    '5jZVIJaW5zdXJhbmNl');

@$core.Deprecated('Use updateInsuranceResponseDescriptor instead')
const UpdateInsuranceResponse$json = {
  '1': 'UpdateInsuranceResponse',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `UpdateInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsuranceResponseDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVJbnN1cmFuY2VSZXNwb25zZRIrCglpbnN1cmFuY2UYASABKAsyDS5wYi5JbnN1cm'
    'FuY2VSCWluc3VyYW5jZRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVID'
    'bXNn');

@$core.Deprecated('Use deleteInsuranceRequestDescriptor instead')
const DeleteInsuranceRequest$json = {
  '1': 'DeleteInsuranceRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInsuranceRequestDescriptor = $convert.base64Decode(
    'ChZEZWxldGVJbnN1cmFuY2VSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use deleteInsuranceResponseDescriptor instead')
const DeleteInsuranceResponse$json = {
  '1': 'DeleteInsuranceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `DeleteInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInsuranceResponseDescriptor = $convert.base64Decode(
    'ChdEZWxldGVJbnN1cmFuY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA2'
    '1zZxgCIAEoCVIDbXNn');

@$core.Deprecated('Use searchInsurancesRequestDescriptor instead')
const SearchInsurancesRequest$json = {
  '1': 'SearchInsurancesRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchInsurancesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchInsurancesRequestDescriptor = $convert.base64Decode(
    'ChdTZWFyY2hJbnN1cmFuY2VzUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSEgoEcGFnZR'
    'gCIAEoBVIEcGFnZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use searchInsurancesResponseDescriptor instead')
const SearchInsurancesResponse$json = {
  '1': 'SearchInsurancesResponse',
  '2': [
    {'1': 'insurances', '3': 1, '4': 3, '5': 11, '6': '.pb.Insurance', '10': 'insurances'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `SearchInsurancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchInsurancesResponseDescriptor = $convert.base64Decode(
    'ChhTZWFyY2hJbnN1cmFuY2VzUmVzcG9uc2USLQoKaW5zdXJhbmNlcxgBIAMoCzINLnBiLkluc3'
    'VyYW5jZVIKaW5zdXJhbmNlcxI7CgpwYWdpbmF0aW9uGAIgASgLMhsucGIuSW5zdXJhbmNlUGFn'
    'aW5hdGlvbkluZm9SCnBhZ2luYXRpb24SGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2VzcxIQCgNtc2'
    'cYBCABKAlSA21zZw==');

@$core.Deprecated('Use getInsurancePaymentsRequestDescriptor instead')
const GetInsurancePaymentsRequest$json = {
  '1': 'GetInsurancePaymentsRequest',
  '2': [
    {'1': 'insurance_id', '3': 1, '4': 1, '5': 9, '10': 'insuranceId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInsurancePaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRJbnN1cmFuY2VQYXltZW50c1JlcXVlc3QSIQoMaW5zdXJhbmNlX2lkGAEgASgJUgtpbn'
    'N1cmFuY2VJZBISCgRwYWdlGAIgASgFUgRwYWdlEhQKBWxpbWl0GAMgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getInsurancePaymentsResponseDescriptor instead')
const GetInsurancePaymentsResponse$json = {
  '1': 'GetInsurancePaymentsResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.InsurancePayment', '10': 'payments'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsurancePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRJbnN1cmFuY2VQYXltZW50c1Jlc3BvbnNlEjAKCHBheW1lbnRzGAEgAygLMhQucGIuSW'
    '5zdXJhbmNlUGF5bWVudFIIcGF5bWVudHMSOwoKcGFnaW5hdGlvbhgCIAEoCzIbLnBiLkluc3Vy'
    'YW5jZVBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9uEhgKB3N1Y2Nlc3MYAyABKAhSB3N1Y2Nlc3'
    'MSEAoDbXNnGAQgASgJUgNtc2c=');

@$core.Deprecated('Use getUserPaymentsRequestDescriptor instead')
const GetUserPaymentsRequest$json = {
  '1': 'GetUserPaymentsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPaymentsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyUGF5bWVudHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAi'
    'ABKAVSBWxpbWl0');

@$core.Deprecated('Use getUserPaymentsResponseDescriptor instead')
const GetUserPaymentsResponse$json = {
  '1': 'GetUserPaymentsResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.InsurancePayment', '10': 'payments'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPaymentsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyUGF5bWVudHNSZXNwb25zZRIwCghwYXltZW50cxgBIAMoCzIULnBiLkluc3VyYW'
    '5jZVBheW1lbnRSCHBheW1lbnRzEjsKCnBhZ2luYXRpb24YAiABKAsyGy5wYi5JbnN1cmFuY2VQ'
    'YWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbhIYCgdzdWNjZXNzGAMgASgIUgdzdWNjZXNzEhAKA2'
    '1zZxgEIAEoCVIDbXNn');

@$core.Deprecated('Use createPaymentRequestDescriptor instead')
const CreatePaymentRequest$json = {
  '1': 'CreatePaymentRequest',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePayment', '10': 'payment'},
  ],
};

/// Descriptor for `CreatePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVQYXltZW50UmVxdWVzdBIuCgdwYXltZW50GAEgASgLMhQucGIuSW5zdXJhbmNlUG'
    'F5bWVudFIHcGF5bWVudA==');

@$core.Deprecated('Use createPaymentResponseDescriptor instead')
const CreatePaymentResponse$json = {
  '1': 'CreatePaymentResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePayment', '10': 'payment'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreatePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVQYXltZW50UmVzcG9uc2USLgoHcGF5bWVudBgBIAEoCzIULnBiLkluc3VyYW5jZV'
    'BheW1lbnRSB3BheW1lbnQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIQCgNtc2cYAyABKAlS'
    'A21zZw==');

@$core.Deprecated('Use processPaymentRequestDescriptor instead')
const ProcessPaymentRequest$json = {
  '1': 'ProcessPaymentRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'payment_method', '3': 2, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'payment_details', '3': 3, '4': 3, '5': 11, '6': '.pb.ProcessPaymentRequest.PaymentDetailsEntry', '10': 'paymentDetails'},
  ],
  '3': [ProcessPaymentRequest_PaymentDetailsEntry$json],
};

@$core.Deprecated('Use processPaymentRequestDescriptor instead')
const ProcessPaymentRequest_PaymentDetailsEntry$json = {
  '1': 'PaymentDetailsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ProcessPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPaymentRequestDescriptor = $convert.base64Decode(
    'ChVQcm9jZXNzUGF5bWVudFJlcXVlc3QSHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudElkEi'
    'UKDnBheW1lbnRfbWV0aG9kGAIgASgJUg1wYXltZW50TWV0aG9kElYKD3BheW1lbnRfZGV0YWls'
    'cxgDIAMoCzItLnBiLlByb2Nlc3NQYXltZW50UmVxdWVzdC5QYXltZW50RGV0YWlsc0VudHJ5Ug'
    '5wYXltZW50RGV0YWlscxpBChNQYXltZW50RGV0YWlsc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5'
    'EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use processPaymentResponseDescriptor instead')
const ProcessPaymentResponse$json = {
  '1': 'ProcessPaymentResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePayment', '10': 'payment'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'reference_number', '3': 3, '4': 1, '5': 9, '10': 'referenceNumber'},
    {'1': 'receipt_url', '3': 4, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'success', '3': 5, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 6, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `ProcessPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPaymentResponseDescriptor = $convert.base64Decode(
    'ChZQcm9jZXNzUGF5bWVudFJlc3BvbnNlEi4KB3BheW1lbnQYASABKAsyFC5wYi5JbnN1cmFuY2'
    'VQYXltZW50UgdwYXltZW50EiUKDnRyYW5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklk'
    'EikKEHJlZmVyZW5jZV9udW1iZXIYAyABKAlSD3JlZmVyZW5jZU51bWJlchIfCgtyZWNlaXB0X3'
    'VybBgEIAEoCVIKcmVjZWlwdFVybBIYCgdzdWNjZXNzGAUgASgIUgdzdWNjZXNzEhAKA21zZxgG'
    'IAEoCVIDbXNn');

@$core.Deprecated('Use getPaymentByIdRequestDescriptor instead')
const GetPaymentByIdRequest$json = {
  '1': 'GetPaymentByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetPaymentByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentByIdRequestDescriptor = $convert.base64Decode(
    'ChVHZXRQYXltZW50QnlJZFJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use getPaymentByIdResponseDescriptor instead')
const GetPaymentByIdResponse$json = {
  '1': 'GetPaymentByIdResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePayment', '10': 'payment'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetPaymentByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentByIdResponseDescriptor = $convert.base64Decode(
    'ChZHZXRQYXltZW50QnlJZFJlc3BvbnNlEi4KB3BheW1lbnQYASABKAsyFC5wYi5JbnN1cmFuY2'
    'VQYXltZW50UgdwYXltZW50EhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJ'
    'UgNtc2c=');

@$core.Deprecated('Use getOverduePaymentsRequestDescriptor instead')
const GetOverduePaymentsRequest$json = {
  '1': 'GetOverduePaymentsRequest',
};

/// Descriptor for `GetOverduePaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverduePaymentsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRPdmVyZHVlUGF5bWVudHNSZXF1ZXN0');

@$core.Deprecated('Use getOverduePaymentsResponseDescriptor instead')
const GetOverduePaymentsResponse$json = {
  '1': 'GetOverduePaymentsResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.InsurancePayment', '10': 'payments'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetOverduePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverduePaymentsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRPdmVyZHVlUGF5bWVudHNSZXNwb25zZRIwCghwYXltZW50cxgBIAMoCzIULnBiLkluc3'
    'VyYW5jZVBheW1lbnRSCHBheW1lbnRzEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNn'
    'GAMgASgJUgNtc2c=');

@$core.Deprecated('Use getInsuranceClaimsRequestDescriptor instead')
const GetInsuranceClaimsRequest$json = {
  '1': 'GetInsuranceClaimsRequest',
  '2': [
    {'1': 'insurance_id', '3': 1, '4': 1, '5': 9, '10': 'insuranceId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInsuranceClaimsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimsRequestDescriptor = $convert.base64Decode(
    'ChlHZXRJbnN1cmFuY2VDbGFpbXNSZXF1ZXN0EiEKDGluc3VyYW5jZV9pZBgBIAEoCVILaW5zdX'
    'JhbmNlSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getInsuranceClaimsResponseDescriptor instead')
const GetInsuranceClaimsResponse$json = {
  '1': 'GetInsuranceClaimsResponse',
  '2': [
    {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claims'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRJbnN1cmFuY2VDbGFpbXNSZXNwb25zZRIqCgZjbGFpbXMYASADKAsyEi5wYi5JbnN1cm'
    'FuY2VDbGFpbVIGY2xhaW1zEjsKCnBhZ2luYXRpb24YAiABKAsyGy5wYi5JbnN1cmFuY2VQYWdp'
    'bmF0aW9uSW5mb1IKcGFnaW5hdGlvbhIYCgdzdWNjZXNzGAMgASgIUgdzdWNjZXNzEhAKA21zZx'
    'gEIAEoCVIDbXNn');

@$core.Deprecated('Use getUserClaimsRequestDescriptor instead')
const GetUserClaimsRequest$json = {
  '1': 'GetUserClaimsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserClaimsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserClaimsRequestDescriptor = $convert.base64Decode(
    'ChRHZXRVc2VyQ2xhaW1zUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgAS'
    'gFUgVsaW1pdA==');

@$core.Deprecated('Use getUserClaimsResponseDescriptor instead')
const GetUserClaimsResponse$json = {
  '1': 'GetUserClaimsResponse',
  '2': [
    {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claims'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserClaimsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyQ2xhaW1zUmVzcG9uc2USKgoGY2xhaW1zGAEgAygLMhIucGIuSW5zdXJhbmNlQ2'
    'xhaW1SBmNsYWltcxI7CgpwYWdpbmF0aW9uGAIgASgLMhsucGIuSW5zdXJhbmNlUGFnaW5hdGlv'
    'bkluZm9SCnBhZ2luYXRpb24SGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2VzcxIQCgNtc2cYBCABKA'
    'lSA21zZw==');

@$core.Deprecated('Use createClaimRequestDescriptor instead')
const CreateClaimRequest$json = {
  '1': 'CreateClaimRequest',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
  ],
};

/// Descriptor for `CreateClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createClaimRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVDbGFpbVJlcXVlc3QSKAoFY2xhaW0YASABKAsyEi5wYi5JbnN1cmFuY2VDbGFpbV'
    'IFY2xhaW0=');

@$core.Deprecated('Use createClaimResponseDescriptor instead')
const CreateClaimResponse$json = {
  '1': 'CreateClaimResponse',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreateClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createClaimResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVDbGFpbVJlc3BvbnNlEigKBWNsYWltGAEgASgLMhIucGIuSW5zdXJhbmNlQ2xhaW'
    '1SBWNsYWltEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJUgNtc2c=');

@$core.Deprecated('Use updateClaimRequestDescriptor instead')
const UpdateClaimRequest$json = {
  '1': 'UpdateClaimRequest',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
  ],
};

/// Descriptor for `UpdateClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateClaimRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVDbGFpbVJlcXVlc3QSKAoFY2xhaW0YASABKAsyEi5wYi5JbnN1cmFuY2VDbGFpbV'
    'IFY2xhaW0=');

@$core.Deprecated('Use updateClaimResponseDescriptor instead')
const UpdateClaimResponse$json = {
  '1': 'UpdateClaimResponse',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `UpdateClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateClaimResponseDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVDbGFpbVJlc3BvbnNlEigKBWNsYWltGAEgASgLMhIucGIuSW5zdXJhbmNlQ2xhaW'
    '1SBWNsYWltEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJUgNtc2c=');

@$core.Deprecated('Use getClaimByIdRequestDescriptor instead')
const GetClaimByIdRequest$json = {
  '1': 'GetClaimByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetClaimByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClaimByIdRequestDescriptor = $convert.base64Decode(
    'ChNHZXRDbGFpbUJ5SWRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use getClaimByIdResponseDescriptor instead')
const GetClaimByIdResponse$json = {
  '1': 'GetClaimByIdResponse',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetClaimByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClaimByIdResponseDescriptor = $convert.base64Decode(
    'ChRHZXRDbGFpbUJ5SWRSZXNwb25zZRIoCgVjbGFpbRgBIAEoCzISLnBiLkluc3VyYW5jZUNsYW'
    'ltUgVjbGFpbRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVIDbXNn');

@$core.Deprecated('Use generatePaymentReceiptRequestDescriptor instead')
const GeneratePaymentReceiptRequest$json = {
  '1': 'GeneratePaymentReceiptRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GeneratePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatePaymentReceiptRequestDescriptor = $convert.base64Decode(
    'Ch1HZW5lcmF0ZVBheW1lbnRSZWNlaXB0UmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYX'
    'ltZW50SWQ=');

@$core.Deprecated('Use generatePaymentReceiptResponseDescriptor instead')
const GeneratePaymentReceiptResponse$json = {
  '1': 'GeneratePaymentReceiptResponse',
  '2': [
    {'1': 'receipt_url', '3': 1, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'receipt_id', '3': 2, '4': 1, '5': 9, '10': 'receiptId'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GeneratePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatePaymentReceiptResponseDescriptor = $convert.base64Decode(
    'Ch5HZW5lcmF0ZVBheW1lbnRSZWNlaXB0UmVzcG9uc2USHwoLcmVjZWlwdF91cmwYASABKAlSCn'
    'JlY2VpcHRVcmwSHQoKcmVjZWlwdF9pZBgCIAEoCVIJcmVjZWlwdElkEhgKB3N1Y2Nlc3MYAyAB'
    'KAhSB3N1Y2Nlc3MSEAoDbXNnGAQgASgJUgNtc2c=');

@$core.Deprecated('Use getUserReceiptsRequestDescriptor instead')
const GetUserReceiptsRequest$json = {
  '1': 'GetUserReceiptsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserReceiptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserReceiptsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRVc2VyUmVjZWlwdHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAi'
    'ABKAVSBWxpbWl0');

@$core.Deprecated('Use getUserReceiptsResponseDescriptor instead')
const GetUserReceiptsResponse$json = {
  '1': 'GetUserReceiptsResponse',
  '2': [
    {'1': 'receipt_urls', '3': 1, '4': 3, '5': 9, '10': 'receiptUrls'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserReceiptsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyUmVjZWlwdHNSZXNwb25zZRIhCgxyZWNlaXB0X3VybHMYASADKAlSC3JlY2VpcH'
    'RVcmxzEjsKCnBhZ2luYXRpb24YAiABKAsyGy5wYi5JbnN1cmFuY2VQYWdpbmF0aW9uSW5mb1IK'
    'cGFnaW5hdGlvbhIYCgdzdWNjZXNzGAMgASgIUgdzdWNjZXNzEhAKA21zZxgEIAEoCVIDbXNn');

@$core.Deprecated('Use getInsuranceStatisticsRequestDescriptor instead')
const GetInsuranceStatisticsRequest$json = {
  '1': 'GetInsuranceStatisticsRequest',
};

/// Descriptor for `GetInsuranceStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceStatisticsRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRJbnN1cmFuY2VTdGF0aXN0aWNzUmVxdWVzdA==');

@$core.Deprecated('Use getInsuranceStatisticsResponseDescriptor instead')
const GetInsuranceStatisticsResponse$json = {
  '1': 'GetInsuranceStatisticsResponse',
  '2': [
    {'1': 'total_policies', '3': 1, '4': 1, '5': 5, '10': 'totalPolicies'},
    {'1': 'active_policies', '3': 2, '4': 1, '5': 5, '10': 'activePolicies'},
    {'1': 'expired_policies', '3': 3, '4': 1, '5': 5, '10': 'expiredPolicies'},
    {'1': 'total_coverage_amount', '3': 4, '4': 1, '5': 1, '10': 'totalCoverageAmount'},
    {'1': 'total_premium_amount', '3': 5, '4': 1, '5': 1, '10': 'totalPremiumAmount'},
    {'1': 'policies_by_type', '3': 6, '4': 3, '5': 11, '6': '.pb.GetInsuranceStatisticsResponse.PoliciesByTypeEntry', '10': 'policiesByType'},
    {'1': 'success', '3': 7, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 8, '4': 1, '5': 9, '10': 'msg'},
  ],
  '3': [GetInsuranceStatisticsResponse_PoliciesByTypeEntry$json],
};

@$core.Deprecated('Use getInsuranceStatisticsResponseDescriptor instead')
const GetInsuranceStatisticsResponse_PoliciesByTypeEntry$json = {
  '1': 'PoliciesByTypeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInsuranceStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceStatisticsResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRJbnN1cmFuY2VTdGF0aXN0aWNzUmVzcG9uc2USJQoOdG90YWxfcG9saWNpZXMYASABKA'
    'VSDXRvdGFsUG9saWNpZXMSJwoPYWN0aXZlX3BvbGljaWVzGAIgASgFUg5hY3RpdmVQb2xpY2ll'
    'cxIpChBleHBpcmVkX3BvbGljaWVzGAMgASgFUg9leHBpcmVkUG9saWNpZXMSMgoVdG90YWxfY2'
    '92ZXJhZ2VfYW1vdW50GAQgASgBUhN0b3RhbENvdmVyYWdlQW1vdW50EjAKFHRvdGFsX3ByZW1p'
    'dW1fYW1vdW50GAUgASgBUhJ0b3RhbFByZW1pdW1BbW91bnQSYAoQcG9saWNpZXNfYnlfdHlwZR'
    'gGIAMoCzI2LnBiLkdldEluc3VyYW5jZVN0YXRpc3RpY3NSZXNwb25zZS5Qb2xpY2llc0J5VHlw'
    'ZUVudHJ5Ug5wb2xpY2llc0J5VHlwZRIYCgdzdWNjZXNzGAcgASgIUgdzdWNjZXNzEhAKA21zZx'
    'gIIAEoCVIDbXNnGkEKE1BvbGljaWVzQnlUeXBlRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoF'
    'dmFsdWUYAiABKAVSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use getPaymentStatisticsRequestDescriptor instead')
const GetPaymentStatisticsRequest$json = {
  '1': 'GetPaymentStatisticsRequest',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetPaymentStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentStatisticsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRQYXltZW50U3RhdGlzdGljc1JlcXVlc3QSHQoKc3RhcnRfZGF0ZRgBIAEoCVIJc3Rhcn'
    'REYXRlEhkKCGVuZF9kYXRlGAIgASgJUgdlbmREYXRl');

@$core.Deprecated('Use getPaymentStatisticsResponseDescriptor instead')
const GetPaymentStatisticsResponse$json = {
  '1': 'GetPaymentStatisticsResponse',
  '2': [
    {'1': 'total_payments', '3': 1, '4': 1, '5': 5, '10': 'totalPayments'},
    {'1': 'completed_payments', '3': 2, '4': 1, '5': 5, '10': 'completedPayments'},
    {'1': 'pending_payments', '3': 3, '4': 1, '5': 5, '10': 'pendingPayments'},
    {'1': 'failed_payments', '3': 4, '4': 1, '5': 5, '10': 'failedPayments'},
    {'1': 'total_amount', '3': 5, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'completed_amount', '3': 6, '4': 1, '5': 1, '10': 'completedAmount'},
    {'1': 'payments_by_method', '3': 7, '4': 3, '5': 11, '6': '.pb.GetPaymentStatisticsResponse.PaymentsByMethodEntry', '10': 'paymentsByMethod'},
    {'1': 'success', '3': 8, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 9, '4': 1, '5': 9, '10': 'msg'},
  ],
  '3': [GetPaymentStatisticsResponse_PaymentsByMethodEntry$json],
};

@$core.Deprecated('Use getPaymentStatisticsResponseDescriptor instead')
const GetPaymentStatisticsResponse_PaymentsByMethodEntry$json = {
  '1': 'PaymentsByMethodEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetPaymentStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentStatisticsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRQYXltZW50U3RhdGlzdGljc1Jlc3BvbnNlEiUKDnRvdGFsX3BheW1lbnRzGAEgASgFUg'
    '10b3RhbFBheW1lbnRzEi0KEmNvbXBsZXRlZF9wYXltZW50cxgCIAEoBVIRY29tcGxldGVkUGF5'
    'bWVudHMSKQoQcGVuZGluZ19wYXltZW50cxgDIAEoBVIPcGVuZGluZ1BheW1lbnRzEicKD2ZhaW'
    'xlZF9wYXltZW50cxgEIAEoBVIOZmFpbGVkUGF5bWVudHMSIQoMdG90YWxfYW1vdW50GAUgASgB'
    'Ugt0b3RhbEFtb3VudBIpChBjb21wbGV0ZWRfYW1vdW50GAYgASgBUg9jb21wbGV0ZWRBbW91bn'
    'QSZAoScGF5bWVudHNfYnlfbWV0aG9kGAcgAygLMjYucGIuR2V0UGF5bWVudFN0YXRpc3RpY3NS'
    'ZXNwb25zZS5QYXltZW50c0J5TWV0aG9kRW50cnlSEHBheW1lbnRzQnlNZXRob2QSGAoHc3VjY2'
    'VzcxgIIAEoCFIHc3VjY2VzcxIQCgNtc2cYCSABKAlSA21zZxpDChVQYXltZW50c0J5TWV0aG9k'
    'RW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAVSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use insuranceProductFormFieldDescriptor instead')
const InsuranceProductFormField$json = {
  '1': 'InsuranceProductFormField',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'required', '3': 4, '4': 1, '5': 8, '10': 'required'},
    {'1': 'options', '3': 5, '4': 3, '5': 9, '10': 'options'},
    {'1': 'default_value', '3': 6, '4': 1, '5': 9, '10': 'defaultValue'},
    {'1': 'validation_regex', '3': 7, '4': 1, '5': 9, '10': 'validationRegex'},
    {'1': 'placeholder', '3': 8, '4': 1, '5': 9, '10': 'placeholder'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `InsuranceProductFormField`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceProductFormFieldDescriptor = $convert.base64Decode(
    'ChlJbnN1cmFuY2VQcm9kdWN0Rm9ybUZpZWxkEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFbGFiZW'
    'wYAiABKAlSBWxhYmVsEhIKBHR5cGUYAyABKAlSBHR5cGUSGgoIcmVxdWlyZWQYBCABKAhSCHJl'
    'cXVpcmVkEhgKB29wdGlvbnMYBSADKAlSB29wdGlvbnMSIwoNZGVmYXVsdF92YWx1ZRgGIAEoCV'
    'IMZGVmYXVsdFZhbHVlEikKEHZhbGlkYXRpb25fcmVnZXgYByABKAlSD3ZhbGlkYXRpb25SZWdl'
    'eBIgCgtwbGFjZWhvbGRlchgIIAEoCVILcGxhY2Vob2xkZXISIAoLZGVzY3JpcHRpb24YCSABKA'
    'lSC2Rlc2NyaXB0aW9u');

@$core.Deprecated('Use insuranceProductDescriptor instead')
const InsuranceProduct$json = {
  '1': 'InsuranceProduct',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'provider_name', '3': 5, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'provider_logo', '3': 6, '4': 1, '5': 9, '10': 'providerLogo'},
    {'1': 'min_premium', '3': 7, '4': 1, '5': 1, '10': 'minPremium'},
    {'1': 'max_premium', '3': 8, '4': 1, '5': 1, '10': 'maxPremium'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'benefits', '3': 10, '4': 3, '5': 9, '10': 'benefits'},
    {'1': 'terms_url', '3': 11, '4': 1, '5': 9, '10': 'termsUrl'},
    {'1': 'metadata', '3': 12, '4': 3, '5': 11, '6': '.pb.InsuranceProduct.MetadataEntry', '10': 'metadata'},
    {'1': 'form_fields', '3': 13, '4': 3, '5': 11, '6': '.pb.InsuranceProductFormField', '10': 'formFields'},
    {'1': 'is_active', '3': 14, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'purchase_route', '3': 15, '4': 1, '5': 9, '10': 'purchaseRoute'},
    {'1': 'provider_id', '3': 16, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'base_price', '3': 17, '4': 1, '5': 1, '10': 'basePrice'},
    {'1': 'how_it_works', '3': 18, '4': 1, '5': 9, '10': 'howItWorks'},
    {'1': 'full_benefits', '3': 19, '4': 1, '5': 9, '10': 'fullBenefits'},
    {'1': 'is_renewable', '3': 20, '4': 1, '5': 8, '10': 'isRenewable'},
    {'1': 'is_claimable', '3': 21, '4': 1, '5': 8, '10': 'isClaimable'},
  ],
  '3': [InsuranceProduct_MetadataEntry$json],
};

@$core.Deprecated('Use insuranceProductDescriptor instead')
const InsuranceProduct_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InsuranceProduct`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceProductDescriptor = $convert.base64Decode(
    'ChBJbnN1cmFuY2VQcm9kdWN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEi'
    'AKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIaCghjYXRlZ29yeRgEIAEoCVIIY2F0'
    'ZWdvcnkSIwoNcHJvdmlkZXJfbmFtZRgFIAEoCVIMcHJvdmlkZXJOYW1lEiMKDXByb3ZpZGVyX2'
    'xvZ28YBiABKAlSDHByb3ZpZGVyTG9nbxIfCgttaW5fcHJlbWl1bRgHIAEoAVIKbWluUHJlbWl1'
    'bRIfCgttYXhfcHJlbWl1bRgIIAEoAVIKbWF4UHJlbWl1bRIaCghjdXJyZW5jeRgJIAEoCVIIY3'
    'VycmVuY3kSGgoIYmVuZWZpdHMYCiADKAlSCGJlbmVmaXRzEhsKCXRlcm1zX3VybBgLIAEoCVII'
    'dGVybXNVcmwSPgoIbWV0YWRhdGEYDCADKAsyIi5wYi5JbnN1cmFuY2VQcm9kdWN0Lk1ldGFkYX'
    'RhRW50cnlSCG1ldGFkYXRhEj4KC2Zvcm1fZmllbGRzGA0gAygLMh0ucGIuSW5zdXJhbmNlUHJv'
    'ZHVjdEZvcm1GaWVsZFIKZm9ybUZpZWxkcxIbCglpc19hY3RpdmUYDiABKAhSCGlzQWN0aXZlEi'
    'UKDnB1cmNoYXNlX3JvdXRlGA8gASgJUg1wdXJjaGFzZVJvdXRlEh8KC3Byb3ZpZGVyX2lkGBAg'
    'ASgJUgpwcm92aWRlcklkEh0KCmJhc2VfcHJpY2UYESABKAFSCWJhc2VQcmljZRIgCgxob3dfaX'
    'Rfd29ya3MYEiABKAlSCmhvd0l0V29ya3MSIwoNZnVsbF9iZW5lZml0cxgTIAEoCVIMZnVsbEJl'
    'bmVmaXRzEiEKDGlzX3JlbmV3YWJsZRgUIAEoCFILaXNSZW5ld2FibGUSIQoMaXNfY2xhaW1hYm'
    'xlGBUgASgIUgtpc0NsYWltYWJsZRo7Cg1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5'
    'EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use insuranceCategoryDescriptor instead')
const InsuranceCategory$json = {
  '1': 'InsuranceCategory',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'icon', '3': 3, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'product_count', '3': 5, '4': 1, '5': 5, '10': 'productCount'},
  ],
};

/// Descriptor for `InsuranceCategory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceCategoryDescriptor = $convert.base64Decode(
    'ChFJbnN1cmFuY2VDYXRlZ29yeRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZR'
    'ISCgRpY29uGAMgASgJUgRpY29uEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIj'
    'Cg1wcm9kdWN0X2NvdW50GAUgASgFUgxwcm9kdWN0Q291bnQ=');

@$core.Deprecated('Use insuranceQuoteDescriptor instead')
const InsuranceQuote$json = {
  '1': 'InsuranceQuote',
  '2': [
    {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    {'1': 'product_id', '3': 2, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'premium', '3': 3, '4': 1, '5': 1, '10': 'premium'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'coverage_summary', '3': 5, '4': 1, '5': 9, '10': 'coverageSummary'},
    {'1': 'coverage_items', '3': 6, '4': 3, '5': 9, '10': 'coverageItems'},
    {'1': 'valid_until', '3': 7, '4': 1, '5': 9, '10': 'validUntil'},
    {'1': 'quote_details', '3': 8, '4': 3, '5': 11, '6': '.pb.InsuranceQuote.QuoteDetailsEntry', '10': 'quoteDetails'},
  ],
  '3': [InsuranceQuote_QuoteDetailsEntry$json],
};

@$core.Deprecated('Use insuranceQuoteDescriptor instead')
const InsuranceQuote_QuoteDetailsEntry$json = {
  '1': 'QuoteDetailsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InsuranceQuote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceQuoteDescriptor = $convert.base64Decode(
    'Cg5JbnN1cmFuY2VRdW90ZRIZCghxdW90ZV9pZBgBIAEoCVIHcXVvdGVJZBIdCgpwcm9kdWN0X2'
    'lkGAIgASgJUglwcm9kdWN0SWQSGAoHcHJlbWl1bRgDIAEoAVIHcHJlbWl1bRIaCghjdXJyZW5j'
    'eRgEIAEoCVIIY3VycmVuY3kSKQoQY292ZXJhZ2Vfc3VtbWFyeRgFIAEoCVIPY292ZXJhZ2VTdW'
    '1tYXJ5EiUKDmNvdmVyYWdlX2l0ZW1zGAYgAygJUg1jb3ZlcmFnZUl0ZW1zEh8KC3ZhbGlkX3Vu'
    'dGlsGAcgASgJUgp2YWxpZFVudGlsEkkKDXF1b3RlX2RldGFpbHMYCCADKAsyJC5wYi5JbnN1cm'
    'FuY2VRdW90ZS5RdW90ZURldGFpbHNFbnRyeVIMcXVvdGVEZXRhaWxzGj8KEVF1b3RlRGV0YWls'
    'c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use insurancePurchaseResultDescriptor instead')
const InsurancePurchaseResult$json = {
  '1': 'InsurancePurchaseResult',
  '2': [
    {'1': 'policy_id', '3': 1, '4': 1, '5': 9, '10': 'policyId'},
    {'1': 'policy_number', '3': 2, '4': 1, '5': 9, '10': 'policyNumber'},
    {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'provider_reference', '3': 5, '4': 1, '5': 9, '10': 'providerReference'},
    {'1': 'insurance', '3': 6, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `InsurancePurchaseResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePurchaseResultDescriptor = $convert.base64Decode(
    'ChdJbnN1cmFuY2VQdXJjaGFzZVJlc3VsdBIbCglwb2xpY3lfaWQYASABKAlSCHBvbGljeUlkEi'
    'MKDXBvbGljeV9udW1iZXIYAiABKAlSDHBvbGljeU51bWJlchIcCglyZWZlcmVuY2UYAyABKAlS'
    'CXJlZmVyZW5jZRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxItChJwcm92aWRlcl9yZWZlcmVuY2'
    'UYBSABKAlSEXByb3ZpZGVyUmVmZXJlbmNlEisKCWluc3VyYW5jZRgGIAEoCzINLnBiLkluc3Vy'
    'YW5jZVIJaW5zdXJhbmNl');

@$core.Deprecated('Use getInsuranceProductsRequestDescriptor instead')
const GetInsuranceProductsRequest$json = {
  '1': 'GetInsuranceProductsRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'locale', '3': 2, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInsuranceProductsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceProductsRequestDescriptor = $convert.base64Decode(
    'ChtHZXRJbnN1cmFuY2VQcm9kdWN0c1JlcXVlc3QSGgoIY2F0ZWdvcnkYASABKAlSCGNhdGVnb3'
    'J5EhYKBmxvY2FsZRgCIAEoCVIGbG9jYWxlEhIKBHBhZ2UYAyABKAVSBHBhZ2USFAoFbGltaXQY'
    'BCABKAVSBWxpbWl0');

@$core.Deprecated('Use getInsuranceProductsResponseDescriptor instead')
const GetInsuranceProductsResponse$json = {
  '1': 'GetInsuranceProductsResponse',
  '2': [
    {'1': 'products', '3': 1, '4': 3, '5': 11, '6': '.pb.InsuranceProduct', '10': 'products'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceProductsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceProductsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRJbnN1cmFuY2VQcm9kdWN0c1Jlc3BvbnNlEjAKCHByb2R1Y3RzGAEgAygLMhQucGIuSW'
    '5zdXJhbmNlUHJvZHVjdFIIcHJvZHVjdHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEhgKB3N1Y2Nl'
    'c3MYAyABKAhSB3N1Y2Nlc3MSEAoDbXNnGAQgASgJUgNtc2c=');

@$core.Deprecated('Use getInsuranceCategoriesRequestDescriptor instead')
const GetInsuranceCategoriesRequest$json = {
  '1': 'GetInsuranceCategoriesRequest',
  '2': [
    {'1': 'locale', '3': 1, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `GetInsuranceCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceCategoriesRequestDescriptor = $convert.base64Decode(
    'Ch1HZXRJbnN1cmFuY2VDYXRlZ29yaWVzUmVxdWVzdBIWCgZsb2NhbGUYASABKAlSBmxvY2FsZQ'
    '==');

@$core.Deprecated('Use getInsuranceCategoriesResponseDescriptor instead')
const GetInsuranceCategoriesResponse$json = {
  '1': 'GetInsuranceCategoriesResponse',
  '2': [
    {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.pb.InsuranceCategory', '10': 'categories'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceCategoriesResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRJbnN1cmFuY2VDYXRlZ29yaWVzUmVzcG9uc2USNQoKY2F0ZWdvcmllcxgBIAMoCzIVLn'
    'BiLkluc3VyYW5jZUNhdGVnb3J5UgpjYXRlZ29yaWVzEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nl'
    'c3MSEAoDbXNnGAMgASgJUgNtc2c=');

@$core.Deprecated('Use getInsuranceQuoteRequestDescriptor instead')
const GetInsuranceQuoteRequest$json = {
  '1': 'GetInsuranceQuoteRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'form_data', '3': 2, '4': 3, '5': 11, '6': '.pb.GetInsuranceQuoteRequest.FormDataEntry', '10': 'formData'},
    {'1': 'locale', '3': 3, '4': 1, '5': 9, '10': 'locale'},
  ],
  '3': [GetInsuranceQuoteRequest_FormDataEntry$json],
};

@$core.Deprecated('Use getInsuranceQuoteRequestDescriptor instead')
const GetInsuranceQuoteRequest_FormDataEntry$json = {
  '1': 'FormDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInsuranceQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceQuoteRequestDescriptor = $convert.base64Decode(
    'ChhHZXRJbnN1cmFuY2VRdW90ZVJlcXVlc3QSHQoKcHJvZHVjdF9pZBgBIAEoCVIJcHJvZHVjdE'
    'lkEkcKCWZvcm1fZGF0YRgCIAMoCzIqLnBiLkdldEluc3VyYW5jZVF1b3RlUmVxdWVzdC5Gb3Jt'
    'RGF0YUVudHJ5Ughmb3JtRGF0YRIWCgZsb2NhbGUYAyABKAlSBmxvY2FsZRo7Cg1Gb3JtRGF0YU'
    'VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getInsuranceQuoteResponseDescriptor instead')
const GetInsuranceQuoteResponse$json = {
  '1': 'GetInsuranceQuoteResponse',
  '2': [
    {'1': 'quote', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceQuote', '10': 'quote'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceQuoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceQuoteResponseDescriptor = $convert.base64Decode(
    'ChlHZXRJbnN1cmFuY2VRdW90ZVJlc3BvbnNlEigKBXF1b3RlGAEgASgLMhIucGIuSW5zdXJhbm'
    'NlUXVvdGVSBXF1b3RlEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJUgNt'
    'c2c=');

@$core.Deprecated('Use purchaseInsuranceRequestDescriptor instead')
const PurchaseInsuranceRequest$json = {
  '1': 'PurchaseInsuranceRequest',
  '2': [
    {'1': 'quote_id', '3': 1, '4': 1, '5': 9, '10': 'quoteId'},
    {'1': 'product_id', '3': 2, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'transaction_pin', '3': 4, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'form_data', '3': 6, '4': 3, '5': 11, '6': '.pb.PurchaseInsuranceRequest.FormDataEntry', '10': 'formData'},
    {'1': 'locale', '3': 7, '4': 1, '5': 9, '10': 'locale'},
  ],
  '3': [PurchaseInsuranceRequest_FormDataEntry$json],
};

@$core.Deprecated('Use purchaseInsuranceRequestDescriptor instead')
const PurchaseInsuranceRequest_FormDataEntry$json = {
  '1': 'FormDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `PurchaseInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseInsuranceRequestDescriptor = $convert.base64Decode(
    'ChhQdXJjaGFzZUluc3VyYW5jZVJlcXVlc3QSGQoIcXVvdGVfaWQYASABKAlSB3F1b3RlSWQSHQ'
    'oKcHJvZHVjdF9pZBgCIAEoCVIJcHJvZHVjdElkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291'
    'bnRJZBInCg90cmFuc2FjdGlvbl9waW4YBCABKAlSDnRyYW5zYWN0aW9uUGluEicKD2lkZW1wb3'
    'RlbmN5X2tleRgFIAEoCVIOaWRlbXBvdGVuY3lLZXkSRwoJZm9ybV9kYXRhGAYgAygLMioucGIu'
    'UHVyY2hhc2VJbnN1cmFuY2VSZXF1ZXN0LkZvcm1EYXRhRW50cnlSCGZvcm1EYXRhEhYKBmxvY2'
    'FsZRgHIAEoCVIGbG9jYWxlGjsKDUZvcm1EYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoF'
    'dmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use purchaseInsuranceResponseDescriptor instead')
const PurchaseInsuranceResponse$json = {
  '1': 'PurchaseInsuranceResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePurchaseResult', '10': 'result'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `PurchaseInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseInsuranceResponseDescriptor = $convert.base64Decode(
    'ChlQdXJjaGFzZUluc3VyYW5jZVJlc3BvbnNlEjMKBnJlc3VsdBgBIAEoCzIbLnBiLkluc3VyYW'
    '5jZVB1cmNoYXNlUmVzdWx0UgZyZXN1bHQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIQCgNt'
    'c2cYAyABKAlSA21zZw==');

@$core.Deprecated('Use getInsurancePurchaseStatusRequestDescriptor instead')
const GetInsurancePurchaseStatusRequest$json = {
  '1': 'GetInsurancePurchaseStatusRequest',
  '2': [
    {'1': 'reference', '3': 1, '4': 1, '5': 9, '10': 'reference'},
  ],
};

/// Descriptor for `GetInsurancePurchaseStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePurchaseStatusRequestDescriptor = $convert.base64Decode(
    'CiFHZXRJbnN1cmFuY2VQdXJjaGFzZVN0YXR1c1JlcXVlc3QSHAoJcmVmZXJlbmNlGAEgASgJUg'
    'lyZWZlcmVuY2U=');

@$core.Deprecated('Use getInsurancePurchaseStatusResponseDescriptor instead')
const GetInsurancePurchaseStatusResponse$json = {
  '1': 'GetInsurancePurchaseStatusResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePurchaseResult', '10': 'result'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsurancePurchaseStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePurchaseStatusResponseDescriptor = $convert.base64Decode(
    'CiJHZXRJbnN1cmFuY2VQdXJjaGFzZVN0YXR1c1Jlc3BvbnNlEjMKBnJlc3VsdBgBIAEoCzIbLn'
    'BiLkluc3VyYW5jZVB1cmNoYXNlUmVzdWx0UgZyZXN1bHQSGAoHc3VjY2VzcxgCIAEoCFIHc3Vj'
    'Y2VzcxIQCgNtc2cYAyABKAlSA21zZw==');

@$core.Deprecated('Use uploadInsuranceDocumentRequestDescriptor instead')
const UploadInsuranceDocumentRequest$json = {
  '1': 'UploadInsuranceDocumentRequest',
  '2': [
    {'1': 'file_data', '3': 1, '4': 1, '5': 12, '10': 'fileData'},
    {'1': 'filename', '3': 2, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'document_type', '3': 3, '4': 1, '5': 9, '10': 'documentType'},
  ],
};

/// Descriptor for `UploadInsuranceDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadInsuranceDocumentRequestDescriptor = $convert.base64Decode(
    'Ch5VcGxvYWRJbnN1cmFuY2VEb2N1bWVudFJlcXVlc3QSGwoJZmlsZV9kYXRhGAEgASgMUghmaW'
    'xlRGF0YRIaCghmaWxlbmFtZRgCIAEoCVIIZmlsZW5hbWUSIwoNZG9jdW1lbnRfdHlwZRgDIAEo'
    'CVIMZG9jdW1lbnRUeXBl');

@$core.Deprecated('Use uploadInsuranceDocumentResponseDescriptor instead')
const UploadInsuranceDocumentResponse$json = {
  '1': 'UploadInsuranceDocumentResponse',
  '2': [
    {'1': 'upload_id', '3': 1, '4': 1, '5': 9, '10': 'uploadId'},
    {'1': 'file_url', '3': 2, '4': 1, '5': 9, '10': 'fileUrl'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `UploadInsuranceDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadInsuranceDocumentResponseDescriptor = $convert.base64Decode(
    'Ch9VcGxvYWRJbnN1cmFuY2VEb2N1bWVudFJlc3BvbnNlEhsKCXVwbG9hZF9pZBgBIAEoCVIIdX'
    'Bsb2FkSWQSGQoIZmlsZV91cmwYAiABKAlSB2ZpbGVVcmwSGAoHc3VjY2VzcxgDIAEoCFIHc3Vj'
    'Y2VzcxIQCgNtc2cYBCABKAlSA21zZw==');

@$core.Deprecated('Use getInsuranceAuxiliaryDataRequestDescriptor instead')
const GetInsuranceAuxiliaryDataRequest$json = {
  '1': 'GetInsuranceAuxiliaryDataRequest',
  '2': [
    {'1': 'utility_id', '3': 1, '4': 1, '5': 9, '10': 'utilityId'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `GetInsuranceAuxiliaryDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceAuxiliaryDataRequestDescriptor = $convert.base64Decode(
    'CiBHZXRJbnN1cmFuY2VBdXhpbGlhcnlEYXRhUmVxdWVzdBIdCgp1dGlsaXR5X2lkGAEgASgJUg'
    'l1dGlsaXR5SWQSFAoFcXVlcnkYAiABKAlSBXF1ZXJ5');

@$core.Deprecated('Use getInsuranceAuxiliaryDataResponseDescriptor instead')
const GetInsuranceAuxiliaryDataResponse$json = {
  '1': 'GetInsuranceAuxiliaryDataResponse',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.pb.InsuranceAuxiliaryItem', '10': 'items'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceAuxiliaryDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceAuxiliaryDataResponseDescriptor = $convert.base64Decode(
    'CiFHZXRJbnN1cmFuY2VBdXhpbGlhcnlEYXRhUmVzcG9uc2USMAoFaXRlbXMYASADKAsyGi5wYi'
    '5JbnN1cmFuY2VBdXhpbGlhcnlJdGVtUgVpdGVtcxIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNz'
    'EhAKA21zZxgDIAEoCVIDbXNn');

@$core.Deprecated('Use insuranceAuxiliaryItemDescriptor instead')
const InsuranceAuxiliaryItem$json = {
  '1': 'InsuranceAuxiliaryItem',
  '2': [
    {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `InsuranceAuxiliaryItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceAuxiliaryItemDescriptor = $convert.base64Decode(
    'ChZJbnN1cmFuY2VBdXhpbGlhcnlJdGVtEhQKBWxhYmVsGAEgASgJUgVsYWJlbBIUCgV2YWx1ZR'
    'gCIAEoCVIFdmFsdWU=');

@$core.Deprecated('Use insuranceDescriptor instead')
const Insurance$json = {
  '1': 'Insurance',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'policy_number', '3': 2, '4': 1, '5': 9, '10': 'policyNumber'},
    {'1': 'policy_holder_name', '3': 3, '4': 1, '5': 9, '10': 'policyHolderName'},
    {'1': 'policy_holder_email', '3': 4, '4': 1, '5': 9, '10': 'policyHolderEmail'},
    {'1': 'policy_holder_phone', '3': 5, '4': 1, '5': 9, '10': 'policyHolderPhone'},
    {'1': 'type', '3': 6, '4': 1, '5': 9, '10': 'type'},
    {'1': 'provider', '3': 7, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'provider_logo', '3': 8, '4': 1, '5': 9, '10': 'providerLogo'},
    {'1': 'premium_amount', '3': 9, '4': 1, '5': 1, '10': 'premiumAmount'},
    {'1': 'coverage_amount', '3': 10, '4': 1, '5': 1, '10': 'coverageAmount'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'start_date', '3': 12, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 13, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'next_payment_date', '3': 14, '4': 1, '5': 9, '10': 'nextPaymentDate'},
    {'1': 'status', '3': 15, '4': 1, '5': 9, '10': 'status'},
    {'1': 'beneficiaries', '3': 16, '4': 3, '5': 9, '10': 'beneficiaries'},
    {'1': 'coverage_details', '3': 17, '4': 3, '5': 11, '6': '.pb.Insurance.CoverageDetailsEntry', '10': 'coverageDetails'},
    {'1': 'description', '3': 18, '4': 1, '5': 9, '10': 'description'},
    {'1': 'user_id', '3': 19, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': [Insurance_CoverageDetailsEntry$json],
};

@$core.Deprecated('Use insuranceDescriptor instead')
const Insurance_CoverageDetailsEntry$json = {
  '1': 'CoverageDetailsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Insurance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceDescriptor = $convert.base64Decode(
    'CglJbnN1cmFuY2USDgoCaWQYASABKAlSAmlkEiMKDXBvbGljeV9udW1iZXIYAiABKAlSDHBvbG'
    'ljeU51bWJlchIsChJwb2xpY3lfaG9sZGVyX25hbWUYAyABKAlSEHBvbGljeUhvbGRlck5hbWUS'
    'LgoTcG9saWN5X2hvbGRlcl9lbWFpbBgEIAEoCVIRcG9saWN5SG9sZGVyRW1haWwSLgoTcG9saW'
    'N5X2hvbGRlcl9waG9uZRgFIAEoCVIRcG9saWN5SG9sZGVyUGhvbmUSEgoEdHlwZRgGIAEoCVIE'
    'dHlwZRIaCghwcm92aWRlchgHIAEoCVIIcHJvdmlkZXISIwoNcHJvdmlkZXJfbG9nbxgIIAEoCV'
    'IMcHJvdmlkZXJMb2dvEiUKDnByZW1pdW1fYW1vdW50GAkgASgBUg1wcmVtaXVtQW1vdW50EicK'
    'D2NvdmVyYWdlX2Ftb3VudBgKIAEoAVIOY292ZXJhZ2VBbW91bnQSGgoIY3VycmVuY3kYCyABKA'
    'lSCGN1cnJlbmN5Eh0KCnN0YXJ0X2RhdGUYDCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgN'
    'IAEoCVIHZW5kRGF0ZRIqChFuZXh0X3BheW1lbnRfZGF0ZRgOIAEoCVIPbmV4dFBheW1lbnREYX'
    'RlEhYKBnN0YXR1cxgPIAEoCVIGc3RhdHVzEiQKDWJlbmVmaWNpYXJpZXMYECADKAlSDWJlbmVm'
    'aWNpYXJpZXMSTQoQY292ZXJhZ2VfZGV0YWlscxgRIAMoCzIiLnBiLkluc3VyYW5jZS5Db3Zlcm'
    'FnZURldGFpbHNFbnRyeVIPY292ZXJhZ2VEZXRhaWxzEiAKC2Rlc2NyaXB0aW9uGBIgASgJUgtk'
    'ZXNjcmlwdGlvbhIXCgd1c2VyX2lkGBMgASgJUgZ1c2VySWQSHQoKY3JlYXRlZF9hdBgUIAEoCV'
    'IJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFSABKAlSCXVwZGF0ZWRBdBpCChRDb3ZlcmFnZURl'
    'dGFpbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use insurancePaymentDescriptor instead')
const InsurancePayment$json = {
  '1': 'InsurancePayment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'insurance_id', '3': 2, '4': 1, '5': 9, '10': 'insuranceId'},
    {'1': 'policy_number', '3': 3, '4': 1, '5': 9, '10': 'policyNumber'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payment_method', '3': 6, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    {'1': 'transaction_id', '3': 8, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'reference_number', '3': 9, '4': 1, '5': 9, '10': 'referenceNumber'},
    {'1': 'payment_date', '3': 10, '4': 1, '5': 9, '10': 'paymentDate'},
    {'1': 'due_date', '3': 11, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'processed_at', '3': 12, '4': 1, '5': 9, '10': 'processedAt'},
    {'1': 'payment_details', '3': 13, '4': 3, '5': 11, '6': '.pb.InsurancePayment.PaymentDetailsEntry', '10': 'paymentDetails'},
    {'1': 'failure_reason', '3': 14, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'receipt_url', '3': 15, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'user_id', '3': 16, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': [InsurancePayment_PaymentDetailsEntry$json],
};

@$core.Deprecated('Use insurancePaymentDescriptor instead')
const InsurancePayment_PaymentDetailsEntry$json = {
  '1': 'PaymentDetailsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InsurancePayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePaymentDescriptor = $convert.base64Decode(
    'ChBJbnN1cmFuY2VQYXltZW50Eg4KAmlkGAEgASgJUgJpZBIhCgxpbnN1cmFuY2VfaWQYAiABKA'
    'lSC2luc3VyYW5jZUlkEiMKDXBvbGljeV9udW1iZXIYAyABKAlSDHBvbGljeU51bWJlchIWCgZh'
    'bW91bnQYBCABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSJQoOcGF5bW'
    'VudF9tZXRob2QYBiABKAlSDXBheW1lbnRNZXRob2QSFgoGc3RhdHVzGAcgASgJUgZzdGF0dXMS'
    'JQoOdHJhbnNhY3Rpb25faWQYCCABKAlSDXRyYW5zYWN0aW9uSWQSKQoQcmVmZXJlbmNlX251bW'
    'JlchgJIAEoCVIPcmVmZXJlbmNlTnVtYmVyEiEKDHBheW1lbnRfZGF0ZRgKIAEoCVILcGF5bWVu'
    'dERhdGUSGQoIZHVlX2RhdGUYCyABKAlSB2R1ZURhdGUSIQoMcHJvY2Vzc2VkX2F0GAwgASgJUg'
    'twcm9jZXNzZWRBdBJRCg9wYXltZW50X2RldGFpbHMYDSADKAsyKC5wYi5JbnN1cmFuY2VQYXlt'
    'ZW50LlBheW1lbnREZXRhaWxzRW50cnlSDnBheW1lbnREZXRhaWxzEiUKDmZhaWx1cmVfcmVhc2'
    '9uGA4gASgJUg1mYWlsdXJlUmVhc29uEh8KC3JlY2VpcHRfdXJsGA8gASgJUgpyZWNlaXB0VXJs'
    'EhcKB3VzZXJfaWQYECABKAlSBnVzZXJJZBIdCgpjcmVhdGVkX2F0GBEgASgJUgljcmVhdGVkQX'
    'QSHQoKdXBkYXRlZF9hdBgSIAEoCVIJdXBkYXRlZEF0GkEKE1BheW1lbnREZXRhaWxzRW50cnkS'
    'EAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use insuranceClaimDescriptor instead')
const InsuranceClaim$json = {
  '1': 'InsuranceClaim',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'claim_number', '3': 2, '4': 1, '5': 9, '10': 'claimNumber'},
    {'1': 'insurance_id', '3': 3, '4': 1, '5': 9, '10': 'insuranceId'},
    {'1': 'policy_number', '3': 4, '4': 1, '5': 9, '10': 'policyNumber'},
    {'1': 'type', '3': 5, '4': 1, '5': 9, '10': 'type'},
    {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    {'1': 'title', '3': 7, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    {'1': 'claim_amount', '3': 9, '4': 1, '5': 1, '10': 'claimAmount'},
    {'1': 'approved_amount', '3': 10, '4': 1, '5': 1, '10': 'approvedAmount'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'incident_date', '3': 12, '4': 1, '5': 9, '10': 'incidentDate'},
    {'1': 'incident_location', '3': 13, '4': 1, '5': 9, '10': 'incidentLocation'},
    {'1': 'attachments', '3': 14, '4': 3, '5': 9, '10': 'attachments'},
    {'1': 'documents', '3': 15, '4': 3, '5': 9, '10': 'documents'},
    {'1': 'additional_info', '3': 16, '4': 3, '5': 11, '6': '.pb.InsuranceClaim.AdditionalInfoEntry', '10': 'additionalInfo'},
    {'1': 'rejection_reason', '3': 17, '4': 1, '5': 9, '10': 'rejectionReason'},
    {'1': 'settlement_date', '3': 18, '4': 1, '5': 9, '10': 'settlementDate'},
    {'1': 'settlement_details', '3': 19, '4': 1, '5': 9, '10': 'settlementDetails'},
    {'1': 'user_id', '3': 20, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'created_at', '3': 21, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 22, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': [InsuranceClaim_AdditionalInfoEntry$json],
};

@$core.Deprecated('Use insuranceClaimDescriptor instead')
const InsuranceClaim_AdditionalInfoEntry$json = {
  '1': 'AdditionalInfoEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InsuranceClaim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceClaimDescriptor = $convert.base64Decode(
    'Cg5JbnN1cmFuY2VDbGFpbRIOCgJpZBgBIAEoCVICaWQSIQoMY2xhaW1fbnVtYmVyGAIgASgJUg'
    'tjbGFpbU51bWJlchIhCgxpbnN1cmFuY2VfaWQYAyABKAlSC2luc3VyYW5jZUlkEiMKDXBvbGlj'
    'eV9udW1iZXIYBCABKAlSDHBvbGljeU51bWJlchISCgR0eXBlGAUgASgJUgR0eXBlEhYKBnN0YX'
    'R1cxgGIAEoCVIGc3RhdHVzEhQKBXRpdGxlGAcgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgI'
    'IAEoCVILZGVzY3JpcHRpb24SIQoMY2xhaW1fYW1vdW50GAkgASgBUgtjbGFpbUFtb3VudBInCg'
    '9hcHByb3ZlZF9hbW91bnQYCiABKAFSDmFwcHJvdmVkQW1vdW50EhoKCGN1cnJlbmN5GAsgASgJ'
    'UghjdXJyZW5jeRIjCg1pbmNpZGVudF9kYXRlGAwgASgJUgxpbmNpZGVudERhdGUSKwoRaW5jaW'
    'RlbnRfbG9jYXRpb24YDSABKAlSEGluY2lkZW50TG9jYXRpb24SIAoLYXR0YWNobWVudHMYDiAD'
    'KAlSC2F0dGFjaG1lbnRzEhwKCWRvY3VtZW50cxgPIAMoCVIJZG9jdW1lbnRzEk8KD2FkZGl0aW'
    '9uYWxfaW5mbxgQIAMoCzImLnBiLkluc3VyYW5jZUNsYWltLkFkZGl0aW9uYWxJbmZvRW50cnlS'
    'DmFkZGl0aW9uYWxJbmZvEikKEHJlamVjdGlvbl9yZWFzb24YESABKAlSD3JlamVjdGlvblJlYX'
    'NvbhInCg9zZXR0bGVtZW50X2RhdGUYEiABKAlSDnNldHRsZW1lbnREYXRlEi0KEnNldHRsZW1l'
    'bnRfZGV0YWlscxgTIAEoCVIRc2V0dGxlbWVudERldGFpbHMSFwoHdXNlcl9pZBgUIAEoCVIGdX'
    'NlcklkEh0KCmNyZWF0ZWRfYXQYFSABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GBYgASgJ'
    'Ugl1cGRhdGVkQXQaQQoTQWRkaXRpb25hbEluZm9FbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCg'
    'V2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

