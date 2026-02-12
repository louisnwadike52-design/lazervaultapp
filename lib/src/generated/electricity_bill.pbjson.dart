//
//  Generated code. Do not modify.
//  source: electricity_bill.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use electricityProviderDescriptor instead')
const ElectricityProvider$json = {
  '1': 'ElectricityProvider',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 3, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'country', '3': 4, '4': 1, '5': 9, '10': 'country'},
    {'1': 'logo_url', '3': 5, '4': 1, '5': 9, '10': 'logoUrl'},
    {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'payment_gateway', '3': 7, '4': 1, '5': 9, '10': 'paymentGateway'},
    {'1': 'min_amount', '3': 8, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 9, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'service_fee', '3': 10, '4': 1, '5': 1, '10': 'serviceFee'},
    {'1': 'fee_type', '3': 11, '4': 1, '5': 9, '10': 'feeType'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `ElectricityProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List electricityProviderDescriptor = $convert.base64Decode(
    'ChNFbGVjdHJpY2l0eVByb3ZpZGVyEg4KAmlkGAEgASgJUgJpZBIjCg1wcm92aWRlcl9jb2RlGA'
    'IgASgJUgxwcm92aWRlckNvZGUSIwoNcHJvdmlkZXJfbmFtZRgDIAEoCVIMcHJvdmlkZXJOYW1l'
    'EhgKB2NvdW50cnkYBCABKAlSB2NvdW50cnkSGQoIbG9nb191cmwYBSABKAlSB2xvZ29VcmwSGw'
    'oJaXNfYWN0aXZlGAYgASgIUghpc0FjdGl2ZRInCg9wYXltZW50X2dhdGV3YXkYByABKAlSDnBh'
    'eW1lbnRHYXRld2F5Eh0KCm1pbl9hbW91bnQYCCABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW'
    '50GAkgASgBUgltYXhBbW91bnQSHwoLc2VydmljZV9mZWUYCiABKAFSCnNlcnZpY2VGZWUSGQoI'
    'ZmVlX3R5cGUYCyABKAlSB2ZlZVR5cGUSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm'
    '90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use billPaymentDescriptor instead')
const BillPayment$json = {
  '1': 'BillPayment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'meter_number', '3': 5, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'customer_name', '3': 6, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'customer_address', '3': 7, '4': 1, '5': 9, '10': 'customerAddress'},
    {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'service_fee', '3': 9, '4': 1, '5': 1, '10': 'serviceFee'},
    {'1': 'total_amount', '3': 10, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    {'1': 'payment_gateway', '3': 13, '4': 1, '5': 9, '10': 'paymentGateway'},
    {'1': 'gateway_reference', '3': 14, '4': 1, '5': 9, '10': 'gatewayReference'},
    {'1': 'reference_number', '3': 15, '4': 1, '5': 9, '10': 'referenceNumber'},
    {'1': 'token', '3': 16, '4': 1, '5': 9, '10': 'token'},
    {'1': 'units', '3': 17, '4': 1, '5': 1, '10': 'units'},
    {'1': 'meter_type', '3': 18, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'failure_reason', '3': 19, '4': 1, '5': 9, '10': 'failureReason'},
    {'1': 'created_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    {'1': 'provider_id', '3': 22, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'updated_at', '3': 23, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'error_message', '3': 24, '4': 1, '5': 9, '10': 'errorMessage'},
    {'1': 'failed_at', '3': 25, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failedAt'},
  ],
};

/// Descriptor for `BillPayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billPaymentDescriptor = $convert.base64Decode(
    'CgtCaWxsUGF5bWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEi'
    'MKDXByb3ZpZGVyX2NvZGUYAyABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAQg'
    'ASgJUgxwcm92aWRlck5hbWUSIQoMbWV0ZXJfbnVtYmVyGAUgASgJUgttZXRlck51bWJlchIjCg'
    '1jdXN0b21lcl9uYW1lGAYgASgJUgxjdXN0b21lck5hbWUSKQoQY3VzdG9tZXJfYWRkcmVzcxgH'
    'IAEoCVIPY3VzdG9tZXJBZGRyZXNzEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50Eh8KC3NlcnZpY2'
    'VfZmVlGAkgASgBUgpzZXJ2aWNlRmVlEiEKDHRvdGFsX2Ftb3VudBgKIAEoAVILdG90YWxBbW91'
    'bnQSGgoIY3VycmVuY3kYCyABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgMIAEoCVIGc3RhdHVzEi'
    'cKD3BheW1lbnRfZ2F0ZXdheRgNIAEoCVIOcGF5bWVudEdhdGV3YXkSKwoRZ2F0ZXdheV9yZWZl'
    'cmVuY2UYDiABKAlSEGdhdGV3YXlSZWZlcmVuY2USKQoQcmVmZXJlbmNlX251bWJlchgPIAEoCV'
    'IPcmVmZXJlbmNlTnVtYmVyEhQKBXRva2VuGBAgASgJUgV0b2tlbhIUCgV1bml0cxgRIAEoAVIF'
    'dW5pdHMSHQoKbWV0ZXJfdHlwZRgSIAEoCVIJbWV0ZXJUeXBlEiUKDmZhaWx1cmVfcmVhc29uGB'
    'MgASgJUg1mYWlsdXJlUmVhc29uEjkKCmNyZWF0ZWRfYXQYFCABKAsyGi5nb29nbGUucHJvdG9i'
    'dWYuVGltZXN0YW1wUgljcmVhdGVkQXQSPQoMY29tcGxldGVkX2F0GBUgASgLMhouZ29vZ2xlLn'
    'Byb3RvYnVmLlRpbWVzdGFtcFILY29tcGxldGVkQXQSHwoLcHJvdmlkZXJfaWQYFiABKAlSCnBy'
    'b3ZpZGVySWQSOQoKdXBkYXRlZF9hdBgXIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbX'
    'BSCXVwZGF0ZWRBdBIjCg1lcnJvcl9tZXNzYWdlGBggASgJUgxlcnJvck1lc3NhZ2USNwoJZmFp'
    'bGVkX2F0GBkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIZmFpbGVkQXQ=');

@$core.Deprecated('Use billBeneficiaryDescriptor instead')
const BillBeneficiary$json = {
  '1': 'BillBeneficiary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'meter_number', '3': 5, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'customer_name', '3': 6, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'nickname', '3': 7, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'meter_type', '3': 8, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'is_default', '3': 9, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'last_used_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
    {'1': 'provider_id', '3': 12, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'customer_address', '3': 13, '4': 1, '5': 9, '10': 'customerAddress'},
    {'1': 'updated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `BillBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billBeneficiaryDescriptor = $convert.base64Decode(
    'Cg9CaWxsQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBIjCg1wcm92aWRlcl9jb2RlGAMgASgJUgxwcm92aWRlckNvZGUSIwoNcHJvdmlkZXJfbmFt'
    'ZRgEIAEoCVIMcHJvdmlkZXJOYW1lEiEKDG1ldGVyX251bWJlchgFIAEoCVILbWV0ZXJOdW1iZX'
    'ISIwoNY3VzdG9tZXJfbmFtZRgGIAEoCVIMY3VzdG9tZXJOYW1lEhoKCG5pY2tuYW1lGAcgASgJ'
    'UghuaWNrbmFtZRIdCgptZXRlcl90eXBlGAggASgJUgltZXRlclR5cGUSHQoKaXNfZGVmYXVsdB'
    'gJIAEoCFIJaXNEZWZhdWx0EjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUgljcmVhdGVkQXQSPAoMbGFzdF91c2VkX2F0GAsgASgLMhouZ29vZ2xlLnByb3'
    'RvYnVmLlRpbWVzdGFtcFIKbGFzdFVzZWRBdBIfCgtwcm92aWRlcl9pZBgMIAEoCVIKcHJvdmlk'
    'ZXJJZBIpChBjdXN0b21lcl9hZGRyZXNzGA0gASgJUg9jdXN0b21lckFkZHJlc3MSOQoKdXBkYX'
    'RlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use autoRechargeDescriptor instead')
const AutoRecharge$json = {
  '1': 'AutoRecharge',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'meter_number', '3': 4, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 7, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 8, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 9, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'next_run_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRunDate'},
    {'1': 'last_run_date', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastRunDate'},
    {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    {'1': 'failure_count', '3': 13, '4': 1, '5': 5, '10': 'failureCount'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'beneficiary', '3': 15, '4': 1, '5': 11, '6': '.pb.BillBeneficiary', '10': 'beneficiary'},
    {'1': 'provider_id', '3': 16, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'provider_code', '3': 17, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 18, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'customer_name', '3': 19, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'meter_type', '3': 20, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'max_retries', '3': 21, '4': 1, '5': 5, '10': 'maxRetries'},
    {'1': 'updated_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `AutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoRechargeDescriptor = $convert.base64Decode(
    'CgxBdXRvUmVjaGFyZ2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'IlCg5iZW5lZmljaWFyeV9pZBgDIAEoCVINYmVuZWZpY2lhcnlJZBIhCgxtZXRlcl9udW1iZXIY'
    'BCABKAlSC21ldGVyTnVtYmVyEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GA'
    'YgASgJUghjdXJyZW5jeRIcCglmcmVxdWVuY3kYByABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zf'
    'd2VlaxgIIAEoBVIJZGF5T2ZXZWVrEiAKDGRheV9vZl9tb250aBgJIAEoBVIKZGF5T2ZNb250aB'
    'I+Cg1uZXh0X3J1bl9kYXRlGAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbmV4'
    'dFJ1bkRhdGUSPgoNbGFzdF9ydW5fZGF0ZRgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSC2xhc3RSdW5EYXRlEhYKBnN0YXR1cxgMIAEoCVIGc3RhdHVzEiMKDWZhaWx1cmVfY291'
    'bnQYDSABKAVSDGZhaWx1cmVDb3VudBI5CgpjcmVhdGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3'
    'RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjUKC2JlbmVmaWNpYXJ5GA8gASgLMhMucGIuQmls'
    'bEJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIfCgtwcm92aWRlcl9pZBgQIAEoCVIKcHJvdmlkZX'
    'JJZBIjCg1wcm92aWRlcl9jb2RlGBEgASgJUgxwcm92aWRlckNvZGUSIwoNcHJvdmlkZXJfbmFt'
    'ZRgSIAEoCVIMcHJvdmlkZXJOYW1lEiMKDWN1c3RvbWVyX25hbWUYEyABKAlSDGN1c3RvbWVyTm'
    'FtZRIdCgptZXRlcl90eXBlGBQgASgJUgltZXRlclR5cGUSHwoLbWF4X3JldHJpZXMYFSABKAVS'
    'Cm1heFJldHJpZXMSOQoKdXBkYXRlZF9hdBgWIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use billPaymentReminderDescriptor instead')
const BillPaymentReminder$json = {
  '1': 'BillPaymentReminder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reminder_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    {'1': 'notified_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'notifiedAt'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'currency', '3': 13, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'updated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `BillPaymentReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billPaymentReminderDescriptor = $convert.base64Decode(
    'ChNCaWxsUGF5bWVudFJlbWluZGVyEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUY'
    'BCABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbm'
    'Rlcl9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRl'
    'EhYKBmFtb3VudBgHIAEoAVIGYW1vdW50EiEKDGlzX3JlY3VycmluZxgIIAEoCFILaXNSZWN1cn'
    'JpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAkgASgJUg5yZWN1cnJlbmNlVHlwZRIWCgZzdGF0dXMY'
    'CiABKAlSBnN0YXR1cxI7Cgtub3RpZmllZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSCm5vdGlmaWVkQXQSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1'
    'Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBIaCghjdXJyZW5jeRgNIAEoCVIIY3VycmVuY3kSOQoKdX'
    'BkYXRlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use receiptDataDescriptor instead')
const ReceiptData$json = {
  '1': 'ReceiptData',
  '2': [
    {'1': 'receipt_number', '3': 1, '4': 1, '5': 9, '10': 'receiptNumber'},
    {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'meter_number', '3': 3, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'amount_paid', '3': 5, '4': 1, '5': 1, '10': 'amountPaid'},
    {'1': 'service_fee', '3': 6, '4': 1, '5': 1, '10': 'serviceFee'},
    {'1': 'total_amount', '3': 7, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'token', '3': 8, '4': 1, '5': 9, '10': 'token'},
    {'1': 'units', '3': 9, '4': 1, '5': 1, '10': 'units'},
    {'1': 'payment_date', '3': 10, '4': 1, '5': 9, '10': 'paymentDate'},
    {'1': 'reference_number', '3': 11, '4': 1, '5': 9, '10': 'referenceNumber'},
  ],
};

/// Descriptor for `ReceiptData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiptDataDescriptor = $convert.base64Decode(
    'CgtSZWNlaXB0RGF0YRIlCg5yZWNlaXB0X251bWJlchgBIAEoCVINcmVjZWlwdE51bWJlchIjCg'
    '1jdXN0b21lcl9uYW1lGAIgASgJUgxjdXN0b21lck5hbWUSIQoMbWV0ZXJfbnVtYmVyGAMgASgJ'
    'UgttZXRlck51bWJlchIjCg1wcm92aWRlcl9uYW1lGAQgASgJUgxwcm92aWRlck5hbWUSHwoLYW'
    '1vdW50X3BhaWQYBSABKAFSCmFtb3VudFBhaWQSHwoLc2VydmljZV9mZWUYBiABKAFSCnNlcnZp'
    'Y2VGZWUSIQoMdG90YWxfYW1vdW50GAcgASgBUgt0b3RhbEFtb3VudBIUCgV0b2tlbhgIIAEoCV'
    'IFdG9rZW4SFAoFdW5pdHMYCSABKAFSBXVuaXRzEiEKDHBheW1lbnRfZGF0ZRgKIAEoCVILcGF5'
    'bWVudERhdGUSKQoQcmVmZXJlbmNlX251bWJlchgLIAEoCVIPcmVmZXJlbmNlTnVtYmVy');

@$core.Deprecated('Use getProvidersRequestDescriptor instead')
const GetProvidersRequest$json = {
  '1': 'GetProvidersRequest',
  '2': [
    {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
    {'1': 'payment_gateway', '3': 2, '4': 1, '5': 9, '10': 'paymentGateway'},
  ],
};

/// Descriptor for `GetProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProvidersRequestDescriptor = $convert.base64Decode(
    'ChNHZXRQcm92aWRlcnNSZXF1ZXN0EhgKB2NvdW50cnkYASABKAlSB2NvdW50cnkSJwoPcGF5bW'
    'VudF9nYXRld2F5GAIgASgJUg5wYXltZW50R2F0ZXdheQ==');

@$core.Deprecated('Use getProvidersResponseDescriptor instead')
const GetProvidersResponse$json = {
  '1': 'GetProvidersResponse',
  '2': [
    {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.pb.ElectricityProvider', '10': 'providers'},
  ],
};

/// Descriptor for `GetProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProvidersResponseDescriptor = $convert.base64Decode(
    'ChRHZXRQcm92aWRlcnNSZXNwb25zZRI1Cglwcm92aWRlcnMYASADKAsyFy5wYi5FbGVjdHJpY2'
    'l0eVByb3ZpZGVyUglwcm92aWRlcnM=');

@$core.Deprecated('Use syncProvidersRequestDescriptor instead')
const SyncProvidersRequest$json = {
  '1': 'SyncProvidersRequest',
  '2': [
    {'1': 'payment_gateway', '3': 1, '4': 1, '5': 9, '10': 'paymentGateway'},
  ],
};

/// Descriptor for `SyncProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncProvidersRequestDescriptor = $convert.base64Decode(
    'ChRTeW5jUHJvdmlkZXJzUmVxdWVzdBInCg9wYXltZW50X2dhdGV3YXkYASABKAlSDnBheW1lbn'
    'RHYXRld2F5');

@$core.Deprecated('Use syncProvidersResponseDescriptor instead')
const SyncProvidersResponse$json = {
  '1': 'SyncProvidersResponse',
  '2': [
    {'1': 'synced_count', '3': 1, '4': 1, '5': 5, '10': 'syncedCount'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SyncProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncProvidersResponseDescriptor = $convert.base64Decode(
    'ChVTeW5jUHJvdmlkZXJzUmVzcG9uc2USIQoMc3luY2VkX2NvdW50GAEgASgFUgtzeW5jZWRDb3'
    'VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use validateMeterRequestDescriptor instead')
const ValidateMeterRequest$json = {
  '1': 'ValidateMeterRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'meter_type', '3': 3, '4': 1, '5': 9, '10': 'meterType'},
  ],
};

/// Descriptor for `ValidateMeterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateMeterRequestDescriptor = $convert.base64Decode(
    'ChRWYWxpZGF0ZU1ldGVyUmVxdWVzdBIjCg1wcm92aWRlcl9jb2RlGAEgASgJUgxwcm92aWRlck'
    'NvZGUSIQoMbWV0ZXJfbnVtYmVyGAIgASgJUgttZXRlck51bWJlchIdCgptZXRlcl90eXBlGAMg'
    'ASgJUgltZXRlclR5cGU=');

@$core.Deprecated('Use validateMeterResponseDescriptor instead')
const ValidateMeterResponse$json = {
  '1': 'ValidateMeterResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'customer_address', '3': 3, '4': 1, '5': 9, '10': 'customerAddress'},
    {'1': 'meter_type', '3': 4, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'outstanding_balance', '3': 5, '4': 1, '5': 1, '10': 'outstandingBalance'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    {'1': 'meter_number', '3': 7, '4': 1, '5': 9, '10': 'meterNumber'},
  ],
};

/// Descriptor for `ValidateMeterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateMeterResponseDescriptor = $convert.base64Decode(
    'ChVWYWxpZGF0ZU1ldGVyUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSIwoNY3'
    'VzdG9tZXJfbmFtZRgCIAEoCVIMY3VzdG9tZXJOYW1lEikKEGN1c3RvbWVyX2FkZHJlc3MYAyAB'
    'KAlSD2N1c3RvbWVyQWRkcmVzcxIdCgptZXRlcl90eXBlGAQgASgJUgltZXRlclR5cGUSLwoTb3'
    'V0c3RhbmRpbmdfYmFsYW5jZRgFIAEoAVISb3V0c3RhbmRpbmdCYWxhbmNlEhgKB21lc3NhZ2UY'
    'BiABKAlSB21lc3NhZ2USIQoMbWV0ZXJfbnVtYmVyGAcgASgJUgttZXRlck51bWJlcg==');

@$core.Deprecated('Use smartValidateMeterRequestDescriptor instead')
const SmartValidateMeterRequest$json = {
  '1': 'SmartValidateMeterRequest',
  '2': [
    {'1': 'meter_number', '3': 1, '4': 1, '5': 9, '10': 'meterNumber'},
  ],
};

/// Descriptor for `SmartValidateMeterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smartValidateMeterRequestDescriptor = $convert.base64Decode(
    'ChlTbWFydFZhbGlkYXRlTWV0ZXJSZXF1ZXN0EiEKDG1ldGVyX251bWJlchgBIAEoCVILbWV0ZX'
    'JOdW1iZXI=');

@$core.Deprecated('Use smartValidateMeterResponseDescriptor instead')
const SmartValidateMeterResponse$json = {
  '1': 'SmartValidateMeterResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'customer_address', '3': 3, '4': 1, '5': 9, '10': 'customerAddress'},
    {'1': 'meter_type', '3': 4, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'meter_number', '3': 5, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'provider_code', '3': 6, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'provider_name', '3': 7, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'message', '3': 8, '4': 1, '5': 9, '10': 'message'},
    {'1': 'min_amount', '3': 9, '4': 1, '5': 1, '10': 'minAmount'},
    {'1': 'max_amount', '3': 10, '4': 1, '5': 1, '10': 'maxAmount'},
    {'1': 'service_fee', '3': 11, '4': 1, '5': 1, '10': 'serviceFee'},
    {'1': 'from_cache', '3': 12, '4': 1, '5': 8, '10': 'fromCache'},
  ],
};

/// Descriptor for `SmartValidateMeterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smartValidateMeterResponseDescriptor = $convert.base64Decode(
    'ChpTbWFydFZhbGlkYXRlTWV0ZXJSZXNwb25zZRIZCghpc192YWxpZBgBIAEoCFIHaXNWYWxpZB'
    'IjCg1jdXN0b21lcl9uYW1lGAIgASgJUgxjdXN0b21lck5hbWUSKQoQY3VzdG9tZXJfYWRkcmVz'
    'cxgDIAEoCVIPY3VzdG9tZXJBZGRyZXNzEh0KCm1ldGVyX3R5cGUYBCABKAlSCW1ldGVyVHlwZR'
    'IhCgxtZXRlcl9udW1iZXIYBSABKAlSC21ldGVyTnVtYmVyEiMKDXByb3ZpZGVyX2NvZGUYBiAB'
    'KAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAcgASgJUgxwcm92aWRlck5hbWUSGA'
    'oHbWVzc2FnZRgIIAEoCVIHbWVzc2FnZRIdCgptaW5fYW1vdW50GAkgASgBUgltaW5BbW91bnQS'
    'HQoKbWF4X2Ftb3VudBgKIAEoAVIJbWF4QW1vdW50Eh8KC3NlcnZpY2VfZmVlGAsgASgBUgpzZX'
    'J2aWNlRmVlEh0KCmZyb21fY2FjaGUYDCABKAhSCWZyb21DYWNoZQ==');

@$core.Deprecated('Use getBillDetailsRequestDescriptor instead')
const GetBillDetailsRequest$json = {
  '1': 'GetBillDetailsRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
  ],
};

/// Descriptor for `GetBillDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillDetailsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRCaWxsRGV0YWlsc1JlcXVlc3QSIwoNcHJvdmlkZXJfY29kZRgBIAEoCVIMcHJvdmlkZX'
    'JDb2RlEiEKDG1ldGVyX251bWJlchgCIAEoCVILbWV0ZXJOdW1iZXI=');

@$core.Deprecated('Use getBillDetailsResponseDescriptor instead')
const GetBillDetailsResponse$json = {
  '1': 'GetBillDetailsResponse',
  '2': [
    {'1': 'customer_name', '3': 1, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'customer_address', '3': 2, '4': 1, '5': 9, '10': 'customerAddress'},
    {'1': 'outstanding_amount', '3': 3, '4': 1, '5': 1, '10': 'outstandingAmount'},
    {'1': 'due_date', '3': 4, '4': 1, '5': 9, '10': 'dueDate'},
    {'1': 'meter_type', '3': 5, '4': 1, '5': 9, '10': 'meterType'},
  ],
};

/// Descriptor for `GetBillDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillDetailsResponseDescriptor = $convert.base64Decode(
    'ChZHZXRCaWxsRGV0YWlsc1Jlc3BvbnNlEiMKDWN1c3RvbWVyX25hbWUYASABKAlSDGN1c3RvbW'
    'VyTmFtZRIpChBjdXN0b21lcl9hZGRyZXNzGAIgASgJUg9jdXN0b21lckFkZHJlc3MSLQoSb3V0'
    'c3RhbmRpbmdfYW1vdW50GAMgASgBUhFvdXRzdGFuZGluZ0Ftb3VudBIZCghkdWVfZGF0ZRgEIA'
    'EoCVIHZHVlRGF0ZRIdCgptZXRlcl90eXBlGAUgASgJUgltZXRlclR5cGU=');

@$core.Deprecated('Use initiatePaymentRequestDescriptor instead')
const InitiatePaymentRequest$json = {
  '1': 'InitiatePaymentRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'meter_type', '3': 5, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'payment_gateway', '3': 6, '4': 1, '5': 9, '10': 'paymentGateway'},
    {'1': 'source_account_id', '3': 7, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'beneficiary_id', '3': 8, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'transaction_id', '3': 9, '4': 1, '5': 9, '10': 'transactionId'},
    {'1': 'verification_token', '3': 10, '4': 1, '5': 9, '10': 'verificationToken'},
    {'1': 'phone_number', '3': 11, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

/// Descriptor for `InitiatePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiatePaymentRequestDescriptor = $convert.base64Decode(
    'ChZJbml0aWF0ZVBheW1lbnRSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKAlSDHByb3ZpZG'
    'VyQ29kZRIhCgxtZXRlcl9udW1iZXIYAiABKAlSC21ldGVyTnVtYmVyEhYKBmFtb3VudBgDIAEo'
    'AVIGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIdCgptZXRlcl90eXBlGAUgAS'
    'gJUgltZXRlclR5cGUSJwoPcGF5bWVudF9nYXRld2F5GAYgASgJUg5wYXltZW50R2F0ZXdheRIq'
    'ChFzb3VyY2VfYWNjb3VudF9pZBgHIAEoCVIPc291cmNlQWNjb3VudElkEiUKDmJlbmVmaWNpYX'
    'J5X2lkGAggASgJUg1iZW5lZmljaWFyeUlkEiUKDnRyYW5zYWN0aW9uX2lkGAkgASgJUg10cmFu'
    'c2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgKIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW'
    '4SIQoMcGhvbmVfbnVtYmVyGAsgASgJUgtwaG9uZU51bWJlcg==');

@$core.Deprecated('Use initiatePaymentResponseDescriptor instead')
const InitiatePaymentResponse$json = {
  '1': 'InitiatePaymentResponse',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'reference_number', '3': 2, '4': 1, '5': 9, '10': 'referenceNumber'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'total_amount', '3': 4, '4': 1, '5': 1, '10': 'totalAmount'},
    {'1': 'service_fee', '3': 5, '4': 1, '5': 1, '10': 'serviceFee'},
    {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiatePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiatePaymentResponseDescriptor = $convert.base64Decode(
    'ChdJbml0aWF0ZVBheW1lbnRSZXNwb25zZRIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SW'
    'QSKQoQcmVmZXJlbmNlX251bWJlchgCIAEoCVIPcmVmZXJlbmNlTnVtYmVyEhYKBnN0YXR1cxgD'
    'IAEoCVIGc3RhdHVzEiEKDHRvdGFsX2Ftb3VudBgEIAEoAVILdG90YWxBbW91bnQSHwoLc2Vydm'
    'ljZV9mZWUYBSABKAFSCnNlcnZpY2VGZWUSGAoHbWVzc2FnZRgGIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use verifyPaymentRequestDescriptor instead')
const VerifyPaymentRequest$json = {
  '1': 'VerifyPaymentRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'reference_number', '3': 2, '4': 1, '5': 9, '10': 'referenceNumber'},
  ],
};

/// Descriptor for `VerifyPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPaymentRequestDescriptor = $convert.base64Decode(
    'ChRWZXJpZnlQYXltZW50UmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SWQSKQ'
    'oQcmVmZXJlbmNlX251bWJlchgCIAEoCVIPcmVmZXJlbmNlTnVtYmVy');

@$core.Deprecated('Use verifyPaymentResponseDescriptor instead')
const VerifyPaymentResponse$json = {
  '1': 'VerifyPaymentResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.BillPayment', '10': 'payment'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `VerifyPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPaymentResponseDescriptor = $convert.base64Decode(
    'ChVWZXJpZnlQYXltZW50UmVzcG9uc2USKQoHcGF5bWVudBgBIAEoCzIPLnBiLkJpbGxQYXltZW'
    '50UgdwYXltZW50EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getPaymentHistoryRequestDescriptor instead')
const GetPaymentHistoryRequest$json = {
  '1': 'GetPaymentHistoryRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetPaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQYXltZW50SGlzdG9yeVJlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm9mZn'
    'NldBgCIAEoBVIGb2Zmc2V0EiMKDXByb3ZpZGVyX2NvZGUYAyABKAlSDHByb3ZpZGVyQ29kZRIW'
    'CgZzdGF0dXMYBCABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use getPaymentHistoryResponseDescriptor instead')
const GetPaymentHistoryResponse$json = {
  '1': 'GetPaymentHistoryResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.BillPayment', '10': 'payments'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQYXltZW50SGlzdG9yeVJlc3BvbnNlEisKCHBheW1lbnRzGAEgAygLMg8ucGIuQmlsbF'
    'BheW1lbnRSCHBheW1lbnRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use getPaymentReceiptRequestDescriptor instead')
const GetPaymentReceiptRequest$json = {
  '1': 'GetPaymentReceiptRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GetPaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentReceiptRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQYXltZW50UmVjZWlwdFJlcXVlc3QSHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudE'
    'lk');

@$core.Deprecated('Use getPaymentReceiptResponseDescriptor instead')
const GetPaymentReceiptResponse$json = {
  '1': 'GetPaymentReceiptResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.BillPayment', '10': 'payment'},
    {'1': 'receipt_data', '3': 2, '4': 1, '5': 11, '6': '.pb.ReceiptData', '10': 'receiptData'},
  ],
};

/// Descriptor for `GetPaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentReceiptResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQYXltZW50UmVjZWlwdFJlc3BvbnNlEikKB3BheW1lbnQYASABKAsyDy5wYi5CaWxsUG'
    'F5bWVudFIHcGF5bWVudBIyCgxyZWNlaXB0X2RhdGEYAiABKAsyDy5wYi5SZWNlaXB0RGF0YVIL'
    'cmVjZWlwdERhdGE=');

@$core.Deprecated('Use saveBeneficiaryRequestDescriptor instead')
const SaveBeneficiaryRequest$json = {
  '1': 'SaveBeneficiaryRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
    {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    {'1': 'customer_name', '3': 3, '4': 1, '5': 9, '10': 'customerName'},
    {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'meter_type', '3': 5, '4': 1, '5': 9, '10': 'meterType'},
    {'1': 'is_default', '3': 6, '4': 1, '5': 8, '10': 'isDefault'},
    {'1': 'provider_id', '3': 7, '4': 1, '5': 9, '10': 'providerId'},
    {'1': 'provider_name', '3': 8, '4': 1, '5': 9, '10': 'providerName'},
    {'1': 'customer_address', '3': 9, '4': 1, '5': 9, '10': 'customerAddress'},
  ],
};

/// Descriptor for `SaveBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBeneficiaryRequestDescriptor = $convert.base64Decode(
    'ChZTYXZlQmVuZWZpY2lhcnlSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKAlSDHByb3ZpZG'
    'VyQ29kZRIhCgxtZXRlcl9udW1iZXIYAiABKAlSC21ldGVyTnVtYmVyEiMKDWN1c3RvbWVyX25h'
    'bWUYAyABKAlSDGN1c3RvbWVyTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWUSHQoKbW'
    'V0ZXJfdHlwZRgFIAEoCVIJbWV0ZXJUeXBlEh0KCmlzX2RlZmF1bHQYBiABKAhSCWlzRGVmYXVs'
    'dBIfCgtwcm92aWRlcl9pZBgHIAEoCVIKcHJvdmlkZXJJZBIjCg1wcm92aWRlcl9uYW1lGAggAS'
    'gJUgxwcm92aWRlck5hbWUSKQoQY3VzdG9tZXJfYWRkcmVzcxgJIAEoCVIPY3VzdG9tZXJBZGRy'
    'ZXNz');

@$core.Deprecated('Use saveBeneficiaryResponseDescriptor instead')
const SaveBeneficiaryResponse$json = {
  '1': 'SaveBeneficiaryResponse',
  '2': [
    {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.pb.BillBeneficiary', '10': 'beneficiary'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBeneficiaryResponseDescriptor = $convert.base64Decode(
    'ChdTYXZlQmVuZWZpY2lhcnlSZXNwb25zZRI1CgtiZW5lZmljaWFyeRgBIAEoCzITLnBiLkJpbG'
    'xCZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getBeneficiariesRequestDescriptor instead')
const GetBeneficiariesRequest$json = {
  '1': 'GetBeneficiariesRequest',
  '2': [
    {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBeneficiariesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRCZW5lZmljaWFyaWVzUmVxdWVzdBIjCg1wcm92aWRlcl9jb2RlGAEgASgJUgxwcm92aW'
    'RlckNvZGU=');

@$core.Deprecated('Use getBeneficiariesResponseDescriptor instead')
const GetBeneficiariesResponse$json = {
  '1': 'GetBeneficiariesResponse',
  '2': [
    {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.pb.BillBeneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `GetBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBeneficiariesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRCZW5lZmljaWFyaWVzUmVzcG9uc2USOQoNYmVuZWZpY2lhcmllcxgBIAMoCzITLnBiLk'
    'JpbGxCZW5lZmljaWFyeVINYmVuZWZpY2lhcmllcw==');

@$core.Deprecated('Use updateBeneficiaryRequestDescriptor instead')
const UpdateBeneficiaryRequest$json = {
  '1': 'UpdateBeneficiaryRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'is_default', '3': 3, '4': 1, '5': 8, '10': 'isDefault'},
  ],
};

/// Descriptor for `UpdateBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBeneficiaryRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVCZW5lZmljaWFyeVJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbm'
    'VmaWNpYXJ5SWQSGgoIbmlja25hbWUYAiABKAlSCG5pY2tuYW1lEh0KCmlzX2RlZmF1bHQYAyAB'
    'KAhSCWlzRGVmYXVsdA==');

@$core.Deprecated('Use updateBeneficiaryResponseDescriptor instead')
const UpdateBeneficiaryResponse$json = {
  '1': 'UpdateBeneficiaryResponse',
  '2': [
    {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.pb.BillBeneficiary', '10': 'beneficiary'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBeneficiaryResponseDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVCZW5lZmljaWFyeVJlc3BvbnNlEjUKC2JlbmVmaWNpYXJ5GAEgASgLMhMucGIuQm'
    'lsbEJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use deleteBeneficiaryRequestDescriptor instead')
const DeleteBeneficiaryRequest$json = {
  '1': 'DeleteBeneficiaryRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
  ],
};

/// Descriptor for `DeleteBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBeneficiaryRequestDescriptor = $convert.base64Decode(
    'ChhEZWxldGVCZW5lZmljaWFyeVJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbm'
    'VmaWNpYXJ5SWQ=');

@$core.Deprecated('Use deleteBeneficiaryResponseDescriptor instead')
const DeleteBeneficiaryResponse$json = {
  '1': 'DeleteBeneficiaryResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBeneficiaryResponseDescriptor = $convert.base64Decode(
    'ChlEZWxldGVCZW5lZmljaWFyeVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use createAutoRechargeRequestDescriptor instead')
const CreateAutoRechargeRequest$json = {
  '1': 'CreateAutoRechargeRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 5, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 6, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 7, '4': 1, '5': 5, '10': 'maxRetries'},
  ],
};

/// Descriptor for `CreateAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoRechargeRequestDescriptor = $convert.base64Decode(
    'ChlDcmVhdGVBdXRvUmVjaGFyZ2VSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgASgJUg1iZW'
    '5lZmljaWFyeUlkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghj'
    'dXJyZW5jeRIcCglmcmVxdWVuY3kYBCABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zfd2VlaxgFIA'
    'EoBVIJZGF5T2ZXZWVrEiAKDGRheV9vZl9tb250aBgGIAEoBVIKZGF5T2ZNb250aBIfCgttYXhf'
    'cmV0cmllcxgHIAEoBVIKbWF4UmV0cmllcw==');

@$core.Deprecated('Use createAutoRechargeResponseDescriptor instead')
const CreateAutoRechargeResponse$json = {
  '1': 'CreateAutoRechargeResponse',
  '2': [
    {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.pb.AutoRecharge', '10': 'autoRecharge'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoRechargeResponseDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVBdXRvUmVjaGFyZ2VSZXNwb25zZRI1Cg1hdXRvX3JlY2hhcmdlGAEgASgLMhAucG'
    'IuQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getAutoRechargesRequestDescriptor instead')
const GetAutoRechargesRequest$json = {
  '1': 'GetAutoRechargesRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoRechargesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRBdXRvUmVjaGFyZ2VzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cw==');

@$core.Deprecated('Use getAutoRechargesResponseDescriptor instead')
const GetAutoRechargesResponse$json = {
  '1': 'GetAutoRechargesResponse',
  '2': [
    {'1': 'auto_recharges', '3': 1, '4': 3, '5': 11, '6': '.pb.AutoRecharge', '10': 'autoRecharges'},
  ],
};

/// Descriptor for `GetAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoRechargesResponseDescriptor = $convert.base64Decode(
    'ChhHZXRBdXRvUmVjaGFyZ2VzUmVzcG9uc2USNwoOYXV0b19yZWNoYXJnZXMYASADKAsyEC5wYi'
    '5BdXRvUmVjaGFyZ2VSDWF1dG9SZWNoYXJnZXM=');

@$core.Deprecated('Use updateAutoRechargeRequestDescriptor instead')
const UpdateAutoRechargeRequest$json = {
  '1': 'UpdateAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    {'1': 'day_of_week', '3': 4, '4': 1, '5': 5, '10': 'dayOfWeek'},
    {'1': 'day_of_month', '3': 5, '4': 1, '5': 5, '10': 'dayOfMonth'},
    {'1': 'max_retries', '3': 6, '4': 1, '5': 5, '10': 'maxRetries'},
  ],
};

/// Descriptor for `UpdateAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoRechargeRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDm'
    'F1dG9SZWNoYXJnZUlkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhwKCWZyZXF1ZW5jeRgDIAEo'
    'CVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAQgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX2'
    '1vbnRoGAUgASgFUgpkYXlPZk1vbnRoEh8KC21heF9yZXRyaWVzGAYgASgFUgptYXhSZXRyaWVz');

@$core.Deprecated('Use updateAutoRechargeResponseDescriptor instead')
const UpdateAutoRechargeResponse$json = {
  '1': 'UpdateAutoRechargeResponse',
  '2': [
    {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.pb.AutoRecharge', '10': 'autoRecharge'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoRechargeResponseDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVBdXRvUmVjaGFyZ2VSZXNwb25zZRI1Cg1hdXRvX3JlY2hhcmdlGAEgASgLMhAucG'
    'IuQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteAutoRechargeRequestDescriptor instead')
const DeleteAutoRechargeRequest$json = {
  '1': 'DeleteAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoRechargeRequestDescriptor = $convert.base64Decode(
    'ChlEZWxldGVBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDm'
    'F1dG9SZWNoYXJnZUlk');

@$core.Deprecated('Use deleteAutoRechargeResponseDescriptor instead')
const DeleteAutoRechargeResponse$json = {
  '1': 'DeleteAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoRechargeResponseDescriptor = $convert.base64Decode(
    'ChpEZWxldGVBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use pauseAutoRechargeRequestDescriptor instead')
const PauseAutoRechargeRequest$json = {
  '1': 'PauseAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseAutoRechargeRequestDescriptor = $convert.base64Decode(
    'ChhQYXVzZUF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIAEoCVIOYX'
    'V0b1JlY2hhcmdlSWQ=');

@$core.Deprecated('Use pauseAutoRechargeResponseDescriptor instead')
const PauseAutoRechargeResponse$json = {
  '1': 'PauseAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseAutoRechargeResponseDescriptor = $convert.base64Decode(
    'ChlQYXVzZUF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use resumeAutoRechargeRequestDescriptor instead')
const ResumeAutoRechargeRequest$json = {
  '1': 'ResumeAutoRechargeRequest',
  '2': [
    {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeAutoRechargeRequestDescriptor = $convert.base64Decode(
    'ChlSZXN1bWVBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDm'
    'F1dG9SZWNoYXJnZUlk');

@$core.Deprecated('Use resumeAutoRechargeResponseDescriptor instead')
const ResumeAutoRechargeResponse$json = {
  '1': 'ResumeAutoRechargeResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeAutoRechargeResponseDescriptor = $convert.base64Decode(
    'ChpSZXN1bWVBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use createReminderRequestDescriptor instead')
const CreateReminderRequest$json = {
  '1': 'CreateReminderRequest',
  '2': [
    {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'is_recurring', '3': 6, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 7, '4': 1, '5': 9, '10': 'recurrenceType'},
    {'1': 'currency', '3': 8, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `CreateReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createReminderRequestDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVSZW1pbmRlclJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbmVmaW'
    'NpYXJ5SWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNj'
    'cmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EiEKDGlzX3JlY3Vycmlu'
    'ZxgGIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAcgASgJUg5yZWN1cnJlbm'
    'NlVHlwZRIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3k=');

@$core.Deprecated('Use createReminderResponseDescriptor instead')
const CreateReminderResponse$json = {
  '1': 'CreateReminderResponse',
  '2': [
    {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.pb.BillPaymentReminder', '10': 'reminder'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createReminderResponseDescriptor = $convert.base64Decode(
    'ChZDcmVhdGVSZW1pbmRlclJlc3BvbnNlEjMKCHJlbWluZGVyGAEgASgLMhcucGIuQmlsbFBheW'
    '1lbnRSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getRemindersRequestDescriptor instead')
const GetRemindersRequest$json = {
  '1': 'GetRemindersRequest',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRemindersRequestDescriptor = $convert.base64Decode(
    'ChNHZXRSZW1pbmRlcnNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEiEKDGluY2x1ZG'
    'VfcGFzdBgCIAEoCFILaW5jbHVkZVBhc3Q=');

@$core.Deprecated('Use getRemindersResponseDescriptor instead')
const GetRemindersResponse$json = {
  '1': 'GetRemindersResponse',
  '2': [
    {'1': 'reminders', '3': 1, '4': 3, '5': 11, '6': '.pb.BillPaymentReminder', '10': 'reminders'},
  ],
};

/// Descriptor for `GetRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRemindersResponseDescriptor = $convert.base64Decode(
    'ChRHZXRSZW1pbmRlcnNSZXNwb25zZRI1CglyZW1pbmRlcnMYASADKAsyFy5wYi5CaWxsUGF5bW'
    'VudFJlbWluZGVyUglyZW1pbmRlcnM=');

@$core.Deprecated('Use updateReminderRequestDescriptor instead')
const UpdateReminderRequest$json = {
  '1': 'UpdateReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'reminder_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'is_recurring', '3': 7, '4': 1, '5': 8, '10': 'isRecurring'},
    {'1': 'recurrence_type', '3': 8, '4': 1, '5': 9, '10': 'recurrenceType'},
  ],
};

/// Descriptor for `UpdateReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateReminderRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVSZW1pbmRlclJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbWluZGVySW'
    'QSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlv'
    'bhI/Cg1yZW1pbmRlcl9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcm'
    'VtaW5kZXJEYXRlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghj'
    'dXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2'
    'VfdHlwZRgIIAEoCVIOcmVjdXJyZW5jZVR5cGU=');

@$core.Deprecated('Use updateReminderResponseDescriptor instead')
const UpdateReminderResponse$json = {
  '1': 'UpdateReminderResponse',
  '2': [
    {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.pb.BillPaymentReminder', '10': 'reminder'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateReminderResponseDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVSZW1pbmRlclJlc3BvbnNlEjMKCHJlbWluZGVyGAEgASgLMhcucGIuQmlsbFBheW'
    '1lbnRSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use deleteReminderRequestDescriptor instead')
const DeleteReminderRequest$json = {
  '1': 'DeleteReminderRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteReminderRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVSZW1pbmRlclJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbWluZGVySW'
    'Q=');

@$core.Deprecated('Use deleteReminderResponseDescriptor instead')
const DeleteReminderResponse$json = {
  '1': 'DeleteReminderResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteReminderResponseDescriptor = $convert.base64Decode(
    'ChZEZWxldGVSZW1pbmRlclJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use markReminderCompleteRequestDescriptor instead')
const MarkReminderCompleteRequest$json = {
  '1': 'MarkReminderCompleteRequest',
  '2': [
    {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markReminderCompleteRequestDescriptor = $convert.base64Decode(
    'ChtNYXJrUmVtaW5kZXJDb21wbGV0ZVJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbW'
    'luZGVySWQ=');

@$core.Deprecated('Use markReminderCompleteResponseDescriptor instead')
const MarkReminderCompleteResponse$json = {
  '1': 'MarkReminderCompleteResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markReminderCompleteResponseDescriptor = $convert.base64Decode(
    'ChxNYXJrUmVtaW5kZXJDb21wbGV0ZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2'
    'U=');

