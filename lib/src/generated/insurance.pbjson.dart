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
    {'1': 'insurances', '3': 1, '4': 3, '5': 11, '6': '.insurance.Insurance', '10': 'insurances'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.insurance.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserInsurancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsurancesResponseDescriptor = $convert.base64Decode(
    'ChlHZXRVc2VySW5zdXJhbmNlc1Jlc3BvbnNlEjQKCmluc3VyYW5jZXMYASADKAsyFC5pbnN1cm'
    'FuY2UuSW5zdXJhbmNlUgppbnN1cmFuY2VzEkIKCnBhZ2luYXRpb24YAiABKAsyIi5pbnN1cmFu'
    'Y2UuSW5zdXJhbmNlUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24SGAoHc3VjY2VzcxgDIAEoCF'
    'IHc3VjY2VzcxIQCgNtc2cYBCABKAlSA21zZw==');

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
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.insurance.Insurance', '10': 'insurance'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceByIdResponseDescriptor = $convert.base64Decode(
    'ChhHZXRJbnN1cmFuY2VCeUlkUmVzcG9uc2USMgoJaW5zdXJhbmNlGAEgASgLMhQuaW5zdXJhbm'
    'NlLkluc3VyYW5jZVIJaW5zdXJhbmNlEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNn'
    'GAMgASgJUgNtc2c=');

@$core.Deprecated('Use createInsuranceRequestDescriptor instead')
const CreateInsuranceRequest$json = {
  '1': 'CreateInsuranceRequest',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.insurance.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `CreateInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInsuranceRequestDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVJbnN1cmFuY2VSZXF1ZXN0EjIKCWluc3VyYW5jZRgBIAEoCzIULmluc3VyYW5jZS'
    '5JbnN1cmFuY2VSCWluc3VyYW5jZQ==');

@$core.Deprecated('Use createInsuranceResponseDescriptor instead')
const CreateInsuranceResponse$json = {
  '1': 'CreateInsuranceResponse',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.insurance.Insurance', '10': 'insurance'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreateInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInsuranceResponseDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVJbnN1cmFuY2VSZXNwb25zZRIyCglpbnN1cmFuY2UYASABKAsyFC5pbnN1cmFuY2'
    'UuSW5zdXJhbmNlUglpbnN1cmFuY2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIQCgNtc2cY'
    'AyABKAlSA21zZw==');

@$core.Deprecated('Use updateInsuranceRequestDescriptor instead')
const UpdateInsuranceRequest$json = {
  '1': 'UpdateInsuranceRequest',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.insurance.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `UpdateInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsuranceRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVJbnN1cmFuY2VSZXF1ZXN0EjIKCWluc3VyYW5jZRgBIAEoCzIULmluc3VyYW5jZS'
    '5JbnN1cmFuY2VSCWluc3VyYW5jZQ==');

@$core.Deprecated('Use updateInsuranceResponseDescriptor instead')
const UpdateInsuranceResponse$json = {
  '1': 'UpdateInsuranceResponse',
  '2': [
    {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.insurance.Insurance', '10': 'insurance'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `UpdateInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsuranceResponseDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVJbnN1cmFuY2VSZXNwb25zZRIyCglpbnN1cmFuY2UYASABKAsyFC5pbnN1cmFuY2'
    'UuSW5zdXJhbmNlUglpbnN1cmFuY2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIQCgNtc2cY'
    'AyABKAlSA21zZw==');

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
    {'1': 'insurances', '3': 1, '4': 3, '5': 11, '6': '.insurance.Insurance', '10': 'insurances'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.insurance.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `SearchInsurancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchInsurancesResponseDescriptor = $convert.base64Decode(
    'ChhTZWFyY2hJbnN1cmFuY2VzUmVzcG9uc2USNAoKaW5zdXJhbmNlcxgBIAMoCzIULmluc3VyYW'
    '5jZS5JbnN1cmFuY2VSCmluc3VyYW5jZXMSQgoKcGFnaW5hdGlvbhgCIAEoCzIiLmluc3VyYW5j'
    'ZS5JbnN1cmFuY2VQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbhIYCgdzdWNjZXNzGAMgASgIUg'
    'dzdWNjZXNzEhAKA21zZxgEIAEoCVIDbXNn');

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
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.insurance.InsurancePayment', '10': 'payments'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.insurance.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsurancePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRJbnN1cmFuY2VQYXltZW50c1Jlc3BvbnNlEjcKCHBheW1lbnRzGAEgAygLMhsuaW5zdX'
    'JhbmNlLkluc3VyYW5jZVBheW1lbnRSCHBheW1lbnRzEkIKCnBhZ2luYXRpb24YAiABKAsyIi5p'
    'bnN1cmFuY2UuSW5zdXJhbmNlUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24SGAoHc3VjY2Vzcx'
    'gDIAEoCFIHc3VjY2VzcxIQCgNtc2cYBCABKAlSA21zZw==');

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
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.insurance.InsurancePayment', '10': 'payments'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.insurance.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPaymentsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyUGF5bWVudHNSZXNwb25zZRI3CghwYXltZW50cxgBIAMoCzIbLmluc3VyYW5jZS'
    '5JbnN1cmFuY2VQYXltZW50UghwYXltZW50cxJCCgpwYWdpbmF0aW9uGAIgASgLMiIuaW5zdXJh'
    'bmNlLkluc3VyYW5jZVBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9uEhgKB3N1Y2Nlc3MYAyABKA'
    'hSB3N1Y2Nlc3MSEAoDbXNnGAQgASgJUgNtc2c=');

@$core.Deprecated('Use createPaymentRequestDescriptor instead')
const CreatePaymentRequest$json = {
  '1': 'CreatePaymentRequest',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsurancePayment', '10': 'payment'},
  ],
};

/// Descriptor for `CreatePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVQYXltZW50UmVxdWVzdBI1CgdwYXltZW50GAEgASgLMhsuaW5zdXJhbmNlLkluc3'
    'VyYW5jZVBheW1lbnRSB3BheW1lbnQ=');

@$core.Deprecated('Use createPaymentResponseDescriptor instead')
const CreatePaymentResponse$json = {
  '1': 'CreatePaymentResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsurancePayment', '10': 'payment'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreatePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentResponseDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVQYXltZW50UmVzcG9uc2USNQoHcGF5bWVudBgBIAEoCzIbLmluc3VyYW5jZS5Jbn'
    'N1cmFuY2VQYXltZW50UgdwYXltZW50EhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNn'
    'GAMgASgJUgNtc2c=');

@$core.Deprecated('Use processPaymentRequestDescriptor instead')
const ProcessPaymentRequest$json = {
  '1': 'ProcessPaymentRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'payment_method', '3': 2, '4': 1, '5': 9, '10': 'paymentMethod'},
    {'1': 'payment_details', '3': 3, '4': 3, '5': 11, '6': '.insurance.ProcessPaymentRequest.PaymentDetailsEntry', '10': 'paymentDetails'},
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
    'UKDnBheW1lbnRfbWV0aG9kGAIgASgJUg1wYXltZW50TWV0aG9kEl0KD3BheW1lbnRfZGV0YWls'
    'cxgDIAMoCzI0Lmluc3VyYW5jZS5Qcm9jZXNzUGF5bWVudFJlcXVlc3QuUGF5bWVudERldGFpbH'
    'NFbnRyeVIOcGF5bWVudERldGFpbHMaQQoTUGF5bWVudERldGFpbHNFbnRyeRIQCgNrZXkYASAB'
    'KAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use processPaymentResponseDescriptor instead')
const ProcessPaymentResponse$json = {
  '1': 'ProcessPaymentResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsurancePayment', '10': 'payment'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'reference_number', '3': 3, '4': 1, '5': 9, '10': 'referenceNumber'},
    {'1': 'receipt_url', '3': 4, '4': 1, '5': 9, '10': 'receiptUrl'},
    {'1': 'success', '3': 5, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 6, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `ProcessPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPaymentResponseDescriptor = $convert.base64Decode(
    'ChZQcm9jZXNzUGF5bWVudFJlc3BvbnNlEjUKB3BheW1lbnQYASABKAsyGy5pbnN1cmFuY2UuSW'
    '5zdXJhbmNlUGF5bWVudFIHcGF5bWVudBIlCg50cmFuc2FjdGlvbl9pZBgCIAEoCVINdHJhbnNh'
    'Y3Rpb25JZBIpChByZWZlcmVuY2VfbnVtYmVyGAMgASgJUg9yZWZlcmVuY2VOdW1iZXISHwoLcm'
    'VjZWlwdF91cmwYBCABKAlSCnJlY2VpcHRVcmwSGAoHc3VjY2VzcxgFIAEoCFIHc3VjY2VzcxIQ'
    'CgNtc2cYBiABKAlSA21zZw==');

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
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsurancePayment', '10': 'payment'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetPaymentByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentByIdResponseDescriptor = $convert.base64Decode(
    'ChZHZXRQYXltZW50QnlJZFJlc3BvbnNlEjUKB3BheW1lbnQYASABKAsyGy5pbnN1cmFuY2UuSW'
    '5zdXJhbmNlUGF5bWVudFIHcGF5bWVudBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21z'
    'ZxgDIAEoCVIDbXNn');

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
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.insurance.InsurancePayment', '10': 'payments'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetOverduePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverduePaymentsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRPdmVyZHVlUGF5bWVudHNSZXNwb25zZRI3CghwYXltZW50cxgBIAMoCzIbLmluc3VyYW'
    '5jZS5JbnN1cmFuY2VQYXltZW50UghwYXltZW50cxIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNz'
    'EhAKA21zZxgDIAEoCVIDbXNn');

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
    {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.insurance.InsuranceClaim', '10': 'claims'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.insurance.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimsResponseDescriptor = $convert.base64Decode(
    'ChpHZXRJbnN1cmFuY2VDbGFpbXNSZXNwb25zZRIxCgZjbGFpbXMYASADKAsyGS5pbnN1cmFuY2'
    'UuSW5zdXJhbmNlQ2xhaW1SBmNsYWltcxJCCgpwYWdpbmF0aW9uGAIgASgLMiIuaW5zdXJhbmNl'
    'Lkluc3VyYW5jZVBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9uEhgKB3N1Y2Nlc3MYAyABKAhSB3'
    'N1Y2Nlc3MSEAoDbXNnGAQgASgJUgNtc2c=');

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
    {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.insurance.InsuranceClaim', '10': 'claims'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.insurance.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserClaimsResponseDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyQ2xhaW1zUmVzcG9uc2USMQoGY2xhaW1zGAEgAygLMhkuaW5zdXJhbmNlLkluc3'
    'VyYW5jZUNsYWltUgZjbGFpbXMSQgoKcGFnaW5hdGlvbhgCIAEoCzIiLmluc3VyYW5jZS5JbnN1'
    'cmFuY2VQYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbhIYCgdzdWNjZXNzGAMgASgIUgdzdWNjZX'
    'NzEhAKA21zZxgEIAEoCVIDbXNn');

@$core.Deprecated('Use createClaimRequestDescriptor instead')
const CreateClaimRequest$json = {
  '1': 'CreateClaimRequest',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsuranceClaim', '10': 'claim'},
  ],
};

/// Descriptor for `CreateClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createClaimRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVDbGFpbVJlcXVlc3QSLwoFY2xhaW0YASABKAsyGS5pbnN1cmFuY2UuSW5zdXJhbm'
    'NlQ2xhaW1SBWNsYWlt');

@$core.Deprecated('Use createClaimResponseDescriptor instead')
const CreateClaimResponse$json = {
  '1': 'CreateClaimResponse',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsuranceClaim', '10': 'claim'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreateClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createClaimResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVDbGFpbVJlc3BvbnNlEi8KBWNsYWltGAEgASgLMhkuaW5zdXJhbmNlLkluc3VyYW'
    '5jZUNsYWltUgVjbGFpbRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVID'
    'bXNn');

@$core.Deprecated('Use updateClaimRequestDescriptor instead')
const UpdateClaimRequest$json = {
  '1': 'UpdateClaimRequest',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsuranceClaim', '10': 'claim'},
  ],
};

/// Descriptor for `UpdateClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateClaimRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVDbGFpbVJlcXVlc3QSLwoFY2xhaW0YASABKAsyGS5pbnN1cmFuY2UuSW5zdXJhbm'
    'NlQ2xhaW1SBWNsYWlt');

@$core.Deprecated('Use updateClaimResponseDescriptor instead')
const UpdateClaimResponse$json = {
  '1': 'UpdateClaimResponse',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsuranceClaim', '10': 'claim'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `UpdateClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateClaimResponseDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVDbGFpbVJlc3BvbnNlEi8KBWNsYWltGAEgASgLMhkuaW5zdXJhbmNlLkluc3VyYW'
    '5jZUNsYWltUgVjbGFpbRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVID'
    'bXNn');

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
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.insurance.InsuranceClaim', '10': 'claim'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetClaimByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClaimByIdResponseDescriptor = $convert.base64Decode(
    'ChRHZXRDbGFpbUJ5SWRSZXNwb25zZRIvCgVjbGFpbRgBIAEoCzIZLmluc3VyYW5jZS5JbnN1cm'
    'FuY2VDbGFpbVIFY2xhaW0SGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIQCgNtc2cYAyABKAlS'
    'A21zZw==');

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
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.insurance.InsurancePaginationInfo', '10': 'pagination'},
    {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserReceiptsResponseDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyUmVjZWlwdHNSZXNwb25zZRIhCgxyZWNlaXB0X3VybHMYASADKAlSC3JlY2VpcH'
    'RVcmxzEkIKCnBhZ2luYXRpb24YAiABKAsyIi5pbnN1cmFuY2UuSW5zdXJhbmNlUGFnaW5hdGlv'
    'bkluZm9SCnBhZ2luYXRpb24SGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2VzcxIQCgNtc2cYBCABKA'
    'lSA21zZw==');

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
    {'1': 'policies_by_type', '3': 6, '4': 3, '5': 11, '6': '.insurance.GetInsuranceStatisticsResponse.PoliciesByTypeEntry', '10': 'policiesByType'},
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
    'dW1fYW1vdW50GAUgASgBUhJ0b3RhbFByZW1pdW1BbW91bnQSZwoQcG9saWNpZXNfYnlfdHlwZR'
    'gGIAMoCzI9Lmluc3VyYW5jZS5HZXRJbnN1cmFuY2VTdGF0aXN0aWNzUmVzcG9uc2UuUG9saWNp'
    'ZXNCeVR5cGVFbnRyeVIOcG9saWNpZXNCeVR5cGUSGAoHc3VjY2VzcxgHIAEoCFIHc3VjY2Vzcx'
    'IQCgNtc2cYCCABKAlSA21zZxpBChNQb2xpY2llc0J5VHlwZUVudHJ5EhAKA2tleRgBIAEoCVID'
    'a2V5EhQKBXZhbHVlGAIgASgFUgV2YWx1ZToCOAE=');

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
    {'1': 'payments_by_method', '3': 7, '4': 3, '5': 11, '6': '.insurance.GetPaymentStatisticsResponse.PaymentsByMethodEntry', '10': 'paymentsByMethod'},
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
    'QSawoScGF5bWVudHNfYnlfbWV0aG9kGAcgAygLMj0uaW5zdXJhbmNlLkdldFBheW1lbnRTdGF0'
    'aXN0aWNzUmVzcG9uc2UuUGF5bWVudHNCeU1ldGhvZEVudHJ5UhBwYXltZW50c0J5TWV0aG9kEh'
    'gKB3N1Y2Nlc3MYCCABKAhSB3N1Y2Nlc3MSEAoDbXNnGAkgASgJUgNtc2caQwoVUGF5bWVudHNC'
    'eU1ldGhvZEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgFUgV2YWx1ZToCOA'
    'E=');

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
    {'1': 'coverage_details', '3': 17, '4': 3, '5': 11, '6': '.insurance.Insurance.CoverageDetailsEntry', '10': 'coverageDetails'},
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
    'aWNpYXJpZXMSVAoQY292ZXJhZ2VfZGV0YWlscxgRIAMoCzIpLmluc3VyYW5jZS5JbnN1cmFuY2'
    'UuQ292ZXJhZ2VEZXRhaWxzRW50cnlSD2NvdmVyYWdlRGV0YWlscxIgCgtkZXNjcmlwdGlvbhgS'
    'IAEoCVILZGVzY3JpcHRpb24SFwoHdXNlcl9pZBgTIAEoCVIGdXNlcklkEh0KCmNyZWF0ZWRfYX'
    'QYFCABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GBUgASgJUgl1cGRhdGVkQXQaQgoUQ292'
    'ZXJhZ2VEZXRhaWxzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbH'
    'VlOgI4AQ==');

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
    {'1': 'payment_details', '3': 13, '4': 3, '5': 11, '6': '.insurance.InsurancePayment.PaymentDetailsEntry', '10': 'paymentDetails'},
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
    'twcm9jZXNzZWRBdBJYCg9wYXltZW50X2RldGFpbHMYDSADKAsyLy5pbnN1cmFuY2UuSW5zdXJh'
    'bmNlUGF5bWVudC5QYXltZW50RGV0YWlsc0VudHJ5Ug5wYXltZW50RGV0YWlscxIlCg5mYWlsdX'
    'JlX3JlYXNvbhgOIAEoCVINZmFpbHVyZVJlYXNvbhIfCgtyZWNlaXB0X3VybBgPIAEoCVIKcmVj'
    'ZWlwdFVybBIXCgd1c2VyX2lkGBAgASgJUgZ1c2VySWQSHQoKY3JlYXRlZF9hdBgRIAEoCVIJY3'
    'JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYEiABKAlSCXVwZGF0ZWRBdBpBChNQYXltZW50RGV0YWls'
    'c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

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
    {'1': 'additional_info', '3': 16, '4': 3, '5': 11, '6': '.insurance.InsuranceClaim.AdditionalInfoEntry', '10': 'additionalInfo'},
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
    'KAlSC2F0dGFjaG1lbnRzEhwKCWRvY3VtZW50cxgPIAMoCVIJZG9jdW1lbnRzElYKD2FkZGl0aW'
    '9uYWxfaW5mbxgQIAMoCzItLmluc3VyYW5jZS5JbnN1cmFuY2VDbGFpbS5BZGRpdGlvbmFsSW5m'
    'b0VudHJ5Ug5hZGRpdGlvbmFsSW5mbxIpChByZWplY3Rpb25fcmVhc29uGBEgASgJUg9yZWplY3'
    'Rpb25SZWFzb24SJwoPc2V0dGxlbWVudF9kYXRlGBIgASgJUg5zZXR0bGVtZW50RGF0ZRItChJz'
    'ZXR0bGVtZW50X2RldGFpbHMYEyABKAlSEXNldHRsZW1lbnREZXRhaWxzEhcKB3VzZXJfaWQYFC'
    'ABKAlSBnVzZXJJZBIdCgpjcmVhdGVkX2F0GBUgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9h'
    'dBgWIAEoCVIJdXBkYXRlZEF0GkEKE0FkZGl0aW9uYWxJbmZvRW50cnkSEAoDa2V5GAEgASgJUg'
    'NrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

