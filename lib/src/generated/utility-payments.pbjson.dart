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
    const {'1': 'refund_source', '3': 14, '4': 1, '5': 9, '10': 'refundSource'},
  ],
};

/// Descriptor for `BillPayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billPaymentDescriptor = $convert.base64Decode('CgtCaWxsUGF5bWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh0KCmFjY291bnRfaWQYAyABKAlSCWFjY291bnRJZBIbCgliaWxsX3R5cGUYBCABKAlSCGJpbGxUeXBlEh8KC3Byb3ZpZGVyX2lkGAUgASgJUgpwcm92aWRlcklkEhwKCXJlZmVyZW5jZRgGIAEoCVIJcmVmZXJlbmNlEicKD2lkZW1wb3RlbmN5X2tleRgHIAEoCVIOaWRlbXBvdGVuY3lLZXkSFgoGYW1vdW50GAggASgBUgZhbW91bnQSFgoGc3RhdHVzGAkgASgJUgZzdGF0dXMSJwoPY3VzdG9tZXJfbnVtYmVyGAogASgJUg5jdXN0b21lck51bWJlchIUCgV0b2tlbhgLIAEoCVIFdG9rZW4SGgoIbWV0YWRhdGEYDCABKAlSCG1ldGFkYXRhEh0KCmNyZWF0ZWRfYXQYDSABKAlSCWNyZWF0ZWRBdBIjCg1yZWZ1bmRfc291cmNlGA4gASgJUgxyZWZ1bmRTb3VyY2U=');
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
    const {'1': 'bill_type_in', '3': 8, '4': 3, '5': 9, '10': 'billTypeIn'},
  ],
};

/// Descriptor for `GetBillPaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillPaymentHistoryRequestDescriptor = $convert.base64Decode('ChxHZXRCaWxsUGF5bWVudEhpc3RvcnlSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIbCgliaWxsX3R5cGUYAiABKAlSCGJpbGxUeXBlEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEh0KCnN0YXJ0X2RhdGUYBCABKAlSCXN0YXJ0RGF0ZRIZCghlbmRfZGF0ZRgFIAEoCVIHZW5kRGF0ZRIUCgVsaW1pdBgGIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAcgASgFUgZvZmZzZXQSIAoMYmlsbF90eXBlX2luGAggAygJUgpiaWxsVHlwZUlu');
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
    const {'1': 'service_fee', '3': 6, '4': 1, '5': 1, '10': 'serviceFee'},
  ],
};

/// Descriptor for `DataPlan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataPlanDescriptor = $convert.base64Decode('CghEYXRhUGxhbhIhCgx2YXJpYXRpb25faWQYASABKAlSC3ZhcmlhdGlvbklkEhIKBG5hbWUYAiABKAlSBG5hbWUSFAoFcHJpY2UYAyABKAFSBXByaWNlEhgKB25ldHdvcmsYBCABKAlSB25ldHdvcmsSIgoMYXZhaWxhYmlsaXR5GAUgASgJUgxhdmFpbGFiaWxpdHkSHwoLc2VydmljZV9mZWUYBiABKAFSCnNlcnZpY2VGZWU=');
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
    const {'1': 'current_rate', '3': 4, '4': 1, '5': 1, '10': 'currentRate'},
    const {'1': 'fee', '3': 5, '4': 1, '5': 1, '10': 'fee'},
  ],
};

/// Descriptor for `CheckAirtimeToCashQuotaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkAirtimeToCashQuotaResponseDescriptor = $convert.base64Decode('Ch9DaGVja0FpcnRpbWVUb0Nhc2hRdW90YVJlc3BvbnNlEhwKCWF2YWlsYWJsZRgBIAEoCFIJYXZhaWxhYmxlEh0KCm1heF9hbW91bnQYAiABKAFSCW1heEFtb3VudBIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEiEKDGN1cnJlbnRfcmF0ZRgEIAEoAVILY3VycmVudFJhdGUSEAoDZmVlGAUgASgBUgNmZWU=');
@$core.Deprecated('Use waterProviderDescriptor instead')
const WaterProvider$json = const {
  '1': 'WaterProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'service_id', '3': 3, '4': 1, '5': 9, '10': 'serviceId'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'commission_rate', '3': 6, '4': 1, '5': 1, '10': 'commissionRate'},
  ],
};

/// Descriptor for `WaterProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waterProviderDescriptor = $convert.base64Decode('Cg1XYXRlclByb3ZpZGVyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh0KCnNlcnZpY2VfaWQYAyABKAlSCXNlcnZpY2VJZBIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUYBSABKAhSCGlzQWN0aXZlEicKD2NvbW1pc3Npb25fcmF0ZRgGIAEoAVIOY29tbWlzc2lvblJhdGU=');
@$core.Deprecated('Use getWaterProvidersRequestDescriptor instead')
const GetWaterProvidersRequest$json = const {
  '1': 'GetWaterProvidersRequest',
  '2': const [
    const {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
  ],
};

/// Descriptor for `GetWaterProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterProvidersRequestDescriptor = $convert.base64Decode('ChhHZXRXYXRlclByb3ZpZGVyc1JlcXVlc3QSHwoLYWN0aXZlX29ubHkYASABKAhSCmFjdGl2ZU9ubHk=');
@$core.Deprecated('Use getWaterProvidersResponseDescriptor instead')
const GetWaterProvidersResponse$json = const {
  '1': 'GetWaterProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.WaterProvider', '10': 'providers'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetWaterProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterProvidersResponseDescriptor = $convert.base64Decode('ChlHZXRXYXRlclByb3ZpZGVyc1Jlc3BvbnNlEjwKCXByb3ZpZGVycxgBIAMoCzIeLnV0aWxpdHlwYXltZW50cy5XYXRlclByb3ZpZGVyUglwcm92aWRlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use asyncPaymentConfigDescriptor instead')
const AsyncPaymentConfig$json = const {
  '1': 'AsyncPaymentConfig',
  '2': const [
    const {'1': 'electricity_enabled', '3': 1, '4': 1, '5': 8, '10': 'electricityEnabled'},
    const {'1': 'airtime_enabled', '3': 2, '4': 1, '5': 8, '10': 'airtimeEnabled'},
    const {'1': 'data_enabled', '3': 3, '4': 1, '5': 8, '10': 'dataEnabled'},
    const {'1': 'cable_tv_enabled', '3': 4, '4': 1, '5': 8, '10': 'cableTvEnabled'},
    const {'1': 'internet_enabled', '3': 5, '4': 1, '5': 8, '10': 'internetEnabled'},
    const {'1': 'water_enabled', '3': 6, '4': 1, '5': 8, '10': 'waterEnabled'},
    const {'1': 'education_enabled', '3': 7, '4': 1, '5': 8, '10': 'educationEnabled'},
    const {'1': 'vtpass_async_enabled', '3': 8, '4': 1, '5': 8, '10': 'vtpassAsyncEnabled'},
    const {'1': 'reloadly_async_enabled', '3': 9, '4': 1, '5': 8, '10': 'reloadlyAsyncEnabled'},
    const {'1': 'provider_timeout_seconds', '3': 10, '4': 1, '5': 5, '10': 'providerTimeoutSeconds'},
    const {'1': 'send_push_notification', '3': 11, '4': 1, '5': 8, '10': 'sendPushNotification'},
    const {'1': 'send_sms_notification', '3': 12, '4': 1, '5': 8, '10': 'sendSmsNotification'},
    const {'1': 'notification_message', '3': 13, '4': 1, '5': 9, '10': 'notificationMessage'},
    const {'1': 'async_pending_message', '3': 14, '4': 1, '5': 9, '10': 'asyncPendingMessage'},
    const {'1': 'async_completed_message', '3': 15, '4': 1, '5': 9, '10': 'asyncCompletedMessage'},
    const {'1': 'async_failed_message', '3': 16, '4': 1, '5': 9, '10': 'asyncFailedMessage'},
  ],
};

/// Descriptor for `AsyncPaymentConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List asyncPaymentConfigDescriptor = $convert.base64Decode('ChJBc3luY1BheW1lbnRDb25maWcSLwoTZWxlY3RyaWNpdHlfZW5hYmxlZBgBIAEoCFISZWxlY3RyaWNpdHlFbmFibGVkEicKD2FpcnRpbWVfZW5hYmxlZBgCIAEoCFIOYWlydGltZUVuYWJsZWQSIQoMZGF0YV9lbmFibGVkGAMgASgIUgtkYXRhRW5hYmxlZBIoChBjYWJsZV90dl9lbmFibGVkGAQgASgIUg5jYWJsZVR2RW5hYmxlZBIpChBpbnRlcm5ldF9lbmFibGVkGAUgASgIUg9pbnRlcm5ldEVuYWJsZWQSIwoNd2F0ZXJfZW5hYmxlZBgGIAEoCFIMd2F0ZXJFbmFibGVkEisKEWVkdWNhdGlvbl9lbmFibGVkGAcgASgIUhBlZHVjYXRpb25FbmFibGVkEjAKFHZ0cGFzc19hc3luY19lbmFibGVkGAggASgIUhJ2dHBhc3NBc3luY0VuYWJsZWQSNAoWcmVsb2FkbHlfYXN5bmNfZW5hYmxlZBgJIAEoCFIUcmVsb2FkbHlBc3luY0VuYWJsZWQSOAoYcHJvdmlkZXJfdGltZW91dF9zZWNvbmRzGAogASgFUhZwcm92aWRlclRpbWVvdXRTZWNvbmRzEjQKFnNlbmRfcHVzaF9ub3RpZmljYXRpb24YCyABKAhSFHNlbmRQdXNoTm90aWZpY2F0aW9uEjIKFXNlbmRfc21zX25vdGlmaWNhdGlvbhgMIAEoCFITc2VuZFNtc05vdGlmaWNhdGlvbhIxChRub3RpZmljYXRpb25fbWVzc2FnZRgNIAEoCVITbm90aWZpY2F0aW9uTWVzc2FnZRIyChVhc3luY19wZW5kaW5nX21lc3NhZ2UYDiABKAlSE2FzeW5jUGVuZGluZ01lc3NhZ2USNgoXYXN5bmNfY29tcGxldGVkX21lc3NhZ2UYDyABKAlSFWFzeW5jQ29tcGxldGVkTWVzc2FnZRIwChRhc3luY19mYWlsZWRfbWVzc2FnZRgQIAEoCVISYXN5bmNGYWlsZWRNZXNzYWdl');
@$core.Deprecated('Use getAsyncPaymentConfigRequestDescriptor instead')
const GetAsyncPaymentConfigRequest$json = const {
  '1': 'GetAsyncPaymentConfigRequest',
};

/// Descriptor for `GetAsyncPaymentConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAsyncPaymentConfigRequestDescriptor = $convert.base64Decode('ChxHZXRBc3luY1BheW1lbnRDb25maWdSZXF1ZXN0');
@$core.Deprecated('Use getAsyncPaymentConfigResponseDescriptor instead')
const GetAsyncPaymentConfigResponse$json = const {
  '1': 'GetAsyncPaymentConfigResponse',
  '2': const [
    const {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.AsyncPaymentConfig', '10': 'config'},
  ],
};

/// Descriptor for `GetAsyncPaymentConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAsyncPaymentConfigResponseDescriptor = $convert.base64Decode('Ch1HZXRBc3luY1BheW1lbnRDb25maWdSZXNwb25zZRI7CgZjb25maWcYASABKAsyIy51dGlsaXR5cGF5bWVudHMuQXN5bmNQYXltZW50Q29uZmlnUgZjb25maWc=');
@$core.Deprecated('Use updateAsyncPaymentConfigRequestDescriptor instead')
const UpdateAsyncPaymentConfigRequest$json = const {
  '1': 'UpdateAsyncPaymentConfigRequest',
  '2': const [
    const {'1': 'electricity_enabled', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'electricityEnabled'},
    const {'1': 'airtime_enabled', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'airtimeEnabled'},
    const {'1': 'data_enabled', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'dataEnabled'},
    const {'1': 'cable_tv_enabled', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'cableTvEnabled'},
    const {'1': 'internet_enabled', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'internetEnabled'},
    const {'1': 'water_enabled', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'waterEnabled'},
    const {'1': 'education_enabled', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'educationEnabled'},
    const {'1': 'vtpass_async_enabled', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'vtpassAsyncEnabled'},
    const {'1': 'reloadly_async_enabled', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'reloadlyAsyncEnabled'},
    const {'1': 'provider_timeout_seconds', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Int32Value', '10': 'providerTimeoutSeconds'},
    const {'1': 'send_push_notification', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'sendPushNotification'},
    const {'1': 'send_sms_notification', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.BoolValue', '10': 'sendSmsNotification'},
    const {'1': 'notification_message', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '10': 'notificationMessage'},
    const {'1': 'async_pending_message', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '10': 'asyncPendingMessage'},
    const {'1': 'async_completed_message', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '10': 'asyncCompletedMessage'},
    const {'1': 'async_failed_message', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.StringValue', '10': 'asyncFailedMessage'},
  ],
};

/// Descriptor for `UpdateAsyncPaymentConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAsyncPaymentConfigRequestDescriptor = $convert.base64Decode('Ch9VcGRhdGVBc3luY1BheW1lbnRDb25maWdSZXF1ZXN0EksKE2VsZWN0cmljaXR5X2VuYWJsZWQYASABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUhJlbGVjdHJpY2l0eUVuYWJsZWQSQwoPYWlydGltZV9lbmFibGVkGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZVIOYWlydGltZUVuYWJsZWQSPQoMZGF0YV9lbmFibGVkGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZVILZGF0YUVuYWJsZWQSRAoQY2FibGVfdHZfZW5hYmxlZBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVmFsdWVSDmNhYmxlVHZFbmFibGVkEkUKEGludGVybmV0X2VuYWJsZWQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUg9pbnRlcm5ldEVuYWJsZWQSPwoNd2F0ZXJfZW5hYmxlZBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVmFsdWVSDHdhdGVyRW5hYmxlZBJHChFlZHVjYXRpb25fZW5hYmxlZBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVmFsdWVSEGVkdWNhdGlvbkVuYWJsZWQSTAoUdnRwYXNzX2FzeW5jX2VuYWJsZWQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUhJ2dHBhc3NBc3luY0VuYWJsZWQSUAoWcmVsb2FkbHlfYXN5bmNfZW5hYmxlZBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVmFsdWVSFHJlbG9hZGx5QXN5bmNFbmFibGVkElUKGHByb3ZpZGVyX3RpbWVvdXRfc2Vjb25kcxgKIAEoCzIbLmdvb2dsZS5wcm90b2J1Zi5JbnQzMlZhbHVlUhZwcm92aWRlclRpbWVvdXRTZWNvbmRzElAKFnNlbmRfcHVzaF9ub3RpZmljYXRpb24YCyABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUhRzZW5kUHVzaE5vdGlmaWNhdGlvbhJOChVzZW5kX3Ntc19ub3RpZmljYXRpb24YDCABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUhNzZW5kU21zTm90aWZpY2F0aW9uEk8KFG5vdGlmaWNhdGlvbl9tZXNzYWdlGA0gASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUhNub3RpZmljYXRpb25NZXNzYWdlElAKFWFzeW5jX3BlbmRpbmdfbWVzc2FnZRgOIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVITYXN5bmNQZW5kaW5nTWVzc2FnZRJUChdhc3luY19jb21wbGV0ZWRfbWVzc2FnZRgPIAEoCzIcLmdvb2dsZS5wcm90b2J1Zi5TdHJpbmdWYWx1ZVIVYXN5bmNDb21wbGV0ZWRNZXNzYWdlEk4KFGFzeW5jX2ZhaWxlZF9tZXNzYWdlGBAgASgLMhwuZ29vZ2xlLnByb3RvYnVmLlN0cmluZ1ZhbHVlUhJhc3luY0ZhaWxlZE1lc3NhZ2U=');
@$core.Deprecated('Use updateAsyncPaymentConfigResponseDescriptor instead')
const UpdateAsyncPaymentConfigResponse$json = const {
  '1': 'UpdateAsyncPaymentConfigResponse',
  '2': const [
    const {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.AsyncPaymentConfig', '10': 'config'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAsyncPaymentConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAsyncPaymentConfigResponseDescriptor = $convert.base64Decode('CiBVcGRhdGVBc3luY1BheW1lbnRDb25maWdSZXNwb25zZRI7CgZjb25maWcYASABKAsyIy51dGlsaXR5cGF5bWVudHMuQXN5bmNQYXltZW50Q29uZmlnUgZjb25maWcSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use airtimeBeneficiaryDescriptor instead')
const AirtimeBeneficiary$json = const {
  '1': 'AirtimeBeneficiary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network_code', '3': 4, '4': 1, '5': 9, '10': 'networkCode'},
    const {'1': 'network_name', '3': 5, '4': 1, '5': 9, '10': 'networkName'},
    const {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'country_code', '3': 7, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'operator_id', '3': 8, '4': 1, '5': 9, '10': 'operatorId'},
    const {'1': 'last_amount', '3': 9, '4': 1, '5': 1, '10': 'lastAmount'},
    const {'1': 'last_topup_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTopupAt'},
    const {'1': 'topup_count', '3': 11, '4': 1, '5': 5, '10': 'topupCount'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `AirtimeBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeBeneficiaryDescriptor = $convert.base64Decode('ChJBaXJ0aW1lQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIhCgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEiEKDG5ldHdvcmtfY29kZRgEIAEoCVILbmV0d29ya0NvZGUSIQoMbmV0d29ya19uYW1lGAUgASgJUgtuZXR3b3JrTmFtZRIaCghuaWNrbmFtZRgGIAEoCVIIbmlja25hbWUSIQoMY291bnRyeV9jb2RlGAcgASgJUgtjb3VudHJ5Q29kZRIfCgtvcGVyYXRvcl9pZBgIIAEoCVIKb3BlcmF0b3JJZBIfCgtsYXN0X2Ftb3VudBgJIAEoAVIKbGFzdEFtb3VudBI+Cg1sYXN0X3RvcHVwX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFRvcHVwQXQSHwoLdG9wdXBfY291bnQYCyABKAVSCnRvcHVwQ291bnQSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use saveAirtimeBeneficiaryRequestDescriptor instead')
const SaveAirtimeBeneficiaryRequest$json = const {
  '1': 'SaveAirtimeBeneficiaryRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network_code', '3': 2, '4': 1, '5': 9, '10': 'networkCode'},
    const {'1': 'network_name', '3': 3, '4': 1, '5': 9, '10': 'networkName'},
    const {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'country_code', '3': 5, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'operator_id', '3': 6, '4': 1, '5': 9, '10': 'operatorId'},
  ],
};

/// Descriptor for `SaveAirtimeBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveAirtimeBeneficiaryRequestDescriptor = $convert.base64Decode('Ch1TYXZlQWlydGltZUJlbmVmaWNpYXJ5UmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEiEKDG5ldHdvcmtfY29kZRgCIAEoCVILbmV0d29ya0NvZGUSIQoMbmV0d29ya19uYW1lGAMgASgJUgtuZXR3b3JrTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWUSIQoMY291bnRyeV9jb2RlGAUgASgJUgtjb3VudHJ5Q29kZRIfCgtvcGVyYXRvcl9pZBgGIAEoCVIKb3BlcmF0b3JJZA==');
@$core.Deprecated('Use saveAirtimeBeneficiaryResponseDescriptor instead')
const SaveAirtimeBeneficiaryResponse$json = const {
  '1': 'SaveAirtimeBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.AirtimeBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveAirtimeBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveAirtimeBeneficiaryResponseDescriptor = $convert.base64Decode('Ch5TYXZlQWlydGltZUJlbmVmaWNpYXJ5UmVzcG9uc2USRQoLYmVuZWZpY2lhcnkYASABKAsyIy51dGlsaXR5cGF5bWVudHMuQWlydGltZUJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getAirtimeBeneficiariesRequestDescriptor instead')
const GetAirtimeBeneficiariesRequest$json = const {
  '1': 'GetAirtimeBeneficiariesRequest',
  '2': const [
    const {'1': 'network_code', '3': 1, '4': 1, '5': 9, '10': 'networkCode'},
  ],
};

/// Descriptor for `GetAirtimeBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeBeneficiariesRequestDescriptor = $convert.base64Decode('Ch5HZXRBaXJ0aW1lQmVuZWZpY2lhcmllc1JlcXVlc3QSIQoMbmV0d29ya19jb2RlGAEgASgJUgtuZXR3b3JrQ29kZQ==');
@$core.Deprecated('Use getAirtimeBeneficiariesResponseDescriptor instead')
const GetAirtimeBeneficiariesResponse$json = const {
  '1': 'GetAirtimeBeneficiariesResponse',
  '2': const [
    const {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeBeneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `GetAirtimeBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeBeneficiariesResponseDescriptor = $convert.base64Decode('Ch9HZXRBaXJ0aW1lQmVuZWZpY2lhcmllc1Jlc3BvbnNlEkkKDWJlbmVmaWNpYXJpZXMYASADKAsyIy51dGlsaXR5cGF5bWVudHMuQWlydGltZUJlbmVmaWNpYXJ5Ug1iZW5lZmljaWFyaWVz');
@$core.Deprecated('Use updateAirtimeBeneficiaryRequestDescriptor instead')
const UpdateAirtimeBeneficiaryRequest$json = const {
  '1': 'UpdateAirtimeBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateAirtimeBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeBeneficiaryRequestDescriptor = $convert.base64Decode('Ch9VcGRhdGVBaXJ0aW1lQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIaCghuaWNrbmFtZRgCIAEoCVIIbmlja25hbWU=');
@$core.Deprecated('Use updateAirtimeBeneficiaryResponseDescriptor instead')
const UpdateAirtimeBeneficiaryResponse$json = const {
  '1': 'UpdateAirtimeBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.AirtimeBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAirtimeBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeBeneficiaryResponseDescriptor = $convert.base64Decode('CiBVcGRhdGVBaXJ0aW1lQmVuZWZpY2lhcnlSZXNwb25zZRJFCgtiZW5lZmljaWFyeRgBIAEoCzIjLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteAirtimeBeneficiaryRequestDescriptor instead')
const DeleteAirtimeBeneficiaryRequest$json = const {
  '1': 'DeleteAirtimeBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteAirtimeBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeBeneficiaryRequestDescriptor = $convert.base64Decode('Ch9EZWxldGVBaXJ0aW1lQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use deleteAirtimeBeneficiaryResponseDescriptor instead')
const DeleteAirtimeBeneficiaryResponse$json = const {
  '1': 'DeleteAirtimeBeneficiaryResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAirtimeBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeBeneficiaryResponseDescriptor = $convert.base64Decode('CiBEZWxldGVBaXJ0aW1lQmVuZWZpY2lhcnlSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use airtimeAutoRechargeDescriptor instead')
const AirtimeAutoRecharge$json = const {
  '1': 'AirtimeAutoRecharge',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network_code', '3': 5, '4': 1, '5': 9, '10': 'networkCode'},
    const {'1': 'network_name', '3': 6, '4': 1, '5': 9, '10': 'networkName'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 9, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 10, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 11, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'next_run_date', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRunDate'},
    const {'1': 'last_run_date', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastRunDate'},
    const {'1': 'status', '3': 14, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'failure_count', '3': 15, '4': 1, '5': 5, '10': 'failureCount'},
    const {'1': 'max_retries', '3': 16, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'created_at', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'beneficiary', '3': 18, '4': 1, '5': 11, '6': '.utilitypayments.AirtimeBeneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `AirtimeAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeAutoRechargeDescriptor = $convert.base64Decode('ChNBaXJ0aW1lQXV0b1JlY2hhcmdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSIQoMcGhvbmVfbnVtYmVyGAQgASgJUgtwaG9uZU51bWJlchIhCgxuZXR3b3JrX2NvZGUYBSABKAlSC25ldHdvcmtDb2RlEiEKDG5ldHdvcmtfbmFtZRgGIAEoCVILbmV0d29ya05hbWUSFgoGYW1vdW50GAcgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgJIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAogASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAsgASgFUgpkYXlPZk1vbnRoEj4KDW5leHRfcnVuX2RhdGUYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtuZXh0UnVuRGF0ZRI+Cg1sYXN0X3J1bl9kYXRlGA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFJ1bkRhdGUSFgoGc3RhdHVzGA4gASgJUgZzdGF0dXMSIwoNZmFpbHVyZV9jb3VudBgPIAEoBVIMZmFpbHVyZUNvdW50Eh8KC21heF9yZXRyaWVzGBAgASgFUgptYXhSZXRyaWVzEjkKCmNyZWF0ZWRfYXQYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSRQoLYmVuZWZpY2lhcnkYEiABKAsyIy51dGlsaXR5cGF5bWVudHMuQWlydGltZUJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');
@$core.Deprecated('Use createAirtimeAutoRechargeRequestDescriptor instead')
const CreateAirtimeAutoRechargeRequest$json = const {
  '1': 'CreateAirtimeAutoRechargeRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 5, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 6, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 7, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 8, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 9, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAirtimeAutoRechargeRequestDescriptor = $convert.base64Decode('CiBDcmVhdGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIAEoCVINYmVuZWZpY2lhcnlJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSHAoJZnJlcXVlbmN5GAQgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYBSABKAVSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYBiABKAVSCmRheU9mTW9udGgSHwoLbWF4X3JldHJpZXMYByABKAVSCm1heFJldHJpZXMSJQoOZXhlY3V0aW9uX2hvdXIYCCABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW9uX21pbnV0ZRgJIAEoBVIPZXhlY3V0aW9uTWludXRl');
@$core.Deprecated('Use createAirtimeAutoRechargeResponseDescriptor instead')
const CreateAirtimeAutoRechargeResponse$json = const {
  '1': 'CreateAirtimeAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.AirtimeAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAirtimeAutoRechargeResponseDescriptor = $convert.base64Decode('CiFDcmVhdGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVzcG9uc2USSQoNYXV0b19yZWNoYXJnZRgBIAEoCzIkLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getAirtimeAutoRechargesRequestDescriptor instead')
const GetAirtimeAutoRechargesRequest$json = const {
  '1': 'GetAirtimeAutoRechargesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetAirtimeAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeAutoRechargesRequestDescriptor = $convert.base64Decode('Ch5HZXRBaXJ0aW1lQXV0b1JlY2hhcmdlc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use getAirtimeAutoRechargesResponseDescriptor instead')
const GetAirtimeAutoRechargesResponse$json = const {
  '1': 'GetAirtimeAutoRechargesResponse',
  '2': const [
    const {'1': 'auto_recharges', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeAutoRecharge', '10': 'autoRecharges'},
  ],
};

/// Descriptor for `GetAirtimeAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeAutoRechargesResponseDescriptor = $convert.base64Decode('Ch9HZXRBaXJ0aW1lQXV0b1JlY2hhcmdlc1Jlc3BvbnNlEksKDmF1dG9fcmVjaGFyZ2VzGAEgAygLMiQudXRpbGl0eXBheW1lbnRzLkFpcnRpbWVBdXRvUmVjaGFyZ2VSDWF1dG9SZWNoYXJnZXM=');
@$core.Deprecated('Use updateAirtimeAutoRechargeRequestDescriptor instead')
const UpdateAirtimeAutoRechargeRequest$json = const {
  '1': 'UpdateAirtimeAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 4, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 5, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 6, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 7, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 8, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeAutoRechargeRequestDescriptor = $convert.base64Decode('CiBVcGRhdGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIcCglmcmVxdWVuY3kYAyABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zfd2VlaxgEIAEoBVIJZGF5T2ZXZWVrEiAKDGRheV9vZl9tb250aBgFIAEoBVIKZGF5T2ZNb250aBIfCgttYXhfcmV0cmllcxgGIAEoBVIKbWF4UmV0cmllcxIlCg5leGVjdXRpb25faG91chgHIAEoBVINZXhlY3V0aW9uSG91chIpChBleGVjdXRpb25fbWludXRlGAggASgFUg9leGVjdXRpb25NaW51dGU=');
@$core.Deprecated('Use updateAirtimeAutoRechargeResponseDescriptor instead')
const UpdateAirtimeAutoRechargeResponse$json = const {
  '1': 'UpdateAirtimeAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.AirtimeAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeAutoRechargeResponseDescriptor = $convert.base64Decode('CiFVcGRhdGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVzcG9uc2USSQoNYXV0b19yZWNoYXJnZRgBIAEoCzIkLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteAirtimeAutoRechargeRequestDescriptor instead')
const DeleteAirtimeAutoRechargeRequest$json = const {
  '1': 'DeleteAirtimeAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeAutoRechargeRequestDescriptor = $convert.base64Decode('CiBEZWxldGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZA==');
@$core.Deprecated('Use deleteAirtimeAutoRechargeResponseDescriptor instead')
const DeleteAirtimeAutoRechargeResponse$json = const {
  '1': 'DeleteAirtimeAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeAutoRechargeResponseDescriptor = $convert.base64Decode('CiFEZWxldGVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use pauseAirtimeAutoRechargeRequestDescriptor instead')
const PauseAirtimeAutoRechargeRequest$json = const {
  '1': 'PauseAirtimeAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseAirtimeAutoRechargeRequestDescriptor = $convert.base64Decode('Ch9QYXVzZUFpcnRpbWVBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDmF1dG9SZWNoYXJnZUlk');
@$core.Deprecated('Use pauseAirtimeAutoRechargeResponseDescriptor instead')
const PauseAirtimeAutoRechargeResponse$json = const {
  '1': 'PauseAirtimeAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseAirtimeAutoRechargeResponseDescriptor = $convert.base64Decode('CiBQYXVzZUFpcnRpbWVBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use resumeAirtimeAutoRechargeRequestDescriptor instead')
const ResumeAirtimeAutoRechargeRequest$json = const {
  '1': 'ResumeAirtimeAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeAirtimeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeAirtimeAutoRechargeRequestDescriptor = $convert.base64Decode('CiBSZXN1bWVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZA==');
@$core.Deprecated('Use resumeAirtimeAutoRechargeResponseDescriptor instead')
const ResumeAirtimeAutoRechargeResponse$json = const {
  '1': 'ResumeAirtimeAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeAirtimeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeAirtimeAutoRechargeResponseDescriptor = $convert.base64Decode('CiFSZXN1bWVBaXJ0aW1lQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use airtimeReminderDescriptor instead')
const AirtimeReminder$json = const {
  '1': 'AirtimeReminder',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 9, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 10, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'notified_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'notifiedAt'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `AirtimeReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airtimeReminderDescriptor = $convert.base64Decode('Cg9BaXJ0aW1lUmVtaW5kZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIlCg5iZW5lZmljaWFyeV9pZBgDIAEoCVINYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgEIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAcgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5EiEKDGlzX3JlY3VycmluZxgJIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAogASgJUg5yZWN1cnJlbmNlVHlwZRIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxI7Cgtub3RpZmllZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCm5vdGlmaWVkQXQSOQoKY3JlYXRlZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use createAirtimeReminderRequestDescriptor instead')
const CreateAirtimeReminderRequest$json = const {
  '1': 'CreateAirtimeReminderRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'is_recurring', '3': 6, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 7, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateAirtimeReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAirtimeReminderRequestDescriptor = $convert.base64Decode('ChxDcmVhdGVBaXJ0aW1lUmVtaW5kZXJSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgASgJUg1iZW5lZmljaWFyeUlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIhCgxpc19yZWN1cnJpbmcYBiABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgHIAEoCVIOcmVjdXJyZW5jZVR5cGUSGgoIY3VycmVuY3kYCCABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use createAirtimeReminderResponseDescriptor instead')
const CreateAirtimeReminderResponse$json = const {
  '1': 'CreateAirtimeReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.AirtimeReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAirtimeReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAirtimeReminderResponseDescriptor = $convert.base64Decode('Ch1DcmVhdGVBaXJ0aW1lUmVtaW5kZXJSZXNwb25zZRI8CghyZW1pbmRlchgBIAEoCzIgLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getAirtimeRemindersRequestDescriptor instead')
const GetAirtimeRemindersRequest$json = const {
  '1': 'GetAirtimeRemindersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetAirtimeRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeRemindersRequestDescriptor = $convert.base64Decode('ChpHZXRBaXJ0aW1lUmVtaW5kZXJzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIhCgxpbmNsdWRlX3Bhc3QYAiABKAhSC2luY2x1ZGVQYXN0');
@$core.Deprecated('Use getAirtimeRemindersResponseDescriptor instead')
const GetAirtimeRemindersResponse$json = const {
  '1': 'GetAirtimeRemindersResponse',
  '2': const [
    const {'1': 'reminders', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.AirtimeReminder', '10': 'reminders'},
  ],
};

/// Descriptor for `GetAirtimeRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimeRemindersResponseDescriptor = $convert.base64Decode('ChtHZXRBaXJ0aW1lUmVtaW5kZXJzUmVzcG9uc2USPgoJcmVtaW5kZXJzGAEgAygLMiAudXRpbGl0eXBheW1lbnRzLkFpcnRpbWVSZW1pbmRlclIJcmVtaW5kZXJz');
@$core.Deprecated('Use updateAirtimeReminderRequestDescriptor instead')
const UpdateAirtimeReminderRequest$json = const {
  '1': 'UpdateAirtimeReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateAirtimeReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeReminderRequestDescriptor = $convert.base64Decode('ChxVcGRhdGVBaXJ0aW1lUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgGIAEoCVIIY3VycmVuY3kSIQoMaXNfcmVjdXJyaW5nGAcgASgIUgtpc1JlY3VycmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCCABKAlSDnJlY3VycmVuY2VUeXBl');
@$core.Deprecated('Use updateAirtimeReminderResponseDescriptor instead')
const UpdateAirtimeReminderResponse$json = const {
  '1': 'UpdateAirtimeReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.AirtimeReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAirtimeReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAirtimeReminderResponseDescriptor = $convert.base64Decode('Ch1VcGRhdGVBaXJ0aW1lUmVtaW5kZXJSZXNwb25zZRI8CghyZW1pbmRlchgBIAEoCzIgLnV0aWxpdHlwYXltZW50cy5BaXJ0aW1lUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteAirtimeReminderRequestDescriptor instead')
const DeleteAirtimeReminderRequest$json = const {
  '1': 'DeleteAirtimeReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteAirtimeReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeReminderRequestDescriptor = $convert.base64Decode('ChxEZWxldGVBaXJ0aW1lUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklk');
@$core.Deprecated('Use deleteAirtimeReminderResponseDescriptor instead')
const DeleteAirtimeReminderResponse$json = const {
  '1': 'DeleteAirtimeReminderResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAirtimeReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAirtimeReminderResponseDescriptor = $convert.base64Decode('Ch1EZWxldGVBaXJ0aW1lUmVtaW5kZXJSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use markAirtimeReminderCompleteRequestDescriptor instead')
const MarkAirtimeReminderCompleteRequest$json = const {
  '1': 'MarkAirtimeReminderCompleteRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkAirtimeReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAirtimeReminderCompleteRequestDescriptor = $convert.base64Decode('CiJNYXJrQWlydGltZVJlbWluZGVyQ29tcGxldGVSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklk');
@$core.Deprecated('Use markAirtimeReminderCompleteResponseDescriptor instead')
const MarkAirtimeReminderCompleteResponse$json = const {
  '1': 'MarkAirtimeReminderCompleteResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkAirtimeReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAirtimeReminderCompleteResponseDescriptor = $convert.base64Decode('CiNNYXJrQWlydGltZVJlbWluZGVyQ29tcGxldGVSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getAirtimePaymentReceiptRequestDescriptor instead')
const GetAirtimePaymentReceiptRequest$json = const {
  '1': 'GetAirtimePaymentReceiptRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GetAirtimePaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimePaymentReceiptRequestDescriptor = $convert.base64Decode('Ch9HZXRBaXJ0aW1lUGF5bWVudFJlY2VpcHRSZXF1ZXN0Eh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZA==');
@$core.Deprecated('Use getAirtimePaymentReceiptResponseDescriptor instead')
const GetAirtimePaymentReceiptResponse$json = const {
  '1': 'GetAirtimePaymentReceiptResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.BillPayment', '10': 'payment'},
    const {'1': 'phone_number', '3': 2, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network_name', '3': 3, '4': 1, '5': 9, '10': 'networkName'},
    const {'1': 'status_message', '3': 4, '4': 1, '5': 9, '10': 'statusMessage'},
    const {'1': 'service_fee', '3': 5, '4': 1, '5': 1, '10': 'serviceFee'},
    const {'1': 'total_amount', '3': 6, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'refund_state', '3': 7, '4': 1, '5': 9, '10': 'refundState'},
  ],
};

/// Descriptor for `GetAirtimePaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAirtimePaymentReceiptResponseDescriptor = $convert.base64Decode('CiBHZXRBaXJ0aW1lUGF5bWVudFJlY2VpcHRSZXNwb25zZRI2CgdwYXltZW50GAEgASgLMhwudXRpbGl0eXBheW1lbnRzLkJpbGxQYXltZW50UgdwYXltZW50EiEKDHBob25lX251bWJlchgCIAEoCVILcGhvbmVOdW1iZXISIQoMbmV0d29ya19uYW1lGAMgASgJUgtuZXR3b3JrTmFtZRIlCg5zdGF0dXNfbWVzc2FnZRgEIAEoCVINc3RhdHVzTWVzc2FnZRIfCgtzZXJ2aWNlX2ZlZRgFIAEoAVIKc2VydmljZUZlZRIhCgx0b3RhbF9hbW91bnQYBiABKAFSC3RvdGFsQW1vdW50EiEKDHJlZnVuZF9zdGF0ZRgHIAEoCVILcmVmdW5kU3RhdGU=');
@$core.Deprecated('Use dataBeneficiaryDescriptor instead')
const DataBeneficiary$json = const {
  '1': 'DataBeneficiary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'phone_number', '3': 3, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network_code', '3': 4, '4': 1, '5': 9, '10': 'networkCode'},
    const {'1': 'network_name', '3': 5, '4': 1, '5': 9, '10': 'networkName'},
    const {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'country_code', '3': 7, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'operator_id', '3': 8, '4': 1, '5': 9, '10': 'operatorId'},
    const {'1': 'last_amount', '3': 9, '4': 1, '5': 1, '10': 'lastAmount'},
    const {'1': 'last_variation_id', '3': 10, '4': 1, '5': 9, '10': 'lastVariationId'},
    const {'1': 'last_plan_name', '3': 11, '4': 1, '5': 9, '10': 'lastPlanName'},
    const {'1': 'last_topup_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTopupAt'},
    const {'1': 'topup_count', '3': 13, '4': 1, '5': 5, '10': 'topupCount'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `DataBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataBeneficiaryDescriptor = $convert.base64Decode('Cg9EYXRhQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIhCgxwaG9uZV9udW1iZXIYAyABKAlSC3Bob25lTnVtYmVyEiEKDG5ldHdvcmtfY29kZRgEIAEoCVILbmV0d29ya0NvZGUSIQoMbmV0d29ya19uYW1lGAUgASgJUgtuZXR3b3JrTmFtZRIaCghuaWNrbmFtZRgGIAEoCVIIbmlja25hbWUSIQoMY291bnRyeV9jb2RlGAcgASgJUgtjb3VudHJ5Q29kZRIfCgtvcGVyYXRvcl9pZBgIIAEoCVIKb3BlcmF0b3JJZBIfCgtsYXN0X2Ftb3VudBgJIAEoAVIKbGFzdEFtb3VudBIqChFsYXN0X3ZhcmlhdGlvbl9pZBgKIAEoCVIPbGFzdFZhcmlhdGlvbklkEiQKDmxhc3RfcGxhbl9uYW1lGAsgASgJUgxsYXN0UGxhbk5hbWUSPgoNbGFzdF90b3B1cF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RUb3B1cEF0Eh8KC3RvcHVwX2NvdW50GA0gASgFUgp0b3B1cENvdW50EjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use saveDataBeneficiaryRequestDescriptor instead')
const SaveDataBeneficiaryRequest$json = const {
  '1': 'SaveDataBeneficiaryRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network_code', '3': 2, '4': 1, '5': 9, '10': 'networkCode'},
    const {'1': 'network_name', '3': 3, '4': 1, '5': 9, '10': 'networkName'},
    const {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'country_code', '3': 5, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'operator_id', '3': 6, '4': 1, '5': 9, '10': 'operatorId'},
  ],
};

/// Descriptor for `SaveDataBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveDataBeneficiaryRequestDescriptor = $convert.base64Decode('ChpTYXZlRGF0YUJlbmVmaWNpYXJ5UmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEiEKDG5ldHdvcmtfY29kZRgCIAEoCVILbmV0d29ya0NvZGUSIQoMbmV0d29ya19uYW1lGAMgASgJUgtuZXR3b3JrTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWUSIQoMY291bnRyeV9jb2RlGAUgASgJUgtjb3VudHJ5Q29kZRIfCgtvcGVyYXRvcl9pZBgGIAEoCVIKb3BlcmF0b3JJZA==');
@$core.Deprecated('Use saveDataBeneficiaryResponseDescriptor instead')
const SaveDataBeneficiaryResponse$json = const {
  '1': 'SaveDataBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.DataBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveDataBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveDataBeneficiaryResponseDescriptor = $convert.base64Decode('ChtTYXZlRGF0YUJlbmVmaWNpYXJ5UmVzcG9uc2USQgoLYmVuZWZpY2lhcnkYASABKAsyIC51dGlsaXR5cGF5bWVudHMuRGF0YUJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getDataBeneficiariesRequestDescriptor instead')
const GetDataBeneficiariesRequest$json = const {
  '1': 'GetDataBeneficiariesRequest',
  '2': const [
    const {'1': 'network_code', '3': 1, '4': 1, '5': 9, '10': 'networkCode'},
  ],
};

/// Descriptor for `GetDataBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataBeneficiariesRequestDescriptor = $convert.base64Decode('ChtHZXREYXRhQmVuZWZpY2lhcmllc1JlcXVlc3QSIQoMbmV0d29ya19jb2RlGAEgASgJUgtuZXR3b3JrQ29kZQ==');
@$core.Deprecated('Use getDataBeneficiariesResponseDescriptor instead')
const GetDataBeneficiariesResponse$json = const {
  '1': 'GetDataBeneficiariesResponse',
  '2': const [
    const {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.DataBeneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `GetDataBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataBeneficiariesResponseDescriptor = $convert.base64Decode('ChxHZXREYXRhQmVuZWZpY2lhcmllc1Jlc3BvbnNlEkYKDWJlbmVmaWNpYXJpZXMYASADKAsyIC51dGlsaXR5cGF5bWVudHMuRGF0YUJlbmVmaWNpYXJ5Ug1iZW5lZmljaWFyaWVz');
@$core.Deprecated('Use updateDataBeneficiaryRequestDescriptor instead')
const UpdateDataBeneficiaryRequest$json = const {
  '1': 'UpdateDataBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateDataBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataBeneficiaryRequestDescriptor = $convert.base64Decode('ChxVcGRhdGVEYXRhQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIaCghuaWNrbmFtZRgCIAEoCVIIbmlja25hbWU=');
@$core.Deprecated('Use updateDataBeneficiaryResponseDescriptor instead')
const UpdateDataBeneficiaryResponse$json = const {
  '1': 'UpdateDataBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.DataBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateDataBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataBeneficiaryResponseDescriptor = $convert.base64Decode('Ch1VcGRhdGVEYXRhQmVuZWZpY2lhcnlSZXNwb25zZRJCCgtiZW5lZmljaWFyeRgBIAEoCzIgLnV0aWxpdHlwYXltZW50cy5EYXRhQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteDataBeneficiaryRequestDescriptor instead')
const DeleteDataBeneficiaryRequest$json = const {
  '1': 'DeleteDataBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteDataBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataBeneficiaryRequestDescriptor = $convert.base64Decode('ChxEZWxldGVEYXRhQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use deleteDataBeneficiaryResponseDescriptor instead')
const DeleteDataBeneficiaryResponse$json = const {
  '1': 'DeleteDataBeneficiaryResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteDataBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataBeneficiaryResponseDescriptor = $convert.base64Decode('Ch1EZWxldGVEYXRhQmVuZWZpY2lhcnlSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use dataAutoRechargeDescriptor instead')
const DataAutoRecharge$json = const {
  '1': 'DataAutoRecharge',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'network_code', '3': 5, '4': 1, '5': 9, '10': 'networkCode'},
    const {'1': 'network_name', '3': 6, '4': 1, '5': 9, '10': 'networkName'},
    const {'1': 'variation_id', '3': 7, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'plan_name', '3': 8, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'amount', '3': 9, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 11, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 12, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 13, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'execution_hour', '3': 14, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 15, '4': 1, '5': 5, '10': 'executionMinute'},
    const {'1': 'next_run_date', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRunDate'},
    const {'1': 'last_run_date', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastRunDate'},
    const {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'failure_count', '3': 19, '4': 1, '5': 5, '10': 'failureCount'},
    const {'1': 'max_retries', '3': 20, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'beneficiary', '3': 22, '4': 1, '5': 11, '6': '.utilitypayments.DataBeneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `DataAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataAutoRechargeDescriptor = $convert.base64Decode('ChBEYXRhQXV0b1JlY2hhcmdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSIQoMcGhvbmVfbnVtYmVyGAQgASgJUgtwaG9uZU51bWJlchIhCgxuZXR3b3JrX2NvZGUYBSABKAlSC25ldHdvcmtDb2RlEiEKDG5ldHdvcmtfbmFtZRgGIAEoCVILbmV0d29ya05hbWUSIQoMdmFyaWF0aW9uX2lkGAcgASgJUgt2YXJpYXRpb25JZBIbCglwbGFuX25hbWUYCCABKAlSCHBsYW5OYW1lEhYKBmFtb3VudBgJIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAogASgJUghjdXJyZW5jeRIcCglmcmVxdWVuY3kYCyABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zfd2VlaxgMIAEoBVIJZGF5T2ZXZWVrEiAKDGRheV9vZl9tb250aBgNIAEoBVIKZGF5T2ZNb250aBIlCg5leGVjdXRpb25faG91chgOIAEoBVINZXhlY3V0aW9uSG91chIpChBleGVjdXRpb25fbWludXRlGA8gASgFUg9leGVjdXRpb25NaW51dGUSPgoNbmV4dF9ydW5fZGF0ZRgQIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC25leHRSdW5EYXRlEj4KDWxhc3RfcnVuX2RhdGUYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsYXN0UnVuRGF0ZRIWCgZzdGF0dXMYEiABKAlSBnN0YXR1cxIjCg1mYWlsdXJlX2NvdW50GBMgASgFUgxmYWlsdXJlQ291bnQSHwoLbWF4X3JldHJpZXMYFCABKAVSCm1heFJldHJpZXMSOQoKY3JlYXRlZF9hdBgVIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBJCCgtiZW5lZmljaWFyeRgWIAEoCzIgLnV0aWxpdHlwYXltZW50cy5EYXRhQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5');
@$core.Deprecated('Use createDataAutoRechargeRequestDescriptor instead')
const CreateDataAutoRechargeRequest$json = const {
  '1': 'CreateDataAutoRechargeRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'variation_id', '3': 2, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'plan_name', '3': 3, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 6, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 7, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 8, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 9, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 10, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 11, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDataAutoRechargeRequestDescriptor = $convert.base64Decode('Ch1DcmVhdGVEYXRhQXV0b1JlY2hhcmdlUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIAEoCVINYmVuZWZpY2lhcnlJZBIhCgx2YXJpYXRpb25faWQYAiABKAlSC3ZhcmlhdGlvbklkEhsKCXBsYW5fbmFtZRgDIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgGIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAcgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAggASgFUgpkYXlPZk1vbnRoEh8KC21heF9yZXRyaWVzGAkgASgFUgptYXhSZXRyaWVzEiUKDmV4ZWN1dGlvbl9ob3VyGAogASgFUg1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYCyABKAVSD2V4ZWN1dGlvbk1pbnV0ZQ==');
@$core.Deprecated('Use createDataAutoRechargeResponseDescriptor instead')
const CreateDataAutoRechargeResponse$json = const {
  '1': 'CreateDataAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.DataAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDataAutoRechargeResponseDescriptor = $convert.base64Decode('Ch5DcmVhdGVEYXRhQXV0b1JlY2hhcmdlUmVzcG9uc2USRgoNYXV0b19yZWNoYXJnZRgBIAEoCzIhLnV0aWxpdHlwYXltZW50cy5EYXRhQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getDataAutoRechargesRequestDescriptor instead')
const GetDataAutoRechargesRequest$json = const {
  '1': 'GetDataAutoRechargesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetDataAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataAutoRechargesRequestDescriptor = $convert.base64Decode('ChtHZXREYXRhQXV0b1JlY2hhcmdlc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use getDataAutoRechargesResponseDescriptor instead')
const GetDataAutoRechargesResponse$json = const {
  '1': 'GetDataAutoRechargesResponse',
  '2': const [
    const {'1': 'auto_recharges', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.DataAutoRecharge', '10': 'autoRecharges'},
  ],
};

/// Descriptor for `GetDataAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataAutoRechargesResponseDescriptor = $convert.base64Decode('ChxHZXREYXRhQXV0b1JlY2hhcmdlc1Jlc3BvbnNlEkgKDmF1dG9fcmVjaGFyZ2VzGAEgAygLMiEudXRpbGl0eXBheW1lbnRzLkRhdGFBdXRvUmVjaGFyZ2VSDWF1dG9SZWNoYXJnZXM=');
@$core.Deprecated('Use updateDataAutoRechargeRequestDescriptor instead')
const UpdateDataAutoRechargeRequest$json = const {
  '1': 'UpdateDataAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    const {'1': 'variation_id', '3': 2, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'plan_name', '3': 3, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 5, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 6, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 7, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 8, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 9, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 10, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataAutoRechargeRequestDescriptor = $convert.base64Decode('Ch1VcGRhdGVEYXRhQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZBIhCgx2YXJpYXRpb25faWQYAiABKAlSC3ZhcmlhdGlvbklkEhsKCXBsYW5fbmFtZRgDIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSHAoJZnJlcXVlbmN5GAUgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYBiABKAVSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYByABKAVSCmRheU9mTW9udGgSHwoLbWF4X3JldHJpZXMYCCABKAVSCm1heFJldHJpZXMSJQoOZXhlY3V0aW9uX2hvdXIYCSABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW9uX21pbnV0ZRgKIAEoBVIPZXhlY3V0aW9uTWludXRl');
@$core.Deprecated('Use updateDataAutoRechargeResponseDescriptor instead')
const UpdateDataAutoRechargeResponse$json = const {
  '1': 'UpdateDataAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.DataAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataAutoRechargeResponseDescriptor = $convert.base64Decode('Ch5VcGRhdGVEYXRhQXV0b1JlY2hhcmdlUmVzcG9uc2USRgoNYXV0b19yZWNoYXJnZRgBIAEoCzIhLnV0aWxpdHlwYXltZW50cy5EYXRhQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteDataAutoRechargeRequestDescriptor instead')
const DeleteDataAutoRechargeRequest$json = const {
  '1': 'DeleteDataAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataAutoRechargeRequestDescriptor = $convert.base64Decode('Ch1EZWxldGVEYXRhQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZA==');
@$core.Deprecated('Use deleteDataAutoRechargeResponseDescriptor instead')
const DeleteDataAutoRechargeResponse$json = const {
  '1': 'DeleteDataAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataAutoRechargeResponseDescriptor = $convert.base64Decode('Ch5EZWxldGVEYXRhQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use pauseDataAutoRechargeRequestDescriptor instead')
const PauseDataAutoRechargeRequest$json = const {
  '1': 'PauseDataAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseDataAutoRechargeRequestDescriptor = $convert.base64Decode('ChxQYXVzZURhdGFBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDmF1dG9SZWNoYXJnZUlk');
@$core.Deprecated('Use pauseDataAutoRechargeResponseDescriptor instead')
const PauseDataAutoRechargeResponse$json = const {
  '1': 'PauseDataAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseDataAutoRechargeResponseDescriptor = $convert.base64Decode('Ch1QYXVzZURhdGFBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use resumeDataAutoRechargeRequestDescriptor instead')
const ResumeDataAutoRechargeRequest$json = const {
  '1': 'ResumeDataAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeDataAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeDataAutoRechargeRequestDescriptor = $convert.base64Decode('Ch1SZXN1bWVEYXRhQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZA==');
@$core.Deprecated('Use resumeDataAutoRechargeResponseDescriptor instead')
const ResumeDataAutoRechargeResponse$json = const {
  '1': 'ResumeDataAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeDataAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeDataAutoRechargeResponseDescriptor = $convert.base64Decode('Ch5SZXN1bWVEYXRhQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use dataReminderDescriptor instead')
const DataReminder$json = const {
  '1': 'DataReminder',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'variation_id', '3': 8, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 10, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 11, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'notified_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'notifiedAt'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `DataReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataReminderDescriptor = $convert.base64Decode('CgxEYXRhUmVtaW5kZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIlCg5iZW5lZmljaWFyeV9pZBgDIAEoCVINYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgEIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAcgASgBUgZhbW91bnQSIQoMdmFyaWF0aW9uX2lkGAggASgJUgt2YXJpYXRpb25JZBIaCghjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3kSIQoMaXNfcmVjdXJyaW5nGAogASgIUgtpc1JlY3VycmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCyABKAlSDnJlY3VycmVuY2VUeXBlEhYKBnN0YXR1cxgMIAEoCVIGc3RhdHVzEjsKC25vdGlmaWVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbm90aWZpZWRBdBI5CgpjcmVhdGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use createDataReminderRequestDescriptor instead')
const CreateDataReminderRequest$json = const {
  '1': 'CreateDataReminderRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'variation_id', '3': 6, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateDataReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDataReminderRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVEYXRhUmVtaW5kZXJSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgASgJUg1iZW5lZmljaWFyeUlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIhCgx2YXJpYXRpb25faWQYBiABKAlSC3ZhcmlhdGlvbklkEiEKDGlzX3JlY3VycmluZxgHIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAggASgJUg5yZWN1cnJlbmNlVHlwZRIaCghjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use createDataReminderResponseDescriptor instead')
const CreateDataReminderResponse$json = const {
  '1': 'CreateDataReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.DataReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateDataReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDataReminderResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVEYXRhUmVtaW5kZXJSZXNwb25zZRI5CghyZW1pbmRlchgBIAEoCzIdLnV0aWxpdHlwYXltZW50cy5EYXRhUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getDataRemindersRequestDescriptor instead')
const GetDataRemindersRequest$json = const {
  '1': 'GetDataRemindersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetDataRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataRemindersRequestDescriptor = $convert.base64Decode('ChdHZXREYXRhUmVtaW5kZXJzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIhCgxpbmNsdWRlX3Bhc3QYAiABKAhSC2luY2x1ZGVQYXN0');
@$core.Deprecated('Use getDataRemindersResponseDescriptor instead')
const GetDataRemindersResponse$json = const {
  '1': 'GetDataRemindersResponse',
  '2': const [
    const {'1': 'reminders', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.DataReminder', '10': 'reminders'},
  ],
};

/// Descriptor for `GetDataRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataRemindersResponseDescriptor = $convert.base64Decode('ChhHZXREYXRhUmVtaW5kZXJzUmVzcG9uc2USOwoJcmVtaW5kZXJzGAEgAygLMh0udXRpbGl0eXBheW1lbnRzLkRhdGFSZW1pbmRlclIJcmVtaW5kZXJz');
@$core.Deprecated('Use updateDataReminderRequestDescriptor instead')
const UpdateDataReminderRequest$json = const {
  '1': 'UpdateDataReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'variation_id', '3': 6, '4': 1, '5': 9, '10': 'variationId'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateDataReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataReminderRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVEYXRhUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIhCgx2YXJpYXRpb25faWQYBiABKAlSC3ZhcmlhdGlvbklkEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYCCABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgJIAEoCVIOcmVjdXJyZW5jZVR5cGU=');
@$core.Deprecated('Use updateDataReminderResponseDescriptor instead')
const UpdateDataReminderResponse$json = const {
  '1': 'UpdateDataReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.DataReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateDataReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataReminderResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVEYXRhUmVtaW5kZXJSZXNwb25zZRI5CghyZW1pbmRlchgBIAEoCzIdLnV0aWxpdHlwYXltZW50cy5EYXRhUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteDataReminderRequestDescriptor instead')
const DeleteDataReminderRequest$json = const {
  '1': 'DeleteDataReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteDataReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataReminderRequestDescriptor = $convert.base64Decode('ChlEZWxldGVEYXRhUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklk');
@$core.Deprecated('Use deleteDataReminderResponseDescriptor instead')
const DeleteDataReminderResponse$json = const {
  '1': 'DeleteDataReminderResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteDataReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDataReminderResponseDescriptor = $convert.base64Decode('ChpEZWxldGVEYXRhUmVtaW5kZXJSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use markDataReminderCompleteRequestDescriptor instead')
const MarkDataReminderCompleteRequest$json = const {
  '1': 'MarkDataReminderCompleteRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkDataReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markDataReminderCompleteRequestDescriptor = $convert.base64Decode('Ch9NYXJrRGF0YVJlbWluZGVyQ29tcGxldGVSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklk');
@$core.Deprecated('Use markDataReminderCompleteResponseDescriptor instead')
const MarkDataReminderCompleteResponse$json = const {
  '1': 'MarkDataReminderCompleteResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkDataReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markDataReminderCompleteResponseDescriptor = $convert.base64Decode('CiBNYXJrRGF0YVJlbWluZGVyQ29tcGxldGVSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use cableTVBeneficiaryDescriptor instead')
const CableTVBeneficiary$json = const {
  '1': 'CableTVBeneficiary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'smart_card_number', '3': 3, '4': 1, '5': 9, '10': 'smartCardNumber'},
    const {'1': 'provider_code', '3': 4, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 5, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'customer_name', '3': 7, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'current_package', '3': 8, '4': 1, '5': 9, '10': 'currentPackage'},
    const {'1': 'last_amount', '3': 9, '4': 1, '5': 1, '10': 'lastAmount'},
    const {'1': 'last_variation_code', '3': 10, '4': 1, '5': 9, '10': 'lastVariationCode'},
    const {'1': 'last_package_name', '3': 11, '4': 1, '5': 9, '10': 'lastPackageName'},
    const {'1': 'last_topup_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTopupAt'},
    const {'1': 'topup_count', '3': 13, '4': 1, '5': 5, '10': 'topupCount'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `CableTVBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cableTVBeneficiaryDescriptor = $convert.base64Decode('ChJDYWJsZVRWQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIqChFzbWFydF9jYXJkX251bWJlchgDIAEoCVIPc21hcnRDYXJkTnVtYmVyEiMKDXByb3ZpZGVyX2NvZGUYBCABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAUgASgJUgxwcm92aWRlck5hbWUSGgoIbmlja25hbWUYBiABKAlSCG5pY2tuYW1lEiMKDWN1c3RvbWVyX25hbWUYByABKAlSDGN1c3RvbWVyTmFtZRInCg9jdXJyZW50X3BhY2thZ2UYCCABKAlSDmN1cnJlbnRQYWNrYWdlEh8KC2xhc3RfYW1vdW50GAkgASgBUgpsYXN0QW1vdW50Ei4KE2xhc3RfdmFyaWF0aW9uX2NvZGUYCiABKAlSEWxhc3RWYXJpYXRpb25Db2RlEioKEWxhc3RfcGFja2FnZV9uYW1lGAsgASgJUg9sYXN0UGFja2FnZU5hbWUSPgoNbGFzdF90b3B1cF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RUb3B1cEF0Eh8KC3RvcHVwX2NvdW50GA0gASgFUgp0b3B1cENvdW50EjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use saveCableTVBeneficiaryRequestDescriptor instead')
const SaveCableTVBeneficiaryRequest$json = const {
  '1': 'SaveCableTVBeneficiaryRequest',
  '2': const [
    const {'1': 'smart_card_number', '3': 1, '4': 1, '5': 9, '10': 'smartCardNumber'},
    const {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 3, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'customer_name', '3': 5, '4': 1, '5': 9, '10': 'customerName'},
  ],
};

/// Descriptor for `SaveCableTVBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveCableTVBeneficiaryRequestDescriptor = $convert.base64Decode('Ch1TYXZlQ2FibGVUVkJlbmVmaWNpYXJ5UmVxdWVzdBIqChFzbWFydF9jYXJkX251bWJlchgBIAEoCVIPc21hcnRDYXJkTnVtYmVyEiMKDXByb3ZpZGVyX2NvZGUYAiABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAMgASgJUgxwcm92aWRlck5hbWUSGgoIbmlja25hbWUYBCABKAlSCG5pY2tuYW1lEiMKDWN1c3RvbWVyX25hbWUYBSABKAlSDGN1c3RvbWVyTmFtZQ==');
@$core.Deprecated('Use saveCableTVBeneficiaryResponseDescriptor instead')
const SaveCableTVBeneficiaryResponse$json = const {
  '1': 'SaveCableTVBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.CableTVBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveCableTVBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveCableTVBeneficiaryResponseDescriptor = $convert.base64Decode('Ch5TYXZlQ2FibGVUVkJlbmVmaWNpYXJ5UmVzcG9uc2USRQoLYmVuZWZpY2lhcnkYASABKAsyIy51dGlsaXR5cGF5bWVudHMuQ2FibGVUVkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getCableTVBeneficiariesRequestDescriptor instead')
const GetCableTVBeneficiariesRequest$json = const {
  '1': 'GetCableTVBeneficiariesRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetCableTVBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVBeneficiariesRequestDescriptor = $convert.base64Decode('Ch5HZXRDYWJsZVRWQmVuZWZpY2lhcmllc1JlcXVlc3QSIwoNcHJvdmlkZXJfY29kZRgBIAEoCVIMcHJvdmlkZXJDb2Rl');
@$core.Deprecated('Use getCableTVBeneficiariesResponseDescriptor instead')
const GetCableTVBeneficiariesResponse$json = const {
  '1': 'GetCableTVBeneficiariesResponse',
  '2': const [
    const {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.CableTVBeneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `GetCableTVBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVBeneficiariesResponseDescriptor = $convert.base64Decode('Ch9HZXRDYWJsZVRWQmVuZWZpY2lhcmllc1Jlc3BvbnNlEkkKDWJlbmVmaWNpYXJpZXMYASADKAsyIy51dGlsaXR5cGF5bWVudHMuQ2FibGVUVkJlbmVmaWNpYXJ5Ug1iZW5lZmljaWFyaWVz');
@$core.Deprecated('Use updateCableTVBeneficiaryRequestDescriptor instead')
const UpdateCableTVBeneficiaryRequest$json = const {
  '1': 'UpdateCableTVBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateCableTVBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVBeneficiaryRequestDescriptor = $convert.base64Decode('Ch9VcGRhdGVDYWJsZVRWQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIaCghuaWNrbmFtZRgCIAEoCVIIbmlja25hbWU=');
@$core.Deprecated('Use updateCableTVBeneficiaryResponseDescriptor instead')
const UpdateCableTVBeneficiaryResponse$json = const {
  '1': 'UpdateCableTVBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.CableTVBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateCableTVBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVBeneficiaryResponseDescriptor = $convert.base64Decode('CiBVcGRhdGVDYWJsZVRWQmVuZWZpY2lhcnlSZXNwb25zZRJFCgtiZW5lZmljaWFyeRgBIAEoCzIjLnV0aWxpdHlwYXltZW50cy5DYWJsZVRWQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteCableTVBeneficiaryRequestDescriptor instead')
const DeleteCableTVBeneficiaryRequest$json = const {
  '1': 'DeleteCableTVBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteCableTVBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVBeneficiaryRequestDescriptor = $convert.base64Decode('Ch9EZWxldGVDYWJsZVRWQmVuZWZpY2lhcnlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use deleteCableTVBeneficiaryResponseDescriptor instead')
const DeleteCableTVBeneficiaryResponse$json = const {
  '1': 'DeleteCableTVBeneficiaryResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCableTVBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVBeneficiaryResponseDescriptor = $convert.base64Decode('CiBEZWxldGVDYWJsZVRWQmVuZWZpY2lhcnlSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use cableTVAutoRechargeDescriptor instead')
const CableTVAutoRecharge$json = const {
  '1': 'CableTVAutoRecharge',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'smart_card_number', '3': 4, '4': 1, '5': 9, '10': 'smartCardNumber'},
    const {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'variation_code', '3': 6, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'package_name', '3': 7, '4': 1, '5': 9, '10': 'packageName'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'subscription_type', '3': 10, '4': 1, '5': 9, '10': 'subscriptionType'},
    const {'1': 'frequency', '3': 11, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 12, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 13, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'execution_hour', '3': 14, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 15, '4': 1, '5': 5, '10': 'executionMinute'},
    const {'1': 'next_run_date', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRunDate'},
    const {'1': 'last_run_date', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastRunDate'},
    const {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'failure_count', '3': 19, '4': 1, '5': 5, '10': 'failureCount'},
    const {'1': 'max_retries', '3': 20, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'beneficiary', '3': 22, '4': 1, '5': 11, '6': '.utilitypayments.CableTVBeneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `CableTVAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cableTVAutoRechargeDescriptor = $convert.base64Decode('ChNDYWJsZVRWQXV0b1JlY2hhcmdlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSKgoRc21hcnRfY2FyZF9udW1iZXIYBCABKAlSD3NtYXJ0Q2FyZE51bWJlchIjCg1wcm92aWRlcl9jb2RlGAUgASgJUgxwcm92aWRlckNvZGUSJQoOdmFyaWF0aW9uX2NvZGUYBiABKAlSDXZhcmlhdGlvbkNvZGUSIQoMcGFja2FnZV9uYW1lGAcgASgJUgtwYWNrYWdlTmFtZRIWCgZhbW91bnQYCCABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3kSKwoRc3Vic2NyaXB0aW9uX3R5cGUYCiABKAlSEHN1YnNjcmlwdGlvblR5cGUSHAoJZnJlcXVlbmN5GAsgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYDCABKAVSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYDSABKAVSCmRheU9mTW9udGgSJQoOZXhlY3V0aW9uX2hvdXIYDiABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW9uX21pbnV0ZRgPIAEoBVIPZXhlY3V0aW9uTWludXRlEj4KDW5leHRfcnVuX2RhdGUYECABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtuZXh0UnVuRGF0ZRI+Cg1sYXN0X3J1bl9kYXRlGBEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFJ1bkRhdGUSFgoGc3RhdHVzGBIgASgJUgZzdGF0dXMSIwoNZmFpbHVyZV9jb3VudBgTIAEoBVIMZmFpbHVyZUNvdW50Eh8KC21heF9yZXRyaWVzGBQgASgFUgptYXhSZXRyaWVzEjkKCmNyZWF0ZWRfYXQYFSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSRQoLYmVuZWZpY2lhcnkYFiABKAsyIy51dGlsaXR5cGF5bWVudHMuQ2FibGVUVkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeQ==');
@$core.Deprecated('Use createCableTVAutoRechargeRequestDescriptor instead')
const CreateCableTVAutoRechargeRequest$json = const {
  '1': 'CreateCableTVAutoRechargeRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'variation_code', '3': 2, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'package_name', '3': 3, '4': 1, '5': 9, '10': 'packageName'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'subscription_type', '3': 6, '4': 1, '5': 9, '10': 'subscriptionType'},
    const {'1': 'frequency', '3': 7, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 8, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 9, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 10, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 11, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 12, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCableTVAutoRechargeRequestDescriptor = $convert.base64Decode('CiBDcmVhdGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIAEoCVINYmVuZWZpY2lhcnlJZBIlCg52YXJpYXRpb25fY29kZRgCIAEoCVINdmFyaWF0aW9uQ29kZRIhCgxwYWNrYWdlX25hbWUYAyABKAlSC3BhY2thZ2VOYW1lEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAUgASgJUghjdXJyZW5jeRIrChFzdWJzY3JpcHRpb25fdHlwZRgGIAEoCVIQc3Vic2NyaXB0aW9uVHlwZRIcCglmcmVxdWVuY3kYByABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zfd2VlaxgIIAEoBVIJZGF5T2ZXZWVrEiAKDGRheV9vZl9tb250aBgJIAEoBVIKZGF5T2ZNb250aBIfCgttYXhfcmV0cmllcxgKIAEoBVIKbWF4UmV0cmllcxIlCg5leGVjdXRpb25faG91chgLIAEoBVINZXhlY3V0aW9uSG91chIpChBleGVjdXRpb25fbWludXRlGAwgASgFUg9leGVjdXRpb25NaW51dGU=');
@$core.Deprecated('Use createCableTVAutoRechargeResponseDescriptor instead')
const CreateCableTVAutoRechargeResponse$json = const {
  '1': 'CreateCableTVAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.CableTVAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCableTVAutoRechargeResponseDescriptor = $convert.base64Decode('CiFDcmVhdGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVzcG9uc2USSQoNYXV0b19yZWNoYXJnZRgBIAEoCzIkLnV0aWxpdHlwYXltZW50cy5DYWJsZVRWQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getCableTVAutoRechargesRequestDescriptor instead')
const GetCableTVAutoRechargesRequest$json = const {
  '1': 'GetCableTVAutoRechargesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetCableTVAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVAutoRechargesRequestDescriptor = $convert.base64Decode('Ch5HZXRDYWJsZVRWQXV0b1JlY2hhcmdlc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use getCableTVAutoRechargesResponseDescriptor instead')
const GetCableTVAutoRechargesResponse$json = const {
  '1': 'GetCableTVAutoRechargesResponse',
  '2': const [
    const {'1': 'auto_recharges', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.CableTVAutoRecharge', '10': 'autoRecharges'},
  ],
};

/// Descriptor for `GetCableTVAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVAutoRechargesResponseDescriptor = $convert.base64Decode('Ch9HZXRDYWJsZVRWQXV0b1JlY2hhcmdlc1Jlc3BvbnNlEksKDmF1dG9fcmVjaGFyZ2VzGAEgAygLMiQudXRpbGl0eXBheW1lbnRzLkNhYmxlVFZBdXRvUmVjaGFyZ2VSDWF1dG9SZWNoYXJnZXM=');
@$core.Deprecated('Use updateCableTVAutoRechargeRequestDescriptor instead')
const UpdateCableTVAutoRechargeRequest$json = const {
  '1': 'UpdateCableTVAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    const {'1': 'variation_code', '3': 2, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'package_name', '3': 3, '4': 1, '5': 9, '10': 'packageName'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 5, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 6, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 7, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 8, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 9, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 10, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVAutoRechargeRequestDescriptor = $convert.base64Decode('CiBVcGRhdGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZBIlCg52YXJpYXRpb25fY29kZRgCIAEoCVINdmFyaWF0aW9uQ29kZRIhCgxwYWNrYWdlX25hbWUYAyABKAlSC3BhY2thZ2VOYW1lEhYKBmFtb3VudBgEIAEoAVIGYW1vdW50EhwKCWZyZXF1ZW5jeRgFIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAYgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAcgASgFUgpkYXlPZk1vbnRoEh8KC21heF9yZXRyaWVzGAggASgFUgptYXhSZXRyaWVzEiUKDmV4ZWN1dGlvbl9ob3VyGAkgASgFUg1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYCiABKAVSD2V4ZWN1dGlvbk1pbnV0ZQ==');
@$core.Deprecated('Use updateCableTVAutoRechargeResponseDescriptor instead')
const UpdateCableTVAutoRechargeResponse$json = const {
  '1': 'UpdateCableTVAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.CableTVAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVAutoRechargeResponseDescriptor = $convert.base64Decode('CiFVcGRhdGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVzcG9uc2USSQoNYXV0b19yZWNoYXJnZRgBIAEoCzIkLnV0aWxpdHlwYXltZW50cy5DYWJsZVRWQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteCableTVAutoRechargeRequestDescriptor instead')
const DeleteCableTVAutoRechargeRequest$json = const {
  '1': 'DeleteCableTVAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVAutoRechargeRequestDescriptor = $convert.base64Decode('CiBEZWxldGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZA==');
@$core.Deprecated('Use deleteCableTVAutoRechargeResponseDescriptor instead')
const DeleteCableTVAutoRechargeResponse$json = const {
  '1': 'DeleteCableTVAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVAutoRechargeResponseDescriptor = $convert.base64Decode('CiFEZWxldGVDYWJsZVRWQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use pauseCableTVAutoRechargeRequestDescriptor instead')
const PauseCableTVAutoRechargeRequest$json = const {
  '1': 'PauseCableTVAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseCableTVAutoRechargeRequestDescriptor = $convert.base64Decode('Ch9QYXVzZUNhYmxlVFZBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDmF1dG9SZWNoYXJnZUlk');
@$core.Deprecated('Use pauseCableTVAutoRechargeResponseDescriptor instead')
const PauseCableTVAutoRechargeResponse$json = const {
  '1': 'PauseCableTVAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseCableTVAutoRechargeResponseDescriptor = $convert.base64Decode('CiBQYXVzZUNhYmxlVFZBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use resumeCableTVAutoRechargeRequestDescriptor instead')
const ResumeCableTVAutoRechargeRequest$json = const {
  '1': 'ResumeCableTVAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeCableTVAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeCableTVAutoRechargeRequestDescriptor = $convert.base64Decode('CiBSZXN1bWVDYWJsZVRWQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZA==');
@$core.Deprecated('Use resumeCableTVAutoRechargeResponseDescriptor instead')
const ResumeCableTVAutoRechargeResponse$json = const {
  '1': 'ResumeCableTVAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeCableTVAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeCableTVAutoRechargeResponseDescriptor = $convert.base64Decode('CiFSZXN1bWVDYWJsZVRWQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use cableTVReminderDescriptor instead')
const CableTVReminder$json = const {
  '1': 'CableTVReminder',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'variation_code', '3': 8, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 10, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 11, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'notified_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'notifiedAt'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `CableTVReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cableTVReminderDescriptor = $convert.base64Decode('Cg9DYWJsZVRWUmVtaW5kZXISDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIlCg5iZW5lZmljaWFyeV9pZBgDIAEoCVINYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgEIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBSABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAcgASgBUgZhbW91bnQSJQoOdmFyaWF0aW9uX2NvZGUYCCABKAlSDXZhcmlhdGlvbkNvZGUSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EiEKDGlzX3JlY3VycmluZxgKIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAsgASgJUg5yZWN1cnJlbmNlVHlwZRIWCgZzdGF0dXMYDCABKAlSBnN0YXR1cxI7Cgtub3RpZmllZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCm5vdGlmaWVkQXQSOQoKY3JlYXRlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use createCableTVReminderRequestDescriptor instead')
const CreateCableTVReminderRequest$json = const {
  '1': 'CreateCableTVReminderRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'variation_code', '3': 6, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateCableTVReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCableTVReminderRequestDescriptor = $convert.base64Decode('ChxDcmVhdGVDYWJsZVRWUmVtaW5kZXJSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgASgJUg1iZW5lZmljaWFyeUlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIlCg52YXJpYXRpb25fY29kZRgGIAEoCVINdmFyaWF0aW9uQ29kZRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgIIAEoCVIOcmVjdXJyZW5jZVR5cGUSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use createCableTVReminderResponseDescriptor instead')
const CreateCableTVReminderResponse$json = const {
  '1': 'CreateCableTVReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.CableTVReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateCableTVReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCableTVReminderResponseDescriptor = $convert.base64Decode('Ch1DcmVhdGVDYWJsZVRWUmVtaW5kZXJSZXNwb25zZRI8CghyZW1pbmRlchgBIAEoCzIgLnV0aWxpdHlwYXltZW50cy5DYWJsZVRWUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getCableTVRemindersRequestDescriptor instead')
const GetCableTVRemindersRequest$json = const {
  '1': 'GetCableTVRemindersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetCableTVRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVRemindersRequestDescriptor = $convert.base64Decode('ChpHZXRDYWJsZVRWUmVtaW5kZXJzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cxIhCgxpbmNsdWRlX3Bhc3QYAiABKAhSC2luY2x1ZGVQYXN0');
@$core.Deprecated('Use getCableTVRemindersResponseDescriptor instead')
const GetCableTVRemindersResponse$json = const {
  '1': 'GetCableTVRemindersResponse',
  '2': const [
    const {'1': 'reminders', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.CableTVReminder', '10': 'reminders'},
  ],
};

/// Descriptor for `GetCableTVRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCableTVRemindersResponseDescriptor = $convert.base64Decode('ChtHZXRDYWJsZVRWUmVtaW5kZXJzUmVzcG9uc2USPgoJcmVtaW5kZXJzGAEgAygLMiAudXRpbGl0eXBheW1lbnRzLkNhYmxlVFZSZW1pbmRlclIJcmVtaW5kZXJz');
@$core.Deprecated('Use updateCableTVReminderRequestDescriptor instead')
const UpdateCableTVReminderRequest$json = const {
  '1': 'UpdateCableTVReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'variation_code', '3': 6, '4': 1, '5': 9, '10': 'variationCode'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateCableTVReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVReminderRequestDescriptor = $convert.base64Decode('ChxVcGRhdGVDYWJsZVRWUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYBSABKAFSBmFtb3VudBIlCg52YXJpYXRpb25fY29kZRgGIAEoCVINdmFyaWF0aW9uQ29kZRIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSIQoMaXNfcmVjdXJyaW5nGAggASgIUgtpc1JlY3VycmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCSABKAlSDnJlY3VycmVuY2VUeXBl');
@$core.Deprecated('Use updateCableTVReminderResponseDescriptor instead')
const UpdateCableTVReminderResponse$json = const {
  '1': 'UpdateCableTVReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.CableTVReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateCableTVReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCableTVReminderResponseDescriptor = $convert.base64Decode('Ch1VcGRhdGVDYWJsZVRWUmVtaW5kZXJSZXNwb25zZRI8CghyZW1pbmRlchgBIAEoCzIgLnV0aWxpdHlwYXltZW50cy5DYWJsZVRWUmVtaW5kZXJSCHJlbWluZGVyEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteCableTVReminderRequestDescriptor instead')
const DeleteCableTVReminderRequest$json = const {
  '1': 'DeleteCableTVReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteCableTVReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVReminderRequestDescriptor = $convert.base64Decode('ChxEZWxldGVDYWJsZVRWUmVtaW5kZXJSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklk');
@$core.Deprecated('Use deleteCableTVReminderResponseDescriptor instead')
const DeleteCableTVReminderResponse$json = const {
  '1': 'DeleteCableTVReminderResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCableTVReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCableTVReminderResponseDescriptor = $convert.base64Decode('Ch1EZWxldGVDYWJsZVRWUmVtaW5kZXJSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use markCableTVReminderCompleteRequestDescriptor instead')
const MarkCableTVReminderCompleteRequest$json = const {
  '1': 'MarkCableTVReminderCompleteRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkCableTVReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markCableTVReminderCompleteRequestDescriptor = $convert.base64Decode('CiJNYXJrQ2FibGVUVlJlbWluZGVyQ29tcGxldGVSZXF1ZXN0Eh8KC3JlbWluZGVyX2lkGAEgASgJUgpyZW1pbmRlcklk');
@$core.Deprecated('Use markCableTVReminderCompleteResponseDescriptor instead')
const MarkCableTVReminderCompleteResponse$json = const {
  '1': 'MarkCableTVReminderCompleteResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkCableTVReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markCableTVReminderCompleteResponseDescriptor = $convert.base64Decode('CiNNYXJrQ2FibGVUVlJlbWluZGVyQ29tcGxldGVSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use waterBeneficiaryDescriptor instead')
const WaterBeneficiary$json = const {
  '1': 'WaterBeneficiary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'provider_code', '3': 4, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 5, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'customer_name', '3': 7, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'last_amount', '3': 8, '4': 1, '5': 1, '10': 'lastAmount'},
    const {'1': 'last_topup_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTopupAt'},
    const {'1': 'topup_count', '3': 10, '4': 1, '5': 5, '10': 'topupCount'},
    const {'1': 'created_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `WaterBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waterBeneficiaryDescriptor = $convert.base64Decode('ChBXYXRlckJlbmVmaWNpYXJ5Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYWNjb3VudF9udW1iZXIYAyABKAlSDWFjY291bnROdW1iZXISIwoNcHJvdmlkZXJfY29kZRgEIAEoCVIMcHJvdmlkZXJDb2RlEiMKDXByb3ZpZGVyX25hbWUYBSABKAlSDHByb3ZpZGVyTmFtZRIaCghuaWNrbmFtZRgGIAEoCVIIbmlja25hbWUSIwoNY3VzdG9tZXJfbmFtZRgHIAEoCVIMY3VzdG9tZXJOYW1lEh8KC2xhc3RfYW1vdW50GAggASgBUgpsYXN0QW1vdW50Ej4KDWxhc3RfdG9wdXBfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtsYXN0VG9wdXBBdBIfCgt0b3B1cF9jb3VudBgKIAEoBVIKdG9wdXBDb3VudBI5CgpjcmVhdGVkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use saveWaterBeneficiaryRequestDescriptor instead')
const SaveWaterBeneficiaryRequest$json = const {
  '1': 'SaveWaterBeneficiaryRequest',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 3, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'customer_name', '3': 5, '4': 1, '5': 9, '10': 'customerName'},
  ],
};

/// Descriptor for `SaveWaterBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveWaterBeneficiaryRequestDescriptor = $convert.base64Decode('ChtTYXZlV2F0ZXJCZW5lZmljaWFyeVJlcXVlc3QSJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW1iZXISIwoNcHJvdmlkZXJfY29kZRgCIAEoCVIMcHJvdmlkZXJDb2RlEiMKDXByb3ZpZGVyX25hbWUYAyABKAlSDHByb3ZpZGVyTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWUSIwoNY3VzdG9tZXJfbmFtZRgFIAEoCVIMY3VzdG9tZXJOYW1l');
@$core.Deprecated('Use saveWaterBeneficiaryResponseDescriptor instead')
const SaveWaterBeneficiaryResponse$json = const {
  '1': 'SaveWaterBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.WaterBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveWaterBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveWaterBeneficiaryResponseDescriptor = $convert.base64Decode('ChxTYXZlV2F0ZXJCZW5lZmljaWFyeVJlc3BvbnNlEkMKC2JlbmVmaWNpYXJ5GAEgASgLMiEudXRpbGl0eXBheW1lbnRzLldhdGVyQmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getWaterBeneficiariesRequestDescriptor instead')
const GetWaterBeneficiariesRequest$json = const {
  '1': 'GetWaterBeneficiariesRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetWaterBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterBeneficiariesRequestDescriptor = $convert.base64Decode('ChxHZXRXYXRlckJlbmVmaWNpYXJpZXNSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKAlSDHByb3ZpZGVyQ29kZQ==');
@$core.Deprecated('Use getWaterBeneficiariesResponseDescriptor instead')
const GetWaterBeneficiariesResponse$json = const {
  '1': 'GetWaterBeneficiariesResponse',
  '2': const [
    const {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.WaterBeneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `GetWaterBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterBeneficiariesResponseDescriptor = $convert.base64Decode('Ch1HZXRXYXRlckJlbmVmaWNpYXJpZXNSZXNwb25zZRJHCg1iZW5lZmljaWFyaWVzGAEgAygLMiEudXRpbGl0eXBheW1lbnRzLldhdGVyQmVuZWZpY2lhcnlSDWJlbmVmaWNpYXJpZXM=');
@$core.Deprecated('Use updateWaterBeneficiaryRequestDescriptor instead')
const UpdateWaterBeneficiaryRequest$json = const {
  '1': 'UpdateWaterBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateWaterBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterBeneficiaryRequestDescriptor = $convert.base64Decode('Ch1VcGRhdGVXYXRlckJlbmVmaWNpYXJ5UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSGgoIbmlja25hbWUYAiABKAlSCG5pY2tuYW1l');
@$core.Deprecated('Use updateWaterBeneficiaryResponseDescriptor instead')
const UpdateWaterBeneficiaryResponse$json = const {
  '1': 'UpdateWaterBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.WaterBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateWaterBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterBeneficiaryResponseDescriptor = $convert.base64Decode('Ch5VcGRhdGVXYXRlckJlbmVmaWNpYXJ5UmVzcG9uc2USQwoLYmVuZWZpY2lhcnkYASABKAsyIS51dGlsaXR5cGF5bWVudHMuV2F0ZXJCZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteWaterBeneficiaryRequestDescriptor instead')
const DeleteWaterBeneficiaryRequest$json = const {
  '1': 'DeleteWaterBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteWaterBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterBeneficiaryRequestDescriptor = $convert.base64Decode('Ch1EZWxldGVXYXRlckJlbmVmaWNpYXJ5UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use deleteWaterBeneficiaryResponseDescriptor instead')
const DeleteWaterBeneficiaryResponse$json = const {
  '1': 'DeleteWaterBeneficiaryResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteWaterBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterBeneficiaryResponseDescriptor = $convert.base64Decode('Ch5EZWxldGVXYXRlckJlbmVmaWNpYXJ5UmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use waterAutoRechargeDescriptor instead')
const WaterAutoRecharge$json = const {
  '1': 'WaterAutoRecharge',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 8, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 9, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 10, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'execution_hour', '3': 11, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 12, '4': 1, '5': 5, '10': 'executionMinute'},
    const {'1': 'next_run_date', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRunDate'},
    const {'1': 'last_run_date', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastRunDate'},
    const {'1': 'status', '3': 15, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'failure_count', '3': 16, '4': 1, '5': 5, '10': 'failureCount'},
    const {'1': 'max_retries', '3': 17, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'beneficiary', '3': 19, '4': 1, '5': 11, '6': '.utilitypayments.WaterBeneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `WaterAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waterAutoRechargeDescriptor = $convert.base64Decode('ChFXYXRlckF1dG9SZWNoYXJnZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiUKDmJlbmVmaWNpYXJ5X2lkGAMgASgJUg1iZW5lZmljaWFyeUlkEiUKDmFjY291bnRfbnVtYmVyGAQgASgJUg1hY2NvdW50TnVtYmVyEiMKDXByb3ZpZGVyX2NvZGUYBSABKAlSDHByb3ZpZGVyQ29kZRIWCgZhbW91bnQYBiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgHIAEoCVIIY3VycmVuY3kSHAoJZnJlcXVlbmN5GAggASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYCSABKAVSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYCiABKAVSCmRheU9mTW9udGgSJQoOZXhlY3V0aW9uX2hvdXIYCyABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW9uX21pbnV0ZRgMIAEoBVIPZXhlY3V0aW9uTWludXRlEj4KDW5leHRfcnVuX2RhdGUYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtuZXh0UnVuRGF0ZRI+Cg1sYXN0X3J1bl9kYXRlGA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbGFzdFJ1bkRhdGUSFgoGc3RhdHVzGA8gASgJUgZzdGF0dXMSIwoNZmFpbHVyZV9jb3VudBgQIAEoBVIMZmFpbHVyZUNvdW50Eh8KC21heF9yZXRyaWVzGBEgASgFUgptYXhSZXRyaWVzEjkKCmNyZWF0ZWRfYXQYEiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSQwoLYmVuZWZpY2lhcnkYEyABKAsyIS51dGlsaXR5cGF5bWVudHMuV2F0ZXJCZW5lZmljaWFyeVILYmVuZWZpY2lhcnk=');
@$core.Deprecated('Use createWaterAutoRechargeRequestDescriptor instead')
const CreateWaterAutoRechargeRequest$json = const {
  '1': 'CreateWaterAutoRechargeRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 5, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 6, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 7, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 8, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 9, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaterAutoRechargeRequestDescriptor = $convert.base64Decode('Ch5DcmVhdGVXYXRlckF1dG9SZWNoYXJnZVJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbmVmaWNpYXJ5SWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgEIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAUgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAYgASgFUgpkYXlPZk1vbnRoEh8KC21heF9yZXRyaWVzGAcgASgFUgptYXhSZXRyaWVzEiUKDmV4ZWN1dGlvbl9ob3VyGAggASgFUg1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYCSABKAVSD2V4ZWN1dGlvbk1pbnV0ZQ==');
@$core.Deprecated('Use createWaterAutoRechargeResponseDescriptor instead')
const CreateWaterAutoRechargeResponse$json = const {
  '1': 'CreateWaterAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.WaterAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaterAutoRechargeResponseDescriptor = $convert.base64Decode('Ch9DcmVhdGVXYXRlckF1dG9SZWNoYXJnZVJlc3BvbnNlEkcKDWF1dG9fcmVjaGFyZ2UYASABKAsyIi51dGlsaXR5cGF5bWVudHMuV2F0ZXJBdXRvUmVjaGFyZ2VSDGF1dG9SZWNoYXJnZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getWaterAutoRechargesRequestDescriptor instead')
const GetWaterAutoRechargesRequest$json = const {
  '1': 'GetWaterAutoRechargesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetWaterAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterAutoRechargesRequestDescriptor = $convert.base64Decode('ChxHZXRXYXRlckF1dG9SZWNoYXJnZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use getWaterAutoRechargesResponseDescriptor instead')
const GetWaterAutoRechargesResponse$json = const {
  '1': 'GetWaterAutoRechargesResponse',
  '2': const [
    const {'1': 'auto_recharges', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.WaterAutoRecharge', '10': 'autoRecharges'},
  ],
};

/// Descriptor for `GetWaterAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterAutoRechargesResponseDescriptor = $convert.base64Decode('Ch1HZXRXYXRlckF1dG9SZWNoYXJnZXNSZXNwb25zZRJJCg5hdXRvX3JlY2hhcmdlcxgBIAMoCzIiLnV0aWxpdHlwYXltZW50cy5XYXRlckF1dG9SZWNoYXJnZVINYXV0b1JlY2hhcmdlcw==');
@$core.Deprecated('Use updateWaterAutoRechargeRequestDescriptor instead')
const UpdateWaterAutoRechargeRequest$json = const {
  '1': 'UpdateWaterAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 4, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 5, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 6, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 7, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 8, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterAutoRechargeRequestDescriptor = $convert.base64Decode('Ch5VcGRhdGVXYXRlckF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIAEoCVIOYXV0b1JlY2hhcmdlSWQSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSHAoJZnJlcXVlbmN5GAMgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYBCABKAVSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYBSABKAVSCmRheU9mTW9udGgSHwoLbWF4X3JldHJpZXMYBiABKAVSCm1heFJldHJpZXMSJQoOZXhlY3V0aW9uX2hvdXIYByABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW9uX21pbnV0ZRgIIAEoBVIPZXhlY3V0aW9uTWludXRl');
@$core.Deprecated('Use updateWaterAutoRechargeResponseDescriptor instead')
const UpdateWaterAutoRechargeResponse$json = const {
  '1': 'UpdateWaterAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.WaterAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterAutoRechargeResponseDescriptor = $convert.base64Decode('Ch9VcGRhdGVXYXRlckF1dG9SZWNoYXJnZVJlc3BvbnNlEkcKDWF1dG9fcmVjaGFyZ2UYASABKAsyIi51dGlsaXR5cGF5bWVudHMuV2F0ZXJBdXRvUmVjaGFyZ2VSDGF1dG9SZWNoYXJnZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteWaterAutoRechargeRequestDescriptor instead')
const DeleteWaterAutoRechargeRequest$json = const {
  '1': 'DeleteWaterAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterAutoRechargeRequestDescriptor = $convert.base64Decode('Ch5EZWxldGVXYXRlckF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIAEoCVIOYXV0b1JlY2hhcmdlSWQ=');
@$core.Deprecated('Use deleteWaterAutoRechargeResponseDescriptor instead')
const DeleteWaterAutoRechargeResponse$json = const {
  '1': 'DeleteWaterAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterAutoRechargeResponseDescriptor = $convert.base64Decode('Ch9EZWxldGVXYXRlckF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use pauseWaterAutoRechargeRequestDescriptor instead')
const PauseWaterAutoRechargeRequest$json = const {
  '1': 'PauseWaterAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseWaterAutoRechargeRequestDescriptor = $convert.base64Decode('Ch1QYXVzZVdhdGVyQXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZA==');
@$core.Deprecated('Use pauseWaterAutoRechargeResponseDescriptor instead')
const PauseWaterAutoRechargeResponse$json = const {
  '1': 'PauseWaterAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseWaterAutoRechargeResponseDescriptor = $convert.base64Decode('Ch5QYXVzZVdhdGVyQXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use resumeWaterAutoRechargeRequestDescriptor instead')
const ResumeWaterAutoRechargeRequest$json = const {
  '1': 'ResumeWaterAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeWaterAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeWaterAutoRechargeRequestDescriptor = $convert.base64Decode('Ch5SZXN1bWVXYXRlckF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIAEoCVIOYXV0b1JlY2hhcmdlSWQ=');
@$core.Deprecated('Use resumeWaterAutoRechargeResponseDescriptor instead')
const ResumeWaterAutoRechargeResponse$json = const {
  '1': 'ResumeWaterAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeWaterAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeWaterAutoRechargeResponseDescriptor = $convert.base64Decode('Ch9SZXN1bWVXYXRlckF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use waterReminderDescriptor instead')
const WaterReminder$json = const {
  '1': 'WaterReminder',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 9, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 10, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'notified_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'notifiedAt'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `WaterReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waterReminderDescriptor = $convert.base64Decode('Cg1XYXRlclJlbWluZGVyEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUYBCABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgHIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAggASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYCSABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgKIAEoCVIOcmVjdXJyZW5jZVR5cGUSFgoGc3RhdHVzGAsgASgJUgZzdGF0dXMSOwoLbm90aWZpZWRfYXQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpub3RpZmllZEF0EjkKCmNyZWF0ZWRfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use createWaterReminderRequestDescriptor instead')
const CreateWaterReminderRequest$json = const {
  '1': 'CreateWaterReminderRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `CreateWaterReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaterReminderRequestDescriptor = $convert.base64Decode('ChpDcmVhdGVXYXRlclJlbWluZGVyUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIAEoCVINYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EiEKDGlzX3JlY3VycmluZxgHIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAggASgJUg5yZWN1cnJlbmNlVHlwZQ==');
@$core.Deprecated('Use createWaterReminderResponseDescriptor instead')
const CreateWaterReminderResponse$json = const {
  '1': 'CreateWaterReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.WaterReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateWaterReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createWaterReminderResponseDescriptor = $convert.base64Decode('ChtDcmVhdGVXYXRlclJlbWluZGVyUmVzcG9uc2USOgoIcmVtaW5kZXIYASABKAsyHi51dGlsaXR5cGF5bWVudHMuV2F0ZXJSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getWaterRemindersRequestDescriptor instead')
const GetWaterRemindersRequest$json = const {
  '1': 'GetWaterRemindersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetWaterRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterRemindersRequestDescriptor = $convert.base64Decode('ChhHZXRXYXRlclJlbWluZGVyc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSIQoMaW5jbHVkZV9wYXN0GAIgASgIUgtpbmNsdWRlUGFzdA==');
@$core.Deprecated('Use getWaterRemindersResponseDescriptor instead')
const GetWaterRemindersResponse$json = const {
  '1': 'GetWaterRemindersResponse',
  '2': const [
    const {'1': 'reminders', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.WaterReminder', '10': 'reminders'},
  ],
};

/// Descriptor for `GetWaterRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWaterRemindersResponseDescriptor = $convert.base64Decode('ChlHZXRXYXRlclJlbWluZGVyc1Jlc3BvbnNlEjwKCXJlbWluZGVycxgBIAMoCzIeLnV0aWxpdHlwYXltZW50cy5XYXRlclJlbWluZGVyUglyZW1pbmRlcnM=');
@$core.Deprecated('Use updateWaterReminderRequestDescriptor instead')
const UpdateWaterReminderRequest$json = const {
  '1': 'UpdateWaterReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateWaterReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterReminderRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVXYXRlclJlbWluZGVyUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcmVtaW5kZXJJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBiABKAlSCGN1cnJlbmN5EiEKDGlzX3JlY3VycmluZxgHIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAggASgJUg5yZWN1cnJlbmNlVHlwZQ==');
@$core.Deprecated('Use updateWaterReminderResponseDescriptor instead')
const UpdateWaterReminderResponse$json = const {
  '1': 'UpdateWaterReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.WaterReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateWaterReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWaterReminderResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVXYXRlclJlbWluZGVyUmVzcG9uc2USOgoIcmVtaW5kZXIYASABKAsyHi51dGlsaXR5cGF5bWVudHMuV2F0ZXJSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteWaterReminderRequestDescriptor instead')
const DeleteWaterReminderRequest$json = const {
  '1': 'DeleteWaterReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteWaterReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterReminderRequestDescriptor = $convert.base64Decode('ChpEZWxldGVXYXRlclJlbWluZGVyUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcmVtaW5kZXJJZA==');
@$core.Deprecated('Use deleteWaterReminderResponseDescriptor instead')
const DeleteWaterReminderResponse$json = const {
  '1': 'DeleteWaterReminderResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteWaterReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteWaterReminderResponseDescriptor = $convert.base64Decode('ChtEZWxldGVXYXRlclJlbWluZGVyUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use markWaterReminderCompleteRequestDescriptor instead')
const MarkWaterReminderCompleteRequest$json = const {
  '1': 'MarkWaterReminderCompleteRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkWaterReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markWaterReminderCompleteRequestDescriptor = $convert.base64Decode('CiBNYXJrV2F0ZXJSZW1pbmRlckNvbXBsZXRlUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcmVtaW5kZXJJZA==');
@$core.Deprecated('Use markWaterReminderCompleteResponseDescriptor instead')
const MarkWaterReminderCompleteResponse$json = const {
  '1': 'MarkWaterReminderCompleteResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkWaterReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markWaterReminderCompleteResponseDescriptor = $convert.base64Decode('CiFNYXJrV2F0ZXJSZW1pbmRlckNvbXBsZXRlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use intlAirtimeCountryDescriptor instead')
const IntlAirtimeCountry$json = const {
  '1': 'IntlAirtimeCountry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    const {'1': 'dial_code', '3': 4, '4': 1, '5': 9, '10': 'dialCode'},
    const {'1': 'currency_code', '3': 5, '4': 1, '5': 9, '10': 'currencyCode'},
    const {'1': 'currency_symbol', '3': 6, '4': 1, '5': 9, '10': 'currencySymbol'},
    const {'1': 'flag_emoji', '3': 7, '4': 1, '5': 9, '10': 'flagEmoji'},
    const {'1': 'is_active', '3': 8, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'reloadly_supported', '3': 9, '4': 1, '5': 8, '10': 'reloadlySupported'},
    const {'1': 'vtpass_supported', '3': 10, '4': 1, '5': 8, '10': 'vtpassSupported'},
    const {'1': 'operator_count', '3': 11, '4': 1, '5': 5, '10': 'operatorCount'},
  ],
};

/// Descriptor for `IntlAirtimeCountry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intlAirtimeCountryDescriptor = $convert.base64Decode('ChJJbnRsQWlydGltZUNvdW50cnkSDgoCaWQYASABKAlSAmlkEiEKDGNvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGUSIQoMY291bnRyeV9uYW1lGAMgASgJUgtjb3VudHJ5TmFtZRIbCglkaWFsX2NvZGUYBCABKAlSCGRpYWxDb2RlEiMKDWN1cnJlbmN5X2NvZGUYBSABKAlSDGN1cnJlbmN5Q29kZRInCg9jdXJyZW5jeV9zeW1ib2wYBiABKAlSDmN1cnJlbmN5U3ltYm9sEh0KCmZsYWdfZW1vamkYByABKAlSCWZsYWdFbW9qaRIbCglpc19hY3RpdmUYCCABKAhSCGlzQWN0aXZlEi0KEnJlbG9hZGx5X3N1cHBvcnRlZBgJIAEoCFIRcmVsb2FkbHlTdXBwb3J0ZWQSKQoQdnRwYXNzX3N1cHBvcnRlZBgKIAEoCFIPdnRwYXNzU3VwcG9ydGVkEiUKDm9wZXJhdG9yX2NvdW50GAsgASgFUg1vcGVyYXRvckNvdW50');
@$core.Deprecated('Use intlAirtimeOperatorDescriptor instead')
const IntlAirtimeOperator$json = const {
  '1': 'IntlAirtimeOperator',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    const {'1': 'operator_name', '3': 4, '4': 1, '5': 9, '10': 'operatorName'},
    const {'1': 'reloadly_operator_id', '3': 5, '4': 1, '5': 9, '10': 'reloadlyOperatorId'},
    const {'1': 'vtpass_operator_id', '3': 6, '4': 1, '5': 9, '10': 'vtpassOperatorId'},
    const {'1': 'denomination_type', '3': 7, '4': 1, '5': 9, '10': 'denominationType'},
    const {'1': 'sender_currency_code', '3': 8, '4': 1, '5': 9, '10': 'senderCurrencyCode'},
    const {'1': 'dest_currency_code', '3': 9, '4': 1, '5': 9, '10': 'destCurrencyCode'},
    const {'1': 'fx_rate', '3': 10, '4': 1, '5': 1, '10': 'fxRate'},
    const {'1': 'min_amount', '3': 11, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 12, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'local_min_amount', '3': 13, '4': 1, '5': 1, '10': 'localMinAmount'},
    const {'1': 'local_max_amount', '3': 14, '4': 1, '5': 1, '10': 'localMaxAmount'},
    const {'1': 'fixed_amounts', '3': 15, '4': 1, '5': 9, '10': 'fixedAmounts'},
    const {'1': 'local_fixed_amounts', '3': 16, '4': 1, '5': 9, '10': 'localFixedAmounts'},
    const {'1': 'supports_local_amounts', '3': 17, '4': 1, '5': 8, '10': 'supportsLocalAmounts'},
    const {'1': 'logo_url', '3': 18, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 19, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `IntlAirtimeOperator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intlAirtimeOperatorDescriptor = $convert.base64Decode('ChNJbnRsQWlydGltZU9wZXJhdG9yEg4KAmlkGAEgASgJUgJpZBIhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2RlEiEKDGNvdW50cnlfbmFtZRgDIAEoCVILY291bnRyeU5hbWUSIwoNb3BlcmF0b3JfbmFtZRgEIAEoCVIMb3BlcmF0b3JOYW1lEjAKFHJlbG9hZGx5X29wZXJhdG9yX2lkGAUgASgJUhJyZWxvYWRseU9wZXJhdG9ySWQSLAoSdnRwYXNzX29wZXJhdG9yX2lkGAYgASgJUhB2dHBhc3NPcGVyYXRvcklkEisKEWRlbm9taW5hdGlvbl90eXBlGAcgASgJUhBkZW5vbWluYXRpb25UeXBlEjAKFHNlbmRlcl9jdXJyZW5jeV9jb2RlGAggASgJUhJzZW5kZXJDdXJyZW5jeUNvZGUSLAoSZGVzdF9jdXJyZW5jeV9jb2RlGAkgASgJUhBkZXN0Q3VycmVuY3lDb2RlEhcKB2Z4X3JhdGUYCiABKAFSBmZ4UmF0ZRIdCgptaW5fYW1vdW50GAsgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgMIAEoAVIJbWF4QW1vdW50EigKEGxvY2FsX21pbl9hbW91bnQYDSABKAFSDmxvY2FsTWluQW1vdW50EigKEGxvY2FsX21heF9hbW91bnQYDiABKAFSDmxvY2FsTWF4QW1vdW50EiMKDWZpeGVkX2Ftb3VudHMYDyABKAlSDGZpeGVkQW1vdW50cxIuChNsb2NhbF9maXhlZF9hbW91bnRzGBAgASgJUhFsb2NhbEZpeGVkQW1vdW50cxI0ChZzdXBwb3J0c19sb2NhbF9hbW91bnRzGBEgASgIUhRzdXBwb3J0c0xvY2FsQW1vdW50cxIZCghsb2dvX3VybBgSIAEoCVIHbG9nb1VybBIbCglpc19hY3RpdmUYEyABKAhSCGlzQWN0aXZl');
@$core.Deprecated('Use getIntlAirtimeCountriesRequestDescriptor instead')
const GetIntlAirtimeCountriesRequest$json = const {
  '1': 'GetIntlAirtimeCountriesRequest',
  '2': const [
    const {'1': 'include_inactive', '3': 1, '4': 1, '5': 8, '10': 'includeInactive'},
  ],
};

/// Descriptor for `GetIntlAirtimeCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlAirtimeCountriesRequestDescriptor = $convert.base64Decode('Ch5HZXRJbnRsQWlydGltZUNvdW50cmllc1JlcXVlc3QSKQoQaW5jbHVkZV9pbmFjdGl2ZRgBIAEoCFIPaW5jbHVkZUluYWN0aXZl');
@$core.Deprecated('Use getIntlAirtimeCountriesResponseDescriptor instead')
const GetIntlAirtimeCountriesResponse$json = const {
  '1': 'GetIntlAirtimeCountriesResponse',
  '2': const [
    const {'1': 'countries', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.IntlAirtimeCountry', '10': 'countries'},
  ],
};

/// Descriptor for `GetIntlAirtimeCountriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlAirtimeCountriesResponseDescriptor = $convert.base64Decode('Ch9HZXRJbnRsQWlydGltZUNvdW50cmllc1Jlc3BvbnNlEkEKCWNvdW50cmllcxgBIAMoCzIjLnV0aWxpdHlwYXltZW50cy5JbnRsQWlydGltZUNvdW50cnlSCWNvdW50cmllcw==');
@$core.Deprecated('Use getIntlAirtimeOperatorsRequestDescriptor instead')
const GetIntlAirtimeOperatorsRequest$json = const {
  '1': 'GetIntlAirtimeOperatorsRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetIntlAirtimeOperatorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlAirtimeOperatorsRequestDescriptor = $convert.base64Decode('Ch5HZXRJbnRsQWlydGltZU9wZXJhdG9yc1JlcXVlc3QSIQoMY291bnRyeV9jb2RlGAEgASgJUgtjb3VudHJ5Q29kZQ==');
@$core.Deprecated('Use getIntlAirtimeOperatorsResponseDescriptor instead')
const GetIntlAirtimeOperatorsResponse$json = const {
  '1': 'GetIntlAirtimeOperatorsResponse',
  '2': const [
    const {'1': 'operators', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.IntlAirtimeOperator', '10': 'operators'},
    const {'1': 'country_name', '3': 2, '4': 1, '5': 9, '10': 'countryName'},
    const {'1': 'currency_code', '3': 3, '4': 1, '5': 9, '10': 'currencyCode'},
    const {'1': 'currency_symbol', '3': 4, '4': 1, '5': 9, '10': 'currencySymbol'},
  ],
};

/// Descriptor for `GetIntlAirtimeOperatorsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlAirtimeOperatorsResponseDescriptor = $convert.base64Decode('Ch9HZXRJbnRsQWlydGltZU9wZXJhdG9yc1Jlc3BvbnNlEkIKCW9wZXJhdG9ycxgBIAMoCzIkLnV0aWxpdHlwYXltZW50cy5JbnRsQWlydGltZU9wZXJhdG9yUglvcGVyYXRvcnMSIQoMY291bnRyeV9uYW1lGAIgASgJUgtjb3VudHJ5TmFtZRIjCg1jdXJyZW5jeV9jb2RlGAMgASgJUgxjdXJyZW5jeUNvZGUSJwoPY3VycmVuY3lfc3ltYm9sGAQgASgJUg5jdXJyZW5jeVN5bWJvbA==');
@$core.Deprecated('Use autoDetectIntlOperatorRequestDescriptor instead')
const AutoDetectIntlOperatorRequest$json = const {
  '1': 'AutoDetectIntlOperatorRequest',
  '2': const [
    const {'1': 'phone_number', '3': 1, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `AutoDetectIntlOperatorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoDetectIntlOperatorRequestDescriptor = $convert.base64Decode('Ch1BdXRvRGV0ZWN0SW50bE9wZXJhdG9yUmVxdWVzdBIhCgxwaG9uZV9udW1iZXIYASABKAlSC3Bob25lTnVtYmVyEiEKDGNvdW50cnlfY29kZRgCIAEoCVILY291bnRyeUNvZGU=');
@$core.Deprecated('Use autoDetectIntlOperatorResponseDescriptor instead')
const AutoDetectIntlOperatorResponse$json = const {
  '1': 'AutoDetectIntlOperatorResponse',
  '2': const [
    const {'1': 'operator', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.IntlAirtimeOperator', '10': 'operator'},
    const {'1': 'detected', '3': 2, '4': 1, '5': 8, '10': 'detected'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AutoDetectIntlOperatorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoDetectIntlOperatorResponseDescriptor = $convert.base64Decode('Ch5BdXRvRGV0ZWN0SW50bE9wZXJhdG9yUmVzcG9uc2USQAoIb3BlcmF0b3IYASABKAsyJC51dGlsaXR5cGF5bWVudHMuSW50bEFpcnRpbWVPcGVyYXRvclIIb3BlcmF0b3ISGgoIZGV0ZWN0ZWQYAiABKAhSCGRldGVjdGVkEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use buyIntlAirtimeRequestDescriptor instead')
const BuyIntlAirtimeRequest$json = const {
  '1': 'BuyIntlAirtimeRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'idempotency_key', '3': 2, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'operator_id', '3': 3, '4': 1, '5': 9, '10': 'operatorId'},
    const {'1': 'country_code', '3': 4, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'sender_currency', '3': 7, '4': 1, '5': 9, '10': 'senderCurrency'},
    const {'1': 'use_local_amount', '3': 8, '4': 1, '5': 1, '10': 'useLocalAmount'},
    const {'1': 'fx_rate_snapshot', '3': 9, '4': 1, '5': 1, '10': 'fxRateSnapshot'},
    const {'1': 'dest_currency', '3': 10, '4': 1, '5': 9, '10': 'destCurrency'},
    const {'1': 'dest_amount_estimate', '3': 11, '4': 1, '5': 1, '10': 'destAmountEstimate'},
    const {'1': 'transaction_pin', '3': 12, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `BuyIntlAirtimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyIntlAirtimeRequestDescriptor = $convert.base64Decode('ChVCdXlJbnRsQWlydGltZVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEicKD2lkZW1wb3RlbmN5X2tleRgCIAEoCVIOaWRlbXBvdGVuY3lLZXkSHwoLb3BlcmF0b3JfaWQYAyABKAlSCm9wZXJhdG9ySWQSIQoMY291bnRyeV9jb2RlGAQgASgJUgtjb3VudHJ5Q29kZRIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEhYKBmFtb3VudBgGIAEoAVIGYW1vdW50EicKD3NlbmRlcl9jdXJyZW5jeRgHIAEoCVIOc2VuZGVyQ3VycmVuY3kSKAoQdXNlX2xvY2FsX2Ftb3VudBgIIAEoAVIOdXNlTG9jYWxBbW91bnQSKAoQZnhfcmF0ZV9zbmFwc2hvdBgJIAEoAVIOZnhSYXRlU25hcHNob3QSIwoNZGVzdF9jdXJyZW5jeRgKIAEoCVIMZGVzdEN1cnJlbmN5EjAKFGRlc3RfYW1vdW50X2VzdGltYXRlGAsgASgBUhJkZXN0QW1vdW50RXN0aW1hdGUSJwoPdHJhbnNhY3Rpb25fcGluGAwgASgJUg50cmFuc2FjdGlvblBpbg==');
@$core.Deprecated('Use buyIntlAirtimeResponseDescriptor instead')
const BuyIntlAirtimeResponse$json = const {
  '1': 'BuyIntlAirtimeResponse',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount_paid', '3': 4, '4': 1, '5': 1, '10': 'amountPaid'},
    const {'1': 'sender_currency', '3': 5, '4': 1, '5': 9, '10': 'senderCurrency'},
    const {'1': 'delivered_amount', '3': 6, '4': 1, '5': 1, '10': 'deliveredAmount'},
    const {'1': 'delivered_currency', '3': 7, '4': 1, '5': 9, '10': 'deliveredCurrency'},
    const {'1': 'fx_rate_used', '3': 8, '4': 1, '5': 1, '10': 'fxRateUsed'},
    const {'1': 'operator_name', '3': 9, '4': 1, '5': 9, '10': 'operatorName'},
    const {'1': 'country_name', '3': 10, '4': 1, '5': 9, '10': 'countryName'},
    const {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'message', '3': 12, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `BuyIntlAirtimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyIntlAirtimeResponseDescriptor = $convert.base64Decode('ChZCdXlJbnRsQWlydGltZVJlc3BvbnNlEh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIfCgthbW91bnRfcGFpZBgEIAEoAVIKYW1vdW50UGFpZBInCg9zZW5kZXJfY3VycmVuY3kYBSABKAlSDnNlbmRlckN1cnJlbmN5EikKEGRlbGl2ZXJlZF9hbW91bnQYBiABKAFSD2RlbGl2ZXJlZEFtb3VudBItChJkZWxpdmVyZWRfY3VycmVuY3kYByABKAlSEWRlbGl2ZXJlZEN1cnJlbmN5EiAKDGZ4X3JhdGVfdXNlZBgIIAEoAVIKZnhSYXRlVXNlZBIjCg1vcGVyYXRvcl9uYW1lGAkgASgJUgxvcGVyYXRvck5hbWUSIQoMY291bnRyeV9uYW1lGAogASgJUgtjb3VudHJ5TmFtZRIhCgxwaG9uZV9udW1iZXIYCyABKAlSC3Bob25lTnVtYmVyEhgKB21lc3NhZ2UYDCABKAlSB21lc3NhZ2USHQoKY3JlYXRlZF9hdBgNIAEoCVIJY3JlYXRlZEF0');
@$core.Deprecated('Use intlDataBundleDescriptor instead')
const IntlDataBundle$json = const {
  '1': 'IntlDataBundle',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'operator_id', '3': 2, '4': 1, '5': 9, '10': 'operatorId'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'local_amount', '3': 4, '4': 1, '5': 1, '10': 'localAmount'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'dest_currency_code', '3': 6, '4': 1, '5': 9, '10': 'destCurrencyCode'},
    const {'1': 'sender_currency_code', '3': 7, '4': 1, '5': 9, '10': 'senderCurrencyCode'},
    const {'1': 'fx_rate', '3': 8, '4': 1, '5': 1, '10': 'fxRate'},
  ],
};

/// Descriptor for `IntlDataBundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intlDataBundleDescriptor = $convert.base64Decode('Cg5JbnRsRGF0YUJ1bmRsZRIOCgJpZBgBIAEoCVICaWQSHwoLb3BlcmF0b3JfaWQYAiABKAlSCm9wZXJhdG9ySWQSFgoGYW1vdW50GAMgASgBUgZhbW91bnQSIQoMbG9jYWxfYW1vdW50GAQgASgBUgtsb2NhbEFtb3VudBIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SLAoSZGVzdF9jdXJyZW5jeV9jb2RlGAYgASgJUhBkZXN0Q3VycmVuY3lDb2RlEjAKFHNlbmRlcl9jdXJyZW5jeV9jb2RlGAcgASgJUhJzZW5kZXJDdXJyZW5jeUNvZGUSFwoHZnhfcmF0ZRgIIAEoAVIGZnhSYXRl');
@$core.Deprecated('Use intlDataOperatorDescriptor instead')
const IntlDataOperator$json = const {
  '1': 'IntlDataOperator',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    const {'1': 'operator_name', '3': 4, '4': 1, '5': 9, '10': 'operatorName'},
    const {'1': 'reloadly_operator_id', '3': 5, '4': 1, '5': 9, '10': 'reloadlyOperatorId'},
    const {'1': 'sender_currency_code', '3': 6, '4': 1, '5': 9, '10': 'senderCurrencyCode'},
    const {'1': 'dest_currency_code', '3': 7, '4': 1, '5': 9, '10': 'destCurrencyCode'},
    const {'1': 'fx_rate', '3': 8, '4': 1, '5': 1, '10': 'fxRate'},
    const {'1': 'logo_url', '3': 9, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 10, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'bundle_count', '3': 11, '4': 1, '5': 5, '10': 'bundleCount'},
  ],
};

/// Descriptor for `IntlDataOperator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intlDataOperatorDescriptor = $convert.base64Decode('ChBJbnRsRGF0YU9wZXJhdG9yEg4KAmlkGAEgASgJUgJpZBIhCgxjb3VudHJ5X2NvZGUYAiABKAlSC2NvdW50cnlDb2RlEiEKDGNvdW50cnlfbmFtZRgDIAEoCVILY291bnRyeU5hbWUSIwoNb3BlcmF0b3JfbmFtZRgEIAEoCVIMb3BlcmF0b3JOYW1lEjAKFHJlbG9hZGx5X29wZXJhdG9yX2lkGAUgASgJUhJyZWxvYWRseU9wZXJhdG9ySWQSMAoUc2VuZGVyX2N1cnJlbmN5X2NvZGUYBiABKAlSEnNlbmRlckN1cnJlbmN5Q29kZRIsChJkZXN0X2N1cnJlbmN5X2NvZGUYByABKAlSEGRlc3RDdXJyZW5jeUNvZGUSFwoHZnhfcmF0ZRgIIAEoAVIGZnhSYXRlEhkKCGxvZ29fdXJsGAkgASgJUgdsb2dvVXJsEhsKCWlzX2FjdGl2ZRgKIAEoCFIIaXNBY3RpdmUSIQoMYnVuZGxlX2NvdW50GAsgASgFUgtidW5kbGVDb3VudA==');
@$core.Deprecated('Use getIntlDataOperatorsRequestDescriptor instead')
const GetIntlDataOperatorsRequest$json = const {
  '1': 'GetIntlDataOperatorsRequest',
  '2': const [
    const {'1': 'country_code', '3': 1, '4': 1, '5': 9, '10': 'countryCode'},
  ],
};

/// Descriptor for `GetIntlDataOperatorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlDataOperatorsRequestDescriptor = $convert.base64Decode('ChtHZXRJbnRsRGF0YU9wZXJhdG9yc1JlcXVlc3QSIQoMY291bnRyeV9jb2RlGAEgASgJUgtjb3VudHJ5Q29kZQ==');
@$core.Deprecated('Use getIntlDataOperatorsResponseDescriptor instead')
const GetIntlDataOperatorsResponse$json = const {
  '1': 'GetIntlDataOperatorsResponse',
  '2': const [
    const {'1': 'operators', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.IntlDataOperator', '10': 'operators'},
    const {'1': 'country_name', '3': 2, '4': 1, '5': 9, '10': 'countryName'},
    const {'1': 'currency_code', '3': 3, '4': 1, '5': 9, '10': 'currencyCode'},
    const {'1': 'currency_symbol', '3': 4, '4': 1, '5': 9, '10': 'currencySymbol'},
  ],
};

/// Descriptor for `GetIntlDataOperatorsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlDataOperatorsResponseDescriptor = $convert.base64Decode('ChxHZXRJbnRsRGF0YU9wZXJhdG9yc1Jlc3BvbnNlEj8KCW9wZXJhdG9ycxgBIAMoCzIhLnV0aWxpdHlwYXltZW50cy5JbnRsRGF0YU9wZXJhdG9yUglvcGVyYXRvcnMSIQoMY291bnRyeV9uYW1lGAIgASgJUgtjb3VudHJ5TmFtZRIjCg1jdXJyZW5jeV9jb2RlGAMgASgJUgxjdXJyZW5jeUNvZGUSJwoPY3VycmVuY3lfc3ltYm9sGAQgASgJUg5jdXJyZW5jeVN5bWJvbA==');
@$core.Deprecated('Use getIntlDataBundlesRequestDescriptor instead')
const GetIntlDataBundlesRequest$json = const {
  '1': 'GetIntlDataBundlesRequest',
  '2': const [
    const {'1': 'operator_id', '3': 1, '4': 1, '5': 9, '10': 'operatorId'},
  ],
};

/// Descriptor for `GetIntlDataBundlesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlDataBundlesRequestDescriptor = $convert.base64Decode('ChlHZXRJbnRsRGF0YUJ1bmRsZXNSZXF1ZXN0Eh8KC29wZXJhdG9yX2lkGAEgASgJUgpvcGVyYXRvcklk');
@$core.Deprecated('Use getIntlDataBundlesResponseDescriptor instead')
const GetIntlDataBundlesResponse$json = const {
  '1': 'GetIntlDataBundlesResponse',
  '2': const [
    const {'1': 'bundles', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.IntlDataBundle', '10': 'bundles'},
    const {'1': 'operator', '3': 2, '4': 1, '5': 11, '6': '.utilitypayments.IntlDataOperator', '10': 'operator'},
  ],
};

/// Descriptor for `GetIntlDataBundlesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIntlDataBundlesResponseDescriptor = $convert.base64Decode('ChpHZXRJbnRsRGF0YUJ1bmRsZXNSZXNwb25zZRI5CgdidW5kbGVzGAEgAygLMh8udXRpbGl0eXBheW1lbnRzLkludGxEYXRhQnVuZGxlUgdidW5kbGVzEj0KCG9wZXJhdG9yGAIgASgLMiEudXRpbGl0eXBheW1lbnRzLkludGxEYXRhT3BlcmF0b3JSCG9wZXJhdG9y');
@$core.Deprecated('Use buyIntlDataRequestDescriptor instead')
const BuyIntlDataRequest$json = const {
  '1': 'BuyIntlDataRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'idempotency_key', '3': 2, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'operator_id', '3': 3, '4': 1, '5': 9, '10': 'operatorId'},
    const {'1': 'bundle_id', '3': 4, '4': 1, '5': 9, '10': 'bundleId'},
    const {'1': 'country_code', '3': 5, '4': 1, '5': 9, '10': 'countryCode'},
    const {'1': 'phone_number', '3': 6, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'sender_currency', '3': 8, '4': 1, '5': 9, '10': 'senderCurrency'},
    const {'1': 'dest_amount', '3': 9, '4': 1, '5': 1, '10': 'destAmount'},
    const {'1': 'dest_currency', '3': 10, '4': 1, '5': 9, '10': 'destCurrency'},
    const {'1': 'fx_rate_snapshot', '3': 11, '4': 1, '5': 1, '10': 'fxRateSnapshot'},
    const {'1': 'transaction_pin', '3': 12, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `BuyIntlDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyIntlDataRequestDescriptor = $convert.base64Decode('ChJCdXlJbnRsRGF0YVJlcXVlc3QSHQoKYWNjb3VudF9pZBgBIAEoCVIJYWNjb3VudElkEicKD2lkZW1wb3RlbmN5X2tleRgCIAEoCVIOaWRlbXBvdGVuY3lLZXkSHwoLb3BlcmF0b3JfaWQYAyABKAlSCm9wZXJhdG9ySWQSGwoJYnVuZGxlX2lkGAQgASgJUghidW5kbGVJZBIhCgxjb3VudHJ5X2NvZGUYBSABKAlSC2NvdW50cnlDb2RlEiEKDHBob25lX251bWJlchgGIAEoCVILcGhvbmVOdW1iZXISFgoGYW1vdW50GAcgASgBUgZhbW91bnQSJwoPc2VuZGVyX2N1cnJlbmN5GAggASgJUg5zZW5kZXJDdXJyZW5jeRIfCgtkZXN0X2Ftb3VudBgJIAEoAVIKZGVzdEFtb3VudBIjCg1kZXN0X2N1cnJlbmN5GAogASgJUgxkZXN0Q3VycmVuY3kSKAoQZnhfcmF0ZV9zbmFwc2hvdBgLIAEoAVIOZnhSYXRlU25hcHNob3QSJwoPdHJhbnNhY3Rpb25fcGluGAwgASgJUg50cmFuc2FjdGlvblBpbg==');
@$core.Deprecated('Use buyIntlDataResponseDescriptor instead')
const BuyIntlDataResponse$json = const {
  '1': 'BuyIntlDataResponse',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'amount_paid', '3': 4, '4': 1, '5': 1, '10': 'amountPaid'},
    const {'1': 'sender_currency', '3': 5, '4': 1, '5': 9, '10': 'senderCurrency'},
    const {'1': 'delivered_amount', '3': 6, '4': 1, '5': 1, '10': 'deliveredAmount'},
    const {'1': 'delivered_currency', '3': 7, '4': 1, '5': 9, '10': 'deliveredCurrency'},
    const {'1': 'fx_rate_used', '3': 8, '4': 1, '5': 1, '10': 'fxRateUsed'},
    const {'1': 'operator_name', '3': 9, '4': 1, '5': 9, '10': 'operatorName'},
    const {'1': 'country_name', '3': 10, '4': 1, '5': 9, '10': 'countryName'},
    const {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'bundle_description', '3': 12, '4': 1, '5': 9, '10': 'bundleDescription'},
    const {'1': 'message', '3': 13, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `BuyIntlDataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buyIntlDataResponseDescriptor = $convert.base64Decode('ChNCdXlJbnRsRGF0YVJlc3BvbnNlEh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYAyABKAlSBnN0YXR1cxIfCgthbW91bnRfcGFpZBgEIAEoAVIKYW1vdW50UGFpZBInCg9zZW5kZXJfY3VycmVuY3kYBSABKAlSDnNlbmRlckN1cnJlbmN5EikKEGRlbGl2ZXJlZF9hbW91bnQYBiABKAFSD2RlbGl2ZXJlZEFtb3VudBItChJkZWxpdmVyZWRfY3VycmVuY3kYByABKAlSEWRlbGl2ZXJlZEN1cnJlbmN5EiAKDGZ4X3JhdGVfdXNlZBgIIAEoAVIKZnhSYXRlVXNlZBIjCg1vcGVyYXRvcl9uYW1lGAkgASgJUgxvcGVyYXRvck5hbWUSIQoMY291bnRyeV9uYW1lGAogASgJUgtjb3VudHJ5TmFtZRIhCgxwaG9uZV9udW1iZXIYCyABKAlSC3Bob25lTnVtYmVyEi0KEmJ1bmRsZV9kZXNjcmlwdGlvbhgMIAEoCVIRYnVuZGxlRGVzY3JpcHRpb24SGAoHbWVzc2FnZRgNIAEoCVIHbWVzc2FnZRIdCgpjcmVhdGVkX2F0GA4gASgJUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use educationBeneficiaryDescriptor instead')
const EducationBeneficiary$json = const {
  '1': 'EducationBeneficiary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'candidate_number', '3': 3, '4': 1, '5': 9, '10': 'candidateNumber'},
    const {'1': 'exam_type', '3': 4, '4': 1, '5': 9, '10': 'examType'},
    const {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 6, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'nickname', '3': 7, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'candidate_name', '3': 8, '4': 1, '5': 9, '10': 'candidateName'},
    const {'1': 'last_amount', '3': 9, '4': 1, '5': 1, '10': 'lastAmount'},
    const {'1': 'last_purchase_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastPurchaseAt'},
    const {'1': 'purchase_count', '3': 11, '4': 1, '5': 5, '10': 'purchaseCount'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `EducationBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List educationBeneficiaryDescriptor = $convert.base64Decode('ChRFZHVjYXRpb25CZW5lZmljaWFyeRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEikKEGNhbmRpZGF0ZV9udW1iZXIYAyABKAlSD2NhbmRpZGF0ZU51bWJlchIbCglleGFtX3R5cGUYBCABKAlSCGV4YW1UeXBlEiMKDXByb3ZpZGVyX2NvZGUYBSABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAYgASgJUgxwcm92aWRlck5hbWUSGgoIbmlja25hbWUYByABKAlSCG5pY2tuYW1lEiUKDmNhbmRpZGF0ZV9uYW1lGAggASgJUg1jYW5kaWRhdGVOYW1lEh8KC2xhc3RfYW1vdW50GAkgASgBUgpsYXN0QW1vdW50EkQKEGxhc3RfcHVyY2hhc2VfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg5sYXN0UHVyY2hhc2VBdBIlCg5wdXJjaGFzZV9jb3VudBgLIAEoBVINcHVyY2hhc2VDb3VudBI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use saveEducationBeneficiaryRequestDescriptor instead')
const SaveEducationBeneficiaryRequest$json = const {
  '1': 'SaveEducationBeneficiaryRequest',
  '2': const [
    const {'1': 'candidate_number', '3': 1, '4': 1, '5': 9, '10': 'candidateNumber'},
    const {'1': 'exam_type', '3': 2, '4': 1, '5': 9, '10': 'examType'},
    const {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'nickname', '3': 5, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'candidate_name', '3': 6, '4': 1, '5': 9, '10': 'candidateName'},
  ],
};

/// Descriptor for `SaveEducationBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveEducationBeneficiaryRequestDescriptor = $convert.base64Decode('Ch9TYXZlRWR1Y2F0aW9uQmVuZWZpY2lhcnlSZXF1ZXN0EikKEGNhbmRpZGF0ZV9udW1iZXIYASABKAlSD2NhbmRpZGF0ZU51bWJlchIbCglleGFtX3R5cGUYAiABKAlSCGV4YW1UeXBlEiMKDXByb3ZpZGVyX2NvZGUYAyABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAQgASgJUgxwcm92aWRlck5hbWUSGgoIbmlja25hbWUYBSABKAlSCG5pY2tuYW1lEiUKDmNhbmRpZGF0ZV9uYW1lGAYgASgJUg1jYW5kaWRhdGVOYW1l');
@$core.Deprecated('Use saveEducationBeneficiaryResponseDescriptor instead')
const SaveEducationBeneficiaryResponse$json = const {
  '1': 'SaveEducationBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.EducationBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveEducationBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveEducationBeneficiaryResponseDescriptor = $convert.base64Decode('CiBTYXZlRWR1Y2F0aW9uQmVuZWZpY2lhcnlSZXNwb25zZRJHCgtiZW5lZmljaWFyeRgBIAEoCzIlLnV0aWxpdHlwYXltZW50cy5FZHVjYXRpb25CZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getEducationBeneficiariesRequestDescriptor instead')
const GetEducationBeneficiariesRequest$json = const {
  '1': 'GetEducationBeneficiariesRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetEducationBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationBeneficiariesRequestDescriptor = $convert.base64Decode('CiBHZXRFZHVjYXRpb25CZW5lZmljaWFyaWVzUmVxdWVzdBIjCg1wcm92aWRlcl9jb2RlGAEgASgJUgxwcm92aWRlckNvZGU=');
@$core.Deprecated('Use getEducationBeneficiariesResponseDescriptor instead')
const GetEducationBeneficiariesResponse$json = const {
  '1': 'GetEducationBeneficiariesResponse',
  '2': const [
    const {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.EducationBeneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `GetEducationBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationBeneficiariesResponseDescriptor = $convert.base64Decode('CiFHZXRFZHVjYXRpb25CZW5lZmljaWFyaWVzUmVzcG9uc2USSwoNYmVuZWZpY2lhcmllcxgBIAMoCzIlLnV0aWxpdHlwYXltZW50cy5FZHVjYXRpb25CZW5lZmljaWFyeVINYmVuZWZpY2lhcmllcw==');
@$core.Deprecated('Use updateEducationBeneficiaryRequestDescriptor instead')
const UpdateEducationBeneficiaryRequest$json = const {
  '1': 'UpdateEducationBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateEducationBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEducationBeneficiaryRequestDescriptor = $convert.base64Decode('CiFVcGRhdGVFZHVjYXRpb25CZW5lZmljaWFyeVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEhoKCG5pY2tuYW1lGAIgASgJUghuaWNrbmFtZQ==');
@$core.Deprecated('Use updateEducationBeneficiaryResponseDescriptor instead')
const UpdateEducationBeneficiaryResponse$json = const {
  '1': 'UpdateEducationBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.EducationBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateEducationBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEducationBeneficiaryResponseDescriptor = $convert.base64Decode('CiJVcGRhdGVFZHVjYXRpb25CZW5lZmljaWFyeVJlc3BvbnNlEkcKC2JlbmVmaWNpYXJ5GAEgASgLMiUudXRpbGl0eXBheW1lbnRzLkVkdWNhdGlvbkJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteEducationBeneficiaryRequestDescriptor instead')
const DeleteEducationBeneficiaryRequest$json = const {
  '1': 'DeleteEducationBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteEducationBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEducationBeneficiaryRequestDescriptor = $convert.base64Decode('CiFEZWxldGVFZHVjYXRpb25CZW5lZmljaWFyeVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use deleteEducationBeneficiaryResponseDescriptor instead')
const DeleteEducationBeneficiaryResponse$json = const {
  '1': 'DeleteEducationBeneficiaryResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteEducationBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEducationBeneficiaryResponseDescriptor = $convert.base64Decode('CiJEZWxldGVFZHVjYXRpb25CZW5lZmljaWFyeVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use educationReminderDescriptor instead')
const EducationReminder$json = const {
  '1': 'EducationReminder',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 9, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 10, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'notified_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'notifiedAt'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `EducationReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List educationReminderDescriptor = $convert.base64Decode('ChFFZHVjYXRpb25SZW1pbmRlchIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiUKDmJlbmVmaWNpYXJ5X2lkGAMgASgJUg1iZW5lZmljaWFyeUlkEhQKBXRpdGxlGAQgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SPwoNcmVtaW5kZXJfZGF0ZRgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlbWluZGVyRGF0ZRIWCgZhbW91bnQYByABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3kSIQoMaXNfcmVjdXJyaW5nGAkgASgIUgtpc1JlY3VycmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCiABKAlSDnJlY3VycmVuY2VUeXBlEhYKBnN0YXR1cxgLIAEoCVIGc3RhdHVzEjsKC25vdGlmaWVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbm90aWZpZWRBdBI5CgpjcmVhdGVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use createEducationReminderRequestDescriptor instead')
const CreateEducationReminderRequest$json = const {
  '1': 'CreateEducationReminderRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `CreateEducationReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createEducationReminderRequestDescriptor = $convert.base64Decode('Ch5DcmVhdGVFZHVjYXRpb25SZW1pbmRlclJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgIIAEoCVIOcmVjdXJyZW5jZVR5cGU=');
@$core.Deprecated('Use createEducationReminderResponseDescriptor instead')
const CreateEducationReminderResponse$json = const {
  '1': 'CreateEducationReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.EducationReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateEducationReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createEducationReminderResponseDescriptor = $convert.base64Decode('Ch9DcmVhdGVFZHVjYXRpb25SZW1pbmRlclJlc3BvbnNlEj4KCHJlbWluZGVyGAEgASgLMiIudXRpbGl0eXBheW1lbnRzLkVkdWNhdGlvblJlbWluZGVyUghyZW1pbmRlchIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getEducationRemindersRequestDescriptor instead')
const GetEducationRemindersRequest$json = const {
  '1': 'GetEducationRemindersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetEducationRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationRemindersRequestDescriptor = $convert.base64Decode('ChxHZXRFZHVjYXRpb25SZW1pbmRlcnNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEiEKDGluY2x1ZGVfcGFzdBgCIAEoCFILaW5jbHVkZVBhc3Q=');
@$core.Deprecated('Use getEducationRemindersResponseDescriptor instead')
const GetEducationRemindersResponse$json = const {
  '1': 'GetEducationRemindersResponse',
  '2': const [
    const {'1': 'reminders', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.EducationReminder', '10': 'reminders'},
  ],
};

/// Descriptor for `GetEducationRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEducationRemindersResponseDescriptor = $convert.base64Decode('Ch1HZXRFZHVjYXRpb25SZW1pbmRlcnNSZXNwb25zZRJACglyZW1pbmRlcnMYASADKAsyIi51dGlsaXR5cGF5bWVudHMuRWR1Y2F0aW9uUmVtaW5kZXJSCXJlbWluZGVycw==');
@$core.Deprecated('Use updateEducationReminderRequestDescriptor instead')
const UpdateEducationReminderRequest$json = const {
  '1': 'UpdateEducationReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateEducationReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEducationReminderRequestDescriptor = $convert.base64Decode('Ch5VcGRhdGVFZHVjYXRpb25SZW1pbmRlclJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbWluZGVySWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgIIAEoCVIOcmVjdXJyZW5jZVR5cGU=');
@$core.Deprecated('Use updateEducationReminderResponseDescriptor instead')
const UpdateEducationReminderResponse$json = const {
  '1': 'UpdateEducationReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.EducationReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateEducationReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEducationReminderResponseDescriptor = $convert.base64Decode('Ch9VcGRhdGVFZHVjYXRpb25SZW1pbmRlclJlc3BvbnNlEj4KCHJlbWluZGVyGAEgASgLMiIudXRpbGl0eXBheW1lbnRzLkVkdWNhdGlvblJlbWluZGVyUghyZW1pbmRlchIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteEducationReminderRequestDescriptor instead')
const DeleteEducationReminderRequest$json = const {
  '1': 'DeleteEducationReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteEducationReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEducationReminderRequestDescriptor = $convert.base64Decode('Ch5EZWxldGVFZHVjYXRpb25SZW1pbmRlclJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbWluZGVySWQ=');
@$core.Deprecated('Use deleteEducationReminderResponseDescriptor instead')
const DeleteEducationReminderResponse$json = const {
  '1': 'DeleteEducationReminderResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteEducationReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEducationReminderResponseDescriptor = $convert.base64Decode('Ch9EZWxldGVFZHVjYXRpb25SZW1pbmRlclJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use markEducationReminderCompleteRequestDescriptor instead')
const MarkEducationReminderCompleteRequest$json = const {
  '1': 'MarkEducationReminderCompleteRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkEducationReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markEducationReminderCompleteRequestDescriptor = $convert.base64Decode('CiRNYXJrRWR1Y2F0aW9uUmVtaW5kZXJDb21wbGV0ZVJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbWluZGVySWQ=');
@$core.Deprecated('Use markEducationReminderCompleteResponseDescriptor instead')
const MarkEducationReminderCompleteResponse$json = const {
  '1': 'MarkEducationReminderCompleteResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkEducationReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markEducationReminderCompleteResponseDescriptor = $convert.base64Decode('CiVNYXJrRWR1Y2F0aW9uUmVtaW5kZXJDb21wbGV0ZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use internetBeneficiaryDescriptor instead')
const InternetBeneficiary$json = const {
  '1': 'InternetBeneficiary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'account_number', '3': 3, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'provider_code', '3': 4, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 5, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'nickname', '3': 6, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'last_amount', '3': 7, '4': 1, '5': 1, '10': 'lastAmount'},
    const {'1': 'last_package_id', '3': 8, '4': 1, '5': 9, '10': 'lastPackageId'},
    const {'1': 'last_plan_name', '3': 9, '4': 1, '5': 9, '10': 'lastPlanName'},
    const {'1': 'last_topup_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastTopupAt'},
    const {'1': 'topup_count', '3': 11, '4': 1, '5': 5, '10': 'topupCount'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `InternetBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetBeneficiaryDescriptor = $convert.base64Decode('ChNJbnRlcm5ldEJlbmVmaWNpYXJ5Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYWNjb3VudF9udW1iZXIYAyABKAlSDWFjY291bnROdW1iZXISIwoNcHJvdmlkZXJfY29kZRgEIAEoCVIMcHJvdmlkZXJDb2RlEiMKDXByb3ZpZGVyX25hbWUYBSABKAlSDHByb3ZpZGVyTmFtZRIaCghuaWNrbmFtZRgGIAEoCVIIbmlja25hbWUSHwoLbGFzdF9hbW91bnQYByABKAFSCmxhc3RBbW91bnQSJgoPbGFzdF9wYWNrYWdlX2lkGAggASgJUg1sYXN0UGFja2FnZUlkEiQKDmxhc3RfcGxhbl9uYW1lGAkgASgJUgxsYXN0UGxhbk5hbWUSPgoNbGFzdF90b3B1cF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RUb3B1cEF0Eh8KC3RvcHVwX2NvdW50GAsgASgFUgp0b3B1cENvdW50EjkKCmNyZWF0ZWRfYXQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use saveInternetBeneficiaryRequestDescriptor instead')
const SaveInternetBeneficiaryRequest$json = const {
  '1': 'SaveInternetBeneficiaryRequest',
  '2': const [
    const {'1': 'account_number', '3': 1, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 3, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `SaveInternetBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveInternetBeneficiaryRequestDescriptor = $convert.base64Decode('Ch5TYXZlSW50ZXJuZXRCZW5lZmljaWFyeVJlcXVlc3QSJQoOYWNjb3VudF9udW1iZXIYASABKAlSDWFjY291bnROdW1iZXISIwoNcHJvdmlkZXJfY29kZRgCIAEoCVIMcHJvdmlkZXJDb2RlEiMKDXByb3ZpZGVyX25hbWUYAyABKAlSDHByb3ZpZGVyTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWU=');
@$core.Deprecated('Use saveInternetBeneficiaryResponseDescriptor instead')
const SaveInternetBeneficiaryResponse$json = const {
  '1': 'SaveInternetBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.InternetBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveInternetBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveInternetBeneficiaryResponseDescriptor = $convert.base64Decode('Ch9TYXZlSW50ZXJuZXRCZW5lZmljaWFyeVJlc3BvbnNlEkYKC2JlbmVmaWNpYXJ5GAEgASgLMiQudXRpbGl0eXBheW1lbnRzLkludGVybmV0QmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getInternetBeneficiariesRequestDescriptor instead')
const GetInternetBeneficiariesRequest$json = const {
  '1': 'GetInternetBeneficiariesRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetInternetBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetBeneficiariesRequestDescriptor = $convert.base64Decode('Ch9HZXRJbnRlcm5ldEJlbmVmaWNpYXJpZXNSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKAlSDHByb3ZpZGVyQ29kZQ==');
@$core.Deprecated('Use getInternetBeneficiariesResponseDescriptor instead')
const GetInternetBeneficiariesResponse$json = const {
  '1': 'GetInternetBeneficiariesResponse',
  '2': const [
    const {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.InternetBeneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `GetInternetBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetBeneficiariesResponseDescriptor = $convert.base64Decode('CiBHZXRJbnRlcm5ldEJlbmVmaWNpYXJpZXNSZXNwb25zZRJKCg1iZW5lZmljaWFyaWVzGAEgAygLMiQudXRpbGl0eXBheW1lbnRzLkludGVybmV0QmVuZWZpY2lhcnlSDWJlbmVmaWNpYXJpZXM=');
@$core.Deprecated('Use updateInternetBeneficiaryRequestDescriptor instead')
const UpdateInternetBeneficiaryRequest$json = const {
  '1': 'UpdateInternetBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `UpdateInternetBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetBeneficiaryRequestDescriptor = $convert.base64Decode('CiBVcGRhdGVJbnRlcm5ldEJlbmVmaWNpYXJ5UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSGgoIbmlja25hbWUYAiABKAlSCG5pY2tuYW1l');
@$core.Deprecated('Use updateInternetBeneficiaryResponseDescriptor instead')
const UpdateInternetBeneficiaryResponse$json = const {
  '1': 'UpdateInternetBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.InternetBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInternetBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetBeneficiaryResponseDescriptor = $convert.base64Decode('CiFVcGRhdGVJbnRlcm5ldEJlbmVmaWNpYXJ5UmVzcG9uc2USRgoLYmVuZWZpY2lhcnkYASABKAsyJC51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRCZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteInternetBeneficiaryRequestDescriptor instead')
const DeleteInternetBeneficiaryRequest$json = const {
  '1': 'DeleteInternetBeneficiaryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteInternetBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetBeneficiaryRequestDescriptor = $convert.base64Decode('CiBEZWxldGVJbnRlcm5ldEJlbmVmaWNpYXJ5UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use deleteInternetBeneficiaryResponseDescriptor instead')
const DeleteInternetBeneficiaryResponse$json = const {
  '1': 'DeleteInternetBeneficiaryResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInternetBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetBeneficiaryResponseDescriptor = $convert.base64Decode('CiFEZWxldGVJbnRlcm5ldEJlbmVmaWNpYXJ5UmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use internetAutoRechargeDescriptor instead')
const InternetAutoRecharge$json = const {
  '1': 'InternetAutoRecharge',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'account_number', '3': 4, '4': 1, '5': 9, '10': 'accountNumber'},
    const {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 6, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'package_id', '3': 7, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'plan_name', '3': 8, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'amount', '3': 9, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 10, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 11, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 12, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 13, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'execution_hour', '3': 14, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 15, '4': 1, '5': 5, '10': 'executionMinute'},
    const {'1': 'next_run_date', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRunDate'},
    const {'1': 'last_run_date', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastRunDate'},
    const {'1': 'status', '3': 18, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'failure_count', '3': 19, '4': 1, '5': 5, '10': 'failureCount'},
    const {'1': 'max_retries', '3': 20, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'created_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'beneficiary', '3': 22, '4': 1, '5': 11, '6': '.utilitypayments.InternetBeneficiary', '10': 'beneficiary'},
  ],
};

/// Descriptor for `InternetAutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetAutoRechargeDescriptor = $convert.base64Decode('ChRJbnRlcm5ldEF1dG9SZWNoYXJnZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiUKDmJlbmVmaWNpYXJ5X2lkGAMgASgJUg1iZW5lZmljaWFyeUlkEiUKDmFjY291bnRfbnVtYmVyGAQgASgJUg1hY2NvdW50TnVtYmVyEiMKDXByb3ZpZGVyX2NvZGUYBSABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAYgASgJUgxwcm92aWRlck5hbWUSHQoKcGFja2FnZV9pZBgHIAEoCVIJcGFja2FnZUlkEhsKCXBsYW5fbmFtZRgIIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAkgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYCiABKAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgLIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAwgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGA0gASgFUgpkYXlPZk1vbnRoEiUKDmV4ZWN1dGlvbl9ob3VyGA4gASgFUg1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYDyABKAVSD2V4ZWN1dGlvbk1pbnV0ZRI+Cg1uZXh0X3J1bl9kYXRlGBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbmV4dFJ1bkRhdGUSPgoNbGFzdF9ydW5fZGF0ZRgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RSdW5EYXRlEhYKBnN0YXR1cxgSIAEoCVIGc3RhdHVzEiMKDWZhaWx1cmVfY291bnQYEyABKAVSDGZhaWx1cmVDb3VudBIfCgttYXhfcmV0cmllcxgUIAEoBVIKbWF4UmV0cmllcxI5CgpjcmVhdGVkX2F0GBUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EkYKC2JlbmVmaWNpYXJ5GBYgASgLMiQudXRpbGl0eXBheW1lbnRzLkludGVybmV0QmVuZWZpY2lhcnlSC2JlbmVmaWNpYXJ5');
@$core.Deprecated('Use createInternetAutoRechargeRequestDescriptor instead')
const CreateInternetAutoRechargeRequest$json = const {
  '1': 'CreateInternetAutoRechargeRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'package_id', '3': 2, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'plan_name', '3': 3, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 5, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 6, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 7, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 8, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 9, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 10, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 11, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `CreateInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInternetAutoRechargeRequestDescriptor = $convert.base64Decode('CiFDcmVhdGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbmVmaWNpYXJ5SWQSHQoKcGFja2FnZV9pZBgCIAEoCVIJcGFja2FnZUlkEhsKCXBsYW5fbmFtZRgDIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYBSABKAlSCGN1cnJlbmN5EhwKCWZyZXF1ZW5jeRgGIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAcgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAggASgFUgpkYXlPZk1vbnRoEh8KC21heF9yZXRyaWVzGAkgASgFUgptYXhSZXRyaWVzEiUKDmV4ZWN1dGlvbl9ob3VyGAogASgFUg1leGVjdXRpb25Ib3VyEikKEGV4ZWN1dGlvbl9taW51dGUYCyABKAVSD2V4ZWN1dGlvbk1pbnV0ZQ==');
@$core.Deprecated('Use createInternetAutoRechargeResponseDescriptor instead')
const CreateInternetAutoRechargeResponse$json = const {
  '1': 'CreateInternetAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.InternetAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInternetAutoRechargeResponseDescriptor = $convert.base64Decode('CiJDcmVhdGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlc3BvbnNlEkoKDWF1dG9fcmVjaGFyZ2UYASABKAsyJS51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRBdXRvUmVjaGFyZ2VSDGF1dG9SZWNoYXJnZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getInternetAutoRechargesRequestDescriptor instead')
const GetInternetAutoRechargesRequest$json = const {
  '1': 'GetInternetAutoRechargesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetInternetAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetAutoRechargesRequestDescriptor = $convert.base64Decode('Ch9HZXRJbnRlcm5ldEF1dG9SZWNoYXJnZXNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');
@$core.Deprecated('Use getInternetAutoRechargesResponseDescriptor instead')
const GetInternetAutoRechargesResponse$json = const {
  '1': 'GetInternetAutoRechargesResponse',
  '2': const [
    const {'1': 'auto_recharges', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.InternetAutoRecharge', '10': 'autoRecharges'},
  ],
};

/// Descriptor for `GetInternetAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetAutoRechargesResponseDescriptor = $convert.base64Decode('CiBHZXRJbnRlcm5ldEF1dG9SZWNoYXJnZXNSZXNwb25zZRJMCg5hdXRvX3JlY2hhcmdlcxgBIAMoCzIlLnV0aWxpdHlwYXltZW50cy5JbnRlcm5ldEF1dG9SZWNoYXJnZVINYXV0b1JlY2hhcmdlcw==');
@$core.Deprecated('Use updateInternetAutoRechargeRequestDescriptor instead')
const UpdateInternetAutoRechargeRequest$json = const {
  '1': 'UpdateInternetAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    const {'1': 'package_id', '3': 2, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'plan_name', '3': 3, '4': 1, '5': 9, '10': 'planName'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 5, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 6, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 7, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 8, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'execution_hour', '3': 9, '4': 1, '5': 5, '10': 'executionHour'},
    const {'1': 'execution_minute', '3': 10, '4': 1, '5': 5, '10': 'executionMinute'},
  ],
};

/// Descriptor for `UpdateInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetAutoRechargeRequestDescriptor = $convert.base64Decode('CiFVcGRhdGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIAEoCVIOYXV0b1JlY2hhcmdlSWQSHQoKcGFja2FnZV9pZBgCIAEoCVIJcGFja2FnZUlkEhsKCXBsYW5fbmFtZRgDIAEoCVIIcGxhbk5hbWUSFgoGYW1vdW50GAQgASgBUgZhbW91bnQSHAoJZnJlcXVlbmN5GAUgASgJUglmcmVxdWVuY3kSHgoLZGF5X29mX3dlZWsYBiABKAVSCWRheU9mV2VlaxIgCgxkYXlfb2ZfbW9udGgYByABKAVSCmRheU9mTW9udGgSHwoLbWF4X3JldHJpZXMYCCABKAVSCm1heFJldHJpZXMSJQoOZXhlY3V0aW9uX2hvdXIYCSABKAVSDWV4ZWN1dGlvbkhvdXISKQoQZXhlY3V0aW9uX21pbnV0ZRgKIAEoBVIPZXhlY3V0aW9uTWludXRl');
@$core.Deprecated('Use updateInternetAutoRechargeResponseDescriptor instead')
const UpdateInternetAutoRechargeResponse$json = const {
  '1': 'UpdateInternetAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.InternetAutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetAutoRechargeResponseDescriptor = $convert.base64Decode('CiJVcGRhdGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlc3BvbnNlEkoKDWF1dG9fcmVjaGFyZ2UYASABKAsyJS51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRBdXRvUmVjaGFyZ2VSDGF1dG9SZWNoYXJnZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteInternetAutoRechargeRequestDescriptor instead')
const DeleteInternetAutoRechargeRequest$json = const {
  '1': 'DeleteInternetAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetAutoRechargeRequestDescriptor = $convert.base64Decode('CiFEZWxldGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIAEoCVIOYXV0b1JlY2hhcmdlSWQ=');
@$core.Deprecated('Use deleteInternetAutoRechargeResponseDescriptor instead')
const DeleteInternetAutoRechargeResponse$json = const {
  '1': 'DeleteInternetAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetAutoRechargeResponseDescriptor = $convert.base64Decode('CiJEZWxldGVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use pauseInternetAutoRechargeRequestDescriptor instead')
const PauseInternetAutoRechargeRequest$json = const {
  '1': 'PauseInternetAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseInternetAutoRechargeRequestDescriptor = $convert.base64Decode('CiBQYXVzZUludGVybmV0QXV0b1JlY2hhcmdlUmVxdWVzdBIoChBhdXRvX3JlY2hhcmdlX2lkGAEgASgJUg5hdXRvUmVjaGFyZ2VJZA==');
@$core.Deprecated('Use pauseInternetAutoRechargeResponseDescriptor instead')
const PauseInternetAutoRechargeResponse$json = const {
  '1': 'PauseInternetAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseInternetAutoRechargeResponseDescriptor = $convert.base64Decode('CiFQYXVzZUludGVybmV0QXV0b1JlY2hhcmdlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use resumeInternetAutoRechargeRequestDescriptor instead')
const ResumeInternetAutoRechargeRequest$json = const {
  '1': 'ResumeInternetAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeInternetAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeInternetAutoRechargeRequestDescriptor = $convert.base64Decode('CiFSZXN1bWVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIAEoCVIOYXV0b1JlY2hhcmdlSWQ=');
@$core.Deprecated('Use resumeInternetAutoRechargeResponseDescriptor instead')
const ResumeInternetAutoRechargeResponse$json = const {
  '1': 'ResumeInternetAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeInternetAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeInternetAutoRechargeResponseDescriptor = $convert.base64Decode('CiJSZXN1bWVJbnRlcm5ldEF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use internetReminderDescriptor instead')
const InternetReminder$json = const {
  '1': 'InternetReminder',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'package_id', '3': 8, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 10, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 11, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'notified_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'notifiedAt'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `InternetReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List internetReminderDescriptor = $convert.base64Decode('ChBJbnRlcm5ldFJlbWluZGVyEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUYBCABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgHIAEoAVIGYW1vdW50Eh0KCnBhY2thZ2VfaWQYCCABKAlSCXBhY2thZ2VJZBIaCghjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3kSIQoMaXNfcmVjdXJyaW5nGAogASgIUgtpc1JlY3VycmluZxInCg9yZWN1cnJlbmNlX3R5cGUYCyABKAlSDnJlY3VycmVuY2VUeXBlEhYKBnN0YXR1cxgMIAEoCVIGc3RhdHVzEjsKC25vdGlmaWVkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbm90aWZpZWRBdBI5CgpjcmVhdGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use createInternetReminderRequestDescriptor instead')
const CreateInternetReminderRequest$json = const {
  '1': 'CreateInternetReminderRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'package_id', '3': 6, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `CreateInternetReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInternetReminderRequestDescriptor = $convert.base64Decode('Ch1DcmVhdGVJbnRlcm5ldFJlbWluZGVyUmVxdWVzdBIlCg5iZW5lZmljaWFyeV9pZBgBIAEoCVINYmVuZWZpY2lhcnlJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSHQoKcGFja2FnZV9pZBgGIAEoCVIJcGFja2FnZUlkEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYCCABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgJIAEoCVIOcmVjdXJyZW5jZVR5cGU=');
@$core.Deprecated('Use createInternetReminderResponseDescriptor instead')
const CreateInternetReminderResponse$json = const {
  '1': 'CreateInternetReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.InternetReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateInternetReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInternetReminderResponseDescriptor = $convert.base64Decode('Ch5DcmVhdGVJbnRlcm5ldFJlbWluZGVyUmVzcG9uc2USPQoIcmVtaW5kZXIYASABKAsyIS51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getInternetRemindersRequestDescriptor instead')
const GetInternetRemindersRequest$json = const {
  '1': 'GetInternetRemindersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetInternetRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetRemindersRequestDescriptor = $convert.base64Decode('ChtHZXRJbnRlcm5ldFJlbWluZGVyc1JlcXVlc3QSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXMSIQoMaW5jbHVkZV9wYXN0GAIgASgIUgtpbmNsdWRlUGFzdA==');
@$core.Deprecated('Use getInternetRemindersResponseDescriptor instead')
const GetInternetRemindersResponse$json = const {
  '1': 'GetInternetRemindersResponse',
  '2': const [
    const {'1': 'reminders', '3': 1, '4': 3, '5': 11, '6': '.utilitypayments.InternetReminder', '10': 'reminders'},
  ],
};

/// Descriptor for `GetInternetRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInternetRemindersResponseDescriptor = $convert.base64Decode('ChxHZXRJbnRlcm5ldFJlbWluZGVyc1Jlc3BvbnNlEj8KCXJlbWluZGVycxgBIAMoCzIhLnV0aWxpdHlwYXltZW50cy5JbnRlcm5ldFJlbWluZGVyUglyZW1pbmRlcnM=');
@$core.Deprecated('Use updateInternetReminderRequestDescriptor instead')
const UpdateInternetReminderRequest$json = const {
  '1': 'UpdateInternetReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'package_id', '3': 6, '4': 1, '5': 9, '10': 'packageId'},
    const {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateInternetReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetReminderRequestDescriptor = $convert.base64Decode('Ch1VcGRhdGVJbnRlcm5ldFJlbWluZGVyUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcmVtaW5kZXJJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEj8KDXJlbWluZGVyX2RhdGUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxyZW1pbmRlckRhdGUSFgoGYW1vdW50GAUgASgBUgZhbW91bnQSHQoKcGFja2FnZV9pZBgGIAEoCVIJcGFja2FnZUlkEhoKCGN1cnJlbmN5GAcgASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYCCABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgJIAEoCVIOcmVjdXJyZW5jZVR5cGU=');
@$core.Deprecated('Use updateInternetReminderResponseDescriptor instead')
const UpdateInternetReminderResponse$json = const {
  '1': 'UpdateInternetReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.utilitypayments.InternetReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateInternetReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInternetReminderResponseDescriptor = $convert.base64Decode('Ch5VcGRhdGVJbnRlcm5ldFJlbWluZGVyUmVzcG9uc2USPQoIcmVtaW5kZXIYASABKAsyIS51dGlsaXR5cGF5bWVudHMuSW50ZXJuZXRSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteInternetReminderRequestDescriptor instead')
const DeleteInternetReminderRequest$json = const {
  '1': 'DeleteInternetReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteInternetReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetReminderRequestDescriptor = $convert.base64Decode('Ch1EZWxldGVJbnRlcm5ldFJlbWluZGVyUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcmVtaW5kZXJJZA==');
@$core.Deprecated('Use deleteInternetReminderResponseDescriptor instead')
const DeleteInternetReminderResponse$json = const {
  '1': 'DeleteInternetReminderResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInternetReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInternetReminderResponseDescriptor = $convert.base64Decode('Ch5EZWxldGVJbnRlcm5ldFJlbWluZGVyUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use markInternetReminderCompleteRequestDescriptor instead')
const MarkInternetReminderCompleteRequest$json = const {
  '1': 'MarkInternetReminderCompleteRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkInternetReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markInternetReminderCompleteRequestDescriptor = $convert.base64Decode('CiNNYXJrSW50ZXJuZXRSZW1pbmRlckNvbXBsZXRlUmVxdWVzdBIfCgtyZW1pbmRlcl9pZBgBIAEoCVIKcmVtaW5kZXJJZA==');
@$core.Deprecated('Use markInternetReminderCompleteResponseDescriptor instead')
const MarkInternetReminderCompleteResponse$json = const {
  '1': 'MarkInternetReminderCompleteResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkInternetReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markInternetReminderCompleteResponseDescriptor = $convert.base64Decode('CiRNYXJrSW50ZXJuZXRSZW1pbmRlckNvbXBsZXRlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
