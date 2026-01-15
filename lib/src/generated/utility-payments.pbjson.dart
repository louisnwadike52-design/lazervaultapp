///
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use billPaymentDescriptor instead')
const BillPayment$json = const {
  '1': 'BillPayment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'bill_type', '3': 4, '4': 1, '5': 9, '10': 'billType'},
    const {'1': 'provider_id', '3': 5, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'reference', '3': 6, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'customer_number', '3': 10, '4': 1, '5': 9, '10': 'customerNumber'},
    const {'1': 'token', '3': 11, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'metadata', '3': 12, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `BillPayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billPaymentDescriptor = $convert.base64Decode('CgtCaWxsUGF5bWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIbCgliaWxsX3R5cGUYBCABKAlSCGJpbGxUeXBlEh8KC3Byb3ZpZGVyX2lkGAUgASgJUgpwcm92aWRlcklkEhwKCXJlZmVyZW5jZRgGIAEoCVIJcmVmZXJlbmNlEicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVuY3lLZXkSFgoGYW1vdW50GAggASgBUgZhbW91bnQSFgoGc3RhdHVzGAkgASgJUgZzdGF0dXMSJwoPY3VzdG9tZXJfbnVtYmVyGAogASgJUg5jdXN0b21lck51bWJlchIUCgV0b2tlbhgLIAEoCVIFdG9rZW4SGgoIbWV0YWRhdGEYDCABKAlSCG1ldGFkYXRhEh0KCmNyZWF0ZWRfYXQYDSABKAlSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use billProviderDescriptor instead')
const BillProvider$json = const {
  '1': 'BillProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'min_amount', '3': 6, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 7, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'service_types', '3': 8, '4': 3, '5': 9, '10': 'serviceTypes'},
  ],
};

/// Descriptor for `BillProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billProviderDescriptor = $convert.base64Decode('CgxCaWxsUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEdHlwZRgDIAEoCVIEdHlwZRIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEh0KCm1pbl9hbW91bnQYBiABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAcgASgBUgltYXhBbW91bnQSIwoNc2VydmljZV90eXBlcxgIIAMoCVIMc2VydmljZVR5cGVz');
@$core.Deprecated('Use airtimeProviderDescriptor instead')
const AirtimeProvider$json = const {
  '1': 'AirtimeProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'denominations', '3': 6, '4': 3, '5': 9, '10': 'denominations'},
    const {'1': 'data_plans', '3': 7, '4': 3, '5': 9, '10': 'dataPlans'},
  ],
};

/// Descriptor for `AirtimeProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeProviderDescriptor = $convert.base64Decode('Cg9BaXJ0aW1lUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGAoHbmV0d29yaxgDIAEoCVIHbmV0d29yaxIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEiQKDWRlbm9taW5hdGlvbnMYBiADKAlSDWRlbm9taW5hdGlvbnMSHQoKZGF0YV9wbGFucxgHIAMoCVIJZGF0YVBsYW5z');
@$core.Deprecated('Use payElectricityBillRequestDescriptor instead')
const PayElectricityBillRequest$json = const {
  '1': 'PayElectricityBillRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'meter_type', '3': 4, '4': 1, '5': 9, '10': 'meterType'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayElectricityBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payElectricityBillRequestDescriptor = $convert.base64Decode('ChlQYXlFbGVjdHJpY2l0eUJpbGxSZXF1ZXN0Eh8KC3Byb3ZpZGVyX2lkGAEgASgJUgpwcm92aWRlcklkEiEKDG1ldGVyX251bWJlchgCIAEoCVILbWV0ZXJOdW1iZXISFgoGYW1vdW50GAMgASgBUgZhbW91bnQSHQoKbWV0ZXJfdHlwZRgEIAEoCVIJbWV0ZXJUeXBlEiUKDnRyYW5zYWN0aW9uX2lkGAUgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgGIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAcgASgJUg5pZGVtcG90ZW5jeUtleQ==');
@$core.Deprecated('Use payElectricityBillResponseDescriptor instead')
const PayElectricityBillResponse$json = const {
  '1': 'PayElectricityBillResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'units', '3': 4, '4': 1, '5': 9, '10': 'units'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayElectricityBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payElectricityBillResponseDescriptor = $convert.base64Decode('ChpQYXlFbGVjdHJpY2l0eUJpbGxSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEhQKBXRva2VuGAMgASgJUgV0b2tlbhIUCgV1bml0cxgEIAEoCVIFdW5pdHMSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use payWaterBillRequestDescriptor instead')
const PayWaterBillRequest$json = const {
  '1': 'PayWaterBillRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'customer_number', '3': 2, '4': 1, '5': 9, '10': 'customerNumber'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayWaterBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWaterBillRequestDescriptor = $convert.base64Decode('ChNQYXlXYXRlckJpbGxSZXF1ZXN0Eh8KC3Byb3ZpZGVyX2lkGAEgASgJUgpwcm92aWRlcklkEicKD2N1c3RvbWVyX251bWJlchgCIAEoCVIOY3VzdG9tZXJOdW1iZXISFgoGYW1vdW50GAMgASgBUgZhbW91bnQSJQoOdHJhbnNhY3Rpb25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAUgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYBiABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use payWaterBillResponseDescriptor instead')
const PayWaterBillResponse$json = const {
  '1': 'PayWaterBillResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'receipt_number', '3': 3, '4': 1, '5': 9, '10': 'receiptNumber'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayWaterBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payWaterBillResponseDescriptor = $convert.base64Decode('ChRQYXlXYXRlckJpbGxSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEiUKDnJlY2VpcHRfbnVtYmVyGAMgASgJUg1yZWNlaXB0TnVtYmVyEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use payInternetBillRequestDescriptor instead')
const PayInternetBillRequest$json = const {
  '1': 'PayInternetBillRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'customer_number', '3': 2, '4': 1, '5': 9, '10': 'customerNumber'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'service_type', '3': 4, '4': 1, '5': 9, '10': 'serviceType'},
    const {'1': 'package_id', '3': 5, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayInternetBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInternetBillRequestDescriptor = $convert.base64Decode('ChZQYXlJbnRlcm5ldEJpbGxSZXF1ZXN0Eh8KC3Byb3ZpZGVyX2lkGAEgASgJUgpwcm92aWRlcklkEicKD2N1c3RvbWVyX251bWJlchgCIAEoCVIOY3VzdG9tZXJOdW1iZXISFgoGYW1vdW50GAMgASgBUgZhbW91bnQSIQoMc2VydmljZV90eXBlGAQgASgJUgtzZXJ2aWNlVHlwZRIdCgpwYWNrYWdlX2lkGAUgASgJUglwYWNrYWdlSWQSJQoOdHJhbnNhY3Rpb25faWQYBiABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAcgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYCCABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use payInternetBillResponseDescriptor instead')
const PayInternetBillResponse$json = const {
  '1': 'PayInternetBillResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'renewal_date', '3': 3, '4': 1, '5': 9, '10': 'renewalDate'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayInternetBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInternetBillResponseDescriptor = $convert.base64Decode('ChdQYXlJbnRlcm5ldEJpbGxSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEiEKDHJlbmV3YWxfZGF0ZRgDIAEoCVILcmVuZXdhbERhdGUSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use buyAirtimeRequestDescriptor instead')
const BuyAirtimeRequest$json = const {
  '1': 'BuyAirtimeRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'phone_number', '3': 2, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'airtime_type', '3': 4, '4': 1, '5': 9, '10': 'airtimeType'},
    const {'1': 'data_plan_id', '3': 5, '4': 1, '5': 9, '10': 'dataPlanId'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `BuyAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeRequestDescriptor = $convert.base64Decode('ChFCdXlBaXJ0aW1lUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZBIhCgxwaG9uZV9udW1iZXIYAiABKAlSC3Bob25lTnVtYmVyEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EiEKDGFpcnRpbWVfdHlwZRgEIAEoCVILYWlydGltZVR5cGUSIAoMZGF0YV9wbGFuX2lkGAUgASgJUgpkYXRhUGxhbklkEiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAggASgJUg5pZGVtcG90ZW5jeUtleQ==');
@$core.Deprecated('Use buyAirtimeResponseDescriptor instead')
const BuyAirtimeResponse$json = const {
  '1': 'BuyAirtimeResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'data_info', '3': 4, '4': 1, '5': 9, '10': 'dataInfo'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BuyAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeResponseDescriptor = $convert.base64Decode('ChJCdXlBaXJ0aW1lUmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aWxpdHlwYXltZW50cy5CaWxsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIhCgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEhsKCWRhdGFfaW5mbxgEIAEoCVIIZGF0YUluZm8SGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use barcodePayRequestDescriptor instead')
const BarcodePayRequest$json = const {
  '1': 'BarcodePayRequest',
  '2': const [
    const {'1': 'barcode_data', '3': 1, '4': 1, '5': 9, '10': 'barcodeData'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `BarcodePayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePayRequestDescriptor = $convert.base64Decode('ChFCYXJjb2RlUGF5UmVxdWVzdBIhCgxiYXJjb2RlX2RhdGEYASABKAlSC2JhcmNvZGVEYXRhEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgEIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAUgASgJUg5pZGVtcG90ZW5jeUtleQ==');
@$core.Deprecated('Use barcodePayResponseDescriptor instead')
const BarcodePayResponse$json = const {
  '1': 'BarcodePayResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    const {'1': 'bill_type', '3': 4, '4': 1, '5': 9, '10': 'billType'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `BarcodePayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List barcodePayResponseDescriptor = $convert.base64Decode('ChJCYXJjb2RlUGF5UmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aWxpdHlwYXltZW50cy5CaWxsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIjCg1tZXJjaGFudF9uYW1lGAMgASgJUgxtZXJjaGFudE5hbWUSGwoJYmlsbF90eXBlGAQgASgJUghiaWxsVHlwZRIYCgdtZXNzYWdlGAUgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use scanToPayRequestDescriptor instead')
const ScanToPayRequest$json = const {
  '1': 'ScanToPayRequest',
  '2': const [
    const {'1': 'image_data', '3': 1, '4': 1, '5': 12, '10': 'imageData'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 4, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ScanToPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanToPayRequestDescriptor = $convert.base64Decode('ChBTY2FuVG9QYXlSZXF1ZXN0Eh0KCmltYWdlX2RhdGEYASABKAxSCWltYWdlRGF0YRIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIlCg50cmFuc2FjdGlvbl9pZBgDIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBCABKAlSEXZlcmlmaWNhdGlvblRva2VuEicKD2lkZW1wb3RlbmN5X2tleRgFIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use scanToPayResponseDescriptor instead')
const ScanToPayResponse$json = const {
  '1': 'ScanToPayResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    const {'1': 'bill_type', '3': 4, '4': 1, '5': 9, '10': 'billType'},
    const {'1': 'extracted_amount', '3': 5, '4': 1, '5': 1, '10': 'extractedAmount'},
    const {'1': 'bill_details', '3': 6, '4': 1, '5': 9, '10': 'billDetails'},
    const {'1': 'confidence_score', '3': 7, '4': 1, '5': 9, '10': 'confidenceScore'},
    const {'1': 'message', '3': 8, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ScanToPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanToPayResponseDescriptor = $convert.base64Decode('ChFTY2FuVG9QYXlSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEiMKDW1lcmNoYW50X25hbWUYAyABKAlSDG1lcmNoYW50TmFtZRIbCgliaWxsX3R5cGUYBCABKAlSCGJpbGxUeXBlEikKEGV4dHJhY3RlZF9hbW91bnQYBSABKAFSD2V4dHJhY3RlZEFtb3VudBIhCgxiaWxsX2RldGFpbHMYBiABKAlSC2JpbGxEZXRhaWxzEikKEGNvbmZpZGVuY2Vfc2NvcmUYByABKAlSD2NvbmZpZGVuY2VTY29yZRIYCgdtZXNzYWdlGAggASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getBillPaymentHistoryRequestDescriptor instead')
const GetBillPaymentHistoryRequest$json = const {
  '1': 'GetBillPaymentHistoryRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'bill_type', '3': 2, '4': 1, '5': 9, '10': 'billType'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'start_date', '3': 4, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 5, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'limit', '3': 6, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 7, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetBillPaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillPaymentHistoryRequestDescriptor = $convert.base64Decode('ChxHZXRCaWxsUGF5bWVudEhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIbCgliaWxsX3R5cGUYAiABKAlSCGJpbGxUeXBlEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEh0KCnN0YXJ0X2RhdGUYBCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgFIAEoCVIHZW5kRGF0ZRIUCgVsaW1pdBgGIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAcgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getBillPaymentHistoryResponseDescriptor instead')
const GetBillPaymentHistoryResponse$json = const {
  '1': 'GetBillPaymentHistoryResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payments'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'total_amount', '3': 3, '4': 1, '5': 1, '10': 'totalAmount'},
  ],
};

/// Descriptor for `GetBillPaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillPaymentHistoryResponseDescriptor = $convert.base64Decode('Ch1HZXRCaWxsUGF5bWVudEhpc3RvcnlSZXNwb25zZRI4CghwYXltZW50cxgBIAMoCzIcLnV0aWxpdHlwYXltZW50cy5CaWxsUGF5bWVudFIIcGF5bWVudHMSFAoFdG90YWwYAiABKAVSBXRvdGFsEiEKDHRvdGFsX2Ftb3VudBgDIAEoAVILdG90YWxBbW91bnQ=');
@$core.Deprecated('Use getBillProvidersRequestDescriptor instead')
const GetBillProvidersRequest$json = const {
  '1': 'GetBillProvidersRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'active_only', '3': 2, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetBillProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillProvidersRequestDescriptor = $convert.base64Decode('ChdHZXRCaWxsUHJvdmlkZXJzUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEh8KC2FjdGl2ZV9vbmx5GAIgASgIUgphY3RpdmVPbmx5');
@$core.Deprecated('Use getBillProvidersResponseDescriptor instead')
const GetBillProvidersResponse$json = const {
  '1': 'GetBillProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.BillProvider', '10': 'providers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetBillProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillProvidersResponseDescriptor = $convert.base64Decode('ChhHZXRCaWxsUHJvdmlkZXJzUmVzcG9uc2USOwoJcHJvdmlkZXJzGAEgAygLMh0udXRpbGl0eXBheW1lbnRzLkJpbGxQcm92aWRlclIJcHJvdmlkZXJzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use getAirtimeProvidersRequestDescriptor instead')
const GetAirtimeProvidersRequest$json = const {
  '1': 'GetAirtimeProvidersRequest',
  '2': const [
    const {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetAirtimeProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersRequestDescriptor = $convert.base64Decode('ChpHZXRBaXJ0aW1lUHJvdmlkZXJzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aXZlT25seQ==');
@$core.Deprecated('Use getAirtimeProvidersResponseDescriptor instead')
const GetAirtimeProvidersResponse$json = const {
  '1': 'GetAirtimeProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeProvider', '10': 'providers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAirtimeProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersResponseDescriptor = $convert.base64Decode('ChtHZXRBaXJ0aW1lUHJvdmlkZXJzUmVzcG9uc2USPgoJcHJvdmlkZXJzGAEgAygLMiAudXRpbGl0eXBheW1lbnRzLkFpcnRpbWVQcm92aWRlclIJcHJvdmlkZXJzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use verifyBillRequestDescriptor instead')
const VerifyBillRequest$json = const {
  '1': 'VerifyBillRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'customer_number', '3': 2, '4': 1, '5': 9, '10': 'customerNumber'},
    const {'1': 'bill_type', '3': 3, '4': 1, '5': 9, '10': 'billType'},
  ],
};

/// Descriptor for `VerifyBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBillRequestDescriptor = $convert.base64Decode('ChFWZXJpZnlCaWxsUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZBInCg9jdXN0b21lcl9udW1iZXIYAiABKAlSDmN1c3RvbWVyTnVtYmVyEhsKCWJpbGxfdHlwZRgDIAEoCVIIYmlsbFR5cGU=');
@$core.Deprecated('Use verifyBillResponseDescriptor instead')
const VerifyBillResponse$json = const {
  '1': 'VerifyBillResponse',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'outstanding_amount', '3': 3, '4': 1, '5': 1, '10': 'outstandingAmount'},
    const {'1': 'account_status', '3': 4, '4': 1, '5': 9, '10': 'accountStatus'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `VerifyBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBillResponseDescriptor = $convert.base64Decode('ChJWZXJpZnlCaWxsUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSIwoNY3VzdG9tZXJfbmFtZRgCIAEoCVIMY3VzdG9tZXJOYW1lEi0KEm91dHN0YW5kaW5nX2Ftb3VudBgDIAEoAVIRb3V0c3RhbmRpbmdBbW91bnQSJQoOYWNjb3VudF9zdGF0dXMYBCABKAlSDWFjY291bnRTdGF0dXMSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');
