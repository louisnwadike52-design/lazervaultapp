///
//  Generated code. Do not modify.
//  source: tag_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use tagPayTransactionStatusDescriptor instead')
const TagPayTransactionStatus$json = const {
  '1': 'TagPayTransactionStatus',
  '2': const [
    const {'1': 'TAG_PAY_TRANSACTION_STATUS_PENDING', '2': 0},
    const {'1': 'TAG_PAY_TRANSACTION_STATUS_PROCESSING', '2': 1},
    const {'1': 'TAG_PAY_TRANSACTION_STATUS_COMPLETED', '2': 2},
    const {'1': 'TAG_PAY_TRANSACTION_STATUS_FAILED', '2': 3},
    const {'1': 'TAG_PAY_TRANSACTION_STATUS_CANCELLED', '2': 4},
    const {'1': 'TAG_PAY_TRANSACTION_STATUS_REFUNDED', '2': 5},
  ],
};

/// Descriptor for `TagPayTransactionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tagPayTransactionStatusDescriptor = $convert.base64Decode('ChdUYWdQYXlUcmFuc2FjdGlvblN0YXR1cxImCiJUQUdfUEFZX1RSQU5TQUNUSU9OX1NUQVRVU19QRU5ESU5HEAASKQolVEFHX1BBWV9UUkFOU0FDVElPTl9TVEFUVVNfUFJPQ0VTU0lORxABEigKJFRBR19QQVlfVFJBTlNBQ1RJT05fU1RBVFVTX0NPTVBMRVRFRBACEiUKIVRBR19QQVlfVFJBTlNBQ1RJT05fU1RBVFVTX0ZBSUxFRBADEigKJFRBR19QQVlfVFJBTlNBQ1RJT05fU1RBVFVTX0NBTkNFTExFRBAEEicKI1RBR19QQVlfVFJBTlNBQ1RJT05fU1RBVFVTX1JFRlVOREVEEAU=');
@$core.Deprecated('Use tagPayTransactionTypeDescriptor instead')
const TagPayTransactionType$json = const {
  '1': 'TagPayTransactionType',
  '2': const [
    const {'1': 'TAG_PAY_TRANSACTION_TYPE_SEND', '2': 0},
    const {'1': 'TAG_PAY_TRANSACTION_TYPE_RECEIVE', '2': 1},
    const {'1': 'TAG_PAY_TRANSACTION_TYPE_REQUEST', '2': 2},
    const {'1': 'TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED', '2': 3},
  ],
};

/// Descriptor for `TagPayTransactionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tagPayTransactionTypeDescriptor = $convert.base64Decode('ChVUYWdQYXlUcmFuc2FjdGlvblR5cGUSIQodVEFHX1BBWV9UUkFOU0FDVElPTl9UWVBFX1NFTkQQABIkCiBUQUdfUEFZX1RSQU5TQUNUSU9OX1RZUEVfUkVDRUlWRRABEiQKIFRBR19QQVlfVFJBTlNBQ1RJT05fVFlQRV9SRVFVRVNUEAISLgoqVEFHX1BBWV9UUkFOU0FDVElPTl9UWVBFX1JFUVVFU1RfRlVMRklMTEVEEAM=');
@$core.Deprecated('Use moneyRequestStatusDescriptor instead')
const MoneyRequestStatus$json = const {
  '1': 'MoneyRequestStatus',
  '2': const [
    const {'1': 'MONEY_REQUEST_STATUS_PENDING', '2': 0},
    const {'1': 'MONEY_REQUEST_STATUS_ACCEPTED', '2': 1},
    const {'1': 'MONEY_REQUEST_STATUS_DECLINED', '2': 2},
    const {'1': 'MONEY_REQUEST_STATUS_EXPIRED', '2': 3},
    const {'1': 'MONEY_REQUEST_STATUS_CANCELLED', '2': 4},
  ],
};

/// Descriptor for `MoneyRequestStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List moneyRequestStatusDescriptor = $convert.base64Decode('ChJNb25leVJlcXVlc3RTdGF0dXMSIAocTU9ORVlfUkVRVUVTVF9TVEFUVVNfUEVORElORxAAEiEKHU1PTkVZX1JFUVVFU1RfU1RBVFVTX0FDQ0VQVEVEEAESIQodTU9ORVlfUkVRVUVTVF9TVEFUVVNfREVDTElORUQQAhIgChxNT05FWV9SRVFVRVNUX1NUQVRVU19FWFBJUkVEEAMSIgoeTU9ORVlfUkVRVUVTVF9TVEFUVVNfQ0FOQ0VMTEVEEAQ=');
@$core.Deprecated('Use tagStatusDescriptor instead')
const TagStatus$json = const {
  '1': 'TagStatus',
  '2': const [
    const {'1': 'TAG_STATUS_PENDING', '2': 0},
    const {'1': 'TAG_STATUS_PAID', '2': 1},
    const {'1': 'TAG_STATUS_CANCELLED', '2': 2},
  ],
};

/// Descriptor for `TagStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tagStatusDescriptor = $convert.base64Decode('CglUYWdTdGF0dXMSFgoSVEFHX1NUQVRVU19QRU5ESU5HEAASEwoPVEFHX1NUQVRVU19QQUlEEAESGAoUVEFHX1NUQVRVU19DQU5DRUxMRUQQAg==');
@$core.Deprecated('Use tagPayDescriptor instead')
const TagPay$json = const {
  '1': 'TagPay',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'tag_pay', '3': 3, '4': 1, '5': 9, '10': 'tagPay'},
    const {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'avatar_url', '3': 5, '4': 1, '5': 9, '10': 'avatarUrl'},
    const {'1': 'is_active', '3': 6, '4': 1, '5': 8, '10': 'isActive'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `TagPay`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagPayDescriptor = $convert.base64Decode('CgZUYWdQYXkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIXCgd0YWdfcGF5GAMgASgJUgZ0YWdQYXkSIQoMZGlzcGxheV9uYW1lGAQgASgJUgtkaXNwbGF5TmFtZRIdCgphdmF0YXJfdXJsGAUgASgJUglhdmF0YXJVcmwSGwoJaXNfYWN0aXZlGAYgASgIUghpc0FjdGl2ZRI5CgpjcmVhdGVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use tagPayTransactionDescriptor instead')
const TagPayTransaction$json = const {
  '1': 'TagPayTransaction',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'sender_tag_pay', '3': 3, '4': 1, '5': 9, '10': 'senderTagPay'},
    const {'1': 'sender_name', '3': 4, '4': 1, '5': 9, '10': 'senderName'},
    const {'1': 'receiver_id', '3': 5, '4': 1, '5': 9, '10': 'receiverId'},
    const {'1': 'receiver_tag_pay', '3': 6, '4': 1, '5': 9, '10': 'receiverTagPay'},
    const {'1': 'receiver_name', '3': 7, '4': 1, '5': 9, '10': 'receiverName'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.pb.TagPayTransactionStatus', '10': 'status'},
    const {'1': 'type', '3': 12, '4': 1, '5': 14, '6': '.pb.TagPayTransactionType', '10': 'type'},
    const {'1': 'reference_number', '3': 13, '4': 1, '5': 9, '10': 'referenceNumber'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'completed_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'completedAt'},
  ],
};

/// Descriptor for `TagPayTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagPayTransactionDescriptor = $convert.base64Decode('ChFUYWdQYXlUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSGwoJc2VuZGVyX2lkGAIgASgJUghzZW5kZXJJZBIkCg5zZW5kZXJfdGFnX3BheRgDIAEoCVIMc2VuZGVyVGFnUGF5Eh8KC3NlbmRlcl9uYW1lGAQgASgJUgpzZW5kZXJOYW1lEh8KC3JlY2VpdmVyX2lkGAUgASgJUgpyZWNlaXZlcklkEigKEHJlY2VpdmVyX3RhZ19wYXkYBiABKAlSDnJlY2VpdmVyVGFnUGF5EiMKDXJlY2VpdmVyX25hbWUYByABKAlSDHJlY2VpdmVyTmFtZRIWCgZhbW91bnQYCCABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgJIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YCiABKAlSC2Rlc2NyaXB0aW9uEjMKBnN0YXR1cxgLIAEoDjIbLnBiLlRhZ1BheVRyYW5zYWN0aW9uU3RhdHVzUgZzdGF0dXMSLQoEdHlwZRgMIAEoDjIZLnBiLlRhZ1BheVRyYW5zYWN0aW9uVHlwZVIEdHlwZRIpChByZWZlcmVuY2VfbnVtYmVyGA0gASgJUg9yZWZlcmVuY2VOdW1iZXISOQoKY3JlYXRlZF9hdBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI9Cgxjb21wbGV0ZWRfYXQYDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtjb21wbGV0ZWRBdA==');
@$core.Deprecated('Use moneyRequestDescriptor instead')
const MoneyRequest$json = const {
  '1': 'MoneyRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'requester_id', '3': 2, '4': 1, '5': 9, '10': 'requesterId'},
    const {'1': 'requester_tag_pay', '3': 3, '4': 1, '5': 9, '10': 'requesterTagPay'},
    const {'1': 'requester_name', '3': 4, '4': 1, '5': 9, '10': 'requesterName'},
    const {'1': 'requestee_id', '3': 5, '4': 1, '5': 9, '10': 'requesteeId'},
    const {'1': 'requestee_tag_pay', '3': 6, '4': 1, '5': 9, '10': 'requesteeTagPay'},
    const {'1': 'requestee_name', '3': 7, '4': 1, '5': 9, '10': 'requesteeName'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.pb.MoneyRequestStatus', '10': 'status'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'responded_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'respondedAt'},
    const {'1': 'expires_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
  ],
};

/// Descriptor for `MoneyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneyRequestDescriptor = $convert.base64Decode('CgxNb25leVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEiEKDHJlcXVlc3Rlcl9pZBgCIAEoCVILcmVxdWVzdGVySWQSKgoRcmVxdWVzdGVyX3RhZ19wYXkYAyABKAlSD3JlcXVlc3RlclRhZ1BheRIlCg5yZXF1ZXN0ZXJfbmFtZRgEIAEoCVINcmVxdWVzdGVyTmFtZRIhCgxyZXF1ZXN0ZWVfaWQYBSABKAlSC3JlcXVlc3RlZUlkEioKEXJlcXVlc3RlZV90YWdfcGF5GAYgASgJUg9yZXF1ZXN0ZWVUYWdQYXkSJQoOcmVxdWVzdGVlX25hbWUYByABKAlSDXJlcXVlc3RlZU5hbWUSFgoGYW1vdW50GAggASgBUgZhbW91bnQSGgoIY3VycmVuY3kYCSABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAogASgJUgtkZXNjcmlwdGlvbhIuCgZzdGF0dXMYCyABKA4yFi5wYi5Nb25leVJlcXVlc3RTdGF0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ej0KDHJlc3BvbmRlZF9hdBgNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC3Jlc3BvbmRlZEF0EjkKCmV4cGlyZXNfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQ=');
@$core.Deprecated('Use userTagDescriptor instead')
const UserTag$json = const {
  '1': 'UserTag',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'tagger_id', '3': 2, '4': 1, '5': 9, '10': 'taggerId'},
    const {'1': 'tagger_tag_pay', '3': 3, '4': 1, '5': 9, '10': 'taggerTagPay'},
    const {'1': 'tagger_name', '3': 4, '4': 1, '5': 9, '10': 'taggerName'},
    const {'1': 'tagged_user_id', '3': 5, '4': 1, '5': 9, '10': 'taggedUserId'},
    const {'1': 'tagged_user_tag_pay', '3': 6, '4': 1, '5': 9, '10': 'taggedUserTagPay'},
    const {'1': 'tagged_user_name', '3': 7, '4': 1, '5': 9, '10': 'taggedUserName'},
    const {'1': 'amount', '3': 8, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 9, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.pb.TagStatus', '10': 'status'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'paid_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paidAt'},
  ],
};

/// Descriptor for `UserTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userTagDescriptor = $convert.base64Decode('CgdVc2VyVGFnEg4KAmlkGAEgASgJUgJpZBIbCgl0YWdnZXJfaWQYAiABKAlSCHRhZ2dlcklkEiQKDnRhZ2dlcl90YWdfcGF5GAMgASgJUgx0YWdnZXJUYWdQYXkSHwoLdGFnZ2VyX25hbWUYBCABKAlSCnRhZ2dlck5hbWUSJAoOdGFnZ2VkX3VzZXJfaWQYBSABKAlSDHRhZ2dlZFVzZXJJZBItChN0YWdnZWRfdXNlcl90YWdfcGF5GAYgASgJUhB0YWdnZWRVc2VyVGFnUGF5EigKEHRhZ2dlZF91c2VyX25hbWUYByABKAlSDnRhZ2dlZFVzZXJOYW1lEhYKBmFtb3VudBgIIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAkgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgKIAEoCVILZGVzY3JpcHRpb24SJQoGc3RhdHVzGAsgASgOMg0ucGIuVGFnU3RhdHVzUgZzdGF0dXMSOQoKY3JlYXRlZF9hdBgMIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBIzCgdwYWlkX2F0GA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIGcGFpZEF0');
@$core.Deprecated('Use createTagPayRequestDescriptor instead')
const CreateTagPayRequest$json = const {
  '1': 'CreateTagPayRequest',
  '2': const [
    const {'1': 'tag_pay', '3': 1, '4': 1, '5': 9, '10': 'tagPay'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'avatar_url', '3': 3, '4': 1, '5': 9, '10': 'avatarUrl'},
  ],
};

/// Descriptor for `CreateTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTagPayRequestDescriptor = $convert.base64Decode('ChNDcmVhdGVUYWdQYXlSZXF1ZXN0EhcKB3RhZ19wYXkYASABKAlSBnRhZ1BheRIhCgxkaXNwbGF5X25hbWUYAiABKAlSC2Rpc3BsYXlOYW1lEh0KCmF2YXRhcl91cmwYAyABKAlSCWF2YXRhclVybA==');
@$core.Deprecated('Use createTagPayResponseDescriptor instead')
const CreateTagPayResponse$json = const {
  '1': 'CreateTagPayResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'tag_pay', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPay', '10': 'tagPay'},
  ],
};

/// Descriptor for `CreateTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTagPayResponseDescriptor = $convert.base64Decode('ChRDcmVhdGVUYWdQYXlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoHdGFnX3BheRgDIAEoCzIKLnBiLlRhZ1BheVIGdGFnUGF5');
@$core.Deprecated('Use getTagPayRequestDescriptor instead')
const GetTagPayRequest$json = const {
  '1': 'GetTagPayRequest',
  '2': const [
    const {'1': 'tag_pay', '3': 1, '4': 1, '5': 9, '10': 'tagPay'},
  ],
};

/// Descriptor for `GetTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTagPayRequestDescriptor = $convert.base64Decode('ChBHZXRUYWdQYXlSZXF1ZXN0EhcKB3RhZ19wYXkYASABKAlSBnRhZ1BheQ==');
@$core.Deprecated('Use getTagPayResponseDescriptor instead')
const GetTagPayResponse$json = const {
  '1': 'GetTagPayResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'tag_pay', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPay', '10': 'tagPay'},
  ],
};

/// Descriptor for `GetTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTagPayResponseDescriptor = $convert.base64Decode('ChFHZXRUYWdQYXlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoHdGFnX3BheRgDIAEoCzIKLnBiLlRhZ1BheVIGdGFnUGF5');
@$core.Deprecated('Use checkTagPayAvailabilityRequestDescriptor instead')
const CheckTagPayAvailabilityRequest$json = const {
  '1': 'CheckTagPayAvailabilityRequest',
  '2': const [
    const {'1': 'tag_pay', '3': 1, '4': 1, '5': 9, '10': 'tagPay'},
  ],
};

/// Descriptor for `CheckTagPayAvailabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkTagPayAvailabilityRequestDescriptor = $convert.base64Decode('Ch5DaGVja1RhZ1BheUF2YWlsYWJpbGl0eVJlcXVlc3QSFwoHdGFnX3BheRgBIAEoCVIGdGFnUGF5');
@$core.Deprecated('Use checkTagPayAvailabilityResponseDescriptor instead')
const CheckTagPayAvailabilityResponse$json = const {
  '1': 'CheckTagPayAvailabilityResponse',
  '2': const [
    const {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'suggestions', '3': 3, '4': 3, '5': 9, '10': 'suggestions'},
  ],
};

/// Descriptor for `CheckTagPayAvailabilityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkTagPayAvailabilityResponseDescriptor = $convert.base64Decode('Ch9DaGVja1RhZ1BheUF2YWlsYWJpbGl0eVJlc3BvbnNlEhwKCWF2YWlsYWJsZRgBIAEoCFIJYXZhaWxhYmxlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIAoLc3VnZ2VzdGlvbnMYAyADKAlSC3N1Z2dlc3Rpb25z');
@$core.Deprecated('Use searchTagPayRequestDescriptor instead')
const SearchTagPayRequest$json = const {
  '1': 'SearchTagPayRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTagPayRequestDescriptor = $convert.base64Decode('ChNTZWFyY2hUYWdQYXlSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIUCgVsaW1pdBgCIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use searchTagPayResponseDescriptor instead')
const SearchTagPayResponse$json = const {
  '1': 'SearchTagPayResponse',
  '2': const [
    const {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.pb.TagPay', '10': 'results'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `SearchTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTagPayResponseDescriptor = $convert.base64Decode('ChRTZWFyY2hUYWdQYXlSZXNwb25zZRIkCgdyZXN1bHRzGAEgAygLMgoucGIuVGFnUGF5UgdyZXN1bHRzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');
@$core.Deprecated('Use sendMoneyTagPayRequestDescriptor instead')
const SendMoneyTagPayRequest$json = const {
  '1': 'SendMoneyTagPayRequest',
  '2': const [
    const {'1': 'receiver_tag_pay', '3': 1, '4': 1, '5': 9, '10': 'receiverTagPay'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'source_account_id', '3': 5, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'transaction_pin', '3': 6, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `SendMoneyTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMoneyTagPayRequestDescriptor = $convert.base64Decode('ChZTZW5kTW9uZXlUYWdQYXlSZXF1ZXN0EigKEHJlY2VpdmVyX3RhZ19wYXkYASABKAlSDnJlY2VpdmVyVGFnUGF5EhYKBmFtb3VudBgCIAEoAVIGYW1vdW50EhoKCGN1cnJlbmN5GAMgASgJUghjdXJyZW5jeRIgCgtkZXNjcmlwdGlvbhgEIAEoCVILZGVzY3JpcHRpb24SKgoRc291cmNlX2FjY291bnRfaWQYBSABKAlSD3NvdXJjZUFjY291bnRJZBInCg90cmFuc2FjdGlvbl9waW4YBiABKAlSDnRyYW5zYWN0aW9uUGlu');
@$core.Deprecated('Use sendMoneyTagPayResponseDescriptor instead')
const SendMoneyTagPayResponse$json = const {
  '1': 'SendMoneyTagPayResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPayTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `SendMoneyTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMoneyTagPayResponseDescriptor = $convert.base64Decode('ChdTZW5kTW9uZXlUYWdQYXlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNwoLdHJhbnNhY3Rpb24YAyABKAsyFS5wYi5UYWdQYXlUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24=');
@$core.Deprecated('Use requestMoneyTagPayRequestDescriptor instead')
const RequestMoneyTagPayRequest$json = const {
  '1': 'RequestMoneyTagPayRequest',
  '2': const [
    const {'1': 'requestee_tag_pay', '3': 1, '4': 1, '5': 9, '10': 'requesteeTagPay'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `RequestMoneyTagPayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestMoneyTagPayRequestDescriptor = $convert.base64Decode('ChlSZXF1ZXN0TW9uZXlUYWdQYXlSZXF1ZXN0EioKEXJlcXVlc3RlZV90YWdfcGF5GAEgASgJUg9yZXF1ZXN0ZWVUYWdQYXkSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbg==');
@$core.Deprecated('Use requestMoneyTagPayResponseDescriptor instead')
const RequestMoneyTagPayResponse$json = const {
  '1': 'RequestMoneyTagPayResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'money_request', '3': 3, '4': 1, '5': 11, '6': '.pb.MoneyRequest', '10': 'moneyRequest'},
  ],
};

/// Descriptor for `RequestMoneyTagPayResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestMoneyTagPayResponseDescriptor = $convert.base64Decode('ChpSZXF1ZXN0TW9uZXlUYWdQYXlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNQoNbW9uZXlfcmVxdWVzdBgDIAEoCzIQLnBiLk1vbmV5UmVxdWVzdFIMbW9uZXlSZXF1ZXN0');
@$core.Deprecated('Use getTagPayTransactionsRequestDescriptor instead')
const GetTagPayTransactionsRequest$json = const {
  '1': 'GetTagPayTransactionsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.pb.TagPayTransactionType', '10': 'type'},
  ],
};

/// Descriptor for `GetTagPayTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTagPayTransactionsRequestDescriptor = $convert.base64Decode('ChxHZXRUYWdQYXlUcmFuc2FjdGlvbnNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBWxpbWl0Ei0KBHR5cGUYAyABKA4yGS5wYi5UYWdQYXlUcmFuc2FjdGlvblR5cGVSBHR5cGU=');
@$core.Deprecated('Use getTagPayTransactionsResponseDescriptor instead')
const GetTagPayTransactionsResponse$json = const {
  '1': 'GetTagPayTransactionsResponse',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.pb.TagPayTransaction', '10': 'transactions'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetTagPayTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTagPayTransactionsResponseDescriptor = $convert.base64Decode('Ch1HZXRUYWdQYXlUcmFuc2FjdGlvbnNSZXNwb25zZRI5Cgx0cmFuc2FjdGlvbnMYASADKAsyFS5wYi5UYWdQYXlUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEhQKBXRvdGFsGAIgASgFUgV0b3RhbBISCgRwYWdlGAMgASgFUgRwYWdlEh8KC3RvdGFsX3BhZ2VzGAQgASgFUgp0b3RhbFBhZ2Vz');
@$core.Deprecated('Use acceptMoneyRequestRequestDescriptor instead')
const AcceptMoneyRequestRequest$json = const {
  '1': 'AcceptMoneyRequestRequest',
  '2': const [
    const {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `AcceptMoneyRequestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptMoneyRequestRequestDescriptor = $convert.base64Decode('ChlBY2NlcHRNb25leVJlcXVlc3RSZXF1ZXN0Eh0KCnJlcXVlc3RfaWQYASABKAlSCXJlcXVlc3RJZBIqChFzb3VyY2VfYWNjb3VudF9pZBgCIAEoCVIPc291cmNlQWNjb3VudElkEicKD3RyYW5zYWN0aW9uX3BpbhgDIAEoCVIOdHJhbnNhY3Rpb25QaW4=');
@$core.Deprecated('Use acceptMoneyRequestResponseDescriptor instead')
const AcceptMoneyRequestResponse$json = const {
  '1': 'AcceptMoneyRequestResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPayTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `AcceptMoneyRequestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptMoneyRequestResponseDescriptor = $convert.base64Decode('ChpBY2NlcHRNb25leVJlcXVlc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNwoLdHJhbnNhY3Rpb24YAyABKAsyFS5wYi5UYWdQYXlUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24=');
@$core.Deprecated('Use declineMoneyRequestRequestDescriptor instead')
const DeclineMoneyRequestRequest$json = const {
  '1': 'DeclineMoneyRequestRequest',
  '2': const [
    const {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `DeclineMoneyRequestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineMoneyRequestRequestDescriptor = $convert.base64Decode('ChpEZWNsaW5lTW9uZXlSZXF1ZXN0UmVxdWVzdBIdCgpyZXF1ZXN0X2lkGAEgASgJUglyZXF1ZXN0SWQSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');
@$core.Deprecated('Use declineMoneyRequestResponseDescriptor instead')
const DeclineMoneyRequestResponse$json = const {
  '1': 'DeclineMoneyRequestResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeclineMoneyRequestResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineMoneyRequestResponseDescriptor = $convert.base64Decode('ChtEZWNsaW5lTW9uZXlSZXF1ZXN0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getPendingMoneyRequestsRequestDescriptor instead')
const GetPendingMoneyRequestsRequest$json = const {
  '1': 'GetPendingMoneyRequestsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'incoming', '3': 3, '4': 1, '5': 8, '10': 'incoming'},
  ],
};

/// Descriptor for `GetPendingMoneyRequestsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingMoneyRequestsRequestDescriptor = $convert.base64Decode('Ch5HZXRQZW5kaW5nTW9uZXlSZXF1ZXN0c1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQSGgoIaW5jb21pbmcYAyABKAhSCGluY29taW5n');
@$core.Deprecated('Use getPendingMoneyRequestsResponseDescriptor instead')
const GetPendingMoneyRequestsResponse$json = const {
  '1': 'GetPendingMoneyRequestsResponse',
  '2': const [
    const {'1': 'requests', '3': 1, '4': 3, '5': 11, '6': '.pb.MoneyRequest', '10': 'requests'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetPendingMoneyRequestsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPendingMoneyRequestsResponseDescriptor = $convert.base64Decode('Ch9HZXRQZW5kaW5nTW9uZXlSZXF1ZXN0c1Jlc3BvbnNlEiwKCHJlcXVlc3RzGAEgAygLMhAucGIuTW9uZXlSZXF1ZXN0UghyZXF1ZXN0cxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIfCgt0b3RhbF9wYWdlcxgEIAEoBVIKdG90YWxQYWdlcw==');
@$core.Deprecated('Use createTagRequestDescriptor instead')
const CreateTagRequest$json = const {
  '1': 'CreateTagRequest',
  '2': const [
    const {'1': 'tagged_user_tag_pay', '3': 1, '4': 1, '5': 9, '10': 'taggedUserTagPay'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `CreateTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTagRequestDescriptor = $convert.base64Decode('ChBDcmVhdGVUYWdSZXF1ZXN0Ei0KE3RhZ2dlZF91c2VyX3RhZ19wYXkYASABKAlSEHRhZ2dlZFVzZXJUYWdQYXkSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYAyABKAlSCGN1cnJlbmN5EiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbg==');
@$core.Deprecated('Use createTagResponseDescriptor instead')
const CreateTagResponse$json = const {
  '1': 'CreateTagResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'tag', '3': 3, '4': 1, '5': 11, '6': '.pb.UserTag', '10': 'tag'},
  ],
};

/// Descriptor for `CreateTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTagResponseDescriptor = $convert.base64Decode('ChFDcmVhdGVUYWdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USHQoDdGFnGAMgASgLMgsucGIuVXNlclRhZ1IDdGFn');
@$core.Deprecated('Use getMyTagsRequestDescriptor instead')
const GetMyTagsRequest$json = const {
  '1': 'GetMyTagsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.TagStatus', '10': 'status'},
  ],
};

/// Descriptor for `GetMyTagsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyTagsRequestDescriptor = $convert.base64Decode('ChBHZXRNeVRhZ3NSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBWxpbWl0EiUKBnN0YXR1cxgDIAEoDjINLnBiLlRhZ1N0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use getMyTagsResponseDescriptor instead')
const GetMyTagsResponse$json = const {
  '1': 'GetMyTagsResponse',
  '2': const [
    const {'1': 'tags', '3': 1, '4': 3, '5': 11, '6': '.pb.UserTag', '10': 'tags'},
    const {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
    const {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
  ],
};

/// Descriptor for `GetMyTagsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMyTagsResponseDescriptor = $convert.base64Decode('ChFHZXRNeVRhZ3NSZXNwb25zZRIfCgR0YWdzGAEgAygLMgsucGIuVXNlclRhZ1IEdGFncxIUCgV0b3RhbBgCIAEoBVIFdG90YWwSEgoEcGFnZRgDIAEoBVIEcGFnZRIfCgt0b3RhbF9wYWdlcxgEIAEoBVIKdG90YWxQYWdlcw==');
@$core.Deprecated('Use payTagRequestDescriptor instead')
const PayTagRequest$json = const {
  '1': 'PayTagRequest',
  '2': const [
    const {'1': 'tag_id', '3': 1, '4': 1, '5': 9, '10': 'tagId'},
    const {'1': 'source_account_id', '3': 2, '4': 1, '5': 9, '10': 'sourceAccountId'},
    const {'1': 'transaction_pin', '3': 3, '4': 1, '5': 9, '10': 'transactionPin'},
  ],
};

/// Descriptor for `PayTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payTagRequestDescriptor = $convert.base64Decode('Cg1QYXlUYWdSZXF1ZXN0EhUKBnRhZ19pZBgBIAEoCVIFdGFnSWQSKgoRc291cmNlX2FjY291bnRfaWQYAiABKAlSD3NvdXJjZUFjY291bnRJZBInCg90cmFuc2FjdGlvbl9waW4YAyABKAlSDnRyYW5zYWN0aW9uUGlu');
@$core.Deprecated('Use payTagResponseDescriptor instead')
const PayTagResponse$json = const {
  '1': 'PayTagResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.pb.TagPayTransaction', '10': 'transaction'},
  ],
};

/// Descriptor for `PayTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payTagResponseDescriptor = $convert.base64Decode('Cg5QYXlUYWdSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNwoLdHJhbnNhY3Rpb24YAyABKAsyFS5wYi5UYWdQYXlUcmFuc2FjdGlvblILdHJhbnNhY3Rpb24=');
@$core.Deprecated('Use searchUsersForTagRequestDescriptor instead')
const SearchUsersForTagRequest$json = const {
  '1': 'SearchUsersForTagRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchUsersForTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersForTagRequestDescriptor = $convert.base64Decode('ChhTZWFyY2hVc2Vyc0ZvclRhZ1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EhQKBWxpbWl0GAIgASgFUgVsaW1pdA==');
@$core.Deprecated('Use userSearchResultDescriptor instead')
const UserSearchResult$json = const {
  '1': 'UserSearchResult',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'profile_picture', '3': 6, '4': 1, '5': 9, '10': 'profilePicture'},
  ],
};

/// Descriptor for `UserSearchResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSearchResultDescriptor = $convert.base64Decode('ChBVc2VyU2VhcmNoUmVzdWx0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSHQoKZmlyc3RfbmFtZRgDIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgEIAEoCVIIbGFzdE5hbWUSFAoFZW1haWwYBSABKAlSBWVtYWlsEicKD3Byb2ZpbGVfcGljdHVyZRgGIAEoCVIOcHJvZmlsZVBpY3R1cmU=');
@$core.Deprecated('Use searchUsersForTagResponseDescriptor instead')
const SearchUsersForTagResponse$json = const {
  '1': 'SearchUsersForTagResponse',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.pb.UserSearchResult', '10': 'users'},
  ],
};

/// Descriptor for `SearchUsersForTagResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersForTagResponseDescriptor = $convert.base64Decode('ChlTZWFyY2hVc2Vyc0ZvclRhZ1Jlc3BvbnNlEioKBXVzZXJzGAEgAygLMhQucGIuVXNlclNlYXJjaFJlc3VsdFIFdXNlcnM=');
@$core.Deprecated('Use batchCreateTagsRequestDescriptor instead')
const BatchCreateTagsRequest$json = const {
  '1': 'BatchCreateTagsRequest',
  '2': const [
    const {'1': 'tagged_user_tag_pays', '3': 1, '4': 3, '5': 9, '10': 'taggedUserTagPays'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    const {'1': 'currency', '3': 3, '4': 1, '5': 9, '10': 'currency'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `BatchCreateTagsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateTagsRequestDescriptor = $convert.base64Decode('ChZCYXRjaENyZWF0ZVRhZ3NSZXF1ZXN0Ei8KFHRhZ2dlZF91c2VyX3RhZ19wYXlzGAEgAygJUhF0YWdnZWRVc2VyVGFnUGF5cxIWCgZhbW91bnQYAiABKAFSBmFtb3VudBIaCghjdXJyZW5jeRgDIAEoCVIIY3VycmVuY3kSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use batchCreateTagsResponseDescriptor instead')
const BatchCreateTagsResponse$json = const {
  '1': 'BatchCreateTagsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'tags', '3': 3, '4': 3, '5': 11, '6': '.pb.UserTag', '10': 'tags'},
    const {'1': 'failed_users', '3': 4, '4': 3, '5': 9, '10': 'failedUsers'},
  ],
};

/// Descriptor for `BatchCreateTagsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchCreateTagsResponseDescriptor = $convert.base64Decode('ChdCYXRjaENyZWF0ZVRhZ3NSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USHwoEdGFncxgDIAMoCzILLnBiLlVzZXJUYWdSBHRhZ3MSIQoMZmFpbGVkX3VzZXJzGAQgAygJUgtmYWlsZWRVc2Vycw==');
