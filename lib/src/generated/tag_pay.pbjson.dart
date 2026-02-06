//
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use tagPayTransactionStatusDescriptor instead')
const TagPayTransactionStatus$json = {
  '1': 'TagPayTransactionStatus',
  '2': [
    {'1': 'TAG_PAY_TRANSACTION_STATUS_PENDING', '2': 0},
    {'1': 'TAG_PAY_TRANSACTION_STATUS_PROCESSING', '2': 1},
    {'1': 'TAG_PAY_TRANSACTION_STATUS_COMPLETED', '2': 2},
    {'1': 'TAG_PAY_TRANSACTION_STATUS_FAILED', '2': 3},
    {'1': 'TAG_PAY_TRANSACTION_STATUS_CANCELLED', '2': 4},
    {'1': 'TAG_PAY_TRANSACTION_STATUS_REFUNDED', '2': 5},
  ],
};

/// Descriptor for `TagPayTransactionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tagPayTransactionStatusDescriptor = $convert.base64Decode(
    'ChdUYWdQYXlUcmFuc2FjdGlvblN0YXR1cxImCiJUQUdfUEFZX1RSQU5TQUNUSU9OX1NUQVRVU1'
    '9QRU5ESU5HEAASKQolVEFHX1BBWV9UUkFOU0FDVElPTl9TVEFUVVNfUFJPQ0VTU0lORxABEigK'
    'JFRBR19QQVlfVFJBTlNBQ1RJT05fU1RBVFVTX0NPTVBMRVRFRBACEiUKIVRBR19QQVlfVFJBTl'
    'NBQ1RJT05fU1RBVFVTX0ZBSUxFRBADEigKJFRBR19QQVlfVFJBTlNBQ1RJT05fU1RBVFVTX0NB'
    'TkNFTExFRBAEEicKI1RBR19QQVlfVFJBTlNBQ1RJT05fU1RBVFVTX1JFRlVOREVEEAU=');

@$core.Deprecated('Use tagPayTransactionTypeDescriptor instead')
const TagPayTransactionType$json = {
  '1': 'TagPayTransactionType',
  '2': [
    {'1': 'TAG_PAY_TRANSACTION_TYPE_SEND', '2': 0},
    {'1': 'TAG_PAY_TRANSACTION_TYPE_RECEIVE', '2': 1},
    {'1': 'TAG_PAY_TRANSACTION_TYPE_REQUEST', '2': 2},
    {'1': 'TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED', '2': 3},
  ],
};

/// Descriptor for `TagPayTransactionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tagPayTransactionTypeDescriptor = $convert.base64Decode(
    'ChVUYWdQYXlUcmFuc2FjdGlvblR5cGUSIQodVEFHX1BBWV9UUkFOU0FDVElPTl9UWVBFX1NFTk'
    'QQABIkCiBUQUdfUEFZX1RSQU5TQUNUSU9OX1RZUEVfUkVDRUlWRRABEiQKIFRBR19QQVlfVFJB'
    'TlNBQ1RJT05fVFlQRV9SRVFVRVNUEAISLgoqVEFHX1BBWV9UUkFOU0FDVElPTl9UWVBFX1JFUV'
    'VFU1RfRlVMRklMTEVEEAM=');

@$core.Deprecated('Use moneyRequestStatusDescriptor instead')
const MoneyRequestStatus$json = {
  '1': 'MoneyRequestStatus',
  '2': [
    {'1': 'MONEY_REQUEST_STATUS_PENDING', '2': 0},
    {'1': 'MONEY_REQUEST_STATUS_ACCEPTED', '2': 1},
    {'1': 'MONEY_REQUEST_STATUS_DECLINED', '2': 2},
    {'1': 'MONEY_REQUEST_STATUS_EXPIRED', '2': 3},
    {'1': 'MONEY_REQUEST_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `MoneyRequestStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List moneyRequestStatusDescriptor = $convert.base64Decode(
    'ChJNb25leVJlcXVlc3RTdGF0dXMSIAocTU9ORVlfUkVRVUVTVF9TVEFUVVNfUEVORElORxAAEi'
    'EKHU1PTkVZX1JFUVVFU1RfU1RBVFVTX0FDQ0VQVEVEEAESIQodTU9ORVlfUkVRVUVTVF9TVEFU'
    'VVNfREVDTElORUQQAhIgChxNT05FWV9SRVFVRVNUX1NUQVRVU19FWFBJUkVEEAMSIgoeTU9ORV'
    'lfUkVRVUVTVF9TVEFUVVNfQ0FOQ0VMTEVEEAQ=');

@$core.Deprecated('Use tagStatusDescriptor instead')
const TagStatus$json = {
  '1': 'TagStatus',
  '2': [
    {'1': 'TAG_STATUS_PENDING', '2': 0},
    {'1': 'TAG_STATUS_PAID', '2': 1},
    {'1': 'TAG_STATUS_CANCELLED', '2': 2},
  ],
};

/// Descriptor for `TagStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tagStatusDescriptor = $convert.base64Decode(
    'CglUYWdTdGF0dXMSFgoSVEFHX1NUQVRVU19QRU5ESU5HEAASEwoPVEFHX1NUQVRVU19QQUlEEA'
    'ESGAoUVEFHX1NUQVRVU19DQU5DRUxMRUQQAg==');

@$core.Deprecated('Use tagPayDescriptor instead')
const TagPay$json = {
  '1': 'TagPay',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'tag_pay', '3': 3, '4': 1, '5': 9, '10': 'tagPay'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'avatar_url', '3': 5, '4': 1, '5': 9, '10': 'avatarUrl'},
    {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `TagPay`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagPayDescriptor = $convert.base64Decode(
    'CgZUYWdQYXkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIXCgd0YW'
    'dfcGF5GAMgASgJUgZ0YWdQYXkSIQoMZGlzcGxheV9uYW1lGAQgASgJUgtkaXNwbGF5TmFtZRId'
    'CgphdmF0YXJfdXJsGAUgASgJUglhdmF0YXJVcmwSGwoJaXNfYWN0aXZlGAYgASgIUghpc0FjdG'
    'l2ZRI5CgpjcmVhdGVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3Jl'
    'YXRlZEF0EjkKCnVwZGF0ZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg'
    'l1cGRhdGVkQXQ=');

@$core.Deprecated('Use tagPayTransactionDescriptor instead')
const TagPayTransaction$json = {
  '1': 'TagPayTransaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'sender_tag_pay', '3': 3, '4': 1, '5': 9, '10': 'senderTagPay'},
    {'1': 'sender_name', '3': 4, '4': 1, '5': 9, '10': 'senderName'},
    {'1': 'receiver_id', '3': 5, '4': 1, '5': 9, '10': 'receiverId'},
    {'1': 'receiver_tag_pay', '3': 6, '4': 1, '5': 9, '10': 'receiverTagPay'},
    {'1': 'receiver_name', '3': 7, '4': 1, '5': 9, '10': 'receiverName'},
    {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.pb.TagPayTransactionStatus', '10': 'status'},
    {'1': 'type', '3': 12, '4': 1, '5': 14, '6': '.pb.TagPayTransactionType', '10': 'type'},
    {'1': 'reference_number', '3': 13, '4': 1, '5': 9, '10': 'referenceNumber'},
    {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'completed_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `TagPayTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagPayTransactionDescriptor = $convert.base64Decode(
    'ChFUYWdQYXlUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSGwoJc2VuZGVyX2lkGAIgASgJUg'
    'hzZW5kZXJJZBIkCg5zZW5kZXJfdGFnX3BheRgDIAEoCVIMc2VuZGVyVGFnUGF5Eh8KC3NlbmRl'
    'cl9uYW1lGAQgASgJUgpzZW5kZXJOYW1lEh8KC3JlY2VpdmVyX2lkGAUgASgJUgpyZWNlaXZlck'
    'lkEigKEHJlY2VpdmVyX3RhZ19wYXkYBiABKAlSDnJlY2VpdmVyVGFnUGF5EiMKDXJlY2VpdmVy'
    'X25hbWUYByABKAlSDHJlY2VpdmVyTmFtZRIWCgZhbW91bnQYCCABKAFSBmFtb3VudBIaCghjdX'
    'JyZW5jeRgJIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YCiABKAlSC2Rlc2NyaXB0aW9u'
    'EjMKBnN0YXR1cxgLIAEoDjIbLnBiLlRhZ1BheVRyYW5zYWN0aW9uU3RhdHVzUgZzdGF0dXMSLQ'
    'oEdHlwZRgMIAEoDjIZLnBiLlRhZ1BheVRyYW5zYWN0aW9uVHlwZVIEdHlwZRIpChByZWZlcmVu'
    'Y2VfbnVtYmVyGA0gASgJUg9yZWZlcmVuY2VOdW1iZXISOQoKY3JlYXRlZF9hdBgOIAEoCzIaLm'
    'dvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9Cgxjb21wbGV0ZWRfYXQYDyAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtjb21wbGV0ZWRBdA==');

@$core.Deprecated('Use moneyRequestDescriptor instead')
const MoneyRequest$json = {
  '1': 'MoneyRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'requester_id', '3': 2, '4': 1, '5': 9, '10': 'requesterId'},
    {'1': 'requester_tag_pay', '3': 3, '4': 1, '5': 9, '10': 'requesterTagPay'},
    {'1': 'requester_name', '3': 4, '4': 1, '5': 9, '10': 'requesterName'},
    {'1': 'requestee_id', '3': 5, '4': 1, '5': 9, '10': 'requesteeId'},
    {'1': 'requestee_tag_pay', '3': 6, '4': 1, '5': 9, '10': 'requesteeTagPay'},
    {'1': 'requestee_name', '3': 7, '4': 1, '5': 9, '10': 'requesteeName'},
    {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.pb.MoneyRequestStatus', '10': 'status'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'responded_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'respondedAt'},
    {'1': 'expires_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
  ],
};

/// Descriptor for `MoneyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneyRequestDescriptor = $convert.base64Decode(
    'CgxNb25leVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEiEKDHJlcXVlc3Rlcl9pZBgCIAEoCVILcm'
    'VxdWVzdGVySWQSKgoRcmVxdWVzdGVyX3RhZ19wYXkYAyABKAlSD3JlcXVlc3RlclRhZ1BheRIl'
    'Cg5yZXF1ZXN0ZXJfbmFtZRgEIAEoCVINcmVxdWVzdGVyTmFtZRIhCgxyZXF1ZXN0ZWVfaWQYBS'
    'ABKAlSC3JlcXVlc3RlZUlkEioKEXJlcXVlc3RlZV90YWdfcGF5GAYgASgJUg9yZXF1ZXN0ZWVU'
    'YWdQYXkSJQoOcmVxdWVzdGVlX25hbWUYByABKAlSDXJlcXVlc3RlZU5hbWUSFgoGYW1vdW50GA'
    'ggASgBUgZhbW91bnQSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9u'
    'GAogASgJUgtkZXNjcmlwdGlvbhIuCgZzdGF0dXMYCyABKA4yFi5wYi5Nb25leVJlcXVlc3RTdG'
    'F0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVz'
    'dGFtcFIJY3JlYXRlZEF0Ej0KDHJlc3BvbmRlZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi'
    '5UaW1lc3RhbXBSC3Jlc3BvbmRlZEF0EjkKCmV4cGlyZXNfYXQYDiABKAsyGi5nb29nbGUucHJv'
    'dG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQ=');

@$core.Deprecated('Use userTagDescriptor instead')
const UserTag$json = {
  '1': 'UserTag',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'tagger_id', '3': 2, '4': 1, '5': 9, '10': 'taggerId'},
    {'1': 'tagger_tag_pay', '3': 3, '4': 1, '5': 9, '10': 'taggerTagPay'},
    {'1': 'tagger_name', '3': 4, '4': 1, '5': 9, '10': 'taggerName'},
    {'1': 'tagged_user_id', '3': 5, '4': 1, '5': 9, '10': 'taggedUserId'},
    {'1': 'tagged_user_tag_pay', '3': 6, '4': 1, '5': 9, '10': 'taggedUserTagPay'},
    {'1': 'tagged_user_name', '3': 7, '4': 1, '5': 9, '10': 'taggedUserName'},
    {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.pb.TagStatus', '10': 'status'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'paid_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paidAt'},
  ],
};

/// Descriptor for `UserTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userTagDescriptor = $convert.base64Decode(
    'CgdVc2VyVGFnEg4KAmlkGAEgASgJUgJpZBIbCgl0YWdnZXJfaWQYAiABKAlSCHRhZ2dlcklkEi'
    'QKDnRhZ2dlcl90YWdfcGF5GAMgASgJUgx0YWdnZXJUYWdQYXkSHwoLdGFnZ2VyX25hbWUYBCAB'
    'KAlSCnRhZ2dlck5hbWUSJAoOdGFnZ2VkX3VzZXJfaWQYBSABKAlSDHRhZ2dlZFVzZXJJZBItCh'
    'N0YWdnZWRfdXNlcl90YWdfcGF5GAYgASgJUhB0YWdnZWRVc2VyVGFnUGF5EigKEHRhZ2dlZF91'
    'c2VyX25hbWUYByABKAlSDnRhZ2dlZFVzZXJOYW1lEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50Eh'
    'oKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgKIAEoCVILZGVzY3Jp'
    'cHRpb24SJQoGc3RhdHVzGAsgASgOMg0ucGIuVGFnU3RhdHVzUgZzdGF0dXMSOQoKY3JlYXRlZF'
    '9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBIzCgdwYWlk'
    'X2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIGcGFpZEF0');

@$core.Deprecated('Use createTagPayRequestDescriptor instead')
const CreateTagPayRequest$json = {
  '1': 'CreateTagPayRequest',
  '2': [
    {'1': 'tag_pay', '3': 1, '4': 1, '5': 9, '10': 'tagPay'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'avatar_url', '3': 3, '4': 1, '5': 9, '10': 'avatarUrl'},
  ],
};

/// Descriptor for `CreateTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTagPayRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVUYWdQYXlSZXF1ZXN0EhcKB3RhZ19wYXkYASABKAlSBnRhZ1BheRIhCgxkaXNwbG'
    'F5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEh0KCmF2YXRhcl91cmwYAyABKAlSCWF2YXRhclVy'
    'bA==');

@$core.Deprecated('Use createTagPayResponseDescriptor instead')
const CreateTagPayResponse$json = {
  '1': 'CreateTagPayResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'tag_pay', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPay', '10': 'tagPay'},
  ],
};

/// Descriptor for `CreateTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTagPayResponseDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVUYWdQYXlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2USIwoHdGFnX3BheRgDIAEoCzIKLnBiLlRhZ1BheVIGdGFnUGF5');

@$core.Deprecated('Use getTagPayRequestDescriptor instead')
const GetTagPayRequest$json = {
  '1': 'GetTagPayRequest',
  '2': [
    {'1': 'tag_pay', '3': 1, '4': 1, '5': 9, '10': 'tagPay'},
  ],
};

/// Descriptor for `GetTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTagPayRequestDescriptor = $convert.base64Decode(
    'ChBHZXRUYWdQYXlSZXF1ZXN0EhcKB3RhZ19wYXkYASABKAlSBnRhZ1BheQ==');

@$core.Deprecated('Use getTagPayResponseDescriptor instead')
const GetTagPayResponse$json = {
  '1': 'GetTagPayResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'tag_pay', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPay', '10': 'tagPay'},
  ],
};

/// Descriptor for `GetTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTagPayResponseDescriptor = $convert.base64Decode(
    'ChFHZXRUYWdQYXlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2'
    'UYAiABKAlSB21lc3NhZ2USIwoHdGFnX3BheRgDIAEoCzIKLnBiLlRhZ1BheVIGdGFnUGF5');

@$core.Deprecated('Use checkTagPayAvailabilityRequestDescriptor instead')
const CheckTagPayAvailabilityRequest$json = {
  '1': 'CheckTagPayAvailabilityRequest',
  '2': [
    {'1': 'tag_pay', '3': 1, '4': 1, '5': 9, '10': 'tagPay'},
  ],
};

/// Descriptor for `CheckTagPayAvailabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkTagPayAvailabilityRequestDescriptor = $convert.base64Decode(
    'Ch5DaGVja1RhZ1BheUF2YWlsYWJpbGl0eVJlcXVlc3QSFwoHdGFnX3BheRgBIAEoCVIGdGFnUG'
    'F5');

@$core.Deprecated('Use checkTagPayAvailabilityResponseDescriptor instead')
const CheckTagPayAvailabilityResponse$json = {
  '1': 'CheckTagPayAvailabilityResponse',
  '2': [
    {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'suggestions', '3': 3, '4': 3, '5': 9, '10': 'suggestions'},
  ],
};

/// Descriptor for `CheckTagPayAvailabilityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkTagPayAvailabilityResponseDescriptor = $convert.base64Decode(
    'Ch9DaGVja1RhZ1BheUF2YWlsYWJpbGl0eVJlc3BvbnNlEhwKCWF2YWlsYWJsZRgBIAEoCFIJYX'
    'ZhaWxhYmxlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIAoLc3VnZ2VzdGlvbnMYAyADKAlS'
    'C3N1Z2dlc3Rpb25z');

@$core.Deprecated('Use searchTagPayRequestDescriptor instead')
const SearchTagPayRequest$json = {
  '1': 'SearchTagPayRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTagPayRequestDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hUYWdQYXlSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIUCgVsaW1pdBgCIA'
    'EoBVIFbGltaXQ=');

@$core.Deprecated('Use searchTagPayResponseDescriptor instead')
const SearchTagPayResponse$json = {
  '1': 'SearchTagPayResponse',
  '2': [
    {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.pb.TagPay', '10': 'results'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `SearchTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTagPayResponseDescriptor = $convert.base64Decode(
    'ChRTZWFyY2hUYWdQYXlSZXNwb25zZRIkCgdyZXN1bHRzGAEgAygLMgoucGIuVGFnUGF5UgdyZX'
    'N1bHRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use sendMoneyTagPayRequestDescriptor instead')
const SendMoneyTagPayRequest$json = {
  '1': 'SendMoneyTagPayRequest',
  '2': [
    {'1': 'receiver_tag_pay', '3': 1, '4': 1, '5': 9, '10': 'receiverTagPay'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'source_account_id', '3': 5, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'transaction_pin', '3': 6, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `SendMoneyTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMoneyTagPayRequestDescriptor = $convert.base64Decode(
    'ChZTZW5kTW9uZXlUYWdQYXlSZXF1ZXN0EigKEHJlY2VpdmVyX3RhZ19wYXkYASABKAlSDnJlY2'
    'VpdmVyVGFnUGF5EhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghj'
    'dXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SKgoRc291cmNlX2FjY2'
    '91bnRfaWQYBSABKAlSD3NvdXJjZUFjY291bnRJZBInCg90cmFuc2FjdGlvbl9waW4YBiABKAlS'
    'DnRyYW5zYWN0aW9uUGlu');

@$core.Deprecated('Use sendMoneyTagPayResponseDescriptor instead')
const SendMoneyTagPayResponse$json = {
  '1': 'SendMoneyTagPayResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPayTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `SendMoneyTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMoneyTagPayResponseDescriptor = $convert.base64Decode(
    'ChdTZW5kTW9uZXlUYWdQYXlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2USNwoLdHJhbnNhY3Rpb24YAyABKAsyFS5wYi5UYWdQYXlU'
    'cmFuc2FjdGlvblILdHJhbnNhY3Rpb24=');

@$core.Deprecated('Use requestMoneyTagPayRequestDescriptor instead')
const RequestMoneyTagPayRequest$json = {
  '1': 'RequestMoneyTagPayRequest',
  '2': [
    {'1': 'requestee_tag_pay', '3': 1, '4': 1, '5': 9, '10': 'requesteeTagPay'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `RequestMoneyTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestMoneyTagPayRequestDescriptor = $convert.base64Decode(
    'ChlSZXF1ZXN0TW9uZXlUYWdQYXlSZXF1ZXN0EioKEXJlcXVlc3RlZV90YWdfcGF5GAEgASgJUg'
    '9yZXF1ZXN0ZWVUYWdQYXkSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyAB'
    'KAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbg==');

@$core.Deprecated('Use requestMoneyTagPayResponseDescriptor instead')
const RequestMoneyTagPayResponse$json = {
  '1': 'RequestMoneyTagPayResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'money_request', '3': 3, '4': 1, '5': 11, '6': '.pb.MoneyRequest', '10': 'moneyRequest'},
  ],
};

/// Descriptor for `RequestMoneyTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestMoneyTagPayResponseDescriptor = $convert.base64Decode(
    'ChpSZXF1ZXN0TW9uZXlUYWdQYXlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    'gKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNQoNbW9uZXlfcmVxdWVzdBgDIAEoCzIQLnBiLk1v'
    'bmV5UmVxdWVzdFIMbW9uZXlSZXF1ZXN0');

@$core.Deprecated('Use getTagPayTransactionsRequestDescriptor instead')
const GetTagPayTransactionsRequest$json = {
  '1': 'GetTagPayTransactionsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.pb.TagPayTransactionType', '10': 'type'},
  ],
};

/// Descriptor for `GetTagPayTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTagPayTransactionsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRUYWdQYXlUcmFuc2FjdGlvbnNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbG'
    'ltaXQYAiABKAVSBWxpbWl0Ei0KBHR5cGUYAyABKA4yGS5wYi5UYWdQYXlUcmFuc2FjdGlvblR5'
    'cGVSBHR5cGU=');

@$core.Deprecated('Use getTagPayTransactionsResponseDescriptor instead')
const GetTagPayTransactionsResponse$json = {
  '1': 'GetTagPayTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.TagPayTransaction', '10': 'transactions'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetTagPayTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTagPayTransactionsResponseDescriptor = $convert.base64Decode(
    'Ch1HZXRUYWdQYXlUcmFuc2FjdGlvbnNSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS'
    '5wYi5UYWdQYXlUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3Rh'
    'bBISCgRwYWdlGAMgASgFUgRwYWdlEh8KC3RvdGFsX3BhZ2VzGAQgASgFUgp0b3RhbFBhZ2Vz');

@$core.Deprecated('Use acceptMoneyRequestRequestDescriptor instead')
const AcceptMoneyRequestRequest$json = {
  '1': 'AcceptMoneyRequestRequest',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `AcceptMoneyRequestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptMoneyRequestRequestDescriptor = $convert.base64Decode(
    'ChlBY2NlcHRNb25leVJlcXVlc3RSZXF1ZXN0Eh0KCnJlcXVlc3RfaWQYASABKAlSCXJlcXVlc3'
    'RJZBIqChFzb3VyY2VfYWNjb3VudF9pZBgCIAEoCVIPc291cmNlQWNjb3VudElkEicKD3RyYW5z'
    'YWN0aW9uX3BpbhgDIAEoCVIOdHJhbnNhY3Rpb25QaW4=');

@$core.Deprecated('Use acceptMoneyRequestResponseDescriptor instead')
const AcceptMoneyRequestResponse$json = {
  '1': 'AcceptMoneyRequestResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPayTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `AcceptMoneyRequestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptMoneyRequestResponseDescriptor = $convert.base64Decode(
    'ChpBY2NlcHRNb25leVJlcXVlc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
    'gKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNwoLdHJhbnNhY3Rpb24YAyABKAsyFS5wYi5UYWdQ'
    'YXlUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24=');

@$core.Deprecated('Use declineMoneyRequestRequestDescriptor instead')
const DeclineMoneyRequestRequest$json = {
  '1': 'DeclineMoneyRequestRequest',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `DeclineMoneyRequestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineMoneyRequestRequestDescriptor = $convert.base64Decode(
    'ChpEZWNsaW5lTW9uZXlSZXF1ZXN0UmVxdWVzdBIdCgpyZXF1ZXN0X2lkGAEgASgJUglyZXF1ZX'
    'N0SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use declineMoneyRequestResponseDescriptor instead')
const DeclineMoneyRequestResponse$json = {
  '1': 'DeclineMoneyRequestResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeclineMoneyRequestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineMoneyRequestResponseDescriptor = $convert.base64Decode(
    'ChtEZWNsaW5lTW9uZXlSZXF1ZXN0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use getPendingMoneyRequestsRequestDescriptor instead')
const GetPendingMoneyRequestsRequest$json = {
  '1': 'GetPendingMoneyRequestsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'incoming', '3': 3, '4': 1, '5': 8, '10': 'incoming'},
  ],
};

/// Descriptor for `GetPendingMoneyRequestsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingMoneyRequestsRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRQZW5kaW5nTW9uZXlSZXF1ZXN0c1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCg'
    'VsaW1pdBgCIAEoBVIFbGltaXQSGgoIaW5jb21pbmcYAyABKAhSCGluY29taW5n');

@$core.Deprecated('Use getPendingMoneyRequestsResponseDescriptor instead')
const GetPendingMoneyRequestsResponse$json = {
  '1': 'GetPendingMoneyRequestsResponse',
  '2': [
    {'1': 'requests', '3': 1, '4': 3, '5': 11, '6': '.pb.MoneyRequest', '10': 'requests'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetPendingMoneyRequestsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingMoneyRequestsResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRQZW5kaW5nTW9uZXlSZXF1ZXN0c1Jlc3BvbnNlEiwKCHJlcXVlc3RzGAEgAygLMhAucG'
    'IuTW9uZXlSZXF1ZXN0UghyZXF1ZXN0cxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSEgoEcGFnZRgD'
    'IAEoBVIEcGFnZRIfCgt0b3RhbF9wYWdlcxgEIAEoBVIKdG90YWxQYWdlcw==');

@$core.Deprecated('Use createTagRequestDescriptor instead')
const CreateTagRequest$json = {
  '1': 'CreateTagRequest',
  '2': [
    {'1': 'tagged_user_tag_pay', '3': 1, '4': 1, '5': 9, '10': 'taggedUserTagPay'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTagRequestDescriptor = $convert.base64Decode(
    'ChBDcmVhdGVUYWdSZXF1ZXN0Ei0KE3RhZ2dlZF91c2VyX3RhZ19wYXkYASABKAlSEHRhZ2dlZF'
    'VzZXJUYWdQYXkSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1'
    'cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbg==');

@$core.Deprecated('Use createTagResponseDescriptor instead')
const CreateTagResponse$json = {
  '1': 'CreateTagResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'tag', '3': 3, '4': 1, '5': 11, '6': '.pb.UserTag', '10': 'tag'},
  ],
};

/// Descriptor for `CreateTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTagResponseDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVUYWdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2'
    'UYAiABKAlSB21lc3NhZ2USHQoDdGFnGAMgASgLMgsucGIuVXNlclRhZ1IDdGFn');

@$core.Deprecated('Use getMyTagsRequestDescriptor instead')
const GetMyTagsRequest$json = {
  '1': 'GetMyTagsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.TagStatus', '10': 'status'},
  ],
};

/// Descriptor for `GetMyTagsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyTagsRequestDescriptor = $convert.base64Decode(
    'ChBHZXRNeVRhZ3NSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBW'
    'xpbWl0EiUKBnN0YXR1cxgDIAEoDjINLnBiLlRhZ1N0YXR1c1IGc3RhdHVz');

@$core.Deprecated('Use getMyTagsResponseDescriptor instead')
const GetMyTagsResponse$json = {
  '1': 'GetMyTagsResponse',
  '2': [
    {'1': 'tags', '3': 1, '4': 3, '5': 11, '6': '.pb.UserTag', '10': 'tags'},
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetMyTagsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyTagsResponseDescriptor = $convert.base64Decode(
    'ChFHZXRNeVRhZ3NSZXNwb25zZRIfCgR0YWdzGAEgAygLMgsucGIuVXNlclRhZ1IEdGFncxIUCg'
    'V0b3RhbBgCIAEoBVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIfCgt0b3RhbF9wYWdlcxgE'
    'IAEoBVIKdG90YWxQYWdlcw==');

@$core.Deprecated('Use payTagRequestDescriptor instead')
const PayTagRequest$json = {
  '1': 'PayTagRequest',
  '2': [
    {'1': 'tag_id', '3': 1, '4': 1, '5': 9, '10': 'tagId'},
    {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `PayTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payTagRequestDescriptor = $convert.base64Decode(
    'Cg1QYXlUYWdSZXF1ZXN0EhUKBnRhZ19pZBgBIAEoCVIFdGFnSWQSKgoRc291cmNlX2FjY291bn'
    'RfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBInCg90cmFuc2FjdGlvbl9waW4YAyABKAlSDnRy'
    'YW5zYWN0aW9uUGlu');

@$core.Deprecated('Use payTagResponseDescriptor instead')
const PayTagResponse$json = {
  '1': 'PayTagResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPayTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `PayTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payTagResponseDescriptor = $convert.base64Decode(
    'Cg5QYXlUYWdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAi'
    'ABKAlSB21lc3NhZ2USNwoLdHJhbnNhY3Rpb24YAyABKAsyFS5wYi5UYWdQYXlUcmFuc2FjdGlv'
    'blILdHJhbnNhY3Rpb24=');

@$core.Deprecated('Use searchUsersForTagRequestDescriptor instead')
const SearchUsersForTagRequest$json = {
  '1': 'SearchUsersForTagRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchUsersForTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersForTagRequestDescriptor = $convert.base64Decode(
    'ChhTZWFyY2hVc2Vyc0ZvclRhZ1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EhQKBWxpbW'
    'l0GAIgASgFUgVsaW1pdA==');

@$core.Deprecated('Use userSearchResultDescriptor instead')
const UserSearchResult$json = {
  '1': 'UserSearchResult',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'profile_picture', '3': 6, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `UserSearchResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSearchResultDescriptor = $convert.base64Decode(
    'ChBVc2VyU2VhcmNoUmVzdWx0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZR'
    'gCIAEoCVIIdXNlcm5hbWUSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3Rf'
    'bmFtZRgEIAEoCVIIbGFzdE5hbWUSFAoFZW1haWwYBSABKAlSBWVtYWlsEicKD3Byb2ZpbGVfcG'
    'ljdHVyZRgGIAEoCVIOcHJvZmlsZVBpY3R1cmU=');

@$core.Deprecated('Use searchUsersForTagResponseDescriptor instead')
const SearchUsersForTagResponse$json = {
  '1': 'SearchUsersForTagResponse',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.pb.UserSearchResult', '10': 'users'},
  ],
};

/// Descriptor for `SearchUsersForTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersForTagResponseDescriptor = $convert.base64Decode(
    'ChlTZWFyY2hVc2Vyc0ZvclRhZ1Jlc3BvbnNlEioKBXVzZXJzGAEgAygLMhQucGIuVXNlclNlYX'
    'JjaFJlc3VsdFIFdXNlcnM=');

@$core.Deprecated('Use batchCreateTagsRequestDescriptor instead')
const BatchCreateTagsRequest$json = {
  '1': 'BatchCreateTagsRequest',
  '2': [
    {'1': 'tagged_user_tag_pays', '3': 1, '4': 3, '5': 9, '10': 'taggedUserTagPays'},
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `BatchCreateTagsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateTagsRequestDescriptor = $convert.base64Decode(
    'ChZCYXRjaENyZWF0ZVRhZ3NSZXF1ZXN0Ei8KFHRhZ2dlZF91c2VyX3RhZ19wYXlzGAEgAygJUh'
    'F0YWdnZWRVc2VyVGFnUGF5cxIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgD'
    'IAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9u');

@$core.Deprecated('Use batchCreateTagsResponseDescriptor instead')
const BatchCreateTagsResponse$json = {
  '1': 'BatchCreateTagsResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'tags', '3': 3, '4': 3, '5': 11, '6': '.pb.UserTag', '10': 'tags'},
    {'1': 'failed_users', '3': 4, '4': 3, '5': 9, '10': 'failedUsers'},
  ],
};

/// Descriptor for `BatchCreateTagsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateTagsResponseDescriptor = $convert.base64Decode(
    'ChdCYXRjaENyZWF0ZVRhZ3NSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2USHwoEdGFncxgDIAMoCzILLnBiLlVzZXJUYWdSBHRhZ3MS'
    'IQoMZmFpbGVkX3VzZXJzGAQgAygJUgtmYWlsZWRVc2Vycw==');

