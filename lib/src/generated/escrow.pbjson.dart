// This is a generated file - do not edit.
//
// Generated from escrow.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use dealDescriptor instead')
const Deal$json = {
  '1': 'Deal',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'buyer_user_id', '3': 3, '4': 1, '5': 9, '10': 'buyerUserId'},
    {'1': 'buyer_account_id', '3': 4, '4': 1, '5': 9, '10': 'buyerAccountId'},
    {'1': 'buyer_name', '3': 5, '4': 1, '5': 9, '10': 'buyerName'},
    {'1': 'seller_user_id', '3': 6, '4': 1, '5': 9, '10': 'sellerUserId'},
    {'1': 'seller_account_id', '3': 7, '4': 1, '5': 9, '10': 'sellerAccountId'},
    {'1': 'seller_name', '3': 8, '4': 1, '5': 9, '10': 'sellerName'},
    {'1': 'title', '3': 9, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'amount', '3': 12, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'fee', '3': 13, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'fee_payer', '3': 14, '4': 1, '5': 9, '10': 'feePayer'},
    {'1': 'buyer_total', '3': 15, '4': 1, '5': 1, '10': 'buyerTotal'},
    {'1': 'seller_net', '3': 16, '4': 1, '5': 1, '10': 'sellerNet'},
    {'1': 'status', '3': 17, '4': 1, '5': 9, '10': 'status'},
    {'1': 'fraud_score', '3': 18, '4': 1, '5': 5, '10': 'fraudScore'},
    {'1': 'fraud_flags', '3': 19, '4': 3, '5': 9, '10': 'fraudFlags'},
    {
      '1': 'requires_admin_review',
      '3': 20,
      '4': 1,
      '5': 8,
      '10': 'requiresAdminReview'
    },
    {'1': 'delivery_note', '3': 21, '4': 1, '5': 9, '10': 'deliveryNote'},
    {
      '1': 'deadline_at',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'deadlineAt'
    },
    {
      '1': 'funded_at',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'fundedAt'
    },
    {
      '1': 'delivered_at',
      '3': 24,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'deliveredAt'
    },
    {
      '1': 'released_at',
      '3': 25,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'releasedAt'
    },
    {
      '1': 'created_at',
      '3': 26,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 27,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {
      '1': 'events',
      '3': 28,
      '4': 3,
      '5': 11,
      '6': '.escrow.DealEvent',
      '10': 'events'
    },
    {
      '1': 'buyer_item_image_url',
      '3': 29,
      '4': 1,
      '5': 9,
      '10': 'buyerItemImageUrl'
    },
    {
      '1': 'seller_proof_image_url',
      '3': 30,
      '4': 1,
      '5': 9,
      '10': 'sellerProofImageUrl'
    },
  ],
};

/// Descriptor for `Deal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dealDescriptor = $convert.base64Decode(
    'CgREZWFsEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIiCg'
    '1idXllcl91c2VyX2lkGAMgASgJUgtidXllclVzZXJJZBIoChBidXllcl9hY2NvdW50X2lkGAQg'
    'ASgJUg5idXllckFjY291bnRJZBIdCgpidXllcl9uYW1lGAUgASgJUglidXllck5hbWUSJAoOc2'
    'VsbGVyX3VzZXJfaWQYBiABKAlSDHNlbGxlclVzZXJJZBIqChFzZWxsZXJfYWNjb3VudF9pZBgH'
    'IAEoCVIPc2VsbGVyQWNjb3VudElkEh8KC3NlbGxlcl9uYW1lGAggASgJUgpzZWxsZXJOYW1lEh'
    'QKBXRpdGxlGAkgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgKIAEoCVILZGVzY3JpcHRpb24S'
    'GgoIY3VycmVuY3kYCyABKAlSCGN1cnJlbmN5EhYKBmFtb3VudBgMIAEoAVIGYW1vdW50EhAKA2'
    'ZlZRgNIAEoAVIDZmVlEhsKCWZlZV9wYXllchgOIAEoCVIIZmVlUGF5ZXISHwoLYnV5ZXJfdG90'
    'YWwYDyABKAFSCmJ1eWVyVG90YWwSHQoKc2VsbGVyX25ldBgQIAEoAVIJc2VsbGVyTmV0EhYKBn'
    'N0YXR1cxgRIAEoCVIGc3RhdHVzEh8KC2ZyYXVkX3Njb3JlGBIgASgFUgpmcmF1ZFNjb3JlEh8K'
    'C2ZyYXVkX2ZsYWdzGBMgAygJUgpmcmF1ZEZsYWdzEjIKFXJlcXVpcmVzX2FkbWluX3Jldmlldx'
    'gUIAEoCFITcmVxdWlyZXNBZG1pblJldmlldxIjCg1kZWxpdmVyeV9ub3RlGBUgASgJUgxkZWxp'
    'dmVyeU5vdGUSOwoLZGVhZGxpbmVfYXQYFiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgpkZWFkbGluZUF0EjcKCWZ1bmRlZF9hdBgXIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1l'
    'c3RhbXBSCGZ1bmRlZEF0Ej0KDGRlbGl2ZXJlZF9hdBgYIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSC2RlbGl2ZXJlZEF0EjsKC3JlbGVhc2VkX2F0GBkgASgLMhouZ29vZ2xlLnBy'
    'b3RvYnVmLlRpbWVzdGFtcFIKcmVsZWFzZWRBdBI5CgpjcmVhdGVkX2F0GBogASgLMhouZ29vZ2'
    'xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYGyABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSKQoGZXZlbnRzGBwgAygLMhEuZX'
    'Njcm93LkRlYWxFdmVudFIGZXZlbnRzEi8KFGJ1eWVyX2l0ZW1faW1hZ2VfdXJsGB0gASgJUhFi'
    'dXllckl0ZW1JbWFnZVVybBIzChZzZWxsZXJfcHJvb2ZfaW1hZ2VfdXJsGB4gASgJUhNzZWxsZX'
    'JQcm9vZkltYWdlVXJs');

@$core.Deprecated('Use dealEventDescriptor instead')
const DealEvent$json = {
  '1': 'DealEvent',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'deal_id', '3': 2, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'event_type', '3': 3, '4': 1, '5': 9, '10': 'eventType'},
    {'1': 'actor', '3': 4, '4': 1, '5': 9, '10': 'actor'},
    {'1': 'detail', '3': 5, '4': 1, '5': 9, '10': 'detail'},
    {
      '1': 'created_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `DealEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dealEventDescriptor = $convert.base64Decode(
    'CglEZWFsRXZlbnQSDgoCaWQYASABKAlSAmlkEhcKB2RlYWxfaWQYAiABKAlSBmRlYWxJZBIdCg'
    'pldmVudF90eXBlGAMgASgJUglldmVudFR5cGUSFAoFYWN0b3IYBCABKAlSBWFjdG9yEhYKBmRl'
    'dGFpbBgFIAEoCVIGZGV0YWlsEjkKCmNyZWF0ZWRfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use createDealRequestDescriptor instead')
const CreateDealRequest$json = {
  '1': 'CreateDealRequest',
  '2': [
    {'1': 'buyer_account_id', '3': 1, '4': 1, '5': 9, '10': 'buyerAccountId'},
    {'1': 'seller_query', '3': 2, '4': 1, '5': 9, '10': 'sellerQuery'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'deadline_days', '3': 6, '4': 1, '5': 5, '10': 'deadlineDays'},
    {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    {
      '1': 'buyer_item_image_url',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'buyerItemImageUrl'
    },
  ],
};

/// Descriptor for `CreateDealRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDealRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVEZWFsUmVxdWVzdBIoChBidXllcl9hY2NvdW50X2lkGAEgASgJUg5idXllckFjY2'
    '91bnRJZBIhCgxzZWxsZXJfcXVlcnkYAiABKAlSC3NlbGxlclF1ZXJ5EhQKBXRpdGxlGAMgASgJ'
    'UgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SFgoGYW1vdW50GAUgAS'
    'gBUgZhbW91bnQSIwoNZGVhZGxpbmVfZGF5cxgGIAEoBVIMZGVhZGxpbmVEYXlzEiUKDnRyYW5z'
    'YWN0aW9uX2lkGAcgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgIIA'
    'EoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAkgASgJUg5pZGVtcG90'
    'ZW5jeUtleRIvChRidXllcl9pdGVtX2ltYWdlX3VybBgKIAEoCVIRYnV5ZXJJdGVtSW1hZ2VVcm'
    'w=');

@$core.Deprecated('Use listMyDealsRequestDescriptor instead')
const ListMyDealsRequest$json = {
  '1': 'ListMyDealsRequest',
  '2': [
    {'1': 'role', '3': 1, '4': 1, '5': 9, '10': 'role'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListMyDealsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyDealsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0TXlEZWFsc1JlcXVlc3QSEgoEcm9sZRgBIAEoCVIEcm9sZRIWCgZzdGF0dXMYAiABKA'
    'lSBnN0YXR1cxISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');

@$core.Deprecated('Use listDealsResponseDescriptor instead')
const ListDealsResponse$json = {
  '1': 'ListDealsResponse',
  '2': [
    {'1': 'deals', '3': 1, '4': 3, '5': 11, '6': '.escrow.Deal', '10': 'deals'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListDealsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDealsResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0RGVhbHNSZXNwb25zZRIiCgVkZWFscxgBIAMoCzIMLmVzY3Jvdy5EZWFsUgVkZWFscx'
    'IUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use getDealRequestDescriptor instead')
const GetDealRequest$json = {
  '1': 'GetDealRequest',
  '2': [
    {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
  ],
};

/// Descriptor for `GetDealRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDealRequestDescriptor = $convert
    .base64Decode('Cg5HZXREZWFsUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQ=');

@$core.Deprecated('Use dealResponseDescriptor instead')
const DealResponse$json = {
  '1': 'DealResponse',
  '2': [
    {'1': 'deal', '3': 1, '4': 1, '5': 11, '6': '.escrow.Deal', '10': 'deal'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DealResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dealResponseDescriptor = $convert.base64Decode(
    'CgxEZWFsUmVzcG9uc2USIAoEZGVhbBgBIAEoCzIMLmVzY3Jvdy5EZWFsUgRkZWFsEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use markDeliveredRequestDescriptor instead')
const MarkDeliveredRequest$json = {
  '1': 'MarkDeliveredRequest',
  '2': [
    {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'delivery_note', '3': 2, '4': 1, '5': 9, '10': 'deliveryNote'},
    {
      '1': 'seller_proof_image_url',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'sellerProofImageUrl'
    },
  ],
};

/// Descriptor for `MarkDeliveredRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markDeliveredRequestDescriptor = $convert.base64Decode(
    'ChRNYXJrRGVsaXZlcmVkUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSIwoNZGVsaX'
    'Zlcnlfbm90ZRgCIAEoCVIMZGVsaXZlcnlOb3RlEjMKFnNlbGxlcl9wcm9vZl9pbWFnZV91cmwY'
    'AyABKAlSE3NlbGxlclByb29mSW1hZ2VVcmw=');

@$core.Deprecated('Use validateReleaseRequestDescriptor instead')
const ValidateReleaseRequest$json = {
  '1': 'ValidateReleaseRequest',
  '2': [
    {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    {
      '1': 'verification_token',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
    {'1': 'idempotency_key', '3': 4, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ValidateReleaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateReleaseRequestDescriptor = $convert.base64Decode(
    'ChZWYWxpZGF0ZVJlbGVhc2VSZXF1ZXN0EhcKB2RlYWxfaWQYASABKAlSBmRlYWxJZBIlCg50cm'
    'Fuc2FjdGlvbl9pZBgCIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4Y'
    'AyABKAlSEXZlcmlmaWNhdGlvblRva2VuEicKD2lkZW1wb3RlbmN5X2tleRgEIAEoCVIOaWRlbX'
    'BvdGVuY3lLZXk=');

@$core.Deprecated('Use cancelDealRequestDescriptor instead')
const CancelDealRequest$json = {
  '1': 'CancelDealRequest',
  '2': [
    {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'idempotency_key', '3': 3, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `CancelDealRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelDealRequestDescriptor = $convert.base64Decode(
    'ChFDYW5jZWxEZWFsUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSFgoGcmVhc29uGA'
    'IgASgJUgZyZWFzb24SJwoPaWRlbXBvdGVuY3lfa2V5GAMgASgJUg5pZGVtcG90ZW5jeUtleQ==');

@$core.Deprecated('Use openDisputeRequestDescriptor instead')
const OpenDisputeRequest$json = {
  '1': 'OpenDisputeRequest',
  '2': [
    {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'evidence_url', '3': 3, '4': 1, '5': 9, '10': 'evidenceUrl'},
  ],
};

/// Descriptor for `OpenDisputeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openDisputeRequestDescriptor = $convert.base64Decode(
    'ChJPcGVuRGlzcHV0ZVJlcXVlc3QSFwoHZGVhbF9pZBgBIAEoCVIGZGVhbElkEhYKBnJlYXNvbh'
    'gCIAEoCVIGcmVhc29uEiEKDGV2aWRlbmNlX3VybBgDIAEoCVILZXZpZGVuY2VVcmw=');

@$core.Deprecated('Use quoteFeeRequestDescriptor instead')
const QuoteFeeRequest$json = {
  '1': 'QuoteFeeRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `QuoteFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteFeeRequestDescriptor = $convert.base64Decode(
    'Cg9RdW90ZUZlZVJlcXVlc3QSFgoGYW1vdW50GAEgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAi'
    'ABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use quoteFeeResponseDescriptor instead')
const QuoteFeeResponse$json = {
  '1': 'QuoteFeeResponse',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'fee', '3': 2, '4': 1, '5': 1, '10': 'fee'},
    {'1': 'fee_payer', '3': 3, '4': 1, '5': 9, '10': 'feePayer'},
    {'1': 'buyer_total', '3': 4, '4': 1, '5': 1, '10': 'buyerTotal'},
    {'1': 'seller_net', '3': 5, '4': 1, '5': 1, '10': 'sellerNet'},
  ],
};

/// Descriptor for `QuoteFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteFeeResponseDescriptor = $convert.base64Decode(
    'ChBRdW90ZUZlZVJlc3BvbnNlEhYKBmFtb3VudBgBIAEoAVIGYW1vdW50EhAKA2ZlZRgCIAEoAV'
    'IDZmVlEhsKCWZlZV9wYXllchgDIAEoCVIIZmVlUGF5ZXISHwoLYnV5ZXJfdG90YWwYBCABKAFS'
    'CmJ1eWVyVG90YWwSHQoKc2VsbGVyX25ldBgFIAEoAVIJc2VsbGVyTmV0');
