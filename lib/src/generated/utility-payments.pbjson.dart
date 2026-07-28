// This is a generated file - do not edit.
//
// Generated from utility-payments.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

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
    {'1': 'refund_source', '3': 14, '4': 1, '5': 9, '10': 'refundSource'},
    {'1': 'final_provider', '3': 15, '4': 1, '5': 9, '10': 'finalProvider'},
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
    'bWV0YWRhdGEYDCABKAlSCG1ldGFkYXRhEh0KCmNyZWF0ZWRfYXQYDSABKAlSCWNyZWF0ZWRBdB'
    'IjCg1yZWZ1bmRfc291cmNlGA4gASgJUgxyZWZ1bmRTb3VyY2USJQoOZmluYWxfcHJvdmlkZXIY'
    'DyABKAlSDWZpbmFsUHJvdmlkZXI=');

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
    {'1': 'country_code', '3': 8, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'min_amount', '3': 9, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 10, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'commission_rate', '3': 11, '4': 1, '5': 1, '10': 'commissionRate'},
    {'1': 'operator_id', '3': 12, '4': 1, '5': 9, '10': 'operatorId'},
    {
      '1': 'reloadly_operator_id',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'reloadlyOperatorId'
    },
  ],
};

/// Descriptor for `AirtimeProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeProviderDescriptor = $convert.base64Decode(
    'Cg9BaXJ0aW1lUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGA'
    'oHbmV0d29yaxgDIAEoCVIHbmV0d29yaxIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglp'
    'c19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEiQKDWRlbm9taW5hdGlvbnMYBiADKAlSDWRlbm9taW'
    '5hdGlvbnMSHQoKZGF0YV9wbGFucxgHIAMoCVIJZGF0YVBsYW5zEiEKDGNvdW50cnlfY29kZRgI'
    'IAEoCVILY291bnRyeUNvZGUSHQoKbWluX2Ftb3VudBgJIAEoAVIJbWluQW1vdW50Eh0KCm1heF'
    '9hbW91bnQYCiABKAFSCW1heEFtb3VudBInCg9jb21taXNzaW9uX3JhdGUYCyABKAFSDmNvbW1p'
    'c3Npb25SYXRlEh8KC29wZXJhdG9yX2lkGAwgASgJUgpvcGVyYXRvcklkEjAKFHJlbG9hZGx5X2'
    '9wZXJhdG9yX2lkGA0gASgJUhJyZWxvYWRseU9wZXJhdG9ySWQ=');

@$core.Deprecated('Use payElectricityBillRequestDescriptor instead')
const PayElectricityBillRequest$json = {
  '1': 'PayElectricityBillRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'meter_type', '3': 4, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
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
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
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
    {
      '1': 'verification_token',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
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
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
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
    {
      '1': 'verification_token',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
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
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
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
    {
      '1': 'verification_token',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'country_code', '3': 9, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'operator_id', '3': 10, '4': 1, '5': 9, '10': 'operatorId'},
  ],
};

/// Descriptor for `BuyAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeRequestDescriptor = $convert.base64Decode(
    'ChFCdXlBaXJ0aW1lUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZBIhCg'
    'xwaG9uZV9udW1iZXIYAiABKAlSC3Bob25lTnVtYmVyEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50'
    'EiEKDGFpcnRpbWVfdHlwZRgEIAEoCVILYWlydGltZVR5cGUSIAoMZGF0YV9wbGFuX2lkGAUgAS'
    'gJUgpkYXRhUGxhbklkEiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0K'
    'EnZlcmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdG'
    'VuY3lfa2V5GAggASgJUg5pZGVtcG90ZW5jeUtleRIhCgxjb3VudHJ5X2NvZGUYCSABKAlSC2Nv'
    'dW50cnlDb2RlEh8KC29wZXJhdG9yX2lkGAogASgJUgpvcGVyYXRvcklk');

@$core.Deprecated('Use buyAirtimeResponseDescriptor instead')
const BuyAirtimeResponse$json = {
  '1': 'BuyAirtimeResponse',
  '2': [
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'data_info', '3': 4, '4': 1, '5': 9, '10': 'dataInfo'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'commission_earned',
      '3': 6,
      '4': 1,
      '5': 1,
      '10': 'commissionEarned'
    },
    {
      '1': 'provider_reference',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'providerReference'
    },
  ],
};

/// Descriptor for `BuyAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeResponseDescriptor = $convert.base64Decode(
    'ChJCdXlBaXJ0aW1lUmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aWxpdHlwYXltZW50cy'
    '5CaWxsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIh'
    'CgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEhsKCWRhdGFfaW5mbxgEIAEoCVIIZG'
    'F0YUluZm8SGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZRIrChFjb21taXNzaW9uX2Vhcm5lZBgG'
    'IAEoAVIQY29tbWlzc2lvbkVhcm5lZBItChJwcm92aWRlcl9yZWZlcmVuY2UYByABKAlSEXByb3'
    'ZpZGVyUmVmZXJlbmNl');

@$core.Deprecated('Use barcodePayRequestDescriptor instead')
const BarcodePayRequest$json = {
  '1': 'BarcodePayRequest',
  '2': [
    {'1': 'barcode_data', '3': 1, '4': 1, '5': 9, '10': 'barcodeData'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_id', '3': 3, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
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
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
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
    {
      '1': 'verification_token',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
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
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
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
    {'1': 'bill_type_in', '3': 8, '4': 3, '5': 9, '10': 'billTypeIn'},
  ],
};

/// Descriptor for `GetBillPaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillPaymentHistoryRequestDescriptor = $convert.base64Decode(
    'ChxHZXRCaWxsUGF5bWVudEhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY2'
    '91bnRJZBIbCgliaWxsX3R5cGUYAiABKAlSCGJpbGxUeXBlEhYKBnN0YXR1cxgDIAEoCVIGc3Rh'
    'dHVzEh0KCnN0YXJ0X2RhdGUYBCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgFIAEoCVIHZW'
    '5kRGF0ZRIUCgVsaW1pdBgGIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAcgASgFUgZvZmZzZXQSIAoM'
    'YmlsbF90eXBlX2luGAggAygJUgpiaWxsVHlwZUlu');

@$core.Deprecated('Use getBillPaymentHistoryResponseDescriptor instead')
const GetBillPaymentHistoryResponse$json = {
  '1': 'GetBillPaymentHistoryResponse',
  '2': [
    {
      '1': 'payments',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payments'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'total_amount', '3': 3, '4': 1, '5': 1, '10': 'totalAmount'},
  ],
};

/// Descriptor for `GetBillPaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillPaymentHistoryResponseDescriptor =
    $convert.base64Decode(
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
final $typed_data.Uint8List getBillProvidersRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRCaWxsUHJvdmlkZXJzUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEh8KC2FjdGl2ZV'
        '9vbmx5GAIgASgIUgphY3RpdmVPbmx5');

@$core.Deprecated('Use getBillProvidersResponseDescriptor instead')
const GetBillProvidersResponse$json = {
  '1': 'GetBillProvidersResponse',
  '2': [
    {
      '1': 'providers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.BillProvider',
      '10': 'providers'
    },
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
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetAirtimeProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRBaXJ0aW1lUHJvdmlkZXJzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aX'
        'ZlT25seRIhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2Rl');

@$core.Deprecated('Use getAirtimeProvidersResponseDescriptor instead')
const GetAirtimeProvidersResponse$json = {
  '1': 'GetAirtimeProvidersResponse',
  '2': [
    {
      '1': 'providers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.AirtimeProvider',
      '10': 'providers'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAirtimeProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersResponseDescriptor =
    $convert.base64Decode(
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
    {
      '1': 'outstanding_amount',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'outstandingAmount'
    },
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

@$core.Deprecated('Use cableTVProviderDescriptor instead')
const CableTVProvider$json = {
  '1': 'CableTVProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'service_id', '3': 3, '4': 1, '5': 9, '10': 'serviceId'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'commission_rate', '3': 6, '4': 1, '5': 1, '10': 'commissionRate'},
  ],
};

/// Descriptor for `CableTVProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cableTVProviderDescriptor = $convert.base64Decode(
    'Cg9DYWJsZVRWUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSHQ'
    'oKc2VydmljZV9pZBgDIAEoCVIJc2VydmljZUlkEhkKCGxvZ29fdXJsGAQgASgJUgdsb2dvVXJs'
    'EhsKCWlzX2FjdGl2ZRgFIAEoCFIIaXNBY3RpdmUSJwoPY29tbWlzc2lvbl9yYXRlGAYgASgBUg'
    '5jb21taXNzaW9uUmF0ZQ==');

@$core.Deprecated('Use tVPackageDescriptor instead')
const TVPackage$json = {
  '1': 'TVPackage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'variation_code', '3': 3, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'provider_id', '3': 5, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'validity', '3': 6, '4': 1, '5': 9, '10': 'validity'},
  ],
};

/// Descriptor for `TVPackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tVPackageDescriptor = $convert.base64Decode(
    'CglUVlBhY2thZ2USDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSJQoOdmFyaW'
    'F0aW9uX2NvZGUYAyABKAlSDXZhcmlhdGlvbkNvZGUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQS'
    'HwoLcHJvdmlkZXJfaWQYBSABKAlSCnByb3ZpZGVySWQSGgoIdmFsaWRpdHkYBiABKAlSCHZhbG'
    'lkaXR5');

@$core.Deprecated('Use smartCardValidationDescriptor instead')
const SmartCardValidation$json = {
  '1': 'SmartCardValidation',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'smart_card_number', '3': 3, '4': 1, '5': 9, '10': 'smartCardNumber'},
    {'1': 'current_package', '3': 4, '4': 1, '5': 9, '10': 'currentPackage'},
    {'1': 'renewal_date', '3': 5, '4': 1, '5': 9, '10': 'renewalDate'},
    {'1': 'due_date', '3': 6, '4': 1, '5': 9, '10': 'dueDate'},
  ],
};

/// Descriptor for `SmartCardValidation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smartCardValidationDescriptor = $convert.base64Decode(
    'ChNTbWFydENhcmRWYWxpZGF0aW9uEhkKCGlzX3ZhbGlkGAEgASgIUgdpc1ZhbGlkEiMKDWN1c3'
    'RvbWVyX25hbWUYAiABKAlSDGN1c3RvbWVyTmFtZRIqChFzbWFydF9jYXJkX251bWJlchgDIAEo'
    'CVIPc21hcnRDYXJkTnVtYmVyEicKD2N1cnJlbnRfcGFja2FnZRgEIAEoCVIOY3VycmVudFBhY2'
    'thZ2USIQoMcmVuZXdhbF9kYXRlGAUgASgJUgtyZW5ld2FsRGF0ZRIZCghkdWVfZGF0ZRgGIAEo'
    'CVIHZHVlRGF0ZQ==');

@$core.Deprecated('Use validateSmartCardRequestDescriptor instead')
const ValidateSmartCardRequest$json = {
  '1': 'ValidateSmartCardRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'smart_card_number', '3': 2, '4': 1, '5': 9, '10': 'smartCardNumber'},
  ],
};

/// Descriptor for `ValidateSmartCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateSmartCardRequestDescriptor =
    $convert.base64Decode(
        'ChhWYWxpZGF0ZVNtYXJ0Q2FyZFJlcXVlc3QSHwoLcHJvdmlkZXJfaWQYASABKAlSCnByb3ZpZG'
        'VySWQSKgoRc21hcnRfY2FyZF9udW1iZXIYAiABKAlSD3NtYXJ0Q2FyZE51bWJlcg==');

@$core.Deprecated('Use validateSmartCardResponseDescriptor instead')
const ValidateSmartCardResponse$json = {
  '1': 'ValidateSmartCardResponse',
  '2': [
    {
      '1': 'validation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.SmartCardValidation',
      '10': 'validation'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ValidateSmartCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateSmartCardResponseDescriptor = $convert.base64Decode(
    'ChlWYWxpZGF0ZVNtYXJ0Q2FyZFJlc3BvbnNlEkQKCnZhbGlkYXRpb24YASABKAsyJC51dGlsaX'
    'R5cGF5bWVudHMuU21hcnRDYXJkVmFsaWRhdGlvblIKdmFsaWRhdGlvbhIYCgdtZXNzYWdlGAIg'
    'ASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getTVPackagesRequestDescriptor instead')
const GetTVPackagesRequest$json = {
  '1': 'GetTVPackagesRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
  ],
};

/// Descriptor for `GetTVPackagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTVPackagesRequestDescriptor = $convert.base64Decode(
    'ChRHZXRUVlBhY2thZ2VzUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZA'
    '==');

@$core.Deprecated('Use getTVPackagesResponseDescriptor instead')
const GetTVPackagesResponse$json = {
  '1': 'GetTVPackagesResponse',
  '2': [
    {
      '1': 'packages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.TVPackage',
      '10': 'packages'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetTVPackagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTVPackagesResponseDescriptor = $convert.base64Decode(
    'ChVHZXRUVlBhY2thZ2VzUmVzcG9uc2USNgoIcGFja2FnZXMYASADKAsyGi51dGlsaXR5cGF5bW'
    'VudHMuVFZQYWNrYWdlUghwYWNrYWdlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use payCableTVBillRequestDescriptor instead')
const PayCableTVBillRequest$json = {
  '1': 'PayCableTVBillRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'smart_card_number', '3': 2, '4': 1, '5': 9, '10': 'smartCardNumber'},
    {'1': 'variation_code', '3': 3, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayCableTVBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payCableTVBillRequestDescriptor = $convert.base64Decode(
    'ChVQYXlDYWJsZVRWQmlsbFJlcXVlc3QSHwoLcHJvdmlkZXJfaWQYASABKAlSCnByb3ZpZGVySW'
    'QSKgoRc21hcnRfY2FyZF9udW1iZXIYAiABKAlSD3NtYXJ0Q2FyZE51bWJlchIlCg52YXJpYXRp'
    'b25fY29kZRgDIAEoCVINdmFyaWF0aW9uQ29kZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIUCg'
    'VwaG9uZRgFIAEoCVIFcGhvbmUSJQoOdHJhbnNhY3Rpb25faWQYBiABKAlSDXRyYW5zYWN0aW9u'
    'SWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAcgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZG'
    'VtcG90ZW5jeV9rZXkYCCABKAlSDmlkZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use payCableTVBillResponseDescriptor instead')
const PayCableTVBillResponse$json = {
  '1': 'PayCableTVBillResponse',
  '2': [
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'renewal_date', '3': 3, '4': 1, '5': 9, '10': 'renewalDate'},
    {'1': 'customer_name', '3': 4, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayCableTVBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payCableTVBillResponseDescriptor = $convert.base64Decode(
    'ChZQYXlDYWJsZVRWQmlsbFJlc3BvbnNlEjYKB3BheW1lbnQYASABKAsyHC51dGlsaXR5cGF5bW'
    'VudHMuQmlsbFBheW1lbnRSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFu'
    'Y2USIQoMcmVuZXdhbF9kYXRlGAMgASgJUgtyZW5ld2FsRGF0ZRIjCg1jdXN0b21lcl9uYW1lGA'
    'QgASgJUgxjdXN0b21lck5hbWUSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getCableTVProvidersRequestDescriptor instead')
const GetCableTVProvidersRequest$json = {
  '1': 'GetCableTVProvidersRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetCableTVProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVProvidersRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRDYWJsZVRWUHJvdmlkZXJzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aX'
        'ZlT25seQ==');

@$core.Deprecated('Use getCableTVProvidersResponseDescriptor instead')
const GetCableTVProvidersResponse$json = {
  '1': 'GetCableTVProvidersResponse',
  '2': [
    {
      '1': 'providers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.CableTVProvider',
      '10': 'providers'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetCableTVProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVProvidersResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXRDYWJsZVRWUHJvdmlkZXJzUmVzcG9uc2USPgoJcHJvdmlkZXJzGAEgAygLMiAudXRpbG'
        'l0eXBheW1lbnRzLkNhYmxlVFZQcm92aWRlclIJcHJvdmlkZXJzEhQKBXRvdGFsGAIgASgFUgV0'
        'b3RhbA==');

@$core.Deprecated('Use educationProviderDescriptor instead')
const EducationProvider$json = {
  '1': 'EducationProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'service_id', '3': 3, '4': 1, '5': 9, '10': 'serviceId'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    {'1': 'variation_code', '3': 8, '4': 1, '5': 9, '10': 'variationCode'},
  ],
};

/// Descriptor for `EducationProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List educationProviderDescriptor = $convert.base64Decode(
    'ChFFZHVjYXRpb25Qcm92aWRlchIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZR'
    'IdCgpzZXJ2aWNlX2lkGAMgASgJUglzZXJ2aWNlSWQSGQoIbG9nb191cmwYBCABKAlSB2xvZ29V'
    'cmwSGwoJaXNfYWN0aXZlGAUgASgIUghpc0FjdGl2ZRIWCgZhbW91bnQYBiABKAFSBmFtb3VudB'
    'IgCgtkZXNjcmlwdGlvbhgHIAEoCVILZGVzY3JpcHRpb24SJQoOdmFyaWF0aW9uX2NvZGUYCCAB'
    'KAlSDXZhcmlhdGlvbkNvZGU=');

@$core.Deprecated('Use educationPinResultDescriptor instead')
const EducationPinResult$json = {
  '1': 'EducationPinResult',
  '2': [
    {'1': 'pin', '3': 1, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'serial', '3': 2, '4': 1, '5': 9, '10': 'serial'},
    {'1': 'expires_at', '3': 3, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `EducationPinResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List educationPinResultDescriptor = $convert.base64Decode(
    'ChJFZHVjYXRpb25QaW5SZXN1bHQSEAoDcGluGAEgASgJUgNwaW4SFgoGc2VyaWFsGAIgASgJUg'
    'ZzZXJpYWwSHQoKZXhwaXJlc19hdBgDIAEoCVIJZXhwaXJlc0F0');

@$core.Deprecated('Use purchaseEducationPinRequestDescriptor instead')
const PurchaseEducationPinRequest$json = {
  '1': 'PurchaseEducationPinRequest',
  '2': [
    {'1': 'service_id', '3': 1, '4': 1, '5': 9, '10': 'serviceId'},
    {'1': 'quantity', '3': 2, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'variation_code', '3': 7, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'billers_code', '3': 8, '4': 1, '5': 9, '10': 'billersCode'},
  ],
};

/// Descriptor for `PurchaseEducationPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseEducationPinRequestDescriptor = $convert.base64Decode(
    'ChtQdXJjaGFzZUVkdWNhdGlvblBpblJlcXVlc3QSHQoKc2VydmljZV9pZBgBIAEoCVIJc2Vydm'
    'ljZUlkEhoKCHF1YW50aXR5GAIgASgFUghxdWFudGl0eRIUCgVwaG9uZRgDIAEoCVIFcGhvbmUS'
    'JQoOdHJhbnNhY3Rpb25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3'
    'Rva2VuGAUgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYBiABKAlS'
    'DmlkZW1wb3RlbmN5S2V5EiUKDnZhcmlhdGlvbl9jb2RlGAcgASgJUg12YXJpYXRpb25Db2RlEi'
    'EKDGJpbGxlcnNfY29kZRgIIAEoCVILYmlsbGVyc0NvZGU=');

@$core.Deprecated('Use purchaseEducationPinResponseDescriptor instead')
const PurchaseEducationPinResponse$json = {
  '1': 'PurchaseEducationPinResponse',
  '2': [
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {
      '1': 'pins',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.EducationPinResult',
      '10': 'pins'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PurchaseEducationPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseEducationPinResponseDescriptor = $convert.base64Decode(
    'ChxQdXJjaGFzZUVkdWNhdGlvblBpblJlc3BvbnNlEjYKB3BheW1lbnQYASABKAsyHC51dGlsaX'
    'R5cGF5bWVudHMuQmlsbFBheW1lbnRSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5l'
    'd0JhbGFuY2USNwoEcGlucxgDIAMoCzIjLnV0aWxpdHlwYXltZW50cy5FZHVjYXRpb25QaW5SZX'
    'N1bHRSBHBpbnMSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getEducationProvidersRequestDescriptor instead')
const GetEducationProvidersRequest$json = {
  '1': 'GetEducationProvidersRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetEducationProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationProvidersRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRFZHVjYXRpb25Qcm92aWRlcnNSZXF1ZXN0Eh8KC2FjdGl2ZV9vbmx5GAEgASgIUgphY3'
        'RpdmVPbmx5');

@$core.Deprecated('Use getEducationProvidersResponseDescriptor instead')
const GetEducationProvidersResponse$json = {
  '1': 'GetEducationProvidersResponse',
  '2': [
    {
      '1': 'providers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.EducationProvider',
      '10': 'providers'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetEducationProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationProvidersResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRFZHVjYXRpb25Qcm92aWRlcnNSZXNwb25zZRJACglwcm92aWRlcnMYASADKAsyIi51dG'
        'lsaXR5cGF5bWVudHMuRWR1Y2F0aW9uUHJvdmlkZXJSCXByb3ZpZGVycxIUCgV0b3RhbBgCIAEo'
        'BVIFdG90YWw=');

@$core.Deprecated('Use dataPlanDescriptor instead')
const DataPlan$json = {
  '1': 'DataPlan',
  '2': [
    {'1': 'variation_id', '3': 1, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    {'1': 'network', '3': 4, '4': 1, '5': 9, '10': 'network'},
    {'1': 'availability', '3': 5, '4': 1, '5': 9, '10': 'availability'},
    {'1': 'service_fee', '3': 6, '4': 1, '5': 1, '10': 'serviceFee'},
  ],
};

/// Descriptor for `DataPlan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataPlanDescriptor = $convert.base64Decode(
    'CghEYXRhUGxhbhIhCgx2YXJpYXRpb25faWQYASABKAlSC3ZhcmlhdGlvbklkEhIKBG5hbWUYAi'
    'ABKAlSBG5hbWUSFAoFcHJpY2UYAyABKAFSBXByaWNlEhgKB25ldHdvcmsYBCABKAlSB25ldHdv'
    'cmsSIgoMYXZhaWxhYmlsaXR5GAUgASgJUgxhdmFpbGFiaWxpdHkSHwoLc2VydmljZV9mZWUYBi'
    'ABKAFSCnNlcnZpY2VGZWU=');

@$core.Deprecated('Use getDataPlansRequestDescriptor instead')
const GetDataPlansRequest$json = {
  '1': 'GetDataPlansRequest',
  '2': [
    {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetDataPlansRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataPlansRequestDescriptor =
    $convert.base64Decode(
        'ChNHZXREYXRhUGxhbnNSZXF1ZXN0EhgKB25ldHdvcmsYASABKAlSB25ldHdvcms=');

@$core.Deprecated('Use getDataPlansResponseDescriptor instead')
const GetDataPlansResponse$json = {
  '1': 'GetDataPlansResponse',
  '2': [
    {
      '1': 'plans',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.DataPlan',
      '10': 'plans'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetDataPlansResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataPlansResponseDescriptor = $convert.base64Decode(
    'ChRHZXREYXRhUGxhbnNSZXNwb25zZRIvCgVwbGFucxgBIAMoCzIZLnV0aWxpdHlwYXltZW50cy'
    '5EYXRhUGxhblIFcGxhbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use buyDataRequestDescriptor instead')
const BuyDataRequest$json = {
  '1': 'BuyDataRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    {'1': 'variation_id', '3': 3, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'country_code', '3': 8, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `BuyDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyDataRequestDescriptor = $convert.base64Decode(
    'Cg5CdXlEYXRhUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEhgKB2'
    '5ldHdvcmsYAiABKAlSB25ldHdvcmsSIQoMdmFyaWF0aW9uX2lkGAMgASgJUgt2YXJpYXRpb25J'
    'ZBIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIlCg50cmFuc2FjdGlvbl9pZBgFIAEoCVINdHJhbn'
    'NhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBiABKAlSEXZlcmlmaWNhdGlvblRva2Vu'
    'EicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVuY3lLZXkSIQoMY291bnRyeV9jb2'
    'RlGAggASgJUgtjb3VudHJ5Q29kZQ==');

@$core.Deprecated('Use buyDataResponseDescriptor instead')
const BuyDataResponse$json = {
  '1': 'BuyDataResponse',
  '2': [
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'data_plan', '3': 4, '4': 1, '5': 9, '10': 'dataPlan'},
    {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'commission_earned',
      '3': 6,
      '4': 1,
      '5': 1,
      '10': 'commissionEarned'
    },
    {
      '1': 'provider_reference',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'providerReference'
    },
  ],
};

/// Descriptor for `BuyDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyDataResponseDescriptor = $convert.base64Decode(
    'Cg9CdXlEYXRhUmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aWxpdHlwYXltZW50cy5CaW'
    'xsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIhCgxw'
    'aG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEhsKCWRhdGFfcGxhbhgEIAEoCVIIZGF0YV'
    'BsYW4SGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZRIrChFjb21taXNzaW9uX2Vhcm5lZBgGIAEo'
    'AVIQY29tbWlzc2lvbkVhcm5lZBItChJwcm92aWRlcl9yZWZlcmVuY2UYByABKAlSEXByb3ZpZG'
    'VyUmVmZXJlbmNl');

@$core.Deprecated('Use internetProviderDescriptor instead')
const InternetProvider$json = {
  '1': 'InternetProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'service_id', '3': 3, '4': 1, '5': 9, '10': 'serviceId'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'commission_rate', '3': 6, '4': 1, '5': 1, '10': 'commissionRate'},
  ],
};

/// Descriptor for `InternetProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetProviderDescriptor = $convert.base64Decode(
    'ChBJbnRlcm5ldFByb3ZpZGVyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh'
    '0KCnNlcnZpY2VfaWQYAyABKAlSCXNlcnZpY2VJZBIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1Vy'
    'bBIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEicKD2NvbW1pc3Npb25fcmF0ZRgGIAEoAV'
    'IOY29tbWlzc2lvblJhdGU=');

@$core.Deprecated('Use internetPackageDescriptor instead')
const InternetPackage$json = {
  '1': 'InternetPackage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'variation_code', '3': 3, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'provider_id', '3': 5, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'validity', '3': 6, '4': 1, '5': 9, '10': 'validity'},
  ],
};

/// Descriptor for `InternetPackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetPackageDescriptor = $convert.base64Decode(
    'Cg9JbnRlcm5ldFBhY2thZ2USDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSJQ'
    'oOdmFyaWF0aW9uX2NvZGUYAyABKAlSDXZhcmlhdGlvbkNvZGUSFgoGYW1vdW50GAQgASgBUgZh'
    'bW91bnQSHwoLcHJvdmlkZXJfaWQYBSABKAlSCnByb3ZpZGVySWQSGgoIdmFsaWRpdHkYBiABKA'
    'lSCHZhbGlkaXR5');

@$core.Deprecated('Use internetAccountValidationDescriptor instead')
const InternetAccountValidation$json = {
  '1': 'InternetAccountValidation',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'due_amount', '3': 5, '4': 1, '5': 1, '10': 'dueAmount'},
  ],
};

/// Descriptor for `InternetAccountValidation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetAccountValidationDescriptor = $convert.base64Decode(
    'ChlJbnRlcm5ldEFjY291bnRWYWxpZGF0aW9uEhkKCGlzX3ZhbGlkGAEgASgIUgdpc1ZhbGlkEi'
    'MKDWN1c3RvbWVyX25hbWUYAiABKAlSDGN1c3RvbWVyTmFtZRIlCg5hY2NvdW50X251bWJlchgD'
    'IAEoCVINYWNjb3VudE51bWJlchIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxIdCgpkdWVfYW1vdW'
    '50GAUgASgBUglkdWVBbW91bnQ=');

@$core.Deprecated('Use getInternetProvidersRequestDescriptor instead')
const GetInternetProvidersRequest$json = {
  '1': 'GetInternetProvidersRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetInternetProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetProvidersRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRJbnRlcm5ldFByb3ZpZGVyc1JlcXVlc3QSHwoLYWN0aXZlX29ubHkYASABKAhSCmFjdG'
        'l2ZU9ubHk=');

@$core.Deprecated('Use getInternetProvidersResponseDescriptor instead')
const GetInternetProvidersResponse$json = {
  '1': 'GetInternetProvidersResponse',
  '2': [
    {
      '1': 'providers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.InternetProvider',
      '10': 'providers'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInternetProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetProvidersResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXRJbnRlcm5ldFByb3ZpZGVyc1Jlc3BvbnNlEj8KCXByb3ZpZGVycxgBIAMoCzIhLnV0aW'
        'xpdHlwYXltZW50cy5JbnRlcm5ldFByb3ZpZGVyUglwcm92aWRlcnMSFAoFdG90YWwYAiABKAVS'
        'BXRvdGFs');

@$core.Deprecated('Use validateInternetAccountRequestDescriptor instead')
const ValidateInternetAccountRequest$json = {
  '1': 'ValidateInternetAccountRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `ValidateInternetAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInternetAccountRequestDescriptor =
    $convert.base64Decode(
        'Ch5WYWxpZGF0ZUludGVybmV0QWNjb3VudFJlcXVlc3QSHwoLcHJvdmlkZXJfaWQYASABKAlSCn'
        'Byb3ZpZGVySWQSJQoOYWNjb3VudF9udW1iZXIYAiABKAlSDWFjY291bnROdW1iZXI=');

@$core.Deprecated('Use validateInternetAccountResponseDescriptor instead')
const ValidateInternetAccountResponse$json = {
  '1': 'ValidateInternetAccountResponse',
  '2': [
    {
      '1': 'validation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.InternetAccountValidation',
      '10': 'validation'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ValidateInternetAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInternetAccountResponseDescriptor =
    $convert.base64Decode(
        'Ch9WYWxpZGF0ZUludGVybmV0QWNjb3VudFJlc3BvbnNlEkoKCnZhbGlkYXRpb24YASABKAsyKi'
        '51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRBY2NvdW50VmFsaWRhdGlvblIKdmFsaWRhdGlvbhIY'
        'CgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getInternetPackagesRequestDescriptor instead')
const GetInternetPackagesRequest$json = {
  '1': 'GetInternetPackagesRequest',
  '2': [
    {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
  ],
};

/// Descriptor for `GetInternetPackagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetPackagesRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRJbnRlcm5ldFBhY2thZ2VzUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdm'
        'lkZXJJZA==');

@$core.Deprecated('Use getInternetPackagesResponseDescriptor instead')
const GetInternetPackagesResponse$json = {
  '1': 'GetInternetPackagesResponse',
  '2': [
    {
      '1': 'packages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.InternetPackage',
      '10': 'packages'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInternetPackagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetPackagesResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXRJbnRlcm5ldFBhY2thZ2VzUmVzcG9uc2USPAoIcGFja2FnZXMYASADKAsyIC51dGlsaX'
        'R5cGF5bWVudHMuSW50ZXJuZXRQYWNrYWdlUghwYWNrYWdlcxIUCgV0b3RhbBgCIAEoBVIFdG90'
        'YWw=');

@$core.Deprecated('Use activeSubscriptionDescriptor instead')
const ActiveSubscription$json = {
  '1': 'ActiveSubscription',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'subscription_type',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'subscriptionType'
    },
    {'1': 'provider_id', '3': 3, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'plan_name', '3': 5, '4': 1, '5': 9, '10': 'planName'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'customer_number', '3': 8, '4': 1, '5': 9, '10': 'customerNumber'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    {'1': 'purchased_at', '3': 10, '4': 1, '5': 9, '10': 'purchasedAt'},
    {'1': 'expires_at', '3': 11, '4': 1, '5': 9, '10': 'expiresAt'},
    {'1': 'validity_days', '3': 12, '4': 1, '5': 5, '10': 'validityDays'},
    {'1': 'renewal_date', '3': 13, '4': 1, '5': 9, '10': 'renewalDate'},
    {'1': 'token', '3': 14, '4': 1, '5': 9, '10': 'token'},
    {'1': 'units', '3': 15, '4': 1, '5': 1, '10': 'units'},
    {
      '1': 'progress_percentage',
      '3': 16,
      '4': 1,
      '5': 1,
      '10': 'progressPercentage'
    },
    {'1': 'days_remaining', '3': 17, '4': 1, '5': 5, '10': 'daysRemaining'},
    {
      '1': 'payment_reference',
      '3': 18,
      '4': 1,
      '5': 9,
      '10': 'paymentReference'
    },
    {
      '1': 'auto_renew_enabled',
      '3': 19,
      '4': 1,
      '5': 8,
      '10': 'autoRenewEnabled'
    },
    {
      '1': 'auto_renew_variation_id',
      '3': 20,
      '4': 1,
      '5': 9,
      '10': 'autoRenewVariationId'
    },
    {
      '1': 'auto_renew_network',
      '3': 21,
      '4': 1,
      '5': 9,
      '10': 'autoRenewNetwork'
    },
    {
      '1': 'auto_renew_amount',
      '3': 22,
      '4': 1,
      '5': 1,
      '10': 'autoRenewAmount'
    },
    {'1': 'renewal_attempts', '3': 23, '4': 1, '5': 5, '10': 'renewalAttempts'},
    {'1': 'next_renewal_at', '3': 24, '4': 1, '5': 9, '10': 'nextRenewalAt'},
    {
      '1': 'auto_renew_disabled_reason',
      '3': 25,
      '4': 1,
      '5': 9,
      '10': 'autoRenewDisabledReason'
    },
  ],
};

/// Descriptor for `ActiveSubscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activeSubscriptionDescriptor = $convert.base64Decode(
    'ChJBY3RpdmVTdWJzY3JpcHRpb24SDgoCaWQYASABKAlSAmlkEisKEXN1YnNjcmlwdGlvbl90eX'
    'BlGAIgASgJUhBzdWJzY3JpcHRpb25UeXBlEh8KC3Byb3ZpZGVyX2lkGAMgASgJUgpwcm92aWRl'
    'cklkEiMKDXByb3ZpZGVyX25hbWUYBCABKAlSDHByb3ZpZGVyTmFtZRIbCglwbGFuX25hbWUYBS'
    'ABKAlSCHBsYW5OYW1lEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAcgASgJ'
    'UghjdXJyZW5jeRInCg9jdXN0b21lcl9udW1iZXIYCCABKAlSDmN1c3RvbWVyTnVtYmVyEhYKBn'
    'N0YXR1cxgJIAEoCVIGc3RhdHVzEiEKDHB1cmNoYXNlZF9hdBgKIAEoCVILcHVyY2hhc2VkQXQS'
    'HQoKZXhwaXJlc19hdBgLIAEoCVIJZXhwaXJlc0F0EiMKDXZhbGlkaXR5X2RheXMYDCABKAVSDH'
    'ZhbGlkaXR5RGF5cxIhCgxyZW5ld2FsX2RhdGUYDSABKAlSC3JlbmV3YWxEYXRlEhQKBXRva2Vu'
    'GA4gASgJUgV0b2tlbhIUCgV1bml0cxgPIAEoAVIFdW5pdHMSLwoTcHJvZ3Jlc3NfcGVyY2VudG'
    'FnZRgQIAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdlEiUKDmRheXNfcmVtYWluaW5nGBEgASgFUg1k'
    'YXlzUmVtYWluaW5nEisKEXBheW1lbnRfcmVmZXJlbmNlGBIgASgJUhBwYXltZW50UmVmZXJlbm'
    'NlEiwKEmF1dG9fcmVuZXdfZW5hYmxlZBgTIAEoCFIQYXV0b1JlbmV3RW5hYmxlZBI1ChdhdXRv'
    'X3JlbmV3X3ZhcmlhdGlvbl9pZBgUIAEoCVIUYXV0b1JlbmV3VmFyaWF0aW9uSWQSLAoSYXV0b1'
    '9yZW5ld19uZXR3b3JrGBUgASgJUhBhdXRvUmVuZXdOZXR3b3JrEioKEWF1dG9fcmVuZXdfYW1v'
    'dW50GBYgASgBUg9hdXRvUmVuZXdBbW91bnQSKQoQcmVuZXdhbF9hdHRlbXB0cxgXIAEoBVIPcm'
    'VuZXdhbEF0dGVtcHRzEiYKD25leHRfcmVuZXdhbF9hdBgYIAEoCVINbmV4dFJlbmV3YWxBdBI7'
    'ChphdXRvX3JlbmV3X2Rpc2FibGVkX3JlYXNvbhgZIAEoCVIXYXV0b1JlbmV3RGlzYWJsZWRSZW'
    'Fzb24=');

@$core.Deprecated('Use getActiveSubscriptionsRequestDescriptor instead')
const GetActiveSubscriptionsRequest$json = {
  '1': 'GetActiveSubscriptionsRequest',
  '2': [
    {
      '1': 'subscription_type',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'subscriptionType'
    },
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetActiveSubscriptionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveSubscriptionsRequestDescriptor =
    $convert.base64Decode(
        'Ch1HZXRBY3RpdmVTdWJzY3JpcHRpb25zUmVxdWVzdBIrChFzdWJzY3JpcHRpb25fdHlwZRgBIA'
        'EoCVIQc3Vic2NyaXB0aW9uVHlwZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMg'
        'ASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getActiveSubscriptionsResponseDescriptor instead')
const GetActiveSubscriptionsResponse$json = {
  '1': 'GetActiveSubscriptionsResponse',
  '2': [
    {
      '1': 'subscriptions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.ActiveSubscription',
      '10': 'subscriptions'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetActiveSubscriptionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveSubscriptionsResponseDescriptor =
    $convert.base64Decode(
        'Ch5HZXRBY3RpdmVTdWJzY3JpcHRpb25zUmVzcG9uc2USSQoNc3Vic2NyaXB0aW9ucxgBIAMoCz'
        'IjLnV0aWxpdHlwYXltZW50cy5BY3RpdmVTdWJzY3JpcHRpb25SDXN1YnNjcmlwdGlvbnMSFAoF'
        'dG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use subscriptionTypeSummaryDescriptor instead')
const SubscriptionTypeSummary$json = {
  '1': 'SubscriptionTypeSummary',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    {'1': 'total_spend', '3': 3, '4': 1, '5': 1, '10': 'totalSpend'},
  ],
};

/// Descriptor for `SubscriptionTypeSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscriptionTypeSummaryDescriptor =
    $convert.base64Decode(
        'ChdTdWJzY3JpcHRpb25UeXBlU3VtbWFyeRISCgR0eXBlGAEgASgJUgR0eXBlEhQKBWNvdW50GA'
        'IgASgFUgVjb3VudBIfCgt0b3RhbF9zcGVuZBgDIAEoAVIKdG90YWxTcGVuZA==');

@$core.Deprecated('Use getSubscriptionSummaryRequestDescriptor instead')
const GetSubscriptionSummaryRequest$json = {
  '1': 'GetSubscriptionSummaryRequest',
};

/// Descriptor for `GetSubscriptionSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionSummaryRequestDescriptor =
    $convert.base64Decode('Ch1HZXRTdWJzY3JpcHRpb25TdW1tYXJ5UmVxdWVzdA==');

@$core.Deprecated('Use getSubscriptionSummaryResponseDescriptor instead')
const GetSubscriptionSummaryResponse$json = {
  '1': 'GetSubscriptionSummaryResponse',
  '2': [
    {'1': 'active_count', '3': 1, '4': 1, '5': 5, '10': 'activeCount'},
    {'1': 'expiring_count', '3': 2, '4': 1, '5': 5, '10': 'expiringCount'},
    {
      '1': 'total_monthly_spend',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'totalMonthlySpend'
    },
    {
      '1': 'by_type',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.SubscriptionTypeSummary',
      '10': 'byType'
    },
  ],
};

/// Descriptor for `GetSubscriptionSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionSummaryResponseDescriptor = $convert.base64Decode(
    'Ch5HZXRTdWJzY3JpcHRpb25TdW1tYXJ5UmVzcG9uc2USIQoMYWN0aXZlX2NvdW50GAEgASgFUg'
    'thY3RpdmVDb3VudBIlCg5leHBpcmluZ19jb3VudBgCIAEoBVINZXhwaXJpbmdDb3VudBIuChN0'
    'b3RhbF9tb250aGx5X3NwZW5kGAMgASgBUhF0b3RhbE1vbnRobHlTcGVuZBJBCgdieV90eXBlGA'
    'QgAygLMigudXRpbGl0eXBheW1lbnRzLlN1YnNjcmlwdGlvblR5cGVTdW1tYXJ5UgZieVR5cGU=');

@$core.Deprecated('Use monthlySubscriptionSpendingDescriptor instead')
const MonthlySubscriptionSpending$json = {
  '1': 'MonthlySubscriptionSpending',
  '2': [
    {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    {'1': 'total', '3': 2, '4': 1, '5': 1, '10': 'total'},
  ],
};

/// Descriptor for `MonthlySubscriptionSpending`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monthlySubscriptionSpendingDescriptor =
    $convert.base64Decode(
        'ChtNb250aGx5U3Vic2NyaXB0aW9uU3BlbmRpbmcSFAoFbW9udGgYASABKAlSBW1vbnRoEhQKBX'
        'RvdGFsGAIgASgBUgV0b3RhbA==');

@$core.Deprecated('Use getSubscriptionSpendingRequestDescriptor instead')
const GetSubscriptionSpendingRequest$json = {
  '1': 'GetSubscriptionSpendingRequest',
  '2': [
    {'1': 'months', '3': 1, '4': 1, '5': 5, '10': 'months'},
  ],
};

/// Descriptor for `GetSubscriptionSpendingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionSpendingRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRTdWJzY3JpcHRpb25TcGVuZGluZ1JlcXVlc3QSFgoGbW9udGhzGAEgASgFUgZtb250aH'
        'M=');

@$core.Deprecated('Use getSubscriptionSpendingResponseDescriptor instead')
const GetSubscriptionSpendingResponse$json = {
  '1': 'GetSubscriptionSpendingResponse',
  '2': [
    {'1': 'total_all_time', '3': 1, '4': 1, '5': 1, '10': 'totalAllTime'},
    {'1': 'total_this_month', '3': 2, '4': 1, '5': 1, '10': 'totalThisMonth'},
    {
      '1': 'by_type',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.GetSubscriptionSpendingResponse.ByTypeEntry',
      '10': 'byType'
    },
    {
      '1': 'monthly_trend',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.MonthlySubscriptionSpending',
      '10': 'monthlyTrend'
    },
  ],
  '3': [GetSubscriptionSpendingResponse_ByTypeEntry$json],
};

@$core.Deprecated('Use getSubscriptionSpendingResponseDescriptor instead')
const GetSubscriptionSpendingResponse_ByTypeEntry$json = {
  '1': 'ByTypeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetSubscriptionSpendingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionSpendingResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRTdWJzY3JpcHRpb25TcGVuZGluZ1Jlc3BvbnNlEiQKDnRvdGFsX2FsbF90aW1lGAEgAS'
    'gBUgx0b3RhbEFsbFRpbWUSKAoQdG90YWxfdGhpc19tb250aBgCIAEoAVIOdG90YWxUaGlzTW9u'
    'dGgSVQoHYnlfdHlwZRgDIAMoCzI8LnV0aWxpdHlwYXltZW50cy5HZXRTdWJzY3JpcHRpb25TcG'
    'VuZGluZ1Jlc3BvbnNlLkJ5VHlwZUVudHJ5UgZieVR5cGUSUQoNbW9udGhseV90cmVuZBgEIAMo'
    'CzIsLnV0aWxpdHlwYXltZW50cy5Nb250aGx5U3Vic2NyaXB0aW9uU3BlbmRpbmdSDG1vbnRobH'
    'lUcmVuZBo5CgtCeVR5cGVFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoAVIF'
    'dmFsdWU6AjgB');

@$core.Deprecated('Use enableAutoRenewRequestDescriptor instead')
const EnableAutoRenewRequest$json = {
  '1': 'EnableAutoRenewRequest',
  '2': [
    {'1': 'subscription_id', '3': 1, '4': 1, '5': 9, '10': 'subscriptionId'},
    {'1': 'variation_id', '3': 2, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `EnableAutoRenewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableAutoRenewRequestDescriptor = $convert.base64Decode(
    'ChZFbmFibGVBdXRvUmVuZXdSZXF1ZXN0EicKD3N1YnNjcmlwdGlvbl9pZBgBIAEoCVIOc3Vic2'
    'NyaXB0aW9uSWQSIQoMdmFyaWF0aW9uX2lkGAIgASgJUgt2YXJpYXRpb25JZBIYCgduZXR3b3Jr'
    'GAMgASgJUgduZXR3b3JrEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50');

@$core.Deprecated('Use enableAutoRenewResponseDescriptor instead')
const EnableAutoRenewResponse$json = {
  '1': 'EnableAutoRenewResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'subscription',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.ActiveSubscription',
      '10': 'subscription'
    },
  ],
};

/// Descriptor for `EnableAutoRenewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableAutoRenewResponseDescriptor = $convert.base64Decode(
    'ChdFbmFibGVBdXRvUmVuZXdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2USRwoMc3Vic2NyaXB0aW9uGAMgASgLMiMudXRpbGl0eXBh'
    'eW1lbnRzLkFjdGl2ZVN1YnNjcmlwdGlvblIMc3Vic2NyaXB0aW9u');

@$core.Deprecated('Use disableAutoRenewRequestDescriptor instead')
const DisableAutoRenewRequest$json = {
  '1': 'DisableAutoRenewRequest',
  '2': [
    {'1': 'subscription_id', '3': 1, '4': 1, '5': 9, '10': 'subscriptionId'},
  ],
};

/// Descriptor for `DisableAutoRenewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableAutoRenewRequestDescriptor =
    $convert.base64Decode(
        'ChdEaXNhYmxlQXV0b1JlbmV3UmVxdWVzdBInCg9zdWJzY3JpcHRpb25faWQYASABKAlSDnN1Yn'
        'NjcmlwdGlvbklk');

@$core.Deprecated('Use disableAutoRenewResponseDescriptor instead')
const DisableAutoRenewResponse$json = {
  '1': 'DisableAutoRenewResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DisableAutoRenewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableAutoRenewResponseDescriptor =
    $convert.base64Decode(
        'ChhEaXNhYmxlQXV0b1JlbmV3UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCg'
        'dtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getAutoRenewSubscriptionsRequestDescriptor instead')
const GetAutoRenewSubscriptionsRequest$json = {
  '1': 'GetAutoRenewSubscriptionsRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAutoRenewSubscriptionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoRenewSubscriptionsRequestDescriptor =
    $convert.base64Decode(
        'CiBHZXRBdXRvUmVuZXdTdWJzY3JpcHRpb25zUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaX'
        'QSFgoGb2Zmc2V0GAIgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getAutoRenewSubscriptionsResponseDescriptor instead')
const GetAutoRenewSubscriptionsResponse$json = {
  '1': 'GetAutoRenewSubscriptionsResponse',
  '2': [
    {
      '1': 'subscriptions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.ActiveSubscription',
      '10': 'subscriptions'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAutoRenewSubscriptionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoRenewSubscriptionsResponseDescriptor =
    $convert.base64Decode(
        'CiFHZXRBdXRvUmVuZXdTdWJzY3JpcHRpb25zUmVzcG9uc2USSQoNc3Vic2NyaXB0aW9ucxgBIA'
        'MoCzIjLnV0aWxpdHlwYXltZW50cy5BY3RpdmVTdWJzY3JpcHRpb25SDXN1YnNjcmlwdGlvbnMS'
        'FAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use updateAutoRenewPlanRequestDescriptor instead')
const UpdateAutoRenewPlanRequest$json = {
  '1': 'UpdateAutoRenewPlanRequest',
  '2': [
    {'1': 'subscription_id', '3': 1, '4': 1, '5': 9, '10': 'subscriptionId'},
    {'1': 'new_variation_id', '3': 2, '4': 1, '5': 9, '10': 'newVariationId'},
    {'1': 'new_amount', '3': 3, '4': 1, '5': 1, '10': 'newAmount'},
  ],
};

/// Descriptor for `UpdateAutoRenewPlanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoRenewPlanRequestDescriptor =
    $convert.base64Decode(
        'ChpVcGRhdGVBdXRvUmVuZXdQbGFuUmVxdWVzdBInCg9zdWJzY3JpcHRpb25faWQYASABKAlSDn'
        'N1YnNjcmlwdGlvbklkEigKEG5ld192YXJpYXRpb25faWQYAiABKAlSDm5ld1ZhcmlhdGlvbklk'
        'Eh0KCm5ld19hbW91bnQYAyABKAFSCW5ld0Ftb3VudA==');

@$core.Deprecated('Use updateAutoRenewPlanResponseDescriptor instead')
const UpdateAutoRenewPlanResponse$json = {
  '1': 'UpdateAutoRenewPlanResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'subscription',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.ActiveSubscription',
      '10': 'subscription'
    },
  ],
};

/// Descriptor for `UpdateAutoRenewPlanResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoRenewPlanResponseDescriptor =
    $convert.base64Decode(
        'ChtVcGRhdGVBdXRvUmVuZXdQbGFuUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
        'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEkcKDHN1YnNjcmlwdGlvbhgDIAEoCzIjLnV0aWxp'
        'dHlwYXltZW50cy5BY3RpdmVTdWJzY3JpcHRpb25SDHN1YnNjcmlwdGlvbg==');

@$core.Deprecated('Use airtimeToCashNetworkRateDescriptor instead')
const AirtimeToCashNetworkRate$json = {
  '1': 'AirtimeToCashNetworkRate',
  '2': [
    {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
    {'1': 'conversion_rate', '3': 2, '4': 1, '5': 1, '10': 'conversionRate'},
    {'1': 'min_amount', '3': 3, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 4, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'automation_fee', '3': 5, '4': 1, '5': 1, '10': 'automationFee'},
    {'1': 'is_available', '3': 6, '4': 1, '5': 8, '10': 'isAvailable'},
  ],
};

/// Descriptor for `AirtimeToCashNetworkRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeToCashNetworkRateDescriptor = $convert.base64Decode(
    'ChhBaXJ0aW1lVG9DYXNoTmV0d29ya1JhdGUSGAoHbmV0d29yaxgBIAEoCVIHbmV0d29yaxInCg'
    '9jb252ZXJzaW9uX3JhdGUYAiABKAFSDmNvbnZlcnNpb25SYXRlEh0KCm1pbl9hbW91bnQYAyAB'
    'KAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAQgASgBUgltYXhBbW91bnQSJQoOYXV0b21hdG'
    'lvbl9mZWUYBSABKAFSDWF1dG9tYXRpb25GZWUSIQoMaXNfYXZhaWxhYmxlGAYgASgIUgtpc0F2'
    'YWlsYWJsZQ==');

@$core.Deprecated('Use getAirtimeToCashRatesRequestDescriptor instead')
const GetAirtimeToCashRatesRequest$json = {
  '1': 'GetAirtimeToCashRatesRequest',
};

/// Descriptor for `GetAirtimeToCashRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashRatesRequestDescriptor =
    $convert.base64Decode('ChxHZXRBaXJ0aW1lVG9DYXNoUmF0ZXNSZXF1ZXN0');

@$core.Deprecated('Use getAirtimeToCashRatesResponseDescriptor instead')
const GetAirtimeToCashRatesResponse$json = {
  '1': 'GetAirtimeToCashRatesResponse',
  '2': [
    {
      '1': 'rates',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.AirtimeToCashNetworkRate',
      '10': 'rates'
    },
  ],
};

/// Descriptor for `GetAirtimeToCashRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashRatesResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRBaXJ0aW1lVG9DYXNoUmF0ZXNSZXNwb25zZRI/CgVyYXRlcxgBIAMoCzIpLnV0aWxpdH'
        'lwYXltZW50cy5BaXJ0aW1lVG9DYXNoTmV0d29ya1JhdGVSBXJhdGVz');

@$core.Deprecated('Use requestAirtimeToCashOTPRequestDescriptor instead')
const RequestAirtimeToCashOTPRequest$json = {
  '1': 'RequestAirtimeToCashOTPRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `RequestAirtimeToCashOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAirtimeToCashOTPRequestDescriptor =
    $convert.base64Decode(
        'Ch5SZXF1ZXN0QWlydGltZVRvQ2FzaE9UUFJlcXVlc3QSIQoMcGhvbmVfbnVtYmVyGAEgASgJUg'
        'twaG9uZU51bWJlchIYCgduZXR3b3JrGAIgASgJUgduZXR3b3Jr');

@$core.Deprecated('Use requestAirtimeToCashOTPResponseDescriptor instead')
const RequestAirtimeToCashOTPResponse$json = {
  '1': 'RequestAirtimeToCashOTPResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'session_id', '3': 3, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'otp_required', '3': 4, '4': 1, '5': 8, '10': 'otpRequired'},
    {
      '1': 'destination_phone',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'destinationPhone'
    },
    {'1': 'provider_name', '3': 6, '4': 1, '5': 9, '10': 'providerName'},
  ],
};

/// Descriptor for `RequestAirtimeToCashOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAirtimeToCashOTPResponseDescriptor = $convert.base64Decode(
    'Ch9SZXF1ZXN0QWlydGltZVRvQ2FzaE9UUFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2'
    'Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIdCgpzZXNzaW9uX2lkGAMgASgJUglzZXNz'
    'aW9uSWQSIQoMb3RwX3JlcXVpcmVkGAQgASgIUgtvdHBSZXF1aXJlZBIrChFkZXN0aW5hdGlvbl'
    '9waG9uZRgFIAEoCVIQZGVzdGluYXRpb25QaG9uZRIjCg1wcm92aWRlcl9uYW1lGAYgASgJUgxw'
    'cm92aWRlck5hbWU=');

@$core.Deprecated('Use verifyAirtimeToCashOTPRequestDescriptor instead')
const VerifyAirtimeToCashOTPRequest$json = {
  '1': 'VerifyAirtimeToCashOTPRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    {'1': 'otp', '3': 3, '4': 1, '5': 9, '10': 'otp'},
    {'1': 'session_id', '3': 4, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `VerifyAirtimeToCashOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAirtimeToCashOTPRequestDescriptor =
    $convert.base64Decode(
        'Ch1WZXJpZnlBaXJ0aW1lVG9DYXNoT1RQUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3'
        'Bob25lTnVtYmVyEhgKB25ldHdvcmsYAiABKAlSB25ldHdvcmsSEAoDb3RwGAMgASgJUgNvdHAS'
        'HQoKc2Vzc2lvbl9pZBgEIAEoCVIJc2Vzc2lvbklk');

@$core.Deprecated('Use verifyAirtimeToCashOTPResponseDescriptor instead')
const VerifyAirtimeToCashOTPResponse$json = {
  '1': 'VerifyAirtimeToCashOTPResponse',
  '2': [
    {'1': 'verified', '3': 1, '4': 1, '5': 8, '10': 'verified'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'session_token', '3': 3, '4': 1, '5': 9, '10': 'sessionToken'},
    {'1': 'session_id', '3': 4, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `VerifyAirtimeToCashOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAirtimeToCashOTPResponseDescriptor =
    $convert.base64Decode(
        'Ch5WZXJpZnlBaXJ0aW1lVG9DYXNoT1RQUmVzcG9uc2USGgoIdmVyaWZpZWQYASABKAhSCHZlcm'
        'lmaWVkEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoNc2Vzc2lvbl90b2tlbhgDIAEoCVIM'
        'c2Vzc2lvblRva2VuEh0KCnNlc3Npb25faWQYBCABKAlSCXNlc3Npb25JZA==');

@$core.Deprecated('Use convertAirtimeToCashRequestDescriptor instead')
const ConvertAirtimeToCashRequest$json = {
  '1': 'ConvertAirtimeToCashRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'session_token', '3': 4, '4': 1, '5': 9, '10': 'sessionToken'},
    {'1': 'session_id', '3': 5, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'pin', '3': 6, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ConvertAirtimeToCashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertAirtimeToCashRequestDescriptor = $convert.base64Decode(
    'ChtDb252ZXJ0QWlydGltZVRvQ2FzaFJlcXVlc3QSIQoMcGhvbmVfbnVtYmVyGAEgASgJUgtwaG'
    '9uZU51bWJlchIYCgduZXR3b3JrGAIgASgJUgduZXR3b3JrEhYKBmFtb3VudBgDIAEoAVIGYW1v'
    'dW50EiMKDXNlc3Npb25fdG9rZW4YBCABKAlSDHNlc3Npb25Ub2tlbhIdCgpzZXNzaW9uX2lkGA'
    'UgASgJUglzZXNzaW9uSWQSEAoDcGluGAYgASgJUgNwaW4SJQoOdHJhbnNhY3Rpb25faWQYByAB'
    'KAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAggASgJUhF2ZXJpZmljYX'
    'Rpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2V5');

@$core.Deprecated('Use convertAirtimeToCashResponseDescriptor instead')
const ConvertAirtimeToCashResponse$json = {
  '1': 'ConvertAirtimeToCashResponse',
  '2': [
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
    {'1': 'cash_amount', '3': 2, '4': 1, '5': 1, '10': 'cashAmount'},
    {'1': 'conversion_rate', '3': 3, '4': 1, '5': 1, '10': 'conversionRate'},
    {'1': 'fee', '3': 4, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'new_balance', '3': 5, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ConvertAirtimeToCashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertAirtimeToCashResponseDescriptor = $convert.base64Decode(
    'ChxDb252ZXJ0QWlydGltZVRvQ2FzaFJlc3BvbnNlEjYKB3BheW1lbnQYASABKAsyHC51dGlsaX'
    'R5cGF5bWVudHMuQmlsbFBheW1lbnRSB3BheW1lbnQSHwoLY2FzaF9hbW91bnQYAiABKAFSCmNh'
    'c2hBbW91bnQSJwoPY29udmVyc2lvbl9yYXRlGAMgASgBUg5jb252ZXJzaW9uUmF0ZRIQCgNmZW'
    'UYBCABKAFSA2ZlZRIfCgtuZXdfYmFsYW5jZRgFIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdl'
    'GAYgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use airtimeToCashConversionDescriptor instead')
const AirtimeToCashConversion$json = {
  '1': 'AirtimeToCashConversion',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network', '3': 5, '4': 1, '5': 9, '10': 'network'},
    {'1': 'airtime_amount', '3': 6, '4': 1, '5': 1, '10': 'airtimeAmount'},
    {'1': 'cash_amount', '3': 7, '4': 1, '5': 1, '10': 'cashAmount'},
    {'1': 'conversion_rate', '3': 8, '4': 1, '5': 1, '10': 'conversionRate'},
    {'1': 'fee', '3': 9, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {'1': 'provider_name', '3': 11, '4': 1, '5': 9, '10': 'providerName'},
    {
      '1': 'provider_reference',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'providerReference'
    },
    {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'provider_tx_id', '3': 15, '4': 1, '5': 9, '10': 'providerTxId'},
    {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'completed_at', '3': 17, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `AirtimeToCashConversion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeToCashConversionDescriptor = $convert.base64Decode(
    'ChdBaXJ0aW1lVG9DYXNoQ29udmVyc2lvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIA'
    'EoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIhCgxwaG9uZV9udW1i'
    'ZXIYBCABKAlSC3Bob25lTnVtYmVyEhgKB25ldHdvcmsYBSABKAlSB25ldHdvcmsSJQoOYWlydG'
    'ltZV9hbW91bnQYBiABKAFSDWFpcnRpbWVBbW91bnQSHwoLY2FzaF9hbW91bnQYByABKAFSCmNh'
    'c2hBbW91bnQSJwoPY29udmVyc2lvbl9yYXRlGAggASgBUg5jb252ZXJzaW9uUmF0ZRIQCgNmZW'
    'UYCSABKAFSA2ZlZRIWCgZzdGF0dXMYCiABKAlSBnN0YXR1cxIjCg1wcm92aWRlcl9uYW1lGAsg'
    'ASgJUgxwcm92aWRlck5hbWUSLQoScHJvdmlkZXJfcmVmZXJlbmNlGAwgASgJUhFwcm92aWRlcl'
    'JlZmVyZW5jZRIcCglyZWZlcmVuY2UYDSABKAlSCXJlZmVyZW5jZRIdCgpjcmVhdGVkX2F0GA4g'
    'ASgJUgljcmVhdGVkQXQSJAoOcHJvdmlkZXJfdHhfaWQYDyABKAlSDHByb3ZpZGVyVHhJZBIlCg'
    '5mYWlsdXJlX3JlYXNvbhgQIAEoCVINZmFpbHVyZVJlYXNvbhIhCgxjb21wbGV0ZWRfYXQYESAB'
    'KAlSC2NvbXBsZXRlZEF0');

@$core.Deprecated('Use getAirtimeToCashHistoryRequestDescriptor instead')
const GetAirtimeToCashHistoryRequest$json = {
  '1': 'GetAirtimeToCashHistoryRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAirtimeToCashHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashHistoryRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRBaXJ0aW1lVG9DYXNoSGlzdG9yeVJlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0Eh'
        'YKBm9mZnNldBgCIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use getAirtimeToCashHistoryResponseDescriptor instead')
const GetAirtimeToCashHistoryResponse$json = {
  '1': 'GetAirtimeToCashHistoryResponse',
  '2': [
    {
      '1': 'conversions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.AirtimeToCashConversion',
      '10': 'conversions'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 3, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetAirtimeToCashHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashHistoryResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRBaXJ0aW1lVG9DYXNoSGlzdG9yeVJlc3BvbnNlEkoKC2NvbnZlcnNpb25zGAEgAygLMi'
        'gudXRpbGl0eXBheW1lbnRzLkFpcnRpbWVUb0Nhc2hDb252ZXJzaW9uUgtjb252ZXJzaW9ucxIf'
        'Cgt0b3RhbF9jb3VudBgCIAEoA1IKdG90YWxDb3VudA==');

@$core.Deprecated('Use verifyAirtimeToCashServiceRequestDescriptor instead')
const VerifyAirtimeToCashServiceRequest$json = {
  '1': 'VerifyAirtimeToCashServiceRequest',
  '2': [
    {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
    {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `VerifyAirtimeToCashServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAirtimeToCashServiceRequestDescriptor =
    $convert.base64Decode(
        'CiFWZXJpZnlBaXJ0aW1lVG9DYXNoU2VydmljZVJlcXVlc3QSGAoHbmV0d29yaxgBIAEoCVIHbm'
        'V0d29yaxIaCghwcm92aWRlchgCIAEoCVIIcHJvdmlkZXI=');

@$core.Deprecated('Use verifyAirtimeToCashServiceResponseDescriptor instead')
const VerifyAirtimeToCashServiceResponse$json = {
  '1': 'VerifyAirtimeToCashServiceResponse',
  '2': [
    {'1': 'is_available', '3': 1, '4': 1, '5': 8, '10': 'isAvailable'},
    {'1': 'provider_name', '3': 2, '4': 1, '5': 9, '10': 'providerName'},
    {
      '1': 'destination_phone',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'destinationPhone'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'network', '3': 5, '4': 1, '5': 9, '10': 'network'},
    {
      '1': 'requires_transfer',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'requiresTransfer'
    },
  ],
};

/// Descriptor for `VerifyAirtimeToCashServiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAirtimeToCashServiceResponseDescriptor =
    $convert.base64Decode(
        'CiJWZXJpZnlBaXJ0aW1lVG9DYXNoU2VydmljZVJlc3BvbnNlEiEKDGlzX2F2YWlsYWJsZRgBIA'
        'EoCFILaXNBdmFpbGFibGUSIwoNcHJvdmlkZXJfbmFtZRgCIAEoCVIMcHJvdmlkZXJOYW1lEisK'
        'EWRlc3RpbmF0aW9uX3Bob25lGAMgASgJUhBkZXN0aW5hdGlvblBob25lEhgKB21lc3NhZ2UYBC'
        'ABKAlSB21lc3NhZ2USGAoHbmV0d29yaxgFIAEoCVIHbmV0d29yaxIrChFyZXF1aXJlc190cmFu'
        'c2ZlchgGIAEoCFIQcmVxdWlyZXNUcmFuc2Zlcg==');

@$core.Deprecated('Use providerStatusDescriptor instead')
const ProviderStatus$json = {
  '1': 'ProviderStatus',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'is_active', '3': 3, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'is_healthy', '3': 4, '4': 1, '5': 8, '10': 'isHealthy'},
    {'1': 'network_count', '3': 5, '4': 1, '5': 5, '10': 'networkCount'},
    {'1': 'error_message', '3': 6, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `ProviderStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerStatusDescriptor = $convert.base64Decode(
    'Cg5Qcm92aWRlclN0YXR1cxISCgRuYW1lGAEgASgJUgRuYW1lEiEKDGRpc3BsYXlfbmFtZRgCIA'
    'EoCVILZGlzcGxheU5hbWUSGwoJaXNfYWN0aXZlGAMgASgIUghpc0FjdGl2ZRIdCgppc19oZWFs'
    'dGh5GAQgASgIUglpc0hlYWx0aHkSIwoNbmV0d29ya19jb3VudBgFIAEoBVIMbmV0d29ya0NvdW'
    '50EiMKDWVycm9yX21lc3NhZ2UYBiABKAlSDGVycm9yTWVzc2FnZQ==');

@$core.Deprecated('Use getAirtimeToCashProviderInfoRequestDescriptor instead')
const GetAirtimeToCashProviderInfoRequest$json = {
  '1': 'GetAirtimeToCashProviderInfoRequest',
};

/// Descriptor for `GetAirtimeToCashProviderInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashProviderInfoRequestDescriptor =
    $convert
        .base64Decode('CiNHZXRBaXJ0aW1lVG9DYXNoUHJvdmlkZXJJbmZvUmVxdWVzdA==');

@$core.Deprecated('Use getAirtimeToCashProviderInfoResponseDescriptor instead')
const GetAirtimeToCashProviderInfoResponse$json = {
  '1': 'GetAirtimeToCashProviderInfoResponse',
  '2': [
    {'1': 'provider_name', '3': 1, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'requires_otp', '3': 2, '4': 1, '5': 8, '10': 'requiresOtp'},
    {
      '1': 'requires_transfer',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'requiresTransfer'
    },
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {
      '1': 'providers',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.ProviderStatus',
      '10': 'providers'
    },
  ],
};

/// Descriptor for `GetAirtimeToCashProviderInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashProviderInfoResponseDescriptor =
    $convert.base64Decode(
        'CiRHZXRBaXJ0aW1lVG9DYXNoUHJvdmlkZXJJbmZvUmVzcG9uc2USIwoNcHJvdmlkZXJfbmFtZR'
        'gBIAEoCVIMcHJvdmlkZXJOYW1lEiEKDHJlcXVpcmVzX290cBgCIAEoCFILcmVxdWlyZXNPdHAS'
        'KwoRcmVxdWlyZXNfdHJhbnNmZXIYAyABKAhSEHJlcXVpcmVzVHJhbnNmZXISIQoMZGlzcGxheV'
        '9uYW1lGAQgASgJUgtkaXNwbGF5TmFtZRI9Cglwcm92aWRlcnMYBSADKAsyHy51dGlsaXR5cGF5'
        'bWVudHMuUHJvdmlkZXJTdGF0dXNSCXByb3ZpZGVycw==');

@$core.Deprecated('Use checkAirtimeToCashQuotaRequestDescriptor instead')
const CheckAirtimeToCashQuotaRequest$json = {
  '1': 'CheckAirtimeToCashQuotaRequest',
  '2': [
    {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `CheckAirtimeToCashQuotaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkAirtimeToCashQuotaRequestDescriptor =
    $convert.base64Decode(
        'Ch5DaGVja0FpcnRpbWVUb0Nhc2hRdW90YVJlcXVlc3QSGAoHbmV0d29yaxgBIAEoCVIHbmV0d2'
        '9yaxIWCgZhbW91bnQYAiABKAFSBmFtb3VudA==');

@$core.Deprecated('Use checkAirtimeToCashQuotaResponseDescriptor instead')
const CheckAirtimeToCashQuotaResponse$json = {
  '1': 'CheckAirtimeToCashQuotaResponse',
  '2': [
    {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    {'1': 'max_amount', '3': 2, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'current_rate', '3': 4, '4': 1, '5': 1, '10': 'currentRate'},
    {'1': 'fee', '3': 5, '4': 1, '5': 1, '10': 'fee'},
  ],
};

/// Descriptor for `CheckAirtimeToCashQuotaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkAirtimeToCashQuotaResponseDescriptor =
    $convert.base64Decode(
        'Ch9DaGVja0FpcnRpbWVUb0Nhc2hRdW90YVJlc3BvbnNlEhwKCWF2YWlsYWJsZRgBIAEoCFIJYX'
        'ZhaWxhYmxlEh0KCm1heF9hbW91bnQYAiABKAFSCW1heEFtb3VudBIYCgdtZXNzYWdlGAMgASgJ'
        'UgdtZXNzYWdlEiEKDGN1cnJlbnRfcmF0ZRgEIAEoAVILY3VycmVudFJhdGUSEAoDZmVlGAUgAS'
        'gBUgNmZWU=');

@$core.Deprecated('Use waterProviderDescriptor instead')
const WaterProvider$json = {
  '1': 'WaterProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'service_id', '3': 3, '4': 1, '5': 9, '10': 'serviceId'},
    {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'commission_rate', '3': 6, '4': 1, '5': 1, '10': 'commissionRate'},
    {'1': 'min_amount', '3': 7, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 8, '4': 1, '5': 1, '10': 'maxAmount'},
  ],
};

/// Descriptor for `WaterProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waterProviderDescriptor = $convert.base64Decode(
    'Cg1XYXRlclByb3ZpZGVyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh0KCn'
    'NlcnZpY2VfaWQYAyABKAlSCXNlcnZpY2VJZBIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIb'
    'Cglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEicKD2NvbW1pc3Npb25fcmF0ZRgGIAEoAVIOY2'
    '9tbWlzc2lvblJhdGUSHQoKbWluX2Ftb3VudBgHIAEoAVIJbWluQW1vdW50Eh0KCm1heF9hbW91'
    'bnQYCCABKAFSCW1heEFtb3VudA==');

@$core.Deprecated('Use getWaterProvidersRequestDescriptor instead')
const GetWaterProvidersRequest$json = {
  '1': 'GetWaterProvidersRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetWaterProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterProvidersRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRXYXRlclByb3ZpZGVyc1JlcXVlc3QSHwoLYWN0aXZlX29ubHkYASABKAhSCmFjdGl2ZU'
        '9ubHk=');

@$core.Deprecated('Use getWaterProvidersResponseDescriptor instead')
const GetWaterProvidersResponse$json = {
  '1': 'GetWaterProvidersResponse',
  '2': [
    {
      '1': 'providers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.WaterProvider',
      '10': 'providers'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetWaterProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterProvidersResponseDescriptor = $convert.base64Decode(
    'ChlHZXRXYXRlclByb3ZpZGVyc1Jlc3BvbnNlEjwKCXByb3ZpZGVycxgBIAMoCzIeLnV0aWxpdH'
    'lwYXltZW50cy5XYXRlclByb3ZpZGVyUglwcm92aWRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use asyncPaymentConfigDescriptor instead')
const AsyncPaymentConfig$json = {
  '1': 'AsyncPaymentConfig',
  '2': [
    {
      '1': 'electricity_enabled',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'electricityEnabled'
    },
    {'1': 'airtime_enabled', '3': 2, '4': 1, '5': 8, '10': 'airtimeEnabled'},
    {'1': 'data_enabled', '3': 3, '4': 1, '5': 8, '10': 'dataEnabled'},
    {'1': 'cable_tv_enabled', '3': 4, '4': 1, '5': 8, '10': 'cableTvEnabled'},
    {'1': 'internet_enabled', '3': 5, '4': 1, '5': 8, '10': 'internetEnabled'},
    {'1': 'water_enabled', '3': 6, '4': 1, '5': 8, '10': 'waterEnabled'},
    {
      '1': 'education_enabled',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'educationEnabled'
    },
    {
      '1': 'vtpass_async_enabled',
      '3': 8,
      '4': 1,
      '5': 8,
      '10': 'vtpassAsyncEnabled'
    },
    {
      '1': 'reloadly_async_enabled',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'reloadlyAsyncEnabled'
    },
    {
      '1': 'provider_timeout_seconds',
      '3': 10,
      '4': 1,
      '5': 5,
      '10': 'providerTimeoutSeconds'
    },
    {
      '1': 'send_push_notification',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'sendPushNotification'
    },
    {
      '1': 'send_sms_notification',
      '3': 12,
      '4': 1,
      '5': 8,
      '10': 'sendSmsNotification'
    },
    {
      '1': 'notification_message',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'notificationMessage'
    },
    {
      '1': 'async_pending_message',
      '3': 14,
      '4': 1,
      '5': 9,
      '10': 'asyncPendingMessage'
    },
    {
      '1': 'async_completed_message',
      '3': 15,
      '4': 1,
      '5': 9,
      '10': 'asyncCompletedMessage'
    },
    {
      '1': 'async_failed_message',
      '3': 16,
      '4': 1,
      '5': 9,
      '10': 'asyncFailedMessage'
    },
  ],
};

/// Descriptor for `AsyncPaymentConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List asyncPaymentConfigDescriptor = $convert.base64Decode(
    'ChJBc3luY1BheW1lbnRDb25maWcSLwoTZWxlY3RyaWNpdHlfZW5hYmxlZBgBIAEoCFISZWxlY3'
    'RyaWNpdHlFbmFibGVkEicKD2FpcnRpbWVfZW5hYmxlZBgCIAEoCFIOYWlydGltZUVuYWJsZWQS'
    'IQoMZGF0YV9lbmFibGVkGAMgASgIUgtkYXRhRW5hYmxlZBIoChBjYWJsZV90dl9lbmFibGVkGA'
    'QgASgIUg5jYWJsZVR2RW5hYmxlZBIpChBpbnRlcm5ldF9lbmFibGVkGAUgASgIUg9pbnRlcm5l'
    'dEVuYWJsZWQSIwoNd2F0ZXJfZW5hYmxlZBgGIAEoCFIMd2F0ZXJFbmFibGVkEisKEWVkdWNhdG'
    'lvbl9lbmFibGVkGAcgASgIUhBlZHVjYXRpb25FbmFibGVkEjAKFHZ0cGFzc19hc3luY19lbmFi'
    'bGVkGAggASgIUhJ2dHBhc3NBc3luY0VuYWJsZWQSNAoWcmVsb2FkbHlfYXN5bmNfZW5hYmxlZB'
    'gJIAEoCFIUcmVsb2FkbHlBc3luY0VuYWJsZWQSOAoYcHJvdmlkZXJfdGltZW91dF9zZWNvbmRz'
    'GAogASgFUhZwcm92aWRlclRpbWVvdXRTZWNvbmRzEjQKFnNlbmRfcHVzaF9ub3RpZmljYXRpb2'
    '4YCyABKAhSFHNlbmRQdXNoTm90aWZpY2F0aW9uEjIKFXNlbmRfc21zX25vdGlmaWNhdGlvbhgM'
    'IAEoCFITc2VuZFNtc05vdGlmaWNhdGlvbhIxChRub3RpZmljYXRpb25fbWVzc2FnZRgNIAEoCV'
    'ITbm90aWZpY2F0aW9uTWVzc2FnZRIyChVhc3luY19wZW5kaW5nX21lc3NhZ2UYDiABKAlSE2Fz'
    'eW5jUGVuZGluZ01lc3NhZ2USNgoXYXN5bmNfY29tcGxldGVkX21lc3NhZ2UYDyABKAlSFWFzeW'
    '5jQ29tcGxldGVkTWVzc2FnZRIwChRhc3luY19mYWlsZWRfbWVzc2FnZRgQIAEoCVISYXN5bmNG'
    'YWlsZWRNZXNzYWdl');

@$core.Deprecated('Use getAsyncPaymentConfigRequestDescriptor instead')
const GetAsyncPaymentConfigRequest$json = {
  '1': 'GetAsyncPaymentConfigRequest',
};

/// Descriptor for `GetAsyncPaymentConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAsyncPaymentConfigRequestDescriptor =
    $convert.base64Decode('ChxHZXRBc3luY1BheW1lbnRDb25maWdSZXF1ZXN0');

@$core.Deprecated('Use getAsyncPaymentConfigResponseDescriptor instead')
const GetAsyncPaymentConfigResponse$json = {
  '1': 'GetAsyncPaymentConfigResponse',
  '2': [
    {
      '1': 'config',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AsyncPaymentConfig',
      '10': 'config'
    },
  ],
};

/// Descriptor for `GetAsyncPaymentConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAsyncPaymentConfigResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRBc3luY1BheW1lbnRDb25maWdSZXNwb25zZRI7CgZjb25maWcYASABKAsyIy51dGlsaX'
        'R5cGF5bWVudHMuQXN5bmNQYXltZW50Q29uZmlnUgZjb25maWc=');

@$core.Deprecated('Use updateAsyncPaymentConfigRequestDescriptor instead')
const UpdateAsyncPaymentConfigRequest$json = {
  '1': 'UpdateAsyncPaymentConfigRequest',
  '2': [
    {
      '1': 'electricity_enabled',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'electricityEnabled'
    },
    {
      '1': 'airtime_enabled',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'airtimeEnabled'
    },
    {
      '1': 'data_enabled',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'dataEnabled'
    },
    {
      '1': 'cable_tv_enabled',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'cableTvEnabled'
    },
    {
      '1': 'internet_enabled',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'internetEnabled'
    },
    {
      '1': 'water_enabled',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'waterEnabled'
    },
    {
      '1': 'education_enabled',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'educationEnabled'
    },
    {
      '1': 'vtpass_async_enabled',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'vtpassAsyncEnabled'
    },
    {
      '1': 'reloadly_async_enabled',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'reloadlyAsyncEnabled'
    },
    {
      '1': 'provider_timeout_seconds',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Int32Value',
      '10': 'providerTimeoutSeconds'
    },
    {
      '1': 'send_push_notification',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'sendPushNotification'
    },
    {
      '1': 'send_sms_notification',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'sendSmsNotification'
    },
    {
      '1': 'notification_message',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'notificationMessage'
    },
    {
      '1': 'async_pending_message',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'asyncPendingMessage'
    },
    {
      '1': 'async_completed_message',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'asyncCompletedMessage'
    },
    {
      '1': 'async_failed_message',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.StringValue',
      '10': 'asyncFailedMessage'
    },
  ],
};

/// Descriptor for `UpdateAsyncPaymentConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAsyncPaymentConfigRequestDescriptor = $convert.base64Decode(
    'Ch9VcGRhdGVBc3luY1BheW1lbnRDb25maWdSZXF1ZXN0EksKE2VsZWN0cmljaXR5X2VuYWJsZW'
    'QYASABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUhJlbGVjdHJpY2l0eUVuYWJsZWQS'
    'QwoPYWlydGltZV9lbmFibGVkGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZVIOYW'
    'lydGltZUVuYWJsZWQSPQoMZGF0YV9lbmFibGVkGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLkJv'
    'b2xWYWx1ZVILZGF0YUVuYWJsZWQSRAoQY2FibGVfdHZfZW5hYmxlZBgEIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5Cb29sVmFsdWVSDmNhYmxlVHZFbmFibGVkEkUKEGludGVybmV0X2VuYWJsZWQY'
    'BSABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUg9pbnRlcm5ldEVuYWJsZWQSPwoNd2'
    'F0ZXJfZW5hYmxlZBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVmFsdWVSDHdhdGVyRW5h'
    'YmxlZBJHChFlZHVjYXRpb25fZW5hYmxlZBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVm'
    'FsdWVSEGVkdWNhdGlvbkVuYWJsZWQSTAoUdnRwYXNzX2FzeW5jX2VuYWJsZWQYCCABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuQm9vbFZhbHVlUhJ2dHBhc3NBc3luY0VuYWJsZWQSUAoWcmVsb2FkbH'
    'lfYXN5bmNfZW5hYmxlZBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVmFsdWVSFHJlbG9h'
    'ZGx5QXN5bmNFbmFibGVkElUKGHByb3ZpZGVyX3RpbWVvdXRfc2Vjb25kcxgKIAEoCzIbLmdvb2'
    'dsZS5wcm90b2J1Zi5JbnQzMlZhbHVlUhZwcm92aWRlclRpbWVvdXRTZWNvbmRzElAKFnNlbmRf'
    'cHVzaF9ub3RpZmljYXRpb24YCyABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUhRzZW'
    '5kUHVzaE5vdGlmaWNhdGlvbhJOChVzZW5kX3Ntc19ub3RpZmljYXRpb24YDCABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuQm9vbFZhbHVlUhNzZW5kU21zTm90aWZpY2F0aW9uEk8KFG5vdGlmaWNhdG'
    'lvbl9tZXNzYWdlGA0gASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUhNub3RpZmlj'
    'YXRpb25NZXNzYWdlElAKFWFzeW5jX3BlbmRpbmdfbWVzc2FnZRgOIAEoCzIcLmdvb2dsZS5wcm'
    '90b2J1Zi5TdHJpbmdWYWx1ZVITYXN5bmNQZW5kaW5nTWVzc2FnZRJUChdhc3luY19jb21wbGV0'
    'ZWRfbWVzc2FnZRgPIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIVYXN5bmNDb2'
    '1wbGV0ZWRNZXNzYWdlEk4KFGFzeW5jX2ZhaWxlZF9tZXNzYWdlGBAgASgLMhwuZ29vZ2xlLnBy'
    'b3RvYnVmLlN0cmluZ1ZhbHVlUhJhc3luY0ZhaWxlZE1lc3NhZ2U=');

@$core.Deprecated('Use updateAsyncPaymentConfigResponseDescriptor instead')
const UpdateAsyncPaymentConfigResponse$json = {
  '1': 'UpdateAsyncPaymentConfigResponse',
  '2': [
    {
      '1': 'config',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AsyncPaymentConfig',
      '10': 'config'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAsyncPaymentConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAsyncPaymentConfigResponseDescriptor =
    $convert.base64Decode(
        'CiBVcGRhdGVBc3luY1BheW1lbnRDb25maWdSZXNwb25zZRI7CgZjb25maWcYASABKAsyIy51dG'
        'lsaXR5cGF5bWVudHMuQXN5bmNQYXltZW50Q29uZmlnUgZjb25maWcSGAoHbWVzc2FnZRgCIAEo'
        'CVIHbWVzc2FnZQ==');

@$core.Deprecated('Use airtimeBeneficiaryDescriptor instead')
const AirtimeBeneficiary$json = {
  '1': 'AirtimeBeneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network_code', '3': 4, '4': 1, '5': 9, '10': 'networkCode'},
    {'1': 'network_name', '3': 5, '4': 1, '5': 9, '10': 'networkName'},
    {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'country_code', '3': 7, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'operator_id', '3': 8, '4': 1, '5': 9, '10': 'operatorId'},
    {'1': 'last_amount', '3': 9, '4': 1, '5': 1, '10': 'lastAmount'},
    {
      '1': 'last_topup_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastTopupAt'
    },
    {'1': 'topup_count', '3': 11, '4': 1, '5': 5, '10': 'topupCount'},
    {
      '1': 'created_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `AirtimeBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeBeneficiaryDescriptor = $convert.base64Decode(
    'ChJBaXJ0aW1lQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBn'
    'VzZXJJZBIhCgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEiEKDG5ldHdvcmtfY29k'
    'ZRgEIAEoCVILbmV0d29ya0NvZGUSIQoMbmV0d29ya19uYW1lGAUgASgJUgtuZXR3b3JrTmFtZR'
    'IaCghuaWNrbmFtZRgGIAEoCVIIbmlja25hbWUSIQoMY291bnRyeV9jb2RlGAcgASgJUgtjb3Vu'
    'dHJ5Q29kZRIfCgtvcGVyYXRvcl9pZBgIIAEoCVIKb3BlcmF0b3JJZBIfCgtsYXN0X2Ftb3VudB'
    'gJIAEoAVIKbGFzdEFtb3VudBI+Cg1sYXN0X3RvcHVwX2F0GAogASgLMhouZ29vZ2xlLnByb3Rv'
    'YnVmLlRpbWVzdGFtcFILbGFzdFRvcHVwQXQSHwoLdG9wdXBfY291bnQYCyABKAVSCnRvcHVwQ2'
    '91bnQSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNy'
    'ZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'IJdXBkYXRlZEF0');

@$core.Deprecated('Use saveAirtimeBeneficiaryRequestDescriptor instead')
const SaveAirtimeBeneficiaryRequest$json = {
  '1': 'SaveAirtimeBeneficiaryRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network_code', '3': 2, '4': 1, '5': 9, '10': 'networkCode'},
    {'1': 'network_name', '3': 3, '4': 1, '5': 9, '10': 'networkName'},
    {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'country_code', '3': 5, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'operator_id', '3': 6, '4': 1, '5': 9, '10': 'operatorId'},
  ],
};

/// Descriptor for `SaveAirtimeBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveAirtimeBeneficiaryRequestDescriptor = $convert.base64Decode(
    'Ch1TYXZlQWlydGltZUJlbmVmaWNpYXJ5UmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3'
    'Bob25lTnVtYmVyEiEKDG5ldHdvcmtfY29kZRgCIAEoCVILbmV0d29ya0NvZGUSIQoMbmV0d29y'
    'a19uYW1lGAMgASgJUgtuZXR3b3JrTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWUSIQ'
    'oMY291bnRyeV9jb2RlGAUgASgJUgtjb3VudHJ5Q29kZRIfCgtvcGVyYXRvcl9pZBgGIAEoCVIK'
    'b3BlcmF0b3JJZA==');

@$core.Deprecated('Use saveAirtimeBeneficiaryResponseDescriptor instead')
const SaveAirtimeBeneficiaryResponse$json = {
  '1': 'SaveAirtimeBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AirtimeBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveAirtimeBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveAirtimeBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'Ch5TYXZlQWlydGltZUJlbmVmaWNpYXJ5UmVzcG9uc2USRQoLYmVuZWZpY2lhcnkYASABKAsyIy'
        '51dGlsaXR5cGF5bWVudHMuQWlydGltZUJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNz'
        'YWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getAirtimeBeneficiariesRequestDescriptor instead')
const GetAirtimeBeneficiariesRequest$json = {
  '1': 'GetAirtimeBeneficiariesRequest',
  '2': [
    {'1': 'network_code', '3': 1, '4': 1, '5': 9, '10': 'networkCode'},
  ],
};

/// Descriptor for `GetAirtimeBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeBeneficiariesRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRBaXJ0aW1lQmVuZWZpY2lhcmllc1JlcXVlc3QSIQoMbmV0d29ya19jb2RlGAEgASgJUg'
        'tuZXR3b3JrQ29kZQ==');

@$core.Deprecated('Use getAirtimeBeneficiariesResponseDescriptor instead')
const GetAirtimeBeneficiariesResponse$json = {
  '1': 'GetAirtimeBeneficiariesResponse',
  '2': [
    {
      '1': 'beneficiaries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.AirtimeBeneficiary',
      '10': 'beneficiaries'
    },
  ],
};

/// Descriptor for `GetAirtimeBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeBeneficiariesResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRBaXJ0aW1lQmVuZWZpY2lhcmllc1Jlc3BvbnNlEkkKDWJlbmVmaWNpYXJpZXMYASADKA'
        'syIy51dGlsaXR5cGF5bWVudHMuQWlydGltZUJlbmVmaWNpYXJ5Ug1iZW5lZmljaWFyaWVz');

@$core.Deprecated('Use updateAirtimeBeneficiaryRequestDescriptor instead')
const UpdateAirtimeBeneficiaryRequest$json = {
  '1': 'UpdateAirtimeBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateAirtimeBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'Ch9VcGRhdGVBaXJ0aW1lQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIaCghuaW'
        'NrbmFtZRgCIAEoCVIIbmlja25hbWU=');

@$core.Deprecated('Use updateAirtimeBeneficiaryResponseDescriptor instead')
const UpdateAirtimeBeneficiaryResponse$json = {
  '1': 'UpdateAirtimeBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AirtimeBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAirtimeBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiBVcGRhdGVBaXJ0aW1lQmVuZWZpY2lhcnlSZXNwb25zZRJFCgtiZW5lZmljaWFyeRgBIAEoCz'
        'IjLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21l'
        'c3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use deleteAirtimeBeneficiaryRequestDescriptor instead')
const DeleteAirtimeBeneficiaryRequest$json = {
  '1': 'DeleteAirtimeBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteAirtimeBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'Ch9EZWxldGVBaXJ0aW1lQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use deleteAirtimeBeneficiaryResponseDescriptor instead')
const DeleteAirtimeBeneficiaryResponse$json = {
  '1': 'DeleteAirtimeBeneficiaryResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAirtimeBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiBEZWxldGVBaXJ0aW1lQmVuZWZpY2lhcnlSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZX'
        'NzYWdl');

@$core.Deprecated('Use airtimeAutoRechargeDescriptor instead')
const AirtimeAutoRecharge$json = {
  '1': 'AirtimeAutoRecharge',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network_code', '3': 5, '4': 1, '5': 9, '10': 'networkCode'},
    {'1': 'network_name', '3': 6, '4': 1, '5': 9, '10': 'networkName'},
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 9, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 10, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 11, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {
      '1': 'next_run_date',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'nextRunDate'
    },
    {
      '1': 'last_run_date',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastRunDate'
    },
    {'1': 'status', '3': 14, '4': 1, '5': 9, '10': 'status'},
    {'1': 'failure_count', '3': 15, '4': 1, '5': 5, '10': 'failureCount'},
    {'1': 'max_retries', '3': 16, '4': 1, '5': 5, '10': 'maxRetries'},
    {
      '1': 'created_at',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'beneficiary',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AirtimeBeneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `AirtimeAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeAutoRechargeDescriptor = $convert.base64Decode(
    'ChNBaXJ0aW1lQXV0b1JlY2hhcmdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSIQoMcGhvbmVf'
    'bnVtYmVyGAQgASgJUgtwaG9uZU51bWJlchIhCgxuZXR3b3JrX2NvZGUYBSABKAlSC25ldHdvcm'
    'tDb2RlEiEKDG5ldHdvcmtfbmFtZRgGIAEoCVILbmV0d29ya05hbWUSFgoGYW1vdW50GAcgASgB'
    'UgZhbW91bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgJIAEoCV'
    'IJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAogASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21v'
    'bnRoGAsgASgFUgpkYXlPZk1vbnRoEj4KDW5leHRfcnVuX2RhdGUYDCABKAsyGi5nb29nbGUucH'
    'JvdG9idWYuVGltZXN0YW1wUgtuZXh0UnVuRGF0ZRI+Cg1sYXN0X3J1bl9kYXRlGA0gASgLMhou'
    'Z29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFJ1bkRhdGUSFgoGc3RhdHVzGA4gASgJUg'
    'ZzdGF0dXMSIwoNZmFpbHVyZV9jb3VudBgPIAEoBVIMZmFpbHVyZUNvdW50Eh8KC21heF9yZXRy'
    'aWVzGBAgASgFUgptYXhSZXRyaWVzEjkKCmNyZWF0ZWRfYXQYESABKAsyGi5nb29nbGUucHJvdG'
    '9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSRQoLYmVuZWZpY2lhcnkYEiABKAsyIy51dGlsaXR5'
    'cGF5bWVudHMuQWlydGltZUJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');

@$core.Deprecated('Use createAirtimeAutoRechargeRequestDescriptor instead')
const CreateAirtimeAutoRechargeRequest$json = {
  '1': 'CreateAirtimeAutoRechargeRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 5, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 6, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 7, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 8, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 9, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAirtimeAutoRechargeRequestDescriptor = $convert.base64Decode(
    'CiBDcmVhdGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIA'
    'EoCVINYmVuZWZpY2lhcnlJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgD'
    'IAEoCVIIY3VycmVuY3kSHAoJZnJlcXVlbmN5GAQgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3'
    'dlZWsYBSABKAVSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYBiABKAVSCmRheU9mTW9udGgS'
    'HwoLbWF4X3JldHJpZXMYByABKAVSCm1heFJldHJpZXMSJQoOZXhlY3V0aW9uX2hvdXIYCCABKA'
    'VSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW9uX21pbnV0ZRgJIAEoBVIPZXhlY3V0aW9uTWlu'
    'dXRl');

@$core.Deprecated('Use createAirtimeAutoRechargeResponseDescriptor instead')
const CreateAirtimeAutoRechargeResponse$json = {
  '1': 'CreateAirtimeAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AirtimeAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAirtimeAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFDcmVhdGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVzcG9uc2USSQoNYXV0b19yZWNoYXJnZRgBIA'
        'EoCzIkLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2US'
        'GAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getAirtimeAutoRechargesRequestDescriptor instead')
const GetAirtimeAutoRechargesRequest$json = {
  '1': 'GetAirtimeAutoRechargesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetAirtimeAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeAutoRechargesRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRBaXJ0aW1lQXV0b1JlY2hhcmdlc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dX'
        'M=');

@$core.Deprecated('Use getAirtimeAutoRechargesResponseDescriptor instead')
const GetAirtimeAutoRechargesResponse$json = {
  '1': 'GetAirtimeAutoRechargesResponse',
  '2': [
    {
      '1': 'auto_recharges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.AirtimeAutoRecharge',
      '10': 'autoRecharges'
    },
  ],
};

/// Descriptor for `GetAirtimeAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeAutoRechargesResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRBaXJ0aW1lQXV0b1JlY2hhcmdlc1Jlc3BvbnNlEksKDmF1dG9fcmVjaGFyZ2VzGAEgAy'
        'gLMiQudXRpbGl0eXBheW1lbnRzLkFpcnRpbWVBdXRvUmVjaGFyZ2VSDWF1dG9SZWNoYXJnZXM=');

@$core.Deprecated('Use updateAirtimeAutoRechargeRequestDescriptor instead')
const UpdateAirtimeAutoRechargeRequest$json = {
  '1': 'UpdateAirtimeAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 4, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 5, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 6, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 7, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 8, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeAutoRechargeRequestDescriptor = $convert.base64Decode(
    'CiBVcGRhdGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGA'
    'EgASgJUg5hdXRvUmVjaGFyZ2VJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIcCglmcmVxdWVu'
    'Y3kYAyABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zfd2VlaxgEIAEoBVIJZGF5T2ZXZWVrEiAKDG'
    'RheV9vZl9tb250aBgFIAEoBVIKZGF5T2ZNb250aBIfCgttYXhfcmV0cmllcxgGIAEoBVIKbWF4'
    'UmV0cmllcxIlCg5leGVjdXRpb25faG91chgHIAEoBVINZXhlY3V0aW9uSG91chIpChBleGVjdX'
    'Rpb25fbWludXRlGAggASgFUg9leGVjdXRpb25NaW51dGU=');

@$core.Deprecated('Use updateAirtimeAutoRechargeResponseDescriptor instead')
const UpdateAirtimeAutoRechargeResponse$json = {
  '1': 'UpdateAirtimeAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AirtimeAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFVcGRhdGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVzcG9uc2USSQoNYXV0b19yZWNoYXJnZRgBIA'
        'EoCzIkLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2US'
        'GAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteAirtimeAutoRechargeRequestDescriptor instead')
const DeleteAirtimeAutoRechargeRequest$json = {
  '1': 'DeleteAirtimeAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'CiBEZWxldGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGA'
        'EgASgJUg5hdXRvUmVjaGFyZ2VJZA==');

@$core.Deprecated('Use deleteAirtimeAutoRechargeResponseDescriptor instead')
const DeleteAirtimeAutoRechargeResponse$json = {
  '1': 'DeleteAirtimeAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFEZWxldGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbW'
        'Vzc2FnZQ==');

@$core.Deprecated('Use pauseAirtimeAutoRechargeRequestDescriptor instead')
const PauseAirtimeAutoRechargeRequest$json = {
  '1': 'PauseAirtimeAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseAirtimeAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'Ch9QYXVzZUFpcnRpbWVBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYAS'
        'ABKAlSDmF1dG9SZWNoYXJnZUlk');

@$core.Deprecated('Use pauseAirtimeAutoRechargeResponseDescriptor instead')
const PauseAirtimeAutoRechargeResponse$json = {
  '1': 'PauseAirtimeAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseAirtimeAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiBQYXVzZUFpcnRpbWVBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZX'
        'NzYWdl');

@$core.Deprecated('Use resumeAirtimeAutoRechargeRequestDescriptor instead')
const ResumeAirtimeAutoRechargeRequest$json = {
  '1': 'ResumeAirtimeAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeAirtimeAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'CiBSZXN1bWVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGA'
        'EgASgJUg5hdXRvUmVjaGFyZ2VJZA==');

@$core.Deprecated('Use resumeAirtimeAutoRechargeResponseDescriptor instead')
const ResumeAirtimeAutoRechargeResponse$json = {
  '1': 'ResumeAirtimeAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeAirtimeAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFSZXN1bWVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbW'
        'Vzc2FnZQ==');

@$core.Deprecated('Use airtimeReminderDescriptor instead')
const AirtimeReminder$json = {
  '1': 'AirtimeReminder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 9, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 10, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'notified_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'notifiedAt'
    },
    {
      '1': 'created_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `AirtimeReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeReminderDescriptor = $convert.base64Decode(
    'Cg9BaXJ0aW1lUmVtaW5kZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBIlCg5iZW5lZmljaWFyeV9pZBgDIAEoCVINYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgEIAEo'
    'CVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2'
    'RhdGUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoG'
    'YW1vdW50GAcgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5EiEKDGlzX3'
    'JlY3VycmluZxgJIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAogASgJUg5y'
    'ZWN1cnJlbmNlVHlwZRIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxI7Cgtub3RpZmllZF9hdBgMIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCm5vdGlmaWVkQXQSOQoKY3JlYXRlZF9h'
    'dBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdG'
    'VkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use createAirtimeReminderRequestDescriptor instead')
const CreateAirtimeReminderRequest$json = {
  '1': 'CreateAirtimeReminderRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'is_recurring', '3': 6, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 7, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateAirtimeReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAirtimeReminderRequestDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVBaXJ0aW1lUmVtaW5kZXJSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgASgJUg'
    '1iZW5lZmljaWFyeUlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEo'
    'CVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIhCgxpc19y'
    'ZWN1cnJpbmcYBiABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgHIAEoCVIOcm'
    'VjdXJyZW5jZVR5cGUSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use createAirtimeReminderResponseDescriptor instead')
const CreateAirtimeReminderResponse$json = {
  '1': 'CreateAirtimeReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AirtimeReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAirtimeReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAirtimeReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch1DcmVhdGVBaXJ0aW1lUmVtaW5kZXJSZXNwb25zZRI8CghyZW1pbmRlchgBIAEoCzIgLnV0aW'
        'xpdHlwYXltZW50cy5BaXJ0aW1lUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlS'
        'B21lc3NhZ2U=');

@$core.Deprecated('Use getAirtimeRemindersRequestDescriptor instead')
const GetAirtimeRemindersRequest$json = {
  '1': 'GetAirtimeRemindersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetAirtimeRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeRemindersRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRBaXJ0aW1lUmVtaW5kZXJzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIhCg'
        'xpbmNsdWRlX3Bhc3QYAiABKAhSC2luY2x1ZGVQYXN0');

@$core.Deprecated('Use getAirtimeRemindersResponseDescriptor instead')
const GetAirtimeRemindersResponse$json = {
  '1': 'GetAirtimeRemindersResponse',
  '2': [
    {
      '1': 'reminders',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.AirtimeReminder',
      '10': 'reminders'
    },
  ],
};

/// Descriptor for `GetAirtimeRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeRemindersResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXRBaXJ0aW1lUmVtaW5kZXJzUmVzcG9uc2USPgoJcmVtaW5kZXJzGAEgAygLMiAudXRpbG'
        'l0eXBheW1lbnRzLkFpcnRpbWVSZW1pbmRlclIJcmVtaW5kZXJz');

@$core.Deprecated('Use updateAirtimeReminderRequestDescriptor instead')
const UpdateAirtimeReminderRequest$json = {
  '1': 'UpdateAirtimeReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateAirtimeReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeReminderRequestDescriptor = $convert.base64Decode(
    'ChxVcGRhdGVBaXJ0aW1lUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW'
    '1pbmRlcklkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVz'
    'Y3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgG'
    'IAEoCVIIY3VycmVuY3kSIQoMaXNfcmVjdXJyaW5nGAcgASgIUgtpc1JlY3VycmluZxInCg9yZW'
    'N1cnJlbmNlX3R5cGUYCCABKAlSDnJlY3VycmVuY2VUeXBl');

@$core.Deprecated('Use updateAirtimeReminderResponseDescriptor instead')
const UpdateAirtimeReminderResponse$json = {
  '1': 'UpdateAirtimeReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.AirtimeReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAirtimeReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch1VcGRhdGVBaXJ0aW1lUmVtaW5kZXJSZXNwb25zZRI8CghyZW1pbmRlchgBIAEoCzIgLnV0aW'
        'xpdHlwYXltZW50cy5BaXJ0aW1lUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlS'
        'B21lc3NhZ2U=');

@$core.Deprecated('Use deleteAirtimeReminderRequestDescriptor instead')
const DeleteAirtimeReminderRequest$json = {
  '1': 'DeleteAirtimeReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteAirtimeReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeReminderRequestDescriptor =
    $convert.base64Decode(
        'ChxEZWxldGVBaXJ0aW1lUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW'
        '1pbmRlcklk');

@$core.Deprecated('Use deleteAirtimeReminderResponseDescriptor instead')
const DeleteAirtimeReminderResponse$json = {
  '1': 'DeleteAirtimeReminderResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAirtimeReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch1EZWxldGVBaXJ0aW1lUmVtaW5kZXJSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYW'
        'dl');

@$core.Deprecated('Use markAirtimeReminderCompleteRequestDescriptor instead')
const MarkAirtimeReminderCompleteRequest$json = {
  '1': 'MarkAirtimeReminderCompleteRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkAirtimeReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAirtimeReminderCompleteRequestDescriptor =
    $convert.base64Decode(
        'CiJNYXJrQWlydGltZVJlbWluZGVyQ29tcGxldGVSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgAS'
        'gJUgpyZW1pbmRlcklk');

@$core.Deprecated('Use markAirtimeReminderCompleteResponseDescriptor instead')
const MarkAirtimeReminderCompleteResponse$json = {
  '1': 'MarkAirtimeReminderCompleteResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkAirtimeReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAirtimeReminderCompleteResponseDescriptor =
    $convert.base64Decode(
        'CiNNYXJrQWlydGltZVJlbWluZGVyQ29tcGxldGVSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUg'
        'dtZXNzYWdl');

@$core.Deprecated('Use getAirtimePaymentReceiptRequestDescriptor instead')
const GetAirtimePaymentReceiptRequest$json = {
  '1': 'GetAirtimePaymentReceiptRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GetAirtimePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimePaymentReceiptRequestDescriptor =
    $convert.base64Decode(
        'Ch9HZXRBaXJ0aW1lUGF5bWVudFJlY2VpcHRSZXF1ZXN0Eh0KCnBheW1lbnRfaWQYASABKAlSCX'
        'BheW1lbnRJZA==');

@$core.Deprecated('Use getAirtimePaymentReceiptResponseDescriptor instead')
const GetAirtimePaymentReceiptResponse$json = {
  '1': 'GetAirtimePaymentReceiptResponse',
  '2': [
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
    {'1': 'phone_number', '3': 2, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network_name', '3': 3, '4': 1, '5': 9, '10': 'networkName'},
    {'1': 'status_message', '3': 4, '4': 1, '5': 9, '10': 'statusMessage'},
    {'1': 'service_fee', '3': 5, '4': 1, '5': 1, '10': 'serviceFee'},
    {'1': 'total_amount', '3': 6, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'refund_state', '3': 7, '4': 1, '5': 9, '10': 'refundState'},
  ],
};

/// Descriptor for `GetAirtimePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimePaymentReceiptResponseDescriptor = $convert.base64Decode(
    'CiBHZXRBaXJ0aW1lUGF5bWVudFJlY2VpcHRSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudX'
    'RpbGl0eXBheW1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50EiEKDHBob25lX251bWJlchgCIAEo'
    'CVILcGhvbmVOdW1iZXISIQoMbmV0d29ya19uYW1lGAMgASgJUgtuZXR3b3JrTmFtZRIlCg5zdG'
    'F0dXNfbWVzc2FnZRgEIAEoCVINc3RhdHVzTWVzc2FnZRIfCgtzZXJ2aWNlX2ZlZRgFIAEoAVIK'
    'c2VydmljZUZlZRIhCgx0b3RhbF9hbW91bnQYBiABKAFSC3RvdGFsQW1vdW50EiEKDHJlZnVuZF'
    '9zdGF0ZRgHIAEoCVILcmVmdW5kU3RhdGU=');

@$core.Deprecated('Use dataBeneficiaryDescriptor instead')
const DataBeneficiary$json = {
  '1': 'DataBeneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network_code', '3': 4, '4': 1, '5': 9, '10': 'networkCode'},
    {'1': 'network_name', '3': 5, '4': 1, '5': 9, '10': 'networkName'},
    {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'country_code', '3': 7, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'operator_id', '3': 8, '4': 1, '5': 9, '10': 'operatorId'},
    {'1': 'last_amount', '3': 9, '4': 1, '5': 1, '10': 'lastAmount'},
    {
      '1': 'last_variation_id',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'lastVariationId'
    },
    {'1': 'last_plan_name', '3': 11, '4': 1, '5': 9, '10': 'lastPlanName'},
    {
      '1': 'last_topup_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastTopupAt'
    },
    {'1': 'topup_count', '3': 13, '4': 1, '5': 5, '10': 'topupCount'},
    {
      '1': 'created_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `DataBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataBeneficiaryDescriptor = $convert.base64Decode(
    'Cg9EYXRhQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBIhCgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEiEKDG5ldHdvcmtfY29kZRgE'
    'IAEoCVILbmV0d29ya0NvZGUSIQoMbmV0d29ya19uYW1lGAUgASgJUgtuZXR3b3JrTmFtZRIaCg'
    'huaWNrbmFtZRgGIAEoCVIIbmlja25hbWUSIQoMY291bnRyeV9jb2RlGAcgASgJUgtjb3VudHJ5'
    'Q29kZRIfCgtvcGVyYXRvcl9pZBgIIAEoCVIKb3BlcmF0b3JJZBIfCgtsYXN0X2Ftb3VudBgJIA'
    'EoAVIKbGFzdEFtb3VudBIqChFsYXN0X3ZhcmlhdGlvbl9pZBgKIAEoCVIPbGFzdFZhcmlhdGlv'
    'bklkEiQKDmxhc3RfcGxhbl9uYW1lGAsgASgJUgxsYXN0UGxhbk5hbWUSPgoNbGFzdF90b3B1cF'
    '9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RUb3B1cEF0Eh8KC3Rv'
    'cHVwX2NvdW50GA0gASgFUgp0b3B1cENvdW50EjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbG'
    'UucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgPIAEoCzIaLmdv'
    'b2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use saveDataBeneficiaryRequestDescriptor instead')
const SaveDataBeneficiaryRequest$json = {
  '1': 'SaveDataBeneficiaryRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network_code', '3': 2, '4': 1, '5': 9, '10': 'networkCode'},
    {'1': 'network_name', '3': 3, '4': 1, '5': 9, '10': 'networkName'},
    {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'country_code', '3': 5, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'operator_id', '3': 6, '4': 1, '5': 9, '10': 'operatorId'},
  ],
};

/// Descriptor for `SaveDataBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveDataBeneficiaryRequestDescriptor = $convert.base64Decode(
    'ChpTYXZlRGF0YUJlbmVmaWNpYXJ5UmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob2'
    '5lTnVtYmVyEiEKDG5ldHdvcmtfY29kZRgCIAEoCVILbmV0d29ya0NvZGUSIQoMbmV0d29ya19u'
    'YW1lGAMgASgJUgtuZXR3b3JrTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWUSIQoMY2'
    '91bnRyeV9jb2RlGAUgASgJUgtjb3VudHJ5Q29kZRIfCgtvcGVyYXRvcl9pZBgGIAEoCVIKb3Bl'
    'cmF0b3JJZA==');

@$core.Deprecated('Use saveDataBeneficiaryResponseDescriptor instead')
const SaveDataBeneficiaryResponse$json = {
  '1': 'SaveDataBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.DataBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveDataBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveDataBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'ChtTYXZlRGF0YUJlbmVmaWNpYXJ5UmVzcG9uc2USQgoLYmVuZWZpY2lhcnkYASABKAsyIC51dG'
        'lsaXR5cGF5bWVudHMuRGF0YUJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNzYWdlGAIg'
        'ASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getDataBeneficiariesRequestDescriptor instead')
const GetDataBeneficiariesRequest$json = {
  '1': 'GetDataBeneficiariesRequest',
  '2': [
    {'1': 'network_code', '3': 1, '4': 1, '5': 9, '10': 'networkCode'},
  ],
};

/// Descriptor for `GetDataBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataBeneficiariesRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXREYXRhQmVuZWZpY2lhcmllc1JlcXVlc3QSIQoMbmV0d29ya19jb2RlGAEgASgJUgtuZX'
        'R3b3JrQ29kZQ==');

@$core.Deprecated('Use getDataBeneficiariesResponseDescriptor instead')
const GetDataBeneficiariesResponse$json = {
  '1': 'GetDataBeneficiariesResponse',
  '2': [
    {
      '1': 'beneficiaries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.DataBeneficiary',
      '10': 'beneficiaries'
    },
  ],
};

/// Descriptor for `GetDataBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataBeneficiariesResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXREYXRhQmVuZWZpY2lhcmllc1Jlc3BvbnNlEkYKDWJlbmVmaWNpYXJpZXMYASADKAsyIC'
        '51dGlsaXR5cGF5bWVudHMuRGF0YUJlbmVmaWNpYXJ5Ug1iZW5lZmljaWFyaWVz');

@$core.Deprecated('Use updateDataBeneficiaryRequestDescriptor instead')
const UpdateDataBeneficiaryRequest$json = {
  '1': 'UpdateDataBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateDataBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'ChxVcGRhdGVEYXRhQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIaCghuaWNrbm'
        'FtZRgCIAEoCVIIbmlja25hbWU=');

@$core.Deprecated('Use updateDataBeneficiaryResponseDescriptor instead')
const UpdateDataBeneficiaryResponse$json = {
  '1': 'UpdateDataBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.DataBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateDataBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'Ch1VcGRhdGVEYXRhQmVuZWZpY2lhcnlSZXNwb25zZRJCCgtiZW5lZmljaWFyeRgBIAEoCzIgLn'
        'V0aWxpdHlwYXltZW50cy5EYXRhQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21lc3NhZ2UY'
        'AiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use deleteDataBeneficiaryRequestDescriptor instead')
const DeleteDataBeneficiaryRequest$json = {
  '1': 'DeleteDataBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteDataBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'ChxEZWxldGVEYXRhQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use deleteDataBeneficiaryResponseDescriptor instead')
const DeleteDataBeneficiaryResponse$json = {
  '1': 'DeleteDataBeneficiaryResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteDataBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'Ch1EZWxldGVEYXRhQmVuZWZpY2lhcnlSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYW'
        'dl');

@$core.Deprecated('Use dataAutoRechargeDescriptor instead')
const DataAutoRecharge$json = {
  '1': 'DataAutoRecharge',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'network_code', '3': 5, '4': 1, '5': 9, '10': 'networkCode'},
    {'1': 'network_name', '3': 6, '4': 1, '5': 9, '10': 'networkName'},
    {'1': 'variation_id', '3': 7, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'plan_name', '3': 8, '4': 1, '5': 9, '10': 'planName'},
    {'1': 'amount', '3': 9, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 11, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 12, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 13, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'execution_hour', '3': 14, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 15, '4': 1, '5': 5, '10': 'executionMinute'},
    {
      '1': 'next_run_date',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'nextRunDate'
    },
    {
      '1': 'last_run_date',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastRunDate'
    },
    {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    {'1': 'failure_count', '3': 19, '4': 1, '5': 5, '10': 'failureCount'},
    {'1': 'max_retries', '3': 20, '4': 1, '5': 5, '10': 'maxRetries'},
    {
      '1': 'created_at',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'beneficiary',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.DataBeneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `DataAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataAutoRechargeDescriptor = $convert.base64Decode(
    'ChBEYXRhQXV0b1JlY2hhcmdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSIQoMcGhvbmVfbnVt'
    'YmVyGAQgASgJUgtwaG9uZU51bWJlchIhCgxuZXR3b3JrX2NvZGUYBSABKAlSC25ldHdvcmtDb2'
    'RlEiEKDG5ldHdvcmtfbmFtZRgGIAEoCVILbmV0d29ya05hbWUSIQoMdmFyaWF0aW9uX2lkGAcg'
    'ASgJUgt2YXJpYXRpb25JZBIbCglwbGFuX25hbWUYCCABKAlSCHBsYW5OYW1lEhYKBmFtb3VudB'
    'gJIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAogASgJUghjdXJyZW5jeRIcCglmcmVxdWVuY3kY'
    'CyABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zfd2VlaxgMIAEoBVIJZGF5T2ZXZWVrEiAKDGRheV'
    '9vZl9tb250aBgNIAEoBVIKZGF5T2ZNb250aBIlCg5leGVjdXRpb25faG91chgOIAEoBVINZXhl'
    'Y3V0aW9uSG91chIpChBleGVjdXRpb25fbWludXRlGA8gASgFUg9leGVjdXRpb25NaW51dGUSPg'
    'oNbmV4dF9ydW5fZGF0ZRgQIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC25leHRS'
    'dW5EYXRlEj4KDWxhc3RfcnVuX2RhdGUYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgtsYXN0UnVuRGF0ZRIWCgZzdGF0dXMYEiABKAlSBnN0YXR1cxIjCg1mYWlsdXJlX2NvdW50'
    'GBMgASgFUgxmYWlsdXJlQ291bnQSHwoLbWF4X3JldHJpZXMYFCABKAVSCm1heFJldHJpZXMSOQ'
    'oKY3JlYXRlZF9hdBgVIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRB'
    'dBJCCgtiZW5lZmljaWFyeRgWIAEoCzIgLnV0aWxpdHlwYXltZW50cy5EYXRhQmVuZWZpY2lhcn'
    'lSC2JlbmVmaWNpYXJ5');

@$core.Deprecated('Use createDataAutoRechargeRequestDescriptor instead')
const CreateDataAutoRechargeRequest$json = {
  '1': 'CreateDataAutoRechargeRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'variation_id', '3': 2, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'plan_name', '3': 3, '4': 1, '5': 9, '10': 'planName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 6, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 7, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 8, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 9, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 10, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 11, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDataAutoRechargeRequestDescriptor = $convert.base64Decode(
    'Ch1DcmVhdGVEYXRhQXV0b1JlY2hhcmdlUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIAEoCV'
    'INYmVuZWZpY2lhcnlJZBIhCgx2YXJpYXRpb25faWQYAiABKAlSC3ZhcmlhdGlvbklkEhsKCXBs'
    'YW5fbmFtZRgDIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSGgoIY3Vycm'
    'VuY3kYBSABKAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgGIAEoCVIJZnJlcXVlbmN5Eh4KC2Rh'
    'eV9vZl93ZWVrGAcgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAggASgFUgpkYXlPZk'
    '1vbnRoEh8KC21heF9yZXRyaWVzGAkgASgFUgptYXhSZXRyaWVzEiUKDmV4ZWN1dGlvbl9ob3Vy'
    'GAogASgFUg1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYCyABKAVSD2V4ZWN1dG'
    'lvbk1pbnV0ZQ==');

@$core.Deprecated('Use createDataAutoRechargeResponseDescriptor instead')
const CreateDataAutoRechargeResponse$json = {
  '1': 'CreateDataAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.DataAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDataAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch5DcmVhdGVEYXRhQXV0b1JlY2hhcmdlUmVzcG9uc2USRgoNYXV0b19yZWNoYXJnZRgBIAEoCz'
        'IhLnV0aWxpdHlwYXltZW50cy5EYXRhQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVz'
        'c2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getDataAutoRechargesRequestDescriptor instead')
const GetDataAutoRechargesRequest$json = {
  '1': 'GetDataAutoRechargesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetDataAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataAutoRechargesRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXREYXRhQXV0b1JlY2hhcmdlc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use getDataAutoRechargesResponseDescriptor instead')
const GetDataAutoRechargesResponse$json = {
  '1': 'GetDataAutoRechargesResponse',
  '2': [
    {
      '1': 'auto_recharges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.DataAutoRecharge',
      '10': 'autoRecharges'
    },
  ],
};

/// Descriptor for `GetDataAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataAutoRechargesResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXREYXRhQXV0b1JlY2hhcmdlc1Jlc3BvbnNlEkgKDmF1dG9fcmVjaGFyZ2VzGAEgAygLMi'
        'EudXRpbGl0eXBheW1lbnRzLkRhdGFBdXRvUmVjaGFyZ2VSDWF1dG9SZWNoYXJnZXM=');

@$core.Deprecated('Use updateDataAutoRechargeRequestDescriptor instead')
const UpdateDataAutoRechargeRequest$json = {
  '1': 'UpdateDataAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    {'1': 'variation_id', '3': 2, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'plan_name', '3': 3, '4': 1, '5': 9, '10': 'planName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 5, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 6, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 7, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 8, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 9, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 10, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataAutoRechargeRequestDescriptor = $convert.base64Decode(
    'Ch1VcGRhdGVEYXRhQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgAS'
    'gJUg5hdXRvUmVjaGFyZ2VJZBIhCgx2YXJpYXRpb25faWQYAiABKAlSC3ZhcmlhdGlvbklkEhsK'
    'CXBsYW5fbmFtZRgDIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSHAoJZn'
    'JlcXVlbmN5GAUgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYBiABKAVSCWRheU9mV2Vl'
    'axIgCgxkYXlfb2ZfbW9udGgYByABKAVSCmRheU9mTW9udGgSHwoLbWF4X3JldHJpZXMYCCABKA'
    'VSCm1heFJldHJpZXMSJQoOZXhlY3V0aW9uX2hvdXIYCSABKAVSDWV4ZWN1dGlvbkhvdXISKQoQ'
    'ZXhlY3V0aW9uX21pbnV0ZRgKIAEoBVIPZXhlY3V0aW9uTWludXRl');

@$core.Deprecated('Use updateDataAutoRechargeResponseDescriptor instead')
const UpdateDataAutoRechargeResponse$json = {
  '1': 'UpdateDataAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.DataAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch5VcGRhdGVEYXRhQXV0b1JlY2hhcmdlUmVzcG9uc2USRgoNYXV0b19yZWNoYXJnZRgBIAEoCz'
        'IhLnV0aWxpdHlwYXltZW50cy5EYXRhQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVz'
        'c2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteDataAutoRechargeRequestDescriptor instead')
const DeleteDataAutoRechargeRequest$json = {
  '1': 'DeleteDataAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'Ch1EZWxldGVEYXRhQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgAS'
        'gJUg5hdXRvUmVjaGFyZ2VJZA==');

@$core.Deprecated('Use deleteDataAutoRechargeResponseDescriptor instead')
const DeleteDataAutoRechargeResponse$json = {
  '1': 'DeleteDataAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch5EZWxldGVEYXRhQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2'
        'FnZQ==');

@$core.Deprecated('Use pauseDataAutoRechargeRequestDescriptor instead')
const PauseDataAutoRechargeRequest$json = {
  '1': 'PauseDataAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseDataAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'ChxQYXVzZURhdGFBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKA'
        'lSDmF1dG9SZWNoYXJnZUlk');

@$core.Deprecated('Use pauseDataAutoRechargeResponseDescriptor instead')
const PauseDataAutoRechargeResponse$json = {
  '1': 'PauseDataAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseDataAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch1QYXVzZURhdGFBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYW'
        'dl');

@$core.Deprecated('Use resumeDataAutoRechargeRequestDescriptor instead')
const ResumeDataAutoRechargeRequest$json = {
  '1': 'ResumeDataAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeDataAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'Ch1SZXN1bWVEYXRhQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgAS'
        'gJUg5hdXRvUmVjaGFyZ2VJZA==');

@$core.Deprecated('Use resumeDataAutoRechargeResponseDescriptor instead')
const ResumeDataAutoRechargeResponse$json = {
  '1': 'ResumeDataAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeDataAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch5SZXN1bWVEYXRhQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2'
        'FnZQ==');

@$core.Deprecated('Use dataReminderDescriptor instead')
const DataReminder$json = {
  '1': 'DataReminder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'variation_id', '3': 8, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 10, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 11, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'notified_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'notifiedAt'
    },
    {
      '1': 'created_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `DataReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataReminderDescriptor = $convert.base64Decode(
    'CgxEYXRhUmVtaW5kZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'IlCg5iZW5lZmljaWFyeV9pZBgDIAEoCVINYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgEIAEoCVIF'
    'dGl0bGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdG'
    'UYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1v'
    'dW50GAcgASgBUgZhbW91bnQSIQoMdmFyaWF0aW9uX2lkGAggASgJUgt2YXJpYXRpb25JZBIaCg'
    'hjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3kSIQoMaXNfcmVjdXJyaW5nGAogASgIUgtpc1JlY3Vy'
    'cmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCyABKAlSDnJlY3VycmVuY2VUeXBlEhYKBnN0YXR1cx'
    'gMIAEoCVIGc3RhdHVzEjsKC25vdGlmaWVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRp'
    'bWVzdGFtcFIKbm90aWZpZWRBdBI5CgpjcmVhdGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJv'
    'dG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use createDataReminderRequestDescriptor instead')
const CreateDataReminderRequest$json = {
  '1': 'CreateDataReminderRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'variation_id', '3': 6, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateDataReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDataReminderRequestDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVEYXRhUmVtaW5kZXJSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgASgJUg1iZW'
    '5lZmljaWFyeUlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVIL'
    'ZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIhCgx2YXJpYXRp'
    'b25faWQYBiABKAlSC3ZhcmlhdGlvbklkEiEKDGlzX3JlY3VycmluZxgHIAEoCFILaXNSZWN1cn'
    'JpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAggASgJUg5yZWN1cnJlbmNlVHlwZRIaCghjdXJyZW5j'
    'eRgJIAEoCVIIY3VycmVuY3k=');

@$core.Deprecated('Use createDataReminderResponseDescriptor instead')
const CreateDataReminderResponse$json = {
  '1': 'CreateDataReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.DataReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateDataReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDataReminderResponseDescriptor =
    $convert.base64Decode(
        'ChpDcmVhdGVEYXRhUmVtaW5kZXJSZXNwb25zZRI5CghyZW1pbmRlchgBIAEoCzIdLnV0aWxpdH'
        'lwYXltZW50cy5EYXRhUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3Nh'
        'Z2U=');

@$core.Deprecated('Use getDataRemindersRequestDescriptor instead')
const GetDataRemindersRequest$json = {
  '1': 'GetDataRemindersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetDataRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataRemindersRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXREYXRhUmVtaW5kZXJzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIhCgxpbm'
        'NsdWRlX3Bhc3QYAiABKAhSC2luY2x1ZGVQYXN0');

@$core.Deprecated('Use getDataRemindersResponseDescriptor instead')
const GetDataRemindersResponse$json = {
  '1': 'GetDataRemindersResponse',
  '2': [
    {
      '1': 'reminders',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.DataReminder',
      '10': 'reminders'
    },
  ],
};

/// Descriptor for `GetDataRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataRemindersResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXREYXRhUmVtaW5kZXJzUmVzcG9uc2USOwoJcmVtaW5kZXJzGAEgAygLMh0udXRpbGl0eX'
        'BheW1lbnRzLkRhdGFSZW1pbmRlclIJcmVtaW5kZXJz');

@$core.Deprecated('Use updateDataReminderRequestDescriptor instead')
const UpdateDataReminderRequest$json = {
  '1': 'UpdateDataReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'variation_id', '3': 6, '4': 1, '5': 9, '10': 'variationId'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateDataReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataReminderRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVEYXRhUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbm'
    'RlcklkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3Jp'
    'cHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbX'
    'BSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIhCgx2YXJpYXRpb25faWQY'
    'BiABKAlSC3ZhcmlhdGlvbklkEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIhCgxpc19yZW'
    'N1cnJpbmcYCCABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgJIAEoCVIOcmVj'
    'dXJyZW5jZVR5cGU=');

@$core.Deprecated('Use updateDataReminderResponseDescriptor instead')
const UpdateDataReminderResponse$json = {
  '1': 'UpdateDataReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.DataReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateDataReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataReminderResponseDescriptor =
    $convert.base64Decode(
        'ChpVcGRhdGVEYXRhUmVtaW5kZXJSZXNwb25zZRI5CghyZW1pbmRlchgBIAEoCzIdLnV0aWxpdH'
        'lwYXltZW50cy5EYXRhUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3Nh'
        'Z2U=');

@$core.Deprecated('Use deleteDataReminderRequestDescriptor instead')
const DeleteDataReminderRequest$json = {
  '1': 'DeleteDataReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteDataReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataReminderRequestDescriptor =
    $convert.base64Decode(
        'ChlEZWxldGVEYXRhUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbm'
        'Rlcklk');

@$core.Deprecated('Use deleteDataReminderResponseDescriptor instead')
const DeleteDataReminderResponse$json = {
  '1': 'DeleteDataReminderResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteDataReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataReminderResponseDescriptor =
    $convert.base64Decode(
        'ChpEZWxldGVEYXRhUmVtaW5kZXJSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use markDataReminderCompleteRequestDescriptor instead')
const MarkDataReminderCompleteRequest$json = {
  '1': 'MarkDataReminderCompleteRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkDataReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markDataReminderCompleteRequestDescriptor =
    $convert.base64Decode(
        'Ch9NYXJrRGF0YVJlbWluZGVyQ29tcGxldGVSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUg'
        'pyZW1pbmRlcklk');

@$core.Deprecated('Use markDataReminderCompleteResponseDescriptor instead')
const MarkDataReminderCompleteResponse$json = {
  '1': 'MarkDataReminderCompleteResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkDataReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markDataReminderCompleteResponseDescriptor =
    $convert.base64Decode(
        'CiBNYXJrRGF0YVJlbWluZGVyQ29tcGxldGVSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZX'
        'NzYWdl');

@$core.Deprecated('Use cableTVBeneficiaryDescriptor instead')
const CableTVBeneficiary$json = {
  '1': 'CableTVBeneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'smart_card_number', '3': 3, '4': 1, '5': 9, '10': 'smartCardNumber'},
    {'1': 'provider_code', '3': 4, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 5, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'customer_name', '3': 7, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'current_package', '3': 8, '4': 1, '5': 9, '10': 'currentPackage'},
    {'1': 'last_amount', '3': 9, '4': 1, '5': 1, '10': 'lastAmount'},
    {
      '1': 'last_variation_code',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'lastVariationCode'
    },
    {
      '1': 'last_package_name',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'lastPackageName'
    },
    {
      '1': 'last_topup_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastTopupAt'
    },
    {'1': 'topup_count', '3': 13, '4': 1, '5': 5, '10': 'topupCount'},
    {
      '1': 'created_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `CableTVBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cableTVBeneficiaryDescriptor = $convert.base64Decode(
    'ChJDYWJsZVRWQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBn'
    'VzZXJJZBIqChFzbWFydF9jYXJkX251bWJlchgDIAEoCVIPc21hcnRDYXJkTnVtYmVyEiMKDXBy'
    'b3ZpZGVyX2NvZGUYBCABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAUgASgJUg'
    'xwcm92aWRlck5hbWUSGgoIbmlja25hbWUYBiABKAlSCG5pY2tuYW1lEiMKDWN1c3RvbWVyX25h'
    'bWUYByABKAlSDGN1c3RvbWVyTmFtZRInCg9jdXJyZW50X3BhY2thZ2UYCCABKAlSDmN1cnJlbn'
    'RQYWNrYWdlEh8KC2xhc3RfYW1vdW50GAkgASgBUgpsYXN0QW1vdW50Ei4KE2xhc3RfdmFyaWF0'
    'aW9uX2NvZGUYCiABKAlSEWxhc3RWYXJpYXRpb25Db2RlEioKEWxhc3RfcGFja2FnZV9uYW1lGA'
    'sgASgJUg9sYXN0UGFja2FnZU5hbWUSPgoNbGFzdF90b3B1cF9hdBgMIAEoCzIaLmdvb2dsZS5w'
    'cm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RUb3B1cEF0Eh8KC3RvcHVwX2NvdW50GA0gASgFUgp0b3'
    'B1cENvdW50EjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1w'
    'UgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use saveCableTVBeneficiaryRequestDescriptor instead')
const SaveCableTVBeneficiaryRequest$json = {
  '1': 'SaveCableTVBeneficiaryRequest',
  '2': [
    {'1': 'smart_card_number', '3': 1, '4': 1, '5': 9, '10': 'smartCardNumber'},
    {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 3, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'customer_name', '3': 5, '4': 1, '5': 9, '10': 'customerName'},
  ],
};

/// Descriptor for `SaveCableTVBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveCableTVBeneficiaryRequestDescriptor = $convert.base64Decode(
    'Ch1TYXZlQ2FibGVUVkJlbmVmaWNpYXJ5UmVxdWVzdBIqChFzbWFydF9jYXJkX251bWJlchgBIA'
    'EoCVIPc21hcnRDYXJkTnVtYmVyEiMKDXByb3ZpZGVyX2NvZGUYAiABKAlSDHByb3ZpZGVyQ29k'
    'ZRIjCg1wcm92aWRlcl9uYW1lGAMgASgJUgxwcm92aWRlck5hbWUSGgoIbmlja25hbWUYBCABKA'
    'lSCG5pY2tuYW1lEiMKDWN1c3RvbWVyX25hbWUYBSABKAlSDGN1c3RvbWVyTmFtZQ==');

@$core.Deprecated('Use saveCableTVBeneficiaryResponseDescriptor instead')
const SaveCableTVBeneficiaryResponse$json = {
  '1': 'SaveCableTVBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.CableTVBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveCableTVBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveCableTVBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'Ch5TYXZlQ2FibGVUVkJlbmVmaWNpYXJ5UmVzcG9uc2USRQoLYmVuZWZpY2lhcnkYASABKAsyIy'
        '51dGlsaXR5cGF5bWVudHMuQ2FibGVUVkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNz'
        'YWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getCableTVBeneficiariesRequestDescriptor instead')
const GetCableTVBeneficiariesRequest$json = {
  '1': 'GetCableTVBeneficiariesRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetCableTVBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVBeneficiariesRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRDYWJsZVRWQmVuZWZpY2lhcmllc1JlcXVlc3QSIwoNcHJvdmlkZXJfY29kZRgBIAEoCV'
        'IMcHJvdmlkZXJDb2Rl');

@$core.Deprecated('Use getCableTVBeneficiariesResponseDescriptor instead')
const GetCableTVBeneficiariesResponse$json = {
  '1': 'GetCableTVBeneficiariesResponse',
  '2': [
    {
      '1': 'beneficiaries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.CableTVBeneficiary',
      '10': 'beneficiaries'
    },
  ],
};

/// Descriptor for `GetCableTVBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVBeneficiariesResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRDYWJsZVRWQmVuZWZpY2lhcmllc1Jlc3BvbnNlEkkKDWJlbmVmaWNpYXJpZXMYASADKA'
        'syIy51dGlsaXR5cGF5bWVudHMuQ2FibGVUVkJlbmVmaWNpYXJ5Ug1iZW5lZmljaWFyaWVz');

@$core.Deprecated('Use updateCableTVBeneficiaryRequestDescriptor instead')
const UpdateCableTVBeneficiaryRequest$json = {
  '1': 'UpdateCableTVBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateCableTVBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'Ch9VcGRhdGVDYWJsZVRWQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIaCghuaW'
        'NrbmFtZRgCIAEoCVIIbmlja25hbWU=');

@$core.Deprecated('Use updateCableTVBeneficiaryResponseDescriptor instead')
const UpdateCableTVBeneficiaryResponse$json = {
  '1': 'UpdateCableTVBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.CableTVBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateCableTVBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiBVcGRhdGVDYWJsZVRWQmVuZWZpY2lhcnlSZXNwb25zZRJFCgtiZW5lZmljaWFyeRgBIAEoCz'
        'IjLnV0aWxpdHlwYXltZW50cy5DYWJsZVRWQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21l'
        'c3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use deleteCableTVBeneficiaryRequestDescriptor instead')
const DeleteCableTVBeneficiaryRequest$json = {
  '1': 'DeleteCableTVBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteCableTVBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'Ch9EZWxldGVDYWJsZVRWQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use deleteCableTVBeneficiaryResponseDescriptor instead')
const DeleteCableTVBeneficiaryResponse$json = {
  '1': 'DeleteCableTVBeneficiaryResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCableTVBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiBEZWxldGVDYWJsZVRWQmVuZWZpY2lhcnlSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZX'
        'NzYWdl');

@$core.Deprecated('Use cableTVAutoRechargeDescriptor instead')
const CableTVAutoRecharge$json = {
  '1': 'CableTVAutoRecharge',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'smart_card_number', '3': 4, '4': 1, '5': 9, '10': 'smartCardNumber'},
    {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'variation_code', '3': 6, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'package_name', '3': 7, '4': 1, '5': 9, '10': 'packageName'},
    {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'subscription_type',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'subscriptionType'
    },
    {'1': 'frequency', '3': 11, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 12, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 13, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'execution_hour', '3': 14, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 15, '4': 1, '5': 5, '10': 'executionMinute'},
    {
      '1': 'next_run_date',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'nextRunDate'
    },
    {
      '1': 'last_run_date',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastRunDate'
    },
    {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    {'1': 'failure_count', '3': 19, '4': 1, '5': 5, '10': 'failureCount'},
    {'1': 'max_retries', '3': 20, '4': 1, '5': 5, '10': 'maxRetries'},
    {
      '1': 'created_at',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'beneficiary',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.CableTVBeneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `CableTVAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cableTVAutoRechargeDescriptor = $convert.base64Decode(
    'ChNDYWJsZVRWQXV0b1JlY2hhcmdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSKgoRc21hcnRf'
    'Y2FyZF9udW1iZXIYBCABKAlSD3NtYXJ0Q2FyZE51bWJlchIjCg1wcm92aWRlcl9jb2RlGAUgAS'
    'gJUgxwcm92aWRlckNvZGUSJQoOdmFyaWF0aW9uX2NvZGUYBiABKAlSDXZhcmlhdGlvbkNvZGUS'
    'IQoMcGFja2FnZV9uYW1lGAcgASgJUgtwYWNrYWdlTmFtZRIWCgZhbW91bnQYCCABKAFSBmFtb3'
    'VudBIaCghjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3kSKwoRc3Vic2NyaXB0aW9uX3R5cGUYCiAB'
    'KAlSEHN1YnNjcmlwdGlvblR5cGUSHAoJZnJlcXVlbmN5GAsgASgJUglmcmVxdWVuY3kSHgoLZG'
    'F5X29mX3dlZWsYDCABKAVSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYDSABKAVSCmRheU9m'
    'TW9udGgSJQoOZXhlY3V0aW9uX2hvdXIYDiABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW'
    '9uX21pbnV0ZRgPIAEoBVIPZXhlY3V0aW9uTWludXRlEj4KDW5leHRfcnVuX2RhdGUYECABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtuZXh0UnVuRGF0ZRI+Cg1sYXN0X3J1bl9kYX'
    'RlGBEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFJ1bkRhdGUSFgoGc3Rh'
    'dHVzGBIgASgJUgZzdGF0dXMSIwoNZmFpbHVyZV9jb3VudBgTIAEoBVIMZmFpbHVyZUNvdW50Eh'
    '8KC21heF9yZXRyaWVzGBQgASgFUgptYXhSZXRyaWVzEjkKCmNyZWF0ZWRfYXQYFSABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSRQoLYmVuZWZpY2lhcnkYFiABKA'
    'syIy51dGlsaXR5cGF5bWVudHMuQ2FibGVUVkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');

@$core.Deprecated('Use createCableTVAutoRechargeRequestDescriptor instead')
const CreateCableTVAutoRechargeRequest$json = {
  '1': 'CreateCableTVAutoRechargeRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'variation_code', '3': 2, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'package_name', '3': 3, '4': 1, '5': 9, '10': 'packageName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'subscription_type',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'subscriptionType'
    },
    {'1': 'frequency', '3': 7, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 8, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 9, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 10, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 11, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 12, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCableTVAutoRechargeRequestDescriptor = $convert.base64Decode(
    'CiBDcmVhdGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIA'
    'EoCVINYmVuZWZpY2lhcnlJZBIlCg52YXJpYXRpb25fY29kZRgCIAEoCVINdmFyaWF0aW9uQ29k'
    'ZRIhCgxwYWNrYWdlX25hbWUYAyABKAlSC3BhY2thZ2VOYW1lEhYKBmFtb3VudBgEIAEoAVIGYW'
    '1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIrChFzdWJzY3JpcHRpb25fdHlwZRgG'
    'IAEoCVIQc3Vic2NyaXB0aW9uVHlwZRIcCglmcmVxdWVuY3kYByABKAlSCWZyZXF1ZW5jeRIeCg'
    'tkYXlfb2Zfd2VlaxgIIAEoBVIJZGF5T2ZXZWVrEiAKDGRheV9vZl9tb250aBgJIAEoBVIKZGF5'
    'T2ZNb250aBIfCgttYXhfcmV0cmllcxgKIAEoBVIKbWF4UmV0cmllcxIlCg5leGVjdXRpb25faG'
    '91chgLIAEoBVINZXhlY3V0aW9uSG91chIpChBleGVjdXRpb25fbWludXRlGAwgASgFUg9leGVj'
    'dXRpb25NaW51dGU=');

@$core.Deprecated('Use createCableTVAutoRechargeResponseDescriptor instead')
const CreateCableTVAutoRechargeResponse$json = {
  '1': 'CreateCableTVAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.CableTVAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCableTVAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFDcmVhdGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVzcG9uc2USSQoNYXV0b19yZWNoYXJnZRgBIA'
        'EoCzIkLnV0aWxpdHlwYXltZW50cy5DYWJsZVRWQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2US'
        'GAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getCableTVAutoRechargesRequestDescriptor instead')
const GetCableTVAutoRechargesRequest$json = {
  '1': 'GetCableTVAutoRechargesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetCableTVAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVAutoRechargesRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRDYWJsZVRWQXV0b1JlY2hhcmdlc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dX'
        'M=');

@$core.Deprecated('Use getCableTVAutoRechargesResponseDescriptor instead')
const GetCableTVAutoRechargesResponse$json = {
  '1': 'GetCableTVAutoRechargesResponse',
  '2': [
    {
      '1': 'auto_recharges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.CableTVAutoRecharge',
      '10': 'autoRecharges'
    },
  ],
};

/// Descriptor for `GetCableTVAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVAutoRechargesResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRDYWJsZVRWQXV0b1JlY2hhcmdlc1Jlc3BvbnNlEksKDmF1dG9fcmVjaGFyZ2VzGAEgAy'
        'gLMiQudXRpbGl0eXBheW1lbnRzLkNhYmxlVFZBdXRvUmVjaGFyZ2VSDWF1dG9SZWNoYXJnZXM=');

@$core.Deprecated('Use updateCableTVAutoRechargeRequestDescriptor instead')
const UpdateCableTVAutoRechargeRequest$json = {
  '1': 'UpdateCableTVAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    {'1': 'variation_code', '3': 2, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'package_name', '3': 3, '4': 1, '5': 9, '10': 'packageName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 5, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 6, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 7, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 8, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 9, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 10, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVAutoRechargeRequestDescriptor = $convert.base64Decode(
    'CiBVcGRhdGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGA'
    'EgASgJUg5hdXRvUmVjaGFyZ2VJZBIlCg52YXJpYXRpb25fY29kZRgCIAEoCVINdmFyaWF0aW9u'
    'Q29kZRIhCgxwYWNrYWdlX25hbWUYAyABKAlSC3BhY2thZ2VOYW1lEhYKBmFtb3VudBgEIAEoAV'
    'IGYW1vdW50EhwKCWZyZXF1ZW5jeRgFIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAYg'
    'ASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAcgASgFUgpkYXlPZk1vbnRoEh8KC21heF'
    '9yZXRyaWVzGAggASgFUgptYXhSZXRyaWVzEiUKDmV4ZWN1dGlvbl9ob3VyGAkgASgFUg1leGVj'
    'dXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYCiABKAVSD2V4ZWN1dGlvbk1pbnV0ZQ==');

@$core.Deprecated('Use updateCableTVAutoRechargeResponseDescriptor instead')
const UpdateCableTVAutoRechargeResponse$json = {
  '1': 'UpdateCableTVAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.CableTVAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFVcGRhdGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVzcG9uc2USSQoNYXV0b19yZWNoYXJnZRgBIA'
        'EoCzIkLnV0aWxpdHlwYXltZW50cy5DYWJsZVRWQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2US'
        'GAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteCableTVAutoRechargeRequestDescriptor instead')
const DeleteCableTVAutoRechargeRequest$json = {
  '1': 'DeleteCableTVAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'CiBEZWxldGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGA'
        'EgASgJUg5hdXRvUmVjaGFyZ2VJZA==');

@$core.Deprecated('Use deleteCableTVAutoRechargeResponseDescriptor instead')
const DeleteCableTVAutoRechargeResponse$json = {
  '1': 'DeleteCableTVAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFEZWxldGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbW'
        'Vzc2FnZQ==');

@$core.Deprecated('Use pauseCableTVAutoRechargeRequestDescriptor instead')
const PauseCableTVAutoRechargeRequest$json = {
  '1': 'PauseCableTVAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseCableTVAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'Ch9QYXVzZUNhYmxlVFZBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYAS'
        'ABKAlSDmF1dG9SZWNoYXJnZUlk');

@$core.Deprecated('Use pauseCableTVAutoRechargeResponseDescriptor instead')
const PauseCableTVAutoRechargeResponse$json = {
  '1': 'PauseCableTVAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseCableTVAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiBQYXVzZUNhYmxlVFZBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZX'
        'NzYWdl');

@$core.Deprecated('Use resumeCableTVAutoRechargeRequestDescriptor instead')
const ResumeCableTVAutoRechargeRequest$json = {
  '1': 'ResumeCableTVAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeCableTVAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'CiBSZXN1bWVDYWJsZVRWQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGA'
        'EgASgJUg5hdXRvUmVjaGFyZ2VJZA==');

@$core.Deprecated('Use resumeCableTVAutoRechargeResponseDescriptor instead')
const ResumeCableTVAutoRechargeResponse$json = {
  '1': 'ResumeCableTVAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeCableTVAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFSZXN1bWVDYWJsZVRWQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbW'
        'Vzc2FnZQ==');

@$core.Deprecated('Use cableTVReminderDescriptor instead')
const CableTVReminder$json = {
  '1': 'CableTVReminder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'variation_code', '3': 8, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 10, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 11, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'notified_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'notifiedAt'
    },
    {
      '1': 'created_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `CableTVReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cableTVReminderDescriptor = $convert.base64Decode(
    'Cg9DYWJsZVRWUmVtaW5kZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBIlCg5iZW5lZmljaWFyeV9pZBgDIAEoCVINYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgEIAEo'
    'CVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2'
    'RhdGUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoG'
    'YW1vdW50GAcgASgBUgZhbW91bnQSJQoOdmFyaWF0aW9uX2NvZGUYCCABKAlSDXZhcmlhdGlvbk'
    'NvZGUSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EiEKDGlzX3JlY3VycmluZxgKIAEoCFIL'
    'aXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAsgASgJUg5yZWN1cnJlbmNlVHlwZRIWCg'
    'ZzdGF0dXMYDCABKAlSBnN0YXR1cxI7Cgtub3RpZmllZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90'
    'b2J1Zi5UaW1lc3RhbXBSCm5vdGlmaWVkQXQSOQoKY3JlYXRlZF9hdBgOIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GA8gASgLMhouZ29v'
    'Z2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use createCableTVReminderRequestDescriptor instead')
const CreateCableTVReminderRequest$json = {
  '1': 'CreateCableTVReminderRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'variation_code', '3': 6, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateCableTVReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCableTVReminderRequestDescriptor = $convert.base64Decode(
    'ChxDcmVhdGVDYWJsZVRWUmVtaW5kZXJSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgASgJUg'
    '1iZW5lZmljaWFyeUlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEo'
    'CVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIlCg52YXJp'
    'YXRpb25fY29kZRgGIAEoCVINdmFyaWF0aW9uQ29kZRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2'
    'lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgIIAEoCVIOcmVjdXJyZW5jZVR5cGUSGgoI'
    'Y3VycmVuY3kYCSABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use createCableTVReminderResponseDescriptor instead')
const CreateCableTVReminderResponse$json = {
  '1': 'CreateCableTVReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.CableTVReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateCableTVReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCableTVReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch1DcmVhdGVDYWJsZVRWUmVtaW5kZXJSZXNwb25zZRI8CghyZW1pbmRlchgBIAEoCzIgLnV0aW'
        'xpdHlwYXltZW50cy5DYWJsZVRWUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlS'
        'B21lc3NhZ2U=');

@$core.Deprecated('Use getCableTVRemindersRequestDescriptor instead')
const GetCableTVRemindersRequest$json = {
  '1': 'GetCableTVRemindersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetCableTVRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVRemindersRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRDYWJsZVRWUmVtaW5kZXJzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIhCg'
        'xpbmNsdWRlX3Bhc3QYAiABKAhSC2luY2x1ZGVQYXN0');

@$core.Deprecated('Use getCableTVRemindersResponseDescriptor instead')
const GetCableTVRemindersResponse$json = {
  '1': 'GetCableTVRemindersResponse',
  '2': [
    {
      '1': 'reminders',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.CableTVReminder',
      '10': 'reminders'
    },
  ],
};

/// Descriptor for `GetCableTVRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVRemindersResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXRDYWJsZVRWUmVtaW5kZXJzUmVzcG9uc2USPgoJcmVtaW5kZXJzGAEgAygLMiAudXRpbG'
        'l0eXBheW1lbnRzLkNhYmxlVFZSZW1pbmRlclIJcmVtaW5kZXJz');

@$core.Deprecated('Use updateCableTVReminderRequestDescriptor instead')
const UpdateCableTVReminderRequest$json = {
  '1': 'UpdateCableTVReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'variation_code', '3': 6, '4': 1, '5': 9, '10': 'variationCode'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateCableTVReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVReminderRequestDescriptor = $convert.base64Decode(
    'ChxVcGRhdGVDYWJsZVRWUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW'
    '1pbmRlcklkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVz'
    'Y3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIlCg52YXJpYXRpb25f'
    'Y29kZRgGIAEoCVINdmFyaWF0aW9uQ29kZRIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSIQ'
    'oMaXNfcmVjdXJyaW5nGAggASgIUgtpc1JlY3VycmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCSAB'
    'KAlSDnJlY3VycmVuY2VUeXBl');

@$core.Deprecated('Use updateCableTVReminderResponseDescriptor instead')
const UpdateCableTVReminderResponse$json = {
  '1': 'UpdateCableTVReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.CableTVReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateCableTVReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch1VcGRhdGVDYWJsZVRWUmVtaW5kZXJSZXNwb25zZRI8CghyZW1pbmRlchgBIAEoCzIgLnV0aW'
        'xpdHlwYXltZW50cy5DYWJsZVRWUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlS'
        'B21lc3NhZ2U=');

@$core.Deprecated('Use deleteCableTVReminderRequestDescriptor instead')
const DeleteCableTVReminderRequest$json = {
  '1': 'DeleteCableTVReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteCableTVReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVReminderRequestDescriptor =
    $convert.base64Decode(
        'ChxEZWxldGVDYWJsZVRWUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW'
        '1pbmRlcklk');

@$core.Deprecated('Use deleteCableTVReminderResponseDescriptor instead')
const DeleteCableTVReminderResponse$json = {
  '1': 'DeleteCableTVReminderResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCableTVReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch1EZWxldGVDYWJsZVRWUmVtaW5kZXJSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYW'
        'dl');

@$core.Deprecated('Use markCableTVReminderCompleteRequestDescriptor instead')
const MarkCableTVReminderCompleteRequest$json = {
  '1': 'MarkCableTVReminderCompleteRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkCableTVReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markCableTVReminderCompleteRequestDescriptor =
    $convert.base64Decode(
        'CiJNYXJrQ2FibGVUVlJlbWluZGVyQ29tcGxldGVSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgAS'
        'gJUgpyZW1pbmRlcklk');

@$core.Deprecated('Use markCableTVReminderCompleteResponseDescriptor instead')
const MarkCableTVReminderCompleteResponse$json = {
  '1': 'MarkCableTVReminderCompleteResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkCableTVReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markCableTVReminderCompleteResponseDescriptor =
    $convert.base64Decode(
        'CiNNYXJrQ2FibGVUVlJlbWluZGVyQ29tcGxldGVSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUg'
        'dtZXNzYWdl');

@$core.Deprecated('Use waterBeneficiaryDescriptor instead')
const WaterBeneficiary$json = {
  '1': 'WaterBeneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'provider_code', '3': 4, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 5, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'customer_name', '3': 7, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'last_amount', '3': 8, '4': 1, '5': 1, '10': 'lastAmount'},
    {
      '1': 'last_topup_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastTopupAt'
    },
    {'1': 'topup_count', '3': 10, '4': 1, '5': 5, '10': 'topupCount'},
    {
      '1': 'created_at',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `WaterBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waterBeneficiaryDescriptor = $convert.base64Decode(
    'ChBXYXRlckJlbmVmaWNpYXJ5Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSJQoOYWNjb3VudF9udW1iZXIYAyABKAlSDWFjY291bnROdW1iZXISIwoNcHJvdmlkZXJf'
    'Y29kZRgEIAEoCVIMcHJvdmlkZXJDb2RlEiMKDXByb3ZpZGVyX25hbWUYBSABKAlSDHByb3ZpZG'
    'VyTmFtZRIaCghuaWNrbmFtZRgGIAEoCVIIbmlja25hbWUSIwoNY3VzdG9tZXJfbmFtZRgHIAEo'
    'CVIMY3VzdG9tZXJOYW1lEh8KC2xhc3RfYW1vdW50GAggASgBUgpsYXN0QW1vdW50Ej4KDWxhc3'
    'RfdG9wdXBfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsYXN0VG9wdXBB'
    'dBIfCgt0b3B1cF9jb3VudBgKIAEoBVIKdG9wdXBDb3VudBI5CgpjcmVhdGVkX2F0GAsgASgLMh'
    'ouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDCAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use saveWaterBeneficiaryRequestDescriptor instead')
const SaveWaterBeneficiaryRequest$json = {
  '1': 'SaveWaterBeneficiaryRequest',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 3, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'customer_name', '3': 5, '4': 1, '5': 9, '10': 'customerName'},
  ],
};

/// Descriptor for `SaveWaterBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveWaterBeneficiaryRequestDescriptor = $convert.base64Decode(
    'ChtTYXZlV2F0ZXJCZW5lZmljaWFyeVJlcXVlc3QSJQoOYWNjb3VudF9udW1iZXIYASABKAlSDW'
    'FjY291bnROdW1iZXISIwoNcHJvdmlkZXJfY29kZRgCIAEoCVIMcHJvdmlkZXJDb2RlEiMKDXBy'
    'b3ZpZGVyX25hbWUYAyABKAlSDHByb3ZpZGVyTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja2'
    '5hbWUSIwoNY3VzdG9tZXJfbmFtZRgFIAEoCVIMY3VzdG9tZXJOYW1l');

@$core.Deprecated('Use saveWaterBeneficiaryResponseDescriptor instead')
const SaveWaterBeneficiaryResponse$json = {
  '1': 'SaveWaterBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.WaterBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveWaterBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveWaterBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'ChxTYXZlV2F0ZXJCZW5lZmljaWFyeVJlc3BvbnNlEkMKC2JlbmVmaWNpYXJ5GAEgASgLMiEudX'
        'RpbGl0eXBheW1lbnRzLldhdGVyQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21lc3NhZ2UY'
        'AiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getWaterBeneficiariesRequestDescriptor instead')
const GetWaterBeneficiariesRequest$json = {
  '1': 'GetWaterBeneficiariesRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetWaterBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterBeneficiariesRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRXYXRlckJlbmVmaWNpYXJpZXNSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKAlSDH'
        'Byb3ZpZGVyQ29kZQ==');

@$core.Deprecated('Use getWaterBeneficiariesResponseDescriptor instead')
const GetWaterBeneficiariesResponse$json = {
  '1': 'GetWaterBeneficiariesResponse',
  '2': [
    {
      '1': 'beneficiaries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.WaterBeneficiary',
      '10': 'beneficiaries'
    },
  ],
};

/// Descriptor for `GetWaterBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterBeneficiariesResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRXYXRlckJlbmVmaWNpYXJpZXNSZXNwb25zZRJHCg1iZW5lZmljaWFyaWVzGAEgAygLMi'
        'EudXRpbGl0eXBheW1lbnRzLldhdGVyQmVuZWZpY2lhcnlSDWJlbmVmaWNpYXJpZXM=');

@$core.Deprecated('Use updateWaterBeneficiaryRequestDescriptor instead')
const UpdateWaterBeneficiaryRequest$json = {
  '1': 'UpdateWaterBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateWaterBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'Ch1VcGRhdGVXYXRlckJlbmVmaWNpYXJ5UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSGgoIbmlja2'
        '5hbWUYAiABKAlSCG5pY2tuYW1l');

@$core.Deprecated('Use updateWaterBeneficiaryResponseDescriptor instead')
const UpdateWaterBeneficiaryResponse$json = {
  '1': 'UpdateWaterBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.WaterBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateWaterBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'Ch5VcGRhdGVXYXRlckJlbmVmaWNpYXJ5UmVzcG9uc2USQwoLYmVuZWZpY2lhcnkYASABKAsyIS'
        '51dGlsaXR5cGF5bWVudHMuV2F0ZXJCZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSGAoHbWVzc2Fn'
        'ZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteWaterBeneficiaryRequestDescriptor instead')
const DeleteWaterBeneficiaryRequest$json = {
  '1': 'DeleteWaterBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteWaterBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'Ch1EZWxldGVXYXRlckJlbmVmaWNpYXJ5UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use deleteWaterBeneficiaryResponseDescriptor instead')
const DeleteWaterBeneficiaryResponse$json = {
  '1': 'DeleteWaterBeneficiaryResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteWaterBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'Ch5EZWxldGVXYXRlckJlbmVmaWNpYXJ5UmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2'
        'FnZQ==');

@$core.Deprecated('Use waterAutoRechargeDescriptor instead')
const WaterAutoRecharge$json = {
  '1': 'WaterAutoRecharge',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 8, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 9, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 10, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'execution_hour', '3': 11, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 12, '4': 1, '5': 5, '10': 'executionMinute'},
    {
      '1': 'next_run_date',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'nextRunDate'
    },
    {
      '1': 'last_run_date',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastRunDate'
    },
    {'1': 'status', '3': 15, '4': 1, '5': 9, '10': 'status'},
    {'1': 'failure_count', '3': 16, '4': 1, '5': 5, '10': 'failureCount'},
    {'1': 'max_retries', '3': 17, '4': 1, '5': 5, '10': 'maxRetries'},
    {
      '1': 'created_at',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'beneficiary',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.WaterBeneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `WaterAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waterAutoRechargeDescriptor = $convert.base64Decode(
    'ChFXYXRlckF1dG9SZWNoYXJnZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdX'
    'NlcklkEiUKDmJlbmVmaWNpYXJ5X2lkGAMgASgJUg1iZW5lZmljaWFyeUlkEiUKDmFjY291bnRf'
    'bnVtYmVyGAQgASgJUg1hY2NvdW50TnVtYmVyEiMKDXByb3ZpZGVyX2NvZGUYBSABKAlSDHByb3'
    'ZpZGVyQ29kZRIWCgZhbW91bnQYBiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3Vy'
    'cmVuY3kSHAoJZnJlcXVlbmN5GAggASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYCSABKA'
    'VSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYCiABKAVSCmRheU9mTW9udGgSJQoOZXhlY3V0'
    'aW9uX2hvdXIYCyABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW9uX21pbnV0ZRgMIAEoBV'
    'IPZXhlY3V0aW9uTWludXRlEj4KDW5leHRfcnVuX2RhdGUYDSABKAsyGi5nb29nbGUucHJvdG9i'
    'dWYuVGltZXN0YW1wUgtuZXh0UnVuRGF0ZRI+Cg1sYXN0X3J1bl9kYXRlGA4gASgLMhouZ29vZ2'
    'xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFJ1bkRhdGUSFgoGc3RhdHVzGA8gASgJUgZzdGF0'
    'dXMSIwoNZmFpbHVyZV9jb3VudBgQIAEoBVIMZmFpbHVyZUNvdW50Eh8KC21heF9yZXRyaWVzGB'
    'EgASgFUgptYXhSZXRyaWVzEjkKCmNyZWF0ZWRfYXQYEiABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUgljcmVhdGVkQXQSQwoLYmVuZWZpY2lhcnkYEyABKAsyIS51dGlsaXR5cGF5bW'
    'VudHMuV2F0ZXJCZW5lZmljaWFyeVILYmVuZWZpY2lhcnk=');

@$core.Deprecated('Use createWaterAutoRechargeRequestDescriptor instead')
const CreateWaterAutoRechargeRequest$json = {
  '1': 'CreateWaterAutoRechargeRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 5, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 6, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 7, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 8, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 9, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaterAutoRechargeRequestDescriptor = $convert.base64Decode(
    'Ch5DcmVhdGVXYXRlckF1dG9SZWNoYXJnZVJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKA'
    'lSDWJlbmVmaWNpYXJ5SWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyAB'
    'KAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgEIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZW'
    'VrGAUgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAYgASgFUgpkYXlPZk1vbnRoEh8K'
    'C21heF9yZXRyaWVzGAcgASgFUgptYXhSZXRyaWVzEiUKDmV4ZWN1dGlvbl9ob3VyGAggASgFUg'
    '1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYCSABKAVSD2V4ZWN1dGlvbk1pbnV0'
    'ZQ==');

@$core.Deprecated('Use createWaterAutoRechargeResponseDescriptor instead')
const CreateWaterAutoRechargeResponse$json = {
  '1': 'CreateWaterAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.WaterAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaterAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch9DcmVhdGVXYXRlckF1dG9SZWNoYXJnZVJlc3BvbnNlEkcKDWF1dG9fcmVjaGFyZ2UYASABKA'
        'syIi51dGlsaXR5cGF5bWVudHMuV2F0ZXJBdXRvUmVjaGFyZ2VSDGF1dG9SZWNoYXJnZRIYCgdt'
        'ZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getWaterAutoRechargesRequestDescriptor instead')
const GetWaterAutoRechargesRequest$json = {
  '1': 'GetWaterAutoRechargesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetWaterAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterAutoRechargesRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRXYXRlckF1dG9SZWNoYXJnZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use getWaterAutoRechargesResponseDescriptor instead')
const GetWaterAutoRechargesResponse$json = {
  '1': 'GetWaterAutoRechargesResponse',
  '2': [
    {
      '1': 'auto_recharges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.WaterAutoRecharge',
      '10': 'autoRecharges'
    },
  ],
};

/// Descriptor for `GetWaterAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterAutoRechargesResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRXYXRlckF1dG9SZWNoYXJnZXNSZXNwb25zZRJJCg5hdXRvX3JlY2hhcmdlcxgBIAMoCz'
        'IiLnV0aWxpdHlwYXltZW50cy5XYXRlckF1dG9SZWNoYXJnZVINYXV0b1JlY2hhcmdlcw==');

@$core.Deprecated('Use updateWaterAutoRechargeRequestDescriptor instead')
const UpdateWaterAutoRechargeRequest$json = {
  '1': 'UpdateWaterAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 4, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 5, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 6, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 7, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 8, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterAutoRechargeRequestDescriptor = $convert.base64Decode(
    'Ch5VcGRhdGVXYXRlckF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIA'
    'EoCVIOYXV0b1JlY2hhcmdlSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSHAoJZnJlcXVlbmN5'
    'GAMgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYBCABKAVSCWRheU9mV2VlaxIgCgxkYX'
    'lfb2ZfbW9udGgYBSABKAVSCmRheU9mTW9udGgSHwoLbWF4X3JldHJpZXMYBiABKAVSCm1heFJl'
    'dHJpZXMSJQoOZXhlY3V0aW9uX2hvdXIYByABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW'
    '9uX21pbnV0ZRgIIAEoBVIPZXhlY3V0aW9uTWludXRl');

@$core.Deprecated('Use updateWaterAutoRechargeResponseDescriptor instead')
const UpdateWaterAutoRechargeResponse$json = {
  '1': 'UpdateWaterAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.WaterAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch9VcGRhdGVXYXRlckF1dG9SZWNoYXJnZVJlc3BvbnNlEkcKDWF1dG9fcmVjaGFyZ2UYASABKA'
        'syIi51dGlsaXR5cGF5bWVudHMuV2F0ZXJBdXRvUmVjaGFyZ2VSDGF1dG9SZWNoYXJnZRIYCgdt'
        'ZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use deleteWaterAutoRechargeRequestDescriptor instead')
const DeleteWaterAutoRechargeRequest$json = {
  '1': 'DeleteWaterAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'Ch5EZWxldGVXYXRlckF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIA'
        'EoCVIOYXV0b1JlY2hhcmdlSWQ=');

@$core.Deprecated('Use deleteWaterAutoRechargeResponseDescriptor instead')
const DeleteWaterAutoRechargeResponse$json = {
  '1': 'DeleteWaterAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch9EZWxldGVXYXRlckF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3'
        'NhZ2U=');

@$core.Deprecated('Use pauseWaterAutoRechargeRequestDescriptor instead')
const PauseWaterAutoRechargeRequest$json = {
  '1': 'PauseWaterAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseWaterAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'Ch1QYXVzZVdhdGVyQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgAS'
        'gJUg5hdXRvUmVjaGFyZ2VJZA==');

@$core.Deprecated('Use pauseWaterAutoRechargeResponseDescriptor instead')
const PauseWaterAutoRechargeResponse$json = {
  '1': 'PauseWaterAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseWaterAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch5QYXVzZVdhdGVyQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2'
        'FnZQ==');

@$core.Deprecated('Use resumeWaterAutoRechargeRequestDescriptor instead')
const ResumeWaterAutoRechargeRequest$json = {
  '1': 'ResumeWaterAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeWaterAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'Ch5SZXN1bWVXYXRlckF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIA'
        'EoCVIOYXV0b1JlY2hhcmdlSWQ=');

@$core.Deprecated('Use resumeWaterAutoRechargeResponseDescriptor instead')
const ResumeWaterAutoRechargeResponse$json = {
  '1': 'ResumeWaterAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeWaterAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'Ch9SZXN1bWVXYXRlckF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3'
        'NhZ2U=');

@$core.Deprecated('Use waterReminderDescriptor instead')
const WaterReminder$json = {
  '1': 'WaterReminder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 9, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 10, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'notified_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'notifiedAt'
    },
    {
      '1': 'created_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `WaterReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waterReminderDescriptor = $convert.base64Decode(
    'Cg1XYXRlclJlbWluZGVyEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySW'
    'QSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUYBCABKAlS'
    'BXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYX'
    'RlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFt'
    'b3VudBgHIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIhCgxpc19yZW'
    'N1cnJpbmcYCSABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgKIAEoCVIOcmVj'
    'dXJyZW5jZVR5cGUSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSOwoLbm90aWZpZWRfYXQYDCABKA'
    'syGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpub3RpZmllZEF0EjkKCmNyZWF0ZWRfYXQY'
    'DSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF'
    '9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use createWaterReminderRequestDescriptor instead')
const CreateWaterReminderRequest$json = {
  '1': 'CreateWaterReminderRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `CreateWaterReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaterReminderRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVXYXRlclJlbWluZGVyUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIAEoCVINYm'
    'VuZWZpY2lhcnlJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlS'
    'C2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVG'
    'ltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSGgoIY3VycmVu'
    'Y3kYBiABKAlSCGN1cnJlbmN5EiEKDGlzX3JlY3VycmluZxgHIAEoCFILaXNSZWN1cnJpbmcSJw'
    'oPcmVjdXJyZW5jZV90eXBlGAggASgJUg5yZWN1cnJlbmNlVHlwZQ==');

@$core.Deprecated('Use createWaterReminderResponseDescriptor instead')
const CreateWaterReminderResponse$json = {
  '1': 'CreateWaterReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.WaterReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateWaterReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaterReminderResponseDescriptor =
    $convert.base64Decode(
        'ChtDcmVhdGVXYXRlclJlbWluZGVyUmVzcG9uc2USOgoIcmVtaW5kZXIYASABKAsyHi51dGlsaX'
        'R5cGF5bWVudHMuV2F0ZXJSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVz'
        'c2FnZQ==');

@$core.Deprecated('Use getWaterRemindersRequestDescriptor instead')
const GetWaterRemindersRequest$json = {
  '1': 'GetWaterRemindersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetWaterRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterRemindersRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRXYXRlclJlbWluZGVyc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSIQoMaW'
        '5jbHVkZV9wYXN0GAIgASgIUgtpbmNsdWRlUGFzdA==');

@$core.Deprecated('Use getWaterRemindersResponseDescriptor instead')
const GetWaterRemindersResponse$json = {
  '1': 'GetWaterRemindersResponse',
  '2': [
    {
      '1': 'reminders',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.WaterReminder',
      '10': 'reminders'
    },
  ],
};

/// Descriptor for `GetWaterRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterRemindersResponseDescriptor =
    $convert.base64Decode(
        'ChlHZXRXYXRlclJlbWluZGVyc1Jlc3BvbnNlEjwKCXJlbWluZGVycxgBIAMoCzIeLnV0aWxpdH'
        'lwYXltZW50cy5XYXRlclJlbWluZGVyUglyZW1pbmRlcnM=');

@$core.Deprecated('Use updateWaterReminderRequestDescriptor instead')
const UpdateWaterReminderRequest$json = {
  '1': 'UpdateWaterReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateWaterReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterReminderRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVXYXRlclJlbWluZGVyUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcmVtaW'
    '5kZXJJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2Ny'
    'aXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBiAB'
    'KAlSCGN1cnJlbmN5EiEKDGlzX3JlY3VycmluZxgHIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdX'
    'JyZW5jZV90eXBlGAggASgJUg5yZWN1cnJlbmNlVHlwZQ==');

@$core.Deprecated('Use updateWaterReminderResponseDescriptor instead')
const UpdateWaterReminderResponse$json = {
  '1': 'UpdateWaterReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.WaterReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateWaterReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterReminderResponseDescriptor =
    $convert.base64Decode(
        'ChtVcGRhdGVXYXRlclJlbWluZGVyUmVzcG9uc2USOgoIcmVtaW5kZXIYASABKAsyHi51dGlsaX'
        'R5cGF5bWVudHMuV2F0ZXJSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVz'
        'c2FnZQ==');

@$core.Deprecated('Use deleteWaterReminderRequestDescriptor instead')
const DeleteWaterReminderRequest$json = {
  '1': 'DeleteWaterReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteWaterReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterReminderRequestDescriptor =
    $convert.base64Decode(
        'ChpEZWxldGVXYXRlclJlbWluZGVyUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcmVtaW'
        '5kZXJJZA==');

@$core.Deprecated('Use deleteWaterReminderResponseDescriptor instead')
const DeleteWaterReminderResponse$json = {
  '1': 'DeleteWaterReminderResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteWaterReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterReminderResponseDescriptor =
    $convert.base64Decode(
        'ChtEZWxldGVXYXRlclJlbWluZGVyUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ'
        '==');

@$core.Deprecated('Use markWaterReminderCompleteRequestDescriptor instead')
const MarkWaterReminderCompleteRequest$json = {
  '1': 'MarkWaterReminderCompleteRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkWaterReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markWaterReminderCompleteRequestDescriptor =
    $convert.base64Decode(
        'CiBNYXJrV2F0ZXJSZW1pbmRlckNvbXBsZXRlUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCV'
        'IKcmVtaW5kZXJJZA==');

@$core.Deprecated('Use markWaterReminderCompleteResponseDescriptor instead')
const MarkWaterReminderCompleteResponse$json = {
  '1': 'MarkWaterReminderCompleteResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkWaterReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markWaterReminderCompleteResponseDescriptor =
    $convert.base64Decode(
        'CiFNYXJrV2F0ZXJSZW1pbmRlckNvbXBsZXRlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbW'
        'Vzc2FnZQ==');

@$core.Deprecated('Use intlAirtimeCountryDescriptor instead')
const IntlAirtimeCountry$json = {
  '1': 'IntlAirtimeCountry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'dial_code', '3': 4, '4': 1, '5': 9, '10': 'dialCode'},
    {'1': 'currency_code', '3': 5, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'currency_symbol', '3': 6, '4': 1, '5': 9, '10': 'currencySymbol'},
    {'1': 'flag_emoji', '3': 7, '4': 1, '5': 9, '10': 'flagEmoji'},
    {'1': 'is_active', '3': 8, '4': 1, '5': 8, '10': 'isActive'},
    {
      '1': 'reloadly_supported',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'reloadlySupported'
    },
    {'1': 'vtpass_supported', '3': 10, '4': 1, '5': 8, '10': 'vtpassSupported'},
    {'1': 'operator_count', '3': 11, '4': 1, '5': 5, '10': 'operatorCount'},
  ],
};

/// Descriptor for `IntlAirtimeCountry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intlAirtimeCountryDescriptor = $convert.base64Decode(
    'ChJJbnRsQWlydGltZUNvdW50cnkSDgoCaWQYASABKAlSAmlkEiEKDGNvdW50cnlfY29kZRgCIA'
    'EoCVILY291bnRyeUNvZGUSIQoMY291bnRyeV9uYW1lGAMgASgJUgtjb3VudHJ5TmFtZRIbCglk'
    'aWFsX2NvZGUYBCABKAlSCGRpYWxDb2RlEiMKDWN1cnJlbmN5X2NvZGUYBSABKAlSDGN1cnJlbm'
    'N5Q29kZRInCg9jdXJyZW5jeV9zeW1ib2wYBiABKAlSDmN1cnJlbmN5U3ltYm9sEh0KCmZsYWdf'
    'ZW1vamkYByABKAlSCWZsYWdFbW9qaRIbCglpc19hY3RpdmUYCCABKAhSCGlzQWN0aXZlEi0KEn'
    'JlbG9hZGx5X3N1cHBvcnRlZBgJIAEoCFIRcmVsb2FkbHlTdXBwb3J0ZWQSKQoQdnRwYXNzX3N1'
    'cHBvcnRlZBgKIAEoCFIPdnRwYXNzU3VwcG9ydGVkEiUKDm9wZXJhdG9yX2NvdW50GAsgASgFUg'
    '1vcGVyYXRvckNvdW50');

@$core.Deprecated('Use intlAirtimeOperatorDescriptor instead')
const IntlAirtimeOperator$json = {
  '1': 'IntlAirtimeOperator',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'operator_name', '3': 4, '4': 1, '5': 9, '10': 'operatorName'},
    {
      '1': 'reloadly_operator_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'reloadlyOperatorId'
    },
    {
      '1': 'vtpass_operator_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'vtpassOperatorId'
    },
    {
      '1': 'denomination_type',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'denominationType'
    },
    {
      '1': 'sender_currency_code',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'senderCurrencyCode'
    },
    {
      '1': 'dest_currency_code',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'destCurrencyCode'
    },
    {'1': 'fx_rate', '3': 10, '4': 1, '5': 1, '10': 'fxRate'},
    {'1': 'min_amount', '3': 11, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 12, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'local_min_amount', '3': 13, '4': 1, '5': 1, '10': 'localMinAmount'},
    {'1': 'local_max_amount', '3': 14, '4': 1, '5': 1, '10': 'localMaxAmount'},
    {'1': 'fixed_amounts', '3': 15, '4': 1, '5': 9, '10': 'fixedAmounts'},
    {
      '1': 'local_fixed_amounts',
      '3': 16,
      '4': 1,
      '5': 9,
      '10': 'localFixedAmounts'
    },
    {
      '1': 'supports_local_amounts',
      '3': 17,
      '4': 1,
      '5': 8,
      '10': 'supportsLocalAmounts'
    },
    {'1': 'logo_url', '3': 18, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 19, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `IntlAirtimeOperator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intlAirtimeOperatorDescriptor = $convert.base64Decode(
    'ChNJbnRsQWlydGltZU9wZXJhdG9yEg4KAmlkGAEgASgJUgJpZBIhCgxjb3VudHJ5X2NvZGUYAi'
    'ABKAlSC2NvdW50cnlDb2RlEiEKDGNvdW50cnlfbmFtZRgDIAEoCVILY291bnRyeU5hbWUSIwoN'
    'b3BlcmF0b3JfbmFtZRgEIAEoCVIMb3BlcmF0b3JOYW1lEjAKFHJlbG9hZGx5X29wZXJhdG9yX2'
    'lkGAUgASgJUhJyZWxvYWRseU9wZXJhdG9ySWQSLAoSdnRwYXNzX29wZXJhdG9yX2lkGAYgASgJ'
    'UhB2dHBhc3NPcGVyYXRvcklkEisKEWRlbm9taW5hdGlvbl90eXBlGAcgASgJUhBkZW5vbWluYX'
    'Rpb25UeXBlEjAKFHNlbmRlcl9jdXJyZW5jeV9jb2RlGAggASgJUhJzZW5kZXJDdXJyZW5jeUNv'
    'ZGUSLAoSZGVzdF9jdXJyZW5jeV9jb2RlGAkgASgJUhBkZXN0Q3VycmVuY3lDb2RlEhcKB2Z4X3'
    'JhdGUYCiABKAFSBmZ4UmF0ZRIdCgptaW5fYW1vdW50GAsgASgBUgltaW5BbW91bnQSHQoKbWF4'
    'X2Ftb3VudBgMIAEoAVIJbWF4QW1vdW50EigKEGxvY2FsX21pbl9hbW91bnQYDSABKAFSDmxvY2'
    'FsTWluQW1vdW50EigKEGxvY2FsX21heF9hbW91bnQYDiABKAFSDmxvY2FsTWF4QW1vdW50EiMK'
    'DWZpeGVkX2Ftb3VudHMYDyABKAlSDGZpeGVkQW1vdW50cxIuChNsb2NhbF9maXhlZF9hbW91bn'
    'RzGBAgASgJUhFsb2NhbEZpeGVkQW1vdW50cxI0ChZzdXBwb3J0c19sb2NhbF9hbW91bnRzGBEg'
    'ASgIUhRzdXBwb3J0c0xvY2FsQW1vdW50cxIZCghsb2dvX3VybBgSIAEoCVIHbG9nb1VybBIbCg'
    'lpc19hY3RpdmUYEyABKAhSCGlzQWN0aXZl');

@$core.Deprecated('Use getIntlAirtimeCountriesRequestDescriptor instead')
const GetIntlAirtimeCountriesRequest$json = {
  '1': 'GetIntlAirtimeCountriesRequest',
  '2': [
    {'1': 'include_inactive', '3': 1, '4': 1, '5': 8, '10': 'includeInactive'},
  ],
};

/// Descriptor for `GetIntlAirtimeCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlAirtimeCountriesRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRJbnRsQWlydGltZUNvdW50cmllc1JlcXVlc3QSKQoQaW5jbHVkZV9pbmFjdGl2ZRgBIA'
        'EoCFIPaW5jbHVkZUluYWN0aXZl');

@$core.Deprecated('Use getIntlAirtimeCountriesResponseDescriptor instead')
const GetIntlAirtimeCountriesResponse$json = {
  '1': 'GetIntlAirtimeCountriesResponse',
  '2': [
    {
      '1': 'countries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.IntlAirtimeCountry',
      '10': 'countries'
    },
  ],
};

/// Descriptor for `GetIntlAirtimeCountriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlAirtimeCountriesResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRJbnRsQWlydGltZUNvdW50cmllc1Jlc3BvbnNlEkEKCWNvdW50cmllcxgBIAMoCzIjLn'
        'V0aWxpdHlwYXltZW50cy5JbnRsQWlydGltZUNvdW50cnlSCWNvdW50cmllcw==');

@$core.Deprecated('Use getIntlAirtimeOperatorsRequestDescriptor instead')
const GetIntlAirtimeOperatorsRequest$json = {
  '1': 'GetIntlAirtimeOperatorsRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetIntlAirtimeOperatorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlAirtimeOperatorsRequestDescriptor =
    $convert.base64Decode(
        'Ch5HZXRJbnRsQWlydGltZU9wZXJhdG9yc1JlcXVlc3QSIQoMY291bnRyeV9jb2RlGAEgASgJUg'
        'tjb3VudHJ5Q29kZQ==');

@$core.Deprecated('Use getIntlAirtimeOperatorsResponseDescriptor instead')
const GetIntlAirtimeOperatorsResponse$json = {
  '1': 'GetIntlAirtimeOperatorsResponse',
  '2': [
    {
      '1': 'operators',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.IntlAirtimeOperator',
      '10': 'operators'
    },
    {'1': 'country_name', '3': 2, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'currency_code', '3': 3, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'currency_symbol', '3': 4, '4': 1, '5': 9, '10': 'currencySymbol'},
  ],
};

/// Descriptor for `GetIntlAirtimeOperatorsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlAirtimeOperatorsResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRJbnRsQWlydGltZU9wZXJhdG9yc1Jlc3BvbnNlEkIKCW9wZXJhdG9ycxgBIAMoCzIkLn'
        'V0aWxpdHlwYXltZW50cy5JbnRsQWlydGltZU9wZXJhdG9yUglvcGVyYXRvcnMSIQoMY291bnRy'
        'eV9uYW1lGAIgASgJUgtjb3VudHJ5TmFtZRIjCg1jdXJyZW5jeV9jb2RlGAMgASgJUgxjdXJyZW'
        '5jeUNvZGUSJwoPY3VycmVuY3lfc3ltYm9sGAQgASgJUg5jdXJyZW5jeVN5bWJvbA==');

@$core.Deprecated('Use autoDetectIntlOperatorRequestDescriptor instead')
const AutoDetectIntlOperatorRequest$json = {
  '1': 'AutoDetectIntlOperatorRequest',
  '2': [
    {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `AutoDetectIntlOperatorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoDetectIntlOperatorRequestDescriptor =
    $convert.base64Decode(
        'Ch1BdXRvRGV0ZWN0SW50bE9wZXJhdG9yUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3'
        'Bob25lTnVtYmVyEiEKDGNvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGU=');

@$core.Deprecated('Use autoDetectIntlOperatorResponseDescriptor instead')
const AutoDetectIntlOperatorResponse$json = {
  '1': 'AutoDetectIntlOperatorResponse',
  '2': [
    {
      '1': 'operator',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.IntlAirtimeOperator',
      '10': 'operator'
    },
    {'1': 'detected', '3': 2, '4': 1, '5': 8, '10': 'detected'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AutoDetectIntlOperatorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoDetectIntlOperatorResponseDescriptor =
    $convert.base64Decode(
        'Ch5BdXRvRGV0ZWN0SW50bE9wZXJhdG9yUmVzcG9uc2USQAoIb3BlcmF0b3IYASABKAsyJC51dG'
        'lsaXR5cGF5bWVudHMuSW50bEFpcnRpbWVPcGVyYXRvclIIb3BlcmF0b3ISGgoIZGV0ZWN0ZWQY'
        'AiABKAhSCGRldGVjdGVkEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use buyIntlAirtimeRequestDescriptor instead')
const BuyIntlAirtimeRequest$json = {
  '1': 'BuyIntlAirtimeRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'idempotency_key', '3': 2, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'operator_id', '3': 3, '4': 1, '5': 9, '10': 'operatorId'},
    {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'sender_currency', '3': 7, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'use_local_amount', '3': 8, '4': 1, '5': 1, '10': 'useLocalAmount'},
    {'1': 'fx_rate_snapshot', '3': 9, '4': 1, '5': 1, '10': 'fxRateSnapshot'},
    {'1': 'dest_currency', '3': 10, '4': 1, '5': 9, '10': 'destCurrency'},
    {
      '1': 'dest_amount_estimate',
      '3': 11,
      '4': 1,
      '5': 1,
      '10': 'destAmountEstimate'
    },
    {'1': 'transaction_pin', '3': 12, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `BuyIntlAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyIntlAirtimeRequestDescriptor = $convert.base64Decode(
    'ChVCdXlJbnRsQWlydGltZVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEi'
    'cKD2lkZW1wb3RlbmN5X2tleRgCIAEoCVIOaWRlbXBvdGVuY3lLZXkSHwoLb3BlcmF0b3JfaWQY'
    'AyABKAlSCm9wZXJhdG9ySWQSIQoMY291bnRyeV9jb2RlGAQgASgJUgtjb3VudHJ5Q29kZRIhCg'
    'xwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50'
    'EicKD3NlbmRlcl9jdXJyZW5jeRgHIAEoCVIOc2VuZGVyQ3VycmVuY3kSKAoQdXNlX2xvY2FsX2'
    'Ftb3VudBgIIAEoAVIOdXNlTG9jYWxBbW91bnQSKAoQZnhfcmF0ZV9zbmFwc2hvdBgJIAEoAVIO'
    'ZnhSYXRlU25hcHNob3QSIwoNZGVzdF9jdXJyZW5jeRgKIAEoCVIMZGVzdEN1cnJlbmN5EjAKFG'
    'Rlc3RfYW1vdW50X2VzdGltYXRlGAsgASgBUhJkZXN0QW1vdW50RXN0aW1hdGUSJwoPdHJhbnNh'
    'Y3Rpb25fcGluGAwgASgJUg50cmFuc2FjdGlvblBpbg==');

@$core.Deprecated('Use buyIntlAirtimeResponseDescriptor instead')
const BuyIntlAirtimeResponse$json = {
  '1': 'BuyIntlAirtimeResponse',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'amount_paid', '3': 4, '4': 1, '5': 1, '10': 'amountPaid'},
    {'1': 'sender_currency', '3': 5, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'delivered_amount', '3': 6, '4': 1, '5': 1, '10': 'deliveredAmount'},
    {
      '1': 'delivered_currency',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'deliveredCurrency'
    },
    {'1': 'fx_rate_used', '3': 8, '4': 1, '5': 1, '10': 'fxRateUsed'},
    {'1': 'operator_name', '3': 9, '4': 1, '5': 9, '10': 'operatorName'},
    {'1': 'country_name', '3': 10, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'message', '3': 12, '4': 1, '5': 9, '10': 'message'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `BuyIntlAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyIntlAirtimeResponseDescriptor = $convert.base64Decode(
    'ChZCdXlJbnRsQWlydGltZVJlc3BvbnNlEh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZB'
    'IcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIf'
    'CgthbW91bnRfcGFpZBgEIAEoAVIKYW1vdW50UGFpZBInCg9zZW5kZXJfY3VycmVuY3kYBSABKA'
    'lSDnNlbmRlckN1cnJlbmN5EikKEGRlbGl2ZXJlZF9hbW91bnQYBiABKAFSD2RlbGl2ZXJlZEFt'
    'b3VudBItChJkZWxpdmVyZWRfY3VycmVuY3kYByABKAlSEWRlbGl2ZXJlZEN1cnJlbmN5EiAKDG'
    'Z4X3JhdGVfdXNlZBgIIAEoAVIKZnhSYXRlVXNlZBIjCg1vcGVyYXRvcl9uYW1lGAkgASgJUgxv'
    'cGVyYXRvck5hbWUSIQoMY291bnRyeV9uYW1lGAogASgJUgtjb3VudHJ5TmFtZRIhCgxwaG9uZV'
    '9udW1iZXIYCyABKAlSC3Bob25lTnVtYmVyEhgKB21lc3NhZ2UYDCABKAlSB21lc3NhZ2USHQoK'
    'Y3JlYXRlZF9hdBgNIAEoCVIJY3JlYXRlZEF0');

@$core.Deprecated('Use intlDataBundleDescriptor instead')
const IntlDataBundle$json = {
  '1': 'IntlDataBundle',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'operator_id', '3': 2, '4': 1, '5': 9, '10': 'operatorId'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'local_amount', '3': 4, '4': 1, '5': 1, '10': 'localAmount'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'dest_currency_code',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'destCurrencyCode'
    },
    {
      '1': 'sender_currency_code',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'senderCurrencyCode'
    },
    {'1': 'fx_rate', '3': 8, '4': 1, '5': 1, '10': 'fxRate'},
  ],
};

/// Descriptor for `IntlDataBundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intlDataBundleDescriptor = $convert.base64Decode(
    'Cg5JbnRsRGF0YUJ1bmRsZRIOCgJpZBgBIAEoCVICaWQSHwoLb3BlcmF0b3JfaWQYAiABKAlSCm'
    '9wZXJhdG9ySWQSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSIQoMbG9jYWxfYW1vdW50GAQgASgB'
    'Ugtsb2NhbEFtb3VudBIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SLAoSZGVzdF'
    '9jdXJyZW5jeV9jb2RlGAYgASgJUhBkZXN0Q3VycmVuY3lDb2RlEjAKFHNlbmRlcl9jdXJyZW5j'
    'eV9jb2RlGAcgASgJUhJzZW5kZXJDdXJyZW5jeUNvZGUSFwoHZnhfcmF0ZRgIIAEoAVIGZnhSYX'
    'Rl');

@$core.Deprecated('Use intlDataOperatorDescriptor instead')
const IntlDataOperator$json = {
  '1': 'IntlDataOperator',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'operator_name', '3': 4, '4': 1, '5': 9, '10': 'operatorName'},
    {
      '1': 'reloadly_operator_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'reloadlyOperatorId'
    },
    {
      '1': 'sender_currency_code',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'senderCurrencyCode'
    },
    {
      '1': 'dest_currency_code',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'destCurrencyCode'
    },
    {'1': 'fx_rate', '3': 8, '4': 1, '5': 1, '10': 'fxRate'},
    {'1': 'logo_url', '3': 9, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 10, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'bundle_count', '3': 11, '4': 1, '5': 5, '10': 'bundleCount'},
  ],
};

/// Descriptor for `IntlDataOperator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intlDataOperatorDescriptor = $convert.base64Decode(
    'ChBJbnRsRGF0YU9wZXJhdG9yEg4KAmlkGAEgASgJUgJpZBIhCgxjb3VudHJ5X2NvZGUYAiABKA'
    'lSC2NvdW50cnlDb2RlEiEKDGNvdW50cnlfbmFtZRgDIAEoCVILY291bnRyeU5hbWUSIwoNb3Bl'
    'cmF0b3JfbmFtZRgEIAEoCVIMb3BlcmF0b3JOYW1lEjAKFHJlbG9hZGx5X29wZXJhdG9yX2lkGA'
    'UgASgJUhJyZWxvYWRseU9wZXJhdG9ySWQSMAoUc2VuZGVyX2N1cnJlbmN5X2NvZGUYBiABKAlS'
    'EnNlbmRlckN1cnJlbmN5Q29kZRIsChJkZXN0X2N1cnJlbmN5X2NvZGUYByABKAlSEGRlc3RDdX'
    'JyZW5jeUNvZGUSFwoHZnhfcmF0ZRgIIAEoAVIGZnhSYXRlEhkKCGxvZ29fdXJsGAkgASgJUgds'
    'b2dvVXJsEhsKCWlzX2FjdGl2ZRgKIAEoCFIIaXNBY3RpdmUSIQoMYnVuZGxlX2NvdW50GAsgAS'
    'gFUgtidW5kbGVDb3VudA==');

@$core.Deprecated('Use getIntlDataOperatorsRequestDescriptor instead')
const GetIntlDataOperatorsRequest$json = {
  '1': 'GetIntlDataOperatorsRequest',
  '2': [
    {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetIntlDataOperatorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlDataOperatorsRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRJbnRsRGF0YU9wZXJhdG9yc1JlcXVlc3QSIQoMY291bnRyeV9jb2RlGAEgASgJUgtjb3'
        'VudHJ5Q29kZQ==');

@$core.Deprecated('Use getIntlDataOperatorsResponseDescriptor instead')
const GetIntlDataOperatorsResponse$json = {
  '1': 'GetIntlDataOperatorsResponse',
  '2': [
    {
      '1': 'operators',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.IntlDataOperator',
      '10': 'operators'
    },
    {'1': 'country_name', '3': 2, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'currency_code', '3': 3, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'currency_symbol', '3': 4, '4': 1, '5': 9, '10': 'currencySymbol'},
  ],
};

/// Descriptor for `GetIntlDataOperatorsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlDataOperatorsResponseDescriptor = $convert.base64Decode(
    'ChxHZXRJbnRsRGF0YU9wZXJhdG9yc1Jlc3BvbnNlEj8KCW9wZXJhdG9ycxgBIAMoCzIhLnV0aW'
    'xpdHlwYXltZW50cy5JbnRsRGF0YU9wZXJhdG9yUglvcGVyYXRvcnMSIQoMY291bnRyeV9uYW1l'
    'GAIgASgJUgtjb3VudHJ5TmFtZRIjCg1jdXJyZW5jeV9jb2RlGAMgASgJUgxjdXJyZW5jeUNvZG'
    'USJwoPY3VycmVuY3lfc3ltYm9sGAQgASgJUg5jdXJyZW5jeVN5bWJvbA==');

@$core.Deprecated('Use getIntlDataBundlesRequestDescriptor instead')
const GetIntlDataBundlesRequest$json = {
  '1': 'GetIntlDataBundlesRequest',
  '2': [
    {'1': 'operator_id', '3': 1, '4': 1, '5': 9, '10': 'operatorId'},
  ],
};

/// Descriptor for `GetIntlDataBundlesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlDataBundlesRequestDescriptor =
    $convert.base64Decode(
        'ChlHZXRJbnRsRGF0YUJ1bmRsZXNSZXF1ZXN0Eh8KC29wZXJhdG9yX2lkGAEgASgJUgpvcGVyYX'
        'Rvcklk');

@$core.Deprecated('Use getIntlDataBundlesResponseDescriptor instead')
const GetIntlDataBundlesResponse$json = {
  '1': 'GetIntlDataBundlesResponse',
  '2': [
    {
      '1': 'bundles',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.IntlDataBundle',
      '10': 'bundles'
    },
    {
      '1': 'operator',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.IntlDataOperator',
      '10': 'operator'
    },
  ],
};

/// Descriptor for `GetIntlDataBundlesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlDataBundlesResponseDescriptor =
    $convert.base64Decode(
        'ChpHZXRJbnRsRGF0YUJ1bmRsZXNSZXNwb25zZRI5CgdidW5kbGVzGAEgAygLMh8udXRpbGl0eX'
        'BheW1lbnRzLkludGxEYXRhQnVuZGxlUgdidW5kbGVzEj0KCG9wZXJhdG9yGAIgASgLMiEudXRp'
        'bGl0eXBheW1lbnRzLkludGxEYXRhT3BlcmF0b3JSCG9wZXJhdG9y');

@$core.Deprecated('Use buyIntlDataRequestDescriptor instead')
const BuyIntlDataRequest$json = {
  '1': 'BuyIntlDataRequest',
  '2': [
    {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    {'1': 'idempotency_key', '3': 2, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'operator_id', '3': 3, '4': 1, '5': 9, '10': 'operatorId'},
    {'1': 'bundle_id', '3': 4, '4': 1, '5': 9, '10': 'bundleId'},
    {'1': 'country_code', '3': 5, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'sender_currency', '3': 8, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'dest_amount', '3': 9, '4': 1, '5': 1, '10': 'destAmount'},
    {'1': 'dest_currency', '3': 10, '4': 1, '5': 9, '10': 'destCurrency'},
    {'1': 'fx_rate_snapshot', '3': 11, '4': 1, '5': 1, '10': 'fxRateSnapshot'},
    {'1': 'transaction_pin', '3': 12, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `BuyIntlDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyIntlDataRequestDescriptor = $convert.base64Decode(
    'ChJCdXlJbnRsRGF0YVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEicKD2'
    'lkZW1wb3RlbmN5X2tleRgCIAEoCVIOaWRlbXBvdGVuY3lLZXkSHwoLb3BlcmF0b3JfaWQYAyAB'
    'KAlSCm9wZXJhdG9ySWQSGwoJYnVuZGxlX2lkGAQgASgJUghidW5kbGVJZBIhCgxjb3VudHJ5X2'
    'NvZGUYBSABKAlSC2NvdW50cnlDb2RlEiEKDHBob25lX251bWJlchgGIAEoCVILcGhvbmVOdW1i'
    'ZXISFgoGYW1vdW50GAcgASgBUgZhbW91bnQSJwoPc2VuZGVyX2N1cnJlbmN5GAggASgJUg5zZW'
    '5kZXJDdXJyZW5jeRIfCgtkZXN0X2Ftb3VudBgJIAEoAVIKZGVzdEFtb3VudBIjCg1kZXN0X2N1'
    'cnJlbmN5GAogASgJUgxkZXN0Q3VycmVuY3kSKAoQZnhfcmF0ZV9zbmFwc2hvdBgLIAEoAVIOZn'
    'hSYXRlU25hcHNob3QSJwoPdHJhbnNhY3Rpb25fcGluGAwgASgJUg50cmFuc2FjdGlvblBpbg==');

@$core.Deprecated('Use buyIntlDataResponseDescriptor instead')
const BuyIntlDataResponse$json = {
  '1': 'BuyIntlDataResponse',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'amount_paid', '3': 4, '4': 1, '5': 1, '10': 'amountPaid'},
    {'1': 'sender_currency', '3': 5, '4': 1, '5': 9, '10': 'senderCurrency'},
    {'1': 'delivered_amount', '3': 6, '4': 1, '5': 1, '10': 'deliveredAmount'},
    {
      '1': 'delivered_currency',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'deliveredCurrency'
    },
    {'1': 'fx_rate_used', '3': 8, '4': 1, '5': 1, '10': 'fxRateUsed'},
    {'1': 'operator_name', '3': 9, '4': 1, '5': 9, '10': 'operatorName'},
    {'1': 'country_name', '3': 10, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    {
      '1': 'bundle_description',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'bundleDescription'
    },
    {'1': 'message', '3': 13, '4': 1, '5': 9, '10': 'message'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `BuyIntlDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyIntlDataResponseDescriptor = $convert.base64Decode(
    'ChNCdXlJbnRsRGF0YVJlc3BvbnNlEh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZBIcCg'
    'lyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIfCgth'
    'bW91bnRfcGFpZBgEIAEoAVIKYW1vdW50UGFpZBInCg9zZW5kZXJfY3VycmVuY3kYBSABKAlSDn'
    'NlbmRlckN1cnJlbmN5EikKEGRlbGl2ZXJlZF9hbW91bnQYBiABKAFSD2RlbGl2ZXJlZEFtb3Vu'
    'dBItChJkZWxpdmVyZWRfY3VycmVuY3kYByABKAlSEWRlbGl2ZXJlZEN1cnJlbmN5EiAKDGZ4X3'
    'JhdGVfdXNlZBgIIAEoAVIKZnhSYXRlVXNlZBIjCg1vcGVyYXRvcl9uYW1lGAkgASgJUgxvcGVy'
    'YXRvck5hbWUSIQoMY291bnRyeV9uYW1lGAogASgJUgtjb3VudHJ5TmFtZRIhCgxwaG9uZV9udW'
    '1iZXIYCyABKAlSC3Bob25lTnVtYmVyEi0KEmJ1bmRsZV9kZXNjcmlwdGlvbhgMIAEoCVIRYnVu'
    'ZGxlRGVzY3JpcHRpb24SGAoHbWVzc2FnZRgNIAEoCVIHbWVzc2FnZRIdCgpjcmVhdGVkX2F0GA'
    '4gASgJUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use educationBeneficiaryDescriptor instead')
const EducationBeneficiary$json = {
  '1': 'EducationBeneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'candidate_number', '3': 3, '4': 1, '5': 9, '10': 'candidateNumber'},
    {'1': 'exam_type', '3': 4, '4': 1, '5': 9, '10': 'examType'},
    {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 6, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'nickname', '3': 7, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'candidate_name', '3': 8, '4': 1, '5': 9, '10': 'candidateName'},
    {'1': 'last_amount', '3': 9, '4': 1, '5': 1, '10': 'lastAmount'},
    {
      '1': 'last_purchase_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastPurchaseAt'
    },
    {'1': 'purchase_count', '3': 11, '4': 1, '5': 5, '10': 'purchaseCount'},
    {
      '1': 'created_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `EducationBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List educationBeneficiaryDescriptor = $convert.base64Decode(
    'ChRFZHVjYXRpb25CZW5lZmljaWFyeRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCV'
    'IGdXNlcklkEikKEGNhbmRpZGF0ZV9udW1iZXIYAyABKAlSD2NhbmRpZGF0ZU51bWJlchIbCgll'
    'eGFtX3R5cGUYBCABKAlSCGV4YW1UeXBlEiMKDXByb3ZpZGVyX2NvZGUYBSABKAlSDHByb3ZpZG'
    'VyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAYgASgJUgxwcm92aWRlck5hbWUSGgoIbmlja25hbWUY'
    'ByABKAlSCG5pY2tuYW1lEiUKDmNhbmRpZGF0ZV9uYW1lGAggASgJUg1jYW5kaWRhdGVOYW1lEh'
    '8KC2xhc3RfYW1vdW50GAkgASgBUgpsYXN0QW1vdW50EkQKEGxhc3RfcHVyY2hhc2VfYXQYCiAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg5sYXN0UHVyY2hhc2VBdBIlCg5wdXJjaG'
    'FzZV9jb3VudBgLIAEoBVINcHVyY2hhc2VDb3VudBI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29v'
    'Z2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDSABKAsyGi'
    '5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use saveEducationBeneficiaryRequestDescriptor instead')
const SaveEducationBeneficiaryRequest$json = {
  '1': 'SaveEducationBeneficiaryRequest',
  '2': [
    {'1': 'candidate_number', '3': 1, '4': 1, '5': 9, '10': 'candidateNumber'},
    {'1': 'exam_type', '3': 2, '4': 1, '5': 9, '10': 'examType'},
    {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'nickname', '3': 5, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'candidate_name', '3': 6, '4': 1, '5': 9, '10': 'candidateName'},
  ],
};

/// Descriptor for `SaveEducationBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveEducationBeneficiaryRequestDescriptor = $convert.base64Decode(
    'Ch9TYXZlRWR1Y2F0aW9uQmVuZWZpY2lhcnlSZXF1ZXN0EikKEGNhbmRpZGF0ZV9udW1iZXIYAS'
    'ABKAlSD2NhbmRpZGF0ZU51bWJlchIbCglleGFtX3R5cGUYAiABKAlSCGV4YW1UeXBlEiMKDXBy'
    'b3ZpZGVyX2NvZGUYAyABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAQgASgJUg'
    'xwcm92aWRlck5hbWUSGgoIbmlja25hbWUYBSABKAlSCG5pY2tuYW1lEiUKDmNhbmRpZGF0ZV9u'
    'YW1lGAYgASgJUg1jYW5kaWRhdGVOYW1l');

@$core.Deprecated('Use saveEducationBeneficiaryResponseDescriptor instead')
const SaveEducationBeneficiaryResponse$json = {
  '1': 'SaveEducationBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.EducationBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveEducationBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveEducationBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiBTYXZlRWR1Y2F0aW9uQmVuZWZpY2lhcnlSZXNwb25zZRJHCgtiZW5lZmljaWFyeRgBIAEoCz'
        'IlLnV0aWxpdHlwYXltZW50cy5FZHVjYXRpb25CZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSGAoH'
        'bWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getEducationBeneficiariesRequestDescriptor instead')
const GetEducationBeneficiariesRequest$json = {
  '1': 'GetEducationBeneficiariesRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetEducationBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationBeneficiariesRequestDescriptor =
    $convert.base64Decode(
        'CiBHZXRFZHVjYXRpb25CZW5lZmljaWFyaWVzUmVxdWVzdBIjCg1wcm92aWRlcl9jb2RlGAEgAS'
        'gJUgxwcm92aWRlckNvZGU=');

@$core.Deprecated('Use getEducationBeneficiariesResponseDescriptor instead')
const GetEducationBeneficiariesResponse$json = {
  '1': 'GetEducationBeneficiariesResponse',
  '2': [
    {
      '1': 'beneficiaries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.EducationBeneficiary',
      '10': 'beneficiaries'
    },
  ],
};

/// Descriptor for `GetEducationBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationBeneficiariesResponseDescriptor =
    $convert.base64Decode(
        'CiFHZXRFZHVjYXRpb25CZW5lZmljaWFyaWVzUmVzcG9uc2USSwoNYmVuZWZpY2lhcmllcxgBIA'
        'MoCzIlLnV0aWxpdHlwYXltZW50cy5FZHVjYXRpb25CZW5lZmljaWFyeVINYmVuZWZpY2lhcmll'
        'cw==');

@$core.Deprecated('Use updateEducationBeneficiaryRequestDescriptor instead')
const UpdateEducationBeneficiaryRequest$json = {
  '1': 'UpdateEducationBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateEducationBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEducationBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'CiFVcGRhdGVFZHVjYXRpb25CZW5lZmljaWFyeVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEhoKCG'
        '5pY2tuYW1lGAIgASgJUghuaWNrbmFtZQ==');

@$core.Deprecated('Use updateEducationBeneficiaryResponseDescriptor instead')
const UpdateEducationBeneficiaryResponse$json = {
  '1': 'UpdateEducationBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.EducationBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateEducationBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEducationBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiJVcGRhdGVFZHVjYXRpb25CZW5lZmljaWFyeVJlc3BvbnNlEkcKC2JlbmVmaWNpYXJ5GAEgAS'
        'gLMiUudXRpbGl0eXBheW1lbnRzLkVkdWNhdGlvbkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIY'
        'CgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use deleteEducationBeneficiaryRequestDescriptor instead')
const DeleteEducationBeneficiaryRequest$json = {
  '1': 'DeleteEducationBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteEducationBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEducationBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'CiFEZWxldGVFZHVjYXRpb25CZW5lZmljaWFyeVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use deleteEducationBeneficiaryResponseDescriptor instead')
const DeleteEducationBeneficiaryResponse$json = {
  '1': 'DeleteEducationBeneficiaryResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteEducationBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEducationBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiJEZWxldGVFZHVjYXRpb25CZW5lZmljaWFyeVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB2'
        '1lc3NhZ2U=');

@$core.Deprecated('Use educationReminderDescriptor instead')
const EducationReminder$json = {
  '1': 'EducationReminder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 9, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 10, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'notified_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'notifiedAt'
    },
    {
      '1': 'created_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `EducationReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List educationReminderDescriptor = $convert.base64Decode(
    'ChFFZHVjYXRpb25SZW1pbmRlchIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdX'
    'NlcklkEiUKDmJlbmVmaWNpYXJ5X2lkGAMgASgJUg1iZW5lZmljaWFyeUlkEhQKBXRpdGxlGAQg'
    'ASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZX'
    'JfZGF0ZRgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIW'
    'CgZhbW91bnQYByABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3kSIQoMaX'
    'NfcmVjdXJyaW5nGAkgASgIUgtpc1JlY3VycmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCiABKAlS'
    'DnJlY3VycmVuY2VUeXBlEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEjsKC25vdGlmaWVkX2F0GA'
    'wgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbm90aWZpZWRBdBI5CgpjcmVhdGVk'
    'X2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZG'
    'F0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use createEducationReminderRequestDescriptor instead')
const CreateEducationReminderRequest$json = {
  '1': 'CreateEducationReminderRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `CreateEducationReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createEducationReminderRequestDescriptor = $convert.base64Decode(
    'Ch5DcmVhdGVFZHVjYXRpb25SZW1pbmRlclJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKA'
    'lSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMg'
    'ASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1'
    'cnJlbmN5GAYgASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW'
    '5nEicKD3JlY3VycmVuY2VfdHlwZRgIIAEoCVIOcmVjdXJyZW5jZVR5cGU=');

@$core.Deprecated('Use createEducationReminderResponseDescriptor instead')
const CreateEducationReminderResponse$json = {
  '1': 'CreateEducationReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.EducationReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateEducationReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createEducationReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch9DcmVhdGVFZHVjYXRpb25SZW1pbmRlclJlc3BvbnNlEj4KCHJlbWluZGVyGAEgASgLMiIudX'
        'RpbGl0eXBheW1lbnRzLkVkdWNhdGlvblJlbWluZGVyUghyZW1pbmRlchIYCgdtZXNzYWdlGAIg'
        'ASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getEducationRemindersRequestDescriptor instead')
const GetEducationRemindersRequest$json = {
  '1': 'GetEducationRemindersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetEducationRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationRemindersRequestDescriptor =
    $convert.base64Decode(
        'ChxHZXRFZHVjYXRpb25SZW1pbmRlcnNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEi'
        'EKDGluY2x1ZGVfcGFzdBgCIAEoCFILaW5jbHVkZVBhc3Q=');

@$core.Deprecated('Use getEducationRemindersResponseDescriptor instead')
const GetEducationRemindersResponse$json = {
  '1': 'GetEducationRemindersResponse',
  '2': [
    {
      '1': 'reminders',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.EducationReminder',
      '10': 'reminders'
    },
  ],
};

/// Descriptor for `GetEducationRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationRemindersResponseDescriptor =
    $convert.base64Decode(
        'Ch1HZXRFZHVjYXRpb25SZW1pbmRlcnNSZXNwb25zZRJACglyZW1pbmRlcnMYASADKAsyIi51dG'
        'lsaXR5cGF5bWVudHMuRWR1Y2F0aW9uUmVtaW5kZXJSCXJlbWluZGVycw==');

@$core.Deprecated('Use updateEducationReminderRequestDescriptor instead')
const UpdateEducationReminderRequest$json = {
  '1': 'UpdateEducationReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateEducationReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEducationReminderRequestDescriptor = $convert.base64Decode(
    'Ch5VcGRhdGVFZHVjYXRpb25SZW1pbmRlclJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCn'
    'JlbWluZGVySWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtk'
    'ZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbW'
    'VzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5'
    'GAYgASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW5nEicKD3'
    'JlY3VycmVuY2VfdHlwZRgIIAEoCVIOcmVjdXJyZW5jZVR5cGU=');

@$core.Deprecated('Use updateEducationReminderResponseDescriptor instead')
const UpdateEducationReminderResponse$json = {
  '1': 'UpdateEducationReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.EducationReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateEducationReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEducationReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch9VcGRhdGVFZHVjYXRpb25SZW1pbmRlclJlc3BvbnNlEj4KCHJlbWluZGVyGAEgASgLMiIudX'
        'RpbGl0eXBheW1lbnRzLkVkdWNhdGlvblJlbWluZGVyUghyZW1pbmRlchIYCgdtZXNzYWdlGAIg'
        'ASgJUgdtZXNzYWdl');

@$core.Deprecated('Use deleteEducationReminderRequestDescriptor instead')
const DeleteEducationReminderRequest$json = {
  '1': 'DeleteEducationReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteEducationReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEducationReminderRequestDescriptor =
    $convert.base64Decode(
        'Ch5EZWxldGVFZHVjYXRpb25SZW1pbmRlclJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCn'
        'JlbWluZGVySWQ=');

@$core.Deprecated('Use deleteEducationReminderResponseDescriptor instead')
const DeleteEducationReminderResponse$json = {
  '1': 'DeleteEducationReminderResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteEducationReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEducationReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch9EZWxldGVFZHVjYXRpb25SZW1pbmRlclJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3'
        'NhZ2U=');

@$core.Deprecated('Use markEducationReminderCompleteRequestDescriptor instead')
const MarkEducationReminderCompleteRequest$json = {
  '1': 'MarkEducationReminderCompleteRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkEducationReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markEducationReminderCompleteRequestDescriptor =
    $convert.base64Decode(
        'CiRNYXJrRWR1Y2F0aW9uUmVtaW5kZXJDb21wbGV0ZVJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYAS'
        'ABKAlSCnJlbWluZGVySWQ=');

@$core.Deprecated('Use markEducationReminderCompleteResponseDescriptor instead')
const MarkEducationReminderCompleteResponse$json = {
  '1': 'MarkEducationReminderCompleteResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkEducationReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markEducationReminderCompleteResponseDescriptor =
    $convert.base64Decode(
        'CiVNYXJrRWR1Y2F0aW9uUmVtaW5kZXJDb21wbGV0ZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKA'
        'lSB21lc3NhZ2U=');

@$core.Deprecated('Use internetBeneficiaryDescriptor instead')
const InternetBeneficiary$json = {
  '1': 'InternetBeneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'provider_code', '3': 4, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 5, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'last_amount', '3': 7, '4': 1, '5': 1, '10': 'lastAmount'},
    {'1': 'last_package_id', '3': 8, '4': 1, '5': 9, '10': 'lastPackageId'},
    {'1': 'last_plan_name', '3': 9, '4': 1, '5': 9, '10': 'lastPlanName'},
    {
      '1': 'last_topup_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastTopupAt'
    },
    {'1': 'topup_count', '3': 11, '4': 1, '5': 5, '10': 'topupCount'},
    {
      '1': 'created_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `InternetBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetBeneficiaryDescriptor = $convert.base64Decode(
    'ChNJbnRlcm5ldEJlbmVmaWNpYXJ5Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSJQoOYWNjb3VudF9udW1iZXIYAyABKAlSDWFjY291bnROdW1iZXISIwoNcHJvdmlk'
    'ZXJfY29kZRgEIAEoCVIMcHJvdmlkZXJDb2RlEiMKDXByb3ZpZGVyX25hbWUYBSABKAlSDHByb3'
    'ZpZGVyTmFtZRIaCghuaWNrbmFtZRgGIAEoCVIIbmlja25hbWUSHwoLbGFzdF9hbW91bnQYByAB'
    'KAFSCmxhc3RBbW91bnQSJgoPbGFzdF9wYWNrYWdlX2lkGAggASgJUg1sYXN0UGFja2FnZUlkEi'
    'QKDmxhc3RfcGxhbl9uYW1lGAkgASgJUgxsYXN0UGxhbk5hbWUSPgoNbGFzdF90b3B1cF9hdBgK'
    'IAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RUb3B1cEF0Eh8KC3RvcHVwX2'
    'NvdW50GAsgASgFUgp0b3B1cENvdW50EjkKCmNyZWF0ZWRfYXQYDCABKAsyGi5nb29nbGUucHJv'
    'dG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgNIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use saveInternetBeneficiaryRequestDescriptor instead')
const SaveInternetBeneficiaryRequest$json = {
  '1': 'SaveInternetBeneficiaryRequest',
  '2': [
    {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 3, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `SaveInternetBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveInternetBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'Ch5TYXZlSW50ZXJuZXRCZW5lZmljaWFyeVJlcXVlc3QSJQoOYWNjb3VudF9udW1iZXIYASABKA'
        'lSDWFjY291bnROdW1iZXISIwoNcHJvdmlkZXJfY29kZRgCIAEoCVIMcHJvdmlkZXJDb2RlEiMK'
        'DXByb3ZpZGVyX25hbWUYAyABKAlSDHByb3ZpZGVyTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbm'
        'lja25hbWU=');

@$core.Deprecated('Use saveInternetBeneficiaryResponseDescriptor instead')
const SaveInternetBeneficiaryResponse$json = {
  '1': 'SaveInternetBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.InternetBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveInternetBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveInternetBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'Ch9TYXZlSW50ZXJuZXRCZW5lZmljaWFyeVJlc3BvbnNlEkYKC2JlbmVmaWNpYXJ5GAEgASgLMi'
        'QudXRpbGl0eXBheW1lbnRzLkludGVybmV0QmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21l'
        'c3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getInternetBeneficiariesRequestDescriptor instead')
const GetInternetBeneficiariesRequest$json = {
  '1': 'GetInternetBeneficiariesRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetInternetBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetBeneficiariesRequestDescriptor =
    $convert.base64Decode(
        'Ch9HZXRJbnRlcm5ldEJlbmVmaWNpYXJpZXNSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKA'
        'lSDHByb3ZpZGVyQ29kZQ==');

@$core.Deprecated('Use getInternetBeneficiariesResponseDescriptor instead')
const GetInternetBeneficiariesResponse$json = {
  '1': 'GetInternetBeneficiariesResponse',
  '2': [
    {
      '1': 'beneficiaries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.InternetBeneficiary',
      '10': 'beneficiaries'
    },
  ],
};

/// Descriptor for `GetInternetBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetBeneficiariesResponseDescriptor =
    $convert.base64Decode(
        'CiBHZXRJbnRlcm5ldEJlbmVmaWNpYXJpZXNSZXNwb25zZRJKCg1iZW5lZmljaWFyaWVzGAEgAy'
        'gLMiQudXRpbGl0eXBheW1lbnRzLkludGVybmV0QmVuZWZpY2lhcnlSDWJlbmVmaWNpYXJpZXM=');

@$core.Deprecated('Use updateInternetBeneficiaryRequestDescriptor instead')
const UpdateInternetBeneficiaryRequest$json = {
  '1': 'UpdateInternetBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateInternetBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'CiBVcGRhdGVJbnRlcm5ldEJlbmVmaWNpYXJ5UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSGgoIbm'
        'lja25hbWUYAiABKAlSCG5pY2tuYW1l');

@$core.Deprecated('Use updateInternetBeneficiaryResponseDescriptor instead')
const UpdateInternetBeneficiaryResponse$json = {
  '1': 'UpdateInternetBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.InternetBeneficiary',
      '10': 'beneficiary'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInternetBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiFVcGRhdGVJbnRlcm5ldEJlbmVmaWNpYXJ5UmVzcG9uc2USRgoLYmVuZWZpY2lhcnkYASABKA'
        'syJC51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRCZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSGAoH'
        'bWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteInternetBeneficiaryRequestDescriptor instead')
const DeleteInternetBeneficiaryRequest$json = {
  '1': 'DeleteInternetBeneficiaryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteInternetBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'CiBEZWxldGVJbnRlcm5ldEJlbmVmaWNpYXJ5UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use deleteInternetBeneficiaryResponseDescriptor instead')
const DeleteInternetBeneficiaryResponse$json = {
  '1': 'DeleteInternetBeneficiaryResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInternetBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiFEZWxldGVJbnRlcm5ldEJlbmVmaWNpYXJ5UmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbW'
        'Vzc2FnZQ==');

@$core.Deprecated('Use internetAutoRechargeDescriptor instead')
const InternetAutoRecharge$json = {
  '1': 'InternetAutoRecharge',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 6, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'package_id', '3': 7, '4': 1, '5': 9, '10': 'packageId'},
    {'1': 'plan_name', '3': 8, '4': 1, '5': 9, '10': 'planName'},
    {'1': 'amount', '3': 9, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 11, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 12, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 13, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'execution_hour', '3': 14, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 15, '4': 1, '5': 5, '10': 'executionMinute'},
    {
      '1': 'next_run_date',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'nextRunDate'
    },
    {
      '1': 'last_run_date',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastRunDate'
    },
    {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    {'1': 'failure_count', '3': 19, '4': 1, '5': 5, '10': 'failureCount'},
    {'1': 'max_retries', '3': 20, '4': 1, '5': 5, '10': 'maxRetries'},
    {
      '1': 'created_at',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'beneficiary',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.InternetBeneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `InternetAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetAutoRechargeDescriptor = $convert.base64Decode(
    'ChRJbnRlcm5ldEF1dG9SZWNoYXJnZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCV'
    'IGdXNlcklkEiUKDmJlbmVmaWNpYXJ5X2lkGAMgASgJUg1iZW5lZmljaWFyeUlkEiUKDmFjY291'
    'bnRfbnVtYmVyGAQgASgJUg1hY2NvdW50TnVtYmVyEiMKDXByb3ZpZGVyX2NvZGUYBSABKAlSDH'
    'Byb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAYgASgJUgxwcm92aWRlck5hbWUSHQoKcGFj'
    'a2FnZV9pZBgHIAEoCVIJcGFja2FnZUlkEhsKCXBsYW5fbmFtZRgIIAEoCVIIcGxhbk5hbWUSFg'
    'oGYW1vdW50GAkgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYCiABKAlSCGN1cnJlbmN5EhwKCWZy'
    'ZXF1ZW5jeRgLIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAwgASgFUglkYXlPZldlZW'
    'sSIAoMZGF5X29mX21vbnRoGA0gASgFUgpkYXlPZk1vbnRoEiUKDmV4ZWN1dGlvbl9ob3VyGA4g'
    'ASgFUg1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYDyABKAVSD2V4ZWN1dGlvbk'
    '1pbnV0ZRI+Cg1uZXh0X3J1bl9kYXRlGBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFILbmV4dFJ1bkRhdGUSPgoNbGFzdF9ydW5fZGF0ZRgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSC2xhc3RSdW5EYXRlEhYKBnN0YXR1cxgSIAEoCVIGc3RhdHVzEiMKDWZhaWx1'
    'cmVfY291bnQYEyABKAVSDGZhaWx1cmVDb3VudBIfCgttYXhfcmV0cmllcxgUIAEoBVIKbWF4Um'
    'V0cmllcxI5CgpjcmVhdGVkX2F0GBUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJ'
    'Y3JlYXRlZEF0EkYKC2JlbmVmaWNpYXJ5GBYgASgLMiQudXRpbGl0eXBheW1lbnRzLkludGVybm'
    'V0QmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5');

@$core.Deprecated('Use createInternetAutoRechargeRequestDescriptor instead')
const CreateInternetAutoRechargeRequest$json = {
  '1': 'CreateInternetAutoRechargeRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'package_id', '3': 2, '4': 1, '5': 9, '10': 'packageId'},
    {'1': 'plan_name', '3': 3, '4': 1, '5': 9, '10': 'planName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 6, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 7, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 8, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 9, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 10, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 11, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInternetAutoRechargeRequestDescriptor = $convert.base64Decode(
    'CiFDcmVhdGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYAS'
    'ABKAlSDWJlbmVmaWNpYXJ5SWQSHQoKcGFja2FnZV9pZBgCIAEoCVIJcGFja2FnZUlkEhsKCXBs'
    'YW5fbmFtZRgDIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSGgoIY3Vycm'
    'VuY3kYBSABKAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgGIAEoCVIJZnJlcXVlbmN5Eh4KC2Rh'
    'eV9vZl93ZWVrGAcgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAggASgFUgpkYXlPZk'
    '1vbnRoEh8KC21heF9yZXRyaWVzGAkgASgFUgptYXhSZXRyaWVzEiUKDmV4ZWN1dGlvbl9ob3Vy'
    'GAogASgFUg1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYCyABKAVSD2V4ZWN1dG'
    'lvbk1pbnV0ZQ==');

@$core.Deprecated('Use createInternetAutoRechargeResponseDescriptor instead')
const CreateInternetAutoRechargeResponse$json = {
  '1': 'CreateInternetAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.InternetAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInternetAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiJDcmVhdGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlc3BvbnNlEkoKDWF1dG9fcmVjaGFyZ2UYAS'
        'ABKAsyJS51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRBdXRvUmVjaGFyZ2VSDGF1dG9SZWNoYXJn'
        'ZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getInternetAutoRechargesRequestDescriptor instead')
const GetInternetAutoRechargesRequest$json = {
  '1': 'GetInternetAutoRechargesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetInternetAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetAutoRechargesRequestDescriptor =
    $convert.base64Decode(
        'Ch9HZXRJbnRlcm5ldEF1dG9SZWNoYXJnZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdH'
        'Vz');

@$core.Deprecated('Use getInternetAutoRechargesResponseDescriptor instead')
const GetInternetAutoRechargesResponse$json = {
  '1': 'GetInternetAutoRechargesResponse',
  '2': [
    {
      '1': 'auto_recharges',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.InternetAutoRecharge',
      '10': 'autoRecharges'
    },
  ],
};

/// Descriptor for `GetInternetAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetAutoRechargesResponseDescriptor =
    $convert.base64Decode(
        'CiBHZXRJbnRlcm5ldEF1dG9SZWNoYXJnZXNSZXNwb25zZRJMCg5hdXRvX3JlY2hhcmdlcxgBIA'
        'MoCzIlLnV0aWxpdHlwYXltZW50cy5JbnRlcm5ldEF1dG9SZWNoYXJnZVINYXV0b1JlY2hhcmdl'
        'cw==');

@$core.Deprecated('Use updateInternetAutoRechargeRequestDescriptor instead')
const UpdateInternetAutoRechargeRequest$json = {
  '1': 'UpdateInternetAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    {'1': 'package_id', '3': 2, '4': 1, '5': 9, '10': 'packageId'},
    {'1': 'plan_name', '3': 3, '4': 1, '5': 9, '10': 'planName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 5, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 6, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 7, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 8, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'execution_hour', '3': 9, '4': 1, '5': 5, '10': 'executionHour'},
    {'1': 'execution_minute', '3': 10, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetAutoRechargeRequestDescriptor = $convert.base64Decode(
    'CiFVcGRhdGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZB'
    'gBIAEoCVIOYXV0b1JlY2hhcmdlSWQSHQoKcGFja2FnZV9pZBgCIAEoCVIJcGFja2FnZUlkEhsK'
    'CXBsYW5fbmFtZRgDIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSHAoJZn'
    'JlcXVlbmN5GAUgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYBiABKAVSCWRheU9mV2Vl'
    'axIgCgxkYXlfb2ZfbW9udGgYByABKAVSCmRheU9mTW9udGgSHwoLbWF4X3JldHJpZXMYCCABKA'
    'VSCm1heFJldHJpZXMSJQoOZXhlY3V0aW9uX2hvdXIYCSABKAVSDWV4ZWN1dGlvbkhvdXISKQoQ'
    'ZXhlY3V0aW9uX21pbnV0ZRgKIAEoBVIPZXhlY3V0aW9uTWludXRl');

@$core.Deprecated('Use updateInternetAutoRechargeResponseDescriptor instead')
const UpdateInternetAutoRechargeResponse$json = {
  '1': 'UpdateInternetAutoRechargeResponse',
  '2': [
    {
      '1': 'auto_recharge',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.InternetAutoRecharge',
      '10': 'autoRecharge'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiJVcGRhdGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlc3BvbnNlEkoKDWF1dG9fcmVjaGFyZ2UYAS'
        'ABKAsyJS51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRBdXRvUmVjaGFyZ2VSDGF1dG9SZWNoYXJn'
        'ZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use deleteInternetAutoRechargeRequestDescriptor instead')
const DeleteInternetAutoRechargeRequest$json = {
  '1': 'DeleteInternetAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'CiFEZWxldGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZB'
        'gBIAEoCVIOYXV0b1JlY2hhcmdlSWQ=');

@$core.Deprecated('Use deleteInternetAutoRechargeResponseDescriptor instead')
const DeleteInternetAutoRechargeResponse$json = {
  '1': 'DeleteInternetAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiJEZWxldGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB2'
        '1lc3NhZ2U=');

@$core.Deprecated('Use pauseInternetAutoRechargeRequestDescriptor instead')
const PauseInternetAutoRechargeRequest$json = {
  '1': 'PauseInternetAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseInternetAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'CiBQYXVzZUludGVybmV0QXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGA'
        'EgASgJUg5hdXRvUmVjaGFyZ2VJZA==');

@$core.Deprecated('Use pauseInternetAutoRechargeResponseDescriptor instead')
const PauseInternetAutoRechargeResponse$json = {
  '1': 'PauseInternetAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseInternetAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiFQYXVzZUludGVybmV0QXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbW'
        'Vzc2FnZQ==');

@$core.Deprecated('Use resumeInternetAutoRechargeRequestDescriptor instead')
const ResumeInternetAutoRechargeRequest$json = {
  '1': 'ResumeInternetAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeInternetAutoRechargeRequestDescriptor =
    $convert.base64Decode(
        'CiFSZXN1bWVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZB'
        'gBIAEoCVIOYXV0b1JlY2hhcmdlSWQ=');

@$core.Deprecated('Use resumeInternetAutoRechargeResponseDescriptor instead')
const ResumeInternetAutoRechargeResponse$json = {
  '1': 'ResumeInternetAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeInternetAutoRechargeResponseDescriptor =
    $convert.base64Decode(
        'CiJSZXN1bWVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB2'
        '1lc3NhZ2U=');

@$core.Deprecated('Use internetReminderDescriptor instead')
const InternetReminder$json = {
  '1': 'InternetReminder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'package_id', '3': 8, '4': 1, '5': 9, '10': 'packageId'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 10, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 11, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'notified_at',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'notifiedAt'
    },
    {
      '1': 'created_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `InternetReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetReminderDescriptor = $convert.base64Decode(
    'ChBJbnRlcm5ldFJlbWluZGVyEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUYBCAB'
    'KAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl'
    '9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYK'
    'BmFtb3VudBgHIAEoAVIGYW1vdW50Eh0KCnBhY2thZ2VfaWQYCCABKAlSCXBhY2thZ2VJZBIaCg'
    'hjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3kSIQoMaXNfcmVjdXJyaW5nGAogASgIUgtpc1JlY3Vy'
    'cmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCyABKAlSDnJlY3VycmVuY2VUeXBlEhYKBnN0YXR1cx'
    'gMIAEoCVIGc3RhdHVzEjsKC25vdGlmaWVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRp'
    'bWVzdGFtcFIKbm90aWZpZWRBdBI5CgpjcmVhdGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJv'
    'dG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use createInternetReminderRequestDescriptor instead')
const CreateInternetReminderRequest$json = {
  '1': 'CreateInternetReminderRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'package_id', '3': 6, '4': 1, '5': 9, '10': 'packageId'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `CreateInternetReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInternetReminderRequestDescriptor = $convert.base64Decode(
    'Ch1DcmVhdGVJbnRlcm5ldFJlbWluZGVyUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIAEoCV'
    'INYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyAB'
    'KAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSHQoKcGFj'
    'a2FnZV9pZBgGIAEoCVIJcGFja2FnZUlkEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIhCg'
    'xpc19yZWN1cnJpbmcYCCABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgJIAEo'
    'CVIOcmVjdXJyZW5jZVR5cGU=');

@$core.Deprecated('Use createInternetReminderResponseDescriptor instead')
const CreateInternetReminderResponse$json = {
  '1': 'CreateInternetReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.InternetReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInternetReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInternetReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch5DcmVhdGVJbnRlcm5ldFJlbWluZGVyUmVzcG9uc2USPQoIcmVtaW5kZXIYASABKAsyIS51dG'
        'lsaXR5cGF5bWVudHMuSW50ZXJuZXRSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEo'
        'CVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getInternetRemindersRequestDescriptor instead')
const GetInternetRemindersRequest$json = {
  '1': 'GetInternetRemindersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetInternetRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetRemindersRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRJbnRlcm5ldFJlbWluZGVyc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSIQ'
        'oMaW5jbHVkZV9wYXN0GAIgASgIUgtpbmNsdWRlUGFzdA==');

@$core.Deprecated('Use getInternetRemindersResponseDescriptor instead')
const GetInternetRemindersResponse$json = {
  '1': 'GetInternetRemindersResponse',
  '2': [
    {
      '1': 'reminders',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.InternetReminder',
      '10': 'reminders'
    },
  ],
};

/// Descriptor for `GetInternetRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetRemindersResponseDescriptor =
    $convert.base64Decode(
        'ChxHZXRJbnRlcm5ldFJlbWluZGVyc1Jlc3BvbnNlEj8KCXJlbWluZGVycxgBIAMoCzIhLnV0aW'
        'xpdHlwYXltZW50cy5JbnRlcm5ldFJlbWluZGVyUglyZW1pbmRlcnM=');

@$core.Deprecated('Use updateInternetReminderRequestDescriptor instead')
const UpdateInternetReminderRequest$json = {
  '1': 'UpdateInternetReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'reminder_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'reminderDate'
    },
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'package_id', '3': 6, '4': 1, '5': 9, '10': 'packageId'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateInternetReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetReminderRequestDescriptor = $convert.base64Decode(
    'Ch1VcGRhdGVJbnRlcm5ldFJlbWluZGVyUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcm'
    'VtaW5kZXJJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rl'
    'c2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZX'
    'N0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSHQoKcGFja2FnZV9p'
    'ZBgGIAEoCVIJcGFja2FnZUlkEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIhCgxpc19yZW'
    'N1cnJpbmcYCCABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgJIAEoCVIOcmVj'
    'dXJyZW5jZVR5cGU=');

@$core.Deprecated('Use updateInternetReminderResponseDescriptor instead')
const UpdateInternetReminderResponse$json = {
  '1': 'UpdateInternetReminderResponse',
  '2': [
    {
      '1': 'reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.InternetReminder',
      '10': 'reminder'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInternetReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch5VcGRhdGVJbnRlcm5ldFJlbWluZGVyUmVzcG9uc2USPQoIcmVtaW5kZXIYASABKAsyIS51dG'
        'lsaXR5cGF5bWVudHMuSW50ZXJuZXRSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEo'
        'CVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteInternetReminderRequestDescriptor instead')
const DeleteInternetReminderRequest$json = {
  '1': 'DeleteInternetReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteInternetReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetReminderRequestDescriptor =
    $convert.base64Decode(
        'Ch1EZWxldGVJbnRlcm5ldFJlbWluZGVyUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcm'
        'VtaW5kZXJJZA==');

@$core.Deprecated('Use deleteInternetReminderResponseDescriptor instead')
const DeleteInternetReminderResponse$json = {
  '1': 'DeleteInternetReminderResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInternetReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetReminderResponseDescriptor =
    $convert.base64Decode(
        'Ch5EZWxldGVJbnRlcm5ldFJlbWluZGVyUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2'
        'FnZQ==');

@$core.Deprecated('Use markInternetReminderCompleteRequestDescriptor instead')
const MarkInternetReminderCompleteRequest$json = {
  '1': 'MarkInternetReminderCompleteRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkInternetReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markInternetReminderCompleteRequestDescriptor =
    $convert.base64Decode(
        'CiNNYXJrSW50ZXJuZXRSZW1pbmRlckNvbXBsZXRlUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIA'
        'EoCVIKcmVtaW5kZXJJZA==');

@$core.Deprecated('Use markInternetReminderCompleteResponseDescriptor instead')
const MarkInternetReminderCompleteResponse$json = {
  '1': 'MarkInternetReminderCompleteResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkInternetReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markInternetReminderCompleteResponseDescriptor =
    $convert.base64Decode(
        'CiRNYXJrSW50ZXJuZXRSZW1pbmRlckNvbXBsZXRlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCV'
        'IHbWVzc2FnZQ==');

@$core.Deprecated('Use ePinDenominationDescriptor instead')
const EPinDenomination$json = {
  '1': 'EPinDenomination',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'variation', '3': 2, '4': 1, '5': 9, '10': 'variation'},
    {'1': 'label', '3': 3, '4': 1, '5': 9, '10': 'label'},
  ],
};

/// Descriptor for `EPinDenomination`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ePinDenominationDescriptor = $convert.base64Decode(
    'ChBFUGluRGVub21pbmF0aW9uEhYKBmFtb3VudBgBIAEoAVIGYW1vdW50EhwKCXZhcmlhdGlvbh'
    'gCIAEoCVIJdmFyaWF0aW9uEhQKBWxhYmVsGAMgASgJUgVsYWJlbA==');

@$core.Deprecated('Use ePinNetworkDescriptor instead')
const EPinNetwork$json = {
  '1': 'EPinNetwork',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 4, '4': 1, '5': 8, '10': 'isActive'},
    {
      '1': 'denominations',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.EPinDenomination',
      '10': 'denominations'
    },
  ],
};

/// Descriptor for `EPinNetwork`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ePinNetworkDescriptor = $convert.base64Decode(
    'CgtFUGluTmV0d29yaxISCgRjb2RlGAEgASgJUgRjb2RlEhIKBG5hbWUYAiABKAlSBG5hbWUSGQ'
    'oIbG9nb191cmwYAyABKAlSB2xvZ29VcmwSGwoJaXNfYWN0aXZlGAQgASgIUghpc0FjdGl2ZRJH'
    'Cg1kZW5vbWluYXRpb25zGAUgAygLMiEudXRpbGl0eXBheW1lbnRzLkVQaW5EZW5vbWluYXRpb2'
    '5SDWRlbm9taW5hdGlvbnM=');

@$core.Deprecated('Use getEPinNetworksRequestDescriptor instead')
const GetEPinNetworksRequest$json = {
  '1': 'GetEPinNetworksRequest',
};

/// Descriptor for `GetEPinNetworksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEPinNetworksRequestDescriptor =
    $convert.base64Decode('ChZHZXRFUGluTmV0d29ya3NSZXF1ZXN0');

@$core.Deprecated('Use getEPinNetworksResponseDescriptor instead')
const GetEPinNetworksResponse$json = {
  '1': 'GetEPinNetworksResponse',
  '2': [
    {
      '1': 'networks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.EPinNetwork',
      '10': 'networks'
    },
  ],
};

/// Descriptor for `GetEPinNetworksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEPinNetworksResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRFUGluTmV0d29ya3NSZXNwb25zZRI4CghuZXR3b3JrcxgBIAMoCzIcLnV0aWxpdHlwYX'
        'ltZW50cy5FUGluTmV0d29ya1IIbmV0d29ya3M=');

@$core.Deprecated('Use initiateEPinPurchaseRequestDescriptor instead')
const InitiateEPinPurchaseRequest$json = {
  '1': 'InitiateEPinPurchaseRequest',
  '2': [
    {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
    {'1': 'denomination', '3': 2, '4': 1, '5': 1, '10': 'denomination'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'business_name', '3': 9, '4': 1, '5': 9, '10': 'businessName'},
  ],
};

/// Descriptor for `InitiateEPinPurchaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateEPinPurchaseRequestDescriptor = $convert.base64Decode(
    'ChtJbml0aWF0ZUVQaW5QdXJjaGFzZVJlcXVlc3QSGAoHbmV0d29yaxgBIAEoCVIHbmV0d29yax'
    'IiCgxkZW5vbWluYXRpb24YAiABKAFSDGRlbm9taW5hdGlvbhIaCghxdWFudGl0eRgDIAEoBVII'
    'cXVhbnRpdHkSKgoRc291cmNlX2FjY291bnRfaWQYBCABKAlSD3NvdXJjZUFjY291bnRJZBIhCg'
    'xwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJ'
    'Ug10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW'
    '9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAggASgJUg5pZGVtcG90ZW5jeUtleRIjCg1idXNp'
    'bmVzc19uYW1lGAkgASgJUgxidXNpbmVzc05hbWU=');

@$core.Deprecated('Use ePinCardDescriptor instead')
const EPinCard$json = {
  '1': 'EPinCard',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    {'1': 'denomination', '3': 3, '4': 1, '5': 1, '10': 'denomination'},
    {'1': 'product_name', '3': 4, '4': 1, '5': 9, '10': 'productName'},
    {'1': 'pin', '3': 5, '4': 1, '5': 9, '10': 'pin'},
    {'1': 'serial', '3': 6, '4': 1, '5': 9, '10': 'serial'},
    {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 8, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `EPinCard`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ePinCardDescriptor = $convert.base64Decode(
    'CghFUGluQ2FyZBIOCgJpZBgBIAEoCVICaWQSGAoHbmV0d29yaxgCIAEoCVIHbmV0d29yaxIiCg'
    'xkZW5vbWluYXRpb24YAyABKAFSDGRlbm9taW5hdGlvbhIhCgxwcm9kdWN0X25hbWUYBCABKAlS'
    'C3Byb2R1Y3ROYW1lEhAKA3BpbhgFIAEoCVIDcGluEhYKBnNlcmlhbBgGIAEoCVIGc2VyaWFsEh'
    'YKBnN0YXR1cxgHIAEoCVIGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYCCABKAlSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use ePinOrderDescriptor instead')
const EPinOrder$json = {
  '1': 'EPinOrder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    {'1': 'denomination', '3': 3, '4': 1, '5': 1, '10': 'denomination'},
    {'1': 'quantity', '3': 4, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'service_fee', '3': 6, '4': 1, '5': 1, '10': 'serviceFee'},
    {'1': 'total_amount', '3': 7, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    {
      '1': 'provider_reference',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'providerReference'
    },
    {'1': 'created_at', '3': 11, '4': 1, '5': 9, '10': 'createdAt'},
    {
      '1': 'cards',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.EPinCard',
      '10': 'cards'
    },
    {'1': 'business_name', '3': 13, '4': 1, '5': 9, '10': 'businessName'},
  ],
};

/// Descriptor for `EPinOrder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ePinOrderDescriptor = $convert.base64Decode(
    'CglFUGluT3JkZXISDgoCaWQYASABKAlSAmlkEhgKB25ldHdvcmsYAiABKAlSB25ldHdvcmsSIg'
    'oMZGVub21pbmF0aW9uGAMgASgBUgxkZW5vbWluYXRpb24SGgoIcXVhbnRpdHkYBCABKAVSCHF1'
    'YW50aXR5EhYKBmFtb3VudBgFIAEoAVIGYW1vdW50Eh8KC3NlcnZpY2VfZmVlGAYgASgBUgpzZX'
    'J2aWNlRmVlEiEKDHRvdGFsX2Ftb3VudBgHIAEoAVILdG90YWxBbW91bnQSFgoGc3RhdHVzGAgg'
    'ASgJUgZzdGF0dXMSHAoJcmVmZXJlbmNlGAkgASgJUglyZWZlcmVuY2USLQoScHJvdmlkZXJfcm'
    'VmZXJlbmNlGAogASgJUhFwcm92aWRlclJlZmVyZW5jZRIdCgpjcmVhdGVkX2F0GAsgASgJUglj'
    'cmVhdGVkQXQSLwoFY2FyZHMYDCADKAsyGS51dGlsaXR5cGF5bWVudHMuRVBpbkNhcmRSBWNhcm'
    'RzEiMKDWJ1c2luZXNzX25hbWUYDSABKAlSDGJ1c2luZXNzTmFtZQ==');

@$core.Deprecated('Use initiateEPinPurchaseResponseDescriptor instead')
const InitiateEPinPurchaseResponse$json = {
  '1': 'InitiateEPinPurchaseResponse',
  '2': [
    {
      '1': 'order',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.EPinOrder',
      '10': 'order'
    },
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiateEPinPurchaseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateEPinPurchaseResponseDescriptor =
    $convert.base64Decode(
        'ChxJbml0aWF0ZUVQaW5QdXJjaGFzZVJlc3BvbnNlEjAKBW9yZGVyGAEgASgLMhoudXRpbGl0eX'
        'BheW1lbnRzLkVQaW5PcmRlclIFb3JkZXISHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFu'
        'Y2USGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getEPinOrderRequestDescriptor instead')
const GetEPinOrderRequest$json = {
  '1': 'GetEPinOrderRequest',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
  ],
};

/// Descriptor for `GetEPinOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEPinOrderRequestDescriptor =
    $convert.base64Decode(
        'ChNHZXRFUGluT3JkZXJSZXF1ZXN0EhkKCG9yZGVyX2lkGAEgASgJUgdvcmRlcklk');

@$core.Deprecated('Use getEPinOrderResponseDescriptor instead')
const GetEPinOrderResponse$json = {
  '1': 'GetEPinOrderResponse',
  '2': [
    {
      '1': 'order',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.EPinOrder',
      '10': 'order'
    },
  ],
};

/// Descriptor for `GetEPinOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEPinOrderResponseDescriptor = $convert.base64Decode(
    'ChRHZXRFUGluT3JkZXJSZXNwb25zZRIwCgVvcmRlchgBIAEoCzIaLnV0aWxpdHlwYXltZW50cy'
    '5FUGluT3JkZXJSBW9yZGVy');

@$core.Deprecated('Use listEPinOrdersRequestDescriptor instead')
const ListEPinOrdersRequest$json = {
  '1': 'ListEPinOrdersRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `ListEPinOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEPinOrdersRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0RVBpbk9yZGVyc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm9mZnNldB'
    'gCIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use listEPinOrdersResponseDescriptor instead')
const ListEPinOrdersResponse$json = {
  '1': 'ListEPinOrdersResponse',
  '2': [
    {
      '1': 'orders',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.EPinOrder',
      '10': 'orders'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListEPinOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEPinOrdersResponseDescriptor =
    $convert.base64Decode(
        'ChZMaXN0RVBpbk9yZGVyc1Jlc3BvbnNlEjIKBm9yZGVycxgBIAMoCzIaLnV0aWxpdHlwYXltZW'
        '50cy5FUGluT3JkZXJSBm9yZGVycxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use getEPinReceiptRequestDescriptor instead')
const GetEPinReceiptRequest$json = {
  '1': 'GetEPinReceiptRequest',
  '2': [
    {'1': 'order_id', '3': 1, '4': 1, '5': 9, '10': 'orderId'},
  ],
};

/// Descriptor for `GetEPinReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEPinReceiptRequestDescriptor =
    $convert.base64Decode(
        'ChVHZXRFUGluUmVjZWlwdFJlcXVlc3QSGQoIb3JkZXJfaWQYASABKAlSB29yZGVySWQ=');

@$core.Deprecated('Use getEPinReceiptResponseDescriptor instead')
const GetEPinReceiptResponse$json = {
  '1': 'GetEPinReceiptResponse',
  '2': [
    {
      '1': 'order',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.EPinOrder',
      '10': 'order'
    },
    {'1': 'pdf_url', '3': 2, '4': 1, '5': 9, '10': 'pdfUrl'},
  ],
};

/// Descriptor for `GetEPinReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEPinReceiptResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRFUGluUmVjZWlwdFJlc3BvbnNlEjAKBW9yZGVyGAEgASgLMhoudXRpbGl0eXBheW1lbn'
        'RzLkVQaW5PcmRlclIFb3JkZXISFwoHcGRmX3VybBgCIAEoCVIGcGRmVXJs');

@$core.Deprecated('Use bettingPlatformDescriptor instead')
const BettingPlatform$json = {
  '1': 'BettingPlatform',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 4, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'min_amount', '3': 5, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 6, '4': 1, '5': 1, '10': 'maxAmount'},
  ],
};

/// Descriptor for `BettingPlatform`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bettingPlatformDescriptor = $convert.base64Decode(
    'Cg9CZXR0aW5nUGxhdGZvcm0SEgoEY29kZRgBIAEoCVIEY29kZRISCgRuYW1lGAIgASgJUgRuYW'
    '1lEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEhsKCWlzX2FjdGl2ZRgEIAEoCFIIaXNBY3Rp'
    'dmUSHQoKbWluX2Ftb3VudBgFIAEoAVIJbWluQW1vdW50Eh0KCm1heF9hbW91bnQYBiABKAFSCW'
    '1heEFtb3VudA==');

@$core.Deprecated('Use getBettingPlatformsRequestDescriptor instead')
const GetBettingPlatformsRequest$json = {
  '1': 'GetBettingPlatformsRequest',
};

/// Descriptor for `GetBettingPlatformsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBettingPlatformsRequestDescriptor =
    $convert.base64Decode('ChpHZXRCZXR0aW5nUGxhdGZvcm1zUmVxdWVzdA==');

@$core.Deprecated('Use getBettingPlatformsResponseDescriptor instead')
const GetBettingPlatformsResponse$json = {
  '1': 'GetBettingPlatformsResponse',
  '2': [
    {
      '1': 'platforms',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.BettingPlatform',
      '10': 'platforms'
    },
  ],
};

/// Descriptor for `GetBettingPlatformsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBettingPlatformsResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXRCZXR0aW5nUGxhdGZvcm1zUmVzcG9uc2USPgoJcGxhdGZvcm1zGAEgAygLMiAudXRpbG'
        'l0eXBheW1lbnRzLkJldHRpbmdQbGF0Zm9ybVIJcGxhdGZvcm1z');

@$core.Deprecated('Use verifyBettingAccountRequestDescriptor instead')
const VerifyBettingAccountRequest$json = {
  '1': 'VerifyBettingAccountRequest',
  '2': [
    {'1': 'platform', '3': 1, '4': 1, '5': 9, '10': 'platform'},
    {'1': 'account_userid', '3': 2, '4': 1, '5': 9, '10': 'accountUserid'},
  ],
};

/// Descriptor for `VerifyBettingAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBettingAccountRequestDescriptor =
    $convert.base64Decode(
        'ChtWZXJpZnlCZXR0aW5nQWNjb3VudFJlcXVlc3QSGgoIcGxhdGZvcm0YASABKAlSCHBsYXRmb3'
        'JtEiUKDmFjY291bnRfdXNlcmlkGAIgASgJUg1hY2NvdW50VXNlcmlk');

@$core.Deprecated('Use verifyBettingAccountResponseDescriptor instead')
const VerifyBettingAccountResponse$json = {
  '1': 'VerifyBettingAccountResponse',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    {'1': 'account_name', '3': 2, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `VerifyBettingAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyBettingAccountResponseDescriptor =
    $convert.base64Decode(
        'ChxWZXJpZnlCZXR0aW5nQWNjb3VudFJlc3BvbnNlEhQKBXZhbGlkGAEgASgIUgV2YWxpZBIhCg'
        'xhY2NvdW50X25hbWUYAiABKAlSC2FjY291bnROYW1lEhgKB21lc3NhZ2UYAyABKAlSB21lc3Nh'
        'Z2U=');

@$core.Deprecated('Use initiateBettingFundingRequestDescriptor instead')
const InitiateBettingFundingRequest$json = {
  '1': 'InitiateBettingFundingRequest',
  '2': [
    {'1': 'platform', '3': 1, '4': 1, '5': 9, '10': 'platform'},
    {'1': 'account_userid', '3': 2, '4': 1, '5': 9, '10': 'accountUserid'},
    {'1': 'account_name', '3': 3, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'source_account_id', '3': 5, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {'1': 'save_beneficiary', '3': 10, '4': 1, '5': 8, '10': 'saveBeneficiary'},
    {'1': 'nickname', '3': 11, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `InitiateBettingFundingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateBettingFundingRequestDescriptor = $convert.base64Decode(
    'Ch1Jbml0aWF0ZUJldHRpbmdGdW5kaW5nUmVxdWVzdBIaCghwbGF0Zm9ybRgBIAEoCVIIcGxhdG'
    'Zvcm0SJQoOYWNjb3VudF91c2VyaWQYAiABKAlSDWFjY291bnRVc2VyaWQSIQoMYWNjb3VudF9u'
    'YW1lGAMgASgJUgthY2NvdW50TmFtZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIqChFzb3VyY2'
    'VfYWNjb3VudF9pZBgFIAEoCVIPc291cmNlQWNjb3VudElkEiEKDHBob25lX251bWJlchgGIAEo'
    'CVILcGhvbmVOdW1iZXISJQoOdHJhbnNhY3Rpb25faWQYByABKAlSDXRyYW5zYWN0aW9uSWQSLQ'
    'oSdmVyaWZpY2F0aW9uX3Rva2VuGAggASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90'
    'ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2V5EikKEHNhdmVfYmVuZWZpY2lhcnkYCiABKA'
    'hSD3NhdmVCZW5lZmljaWFyeRIaCghuaWNrbmFtZRgLIAEoCVIIbmlja25hbWU=');

@$core.Deprecated('Use initiateBettingFundingResponseDescriptor instead')
const InitiateBettingFundingResponse$json = {
  '1': 'InitiateBettingFundingResponse',
  '2': [
    {
      '1': 'payment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payment'
    },
    {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    {
      '1': 'provider_reference',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'providerReference'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiateBettingFundingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateBettingFundingResponseDescriptor =
    $convert.base64Decode(
        'Ch5Jbml0aWF0ZUJldHRpbmdGdW5kaW5nUmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aW'
        'xpdHlwYXltZW50cy5CaWxsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIK'
        'bmV3QmFsYW5jZRItChJwcm92aWRlcl9yZWZlcmVuY2UYAyABKAlSEXByb3ZpZGVyUmVmZXJlbm'
        'NlEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getBettingHistoryRequestDescriptor instead')
const GetBettingHistoryRequest$json = {
  '1': 'GetBettingHistoryRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetBettingHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBettingHistoryRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRCZXR0aW5nSGlzdG9yeVJlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm9mZn'
        'NldBgCIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use getBettingHistoryResponseDescriptor instead')
const GetBettingHistoryResponse$json = {
  '1': 'GetBettingHistoryResponse',
  '2': [
    {
      '1': 'payments',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.BillPayment',
      '10': 'payments'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetBettingHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBettingHistoryResponseDescriptor =
    $convert.base64Decode(
        'ChlHZXRCZXR0aW5nSGlzdG9yeVJlc3BvbnNlEjgKCHBheW1lbnRzGAEgAygLMhwudXRpbGl0eX'
        'BheW1lbnRzLkJpbGxQYXltZW50UghwYXltZW50cxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use bettingBeneficiaryDescriptor instead')
const BettingBeneficiary$json = {
  '1': 'BettingBeneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'platform', '3': 2, '4': 1, '5': 9, '10': 'platform'},
    {'1': 'account_userid', '3': 3, '4': 1, '5': 9, '10': 'accountUserid'},
    {'1': 'account_name', '3': 4, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'nickname', '3': 5, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'is_default', '3': 6, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `BettingBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bettingBeneficiaryDescriptor = $convert.base64Decode(
    'ChJCZXR0aW5nQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhoKCHBsYXRmb3JtGAIgASgJUg'
    'hwbGF0Zm9ybRIlCg5hY2NvdW50X3VzZXJpZBgDIAEoCVINYWNjb3VudFVzZXJpZBIhCgxhY2Nv'
    'dW50X25hbWUYBCABKAlSC2FjY291bnROYW1lEhoKCG5pY2tuYW1lGAUgASgJUghuaWNrbmFtZR'
    'IdCgppc19kZWZhdWx0GAYgASgIUglpc0RlZmF1bHQSHQoKY3JlYXRlZF9hdBgHIAEoCVIJY3Jl'
    'YXRlZEF0');

@$core.Deprecated('Use saveBettingBeneficiaryRequestDescriptor instead')
const SaveBettingBeneficiaryRequest$json = {
  '1': 'SaveBettingBeneficiaryRequest',
  '2': [
    {'1': 'platform', '3': 1, '4': 1, '5': 9, '10': 'platform'},
    {'1': 'account_userid', '3': 2, '4': 1, '5': 9, '10': 'accountUserid'},
    {'1': 'account_name', '3': 3, '4': 1, '5': 9, '10': 'accountName'},
    {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'is_default', '3': 5, '4': 1, '5': 8, '10': 'isDefault'},
  ],
};

/// Descriptor for `SaveBettingBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBettingBeneficiaryRequestDescriptor = $convert.base64Decode(
    'Ch1TYXZlQmV0dGluZ0JlbmVmaWNpYXJ5UmVxdWVzdBIaCghwbGF0Zm9ybRgBIAEoCVIIcGxhdG'
    'Zvcm0SJQoOYWNjb3VudF91c2VyaWQYAiABKAlSDWFjY291bnRVc2VyaWQSIQoMYWNjb3VudF9u'
    'YW1lGAMgASgJUgthY2NvdW50TmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWUSHQoKaX'
    'NfZGVmYXVsdBgFIAEoCFIJaXNEZWZhdWx0');

@$core.Deprecated('Use saveBettingBeneficiaryResponseDescriptor instead')
const SaveBettingBeneficiaryResponse$json = {
  '1': 'SaveBettingBeneficiaryResponse',
  '2': [
    {
      '1': 'beneficiary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.utilitypayments.BettingBeneficiary',
      '10': 'beneficiary'
    },
  ],
};

/// Descriptor for `SaveBettingBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBettingBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'Ch5TYXZlQmV0dGluZ0JlbmVmaWNpYXJ5UmVzcG9uc2USRQoLYmVuZWZpY2lhcnkYASABKAsyIy'
        '51dGlsaXR5cGF5bWVudHMuQmV0dGluZ0JlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');

@$core.Deprecated('Use getBettingBeneficiariesRequestDescriptor instead')
const GetBettingBeneficiariesRequest$json = {
  '1': 'GetBettingBeneficiariesRequest',
};

/// Descriptor for `GetBettingBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBettingBeneficiariesRequestDescriptor =
    $convert.base64Decode('Ch5HZXRCZXR0aW5nQmVuZWZpY2lhcmllc1JlcXVlc3Q=');

@$core.Deprecated('Use getBettingBeneficiariesResponseDescriptor instead')
const GetBettingBeneficiariesResponse$json = {
  '1': 'GetBettingBeneficiariesResponse',
  '2': [
    {
      '1': 'beneficiaries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.utilitypayments.BettingBeneficiary',
      '10': 'beneficiaries'
    },
  ],
};

/// Descriptor for `GetBettingBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBettingBeneficiariesResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRCZXR0aW5nQmVuZWZpY2lhcmllc1Jlc3BvbnNlEkkKDWJlbmVmaWNpYXJpZXMYASADKA'
        'syIy51dGlsaXR5cGF5bWVudHMuQmV0dGluZ0JlbmVmaWNpYXJ5Ug1iZW5lZmljaWFyaWVz');

@$core.Deprecated('Use deleteBettingBeneficiaryRequestDescriptor instead')
const DeleteBettingBeneficiaryRequest$json = {
  '1': 'DeleteBettingBeneficiaryRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
  ],
};

/// Descriptor for `DeleteBettingBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBettingBeneficiaryRequestDescriptor =
    $convert.base64Decode(
        'Ch9EZWxldGVCZXR0aW5nQmVuZWZpY2lhcnlSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgAS'
        'gJUg1iZW5lZmljaWFyeUlk');

@$core.Deprecated('Use deleteBettingBeneficiaryResponseDescriptor instead')
const DeleteBettingBeneficiaryResponse$json = {
  '1': 'DeleteBettingBeneficiaryResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteBettingBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBettingBeneficiaryResponseDescriptor =
    $convert.base64Decode(
        'CiBEZWxldGVCZXR0aW5nQmVuZWZpY2lhcnlSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZX'
        'NzYWdl');
