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
    {
      '1': 'attachments',
      '3': 31,
      '4': 3,
      '5': 11,
      '6': '.escrow.Attachment',
      '10': 'attachments'
    },
    {
      '1': 'refund_request',
      '3': 32,
      '4': 1,
      '5': 11,
      '6': '.escrow.RefundRequest',
      '10': 'refundRequest'
    },
    {'1': 'offer_id', '3': 33, '4': 1, '5': 9, '10': 'offerId'},
    {'1': 'offer_direction', '3': 34, '4': 1, '5': 9, '10': 'offerDirection'},
    {'1': 'condition', '3': 35, '4': 1, '5': 9, '10': 'condition'},
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
    'JQcm9vZkltYWdlVXJsEjQKC2F0dGFjaG1lbnRzGB8gAygLMhIuZXNjcm93LkF0dGFjaG1lbnRS'
    'C2F0dGFjaG1lbnRzEjwKDnJlZnVuZF9yZXF1ZXN0GCAgASgLMhUuZXNjcm93LlJlZnVuZFJlcX'
    'Vlc3RSDXJlZnVuZFJlcXVlc3QSGQoIb2ZmZXJfaWQYISABKAlSB29mZmVySWQSJwoPb2ZmZXJf'
    'ZGlyZWN0aW9uGCIgASgJUg5vZmZlckRpcmVjdGlvbhIcCgljb25kaXRpb24YIyABKAlSCWNvbm'
    'RpdGlvbg==');

@$core.Deprecated('Use attachmentDescriptor instead')
const Attachment$json = {
  '1': 'Attachment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'purpose', '3': 2, '4': 1, '5': 9, '10': 'purpose'},
    {'1': 'media_kind', '3': 3, '4': 1, '5': 9, '10': 'mediaKind'},
    {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    {'1': 'content_type', '3': 5, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'size_bytes', '3': 6, '4': 1, '5': 3, '10': 'sizeBytes'},
    {'1': 'duration_seconds', '3': 7, '4': 1, '5': 5, '10': 'durationSeconds'},
    {'1': 'uploaded_by', '3': 8, '4': 1, '5': 9, '10': 'uploadedBy'},
    {'1': 'actor_role', '3': 9, '4': 1, '5': 9, '10': 'actorRole'},
    {
      '1': 'created_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `Attachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attachmentDescriptor = $convert.base64Decode(
    'CgpBdHRhY2htZW50Eg4KAmlkGAEgASgJUgJpZBIYCgdwdXJwb3NlGAIgASgJUgdwdXJwb3NlEh'
    '0KCm1lZGlhX2tpbmQYAyABKAlSCW1lZGlhS2luZBIQCgN1cmwYBCABKAlSA3VybBIhCgxjb250'
    'ZW50X3R5cGUYBSABKAlSC2NvbnRlbnRUeXBlEh0KCnNpemVfYnl0ZXMYBiABKANSCXNpemVCeX'
    'RlcxIpChBkdXJhdGlvbl9zZWNvbmRzGAcgASgFUg9kdXJhdGlvblNlY29uZHMSHwoLdXBsb2Fk'
    'ZWRfYnkYCCABKAlSCnVwbG9hZGVkQnkSHQoKYWN0b3Jfcm9sZRgJIAEoCVIJYWN0b3JSb2xlEj'
    'kKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVk'
    'QXQ=');

@$core.Deprecated('Use refundRequestDescriptor instead')
const RefundRequest$json = {
  '1': 'RefundRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'deal_id', '3': 2, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'requested_by', '3': 3, '4': 1, '5': 9, '10': 'requestedBy'},
    {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'response_deadline_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'responseDeadlineAt'
    },
    {'1': 'responded_by', '3': 7, '4': 1, '5': 9, '10': 'respondedBy'},
    {'1': 'response_note', '3': 8, '4': 1, '5': 9, '10': 'responseNote'},
    {
      '1': 'responded_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'respondedAt'
    },
    {
      '1': 'created_at',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'attachments',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.escrow.Attachment',
      '10': 'attachments'
    },
  ],
};

/// Descriptor for `RefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refundRequestDescriptor = $convert.base64Decode(
    'Cg1SZWZ1bmRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIXCgdkZWFsX2lkGAIgASgJUgZkZWFsSW'
    'QSIQoMcmVxdWVzdGVkX2J5GAMgASgJUgtyZXF1ZXN0ZWRCeRIWCgZyZWFzb24YBCABKAlSBnJl'
    'YXNvbhIWCgZzdGF0dXMYBSABKAlSBnN0YXR1cxJMChRyZXNwb25zZV9kZWFkbGluZV9hdBgGIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEnJlc3BvbnNlRGVhZGxpbmVBdBIhCgxy'
    'ZXNwb25kZWRfYnkYByABKAlSC3Jlc3BvbmRlZEJ5EiMKDXJlc3BvbnNlX25vdGUYCCABKAlSDH'
    'Jlc3BvbnNlTm90ZRI9CgxyZXNwb25kZWRfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGlt'
    'ZXN0YW1wUgtyZXNwb25kZWRBdBI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjQKC2F0dGFjaG1lbnRzGAsgAygLMhIuZXNjcm93LkF0'
    'dGFjaG1lbnRSC2F0dGFjaG1lbnRz');

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

@$core.Deprecated('Use addAttachmentRequestDescriptor instead')
const AddAttachmentRequest$json = {
  '1': 'AddAttachmentRequest',
  '2': [
    {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'purpose', '3': 2, '4': 1, '5': 9, '10': 'purpose'},
    {'1': 'media_kind', '3': 3, '4': 1, '5': 9, '10': 'mediaKind'},
    {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    {'1': 'content_type', '3': 5, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'size_bytes', '3': 6, '4': 1, '5': 3, '10': 'sizeBytes'},
    {'1': 'duration_seconds', '3': 7, '4': 1, '5': 5, '10': 'durationSeconds'},
  ],
};

/// Descriptor for `AddAttachmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addAttachmentRequestDescriptor = $convert.base64Decode(
    'ChRBZGRBdHRhY2htZW50UmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSGAoHcHVycG'
    '9zZRgCIAEoCVIHcHVycG9zZRIdCgptZWRpYV9raW5kGAMgASgJUgltZWRpYUtpbmQSEAoDdXJs'
    'GAQgASgJUgN1cmwSIQoMY29udGVudF90eXBlGAUgASgJUgtjb250ZW50VHlwZRIdCgpzaXplX2'
    'J5dGVzGAYgASgDUglzaXplQnl0ZXMSKQoQZHVyYXRpb25fc2Vjb25kcxgHIAEoBVIPZHVyYXRp'
    'b25TZWNvbmRz');

@$core.Deprecated('Use attachmentResponseDescriptor instead')
const AttachmentResponse$json = {
  '1': 'AttachmentResponse',
  '2': [
    {
      '1': 'attachment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.escrow.Attachment',
      '10': 'attachment'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AttachmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attachmentResponseDescriptor = $convert.base64Decode(
    'ChJBdHRhY2htZW50UmVzcG9uc2USMgoKYXR0YWNobWVudBgBIAEoCzISLmVzY3Jvdy5BdHRhY2'
    'htZW50UgphdHRhY2htZW50EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use requestRefundRequestDescriptor instead')
const RequestRefundRequest$json = {
  '1': 'RequestRefundRequest',
  '2': [
    {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RequestRefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestRefundRequestDescriptor = $convert.base64Decode(
    'ChRSZXF1ZXN0UmVmdW5kUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSFgoGcmVhc2'
    '9uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use respondRefundRequestDescriptor instead')
const RespondRefundRequest$json = {
  '1': 'RespondRefundRequest',
  '2': [
    {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    {'1': 'accept', '3': 2, '4': 1, '5': 8, '10': 'accept'},
    {'1': 'note', '3': 3, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `RespondRefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List respondRefundRequestDescriptor = $convert.base64Decode(
    'ChRSZXNwb25kUmVmdW5kUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSFgoGYWNjZX'
    'B0GAIgASgIUgZhY2NlcHQSEgoEbm90ZRgDIAEoCVIEbm90ZQ==');

@$core.Deprecated('Use offerDescriptor instead')
const Offer$json = {
  '1': 'Offer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    {'1': 'direction', '3': 3, '4': 1, '5': 9, '10': 'direction'},
    {'1': 'creator_user_id', '3': 4, '4': 1, '5': 9, '10': 'creatorUserId'},
    {'1': 'creator_name', '3': 5, '4': 1, '5': 9, '10': 'creatorName'},
    {
      '1': 'counterparty_user_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'counterpartyUserId'
    },
    {
      '1': 'counterparty_name',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'counterpartyName'
    },
    {'1': 'title', '3': 8, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    {'1': 'amount', '3': 10, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'fee_payer_mode', '3': 12, '4': 1, '5': 9, '10': 'feePayerMode'},
    {
      '1': 'delivery_deadline_days',
      '3': 13,
      '4': 1,
      '5': 5,
      '10': 'deliveryDeadlineDays'
    },
    {'1': 'status', '3': 14, '4': 1, '5': 9, '10': 'status'},
    {'1': 'decline_reason', '3': 15, '4': 1, '5': 9, '10': 'declineReason'},
    {
      '1': 'expires_at',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expiresAt'
    },
    {
      '1': 'funding_deadline_at',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'fundingDeadlineAt'
    },
    {'1': 'deal_id', '3': 18, '4': 1, '5': 9, '10': 'dealId'},
    {
      '1': 'accepted_at',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'acceptedAt'
    },
    {
      '1': 'created_at',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'attachments',
      '3': 21,
      '4': 3,
      '5': 11,
      '6': '.escrow.Attachment',
      '10': 'attachments'
    },
    {
      '1': 'viewer_is_creator',
      '3': 22,
      '4': 1,
      '5': 8,
      '10': 'viewerIsCreator'
    },
    {'1': 'condition', '3': 23, '4': 1, '5': 9, '10': 'condition'},
  ],
};

/// Descriptor for `Offer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List offerDescriptor = $convert.base64Decode(
    'CgVPZmZlchIOCgJpZBgBIAEoCVICaWQSHAoJcmVmZXJlbmNlGAIgASgJUglyZWZlcmVuY2USHA'
    'oJZGlyZWN0aW9uGAMgASgJUglkaXJlY3Rpb24SJgoPY3JlYXRvcl91c2VyX2lkGAQgASgJUg1j'
    'cmVhdG9yVXNlcklkEiEKDGNyZWF0b3JfbmFtZRgFIAEoCVILY3JlYXRvck5hbWUSMAoUY291bn'
    'RlcnBhcnR5X3VzZXJfaWQYBiABKAlSEmNvdW50ZXJwYXJ0eVVzZXJJZBIrChFjb3VudGVycGFy'
    'dHlfbmFtZRgHIAEoCVIQY291bnRlcnBhcnR5TmFtZRIUCgV0aXRsZRgIIAEoCVIFdGl0bGUSIA'
    'oLZGVzY3JpcHRpb24YCSABKAlSC2Rlc2NyaXB0aW9uEhYKBmFtb3VudBgKIAEoAVIGYW1vdW50'
    'EhoKCGN1cnJlbmN5GAsgASgJUghjdXJyZW5jeRIkCg5mZWVfcGF5ZXJfbW9kZRgMIAEoCVIMZm'
    'VlUGF5ZXJNb2RlEjQKFmRlbGl2ZXJ5X2RlYWRsaW5lX2RheXMYDSABKAVSFGRlbGl2ZXJ5RGVh'
    'ZGxpbmVEYXlzEhYKBnN0YXR1cxgOIAEoCVIGc3RhdHVzEiUKDmRlY2xpbmVfcmVhc29uGA8gAS'
    'gJUg1kZWNsaW5lUmVhc29uEjkKCmV4cGlyZXNfYXQYECABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUglleHBpcmVzQXQSSgoTZnVuZGluZ19kZWFkbGluZV9hdBgRIAEoCzIaLmdvb2'
    'dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEWZ1bmRpbmdEZWFkbGluZUF0EhcKB2RlYWxfaWQYEiAB'
    'KAlSBmRlYWxJZBI7CgthY2NlcHRlZF9hdBgTIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSCmFjY2VwdGVkQXQSOQoKY3JlYXRlZF9hdBgUIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5U'
    'aW1lc3RhbXBSCWNyZWF0ZWRBdBI0CgthdHRhY2htZW50cxgVIAMoCzISLmVzY3Jvdy5BdHRhY2'
    'htZW50UgthdHRhY2htZW50cxIqChF2aWV3ZXJfaXNfY3JlYXRvchgWIAEoCFIPdmlld2VySXND'
    'cmVhdG9yEhwKCWNvbmRpdGlvbhgXIAEoCVIJY29uZGl0aW9u');

@$core.Deprecated('Use createOfferRequestDescriptor instead')
const CreateOfferRequest$json = {
  '1': 'CreateOfferRequest',
  '2': [
    {'1': 'direction', '3': 1, '4': 1, '5': 9, '10': 'direction'},
    {
      '1': 'counterparty_query',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'counterpartyQuery'
    },
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {
      '1': 'fee_payer_preference',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'feePayerPreference'
    },
    {
      '1': 'delivery_deadline_days',
      '3': 8,
      '4': 1,
      '5': 5,
      '10': 'deliveryDeadlineDays'
    },
    {'1': 'condition', '3': 9, '4': 1, '5': 9, '10': 'condition'},
  ],
};

/// Descriptor for `CreateOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOfferRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVPZmZlclJlcXVlc3QSHAoJZGlyZWN0aW9uGAEgASgJUglkaXJlY3Rpb24SLQoSY2'
    '91bnRlcnBhcnR5X3F1ZXJ5GAIgASgJUhFjb3VudGVycGFydHlRdWVyeRIUCgV0aXRsZRgDIAEo'
    'CVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhYKBmFtb3VudBgFIA'
    'EoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIwChRmZWVfcGF5ZXJfcHJl'
    'ZmVyZW5jZRgHIAEoCVISZmVlUGF5ZXJQcmVmZXJlbmNlEjQKFmRlbGl2ZXJ5X2RlYWRsaW5lX2'
    'RheXMYCCABKAVSFGRlbGl2ZXJ5RGVhZGxpbmVEYXlzEhwKCWNvbmRpdGlvbhgJIAEoCVIJY29u'
    'ZGl0aW9u');

@$core.Deprecated('Use offerResponseDescriptor instead')
const OfferResponse$json = {
  '1': 'OfferResponse',
  '2': [
    {
      '1': 'offer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.escrow.Offer',
      '10': 'offer'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'share_url_token', '3': 3, '4': 1, '5': 9, '10': 'shareUrlToken'},
  ],
};

/// Descriptor for `OfferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List offerResponseDescriptor = $convert.base64Decode(
    'Cg1PZmZlclJlc3BvbnNlEiMKBW9mZmVyGAEgASgLMg0uZXNjcm93Lk9mZmVyUgVvZmZlchIYCg'
    'dtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiYKD3NoYXJlX3VybF90b2tlbhgDIAEoCVINc2hhcmVV'
    'cmxUb2tlbg==');

@$core.Deprecated('Use getOfferRequestDescriptor instead')
const GetOfferRequest$json = {
  '1': 'GetOfferRequest',
  '2': [
    {'1': 'offer_id', '3': 1, '4': 1, '5': 9, '10': 'offerId'},
  ],
};

/// Descriptor for `GetOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOfferRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRPZmZlclJlcXVlc3QSGQoIb2ZmZXJfaWQYASABKAlSB29mZmVySWQ=');

@$core.Deprecated('Use getOfferByShareTokenRequestDescriptor instead')
const GetOfferByShareTokenRequest$json = {
  '1': 'GetOfferByShareTokenRequest',
  '2': [
    {'1': 'share_token', '3': 1, '4': 1, '5': 9, '10': 'shareToken'},
  ],
};

/// Descriptor for `GetOfferByShareTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOfferByShareTokenRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRPZmZlckJ5U2hhcmVUb2tlblJlcXVlc3QSHwoLc2hhcmVfdG9rZW4YASABKAlSCnNoYX'
        'JlVG9rZW4=');

@$core.Deprecated('Use listMyOffersRequestDescriptor instead')
const ListMyOffersRequest$json = {
  '1': 'ListMyOffersRequest',
  '2': [
    {'1': 'role', '3': 1, '4': 1, '5': 9, '10': 'role'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListMyOffersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyOffersRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0TXlPZmZlcnNSZXF1ZXN0EhIKBHJvbGUYASABKAlSBHJvbGUSFgoGc3RhdHVzGAIgAS'
    'gJUgZzdGF0dXMSEgoEcGFnZRgDIAEoBVIEcGFnZRIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use listOffersResponseDescriptor instead')
const ListOffersResponse$json = {
  '1': 'ListOffersResponse',
  '2': [
    {
      '1': 'offers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.escrow.Offer',
      '10': 'offers'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListOffersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listOffersResponseDescriptor = $convert.base64Decode(
    'ChJMaXN0T2ZmZXJzUmVzcG9uc2USJQoGb2ZmZXJzGAEgAygLMg0uZXNjcm93Lk9mZmVyUgZvZm'
    'ZlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use respondOfferRequestDescriptor instead')
const RespondOfferRequest$json = {
  '1': 'RespondOfferRequest',
  '2': [
    {'1': 'offer_id', '3': 1, '4': 1, '5': 9, '10': 'offerId'},
    {'1': 'accept', '3': 2, '4': 1, '5': 8, '10': 'accept'},
    {'1': 'note', '3': 3, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `RespondOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List respondOfferRequestDescriptor = $convert.base64Decode(
    'ChNSZXNwb25kT2ZmZXJSZXF1ZXN0EhkKCG9mZmVyX2lkGAEgASgJUgdvZmZlcklkEhYKBmFjY2'
    'VwdBgCIAEoCFIGYWNjZXB0EhIKBG5vdGUYAyABKAlSBG5vdGU=');

@$core.Deprecated('Use fundOfferRequestDescriptor instead')
const FundOfferRequest$json = {
  '1': 'FundOfferRequest',
  '2': [
    {'1': 'offer_id', '3': 1, '4': 1, '5': 9, '10': 'offerId'},
    {'1': 'buyer_account_id', '3': 2, '4': 1, '5': 9, '10': 'buyerAccountId'},
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

/// Descriptor for `FundOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundOfferRequestDescriptor = $convert.base64Decode(
    'ChBGdW5kT2ZmZXJSZXF1ZXN0EhkKCG9mZmVyX2lkGAEgASgJUgdvZmZlcklkEigKEGJ1eWVyX2'
    'FjY291bnRfaWQYAiABKAlSDmJ1eWVyQWNjb3VudElkEiUKDnRyYW5zYWN0aW9uX2lkGAMgASgJ'
    'Ug10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgEIAEoCVIRdmVyaWZpY2F0aW'
    '9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAUgASgJUg5pZGVtcG90ZW5jeUtleQ==');

@$core.Deprecated('Use cancelOfferRequestDescriptor instead')
const CancelOfferRequest$json = {
  '1': 'CancelOfferRequest',
  '2': [
    {'1': 'offer_id', '3': 1, '4': 1, '5': 9, '10': 'offerId'},
  ],
};

/// Descriptor for `CancelOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelOfferRequestDescriptor =
    $convert.base64Decode(
        'ChJDYW5jZWxPZmZlclJlcXVlc3QSGQoIb2ZmZXJfaWQYASABKAlSB29mZmVySWQ=');

@$core.Deprecated('Use addOfferAttachmentRequestDescriptor instead')
const AddOfferAttachmentRequest$json = {
  '1': 'AddOfferAttachmentRequest',
  '2': [
    {'1': 'offer_id', '3': 1, '4': 1, '5': 9, '10': 'offerId'},
    {'1': 'media_kind', '3': 2, '4': 1, '5': 9, '10': 'mediaKind'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'content_type', '3': 4, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'size_bytes', '3': 5, '4': 1, '5': 3, '10': 'sizeBytes'},
    {'1': 'duration_seconds', '3': 6, '4': 1, '5': 5, '10': 'durationSeconds'},
  ],
};

/// Descriptor for `AddOfferAttachmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addOfferAttachmentRequestDescriptor = $convert.base64Decode(
    'ChlBZGRPZmZlckF0dGFjaG1lbnRSZXF1ZXN0EhkKCG9mZmVyX2lkGAEgASgJUgdvZmZlcklkEh'
    '0KCm1lZGlhX2tpbmQYAiABKAlSCW1lZGlhS2luZBIQCgN1cmwYAyABKAlSA3VybBIhCgxjb250'
    'ZW50X3R5cGUYBCABKAlSC2NvbnRlbnRUeXBlEh0KCnNpemVfYnl0ZXMYBSABKANSCXNpemVCeX'
    'RlcxIpChBkdXJhdGlvbl9zZWNvbmRzGAYgASgFUg9kdXJhdGlvblNlY29uZHM=');
