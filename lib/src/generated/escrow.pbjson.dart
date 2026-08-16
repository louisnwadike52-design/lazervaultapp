///
//  Generated code. Do not modify.
//  source: escrow.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use dealDescriptor instead')
const Deal$json = const {
  '1': 'Deal',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'buyer_user_id', '3': 3, '4': 1, '5': 9, '10': 'buyerUserId'},
    const {'1': 'buyer_account_id', '3': 4, '4': 1, '5': 9, '10': 'buyerAccountId'},
    const {'1': 'buyer_name', '3': 5, '4': 1, '5': 9, '10': 'buyerName'},
    const {'1': 'seller_user_id', '3': 6, '4': 1, '5': 9, '10': 'sellerUserId'},
    const {'1': 'seller_account_id', '3': 7, '4': 1, '5': 9, '10': 'sellerAccountId'},
    const {'1': 'seller_name', '3': 8, '4': 1, '5': 9, '10': 'sellerName'},
    const {'1': 'title', '3': 9, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'currency', '3': 11, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'amount', '3': 12, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'fee', '3': 13, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'fee_payer', '3': 14, '4': 1, '5': 9, '10': 'feePayer'},
    const {'1': 'buyer_total', '3': 15, '4': 1, '5': 1, '10': 'buyerTotal'},
    const {'1': 'seller_net', '3': 16, '4': 1, '5': 1, '10': 'sellerNet'},
    const {'1': 'status', '3': 17, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'fraud_score', '3': 18, '4': 1, '5': 5, '10': 'fraudScore'},
    const {'1': 'fraud_flags', '3': 19, '4': 3, '5': 9, '10': 'fraudFlags'},
    const {'1': 'requires_admin_review', '3': 20, '4': 1, '5': 8, '10': 'requiresAdminReview'},
    const {'1': 'delivery_note', '3': 21, '4': 1, '5': 9, '10': 'deliveryNote'},
    const {'1': 'deadline_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadlineAt'},
    const {'1': 'funded_at', '3': 23, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'fundedAt'},
    const {'1': 'delivered_at', '3': 24, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deliveredAt'},
    const {'1': 'released_at', '3': 25, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'releasedAt'},
    const {'1': 'created_at', '3': 26, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 27, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'events', '3': 28, '4': 3, '5': 11, '6': '.escrow.DealEvent', '10': 'events'},
    const {'1': 'buyer_item_image_url', '3': 29, '4': 1, '5': 9, '10': 'buyerItemImageUrl'},
    const {'1': 'seller_proof_image_url', '3': 30, '4': 1, '5': 9, '10': 'sellerProofImageUrl'},
    const {'1': 'attachments', '3': 31, '4': 3, '5': 11, '6': '.escrow.Attachment', '10': 'attachments'},
    const {'1': 'refund_request', '3': 32, '4': 1, '5': 11, '6': '.escrow.RefundRequest', '10': 'refundRequest'},
  ],
};

/// Descriptor for `Deal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dealDescriptor = $convert.base64Decode('CgREZWFsEg4KAmlkGAEgASgJUgJpZBIcCglyZWZlcmVuY2UYAiABKAlSCXJlZmVyZW5jZRIiCg1idXllcl91c2VyX2lkGAMgASgJUgtidXllclVzZXJJZBIoChBidXllcl9hY2NvdW50X2lkGAQgASgJUg5idXllckFjY291bnRJZBIdCgpidXllcl9uYW1lGAUgASgJUglidXllck5hbWUSJAoOc2VsbGVyX3VzZXJfaWQYBiABKAlSDHNlbGxlclVzZXJJZBIqChFzZWxsZXJfYWNjb3VudF9pZBgHIAEoCVIPc2VsbGVyQWNjb3VudElkEh8KC3NlbGxlcl9uYW1lGAggASgJUgpzZWxsZXJOYW1lEhQKBXRpdGxlGAkgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgKIAEoCVILZGVzY3JpcHRpb24SGgoIY3VycmVuY3kYCyABKAlSCGN1cnJlbmN5EhYKBmFtb3VudBgMIAEoAVIGYW1vdW50EhAKA2ZlZRgNIAEoAVIDZmVlEhsKCWZlZV9wYXllchgOIAEoCVIIZmVlUGF5ZXISHwoLYnV5ZXJfdG90YWwYDyABKAFSCmJ1eWVyVG90YWwSHQoKc2VsbGVyX25ldBgQIAEoAVIJc2VsbGVyTmV0EhYKBnN0YXR1cxgRIAEoCVIGc3RhdHVzEh8KC2ZyYXVkX3Njb3JlGBIgASgFUgpmcmF1ZFNjb3JlEh8KC2ZyYXVkX2ZsYWdzGBMgAygJUgpmcmF1ZEZsYWdzEjIKFXJlcXVpcmVzX2FkbWluX3JldmlldxgUIAEoCFITcmVxdWlyZXNBZG1pblJldmlldxIjCg1kZWxpdmVyeV9ub3RlGBUgASgJUgxkZWxpdmVyeU5vdGUSOwoLZGVhZGxpbmVfYXQYFiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpkZWFkbGluZUF0EjcKCWZ1bmRlZF9hdBgXIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGZ1bmRlZEF0Ej0KDGRlbGl2ZXJlZF9hdBgYIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2RlbGl2ZXJlZEF0EjsKC3JlbGVhc2VkX2F0GBkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKcmVsZWFzZWRBdBI5CgpjcmVhdGVkX2F0GBogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYGyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQSKQoGZXZlbnRzGBwgAygLMhEuZXNjcm93LkRlYWxFdmVudFIGZXZlbnRzEi8KFGJ1eWVyX2l0ZW1faW1hZ2VfdXJsGB0gASgJUhFidXllckl0ZW1JbWFnZVVybBIzChZzZWxsZXJfcHJvb2ZfaW1hZ2VfdXJsGB4gASgJUhNzZWxsZXJQcm9vZkltYWdlVXJsEjQKC2F0dGFjaG1lbnRzGB8gAygLMhIuZXNjcm93LkF0dGFjaG1lbnRSC2F0dGFjaG1lbnRzEjwKDnJlZnVuZF9yZXF1ZXN0GCAgASgLMhUuZXNjcm93LlJlZnVuZFJlcXVlc3RSDXJlZnVuZFJlcXVlc3Q=');
@$core.Deprecated('Use attachmentDescriptor instead')
const Attachment$json = const {
  '1': 'Attachment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'purpose', '3': 2, '4': 1, '5': 9, '10': 'purpose'},
    const {'1': 'media_kind', '3': 3, '4': 1, '5': 9, '10': 'mediaKind'},
    const {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'content_type', '3': 5, '4': 1, '5': 9, '10': 'contentType'},
    const {'1': 'size_bytes', '3': 6, '4': 1, '5': 3, '10': 'sizeBytes'},
    const {'1': 'duration_seconds', '3': 7, '4': 1, '5': 5, '10': 'durationSeconds'},
    const {'1': 'uploaded_by', '3': 8, '4': 1, '5': 9, '10': 'uploadedBy'},
    const {'1': 'actor_role', '3': 9, '4': 1, '5': 9, '10': 'actorRole'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `Attachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attachmentDescriptor = $convert.base64Decode('CgpBdHRhY2htZW50Eg4KAmlkGAEgASgJUgJpZBIYCgdwdXJwb3NlGAIgASgJUgdwdXJwb3NlEh0KCm1lZGlhX2tpbmQYAyABKAlSCW1lZGlhS2luZBIQCgN1cmwYBCABKAlSA3VybBIhCgxjb250ZW50X3R5cGUYBSABKAlSC2NvbnRlbnRUeXBlEh0KCnNpemVfYnl0ZXMYBiABKANSCXNpemVCeXRlcxIpChBkdXJhdGlvbl9zZWNvbmRzGAcgASgFUg9kdXJhdGlvblNlY29uZHMSHwoLdXBsb2FkZWRfYnkYCCABKAlSCnVwbG9hZGVkQnkSHQoKYWN0b3Jfcm9sZRgJIAEoCVIJYWN0b3JSb2xlEjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use refundRequestDescriptor instead')
const RefundRequest$json = const {
  '1': 'RefundRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'deal_id', '3': 2, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'requested_by', '3': 3, '4': 1, '5': 9, '10': 'requestedBy'},
    const {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'response_deadline_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'responseDeadlineAt'},
    const {'1': 'responded_by', '3': 7, '4': 1, '5': 9, '10': 'respondedBy'},
    const {'1': 'response_note', '3': 8, '4': 1, '5': 9, '10': 'responseNote'},
    const {'1': 'responded_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'respondedAt'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'attachments', '3': 11, '4': 3, '5': 11, '6': '.escrow.Attachment', '10': 'attachments'},
  ],
};

/// Descriptor for `RefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refundRequestDescriptor = $convert.base64Decode('Cg1SZWZ1bmRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIXCgdkZWFsX2lkGAIgASgJUgZkZWFsSWQSIQoMcmVxdWVzdGVkX2J5GAMgASgJUgtyZXF1ZXN0ZWRCeRIWCgZyZWFzb24YBCABKAlSBnJlYXNvbhIWCgZzdGF0dXMYBSABKAlSBnN0YXR1cxJMChRyZXNwb25zZV9kZWFkbGluZV9hdBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEnJlc3BvbnNlRGVhZGxpbmVBdBIhCgxyZXNwb25kZWRfYnkYByABKAlSC3Jlc3BvbmRlZEJ5EiMKDXJlc3BvbnNlX25vdGUYCCABKAlSDHJlc3BvbnNlTm90ZRI9CgxyZXNwb25kZWRfYXQYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtyZXNwb25kZWRBdBI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjQKC2F0dGFjaG1lbnRzGAsgAygLMhIuZXNjcm93LkF0dGFjaG1lbnRSC2F0dGFjaG1lbnRz');
@$core.Deprecated('Use dealEventDescriptor instead')
const DealEvent$json = const {
  '1': 'DealEvent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'deal_id', '3': 2, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'event_type', '3': 3, '4': 1, '5': 9, '10': 'eventType'},
    const {'1': 'actor', '3': 4, '4': 1, '5': 9, '10': 'actor'},
    const {'1': 'detail', '3': 5, '4': 1, '5': 9, '10': 'detail'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `DealEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dealEventDescriptor = $convert.base64Decode('CglEZWFsRXZlbnQSDgoCaWQYASABKAlSAmlkEhcKB2RlYWxfaWQYAiABKAlSBmRlYWxJZBIdCgpldmVudF90eXBlGAMgASgJUglldmVudFR5cGUSFAoFYWN0b3IYBCABKAlSBWFjdG9yEhYKBmRldGFpbBgFIAEoCVIGZGV0YWlsEjkKCmNyZWF0ZWRfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use createDealRequestDescriptor instead')
const CreateDealRequest$json = const {
  '1': 'CreateDealRequest',
  '2': const [
    const {'1': 'buyer_account_id', '3': 1, '4': 1, '5': 9, '10': 'buyerAccountId'},
    const {'1': 'seller_query', '3': 2, '4': 1, '5': 9, '10': 'sellerQuery'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'deadline_days', '3': 6, '4': 1, '5': 5, '10': 'deadlineDays'},
    const {'1': 'transaction_id', '3': 7, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 8, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 9, '4': 1, '5': 9, '10': 'idempotencyKey'},
    const {'1': 'buyer_item_image_url', '3': 10, '4': 1, '5': 9, '10': 'buyerItemImageUrl'},
  ],
};

/// Descriptor for `CreateDealRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDealRequestDescriptor = $convert.base64Decode('ChFDcmVhdGVEZWFsUmVxdWVzdBIoChBidXllcl9hY2NvdW50X2lkGAEgASgJUg5idXllckFjY291bnRJZBIhCgxzZWxsZXJfcXVlcnkYAiABKAlSC3NlbGxlclF1ZXJ5EhQKBXRpdGxlGAMgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SFgoGYW1vdW50GAUgASgBUgZhbW91bnQSIwoNZGVhZGxpbmVfZGF5cxgGIAEoBVIMZGVhZGxpbmVEYXlzEiUKDnRyYW5zYWN0aW9uX2lkGAcgASgJUg10cmFuc2FjdGlvbklkEi0KEnZlcmlmaWNhdGlvbl90b2tlbhgIIAEoCVIRdmVyaWZpY2F0aW9uVG9rZW4SJwoPaWRlbXBvdGVuY3lfa2V5GAkgASgJUg5pZGVtcG90ZW5jeUtleRIvChRidXllcl9pdGVtX2ltYWdlX3VybBgKIAEoCVIRYnV5ZXJJdGVtSW1hZ2VVcmw=');
@$core.Deprecated('Use listMyDealsRequestDescriptor instead')
const ListMyDealsRequest$json = const {
  '1': 'ListMyDealsRequest',
  '2': const [
    const {'1': 'role', '3': 1, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListMyDealsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyDealsRequestDescriptor = $convert.base64Decode('ChJMaXN0TXlEZWFsc1JlcXVlc3QSEgoEcm9sZRgBIAEoCVIEcm9sZRIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cxISCgRwYWdlGAMgASgFUgRwYWdlEhQKBWxpbWl0GAQgASgFUgVsaW1pdA==');
@$core.Deprecated('Use listDealsResponseDescriptor instead')
const ListDealsResponse$json = const {
  '1': 'ListDealsResponse',
  '2': const [
    const {'1': 'deals', '3': 1, '4': 3, '5': 11, '6': '.escrow.Deal', '10': 'deals'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListDealsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDealsResponseDescriptor = $convert.base64Decode('ChFMaXN0RGVhbHNSZXNwb25zZRIiCgVkZWFscxgBIAMoCzIMLmVzY3Jvdy5EZWFsUgVkZWFscxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');
@$core.Deprecated('Use getDealRequestDescriptor instead')
const GetDealRequest$json = const {
  '1': 'GetDealRequest',
  '2': const [
    const {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
  ],
};

/// Descriptor for `GetDealRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDealRequestDescriptor = $convert.base64Decode('Cg5HZXREZWFsUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQ=');
@$core.Deprecated('Use dealResponseDescriptor instead')
const DealResponse$json = const {
  '1': 'DealResponse',
  '2': const [
    const {'1': 'deal', '3': 1, '4': 1, '5': 11, '6': '.escrow.Deal', '10': 'deal'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DealResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dealResponseDescriptor = $convert.base64Decode('CgxEZWFsUmVzcG9uc2USIAoEZGVhbBgBIAEoCzIMLmVzY3Jvdy5EZWFsUgRkZWFsEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use markDeliveredRequestDescriptor instead')
const MarkDeliveredRequest$json = const {
  '1': 'MarkDeliveredRequest',
  '2': const [
    const {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'delivery_note', '3': 2, '4': 1, '5': 9, '10': 'deliveryNote'},
    const {'1': 'seller_proof_image_url', '3': 3, '4': 1, '5': 9, '10': 'sellerProofImageUrl'},
  ],
};

/// Descriptor for `MarkDeliveredRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markDeliveredRequestDescriptor = $convert.base64Decode('ChRNYXJrRGVsaXZlcmVkUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSIwoNZGVsaXZlcnlfbm90ZRgCIAEoCVIMZGVsaXZlcnlOb3RlEjMKFnNlbGxlcl9wcm9vZl9pbWFnZV91cmwYAyABKAlSE3NlbGxlclByb29mSW1hZ2VVcmw=');
@$core.Deprecated('Use validateReleaseRequestDescriptor instead')
const ValidateReleaseRequest$json = const {
  '1': 'ValidateReleaseRequest',
  '2': const [
    const {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
    const {'1': 'verification_token', '3': 3, '4': 1, '5': 9, '10': 'verificationToken'},
    const {'1': 'idempotency_key', '3': 4, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `ValidateReleaseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateReleaseRequestDescriptor = $convert.base64Decode('ChZWYWxpZGF0ZVJlbGVhc2VSZXF1ZXN0EhcKB2RlYWxfaWQYASABKAlSBmRlYWxJZBIlCg50cmFuc2FjdGlvbl9pZBgCIAEoCVINdHJhbnNhY3Rpb25JZBItChJ2ZXJpZmljYXRpb25fdG9rZW4YAyABKAlSEXZlcmlmaWNhdGlvblRva2VuEicKD2lkZW1wb3RlbmN5X2tleRgEIAEoCVIOaWRlbXBvdGVuY3lLZXk=');
@$core.Deprecated('Use cancelDealRequestDescriptor instead')
const CancelDealRequest$json = const {
  '1': 'CancelDealRequest',
  '2': const [
    const {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'idempotency_key', '3': 3, '4': 1, '5': 9, '10': 'idempotencyKey'},
  ],
};

/// Descriptor for `CancelDealRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelDealRequestDescriptor = $convert.base64Decode('ChFDYW5jZWxEZWFsUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24SJwoPaWRlbXBvdGVuY3lfa2V5GAMgASgJUg5pZGVtcG90ZW5jeUtleQ==');
@$core.Deprecated('Use openDisputeRequestDescriptor instead')
const OpenDisputeRequest$json = const {
  '1': 'OpenDisputeRequest',
  '2': const [
    const {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'evidence_url', '3': 3, '4': 1, '5': 9, '10': 'evidenceUrl'},
  ],
};

/// Descriptor for `OpenDisputeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openDisputeRequestDescriptor = $convert.base64Decode('ChJPcGVuRGlzcHV0ZVJlcXVlc3QSFwoHZGVhbF9pZBgBIAEoCVIGZGVhbElkEhYKBnJlYXNvbhgCIAEoCVIGcmVhc29uEiEKDGV2aWRlbmNlX3VybBgDIAEoCVILZXZpZGVuY2VVcmw=');
@$core.Deprecated('Use quoteFeeRequestDescriptor instead')
const QuoteFeeRequest$json = const {
  '1': 'QuoteFeeRequest',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 2, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `QuoteFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteFeeRequestDescriptor = $convert.base64Decode('Cg9RdW90ZUZlZVJlcXVlc3QSFgoGYW1vdW50GAEgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAiABKAlSCGN1cnJlbmN5');
@$core.Deprecated('Use quoteFeeResponseDescriptor instead')
const QuoteFeeResponse$json = const {
  '1': 'QuoteFeeResponse',
  '2': const [
    const {'1': 'amount', '3': 1, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'fee', '3': 2, '4': 1, '5': 1, '10': 'fee'},
    const {'1': 'fee_payer', '3': 3, '4': 1, '5': 9, '10': 'feePayer'},
    const {'1': 'buyer_total', '3': 4, '4': 1, '5': 1, '10': 'buyerTotal'},
    const {'1': 'seller_net', '3': 5, '4': 1, '5': 1, '10': 'sellerNet'},
  ],
};

/// Descriptor for `QuoteFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteFeeResponseDescriptor = $convert.base64Decode('ChBRdW90ZUZlZVJlc3BvbnNlEhYKBmFtb3VudBgBIAEoAVIGYW1vdW50EhAKA2ZlZRgCIAEoAVIDZmVlEhsKCWZlZV9wYXllchgDIAEoCVIIZmVlUGF5ZXISHwoLYnV5ZXJfdG90YWwYBCABKAFSCmJ1eWVyVG90YWwSHQoKc2VsbGVyX25ldBgFIAEoAVIJc2VsbGVyTmV0');
@$core.Deprecated('Use addAttachmentRequestDescriptor instead')
const AddAttachmentRequest$json = const {
  '1': 'AddAttachmentRequest',
  '2': const [
    const {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'purpose', '3': 2, '4': 1, '5': 9, '10': 'purpose'},
    const {'1': 'media_kind', '3': 3, '4': 1, '5': 9, '10': 'mediaKind'},
    const {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'content_type', '3': 5, '4': 1, '5': 9, '10': 'contentType'},
    const {'1': 'size_bytes', '3': 6, '4': 1, '5': 3, '10': 'sizeBytes'},
    const {'1': 'duration_seconds', '3': 7, '4': 1, '5': 5, '10': 'durationSeconds'},
  ],
};

/// Descriptor for `AddAttachmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addAttachmentRequestDescriptor = $convert.base64Decode('ChRBZGRBdHRhY2htZW50UmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSGAoHcHVycG9zZRgCIAEoCVIHcHVycG9zZRIdCgptZWRpYV9raW5kGAMgASgJUgltZWRpYUtpbmQSEAoDdXJsGAQgASgJUgN1cmwSIQoMY29udGVudF90eXBlGAUgASgJUgtjb250ZW50VHlwZRIdCgpzaXplX2J5dGVzGAYgASgDUglzaXplQnl0ZXMSKQoQZHVyYXRpb25fc2Vjb25kcxgHIAEoBVIPZHVyYXRpb25TZWNvbmRz');
@$core.Deprecated('Use attachmentResponseDescriptor instead')
const AttachmentResponse$json = const {
  '1': 'AttachmentResponse',
  '2': const [
    const {'1': 'attachment', '3': 1, '4': 1, '5': 11, '6': '.escrow.Attachment', '10': 'attachment'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `AttachmentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attachmentResponseDescriptor = $convert.base64Decode('ChJBdHRhY2htZW50UmVzcG9uc2USMgoKYXR0YWNobWVudBgBIAEoCzISLmVzY3Jvdy5BdHRhY2htZW50UgphdHRhY2htZW50EhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');
@$core.Deprecated('Use requestRefundRequestDescriptor instead')
const RequestRefundRequest$json = const {
  '1': 'RequestRefundRequest',
  '2': const [
    const {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RequestRefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestRefundRequestDescriptor = $convert.base64Decode('ChRSZXF1ZXN0UmVmdW5kUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');
@$core.Deprecated('Use respondRefundRequestDescriptor instead')
const RespondRefundRequest$json = const {
  '1': 'RespondRefundRequest',
  '2': const [
    const {'1': 'deal_id', '3': 1, '4': 1, '5': 9, '10': 'dealId'},
    const {'1': 'accept', '3': 2, '4': 1, '5': 8, '10': 'accept'},
    const {'1': 'note', '3': 3, '4': 1, '5': 9, '10': 'note'},
  ],
};

/// Descriptor for `RespondRefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List respondRefundRequestDescriptor = $convert.base64Decode('ChRSZXNwb25kUmVmdW5kUmVxdWVzdBIXCgdkZWFsX2lkGAEgASgJUgZkZWFsSWQSFgoGYWNjZXB0GAIgASgIUgZhY2NlcHQSEgoEbm90ZRgDIAEoCVIEbm90ZQ==');
