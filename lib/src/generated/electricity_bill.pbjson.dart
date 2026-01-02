///
//  Generated code. Do not modify.
//  source: electricity_bill.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use electricityProviderDescriptor instead')
const ElectricityProvider$json = const {
  '1': 'ElectricityProvider',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 3, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'country', '3': 4, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'logo_url', '3': 5, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'payment_gateway', '3': 7, '4': 1, '5': 9, '10': 'paymentGateway'},
    const {'1': 'min_amount', '3': 8, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 9, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'service_fee', '3': 10, '4': 1, '5': 1, '10': 'serviceFee'},
    const {'1': 'fee_type', '3': 11, '4': 1, '5': 9, '10': 'feeType'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `ElectricityProvider`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List electricityProviderDescriptor = $convert.base64Decode('ChNFbGVjdHJpY2l0eVByb3ZpZGVyEg4KAmlkGAEgASgJUgJpZBIjCg1wcm92aWRlcl9jb2RlGAIgASgJUgxwcm92aWRlckNvZGUSIwoNcHJvdmlkZXJfbmFtZRgDIAEoCVIMcHJvdmlkZXJOYW1lEhgKB2NvdW50cnkYBCABKAlSB2NvdW50cnkSGQoIbG9nb191cmwYBSABKAlSB2xvZ29VcmwSGwoJaXNfYWN0aXZlGAYgASgIUghpc0FjdGl2ZRInCg9wYXltZW50X2dhdGV3YXkYByABKAlSDnBheW1lbnRHYXRld2F5Eh0KCm1pbl9hbW91bnQYCCABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAkgASgBUgltYXhBbW91bnQSHwoLc2VydmljZV9mZWUYCiABKAFSCnNlcnZpY2VGZWUSGQoIZmVlX3R5cGUYCyABKAlSB2ZlZVR5cGUSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use billPaymentDescriptor instead')
const BillPayment$json = const {
  '1': 'BillPayment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'meter_number', '3': 5, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'customer_name', '3': 6, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'customer_address', '3': 7, '4': 1, '5': 9, '10': 'customerAddress'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'service_fee', '3': 9, '4': 1, '5': 1, '10': 'serviceFee'},
    const {'1': 'total_amount', '3': 10, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'payment_gateway', '3': 13, '4': 1, '5': 9, '10': 'paymentGateway'},
    const {'1': 'gateway_reference', '3': 14, '4': 1, '5': 9, '10': 'gatewayReference'},
    const {'1': 'reference_number', '3': 15, '4': 1, '5': 9, '10': 'referenceNumber'},
    const {'1': 'token', '3': 16, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'units', '3': 17, '4': 1, '5': 1, '10': 'units'},
    const {'1': 'meter_type', '3': 18, '4': 1, '5': 9, '10': 'meterType'},
    const {'1': 'failure_reason', '3': 19, '4': 1, '5': 9, '10': 'failureReason'},
    const {'1': 'created_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'completed_at', '3': 21, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
    const {'1': 'provider_id', '3': 22, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'updated_at', '3': 23, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'error_message', '3': 24, '4': 1, '5': 9, '10': 'errorMessage'},
    const {'1': 'failed_at', '3': 25, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'failedAt'},
  ],
};

/// Descriptor for `BillPayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billPaymentDescriptor = $convert.base64Decode('CgtCaWxsUGF5bWVudBIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiMKDXByb3ZpZGVyX2NvZGUYAyABKAlSDHByb3ZpZGVyQ29kZRIjCg1wcm92aWRlcl9uYW1lGAQgASgJUgxwcm92aWRlck5hbWUSIQoMbWV0ZXJfbnVtYmVyGAUgASgJUgttZXRlck51bWJlchIjCg1jdXN0b21lcl9uYW1lGAYgASgJUgxjdXN0b21lck5hbWUSKQoQY3VzdG9tZXJfYWRkcmVzcxgHIAEoCVIPY3VzdG9tZXJBZGRyZXNzEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50Eh8KC3NlcnZpY2VfZmVlGAkgASgBUgpzZXJ2aWNlRmVlEiEKDHRvdGFsX2Ftb3VudBgKIAEoAVILdG90YWxBbW91bnQSGgoIY3VycmVuY3kYCyABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgMIAEoCVIGc3RhdHVzEicKD3BheW1lbnRfZ2F0ZXdheRgNIAEoCVIOcGF5bWVudEdhdGV3YXkSKwoRZ2F0ZXdheV9yZWZlcmVuY2UYDiABKAlSEGdhdGV3YXlSZWZlcmVuY2USKQoQcmVmZXJlbmNlX251bWJlchgPIAEoCVIPcmVmZXJlbmNlTnVtYmVyEhQKBXRva2VuGBAgASgJUgV0b2tlbhIUCgV1bml0cxgRIAEoAVIFdW5pdHMSHQoKbWV0ZXJfdHlwZRgSIAEoCVIJbWV0ZXJUeXBlEiUKDmZhaWx1cmVfcmVhc29uGBMgASgJUg1mYWlsdXJlUmVhc29uEjkKCmNyZWF0ZWRfYXQYFCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSPQoMY29tcGxldGVkX2F0GBUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILY29tcGxldGVkQXQSHwoLcHJvdmlkZXJfaWQYFiABKAlSCnByb3ZpZGVySWQSOQoKdXBkYXRlZF9hdBgXIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBIjCg1lcnJvcl9tZXNzYWdlGBggASgJUgxlcnJvck1lc3NhZ2USNwoJZmFpbGVkX2F0GBkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIZmFpbGVkQXQ=');
@$core.Deprecated('Use billBeneficiaryDescriptor instead')
const BillBeneficiary$json = const {
  '1': 'BillBeneficiary',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'meter_number', '3': 5, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'customer_name', '3': 6, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'nickname', '3': 7, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'meter_type', '3': 8, '4': 1, '5': 9, '10': 'meterType'},
    const {'1': 'is_default', '3': 9, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'last_used_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUsedAt'},
    const {'1': 'provider_id', '3': 12, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'customer_address', '3': 13, '4': 1, '5': 9, '10': 'customerAddress'},
    const {'1': 'updated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `BillBeneficiary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billBeneficiaryDescriptor = $convert.base64Decode('Cg9CaWxsQmVuZWZpY2lhcnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIjCg1wcm92aWRlcl9jb2RlGAMgASgJUgxwcm92aWRlckNvZGUSIwoNcHJvdmlkZXJfbmFtZRgEIAEoCVIMcHJvdmlkZXJOYW1lEiEKDG1ldGVyX251bWJlchgFIAEoCVILbWV0ZXJOdW1iZXISIwoNY3VzdG9tZXJfbmFtZRgGIAEoCVIMY3VzdG9tZXJOYW1lEhoKCG5pY2tuYW1lGAcgASgJUghuaWNrbmFtZRIdCgptZXRlcl90eXBlGAggASgJUgltZXRlclR5cGUSHQoKaXNfZGVmYXVsdBgJIAEoCFIJaXNEZWZhdWx0EjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSPAoMbGFzdF91c2VkX2F0GAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbGFzdFVzZWRBdBIfCgtwcm92aWRlcl9pZBgMIAEoCVIKcHJvdmlkZXJJZBIpChBjdXN0b21lcl9hZGRyZXNzGA0gASgJUg9jdXN0b21lckFkZHJlc3MSOQoKdXBkYXRlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use autoRechargeDescriptor instead')
const AutoRecharge$json = const {
  '1': 'AutoRecharge',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'meter_number', '3': 4, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 7, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 8, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 9, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'next_run_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextRunDate'},
    const {'1': 'last_run_date', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastRunDate'},
    const {'1': 'status', '3': 12, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'failure_count', '3': 13, '4': 1, '5': 5, '10': 'failureCount'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'beneficiary', '3': 15, '4': 1, '5': 11, '6': '.pb.BillBeneficiary', '10': 'beneficiary'},
    const {'1': 'provider_id', '3': 16, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'provider_code', '3': 17, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'provider_name', '3': 18, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'customer_name', '3': 19, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'meter_type', '3': 20, '4': 1, '5': 9, '10': 'meterType'},
    const {'1': 'max_retries', '3': 21, '4': 1, '5': 5, '10': 'maxRetries'},
    const {'1': 'updated_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `AutoRecharge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autoRechargeDescriptor = $convert.base64Decode('CgxBdXRvUmVjaGFyZ2USDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIlCg5iZW5lZmljaWFyeV9pZBgDIAEoCVINYmVuZWZpY2lhcnlJZBIhCgxtZXRlcl9udW1iZXIYBCABKAlSC21ldGVyTnVtYmVyEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIcCglmcmVxdWVuY3kYByABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zfd2VlaxgIIAEoBVIJZGF5T2ZXZWVrEiAKDGRheV9vZl9tb250aBgJIAEoBVIKZGF5T2ZNb250aBI+Cg1uZXh0X3J1bl9kYXRlGAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbmV4dFJ1bkRhdGUSPgoNbGFzdF9ydW5fZGF0ZRgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2xhc3RSdW5EYXRlEhYKBnN0YXR1cxgMIAEoCVIGc3RhdHVzEiMKDWZhaWx1cmVfY291bnQYDSABKAVSDGZhaWx1cmVDb3VudBI5CgpjcmVhdGVkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjUKC2JlbmVmaWNpYXJ5GA8gASgLMhMucGIuQmlsbEJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIfCgtwcm92aWRlcl9pZBgQIAEoCVIKcHJvdmlkZXJJZBIjCg1wcm92aWRlcl9jb2RlGBEgASgJUgxwcm92aWRlckNvZGUSIwoNcHJvdmlkZXJfbmFtZRgSIAEoCVIMcHJvdmlkZXJOYW1lEiMKDWN1c3RvbWVyX25hbWUYEyABKAlSDGN1c3RvbWVyTmFtZRIdCgptZXRlcl90eXBlGBQgASgJUgltZXRlclR5cGUSHwoLbWF4X3JldHJpZXMYFSABKAVSCm1heFJldHJpZXMSOQoKdXBkYXRlZF9hdBgWIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use billPaymentReminderDescriptor instead')
const BillPaymentReminder$json = const {
  '1': 'BillPaymentReminder',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'beneficiary_id', '3': 3, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'reminder_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'reminderDate'},
    const {'1': 'amount', '3': 7, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'is_recurring', '3': 8, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_type', '3': 9, '4': 1, '5': 9, '10': 'recurrenceType'},
    const {'1': 'status', '3': 10, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'notified_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'notifiedAt'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'currency', '3': 13, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'updated_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `BillPaymentReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List billPaymentReminderDescriptor = $convert.base64Decode('ChNCaWxsUGF5bWVudFJlbWluZGVyEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSJQoOYmVuZWZpY2lhcnlfaWQYAyABKAlSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUYBCABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAUgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgHIAEoAVIGYW1vdW50EiEKDGlzX3JlY3VycmluZxgIIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAkgASgJUg5yZWN1cnJlbmNlVHlwZRIWCgZzdGF0dXMYCiABKAlSBnN0YXR1cxI7Cgtub3RpZmllZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCm5vdGlmaWVkQXQSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBIaCghjdXJyZW5jeRgNIAEoCVIIY3VycmVuY3kSOQoKdXBkYXRlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use receiptDataDescriptor instead')
const ReceiptData$json = const {
  '1': 'ReceiptData',
  '2': const [
    const {'1': 'receipt_number', '3': 1, '4': 1, '5': 9, '10': 'receiptNumber'},
    const {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'meter_number', '3': 3, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'provider_name', '3': 4, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'amount_paid', '3': 5, '4': 1, '5': 1, '10': 'amountPaid'},
    const {'1': 'service_fee', '3': 6, '4': 1, '5': 1, '10': 'serviceFee'},
    const {'1': 'total_amount', '3': 7, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'token', '3': 8, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'units', '3': 9, '4': 1, '5': 1, '10': 'units'},
    const {'1': 'payment_date', '3': 10, '4': 1, '5': 9, '10': 'paymentDate'},
    const {'1': 'reference_number', '3': 11, '4': 1, '5': 9, '10': 'referenceNumber'},
  ],
};

/// Descriptor for `ReceiptData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiptDataDescriptor = $convert.base64Decode('CgtSZWNlaXB0RGF0YRIlCg5yZWNlaXB0X251bWJlchgBIAEoCVINcmVjZWlwdE51bWJlchIjCg1jdXN0b21lcl9uYW1lGAIgASgJUgxjdXN0b21lck5hbWUSIQoMbWV0ZXJfbnVtYmVyGAMgASgJUgttZXRlck51bWJlchIjCg1wcm92aWRlcl9uYW1lGAQgASgJUgxwcm92aWRlck5hbWUSHwoLYW1vdW50X3BhaWQYBSABKAFSCmFtb3VudFBhaWQSHwoLc2VydmljZV9mZWUYBiABKAFSCnNlcnZpY2VGZWUSIQoMdG90YWxfYW1vdW50GAcgASgBUgt0b3RhbEFtb3VudBIUCgV0b2tlbhgIIAEoCVIFdG9rZW4SFAoFdW5pdHMYCSABKAFSBXVuaXRzEiEKDHBheW1lbnRfZGF0ZRgKIAEoCVILcGF5bWVudERhdGUSKQoQcmVmZXJlbmNlX251bWJlchgLIAEoCVIPcmVmZXJlbmNlTnVtYmVy');
@$core.Deprecated('Use getProvidersRequestDescriptor instead')
const GetProvidersRequest$json = const {
  '1': 'GetProvidersRequest',
  '2': const [
    const {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'payment_gateway', '3': 2, '4': 1, '5': 9, '10': 'paymentGateway'},
  ],
};

/// Descriptor for `GetProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProvidersRequestDescriptor = $convert.base64Decode('ChNHZXRQcm92aWRlcnNSZXF1ZXN0EhgKB2NvdW50cnkYASABKAlSB2NvdW50cnkSJwoPcGF5bWVudF9nYXRld2F5GAIgASgJUg5wYXltZW50R2F0ZXdheQ==');
@$core.Deprecated('Use getProvidersResponseDescriptor instead')
const GetProvidersResponse$json = const {
  '1': 'GetProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.pb.ElectricityProvider', '10': 'providers'},
  ],
};

/// Descriptor for `GetProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProvidersResponseDescriptor = $convert.base64Decode('ChRHZXRQcm92aWRlcnNSZXNwb25zZRI1Cglwcm92aWRlcnMYASADKAsyFy5wYi5FbGVjdHJpY2l0eVByb3ZpZGVyUglwcm92aWRlcnM=');
@$core.Deprecated('Use syncProvidersRequestDescriptor instead')
const SyncProvidersRequest$json = const {
  '1': 'SyncProvidersRequest',
  '2': const [
    const {'1': 'payment_gateway', '3': 1, '4': 1, '5': 9, '10': 'paymentGateway'},
  ],
};

/// Descriptor for `SyncProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncProvidersRequestDescriptor = $convert.base64Decode('ChRTeW5jUHJvdmlkZXJzUmVxdWVzdBInCg9wYXltZW50X2dhdGV3YXkYASABKAlSDnBheW1lbnRHYXRld2F5');
@$core.Deprecated('Use syncProvidersResponseDescriptor instead')
const SyncProvidersResponse$json = const {
  '1': 'SyncProvidersResponse',
  '2': const [
    const {'1': 'synced_count', '3': 1, '4': 1, '5': 5, '10': 'syncedCount'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SyncProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncProvidersResponseDescriptor = $convert.base64Decode('ChVTeW5jUHJvdmlkZXJzUmVzcG9uc2USIQoMc3luY2VkX2NvdW50GAEgASgFUgtzeW5jZWRDb3VudBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use validateMeterRequestDescriptor instead')
const ValidateMeterRequest$json = const {
  '1': 'ValidateMeterRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'meter_type', '3': 3, '4': 1, '5': 9, '10': 'meterType'},
  ],
};

/// Descriptor for `ValidateMeterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateMeterRequestDescriptor = $convert.base64Decode('ChRWYWxpZGF0ZU1ldGVyUmVxdWVzdBIjCg1wcm92aWRlcl9jb2RlGAEgASgJUgxwcm92aWRlckNvZGUSIQoMbWV0ZXJfbnVtYmVyGAIgASgJUgttZXRlck51bWJlchIdCgptZXRlcl90eXBlGAMgASgJUgltZXRlclR5cGU=');
@$core.Deprecated('Use validateMeterResponseDescriptor instead')
const ValidateMeterResponse$json = const {
  '1': 'ValidateMeterResponse',
  '2': const [
    const {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    const {'1': 'customer_name', '3': 2, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'customer_address', '3': 3, '4': 1, '5': 9, '10': 'customerAddress'},
    const {'1': 'meter_type', '3': 4, '4': 1, '5': 9, '10': 'meterType'},
    const {'1': 'outstanding_balance', '3': 5, '4': 1, '5': 1, '10': 'outstandingBalance'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'meter_number', '3': 7, '4': 1, '5': 9, '10': 'meterNumber'},
  ],
};

/// Descriptor for `ValidateMeterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateMeterResponseDescriptor = $convert.base64Decode('ChVWYWxpZGF0ZU1ldGVyUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSIwoNY3VzdG9tZXJfbmFtZRgCIAEoCVIMY3VzdG9tZXJOYW1lEikKEGN1c3RvbWVyX2FkZHJlc3MYAyABKAlSD2N1c3RvbWVyQWRkcmVzcxIdCgptZXRlcl90eXBlGAQgASgJUgltZXRlclR5cGUSLwoTb3V0c3RhbmRpbmdfYmFsYW5jZRgFIAEoAVISb3V0c3RhbmRpbmdCYWxhbmNlEhgKB21lc3NhZ2UYBiABKAlSB21lc3NhZ2USIQoMbWV0ZXJfbnVtYmVyGAcgASgJUgttZXRlck51bWJlcg==');
@$core.Deprecated('Use getBillDetailsRequestDescriptor instead')
const GetBillDetailsRequest$json = const {
  '1': 'GetBillDetailsRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
  ],
};

/// Descriptor for `GetBillDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillDetailsRequestDescriptor = $convert.base64Decode('ChVHZXRCaWxsRGV0YWlsc1JlcXVlc3QSIwoNcHJvdmlkZXJfY29kZRgBIAEoCVIMcHJvdmlkZXJDb2RlEiEKDG1ldGVyX251bWJlchgCIAEoCVILbWV0ZXJOdW1iZXI=');
@$core.Deprecated('Use getBillDetailsResponseDescriptor instead')
const GetBillDetailsResponse$json = const {
  '1': 'GetBillDetailsResponse',
  '2': const [
    const {'1': 'customer_name', '3': 1, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'customer_address', '3': 2, '4': 1, '5': 9, '10': 'customerAddress'},
    const {'1': 'outstanding_amount', '3': 3, '4': 1, '5': 1, '10': 'outstandingAmount'},
    const {'1': 'due_date', '3': 4, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'meter_type', '3': 5, '4': 1, '5': 9, '10': 'meterType'},
  ],
};

/// Descriptor for `GetBillDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBillDetailsResponseDescriptor = $convert.base64Decode('ChZHZXRCaWxsRGV0YWlsc1Jlc3BvbnNlEiMKDWN1c3RvbWVyX25hbWUYASABKAlSDGN1c3RvbWVyTmFtZRIpChBjdXN0b21lcl9hZGRyZXNzGAIgASgJUg9jdXN0b21lckFkZHJlc3MSLQoSb3V0c3RhbmRpbmdfYW1vdW50GAMgASgBUhFvdXRzdGFuZGluZ0Ftb3VudBIZCghkdWVfZGF0ZRgEIAEoCVIHZHVlRGF0ZRIdCgptZXRlcl90eXBlGAUgASgJUgltZXRlclR5cGU=');
@$core.Deprecated('Use initiatePaymentRequestDescriptor instead')
const InitiatePaymentRequest$json = const {
  '1': 'InitiatePaymentRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'meter_type', '3': 5, '4': 1, '5': 9, '10': 'meterType'},
    const {'1': 'payment_gateway', '3': 6, '4': 1, '5': 9, '10': 'paymentGateway'},
    const {'1': 'source_account_id', '3': 7, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'beneficiary_id', '3': 8, '4': 1, '5': 9, '10': 'beneficiaryId'},
  ],
};

/// Descriptor for `InitiatePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiatePaymentRequestDescriptor = $convert.base64Decode('ChZJbml0aWF0ZVBheW1lbnRSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKAlSDHByb3ZpZGVyQ29kZRIhCgxtZXRlcl9udW1iZXIYAiABKAlSC21ldGVyTnVtYmVyEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIdCgptZXRlcl90eXBlGAUgASgJUgltZXRlclR5cGUSJwoPcGF5bWVudF9nYXRld2F5GAYgASgJUg5wYXltZW50R2F0ZXdheRIqChFzb3VyY2VfYWNjb3VudF9pZBgHIAEoCVIPc291cmNlQWNjb3VudElkEiUKDmJlbmVmaWNpYXJ5X2lkGAggASgJUg1iZW5lZmljaWFyeUlk');
@$core.Deprecated('Use initiatePaymentResponseDescriptor instead')
const InitiatePaymentResponse$json = const {
  '1': 'InitiatePaymentResponse',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'reference_number', '3': 2, '4': 1, '5': 9, '10': 'referenceNumber'},
    const {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'total_amount', '3': 4, '4': 1, '5': 1, '10': 'totalAmount'},
    const {'1': 'service_fee', '3': 5, '4': 1, '5': 1, '10': 'serviceFee'},
    const {'1': 'message', '3': 6, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InitiatePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiatePaymentResponseDescriptor = $convert.base64Decode('ChdJbml0aWF0ZVBheW1lbnRSZXNwb25zZRIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SWQSKQoQcmVmZXJlbmNlX251bWJlchgCIAEoCVIPcmVmZXJlbmNlTnVtYmVyEhYKBnN0YXR1cxgDIAEoCVIGc3RhdHVzEiEKDHRvdGFsX2Ftb3VudBgEIAEoAVILdG90YWxBbW91bnQSHwoLc2VydmljZV9mZWUYBSABKAFSCnNlcnZpY2VGZWUSGAoHbWVzc2FnZRgGIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use verifyPaymentRequestDescriptor instead')
const VerifyPaymentRequest$json = const {
  '1': 'VerifyPaymentRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    const {'1': 'reference_number', '3': 2, '4': 1, '5': 9, '10': 'referenceNumber'},
  ],
};

/// Descriptor for `VerifyPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPaymentRequestDescriptor = $convert.base64Decode('ChRWZXJpZnlQYXltZW50UmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SWQSKQoQcmVmZXJlbmNlX251bWJlchgCIAEoCVIPcmVmZXJlbmNlTnVtYmVy');
@$core.Deprecated('Use verifyPaymentResponseDescriptor instead')
const VerifyPaymentResponse$json = const {
  '1': 'VerifyPaymentResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.BillPayment', '10': 'payment'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `VerifyPaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPaymentResponseDescriptor = $convert.base64Decode('ChVWZXJpZnlQYXltZW50UmVzcG9uc2USKQoHcGF5bWVudBgBIAEoCzIPLnBiLkJpbGxQYXltZW50UgdwYXltZW50EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getPaymentHistoryRequestDescriptor instead')
const GetPaymentHistoryRequest$json = const {
  '1': 'GetPaymentHistoryRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetPaymentHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryRequestDescriptor = $convert.base64Decode('ChhHZXRQYXltZW50SGlzdG9yeVJlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm9mZnNldBgCIAEoBVIGb2Zmc2V0EiMKDXByb3ZpZGVyX2NvZGUYAyABKAlSDHByb3ZpZGVyQ29kZRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cw==');
@$core.Deprecated('Use getPaymentHistoryResponseDescriptor instead')
const GetPaymentHistoryResponse$json = const {
  '1': 'GetPaymentHistoryResponse',
  '2': const [
    const {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.pb.BillPayment', '10': 'payments'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetPaymentHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentHistoryResponseDescriptor = $convert.base64Decode('ChlHZXRQYXltZW50SGlzdG9yeVJlc3BvbnNlEisKCHBheW1lbnRzGAEgAygLMg8ucGIuQmlsbFBheW1lbnRSCHBheW1lbnRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use getPaymentReceiptRequestDescriptor instead')
const GetPaymentReceiptRequest$json = const {
  '1': 'GetPaymentReceiptRequest',
  '2': const [
    const {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GetPaymentReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentReceiptRequestDescriptor = $convert.base64Decode('ChhHZXRQYXltZW50UmVjZWlwdFJlcXVlc3QSHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudElk');
@$core.Deprecated('Use getPaymentReceiptResponseDescriptor instead')
const GetPaymentReceiptResponse$json = const {
  '1': 'GetPaymentReceiptResponse',
  '2': const [
    const {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.pb.BillPayment', '10': 'payment'},
    const {'1': 'receipt_data', '3': 2, '4': 1, '5': 11, '6': '.pb.ReceiptData', '10': 'receiptData'},
  ],
};

/// Descriptor for `GetPaymentReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentReceiptResponseDescriptor = $convert.base64Decode('ChlHZXRQYXltZW50UmVjZWlwdFJlc3BvbnNlEikKB3BheW1lbnQYASABKAsyDy5wYi5CaWxsUGF5bWVudFIHcGF5bWVudBIyCgxyZWNlaXB0X2RhdGEYAiABKAsyDy5wYi5SZWNlaXB0RGF0YVILcmVjZWlwdERhdGE=');
@$core.Deprecated('Use saveBeneficiaryRequestDescriptor instead')
const SaveBeneficiaryRequest$json = const {
  '1': 'SaveBeneficiaryRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'meter_number', '3': 2, '4': 1, '5': 9, '10': 'meterNumber'},
    const {'1': 'customer_name', '3': 3, '4': 1, '5': 9, '10': 'customerName'},
    const {'1': 'nickname', '3': 4, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'meter_type', '3': 5, '4': 1, '5': 9, '10': 'meterType'},
    const {'1': 'is_default', '3': 6, '4': 1, '5': 8, '10': 'isDefault'},
    const {'1': 'provider_id', '3': 7, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'provider_name', '3': 8, '4': 1, '5': 9, '10': 'providerName'},
    const {'1': 'customer_address', '3': 9, '4': 1, '5': 9, '10': 'customerAddress'},
  ],
};

/// Descriptor for `SaveBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBeneficiaryRequestDescriptor = $convert.base64Decode('ChZTYXZlQmVuZWZpY2lhcnlSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKAlSDHByb3ZpZGVyQ29kZRIhCgxtZXRlcl9udW1iZXIYAiABKAlSC21ldGVyTnVtYmVyEiMKDWN1c3RvbWVyX25hbWUYAyABKAlSDGN1c3RvbWVyTmFtZRIaCghuaWNrbmFtZRgEIAEoCVIIbmlja25hbWUSHQoKbWV0ZXJfdHlwZRgFIAEoCVIJbWV0ZXJUeXBlEh0KCmlzX2RlZmF1bHQYBiABKAhSCWlzRGVmYXVsdBIfCgtwcm92aWRlcl9pZBgHIAEoCVIKcHJvdmlkZXJJZBIjCg1wcm92aWRlcl9uYW1lGAggASgJUgxwcm92aWRlck5hbWUSKQoQY3VzdG9tZXJfYWRkcmVzcxgJIAEoCVIPY3VzdG9tZXJBZGRyZXNz');
@$core.Deprecated('Use saveBeneficiaryResponseDescriptor instead')
const SaveBeneficiaryResponse$json = const {
  '1': 'SaveBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.pb.BillBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SaveBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveBeneficiaryResponseDescriptor = $convert.base64Decode('ChdTYXZlQmVuZWZpY2lhcnlSZXNwb25zZRI1CgtiZW5lZmljaWFyeRgBIAEoCzITLnBiLkJpbGxCZW5lZmljaWFyeVILYmVuZWZpY2lhcnkSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getBeneficiariesRequestDescriptor instead')
const GetBeneficiariesRequest$json = const {
  '1': 'GetBeneficiariesRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `GetBeneficiariesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBeneficiariesRequestDescriptor = $convert.base64Decode('ChdHZXRCZW5lZmljaWFyaWVzUmVxdWVzdBIjCg1wcm92aWRlcl9jb2RlGAEgASgJUgxwcm92aWRlckNvZGU=');
@$core.Deprecated('Use getBeneficiariesResponseDescriptor instead')
const GetBeneficiariesResponse$json = const {
  '1': 'GetBeneficiariesResponse',
  '2': const [
    const {'1': 'beneficiaries', '3': 1, '4': 3, '5': 11, '6': '.pb.BillBeneficiary', '10': 'beneficiaries'},
  ],
};

/// Descriptor for `GetBeneficiariesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBeneficiariesResponseDescriptor = $convert.base64Decode('ChhHZXRCZW5lZmljaWFyaWVzUmVzcG9uc2USOQoNYmVuZWZpY2lhcmllcxgBIAMoCzITLnBiLkJpbGxCZW5lZmljaWFyeVINYmVuZWZpY2lhcmllcw==');
@$core.Deprecated('Use updateBeneficiaryRequestDescriptor instead')
const UpdateBeneficiaryRequest$json = const {
  '1': 'UpdateBeneficiaryRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'is_default', '3': 3, '4': 1, '5': 8, '10': 'isDefault'},
  ],
};

/// Descriptor for `UpdateBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBeneficiaryRequestDescriptor = $convert.base64Decode('ChhVcGRhdGVCZW5lZmljaWFyeVJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbmVmaWNpYXJ5SWQSGgoIbmlja25hbWUYAiABKAlSCG5pY2tuYW1lEh0KCmlzX2RlZmF1bHQYAyABKAhSCWlzRGVmYXVsdA==');
@$core.Deprecated('Use updateBeneficiaryResponseDescriptor instead')
const UpdateBeneficiaryResponse$json = const {
  '1': 'UpdateBeneficiaryResponse',
  '2': const [
    const {'1': 'beneficiary', '3': 1, '4': 1, '5': 11, '6': '.pb.BillBeneficiary', '10': 'beneficiary'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBeneficiaryResponseDescriptor = $convert.base64Decode('ChlVcGRhdGVCZW5lZmljaWFyeVJlc3BvbnNlEjUKC2JlbmVmaWNpYXJ5GAEgASgLMhMucGIuQmlsbEJlbmVmaWNpYXJ5UgtiZW5lZmljaWFyeRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use deleteBeneficiaryRequestDescriptor instead')
const DeleteBeneficiaryRequest$json = const {
  '1': 'DeleteBeneficiaryRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
  ],
};

/// Descriptor for `DeleteBeneficiaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBeneficiaryRequestDescriptor = $convert.base64Decode('ChhEZWxldGVCZW5lZmljaWFyeVJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbmVmaWNpYXJ5SWQ=');
@$core.Deprecated('Use deleteBeneficiaryResponseDescriptor instead')
const DeleteBeneficiaryResponse$json = const {
  '1': 'DeleteBeneficiaryResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteBeneficiaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBeneficiaryResponseDescriptor = $convert.base64Decode('ChlEZWxldGVCZW5lZmljaWFyeVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use createAutoRechargeRequestDescriptor instead')
const CreateAutoRechargeRequest$json = const {
  '1': 'CreateAutoRechargeRequest',
  '2': const [
    const {'1': 'beneficiary_id', '3': 1, '4': 1, '5': 9, '10': 'beneficiaryId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'frequency', '3': 4, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 5, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 6, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 7, '4': 1, '5': 5, '10': 'maxRetries'},
  ],
};

/// Descriptor for `CreateAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoRechargeRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVBdXRvUmVjaGFyZ2VSZXF1ZXN0EiUKDmJlbmVmaWNpYXJ5X2lkGAEgASgJUg1iZW5lZmljaWFyeUlkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIcCglmcmVxdWVuY3kYBCABKAlSCWZyZXF1ZW5jeRIeCgtkYXlfb2Zfd2VlaxgFIAEoBVIJZGF5T2ZXZWVrEiAKDGRheV9vZl9tb250aBgGIAEoBVIKZGF5T2ZNb250aBIfCgttYXhfcmV0cmllcxgHIAEoBVIKbWF4UmV0cmllcw==');
@$core.Deprecated('Use createAutoRechargeResponseDescriptor instead')
const CreateAutoRechargeResponse$json = const {
  '1': 'CreateAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.pb.AutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAutoRechargeResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVBdXRvUmVjaGFyZ2VSZXNwb25zZRI1Cg1hdXRvX3JlY2hhcmdlGAEgASgLMhAucGIuQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getAutoRechargesRequestDescriptor instead')
const GetAutoRechargesRequest$json = const {
  '1': 'GetAutoRechargesRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `GetAutoRechargesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoRechargesRequestDescriptor = $convert.base64Decode('ChdHZXRBdXRvUmVjaGFyZ2VzUmVxdWVzdBIWCgZzdGF0dXMYASABKAlSBnN0YXR1cw==');
@$core.Deprecated('Use getAutoRechargesResponseDescriptor instead')
const GetAutoRechargesResponse$json = const {
  '1': 'GetAutoRechargesResponse',
  '2': const [
    const {'1': 'auto_recharges', '3': 1, '4': 3, '5': 11, '6': '.pb.AutoRecharge', '10': 'autoRecharges'},
  ],
};

/// Descriptor for `GetAutoRechargesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAutoRechargesResponseDescriptor = $convert.base64Decode('ChhHZXRBdXRvUmVjaGFyZ2VzUmVzcG9uc2USNwoOYXV0b19yZWNoYXJnZXMYASADKAsyEC5wYi5BdXRvUmVjaGFyZ2VSDWF1dG9SZWNoYXJnZXM=');
@$core.Deprecated('Use updateAutoRechargeRequestDescriptor instead')
const UpdateAutoRechargeRequest$json = const {
  '1': 'UpdateAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'frequency', '3': 3, '4': 1, '5': 9, '10': 'frequency'},
    const {'1': 'day_of_week', '3': 4, '4': 1, '5': 5, '10': 'dayOfWeek'},
    const {'1': 'day_of_month', '3': 5, '4': 1, '5': 5, '10': 'dayOfMonth'},
    const {'1': 'max_retries', '3': 6, '4': 1, '5': 5, '10': 'maxRetries'},
  ],
};

/// Descriptor for `UpdateAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoRechargeRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDmF1dG9SZWNoYXJnZUlkEhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhwKCWZyZXF1ZW5jeRgDIAEoCVIJZnJlcXVlbmN5Eh4KC2RheV9vZl93ZWVrGAQgASgFUglkYXlPZldlZWsSIAoMZGF5X29mX21vbnRoGAUgASgFUgpkYXlPZk1vbnRoEh8KC21heF9yZXRyaWVzGAYgASgFUgptYXhSZXRyaWVz');
@$core.Deprecated('Use updateAutoRechargeResponseDescriptor instead')
const UpdateAutoRechargeResponse$json = const {
  '1': 'UpdateAutoRechargeResponse',
  '2': const [
    const {'1': 'auto_recharge', '3': 1, '4': 1, '5': 11, '6': '.pb.AutoRecharge', '10': 'autoRecharge'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAutoRechargeResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVBdXRvUmVjaGFyZ2VSZXNwb25zZRI1Cg1hdXRvX3JlY2hhcmdlGAEgASgLMhAucGIuQXV0b1JlY2hhcmdlUgxhdXRvUmVjaGFyZ2USGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteAutoRechargeRequestDescriptor instead')
const DeleteAutoRechargeRequest$json = const {
  '1': 'DeleteAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `DeleteAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoRechargeRequestDescriptor = $convert.base64Decode('ChlEZWxldGVBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDmF1dG9SZWNoYXJnZUlk');
@$core.Deprecated('Use deleteAutoRechargeResponseDescriptor instead')
const DeleteAutoRechargeResponse$json = const {
  '1': 'DeleteAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAutoRechargeResponseDescriptor = $convert.base64Decode('ChpEZWxldGVBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use pauseAutoRechargeRequestDescriptor instead')
const PauseAutoRechargeRequest$json = const {
  '1': 'PauseAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `PauseAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseAutoRechargeRequestDescriptor = $convert.base64Decode('ChhQYXVzZUF1dG9SZWNoYXJnZVJlcXVlc3QSKAoQYXV0b19yZWNoYXJnZV9pZBgBIAEoCVIOYXV0b1JlY2hhcmdlSWQ=');
@$core.Deprecated('Use pauseAutoRechargeResponseDescriptor instead')
const PauseAutoRechargeResponse$json = const {
  '1': 'PauseAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PauseAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseAutoRechargeResponseDescriptor = $convert.base64Decode('ChlQYXVzZUF1dG9SZWNoYXJnZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use resumeAutoRechargeRequestDescriptor instead')
const ResumeAutoRechargeRequest$json = const {
  '1': 'ResumeAutoRechargeRequest',
  '2': const [
    const {'1': 'auto_recharge_id', '3': 1, '4': 1, '5': 9, '10': 'autoRechargeId'},
  ],
};

/// Descriptor for `ResumeAutoRechargeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeAutoRechargeRequestDescriptor = $convert.base64Decode('ChlSZXN1bWVBdXRvUmVjaGFyZ2VSZXF1ZXN0EigKEGF1dG9fcmVjaGFyZ2VfaWQYASABKAlSDmF1dG9SZWNoYXJnZUlk');
@$core.Deprecated('Use resumeAutoRechargeResponseDescriptor instead')
const ResumeAutoRechargeResponse$json = const {
  '1': 'ResumeAutoRechargeResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResumeAutoRechargeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resumeAutoRechargeResponseDescriptor = $convert.base64Decode('ChpSZXN1bWVBdXRvUmVjaGFyZ2VSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use createReminderRequestDescriptor instead')
const CreateReminderRequest$json = const {
  '1': 'CreateReminderRequest',
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

/// Descriptor for `CreateReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createReminderRequestDescriptor = $convert.base64Decode('ChVDcmVhdGVSZW1pbmRlclJlcXVlc3QSJQoOYmVuZWZpY2lhcnlfaWQYASABKAlSDWJlbmVmaWNpYXJ5SWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EiEKDGlzX3JlY3VycmluZxgGIAEoCFILaXNSZWN1cnJpbmcSJwoPcmVjdXJyZW5jZV90eXBlGAcgASgJUg5yZWN1cnJlbmNlVHlwZRIaCghjdXJyZW5jeRgIIAEoCVIIY3VycmVuY3k=');
@$core.Deprecated('Use createReminderResponseDescriptor instead')
const CreateReminderResponse$json = const {
  '1': 'CreateReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.pb.BillPaymentReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createReminderResponseDescriptor = $convert.base64Decode('ChZDcmVhdGVSZW1pbmRlclJlc3BvbnNlEjMKCHJlbWluZGVyGAEgASgLMhcucGIuQmlsbFBheW1lbnRSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getRemindersRequestDescriptor instead')
const GetRemindersRequest$json = const {
  '1': 'GetRemindersRequest',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'include_past', '3': 2, '4': 1, '5': 8, '10': 'includePast'},
  ],
};

/// Descriptor for `GetRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRemindersRequestDescriptor = $convert.base64Decode('ChNHZXRSZW1pbmRlcnNSZXF1ZXN0EhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEiEKDGluY2x1ZGVfcGFzdBgCIAEoCFILaW5jbHVkZVBhc3Q=');
@$core.Deprecated('Use getRemindersResponseDescriptor instead')
const GetRemindersResponse$json = const {
  '1': 'GetRemindersResponse',
  '2': const [
    const {'1': 'reminders', '3': 1, '4': 3, '5': 11, '6': '.pb.BillPaymentReminder', '10': 'reminders'},
  ],
};

/// Descriptor for `GetRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRemindersResponseDescriptor = $convert.base64Decode('ChRHZXRSZW1pbmRlcnNSZXNwb25zZRI1CglyZW1pbmRlcnMYASADKAsyFy5wYi5CaWxsUGF5bWVudFJlbWluZGVyUglyZW1pbmRlcnM=');
@$core.Deprecated('Use updateReminderRequestDescriptor instead')
const UpdateReminderRequest$json = const {
  '1': 'UpdateReminderRequest',
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

/// Descriptor for `UpdateReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateReminderRequestDescriptor = $convert.base64Decode('ChVVcGRhdGVSZW1pbmRlclJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbWluZGVySWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhI/Cg1yZW1pbmRlcl9kYXRlGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMcmVtaW5kZXJEYXRlEhYKBmFtb3VudBgFIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIhCgxpc19yZWN1cnJpbmcYByABKAhSC2lzUmVjdXJyaW5nEicKD3JlY3VycmVuY2VfdHlwZRgIIAEoCVIOcmVjdXJyZW5jZVR5cGU=');
@$core.Deprecated('Use updateReminderResponseDescriptor instead')
const UpdateReminderResponse$json = const {
  '1': 'UpdateReminderResponse',
  '2': const [
    const {'1': 'reminder', '3': 1, '4': 1, '5': 11, '6': '.pb.BillPaymentReminder', '10': 'reminder'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `UpdateReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateReminderResponseDescriptor = $convert.base64Decode('ChZVcGRhdGVSZW1pbmRlclJlc3BvbnNlEjMKCHJlbWluZGVyGAEgASgLMhcucGIuQmlsbFBheW1lbnRSZW1pbmRlclIIcmVtaW5kZXISGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use deleteReminderRequestDescriptor instead')
const DeleteReminderRequest$json = const {
  '1': 'DeleteReminderRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `DeleteReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteReminderRequestDescriptor = $convert.base64Decode('ChVEZWxldGVSZW1pbmRlclJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbWluZGVySWQ=');
@$core.Deprecated('Use deleteReminderResponseDescriptor instead')
const DeleteReminderResponse$json = const {
  '1': 'DeleteReminderResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteReminderResponseDescriptor = $convert.base64Decode('ChZEZWxldGVSZW1pbmRlclJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use markReminderCompleteRequestDescriptor instead')
const MarkReminderCompleteRequest$json = const {
  '1': 'MarkReminderCompleteRequest',
  '2': const [
    const {'1': 'reminder_id', '3': 1, '4': 1, '5': 9, '10': 'reminderId'},
  ],
};

/// Descriptor for `MarkReminderCompleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markReminderCompleteRequestDescriptor = $convert.base64Decode('ChtNYXJrUmVtaW5kZXJDb21wbGV0ZVJlcXVlc3QSHwoLcmVtaW5kZXJfaWQYASABKAlSCnJlbWluZGVySWQ=');
@$core.Deprecated('Use markReminderCompleteResponseDescriptor instead')
const MarkReminderCompleteResponse$json = const {
  '1': 'MarkReminderCompleteResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `MarkReminderCompleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markReminderCompleteResponseDescriptor = $convert.base64Decode('ChxNYXJrUmVtaW5kZXJDb21wbGV0ZVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
