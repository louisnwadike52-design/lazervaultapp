///
//  Generated code. Do not modify.
//  source: id_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use iDPayTypeDescriptor instead')
const IDPayType$json = const {
  '1': 'IDPayType',
  '2': const [
    const {'1': 'ID_PAY_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'ID_PAY_ONE_TIME', '2': 1},
    const {'1': 'ID_PAY_RECURRING', '2': 2},
  ],
};

/// Descriptor for `IDPayType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List iDPayTypeDescriptor = $convert.base64Decode('CglJRFBheVR5cGUSGwoXSURfUEFZX1RZUEVfVU5TUEVDSUZJRUQQABITCg9JRF9QQVlfT05FX1RJTUUQARIUChBJRF9QQVlfUkVDVVJSSU5HEAI=');
@$core.Deprecated('Use iDPayAmountModeDescriptor instead')
const IDPayAmountMode$json = const {
  '1': 'IDPayAmountMode',
  '2': const [
    const {'1': 'ID_PAY_AMOUNT_UNSPECIFIED', '2': 0},
    const {'1': 'ID_PAY_FIXED', '2': 1},
    const {'1': 'ID_PAY_FLEXIBLE', '2': 2},
  ],
};

/// Descriptor for `IDPayAmountMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List iDPayAmountModeDescriptor = $convert.base64Decode('Cg9JRFBheUFtb3VudE1vZGUSHQoZSURfUEFZX0FNT1VOVF9VTlNQRUNJRklFRBAAEhAKDElEX1BBWV9GSVhFRBABEhMKD0lEX1BBWV9GTEVYSUJMRRAC');
@$core.Deprecated('Use iDPayStatusDescriptor instead')
const IDPayStatus$json = const {
  '1': 'IDPayStatus',
  '2': const [
    const {'1': 'ID_PAY_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'ID_PAY_ACTIVE', '2': 1},
    const {'1': 'ID_PAY_PAID', '2': 2},
    const {'1': 'ID_PAY_EXPIRED', '2': 3},
    const {'1': 'ID_PAY_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `IDPayStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List iDPayStatusDescriptor = $convert.base64Decode('CgtJRFBheVN0YXR1cxIdChlJRF9QQVlfU1RBVFVTX1VOU1BFQ0lGSUVEEAASEQoNSURfUEFZX0FDVElWRRABEg8KC0lEX1BBWV9QQUlEEAISEgoOSURfUEFZX0VYUElSRUQQAxIUChBJRF9QQVlfQ0FOQ0VMTEVEEAQ=');
@$core.Deprecated('Use iDPayDescriptor instead')
const IDPay$json = const {
  '1': 'IDPay',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'pay_id', '3': 2, '4': 1, '5': 9, '10': 'payId'},
    const {'1': 'creator_id', '3': 3, '4': 1, '5': 9, '10': 'creatorId'},
    const {'1': 'creator_name', '3': 4, '4': 1, '5': 9, '10': 'creatorName'},
    const {'1': 'creator_username', '3': 5, '4': 1, '5': 9, '10': 'creatorUsername'},
    const {'1': 'type', '3': 6, '4': 1, '5': 14, '6': '.id_pay.IDPayType', '10': 'type'},
    const {'1': 'amount_mode', '3': 7, '4': 1, '5': 14, '6': '.id_pay.IDPayAmountMode', '10': 'amountMode'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'min_amount', '3': 9, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 10, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 12, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 13, '4': 1, '5': 14, '6': '.id_pay.IDPayStatus', '10': 'status'},
    const {'1': 'expires_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'created_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'total_received', '3': 16, '4': 1, '5': 1, '10': 'totalReceived'},
    const {'1': 'payment_count', '3': 17, '4': 1, '5': 5, '10': 'paymentCount'},
    const {'1': 'never_expires', '3': 18, '4': 1, '5': 8, '10': 'neverExpires'},
    const {'1': 'organization_id', '3': 19, '4': 1, '5': 9, '10': 'organizationId'},
    const {'1': 'organization_name', '3': 20, '4': 1, '5': 9, '10': 'organizationName'},
  ],
};

/// Descriptor for `IDPay`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iDPayDescriptor = $convert.base64Decode('CgVJRFBheRIOCgJpZBgBIAEoCVICaWQSFQoGcGF5X2lkGAIgASgJUgVwYXlJZBIdCgpjcmVhdG9yX2lkGAMgASgJUgljcmVhdG9ySWQSIQoMY3JlYXRvcl9uYW1lGAQgASgJUgtjcmVhdG9yTmFtZRIpChBjcmVhdG9yX3VzZXJuYW1lGAUgASgJUg9jcmVhdG9yVXNlcm5hbWUSJQoEdHlwZRgGIAEoDjIRLmlkX3BheS5JRFBheVR5cGVSBHR5cGUSOAoLYW1vdW50X21vZGUYByABKA4yFy5pZF9wYXkuSURQYXlBbW91bnRNb2RlUgphbW91bnRNb2RlEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50Eh0KCm1pbl9hbW91bnQYCSABKAFSCW1pbkFtb3VudBIdCgptYXhfYW1vdW50GAogASgBUgltYXhBbW91bnQSGgoIY3VycmVuY3kYCyABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAwgASgJUgtkZXNjcmlwdGlvbhIrCgZzdGF0dXMYDSABKA4yEy5pZF9wYXkuSURQYXlTdGF0dXNSBnN0YXR1cxI5CgpleHBpcmVzX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZXhwaXJlc0F0EjkKCmNyZWF0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSJQoOdG90YWxfcmVjZWl2ZWQYECABKAFSDXRvdGFsUmVjZWl2ZWQSIwoNcGF5bWVudF9jb3VudBgRIAEoBVIMcGF5bWVudENvdW50EiMKDW5ldmVyX2V4cGlyZXMYEiABKAhSDG5ldmVyRXhwaXJlcxInCg9vcmdhbml6YXRpb25faWQYEyABKAlSDm9yZ2FuaXphdGlvbklkEisKEW9yZ2FuaXphdGlvbl9uYW1lGBQgASgJUhBvcmdhbml6YXRpb25OYW1l');
@$core.Deprecated('Use iDPayTransactionDescriptor instead')
const IDPayTransaction$json = const {
  '1': 'IDPayTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'pay_id', '3': 2, '4': 1, '5': 9, '10': 'payId'},
    const {'1': 'payer_id', '3': 3, '4': 1, '5': 9, '10': 'payerId'},
    const {'1': 'payer_name', '3': 4, '4': 1, '5': 9, '10': 'payerName'},
    const {'1': 'payer_username', '3': 5, '4': 1, '5': 9, '10': 'payerUsername'},
    const {'1': 'recipient_id', '3': 6, '4': 1, '5': 9, '10': 'recipientId'},
    const {'1': 'recipient_name', '3': 7, '4': 1, '5': 9, '10': 'recipientName'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'reference', '3': 10, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'status', '3': 11, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `IDPayTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iDPayTransactionDescriptor = $convert.base64Decode('ChBJRFBheVRyYW5zYWN0aW9uEg4KAmlkGAEgASgJUgJpZBIVCgZwYXlfaWQYAiABKAlSBXBheUlkEhkKCHBheWVyX2lkGAMgASgJUgdwYXllcklkEh0KCnBheWVyX25hbWUYBCABKAlSCXBheWVyTmFtZRIlCg5wYXllcl91c2VybmFtZRgFIAEoCVINcGF5ZXJVc2VybmFtZRIhCgxyZWNpcGllbnRfaWQYBiABKAlSC3JlY2lwaWVudElkEiUKDnJlY2lwaWVudF9uYW1lGAcgASgJUg1yZWNpcGllbnROYW1lEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeRIcCglyZWZlcmVuY2UYCiABKAlSCXJlZmVyZW5jZRIWCgZzdGF0dXMYCyABKAlSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');
@$core.Deprecated('Use iDPayOrganizationDescriptor instead')
const IDPayOrganization$json = const {
  '1': 'IDPayOrganization',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'creator_id', '3': 2, '4': 1, '5': 9, '10': 'creatorId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'logo_url', '3': 5, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'account_id', '3': 6, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'total_received', '3': 7, '4': 1, '5': 1, '10': 'totalReceived'},
    const {'1': 'total_payment_count', '3': 8, '4': 1, '5': 5, '10': 'totalPaymentCount'},
    const {'1': 'active_id_pay_count', '3': 9, '4': 1, '5': 5, '10': 'activeIdPayCount'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `IDPayOrganization`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iDPayOrganizationDescriptor = $convert.base64Decode('ChFJRFBheU9yZ2FuaXphdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKY3JlYXRvcl9pZBgCIAEoCVIJY3JlYXRvcklkEhIKBG5hbWUYAyABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhkKCGxvZ29fdXJsGAUgASgJUgdsb2dvVXJsEh0KCmFjY291bnRfaWQYBiABKAlSCWFjY291bnRJZBIlCg50b3RhbF9yZWNlaXZlZBgHIAEoAVINdG90YWxSZWNlaXZlZBIuChN0b3RhbF9wYXltZW50X2NvdW50GAggASgFUhF0b3RhbFBheW1lbnRDb3VudBItChNhY3RpdmVfaWRfcGF5X2NvdW50GAkgASgFUhBhY3RpdmVJZFBheUNvdW50EjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use createIDPayRequestDescriptor instead')
const CreateIDPayRequest$json = const {
  '1': 'CreateIDPayRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.id_pay.IDPayType', '10': 'type'},
    const {'1': 'amount_mode', '3': 2, '4': 1, '5': 14, '6': '.id_pay.IDPayAmountMode', '10': 'amountMode'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 4, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'min_amount', '3': 5, '4': 1, '5': 1, '10': 'minAmount'},
    const {'1': 'max_amount', '3': 6, '4': 1, '5': 1, '10': 'maxAmount'},
    const {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'validity_minutes', '3': 8, '4': 1, '5': 5, '10': 'validityMinutes'},
    const {'1': 'recipient_account_id', '3': 9, '4': 1, '5': 9, '10': 'recipientAccountId'},
    const {'1': 'never_expires', '3': 10, '4': 1, '5': 8, '10': 'neverExpires'},
    const {'1': 'organization_id', '3': 11, '4': 1, '5': 9, '10': 'organizationId'},
  ],
};

/// Descriptor for `CreateIDPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createIDPayRequestDescriptor = $convert.base64Decode('ChJDcmVhdGVJRFBheVJlcXVlc3QSJQoEdHlwZRgBIAEoDjIRLmlkX3BheS5JRFBheVR5cGVSBHR5cGUSOAoLYW1vdW50X21vZGUYAiABKA4yFy5pZF9wYXkuSURQYXlBbW91bnRNb2RlUgphbW91bnRNb2RlEhYKBmFtb3VudBgDIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAQgASgJUghjdXJyZW5jeRIdCgptaW5fYW1vdW50GAUgASgBUgltaW5BbW91bnQSHQoKbWF4X2Ftb3VudBgGIAEoAVIJbWF4QW1vdW50EiAKC2Rlc2NyaXB0aW9uGAcgASgJUgtkZXNjcmlwdGlvbhIpChB2YWxpZGl0eV9taW51dGVzGAggASgFUg92YWxpZGl0eU1pbnV0ZXMSMAoUcmVjaXBpZW50X2FjY291bnRfaWQYCSABKAlSEnJlY2lwaWVudEFjY291bnRJZBIjCg1uZXZlcl9leHBpcmVzGAogASgIUgxuZXZlckV4cGlyZXMSJwoPb3JnYW5pemF0aW9uX2lkGAsgASgJUg5vcmdhbml6YXRpb25JZA==');
@$core.Deprecated('Use createIDPayResponseDescriptor instead')
const CreateIDPayResponse$json = const {
  '1': 'CreateIDPayResponse',
  '2': const [
    const {'1': 'id_pay', '3': 1, '4': 1, '5': 11, '6': '.id_pay.IDPay', '10': 'idPay'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateIDPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createIDPayResponseDescriptor = $convert.base64Decode('ChNDcmVhdGVJRFBheVJlc3BvbnNlEiQKBmlkX3BheRgBIAEoCzINLmlkX3BheS5JRFBheVIFaWRQYXkSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use lookupIDPayRequestDescriptor instead')
const LookupIDPayRequest$json = const {
  '1': 'LookupIDPayRequest',
  '2': const [
    const {'1': 'pay_id', '3': 1, '4': 1, '5': 9, '10': 'payId'},
  ],
};

/// Descriptor for `LookupIDPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupIDPayRequestDescriptor = $convert.base64Decode('ChJMb29rdXBJRFBheVJlcXVlc3QSFQoGcGF5X2lkGAEgASgJUgVwYXlJZA==');
@$core.Deprecated('Use lookupIDPayResponseDescriptor instead')
const LookupIDPayResponse$json = const {
  '1': 'LookupIDPayResponse',
  '2': const [
    const {'1': 'id_pay', '3': 1, '4': 1, '5': 11, '6': '.id_pay.IDPay', '10': 'idPay'},
    const {'1': 'organization', '3': 2, '4': 1, '5': 11, '6': '.id_pay.IDPayOrganization', '10': 'organization'},
  ],
};

/// Descriptor for `LookupIDPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupIDPayResponseDescriptor = $convert.base64Decode('ChNMb29rdXBJRFBheVJlc3BvbnNlEiQKBmlkX3BheRgBIAEoCzINLmlkX3BheS5JRFBheVIFaWRQYXkSPQoMb3JnYW5pemF0aW9uGAIgASgLMhkuaWRfcGF5LklEUGF5T3JnYW5pemF0aW9uUgxvcmdhbml6YXRpb24=');
@$core.Deprecated('Use payIDPayRequestDescriptor instead')
const PayIDPayRequest$json = const {
  '1': 'PayIDPayRequest',
  '2': const [
    const {'1': 'pay_id', '3': 1, '4': 1, '5': 9, '10': 'payId'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'source_account_id', '3': 4, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'idempotency_key', '3': 5, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `PayIDPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payIDPayRequestDescriptor = $convert.base64Decode('Cg9QYXlJRFBheVJlcXVlc3QSFQoGcGF5X2lkGAEgASgJUgVwYXlJZBIWCgZhbW91bnQYAiABKAFSBmFtb3VudBInCg90cmFuc2FjdGlvbl9waW4YAyABKAlSDnRyYW5zYWN0aW9uUGluEioKEXNvdXJjZV9hY2NvdW50X2lkGAQgASgJUg9zb3VyY2VBY2NvdW50SWQSJwoPaWRlbXBvdGVuY3lfa2V5GAUgASgJUg5pZGVtcG90ZW5jeUtleQ==');
@$core.Deprecated('Use payIDPayResponseDescriptor instead')
const PayIDPayResponse$json = const {
  '1': 'PayIDPayResponse',
  '2': const [
    const {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.id_pay.IDPayTransaction', '10': 'transaction'},
    const {'1': 'new_balance', '3': 2, '4': 1, '5': 1, '10': 'newBalance'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PayIDPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payIDPayResponseDescriptor = $convert.base64Decode('ChBQYXlJRFBheVJlc3BvbnNlEjoKC3RyYW5zYWN0aW9uGAEgASgLMhguaWRfcGF5LklEUGF5VHJhbnNhY3Rpb25SC3RyYW5zYWN0aW9uEh8KC25ld19iYWxhbmNlGAIgASgBUgpuZXdCYWxhbmNlEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getMyIDPaysRequestDescriptor instead')
const GetMyIDPaysRequest$json = const {
  '1': 'GetMyIDPaysRequest',
  '2': const [
    const {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    const {'1': 'status_filter', '3': 3, '4': 1, '5': 14, '6': '.id_pay.IDPayStatus', '10': 'statusFilter'},
  ],
};

/// Descriptor for `GetMyIDPaysRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyIDPaysRequestDescriptor = $convert.base64Decode('ChJHZXRNeUlEUGF5c1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EhYKBm9mZnNldBgCIAEoBVIGb2Zmc2V0EjgKDXN0YXR1c19maWx0ZXIYAyABKA4yEy5pZF9wYXkuSURQYXlTdGF0dXNSDHN0YXR1c0ZpbHRlcg==');
@$core.Deprecated('Use getMyIDPaysResponseDescriptor instead')
const GetMyIDPaysResponse$json = const {
  '1': 'GetMyIDPaysResponse',
  '2': const [
    const {'1': 'id_pays', '3': 1, '4': 3, '5': 11, '6': '.id_pay.IDPay', '10': 'idPays'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyIDPaysResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyIDPaysResponseDescriptor = $convert.base64Decode('ChNHZXRNeUlEUGF5c1Jlc3BvbnNlEiYKB2lkX3BheXMYASADKAsyDS5pZF9wYXkuSURQYXlSBmlkUGF5cxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use getIDPayTransactionsRequestDescriptor instead')
const GetIDPayTransactionsRequest$json = const {
  '1': 'GetIDPayTransactionsRequest',
  '2': const [
    const {'1': 'pay_id', '3': 1, '4': 1, '5': 9, '10': 'payId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetIDPayTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIDPayTransactionsRequestDescriptor = $convert.base64Decode('ChtHZXRJRFBheVRyYW5zYWN0aW9uc1JlcXVlc3QSFQoGcGF5X2lkGAEgASgJUgVwYXlJZBIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getIDPayTransactionsResponseDescriptor instead')
const GetIDPayTransactionsResponse$json = const {
  '1': 'GetIDPayTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.id_pay.IDPayTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetIDPayTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIDPayTransactionsResponseDescriptor = $convert.base64Decode('ChxHZXRJRFBheVRyYW5zYWN0aW9uc1Jlc3BvbnNlEjwKDHRyYW5zYWN0aW9ucxgBIAMoCzIYLmlkX3BheS5JRFBheVRyYW5zYWN0aW9uUgx0cmFuc2FjdGlvbnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');
@$core.Deprecated('Use cancelIDPayRequestDescriptor instead')
const CancelIDPayRequest$json = const {
  '1': 'CancelIDPayRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `CancelIDPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelIDPayRequestDescriptor = $convert.base64Decode('ChJDYW5jZWxJRFBheVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use cancelIDPayResponseDescriptor instead')
const CancelIDPayResponse$json = const {
  '1': 'CancelIDPayResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CancelIDPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelIDPayResponseDescriptor = $convert.base64Decode('ChNDYW5jZWxJRFBheVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use getIDPayDetailsRequestDescriptor instead')
const GetIDPayDetailsRequest$json = const {
  '1': 'GetIDPayDetailsRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetIDPayDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIDPayDetailsRequestDescriptor = $convert.base64Decode('ChZHZXRJRFBheURldGFpbHNSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use getIDPayDetailsResponseDescriptor instead')
const GetIDPayDetailsResponse$json = const {
  '1': 'GetIDPayDetailsResponse',
  '2': const [
    const {'1': 'id_pay', '3': 1, '4': 1, '5': 11, '6': '.id_pay.IDPay', '10': 'idPay'},
  ],
};

/// Descriptor for `GetIDPayDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIDPayDetailsResponseDescriptor = $convert.base64Decode('ChdHZXRJRFBheURldGFpbHNSZXNwb25zZRIkCgZpZF9wYXkYASABKAsyDS5pZF9wYXkuSURQYXlSBWlkUGF5');
@$core.Deprecated('Use createOrganizationRequestDescriptor instead')
const CreateOrganizationRequest$json = const {
  '1': 'CreateOrganizationRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'account_id', '3': 4, '4': 1, '5': 9, '10': 'accountId'},
  ],
};

/// Descriptor for `CreateOrganizationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrganizationRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVPcmdhbml6YXRpb25SZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEhkKCGxvZ29fdXJsGAMgASgJUgdsb2dvVXJsEh0KCmFjY291bnRfaWQYBCABKAlSCWFjY291bnRJZA==');
@$core.Deprecated('Use createOrganizationResponseDescriptor instead')
const CreateOrganizationResponse$json = const {
  '1': 'CreateOrganizationResponse',
  '2': const [
    const {'1': 'organization', '3': 1, '4': 1, '5': 11, '6': '.id_pay.IDPayOrganization', '10': 'organization'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CreateOrganizationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrganizationResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVPcmdhbml6YXRpb25SZXNwb25zZRI9Cgxvcmdhbml6YXRpb24YASABKAsyGS5pZF9wYXkuSURQYXlPcmdhbml6YXRpb25SDG9yZ2FuaXphdGlvbhIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getMyOrganizationsRequestDescriptor instead')
const GetMyOrganizationsRequest$json = const {
  '1': 'GetMyOrganizationsRequest',
  '2': const [
    const {'1': 'account_id', '3': 1, '4': 1, '5': 9, '10': 'accountId'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetMyOrganizationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyOrganizationsRequestDescriptor = $convert.base64Decode('ChlHZXRNeU9yZ2FuaXphdGlvbnNSZXF1ZXN0Eh0KCmFjY291bnRfaWQYASABKAlSCWFjY291bnRJZBIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');
@$core.Deprecated('Use getMyOrganizationsResponseDescriptor instead')
const GetMyOrganizationsResponse$json = const {
  '1': 'GetMyOrganizationsResponse',
  '2': const [
    const {'1': 'organizations', '3': 1, '4': 3, '5': 11, '6': '.id_pay.IDPayOrganization', '10': 'organizations'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetMyOrganizationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyOrganizationsResponseDescriptor = $convert.base64Decode('ChpHZXRNeU9yZ2FuaXphdGlvbnNSZXNwb25zZRI/Cg1vcmdhbml6YXRpb25zGAEgAygLMhkuaWRfcGF5LklEUGF5T3JnYW5pemF0aW9uUg1vcmdhbml6YXRpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use updateOrganizationRequestDescriptor instead')
const UpdateOrganizationRequest$json = const {
  '1': 'UpdateOrganizationRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'logo_url', '3': 4, '4': 1, '5': 9, '10': 'logoUrl'},
  ],
};

/// Descriptor for `UpdateOrganizationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateOrganizationRequestDescriptor = $convert.base64Decode('ChlVcGRhdGVPcmdhbml6YXRpb25SZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIZCghsb2dvX3VybBgEIAEoCVIHbG9nb1VybA==');
@$core.Deprecated('Use updateOrganizationResponseDescriptor instead')
const UpdateOrganizationResponse$json = const {
  '1': 'UpdateOrganizationResponse',
  '2': const [
    const {'1': 'organization', '3': 1, '4': 1, '5': 11, '6': '.id_pay.IDPayOrganization', '10': 'organization'},
  ],
};

/// Descriptor for `UpdateOrganizationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateOrganizationResponseDescriptor = $convert.base64Decode('ChpVcGRhdGVPcmdhbml6YXRpb25SZXNwb25zZRI9Cgxvcmdhbml6YXRpb24YASABKAsyGS5pZF9wYXkuSURQYXlPcmdhbml6YXRpb25SDG9yZ2FuaXphdGlvbg==');
@$core.Deprecated('Use deleteOrganizationRequestDescriptor instead')
const DeleteOrganizationRequest$json = const {
  '1': 'DeleteOrganizationRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteOrganizationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteOrganizationRequestDescriptor = $convert.base64Decode('ChlEZWxldGVPcmdhbml6YXRpb25SZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use deleteOrganizationResponseDescriptor instead')
const DeleteOrganizationResponse$json = const {
  '1': 'DeleteOrganizationResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteOrganizationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteOrganizationResponseDescriptor = $convert.base64Decode('ChpEZWxldGVPcmdhbml6YXRpb25SZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getOrganizationDetailsRequestDescriptor instead')
const GetOrganizationDetailsRequest$json = const {
  '1': 'GetOrganizationDetailsRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetOrganizationDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrganizationDetailsRequestDescriptor = $convert.base64Decode('Ch1HZXRPcmdhbml6YXRpb25EZXRhaWxzUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use getOrganizationDetailsResponseDescriptor instead')
const GetOrganizationDetailsResponse$json = const {
  '1': 'GetOrganizationDetailsResponse',
  '2': const [
    const {'1': 'organization', '3': 1, '4': 1, '5': 11, '6': '.id_pay.IDPayOrganization', '10': 'organization'},
    const {'1': 'id_pays', '3': 2, '4': 3, '5': 11, '6': '.id_pay.IDPay', '10': 'idPays'},
    const {'1': 'total_paid_out', '3': 3, '4': 1, '5': 1, '10': 'totalPaidOut'},
  ],
};

/// Descriptor for `GetOrganizationDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrganizationDetailsResponseDescriptor = $convert.base64Decode('Ch5HZXRPcmdhbml6YXRpb25EZXRhaWxzUmVzcG9uc2USPQoMb3JnYW5pemF0aW9uGAEgASgLMhkuaWRfcGF5LklEUGF5T3JnYW5pemF0aW9uUgxvcmdhbml6YXRpb24SJgoHaWRfcGF5cxgCIAMoCzINLmlkX3BheS5JRFBheVIGaWRQYXlzEiQKDnRvdGFsX3BhaWRfb3V0GAMgASgBUgx0b3RhbFBhaWRPdXQ=');
