//
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use billPaymentDescriptor instead')
const BillPayment$json = {
  '1': 'BillPayment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'bill_type', '3': 4, '4': 1, '5': 9, '10': 'billType'},
    {'1': 'provider_id', '3': 5, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'customer_number', '3': 10, '4': 1, '5': 9, '10': 'customerNumber'},
    {'1': 'token', '3': 11, '4': 1, '5': 9, '10': 'token'},
    {'1': 'metadata', '3': 12, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `BillPayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billPaymentDescriptor = $convert.base64Decode(
    'CgtCaWxsUGF5bWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh'
    '0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIbCgliaWxsX3R5cGUYBCABKAlSCGJpbGxU'
    'eXBlEh8KC3Byb3ZpZGVyX2lkGAUgASgJUgpwcm92aWRlcklkEhwKCXJlZmVyZW5jZRgGIAEoCV'
    'IJcmVmZXJlbmNlEicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVuY3lLZXkSFgoG'
    'YW1vdW50GAggASgBUgZhbW91bnQSFgoGc3RhdHVzGAkgASgJUgZzdGF0dXMSJwoPY3VzdG9tZX'
    'JfbnVtYmVyGAogASgJUg5jdXN0b21lck51bWJlchIUCgV0b2tlbhgLIAEoCVIFdG9rZW4SGgoI'
    'bWV0YWRhdGEYDCABKAlSCG1ldGFkYXRhEh0KCmNyZWF0ZWRfYXQYDSABKAlSCWNyZWF0ZWRBdA'
    '==');

@$core.Deprecated('Use billProviderDescriptor instead')
const BillProvider$json = {
  '1': 'BillProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'min_amount', '3': 6, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 7, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'service_types', '3': 8, '4': 3, '5': 9, '10': 'serviceTypes'},
  ],
};

/// Descriptor for `BillProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billProviderDescriptor = $convert.base64Decode(
    'CgxCaWxsUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEdH'
    'lwZRgDIAEoCVIEdHlwZRIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUY'
    'BSABKAhSCGlzQWN0aXZlEh0KCm1pbl9hbW91bnQYBiABKAFSCW1pbkFtb3VudBIdCgptYXhfYW'
    '1vdW50GAcgASgBUgltYXhBbW91bnQSIwoNc2VydmljZV90eXBlcxgIIAMoCVIMc2VydmljZVR5'
    'cGVz');

@$core.Deprecated('Use airtimeProviderDescriptor instead')
const AirtimeProvider$json = {
  '1': 'AirtimeProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'denominations', '3': 6, '4': 3, '5': 9, '10': 'denominations'},
    {'1': 'data_plans', '3': 7, '4': 3, '5': 9, '10': 'dataPlans'},
  ],
};

/// Descriptor for `AirtimeProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeProviderDescriptor = $convert.base64Decode(
    'Cg9BaXJ0aW1lUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGA'
    'oHbmV0d29yaxgDIAEoCVIHbmV0d29yaxIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglp'
    'c19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEiQKDWRlbm9taW5hdGlvbnMYBiADKAlSDWRlbm9taW'
    '5hdGlvbnMSHQoKZGF0YV9wbGFucxgHIAMoCVIJZGF0YVBsYW5z');

@$core.Deprecated('Use payElectricityBillRequestDescriptor instead')
const PayElectricityBillRequest$json = {
  '1': 'PayElectricityBillRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'meter_type', '3': 4, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayElectricityBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payElectricityBillRequestDescriptor = $convert.base64Decode(
    'ChlQYXlFbGVjdHJpY2l0eUJpbGxSZXF1ZXN0Eh8KC3Byb3ZpZGVyX2lkGAEgASgJUgpwcm92aW'
    'RlcklkEiEKDG1ldGVyX251bWJlchgCIAEoCVILbWV0ZXJOdW1iZXISFgoGYW1vdW50GAMgASgB'
    'UgZhbW91bnQSHQoKbWV0ZXJfdHlwZRgEIAEoCVIJbWV0ZXJUeXBlEiUKDnRyYW5zYWN0aW9uX2'
    'lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVy'
    'aWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAcgASgJUg5pZGVtcG90ZW5jeUtleQ'
    '==');

@$core.Deprecated('Use payElectricityBillResponseDescriptor instead')
const PayElectricityBillResponse$json = {
  '1': 'PayElectricityBillResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    {'1': 'units', '3': 4, '4': 1, '5': 9, '10': 'units'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayElectricityBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payElectricityBillResponseDescriptor = $convert.base64Decode(
    'ChpQYXlFbGVjdHJpY2l0eUJpbGxSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eX'
    'BheW1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdC'
    'YWxhbmNlEhQKBXRva2VuGAMgASgJUgV0b2tlbhIUCgV1bml0cxgEIAEoCVIFdW5pdHMSGAoHbW'
    'Vzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use payWaterBillRequestDescriptor instead')
const PayWaterBillRequest$json = {
  '1': 'PayWaterBillRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'customer_number', '3': 2, '4': 1, '5': 9, '10': 'customerNumber'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayWaterBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWaterBillRequestDescriptor = $convert.base64Decode(
    'ChNQYXlXYXRlckJpbGxSZXF1ZXN0Eh8KC3Byb3ZpZGVyX2lkGAEgASgJUgpwcm92aWRlcklkEi'
    'cKD2N1c3RvbWVyX251bWJlchgCIAEoCVIOY3VzdG9tZXJOdW1iZXISFgoGYW1vdW50GAMgASgB'
    'UgZhbW91bnQSJQoOdHJhbnNhY3Rpb25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaW'
    'ZpY2F0aW9uX3Rva2VuGAUgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9r'
    'ZXkYBiABKAlSDmlkZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use payWaterBillResponseDescriptor instead')
const PayWaterBillResponse$json = {
  '1': 'PayWaterBillResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'receipt_number', '3': 3, '4': 1, '5': 9, '10': 'receiptNumber'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayWaterBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWaterBillResponseDescriptor = $convert.base64Decode(
    'ChRQYXlXYXRlckJpbGxSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW1lbn'
    'RzLkJpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNl'
    'EiUKDnJlY2VpcHRfbnVtYmVyGAMgASgJUg1yZWNlaXB0TnVtYmVyEhgKB21lc3NhZ2UYBCABKA'
    'lSB21lc3NhZ2U=');

@$core.Deprecated('Use payInternetBillRequestDescriptor instead')
const PayInternetBillRequest$json = {
  '1': 'PayInternetBillRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'customer_number', '3': 2, '4': 1, '5': 9, '10': 'customerNumber'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'service_type', '3': 4, '4': 1, '5': 9, '10': 'serviceType'},
    {'1': 'package_id', '3': 5, '4': 1, '5': 9, '10': 'packageId'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayInternetBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInternetBillRequestDescriptor = $convert.base64Decode(
    'ChZQYXlJbnRlcm5ldEJpbGxSZXF1ZXN0Eh8KC3Byb3ZpZGVyX2lkGAEgASgJUgpwcm92aWRlck'
    'lkEicKD2N1c3RvbWVyX251bWJlchgCIAEoCVIOY3VzdG9tZXJOdW1iZXISFgoGYW1vdW50GAMg'
    'ASgBUgZhbW91bnQSIQoMc2VydmljZV90eXBlGAQgASgJUgtzZXJ2aWNlVHlwZRIdCgpwYWNrYW'
    'dlX2lkGAUgASgJUglwYWNrYWdlSWQSJQoOdHJhbnNhY3Rpb25faWQYBiABKAlSDXRyYW5zYWN0'
    'aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAcgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg'
    '9pZGVtcG90ZW5jeV9rZXkYCCABKAlSDmlkZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use payInternetBillResponseDescriptor instead')
const PayInternetBillResponse$json = {
  '1': 'PayInternetBillResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'renewal_date', '3': 3, '4': 1, '5': 9, '10': 'renewalDate'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayInternetBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInternetBillResponseDescriptor = $convert.base64Decode(
    'ChdQYXlJbnRlcm5ldEJpbGxSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW'
    '1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxh'
    'bmNlEiEKDHJlbmV3YWxfZGF0ZRgDIAEoCVILcmVuZXdhbERhdGUSGAoHbWVzc2FnZRgEIAEoCV'
    'IHbWVzc2FnZQ==');

@$core.Deprecated('Use buyAirtimeRequestDescriptor instead')
const BuyAirtimeRequest$json = {
  '1': 'BuyAirtimeRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'phone_number', '3': 2, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'airtime_type', '3': 4, '4': 1, '5': 9, '10': 'airtimeType'},
    {'1': 'data_plan_id', '3': 5, '4': 1, '5': 9, '10': 'dataPlanId'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `BuyAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeRequestDescriptor = $convert.base64Decode(
    'ChFCdXlBaXJ0aW1lUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZBIhCg'
    'xwaG9uZV9udW1iZXIYAiABKAlSC3Bob25lTnVtYmVyEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50'
    'EiEKDGFpcnRpbWVfdHlwZRgEIAEoCVILYWlydGltZVR5cGUSIAoMZGF0YV9wbGFuX2lkGAUgAS'
    'gJUgpkYXRhUGxhbklkEiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0K'
    'EnZlcmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdG'
    'VuY3lfa2V5GAggASgJUg5pZGVtcG90ZW5jeUtleQ==');

@$core.Deprecated('Use buyAirtimeResponseDescriptor instead')
const BuyAirtimeResponse$json = {
  '1': 'BuyAirtimeResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'data_info', '3': 4, '4': 1, '5': 9, '10': 'dataInfo'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeResponseDescriptor = $convert.base64Decode(
    'ChJCdXlBaXJ0aW1lUmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aWxpdHlwYXltZW50cy'
    '5CaWxsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIh'
    'CgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEhsKCWRhdGFfaW5mbxgEIAEoCVIIZG'
    'F0YUluZm8SGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use barcodePayRequestDescriptor instead')
const BarcodePayRequest$json = {
  '1': 'BarcodePayRequest',
  '2': [
    {'1': 'barcode_data', '3': 1, '4': 1, '5': 9, '10': 'barcodeData'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `BarcodePayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePayRequestDescriptor = $convert.base64Decode(
    'ChFCYXJjb2RlUGF5UmVxdWVzdBIhCgxiYXJjb2RlX2RhdGEYASABKAlSC2JhcmNvZGVEYXRhEh'
    'YKBmFtb3VudBgCIAEoAVIGYW1vdW50EiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2Fj'
    'dGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgEIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJw'
    'oPaWRlbXBvdGVuY3lfa2V5GAUgASgJUg5pZGVtcG90ZW5jeUtleQ==');

@$core.Deprecated('Use barcodePayResponseDescriptor instead')
const BarcodePayResponse$json = {
  '1': 'BarcodePayResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    {'1': 'bill_type', '3': 4, '4': 1, '5': 9, '10': 'billType'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BarcodePayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePayResponseDescriptor = $convert.base64Decode(
    'ChJCYXJjb2RlUGF5UmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aWxpdHlwYXltZW50cy'
    '5CaWxsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIj'
    'Cg1tZXJjaGFudF9uYW1lGAMgASgJUgxtZXJjaGFudE5hbWUSGwoJYmlsbF90eXBlGAQgASgJUg'
    'hiaWxsVHlwZRIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use scanToPayRequestDescriptor instead')
const ScanToPayRequest$json = {
  '1': 'ScanToPayRequest',
  '2': [
    {'1': 'image_data', '3': 1, '4': 1, '5': 12, '10': 'imageData'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ScanToPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanToPayRequestDescriptor = $convert.base64Decode(
    'ChBTY2FuVG9QYXlSZXF1ZXN0Eh0KCmltYWdlX2RhdGEYASABKAxSCWltYWdlRGF0YRIWCgZhbW'
    '91bnQYAiABKAFSBmFtb3VudBIlCg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25J'
    'ZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBCABKAlSEXZlcmlmaWNhdGlvblRva2VuEicKD2lkZW'
    '1wb3RlbmN5X2tleRgFIAEoCVIOaWRlbXBvdGVuY3lLZXk=');

@$core.Deprecated('Use scanToPayResponseDescriptor instead')
const ScanToPayResponse$json = {
  '1': 'ScanToPayResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    {'1': 'bill_type', '3': 4, '4': 1, '5': 9, '10': 'billType'},
    {'1': 'extracted_amount', '3': 5, '4': 1, '5': 1, '10': 'extractedAmount'},
    {'1': 'bill_details', '3': 6, '4': 1, '5': 9, '10': 'billDetails'},
    {'1': 'confidence_score', '3': 7, '4': 1, '5': 9, '10': 'confidenceScore'},
    {'1': 'message', '3': 8, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ScanToPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanToPayResponseDescriptor = $convert.base64Decode(
    'ChFTY2FuVG9QYXlSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW1lbnRzLk'
    'JpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEiMK'
    'DW1lcmNoYW50X25hbWUYAyABKAlSDG1lcmNoYW50TmFtZRIbCgliaWxsX3R5cGUYBCABKAlSCG'
    'JpbGxUeXBlEikKEGV4dHJhY3RlZF9hbW91bnQYBSABKAFSD2V4dHJhY3RlZEFtb3VudBIhCgxi'
    'aWxsX2RldGFpbHMYBiABKAlSC2JpbGxEZXRhaWxzEikKEGNvbmZpZGVuY2Vfc2NvcmUYByABKA'
    'lSD2NvbmZpZGVuY2VTY29yZRIYCgdtZXNzYWdlGAggASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getBillPaymentHistoryRequestDescriptor instead')
const GetBillPaymentHistoryRequest$json = {
  '1': 'GetBillPaymentHistoryRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'bill_type', '3': 2, '4': 1, '5': 9, '10': 'billType'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'start_date', '3': 4, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 5, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'limit', '3': 6, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 7, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetBillPaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillPaymentHistoryRequestDescriptor = $convert.base64Decode(
    'ChxHZXRCaWxsUGF5bWVudEhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY2'
    '91bnRJZBIbCgliaWxsX3R5cGUYAiABKAlSCGJpbGxUeXBlEhYKBnN0YXR1cxgDIAEoCVIGc3Rh'
    'dHVzEh0KCnN0YXJ0X2RhdGUYBCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgFIAEoCVIHZW'
    '5kRGF0ZRIUCgVsaW1pdBgGIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAcgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getBillPaymentHistoryResponseDescriptor instead')
const GetBillPaymentHistoryResponse$json = {
  '1': 'GetBillPaymentHistoryResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payments'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_amount', '3': 3, '4': 1, '5': 1, '10': 'totalAmount'},
  ],
};

/// Descriptor for `GetBillPaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillPaymentHistoryResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRCaWxsUGF5bWVudEhpc3RvcnlSZXNwb25zZRI4CghwYXltZW50cxgBIAMoCzIcLnV0aW'
    'xpdHlwYXltZW50cy5CaWxsUGF5bWVudFIIcGF5bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFs'
    'EiEKDHRvdGFsX2Ftb3VudBgDIAEoAVILdG90YWxBbW91bnQ=');

@$core.Deprecated('Use getBillProvidersRequestDescriptor instead')
const GetBillProvidersRequest$json = {
  '1': 'GetBillProvidersRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetBillProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillProvidersRequestDescriptor = $convert.base64Decode(
    'ChdHZXRCaWxsUHJvdmlkZXJzUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEh8KC2FjdGl2ZV'
    '9vbmx5GAIgASgIUgphY3RpdmVPbmx5');

@$core.Deprecated('Use getBillProvidersResponseDescriptor instead')
const GetBillProvidersResponse$json = {
  '1': 'GetBillProvidersResponse',
  '2': [
    {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.BillProvider', '10': 'providers'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetBillProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillProvidersResponseDescriptor = $convert.base64Decode(
    'ChhHZXRCaWxsUHJvdmlkZXJzUmVzcG9uc2USOwoJcHJvdmlkZXJzGAEgAygLMh0udXRpbGl0eX'
    'BheW1lbnRzLkJpbGxQcm92aWRlclIJcHJvdmlkZXJzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use getAirtimeProvidersRequestDescriptor instead')
const GetAirtimeProvidersRequest$json = {
  '1': 'GetAirtimeProvidersRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetAirtimeProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersRequestDescriptor = $convert.base64Decode(
    'ChpHZXRBaXJ0aW1lUHJvdmlkZXJzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aX'
    'ZlT25seQ==');

@$core.Deprecated('Use getAirtimeProvidersResponseDescriptor instead')
const GetAirtimeProvidersResponse$json = {
  '1': 'GetAirtimeProvidersResponse',
  '2': [
    {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeProvider', '10': 'providers'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAirtimeProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersResponseDescriptor = $convert.base64Decode(
    'ChtHZXRBaXJ0aW1lUHJvdmlkZXJzUmVzcG9uc2USPgoJcHJvdmlkZXJzGAEgAygLMiAudXRpbG'
    'l0eXBheW1lbnRzLkFpcnRpbWVQcm92aWRlclIJcHJvdmlkZXJzEhQKBXRvdGFsGAIgASgFUgV0'
    'b3RhbA==');

@$core.Deprecated('Use verifyBillRequestDescriptor instead')
const VerifyBillRequest$json = {
  '1': 'VerifyBillRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'customer_number', '3': 2, '4': 1, '5': 9, '10': 'customerNumber'},
    {'1': 'bill_type', '3': 3, '4': 1, '5': 9, '10': 'billType'},
  ],
};

/// Descriptor for `VerifyBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBillRequestDescriptor = $convert.base64Decode(
    'ChFWZXJpZnlCaWxsUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZBInCg'
    '9jdXN0b21lcl9udW1iZXIYAiABKAlSDmN1c3RvbWVyTnVtYmVyEhsKCWJpbGxfdHlwZRgDIAEo'
    'CVIIYmlsbFR5cGU=');

@$core.Deprecated('Use verifyBillResponseDescriptor instead')
const VerifyBillResponse$json = {
  '1': 'VerifyBillResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'outstanding_amount', '3': 3, '4': 1, '5': 1, '10': 'outstandingAmount'},
    {'1': 'account_status', '3': 4, '4': 1, '5': 9, '10': 'accountStatus'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `VerifyBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBillResponseDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlCaWxsUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSIwoNY3VzdG'
    '9tZXJfbmFtZRgCIAEoCVIMY3VzdG9tZXJOYW1lEi0KEm91dHN0YW5kaW5nX2Ftb3VudBgDIAEo'
    'AVIRb3V0c3RhbmRpbmdBbW91bnQSJQoOYWNjb3VudF9zdGF0dXMYBCABKAlSDWFjY291bnRTdG'
    'F0dXMSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');

