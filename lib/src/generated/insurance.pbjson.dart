///
//  Generated code. Do not modify.
//  source: insurance.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use getUserInsurancesRequestDescriptor instead')
const GetUserInsurancesRequest$json = const {
  '1': 'GetUserInsurancesRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserInsurancesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsurancesRequestDescriptor = $convert.base64Decode('ChhHZXRVc2VySW5zdXJhbmNlc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getUserInsurancesResponseDescriptor instead')
const GetUserInsurancesResponse$json = const {
  '1': 'GetUserInsurancesResponse',
  '2': const [
    const {'1': 'insurances', '3': 1, '4': 3, '5': 11, '6': '.pb.Insurance', '10': 'insurances'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserInsurancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInsurancesResponseDescriptor = $convert.base64Decode('ChlHZXRVc2VySW5zdXJhbmNlc1Jlc3BvbnNlEi0KCmluc3VyYW5jZXMYASADKAsyDS5wYi5JbnN1cmFuY2VSCmluc3VyYW5jZXMSMgoKcGFnaW5hdGlvbhgCIAEoCzISLnBiLlBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9uEhgKB3N1Y2Nlc3MYAyABKAhSB3N1Y2Nlc3MSEAoDbXNnGAQgASgJUgNtc2c=');
@$core.Deprecated('Use getInsuranceByIdRequestDescriptor instead')
const GetInsuranceByIdRequest$json = const {
  '1': 'GetInsuranceByIdRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetInsuranceByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceByIdRequestDescriptor = $convert.base64Decode('ChdHZXRJbnN1cmFuY2VCeUlkUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use getInsuranceByIdResponseDescriptor instead')
const GetInsuranceByIdResponse$json = const {
  '1': 'GetInsuranceByIdResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceByIdResponseDescriptor = $convert.base64Decode('ChhHZXRJbnN1cmFuY2VCeUlkUmVzcG9uc2USKwoJaW5zdXJhbmNlGAEgASgLMg0ucGIuSW5zdXJhbmNlUglpbnN1cmFuY2USGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIQCgNtc2cYAyABKAlSA21zZw==');
@$core.Deprecated('Use createInsuranceRequestDescriptor instead')
const CreateInsuranceRequest$json = const {
  '1': 'CreateInsuranceRequest',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `CreateInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInsuranceRequestDescriptor = $convert.base64Decode('ChZDcmVhdGVJbnN1cmFuY2VSZXF1ZXN0EisKCWluc3VyYW5jZRgBIAEoCzINLnBiLkluc3VyYW5jZVIJaW5zdXJhbmNl');
@$core.Deprecated('Use createInsuranceResponseDescriptor instead')
const CreateInsuranceResponse$json = const {
  '1': 'CreateInsuranceResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreateInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInsuranceResponseDescriptor = $convert.base64Decode('ChdDcmVhdGVJbnN1cmFuY2VSZXNwb25zZRIrCglpbnN1cmFuY2UYASABKAsyDS5wYi5JbnN1cmFuY2VSCWluc3VyYW5jZRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVIDbXNn');
@$core.Deprecated('Use updateInsuranceRequestDescriptor instead')
const UpdateInsuranceRequest$json = const {
  '1': 'UpdateInsuranceRequest',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
  ],
};

/// Descriptor for `UpdateInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsuranceRequestDescriptor = $convert.base64Decode('ChZVcGRhdGVJbnN1cmFuY2VSZXF1ZXN0EisKCWluc3VyYW5jZRgBIAEoCzINLnBiLkluc3VyYW5jZVIJaW5zdXJhbmNl');
@$core.Deprecated('Use updateInsuranceResponseDescriptor instead')
const UpdateInsuranceResponse$json = const {
  '1': 'UpdateInsuranceResponse',
  '2': const [
    const {'1': 'insurance', '3': 1, '4': 1, '5': 11, '6': '.pb.Insurance', '10': 'insurance'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `UpdateInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInsuranceResponseDescriptor = $convert.base64Decode('ChdVcGRhdGVJbnN1cmFuY2VSZXNwb25zZRIrCglpbnN1cmFuY2UYASABKAsyDS5wYi5JbnN1cmFuY2VSCWluc3VyYW5jZRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVIDbXNn');
@$core.Deprecated('Use deleteInsuranceRequestDescriptor instead')
const DeleteInsuranceRequest$json = const {
  '1': 'DeleteInsuranceRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteInsuranceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInsuranceRequestDescriptor = $convert.base64Decode('ChZEZWxldGVJbnN1cmFuY2VSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use deleteInsuranceResponseDescriptor instead')
const DeleteInsuranceResponse$json = const {
  '1': 'DeleteInsuranceResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 2, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `DeleteInsuranceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInsuranceResponseDescriptor = $convert.base64Decode('ChdEZWxldGVJbnN1cmFuY2VSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhAKA21zZxgCIAEoCVIDbXNn');
@$core.Deprecated('Use searchInsurancesRequestDescriptor instead')
const SearchInsurancesRequest$json = const {
  '1': 'SearchInsurancesRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchInsurancesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchInsurancesRequestDescriptor = $convert.base64Decode('ChdTZWFyY2hJbnN1cmFuY2VzUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSEgoEcGFnZRgCIAEoBVIEcGFnZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use searchInsurancesResponseDescriptor instead')
const SearchInsurancesResponse$json = const {
  '1': 'SearchInsurancesResponse',
  '2': const [
    const {'1': 'insurances', '3': 1, '4': 3, '5': 11, '6': '.pb.Insurance', '10': 'insurances'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `SearchInsurancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchInsurancesResponseDescriptor = $convert.base64Decode('ChhTZWFyY2hJbnN1cmFuY2VzUmVzcG9uc2USLQoKaW5zdXJhbmNlcxgBIAMoCzINLnBiLkluc3VyYW5jZVIKaW5zdXJhbmNlcxIyCgpwYWdpbmF0aW9uGAIgASgLMhIucGIuUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24SGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2VzcxIQCgNtc2cYBCABKAlSA21zZw==');
@$core.Deprecated('Use getInsurancePaymentsRequestDescriptor instead')
const GetInsurancePaymentsRequest$json = const {
  '1': 'GetInsurancePaymentsRequest',
  '2': const [
    const {'1': 'insurance_id', '3': 1, '4': 1, '5': 9, '10': 'insuranceId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInsurancePaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentsRequestDescriptor = $convert.base64Decode('ChtHZXRJbnN1cmFuY2VQYXltZW50c1JlcXVlc3QSIQoMaW5zdXJhbmNlX2lkGAEgASgJUgtpbnN1cmFuY2VJZBISCgRwYWdlGAIgASgFUgRwYWdlEhQKBWxpbWl0GAMgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getInsurancePaymentsResponseDescriptor instead')
const GetInsurancePaymentsResponse$json = const {
  '1': 'GetInsurancePaymentsResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.InsurancePayment', '10': 'payments'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsurancePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsurancePaymentsResponseDescriptor = $convert.base64Decode('ChxHZXRJbnN1cmFuY2VQYXltZW50c1Jlc3BvbnNlEjAKCHBheW1lbnRzGAEgAygLMhQucGIuSW5zdXJhbmNlUGF5bWVudFIIcGF5bWVudHMSMgoKcGFnaW5hdGlvbhgCIAEoCzISLnBiLlBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9uEhgKB3N1Y2Nlc3MYAyABKAhSB3N1Y2Nlc3MSEAoDbXNnGAQgASgJUgNtc2c=');
@$core.Deprecated('Use getUserPaymentsRequestDescriptor instead')
const GetUserPaymentsRequest$json = const {
  '1': 'GetUserPaymentsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPaymentsRequestDescriptor = $convert.base64Decode('ChZHZXRVc2VyUGF5bWVudHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBWxpbWl0');
@$core.Deprecated('Use getUserPaymentsResponseDescriptor instead')
const GetUserPaymentsResponse$json = const {
  '1': 'GetUserPaymentsResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.InsurancePayment', '10': 'payments'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPaymentsResponseDescriptor = $convert.base64Decode('ChdHZXRVc2VyUGF5bWVudHNSZXNwb25zZRIwCghwYXltZW50cxgBIAMoCzIULnBiLkluc3VyYW5jZVBheW1lbnRSCHBheW1lbnRzEjIKCnBhZ2luYXRpb24YAiABKAsyEi5wYi5QYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbhIYCgdzdWNjZXNzGAMgASgIUgdzdWNjZXNzEhAKA21zZxgEIAEoCVIDbXNn');
@$core.Deprecated('Use createPaymentRequestDescriptor instead')
const CreatePaymentRequest$json = const {
  '1': 'CreatePaymentRequest',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePayment', '10': 'payment'},
  ],
};

/// Descriptor for `CreatePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVQYXltZW50UmVxdWVzdBIuCgdwYXltZW50GAEgASgLMhQucGIuSW5zdXJhbmNlUGF5bWVudFIHcGF5bWVudA==');
@$core.Deprecated('Use createPaymentResponseDescriptor instead')
const CreatePaymentResponse$json = const {
  '1': 'CreatePaymentResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePayment', '10': 'payment'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreatePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPaymentResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVQYXltZW50UmVzcG9uc2USLgoHcGF5bWVudBgBIAEoCzIULnBiLkluc3VyYW5jZVBheW1lbnRSB3BheW1lbnQSGAoHc3VjY2VzcxgCIAEoCFIHc3VjY2VzcxIQCgNtc2cYAyABKAlSA21zZw==');
@$core.Deprecated('Use processPaymentRequestDescriptor instead')
const ProcessPaymentRequest$json = const {
  '1': 'ProcessPaymentRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'payment_method', '3': 2, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'payment_details', '3': 3, '4': 3, '5': 11, '6': '.pb.ProcessPaymentRequest.PaymentDetailsEntry', '10': 'paymentDetails'},
  ],
  '3': const [ProcessPaymentRequest_PaymentDetailsEntry$json],
};

@$core.Deprecated('Use processPaymentRequestDescriptor instead')
const ProcessPaymentRequest_PaymentDetailsEntry$json = const {
  '1': 'PaymentDetailsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ProcessPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPaymentRequestDescriptor = $convert.base64Decode('ChVQcm9jZXNzUGF5bWVudFJlcXVlc3QSHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudElkEiUKDnBheW1lbnRfbWV0aG9kGAIgASgJUg1wYXltZW50TWV0aG9kElYKD3BheW1lbnRfZGV0YWlscxgDIAMoCzItLnBiLlByb2Nlc3NQYXltZW50UmVxdWVzdC5QYXltZW50RGV0YWlsc0VudHJ5Ug5wYXltZW50RGV0YWlscxpBChNQYXltZW50RGV0YWlsc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use processPaymentResponseDescriptor instead')
const ProcessPaymentResponse$json = const {
  '1': 'ProcessPaymentResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePayment', '10': 'payment'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'reference_number', '3': 3, '4': 1, '5': 9, '10': 'referenceNumber'},
    const {'1': 'receipt_url', '3': 4, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'success', '3': 5, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 6, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `ProcessPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPaymentResponseDescriptor = $convert.base64Decode('ChZQcm9jZXNzUGF5bWVudFJlc3BvbnNlEi4KB3BheW1lbnQYASABKAsyFC5wYi5JbnN1cmFuY2VQYXltZW50UgdwYXltZW50EiUKDnRyYW5zYWN0aW9uX2lkGAIgASgJUg10cmFuc2FjdGlvbklkEikKEHJlZmVyZW5jZV9udW1iZXIYAyABKAlSD3JlZmVyZW5jZU51bWJlchIfCgtyZWNlaXB0X3VybBgEIAEoCVIKcmVjZWlwdFVybBIYCgdzdWNjZXNzGAUgASgIUgdzdWNjZXNzEhAKA21zZxgGIAEoCVIDbXNn');
@$core.Deprecated('Use getPaymentByIdRequestDescriptor instead')
const GetPaymentByIdRequest$json = const {
  '1': 'GetPaymentByIdRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetPaymentByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentByIdRequestDescriptor = $convert.base64Decode('ChVHZXRQYXltZW50QnlJZFJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use getPaymentByIdResponseDescriptor instead')
const GetPaymentByIdResponse$json = const {
  '1': 'GetPaymentByIdResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.InsurancePayment', '10': 'payment'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetPaymentByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentByIdResponseDescriptor = $convert.base64Decode('ChZHZXRQYXltZW50QnlJZFJlc3BvbnNlEi4KB3BheW1lbnQYASABKAsyFC5wYi5JbnN1cmFuY2VQYXltZW50UgdwYXltZW50EhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJUgNtc2c=');
@$core.Deprecated('Use getOverduePaymentsRequestDescriptor instead')
const GetOverduePaymentsRequest$json = const {
  '1': 'GetOverduePaymentsRequest',
};

/// Descriptor for `GetOverduePaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverduePaymentsRequestDescriptor = $convert.base64Decode('ChlHZXRPdmVyZHVlUGF5bWVudHNSZXF1ZXN0');
@$core.Deprecated('Use getOverduePaymentsResponseDescriptor instead')
const GetOverduePaymentsResponse$json = const {
  '1': 'GetOverduePaymentsResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.InsurancePayment', '10': 'payments'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetOverduePaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOverduePaymentsResponseDescriptor = $convert.base64Decode('ChpHZXRPdmVyZHVlUGF5bWVudHNSZXNwb25zZRIwCghwYXltZW50cxgBIAMoCzIULnBiLkluc3VyYW5jZVBheW1lbnRSCHBheW1lbnRzEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJUgNtc2c=');
@$core.Deprecated('Use getInsuranceClaimsRequestDescriptor instead')
const GetInsuranceClaimsRequest$json = const {
  '1': 'GetInsuranceClaimsRequest',
  '2': const [
    const {'1': 'insurance_id', '3': 1, '4': 1, '5': 9, '10': 'insuranceId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInsuranceClaimsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimsRequestDescriptor = $convert.base64Decode('ChlHZXRJbnN1cmFuY2VDbGFpbXNSZXF1ZXN0EiEKDGluc3VyYW5jZV9pZBgBIAEoCVILaW5zdXJhbmNlSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getInsuranceClaimsResponseDescriptor instead')
const GetInsuranceClaimsResponse$json = const {
  '1': 'GetInsuranceClaimsResponse',
  '2': const [
    const {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claims'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetInsuranceClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceClaimsResponseDescriptor = $convert.base64Decode('ChpHZXRJbnN1cmFuY2VDbGFpbXNSZXNwb25zZRIqCgZjbGFpbXMYASADKAsyEi5wYi5JbnN1cmFuY2VDbGFpbVIGY2xhaW1zEjIKCnBhZ2luYXRpb24YAiABKAsyEi5wYi5QYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbhIYCgdzdWNjZXNzGAMgASgIUgdzdWNjZXNzEhAKA21zZxgEIAEoCVIDbXNn');
@$core.Deprecated('Use getUserClaimsRequestDescriptor instead')
const GetUserClaimsRequest$json = const {
  '1': 'GetUserClaimsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserClaimsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserClaimsRequestDescriptor = $convert.base64Decode('ChRHZXRVc2VyQ2xhaW1zUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');
@$core.Deprecated('Use getUserClaimsResponseDescriptor instead')
const GetUserClaimsResponse$json = const {
  '1': 'GetUserClaimsResponse',
  '2': const [
    const {'1': 'claims', '3': 1, '4': 3, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claims'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserClaimsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserClaimsResponseDescriptor = $convert.base64Decode('ChVHZXRVc2VyQ2xhaW1zUmVzcG9uc2USKgoGY2xhaW1zGAEgAygLMhIucGIuSW5zdXJhbmNlQ2xhaW1SBmNsYWltcxIyCgpwYWdpbmF0aW9uGAIgASgLMhIucGIuUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24SGAoHc3VjY2VzcxgDIAEoCFIHc3VjY2VzcxIQCgNtc2cYBCABKAlSA21zZw==');
@$core.Deprecated('Use createClaimRequestDescriptor instead')
const CreateClaimRequest$json = const {
  '1': 'CreateClaimRequest',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
  ],
};

/// Descriptor for `CreateClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createClaimRequestDescriptor = $convert.base64Decode('ChJDcmVhdGVDbGFpbVJlcXVlc3QSKAoFY2xhaW0YASABKAsyEi5wYi5JbnN1cmFuY2VDbGFpbVIFY2xhaW0=');
@$core.Deprecated('Use createClaimResponseDescriptor instead')
const CreateClaimResponse$json = const {
  '1': 'CreateClaimResponse',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `CreateClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createClaimResponseDescriptor = $convert.base64Decode('ChNDcmVhdGVDbGFpbVJlc3BvbnNlEigKBWNsYWltGAEgASgLMhIucGIuSW5zdXJhbmNlQ2xhaW1SBWNsYWltEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJUgNtc2c=');
@$core.Deprecated('Use updateClaimRequestDescriptor instead')
const UpdateClaimRequest$json = const {
  '1': 'UpdateClaimRequest',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
  ],
};

/// Descriptor for `UpdateClaimRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateClaimRequestDescriptor = $convert.base64Decode('ChJVcGRhdGVDbGFpbVJlcXVlc3QSKAoFY2xhaW0YASABKAsyEi5wYi5JbnN1cmFuY2VDbGFpbVIFY2xhaW0=');
@$core.Deprecated('Use updateClaimResponseDescriptor instead')
const UpdateClaimResponse$json = const {
  '1': 'UpdateClaimResponse',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `UpdateClaimResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateClaimResponseDescriptor = $convert.base64Decode('ChNVcGRhdGVDbGFpbVJlc3BvbnNlEigKBWNsYWltGAEgASgLMhIucGIuSW5zdXJhbmNlQ2xhaW1SBWNsYWltEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3MSEAoDbXNnGAMgASgJUgNtc2c=');
@$core.Deprecated('Use getClaimByIdRequestDescriptor instead')
const GetClaimByIdRequest$json = const {
  '1': 'GetClaimByIdRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetClaimByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClaimByIdRequestDescriptor = $convert.base64Decode('ChNHZXRDbGFpbUJ5SWRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use getClaimByIdResponseDescriptor instead')
const GetClaimByIdResponse$json = const {
  '1': 'GetClaimByIdResponse',
  '2': const [
    const {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.pb.InsuranceClaim', '10': 'claim'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetClaimByIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getClaimByIdResponseDescriptor = $convert.base64Decode('ChRHZXRDbGFpbUJ5SWRSZXNwb25zZRIoCgVjbGFpbRgBIAEoCzISLnBiLkluc3VyYW5jZUNsYWltUgVjbGFpbRIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEhAKA21zZxgDIAEoCVIDbXNn');
@$core.Deprecated('Use generatePaymentReceiptRequestDescriptor instead')
const GeneratePaymentReceiptRequest$json = const {
  '1': 'GeneratePaymentReceiptRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GeneratePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatePaymentReceiptRequestDescriptor = $convert.base64Decode('Ch1HZW5lcmF0ZVBheW1lbnRSZWNlaXB0UmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SWQ=');
@$core.Deprecated('Use generatePaymentReceiptResponseDescriptor instead')
const GeneratePaymentReceiptResponse$json = const {
  '1': 'GeneratePaymentReceiptResponse',
  '2': const [
    const {'1': 'receipt_url', '3': 1, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'receipt_id', '3': 2, '4': 1, '5': 9, '10': 'receiptId'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GeneratePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatePaymentReceiptResponseDescriptor = $convert.base64Decode('Ch5HZW5lcmF0ZVBheW1lbnRSZWNlaXB0UmVzcG9uc2USHwoLcmVjZWlwdF91cmwYASABKAlSCnJlY2VpcHRVcmwSHQoKcmVjZWlwdF9pZBgCIAEoCVIJcmVjZWlwdElkEhgKB3N1Y2Nlc3MYAyABKAhSB3N1Y2Nlc3MSEAoDbXNnGAQgASgJUgNtc2c=');
@$core.Deprecated('Use getUserReceiptsRequestDescriptor instead')
const GetUserReceiptsRequest$json = const {
  '1': 'GetUserReceiptsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetUserReceiptsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserReceiptsRequestDescriptor = $convert.base64Decode('ChZHZXRVc2VyUmVjZWlwdHNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBWxpbWl0');
@$core.Deprecated('Use getUserReceiptsResponseDescriptor instead')
const GetUserReceiptsResponse$json = const {
  '1': 'GetUserReceiptsResponse',
  '2': const [
    const {'1': 'receipt_urls', '3': 1, '4': 3, '5': 9, '10': 'receiptUrls'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PaginationInfo', '10': 'pagination'},
    const {'1': 'success', '3': 3, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 4, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `GetUserReceiptsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserReceiptsResponseDescriptor = $convert.base64Decode('ChdHZXRVc2VyUmVjZWlwdHNSZXNwb25zZRIhCgxyZWNlaXB0X3VybHMYASADKAlSC3JlY2VpcHRVcmxzEjIKCnBhZ2luYXRpb24YAiABKAsyEi5wYi5QYWdpbmF0aW9uSW5mb1IKcGFnaW5hdGlvbhIYCgdzdWNjZXNzGAMgASgIUgdzdWNjZXNzEhAKA21zZxgEIAEoCVIDbXNn');
@$core.Deprecated('Use getInsuranceStatisticsRequestDescriptor instead')
const GetInsuranceStatisticsRequest$json = const {
  '1': 'GetInsuranceStatisticsRequest',
};

/// Descriptor for `GetInsuranceStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceStatisticsRequestDescriptor = $convert.base64Decode('Ch1HZXRJbnN1cmFuY2VTdGF0aXN0aWNzUmVxdWVzdA==');
@$core.Deprecated('Use getInsuranceStatisticsResponseDescriptor instead')
const GetInsuranceStatisticsResponse$json = const {
  '1': 'GetInsuranceStatisticsResponse',
  '2': const [
    const {'1': 'total_policies', '3': 1, '4': 1, '5': 5, '10': 'totalPolicies'},
    const {'1': 'active_policies', '3': 2, '4': 1, '5': 5, '10': 'activePolicies'},
    const {'1': 'expired_policies', '3': 3, '4': 1, '5': 5, '10': 'expiredPolicies'},
    const {'1': 'total_coverage_amount', '3': 4, '4': 1, '5': 1, '10': 'totalCoverageAmount'},
    const {'1': 'total_premium_amount', '3': 5, '4': 1, '5': 1, '10': 'totalPremiumAmount'},
    const {'1': 'policies_by_type', '3': 6, '4': 3, '5': 11, '6': '.pb.GetInsuranceStatisticsResponse.PoliciesByTypeEntry', '10': 'policiesByType'},
    const {'1': 'success', '3': 7, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 8, '4': 1, '5': 9, '10': 'msg'},
  ],
  '3': const [GetInsuranceStatisticsResponse_PoliciesByTypeEntry$json],
};

@$core.Deprecated('Use getInsuranceStatisticsResponseDescriptor instead')
const GetInsuranceStatisticsResponse_PoliciesByTypeEntry$json = const {
  '1': 'PoliciesByTypeEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetInsuranceStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInsuranceStatisticsResponseDescriptor = $convert.base64Decode('Ch5HZXRJbnN1cmFuY2VTdGF0aXN0aWNzUmVzcG9uc2USJQoOdG90YWxfcG9saWNpZXMYASABKAVSDXRvdGFsUG9saWNpZXMSJwoPYWN0aXZlX3BvbGljaWVzGAIgASgFUg5hY3RpdmVQb2xpY2llcxIpChBleHBpcmVkX3BvbGljaWVzGAMgASgFUg9leHBpcmVkUG9saWNpZXMSMgoVdG90YWxfY292ZXJhZ2VfYW1vdW50GAQgASgBUhN0b3RhbENvdmVyYWdlQW1vdW50EjAKFHRvdGFsX3ByZW1pdW1fYW1vdW50GAUgASgBUhJ0b3RhbFByZW1pdW1BbW91bnQSYAoQcG9saWNpZXNfYnlfdHlwZRgGIAMoCzI2LnBiLkdldEluc3VyYW5jZVN0YXRpc3RpY3NSZXNwb25zZS5Qb2xpY2llc0J5VHlwZUVudHJ5Ug5wb2xpY2llc0J5VHlwZRIYCgdzdWNjZXNzGAcgASgIUgdzdWNjZXNzEhAKA21zZxgIIAEoCVIDbXNnGkEKE1BvbGljaWVzQnlUeXBlRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAVSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use getPaymentStatisticsRequestDescriptor instead')
const GetPaymentStatisticsRequest$json = const {
  '1': 'GetPaymentStatisticsRequest',
  '2': const [
    const {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetPaymentStatisticsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentStatisticsRequestDescriptor = $convert.base64Decode('ChtHZXRQYXltZW50U3RhdGlzdGljc1JlcXVlc3QSHQoKc3RhcnRfZGF0ZRgBIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAIgASgJUgdlbmREYXRl');
@$core.Deprecated('Use getPaymentStatisticsResponseDescriptor instead')
const GetPaymentStatisticsResponse$json = const {
  '1': 'GetPaymentStatisticsResponse',
  '2': const [
    const {'1': 'total_payments', '3': 1, '4': 1, '5': 5, '10': 'totalPayments'},
    const {'1': 'completed_payments', '3': 2, '4': 1, '5': 5, '10': 'completedPayments'},
    const {'1': 'pending_payments', '3': 3, '4': 1, '5': 5, '10': 'pendingPayments'},
    const {'1': 'failed_payments', '3': 4, '4': 1, '5': 5, '10': 'failedPayments'},
    const {'1': 'total_amount', '3': 5, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'completed_amount', '3': 6, '4': 1, '5': 1, '10': 'completedAmount'},
    const {'1': 'payments_by_method', '3': 7, '4': 3, '5': 11, '6': '.pb.GetPaymentStatisticsResponse.PaymentsByMethodEntry', '10': 'paymentsByMethod'},
    const {'1': 'success', '3': 8, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'msg', '3': 9, '4': 1, '5': 9, '10': 'msg'},
  ],
  '3': const [GetPaymentStatisticsResponse_PaymentsByMethodEntry$json],
};

@$core.Deprecated('Use getPaymentStatisticsResponseDescriptor instead')
const GetPaymentStatisticsResponse_PaymentsByMethodEntry$json = const {
  '1': 'PaymentsByMethodEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetPaymentStatisticsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentStatisticsResponseDescriptor = $convert.base64Decode('ChxHZXRQYXltZW50U3RhdGlzdGljc1Jlc3BvbnNlEiUKDnRvdGFsX3BheW1lbnRzGAEgASgFUg10b3RhbFBheW1lbnRzEi0KEmNvbXBsZXRlZF9wYXltZW50cxgCIAEoBVIRY29tcGxldGVkUGF5bWVudHMSKQoQcGVuZGluZ19wYXltZW50cxgDIAEoBVIPcGVuZGluZ1BheW1lbnRzEicKD2ZhaWxlZF9wYXltZW50cxgEIAEoBVIOZmFpbGVkUGF5bWVudHMSIQoMdG90YWxfYW1vdW50GAUgASgBUgt0b3RhbEFtb3VudBIpChBjb21wbGV0ZWRfYW1vdW50GAYgASgBUg9jb21wbGV0ZWRBbW91bnQSZAoScGF5bWVudHNfYnlfbWV0aG9kGAcgAygLMjYucGIuR2V0UGF5bWVudFN0YXRpc3RpY3NSZXNwb25zZS5QYXltZW50c0J5TWV0aG9kRW50cnlSEHBheW1lbnRzQnlNZXRob2QSGAoHc3VjY2VzcxgIIAEoCFIHc3VjY2VzcxIQCgNtc2cYCSABKAlSA21zZxpDChVQYXltZW50c0J5TWV0aG9kRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAVSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use insuranceDescriptor instead')
const Insurance$json = const {
  '1': 'Insurance',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'policy_number', '3': 2, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'policy_holder_name', '3': 3, '4': 1, '5': 9, '10': 'policyHolderName'},
    const {'1': 'policy_holder_email', '3': 4, '4': 1, '5': 9, '10': 'policyHolderEmail'},
    const {'1': 'policy_holder_phone', '3': 5, '4': 1, '5': 9, '10': 'policyHolderPhone'},
    const {'1': 'type', '3': 6, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'provider', '3': 7, '4': 1, '5': 9, '10': 'provider'},
    const {'1': 'provider_logo', '3': 8, '4': 1, '5': 9, '10': 'providerLogo'},
    const {'1': 'premium_amount', '3': 9, '4': 1, '5': 1, '10': 'premiumAmount'},
    const {'1': 'coverage_amount', '3': 10, '4': 1, '5': 1, '10': 'coverageAmount'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'start_date', '3': 12, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 13, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'next_payment_date', '3': 14, '4': 1, '5': 9, '10': 'nextPaymentDate'},
    const {'1': 'status', '3': 15, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'beneficiaries', '3': 16, '4': 3, '5': 9, '10': 'beneficiaries'},
    const {'1': 'coverage_details', '3': 17, '4': 3, '5': 11, '6': '.pb.Insurance.CoverageDetailsEntry', '10': 'coverageDetails'},
    const {'1': 'description', '3': 18, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'user_id', '3': 19, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': const [Insurance_CoverageDetailsEntry$json],
};

@$core.Deprecated('Use insuranceDescriptor instead')
const Insurance_CoverageDetailsEntry$json = const {
  '1': 'CoverageDetailsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Insurance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceDescriptor = $convert.base64Decode('CglJbnN1cmFuY2USDgoCaWQYASABKAlSAmlkEiMKDXBvbGljeV9udW1iZXIYAiABKAlSDHBvbGljeU51bWJlchIsChJwb2xpY3lfaG9sZGVyX25hbWUYAyABKAlSEHBvbGljeUhvbGRlck5hbWUSLgoTcG9saWN5X2hvbGRlcl9lbWFpbBgEIAEoCVIRcG9saWN5SG9sZGVyRW1haWwSLgoTcG9saWN5X2hvbGRlcl9waG9uZRgFIAEoCVIRcG9saWN5SG9sZGVyUGhvbmUSEgoEdHlwZRgGIAEoCVIEdHlwZRIaCghwcm92aWRlchgHIAEoCVIIcHJvdmlkZXISIwoNcHJvdmlkZXJfbG9nbxgIIAEoCVIMcHJvdmlkZXJMb2dvEiUKDnByZW1pdW1fYW1vdW50GAkgASgBUg1wcmVtaXVtQW1vdW50EicKD2NvdmVyYWdlX2Ftb3VudBgKIAEoAVIOY292ZXJhZ2VBbW91bnQSGgoIY3VycmVuY3kYCyABKAlSCGN1cnJlbmN5Eh0KCnN0YXJ0X2RhdGUYDCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgNIAEoCVIHZW5kRGF0ZRIqChFuZXh0X3BheW1lbnRfZGF0ZRgOIAEoCVIPbmV4dFBheW1lbnREYXRlEhYKBnN0YXR1cxgPIAEoCVIGc3RhdHVzEiQKDWJlbmVmaWNpYXJpZXMYECADKAlSDWJlbmVmaWNpYXJpZXMSTQoQY292ZXJhZ2VfZGV0YWlscxgRIAMoCzIiLnBiLkluc3VyYW5jZS5Db3ZlcmFnZURldGFpbHNFbnRyeVIPY292ZXJhZ2VEZXRhaWxzEiAKC2Rlc2NyaXB0aW9uGBIgASgJUgtkZXNjcmlwdGlvbhIXCgd1c2VyX2lkGBMgASgJUgZ1c2VySWQSHQoKY3JlYXRlZF9hdBgUIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFSABKAlSCXVwZGF0ZWRBdBpCChRDb3ZlcmFnZURldGFpbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use insurancePaymentDescriptor instead')
const InsurancePayment$json = const {
  '1': 'InsurancePayment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'insurance_id', '3': 2, '4': 1, '5': 9, '10': 'insuranceId'},
    const {'1': 'policy_number', '3': 3, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'payment_method', '3': 6, '4': 1, '5': 9, '10': 'paymentMethod'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'transaction_id', '3': 8, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'reference_number', '3': 9, '4': 1, '5': 9, '10': 'referenceNumber'},
    const {'1': 'payment_date', '3': 10, '4': 1, '5': 9, '10': 'paymentDate'},
    const {'1': 'due_date', '3': 11, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'processed_at', '3': 12, '4': 1, '5': 9, '10': 'processedAt'},
    const {'1': 'payment_details', '3': 13, '4': 3, '5': 11, '6': '.pb.InsurancePayment.PaymentDetailsEntry', '10': 'paymentDetails'},
    const {'1': 'failure_reason', '3': 14, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'receipt_url', '3': 15, '4': 1, '5': 9, '10': 'receiptUrl'},
    const {'1': 'user_id', '3': 16, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': const [InsurancePayment_PaymentDetailsEntry$json],
};

@$core.Deprecated('Use insurancePaymentDescriptor instead')
const InsurancePayment_PaymentDetailsEntry$json = const {
  '1': 'PaymentDetailsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `InsurancePayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insurancePaymentDescriptor = $convert.base64Decode('ChBJbnN1cmFuY2VQYXltZW50Eg4KAmlkGAEgASgJUgJpZBIhCgxpbnN1cmFuY2VfaWQYAiABKAlSC2luc3VyYW5jZUlkEiMKDXBvbGljeV9udW1iZXIYAyABKAlSDHBvbGljeU51bWJlchIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgFIAEoCVIIY3VycmVuY3kSJQoOcGF5bWVudF9tZXRob2QYBiABKAlSDXBheW1lbnRNZXRob2QSFgoGc3RhdHVzGAcgASgJUgZzdGF0dXMSJQoOdHJhbnNhY3Rpb25faWQYCCABKAlSDXRyYW5zYWN0aW9uSWQSKQoQcmVmZXJlbmNlX251bWJlchgJIAEoCVIPcmVmZXJlbmNlTnVtYmVyEiEKDHBheW1lbnRfZGF0ZRgKIAEoCVILcGF5bWVudERhdGUSGQoIZHVlX2RhdGUYCyABKAlSB2R1ZURhdGUSIQoMcHJvY2Vzc2VkX2F0GAwgASgJUgtwcm9jZXNzZWRBdBJRCg9wYXltZW50X2RldGFpbHMYDSADKAsyKC5wYi5JbnN1cmFuY2VQYXltZW50LlBheW1lbnREZXRhaWxzRW50cnlSDnBheW1lbnREZXRhaWxzEiUKDmZhaWx1cmVfcmVhc29uGA4gASgJUg1mYWlsdXJlUmVhc29uEh8KC3JlY2VpcHRfdXJsGA8gASgJUgpyZWNlaXB0VXJsEhcKB3VzZXJfaWQYECABKAlSBnVzZXJJZBIdCgpjcmVhdGVkX2F0GBEgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgSIAEoCVIJdXBkYXRlZEF0GkEKE1BheW1lbnREZXRhaWxzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use insuranceClaimDescriptor instead')
const InsuranceClaim$json = const {
  '1': 'InsuranceClaim',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'claim_number', '3': 2, '4': 1, '5': 9, '10': 'claimNumber'},
    const {'1': 'insurance_id', '3': 3, '4': 1, '5': 9, '10': 'insuranceId'},
    const {'1': 'policy_number', '3': 4, '4': 1, '5': 9, '10': 'policyNumber'},
    const {'1': 'type', '3': 5, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'status', '3': 6, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'title', '3': 7, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'claim_amount', '3': 9, '4': 1, '5': 1, '10': 'claimAmount'},
    const {'1': 'approved_amount', '3': 10, '4': 1, '5': 1, '10': 'approvedAmount'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'incident_date', '3': 12, '4': 1, '5': 9, '10': 'incidentDate'},
    const {'1': 'incident_location', '3': 13, '4': 1, '5': 9, '10': 'incidentLocation'},
    const {'1': 'attachments', '3': 14, '4': 3, '5': 9, '10': 'attachments'},
    const {'1': 'documents', '3': 15, '4': 3, '5': 9, '10': 'documents'},
    const {'1': 'additional_info', '3': 16, '4': 3, '5': 11, '6': '.pb.InsuranceClaim.AdditionalInfoEntry', '10': 'additionalInfo'},
    const {'1': 'rejection_reason', '3': 17, '4': 1, '5': 9, '10': 'rejectionReason'},
    const {'1': 'settlement_date', '3': 18, '4': 1, '5': 9, '10': 'settlementDate'},
    const {'1': 'settlement_details', '3': 19, '4': 1, '5': 9, '10': 'settlementDetails'},
    const {'1': 'user_id', '3': 20, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 22, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
  '3': const [InsuranceClaim_AdditionalInfoEntry$json],
};

@$core.Deprecated('Use insuranceClaimDescriptor instead')
const InsuranceClaim_AdditionalInfoEntry$json = const {
  '1': 'AdditionalInfoEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `InsuranceClaim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insuranceClaimDescriptor = $convert.base64Decode('Cg5JbnN1cmFuY2VDbGFpbRIOCgJpZBgBIAEoCVICaWQSIQoMY2xhaW1fbnVtYmVyGAIgASgJUgtjbGFpbU51bWJlchIhCgxpbnN1cmFuY2VfaWQYAyABKAlSC2luc3VyYW5jZUlkEiMKDXBvbGljeV9udW1iZXIYBCABKAlSDHBvbGljeU51bWJlchISCgR0eXBlGAUgASgJUgR0eXBlEhYKBnN0YXR1cxgGIAEoCVIGc3RhdHVzEhQKBXRpdGxlGAcgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgIIAEoCVILZGVzY3JpcHRpb24SIQoMY2xhaW1fYW1vdW50GAkgASgBUgtjbGFpbUFtb3VudBInCg9hcHByb3ZlZF9hbW91bnQYCiABKAFSDmFwcHJvdmVkQW1vdW50EhoKCGN1cnJlbmN5GAsgASgJUghjdXJyZW5jeRIjCg1pbmNpZGVudF9kYXRlGAwgASgJUgxpbmNpZGVudERhdGUSKwoRaW5jaWRlbnRfbG9jYXRpb24YDSABKAlSEGluY2lkZW50TG9jYXRpb24SIAoLYXR0YWNobWVudHMYDiADKAlSC2F0dGFjaG1lbnRzEhwKCWRvY3VtZW50cxgPIAMoCVIJZG9jdW1lbnRzEk8KD2FkZGl0aW9uYWxfaW5mbxgQIAMoCzImLnBiLkluc3VyYW5jZUNsYWltLkFkZGl0aW9uYWxJbmZvRW50cnlSDmFkZGl0aW9uYWxJbmZvEikKEHJlamVjdGlvbl9yZWFzb24YESABKAlSD3JlamVjdGlvblJlYXNvbhInCg9zZXR0bGVtZW50X2RhdGUYEiABKAlSDnNldHRsZW1lbnREYXRlEi0KEnNldHRsZW1lbnRfZGV0YWlscxgTIAEoCVIRc2V0dGxlbWVudERldGFpbHMSFwoHdXNlcl9pZBgUIAEoCVIGdXNlcklkEh0KCmNyZWF0ZWRfYXQYFSABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GBYgASgJUgl1cGRhdGVkQXQaQQoTQWRkaXRpb25hbEluZm9FbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
