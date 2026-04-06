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
    const {'1': 'country_code', '3': 8, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'min_amount', '3': 9, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 10, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'commission_rate', '3': 11, '4': 1, '5': 1, '10': 'commissionRate'},
    const {'1': 'operator_id', '3': 12, '4': 1, '5': 9, '10': 'operatorId'},
    const {'1': 'reloadly_operator_id', '3': 13, '4': 1, '5': 9, '10': 'reloadlyOperatorId'},
  ],
};

/// Descriptor for `AirtimeProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeProviderDescriptor = $convert.base64Decode('Cg9BaXJ0aW1lUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGAoHbmV0d29yaxgDIAEoCVIHbmV0d29yaxIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEiQKDWRlbm9taW5hdGlvbnMYBiADKAlSDWRlbm9taW5hdGlvbnMSHQoKZGF0YV9wbGFucxgHIAMoCVIJZGF0YVBsYW5zEiEKDGNvdW50cnlfY29kZRgIIAEoCVILY291bnRyeUNvZGUSHQoKbWluX2Ftb3VudBgJIAEoAVIJbWluQW1vdW50Eh0KCm1heF9hbW91bnQYCiABKAFSCW1heEFtb3VudBInCg9jb21taXNzaW9uX3JhdGUYCyABKAFSDmNvbW1pc3Npb25SYXRlEh8KC29wZXJhdG9yX2lkGAwgASgJUgpvcGVyYXRvcklkEjAKFHJlbG9hZGx5X29wZXJhdG9yX2lkGA0gASgJUhJyZWxvYWRseU9wZXJhdG9ySWQ=');
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
    const {'1': 'country_code', '3': 9, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'operator_id', '3': 10, '4': 1, '5': 9, '10': 'operatorId'},
  ],
};

/// Descriptor for `BuyAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeRequestDescriptor = $convert.base64Decode('ChFCdXlBaXJ0aW1lUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZBIhCgxwaG9uZV9udW1iZXIYAiABKAlSC3Bob25lTnVtYmVyEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EiEKDGFpcnRpbWVfdHlwZRgEIAEoCVILYWlydGltZVR5cGUSIAoMZGF0YV9wbGFuX2lkGAUgASgJUgpkYXRhUGxhbklkEiUKDnRyYW5zYWN0aW9uX2lkGAYgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgHIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAggASgJUg5pZGVtcG90ZW5jeUtleRIhCgxjb3VudHJ5X2NvZGUYCSABKAlSC2NvdW50cnlDb2RlEh8KC29wZXJhdG9yX2lkGAogASgJUgpvcGVyYXRvcklk');
@$core.Deprecated('Use buyAirtimeResponseDescriptor instead')
const BuyAirtimeResponse$json = const {
  '1': 'BuyAirtimeResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'data_info', '3': 4, '4': 1, '5': 9, '10': 'dataInfo'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'commission_earned', '3': 6, '4': 1, '5': 1, '10': 'commissionEarned'},
    const {'1': 'provider_reference', '3': 7, '4': 1, '5': 9, '10': 'providerReference'},
  ],
};

/// Descriptor for `BuyAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyAirtimeResponseDescriptor = $convert.base64Decode('ChJCdXlBaXJ0aW1lUmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aWxpdHlwYXltZW50cy5CaWxsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIhCgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEhsKCWRhdGFfaW5mbxgEIAEoCVIIZGF0YUluZm8SGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZRIrChFjb21taXNzaW9uX2Vhcm5lZBgGIAEoAVIQY29tbWlzc2lvbkVhcm5lZBItChJwcm92aWRlcl9yZWZlcmVuY2UYByABKAlSEXByb3ZpZGVyUmVmZXJlbmNl');
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
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetAirtimeProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeProvidersRequestDescriptor = $convert.base64Decode('ChpHZXRBaXJ0aW1lUHJvdmlkZXJzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aXZlT25seRIhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2Rl');
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
@$core.Deprecated('Use cableTVProviderDescriptor instead')
const CableTVProvider$json = const {
  '1': 'CableTVProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'service_id', '3': 3, '4': 1, '5': 9, '10': 'serviceId'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'commission_rate', '3': 6, '4': 1, '5': 1, '10': 'commissionRate'},
  ],
};

/// Descriptor for `CableTVProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cableTVProviderDescriptor = $convert.base64Decode('Cg9DYWJsZVRWUHJvdmlkZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSHQoKc2VydmljZV9pZBgDIAEoCVIJc2VydmljZUlkEhkKCGxvZ29fdXJsGAQgASgJUgdsb2dvVXJsEhsKCWlzX2FjdGl2ZRgFIAEoCFIIaXNBY3RpdmUSJwoPY29tbWlzc2lvbl9yYXRlGAYgASgBUg5jb21taXNzaW9uUmF0ZQ==');
@$core.Deprecated('Use tVPackageDescriptor instead')
const TVPackage$json = const {
  '1': 'TVPackage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'variation_code', '3': 3, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'provider_id', '3': 5, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'validity', '3': 6, '4': 1, '5': 9, '10': 'validity'},
  ],
};

/// Descriptor for `TVPackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tVPackageDescriptor = $convert.base64Decode('CglUVlBhY2thZ2USDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSJQoOdmFyaWF0aW9uX2NvZGUYAyABKAlSDXZhcmlhdGlvbkNvZGUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSHwoLcHJvdmlkZXJfaWQYBSABKAlSCnByb3ZpZGVySWQSGgoIdmFsaWRpdHkYBiABKAlSCHZhbGlkaXR5');
@$core.Deprecated('Use smartCardValidationDescriptor instead')
const SmartCardValidation$json = const {
  '1': 'SmartCardValidation',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'smart_card_number', '3': 3, '4': 1, '5': 9, '10': 'smartCardNumber'},
    const {'1': 'current_package', '3': 4, '4': 1, '5': 9, '10': 'currentPackage'},
    const {'1': 'renewal_date', '3': 5, '4': 1, '5': 9, '10': 'renewalDate'},
    const {'1': 'due_date', '3': 6, '4': 1, '5': 9, '10': 'dueDate'},
  ],
};

/// Descriptor for `SmartCardValidation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smartCardValidationDescriptor = $convert.base64Decode('ChNTbWFydENhcmRWYWxpZGF0aW9uEhkKCGlzX3ZhbGlkGAEgASgIUgdpc1ZhbGlkEiMKDWN1c3RvbWVyX25hbWUYAiABKAlSDGN1c3RvbWVyTmFtZRIqChFzbWFydF9jYXJkX251bWJlchgDIAEoCVIPc21hcnRDYXJkTnVtYmVyEicKD2N1cnJlbnRfcGFja2FnZRgEIAEoCVIOY3VycmVudFBhY2thZ2USIQoMcmVuZXdhbF9kYXRlGAUgASgJUgtyZW5ld2FsRGF0ZRIZCghkdWVfZGF0ZRgGIAEoCVIHZHVlRGF0ZQ==');
@$core.Deprecated('Use validateSmartCardRequestDescriptor instead')
const ValidateSmartCardRequest$json = const {
  '1': 'ValidateSmartCardRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'smart_card_number', '3': 2, '4': 1, '5': 9, '10': 'smartCardNumber'},
  ],
};

/// Descriptor for `ValidateSmartCardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateSmartCardRequestDescriptor = $convert.base64Decode('ChhWYWxpZGF0ZVNtYXJ0Q2FyZFJlcXVlc3QSHwoLcHJvdmlkZXJfaWQYASABKAlSCnByb3ZpZGVySWQSKgoRc21hcnRfY2FyZF9udW1iZXIYAiABKAlSD3NtYXJ0Q2FyZE51bWJlcg==');
@$core.Deprecated('Use validateSmartCardResponseDescriptor instead')
const ValidateSmartCardResponse$json = const {
  '1': 'ValidateSmartCardResponse',
  '2': const [
    const {'1': 'validation', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.SmartCardValidation', '10': 'validation'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ValidateSmartCardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateSmartCardResponseDescriptor = $convert.base64Decode('ChlWYWxpZGF0ZVNtYXJ0Q2FyZFJlc3BvbnNlEkQKCnZhbGlkYXRpb24YASABKAsyJC51dGlsaXR5cGF5bWVudHMuU21hcnRDYXJkVmFsaWRhdGlvblIKdmFsaWRhdGlvbhIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getTVPackagesRequestDescriptor instead')
const GetTVPackagesRequest$json = const {
  '1': 'GetTVPackagesRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
  ],
};

/// Descriptor for `GetTVPackagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTVPackagesRequestDescriptor = $convert.base64Decode('ChRHZXRUVlBhY2thZ2VzUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZA==');
@$core.Deprecated('Use getTVPackagesResponseDescriptor instead')
const GetTVPackagesResponse$json = const {
  '1': 'GetTVPackagesResponse',
  '2': const [
    const {'1': 'packages', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.TVPackage', '10': 'packages'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetTVPackagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTVPackagesResponseDescriptor = $convert.base64Decode('ChVHZXRUVlBhY2thZ2VzUmVzcG9uc2USNgoIcGFja2FnZXMYASADKAsyGi51dGlsaXR5cGF5bWVudHMuVFZQYWNrYWdlUghwYWNrYWdlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use payCableTVBillRequestDescriptor instead')
const PayCableTVBillRequest$json = const {
  '1': 'PayCableTVBillRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'smart_card_number', '3': 2, '4': 1, '5': 9, '10': 'smartCardNumber'},
    const {'1': 'variation_code', '3': 3, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'transaction_id', '3': 6, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 7, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 8, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayCableTVBillRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payCableTVBillRequestDescriptor = $convert.base64Decode('ChVQYXlDYWJsZVRWQmlsbFJlcXVlc3QSHwoLcHJvdmlkZXJfaWQYASABKAlSCnByb3ZpZGVySWQSKgoRc21hcnRfY2FyZF9udW1iZXIYAiABKAlSD3NtYXJ0Q2FyZE51bWJlchIlCg52YXJpYXRpb25fY29kZRgDIAEoCVINdmFyaWF0aW9uQ29kZRIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIUCgVwaG9uZRgFIAEoCVIFcGhvbmUSJQoOdHJhbnNhY3Rpb25faWQYBiABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAcgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYCCABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use payCableTVBillResponseDescriptor instead')
const PayCableTVBillResponse$json = const {
  '1': 'PayCableTVBillResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'renewal_date', '3': 3, '4': 1, '5': 9, '10': 'renewalDate'},
    const {'1': 'customer_name', '3': 4, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayCableTVBillResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payCableTVBillResponseDescriptor = $convert.base64Decode('ChZQYXlDYWJsZVRWQmlsbFJlc3BvbnNlEjYKB3BheW1lbnQYASABKAsyHC51dGlsaXR5cGF5bWVudHMuQmlsbFBheW1lbnRSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USIQoMcmVuZXdhbF9kYXRlGAMgASgJUgtyZW5ld2FsRGF0ZRIjCg1jdXN0b21lcl9uYW1lGAQgASgJUgxjdXN0b21lck5hbWUSGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getCableTVProvidersRequestDescriptor instead')
const GetCableTVProvidersRequest$json = const {
  '1': 'GetCableTVProvidersRequest',
  '2': const [
    const {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetCableTVProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVProvidersRequestDescriptor = $convert.base64Decode('ChpHZXRDYWJsZVRWUHJvdmlkZXJzUmVxdWVzdBIfCgthY3RpdmVfb25seRgBIAEoCFIKYWN0aXZlT25seQ==');
@$core.Deprecated('Use getCableTVProvidersResponseDescriptor instead')
const GetCableTVProvidersResponse$json = const {
  '1': 'GetCableTVProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.CableTVProvider', '10': 'providers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetCableTVProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVProvidersResponseDescriptor = $convert.base64Decode('ChtHZXRDYWJsZVRWUHJvdmlkZXJzUmVzcG9uc2USPgoJcHJvdmlkZXJzGAEgAygLMiAudXRpbGl0eXBheW1lbnRzLkNhYmxlVFZQcm92aWRlclIJcHJvdmlkZXJzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use educationProviderDescriptor instead')
const EducationProvider$json = const {
  '1': 'EducationProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'service_id', '3': 3, '4': 1, '5': 9, '10': 'serviceId'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'variation_code', '3': 8, '4': 1, '5': 9, '10': 'variationCode'},
  ],
};

/// Descriptor for `EducationProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List educationProviderDescriptor = $convert.base64Decode('ChFFZHVjYXRpb25Qcm92aWRlchIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIdCgpzZXJ2aWNlX2lkGAMgASgJUglzZXJ2aWNlSWQSGQoIbG9nb191cmwYBCABKAlSB2xvZ29VcmwSGwoJaXNfYWN0aXZlGAUgASgIUghpc0FjdGl2ZRIWCgZhbW91bnQYBiABKAFSBmFtb3VudBIgCgtkZXNjcmlwdGlvbhgHIAEoCVILZGVzY3JpcHRpb24SJQoOdmFyaWF0aW9uX2NvZGUYCCABKAlSDXZhcmlhdGlvbkNvZGU=');
@$core.Deprecated('Use educationPinResultDescriptor instead')
const EducationPinResult$json = const {
  '1': 'EducationPinResult',
  '2': const [
    const {'1': 'pin', '3': 1, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'serial', '3': 2, '4': 1, '5': 9, '10': 'serial'},
    const {'1': 'expires_at', '3': 3, '4': 1, '5': 9, '10': 'expiresAt'},
  ],
};

/// Descriptor for `EducationPinResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List educationPinResultDescriptor = $convert.base64Decode('ChJFZHVjYXRpb25QaW5SZXN1bHQSEAoDcGluGAEgASgJUgNwaW4SFgoGc2VyaWFsGAIgASgJUgZzZXJpYWwSHQoKZXhwaXJlc19hdBgDIAEoCVIJZXhwaXJlc0F0');
@$core.Deprecated('Use purchaseEducationPinRequestDescriptor instead')
const PurchaseEducationPinRequest$json = const {
  '1': 'PurchaseEducationPinRequest',
  '2': const [
    const {'1': 'service_id', '3': 1, '4': 1, '5': 9, '10': 'serviceId'},
    const {'1': 'quantity', '3': 2, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'transaction_id', '3': 4, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 5, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 6, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'variation_code', '3': 7, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'billers_code', '3': 8, '4': 1, '5': 9, '10': 'billersCode'},
  ],
};

/// Descriptor for `PurchaseEducationPinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseEducationPinRequestDescriptor = $convert.base64Decode('ChtQdXJjaGFzZUVkdWNhdGlvblBpblJlcXVlc3QSHQoKc2VydmljZV9pZBgBIAEoCVIJc2VydmljZUlkEhoKCHF1YW50aXR5GAIgASgFUghxdWFudGl0eRIUCgVwaG9uZRgDIAEoCVIFcGhvbmUSJQoOdHJhbnNhY3Rpb25faWQYBCABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAUgASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYBiABKAlSDmlkZW1wb3RlbmN5S2V5EiUKDnZhcmlhdGlvbl9jb2RlGAcgASgJUg12YXJpYXRpb25Db2RlEiEKDGJpbGxlcnNfY29kZRgIIAEoCVILYmlsbGVyc0NvZGU=');
@$core.Deprecated('Use purchaseEducationPinResponseDescriptor instead')
const PurchaseEducationPinResponse$json = const {
  '1': 'PurchaseEducationPinResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'pins', '3': 3, '4': 3, '5': 11, '6': '.utilitypayments.EducationPinResult', '10': 'pins'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PurchaseEducationPinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseEducationPinResponseDescriptor = $convert.base64Decode('ChxQdXJjaGFzZUVkdWNhdGlvblBpblJlc3BvbnNlEjYKB3BheW1lbnQYASABKAsyHC51dGlsaXR5cGF5bWVudHMuQmlsbFBheW1lbnRSB3BheW1lbnQSHwoLbmV3X2JhbGFuY2UYAiABKAFSCm5ld0JhbGFuY2USNwoEcGlucxgDIAMoCzIjLnV0aWxpdHlwYXltZW50cy5FZHVjYXRpb25QaW5SZXN1bHRSBHBpbnMSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getEducationProvidersRequestDescriptor instead')
const GetEducationProvidersRequest$json = const {
  '1': 'GetEducationProvidersRequest',
  '2': const [
    const {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetEducationProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationProvidersRequestDescriptor = $convert.base64Decode('ChxHZXRFZHVjYXRpb25Qcm92aWRlcnNSZXF1ZXN0Eh8KC2FjdGl2ZV9vbmx5GAEgASgIUgphY3RpdmVPbmx5');
@$core.Deprecated('Use getEducationProvidersResponseDescriptor instead')
const GetEducationProvidersResponse$json = const {
  '1': 'GetEducationProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.EducationProvider', '10': 'providers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetEducationProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationProvidersResponseDescriptor = $convert.base64Decode('Ch1HZXRFZHVjYXRpb25Qcm92aWRlcnNSZXNwb25zZRJACglwcm92aWRlcnMYASADKAsyIi51dGlsaXR5cGF5bWVudHMuRWR1Y2F0aW9uUHJvdmlkZXJSCXByb3ZpZGVycxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use dataPlanDescriptor instead')
const DataPlan$json = const {
  '1': 'DataPlan',
  '2': const [
    const {'1': 'variation_id', '3': 1, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'price', '3': 3, '4': 1, '5': 1, '10': 'price'},
    const {'1': 'network', '3': 4, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'availability', '3': 5, '4': 1, '5': 9, '10': 'availability'},
  ],
};

/// Descriptor for `DataPlan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataPlanDescriptor = $convert.base64Decode('CghEYXRhUGxhbhIhCgx2YXJpYXRpb25faWQYASABKAlSC3ZhcmlhdGlvbklkEhIKBG5hbWUYAiABKAlSBG5hbWUSFAoFcHJpY2UYAyABKAFSBXByaWNlEhgKB25ldHdvcmsYBCABKAlSB25ldHdvcmsSIgoMYXZhaWxhYmlsaXR5GAUgASgJUgxhdmFpbGFiaWxpdHk=');
@$core.Deprecated('Use getDataPlansRequestDescriptor instead')
const GetDataPlansRequest$json = const {
  '1': 'GetDataPlansRequest',
  '2': const [
    const {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `GetDataPlansRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataPlansRequestDescriptor = $convert.base64Decode('ChNHZXREYXRhUGxhbnNSZXF1ZXN0EhgKB25ldHdvcmsYASABKAlSB25ldHdvcms=');
@$core.Deprecated('Use getDataPlansResponseDescriptor instead')
const GetDataPlansResponse$json = const {
  '1': 'GetDataPlansResponse',
  '2': const [
    const {'1': 'plans', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.DataPlan', '10': 'plans'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetDataPlansResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataPlansResponseDescriptor = $convert.base64Decode('ChRHZXREYXRhUGxhbnNSZXNwb25zZRIvCgVwbGFucxgBIAMoCzIZLnV0aWxpdHlwYXltZW50cy5EYXRhUGxhblIFcGxhbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use buyDataRequestDescriptor instead')
const BuyDataRequest$json = const {
  '1': 'BuyDataRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'variation_id', '3': 3, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_id', '3': 5, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 6, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 7, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'country_code', '3': 8, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `BuyDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyDataRequestDescriptor = $convert.base64Decode('Cg5CdXlEYXRhUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEhgKB25ldHdvcmsYAiABKAlSB25ldHdvcmsSIQoMdmFyaWF0aW9uX2lkGAMgASgJUgt2YXJpYXRpb25JZBIWCgZhbW91bnQYBCABKAFSBmFtb3VudBIlCg50cmFuc2FjdGlvbl9pZBgFIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YBiABKAlSEXZlcmlmaWNhdGlvblRva2VuEicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVuY3lLZXkSIQoMY291bnRyeV9jb2RlGAggASgJUgtjb3VudHJ5Q29kZQ==');
@$core.Deprecated('Use buyDataResponseDescriptor instead')
const BuyDataResponse$json = const {
  '1': 'BuyDataResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'data_plan', '3': 4, '4': 1, '5': 9, '10': 'dataPlan'},
    const {'1': 'message', '3': 5, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'commission_earned', '3': 6, '4': 1, '5': 1, '10': 'commissionEarned'},
    const {'1': 'provider_reference', '3': 7, '4': 1, '5': 9, '10': 'providerReference'},
  ],
};

/// Descriptor for `BuyDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyDataResponseDescriptor = $convert.base64Decode('Cg9CdXlEYXRhUmVzcG9uc2USNgoHcGF5bWVudBgBIAEoCzIcLnV0aWxpdHlwYXltZW50cy5CaWxsUGF5bWVudFIHcGF5bWVudBIfCgtuZXdfYmFsYW5jZRgCIAEoAVIKbmV3QmFsYW5jZRIhCgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEhsKCWRhdGFfcGxhbhgEIAEoCVIIZGF0YVBsYW4SGAoHbWVzc2FnZRgFIAEoCVIHbWVzc2FnZRIrChFjb21taXNzaW9uX2Vhcm5lZBgGIAEoAVIQY29tbWlzc2lvbkVhcm5lZBItChJwcm92aWRlcl9yZWZlcmVuY2UYByABKAlSEXByb3ZpZGVyUmVmZXJlbmNl');
@$core.Deprecated('Use internetProviderDescriptor instead')
const InternetProvider$json = const {
  '1': 'InternetProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'service_id', '3': 3, '4': 1, '5': 9, '10': 'serviceId'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'commission_rate', '3': 6, '4': 1, '5': 1, '10': 'commissionRate'},
  ],
};

/// Descriptor for `InternetProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetProviderDescriptor = $convert.base64Decode('ChBJbnRlcm5ldFByb3ZpZGVyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh0KCnNlcnZpY2VfaWQYAyABKAlSCXNlcnZpY2VJZBIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEicKD2NvbW1pc3Npb25fcmF0ZRgGIAEoAVIOY29tbWlzc2lvblJhdGU=');
@$core.Deprecated('Use internetPackageDescriptor instead')
const InternetPackage$json = const {
  '1': 'InternetPackage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'variation_code', '3': 3, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'provider_id', '3': 5, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'validity', '3': 6, '4': 1, '5': 9, '10': 'validity'},
  ],
};

/// Descriptor for `InternetPackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetPackageDescriptor = $convert.base64Decode('Cg9JbnRlcm5ldFBhY2thZ2USDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSJQoOdmFyaWF0aW9uX2NvZGUYAyABKAlSDXZhcmlhdGlvbkNvZGUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSHwoLcHJvdmlkZXJfaWQYBSABKAlSCnByb3ZpZGVySWQSGgoIdmFsaWRpdHkYBiABKAlSCHZhbGlkaXR5');
@$core.Deprecated('Use internetAccountValidationDescriptor instead')
const InternetAccountValidation$json = const {
  '1': 'InternetAccountValidation',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'due_amount', '3': 5, '4': 1, '5': 1, '10': 'dueAmount'},
  ],
};

/// Descriptor for `InternetAccountValidation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetAccountValidationDescriptor = $convert.base64Decode('ChlJbnRlcm5ldEFjY291bnRWYWxpZGF0aW9uEhkKCGlzX3ZhbGlkGAEgASgIUgdpc1ZhbGlkEiMKDWN1c3RvbWVyX25hbWUYAiABKAlSDGN1c3RvbWVyTmFtZRIlCg5hY2NvdW50X251bWJlchgDIAEoCVINYWNjb3VudE51bWJlchIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxIdCgpkdWVfYW1vdW50GAUgASgBUglkdWVBbW91bnQ=');
@$core.Deprecated('Use getInternetProvidersRequestDescriptor instead')
const GetInternetProvidersRequest$json = const {
  '1': 'GetInternetProvidersRequest',
  '2': const [
    const {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetInternetProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetProvidersRequestDescriptor = $convert.base64Decode('ChtHZXRJbnRlcm5ldFByb3ZpZGVyc1JlcXVlc3QSHwoLYWN0aXZlX29ubHkYASABKAhSCmFjdGl2ZU9ubHk=');
@$core.Deprecated('Use getInternetProvidersResponseDescriptor instead')
const GetInternetProvidersResponse$json = const {
  '1': 'GetInternetProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.InternetProvider', '10': 'providers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInternetProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetProvidersResponseDescriptor = $convert.base64Decode('ChxHZXRJbnRlcm5ldFByb3ZpZGVyc1Jlc3BvbnNlEj8KCXByb3ZpZGVycxgBIAMoCzIhLnV0aWxpdHlwYXltZW50cy5JbnRlcm5ldFByb3ZpZGVyUglwcm92aWRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use validateInternetAccountRequestDescriptor instead')
const ValidateInternetAccountRequest$json = const {
  '1': 'ValidateInternetAccountRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'account_number', '3': 2, '4': 1, '5': 9, '10': 'accountNumber'},
  ],
};

/// Descriptor for `ValidateInternetAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInternetAccountRequestDescriptor = $convert.base64Decode('Ch5WYWxpZGF0ZUludGVybmV0QWNjb3VudFJlcXVlc3QSHwoLcHJvdmlkZXJfaWQYASABKAlSCnByb3ZpZGVySWQSJQoOYWNjb3VudF9udW1iZXIYAiABKAlSDWFjY291bnROdW1iZXI=');
@$core.Deprecated('Use validateInternetAccountResponseDescriptor instead')
const ValidateInternetAccountResponse$json = const {
  '1': 'ValidateInternetAccountResponse',
  '2': const [
    const {'1': 'validation', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.InternetAccountValidation', '10': 'validation'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ValidateInternetAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInternetAccountResponseDescriptor = $convert.base64Decode('Ch9WYWxpZGF0ZUludGVybmV0QWNjb3VudFJlc3BvbnNlEkoKCnZhbGlkYXRpb24YASABKAsyKi51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRBY2NvdW50VmFsaWRhdGlvblIKdmFsaWRhdGlvbhIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getInternetPackagesRequestDescriptor instead')
const GetInternetPackagesRequest$json = const {
  '1': 'GetInternetPackagesRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
  ],
};

/// Descriptor for `GetInternetPackagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetPackagesRequestDescriptor = $convert.base64Decode('ChpHZXRJbnRlcm5ldFBhY2thZ2VzUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZA==');
@$core.Deprecated('Use getInternetPackagesResponseDescriptor instead')
const GetInternetPackagesResponse$json = const {
  '1': 'GetInternetPackagesResponse',
  '2': const [
    const {'1': 'packages', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.InternetPackage', '10': 'packages'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetInternetPackagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetPackagesResponseDescriptor = $convert.base64Decode('ChtHZXRJbnRlcm5ldFBhY2thZ2VzUmVzcG9uc2USPAoIcGFja2FnZXMYASADKAsyIC51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRQYWNrYWdlUghwYWNrYWdlcxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use activeSubscriptionDescriptor instead')
const ActiveSubscription$json = const {
  '1': 'ActiveSubscription',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'subscription_type', '3': 2, '4': 1, '5': 9, '10': 'subscriptionType'},
    const {'1': 'provider_id', '3': 3, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'plan_name', '3': 5, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'customer_number', '3': 8, '4': 1, '5': 9, '10': 'customerNumber'},
    const {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'purchased_at', '3': 10, '4': 1, '5': 9, '10': 'purchasedAt'},
    const {'1': 'expires_at', '3': 11, '4': 1, '5': 9, '10': 'expiresAt'},
    const {'1': 'validity_days', '3': 12, '4': 1, '5': 5, '10': 'validityDays'},
    const {'1': 'renewal_date', '3': 13, '4': 1, '5': 9, '10': 'renewalDate'},
    const {'1': 'token', '3': 14, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'units', '3': 15, '4': 1, '5': 1, '10': 'units'},
    const {'1': 'progress_percentage', '3': 16, '4': 1, '5': 1, '10': 'progressPercentage'},
    const {'1': 'days_remaining', '3': 17, '4': 1, '5': 5, '10': 'daysRemaining'},
    const {'1': 'payment_reference', '3': 18, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'auto_renew_enabled', '3': 19, '4': 1, '5': 8, '10': 'autoRenewEnabled'},
    const {'1': 'auto_renew_variation_id', '3': 20, '4': 1, '5': 9, '10': 'autoRenewVariationId'},
    const {'1': 'auto_renew_network', '3': 21, '4': 1, '5': 9, '10': 'autoRenewNetwork'},
    const {'1': 'auto_renew_amount', '3': 22, '4': 1, '5': 1, '10': 'autoRenewAmount'},
    const {'1': 'renewal_attempts', '3': 23, '4': 1, '5': 5, '10': 'renewalAttempts'},
    const {'1': 'next_renewal_at', '3': 24, '4': 1, '5': 9, '10': 'nextRenewalAt'},
    const {'1': 'auto_renew_disabled_reason', '3': 25, '4': 1, '5': 9, '10': 'autoRenewDisabledReason'},
  ],
};

/// Descriptor for `ActiveSubscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activeSubscriptionDescriptor = $convert.base64Decode('ChJBY3RpdmVTdWJzY3JpcHRpb24SDgoCaWQYASABKAlSAmlkEisKEXN1YnNjcmlwdGlvbl90eXBlGAIgASgJUhBzdWJzY3JpcHRpb25UeXBlEh8KC3Byb3ZpZGVyX2lkGAMgASgJUgpwcm92aWRlcklkEiMKDXByb3ZpZGVyX25hbWUYBCABKAlSDHByb3ZpZGVyTmFtZRIbCglwbGFuX25hbWUYBSABKAlSCHBsYW5OYW1lEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRInCg9jdXN0b21lcl9udW1iZXIYCCABKAlSDmN1c3RvbWVyTnVtYmVyEhYKBnN0YXR1cxgJIAEoCVIGc3RhdHVzEiEKDHB1cmNoYXNlZF9hdBgKIAEoCVILcHVyY2hhc2VkQXQSHQoKZXhwaXJlc19hdBgLIAEoCVIJZXhwaXJlc0F0EiMKDXZhbGlkaXR5X2RheXMYDCABKAVSDHZhbGlkaXR5RGF5cxIhCgxyZW5ld2FsX2RhdGUYDSABKAlSC3JlbmV3YWxEYXRlEhQKBXRva2VuGA4gASgJUgV0b2tlbhIUCgV1bml0cxgPIAEoAVIFdW5pdHMSLwoTcHJvZ3Jlc3NfcGVyY2VudGFnZRgQIAEoAVIScHJvZ3Jlc3NQZXJjZW50YWdlEiUKDmRheXNfcmVtYWluaW5nGBEgASgFUg1kYXlzUmVtYWluaW5nEisKEXBheW1lbnRfcmVmZXJlbmNlGBIgASgJUhBwYXltZW50UmVmZXJlbmNlEiwKEmF1dG9fcmVuZXdfZW5hYmxlZBgTIAEoCFIQYXV0b1JlbmV3RW5hYmxlZBI1ChdhdXRvX3JlbmV3X3ZhcmlhdGlvbl9pZBgUIAEoCVIUYXV0b1JlbmV3VmFyaWF0aW9uSWQSLAoSYXV0b19yZW5ld19uZXR3b3JrGBUgASgJUhBhdXRvUmVuZXdOZXR3b3JrEioKEWF1dG9fcmVuZXdfYW1vdW50GBYgASgBUg9hdXRvUmVuZXdBbW91bnQSKQoQcmVuZXdhbF9hdHRlbXB0cxgXIAEoBVIPcmVuZXdhbEF0dGVtcHRzEiYKD25leHRfcmVuZXdhbF9hdBgYIAEoCVINbmV4dFJlbmV3YWxBdBI7ChphdXRvX3JlbmV3X2Rpc2FibGVkX3JlYXNvbhgZIAEoCVIXYXV0b1JlbmV3RGlzYWJsZWRSZWFzb24=');
@$core.Deprecated('Use getActiveSubscriptionsRequestDescriptor instead')
const GetActiveSubscriptionsRequest$json = const {
  '1': 'GetActiveSubscriptionsRequest',
  '2': const [
    const {'1': 'subscription_type', '3': 1, '4': 1, '5': 9, '10': 'subscriptionType'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetActiveSubscriptionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveSubscriptionsRequestDescriptor = $convert.base64Decode('Ch1HZXRBY3RpdmVTdWJzY3JpcHRpb25zUmVxdWVzdBIrChFzdWJzY3JpcHRpb25fdHlwZRgBIAEoCVIQc3Vic2NyaXB0aW9uVHlwZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getActiveSubscriptionsResponseDescriptor instead')
const GetActiveSubscriptionsResponse$json = const {
  '1': 'GetActiveSubscriptionsResponse',
  '2': const [
    const {'1': 'subscriptions', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.ActiveSubscription', '10': 'subscriptions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetActiveSubscriptionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActiveSubscriptionsResponseDescriptor = $convert.base64Decode('Ch5HZXRBY3RpdmVTdWJzY3JpcHRpb25zUmVzcG9uc2USSQoNc3Vic2NyaXB0aW9ucxgBIAMoCzIjLnV0aWxpdHlwYXltZW50cy5BY3RpdmVTdWJzY3JpcHRpb25SDXN1YnNjcmlwdGlvbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use subscriptionTypeSummaryDescriptor instead')
const SubscriptionTypeSummary$json = const {
  '1': 'SubscriptionTypeSummary',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    const {'1': 'total_spend', '3': 3, '4': 1, '5': 1, '10': 'totalSpend'},
  ],
};

/// Descriptor for `SubscriptionTypeSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscriptionTypeSummaryDescriptor = $convert.base64Decode('ChdTdWJzY3JpcHRpb25UeXBlU3VtbWFyeRISCgR0eXBlGAEgASgJUgR0eXBlEhQKBWNvdW50GAIgASgFUgVjb3VudBIfCgt0b3RhbF9zcGVuZBgDIAEoAVIKdG90YWxTcGVuZA==');
@$core.Deprecated('Use getSubscriptionSummaryRequestDescriptor instead')
const GetSubscriptionSummaryRequest$json = const {
  '1': 'GetSubscriptionSummaryRequest',
};

/// Descriptor for `GetSubscriptionSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionSummaryRequestDescriptor = $convert.base64Decode('Ch1HZXRTdWJzY3JpcHRpb25TdW1tYXJ5UmVxdWVzdA==');
@$core.Deprecated('Use getSubscriptionSummaryResponseDescriptor instead')
const GetSubscriptionSummaryResponse$json = const {
  '1': 'GetSubscriptionSummaryResponse',
  '2': const [
    const {'1': 'active_count', '3': 1, '4': 1, '5': 5, '10': 'activeCount'},
    const {'1': 'expiring_count', '3': 2, '4': 1, '5': 5, '10': 'expiringCount'},
    const {'1': 'total_monthly_spend', '3': 3, '4': 1, '5': 1, '10': 'totalMonthlySpend'},
    const {'1': 'by_type', '3': 4, '4': 3, '5': 11, '6': '.utilitypayments.SubscriptionTypeSummary', '10': 'byType'},
  ],
};

/// Descriptor for `GetSubscriptionSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionSummaryResponseDescriptor = $convert.base64Decode('Ch5HZXRTdWJzY3JpcHRpb25TdW1tYXJ5UmVzcG9uc2USIQoMYWN0aXZlX2NvdW50GAEgASgFUgthY3RpdmVDb3VudBIlCg5leHBpcmluZ19jb3VudBgCIAEoBVINZXhwaXJpbmdDb3VudBIuChN0b3RhbF9tb250aGx5X3NwZW5kGAMgASgBUhF0b3RhbE1vbnRobHlTcGVuZBJBCgdieV90eXBlGAQgAygLMigudXRpbGl0eXBheW1lbnRzLlN1YnNjcmlwdGlvblR5cGVTdW1tYXJ5UgZieVR5cGU=');
@$core.Deprecated('Use monthlySubscriptionSpendingDescriptor instead')
const MonthlySubscriptionSpending$json = const {
  '1': 'MonthlySubscriptionSpending',
  '2': const [
    const {'1': 'month', '3': 1, '4': 1, '5': 9, '10': 'month'},
    const {'1': 'total', '3': 2, '4': 1, '5': 1, '10': 'total'},
  ],
};

/// Descriptor for `MonthlySubscriptionSpending`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monthlySubscriptionSpendingDescriptor = $convert.base64Decode('ChtNb250aGx5U3Vic2NyaXB0aW9uU3BlbmRpbmcSFAoFbW9udGgYASABKAlSBW1vbnRoEhQKBXRvdGFsGAIgASgBUgV0b3RhbA==');
@$core.Deprecated('Use getSubscriptionSpendingRequestDescriptor instead')
const GetSubscriptionSpendingRequest$json = const {
  '1': 'GetSubscriptionSpendingRequest',
  '2': const [
    const {'1': 'months', '3': 1, '4': 1, '5': 5, '10': 'months'},
  ],
};

/// Descriptor for `GetSubscriptionSpendingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionSpendingRequestDescriptor = $convert.base64Decode('Ch5HZXRTdWJzY3JpcHRpb25TcGVuZGluZ1JlcXVlc3QSFgoGbW9udGhzGAEgASgFUgZtb250aHM=');
@$core.Deprecated('Use getSubscriptionSpendingResponseDescriptor instead')
const GetSubscriptionSpendingResponse$json = const {
  '1': 'GetSubscriptionSpendingResponse',
  '2': const [
    const {'1': 'total_all_time', '3': 1, '4': 1, '5': 1, '10': 'totalAllTime'},
    const {'1': 'total_this_month', '3': 2, '4': 1, '5': 1, '10': 'totalThisMonth'},
    const {'1': 'by_type', '3': 3, '4': 3, '5': 11, '6': '.utilitypayments.GetSubscriptionSpendingResponse.ByTypeEntry', '10': 'byType'},
    const {'1': 'monthly_trend', '3': 4, '4': 3, '5': 11, '6': '.utilitypayments.MonthlySubscriptionSpending', '10': 'monthlyTrend'},
  ],
  '3': const [GetSubscriptionSpendingResponse_ByTypeEntry$json],
};

@$core.Deprecated('Use getSubscriptionSpendingResponseDescriptor instead')
const GetSubscriptionSpendingResponse_ByTypeEntry$json = const {
  '1': 'ByTypeEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetSubscriptionSpendingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionSpendingResponseDescriptor = $convert.base64Decode('Ch9HZXRTdWJzY3JpcHRpb25TcGVuZGluZ1Jlc3BvbnNlEiQKDnRvdGFsX2FsbF90aW1lGAEgASgBUgx0b3RhbEFsbFRpbWUSKAoQdG90YWxfdGhpc19tb250aBgCIAEoAVIOdG90YWxUaGlzTW9udGgSVQoHYnlfdHlwZRgDIAMoCzI8LnV0aWxpdHlwYXltZW50cy5HZXRTdWJzY3JpcHRpb25TcGVuZGluZ1Jlc3BvbnNlLkJ5VHlwZUVudHJ5UgZieVR5cGUSUQoNbW9udGhseV90cmVuZBgEIAMoCzIsLnV0aWxpdHlwYXltZW50cy5Nb250aGx5U3Vic2NyaXB0aW9uU3BlbmRpbmdSDG1vbnRobHlUcmVuZBo5CgtCeVR5cGVFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoAVIFdmFsdWU6AjgB');
@$core.Deprecated('Use enableAutoRenewRequestDescriptor instead')
const EnableAutoRenewRequest$json = const {
  '1': 'EnableAutoRenewRequest',
  '2': const [
    const {'1': 'subscription_id', '3': 1, '4': 1, '5': 9, '10': 'subscriptionId'},
    const {'1': 'variation_id', '3': 2, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `EnableAutoRenewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableAutoRenewRequestDescriptor = $convert.base64Decode('ChZFbmFibGVBdXRvUmVuZXdSZXF1ZXN0EicKD3N1YnNjcmlwdGlvbl9pZBgBIAEoCVIOc3Vic2NyaXB0aW9uSWQSIQoMdmFyaWF0aW9uX2lkGAIgASgJUgt2YXJpYXRpb25JZBIYCgduZXR3b3JrGAMgASgJUgduZXR3b3JrEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50');
@$core.Deprecated('Use enableAutoRenewResponseDescriptor instead')
const EnableAutoRenewResponse$json = const {
  '1': 'EnableAutoRenewResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'subscription', '3': 3, '4': 1, '5': 11, '6': '.utilitypayments.ActiveSubscription', '10': 'subscription'},
  ],
};

/// Descriptor for `EnableAutoRenewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enableAutoRenewResponseDescriptor = $convert.base64Decode('ChdFbmFibGVBdXRvUmVuZXdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USRwoMc3Vic2NyaXB0aW9uGAMgASgLMiMudXRpbGl0eXBheW1lbnRzLkFjdGl2ZVN1YnNjcmlwdGlvblIMc3Vic2NyaXB0aW9u');
@$core.Deprecated('Use disableAutoRenewRequestDescriptor instead')
const DisableAutoRenewRequest$json = const {
  '1': 'DisableAutoRenewRequest',
  '2': const [
    const {'1': 'subscription_id', '3': 1, '4': 1, '5': 9, '10': 'subscriptionId'},
  ],
};

/// Descriptor for `DisableAutoRenewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableAutoRenewRequestDescriptor = $convert.base64Decode('ChdEaXNhYmxlQXV0b1JlbmV3UmVxdWVzdBInCg9zdWJzY3JpcHRpb25faWQYASABKAlSDnN1YnNjcmlwdGlvbklk');
@$core.Deprecated('Use disableAutoRenewResponseDescriptor instead')
const DisableAutoRenewResponse$json = const {
  '1': 'DisableAutoRenewResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DisableAutoRenewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disableAutoRenewResponseDescriptor = $convert.base64Decode('ChhEaXNhYmxlQXV0b1JlbmV3UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getAutoRenewSubscriptionsRequestDescriptor instead')
const GetAutoRenewSubscriptionsRequest$json = const {
  '1': 'GetAutoRenewSubscriptionsRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAutoRenewSubscriptionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoRenewSubscriptionsRequestDescriptor = $convert.base64Decode('CiBHZXRBdXRvUmVuZXdTdWJzY3JpcHRpb25zUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAIgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getAutoRenewSubscriptionsResponseDescriptor instead')
const GetAutoRenewSubscriptionsResponse$json = const {
  '1': 'GetAutoRenewSubscriptionsResponse',
  '2': const [
    const {'1': 'subscriptions', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.ActiveSubscription', '10': 'subscriptions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAutoRenewSubscriptionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoRenewSubscriptionsResponseDescriptor = $convert.base64Decode('CiFHZXRBdXRvUmVuZXdTdWJzY3JpcHRpb25zUmVzcG9uc2USSQoNc3Vic2NyaXB0aW9ucxgBIAMoCzIjLnV0aWxpdHlwYXltZW50cy5BY3RpdmVTdWJzY3JpcHRpb25SDXN1YnNjcmlwdGlvbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use updateAutoRenewPlanRequestDescriptor instead')
const UpdateAutoRenewPlanRequest$json = const {
  '1': 'UpdateAutoRenewPlanRequest',
  '2': const [
    const {'1': 'subscription_id', '3': 1, '4': 1, '5': 9, '10': 'subscriptionId'},
    const {'1': 'new_variation_id', '3': 2, '4': 1, '5': 9, '10': 'newVariationId'},
    const {'1': 'new_amount', '3': 3, '4': 1, '5': 1, '10': 'newAmount'},
  ],
};

/// Descriptor for `UpdateAutoRenewPlanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoRenewPlanRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVBdXRvUmVuZXdQbGFuUmVxdWVzdBInCg9zdWJzY3JpcHRpb25faWQYASABKAlSDnN1YnNjcmlwdGlvbklkEigKEG5ld192YXJpYXRpb25faWQYAiABKAlSDm5ld1ZhcmlhdGlvbklkEh0KCm5ld19hbW91bnQYAyABKAFSCW5ld0Ftb3VudA==');
@$core.Deprecated('Use updateAutoRenewPlanResponseDescriptor instead')
const UpdateAutoRenewPlanResponse$json = const {
  '1': 'UpdateAutoRenewPlanResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'subscription', '3': 3, '4': 1, '5': 11, '6': '.utilitypayments.ActiveSubscription', '10': 'subscription'},
  ],
};

/// Descriptor for `UpdateAutoRenewPlanResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoRenewPlanResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVBdXRvUmVuZXdQbGFuUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEkcKDHN1YnNjcmlwdGlvbhgDIAEoCzIjLnV0aWxpdHlwYXltZW50cy5BY3RpdmVTdWJzY3JpcHRpb25SDHN1YnNjcmlwdGlvbg==');
@$core.Deprecated('Use transferAirtimeRequestDescriptor instead')
const TransferAirtimeRequest$json = const {
  '1': 'TransferAirtimeRequest',
  '2': const [
    const {'1': 'sender_phone', '3': 1, '4': 1, '5': 9, '10': 'senderPhone'},
    const {'1': 'recipient_phone', '3': 2, '4': 1, '5': 9, '10': 'recipientPhone'},
    const {'1': 'network', '3': 3, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'country_code', '3': 5, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'operator_id', '3': 6, '4': 1, '5': 9, '10': 'operatorId'},
    const {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 8, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'recipient_name', '3': 10, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'transfer_note', '3': 11, '4': 1, '5': 9, '10': 'transferNote'},
  ],
};

/// Descriptor for `TransferAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferAirtimeRequestDescriptor = $convert.base64Decode('ChZUcmFuc2ZlckFpcnRpbWVSZXF1ZXN0EiEKDHNlbmRlcl9waG9uZRgBIAEoCVILc2VuZGVyUGhvbmUSJwoPcmVjaXBpZW50X3Bob25lGAIgASgJUg5yZWNpcGllbnRQaG9uZRIYCgduZXR3b3JrGAMgASgJUgduZXR3b3JrEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EiEKDGNvdW50cnlfY29kZRgFIAEoCVILY291bnRyeUNvZGUSHwoLb3BlcmF0b3JfaWQYBiABKAlSCm9wZXJhdG9ySWQSJQoOdHJhbnNhY3Rpb25faWQYByABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAggASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2V5EiUKDnJlY2lwaWVudF9uYW1lGAogASgJUg1yZWNpcGllbnROYW1lEiMKDXRyYW5zZmVyX25vdGUYCyABKAlSDHRyYW5zZmVyTm90ZQ==');
@$core.Deprecated('Use transferAirtimeResponseDescriptor instead')
const TransferAirtimeResponse$json = const {
  '1': 'TransferAirtimeResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'recipient_phone', '3': 3, '4': 1, '5': 9, '10': 'recipientPhone'},
    const {'1': 'recipient_name', '3': 4, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'amount_sent', '3': 5, '4': 1, '5': 1, '10': 'amountSent'},
    const {'1': 'commission', '3': 6, '4': 1, '5': 1, '10': 'commission'},
    const {'1': 'total_charged', '3': 7, '4': 1, '5': 1, '10': 'totalCharged'},
    const {'1': 'provider_reference', '3': 8, '4': 1, '5': 9, '10': 'providerReference'},
    const {'1': 'message', '3': 9, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TransferAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferAirtimeResponseDescriptor = $convert.base64Decode('ChdUcmFuc2ZlckFpcnRpbWVSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50Eh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEicKD3JlY2lwaWVudF9waG9uZRgDIAEoCVIOcmVjaXBpZW50UGhvbmUSJQoOcmVjaXBpZW50X25hbWUYBCABKAlSDXJlY2lwaWVudE5hbWUSHwoLYW1vdW50X3NlbnQYBSABKAFSCmFtb3VudFNlbnQSHgoKY29tbWlzc2lvbhgGIAEoAVIKY29tbWlzc2lvbhIjCg10b3RhbF9jaGFyZ2VkGAcgASgBUgx0b3RhbENoYXJnZWQSLQoScHJvdmlkZXJfcmVmZXJlbmNlGAggASgJUhFwcm92aWRlclJlZmVyZW5jZRIYCgdtZXNzYWdlGAkgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use airtimeTransferRateDescriptor instead')
const AirtimeTransferRate$json = const {
  '1': 'AirtimeTransferRate',
  '2': const [
    const {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'commission_rate', '3': 2, '4': 1, '5': 1, '10': 'commissionRate'},
    const {'1': 'flat_fee', '3': 3, '4': 1, '5': 1, '10': 'flatFee'},
    const {'1': 'min_amount', '3': 4, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 5, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'is_available', '3': 6, '4': 1, '5': 8, '10': 'isAvailable'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `AirtimeTransferRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeTransferRateDescriptor = $convert.base64Decode('ChNBaXJ0aW1lVHJhbnNmZXJSYXRlEhgKB25ldHdvcmsYASABKAlSB25ldHdvcmsSJwoPY29tbWlzc2lvbl9yYXRlGAIgASgBUg5jb21taXNzaW9uUmF0ZRIZCghmbGF0X2ZlZRgDIAEoAVIHZmxhdEZlZRIdCgptaW5fYW1vdW50GAQgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgFIAEoAVIJbWF4QW1vdW50EiEKDGlzX2F2YWlsYWJsZRgGIAEoCFILaXNBdmFpbGFibGUSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use getAirtimeTransferRatesRequestDescriptor instead')
const GetAirtimeTransferRatesRequest$json = const {
  '1': 'GetAirtimeTransferRatesRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetAirtimeTransferRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeTransferRatesRequestDescriptor = $convert.base64Decode('Ch5HZXRBaXJ0aW1lVHJhbnNmZXJSYXRlc1JlcXVlc3QSIQoMY291bnRyeV9jb2RlGAEgASgJUgtjb3VudHJ5Q29kZQ==');
@$core.Deprecated('Use getAirtimeTransferRatesResponseDescriptor instead')
const GetAirtimeTransferRatesResponse$json = const {
  '1': 'GetAirtimeTransferRatesResponse',
  '2': const [
    const {'1': 'rates', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeTransferRate', '10': 'rates'},
  ],
};

/// Descriptor for `GetAirtimeTransferRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeTransferRatesResponseDescriptor = $convert.base64Decode('Ch9HZXRBaXJ0aW1lVHJhbnNmZXJSYXRlc1Jlc3BvbnNlEjoKBXJhdGVzGAEgAygLMiQudXRpbGl0eXBheW1lbnRzLkFpcnRpbWVUcmFuc2ZlclJhdGVSBXJhdGVz');
@$core.Deprecated('Use airtimeTransferDescriptor instead')
const AirtimeTransfer$json = const {
  '1': 'AirtimeTransfer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'sender_phone', '3': 4, '4': 1, '5': 9, '10': 'senderPhone'},
    const {'1': 'recipient_phone', '3': 5, '4': 1, '5': 9, '10': 'recipientPhone'},
    const {'1': 'recipient_name', '3': 6, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'network', '3': 7, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'commission', '3': 9, '4': 1, '5': 1, '10': 'commission'},
    const {'1': 'total_charged', '3': 10, '4': 1, '5': 1, '10': 'totalCharged'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'provider_reference', '3': 12, '4': 1, '5': 9, '10': 'providerReference'},
    const {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'transfer_note', '3': 14, '4': 1, '5': 9, '10': 'transferNote'},
    const {'1': 'failure_reason', '3': 15, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'created_at', '3': 16, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'completed_at', '3': 17, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `AirtimeTransfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeTransferDescriptor = $convert.base64Decode('Cg9BaXJ0aW1lVHJhbnNmZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCgphY2NvdW50X2lkGAMgASgJUglhY2NvdW50SWQSIQoMc2VuZGVyX3Bob25lGAQgASgJUgtzZW5kZXJQaG9uZRInCg9yZWNpcGllbnRfcGhvbmUYBSABKAlSDnJlY2lwaWVudFBob25lEiUKDnJlY2lwaWVudF9uYW1lGAYgASgJUg1yZWNpcGllbnROYW1lEhgKB25ldHdvcmsYByABKAlSB25ldHdvcmsSFgoGYW1vdW50GAggASgBUgZhbW91bnQSHgoKY29tbWlzc2lvbhgJIAEoAVIKY29tbWlzc2lvbhIjCg10b3RhbF9jaGFyZ2VkGAogASgBUgx0b3RhbENoYXJnZWQSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSLQoScHJvdmlkZXJfcmVmZXJlbmNlGAwgASgJUhFwcm92aWRlclJlZmVyZW5jZRIcCglyZWZlcmVuY2UYDSABKAlSCXJlZmVyZW5jZRIjCg10cmFuc2Zlcl9ub3RlGA4gASgJUgx0cmFuc2Zlck5vdGUSJQoOZmFpbHVyZV9yZWFzb24YDyABKAlSDWZhaWx1cmVSZWFzb24SHQoKY3JlYXRlZF9hdBgQIAEoCVIJY3JlYXRlZEF0EiEKDGNvbXBsZXRlZF9hdBgRIAEoCVILY29tcGxldGVkQXQ=');
@$core.Deprecated('Use getAirtimeTransferHistoryRequestDescriptor instead')
const GetAirtimeTransferHistoryRequest$json = const {
  '1': 'GetAirtimeTransferHistoryRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAirtimeTransferHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeTransferHistoryRequestDescriptor = $convert.base64Decode('CiBHZXRBaXJ0aW1lVHJhbnNmZXJIaXN0b3J5UmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAIgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getAirtimeTransferHistoryResponseDescriptor instead')
const GetAirtimeTransferHistoryResponse$json = const {
  '1': 'GetAirtimeTransferHistoryResponse',
  '2': const [
    const {'1': 'transfers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeTransfer', '10': 'transfers'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 3, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetAirtimeTransferHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeTransferHistoryResponseDescriptor = $convert.base64Decode('CiFHZXRBaXJ0aW1lVHJhbnNmZXJIaXN0b3J5UmVzcG9uc2USPgoJdHJhbnNmZXJzGAEgAygLMiAudXRpbGl0eXBheW1lbnRzLkFpcnRpbWVUcmFuc2ZlclIJdHJhbnNmZXJzEh8KC3RvdGFsX2NvdW50GAIgASgDUgp0b3RhbENvdW50');
@$core.Deprecated('Use airtimeToCashNetworkRateDescriptor instead')
const AirtimeToCashNetworkRate$json = const {
  '1': 'AirtimeToCashNetworkRate',
  '2': const [
    const {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'conversion_rate', '3': 2, '4': 1, '5': 1, '10': 'conversionRate'},
    const {'1': 'min_amount', '3': 3, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 4, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'automation_fee', '3': 5, '4': 1, '5': 1, '10': 'automationFee'},
    const {'1': 'is_available', '3': 6, '4': 1, '5': 8, '10': 'isAvailable'},
  ],
};

/// Descriptor for `AirtimeToCashNetworkRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeToCashNetworkRateDescriptor = $convert.base64Decode('ChhBaXJ0aW1lVG9DYXNoTmV0d29ya1JhdGUSGAoHbmV0d29yaxgBIAEoCVIHbmV0d29yaxInCg9jb252ZXJzaW9uX3JhdGUYAiABKAFSDmNvbnZlcnNpb25SYXRlEh0KCm1pbl9hbW91bnQYAyABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAQgASgBUgltYXhBbW91bnQSJQoOYXV0b21hdGlvbl9mZWUYBSABKAFSDWF1dG9tYXRpb25GZWUSIQoMaXNfYXZhaWxhYmxlGAYgASgIUgtpc0F2YWlsYWJsZQ==');
@$core.Deprecated('Use getAirtimeToCashRatesRequestDescriptor instead')
const GetAirtimeToCashRatesRequest$json = const {
  '1': 'GetAirtimeToCashRatesRequest',
};

/// Descriptor for `GetAirtimeToCashRatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashRatesRequestDescriptor = $convert.base64Decode('ChxHZXRBaXJ0aW1lVG9DYXNoUmF0ZXNSZXF1ZXN0');
@$core.Deprecated('Use getAirtimeToCashRatesResponseDescriptor instead')
const GetAirtimeToCashRatesResponse$json = const {
  '1': 'GetAirtimeToCashRatesResponse',
  '2': const [
    const {'1': 'rates', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeToCashNetworkRate', '10': 'rates'},
  ],
};

/// Descriptor for `GetAirtimeToCashRatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashRatesResponseDescriptor = $convert.base64Decode('Ch1HZXRBaXJ0aW1lVG9DYXNoUmF0ZXNSZXNwb25zZRI/CgVyYXRlcxgBIAMoCzIpLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lVG9DYXNoTmV0d29ya1JhdGVSBXJhdGVz');
@$core.Deprecated('Use requestAirtimeToCashOTPRequestDescriptor instead')
const RequestAirtimeToCashOTPRequest$json = const {
  '1': 'RequestAirtimeToCashOTPRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `RequestAirtimeToCashOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAirtimeToCashOTPRequestDescriptor = $convert.base64Decode('Ch5SZXF1ZXN0QWlydGltZVRvQ2FzaE9UUFJlcXVlc3QSIQoMcGhvbmVfbnVtYmVyGAEgASgJUgtwaG9uZU51bWJlchIYCgduZXR3b3JrGAIgASgJUgduZXR3b3Jr');
@$core.Deprecated('Use requestAirtimeToCashOTPResponseDescriptor instead')
const RequestAirtimeToCashOTPResponse$json = const {
  '1': 'RequestAirtimeToCashOTPResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'session_id', '3': 3, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'otp_required', '3': 4, '4': 1, '5': 8, '10': 'otpRequired'},
    const {'1': 'destination_phone', '3': 5, '4': 1, '5': 9, '10': 'destinationPhone'},
    const {'1': 'provider_name', '3': 6, '4': 1, '5': 9, '10': 'providerName'},
  ],
};

/// Descriptor for `RequestAirtimeToCashOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAirtimeToCashOTPResponseDescriptor = $convert.base64Decode('Ch9SZXF1ZXN0QWlydGltZVRvQ2FzaE9UUFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIdCgpzZXNzaW9uX2lkGAMgASgJUglzZXNzaW9uSWQSIQoMb3RwX3JlcXVpcmVkGAQgASgIUgtvdHBSZXF1aXJlZBIrChFkZXN0aW5hdGlvbl9waG9uZRgFIAEoCVIQZGVzdGluYXRpb25QaG9uZRIjCg1wcm92aWRlcl9uYW1lGAYgASgJUgxwcm92aWRlck5hbWU=');
@$core.Deprecated('Use verifyAirtimeToCashOTPRequestDescriptor instead')
const VerifyAirtimeToCashOTPRequest$json = const {
  '1': 'VerifyAirtimeToCashOTPRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'otp', '3': 3, '4': 1, '5': 9, '10': 'otp'},
    const {'1': 'session_id', '3': 4, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `VerifyAirtimeToCashOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAirtimeToCashOTPRequestDescriptor = $convert.base64Decode('Ch1WZXJpZnlBaXJ0aW1lVG9DYXNoT1RQUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEhgKB25ldHdvcmsYAiABKAlSB25ldHdvcmsSEAoDb3RwGAMgASgJUgNvdHASHQoKc2Vzc2lvbl9pZBgEIAEoCVIJc2Vzc2lvbklk');
@$core.Deprecated('Use verifyAirtimeToCashOTPResponseDescriptor instead')
const VerifyAirtimeToCashOTPResponse$json = const {
  '1': 'VerifyAirtimeToCashOTPResponse',
  '2': const [
    const {'1': 'verified', '3': 1, '4': 1, '5': 8, '10': 'verified'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'session_token', '3': 3, '4': 1, '5': 9, '10': 'sessionToken'},
    const {'1': 'session_id', '3': 4, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `VerifyAirtimeToCashOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAirtimeToCashOTPResponseDescriptor = $convert.base64Decode('Ch5WZXJpZnlBaXJ0aW1lVG9DYXNoT1RQUmVzcG9uc2USGgoIdmVyaWZpZWQYASABKAhSCHZlcmlmaWVkEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoNc2Vzc2lvbl90b2tlbhgDIAEoCVIMc2Vzc2lvblRva2VuEh0KCnNlc3Npb25faWQYBCABKAlSCXNlc3Npb25JZA==');
@$core.Deprecated('Use convertAirtimeToCashRequestDescriptor instead')
const ConvertAirtimeToCashRequest$json = const {
  '1': 'ConvertAirtimeToCashRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'session_token', '3': 4, '4': 1, '5': 9, '10': 'sessionToken'},
    const {'1': 'session_id', '3': 5, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'pin', '3': 6, '4': 1, '5': 9, '10': 'pin'},
    const {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 8, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ConvertAirtimeToCashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertAirtimeToCashRequestDescriptor = $convert.base64Decode('ChtDb252ZXJ0QWlydGltZVRvQ2FzaFJlcXVlc3QSIQoMcGhvbmVfbnVtYmVyGAEgASgJUgtwaG9uZU51bWJlchIYCgduZXR3b3JrGAIgASgJUgduZXR3b3JrEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EiMKDXNlc3Npb25fdG9rZW4YBCABKAlSDHNlc3Npb25Ub2tlbhIdCgpzZXNzaW9uX2lkGAUgASgJUglzZXNzaW9uSWQSEAoDcGluGAYgASgJUgNwaW4SJQoOdHJhbnNhY3Rpb25faWQYByABKAlSDXRyYW5zYWN0aW9uSWQSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAggASgJUhF2ZXJpZmljYXRpb25Ub2tlbhInCg9pZGVtcG90ZW5jeV9rZXkYCSABKAlSDmlkZW1wb3RlbmN5S2V5');
@$core.Deprecated('Use convertAirtimeToCashResponseDescriptor instead')
const ConvertAirtimeToCashResponse$json = const {
  '1': 'ConvertAirtimeToCashResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'cash_amount', '3': 2, '4': 1, '5': 1, '10': 'cashAmount'},
    const {'1': 'conversion_rate', '3': 3, '4': 1, '5': 1, '10': 'conversionRate'},
    const {'1': 'fee', '3': 4, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'new_balance', '3': 5, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ConvertAirtimeToCashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List convertAirtimeToCashResponseDescriptor = $convert.base64Decode('ChxDb252ZXJ0QWlydGltZVRvQ2FzaFJlc3BvbnNlEjYKB3BheW1lbnQYASABKAsyHC51dGlsaXR5cGF5bWVudHMuQmlsbFBheW1lbnRSB3BheW1lbnQSHwoLY2FzaF9hbW91bnQYAiABKAFSCmNhc2hBbW91bnQSJwoPY29udmVyc2lvbl9yYXRlGAMgASgBUg5jb252ZXJzaW9uUmF0ZRIQCgNmZWUYBCABKAFSA2ZlZRIfCgtuZXdfYmFsYW5jZRgFIAEoAVIKbmV3QmFsYW5jZRIYCgdtZXNzYWdlGAYgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use airtimeToCashConversionDescriptor instead')
const AirtimeToCashConversion$json = const {
  '1': 'AirtimeToCashConversion',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_id', '3': 3, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network', '3': 5, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'airtime_amount', '3': 6, '4': 1, '5': 1, '10': 'airtimeAmount'},
    const {'1': 'cash_amount', '3': 7, '4': 1, '5': 1, '10': 'cashAmount'},
    const {'1': 'conversion_rate', '3': 8, '4': 1, '5': 1, '10': 'conversionRate'},
    const {'1': 'fee', '3': 9, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'provider_name', '3': 11, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'provider_reference', '3': 12, '4': 1, '5': 9, '10': 'providerReference'},
    const {'1': 'reference', '3': 13, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'provider_tx_id', '3': 15, '4': 1, '5': 9, '10': 'providerTxId'},
    const {'1': 'failure_reason', '3': 16, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'completed_at', '3': 17, '4': 1, '5': 9, '10': 'completedAt'},
  ],
};

/// Descriptor for `AirtimeToCashConversion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeToCashConversionDescriptor = $convert.base64Decode('ChdBaXJ0aW1lVG9DYXNoQ29udmVyc2lvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIhCgxwaG9uZV9udW1iZXIYBCABKAlSC3Bob25lTnVtYmVyEhgKB25ldHdvcmsYBSABKAlSB25ldHdvcmsSJQoOYWlydGltZV9hbW91bnQYBiABKAFSDWFpcnRpbWVBbW91bnQSHwoLY2FzaF9hbW91bnQYByABKAFSCmNhc2hBbW91bnQSJwoPY29udmVyc2lvbl9yYXRlGAggASgBUg5jb252ZXJzaW9uUmF0ZRIQCgNmZWUYCSABKAFSA2ZlZRIWCgZzdGF0dXMYCiABKAlSBnN0YXR1cxIjCg1wcm92aWRlcl9uYW1lGAsgASgJUgxwcm92aWRlck5hbWUSLQoScHJvdmlkZXJfcmVmZXJlbmNlGAwgASgJUhFwcm92aWRlclJlZmVyZW5jZRIcCglyZWZlcmVuY2UYDSABKAlSCXJlZmVyZW5jZRIdCgpjcmVhdGVkX2F0GA4gASgJUgljcmVhdGVkQXQSJAoOcHJvdmlkZXJfdHhfaWQYDyABKAlSDHByb3ZpZGVyVHhJZBIlCg5mYWlsdXJlX3JlYXNvbhgQIAEoCVINZmFpbHVyZVJlYXNvbhIhCgxjb21wbGV0ZWRfYXQYESABKAlSC2NvbXBsZXRlZEF0');
@$core.Deprecated('Use getAirtimeToCashHistoryRequestDescriptor instead')
const GetAirtimeToCashHistoryRequest$json = const {
  '1': 'GetAirtimeToCashHistoryRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAirtimeToCashHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashHistoryRequestDescriptor = $convert.base64Decode('Ch5HZXRBaXJ0aW1lVG9DYXNoSGlzdG9yeVJlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm9mZnNldBgCIAEoBVIGb2Zmc2V0');
@$core.Deprecated('Use getAirtimeToCashHistoryResponseDescriptor instead')
const GetAirtimeToCashHistoryResponse$json = const {
  '1': 'GetAirtimeToCashHistoryResponse',
  '2': const [
    const {'1': 'conversions', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeToCashConversion', '10': 'conversions'},
    const {'1': 'total_count', '3': 2, '4': 1, '5': 3, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetAirtimeToCashHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashHistoryResponseDescriptor = $convert.base64Decode('Ch9HZXRBaXJ0aW1lVG9DYXNoSGlzdG9yeVJlc3BvbnNlEkoKC2NvbnZlcnNpb25zGAEgAygLMigudXRpbGl0eXBheW1lbnRzLkFpcnRpbWVUb0Nhc2hDb252ZXJzaW9uUgtjb252ZXJzaW9ucxIfCgt0b3RhbF9jb3VudBgCIAEoA1IKdG90YWxDb3VudA==');
@$core.Deprecated('Use verifyAirtimeToCashServiceRequestDescriptor instead')
const VerifyAirtimeToCashServiceRequest$json = const {
  '1': 'VerifyAirtimeToCashServiceRequest',
  '2': const [
    const {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `VerifyAirtimeToCashServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAirtimeToCashServiceRequestDescriptor = $convert.base64Decode('CiFWZXJpZnlBaXJ0aW1lVG9DYXNoU2VydmljZVJlcXVlc3QSGAoHbmV0d29yaxgBIAEoCVIHbmV0d29yaw==');
@$core.Deprecated('Use verifyAirtimeToCashServiceResponseDescriptor instead')
const VerifyAirtimeToCashServiceResponse$json = const {
  '1': 'VerifyAirtimeToCashServiceResponse',
  '2': const [
    const {'1': 'is_available', '3': 1, '4': 1, '5': 8, '10': 'isAvailable'},
    const {'1': 'provider_name', '3': 2, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'destination_phone', '3': 3, '4': 1, '5': 9, '10': 'destinationPhone'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'network', '3': 5, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'requires_transfer', '3': 6, '4': 1, '5': 8, '10': 'requiresTransfer'},
  ],
};

/// Descriptor for `VerifyAirtimeToCashServiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAirtimeToCashServiceResponseDescriptor = $convert.base64Decode('CiJWZXJpZnlBaXJ0aW1lVG9DYXNoU2VydmljZVJlc3BvbnNlEiEKDGlzX2F2YWlsYWJsZRgBIAEoCFILaXNBdmFpbGFibGUSIwoNcHJvdmlkZXJfbmFtZRgCIAEoCVIMcHJvdmlkZXJOYW1lEisKEWRlc3RpbmF0aW9uX3Bob25lGAMgASgJUhBkZXN0aW5hdGlvblBob25lEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2USGAoHbmV0d29yaxgFIAEoCVIHbmV0d29yaxIrChFyZXF1aXJlc190cmFuc2ZlchgGIAEoCFIQcmVxdWlyZXNUcmFuc2Zlcg==');
@$core.Deprecated('Use getAirtimeToCashProviderInfoRequestDescriptor instead')
const GetAirtimeToCashProviderInfoRequest$json = const {
  '1': 'GetAirtimeToCashProviderInfoRequest',
};

/// Descriptor for `GetAirtimeToCashProviderInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashProviderInfoRequestDescriptor = $convert.base64Decode('CiNHZXRBaXJ0aW1lVG9DYXNoUHJvdmlkZXJJbmZvUmVxdWVzdA==');
@$core.Deprecated('Use getAirtimeToCashProviderInfoResponseDescriptor instead')
const GetAirtimeToCashProviderInfoResponse$json = const {
  '1': 'GetAirtimeToCashProviderInfoResponse',
  '2': const [
    const {'1': 'provider_name', '3': 1, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'requires_otp', '3': 2, '4': 1, '5': 8, '10': 'requiresOtp'},
    const {'1': 'requires_transfer', '3': 3, '4': 1, '5': 8, '10': 'requiresTransfer'},
    const {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'providers', '3': 5, '4': 3, '5': 11, '6': '.utilitypayments.ProviderStatus', '10': 'providers'},
  ],
};

/// Descriptor for `GetAirtimeToCashProviderInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeToCashProviderInfoResponseDescriptor = $convert.base64Decode('CiRHZXRBaXJ0aW1lVG9DYXNoUHJvdmlkZXJJbmZvUmVzcG9uc2USIwoNcHJvdmlkZXJfbmFtZRgBIAEoCVIMcHJvdmlkZXJOYW1lEiEKDHJlcXVpcmVzX290cBgCIAEoCFILcmVxdWlyZXNPdHASKwoRcmVxdWlyZXNfdHJhbnNmZXIYAyABKAhSEHJlcXVpcmVzVHJhbnNmZXISIQoMZGlzcGxheV9uYW1lGAQgASgJUgtkaXNwbGF5TmFtZRI9Cglwcm92aWRlcnMYBSADKAsyHy51dGlsaXR5cGF5bWVudHMuUHJvdmlkZXJTdGF0dXNSCXByb3ZpZGVycw==');
@$core.Deprecated('Use providerStatusDescriptor instead')
const ProviderStatus$json = const {
  '1': 'ProviderStatus',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'is_active', '3': 3, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'is_healthy', '3': 4, '4': 1, '5': 8, '10': 'isHealthy'},
    const {'1': 'network_count', '3': 5, '4': 1, '5': 5, '10': 'networkCount'},
    const {'1': 'error_message', '3': 6, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `ProviderStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerStatusDescriptor = $convert.base64Decode('Cg5Qcm92aWRlclN0YXR1cxISCgRuYW1lGAEgASgJUgRuYW1lEiEKDGRpc3BsYXlfbmFtZRgCIAEoCVILZGlzcGxheU5hbWUSGwoJaXNfYWN0aXZlGAMgASgIUghpc0FjdGl2ZRIdCgppc19oZWFsdGh5GAQgASgIUglpc0hlYWx0aHkSIwoNbmV0d29ya19jb3VudBgFIAEoBVIMbmV0d29ya0NvdW50EiMKDWVycm9yX21lc3NhZ2UYBiABKAlSDGVycm9yTWVzc2FnZQ==');
@$core.Deprecated('Use checkAirtimeToCashQuotaRequestDescriptor instead')
const CheckAirtimeToCashQuotaRequest$json = const {
  '1': 'CheckAirtimeToCashQuotaRequest',
  '2': const [
    const {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
  ],
};

/// Descriptor for `CheckAirtimeToCashQuotaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkAirtimeToCashQuotaRequestDescriptor = $convert.base64Decode('Ch5DaGVja0FpcnRpbWVUb0Nhc2hRdW90YVJlcXVlc3QSGAoHbmV0d29yaxgBIAEoCVIHbmV0d29yaxIWCgZhbW91bnQYAiABKAFSBmFtb3VudA==');
@$core.Deprecated('Use checkAirtimeToCashQuotaResponseDescriptor instead')
const CheckAirtimeToCashQuotaResponse$json = const {
  '1': 'CheckAirtimeToCashQuotaResponse',
  '2': const [
    const {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    const {'1': 'max_amount', '3': 2, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CheckAirtimeToCashQuotaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkAirtimeToCashQuotaResponseDescriptor = $convert.base64Decode('Ch9DaGVja0FpcnRpbWVUb0Nhc2hRdW90YVJlc3BvbnNlEhwKCWF2YWlsYWJsZRgBIAEoCFIJYXZhaWxhYmxlEh0KCm1heF9hbW91bnQYAiABKAFSCW1heEFtb3VudBIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdl');
